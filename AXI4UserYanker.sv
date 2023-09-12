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

module AXI4UserYanker(
  input         clock,
                reset,
                auto_in_aw_valid,
  input  [3:0]  auto_in_aw_bits_id,
  input  [31:0] auto_in_aw_bits_addr,
  input  [7:0]  auto_in_aw_bits_len,
  input  [2:0]  auto_in_aw_bits_size,
  input  [1:0]  auto_in_aw_bits_burst,
  input         auto_in_aw_bits_lock,
  input  [3:0]  auto_in_aw_bits_cache,
  input  [2:0]  auto_in_aw_bits_prot,
  input  [3:0]  auto_in_aw_bits_qos,
                auto_in_aw_bits_echo_tl_state_size,
                auto_in_aw_bits_echo_tl_state_source,
  input         auto_in_w_valid,
  input  [63:0] auto_in_w_bits_data,
  input  [7:0]  auto_in_w_bits_strb,
  input         auto_in_w_bits_last,
                auto_in_b_ready,
                auto_in_ar_valid,
  input  [3:0]  auto_in_ar_bits_id,
  input  [31:0] auto_in_ar_bits_addr,
  input  [7:0]  auto_in_ar_bits_len,
  input  [2:0]  auto_in_ar_bits_size,
  input  [1:0]  auto_in_ar_bits_burst,
  input         auto_in_ar_bits_lock,
  input  [3:0]  auto_in_ar_bits_cache,
  input  [2:0]  auto_in_ar_bits_prot,
  input  [3:0]  auto_in_ar_bits_qos,
                auto_in_ar_bits_echo_tl_state_size,
                auto_in_ar_bits_echo_tl_state_source,
  input         auto_in_r_ready,
                auto_out_aw_ready,
                auto_out_w_ready,
                auto_out_b_valid,
  input  [3:0]  auto_out_b_bits_id,
  input  [1:0]  auto_out_b_bits_resp,
  input         auto_out_ar_ready,
                auto_out_r_valid,
  input  [3:0]  auto_out_r_bits_id,
  input  [63:0] auto_out_r_bits_data,
  input  [1:0]  auto_out_r_bits_resp,
  input         auto_out_r_bits_last,
  output        auto_in_aw_ready,
                auto_in_w_ready,
                auto_in_b_valid,
  output [3:0]  auto_in_b_bits_id,
  output [1:0]  auto_in_b_bits_resp,
  output [3:0]  auto_in_b_bits_echo_tl_state_size,
                auto_in_b_bits_echo_tl_state_source,
  output        auto_in_ar_ready,
                auto_in_r_valid,
  output [3:0]  auto_in_r_bits_id,
  output [63:0] auto_in_r_bits_data,
  output [1:0]  auto_in_r_bits_resp,
  output [3:0]  auto_in_r_bits_echo_tl_state_size,
                auto_in_r_bits_echo_tl_state_source,
  output        auto_in_r_bits_last,
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
  output        auto_out_r_ready
);

  wire             _QueueCompatibility_19_io_enq_ready;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_19_io_deq_valid;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_19_io_deq_bits_tl_state_size;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_19_io_deq_bits_tl_state_source;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_18_io_enq_ready;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_18_io_deq_valid;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_18_io_deq_bits_tl_state_size;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_18_io_deq_bits_tl_state_source;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_17_io_enq_ready;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_17_io_deq_valid;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_17_io_deq_bits_tl_state_size;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_17_io_deq_bits_tl_state_source;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_16_io_enq_ready;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_16_io_deq_valid;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_16_io_deq_bits_tl_state_size;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_16_io_deq_bits_tl_state_source;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_15_io_enq_ready;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_15_io_deq_valid;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_15_io_deq_bits_tl_state_size;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_15_io_deq_bits_tl_state_source;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_14_io_enq_ready;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_14_io_deq_valid;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_14_io_deq_bits_tl_state_size;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_14_io_deq_bits_tl_state_source;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_13_io_enq_ready;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_13_io_deq_valid;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_13_io_deq_bits_tl_state_size;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_13_io_deq_bits_tl_state_source;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_12_io_enq_ready;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_12_io_deq_valid;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_12_io_deq_bits_tl_state_size;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_12_io_deq_bits_tl_state_source;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_11_io_enq_ready;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_11_io_deq_valid;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_11_io_deq_bits_tl_state_size;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_11_io_deq_bits_tl_state_source;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_10_io_enq_ready;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_10_io_deq_valid;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_10_io_deq_bits_tl_state_size;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_10_io_deq_bits_tl_state_source;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_9_io_enq_ready;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_9_io_deq_valid;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_9_io_deq_bits_tl_state_size;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_9_io_deq_bits_tl_state_source;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_8_io_enq_ready;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_8_io_deq_valid;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_8_io_deq_bits_tl_state_size;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_8_io_deq_bits_tl_state_source;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_7_io_enq_ready;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_7_io_deq_valid;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_7_io_deq_bits_tl_state_size;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_7_io_deq_bits_tl_state_source;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_6_io_enq_ready;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_6_io_deq_valid;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_6_io_deq_bits_tl_state_size;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_6_io_deq_bits_tl_state_source;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_5_io_enq_ready;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_5_io_deq_valid;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_5_io_deq_bits_tl_state_size;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_5_io_deq_bits_tl_state_source;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_4_io_enq_ready;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_4_io_deq_valid;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_4_io_deq_bits_tl_state_size;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_4_io_deq_bits_tl_state_source;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_3_io_enq_ready;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_3_io_deq_valid;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_3_io_deq_bits_tl_state_size;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_3_io_deq_bits_tl_state_source;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_2_io_enq_ready;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_2_io_deq_valid;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_2_io_deq_bits_tl_state_size;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_2_io_deq_bits_tl_state_source;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_1_io_enq_ready;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_1_io_deq_valid;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_1_io_deq_bits_tl_state_size;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_1_io_deq_bits_tl_state_source;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_io_enq_ready;	// UserYanker.scala:47:17
  wire             _QueueCompatibility_io_deq_valid;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_io_deq_bits_tl_state_size;	// UserYanker.scala:47:17
  wire [3:0]       _QueueCompatibility_io_deq_bits_tl_state_source;	// UserYanker.scala:47:17
  wire [15:0]      _GEN =
    {{1'h0},
     {1'h0},
     {1'h0},
     {1'h0},
     {1'h0},
     {1'h0},
     {_QueueCompatibility_9_io_enq_ready},
     {_QueueCompatibility_8_io_enq_ready},
     {_QueueCompatibility_7_io_enq_ready},
     {_QueueCompatibility_6_io_enq_ready},
     {_QueueCompatibility_5_io_enq_ready},
     {_QueueCompatibility_4_io_enq_ready},
     {_QueueCompatibility_3_io_enq_ready},
     {_QueueCompatibility_2_io_enq_ready},
     {_QueueCompatibility_1_io_enq_ready},
     {_QueueCompatibility_io_enq_ready}};	// UserYanker.scala:45:15, :47:17, :56:36
  wire [15:0][3:0] _GEN_0 =
    {{4'h0},
     {4'h0},
     {4'h0},
     {4'h0},
     {4'h0},
     {4'h0},
     {_QueueCompatibility_9_io_deq_bits_tl_state_size},
     {_QueueCompatibility_8_io_deq_bits_tl_state_size},
     {_QueueCompatibility_7_io_deq_bits_tl_state_size},
     {_QueueCompatibility_6_io_deq_bits_tl_state_size},
     {_QueueCompatibility_5_io_deq_bits_tl_state_size},
     {_QueueCompatibility_4_io_deq_bits_tl_state_size},
     {_QueueCompatibility_3_io_deq_bits_tl_state_size},
     {_QueueCompatibility_2_io_deq_bits_tl_state_size},
     {_QueueCompatibility_1_io_deq_bits_tl_state_size},
     {_QueueCompatibility_io_deq_bits_tl_state_size}};	// BundleMap.scala:247:19, UserYanker.scala:45:15, :47:17
  wire [15:0][3:0] _GEN_1 =
    {{4'h0},
     {4'h0},
     {4'h0},
     {4'h0},
     {4'h0},
     {4'h0},
     {_QueueCompatibility_9_io_deq_bits_tl_state_source},
     {_QueueCompatibility_8_io_deq_bits_tl_state_source},
     {_QueueCompatibility_7_io_deq_bits_tl_state_source},
     {_QueueCompatibility_6_io_deq_bits_tl_state_source},
     {_QueueCompatibility_5_io_deq_bits_tl_state_source},
     {_QueueCompatibility_4_io_deq_bits_tl_state_source},
     {_QueueCompatibility_3_io_deq_bits_tl_state_source},
     {_QueueCompatibility_2_io_deq_bits_tl_state_source},
     {_QueueCompatibility_1_io_deq_bits_tl_state_source},
     {_QueueCompatibility_io_deq_bits_tl_state_source}};	// BundleMap.scala:247:19, UserYanker.scala:45:15, :47:17
  wire             _rqueues_15_deq_ready_T = auto_out_r_valid & auto_in_r_ready;	// UserYanker.scala:70:37
  wire             _rqueues_15_enq_valid_T = auto_in_ar_valid & auto_out_ar_ready;	// UserYanker.scala:71:37
  wire [15:0]      _GEN_2 =
    {{1'h0},
     {1'h0},
     {1'h0},
     {1'h0},
     {1'h0},
     {1'h0},
     {_QueueCompatibility_19_io_enq_ready},
     {_QueueCompatibility_18_io_enq_ready},
     {_QueueCompatibility_17_io_enq_ready},
     {_QueueCompatibility_16_io_enq_ready},
     {_QueueCompatibility_15_io_enq_ready},
     {_QueueCompatibility_14_io_enq_ready},
     {_QueueCompatibility_13_io_enq_ready},
     {_QueueCompatibility_12_io_enq_ready},
     {_QueueCompatibility_11_io_enq_ready},
     {_QueueCompatibility_10_io_enq_ready}};	// UserYanker.scala:45:15, :47:17, :77:36
  `ifndef SYNTHESIS	// UserYanker.scala:63:14
    always @(posedge clock) begin	// UserYanker.scala:63:14
      automatic logic [15:0] _GEN_3 =
        {{1'h0},
         {1'h0},
         {1'h0},
         {1'h0},
         {1'h0},
         {1'h0},
         {_QueueCompatibility_9_io_deq_valid},
         {_QueueCompatibility_8_io_deq_valid},
         {_QueueCompatibility_7_io_deq_valid},
         {_QueueCompatibility_6_io_deq_valid},
         {_QueueCompatibility_5_io_deq_valid},
         {_QueueCompatibility_4_io_deq_valid},
         {_QueueCompatibility_3_io_deq_valid},
         {_QueueCompatibility_2_io_deq_valid},
         {_QueueCompatibility_1_io_deq_valid},
         {_QueueCompatibility_io_deq_valid}};	// UserYanker.scala:45:15, :47:17, :63:28
      automatic logic [15:0] _GEN_4 =
        {{1'h0},
         {1'h0},
         {1'h0},
         {1'h0},
         {1'h0},
         {1'h0},
         {_QueueCompatibility_19_io_deq_valid},
         {_QueueCompatibility_18_io_deq_valid},
         {_QueueCompatibility_17_io_deq_valid},
         {_QueueCompatibility_16_io_deq_valid},
         {_QueueCompatibility_15_io_deq_valid},
         {_QueueCompatibility_14_io_deq_valid},
         {_QueueCompatibility_13_io_deq_valid},
         {_QueueCompatibility_12_io_deq_valid},
         {_QueueCompatibility_11_io_deq_valid},
         {_QueueCompatibility_10_io_deq_valid}};	// UserYanker.scala:45:15, :47:17, :84:28
      if (~(~auto_out_r_valid | _GEN_3[auto_out_r_bits_id] | reset)) begin	// UserYanker.scala:63:{14,15,28}
        if (`ASSERT_VERBOSE_COND_)	// UserYanker.scala:63:14
          $error("Assertion failed\n    at UserYanker.scala:63 assert (!out.r.valid || r_valid) // Q must be ready faster than the response\n");	// UserYanker.scala:63:14
        if (`STOP_COND_)	// UserYanker.scala:63:14
          $fatal;	// UserYanker.scala:63:14
      end
      if (~(~auto_out_b_valid | _GEN_4[auto_out_b_bits_id] | reset)) begin	// UserYanker.scala:84:{14,15,28}
        if (`ASSERT_VERBOSE_COND_)	// UserYanker.scala:84:14
          $error("Assertion failed\n    at UserYanker.scala:84 assert (!out.b.valid || b_valid) // Q must be ready faster than the response\n");	// UserYanker.scala:84:14
        if (`STOP_COND_)	// UserYanker.scala:84:14
          $fatal;	// UserYanker.scala:84:14
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  wire [15:0][3:0] _GEN_5 =
    {{4'h0},
     {4'h0},
     {4'h0},
     {4'h0},
     {4'h0},
     {4'h0},
     {_QueueCompatibility_19_io_deq_bits_tl_state_size},
     {_QueueCompatibility_18_io_deq_bits_tl_state_size},
     {_QueueCompatibility_17_io_deq_bits_tl_state_size},
     {_QueueCompatibility_16_io_deq_bits_tl_state_size},
     {_QueueCompatibility_15_io_deq_bits_tl_state_size},
     {_QueueCompatibility_14_io_deq_bits_tl_state_size},
     {_QueueCompatibility_13_io_deq_bits_tl_state_size},
     {_QueueCompatibility_12_io_deq_bits_tl_state_size},
     {_QueueCompatibility_11_io_deq_bits_tl_state_size},
     {_QueueCompatibility_10_io_deq_bits_tl_state_size}};	// BundleMap.scala:247:19, UserYanker.scala:45:15, :47:17
  wire [15:0][3:0] _GEN_6 =
    {{4'h0},
     {4'h0},
     {4'h0},
     {4'h0},
     {4'h0},
     {4'h0},
     {_QueueCompatibility_19_io_deq_bits_tl_state_source},
     {_QueueCompatibility_18_io_deq_bits_tl_state_source},
     {_QueueCompatibility_17_io_deq_bits_tl_state_source},
     {_QueueCompatibility_16_io_deq_bits_tl_state_source},
     {_QueueCompatibility_15_io_deq_bits_tl_state_source},
     {_QueueCompatibility_14_io_deq_bits_tl_state_source},
     {_QueueCompatibility_13_io_deq_bits_tl_state_source},
     {_QueueCompatibility_12_io_deq_bits_tl_state_source},
     {_QueueCompatibility_11_io_deq_bits_tl_state_source},
     {_QueueCompatibility_10_io_deq_bits_tl_state_source}};	// BundleMap.scala:247:19, UserYanker.scala:45:15, :47:17
  wire             _wqueues_15_deq_ready_T = auto_out_b_valid & auto_in_b_ready;	// UserYanker.scala:91:37
  wire             _wqueues_15_enq_valid_T = auto_in_aw_valid & auto_out_aw_ready;	// UserYanker.scala:92:37
  QueueCompatibility QueueCompatibility (	// UserYanker.scala:47:17
    .clock                       (clock),
    .reset                       (reset),
    .io_enq_valid                (_rqueues_15_enq_valid_T & auto_in_ar_bits_id == 4'h0),	// UserYanker.scala:45:15, :67:55, :71:{37,53}
    .io_enq_bits_tl_state_size   (auto_in_ar_bits_echo_tl_state_size),
    .io_enq_bits_tl_state_source (auto_in_ar_bits_echo_tl_state_source),
    .io_deq_ready
      (_rqueues_15_deq_ready_T & auto_out_r_bits_id == 4'h0 & auto_out_r_bits_last),	// UserYanker.scala:45:15, :68:55, :70:{37,58}
    .io_enq_ready                (_QueueCompatibility_io_enq_ready),
    .io_deq_valid                (_QueueCompatibility_io_deq_valid),
    .io_deq_bits_tl_state_size   (_QueueCompatibility_io_deq_bits_tl_state_size),
    .io_deq_bits_tl_state_source (_QueueCompatibility_io_deq_bits_tl_state_source)
  );
  QueueCompatibility QueueCompatibility_1 (	// UserYanker.scala:47:17
    .clock                       (clock),
    .reset                       (reset),
    .io_enq_valid                (_rqueues_15_enq_valid_T & auto_in_ar_bits_id == 4'h1),	// OneHot.scala:65:12, UserYanker.scala:67:55, :71:{37,53}
    .io_enq_bits_tl_state_size   (auto_in_ar_bits_echo_tl_state_size),
    .io_enq_bits_tl_state_source (auto_in_ar_bits_echo_tl_state_source),
    .io_deq_ready
      (_rqueues_15_deq_ready_T & auto_out_r_bits_id == 4'h1 & auto_out_r_bits_last),	// OneHot.scala:65:12, UserYanker.scala:68:55, :70:{37,58}
    .io_enq_ready                (_QueueCompatibility_1_io_enq_ready),
    .io_deq_valid                (_QueueCompatibility_1_io_deq_valid),
    .io_deq_bits_tl_state_size   (_QueueCompatibility_1_io_deq_bits_tl_state_size),
    .io_deq_bits_tl_state_source (_QueueCompatibility_1_io_deq_bits_tl_state_source)
  );
  QueueCompatibility QueueCompatibility_2 (	// UserYanker.scala:47:17
    .clock                       (clock),
    .reset                       (reset),
    .io_enq_valid                (_rqueues_15_enq_valid_T & auto_in_ar_bits_id == 4'h2),	// OneHot.scala:65:12, UserYanker.scala:67:55, :71:{37,53}
    .io_enq_bits_tl_state_size   (auto_in_ar_bits_echo_tl_state_size),
    .io_enq_bits_tl_state_source (auto_in_ar_bits_echo_tl_state_source),
    .io_deq_ready
      (_rqueues_15_deq_ready_T & auto_out_r_bits_id == 4'h2 & auto_out_r_bits_last),	// OneHot.scala:65:12, UserYanker.scala:68:55, :70:{37,58}
    .io_enq_ready                (_QueueCompatibility_2_io_enq_ready),
    .io_deq_valid                (_QueueCompatibility_2_io_deq_valid),
    .io_deq_bits_tl_state_size   (_QueueCompatibility_2_io_deq_bits_tl_state_size),
    .io_deq_bits_tl_state_source (_QueueCompatibility_2_io_deq_bits_tl_state_source)
  );
  QueueCompatibility QueueCompatibility_3 (	// UserYanker.scala:47:17
    .clock                       (clock),
    .reset                       (reset),
    .io_enq_valid                (_rqueues_15_enq_valid_T & auto_in_ar_bits_id == 4'h3),	// OneHot.scala:65:12, UserYanker.scala:67:55, :71:{37,53}
    .io_enq_bits_tl_state_size   (auto_in_ar_bits_echo_tl_state_size),
    .io_enq_bits_tl_state_source (auto_in_ar_bits_echo_tl_state_source),
    .io_deq_ready
      (_rqueues_15_deq_ready_T & auto_out_r_bits_id == 4'h3 & auto_out_r_bits_last),	// OneHot.scala:65:12, UserYanker.scala:68:55, :70:{37,58}
    .io_enq_ready                (_QueueCompatibility_3_io_enq_ready),
    .io_deq_valid                (_QueueCompatibility_3_io_deq_valid),
    .io_deq_bits_tl_state_size   (_QueueCompatibility_3_io_deq_bits_tl_state_size),
    .io_deq_bits_tl_state_source (_QueueCompatibility_3_io_deq_bits_tl_state_source)
  );
  QueueCompatibility QueueCompatibility_4 (	// UserYanker.scala:47:17
    .clock                       (clock),
    .reset                       (reset),
    .io_enq_valid                (_rqueues_15_enq_valid_T & auto_in_ar_bits_id == 4'h4),	// OneHot.scala:65:12, UserYanker.scala:67:55, :71:{37,53}
    .io_enq_bits_tl_state_size   (auto_in_ar_bits_echo_tl_state_size),
    .io_enq_bits_tl_state_source (auto_in_ar_bits_echo_tl_state_source),
    .io_deq_ready
      (_rqueues_15_deq_ready_T & auto_out_r_bits_id == 4'h4 & auto_out_r_bits_last),	// OneHot.scala:65:12, UserYanker.scala:68:55, :70:{37,58}
    .io_enq_ready                (_QueueCompatibility_4_io_enq_ready),
    .io_deq_valid                (_QueueCompatibility_4_io_deq_valid),
    .io_deq_bits_tl_state_size   (_QueueCompatibility_4_io_deq_bits_tl_state_size),
    .io_deq_bits_tl_state_source (_QueueCompatibility_4_io_deq_bits_tl_state_source)
  );
  QueueCompatibility QueueCompatibility_5 (	// UserYanker.scala:47:17
    .clock                       (clock),
    .reset                       (reset),
    .io_enq_valid                (_rqueues_15_enq_valid_T & auto_in_ar_bits_id == 4'h5),	// OneHot.scala:65:12, UserYanker.scala:67:55, :71:{37,53}
    .io_enq_bits_tl_state_size   (auto_in_ar_bits_echo_tl_state_size),
    .io_enq_bits_tl_state_source (auto_in_ar_bits_echo_tl_state_source),
    .io_deq_ready
      (_rqueues_15_deq_ready_T & auto_out_r_bits_id == 4'h5 & auto_out_r_bits_last),	// OneHot.scala:65:12, UserYanker.scala:68:55, :70:{37,58}
    .io_enq_ready                (_QueueCompatibility_5_io_enq_ready),
    .io_deq_valid                (_QueueCompatibility_5_io_deq_valid),
    .io_deq_bits_tl_state_size   (_QueueCompatibility_5_io_deq_bits_tl_state_size),
    .io_deq_bits_tl_state_source (_QueueCompatibility_5_io_deq_bits_tl_state_source)
  );
  QueueCompatibility QueueCompatibility_6 (	// UserYanker.scala:47:17
    .clock                       (clock),
    .reset                       (reset),
    .io_enq_valid                (_rqueues_15_enq_valid_T & auto_in_ar_bits_id == 4'h6),	// OneHot.scala:65:12, UserYanker.scala:67:55, :71:{37,53}
    .io_enq_bits_tl_state_size   (auto_in_ar_bits_echo_tl_state_size),
    .io_enq_bits_tl_state_source (auto_in_ar_bits_echo_tl_state_source),
    .io_deq_ready
      (_rqueues_15_deq_ready_T & auto_out_r_bits_id == 4'h6 & auto_out_r_bits_last),	// OneHot.scala:65:12, UserYanker.scala:68:55, :70:{37,58}
    .io_enq_ready                (_QueueCompatibility_6_io_enq_ready),
    .io_deq_valid                (_QueueCompatibility_6_io_deq_valid),
    .io_deq_bits_tl_state_size   (_QueueCompatibility_6_io_deq_bits_tl_state_size),
    .io_deq_bits_tl_state_source (_QueueCompatibility_6_io_deq_bits_tl_state_source)
  );
  QueueCompatibility QueueCompatibility_7 (	// UserYanker.scala:47:17
    .clock                       (clock),
    .reset                       (reset),
    .io_enq_valid                (_rqueues_15_enq_valid_T & auto_in_ar_bits_id == 4'h7),	// OneHot.scala:65:12, UserYanker.scala:67:55, :71:{37,53}
    .io_enq_bits_tl_state_size   (auto_in_ar_bits_echo_tl_state_size),
    .io_enq_bits_tl_state_source (auto_in_ar_bits_echo_tl_state_source),
    .io_deq_ready
      (_rqueues_15_deq_ready_T & auto_out_r_bits_id == 4'h7 & auto_out_r_bits_last),	// OneHot.scala:65:12, UserYanker.scala:68:55, :70:{37,58}
    .io_enq_ready                (_QueueCompatibility_7_io_enq_ready),
    .io_deq_valid                (_QueueCompatibility_7_io_deq_valid),
    .io_deq_bits_tl_state_size   (_QueueCompatibility_7_io_deq_bits_tl_state_size),
    .io_deq_bits_tl_state_source (_QueueCompatibility_7_io_deq_bits_tl_state_source)
  );
  QueueCompatibility QueueCompatibility_8 (	// UserYanker.scala:47:17
    .clock                       (clock),
    .reset                       (reset),
    .io_enq_valid                (_rqueues_15_enq_valid_T & auto_in_ar_bits_id == 4'h8),	// OneHot.scala:65:12, UserYanker.scala:67:55, :71:{37,53}
    .io_enq_bits_tl_state_size   (auto_in_ar_bits_echo_tl_state_size),
    .io_enq_bits_tl_state_source (auto_in_ar_bits_echo_tl_state_source),
    .io_deq_ready
      (_rqueues_15_deq_ready_T & auto_out_r_bits_id == 4'h8 & auto_out_r_bits_last),	// OneHot.scala:65:12, UserYanker.scala:68:55, :70:{37,58}
    .io_enq_ready                (_QueueCompatibility_8_io_enq_ready),
    .io_deq_valid                (_QueueCompatibility_8_io_deq_valid),
    .io_deq_bits_tl_state_size   (_QueueCompatibility_8_io_deq_bits_tl_state_size),
    .io_deq_bits_tl_state_source (_QueueCompatibility_8_io_deq_bits_tl_state_source)
  );
  QueueCompatibility QueueCompatibility_9 (	// UserYanker.scala:47:17
    .clock                       (clock),
    .reset                       (reset),
    .io_enq_valid                (_rqueues_15_enq_valid_T & auto_in_ar_bits_id == 4'h9),	// OneHot.scala:65:12, UserYanker.scala:67:55, :71:{37,53}
    .io_enq_bits_tl_state_size   (auto_in_ar_bits_echo_tl_state_size),
    .io_enq_bits_tl_state_source (auto_in_ar_bits_echo_tl_state_source),
    .io_deq_ready
      (_rqueues_15_deq_ready_T & auto_out_r_bits_id == 4'h9 & auto_out_r_bits_last),	// OneHot.scala:65:12, UserYanker.scala:68:55, :70:{37,58}
    .io_enq_ready                (_QueueCompatibility_9_io_enq_ready),
    .io_deq_valid                (_QueueCompatibility_9_io_deq_valid),
    .io_deq_bits_tl_state_size   (_QueueCompatibility_9_io_deq_bits_tl_state_size),
    .io_deq_bits_tl_state_source (_QueueCompatibility_9_io_deq_bits_tl_state_source)
  );
  QueueCompatibility QueueCompatibility_10 (	// UserYanker.scala:47:17
    .clock                       (clock),
    .reset                       (reset),
    .io_enq_valid                (_wqueues_15_enq_valid_T & auto_in_aw_bits_id == 4'h0),	// UserYanker.scala:45:15, :88:55, :92:{37,53}
    .io_enq_bits_tl_state_size   (auto_in_aw_bits_echo_tl_state_size),
    .io_enq_bits_tl_state_source (auto_in_aw_bits_echo_tl_state_source),
    .io_deq_ready                (_wqueues_15_deq_ready_T & auto_out_b_bits_id == 4'h0),	// UserYanker.scala:45:15, :89:55, :91:{37,53}
    .io_enq_ready                (_QueueCompatibility_10_io_enq_ready),
    .io_deq_valid                (_QueueCompatibility_10_io_deq_valid),
    .io_deq_bits_tl_state_size   (_QueueCompatibility_10_io_deq_bits_tl_state_size),
    .io_deq_bits_tl_state_source (_QueueCompatibility_10_io_deq_bits_tl_state_source)
  );
  QueueCompatibility QueueCompatibility_11 (	// UserYanker.scala:47:17
    .clock                       (clock),
    .reset                       (reset),
    .io_enq_valid                (_wqueues_15_enq_valid_T & auto_in_aw_bits_id == 4'h1),	// OneHot.scala:65:12, UserYanker.scala:88:55, :92:{37,53}
    .io_enq_bits_tl_state_size   (auto_in_aw_bits_echo_tl_state_size),
    .io_enq_bits_tl_state_source (auto_in_aw_bits_echo_tl_state_source),
    .io_deq_ready                (_wqueues_15_deq_ready_T & auto_out_b_bits_id == 4'h1),	// OneHot.scala:65:12, UserYanker.scala:89:55, :91:{37,53}
    .io_enq_ready                (_QueueCompatibility_11_io_enq_ready),
    .io_deq_valid                (_QueueCompatibility_11_io_deq_valid),
    .io_deq_bits_tl_state_size   (_QueueCompatibility_11_io_deq_bits_tl_state_size),
    .io_deq_bits_tl_state_source (_QueueCompatibility_11_io_deq_bits_tl_state_source)
  );
  QueueCompatibility QueueCompatibility_12 (	// UserYanker.scala:47:17
    .clock                       (clock),
    .reset                       (reset),
    .io_enq_valid                (_wqueues_15_enq_valid_T & auto_in_aw_bits_id == 4'h2),	// OneHot.scala:65:12, UserYanker.scala:88:55, :92:{37,53}
    .io_enq_bits_tl_state_size   (auto_in_aw_bits_echo_tl_state_size),
    .io_enq_bits_tl_state_source (auto_in_aw_bits_echo_tl_state_source),
    .io_deq_ready                (_wqueues_15_deq_ready_T & auto_out_b_bits_id == 4'h2),	// OneHot.scala:65:12, UserYanker.scala:89:55, :91:{37,53}
    .io_enq_ready                (_QueueCompatibility_12_io_enq_ready),
    .io_deq_valid                (_QueueCompatibility_12_io_deq_valid),
    .io_deq_bits_tl_state_size   (_QueueCompatibility_12_io_deq_bits_tl_state_size),
    .io_deq_bits_tl_state_source (_QueueCompatibility_12_io_deq_bits_tl_state_source)
  );
  QueueCompatibility QueueCompatibility_13 (	// UserYanker.scala:47:17
    .clock                       (clock),
    .reset                       (reset),
    .io_enq_valid                (_wqueues_15_enq_valid_T & auto_in_aw_bits_id == 4'h3),	// OneHot.scala:65:12, UserYanker.scala:88:55, :92:{37,53}
    .io_enq_bits_tl_state_size   (auto_in_aw_bits_echo_tl_state_size),
    .io_enq_bits_tl_state_source (auto_in_aw_bits_echo_tl_state_source),
    .io_deq_ready                (_wqueues_15_deq_ready_T & auto_out_b_bits_id == 4'h3),	// OneHot.scala:65:12, UserYanker.scala:89:55, :91:{37,53}
    .io_enq_ready                (_QueueCompatibility_13_io_enq_ready),
    .io_deq_valid                (_QueueCompatibility_13_io_deq_valid),
    .io_deq_bits_tl_state_size   (_QueueCompatibility_13_io_deq_bits_tl_state_size),
    .io_deq_bits_tl_state_source (_QueueCompatibility_13_io_deq_bits_tl_state_source)
  );
  QueueCompatibility QueueCompatibility_14 (	// UserYanker.scala:47:17
    .clock                       (clock),
    .reset                       (reset),
    .io_enq_valid                (_wqueues_15_enq_valid_T & auto_in_aw_bits_id == 4'h4),	// OneHot.scala:65:12, UserYanker.scala:88:55, :92:{37,53}
    .io_enq_bits_tl_state_size   (auto_in_aw_bits_echo_tl_state_size),
    .io_enq_bits_tl_state_source (auto_in_aw_bits_echo_tl_state_source),
    .io_deq_ready                (_wqueues_15_deq_ready_T & auto_out_b_bits_id == 4'h4),	// OneHot.scala:65:12, UserYanker.scala:89:55, :91:{37,53}
    .io_enq_ready                (_QueueCompatibility_14_io_enq_ready),
    .io_deq_valid                (_QueueCompatibility_14_io_deq_valid),
    .io_deq_bits_tl_state_size   (_QueueCompatibility_14_io_deq_bits_tl_state_size),
    .io_deq_bits_tl_state_source (_QueueCompatibility_14_io_deq_bits_tl_state_source)
  );
  QueueCompatibility QueueCompatibility_15 (	// UserYanker.scala:47:17
    .clock                       (clock),
    .reset                       (reset),
    .io_enq_valid                (_wqueues_15_enq_valid_T & auto_in_aw_bits_id == 4'h5),	// OneHot.scala:65:12, UserYanker.scala:88:55, :92:{37,53}
    .io_enq_bits_tl_state_size   (auto_in_aw_bits_echo_tl_state_size),
    .io_enq_bits_tl_state_source (auto_in_aw_bits_echo_tl_state_source),
    .io_deq_ready                (_wqueues_15_deq_ready_T & auto_out_b_bits_id == 4'h5),	// OneHot.scala:65:12, UserYanker.scala:89:55, :91:{37,53}
    .io_enq_ready                (_QueueCompatibility_15_io_enq_ready),
    .io_deq_valid                (_QueueCompatibility_15_io_deq_valid),
    .io_deq_bits_tl_state_size   (_QueueCompatibility_15_io_deq_bits_tl_state_size),
    .io_deq_bits_tl_state_source (_QueueCompatibility_15_io_deq_bits_tl_state_source)
  );
  QueueCompatibility QueueCompatibility_16 (	// UserYanker.scala:47:17
    .clock                       (clock),
    .reset                       (reset),
    .io_enq_valid                (_wqueues_15_enq_valid_T & auto_in_aw_bits_id == 4'h6),	// OneHot.scala:65:12, UserYanker.scala:88:55, :92:{37,53}
    .io_enq_bits_tl_state_size   (auto_in_aw_bits_echo_tl_state_size),
    .io_enq_bits_tl_state_source (auto_in_aw_bits_echo_tl_state_source),
    .io_deq_ready                (_wqueues_15_deq_ready_T & auto_out_b_bits_id == 4'h6),	// OneHot.scala:65:12, UserYanker.scala:89:55, :91:{37,53}
    .io_enq_ready                (_QueueCompatibility_16_io_enq_ready),
    .io_deq_valid                (_QueueCompatibility_16_io_deq_valid),
    .io_deq_bits_tl_state_size   (_QueueCompatibility_16_io_deq_bits_tl_state_size),
    .io_deq_bits_tl_state_source (_QueueCompatibility_16_io_deq_bits_tl_state_source)
  );
  QueueCompatibility QueueCompatibility_17 (	// UserYanker.scala:47:17
    .clock                       (clock),
    .reset                       (reset),
    .io_enq_valid                (_wqueues_15_enq_valid_T & auto_in_aw_bits_id == 4'h7),	// OneHot.scala:65:12, UserYanker.scala:88:55, :92:{37,53}
    .io_enq_bits_tl_state_size   (auto_in_aw_bits_echo_tl_state_size),
    .io_enq_bits_tl_state_source (auto_in_aw_bits_echo_tl_state_source),
    .io_deq_ready                (_wqueues_15_deq_ready_T & auto_out_b_bits_id == 4'h7),	// OneHot.scala:65:12, UserYanker.scala:89:55, :91:{37,53}
    .io_enq_ready                (_QueueCompatibility_17_io_enq_ready),
    .io_deq_valid                (_QueueCompatibility_17_io_deq_valid),
    .io_deq_bits_tl_state_size   (_QueueCompatibility_17_io_deq_bits_tl_state_size),
    .io_deq_bits_tl_state_source (_QueueCompatibility_17_io_deq_bits_tl_state_source)
  );
  QueueCompatibility QueueCompatibility_18 (	// UserYanker.scala:47:17
    .clock                       (clock),
    .reset                       (reset),
    .io_enq_valid                (_wqueues_15_enq_valid_T & auto_in_aw_bits_id == 4'h8),	// OneHot.scala:65:12, UserYanker.scala:88:55, :92:{37,53}
    .io_enq_bits_tl_state_size   (auto_in_aw_bits_echo_tl_state_size),
    .io_enq_bits_tl_state_source (auto_in_aw_bits_echo_tl_state_source),
    .io_deq_ready                (_wqueues_15_deq_ready_T & auto_out_b_bits_id == 4'h8),	// OneHot.scala:65:12, UserYanker.scala:89:55, :91:{37,53}
    .io_enq_ready                (_QueueCompatibility_18_io_enq_ready),
    .io_deq_valid                (_QueueCompatibility_18_io_deq_valid),
    .io_deq_bits_tl_state_size   (_QueueCompatibility_18_io_deq_bits_tl_state_size),
    .io_deq_bits_tl_state_source (_QueueCompatibility_18_io_deq_bits_tl_state_source)
  );
  QueueCompatibility QueueCompatibility_19 (	// UserYanker.scala:47:17
    .clock                       (clock),
    .reset                       (reset),
    .io_enq_valid                (_wqueues_15_enq_valid_T & auto_in_aw_bits_id == 4'h9),	// OneHot.scala:65:12, UserYanker.scala:88:55, :92:{37,53}
    .io_enq_bits_tl_state_size   (auto_in_aw_bits_echo_tl_state_size),
    .io_enq_bits_tl_state_source (auto_in_aw_bits_echo_tl_state_source),
    .io_deq_ready                (_wqueues_15_deq_ready_T & auto_out_b_bits_id == 4'h9),	// OneHot.scala:65:12, UserYanker.scala:89:55, :91:{37,53}
    .io_enq_ready                (_QueueCompatibility_19_io_enq_ready),
    .io_deq_valid                (_QueueCompatibility_19_io_deq_valid),
    .io_deq_bits_tl_state_size   (_QueueCompatibility_19_io_deq_bits_tl_state_size),
    .io_deq_bits_tl_state_source (_QueueCompatibility_19_io_deq_bits_tl_state_source)
  );
  assign auto_in_aw_ready = auto_out_aw_ready & _GEN_2[auto_in_aw_bits_id];	// UserYanker.scala:77:36
  assign auto_in_w_ready = auto_out_w_ready;
  assign auto_in_b_valid = auto_out_b_valid;
  assign auto_in_b_bits_id = auto_out_b_bits_id;
  assign auto_in_b_bits_resp = auto_out_b_bits_resp;
  assign auto_in_b_bits_echo_tl_state_size = _GEN_5[auto_out_b_bits_id];	// BundleMap.scala:247:19
  assign auto_in_b_bits_echo_tl_state_source = _GEN_6[auto_out_b_bits_id];	// BundleMap.scala:247:19
  assign auto_in_ar_ready = auto_out_ar_ready & _GEN[auto_in_ar_bits_id];	// UserYanker.scala:56:36
  assign auto_in_r_valid = auto_out_r_valid;
  assign auto_in_r_bits_id = auto_out_r_bits_id;
  assign auto_in_r_bits_data = auto_out_r_bits_data;
  assign auto_in_r_bits_resp = auto_out_r_bits_resp;
  assign auto_in_r_bits_echo_tl_state_size = _GEN_0[auto_out_r_bits_id];	// BundleMap.scala:247:19
  assign auto_in_r_bits_echo_tl_state_source = _GEN_1[auto_out_r_bits_id];	// BundleMap.scala:247:19
  assign auto_in_r_bits_last = auto_out_r_bits_last;
  assign auto_out_aw_valid = auto_in_aw_valid & _GEN_2[auto_in_aw_bits_id];	// UserYanker.scala:77:36, :78:36
  assign auto_out_aw_bits_id = auto_in_aw_bits_id;
  assign auto_out_aw_bits_addr = auto_in_aw_bits_addr;
  assign auto_out_aw_bits_len = auto_in_aw_bits_len;
  assign auto_out_aw_bits_size = auto_in_aw_bits_size;
  assign auto_out_aw_bits_burst = auto_in_aw_bits_burst;
  assign auto_out_aw_bits_lock = auto_in_aw_bits_lock;
  assign auto_out_aw_bits_cache = auto_in_aw_bits_cache;
  assign auto_out_aw_bits_prot = auto_in_aw_bits_prot;
  assign auto_out_aw_bits_qos = auto_in_aw_bits_qos;
  assign auto_out_w_valid = auto_in_w_valid;
  assign auto_out_w_bits_data = auto_in_w_bits_data;
  assign auto_out_w_bits_strb = auto_in_w_bits_strb;
  assign auto_out_w_bits_last = auto_in_w_bits_last;
  assign auto_out_b_ready = auto_in_b_ready;
  assign auto_out_ar_valid = auto_in_ar_valid & _GEN[auto_in_ar_bits_id];	// UserYanker.scala:56:36, :57:36
  assign auto_out_ar_bits_id = auto_in_ar_bits_id;
  assign auto_out_ar_bits_addr = auto_in_ar_bits_addr;
  assign auto_out_ar_bits_len = auto_in_ar_bits_len;
  assign auto_out_ar_bits_size = auto_in_ar_bits_size;
  assign auto_out_ar_bits_burst = auto_in_ar_bits_burst;
  assign auto_out_ar_bits_lock = auto_in_ar_bits_lock;
  assign auto_out_ar_bits_cache = auto_in_ar_bits_cache;
  assign auto_out_ar_bits_prot = auto_in_ar_bits_prot;
  assign auto_out_ar_bits_qos = auto_in_ar_bits_qos;
  assign auto_out_r_ready = auto_in_r_ready;
endmodule

