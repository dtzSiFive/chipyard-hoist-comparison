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

module TLXbar_5(
  input         clock,
                reset,
                auto_in_a_valid,
  input  [2:0]  auto_in_a_bits_opcode,
                auto_in_a_bits_param,
  input  [3:0]  auto_in_a_bits_size,
  input  [7:0]  auto_in_a_bits_source,
  input  [30:0] auto_in_a_bits_address,
  input  [7:0]  auto_in_a_bits_mask,
  input         auto_in_a_bits_corrupt,
                auto_in_d_ready,
                auto_out_6_a_ready,
                auto_out_6_d_valid,
  input  [2:0]  auto_out_6_d_bits_size,
  input  [7:0]  auto_out_6_d_bits_source,
  input  [63:0] auto_out_6_d_bits_data,
  input         auto_out_5_a_ready,
                auto_out_5_d_valid,
  input  [2:0]  auto_out_5_d_bits_opcode,
                auto_out_5_d_bits_size,
  input  [7:0]  auto_out_5_d_bits_source,
  input  [63:0] auto_out_5_d_bits_data,
  input         auto_out_4_a_ready,
                auto_out_4_d_valid,
  input  [2:0]  auto_out_4_d_bits_opcode,
                auto_out_4_d_bits_size,
  input  [7:0]  auto_out_4_d_bits_source,
  input  [63:0] auto_out_4_d_bits_data,
  input         auto_out_3_a_ready,
                auto_out_3_d_valid,
  input  [2:0]  auto_out_3_d_bits_opcode,
                auto_out_3_d_bits_size,
  input  [7:0]  auto_out_3_d_bits_source,
  input  [63:0] auto_out_3_d_bits_data,
  input         auto_out_2_a_ready,
                auto_out_2_d_valid,
  input  [2:0]  auto_out_2_d_bits_opcode,
  input  [1:0]  auto_out_2_d_bits_param,
  input  [2:0]  auto_out_2_d_bits_size,
  input  [7:0]  auto_out_2_d_bits_source,
  input         auto_out_2_d_bits_sink,
                auto_out_2_d_bits_denied,
  input  [63:0] auto_out_2_d_bits_data,
  input         auto_out_2_d_bits_corrupt,
                auto_out_1_a_ready,
                auto_out_1_d_valid,
  input  [2:0]  auto_out_1_d_bits_opcode,
  input  [1:0]  auto_out_1_d_bits_param,
  input  [2:0]  auto_out_1_d_bits_size,
  input  [7:0]  auto_out_1_d_bits_source,
  input         auto_out_1_d_bits_sink,
                auto_out_1_d_bits_denied,
  input  [63:0] auto_out_1_d_bits_data,
  input         auto_out_1_d_bits_corrupt,
                auto_out_0_a_ready,
                auto_out_0_d_valid,
  input  [2:0]  auto_out_0_d_bits_opcode,
  input  [1:0]  auto_out_0_d_bits_param,
  input  [3:0]  auto_out_0_d_bits_size,
  input  [7:0]  auto_out_0_d_bits_source,
  input         auto_out_0_d_bits_sink,
                auto_out_0_d_bits_denied,
  input  [63:0] auto_out_0_d_bits_data,
  input         auto_out_0_d_bits_corrupt,
  output        auto_in_a_ready,
                auto_in_d_valid,
  output [2:0]  auto_in_d_bits_opcode,
  output [1:0]  auto_in_d_bits_param,
  output [3:0]  auto_in_d_bits_size,
  output [7:0]  auto_in_d_bits_source,
  output        auto_in_d_bits_sink,
                auto_in_d_bits_denied,
  output [63:0] auto_in_d_bits_data,
  output        auto_in_d_bits_corrupt,
                auto_out_6_a_valid,
  output [2:0]  auto_out_6_a_bits_size,
  output [16:0] auto_out_6_a_bits_address,
  output        auto_out_6_d_ready,
                auto_out_5_a_valid,
  output [2:0]  auto_out_5_a_bits_size,
  output [11:0] auto_out_5_a_bits_address,
  output        auto_out_5_d_ready,
                auto_out_4_a_valid,
  output [2:0]  auto_out_4_a_bits_size,
  output [25:0] auto_out_4_a_bits_address,
  output        auto_out_4_d_ready,
                auto_out_3_a_valid,
  output [2:0]  auto_out_3_a_bits_size,
  output [27:0] auto_out_3_a_bits_address,
  output        auto_out_3_d_ready,
                auto_out_2_a_valid,
  output [2:0]  auto_out_2_a_bits_size,
  output        auto_out_2_d_ready,
                auto_out_1_a_valid,
  output [2:0]  auto_out_1_a_bits_size,
  output [25:0] auto_out_1_a_bits_address,
  output        auto_out_1_d_ready,
                auto_out_0_a_valid,
  output [13:0] auto_out_0_a_bits_address,
  output        auto_out_0_d_ready
);

  wire        requestAIO_0_0 =
    {auto_in_a_bits_address[30],
     auto_in_a_bits_address[26:25],
     auto_in_a_bits_address[20],
     auto_in_a_bits_address[16],
     auto_in_a_bits_address[14],
     ~(auto_in_a_bits_address[13])} == 7'h0;	// Arbiter.scala:25:66, BundleMap.scala:247:19, Parameters.scala:137:{31,49,52,67}
  wire [9:0]  _GEN = auto_in_a_bits_address[25:16] ^ 10'h201;	// BundleMap.scala:247:19, Parameters.scala:137:31
  wire        requestAIO_0_1 =
    {auto_in_a_bits_address[30],
     auto_in_a_bits_address[26],
     _GEN[9],
     auto_in_a_bits_address[20],
     _GEN[0],
     auto_in_a_bits_address[14:13]} == 7'h0;	// Arbiter.scala:25:66, Parameters.scala:137:{31,49,52,67}
  wire [5:0]  _requestAIO_T_20 = auto_in_a_bits_address[30:25] ^ 6'h22;	// Parameters.scala:137:31
  wire        requestAIO_0_2 =
    {auto_in_a_bits_address[30],
     auto_in_a_bits_address[26:25],
     auto_in_a_bits_address[20],
     auto_in_a_bits_address[16],
     auto_in_a_bits_address[14:13] ^ 2'h2} == 7'h0
    | {auto_in_a_bits_address[30],
       auto_in_a_bits_address[26:25],
       ~(auto_in_a_bits_address[20]),
       auto_in_a_bits_address[16],
       auto_in_a_bits_address[14:13]} == 7'h0
    | {_requestAIO_T_20[5],
       _requestAIO_T_20[1:0],
       auto_in_a_bits_address[20],
       auto_in_a_bits_address[16],
       auto_in_a_bits_address[14:13]} == 7'h0;	// Arbiter.scala:25:66, Parameters.scala:137:{31,49,52,67}, Xbar.scala:363:92
  wire        requestAIO_0_3 =
    {auto_in_a_bits_address[30], ~(auto_in_a_bits_address[26])} == 2'h0;	// Mux.scala:27:72, Parameters.scala:137:{31,49,52,67}
  wire        requestAIO_0_4 =
    {auto_in_a_bits_address[30],
     auto_in_a_bits_address[26],
     ~(auto_in_a_bits_address[25]),
     auto_in_a_bits_address[20],
     auto_in_a_bits_address[16]} == 5'h0;	// BundleMap.scala:247:19, Parameters.scala:137:{31,49,52,67}
  wire        requestAIO_0_5 =
    {auto_in_a_bits_address[30],
     auto_in_a_bits_address[26:25],
     auto_in_a_bits_address[20],
     auto_in_a_bits_address[16],
     auto_in_a_bits_address[14:13]} == 7'h0;	// Arbiter.scala:25:66, Parameters.scala:137:{49,52,67}
  wire        requestAIO_0_6 =
    {auto_in_a_bits_address[30],
     auto_in_a_bits_address[26:25],
     auto_in_a_bits_address[20],
     ~(auto_in_a_bits_address[16])} == 5'h0;	// Parameters.scala:137:{31,49,52,67}
  wire        _portsAOI_in_0_a_ready_WIRE =
    requestAIO_0_0 & auto_out_0_a_ready | requestAIO_0_1 & auto_out_1_a_ready
    | requestAIO_0_2 & auto_out_2_a_ready | requestAIO_0_3 & auto_out_3_a_ready
    | requestAIO_0_4 & auto_out_4_a_ready | requestAIO_0_5 & auto_out_5_a_ready
    | requestAIO_0_6 & auto_out_6_a_ready;	// Mux.scala:27:72, Parameters.scala:137:{49,52,67}, Xbar.scala:363:92
  reg  [8:0]  beatsLeft;	// Arbiter.scala:87:30
  wire        idle = beatsLeft == 9'h0;	// Arbiter.scala:87:30, :88:28, Edges.scala:220:14
  wire [6:0]  readys_filter_lo =
    {auto_out_6_d_valid,
     auto_out_5_d_valid,
     auto_out_4_d_valid,
     auto_out_3_d_valid,
     auto_out_2_d_valid,
     auto_out_1_d_valid,
     auto_out_0_d_valid};	// Cat.scala:30:58
  reg  [6:0]  readys_mask;	// Arbiter.scala:23:23
  wire [6:0]  readys_filter_hi = readys_filter_lo & ~readys_mask;	// Arbiter.scala:23:23, :24:{28,30}, Cat.scala:30:58
  wire [11:0] _GEN_0 =
    {readys_filter_hi[5:0],
     auto_out_6_d_valid,
     auto_out_5_d_valid,
     auto_out_4_d_valid,
     auto_out_3_d_valid,
     auto_out_2_d_valid,
     auto_out_1_d_valid}
    | {readys_filter_hi,
       auto_out_6_d_valid,
       auto_out_5_d_valid,
       auto_out_4_d_valid,
       auto_out_3_d_valid,
       auto_out_2_d_valid};	// Arbiter.scala:24:28, package.scala:253:{43,48}
  wire [10:0] _GEN_1 = _GEN_0[10:0] | {readys_filter_hi[6], _GEN_0[11:2]};	// Arbiter.scala:24:28, package.scala:253:{43,48}
  wire [8:0]  _GEN_2 = _GEN_1[8:0] | {readys_filter_hi[6], _GEN_0[11], _GEN_1[10:4]};	// Arbiter.scala:24:28, package.scala:253:{43,48}
  wire [6:0]  readys_readys =
    ~({readys_mask[6],
       readys_filter_hi[6] | readys_mask[5],
       _GEN_0[11] | readys_mask[4],
       _GEN_1[10:9] | readys_mask[3:2],
       _GEN_2[8:7] | readys_mask[1:0]} & _GEN_2[6:0]);	// Arbiter.scala:23:23, :24:28, :25:58, :26:{18,29,39}, package.scala:253:43
  wire        prefixOR_1 = readys_readys[0] & auto_out_0_d_valid;	// Arbiter.scala:26:18, :95:86, :97:79
  wire        earlyWinner_1 = readys_readys[1] & auto_out_1_d_valid;	// Arbiter.scala:26:18, :95:86, :97:79
  wire        earlyWinner_2 = readys_readys[2] & auto_out_2_d_valid;	// Arbiter.scala:26:18, :95:86, :97:79
  wire        earlyWinner_3 = readys_readys[3] & auto_out_3_d_valid;	// Arbiter.scala:26:18, :95:86, :97:79
  wire        earlyWinner_4 = readys_readys[4] & auto_out_4_d_valid;	// Arbiter.scala:26:18, :95:86, :97:79
  wire        earlyWinner_5 = readys_readys[5] & auto_out_5_d_valid;	// Arbiter.scala:26:18, :95:86, :97:79
  wire        earlyWinner_6 = readys_readys[6] & auto_out_6_d_valid;	// Arbiter.scala:26:18, :95:86, :97:79
  wire        _sink_ACancel_earlyValid_T = auto_out_0_d_valid | auto_out_1_d_valid;	// Arbiter.scala:107:36
  `ifndef SYNTHESIS	// Arbiter.scala:105:13
    always @(posedge clock) begin	// Arbiter.scala:105:13
      automatic logic prefixOR_2 = prefixOR_1 | earlyWinner_1;	// Arbiter.scala:97:79, :104:53
      automatic logic prefixOR_3 = prefixOR_2 | earlyWinner_2;	// Arbiter.scala:97:79, :104:53
      automatic logic prefixOR_4 = prefixOR_3 | earlyWinner_3;	// Arbiter.scala:97:79, :104:53
      automatic logic prefixOR_5 = prefixOR_4 | earlyWinner_4;	// Arbiter.scala:97:79, :104:53
      if (~((~prefixOR_1 | ~earlyWinner_1) & (~prefixOR_2 | ~earlyWinner_2)
            & (~prefixOR_3 | ~earlyWinner_3) & (~prefixOR_4 | ~earlyWinner_4)
            & (~prefixOR_5 | ~earlyWinner_5)
            & (~(prefixOR_5 | earlyWinner_5) | ~earlyWinner_6) | reset)) begin	// Arbiter.scala:97:79, :104:53, :105:{13,61,64,67,82}
        if (`ASSERT_VERBOSE_COND_)	// Arbiter.scala:105:13
          $error("Assertion failed\n    at Arbiter.scala:105 assert((prefixOR zip earlyWinner) map { case (p,w) => !p || !w } reduce {_ && _})\n");	// Arbiter.scala:105:13
        if (`STOP_COND_)	// Arbiter.scala:105:13
          $fatal;	// Arbiter.scala:105:13
      end
      if (~(~(_sink_ACancel_earlyValid_T | auto_out_2_d_valid | auto_out_3_d_valid
              | auto_out_4_d_valid | auto_out_5_d_valid | auto_out_6_d_valid) | prefixOR_1
            | earlyWinner_1 | earlyWinner_2 | earlyWinner_3 | earlyWinner_4
            | earlyWinner_5 | earlyWinner_6 | reset)) begin	// Arbiter.scala:97:79, :107:{14,15,36}
        if (`ASSERT_VERBOSE_COND_)	// Arbiter.scala:107:14
          $error("Assertion failed\n    at Arbiter.scala:107 assert (!earlyValids.reduce(_||_) || earlyWinner.reduce(_||_))\n");	// Arbiter.scala:107:14
        if (`STOP_COND_)	// Arbiter.scala:107:14
          $fatal;	// Arbiter.scala:107:14
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  reg         state_0;	// Arbiter.scala:116:26
  reg         state_1;	// Arbiter.scala:116:26
  reg         state_2;	// Arbiter.scala:116:26
  reg         state_3;	// Arbiter.scala:116:26
  reg         state_4;	// Arbiter.scala:116:26
  reg         state_5;	// Arbiter.scala:116:26
  reg         state_6;	// Arbiter.scala:116:26
  wire        muxStateEarly_0 = idle ? prefixOR_1 : state_0;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        muxStateEarly_1 = idle ? earlyWinner_1 : state_1;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        muxStateEarly_2 = idle ? earlyWinner_2 : state_2;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        muxStateEarly_3 = idle ? earlyWinner_3 : state_3;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        muxStateEarly_4 = idle ? earlyWinner_4 : state_4;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        muxStateEarly_5 = idle ? earlyWinner_5 : state_5;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        muxStateEarly_6 = idle ? earlyWinner_6 : state_6;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        out_24_valid =
    idle
      ? _sink_ACancel_earlyValid_T | auto_out_2_d_valid | auto_out_3_d_valid
        | auto_out_4_d_valid | auto_out_5_d_valid | auto_out_6_d_valid
      : state_0 & auto_out_0_d_valid | state_1 & auto_out_1_d_valid | state_2
        & auto_out_2_d_valid | state_3 & auto_out_3_d_valid | state_4 & auto_out_4_d_valid
        | state_5 & auto_out_5_d_valid | state_6 & auto_out_6_d_valid;	// Arbiter.scala:88:28, :107:36, :116:26, :125:{29,56}, Mux.scala:27:72
  wire        out_24_bits_corrupt =
    muxStateEarly_0 & auto_out_0_d_bits_corrupt | muxStateEarly_1
    & auto_out_1_d_bits_corrupt | muxStateEarly_2 & auto_out_2_d_bits_corrupt;	// Arbiter.scala:117:30, Mux.scala:27:72
  wire        out_24_bits_denied =
    muxStateEarly_0 & auto_out_0_d_bits_denied | muxStateEarly_1
    & auto_out_1_d_bits_denied | muxStateEarly_2 & auto_out_2_d_bits_denied;	// Arbiter.scala:117:30, Mux.scala:27:72
  wire        out_24_bits_sink =
    muxStateEarly_0 & auto_out_0_d_bits_sink | muxStateEarly_1 & auto_out_1_d_bits_sink
    | muxStateEarly_2 & auto_out_2_d_bits_sink;	// Arbiter.scala:117:30, Mux.scala:27:72
  wire [7:0]  out_24_bits_source =
    (muxStateEarly_0 ? auto_out_0_d_bits_source : 8'h0)
    | (muxStateEarly_1 ? auto_out_1_d_bits_source : 8'h0)
    | (muxStateEarly_2 ? auto_out_2_d_bits_source : 8'h0)
    | (muxStateEarly_3 ? auto_out_3_d_bits_source : 8'h0)
    | (muxStateEarly_4 ? auto_out_4_d_bits_source : 8'h0)
    | (muxStateEarly_5 ? auto_out_5_d_bits_source : 8'h0)
    | (muxStateEarly_6 ? auto_out_6_d_bits_source : 8'h0);	// Arbiter.scala:117:30, Bundles.scala:257:54, Mux.scala:27:72
  wire [3:0]  out_24_bits_size =
    (muxStateEarly_0 ? auto_out_0_d_bits_size : 4'h0)
    | (muxStateEarly_1 ? {1'h0, auto_out_1_d_bits_size} : 4'h0)
    | (muxStateEarly_2 ? {1'h0, auto_out_2_d_bits_size} : 4'h0)
    | (muxStateEarly_3 ? {1'h0, auto_out_3_d_bits_size} : 4'h0)
    | (muxStateEarly_4 ? {1'h0, auto_out_4_d_bits_size} : 4'h0)
    | (muxStateEarly_5 ? {1'h0, auto_out_5_d_bits_size} : 4'h0)
    | (muxStateEarly_6 ? {1'h0, auto_out_6_d_bits_size} : 4'h0);	// Arbiter.scala:117:30, BundleMap.scala:247:19, Bundles.scala:257:54, Mux.scala:27:72
  wire [1:0]  out_24_bits_param =
    (muxStateEarly_0 ? auto_out_0_d_bits_param : 2'h0)
    | (muxStateEarly_1 ? auto_out_1_d_bits_param : 2'h0)
    | (muxStateEarly_2 ? auto_out_2_d_bits_param : 2'h0);	// Arbiter.scala:117:30, Mux.scala:27:72
  wire [2:0]  out_24_bits_opcode =
    (muxStateEarly_0 ? auto_out_0_d_bits_opcode : 3'h0)
    | (muxStateEarly_1 ? auto_out_1_d_bits_opcode : 3'h0)
    | (muxStateEarly_2 ? auto_out_2_d_bits_opcode : 3'h0)
    | (muxStateEarly_3 ? auto_out_3_d_bits_opcode : 3'h0)
    | (muxStateEarly_4 ? auto_out_4_d_bits_opcode : 3'h0)
    | (muxStateEarly_5 ? auto_out_5_d_bits_opcode : 3'h0) | {2'h0, muxStateEarly_6};	// Arbiter.scala:117:30, Bundles.scala:257:54, Mux.scala:27:72
  always @(posedge clock) begin
    if (reset) begin
      beatsLeft <= 9'h0;	// Arbiter.scala:87:30, Edges.scala:220:14
      readys_mask <= 7'h7F;	// Arbiter.scala:23:23
      state_0 <= 1'h0;	// Arbiter.scala:116:26
      state_1 <= 1'h0;	// Arbiter.scala:116:26
      state_2 <= 1'h0;	// Arbiter.scala:116:26
      state_3 <= 1'h0;	// Arbiter.scala:116:26
      state_4 <= 1'h0;	// Arbiter.scala:116:26
      state_5 <= 1'h0;	// Arbiter.scala:116:26
      state_6 <= 1'h0;	// Arbiter.scala:116:26
    end
    else begin
      automatic logic latch = idle & auto_in_d_ready;	// Arbiter.scala:88:28, :89:24
      automatic logic winnerQual_0;	// Arbiter.scala:98:79
      automatic logic winnerQual_1;	// Arbiter.scala:98:79
      automatic logic winnerQual_2;	// Arbiter.scala:98:79
      automatic logic winnerQual_3;	// Arbiter.scala:98:79
      automatic logic winnerQual_4;	// Arbiter.scala:98:79
      automatic logic winnerQual_5;	// Arbiter.scala:98:79
      automatic logic winnerQual_6;	// Arbiter.scala:98:79
      winnerQual_0 = readys_readys[0] & auto_out_0_d_valid;	// Arbiter.scala:26:18, :95:86, :98:79
      winnerQual_1 = readys_readys[1] & auto_out_1_d_valid;	// Arbiter.scala:26:18, :95:86, :98:79
      winnerQual_2 = readys_readys[2] & auto_out_2_d_valid;	// Arbiter.scala:26:18, :95:86, :98:79
      winnerQual_3 = readys_readys[3] & auto_out_3_d_valid;	// Arbiter.scala:26:18, :95:86, :98:79
      winnerQual_4 = readys_readys[4] & auto_out_4_d_valid;	// Arbiter.scala:26:18, :95:86, :98:79
      winnerQual_5 = readys_readys[5] & auto_out_5_d_valid;	// Arbiter.scala:26:18, :95:86, :98:79
      winnerQual_6 = readys_readys[6] & auto_out_6_d_valid;	// Arbiter.scala:26:18, :95:86, :98:79
      if (latch) begin	// Arbiter.scala:89:24
        automatic logic [26:0] _beatsDO_decode_T_1 = 27'hFFF << auto_out_0_d_bits_size;	// package.scala:234:77
        automatic logic [8:0]  maskedBeats_0;	// Arbiter.scala:111:73, Edges.scala:220:14
        automatic logic [20:0] _beatsDO_decode_T_25 = 21'h3F << auto_out_6_d_bits_size;	// package.scala:234:77
        automatic logic [20:0] _beatsDO_decode_T_21 = 21'h3F << auto_out_5_d_bits_size;	// package.scala:234:77
        automatic logic [20:0] _beatsDO_decode_T_17 = 21'h3F << auto_out_4_d_bits_size;	// package.scala:234:77
        automatic logic [20:0] _beatsDO_decode_T_13 = 21'h3F << auto_out_3_d_bits_size;	// package.scala:234:77
        automatic logic [20:0] _beatsDO_decode_T_9 = 21'h3F << auto_out_2_d_bits_size;	// package.scala:234:77
        automatic logic [20:0] _beatsDO_decode_T_5 = 21'h3F << auto_out_1_d_bits_size;	// package.scala:234:77
        maskedBeats_0 =
          winnerQual_0 & auto_out_0_d_bits_opcode[0]
            ? ~(_beatsDO_decode_T_1[11:3])
            : 9'h0;	// Arbiter.scala:98:79, :111:73, Edges.scala:105:36, :220:14, package.scala:234:{46,77,82}
        beatsLeft <=
          {maskedBeats_0[8:3],
           maskedBeats_0[2:0]
             | (winnerQual_1 & auto_out_1_d_bits_opcode[0]
                  ? ~(_beatsDO_decode_T_5[5:3])
                  : 3'h0)
             | (winnerQual_2 & auto_out_2_d_bits_opcode[0]
                  ? ~(_beatsDO_decode_T_9[5:3])
                  : 3'h0)
             | (winnerQual_3 & auto_out_3_d_bits_opcode[0]
                  ? ~(_beatsDO_decode_T_13[5:3])
                  : 3'h0)
             | (winnerQual_4 & auto_out_4_d_bits_opcode[0]
                  ? ~(_beatsDO_decode_T_17[5:3])
                  : 3'h0)
             | (winnerQual_5 & auto_out_5_d_bits_opcode[0]
                  ? ~(_beatsDO_decode_T_21[5:3])
                  : 3'h0) | (winnerQual_6 ? ~(_beatsDO_decode_T_25[5:3]) : 3'h0)};	// Arbiter.scala:87:30, :98:79, :111:73, :112:44, Bundles.scala:257:54, Edges.scala:105:36, :220:14, package.scala:234:{46,77,82}
      end
      else	// Arbiter.scala:89:24
        beatsLeft <= beatsLeft - {8'h0, auto_in_d_ready & out_24_valid};	// Arbiter.scala:87:30, :113:52, :125:29, Bundles.scala:257:54, ReadyValidCancel.scala:50:33
      if (latch & (|readys_filter_lo)) begin	// Arbiter.scala:27:{18,27}, :89:24, Cat.scala:30:58
        automatic logic [6:0] _readys_mask_T = readys_readys & readys_filter_lo;	// Arbiter.scala:26:18, :28:29, Cat.scala:30:58
        automatic logic [6:0] _readys_mask_T_3 =
          _readys_mask_T | {_readys_mask_T[5:0], 1'h0};	// Arbiter.scala:28:29, package.scala:244:{43,53}
        automatic logic [6:0] _readys_mask_T_6 =
          _readys_mask_T_3 | {_readys_mask_T_3[4:0], 2'h0};	// Mux.scala:27:72, package.scala:244:{43,53}
        readys_mask <= _readys_mask_T_6 | {_readys_mask_T_6[2:0], 4'h0};	// Arbiter.scala:23:23, Bundles.scala:257:54, package.scala:244:{43,53}
      end
      if (idle) begin	// Arbiter.scala:88:28
        state_0 <= winnerQual_0;	// Arbiter.scala:98:79, :116:26
        state_1 <= winnerQual_1;	// Arbiter.scala:98:79, :116:26
        state_2 <= winnerQual_2;	// Arbiter.scala:98:79, :116:26
        state_3 <= winnerQual_3;	// Arbiter.scala:98:79, :116:26
        state_4 <= winnerQual_4;	// Arbiter.scala:98:79, :116:26
        state_5 <= winnerQual_5;	// Arbiter.scala:98:79, :116:26
        state_6 <= winnerQual_6;	// Arbiter.scala:98:79, :116:26
      end
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
        beatsLeft = _RANDOM[/*Zero width*/ 1'b0][8:0];	// Arbiter.scala:87:30
        readys_mask = _RANDOM[/*Zero width*/ 1'b0][15:9];	// Arbiter.scala:23:23, :87:30
        state_0 = _RANDOM[/*Zero width*/ 1'b0][16];	// Arbiter.scala:87:30, :116:26
        state_1 = _RANDOM[/*Zero width*/ 1'b0][17];	// Arbiter.scala:87:30, :116:26
        state_2 = _RANDOM[/*Zero width*/ 1'b0][18];	// Arbiter.scala:87:30, :116:26
        state_3 = _RANDOM[/*Zero width*/ 1'b0][19];	// Arbiter.scala:87:30, :116:26
        state_4 = _RANDOM[/*Zero width*/ 1'b0][20];	// Arbiter.scala:87:30, :116:26
        state_5 = _RANDOM[/*Zero width*/ 1'b0][21];	// Arbiter.scala:87:30, :116:26
        state_6 = _RANDOM[/*Zero width*/ 1'b0][22];	// Arbiter.scala:87:30, :116:26
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  TLMonitor_29 monitor (	// Nodes.scala:24:25
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (_portsAOI_in_0_a_ready_WIRE),	// Mux.scala:27:72
    .io_in_a_valid        (auto_in_a_valid),
    .io_in_a_bits_opcode  (auto_in_a_bits_opcode),
    .io_in_a_bits_param   (auto_in_a_bits_param),
    .io_in_a_bits_size    (auto_in_a_bits_size),
    .io_in_a_bits_source  (auto_in_a_bits_source),
    .io_in_a_bits_address (auto_in_a_bits_address),
    .io_in_a_bits_mask    (auto_in_a_bits_mask),
    .io_in_a_bits_corrupt (auto_in_a_bits_corrupt),
    .io_in_d_ready        (auto_in_d_ready),
    .io_in_d_valid        (out_24_valid),	// Arbiter.scala:125:29
    .io_in_d_bits_opcode  (out_24_bits_opcode),	// Mux.scala:27:72
    .io_in_d_bits_param   (out_24_bits_param),	// Mux.scala:27:72
    .io_in_d_bits_size    (out_24_bits_size),	// Mux.scala:27:72
    .io_in_d_bits_source  (out_24_bits_source),	// Mux.scala:27:72
    .io_in_d_bits_sink    (out_24_bits_sink),	// Mux.scala:27:72
    .io_in_d_bits_denied  (out_24_bits_denied),	// Mux.scala:27:72
    .io_in_d_bits_corrupt (out_24_bits_corrupt)	// Mux.scala:27:72
  );
  assign auto_in_a_ready = _portsAOI_in_0_a_ready_WIRE;	// Mux.scala:27:72
  assign auto_in_d_valid = out_24_valid;	// Arbiter.scala:125:29
  assign auto_in_d_bits_opcode = out_24_bits_opcode;	// Mux.scala:27:72
  assign auto_in_d_bits_param = out_24_bits_param;	// Mux.scala:27:72
  assign auto_in_d_bits_size = out_24_bits_size;	// Mux.scala:27:72
  assign auto_in_d_bits_source = out_24_bits_source;	// Mux.scala:27:72
  assign auto_in_d_bits_sink = out_24_bits_sink;	// Mux.scala:27:72
  assign auto_in_d_bits_denied = out_24_bits_denied;	// Mux.scala:27:72
  assign auto_in_d_bits_data =
    (muxStateEarly_0 ? auto_out_0_d_bits_data : 64'h0)
    | (muxStateEarly_1 ? auto_out_1_d_bits_data : 64'h0)
    | (muxStateEarly_2 ? auto_out_2_d_bits_data : 64'h0)
    | (muxStateEarly_3 ? auto_out_3_d_bits_data : 64'h0)
    | (muxStateEarly_4 ? auto_out_4_d_bits_data : 64'h0)
    | (muxStateEarly_5 ? auto_out_5_d_bits_data : 64'h0)
    | (muxStateEarly_6 ? auto_out_6_d_bits_data : 64'h0);	// Arbiter.scala:117:30, Bundles.scala:257:54, Mux.scala:27:72
  assign auto_in_d_bits_corrupt = out_24_bits_corrupt;	// Mux.scala:27:72
  assign auto_out_6_a_valid = auto_in_a_valid & requestAIO_0_6;	// Parameters.scala:137:{49,52,67}, Xbar.scala:428:50
  assign auto_out_6_a_bits_size = auto_in_a_bits_size[2:0];	// BundleMap.scala:247:19
  assign auto_out_6_a_bits_address = auto_in_a_bits_address[16:0];	// BundleMap.scala:247:19
  assign auto_out_6_d_ready = auto_in_d_ready & (idle ? readys_readys[6] : state_6);	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24, :123:31
  assign auto_out_5_a_valid = auto_in_a_valid & requestAIO_0_5;	// Parameters.scala:137:{49,52,67}, Xbar.scala:428:50
  assign auto_out_5_a_bits_size = auto_in_a_bits_size[2:0];	// BundleMap.scala:247:19
  assign auto_out_5_a_bits_address = auto_in_a_bits_address[11:0];	// BundleMap.scala:247:19
  assign auto_out_5_d_ready = auto_in_d_ready & (idle ? readys_readys[5] : state_5);	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24, :123:31
  assign auto_out_4_a_valid = auto_in_a_valid & requestAIO_0_4;	// Parameters.scala:137:{49,52,67}, Xbar.scala:428:50
  assign auto_out_4_a_bits_size = auto_in_a_bits_size[2:0];	// BundleMap.scala:247:19
  assign auto_out_4_a_bits_address = auto_in_a_bits_address[25:0];	// BundleMap.scala:247:19
  assign auto_out_4_d_ready = auto_in_d_ready & (idle ? readys_readys[4] : state_4);	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24, :123:31
  assign auto_out_3_a_valid = auto_in_a_valid & requestAIO_0_3;	// Parameters.scala:137:{49,52,67}, Xbar.scala:428:50
  assign auto_out_3_a_bits_size = auto_in_a_bits_size[2:0];	// BundleMap.scala:247:19
  assign auto_out_3_a_bits_address = auto_in_a_bits_address[27:0];	// BundleMap.scala:247:19
  assign auto_out_3_d_ready = auto_in_d_ready & (idle ? readys_readys[3] : state_3);	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24, :123:31
  assign auto_out_2_a_valid = auto_in_a_valid & requestAIO_0_2;	// Xbar.scala:363:92, :428:50
  assign auto_out_2_a_bits_size = auto_in_a_bits_size[2:0];	// BundleMap.scala:247:19
  assign auto_out_2_d_ready = auto_in_d_ready & (idle ? readys_readys[2] : state_2);	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24, :123:31
  assign auto_out_1_a_valid = auto_in_a_valid & requestAIO_0_1;	// Parameters.scala:137:{49,52,67}, Xbar.scala:428:50
  assign auto_out_1_a_bits_size = auto_in_a_bits_size[2:0];	// BundleMap.scala:247:19
  assign auto_out_1_a_bits_address = auto_in_a_bits_address[25:0];	// BundleMap.scala:247:19
  assign auto_out_1_d_ready = auto_in_d_ready & (idle ? readys_readys[1] : state_1);	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24, :123:31
  assign auto_out_0_a_valid = auto_in_a_valid & requestAIO_0_0;	// Parameters.scala:137:{49,52,67}, Xbar.scala:428:50
  assign auto_out_0_a_bits_address = auto_in_a_bits_address[13:0];	// BundleMap.scala:247:19
  assign auto_out_0_d_ready = auto_in_d_ready & (idle ? readys_readys[0] : state_0);	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24, :123:31
endmodule

