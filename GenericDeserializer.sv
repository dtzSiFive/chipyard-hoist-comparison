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

module GenericDeserializer(
  input         clock,
                reset,
                io_in_valid,
  input  [3:0]  io_in_bits,
  input         io_out_ready,
  output        io_in_ready,
                io_out_valid,
  output [2:0]  io_out_bits_chanId,
                io_out_bits_opcode,
                io_out_bits_param,
  output [3:0]  io_out_bits_size,
                io_out_bits_source,
  output [31:0] io_out_bits_address,
  output [63:0] io_out_bits_data,
  output        io_out_bits_corrupt,
  output [7:0]  io_out_bits_union
);

  reg [3:0] data_0;	// Serdes.scala:202:17
  reg [3:0] data_1;	// Serdes.scala:202:17
  reg [3:0] data_2;	// Serdes.scala:202:17
  reg [3:0] data_3;	// Serdes.scala:202:17
  reg [3:0] data_4;	// Serdes.scala:202:17
  reg [3:0] data_5;	// Serdes.scala:202:17
  reg [3:0] data_6;	// Serdes.scala:202:17
  reg [3:0] data_7;	// Serdes.scala:202:17
  reg [3:0] data_8;	// Serdes.scala:202:17
  reg [3:0] data_9;	// Serdes.scala:202:17
  reg [3:0] data_10;	// Serdes.scala:202:17
  reg [3:0] data_11;	// Serdes.scala:202:17
  reg [3:0] data_12;	// Serdes.scala:202:17
  reg [3:0] data_13;	// Serdes.scala:202:17
  reg [3:0] data_14;	// Serdes.scala:202:17
  reg [3:0] data_15;	// Serdes.scala:202:17
  reg [3:0] data_16;	// Serdes.scala:202:17
  reg [3:0] data_17;	// Serdes.scala:202:17
  reg [3:0] data_18;	// Serdes.scala:202:17
  reg [3:0] data_19;	// Serdes.scala:202:17
  reg [3:0] data_20;	// Serdes.scala:202:17
  reg [3:0] data_21;	// Serdes.scala:202:17
  reg [3:0] data_22;	// Serdes.scala:202:17
  reg [3:0] data_23;	// Serdes.scala:202:17
  reg [3:0] data_24;	// Serdes.scala:202:17
  reg [3:0] data_25;	// Serdes.scala:202:17
  reg [3:0] data_26;	// Serdes.scala:202:17
  reg [3:0] data_27;	// Serdes.scala:202:17
  reg [3:0] data_28;	// Serdes.scala:202:17
  reg [3:0] data_29;	// Serdes.scala:202:17
  reg [3:0] data_30;	// Serdes.scala:202:17
  reg       receiving;	// Serdes.scala:204:26
  reg [4:0] recvCount;	// Counter.scala:60:40
  always @(posedge clock) begin
    automatic logic _GEN;	// Decoupled.scala:40:37
    _GEN = receiving & io_in_valid;	// Decoupled.scala:40:37, Serdes.scala:204:26
    if (_GEN & recvCount == 5'h0)	// Counter.scala:60:40, Decoupled.scala:40:37, Serdes.scala:202:17, :211:23, :212:21
      data_0 <= io_in_bits;	// Serdes.scala:202:17
    if (_GEN & recvCount == 5'h1)	// Counter.scala:60:40, Decoupled.scala:40:37, Serdes.scala:202:17, :211:23, :212:21
      data_1 <= io_in_bits;	// Serdes.scala:202:17
    if (_GEN & recvCount == 5'h2)	// Counter.scala:60:40, Decoupled.scala:40:37, Serdes.scala:202:17, :211:23, :212:21
      data_2 <= io_in_bits;	// Serdes.scala:202:17
    if (_GEN & recvCount == 5'h3)	// Counter.scala:60:40, Decoupled.scala:40:37, Serdes.scala:202:17, :211:23, :212:21
      data_3 <= io_in_bits;	// Serdes.scala:202:17
    if (_GEN & recvCount == 5'h4)	// Counter.scala:60:40, Decoupled.scala:40:37, Serdes.scala:202:17, :211:23, :212:21
      data_4 <= io_in_bits;	// Serdes.scala:202:17
    if (_GEN & recvCount == 5'h5)	// Counter.scala:60:40, Decoupled.scala:40:37, Serdes.scala:202:17, :211:23, :212:21
      data_5 <= io_in_bits;	// Serdes.scala:202:17
    if (_GEN & recvCount == 5'h6)	// Counter.scala:60:40, Decoupled.scala:40:37, Serdes.scala:202:17, :211:23, :212:21
      data_6 <= io_in_bits;	// Serdes.scala:202:17
    if (_GEN & recvCount == 5'h7)	// Counter.scala:60:40, Decoupled.scala:40:37, Serdes.scala:202:17, :211:23, :212:21
      data_7 <= io_in_bits;	// Serdes.scala:202:17
    if (_GEN & recvCount == 5'h8)	// Counter.scala:60:40, Decoupled.scala:40:37, Serdes.scala:202:17, :211:23, :212:21
      data_8 <= io_in_bits;	// Serdes.scala:202:17
    if (_GEN & recvCount == 5'h9)	// Counter.scala:60:40, Decoupled.scala:40:37, Serdes.scala:202:17, :211:23, :212:21
      data_9 <= io_in_bits;	// Serdes.scala:202:17
    if (_GEN & recvCount == 5'hA)	// Counter.scala:60:40, Decoupled.scala:40:37, Serdes.scala:202:17, :211:23, :212:21
      data_10 <= io_in_bits;	// Serdes.scala:202:17
    if (_GEN & recvCount == 5'hB)	// Counter.scala:60:40, Decoupled.scala:40:37, Serdes.scala:202:17, :211:23, :212:21
      data_11 <= io_in_bits;	// Serdes.scala:202:17
    if (_GEN & recvCount == 5'hC)	// Counter.scala:60:40, Decoupled.scala:40:37, Serdes.scala:202:17, :211:23, :212:21
      data_12 <= io_in_bits;	// Serdes.scala:202:17
    if (_GEN & recvCount == 5'hD)	// Counter.scala:60:40, Decoupled.scala:40:37, Serdes.scala:202:17, :211:23, :212:21
      data_13 <= io_in_bits;	// Serdes.scala:202:17
    if (_GEN & recvCount == 5'hE)	// Counter.scala:60:40, Decoupled.scala:40:37, Serdes.scala:202:17, :211:23, :212:21
      data_14 <= io_in_bits;	// Serdes.scala:202:17
    if (_GEN & recvCount == 5'hF)	// Counter.scala:60:40, Decoupled.scala:40:37, Serdes.scala:202:17, :211:23, :212:21
      data_15 <= io_in_bits;	// Serdes.scala:202:17
    if (_GEN & recvCount == 5'h10)	// Counter.scala:60:40, Decoupled.scala:40:37, Serdes.scala:202:17, :211:23, :212:21
      data_16 <= io_in_bits;	// Serdes.scala:202:17
    if (_GEN & recvCount == 5'h11)	// Counter.scala:60:40, Decoupled.scala:40:37, Serdes.scala:202:17, :211:23, :212:21
      data_17 <= io_in_bits;	// Serdes.scala:202:17
    if (_GEN & recvCount == 5'h12)	// Counter.scala:60:40, Decoupled.scala:40:37, Serdes.scala:202:17, :211:23, :212:21
      data_18 <= io_in_bits;	// Serdes.scala:202:17
    if (_GEN & recvCount == 5'h13)	// Counter.scala:60:40, Decoupled.scala:40:37, Serdes.scala:202:17, :211:23, :212:21
      data_19 <= io_in_bits;	// Serdes.scala:202:17
    if (_GEN & recvCount == 5'h14)	// Counter.scala:60:40, Decoupled.scala:40:37, Serdes.scala:202:17, :211:23, :212:21
      data_20 <= io_in_bits;	// Serdes.scala:202:17
    if (_GEN & recvCount == 5'h15)	// Counter.scala:60:40, Decoupled.scala:40:37, Serdes.scala:202:17, :211:23, :212:21
      data_21 <= io_in_bits;	// Serdes.scala:202:17
    if (_GEN & recvCount == 5'h16)	// Counter.scala:60:40, Decoupled.scala:40:37, Serdes.scala:202:17, :211:23, :212:21
      data_22 <= io_in_bits;	// Serdes.scala:202:17
    if (_GEN & recvCount == 5'h17)	// Counter.scala:60:40, Decoupled.scala:40:37, Serdes.scala:202:17, :211:23, :212:21
      data_23 <= io_in_bits;	// Serdes.scala:202:17
    if (_GEN & recvCount == 5'h18)	// Counter.scala:60:40, Decoupled.scala:40:37, Serdes.scala:202:17, :211:23, :212:21
      data_24 <= io_in_bits;	// Serdes.scala:202:17
    if (_GEN & recvCount == 5'h19)	// Counter.scala:60:40, Decoupled.scala:40:37, Serdes.scala:202:17, :211:23, :212:21
      data_25 <= io_in_bits;	// Serdes.scala:202:17
    if (_GEN & recvCount == 5'h1A)	// Counter.scala:60:40, Decoupled.scala:40:37, Serdes.scala:202:17, :211:23, :212:21
      data_26 <= io_in_bits;	// Serdes.scala:202:17
    if (_GEN & recvCount == 5'h1B)	// Counter.scala:60:40, Decoupled.scala:40:37, Serdes.scala:202:17, :211:23, :212:21
      data_27 <= io_in_bits;	// Serdes.scala:202:17
    if (_GEN & recvCount == 5'h1C)	// Counter.scala:60:40, Decoupled.scala:40:37, Serdes.scala:202:17, :211:23, :212:21
      data_28 <= io_in_bits;	// Serdes.scala:202:17
    if (_GEN & recvCount == 5'h1D)	// Counter.scala:60:40, Decoupled.scala:40:37, Serdes.scala:202:17, :211:23, :212:21
      data_29 <= io_in_bits;	// Serdes.scala:202:17
    if (_GEN & recvCount == 5'h1E)	// Counter.scala:60:40, :72:24, Decoupled.scala:40:37, Serdes.scala:202:17, :211:23, :212:21
      data_30 <= io_in_bits;	// Serdes.scala:202:17
    if (reset) begin
      receiving <= 1'h1;	// Serdes.scala:204:26
      recvCount <= 5'h0;	// Counter.scala:60:40
    end
    else begin
      automatic logic wrap_wrap;	// Counter.scala:72:24
      wrap_wrap = recvCount == 5'h1E;	// Counter.scala:60:40, :72:24
      receiving <= io_out_ready & ~receiving | ~(_GEN & wrap_wrap) & receiving;	// Counter.scala:72:24, :118:{17,24}, Decoupled.scala:40:37, Serdes.scala:204:26, :208:19, :215:{19,31}, :217:{24,36}
      if (_GEN) begin	// Decoupled.scala:40:37
        if (wrap_wrap)	// Counter.scala:72:24
          recvCount <= 5'h0;	// Counter.scala:60:40
        else	// Counter.scala:72:24
          recvCount <= recvCount + 5'h1;	// Counter.scala:60:40, :76:24, Serdes.scala:212:21
      end
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:4];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [2:0] i = 3'h0; i < 3'h5; i += 3'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        data_0 = _RANDOM[3'h0][3:0];	// Serdes.scala:202:17
        data_1 = _RANDOM[3'h0][7:4];	// Serdes.scala:202:17
        data_2 = _RANDOM[3'h0][11:8];	// Serdes.scala:202:17
        data_3 = _RANDOM[3'h0][15:12];	// Serdes.scala:202:17
        data_4 = _RANDOM[3'h0][19:16];	// Serdes.scala:202:17
        data_5 = _RANDOM[3'h0][23:20];	// Serdes.scala:202:17
        data_6 = _RANDOM[3'h0][27:24];	// Serdes.scala:202:17
        data_7 = _RANDOM[3'h0][31:28];	// Serdes.scala:202:17
        data_8 = _RANDOM[3'h1][3:0];	// Serdes.scala:202:17
        data_9 = _RANDOM[3'h1][7:4];	// Serdes.scala:202:17
        data_10 = _RANDOM[3'h1][11:8];	// Serdes.scala:202:17
        data_11 = _RANDOM[3'h1][15:12];	// Serdes.scala:202:17
        data_12 = _RANDOM[3'h1][19:16];	// Serdes.scala:202:17
        data_13 = _RANDOM[3'h1][23:20];	// Serdes.scala:202:17
        data_14 = _RANDOM[3'h1][27:24];	// Serdes.scala:202:17
        data_15 = _RANDOM[3'h1][31:28];	// Serdes.scala:202:17
        data_16 = _RANDOM[3'h2][3:0];	// Serdes.scala:202:17
        data_17 = _RANDOM[3'h2][7:4];	// Serdes.scala:202:17
        data_18 = _RANDOM[3'h2][11:8];	// Serdes.scala:202:17
        data_19 = _RANDOM[3'h2][15:12];	// Serdes.scala:202:17
        data_20 = _RANDOM[3'h2][19:16];	// Serdes.scala:202:17
        data_21 = _RANDOM[3'h2][23:20];	// Serdes.scala:202:17
        data_22 = _RANDOM[3'h2][27:24];	// Serdes.scala:202:17
        data_23 = _RANDOM[3'h2][31:28];	// Serdes.scala:202:17
        data_24 = _RANDOM[3'h3][3:0];	// Serdes.scala:202:17
        data_25 = _RANDOM[3'h3][7:4];	// Serdes.scala:202:17
        data_26 = _RANDOM[3'h3][11:8];	// Serdes.scala:202:17
        data_27 = _RANDOM[3'h3][15:12];	// Serdes.scala:202:17
        data_28 = _RANDOM[3'h3][19:16];	// Serdes.scala:202:17
        data_29 = _RANDOM[3'h3][23:20];	// Serdes.scala:202:17
        data_30 = _RANDOM[3'h3][27:24];	// Serdes.scala:202:17
        receiving = _RANDOM[3'h3][28];	// Serdes.scala:202:17, :204:26
        recvCount = {_RANDOM[3'h3][31:29], _RANDOM[3'h4][1:0]};	// Counter.scala:60:40, Serdes.scala:202:17
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_in_ready = receiving;	// Serdes.scala:204:26
  assign io_out_valid = ~receiving;	// Serdes.scala:204:26, :208:19
  assign io_out_bits_chanId = data_30[2:0];	// Serdes.scala:202:17
  assign io_out_bits_opcode = data_29[3:1];	// Serdes.scala:202:17, :209:38
  assign io_out_bits_param = {data_29[0], data_28[3:2]};	// Serdes.scala:202:17, :209:38
  assign io_out_bits_size = {data_28[1:0], data_27[3:2]};	// Serdes.scala:202:17, :209:38
  assign io_out_bits_source = {data_27[1:0], data_26[3:2]};	// Serdes.scala:202:17, :209:38
  assign io_out_bits_address =
    {data_26[1:0],
     data_25,
     data_24,
     data_23,
     data_22,
     data_21,
     data_20,
     data_19,
     data_18[3:2]};	// Serdes.scala:202:17, :209:38
  assign io_out_bits_data =
    {data_18[1:0],
     data_17,
     data_16,
     data_15,
     data_14,
     data_13,
     data_12,
     data_11,
     data_10,
     data_9,
     data_8,
     data_7,
     data_6,
     data_5,
     data_4,
     data_3,
     data_2[3:2]};	// Serdes.scala:202:17, :209:38
  assign io_out_bits_corrupt = data_2[1];	// Serdes.scala:202:17, :209:38
  assign io_out_bits_union = {data_2[0], data_1, data_0[3:1]};	// Serdes.scala:202:17, :209:38
endmodule

