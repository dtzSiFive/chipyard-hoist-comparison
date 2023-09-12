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

module MaxPeriodFibonacciLFSR_1(
  input  clock,
         reset,
         io_increment,
  output io_out_0,
         io_out_1,
         io_out_2,
         io_out_3,
         io_out_4,
         io_out_5,
         io_out_6,
         io_out_7,
         io_out_8,
         io_out_9,
         io_out_10,
         io_out_11,
         io_out_12,
         io_out_13,
         io_out_14,
         io_out_15
);

  reg state_0;	// PRNG.scala:47:50
  reg state_1;	// PRNG.scala:47:50
  reg state_2;	// PRNG.scala:47:50
  reg state_3;	// PRNG.scala:47:50
  reg state_4;	// PRNG.scala:47:50
  reg state_5;	// PRNG.scala:47:50
  reg state_6;	// PRNG.scala:47:50
  reg state_7;	// PRNG.scala:47:50
  reg state_8;	// PRNG.scala:47:50
  reg state_9;	// PRNG.scala:47:50
  reg state_10;	// PRNG.scala:47:50
  reg state_11;	// PRNG.scala:47:50
  reg state_12;	// PRNG.scala:47:50
  reg state_13;	// PRNG.scala:47:50
  reg state_14;	// PRNG.scala:47:50
  reg state_15;	// PRNG.scala:47:50
  always @(posedge clock) begin
    if (reset) begin
      state_0 <= 1'h1;	// PRNG.scala:47:50
      state_1 <= 1'h0;	// PRNG.scala:47:50
      state_2 <= 1'h0;	// PRNG.scala:47:50
      state_3 <= 1'h0;	// PRNG.scala:47:50
      state_4 <= 1'h0;	// PRNG.scala:47:50
      state_5 <= 1'h0;	// PRNG.scala:47:50
      state_6 <= 1'h0;	// PRNG.scala:47:50
      state_7 <= 1'h0;	// PRNG.scala:47:50
      state_8 <= 1'h0;	// PRNG.scala:47:50
      state_9 <= 1'h0;	// PRNG.scala:47:50
      state_10 <= 1'h0;	// PRNG.scala:47:50
      state_11 <= 1'h0;	// PRNG.scala:47:50
      state_12 <= 1'h0;	// PRNG.scala:47:50
      state_13 <= 1'h0;	// PRNG.scala:47:50
      state_14 <= 1'h0;	// PRNG.scala:47:50
      state_15 <= 1'h0;	// PRNG.scala:47:50
    end
    else if (io_increment) begin
      state_0 <= state_15 ^ state_13 ^ state_12 ^ state_10;	// LFSR.scala:15:41, PRNG.scala:47:50
      state_1 <= state_0;	// PRNG.scala:47:50
      state_2 <= state_1;	// PRNG.scala:47:50
      state_3 <= state_2;	// PRNG.scala:47:50
      state_4 <= state_3;	// PRNG.scala:47:50
      state_5 <= state_4;	// PRNG.scala:47:50
      state_6 <= state_5;	// PRNG.scala:47:50
      state_7 <= state_6;	// PRNG.scala:47:50
      state_8 <= state_7;	// PRNG.scala:47:50
      state_9 <= state_8;	// PRNG.scala:47:50
      state_10 <= state_9;	// PRNG.scala:47:50
      state_11 <= state_10;	// PRNG.scala:47:50
      state_12 <= state_11;	// PRNG.scala:47:50
      state_13 <= state_12;	// PRNG.scala:47:50
      state_14 <= state_13;	// PRNG.scala:47:50
      state_15 <= state_14;	// PRNG.scala:47:50
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:0];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        _RANDOM[/*Zero width*/ 1'b0] = `RANDOM;
        state_0 = _RANDOM[/*Zero width*/ 1'b0][0];	// PRNG.scala:47:50
        state_1 = _RANDOM[/*Zero width*/ 1'b0][1];	// PRNG.scala:47:50
        state_2 = _RANDOM[/*Zero width*/ 1'b0][2];	// PRNG.scala:47:50
        state_3 = _RANDOM[/*Zero width*/ 1'b0][3];	// PRNG.scala:47:50
        state_4 = _RANDOM[/*Zero width*/ 1'b0][4];	// PRNG.scala:47:50
        state_5 = _RANDOM[/*Zero width*/ 1'b0][5];	// PRNG.scala:47:50
        state_6 = _RANDOM[/*Zero width*/ 1'b0][6];	// PRNG.scala:47:50
        state_7 = _RANDOM[/*Zero width*/ 1'b0][7];	// PRNG.scala:47:50
        state_8 = _RANDOM[/*Zero width*/ 1'b0][8];	// PRNG.scala:47:50
        state_9 = _RANDOM[/*Zero width*/ 1'b0][9];	// PRNG.scala:47:50
        state_10 = _RANDOM[/*Zero width*/ 1'b0][10];	// PRNG.scala:47:50
        state_11 = _RANDOM[/*Zero width*/ 1'b0][11];	// PRNG.scala:47:50
        state_12 = _RANDOM[/*Zero width*/ 1'b0][12];	// PRNG.scala:47:50
        state_13 = _RANDOM[/*Zero width*/ 1'b0][13];	// PRNG.scala:47:50
        state_14 = _RANDOM[/*Zero width*/ 1'b0][14];	// PRNG.scala:47:50
        state_15 = _RANDOM[/*Zero width*/ 1'b0][15];	// PRNG.scala:47:50
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_out_0 = state_0;	// PRNG.scala:47:50
  assign io_out_1 = state_1;	// PRNG.scala:47:50
  assign io_out_2 = state_2;	// PRNG.scala:47:50
  assign io_out_3 = state_3;	// PRNG.scala:47:50
  assign io_out_4 = state_4;	// PRNG.scala:47:50
  assign io_out_5 = state_5;	// PRNG.scala:47:50
  assign io_out_6 = state_6;	// PRNG.scala:47:50
  assign io_out_7 = state_7;	// PRNG.scala:47:50
  assign io_out_8 = state_8;	// PRNG.scala:47:50
  assign io_out_9 = state_9;	// PRNG.scala:47:50
  assign io_out_10 = state_10;	// PRNG.scala:47:50
  assign io_out_11 = state_11;	// PRNG.scala:47:50
  assign io_out_12 = state_12;	// PRNG.scala:47:50
  assign io_out_13 = state_13;	// PRNG.scala:47:50
  assign io_out_14 = state_14;	// PRNG.scala:47:50
  assign io_out_15 = state_15;	// PRNG.scala:47:50
endmodule

