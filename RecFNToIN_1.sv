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

module RecFNToIN_1(
  input  [64:0] io_in,
  input  [2:0]  io_roundingMode,
  input         io_signedOut,
  output [2:0]  io_intExceptionFlags
);

  wire        magJustBelowOne = ~(io_in[63]) & (&(io_in[62:52]));	// RecFNToIN.scala:58:30, :59:28, :60:{27,37,47}
  wire [83:0] shiftedSig =
    {31'h0, io_in[63], io_in[51:0]} << (io_in[63] ? io_in[56:52] : 5'h0);	// RecFNToIN.scala:58:30, :80:50, :81:16, :82:27, rawFloatFromRecFN.scala:60:51
  wire [1:0]  _roundIncr_near_even_T_6 = {shiftedSig[51], |(shiftedSig[50:0])};	// RecFNToIN.scala:80:50, :86:{51,69}, :89:50
  wire        common_inexact =
    io_in[63] ? (|_roundIncr_near_even_T_6) : (|(io_in[63:61]));	// RecFNToIN.scala:58:30, :89:{29,50,57}, rawFloatFromRecFN.scala:50:21, :51:{29,54}
  wire        roundIncr =
    io_roundingMode == 3'h0
    & (io_in[63] & ((&(shiftedSig[52:51])) | (&_roundIncr_near_even_T_6))
       | magJustBelowOne & (|_roundIncr_near_even_T_6)) | io_roundingMode == 3'h4
    & (io_in[63] & shiftedSig[51] | magJustBelowOne)
    | (io_roundingMode == 3'h2 | io_roundingMode == 3'h6) & io_in[64] & common_inexact
    | io_roundingMode == 3'h3 & ~(io_in[64]) & common_inexact;	// RecFNToIN.scala:58:30, :60:37, :64:53, :66:53, :67:53, :68:53, :69:53, :80:50, :89:{29,50}, :91:{25,39,46,51,71,78}, :92:{26,46}, :93:{43,56,61}, :95:35, :96:35, :97:{28,49}, :98:46, :99:{27,31}, rawFloatFromRecFN.scala:51:54, :58:25
  wire        magGeOne_atOverflowEdge = io_in[62:52] == 11'h1F;	// RecFNToIN.scala:59:28, :107:43
  wire        roundCarryBut2 = (&(shiftedSig[81:52])) & roundIncr;	// RecFNToIN.scala:80:50, :87:54, :98:46, :110:{38,56,61}
  wire        common_overflow =
    io_in[63]
      ? (|(io_in[62:57]))
        | (io_signedOut
             ? (io_in[64]
                  ? magGeOne_atOverflowEdge & ((|(shiftedSig[82:52])) | roundIncr)
                  : magGeOne_atOverflowEdge | io_in[62:52] == 11'h1E & roundCarryBut2)
             : io_in[64] | magGeOne_atOverflowEdge & shiftedSig[82] & roundCarryBut2)
      : ~io_signedOut & io_in[64] & roundIncr;	// RecFNToIN.scala:58:30, :59:28, :80:50, :87:54, :98:46, :107:43, :110:61, :112:12, :113:{21,40}, :114:20, :115:24, :116:49, :117:{42,60,64}, :118:49, :119:{38,62}, :121:32, :123:{42,57}, :125:{13,41}, rawFloatFromRecFN.scala:58:25
  wire        invalidExc =
    (&(io_in[63:62])) & io_in[61] | (&(io_in[63:62])) & ~(io_in[61]);	// RecFNToIN.scala:130:34, rawFloatFromRecFN.scala:50:21, :52:{29,54}, :55:{33,41}, :56:{33,36}
  assign io_intExceptionFlags =
    {invalidExc,
     ~invalidExc & common_overflow,
     ~invalidExc & ~common_overflow & common_inexact};	// Cat.scala:30:58, RecFNToIN.scala:89:29, :112:12, :130:34, :131:{20,32}, :132:{35,52}
endmodule

