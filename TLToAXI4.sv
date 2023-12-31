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

module TLToAXI4(
  input         clock,
                reset,
                auto_in_a_valid,
  input  [2:0]  auto_in_a_bits_opcode,
                auto_in_a_bits_param,
                auto_in_a_bits_size,
  input  [3:0]  auto_in_a_bits_source,
  input  [31:0] auto_in_a_bits_address,
  input  [7:0]  auto_in_a_bits_mask,
  input  [63:0] auto_in_a_bits_data,
  input         auto_in_a_bits_corrupt,
                auto_in_d_ready,
                auto_out_aw_ready,
                auto_out_w_ready,
                auto_out_b_valid,
  input  [3:0]  auto_out_b_bits_id,
  input  [1:0]  auto_out_b_bits_resp,
  input  [3:0]  auto_out_b_bits_echo_tl_state_size,
                auto_out_b_bits_echo_tl_state_source,
  input         auto_out_ar_ready,
                auto_out_r_valid,
  input  [3:0]  auto_out_r_bits_id,
  input  [1:0]  auto_out_r_bits_resp,
  input  [3:0]  auto_out_r_bits_echo_tl_state_size,
                auto_out_r_bits_echo_tl_state_source,
  input         auto_out_r_bits_last,
  output        auto_in_a_ready,
                auto_in_d_valid,
  output [2:0]  auto_in_d_bits_opcode,
                auto_in_d_bits_size,
  output [3:0]  auto_in_d_bits_source,
  output        auto_in_d_bits_denied,
                auto_in_d_bits_corrupt,
                auto_out_aw_valid,
  output [3:0]  auto_out_aw_bits_id,
  output [31:0] auto_out_aw_bits_addr,
  output [7:0]  auto_out_aw_bits_len,
  output [2:0]  auto_out_aw_bits_size,
  output [1:0]  auto_out_aw_bits_burst,
  output        auto_out_aw_bits_lock,
  output [3:0]  auto_out_aw_bits_cache,
  output [2:0]  auto_out_aw_bits_prot,
  output [3:0]  auto_out_aw_bits_qos,
                auto_out_aw_bits_echo_tl_state_size,
                auto_out_aw_bits_echo_tl_state_source,
  output        auto_out_w_valid,
  output [63:0] auto_out_w_bits_data,
  output [7:0]  auto_out_w_bits_strb,
  output        auto_out_w_bits_last,
                auto_out_b_ready,
                auto_out_ar_valid,
  output [3:0]  auto_out_ar_bits_id,
  output [31:0] auto_out_ar_bits_addr,
  output [7:0]  auto_out_ar_bits_len,
  output [2:0]  auto_out_ar_bits_size,
  output [1:0]  auto_out_ar_bits_burst,
  output        auto_out_ar_bits_lock,
  output [3:0]  auto_out_ar_bits_cache,
  output [2:0]  auto_out_ar_bits_prot,
  output [3:0]  auto_out_ar_bits_qos,
                auto_out_ar_bits_echo_tl_state_size,
                auto_out_ar_bits_echo_tl_state_source
);

  reg              count_10;	// ToAXI4.scala:248:28
  reg              count_9;	// ToAXI4.scala:248:28
  reg              count_8;	// ToAXI4.scala:248:28
  reg              count_7;	// ToAXI4.scala:248:28
  reg              count_6;	// ToAXI4.scala:248:28
  reg              count_5;	// ToAXI4.scala:248:28
  reg              count_4;	// ToAXI4.scala:248:28
  reg              count_3;	// ToAXI4.scala:248:28
  reg              count_2;	// ToAXI4.scala:248:28
  reg              count_1;	// ToAXI4.scala:248:28
  wire             _queue_arw_deq_io_enq_ready;	// Decoupled.scala:296:21
  wire             _queue_arw_deq_io_deq_valid;	// Decoupled.scala:296:21
  wire [3:0]       _queue_arw_deq_io_deq_bits_id;	// Decoupled.scala:296:21
  wire [31:0]      _queue_arw_deq_io_deq_bits_addr;	// Decoupled.scala:296:21
  wire [7:0]       _queue_arw_deq_io_deq_bits_len;	// Decoupled.scala:296:21
  wire [2:0]       _queue_arw_deq_io_deq_bits_size;	// Decoupled.scala:296:21
  wire [1:0]       _queue_arw_deq_io_deq_bits_burst;	// Decoupled.scala:296:21
  wire             _queue_arw_deq_io_deq_bits_lock;	// Decoupled.scala:296:21
  wire [3:0]       _queue_arw_deq_io_deq_bits_cache;	// Decoupled.scala:296:21
  wire [2:0]       _queue_arw_deq_io_deq_bits_prot;	// Decoupled.scala:296:21
  wire [3:0]       _queue_arw_deq_io_deq_bits_qos;	// Decoupled.scala:296:21
  wire [3:0]       _queue_arw_deq_io_deq_bits_echo_tl_state_size;	// Decoupled.scala:296:21
  wire [3:0]       _queue_arw_deq_io_deq_bits_echo_tl_state_source;	// Decoupled.scala:296:21
  wire             _queue_arw_deq_io_deq_bits_wen;	// Decoupled.scala:296:21
  wire             _deq_io_enq_ready;	// Decoupled.scala:296:21
  wire [15:0][3:0] _GEN =
    {4'h0,
     4'h0,
     4'h0,
     4'h0,
     4'h0,
     4'h0,
     4'h9,
     4'h8,
     4'h7,
     4'h6,
     4'h5,
     4'h4,
     4'h3,
     4'h2,
     4'h1,
     4'h0};	// ToAXI4.scala:166:17
  wire [12:0]      _beats1_decode_T_1 = 13'h3F << auto_in_a_bits_size;	// package.scala:234:77
  reg  [2:0]       counter;	// Edges.scala:228:27
  wire             a_first = counter == 3'h0;	// Edges.scala:228:27, :230:25
  wire             out_w_bits_last =
    counter == 3'h1
    | (auto_in_a_bits_opcode[2] ? 3'h0 : ~(_beats1_decode_T_1[5:3])) == 3'h0;	// Edges.scala:91:37, :220:14, :228:27, :231:{25,37,47}, ToAXI4.scala:173:17, package.scala:234:{46,77,82}
  reg              doneAW;	// ToAXI4.scala:161:30
  wire [17:0]      _out_arw_bits_len_T_1 = 18'h7FF << auto_in_a_bits_size;	// package.scala:234:77
  wire [15:0]      _GEN_0 =
    {{count_1},
     {count_1},
     {count_1},
     {count_1},
     {count_1},
     {count_1},
     {count_10},
     {count_9},
     {count_8},
     {count_7},
     {count_6},
     {count_5},
     {count_4},
     {count_3},
     {count_2},
     {count_1}};	// ToAXI4.scala:195:49, :248:28
  wire             stall = _GEN_0[auto_in_a_bits_source] & a_first;	// Edges.scala:230:25, ToAXI4.scala:195:49
  wire             _out_w_valid_T_3 = doneAW | _queue_arw_deq_io_enq_ready;	// Decoupled.scala:296:21, ToAXI4.scala:161:30, :196:52
  wire             bundleIn_0_a_ready =
    ~stall
    & (auto_in_a_bits_opcode[2]
         ? _queue_arw_deq_io_enq_ready
         : _out_w_valid_T_3 & _deq_io_enq_ready);	// Decoupled.scala:296:21, Edges.scala:91:37, ToAXI4.scala:195:49, :196:{21,28,34,52,70}
  wire             out_arw_valid =
    ~stall & auto_in_a_valid & (auto_in_a_bits_opcode[2] | ~doneAW & _deq_io_enq_ready);	// Decoupled.scala:296:21, Edges.scala:91:37, ToAXI4.scala:161:30, :195:49, :196:21, :197:{45,51,61,69}
  reg              r_holds_d;	// ToAXI4.scala:206:30
  wire             r_wins = auto_out_r_valid | r_holds_d;	// ToAXI4.scala:206:30, :209:32
  wire             bundleIn_0_d_valid = r_wins ? auto_out_r_valid : auto_out_b_valid;	// ToAXI4.scala:209:32, :213:24
  reg              r_first;	// ToAXI4.scala:218:28
  reg              r_denied_r;	// Reg.scala:15:16
  wire             r_d_denied = r_first ? (&auto_out_r_bits_resp) : r_denied_r;	// Reg.scala:15:16, ToAXI4.scala:218:28, :220:39, package.scala:79:42
  wire [2:0]       bundleIn_0_d_bits_opcode = {2'h0, r_wins};	// Edges.scala:231:25, ToAXI4.scala:209:32, :231:23
  wire [2:0]       bundleIn_0_d_bits_size =
    r_wins
      ? auto_out_r_bits_echo_tl_state_size[2:0]
      : auto_out_b_bits_echo_tl_state_size[2:0];	// Edges.scala:758:15, :774:15, ToAXI4.scala:209:32, :231:23
  wire [3:0]       bundleIn_0_d_bits_source =
    r_wins ? auto_out_r_bits_echo_tl_state_source : auto_out_b_bits_echo_tl_state_source;	// ToAXI4.scala:209:32, :231:23
  wire             bundleIn_0_d_bits_denied =
    r_wins ? r_d_denied : (|auto_out_b_bits_resp);	// ToAXI4.scala:209:32, :222:39, :231:23, package.scala:79:42
  wire             bundleIn_0_d_bits_corrupt =
    r_wins & ((|auto_out_r_bits_resp) | r_d_denied);	// ToAXI4.scala:209:32, :221:39, :224:100, :231:23, package.scala:79:42
  wire [3:0]       d_sel_shiftAmount = r_wins ? auto_out_r_bits_id : auto_out_b_bits_id;	// ToAXI4.scala:209:32, :237:31
  wire             d_last = ~r_wins | auto_out_r_bits_last;	// ToAXI4.scala:209:32, :238:23
  wire             _inc_T_9 = _queue_arw_deq_io_enq_ready & out_arw_valid;	// Decoupled.scala:40:37, :296:21, ToAXI4.scala:197:45
  wire             inc = _GEN[auto_in_a_bits_source] == 4'h0 & _inc_T_9;	// Decoupled.scala:40:37, OneHot.scala:65:{12,27}, ToAXI4.scala:166:17, :236:58, :252:22
  wire             _dec_T_19 = auto_in_d_ready & bundleIn_0_d_valid;	// Decoupled.scala:40:37, ToAXI4.scala:213:24
  wire             dec = d_sel_shiftAmount == 4'h0 & d_last & _dec_T_19;	// Decoupled.scala:40:37, OneHot.scala:65:{12,27}, ToAXI4.scala:237:{31,93}, :238:23, :253:32
  wire             inc_1 = _GEN[auto_in_a_bits_source] == 4'h1 & _inc_T_9;	// Decoupled.scala:40:37, OneHot.scala:65:{12,27}, ToAXI4.scala:166:17, :236:58, :252:22
  wire             dec_1 = d_sel_shiftAmount == 4'h1 & d_last & _dec_T_19;	// Decoupled.scala:40:37, OneHot.scala:65:{12,27}, ToAXI4.scala:237:{31,93}, :238:23, :253:32
  wire             inc_2 = _GEN[auto_in_a_bits_source] == 4'h2 & _inc_T_9;	// Decoupled.scala:40:37, OneHot.scala:65:{12,27}, ToAXI4.scala:166:17, :236:58, :252:22
  wire             dec_2 = d_sel_shiftAmount == 4'h2 & d_last & _dec_T_19;	// Decoupled.scala:40:37, OneHot.scala:65:{12,27}, ToAXI4.scala:237:{31,93}, :238:23, :253:32
  wire             inc_3 = _GEN[auto_in_a_bits_source] == 4'h3 & _inc_T_9;	// Decoupled.scala:40:37, OneHot.scala:65:{12,27}, ToAXI4.scala:166:17, :236:58, :252:22
  wire             dec_3 = d_sel_shiftAmount == 4'h3 & d_last & _dec_T_19;	// Decoupled.scala:40:37, OneHot.scala:65:{12,27}, ToAXI4.scala:237:{31,93}, :238:23, :253:32
  wire             inc_4 = _GEN[auto_in_a_bits_source] == 4'h4 & _inc_T_9;	// Decoupled.scala:40:37, OneHot.scala:65:{12,27}, ToAXI4.scala:166:17, :236:58, :252:22
  wire             dec_4 = d_sel_shiftAmount == 4'h4 & d_last & _dec_T_19;	// Decoupled.scala:40:37, OneHot.scala:65:{12,27}, ToAXI4.scala:237:{31,93}, :238:23, :253:32
  wire             inc_5 = _GEN[auto_in_a_bits_source] == 4'h5 & _inc_T_9;	// Decoupled.scala:40:37, OneHot.scala:65:{12,27}, ToAXI4.scala:166:17, :236:58, :252:22
  wire             dec_5 = d_sel_shiftAmount == 4'h5 & d_last & _dec_T_19;	// Decoupled.scala:40:37, OneHot.scala:65:{12,27}, ToAXI4.scala:237:{31,93}, :238:23, :253:32
  wire             inc_6 = _GEN[auto_in_a_bits_source] == 4'h6 & _inc_T_9;	// Decoupled.scala:40:37, OneHot.scala:65:{12,27}, ToAXI4.scala:166:17, :236:58, :252:22
  wire             dec_6 = d_sel_shiftAmount == 4'h6 & d_last & _dec_T_19;	// Decoupled.scala:40:37, OneHot.scala:65:{12,27}, ToAXI4.scala:237:{31,93}, :238:23, :253:32
  wire             inc_7 = _GEN[auto_in_a_bits_source] == 4'h7 & _inc_T_9;	// Decoupled.scala:40:37, OneHot.scala:65:{12,27}, ToAXI4.scala:166:17, :236:58, :252:22
  wire             dec_7 = d_sel_shiftAmount == 4'h7 & d_last & _dec_T_19;	// Decoupled.scala:40:37, OneHot.scala:65:{12,27}, ToAXI4.scala:237:{31,93}, :238:23, :253:32
  wire             inc_8 = _GEN[auto_in_a_bits_source] == 4'h8 & _inc_T_9;	// Decoupled.scala:40:37, OneHot.scala:65:{12,27}, ToAXI4.scala:166:17, :236:58, :252:22
  wire             dec_8 = d_sel_shiftAmount == 4'h8 & d_last & _dec_T_19;	// Decoupled.scala:40:37, OneHot.scala:65:{12,27}, ToAXI4.scala:237:{31,93}, :238:23, :253:32
  wire             inc_9 = _GEN[auto_in_a_bits_source] == 4'h9 & _inc_T_9;	// Decoupled.scala:40:37, OneHot.scala:65:{12,27}, ToAXI4.scala:166:17, :236:58, :252:22
  wire             dec_9 = d_sel_shiftAmount == 4'h9 & d_last & _dec_T_19;	// Decoupled.scala:40:37, OneHot.scala:65:{12,27}, ToAXI4.scala:237:{31,93}, :238:23, :253:32
  `ifndef SYNTHESIS	// ToAXI4.scala:256:16
    always @(posedge clock) begin	// ToAXI4.scala:256:16
      if (~(~dec | count_1 | reset)) begin	// ToAXI4.scala:248:28, :253:32, :256:{16,17}
        if (`ASSERT_VERBOSE_COND_)	// ToAXI4.scala:256:16
          $error("Assertion failed\n    at ToAXI4.scala:256 assert (!dec || count =/= UInt(0))        // underflow\n");	// ToAXI4.scala:256:16
        if (`STOP_COND_)	// ToAXI4.scala:256:16
          $fatal;	// ToAXI4.scala:256:16
      end
      if (~(~inc | ~count_1 | reset)) begin	// ToAXI4.scala:248:28, :252:22, :257:{16,17,31}
        if (`ASSERT_VERBOSE_COND_)	// ToAXI4.scala:257:16
          $error("Assertion failed\n    at ToAXI4.scala:257 assert (!inc || count =/= UInt(maxCount)) // overflow\n");	// ToAXI4.scala:257:16
        if (`STOP_COND_)	// ToAXI4.scala:257:16
          $fatal;	// ToAXI4.scala:257:16
      end
      if (~(~dec_1 | count_2 | reset)) begin	// ToAXI4.scala:248:28, :253:32, :256:{16,17}
        if (`ASSERT_VERBOSE_COND_)	// ToAXI4.scala:256:16
          $error("Assertion failed\n    at ToAXI4.scala:256 assert (!dec || count =/= UInt(0))        // underflow\n");	// ToAXI4.scala:256:16
        if (`STOP_COND_)	// ToAXI4.scala:256:16
          $fatal;	// ToAXI4.scala:256:16
      end
      if (~(~inc_1 | ~count_2 | reset)) begin	// ToAXI4.scala:248:28, :252:22, :257:{16,17,31}
        if (`ASSERT_VERBOSE_COND_)	// ToAXI4.scala:257:16
          $error("Assertion failed\n    at ToAXI4.scala:257 assert (!inc || count =/= UInt(maxCount)) // overflow\n");	// ToAXI4.scala:257:16
        if (`STOP_COND_)	// ToAXI4.scala:257:16
          $fatal;	// ToAXI4.scala:257:16
      end
      if (~(~dec_2 | count_3 | reset)) begin	// ToAXI4.scala:248:28, :253:32, :256:{16,17}
        if (`ASSERT_VERBOSE_COND_)	// ToAXI4.scala:256:16
          $error("Assertion failed\n    at ToAXI4.scala:256 assert (!dec || count =/= UInt(0))        // underflow\n");	// ToAXI4.scala:256:16
        if (`STOP_COND_)	// ToAXI4.scala:256:16
          $fatal;	// ToAXI4.scala:256:16
      end
      if (~(~inc_2 | ~count_3 | reset)) begin	// ToAXI4.scala:248:28, :252:22, :257:{16,17,31}
        if (`ASSERT_VERBOSE_COND_)	// ToAXI4.scala:257:16
          $error("Assertion failed\n    at ToAXI4.scala:257 assert (!inc || count =/= UInt(maxCount)) // overflow\n");	// ToAXI4.scala:257:16
        if (`STOP_COND_)	// ToAXI4.scala:257:16
          $fatal;	// ToAXI4.scala:257:16
      end
      if (~(~dec_3 | count_4 | reset)) begin	// ToAXI4.scala:248:28, :253:32, :256:{16,17}
        if (`ASSERT_VERBOSE_COND_)	// ToAXI4.scala:256:16
          $error("Assertion failed\n    at ToAXI4.scala:256 assert (!dec || count =/= UInt(0))        // underflow\n");	// ToAXI4.scala:256:16
        if (`STOP_COND_)	// ToAXI4.scala:256:16
          $fatal;	// ToAXI4.scala:256:16
      end
      if (~(~inc_3 | ~count_4 | reset)) begin	// ToAXI4.scala:248:28, :252:22, :257:{16,17,31}
        if (`ASSERT_VERBOSE_COND_)	// ToAXI4.scala:257:16
          $error("Assertion failed\n    at ToAXI4.scala:257 assert (!inc || count =/= UInt(maxCount)) // overflow\n");	// ToAXI4.scala:257:16
        if (`STOP_COND_)	// ToAXI4.scala:257:16
          $fatal;	// ToAXI4.scala:257:16
      end
      if (~(~dec_4 | count_5 | reset)) begin	// ToAXI4.scala:248:28, :253:32, :256:{16,17}
        if (`ASSERT_VERBOSE_COND_)	// ToAXI4.scala:256:16
          $error("Assertion failed\n    at ToAXI4.scala:256 assert (!dec || count =/= UInt(0))        // underflow\n");	// ToAXI4.scala:256:16
        if (`STOP_COND_)	// ToAXI4.scala:256:16
          $fatal;	// ToAXI4.scala:256:16
      end
      if (~(~inc_4 | ~count_5 | reset)) begin	// ToAXI4.scala:248:28, :252:22, :257:{16,17,31}
        if (`ASSERT_VERBOSE_COND_)	// ToAXI4.scala:257:16
          $error("Assertion failed\n    at ToAXI4.scala:257 assert (!inc || count =/= UInt(maxCount)) // overflow\n");	// ToAXI4.scala:257:16
        if (`STOP_COND_)	// ToAXI4.scala:257:16
          $fatal;	// ToAXI4.scala:257:16
      end
      if (~(~dec_5 | count_6 | reset)) begin	// ToAXI4.scala:248:28, :253:32, :256:{16,17}
        if (`ASSERT_VERBOSE_COND_)	// ToAXI4.scala:256:16
          $error("Assertion failed\n    at ToAXI4.scala:256 assert (!dec || count =/= UInt(0))        // underflow\n");	// ToAXI4.scala:256:16
        if (`STOP_COND_)	// ToAXI4.scala:256:16
          $fatal;	// ToAXI4.scala:256:16
      end
      if (~(~inc_5 | ~count_6 | reset)) begin	// ToAXI4.scala:248:28, :252:22, :257:{16,17,31}
        if (`ASSERT_VERBOSE_COND_)	// ToAXI4.scala:257:16
          $error("Assertion failed\n    at ToAXI4.scala:257 assert (!inc || count =/= UInt(maxCount)) // overflow\n");	// ToAXI4.scala:257:16
        if (`STOP_COND_)	// ToAXI4.scala:257:16
          $fatal;	// ToAXI4.scala:257:16
      end
      if (~(~dec_6 | count_7 | reset)) begin	// ToAXI4.scala:248:28, :253:32, :256:{16,17}
        if (`ASSERT_VERBOSE_COND_)	// ToAXI4.scala:256:16
          $error("Assertion failed\n    at ToAXI4.scala:256 assert (!dec || count =/= UInt(0))        // underflow\n");	// ToAXI4.scala:256:16
        if (`STOP_COND_)	// ToAXI4.scala:256:16
          $fatal;	// ToAXI4.scala:256:16
      end
      if (~(~inc_6 | ~count_7 | reset)) begin	// ToAXI4.scala:248:28, :252:22, :257:{16,17,31}
        if (`ASSERT_VERBOSE_COND_)	// ToAXI4.scala:257:16
          $error("Assertion failed\n    at ToAXI4.scala:257 assert (!inc || count =/= UInt(maxCount)) // overflow\n");	// ToAXI4.scala:257:16
        if (`STOP_COND_)	// ToAXI4.scala:257:16
          $fatal;	// ToAXI4.scala:257:16
      end
      if (~(~dec_7 | count_8 | reset)) begin	// ToAXI4.scala:248:28, :253:32, :256:{16,17}
        if (`ASSERT_VERBOSE_COND_)	// ToAXI4.scala:256:16
          $error("Assertion failed\n    at ToAXI4.scala:256 assert (!dec || count =/= UInt(0))        // underflow\n");	// ToAXI4.scala:256:16
        if (`STOP_COND_)	// ToAXI4.scala:256:16
          $fatal;	// ToAXI4.scala:256:16
      end
      if (~(~inc_7 | ~count_8 | reset)) begin	// ToAXI4.scala:248:28, :252:22, :257:{16,17,31}
        if (`ASSERT_VERBOSE_COND_)	// ToAXI4.scala:257:16
          $error("Assertion failed\n    at ToAXI4.scala:257 assert (!inc || count =/= UInt(maxCount)) // overflow\n");	// ToAXI4.scala:257:16
        if (`STOP_COND_)	// ToAXI4.scala:257:16
          $fatal;	// ToAXI4.scala:257:16
      end
      if (~(~dec_8 | count_9 | reset)) begin	// ToAXI4.scala:248:28, :253:32, :256:{16,17}
        if (`ASSERT_VERBOSE_COND_)	// ToAXI4.scala:256:16
          $error("Assertion failed\n    at ToAXI4.scala:256 assert (!dec || count =/= UInt(0))        // underflow\n");	// ToAXI4.scala:256:16
        if (`STOP_COND_)	// ToAXI4.scala:256:16
          $fatal;	// ToAXI4.scala:256:16
      end
      if (~(~inc_8 | ~count_9 | reset)) begin	// ToAXI4.scala:248:28, :252:22, :257:{16,17,31}
        if (`ASSERT_VERBOSE_COND_)	// ToAXI4.scala:257:16
          $error("Assertion failed\n    at ToAXI4.scala:257 assert (!inc || count =/= UInt(maxCount)) // overflow\n");	// ToAXI4.scala:257:16
        if (`STOP_COND_)	// ToAXI4.scala:257:16
          $fatal;	// ToAXI4.scala:257:16
      end
      if (~(~dec_9 | count_10 | reset)) begin	// ToAXI4.scala:248:28, :253:32, :256:{16,17}
        if (`ASSERT_VERBOSE_COND_)	// ToAXI4.scala:256:16
          $error("Assertion failed\n    at ToAXI4.scala:256 assert (!dec || count =/= UInt(0))        // underflow\n");	// ToAXI4.scala:256:16
        if (`STOP_COND_)	// ToAXI4.scala:256:16
          $fatal;	// ToAXI4.scala:256:16
      end
      if (~(~inc_9 | ~count_10 | reset)) begin	// ToAXI4.scala:248:28, :252:22, :257:{16,17,31}
        if (`ASSERT_VERBOSE_COND_)	// ToAXI4.scala:257:16
          $error("Assertion failed\n    at ToAXI4.scala:257 assert (!inc || count =/= UInt(maxCount)) // overflow\n");	// ToAXI4.scala:257:16
        if (`STOP_COND_)	// ToAXI4.scala:257:16
          $fatal;	// ToAXI4.scala:257:16
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      counter <= 3'h0;	// Edges.scala:228:27
      doneAW <= 1'h0;	// ToAXI4.scala:161:30
      r_holds_d <= 1'h0;	// ToAXI4.scala:206:30
      r_first <= 1'h1;	// ToAXI4.scala:218:28
      count_1 <= 1'h0;	// ToAXI4.scala:248:28
      count_2 <= 1'h0;	// ToAXI4.scala:248:28
      count_3 <= 1'h0;	// ToAXI4.scala:248:28
      count_4 <= 1'h0;	// ToAXI4.scala:248:28
      count_5 <= 1'h0;	// ToAXI4.scala:248:28
      count_6 <= 1'h0;	// ToAXI4.scala:248:28
      count_7 <= 1'h0;	// ToAXI4.scala:248:28
      count_8 <= 1'h0;	// ToAXI4.scala:248:28
      count_9 <= 1'h0;	// ToAXI4.scala:248:28
      count_10 <= 1'h0;	// ToAXI4.scala:248:28
    end
    else begin
      if (bundleIn_0_a_ready & auto_in_a_valid) begin	// Decoupled.scala:40:37, ToAXI4.scala:196:28
        if (a_first) begin	// Edges.scala:230:25
          if (auto_in_a_bits_opcode[2])	// Edges.scala:91:37
            counter <= 3'h0;	// Edges.scala:228:27
          else	// Edges.scala:91:37
            counter <= ~(_beats1_decode_T_1[5:3]);	// Edges.scala:228:27, package.scala:234:{46,77,82}
        end
        else	// Edges.scala:230:25
          counter <= counter - 3'h1;	// Edges.scala:228:27, :229:28
        doneAW <= ~out_w_bits_last;	// Edges.scala:231:37, ToAXI4.scala:161:30, :162:38
      end
      if (auto_in_d_ready & auto_out_r_valid) begin	// Decoupled.scala:40:37
        r_holds_d <= ~auto_out_r_bits_last;	// ToAXI4.scala:206:30, :207:42
        r_first <= auto_out_r_bits_last;	// ToAXI4.scala:218:28
      end
      count_1 <= count_1 + inc - dec;	// ToAXI4.scala:248:28, :252:22, :253:32, :254:{24,37}
      count_2 <= count_2 + inc_1 - dec_1;	// ToAXI4.scala:248:28, :252:22, :253:32, :254:{24,37}
      count_3 <= count_3 + inc_2 - dec_2;	// ToAXI4.scala:248:28, :252:22, :253:32, :254:{24,37}
      count_4 <= count_4 + inc_3 - dec_3;	// ToAXI4.scala:248:28, :252:22, :253:32, :254:{24,37}
      count_5 <= count_5 + inc_4 - dec_4;	// ToAXI4.scala:248:28, :252:22, :253:32, :254:{24,37}
      count_6 <= count_6 + inc_5 - dec_5;	// ToAXI4.scala:248:28, :252:22, :253:32, :254:{24,37}
      count_7 <= count_7 + inc_6 - dec_6;	// ToAXI4.scala:248:28, :252:22, :253:32, :254:{24,37}
      count_8 <= count_8 + inc_7 - dec_7;	// ToAXI4.scala:248:28, :252:22, :253:32, :254:{24,37}
      count_9 <= count_9 + inc_8 - dec_8;	// ToAXI4.scala:248:28, :252:22, :253:32, :254:{24,37}
      count_10 <= count_10 + inc_9 - dec_9;	// ToAXI4.scala:248:28, :252:22, :253:32, :254:{24,37}
    end
    if (r_first)	// ToAXI4.scala:218:28
      r_denied_r <= &auto_out_r_bits_resp;	// Reg.scala:15:16, ToAXI4.scala:220:39
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
        counter = _RANDOM[/*Zero width*/ 1'b0][2:0];	// Edges.scala:228:27
        doneAW = _RANDOM[/*Zero width*/ 1'b0][3];	// Edges.scala:228:27, ToAXI4.scala:161:30
        r_holds_d = _RANDOM[/*Zero width*/ 1'b0][4];	// Edges.scala:228:27, ToAXI4.scala:206:30
        r_first = _RANDOM[/*Zero width*/ 1'b0][5];	// Edges.scala:228:27, ToAXI4.scala:218:28
        r_denied_r = _RANDOM[/*Zero width*/ 1'b0][6];	// Edges.scala:228:27, Reg.scala:15:16
        count_1 = _RANDOM[/*Zero width*/ 1'b0][7];	// Edges.scala:228:27, ToAXI4.scala:248:28
        count_2 = _RANDOM[/*Zero width*/ 1'b0][9];	// Edges.scala:228:27, ToAXI4.scala:248:28
        count_3 = _RANDOM[/*Zero width*/ 1'b0][11];	// Edges.scala:228:27, ToAXI4.scala:248:28
        count_4 = _RANDOM[/*Zero width*/ 1'b0][13];	// Edges.scala:228:27, ToAXI4.scala:248:28
        count_5 = _RANDOM[/*Zero width*/ 1'b0][15];	// Edges.scala:228:27, ToAXI4.scala:248:28
        count_6 = _RANDOM[/*Zero width*/ 1'b0][17];	// Edges.scala:228:27, ToAXI4.scala:248:28
        count_7 = _RANDOM[/*Zero width*/ 1'b0][19];	// Edges.scala:228:27, ToAXI4.scala:248:28
        count_8 = _RANDOM[/*Zero width*/ 1'b0][21];	// Edges.scala:228:27, ToAXI4.scala:248:28
        count_9 = _RANDOM[/*Zero width*/ 1'b0][23];	// Edges.scala:228:27, ToAXI4.scala:248:28
        count_10 = _RANDOM[/*Zero width*/ 1'b0][25];	// Edges.scala:228:27, ToAXI4.scala:248:28
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  TLMonitor_44 monitor (	// Nodes.scala:24:25
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (bundleIn_0_a_ready),	// ToAXI4.scala:196:28
    .io_in_a_valid        (auto_in_a_valid),
    .io_in_a_bits_opcode  (auto_in_a_bits_opcode),
    .io_in_a_bits_param   (auto_in_a_bits_param),
    .io_in_a_bits_size    (auto_in_a_bits_size),
    .io_in_a_bits_source  (auto_in_a_bits_source),
    .io_in_a_bits_address (auto_in_a_bits_address),
    .io_in_a_bits_mask    (auto_in_a_bits_mask),
    .io_in_a_bits_corrupt (auto_in_a_bits_corrupt),
    .io_in_d_ready        (auto_in_d_ready),
    .io_in_d_valid        (bundleIn_0_d_valid),	// ToAXI4.scala:213:24
    .io_in_d_bits_opcode  (bundleIn_0_d_bits_opcode),	// ToAXI4.scala:231:23
    .io_in_d_bits_size    (bundleIn_0_d_bits_size),	// ToAXI4.scala:231:23
    .io_in_d_bits_source  (bundleIn_0_d_bits_source),	// ToAXI4.scala:231:23
    .io_in_d_bits_denied  (bundleIn_0_d_bits_denied),	// ToAXI4.scala:231:23
    .io_in_d_bits_corrupt (bundleIn_0_d_bits_corrupt)	// ToAXI4.scala:231:23
  );
  Queue_17 deq (	// Decoupled.scala:296:21
    .clock            (clock),
    .reset            (reset),
    .io_enq_valid
      (~stall & auto_in_a_valid & ~(auto_in_a_bits_opcode[2]) & _out_w_valid_T_3),	// Edges.scala:91:{28,37}, ToAXI4.scala:195:49, :196:{21,52}, :199:54
    .io_enq_bits_data (auto_in_a_bits_data),
    .io_enq_bits_strb (auto_in_a_bits_mask),
    .io_enq_bits_last (out_w_bits_last),	// Edges.scala:231:37
    .io_deq_ready     (auto_out_w_ready),
    .io_enq_ready     (_deq_io_enq_ready),
    .io_deq_valid     (auto_out_w_valid),
    .io_deq_bits_data (auto_out_w_bits_data),
    .io_deq_bits_strb (auto_out_w_bits_strb),
    .io_deq_bits_last (auto_out_w_bits_last)
  );
  Queue_18 queue_arw_deq (	// Decoupled.scala:296:21
    .clock                            (clock),
    .reset                            (reset),
    .io_enq_valid                     (out_arw_valid),	// ToAXI4.scala:197:45
    .io_enq_bits_id                   (_GEN[auto_in_a_bits_source]),	// ToAXI4.scala:166:17
    .io_enq_bits_addr                 (auto_in_a_bits_address),
    .io_enq_bits_len                  (~(_out_arw_bits_len_T_1[10:3])),	// package.scala:234:{46,77,82}
    .io_enq_bits_size
      (auto_in_a_bits_size > 3'h2 ? 3'h3 : auto_in_a_bits_size),	// ToAXI4.scala:169:{23,31}
    .io_enq_bits_echo_tl_state_size   ({1'h0, auto_in_a_bits_size}),	// ToAXI4.scala:179:22
    .io_enq_bits_echo_tl_state_source (auto_in_a_bits_source),
    .io_enq_bits_wen                  (~(auto_in_a_bits_opcode[2])),	// Edges.scala:91:{28,37}
    .io_deq_ready
      (_queue_arw_deq_io_deq_bits_wen ? auto_out_aw_ready : auto_out_ar_ready),	// Decoupled.scala:296:21, ToAXI4.scala:157:29
    .io_enq_ready                     (_queue_arw_deq_io_enq_ready),
    .io_deq_valid                     (_queue_arw_deq_io_deq_valid),
    .io_deq_bits_id                   (_queue_arw_deq_io_deq_bits_id),
    .io_deq_bits_addr                 (_queue_arw_deq_io_deq_bits_addr),
    .io_deq_bits_len                  (_queue_arw_deq_io_deq_bits_len),
    .io_deq_bits_size                 (_queue_arw_deq_io_deq_bits_size),
    .io_deq_bits_burst                (_queue_arw_deq_io_deq_bits_burst),
    .io_deq_bits_lock                 (_queue_arw_deq_io_deq_bits_lock),
    .io_deq_bits_cache                (_queue_arw_deq_io_deq_bits_cache),
    .io_deq_bits_prot                 (_queue_arw_deq_io_deq_bits_prot),
    .io_deq_bits_qos                  (_queue_arw_deq_io_deq_bits_qos),
    .io_deq_bits_echo_tl_state_size   (_queue_arw_deq_io_deq_bits_echo_tl_state_size),
    .io_deq_bits_echo_tl_state_source (_queue_arw_deq_io_deq_bits_echo_tl_state_source),
    .io_deq_bits_wen                  (_queue_arw_deq_io_deq_bits_wen)
  );
  assign auto_in_a_ready = bundleIn_0_a_ready;	// ToAXI4.scala:196:28
  assign auto_in_d_valid = bundleIn_0_d_valid;	// ToAXI4.scala:213:24
  assign auto_in_d_bits_opcode = bundleIn_0_d_bits_opcode;	// ToAXI4.scala:231:23
  assign auto_in_d_bits_size = bundleIn_0_d_bits_size;	// ToAXI4.scala:231:23
  assign auto_in_d_bits_source = bundleIn_0_d_bits_source;	// ToAXI4.scala:231:23
  assign auto_in_d_bits_denied = bundleIn_0_d_bits_denied;	// ToAXI4.scala:231:23
  assign auto_in_d_bits_corrupt = bundleIn_0_d_bits_corrupt;	// ToAXI4.scala:231:23
  assign auto_out_aw_valid = _queue_arw_deq_io_deq_valid & _queue_arw_deq_io_deq_bits_wen;	// Decoupled.scala:296:21, ToAXI4.scala:156:39
  assign auto_out_aw_bits_id = _queue_arw_deq_io_deq_bits_id;	// Decoupled.scala:296:21
  assign auto_out_aw_bits_addr = _queue_arw_deq_io_deq_bits_addr;	// Decoupled.scala:296:21
  assign auto_out_aw_bits_len = _queue_arw_deq_io_deq_bits_len;	// Decoupled.scala:296:21
  assign auto_out_aw_bits_size = _queue_arw_deq_io_deq_bits_size;	// Decoupled.scala:296:21
  assign auto_out_aw_bits_burst = _queue_arw_deq_io_deq_bits_burst;	// Decoupled.scala:296:21
  assign auto_out_aw_bits_lock = _queue_arw_deq_io_deq_bits_lock;	// Decoupled.scala:296:21
  assign auto_out_aw_bits_cache = _queue_arw_deq_io_deq_bits_cache;	// Decoupled.scala:296:21
  assign auto_out_aw_bits_prot = _queue_arw_deq_io_deq_bits_prot;	// Decoupled.scala:296:21
  assign auto_out_aw_bits_qos = _queue_arw_deq_io_deq_bits_qos;	// Decoupled.scala:296:21
  assign auto_out_aw_bits_echo_tl_state_size =
    _queue_arw_deq_io_deq_bits_echo_tl_state_size;	// Decoupled.scala:296:21
  assign auto_out_aw_bits_echo_tl_state_source =
    _queue_arw_deq_io_deq_bits_echo_tl_state_source;	// Decoupled.scala:296:21
  assign auto_out_b_ready = auto_in_d_ready & ~r_wins;	// ToAXI4.scala:209:32, :212:{33,36}
  assign auto_out_ar_valid =
    _queue_arw_deq_io_deq_valid & ~_queue_arw_deq_io_deq_bits_wen;	// Decoupled.scala:296:21, ToAXI4.scala:155:{39,42}
  assign auto_out_ar_bits_id = _queue_arw_deq_io_deq_bits_id;	// Decoupled.scala:296:21
  assign auto_out_ar_bits_addr = _queue_arw_deq_io_deq_bits_addr;	// Decoupled.scala:296:21
  assign auto_out_ar_bits_len = _queue_arw_deq_io_deq_bits_len;	// Decoupled.scala:296:21
  assign auto_out_ar_bits_size = _queue_arw_deq_io_deq_bits_size;	// Decoupled.scala:296:21
  assign auto_out_ar_bits_burst = _queue_arw_deq_io_deq_bits_burst;	// Decoupled.scala:296:21
  assign auto_out_ar_bits_lock = _queue_arw_deq_io_deq_bits_lock;	// Decoupled.scala:296:21
  assign auto_out_ar_bits_cache = _queue_arw_deq_io_deq_bits_cache;	// Decoupled.scala:296:21
  assign auto_out_ar_bits_prot = _queue_arw_deq_io_deq_bits_prot;	// Decoupled.scala:296:21
  assign auto_out_ar_bits_qos = _queue_arw_deq_io_deq_bits_qos;	// Decoupled.scala:296:21
  assign auto_out_ar_bits_echo_tl_state_size =
    _queue_arw_deq_io_deq_bits_echo_tl_state_size;	// Decoupled.scala:296:21
  assign auto_out_ar_bits_echo_tl_state_source =
    _queue_arw_deq_io_deq_bits_echo_tl_state_source;	// Decoupled.scala:296:21
endmodule

