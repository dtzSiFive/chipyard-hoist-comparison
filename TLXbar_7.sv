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

module TLXbar_7(
  input         clock,
                reset,
                auto_in_1_a_valid,
  input  [31:0] auto_in_1_a_bits_address,
  input         auto_in_0_a_valid,
  input  [2:0]  auto_in_0_a_bits_opcode,
                auto_in_0_a_bits_param,
  input  [3:0]  auto_in_0_a_bits_size,
  input         auto_in_0_a_bits_source,
  input  [31:0] auto_in_0_a_bits_address,
  input  [7:0]  auto_in_0_a_bits_mask,
  input  [63:0] auto_in_0_a_bits_data,
  input         auto_in_0_b_ready,
                auto_in_0_c_valid,
  input  [2:0]  auto_in_0_c_bits_opcode,
                auto_in_0_c_bits_param,
  input  [3:0]  auto_in_0_c_bits_size,
  input         auto_in_0_c_bits_source,
  input  [31:0] auto_in_0_c_bits_address,
  input         auto_in_0_d_ready,
                auto_in_0_e_valid,
  input  [2:0]  auto_in_0_e_bits_sink,
  input         auto_out_a_ready,
                auto_out_b_valid,
  input  [2:0]  auto_out_b_bits_opcode,
  input  [1:0]  auto_out_b_bits_param,
  input  [3:0]  auto_out_b_bits_size,
  input  [1:0]  auto_out_b_bits_source,
  input  [31:0] auto_out_b_bits_address,
  input  [7:0]  auto_out_b_bits_mask,
  input         auto_out_b_bits_corrupt,
                auto_out_c_ready,
                auto_out_d_valid,
  input  [2:0]  auto_out_d_bits_opcode,
  input  [1:0]  auto_out_d_bits_param,
  input  [3:0]  auto_out_d_bits_size,
  input  [1:0]  auto_out_d_bits_source,
  input  [2:0]  auto_out_d_bits_sink,
  input         auto_out_d_bits_denied,
                auto_out_d_bits_corrupt,
                auto_out_e_ready,
  output        auto_in_1_a_ready,
                auto_in_1_d_valid,
                auto_in_0_a_ready,
                auto_in_0_b_valid,
                auto_in_0_b_bits_source,
                auto_in_0_d_valid,
                auto_in_0_d_bits_source,
                auto_out_a_valid,
  output [2:0]  auto_out_a_bits_opcode,
                auto_out_a_bits_param,
  output [3:0]  auto_out_a_bits_size,
  output [1:0]  auto_out_a_bits_source,
  output [31:0] auto_out_a_bits_address,
  output [7:0]  auto_out_a_bits_mask,
  output [63:0] auto_out_a_bits_data,
  output        auto_out_b_ready,
  output [1:0]  auto_out_c_bits_source,
  output        auto_out_d_ready
);

  wire       requestDOI_0_1 = auto_out_d_bits_source == 2'h2;	// Parameters.scala:46:9, Xbar.scala:424:24
  wire       out_8_valid = auto_out_b_valid & ~(auto_out_b_bits_source[1]);	// Parameters.scala:54:{10,32}, Xbar.scala:179:40
  wire       out_10_valid = auto_out_d_valid & ~(auto_out_d_bits_source[1]);	// Parameters.scala:54:{10,32}, Xbar.scala:179:40
  wire       out_13_valid = auto_out_d_valid & requestDOI_0_1;	// Parameters.scala:46:9, Xbar.scala:179:40
  reg  [8:0] beatsLeft;	// Arbiter.scala:87:30
  wire       idle = beatsLeft == 9'h0;	// Arbiter.scala:87:30, :88:28, :111:73, Edges.scala:220:14
  wire [1:0] readys_filter_lo = {auto_in_1_a_valid, auto_in_0_a_valid};	// Cat.scala:30:58
  reg  [1:0] readys_mask;	// Arbiter.scala:23:23
  wire [1:0] readys_filter_hi = readys_filter_lo & ~readys_mask;	// Arbiter.scala:23:23, :24:{28,30}, Cat.scala:30:58
  wire [1:0] readys_readys =
    ~({readys_mask[1], readys_filter_hi[1] | readys_mask[0]}
      & ({readys_filter_hi[0], auto_in_1_a_valid} | readys_filter_hi));	// Arbiter.scala:23:23, :24:28, :25:58, :26:{18,29,39}, package.scala:253:43
  wire       prefixOR_1 = readys_readys[0] & auto_in_0_a_valid;	// Arbiter.scala:26:18, :95:86, :97:79
  wire       earlyWinner_1 = readys_readys[1] & auto_in_1_a_valid;	// Arbiter.scala:26:18, :95:86, :97:79
  wire       _out_0_a_earlyValid_T = auto_in_0_a_valid | auto_in_1_a_valid;	// Arbiter.scala:107:36
  `ifndef SYNTHESIS	// Arbiter.scala:105:13
    always @(posedge clock) begin	// Arbiter.scala:105:13
      if (~(~prefixOR_1 | ~earlyWinner_1 | reset)) begin	// Arbiter.scala:97:79, :105:{13,61,67}
        if (`ASSERT_VERBOSE_COND_)	// Arbiter.scala:105:13
          $error("Assertion failed\n    at Arbiter.scala:105 assert((prefixOR zip earlyWinner) map { case (p,w) => !p || !w } reduce {_ && _})\n");	// Arbiter.scala:105:13
        if (`STOP_COND_)	// Arbiter.scala:105:13
          $fatal;	// Arbiter.scala:105:13
      end
      if (~(~_out_0_a_earlyValid_T | prefixOR_1 | earlyWinner_1 | reset)) begin	// Arbiter.scala:97:79, :107:{14,15,36}
        if (`ASSERT_VERBOSE_COND_)	// Arbiter.scala:107:14
          $error("Assertion failed\n    at Arbiter.scala:107 assert (!earlyValids.reduce(_||_) || earlyWinner.reduce(_||_))\n");	// Arbiter.scala:107:14
        if (`STOP_COND_)	// Arbiter.scala:107:14
          $fatal;	// Arbiter.scala:107:14
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  reg        state_0;	// Arbiter.scala:116:26
  reg        state_1;	// Arbiter.scala:116:26
  wire       muxStateEarly_0 = idle ? prefixOR_1 : state_0;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire       muxStateEarly_1 = idle ? earlyWinner_1 : state_1;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire       portsAOI_filtered_0_ready =
    auto_out_a_ready & (idle ? readys_readys[0] : state_0);	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24, :123:31
  wire       portsAOI_filtered_1_0_ready =
    auto_out_a_ready & (idle ? readys_readys[1] : state_1);	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24, :123:31
  wire       bundleOut_0_out_1_valid =
    idle
      ? _out_0_a_earlyValid_T
      : state_0 & auto_in_0_a_valid | state_1 & auto_in_1_a_valid;	// Arbiter.scala:88:28, :107:36, :116:26, :125:29, Mux.scala:27:72
  always @(posedge clock) begin
    if (reset) begin
      beatsLeft <= 9'h0;	// Arbiter.scala:87:30, :111:73, Edges.scala:220:14
      readys_mask <= 2'h3;	// Arbiter.scala:23:23
      state_0 <= 1'h0;	// Arbiter.scala:116:26
      state_1 <= 1'h0;	// Arbiter.scala:116:26
    end
    else begin
      automatic logic latch = idle & auto_out_a_ready;	// Arbiter.scala:88:28, :89:24
      automatic logic winnerQual_0;	// Arbiter.scala:98:79
      winnerQual_0 = readys_readys[0] & auto_in_0_a_valid;	// Arbiter.scala:26:18, :95:86, :98:79
      if (latch) begin	// Arbiter.scala:89:24
        if (winnerQual_0 & ~(auto_in_0_a_bits_opcode[2])) begin	// Arbiter.scala:98:79, :111:73, Edges.scala:91:{28,37}, :220:14
          automatic logic [26:0] _beatsAI_decode_T_1 = 27'hFFF << auto_in_0_a_bits_size;	// package.scala:234:77
          beatsLeft <= ~(_beatsAI_decode_T_1[11:3]);	// Arbiter.scala:87:30, package.scala:234:{46,77,82}
        end
        else	// Arbiter.scala:111:73, Edges.scala:220:14
          beatsLeft <= 9'h0;	// Arbiter.scala:87:30, :111:73, Edges.scala:220:14
      end
      else	// Arbiter.scala:89:24
        beatsLeft <= beatsLeft - {8'h0, auto_out_a_ready & bundleOut_0_out_1_valid};	// Arbiter.scala:87:30, :113:52, :125:29, ReadyValidCancel.scala:50:33, Xbar.scala:254:26
      if (latch & (|readys_filter_lo)) begin	// Arbiter.scala:27:{18,27}, :89:24, Cat.scala:30:58
        automatic logic [1:0] _readys_mask_T = readys_readys & readys_filter_lo;	// Arbiter.scala:26:18, :28:29, Cat.scala:30:58
        readys_mask <= _readys_mask_T | {_readys_mask_T[0], 1'h0};	// Arbiter.scala:23:23, :28:29, package.scala:244:{43,53}
      end
      if (idle) begin	// Arbiter.scala:88:28
        state_0 <= winnerQual_0;	// Arbiter.scala:98:79, :116:26
        state_1 <= readys_readys[1] & auto_in_1_a_valid;	// Arbiter.scala:26:18, :95:86, :98:79, :116:26
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
        readys_mask = _RANDOM[/*Zero width*/ 1'b0][10:9];	// Arbiter.scala:23:23, :87:30
        state_0 = _RANDOM[/*Zero width*/ 1'b0][11];	// Arbiter.scala:87:30, :116:26
        state_1 = _RANDOM[/*Zero width*/ 1'b0][12];	// Arbiter.scala:87:30, :116:26
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  TLMonitor_50 monitor (	// Nodes.scala:24:25
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (portsAOI_filtered_0_ready),	// Arbiter.scala:123:31
    .io_in_a_valid        (auto_in_0_a_valid),
    .io_in_a_bits_opcode  (auto_in_0_a_bits_opcode),
    .io_in_a_bits_param   (auto_in_0_a_bits_param),
    .io_in_a_bits_size    (auto_in_0_a_bits_size),
    .io_in_a_bits_source  (auto_in_0_a_bits_source),
    .io_in_a_bits_address (auto_in_0_a_bits_address),
    .io_in_a_bits_mask    (auto_in_0_a_bits_mask),
    .io_in_b_ready        (auto_in_0_b_ready),
    .io_in_b_valid        (out_8_valid),	// Xbar.scala:179:40
    .io_in_b_bits_opcode  (auto_out_b_bits_opcode),
    .io_in_b_bits_param   (auto_out_b_bits_param),
    .io_in_b_bits_size    (auto_out_b_bits_size),
    .io_in_b_bits_source  (auto_out_b_bits_source[0]),	// Xbar.scala:228:69
    .io_in_b_bits_address (auto_out_b_bits_address),
    .io_in_b_bits_mask    (auto_out_b_bits_mask),
    .io_in_b_bits_corrupt (auto_out_b_bits_corrupt),
    .io_in_c_ready        (auto_out_c_ready),
    .io_in_c_valid        (auto_in_0_c_valid),
    .io_in_c_bits_opcode  (auto_in_0_c_bits_opcode),
    .io_in_c_bits_param   (auto_in_0_c_bits_param),
    .io_in_c_bits_size    (auto_in_0_c_bits_size),
    .io_in_c_bits_source  (auto_in_0_c_bits_source),
    .io_in_c_bits_address (auto_in_0_c_bits_address),
    .io_in_d_ready        (auto_in_0_d_ready),
    .io_in_d_valid        (out_10_valid),	// Xbar.scala:179:40
    .io_in_d_bits_opcode  (auto_out_d_bits_opcode),
    .io_in_d_bits_param   (auto_out_d_bits_param),
    .io_in_d_bits_size    (auto_out_d_bits_size),
    .io_in_d_bits_source  (auto_out_d_bits_source[0]),	// Xbar.scala:228:69
    .io_in_d_bits_sink    (auto_out_d_bits_sink),
    .io_in_d_bits_denied  (auto_out_d_bits_denied),
    .io_in_d_bits_corrupt (auto_out_d_bits_corrupt),
    .io_in_e_ready        (auto_out_e_ready),
    .io_in_e_valid        (auto_in_0_e_valid),
    .io_in_e_bits_sink    (auto_in_0_e_bits_sink)
  );
  TLMonitor_51 monitor_1 (	// Nodes.scala:24:25
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (portsAOI_filtered_1_0_ready),	// Arbiter.scala:123:31
    .io_in_a_valid        (auto_in_1_a_valid),
    .io_in_a_bits_address (auto_in_1_a_bits_address),
    .io_in_d_valid        (out_13_valid),	// Xbar.scala:179:40
    .io_in_d_bits_opcode  (auto_out_d_bits_opcode),
    .io_in_d_bits_param   (auto_out_d_bits_param),
    .io_in_d_bits_size    (auto_out_d_bits_size),
    .io_in_d_bits_sink    (auto_out_d_bits_sink),
    .io_in_d_bits_denied  (auto_out_d_bits_denied),
    .io_in_d_bits_corrupt (auto_out_d_bits_corrupt)
  );
  assign auto_in_1_a_ready = portsAOI_filtered_1_0_ready;	// Arbiter.scala:123:31
  assign auto_in_1_d_valid = out_13_valid;	// Xbar.scala:179:40
  assign auto_in_0_a_ready = portsAOI_filtered_0_ready;	// Arbiter.scala:123:31
  assign auto_in_0_b_valid = out_8_valid;	// Xbar.scala:179:40
  assign auto_in_0_b_bits_source = auto_out_b_bits_source[0];	// Xbar.scala:228:69
  assign auto_in_0_d_valid = out_10_valid;	// Xbar.scala:179:40
  assign auto_in_0_d_bits_source = auto_out_d_bits_source[0];	// Xbar.scala:228:69
  assign auto_out_a_valid = bundleOut_0_out_1_valid;	// Arbiter.scala:125:29
  assign auto_out_a_bits_opcode =
    (muxStateEarly_0 ? auto_in_0_a_bits_opcode : 3'h0) | {muxStateEarly_1, 2'h0};	// Arbiter.scala:117:30, Mux.scala:27:72, Nodes.scala:24:25, Xbar.scala:254:26
  assign auto_out_a_bits_param = muxStateEarly_0 ? auto_in_0_a_bits_param : 3'h0;	// Arbiter.scala:117:30, Mux.scala:27:72, Nodes.scala:24:25
  assign auto_out_a_bits_size =
    (muxStateEarly_0 ? auto_in_0_a_bits_size : 4'h0) | (muxStateEarly_1 ? 4'h6 : 4'h0);	// Arbiter.scala:117:30, Bundles.scala:257:54, Mux.scala:27:72, Nodes.scala:24:25
  assign auto_out_a_bits_source =
    (muxStateEarly_0 ? {1'h0, auto_in_0_a_bits_source} : 2'h0) | {muxStateEarly_1, 1'h0};	// Arbiter.scala:117:30, Mux.scala:27:72, Xbar.scala:237:29, :254:26
  assign auto_out_a_bits_address =
    (muxStateEarly_0 ? auto_in_0_a_bits_address : 32'h0)
    | (muxStateEarly_1 ? auto_in_1_a_bits_address : 32'h0);	// Arbiter.scala:117:30, Bundles.scala:257:54, Mux.scala:27:72
  assign auto_out_a_bits_mask =
    (muxStateEarly_0 ? auto_in_0_a_bits_mask : 8'h0) | {8{muxStateEarly_1}};	// Arbiter.scala:117:30, Mux.scala:27:72, Xbar.scala:254:26
  assign auto_out_a_bits_data = muxStateEarly_0 ? auto_in_0_a_bits_data : 64'h0;	// Arbiter.scala:117:30, Mux.scala:27:72, Nodes.scala:24:25
  assign auto_out_b_ready = ~(auto_out_b_bits_source[1]) & auto_in_0_b_ready;	// Mux.scala:27:72, Parameters.scala:54:{10,32}
  assign auto_out_c_bits_source = {1'h0, auto_in_0_c_bits_source};	// Xbar.scala:259:29
  assign auto_out_d_ready =
    ~(auto_out_d_bits_source[1]) & auto_in_0_d_ready | requestDOI_0_1;	// Mux.scala:27:72, Parameters.scala:46:9, :54:{10,32}
endmodule

