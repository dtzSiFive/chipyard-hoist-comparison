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

module DivSqrtRecF64(
  input         clock,
                reset,
                io_inValid,
                io_sqrtOp,
  input  [64:0] io_a,
                io_b,
  input  [2:0]  io_roundingMode,
  output        io_inReady_div,
                io_inReady_sqrt,
                io_outValid_div,
                io_outValid_sqrt,
  output [64:0] io_out,
  output [4:0]  io_exceptionFlags
);

  wire [104:0] _mul_io_result_s3;	// DivSqrtRecF64.scala:75:21
  wire [3:0]   _ds_io_usingMulAdd;	// DivSqrtRecF64.scala:60:20
  wire         _ds_io_latchMulAddA_0;	// DivSqrtRecF64.scala:60:20
  wire [53:0]  _ds_io_mulAddA_0;	// DivSqrtRecF64.scala:60:20
  wire         _ds_io_latchMulAddB_0;	// DivSqrtRecF64.scala:60:20
  wire [53:0]  _ds_io_mulAddB_0;	// DivSqrtRecF64.scala:60:20
  wire [104:0] _ds_io_mulAddC_2;	// DivSqrtRecF64.scala:60:20
  DivSqrtRecF64_mulAddZ31 ds (	// DivSqrtRecF64.scala:60:20
    .clock             (clock),
    .reset             (reset),
    .io_inValid        (io_inValid),
    .io_sqrtOp         (io_sqrtOp),
    .io_a              (io_a),
    .io_b              (io_b),
    .io_roundingMode   (io_roundingMode),
    .io_mulAddResult_3 (_mul_io_result_s3),	// DivSqrtRecF64.scala:75:21
    .io_inReady_div    (io_inReady_div),
    .io_inReady_sqrt   (io_inReady_sqrt),
    .io_usingMulAdd    (_ds_io_usingMulAdd),
    .io_latchMulAddA_0 (_ds_io_latchMulAddA_0),
    .io_mulAddA_0      (_ds_io_mulAddA_0),
    .io_latchMulAddB_0 (_ds_io_latchMulAddB_0),
    .io_mulAddB_0      (_ds_io_mulAddB_0),
    .io_mulAddC_2      (_ds_io_mulAddC_2),
    .io_outValid_div   (io_outValid_div),
    .io_outValid_sqrt  (io_outValid_sqrt),
    .io_out            (io_out),
    .io_exceptionFlags (io_exceptionFlags)
  );
  Mul54 mul (	// DivSqrtRecF64.scala:75:21
    .clock         (clock),
    .io_val_s0     (_ds_io_usingMulAdd[0]),	// DivSqrtRecF64.scala:60:20, :77:43
    .io_latch_a_s0 (_ds_io_latchMulAddA_0),	// DivSqrtRecF64.scala:60:20
    .io_a_s0       (_ds_io_mulAddA_0),	// DivSqrtRecF64.scala:60:20
    .io_latch_b_s0 (_ds_io_latchMulAddB_0),	// DivSqrtRecF64.scala:60:20
    .io_b_s0       (_ds_io_mulAddB_0),	// DivSqrtRecF64.scala:60:20
    .io_c_s2       (_ds_io_mulAddC_2),	// DivSqrtRecF64.scala:60:20
    .io_result_s3  (_mul_io_result_s3)
  );
endmodule

