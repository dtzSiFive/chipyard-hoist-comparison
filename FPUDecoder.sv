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

module FPUDecoder(
  input  [31:0] io_inst,
  output        io_sigs_wen,
                io_sigs_ren1,
                io_sigs_ren2,
                io_sigs_ren3,
                io_sigs_swap12,
                io_sigs_swap23,
  output [1:0]  io_sigs_typeTagIn,
                io_sigs_typeTagOut,
  output        io_sigs_fromint,
                io_sigs_toint,
                io_sigs_fastpipe,
                io_sigs_fma,
                io_sigs_div,
                io_sigs_sqrt,
                io_sigs_wflags
);

  wire       decoder_4 = {io_inst[6], io_inst[4]} == 2'h2;	// Decode.scala:14:{65,121}
  wire [2:0] _GEN = {io_inst[29:28], io_inst[4]};	// Decode.scala:14:65
  wire [2:0] _GEN_0 = {io_inst[31], io_inst[28], io_inst[4]};	// Decode.scala:14:65
  wire [3:0] _GEN_1 = {io_inst[31:30], io_inst[28], io_inst[4]};	// Decode.scala:14:65
  assign io_sigs_wen =
    {io_inst[31], io_inst[5]} == 2'h0 | io_inst[5:4] == 2'h0
    | {io_inst[28], io_inst[5]} == 2'h2;	// Decode.scala:14:{65,121}, :15:30
  assign io_sigs_ren1 =
    {io_inst[31], io_inst[2]} == 2'h0 | {io_inst[28], io_inst[2]} == 2'h0 | decoder_4;	// Decode.scala:14:{65,121}, :15:30
  assign io_sigs_ren2 = {io_inst[30], io_inst[2]} == 2'h0 | io_inst[5] | decoder_4;	// Decode.scala:14:{65,121}, :15:30
  assign io_sigs_ren3 = decoder_4;	// Decode.scala:14:121
  assign io_sigs_swap12 = ~(io_inst[6]);	// Decode.scala:14:{65,121}
  assign io_sigs_swap23 = _GEN == 3'h1;	// Decode.scala:14:{65,121}
  assign io_sigs_typeTagIn =
    {1'h0,
     ~(io_inst[6]) | {io_inst[30], io_inst[25]} == 2'h1
       | {io_inst[25], io_inst[4]} == 2'h2 | (&{io_inst[28], io_inst[25]})
       | {io_inst[31:30], io_inst[28], io_inst[25], io_inst[4]} == 5'h9
       | {io_inst[30:28], io_inst[12], io_inst[4]} == 5'h19
       | (&{io_inst[31], io_inst[25]})};	// Decode.scala:14:{65,121}, :15:30, FPU.scala:174:40
  assign io_sigs_typeTagOut =
    {1'h0,
     {io_inst[12], io_inst[6]} == 2'h2 | {io_inst[25], io_inst[5]} == 2'h2 | (&_GEN)};	// Decode.scala:14:{65,121}, :15:30, FPU.scala:174:40
  assign io_sigs_fromint = &_GEN_0;	// Decode.scala:14:{65,121}
  assign io_sigs_toint = io_inst[5] | _GEN_0 == 3'h5;	// Decode.scala:14:{65,121}, :15:30
  assign io_sigs_fastpipe =
    {io_inst[31], io_inst[29], io_inst[4]} == 3'h3 | _GEN_1 == 4'h5;	// Decode.scala:14:{65,121}, :15:30
  assign io_sigs_fma =
    {io_inst[30:28], io_inst[2]} == 4'h0
    | {io_inst[30:29], io_inst[27], io_inst[2]} == 4'h0 | decoder_4;	// Decode.scala:14:{65,121}, :15:30
  assign io_sigs_div = {io_inst[30], io_inst[28:27], io_inst[4]} == 4'h7;	// Decode.scala:14:{65,121}
  assign io_sigs_sqrt = _GEN_1 == 4'h7;	// Decode.scala:14:{65,121}
  assign io_sigs_wflags =
    {io_inst[29], io_inst[2]} == 2'h0 | decoder_4 | {io_inst[27], io_inst[13]} == 2'h2
    | {io_inst[31:30], io_inst[2]} == 3'h4;	// Decode.scala:14:{65,121}, :15:30
endmodule

