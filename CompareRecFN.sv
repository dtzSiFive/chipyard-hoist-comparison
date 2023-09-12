// 
// Standard header to adapt well known macros to our needs.
`ifndef RANDOMIZE
  `ifdef RANDOMIZE_REG_INIT
    `define RANDOMIZE
  `endif // RANDOMIZE_REG_INIT
`endif // not def RANDOMIZE
`ifndef RANDOMIZE
  `ifdef RANDOMIZE_MEM_INIT
    `define RANDOMIZE
  `endif // RANDOMIZE_MEM_INIT
`endif // not def RANDOMIZE

// RANDOM may be set to an expression that produces a 32-bit random unsigned value.
`ifndef RANDOM
  `define RANDOM $random
`endif // not def RANDOM

// Users can define 'PRINTF_COND' to add an extra gate to prints.
`ifndef PRINTF_COND_
  `ifdef PRINTF_COND
    `define PRINTF_COND_ (`PRINTF_COND)
  `else  // PRINTF_COND
    `define PRINTF_COND_ 1
  `endif // PRINTF_COND
`endif // not def PRINTF_COND_

// Users can define 'ASSERT_VERBOSE_COND' to add an extra gate to assert error printing.
`ifndef ASSERT_VERBOSE_COND_
  `ifdef ASSERT_VERBOSE_COND
    `define ASSERT_VERBOSE_COND_ (`ASSERT_VERBOSE_COND)
  `else  // ASSERT_VERBOSE_COND
    `define ASSERT_VERBOSE_COND_ 1
  `endif // ASSERT_VERBOSE_COND
`endif // not def ASSERT_VERBOSE_COND_

// Users can define 'STOP_COND' to add an extra gate to stop conditions.
`ifndef STOP_COND_
  `ifdef STOP_COND
    `define STOP_COND_ (`STOP_COND)
  `else  // STOP_COND
    `define STOP_COND_ 1
  `endif // STOP_COND
`endif // not def STOP_COND_

// Users can define INIT_RANDOM as general code that gets injected into the
// initializer block for modules with registers.
`ifndef INIT_RANDOM
  `define INIT_RANDOM
`endif // not def INIT_RANDOM

// If using random initialization, you can also define RANDOMIZE_DELAY to
// customize the delay used, otherwise 0.002 is used.
`ifndef RANDOMIZE_DELAY
  `define RANDOMIZE_DELAY 0.002
`endif // not def RANDOMIZE_DELAY

// Define INIT_RANDOM_PROLOG_ for use in our modules below.
`ifndef INIT_RANDOM_PROLOG_
  `ifdef RANDOMIZE
    `ifdef VERILATOR
      `define INIT_RANDOM_PROLOG_ `INIT_RANDOM
    `else  // VERILATOR
      `define INIT_RANDOM_PROLOG_ `INIT_RANDOM #`RANDOMIZE_DELAY begin end
    `endif // VERILATOR
  `else  // RANDOMIZE
    `define INIT_RANDOM_PROLOG_
  `endif // RANDOMIZE
`endif // not def INIT_RANDOM_PROLOG_

// Include register initializers in init blocks unless synthesis is set
`ifndef SYNTHESIS
  `ifndef ENABLE_INITIAL_REG_
    `define ENABLE_INITIAL_REG_
  `endif // not def ENABLE_INITIAL_REG_
`endif // not def SYNTHESIS

// Include rmemory initializers in init blocks unless synthesis is set
`ifndef SYNTHESIS
  `ifndef ENABLE_INITIAL_MEM_
    `define ENABLE_INITIAL_MEM_
  `endif // not def ENABLE_INITIAL_MEM_
`endif // not def SYNTHESIS

module CompareRecFN(
  input  [64:0] io_a,
                io_b,
  input         io_signaling,
  output        io_lt,
                io_eq,
  output [4:0]  io_exceptionFlags
);

  wire        rawA_isNaN = (&(io_a[63:62])) & io_a[61];	// rawFloatFromRecFN.scala:50:21, :52:{29,54}, :55:{33,41}
  wire        rawB_isNaN = (&(io_b[63:62])) & io_b[61];	// rawFloatFromRecFN.scala:50:21, :52:{29,54}, :55:{33,41}
  wire        ordered = ~rawA_isNaN & ~rawB_isNaN;	// CompareRecFN.scala:57:{19,32,35}, rawFloatFromRecFN.scala:55:33
  wire        bothInfs = (&(io_a[63:62])) & ~(io_a[61]) & (&(io_b[63:62])) & ~(io_b[61]);	// CompareRecFN.scala:58:33, rawFloatFromRecFN.scala:50:21, :52:{29,54}, :55:41, :56:36
  wire        bothZeros = ~(|(io_a[63:61])) & ~(|(io_b[63:61]));	// CompareRecFN.scala:59:33, rawFloatFromRecFN.scala:50:21, :51:{29,54}
  wire        eqExps = io_a[63:52] == io_b[63:52];	// CompareRecFN.scala:60:29, rawFloatFromRecFN.scala:50:21
  wire [52:0] _GEN = {|(io_a[63:61]), io_a[51:0]};	// Cat.scala:30:58, rawFloatFromRecFN.scala:50:21, :51:{29,54}, :60:51
  wire [52:0] _GEN_0 = {|(io_b[63:61]), io_b[51:0]};	// Cat.scala:30:58, rawFloatFromRecFN.scala:50:21, :51:{29,54}, :60:51
  wire        common_ltMags =
    $signed({1'h0, io_a[63:52]}) < $signed({1'h0, io_b[63:52]}) | eqExps & _GEN < _GEN_0;	// Cat.scala:30:58, CompareRecFN.scala:60:29, :62:{20,33,44,57}, rawFloatFromRecFN.scala:50:21, :51:54, :59:27
  wire        common_eqMags = eqExps & _GEN == _GEN_0;	// Cat.scala:30:58, CompareRecFN.scala:60:29, :63:{32,45}
  assign io_lt =
    ordered & ~bothZeros
    & (io_a[64] & ~(io_b[64]) | ~bothInfs
       & (io_a[64] & ~common_ltMags & ~common_eqMags | ~(io_b[64]) & common_ltMags));	// CompareRecFN.scala:57:32, :58:33, :59:33, :62:33, :63:32, :66:9, :67:{25,28,41}, :68:{19,30}, :69:{38,54,57,74}, :70:41, :78:22, rawFloatFromRecFN.scala:58:25
  assign io_eq =
    ordered & (bothZeros | io_a[64] == io_b[64] & (bothInfs | common_eqMags));	// CompareRecFN.scala:57:32, :58:33, :59:33, :63:32, :72:{19,34,49,62}, :79:22, rawFloatFromRecFN.scala:58:25
  assign io_exceptionFlags =
    {rawA_isNaN & ~(io_a[51]) | rawB_isNaN & ~(io_b[51]) | io_signaling & ~ordered, 4'h0};	// Cat.scala:30:58, CompareRecFN.scala:57:32, :75:58, :76:{27,30}, common.scala:81:{46,49,56}, rawFloatFromRecFN.scala:55:33
endmodule

