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

module HellaPeekingArbiter(
  input         clock,
                reset,
                io_in_1_valid,
  input  [2:0]  io_in_1_bits_opcode,
                io_in_1_bits_param,
  input  [3:0]  io_in_1_bits_size,
                io_in_1_bits_source,
  input  [63:0] io_in_1_bits_data,
  input         io_in_1_bits_corrupt,
  input  [7:0]  io_in_1_bits_union,
  input         io_in_1_bits_last,
                io_in_4_valid,
  input  [2:0]  io_in_4_bits_opcode,
                io_in_4_bits_param,
  input  [3:0]  io_in_4_bits_size,
                io_in_4_bits_source,
  input  [31:0] io_in_4_bits_address,
  input  [63:0] io_in_4_bits_data,
  input         io_in_4_bits_corrupt,
  input  [7:0]  io_in_4_bits_union,
  input         io_in_4_bits_last,
                io_out_ready,
  output        io_in_1_ready,
                io_in_4_ready,
                io_out_valid,
  output [2:0]  io_out_bits_chanId,
                io_out_bits_opcode,
                io_out_bits_param,
  output [3:0]  io_out_bits_size,
                io_out_bits_source,
  output [31:0] io_out_bits_address,
  output [63:0] io_out_bits_data,
  output        io_out_bits_corrupt,
  output [7:0]  io_out_bits_union,
  output        io_out_bits_last
);

  wire [2:0]       _GEN = {1'h1, 1'h1, 1'h1};	// Arbiters.scala:42:16
  wire [2:0][7:0]  _GEN_0 = {8'h0, 8'h0, 8'h0};	// Arbiters.scala:42:16
  wire [2:0]       _GEN_1 = {1'h0, 1'h0, 1'h0};	// Arbiters.scala:42:16
  wire [2:0][63:0] _GEN_2 = {64'h0, 64'h0, 64'h0};	// Arbiters.scala:42:16
  wire [2:0][31:0] _GEN_3 = {32'h0, 32'h0, 32'h0};	// Arbiters.scala:42:16
  wire [2:0][3:0]  _GEN_4 = {4'h0, 4'h0, 4'h0};	// Arbiters.scala:42:16
  wire [2:0][2:0]  _GEN_5 = {3'h0, 3'h0, 3'h0};	// Arbiters.scala:42:16
  wire [7:0][2:0]  _GEN_6 = {3'h4, 3'h4, 3'h4, 3'h0, 3'h1, 3'h2, 3'h3, 3'h4};	// Arbiters.scala:42:16
  reg  [2:0]       lockIdx;	// Arbiters.scala:25:20
  reg              locked;	// Arbiters.scala:26:19
  wire [2:0]       chosen = locked ? lockIdx : io_in_1_valid ? 3'h1 : 3'h4;	// Arbiters.scala:25:20, :26:19, :36:19, Mux.scala:47:69
  wire [7:0]       _GEN_7 =
    {_GEN_1, {{io_in_4_valid}, {1'h0}, {1'h0}, {io_in_1_valid}, {1'h0}}};	// Arbiters.scala:42:16
  wire [7:0][2:0]  _GEN_8 =
    {_GEN_5, {{io_in_4_bits_opcode}, {3'h0}, {3'h0}, {io_in_1_bits_opcode}, {3'h0}}};	// Arbiters.scala:42:16
  wire [7:0][2:0]  _GEN_9 =
    {_GEN_5, {{io_in_4_bits_param}, {3'h0}, {3'h0}, {io_in_1_bits_param}, {3'h0}}};	// Arbiters.scala:42:16
  wire [7:0][3:0]  _GEN_10 =
    {_GEN_4, {{io_in_4_bits_size}, {4'h0}, {4'h0}, {io_in_1_bits_size}, {4'h0}}};	// Arbiters.scala:42:16
  wire [7:0][3:0]  _GEN_11 =
    {_GEN_4, {{io_in_4_bits_source}, {4'h0}, {4'h0}, {io_in_1_bits_source}, {4'h0}}};	// Arbiters.scala:42:16
  wire [7:0][31:0] _GEN_12 =
    {_GEN_3, {{io_in_4_bits_address}, {32'h0}, {32'h0}, {32'h0}, {32'h0}}};	// Arbiters.scala:42:16
  wire [7:0][63:0] _GEN_13 =
    {_GEN_2, {{io_in_4_bits_data}, {64'h0}, {64'h0}, {io_in_1_bits_data}, {64'h0}}};	// Arbiters.scala:42:16
  wire [7:0]       _GEN_14 =
    {_GEN_1, {{io_in_4_bits_corrupt}, {1'h0}, {1'h0}, {io_in_1_bits_corrupt}, {1'h0}}};	// Arbiters.scala:42:16
  wire [7:0][7:0]  _GEN_15 =
    {_GEN_0, {{io_in_4_bits_union}, {8'h0}, {8'h0}, {io_in_1_bits_union}, {8'h0}}};	// Arbiters.scala:42:16
  wire [7:0]       _GEN_16 =
    {_GEN, {{io_in_4_bits_last}, {1'h1}, {1'h1}, {io_in_1_bits_last}, {1'h1}}};	// Arbiters.scala:42:16
  always @(posedge clock) begin
    if (reset) begin
      lockIdx <= 3'h0;	// Arbiters.scala:25:20
      locked <= 1'h0;	// Arbiters.scala:26:19
    end
    else begin
      automatic logic _GEN_17 = io_out_ready & _GEN_7[chosen];	// Arbiters.scala:36:19, :42:16, Decoupled.scala:40:37
      if (_GEN_17 & ~locked) begin	// Arbiters.scala:25:20, :26:19, :58:24, :59:{11,50}, :60:15, Decoupled.scala:40:37
        if (io_in_1_valid)
          lockIdx <= 3'h1;	// Arbiters.scala:25:20
        else
          lockIdx <= 3'h4;	// Arbiters.scala:25:20, Mux.scala:47:69
      end
      if (_GEN_17)	// Decoupled.scala:40:37
        locked <= ~_GEN_16[chosen];	// Arbiters.scala:26:19, :36:19, :42:16, :59:50, :64:35, :65:14
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
        lockIdx = _RANDOM[/*Zero width*/ 1'b0][2:0];	// Arbiters.scala:25:20
        locked = _RANDOM[/*Zero width*/ 1'b0][3];	// Arbiters.scala:25:20, :26:19
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_in_1_ready = io_out_ready & chosen == 3'h1;	// Arbiters.scala:36:19, :39:{36,46}
  assign io_in_4_ready = io_out_ready & chosen == 3'h4;	// Arbiters.scala:36:19, :39:{36,46}, Mux.scala:47:69
  assign io_out_valid = _GEN_7[chosen];	// Arbiters.scala:36:19, :42:16
  assign io_out_bits_chanId = _GEN_6[chosen];	// Arbiters.scala:36:19, :42:16
  assign io_out_bits_opcode = _GEN_8[chosen];	// Arbiters.scala:36:19, :42:16
  assign io_out_bits_param = _GEN_9[chosen];	// Arbiters.scala:36:19, :42:16
  assign io_out_bits_size = _GEN_10[chosen];	// Arbiters.scala:36:19, :42:16
  assign io_out_bits_source = _GEN_11[chosen];	// Arbiters.scala:36:19, :42:16
  assign io_out_bits_address = _GEN_12[chosen];	// Arbiters.scala:36:19, :42:16
  assign io_out_bits_data = _GEN_13[chosen];	// Arbiters.scala:36:19, :42:16
  assign io_out_bits_corrupt = _GEN_14[chosen];	// Arbiters.scala:36:19, :42:16
  assign io_out_bits_union = _GEN_15[chosen];	// Arbiters.scala:36:19, :42:16
  assign io_out_bits_last = _GEN_16[chosen];	// Arbiters.scala:36:19, :42:16
endmodule

