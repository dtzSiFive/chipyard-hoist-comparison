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

module TLCacheCork(
  input         clock,
                reset,
                auto_in_a_valid,
  input  [2:0]  auto_in_a_bits_opcode,
                auto_in_a_bits_param,
                auto_in_a_bits_size,
                auto_in_a_bits_source,
  input  [31:0] auto_in_a_bits_address,
  input  [7:0]  auto_in_a_bits_mask,
  input  [63:0] auto_in_a_bits_data,
  input         auto_in_a_bits_corrupt,
                auto_in_c_valid,
  input  [2:0]  auto_in_c_bits_opcode,
                auto_in_c_bits_param,
                auto_in_c_bits_size,
                auto_in_c_bits_source,
  input  [31:0] auto_in_c_bits_address,
  input  [63:0] auto_in_c_bits_data,
  input         auto_in_c_bits_corrupt,
                auto_in_d_ready,
                auto_in_e_valid,
  input  [2:0]  auto_in_e_bits_sink,
  input         auto_out_a_ready,
                auto_out_d_valid,
  input  [2:0]  auto_out_d_bits_opcode,
  input  [1:0]  auto_out_d_bits_param,
  input  [2:0]  auto_out_d_bits_size,
  input  [3:0]  auto_out_d_bits_source,
  input         auto_out_d_bits_denied,
  input  [63:0] auto_out_d_bits_data,
  input         auto_out_d_bits_corrupt,
  output        auto_in_a_ready,
                auto_in_c_ready,
                auto_in_d_valid,
  output [2:0]  auto_in_d_bits_opcode,
  output [1:0]  auto_in_d_bits_param,
  output [2:0]  auto_in_d_bits_size,
                auto_in_d_bits_source,
                auto_in_d_bits_sink,
  output        auto_in_d_bits_denied,
  output [63:0] auto_in_d_bits_data,
  output        auto_in_d_bits_corrupt,
                auto_out_a_valid,
  output [2:0]  auto_out_a_bits_opcode,
                auto_out_a_bits_param,
                auto_out_a_bits_size,
  output [3:0]  auto_out_a_bits_source,
  output [31:0] auto_out_a_bits_address,
  output [7:0]  auto_out_a_bits_mask,
  output [63:0] auto_out_a_bits_data,
  output        auto_out_a_bits_corrupt,
                auto_out_d_ready
);

  wire [2:0]  out_6_bits_opcode;	// Mux.scala:27:72
  wire        out_6_valid;	// Arbiter.scala:125:29
  wire        out_1_ready;	// Arbiter.scala:123:31
  wire        out_ready;	// Arbiter.scala:123:31
  wire        bundleIn_0_d_valid;	// CacheCork.scala:125:34
  wire        _q_1_io_enq_ready;	// Decoupled.scala:296:21
  wire        _q_1_io_deq_valid;	// Decoupled.scala:296:21
  wire [2:0]  _q_1_io_deq_bits_opcode;	// Decoupled.scala:296:21
  wire [1:0]  _q_1_io_deq_bits_param;	// Decoupled.scala:296:21
  wire [2:0]  _q_1_io_deq_bits_size;	// Decoupled.scala:296:21
  wire [2:0]  _q_1_io_deq_bits_source;	// Decoupled.scala:296:21
  wire        _q_1_io_deq_bits_denied;	// Decoupled.scala:296:21
  wire [63:0] _q_1_io_deq_bits_data;	// Decoupled.scala:296:21
  wire        _q_1_io_deq_bits_corrupt;	// Decoupled.scala:296:21
  wire        _q_io_enq_ready;	// Decoupled.scala:296:21
  wire        _q_io_deq_valid;	// Decoupled.scala:296:21
  wire [2:0]  _q_io_deq_bits_opcode;	// Decoupled.scala:296:21
  wire [1:0]  _q_io_deq_bits_param;	// Decoupled.scala:296:21
  wire [2:0]  _q_io_deq_bits_size;	// Decoupled.scala:296:21
  wire [2:0]  _q_io_deq_bits_source;	// Decoupled.scala:296:21
  wire        _q_io_deq_bits_denied;	// Decoupled.scala:296:21
  wire [63:0] _q_io_deq_bits_data;	// Decoupled.scala:296:21
  wire        _q_io_deq_bits_corrupt;	// Decoupled.scala:296:21
  wire        _pool_io_alloc_valid;	// CacheCork.scala:117:26
  wire [2:0]  _pool_io_alloc_bits;	// CacheCork.scala:117:26
  wire        _toD_T = auto_in_a_bits_opcode == 3'h6;	// CacheCork.scala:67:37
  wire        toD = _toD_T & auto_in_a_bits_param == 3'h2 | (&auto_in_a_bits_opcode);	// CacheCork.scala:67:{37,54,73,97}, :68:37, :144:40
  wire        bundleIn_0_a_ready = toD ? _q_1_io_enq_ready : out_1_ready;	// Arbiter.scala:123:31, CacheCork.scala:67:97, :69:26, Decoupled.scala:296:21
  wire        validQuals_1 = auto_in_a_valid & ~toD;	// CacheCork.scala:67:97, :71:{33,36}
  wire        _GEN = _toD_T | (&auto_in_a_bits_opcode);	// CacheCork.scala:67:37, :68:37, :76:49
  wire [2:0]  out_1_bits_opcode = _GEN ? 3'h4 : auto_in_a_bits_opcode;	// CacheCork.scala:72:18, :76:{49,86}, :77:27
  wire        winnerQual_0 = auto_in_c_valid & (&auto_in_c_bits_opcode);	// CacheCork.scala:92:{33,53}
  wire        _c_a_bits_a_mask_T = auto_in_c_bits_size > 3'h2;	// CacheCork.scala:144:40, Misc.scala:205:21
  wire        c_a_bits_a_mask_size = auto_in_c_bits_size[1:0] == 2'h2;	// Misc.scala:208:26, OneHot.scala:64:49, :65:12
  wire        c_a_bits_a_mask_acc =
    _c_a_bits_a_mask_T | c_a_bits_a_mask_size & ~(auto_in_c_bits_address[2]);	// Misc.scala:205:21, :208:26, :209:26, :210:20, :214:{29,38}
  wire        c_a_bits_a_mask_acc_1 =
    _c_a_bits_a_mask_T | c_a_bits_a_mask_size & auto_in_c_bits_address[2];	// Misc.scala:205:21, :208:26, :209:26, :214:{29,38}
  wire        c_a_bits_a_mask_size_1 = auto_in_c_bits_size[1:0] == 2'h1;	// CacheCork.scala:154:32, Misc.scala:208:26, OneHot.scala:64:49
  wire        c_a_bits_a_mask_eq_2 =
    ~(auto_in_c_bits_address[2]) & ~(auto_in_c_bits_address[1]);	// Misc.scala:209:26, :210:20, :213:27
  wire        c_a_bits_a_mask_acc_2 =
    c_a_bits_a_mask_acc | c_a_bits_a_mask_size_1 & c_a_bits_a_mask_eq_2;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        c_a_bits_a_mask_eq_3 =
    ~(auto_in_c_bits_address[2]) & auto_in_c_bits_address[1];	// Misc.scala:209:26, :210:20, :213:27
  wire        c_a_bits_a_mask_acc_3 =
    c_a_bits_a_mask_acc | c_a_bits_a_mask_size_1 & c_a_bits_a_mask_eq_3;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        c_a_bits_a_mask_eq_4 =
    auto_in_c_bits_address[2] & ~(auto_in_c_bits_address[1]);	// Misc.scala:209:26, :210:20, :213:27
  wire        c_a_bits_a_mask_acc_4 =
    c_a_bits_a_mask_acc_1 | c_a_bits_a_mask_size_1 & c_a_bits_a_mask_eq_4;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        c_a_bits_a_mask_eq_5 =
    auto_in_c_bits_address[2] & auto_in_c_bits_address[1];	// Misc.scala:209:26, :213:27
  wire        c_a_bits_a_mask_acc_5 =
    c_a_bits_a_mask_acc_1 | c_a_bits_a_mask_size_1 & c_a_bits_a_mask_eq_5;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        _bundleIn_0_c_ready_T = auto_in_c_bits_opcode == 3'h6;	// CacheCork.scala:67:37, :103:53
  wire        bundleIn_0_c_ready = _bundleIn_0_c_ready_T ? _q_io_enq_ready : out_ready;	// Arbiter.scala:123:31, CacheCork.scala:103:53, :107:26, Decoupled.scala:296:21
  reg  [2:0]  d_first_counter;	// Edges.scala:228:27
  wire        d_grant = out_6_bits_opcode == 3'h5 | out_6_bits_opcode == 3'h4;	// CacheCork.scala:77:27, :123:{40,54,74}, Mux.scala:27:72
  assign bundleIn_0_d_valid =
    out_6_valid & (_pool_io_alloc_valid | (|d_first_counter) | ~d_grant);	// Arbiter.scala:125:29, CacheCork.scala:117:26, :123:54, :125:{34,70,73}, Edges.scala:228:27, :230:25
  wire        out_6_ready =
    auto_in_d_ready & (_pool_io_alloc_valid | (|d_first_counter) | ~d_grant);	// CacheCork.scala:117:26, :123:54, :125:73, :126:{34,70}, Edges.scala:228:27, :230:25
  reg  [2:0]  bundleIn_0_d_bits_sink_r;	// Reg.scala:15:16
  wire [2:0]  bundleIn_0_d_bits_sink =
    (|d_first_counter) ? bundleIn_0_d_bits_sink_r : _pool_io_alloc_bits;	// CacheCork.scala:117:26, Edges.scala:228:27, :230:25, Reg.scala:15:16, package.scala:79:42
  reg         wSourceVec_0;	// CacheCork.scala:137:29
  reg         wSourceVec_1;	// CacheCork.scala:137:29
  reg         wSourceVec_2;	// CacheCork.scala:137:29
  reg         wSourceVec_3;	// CacheCork.scala:137:29
  reg         wSourceVec_4;	// CacheCork.scala:137:29
  wire [7:0]  _GEN_0 =
    {{wSourceVec_0},
     {wSourceVec_0},
     {wSourceVec_0},
     {wSourceVec_4},
     {wSourceVec_3},
     {wSourceVec_2},
     {wSourceVec_1},
     {wSourceVec_0}};	// CacheCork.scala:137:29, :141:25
  wire        _GEN_1 = _GEN_0[auto_out_d_bits_source[3:1]];	// CacheCork.scala:133:46, :141:25
  reg         dWHeld_r;	// Reg.scala:15:16
  wire        _GEN_2 = auto_out_d_bits_opcode == 3'h1 & auto_out_d_bits_source[0];	// CacheCork.scala:144:40, :152:{33,51,71}
  wire [2:0]  out_3_bits_opcode =
    auto_out_d_bits_opcode == 3'h0 & ~(auto_out_d_bits_source[0])
      ? 3'h6
      : _GEN_2 ? 3'h5 : auto_out_d_bits_opcode;	// CacheCork.scala:67:37, :123:40, :132:13, :152:{51,71,76}, :153:27, :156:{33,47,50,73}, :157:27, Nodes.scala:1210:84
  reg  [2:0]  beatsLeft;	// Arbiter.scala:87:30
  wire        idle = beatsLeft == 3'h0;	// Arbiter.scala:87:30, :88:28, Nodes.scala:1210:84
  wire        earlyWinner_1 = ~winnerQual_0 & validQuals_1;	// Arbiter.scala:16:61, :97:79, CacheCork.scala:71:33, :92:33
  wire        _sink_ACancel_earlyValid_T = winnerQual_0 | validQuals_1;	// Arbiter.scala:107:36, CacheCork.scala:71:33, :92:33
  reg         state_0;	// Arbiter.scala:116:26
  reg         state_1;	// Arbiter.scala:116:26
  wire        muxStateEarly_0 = idle ? winnerQual_0 : state_0;	// Arbiter.scala:88:28, :116:26, :117:30, CacheCork.scala:92:33
  wire        muxStateEarly_1 = idle ? earlyWinner_1 : state_1;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  assign out_ready = auto_out_a_ready & (idle | state_0);	// Arbiter.scala:88:28, :116:26, :121:24, :123:31
  assign out_1_ready = auto_out_a_ready & (idle ? ~winnerQual_0 : state_1);	// Arbiter.scala:16:61, :88:28, :116:26, :121:24, :123:31, CacheCork.scala:92:33
  wire        out_2_valid =
    idle ? _sink_ACancel_earlyValid_T : state_0 & winnerQual_0 | state_1 & validQuals_1;	// Arbiter.scala:88:28, :107:36, :116:26, :125:29, CacheCork.scala:71:33, :92:33, Mux.scala:27:72
  reg  [2:0]  beatsLeft_1;	// Arbiter.scala:87:30
  wire        idle_1 = beatsLeft_1 == 3'h0;	// Arbiter.scala:87:30, :88:28, Nodes.scala:1210:84
  wire        _GEN_3 = _q_io_deq_valid | auto_out_d_valid;	// Decoupled.scala:296:21, package.scala:244:43
  wire        earlyWinner_1_1 = ~auto_out_d_valid & _q_io_deq_valid;	// Arbiter.scala:16:61, :97:79, Decoupled.scala:296:21
  wire        earlyWinner_1_2 = ~_GEN_3 & _q_1_io_deq_valid;	// Arbiter.scala:16:61, :97:79, Decoupled.scala:296:21, package.scala:244:43
  wire        _sink_ACancel_earlyValid_T_5 = auto_out_d_valid | _q_io_deq_valid;	// Arbiter.scala:107:36, Decoupled.scala:296:21
  `ifndef SYNTHESIS	// CacheCork.scala:106:16
    always @(posedge clock) begin	// CacheCork.scala:106:16
      if (~(~auto_in_c_valid | _bundleIn_0_c_ready_T | (&auto_in_c_bits_opcode)
            | reset)) begin	// CacheCork.scala:92:53, :103:53, :106:{16,17}
        if (`ASSERT_VERBOSE_COND_)	// CacheCork.scala:106:16
          $error("Assertion failed\n    at CacheCork.scala:106 assert (!in.c.valid || in.c.bits.opcode === Release || in.c.bits.opcode === ReleaseData)\n");	// CacheCork.scala:106:16
        if (`STOP_COND_)	// CacheCork.scala:106:16
          $fatal;	// CacheCork.scala:106:16
      end
      if (~(~winnerQual_0 | ~earlyWinner_1 | reset)) begin	// Arbiter.scala:97:79, :105:{13,61,67}, CacheCork.scala:92:33
        if (`ASSERT_VERBOSE_COND_)	// Arbiter.scala:105:13
          $error("Assertion failed\n    at Arbiter.scala:105 assert((prefixOR zip earlyWinner) map { case (p,w) => !p || !w } reduce {_ && _})\n");	// Arbiter.scala:105:13
        if (`STOP_COND_)	// Arbiter.scala:105:13
          $fatal;	// Arbiter.scala:105:13
      end
      if (~(~_sink_ACancel_earlyValid_T | winnerQual_0 | earlyWinner_1 | reset)) begin	// Arbiter.scala:97:79, :107:{14,15,36}, CacheCork.scala:92:33
        if (`ASSERT_VERBOSE_COND_)	// Arbiter.scala:107:14
          $error("Assertion failed\n    at Arbiter.scala:107 assert (!earlyValids.reduce(_||_) || earlyWinner.reduce(_||_))\n");	// Arbiter.scala:107:14
        if (`STOP_COND_)	// Arbiter.scala:107:14
          $fatal;	// Arbiter.scala:107:14
      end
      if (~((~auto_out_d_valid | ~earlyWinner_1_1)
            & (~(auto_out_d_valid | earlyWinner_1_1) | ~earlyWinner_1_2) | reset)) begin	// Arbiter.scala:97:79, :104:53, :105:{13,61,64,67,82}
        if (`ASSERT_VERBOSE_COND_)	// Arbiter.scala:105:13
          $error("Assertion failed\n    at Arbiter.scala:105 assert((prefixOR zip earlyWinner) map { case (p,w) => !p || !w } reduce {_ && _})\n");	// Arbiter.scala:105:13
        if (`STOP_COND_)	// Arbiter.scala:105:13
          $fatal;	// Arbiter.scala:105:13
      end
      if (~(~(_sink_ACancel_earlyValid_T_5 | _q_1_io_deq_valid) | auto_out_d_valid
            | earlyWinner_1_1 | earlyWinner_1_2 | reset)) begin	// Arbiter.scala:97:79, :107:{14,15,36}, Decoupled.scala:296:21
        if (`ASSERT_VERBOSE_COND_)	// Arbiter.scala:107:14
          $error("Assertion failed\n    at Arbiter.scala:107 assert (!earlyValids.reduce(_||_) || earlyWinner.reduce(_||_))\n");	// Arbiter.scala:107:14
        if (`STOP_COND_)	// Arbiter.scala:107:14
          $fatal;	// Arbiter.scala:107:14
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  reg         state_1_0;	// Arbiter.scala:116:26
  reg         state_1_1;	// Arbiter.scala:116:26
  reg         state_1_2;	// Arbiter.scala:116:26
  wire        muxStateEarly_1_0 = idle_1 ? auto_out_d_valid : state_1_0;	// Arbiter.scala:88:28, :116:26, :117:30
  wire        muxStateEarly_1_1 = idle_1 ? earlyWinner_1_1 : state_1_1;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        muxStateEarly_1_2 = idle_1 ? earlyWinner_1_2 : state_1_2;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  assign out_6_valid =
    idle_1
      ? _sink_ACancel_earlyValid_T_5 | _q_1_io_deq_valid
      : state_1_0 & auto_out_d_valid | state_1_1 & _q_io_deq_valid | state_1_2
        & _q_1_io_deq_valid;	// Arbiter.scala:88:28, :107:36, :116:26, :125:{29,56}, Decoupled.scala:296:21, Mux.scala:27:72
  wire        out_6_bits_corrupt =
    muxStateEarly_1_0 & auto_out_d_bits_corrupt | muxStateEarly_1_1
    & _q_io_deq_bits_corrupt | muxStateEarly_1_2 & _q_1_io_deq_bits_corrupt;	// Arbiter.scala:117:30, Decoupled.scala:296:21, Mux.scala:27:72
  wire        out_6_bits_denied =
    muxStateEarly_1_0 & auto_out_d_bits_denied | muxStateEarly_1_1 & _q_io_deq_bits_denied
    | muxStateEarly_1_2 & _q_1_io_deq_bits_denied;	// Arbiter.scala:117:30, Decoupled.scala:296:21, Mux.scala:27:72
  wire [2:0]  out_6_bits_source =
    (muxStateEarly_1_0 ? auto_out_d_bits_source[3:1] : 3'h0)
    | (muxStateEarly_1_1 ? _q_io_deq_bits_source : 3'h0)
    | (muxStateEarly_1_2 ? _q_1_io_deq_bits_source : 3'h0);	// Arbiter.scala:117:30, CacheCork.scala:133:46, Decoupled.scala:296:21, Mux.scala:27:72, Nodes.scala:1210:84
  wire [2:0]  out_6_bits_size =
    (muxStateEarly_1_0 ? auto_out_d_bits_size : 3'h0)
    | (muxStateEarly_1_1 ? _q_io_deq_bits_size : 3'h0)
    | (muxStateEarly_1_2 ? _q_1_io_deq_bits_size : 3'h0);	// Arbiter.scala:117:30, Decoupled.scala:296:21, Mux.scala:27:72, Nodes.scala:1210:84
  wire [1:0]  out_6_bits_param =
    (muxStateEarly_1_0
       ? (_GEN_2
            ? {1'h0, ~((|d_first_counter) ? dWHeld_r : _GEN_1)}
            : auto_out_d_bits_param)
       : 2'h0) | (muxStateEarly_1_1 ? _q_io_deq_bits_param : 2'h0)
    | (muxStateEarly_1_2 ? _q_1_io_deq_bits_param : 2'h0);	// Arbiter.scala:117:30, CacheCork.scala:132:13, :141:25, :152:{51,76}, :154:{26,32}, Decoupled.scala:296:21, Edges.scala:228:27, :230:25, Mux.scala:27:72, Nodes.scala:1210:84, Reg.scala:15:16, package.scala:79:42
  assign out_6_bits_opcode =
    (muxStateEarly_1_0 ? out_3_bits_opcode : 3'h0)
    | (muxStateEarly_1_1 ? _q_io_deq_bits_opcode : 3'h0)
    | (muxStateEarly_1_2 ? _q_1_io_deq_bits_opcode : 3'h0);	// Arbiter.scala:117:30, CacheCork.scala:152:76, :156:73, :157:27, Decoupled.scala:296:21, Mux.scala:27:72, Nodes.scala:1210:84
  always @(posedge clock) begin
    automatic logic aWOk;	// Parameters.scala:615:89
    automatic logic _GEN_4 = bundleIn_0_a_ready & auto_in_a_valid;	// CacheCork.scala:69:26, Decoupled.scala:40:37
    aWOk =
      {auto_in_a_bits_address[31], ~(auto_in_a_bits_address[28])} == 2'h0
      | {~(auto_in_a_bits_address[31]), auto_in_a_bits_address[28]} == 2'h0;	// Nodes.scala:1210:84, Parameters.scala:137:{31,49,52,67}, :615:89
    if (reset) begin
      d_first_counter <= 3'h0;	// Edges.scala:228:27, Nodes.scala:1210:84
      beatsLeft <= 3'h0;	// Arbiter.scala:87:30, Nodes.scala:1210:84
      state_0 <= 1'h0;	// Arbiter.scala:116:26
      state_1 <= 1'h0;	// Arbiter.scala:116:26
      beatsLeft_1 <= 3'h0;	// Arbiter.scala:87:30, Nodes.scala:1210:84
      state_1_0 <= 1'h0;	// Arbiter.scala:116:26
      state_1_1 <= 1'h0;	// Arbiter.scala:116:26
      state_1_2 <= 1'h0;	// Arbiter.scala:116:26
    end
    else begin
      automatic logic winnerQual_1;	// Arbiter.scala:98:79
      winnerQual_1 = ~winnerQual_0 & validQuals_1;	// Arbiter.scala:16:61, :98:79, CacheCork.scala:71:33, :92:33
      if (out_6_ready & out_6_valid) begin	// Arbiter.scala:125:29, CacheCork.scala:126:34, Decoupled.scala:40:37
        if (|d_first_counter)	// Edges.scala:228:27, :230:25
          d_first_counter <= d_first_counter - 3'h1;	// Edges.scala:228:27, :229:28
        else if (out_6_bits_opcode[0]) begin	// Edges.scala:105:36, Mux.scala:27:72
          automatic logic [12:0] _d_first_beats1_decode_T_1 = 13'h3F << out_6_bits_size;	// Mux.scala:27:72, package.scala:234:77
          d_first_counter <= ~(_d_first_beats1_decode_T_1[5:3]);	// Edges.scala:228:27, package.scala:234:{46,77,82}
        end
        else	// Edges.scala:105:36
          d_first_counter <= 3'h0;	// Edges.scala:228:27, Nodes.scala:1210:84
      end
      if (idle & auto_out_a_ready) begin	// Arbiter.scala:88:28, :89:24
        automatic logic [12:0] _decode_T_5 = 13'h3F << auto_in_a_bits_size;	// package.scala:234:77
        automatic logic [12:0] _decode_T_1 = 13'h3F << auto_in_c_bits_size;	// package.scala:234:77
        beatsLeft <=
          (winnerQual_0 ? ~(_decode_T_1[5:3]) : 3'h0)
          | (winnerQual_1 & ~(out_1_bits_opcode[2]) ? ~(_decode_T_5[5:3]) : 3'h0);	// Arbiter.scala:87:30, :98:79, :111:73, :112:44, CacheCork.scala:72:18, :76:86, :77:27, :92:33, Edges.scala:91:{28,37}, :220:14, Nodes.scala:1210:84, package.scala:234:{46,77,82}
      end
      else	// Arbiter.scala:89:24
        beatsLeft <= beatsLeft - {2'h0, auto_out_a_ready & out_2_valid};	// Arbiter.scala:87:30, :113:52, :125:29, Nodes.scala:1210:84, ReadyValidCancel.scala:50:33
      if (idle) begin	// Arbiter.scala:88:28
        state_0 <= winnerQual_0;	// Arbiter.scala:116:26, CacheCork.scala:92:33
        state_1 <= winnerQual_1;	// Arbiter.scala:98:79, :116:26
      end
      if (idle_1 & out_6_ready) begin	// Arbiter.scala:88:28, :89:24, CacheCork.scala:126:34
        if (auto_out_d_valid & out_3_bits_opcode[0]) begin	// Arbiter.scala:111:73, CacheCork.scala:152:76, :156:73, :157:27, Edges.scala:105:36, :220:14
          automatic logic [12:0] _decode_T_9 = 13'h3F << auto_out_d_bits_size;	// package.scala:234:77
          beatsLeft_1 <= ~(_decode_T_9[5:3]);	// Arbiter.scala:87:30, package.scala:234:{46,77,82}
        end
        else	// Arbiter.scala:111:73, Edges.scala:220:14
          beatsLeft_1 <= 3'h0;	// Arbiter.scala:87:30, Nodes.scala:1210:84
      end
      else	// Arbiter.scala:89:24
        beatsLeft_1 <= beatsLeft_1 - {2'h0, out_6_ready & out_6_valid};	// Arbiter.scala:87:30, :113:52, :125:29, CacheCork.scala:126:34, Nodes.scala:1210:84, ReadyValidCancel.scala:50:33
      if (idle_1) begin	// Arbiter.scala:88:28
        state_1_0 <= auto_out_d_valid;	// Arbiter.scala:116:26
        state_1_1 <= ~auto_out_d_valid & _q_io_deq_valid;	// Arbiter.scala:16:61, :98:79, :116:26, Decoupled.scala:296:21
        state_1_2 <= ~_GEN_3 & _q_1_io_deq_valid;	// Arbiter.scala:16:61, :98:79, :116:26, Decoupled.scala:296:21, package.scala:244:43
      end
    end
    if (~(|d_first_counter)) begin	// Edges.scala:228:27, :230:25
      bundleIn_0_d_bits_sink_r <= _pool_io_alloc_bits;	// CacheCork.scala:117:26, Reg.scala:15:16
      dWHeld_r <= _GEN_1;	// CacheCork.scala:141:25, Reg.scala:15:16
    end
    if (_GEN_4 & auto_in_a_bits_source == 3'h0)	// CacheCork.scala:137:29, :143:28, :144:40, Decoupled.scala:40:37, Nodes.scala:1210:84
      wSourceVec_0 <= aWOk;	// CacheCork.scala:137:29, Parameters.scala:615:89
    if (_GEN_4 & auto_in_a_bits_source == 3'h1)	// CacheCork.scala:137:29, :143:28, :144:40, Decoupled.scala:40:37
      wSourceVec_1 <= aWOk;	// CacheCork.scala:137:29, Parameters.scala:615:89
    if (_GEN_4 & auto_in_a_bits_source == 3'h2)	// CacheCork.scala:137:29, :143:28, :144:40, Decoupled.scala:40:37
      wSourceVec_2 <= aWOk;	// CacheCork.scala:137:29, Parameters.scala:615:89
    if (_GEN_4 & auto_in_a_bits_source == 3'h3)	// CacheCork.scala:137:29, :143:28, :144:40, Decoupled.scala:40:37
      wSourceVec_3 <= aWOk;	// CacheCork.scala:137:29, Parameters.scala:615:89
    if (_GEN_4 & auto_in_a_bits_source == 3'h4)	// CacheCork.scala:77:27, :137:29, :143:28, :144:40, Decoupled.scala:40:37
      wSourceVec_4 <= aWOk;	// CacheCork.scala:137:29, Parameters.scala:615:89
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
        d_first_counter = _RANDOM[/*Zero width*/ 1'b0][2:0];	// Edges.scala:228:27
        bundleIn_0_d_bits_sink_r = _RANDOM[/*Zero width*/ 1'b0][5:3];	// Edges.scala:228:27, Reg.scala:15:16
        wSourceVec_0 = _RANDOM[/*Zero width*/ 1'b0][6];	// CacheCork.scala:137:29, Edges.scala:228:27
        wSourceVec_1 = _RANDOM[/*Zero width*/ 1'b0][7];	// CacheCork.scala:137:29, Edges.scala:228:27
        wSourceVec_2 = _RANDOM[/*Zero width*/ 1'b0][8];	// CacheCork.scala:137:29, Edges.scala:228:27
        wSourceVec_3 = _RANDOM[/*Zero width*/ 1'b0][9];	// CacheCork.scala:137:29, Edges.scala:228:27
        wSourceVec_4 = _RANDOM[/*Zero width*/ 1'b0][10];	// CacheCork.scala:137:29, Edges.scala:228:27
        dWHeld_r = _RANDOM[/*Zero width*/ 1'b0][11];	// Edges.scala:228:27, Reg.scala:15:16
        beatsLeft = _RANDOM[/*Zero width*/ 1'b0][14:12];	// Arbiter.scala:87:30, Edges.scala:228:27
        state_0 = _RANDOM[/*Zero width*/ 1'b0][15];	// Arbiter.scala:116:26, Edges.scala:228:27
        state_1 = _RANDOM[/*Zero width*/ 1'b0][16];	// Arbiter.scala:116:26, Edges.scala:228:27
        beatsLeft_1 = _RANDOM[/*Zero width*/ 1'b0][19:17];	// Arbiter.scala:87:30, Edges.scala:228:27
        state_1_0 = _RANDOM[/*Zero width*/ 1'b0][20];	// Arbiter.scala:116:26, Edges.scala:228:27
        state_1_1 = _RANDOM[/*Zero width*/ 1'b0][21];	// Arbiter.scala:116:26, Edges.scala:228:27
        state_1_2 = _RANDOM[/*Zero width*/ 1'b0][22];	// Arbiter.scala:116:26, Edges.scala:228:27
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  TLMonitor_48 monitor (	// Nodes.scala:24:25
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (bundleIn_0_a_ready),	// CacheCork.scala:69:26
    .io_in_a_valid        (auto_in_a_valid),
    .io_in_a_bits_opcode  (auto_in_a_bits_opcode),
    .io_in_a_bits_param   (auto_in_a_bits_param),
    .io_in_a_bits_size    (auto_in_a_bits_size),
    .io_in_a_bits_source  (auto_in_a_bits_source),
    .io_in_a_bits_address (auto_in_a_bits_address),
    .io_in_a_bits_mask    (auto_in_a_bits_mask),
    .io_in_a_bits_corrupt (auto_in_a_bits_corrupt),
    .io_in_c_ready        (bundleIn_0_c_ready),	// CacheCork.scala:107:26
    .io_in_c_valid        (auto_in_c_valid),
    .io_in_c_bits_opcode  (auto_in_c_bits_opcode),
    .io_in_c_bits_param   (auto_in_c_bits_param),
    .io_in_c_bits_size    (auto_in_c_bits_size),
    .io_in_c_bits_source  (auto_in_c_bits_source),
    .io_in_c_bits_address (auto_in_c_bits_address),
    .io_in_c_bits_corrupt (auto_in_c_bits_corrupt),
    .io_in_d_ready        (auto_in_d_ready),
    .io_in_d_valid        (bundleIn_0_d_valid),	// CacheCork.scala:125:34
    .io_in_d_bits_opcode  (out_6_bits_opcode),	// Mux.scala:27:72
    .io_in_d_bits_param   (out_6_bits_param),	// Mux.scala:27:72
    .io_in_d_bits_size    (out_6_bits_size),	// Mux.scala:27:72
    .io_in_d_bits_source  (out_6_bits_source),	// Mux.scala:27:72
    .io_in_d_bits_sink    (bundleIn_0_d_bits_sink),	// package.scala:79:42
    .io_in_d_bits_denied  (out_6_bits_denied),	// Mux.scala:27:72
    .io_in_d_bits_corrupt (out_6_bits_corrupt),	// Mux.scala:27:72
    .io_in_e_valid        (auto_in_e_valid),
    .io_in_e_bits_sink    (auto_in_e_bits_sink)
  );
  IDPool pool (	// CacheCork.scala:117:26
    .clock          (clock),
    .reset          (reset),
    .io_free_valid  (auto_in_e_valid),
    .io_free_bits   (auto_in_e_bits_sink),
    .io_alloc_ready
      (auto_in_d_ready & bundleIn_0_d_valid & ~(|d_first_counter) & d_grant),	// CacheCork.scala:123:54, :124:55, :125:34, Edges.scala:228:27, :230:25
    .io_alloc_valid (_pool_io_alloc_valid),
    .io_alloc_bits  (_pool_io_alloc_bits)
  );
  Queue_25 q (	// Decoupled.scala:296:21
    .clock               (clock),
    .reset               (reset),
    .io_enq_valid        (auto_in_c_valid & _bundleIn_0_c_ready_T),	// CacheCork.scala:103:{33,53}
    .io_enq_bits_opcode  (3'h6),	// CacheCork.scala:67:37
    .io_enq_bits_param   (2'h0),	// Nodes.scala:1210:84
    .io_enq_bits_size    (auto_in_c_bits_size),
    .io_enq_bits_source  (auto_in_c_bits_source),
    .io_enq_bits_sink    (3'h0),	// Nodes.scala:1210:84
    .io_enq_bits_denied  (1'h0),
    .io_enq_bits_data    (64'h0),	// Nodes.scala:1210:84
    .io_enq_bits_corrupt (1'h0),
    .io_deq_ready        (out_6_ready & (idle_1 ? ~auto_out_d_valid : state_1_1)),	// Arbiter.scala:16:61, :88:28, :116:26, :121:24, :123:31, CacheCork.scala:126:34
    .io_enq_ready        (_q_io_enq_ready),
    .io_deq_valid        (_q_io_deq_valid),
    .io_deq_bits_opcode  (_q_io_deq_bits_opcode),
    .io_deq_bits_param   (_q_io_deq_bits_param),
    .io_deq_bits_size    (_q_io_deq_bits_size),
    .io_deq_bits_source  (_q_io_deq_bits_source),
    .io_deq_bits_sink    (/* unused */),
    .io_deq_bits_denied  (_q_io_deq_bits_denied),
    .io_deq_bits_data    (_q_io_deq_bits_data),
    .io_deq_bits_corrupt (_q_io_deq_bits_corrupt)
  );
  Queue_25 q_1 (	// Decoupled.scala:296:21
    .clock               (clock),
    .reset               (reset),
    .io_enq_valid        (auto_in_a_valid & toD),	// CacheCork.scala:67:97, :83:33
    .io_enq_bits_opcode  (3'h4),	// CacheCork.scala:77:27
    .io_enq_bits_param   (2'h0),	// Nodes.scala:1210:84
    .io_enq_bits_size    (auto_in_a_bits_size),
    .io_enq_bits_source  (auto_in_a_bits_source),
    .io_enq_bits_sink    (3'h0),	// Nodes.scala:1210:84
    .io_enq_bits_denied  (1'h0),
    .io_enq_bits_data    (64'h0),	// Nodes.scala:1210:84
    .io_enq_bits_corrupt (1'h0),
    .io_deq_ready        (out_6_ready & (idle_1 ? ~_GEN_3 : state_1_2)),	// Arbiter.scala:16:61, :88:28, :116:26, :121:24, :123:31, CacheCork.scala:126:34, package.scala:244:43
    .io_enq_ready        (_q_1_io_enq_ready),
    .io_deq_valid        (_q_1_io_deq_valid),
    .io_deq_bits_opcode  (_q_1_io_deq_bits_opcode),
    .io_deq_bits_param   (_q_1_io_deq_bits_param),
    .io_deq_bits_size    (_q_1_io_deq_bits_size),
    .io_deq_bits_source  (_q_1_io_deq_bits_source),
    .io_deq_bits_sink    (/* unused */),
    .io_deq_bits_denied  (_q_1_io_deq_bits_denied),
    .io_deq_bits_data    (_q_1_io_deq_bits_data),
    .io_deq_bits_corrupt (_q_1_io_deq_bits_corrupt)
  );
  assign auto_in_a_ready = bundleIn_0_a_ready;	// CacheCork.scala:69:26
  assign auto_in_c_ready = bundleIn_0_c_ready;	// CacheCork.scala:107:26
  assign auto_in_d_valid = bundleIn_0_d_valid;	// CacheCork.scala:125:34
  assign auto_in_d_bits_opcode = out_6_bits_opcode;	// Mux.scala:27:72
  assign auto_in_d_bits_param = out_6_bits_param;	// Mux.scala:27:72
  assign auto_in_d_bits_size = out_6_bits_size;	// Mux.scala:27:72
  assign auto_in_d_bits_source = out_6_bits_source;	// Mux.scala:27:72
  assign auto_in_d_bits_sink = bundleIn_0_d_bits_sink;	// package.scala:79:42
  assign auto_in_d_bits_denied = out_6_bits_denied;	// Mux.scala:27:72
  assign auto_in_d_bits_data =
    (muxStateEarly_1_0 ? auto_out_d_bits_data : 64'h0)
    | (muxStateEarly_1_1 ? _q_io_deq_bits_data : 64'h0)
    | (muxStateEarly_1_2 ? _q_1_io_deq_bits_data : 64'h0);	// Arbiter.scala:117:30, Decoupled.scala:296:21, Mux.scala:27:72, Nodes.scala:1210:84
  assign auto_in_d_bits_corrupt = out_6_bits_corrupt;	// Mux.scala:27:72
  assign auto_out_a_valid = out_2_valid;	// Arbiter.scala:125:29
  assign auto_out_a_bits_opcode = muxStateEarly_1 ? out_1_bits_opcode : 3'h0;	// Arbiter.scala:117:30, CacheCork.scala:72:18, :76:86, :77:27, Mux.scala:27:72, Nodes.scala:1210:84
  assign auto_out_a_bits_param = ~muxStateEarly_1 | _GEN ? 3'h0 : auto_in_a_bits_param;	// Arbiter.scala:117:30, CacheCork.scala:76:49, Mux.scala:27:72, Nodes.scala:1210:84
  assign auto_out_a_bits_size =
    (muxStateEarly_0 ? auto_in_c_bits_size : 3'h0)
    | (muxStateEarly_1 ? auto_in_a_bits_size : 3'h0);	// Arbiter.scala:117:30, Mux.scala:27:72, Nodes.scala:1210:84
  assign auto_out_a_bits_source =
    (muxStateEarly_0 ? {auto_in_c_bits_source, 1'h0} : 4'h0)
    | (muxStateEarly_1
         ? {auto_in_a_bits_source,
            _GEN | auto_in_a_bits_opcode == 3'h0 | auto_in_a_bits_opcode == 3'h1}
         : 4'h0);	// Arbiter.scala:117:30, Bundles.scala:256:54, CacheCork.scala:66:{38,74}, :73:25, :76:{49,86}, :79:27, :94:41, :144:40, Mux.scala:27:72, Nodes.scala:1210:84
  assign auto_out_a_bits_address =
    (muxStateEarly_0 ? auto_in_c_bits_address : 32'h0)
    | (muxStateEarly_1 ? auto_in_a_bits_address : 32'h0);	// Arbiter.scala:117:30, Mux.scala:27:72, Nodes.scala:1210:84
  assign auto_out_a_bits_mask =
    (muxStateEarly_0
       ? {c_a_bits_a_mask_acc_5 | c_a_bits_a_mask_eq_5 & auto_in_c_bits_address[0],
          c_a_bits_a_mask_acc_5 | c_a_bits_a_mask_eq_5 & ~(auto_in_c_bits_address[0]),
          c_a_bits_a_mask_acc_4 | c_a_bits_a_mask_eq_4 & auto_in_c_bits_address[0],
          c_a_bits_a_mask_acc_4 | c_a_bits_a_mask_eq_4 & ~(auto_in_c_bits_address[0]),
          c_a_bits_a_mask_acc_3 | c_a_bits_a_mask_eq_3 & auto_in_c_bits_address[0],
          c_a_bits_a_mask_acc_3 | c_a_bits_a_mask_eq_3 & ~(auto_in_c_bits_address[0]),
          c_a_bits_a_mask_acc_2 | c_a_bits_a_mask_eq_2 & auto_in_c_bits_address[0],
          c_a_bits_a_mask_acc_2 | c_a_bits_a_mask_eq_2 & ~(auto_in_c_bits_address[0])}
       : 8'h0) | (muxStateEarly_1 ? auto_in_a_bits_mask : 8'h0);	// Arbiter.scala:117:30, Cat.scala:30:58, Misc.scala:209:26, :210:20, :213:27, :214:29, Mux.scala:27:72, Nodes.scala:1210:84
  assign auto_out_a_bits_data =
    (muxStateEarly_0 ? auto_in_c_bits_data : 64'h0)
    | (muxStateEarly_1 ? auto_in_a_bits_data : 64'h0);	// Arbiter.scala:117:30, Mux.scala:27:72, Nodes.scala:1210:84
  assign auto_out_a_bits_corrupt =
    muxStateEarly_0 & auto_in_c_bits_corrupt | muxStateEarly_1 & auto_in_a_bits_corrupt;	// Arbiter.scala:117:30, Mux.scala:27:72
  assign auto_out_d_ready = out_6_ready & (idle_1 | state_1_0);	// Arbiter.scala:88:28, :116:26, :121:24, :123:31, CacheCork.scala:126:34
endmodule

