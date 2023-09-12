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

module DivSqrtRecFNToRaw_small(
  input         clock,
                reset,
                io_inValid,
                io_sqrtOp,
  input  [32:0] io_a,
                io_b,
  input  [2:0]  io_roundingMode,
  output        io_inReady,
                io_rawOutValid_div,
                io_rawOutValid_sqrt,
  output [2:0]  io_roundingModeOut,
  output        io_invalidExc,
                io_infiniteExc,
                io_rawOut_isNaN,
                io_rawOut_isInf,
                io_rawOut_isZero,
                io_rawOut_sign,
  output [9:0]  io_rawOut_sExp,
  output [26:0] io_rawOut_sig
);

  DivSqrtRawFN_small divSqrtRawFN (	// DivSqrtRecFN_small.scala:416:15
    .clock               (clock),
    .reset               (reset),
    .io_inValid          (io_inValid),
    .io_sqrtOp           (io_sqrtOp),
    .io_a_isNaN          ((&(io_a[31:30])) & io_a[29]),	// rawFloatFromRecFN.scala:50:21, :52:{29,54}, :55:{33,41}
    .io_a_isInf          ((&(io_a[31:30])) & ~(io_a[29])),	// rawFloatFromRecFN.scala:50:21, :52:{29,54}, :55:41, :56:{33,36}
    .io_a_isZero         (~(|(io_a[31:29]))),	// rawFloatFromRecFN.scala:50:21, :51:{29,54}
    .io_a_sign           (io_a[32]),	// rawFloatFromRecFN.scala:58:25
    .io_a_sExp           ({1'h0, io_a[31:23]}),	// rawFloatFromRecFN.scala:50:21, :51:54, :59:27
    .io_a_sig            ({1'h0, |(io_a[31:29]), io_a[22:0]}),	// Cat.scala:30:58, rawFloatFromRecFN.scala:50:21, :51:{29,54}, :60:51
    .io_b_isNaN          ((&(io_b[31:30])) & io_b[29]),	// rawFloatFromRecFN.scala:50:21, :52:{29,54}, :55:{33,41}
    .io_b_isInf          ((&(io_b[31:30])) & ~(io_b[29])),	// rawFloatFromRecFN.scala:50:21, :52:{29,54}, :55:41, :56:{33,36}
    .io_b_isZero         (~(|(io_b[31:29]))),	// rawFloatFromRecFN.scala:50:21, :51:{29,54}
    .io_b_sign           (io_b[32]),	// rawFloatFromRecFN.scala:58:25
    .io_b_sExp           ({1'h0, io_b[31:23]}),	// rawFloatFromRecFN.scala:50:21, :51:54, :59:27
    .io_b_sig            ({1'h0, |(io_b[31:29]), io_b[22:0]}),	// Cat.scala:30:58, rawFloatFromRecFN.scala:50:21, :51:{29,54}, :60:51
    .io_roundingMode     (io_roundingMode),
    .io_inReady          (io_inReady),
    .io_rawOutValid_div  (io_rawOutValid_div),
    .io_rawOutValid_sqrt (io_rawOutValid_sqrt),
    .io_roundingModeOut  (io_roundingModeOut),
    .io_invalidExc       (io_invalidExc),
    .io_infiniteExc      (io_infiniteExc),
    .io_rawOut_isNaN     (io_rawOut_isNaN),
    .io_rawOut_isInf     (io_rawOut_isInf),
    .io_rawOut_isZero    (io_rawOut_isZero),
    .io_rawOut_sign      (io_rawOut_sign),
    .io_rawOut_sExp      (io_rawOut_sExp),
    .io_rawOut_sig       (io_rawOut_sig)
  );
endmodule

