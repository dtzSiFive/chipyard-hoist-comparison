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

module BoomRAS(
  input         clock,
  input  [4:0]  io_read_idx,
  input         io_write_valid,
  input  [4:0]  io_write_idx,
  input  [39:0] io_write_addr,
  output [39:0] io_read_addr
);

  reg [39:0] ras_0;	// ras.scala:37:16
  reg [39:0] ras_1;	// ras.scala:37:16
  reg [39:0] ras_2;	// ras.scala:37:16
  reg [39:0] ras_3;	// ras.scala:37:16
  reg [39:0] ras_4;	// ras.scala:37:16
  reg [39:0] ras_5;	// ras.scala:37:16
  reg [39:0] ras_6;	// ras.scala:37:16
  reg [39:0] ras_7;	// ras.scala:37:16
  reg [39:0] ras_8;	// ras.scala:37:16
  reg [39:0] ras_9;	// ras.scala:37:16
  reg [39:0] ras_10;	// ras.scala:37:16
  reg [39:0] ras_11;	// ras.scala:37:16
  reg [39:0] ras_12;	// ras.scala:37:16
  reg [39:0] ras_13;	// ras.scala:37:16
  reg [39:0] ras_14;	// ras.scala:37:16
  reg [39:0] ras_15;	// ras.scala:37:16
  reg [39:0] ras_16;	// ras.scala:37:16
  reg [39:0] ras_17;	// ras.scala:37:16
  reg [39:0] ras_18;	// ras.scala:37:16
  reg [39:0] ras_19;	// ras.scala:37:16
  reg [39:0] ras_20;	// ras.scala:37:16
  reg [39:0] ras_21;	// ras.scala:37:16
  reg [39:0] ras_22;	// ras.scala:37:16
  reg [39:0] ras_23;	// ras.scala:37:16
  reg [39:0] ras_24;	// ras.scala:37:16
  reg [39:0] ras_25;	// ras.scala:37:16
  reg [39:0] ras_26;	// ras.scala:37:16
  reg [39:0] ras_27;	// ras.scala:37:16
  reg [39:0] ras_28;	// ras.scala:37:16
  reg [39:0] ras_29;	// ras.scala:37:16
  reg [39:0] ras_30;	// ras.scala:37:16
  reg [39:0] ras_31;	// ras.scala:37:16
  reg        io_read_addr_REG;	// ras.scala:39:30
  reg [39:0] io_read_addr_REG_1;	// ras.scala:40:12
  reg [39:0] io_read_addr_REG_2;	// ras.scala:41:12
  always @(posedge clock) begin
    automatic logic [31:0][39:0] _GEN;	// ras.scala:41:12
    if (io_write_valid & io_write_idx == 5'h0)	// ras.scala:37:16, :43:25, :44:23
      ras_0 <= io_write_addr;	// ras.scala:37:16
    if (io_write_valid & io_write_idx == 5'h1)	// ras.scala:37:16, :43:25, :44:23
      ras_1 <= io_write_addr;	// ras.scala:37:16
    if (io_write_valid & io_write_idx == 5'h2)	// ras.scala:37:16, :43:25, :44:23
      ras_2 <= io_write_addr;	// ras.scala:37:16
    if (io_write_valid & io_write_idx == 5'h3)	// ras.scala:37:16, :43:25, :44:23
      ras_3 <= io_write_addr;	// ras.scala:37:16
    if (io_write_valid & io_write_idx == 5'h4)	// ras.scala:37:16, :43:25, :44:23
      ras_4 <= io_write_addr;	// ras.scala:37:16
    if (io_write_valid & io_write_idx == 5'h5)	// ras.scala:37:16, :43:25, :44:23
      ras_5 <= io_write_addr;	// ras.scala:37:16
    if (io_write_valid & io_write_idx == 5'h6)	// ras.scala:37:16, :43:25, :44:23
      ras_6 <= io_write_addr;	// ras.scala:37:16
    if (io_write_valid & io_write_idx == 5'h7)	// ras.scala:37:16, :43:25, :44:23
      ras_7 <= io_write_addr;	// ras.scala:37:16
    if (io_write_valid & io_write_idx == 5'h8)	// ras.scala:37:16, :43:25, :44:23
      ras_8 <= io_write_addr;	// ras.scala:37:16
    if (io_write_valid & io_write_idx == 5'h9)	// ras.scala:37:16, :43:25, :44:23
      ras_9 <= io_write_addr;	// ras.scala:37:16
    if (io_write_valid & io_write_idx == 5'hA)	// ras.scala:37:16, :43:25, :44:23
      ras_10 <= io_write_addr;	// ras.scala:37:16
    if (io_write_valid & io_write_idx == 5'hB)	// ras.scala:37:16, :43:25, :44:23
      ras_11 <= io_write_addr;	// ras.scala:37:16
    if (io_write_valid & io_write_idx == 5'hC)	// ras.scala:37:16, :43:25, :44:23
      ras_12 <= io_write_addr;	// ras.scala:37:16
    if (io_write_valid & io_write_idx == 5'hD)	// ras.scala:37:16, :43:25, :44:23
      ras_13 <= io_write_addr;	// ras.scala:37:16
    if (io_write_valid & io_write_idx == 5'hE)	// ras.scala:37:16, :43:25, :44:23
      ras_14 <= io_write_addr;	// ras.scala:37:16
    if (io_write_valid & io_write_idx == 5'hF)	// ras.scala:37:16, :43:25, :44:23
      ras_15 <= io_write_addr;	// ras.scala:37:16
    if (io_write_valid & io_write_idx == 5'h10)	// ras.scala:37:16, :43:25, :44:23
      ras_16 <= io_write_addr;	// ras.scala:37:16
    if (io_write_valid & io_write_idx == 5'h11)	// ras.scala:37:16, :43:25, :44:23
      ras_17 <= io_write_addr;	// ras.scala:37:16
    if (io_write_valid & io_write_idx == 5'h12)	// ras.scala:37:16, :43:25, :44:23
      ras_18 <= io_write_addr;	// ras.scala:37:16
    if (io_write_valid & io_write_idx == 5'h13)	// ras.scala:37:16, :43:25, :44:23
      ras_19 <= io_write_addr;	// ras.scala:37:16
    if (io_write_valid & io_write_idx == 5'h14)	// ras.scala:37:16, :43:25, :44:23
      ras_20 <= io_write_addr;	// ras.scala:37:16
    if (io_write_valid & io_write_idx == 5'h15)	// ras.scala:37:16, :43:25, :44:23
      ras_21 <= io_write_addr;	// ras.scala:37:16
    if (io_write_valid & io_write_idx == 5'h16)	// ras.scala:37:16, :43:25, :44:23
      ras_22 <= io_write_addr;	// ras.scala:37:16
    if (io_write_valid & io_write_idx == 5'h17)	// ras.scala:37:16, :43:25, :44:23
      ras_23 <= io_write_addr;	// ras.scala:37:16
    if (io_write_valid & io_write_idx == 5'h18)	// ras.scala:37:16, :43:25, :44:23
      ras_24 <= io_write_addr;	// ras.scala:37:16
    if (io_write_valid & io_write_idx == 5'h19)	// ras.scala:37:16, :43:25, :44:23
      ras_25 <= io_write_addr;	// ras.scala:37:16
    if (io_write_valid & io_write_idx == 5'h1A)	// ras.scala:37:16, :43:25, :44:23
      ras_26 <= io_write_addr;	// ras.scala:37:16
    if (io_write_valid & io_write_idx == 5'h1B)	// ras.scala:37:16, :43:25, :44:23
      ras_27 <= io_write_addr;	// ras.scala:37:16
    if (io_write_valid & io_write_idx == 5'h1C)	// ras.scala:37:16, :43:25, :44:23
      ras_28 <= io_write_addr;	// ras.scala:37:16
    if (io_write_valid & io_write_idx == 5'h1D)	// ras.scala:37:16, :43:25, :44:23
      ras_29 <= io_write_addr;	// ras.scala:37:16
    if (io_write_valid & io_write_idx == 5'h1E)	// ras.scala:37:16, :43:25, :44:23
      ras_30 <= io_write_addr;	// ras.scala:37:16
    if (io_write_valid & (&io_write_idx))	// ras.scala:37:16, :43:25, :44:23
      ras_31 <= io_write_addr;	// ras.scala:37:16
    io_read_addr_REG <= io_write_valid & io_write_idx == io_read_idx;	// ras.scala:39:{30,46,62}
    io_read_addr_REG_1 <= io_write_addr;	// ras.scala:40:12
    _GEN =
      {{ras_31},
       {ras_30},
       {ras_29},
       {ras_28},
       {ras_27},
       {ras_26},
       {ras_25},
       {ras_24},
       {ras_23},
       {ras_22},
       {ras_21},
       {ras_20},
       {ras_19},
       {ras_18},
       {ras_17},
       {ras_16},
       {ras_15},
       {ras_14},
       {ras_13},
       {ras_12},
       {ras_11},
       {ras_10},
       {ras_9},
       {ras_8},
       {ras_7},
       {ras_6},
       {ras_5},
       {ras_4},
       {ras_3},
       {ras_2},
       {ras_1},
       {ras_0}};	// ras.scala:37:16, :41:12
    io_read_addr_REG_2 <= _GEN[io_read_idx];	// ras.scala:41:12
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:42];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [5:0] i = 6'h0; i < 6'h2B; i += 6'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        ras_0 = {_RANDOM[6'h0], _RANDOM[6'h1][7:0]};	// ras.scala:37:16
        ras_1 = {_RANDOM[6'h1][31:8], _RANDOM[6'h2][15:0]};	// ras.scala:37:16
        ras_2 = {_RANDOM[6'h2][31:16], _RANDOM[6'h3][23:0]};	// ras.scala:37:16
        ras_3 = {_RANDOM[6'h3][31:24], _RANDOM[6'h4]};	// ras.scala:37:16
        ras_4 = {_RANDOM[6'h5], _RANDOM[6'h6][7:0]};	// ras.scala:37:16
        ras_5 = {_RANDOM[6'h6][31:8], _RANDOM[6'h7][15:0]};	// ras.scala:37:16
        ras_6 = {_RANDOM[6'h7][31:16], _RANDOM[6'h8][23:0]};	// ras.scala:37:16
        ras_7 = {_RANDOM[6'h8][31:24], _RANDOM[6'h9]};	// ras.scala:37:16
        ras_8 = {_RANDOM[6'hA], _RANDOM[6'hB][7:0]};	// ras.scala:37:16
        ras_9 = {_RANDOM[6'hB][31:8], _RANDOM[6'hC][15:0]};	// ras.scala:37:16
        ras_10 = {_RANDOM[6'hC][31:16], _RANDOM[6'hD][23:0]};	// ras.scala:37:16
        ras_11 = {_RANDOM[6'hD][31:24], _RANDOM[6'hE]};	// ras.scala:37:16
        ras_12 = {_RANDOM[6'hF], _RANDOM[6'h10][7:0]};	// ras.scala:37:16
        ras_13 = {_RANDOM[6'h10][31:8], _RANDOM[6'h11][15:0]};	// ras.scala:37:16
        ras_14 = {_RANDOM[6'h11][31:16], _RANDOM[6'h12][23:0]};	// ras.scala:37:16
        ras_15 = {_RANDOM[6'h12][31:24], _RANDOM[6'h13]};	// ras.scala:37:16
        ras_16 = {_RANDOM[6'h14], _RANDOM[6'h15][7:0]};	// ras.scala:37:16
        ras_17 = {_RANDOM[6'h15][31:8], _RANDOM[6'h16][15:0]};	// ras.scala:37:16
        ras_18 = {_RANDOM[6'h16][31:16], _RANDOM[6'h17][23:0]};	// ras.scala:37:16
        ras_19 = {_RANDOM[6'h17][31:24], _RANDOM[6'h18]};	// ras.scala:37:16
        ras_20 = {_RANDOM[6'h19], _RANDOM[6'h1A][7:0]};	// ras.scala:37:16
        ras_21 = {_RANDOM[6'h1A][31:8], _RANDOM[6'h1B][15:0]};	// ras.scala:37:16
        ras_22 = {_RANDOM[6'h1B][31:16], _RANDOM[6'h1C][23:0]};	// ras.scala:37:16
        ras_23 = {_RANDOM[6'h1C][31:24], _RANDOM[6'h1D]};	// ras.scala:37:16
        ras_24 = {_RANDOM[6'h1E], _RANDOM[6'h1F][7:0]};	// ras.scala:37:16
        ras_25 = {_RANDOM[6'h1F][31:8], _RANDOM[6'h20][15:0]};	// ras.scala:37:16
        ras_26 = {_RANDOM[6'h20][31:16], _RANDOM[6'h21][23:0]};	// ras.scala:37:16
        ras_27 = {_RANDOM[6'h21][31:24], _RANDOM[6'h22]};	// ras.scala:37:16
        ras_28 = {_RANDOM[6'h23], _RANDOM[6'h24][7:0]};	// ras.scala:37:16
        ras_29 = {_RANDOM[6'h24][31:8], _RANDOM[6'h25][15:0]};	// ras.scala:37:16
        ras_30 = {_RANDOM[6'h25][31:16], _RANDOM[6'h26][23:0]};	// ras.scala:37:16
        ras_31 = {_RANDOM[6'h26][31:24], _RANDOM[6'h27]};	// ras.scala:37:16
        io_read_addr_REG = _RANDOM[6'h28][0];	// ras.scala:39:30
        io_read_addr_REG_1 = {_RANDOM[6'h28][31:1], _RANDOM[6'h29][8:0]};	// ras.scala:39:30, :40:12
        io_read_addr_REG_2 = {_RANDOM[6'h29][31:9], _RANDOM[6'h2A][16:0]};	// ras.scala:40:12, :41:12
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_read_addr = io_read_addr_REG ? io_read_addr_REG_1 : io_read_addr_REG_2;	// ras.scala:39:{22,30}, :40:12, :41:12
endmodule

