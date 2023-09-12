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

module Mul54(
  input          clock,
                 io_val_s0,
                 io_latch_a_s0,
  input  [53:0]  io_a_s0,
  input          io_latch_b_s0,
  input  [53:0]  io_b_s0,
  input  [104:0] io_c_s2,
  output [104:0] io_result_s3
);

  reg         val_s1;	// DivSqrtRecF64.scala:98:21
  reg         val_s2;	// DivSqrtRecF64.scala:99:21
  reg [53:0]  reg_a_s1;	// DivSqrtRecF64.scala:100:23
  reg [53:0]  reg_b_s1;	// DivSqrtRecF64.scala:101:23
  reg [53:0]  reg_a_s2;	// DivSqrtRecF64.scala:102:23
  reg [53:0]  reg_b_s2;	// DivSqrtRecF64.scala:103:23
  reg [104:0] reg_result_s3;	// DivSqrtRecF64.scala:104:28
  always @(posedge clock) begin
    val_s1 <= io_val_s0;	// DivSqrtRecF64.scala:98:21
    val_s2 <= val_s1;	// DivSqrtRecF64.scala:98:21, :99:21
    if (io_val_s0 & io_latch_a_s0)	// DivSqrtRecF64.scala:100:23, :109:22, :110:30, :111:22
      reg_a_s1 <= io_a_s0;	// DivSqrtRecF64.scala:100:23
    if (io_val_s0 & io_latch_b_s0)	// DivSqrtRecF64.scala:101:23, :109:22, :113:30, :114:22
      reg_b_s1 <= io_b_s0;	// DivSqrtRecF64.scala:101:23
    if (val_s1) begin	// DivSqrtRecF64.scala:98:21
      reg_a_s2 <= reg_a_s1;	// DivSqrtRecF64.scala:100:23, :102:23
      reg_b_s2 <= reg_b_s1;	// DivSqrtRecF64.scala:101:23, :103:23
    end
    if (val_s2)	// DivSqrtRecF64.scala:99:21
      reg_result_s3 <= {51'h0, reg_a_s2} * {51'h0, reg_b_s2} + io_c_s2;	// DivSqrtRecF64.scala:102:23, :103:23, :104:28, :124:{36,55}
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:10];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [3:0] i = 4'h0; i < 4'hB; i += 4'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        val_s1 = _RANDOM[4'h0][0];	// DivSqrtRecF64.scala:98:21
        val_s2 = _RANDOM[4'h0][1];	// DivSqrtRecF64.scala:98:21, :99:21
        reg_a_s1 = {_RANDOM[4'h0][31:2], _RANDOM[4'h1][23:0]};	// DivSqrtRecF64.scala:98:21, :100:23
        reg_b_s1 = {_RANDOM[4'h1][31:24], _RANDOM[4'h2], _RANDOM[4'h3][13:0]};	// DivSqrtRecF64.scala:100:23, :101:23
        reg_a_s2 = {_RANDOM[4'h3][31:14], _RANDOM[4'h4], _RANDOM[4'h5][3:0]};	// DivSqrtRecF64.scala:101:23, :102:23
        reg_b_s2 = {_RANDOM[4'h5][31:4], _RANDOM[4'h6][25:0]};	// DivSqrtRecF64.scala:102:23, :103:23
        reg_result_s3 =
          {_RANDOM[4'h6][31:26],
           _RANDOM[4'h7],
           _RANDOM[4'h8],
           _RANDOM[4'h9],
           _RANDOM[4'hA][2:0]};	// DivSqrtRecF64.scala:103:23, :104:28
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_result_s3 = reg_result_s3;	// DivSqrtRecF64.scala:104:28
endmodule

