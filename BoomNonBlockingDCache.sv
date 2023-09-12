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

module BoomNonBlockingDCache(
  input         clock,
                reset,
                auto_out_a_ready,
                auto_out_b_valid,
  input  [1:0]  auto_out_b_bits_param,
  input  [3:0]  auto_out_b_bits_size,
                auto_out_b_bits_source,
  input  [31:0] auto_out_b_bits_address,
  input         auto_out_c_ready,
                auto_out_d_valid,
  input  [2:0]  auto_out_d_bits_opcode,
  input  [1:0]  auto_out_d_bits_param,
  input  [3:0]  auto_out_d_bits_size,
                auto_out_d_bits_source,
  input  [2:0]  auto_out_d_bits_sink,
  input  [63:0] auto_out_d_bits_data,
  input         auto_out_e_ready,
                io_lsu_req_valid,
                io_lsu_req_bits_0_valid,
  input  [6:0]  io_lsu_req_bits_0_bits_uop_uopc,
  input  [31:0] io_lsu_req_bits_0_bits_uop_inst,
                io_lsu_req_bits_0_bits_uop_debug_inst,
  input         io_lsu_req_bits_0_bits_uop_is_rvc,
  input  [39:0] io_lsu_req_bits_0_bits_uop_debug_pc,
  input  [2:0]  io_lsu_req_bits_0_bits_uop_iq_type,
  input  [9:0]  io_lsu_req_bits_0_bits_uop_fu_code,
  input  [3:0]  io_lsu_req_bits_0_bits_uop_ctrl_br_type,
  input  [1:0]  io_lsu_req_bits_0_bits_uop_ctrl_op1_sel,
  input  [2:0]  io_lsu_req_bits_0_bits_uop_ctrl_op2_sel,
                io_lsu_req_bits_0_bits_uop_ctrl_imm_sel,
  input  [3:0]  io_lsu_req_bits_0_bits_uop_ctrl_op_fcn,
  input         io_lsu_req_bits_0_bits_uop_ctrl_fcn_dw,
  input  [2:0]  io_lsu_req_bits_0_bits_uop_ctrl_csr_cmd,
  input         io_lsu_req_bits_0_bits_uop_ctrl_is_load,
                io_lsu_req_bits_0_bits_uop_ctrl_is_sta,
                io_lsu_req_bits_0_bits_uop_ctrl_is_std,
  input  [1:0]  io_lsu_req_bits_0_bits_uop_iw_state,
  input         io_lsu_req_bits_0_bits_uop_iw_p1_poisoned,
                io_lsu_req_bits_0_bits_uop_iw_p2_poisoned,
                io_lsu_req_bits_0_bits_uop_is_br,
                io_lsu_req_bits_0_bits_uop_is_jalr,
                io_lsu_req_bits_0_bits_uop_is_jal,
                io_lsu_req_bits_0_bits_uop_is_sfb,
  input  [19:0] io_lsu_req_bits_0_bits_uop_br_mask,
  input  [4:0]  io_lsu_req_bits_0_bits_uop_br_tag,
  input  [5:0]  io_lsu_req_bits_0_bits_uop_ftq_idx,
  input         io_lsu_req_bits_0_bits_uop_edge_inst,
  input  [5:0]  io_lsu_req_bits_0_bits_uop_pc_lob,
  input         io_lsu_req_bits_0_bits_uop_taken,
  input  [19:0] io_lsu_req_bits_0_bits_uop_imm_packed,
  input  [11:0] io_lsu_req_bits_0_bits_uop_csr_addr,
  input  [6:0]  io_lsu_req_bits_0_bits_uop_rob_idx,
  input  [4:0]  io_lsu_req_bits_0_bits_uop_ldq_idx,
                io_lsu_req_bits_0_bits_uop_stq_idx,
  input  [1:0]  io_lsu_req_bits_0_bits_uop_rxq_idx,
  input  [6:0]  io_lsu_req_bits_0_bits_uop_pdst,
                io_lsu_req_bits_0_bits_uop_prs1,
                io_lsu_req_bits_0_bits_uop_prs2,
                io_lsu_req_bits_0_bits_uop_prs3,
  input  [5:0]  io_lsu_req_bits_0_bits_uop_ppred,
  input         io_lsu_req_bits_0_bits_uop_prs1_busy,
                io_lsu_req_bits_0_bits_uop_prs2_busy,
                io_lsu_req_bits_0_bits_uop_prs3_busy,
                io_lsu_req_bits_0_bits_uop_ppred_busy,
  input  [6:0]  io_lsu_req_bits_0_bits_uop_stale_pdst,
  input         io_lsu_req_bits_0_bits_uop_exception,
  input  [63:0] io_lsu_req_bits_0_bits_uop_exc_cause,
  input         io_lsu_req_bits_0_bits_uop_bypassable,
  input  [4:0]  io_lsu_req_bits_0_bits_uop_mem_cmd,
  input  [1:0]  io_lsu_req_bits_0_bits_uop_mem_size,
  input         io_lsu_req_bits_0_bits_uop_mem_signed,
                io_lsu_req_bits_0_bits_uop_is_fence,
                io_lsu_req_bits_0_bits_uop_is_fencei,
                io_lsu_req_bits_0_bits_uop_is_amo,
                io_lsu_req_bits_0_bits_uop_uses_ldq,
                io_lsu_req_bits_0_bits_uop_uses_stq,
                io_lsu_req_bits_0_bits_uop_is_sys_pc2epc,
                io_lsu_req_bits_0_bits_uop_is_unique,
                io_lsu_req_bits_0_bits_uop_flush_on_commit,
                io_lsu_req_bits_0_bits_uop_ldst_is_rs1,
  input  [5:0]  io_lsu_req_bits_0_bits_uop_ldst,
                io_lsu_req_bits_0_bits_uop_lrs1,
                io_lsu_req_bits_0_bits_uop_lrs2,
                io_lsu_req_bits_0_bits_uop_lrs3,
  input         io_lsu_req_bits_0_bits_uop_ldst_val,
  input  [1:0]  io_lsu_req_bits_0_bits_uop_dst_rtype,
                io_lsu_req_bits_0_bits_uop_lrs1_rtype,
                io_lsu_req_bits_0_bits_uop_lrs2_rtype,
  input         io_lsu_req_bits_0_bits_uop_frs3_en,
                io_lsu_req_bits_0_bits_uop_fp_val,
                io_lsu_req_bits_0_bits_uop_fp_single,
                io_lsu_req_bits_0_bits_uop_xcpt_pf_if,
                io_lsu_req_bits_0_bits_uop_xcpt_ae_if,
                io_lsu_req_bits_0_bits_uop_xcpt_ma_if,
                io_lsu_req_bits_0_bits_uop_bp_debug_if,
                io_lsu_req_bits_0_bits_uop_bp_xcpt_if,
  input  [1:0]  io_lsu_req_bits_0_bits_uop_debug_fsrc,
                io_lsu_req_bits_0_bits_uop_debug_tsrc,
  input  [39:0] io_lsu_req_bits_0_bits_addr,
  input  [63:0] io_lsu_req_bits_0_bits_data,
  input         io_lsu_req_bits_1_valid,
  input  [6:0]  io_lsu_req_bits_1_bits_uop_uopc,
  input  [31:0] io_lsu_req_bits_1_bits_uop_inst,
                io_lsu_req_bits_1_bits_uop_debug_inst,
  input         io_lsu_req_bits_1_bits_uop_is_rvc,
  input  [39:0] io_lsu_req_bits_1_bits_uop_debug_pc,
  input  [2:0]  io_lsu_req_bits_1_bits_uop_iq_type,
  input  [9:0]  io_lsu_req_bits_1_bits_uop_fu_code,
  input  [3:0]  io_lsu_req_bits_1_bits_uop_ctrl_br_type,
  input  [1:0]  io_lsu_req_bits_1_bits_uop_ctrl_op1_sel,
  input  [2:0]  io_lsu_req_bits_1_bits_uop_ctrl_op2_sel,
                io_lsu_req_bits_1_bits_uop_ctrl_imm_sel,
  input  [3:0]  io_lsu_req_bits_1_bits_uop_ctrl_op_fcn,
  input         io_lsu_req_bits_1_bits_uop_ctrl_fcn_dw,
  input  [2:0]  io_lsu_req_bits_1_bits_uop_ctrl_csr_cmd,
  input         io_lsu_req_bits_1_bits_uop_ctrl_is_load,
                io_lsu_req_bits_1_bits_uop_ctrl_is_sta,
                io_lsu_req_bits_1_bits_uop_ctrl_is_std,
  input  [1:0]  io_lsu_req_bits_1_bits_uop_iw_state,
  input         io_lsu_req_bits_1_bits_uop_iw_p1_poisoned,
                io_lsu_req_bits_1_bits_uop_iw_p2_poisoned,
                io_lsu_req_bits_1_bits_uop_is_br,
                io_lsu_req_bits_1_bits_uop_is_jalr,
                io_lsu_req_bits_1_bits_uop_is_jal,
                io_lsu_req_bits_1_bits_uop_is_sfb,
  input  [19:0] io_lsu_req_bits_1_bits_uop_br_mask,
  input  [4:0]  io_lsu_req_bits_1_bits_uop_br_tag,
  input  [5:0]  io_lsu_req_bits_1_bits_uop_ftq_idx,
  input         io_lsu_req_bits_1_bits_uop_edge_inst,
  input  [5:0]  io_lsu_req_bits_1_bits_uop_pc_lob,
  input         io_lsu_req_bits_1_bits_uop_taken,
  input  [19:0] io_lsu_req_bits_1_bits_uop_imm_packed,
  input  [11:0] io_lsu_req_bits_1_bits_uop_csr_addr,
  input  [6:0]  io_lsu_req_bits_1_bits_uop_rob_idx,
  input  [4:0]  io_lsu_req_bits_1_bits_uop_ldq_idx,
                io_lsu_req_bits_1_bits_uop_stq_idx,
  input  [1:0]  io_lsu_req_bits_1_bits_uop_rxq_idx,
  input  [6:0]  io_lsu_req_bits_1_bits_uop_pdst,
                io_lsu_req_bits_1_bits_uop_prs1,
                io_lsu_req_bits_1_bits_uop_prs2,
                io_lsu_req_bits_1_bits_uop_prs3,
  input  [5:0]  io_lsu_req_bits_1_bits_uop_ppred,
  input         io_lsu_req_bits_1_bits_uop_prs1_busy,
                io_lsu_req_bits_1_bits_uop_prs2_busy,
                io_lsu_req_bits_1_bits_uop_prs3_busy,
                io_lsu_req_bits_1_bits_uop_ppred_busy,
  input  [6:0]  io_lsu_req_bits_1_bits_uop_stale_pdst,
  input         io_lsu_req_bits_1_bits_uop_exception,
  input  [63:0] io_lsu_req_bits_1_bits_uop_exc_cause,
  input         io_lsu_req_bits_1_bits_uop_bypassable,
  input  [4:0]  io_lsu_req_bits_1_bits_uop_mem_cmd,
  input  [1:0]  io_lsu_req_bits_1_bits_uop_mem_size,
  input         io_lsu_req_bits_1_bits_uop_mem_signed,
                io_lsu_req_bits_1_bits_uop_is_fence,
                io_lsu_req_bits_1_bits_uop_is_fencei,
                io_lsu_req_bits_1_bits_uop_is_amo,
                io_lsu_req_bits_1_bits_uop_uses_ldq,
                io_lsu_req_bits_1_bits_uop_uses_stq,
                io_lsu_req_bits_1_bits_uop_is_sys_pc2epc,
                io_lsu_req_bits_1_bits_uop_is_unique,
                io_lsu_req_bits_1_bits_uop_flush_on_commit,
                io_lsu_req_bits_1_bits_uop_ldst_is_rs1,
  input  [5:0]  io_lsu_req_bits_1_bits_uop_ldst,
                io_lsu_req_bits_1_bits_uop_lrs1,
                io_lsu_req_bits_1_bits_uop_lrs2,
                io_lsu_req_bits_1_bits_uop_lrs3,
  input         io_lsu_req_bits_1_bits_uop_ldst_val,
  input  [1:0]  io_lsu_req_bits_1_bits_uop_dst_rtype,
                io_lsu_req_bits_1_bits_uop_lrs1_rtype,
                io_lsu_req_bits_1_bits_uop_lrs2_rtype,
  input         io_lsu_req_bits_1_bits_uop_frs3_en,
                io_lsu_req_bits_1_bits_uop_fp_val,
                io_lsu_req_bits_1_bits_uop_fp_single,
                io_lsu_req_bits_1_bits_uop_xcpt_pf_if,
                io_lsu_req_bits_1_bits_uop_xcpt_ae_if,
                io_lsu_req_bits_1_bits_uop_xcpt_ma_if,
                io_lsu_req_bits_1_bits_uop_bp_debug_if,
                io_lsu_req_bits_1_bits_uop_bp_xcpt_if,
  input  [1:0]  io_lsu_req_bits_1_bits_uop_debug_fsrc,
                io_lsu_req_bits_1_bits_uop_debug_tsrc,
  input  [39:0] io_lsu_req_bits_1_bits_addr,
  input  [63:0] io_lsu_req_bits_1_bits_data,
  input         io_lsu_req_bits_1_bits_is_hella,
                io_lsu_s1_kill_0,
                io_lsu_s1_kill_1,
  input  [19:0] io_lsu_brupdate_b1_resolve_mask,
                io_lsu_brupdate_b1_mispredict_mask,
  input         io_lsu_exception,
                io_lsu_release_ready,
                io_lsu_force_order,
  output        auto_out_a_valid,
  output [2:0]  auto_out_a_bits_opcode,
                auto_out_a_bits_param,
  output [3:0]  auto_out_a_bits_size,
                auto_out_a_bits_source,
  output [31:0] auto_out_a_bits_address,
  output [7:0]  auto_out_a_bits_mask,
  output [63:0] auto_out_a_bits_data,
  output        auto_out_b_ready,
                auto_out_c_valid,
  output [2:0]  auto_out_c_bits_opcode,
                auto_out_c_bits_param,
  output [3:0]  auto_out_c_bits_size,
                auto_out_c_bits_source,
  output [31:0] auto_out_c_bits_address,
  output [63:0] auto_out_c_bits_data,
  output        auto_out_d_ready,
                auto_out_e_valid,
  output [2:0]  auto_out_e_bits_sink,
  output        io_lsu_req_ready,
                io_lsu_resp_0_valid,
  output [4:0]  io_lsu_resp_0_bits_uop_ldq_idx,
                io_lsu_resp_0_bits_uop_stq_idx,
  output        io_lsu_resp_0_bits_uop_is_amo,
                io_lsu_resp_0_bits_uop_uses_ldq,
                io_lsu_resp_0_bits_uop_uses_stq,
  output [63:0] io_lsu_resp_0_bits_data,
  output        io_lsu_resp_0_bits_is_hella,
                io_lsu_resp_1_valid,
  output [4:0]  io_lsu_resp_1_bits_uop_ldq_idx,
                io_lsu_resp_1_bits_uop_stq_idx,
  output        io_lsu_resp_1_bits_uop_is_amo,
                io_lsu_resp_1_bits_uop_uses_ldq,
                io_lsu_resp_1_bits_uop_uses_stq,
  output [63:0] io_lsu_resp_1_bits_data,
  output        io_lsu_resp_1_bits_is_hella,
                io_lsu_nack_0_valid,
  output [4:0]  io_lsu_nack_0_bits_uop_ldq_idx,
                io_lsu_nack_0_bits_uop_stq_idx,
  output        io_lsu_nack_0_bits_uop_uses_ldq,
                io_lsu_nack_0_bits_uop_uses_stq,
                io_lsu_nack_0_bits_is_hella,
                io_lsu_nack_1_valid,
  output [4:0]  io_lsu_nack_1_bits_uop_ldq_idx,
                io_lsu_nack_1_bits_uop_stq_idx,
  output        io_lsu_nack_1_bits_uop_uses_ldq,
                io_lsu_nack_1_bits_uop_uses_stq,
                io_lsu_nack_1_bits_is_hella,
                io_lsu_release_valid,
  output [31:0] io_lsu_release_bits_address,
  output        io_lsu_ordered
);

  wire [63:0]      s2_data_word_1;	// dcache.scala:890:27
  wire [63:0]      s2_data_word_0;	// dcache.scala:890:27
  wire             _mshrs_io_req_1_valid_T_72;	// dcache.scala:753:77
  wire             _mshrs_io_req_0_valid_T_72;	// dcache.scala:753:77
  reg  [7:0]       s2_tag_match_way_1;	// dcache.scala:642:33
  reg  [7:0]       s2_tag_match_way_0;	// dcache.scala:642:33
  wire             _wb_io_data_req_ready_T;	// dcache.scala:541:55
  wire             _metaWriteArb_io_out_ready_T;	// dcache.scala:456:67
  wire [63:0]      _amoalu_io_out;	// dcache.scala:895:24
  wire             _lsu_release_arb_io_in_1_ready;	// dcache.scala:813:31
  wire             _wbArb_io_in_1_ready;	// dcache.scala:804:21
  wire             _wbArb_io_out_valid;	// dcache.scala:804:21
  wire [19:0]      _wbArb_io_out_bits_tag;	// dcache.scala:804:21
  wire [5:0]       _wbArb_io_out_bits_idx;	// dcache.scala:804:21
  wire [2:0]       _wbArb_io_out_bits_param;	// dcache.scala:804:21
  wire [7:0]       _wbArb_io_out_bits_way_en;	// dcache.scala:804:21
  wire             _wbArb_io_out_bits_voluntary;	// dcache.scala:804:21
  wire             _lfsr_prng_io_out_0;	// PRNG.scala:82:22
  wire             _lfsr_prng_io_out_1;	// PRNG.scala:82:22
  wire             _lfsr_prng_io_out_2;	// PRNG.scala:82:22
  wire             _dataReadArb_io_in_1_ready;	// dcache.scala:462:27
  wire             _dataReadArb_io_in_2_ready;	// dcache.scala:462:27
  wire             _dataReadArb_io_out_valid;	// dcache.scala:462:27
  wire [7:0]       _dataReadArb_io_out_bits_req_0_way_en;	// dcache.scala:462:27
  wire [11:0]      _dataReadArb_io_out_bits_req_0_addr;	// dcache.scala:462:27
  wire [7:0]       _dataReadArb_io_out_bits_req_1_way_en;	// dcache.scala:462:27
  wire [11:0]      _dataReadArb_io_out_bits_req_1_addr;	// dcache.scala:462:27
  wire             _dataReadArb_io_out_bits_valid_0;	// dcache.scala:462:27
  wire             _dataReadArb_io_out_bits_valid_1;	// dcache.scala:462:27
  wire             _dataWriteArb_io_in_1_ready;	// dcache.scala:460:28
  wire             _dataWriteArb_io_out_valid;	// dcache.scala:460:28
  wire [7:0]       _dataWriteArb_io_out_bits_way_en;	// dcache.scala:460:28
  wire [11:0]      _dataWriteArb_io_out_bits_addr;	// dcache.scala:460:28
  wire [63:0]      _dataWriteArb_io_out_bits_data;	// dcache.scala:460:28
  wire [63:0]      _data_io_resp_0_0;	// dcache.scala:459:20
  wire [63:0]      _data_io_resp_0_1;	// dcache.scala:459:20
  wire [63:0]      _data_io_resp_0_2;	// dcache.scala:459:20
  wire [63:0]      _data_io_resp_0_3;	// dcache.scala:459:20
  wire [63:0]      _data_io_resp_0_4;	// dcache.scala:459:20
  wire [63:0]      _data_io_resp_0_5;	// dcache.scala:459:20
  wire [63:0]      _data_io_resp_0_6;	// dcache.scala:459:20
  wire [63:0]      _data_io_resp_0_7;	// dcache.scala:459:20
  wire [63:0]      _data_io_resp_1_0;	// dcache.scala:459:20
  wire [63:0]      _data_io_resp_1_1;	// dcache.scala:459:20
  wire [63:0]      _data_io_resp_1_2;	// dcache.scala:459:20
  wire [63:0]      _data_io_resp_1_3;	// dcache.scala:459:20
  wire [63:0]      _data_io_resp_1_4;	// dcache.scala:459:20
  wire [63:0]      _data_io_resp_1_5;	// dcache.scala:459:20
  wire [63:0]      _data_io_resp_1_6;	// dcache.scala:459:20
  wire [63:0]      _data_io_resp_1_7;	// dcache.scala:459:20
  wire             _metaReadArb_io_in_1_ready;	// dcache.scala:444:27
  wire             _metaReadArb_io_in_2_ready;	// dcache.scala:444:27
  wire             _metaReadArb_io_in_3_ready;	// dcache.scala:444:27
  wire             _metaReadArb_io_in_4_ready;	// dcache.scala:444:27
  wire             _metaReadArb_io_in_5_ready;	// dcache.scala:444:27
  wire             _metaReadArb_io_out_valid;	// dcache.scala:444:27
  wire [5:0]       _metaReadArb_io_out_bits_req_0_idx;	// dcache.scala:444:27
  wire [5:0]       _metaReadArb_io_out_bits_req_1_idx;	// dcache.scala:444:27
  wire             _metaWriteArb_io_in_1_ready;	// dcache.scala:442:28
  wire             _metaWriteArb_io_out_valid;	// dcache.scala:442:28
  wire [5:0]       _metaWriteArb_io_out_bits_idx;	// dcache.scala:442:28
  wire [7:0]       _metaWriteArb_io_out_bits_way_en;	// dcache.scala:442:28
  wire [1:0]       _metaWriteArb_io_out_bits_data_coh_state;	// dcache.scala:442:28
  wire [19:0]      _metaWriteArb_io_out_bits_data_tag;	// dcache.scala:442:28
  wire             _meta_1_io_read_ready;	// dcache.scala:441:41
  wire             _meta_1_io_write_ready;	// dcache.scala:441:41
  wire [1:0]       _meta_1_io_resp_0_coh_state;	// dcache.scala:441:41
  wire [19:0]      _meta_1_io_resp_0_tag;	// dcache.scala:441:41
  wire [1:0]       _meta_1_io_resp_1_coh_state;	// dcache.scala:441:41
  wire [19:0]      _meta_1_io_resp_1_tag;	// dcache.scala:441:41
  wire [1:0]       _meta_1_io_resp_2_coh_state;	// dcache.scala:441:41
  wire [19:0]      _meta_1_io_resp_2_tag;	// dcache.scala:441:41
  wire [1:0]       _meta_1_io_resp_3_coh_state;	// dcache.scala:441:41
  wire [19:0]      _meta_1_io_resp_3_tag;	// dcache.scala:441:41
  wire [1:0]       _meta_1_io_resp_4_coh_state;	// dcache.scala:441:41
  wire [19:0]      _meta_1_io_resp_4_tag;	// dcache.scala:441:41
  wire [1:0]       _meta_1_io_resp_5_coh_state;	// dcache.scala:441:41
  wire [19:0]      _meta_1_io_resp_5_tag;	// dcache.scala:441:41
  wire [1:0]       _meta_1_io_resp_6_coh_state;	// dcache.scala:441:41
  wire [19:0]      _meta_1_io_resp_6_tag;	// dcache.scala:441:41
  wire [1:0]       _meta_1_io_resp_7_coh_state;	// dcache.scala:441:41
  wire [19:0]      _meta_1_io_resp_7_tag;	// dcache.scala:441:41
  wire             _meta_0_io_read_ready;	// dcache.scala:441:41
  wire             _meta_0_io_write_ready;	// dcache.scala:441:41
  wire [1:0]       _meta_0_io_resp_0_coh_state;	// dcache.scala:441:41
  wire [19:0]      _meta_0_io_resp_0_tag;	// dcache.scala:441:41
  wire [1:0]       _meta_0_io_resp_1_coh_state;	// dcache.scala:441:41
  wire [19:0]      _meta_0_io_resp_1_tag;	// dcache.scala:441:41
  wire [1:0]       _meta_0_io_resp_2_coh_state;	// dcache.scala:441:41
  wire [19:0]      _meta_0_io_resp_2_tag;	// dcache.scala:441:41
  wire [1:0]       _meta_0_io_resp_3_coh_state;	// dcache.scala:441:41
  wire [19:0]      _meta_0_io_resp_3_tag;	// dcache.scala:441:41
  wire [1:0]       _meta_0_io_resp_4_coh_state;	// dcache.scala:441:41
  wire [19:0]      _meta_0_io_resp_4_tag;	// dcache.scala:441:41
  wire [1:0]       _meta_0_io_resp_5_coh_state;	// dcache.scala:441:41
  wire [19:0]      _meta_0_io_resp_5_tag;	// dcache.scala:441:41
  wire [1:0]       _meta_0_io_resp_6_coh_state;	// dcache.scala:441:41
  wire [19:0]      _meta_0_io_resp_6_tag;	// dcache.scala:441:41
  wire [1:0]       _meta_0_io_resp_7_coh_state;	// dcache.scala:441:41
  wire [19:0]      _meta_0_io_resp_7_tag;	// dcache.scala:441:41
  wire             _mshrs_io_req_0_ready;	// dcache.scala:432:21
  wire             _mshrs_io_req_1_ready;	// dcache.scala:432:21
  wire             _mshrs_io_resp_valid;	// dcache.scala:432:21
  wire [19:0]      _mshrs_io_resp_bits_uop_br_mask;	// dcache.scala:432:21
  wire [4:0]       _mshrs_io_resp_bits_uop_ldq_idx;	// dcache.scala:432:21
  wire [4:0]       _mshrs_io_resp_bits_uop_stq_idx;	// dcache.scala:432:21
  wire             _mshrs_io_resp_bits_uop_is_amo;	// dcache.scala:432:21
  wire             _mshrs_io_resp_bits_uop_uses_ldq;	// dcache.scala:432:21
  wire             _mshrs_io_resp_bits_uop_uses_stq;	// dcache.scala:432:21
  wire [63:0]      _mshrs_io_resp_bits_data;	// dcache.scala:432:21
  wire             _mshrs_io_resp_bits_is_hella;	// dcache.scala:432:21
  wire             _mshrs_io_secondary_miss_0;	// dcache.scala:432:21
  wire             _mshrs_io_secondary_miss_1;	// dcache.scala:432:21
  wire             _mshrs_io_block_hit_0;	// dcache.scala:432:21
  wire             _mshrs_io_block_hit_1;	// dcache.scala:432:21
  wire             _mshrs_io_mem_grant_ready;	// dcache.scala:432:21
  wire             _mshrs_io_refill_valid;	// dcache.scala:432:21
  wire [7:0]       _mshrs_io_refill_bits_way_en;	// dcache.scala:432:21
  wire [11:0]      _mshrs_io_refill_bits_addr;	// dcache.scala:432:21
  wire [63:0]      _mshrs_io_refill_bits_data;	// dcache.scala:432:21
  wire             _mshrs_io_meta_write_valid;	// dcache.scala:432:21
  wire [5:0]       _mshrs_io_meta_write_bits_idx;	// dcache.scala:432:21
  wire [7:0]       _mshrs_io_meta_write_bits_way_en;	// dcache.scala:432:21
  wire [1:0]       _mshrs_io_meta_write_bits_data_coh_state;	// dcache.scala:432:21
  wire [19:0]      _mshrs_io_meta_write_bits_data_tag;	// dcache.scala:432:21
  wire             _mshrs_io_meta_read_valid;	// dcache.scala:432:21
  wire [5:0]       _mshrs_io_meta_read_bits_idx;	// dcache.scala:432:21
  wire [7:0]       _mshrs_io_meta_read_bits_way_en;	// dcache.scala:432:21
  wire [19:0]      _mshrs_io_meta_read_bits_tag;	// dcache.scala:432:21
  wire             _mshrs_io_replay_valid;	// dcache.scala:432:21
  wire [6:0]       _mshrs_io_replay_bits_uop_uopc;	// dcache.scala:432:21
  wire [31:0]      _mshrs_io_replay_bits_uop_inst;	// dcache.scala:432:21
  wire [31:0]      _mshrs_io_replay_bits_uop_debug_inst;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_uop_is_rvc;	// dcache.scala:432:21
  wire [39:0]      _mshrs_io_replay_bits_uop_debug_pc;	// dcache.scala:432:21
  wire [2:0]       _mshrs_io_replay_bits_uop_iq_type;	// dcache.scala:432:21
  wire [9:0]       _mshrs_io_replay_bits_uop_fu_code;	// dcache.scala:432:21
  wire [3:0]       _mshrs_io_replay_bits_uop_ctrl_br_type;	// dcache.scala:432:21
  wire [1:0]       _mshrs_io_replay_bits_uop_ctrl_op1_sel;	// dcache.scala:432:21
  wire [2:0]       _mshrs_io_replay_bits_uop_ctrl_op2_sel;	// dcache.scala:432:21
  wire [2:0]       _mshrs_io_replay_bits_uop_ctrl_imm_sel;	// dcache.scala:432:21
  wire [3:0]       _mshrs_io_replay_bits_uop_ctrl_op_fcn;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_uop_ctrl_fcn_dw;	// dcache.scala:432:21
  wire [2:0]       _mshrs_io_replay_bits_uop_ctrl_csr_cmd;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_uop_ctrl_is_load;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_uop_ctrl_is_sta;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_uop_ctrl_is_std;	// dcache.scala:432:21
  wire [1:0]       _mshrs_io_replay_bits_uop_iw_state;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_uop_iw_p1_poisoned;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_uop_iw_p2_poisoned;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_uop_is_br;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_uop_is_jalr;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_uop_is_jal;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_uop_is_sfb;	// dcache.scala:432:21
  wire [19:0]      _mshrs_io_replay_bits_uop_br_mask;	// dcache.scala:432:21
  wire [4:0]       _mshrs_io_replay_bits_uop_br_tag;	// dcache.scala:432:21
  wire [5:0]       _mshrs_io_replay_bits_uop_ftq_idx;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_uop_edge_inst;	// dcache.scala:432:21
  wire [5:0]       _mshrs_io_replay_bits_uop_pc_lob;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_uop_taken;	// dcache.scala:432:21
  wire [19:0]      _mshrs_io_replay_bits_uop_imm_packed;	// dcache.scala:432:21
  wire [11:0]      _mshrs_io_replay_bits_uop_csr_addr;	// dcache.scala:432:21
  wire [6:0]       _mshrs_io_replay_bits_uop_rob_idx;	// dcache.scala:432:21
  wire [4:0]       _mshrs_io_replay_bits_uop_ldq_idx;	// dcache.scala:432:21
  wire [4:0]       _mshrs_io_replay_bits_uop_stq_idx;	// dcache.scala:432:21
  wire [1:0]       _mshrs_io_replay_bits_uop_rxq_idx;	// dcache.scala:432:21
  wire [6:0]       _mshrs_io_replay_bits_uop_pdst;	// dcache.scala:432:21
  wire [6:0]       _mshrs_io_replay_bits_uop_prs1;	// dcache.scala:432:21
  wire [6:0]       _mshrs_io_replay_bits_uop_prs2;	// dcache.scala:432:21
  wire [6:0]       _mshrs_io_replay_bits_uop_prs3;	// dcache.scala:432:21
  wire [5:0]       _mshrs_io_replay_bits_uop_ppred;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_uop_prs1_busy;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_uop_prs2_busy;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_uop_prs3_busy;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_uop_ppred_busy;	// dcache.scala:432:21
  wire [6:0]       _mshrs_io_replay_bits_uop_stale_pdst;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_uop_exception;	// dcache.scala:432:21
  wire [63:0]      _mshrs_io_replay_bits_uop_exc_cause;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_uop_bypassable;	// dcache.scala:432:21
  wire [4:0]       _mshrs_io_replay_bits_uop_mem_cmd;	// dcache.scala:432:21
  wire [1:0]       _mshrs_io_replay_bits_uop_mem_size;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_uop_mem_signed;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_uop_is_fence;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_uop_is_fencei;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_uop_is_amo;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_uop_uses_ldq;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_uop_uses_stq;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_uop_is_sys_pc2epc;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_uop_is_unique;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_uop_flush_on_commit;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_uop_ldst_is_rs1;	// dcache.scala:432:21
  wire [5:0]       _mshrs_io_replay_bits_uop_ldst;	// dcache.scala:432:21
  wire [5:0]       _mshrs_io_replay_bits_uop_lrs1;	// dcache.scala:432:21
  wire [5:0]       _mshrs_io_replay_bits_uop_lrs2;	// dcache.scala:432:21
  wire [5:0]       _mshrs_io_replay_bits_uop_lrs3;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_uop_ldst_val;	// dcache.scala:432:21
  wire [1:0]       _mshrs_io_replay_bits_uop_dst_rtype;	// dcache.scala:432:21
  wire [1:0]       _mshrs_io_replay_bits_uop_lrs1_rtype;	// dcache.scala:432:21
  wire [1:0]       _mshrs_io_replay_bits_uop_lrs2_rtype;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_uop_frs3_en;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_uop_fp_val;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_uop_fp_single;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_uop_xcpt_pf_if;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_uop_xcpt_ae_if;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_uop_xcpt_ma_if;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_uop_bp_debug_if;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_uop_bp_xcpt_if;	// dcache.scala:432:21
  wire [1:0]       _mshrs_io_replay_bits_uop_debug_fsrc;	// dcache.scala:432:21
  wire [1:0]       _mshrs_io_replay_bits_uop_debug_tsrc;	// dcache.scala:432:21
  wire [39:0]      _mshrs_io_replay_bits_addr;	// dcache.scala:432:21
  wire [63:0]      _mshrs_io_replay_bits_data;	// dcache.scala:432:21
  wire             _mshrs_io_replay_bits_is_hella;	// dcache.scala:432:21
  wire [7:0]       _mshrs_io_replay_bits_way_en;	// dcache.scala:432:21
  wire             _mshrs_io_prefetch_valid;	// dcache.scala:432:21
  wire [4:0]       _mshrs_io_prefetch_bits_uop_mem_cmd;	// dcache.scala:432:21
  wire [39:0]      _mshrs_io_prefetch_bits_addr;	// dcache.scala:432:21
  wire             _mshrs_io_wb_req_valid;	// dcache.scala:432:21
  wire [19:0]      _mshrs_io_wb_req_bits_tag;	// dcache.scala:432:21
  wire [5:0]       _mshrs_io_wb_req_bits_idx;	// dcache.scala:432:21
  wire [2:0]       _mshrs_io_wb_req_bits_param;	// dcache.scala:432:21
  wire [7:0]       _mshrs_io_wb_req_bits_way_en;	// dcache.scala:432:21
  wire             _mshrs_io_fence_rdy;	// dcache.scala:432:21
  wire             _mshrs_io_probe_rdy;	// dcache.scala:432:21
  wire             _prober_io_req_ready;	// dcache.scala:431:22
  wire             _prober_io_rep_valid;	// dcache.scala:431:22
  wire [2:0]       _prober_io_rep_bits_param;	// dcache.scala:431:22
  wire [3:0]       _prober_io_rep_bits_size;	// dcache.scala:431:22
  wire [3:0]       _prober_io_rep_bits_source;	// dcache.scala:431:22
  wire [31:0]      _prober_io_rep_bits_address;	// dcache.scala:431:22
  wire             _prober_io_meta_read_valid;	// dcache.scala:431:22
  wire [5:0]       _prober_io_meta_read_bits_idx;	// dcache.scala:431:22
  wire [19:0]      _prober_io_meta_read_bits_tag;	// dcache.scala:431:22
  wire             _prober_io_meta_write_valid;	// dcache.scala:431:22
  wire [5:0]       _prober_io_meta_write_bits_idx;	// dcache.scala:431:22
  wire [7:0]       _prober_io_meta_write_bits_way_en;	// dcache.scala:431:22
  wire [1:0]       _prober_io_meta_write_bits_data_coh_state;	// dcache.scala:431:22
  wire [19:0]      _prober_io_meta_write_bits_data_tag;	// dcache.scala:431:22
  wire             _prober_io_wb_req_valid;	// dcache.scala:431:22
  wire [19:0]      _prober_io_wb_req_bits_tag;	// dcache.scala:431:22
  wire [5:0]       _prober_io_wb_req_bits_idx;	// dcache.scala:431:22
  wire [2:0]       _prober_io_wb_req_bits_param;	// dcache.scala:431:22
  wire [7:0]       _prober_io_wb_req_bits_way_en;	// dcache.scala:431:22
  wire             _prober_io_mshr_wb_rdy;	// dcache.scala:431:22
  wire             _prober_io_lsu_release_valid;	// dcache.scala:431:22
  wire [31:0]      _prober_io_lsu_release_bits_address;	// dcache.scala:431:22
  wire             _prober_io_state_valid;	// dcache.scala:431:22
  wire [39:0]      _prober_io_state_bits;	// dcache.scala:431:22
  wire             _wb_io_req_ready;	// dcache.scala:430:18
  wire             _wb_io_meta_read_valid;	// dcache.scala:430:18
  wire [5:0]       _wb_io_meta_read_bits_idx;	// dcache.scala:430:18
  wire [19:0]      _wb_io_meta_read_bits_tag;	// dcache.scala:430:18
  wire             _wb_io_resp;	// dcache.scala:430:18
  wire             _wb_io_idx_valid;	// dcache.scala:430:18
  wire [5:0]       _wb_io_idx_bits;	// dcache.scala:430:18
  wire             _wb_io_data_req_valid;	// dcache.scala:430:18
  wire [7:0]       _wb_io_data_req_bits_way_en;	// dcache.scala:430:18
  wire [11:0]      _wb_io_data_req_bits_addr;	// dcache.scala:430:18
  wire             _wb_io_release_valid;	// dcache.scala:430:18
  wire [2:0]       _wb_io_release_bits_opcode;	// dcache.scala:430:18
  wire [2:0]       _wb_io_release_bits_param;	// dcache.scala:430:18
  wire [31:0]      _wb_io_release_bits_address;	// dcache.scala:430:18
  wire [63:0]      _wb_io_release_bits_data;	// dcache.scala:430:18
  wire             _wb_io_lsu_release_valid;	// dcache.scala:430:18
  wire [31:0]      _wb_io_lsu_release_bits_address;	// dcache.scala:430:18
  wire             _meta_1_io_write_valid_T =
    _metaWriteArb_io_out_ready_T & _metaWriteArb_io_out_valid;	// Decoupled.scala:40:37, dcache.scala:442:28, :456:67
  wire             _metaReadArb_io_out_ready_T =
    _meta_0_io_read_ready | _meta_1_io_read_ready;	// dcache.scala:441:41, :455:66
  assign _metaWriteArb_io_out_ready_T = _meta_0_io_write_ready | _meta_1_io_write_ready;	// dcache.scala:441:41, :456:67
  wire             _io_lsu_req_ready_output =
    _metaReadArb_io_in_4_ready & _dataReadArb_io_in_2_ready;	// dcache.scala:444:27, :462:27, :479:50
  wire             _wb_fire_T = _wb_io_data_req_ready_T & _wb_io_meta_read_valid;	// Decoupled.scala:40:37, dcache.scala:430:18, :541:55
  wire             _wb_fire_T_1 = _wb_io_data_req_ready_T & _wb_io_data_req_valid;	// Decoupled.scala:40:37, dcache.scala:430:18, :541:55
  assign _wb_io_data_req_ready_T =
    _metaReadArb_io_in_2_ready & _dataReadArb_io_in_1_ready;	// dcache.scala:444:27, :462:27, :541:55
  reg  [6:0]       s1_req_0_uop_uopc;	// dcache.scala:599:32
  reg  [31:0]      s1_req_0_uop_inst;	// dcache.scala:599:32
  reg  [31:0]      s1_req_0_uop_debug_inst;	// dcache.scala:599:32
  reg              s1_req_0_uop_is_rvc;	// dcache.scala:599:32
  reg  [39:0]      s1_req_0_uop_debug_pc;	// dcache.scala:599:32
  reg  [2:0]       s1_req_0_uop_iq_type;	// dcache.scala:599:32
  reg  [9:0]       s1_req_0_uop_fu_code;	// dcache.scala:599:32
  reg  [3:0]       s1_req_0_uop_ctrl_br_type;	// dcache.scala:599:32
  reg  [1:0]       s1_req_0_uop_ctrl_op1_sel;	// dcache.scala:599:32
  reg  [2:0]       s1_req_0_uop_ctrl_op2_sel;	// dcache.scala:599:32
  reg  [2:0]       s1_req_0_uop_ctrl_imm_sel;	// dcache.scala:599:32
  reg  [3:0]       s1_req_0_uop_ctrl_op_fcn;	// dcache.scala:599:32
  reg              s1_req_0_uop_ctrl_fcn_dw;	// dcache.scala:599:32
  reg  [2:0]       s1_req_0_uop_ctrl_csr_cmd;	// dcache.scala:599:32
  reg              s1_req_0_uop_ctrl_is_load;	// dcache.scala:599:32
  reg              s1_req_0_uop_ctrl_is_sta;	// dcache.scala:599:32
  reg              s1_req_0_uop_ctrl_is_std;	// dcache.scala:599:32
  reg  [1:0]       s1_req_0_uop_iw_state;	// dcache.scala:599:32
  reg              s1_req_0_uop_iw_p1_poisoned;	// dcache.scala:599:32
  reg              s1_req_0_uop_iw_p2_poisoned;	// dcache.scala:599:32
  reg              s1_req_0_uop_is_br;	// dcache.scala:599:32
  reg              s1_req_0_uop_is_jalr;	// dcache.scala:599:32
  reg              s1_req_0_uop_is_jal;	// dcache.scala:599:32
  reg              s1_req_0_uop_is_sfb;	// dcache.scala:599:32
  reg  [19:0]      s1_req_0_uop_br_mask;	// dcache.scala:599:32
  reg  [4:0]       s1_req_0_uop_br_tag;	// dcache.scala:599:32
  reg  [5:0]       s1_req_0_uop_ftq_idx;	// dcache.scala:599:32
  reg              s1_req_0_uop_edge_inst;	// dcache.scala:599:32
  reg  [5:0]       s1_req_0_uop_pc_lob;	// dcache.scala:599:32
  reg              s1_req_0_uop_taken;	// dcache.scala:599:32
  reg  [19:0]      s1_req_0_uop_imm_packed;	// dcache.scala:599:32
  reg  [11:0]      s1_req_0_uop_csr_addr;	// dcache.scala:599:32
  reg  [6:0]       s1_req_0_uop_rob_idx;	// dcache.scala:599:32
  reg  [4:0]       s1_req_0_uop_ldq_idx;	// dcache.scala:599:32
  reg  [4:0]       s1_req_0_uop_stq_idx;	// dcache.scala:599:32
  reg  [1:0]       s1_req_0_uop_rxq_idx;	// dcache.scala:599:32
  reg  [6:0]       s1_req_0_uop_pdst;	// dcache.scala:599:32
  reg  [6:0]       s1_req_0_uop_prs1;	// dcache.scala:599:32
  reg  [6:0]       s1_req_0_uop_prs2;	// dcache.scala:599:32
  reg  [6:0]       s1_req_0_uop_prs3;	// dcache.scala:599:32
  reg  [5:0]       s1_req_0_uop_ppred;	// dcache.scala:599:32
  reg              s1_req_0_uop_prs1_busy;	// dcache.scala:599:32
  reg              s1_req_0_uop_prs2_busy;	// dcache.scala:599:32
  reg              s1_req_0_uop_prs3_busy;	// dcache.scala:599:32
  reg              s1_req_0_uop_ppred_busy;	// dcache.scala:599:32
  reg  [6:0]       s1_req_0_uop_stale_pdst;	// dcache.scala:599:32
  reg              s1_req_0_uop_exception;	// dcache.scala:599:32
  reg  [63:0]      s1_req_0_uop_exc_cause;	// dcache.scala:599:32
  reg              s1_req_0_uop_bypassable;	// dcache.scala:599:32
  reg  [4:0]       s1_req_0_uop_mem_cmd;	// dcache.scala:599:32
  reg  [1:0]       s1_req_0_uop_mem_size;	// dcache.scala:599:32
  reg              s1_req_0_uop_mem_signed;	// dcache.scala:599:32
  reg              s1_req_0_uop_is_fence;	// dcache.scala:599:32
  reg              s1_req_0_uop_is_fencei;	// dcache.scala:599:32
  reg              s1_req_0_uop_is_amo;	// dcache.scala:599:32
  reg              s1_req_0_uop_uses_ldq;	// dcache.scala:599:32
  reg              s1_req_0_uop_uses_stq;	// dcache.scala:599:32
  reg              s1_req_0_uop_is_sys_pc2epc;	// dcache.scala:599:32
  reg              s1_req_0_uop_is_unique;	// dcache.scala:599:32
  reg              s1_req_0_uop_flush_on_commit;	// dcache.scala:599:32
  reg              s1_req_0_uop_ldst_is_rs1;	// dcache.scala:599:32
  reg  [5:0]       s1_req_0_uop_ldst;	// dcache.scala:599:32
  reg  [5:0]       s1_req_0_uop_lrs1;	// dcache.scala:599:32
  reg  [5:0]       s1_req_0_uop_lrs2;	// dcache.scala:599:32
  reg  [5:0]       s1_req_0_uop_lrs3;	// dcache.scala:599:32
  reg              s1_req_0_uop_ldst_val;	// dcache.scala:599:32
  reg  [1:0]       s1_req_0_uop_dst_rtype;	// dcache.scala:599:32
  reg  [1:0]       s1_req_0_uop_lrs1_rtype;	// dcache.scala:599:32
  reg  [1:0]       s1_req_0_uop_lrs2_rtype;	// dcache.scala:599:32
  reg              s1_req_0_uop_frs3_en;	// dcache.scala:599:32
  reg              s1_req_0_uop_fp_val;	// dcache.scala:599:32
  reg              s1_req_0_uop_fp_single;	// dcache.scala:599:32
  reg              s1_req_0_uop_xcpt_pf_if;	// dcache.scala:599:32
  reg              s1_req_0_uop_xcpt_ae_if;	// dcache.scala:599:32
  reg              s1_req_0_uop_xcpt_ma_if;	// dcache.scala:599:32
  reg              s1_req_0_uop_bp_debug_if;	// dcache.scala:599:32
  reg              s1_req_0_uop_bp_xcpt_if;	// dcache.scala:599:32
  reg  [1:0]       s1_req_0_uop_debug_fsrc;	// dcache.scala:599:32
  reg  [1:0]       s1_req_0_uop_debug_tsrc;	// dcache.scala:599:32
  reg  [39:0]      s1_req_0_addr;	// dcache.scala:599:32
  reg  [63:0]      s1_req_0_data;	// dcache.scala:599:32
  reg              s1_req_0_is_hella;	// dcache.scala:599:32
  reg  [6:0]       s1_req_1_uop_uopc;	// dcache.scala:599:32
  reg  [31:0]      s1_req_1_uop_inst;	// dcache.scala:599:32
  reg  [31:0]      s1_req_1_uop_debug_inst;	// dcache.scala:599:32
  reg              s1_req_1_uop_is_rvc;	// dcache.scala:599:32
  reg  [39:0]      s1_req_1_uop_debug_pc;	// dcache.scala:599:32
  reg  [2:0]       s1_req_1_uop_iq_type;	// dcache.scala:599:32
  reg  [9:0]       s1_req_1_uop_fu_code;	// dcache.scala:599:32
  reg  [3:0]       s1_req_1_uop_ctrl_br_type;	// dcache.scala:599:32
  reg  [1:0]       s1_req_1_uop_ctrl_op1_sel;	// dcache.scala:599:32
  reg  [2:0]       s1_req_1_uop_ctrl_op2_sel;	// dcache.scala:599:32
  reg  [2:0]       s1_req_1_uop_ctrl_imm_sel;	// dcache.scala:599:32
  reg  [3:0]       s1_req_1_uop_ctrl_op_fcn;	// dcache.scala:599:32
  reg              s1_req_1_uop_ctrl_fcn_dw;	// dcache.scala:599:32
  reg  [2:0]       s1_req_1_uop_ctrl_csr_cmd;	// dcache.scala:599:32
  reg              s1_req_1_uop_ctrl_is_load;	// dcache.scala:599:32
  reg              s1_req_1_uop_ctrl_is_sta;	// dcache.scala:599:32
  reg              s1_req_1_uop_ctrl_is_std;	// dcache.scala:599:32
  reg  [1:0]       s1_req_1_uop_iw_state;	// dcache.scala:599:32
  reg              s1_req_1_uop_iw_p1_poisoned;	// dcache.scala:599:32
  reg              s1_req_1_uop_iw_p2_poisoned;	// dcache.scala:599:32
  reg              s1_req_1_uop_is_br;	// dcache.scala:599:32
  reg              s1_req_1_uop_is_jalr;	// dcache.scala:599:32
  reg              s1_req_1_uop_is_jal;	// dcache.scala:599:32
  reg              s1_req_1_uop_is_sfb;	// dcache.scala:599:32
  reg  [19:0]      s1_req_1_uop_br_mask;	// dcache.scala:599:32
  reg  [4:0]       s1_req_1_uop_br_tag;	// dcache.scala:599:32
  reg  [5:0]       s1_req_1_uop_ftq_idx;	// dcache.scala:599:32
  reg              s1_req_1_uop_edge_inst;	// dcache.scala:599:32
  reg  [5:0]       s1_req_1_uop_pc_lob;	// dcache.scala:599:32
  reg              s1_req_1_uop_taken;	// dcache.scala:599:32
  reg  [19:0]      s1_req_1_uop_imm_packed;	// dcache.scala:599:32
  reg  [11:0]      s1_req_1_uop_csr_addr;	// dcache.scala:599:32
  reg  [6:0]       s1_req_1_uop_rob_idx;	// dcache.scala:599:32
  reg  [4:0]       s1_req_1_uop_ldq_idx;	// dcache.scala:599:32
  reg  [4:0]       s1_req_1_uop_stq_idx;	// dcache.scala:599:32
  reg  [1:0]       s1_req_1_uop_rxq_idx;	// dcache.scala:599:32
  reg  [6:0]       s1_req_1_uop_pdst;	// dcache.scala:599:32
  reg  [6:0]       s1_req_1_uop_prs1;	// dcache.scala:599:32
  reg  [6:0]       s1_req_1_uop_prs2;	// dcache.scala:599:32
  reg  [6:0]       s1_req_1_uop_prs3;	// dcache.scala:599:32
  reg  [5:0]       s1_req_1_uop_ppred;	// dcache.scala:599:32
  reg              s1_req_1_uop_prs1_busy;	// dcache.scala:599:32
  reg              s1_req_1_uop_prs2_busy;	// dcache.scala:599:32
  reg              s1_req_1_uop_prs3_busy;	// dcache.scala:599:32
  reg              s1_req_1_uop_ppred_busy;	// dcache.scala:599:32
  reg  [6:0]       s1_req_1_uop_stale_pdst;	// dcache.scala:599:32
  reg              s1_req_1_uop_exception;	// dcache.scala:599:32
  reg  [63:0]      s1_req_1_uop_exc_cause;	// dcache.scala:599:32
  reg              s1_req_1_uop_bypassable;	// dcache.scala:599:32
  reg  [4:0]       s1_req_1_uop_mem_cmd;	// dcache.scala:599:32
  reg  [1:0]       s1_req_1_uop_mem_size;	// dcache.scala:599:32
  reg              s1_req_1_uop_mem_signed;	// dcache.scala:599:32
  reg              s1_req_1_uop_is_fence;	// dcache.scala:599:32
  reg              s1_req_1_uop_is_fencei;	// dcache.scala:599:32
  reg              s1_req_1_uop_is_amo;	// dcache.scala:599:32
  reg              s1_req_1_uop_uses_ldq;	// dcache.scala:599:32
  reg              s1_req_1_uop_uses_stq;	// dcache.scala:599:32
  reg              s1_req_1_uop_is_sys_pc2epc;	// dcache.scala:599:32
  reg              s1_req_1_uop_is_unique;	// dcache.scala:599:32
  reg              s1_req_1_uop_flush_on_commit;	// dcache.scala:599:32
  reg              s1_req_1_uop_ldst_is_rs1;	// dcache.scala:599:32
  reg  [5:0]       s1_req_1_uop_ldst;	// dcache.scala:599:32
  reg  [5:0]       s1_req_1_uop_lrs1;	// dcache.scala:599:32
  reg  [5:0]       s1_req_1_uop_lrs2;	// dcache.scala:599:32
  reg  [5:0]       s1_req_1_uop_lrs3;	// dcache.scala:599:32
  reg              s1_req_1_uop_ldst_val;	// dcache.scala:599:32
  reg  [1:0]       s1_req_1_uop_dst_rtype;	// dcache.scala:599:32
  reg  [1:0]       s1_req_1_uop_lrs1_rtype;	// dcache.scala:599:32
  reg  [1:0]       s1_req_1_uop_lrs2_rtype;	// dcache.scala:599:32
  reg              s1_req_1_uop_frs3_en;	// dcache.scala:599:32
  reg              s1_req_1_uop_fp_val;	// dcache.scala:599:32
  reg              s1_req_1_uop_fp_single;	// dcache.scala:599:32
  reg              s1_req_1_uop_xcpt_pf_if;	// dcache.scala:599:32
  reg              s1_req_1_uop_xcpt_ae_if;	// dcache.scala:599:32
  reg              s1_req_1_uop_xcpt_ma_if;	// dcache.scala:599:32
  reg              s1_req_1_uop_bp_debug_if;	// dcache.scala:599:32
  reg              s1_req_1_uop_bp_xcpt_if;	// dcache.scala:599:32
  reg  [1:0]       s1_req_1_uop_debug_fsrc;	// dcache.scala:599:32
  reg  [1:0]       s1_req_1_uop_debug_tsrc;	// dcache.scala:599:32
  reg  [39:0]      s1_req_1_addr;	// dcache.scala:599:32
  reg  [63:0]      s1_req_1_data;	// dcache.scala:599:32
  reg              s1_req_1_is_hella;	// dcache.scala:599:32
  reg              s1_valid_REG;	// dcache.scala:604:25
  reg              s1_valid_REG_1;	// dcache.scala:604:25
  reg              REG;	// dcache.scala:610:43
  reg              REG_1;	// dcache.scala:610:74
  reg              REG_2;	// dcache.scala:610:43
  reg              REG_3;	// dcache.scala:610:74
  reg              s1_send_resp_or_nack_0;	// dcache.scala:613:37
  reg              s1_send_resp_or_nack_1;	// dcache.scala:613:37
  reg  [2:0]       s1_type;	// dcache.scala:614:32
  reg  [7:0]       s1_mshr_meta_read_way_en;	// dcache.scala:616:41
  reg  [7:0]       s1_replay_way_en;	// dcache.scala:617:41
  reg  [7:0]       s1_wb_way_en;	// dcache.scala:618:41
  reg  [6:0]       s2_req_0_uop_uopc;	// dcache.scala:631:25
  reg  [31:0]      s2_req_0_uop_inst;	// dcache.scala:631:25
  reg  [31:0]      s2_req_0_uop_debug_inst;	// dcache.scala:631:25
  reg              s2_req_0_uop_is_rvc;	// dcache.scala:631:25
  reg  [39:0]      s2_req_0_uop_debug_pc;	// dcache.scala:631:25
  reg  [2:0]       s2_req_0_uop_iq_type;	// dcache.scala:631:25
  reg  [9:0]       s2_req_0_uop_fu_code;	// dcache.scala:631:25
  reg  [3:0]       s2_req_0_uop_ctrl_br_type;	// dcache.scala:631:25
  reg  [1:0]       s2_req_0_uop_ctrl_op1_sel;	// dcache.scala:631:25
  reg  [2:0]       s2_req_0_uop_ctrl_op2_sel;	// dcache.scala:631:25
  reg  [2:0]       s2_req_0_uop_ctrl_imm_sel;	// dcache.scala:631:25
  reg  [3:0]       s2_req_0_uop_ctrl_op_fcn;	// dcache.scala:631:25
  reg              s2_req_0_uop_ctrl_fcn_dw;	// dcache.scala:631:25
  reg  [2:0]       s2_req_0_uop_ctrl_csr_cmd;	// dcache.scala:631:25
  reg              s2_req_0_uop_ctrl_is_load;	// dcache.scala:631:25
  reg              s2_req_0_uop_ctrl_is_sta;	// dcache.scala:631:25
  reg              s2_req_0_uop_ctrl_is_std;	// dcache.scala:631:25
  reg  [1:0]       s2_req_0_uop_iw_state;	// dcache.scala:631:25
  reg              s2_req_0_uop_iw_p1_poisoned;	// dcache.scala:631:25
  reg              s2_req_0_uop_iw_p2_poisoned;	// dcache.scala:631:25
  reg              s2_req_0_uop_is_br;	// dcache.scala:631:25
  reg              s2_req_0_uop_is_jalr;	// dcache.scala:631:25
  reg              s2_req_0_uop_is_jal;	// dcache.scala:631:25
  reg              s2_req_0_uop_is_sfb;	// dcache.scala:631:25
  reg  [19:0]      s2_req_0_uop_br_mask;	// dcache.scala:631:25
  reg  [4:0]       s2_req_0_uop_br_tag;	// dcache.scala:631:25
  reg  [5:0]       s2_req_0_uop_ftq_idx;	// dcache.scala:631:25
  reg              s2_req_0_uop_edge_inst;	// dcache.scala:631:25
  reg  [5:0]       s2_req_0_uop_pc_lob;	// dcache.scala:631:25
  reg              s2_req_0_uop_taken;	// dcache.scala:631:25
  reg  [19:0]      s2_req_0_uop_imm_packed;	// dcache.scala:631:25
  reg  [11:0]      s2_req_0_uop_csr_addr;	// dcache.scala:631:25
  reg  [6:0]       s2_req_0_uop_rob_idx;	// dcache.scala:631:25
  reg  [4:0]       s2_req_0_uop_ldq_idx;	// dcache.scala:631:25
  reg  [4:0]       s2_req_0_uop_stq_idx;	// dcache.scala:631:25
  reg  [1:0]       s2_req_0_uop_rxq_idx;	// dcache.scala:631:25
  reg  [6:0]       s2_req_0_uop_pdst;	// dcache.scala:631:25
  reg  [6:0]       s2_req_0_uop_prs1;	// dcache.scala:631:25
  reg  [6:0]       s2_req_0_uop_prs2;	// dcache.scala:631:25
  reg  [6:0]       s2_req_0_uop_prs3;	// dcache.scala:631:25
  reg  [5:0]       s2_req_0_uop_ppred;	// dcache.scala:631:25
  reg              s2_req_0_uop_prs1_busy;	// dcache.scala:631:25
  reg              s2_req_0_uop_prs2_busy;	// dcache.scala:631:25
  reg              s2_req_0_uop_prs3_busy;	// dcache.scala:631:25
  reg              s2_req_0_uop_ppred_busy;	// dcache.scala:631:25
  reg  [6:0]       s2_req_0_uop_stale_pdst;	// dcache.scala:631:25
  reg              s2_req_0_uop_exception;	// dcache.scala:631:25
  reg  [63:0]      s2_req_0_uop_exc_cause;	// dcache.scala:631:25
  reg              s2_req_0_uop_bypassable;	// dcache.scala:631:25
  reg  [4:0]       s2_req_0_uop_mem_cmd;	// dcache.scala:631:25
  reg  [1:0]       size;	// dcache.scala:631:25
  reg              s2_req_0_uop_mem_signed;	// dcache.scala:631:25
  reg              s2_req_0_uop_is_fence;	// dcache.scala:631:25
  reg              s2_req_0_uop_is_fencei;	// dcache.scala:631:25
  reg              s2_req_0_uop_is_amo;	// dcache.scala:631:25
  reg              s2_req_0_uop_uses_ldq;	// dcache.scala:631:25
  reg              s2_req_0_uop_uses_stq;	// dcache.scala:631:25
  reg              s2_req_0_uop_is_sys_pc2epc;	// dcache.scala:631:25
  reg              s2_req_0_uop_is_unique;	// dcache.scala:631:25
  reg              s2_req_0_uop_flush_on_commit;	// dcache.scala:631:25
  reg              s2_req_0_uop_ldst_is_rs1;	// dcache.scala:631:25
  reg  [5:0]       s2_req_0_uop_ldst;	// dcache.scala:631:25
  reg  [5:0]       s2_req_0_uop_lrs1;	// dcache.scala:631:25
  reg  [5:0]       s2_req_0_uop_lrs2;	// dcache.scala:631:25
  reg  [5:0]       s2_req_0_uop_lrs3;	// dcache.scala:631:25
  reg              s2_req_0_uop_ldst_val;	// dcache.scala:631:25
  reg  [1:0]       s2_req_0_uop_dst_rtype;	// dcache.scala:631:25
  reg  [1:0]       s2_req_0_uop_lrs1_rtype;	// dcache.scala:631:25
  reg  [1:0]       s2_req_0_uop_lrs2_rtype;	// dcache.scala:631:25
  reg              s2_req_0_uop_frs3_en;	// dcache.scala:631:25
  reg              s2_req_0_uop_fp_val;	// dcache.scala:631:25
  reg              s2_req_0_uop_fp_single;	// dcache.scala:631:25
  reg              s2_req_0_uop_xcpt_pf_if;	// dcache.scala:631:25
  reg              s2_req_0_uop_xcpt_ae_if;	// dcache.scala:631:25
  reg              s2_req_0_uop_xcpt_ma_if;	// dcache.scala:631:25
  reg              s2_req_0_uop_bp_debug_if;	// dcache.scala:631:25
  reg              s2_req_0_uop_bp_xcpt_if;	// dcache.scala:631:25
  reg  [1:0]       s2_req_0_uop_debug_fsrc;	// dcache.scala:631:25
  reg  [1:0]       s2_req_0_uop_debug_tsrc;	// dcache.scala:631:25
  reg  [39:0]      s2_req_0_addr;	// dcache.scala:631:25
  reg  [63:0]      s2_req_0_data;	// dcache.scala:631:25
  reg              s2_req_0_is_hella;	// dcache.scala:631:25
  reg  [6:0]       s2_req_1_uop_uopc;	// dcache.scala:631:25
  reg  [31:0]      s2_req_1_uop_inst;	// dcache.scala:631:25
  reg  [31:0]      s2_req_1_uop_debug_inst;	// dcache.scala:631:25
  reg              s2_req_1_uop_is_rvc;	// dcache.scala:631:25
  reg  [39:0]      s2_req_1_uop_debug_pc;	// dcache.scala:631:25
  reg  [2:0]       s2_req_1_uop_iq_type;	// dcache.scala:631:25
  reg  [9:0]       s2_req_1_uop_fu_code;	// dcache.scala:631:25
  reg  [3:0]       s2_req_1_uop_ctrl_br_type;	// dcache.scala:631:25
  reg  [1:0]       s2_req_1_uop_ctrl_op1_sel;	// dcache.scala:631:25
  reg  [2:0]       s2_req_1_uop_ctrl_op2_sel;	// dcache.scala:631:25
  reg  [2:0]       s2_req_1_uop_ctrl_imm_sel;	// dcache.scala:631:25
  reg  [3:0]       s2_req_1_uop_ctrl_op_fcn;	// dcache.scala:631:25
  reg              s2_req_1_uop_ctrl_fcn_dw;	// dcache.scala:631:25
  reg  [2:0]       s2_req_1_uop_ctrl_csr_cmd;	// dcache.scala:631:25
  reg              s2_req_1_uop_ctrl_is_load;	// dcache.scala:631:25
  reg              s2_req_1_uop_ctrl_is_sta;	// dcache.scala:631:25
  reg              s2_req_1_uop_ctrl_is_std;	// dcache.scala:631:25
  reg  [1:0]       s2_req_1_uop_iw_state;	// dcache.scala:631:25
  reg              s2_req_1_uop_iw_p1_poisoned;	// dcache.scala:631:25
  reg              s2_req_1_uop_iw_p2_poisoned;	// dcache.scala:631:25
  reg              s2_req_1_uop_is_br;	// dcache.scala:631:25
  reg              s2_req_1_uop_is_jalr;	// dcache.scala:631:25
  reg              s2_req_1_uop_is_jal;	// dcache.scala:631:25
  reg              s2_req_1_uop_is_sfb;	// dcache.scala:631:25
  reg  [19:0]      s2_req_1_uop_br_mask;	// dcache.scala:631:25
  reg  [4:0]       s2_req_1_uop_br_tag;	// dcache.scala:631:25
  reg  [5:0]       s2_req_1_uop_ftq_idx;	// dcache.scala:631:25
  reg              s2_req_1_uop_edge_inst;	// dcache.scala:631:25
  reg  [5:0]       s2_req_1_uop_pc_lob;	// dcache.scala:631:25
  reg              s2_req_1_uop_taken;	// dcache.scala:631:25
  reg  [19:0]      s2_req_1_uop_imm_packed;	// dcache.scala:631:25
  reg  [11:0]      s2_req_1_uop_csr_addr;	// dcache.scala:631:25
  reg  [6:0]       s2_req_1_uop_rob_idx;	// dcache.scala:631:25
  reg  [4:0]       s2_req_1_uop_ldq_idx;	// dcache.scala:631:25
  reg  [4:0]       s2_req_1_uop_stq_idx;	// dcache.scala:631:25
  reg  [1:0]       s2_req_1_uop_rxq_idx;	// dcache.scala:631:25
  reg  [6:0]       s2_req_1_uop_pdst;	// dcache.scala:631:25
  reg  [6:0]       s2_req_1_uop_prs1;	// dcache.scala:631:25
  reg  [6:0]       s2_req_1_uop_prs2;	// dcache.scala:631:25
  reg  [6:0]       s2_req_1_uop_prs3;	// dcache.scala:631:25
  reg  [5:0]       s2_req_1_uop_ppred;	// dcache.scala:631:25
  reg              s2_req_1_uop_prs1_busy;	// dcache.scala:631:25
  reg              s2_req_1_uop_prs2_busy;	// dcache.scala:631:25
  reg              s2_req_1_uop_prs3_busy;	// dcache.scala:631:25
  reg              s2_req_1_uop_ppred_busy;	// dcache.scala:631:25
  reg  [6:0]       s2_req_1_uop_stale_pdst;	// dcache.scala:631:25
  reg              s2_req_1_uop_exception;	// dcache.scala:631:25
  reg  [63:0]      s2_req_1_uop_exc_cause;	// dcache.scala:631:25
  reg              s2_req_1_uop_bypassable;	// dcache.scala:631:25
  reg  [4:0]       s2_req_1_uop_mem_cmd;	// dcache.scala:631:25
  reg  [1:0]       size_1;	// dcache.scala:631:25
  reg              s2_req_1_uop_mem_signed;	// dcache.scala:631:25
  reg              s2_req_1_uop_is_fence;	// dcache.scala:631:25
  reg              s2_req_1_uop_is_fencei;	// dcache.scala:631:25
  reg              s2_req_1_uop_is_amo;	// dcache.scala:631:25
  reg              s2_req_1_uop_uses_ldq;	// dcache.scala:631:25
  reg              s2_req_1_uop_uses_stq;	// dcache.scala:631:25
  reg              s2_req_1_uop_is_sys_pc2epc;	// dcache.scala:631:25
  reg              s2_req_1_uop_is_unique;	// dcache.scala:631:25
  reg              s2_req_1_uop_flush_on_commit;	// dcache.scala:631:25
  reg              s2_req_1_uop_ldst_is_rs1;	// dcache.scala:631:25
  reg  [5:0]       s2_req_1_uop_ldst;	// dcache.scala:631:25
  reg  [5:0]       s2_req_1_uop_lrs1;	// dcache.scala:631:25
  reg  [5:0]       s2_req_1_uop_lrs2;	// dcache.scala:631:25
  reg  [5:0]       s2_req_1_uop_lrs3;	// dcache.scala:631:25
  reg              s2_req_1_uop_ldst_val;	// dcache.scala:631:25
  reg  [1:0]       s2_req_1_uop_dst_rtype;	// dcache.scala:631:25
  reg  [1:0]       s2_req_1_uop_lrs1_rtype;	// dcache.scala:631:25
  reg  [1:0]       s2_req_1_uop_lrs2_rtype;	// dcache.scala:631:25
  reg              s2_req_1_uop_frs3_en;	// dcache.scala:631:25
  reg              s2_req_1_uop_fp_val;	// dcache.scala:631:25
  reg              s2_req_1_uop_fp_single;	// dcache.scala:631:25
  reg              s2_req_1_uop_xcpt_pf_if;	// dcache.scala:631:25
  reg              s2_req_1_uop_xcpt_ae_if;	// dcache.scala:631:25
  reg              s2_req_1_uop_xcpt_ma_if;	// dcache.scala:631:25
  reg              s2_req_1_uop_bp_debug_if;	// dcache.scala:631:25
  reg              s2_req_1_uop_bp_xcpt_if;	// dcache.scala:631:25
  reg  [1:0]       s2_req_1_uop_debug_fsrc;	// dcache.scala:631:25
  reg  [1:0]       s2_req_1_uop_debug_tsrc;	// dcache.scala:631:25
  reg  [39:0]      s2_req_1_addr;	// dcache.scala:631:25
  reg  [63:0]      s2_req_1_data;	// dcache.scala:631:25
  reg              s2_req_1_is_hella;	// dcache.scala:631:25
  reg  [2:0]       s2_type;	// dcache.scala:632:25
  reg              s2_valid_REG;	// dcache.scala:634:26
  reg              s2_valid_REG_1;	// dcache.scala:634:26
  reg  [1:0]       s2_hit_state_REG_state;	// dcache.scala:644:93
  reg  [1:0]       s2_hit_state_REG_1_state;	// dcache.scala:644:93
  reg  [1:0]       s2_hit_state_REG_2_state;	// dcache.scala:644:93
  reg  [1:0]       s2_hit_state_REG_3_state;	// dcache.scala:644:93
  reg  [1:0]       s2_hit_state_REG_4_state;	// dcache.scala:644:93
  reg  [1:0]       s2_hit_state_REG_5_state;	// dcache.scala:644:93
  reg  [1:0]       s2_hit_state_REG_6_state;	// dcache.scala:644:93
  reg  [1:0]       s2_hit_state_REG_7_state;	// dcache.scala:644:93
  wire [1:0]       mshrs_io_req_0_bits_old_meta_meta_coh_state =
    (s2_tag_match_way_0[0] ? s2_hit_state_REG_state : 2'h0)
    | (s2_tag_match_way_0[1] ? s2_hit_state_REG_1_state : 2'h0)
    | (s2_tag_match_way_0[2] ? s2_hit_state_REG_2_state : 2'h0)
    | (s2_tag_match_way_0[3] ? s2_hit_state_REG_3_state : 2'h0)
    | (s2_tag_match_way_0[4] ? s2_hit_state_REG_4_state : 2'h0)
    | (s2_tag_match_way_0[5] ? s2_hit_state_REG_5_state : 2'h0)
    | (s2_tag_match_way_0[6] ? s2_hit_state_REG_6_state : 2'h0)
    | (s2_tag_match_way_0[7] ? s2_hit_state_REG_7_state : 2'h0);	// Mux.scala:27:72, :29:36, dcache.scala:432:21, :567:27, :642:33, :644:93
  reg  [1:0]       s2_hit_state_REG_8_state;	// dcache.scala:644:93
  reg  [1:0]       s2_hit_state_REG_9_state;	// dcache.scala:644:93
  reg  [1:0]       s2_hit_state_REG_10_state;	// dcache.scala:644:93
  reg  [1:0]       s2_hit_state_REG_11_state;	// dcache.scala:644:93
  reg  [1:0]       s2_hit_state_REG_12_state;	// dcache.scala:644:93
  reg  [1:0]       s2_hit_state_REG_13_state;	// dcache.scala:644:93
  reg  [1:0]       s2_hit_state_REG_14_state;	// dcache.scala:644:93
  reg  [1:0]       s2_hit_state_REG_15_state;	// dcache.scala:644:93
  wire [1:0]       mshrs_io_req_1_bits_old_meta_meta_coh_state =
    (s2_tag_match_way_1[0] ? s2_hit_state_REG_8_state : 2'h0)
    | (s2_tag_match_way_1[1] ? s2_hit_state_REG_9_state : 2'h0)
    | (s2_tag_match_way_1[2] ? s2_hit_state_REG_10_state : 2'h0)
    | (s2_tag_match_way_1[3] ? s2_hit_state_REG_11_state : 2'h0)
    | (s2_tag_match_way_1[4] ? s2_hit_state_REG_12_state : 2'h0)
    | (s2_tag_match_way_1[5] ? s2_hit_state_REG_13_state : 2'h0)
    | (s2_tag_match_way_1[6] ? s2_hit_state_REG_14_state : 2'h0)
    | (s2_tag_match_way_1[7] ? s2_hit_state_REG_15_state : 2'h0);	// Mux.scala:27:72, :29:36, dcache.scala:432:21, :567:27, :642:33, :644:93
  wire             _s3_valid_T_1 = s2_req_0_uop_mem_cmd == 5'h1;	// Consts.scala:82:32, dcache.scala:631:25
  wire             _s3_valid_T_2 = s2_req_0_uop_mem_cmd == 5'h11;	// Consts.scala:82:49, dcache.scala:631:25
  wire             _s3_valid_T_4 = s2_req_0_uop_mem_cmd == 5'h7;	// Consts.scala:81:65, :82:66, dcache.scala:631:25
  wire             _s3_valid_T_6 = s2_req_0_uop_mem_cmd == 5'h4;	// dcache.scala:631:25, package.scala:15:47
  wire             _s3_valid_T_7 = s2_req_0_uop_mem_cmd == 5'h9;	// dcache.scala:631:25, package.scala:15:47
  wire             _s3_valid_T_8 = s2_req_0_uop_mem_cmd == 5'hA;	// dcache.scala:631:25, package.scala:15:47
  wire             _s3_valid_T_9 = s2_req_0_uop_mem_cmd == 5'hB;	// dcache.scala:631:25, package.scala:15:47
  wire             _s3_valid_T_13 = s2_req_0_uop_mem_cmd == 5'h8;	// dcache.scala:631:25, package.scala:15:47
  wire             _s3_valid_T_14 = s2_req_0_uop_mem_cmd == 5'hC;	// dcache.scala:631:25, package.scala:15:47
  wire             _s3_valid_T_15 = s2_req_0_uop_mem_cmd == 5'hD;	// dcache.scala:631:25, package.scala:15:47
  wire             _s3_valid_T_16 = s2_req_0_uop_mem_cmd == 5'hE;	// dcache.scala:631:25, package.scala:15:47
  wire             _s3_valid_T_17 = s2_req_0_uop_mem_cmd == 5'hF;	// dcache.scala:631:25, package.scala:15:47
  wire             _mshrs_io_req_0_valid_T_22 = s2_req_0_uop_mem_cmd == 5'h3;	// Consts.scala:83:54, dcache.scala:631:25
  wire             _mshrs_io_req_0_valid_T_25 = s2_req_0_uop_mem_cmd == 5'h6;	// Consts.scala:81:48, :83:71, dcache.scala:631:25
  wire [3:0]       _s2_has_permission_T =
    {_s3_valid_T_1 | _s3_valid_T_2 | _s3_valid_T_4 | _s3_valid_T_6 | _s3_valid_T_7
       | _s3_valid_T_8 | _s3_valid_T_9 | _s3_valid_T_13 | _s3_valid_T_14 | _s3_valid_T_15
       | _s3_valid_T_16 | _s3_valid_T_17,
     _s3_valid_T_1 | _s3_valid_T_2 | _s3_valid_T_4 | _s3_valid_T_6 | _s3_valid_T_7
       | _s3_valid_T_8 | _s3_valid_T_9 | _s3_valid_T_13 | _s3_valid_T_14 | _s3_valid_T_15
       | _s3_valid_T_16 | _s3_valid_T_17 | _mshrs_io_req_0_valid_T_22
       | _mshrs_io_req_0_valid_T_25,
     mshrs_io_req_0_bits_old_meta_meta_coh_state};	// Cat.scala:30:58, Consts.scala:82:{32,49,66,76}, :83:{54,64,71}, Mux.scala:27:72, package.scala:15:47
  wire             s2_has_permission_0 =
    _s2_has_permission_T == 4'h3 | _s2_has_permission_T == 4'h2
    | _s2_has_permission_T == 4'h1 | _s2_has_permission_T == 4'h7
    | _s2_has_permission_T == 4'h6 | (&_s2_has_permission_T)
    | _s2_has_permission_T == 4'hE;	// Cat.scala:30:58, Misc.scala:34:9, :48:20, ReadyValidCancel.scala:70:19, dcache.scala:430:18, :813:31, package.scala:15:47
  wire             _mshrs_io_req_1_valid_T_48 = s2_req_1_uop_mem_cmd == 5'h1;	// Consts.scala:82:32, dcache.scala:631:25
  wire             _mshrs_io_req_1_valid_T_49 = s2_req_1_uop_mem_cmd == 5'h11;	// Consts.scala:82:49, dcache.scala:631:25
  wire             _mshrs_io_req_1_valid_T_51 = s2_req_1_uop_mem_cmd == 5'h7;	// Consts.scala:81:65, :82:66, dcache.scala:631:25
  wire             _mshrs_io_req_1_valid_T_53 = s2_req_1_uop_mem_cmd == 5'h4;	// dcache.scala:631:25, package.scala:15:47
  wire             _mshrs_io_req_1_valid_T_54 = s2_req_1_uop_mem_cmd == 5'h9;	// dcache.scala:631:25, package.scala:15:47
  wire             _mshrs_io_req_1_valid_T_55 = s2_req_1_uop_mem_cmd == 5'hA;	// dcache.scala:631:25, package.scala:15:47
  wire             _mshrs_io_req_1_valid_T_56 = s2_req_1_uop_mem_cmd == 5'hB;	// dcache.scala:631:25, package.scala:15:47
  wire             _mshrs_io_req_1_valid_T_60 = s2_req_1_uop_mem_cmd == 5'h8;	// dcache.scala:631:25, package.scala:15:47
  wire             _mshrs_io_req_1_valid_T_61 = s2_req_1_uop_mem_cmd == 5'hC;	// dcache.scala:631:25, package.scala:15:47
  wire             _mshrs_io_req_1_valid_T_62 = s2_req_1_uop_mem_cmd == 5'hD;	// dcache.scala:631:25, package.scala:15:47
  wire             _mshrs_io_req_1_valid_T_63 = s2_req_1_uop_mem_cmd == 5'hE;	// dcache.scala:631:25, package.scala:15:47
  wire             _mshrs_io_req_1_valid_T_64 = s2_req_1_uop_mem_cmd == 5'hF;	// dcache.scala:631:25, package.scala:15:47
  wire             _mshrs_io_req_1_valid_T_22 = s2_req_1_uop_mem_cmd == 5'h3;	// Consts.scala:83:54, dcache.scala:631:25
  wire             _mshrs_io_req_1_valid_T_25 = s2_req_1_uop_mem_cmd == 5'h6;	// Consts.scala:81:48, :83:71, dcache.scala:631:25
  wire [3:0]       _s2_has_permission_T_49 =
    {_mshrs_io_req_1_valid_T_48 | _mshrs_io_req_1_valid_T_49 | _mshrs_io_req_1_valid_T_51
       | _mshrs_io_req_1_valid_T_53 | _mshrs_io_req_1_valid_T_54
       | _mshrs_io_req_1_valid_T_55 | _mshrs_io_req_1_valid_T_56
       | _mshrs_io_req_1_valid_T_60 | _mshrs_io_req_1_valid_T_61
       | _mshrs_io_req_1_valid_T_62 | _mshrs_io_req_1_valid_T_63
       | _mshrs_io_req_1_valid_T_64,
     _mshrs_io_req_1_valid_T_48 | _mshrs_io_req_1_valid_T_49 | _mshrs_io_req_1_valid_T_51
       | _mshrs_io_req_1_valid_T_53 | _mshrs_io_req_1_valid_T_54
       | _mshrs_io_req_1_valid_T_55 | _mshrs_io_req_1_valid_T_56
       | _mshrs_io_req_1_valid_T_60 | _mshrs_io_req_1_valid_T_61
       | _mshrs_io_req_1_valid_T_62 | _mshrs_io_req_1_valid_T_63
       | _mshrs_io_req_1_valid_T_64 | _mshrs_io_req_1_valid_T_22
       | _mshrs_io_req_1_valid_T_25,
     mshrs_io_req_1_bits_old_meta_meta_coh_state};	// Cat.scala:30:58, Consts.scala:82:{32,49,66,76}, :83:{54,64,71}, Mux.scala:27:72, package.scala:15:47
  wire             s2_has_permission_1 =
    _s2_has_permission_T_49 == 4'h3 | _s2_has_permission_T_49 == 4'h2
    | _s2_has_permission_T_49 == 4'h1 | _s2_has_permission_T_49 == 4'h7
    | _s2_has_permission_T_49 == 4'h6 | (&_s2_has_permission_T_49)
    | _s2_has_permission_T_49 == 4'hE;	// Cat.scala:30:58, Misc.scala:34:9, :48:20, ReadyValidCancel.scala:70:19, dcache.scala:430:18, :813:31, package.scala:15:47
  wire [3:0]       _s2_new_hit_state_T =
    {_s3_valid_T_1 | _s3_valid_T_2 | _s3_valid_T_4 | _s3_valid_T_6 | _s3_valid_T_7
       | _s3_valid_T_8 | _s3_valid_T_9 | _s3_valid_T_13 | _s3_valid_T_14 | _s3_valid_T_15
       | _s3_valid_T_16 | _s3_valid_T_17,
     _s3_valid_T_1 | _s3_valid_T_2 | _s3_valid_T_4 | _s3_valid_T_6 | _s3_valid_T_7
       | _s3_valid_T_8 | _s3_valid_T_9 | _s3_valid_T_13 | _s3_valid_T_14 | _s3_valid_T_15
       | _s3_valid_T_16 | _s3_valid_T_17 | _mshrs_io_req_0_valid_T_22
       | _mshrs_io_req_0_valid_T_25,
     mshrs_io_req_0_bits_old_meta_meta_coh_state};	// Cat.scala:30:58, Consts.scala:82:{32,49,66,76}, :83:{54,64,71}, Mux.scala:27:72, package.scala:15:47
  wire [1:0]       _s2_new_hit_state_T_15 = {1'h0, _s2_new_hit_state_T == 4'hC};	// Cat.scala:30:58, Misc.scala:34:36, :48:20, Nodes.scala:1207:84, PRNG.scala:82:22, dcache.scala:426:49, :430:18, :431:22, :432:21, :459:20, :462:27, :567:27, :804:21, :813:31, package.scala:15:47
  wire [15:0][1:0] _GEN =
    {{2'h3},
     {2'h3},
     {2'h2},
     {_s2_new_hit_state_T_15},
     {_s2_new_hit_state_T_15},
     {_s2_new_hit_state_T_15},
     {_s2_new_hit_state_T_15},
     {_s2_new_hit_state_T_15},
     {2'h3},
     {2'h2},
     {2'h2},
     {2'h1},
     {2'h3},
     {2'h2},
     {2'h1},
     {2'h0}};	// Consts.scala:83:54, Misc.scala:34:36, :48:20, dcache.scala:432:21, :567:27, :596:16
  wire [3:0]       _s2_new_hit_state_T_49 =
    {_mshrs_io_req_1_valid_T_48 | _mshrs_io_req_1_valid_T_49 | _mshrs_io_req_1_valid_T_51
       | _mshrs_io_req_1_valid_T_53 | _mshrs_io_req_1_valid_T_54
       | _mshrs_io_req_1_valid_T_55 | _mshrs_io_req_1_valid_T_56
       | _mshrs_io_req_1_valid_T_60 | _mshrs_io_req_1_valid_T_61
       | _mshrs_io_req_1_valid_T_62 | _mshrs_io_req_1_valid_T_63
       | _mshrs_io_req_1_valid_T_64,
     _mshrs_io_req_1_valid_T_48 | _mshrs_io_req_1_valid_T_49 | _mshrs_io_req_1_valid_T_51
       | _mshrs_io_req_1_valid_T_53 | _mshrs_io_req_1_valid_T_54
       | _mshrs_io_req_1_valid_T_55 | _mshrs_io_req_1_valid_T_56
       | _mshrs_io_req_1_valid_T_60 | _mshrs_io_req_1_valid_T_61
       | _mshrs_io_req_1_valid_T_62 | _mshrs_io_req_1_valid_T_63
       | _mshrs_io_req_1_valid_T_64 | _mshrs_io_req_1_valid_T_22
       | _mshrs_io_req_1_valid_T_25,
     mshrs_io_req_1_bits_old_meta_meta_coh_state};	// Cat.scala:30:58, Consts.scala:82:{32,49,66,76}, :83:{54,64,71}, Mux.scala:27:72, package.scala:15:47
  wire [1:0]       _s2_new_hit_state_T_64 = {1'h0, _s2_new_hit_state_T_49 == 4'hC};	// Cat.scala:30:58, Misc.scala:34:36, :48:20, Nodes.scala:1207:84, PRNG.scala:82:22, dcache.scala:426:49, :430:18, :431:22, :432:21, :459:20, :462:27, :567:27, :804:21, :813:31, package.scala:15:47
  wire [15:0][1:0] _GEN_0 =
    {{2'h3},
     {2'h3},
     {2'h2},
     {_s2_new_hit_state_T_64},
     {_s2_new_hit_state_T_64},
     {_s2_new_hit_state_T_64},
     {_s2_new_hit_state_T_64},
     {_s2_new_hit_state_T_64},
     {2'h3},
     {2'h2},
     {2'h2},
     {2'h1},
     {2'h3},
     {2'h2},
     {2'h1},
     {2'h0}};	// Consts.scala:83:54, Misc.scala:34:36, :48:20, dcache.scala:432:21, :567:27, :596:16
  wire             _s2_hit_T_15 = s2_type == 3'h2;	// dcache.scala:588:21, :632:25, package.scala:15:47
  wire             s2_hit_0 =
    (|s2_tag_match_way_0) & s2_has_permission_0
    & mshrs_io_req_0_bits_old_meta_meta_coh_state == _GEN[_s2_new_hit_state_T]
    & ~_mshrs_io_block_hit_0 | ~(|s2_type) | _s2_hit_T_15;	// Cat.scala:30:58, Metadata.scala:45:46, Misc.scala:34:{9,36}, :48:20, Mux.scala:27:72, dcache.scala:432:21, :632:25, :642:33, :643:49, :648:{114,117,141}, package.scala:15:47
  wire             s2_hit_1 =
    (|s2_tag_match_way_1) & s2_has_permission_1
    & mshrs_io_req_1_bits_old_meta_meta_coh_state == _GEN_0[_s2_new_hit_state_T_49]
    & ~_mshrs_io_block_hit_1 | ~(|s2_type) | _s2_hit_T_15;	// Cat.scala:30:58, Metadata.scala:45:46, Misc.scala:34:{9,36}, :48:20, Mux.scala:27:72, dcache.scala:432:21, :632:25, :642:33, :643:49, :648:{114,117,141}, package.scala:15:47
  reg              s2_wb_idx_matches_0;	// dcache.scala:653:34
  reg              s2_wb_idx_matches_1;	// dcache.scala:653:34
  reg  [39:0]      debug_sc_fail_addr;	// dcache.scala:656:35
  reg  [7:0]       debug_sc_fail_cnt;	// dcache.scala:657:35
  reg  [6:0]       lrsc_count;	// dcache.scala:659:27
  reg  [33:0]      lrsc_addr;	// dcache.scala:661:23
  reg              s2_lr_REG;	// dcache.scala:662:59
  reg              s2_sc_REG;	// dcache.scala:663:59
  wire             s2_sc = _s3_valid_T_4 & (~s2_sc_REG | ~(|s2_type));	// Consts.scala:82:66, dcache.scala:632:25, :663:{47,51,59,72}, package.scala:15:47
  wire             s2_lrsc_addr_match_0 =
    (|(lrsc_count[6:2])) & lrsc_addr == s2_req_0_addr[39:6];	// dcache.scala:631:25, :659:27, :660:31, :661:23, :664:{53,66,86}
  wire             s2_sc_fail = s2_sc & ~s2_lrsc_addr_match_0;	// dcache.scala:663:47, :664:53, :665:{26,29}
  wire             _mshrs_io_req_1_valid_T_10 = s2_type == 3'h4;	// ReadyValidCancel.scala:70:19, dcache.scala:431:22, :632:25, :667:34, :813:31
  wire [63:0]      s2_data_word_prebypass_0 =
    (s2_tag_match_way_0[0] ? _data_io_resp_0_0 : 64'h0)
    | (s2_tag_match_way_0[1] ? _data_io_resp_0_1 : 64'h0)
    | (s2_tag_match_way_0[2] ? _data_io_resp_0_2 : 64'h0)
    | (s2_tag_match_way_0[3] ? _data_io_resp_0_3 : 64'h0)
    | (s2_tag_match_way_0[4] ? _data_io_resp_0_4 : 64'h0)
    | (s2_tag_match_way_0[5] ? _data_io_resp_0_5 : 64'h0)
    | (s2_tag_match_way_0[6] ? _data_io_resp_0_6 : 64'h0)
    | (s2_tag_match_way_0[7] ? _data_io_resp_0_7 : 64'h0);	// Mux.scala:27:72, :29:36, dcache.scala:431:22, :432:21, :459:20, :567:27, :642:33, :813:31
  reg  [2:0]       s2_replaced_way_en_REG;	// dcache.scala:717:44
  wire [7:0]       s2_replaced_way_en = 8'h1 << s2_replaced_way_en_REG;	// OneHot.scala:58:35, dcache.scala:717:44
  reg  [1:0]       s2_repl_meta_REG_coh_state;	// dcache.scala:718:88
  reg  [19:0]      s2_repl_meta_REG_tag;	// dcache.scala:718:88
  reg  [1:0]       s2_repl_meta_REG_1_coh_state;	// dcache.scala:718:88
  reg  [19:0]      s2_repl_meta_REG_1_tag;	// dcache.scala:718:88
  reg  [1:0]       s2_repl_meta_REG_2_coh_state;	// dcache.scala:718:88
  reg  [19:0]      s2_repl_meta_REG_2_tag;	// dcache.scala:718:88
  reg  [1:0]       s2_repl_meta_REG_3_coh_state;	// dcache.scala:718:88
  reg  [19:0]      s2_repl_meta_REG_3_tag;	// dcache.scala:718:88
  reg  [1:0]       s2_repl_meta_REG_4_coh_state;	// dcache.scala:718:88
  reg  [19:0]      s2_repl_meta_REG_4_tag;	// dcache.scala:718:88
  reg  [1:0]       s2_repl_meta_REG_5_coh_state;	// dcache.scala:718:88
  reg  [19:0]      s2_repl_meta_REG_5_tag;	// dcache.scala:718:88
  reg  [1:0]       s2_repl_meta_REG_6_coh_state;	// dcache.scala:718:88
  reg  [19:0]      s2_repl_meta_REG_6_tag;	// dcache.scala:718:88
  reg  [1:0]       s2_repl_meta_REG_7_coh_state;	// dcache.scala:718:88
  reg  [19:0]      s2_repl_meta_REG_7_tag;	// dcache.scala:718:88
  wire             _s2_repl_meta_T_38 = s2_replaced_way_en_REG == 3'h0;	// Mux.scala:29:36, dcache.scala:432:21, :567:27, :717:44
  wire             _s2_repl_meta_T_39 = s2_replaced_way_en_REG == 3'h1;	// Mux.scala:29:36, dcache.scala:589:21, :717:44
  wire             _s2_repl_meta_T_40 = s2_replaced_way_en_REG == 3'h2;	// Mux.scala:29:36, dcache.scala:588:21, :717:44
  wire             _s2_repl_meta_T_41 = s2_replaced_way_en_REG == 3'h3;	// Mux.scala:29:36, dcache.scala:591:21, :717:44
  wire             _s2_repl_meta_T_42 = s2_replaced_way_en_REG == 3'h4;	// Mux.scala:29:36, ReadyValidCancel.scala:70:19, dcache.scala:431:22, :717:44, :813:31
  wire             _s2_repl_meta_T_43 = s2_replaced_way_en_REG == 3'h5;	// Mux.scala:29:36, dcache.scala:590:21, :717:44
  wire             _s2_repl_meta_T_44 = s2_replaced_way_en_REG == 3'h6;	// Mux.scala:29:36, OneHot.scala:58:35, dcache.scala:717:44
  reg  [1:0]       s2_repl_meta_REG_8_coh_state;	// dcache.scala:718:88
  reg  [19:0]      s2_repl_meta_REG_8_tag;	// dcache.scala:718:88
  reg  [1:0]       s2_repl_meta_REG_9_coh_state;	// dcache.scala:718:88
  reg  [19:0]      s2_repl_meta_REG_9_tag;	// dcache.scala:718:88
  reg  [1:0]       s2_repl_meta_REG_10_coh_state;	// dcache.scala:718:88
  reg  [19:0]      s2_repl_meta_REG_10_tag;	// dcache.scala:718:88
  reg  [1:0]       s2_repl_meta_REG_11_coh_state;	// dcache.scala:718:88
  reg  [19:0]      s2_repl_meta_REG_11_tag;	// dcache.scala:718:88
  reg  [1:0]       s2_repl_meta_REG_12_coh_state;	// dcache.scala:718:88
  reg  [19:0]      s2_repl_meta_REG_12_tag;	// dcache.scala:718:88
  reg  [1:0]       s2_repl_meta_REG_13_coh_state;	// dcache.scala:718:88
  reg  [19:0]      s2_repl_meta_REG_13_tag;	// dcache.scala:718:88
  reg  [1:0]       s2_repl_meta_REG_14_coh_state;	// dcache.scala:718:88
  reg  [19:0]      s2_repl_meta_REG_14_tag;	// dcache.scala:718:88
  reg  [1:0]       s2_repl_meta_REG_15_coh_state;	// dcache.scala:718:88
  reg  [19:0]      s2_repl_meta_REG_15_tag;	// dcache.scala:718:88
  reg              s2_nack_hit_0;	// dcache.scala:721:31
  reg              s2_nack_hit_1;	// dcache.scala:721:31
  wire             _s3_valid_T = s2_valid_REG & s2_hit_0;	// dcache.scala:634:26, :648:141, :723:50
  wire             s2_nack_victim_0 = _s3_valid_T & _mshrs_io_secondary_miss_0;	// dcache.scala:432:21, :723:{50,64}
  wire             _s2_nack_victim_T_2 = s2_valid_REG_1 & s2_hit_1;	// dcache.scala:634:26, :648:141, :723:50
  wire             s2_nack_victim_1 = _s2_nack_victim_T_2 & _mshrs_io_secondary_miss_1;	// dcache.scala:432:21, :723:{50,64}
  wire             s2_nack_wb_0 = s2_valid_REG & ~s2_hit_0 & s2_wb_idx_matches_0;	// dcache.scala:634:26, :648:141, :650:36, :653:34, :729:64
  wire             s2_nack_wb_1 = s2_valid_REG_1 & ~s2_hit_1 & s2_wb_idx_matches_1;	// dcache.scala:634:26, :648:141, :653:34, :680:7, :729:64
  wire             s2_nack_0 =
    (s2_valid_REG & ~s2_hit_0 & ~_mshrs_io_req_0_ready | s2_nack_hit_0 | s2_nack_victim_0
     | s2_nack_wb_0) & (|s2_type);	// dcache.scala:432:21, :632:25, :634:26, :648:141, :650:36, :721:31, :723:64, :725:{64,67}, :729:64, :731:{113,131}, package.scala:15:47
  wire             s2_nack_1 =
    (s2_valid_REG_1 & ~s2_hit_1 & ~_mshrs_io_req_1_ready | s2_nack_hit_1
     | s2_nack_victim_1 | s2_nack_wb_1) & (|s2_type);	// dcache.scala:432:21, :632:25, :634:26, :648:141, :680:7, :721:31, :723:64, :725:{64,67}, :729:64, :731:{113,131}, package.scala:15:47
  reg              s2_send_resp_REG;	// dcache.scala:732:44
  wire             _s2_send_resp_T_2 = _mshrs_io_req_0_ready & _mshrs_io_req_0_valid_T_72;	// Decoupled.scala:40:37, dcache.scala:432:21, :753:77
  wire             _mshrs_io_req_0_valid_T_24 = s2_req_0_uop_mem_cmd == 5'h0;	// Consts.scala:81:31, dcache.scala:432:21, :567:27, :631:25
  wire             s2_send_resp_0 =
    s2_send_resp_REG & ~s2_nack_0
    & (s2_hit_0 | _s2_send_resp_T_2
       & (_s3_valid_T_1 | _s3_valid_T_2 | _s3_valid_T_4 | _s3_valid_T_6 | _s3_valid_T_7
          | _s3_valid_T_8 | _s3_valid_T_9 | _s3_valid_T_13 | _s3_valid_T_14
          | _s3_valid_T_15 | _s3_valid_T_16 | _s3_valid_T_17)
       & ~(_mshrs_io_req_0_valid_T_24 | _mshrs_io_req_0_valid_T_25 | _s3_valid_T_4
           | _s3_valid_T_6 | _s3_valid_T_7 | _s3_valid_T_8 | _s3_valid_T_9
           | _s3_valid_T_13 | _s3_valid_T_14 | _s3_valid_T_15 | _s3_valid_T_16
           | _s3_valid_T_17));	// Consts.scala:81:{31,75}, :82:{32,49,66,76}, :83:71, Decoupled.scala:40:37, dcache.scala:648:141, :667:60, :731:131, :732:{44,85}, :733:{34,95,98}, package.scala:15:47
  reg              s2_send_resp_REG_1;	// dcache.scala:732:44
  wire             _s2_send_resp_T_56 =
    _mshrs_io_req_1_ready & _mshrs_io_req_1_valid_T_72;	// Decoupled.scala:40:37, dcache.scala:432:21, :753:77
  wire             _mshrs_io_req_1_valid_T_24 = s2_req_1_uop_mem_cmd == 5'h0;	// Consts.scala:81:31, dcache.scala:432:21, :567:27, :631:25
  wire             s2_send_resp_1 =
    s2_send_resp_REG_1 & ~s2_nack_1
    & (s2_hit_1 | _s2_send_resp_T_56
       & (_mshrs_io_req_1_valid_T_48 | _mshrs_io_req_1_valid_T_49
          | _mshrs_io_req_1_valid_T_51 | _mshrs_io_req_1_valid_T_53
          | _mshrs_io_req_1_valid_T_54 | _mshrs_io_req_1_valid_T_55
          | _mshrs_io_req_1_valid_T_56 | _mshrs_io_req_1_valid_T_60
          | _mshrs_io_req_1_valid_T_61 | _mshrs_io_req_1_valid_T_62
          | _mshrs_io_req_1_valid_T_63 | _mshrs_io_req_1_valid_T_64)
       & ~(_mshrs_io_req_1_valid_T_24 | _mshrs_io_req_1_valid_T_25
           | _mshrs_io_req_1_valid_T_51 | _mshrs_io_req_1_valid_T_53
           | _mshrs_io_req_1_valid_T_54 | _mshrs_io_req_1_valid_T_55
           | _mshrs_io_req_1_valid_T_56 | _mshrs_io_req_1_valid_T_60
           | _mshrs_io_req_1_valid_T_61 | _mshrs_io_req_1_valid_T_62
           | _mshrs_io_req_1_valid_T_63 | _mshrs_io_req_1_valid_T_64));	// Consts.scala:81:{31,75}, :82:{32,49,66,76}, :83:71, Decoupled.scala:40:37, dcache.scala:648:141, :683:7, :731:131, :732:{44,85}, :733:{34,95,98}, package.scala:15:47
  reg              s2_send_nack_REG;	// dcache.scala:734:44
  wire             s2_send_nack_0 = s2_send_nack_REG & s2_nack_0;	// dcache.scala:731:131, :734:{44,70}
  reg              s2_send_nack_REG_1;	// dcache.scala:734:44
  wire             s2_send_nack_1 = s2_send_nack_REG_1 & s2_nack_1;	// dcache.scala:731:131, :734:{44,70}
  wire             s2_store_failed =
    s2_valid_REG & s2_nack_0 & s2_send_nack_0 & s2_req_0_uop_uses_stq;	// dcache.scala:631:25, :634:26, :731:131, :734:70, :741:67
  wire             _mshrs_io_req_1_valid_T_11 = s2_type == 3'h5;	// dcache.scala:590:21, :632:25, package.scala:15:47
  wire [19:0]      _io_lsu_nack_0_valid_T_4 =
    io_lsu_brupdate_b1_mispredict_mask & s2_req_0_uop_br_mask;	// dcache.scala:631:25, util.scala:118:51
  wire             _io_lsu_nack_0_valid_T_1 = io_lsu_exception & s2_req_0_uop_uses_ldq;	// dcache.scala:631:25, :753:48
  assign _mshrs_io_req_0_valid_T_72 =
    s2_valid_REG & ~s2_hit_0 & ~s2_nack_hit_0 & ~s2_nack_victim_0 & ~s2_nack_wb_0
    & (_mshrs_io_req_1_valid_T_10 | _mshrs_io_req_1_valid_T_11)
    & _io_lsu_nack_0_valid_T_4 == 20'h0 & ~_io_lsu_nack_0_valid_T_1
    & (s2_req_0_uop_mem_cmd == 5'h2 | _mshrs_io_req_0_valid_T_22
       | _mshrs_io_req_0_valid_T_24 | _mshrs_io_req_0_valid_T_25 | _s3_valid_T_4
       | _s3_valid_T_6 | _s3_valid_T_7 | _s3_valid_T_8 | _s3_valid_T_9 | _s3_valid_T_13
       | _s3_valid_T_14 | _s3_valid_T_15 | _s3_valid_T_16 | _s3_valid_T_17 | _s3_valid_T_1
       | _s3_valid_T_2);	// Consts.scala:80:35, :81:31, :82:{32,49,66}, :83:{54,71}, dcache.scala:431:22, :432:21, :441:41, :442:28, :444:27, :567:27, :631:25, :634:26, :648:141, :650:36, :667:34, :721:31, :723:64, :729:64, :747:29, :748:29, :750:29, :753:{29,48,77}, :755:65, package.scala:15:47, :72:59, util.scala:118:{51,59}
  wire             _mshrs_io_req_is_probe_1_T = s2_type == 3'h1;	// dcache.scala:589:21, :632:25, :768:49
  wire [19:0]      _io_lsu_nack_1_valid_T_4 =
    io_lsu_brupdate_b1_mispredict_mask & s2_req_1_uop_br_mask;	// dcache.scala:631:25, util.scala:118:51
  wire             _io_lsu_nack_1_valid_T_1 = io_lsu_exception & s2_req_1_uop_uses_ldq;	// dcache.scala:631:25, :753:48
  assign _mshrs_io_req_1_valid_T_72 =
    s2_valid_REG_1 & ~s2_hit_1 & ~s2_nack_hit_1 & ~s2_nack_victim_1 & ~s2_nack_wb_1
    & (_mshrs_io_req_1_valid_T_10 | _mshrs_io_req_1_valid_T_11)
    & _io_lsu_nack_1_valid_T_4 == 20'h0 & ~_io_lsu_nack_1_valid_T_1
    & (s2_req_1_uop_mem_cmd == 5'h2 | _mshrs_io_req_1_valid_T_22
       | _mshrs_io_req_1_valid_T_24 | _mshrs_io_req_1_valid_T_25
       | _mshrs_io_req_1_valid_T_51 | _mshrs_io_req_1_valid_T_53
       | _mshrs_io_req_1_valid_T_54 | _mshrs_io_req_1_valid_T_55
       | _mshrs_io_req_1_valid_T_56 | _mshrs_io_req_1_valid_T_60
       | _mshrs_io_req_1_valid_T_61 | _mshrs_io_req_1_valid_T_62
       | _mshrs_io_req_1_valid_T_63 | _mshrs_io_req_1_valid_T_64
       | _mshrs_io_req_1_valid_T_48 | _mshrs_io_req_1_valid_T_49);	// Consts.scala:80:35, :81:31, :82:{32,49,66}, :83:{54,71}, dcache.scala:431:22, :432:21, :441:41, :442:28, :444:27, :567:27, :631:25, :634:26, :648:141, :667:34, :680:7, :721:31, :723:64, :729:64, :747:29, :748:29, :750:29, :753:{29,48,77}, :755:65, package.scala:15:47, :72:59, util.scala:118:{51,59}
  reg  [1:0]       mshrs_io_meta_resp_bits_REG_0_coh_state;	// dcache.scala:772:70
  reg  [1:0]       mshrs_io_meta_resp_bits_REG_1_coh_state;	// dcache.scala:772:70
  reg  [1:0]       mshrs_io_meta_resp_bits_REG_2_coh_state;	// dcache.scala:772:70
  reg  [1:0]       mshrs_io_meta_resp_bits_REG_3_coh_state;	// dcache.scala:772:70
  reg  [1:0]       mshrs_io_meta_resp_bits_REG_4_coh_state;	// dcache.scala:772:70
  reg  [1:0]       mshrs_io_meta_resp_bits_REG_5_coh_state;	// dcache.scala:772:70
  reg  [1:0]       mshrs_io_meta_resp_bits_REG_6_coh_state;	// dcache.scala:772:70
  reg  [1:0]       mshrs_io_meta_resp_bits_REG_7_coh_state;	// dcache.scala:772:70
  wire             _wb_io_mem_grant_T_1 = auto_out_d_bits_source == 4'h8;	// ReadyValidCancel.scala:70:19, dcache.scala:430:18, :788:30, :813:31
  wire             tl_out_d_ready = _wb_io_mem_grant_T_1 | _mshrs_io_mem_grant_ready;	// dcache.scala:432:21, :788:{30,48}, :790:20, :795:24
  reg  [8:0]       beatsLeft;	// Arbiter.scala:87:30
  wire             idle = beatsLeft == 9'h0;	// Arbiter.scala:87:30, :88:28, :111:73, Edges.scala:220:14
  wire             earlyWinner_1 = ~_wb_io_release_valid & _prober_io_rep_valid;	// Arbiter.scala:16:61, :97:79, dcache.scala:430:18, :431:22
  wire             _sink_ACancel_earlyValid_T =
    _wb_io_release_valid | _prober_io_rep_valid;	// Arbiter.scala:107:36, dcache.scala:430:18, :431:22
  reg              state_0;	// Arbiter.scala:116:26
  reg              state_1;	// Arbiter.scala:116:26
  wire             muxStateEarly_0 = idle ? _wb_io_release_valid : state_0;	// Arbiter.scala:88:28, :116:26, :117:30, dcache.scala:430:18
  wire             muxStateEarly_1 = idle ? earlyWinner_1 : state_1;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire             out_2_valid =
    idle
      ? _sink_ACancel_earlyValid_T
      : state_0 & _wb_io_release_valid | state_1 & _prober_io_rep_valid;	// Arbiter.scala:88:28, :107:36, :116:26, :125:29, Mux.scala:27:72, dcache.scala:430:18, :431:22
  wire             cache_resp_0_valid = s2_valid_REG & s2_send_resp_0;	// dcache.scala:634:26, :732:85, :834:48
  wire [31:0]      cache_resp_0_bits_data_lo =
    s2_req_0_addr[2] ? s2_data_word_0[63:32] : s2_data_word_0[31:0];	// AMOALU.scala:39:{24,29,37,55}, dcache.scala:631:25, :890:27
  wire [15:0]      cache_resp_0_bits_data_lo_1 =
    s2_req_0_addr[1] ? cache_resp_0_bits_data_lo[31:16] : cache_resp_0_bits_data_lo[15:0];	// AMOALU.scala:39:{24,29,37,55}, dcache.scala:631:25
  wire [7:0]       cache_resp_0_bits_data_lo_2 =
    s2_sc
      ? 8'h0
      : s2_req_0_addr[0]
          ? cache_resp_0_bits_data_lo_1[15:8]
          : cache_resp_0_bits_data_lo_1[7:0];	// AMOALU.scala:39:{24,29,37,55}, :41:23, dcache.scala:631:25, :663:47
  wire             cache_resp_1_valid = s2_valid_REG_1 & s2_send_resp_1;	// dcache.scala:634:26, :732:85, :834:48
  wire [31:0]      cache_resp_1_bits_data_lo =
    s2_req_1_addr[2] ? s2_data_word_1[63:32] : s2_data_word_1[31:0];	// AMOALU.scala:39:{24,29,37,55}, dcache.scala:631:25, :890:27
  wire [15:0]      cache_resp_1_bits_data_lo_1 =
    s2_req_1_addr[1] ? cache_resp_1_bits_data_lo[31:16] : cache_resp_1_bits_data_lo[15:0];	// AMOALU.scala:39:{24,29,37,55}, dcache.scala:631:25
  wire [7:0]       cache_resp_1_bits_data_lo_2 =
    s2_req_1_addr[0]
      ? cache_resp_1_bits_data_lo_1[15:8]
      : cache_resp_1_bits_data_lo_1[7:0];	// AMOALU.scala:39:{24,29,37,55}, dcache.scala:631:25
  wire             io_lsu_resp_0_bits_out_uop_uses_ldq =
    cache_resp_0_valid ? s2_req_0_uop_uses_ldq : _mshrs_io_resp_bits_uop_uses_ldq;	// dcache.scala:432:21, :631:25, :834:48, :849:28, :850:15
  wire             uncache_respond_1 = ~cache_resp_1_valid & cache_resp_0_valid;	// dcache.scala:834:48, :848:{27,48}
  wire             io_lsu_resp_1_bits_out_uop_uses_ldq =
    uncache_respond_1 ? _mshrs_io_resp_bits_uop_uses_ldq : s2_req_1_uop_uses_ldq;	// dcache.scala:432:21, :631:25, :848:48, :849:28, :850:15
  wire             _io_lsu_nack_0_valid_output =
    s2_valid_REG & s2_send_nack_0 & ~_io_lsu_nack_0_valid_T_1
    & _io_lsu_nack_0_valid_T_4 == 20'h0;	// dcache.scala:431:22, :432:21, :441:41, :442:28, :444:27, :567:27, :634:26, :734:70, :753:48, :862:{29,75}, util.scala:118:{51,59}
  wire             _io_lsu_nack_1_valid_output =
    s2_valid_REG_1 & s2_send_nack_1 & ~_io_lsu_nack_1_valid_T_1
    & _io_lsu_nack_1_valid_T_4 == 20'h0;	// dcache.scala:431:22, :432:21, :441:41, :442:28, :444:27, :567:27, :634:26, :734:70, :753:48, :862:{29,75}, util.scala:118:{51,59}
  reg  [39:0]      s3_req_addr;	// dcache.scala:869:25
  reg  [63:0]      s3_req_data;	// dcache.scala:869:25
  reg              s3_valid;	// dcache.scala:870:25
  `ifndef SYNTHESIS	// dcache.scala:547:9
    always @(posedge clock) begin	// dcache.scala:547:9
      automatic logic _GEN_1;	// dcache.scala:865:46
      _GEN_1 = s2_type != 3'h4;	// ReadyValidCancel.scala:70:19, dcache.scala:431:22, :632:25, :813:31, :865:46
      if (~(_wb_fire_T ^ ~_wb_fire_T_1 | reset)) begin	// Decoupled.scala:40:37, dcache.scala:547:{9,10}
        if (`ASSERT_VERBOSE_COND_)	// dcache.scala:547:9
          $error("Assertion failed\n    at dcache.scala:547 assert(!(wb.io.meta_read.fire() ^ wb.io.data_req.fire()))\n");	// dcache.scala:547:9
        if (`STOP_COND_)	// dcache.scala:547:9
          $fatal;	// dcache.scala:547:9
      end
      if (~(~(io_lsu_s1_kill_0 & ~REG & ~REG_1) | reset)) begin	// dcache.scala:610:{11,12,35,43,63,66,74}
        if (`ASSERT_VERBOSE_COND_)	// dcache.scala:610:11
          $error("Assertion failed\n    at dcache.scala:610 assert(!(io.lsu.s1_kill(w) && !RegNext(io.lsu.req.fire()) && !RegNext(io.lsu.req.bits(w).valid)))\n");	// dcache.scala:610:11
        if (`STOP_COND_)	// dcache.scala:610:11
          $fatal;	// dcache.scala:610:11
      end
      if (~(~(io_lsu_s1_kill_1 & ~REG_2 & ~REG_3) | reset)) begin	// dcache.scala:610:{11,12,35,43,63,66,74}
        if (`ASSERT_VERBOSE_COND_)	// dcache.scala:610:11
          $error("Assertion failed\n    at dcache.scala:610 assert(!(io.lsu.s1_kill(w) && !RegNext(io.lsu.req.fire()) && !RegNext(io.lsu.req.bits(w).valid)))\n");	// dcache.scala:610:11
        if (`STOP_COND_)	// dcache.scala:610:11
          $fatal;	// dcache.scala:610:11
      end
      if (~(~(~(|s2_type) & ~s2_hit_0) | reset)) begin	// dcache.scala:632:25, :648:141, :650:{9,10,33,36}, package.scala:15:47
        if (`ASSERT_VERBOSE_COND_)	// dcache.scala:650:9
          $error("Assertion failed: Replays should always hit\n    at dcache.scala:650 assert(!(s2_type === t_replay && !s2_hit(0)), \"Replays should always hit\")\n");	// dcache.scala:650:9
        if (`STOP_COND_)	// dcache.scala:650:9
          $fatal;	// dcache.scala:650:9
      end
      if (~(~(_s2_hit_T_15 & ~s2_hit_0) | reset)) begin	// dcache.scala:648:141, :650:36, :651:{9,10,29}, package.scala:15:47
        if (`ASSERT_VERBOSE_COND_)	// dcache.scala:651:9
          $error("Assertion failed: Writeback should always see data hit\n    at dcache.scala:651 assert(!(s2_type === t_wb && !s2_hit(0)), \"Writeback should always see data hit\")\n");	// dcache.scala:651:9
        if (`STOP_COND_)	// dcache.scala:651:9
          $fatal;	// dcache.scala:651:9
      end
      if (~(debug_sc_fail_cnt < 8'h64 | reset)) begin	// dcache.scala:657:35, :702:{9,28}
        if (`ASSERT_VERBOSE_COND_)	// dcache.scala:702:9
          $error("Assertion failed: L1DCache failed too many SCs in a row\n    at dcache.scala:702 assert(debug_sc_fail_cnt < 100.U, \"L1DCache failed too many SCs in a row\")\n");	// dcache.scala:702:9
        if (`STOP_COND_)	// dcache.scala:702:9
          $fatal;	// dcache.scala:702:9
      end
      if (~(~(s2_send_resp_0 & s2_send_nack_0) | reset)) begin	// dcache.scala:732:85, :734:70, :736:{11,12,30}
        if (`ASSERT_VERBOSE_COND_)	// dcache.scala:736:11
          $error("Assertion failed\n    at dcache.scala:736 assert(!(s2_send_resp(w) && s2_send_nack(w)))\n");	// dcache.scala:736:11
        if (`STOP_COND_)	// dcache.scala:736:11
          $fatal;	// dcache.scala:736:11
      end
      if (~(~(s2_send_resp_1 & s2_send_nack_1) | reset)) begin	// dcache.scala:732:85, :734:70, :736:{11,12,30}
        if (`ASSERT_VERBOSE_COND_)	// dcache.scala:736:11
          $error("Assertion failed\n    at dcache.scala:736 assert(!(s2_send_resp(w) && s2_send_nack(w)))\n");	// dcache.scala:736:11
        if (`STOP_COND_)	// dcache.scala:736:11
          $fatal;	// dcache.scala:736:11
      end
      if (~(~(_mshrs_io_req_0_valid_T_72 & ~(|s2_type)) | reset)) begin	// dcache.scala:632:25, :753:77, :757:{11,12,36}, package.scala:15:47
        if (`ASSERT_VERBOSE_COND_)	// dcache.scala:757:11
          $error("Assertion failed: Replays should not need to go back into MSHRs\n    at dcache.scala:757 assert(!(mshrs.io.req(w).valid && s2_type === t_replay), \"Replays should not need to go back into MSHRs\")\n");	// dcache.scala:757:11
        if (`STOP_COND_)	// dcache.scala:757:11
          $fatal;	// dcache.scala:757:11
      end
      if (~(~(_mshrs_io_req_1_valid_T_72 & ~(|s2_type)) | reset)) begin	// dcache.scala:632:25, :753:77, :757:{11,12,36}, package.scala:15:47
        if (`ASSERT_VERBOSE_COND_)	// dcache.scala:757:11
          $error("Assertion failed: Replays should not need to go back into MSHRs\n    at dcache.scala:757 assert(!(mshrs.io.req(w).valid && s2_type === t_replay), \"Replays should not need to go back into MSHRs\")\n");	// dcache.scala:757:11
        if (`STOP_COND_)	// dcache.scala:757:11
          $fatal;	// dcache.scala:757:11
      end
      if (~(~_wb_io_release_valid | ~earlyWinner_1 | reset)) begin	// Arbiter.scala:97:79, :105:{13,61,67}, dcache.scala:430:18
        if (`ASSERT_VERBOSE_COND_)	// Arbiter.scala:105:13
          $error("Assertion failed\n    at Arbiter.scala:105 assert((prefixOR zip earlyWinner) map { case (p,w) => !p || !w } reduce {_ && _})\n");	// Arbiter.scala:105:13
        if (`STOP_COND_)	// Arbiter.scala:105:13
          $fatal;	// Arbiter.scala:105:13
      end
      if (~(~_sink_ACancel_earlyValid_T | _wb_io_release_valid | earlyWinner_1
            | reset)) begin	// Arbiter.scala:97:79, :107:{14,15,36}, dcache.scala:430:18
        if (`ASSERT_VERBOSE_COND_)	// Arbiter.scala:107:14
          $error("Assertion failed\n    at Arbiter.scala:107 assert (!earlyValids.reduce(_||_) || earlyWinner.reduce(_||_))\n");	// Arbiter.scala:107:14
        if (`STOP_COND_)	// Arbiter.scala:107:14
          $fatal;	// Arbiter.scala:107:14
      end
      if (~(~(_io_lsu_nack_0_valid_output & _GEN_1) | reset)) begin	// dcache.scala:862:75, :865:{11,12,35,46}
        if (`ASSERT_VERBOSE_COND_)	// dcache.scala:865:11
          $error("Assertion failed\n    at dcache.scala:865 assert(!(io.lsu.nack(w).valid && s2_type =/= t_lsu))\n");	// dcache.scala:865:11
        if (`STOP_COND_)	// dcache.scala:865:11
          $fatal;	// dcache.scala:865:11
      end
      if (~(~(_io_lsu_nack_1_valid_output & _GEN_1) | reset)) begin	// dcache.scala:862:75, :865:{11,12,35,46}
        if (`ASSERT_VERBOSE_COND_)	// dcache.scala:865:11
          $error("Assertion failed\n    at dcache.scala:865 assert(!(io.lsu.nack(w).valid && s2_type =/= t_lsu))\n");	// dcache.scala:865:11
        if (`STOP_COND_)	// dcache.scala:865:11
          $fatal;	// dcache.scala:865:11
      end
      if (~(~(_s2_nack_victim_T_2
              & (_mshrs_io_req_1_valid_T_48 | _mshrs_io_req_1_valid_T_49
                 | _mshrs_io_req_1_valid_T_51 | _mshrs_io_req_1_valid_T_53
                 | _mshrs_io_req_1_valid_T_54 | _mshrs_io_req_1_valid_T_55
                 | _mshrs_io_req_1_valid_T_56 | _mshrs_io_req_1_valid_T_60
                 | _mshrs_io_req_1_valid_T_61 | _mshrs_io_req_1_valid_T_62
                 | _mshrs_io_req_1_valid_T_63 | _mshrs_io_req_1_valid_T_64) & ~s2_sc_fail
              & ~(s2_send_nack_1 & s2_nack_1)) | reset)) begin	// Consts.scala:82:{32,49,66,76}, dcache.scala:665:26, :723:50, :731:131, :734:70, :871:26, :873:{11,12}, :874:{38,41,59}, package.scala:15:47
        if (`ASSERT_VERBOSE_COND_)	// dcache.scala:873:11
          $error("Assertion failed: Store must go through 0th pipe in L1D\n    at dcache.scala:873 assert(!(s2_valid(w) && s2_hit(w) && isWrite(s2_req(w).uop.mem_cmd) &&\n");	// dcache.scala:873:11
        if (`STOP_COND_)	// dcache.scala:873:11
          $fatal;	// dcache.scala:873:11
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  reg  [39:0]      s4_req_addr;	// dcache.scala:879:25
  reg  [63:0]      s4_req_data;	// dcache.scala:879:25
  reg              s4_valid;	// dcache.scala:880:25
  reg  [39:0]      s5_req_addr;	// dcache.scala:881:25
  reg  [63:0]      s5_req_data;	// dcache.scala:881:25
  reg              s5_valid;	// dcache.scala:882:25
  assign s2_data_word_0 =
    s3_valid & s2_req_0_addr[39:3] == s3_req_addr[39:3]
      ? s3_req_data
      : s4_valid & s2_req_0_addr[39:3] == s4_req_addr[39:3]
          ? s4_req_data
          : s5_valid & s2_req_0_addr[39:3] == s5_req_addr[39:3]
              ? s5_req_data
              : s2_data_word_prebypass_0;	// Mux.scala:27:72, dcache.scala:631:25, :869:25, :870:25, :879:25, :880:25, :881:25, :882:25, :884:{42,62,78,95}, :885:{42,78,95}, :886:{42,78,95}, :890:27, :891:27, :892:27
  assign s2_data_word_1 =
    s3_valid & s2_req_1_addr[39:3] == s3_req_addr[39:3]
      ? s3_req_data
      : s4_valid & s2_req_1_addr[39:3] == s4_req_addr[39:3]
          ? s4_req_data
          : s5_valid & s2_req_1_addr[39:3] == s5_req_addr[39:3]
              ? s5_req_data
              : (s2_tag_match_way_1[0] ? _data_io_resp_1_0 : 64'h0)
                | (s2_tag_match_way_1[1] ? _data_io_resp_1_1 : 64'h0)
                | (s2_tag_match_way_1[2] ? _data_io_resp_1_2 : 64'h0)
                | (s2_tag_match_way_1[3] ? _data_io_resp_1_3 : 64'h0)
                | (s2_tag_match_way_1[4] ? _data_io_resp_1_4 : 64'h0)
                | (s2_tag_match_way_1[5] ? _data_io_resp_1_5 : 64'h0)
                | (s2_tag_match_way_1[6] ? _data_io_resp_1_6 : 64'h0)
                | (s2_tag_match_way_1[7] ? _data_io_resp_1_7 : 64'h0);	// Mux.scala:27:72, :29:36, dcache.scala:431:22, :432:21, :459:20, :567:27, :631:25, :642:33, :813:31, :869:25, :870:25, :879:25, :880:25, :881:25, :882:25, :884:{42,62,78,95}, :885:{42,78,95}, :886:{42,78,95}, :890:27, :891:27, :892:27
  wire [1:0]       _amoalu_io_mask_T = {s2_req_0_addr[0] | (|size), ~(s2_req_0_addr[0])};	// AMOALU.scala:17:{46,57}, :18:22, :39:29, Cat.scala:30:58, dcache.scala:470:28, :631:25
  wire [3:0]       _amoalu_io_mask_T_1 =
    {(s2_req_0_addr[1] ? _amoalu_io_mask_T : 2'h0) | {2{size[1]}},
     s2_req_0_addr[1] ? 2'h0 : _amoalu_io_mask_T};	// AMOALU.scala:17:{22,46,51,57}, :18:22, :39:29, Cat.scala:30:58, dcache.scala:432:21, :567:27, :631:25
  reg  [7:0]       s3_way;	// dcache.scala:903:25
  always @(posedge clock) begin
    automatic logic        wb_fire;	// dcache.scala:530:40
    automatic logic        prober_fire;	// Decoupled.scala:40:37
    automatic logic        prefetch_fire;	// Decoupled.scala:40:37
    automatic logic        _s1_valid_T_19;	// Decoupled.scala:40:37
    automatic logic        _s0_send_resp_or_nack_T_1;	// Decoupled.scala:40:37
    automatic logic        _s0_type_T_1;	// Decoupled.scala:40:37
    automatic logic        _GEN_2;	// dcache.scala:582:21, :583:21
    automatic logic        _GEN_3;	// dcache.scala:582:21, :583:21, :584:21, :585:21
    automatic logic        _s0_req_T_5_0_uop_uses_ldq;	// dcache.scala:582:21, :583:21, :584:21, :585:21
    automatic logic        _s0_req_T_5_0_uop_uses_stq;	// dcache.scala:582:21, :583:21, :584:21, :585:21
    automatic logic [19:0] s0_req_0_uop_br_mask;	// dcache.scala:581:21
    automatic logic [19:0] s0_req_1_uop_br_mask;	// dcache.scala:581:21
    automatic logic        s0_req_1_uop_uses_ldq;	// dcache.scala:581:21
    automatic logic        s0_req_1_uop_uses_stq;	// dcache.scala:581:21
    automatic logic        _s2_nack_hit_WIRE_0;	// dcache.scala:612:93
    automatic logic        _s2_valid_T_23;	// dcache.scala:638:56
    automatic logic        s2_lr;	// dcache.scala:662:47
    automatic logic        _GEN_4;	// dcache.scala:667:21
    wb_fire = _wb_fire_T & _wb_fire_T_1;	// Decoupled.scala:40:37, dcache.scala:530:40
    prober_fire = _metaReadArb_io_in_1_ready & _prober_io_meta_read_valid;	// Decoupled.scala:40:37, dcache.scala:431:22, :444:27
    prefetch_fire = _metaReadArb_io_in_5_ready & _mshrs_io_prefetch_valid;	// Decoupled.scala:40:37, dcache.scala:432:21, :444:27
    _s1_valid_T_19 = _io_lsu_req_ready_output & io_lsu_req_valid;	// Decoupled.scala:40:37, dcache.scala:479:50
    _s0_send_resp_or_nack_T_1 = _metaReadArb_io_out_ready_T & _mshrs_io_replay_valid;	// Decoupled.scala:40:37, dcache.scala:432:21, :455:66
    _s0_type_T_1 = _metaReadArb_io_in_3_ready & _mshrs_io_meta_read_valid;	// Decoupled.scala:40:37, dcache.scala:432:21, :444:27
    _GEN_2 = wb_fire | prober_fire;	// Decoupled.scala:40:37, dcache.scala:530:40, :582:21, :583:21
    _GEN_3 = _GEN_2 | prefetch_fire | _s0_type_T_1;	// Decoupled.scala:40:37, dcache.scala:582:21, :583:21, :584:21, :585:21
    _s0_req_T_5_0_uop_uses_ldq = ~_GEN_3 & _mshrs_io_replay_bits_uop_uses_ldq;	// dcache.scala:432:21, :582:21, :583:21, :584:21, :585:21
    _s0_req_T_5_0_uop_uses_stq = ~_GEN_3 & _mshrs_io_replay_bits_uop_uses_stq;	// dcache.scala:432:21, :582:21, :583:21, :584:21, :585:21
    s0_req_0_uop_br_mask =
      _s1_valid_T_19
        ? io_lsu_req_bits_0_bits_uop_br_mask
        : _GEN_3 ? 20'h0 : _mshrs_io_replay_bits_uop_br_mask;	// Decoupled.scala:40:37, dcache.scala:431:22, :432:21, :441:41, :442:28, :444:27, :567:27, :581:21, :582:21, :583:21, :584:21, :585:21
    s0_req_1_uop_br_mask = _s1_valid_T_19 ? io_lsu_req_bits_1_bits_uop_br_mask : 20'h0;	// Decoupled.scala:40:37, dcache.scala:431:22, :432:21, :441:41, :442:28, :444:27, :567:27, :581:21
    s0_req_1_uop_uses_ldq = _s1_valid_T_19 & io_lsu_req_bits_1_bits_uop_uses_ldq;	// Decoupled.scala:40:37, dcache.scala:581:21
    s0_req_1_uop_uses_stq = _s1_valid_T_19 & io_lsu_req_bits_1_bits_uop_uses_stq;	// Decoupled.scala:40:37, dcache.scala:581:21
    _s2_nack_hit_WIRE_0 =
      s1_req_0_addr[11:6] == _prober_io_meta_write_bits_idx & ~_prober_io_req_ready;	// dcache.scala:431:22, :599:32, :612:{43,59,93,96}
    _s2_valid_T_23 = s1_type == 3'h4;	// ReadyValidCancel.scala:70:19, dcache.scala:431:22, :614:32, :638:56, :813:31
    s2_lr = _mshrs_io_req_0_valid_T_25 & (~s2_lr_REG | ~(|s2_type));	// Consts.scala:83:71, dcache.scala:632:25, :662:{47,51,59,72}, package.scala:15:47
    _GEN_4 =
      s2_valid_REG
      & (_mshrs_io_req_1_valid_T_10 & s2_hit_0 & ~s2_nack_0 | ~(|s2_type)
         & s2_req_0_uop_mem_cmd != 5'h5);	// dcache.scala:631:25, :632:25, :634:26, :648:141, :667:{21,34,57,60,73}, :668:{44,69}, :731:131, package.scala:15:47
    if (_s1_valid_T_19) begin	// Decoupled.scala:40:37
      s1_req_0_uop_uopc <= io_lsu_req_bits_0_bits_uop_uopc;	// dcache.scala:599:32
      s1_req_0_uop_inst <= io_lsu_req_bits_0_bits_uop_inst;	// dcache.scala:599:32
      s1_req_0_uop_debug_inst <= io_lsu_req_bits_0_bits_uop_debug_inst;	// dcache.scala:599:32
      s1_req_0_uop_is_rvc <= io_lsu_req_bits_0_bits_uop_is_rvc;	// dcache.scala:599:32
      s1_req_0_uop_debug_pc <= io_lsu_req_bits_0_bits_uop_debug_pc;	// dcache.scala:599:32
      s1_req_0_uop_iq_type <= io_lsu_req_bits_0_bits_uop_iq_type;	// dcache.scala:599:32
      s1_req_0_uop_fu_code <= io_lsu_req_bits_0_bits_uop_fu_code;	// dcache.scala:599:32
      s1_req_0_uop_ctrl_br_type <= io_lsu_req_bits_0_bits_uop_ctrl_br_type;	// dcache.scala:599:32
      s1_req_0_uop_ctrl_op1_sel <= io_lsu_req_bits_0_bits_uop_ctrl_op1_sel;	// dcache.scala:599:32
      s1_req_0_uop_ctrl_op2_sel <= io_lsu_req_bits_0_bits_uop_ctrl_op2_sel;	// dcache.scala:599:32
      s1_req_0_uop_ctrl_imm_sel <= io_lsu_req_bits_0_bits_uop_ctrl_imm_sel;	// dcache.scala:599:32
      s1_req_0_uop_ctrl_op_fcn <= io_lsu_req_bits_0_bits_uop_ctrl_op_fcn;	// dcache.scala:599:32
      s1_req_0_uop_ctrl_fcn_dw <= io_lsu_req_bits_0_bits_uop_ctrl_fcn_dw;	// dcache.scala:599:32
      s1_req_0_uop_ctrl_csr_cmd <= io_lsu_req_bits_0_bits_uop_ctrl_csr_cmd;	// dcache.scala:599:32
      s1_req_0_uop_ctrl_is_load <= io_lsu_req_bits_0_bits_uop_ctrl_is_load;	// dcache.scala:599:32
      s1_req_0_uop_ctrl_is_sta <= io_lsu_req_bits_0_bits_uop_ctrl_is_sta;	// dcache.scala:599:32
      s1_req_0_uop_ctrl_is_std <= io_lsu_req_bits_0_bits_uop_ctrl_is_std;	// dcache.scala:599:32
      s1_req_0_uop_iw_state <= io_lsu_req_bits_0_bits_uop_iw_state;	// dcache.scala:599:32
      s1_req_0_uop_iw_p1_poisoned <= io_lsu_req_bits_0_bits_uop_iw_p1_poisoned;	// dcache.scala:599:32
      s1_req_0_uop_iw_p2_poisoned <= io_lsu_req_bits_0_bits_uop_iw_p2_poisoned;	// dcache.scala:599:32
      s1_req_0_uop_is_br <= io_lsu_req_bits_0_bits_uop_is_br;	// dcache.scala:599:32
      s1_req_0_uop_is_jalr <= io_lsu_req_bits_0_bits_uop_is_jalr;	// dcache.scala:599:32
      s1_req_0_uop_is_jal <= io_lsu_req_bits_0_bits_uop_is_jal;	// dcache.scala:599:32
      s1_req_0_uop_is_sfb <= io_lsu_req_bits_0_bits_uop_is_sfb;	// dcache.scala:599:32
      s1_req_0_uop_br_tag <= io_lsu_req_bits_0_bits_uop_br_tag;	// dcache.scala:599:32
      s1_req_0_uop_ftq_idx <= io_lsu_req_bits_0_bits_uop_ftq_idx;	// dcache.scala:599:32
      s1_req_0_uop_edge_inst <= io_lsu_req_bits_0_bits_uop_edge_inst;	// dcache.scala:599:32
      s1_req_0_uop_pc_lob <= io_lsu_req_bits_0_bits_uop_pc_lob;	// dcache.scala:599:32
      s1_req_0_uop_taken <= io_lsu_req_bits_0_bits_uop_taken;	// dcache.scala:599:32
      s1_req_0_uop_imm_packed <= io_lsu_req_bits_0_bits_uop_imm_packed;	// dcache.scala:599:32
      s1_req_0_uop_csr_addr <= io_lsu_req_bits_0_bits_uop_csr_addr;	// dcache.scala:599:32
      s1_req_0_uop_rob_idx <= io_lsu_req_bits_0_bits_uop_rob_idx;	// dcache.scala:599:32
      s1_req_0_uop_ldq_idx <= io_lsu_req_bits_0_bits_uop_ldq_idx;	// dcache.scala:599:32
      s1_req_0_uop_stq_idx <= io_lsu_req_bits_0_bits_uop_stq_idx;	// dcache.scala:599:32
      s1_req_0_uop_rxq_idx <= io_lsu_req_bits_0_bits_uop_rxq_idx;	// dcache.scala:599:32
      s1_req_0_uop_pdst <= io_lsu_req_bits_0_bits_uop_pdst;	// dcache.scala:599:32
      s1_req_0_uop_prs1 <= io_lsu_req_bits_0_bits_uop_prs1;	// dcache.scala:599:32
      s1_req_0_uop_prs2 <= io_lsu_req_bits_0_bits_uop_prs2;	// dcache.scala:599:32
      s1_req_0_uop_prs3 <= io_lsu_req_bits_0_bits_uop_prs3;	// dcache.scala:599:32
      s1_req_0_uop_ppred <= io_lsu_req_bits_0_bits_uop_ppred;	// dcache.scala:599:32
      s1_req_0_uop_prs1_busy <= io_lsu_req_bits_0_bits_uop_prs1_busy;	// dcache.scala:599:32
      s1_req_0_uop_prs2_busy <= io_lsu_req_bits_0_bits_uop_prs2_busy;	// dcache.scala:599:32
      s1_req_0_uop_prs3_busy <= io_lsu_req_bits_0_bits_uop_prs3_busy;	// dcache.scala:599:32
      s1_req_0_uop_ppred_busy <= io_lsu_req_bits_0_bits_uop_ppred_busy;	// dcache.scala:599:32
      s1_req_0_uop_stale_pdst <= io_lsu_req_bits_0_bits_uop_stale_pdst;	// dcache.scala:599:32
      s1_req_0_uop_exception <= io_lsu_req_bits_0_bits_uop_exception;	// dcache.scala:599:32
      s1_req_0_uop_exc_cause <= io_lsu_req_bits_0_bits_uop_exc_cause;	// dcache.scala:599:32
      s1_req_0_uop_bypassable <= io_lsu_req_bits_0_bits_uop_bypassable;	// dcache.scala:599:32
      s1_req_0_uop_mem_cmd <= io_lsu_req_bits_0_bits_uop_mem_cmd;	// dcache.scala:599:32
      s1_req_0_uop_mem_size <= io_lsu_req_bits_0_bits_uop_mem_size;	// dcache.scala:599:32
      s1_req_0_uop_mem_signed <= io_lsu_req_bits_0_bits_uop_mem_signed;	// dcache.scala:599:32
      s1_req_0_uop_is_fence <= io_lsu_req_bits_0_bits_uop_is_fence;	// dcache.scala:599:32
      s1_req_0_uop_is_fencei <= io_lsu_req_bits_0_bits_uop_is_fencei;	// dcache.scala:599:32
      s1_req_0_uop_is_amo <= io_lsu_req_bits_0_bits_uop_is_amo;	// dcache.scala:599:32
      s1_req_0_uop_uses_ldq <= io_lsu_req_bits_0_bits_uop_uses_ldq;	// dcache.scala:599:32
      s1_req_0_uop_uses_stq <= io_lsu_req_bits_0_bits_uop_uses_stq;	// dcache.scala:599:32
      s1_req_0_uop_is_sys_pc2epc <= io_lsu_req_bits_0_bits_uop_is_sys_pc2epc;	// dcache.scala:599:32
      s1_req_0_uop_is_unique <= io_lsu_req_bits_0_bits_uop_is_unique;	// dcache.scala:599:32
      s1_req_0_uop_flush_on_commit <= io_lsu_req_bits_0_bits_uop_flush_on_commit;	// dcache.scala:599:32
      s1_req_0_uop_ldst_is_rs1 <= io_lsu_req_bits_0_bits_uop_ldst_is_rs1;	// dcache.scala:599:32
      s1_req_0_uop_ldst <= io_lsu_req_bits_0_bits_uop_ldst;	// dcache.scala:599:32
      s1_req_0_uop_lrs1 <= io_lsu_req_bits_0_bits_uop_lrs1;	// dcache.scala:599:32
      s1_req_0_uop_lrs2 <= io_lsu_req_bits_0_bits_uop_lrs2;	// dcache.scala:599:32
      s1_req_0_uop_lrs3 <= io_lsu_req_bits_0_bits_uop_lrs3;	// dcache.scala:599:32
      s1_req_0_uop_ldst_val <= io_lsu_req_bits_0_bits_uop_ldst_val;	// dcache.scala:599:32
      s1_req_0_uop_dst_rtype <= io_lsu_req_bits_0_bits_uop_dst_rtype;	// dcache.scala:599:32
      s1_req_0_uop_lrs1_rtype <= io_lsu_req_bits_0_bits_uop_lrs1_rtype;	// dcache.scala:599:32
      s1_req_0_uop_lrs2_rtype <= io_lsu_req_bits_0_bits_uop_lrs2_rtype;	// dcache.scala:599:32
      s1_req_0_uop_frs3_en <= io_lsu_req_bits_0_bits_uop_frs3_en;	// dcache.scala:599:32
      s1_req_0_uop_fp_val <= io_lsu_req_bits_0_bits_uop_fp_val;	// dcache.scala:599:32
      s1_req_0_uop_fp_single <= io_lsu_req_bits_0_bits_uop_fp_single;	// dcache.scala:599:32
      s1_req_0_uop_xcpt_pf_if <= io_lsu_req_bits_0_bits_uop_xcpt_pf_if;	// dcache.scala:599:32
      s1_req_0_uop_xcpt_ae_if <= io_lsu_req_bits_0_bits_uop_xcpt_ae_if;	// dcache.scala:599:32
      s1_req_0_uop_xcpt_ma_if <= io_lsu_req_bits_0_bits_uop_xcpt_ma_if;	// dcache.scala:599:32
      s1_req_0_uop_bp_debug_if <= io_lsu_req_bits_0_bits_uop_bp_debug_if;	// dcache.scala:599:32
      s1_req_0_uop_bp_xcpt_if <= io_lsu_req_bits_0_bits_uop_bp_xcpt_if;	// dcache.scala:599:32
      s1_req_0_uop_debug_fsrc <= io_lsu_req_bits_0_bits_uop_debug_fsrc;	// dcache.scala:599:32
      s1_req_0_uop_debug_tsrc <= io_lsu_req_bits_0_bits_uop_debug_tsrc;	// dcache.scala:599:32
      s1_req_0_addr <= io_lsu_req_bits_0_bits_addr;	// dcache.scala:599:32
      s1_req_0_data <= io_lsu_req_bits_0_bits_data;	// dcache.scala:599:32
      s1_req_1_uop_uopc <= io_lsu_req_bits_1_bits_uop_uopc;	// dcache.scala:599:32
      s1_req_1_uop_inst <= io_lsu_req_bits_1_bits_uop_inst;	// dcache.scala:599:32
      s1_req_1_uop_debug_inst <= io_lsu_req_bits_1_bits_uop_debug_inst;	// dcache.scala:599:32
      s1_req_1_uop_debug_pc <= io_lsu_req_bits_1_bits_uop_debug_pc;	// dcache.scala:599:32
      s1_req_1_uop_iq_type <= io_lsu_req_bits_1_bits_uop_iq_type;	// dcache.scala:599:32
      s1_req_1_uop_fu_code <= io_lsu_req_bits_1_bits_uop_fu_code;	// dcache.scala:599:32
      s1_req_1_uop_ctrl_br_type <= io_lsu_req_bits_1_bits_uop_ctrl_br_type;	// dcache.scala:599:32
      s1_req_1_uop_ctrl_op1_sel <= io_lsu_req_bits_1_bits_uop_ctrl_op1_sel;	// dcache.scala:599:32
      s1_req_1_uop_ctrl_op2_sel <= io_lsu_req_bits_1_bits_uop_ctrl_op2_sel;	// dcache.scala:599:32
      s1_req_1_uop_ctrl_imm_sel <= io_lsu_req_bits_1_bits_uop_ctrl_imm_sel;	// dcache.scala:599:32
      s1_req_1_uop_ctrl_op_fcn <= io_lsu_req_bits_1_bits_uop_ctrl_op_fcn;	// dcache.scala:599:32
      s1_req_1_uop_ctrl_csr_cmd <= io_lsu_req_bits_1_bits_uop_ctrl_csr_cmd;	// dcache.scala:599:32
      s1_req_1_uop_iw_state <= io_lsu_req_bits_1_bits_uop_iw_state;	// dcache.scala:599:32
      s1_req_1_uop_br_tag <= io_lsu_req_bits_1_bits_uop_br_tag;	// dcache.scala:599:32
      s1_req_1_uop_ftq_idx <= io_lsu_req_bits_1_bits_uop_ftq_idx;	// dcache.scala:599:32
      s1_req_1_uop_pc_lob <= io_lsu_req_bits_1_bits_uop_pc_lob;	// dcache.scala:599:32
      s1_req_1_uop_imm_packed <= io_lsu_req_bits_1_bits_uop_imm_packed;	// dcache.scala:599:32
      s1_req_1_uop_csr_addr <= io_lsu_req_bits_1_bits_uop_csr_addr;	// dcache.scala:599:32
      s1_req_1_uop_rob_idx <= io_lsu_req_bits_1_bits_uop_rob_idx;	// dcache.scala:599:32
      s1_req_1_uop_ldq_idx <= io_lsu_req_bits_1_bits_uop_ldq_idx;	// dcache.scala:599:32
      s1_req_1_uop_stq_idx <= io_lsu_req_bits_1_bits_uop_stq_idx;	// dcache.scala:599:32
      s1_req_1_uop_rxq_idx <= io_lsu_req_bits_1_bits_uop_rxq_idx;	// dcache.scala:599:32
      s1_req_1_uop_pdst <= io_lsu_req_bits_1_bits_uop_pdst;	// dcache.scala:599:32
      s1_req_1_uop_prs1 <= io_lsu_req_bits_1_bits_uop_prs1;	// dcache.scala:599:32
      s1_req_1_uop_prs2 <= io_lsu_req_bits_1_bits_uop_prs2;	// dcache.scala:599:32
      s1_req_1_uop_prs3 <= io_lsu_req_bits_1_bits_uop_prs3;	// dcache.scala:599:32
      s1_req_1_uop_ppred <= io_lsu_req_bits_1_bits_uop_ppred;	// dcache.scala:599:32
      s1_req_1_uop_stale_pdst <= io_lsu_req_bits_1_bits_uop_stale_pdst;	// dcache.scala:599:32
      s1_req_1_uop_exc_cause <= io_lsu_req_bits_1_bits_uop_exc_cause;	// dcache.scala:599:32
      s1_req_1_uop_mem_cmd <= io_lsu_req_bits_1_bits_uop_mem_cmd;	// dcache.scala:599:32
      s1_req_1_uop_mem_size <= io_lsu_req_bits_1_bits_uop_mem_size;	// dcache.scala:599:32
      s1_req_1_uop_ldst <= io_lsu_req_bits_1_bits_uop_ldst;	// dcache.scala:599:32
      s1_req_1_uop_lrs1 <= io_lsu_req_bits_1_bits_uop_lrs1;	// dcache.scala:599:32
      s1_req_1_uop_lrs2 <= io_lsu_req_bits_1_bits_uop_lrs2;	// dcache.scala:599:32
      s1_req_1_uop_lrs3 <= io_lsu_req_bits_1_bits_uop_lrs3;	// dcache.scala:599:32
      s1_req_1_uop_dst_rtype <= io_lsu_req_bits_1_bits_uop_dst_rtype;	// dcache.scala:599:32
      s1_req_1_uop_lrs1_rtype <= io_lsu_req_bits_1_bits_uop_lrs1_rtype;	// dcache.scala:599:32
      s1_req_1_uop_lrs2_rtype <= io_lsu_req_bits_1_bits_uop_lrs2_rtype;	// dcache.scala:599:32
      s1_req_1_uop_debug_fsrc <= io_lsu_req_bits_1_bits_uop_debug_fsrc;	// dcache.scala:599:32
      s1_req_1_uop_debug_tsrc <= io_lsu_req_bits_1_bits_uop_debug_tsrc;	// dcache.scala:599:32
      s1_req_1_addr <= io_lsu_req_bits_1_bits_addr;	// dcache.scala:599:32
      s1_req_1_data <= io_lsu_req_bits_1_bits_data;	// dcache.scala:599:32
      s1_send_resp_or_nack_0 <= io_lsu_req_bits_0_valid;	// dcache.scala:613:37
      s1_type <= 3'h4;	// ReadyValidCancel.scala:70:19, dcache.scala:431:22, :614:32, :813:31
    end
    else begin	// Decoupled.scala:40:37
      if (_GEN_3) begin	// dcache.scala:582:21, :583:21, :584:21, :585:21
        s1_req_0_uop_uopc <= 7'h0;	// dcache.scala:432:21, :567:27, :599:32
        s1_req_0_uop_inst <= 32'h0;	// dcache.scala:432:21, :567:27, :599:32
        s1_req_0_uop_debug_inst <= 32'h0;	// dcache.scala:432:21, :567:27, :599:32
        s1_req_0_uop_debug_pc <= 40'h0;	// dcache.scala:432:21, :567:27, :599:32
        s1_req_0_uop_iq_type <= 3'h0;	// dcache.scala:432:21, :567:27, :599:32
        s1_req_0_uop_fu_code <= 10'h0;	// dcache.scala:432:21, :567:27, :599:32
        s1_req_0_uop_ctrl_br_type <= 4'h0;	// dcache.scala:432:21, :567:27, :599:32
        s1_req_0_uop_ctrl_op1_sel <= 2'h0;	// dcache.scala:432:21, :567:27, :599:32
        s1_req_0_uop_ctrl_op2_sel <= 3'h0;	// dcache.scala:432:21, :567:27, :599:32
        s1_req_0_uop_ctrl_imm_sel <= 3'h0;	// dcache.scala:432:21, :567:27, :599:32
        s1_req_0_uop_ctrl_op_fcn <= 4'h0;	// dcache.scala:432:21, :567:27, :599:32
        s1_req_0_uop_ctrl_csr_cmd <= 3'h0;	// dcache.scala:432:21, :567:27, :599:32
        s1_req_0_uop_iw_state <= 2'h0;	// dcache.scala:432:21, :567:27, :599:32
        s1_req_0_uop_br_tag <= 5'h0;	// dcache.scala:432:21, :567:27, :599:32
        s1_req_0_uop_ftq_idx <= 6'h0;	// dcache.scala:432:21, :444:27, :567:27, :599:32
        s1_req_0_uop_pc_lob <= 6'h0;	// dcache.scala:432:21, :444:27, :567:27, :599:32
        s1_req_0_uop_imm_packed <= 20'h0;	// dcache.scala:431:22, :432:21, :441:41, :442:28, :444:27, :567:27, :599:32
        s1_req_0_uop_csr_addr <= 12'h0;	// dcache.scala:432:21, :462:27, :567:27, :599:32
        s1_req_0_uop_rob_idx <= 7'h0;	// dcache.scala:432:21, :567:27, :599:32
        s1_req_0_uop_ldq_idx <= 5'h0;	// dcache.scala:432:21, :567:27, :599:32
        s1_req_0_uop_stq_idx <= 5'h0;	// dcache.scala:432:21, :567:27, :599:32
        s1_req_0_uop_rxq_idx <= 2'h0;	// dcache.scala:432:21, :567:27, :599:32
        s1_req_0_uop_pdst <= 7'h0;	// dcache.scala:432:21, :567:27, :599:32
        s1_req_0_uop_prs1 <= 7'h0;	// dcache.scala:432:21, :567:27, :599:32
        s1_req_0_uop_prs2 <= 7'h0;	// dcache.scala:432:21, :567:27, :599:32
        s1_req_0_uop_prs3 <= 7'h0;	// dcache.scala:432:21, :567:27, :599:32
        s1_req_0_uop_ppred <= 6'h0;	// dcache.scala:432:21, :444:27, :567:27, :599:32
        s1_req_0_uop_stale_pdst <= 7'h0;	// dcache.scala:432:21, :567:27, :599:32
        s1_req_0_uop_exc_cause <= 64'h0;	// Mux.scala:27:72, dcache.scala:431:22, :432:21, :567:27, :599:32, :813:31
        s1_req_0_uop_mem_size <= 2'h0;	// dcache.scala:432:21, :567:27, :599:32
        s1_req_0_uop_ldst <= 6'h0;	// dcache.scala:432:21, :444:27, :567:27, :599:32
        s1_req_0_uop_lrs1 <= 6'h0;	// dcache.scala:432:21, :444:27, :567:27, :599:32
        s1_req_0_uop_lrs2 <= 6'h0;	// dcache.scala:432:21, :444:27, :567:27, :599:32
        s1_req_0_uop_lrs3 <= 6'h0;	// dcache.scala:432:21, :444:27, :567:27, :599:32
        s1_req_0_uop_dst_rtype <= 2'h2;	// dcache.scala:432:21, :567:27, :599:32
        s1_req_0_uop_lrs1_rtype <= 2'h0;	// dcache.scala:432:21, :567:27, :599:32
        s1_req_0_uop_lrs2_rtype <= 2'h0;	// dcache.scala:432:21, :567:27, :599:32
        s1_req_0_uop_debug_fsrc <= 2'h0;	// dcache.scala:432:21, :567:27, :599:32
        s1_req_0_uop_debug_tsrc <= 2'h0;	// dcache.scala:432:21, :567:27, :599:32
        s1_req_0_data <= 64'h0;	// Mux.scala:27:72, dcache.scala:431:22, :432:21, :567:27, :599:32, :813:31
      end
      else begin	// dcache.scala:582:21, :583:21, :584:21, :585:21
        s1_req_0_uop_uopc <= _mshrs_io_replay_bits_uop_uopc;	// dcache.scala:432:21, :599:32
        s1_req_0_uop_inst <= _mshrs_io_replay_bits_uop_inst;	// dcache.scala:432:21, :599:32
        s1_req_0_uop_debug_inst <= _mshrs_io_replay_bits_uop_debug_inst;	// dcache.scala:432:21, :599:32
        s1_req_0_uop_debug_pc <= _mshrs_io_replay_bits_uop_debug_pc;	// dcache.scala:432:21, :599:32
        s1_req_0_uop_iq_type <= _mshrs_io_replay_bits_uop_iq_type;	// dcache.scala:432:21, :599:32
        s1_req_0_uop_fu_code <= _mshrs_io_replay_bits_uop_fu_code;	// dcache.scala:432:21, :599:32
        s1_req_0_uop_ctrl_br_type <= _mshrs_io_replay_bits_uop_ctrl_br_type;	// dcache.scala:432:21, :599:32
        s1_req_0_uop_ctrl_op1_sel <= _mshrs_io_replay_bits_uop_ctrl_op1_sel;	// dcache.scala:432:21, :599:32
        s1_req_0_uop_ctrl_op2_sel <= _mshrs_io_replay_bits_uop_ctrl_op2_sel;	// dcache.scala:432:21, :599:32
        s1_req_0_uop_ctrl_imm_sel <= _mshrs_io_replay_bits_uop_ctrl_imm_sel;	// dcache.scala:432:21, :599:32
        s1_req_0_uop_ctrl_op_fcn <= _mshrs_io_replay_bits_uop_ctrl_op_fcn;	// dcache.scala:432:21, :599:32
        s1_req_0_uop_ctrl_csr_cmd <= _mshrs_io_replay_bits_uop_ctrl_csr_cmd;	// dcache.scala:432:21, :599:32
        s1_req_0_uop_iw_state <= _mshrs_io_replay_bits_uop_iw_state;	// dcache.scala:432:21, :599:32
        s1_req_0_uop_br_tag <= _mshrs_io_replay_bits_uop_br_tag;	// dcache.scala:432:21, :599:32
        s1_req_0_uop_ftq_idx <= _mshrs_io_replay_bits_uop_ftq_idx;	// dcache.scala:432:21, :599:32
        s1_req_0_uop_pc_lob <= _mshrs_io_replay_bits_uop_pc_lob;	// dcache.scala:432:21, :599:32
        s1_req_0_uop_imm_packed <= _mshrs_io_replay_bits_uop_imm_packed;	// dcache.scala:432:21, :599:32
        s1_req_0_uop_csr_addr <= _mshrs_io_replay_bits_uop_csr_addr;	// dcache.scala:432:21, :599:32
        s1_req_0_uop_rob_idx <= _mshrs_io_replay_bits_uop_rob_idx;	// dcache.scala:432:21, :599:32
        s1_req_0_uop_ldq_idx <= _mshrs_io_replay_bits_uop_ldq_idx;	// dcache.scala:432:21, :599:32
        s1_req_0_uop_stq_idx <= _mshrs_io_replay_bits_uop_stq_idx;	// dcache.scala:432:21, :599:32
        s1_req_0_uop_rxq_idx <= _mshrs_io_replay_bits_uop_rxq_idx;	// dcache.scala:432:21, :599:32
        s1_req_0_uop_pdst <= _mshrs_io_replay_bits_uop_pdst;	// dcache.scala:432:21, :599:32
        s1_req_0_uop_prs1 <= _mshrs_io_replay_bits_uop_prs1;	// dcache.scala:432:21, :599:32
        s1_req_0_uop_prs2 <= _mshrs_io_replay_bits_uop_prs2;	// dcache.scala:432:21, :599:32
        s1_req_0_uop_prs3 <= _mshrs_io_replay_bits_uop_prs3;	// dcache.scala:432:21, :599:32
        s1_req_0_uop_ppred <= _mshrs_io_replay_bits_uop_ppred;	// dcache.scala:432:21, :599:32
        s1_req_0_uop_stale_pdst <= _mshrs_io_replay_bits_uop_stale_pdst;	// dcache.scala:432:21, :599:32
        s1_req_0_uop_exc_cause <= _mshrs_io_replay_bits_uop_exc_cause;	// dcache.scala:432:21, :599:32
        s1_req_0_uop_mem_size <= _mshrs_io_replay_bits_uop_mem_size;	// dcache.scala:432:21, :599:32
        s1_req_0_uop_ldst <= _mshrs_io_replay_bits_uop_ldst;	// dcache.scala:432:21, :599:32
        s1_req_0_uop_lrs1 <= _mshrs_io_replay_bits_uop_lrs1;	// dcache.scala:432:21, :599:32
        s1_req_0_uop_lrs2 <= _mshrs_io_replay_bits_uop_lrs2;	// dcache.scala:432:21, :599:32
        s1_req_0_uop_lrs3 <= _mshrs_io_replay_bits_uop_lrs3;	// dcache.scala:432:21, :599:32
        s1_req_0_uop_dst_rtype <= _mshrs_io_replay_bits_uop_dst_rtype;	// dcache.scala:432:21, :599:32
        s1_req_0_uop_lrs1_rtype <= _mshrs_io_replay_bits_uop_lrs1_rtype;	// dcache.scala:432:21, :599:32
        s1_req_0_uop_lrs2_rtype <= _mshrs_io_replay_bits_uop_lrs2_rtype;	// dcache.scala:432:21, :599:32
        s1_req_0_uop_debug_fsrc <= _mshrs_io_replay_bits_uop_debug_fsrc;	// dcache.scala:432:21, :599:32
        s1_req_0_uop_debug_tsrc <= _mshrs_io_replay_bits_uop_debug_tsrc;	// dcache.scala:432:21, :599:32
        s1_req_0_data <= _mshrs_io_replay_bits_data;	// dcache.scala:432:21, :599:32
      end
      s1_req_0_uop_is_rvc <= ~_GEN_3 & _mshrs_io_replay_bits_uop_is_rvc;	// dcache.scala:432:21, :582:21, :583:21, :584:21, :585:21, :599:32
      s1_req_0_uop_ctrl_fcn_dw <= ~_GEN_3 & _mshrs_io_replay_bits_uop_ctrl_fcn_dw;	// dcache.scala:432:21, :582:21, :583:21, :584:21, :585:21, :599:32
      s1_req_0_uop_ctrl_is_load <= ~_GEN_3 & _mshrs_io_replay_bits_uop_ctrl_is_load;	// dcache.scala:432:21, :582:21, :583:21, :584:21, :585:21, :599:32
      s1_req_0_uop_ctrl_is_sta <= ~_GEN_3 & _mshrs_io_replay_bits_uop_ctrl_is_sta;	// dcache.scala:432:21, :582:21, :583:21, :584:21, :585:21, :599:32
      s1_req_0_uop_ctrl_is_std <= ~_GEN_3 & _mshrs_io_replay_bits_uop_ctrl_is_std;	// dcache.scala:432:21, :582:21, :583:21, :584:21, :585:21, :599:32
      s1_req_0_uop_iw_p1_poisoned <= ~_GEN_3 & _mshrs_io_replay_bits_uop_iw_p1_poisoned;	// dcache.scala:432:21, :582:21, :583:21, :584:21, :585:21, :599:32
      s1_req_0_uop_iw_p2_poisoned <= ~_GEN_3 & _mshrs_io_replay_bits_uop_iw_p2_poisoned;	// dcache.scala:432:21, :582:21, :583:21, :584:21, :585:21, :599:32
      s1_req_0_uop_is_br <= ~_GEN_3 & _mshrs_io_replay_bits_uop_is_br;	// dcache.scala:432:21, :582:21, :583:21, :584:21, :585:21, :599:32
      s1_req_0_uop_is_jalr <= ~_GEN_3 & _mshrs_io_replay_bits_uop_is_jalr;	// dcache.scala:432:21, :582:21, :583:21, :584:21, :585:21, :599:32
      s1_req_0_uop_is_jal <= ~_GEN_3 & _mshrs_io_replay_bits_uop_is_jal;	// dcache.scala:432:21, :582:21, :583:21, :584:21, :585:21, :599:32
      s1_req_0_uop_is_sfb <= ~_GEN_3 & _mshrs_io_replay_bits_uop_is_sfb;	// dcache.scala:432:21, :582:21, :583:21, :584:21, :585:21, :599:32
      s1_req_0_uop_edge_inst <= ~_GEN_3 & _mshrs_io_replay_bits_uop_edge_inst;	// dcache.scala:432:21, :582:21, :583:21, :584:21, :585:21, :599:32
      s1_req_0_uop_taken <= ~_GEN_3 & _mshrs_io_replay_bits_uop_taken;	// dcache.scala:432:21, :582:21, :583:21, :584:21, :585:21, :599:32
      s1_req_0_uop_prs1_busy <= ~_GEN_3 & _mshrs_io_replay_bits_uop_prs1_busy;	// dcache.scala:432:21, :582:21, :583:21, :584:21, :585:21, :599:32
      s1_req_0_uop_prs2_busy <= ~_GEN_3 & _mshrs_io_replay_bits_uop_prs2_busy;	// dcache.scala:432:21, :582:21, :583:21, :584:21, :585:21, :599:32
      s1_req_0_uop_prs3_busy <= ~_GEN_3 & _mshrs_io_replay_bits_uop_prs3_busy;	// dcache.scala:432:21, :582:21, :583:21, :584:21, :585:21, :599:32
      s1_req_0_uop_ppred_busy <= ~_GEN_3 & _mshrs_io_replay_bits_uop_ppred_busy;	// dcache.scala:432:21, :582:21, :583:21, :584:21, :585:21, :599:32
      s1_req_0_uop_exception <= ~_GEN_3 & _mshrs_io_replay_bits_uop_exception;	// dcache.scala:432:21, :582:21, :583:21, :584:21, :585:21, :599:32
      s1_req_0_uop_bypassable <= ~_GEN_3 & _mshrs_io_replay_bits_uop_bypassable;	// dcache.scala:432:21, :582:21, :583:21, :584:21, :585:21, :599:32
      if (_GEN_2)	// dcache.scala:582:21, :583:21
        s1_req_0_uop_mem_cmd <= 5'h0;	// dcache.scala:432:21, :567:27, :599:32
      else if (prefetch_fire)	// Decoupled.scala:40:37
        s1_req_0_uop_mem_cmd <= _mshrs_io_prefetch_bits_uop_mem_cmd;	// dcache.scala:432:21, :599:32
      else if (_s0_type_T_1)	// Decoupled.scala:40:37
        s1_req_0_uop_mem_cmd <= 5'h0;	// dcache.scala:432:21, :567:27, :599:32
      else	// Decoupled.scala:40:37
        s1_req_0_uop_mem_cmd <= _mshrs_io_replay_bits_uop_mem_cmd;	// dcache.scala:432:21, :599:32
      s1_req_0_uop_mem_signed <= ~_GEN_3 & _mshrs_io_replay_bits_uop_mem_signed;	// dcache.scala:432:21, :582:21, :583:21, :584:21, :585:21, :599:32
      s1_req_0_uop_is_fence <= ~_GEN_3 & _mshrs_io_replay_bits_uop_is_fence;	// dcache.scala:432:21, :582:21, :583:21, :584:21, :585:21, :599:32
      s1_req_0_uop_is_fencei <= ~_GEN_3 & _mshrs_io_replay_bits_uop_is_fencei;	// dcache.scala:432:21, :582:21, :583:21, :584:21, :585:21, :599:32
      s1_req_0_uop_is_amo <= ~_GEN_3 & _mshrs_io_replay_bits_uop_is_amo;	// dcache.scala:432:21, :582:21, :583:21, :584:21, :585:21, :599:32
      s1_req_0_uop_uses_ldq <= _s0_req_T_5_0_uop_uses_ldq;	// dcache.scala:582:21, :583:21, :584:21, :585:21, :599:32
      s1_req_0_uop_uses_stq <= _s0_req_T_5_0_uop_uses_stq;	// dcache.scala:582:21, :583:21, :584:21, :585:21, :599:32
      s1_req_0_uop_is_sys_pc2epc <= ~_GEN_3 & _mshrs_io_replay_bits_uop_is_sys_pc2epc;	// dcache.scala:432:21, :582:21, :583:21, :584:21, :585:21, :599:32
      s1_req_0_uop_is_unique <= ~_GEN_3 & _mshrs_io_replay_bits_uop_is_unique;	// dcache.scala:432:21, :582:21, :583:21, :584:21, :585:21, :599:32
      s1_req_0_uop_flush_on_commit <= ~_GEN_3 & _mshrs_io_replay_bits_uop_flush_on_commit;	// dcache.scala:432:21, :582:21, :583:21, :584:21, :585:21, :599:32
      s1_req_0_uop_ldst_is_rs1 <= ~_GEN_3 & _mshrs_io_replay_bits_uop_ldst_is_rs1;	// dcache.scala:432:21, :582:21, :583:21, :584:21, :585:21, :599:32
      s1_req_0_uop_ldst_val <= ~_GEN_3 & _mshrs_io_replay_bits_uop_ldst_val;	// dcache.scala:432:21, :582:21, :583:21, :584:21, :585:21, :599:32
      s1_req_0_uop_frs3_en <= ~_GEN_3 & _mshrs_io_replay_bits_uop_frs3_en;	// dcache.scala:432:21, :582:21, :583:21, :584:21, :585:21, :599:32
      s1_req_0_uop_fp_val <= ~_GEN_3 & _mshrs_io_replay_bits_uop_fp_val;	// dcache.scala:432:21, :582:21, :583:21, :584:21, :585:21, :599:32
      s1_req_0_uop_fp_single <= ~_GEN_3 & _mshrs_io_replay_bits_uop_fp_single;	// dcache.scala:432:21, :582:21, :583:21, :584:21, :585:21, :599:32
      s1_req_0_uop_xcpt_pf_if <= ~_GEN_3 & _mshrs_io_replay_bits_uop_xcpt_pf_if;	// dcache.scala:432:21, :582:21, :583:21, :584:21, :585:21, :599:32
      s1_req_0_uop_xcpt_ae_if <= ~_GEN_3 & _mshrs_io_replay_bits_uop_xcpt_ae_if;	// dcache.scala:432:21, :582:21, :583:21, :584:21, :585:21, :599:32
      s1_req_0_uop_xcpt_ma_if <= ~_GEN_3 & _mshrs_io_replay_bits_uop_xcpt_ma_if;	// dcache.scala:432:21, :582:21, :583:21, :584:21, :585:21, :599:32
      s1_req_0_uop_bp_debug_if <= ~_GEN_3 & _mshrs_io_replay_bits_uop_bp_debug_if;	// dcache.scala:432:21, :582:21, :583:21, :584:21, :585:21, :599:32
      s1_req_0_uop_bp_xcpt_if <= ~_GEN_3 & _mshrs_io_replay_bits_uop_bp_xcpt_if;	// dcache.scala:432:21, :582:21, :583:21, :584:21, :585:21, :599:32
      if (wb_fire) begin	// dcache.scala:530:40
        s1_req_0_addr <= {8'h0, _wb_io_meta_read_bits_tag, _wb_io_data_req_bits_addr};	// dcache.scala:430:18, :534:22, :599:32
        s1_type <= 3'h2;	// dcache.scala:588:21, :614:32
      end
      else if (prober_fire) begin	// Decoupled.scala:40:37
        s1_req_0_addr <=
          {8'h0, _prober_io_meta_read_bits_tag, _prober_io_meta_read_bits_idx, 6'h0};	// dcache.scala:431:22, :432:21, :444:27, :555:26, :567:27, :599:32
        s1_type <= 3'h1;	// dcache.scala:589:21, :614:32
      end
      else if (prefetch_fire) begin	// Decoupled.scala:40:37
        s1_req_0_addr <= _mshrs_io_prefetch_bits_addr;	// dcache.scala:432:21, :599:32
        s1_type <= 3'h5;	// dcache.scala:590:21, :614:32
      end
      else if (_s0_type_T_1) begin	// Decoupled.scala:40:37
        s1_req_0_addr <=
          {8'h0, _mshrs_io_meta_read_bits_tag, _mshrs_io_meta_read_bits_idx, 6'h0};	// dcache.scala:432:21, :444:27, :519:29, :567:27, :599:32
        s1_type <= 3'h3;	// dcache.scala:591:21, :614:32
      end
      else begin	// Decoupled.scala:40:37
        s1_req_0_addr <= _mshrs_io_replay_bits_addr;	// dcache.scala:432:21, :599:32
        s1_type <= 3'h0;	// dcache.scala:432:21, :567:27, :614:32
      end
      s1_req_1_uop_uopc <= 7'h0;	// dcache.scala:432:21, :567:27, :599:32
      s1_req_1_uop_inst <= 32'h0;	// dcache.scala:432:21, :567:27, :599:32
      s1_req_1_uop_debug_inst <= 32'h0;	// dcache.scala:432:21, :567:27, :599:32
      s1_req_1_uop_debug_pc <= 40'h0;	// dcache.scala:432:21, :567:27, :599:32
      s1_req_1_uop_iq_type <= 3'h0;	// dcache.scala:432:21, :567:27, :599:32
      s1_req_1_uop_fu_code <= 10'h0;	// dcache.scala:432:21, :567:27, :599:32
      s1_req_1_uop_ctrl_br_type <= 4'h0;	// dcache.scala:432:21, :567:27, :599:32
      s1_req_1_uop_ctrl_op1_sel <= 2'h0;	// dcache.scala:432:21, :567:27, :599:32
      s1_req_1_uop_ctrl_op2_sel <= 3'h0;	// dcache.scala:432:21, :567:27, :599:32
      s1_req_1_uop_ctrl_imm_sel <= 3'h0;	// dcache.scala:432:21, :567:27, :599:32
      s1_req_1_uop_ctrl_op_fcn <= 4'h0;	// dcache.scala:432:21, :567:27, :599:32
      s1_req_1_uop_ctrl_csr_cmd <= 3'h0;	// dcache.scala:432:21, :567:27, :599:32
      s1_req_1_uop_iw_state <= 2'h0;	// dcache.scala:432:21, :567:27, :599:32
      s1_req_1_uop_br_tag <= 5'h0;	// dcache.scala:432:21, :567:27, :599:32
      s1_req_1_uop_ftq_idx <= 6'h0;	// dcache.scala:432:21, :444:27, :567:27, :599:32
      s1_req_1_uop_pc_lob <= 6'h0;	// dcache.scala:432:21, :444:27, :567:27, :599:32
      s1_req_1_uop_imm_packed <= 20'h0;	// dcache.scala:431:22, :432:21, :441:41, :442:28, :444:27, :567:27, :599:32
      s1_req_1_uop_csr_addr <= 12'h0;	// dcache.scala:432:21, :462:27, :567:27, :599:32
      s1_req_1_uop_rob_idx <= 7'h0;	// dcache.scala:432:21, :567:27, :599:32
      s1_req_1_uop_ldq_idx <= 5'h0;	// dcache.scala:432:21, :567:27, :599:32
      s1_req_1_uop_stq_idx <= 5'h0;	// dcache.scala:432:21, :567:27, :599:32
      s1_req_1_uop_rxq_idx <= 2'h0;	// dcache.scala:432:21, :567:27, :599:32
      s1_req_1_uop_pdst <= 7'h0;	// dcache.scala:432:21, :567:27, :599:32
      s1_req_1_uop_prs1 <= 7'h0;	// dcache.scala:432:21, :567:27, :599:32
      s1_req_1_uop_prs2 <= 7'h0;	// dcache.scala:432:21, :567:27, :599:32
      s1_req_1_uop_prs3 <= 7'h0;	// dcache.scala:432:21, :567:27, :599:32
      s1_req_1_uop_ppred <= 6'h0;	// dcache.scala:432:21, :444:27, :567:27, :599:32
      s1_req_1_uop_stale_pdst <= 7'h0;	// dcache.scala:432:21, :567:27, :599:32
      s1_req_1_uop_exc_cause <= 64'h0;	// Mux.scala:27:72, dcache.scala:431:22, :432:21, :567:27, :599:32, :813:31
      s1_req_1_uop_mem_cmd <= 5'h0;	// dcache.scala:432:21, :567:27, :599:32
      s1_req_1_uop_mem_size <= 2'h0;	// dcache.scala:432:21, :567:27, :599:32
      s1_req_1_uop_ldst <= 6'h0;	// dcache.scala:432:21, :444:27, :567:27, :599:32
      s1_req_1_uop_lrs1 <= 6'h0;	// dcache.scala:432:21, :444:27, :567:27, :599:32
      s1_req_1_uop_lrs2 <= 6'h0;	// dcache.scala:432:21, :444:27, :567:27, :599:32
      s1_req_1_uop_lrs3 <= 6'h0;	// dcache.scala:432:21, :444:27, :567:27, :599:32
      s1_req_1_uop_dst_rtype <= 2'h0;	// dcache.scala:432:21, :567:27, :599:32
      s1_req_1_uop_lrs1_rtype <= 2'h0;	// dcache.scala:432:21, :567:27, :599:32
      s1_req_1_uop_lrs2_rtype <= 2'h0;	// dcache.scala:432:21, :567:27, :599:32
      s1_req_1_uop_debug_fsrc <= 2'h0;	// dcache.scala:432:21, :567:27, :599:32
      s1_req_1_uop_debug_tsrc <= 2'h0;	// dcache.scala:432:21, :567:27, :599:32
      s1_req_1_addr <= 40'h0;	// dcache.scala:432:21, :567:27, :599:32
      s1_req_1_data <= 64'h0;	// Mux.scala:27:72, dcache.scala:431:22, :432:21, :567:27, :599:32, :813:31
      s1_send_resp_or_nack_0 <=
        _s0_send_resp_or_nack_T_1
        & (_mshrs_io_replay_bits_uop_mem_cmd == 5'h0
           | _mshrs_io_replay_bits_uop_mem_cmd == 5'h6
           | _mshrs_io_replay_bits_uop_mem_cmd == 5'h7
           | _mshrs_io_replay_bits_uop_mem_cmd == 5'h4
           | _mshrs_io_replay_bits_uop_mem_cmd == 5'h9
           | _mshrs_io_replay_bits_uop_mem_cmd == 5'hA
           | _mshrs_io_replay_bits_uop_mem_cmd == 5'hB
           | _mshrs_io_replay_bits_uop_mem_cmd == 5'h8
           | _mshrs_io_replay_bits_uop_mem_cmd == 5'hC
           | _mshrs_io_replay_bits_uop_mem_cmd == 5'hD
           | _mshrs_io_replay_bits_uop_mem_cmd == 5'hE
           | _mshrs_io_replay_bits_uop_mem_cmd == 5'hF);	// Consts.scala:81:{31,48,65,75}, Decoupled.scala:40:37, dcache.scala:432:21, :567:27, :596:40, :613:37, package.scala:15:47
    end
    s1_req_0_uop_br_mask <= s0_req_0_uop_br_mask & ~io_lsu_brupdate_b1_resolve_mask;	// dcache.scala:581:21, :599:32, util.scala:85:{25,27}
    s1_req_0_is_hella <= ~(_s1_valid_T_19 | _GEN_3) & _mshrs_io_replay_bits_is_hella;	// Decoupled.scala:40:37, dcache.scala:432:21, :581:21, :582:21, :583:21, :584:21, :585:21, :599:32
    s1_req_1_uop_is_rvc <= _s1_valid_T_19 & io_lsu_req_bits_1_bits_uop_is_rvc;	// Decoupled.scala:40:37, dcache.scala:581:21, :599:32
    s1_req_1_uop_ctrl_fcn_dw <= _s1_valid_T_19 & io_lsu_req_bits_1_bits_uop_ctrl_fcn_dw;	// Decoupled.scala:40:37, dcache.scala:581:21, :599:32
    s1_req_1_uop_ctrl_is_load <= _s1_valid_T_19 & io_lsu_req_bits_1_bits_uop_ctrl_is_load;	// Decoupled.scala:40:37, dcache.scala:581:21, :599:32
    s1_req_1_uop_ctrl_is_sta <= _s1_valid_T_19 & io_lsu_req_bits_1_bits_uop_ctrl_is_sta;	// Decoupled.scala:40:37, dcache.scala:581:21, :599:32
    s1_req_1_uop_ctrl_is_std <= _s1_valid_T_19 & io_lsu_req_bits_1_bits_uop_ctrl_is_std;	// Decoupled.scala:40:37, dcache.scala:581:21, :599:32
    s1_req_1_uop_iw_p1_poisoned <=
      _s1_valid_T_19 & io_lsu_req_bits_1_bits_uop_iw_p1_poisoned;	// Decoupled.scala:40:37, dcache.scala:581:21, :599:32
    s1_req_1_uop_iw_p2_poisoned <=
      _s1_valid_T_19 & io_lsu_req_bits_1_bits_uop_iw_p2_poisoned;	// Decoupled.scala:40:37, dcache.scala:581:21, :599:32
    s1_req_1_uop_is_br <= _s1_valid_T_19 & io_lsu_req_bits_1_bits_uop_is_br;	// Decoupled.scala:40:37, dcache.scala:581:21, :599:32
    s1_req_1_uop_is_jalr <= _s1_valid_T_19 & io_lsu_req_bits_1_bits_uop_is_jalr;	// Decoupled.scala:40:37, dcache.scala:581:21, :599:32
    s1_req_1_uop_is_jal <= _s1_valid_T_19 & io_lsu_req_bits_1_bits_uop_is_jal;	// Decoupled.scala:40:37, dcache.scala:581:21, :599:32
    s1_req_1_uop_is_sfb <= _s1_valid_T_19 & io_lsu_req_bits_1_bits_uop_is_sfb;	// Decoupled.scala:40:37, dcache.scala:581:21, :599:32
    s1_req_1_uop_br_mask <= s0_req_1_uop_br_mask & ~io_lsu_brupdate_b1_resolve_mask;	// dcache.scala:581:21, :599:32, util.scala:85:{25,27}
    s1_req_1_uop_edge_inst <= _s1_valid_T_19 & io_lsu_req_bits_1_bits_uop_edge_inst;	// Decoupled.scala:40:37, dcache.scala:581:21, :599:32
    s1_req_1_uop_taken <= _s1_valid_T_19 & io_lsu_req_bits_1_bits_uop_taken;	// Decoupled.scala:40:37, dcache.scala:581:21, :599:32
    s1_req_1_uop_prs1_busy <= _s1_valid_T_19 & io_lsu_req_bits_1_bits_uop_prs1_busy;	// Decoupled.scala:40:37, dcache.scala:581:21, :599:32
    s1_req_1_uop_prs2_busy <= _s1_valid_T_19 & io_lsu_req_bits_1_bits_uop_prs2_busy;	// Decoupled.scala:40:37, dcache.scala:581:21, :599:32
    s1_req_1_uop_prs3_busy <= _s1_valid_T_19 & io_lsu_req_bits_1_bits_uop_prs3_busy;	// Decoupled.scala:40:37, dcache.scala:581:21, :599:32
    s1_req_1_uop_ppred_busy <= _s1_valid_T_19 & io_lsu_req_bits_1_bits_uop_ppred_busy;	// Decoupled.scala:40:37, dcache.scala:581:21, :599:32
    s1_req_1_uop_exception <= _s1_valid_T_19 & io_lsu_req_bits_1_bits_uop_exception;	// Decoupled.scala:40:37, dcache.scala:581:21, :599:32
    s1_req_1_uop_bypassable <= _s1_valid_T_19 & io_lsu_req_bits_1_bits_uop_bypassable;	// Decoupled.scala:40:37, dcache.scala:581:21, :599:32
    s1_req_1_uop_mem_signed <= _s1_valid_T_19 & io_lsu_req_bits_1_bits_uop_mem_signed;	// Decoupled.scala:40:37, dcache.scala:581:21, :599:32
    s1_req_1_uop_is_fence <= _s1_valid_T_19 & io_lsu_req_bits_1_bits_uop_is_fence;	// Decoupled.scala:40:37, dcache.scala:581:21, :599:32
    s1_req_1_uop_is_fencei <= _s1_valid_T_19 & io_lsu_req_bits_1_bits_uop_is_fencei;	// Decoupled.scala:40:37, dcache.scala:581:21, :599:32
    s1_req_1_uop_is_amo <= _s1_valid_T_19 & io_lsu_req_bits_1_bits_uop_is_amo;	// Decoupled.scala:40:37, dcache.scala:581:21, :599:32
    s1_req_1_uop_uses_ldq <= s0_req_1_uop_uses_ldq;	// dcache.scala:581:21, :599:32
    s1_req_1_uop_uses_stq <= s0_req_1_uop_uses_stq;	// dcache.scala:581:21, :599:32
    s1_req_1_uop_is_sys_pc2epc <=
      _s1_valid_T_19 & io_lsu_req_bits_1_bits_uop_is_sys_pc2epc;	// Decoupled.scala:40:37, dcache.scala:581:21, :599:32
    s1_req_1_uop_is_unique <= _s1_valid_T_19 & io_lsu_req_bits_1_bits_uop_is_unique;	// Decoupled.scala:40:37, dcache.scala:581:21, :599:32
    s1_req_1_uop_flush_on_commit <=
      _s1_valid_T_19 & io_lsu_req_bits_1_bits_uop_flush_on_commit;	// Decoupled.scala:40:37, dcache.scala:581:21, :599:32
    s1_req_1_uop_ldst_is_rs1 <= _s1_valid_T_19 & io_lsu_req_bits_1_bits_uop_ldst_is_rs1;	// Decoupled.scala:40:37, dcache.scala:581:21, :599:32
    s1_req_1_uop_ldst_val <= _s1_valid_T_19 & io_lsu_req_bits_1_bits_uop_ldst_val;	// Decoupled.scala:40:37, dcache.scala:581:21, :599:32
    s1_req_1_uop_frs3_en <= _s1_valid_T_19 & io_lsu_req_bits_1_bits_uop_frs3_en;	// Decoupled.scala:40:37, dcache.scala:581:21, :599:32
    s1_req_1_uop_fp_val <= _s1_valid_T_19 & io_lsu_req_bits_1_bits_uop_fp_val;	// Decoupled.scala:40:37, dcache.scala:581:21, :599:32
    s1_req_1_uop_fp_single <= _s1_valid_T_19 & io_lsu_req_bits_1_bits_uop_fp_single;	// Decoupled.scala:40:37, dcache.scala:581:21, :599:32
    s1_req_1_uop_xcpt_pf_if <= _s1_valid_T_19 & io_lsu_req_bits_1_bits_uop_xcpt_pf_if;	// Decoupled.scala:40:37, dcache.scala:581:21, :599:32
    s1_req_1_uop_xcpt_ae_if <= _s1_valid_T_19 & io_lsu_req_bits_1_bits_uop_xcpt_ae_if;	// Decoupled.scala:40:37, dcache.scala:581:21, :599:32
    s1_req_1_uop_xcpt_ma_if <= _s1_valid_T_19 & io_lsu_req_bits_1_bits_uop_xcpt_ma_if;	// Decoupled.scala:40:37, dcache.scala:581:21, :599:32
    s1_req_1_uop_bp_debug_if <= _s1_valid_T_19 & io_lsu_req_bits_1_bits_uop_bp_debug_if;	// Decoupled.scala:40:37, dcache.scala:581:21, :599:32
    s1_req_1_uop_bp_xcpt_if <= _s1_valid_T_19 & io_lsu_req_bits_1_bits_uop_bp_xcpt_if;	// Decoupled.scala:40:37, dcache.scala:581:21, :599:32
    s1_req_1_is_hella <= _s1_valid_T_19 & io_lsu_req_bits_1_bits_is_hella;	// Decoupled.scala:40:37, dcache.scala:581:21, :599:32
    REG <= _s1_valid_T_19;	// Decoupled.scala:40:37, dcache.scala:610:43
    REG_1 <= io_lsu_req_bits_0_valid;	// dcache.scala:610:74
    REG_2 <= _s1_valid_T_19;	// Decoupled.scala:40:37, dcache.scala:610:43
    REG_3 <= io_lsu_req_bits_1_valid;	// dcache.scala:610:74
    s1_send_resp_or_nack_1 <= _s1_valid_T_19 & io_lsu_req_bits_1_valid;	// Decoupled.scala:40:37, dcache.scala:578:21, :595:33, :613:37
    s1_mshr_meta_read_way_en <= _mshrs_io_meta_read_bits_way_en;	// dcache.scala:432:21, :616:41
    s1_replay_way_en <= _mshrs_io_replay_bits_way_en;	// dcache.scala:432:21, :617:41
    s1_wb_way_en <= _wb_io_data_req_bits_way_en;	// dcache.scala:430:18, :618:41
    s2_req_0_uop_uopc <= s1_req_0_uop_uopc;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_inst <= s1_req_0_uop_inst;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_debug_inst <= s1_req_0_uop_debug_inst;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_is_rvc <= s1_req_0_uop_is_rvc;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_debug_pc <= s1_req_0_uop_debug_pc;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_iq_type <= s1_req_0_uop_iq_type;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_fu_code <= s1_req_0_uop_fu_code;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_ctrl_br_type <= s1_req_0_uop_ctrl_br_type;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_ctrl_op1_sel <= s1_req_0_uop_ctrl_op1_sel;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_ctrl_op2_sel <= s1_req_0_uop_ctrl_op2_sel;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_ctrl_imm_sel <= s1_req_0_uop_ctrl_imm_sel;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_ctrl_op_fcn <= s1_req_0_uop_ctrl_op_fcn;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_ctrl_fcn_dw <= s1_req_0_uop_ctrl_fcn_dw;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_ctrl_csr_cmd <= s1_req_0_uop_ctrl_csr_cmd;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_ctrl_is_load <= s1_req_0_uop_ctrl_is_load;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_ctrl_is_sta <= s1_req_0_uop_ctrl_is_sta;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_ctrl_is_std <= s1_req_0_uop_ctrl_is_std;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_iw_state <= s1_req_0_uop_iw_state;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_iw_p1_poisoned <= s1_req_0_uop_iw_p1_poisoned;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_iw_p2_poisoned <= s1_req_0_uop_iw_p2_poisoned;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_is_br <= s1_req_0_uop_is_br;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_is_jalr <= s1_req_0_uop_is_jalr;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_is_jal <= s1_req_0_uop_is_jal;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_is_sfb <= s1_req_0_uop_is_sfb;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_br_mask <= s1_req_0_uop_br_mask & ~io_lsu_brupdate_b1_resolve_mask;	// dcache.scala:599:32, :631:25, util.scala:85:{25,27}
    s2_req_0_uop_br_tag <= s1_req_0_uop_br_tag;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_ftq_idx <= s1_req_0_uop_ftq_idx;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_edge_inst <= s1_req_0_uop_edge_inst;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_pc_lob <= s1_req_0_uop_pc_lob;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_taken <= s1_req_0_uop_taken;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_imm_packed <= s1_req_0_uop_imm_packed;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_csr_addr <= s1_req_0_uop_csr_addr;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_rob_idx <= s1_req_0_uop_rob_idx;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_ldq_idx <= s1_req_0_uop_ldq_idx;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_stq_idx <= s1_req_0_uop_stq_idx;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_rxq_idx <= s1_req_0_uop_rxq_idx;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_pdst <= s1_req_0_uop_pdst;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_prs1 <= s1_req_0_uop_prs1;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_prs2 <= s1_req_0_uop_prs2;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_prs3 <= s1_req_0_uop_prs3;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_ppred <= s1_req_0_uop_ppred;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_prs1_busy <= s1_req_0_uop_prs1_busy;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_prs2_busy <= s1_req_0_uop_prs2_busy;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_prs3_busy <= s1_req_0_uop_prs3_busy;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_ppred_busy <= s1_req_0_uop_ppred_busy;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_stale_pdst <= s1_req_0_uop_stale_pdst;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_exception <= s1_req_0_uop_exception;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_exc_cause <= s1_req_0_uop_exc_cause;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_bypassable <= s1_req_0_uop_bypassable;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_mem_cmd <= s1_req_0_uop_mem_cmd;	// dcache.scala:599:32, :631:25
    size <= s1_req_0_uop_mem_size;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_mem_signed <= s1_req_0_uop_mem_signed;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_is_fence <= s1_req_0_uop_is_fence;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_is_fencei <= s1_req_0_uop_is_fencei;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_is_amo <= s1_req_0_uop_is_amo;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_uses_ldq <= s1_req_0_uop_uses_ldq;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_uses_stq <= s1_req_0_uop_uses_stq;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_is_sys_pc2epc <= s1_req_0_uop_is_sys_pc2epc;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_is_unique <= s1_req_0_uop_is_unique;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_flush_on_commit <= s1_req_0_uop_flush_on_commit;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_ldst_is_rs1 <= s1_req_0_uop_ldst_is_rs1;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_ldst <= s1_req_0_uop_ldst;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_lrs1 <= s1_req_0_uop_lrs1;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_lrs2 <= s1_req_0_uop_lrs2;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_lrs3 <= s1_req_0_uop_lrs3;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_ldst_val <= s1_req_0_uop_ldst_val;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_dst_rtype <= s1_req_0_uop_dst_rtype;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_lrs1_rtype <= s1_req_0_uop_lrs1_rtype;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_lrs2_rtype <= s1_req_0_uop_lrs2_rtype;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_frs3_en <= s1_req_0_uop_frs3_en;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_fp_val <= s1_req_0_uop_fp_val;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_fp_single <= s1_req_0_uop_fp_single;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_xcpt_pf_if <= s1_req_0_uop_xcpt_pf_if;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_xcpt_ae_if <= s1_req_0_uop_xcpt_ae_if;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_xcpt_ma_if <= s1_req_0_uop_xcpt_ma_if;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_bp_debug_if <= s1_req_0_uop_bp_debug_if;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_bp_xcpt_if <= s1_req_0_uop_bp_xcpt_if;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_debug_fsrc <= s1_req_0_uop_debug_fsrc;	// dcache.scala:599:32, :631:25
    s2_req_0_uop_debug_tsrc <= s1_req_0_uop_debug_tsrc;	// dcache.scala:599:32, :631:25
    s2_req_0_addr <= s1_req_0_addr;	// dcache.scala:599:32, :631:25
    s2_req_0_data <= s1_req_0_data;	// dcache.scala:599:32, :631:25
    s2_req_0_is_hella <= s1_req_0_is_hella;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_uopc <= s1_req_1_uop_uopc;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_inst <= s1_req_1_uop_inst;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_debug_inst <= s1_req_1_uop_debug_inst;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_is_rvc <= s1_req_1_uop_is_rvc;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_debug_pc <= s1_req_1_uop_debug_pc;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_iq_type <= s1_req_1_uop_iq_type;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_fu_code <= s1_req_1_uop_fu_code;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_ctrl_br_type <= s1_req_1_uop_ctrl_br_type;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_ctrl_op1_sel <= s1_req_1_uop_ctrl_op1_sel;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_ctrl_op2_sel <= s1_req_1_uop_ctrl_op2_sel;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_ctrl_imm_sel <= s1_req_1_uop_ctrl_imm_sel;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_ctrl_op_fcn <= s1_req_1_uop_ctrl_op_fcn;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_ctrl_fcn_dw <= s1_req_1_uop_ctrl_fcn_dw;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_ctrl_csr_cmd <= s1_req_1_uop_ctrl_csr_cmd;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_ctrl_is_load <= s1_req_1_uop_ctrl_is_load;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_ctrl_is_sta <= s1_req_1_uop_ctrl_is_sta;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_ctrl_is_std <= s1_req_1_uop_ctrl_is_std;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_iw_state <= s1_req_1_uop_iw_state;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_iw_p1_poisoned <= s1_req_1_uop_iw_p1_poisoned;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_iw_p2_poisoned <= s1_req_1_uop_iw_p2_poisoned;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_is_br <= s1_req_1_uop_is_br;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_is_jalr <= s1_req_1_uop_is_jalr;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_is_jal <= s1_req_1_uop_is_jal;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_is_sfb <= s1_req_1_uop_is_sfb;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_br_mask <= s1_req_1_uop_br_mask & ~io_lsu_brupdate_b1_resolve_mask;	// dcache.scala:599:32, :631:25, util.scala:85:{25,27}
    s2_req_1_uop_br_tag <= s1_req_1_uop_br_tag;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_ftq_idx <= s1_req_1_uop_ftq_idx;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_edge_inst <= s1_req_1_uop_edge_inst;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_pc_lob <= s1_req_1_uop_pc_lob;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_taken <= s1_req_1_uop_taken;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_imm_packed <= s1_req_1_uop_imm_packed;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_csr_addr <= s1_req_1_uop_csr_addr;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_rob_idx <= s1_req_1_uop_rob_idx;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_ldq_idx <= s1_req_1_uop_ldq_idx;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_stq_idx <= s1_req_1_uop_stq_idx;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_rxq_idx <= s1_req_1_uop_rxq_idx;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_pdst <= s1_req_1_uop_pdst;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_prs1 <= s1_req_1_uop_prs1;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_prs2 <= s1_req_1_uop_prs2;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_prs3 <= s1_req_1_uop_prs3;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_ppred <= s1_req_1_uop_ppred;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_prs1_busy <= s1_req_1_uop_prs1_busy;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_prs2_busy <= s1_req_1_uop_prs2_busy;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_prs3_busy <= s1_req_1_uop_prs3_busy;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_ppred_busy <= s1_req_1_uop_ppred_busy;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_stale_pdst <= s1_req_1_uop_stale_pdst;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_exception <= s1_req_1_uop_exception;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_exc_cause <= s1_req_1_uop_exc_cause;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_bypassable <= s1_req_1_uop_bypassable;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_mem_cmd <= s1_req_1_uop_mem_cmd;	// dcache.scala:599:32, :631:25
    size_1 <= s1_req_1_uop_mem_size;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_mem_signed <= s1_req_1_uop_mem_signed;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_is_fence <= s1_req_1_uop_is_fence;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_is_fencei <= s1_req_1_uop_is_fencei;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_is_amo <= s1_req_1_uop_is_amo;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_uses_ldq <= s1_req_1_uop_uses_ldq;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_uses_stq <= s1_req_1_uop_uses_stq;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_is_sys_pc2epc <= s1_req_1_uop_is_sys_pc2epc;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_is_unique <= s1_req_1_uop_is_unique;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_flush_on_commit <= s1_req_1_uop_flush_on_commit;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_ldst_is_rs1 <= s1_req_1_uop_ldst_is_rs1;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_ldst <= s1_req_1_uop_ldst;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_lrs1 <= s1_req_1_uop_lrs1;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_lrs2 <= s1_req_1_uop_lrs2;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_lrs3 <= s1_req_1_uop_lrs3;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_ldst_val <= s1_req_1_uop_ldst_val;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_dst_rtype <= s1_req_1_uop_dst_rtype;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_lrs1_rtype <= s1_req_1_uop_lrs1_rtype;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_lrs2_rtype <= s1_req_1_uop_lrs2_rtype;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_frs3_en <= s1_req_1_uop_frs3_en;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_fp_val <= s1_req_1_uop_fp_val;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_fp_single <= s1_req_1_uop_fp_single;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_xcpt_pf_if <= s1_req_1_uop_xcpt_pf_if;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_xcpt_ae_if <= s1_req_1_uop_xcpt_ae_if;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_xcpt_ma_if <= s1_req_1_uop_xcpt_ma_if;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_bp_debug_if <= s1_req_1_uop_bp_debug_if;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_bp_xcpt_if <= s1_req_1_uop_bp_xcpt_if;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_debug_fsrc <= s1_req_1_uop_debug_fsrc;	// dcache.scala:599:32, :631:25
    s2_req_1_uop_debug_tsrc <= s1_req_1_uop_debug_tsrc;	// dcache.scala:599:32, :631:25
    s2_req_1_addr <= s1_req_1_addr;	// dcache.scala:599:32, :631:25
    s2_req_1_data <= s1_req_1_data;	// dcache.scala:599:32, :631:25
    s2_req_1_is_hella <= s1_req_1_is_hella;	// dcache.scala:599:32, :631:25
    s2_type <= s1_type;	// dcache.scala:614:32, :632:25
    s2_valid_REG <=
      s1_valid_REG & ~io_lsu_s1_kill_0
      & (io_lsu_brupdate_b1_mispredict_mask & s1_req_0_uop_br_mask) == 20'h0
      & ~(io_lsu_exception & s1_req_0_uop_uses_ldq)
      & ~(s2_store_failed & _s2_valid_T_23 & s1_req_0_uop_uses_stq);	// dcache.scala:431:22, :432:21, :441:41, :442:28, :444:27, :567:27, :599:32, :604:25, :634:26, :635:26, :637:{26,45,72}, :638:{26,56,67}, :741:67, util.scala:118:{51,59}
    s2_valid_REG_1 <=
      s1_valid_REG_1 & ~io_lsu_s1_kill_1
      & (io_lsu_brupdate_b1_mispredict_mask & s1_req_1_uop_br_mask) == 20'h0
      & ~(io_lsu_exception & s1_req_1_uop_uses_ldq)
      & ~(s2_store_failed & _s2_valid_T_23 & s1_req_1_uop_uses_stq);	// dcache.scala:431:22, :432:21, :441:41, :442:28, :444:27, :567:27, :599:32, :604:25, :634:26, :635:26, :637:{26,45,72}, :638:{26,56,67}, :741:67, util.scala:118:{51,59}
    if (s1_type == 3'h0) begin	// dcache.scala:432:21, :567:27, :614:32, :624:38
      s2_tag_match_way_0 <= s1_replay_way_en;	// dcache.scala:617:41, :642:33
      s2_tag_match_way_1 <= s1_replay_way_en;	// dcache.scala:617:41, :642:33
    end
    else if (s1_type == 3'h2) begin	// dcache.scala:588:21, :614:32, :625:38
      s2_tag_match_way_0 <= s1_wb_way_en;	// dcache.scala:618:41, :642:33
      s2_tag_match_way_1 <= s1_wb_way_en;	// dcache.scala:618:41, :642:33
    end
    else if (s1_type == 3'h3) begin	// dcache.scala:591:21, :614:32, :626:38
      s2_tag_match_way_0 <= s1_mshr_meta_read_way_en;	// dcache.scala:616:41, :642:33
      s2_tag_match_way_1 <= s1_mshr_meta_read_way_en;	// dcache.scala:616:41, :642:33
    end
    else begin	// dcache.scala:626:38
      s2_tag_match_way_0 <=
        {{8'h0, _meta_0_io_resp_7_tag} == s1_req_0_addr[39:12]
           & (|_meta_0_io_resp_7_coh_state),
         {8'h0, _meta_0_io_resp_6_tag} == s1_req_0_addr[39:12]
           & (|_meta_0_io_resp_6_coh_state),
         {8'h0, _meta_0_io_resp_5_tag} == s1_req_0_addr[39:12]
           & (|_meta_0_io_resp_5_coh_state),
         {8'h0, _meta_0_io_resp_4_tag} == s1_req_0_addr[39:12]
           & (|_meta_0_io_resp_4_coh_state),
         {8'h0, _meta_0_io_resp_3_tag} == s1_req_0_addr[39:12]
           & (|_meta_0_io_resp_3_coh_state),
         {8'h0, _meta_0_io_resp_2_tag} == s1_req_0_addr[39:12]
           & (|_meta_0_io_resp_2_coh_state),
         {8'h0, _meta_0_io_resp_1_tag} == s1_req_0_addr[39:12]
           & (|_meta_0_io_resp_1_coh_state),
         {8'h0, _meta_0_io_resp_0_tag} == s1_req_0_addr[39:12]
           & (|_meta_0_io_resp_0_coh_state)};	// Metadata.scala:49:45, dcache.scala:441:41, :599:32, :622:{79,95}, :627:{67,104}, :642:33
      s2_tag_match_way_1 <=
        {{8'h0, _meta_1_io_resp_7_tag} == s1_req_1_addr[39:12]
           & (|_meta_1_io_resp_7_coh_state),
         {8'h0, _meta_1_io_resp_6_tag} == s1_req_1_addr[39:12]
           & (|_meta_1_io_resp_6_coh_state),
         {8'h0, _meta_1_io_resp_5_tag} == s1_req_1_addr[39:12]
           & (|_meta_1_io_resp_5_coh_state),
         {8'h0, _meta_1_io_resp_4_tag} == s1_req_1_addr[39:12]
           & (|_meta_1_io_resp_4_coh_state),
         {8'h0, _meta_1_io_resp_3_tag} == s1_req_1_addr[39:12]
           & (|_meta_1_io_resp_3_coh_state),
         {8'h0, _meta_1_io_resp_2_tag} == s1_req_1_addr[39:12]
           & (|_meta_1_io_resp_2_coh_state),
         {8'h0, _meta_1_io_resp_1_tag} == s1_req_1_addr[39:12]
           & (|_meta_1_io_resp_1_coh_state),
         {8'h0, _meta_1_io_resp_0_tag} == s1_req_1_addr[39:12]
           & (|_meta_1_io_resp_0_coh_state)};	// Metadata.scala:49:45, dcache.scala:441:41, :599:32, :622:{79,95}, :627:{67,104}, :642:33
    end
    s2_hit_state_REG_state <= _meta_0_io_resp_0_coh_state;	// dcache.scala:441:41, :644:93
    s2_hit_state_REG_1_state <= _meta_0_io_resp_1_coh_state;	// dcache.scala:441:41, :644:93
    s2_hit_state_REG_2_state <= _meta_0_io_resp_2_coh_state;	// dcache.scala:441:41, :644:93
    s2_hit_state_REG_3_state <= _meta_0_io_resp_3_coh_state;	// dcache.scala:441:41, :644:93
    s2_hit_state_REG_4_state <= _meta_0_io_resp_4_coh_state;	// dcache.scala:441:41, :644:93
    s2_hit_state_REG_5_state <= _meta_0_io_resp_5_coh_state;	// dcache.scala:441:41, :644:93
    s2_hit_state_REG_6_state <= _meta_0_io_resp_6_coh_state;	// dcache.scala:441:41, :644:93
    s2_hit_state_REG_7_state <= _meta_0_io_resp_7_coh_state;	// dcache.scala:441:41, :644:93
    s2_hit_state_REG_8_state <= _meta_1_io_resp_0_coh_state;	// dcache.scala:441:41, :644:93
    s2_hit_state_REG_9_state <= _meta_1_io_resp_1_coh_state;	// dcache.scala:441:41, :644:93
    s2_hit_state_REG_10_state <= _meta_1_io_resp_2_coh_state;	// dcache.scala:441:41, :644:93
    s2_hit_state_REG_11_state <= _meta_1_io_resp_3_coh_state;	// dcache.scala:441:41, :644:93
    s2_hit_state_REG_12_state <= _meta_1_io_resp_4_coh_state;	// dcache.scala:441:41, :644:93
    s2_hit_state_REG_13_state <= _meta_1_io_resp_5_coh_state;	// dcache.scala:441:41, :644:93
    s2_hit_state_REG_14_state <= _meta_1_io_resp_6_coh_state;	// dcache.scala:441:41, :644:93
    s2_hit_state_REG_15_state <= _meta_1_io_resp_7_coh_state;	// dcache.scala:441:41, :644:93
    s2_wb_idx_matches_0 <= s1_req_0_addr[11:6] == _wb_io_idx_bits & _wb_io_idx_valid;	// dcache.scala:430:18, :599:32, :612:43, :629:{79,99}, :653:34
    s2_wb_idx_matches_1 <= s1_req_1_addr[11:6] == _wb_io_idx_bits & _wb_io_idx_valid;	// dcache.scala:430:18, :599:32, :612:43, :629:{79,99}, :653:34
    if (_GEN_4 & s2_lr)	// dcache.scala:661:23, :662:47, :667:21, :668:88, :669:18, :671:17
      lrsc_addr <= s2_req_0_addr[39:6];	// dcache.scala:631:25, :661:23, :664:86
    s2_lr_REG <= _s2_nack_hit_WIRE_0;	// dcache.scala:612:93, :662:59
    s2_sc_REG <= _s2_nack_hit_WIRE_0;	// dcache.scala:612:93, :663:59
    s2_replaced_way_en_REG <=
      {_lfsr_prng_io_out_2, _lfsr_prng_io_out_1, _lfsr_prng_io_out_0};	// PRNG.scala:82:22, dcache.scala:717:44, package.scala:154:13
    s2_repl_meta_REG_coh_state <= _meta_0_io_resp_0_coh_state;	// dcache.scala:441:41, :718:88
    s2_repl_meta_REG_tag <= _meta_0_io_resp_0_tag;	// dcache.scala:441:41, :718:88
    s2_repl_meta_REG_1_coh_state <= _meta_0_io_resp_1_coh_state;	// dcache.scala:441:41, :718:88
    s2_repl_meta_REG_1_tag <= _meta_0_io_resp_1_tag;	// dcache.scala:441:41, :718:88
    s2_repl_meta_REG_2_coh_state <= _meta_0_io_resp_2_coh_state;	// dcache.scala:441:41, :718:88
    s2_repl_meta_REG_2_tag <= _meta_0_io_resp_2_tag;	// dcache.scala:441:41, :718:88
    s2_repl_meta_REG_3_coh_state <= _meta_0_io_resp_3_coh_state;	// dcache.scala:441:41, :718:88
    s2_repl_meta_REG_3_tag <= _meta_0_io_resp_3_tag;	// dcache.scala:441:41, :718:88
    s2_repl_meta_REG_4_coh_state <= _meta_0_io_resp_4_coh_state;	// dcache.scala:441:41, :718:88
    s2_repl_meta_REG_4_tag <= _meta_0_io_resp_4_tag;	// dcache.scala:441:41, :718:88
    s2_repl_meta_REG_5_coh_state <= _meta_0_io_resp_5_coh_state;	// dcache.scala:441:41, :718:88
    s2_repl_meta_REG_5_tag <= _meta_0_io_resp_5_tag;	// dcache.scala:441:41, :718:88
    s2_repl_meta_REG_6_coh_state <= _meta_0_io_resp_6_coh_state;	// dcache.scala:441:41, :718:88
    s2_repl_meta_REG_6_tag <= _meta_0_io_resp_6_tag;	// dcache.scala:441:41, :718:88
    s2_repl_meta_REG_7_coh_state <= _meta_0_io_resp_7_coh_state;	// dcache.scala:441:41, :718:88
    s2_repl_meta_REG_7_tag <= _meta_0_io_resp_7_tag;	// dcache.scala:441:41, :718:88
    s2_repl_meta_REG_8_coh_state <= _meta_1_io_resp_0_coh_state;	// dcache.scala:441:41, :718:88
    s2_repl_meta_REG_8_tag <= _meta_1_io_resp_0_tag;	// dcache.scala:441:41, :718:88
    s2_repl_meta_REG_9_coh_state <= _meta_1_io_resp_1_coh_state;	// dcache.scala:441:41, :718:88
    s2_repl_meta_REG_9_tag <= _meta_1_io_resp_1_tag;	// dcache.scala:441:41, :718:88
    s2_repl_meta_REG_10_coh_state <= _meta_1_io_resp_2_coh_state;	// dcache.scala:441:41, :718:88
    s2_repl_meta_REG_10_tag <= _meta_1_io_resp_2_tag;	// dcache.scala:441:41, :718:88
    s2_repl_meta_REG_11_coh_state <= _meta_1_io_resp_3_coh_state;	// dcache.scala:441:41, :718:88
    s2_repl_meta_REG_11_tag <= _meta_1_io_resp_3_tag;	// dcache.scala:441:41, :718:88
    s2_repl_meta_REG_12_coh_state <= _meta_1_io_resp_4_coh_state;	// dcache.scala:441:41, :718:88
    s2_repl_meta_REG_12_tag <= _meta_1_io_resp_4_tag;	// dcache.scala:441:41, :718:88
    s2_repl_meta_REG_13_coh_state <= _meta_1_io_resp_5_coh_state;	// dcache.scala:441:41, :718:88
    s2_repl_meta_REG_13_tag <= _meta_1_io_resp_5_tag;	// dcache.scala:441:41, :718:88
    s2_repl_meta_REG_14_coh_state <= _meta_1_io_resp_6_coh_state;	// dcache.scala:441:41, :718:88
    s2_repl_meta_REG_14_tag <= _meta_1_io_resp_6_tag;	// dcache.scala:441:41, :718:88
    s2_repl_meta_REG_15_coh_state <= _meta_1_io_resp_7_coh_state;	// dcache.scala:441:41, :718:88
    s2_repl_meta_REG_15_tag <= _meta_1_io_resp_7_tag;	// dcache.scala:441:41, :718:88
    s2_nack_hit_0 <= _s2_nack_hit_WIRE_0;	// dcache.scala:612:93, :721:31
    s2_nack_hit_1 <=
      s1_req_1_addr[11:6] == _prober_io_meta_write_bits_idx & ~_prober_io_req_ready;	// dcache.scala:431:22, :599:32, :612:{43,59,93,96}, :721:31
    s2_send_resp_REG <= s1_send_resp_or_nack_0;	// dcache.scala:613:37, :732:44
    s2_send_resp_REG_1 <= s1_send_resp_or_nack_1;	// dcache.scala:613:37, :732:44
    s2_send_nack_REG <= s1_send_resp_or_nack_0;	// dcache.scala:613:37, :734:44
    s2_send_nack_REG_1 <= s1_send_resp_or_nack_1;	// dcache.scala:613:37, :734:44
    mshrs_io_meta_resp_bits_REG_0_coh_state <= _meta_0_io_resp_0_coh_state;	// dcache.scala:441:41, :772:70
    mshrs_io_meta_resp_bits_REG_1_coh_state <= _meta_0_io_resp_1_coh_state;	// dcache.scala:441:41, :772:70
    mshrs_io_meta_resp_bits_REG_2_coh_state <= _meta_0_io_resp_2_coh_state;	// dcache.scala:441:41, :772:70
    mshrs_io_meta_resp_bits_REG_3_coh_state <= _meta_0_io_resp_3_coh_state;	// dcache.scala:441:41, :772:70
    mshrs_io_meta_resp_bits_REG_4_coh_state <= _meta_0_io_resp_4_coh_state;	// dcache.scala:441:41, :772:70
    mshrs_io_meta_resp_bits_REG_5_coh_state <= _meta_0_io_resp_5_coh_state;	// dcache.scala:441:41, :772:70
    mshrs_io_meta_resp_bits_REG_6_coh_state <= _meta_0_io_resp_6_coh_state;	// dcache.scala:441:41, :772:70
    mshrs_io_meta_resp_bits_REG_7_coh_state <= _meta_0_io_resp_7_coh_state;	// dcache.scala:441:41, :772:70
    s3_req_addr <= s2_req_0_addr;	// dcache.scala:631:25, :869:25
    s3_req_data <= _amoalu_io_out;	// dcache.scala:869:25, :895:24
    s3_valid <=
      _s3_valid_T
      & (_s3_valid_T_1 | _s3_valid_T_2 | _s3_valid_T_4 | _s3_valid_T_6 | _s3_valid_T_7
         | _s3_valid_T_8 | _s3_valid_T_9 | _s3_valid_T_13 | _s3_valid_T_14
         | _s3_valid_T_15 | _s3_valid_T_16 | _s3_valid_T_17) & ~s2_sc_fail
      & ~(s2_send_nack_0 & s2_nack_0);	// Consts.scala:82:{32,49,66,76}, dcache.scala:665:26, :723:50, :731:131, :734:70, :870:25, :871:{26,38,41,59}, package.scala:15:47
    s4_req_addr <= s3_req_addr;	// dcache.scala:869:25, :879:25
    s4_req_data <= s3_req_data;	// dcache.scala:869:25, :879:25
    s4_valid <= s3_valid;	// dcache.scala:870:25, :880:25
    s5_req_addr <= s4_req_addr;	// dcache.scala:879:25, :881:25
    s5_req_data <= s4_req_data;	// dcache.scala:879:25, :881:25
    s5_valid <= s4_valid;	// dcache.scala:880:25, :882:25
    s3_way <= s2_tag_match_way_0;	// dcache.scala:642:33, :903:25
    if (reset) begin
      s1_valid_REG <= 1'h0;	// Nodes.scala:1207:84, PRNG.scala:82:22, dcache.scala:426:49, :430:18, :431:22, :432:21, :459:20, :462:27, :567:27, :604:25, :804:21, :813:31
      s1_valid_REG_1 <= 1'h0;	// Nodes.scala:1207:84, PRNG.scala:82:22, dcache.scala:426:49, :430:18, :431:22, :432:21, :459:20, :462:27, :567:27, :604:25, :804:21, :813:31
      debug_sc_fail_addr <= 40'h0;	// dcache.scala:432:21, :567:27, :656:35
      debug_sc_fail_cnt <= 8'h0;	// dcache.scala:657:35
      lrsc_count <= 7'h0;	// dcache.scala:432:21, :567:27, :659:27
      beatsLeft <= 9'h0;	// Arbiter.scala:87:30, :111:73, Edges.scala:220:14
      state_0 <= 1'h0;	// Arbiter.scala:116:26, Nodes.scala:1207:84, PRNG.scala:82:22, dcache.scala:426:49, :430:18, :431:22, :432:21, :459:20, :462:27, :567:27, :804:21, :813:31
      state_1 <= 1'h0;	// Arbiter.scala:116:26, Nodes.scala:1207:84, PRNG.scala:82:22, dcache.scala:426:49, :430:18, :431:22, :432:21, :459:20, :462:27, :567:27, :804:21, :813:31
    end
    else begin
      automatic logic _GEN_5;	// dcache.scala:689:26
      _GEN_5 = s2_req_0_addr == debug_sc_fail_addr;	// dcache.scala:631:25, :656:35, :689:26
      s1_valid_REG <=
        (_s1_valid_T_19
           ? io_lsu_req_bits_0_valid
           : _s0_send_resp_or_nack_T_1 | wb_fire | prober_fire | prefetch_fire
             | _s0_type_T_1)
        & (io_lsu_brupdate_b1_mispredict_mask & s0_req_0_uop_br_mask) == 20'h0
        & ~(io_lsu_exception
            & (_s1_valid_T_19
                 ? io_lsu_req_bits_0_bits_uop_uses_ldq
                 : _s0_req_T_5_0_uop_uses_ldq))
        & ~(s2_store_failed & _s1_valid_T_19
            & (_s1_valid_T_19
                 ? io_lsu_req_bits_0_bits_uop_uses_stq
                 : _s0_req_T_5_0_uop_uses_stq));	// Decoupled.scala:40:37, dcache.scala:431:22, :432:21, :441:41, :442:28, :444:27, :530:40, :567:27, :578:21, :579:88, :581:21, :582:21, :583:21, :584:21, :585:21, :604:25, :606:{26,45,74}, :607:{26,65}, :741:67, util.scala:118:{51,59}
      s1_valid_REG_1 <=
        _s1_valid_T_19 & io_lsu_req_bits_1_valid
        & (io_lsu_brupdate_b1_mispredict_mask & s0_req_1_uop_br_mask) == 20'h0
        & ~(io_lsu_exception & s0_req_1_uop_uses_ldq)
        & ~(s2_store_failed & _s1_valid_T_19 & s0_req_1_uop_uses_stq);	// Decoupled.scala:40:37, dcache.scala:431:22, :432:21, :441:41, :442:28, :444:27, :567:27, :581:21, :604:25, :606:{26,45,74}, :607:{26,65}, :741:67, util.scala:118:{51,59}
      if (~s2_valid_REG | _GEN_5 | ~s2_sc_fail) begin	// dcache.scala:634:26, :656:35, :665:26, :688:22, :689:{26,50}, :696:25
      end
      else	// dcache.scala:656:35, :688:22, :689:50
        debug_sc_fail_addr <= s2_req_0_addr;	// dcache.scala:631:25, :656:35
      if (s2_valid_REG) begin	// dcache.scala:634:26
        if (_GEN_5) begin	// dcache.scala:689:26
          if (s2_sc_fail)	// dcache.scala:665:26
            debug_sc_fail_cnt <= debug_sc_fail_cnt + 8'h1;	// dcache.scala:657:35, :691:48
          else if (s2_sc)	// dcache.scala:663:47
            debug_sc_fail_cnt <= 8'h0;	// dcache.scala:657:35
        end
        else if (s2_sc_fail)	// dcache.scala:665:26
          debug_sc_fail_cnt <= 8'h1;	// dcache.scala:657:35
      end
      if (s2_valid_REG_1 & _mshrs_io_req_1_valid_T_10 & ~s2_hit_1
          & ~(s2_has_permission_1 & (|s2_tag_match_way_1)) & (|(lrsc_count[6:2]))
          & lrsc_addr == s2_req_1_addr[39:6] & ~s2_nack_1 | s2_valid_REG
          & _mshrs_io_req_1_valid_T_10 & ~s2_hit_0
          & ~(s2_has_permission_0 & (|s2_tag_match_way_0)) & s2_lrsc_addr_match_0
          & ~s2_nack_0)	// Misc.scala:34:9, dcache.scala:631:25, :634:26, :642:33, :643:49, :648:141, :650:36, :659:27, :660:31, :661:23, :664:{53,66,86}, :667:{34,60}, :668:88, :680:7, :681:{7,30}, :682:50, :683:{7,20}, :684:18, :731:131
        lrsc_count <= 7'h0;	// dcache.scala:432:21, :567:27, :659:27
      else if (_GEN_4) begin	// dcache.scala:667:21
        if (|lrsc_count)	// dcache.scala:659:27, :666:20
          lrsc_count <= 7'h0;	// dcache.scala:432:21, :567:27, :659:27
        else if (s2_lr)	// dcache.scala:662:47
          lrsc_count <= 7'h4F;	// dcache.scala:659:27, :670:18
      end
      else if (|lrsc_count)	// dcache.scala:659:27, :666:20
        lrsc_count <= lrsc_count - 7'h1;	// dcache.scala:659:27, :666:54
      if (idle & auto_out_c_ready) begin	// Arbiter.scala:88:28, :89:24
        if (_wb_io_release_valid & _wb_io_release_bits_opcode[0])	// Arbiter.scala:111:73, Edges.scala:101:36, :220:14, dcache.scala:430:18
          beatsLeft <= 9'h7;	// Arbiter.scala:87:30, Edges.scala:219:59
        else	// Arbiter.scala:111:73, Edges.scala:220:14
          beatsLeft <= 9'h0;	// Arbiter.scala:87:30, :111:73, Edges.scala:220:14
      end
      else	// Arbiter.scala:89:24
        beatsLeft <= beatsLeft - {8'h0, auto_out_c_ready & out_2_valid};	// Arbiter.scala:87:30, :113:52, :125:29, ReadyValidCancel.scala:50:33
      if (idle) begin	// Arbiter.scala:88:28
        state_0 <= _wb_io_release_valid;	// Arbiter.scala:116:26, dcache.scala:430:18
        state_1 <= ~_wb_io_release_valid & _prober_io_rep_valid;	// Arbiter.scala:16:61, :98:79, :116:26, dcache.scala:430:18, :431:22
      end
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:137];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [7:0] i = 8'h0; i < 8'h8A; i += 8'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        s1_req_0_uop_uopc = _RANDOM[8'h0][6:0];	// dcache.scala:599:32
        s1_req_0_uop_inst = {_RANDOM[8'h0][31:7], _RANDOM[8'h1][6:0]};	// dcache.scala:599:32
        s1_req_0_uop_debug_inst = {_RANDOM[8'h1][31:7], _RANDOM[8'h2][6:0]};	// dcache.scala:599:32
        s1_req_0_uop_is_rvc = _RANDOM[8'h2][7];	// dcache.scala:599:32
        s1_req_0_uop_debug_pc = {_RANDOM[8'h2][31:8], _RANDOM[8'h3][15:0]};	// dcache.scala:599:32
        s1_req_0_uop_iq_type = _RANDOM[8'h3][18:16];	// dcache.scala:599:32
        s1_req_0_uop_fu_code = _RANDOM[8'h3][28:19];	// dcache.scala:599:32
        s1_req_0_uop_ctrl_br_type = {_RANDOM[8'h3][31:29], _RANDOM[8'h4][0]};	// dcache.scala:599:32
        s1_req_0_uop_ctrl_op1_sel = _RANDOM[8'h4][2:1];	// dcache.scala:599:32
        s1_req_0_uop_ctrl_op2_sel = _RANDOM[8'h4][5:3];	// dcache.scala:599:32
        s1_req_0_uop_ctrl_imm_sel = _RANDOM[8'h4][8:6];	// dcache.scala:599:32
        s1_req_0_uop_ctrl_op_fcn = _RANDOM[8'h4][12:9];	// dcache.scala:599:32
        s1_req_0_uop_ctrl_fcn_dw = _RANDOM[8'h4][13];	// dcache.scala:599:32
        s1_req_0_uop_ctrl_csr_cmd = _RANDOM[8'h4][16:14];	// dcache.scala:599:32
        s1_req_0_uop_ctrl_is_load = _RANDOM[8'h4][17];	// dcache.scala:599:32
        s1_req_0_uop_ctrl_is_sta = _RANDOM[8'h4][18];	// dcache.scala:599:32
        s1_req_0_uop_ctrl_is_std = _RANDOM[8'h4][19];	// dcache.scala:599:32
        s1_req_0_uop_iw_state = _RANDOM[8'h4][21:20];	// dcache.scala:599:32
        s1_req_0_uop_iw_p1_poisoned = _RANDOM[8'h4][22];	// dcache.scala:599:32
        s1_req_0_uop_iw_p2_poisoned = _RANDOM[8'h4][23];	// dcache.scala:599:32
        s1_req_0_uop_is_br = _RANDOM[8'h4][24];	// dcache.scala:599:32
        s1_req_0_uop_is_jalr = _RANDOM[8'h4][25];	// dcache.scala:599:32
        s1_req_0_uop_is_jal = _RANDOM[8'h4][26];	// dcache.scala:599:32
        s1_req_0_uop_is_sfb = _RANDOM[8'h4][27];	// dcache.scala:599:32
        s1_req_0_uop_br_mask = {_RANDOM[8'h4][31:28], _RANDOM[8'h5][15:0]};	// dcache.scala:599:32
        s1_req_0_uop_br_tag = _RANDOM[8'h5][20:16];	// dcache.scala:599:32
        s1_req_0_uop_ftq_idx = _RANDOM[8'h5][26:21];	// dcache.scala:599:32
        s1_req_0_uop_edge_inst = _RANDOM[8'h5][27];	// dcache.scala:599:32
        s1_req_0_uop_pc_lob = {_RANDOM[8'h5][31:28], _RANDOM[8'h6][1:0]};	// dcache.scala:599:32
        s1_req_0_uop_taken = _RANDOM[8'h6][2];	// dcache.scala:599:32
        s1_req_0_uop_imm_packed = _RANDOM[8'h6][22:3];	// dcache.scala:599:32
        s1_req_0_uop_csr_addr = {_RANDOM[8'h6][31:23], _RANDOM[8'h7][2:0]};	// dcache.scala:599:32
        s1_req_0_uop_rob_idx = _RANDOM[8'h7][9:3];	// dcache.scala:599:32
        s1_req_0_uop_ldq_idx = _RANDOM[8'h7][14:10];	// dcache.scala:599:32
        s1_req_0_uop_stq_idx = _RANDOM[8'h7][19:15];	// dcache.scala:599:32
        s1_req_0_uop_rxq_idx = _RANDOM[8'h7][21:20];	// dcache.scala:599:32
        s1_req_0_uop_pdst = _RANDOM[8'h7][28:22];	// dcache.scala:599:32
        s1_req_0_uop_prs1 = {_RANDOM[8'h7][31:29], _RANDOM[8'h8][3:0]};	// dcache.scala:599:32
        s1_req_0_uop_prs2 = _RANDOM[8'h8][10:4];	// dcache.scala:599:32
        s1_req_0_uop_prs3 = _RANDOM[8'h8][17:11];	// dcache.scala:599:32
        s1_req_0_uop_ppred = _RANDOM[8'h8][23:18];	// dcache.scala:599:32
        s1_req_0_uop_prs1_busy = _RANDOM[8'h8][24];	// dcache.scala:599:32
        s1_req_0_uop_prs2_busy = _RANDOM[8'h8][25];	// dcache.scala:599:32
        s1_req_0_uop_prs3_busy = _RANDOM[8'h8][26];	// dcache.scala:599:32
        s1_req_0_uop_ppred_busy = _RANDOM[8'h8][27];	// dcache.scala:599:32
        s1_req_0_uop_stale_pdst = {_RANDOM[8'h8][31:28], _RANDOM[8'h9][2:0]};	// dcache.scala:599:32
        s1_req_0_uop_exception = _RANDOM[8'h9][3];	// dcache.scala:599:32
        s1_req_0_uop_exc_cause = {_RANDOM[8'h9][31:4], _RANDOM[8'hA], _RANDOM[8'hB][3:0]};	// dcache.scala:599:32
        s1_req_0_uop_bypassable = _RANDOM[8'hB][4];	// dcache.scala:599:32
        s1_req_0_uop_mem_cmd = _RANDOM[8'hB][9:5];	// dcache.scala:599:32
        s1_req_0_uop_mem_size = _RANDOM[8'hB][11:10];	// dcache.scala:599:32
        s1_req_0_uop_mem_signed = _RANDOM[8'hB][12];	// dcache.scala:599:32
        s1_req_0_uop_is_fence = _RANDOM[8'hB][13];	// dcache.scala:599:32
        s1_req_0_uop_is_fencei = _RANDOM[8'hB][14];	// dcache.scala:599:32
        s1_req_0_uop_is_amo = _RANDOM[8'hB][15];	// dcache.scala:599:32
        s1_req_0_uop_uses_ldq = _RANDOM[8'hB][16];	// dcache.scala:599:32
        s1_req_0_uop_uses_stq = _RANDOM[8'hB][17];	// dcache.scala:599:32
        s1_req_0_uop_is_sys_pc2epc = _RANDOM[8'hB][18];	// dcache.scala:599:32
        s1_req_0_uop_is_unique = _RANDOM[8'hB][19];	// dcache.scala:599:32
        s1_req_0_uop_flush_on_commit = _RANDOM[8'hB][20];	// dcache.scala:599:32
        s1_req_0_uop_ldst_is_rs1 = _RANDOM[8'hB][21];	// dcache.scala:599:32
        s1_req_0_uop_ldst = _RANDOM[8'hB][27:22];	// dcache.scala:599:32
        s1_req_0_uop_lrs1 = {_RANDOM[8'hB][31:28], _RANDOM[8'hC][1:0]};	// dcache.scala:599:32
        s1_req_0_uop_lrs2 = _RANDOM[8'hC][7:2];	// dcache.scala:599:32
        s1_req_0_uop_lrs3 = _RANDOM[8'hC][13:8];	// dcache.scala:599:32
        s1_req_0_uop_ldst_val = _RANDOM[8'hC][14];	// dcache.scala:599:32
        s1_req_0_uop_dst_rtype = _RANDOM[8'hC][16:15];	// dcache.scala:599:32
        s1_req_0_uop_lrs1_rtype = _RANDOM[8'hC][18:17];	// dcache.scala:599:32
        s1_req_0_uop_lrs2_rtype = _RANDOM[8'hC][20:19];	// dcache.scala:599:32
        s1_req_0_uop_frs3_en = _RANDOM[8'hC][21];	// dcache.scala:599:32
        s1_req_0_uop_fp_val = _RANDOM[8'hC][22];	// dcache.scala:599:32
        s1_req_0_uop_fp_single = _RANDOM[8'hC][23];	// dcache.scala:599:32
        s1_req_0_uop_xcpt_pf_if = _RANDOM[8'hC][24];	// dcache.scala:599:32
        s1_req_0_uop_xcpt_ae_if = _RANDOM[8'hC][25];	// dcache.scala:599:32
        s1_req_0_uop_xcpt_ma_if = _RANDOM[8'hC][26];	// dcache.scala:599:32
        s1_req_0_uop_bp_debug_if = _RANDOM[8'hC][27];	// dcache.scala:599:32
        s1_req_0_uop_bp_xcpt_if = _RANDOM[8'hC][28];	// dcache.scala:599:32
        s1_req_0_uop_debug_fsrc = _RANDOM[8'hC][30:29];	// dcache.scala:599:32
        s1_req_0_uop_debug_tsrc = {_RANDOM[8'hC][31], _RANDOM[8'hD][0]};	// dcache.scala:599:32
        s1_req_0_addr = {_RANDOM[8'hD][31:1], _RANDOM[8'hE][8:0]};	// dcache.scala:599:32
        s1_req_0_data = {_RANDOM[8'hE][31:9], _RANDOM[8'hF], _RANDOM[8'h10][8:0]};	// dcache.scala:599:32
        s1_req_0_is_hella = _RANDOM[8'h10][9];	// dcache.scala:599:32
        s1_req_1_uop_uopc = _RANDOM[8'h10][16:10];	// dcache.scala:599:32
        s1_req_1_uop_inst = {_RANDOM[8'h10][31:17], _RANDOM[8'h11][16:0]};	// dcache.scala:599:32
        s1_req_1_uop_debug_inst = {_RANDOM[8'h11][31:17], _RANDOM[8'h12][16:0]};	// dcache.scala:599:32
        s1_req_1_uop_is_rvc = _RANDOM[8'h12][17];	// dcache.scala:599:32
        s1_req_1_uop_debug_pc = {_RANDOM[8'h12][31:18], _RANDOM[8'h13][25:0]};	// dcache.scala:599:32
        s1_req_1_uop_iq_type = _RANDOM[8'h13][28:26];	// dcache.scala:599:32
        s1_req_1_uop_fu_code = {_RANDOM[8'h13][31:29], _RANDOM[8'h14][6:0]};	// dcache.scala:599:32
        s1_req_1_uop_ctrl_br_type = _RANDOM[8'h14][10:7];	// dcache.scala:599:32
        s1_req_1_uop_ctrl_op1_sel = _RANDOM[8'h14][12:11];	// dcache.scala:599:32
        s1_req_1_uop_ctrl_op2_sel = _RANDOM[8'h14][15:13];	// dcache.scala:599:32
        s1_req_1_uop_ctrl_imm_sel = _RANDOM[8'h14][18:16];	// dcache.scala:599:32
        s1_req_1_uop_ctrl_op_fcn = _RANDOM[8'h14][22:19];	// dcache.scala:599:32
        s1_req_1_uop_ctrl_fcn_dw = _RANDOM[8'h14][23];	// dcache.scala:599:32
        s1_req_1_uop_ctrl_csr_cmd = _RANDOM[8'h14][26:24];	// dcache.scala:599:32
        s1_req_1_uop_ctrl_is_load = _RANDOM[8'h14][27];	// dcache.scala:599:32
        s1_req_1_uop_ctrl_is_sta = _RANDOM[8'h14][28];	// dcache.scala:599:32
        s1_req_1_uop_ctrl_is_std = _RANDOM[8'h14][29];	// dcache.scala:599:32
        s1_req_1_uop_iw_state = _RANDOM[8'h14][31:30];	// dcache.scala:599:32
        s1_req_1_uop_iw_p1_poisoned = _RANDOM[8'h15][0];	// dcache.scala:599:32
        s1_req_1_uop_iw_p2_poisoned = _RANDOM[8'h15][1];	// dcache.scala:599:32
        s1_req_1_uop_is_br = _RANDOM[8'h15][2];	// dcache.scala:599:32
        s1_req_1_uop_is_jalr = _RANDOM[8'h15][3];	// dcache.scala:599:32
        s1_req_1_uop_is_jal = _RANDOM[8'h15][4];	// dcache.scala:599:32
        s1_req_1_uop_is_sfb = _RANDOM[8'h15][5];	// dcache.scala:599:32
        s1_req_1_uop_br_mask = _RANDOM[8'h15][25:6];	// dcache.scala:599:32
        s1_req_1_uop_br_tag = _RANDOM[8'h15][30:26];	// dcache.scala:599:32
        s1_req_1_uop_ftq_idx = {_RANDOM[8'h15][31], _RANDOM[8'h16][4:0]};	// dcache.scala:599:32
        s1_req_1_uop_edge_inst = _RANDOM[8'h16][5];	// dcache.scala:599:32
        s1_req_1_uop_pc_lob = _RANDOM[8'h16][11:6];	// dcache.scala:599:32
        s1_req_1_uop_taken = _RANDOM[8'h16][12];	// dcache.scala:599:32
        s1_req_1_uop_imm_packed = {_RANDOM[8'h16][31:13], _RANDOM[8'h17][0]};	// dcache.scala:599:32
        s1_req_1_uop_csr_addr = _RANDOM[8'h17][12:1];	// dcache.scala:599:32
        s1_req_1_uop_rob_idx = _RANDOM[8'h17][19:13];	// dcache.scala:599:32
        s1_req_1_uop_ldq_idx = _RANDOM[8'h17][24:20];	// dcache.scala:599:32
        s1_req_1_uop_stq_idx = _RANDOM[8'h17][29:25];	// dcache.scala:599:32
        s1_req_1_uop_rxq_idx = _RANDOM[8'h17][31:30];	// dcache.scala:599:32
        s1_req_1_uop_pdst = _RANDOM[8'h18][6:0];	// dcache.scala:599:32
        s1_req_1_uop_prs1 = _RANDOM[8'h18][13:7];	// dcache.scala:599:32
        s1_req_1_uop_prs2 = _RANDOM[8'h18][20:14];	// dcache.scala:599:32
        s1_req_1_uop_prs3 = _RANDOM[8'h18][27:21];	// dcache.scala:599:32
        s1_req_1_uop_ppred = {_RANDOM[8'h18][31:28], _RANDOM[8'h19][1:0]};	// dcache.scala:599:32
        s1_req_1_uop_prs1_busy = _RANDOM[8'h19][2];	// dcache.scala:599:32
        s1_req_1_uop_prs2_busy = _RANDOM[8'h19][3];	// dcache.scala:599:32
        s1_req_1_uop_prs3_busy = _RANDOM[8'h19][4];	// dcache.scala:599:32
        s1_req_1_uop_ppred_busy = _RANDOM[8'h19][5];	// dcache.scala:599:32
        s1_req_1_uop_stale_pdst = _RANDOM[8'h19][12:6];	// dcache.scala:599:32
        s1_req_1_uop_exception = _RANDOM[8'h19][13];	// dcache.scala:599:32
        s1_req_1_uop_exc_cause =
          {_RANDOM[8'h19][31:14], _RANDOM[8'h1A], _RANDOM[8'h1B][13:0]};	// dcache.scala:599:32
        s1_req_1_uop_bypassable = _RANDOM[8'h1B][14];	// dcache.scala:599:32
        s1_req_1_uop_mem_cmd = _RANDOM[8'h1B][19:15];	// dcache.scala:599:32
        s1_req_1_uop_mem_size = _RANDOM[8'h1B][21:20];	// dcache.scala:599:32
        s1_req_1_uop_mem_signed = _RANDOM[8'h1B][22];	// dcache.scala:599:32
        s1_req_1_uop_is_fence = _RANDOM[8'h1B][23];	// dcache.scala:599:32
        s1_req_1_uop_is_fencei = _RANDOM[8'h1B][24];	// dcache.scala:599:32
        s1_req_1_uop_is_amo = _RANDOM[8'h1B][25];	// dcache.scala:599:32
        s1_req_1_uop_uses_ldq = _RANDOM[8'h1B][26];	// dcache.scala:599:32
        s1_req_1_uop_uses_stq = _RANDOM[8'h1B][27];	// dcache.scala:599:32
        s1_req_1_uop_is_sys_pc2epc = _RANDOM[8'h1B][28];	// dcache.scala:599:32
        s1_req_1_uop_is_unique = _RANDOM[8'h1B][29];	// dcache.scala:599:32
        s1_req_1_uop_flush_on_commit = _RANDOM[8'h1B][30];	// dcache.scala:599:32
        s1_req_1_uop_ldst_is_rs1 = _RANDOM[8'h1B][31];	// dcache.scala:599:32
        s1_req_1_uop_ldst = _RANDOM[8'h1C][5:0];	// dcache.scala:599:32
        s1_req_1_uop_lrs1 = _RANDOM[8'h1C][11:6];	// dcache.scala:599:32
        s1_req_1_uop_lrs2 = _RANDOM[8'h1C][17:12];	// dcache.scala:599:32
        s1_req_1_uop_lrs3 = _RANDOM[8'h1C][23:18];	// dcache.scala:599:32
        s1_req_1_uop_ldst_val = _RANDOM[8'h1C][24];	// dcache.scala:599:32
        s1_req_1_uop_dst_rtype = _RANDOM[8'h1C][26:25];	// dcache.scala:599:32
        s1_req_1_uop_lrs1_rtype = _RANDOM[8'h1C][28:27];	// dcache.scala:599:32
        s1_req_1_uop_lrs2_rtype = _RANDOM[8'h1C][30:29];	// dcache.scala:599:32
        s1_req_1_uop_frs3_en = _RANDOM[8'h1C][31];	// dcache.scala:599:32
        s1_req_1_uop_fp_val = _RANDOM[8'h1D][0];	// dcache.scala:599:32
        s1_req_1_uop_fp_single = _RANDOM[8'h1D][1];	// dcache.scala:599:32
        s1_req_1_uop_xcpt_pf_if = _RANDOM[8'h1D][2];	// dcache.scala:599:32
        s1_req_1_uop_xcpt_ae_if = _RANDOM[8'h1D][3];	// dcache.scala:599:32
        s1_req_1_uop_xcpt_ma_if = _RANDOM[8'h1D][4];	// dcache.scala:599:32
        s1_req_1_uop_bp_debug_if = _RANDOM[8'h1D][5];	// dcache.scala:599:32
        s1_req_1_uop_bp_xcpt_if = _RANDOM[8'h1D][6];	// dcache.scala:599:32
        s1_req_1_uop_debug_fsrc = _RANDOM[8'h1D][8:7];	// dcache.scala:599:32
        s1_req_1_uop_debug_tsrc = _RANDOM[8'h1D][10:9];	// dcache.scala:599:32
        s1_req_1_addr = {_RANDOM[8'h1D][31:11], _RANDOM[8'h1E][18:0]};	// dcache.scala:599:32
        s1_req_1_data = {_RANDOM[8'h1E][31:19], _RANDOM[8'h1F], _RANDOM[8'h20][18:0]};	// dcache.scala:599:32
        s1_req_1_is_hella = _RANDOM[8'h20][19];	// dcache.scala:599:32
        s1_valid_REG = _RANDOM[8'h20][20];	// dcache.scala:599:32, :604:25
        s1_valid_REG_1 = _RANDOM[8'h20][21];	// dcache.scala:599:32, :604:25
        REG = _RANDOM[8'h20][22];	// dcache.scala:599:32, :610:43
        REG_1 = _RANDOM[8'h20][23];	// dcache.scala:599:32, :610:74
        REG_2 = _RANDOM[8'h20][24];	// dcache.scala:599:32, :610:43
        REG_3 = _RANDOM[8'h20][25];	// dcache.scala:599:32, :610:74
        s1_send_resp_or_nack_0 = _RANDOM[8'h20][26];	// dcache.scala:599:32, :613:37
        s1_send_resp_or_nack_1 = _RANDOM[8'h20][27];	// dcache.scala:599:32, :613:37
        s1_type = _RANDOM[8'h20][30:28];	// dcache.scala:599:32, :614:32
        s1_mshr_meta_read_way_en = {_RANDOM[8'h20][31], _RANDOM[8'h21][6:0]};	// dcache.scala:599:32, :616:41
        s1_replay_way_en = _RANDOM[8'h21][14:7];	// dcache.scala:616:41, :617:41
        s1_wb_way_en = _RANDOM[8'h21][22:15];	// dcache.scala:616:41, :618:41
        s2_req_0_uop_uopc = _RANDOM[8'h21][29:23];	// dcache.scala:616:41, :631:25
        s2_req_0_uop_inst = {_RANDOM[8'h21][31:30], _RANDOM[8'h22][29:0]};	// dcache.scala:616:41, :631:25
        s2_req_0_uop_debug_inst = {_RANDOM[8'h22][31:30], _RANDOM[8'h23][29:0]};	// dcache.scala:631:25
        s2_req_0_uop_is_rvc = _RANDOM[8'h23][30];	// dcache.scala:631:25
        s2_req_0_uop_debug_pc = {_RANDOM[8'h23][31], _RANDOM[8'h24], _RANDOM[8'h25][6:0]};	// dcache.scala:631:25
        s2_req_0_uop_iq_type = _RANDOM[8'h25][9:7];	// dcache.scala:631:25
        s2_req_0_uop_fu_code = _RANDOM[8'h25][19:10];	// dcache.scala:631:25
        s2_req_0_uop_ctrl_br_type = _RANDOM[8'h25][23:20];	// dcache.scala:631:25
        s2_req_0_uop_ctrl_op1_sel = _RANDOM[8'h25][25:24];	// dcache.scala:631:25
        s2_req_0_uop_ctrl_op2_sel = _RANDOM[8'h25][28:26];	// dcache.scala:631:25
        s2_req_0_uop_ctrl_imm_sel = _RANDOM[8'h25][31:29];	// dcache.scala:631:25
        s2_req_0_uop_ctrl_op_fcn = _RANDOM[8'h26][3:0];	// dcache.scala:631:25
        s2_req_0_uop_ctrl_fcn_dw = _RANDOM[8'h26][4];	// dcache.scala:631:25
        s2_req_0_uop_ctrl_csr_cmd = _RANDOM[8'h26][7:5];	// dcache.scala:631:25
        s2_req_0_uop_ctrl_is_load = _RANDOM[8'h26][8];	// dcache.scala:631:25
        s2_req_0_uop_ctrl_is_sta = _RANDOM[8'h26][9];	// dcache.scala:631:25
        s2_req_0_uop_ctrl_is_std = _RANDOM[8'h26][10];	// dcache.scala:631:25
        s2_req_0_uop_iw_state = _RANDOM[8'h26][12:11];	// dcache.scala:631:25
        s2_req_0_uop_iw_p1_poisoned = _RANDOM[8'h26][13];	// dcache.scala:631:25
        s2_req_0_uop_iw_p2_poisoned = _RANDOM[8'h26][14];	// dcache.scala:631:25
        s2_req_0_uop_is_br = _RANDOM[8'h26][15];	// dcache.scala:631:25
        s2_req_0_uop_is_jalr = _RANDOM[8'h26][16];	// dcache.scala:631:25
        s2_req_0_uop_is_jal = _RANDOM[8'h26][17];	// dcache.scala:631:25
        s2_req_0_uop_is_sfb = _RANDOM[8'h26][18];	// dcache.scala:631:25
        s2_req_0_uop_br_mask = {_RANDOM[8'h26][31:19], _RANDOM[8'h27][6:0]};	// dcache.scala:631:25
        s2_req_0_uop_br_tag = _RANDOM[8'h27][11:7];	// dcache.scala:631:25
        s2_req_0_uop_ftq_idx = _RANDOM[8'h27][17:12];	// dcache.scala:631:25
        s2_req_0_uop_edge_inst = _RANDOM[8'h27][18];	// dcache.scala:631:25
        s2_req_0_uop_pc_lob = _RANDOM[8'h27][24:19];	// dcache.scala:631:25
        s2_req_0_uop_taken = _RANDOM[8'h27][25];	// dcache.scala:631:25
        s2_req_0_uop_imm_packed = {_RANDOM[8'h27][31:26], _RANDOM[8'h28][13:0]};	// dcache.scala:631:25
        s2_req_0_uop_csr_addr = _RANDOM[8'h28][25:14];	// dcache.scala:631:25
        s2_req_0_uop_rob_idx = {_RANDOM[8'h28][31:26], _RANDOM[8'h29][0]};	// dcache.scala:631:25
        s2_req_0_uop_ldq_idx = _RANDOM[8'h29][5:1];	// dcache.scala:631:25
        s2_req_0_uop_stq_idx = _RANDOM[8'h29][10:6];	// dcache.scala:631:25
        s2_req_0_uop_rxq_idx = _RANDOM[8'h29][12:11];	// dcache.scala:631:25
        s2_req_0_uop_pdst = _RANDOM[8'h29][19:13];	// dcache.scala:631:25
        s2_req_0_uop_prs1 = _RANDOM[8'h29][26:20];	// dcache.scala:631:25
        s2_req_0_uop_prs2 = {_RANDOM[8'h29][31:27], _RANDOM[8'h2A][1:0]};	// dcache.scala:631:25
        s2_req_0_uop_prs3 = _RANDOM[8'h2A][8:2];	// dcache.scala:631:25
        s2_req_0_uop_ppred = _RANDOM[8'h2A][14:9];	// dcache.scala:631:25
        s2_req_0_uop_prs1_busy = _RANDOM[8'h2A][15];	// dcache.scala:631:25
        s2_req_0_uop_prs2_busy = _RANDOM[8'h2A][16];	// dcache.scala:631:25
        s2_req_0_uop_prs3_busy = _RANDOM[8'h2A][17];	// dcache.scala:631:25
        s2_req_0_uop_ppred_busy = _RANDOM[8'h2A][18];	// dcache.scala:631:25
        s2_req_0_uop_stale_pdst = _RANDOM[8'h2A][25:19];	// dcache.scala:631:25
        s2_req_0_uop_exception = _RANDOM[8'h2A][26];	// dcache.scala:631:25
        s2_req_0_uop_exc_cause =
          {_RANDOM[8'h2A][31:27], _RANDOM[8'h2B], _RANDOM[8'h2C][26:0]};	// dcache.scala:631:25
        s2_req_0_uop_bypassable = _RANDOM[8'h2C][27];	// dcache.scala:631:25
        s2_req_0_uop_mem_cmd = {_RANDOM[8'h2C][31:28], _RANDOM[8'h2D][0]};	// dcache.scala:631:25
        size = _RANDOM[8'h2D][2:1];	// dcache.scala:631:25
        s2_req_0_uop_mem_signed = _RANDOM[8'h2D][3];	// dcache.scala:631:25
        s2_req_0_uop_is_fence = _RANDOM[8'h2D][4];	// dcache.scala:631:25
        s2_req_0_uop_is_fencei = _RANDOM[8'h2D][5];	// dcache.scala:631:25
        s2_req_0_uop_is_amo = _RANDOM[8'h2D][6];	// dcache.scala:631:25
        s2_req_0_uop_uses_ldq = _RANDOM[8'h2D][7];	// dcache.scala:631:25
        s2_req_0_uop_uses_stq = _RANDOM[8'h2D][8];	// dcache.scala:631:25
        s2_req_0_uop_is_sys_pc2epc = _RANDOM[8'h2D][9];	// dcache.scala:631:25
        s2_req_0_uop_is_unique = _RANDOM[8'h2D][10];	// dcache.scala:631:25
        s2_req_0_uop_flush_on_commit = _RANDOM[8'h2D][11];	// dcache.scala:631:25
        s2_req_0_uop_ldst_is_rs1 = _RANDOM[8'h2D][12];	// dcache.scala:631:25
        s2_req_0_uop_ldst = _RANDOM[8'h2D][18:13];	// dcache.scala:631:25
        s2_req_0_uop_lrs1 = _RANDOM[8'h2D][24:19];	// dcache.scala:631:25
        s2_req_0_uop_lrs2 = _RANDOM[8'h2D][30:25];	// dcache.scala:631:25
        s2_req_0_uop_lrs3 = {_RANDOM[8'h2D][31], _RANDOM[8'h2E][4:0]};	// dcache.scala:631:25
        s2_req_0_uop_ldst_val = _RANDOM[8'h2E][5];	// dcache.scala:631:25
        s2_req_0_uop_dst_rtype = _RANDOM[8'h2E][7:6];	// dcache.scala:631:25
        s2_req_0_uop_lrs1_rtype = _RANDOM[8'h2E][9:8];	// dcache.scala:631:25
        s2_req_0_uop_lrs2_rtype = _RANDOM[8'h2E][11:10];	// dcache.scala:631:25
        s2_req_0_uop_frs3_en = _RANDOM[8'h2E][12];	// dcache.scala:631:25
        s2_req_0_uop_fp_val = _RANDOM[8'h2E][13];	// dcache.scala:631:25
        s2_req_0_uop_fp_single = _RANDOM[8'h2E][14];	// dcache.scala:631:25
        s2_req_0_uop_xcpt_pf_if = _RANDOM[8'h2E][15];	// dcache.scala:631:25
        s2_req_0_uop_xcpt_ae_if = _RANDOM[8'h2E][16];	// dcache.scala:631:25
        s2_req_0_uop_xcpt_ma_if = _RANDOM[8'h2E][17];	// dcache.scala:631:25
        s2_req_0_uop_bp_debug_if = _RANDOM[8'h2E][18];	// dcache.scala:631:25
        s2_req_0_uop_bp_xcpt_if = _RANDOM[8'h2E][19];	// dcache.scala:631:25
        s2_req_0_uop_debug_fsrc = _RANDOM[8'h2E][21:20];	// dcache.scala:631:25
        s2_req_0_uop_debug_tsrc = _RANDOM[8'h2E][23:22];	// dcache.scala:631:25
        s2_req_0_addr = {_RANDOM[8'h2E][31:24], _RANDOM[8'h2F]};	// dcache.scala:631:25
        s2_req_0_data = {_RANDOM[8'h30], _RANDOM[8'h31]};	// dcache.scala:631:25
        s2_req_0_is_hella = _RANDOM[8'h32][0];	// dcache.scala:631:25
        s2_req_1_uop_uopc = _RANDOM[8'h32][7:1];	// dcache.scala:631:25
        s2_req_1_uop_inst = {_RANDOM[8'h32][31:8], _RANDOM[8'h33][7:0]};	// dcache.scala:631:25
        s2_req_1_uop_debug_inst = {_RANDOM[8'h33][31:8], _RANDOM[8'h34][7:0]};	// dcache.scala:631:25
        s2_req_1_uop_is_rvc = _RANDOM[8'h34][8];	// dcache.scala:631:25
        s2_req_1_uop_debug_pc = {_RANDOM[8'h34][31:9], _RANDOM[8'h35][16:0]};	// dcache.scala:631:25
        s2_req_1_uop_iq_type = _RANDOM[8'h35][19:17];	// dcache.scala:631:25
        s2_req_1_uop_fu_code = _RANDOM[8'h35][29:20];	// dcache.scala:631:25
        s2_req_1_uop_ctrl_br_type = {_RANDOM[8'h35][31:30], _RANDOM[8'h36][1:0]};	// dcache.scala:631:25
        s2_req_1_uop_ctrl_op1_sel = _RANDOM[8'h36][3:2];	// dcache.scala:631:25
        s2_req_1_uop_ctrl_op2_sel = _RANDOM[8'h36][6:4];	// dcache.scala:631:25
        s2_req_1_uop_ctrl_imm_sel = _RANDOM[8'h36][9:7];	// dcache.scala:631:25
        s2_req_1_uop_ctrl_op_fcn = _RANDOM[8'h36][13:10];	// dcache.scala:631:25
        s2_req_1_uop_ctrl_fcn_dw = _RANDOM[8'h36][14];	// dcache.scala:631:25
        s2_req_1_uop_ctrl_csr_cmd = _RANDOM[8'h36][17:15];	// dcache.scala:631:25
        s2_req_1_uop_ctrl_is_load = _RANDOM[8'h36][18];	// dcache.scala:631:25
        s2_req_1_uop_ctrl_is_sta = _RANDOM[8'h36][19];	// dcache.scala:631:25
        s2_req_1_uop_ctrl_is_std = _RANDOM[8'h36][20];	// dcache.scala:631:25
        s2_req_1_uop_iw_state = _RANDOM[8'h36][22:21];	// dcache.scala:631:25
        s2_req_1_uop_iw_p1_poisoned = _RANDOM[8'h36][23];	// dcache.scala:631:25
        s2_req_1_uop_iw_p2_poisoned = _RANDOM[8'h36][24];	// dcache.scala:631:25
        s2_req_1_uop_is_br = _RANDOM[8'h36][25];	// dcache.scala:631:25
        s2_req_1_uop_is_jalr = _RANDOM[8'h36][26];	// dcache.scala:631:25
        s2_req_1_uop_is_jal = _RANDOM[8'h36][27];	// dcache.scala:631:25
        s2_req_1_uop_is_sfb = _RANDOM[8'h36][28];	// dcache.scala:631:25
        s2_req_1_uop_br_mask = {_RANDOM[8'h36][31:29], _RANDOM[8'h37][16:0]};	// dcache.scala:631:25
        s2_req_1_uop_br_tag = _RANDOM[8'h37][21:17];	// dcache.scala:631:25
        s2_req_1_uop_ftq_idx = _RANDOM[8'h37][27:22];	// dcache.scala:631:25
        s2_req_1_uop_edge_inst = _RANDOM[8'h37][28];	// dcache.scala:631:25
        s2_req_1_uop_pc_lob = {_RANDOM[8'h37][31:29], _RANDOM[8'h38][2:0]};	// dcache.scala:631:25
        s2_req_1_uop_taken = _RANDOM[8'h38][3];	// dcache.scala:631:25
        s2_req_1_uop_imm_packed = _RANDOM[8'h38][23:4];	// dcache.scala:631:25
        s2_req_1_uop_csr_addr = {_RANDOM[8'h38][31:24], _RANDOM[8'h39][3:0]};	// dcache.scala:631:25
        s2_req_1_uop_rob_idx = _RANDOM[8'h39][10:4];	// dcache.scala:631:25
        s2_req_1_uop_ldq_idx = _RANDOM[8'h39][15:11];	// dcache.scala:631:25
        s2_req_1_uop_stq_idx = _RANDOM[8'h39][20:16];	// dcache.scala:631:25
        s2_req_1_uop_rxq_idx = _RANDOM[8'h39][22:21];	// dcache.scala:631:25
        s2_req_1_uop_pdst = _RANDOM[8'h39][29:23];	// dcache.scala:631:25
        s2_req_1_uop_prs1 = {_RANDOM[8'h39][31:30], _RANDOM[8'h3A][4:0]};	// dcache.scala:631:25
        s2_req_1_uop_prs2 = _RANDOM[8'h3A][11:5];	// dcache.scala:631:25
        s2_req_1_uop_prs3 = _RANDOM[8'h3A][18:12];	// dcache.scala:631:25
        s2_req_1_uop_ppred = _RANDOM[8'h3A][24:19];	// dcache.scala:631:25
        s2_req_1_uop_prs1_busy = _RANDOM[8'h3A][25];	// dcache.scala:631:25
        s2_req_1_uop_prs2_busy = _RANDOM[8'h3A][26];	// dcache.scala:631:25
        s2_req_1_uop_prs3_busy = _RANDOM[8'h3A][27];	// dcache.scala:631:25
        s2_req_1_uop_ppred_busy = _RANDOM[8'h3A][28];	// dcache.scala:631:25
        s2_req_1_uop_stale_pdst = {_RANDOM[8'h3A][31:29], _RANDOM[8'h3B][3:0]};	// dcache.scala:631:25
        s2_req_1_uop_exception = _RANDOM[8'h3B][4];	// dcache.scala:631:25
        s2_req_1_uop_exc_cause =
          {_RANDOM[8'h3B][31:5], _RANDOM[8'h3C], _RANDOM[8'h3D][4:0]};	// dcache.scala:631:25
        s2_req_1_uop_bypassable = _RANDOM[8'h3D][5];	// dcache.scala:631:25
        s2_req_1_uop_mem_cmd = _RANDOM[8'h3D][10:6];	// dcache.scala:631:25
        size_1 = _RANDOM[8'h3D][12:11];	// dcache.scala:631:25
        s2_req_1_uop_mem_signed = _RANDOM[8'h3D][13];	// dcache.scala:631:25
        s2_req_1_uop_is_fence = _RANDOM[8'h3D][14];	// dcache.scala:631:25
        s2_req_1_uop_is_fencei = _RANDOM[8'h3D][15];	// dcache.scala:631:25
        s2_req_1_uop_is_amo = _RANDOM[8'h3D][16];	// dcache.scala:631:25
        s2_req_1_uop_uses_ldq = _RANDOM[8'h3D][17];	// dcache.scala:631:25
        s2_req_1_uop_uses_stq = _RANDOM[8'h3D][18];	// dcache.scala:631:25
        s2_req_1_uop_is_sys_pc2epc = _RANDOM[8'h3D][19];	// dcache.scala:631:25
        s2_req_1_uop_is_unique = _RANDOM[8'h3D][20];	// dcache.scala:631:25
        s2_req_1_uop_flush_on_commit = _RANDOM[8'h3D][21];	// dcache.scala:631:25
        s2_req_1_uop_ldst_is_rs1 = _RANDOM[8'h3D][22];	// dcache.scala:631:25
        s2_req_1_uop_ldst = _RANDOM[8'h3D][28:23];	// dcache.scala:631:25
        s2_req_1_uop_lrs1 = {_RANDOM[8'h3D][31:29], _RANDOM[8'h3E][2:0]};	// dcache.scala:631:25
        s2_req_1_uop_lrs2 = _RANDOM[8'h3E][8:3];	// dcache.scala:631:25
        s2_req_1_uop_lrs3 = _RANDOM[8'h3E][14:9];	// dcache.scala:631:25
        s2_req_1_uop_ldst_val = _RANDOM[8'h3E][15];	// dcache.scala:631:25
        s2_req_1_uop_dst_rtype = _RANDOM[8'h3E][17:16];	// dcache.scala:631:25
        s2_req_1_uop_lrs1_rtype = _RANDOM[8'h3E][19:18];	// dcache.scala:631:25
        s2_req_1_uop_lrs2_rtype = _RANDOM[8'h3E][21:20];	// dcache.scala:631:25
        s2_req_1_uop_frs3_en = _RANDOM[8'h3E][22];	// dcache.scala:631:25
        s2_req_1_uop_fp_val = _RANDOM[8'h3E][23];	// dcache.scala:631:25
        s2_req_1_uop_fp_single = _RANDOM[8'h3E][24];	// dcache.scala:631:25
        s2_req_1_uop_xcpt_pf_if = _RANDOM[8'h3E][25];	// dcache.scala:631:25
        s2_req_1_uop_xcpt_ae_if = _RANDOM[8'h3E][26];	// dcache.scala:631:25
        s2_req_1_uop_xcpt_ma_if = _RANDOM[8'h3E][27];	// dcache.scala:631:25
        s2_req_1_uop_bp_debug_if = _RANDOM[8'h3E][28];	// dcache.scala:631:25
        s2_req_1_uop_bp_xcpt_if = _RANDOM[8'h3E][29];	// dcache.scala:631:25
        s2_req_1_uop_debug_fsrc = _RANDOM[8'h3E][31:30];	// dcache.scala:631:25
        s2_req_1_uop_debug_tsrc = _RANDOM[8'h3F][1:0];	// dcache.scala:631:25
        s2_req_1_addr = {_RANDOM[8'h3F][31:2], _RANDOM[8'h40][9:0]};	// dcache.scala:631:25
        s2_req_1_data = {_RANDOM[8'h40][31:10], _RANDOM[8'h41], _RANDOM[8'h42][9:0]};	// dcache.scala:631:25
        s2_req_1_is_hella = _RANDOM[8'h42][10];	// dcache.scala:631:25
        s2_type = _RANDOM[8'h42][13:11];	// dcache.scala:631:25, :632:25
        s2_valid_REG = _RANDOM[8'h42][14];	// dcache.scala:631:25, :634:26
        s2_valid_REG_1 = _RANDOM[8'h42][15];	// dcache.scala:631:25, :634:26
        s2_tag_match_way_0 = _RANDOM[8'h42][23:16];	// dcache.scala:631:25, :642:33
        s2_tag_match_way_1 = _RANDOM[8'h42][31:24];	// dcache.scala:631:25, :642:33
        s2_hit_state_REG_state = _RANDOM[8'h43][1:0];	// dcache.scala:644:93
        s2_hit_state_REG_1_state = _RANDOM[8'h43][3:2];	// dcache.scala:644:93
        s2_hit_state_REG_2_state = _RANDOM[8'h43][5:4];	// dcache.scala:644:93
        s2_hit_state_REG_3_state = _RANDOM[8'h43][7:6];	// dcache.scala:644:93
        s2_hit_state_REG_4_state = _RANDOM[8'h43][9:8];	// dcache.scala:644:93
        s2_hit_state_REG_5_state = _RANDOM[8'h43][11:10];	// dcache.scala:644:93
        s2_hit_state_REG_6_state = _RANDOM[8'h43][13:12];	// dcache.scala:644:93
        s2_hit_state_REG_7_state = _RANDOM[8'h43][15:14];	// dcache.scala:644:93
        s2_hit_state_REG_8_state = _RANDOM[8'h43][17:16];	// dcache.scala:644:93
        s2_hit_state_REG_9_state = _RANDOM[8'h43][19:18];	// dcache.scala:644:93
        s2_hit_state_REG_10_state = _RANDOM[8'h43][21:20];	// dcache.scala:644:93
        s2_hit_state_REG_11_state = _RANDOM[8'h43][23:22];	// dcache.scala:644:93
        s2_hit_state_REG_12_state = _RANDOM[8'h43][25:24];	// dcache.scala:644:93
        s2_hit_state_REG_13_state = _RANDOM[8'h43][27:26];	// dcache.scala:644:93
        s2_hit_state_REG_14_state = _RANDOM[8'h43][29:28];	// dcache.scala:644:93
        s2_hit_state_REG_15_state = _RANDOM[8'h43][31:30];	// dcache.scala:644:93
        s2_wb_idx_matches_0 = _RANDOM[8'h44][0];	// dcache.scala:653:34
        s2_wb_idx_matches_1 = _RANDOM[8'h44][1];	// dcache.scala:653:34
        debug_sc_fail_addr = {_RANDOM[8'h44][31:2], _RANDOM[8'h45][9:0]};	// dcache.scala:653:34, :656:35
        debug_sc_fail_cnt = _RANDOM[8'h45][17:10];	// dcache.scala:656:35, :657:35
        lrsc_count = _RANDOM[8'h45][24:18];	// dcache.scala:656:35, :659:27
        lrsc_addr = {_RANDOM[8'h45][31:25], _RANDOM[8'h46][26:0]};	// dcache.scala:656:35, :661:23
        s2_lr_REG = _RANDOM[8'h46][27];	// dcache.scala:661:23, :662:59
        s2_sc_REG = _RANDOM[8'h46][28];	// dcache.scala:661:23, :663:59
        s2_replaced_way_en_REG = _RANDOM[8'h46][31:29];	// dcache.scala:661:23, :717:44
        s2_repl_meta_REG_coh_state = _RANDOM[8'h47][1:0];	// dcache.scala:718:88
        s2_repl_meta_REG_tag = _RANDOM[8'h47][21:2];	// dcache.scala:718:88
        s2_repl_meta_REG_1_coh_state = _RANDOM[8'h47][23:22];	// dcache.scala:718:88
        s2_repl_meta_REG_1_tag = {_RANDOM[8'h47][31:24], _RANDOM[8'h48][11:0]};	// dcache.scala:718:88
        s2_repl_meta_REG_2_coh_state = _RANDOM[8'h48][13:12];	// dcache.scala:718:88
        s2_repl_meta_REG_2_tag = {_RANDOM[8'h48][31:14], _RANDOM[8'h49][1:0]};	// dcache.scala:718:88
        s2_repl_meta_REG_3_coh_state = _RANDOM[8'h49][3:2];	// dcache.scala:718:88
        s2_repl_meta_REG_3_tag = _RANDOM[8'h49][23:4];	// dcache.scala:718:88
        s2_repl_meta_REG_4_coh_state = _RANDOM[8'h49][25:24];	// dcache.scala:718:88
        s2_repl_meta_REG_4_tag = {_RANDOM[8'h49][31:26], _RANDOM[8'h4A][13:0]};	// dcache.scala:718:88
        s2_repl_meta_REG_5_coh_state = _RANDOM[8'h4A][15:14];	// dcache.scala:718:88
        s2_repl_meta_REG_5_tag = {_RANDOM[8'h4A][31:16], _RANDOM[8'h4B][3:0]};	// dcache.scala:718:88
        s2_repl_meta_REG_6_coh_state = _RANDOM[8'h4B][5:4];	// dcache.scala:718:88
        s2_repl_meta_REG_6_tag = _RANDOM[8'h4B][25:6];	// dcache.scala:718:88
        s2_repl_meta_REG_7_coh_state = _RANDOM[8'h4B][27:26];	// dcache.scala:718:88
        s2_repl_meta_REG_7_tag = {_RANDOM[8'h4B][31:28], _RANDOM[8'h4C][15:0]};	// dcache.scala:718:88
        s2_repl_meta_REG_8_coh_state = _RANDOM[8'h4C][17:16];	// dcache.scala:718:88
        s2_repl_meta_REG_8_tag = {_RANDOM[8'h4C][31:18], _RANDOM[8'h4D][5:0]};	// dcache.scala:718:88
        s2_repl_meta_REG_9_coh_state = _RANDOM[8'h4D][7:6];	// dcache.scala:718:88
        s2_repl_meta_REG_9_tag = _RANDOM[8'h4D][27:8];	// dcache.scala:718:88
        s2_repl_meta_REG_10_coh_state = _RANDOM[8'h4D][29:28];	// dcache.scala:718:88
        s2_repl_meta_REG_10_tag = {_RANDOM[8'h4D][31:30], _RANDOM[8'h4E][17:0]};	// dcache.scala:718:88
        s2_repl_meta_REG_11_coh_state = _RANDOM[8'h4E][19:18];	// dcache.scala:718:88
        s2_repl_meta_REG_11_tag = {_RANDOM[8'h4E][31:20], _RANDOM[8'h4F][7:0]};	// dcache.scala:718:88
        s2_repl_meta_REG_12_coh_state = _RANDOM[8'h4F][9:8];	// dcache.scala:718:88
        s2_repl_meta_REG_12_tag = _RANDOM[8'h4F][29:10];	// dcache.scala:718:88
        s2_repl_meta_REG_13_coh_state = _RANDOM[8'h4F][31:30];	// dcache.scala:718:88
        s2_repl_meta_REG_13_tag = _RANDOM[8'h50][19:0];	// dcache.scala:718:88
        s2_repl_meta_REG_14_coh_state = _RANDOM[8'h50][21:20];	// dcache.scala:718:88
        s2_repl_meta_REG_14_tag = {_RANDOM[8'h50][31:22], _RANDOM[8'h51][9:0]};	// dcache.scala:718:88
        s2_repl_meta_REG_15_coh_state = _RANDOM[8'h51][11:10];	// dcache.scala:718:88
        s2_repl_meta_REG_15_tag = _RANDOM[8'h51][31:12];	// dcache.scala:718:88
        s2_nack_hit_0 = _RANDOM[8'h52][0];	// dcache.scala:721:31
        s2_nack_hit_1 = _RANDOM[8'h52][1];	// dcache.scala:721:31
        s2_send_resp_REG = _RANDOM[8'h52][2];	// dcache.scala:721:31, :732:44
        s2_send_resp_REG_1 = _RANDOM[8'h52][3];	// dcache.scala:721:31, :732:44
        s2_send_nack_REG = _RANDOM[8'h52][4];	// dcache.scala:721:31, :734:44
        s2_send_nack_REG_1 = _RANDOM[8'h52][5];	// dcache.scala:721:31, :734:44
        mshrs_io_meta_resp_bits_REG_0_coh_state = _RANDOM[8'h52][7:6];	// dcache.scala:721:31, :772:70
        mshrs_io_meta_resp_bits_REG_1_coh_state = _RANDOM[8'h52][29:28];	// dcache.scala:721:31, :772:70
        mshrs_io_meta_resp_bits_REG_2_coh_state = _RANDOM[8'h53][19:18];	// dcache.scala:772:70
        mshrs_io_meta_resp_bits_REG_3_coh_state = _RANDOM[8'h54][9:8];	// dcache.scala:772:70
        mshrs_io_meta_resp_bits_REG_4_coh_state = _RANDOM[8'h54][31:30];	// dcache.scala:772:70
        mshrs_io_meta_resp_bits_REG_5_coh_state = _RANDOM[8'h55][21:20];	// dcache.scala:772:70
        mshrs_io_meta_resp_bits_REG_6_coh_state = _RANDOM[8'h56][11:10];	// dcache.scala:772:70
        mshrs_io_meta_resp_bits_REG_7_coh_state = _RANDOM[8'h57][1:0];	// dcache.scala:772:70
        beatsLeft = _RANDOM[8'h57][30:22];	// Arbiter.scala:87:30, dcache.scala:772:70
        state_0 = _RANDOM[8'h57][31];	// Arbiter.scala:116:26, dcache.scala:772:70
        state_1 = _RANDOM[8'h58][0];	// Arbiter.scala:116:26
        s3_req_addr = {_RANDOM[8'h65][31:20], _RANDOM[8'h66][27:0]};	// dcache.scala:869:25
        s3_req_data = {_RANDOM[8'h66][31:28], _RANDOM[8'h67], _RANDOM[8'h68][27:0]};	// dcache.scala:869:25
        s3_valid = _RANDOM[8'h68][29];	// dcache.scala:869:25, :870:25
        s4_req_addr = {_RANDOM[8'h75][31], _RANDOM[8'h76], _RANDOM[8'h77][6:0]};	// dcache.scala:879:25
        s4_req_data = {_RANDOM[8'h77][31:7], _RANDOM[8'h78], _RANDOM[8'h79][6:0]};	// dcache.scala:879:25
        s4_valid = _RANDOM[8'h79][8];	// dcache.scala:879:25, :880:25
        s5_req_addr = {_RANDOM[8'h86][31:10], _RANDOM[8'h87][17:0]};	// dcache.scala:881:25
        s5_req_data = {_RANDOM[8'h87][31:18], _RANDOM[8'h88], _RANDOM[8'h89][17:0]};	// dcache.scala:881:25
        s5_valid = _RANDOM[8'h89][19];	// dcache.scala:881:25, :882:25
        s3_way = _RANDOM[8'h89][27:20];	// dcache.scala:881:25, :903:25
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  BoomWritebackUnit wb (	// dcache.scala:430:18
    .clock                       (clock),
    .reset                       (reset),
    .io_req_valid                (_wbArb_io_out_valid),	// dcache.scala:804:21
    .io_req_bits_tag             (_wbArb_io_out_bits_tag),	// dcache.scala:804:21
    .io_req_bits_idx             (_wbArb_io_out_bits_idx),	// dcache.scala:804:21
    .io_req_bits_param           (_wbArb_io_out_bits_param),	// dcache.scala:804:21
    .io_req_bits_way_en          (_wbArb_io_out_bits_way_en),	// dcache.scala:804:21
    .io_req_bits_voluntary       (_wbArb_io_out_bits_voluntary),	// dcache.scala:804:21
    .io_meta_read_ready          (_wb_io_data_req_ready_T),	// dcache.scala:541:55
    .io_data_req_ready           (_wb_io_data_req_ready_T),	// dcache.scala:541:55
    .io_data_resp                (s2_data_word_prebypass_0),	// Mux.scala:27:72
    .io_mem_grant
      (tl_out_d_ready & auto_out_d_valid & _wb_io_mem_grant_T_1),	// dcache.scala:788:{30,48}, :790:20, :795:24, :811:44
    .io_release_ready            (auto_out_c_ready & (idle | state_0)),	// Arbiter.scala:88:28, :116:26, :121:24, :123:31
    .io_lsu_release_ready        (io_lsu_release_ready),
    .io_req_ready                (_wb_io_req_ready),
    .io_meta_read_valid          (_wb_io_meta_read_valid),
    .io_meta_read_bits_idx       (_wb_io_meta_read_bits_idx),
    .io_meta_read_bits_tag       (_wb_io_meta_read_bits_tag),
    .io_resp                     (_wb_io_resp),
    .io_idx_valid                (_wb_io_idx_valid),
    .io_idx_bits                 (_wb_io_idx_bits),
    .io_data_req_valid           (_wb_io_data_req_valid),
    .io_data_req_bits_way_en     (_wb_io_data_req_bits_way_en),
    .io_data_req_bits_addr       (_wb_io_data_req_bits_addr),
    .io_release_valid            (_wb_io_release_valid),
    .io_release_bits_opcode      (_wb_io_release_bits_opcode),
    .io_release_bits_param       (_wb_io_release_bits_param),
    .io_release_bits_address     (_wb_io_release_bits_address),
    .io_release_bits_data        (_wb_io_release_bits_data),
    .io_lsu_release_valid        (_wb_io_lsu_release_valid),
    .io_lsu_release_bits_address (_wb_io_lsu_release_bits_address)
  );
  BoomProbeUnit prober (	// dcache.scala:431:22
    .clock                             (clock),
    .reset                             (reset),
    .io_req_valid                      (auto_out_b_valid & ~(|(lrsc_count[6:2]))),	// dcache.scala:659:27, :660:31, :777:{43,46}
    .io_req_bits_param                 (auto_out_b_bits_param),
    .io_req_bits_size                  (auto_out_b_bits_size),
    .io_req_bits_source                (auto_out_b_bits_source),
    .io_req_bits_address               (auto_out_b_bits_address),
    .io_rep_ready
      (auto_out_c_ready & (idle ? ~_wb_io_release_valid : state_1)),	// Arbiter.scala:16:61, :88:28, :116:26, :121:24, :123:31, dcache.scala:430:18
    .io_meta_read_ready                (_metaReadArb_io_in_1_ready),	// dcache.scala:444:27
    .io_meta_write_ready               (_metaWriteArb_io_in_1_ready),	// dcache.scala:442:28
    .io_wb_req_ready                   (_wb_io_req_ready),	// dcache.scala:430:18
    .io_way_en                         (s2_tag_match_way_0),	// dcache.scala:642:33
    .io_wb_rdy
      (_prober_io_meta_write_bits_idx != _wb_io_idx_bits | ~_wb_io_idx_valid),	// dcache.scala:430:18, :431:22, :784:{59,79,82}
    .io_mshr_rdy                       (_mshrs_io_probe_rdy),	// dcache.scala:432:21
    .io_block_state_state              (mshrs_io_req_0_bits_old_meta_meta_coh_state),	// Mux.scala:27:72
    .io_lsu_release_ready              (_lsu_release_arb_io_in_1_ready),	// dcache.scala:813:31
    .io_req_ready                      (_prober_io_req_ready),
    .io_rep_valid                      (_prober_io_rep_valid),
    .io_rep_bits_param                 (_prober_io_rep_bits_param),
    .io_rep_bits_size                  (_prober_io_rep_bits_size),
    .io_rep_bits_source                (_prober_io_rep_bits_source),
    .io_rep_bits_address               (_prober_io_rep_bits_address),
    .io_meta_read_valid                (_prober_io_meta_read_valid),
    .io_meta_read_bits_idx             (_prober_io_meta_read_bits_idx),
    .io_meta_read_bits_tag             (_prober_io_meta_read_bits_tag),
    .io_meta_write_valid               (_prober_io_meta_write_valid),
    .io_meta_write_bits_idx            (_prober_io_meta_write_bits_idx),
    .io_meta_write_bits_way_en         (_prober_io_meta_write_bits_way_en),
    .io_meta_write_bits_data_coh_state (_prober_io_meta_write_bits_data_coh_state),
    .io_meta_write_bits_data_tag       (_prober_io_meta_write_bits_data_tag),
    .io_wb_req_valid                   (_prober_io_wb_req_valid),
    .io_wb_req_bits_tag                (_prober_io_wb_req_bits_tag),
    .io_wb_req_bits_idx                (_prober_io_wb_req_bits_idx),
    .io_wb_req_bits_param              (_prober_io_wb_req_bits_param),
    .io_wb_req_bits_way_en             (_prober_io_wb_req_bits_way_en),
    .io_mshr_wb_rdy                    (_prober_io_mshr_wb_rdy),
    .io_lsu_release_valid              (_prober_io_lsu_release_valid),
    .io_lsu_release_bits_address       (_prober_io_lsu_release_bits_address),
    .io_state_valid                    (_prober_io_state_valid),
    .io_state_bits                     (_prober_io_state_bits)
  );
  BoomMSHRFile mshrs (	// dcache.scala:432:21
    .clock                              (clock),
    .reset                              (reset),
    .io_req_0_valid                     (_mshrs_io_req_0_valid_T_72),	// dcache.scala:753:77
    .io_req_0_bits_uop_uopc             (s2_req_0_uop_uopc),	// dcache.scala:631:25
    .io_req_0_bits_uop_inst             (s2_req_0_uop_inst),	// dcache.scala:631:25
    .io_req_0_bits_uop_debug_inst       (s2_req_0_uop_debug_inst),	// dcache.scala:631:25
    .io_req_0_bits_uop_is_rvc           (s2_req_0_uop_is_rvc),	// dcache.scala:631:25
    .io_req_0_bits_uop_debug_pc         (s2_req_0_uop_debug_pc),	// dcache.scala:631:25
    .io_req_0_bits_uop_iq_type          (s2_req_0_uop_iq_type),	// dcache.scala:631:25
    .io_req_0_bits_uop_fu_code          (s2_req_0_uop_fu_code),	// dcache.scala:631:25
    .io_req_0_bits_uop_ctrl_br_type     (s2_req_0_uop_ctrl_br_type),	// dcache.scala:631:25
    .io_req_0_bits_uop_ctrl_op1_sel     (s2_req_0_uop_ctrl_op1_sel),	// dcache.scala:631:25
    .io_req_0_bits_uop_ctrl_op2_sel     (s2_req_0_uop_ctrl_op2_sel),	// dcache.scala:631:25
    .io_req_0_bits_uop_ctrl_imm_sel     (s2_req_0_uop_ctrl_imm_sel),	// dcache.scala:631:25
    .io_req_0_bits_uop_ctrl_op_fcn      (s2_req_0_uop_ctrl_op_fcn),	// dcache.scala:631:25
    .io_req_0_bits_uop_ctrl_fcn_dw      (s2_req_0_uop_ctrl_fcn_dw),	// dcache.scala:631:25
    .io_req_0_bits_uop_ctrl_csr_cmd     (s2_req_0_uop_ctrl_csr_cmd),	// dcache.scala:631:25
    .io_req_0_bits_uop_ctrl_is_load     (s2_req_0_uop_ctrl_is_load),	// dcache.scala:631:25
    .io_req_0_bits_uop_ctrl_is_sta      (s2_req_0_uop_ctrl_is_sta),	// dcache.scala:631:25
    .io_req_0_bits_uop_ctrl_is_std      (s2_req_0_uop_ctrl_is_std),	// dcache.scala:631:25
    .io_req_0_bits_uop_iw_state         (s2_req_0_uop_iw_state),	// dcache.scala:631:25
    .io_req_0_bits_uop_iw_p1_poisoned   (s2_req_0_uop_iw_p1_poisoned),	// dcache.scala:631:25
    .io_req_0_bits_uop_iw_p2_poisoned   (s2_req_0_uop_iw_p2_poisoned),	// dcache.scala:631:25
    .io_req_0_bits_uop_is_br            (s2_req_0_uop_is_br),	// dcache.scala:631:25
    .io_req_0_bits_uop_is_jalr          (s2_req_0_uop_is_jalr),	// dcache.scala:631:25
    .io_req_0_bits_uop_is_jal           (s2_req_0_uop_is_jal),	// dcache.scala:631:25
    .io_req_0_bits_uop_is_sfb           (s2_req_0_uop_is_sfb),	// dcache.scala:631:25
    .io_req_0_bits_uop_br_mask
      (s2_req_0_uop_br_mask & ~io_lsu_brupdate_b1_resolve_mask),	// dcache.scala:631:25, util.scala:85:{25,27}
    .io_req_0_bits_uop_br_tag           (s2_req_0_uop_br_tag),	// dcache.scala:631:25
    .io_req_0_bits_uop_ftq_idx          (s2_req_0_uop_ftq_idx),	// dcache.scala:631:25
    .io_req_0_bits_uop_edge_inst        (s2_req_0_uop_edge_inst),	// dcache.scala:631:25
    .io_req_0_bits_uop_pc_lob           (s2_req_0_uop_pc_lob),	// dcache.scala:631:25
    .io_req_0_bits_uop_taken            (s2_req_0_uop_taken),	// dcache.scala:631:25
    .io_req_0_bits_uop_imm_packed       (s2_req_0_uop_imm_packed),	// dcache.scala:631:25
    .io_req_0_bits_uop_csr_addr         (s2_req_0_uop_csr_addr),	// dcache.scala:631:25
    .io_req_0_bits_uop_rob_idx          (s2_req_0_uop_rob_idx),	// dcache.scala:631:25
    .io_req_0_bits_uop_ldq_idx          (s2_req_0_uop_ldq_idx),	// dcache.scala:631:25
    .io_req_0_bits_uop_stq_idx          (s2_req_0_uop_stq_idx),	// dcache.scala:631:25
    .io_req_0_bits_uop_rxq_idx          (s2_req_0_uop_rxq_idx),	// dcache.scala:631:25
    .io_req_0_bits_uop_pdst             (s2_req_0_uop_pdst),	// dcache.scala:631:25
    .io_req_0_bits_uop_prs1             (s2_req_0_uop_prs1),	// dcache.scala:631:25
    .io_req_0_bits_uop_prs2             (s2_req_0_uop_prs2),	// dcache.scala:631:25
    .io_req_0_bits_uop_prs3             (s2_req_0_uop_prs3),	// dcache.scala:631:25
    .io_req_0_bits_uop_ppred            (s2_req_0_uop_ppred),	// dcache.scala:631:25
    .io_req_0_bits_uop_prs1_busy        (s2_req_0_uop_prs1_busy),	// dcache.scala:631:25
    .io_req_0_bits_uop_prs2_busy        (s2_req_0_uop_prs2_busy),	// dcache.scala:631:25
    .io_req_0_bits_uop_prs3_busy        (s2_req_0_uop_prs3_busy),	// dcache.scala:631:25
    .io_req_0_bits_uop_ppred_busy       (s2_req_0_uop_ppred_busy),	// dcache.scala:631:25
    .io_req_0_bits_uop_stale_pdst       (s2_req_0_uop_stale_pdst),	// dcache.scala:631:25
    .io_req_0_bits_uop_exception        (s2_req_0_uop_exception),	// dcache.scala:631:25
    .io_req_0_bits_uop_exc_cause        (s2_req_0_uop_exc_cause),	// dcache.scala:631:25
    .io_req_0_bits_uop_bypassable       (s2_req_0_uop_bypassable),	// dcache.scala:631:25
    .io_req_0_bits_uop_mem_cmd          (s2_req_0_uop_mem_cmd),	// dcache.scala:631:25
    .io_req_0_bits_uop_mem_size         (size),	// dcache.scala:631:25
    .io_req_0_bits_uop_mem_signed       (s2_req_0_uop_mem_signed),	// dcache.scala:631:25
    .io_req_0_bits_uop_is_fence         (s2_req_0_uop_is_fence),	// dcache.scala:631:25
    .io_req_0_bits_uop_is_fencei        (s2_req_0_uop_is_fencei),	// dcache.scala:631:25
    .io_req_0_bits_uop_is_amo           (s2_req_0_uop_is_amo),	// dcache.scala:631:25
    .io_req_0_bits_uop_uses_ldq         (s2_req_0_uop_uses_ldq),	// dcache.scala:631:25
    .io_req_0_bits_uop_uses_stq         (s2_req_0_uop_uses_stq),	// dcache.scala:631:25
    .io_req_0_bits_uop_is_sys_pc2epc    (s2_req_0_uop_is_sys_pc2epc),	// dcache.scala:631:25
    .io_req_0_bits_uop_is_unique        (s2_req_0_uop_is_unique),	// dcache.scala:631:25
    .io_req_0_bits_uop_flush_on_commit  (s2_req_0_uop_flush_on_commit),	// dcache.scala:631:25
    .io_req_0_bits_uop_ldst_is_rs1      (s2_req_0_uop_ldst_is_rs1),	// dcache.scala:631:25
    .io_req_0_bits_uop_ldst             (s2_req_0_uop_ldst),	// dcache.scala:631:25
    .io_req_0_bits_uop_lrs1             (s2_req_0_uop_lrs1),	// dcache.scala:631:25
    .io_req_0_bits_uop_lrs2             (s2_req_0_uop_lrs2),	// dcache.scala:631:25
    .io_req_0_bits_uop_lrs3             (s2_req_0_uop_lrs3),	// dcache.scala:631:25
    .io_req_0_bits_uop_ldst_val         (s2_req_0_uop_ldst_val),	// dcache.scala:631:25
    .io_req_0_bits_uop_dst_rtype        (s2_req_0_uop_dst_rtype),	// dcache.scala:631:25
    .io_req_0_bits_uop_lrs1_rtype       (s2_req_0_uop_lrs1_rtype),	// dcache.scala:631:25
    .io_req_0_bits_uop_lrs2_rtype       (s2_req_0_uop_lrs2_rtype),	// dcache.scala:631:25
    .io_req_0_bits_uop_frs3_en          (s2_req_0_uop_frs3_en),	// dcache.scala:631:25
    .io_req_0_bits_uop_fp_val           (s2_req_0_uop_fp_val),	// dcache.scala:631:25
    .io_req_0_bits_uop_fp_single        (s2_req_0_uop_fp_single),	// dcache.scala:631:25
    .io_req_0_bits_uop_xcpt_pf_if       (s2_req_0_uop_xcpt_pf_if),	// dcache.scala:631:25
    .io_req_0_bits_uop_xcpt_ae_if       (s2_req_0_uop_xcpt_ae_if),	// dcache.scala:631:25
    .io_req_0_bits_uop_xcpt_ma_if       (s2_req_0_uop_xcpt_ma_if),	// dcache.scala:631:25
    .io_req_0_bits_uop_bp_debug_if      (s2_req_0_uop_bp_debug_if),	// dcache.scala:631:25
    .io_req_0_bits_uop_bp_xcpt_if       (s2_req_0_uop_bp_xcpt_if),	// dcache.scala:631:25
    .io_req_0_bits_uop_debug_fsrc       (s2_req_0_uop_debug_fsrc),	// dcache.scala:631:25
    .io_req_0_bits_uop_debug_tsrc       (s2_req_0_uop_debug_tsrc),	// dcache.scala:631:25
    .io_req_0_bits_addr                 (s2_req_0_addr),	// dcache.scala:631:25
    .io_req_0_bits_data                 (s2_req_0_data),	// dcache.scala:631:25
    .io_req_0_bits_is_hella             (s2_req_0_is_hella),	// dcache.scala:631:25
    .io_req_0_bits_tag_match            (|s2_tag_match_way_0),	// dcache.scala:642:33, :643:49
    .io_req_0_bits_old_meta_coh_state
      ((|s2_tag_match_way_0)
         ? mshrs_io_req_0_bits_old_meta_meta_coh_state
         : (_s2_repl_meta_T_38 ? s2_repl_meta_REG_coh_state : 2'h0)
           | (_s2_repl_meta_T_39 ? s2_repl_meta_REG_1_coh_state : 2'h0)
           | (_s2_repl_meta_T_40 ? s2_repl_meta_REG_2_coh_state : 2'h0)
           | (_s2_repl_meta_T_41 ? s2_repl_meta_REG_3_coh_state : 2'h0)
           | (_s2_repl_meta_T_42 ? s2_repl_meta_REG_4_coh_state : 2'h0)
           | (_s2_repl_meta_T_43 ? s2_repl_meta_REG_5_coh_state : 2'h0)
           | (_s2_repl_meta_T_44 ? s2_repl_meta_REG_6_coh_state : 2'h0)
           | ((&s2_replaced_way_en_REG) ? s2_repl_meta_REG_7_coh_state : 2'h0)),	// Mux.scala:27:72, :29:36, dcache.scala:432:21, :567:27, :642:33, :643:49, :717:44, :718:88, :763:44
    .io_req_0_bits_old_meta_tag
      ((_s2_repl_meta_T_38 ? s2_repl_meta_REG_tag : 20'h0)
       | (_s2_repl_meta_T_39 ? s2_repl_meta_REG_1_tag : 20'h0)
       | (_s2_repl_meta_T_40 ? s2_repl_meta_REG_2_tag : 20'h0)
       | (_s2_repl_meta_T_41 ? s2_repl_meta_REG_3_tag : 20'h0)
       | (_s2_repl_meta_T_42 ? s2_repl_meta_REG_4_tag : 20'h0)
       | (_s2_repl_meta_T_43 ? s2_repl_meta_REG_5_tag : 20'h0)
       | (_s2_repl_meta_T_44 ? s2_repl_meta_REG_6_tag : 20'h0)
       | ((&s2_replaced_way_en_REG) ? s2_repl_meta_REG_7_tag : 20'h0)),	// Mux.scala:27:72, :29:36, dcache.scala:431:22, :432:21, :441:41, :442:28, :444:27, :567:27, :717:44, :718:88
    .io_req_0_bits_way_en
      ((|s2_tag_match_way_0) ? s2_tag_match_way_0 : s2_replaced_way_en),	// OneHot.scala:58:35, dcache.scala:642:33, :643:49, :764:44
    .io_req_1_valid                     (_mshrs_io_req_1_valid_T_72),	// dcache.scala:753:77
    .io_req_1_bits_uop_uopc             (s2_req_1_uop_uopc),	// dcache.scala:631:25
    .io_req_1_bits_uop_inst             (s2_req_1_uop_inst),	// dcache.scala:631:25
    .io_req_1_bits_uop_debug_inst       (s2_req_1_uop_debug_inst),	// dcache.scala:631:25
    .io_req_1_bits_uop_is_rvc           (s2_req_1_uop_is_rvc),	// dcache.scala:631:25
    .io_req_1_bits_uop_debug_pc         (s2_req_1_uop_debug_pc),	// dcache.scala:631:25
    .io_req_1_bits_uop_iq_type          (s2_req_1_uop_iq_type),	// dcache.scala:631:25
    .io_req_1_bits_uop_fu_code          (s2_req_1_uop_fu_code),	// dcache.scala:631:25
    .io_req_1_bits_uop_ctrl_br_type     (s2_req_1_uop_ctrl_br_type),	// dcache.scala:631:25
    .io_req_1_bits_uop_ctrl_op1_sel     (s2_req_1_uop_ctrl_op1_sel),	// dcache.scala:631:25
    .io_req_1_bits_uop_ctrl_op2_sel     (s2_req_1_uop_ctrl_op2_sel),	// dcache.scala:631:25
    .io_req_1_bits_uop_ctrl_imm_sel     (s2_req_1_uop_ctrl_imm_sel),	// dcache.scala:631:25
    .io_req_1_bits_uop_ctrl_op_fcn      (s2_req_1_uop_ctrl_op_fcn),	// dcache.scala:631:25
    .io_req_1_bits_uop_ctrl_fcn_dw      (s2_req_1_uop_ctrl_fcn_dw),	// dcache.scala:631:25
    .io_req_1_bits_uop_ctrl_csr_cmd     (s2_req_1_uop_ctrl_csr_cmd),	// dcache.scala:631:25
    .io_req_1_bits_uop_ctrl_is_load     (s2_req_1_uop_ctrl_is_load),	// dcache.scala:631:25
    .io_req_1_bits_uop_ctrl_is_sta      (s2_req_1_uop_ctrl_is_sta),	// dcache.scala:631:25
    .io_req_1_bits_uop_ctrl_is_std      (s2_req_1_uop_ctrl_is_std),	// dcache.scala:631:25
    .io_req_1_bits_uop_iw_state         (s2_req_1_uop_iw_state),	// dcache.scala:631:25
    .io_req_1_bits_uop_iw_p1_poisoned   (s2_req_1_uop_iw_p1_poisoned),	// dcache.scala:631:25
    .io_req_1_bits_uop_iw_p2_poisoned   (s2_req_1_uop_iw_p2_poisoned),	// dcache.scala:631:25
    .io_req_1_bits_uop_is_br            (s2_req_1_uop_is_br),	// dcache.scala:631:25
    .io_req_1_bits_uop_is_jalr          (s2_req_1_uop_is_jalr),	// dcache.scala:631:25
    .io_req_1_bits_uop_is_jal           (s2_req_1_uop_is_jal),	// dcache.scala:631:25
    .io_req_1_bits_uop_is_sfb           (s2_req_1_uop_is_sfb),	// dcache.scala:631:25
    .io_req_1_bits_uop_br_mask
      (s2_req_1_uop_br_mask & ~io_lsu_brupdate_b1_resolve_mask),	// dcache.scala:631:25, util.scala:85:{25,27}
    .io_req_1_bits_uop_br_tag           (s2_req_1_uop_br_tag),	// dcache.scala:631:25
    .io_req_1_bits_uop_ftq_idx          (s2_req_1_uop_ftq_idx),	// dcache.scala:631:25
    .io_req_1_bits_uop_edge_inst        (s2_req_1_uop_edge_inst),	// dcache.scala:631:25
    .io_req_1_bits_uop_pc_lob           (s2_req_1_uop_pc_lob),	// dcache.scala:631:25
    .io_req_1_bits_uop_taken            (s2_req_1_uop_taken),	// dcache.scala:631:25
    .io_req_1_bits_uop_imm_packed       (s2_req_1_uop_imm_packed),	// dcache.scala:631:25
    .io_req_1_bits_uop_csr_addr         (s2_req_1_uop_csr_addr),	// dcache.scala:631:25
    .io_req_1_bits_uop_rob_idx          (s2_req_1_uop_rob_idx),	// dcache.scala:631:25
    .io_req_1_bits_uop_ldq_idx          (s2_req_1_uop_ldq_idx),	// dcache.scala:631:25
    .io_req_1_bits_uop_stq_idx          (s2_req_1_uop_stq_idx),	// dcache.scala:631:25
    .io_req_1_bits_uop_rxq_idx          (s2_req_1_uop_rxq_idx),	// dcache.scala:631:25
    .io_req_1_bits_uop_pdst             (s2_req_1_uop_pdst),	// dcache.scala:631:25
    .io_req_1_bits_uop_prs1             (s2_req_1_uop_prs1),	// dcache.scala:631:25
    .io_req_1_bits_uop_prs2             (s2_req_1_uop_prs2),	// dcache.scala:631:25
    .io_req_1_bits_uop_prs3             (s2_req_1_uop_prs3),	// dcache.scala:631:25
    .io_req_1_bits_uop_ppred            (s2_req_1_uop_ppred),	// dcache.scala:631:25
    .io_req_1_bits_uop_prs1_busy        (s2_req_1_uop_prs1_busy),	// dcache.scala:631:25
    .io_req_1_bits_uop_prs2_busy        (s2_req_1_uop_prs2_busy),	// dcache.scala:631:25
    .io_req_1_bits_uop_prs3_busy        (s2_req_1_uop_prs3_busy),	// dcache.scala:631:25
    .io_req_1_bits_uop_ppred_busy       (s2_req_1_uop_ppred_busy),	// dcache.scala:631:25
    .io_req_1_bits_uop_stale_pdst       (s2_req_1_uop_stale_pdst),	// dcache.scala:631:25
    .io_req_1_bits_uop_exception        (s2_req_1_uop_exception),	// dcache.scala:631:25
    .io_req_1_bits_uop_exc_cause        (s2_req_1_uop_exc_cause),	// dcache.scala:631:25
    .io_req_1_bits_uop_bypassable       (s2_req_1_uop_bypassable),	// dcache.scala:631:25
    .io_req_1_bits_uop_mem_cmd          (s2_req_1_uop_mem_cmd),	// dcache.scala:631:25
    .io_req_1_bits_uop_mem_size         (size_1),	// dcache.scala:631:25
    .io_req_1_bits_uop_mem_signed       (s2_req_1_uop_mem_signed),	// dcache.scala:631:25
    .io_req_1_bits_uop_is_fence         (s2_req_1_uop_is_fence),	// dcache.scala:631:25
    .io_req_1_bits_uop_is_fencei        (s2_req_1_uop_is_fencei),	// dcache.scala:631:25
    .io_req_1_bits_uop_is_amo           (s2_req_1_uop_is_amo),	// dcache.scala:631:25
    .io_req_1_bits_uop_uses_ldq         (s2_req_1_uop_uses_ldq),	// dcache.scala:631:25
    .io_req_1_bits_uop_uses_stq         (s2_req_1_uop_uses_stq),	// dcache.scala:631:25
    .io_req_1_bits_uop_is_sys_pc2epc    (s2_req_1_uop_is_sys_pc2epc),	// dcache.scala:631:25
    .io_req_1_bits_uop_is_unique        (s2_req_1_uop_is_unique),	// dcache.scala:631:25
    .io_req_1_bits_uop_flush_on_commit  (s2_req_1_uop_flush_on_commit),	// dcache.scala:631:25
    .io_req_1_bits_uop_ldst_is_rs1      (s2_req_1_uop_ldst_is_rs1),	// dcache.scala:631:25
    .io_req_1_bits_uop_ldst             (s2_req_1_uop_ldst),	// dcache.scala:631:25
    .io_req_1_bits_uop_lrs1             (s2_req_1_uop_lrs1),	// dcache.scala:631:25
    .io_req_1_bits_uop_lrs2             (s2_req_1_uop_lrs2),	// dcache.scala:631:25
    .io_req_1_bits_uop_lrs3             (s2_req_1_uop_lrs3),	// dcache.scala:631:25
    .io_req_1_bits_uop_ldst_val         (s2_req_1_uop_ldst_val),	// dcache.scala:631:25
    .io_req_1_bits_uop_dst_rtype        (s2_req_1_uop_dst_rtype),	// dcache.scala:631:25
    .io_req_1_bits_uop_lrs1_rtype       (s2_req_1_uop_lrs1_rtype),	// dcache.scala:631:25
    .io_req_1_bits_uop_lrs2_rtype       (s2_req_1_uop_lrs2_rtype),	// dcache.scala:631:25
    .io_req_1_bits_uop_frs3_en          (s2_req_1_uop_frs3_en),	// dcache.scala:631:25
    .io_req_1_bits_uop_fp_val           (s2_req_1_uop_fp_val),	// dcache.scala:631:25
    .io_req_1_bits_uop_fp_single        (s2_req_1_uop_fp_single),	// dcache.scala:631:25
    .io_req_1_bits_uop_xcpt_pf_if       (s2_req_1_uop_xcpt_pf_if),	// dcache.scala:631:25
    .io_req_1_bits_uop_xcpt_ae_if       (s2_req_1_uop_xcpt_ae_if),	// dcache.scala:631:25
    .io_req_1_bits_uop_xcpt_ma_if       (s2_req_1_uop_xcpt_ma_if),	// dcache.scala:631:25
    .io_req_1_bits_uop_bp_debug_if      (s2_req_1_uop_bp_debug_if),	// dcache.scala:631:25
    .io_req_1_bits_uop_bp_xcpt_if       (s2_req_1_uop_bp_xcpt_if),	// dcache.scala:631:25
    .io_req_1_bits_uop_debug_fsrc       (s2_req_1_uop_debug_fsrc),	// dcache.scala:631:25
    .io_req_1_bits_uop_debug_tsrc       (s2_req_1_uop_debug_tsrc),	// dcache.scala:631:25
    .io_req_1_bits_addr                 (s2_req_1_addr),	// dcache.scala:631:25
    .io_req_1_bits_data                 (s2_req_1_data),	// dcache.scala:631:25
    .io_req_1_bits_is_hella             (s2_req_1_is_hella),	// dcache.scala:631:25
    .io_req_1_bits_tag_match            (|s2_tag_match_way_1),	// dcache.scala:642:33, :643:49
    .io_req_1_bits_old_meta_coh_state
      ((|s2_tag_match_way_1)
         ? mshrs_io_req_1_bits_old_meta_meta_coh_state
         : (_s2_repl_meta_T_38 ? s2_repl_meta_REG_8_coh_state : 2'h0)
           | (_s2_repl_meta_T_39 ? s2_repl_meta_REG_9_coh_state : 2'h0)
           | (_s2_repl_meta_T_40 ? s2_repl_meta_REG_10_coh_state : 2'h0)
           | (_s2_repl_meta_T_41 ? s2_repl_meta_REG_11_coh_state : 2'h0)
           | (_s2_repl_meta_T_42 ? s2_repl_meta_REG_12_coh_state : 2'h0)
           | (_s2_repl_meta_T_43 ? s2_repl_meta_REG_13_coh_state : 2'h0)
           | (_s2_repl_meta_T_44 ? s2_repl_meta_REG_14_coh_state : 2'h0)
           | ((&s2_replaced_way_en_REG) ? s2_repl_meta_REG_15_coh_state : 2'h0)),	// Mux.scala:27:72, :29:36, dcache.scala:432:21, :567:27, :642:33, :643:49, :717:44, :718:88, :763:44
    .io_req_1_bits_old_meta_tag
      ((_s2_repl_meta_T_38 ? s2_repl_meta_REG_8_tag : 20'h0)
       | (_s2_repl_meta_T_39 ? s2_repl_meta_REG_9_tag : 20'h0)
       | (_s2_repl_meta_T_40 ? s2_repl_meta_REG_10_tag : 20'h0)
       | (_s2_repl_meta_T_41 ? s2_repl_meta_REG_11_tag : 20'h0)
       | (_s2_repl_meta_T_42 ? s2_repl_meta_REG_12_tag : 20'h0)
       | (_s2_repl_meta_T_43 ? s2_repl_meta_REG_13_tag : 20'h0)
       | (_s2_repl_meta_T_44 ? s2_repl_meta_REG_14_tag : 20'h0)
       | ((&s2_replaced_way_en_REG) ? s2_repl_meta_REG_15_tag : 20'h0)),	// Mux.scala:27:72, :29:36, dcache.scala:431:22, :432:21, :441:41, :442:28, :444:27, :567:27, :717:44, :718:88
    .io_req_1_bits_way_en
      ((|s2_tag_match_way_1) ? s2_tag_match_way_1 : s2_replaced_way_en),	// OneHot.scala:58:35, dcache.scala:642:33, :643:49, :764:44
    .io_req_is_probe_0                  (_mshrs_io_req_is_probe_1_T & s2_valid_REG),	// dcache.scala:634:26, :768:{49,61}
    .io_req_is_probe_1                  (_mshrs_io_req_is_probe_1_T & s2_valid_REG_1),	// dcache.scala:634:26, :768:{49,61}
    .io_resp_ready                      (~(cache_resp_0_valid & cache_resp_1_valid)),	// dcache.scala:834:48, :843:{26,60}
    .io_brupdate_b1_resolve_mask        (io_lsu_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask     (io_lsu_brupdate_b1_mispredict_mask),
    .io_exception                       (io_lsu_exception),
    .io_mem_acquire_ready               (auto_out_a_ready),
    .io_mem_grant_valid                 (~_wb_io_mem_grant_T_1 & auto_out_d_valid),	// dcache.scala:788:{30,48}, :791:30, :795:24
    .io_mem_grant_bits_opcode           (auto_out_d_bits_opcode),
    .io_mem_grant_bits_param            (auto_out_d_bits_param),
    .io_mem_grant_bits_size             (auto_out_d_bits_size),
    .io_mem_grant_bits_source           (auto_out_d_bits_source),
    .io_mem_grant_bits_sink             (auto_out_d_bits_sink),
    .io_mem_grant_bits_data             (auto_out_d_bits_data),
    .io_mem_finish_ready                (auto_out_e_ready),
    .io_refill_ready                    (_dataWriteArb_io_in_1_ready),	// dcache.scala:460:28
    .io_meta_write_ready                (_metaWriteArb_io_out_ready_T),	// dcache.scala:456:67
    .io_meta_read_ready                 (_metaReadArb_io_in_3_ready),	// dcache.scala:444:27
    .io_meta_resp_valid                 (~s2_nack_hit_0 | _prober_io_mshr_wb_rdy),	// dcache.scala:431:22, :721:31, :747:29, :771:52
    .io_meta_resp_bits_coh_state
      ((s2_tag_match_way_0[0] ? mshrs_io_meta_resp_bits_REG_0_coh_state : 2'h0)
       | (s2_tag_match_way_0[1] ? mshrs_io_meta_resp_bits_REG_1_coh_state : 2'h0)
       | (s2_tag_match_way_0[2] ? mshrs_io_meta_resp_bits_REG_2_coh_state : 2'h0)
       | (s2_tag_match_way_0[3] ? mshrs_io_meta_resp_bits_REG_3_coh_state : 2'h0)
       | (s2_tag_match_way_0[4] ? mshrs_io_meta_resp_bits_REG_4_coh_state : 2'h0)
       | (s2_tag_match_way_0[5] ? mshrs_io_meta_resp_bits_REG_5_coh_state : 2'h0)
       | (s2_tag_match_way_0[6] ? mshrs_io_meta_resp_bits_REG_6_coh_state : 2'h0)
       | (s2_tag_match_way_0[7] ? mshrs_io_meta_resp_bits_REG_7_coh_state : 2'h0)),	// Mux.scala:27:72, :29:36, dcache.scala:432:21, :567:27, :642:33, :772:70
    .io_replay_ready                    (_metaReadArb_io_out_ready_T),	// dcache.scala:455:66
    .io_prefetch_ready                  (_metaReadArb_io_in_5_ready),	// dcache.scala:444:27
    .io_wb_req_ready                    (_wbArb_io_in_1_ready),	// dcache.scala:804:21
    .io_prober_state_valid              (_prober_io_state_valid),	// dcache.scala:431:22
    .io_prober_state_bits               (_prober_io_state_bits),	// dcache.scala:431:22
    .io_clear_all                       (io_lsu_force_order),
    .io_wb_resp                         (_wb_io_resp),	// dcache.scala:430:18
    .io_req_0_ready                     (_mshrs_io_req_0_ready),
    .io_req_1_ready                     (_mshrs_io_req_1_ready),
    .io_resp_valid                      (_mshrs_io_resp_valid),
    .io_resp_bits_uop_br_mask           (_mshrs_io_resp_bits_uop_br_mask),
    .io_resp_bits_uop_ldq_idx           (_mshrs_io_resp_bits_uop_ldq_idx),
    .io_resp_bits_uop_stq_idx           (_mshrs_io_resp_bits_uop_stq_idx),
    .io_resp_bits_uop_is_amo            (_mshrs_io_resp_bits_uop_is_amo),
    .io_resp_bits_uop_uses_ldq          (_mshrs_io_resp_bits_uop_uses_ldq),
    .io_resp_bits_uop_uses_stq          (_mshrs_io_resp_bits_uop_uses_stq),
    .io_resp_bits_data                  (_mshrs_io_resp_bits_data),
    .io_resp_bits_is_hella              (_mshrs_io_resp_bits_is_hella),
    .io_secondary_miss_0                (_mshrs_io_secondary_miss_0),
    .io_secondary_miss_1                (_mshrs_io_secondary_miss_1),
    .io_block_hit_0                     (_mshrs_io_block_hit_0),
    .io_block_hit_1                     (_mshrs_io_block_hit_1),
    .io_mem_acquire_valid               (auto_out_a_valid),
    .io_mem_acquire_bits_opcode         (auto_out_a_bits_opcode),
    .io_mem_acquire_bits_param          (auto_out_a_bits_param),
    .io_mem_acquire_bits_size           (auto_out_a_bits_size),
    .io_mem_acquire_bits_source         (auto_out_a_bits_source),
    .io_mem_acquire_bits_address        (auto_out_a_bits_address),
    .io_mem_acquire_bits_mask           (auto_out_a_bits_mask),
    .io_mem_acquire_bits_data           (auto_out_a_bits_data),
    .io_mem_grant_ready                 (_mshrs_io_mem_grant_ready),
    .io_mem_finish_valid                (auto_out_e_valid),
    .io_mem_finish_bits_sink            (auto_out_e_bits_sink),
    .io_refill_valid                    (_mshrs_io_refill_valid),
    .io_refill_bits_way_en              (_mshrs_io_refill_bits_way_en),
    .io_refill_bits_addr                (_mshrs_io_refill_bits_addr),
    .io_refill_bits_data                (_mshrs_io_refill_bits_data),
    .io_meta_write_valid                (_mshrs_io_meta_write_valid),
    .io_meta_write_bits_idx             (_mshrs_io_meta_write_bits_idx),
    .io_meta_write_bits_way_en          (_mshrs_io_meta_write_bits_way_en),
    .io_meta_write_bits_data_coh_state  (_mshrs_io_meta_write_bits_data_coh_state),
    .io_meta_write_bits_data_tag        (_mshrs_io_meta_write_bits_data_tag),
    .io_meta_read_valid                 (_mshrs_io_meta_read_valid),
    .io_meta_read_bits_idx              (_mshrs_io_meta_read_bits_idx),
    .io_meta_read_bits_way_en           (_mshrs_io_meta_read_bits_way_en),
    .io_meta_read_bits_tag              (_mshrs_io_meta_read_bits_tag),
    .io_replay_valid                    (_mshrs_io_replay_valid),
    .io_replay_bits_uop_uopc            (_mshrs_io_replay_bits_uop_uopc),
    .io_replay_bits_uop_inst            (_mshrs_io_replay_bits_uop_inst),
    .io_replay_bits_uop_debug_inst      (_mshrs_io_replay_bits_uop_debug_inst),
    .io_replay_bits_uop_is_rvc          (_mshrs_io_replay_bits_uop_is_rvc),
    .io_replay_bits_uop_debug_pc        (_mshrs_io_replay_bits_uop_debug_pc),
    .io_replay_bits_uop_iq_type         (_mshrs_io_replay_bits_uop_iq_type),
    .io_replay_bits_uop_fu_code         (_mshrs_io_replay_bits_uop_fu_code),
    .io_replay_bits_uop_ctrl_br_type    (_mshrs_io_replay_bits_uop_ctrl_br_type),
    .io_replay_bits_uop_ctrl_op1_sel    (_mshrs_io_replay_bits_uop_ctrl_op1_sel),
    .io_replay_bits_uop_ctrl_op2_sel    (_mshrs_io_replay_bits_uop_ctrl_op2_sel),
    .io_replay_bits_uop_ctrl_imm_sel    (_mshrs_io_replay_bits_uop_ctrl_imm_sel),
    .io_replay_bits_uop_ctrl_op_fcn     (_mshrs_io_replay_bits_uop_ctrl_op_fcn),
    .io_replay_bits_uop_ctrl_fcn_dw     (_mshrs_io_replay_bits_uop_ctrl_fcn_dw),
    .io_replay_bits_uop_ctrl_csr_cmd    (_mshrs_io_replay_bits_uop_ctrl_csr_cmd),
    .io_replay_bits_uop_ctrl_is_load    (_mshrs_io_replay_bits_uop_ctrl_is_load),
    .io_replay_bits_uop_ctrl_is_sta     (_mshrs_io_replay_bits_uop_ctrl_is_sta),
    .io_replay_bits_uop_ctrl_is_std     (_mshrs_io_replay_bits_uop_ctrl_is_std),
    .io_replay_bits_uop_iw_state        (_mshrs_io_replay_bits_uop_iw_state),
    .io_replay_bits_uop_iw_p1_poisoned  (_mshrs_io_replay_bits_uop_iw_p1_poisoned),
    .io_replay_bits_uop_iw_p2_poisoned  (_mshrs_io_replay_bits_uop_iw_p2_poisoned),
    .io_replay_bits_uop_is_br           (_mshrs_io_replay_bits_uop_is_br),
    .io_replay_bits_uop_is_jalr         (_mshrs_io_replay_bits_uop_is_jalr),
    .io_replay_bits_uop_is_jal          (_mshrs_io_replay_bits_uop_is_jal),
    .io_replay_bits_uop_is_sfb          (_mshrs_io_replay_bits_uop_is_sfb),
    .io_replay_bits_uop_br_mask         (_mshrs_io_replay_bits_uop_br_mask),
    .io_replay_bits_uop_br_tag          (_mshrs_io_replay_bits_uop_br_tag),
    .io_replay_bits_uop_ftq_idx         (_mshrs_io_replay_bits_uop_ftq_idx),
    .io_replay_bits_uop_edge_inst       (_mshrs_io_replay_bits_uop_edge_inst),
    .io_replay_bits_uop_pc_lob          (_mshrs_io_replay_bits_uop_pc_lob),
    .io_replay_bits_uop_taken           (_mshrs_io_replay_bits_uop_taken),
    .io_replay_bits_uop_imm_packed      (_mshrs_io_replay_bits_uop_imm_packed),
    .io_replay_bits_uop_csr_addr        (_mshrs_io_replay_bits_uop_csr_addr),
    .io_replay_bits_uop_rob_idx         (_mshrs_io_replay_bits_uop_rob_idx),
    .io_replay_bits_uop_ldq_idx         (_mshrs_io_replay_bits_uop_ldq_idx),
    .io_replay_bits_uop_stq_idx         (_mshrs_io_replay_bits_uop_stq_idx),
    .io_replay_bits_uop_rxq_idx         (_mshrs_io_replay_bits_uop_rxq_idx),
    .io_replay_bits_uop_pdst            (_mshrs_io_replay_bits_uop_pdst),
    .io_replay_bits_uop_prs1            (_mshrs_io_replay_bits_uop_prs1),
    .io_replay_bits_uop_prs2            (_mshrs_io_replay_bits_uop_prs2),
    .io_replay_bits_uop_prs3            (_mshrs_io_replay_bits_uop_prs3),
    .io_replay_bits_uop_ppred           (_mshrs_io_replay_bits_uop_ppred),
    .io_replay_bits_uop_prs1_busy       (_mshrs_io_replay_bits_uop_prs1_busy),
    .io_replay_bits_uop_prs2_busy       (_mshrs_io_replay_bits_uop_prs2_busy),
    .io_replay_bits_uop_prs3_busy       (_mshrs_io_replay_bits_uop_prs3_busy),
    .io_replay_bits_uop_ppred_busy      (_mshrs_io_replay_bits_uop_ppred_busy),
    .io_replay_bits_uop_stale_pdst      (_mshrs_io_replay_bits_uop_stale_pdst),
    .io_replay_bits_uop_exception       (_mshrs_io_replay_bits_uop_exception),
    .io_replay_bits_uop_exc_cause       (_mshrs_io_replay_bits_uop_exc_cause),
    .io_replay_bits_uop_bypassable      (_mshrs_io_replay_bits_uop_bypassable),
    .io_replay_bits_uop_mem_cmd         (_mshrs_io_replay_bits_uop_mem_cmd),
    .io_replay_bits_uop_mem_size        (_mshrs_io_replay_bits_uop_mem_size),
    .io_replay_bits_uop_mem_signed      (_mshrs_io_replay_bits_uop_mem_signed),
    .io_replay_bits_uop_is_fence        (_mshrs_io_replay_bits_uop_is_fence),
    .io_replay_bits_uop_is_fencei       (_mshrs_io_replay_bits_uop_is_fencei),
    .io_replay_bits_uop_is_amo          (_mshrs_io_replay_bits_uop_is_amo),
    .io_replay_bits_uop_uses_ldq        (_mshrs_io_replay_bits_uop_uses_ldq),
    .io_replay_bits_uop_uses_stq        (_mshrs_io_replay_bits_uop_uses_stq),
    .io_replay_bits_uop_is_sys_pc2epc   (_mshrs_io_replay_bits_uop_is_sys_pc2epc),
    .io_replay_bits_uop_is_unique       (_mshrs_io_replay_bits_uop_is_unique),
    .io_replay_bits_uop_flush_on_commit (_mshrs_io_replay_bits_uop_flush_on_commit),
    .io_replay_bits_uop_ldst_is_rs1     (_mshrs_io_replay_bits_uop_ldst_is_rs1),
    .io_replay_bits_uop_ldst            (_mshrs_io_replay_bits_uop_ldst),
    .io_replay_bits_uop_lrs1            (_mshrs_io_replay_bits_uop_lrs1),
    .io_replay_bits_uop_lrs2            (_mshrs_io_replay_bits_uop_lrs2),
    .io_replay_bits_uop_lrs3            (_mshrs_io_replay_bits_uop_lrs3),
    .io_replay_bits_uop_ldst_val        (_mshrs_io_replay_bits_uop_ldst_val),
    .io_replay_bits_uop_dst_rtype       (_mshrs_io_replay_bits_uop_dst_rtype),
    .io_replay_bits_uop_lrs1_rtype      (_mshrs_io_replay_bits_uop_lrs1_rtype),
    .io_replay_bits_uop_lrs2_rtype      (_mshrs_io_replay_bits_uop_lrs2_rtype),
    .io_replay_bits_uop_frs3_en         (_mshrs_io_replay_bits_uop_frs3_en),
    .io_replay_bits_uop_fp_val          (_mshrs_io_replay_bits_uop_fp_val),
    .io_replay_bits_uop_fp_single       (_mshrs_io_replay_bits_uop_fp_single),
    .io_replay_bits_uop_xcpt_pf_if      (_mshrs_io_replay_bits_uop_xcpt_pf_if),
    .io_replay_bits_uop_xcpt_ae_if      (_mshrs_io_replay_bits_uop_xcpt_ae_if),
    .io_replay_bits_uop_xcpt_ma_if      (_mshrs_io_replay_bits_uop_xcpt_ma_if),
    .io_replay_bits_uop_bp_debug_if     (_mshrs_io_replay_bits_uop_bp_debug_if),
    .io_replay_bits_uop_bp_xcpt_if      (_mshrs_io_replay_bits_uop_bp_xcpt_if),
    .io_replay_bits_uop_debug_fsrc      (_mshrs_io_replay_bits_uop_debug_fsrc),
    .io_replay_bits_uop_debug_tsrc      (_mshrs_io_replay_bits_uop_debug_tsrc),
    .io_replay_bits_addr                (_mshrs_io_replay_bits_addr),
    .io_replay_bits_data                (_mshrs_io_replay_bits_data),
    .io_replay_bits_is_hella            (_mshrs_io_replay_bits_is_hella),
    .io_replay_bits_way_en              (_mshrs_io_replay_bits_way_en),
    .io_prefetch_valid                  (_mshrs_io_prefetch_valid),
    .io_prefetch_bits_uop_mem_cmd       (_mshrs_io_prefetch_bits_uop_mem_cmd),
    .io_prefetch_bits_addr              (_mshrs_io_prefetch_bits_addr),
    .io_wb_req_valid                    (_mshrs_io_wb_req_valid),
    .io_wb_req_bits_tag                 (_mshrs_io_wb_req_bits_tag),
    .io_wb_req_bits_idx                 (_mshrs_io_wb_req_bits_idx),
    .io_wb_req_bits_param               (_mshrs_io_wb_req_bits_param),
    .io_wb_req_bits_way_en              (_mshrs_io_wb_req_bits_way_en),
    .io_fence_rdy                       (_mshrs_io_fence_rdy),
    .io_probe_rdy                       (_mshrs_io_probe_rdy)
  );
  L1MetadataArray meta_0 (	// dcache.scala:441:41
    .clock                        (clock),
    .reset                        (reset),
    .io_read_valid                (_metaReadArb_io_out_valid),	// dcache.scala:444:27
    .io_read_bits_idx             (_metaReadArb_io_out_bits_req_0_idx),	// dcache.scala:444:27
    .io_write_valid               (_meta_1_io_write_valid_T),	// Decoupled.scala:40:37
    .io_write_bits_idx            (_metaWriteArb_io_out_bits_idx),	// dcache.scala:442:28
    .io_write_bits_way_en         (_metaWriteArb_io_out_bits_way_en),	// dcache.scala:442:28
    .io_write_bits_data_coh_state (_metaWriteArb_io_out_bits_data_coh_state),	// dcache.scala:442:28
    .io_write_bits_data_tag       (_metaWriteArb_io_out_bits_data_tag),	// dcache.scala:442:28
    .io_read_ready                (_meta_0_io_read_ready),
    .io_write_ready               (_meta_0_io_write_ready),
    .io_resp_0_coh_state          (_meta_0_io_resp_0_coh_state),
    .io_resp_0_tag                (_meta_0_io_resp_0_tag),
    .io_resp_1_coh_state          (_meta_0_io_resp_1_coh_state),
    .io_resp_1_tag                (_meta_0_io_resp_1_tag),
    .io_resp_2_coh_state          (_meta_0_io_resp_2_coh_state),
    .io_resp_2_tag                (_meta_0_io_resp_2_tag),
    .io_resp_3_coh_state          (_meta_0_io_resp_3_coh_state),
    .io_resp_3_tag                (_meta_0_io_resp_3_tag),
    .io_resp_4_coh_state          (_meta_0_io_resp_4_coh_state),
    .io_resp_4_tag                (_meta_0_io_resp_4_tag),
    .io_resp_5_coh_state          (_meta_0_io_resp_5_coh_state),
    .io_resp_5_tag                (_meta_0_io_resp_5_tag),
    .io_resp_6_coh_state          (_meta_0_io_resp_6_coh_state),
    .io_resp_6_tag                (_meta_0_io_resp_6_tag),
    .io_resp_7_coh_state          (_meta_0_io_resp_7_coh_state),
    .io_resp_7_tag                (_meta_0_io_resp_7_tag)
  );
  L1MetadataArray meta_1 (	// dcache.scala:441:41
    .clock                        (clock),
    .reset                        (reset),
    .io_read_valid                (_metaReadArb_io_out_valid),	// dcache.scala:444:27
    .io_read_bits_idx             (_metaReadArb_io_out_bits_req_1_idx),	// dcache.scala:444:27
    .io_write_valid               (_meta_1_io_write_valid_T),	// Decoupled.scala:40:37
    .io_write_bits_idx            (_metaWriteArb_io_out_bits_idx),	// dcache.scala:442:28
    .io_write_bits_way_en         (_metaWriteArb_io_out_bits_way_en),	// dcache.scala:442:28
    .io_write_bits_data_coh_state (_metaWriteArb_io_out_bits_data_coh_state),	// dcache.scala:442:28
    .io_write_bits_data_tag       (_metaWriteArb_io_out_bits_data_tag),	// dcache.scala:442:28
    .io_read_ready                (_meta_1_io_read_ready),
    .io_write_ready               (_meta_1_io_write_ready),
    .io_resp_0_coh_state          (_meta_1_io_resp_0_coh_state),
    .io_resp_0_tag                (_meta_1_io_resp_0_tag),
    .io_resp_1_coh_state          (_meta_1_io_resp_1_coh_state),
    .io_resp_1_tag                (_meta_1_io_resp_1_tag),
    .io_resp_2_coh_state          (_meta_1_io_resp_2_coh_state),
    .io_resp_2_tag                (_meta_1_io_resp_2_tag),
    .io_resp_3_coh_state          (_meta_1_io_resp_3_coh_state),
    .io_resp_3_tag                (_meta_1_io_resp_3_tag),
    .io_resp_4_coh_state          (_meta_1_io_resp_4_coh_state),
    .io_resp_4_tag                (_meta_1_io_resp_4_tag),
    .io_resp_5_coh_state          (_meta_1_io_resp_5_coh_state),
    .io_resp_5_tag                (_meta_1_io_resp_5_tag),
    .io_resp_6_coh_state          (_meta_1_io_resp_6_coh_state),
    .io_resp_6_tag                (_meta_1_io_resp_6_tag),
    .io_resp_7_coh_state          (_meta_1_io_resp_7_coh_state),
    .io_resp_7_tag                (_meta_1_io_resp_7_tag)
  );
  Arbiter_12 metaWriteArb (	// dcache.scala:442:28
    .io_in_0_valid               (_mshrs_io_meta_write_valid),	// dcache.scala:432:21
    .io_in_0_bits_idx            (_mshrs_io_meta_write_bits_idx),	// dcache.scala:432:21
    .io_in_0_bits_way_en         (_mshrs_io_meta_write_bits_way_en),	// dcache.scala:432:21
    .io_in_0_bits_data_coh_state (_mshrs_io_meta_write_bits_data_coh_state),	// dcache.scala:432:21
    .io_in_0_bits_data_tag       (_mshrs_io_meta_write_bits_data_tag),	// dcache.scala:432:21
    .io_in_1_valid               (_prober_io_meta_write_valid),	// dcache.scala:431:22
    .io_in_1_bits_idx            (_prober_io_meta_write_bits_idx),	// dcache.scala:431:22
    .io_in_1_bits_way_en         (_prober_io_meta_write_bits_way_en),	// dcache.scala:431:22
    .io_in_1_bits_data_coh_state (_prober_io_meta_write_bits_data_coh_state),	// dcache.scala:431:22
    .io_in_1_bits_data_tag       (_prober_io_meta_write_bits_data_tag),	// dcache.scala:431:22
    .io_out_ready                (_metaWriteArb_io_out_ready_T),	// dcache.scala:456:67
    .io_in_1_ready               (_metaWriteArb_io_in_1_ready),
    .io_out_valid                (_metaWriteArb_io_out_valid),
    .io_out_bits_idx             (_metaWriteArb_io_out_bits_idx),
    .io_out_bits_way_en          (_metaWriteArb_io_out_bits_way_en),
    .io_out_bits_data_coh_state  (_metaWriteArb_io_out_bits_data_coh_state),
    .io_out_bits_data_tag        (_metaWriteArb_io_out_bits_data_tag)
  );
  Arbiter_13 metaReadArb (	// dcache.scala:444:27
    .io_in_0_valid          (_mshrs_io_replay_valid),	// dcache.scala:432:21
    .io_in_0_bits_req_0_idx (_mshrs_io_replay_bits_addr[11:6]),	// dcache.scala:432:21, :505:{43,72}
    .io_in_1_valid          (_prober_io_meta_read_valid),	// dcache.scala:431:22
    .io_in_1_bits_req_0_idx (_prober_io_meta_read_bits_idx),	// dcache.scala:431:22
    .io_in_2_valid          (_wb_io_meta_read_valid),	// dcache.scala:430:18
    .io_in_2_bits_req_0_idx (_wb_io_meta_read_bits_idx),	// dcache.scala:430:18
    .io_in_3_valid          (_mshrs_io_meta_read_valid),	// dcache.scala:432:21
    .io_in_3_bits_req_0_idx (_mshrs_io_meta_read_bits_idx),	// dcache.scala:432:21
    .io_in_4_valid          (io_lsu_req_valid),
    .io_in_4_bits_req_0_idx (io_lsu_req_bits_0_bits_addr[11:6]),	// dcache.scala:484:{45,77}
    .io_in_4_bits_req_1_idx (io_lsu_req_bits_1_bits_addr[11:6]),	// dcache.scala:484:{45,77}
    .io_in_5_valid          (_mshrs_io_prefetch_valid),	// dcache.scala:432:21
    .io_in_5_bits_req_0_idx (_mshrs_io_prefetch_bits_addr[11:6]),	// dcache.scala:432:21, :572:{43,74}
    .io_out_ready           (_metaReadArb_io_out_ready_T),	// dcache.scala:455:66
    .io_in_1_ready          (_metaReadArb_io_in_1_ready),
    .io_in_2_ready          (_metaReadArb_io_in_2_ready),
    .io_in_3_ready          (_metaReadArb_io_in_3_ready),
    .io_in_4_ready          (_metaReadArb_io_in_4_ready),
    .io_in_5_ready          (_metaReadArb_io_in_5_ready),
    .io_out_valid           (_metaReadArb_io_out_valid),
    .io_out_bits_req_0_idx  (_metaReadArb_io_out_bits_req_0_idx),
    .io_out_bits_req_1_idx  (_metaReadArb_io_out_bits_req_1_idx)
  );
  BoomDuplicatedDataArray data (	// dcache.scala:459:20
    .clock                 (clock),
    .io_read_0_valid       (_dataReadArb_io_out_bits_valid_0 & _dataReadArb_io_out_valid),	// dcache.scala:462:27, :467:63
    .io_read_0_bits_way_en (_dataReadArb_io_out_bits_req_0_way_en),	// dcache.scala:462:27
    .io_read_0_bits_addr   (_dataReadArb_io_out_bits_req_0_addr),	// dcache.scala:462:27
    .io_read_1_valid       (_dataReadArb_io_out_bits_valid_1 & _dataReadArb_io_out_valid),	// dcache.scala:462:27, :467:63
    .io_read_1_bits_way_en (_dataReadArb_io_out_bits_req_1_way_en),	// dcache.scala:462:27
    .io_read_1_bits_addr   (_dataReadArb_io_out_bits_req_1_addr),	// dcache.scala:462:27
    .io_write_valid        (_dataWriteArb_io_out_valid),	// dcache.scala:460:28
    .io_write_bits_way_en  (_dataWriteArb_io_out_bits_way_en),	// dcache.scala:460:28
    .io_write_bits_addr    (_dataWriteArb_io_out_bits_addr),	// dcache.scala:460:28
    .io_write_bits_data    (_dataWriteArb_io_out_bits_data),	// dcache.scala:460:28
    .io_resp_0_0           (_data_io_resp_0_0),
    .io_resp_0_1           (_data_io_resp_0_1),
    .io_resp_0_2           (_data_io_resp_0_2),
    .io_resp_0_3           (_data_io_resp_0_3),
    .io_resp_0_4           (_data_io_resp_0_4),
    .io_resp_0_5           (_data_io_resp_0_5),
    .io_resp_0_6           (_data_io_resp_0_6),
    .io_resp_0_7           (_data_io_resp_0_7),
    .io_resp_1_0           (_data_io_resp_1_0),
    .io_resp_1_1           (_data_io_resp_1_1),
    .io_resp_1_2           (_data_io_resp_1_2),
    .io_resp_1_3           (_data_io_resp_1_3),
    .io_resp_1_4           (_data_io_resp_1_4),
    .io_resp_1_5           (_data_io_resp_1_5),
    .io_resp_1_6           (_data_io_resp_1_6),
    .io_resp_1_7           (_data_io_resp_1_7)
  );
  Arbiter_14 dataWriteArb (	// dcache.scala:460:28
    .io_in_0_valid       (s3_valid),	// dcache.scala:870:25
    .io_in_0_bits_way_en (s3_way),	// dcache.scala:903:25
    .io_in_0_bits_addr   (s3_req_addr[11:0]),	// dcache.scala:869:25, :906:37
    .io_in_0_bits_data   (s3_req_data),	// dcache.scala:869:25
    .io_in_1_valid       (_mshrs_io_refill_valid),	// dcache.scala:432:21
    .io_in_1_bits_way_en (_mshrs_io_refill_bits_way_en),	// dcache.scala:432:21
    .io_in_1_bits_addr   (_mshrs_io_refill_bits_addr),	// dcache.scala:432:21
    .io_in_1_bits_data   (_mshrs_io_refill_bits_data),	// dcache.scala:432:21
    .io_in_1_ready       (_dataWriteArb_io_in_1_ready),
    .io_out_valid        (_dataWriteArb_io_out_valid),
    .io_out_bits_way_en  (_dataWriteArb_io_out_bits_way_en),
    .io_out_bits_addr    (_dataWriteArb_io_out_bits_addr),
    .io_out_bits_data    (_dataWriteArb_io_out_bits_data)
  );
  Arbiter_15 dataReadArb (	// dcache.scala:462:27
    .io_in_0_valid             (_mshrs_io_replay_valid),	// dcache.scala:432:21
    .io_in_0_bits_req_0_way_en (_mshrs_io_replay_bits_way_en),	// dcache.scala:432:21
    .io_in_0_bits_req_0_addr   (_mshrs_io_replay_bits_addr[11:0]),	// dcache.scala:432:21, :510:43
    .io_in_1_valid             (_wb_io_data_req_valid),	// dcache.scala:430:18
    .io_in_1_bits_req_0_way_en (_wb_io_data_req_bits_way_en),	// dcache.scala:430:18
    .io_in_1_bits_req_0_addr   (_wb_io_data_req_bits_addr),	// dcache.scala:430:18
    .io_in_2_valid             (io_lsu_req_valid),
    .io_in_2_bits_req_0_addr   (io_lsu_req_bits_0_bits_addr[11:0]),	// dcache.scala:489:45
    .io_in_2_bits_req_1_addr   (io_lsu_req_bits_1_bits_addr[11:0]),	// dcache.scala:489:45
    .io_in_2_bits_valid_0      (io_lsu_req_bits_0_valid),
    .io_in_2_bits_valid_1      (io_lsu_req_bits_1_valid),
    .io_in_1_ready             (_dataReadArb_io_in_1_ready),
    .io_in_2_ready             (_dataReadArb_io_in_2_ready),
    .io_out_valid              (_dataReadArb_io_out_valid),
    .io_out_bits_req_0_way_en  (_dataReadArb_io_out_bits_req_0_way_en),
    .io_out_bits_req_0_addr    (_dataReadArb_io_out_bits_req_0_addr),
    .io_out_bits_req_1_way_en  (_dataReadArb_io_out_bits_req_1_way_en),
    .io_out_bits_req_1_addr    (_dataReadArb_io_out_bits_req_1_addr),
    .io_out_bits_valid_0       (_dataReadArb_io_out_bits_valid_0),
    .io_out_bits_valid_1       (_dataReadArb_io_out_bits_valid_1)
  );
  MaxPeriodFibonacciLFSR_1 lfsr_prng (	// PRNG.scala:82:22
    .clock        (clock),
    .reset        (reset),
    .io_increment (_s2_send_resp_T_2 | _s2_send_resp_T_56),	// Decoupled.scala:40:37, dcache.scala:773:44
    .io_out_0     (_lfsr_prng_io_out_0),
    .io_out_1     (_lfsr_prng_io_out_1),
    .io_out_2     (_lfsr_prng_io_out_2),
    .io_out_3     (/* unused */),
    .io_out_4     (/* unused */),
    .io_out_5     (/* unused */),
    .io_out_6     (/* unused */),
    .io_out_7     (/* unused */),
    .io_out_8     (/* unused */),
    .io_out_9     (/* unused */),
    .io_out_10    (/* unused */),
    .io_out_11    (/* unused */),
    .io_out_12    (/* unused */),
    .io_out_13    (/* unused */),
    .io_out_14    (/* unused */),
    .io_out_15    (/* unused */)
  );
  Arbiter_16 wbArb (	// dcache.scala:804:21
    .io_in_0_valid         (_prober_io_wb_req_valid),	// dcache.scala:431:22
    .io_in_0_bits_tag      (_prober_io_wb_req_bits_tag),	// dcache.scala:431:22
    .io_in_0_bits_idx      (_prober_io_wb_req_bits_idx),	// dcache.scala:431:22
    .io_in_0_bits_param    (_prober_io_wb_req_bits_param),	// dcache.scala:431:22
    .io_in_0_bits_way_en   (_prober_io_wb_req_bits_way_en),	// dcache.scala:431:22
    .io_in_1_valid         (_mshrs_io_wb_req_valid),	// dcache.scala:432:21
    .io_in_1_bits_tag      (_mshrs_io_wb_req_bits_tag),	// dcache.scala:432:21
    .io_in_1_bits_idx      (_mshrs_io_wb_req_bits_idx),	// dcache.scala:432:21
    .io_in_1_bits_param    (_mshrs_io_wb_req_bits_param),	// dcache.scala:432:21
    .io_in_1_bits_way_en   (_mshrs_io_wb_req_bits_way_en),	// dcache.scala:432:21
    .io_out_ready          (_wb_io_req_ready),	// dcache.scala:430:18
    .io_in_1_ready         (_wbArb_io_in_1_ready),
    .io_out_valid          (_wbArb_io_out_valid),
    .io_out_bits_tag       (_wbArb_io_out_bits_tag),
    .io_out_bits_idx       (_wbArb_io_out_bits_idx),
    .io_out_bits_param     (_wbArb_io_out_bits_param),
    .io_out_bits_way_en    (_wbArb_io_out_bits_way_en),
    .io_out_bits_voluntary (_wbArb_io_out_bits_voluntary)
  );
  Arbiter_17 lsu_release_arb (	// dcache.scala:813:31
    .io_in_0_valid        (_wb_io_lsu_release_valid),	// dcache.scala:430:18
    .io_in_0_bits_address (_wb_io_lsu_release_bits_address),	// dcache.scala:430:18
    .io_in_1_valid        (_prober_io_lsu_release_valid),	// dcache.scala:431:22
    .io_in_1_bits_address (_prober_io_lsu_release_bits_address),	// dcache.scala:431:22
    .io_out_ready         (io_lsu_release_ready),
    .io_in_1_ready        (_lsu_release_arb_io_in_1_ready),
    .io_out_valid         (io_lsu_release_valid),
    .io_out_bits_address  (io_lsu_release_bits_address)
  );
  AMOALU amoalu (	// dcache.scala:895:24
    .io_mask
      ({(s2_req_0_addr[2] ? _amoalu_io_mask_T_1 : 4'h0) | {4{&size}},
        s2_req_0_addr[2] ? 4'h0 : _amoalu_io_mask_T_1}),	// AMOALU.scala:17:{22,46,51,57}, :18:22, :39:29, Cat.scala:30:58, dcache.scala:432:21, :567:27, :631:25
    .io_cmd  (s2_req_0_uop_mem_cmd),	// dcache.scala:631:25
    .io_lhs  (s2_data_word_0),	// dcache.scala:890:27
    .io_rhs  (s2_req_0_data),	// dcache.scala:631:25
    .io_out  (_amoalu_io_out)
  );
  assign auto_out_b_ready = _prober_io_req_ready & ~(|(lrsc_count[6:2]));	// dcache.scala:431:22, :659:27, :660:31, :777:46, :778:48
  assign auto_out_c_valid = out_2_valid;	// Arbiter.scala:125:29
  assign auto_out_c_bits_opcode =
    (muxStateEarly_0 ? _wb_io_release_bits_opcode : 3'h0) | {muxStateEarly_1, 2'h0};	// Arbiter.scala:117:30, Mux.scala:27:72, dcache.scala:430:18, :432:21, :567:27
  assign auto_out_c_bits_param =
    (muxStateEarly_0 ? _wb_io_release_bits_param : 3'h0)
    | (muxStateEarly_1 ? _prober_io_rep_bits_param : 3'h0);	// Arbiter.scala:117:30, Mux.scala:27:72, dcache.scala:430:18, :431:22, :432:21, :567:27
  assign auto_out_c_bits_size =
    (muxStateEarly_0 ? 4'h6 : 4'h0) | (muxStateEarly_1 ? _prober_io_rep_bits_size : 4'h0);	// Arbiter.scala:117:30, Mux.scala:27:72, ReadyValidCancel.scala:70:19, dcache.scala:430:18, :431:22, :432:21, :567:27, :813:31
  assign auto_out_c_bits_source =
    {muxStateEarly_0, 3'h0} | (muxStateEarly_1 ? _prober_io_rep_bits_source : 4'h0);	// Arbiter.scala:117:30, Mux.scala:27:72, dcache.scala:431:22, :432:21, :567:27
  assign auto_out_c_bits_address =
    (muxStateEarly_0 ? _wb_io_release_bits_address : 32'h0)
    | (muxStateEarly_1 ? _prober_io_rep_bits_address : 32'h0);	// Arbiter.scala:117:30, Mux.scala:27:72, dcache.scala:430:18, :431:22, :432:21, :567:27
  assign auto_out_c_bits_data = muxStateEarly_0 ? _wb_io_release_bits_data : 64'h0;	// Arbiter.scala:117:30, Mux.scala:27:72, dcache.scala:430:18, :431:22, :432:21, :567:27, :813:31
  assign auto_out_d_ready = tl_out_d_ready;	// dcache.scala:788:48, :790:20, :795:24
  assign io_lsu_req_ready = _io_lsu_req_ready_output;	// dcache.scala:479:50
  assign io_lsu_resp_0_valid =
    (cache_resp_0_valid ? cache_resp_0_valid : _mshrs_io_resp_valid)
    & ~(io_lsu_exception & io_lsu_resp_0_bits_out_uop_uses_ldq)
    & (io_lsu_brupdate_b1_mispredict_mask
       & (cache_resp_0_valid
            ? s2_req_0_uop_br_mask
            : _mshrs_io_resp_bits_uop_br_mask)) == 20'h0;	// dcache.scala:431:22, :432:21, :441:41, :442:28, :444:27, :567:27, :631:25, :834:48, :849:28, :850:15, :857:{29,48,78}, util.scala:118:{51,59}
  assign io_lsu_resp_0_bits_uop_ldq_idx =
    cache_resp_0_valid ? s2_req_0_uop_ldq_idx : _mshrs_io_resp_bits_uop_ldq_idx;	// dcache.scala:432:21, :631:25, :834:48, :849:28, :850:15
  assign io_lsu_resp_0_bits_uop_stq_idx =
    cache_resp_0_valid ? s2_req_0_uop_stq_idx : _mshrs_io_resp_bits_uop_stq_idx;	// dcache.scala:432:21, :631:25, :834:48, :849:28, :850:15
  assign io_lsu_resp_0_bits_uop_is_amo =
    cache_resp_0_valid ? s2_req_0_uop_is_amo : _mshrs_io_resp_bits_uop_is_amo;	// dcache.scala:432:21, :631:25, :834:48, :849:28, :850:15
  assign io_lsu_resp_0_bits_uop_uses_ldq = io_lsu_resp_0_bits_out_uop_uses_ldq;	// dcache.scala:849:28, :850:15
  assign io_lsu_resp_0_bits_uop_uses_stq =
    cache_resp_0_valid ? s2_req_0_uop_uses_stq : _mshrs_io_resp_bits_uop_uses_stq;	// dcache.scala:432:21, :631:25, :834:48, :849:28, :850:15
  assign io_lsu_resp_0_bits_data =
    cache_resp_0_valid
      ? {size == 2'h0 | s2_sc
           ? {56{s2_req_0_uop_mem_signed & cache_resp_0_bits_data_lo_2[7]}}
           : {size == 2'h1
                ? {48{s2_req_0_uop_mem_signed & cache_resp_0_bits_data_lo_1[15]}}
                : {size == 2'h2
                     ? {32{s2_req_0_uop_mem_signed & cache_resp_0_bits_data_lo[31]}}
                     : s2_data_word_0[63:32],
                   cache_resp_0_bits_data_lo[31:16]},
              cache_resp_0_bits_data_lo_1[15:8]},
         cache_resp_0_bits_data_lo_2[7:1],
         cache_resp_0_bits_data_lo_2[0] | s2_sc_fail}
      : _mshrs_io_resp_bits_data;	// AMOALU.scala:39:{24,37}, :41:23, :42:{20,26,38,76,85,98}, Bitwise.scala:72:12, dcache.scala:432:21, :567:27, :596:16, :631:25, :663:47, :665:26, :834:48, :836:52, :849:28, :850:15, :890:27
  assign io_lsu_resp_0_bits_is_hella =
    cache_resp_0_valid ? s2_req_0_is_hella : _mshrs_io_resp_bits_is_hella;	// dcache.scala:432:21, :631:25, :834:48, :849:28, :850:15
  assign io_lsu_resp_1_valid =
    (uncache_respond_1 ? _mshrs_io_resp_valid : cache_resp_1_valid)
    & ~(io_lsu_exception & io_lsu_resp_1_bits_out_uop_uses_ldq)
    & (io_lsu_brupdate_b1_mispredict_mask
       & (uncache_respond_1
            ? _mshrs_io_resp_bits_uop_br_mask
            : s2_req_1_uop_br_mask)) == 20'h0;	// dcache.scala:431:22, :432:21, :441:41, :442:28, :444:27, :567:27, :631:25, :834:48, :848:48, :849:28, :850:15, :857:{29,48,78}, util.scala:118:{51,59}
  assign io_lsu_resp_1_bits_uop_ldq_idx =
    uncache_respond_1 ? _mshrs_io_resp_bits_uop_ldq_idx : s2_req_1_uop_ldq_idx;	// dcache.scala:432:21, :631:25, :848:48, :849:28, :850:15
  assign io_lsu_resp_1_bits_uop_stq_idx =
    uncache_respond_1 ? _mshrs_io_resp_bits_uop_stq_idx : s2_req_1_uop_stq_idx;	// dcache.scala:432:21, :631:25, :848:48, :849:28, :850:15
  assign io_lsu_resp_1_bits_uop_is_amo =
    uncache_respond_1 ? _mshrs_io_resp_bits_uop_is_amo : s2_req_1_uop_is_amo;	// dcache.scala:432:21, :631:25, :848:48, :849:28, :850:15
  assign io_lsu_resp_1_bits_uop_uses_ldq = io_lsu_resp_1_bits_out_uop_uses_ldq;	// dcache.scala:849:28, :850:15
  assign io_lsu_resp_1_bits_uop_uses_stq =
    uncache_respond_1 ? _mshrs_io_resp_bits_uop_uses_stq : s2_req_1_uop_uses_stq;	// dcache.scala:432:21, :631:25, :848:48, :849:28, :850:15
  assign io_lsu_resp_1_bits_data =
    uncache_respond_1
      ? _mshrs_io_resp_bits_data
      : {size_1 == 2'h0
           ? {56{s2_req_1_uop_mem_signed & cache_resp_1_bits_data_lo_2[7]}}
           : {size_1 == 2'h1
                ? {48{s2_req_1_uop_mem_signed & cache_resp_1_bits_data_lo_1[15]}}
                : {size_1 == 2'h2
                     ? {32{s2_req_1_uop_mem_signed & cache_resp_1_bits_data_lo[31]}}
                     : s2_data_word_1[63:32],
                   cache_resp_1_bits_data_lo[31:16]},
              cache_resp_1_bits_data_lo_1[15:8]},
         cache_resp_1_bits_data_lo_2[7:1],
         cache_resp_1_bits_data_lo_2[0] | s2_sc_fail};	// AMOALU.scala:39:{24,37}, :42:{20,26,76,85,98}, Bitwise.scala:72:12, dcache.scala:432:21, :567:27, :596:16, :631:25, :665:26, :836:52, :848:48, :849:28, :850:15, :890:27
  assign io_lsu_resp_1_bits_is_hella =
    uncache_respond_1 ? _mshrs_io_resp_bits_is_hella : s2_req_1_is_hella;	// dcache.scala:432:21, :631:25, :848:48, :849:28, :850:15
  assign io_lsu_nack_0_valid = _io_lsu_nack_0_valid_output;	// dcache.scala:862:75
  assign io_lsu_nack_0_bits_uop_ldq_idx = s2_req_0_uop_ldq_idx;	// dcache.scala:631:25
  assign io_lsu_nack_0_bits_uop_stq_idx = s2_req_0_uop_stq_idx;	// dcache.scala:631:25
  assign io_lsu_nack_0_bits_uop_uses_ldq = s2_req_0_uop_uses_ldq;	// dcache.scala:631:25
  assign io_lsu_nack_0_bits_uop_uses_stq = s2_req_0_uop_uses_stq;	// dcache.scala:631:25
  assign io_lsu_nack_0_bits_is_hella = s2_req_0_is_hella;	// dcache.scala:631:25
  assign io_lsu_nack_1_valid = _io_lsu_nack_1_valid_output;	// dcache.scala:862:75
  assign io_lsu_nack_1_bits_uop_ldq_idx = s2_req_1_uop_ldq_idx;	// dcache.scala:631:25
  assign io_lsu_nack_1_bits_uop_stq_idx = s2_req_1_uop_stq_idx;	// dcache.scala:631:25
  assign io_lsu_nack_1_bits_uop_uses_ldq = s2_req_1_uop_uses_ldq;	// dcache.scala:631:25
  assign io_lsu_nack_1_bits_uop_uses_stq = s2_req_1_uop_uses_stq;	// dcache.scala:631:25
  assign io_lsu_nack_1_bits_is_hella = s2_req_1_is_hella;	// dcache.scala:631:25
  assign io_lsu_ordered =
    _mshrs_io_fence_rdy & ~(s1_valid_REG | s1_valid_REG_1)
    & ~(s2_valid_REG | s2_valid_REG_1);	// dcache.scala:432:21, :604:25, :634:26, :912:{43,61,66,69,87}
endmodule

