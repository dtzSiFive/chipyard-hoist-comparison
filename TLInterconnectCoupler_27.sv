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

module TLInterconnectCoupler_27(
  input         clock,
                reset,
                auto_axi4yank_out_aw_ready,
                auto_axi4yank_out_w_ready,
                auto_axi4yank_out_b_valid,
  input  [3:0]  auto_axi4yank_out_b_bits_id,
  input  [1:0]  auto_axi4yank_out_b_bits_resp,
  input         auto_axi4yank_out_ar_ready,
                auto_axi4yank_out_r_valid,
  input  [3:0]  auto_axi4yank_out_r_bits_id,
  input  [1:0]  auto_axi4yank_out_r_bits_resp,
  input         auto_axi4yank_out_r_bits_last,
                auto_tl_in_a_valid,
  input  [2:0]  auto_tl_in_a_bits_opcode,
                auto_tl_in_a_bits_param,
                auto_tl_in_a_bits_size,
  input  [3:0]  auto_tl_in_a_bits_source,
  input  [31:0] auto_tl_in_a_bits_address,
  input  [7:0]  auto_tl_in_a_bits_mask,
  input  [63:0] auto_tl_in_a_bits_data,
  input         auto_tl_in_a_bits_corrupt,
                auto_tl_in_d_ready,
  output        auto_axi4yank_out_aw_valid,
  output [3:0]  auto_axi4yank_out_aw_bits_id,
  output [31:0] auto_axi4yank_out_aw_bits_addr,
  output [7:0]  auto_axi4yank_out_aw_bits_len,
  output [2:0]  auto_axi4yank_out_aw_bits_size,
  output [1:0]  auto_axi4yank_out_aw_bits_burst,
  output        auto_axi4yank_out_aw_bits_lock,
  output [3:0]  auto_axi4yank_out_aw_bits_cache,
  output [2:0]  auto_axi4yank_out_aw_bits_prot,
  output [3:0]  auto_axi4yank_out_aw_bits_qos,
  output        auto_axi4yank_out_w_valid,
  output [63:0] auto_axi4yank_out_w_bits_data,
  output [7:0]  auto_axi4yank_out_w_bits_strb,
  output        auto_axi4yank_out_w_bits_last,
                auto_axi4yank_out_b_ready,
                auto_axi4yank_out_ar_valid,
  output [3:0]  auto_axi4yank_out_ar_bits_id,
  output [31:0] auto_axi4yank_out_ar_bits_addr,
  output [7:0]  auto_axi4yank_out_ar_bits_len,
  output [2:0]  auto_axi4yank_out_ar_bits_size,
  output [1:0]  auto_axi4yank_out_ar_bits_burst,
  output        auto_axi4yank_out_ar_bits_lock,
  output [3:0]  auto_axi4yank_out_ar_bits_cache,
  output [2:0]  auto_axi4yank_out_ar_bits_prot,
  output [3:0]  auto_axi4yank_out_ar_bits_qos,
  output        auto_tl_in_a_ready,
                auto_tl_in_d_valid,
  output [2:0]  auto_tl_in_d_bits_opcode,
                auto_tl_in_d_bits_size,
  output [3:0]  auto_tl_in_d_bits_source,
  output        auto_tl_in_d_bits_denied,
                auto_tl_in_d_bits_corrupt
);

  wire       _tl2axi4_auto_out_aw_valid;	// ToAXI4.scala:277:29
  wire [3:0] _tl2axi4_auto_out_aw_bits_id;	// ToAXI4.scala:277:29
  wire [3:0] _tl2axi4_auto_out_aw_bits_echo_tl_state_size;	// ToAXI4.scala:277:29
  wire [3:0] _tl2axi4_auto_out_aw_bits_echo_tl_state_source;	// ToAXI4.scala:277:29
  wire       _tl2axi4_auto_out_b_ready;	// ToAXI4.scala:277:29
  wire       _tl2axi4_auto_out_ar_valid;	// ToAXI4.scala:277:29
  wire [3:0] _tl2axi4_auto_out_ar_bits_id;	// ToAXI4.scala:277:29
  wire [3:0] _tl2axi4_auto_out_ar_bits_echo_tl_state_size;	// ToAXI4.scala:277:29
  wire [3:0] _tl2axi4_auto_out_ar_bits_echo_tl_state_source;	// ToAXI4.scala:277:29
  wire       _axi4yank_auto_in_aw_ready;	// UserYanker.scala:105:30
  wire [3:0] _axi4yank_auto_in_b_bits_echo_tl_state_size;	// UserYanker.scala:105:30
  wire [3:0] _axi4yank_auto_in_b_bits_echo_tl_state_source;	// UserYanker.scala:105:30
  wire       _axi4yank_auto_in_ar_ready;	// UserYanker.scala:105:30
  wire [3:0] _axi4yank_auto_in_r_bits_echo_tl_state_size;	// UserYanker.scala:105:30
  wire [3:0] _axi4yank_auto_in_r_bits_echo_tl_state_source;	// UserYanker.scala:105:30
  AXI4UserYanker axi4yank (	// UserYanker.scala:105:30
    .clock                                (clock),
    .reset                                (reset),
    .auto_in_aw_valid                     (_tl2axi4_auto_out_aw_valid),	// ToAXI4.scala:277:29
    .auto_in_aw_bits_id                   (_tl2axi4_auto_out_aw_bits_id),	// ToAXI4.scala:277:29
    .auto_in_aw_bits_echo_tl_state_size   (_tl2axi4_auto_out_aw_bits_echo_tl_state_size),	// ToAXI4.scala:277:29
    .auto_in_aw_bits_echo_tl_state_source
      (_tl2axi4_auto_out_aw_bits_echo_tl_state_source),	// ToAXI4.scala:277:29
    .auto_in_b_ready                      (_tl2axi4_auto_out_b_ready),	// ToAXI4.scala:277:29
    .auto_in_ar_valid                     (_tl2axi4_auto_out_ar_valid),	// ToAXI4.scala:277:29
    .auto_in_ar_bits_id                   (_tl2axi4_auto_out_ar_bits_id),	// ToAXI4.scala:277:29
    .auto_in_ar_bits_echo_tl_state_size   (_tl2axi4_auto_out_ar_bits_echo_tl_state_size),	// ToAXI4.scala:277:29
    .auto_in_ar_bits_echo_tl_state_source
      (_tl2axi4_auto_out_ar_bits_echo_tl_state_source),	// ToAXI4.scala:277:29
    .auto_in_r_ready                      (auto_tl_in_d_ready),
    .auto_out_aw_ready                    (auto_axi4yank_out_aw_ready),
    .auto_out_b_valid                     (auto_axi4yank_out_b_valid),
    .auto_out_b_bits_id                   (auto_axi4yank_out_b_bits_id),
    .auto_out_ar_ready                    (auto_axi4yank_out_ar_ready),
    .auto_out_r_valid                     (auto_axi4yank_out_r_valid),
    .auto_out_r_bits_id                   (auto_axi4yank_out_r_bits_id),
    .auto_out_r_bits_last                 (auto_axi4yank_out_r_bits_last),
    .auto_in_aw_ready                     (_axi4yank_auto_in_aw_ready),
    .auto_in_b_bits_echo_tl_state_size    (_axi4yank_auto_in_b_bits_echo_tl_state_size),
    .auto_in_b_bits_echo_tl_state_source  (_axi4yank_auto_in_b_bits_echo_tl_state_source),
    .auto_in_ar_ready                     (_axi4yank_auto_in_ar_ready),
    .auto_in_r_bits_echo_tl_state_size    (_axi4yank_auto_in_r_bits_echo_tl_state_size),
    .auto_in_r_bits_echo_tl_state_source  (_axi4yank_auto_in_r_bits_echo_tl_state_source),
    .auto_out_aw_valid                    (auto_axi4yank_out_aw_valid),
    .auto_out_ar_valid                    (auto_axi4yank_out_ar_valid)
  );
  TLToAXI4 tl2axi4 (	// ToAXI4.scala:277:29
    .clock                                 (clock),
    .reset                                 (reset),
    .auto_in_a_valid                       (auto_tl_in_a_valid),
    .auto_in_a_bits_opcode                 (auto_tl_in_a_bits_opcode),
    .auto_in_a_bits_param                  (auto_tl_in_a_bits_param),
    .auto_in_a_bits_size                   (auto_tl_in_a_bits_size),
    .auto_in_a_bits_source                 (auto_tl_in_a_bits_source),
    .auto_in_a_bits_address                (auto_tl_in_a_bits_address),
    .auto_in_a_bits_mask                   (auto_tl_in_a_bits_mask),
    .auto_in_a_bits_data                   (auto_tl_in_a_bits_data),
    .auto_in_a_bits_corrupt                (auto_tl_in_a_bits_corrupt),
    .auto_in_d_ready                       (auto_tl_in_d_ready),
    .auto_out_aw_ready                     (_axi4yank_auto_in_aw_ready),	// UserYanker.scala:105:30
    .auto_out_w_ready                      (auto_axi4yank_out_w_ready),
    .auto_out_b_valid                      (auto_axi4yank_out_b_valid),
    .auto_out_b_bits_id                    (auto_axi4yank_out_b_bits_id),
    .auto_out_b_bits_resp                  (auto_axi4yank_out_b_bits_resp),
    .auto_out_b_bits_echo_tl_state_size    (_axi4yank_auto_in_b_bits_echo_tl_state_size),	// UserYanker.scala:105:30
    .auto_out_b_bits_echo_tl_state_source
      (_axi4yank_auto_in_b_bits_echo_tl_state_source),	// UserYanker.scala:105:30
    .auto_out_ar_ready                     (_axi4yank_auto_in_ar_ready),	// UserYanker.scala:105:30
    .auto_out_r_valid                      (auto_axi4yank_out_r_valid),
    .auto_out_r_bits_id                    (auto_axi4yank_out_r_bits_id),
    .auto_out_r_bits_resp                  (auto_axi4yank_out_r_bits_resp),
    .auto_out_r_bits_echo_tl_state_size    (_axi4yank_auto_in_r_bits_echo_tl_state_size),	// UserYanker.scala:105:30
    .auto_out_r_bits_echo_tl_state_source
      (_axi4yank_auto_in_r_bits_echo_tl_state_source),	// UserYanker.scala:105:30
    .auto_out_r_bits_last                  (auto_axi4yank_out_r_bits_last),
    .auto_in_a_ready                       (auto_tl_in_a_ready),
    .auto_in_d_valid                       (auto_tl_in_d_valid),
    .auto_in_d_bits_opcode                 (auto_tl_in_d_bits_opcode),
    .auto_in_d_bits_size                   (auto_tl_in_d_bits_size),
    .auto_in_d_bits_source                 (auto_tl_in_d_bits_source),
    .auto_in_d_bits_denied                 (auto_tl_in_d_bits_denied),
    .auto_in_d_bits_corrupt                (auto_tl_in_d_bits_corrupt),
    .auto_out_aw_valid                     (_tl2axi4_auto_out_aw_valid),
    .auto_out_aw_bits_id                   (_tl2axi4_auto_out_aw_bits_id),
    .auto_out_aw_bits_addr                 (auto_axi4yank_out_aw_bits_addr),
    .auto_out_aw_bits_len                  (auto_axi4yank_out_aw_bits_len),
    .auto_out_aw_bits_size                 (auto_axi4yank_out_aw_bits_size),
    .auto_out_aw_bits_burst                (auto_axi4yank_out_aw_bits_burst),
    .auto_out_aw_bits_lock                 (auto_axi4yank_out_aw_bits_lock),
    .auto_out_aw_bits_cache                (auto_axi4yank_out_aw_bits_cache),
    .auto_out_aw_bits_prot                 (auto_axi4yank_out_aw_bits_prot),
    .auto_out_aw_bits_qos                  (auto_axi4yank_out_aw_bits_qos),
    .auto_out_aw_bits_echo_tl_state_size   (_tl2axi4_auto_out_aw_bits_echo_tl_state_size),
    .auto_out_aw_bits_echo_tl_state_source
      (_tl2axi4_auto_out_aw_bits_echo_tl_state_source),
    .auto_out_w_valid                      (auto_axi4yank_out_w_valid),
    .auto_out_w_bits_data                  (auto_axi4yank_out_w_bits_data),
    .auto_out_w_bits_strb                  (auto_axi4yank_out_w_bits_strb),
    .auto_out_w_bits_last                  (auto_axi4yank_out_w_bits_last),
    .auto_out_b_ready                      (_tl2axi4_auto_out_b_ready),
    .auto_out_ar_valid                     (_tl2axi4_auto_out_ar_valid),
    .auto_out_ar_bits_id                   (_tl2axi4_auto_out_ar_bits_id),
    .auto_out_ar_bits_addr                 (auto_axi4yank_out_ar_bits_addr),
    .auto_out_ar_bits_len                  (auto_axi4yank_out_ar_bits_len),
    .auto_out_ar_bits_size                 (auto_axi4yank_out_ar_bits_size),
    .auto_out_ar_bits_burst                (auto_axi4yank_out_ar_bits_burst),
    .auto_out_ar_bits_lock                 (auto_axi4yank_out_ar_bits_lock),
    .auto_out_ar_bits_cache                (auto_axi4yank_out_ar_bits_cache),
    .auto_out_ar_bits_prot                 (auto_axi4yank_out_ar_bits_prot),
    .auto_out_ar_bits_qos                  (auto_axi4yank_out_ar_bits_qos),
    .auto_out_ar_bits_echo_tl_state_size   (_tl2axi4_auto_out_ar_bits_echo_tl_state_size),
    .auto_out_ar_bits_echo_tl_state_source
      (_tl2axi4_auto_out_ar_bits_echo_tl_state_source)
  );
  assign auto_axi4yank_out_aw_bits_id = _tl2axi4_auto_out_aw_bits_id;	// ToAXI4.scala:277:29
  assign auto_axi4yank_out_b_ready = _tl2axi4_auto_out_b_ready;	// ToAXI4.scala:277:29
  assign auto_axi4yank_out_ar_bits_id = _tl2axi4_auto_out_ar_bits_id;	// ToAXI4.scala:277:29
endmodule

