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

module BoomMSHRFile(
  input         clock,
                reset,
                io_req_0_valid,
  input  [6:0]  io_req_0_bits_uop_uopc,
  input  [31:0] io_req_0_bits_uop_inst,
                io_req_0_bits_uop_debug_inst,
  input         io_req_0_bits_uop_is_rvc,
  input  [39:0] io_req_0_bits_uop_debug_pc,
  input  [2:0]  io_req_0_bits_uop_iq_type,
  input  [9:0]  io_req_0_bits_uop_fu_code,
  input  [3:0]  io_req_0_bits_uop_ctrl_br_type,
  input  [1:0]  io_req_0_bits_uop_ctrl_op1_sel,
  input  [2:0]  io_req_0_bits_uop_ctrl_op2_sel,
                io_req_0_bits_uop_ctrl_imm_sel,
  input  [3:0]  io_req_0_bits_uop_ctrl_op_fcn,
  input         io_req_0_bits_uop_ctrl_fcn_dw,
  input  [2:0]  io_req_0_bits_uop_ctrl_csr_cmd,
  input         io_req_0_bits_uop_ctrl_is_load,
                io_req_0_bits_uop_ctrl_is_sta,
                io_req_0_bits_uop_ctrl_is_std,
  input  [1:0]  io_req_0_bits_uop_iw_state,
  input         io_req_0_bits_uop_iw_p1_poisoned,
                io_req_0_bits_uop_iw_p2_poisoned,
                io_req_0_bits_uop_is_br,
                io_req_0_bits_uop_is_jalr,
                io_req_0_bits_uop_is_jal,
                io_req_0_bits_uop_is_sfb,
  input  [19:0] io_req_0_bits_uop_br_mask,
  input  [4:0]  io_req_0_bits_uop_br_tag,
  input  [5:0]  io_req_0_bits_uop_ftq_idx,
  input         io_req_0_bits_uop_edge_inst,
  input  [5:0]  io_req_0_bits_uop_pc_lob,
  input         io_req_0_bits_uop_taken,
  input  [19:0] io_req_0_bits_uop_imm_packed,
  input  [11:0] io_req_0_bits_uop_csr_addr,
  input  [6:0]  io_req_0_bits_uop_rob_idx,
  input  [4:0]  io_req_0_bits_uop_ldq_idx,
                io_req_0_bits_uop_stq_idx,
  input  [1:0]  io_req_0_bits_uop_rxq_idx,
  input  [6:0]  io_req_0_bits_uop_pdst,
                io_req_0_bits_uop_prs1,
                io_req_0_bits_uop_prs2,
                io_req_0_bits_uop_prs3,
  input  [5:0]  io_req_0_bits_uop_ppred,
  input         io_req_0_bits_uop_prs1_busy,
                io_req_0_bits_uop_prs2_busy,
                io_req_0_bits_uop_prs3_busy,
                io_req_0_bits_uop_ppred_busy,
  input  [6:0]  io_req_0_bits_uop_stale_pdst,
  input         io_req_0_bits_uop_exception,
  input  [63:0] io_req_0_bits_uop_exc_cause,
  input         io_req_0_bits_uop_bypassable,
  input  [4:0]  io_req_0_bits_uop_mem_cmd,
  input  [1:0]  io_req_0_bits_uop_mem_size,
  input         io_req_0_bits_uop_mem_signed,
                io_req_0_bits_uop_is_fence,
                io_req_0_bits_uop_is_fencei,
                io_req_0_bits_uop_is_amo,
                io_req_0_bits_uop_uses_ldq,
                io_req_0_bits_uop_uses_stq,
                io_req_0_bits_uop_is_sys_pc2epc,
                io_req_0_bits_uop_is_unique,
                io_req_0_bits_uop_flush_on_commit,
                io_req_0_bits_uop_ldst_is_rs1,
  input  [5:0]  io_req_0_bits_uop_ldst,
                io_req_0_bits_uop_lrs1,
                io_req_0_bits_uop_lrs2,
                io_req_0_bits_uop_lrs3,
  input         io_req_0_bits_uop_ldst_val,
  input  [1:0]  io_req_0_bits_uop_dst_rtype,
                io_req_0_bits_uop_lrs1_rtype,
                io_req_0_bits_uop_lrs2_rtype,
  input         io_req_0_bits_uop_frs3_en,
                io_req_0_bits_uop_fp_val,
                io_req_0_bits_uop_fp_single,
                io_req_0_bits_uop_xcpt_pf_if,
                io_req_0_bits_uop_xcpt_ae_if,
                io_req_0_bits_uop_xcpt_ma_if,
                io_req_0_bits_uop_bp_debug_if,
                io_req_0_bits_uop_bp_xcpt_if,
  input  [1:0]  io_req_0_bits_uop_debug_fsrc,
                io_req_0_bits_uop_debug_tsrc,
  input  [39:0] io_req_0_bits_addr,
  input  [63:0] io_req_0_bits_data,
  input         io_req_0_bits_is_hella,
                io_req_0_bits_tag_match,
  input  [1:0]  io_req_0_bits_old_meta_coh_state,
  input  [19:0] io_req_0_bits_old_meta_tag,
  input  [7:0]  io_req_0_bits_way_en,
  input         io_req_1_valid,
  input  [6:0]  io_req_1_bits_uop_uopc,
  input  [31:0] io_req_1_bits_uop_inst,
                io_req_1_bits_uop_debug_inst,
  input         io_req_1_bits_uop_is_rvc,
  input  [39:0] io_req_1_bits_uop_debug_pc,
  input  [2:0]  io_req_1_bits_uop_iq_type,
  input  [9:0]  io_req_1_bits_uop_fu_code,
  input  [3:0]  io_req_1_bits_uop_ctrl_br_type,
  input  [1:0]  io_req_1_bits_uop_ctrl_op1_sel,
  input  [2:0]  io_req_1_bits_uop_ctrl_op2_sel,
                io_req_1_bits_uop_ctrl_imm_sel,
  input  [3:0]  io_req_1_bits_uop_ctrl_op_fcn,
  input         io_req_1_bits_uop_ctrl_fcn_dw,
  input  [2:0]  io_req_1_bits_uop_ctrl_csr_cmd,
  input         io_req_1_bits_uop_ctrl_is_load,
                io_req_1_bits_uop_ctrl_is_sta,
                io_req_1_bits_uop_ctrl_is_std,
  input  [1:0]  io_req_1_bits_uop_iw_state,
  input         io_req_1_bits_uop_iw_p1_poisoned,
                io_req_1_bits_uop_iw_p2_poisoned,
                io_req_1_bits_uop_is_br,
                io_req_1_bits_uop_is_jalr,
                io_req_1_bits_uop_is_jal,
                io_req_1_bits_uop_is_sfb,
  input  [19:0] io_req_1_bits_uop_br_mask,
  input  [4:0]  io_req_1_bits_uop_br_tag,
  input  [5:0]  io_req_1_bits_uop_ftq_idx,
  input         io_req_1_bits_uop_edge_inst,
  input  [5:0]  io_req_1_bits_uop_pc_lob,
  input         io_req_1_bits_uop_taken,
  input  [19:0] io_req_1_bits_uop_imm_packed,
  input  [11:0] io_req_1_bits_uop_csr_addr,
  input  [6:0]  io_req_1_bits_uop_rob_idx,
  input  [4:0]  io_req_1_bits_uop_ldq_idx,
                io_req_1_bits_uop_stq_idx,
  input  [1:0]  io_req_1_bits_uop_rxq_idx,
  input  [6:0]  io_req_1_bits_uop_pdst,
                io_req_1_bits_uop_prs1,
                io_req_1_bits_uop_prs2,
                io_req_1_bits_uop_prs3,
  input  [5:0]  io_req_1_bits_uop_ppred,
  input         io_req_1_bits_uop_prs1_busy,
                io_req_1_bits_uop_prs2_busy,
                io_req_1_bits_uop_prs3_busy,
                io_req_1_bits_uop_ppred_busy,
  input  [6:0]  io_req_1_bits_uop_stale_pdst,
  input         io_req_1_bits_uop_exception,
  input  [63:0] io_req_1_bits_uop_exc_cause,
  input         io_req_1_bits_uop_bypassable,
  input  [4:0]  io_req_1_bits_uop_mem_cmd,
  input  [1:0]  io_req_1_bits_uop_mem_size,
  input         io_req_1_bits_uop_mem_signed,
                io_req_1_bits_uop_is_fence,
                io_req_1_bits_uop_is_fencei,
                io_req_1_bits_uop_is_amo,
                io_req_1_bits_uop_uses_ldq,
                io_req_1_bits_uop_uses_stq,
                io_req_1_bits_uop_is_sys_pc2epc,
                io_req_1_bits_uop_is_unique,
                io_req_1_bits_uop_flush_on_commit,
                io_req_1_bits_uop_ldst_is_rs1,
  input  [5:0]  io_req_1_bits_uop_ldst,
                io_req_1_bits_uop_lrs1,
                io_req_1_bits_uop_lrs2,
                io_req_1_bits_uop_lrs3,
  input         io_req_1_bits_uop_ldst_val,
  input  [1:0]  io_req_1_bits_uop_dst_rtype,
                io_req_1_bits_uop_lrs1_rtype,
                io_req_1_bits_uop_lrs2_rtype,
  input         io_req_1_bits_uop_frs3_en,
                io_req_1_bits_uop_fp_val,
                io_req_1_bits_uop_fp_single,
                io_req_1_bits_uop_xcpt_pf_if,
                io_req_1_bits_uop_xcpt_ae_if,
                io_req_1_bits_uop_xcpt_ma_if,
                io_req_1_bits_uop_bp_debug_if,
                io_req_1_bits_uop_bp_xcpt_if,
  input  [1:0]  io_req_1_bits_uop_debug_fsrc,
                io_req_1_bits_uop_debug_tsrc,
  input  [39:0] io_req_1_bits_addr,
  input  [63:0] io_req_1_bits_data,
  input         io_req_1_bits_is_hella,
                io_req_1_bits_tag_match,
  input  [1:0]  io_req_1_bits_old_meta_coh_state,
  input  [19:0] io_req_1_bits_old_meta_tag,
  input  [7:0]  io_req_1_bits_way_en,
  input         io_req_is_probe_0,
                io_req_is_probe_1,
                io_resp_ready,
  input  [19:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  input         io_exception,
                io_mem_acquire_ready,
                io_mem_grant_valid,
  input  [2:0]  io_mem_grant_bits_opcode,
  input  [1:0]  io_mem_grant_bits_param,
  input  [3:0]  io_mem_grant_bits_size,
                io_mem_grant_bits_source,
  input  [2:0]  io_mem_grant_bits_sink,
  input  [63:0] io_mem_grant_bits_data,
  input         io_mem_finish_ready,
                io_refill_ready,
                io_meta_write_ready,
                io_meta_read_ready,
                io_meta_resp_valid,
  input  [1:0]  io_meta_resp_bits_coh_state,
  input         io_replay_ready,
                io_prefetch_ready,
                io_wb_req_ready,
                io_prober_state_valid,
  input  [39:0] io_prober_state_bits,
  input         io_clear_all,
                io_wb_resp,
  output        io_req_0_ready,
                io_req_1_ready,
                io_resp_valid,
  output [19:0] io_resp_bits_uop_br_mask,
  output [4:0]  io_resp_bits_uop_ldq_idx,
                io_resp_bits_uop_stq_idx,
  output        io_resp_bits_uop_is_amo,
                io_resp_bits_uop_uses_ldq,
                io_resp_bits_uop_uses_stq,
  output [63:0] io_resp_bits_data,
  output        io_resp_bits_is_hella,
                io_secondary_miss_0,
                io_secondary_miss_1,
                io_block_hit_0,
                io_block_hit_1,
                io_mem_acquire_valid,
  output [2:0]  io_mem_acquire_bits_opcode,
                io_mem_acquire_bits_param,
  output [3:0]  io_mem_acquire_bits_size,
                io_mem_acquire_bits_source,
  output [31:0] io_mem_acquire_bits_address,
  output [7:0]  io_mem_acquire_bits_mask,
  output [63:0] io_mem_acquire_bits_data,
  output        io_mem_grant_ready,
                io_mem_finish_valid,
  output [2:0]  io_mem_finish_bits_sink,
  output        io_refill_valid,
  output [7:0]  io_refill_bits_way_en,
  output [11:0] io_refill_bits_addr,
  output [63:0] io_refill_bits_data,
  output        io_meta_write_valid,
  output [5:0]  io_meta_write_bits_idx,
  output [7:0]  io_meta_write_bits_way_en,
  output [1:0]  io_meta_write_bits_data_coh_state,
  output [19:0] io_meta_write_bits_data_tag,
  output        io_meta_read_valid,
  output [5:0]  io_meta_read_bits_idx,
  output [7:0]  io_meta_read_bits_way_en,
  output [19:0] io_meta_read_bits_tag,
  output        io_replay_valid,
  output [6:0]  io_replay_bits_uop_uopc,
  output [31:0] io_replay_bits_uop_inst,
                io_replay_bits_uop_debug_inst,
  output        io_replay_bits_uop_is_rvc,
  output [39:0] io_replay_bits_uop_debug_pc,
  output [2:0]  io_replay_bits_uop_iq_type,
  output [9:0]  io_replay_bits_uop_fu_code,
  output [3:0]  io_replay_bits_uop_ctrl_br_type,
  output [1:0]  io_replay_bits_uop_ctrl_op1_sel,
  output [2:0]  io_replay_bits_uop_ctrl_op2_sel,
                io_replay_bits_uop_ctrl_imm_sel,
  output [3:0]  io_replay_bits_uop_ctrl_op_fcn,
  output        io_replay_bits_uop_ctrl_fcn_dw,
  output [2:0]  io_replay_bits_uop_ctrl_csr_cmd,
  output        io_replay_bits_uop_ctrl_is_load,
                io_replay_bits_uop_ctrl_is_sta,
                io_replay_bits_uop_ctrl_is_std,
  output [1:0]  io_replay_bits_uop_iw_state,
  output        io_replay_bits_uop_iw_p1_poisoned,
                io_replay_bits_uop_iw_p2_poisoned,
                io_replay_bits_uop_is_br,
                io_replay_bits_uop_is_jalr,
                io_replay_bits_uop_is_jal,
                io_replay_bits_uop_is_sfb,
  output [19:0] io_replay_bits_uop_br_mask,
  output [4:0]  io_replay_bits_uop_br_tag,
  output [5:0]  io_replay_bits_uop_ftq_idx,
  output        io_replay_bits_uop_edge_inst,
  output [5:0]  io_replay_bits_uop_pc_lob,
  output        io_replay_bits_uop_taken,
  output [19:0] io_replay_bits_uop_imm_packed,
  output [11:0] io_replay_bits_uop_csr_addr,
  output [6:0]  io_replay_bits_uop_rob_idx,
  output [4:0]  io_replay_bits_uop_ldq_idx,
                io_replay_bits_uop_stq_idx,
  output [1:0]  io_replay_bits_uop_rxq_idx,
  output [6:0]  io_replay_bits_uop_pdst,
                io_replay_bits_uop_prs1,
                io_replay_bits_uop_prs2,
                io_replay_bits_uop_prs3,
  output [5:0]  io_replay_bits_uop_ppred,
  output        io_replay_bits_uop_prs1_busy,
                io_replay_bits_uop_prs2_busy,
                io_replay_bits_uop_prs3_busy,
                io_replay_bits_uop_ppred_busy,
  output [6:0]  io_replay_bits_uop_stale_pdst,
  output        io_replay_bits_uop_exception,
  output [63:0] io_replay_bits_uop_exc_cause,
  output        io_replay_bits_uop_bypassable,
  output [4:0]  io_replay_bits_uop_mem_cmd,
  output [1:0]  io_replay_bits_uop_mem_size,
  output        io_replay_bits_uop_mem_signed,
                io_replay_bits_uop_is_fence,
                io_replay_bits_uop_is_fencei,
                io_replay_bits_uop_is_amo,
                io_replay_bits_uop_uses_ldq,
                io_replay_bits_uop_uses_stq,
                io_replay_bits_uop_is_sys_pc2epc,
                io_replay_bits_uop_is_unique,
                io_replay_bits_uop_flush_on_commit,
                io_replay_bits_uop_ldst_is_rs1,
  output [5:0]  io_replay_bits_uop_ldst,
                io_replay_bits_uop_lrs1,
                io_replay_bits_uop_lrs2,
                io_replay_bits_uop_lrs3,
  output        io_replay_bits_uop_ldst_val,
  output [1:0]  io_replay_bits_uop_dst_rtype,
                io_replay_bits_uop_lrs1_rtype,
                io_replay_bits_uop_lrs2_rtype,
  output        io_replay_bits_uop_frs3_en,
                io_replay_bits_uop_fp_val,
                io_replay_bits_uop_fp_single,
                io_replay_bits_uop_xcpt_pf_if,
                io_replay_bits_uop_xcpt_ae_if,
                io_replay_bits_uop_xcpt_ma_if,
                io_replay_bits_uop_bp_debug_if,
                io_replay_bits_uop_bp_xcpt_if,
  output [1:0]  io_replay_bits_uop_debug_fsrc,
                io_replay_bits_uop_debug_tsrc,
  output [39:0] io_replay_bits_addr,
  output [63:0] io_replay_bits_data,
  output        io_replay_bits_is_hella,
  output [7:0]  io_replay_bits_way_en,
  output        io_prefetch_valid,
  output [4:0]  io_prefetch_bits_uop_mem_cmd,
  output [39:0] io_prefetch_bits_addr,
  output        io_wb_req_valid,
  output [19:0] io_wb_req_bits_tag,
  output [5:0]  io_wb_req_bits_idx,
  output [2:0]  io_wb_req_bits_param,
  output [7:0]  io_wb_req_bits_way_en,
  output        io_fence_rdy,
                io_probe_rdy
);

  wire        _io_req_1_ready_output;	// mshrs.scala:744:47
  wire        _io_req_0_ready_output;	// mshrs.scala:744:47
  reg  [2:0]  mshr_alloc_idx_REG;	// mshrs.scala:694:31
  wire        _way_matches_1_7_T;	// mshrs.scala:626:66
  wire        _tag_matches_1_7_T_1;	// mshrs.scala:625:66
  wire        idx_matches_1_7;	// mshrs.scala:624:46
  wire        _way_matches_0_7_T;	// mshrs.scala:626:66
  wire        _tag_matches_0_7_T_1;	// mshrs.scala:625:66
  wire        idx_matches_0_7;	// mshrs.scala:624:46
  wire        _way_matches_1_6_T;	// mshrs.scala:626:66
  wire        _tag_matches_1_6_T_1;	// mshrs.scala:625:66
  wire        idx_matches_1_6;	// mshrs.scala:624:46
  wire        _way_matches_0_6_T;	// mshrs.scala:626:66
  wire        _tag_matches_0_6_T_1;	// mshrs.scala:625:66
  wire        idx_matches_0_6;	// mshrs.scala:624:46
  wire        _way_matches_1_5_T;	// mshrs.scala:626:66
  wire        _tag_matches_1_5_T_1;	// mshrs.scala:625:66
  wire        idx_matches_1_5;	// mshrs.scala:624:46
  wire        _way_matches_0_5_T;	// mshrs.scala:626:66
  wire        _tag_matches_0_5_T_1;	// mshrs.scala:625:66
  wire        idx_matches_0_5;	// mshrs.scala:624:46
  wire        _way_matches_1_4_T;	// mshrs.scala:626:66
  wire        _tag_matches_1_4_T_1;	// mshrs.scala:625:66
  wire        idx_matches_1_4;	// mshrs.scala:624:46
  wire        _way_matches_0_4_T;	// mshrs.scala:626:66
  wire        _tag_matches_0_4_T_1;	// mshrs.scala:625:66
  wire        idx_matches_0_4;	// mshrs.scala:624:46
  wire        _way_matches_1_3_T;	// mshrs.scala:626:66
  wire        _tag_matches_1_3_T_1;	// mshrs.scala:625:66
  wire        idx_matches_1_3;	// mshrs.scala:624:46
  wire        _way_matches_0_3_T;	// mshrs.scala:626:66
  wire        _tag_matches_0_3_T_1;	// mshrs.scala:625:66
  wire        idx_matches_0_3;	// mshrs.scala:624:46
  wire        _way_matches_1_2_T;	// mshrs.scala:626:66
  wire        _tag_matches_1_2_T_1;	// mshrs.scala:625:66
  wire        idx_matches_1_2;	// mshrs.scala:624:46
  wire        _way_matches_0_2_T;	// mshrs.scala:626:66
  wire        _tag_matches_0_2_T_1;	// mshrs.scala:625:66
  wire        idx_matches_0_2;	// mshrs.scala:624:46
  wire        _way_matches_1_1_T;	// mshrs.scala:626:66
  wire        _tag_matches_1_1_T_1;	// mshrs.scala:625:66
  wire        idx_matches_1_1;	// mshrs.scala:624:46
  wire        _way_matches_0_1_T;	// mshrs.scala:626:66
  wire        _tag_matches_0_1_T_1;	// mshrs.scala:625:66
  wire        idx_matches_0_1;	// mshrs.scala:624:46
  wire        _way_matches_1_0_T;	// mshrs.scala:626:66
  wire        _tag_matches_1_0_T_1;	// mshrs.scala:625:66
  wire        idx_matches_1_0;	// mshrs.scala:624:46
  wire        _way_matches_0_0_T;	// mshrs.scala:626:66
  wire        _tag_matches_0_0_T_1;	// mshrs.scala:625:66
  wire        idx_matches_0_0;	// mshrs.scala:624:46
  wire        _respq_io_enq_ready;	// mshrs.scala:737:21
  wire        _mmios_0_io_req_ready;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_valid;	// mshrs.scala:710:22
  wire [6:0]  _mmios_0_io_resp_bits_uop_uopc;	// mshrs.scala:710:22
  wire [31:0] _mmios_0_io_resp_bits_uop_inst;	// mshrs.scala:710:22
  wire [31:0] _mmios_0_io_resp_bits_uop_debug_inst;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_bits_uop_is_rvc;	// mshrs.scala:710:22
  wire [39:0] _mmios_0_io_resp_bits_uop_debug_pc;	// mshrs.scala:710:22
  wire [2:0]  _mmios_0_io_resp_bits_uop_iq_type;	// mshrs.scala:710:22
  wire [9:0]  _mmios_0_io_resp_bits_uop_fu_code;	// mshrs.scala:710:22
  wire [3:0]  _mmios_0_io_resp_bits_uop_ctrl_br_type;	// mshrs.scala:710:22
  wire [1:0]  _mmios_0_io_resp_bits_uop_ctrl_op1_sel;	// mshrs.scala:710:22
  wire [2:0]  _mmios_0_io_resp_bits_uop_ctrl_op2_sel;	// mshrs.scala:710:22
  wire [2:0]  _mmios_0_io_resp_bits_uop_ctrl_imm_sel;	// mshrs.scala:710:22
  wire [3:0]  _mmios_0_io_resp_bits_uop_ctrl_op_fcn;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_bits_uop_ctrl_fcn_dw;	// mshrs.scala:710:22
  wire [2:0]  _mmios_0_io_resp_bits_uop_ctrl_csr_cmd;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_bits_uop_ctrl_is_load;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_bits_uop_ctrl_is_sta;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_bits_uop_ctrl_is_std;	// mshrs.scala:710:22
  wire [1:0]  _mmios_0_io_resp_bits_uop_iw_state;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_bits_uop_iw_p1_poisoned;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_bits_uop_iw_p2_poisoned;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_bits_uop_is_br;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_bits_uop_is_jalr;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_bits_uop_is_jal;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_bits_uop_is_sfb;	// mshrs.scala:710:22
  wire [19:0] _mmios_0_io_resp_bits_uop_br_mask;	// mshrs.scala:710:22
  wire [4:0]  _mmios_0_io_resp_bits_uop_br_tag;	// mshrs.scala:710:22
  wire [5:0]  _mmios_0_io_resp_bits_uop_ftq_idx;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_bits_uop_edge_inst;	// mshrs.scala:710:22
  wire [5:0]  _mmios_0_io_resp_bits_uop_pc_lob;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_bits_uop_taken;	// mshrs.scala:710:22
  wire [19:0] _mmios_0_io_resp_bits_uop_imm_packed;	// mshrs.scala:710:22
  wire [11:0] _mmios_0_io_resp_bits_uop_csr_addr;	// mshrs.scala:710:22
  wire [6:0]  _mmios_0_io_resp_bits_uop_rob_idx;	// mshrs.scala:710:22
  wire [4:0]  _mmios_0_io_resp_bits_uop_ldq_idx;	// mshrs.scala:710:22
  wire [4:0]  _mmios_0_io_resp_bits_uop_stq_idx;	// mshrs.scala:710:22
  wire [1:0]  _mmios_0_io_resp_bits_uop_rxq_idx;	// mshrs.scala:710:22
  wire [6:0]  _mmios_0_io_resp_bits_uop_pdst;	// mshrs.scala:710:22
  wire [6:0]  _mmios_0_io_resp_bits_uop_prs1;	// mshrs.scala:710:22
  wire [6:0]  _mmios_0_io_resp_bits_uop_prs2;	// mshrs.scala:710:22
  wire [6:0]  _mmios_0_io_resp_bits_uop_prs3;	// mshrs.scala:710:22
  wire [5:0]  _mmios_0_io_resp_bits_uop_ppred;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_bits_uop_prs1_busy;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_bits_uop_prs2_busy;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_bits_uop_prs3_busy;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_bits_uop_ppred_busy;	// mshrs.scala:710:22
  wire [6:0]  _mmios_0_io_resp_bits_uop_stale_pdst;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_bits_uop_exception;	// mshrs.scala:710:22
  wire [63:0] _mmios_0_io_resp_bits_uop_exc_cause;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_bits_uop_bypassable;	// mshrs.scala:710:22
  wire [4:0]  _mmios_0_io_resp_bits_uop_mem_cmd;	// mshrs.scala:710:22
  wire [1:0]  _mmios_0_io_resp_bits_uop_mem_size;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_bits_uop_mem_signed;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_bits_uop_is_fence;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_bits_uop_is_fencei;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_bits_uop_is_amo;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_bits_uop_uses_ldq;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_bits_uop_uses_stq;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_bits_uop_is_sys_pc2epc;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_bits_uop_is_unique;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_bits_uop_flush_on_commit;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_bits_uop_ldst_is_rs1;	// mshrs.scala:710:22
  wire [5:0]  _mmios_0_io_resp_bits_uop_ldst;	// mshrs.scala:710:22
  wire [5:0]  _mmios_0_io_resp_bits_uop_lrs1;	// mshrs.scala:710:22
  wire [5:0]  _mmios_0_io_resp_bits_uop_lrs2;	// mshrs.scala:710:22
  wire [5:0]  _mmios_0_io_resp_bits_uop_lrs3;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_bits_uop_ldst_val;	// mshrs.scala:710:22
  wire [1:0]  _mmios_0_io_resp_bits_uop_dst_rtype;	// mshrs.scala:710:22
  wire [1:0]  _mmios_0_io_resp_bits_uop_lrs1_rtype;	// mshrs.scala:710:22
  wire [1:0]  _mmios_0_io_resp_bits_uop_lrs2_rtype;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_bits_uop_frs3_en;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_bits_uop_fp_val;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_bits_uop_fp_single;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_bits_uop_xcpt_pf_if;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_bits_uop_xcpt_ae_if;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_bits_uop_xcpt_ma_if;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_bits_uop_bp_debug_if;	// mshrs.scala:710:22
  wire        _mmios_0_io_resp_bits_uop_bp_xcpt_if;	// mshrs.scala:710:22
  wire [1:0]  _mmios_0_io_resp_bits_uop_debug_fsrc;	// mshrs.scala:710:22
  wire [1:0]  _mmios_0_io_resp_bits_uop_debug_tsrc;	// mshrs.scala:710:22
  wire [63:0] _mmios_0_io_resp_bits_data;	// mshrs.scala:710:22
  wire        _mmios_0_io_mem_access_valid;	// mshrs.scala:710:22
  wire [2:0]  _mmios_0_io_mem_access_bits_opcode;	// mshrs.scala:710:22
  wire [2:0]  _mmios_0_io_mem_access_bits_param;	// mshrs.scala:710:22
  wire [3:0]  _mmios_0_io_mem_access_bits_size;	// mshrs.scala:710:22
  wire [3:0]  _mmios_0_io_mem_access_bits_source;	// mshrs.scala:710:22
  wire [31:0] _mmios_0_io_mem_access_bits_address;	// mshrs.scala:710:22
  wire [7:0]  _mmios_0_io_mem_access_bits_mask;	// mshrs.scala:710:22
  wire [63:0] _mmios_0_io_mem_access_bits_data;	// mshrs.scala:710:22
  wire        _mmio_alloc_arb_io_in_0_ready;	// mshrs.scala:703:30
  wire        _mshrs_7_io_req_pri_rdy;	// mshrs.scala:620:22
  wire        _mshrs_7_io_req_sec_rdy;	// mshrs.scala:620:22
  wire        _mshrs_7_io_idx_valid;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_7_io_idx_bits;	// mshrs.scala:620:22
  wire        _mshrs_7_io_way_valid;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_7_io_way_bits;	// mshrs.scala:620:22
  wire        _mshrs_7_io_tag_valid;	// mshrs.scala:620:22
  wire [27:0] _mshrs_7_io_tag_bits;	// mshrs.scala:620:22
  wire        _mshrs_7_io_mem_acquire_valid;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_7_io_mem_acquire_bits_param;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_7_io_mem_acquire_bits_source;	// mshrs.scala:620:22
  wire [31:0] _mshrs_7_io_mem_acquire_bits_address;	// mshrs.scala:620:22
  wire        _mshrs_7_io_mem_grant_ready;	// mshrs.scala:620:22
  wire        _mshrs_7_io_mem_finish_valid;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_7_io_mem_finish_bits_sink;	// mshrs.scala:620:22
  wire        _mshrs_7_io_refill_valid;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_7_io_refill_bits_way_en;	// mshrs.scala:620:22
  wire [11:0] _mshrs_7_io_refill_bits_addr;	// mshrs.scala:620:22
  wire [63:0] _mshrs_7_io_refill_bits_data;	// mshrs.scala:620:22
  wire        _mshrs_7_io_meta_write_valid;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_7_io_meta_write_bits_idx;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_7_io_meta_write_bits_way_en;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_7_io_meta_write_bits_data_coh_state;	// mshrs.scala:620:22
  wire [19:0] _mshrs_7_io_meta_write_bits_data_tag;	// mshrs.scala:620:22
  wire        _mshrs_7_io_meta_read_valid;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_7_io_meta_read_bits_idx;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_7_io_meta_read_bits_way_en;	// mshrs.scala:620:22
  wire [19:0] _mshrs_7_io_meta_read_bits_tag;	// mshrs.scala:620:22
  wire        _mshrs_7_io_wb_req_valid;	// mshrs.scala:620:22
  wire [19:0] _mshrs_7_io_wb_req_bits_tag;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_7_io_wb_req_bits_idx;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_7_io_wb_req_bits_param;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_7_io_wb_req_bits_way_en;	// mshrs.scala:620:22
  wire        _mshrs_7_io_commit_val;	// mshrs.scala:620:22
  wire [39:0] _mshrs_7_io_commit_addr;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_7_io_commit_coh_state;	// mshrs.scala:620:22
  wire        _mshrs_7_io_lb_read_valid;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_7_io_lb_read_bits_id;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_7_io_lb_read_bits_offset;	// mshrs.scala:620:22
  wire        _mshrs_7_io_lb_write_valid;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_7_io_lb_write_bits_id;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_7_io_lb_write_bits_offset;	// mshrs.scala:620:22
  wire [63:0] _mshrs_7_io_lb_write_bits_data;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_valid;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_7_io_replay_bits_uop_uopc;	// mshrs.scala:620:22
  wire [31:0] _mshrs_7_io_replay_bits_uop_inst;	// mshrs.scala:620:22
  wire [31:0] _mshrs_7_io_replay_bits_uop_debug_inst;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_uop_is_rvc;	// mshrs.scala:620:22
  wire [39:0] _mshrs_7_io_replay_bits_uop_debug_pc;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_7_io_replay_bits_uop_iq_type;	// mshrs.scala:620:22
  wire [9:0]  _mshrs_7_io_replay_bits_uop_fu_code;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_7_io_replay_bits_uop_ctrl_br_type;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_7_io_replay_bits_uop_ctrl_op1_sel;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_7_io_replay_bits_uop_ctrl_op2_sel;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_7_io_replay_bits_uop_ctrl_imm_sel;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_7_io_replay_bits_uop_ctrl_op_fcn;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_uop_ctrl_fcn_dw;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_7_io_replay_bits_uop_ctrl_csr_cmd;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_uop_ctrl_is_load;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_uop_ctrl_is_sta;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_uop_ctrl_is_std;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_7_io_replay_bits_uop_iw_state;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_uop_iw_p1_poisoned;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_uop_iw_p2_poisoned;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_uop_is_br;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_uop_is_jalr;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_uop_is_jal;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_uop_is_sfb;	// mshrs.scala:620:22
  wire [19:0] _mshrs_7_io_replay_bits_uop_br_mask;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_7_io_replay_bits_uop_br_tag;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_7_io_replay_bits_uop_ftq_idx;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_uop_edge_inst;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_7_io_replay_bits_uop_pc_lob;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_uop_taken;	// mshrs.scala:620:22
  wire [19:0] _mshrs_7_io_replay_bits_uop_imm_packed;	// mshrs.scala:620:22
  wire [11:0] _mshrs_7_io_replay_bits_uop_csr_addr;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_7_io_replay_bits_uop_rob_idx;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_7_io_replay_bits_uop_ldq_idx;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_7_io_replay_bits_uop_stq_idx;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_7_io_replay_bits_uop_rxq_idx;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_7_io_replay_bits_uop_pdst;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_7_io_replay_bits_uop_prs1;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_7_io_replay_bits_uop_prs2;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_7_io_replay_bits_uop_prs3;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_7_io_replay_bits_uop_ppred;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_uop_prs1_busy;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_uop_prs2_busy;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_uop_prs3_busy;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_uop_ppred_busy;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_7_io_replay_bits_uop_stale_pdst;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_uop_exception;	// mshrs.scala:620:22
  wire [63:0] _mshrs_7_io_replay_bits_uop_exc_cause;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_uop_bypassable;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_7_io_replay_bits_uop_mem_cmd;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_7_io_replay_bits_uop_mem_size;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_uop_mem_signed;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_uop_is_fence;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_uop_is_fencei;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_uop_is_amo;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_uop_uses_ldq;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_uop_uses_stq;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_uop_is_sys_pc2epc;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_uop_is_unique;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_uop_flush_on_commit;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_uop_ldst_is_rs1;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_7_io_replay_bits_uop_ldst;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_7_io_replay_bits_uop_lrs1;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_7_io_replay_bits_uop_lrs2;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_7_io_replay_bits_uop_lrs3;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_uop_ldst_val;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_7_io_replay_bits_uop_dst_rtype;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_7_io_replay_bits_uop_lrs1_rtype;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_7_io_replay_bits_uop_lrs2_rtype;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_uop_frs3_en;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_uop_fp_val;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_uop_fp_single;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_uop_xcpt_pf_if;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_uop_xcpt_ae_if;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_uop_xcpt_ma_if;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_uop_bp_debug_if;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_uop_bp_xcpt_if;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_7_io_replay_bits_uop_debug_fsrc;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_7_io_replay_bits_uop_debug_tsrc;	// mshrs.scala:620:22
  wire [39:0] _mshrs_7_io_replay_bits_addr;	// mshrs.scala:620:22
  wire        _mshrs_7_io_replay_bits_is_hella;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_7_io_replay_bits_way_en;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_7_io_replay_bits_sdq_id;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_valid;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_7_io_resp_bits_uop_uopc;	// mshrs.scala:620:22
  wire [31:0] _mshrs_7_io_resp_bits_uop_inst;	// mshrs.scala:620:22
  wire [31:0] _mshrs_7_io_resp_bits_uop_debug_inst;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_uop_is_rvc;	// mshrs.scala:620:22
  wire [39:0] _mshrs_7_io_resp_bits_uop_debug_pc;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_7_io_resp_bits_uop_iq_type;	// mshrs.scala:620:22
  wire [9:0]  _mshrs_7_io_resp_bits_uop_fu_code;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_7_io_resp_bits_uop_ctrl_br_type;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_7_io_resp_bits_uop_ctrl_op1_sel;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_7_io_resp_bits_uop_ctrl_op2_sel;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_7_io_resp_bits_uop_ctrl_imm_sel;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_7_io_resp_bits_uop_ctrl_op_fcn;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_uop_ctrl_fcn_dw;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_7_io_resp_bits_uop_ctrl_csr_cmd;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_uop_ctrl_is_load;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_uop_ctrl_is_sta;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_uop_ctrl_is_std;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_7_io_resp_bits_uop_iw_state;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_uop_iw_p1_poisoned;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_uop_iw_p2_poisoned;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_uop_is_br;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_uop_is_jalr;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_uop_is_jal;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_uop_is_sfb;	// mshrs.scala:620:22
  wire [19:0] _mshrs_7_io_resp_bits_uop_br_mask;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_7_io_resp_bits_uop_br_tag;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_7_io_resp_bits_uop_ftq_idx;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_uop_edge_inst;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_7_io_resp_bits_uop_pc_lob;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_uop_taken;	// mshrs.scala:620:22
  wire [19:0] _mshrs_7_io_resp_bits_uop_imm_packed;	// mshrs.scala:620:22
  wire [11:0] _mshrs_7_io_resp_bits_uop_csr_addr;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_7_io_resp_bits_uop_rob_idx;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_7_io_resp_bits_uop_ldq_idx;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_7_io_resp_bits_uop_stq_idx;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_7_io_resp_bits_uop_rxq_idx;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_7_io_resp_bits_uop_pdst;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_7_io_resp_bits_uop_prs1;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_7_io_resp_bits_uop_prs2;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_7_io_resp_bits_uop_prs3;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_7_io_resp_bits_uop_ppred;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_uop_prs1_busy;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_uop_prs2_busy;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_uop_prs3_busy;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_uop_ppred_busy;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_7_io_resp_bits_uop_stale_pdst;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_uop_exception;	// mshrs.scala:620:22
  wire [63:0] _mshrs_7_io_resp_bits_uop_exc_cause;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_uop_bypassable;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_7_io_resp_bits_uop_mem_cmd;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_7_io_resp_bits_uop_mem_size;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_uop_mem_signed;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_uop_is_fence;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_uop_is_fencei;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_uop_is_amo;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_uop_uses_ldq;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_uop_uses_stq;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_uop_is_sys_pc2epc;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_uop_is_unique;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_uop_flush_on_commit;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_uop_ldst_is_rs1;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_7_io_resp_bits_uop_ldst;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_7_io_resp_bits_uop_lrs1;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_7_io_resp_bits_uop_lrs2;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_7_io_resp_bits_uop_lrs3;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_uop_ldst_val;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_7_io_resp_bits_uop_dst_rtype;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_7_io_resp_bits_uop_lrs1_rtype;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_7_io_resp_bits_uop_lrs2_rtype;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_uop_frs3_en;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_uop_fp_val;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_uop_fp_single;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_uop_xcpt_pf_if;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_uop_xcpt_ae_if;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_uop_xcpt_ma_if;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_uop_bp_debug_if;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_uop_bp_xcpt_if;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_7_io_resp_bits_uop_debug_fsrc;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_7_io_resp_bits_uop_debug_tsrc;	// mshrs.scala:620:22
  wire [63:0] _mshrs_7_io_resp_bits_data;	// mshrs.scala:620:22
  wire        _mshrs_7_io_resp_bits_is_hella;	// mshrs.scala:620:22
  wire        _mshrs_7_io_probe_rdy;	// mshrs.scala:620:22
  wire        _mshrs_6_io_req_pri_rdy;	// mshrs.scala:620:22
  wire        _mshrs_6_io_req_sec_rdy;	// mshrs.scala:620:22
  wire        _mshrs_6_io_idx_valid;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_6_io_idx_bits;	// mshrs.scala:620:22
  wire        _mshrs_6_io_way_valid;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_6_io_way_bits;	// mshrs.scala:620:22
  wire        _mshrs_6_io_tag_valid;	// mshrs.scala:620:22
  wire [27:0] _mshrs_6_io_tag_bits;	// mshrs.scala:620:22
  wire        _mshrs_6_io_mem_acquire_valid;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_6_io_mem_acquire_bits_param;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_6_io_mem_acquire_bits_source;	// mshrs.scala:620:22
  wire [31:0] _mshrs_6_io_mem_acquire_bits_address;	// mshrs.scala:620:22
  wire        _mshrs_6_io_mem_grant_ready;	// mshrs.scala:620:22
  wire        _mshrs_6_io_mem_finish_valid;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_6_io_mem_finish_bits_sink;	// mshrs.scala:620:22
  wire        _mshrs_6_io_refill_valid;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_6_io_refill_bits_way_en;	// mshrs.scala:620:22
  wire [11:0] _mshrs_6_io_refill_bits_addr;	// mshrs.scala:620:22
  wire [63:0] _mshrs_6_io_refill_bits_data;	// mshrs.scala:620:22
  wire        _mshrs_6_io_meta_write_valid;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_6_io_meta_write_bits_idx;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_6_io_meta_write_bits_way_en;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_6_io_meta_write_bits_data_coh_state;	// mshrs.scala:620:22
  wire [19:0] _mshrs_6_io_meta_write_bits_data_tag;	// mshrs.scala:620:22
  wire        _mshrs_6_io_meta_read_valid;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_6_io_meta_read_bits_idx;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_6_io_meta_read_bits_way_en;	// mshrs.scala:620:22
  wire [19:0] _mshrs_6_io_meta_read_bits_tag;	// mshrs.scala:620:22
  wire        _mshrs_6_io_wb_req_valid;	// mshrs.scala:620:22
  wire [19:0] _mshrs_6_io_wb_req_bits_tag;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_6_io_wb_req_bits_idx;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_6_io_wb_req_bits_param;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_6_io_wb_req_bits_way_en;	// mshrs.scala:620:22
  wire        _mshrs_6_io_commit_val;	// mshrs.scala:620:22
  wire [39:0] _mshrs_6_io_commit_addr;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_6_io_commit_coh_state;	// mshrs.scala:620:22
  wire        _mshrs_6_io_lb_read_valid;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_6_io_lb_read_bits_id;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_6_io_lb_read_bits_offset;	// mshrs.scala:620:22
  wire        _mshrs_6_io_lb_write_valid;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_6_io_lb_write_bits_id;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_6_io_lb_write_bits_offset;	// mshrs.scala:620:22
  wire [63:0] _mshrs_6_io_lb_write_bits_data;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_valid;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_6_io_replay_bits_uop_uopc;	// mshrs.scala:620:22
  wire [31:0] _mshrs_6_io_replay_bits_uop_inst;	// mshrs.scala:620:22
  wire [31:0] _mshrs_6_io_replay_bits_uop_debug_inst;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_uop_is_rvc;	// mshrs.scala:620:22
  wire [39:0] _mshrs_6_io_replay_bits_uop_debug_pc;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_6_io_replay_bits_uop_iq_type;	// mshrs.scala:620:22
  wire [9:0]  _mshrs_6_io_replay_bits_uop_fu_code;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_6_io_replay_bits_uop_ctrl_br_type;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_6_io_replay_bits_uop_ctrl_op1_sel;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_6_io_replay_bits_uop_ctrl_op2_sel;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_6_io_replay_bits_uop_ctrl_imm_sel;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_6_io_replay_bits_uop_ctrl_op_fcn;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_uop_ctrl_fcn_dw;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_6_io_replay_bits_uop_ctrl_csr_cmd;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_uop_ctrl_is_load;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_uop_ctrl_is_sta;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_uop_ctrl_is_std;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_6_io_replay_bits_uop_iw_state;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_uop_iw_p1_poisoned;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_uop_iw_p2_poisoned;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_uop_is_br;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_uop_is_jalr;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_uop_is_jal;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_uop_is_sfb;	// mshrs.scala:620:22
  wire [19:0] _mshrs_6_io_replay_bits_uop_br_mask;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_6_io_replay_bits_uop_br_tag;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_6_io_replay_bits_uop_ftq_idx;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_uop_edge_inst;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_6_io_replay_bits_uop_pc_lob;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_uop_taken;	// mshrs.scala:620:22
  wire [19:0] _mshrs_6_io_replay_bits_uop_imm_packed;	// mshrs.scala:620:22
  wire [11:0] _mshrs_6_io_replay_bits_uop_csr_addr;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_6_io_replay_bits_uop_rob_idx;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_6_io_replay_bits_uop_ldq_idx;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_6_io_replay_bits_uop_stq_idx;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_6_io_replay_bits_uop_rxq_idx;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_6_io_replay_bits_uop_pdst;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_6_io_replay_bits_uop_prs1;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_6_io_replay_bits_uop_prs2;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_6_io_replay_bits_uop_prs3;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_6_io_replay_bits_uop_ppred;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_uop_prs1_busy;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_uop_prs2_busy;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_uop_prs3_busy;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_uop_ppred_busy;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_6_io_replay_bits_uop_stale_pdst;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_uop_exception;	// mshrs.scala:620:22
  wire [63:0] _mshrs_6_io_replay_bits_uop_exc_cause;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_uop_bypassable;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_6_io_replay_bits_uop_mem_cmd;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_6_io_replay_bits_uop_mem_size;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_uop_mem_signed;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_uop_is_fence;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_uop_is_fencei;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_uop_is_amo;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_uop_uses_ldq;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_uop_uses_stq;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_uop_is_sys_pc2epc;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_uop_is_unique;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_uop_flush_on_commit;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_uop_ldst_is_rs1;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_6_io_replay_bits_uop_ldst;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_6_io_replay_bits_uop_lrs1;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_6_io_replay_bits_uop_lrs2;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_6_io_replay_bits_uop_lrs3;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_uop_ldst_val;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_6_io_replay_bits_uop_dst_rtype;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_6_io_replay_bits_uop_lrs1_rtype;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_6_io_replay_bits_uop_lrs2_rtype;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_uop_frs3_en;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_uop_fp_val;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_uop_fp_single;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_uop_xcpt_pf_if;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_uop_xcpt_ae_if;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_uop_xcpt_ma_if;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_uop_bp_debug_if;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_uop_bp_xcpt_if;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_6_io_replay_bits_uop_debug_fsrc;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_6_io_replay_bits_uop_debug_tsrc;	// mshrs.scala:620:22
  wire [39:0] _mshrs_6_io_replay_bits_addr;	// mshrs.scala:620:22
  wire        _mshrs_6_io_replay_bits_is_hella;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_6_io_replay_bits_way_en;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_6_io_replay_bits_sdq_id;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_valid;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_6_io_resp_bits_uop_uopc;	// mshrs.scala:620:22
  wire [31:0] _mshrs_6_io_resp_bits_uop_inst;	// mshrs.scala:620:22
  wire [31:0] _mshrs_6_io_resp_bits_uop_debug_inst;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_uop_is_rvc;	// mshrs.scala:620:22
  wire [39:0] _mshrs_6_io_resp_bits_uop_debug_pc;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_6_io_resp_bits_uop_iq_type;	// mshrs.scala:620:22
  wire [9:0]  _mshrs_6_io_resp_bits_uop_fu_code;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_6_io_resp_bits_uop_ctrl_br_type;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_6_io_resp_bits_uop_ctrl_op1_sel;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_6_io_resp_bits_uop_ctrl_op2_sel;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_6_io_resp_bits_uop_ctrl_imm_sel;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_6_io_resp_bits_uop_ctrl_op_fcn;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_uop_ctrl_fcn_dw;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_6_io_resp_bits_uop_ctrl_csr_cmd;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_uop_ctrl_is_load;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_uop_ctrl_is_sta;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_uop_ctrl_is_std;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_6_io_resp_bits_uop_iw_state;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_uop_iw_p1_poisoned;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_uop_iw_p2_poisoned;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_uop_is_br;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_uop_is_jalr;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_uop_is_jal;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_uop_is_sfb;	// mshrs.scala:620:22
  wire [19:0] _mshrs_6_io_resp_bits_uop_br_mask;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_6_io_resp_bits_uop_br_tag;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_6_io_resp_bits_uop_ftq_idx;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_uop_edge_inst;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_6_io_resp_bits_uop_pc_lob;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_uop_taken;	// mshrs.scala:620:22
  wire [19:0] _mshrs_6_io_resp_bits_uop_imm_packed;	// mshrs.scala:620:22
  wire [11:0] _mshrs_6_io_resp_bits_uop_csr_addr;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_6_io_resp_bits_uop_rob_idx;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_6_io_resp_bits_uop_ldq_idx;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_6_io_resp_bits_uop_stq_idx;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_6_io_resp_bits_uop_rxq_idx;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_6_io_resp_bits_uop_pdst;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_6_io_resp_bits_uop_prs1;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_6_io_resp_bits_uop_prs2;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_6_io_resp_bits_uop_prs3;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_6_io_resp_bits_uop_ppred;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_uop_prs1_busy;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_uop_prs2_busy;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_uop_prs3_busy;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_uop_ppred_busy;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_6_io_resp_bits_uop_stale_pdst;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_uop_exception;	// mshrs.scala:620:22
  wire [63:0] _mshrs_6_io_resp_bits_uop_exc_cause;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_uop_bypassable;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_6_io_resp_bits_uop_mem_cmd;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_6_io_resp_bits_uop_mem_size;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_uop_mem_signed;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_uop_is_fence;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_uop_is_fencei;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_uop_is_amo;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_uop_uses_ldq;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_uop_uses_stq;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_uop_is_sys_pc2epc;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_uop_is_unique;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_uop_flush_on_commit;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_uop_ldst_is_rs1;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_6_io_resp_bits_uop_ldst;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_6_io_resp_bits_uop_lrs1;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_6_io_resp_bits_uop_lrs2;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_6_io_resp_bits_uop_lrs3;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_uop_ldst_val;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_6_io_resp_bits_uop_dst_rtype;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_6_io_resp_bits_uop_lrs1_rtype;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_6_io_resp_bits_uop_lrs2_rtype;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_uop_frs3_en;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_uop_fp_val;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_uop_fp_single;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_uop_xcpt_pf_if;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_uop_xcpt_ae_if;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_uop_xcpt_ma_if;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_uop_bp_debug_if;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_uop_bp_xcpt_if;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_6_io_resp_bits_uop_debug_fsrc;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_6_io_resp_bits_uop_debug_tsrc;	// mshrs.scala:620:22
  wire [63:0] _mshrs_6_io_resp_bits_data;	// mshrs.scala:620:22
  wire        _mshrs_6_io_resp_bits_is_hella;	// mshrs.scala:620:22
  wire        _mshrs_6_io_probe_rdy;	// mshrs.scala:620:22
  wire        _mshrs_5_io_req_pri_rdy;	// mshrs.scala:620:22
  wire        _mshrs_5_io_req_sec_rdy;	// mshrs.scala:620:22
  wire        _mshrs_5_io_idx_valid;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_5_io_idx_bits;	// mshrs.scala:620:22
  wire        _mshrs_5_io_way_valid;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_5_io_way_bits;	// mshrs.scala:620:22
  wire        _mshrs_5_io_tag_valid;	// mshrs.scala:620:22
  wire [27:0] _mshrs_5_io_tag_bits;	// mshrs.scala:620:22
  wire        _mshrs_5_io_mem_acquire_valid;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_5_io_mem_acquire_bits_param;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_5_io_mem_acquire_bits_source;	// mshrs.scala:620:22
  wire [31:0] _mshrs_5_io_mem_acquire_bits_address;	// mshrs.scala:620:22
  wire        _mshrs_5_io_mem_grant_ready;	// mshrs.scala:620:22
  wire        _mshrs_5_io_mem_finish_valid;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_5_io_mem_finish_bits_sink;	// mshrs.scala:620:22
  wire        _mshrs_5_io_refill_valid;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_5_io_refill_bits_way_en;	// mshrs.scala:620:22
  wire [11:0] _mshrs_5_io_refill_bits_addr;	// mshrs.scala:620:22
  wire [63:0] _mshrs_5_io_refill_bits_data;	// mshrs.scala:620:22
  wire        _mshrs_5_io_meta_write_valid;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_5_io_meta_write_bits_idx;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_5_io_meta_write_bits_way_en;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_5_io_meta_write_bits_data_coh_state;	// mshrs.scala:620:22
  wire [19:0] _mshrs_5_io_meta_write_bits_data_tag;	// mshrs.scala:620:22
  wire        _mshrs_5_io_meta_read_valid;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_5_io_meta_read_bits_idx;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_5_io_meta_read_bits_way_en;	// mshrs.scala:620:22
  wire [19:0] _mshrs_5_io_meta_read_bits_tag;	// mshrs.scala:620:22
  wire        _mshrs_5_io_wb_req_valid;	// mshrs.scala:620:22
  wire [19:0] _mshrs_5_io_wb_req_bits_tag;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_5_io_wb_req_bits_idx;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_5_io_wb_req_bits_param;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_5_io_wb_req_bits_way_en;	// mshrs.scala:620:22
  wire        _mshrs_5_io_commit_val;	// mshrs.scala:620:22
  wire [39:0] _mshrs_5_io_commit_addr;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_5_io_commit_coh_state;	// mshrs.scala:620:22
  wire        _mshrs_5_io_lb_read_valid;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_5_io_lb_read_bits_id;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_5_io_lb_read_bits_offset;	// mshrs.scala:620:22
  wire        _mshrs_5_io_lb_write_valid;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_5_io_lb_write_bits_id;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_5_io_lb_write_bits_offset;	// mshrs.scala:620:22
  wire [63:0] _mshrs_5_io_lb_write_bits_data;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_valid;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_5_io_replay_bits_uop_uopc;	// mshrs.scala:620:22
  wire [31:0] _mshrs_5_io_replay_bits_uop_inst;	// mshrs.scala:620:22
  wire [31:0] _mshrs_5_io_replay_bits_uop_debug_inst;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_uop_is_rvc;	// mshrs.scala:620:22
  wire [39:0] _mshrs_5_io_replay_bits_uop_debug_pc;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_5_io_replay_bits_uop_iq_type;	// mshrs.scala:620:22
  wire [9:0]  _mshrs_5_io_replay_bits_uop_fu_code;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_5_io_replay_bits_uop_ctrl_br_type;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_5_io_replay_bits_uop_ctrl_op1_sel;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_5_io_replay_bits_uop_ctrl_op2_sel;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_5_io_replay_bits_uop_ctrl_imm_sel;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_5_io_replay_bits_uop_ctrl_op_fcn;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_uop_ctrl_fcn_dw;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_5_io_replay_bits_uop_ctrl_csr_cmd;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_uop_ctrl_is_load;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_uop_ctrl_is_sta;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_uop_ctrl_is_std;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_5_io_replay_bits_uop_iw_state;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_uop_iw_p1_poisoned;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_uop_iw_p2_poisoned;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_uop_is_br;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_uop_is_jalr;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_uop_is_jal;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_uop_is_sfb;	// mshrs.scala:620:22
  wire [19:0] _mshrs_5_io_replay_bits_uop_br_mask;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_5_io_replay_bits_uop_br_tag;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_5_io_replay_bits_uop_ftq_idx;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_uop_edge_inst;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_5_io_replay_bits_uop_pc_lob;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_uop_taken;	// mshrs.scala:620:22
  wire [19:0] _mshrs_5_io_replay_bits_uop_imm_packed;	// mshrs.scala:620:22
  wire [11:0] _mshrs_5_io_replay_bits_uop_csr_addr;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_5_io_replay_bits_uop_rob_idx;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_5_io_replay_bits_uop_ldq_idx;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_5_io_replay_bits_uop_stq_idx;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_5_io_replay_bits_uop_rxq_idx;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_5_io_replay_bits_uop_pdst;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_5_io_replay_bits_uop_prs1;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_5_io_replay_bits_uop_prs2;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_5_io_replay_bits_uop_prs3;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_5_io_replay_bits_uop_ppred;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_uop_prs1_busy;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_uop_prs2_busy;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_uop_prs3_busy;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_uop_ppred_busy;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_5_io_replay_bits_uop_stale_pdst;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_uop_exception;	// mshrs.scala:620:22
  wire [63:0] _mshrs_5_io_replay_bits_uop_exc_cause;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_uop_bypassable;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_5_io_replay_bits_uop_mem_cmd;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_5_io_replay_bits_uop_mem_size;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_uop_mem_signed;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_uop_is_fence;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_uop_is_fencei;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_uop_is_amo;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_uop_uses_ldq;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_uop_uses_stq;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_uop_is_sys_pc2epc;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_uop_is_unique;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_uop_flush_on_commit;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_uop_ldst_is_rs1;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_5_io_replay_bits_uop_ldst;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_5_io_replay_bits_uop_lrs1;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_5_io_replay_bits_uop_lrs2;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_5_io_replay_bits_uop_lrs3;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_uop_ldst_val;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_5_io_replay_bits_uop_dst_rtype;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_5_io_replay_bits_uop_lrs1_rtype;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_5_io_replay_bits_uop_lrs2_rtype;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_uop_frs3_en;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_uop_fp_val;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_uop_fp_single;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_uop_xcpt_pf_if;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_uop_xcpt_ae_if;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_uop_xcpt_ma_if;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_uop_bp_debug_if;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_uop_bp_xcpt_if;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_5_io_replay_bits_uop_debug_fsrc;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_5_io_replay_bits_uop_debug_tsrc;	// mshrs.scala:620:22
  wire [39:0] _mshrs_5_io_replay_bits_addr;	// mshrs.scala:620:22
  wire        _mshrs_5_io_replay_bits_is_hella;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_5_io_replay_bits_way_en;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_5_io_replay_bits_sdq_id;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_valid;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_5_io_resp_bits_uop_uopc;	// mshrs.scala:620:22
  wire [31:0] _mshrs_5_io_resp_bits_uop_inst;	// mshrs.scala:620:22
  wire [31:0] _mshrs_5_io_resp_bits_uop_debug_inst;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_uop_is_rvc;	// mshrs.scala:620:22
  wire [39:0] _mshrs_5_io_resp_bits_uop_debug_pc;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_5_io_resp_bits_uop_iq_type;	// mshrs.scala:620:22
  wire [9:0]  _mshrs_5_io_resp_bits_uop_fu_code;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_5_io_resp_bits_uop_ctrl_br_type;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_5_io_resp_bits_uop_ctrl_op1_sel;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_5_io_resp_bits_uop_ctrl_op2_sel;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_5_io_resp_bits_uop_ctrl_imm_sel;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_5_io_resp_bits_uop_ctrl_op_fcn;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_uop_ctrl_fcn_dw;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_5_io_resp_bits_uop_ctrl_csr_cmd;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_uop_ctrl_is_load;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_uop_ctrl_is_sta;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_uop_ctrl_is_std;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_5_io_resp_bits_uop_iw_state;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_uop_iw_p1_poisoned;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_uop_iw_p2_poisoned;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_uop_is_br;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_uop_is_jalr;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_uop_is_jal;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_uop_is_sfb;	// mshrs.scala:620:22
  wire [19:0] _mshrs_5_io_resp_bits_uop_br_mask;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_5_io_resp_bits_uop_br_tag;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_5_io_resp_bits_uop_ftq_idx;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_uop_edge_inst;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_5_io_resp_bits_uop_pc_lob;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_uop_taken;	// mshrs.scala:620:22
  wire [19:0] _mshrs_5_io_resp_bits_uop_imm_packed;	// mshrs.scala:620:22
  wire [11:0] _mshrs_5_io_resp_bits_uop_csr_addr;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_5_io_resp_bits_uop_rob_idx;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_5_io_resp_bits_uop_ldq_idx;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_5_io_resp_bits_uop_stq_idx;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_5_io_resp_bits_uop_rxq_idx;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_5_io_resp_bits_uop_pdst;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_5_io_resp_bits_uop_prs1;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_5_io_resp_bits_uop_prs2;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_5_io_resp_bits_uop_prs3;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_5_io_resp_bits_uop_ppred;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_uop_prs1_busy;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_uop_prs2_busy;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_uop_prs3_busy;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_uop_ppred_busy;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_5_io_resp_bits_uop_stale_pdst;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_uop_exception;	// mshrs.scala:620:22
  wire [63:0] _mshrs_5_io_resp_bits_uop_exc_cause;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_uop_bypassable;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_5_io_resp_bits_uop_mem_cmd;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_5_io_resp_bits_uop_mem_size;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_uop_mem_signed;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_uop_is_fence;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_uop_is_fencei;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_uop_is_amo;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_uop_uses_ldq;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_uop_uses_stq;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_uop_is_sys_pc2epc;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_uop_is_unique;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_uop_flush_on_commit;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_uop_ldst_is_rs1;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_5_io_resp_bits_uop_ldst;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_5_io_resp_bits_uop_lrs1;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_5_io_resp_bits_uop_lrs2;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_5_io_resp_bits_uop_lrs3;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_uop_ldst_val;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_5_io_resp_bits_uop_dst_rtype;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_5_io_resp_bits_uop_lrs1_rtype;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_5_io_resp_bits_uop_lrs2_rtype;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_uop_frs3_en;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_uop_fp_val;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_uop_fp_single;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_uop_xcpt_pf_if;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_uop_xcpt_ae_if;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_uop_xcpt_ma_if;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_uop_bp_debug_if;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_uop_bp_xcpt_if;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_5_io_resp_bits_uop_debug_fsrc;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_5_io_resp_bits_uop_debug_tsrc;	// mshrs.scala:620:22
  wire [63:0] _mshrs_5_io_resp_bits_data;	// mshrs.scala:620:22
  wire        _mshrs_5_io_resp_bits_is_hella;	// mshrs.scala:620:22
  wire        _mshrs_5_io_probe_rdy;	// mshrs.scala:620:22
  wire        _mshrs_4_io_req_pri_rdy;	// mshrs.scala:620:22
  wire        _mshrs_4_io_req_sec_rdy;	// mshrs.scala:620:22
  wire        _mshrs_4_io_idx_valid;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_4_io_idx_bits;	// mshrs.scala:620:22
  wire        _mshrs_4_io_way_valid;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_4_io_way_bits;	// mshrs.scala:620:22
  wire        _mshrs_4_io_tag_valid;	// mshrs.scala:620:22
  wire [27:0] _mshrs_4_io_tag_bits;	// mshrs.scala:620:22
  wire        _mshrs_4_io_mem_acquire_valid;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_4_io_mem_acquire_bits_param;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_4_io_mem_acquire_bits_source;	// mshrs.scala:620:22
  wire [31:0] _mshrs_4_io_mem_acquire_bits_address;	// mshrs.scala:620:22
  wire        _mshrs_4_io_mem_grant_ready;	// mshrs.scala:620:22
  wire        _mshrs_4_io_mem_finish_valid;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_4_io_mem_finish_bits_sink;	// mshrs.scala:620:22
  wire        _mshrs_4_io_refill_valid;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_4_io_refill_bits_way_en;	// mshrs.scala:620:22
  wire [11:0] _mshrs_4_io_refill_bits_addr;	// mshrs.scala:620:22
  wire [63:0] _mshrs_4_io_refill_bits_data;	// mshrs.scala:620:22
  wire        _mshrs_4_io_meta_write_valid;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_4_io_meta_write_bits_idx;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_4_io_meta_write_bits_way_en;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_4_io_meta_write_bits_data_coh_state;	// mshrs.scala:620:22
  wire [19:0] _mshrs_4_io_meta_write_bits_data_tag;	// mshrs.scala:620:22
  wire        _mshrs_4_io_meta_read_valid;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_4_io_meta_read_bits_idx;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_4_io_meta_read_bits_way_en;	// mshrs.scala:620:22
  wire [19:0] _mshrs_4_io_meta_read_bits_tag;	// mshrs.scala:620:22
  wire        _mshrs_4_io_wb_req_valid;	// mshrs.scala:620:22
  wire [19:0] _mshrs_4_io_wb_req_bits_tag;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_4_io_wb_req_bits_idx;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_4_io_wb_req_bits_param;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_4_io_wb_req_bits_way_en;	// mshrs.scala:620:22
  wire        _mshrs_4_io_commit_val;	// mshrs.scala:620:22
  wire [39:0] _mshrs_4_io_commit_addr;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_4_io_commit_coh_state;	// mshrs.scala:620:22
  wire        _mshrs_4_io_lb_read_valid;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_4_io_lb_read_bits_id;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_4_io_lb_read_bits_offset;	// mshrs.scala:620:22
  wire        _mshrs_4_io_lb_write_valid;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_4_io_lb_write_bits_id;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_4_io_lb_write_bits_offset;	// mshrs.scala:620:22
  wire [63:0] _mshrs_4_io_lb_write_bits_data;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_valid;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_4_io_replay_bits_uop_uopc;	// mshrs.scala:620:22
  wire [31:0] _mshrs_4_io_replay_bits_uop_inst;	// mshrs.scala:620:22
  wire [31:0] _mshrs_4_io_replay_bits_uop_debug_inst;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_uop_is_rvc;	// mshrs.scala:620:22
  wire [39:0] _mshrs_4_io_replay_bits_uop_debug_pc;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_4_io_replay_bits_uop_iq_type;	// mshrs.scala:620:22
  wire [9:0]  _mshrs_4_io_replay_bits_uop_fu_code;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_4_io_replay_bits_uop_ctrl_br_type;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_4_io_replay_bits_uop_ctrl_op1_sel;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_4_io_replay_bits_uop_ctrl_op2_sel;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_4_io_replay_bits_uop_ctrl_imm_sel;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_4_io_replay_bits_uop_ctrl_op_fcn;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_uop_ctrl_fcn_dw;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_4_io_replay_bits_uop_ctrl_csr_cmd;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_uop_ctrl_is_load;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_uop_ctrl_is_sta;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_uop_ctrl_is_std;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_4_io_replay_bits_uop_iw_state;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_uop_iw_p1_poisoned;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_uop_iw_p2_poisoned;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_uop_is_br;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_uop_is_jalr;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_uop_is_jal;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_uop_is_sfb;	// mshrs.scala:620:22
  wire [19:0] _mshrs_4_io_replay_bits_uop_br_mask;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_4_io_replay_bits_uop_br_tag;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_4_io_replay_bits_uop_ftq_idx;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_uop_edge_inst;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_4_io_replay_bits_uop_pc_lob;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_uop_taken;	// mshrs.scala:620:22
  wire [19:0] _mshrs_4_io_replay_bits_uop_imm_packed;	// mshrs.scala:620:22
  wire [11:0] _mshrs_4_io_replay_bits_uop_csr_addr;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_4_io_replay_bits_uop_rob_idx;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_4_io_replay_bits_uop_ldq_idx;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_4_io_replay_bits_uop_stq_idx;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_4_io_replay_bits_uop_rxq_idx;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_4_io_replay_bits_uop_pdst;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_4_io_replay_bits_uop_prs1;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_4_io_replay_bits_uop_prs2;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_4_io_replay_bits_uop_prs3;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_4_io_replay_bits_uop_ppred;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_uop_prs1_busy;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_uop_prs2_busy;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_uop_prs3_busy;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_uop_ppred_busy;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_4_io_replay_bits_uop_stale_pdst;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_uop_exception;	// mshrs.scala:620:22
  wire [63:0] _mshrs_4_io_replay_bits_uop_exc_cause;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_uop_bypassable;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_4_io_replay_bits_uop_mem_cmd;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_4_io_replay_bits_uop_mem_size;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_uop_mem_signed;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_uop_is_fence;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_uop_is_fencei;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_uop_is_amo;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_uop_uses_ldq;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_uop_uses_stq;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_uop_is_sys_pc2epc;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_uop_is_unique;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_uop_flush_on_commit;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_uop_ldst_is_rs1;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_4_io_replay_bits_uop_ldst;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_4_io_replay_bits_uop_lrs1;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_4_io_replay_bits_uop_lrs2;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_4_io_replay_bits_uop_lrs3;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_uop_ldst_val;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_4_io_replay_bits_uop_dst_rtype;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_4_io_replay_bits_uop_lrs1_rtype;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_4_io_replay_bits_uop_lrs2_rtype;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_uop_frs3_en;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_uop_fp_val;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_uop_fp_single;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_uop_xcpt_pf_if;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_uop_xcpt_ae_if;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_uop_xcpt_ma_if;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_uop_bp_debug_if;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_uop_bp_xcpt_if;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_4_io_replay_bits_uop_debug_fsrc;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_4_io_replay_bits_uop_debug_tsrc;	// mshrs.scala:620:22
  wire [39:0] _mshrs_4_io_replay_bits_addr;	// mshrs.scala:620:22
  wire        _mshrs_4_io_replay_bits_is_hella;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_4_io_replay_bits_way_en;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_4_io_replay_bits_sdq_id;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_valid;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_4_io_resp_bits_uop_uopc;	// mshrs.scala:620:22
  wire [31:0] _mshrs_4_io_resp_bits_uop_inst;	// mshrs.scala:620:22
  wire [31:0] _mshrs_4_io_resp_bits_uop_debug_inst;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_uop_is_rvc;	// mshrs.scala:620:22
  wire [39:0] _mshrs_4_io_resp_bits_uop_debug_pc;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_4_io_resp_bits_uop_iq_type;	// mshrs.scala:620:22
  wire [9:0]  _mshrs_4_io_resp_bits_uop_fu_code;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_4_io_resp_bits_uop_ctrl_br_type;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_4_io_resp_bits_uop_ctrl_op1_sel;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_4_io_resp_bits_uop_ctrl_op2_sel;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_4_io_resp_bits_uop_ctrl_imm_sel;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_4_io_resp_bits_uop_ctrl_op_fcn;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_uop_ctrl_fcn_dw;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_4_io_resp_bits_uop_ctrl_csr_cmd;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_uop_ctrl_is_load;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_uop_ctrl_is_sta;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_uop_ctrl_is_std;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_4_io_resp_bits_uop_iw_state;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_uop_iw_p1_poisoned;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_uop_iw_p2_poisoned;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_uop_is_br;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_uop_is_jalr;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_uop_is_jal;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_uop_is_sfb;	// mshrs.scala:620:22
  wire [19:0] _mshrs_4_io_resp_bits_uop_br_mask;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_4_io_resp_bits_uop_br_tag;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_4_io_resp_bits_uop_ftq_idx;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_uop_edge_inst;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_4_io_resp_bits_uop_pc_lob;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_uop_taken;	// mshrs.scala:620:22
  wire [19:0] _mshrs_4_io_resp_bits_uop_imm_packed;	// mshrs.scala:620:22
  wire [11:0] _mshrs_4_io_resp_bits_uop_csr_addr;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_4_io_resp_bits_uop_rob_idx;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_4_io_resp_bits_uop_ldq_idx;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_4_io_resp_bits_uop_stq_idx;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_4_io_resp_bits_uop_rxq_idx;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_4_io_resp_bits_uop_pdst;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_4_io_resp_bits_uop_prs1;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_4_io_resp_bits_uop_prs2;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_4_io_resp_bits_uop_prs3;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_4_io_resp_bits_uop_ppred;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_uop_prs1_busy;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_uop_prs2_busy;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_uop_prs3_busy;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_uop_ppred_busy;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_4_io_resp_bits_uop_stale_pdst;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_uop_exception;	// mshrs.scala:620:22
  wire [63:0] _mshrs_4_io_resp_bits_uop_exc_cause;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_uop_bypassable;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_4_io_resp_bits_uop_mem_cmd;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_4_io_resp_bits_uop_mem_size;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_uop_mem_signed;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_uop_is_fence;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_uop_is_fencei;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_uop_is_amo;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_uop_uses_ldq;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_uop_uses_stq;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_uop_is_sys_pc2epc;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_uop_is_unique;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_uop_flush_on_commit;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_uop_ldst_is_rs1;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_4_io_resp_bits_uop_ldst;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_4_io_resp_bits_uop_lrs1;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_4_io_resp_bits_uop_lrs2;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_4_io_resp_bits_uop_lrs3;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_uop_ldst_val;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_4_io_resp_bits_uop_dst_rtype;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_4_io_resp_bits_uop_lrs1_rtype;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_4_io_resp_bits_uop_lrs2_rtype;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_uop_frs3_en;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_uop_fp_val;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_uop_fp_single;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_uop_xcpt_pf_if;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_uop_xcpt_ae_if;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_uop_xcpt_ma_if;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_uop_bp_debug_if;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_uop_bp_xcpt_if;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_4_io_resp_bits_uop_debug_fsrc;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_4_io_resp_bits_uop_debug_tsrc;	// mshrs.scala:620:22
  wire [63:0] _mshrs_4_io_resp_bits_data;	// mshrs.scala:620:22
  wire        _mshrs_4_io_resp_bits_is_hella;	// mshrs.scala:620:22
  wire        _mshrs_4_io_probe_rdy;	// mshrs.scala:620:22
  wire        _mshrs_3_io_req_pri_rdy;	// mshrs.scala:620:22
  wire        _mshrs_3_io_req_sec_rdy;	// mshrs.scala:620:22
  wire        _mshrs_3_io_idx_valid;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_3_io_idx_bits;	// mshrs.scala:620:22
  wire        _mshrs_3_io_way_valid;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_3_io_way_bits;	// mshrs.scala:620:22
  wire        _mshrs_3_io_tag_valid;	// mshrs.scala:620:22
  wire [27:0] _mshrs_3_io_tag_bits;	// mshrs.scala:620:22
  wire        _mshrs_3_io_mem_acquire_valid;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_3_io_mem_acquire_bits_param;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_3_io_mem_acquire_bits_source;	// mshrs.scala:620:22
  wire [31:0] _mshrs_3_io_mem_acquire_bits_address;	// mshrs.scala:620:22
  wire        _mshrs_3_io_mem_grant_ready;	// mshrs.scala:620:22
  wire        _mshrs_3_io_mem_finish_valid;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_3_io_mem_finish_bits_sink;	// mshrs.scala:620:22
  wire        _mshrs_3_io_refill_valid;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_3_io_refill_bits_way_en;	// mshrs.scala:620:22
  wire [11:0] _mshrs_3_io_refill_bits_addr;	// mshrs.scala:620:22
  wire [63:0] _mshrs_3_io_refill_bits_data;	// mshrs.scala:620:22
  wire        _mshrs_3_io_meta_write_valid;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_3_io_meta_write_bits_idx;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_3_io_meta_write_bits_way_en;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_3_io_meta_write_bits_data_coh_state;	// mshrs.scala:620:22
  wire [19:0] _mshrs_3_io_meta_write_bits_data_tag;	// mshrs.scala:620:22
  wire        _mshrs_3_io_meta_read_valid;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_3_io_meta_read_bits_idx;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_3_io_meta_read_bits_way_en;	// mshrs.scala:620:22
  wire [19:0] _mshrs_3_io_meta_read_bits_tag;	// mshrs.scala:620:22
  wire        _mshrs_3_io_wb_req_valid;	// mshrs.scala:620:22
  wire [19:0] _mshrs_3_io_wb_req_bits_tag;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_3_io_wb_req_bits_idx;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_3_io_wb_req_bits_param;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_3_io_wb_req_bits_way_en;	// mshrs.scala:620:22
  wire        _mshrs_3_io_commit_val;	// mshrs.scala:620:22
  wire [39:0] _mshrs_3_io_commit_addr;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_3_io_commit_coh_state;	// mshrs.scala:620:22
  wire        _mshrs_3_io_lb_read_valid;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_3_io_lb_read_bits_id;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_3_io_lb_read_bits_offset;	// mshrs.scala:620:22
  wire        _mshrs_3_io_lb_write_valid;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_3_io_lb_write_bits_id;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_3_io_lb_write_bits_offset;	// mshrs.scala:620:22
  wire [63:0] _mshrs_3_io_lb_write_bits_data;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_valid;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_3_io_replay_bits_uop_uopc;	// mshrs.scala:620:22
  wire [31:0] _mshrs_3_io_replay_bits_uop_inst;	// mshrs.scala:620:22
  wire [31:0] _mshrs_3_io_replay_bits_uop_debug_inst;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_uop_is_rvc;	// mshrs.scala:620:22
  wire [39:0] _mshrs_3_io_replay_bits_uop_debug_pc;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_3_io_replay_bits_uop_iq_type;	// mshrs.scala:620:22
  wire [9:0]  _mshrs_3_io_replay_bits_uop_fu_code;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_3_io_replay_bits_uop_ctrl_br_type;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_3_io_replay_bits_uop_ctrl_op1_sel;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_3_io_replay_bits_uop_ctrl_op2_sel;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_3_io_replay_bits_uop_ctrl_imm_sel;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_3_io_replay_bits_uop_ctrl_op_fcn;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_uop_ctrl_fcn_dw;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_3_io_replay_bits_uop_ctrl_csr_cmd;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_uop_ctrl_is_load;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_uop_ctrl_is_sta;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_uop_ctrl_is_std;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_3_io_replay_bits_uop_iw_state;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_uop_iw_p1_poisoned;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_uop_iw_p2_poisoned;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_uop_is_br;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_uop_is_jalr;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_uop_is_jal;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_uop_is_sfb;	// mshrs.scala:620:22
  wire [19:0] _mshrs_3_io_replay_bits_uop_br_mask;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_3_io_replay_bits_uop_br_tag;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_3_io_replay_bits_uop_ftq_idx;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_uop_edge_inst;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_3_io_replay_bits_uop_pc_lob;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_uop_taken;	// mshrs.scala:620:22
  wire [19:0] _mshrs_3_io_replay_bits_uop_imm_packed;	// mshrs.scala:620:22
  wire [11:0] _mshrs_3_io_replay_bits_uop_csr_addr;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_3_io_replay_bits_uop_rob_idx;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_3_io_replay_bits_uop_ldq_idx;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_3_io_replay_bits_uop_stq_idx;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_3_io_replay_bits_uop_rxq_idx;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_3_io_replay_bits_uop_pdst;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_3_io_replay_bits_uop_prs1;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_3_io_replay_bits_uop_prs2;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_3_io_replay_bits_uop_prs3;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_3_io_replay_bits_uop_ppred;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_uop_prs1_busy;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_uop_prs2_busy;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_uop_prs3_busy;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_uop_ppred_busy;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_3_io_replay_bits_uop_stale_pdst;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_uop_exception;	// mshrs.scala:620:22
  wire [63:0] _mshrs_3_io_replay_bits_uop_exc_cause;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_uop_bypassable;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_3_io_replay_bits_uop_mem_cmd;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_3_io_replay_bits_uop_mem_size;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_uop_mem_signed;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_uop_is_fence;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_uop_is_fencei;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_uop_is_amo;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_uop_uses_ldq;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_uop_uses_stq;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_uop_is_sys_pc2epc;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_uop_is_unique;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_uop_flush_on_commit;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_uop_ldst_is_rs1;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_3_io_replay_bits_uop_ldst;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_3_io_replay_bits_uop_lrs1;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_3_io_replay_bits_uop_lrs2;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_3_io_replay_bits_uop_lrs3;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_uop_ldst_val;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_3_io_replay_bits_uop_dst_rtype;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_3_io_replay_bits_uop_lrs1_rtype;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_3_io_replay_bits_uop_lrs2_rtype;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_uop_frs3_en;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_uop_fp_val;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_uop_fp_single;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_uop_xcpt_pf_if;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_uop_xcpt_ae_if;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_uop_xcpt_ma_if;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_uop_bp_debug_if;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_uop_bp_xcpt_if;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_3_io_replay_bits_uop_debug_fsrc;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_3_io_replay_bits_uop_debug_tsrc;	// mshrs.scala:620:22
  wire [39:0] _mshrs_3_io_replay_bits_addr;	// mshrs.scala:620:22
  wire        _mshrs_3_io_replay_bits_is_hella;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_3_io_replay_bits_way_en;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_3_io_replay_bits_sdq_id;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_valid;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_3_io_resp_bits_uop_uopc;	// mshrs.scala:620:22
  wire [31:0] _mshrs_3_io_resp_bits_uop_inst;	// mshrs.scala:620:22
  wire [31:0] _mshrs_3_io_resp_bits_uop_debug_inst;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_uop_is_rvc;	// mshrs.scala:620:22
  wire [39:0] _mshrs_3_io_resp_bits_uop_debug_pc;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_3_io_resp_bits_uop_iq_type;	// mshrs.scala:620:22
  wire [9:0]  _mshrs_3_io_resp_bits_uop_fu_code;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_3_io_resp_bits_uop_ctrl_br_type;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_3_io_resp_bits_uop_ctrl_op1_sel;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_3_io_resp_bits_uop_ctrl_op2_sel;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_3_io_resp_bits_uop_ctrl_imm_sel;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_3_io_resp_bits_uop_ctrl_op_fcn;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_uop_ctrl_fcn_dw;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_3_io_resp_bits_uop_ctrl_csr_cmd;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_uop_ctrl_is_load;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_uop_ctrl_is_sta;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_uop_ctrl_is_std;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_3_io_resp_bits_uop_iw_state;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_uop_iw_p1_poisoned;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_uop_iw_p2_poisoned;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_uop_is_br;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_uop_is_jalr;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_uop_is_jal;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_uop_is_sfb;	// mshrs.scala:620:22
  wire [19:0] _mshrs_3_io_resp_bits_uop_br_mask;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_3_io_resp_bits_uop_br_tag;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_3_io_resp_bits_uop_ftq_idx;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_uop_edge_inst;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_3_io_resp_bits_uop_pc_lob;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_uop_taken;	// mshrs.scala:620:22
  wire [19:0] _mshrs_3_io_resp_bits_uop_imm_packed;	// mshrs.scala:620:22
  wire [11:0] _mshrs_3_io_resp_bits_uop_csr_addr;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_3_io_resp_bits_uop_rob_idx;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_3_io_resp_bits_uop_ldq_idx;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_3_io_resp_bits_uop_stq_idx;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_3_io_resp_bits_uop_rxq_idx;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_3_io_resp_bits_uop_pdst;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_3_io_resp_bits_uop_prs1;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_3_io_resp_bits_uop_prs2;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_3_io_resp_bits_uop_prs3;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_3_io_resp_bits_uop_ppred;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_uop_prs1_busy;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_uop_prs2_busy;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_uop_prs3_busy;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_uop_ppred_busy;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_3_io_resp_bits_uop_stale_pdst;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_uop_exception;	// mshrs.scala:620:22
  wire [63:0] _mshrs_3_io_resp_bits_uop_exc_cause;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_uop_bypassable;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_3_io_resp_bits_uop_mem_cmd;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_3_io_resp_bits_uop_mem_size;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_uop_mem_signed;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_uop_is_fence;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_uop_is_fencei;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_uop_is_amo;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_uop_uses_ldq;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_uop_uses_stq;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_uop_is_sys_pc2epc;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_uop_is_unique;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_uop_flush_on_commit;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_uop_ldst_is_rs1;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_3_io_resp_bits_uop_ldst;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_3_io_resp_bits_uop_lrs1;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_3_io_resp_bits_uop_lrs2;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_3_io_resp_bits_uop_lrs3;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_uop_ldst_val;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_3_io_resp_bits_uop_dst_rtype;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_3_io_resp_bits_uop_lrs1_rtype;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_3_io_resp_bits_uop_lrs2_rtype;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_uop_frs3_en;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_uop_fp_val;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_uop_fp_single;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_uop_xcpt_pf_if;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_uop_xcpt_ae_if;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_uop_xcpt_ma_if;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_uop_bp_debug_if;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_uop_bp_xcpt_if;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_3_io_resp_bits_uop_debug_fsrc;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_3_io_resp_bits_uop_debug_tsrc;	// mshrs.scala:620:22
  wire [63:0] _mshrs_3_io_resp_bits_data;	// mshrs.scala:620:22
  wire        _mshrs_3_io_resp_bits_is_hella;	// mshrs.scala:620:22
  wire        _mshrs_3_io_probe_rdy;	// mshrs.scala:620:22
  wire        _mshrs_2_io_req_pri_rdy;	// mshrs.scala:620:22
  wire        _mshrs_2_io_req_sec_rdy;	// mshrs.scala:620:22
  wire        _mshrs_2_io_idx_valid;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_2_io_idx_bits;	// mshrs.scala:620:22
  wire        _mshrs_2_io_way_valid;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_2_io_way_bits;	// mshrs.scala:620:22
  wire        _mshrs_2_io_tag_valid;	// mshrs.scala:620:22
  wire [27:0] _mshrs_2_io_tag_bits;	// mshrs.scala:620:22
  wire        _mshrs_2_io_mem_acquire_valid;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_2_io_mem_acquire_bits_param;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_2_io_mem_acquire_bits_source;	// mshrs.scala:620:22
  wire [31:0] _mshrs_2_io_mem_acquire_bits_address;	// mshrs.scala:620:22
  wire        _mshrs_2_io_mem_grant_ready;	// mshrs.scala:620:22
  wire        _mshrs_2_io_mem_finish_valid;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_2_io_mem_finish_bits_sink;	// mshrs.scala:620:22
  wire        _mshrs_2_io_refill_valid;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_2_io_refill_bits_way_en;	// mshrs.scala:620:22
  wire [11:0] _mshrs_2_io_refill_bits_addr;	// mshrs.scala:620:22
  wire [63:0] _mshrs_2_io_refill_bits_data;	// mshrs.scala:620:22
  wire        _mshrs_2_io_meta_write_valid;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_2_io_meta_write_bits_idx;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_2_io_meta_write_bits_way_en;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_2_io_meta_write_bits_data_coh_state;	// mshrs.scala:620:22
  wire [19:0] _mshrs_2_io_meta_write_bits_data_tag;	// mshrs.scala:620:22
  wire        _mshrs_2_io_meta_read_valid;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_2_io_meta_read_bits_idx;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_2_io_meta_read_bits_way_en;	// mshrs.scala:620:22
  wire [19:0] _mshrs_2_io_meta_read_bits_tag;	// mshrs.scala:620:22
  wire        _mshrs_2_io_wb_req_valid;	// mshrs.scala:620:22
  wire [19:0] _mshrs_2_io_wb_req_bits_tag;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_2_io_wb_req_bits_idx;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_2_io_wb_req_bits_param;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_2_io_wb_req_bits_way_en;	// mshrs.scala:620:22
  wire        _mshrs_2_io_commit_val;	// mshrs.scala:620:22
  wire [39:0] _mshrs_2_io_commit_addr;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_2_io_commit_coh_state;	// mshrs.scala:620:22
  wire        _mshrs_2_io_lb_read_valid;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_2_io_lb_read_bits_id;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_2_io_lb_read_bits_offset;	// mshrs.scala:620:22
  wire        _mshrs_2_io_lb_write_valid;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_2_io_lb_write_bits_id;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_2_io_lb_write_bits_offset;	// mshrs.scala:620:22
  wire [63:0] _mshrs_2_io_lb_write_bits_data;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_valid;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_2_io_replay_bits_uop_uopc;	// mshrs.scala:620:22
  wire [31:0] _mshrs_2_io_replay_bits_uop_inst;	// mshrs.scala:620:22
  wire [31:0] _mshrs_2_io_replay_bits_uop_debug_inst;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_uop_is_rvc;	// mshrs.scala:620:22
  wire [39:0] _mshrs_2_io_replay_bits_uop_debug_pc;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_2_io_replay_bits_uop_iq_type;	// mshrs.scala:620:22
  wire [9:0]  _mshrs_2_io_replay_bits_uop_fu_code;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_2_io_replay_bits_uop_ctrl_br_type;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_2_io_replay_bits_uop_ctrl_op1_sel;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_2_io_replay_bits_uop_ctrl_op2_sel;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_2_io_replay_bits_uop_ctrl_imm_sel;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_2_io_replay_bits_uop_ctrl_op_fcn;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_uop_ctrl_fcn_dw;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_2_io_replay_bits_uop_ctrl_csr_cmd;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_uop_ctrl_is_load;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_uop_ctrl_is_sta;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_uop_ctrl_is_std;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_2_io_replay_bits_uop_iw_state;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_uop_iw_p1_poisoned;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_uop_iw_p2_poisoned;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_uop_is_br;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_uop_is_jalr;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_uop_is_jal;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_uop_is_sfb;	// mshrs.scala:620:22
  wire [19:0] _mshrs_2_io_replay_bits_uop_br_mask;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_2_io_replay_bits_uop_br_tag;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_2_io_replay_bits_uop_ftq_idx;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_uop_edge_inst;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_2_io_replay_bits_uop_pc_lob;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_uop_taken;	// mshrs.scala:620:22
  wire [19:0] _mshrs_2_io_replay_bits_uop_imm_packed;	// mshrs.scala:620:22
  wire [11:0] _mshrs_2_io_replay_bits_uop_csr_addr;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_2_io_replay_bits_uop_rob_idx;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_2_io_replay_bits_uop_ldq_idx;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_2_io_replay_bits_uop_stq_idx;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_2_io_replay_bits_uop_rxq_idx;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_2_io_replay_bits_uop_pdst;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_2_io_replay_bits_uop_prs1;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_2_io_replay_bits_uop_prs2;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_2_io_replay_bits_uop_prs3;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_2_io_replay_bits_uop_ppred;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_uop_prs1_busy;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_uop_prs2_busy;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_uop_prs3_busy;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_uop_ppred_busy;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_2_io_replay_bits_uop_stale_pdst;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_uop_exception;	// mshrs.scala:620:22
  wire [63:0] _mshrs_2_io_replay_bits_uop_exc_cause;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_uop_bypassable;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_2_io_replay_bits_uop_mem_cmd;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_2_io_replay_bits_uop_mem_size;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_uop_mem_signed;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_uop_is_fence;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_uop_is_fencei;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_uop_is_amo;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_uop_uses_ldq;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_uop_uses_stq;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_uop_is_sys_pc2epc;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_uop_is_unique;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_uop_flush_on_commit;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_uop_ldst_is_rs1;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_2_io_replay_bits_uop_ldst;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_2_io_replay_bits_uop_lrs1;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_2_io_replay_bits_uop_lrs2;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_2_io_replay_bits_uop_lrs3;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_uop_ldst_val;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_2_io_replay_bits_uop_dst_rtype;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_2_io_replay_bits_uop_lrs1_rtype;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_2_io_replay_bits_uop_lrs2_rtype;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_uop_frs3_en;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_uop_fp_val;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_uop_fp_single;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_uop_xcpt_pf_if;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_uop_xcpt_ae_if;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_uop_xcpt_ma_if;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_uop_bp_debug_if;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_uop_bp_xcpt_if;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_2_io_replay_bits_uop_debug_fsrc;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_2_io_replay_bits_uop_debug_tsrc;	// mshrs.scala:620:22
  wire [39:0] _mshrs_2_io_replay_bits_addr;	// mshrs.scala:620:22
  wire        _mshrs_2_io_replay_bits_is_hella;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_2_io_replay_bits_way_en;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_2_io_replay_bits_sdq_id;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_valid;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_2_io_resp_bits_uop_uopc;	// mshrs.scala:620:22
  wire [31:0] _mshrs_2_io_resp_bits_uop_inst;	// mshrs.scala:620:22
  wire [31:0] _mshrs_2_io_resp_bits_uop_debug_inst;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_uop_is_rvc;	// mshrs.scala:620:22
  wire [39:0] _mshrs_2_io_resp_bits_uop_debug_pc;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_2_io_resp_bits_uop_iq_type;	// mshrs.scala:620:22
  wire [9:0]  _mshrs_2_io_resp_bits_uop_fu_code;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_2_io_resp_bits_uop_ctrl_br_type;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_2_io_resp_bits_uop_ctrl_op1_sel;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_2_io_resp_bits_uop_ctrl_op2_sel;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_2_io_resp_bits_uop_ctrl_imm_sel;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_2_io_resp_bits_uop_ctrl_op_fcn;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_uop_ctrl_fcn_dw;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_2_io_resp_bits_uop_ctrl_csr_cmd;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_uop_ctrl_is_load;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_uop_ctrl_is_sta;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_uop_ctrl_is_std;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_2_io_resp_bits_uop_iw_state;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_uop_iw_p1_poisoned;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_uop_iw_p2_poisoned;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_uop_is_br;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_uop_is_jalr;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_uop_is_jal;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_uop_is_sfb;	// mshrs.scala:620:22
  wire [19:0] _mshrs_2_io_resp_bits_uop_br_mask;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_2_io_resp_bits_uop_br_tag;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_2_io_resp_bits_uop_ftq_idx;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_uop_edge_inst;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_2_io_resp_bits_uop_pc_lob;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_uop_taken;	// mshrs.scala:620:22
  wire [19:0] _mshrs_2_io_resp_bits_uop_imm_packed;	// mshrs.scala:620:22
  wire [11:0] _mshrs_2_io_resp_bits_uop_csr_addr;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_2_io_resp_bits_uop_rob_idx;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_2_io_resp_bits_uop_ldq_idx;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_2_io_resp_bits_uop_stq_idx;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_2_io_resp_bits_uop_rxq_idx;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_2_io_resp_bits_uop_pdst;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_2_io_resp_bits_uop_prs1;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_2_io_resp_bits_uop_prs2;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_2_io_resp_bits_uop_prs3;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_2_io_resp_bits_uop_ppred;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_uop_prs1_busy;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_uop_prs2_busy;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_uop_prs3_busy;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_uop_ppred_busy;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_2_io_resp_bits_uop_stale_pdst;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_uop_exception;	// mshrs.scala:620:22
  wire [63:0] _mshrs_2_io_resp_bits_uop_exc_cause;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_uop_bypassable;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_2_io_resp_bits_uop_mem_cmd;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_2_io_resp_bits_uop_mem_size;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_uop_mem_signed;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_uop_is_fence;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_uop_is_fencei;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_uop_is_amo;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_uop_uses_ldq;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_uop_uses_stq;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_uop_is_sys_pc2epc;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_uop_is_unique;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_uop_flush_on_commit;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_uop_ldst_is_rs1;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_2_io_resp_bits_uop_ldst;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_2_io_resp_bits_uop_lrs1;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_2_io_resp_bits_uop_lrs2;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_2_io_resp_bits_uop_lrs3;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_uop_ldst_val;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_2_io_resp_bits_uop_dst_rtype;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_2_io_resp_bits_uop_lrs1_rtype;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_2_io_resp_bits_uop_lrs2_rtype;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_uop_frs3_en;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_uop_fp_val;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_uop_fp_single;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_uop_xcpt_pf_if;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_uop_xcpt_ae_if;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_uop_xcpt_ma_if;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_uop_bp_debug_if;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_uop_bp_xcpt_if;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_2_io_resp_bits_uop_debug_fsrc;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_2_io_resp_bits_uop_debug_tsrc;	// mshrs.scala:620:22
  wire [63:0] _mshrs_2_io_resp_bits_data;	// mshrs.scala:620:22
  wire        _mshrs_2_io_resp_bits_is_hella;	// mshrs.scala:620:22
  wire        _mshrs_2_io_probe_rdy;	// mshrs.scala:620:22
  wire        _mshrs_1_io_req_pri_rdy;	// mshrs.scala:620:22
  wire        _mshrs_1_io_req_sec_rdy;	// mshrs.scala:620:22
  wire        _mshrs_1_io_idx_valid;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_1_io_idx_bits;	// mshrs.scala:620:22
  wire        _mshrs_1_io_way_valid;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_1_io_way_bits;	// mshrs.scala:620:22
  wire        _mshrs_1_io_tag_valid;	// mshrs.scala:620:22
  wire [27:0] _mshrs_1_io_tag_bits;	// mshrs.scala:620:22
  wire        _mshrs_1_io_mem_acquire_valid;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_1_io_mem_acquire_bits_param;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_1_io_mem_acquire_bits_source;	// mshrs.scala:620:22
  wire [31:0] _mshrs_1_io_mem_acquire_bits_address;	// mshrs.scala:620:22
  wire        _mshrs_1_io_mem_grant_ready;	// mshrs.scala:620:22
  wire        _mshrs_1_io_mem_finish_valid;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_1_io_mem_finish_bits_sink;	// mshrs.scala:620:22
  wire        _mshrs_1_io_refill_valid;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_1_io_refill_bits_way_en;	// mshrs.scala:620:22
  wire [11:0] _mshrs_1_io_refill_bits_addr;	// mshrs.scala:620:22
  wire [63:0] _mshrs_1_io_refill_bits_data;	// mshrs.scala:620:22
  wire        _mshrs_1_io_meta_write_valid;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_1_io_meta_write_bits_idx;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_1_io_meta_write_bits_way_en;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_1_io_meta_write_bits_data_coh_state;	// mshrs.scala:620:22
  wire [19:0] _mshrs_1_io_meta_write_bits_data_tag;	// mshrs.scala:620:22
  wire        _mshrs_1_io_meta_read_valid;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_1_io_meta_read_bits_idx;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_1_io_meta_read_bits_way_en;	// mshrs.scala:620:22
  wire [19:0] _mshrs_1_io_meta_read_bits_tag;	// mshrs.scala:620:22
  wire        _mshrs_1_io_wb_req_valid;	// mshrs.scala:620:22
  wire [19:0] _mshrs_1_io_wb_req_bits_tag;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_1_io_wb_req_bits_idx;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_1_io_wb_req_bits_param;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_1_io_wb_req_bits_way_en;	// mshrs.scala:620:22
  wire        _mshrs_1_io_commit_val;	// mshrs.scala:620:22
  wire [39:0] _mshrs_1_io_commit_addr;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_1_io_commit_coh_state;	// mshrs.scala:620:22
  wire        _mshrs_1_io_lb_read_valid;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_1_io_lb_read_bits_id;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_1_io_lb_read_bits_offset;	// mshrs.scala:620:22
  wire        _mshrs_1_io_lb_write_valid;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_1_io_lb_write_bits_id;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_1_io_lb_write_bits_offset;	// mshrs.scala:620:22
  wire [63:0] _mshrs_1_io_lb_write_bits_data;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_valid;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_1_io_replay_bits_uop_uopc;	// mshrs.scala:620:22
  wire [31:0] _mshrs_1_io_replay_bits_uop_inst;	// mshrs.scala:620:22
  wire [31:0] _mshrs_1_io_replay_bits_uop_debug_inst;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_uop_is_rvc;	// mshrs.scala:620:22
  wire [39:0] _mshrs_1_io_replay_bits_uop_debug_pc;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_1_io_replay_bits_uop_iq_type;	// mshrs.scala:620:22
  wire [9:0]  _mshrs_1_io_replay_bits_uop_fu_code;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_1_io_replay_bits_uop_ctrl_br_type;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_1_io_replay_bits_uop_ctrl_op1_sel;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_1_io_replay_bits_uop_ctrl_op2_sel;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_1_io_replay_bits_uop_ctrl_imm_sel;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_1_io_replay_bits_uop_ctrl_op_fcn;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_uop_ctrl_fcn_dw;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_1_io_replay_bits_uop_ctrl_csr_cmd;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_uop_ctrl_is_load;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_uop_ctrl_is_sta;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_uop_ctrl_is_std;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_1_io_replay_bits_uop_iw_state;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_uop_iw_p1_poisoned;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_uop_iw_p2_poisoned;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_uop_is_br;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_uop_is_jalr;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_uop_is_jal;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_uop_is_sfb;	// mshrs.scala:620:22
  wire [19:0] _mshrs_1_io_replay_bits_uop_br_mask;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_1_io_replay_bits_uop_br_tag;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_1_io_replay_bits_uop_ftq_idx;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_uop_edge_inst;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_1_io_replay_bits_uop_pc_lob;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_uop_taken;	// mshrs.scala:620:22
  wire [19:0] _mshrs_1_io_replay_bits_uop_imm_packed;	// mshrs.scala:620:22
  wire [11:0] _mshrs_1_io_replay_bits_uop_csr_addr;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_1_io_replay_bits_uop_rob_idx;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_1_io_replay_bits_uop_ldq_idx;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_1_io_replay_bits_uop_stq_idx;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_1_io_replay_bits_uop_rxq_idx;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_1_io_replay_bits_uop_pdst;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_1_io_replay_bits_uop_prs1;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_1_io_replay_bits_uop_prs2;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_1_io_replay_bits_uop_prs3;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_1_io_replay_bits_uop_ppred;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_uop_prs1_busy;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_uop_prs2_busy;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_uop_prs3_busy;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_uop_ppred_busy;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_1_io_replay_bits_uop_stale_pdst;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_uop_exception;	// mshrs.scala:620:22
  wire [63:0] _mshrs_1_io_replay_bits_uop_exc_cause;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_uop_bypassable;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_1_io_replay_bits_uop_mem_cmd;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_1_io_replay_bits_uop_mem_size;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_uop_mem_signed;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_uop_is_fence;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_uop_is_fencei;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_uop_is_amo;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_uop_uses_ldq;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_uop_uses_stq;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_uop_is_sys_pc2epc;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_uop_is_unique;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_uop_flush_on_commit;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_uop_ldst_is_rs1;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_1_io_replay_bits_uop_ldst;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_1_io_replay_bits_uop_lrs1;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_1_io_replay_bits_uop_lrs2;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_1_io_replay_bits_uop_lrs3;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_uop_ldst_val;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_1_io_replay_bits_uop_dst_rtype;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_1_io_replay_bits_uop_lrs1_rtype;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_1_io_replay_bits_uop_lrs2_rtype;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_uop_frs3_en;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_uop_fp_val;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_uop_fp_single;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_uop_xcpt_pf_if;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_uop_xcpt_ae_if;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_uop_xcpt_ma_if;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_uop_bp_debug_if;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_uop_bp_xcpt_if;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_1_io_replay_bits_uop_debug_fsrc;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_1_io_replay_bits_uop_debug_tsrc;	// mshrs.scala:620:22
  wire [39:0] _mshrs_1_io_replay_bits_addr;	// mshrs.scala:620:22
  wire        _mshrs_1_io_replay_bits_is_hella;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_1_io_replay_bits_way_en;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_1_io_replay_bits_sdq_id;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_valid;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_1_io_resp_bits_uop_uopc;	// mshrs.scala:620:22
  wire [31:0] _mshrs_1_io_resp_bits_uop_inst;	// mshrs.scala:620:22
  wire [31:0] _mshrs_1_io_resp_bits_uop_debug_inst;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_uop_is_rvc;	// mshrs.scala:620:22
  wire [39:0] _mshrs_1_io_resp_bits_uop_debug_pc;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_1_io_resp_bits_uop_iq_type;	// mshrs.scala:620:22
  wire [9:0]  _mshrs_1_io_resp_bits_uop_fu_code;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_1_io_resp_bits_uop_ctrl_br_type;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_1_io_resp_bits_uop_ctrl_op1_sel;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_1_io_resp_bits_uop_ctrl_op2_sel;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_1_io_resp_bits_uop_ctrl_imm_sel;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_1_io_resp_bits_uop_ctrl_op_fcn;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_uop_ctrl_fcn_dw;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_1_io_resp_bits_uop_ctrl_csr_cmd;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_uop_ctrl_is_load;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_uop_ctrl_is_sta;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_uop_ctrl_is_std;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_1_io_resp_bits_uop_iw_state;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_uop_iw_p1_poisoned;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_uop_iw_p2_poisoned;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_uop_is_br;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_uop_is_jalr;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_uop_is_jal;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_uop_is_sfb;	// mshrs.scala:620:22
  wire [19:0] _mshrs_1_io_resp_bits_uop_br_mask;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_1_io_resp_bits_uop_br_tag;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_1_io_resp_bits_uop_ftq_idx;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_uop_edge_inst;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_1_io_resp_bits_uop_pc_lob;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_uop_taken;	// mshrs.scala:620:22
  wire [19:0] _mshrs_1_io_resp_bits_uop_imm_packed;	// mshrs.scala:620:22
  wire [11:0] _mshrs_1_io_resp_bits_uop_csr_addr;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_1_io_resp_bits_uop_rob_idx;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_1_io_resp_bits_uop_ldq_idx;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_1_io_resp_bits_uop_stq_idx;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_1_io_resp_bits_uop_rxq_idx;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_1_io_resp_bits_uop_pdst;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_1_io_resp_bits_uop_prs1;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_1_io_resp_bits_uop_prs2;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_1_io_resp_bits_uop_prs3;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_1_io_resp_bits_uop_ppred;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_uop_prs1_busy;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_uop_prs2_busy;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_uop_prs3_busy;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_uop_ppred_busy;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_1_io_resp_bits_uop_stale_pdst;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_uop_exception;	// mshrs.scala:620:22
  wire [63:0] _mshrs_1_io_resp_bits_uop_exc_cause;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_uop_bypassable;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_1_io_resp_bits_uop_mem_cmd;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_1_io_resp_bits_uop_mem_size;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_uop_mem_signed;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_uop_is_fence;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_uop_is_fencei;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_uop_is_amo;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_uop_uses_ldq;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_uop_uses_stq;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_uop_is_sys_pc2epc;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_uop_is_unique;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_uop_flush_on_commit;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_uop_ldst_is_rs1;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_1_io_resp_bits_uop_ldst;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_1_io_resp_bits_uop_lrs1;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_1_io_resp_bits_uop_lrs2;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_1_io_resp_bits_uop_lrs3;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_uop_ldst_val;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_1_io_resp_bits_uop_dst_rtype;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_1_io_resp_bits_uop_lrs1_rtype;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_1_io_resp_bits_uop_lrs2_rtype;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_uop_frs3_en;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_uop_fp_val;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_uop_fp_single;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_uop_xcpt_pf_if;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_uop_xcpt_ae_if;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_uop_xcpt_ma_if;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_uop_bp_debug_if;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_uop_bp_xcpt_if;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_1_io_resp_bits_uop_debug_fsrc;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_1_io_resp_bits_uop_debug_tsrc;	// mshrs.scala:620:22
  wire [63:0] _mshrs_1_io_resp_bits_data;	// mshrs.scala:620:22
  wire        _mshrs_1_io_resp_bits_is_hella;	// mshrs.scala:620:22
  wire        _mshrs_1_io_probe_rdy;	// mshrs.scala:620:22
  wire        _mshrs_0_io_req_pri_rdy;	// mshrs.scala:620:22
  wire        _mshrs_0_io_req_sec_rdy;	// mshrs.scala:620:22
  wire        _mshrs_0_io_idx_valid;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_0_io_idx_bits;	// mshrs.scala:620:22
  wire        _mshrs_0_io_way_valid;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_0_io_way_bits;	// mshrs.scala:620:22
  wire        _mshrs_0_io_tag_valid;	// mshrs.scala:620:22
  wire [27:0] _mshrs_0_io_tag_bits;	// mshrs.scala:620:22
  wire        _mshrs_0_io_mem_acquire_valid;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_0_io_mem_acquire_bits_param;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_0_io_mem_acquire_bits_source;	// mshrs.scala:620:22
  wire [31:0] _mshrs_0_io_mem_acquire_bits_address;	// mshrs.scala:620:22
  wire        _mshrs_0_io_mem_grant_ready;	// mshrs.scala:620:22
  wire        _mshrs_0_io_mem_finish_valid;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_0_io_mem_finish_bits_sink;	// mshrs.scala:620:22
  wire        _mshrs_0_io_refill_valid;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_0_io_refill_bits_way_en;	// mshrs.scala:620:22
  wire [11:0] _mshrs_0_io_refill_bits_addr;	// mshrs.scala:620:22
  wire [63:0] _mshrs_0_io_refill_bits_data;	// mshrs.scala:620:22
  wire        _mshrs_0_io_meta_write_valid;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_0_io_meta_write_bits_idx;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_0_io_meta_write_bits_way_en;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_0_io_meta_write_bits_data_coh_state;	// mshrs.scala:620:22
  wire [19:0] _mshrs_0_io_meta_write_bits_data_tag;	// mshrs.scala:620:22
  wire        _mshrs_0_io_meta_read_valid;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_0_io_meta_read_bits_idx;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_0_io_meta_read_bits_way_en;	// mshrs.scala:620:22
  wire [19:0] _mshrs_0_io_meta_read_bits_tag;	// mshrs.scala:620:22
  wire        _mshrs_0_io_wb_req_valid;	// mshrs.scala:620:22
  wire [19:0] _mshrs_0_io_wb_req_bits_tag;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_0_io_wb_req_bits_idx;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_0_io_wb_req_bits_param;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_0_io_wb_req_bits_way_en;	// mshrs.scala:620:22
  wire        _mshrs_0_io_commit_val;	// mshrs.scala:620:22
  wire [39:0] _mshrs_0_io_commit_addr;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_0_io_commit_coh_state;	// mshrs.scala:620:22
  wire        _mshrs_0_io_lb_read_valid;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_0_io_lb_read_bits_id;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_0_io_lb_read_bits_offset;	// mshrs.scala:620:22
  wire        _mshrs_0_io_lb_write_valid;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_0_io_lb_write_bits_id;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_0_io_lb_write_bits_offset;	// mshrs.scala:620:22
  wire [63:0] _mshrs_0_io_lb_write_bits_data;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_valid;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_0_io_replay_bits_uop_uopc;	// mshrs.scala:620:22
  wire [31:0] _mshrs_0_io_replay_bits_uop_inst;	// mshrs.scala:620:22
  wire [31:0] _mshrs_0_io_replay_bits_uop_debug_inst;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_uop_is_rvc;	// mshrs.scala:620:22
  wire [39:0] _mshrs_0_io_replay_bits_uop_debug_pc;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_0_io_replay_bits_uop_iq_type;	// mshrs.scala:620:22
  wire [9:0]  _mshrs_0_io_replay_bits_uop_fu_code;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_0_io_replay_bits_uop_ctrl_br_type;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_0_io_replay_bits_uop_ctrl_op1_sel;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_0_io_replay_bits_uop_ctrl_op2_sel;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_0_io_replay_bits_uop_ctrl_imm_sel;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_0_io_replay_bits_uop_ctrl_op_fcn;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_uop_ctrl_fcn_dw;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_0_io_replay_bits_uop_ctrl_csr_cmd;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_uop_ctrl_is_load;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_uop_ctrl_is_sta;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_uop_ctrl_is_std;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_0_io_replay_bits_uop_iw_state;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_uop_iw_p1_poisoned;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_uop_iw_p2_poisoned;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_uop_is_br;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_uop_is_jalr;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_uop_is_jal;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_uop_is_sfb;	// mshrs.scala:620:22
  wire [19:0] _mshrs_0_io_replay_bits_uop_br_mask;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_0_io_replay_bits_uop_br_tag;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_0_io_replay_bits_uop_ftq_idx;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_uop_edge_inst;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_0_io_replay_bits_uop_pc_lob;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_uop_taken;	// mshrs.scala:620:22
  wire [19:0] _mshrs_0_io_replay_bits_uop_imm_packed;	// mshrs.scala:620:22
  wire [11:0] _mshrs_0_io_replay_bits_uop_csr_addr;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_0_io_replay_bits_uop_rob_idx;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_0_io_replay_bits_uop_ldq_idx;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_0_io_replay_bits_uop_stq_idx;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_0_io_replay_bits_uop_rxq_idx;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_0_io_replay_bits_uop_pdst;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_0_io_replay_bits_uop_prs1;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_0_io_replay_bits_uop_prs2;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_0_io_replay_bits_uop_prs3;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_0_io_replay_bits_uop_ppred;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_uop_prs1_busy;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_uop_prs2_busy;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_uop_prs3_busy;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_uop_ppred_busy;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_0_io_replay_bits_uop_stale_pdst;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_uop_exception;	// mshrs.scala:620:22
  wire [63:0] _mshrs_0_io_replay_bits_uop_exc_cause;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_uop_bypassable;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_0_io_replay_bits_uop_mem_cmd;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_0_io_replay_bits_uop_mem_size;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_uop_mem_signed;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_uop_is_fence;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_uop_is_fencei;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_uop_is_amo;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_uop_uses_ldq;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_uop_uses_stq;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_uop_is_sys_pc2epc;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_uop_is_unique;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_uop_flush_on_commit;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_uop_ldst_is_rs1;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_0_io_replay_bits_uop_ldst;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_0_io_replay_bits_uop_lrs1;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_0_io_replay_bits_uop_lrs2;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_0_io_replay_bits_uop_lrs3;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_uop_ldst_val;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_0_io_replay_bits_uop_dst_rtype;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_0_io_replay_bits_uop_lrs1_rtype;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_0_io_replay_bits_uop_lrs2_rtype;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_uop_frs3_en;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_uop_fp_val;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_uop_fp_single;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_uop_xcpt_pf_if;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_uop_xcpt_ae_if;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_uop_xcpt_ma_if;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_uop_bp_debug_if;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_uop_bp_xcpt_if;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_0_io_replay_bits_uop_debug_fsrc;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_0_io_replay_bits_uop_debug_tsrc;	// mshrs.scala:620:22
  wire [39:0] _mshrs_0_io_replay_bits_addr;	// mshrs.scala:620:22
  wire        _mshrs_0_io_replay_bits_is_hella;	// mshrs.scala:620:22
  wire [7:0]  _mshrs_0_io_replay_bits_way_en;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_0_io_replay_bits_sdq_id;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_valid;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_0_io_resp_bits_uop_uopc;	// mshrs.scala:620:22
  wire [31:0] _mshrs_0_io_resp_bits_uop_inst;	// mshrs.scala:620:22
  wire [31:0] _mshrs_0_io_resp_bits_uop_debug_inst;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_uop_is_rvc;	// mshrs.scala:620:22
  wire [39:0] _mshrs_0_io_resp_bits_uop_debug_pc;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_0_io_resp_bits_uop_iq_type;	// mshrs.scala:620:22
  wire [9:0]  _mshrs_0_io_resp_bits_uop_fu_code;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_0_io_resp_bits_uop_ctrl_br_type;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_0_io_resp_bits_uop_ctrl_op1_sel;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_0_io_resp_bits_uop_ctrl_op2_sel;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_0_io_resp_bits_uop_ctrl_imm_sel;	// mshrs.scala:620:22
  wire [3:0]  _mshrs_0_io_resp_bits_uop_ctrl_op_fcn;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_uop_ctrl_fcn_dw;	// mshrs.scala:620:22
  wire [2:0]  _mshrs_0_io_resp_bits_uop_ctrl_csr_cmd;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_uop_ctrl_is_load;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_uop_ctrl_is_sta;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_uop_ctrl_is_std;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_0_io_resp_bits_uop_iw_state;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_uop_iw_p1_poisoned;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_uop_iw_p2_poisoned;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_uop_is_br;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_uop_is_jalr;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_uop_is_jal;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_uop_is_sfb;	// mshrs.scala:620:22
  wire [19:0] _mshrs_0_io_resp_bits_uop_br_mask;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_0_io_resp_bits_uop_br_tag;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_0_io_resp_bits_uop_ftq_idx;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_uop_edge_inst;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_0_io_resp_bits_uop_pc_lob;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_uop_taken;	// mshrs.scala:620:22
  wire [19:0] _mshrs_0_io_resp_bits_uop_imm_packed;	// mshrs.scala:620:22
  wire [11:0] _mshrs_0_io_resp_bits_uop_csr_addr;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_0_io_resp_bits_uop_rob_idx;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_0_io_resp_bits_uop_ldq_idx;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_0_io_resp_bits_uop_stq_idx;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_0_io_resp_bits_uop_rxq_idx;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_0_io_resp_bits_uop_pdst;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_0_io_resp_bits_uop_prs1;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_0_io_resp_bits_uop_prs2;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_0_io_resp_bits_uop_prs3;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_0_io_resp_bits_uop_ppred;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_uop_prs1_busy;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_uop_prs2_busy;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_uop_prs3_busy;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_uop_ppred_busy;	// mshrs.scala:620:22
  wire [6:0]  _mshrs_0_io_resp_bits_uop_stale_pdst;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_uop_exception;	// mshrs.scala:620:22
  wire [63:0] _mshrs_0_io_resp_bits_uop_exc_cause;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_uop_bypassable;	// mshrs.scala:620:22
  wire [4:0]  _mshrs_0_io_resp_bits_uop_mem_cmd;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_0_io_resp_bits_uop_mem_size;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_uop_mem_signed;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_uop_is_fence;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_uop_is_fencei;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_uop_is_amo;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_uop_uses_ldq;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_uop_uses_stq;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_uop_is_sys_pc2epc;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_uop_is_unique;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_uop_flush_on_commit;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_uop_ldst_is_rs1;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_0_io_resp_bits_uop_ldst;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_0_io_resp_bits_uop_lrs1;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_0_io_resp_bits_uop_lrs2;	// mshrs.scala:620:22
  wire [5:0]  _mshrs_0_io_resp_bits_uop_lrs3;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_uop_ldst_val;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_0_io_resp_bits_uop_dst_rtype;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_0_io_resp_bits_uop_lrs1_rtype;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_0_io_resp_bits_uop_lrs2_rtype;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_uop_frs3_en;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_uop_fp_val;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_uop_fp_single;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_uop_xcpt_pf_if;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_uop_xcpt_ae_if;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_uop_xcpt_ma_if;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_uop_bp_debug_if;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_uop_bp_xcpt_if;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_0_io_resp_bits_uop_debug_fsrc;	// mshrs.scala:620:22
  wire [1:0]  _mshrs_0_io_resp_bits_uop_debug_tsrc;	// mshrs.scala:620:22
  wire [63:0] _mshrs_0_io_resp_bits_data;	// mshrs.scala:620:22
  wire        _mshrs_0_io_resp_bits_is_hella;	// mshrs.scala:620:22
  wire        _mshrs_0_io_probe_rdy;	// mshrs.scala:620:22
  wire        _refill_arb_io_in_0_ready;	// mshrs.scala:604:30
  wire        _refill_arb_io_in_1_ready;	// mshrs.scala:604:30
  wire        _refill_arb_io_in_2_ready;	// mshrs.scala:604:30
  wire        _refill_arb_io_in_3_ready;	// mshrs.scala:604:30
  wire        _refill_arb_io_in_4_ready;	// mshrs.scala:604:30
  wire        _refill_arb_io_in_5_ready;	// mshrs.scala:604:30
  wire        _refill_arb_io_in_6_ready;	// mshrs.scala:604:30
  wire        _refill_arb_io_in_7_ready;	// mshrs.scala:604:30
  wire        _resp_arb_io_in_0_ready;	// mshrs.scala:603:30
  wire        _resp_arb_io_in_1_ready;	// mshrs.scala:603:30
  wire        _resp_arb_io_in_2_ready;	// mshrs.scala:603:30
  wire        _resp_arb_io_in_3_ready;	// mshrs.scala:603:30
  wire        _resp_arb_io_in_4_ready;	// mshrs.scala:603:30
  wire        _resp_arb_io_in_5_ready;	// mshrs.scala:603:30
  wire        _resp_arb_io_in_6_ready;	// mshrs.scala:603:30
  wire        _resp_arb_io_in_7_ready;	// mshrs.scala:603:30
  wire        _resp_arb_io_in_8_ready;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_valid;	// mshrs.scala:603:30
  wire [6:0]  _resp_arb_io_out_bits_uop_uopc;	// mshrs.scala:603:30
  wire [31:0] _resp_arb_io_out_bits_uop_inst;	// mshrs.scala:603:30
  wire [31:0] _resp_arb_io_out_bits_uop_debug_inst;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_uop_is_rvc;	// mshrs.scala:603:30
  wire [39:0] _resp_arb_io_out_bits_uop_debug_pc;	// mshrs.scala:603:30
  wire [2:0]  _resp_arb_io_out_bits_uop_iq_type;	// mshrs.scala:603:30
  wire [9:0]  _resp_arb_io_out_bits_uop_fu_code;	// mshrs.scala:603:30
  wire [3:0]  _resp_arb_io_out_bits_uop_ctrl_br_type;	// mshrs.scala:603:30
  wire [1:0]  _resp_arb_io_out_bits_uop_ctrl_op1_sel;	// mshrs.scala:603:30
  wire [2:0]  _resp_arb_io_out_bits_uop_ctrl_op2_sel;	// mshrs.scala:603:30
  wire [2:0]  _resp_arb_io_out_bits_uop_ctrl_imm_sel;	// mshrs.scala:603:30
  wire [3:0]  _resp_arb_io_out_bits_uop_ctrl_op_fcn;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_uop_ctrl_fcn_dw;	// mshrs.scala:603:30
  wire [2:0]  _resp_arb_io_out_bits_uop_ctrl_csr_cmd;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_uop_ctrl_is_load;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_uop_ctrl_is_sta;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_uop_ctrl_is_std;	// mshrs.scala:603:30
  wire [1:0]  _resp_arb_io_out_bits_uop_iw_state;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_uop_iw_p1_poisoned;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_uop_iw_p2_poisoned;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_uop_is_br;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_uop_is_jalr;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_uop_is_jal;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_uop_is_sfb;	// mshrs.scala:603:30
  wire [19:0] _resp_arb_io_out_bits_uop_br_mask;	// mshrs.scala:603:30
  wire [4:0]  _resp_arb_io_out_bits_uop_br_tag;	// mshrs.scala:603:30
  wire [5:0]  _resp_arb_io_out_bits_uop_ftq_idx;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_uop_edge_inst;	// mshrs.scala:603:30
  wire [5:0]  _resp_arb_io_out_bits_uop_pc_lob;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_uop_taken;	// mshrs.scala:603:30
  wire [19:0] _resp_arb_io_out_bits_uop_imm_packed;	// mshrs.scala:603:30
  wire [11:0] _resp_arb_io_out_bits_uop_csr_addr;	// mshrs.scala:603:30
  wire [6:0]  _resp_arb_io_out_bits_uop_rob_idx;	// mshrs.scala:603:30
  wire [4:0]  _resp_arb_io_out_bits_uop_ldq_idx;	// mshrs.scala:603:30
  wire [4:0]  _resp_arb_io_out_bits_uop_stq_idx;	// mshrs.scala:603:30
  wire [1:0]  _resp_arb_io_out_bits_uop_rxq_idx;	// mshrs.scala:603:30
  wire [6:0]  _resp_arb_io_out_bits_uop_pdst;	// mshrs.scala:603:30
  wire [6:0]  _resp_arb_io_out_bits_uop_prs1;	// mshrs.scala:603:30
  wire [6:0]  _resp_arb_io_out_bits_uop_prs2;	// mshrs.scala:603:30
  wire [6:0]  _resp_arb_io_out_bits_uop_prs3;	// mshrs.scala:603:30
  wire [5:0]  _resp_arb_io_out_bits_uop_ppred;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_uop_prs1_busy;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_uop_prs2_busy;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_uop_prs3_busy;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_uop_ppred_busy;	// mshrs.scala:603:30
  wire [6:0]  _resp_arb_io_out_bits_uop_stale_pdst;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_uop_exception;	// mshrs.scala:603:30
  wire [63:0] _resp_arb_io_out_bits_uop_exc_cause;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_uop_bypassable;	// mshrs.scala:603:30
  wire [4:0]  _resp_arb_io_out_bits_uop_mem_cmd;	// mshrs.scala:603:30
  wire [1:0]  _resp_arb_io_out_bits_uop_mem_size;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_uop_mem_signed;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_uop_is_fence;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_uop_is_fencei;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_uop_is_amo;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_uop_uses_ldq;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_uop_uses_stq;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_uop_is_sys_pc2epc;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_uop_is_unique;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_uop_flush_on_commit;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_uop_ldst_is_rs1;	// mshrs.scala:603:30
  wire [5:0]  _resp_arb_io_out_bits_uop_ldst;	// mshrs.scala:603:30
  wire [5:0]  _resp_arb_io_out_bits_uop_lrs1;	// mshrs.scala:603:30
  wire [5:0]  _resp_arb_io_out_bits_uop_lrs2;	// mshrs.scala:603:30
  wire [5:0]  _resp_arb_io_out_bits_uop_lrs3;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_uop_ldst_val;	// mshrs.scala:603:30
  wire [1:0]  _resp_arb_io_out_bits_uop_dst_rtype;	// mshrs.scala:603:30
  wire [1:0]  _resp_arb_io_out_bits_uop_lrs1_rtype;	// mshrs.scala:603:30
  wire [1:0]  _resp_arb_io_out_bits_uop_lrs2_rtype;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_uop_frs3_en;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_uop_fp_val;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_uop_fp_single;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_uop_xcpt_pf_if;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_uop_xcpt_ae_if;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_uop_xcpt_ma_if;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_uop_bp_debug_if;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_uop_bp_xcpt_if;	// mshrs.scala:603:30
  wire [1:0]  _resp_arb_io_out_bits_uop_debug_fsrc;	// mshrs.scala:603:30
  wire [1:0]  _resp_arb_io_out_bits_uop_debug_tsrc;	// mshrs.scala:603:30
  wire [63:0] _resp_arb_io_out_bits_data;	// mshrs.scala:603:30
  wire        _resp_arb_io_out_bits_is_hella;	// mshrs.scala:603:30
  wire        _replay_arb_io_in_0_ready;	// mshrs.scala:602:30
  wire        _replay_arb_io_in_1_ready;	// mshrs.scala:602:30
  wire        _replay_arb_io_in_2_ready;	// mshrs.scala:602:30
  wire        _replay_arb_io_in_3_ready;	// mshrs.scala:602:30
  wire        _replay_arb_io_in_4_ready;	// mshrs.scala:602:30
  wire        _replay_arb_io_in_5_ready;	// mshrs.scala:602:30
  wire        _replay_arb_io_in_6_ready;	// mshrs.scala:602:30
  wire        _replay_arb_io_in_7_ready;	// mshrs.scala:602:30
  wire        _replay_arb_io_out_valid;	// mshrs.scala:602:30
  wire [4:0]  _replay_arb_io_out_bits_uop_mem_cmd;	// mshrs.scala:602:30
  wire [4:0]  _replay_arb_io_out_bits_sdq_id;	// mshrs.scala:602:30
  wire        _wb_req_arb_io_in_0_ready;	// mshrs.scala:601:30
  wire        _wb_req_arb_io_in_1_ready;	// mshrs.scala:601:30
  wire        _wb_req_arb_io_in_2_ready;	// mshrs.scala:601:30
  wire        _wb_req_arb_io_in_3_ready;	// mshrs.scala:601:30
  wire        _wb_req_arb_io_in_4_ready;	// mshrs.scala:601:30
  wire        _wb_req_arb_io_in_5_ready;	// mshrs.scala:601:30
  wire        _wb_req_arb_io_in_6_ready;	// mshrs.scala:601:30
  wire        _wb_req_arb_io_in_7_ready;	// mshrs.scala:601:30
  wire        _meta_read_arb_io_in_0_ready;	// mshrs.scala:600:30
  wire        _meta_read_arb_io_in_1_ready;	// mshrs.scala:600:30
  wire        _meta_read_arb_io_in_2_ready;	// mshrs.scala:600:30
  wire        _meta_read_arb_io_in_3_ready;	// mshrs.scala:600:30
  wire        _meta_read_arb_io_in_4_ready;	// mshrs.scala:600:30
  wire        _meta_read_arb_io_in_5_ready;	// mshrs.scala:600:30
  wire        _meta_read_arb_io_in_6_ready;	// mshrs.scala:600:30
  wire        _meta_read_arb_io_in_7_ready;	// mshrs.scala:600:30
  wire        _meta_write_arb_io_in_0_ready;	// mshrs.scala:599:30
  wire        _meta_write_arb_io_in_1_ready;	// mshrs.scala:599:30
  wire        _meta_write_arb_io_in_2_ready;	// mshrs.scala:599:30
  wire        _meta_write_arb_io_in_3_ready;	// mshrs.scala:599:30
  wire        _meta_write_arb_io_in_4_ready;	// mshrs.scala:599:30
  wire        _meta_write_arb_io_in_5_ready;	// mshrs.scala:599:30
  wire        _meta_write_arb_io_in_6_ready;	// mshrs.scala:599:30
  wire        _meta_write_arb_io_in_7_ready;	// mshrs.scala:599:30
  wire        _lb_write_arb_io_in_1_ready;	// mshrs.scala:570:28
  wire        _lb_write_arb_io_in_2_ready;	// mshrs.scala:570:28
  wire        _lb_write_arb_io_in_3_ready;	// mshrs.scala:570:28
  wire        _lb_write_arb_io_in_4_ready;	// mshrs.scala:570:28
  wire        _lb_write_arb_io_in_5_ready;	// mshrs.scala:570:28
  wire        _lb_write_arb_io_in_6_ready;	// mshrs.scala:570:28
  wire        _lb_write_arb_io_in_7_ready;	// mshrs.scala:570:28
  wire        _lb_write_arb_io_out_valid;	// mshrs.scala:570:28
  wire [2:0]  _lb_write_arb_io_out_bits_id;	// mshrs.scala:570:28
  wire [2:0]  _lb_write_arb_io_out_bits_offset;	// mshrs.scala:570:28
  wire [63:0] _lb_write_arb_io_out_bits_data;	// mshrs.scala:570:28
  wire        _lb_read_arb_io_in_0_ready;	// mshrs.scala:569:28
  wire        _lb_read_arb_io_in_1_ready;	// mshrs.scala:569:28
  wire        _lb_read_arb_io_in_2_ready;	// mshrs.scala:569:28
  wire        _lb_read_arb_io_in_3_ready;	// mshrs.scala:569:28
  wire        _lb_read_arb_io_in_4_ready;	// mshrs.scala:569:28
  wire        _lb_read_arb_io_in_5_ready;	// mshrs.scala:569:28
  wire        _lb_read_arb_io_in_6_ready;	// mshrs.scala:569:28
  wire        _lb_read_arb_io_in_7_ready;	// mshrs.scala:569:28
  wire        _lb_read_arb_io_out_valid;	// mshrs.scala:569:28
  wire [2:0]  _lb_read_arb_io_out_bits_id;	// mshrs.scala:569:28
  wire [2:0]  _lb_read_arb_io_out_bits_offset;	// mshrs.scala:569:28
  wire [63:0] _lb_ext_R0_data;	// mshrs.scala:568:15
  wire        _GEN = io_req_1_valid ? io_req_1_valid : io_req_0_valid;	// Parameters.scala:137:31
  wire [6:0]  _GEN_0 = io_req_1_valid ? io_req_1_bits_uop_uopc : io_req_0_bits_uop_uopc;	// Parameters.scala:137:31
  wire [31:0] _GEN_1 = io_req_1_valid ? io_req_1_bits_uop_inst : io_req_0_bits_uop_inst;	// Parameters.scala:137:31
  wire [31:0] _GEN_2 =
    io_req_1_valid ? io_req_1_bits_uop_debug_inst : io_req_0_bits_uop_debug_inst;	// Parameters.scala:137:31
  wire        _GEN_3 =
    io_req_1_valid ? io_req_1_bits_uop_is_rvc : io_req_0_bits_uop_is_rvc;	// Parameters.scala:137:31
  wire [39:0] _GEN_4 =
    io_req_1_valid ? io_req_1_bits_uop_debug_pc : io_req_0_bits_uop_debug_pc;	// Parameters.scala:137:31
  wire [2:0]  _GEN_5 =
    io_req_1_valid ? io_req_1_bits_uop_iq_type : io_req_0_bits_uop_iq_type;	// Parameters.scala:137:31
  wire [9:0]  _GEN_6 =
    io_req_1_valid ? io_req_1_bits_uop_fu_code : io_req_0_bits_uop_fu_code;	// Parameters.scala:137:31
  wire [3:0]  _GEN_7 =
    io_req_1_valid ? io_req_1_bits_uop_ctrl_br_type : io_req_0_bits_uop_ctrl_br_type;	// Parameters.scala:137:31
  wire [1:0]  _GEN_8 =
    io_req_1_valid ? io_req_1_bits_uop_ctrl_op1_sel : io_req_0_bits_uop_ctrl_op1_sel;	// Parameters.scala:137:31
  wire [2:0]  _GEN_9 =
    io_req_1_valid ? io_req_1_bits_uop_ctrl_op2_sel : io_req_0_bits_uop_ctrl_op2_sel;	// Parameters.scala:137:31
  wire [2:0]  _GEN_10 =
    io_req_1_valid ? io_req_1_bits_uop_ctrl_imm_sel : io_req_0_bits_uop_ctrl_imm_sel;	// Parameters.scala:137:31
  wire [3:0]  _GEN_11 =
    io_req_1_valid ? io_req_1_bits_uop_ctrl_op_fcn : io_req_0_bits_uop_ctrl_op_fcn;	// Parameters.scala:137:31
  wire        _GEN_12 =
    io_req_1_valid ? io_req_1_bits_uop_ctrl_fcn_dw : io_req_0_bits_uop_ctrl_fcn_dw;	// Parameters.scala:137:31
  wire [2:0]  _GEN_13 =
    io_req_1_valid ? io_req_1_bits_uop_ctrl_csr_cmd : io_req_0_bits_uop_ctrl_csr_cmd;	// Parameters.scala:137:31
  wire        _GEN_14 =
    io_req_1_valid ? io_req_1_bits_uop_ctrl_is_load : io_req_0_bits_uop_ctrl_is_load;	// Parameters.scala:137:31
  wire        _GEN_15 =
    io_req_1_valid ? io_req_1_bits_uop_ctrl_is_sta : io_req_0_bits_uop_ctrl_is_sta;	// Parameters.scala:137:31
  wire        _GEN_16 =
    io_req_1_valid ? io_req_1_bits_uop_ctrl_is_std : io_req_0_bits_uop_ctrl_is_std;	// Parameters.scala:137:31
  wire [1:0]  _GEN_17 =
    io_req_1_valid ? io_req_1_bits_uop_iw_state : io_req_0_bits_uop_iw_state;	// Parameters.scala:137:31
  wire        _GEN_18 =
    io_req_1_valid ? io_req_1_bits_uop_iw_p1_poisoned : io_req_0_bits_uop_iw_p1_poisoned;	// Parameters.scala:137:31
  wire        _GEN_19 =
    io_req_1_valid ? io_req_1_bits_uop_iw_p2_poisoned : io_req_0_bits_uop_iw_p2_poisoned;	// Parameters.scala:137:31
  wire        _GEN_20 =
    io_req_1_valid ? io_req_1_bits_uop_is_br : io_req_0_bits_uop_is_br;	// Parameters.scala:137:31
  wire        _GEN_21 =
    io_req_1_valid ? io_req_1_bits_uop_is_jalr : io_req_0_bits_uop_is_jalr;	// Parameters.scala:137:31
  wire        _GEN_22 =
    io_req_1_valid ? io_req_1_bits_uop_is_jal : io_req_0_bits_uop_is_jal;	// Parameters.scala:137:31
  wire        _GEN_23 =
    io_req_1_valid ? io_req_1_bits_uop_is_sfb : io_req_0_bits_uop_is_sfb;	// Parameters.scala:137:31
  wire [19:0] _GEN_24 =
    io_req_1_valid ? io_req_1_bits_uop_br_mask : io_req_0_bits_uop_br_mask;	// Parameters.scala:137:31
  wire [4:0]  _GEN_25 =
    io_req_1_valid ? io_req_1_bits_uop_br_tag : io_req_0_bits_uop_br_tag;	// Parameters.scala:137:31
  wire [5:0]  _GEN_26 =
    io_req_1_valid ? io_req_1_bits_uop_ftq_idx : io_req_0_bits_uop_ftq_idx;	// Parameters.scala:137:31
  wire        _GEN_27 =
    io_req_1_valid ? io_req_1_bits_uop_edge_inst : io_req_0_bits_uop_edge_inst;	// Parameters.scala:137:31
  wire [5:0]  _GEN_28 =
    io_req_1_valid ? io_req_1_bits_uop_pc_lob : io_req_0_bits_uop_pc_lob;	// Parameters.scala:137:31
  wire        _GEN_29 =
    io_req_1_valid ? io_req_1_bits_uop_taken : io_req_0_bits_uop_taken;	// Parameters.scala:137:31
  wire [19:0] _GEN_30 =
    io_req_1_valid ? io_req_1_bits_uop_imm_packed : io_req_0_bits_uop_imm_packed;	// Parameters.scala:137:31
  wire [11:0] _GEN_31 =
    io_req_1_valid ? io_req_1_bits_uop_csr_addr : io_req_0_bits_uop_csr_addr;	// Parameters.scala:137:31
  wire [6:0]  _GEN_32 =
    io_req_1_valid ? io_req_1_bits_uop_rob_idx : io_req_0_bits_uop_rob_idx;	// Parameters.scala:137:31
  wire [4:0]  _GEN_33 =
    io_req_1_valid ? io_req_1_bits_uop_ldq_idx : io_req_0_bits_uop_ldq_idx;	// Parameters.scala:137:31
  wire [4:0]  _GEN_34 =
    io_req_1_valid ? io_req_1_bits_uop_stq_idx : io_req_0_bits_uop_stq_idx;	// Parameters.scala:137:31
  wire [1:0]  _GEN_35 =
    io_req_1_valid ? io_req_1_bits_uop_rxq_idx : io_req_0_bits_uop_rxq_idx;	// Parameters.scala:137:31
  wire [6:0]  _GEN_36 = io_req_1_valid ? io_req_1_bits_uop_pdst : io_req_0_bits_uop_pdst;	// Parameters.scala:137:31
  wire [6:0]  _GEN_37 = io_req_1_valid ? io_req_1_bits_uop_prs1 : io_req_0_bits_uop_prs1;	// Parameters.scala:137:31
  wire [6:0]  _GEN_38 = io_req_1_valid ? io_req_1_bits_uop_prs2 : io_req_0_bits_uop_prs2;	// Parameters.scala:137:31
  wire [6:0]  _GEN_39 = io_req_1_valid ? io_req_1_bits_uop_prs3 : io_req_0_bits_uop_prs3;	// Parameters.scala:137:31
  wire [5:0]  _GEN_40 =
    io_req_1_valid ? io_req_1_bits_uop_ppred : io_req_0_bits_uop_ppred;	// Parameters.scala:137:31
  wire        _GEN_41 =
    io_req_1_valid ? io_req_1_bits_uop_prs1_busy : io_req_0_bits_uop_prs1_busy;	// Parameters.scala:137:31
  wire        _GEN_42 =
    io_req_1_valid ? io_req_1_bits_uop_prs2_busy : io_req_0_bits_uop_prs2_busy;	// Parameters.scala:137:31
  wire        _GEN_43 =
    io_req_1_valid ? io_req_1_bits_uop_prs3_busy : io_req_0_bits_uop_prs3_busy;	// Parameters.scala:137:31
  wire        _GEN_44 =
    io_req_1_valid ? io_req_1_bits_uop_ppred_busy : io_req_0_bits_uop_ppred_busy;	// Parameters.scala:137:31
  wire [6:0]  _GEN_45 =
    io_req_1_valid ? io_req_1_bits_uop_stale_pdst : io_req_0_bits_uop_stale_pdst;	// Parameters.scala:137:31
  wire        _GEN_46 =
    io_req_1_valid ? io_req_1_bits_uop_exception : io_req_0_bits_uop_exception;	// Parameters.scala:137:31
  wire [63:0] _GEN_47 =
    io_req_1_valid ? io_req_1_bits_uop_exc_cause : io_req_0_bits_uop_exc_cause;	// Parameters.scala:137:31
  wire        _GEN_48 =
    io_req_1_valid ? io_req_1_bits_uop_bypassable : io_req_0_bits_uop_bypassable;	// Parameters.scala:137:31
  wire [4:0]  _GEN_49 =
    io_req_1_valid ? io_req_1_bits_uop_mem_cmd : io_req_0_bits_uop_mem_cmd;	// Parameters.scala:137:31
  wire [1:0]  _GEN_50 =
    io_req_1_valid ? io_req_1_bits_uop_mem_size : io_req_0_bits_uop_mem_size;	// Parameters.scala:137:31
  wire        _GEN_51 =
    io_req_1_valid ? io_req_1_bits_uop_mem_signed : io_req_0_bits_uop_mem_signed;	// Parameters.scala:137:31
  wire        _GEN_52 =
    io_req_1_valid ? io_req_1_bits_uop_is_fence : io_req_0_bits_uop_is_fence;	// Parameters.scala:137:31
  wire        _GEN_53 =
    io_req_1_valid ? io_req_1_bits_uop_is_fencei : io_req_0_bits_uop_is_fencei;	// Parameters.scala:137:31
  wire        _GEN_54 =
    io_req_1_valid ? io_req_1_bits_uop_is_amo : io_req_0_bits_uop_is_amo;	// Parameters.scala:137:31
  wire        _GEN_55 =
    io_req_1_valid ? io_req_1_bits_uop_uses_ldq : io_req_0_bits_uop_uses_ldq;	// Parameters.scala:137:31
  wire        _GEN_56 =
    io_req_1_valid ? io_req_1_bits_uop_uses_stq : io_req_0_bits_uop_uses_stq;	// Parameters.scala:137:31
  wire        _GEN_57 =
    io_req_1_valid ? io_req_1_bits_uop_is_sys_pc2epc : io_req_0_bits_uop_is_sys_pc2epc;	// Parameters.scala:137:31
  wire        _GEN_58 =
    io_req_1_valid ? io_req_1_bits_uop_is_unique : io_req_0_bits_uop_is_unique;	// Parameters.scala:137:31
  wire        _GEN_59 =
    io_req_1_valid
      ? io_req_1_bits_uop_flush_on_commit
      : io_req_0_bits_uop_flush_on_commit;	// Parameters.scala:137:31
  wire        _GEN_60 =
    io_req_1_valid ? io_req_1_bits_uop_ldst_is_rs1 : io_req_0_bits_uop_ldst_is_rs1;	// Parameters.scala:137:31
  wire [5:0]  _GEN_61 = io_req_1_valid ? io_req_1_bits_uop_ldst : io_req_0_bits_uop_ldst;	// Parameters.scala:137:31
  wire [5:0]  _GEN_62 = io_req_1_valid ? io_req_1_bits_uop_lrs1 : io_req_0_bits_uop_lrs1;	// Parameters.scala:137:31
  wire [5:0]  _GEN_63 = io_req_1_valid ? io_req_1_bits_uop_lrs2 : io_req_0_bits_uop_lrs2;	// Parameters.scala:137:31
  wire [5:0]  _GEN_64 = io_req_1_valid ? io_req_1_bits_uop_lrs3 : io_req_0_bits_uop_lrs3;	// Parameters.scala:137:31
  wire        _GEN_65 =
    io_req_1_valid ? io_req_1_bits_uop_ldst_val : io_req_0_bits_uop_ldst_val;	// Parameters.scala:137:31
  wire [1:0]  _GEN_66 =
    io_req_1_valid ? io_req_1_bits_uop_dst_rtype : io_req_0_bits_uop_dst_rtype;	// Parameters.scala:137:31
  wire [1:0]  _GEN_67 =
    io_req_1_valid ? io_req_1_bits_uop_lrs1_rtype : io_req_0_bits_uop_lrs1_rtype;	// Parameters.scala:137:31
  wire [1:0]  _GEN_68 =
    io_req_1_valid ? io_req_1_bits_uop_lrs2_rtype : io_req_0_bits_uop_lrs2_rtype;	// Parameters.scala:137:31
  wire        _GEN_69 =
    io_req_1_valid ? io_req_1_bits_uop_frs3_en : io_req_0_bits_uop_frs3_en;	// Parameters.scala:137:31
  wire        _GEN_70 =
    io_req_1_valid ? io_req_1_bits_uop_fp_val : io_req_0_bits_uop_fp_val;	// Parameters.scala:137:31
  wire        _GEN_71 =
    io_req_1_valid ? io_req_1_bits_uop_fp_single : io_req_0_bits_uop_fp_single;	// Parameters.scala:137:31
  wire        _GEN_72 =
    io_req_1_valid ? io_req_1_bits_uop_xcpt_pf_if : io_req_0_bits_uop_xcpt_pf_if;	// Parameters.scala:137:31
  wire        _GEN_73 =
    io_req_1_valid ? io_req_1_bits_uop_xcpt_ae_if : io_req_0_bits_uop_xcpt_ae_if;	// Parameters.scala:137:31
  wire        _GEN_74 =
    io_req_1_valid ? io_req_1_bits_uop_xcpt_ma_if : io_req_0_bits_uop_xcpt_ma_if;	// Parameters.scala:137:31
  wire        _GEN_75 =
    io_req_1_valid ? io_req_1_bits_uop_bp_debug_if : io_req_0_bits_uop_bp_debug_if;	// Parameters.scala:137:31
  wire        _GEN_76 =
    io_req_1_valid ? io_req_1_bits_uop_bp_xcpt_if : io_req_0_bits_uop_bp_xcpt_if;	// Parameters.scala:137:31
  wire [1:0]  _GEN_77 =
    io_req_1_valid ? io_req_1_bits_uop_debug_fsrc : io_req_0_bits_uop_debug_fsrc;	// Parameters.scala:137:31
  wire [1:0]  _GEN_78 =
    io_req_1_valid ? io_req_1_bits_uop_debug_tsrc : io_req_0_bits_uop_debug_tsrc;	// Parameters.scala:137:31
  wire [39:0] _cacheable_T_1 = io_req_1_valid ? io_req_1_bits_addr : io_req_0_bits_addr;	// Parameters.scala:137:31
  wire [63:0] _GEN_79 = io_req_1_valid ? io_req_1_bits_data : io_req_0_bits_data;	// Parameters.scala:137:31
  wire        _GEN_80 = io_req_1_valid ? io_req_1_bits_is_hella : io_req_0_bits_is_hella;	// Parameters.scala:137:31
  wire        _GEN_81 =
    io_req_1_valid ? io_req_1_bits_tag_match : io_req_0_bits_tag_match;	// Parameters.scala:137:31
  wire [1:0]  _GEN_82 =
    io_req_1_valid ? io_req_1_bits_old_meta_coh_state : io_req_0_bits_old_meta_coh_state;	// Parameters.scala:137:31
  wire [19:0] _GEN_83 =
    io_req_1_valid ? io_req_1_bits_old_meta_tag : io_req_0_bits_old_meta_tag;	// Parameters.scala:137:31
  wire [7:0]  _GEN_84 = io_req_1_valid ? io_req_1_bits_way_en : io_req_0_bits_way_en;	// Parameters.scala:137:31
  wire        cacheable =
    {_cacheable_T_1[31],
     _cacheable_T_1[28],
     _cacheable_T_1[26:25],
     _cacheable_T_1[20],
     ~(_cacheable_T_1[17])} == 6'h0
    | {_cacheable_T_1[31],
       ~(_cacheable_T_1[28]),
       _cacheable_T_1[26:25],
       _cacheable_T_1[20],
       _cacheable_T_1[17]} == 6'h0 | {~(_cacheable_T_1[31]), _cacheable_T_1[28]} == 2'h0;	// Mux.scala:27:72, Parameters.scala:137:{31,49,52,67}, :671:42
  reg  [16:0] sdq_val;	// mshrs.scala:555:29
  wire [15:0] _sdq_alloc_id_T_1 = ~(sdq_val[15:0]);	// mshrs.scala:555:29, :556:38
  wire [4:0]  sdq_alloc_id =
    _sdq_alloc_id_T_1[0]
      ? 5'h0
      : _sdq_alloc_id_T_1[1]
          ? 5'h1
          : _sdq_alloc_id_T_1[2]
              ? 5'h2
              : _sdq_alloc_id_T_1[3]
                  ? 5'h3
                  : _sdq_alloc_id_T_1[4]
                      ? 5'h4
                      : _sdq_alloc_id_T_1[5]
                          ? 5'h5
                          : _sdq_alloc_id_T_1[6]
                              ? 5'h6
                              : _sdq_alloc_id_T_1[7]
                                  ? 5'h7
                                  : _sdq_alloc_id_T_1[8]
                                      ? 5'h8
                                      : _sdq_alloc_id_T_1[9]
                                          ? 5'h9
                                          : _sdq_alloc_id_T_1[10]
                                              ? 5'hA
                                              : _sdq_alloc_id_T_1[11]
                                                  ? 5'hB
                                                  : _sdq_alloc_id_T_1[12]
                                                      ? 5'hC
                                                      : _sdq_alloc_id_T_1[13]
                                                          ? 5'hD
                                                          : _sdq_alloc_id_T_1[14]
                                                              ? 5'hE
                                                              : _sdq_alloc_id_T_1[15]
                                                                  ? 5'hF
                                                                  : 5'h10;	// Mux.scala:47:69, OneHot.scala:47:40, mshrs.scala:556:38
  wire        sdq_rdy = sdq_val != 17'h1FFFF;	// Bitwise.scala:72:12, mshrs.scala:555:29, :557:31
  wire        sdq_enq =
    (io_req_1_valid ? _io_req_1_ready_output : _io_req_0_ready_output) & _GEN & cacheable
    & (_GEN_49 == 5'h1 | _GEN_49 == 5'h11 | _GEN_49 == 5'h7 | _GEN_49 == 5'h4
       | _GEN_49 == 5'h9 | _GEN_49 == 5'hA | _GEN_49 == 5'hB | _GEN_49 == 5'h8
       | _GEN_49 == 5'hC | _GEN_49 == 5'hD | _GEN_49 == 5'hE | _GEN_49 == 5'hF);	// Consts.scala:82:{32,49,66,76}, Mux.scala:47:69, Parameters.scala:137:31, :671:42, mshrs.scala:558:46, :744:47, package.scala:15:47
  wire        _GEN_85 = ~_lb_write_arb_io_out_valid & _lb_read_arb_io_out_valid;	// Decoupled.scala:40:37, Mux.scala:47:69, mshrs.scala:543:21, :569:28, :570:28, :572:29, :576:37, :579:30
  wire [63:0] lb_read_data =
    _lb_write_arb_io_out_valid | ~_GEN_85 ? 64'h0 : _lb_ext_R0_data;	// Decoupled.scala:40:37, Mux.scala:27:72, mshrs.scala:545:65, :568:15, :570:28, :576:37, :580:38, :620:22
  wire        tag_match_0 =
    idx_matches_0_0 & _mshrs_0_io_tag_valid & _tag_matches_0_0_T_1 | idx_matches_0_1
    & _mshrs_1_io_tag_valid & _tag_matches_0_1_T_1 | idx_matches_0_2
    & _mshrs_2_io_tag_valid & _tag_matches_0_2_T_1 | idx_matches_0_3
    & _mshrs_3_io_tag_valid & _tag_matches_0_3_T_1 | idx_matches_0_4
    & _mshrs_4_io_tag_valid & _tag_matches_0_4_T_1 | idx_matches_0_5
    & _mshrs_5_io_tag_valid & _tag_matches_0_5_T_1 | idx_matches_0_6
    & _mshrs_6_io_tag_valid & _tag_matches_0_6_T_1 | idx_matches_0_7
    & _mshrs_7_io_tag_valid & _tag_matches_0_7_T_1;	// Mux.scala:27:72, mshrs.scala:620:22, :624:46, :625:66
  wire        tag_match_1 =
    idx_matches_1_0 & _mshrs_0_io_tag_valid & _tag_matches_1_0_T_1 | idx_matches_1_1
    & _mshrs_1_io_tag_valid & _tag_matches_1_1_T_1 | idx_matches_1_2
    & _mshrs_2_io_tag_valid & _tag_matches_1_2_T_1 | idx_matches_1_3
    & _mshrs_3_io_tag_valid & _tag_matches_1_3_T_1 | idx_matches_1_4
    & _mshrs_4_io_tag_valid & _tag_matches_1_4_T_1 | idx_matches_1_5
    & _mshrs_5_io_tag_valid & _tag_matches_1_5_T_1 | idx_matches_1_6
    & _mshrs_6_io_tag_valid & _tag_matches_1_6_T_1 | idx_matches_1_7
    & _mshrs_7_io_tag_valid & _tag_matches_1_7_T_1;	// Mux.scala:27:72, mshrs.scala:620:22, :624:46, :625:66
  wire        idx_match_0 =
    idx_matches_0_0 | idx_matches_0_1 | idx_matches_0_2 | idx_matches_0_3
    | idx_matches_0_4 | idx_matches_0_5 | idx_matches_0_6 | idx_matches_0_7;	// mshrs.scala:594:58, :624:46
  wire        idx_match_1 =
    idx_matches_1_0 | idx_matches_1_1 | idx_matches_1_2 | idx_matches_1_3
    | idx_matches_1_4 | idx_matches_1_5 | idx_matches_1_6 | idx_matches_1_7;	// mshrs.scala:594:58, :624:46
  wire        _mshr_io_req_sec_val_T_28 = _GEN & sdq_rdy;	// Parameters.scala:137:31, mshrs.scala:557:31, :618:27
  wire        pri_val =
    _mshr_io_req_sec_val_T_28 & cacheable & ~(io_req_1_valid ? idx_match_1 : idx_match_0);	// Parameters.scala:671:42, mshrs.scala:594:58, :618:{27,51,54}
  assign idx_matches_0_0 =
    _mshrs_0_io_idx_valid & _mshrs_0_io_idx_bits == io_req_0_bits_addr[11:6];	// mshrs.scala:620:22, :624:{46,66,89}
  assign _tag_matches_0_0_T_1 = _mshrs_0_io_tag_bits == io_req_0_bits_addr[39:12];	// mshrs.scala:620:22, :625:{66,90}
  assign _way_matches_0_0_T = _mshrs_0_io_way_bits == io_req_0_bits_way_en;	// mshrs.scala:620:22, :626:66
  assign idx_matches_1_0 =
    _mshrs_0_io_idx_valid & _mshrs_0_io_idx_bits == io_req_1_bits_addr[11:6];	// mshrs.scala:620:22, :624:{46,66,89}
  assign _tag_matches_1_0_T_1 = _mshrs_0_io_tag_bits == io_req_1_bits_addr[39:12];	// mshrs.scala:620:22, :625:{66,90}
  assign _way_matches_1_0_T = _mshrs_0_io_way_bits == io_req_1_bits_way_en;	// mshrs.scala:620:22, :626:66
  wire        _mshr_io_req_pri_val_T = mshr_alloc_idx_REG == 3'h0;	// mshrs.scala:621:16, :632:34, :694:31
  wire        _GEN_86 = io_req_1_valid ? tag_match_1 : tag_match_0;	// Mux.scala:27:72, mshrs.scala:637:50
  wire        _GEN_87 = io_req_1_valid ? idx_matches_1_0 : idx_matches_0_0;	// mshrs.scala:624:46, :637:72
  wire        _GEN_88 = io_req_1_valid ? idx_matches_1_1 : idx_matches_0_1;	// mshrs.scala:624:46, :637:72
  wire        _GEN_89 = io_req_1_valid ? idx_matches_1_2 : idx_matches_0_2;	// mshrs.scala:624:46, :637:72
  wire        _GEN_90 = io_req_1_valid ? idx_matches_1_3 : idx_matches_0_3;	// mshrs.scala:624:46, :637:72
  wire        _GEN_91 = io_req_1_valid ? idx_matches_1_4 : idx_matches_0_4;	// mshrs.scala:624:46, :637:72
  wire        _GEN_92 = io_req_1_valid ? idx_matches_1_5 : idx_matches_0_5;	// mshrs.scala:624:46, :637:72
  wire        _GEN_93 = io_req_1_valid ? idx_matches_1_6 : idx_matches_0_6;	// mshrs.scala:624:46, :637:72
  wire        _GEN_94 = io_req_1_valid ? idx_matches_1_7 : idx_matches_0_7;	// mshrs.scala:624:46, :637:72
  wire        _mshr_io_req_sec_val_T_3 =
    _mshr_io_req_sec_val_T_28 & _GEN_86 & _GEN_87 & cacheable;	// Parameters.scala:671:42, mshrs.scala:618:27, :637:{50,72,99}
  wire        _GEN_95 = io_mem_grant_bits_source == 4'h0;	// Mux.scala:47:69, mshrs.scala:673:36
  assign idx_matches_0_1 =
    _mshrs_1_io_idx_valid & _mshrs_1_io_idx_bits == io_req_0_bits_addr[11:6];	// mshrs.scala:620:22, :624:{46,66,89}
  assign _tag_matches_0_1_T_1 = _mshrs_1_io_tag_bits == io_req_0_bits_addr[39:12];	// mshrs.scala:620:22, :625:{66,90}
  assign _way_matches_0_1_T = _mshrs_1_io_way_bits == io_req_0_bits_way_en;	// mshrs.scala:620:22, :626:66
  assign idx_matches_1_1 =
    _mshrs_1_io_idx_valid & _mshrs_1_io_idx_bits == io_req_1_bits_addr[11:6];	// mshrs.scala:620:22, :624:{46,66,89}
  assign _tag_matches_1_1_T_1 = _mshrs_1_io_tag_bits == io_req_1_bits_addr[39:12];	// mshrs.scala:620:22, :625:{66,90}
  assign _way_matches_1_1_T = _mshrs_1_io_way_bits == io_req_1_bits_way_en;	// mshrs.scala:620:22, :626:66
  wire        _mshr_io_req_sec_val_T_7 =
    _mshr_io_req_sec_val_T_28 & _GEN_86 & _GEN_88 & cacheable;	// Parameters.scala:671:42, mshrs.scala:618:27, :637:{50,72,99}
  wire        _GEN_96 = io_mem_grant_bits_source == 4'h1;	// Mux.scala:47:69, mshrs.scala:673:36
  assign idx_matches_0_2 =
    _mshrs_2_io_idx_valid & _mshrs_2_io_idx_bits == io_req_0_bits_addr[11:6];	// mshrs.scala:620:22, :624:{46,66,89}
  assign _tag_matches_0_2_T_1 = _mshrs_2_io_tag_bits == io_req_0_bits_addr[39:12];	// mshrs.scala:620:22, :625:{66,90}
  assign _way_matches_0_2_T = _mshrs_2_io_way_bits == io_req_0_bits_way_en;	// mshrs.scala:620:22, :626:66
  assign idx_matches_1_2 =
    _mshrs_2_io_idx_valid & _mshrs_2_io_idx_bits == io_req_1_bits_addr[11:6];	// mshrs.scala:620:22, :624:{46,66,89}
  assign _tag_matches_1_2_T_1 = _mshrs_2_io_tag_bits == io_req_1_bits_addr[39:12];	// mshrs.scala:620:22, :625:{66,90}
  assign _way_matches_1_2_T = _mshrs_2_io_way_bits == io_req_1_bits_way_en;	// mshrs.scala:620:22, :626:66
  wire        _mshr_io_req_sec_val_T_11 =
    _mshr_io_req_sec_val_T_28 & _GEN_86 & _GEN_89 & cacheable;	// Parameters.scala:671:42, mshrs.scala:618:27, :637:{50,72,99}
  wire        _GEN_97 = io_mem_grant_bits_source == 4'h2;	// Mux.scala:47:69, mshrs.scala:673:36
  assign idx_matches_0_3 =
    _mshrs_3_io_idx_valid & _mshrs_3_io_idx_bits == io_req_0_bits_addr[11:6];	// mshrs.scala:620:22, :624:{46,66,89}
  assign _tag_matches_0_3_T_1 = _mshrs_3_io_tag_bits == io_req_0_bits_addr[39:12];	// mshrs.scala:620:22, :625:{66,90}
  assign _way_matches_0_3_T = _mshrs_3_io_way_bits == io_req_0_bits_way_en;	// mshrs.scala:620:22, :626:66
  assign idx_matches_1_3 =
    _mshrs_3_io_idx_valid & _mshrs_3_io_idx_bits == io_req_1_bits_addr[11:6];	// mshrs.scala:620:22, :624:{46,66,89}
  assign _tag_matches_1_3_T_1 = _mshrs_3_io_tag_bits == io_req_1_bits_addr[39:12];	// mshrs.scala:620:22, :625:{66,90}
  assign _way_matches_1_3_T = _mshrs_3_io_way_bits == io_req_1_bits_way_en;	// mshrs.scala:620:22, :626:66
  wire        _mshr_io_req_sec_val_T_15 =
    _mshr_io_req_sec_val_T_28 & _GEN_86 & _GEN_90 & cacheable;	// Parameters.scala:671:42, mshrs.scala:618:27, :637:{50,72,99}
  wire        _GEN_98 = io_mem_grant_bits_source == 4'h3;	// Mux.scala:47:69, mshrs.scala:673:36
  assign idx_matches_0_4 =
    _mshrs_4_io_idx_valid & _mshrs_4_io_idx_bits == io_req_0_bits_addr[11:6];	// mshrs.scala:620:22, :624:{46,66,89}
  assign _tag_matches_0_4_T_1 = _mshrs_4_io_tag_bits == io_req_0_bits_addr[39:12];	// mshrs.scala:620:22, :625:{66,90}
  assign _way_matches_0_4_T = _mshrs_4_io_way_bits == io_req_0_bits_way_en;	// mshrs.scala:620:22, :626:66
  assign idx_matches_1_4 =
    _mshrs_4_io_idx_valid & _mshrs_4_io_idx_bits == io_req_1_bits_addr[11:6];	// mshrs.scala:620:22, :624:{46,66,89}
  assign _tag_matches_1_4_T_1 = _mshrs_4_io_tag_bits == io_req_1_bits_addr[39:12];	// mshrs.scala:620:22, :625:{66,90}
  assign _way_matches_1_4_T = _mshrs_4_io_way_bits == io_req_1_bits_way_en;	// mshrs.scala:620:22, :626:66
  wire        _mshr_io_req_sec_val_T_19 =
    _mshr_io_req_sec_val_T_28 & _GEN_86 & _GEN_91 & cacheable;	// Parameters.scala:671:42, mshrs.scala:618:27, :637:{50,72,99}
  wire        _GEN_99 = io_mem_grant_bits_source == 4'h4;	// Mux.scala:47:69, mshrs.scala:673:36
  assign idx_matches_0_5 =
    _mshrs_5_io_idx_valid & _mshrs_5_io_idx_bits == io_req_0_bits_addr[11:6];	// mshrs.scala:620:22, :624:{46,66,89}
  assign _tag_matches_0_5_T_1 = _mshrs_5_io_tag_bits == io_req_0_bits_addr[39:12];	// mshrs.scala:620:22, :625:{66,90}
  assign _way_matches_0_5_T = _mshrs_5_io_way_bits == io_req_0_bits_way_en;	// mshrs.scala:620:22, :626:66
  assign idx_matches_1_5 =
    _mshrs_5_io_idx_valid & _mshrs_5_io_idx_bits == io_req_1_bits_addr[11:6];	// mshrs.scala:620:22, :624:{46,66,89}
  assign _tag_matches_1_5_T_1 = _mshrs_5_io_tag_bits == io_req_1_bits_addr[39:12];	// mshrs.scala:620:22, :625:{66,90}
  assign _way_matches_1_5_T = _mshrs_5_io_way_bits == io_req_1_bits_way_en;	// mshrs.scala:620:22, :626:66
  wire        _mshr_io_req_sec_val_T_23 =
    _mshr_io_req_sec_val_T_28 & _GEN_86 & _GEN_92 & cacheable;	// Parameters.scala:671:42, mshrs.scala:618:27, :637:{50,72,99}
  wire        _GEN_100 = io_mem_grant_bits_source == 4'h5;	// Mux.scala:47:69, mshrs.scala:673:36
  assign idx_matches_0_6 =
    _mshrs_6_io_idx_valid & _mshrs_6_io_idx_bits == io_req_0_bits_addr[11:6];	// mshrs.scala:620:22, :624:{46,66,89}
  assign _tag_matches_0_6_T_1 = _mshrs_6_io_tag_bits == io_req_0_bits_addr[39:12];	// mshrs.scala:620:22, :625:{66,90}
  assign _way_matches_0_6_T = _mshrs_6_io_way_bits == io_req_0_bits_way_en;	// mshrs.scala:620:22, :626:66
  assign idx_matches_1_6 =
    _mshrs_6_io_idx_valid & _mshrs_6_io_idx_bits == io_req_1_bits_addr[11:6];	// mshrs.scala:620:22, :624:{46,66,89}
  assign _tag_matches_1_6_T_1 = _mshrs_6_io_tag_bits == io_req_1_bits_addr[39:12];	// mshrs.scala:620:22, :625:{66,90}
  assign _way_matches_1_6_T = _mshrs_6_io_way_bits == io_req_1_bits_way_en;	// mshrs.scala:620:22, :626:66
  wire        _mshr_io_req_sec_val_T_27 =
    _mshr_io_req_sec_val_T_28 & _GEN_86 & _GEN_93 & cacheable;	// Parameters.scala:671:42, mshrs.scala:618:27, :637:{50,72,99}
  wire        _GEN_101 = io_mem_grant_bits_source == 4'h6;	// ReadyValidCancel.scala:70:19, mshrs.scala:620:22, :673:36
  assign idx_matches_0_7 =
    _mshrs_7_io_idx_valid & _mshrs_7_io_idx_bits == io_req_0_bits_addr[11:6];	// mshrs.scala:620:22, :624:{46,66,89}
  assign _tag_matches_0_7_T_1 = _mshrs_7_io_tag_bits == io_req_0_bits_addr[39:12];	// mshrs.scala:620:22, :625:{66,90}
  assign _way_matches_0_7_T = _mshrs_7_io_way_bits == io_req_0_bits_way_en;	// mshrs.scala:620:22, :626:66
  assign idx_matches_1_7 =
    _mshrs_7_io_idx_valid & _mshrs_7_io_idx_bits == io_req_1_bits_addr[11:6];	// mshrs.scala:620:22, :624:{46,66,89}
  assign _tag_matches_1_7_T_1 = _mshrs_7_io_tag_bits == io_req_1_bits_addr[39:12];	// mshrs.scala:620:22, :625:{66,90}
  assign _way_matches_1_7_T = _mshrs_7_io_way_bits == io_req_1_bits_way_en;	// mshrs.scala:620:22, :626:66
  wire [7:0]  _GEN_102 =
    {{_mshrs_7_io_req_pri_rdy},
     {_mshrs_6_io_req_pri_rdy},
     {_mshrs_5_io_req_pri_rdy},
     {_mshrs_4_io_req_pri_rdy},
     {_mshrs_3_io_req_pri_rdy},
     {_mshrs_2_io_req_pri_rdy},
     {_mshrs_1_io_req_pri_rdy},
     {_mshr_io_req_pri_val_T & _mshrs_0_io_req_pri_rdy}};	// mshrs.scala:620:22, :632:34, :633:35, :634:15
  wire        pri_rdy = _GEN_102[mshr_alloc_idx_REG];	// mshrs.scala:632:34, :633:35, :634:15, :694:31
  wire        _mshr_io_req_sec_val_T_31 =
    _mshr_io_req_sec_val_T_28 & _GEN_86 & _GEN_94 & cacheable;	// Parameters.scala:671:42, mshrs.scala:618:27, :637:{50,72,99}
  wire        _GEN_103 = io_mem_grant_bits_source == 4'h7;	// Mux.scala:47:69, mshrs.scala:673:36
  wire        sec_rdy =
    _mshrs_0_io_req_sec_rdy & _mshr_io_req_sec_val_T_3 | _mshrs_1_io_req_sec_rdy
    & _mshr_io_req_sec_val_T_7 | _mshrs_2_io_req_sec_rdy & _mshr_io_req_sec_val_T_11
    | _mshrs_3_io_req_sec_rdy & _mshr_io_req_sec_val_T_15 | _mshrs_4_io_req_sec_rdy
    & _mshr_io_req_sec_val_T_19 | _mshrs_5_io_req_sec_rdy & _mshr_io_req_sec_val_T_23
    | _mshrs_6_io_req_sec_rdy & _mshr_io_req_sec_val_T_27 | _mshrs_7_io_req_sec_rdy
    & _mshr_io_req_sec_val_T_31;	// mshrs.scala:620:22, :637:99, :677:{25,49}
  reg  [2:0]  mshr_head;	// mshrs.scala:693:31
  wire        _mshr_io_mem_ack_valid_T = io_mem_grant_bits_source == 4'h9;	// Mux.scala:47:69, mshrs.scala:720:77
  reg  [8:0]  beatsLeft;	// Arbiter.scala:87:30
  wire        idle = beatsLeft == 9'h0;	// Arbiter.scala:87:30, :88:28, :112:44
  wire        _GEN_104 = _mshrs_5_io_mem_acquire_valid | _mshrs_4_io_mem_acquire_valid;	// mshrs.scala:620:22, package.scala:244:43
  wire        _GEN_105 = _mshrs_4_io_mem_acquire_valid | _mshrs_3_io_mem_acquire_valid;	// mshrs.scala:620:22, package.scala:244:43
  wire        _GEN_106 = _mshrs_3_io_mem_acquire_valid | _mshrs_2_io_mem_acquire_valid;	// mshrs.scala:620:22, package.scala:244:43
  wire        _GEN_107 = _mshrs_2_io_mem_acquire_valid | _mshrs_1_io_mem_acquire_valid;	// mshrs.scala:620:22, package.scala:244:43
  wire        _GEN_108 = _mshrs_1_io_mem_acquire_valid | _mshrs_0_io_mem_acquire_valid;	// mshrs.scala:620:22, package.scala:244:43
  wire        _GEN_109 = _GEN_106 | _GEN_108;	// package.scala:244:43
  wire        _GEN_110 = _GEN_107 | _mshrs_0_io_mem_acquire_valid;	// mshrs.scala:620:22, package.scala:244:43
  wire        _GEN_111 =
    _mshrs_7_io_mem_acquire_valid | _mshrs_6_io_mem_acquire_valid | _GEN_104 | _GEN_109;	// mshrs.scala:620:22, package.scala:244:43
  wire        _GEN_112 =
    _mshrs_6_io_mem_acquire_valid | _mshrs_5_io_mem_acquire_valid | _GEN_105 | _GEN_110;	// mshrs.scala:620:22, package.scala:244:43
  wire        _GEN_113 = _GEN_104 | _GEN_106 | _GEN_108;	// package.scala:244:43
  wire        _GEN_114 = _GEN_105 | _GEN_107 | _mshrs_0_io_mem_acquire_valid;	// mshrs.scala:620:22, package.scala:244:43
  wire        earlyWinner_1 =
    ~_mshrs_0_io_mem_acquire_valid & _mshrs_1_io_mem_acquire_valid;	// Arbiter.scala:16:61, :97:79, mshrs.scala:620:22
  wire        earlyWinner_2 = ~_GEN_108 & _mshrs_2_io_mem_acquire_valid;	// Arbiter.scala:16:61, :97:79, mshrs.scala:620:22, package.scala:244:43
  wire        earlyWinner_3 = ~_GEN_110 & _mshrs_3_io_mem_acquire_valid;	// Arbiter.scala:16:61, :97:79, mshrs.scala:620:22, package.scala:244:43
  wire        earlyWinner_4 = ~_GEN_109 & _mshrs_4_io_mem_acquire_valid;	// Arbiter.scala:16:61, :97:79, mshrs.scala:620:22, package.scala:244:43
  wire        earlyWinner_5 = ~_GEN_114 & _mshrs_5_io_mem_acquire_valid;	// Arbiter.scala:16:61, :97:79, mshrs.scala:620:22, package.scala:244:43
  wire        earlyWinner_6 = ~_GEN_113 & _mshrs_6_io_mem_acquire_valid;	// Arbiter.scala:16:61, :97:79, mshrs.scala:620:22, package.scala:244:43
  wire        earlyWinner_7 = ~_GEN_112 & _mshrs_7_io_mem_acquire_valid;	// Arbiter.scala:16:61, :97:79, mshrs.scala:620:22, package.scala:244:43
  wire        earlyWinner_8 = ~_GEN_111 & _mmios_0_io_mem_access_valid;	// Arbiter.scala:16:61, :97:79, mshrs.scala:710:22, package.scala:244:43
  wire        _sink_ACancel_earlyValid_T =
    _mshrs_0_io_mem_acquire_valid | _mshrs_1_io_mem_acquire_valid;	// Arbiter.scala:107:36, mshrs.scala:620:22
  reg         state_0;	// Arbiter.scala:116:26
  reg         state_1;	// Arbiter.scala:116:26
  reg         state_2;	// Arbiter.scala:116:26
  reg         state_3;	// Arbiter.scala:116:26
  reg         state_4;	// Arbiter.scala:116:26
  reg         state_5;	// Arbiter.scala:116:26
  reg         state_6;	// Arbiter.scala:116:26
  reg         state_7;	// Arbiter.scala:116:26
  reg         state_8;	// Arbiter.scala:116:26
  wire        muxStateEarly_0 = idle ? _mshrs_0_io_mem_acquire_valid : state_0;	// Arbiter.scala:88:28, :116:26, :117:30, mshrs.scala:620:22
  wire        muxStateEarly_1 = idle ? earlyWinner_1 : state_1;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        muxStateEarly_2 = idle ? earlyWinner_2 : state_2;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        muxStateEarly_3 = idle ? earlyWinner_3 : state_3;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        muxStateEarly_4 = idle ? earlyWinner_4 : state_4;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        muxStateEarly_5 = idle ? earlyWinner_5 : state_5;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        muxStateEarly_6 = idle ? earlyWinner_6 : state_6;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        muxStateEarly_7 = idle ? earlyWinner_7 : state_7;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        muxStateEarly_8 = idle ? earlyWinner_8 : state_8;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        out_9_valid =
    idle
      ? _sink_ACancel_earlyValid_T | _mshrs_2_io_mem_acquire_valid
        | _mshrs_3_io_mem_acquire_valid | _mshrs_4_io_mem_acquire_valid
        | _mshrs_5_io_mem_acquire_valid | _mshrs_6_io_mem_acquire_valid
        | _mshrs_7_io_mem_acquire_valid | _mmios_0_io_mem_access_valid
      : state_0 & _mshrs_0_io_mem_acquire_valid | state_1 & _mshrs_1_io_mem_acquire_valid
        | state_2 & _mshrs_2_io_mem_acquire_valid | state_3
        & _mshrs_3_io_mem_acquire_valid | state_4 & _mshrs_4_io_mem_acquire_valid
        | state_5 & _mshrs_5_io_mem_acquire_valid | state_6
        & _mshrs_6_io_mem_acquire_valid | state_7 & _mshrs_7_io_mem_acquire_valid
        | state_8 & _mmios_0_io_mem_access_valid;	// Arbiter.scala:88:28, :107:36, :116:26, :125:{29,56}, Mux.scala:27:72, mshrs.scala:620:22, :710:22
  wire        _GEN_115 =
    muxStateEarly_0 | muxStateEarly_1 | muxStateEarly_2 | muxStateEarly_3
    | muxStateEarly_4 | muxStateEarly_5 | muxStateEarly_6 | muxStateEarly_7;	// Arbiter.scala:117:30, Mux.scala:27:72
  reg         beatsLeft_1;	// Arbiter.scala:87:30
  wire        _GEN_116 = _mshrs_4_io_mem_finish_valid | _mshrs_3_io_mem_finish_valid;	// mshrs.scala:620:22, package.scala:244:43
  wire        _GEN_117 = _mshrs_3_io_mem_finish_valid | _mshrs_2_io_mem_finish_valid;	// mshrs.scala:620:22, package.scala:244:43
  wire        _GEN_118 = _mshrs_2_io_mem_finish_valid | _mshrs_1_io_mem_finish_valid;	// mshrs.scala:620:22, package.scala:244:43
  wire        _GEN_119 = _mshrs_1_io_mem_finish_valid | _mshrs_0_io_mem_finish_valid;	// mshrs.scala:620:22, package.scala:244:43
  wire        _GEN_120 = _GEN_117 | _GEN_119;	// package.scala:244:43
  wire        _GEN_121 = _GEN_118 | _mshrs_0_io_mem_finish_valid;	// mshrs.scala:620:22, package.scala:244:43
  wire        _GEN_122 =
    _mshrs_6_io_mem_finish_valid | _mshrs_5_io_mem_finish_valid | _GEN_116 | _GEN_121;	// mshrs.scala:620:22, package.scala:244:43
  wire        _GEN_123 =
    _mshrs_5_io_mem_finish_valid | _mshrs_4_io_mem_finish_valid | _GEN_117 | _GEN_119;	// mshrs.scala:620:22, package.scala:244:43
  wire        _GEN_124 = _GEN_116 | _GEN_118 | _mshrs_0_io_mem_finish_valid;	// mshrs.scala:620:22, package.scala:244:43
  wire        earlyWinner_1_1 =
    ~_mshrs_0_io_mem_finish_valid & _mshrs_1_io_mem_finish_valid;	// Arbiter.scala:16:61, :97:79, mshrs.scala:620:22
  wire        earlyWinner_1_2 = ~_GEN_119 & _mshrs_2_io_mem_finish_valid;	// Arbiter.scala:16:61, :97:79, mshrs.scala:620:22, package.scala:244:43
  wire        earlyWinner_1_3 = ~_GEN_121 & _mshrs_3_io_mem_finish_valid;	// Arbiter.scala:16:61, :97:79, mshrs.scala:620:22, package.scala:244:43
  wire        earlyWinner_1_4 = ~_GEN_120 & _mshrs_4_io_mem_finish_valid;	// Arbiter.scala:16:61, :97:79, mshrs.scala:620:22, package.scala:244:43
  wire        earlyWinner_1_5 = ~_GEN_124 & _mshrs_5_io_mem_finish_valid;	// Arbiter.scala:16:61, :97:79, mshrs.scala:620:22, package.scala:244:43
  wire        earlyWinner_1_6 = ~_GEN_123 & _mshrs_6_io_mem_finish_valid;	// Arbiter.scala:16:61, :97:79, mshrs.scala:620:22, package.scala:244:43
  wire        earlyWinner_1_7 = ~_GEN_122 & _mshrs_7_io_mem_finish_valid;	// Arbiter.scala:16:61, :97:79, mshrs.scala:620:22, package.scala:244:43
  wire        _sink_ACancel_earlyValid_T_26 =
    _mshrs_0_io_mem_finish_valid | _mshrs_1_io_mem_finish_valid;	// Arbiter.scala:107:36, mshrs.scala:620:22
  `ifndef SYNTHESIS	// Arbiter.scala:105:13
    always @(posedge clock) begin	// Arbiter.scala:105:13
      automatic logic prefixOR_2 = _mshrs_0_io_mem_acquire_valid | earlyWinner_1;	// Arbiter.scala:97:79, :104:53, mshrs.scala:620:22
      automatic logic prefixOR_3 = prefixOR_2 | earlyWinner_2;	// Arbiter.scala:97:79, :104:53
      automatic logic prefixOR_4 = prefixOR_3 | earlyWinner_3;	// Arbiter.scala:97:79, :104:53
      automatic logic prefixOR_5 = prefixOR_4 | earlyWinner_4;	// Arbiter.scala:97:79, :104:53
      automatic logic prefixOR_6 = prefixOR_5 | earlyWinner_5;	// Arbiter.scala:97:79, :104:53
      automatic logic prefixOR_7 = prefixOR_6 | earlyWinner_6;	// Arbiter.scala:97:79, :104:53
      automatic logic prefixOR_2_1 = _mshrs_0_io_mem_finish_valid | earlyWinner_1_1;	// Arbiter.scala:97:79, :104:53, mshrs.scala:620:22
      automatic logic prefixOR_3_1 = prefixOR_2_1 | earlyWinner_1_2;	// Arbiter.scala:97:79, :104:53
      automatic logic prefixOR_4_1 = prefixOR_3_1 | earlyWinner_1_3;	// Arbiter.scala:97:79, :104:53
      automatic logic prefixOR_5_1 = prefixOR_4_1 | earlyWinner_1_4;	// Arbiter.scala:97:79, :104:53
      automatic logic prefixOR_6_1 = prefixOR_5_1 | earlyWinner_1_5;	// Arbiter.scala:97:79, :104:53
      if (~((~_mshrs_0_io_mem_acquire_valid | ~earlyWinner_1)
            & (~prefixOR_2 | ~earlyWinner_2) & (~prefixOR_3 | ~earlyWinner_3)
            & (~prefixOR_4 | ~earlyWinner_4) & (~prefixOR_5 | ~earlyWinner_5)
            & (~prefixOR_6 | ~earlyWinner_6) & (~prefixOR_7 | ~earlyWinner_7)
            & (~(prefixOR_7 | earlyWinner_7) | ~earlyWinner_8) | reset)) begin	// Arbiter.scala:97:79, :104:53, :105:{13,61,64,67,82}, mshrs.scala:620:22
        if (`ASSERT_VERBOSE_COND_)	// Arbiter.scala:105:13
          $error("Assertion failed\n    at Arbiter.scala:105 assert((prefixOR zip earlyWinner) map { case (p,w) => !p || !w } reduce {_ && _})\n");	// Arbiter.scala:105:13
        if (`STOP_COND_)	// Arbiter.scala:105:13
          $fatal;	// Arbiter.scala:105:13
      end
      if (~(~(_sink_ACancel_earlyValid_T | _mshrs_2_io_mem_acquire_valid
              | _mshrs_3_io_mem_acquire_valid | _mshrs_4_io_mem_acquire_valid
              | _mshrs_5_io_mem_acquire_valid | _mshrs_6_io_mem_acquire_valid
              | _mshrs_7_io_mem_acquire_valid | _mmios_0_io_mem_access_valid)
            | _mshrs_0_io_mem_acquire_valid | earlyWinner_1 | earlyWinner_2
            | earlyWinner_3 | earlyWinner_4 | earlyWinner_5 | earlyWinner_6
            | earlyWinner_7 | earlyWinner_8 | reset)) begin	// Arbiter.scala:97:79, :107:{14,15,36}, mshrs.scala:620:22, :710:22
        if (`ASSERT_VERBOSE_COND_)	// Arbiter.scala:107:14
          $error("Assertion failed\n    at Arbiter.scala:107 assert (!earlyValids.reduce(_||_) || earlyWinner.reduce(_||_))\n");	// Arbiter.scala:107:14
        if (`STOP_COND_)	// Arbiter.scala:107:14
          $fatal;	// Arbiter.scala:107:14
      end
      if (~((~_mshrs_0_io_mem_finish_valid | ~earlyWinner_1_1)
            & (~prefixOR_2_1 | ~earlyWinner_1_2) & (~prefixOR_3_1 | ~earlyWinner_1_3)
            & (~prefixOR_4_1 | ~earlyWinner_1_4) & (~prefixOR_5_1 | ~earlyWinner_1_5)
            & (~prefixOR_6_1 | ~earlyWinner_1_6)
            & (~(prefixOR_6_1 | earlyWinner_1_6) | ~earlyWinner_1_7) | reset)) begin	// Arbiter.scala:97:79, :104:53, :105:{13,61,64,67,82}, mshrs.scala:620:22
        if (`ASSERT_VERBOSE_COND_)	// Arbiter.scala:105:13
          $error("Assertion failed\n    at Arbiter.scala:105 assert((prefixOR zip earlyWinner) map { case (p,w) => !p || !w } reduce {_ && _})\n");	// Arbiter.scala:105:13
        if (`STOP_COND_)	// Arbiter.scala:105:13
          $fatal;	// Arbiter.scala:105:13
      end
      if (~(~(_sink_ACancel_earlyValid_T_26 | _mshrs_2_io_mem_finish_valid
              | _mshrs_3_io_mem_finish_valid | _mshrs_4_io_mem_finish_valid
              | _mshrs_5_io_mem_finish_valid | _mshrs_6_io_mem_finish_valid
              | _mshrs_7_io_mem_finish_valid) | _mshrs_0_io_mem_finish_valid
            | earlyWinner_1_1 | earlyWinner_1_2 | earlyWinner_1_3 | earlyWinner_1_4
            | earlyWinner_1_5 | earlyWinner_1_6 | earlyWinner_1_7 | reset)) begin	// Arbiter.scala:97:79, :107:{14,15,36}, mshrs.scala:620:22
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
  reg         state_1_3;	// Arbiter.scala:116:26
  reg         state_1_4;	// Arbiter.scala:116:26
  reg         state_1_5;	// Arbiter.scala:116:26
  reg         state_1_6;	// Arbiter.scala:116:26
  reg         state_1_7;	// Arbiter.scala:116:26
  wire        out_18_valid =
    beatsLeft_1
      ? state_1_0 & _mshrs_0_io_mem_finish_valid | state_1_1
        & _mshrs_1_io_mem_finish_valid | state_1_2 & _mshrs_2_io_mem_finish_valid
        | state_1_3 & _mshrs_3_io_mem_finish_valid | state_1_4
        & _mshrs_4_io_mem_finish_valid | state_1_5 & _mshrs_5_io_mem_finish_valid
        | state_1_6 & _mshrs_6_io_mem_finish_valid | state_1_7
        & _mshrs_7_io_mem_finish_valid
      : _sink_ACancel_earlyValid_T_26 | _mshrs_2_io_mem_finish_valid
        | _mshrs_3_io_mem_finish_valid | _mshrs_4_io_mem_finish_valid
        | _mshrs_5_io_mem_finish_valid | _mshrs_6_io_mem_finish_valid
        | _mshrs_7_io_mem_finish_valid;	// Arbiter.scala:87:30, :107:36, :116:26, :125:{29,56}, Mux.scala:27:72, mshrs.scala:620:22
  assign _io_req_0_ready_output =
    ~io_req_1_valid
    & (cacheable
         ? sdq_rdy & (idx_match_0 ? tag_match_0 & sec_rdy : pri_rdy)
         : _mmios_0_io_req_ready);	// Mux.scala:27:72, Parameters.scala:671:42, mshrs.scala:557:31, :594:58, :633:35, :634:15, :677:25, :710:22, :744:{34,47}, :745:{10,41,47,75}
  assign _io_req_1_ready_output =
    io_req_1_valid
    & (cacheable
         ? sdq_rdy & (idx_match_1 ? tag_match_1 & sec_rdy : pri_rdy)
         : _mmios_0_io_req_ready);	// Mux.scala:27:72, Parameters.scala:671:42, mshrs.scala:557:31, :594:58, :633:35, :634:15, :677:25, :710:22, :744:47, :745:{10,41,47,75}
  reg         prefetcher_io_mshr_avail_REG;	// mshrs.scala:761:41
  reg         prefetcher_io_req_val_REG;	// mshrs.scala:762:41
  reg  [39:0] prefetcher_io_req_addr_REG;	// mshrs.scala:763:41
  reg  [1:0]  prefetcher_io_req_coh_REG_state;	// mshrs.scala:764:41
  always @(posedge clock) begin
    if (reset) begin
      sdq_val <= 17'h0;	// mshrs.scala:555:29
      mshr_head <= 3'h0;	// mshrs.scala:621:16, :693:31
      beatsLeft <= 9'h0;	// Arbiter.scala:87:30, :112:44
      state_0 <= 1'h0;	// Arbiter.scala:116:26, mshrs.scala:543:21
      state_1 <= 1'h0;	// Arbiter.scala:116:26, mshrs.scala:543:21
      state_2 <= 1'h0;	// Arbiter.scala:116:26, mshrs.scala:543:21
      state_3 <= 1'h0;	// Arbiter.scala:116:26, mshrs.scala:543:21
      state_4 <= 1'h0;	// Arbiter.scala:116:26, mshrs.scala:543:21
      state_5 <= 1'h0;	// Arbiter.scala:116:26, mshrs.scala:543:21
      state_6 <= 1'h0;	// Arbiter.scala:116:26, mshrs.scala:543:21
      state_7 <= 1'h0;	// Arbiter.scala:116:26, mshrs.scala:543:21
      state_8 <= 1'h0;	// Arbiter.scala:116:26, mshrs.scala:543:21
      beatsLeft_1 <= 1'h0;	// Arbiter.scala:87:30, mshrs.scala:543:21
      state_1_0 <= 1'h0;	// Arbiter.scala:116:26, mshrs.scala:543:21
      state_1_1 <= 1'h0;	// Arbiter.scala:116:26, mshrs.scala:543:21
      state_1_2 <= 1'h0;	// Arbiter.scala:116:26, mshrs.scala:543:21
      state_1_3 <= 1'h0;	// Arbiter.scala:116:26, mshrs.scala:543:21
      state_1_4 <= 1'h0;	// Arbiter.scala:116:26, mshrs.scala:543:21
      state_1_5 <= 1'h0;	// Arbiter.scala:116:26, mshrs.scala:543:21
      state_1_6 <= 1'h0;	// Arbiter.scala:116:26, mshrs.scala:543:21
      state_1_7 <= 1'h0;	// Arbiter.scala:116:26, mshrs.scala:543:21
    end
    else begin
      automatic logic winnerQual_8;	// Arbiter.scala:98:79
      winnerQual_8 = ~_GEN_111 & _mmios_0_io_mem_access_valid;	// Arbiter.scala:16:61, :98:79, mshrs.scala:710:22, package.scala:244:43
      if (_replay_arb_io_out_valid | sdq_enq) begin	// mshrs.scala:558:46, :602:30, :756:25
        automatic logic [16:0] _sdq_val_T_7;	// mshrs.scala:758:25
        automatic logic [31:0] _sdq_val_T = 32'h1 << _replay_arb_io_out_bits_sdq_id;	// OneHot.scala:58:35, mshrs.scala:602:30
        _sdq_val_T_7 = ~sdq_val;	// mshrs.scala:555:29, :758:25
        sdq_val <=
          ~(_sdq_val_T[16:0]
            & {17{io_replay_ready & _replay_arb_io_out_valid
                    & (_replay_arb_io_out_bits_uop_mem_cmd == 5'h1
                       | _replay_arb_io_out_bits_uop_mem_cmd == 5'h11
                       | _replay_arb_io_out_bits_uop_mem_cmd == 5'h7
                       | _replay_arb_io_out_bits_uop_mem_cmd == 5'h4
                       | _replay_arb_io_out_bits_uop_mem_cmd == 5'h9
                       | _replay_arb_io_out_bits_uop_mem_cmd == 5'hA
                       | _replay_arb_io_out_bits_uop_mem_cmd == 5'hB
                       | _replay_arb_io_out_bits_uop_mem_cmd == 5'h8
                       | _replay_arb_io_out_bits_uop_mem_cmd == 5'hC
                       | _replay_arb_io_out_bits_uop_mem_cmd == 5'hD
                       | _replay_arb_io_out_bits_uop_mem_cmd == 5'hE
                       | _replay_arb_io_out_bits_uop_mem_cmd == 5'hF)}}) & sdq_val
          | (_sdq_val_T_7[0]
               ? 17'h1
               : _sdq_val_T_7[1]
                   ? 17'h2
                   : _sdq_val_T_7[2]
                       ? 17'h4
                       : _sdq_val_T_7[3]
                           ? 17'h8
                           : _sdq_val_T_7[4]
                               ? 17'h10
                               : _sdq_val_T_7[5]
                                   ? 17'h20
                                   : _sdq_val_T_7[6]
                                       ? 17'h40
                                       : _sdq_val_T_7[7]
                                           ? 17'h80
                                           : _sdq_val_T_7[8]
                                               ? 17'h100
                                               : _sdq_val_T_7[9]
                                                   ? 17'h200
                                                   : _sdq_val_T_7[10]
                                                       ? 17'h400
                                                       : _sdq_val_T_7[11]
                                                           ? 17'h800
                                                           : _sdq_val_T_7[12]
                                                               ? 17'h1000
                                                               : _sdq_val_T_7[13]
                                                                   ? 17'h2000
                                                                   : _sdq_val_T_7[14]
                                                                       ? 17'h4000
                                                                       : _sdq_val_T_7[15]
                                                                           ? 17'h8000
                                                                           : {_sdq_val_T_7[16],
                                                                              16'h0})
          & {17{sdq_enq}};	// Bitwise.scala:72:12, Consts.scala:82:{32,49,66,76}, Mux.scala:47:69, OneHot.scala:58:35, :85:71, mshrs.scala:555:29, :558:46, :602:30, :751:35, :757:{24,26,68,96}, :758:{25,49}, package.scala:15:47
      end
      if (pri_rdy & pri_val)	// mshrs.scala:618:51, :633:35, :634:15, :695:17
        mshr_head <= mshr_head + 3'h1;	// mshrs.scala:621:16, :693:31, util.scala:203:14
      if (idle & io_mem_acquire_ready) begin	// Arbiter.scala:88:28, :89:24
        if (winnerQual_8 & ~(_mmios_0_io_mem_access_bits_opcode[2])) begin	// Arbiter.scala:98:79, :111:73, Edges.scala:91:{28,37}, :220:14, mshrs.scala:710:22
          automatic logic [26:0] _decode_T_33 =
            27'hFFF << _mmios_0_io_mem_access_bits_size;	// mshrs.scala:710:22, package.scala:234:77
          beatsLeft <= ~(_decode_T_33[11:3]);	// Arbiter.scala:87:30, package.scala:234:{46,77,82}
        end
        else	// Arbiter.scala:111:73, Edges.scala:220:14
          beatsLeft <= 9'h0;	// Arbiter.scala:87:30, :112:44
      end
      else	// Arbiter.scala:89:24
        beatsLeft <= beatsLeft - {8'h0, io_mem_acquire_ready & out_9_valid};	// Arbiter.scala:87:30, :113:52, :125:29, Mux.scala:27:72, ReadyValidCancel.scala:50:33
      if (idle) begin	// Arbiter.scala:88:28
        state_0 <= _mshrs_0_io_mem_acquire_valid;	// Arbiter.scala:116:26, mshrs.scala:620:22
        state_1 <= ~_mshrs_0_io_mem_acquire_valid & _mshrs_1_io_mem_acquire_valid;	// Arbiter.scala:16:61, :98:79, :116:26, mshrs.scala:620:22
        state_2 <= ~_GEN_108 & _mshrs_2_io_mem_acquire_valid;	// Arbiter.scala:16:61, :98:79, :116:26, mshrs.scala:620:22, package.scala:244:43
        state_3 <= ~_GEN_110 & _mshrs_3_io_mem_acquire_valid;	// Arbiter.scala:16:61, :98:79, :116:26, mshrs.scala:620:22, package.scala:244:43
        state_4 <= ~_GEN_109 & _mshrs_4_io_mem_acquire_valid;	// Arbiter.scala:16:61, :98:79, :116:26, mshrs.scala:620:22, package.scala:244:43
        state_5 <= ~_GEN_114 & _mshrs_5_io_mem_acquire_valid;	// Arbiter.scala:16:61, :98:79, :116:26, mshrs.scala:620:22, package.scala:244:43
        state_6 <= ~_GEN_113 & _mshrs_6_io_mem_acquire_valid;	// Arbiter.scala:16:61, :98:79, :116:26, mshrs.scala:620:22, package.scala:244:43
        state_7 <= ~_GEN_112 & _mshrs_7_io_mem_acquire_valid;	// Arbiter.scala:16:61, :98:79, :116:26, mshrs.scala:620:22, package.scala:244:43
        state_8 <= winnerQual_8;	// Arbiter.scala:98:79, :116:26
      end
      beatsLeft_1 <=
        ~(~beatsLeft_1 & io_mem_finish_ready) & beatsLeft_1
        - (io_mem_finish_ready & out_18_valid);	// Arbiter.scala:87:30, :88:28, :89:24, :113:{23,52}, :125:29, ReadyValidCancel.scala:50:33
      if (beatsLeft_1) begin	// Arbiter.scala:87:30
      end
      else begin	// Arbiter.scala:87:30
        state_1_0 <= _mshrs_0_io_mem_finish_valid;	// Arbiter.scala:116:26, mshrs.scala:620:22
        state_1_1 <= ~_mshrs_0_io_mem_finish_valid & _mshrs_1_io_mem_finish_valid;	// Arbiter.scala:16:61, :98:79, :116:26, mshrs.scala:620:22
        state_1_2 <= ~_GEN_119 & _mshrs_2_io_mem_finish_valid;	// Arbiter.scala:16:61, :98:79, :116:26, mshrs.scala:620:22, package.scala:244:43
        state_1_3 <= ~_GEN_121 & _mshrs_3_io_mem_finish_valid;	// Arbiter.scala:16:61, :98:79, :116:26, mshrs.scala:620:22, package.scala:244:43
        state_1_4 <= ~_GEN_120 & _mshrs_4_io_mem_finish_valid;	// Arbiter.scala:16:61, :98:79, :116:26, mshrs.scala:620:22, package.scala:244:43
        state_1_5 <= ~_GEN_124 & _mshrs_5_io_mem_finish_valid;	// Arbiter.scala:16:61, :98:79, :116:26, mshrs.scala:620:22, package.scala:244:43
        state_1_6 <= ~_GEN_123 & _mshrs_6_io_mem_finish_valid;	// Arbiter.scala:16:61, :98:79, :116:26, mshrs.scala:620:22, package.scala:244:43
        state_1_7 <= ~_GEN_122 & _mshrs_7_io_mem_finish_valid;	// Arbiter.scala:16:61, :98:79, :116:26, mshrs.scala:620:22, package.scala:244:43
      end
    end
    mshr_alloc_idx_REG <=
      _mshrs_0_io_req_pri_rdy & mshr_head == 3'h0
        ? 3'h0
        : _mshrs_1_io_req_pri_rdy & mshr_head < 3'h2
            ? 3'h1
            : _mshrs_2_io_req_pri_rdy & mshr_head < 3'h3
                ? 3'h2
                : _mshrs_3_io_req_pri_rdy & ~(mshr_head[2])
                    ? 3'h3
                    : _mshrs_4_io_req_pri_rdy & mshr_head < 3'h5
                        ? 3'h4
                        : _mshrs_5_io_req_pri_rdy & mshr_head[2:1] != 2'h3
                            ? 3'h5
                            : _mshrs_6_io_req_pri_rdy & mshr_head != 3'h7
                                ? 3'h6
                                : _mshrs_7_io_req_pri_rdy
                                    ? 3'h7
                                    : _mshrs_0_io_req_pri_rdy
                                        ? 3'h0
                                        : _mshrs_1_io_req_pri_rdy
                                            ? 3'h1
                                            : _mshrs_2_io_req_pri_rdy
                                                ? 3'h2
                                                : _mshrs_3_io_req_pri_rdy
                                                    ? 3'h3
                                                    : _mshrs_4_io_req_pri_rdy
                                                        ? 3'h4
                                                        : _mshrs_5_io_req_pri_rdy
                                                            ? 3'h5
                                                            : {2'h3,
                                                               ~_mshrs_6_io_req_pri_rdy};	// Mux.scala:47:69, ReadyValidCancel.scala:70:19, mshrs.scala:620:22, :621:16, :693:31, :694:31, util.scala:351:{65,72}
    prefetcher_io_mshr_avail_REG <= pri_rdy;	// mshrs.scala:633:35, :634:15, :761:41
    prefetcher_io_req_val_REG <=
      _mshrs_0_io_commit_val | _mshrs_1_io_commit_val | _mshrs_2_io_commit_val
      | _mshrs_3_io_commit_val | _mshrs_4_io_commit_val | _mshrs_5_io_commit_val
      | _mshrs_6_io_commit_val | _mshrs_7_io_commit_val;	// mshrs.scala:620:22, :762:{41,62}
    prefetcher_io_req_addr_REG <=
      (_mshrs_0_io_commit_val ? _mshrs_0_io_commit_addr : 40'h0)
      | (_mshrs_1_io_commit_val ? _mshrs_1_io_commit_addr : 40'h0)
      | (_mshrs_2_io_commit_val ? _mshrs_2_io_commit_addr : 40'h0)
      | (_mshrs_3_io_commit_val ? _mshrs_3_io_commit_addr : 40'h0)
      | (_mshrs_4_io_commit_val ? _mshrs_4_io_commit_addr : 40'h0)
      | (_mshrs_5_io_commit_val ? _mshrs_5_io_commit_addr : 40'h0)
      | (_mshrs_6_io_commit_val ? _mshrs_6_io_commit_addr : 40'h0)
      | (_mshrs_7_io_commit_val ? _mshrs_7_io_commit_addr : 40'h0);	// Mux.scala:27:72, mshrs.scala:620:22, :763:41
    prefetcher_io_req_coh_REG_state <=
      (_mshrs_0_io_commit_val ? _mshrs_0_io_commit_coh_state : 2'h0)
      | (_mshrs_1_io_commit_val ? _mshrs_1_io_commit_coh_state : 2'h0)
      | (_mshrs_2_io_commit_val ? _mshrs_2_io_commit_coh_state : 2'h0)
      | (_mshrs_3_io_commit_val ? _mshrs_3_io_commit_coh_state : 2'h0)
      | (_mshrs_4_io_commit_val ? _mshrs_4_io_commit_coh_state : 2'h0)
      | (_mshrs_5_io_commit_val ? _mshrs_5_io_commit_coh_state : 2'h0)
      | (_mshrs_6_io_commit_val ? _mshrs_6_io_commit_coh_state : 2'h0)
      | (_mshrs_7_io_commit_val ? _mshrs_7_io_commit_coh_state : 2'h0);	// Mux.scala:27:72, mshrs.scala:620:22, :764:41
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:2];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [1:0] i = 2'h0; i < 2'h3; i += 2'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        sdq_val = _RANDOM[2'h0][16:0];	// mshrs.scala:555:29
        mshr_head = _RANDOM[2'h0][19:17];	// mshrs.scala:555:29, :693:31
        mshr_alloc_idx_REG = _RANDOM[2'h0][22:20];	// mshrs.scala:555:29, :694:31
        beatsLeft = _RANDOM[2'h0][31:23];	// Arbiter.scala:87:30, mshrs.scala:555:29
        state_0 = _RANDOM[2'h1][0];	// Arbiter.scala:116:26
        state_1 = _RANDOM[2'h1][1];	// Arbiter.scala:116:26
        state_2 = _RANDOM[2'h1][2];	// Arbiter.scala:116:26
        state_3 = _RANDOM[2'h1][3];	// Arbiter.scala:116:26
        state_4 = _RANDOM[2'h1][4];	// Arbiter.scala:116:26
        state_5 = _RANDOM[2'h1][5];	// Arbiter.scala:116:26
        state_6 = _RANDOM[2'h1][6];	// Arbiter.scala:116:26
        state_7 = _RANDOM[2'h1][7];	// Arbiter.scala:116:26
        state_8 = _RANDOM[2'h1][8];	// Arbiter.scala:116:26
        beatsLeft_1 = _RANDOM[2'h1][9];	// Arbiter.scala:87:30, :116:26
        state_1_0 = _RANDOM[2'h1][10];	// Arbiter.scala:116:26
        state_1_1 = _RANDOM[2'h1][11];	// Arbiter.scala:116:26
        state_1_2 = _RANDOM[2'h1][12];	// Arbiter.scala:116:26
        state_1_3 = _RANDOM[2'h1][13];	// Arbiter.scala:116:26
        state_1_4 = _RANDOM[2'h1][14];	// Arbiter.scala:116:26
        state_1_5 = _RANDOM[2'h1][15];	// Arbiter.scala:116:26
        state_1_6 = _RANDOM[2'h1][16];	// Arbiter.scala:116:26
        state_1_7 = _RANDOM[2'h1][17];	// Arbiter.scala:116:26
        prefetcher_io_mshr_avail_REG = _RANDOM[2'h1][18];	// Arbiter.scala:116:26, mshrs.scala:761:41
        prefetcher_io_req_val_REG = _RANDOM[2'h1][19];	// Arbiter.scala:116:26, mshrs.scala:762:41
        prefetcher_io_req_addr_REG = {_RANDOM[2'h1][31:20], _RANDOM[2'h2][27:0]};	// Arbiter.scala:116:26, mshrs.scala:763:41
        prefetcher_io_req_coh_REG_state = _RANDOM[2'h2][29:28];	// mshrs.scala:763:41, :764:41
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  NLPrefetcher prefetcher (	// mshrs.scala:545:65
    .clock                        (clock),
    .reset                        (reset),
    .io_mshr_avail                (prefetcher_io_mshr_avail_REG),	// mshrs.scala:761:41
    .io_req_val                   (prefetcher_io_req_val_REG),	// mshrs.scala:762:41
    .io_req_addr                  (prefetcher_io_req_addr_REG),	// mshrs.scala:763:41
    .io_req_coh_state             (prefetcher_io_req_coh_REG_state),	// mshrs.scala:764:41
    .io_prefetch_ready            (io_prefetch_ready),
    .io_prefetch_valid            (io_prefetch_valid),
    .io_prefetch_bits_uop_mem_cmd (io_prefetch_bits_uop_mem_cmd),
    .io_prefetch_bits_addr        (io_prefetch_bits_addr)
  );
  sdq_17x64 sdq_ext (	// mshrs.scala:559:25
    .R0_addr (_replay_arb_io_out_bits_sdq_id),	// mshrs.scala:602:30
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (sdq_alloc_id),	// Mux.scala:47:69
    .W0_en   (sdq_enq),	// mshrs.scala:558:46
    .W0_clk  (clock),
    .W0_data (_GEN_79),	// Parameters.scala:137:31
    .R0_data (io_replay_bits_data)
  );
  lb_64x64 lb_ext (	// mshrs.scala:568:15
    .R0_addr ({_lb_read_arb_io_out_bits_id, _lb_read_arb_io_out_bits_offset}),	// Cat.scala:30:58, mshrs.scala:569:28
    .R0_en   (~_lb_write_arb_io_out_valid & _GEN_85),	// Decoupled.scala:40:37, mshrs.scala:568:15, :570:28, :576:37, :580:38
    .R0_clk  (clock),
    .W0_addr ({_lb_write_arb_io_out_bits_id, _lb_write_arb_io_out_bits_offset}),	// Cat.scala:30:58, mshrs.scala:570:28
    .W0_en   (_lb_write_arb_io_out_valid),	// mshrs.scala:570:28
    .W0_clk  (clock),
    .W0_data (_lb_write_arb_io_out_bits_data),	// mshrs.scala:570:28
    .R0_data (_lb_ext_R0_data)
  );
  Arbiter_3 lb_read_arb (	// mshrs.scala:569:28
    .io_in_0_valid       (_mshrs_0_io_lb_read_valid),	// mshrs.scala:620:22
    .io_in_0_bits_id     (_mshrs_0_io_lb_read_bits_id),	// mshrs.scala:620:22
    .io_in_0_bits_offset (_mshrs_0_io_lb_read_bits_offset),	// mshrs.scala:620:22
    .io_in_1_valid       (_mshrs_1_io_lb_read_valid),	// mshrs.scala:620:22
    .io_in_1_bits_id     (_mshrs_1_io_lb_read_bits_id),	// mshrs.scala:620:22
    .io_in_1_bits_offset (_mshrs_1_io_lb_read_bits_offset),	// mshrs.scala:620:22
    .io_in_2_valid       (_mshrs_2_io_lb_read_valid),	// mshrs.scala:620:22
    .io_in_2_bits_id     (_mshrs_2_io_lb_read_bits_id),	// mshrs.scala:620:22
    .io_in_2_bits_offset (_mshrs_2_io_lb_read_bits_offset),	// mshrs.scala:620:22
    .io_in_3_valid       (_mshrs_3_io_lb_read_valid),	// mshrs.scala:620:22
    .io_in_3_bits_id     (_mshrs_3_io_lb_read_bits_id),	// mshrs.scala:620:22
    .io_in_3_bits_offset (_mshrs_3_io_lb_read_bits_offset),	// mshrs.scala:620:22
    .io_in_4_valid       (_mshrs_4_io_lb_read_valid),	// mshrs.scala:620:22
    .io_in_4_bits_id     (_mshrs_4_io_lb_read_bits_id),	// mshrs.scala:620:22
    .io_in_4_bits_offset (_mshrs_4_io_lb_read_bits_offset),	// mshrs.scala:620:22
    .io_in_5_valid       (_mshrs_5_io_lb_read_valid),	// mshrs.scala:620:22
    .io_in_5_bits_id     (_mshrs_5_io_lb_read_bits_id),	// mshrs.scala:620:22
    .io_in_5_bits_offset (_mshrs_5_io_lb_read_bits_offset),	// mshrs.scala:620:22
    .io_in_6_valid       (_mshrs_6_io_lb_read_valid),	// mshrs.scala:620:22
    .io_in_6_bits_id     (_mshrs_6_io_lb_read_bits_id),	// mshrs.scala:620:22
    .io_in_6_bits_offset (_mshrs_6_io_lb_read_bits_offset),	// mshrs.scala:620:22
    .io_in_7_valid       (_mshrs_7_io_lb_read_valid),	// mshrs.scala:620:22
    .io_in_7_bits_id     (_mshrs_7_io_lb_read_bits_id),	// mshrs.scala:620:22
    .io_in_7_bits_offset (_mshrs_7_io_lb_read_bits_offset),	// mshrs.scala:620:22
    .io_out_ready        (~_lb_write_arb_io_out_valid),	// Mux.scala:47:69, mshrs.scala:543:21, :570:28, :572:29, :576:37, :579:30
    .io_in_0_ready       (_lb_read_arb_io_in_0_ready),
    .io_in_1_ready       (_lb_read_arb_io_in_1_ready),
    .io_in_2_ready       (_lb_read_arb_io_in_2_ready),
    .io_in_3_ready       (_lb_read_arb_io_in_3_ready),
    .io_in_4_ready       (_lb_read_arb_io_in_4_ready),
    .io_in_5_ready       (_lb_read_arb_io_in_5_ready),
    .io_in_6_ready       (_lb_read_arb_io_in_6_ready),
    .io_in_7_ready       (_lb_read_arb_io_in_7_ready),
    .io_out_valid        (_lb_read_arb_io_out_valid),
    .io_out_bits_id      (_lb_read_arb_io_out_bits_id),
    .io_out_bits_offset  (_lb_read_arb_io_out_bits_offset)
  );
  Arbiter_4 lb_write_arb (	// mshrs.scala:570:28
    .io_in_0_valid       (_mshrs_0_io_lb_write_valid),	// mshrs.scala:620:22
    .io_in_0_bits_id     (_mshrs_0_io_lb_write_bits_id),	// mshrs.scala:620:22
    .io_in_0_bits_offset (_mshrs_0_io_lb_write_bits_offset),	// mshrs.scala:620:22
    .io_in_0_bits_data   (_mshrs_0_io_lb_write_bits_data),	// mshrs.scala:620:22
    .io_in_1_valid       (_mshrs_1_io_lb_write_valid),	// mshrs.scala:620:22
    .io_in_1_bits_id     (_mshrs_1_io_lb_write_bits_id),	// mshrs.scala:620:22
    .io_in_1_bits_offset (_mshrs_1_io_lb_write_bits_offset),	// mshrs.scala:620:22
    .io_in_1_bits_data   (_mshrs_1_io_lb_write_bits_data),	// mshrs.scala:620:22
    .io_in_2_valid       (_mshrs_2_io_lb_write_valid),	// mshrs.scala:620:22
    .io_in_2_bits_id     (_mshrs_2_io_lb_write_bits_id),	// mshrs.scala:620:22
    .io_in_2_bits_offset (_mshrs_2_io_lb_write_bits_offset),	// mshrs.scala:620:22
    .io_in_2_bits_data   (_mshrs_2_io_lb_write_bits_data),	// mshrs.scala:620:22
    .io_in_3_valid       (_mshrs_3_io_lb_write_valid),	// mshrs.scala:620:22
    .io_in_3_bits_id     (_mshrs_3_io_lb_write_bits_id),	// mshrs.scala:620:22
    .io_in_3_bits_offset (_mshrs_3_io_lb_write_bits_offset),	// mshrs.scala:620:22
    .io_in_3_bits_data   (_mshrs_3_io_lb_write_bits_data),	// mshrs.scala:620:22
    .io_in_4_valid       (_mshrs_4_io_lb_write_valid),	// mshrs.scala:620:22
    .io_in_4_bits_id     (_mshrs_4_io_lb_write_bits_id),	// mshrs.scala:620:22
    .io_in_4_bits_offset (_mshrs_4_io_lb_write_bits_offset),	// mshrs.scala:620:22
    .io_in_4_bits_data   (_mshrs_4_io_lb_write_bits_data),	// mshrs.scala:620:22
    .io_in_5_valid       (_mshrs_5_io_lb_write_valid),	// mshrs.scala:620:22
    .io_in_5_bits_id     (_mshrs_5_io_lb_write_bits_id),	// mshrs.scala:620:22
    .io_in_5_bits_offset (_mshrs_5_io_lb_write_bits_offset),	// mshrs.scala:620:22
    .io_in_5_bits_data   (_mshrs_5_io_lb_write_bits_data),	// mshrs.scala:620:22
    .io_in_6_valid       (_mshrs_6_io_lb_write_valid),	// mshrs.scala:620:22
    .io_in_6_bits_id     (_mshrs_6_io_lb_write_bits_id),	// mshrs.scala:620:22
    .io_in_6_bits_offset (_mshrs_6_io_lb_write_bits_offset),	// mshrs.scala:620:22
    .io_in_6_bits_data   (_mshrs_6_io_lb_write_bits_data),	// mshrs.scala:620:22
    .io_in_7_valid       (_mshrs_7_io_lb_write_valid),	// mshrs.scala:620:22
    .io_in_7_bits_id     (_mshrs_7_io_lb_write_bits_id),	// mshrs.scala:620:22
    .io_in_7_bits_offset (_mshrs_7_io_lb_write_bits_offset),	// mshrs.scala:620:22
    .io_in_7_bits_data   (_mshrs_7_io_lb_write_bits_data),	// mshrs.scala:620:22
    .io_in_1_ready       (_lb_write_arb_io_in_1_ready),
    .io_in_2_ready       (_lb_write_arb_io_in_2_ready),
    .io_in_3_ready       (_lb_write_arb_io_in_3_ready),
    .io_in_4_ready       (_lb_write_arb_io_in_4_ready),
    .io_in_5_ready       (_lb_write_arb_io_in_5_ready),
    .io_in_6_ready       (_lb_write_arb_io_in_6_ready),
    .io_in_7_ready       (_lb_write_arb_io_in_7_ready),
    .io_out_valid        (_lb_write_arb_io_out_valid),
    .io_out_bits_id      (_lb_write_arb_io_out_bits_id),
    .io_out_bits_offset  (_lb_write_arb_io_out_bits_offset),
    .io_out_bits_data    (_lb_write_arb_io_out_bits_data)
  );
  Arbiter_5 meta_write_arb (	// mshrs.scala:599:30
    .io_in_0_valid               (_mshrs_0_io_meta_write_valid),	// mshrs.scala:620:22
    .io_in_0_bits_idx            (_mshrs_0_io_meta_write_bits_idx),	// mshrs.scala:620:22
    .io_in_0_bits_way_en         (_mshrs_0_io_meta_write_bits_way_en),	// mshrs.scala:620:22
    .io_in_0_bits_data_coh_state (_mshrs_0_io_meta_write_bits_data_coh_state),	// mshrs.scala:620:22
    .io_in_0_bits_data_tag       (_mshrs_0_io_meta_write_bits_data_tag),	// mshrs.scala:620:22
    .io_in_1_valid               (_mshrs_1_io_meta_write_valid),	// mshrs.scala:620:22
    .io_in_1_bits_idx            (_mshrs_1_io_meta_write_bits_idx),	// mshrs.scala:620:22
    .io_in_1_bits_way_en         (_mshrs_1_io_meta_write_bits_way_en),	// mshrs.scala:620:22
    .io_in_1_bits_data_coh_state (_mshrs_1_io_meta_write_bits_data_coh_state),	// mshrs.scala:620:22
    .io_in_1_bits_data_tag       (_mshrs_1_io_meta_write_bits_data_tag),	// mshrs.scala:620:22
    .io_in_2_valid               (_mshrs_2_io_meta_write_valid),	// mshrs.scala:620:22
    .io_in_2_bits_idx            (_mshrs_2_io_meta_write_bits_idx),	// mshrs.scala:620:22
    .io_in_2_bits_way_en         (_mshrs_2_io_meta_write_bits_way_en),	// mshrs.scala:620:22
    .io_in_2_bits_data_coh_state (_mshrs_2_io_meta_write_bits_data_coh_state),	// mshrs.scala:620:22
    .io_in_2_bits_data_tag       (_mshrs_2_io_meta_write_bits_data_tag),	// mshrs.scala:620:22
    .io_in_3_valid               (_mshrs_3_io_meta_write_valid),	// mshrs.scala:620:22
    .io_in_3_bits_idx            (_mshrs_3_io_meta_write_bits_idx),	// mshrs.scala:620:22
    .io_in_3_bits_way_en         (_mshrs_3_io_meta_write_bits_way_en),	// mshrs.scala:620:22
    .io_in_3_bits_data_coh_state (_mshrs_3_io_meta_write_bits_data_coh_state),	// mshrs.scala:620:22
    .io_in_3_bits_data_tag       (_mshrs_3_io_meta_write_bits_data_tag),	// mshrs.scala:620:22
    .io_in_4_valid               (_mshrs_4_io_meta_write_valid),	// mshrs.scala:620:22
    .io_in_4_bits_idx            (_mshrs_4_io_meta_write_bits_idx),	// mshrs.scala:620:22
    .io_in_4_bits_way_en         (_mshrs_4_io_meta_write_bits_way_en),	// mshrs.scala:620:22
    .io_in_4_bits_data_coh_state (_mshrs_4_io_meta_write_bits_data_coh_state),	// mshrs.scala:620:22
    .io_in_4_bits_data_tag       (_mshrs_4_io_meta_write_bits_data_tag),	// mshrs.scala:620:22
    .io_in_5_valid               (_mshrs_5_io_meta_write_valid),	// mshrs.scala:620:22
    .io_in_5_bits_idx            (_mshrs_5_io_meta_write_bits_idx),	// mshrs.scala:620:22
    .io_in_5_bits_way_en         (_mshrs_5_io_meta_write_bits_way_en),	// mshrs.scala:620:22
    .io_in_5_bits_data_coh_state (_mshrs_5_io_meta_write_bits_data_coh_state),	// mshrs.scala:620:22
    .io_in_5_bits_data_tag       (_mshrs_5_io_meta_write_bits_data_tag),	// mshrs.scala:620:22
    .io_in_6_valid               (_mshrs_6_io_meta_write_valid),	// mshrs.scala:620:22
    .io_in_6_bits_idx            (_mshrs_6_io_meta_write_bits_idx),	// mshrs.scala:620:22
    .io_in_6_bits_way_en         (_mshrs_6_io_meta_write_bits_way_en),	// mshrs.scala:620:22
    .io_in_6_bits_data_coh_state (_mshrs_6_io_meta_write_bits_data_coh_state),	// mshrs.scala:620:22
    .io_in_6_bits_data_tag       (_mshrs_6_io_meta_write_bits_data_tag),	// mshrs.scala:620:22
    .io_in_7_valid               (_mshrs_7_io_meta_write_valid),	// mshrs.scala:620:22
    .io_in_7_bits_idx            (_mshrs_7_io_meta_write_bits_idx),	// mshrs.scala:620:22
    .io_in_7_bits_way_en         (_mshrs_7_io_meta_write_bits_way_en),	// mshrs.scala:620:22
    .io_in_7_bits_data_coh_state (_mshrs_7_io_meta_write_bits_data_coh_state),	// mshrs.scala:620:22
    .io_in_7_bits_data_tag       (_mshrs_7_io_meta_write_bits_data_tag),	// mshrs.scala:620:22
    .io_out_ready                (io_meta_write_ready),
    .io_in_0_ready               (_meta_write_arb_io_in_0_ready),
    .io_in_1_ready               (_meta_write_arb_io_in_1_ready),
    .io_in_2_ready               (_meta_write_arb_io_in_2_ready),
    .io_in_3_ready               (_meta_write_arb_io_in_3_ready),
    .io_in_4_ready               (_meta_write_arb_io_in_4_ready),
    .io_in_5_ready               (_meta_write_arb_io_in_5_ready),
    .io_in_6_ready               (_meta_write_arb_io_in_6_ready),
    .io_in_7_ready               (_meta_write_arb_io_in_7_ready),
    .io_out_valid                (io_meta_write_valid),
    .io_out_bits_idx             (io_meta_write_bits_idx),
    .io_out_bits_way_en          (io_meta_write_bits_way_en),
    .io_out_bits_data_coh_state  (io_meta_write_bits_data_coh_state),
    .io_out_bits_data_tag        (io_meta_write_bits_data_tag)
  );
  Arbiter_6 meta_read_arb (	// mshrs.scala:600:30
    .io_in_0_valid       (_mshrs_0_io_meta_read_valid),	// mshrs.scala:620:22
    .io_in_0_bits_idx    (_mshrs_0_io_meta_read_bits_idx),	// mshrs.scala:620:22
    .io_in_0_bits_way_en (_mshrs_0_io_meta_read_bits_way_en),	// mshrs.scala:620:22
    .io_in_0_bits_tag    (_mshrs_0_io_meta_read_bits_tag),	// mshrs.scala:620:22
    .io_in_1_valid       (_mshrs_1_io_meta_read_valid),	// mshrs.scala:620:22
    .io_in_1_bits_idx    (_mshrs_1_io_meta_read_bits_idx),	// mshrs.scala:620:22
    .io_in_1_bits_way_en (_mshrs_1_io_meta_read_bits_way_en),	// mshrs.scala:620:22
    .io_in_1_bits_tag    (_mshrs_1_io_meta_read_bits_tag),	// mshrs.scala:620:22
    .io_in_2_valid       (_mshrs_2_io_meta_read_valid),	// mshrs.scala:620:22
    .io_in_2_bits_idx    (_mshrs_2_io_meta_read_bits_idx),	// mshrs.scala:620:22
    .io_in_2_bits_way_en (_mshrs_2_io_meta_read_bits_way_en),	// mshrs.scala:620:22
    .io_in_2_bits_tag    (_mshrs_2_io_meta_read_bits_tag),	// mshrs.scala:620:22
    .io_in_3_valid       (_mshrs_3_io_meta_read_valid),	// mshrs.scala:620:22
    .io_in_3_bits_idx    (_mshrs_3_io_meta_read_bits_idx),	// mshrs.scala:620:22
    .io_in_3_bits_way_en (_mshrs_3_io_meta_read_bits_way_en),	// mshrs.scala:620:22
    .io_in_3_bits_tag    (_mshrs_3_io_meta_read_bits_tag),	// mshrs.scala:620:22
    .io_in_4_valid       (_mshrs_4_io_meta_read_valid),	// mshrs.scala:620:22
    .io_in_4_bits_idx    (_mshrs_4_io_meta_read_bits_idx),	// mshrs.scala:620:22
    .io_in_4_bits_way_en (_mshrs_4_io_meta_read_bits_way_en),	// mshrs.scala:620:22
    .io_in_4_bits_tag    (_mshrs_4_io_meta_read_bits_tag),	// mshrs.scala:620:22
    .io_in_5_valid       (_mshrs_5_io_meta_read_valid),	// mshrs.scala:620:22
    .io_in_5_bits_idx    (_mshrs_5_io_meta_read_bits_idx),	// mshrs.scala:620:22
    .io_in_5_bits_way_en (_mshrs_5_io_meta_read_bits_way_en),	// mshrs.scala:620:22
    .io_in_5_bits_tag    (_mshrs_5_io_meta_read_bits_tag),	// mshrs.scala:620:22
    .io_in_6_valid       (_mshrs_6_io_meta_read_valid),	// mshrs.scala:620:22
    .io_in_6_bits_idx    (_mshrs_6_io_meta_read_bits_idx),	// mshrs.scala:620:22
    .io_in_6_bits_way_en (_mshrs_6_io_meta_read_bits_way_en),	// mshrs.scala:620:22
    .io_in_6_bits_tag    (_mshrs_6_io_meta_read_bits_tag),	// mshrs.scala:620:22
    .io_in_7_valid       (_mshrs_7_io_meta_read_valid),	// mshrs.scala:620:22
    .io_in_7_bits_idx    (_mshrs_7_io_meta_read_bits_idx),	// mshrs.scala:620:22
    .io_in_7_bits_way_en (_mshrs_7_io_meta_read_bits_way_en),	// mshrs.scala:620:22
    .io_in_7_bits_tag    (_mshrs_7_io_meta_read_bits_tag),	// mshrs.scala:620:22
    .io_out_ready        (io_meta_read_ready),
    .io_in_0_ready       (_meta_read_arb_io_in_0_ready),
    .io_in_1_ready       (_meta_read_arb_io_in_1_ready),
    .io_in_2_ready       (_meta_read_arb_io_in_2_ready),
    .io_in_3_ready       (_meta_read_arb_io_in_3_ready),
    .io_in_4_ready       (_meta_read_arb_io_in_4_ready),
    .io_in_5_ready       (_meta_read_arb_io_in_5_ready),
    .io_in_6_ready       (_meta_read_arb_io_in_6_ready),
    .io_in_7_ready       (_meta_read_arb_io_in_7_ready),
    .io_out_valid        (io_meta_read_valid),
    .io_out_bits_idx     (io_meta_read_bits_idx),
    .io_out_bits_way_en  (io_meta_read_bits_way_en),
    .io_out_bits_tag     (io_meta_read_bits_tag)
  );
  Arbiter_7 wb_req_arb (	// mshrs.scala:601:30
    .io_in_0_valid       (_mshrs_0_io_wb_req_valid),	// mshrs.scala:620:22
    .io_in_0_bits_tag    (_mshrs_0_io_wb_req_bits_tag),	// mshrs.scala:620:22
    .io_in_0_bits_idx    (_mshrs_0_io_wb_req_bits_idx),	// mshrs.scala:620:22
    .io_in_0_bits_param  (_mshrs_0_io_wb_req_bits_param),	// mshrs.scala:620:22
    .io_in_0_bits_way_en (_mshrs_0_io_wb_req_bits_way_en),	// mshrs.scala:620:22
    .io_in_1_valid       (_mshrs_1_io_wb_req_valid),	// mshrs.scala:620:22
    .io_in_1_bits_tag    (_mshrs_1_io_wb_req_bits_tag),	// mshrs.scala:620:22
    .io_in_1_bits_idx    (_mshrs_1_io_wb_req_bits_idx),	// mshrs.scala:620:22
    .io_in_1_bits_param  (_mshrs_1_io_wb_req_bits_param),	// mshrs.scala:620:22
    .io_in_1_bits_way_en (_mshrs_1_io_wb_req_bits_way_en),	// mshrs.scala:620:22
    .io_in_2_valid       (_mshrs_2_io_wb_req_valid),	// mshrs.scala:620:22
    .io_in_2_bits_tag    (_mshrs_2_io_wb_req_bits_tag),	// mshrs.scala:620:22
    .io_in_2_bits_idx    (_mshrs_2_io_wb_req_bits_idx),	// mshrs.scala:620:22
    .io_in_2_bits_param  (_mshrs_2_io_wb_req_bits_param),	// mshrs.scala:620:22
    .io_in_2_bits_way_en (_mshrs_2_io_wb_req_bits_way_en),	// mshrs.scala:620:22
    .io_in_3_valid       (_mshrs_3_io_wb_req_valid),	// mshrs.scala:620:22
    .io_in_3_bits_tag    (_mshrs_3_io_wb_req_bits_tag),	// mshrs.scala:620:22
    .io_in_3_bits_idx    (_mshrs_3_io_wb_req_bits_idx),	// mshrs.scala:620:22
    .io_in_3_bits_param  (_mshrs_3_io_wb_req_bits_param),	// mshrs.scala:620:22
    .io_in_3_bits_way_en (_mshrs_3_io_wb_req_bits_way_en),	// mshrs.scala:620:22
    .io_in_4_valid       (_mshrs_4_io_wb_req_valid),	// mshrs.scala:620:22
    .io_in_4_bits_tag    (_mshrs_4_io_wb_req_bits_tag),	// mshrs.scala:620:22
    .io_in_4_bits_idx    (_mshrs_4_io_wb_req_bits_idx),	// mshrs.scala:620:22
    .io_in_4_bits_param  (_mshrs_4_io_wb_req_bits_param),	// mshrs.scala:620:22
    .io_in_4_bits_way_en (_mshrs_4_io_wb_req_bits_way_en),	// mshrs.scala:620:22
    .io_in_5_valid       (_mshrs_5_io_wb_req_valid),	// mshrs.scala:620:22
    .io_in_5_bits_tag    (_mshrs_5_io_wb_req_bits_tag),	// mshrs.scala:620:22
    .io_in_5_bits_idx    (_mshrs_5_io_wb_req_bits_idx),	// mshrs.scala:620:22
    .io_in_5_bits_param  (_mshrs_5_io_wb_req_bits_param),	// mshrs.scala:620:22
    .io_in_5_bits_way_en (_mshrs_5_io_wb_req_bits_way_en),	// mshrs.scala:620:22
    .io_in_6_valid       (_mshrs_6_io_wb_req_valid),	// mshrs.scala:620:22
    .io_in_6_bits_tag    (_mshrs_6_io_wb_req_bits_tag),	// mshrs.scala:620:22
    .io_in_6_bits_idx    (_mshrs_6_io_wb_req_bits_idx),	// mshrs.scala:620:22
    .io_in_6_bits_param  (_mshrs_6_io_wb_req_bits_param),	// mshrs.scala:620:22
    .io_in_6_bits_way_en (_mshrs_6_io_wb_req_bits_way_en),	// mshrs.scala:620:22
    .io_in_7_valid       (_mshrs_7_io_wb_req_valid),	// mshrs.scala:620:22
    .io_in_7_bits_tag    (_mshrs_7_io_wb_req_bits_tag),	// mshrs.scala:620:22
    .io_in_7_bits_idx    (_mshrs_7_io_wb_req_bits_idx),	// mshrs.scala:620:22
    .io_in_7_bits_param  (_mshrs_7_io_wb_req_bits_param),	// mshrs.scala:620:22
    .io_in_7_bits_way_en (_mshrs_7_io_wb_req_bits_way_en),	// mshrs.scala:620:22
    .io_out_ready        (io_wb_req_ready),
    .io_in_0_ready       (_wb_req_arb_io_in_0_ready),
    .io_in_1_ready       (_wb_req_arb_io_in_1_ready),
    .io_in_2_ready       (_wb_req_arb_io_in_2_ready),
    .io_in_3_ready       (_wb_req_arb_io_in_3_ready),
    .io_in_4_ready       (_wb_req_arb_io_in_4_ready),
    .io_in_5_ready       (_wb_req_arb_io_in_5_ready),
    .io_in_6_ready       (_wb_req_arb_io_in_6_ready),
    .io_in_7_ready       (_wb_req_arb_io_in_7_ready),
    .io_out_valid        (io_wb_req_valid),
    .io_out_bits_tag     (io_wb_req_bits_tag),
    .io_out_bits_idx     (io_wb_req_bits_idx),
    .io_out_bits_param   (io_wb_req_bits_param),
    .io_out_bits_way_en  (io_wb_req_bits_way_en)
  );
  Arbiter_8 replay_arb (	// mshrs.scala:602:30
    .io_in_0_valid                    (_mshrs_0_io_replay_valid),	// mshrs.scala:620:22
    .io_in_0_bits_uop_uopc            (_mshrs_0_io_replay_bits_uop_uopc),	// mshrs.scala:620:22
    .io_in_0_bits_uop_inst            (_mshrs_0_io_replay_bits_uop_inst),	// mshrs.scala:620:22
    .io_in_0_bits_uop_debug_inst      (_mshrs_0_io_replay_bits_uop_debug_inst),	// mshrs.scala:620:22
    .io_in_0_bits_uop_is_rvc          (_mshrs_0_io_replay_bits_uop_is_rvc),	// mshrs.scala:620:22
    .io_in_0_bits_uop_debug_pc        (_mshrs_0_io_replay_bits_uop_debug_pc),	// mshrs.scala:620:22
    .io_in_0_bits_uop_iq_type         (_mshrs_0_io_replay_bits_uop_iq_type),	// mshrs.scala:620:22
    .io_in_0_bits_uop_fu_code         (_mshrs_0_io_replay_bits_uop_fu_code),	// mshrs.scala:620:22
    .io_in_0_bits_uop_ctrl_br_type    (_mshrs_0_io_replay_bits_uop_ctrl_br_type),	// mshrs.scala:620:22
    .io_in_0_bits_uop_ctrl_op1_sel    (_mshrs_0_io_replay_bits_uop_ctrl_op1_sel),	// mshrs.scala:620:22
    .io_in_0_bits_uop_ctrl_op2_sel    (_mshrs_0_io_replay_bits_uop_ctrl_op2_sel),	// mshrs.scala:620:22
    .io_in_0_bits_uop_ctrl_imm_sel    (_mshrs_0_io_replay_bits_uop_ctrl_imm_sel),	// mshrs.scala:620:22
    .io_in_0_bits_uop_ctrl_op_fcn     (_mshrs_0_io_replay_bits_uop_ctrl_op_fcn),	// mshrs.scala:620:22
    .io_in_0_bits_uop_ctrl_fcn_dw     (_mshrs_0_io_replay_bits_uop_ctrl_fcn_dw),	// mshrs.scala:620:22
    .io_in_0_bits_uop_ctrl_csr_cmd    (_mshrs_0_io_replay_bits_uop_ctrl_csr_cmd),	// mshrs.scala:620:22
    .io_in_0_bits_uop_ctrl_is_load    (_mshrs_0_io_replay_bits_uop_ctrl_is_load),	// mshrs.scala:620:22
    .io_in_0_bits_uop_ctrl_is_sta     (_mshrs_0_io_replay_bits_uop_ctrl_is_sta),	// mshrs.scala:620:22
    .io_in_0_bits_uop_ctrl_is_std     (_mshrs_0_io_replay_bits_uop_ctrl_is_std),	// mshrs.scala:620:22
    .io_in_0_bits_uop_iw_state        (_mshrs_0_io_replay_bits_uop_iw_state),	// mshrs.scala:620:22
    .io_in_0_bits_uop_iw_p1_poisoned  (_mshrs_0_io_replay_bits_uop_iw_p1_poisoned),	// mshrs.scala:620:22
    .io_in_0_bits_uop_iw_p2_poisoned  (_mshrs_0_io_replay_bits_uop_iw_p2_poisoned),	// mshrs.scala:620:22
    .io_in_0_bits_uop_is_br           (_mshrs_0_io_replay_bits_uop_is_br),	// mshrs.scala:620:22
    .io_in_0_bits_uop_is_jalr         (_mshrs_0_io_replay_bits_uop_is_jalr),	// mshrs.scala:620:22
    .io_in_0_bits_uop_is_jal          (_mshrs_0_io_replay_bits_uop_is_jal),	// mshrs.scala:620:22
    .io_in_0_bits_uop_is_sfb          (_mshrs_0_io_replay_bits_uop_is_sfb),	// mshrs.scala:620:22
    .io_in_0_bits_uop_br_mask         (_mshrs_0_io_replay_bits_uop_br_mask),	// mshrs.scala:620:22
    .io_in_0_bits_uop_br_tag          (_mshrs_0_io_replay_bits_uop_br_tag),	// mshrs.scala:620:22
    .io_in_0_bits_uop_ftq_idx         (_mshrs_0_io_replay_bits_uop_ftq_idx),	// mshrs.scala:620:22
    .io_in_0_bits_uop_edge_inst       (_mshrs_0_io_replay_bits_uop_edge_inst),	// mshrs.scala:620:22
    .io_in_0_bits_uop_pc_lob          (_mshrs_0_io_replay_bits_uop_pc_lob),	// mshrs.scala:620:22
    .io_in_0_bits_uop_taken           (_mshrs_0_io_replay_bits_uop_taken),	// mshrs.scala:620:22
    .io_in_0_bits_uop_imm_packed      (_mshrs_0_io_replay_bits_uop_imm_packed),	// mshrs.scala:620:22
    .io_in_0_bits_uop_csr_addr        (_mshrs_0_io_replay_bits_uop_csr_addr),	// mshrs.scala:620:22
    .io_in_0_bits_uop_rob_idx         (_mshrs_0_io_replay_bits_uop_rob_idx),	// mshrs.scala:620:22
    .io_in_0_bits_uop_ldq_idx         (_mshrs_0_io_replay_bits_uop_ldq_idx),	// mshrs.scala:620:22
    .io_in_0_bits_uop_stq_idx         (_mshrs_0_io_replay_bits_uop_stq_idx),	// mshrs.scala:620:22
    .io_in_0_bits_uop_rxq_idx         (_mshrs_0_io_replay_bits_uop_rxq_idx),	// mshrs.scala:620:22
    .io_in_0_bits_uop_pdst            (_mshrs_0_io_replay_bits_uop_pdst),	// mshrs.scala:620:22
    .io_in_0_bits_uop_prs1            (_mshrs_0_io_replay_bits_uop_prs1),	// mshrs.scala:620:22
    .io_in_0_bits_uop_prs2            (_mshrs_0_io_replay_bits_uop_prs2),	// mshrs.scala:620:22
    .io_in_0_bits_uop_prs3            (_mshrs_0_io_replay_bits_uop_prs3),	// mshrs.scala:620:22
    .io_in_0_bits_uop_ppred           (_mshrs_0_io_replay_bits_uop_ppred),	// mshrs.scala:620:22
    .io_in_0_bits_uop_prs1_busy       (_mshrs_0_io_replay_bits_uop_prs1_busy),	// mshrs.scala:620:22
    .io_in_0_bits_uop_prs2_busy       (_mshrs_0_io_replay_bits_uop_prs2_busy),	// mshrs.scala:620:22
    .io_in_0_bits_uop_prs3_busy       (_mshrs_0_io_replay_bits_uop_prs3_busy),	// mshrs.scala:620:22
    .io_in_0_bits_uop_ppred_busy      (_mshrs_0_io_replay_bits_uop_ppred_busy),	// mshrs.scala:620:22
    .io_in_0_bits_uop_stale_pdst      (_mshrs_0_io_replay_bits_uop_stale_pdst),	// mshrs.scala:620:22
    .io_in_0_bits_uop_exception       (_mshrs_0_io_replay_bits_uop_exception),	// mshrs.scala:620:22
    .io_in_0_bits_uop_exc_cause       (_mshrs_0_io_replay_bits_uop_exc_cause),	// mshrs.scala:620:22
    .io_in_0_bits_uop_bypassable      (_mshrs_0_io_replay_bits_uop_bypassable),	// mshrs.scala:620:22
    .io_in_0_bits_uop_mem_cmd         (_mshrs_0_io_replay_bits_uop_mem_cmd),	// mshrs.scala:620:22
    .io_in_0_bits_uop_mem_size        (_mshrs_0_io_replay_bits_uop_mem_size),	// mshrs.scala:620:22
    .io_in_0_bits_uop_mem_signed      (_mshrs_0_io_replay_bits_uop_mem_signed),	// mshrs.scala:620:22
    .io_in_0_bits_uop_is_fence        (_mshrs_0_io_replay_bits_uop_is_fence),	// mshrs.scala:620:22
    .io_in_0_bits_uop_is_fencei       (_mshrs_0_io_replay_bits_uop_is_fencei),	// mshrs.scala:620:22
    .io_in_0_bits_uop_is_amo          (_mshrs_0_io_replay_bits_uop_is_amo),	// mshrs.scala:620:22
    .io_in_0_bits_uop_uses_ldq        (_mshrs_0_io_replay_bits_uop_uses_ldq),	// mshrs.scala:620:22
    .io_in_0_bits_uop_uses_stq        (_mshrs_0_io_replay_bits_uop_uses_stq),	// mshrs.scala:620:22
    .io_in_0_bits_uop_is_sys_pc2epc   (_mshrs_0_io_replay_bits_uop_is_sys_pc2epc),	// mshrs.scala:620:22
    .io_in_0_bits_uop_is_unique       (_mshrs_0_io_replay_bits_uop_is_unique),	// mshrs.scala:620:22
    .io_in_0_bits_uop_flush_on_commit (_mshrs_0_io_replay_bits_uop_flush_on_commit),	// mshrs.scala:620:22
    .io_in_0_bits_uop_ldst_is_rs1     (_mshrs_0_io_replay_bits_uop_ldst_is_rs1),	// mshrs.scala:620:22
    .io_in_0_bits_uop_ldst            (_mshrs_0_io_replay_bits_uop_ldst),	// mshrs.scala:620:22
    .io_in_0_bits_uop_lrs1            (_mshrs_0_io_replay_bits_uop_lrs1),	// mshrs.scala:620:22
    .io_in_0_bits_uop_lrs2            (_mshrs_0_io_replay_bits_uop_lrs2),	// mshrs.scala:620:22
    .io_in_0_bits_uop_lrs3            (_mshrs_0_io_replay_bits_uop_lrs3),	// mshrs.scala:620:22
    .io_in_0_bits_uop_ldst_val        (_mshrs_0_io_replay_bits_uop_ldst_val),	// mshrs.scala:620:22
    .io_in_0_bits_uop_dst_rtype       (_mshrs_0_io_replay_bits_uop_dst_rtype),	// mshrs.scala:620:22
    .io_in_0_bits_uop_lrs1_rtype      (_mshrs_0_io_replay_bits_uop_lrs1_rtype),	// mshrs.scala:620:22
    .io_in_0_bits_uop_lrs2_rtype      (_mshrs_0_io_replay_bits_uop_lrs2_rtype),	// mshrs.scala:620:22
    .io_in_0_bits_uop_frs3_en         (_mshrs_0_io_replay_bits_uop_frs3_en),	// mshrs.scala:620:22
    .io_in_0_bits_uop_fp_val          (_mshrs_0_io_replay_bits_uop_fp_val),	// mshrs.scala:620:22
    .io_in_0_bits_uop_fp_single       (_mshrs_0_io_replay_bits_uop_fp_single),	// mshrs.scala:620:22
    .io_in_0_bits_uop_xcpt_pf_if      (_mshrs_0_io_replay_bits_uop_xcpt_pf_if),	// mshrs.scala:620:22
    .io_in_0_bits_uop_xcpt_ae_if      (_mshrs_0_io_replay_bits_uop_xcpt_ae_if),	// mshrs.scala:620:22
    .io_in_0_bits_uop_xcpt_ma_if      (_mshrs_0_io_replay_bits_uop_xcpt_ma_if),	// mshrs.scala:620:22
    .io_in_0_bits_uop_bp_debug_if     (_mshrs_0_io_replay_bits_uop_bp_debug_if),	// mshrs.scala:620:22
    .io_in_0_bits_uop_bp_xcpt_if      (_mshrs_0_io_replay_bits_uop_bp_xcpt_if),	// mshrs.scala:620:22
    .io_in_0_bits_uop_debug_fsrc      (_mshrs_0_io_replay_bits_uop_debug_fsrc),	// mshrs.scala:620:22
    .io_in_0_bits_uop_debug_tsrc      (_mshrs_0_io_replay_bits_uop_debug_tsrc),	// mshrs.scala:620:22
    .io_in_0_bits_addr                (_mshrs_0_io_replay_bits_addr),	// mshrs.scala:620:22
    .io_in_0_bits_is_hella            (_mshrs_0_io_replay_bits_is_hella),	// mshrs.scala:620:22
    .io_in_0_bits_way_en              (_mshrs_0_io_replay_bits_way_en),	// mshrs.scala:620:22
    .io_in_0_bits_sdq_id              (_mshrs_0_io_replay_bits_sdq_id),	// mshrs.scala:620:22
    .io_in_1_valid                    (_mshrs_1_io_replay_valid),	// mshrs.scala:620:22
    .io_in_1_bits_uop_uopc            (_mshrs_1_io_replay_bits_uop_uopc),	// mshrs.scala:620:22
    .io_in_1_bits_uop_inst            (_mshrs_1_io_replay_bits_uop_inst),	// mshrs.scala:620:22
    .io_in_1_bits_uop_debug_inst      (_mshrs_1_io_replay_bits_uop_debug_inst),	// mshrs.scala:620:22
    .io_in_1_bits_uop_is_rvc          (_mshrs_1_io_replay_bits_uop_is_rvc),	// mshrs.scala:620:22
    .io_in_1_bits_uop_debug_pc        (_mshrs_1_io_replay_bits_uop_debug_pc),	// mshrs.scala:620:22
    .io_in_1_bits_uop_iq_type         (_mshrs_1_io_replay_bits_uop_iq_type),	// mshrs.scala:620:22
    .io_in_1_bits_uop_fu_code         (_mshrs_1_io_replay_bits_uop_fu_code),	// mshrs.scala:620:22
    .io_in_1_bits_uop_ctrl_br_type    (_mshrs_1_io_replay_bits_uop_ctrl_br_type),	// mshrs.scala:620:22
    .io_in_1_bits_uop_ctrl_op1_sel    (_mshrs_1_io_replay_bits_uop_ctrl_op1_sel),	// mshrs.scala:620:22
    .io_in_1_bits_uop_ctrl_op2_sel    (_mshrs_1_io_replay_bits_uop_ctrl_op2_sel),	// mshrs.scala:620:22
    .io_in_1_bits_uop_ctrl_imm_sel    (_mshrs_1_io_replay_bits_uop_ctrl_imm_sel),	// mshrs.scala:620:22
    .io_in_1_bits_uop_ctrl_op_fcn     (_mshrs_1_io_replay_bits_uop_ctrl_op_fcn),	// mshrs.scala:620:22
    .io_in_1_bits_uop_ctrl_fcn_dw     (_mshrs_1_io_replay_bits_uop_ctrl_fcn_dw),	// mshrs.scala:620:22
    .io_in_1_bits_uop_ctrl_csr_cmd    (_mshrs_1_io_replay_bits_uop_ctrl_csr_cmd),	// mshrs.scala:620:22
    .io_in_1_bits_uop_ctrl_is_load    (_mshrs_1_io_replay_bits_uop_ctrl_is_load),	// mshrs.scala:620:22
    .io_in_1_bits_uop_ctrl_is_sta     (_mshrs_1_io_replay_bits_uop_ctrl_is_sta),	// mshrs.scala:620:22
    .io_in_1_bits_uop_ctrl_is_std     (_mshrs_1_io_replay_bits_uop_ctrl_is_std),	// mshrs.scala:620:22
    .io_in_1_bits_uop_iw_state        (_mshrs_1_io_replay_bits_uop_iw_state),	// mshrs.scala:620:22
    .io_in_1_bits_uop_iw_p1_poisoned  (_mshrs_1_io_replay_bits_uop_iw_p1_poisoned),	// mshrs.scala:620:22
    .io_in_1_bits_uop_iw_p2_poisoned  (_mshrs_1_io_replay_bits_uop_iw_p2_poisoned),	// mshrs.scala:620:22
    .io_in_1_bits_uop_is_br           (_mshrs_1_io_replay_bits_uop_is_br),	// mshrs.scala:620:22
    .io_in_1_bits_uop_is_jalr         (_mshrs_1_io_replay_bits_uop_is_jalr),	// mshrs.scala:620:22
    .io_in_1_bits_uop_is_jal          (_mshrs_1_io_replay_bits_uop_is_jal),	// mshrs.scala:620:22
    .io_in_1_bits_uop_is_sfb          (_mshrs_1_io_replay_bits_uop_is_sfb),	// mshrs.scala:620:22
    .io_in_1_bits_uop_br_mask         (_mshrs_1_io_replay_bits_uop_br_mask),	// mshrs.scala:620:22
    .io_in_1_bits_uop_br_tag          (_mshrs_1_io_replay_bits_uop_br_tag),	// mshrs.scala:620:22
    .io_in_1_bits_uop_ftq_idx         (_mshrs_1_io_replay_bits_uop_ftq_idx),	// mshrs.scala:620:22
    .io_in_1_bits_uop_edge_inst       (_mshrs_1_io_replay_bits_uop_edge_inst),	// mshrs.scala:620:22
    .io_in_1_bits_uop_pc_lob          (_mshrs_1_io_replay_bits_uop_pc_lob),	// mshrs.scala:620:22
    .io_in_1_bits_uop_taken           (_mshrs_1_io_replay_bits_uop_taken),	// mshrs.scala:620:22
    .io_in_1_bits_uop_imm_packed      (_mshrs_1_io_replay_bits_uop_imm_packed),	// mshrs.scala:620:22
    .io_in_1_bits_uop_csr_addr        (_mshrs_1_io_replay_bits_uop_csr_addr),	// mshrs.scala:620:22
    .io_in_1_bits_uop_rob_idx         (_mshrs_1_io_replay_bits_uop_rob_idx),	// mshrs.scala:620:22
    .io_in_1_bits_uop_ldq_idx         (_mshrs_1_io_replay_bits_uop_ldq_idx),	// mshrs.scala:620:22
    .io_in_1_bits_uop_stq_idx         (_mshrs_1_io_replay_bits_uop_stq_idx),	// mshrs.scala:620:22
    .io_in_1_bits_uop_rxq_idx         (_mshrs_1_io_replay_bits_uop_rxq_idx),	// mshrs.scala:620:22
    .io_in_1_bits_uop_pdst            (_mshrs_1_io_replay_bits_uop_pdst),	// mshrs.scala:620:22
    .io_in_1_bits_uop_prs1            (_mshrs_1_io_replay_bits_uop_prs1),	// mshrs.scala:620:22
    .io_in_1_bits_uop_prs2            (_mshrs_1_io_replay_bits_uop_prs2),	// mshrs.scala:620:22
    .io_in_1_bits_uop_prs3            (_mshrs_1_io_replay_bits_uop_prs3),	// mshrs.scala:620:22
    .io_in_1_bits_uop_ppred           (_mshrs_1_io_replay_bits_uop_ppred),	// mshrs.scala:620:22
    .io_in_1_bits_uop_prs1_busy       (_mshrs_1_io_replay_bits_uop_prs1_busy),	// mshrs.scala:620:22
    .io_in_1_bits_uop_prs2_busy       (_mshrs_1_io_replay_bits_uop_prs2_busy),	// mshrs.scala:620:22
    .io_in_1_bits_uop_prs3_busy       (_mshrs_1_io_replay_bits_uop_prs3_busy),	// mshrs.scala:620:22
    .io_in_1_bits_uop_ppred_busy      (_mshrs_1_io_replay_bits_uop_ppred_busy),	// mshrs.scala:620:22
    .io_in_1_bits_uop_stale_pdst      (_mshrs_1_io_replay_bits_uop_stale_pdst),	// mshrs.scala:620:22
    .io_in_1_bits_uop_exception       (_mshrs_1_io_replay_bits_uop_exception),	// mshrs.scala:620:22
    .io_in_1_bits_uop_exc_cause       (_mshrs_1_io_replay_bits_uop_exc_cause),	// mshrs.scala:620:22
    .io_in_1_bits_uop_bypassable      (_mshrs_1_io_replay_bits_uop_bypassable),	// mshrs.scala:620:22
    .io_in_1_bits_uop_mem_cmd         (_mshrs_1_io_replay_bits_uop_mem_cmd),	// mshrs.scala:620:22
    .io_in_1_bits_uop_mem_size        (_mshrs_1_io_replay_bits_uop_mem_size),	// mshrs.scala:620:22
    .io_in_1_bits_uop_mem_signed      (_mshrs_1_io_replay_bits_uop_mem_signed),	// mshrs.scala:620:22
    .io_in_1_bits_uop_is_fence        (_mshrs_1_io_replay_bits_uop_is_fence),	// mshrs.scala:620:22
    .io_in_1_bits_uop_is_fencei       (_mshrs_1_io_replay_bits_uop_is_fencei),	// mshrs.scala:620:22
    .io_in_1_bits_uop_is_amo          (_mshrs_1_io_replay_bits_uop_is_amo),	// mshrs.scala:620:22
    .io_in_1_bits_uop_uses_ldq        (_mshrs_1_io_replay_bits_uop_uses_ldq),	// mshrs.scala:620:22
    .io_in_1_bits_uop_uses_stq        (_mshrs_1_io_replay_bits_uop_uses_stq),	// mshrs.scala:620:22
    .io_in_1_bits_uop_is_sys_pc2epc   (_mshrs_1_io_replay_bits_uop_is_sys_pc2epc),	// mshrs.scala:620:22
    .io_in_1_bits_uop_is_unique       (_mshrs_1_io_replay_bits_uop_is_unique),	// mshrs.scala:620:22
    .io_in_1_bits_uop_flush_on_commit (_mshrs_1_io_replay_bits_uop_flush_on_commit),	// mshrs.scala:620:22
    .io_in_1_bits_uop_ldst_is_rs1     (_mshrs_1_io_replay_bits_uop_ldst_is_rs1),	// mshrs.scala:620:22
    .io_in_1_bits_uop_ldst            (_mshrs_1_io_replay_bits_uop_ldst),	// mshrs.scala:620:22
    .io_in_1_bits_uop_lrs1            (_mshrs_1_io_replay_bits_uop_lrs1),	// mshrs.scala:620:22
    .io_in_1_bits_uop_lrs2            (_mshrs_1_io_replay_bits_uop_lrs2),	// mshrs.scala:620:22
    .io_in_1_bits_uop_lrs3            (_mshrs_1_io_replay_bits_uop_lrs3),	// mshrs.scala:620:22
    .io_in_1_bits_uop_ldst_val        (_mshrs_1_io_replay_bits_uop_ldst_val),	// mshrs.scala:620:22
    .io_in_1_bits_uop_dst_rtype       (_mshrs_1_io_replay_bits_uop_dst_rtype),	// mshrs.scala:620:22
    .io_in_1_bits_uop_lrs1_rtype      (_mshrs_1_io_replay_bits_uop_lrs1_rtype),	// mshrs.scala:620:22
    .io_in_1_bits_uop_lrs2_rtype      (_mshrs_1_io_replay_bits_uop_lrs2_rtype),	// mshrs.scala:620:22
    .io_in_1_bits_uop_frs3_en         (_mshrs_1_io_replay_bits_uop_frs3_en),	// mshrs.scala:620:22
    .io_in_1_bits_uop_fp_val          (_mshrs_1_io_replay_bits_uop_fp_val),	// mshrs.scala:620:22
    .io_in_1_bits_uop_fp_single       (_mshrs_1_io_replay_bits_uop_fp_single),	// mshrs.scala:620:22
    .io_in_1_bits_uop_xcpt_pf_if      (_mshrs_1_io_replay_bits_uop_xcpt_pf_if),	// mshrs.scala:620:22
    .io_in_1_bits_uop_xcpt_ae_if      (_mshrs_1_io_replay_bits_uop_xcpt_ae_if),	// mshrs.scala:620:22
    .io_in_1_bits_uop_xcpt_ma_if      (_mshrs_1_io_replay_bits_uop_xcpt_ma_if),	// mshrs.scala:620:22
    .io_in_1_bits_uop_bp_debug_if     (_mshrs_1_io_replay_bits_uop_bp_debug_if),	// mshrs.scala:620:22
    .io_in_1_bits_uop_bp_xcpt_if      (_mshrs_1_io_replay_bits_uop_bp_xcpt_if),	// mshrs.scala:620:22
    .io_in_1_bits_uop_debug_fsrc      (_mshrs_1_io_replay_bits_uop_debug_fsrc),	// mshrs.scala:620:22
    .io_in_1_bits_uop_debug_tsrc      (_mshrs_1_io_replay_bits_uop_debug_tsrc),	// mshrs.scala:620:22
    .io_in_1_bits_addr                (_mshrs_1_io_replay_bits_addr),	// mshrs.scala:620:22
    .io_in_1_bits_is_hella            (_mshrs_1_io_replay_bits_is_hella),	// mshrs.scala:620:22
    .io_in_1_bits_way_en              (_mshrs_1_io_replay_bits_way_en),	// mshrs.scala:620:22
    .io_in_1_bits_sdq_id              (_mshrs_1_io_replay_bits_sdq_id),	// mshrs.scala:620:22
    .io_in_2_valid                    (_mshrs_2_io_replay_valid),	// mshrs.scala:620:22
    .io_in_2_bits_uop_uopc            (_mshrs_2_io_replay_bits_uop_uopc),	// mshrs.scala:620:22
    .io_in_2_bits_uop_inst            (_mshrs_2_io_replay_bits_uop_inst),	// mshrs.scala:620:22
    .io_in_2_bits_uop_debug_inst      (_mshrs_2_io_replay_bits_uop_debug_inst),	// mshrs.scala:620:22
    .io_in_2_bits_uop_is_rvc          (_mshrs_2_io_replay_bits_uop_is_rvc),	// mshrs.scala:620:22
    .io_in_2_bits_uop_debug_pc        (_mshrs_2_io_replay_bits_uop_debug_pc),	// mshrs.scala:620:22
    .io_in_2_bits_uop_iq_type         (_mshrs_2_io_replay_bits_uop_iq_type),	// mshrs.scala:620:22
    .io_in_2_bits_uop_fu_code         (_mshrs_2_io_replay_bits_uop_fu_code),	// mshrs.scala:620:22
    .io_in_2_bits_uop_ctrl_br_type    (_mshrs_2_io_replay_bits_uop_ctrl_br_type),	// mshrs.scala:620:22
    .io_in_2_bits_uop_ctrl_op1_sel    (_mshrs_2_io_replay_bits_uop_ctrl_op1_sel),	// mshrs.scala:620:22
    .io_in_2_bits_uop_ctrl_op2_sel    (_mshrs_2_io_replay_bits_uop_ctrl_op2_sel),	// mshrs.scala:620:22
    .io_in_2_bits_uop_ctrl_imm_sel    (_mshrs_2_io_replay_bits_uop_ctrl_imm_sel),	// mshrs.scala:620:22
    .io_in_2_bits_uop_ctrl_op_fcn     (_mshrs_2_io_replay_bits_uop_ctrl_op_fcn),	// mshrs.scala:620:22
    .io_in_2_bits_uop_ctrl_fcn_dw     (_mshrs_2_io_replay_bits_uop_ctrl_fcn_dw),	// mshrs.scala:620:22
    .io_in_2_bits_uop_ctrl_csr_cmd    (_mshrs_2_io_replay_bits_uop_ctrl_csr_cmd),	// mshrs.scala:620:22
    .io_in_2_bits_uop_ctrl_is_load    (_mshrs_2_io_replay_bits_uop_ctrl_is_load),	// mshrs.scala:620:22
    .io_in_2_bits_uop_ctrl_is_sta     (_mshrs_2_io_replay_bits_uop_ctrl_is_sta),	// mshrs.scala:620:22
    .io_in_2_bits_uop_ctrl_is_std     (_mshrs_2_io_replay_bits_uop_ctrl_is_std),	// mshrs.scala:620:22
    .io_in_2_bits_uop_iw_state        (_mshrs_2_io_replay_bits_uop_iw_state),	// mshrs.scala:620:22
    .io_in_2_bits_uop_iw_p1_poisoned  (_mshrs_2_io_replay_bits_uop_iw_p1_poisoned),	// mshrs.scala:620:22
    .io_in_2_bits_uop_iw_p2_poisoned  (_mshrs_2_io_replay_bits_uop_iw_p2_poisoned),	// mshrs.scala:620:22
    .io_in_2_bits_uop_is_br           (_mshrs_2_io_replay_bits_uop_is_br),	// mshrs.scala:620:22
    .io_in_2_bits_uop_is_jalr         (_mshrs_2_io_replay_bits_uop_is_jalr),	// mshrs.scala:620:22
    .io_in_2_bits_uop_is_jal          (_mshrs_2_io_replay_bits_uop_is_jal),	// mshrs.scala:620:22
    .io_in_2_bits_uop_is_sfb          (_mshrs_2_io_replay_bits_uop_is_sfb),	// mshrs.scala:620:22
    .io_in_2_bits_uop_br_mask         (_mshrs_2_io_replay_bits_uop_br_mask),	// mshrs.scala:620:22
    .io_in_2_bits_uop_br_tag          (_mshrs_2_io_replay_bits_uop_br_tag),	// mshrs.scala:620:22
    .io_in_2_bits_uop_ftq_idx         (_mshrs_2_io_replay_bits_uop_ftq_idx),	// mshrs.scala:620:22
    .io_in_2_bits_uop_edge_inst       (_mshrs_2_io_replay_bits_uop_edge_inst),	// mshrs.scala:620:22
    .io_in_2_bits_uop_pc_lob          (_mshrs_2_io_replay_bits_uop_pc_lob),	// mshrs.scala:620:22
    .io_in_2_bits_uop_taken           (_mshrs_2_io_replay_bits_uop_taken),	// mshrs.scala:620:22
    .io_in_2_bits_uop_imm_packed      (_mshrs_2_io_replay_bits_uop_imm_packed),	// mshrs.scala:620:22
    .io_in_2_bits_uop_csr_addr        (_mshrs_2_io_replay_bits_uop_csr_addr),	// mshrs.scala:620:22
    .io_in_2_bits_uop_rob_idx         (_mshrs_2_io_replay_bits_uop_rob_idx),	// mshrs.scala:620:22
    .io_in_2_bits_uop_ldq_idx         (_mshrs_2_io_replay_bits_uop_ldq_idx),	// mshrs.scala:620:22
    .io_in_2_bits_uop_stq_idx         (_mshrs_2_io_replay_bits_uop_stq_idx),	// mshrs.scala:620:22
    .io_in_2_bits_uop_rxq_idx         (_mshrs_2_io_replay_bits_uop_rxq_idx),	// mshrs.scala:620:22
    .io_in_2_bits_uop_pdst            (_mshrs_2_io_replay_bits_uop_pdst),	// mshrs.scala:620:22
    .io_in_2_bits_uop_prs1            (_mshrs_2_io_replay_bits_uop_prs1),	// mshrs.scala:620:22
    .io_in_2_bits_uop_prs2            (_mshrs_2_io_replay_bits_uop_prs2),	// mshrs.scala:620:22
    .io_in_2_bits_uop_prs3            (_mshrs_2_io_replay_bits_uop_prs3),	// mshrs.scala:620:22
    .io_in_2_bits_uop_ppred           (_mshrs_2_io_replay_bits_uop_ppred),	// mshrs.scala:620:22
    .io_in_2_bits_uop_prs1_busy       (_mshrs_2_io_replay_bits_uop_prs1_busy),	// mshrs.scala:620:22
    .io_in_2_bits_uop_prs2_busy       (_mshrs_2_io_replay_bits_uop_prs2_busy),	// mshrs.scala:620:22
    .io_in_2_bits_uop_prs3_busy       (_mshrs_2_io_replay_bits_uop_prs3_busy),	// mshrs.scala:620:22
    .io_in_2_bits_uop_ppred_busy      (_mshrs_2_io_replay_bits_uop_ppred_busy),	// mshrs.scala:620:22
    .io_in_2_bits_uop_stale_pdst      (_mshrs_2_io_replay_bits_uop_stale_pdst),	// mshrs.scala:620:22
    .io_in_2_bits_uop_exception       (_mshrs_2_io_replay_bits_uop_exception),	// mshrs.scala:620:22
    .io_in_2_bits_uop_exc_cause       (_mshrs_2_io_replay_bits_uop_exc_cause),	// mshrs.scala:620:22
    .io_in_2_bits_uop_bypassable      (_mshrs_2_io_replay_bits_uop_bypassable),	// mshrs.scala:620:22
    .io_in_2_bits_uop_mem_cmd         (_mshrs_2_io_replay_bits_uop_mem_cmd),	// mshrs.scala:620:22
    .io_in_2_bits_uop_mem_size        (_mshrs_2_io_replay_bits_uop_mem_size),	// mshrs.scala:620:22
    .io_in_2_bits_uop_mem_signed      (_mshrs_2_io_replay_bits_uop_mem_signed),	// mshrs.scala:620:22
    .io_in_2_bits_uop_is_fence        (_mshrs_2_io_replay_bits_uop_is_fence),	// mshrs.scala:620:22
    .io_in_2_bits_uop_is_fencei       (_mshrs_2_io_replay_bits_uop_is_fencei),	// mshrs.scala:620:22
    .io_in_2_bits_uop_is_amo          (_mshrs_2_io_replay_bits_uop_is_amo),	// mshrs.scala:620:22
    .io_in_2_bits_uop_uses_ldq        (_mshrs_2_io_replay_bits_uop_uses_ldq),	// mshrs.scala:620:22
    .io_in_2_bits_uop_uses_stq        (_mshrs_2_io_replay_bits_uop_uses_stq),	// mshrs.scala:620:22
    .io_in_2_bits_uop_is_sys_pc2epc   (_mshrs_2_io_replay_bits_uop_is_sys_pc2epc),	// mshrs.scala:620:22
    .io_in_2_bits_uop_is_unique       (_mshrs_2_io_replay_bits_uop_is_unique),	// mshrs.scala:620:22
    .io_in_2_bits_uop_flush_on_commit (_mshrs_2_io_replay_bits_uop_flush_on_commit),	// mshrs.scala:620:22
    .io_in_2_bits_uop_ldst_is_rs1     (_mshrs_2_io_replay_bits_uop_ldst_is_rs1),	// mshrs.scala:620:22
    .io_in_2_bits_uop_ldst            (_mshrs_2_io_replay_bits_uop_ldst),	// mshrs.scala:620:22
    .io_in_2_bits_uop_lrs1            (_mshrs_2_io_replay_bits_uop_lrs1),	// mshrs.scala:620:22
    .io_in_2_bits_uop_lrs2            (_mshrs_2_io_replay_bits_uop_lrs2),	// mshrs.scala:620:22
    .io_in_2_bits_uop_lrs3            (_mshrs_2_io_replay_bits_uop_lrs3),	// mshrs.scala:620:22
    .io_in_2_bits_uop_ldst_val        (_mshrs_2_io_replay_bits_uop_ldst_val),	// mshrs.scala:620:22
    .io_in_2_bits_uop_dst_rtype       (_mshrs_2_io_replay_bits_uop_dst_rtype),	// mshrs.scala:620:22
    .io_in_2_bits_uop_lrs1_rtype      (_mshrs_2_io_replay_bits_uop_lrs1_rtype),	// mshrs.scala:620:22
    .io_in_2_bits_uop_lrs2_rtype      (_mshrs_2_io_replay_bits_uop_lrs2_rtype),	// mshrs.scala:620:22
    .io_in_2_bits_uop_frs3_en         (_mshrs_2_io_replay_bits_uop_frs3_en),	// mshrs.scala:620:22
    .io_in_2_bits_uop_fp_val          (_mshrs_2_io_replay_bits_uop_fp_val),	// mshrs.scala:620:22
    .io_in_2_bits_uop_fp_single       (_mshrs_2_io_replay_bits_uop_fp_single),	// mshrs.scala:620:22
    .io_in_2_bits_uop_xcpt_pf_if      (_mshrs_2_io_replay_bits_uop_xcpt_pf_if),	// mshrs.scala:620:22
    .io_in_2_bits_uop_xcpt_ae_if      (_mshrs_2_io_replay_bits_uop_xcpt_ae_if),	// mshrs.scala:620:22
    .io_in_2_bits_uop_xcpt_ma_if      (_mshrs_2_io_replay_bits_uop_xcpt_ma_if),	// mshrs.scala:620:22
    .io_in_2_bits_uop_bp_debug_if     (_mshrs_2_io_replay_bits_uop_bp_debug_if),	// mshrs.scala:620:22
    .io_in_2_bits_uop_bp_xcpt_if      (_mshrs_2_io_replay_bits_uop_bp_xcpt_if),	// mshrs.scala:620:22
    .io_in_2_bits_uop_debug_fsrc      (_mshrs_2_io_replay_bits_uop_debug_fsrc),	// mshrs.scala:620:22
    .io_in_2_bits_uop_debug_tsrc      (_mshrs_2_io_replay_bits_uop_debug_tsrc),	// mshrs.scala:620:22
    .io_in_2_bits_addr                (_mshrs_2_io_replay_bits_addr),	// mshrs.scala:620:22
    .io_in_2_bits_is_hella            (_mshrs_2_io_replay_bits_is_hella),	// mshrs.scala:620:22
    .io_in_2_bits_way_en              (_mshrs_2_io_replay_bits_way_en),	// mshrs.scala:620:22
    .io_in_2_bits_sdq_id              (_mshrs_2_io_replay_bits_sdq_id),	// mshrs.scala:620:22
    .io_in_3_valid                    (_mshrs_3_io_replay_valid),	// mshrs.scala:620:22
    .io_in_3_bits_uop_uopc            (_mshrs_3_io_replay_bits_uop_uopc),	// mshrs.scala:620:22
    .io_in_3_bits_uop_inst            (_mshrs_3_io_replay_bits_uop_inst),	// mshrs.scala:620:22
    .io_in_3_bits_uop_debug_inst      (_mshrs_3_io_replay_bits_uop_debug_inst),	// mshrs.scala:620:22
    .io_in_3_bits_uop_is_rvc          (_mshrs_3_io_replay_bits_uop_is_rvc),	// mshrs.scala:620:22
    .io_in_3_bits_uop_debug_pc        (_mshrs_3_io_replay_bits_uop_debug_pc),	// mshrs.scala:620:22
    .io_in_3_bits_uop_iq_type         (_mshrs_3_io_replay_bits_uop_iq_type),	// mshrs.scala:620:22
    .io_in_3_bits_uop_fu_code         (_mshrs_3_io_replay_bits_uop_fu_code),	// mshrs.scala:620:22
    .io_in_3_bits_uop_ctrl_br_type    (_mshrs_3_io_replay_bits_uop_ctrl_br_type),	// mshrs.scala:620:22
    .io_in_3_bits_uop_ctrl_op1_sel    (_mshrs_3_io_replay_bits_uop_ctrl_op1_sel),	// mshrs.scala:620:22
    .io_in_3_bits_uop_ctrl_op2_sel    (_mshrs_3_io_replay_bits_uop_ctrl_op2_sel),	// mshrs.scala:620:22
    .io_in_3_bits_uop_ctrl_imm_sel    (_mshrs_3_io_replay_bits_uop_ctrl_imm_sel),	// mshrs.scala:620:22
    .io_in_3_bits_uop_ctrl_op_fcn     (_mshrs_3_io_replay_bits_uop_ctrl_op_fcn),	// mshrs.scala:620:22
    .io_in_3_bits_uop_ctrl_fcn_dw     (_mshrs_3_io_replay_bits_uop_ctrl_fcn_dw),	// mshrs.scala:620:22
    .io_in_3_bits_uop_ctrl_csr_cmd    (_mshrs_3_io_replay_bits_uop_ctrl_csr_cmd),	// mshrs.scala:620:22
    .io_in_3_bits_uop_ctrl_is_load    (_mshrs_3_io_replay_bits_uop_ctrl_is_load),	// mshrs.scala:620:22
    .io_in_3_bits_uop_ctrl_is_sta     (_mshrs_3_io_replay_bits_uop_ctrl_is_sta),	// mshrs.scala:620:22
    .io_in_3_bits_uop_ctrl_is_std     (_mshrs_3_io_replay_bits_uop_ctrl_is_std),	// mshrs.scala:620:22
    .io_in_3_bits_uop_iw_state        (_mshrs_3_io_replay_bits_uop_iw_state),	// mshrs.scala:620:22
    .io_in_3_bits_uop_iw_p1_poisoned  (_mshrs_3_io_replay_bits_uop_iw_p1_poisoned),	// mshrs.scala:620:22
    .io_in_3_bits_uop_iw_p2_poisoned  (_mshrs_3_io_replay_bits_uop_iw_p2_poisoned),	// mshrs.scala:620:22
    .io_in_3_bits_uop_is_br           (_mshrs_3_io_replay_bits_uop_is_br),	// mshrs.scala:620:22
    .io_in_3_bits_uop_is_jalr         (_mshrs_3_io_replay_bits_uop_is_jalr),	// mshrs.scala:620:22
    .io_in_3_bits_uop_is_jal          (_mshrs_3_io_replay_bits_uop_is_jal),	// mshrs.scala:620:22
    .io_in_3_bits_uop_is_sfb          (_mshrs_3_io_replay_bits_uop_is_sfb),	// mshrs.scala:620:22
    .io_in_3_bits_uop_br_mask         (_mshrs_3_io_replay_bits_uop_br_mask),	// mshrs.scala:620:22
    .io_in_3_bits_uop_br_tag          (_mshrs_3_io_replay_bits_uop_br_tag),	// mshrs.scala:620:22
    .io_in_3_bits_uop_ftq_idx         (_mshrs_3_io_replay_bits_uop_ftq_idx),	// mshrs.scala:620:22
    .io_in_3_bits_uop_edge_inst       (_mshrs_3_io_replay_bits_uop_edge_inst),	// mshrs.scala:620:22
    .io_in_3_bits_uop_pc_lob          (_mshrs_3_io_replay_bits_uop_pc_lob),	// mshrs.scala:620:22
    .io_in_3_bits_uop_taken           (_mshrs_3_io_replay_bits_uop_taken),	// mshrs.scala:620:22
    .io_in_3_bits_uop_imm_packed      (_mshrs_3_io_replay_bits_uop_imm_packed),	// mshrs.scala:620:22
    .io_in_3_bits_uop_csr_addr        (_mshrs_3_io_replay_bits_uop_csr_addr),	// mshrs.scala:620:22
    .io_in_3_bits_uop_rob_idx         (_mshrs_3_io_replay_bits_uop_rob_idx),	// mshrs.scala:620:22
    .io_in_3_bits_uop_ldq_idx         (_mshrs_3_io_replay_bits_uop_ldq_idx),	// mshrs.scala:620:22
    .io_in_3_bits_uop_stq_idx         (_mshrs_3_io_replay_bits_uop_stq_idx),	// mshrs.scala:620:22
    .io_in_3_bits_uop_rxq_idx         (_mshrs_3_io_replay_bits_uop_rxq_idx),	// mshrs.scala:620:22
    .io_in_3_bits_uop_pdst            (_mshrs_3_io_replay_bits_uop_pdst),	// mshrs.scala:620:22
    .io_in_3_bits_uop_prs1            (_mshrs_3_io_replay_bits_uop_prs1),	// mshrs.scala:620:22
    .io_in_3_bits_uop_prs2            (_mshrs_3_io_replay_bits_uop_prs2),	// mshrs.scala:620:22
    .io_in_3_bits_uop_prs3            (_mshrs_3_io_replay_bits_uop_prs3),	// mshrs.scala:620:22
    .io_in_3_bits_uop_ppred           (_mshrs_3_io_replay_bits_uop_ppred),	// mshrs.scala:620:22
    .io_in_3_bits_uop_prs1_busy       (_mshrs_3_io_replay_bits_uop_prs1_busy),	// mshrs.scala:620:22
    .io_in_3_bits_uop_prs2_busy       (_mshrs_3_io_replay_bits_uop_prs2_busy),	// mshrs.scala:620:22
    .io_in_3_bits_uop_prs3_busy       (_mshrs_3_io_replay_bits_uop_prs3_busy),	// mshrs.scala:620:22
    .io_in_3_bits_uop_ppred_busy      (_mshrs_3_io_replay_bits_uop_ppred_busy),	// mshrs.scala:620:22
    .io_in_3_bits_uop_stale_pdst      (_mshrs_3_io_replay_bits_uop_stale_pdst),	// mshrs.scala:620:22
    .io_in_3_bits_uop_exception       (_mshrs_3_io_replay_bits_uop_exception),	// mshrs.scala:620:22
    .io_in_3_bits_uop_exc_cause       (_mshrs_3_io_replay_bits_uop_exc_cause),	// mshrs.scala:620:22
    .io_in_3_bits_uop_bypassable      (_mshrs_3_io_replay_bits_uop_bypassable),	// mshrs.scala:620:22
    .io_in_3_bits_uop_mem_cmd         (_mshrs_3_io_replay_bits_uop_mem_cmd),	// mshrs.scala:620:22
    .io_in_3_bits_uop_mem_size        (_mshrs_3_io_replay_bits_uop_mem_size),	// mshrs.scala:620:22
    .io_in_3_bits_uop_mem_signed      (_mshrs_3_io_replay_bits_uop_mem_signed),	// mshrs.scala:620:22
    .io_in_3_bits_uop_is_fence        (_mshrs_3_io_replay_bits_uop_is_fence),	// mshrs.scala:620:22
    .io_in_3_bits_uop_is_fencei       (_mshrs_3_io_replay_bits_uop_is_fencei),	// mshrs.scala:620:22
    .io_in_3_bits_uop_is_amo          (_mshrs_3_io_replay_bits_uop_is_amo),	// mshrs.scala:620:22
    .io_in_3_bits_uop_uses_ldq        (_mshrs_3_io_replay_bits_uop_uses_ldq),	// mshrs.scala:620:22
    .io_in_3_bits_uop_uses_stq        (_mshrs_3_io_replay_bits_uop_uses_stq),	// mshrs.scala:620:22
    .io_in_3_bits_uop_is_sys_pc2epc   (_mshrs_3_io_replay_bits_uop_is_sys_pc2epc),	// mshrs.scala:620:22
    .io_in_3_bits_uop_is_unique       (_mshrs_3_io_replay_bits_uop_is_unique),	// mshrs.scala:620:22
    .io_in_3_bits_uop_flush_on_commit (_mshrs_3_io_replay_bits_uop_flush_on_commit),	// mshrs.scala:620:22
    .io_in_3_bits_uop_ldst_is_rs1     (_mshrs_3_io_replay_bits_uop_ldst_is_rs1),	// mshrs.scala:620:22
    .io_in_3_bits_uop_ldst            (_mshrs_3_io_replay_bits_uop_ldst),	// mshrs.scala:620:22
    .io_in_3_bits_uop_lrs1            (_mshrs_3_io_replay_bits_uop_lrs1),	// mshrs.scala:620:22
    .io_in_3_bits_uop_lrs2            (_mshrs_3_io_replay_bits_uop_lrs2),	// mshrs.scala:620:22
    .io_in_3_bits_uop_lrs3            (_mshrs_3_io_replay_bits_uop_lrs3),	// mshrs.scala:620:22
    .io_in_3_bits_uop_ldst_val        (_mshrs_3_io_replay_bits_uop_ldst_val),	// mshrs.scala:620:22
    .io_in_3_bits_uop_dst_rtype       (_mshrs_3_io_replay_bits_uop_dst_rtype),	// mshrs.scala:620:22
    .io_in_3_bits_uop_lrs1_rtype      (_mshrs_3_io_replay_bits_uop_lrs1_rtype),	// mshrs.scala:620:22
    .io_in_3_bits_uop_lrs2_rtype      (_mshrs_3_io_replay_bits_uop_lrs2_rtype),	// mshrs.scala:620:22
    .io_in_3_bits_uop_frs3_en         (_mshrs_3_io_replay_bits_uop_frs3_en),	// mshrs.scala:620:22
    .io_in_3_bits_uop_fp_val          (_mshrs_3_io_replay_bits_uop_fp_val),	// mshrs.scala:620:22
    .io_in_3_bits_uop_fp_single       (_mshrs_3_io_replay_bits_uop_fp_single),	// mshrs.scala:620:22
    .io_in_3_bits_uop_xcpt_pf_if      (_mshrs_3_io_replay_bits_uop_xcpt_pf_if),	// mshrs.scala:620:22
    .io_in_3_bits_uop_xcpt_ae_if      (_mshrs_3_io_replay_bits_uop_xcpt_ae_if),	// mshrs.scala:620:22
    .io_in_3_bits_uop_xcpt_ma_if      (_mshrs_3_io_replay_bits_uop_xcpt_ma_if),	// mshrs.scala:620:22
    .io_in_3_bits_uop_bp_debug_if     (_mshrs_3_io_replay_bits_uop_bp_debug_if),	// mshrs.scala:620:22
    .io_in_3_bits_uop_bp_xcpt_if      (_mshrs_3_io_replay_bits_uop_bp_xcpt_if),	// mshrs.scala:620:22
    .io_in_3_bits_uop_debug_fsrc      (_mshrs_3_io_replay_bits_uop_debug_fsrc),	// mshrs.scala:620:22
    .io_in_3_bits_uop_debug_tsrc      (_mshrs_3_io_replay_bits_uop_debug_tsrc),	// mshrs.scala:620:22
    .io_in_3_bits_addr                (_mshrs_3_io_replay_bits_addr),	// mshrs.scala:620:22
    .io_in_3_bits_is_hella            (_mshrs_3_io_replay_bits_is_hella),	// mshrs.scala:620:22
    .io_in_3_bits_way_en              (_mshrs_3_io_replay_bits_way_en),	// mshrs.scala:620:22
    .io_in_3_bits_sdq_id              (_mshrs_3_io_replay_bits_sdq_id),	// mshrs.scala:620:22
    .io_in_4_valid                    (_mshrs_4_io_replay_valid),	// mshrs.scala:620:22
    .io_in_4_bits_uop_uopc            (_mshrs_4_io_replay_bits_uop_uopc),	// mshrs.scala:620:22
    .io_in_4_bits_uop_inst            (_mshrs_4_io_replay_bits_uop_inst),	// mshrs.scala:620:22
    .io_in_4_bits_uop_debug_inst      (_mshrs_4_io_replay_bits_uop_debug_inst),	// mshrs.scala:620:22
    .io_in_4_bits_uop_is_rvc          (_mshrs_4_io_replay_bits_uop_is_rvc),	// mshrs.scala:620:22
    .io_in_4_bits_uop_debug_pc        (_mshrs_4_io_replay_bits_uop_debug_pc),	// mshrs.scala:620:22
    .io_in_4_bits_uop_iq_type         (_mshrs_4_io_replay_bits_uop_iq_type),	// mshrs.scala:620:22
    .io_in_4_bits_uop_fu_code         (_mshrs_4_io_replay_bits_uop_fu_code),	// mshrs.scala:620:22
    .io_in_4_bits_uop_ctrl_br_type    (_mshrs_4_io_replay_bits_uop_ctrl_br_type),	// mshrs.scala:620:22
    .io_in_4_bits_uop_ctrl_op1_sel    (_mshrs_4_io_replay_bits_uop_ctrl_op1_sel),	// mshrs.scala:620:22
    .io_in_4_bits_uop_ctrl_op2_sel    (_mshrs_4_io_replay_bits_uop_ctrl_op2_sel),	// mshrs.scala:620:22
    .io_in_4_bits_uop_ctrl_imm_sel    (_mshrs_4_io_replay_bits_uop_ctrl_imm_sel),	// mshrs.scala:620:22
    .io_in_4_bits_uop_ctrl_op_fcn     (_mshrs_4_io_replay_bits_uop_ctrl_op_fcn),	// mshrs.scala:620:22
    .io_in_4_bits_uop_ctrl_fcn_dw     (_mshrs_4_io_replay_bits_uop_ctrl_fcn_dw),	// mshrs.scala:620:22
    .io_in_4_bits_uop_ctrl_csr_cmd    (_mshrs_4_io_replay_bits_uop_ctrl_csr_cmd),	// mshrs.scala:620:22
    .io_in_4_bits_uop_ctrl_is_load    (_mshrs_4_io_replay_bits_uop_ctrl_is_load),	// mshrs.scala:620:22
    .io_in_4_bits_uop_ctrl_is_sta     (_mshrs_4_io_replay_bits_uop_ctrl_is_sta),	// mshrs.scala:620:22
    .io_in_4_bits_uop_ctrl_is_std     (_mshrs_4_io_replay_bits_uop_ctrl_is_std),	// mshrs.scala:620:22
    .io_in_4_bits_uop_iw_state        (_mshrs_4_io_replay_bits_uop_iw_state),	// mshrs.scala:620:22
    .io_in_4_bits_uop_iw_p1_poisoned  (_mshrs_4_io_replay_bits_uop_iw_p1_poisoned),	// mshrs.scala:620:22
    .io_in_4_bits_uop_iw_p2_poisoned  (_mshrs_4_io_replay_bits_uop_iw_p2_poisoned),	// mshrs.scala:620:22
    .io_in_4_bits_uop_is_br           (_mshrs_4_io_replay_bits_uop_is_br),	// mshrs.scala:620:22
    .io_in_4_bits_uop_is_jalr         (_mshrs_4_io_replay_bits_uop_is_jalr),	// mshrs.scala:620:22
    .io_in_4_bits_uop_is_jal          (_mshrs_4_io_replay_bits_uop_is_jal),	// mshrs.scala:620:22
    .io_in_4_bits_uop_is_sfb          (_mshrs_4_io_replay_bits_uop_is_sfb),	// mshrs.scala:620:22
    .io_in_4_bits_uop_br_mask         (_mshrs_4_io_replay_bits_uop_br_mask),	// mshrs.scala:620:22
    .io_in_4_bits_uop_br_tag          (_mshrs_4_io_replay_bits_uop_br_tag),	// mshrs.scala:620:22
    .io_in_4_bits_uop_ftq_idx         (_mshrs_4_io_replay_bits_uop_ftq_idx),	// mshrs.scala:620:22
    .io_in_4_bits_uop_edge_inst       (_mshrs_4_io_replay_bits_uop_edge_inst),	// mshrs.scala:620:22
    .io_in_4_bits_uop_pc_lob          (_mshrs_4_io_replay_bits_uop_pc_lob),	// mshrs.scala:620:22
    .io_in_4_bits_uop_taken           (_mshrs_4_io_replay_bits_uop_taken),	// mshrs.scala:620:22
    .io_in_4_bits_uop_imm_packed      (_mshrs_4_io_replay_bits_uop_imm_packed),	// mshrs.scala:620:22
    .io_in_4_bits_uop_csr_addr        (_mshrs_4_io_replay_bits_uop_csr_addr),	// mshrs.scala:620:22
    .io_in_4_bits_uop_rob_idx         (_mshrs_4_io_replay_bits_uop_rob_idx),	// mshrs.scala:620:22
    .io_in_4_bits_uop_ldq_idx         (_mshrs_4_io_replay_bits_uop_ldq_idx),	// mshrs.scala:620:22
    .io_in_4_bits_uop_stq_idx         (_mshrs_4_io_replay_bits_uop_stq_idx),	// mshrs.scala:620:22
    .io_in_4_bits_uop_rxq_idx         (_mshrs_4_io_replay_bits_uop_rxq_idx),	// mshrs.scala:620:22
    .io_in_4_bits_uop_pdst            (_mshrs_4_io_replay_bits_uop_pdst),	// mshrs.scala:620:22
    .io_in_4_bits_uop_prs1            (_mshrs_4_io_replay_bits_uop_prs1),	// mshrs.scala:620:22
    .io_in_4_bits_uop_prs2            (_mshrs_4_io_replay_bits_uop_prs2),	// mshrs.scala:620:22
    .io_in_4_bits_uop_prs3            (_mshrs_4_io_replay_bits_uop_prs3),	// mshrs.scala:620:22
    .io_in_4_bits_uop_ppred           (_mshrs_4_io_replay_bits_uop_ppred),	// mshrs.scala:620:22
    .io_in_4_bits_uop_prs1_busy       (_mshrs_4_io_replay_bits_uop_prs1_busy),	// mshrs.scala:620:22
    .io_in_4_bits_uop_prs2_busy       (_mshrs_4_io_replay_bits_uop_prs2_busy),	// mshrs.scala:620:22
    .io_in_4_bits_uop_prs3_busy       (_mshrs_4_io_replay_bits_uop_prs3_busy),	// mshrs.scala:620:22
    .io_in_4_bits_uop_ppred_busy      (_mshrs_4_io_replay_bits_uop_ppred_busy),	// mshrs.scala:620:22
    .io_in_4_bits_uop_stale_pdst      (_mshrs_4_io_replay_bits_uop_stale_pdst),	// mshrs.scala:620:22
    .io_in_4_bits_uop_exception       (_mshrs_4_io_replay_bits_uop_exception),	// mshrs.scala:620:22
    .io_in_4_bits_uop_exc_cause       (_mshrs_4_io_replay_bits_uop_exc_cause),	// mshrs.scala:620:22
    .io_in_4_bits_uop_bypassable      (_mshrs_4_io_replay_bits_uop_bypassable),	// mshrs.scala:620:22
    .io_in_4_bits_uop_mem_cmd         (_mshrs_4_io_replay_bits_uop_mem_cmd),	// mshrs.scala:620:22
    .io_in_4_bits_uop_mem_size        (_mshrs_4_io_replay_bits_uop_mem_size),	// mshrs.scala:620:22
    .io_in_4_bits_uop_mem_signed      (_mshrs_4_io_replay_bits_uop_mem_signed),	// mshrs.scala:620:22
    .io_in_4_bits_uop_is_fence        (_mshrs_4_io_replay_bits_uop_is_fence),	// mshrs.scala:620:22
    .io_in_4_bits_uop_is_fencei       (_mshrs_4_io_replay_bits_uop_is_fencei),	// mshrs.scala:620:22
    .io_in_4_bits_uop_is_amo          (_mshrs_4_io_replay_bits_uop_is_amo),	// mshrs.scala:620:22
    .io_in_4_bits_uop_uses_ldq        (_mshrs_4_io_replay_bits_uop_uses_ldq),	// mshrs.scala:620:22
    .io_in_4_bits_uop_uses_stq        (_mshrs_4_io_replay_bits_uop_uses_stq),	// mshrs.scala:620:22
    .io_in_4_bits_uop_is_sys_pc2epc   (_mshrs_4_io_replay_bits_uop_is_sys_pc2epc),	// mshrs.scala:620:22
    .io_in_4_bits_uop_is_unique       (_mshrs_4_io_replay_bits_uop_is_unique),	// mshrs.scala:620:22
    .io_in_4_bits_uop_flush_on_commit (_mshrs_4_io_replay_bits_uop_flush_on_commit),	// mshrs.scala:620:22
    .io_in_4_bits_uop_ldst_is_rs1     (_mshrs_4_io_replay_bits_uop_ldst_is_rs1),	// mshrs.scala:620:22
    .io_in_4_bits_uop_ldst            (_mshrs_4_io_replay_bits_uop_ldst),	// mshrs.scala:620:22
    .io_in_4_bits_uop_lrs1            (_mshrs_4_io_replay_bits_uop_lrs1),	// mshrs.scala:620:22
    .io_in_4_bits_uop_lrs2            (_mshrs_4_io_replay_bits_uop_lrs2),	// mshrs.scala:620:22
    .io_in_4_bits_uop_lrs3            (_mshrs_4_io_replay_bits_uop_lrs3),	// mshrs.scala:620:22
    .io_in_4_bits_uop_ldst_val        (_mshrs_4_io_replay_bits_uop_ldst_val),	// mshrs.scala:620:22
    .io_in_4_bits_uop_dst_rtype       (_mshrs_4_io_replay_bits_uop_dst_rtype),	// mshrs.scala:620:22
    .io_in_4_bits_uop_lrs1_rtype      (_mshrs_4_io_replay_bits_uop_lrs1_rtype),	// mshrs.scala:620:22
    .io_in_4_bits_uop_lrs2_rtype      (_mshrs_4_io_replay_bits_uop_lrs2_rtype),	// mshrs.scala:620:22
    .io_in_4_bits_uop_frs3_en         (_mshrs_4_io_replay_bits_uop_frs3_en),	// mshrs.scala:620:22
    .io_in_4_bits_uop_fp_val          (_mshrs_4_io_replay_bits_uop_fp_val),	// mshrs.scala:620:22
    .io_in_4_bits_uop_fp_single       (_mshrs_4_io_replay_bits_uop_fp_single),	// mshrs.scala:620:22
    .io_in_4_bits_uop_xcpt_pf_if      (_mshrs_4_io_replay_bits_uop_xcpt_pf_if),	// mshrs.scala:620:22
    .io_in_4_bits_uop_xcpt_ae_if      (_mshrs_4_io_replay_bits_uop_xcpt_ae_if),	// mshrs.scala:620:22
    .io_in_4_bits_uop_xcpt_ma_if      (_mshrs_4_io_replay_bits_uop_xcpt_ma_if),	// mshrs.scala:620:22
    .io_in_4_bits_uop_bp_debug_if     (_mshrs_4_io_replay_bits_uop_bp_debug_if),	// mshrs.scala:620:22
    .io_in_4_bits_uop_bp_xcpt_if      (_mshrs_4_io_replay_bits_uop_bp_xcpt_if),	// mshrs.scala:620:22
    .io_in_4_bits_uop_debug_fsrc      (_mshrs_4_io_replay_bits_uop_debug_fsrc),	// mshrs.scala:620:22
    .io_in_4_bits_uop_debug_tsrc      (_mshrs_4_io_replay_bits_uop_debug_tsrc),	// mshrs.scala:620:22
    .io_in_4_bits_addr                (_mshrs_4_io_replay_bits_addr),	// mshrs.scala:620:22
    .io_in_4_bits_is_hella            (_mshrs_4_io_replay_bits_is_hella),	// mshrs.scala:620:22
    .io_in_4_bits_way_en              (_mshrs_4_io_replay_bits_way_en),	// mshrs.scala:620:22
    .io_in_4_bits_sdq_id              (_mshrs_4_io_replay_bits_sdq_id),	// mshrs.scala:620:22
    .io_in_5_valid                    (_mshrs_5_io_replay_valid),	// mshrs.scala:620:22
    .io_in_5_bits_uop_uopc            (_mshrs_5_io_replay_bits_uop_uopc),	// mshrs.scala:620:22
    .io_in_5_bits_uop_inst            (_mshrs_5_io_replay_bits_uop_inst),	// mshrs.scala:620:22
    .io_in_5_bits_uop_debug_inst      (_mshrs_5_io_replay_bits_uop_debug_inst),	// mshrs.scala:620:22
    .io_in_5_bits_uop_is_rvc          (_mshrs_5_io_replay_bits_uop_is_rvc),	// mshrs.scala:620:22
    .io_in_5_bits_uop_debug_pc        (_mshrs_5_io_replay_bits_uop_debug_pc),	// mshrs.scala:620:22
    .io_in_5_bits_uop_iq_type         (_mshrs_5_io_replay_bits_uop_iq_type),	// mshrs.scala:620:22
    .io_in_5_bits_uop_fu_code         (_mshrs_5_io_replay_bits_uop_fu_code),	// mshrs.scala:620:22
    .io_in_5_bits_uop_ctrl_br_type    (_mshrs_5_io_replay_bits_uop_ctrl_br_type),	// mshrs.scala:620:22
    .io_in_5_bits_uop_ctrl_op1_sel    (_mshrs_5_io_replay_bits_uop_ctrl_op1_sel),	// mshrs.scala:620:22
    .io_in_5_bits_uop_ctrl_op2_sel    (_mshrs_5_io_replay_bits_uop_ctrl_op2_sel),	// mshrs.scala:620:22
    .io_in_5_bits_uop_ctrl_imm_sel    (_mshrs_5_io_replay_bits_uop_ctrl_imm_sel),	// mshrs.scala:620:22
    .io_in_5_bits_uop_ctrl_op_fcn     (_mshrs_5_io_replay_bits_uop_ctrl_op_fcn),	// mshrs.scala:620:22
    .io_in_5_bits_uop_ctrl_fcn_dw     (_mshrs_5_io_replay_bits_uop_ctrl_fcn_dw),	// mshrs.scala:620:22
    .io_in_5_bits_uop_ctrl_csr_cmd    (_mshrs_5_io_replay_bits_uop_ctrl_csr_cmd),	// mshrs.scala:620:22
    .io_in_5_bits_uop_ctrl_is_load    (_mshrs_5_io_replay_bits_uop_ctrl_is_load),	// mshrs.scala:620:22
    .io_in_5_bits_uop_ctrl_is_sta     (_mshrs_5_io_replay_bits_uop_ctrl_is_sta),	// mshrs.scala:620:22
    .io_in_5_bits_uop_ctrl_is_std     (_mshrs_5_io_replay_bits_uop_ctrl_is_std),	// mshrs.scala:620:22
    .io_in_5_bits_uop_iw_state        (_mshrs_5_io_replay_bits_uop_iw_state),	// mshrs.scala:620:22
    .io_in_5_bits_uop_iw_p1_poisoned  (_mshrs_5_io_replay_bits_uop_iw_p1_poisoned),	// mshrs.scala:620:22
    .io_in_5_bits_uop_iw_p2_poisoned  (_mshrs_5_io_replay_bits_uop_iw_p2_poisoned),	// mshrs.scala:620:22
    .io_in_5_bits_uop_is_br           (_mshrs_5_io_replay_bits_uop_is_br),	// mshrs.scala:620:22
    .io_in_5_bits_uop_is_jalr         (_mshrs_5_io_replay_bits_uop_is_jalr),	// mshrs.scala:620:22
    .io_in_5_bits_uop_is_jal          (_mshrs_5_io_replay_bits_uop_is_jal),	// mshrs.scala:620:22
    .io_in_5_bits_uop_is_sfb          (_mshrs_5_io_replay_bits_uop_is_sfb),	// mshrs.scala:620:22
    .io_in_5_bits_uop_br_mask         (_mshrs_5_io_replay_bits_uop_br_mask),	// mshrs.scala:620:22
    .io_in_5_bits_uop_br_tag          (_mshrs_5_io_replay_bits_uop_br_tag),	// mshrs.scala:620:22
    .io_in_5_bits_uop_ftq_idx         (_mshrs_5_io_replay_bits_uop_ftq_idx),	// mshrs.scala:620:22
    .io_in_5_bits_uop_edge_inst       (_mshrs_5_io_replay_bits_uop_edge_inst),	// mshrs.scala:620:22
    .io_in_5_bits_uop_pc_lob          (_mshrs_5_io_replay_bits_uop_pc_lob),	// mshrs.scala:620:22
    .io_in_5_bits_uop_taken           (_mshrs_5_io_replay_bits_uop_taken),	// mshrs.scala:620:22
    .io_in_5_bits_uop_imm_packed      (_mshrs_5_io_replay_bits_uop_imm_packed),	// mshrs.scala:620:22
    .io_in_5_bits_uop_csr_addr        (_mshrs_5_io_replay_bits_uop_csr_addr),	// mshrs.scala:620:22
    .io_in_5_bits_uop_rob_idx         (_mshrs_5_io_replay_bits_uop_rob_idx),	// mshrs.scala:620:22
    .io_in_5_bits_uop_ldq_idx         (_mshrs_5_io_replay_bits_uop_ldq_idx),	// mshrs.scala:620:22
    .io_in_5_bits_uop_stq_idx         (_mshrs_5_io_replay_bits_uop_stq_idx),	// mshrs.scala:620:22
    .io_in_5_bits_uop_rxq_idx         (_mshrs_5_io_replay_bits_uop_rxq_idx),	// mshrs.scala:620:22
    .io_in_5_bits_uop_pdst            (_mshrs_5_io_replay_bits_uop_pdst),	// mshrs.scala:620:22
    .io_in_5_bits_uop_prs1            (_mshrs_5_io_replay_bits_uop_prs1),	// mshrs.scala:620:22
    .io_in_5_bits_uop_prs2            (_mshrs_5_io_replay_bits_uop_prs2),	// mshrs.scala:620:22
    .io_in_5_bits_uop_prs3            (_mshrs_5_io_replay_bits_uop_prs3),	// mshrs.scala:620:22
    .io_in_5_bits_uop_ppred           (_mshrs_5_io_replay_bits_uop_ppred),	// mshrs.scala:620:22
    .io_in_5_bits_uop_prs1_busy       (_mshrs_5_io_replay_bits_uop_prs1_busy),	// mshrs.scala:620:22
    .io_in_5_bits_uop_prs2_busy       (_mshrs_5_io_replay_bits_uop_prs2_busy),	// mshrs.scala:620:22
    .io_in_5_bits_uop_prs3_busy       (_mshrs_5_io_replay_bits_uop_prs3_busy),	// mshrs.scala:620:22
    .io_in_5_bits_uop_ppred_busy      (_mshrs_5_io_replay_bits_uop_ppred_busy),	// mshrs.scala:620:22
    .io_in_5_bits_uop_stale_pdst      (_mshrs_5_io_replay_bits_uop_stale_pdst),	// mshrs.scala:620:22
    .io_in_5_bits_uop_exception       (_mshrs_5_io_replay_bits_uop_exception),	// mshrs.scala:620:22
    .io_in_5_bits_uop_exc_cause       (_mshrs_5_io_replay_bits_uop_exc_cause),	// mshrs.scala:620:22
    .io_in_5_bits_uop_bypassable      (_mshrs_5_io_replay_bits_uop_bypassable),	// mshrs.scala:620:22
    .io_in_5_bits_uop_mem_cmd         (_mshrs_5_io_replay_bits_uop_mem_cmd),	// mshrs.scala:620:22
    .io_in_5_bits_uop_mem_size        (_mshrs_5_io_replay_bits_uop_mem_size),	// mshrs.scala:620:22
    .io_in_5_bits_uop_mem_signed      (_mshrs_5_io_replay_bits_uop_mem_signed),	// mshrs.scala:620:22
    .io_in_5_bits_uop_is_fence        (_mshrs_5_io_replay_bits_uop_is_fence),	// mshrs.scala:620:22
    .io_in_5_bits_uop_is_fencei       (_mshrs_5_io_replay_bits_uop_is_fencei),	// mshrs.scala:620:22
    .io_in_5_bits_uop_is_amo          (_mshrs_5_io_replay_bits_uop_is_amo),	// mshrs.scala:620:22
    .io_in_5_bits_uop_uses_ldq        (_mshrs_5_io_replay_bits_uop_uses_ldq),	// mshrs.scala:620:22
    .io_in_5_bits_uop_uses_stq        (_mshrs_5_io_replay_bits_uop_uses_stq),	// mshrs.scala:620:22
    .io_in_5_bits_uop_is_sys_pc2epc   (_mshrs_5_io_replay_bits_uop_is_sys_pc2epc),	// mshrs.scala:620:22
    .io_in_5_bits_uop_is_unique       (_mshrs_5_io_replay_bits_uop_is_unique),	// mshrs.scala:620:22
    .io_in_5_bits_uop_flush_on_commit (_mshrs_5_io_replay_bits_uop_flush_on_commit),	// mshrs.scala:620:22
    .io_in_5_bits_uop_ldst_is_rs1     (_mshrs_5_io_replay_bits_uop_ldst_is_rs1),	// mshrs.scala:620:22
    .io_in_5_bits_uop_ldst            (_mshrs_5_io_replay_bits_uop_ldst),	// mshrs.scala:620:22
    .io_in_5_bits_uop_lrs1            (_mshrs_5_io_replay_bits_uop_lrs1),	// mshrs.scala:620:22
    .io_in_5_bits_uop_lrs2            (_mshrs_5_io_replay_bits_uop_lrs2),	// mshrs.scala:620:22
    .io_in_5_bits_uop_lrs3            (_mshrs_5_io_replay_bits_uop_lrs3),	// mshrs.scala:620:22
    .io_in_5_bits_uop_ldst_val        (_mshrs_5_io_replay_bits_uop_ldst_val),	// mshrs.scala:620:22
    .io_in_5_bits_uop_dst_rtype       (_mshrs_5_io_replay_bits_uop_dst_rtype),	// mshrs.scala:620:22
    .io_in_5_bits_uop_lrs1_rtype      (_mshrs_5_io_replay_bits_uop_lrs1_rtype),	// mshrs.scala:620:22
    .io_in_5_bits_uop_lrs2_rtype      (_mshrs_5_io_replay_bits_uop_lrs2_rtype),	// mshrs.scala:620:22
    .io_in_5_bits_uop_frs3_en         (_mshrs_5_io_replay_bits_uop_frs3_en),	// mshrs.scala:620:22
    .io_in_5_bits_uop_fp_val          (_mshrs_5_io_replay_bits_uop_fp_val),	// mshrs.scala:620:22
    .io_in_5_bits_uop_fp_single       (_mshrs_5_io_replay_bits_uop_fp_single),	// mshrs.scala:620:22
    .io_in_5_bits_uop_xcpt_pf_if      (_mshrs_5_io_replay_bits_uop_xcpt_pf_if),	// mshrs.scala:620:22
    .io_in_5_bits_uop_xcpt_ae_if      (_mshrs_5_io_replay_bits_uop_xcpt_ae_if),	// mshrs.scala:620:22
    .io_in_5_bits_uop_xcpt_ma_if      (_mshrs_5_io_replay_bits_uop_xcpt_ma_if),	// mshrs.scala:620:22
    .io_in_5_bits_uop_bp_debug_if     (_mshrs_5_io_replay_bits_uop_bp_debug_if),	// mshrs.scala:620:22
    .io_in_5_bits_uop_bp_xcpt_if      (_mshrs_5_io_replay_bits_uop_bp_xcpt_if),	// mshrs.scala:620:22
    .io_in_5_bits_uop_debug_fsrc      (_mshrs_5_io_replay_bits_uop_debug_fsrc),	// mshrs.scala:620:22
    .io_in_5_bits_uop_debug_tsrc      (_mshrs_5_io_replay_bits_uop_debug_tsrc),	// mshrs.scala:620:22
    .io_in_5_bits_addr                (_mshrs_5_io_replay_bits_addr),	// mshrs.scala:620:22
    .io_in_5_bits_is_hella            (_mshrs_5_io_replay_bits_is_hella),	// mshrs.scala:620:22
    .io_in_5_bits_way_en              (_mshrs_5_io_replay_bits_way_en),	// mshrs.scala:620:22
    .io_in_5_bits_sdq_id              (_mshrs_5_io_replay_bits_sdq_id),	// mshrs.scala:620:22
    .io_in_6_valid                    (_mshrs_6_io_replay_valid),	// mshrs.scala:620:22
    .io_in_6_bits_uop_uopc            (_mshrs_6_io_replay_bits_uop_uopc),	// mshrs.scala:620:22
    .io_in_6_bits_uop_inst            (_mshrs_6_io_replay_bits_uop_inst),	// mshrs.scala:620:22
    .io_in_6_bits_uop_debug_inst      (_mshrs_6_io_replay_bits_uop_debug_inst),	// mshrs.scala:620:22
    .io_in_6_bits_uop_is_rvc          (_mshrs_6_io_replay_bits_uop_is_rvc),	// mshrs.scala:620:22
    .io_in_6_bits_uop_debug_pc        (_mshrs_6_io_replay_bits_uop_debug_pc),	// mshrs.scala:620:22
    .io_in_6_bits_uop_iq_type         (_mshrs_6_io_replay_bits_uop_iq_type),	// mshrs.scala:620:22
    .io_in_6_bits_uop_fu_code         (_mshrs_6_io_replay_bits_uop_fu_code),	// mshrs.scala:620:22
    .io_in_6_bits_uop_ctrl_br_type    (_mshrs_6_io_replay_bits_uop_ctrl_br_type),	// mshrs.scala:620:22
    .io_in_6_bits_uop_ctrl_op1_sel    (_mshrs_6_io_replay_bits_uop_ctrl_op1_sel),	// mshrs.scala:620:22
    .io_in_6_bits_uop_ctrl_op2_sel    (_mshrs_6_io_replay_bits_uop_ctrl_op2_sel),	// mshrs.scala:620:22
    .io_in_6_bits_uop_ctrl_imm_sel    (_mshrs_6_io_replay_bits_uop_ctrl_imm_sel),	// mshrs.scala:620:22
    .io_in_6_bits_uop_ctrl_op_fcn     (_mshrs_6_io_replay_bits_uop_ctrl_op_fcn),	// mshrs.scala:620:22
    .io_in_6_bits_uop_ctrl_fcn_dw     (_mshrs_6_io_replay_bits_uop_ctrl_fcn_dw),	// mshrs.scala:620:22
    .io_in_6_bits_uop_ctrl_csr_cmd    (_mshrs_6_io_replay_bits_uop_ctrl_csr_cmd),	// mshrs.scala:620:22
    .io_in_6_bits_uop_ctrl_is_load    (_mshrs_6_io_replay_bits_uop_ctrl_is_load),	// mshrs.scala:620:22
    .io_in_6_bits_uop_ctrl_is_sta     (_mshrs_6_io_replay_bits_uop_ctrl_is_sta),	// mshrs.scala:620:22
    .io_in_6_bits_uop_ctrl_is_std     (_mshrs_6_io_replay_bits_uop_ctrl_is_std),	// mshrs.scala:620:22
    .io_in_6_bits_uop_iw_state        (_mshrs_6_io_replay_bits_uop_iw_state),	// mshrs.scala:620:22
    .io_in_6_bits_uop_iw_p1_poisoned  (_mshrs_6_io_replay_bits_uop_iw_p1_poisoned),	// mshrs.scala:620:22
    .io_in_6_bits_uop_iw_p2_poisoned  (_mshrs_6_io_replay_bits_uop_iw_p2_poisoned),	// mshrs.scala:620:22
    .io_in_6_bits_uop_is_br           (_mshrs_6_io_replay_bits_uop_is_br),	// mshrs.scala:620:22
    .io_in_6_bits_uop_is_jalr         (_mshrs_6_io_replay_bits_uop_is_jalr),	// mshrs.scala:620:22
    .io_in_6_bits_uop_is_jal          (_mshrs_6_io_replay_bits_uop_is_jal),	// mshrs.scala:620:22
    .io_in_6_bits_uop_is_sfb          (_mshrs_6_io_replay_bits_uop_is_sfb),	// mshrs.scala:620:22
    .io_in_6_bits_uop_br_mask         (_mshrs_6_io_replay_bits_uop_br_mask),	// mshrs.scala:620:22
    .io_in_6_bits_uop_br_tag          (_mshrs_6_io_replay_bits_uop_br_tag),	// mshrs.scala:620:22
    .io_in_6_bits_uop_ftq_idx         (_mshrs_6_io_replay_bits_uop_ftq_idx),	// mshrs.scala:620:22
    .io_in_6_bits_uop_edge_inst       (_mshrs_6_io_replay_bits_uop_edge_inst),	// mshrs.scala:620:22
    .io_in_6_bits_uop_pc_lob          (_mshrs_6_io_replay_bits_uop_pc_lob),	// mshrs.scala:620:22
    .io_in_6_bits_uop_taken           (_mshrs_6_io_replay_bits_uop_taken),	// mshrs.scala:620:22
    .io_in_6_bits_uop_imm_packed      (_mshrs_6_io_replay_bits_uop_imm_packed),	// mshrs.scala:620:22
    .io_in_6_bits_uop_csr_addr        (_mshrs_6_io_replay_bits_uop_csr_addr),	// mshrs.scala:620:22
    .io_in_6_bits_uop_rob_idx         (_mshrs_6_io_replay_bits_uop_rob_idx),	// mshrs.scala:620:22
    .io_in_6_bits_uop_ldq_idx         (_mshrs_6_io_replay_bits_uop_ldq_idx),	// mshrs.scala:620:22
    .io_in_6_bits_uop_stq_idx         (_mshrs_6_io_replay_bits_uop_stq_idx),	// mshrs.scala:620:22
    .io_in_6_bits_uop_rxq_idx         (_mshrs_6_io_replay_bits_uop_rxq_idx),	// mshrs.scala:620:22
    .io_in_6_bits_uop_pdst            (_mshrs_6_io_replay_bits_uop_pdst),	// mshrs.scala:620:22
    .io_in_6_bits_uop_prs1            (_mshrs_6_io_replay_bits_uop_prs1),	// mshrs.scala:620:22
    .io_in_6_bits_uop_prs2            (_mshrs_6_io_replay_bits_uop_prs2),	// mshrs.scala:620:22
    .io_in_6_bits_uop_prs3            (_mshrs_6_io_replay_bits_uop_prs3),	// mshrs.scala:620:22
    .io_in_6_bits_uop_ppred           (_mshrs_6_io_replay_bits_uop_ppred),	// mshrs.scala:620:22
    .io_in_6_bits_uop_prs1_busy       (_mshrs_6_io_replay_bits_uop_prs1_busy),	// mshrs.scala:620:22
    .io_in_6_bits_uop_prs2_busy       (_mshrs_6_io_replay_bits_uop_prs2_busy),	// mshrs.scala:620:22
    .io_in_6_bits_uop_prs3_busy       (_mshrs_6_io_replay_bits_uop_prs3_busy),	// mshrs.scala:620:22
    .io_in_6_bits_uop_ppred_busy      (_mshrs_6_io_replay_bits_uop_ppred_busy),	// mshrs.scala:620:22
    .io_in_6_bits_uop_stale_pdst      (_mshrs_6_io_replay_bits_uop_stale_pdst),	// mshrs.scala:620:22
    .io_in_6_bits_uop_exception       (_mshrs_6_io_replay_bits_uop_exception),	// mshrs.scala:620:22
    .io_in_6_bits_uop_exc_cause       (_mshrs_6_io_replay_bits_uop_exc_cause),	// mshrs.scala:620:22
    .io_in_6_bits_uop_bypassable      (_mshrs_6_io_replay_bits_uop_bypassable),	// mshrs.scala:620:22
    .io_in_6_bits_uop_mem_cmd         (_mshrs_6_io_replay_bits_uop_mem_cmd),	// mshrs.scala:620:22
    .io_in_6_bits_uop_mem_size        (_mshrs_6_io_replay_bits_uop_mem_size),	// mshrs.scala:620:22
    .io_in_6_bits_uop_mem_signed      (_mshrs_6_io_replay_bits_uop_mem_signed),	// mshrs.scala:620:22
    .io_in_6_bits_uop_is_fence        (_mshrs_6_io_replay_bits_uop_is_fence),	// mshrs.scala:620:22
    .io_in_6_bits_uop_is_fencei       (_mshrs_6_io_replay_bits_uop_is_fencei),	// mshrs.scala:620:22
    .io_in_6_bits_uop_is_amo          (_mshrs_6_io_replay_bits_uop_is_amo),	// mshrs.scala:620:22
    .io_in_6_bits_uop_uses_ldq        (_mshrs_6_io_replay_bits_uop_uses_ldq),	// mshrs.scala:620:22
    .io_in_6_bits_uop_uses_stq        (_mshrs_6_io_replay_bits_uop_uses_stq),	// mshrs.scala:620:22
    .io_in_6_bits_uop_is_sys_pc2epc   (_mshrs_6_io_replay_bits_uop_is_sys_pc2epc),	// mshrs.scala:620:22
    .io_in_6_bits_uop_is_unique       (_mshrs_6_io_replay_bits_uop_is_unique),	// mshrs.scala:620:22
    .io_in_6_bits_uop_flush_on_commit (_mshrs_6_io_replay_bits_uop_flush_on_commit),	// mshrs.scala:620:22
    .io_in_6_bits_uop_ldst_is_rs1     (_mshrs_6_io_replay_bits_uop_ldst_is_rs1),	// mshrs.scala:620:22
    .io_in_6_bits_uop_ldst            (_mshrs_6_io_replay_bits_uop_ldst),	// mshrs.scala:620:22
    .io_in_6_bits_uop_lrs1            (_mshrs_6_io_replay_bits_uop_lrs1),	// mshrs.scala:620:22
    .io_in_6_bits_uop_lrs2            (_mshrs_6_io_replay_bits_uop_lrs2),	// mshrs.scala:620:22
    .io_in_6_bits_uop_lrs3            (_mshrs_6_io_replay_bits_uop_lrs3),	// mshrs.scala:620:22
    .io_in_6_bits_uop_ldst_val        (_mshrs_6_io_replay_bits_uop_ldst_val),	// mshrs.scala:620:22
    .io_in_6_bits_uop_dst_rtype       (_mshrs_6_io_replay_bits_uop_dst_rtype),	// mshrs.scala:620:22
    .io_in_6_bits_uop_lrs1_rtype      (_mshrs_6_io_replay_bits_uop_lrs1_rtype),	// mshrs.scala:620:22
    .io_in_6_bits_uop_lrs2_rtype      (_mshrs_6_io_replay_bits_uop_lrs2_rtype),	// mshrs.scala:620:22
    .io_in_6_bits_uop_frs3_en         (_mshrs_6_io_replay_bits_uop_frs3_en),	// mshrs.scala:620:22
    .io_in_6_bits_uop_fp_val          (_mshrs_6_io_replay_bits_uop_fp_val),	// mshrs.scala:620:22
    .io_in_6_bits_uop_fp_single       (_mshrs_6_io_replay_bits_uop_fp_single),	// mshrs.scala:620:22
    .io_in_6_bits_uop_xcpt_pf_if      (_mshrs_6_io_replay_bits_uop_xcpt_pf_if),	// mshrs.scala:620:22
    .io_in_6_bits_uop_xcpt_ae_if      (_mshrs_6_io_replay_bits_uop_xcpt_ae_if),	// mshrs.scala:620:22
    .io_in_6_bits_uop_xcpt_ma_if      (_mshrs_6_io_replay_bits_uop_xcpt_ma_if),	// mshrs.scala:620:22
    .io_in_6_bits_uop_bp_debug_if     (_mshrs_6_io_replay_bits_uop_bp_debug_if),	// mshrs.scala:620:22
    .io_in_6_bits_uop_bp_xcpt_if      (_mshrs_6_io_replay_bits_uop_bp_xcpt_if),	// mshrs.scala:620:22
    .io_in_6_bits_uop_debug_fsrc      (_mshrs_6_io_replay_bits_uop_debug_fsrc),	// mshrs.scala:620:22
    .io_in_6_bits_uop_debug_tsrc      (_mshrs_6_io_replay_bits_uop_debug_tsrc),	// mshrs.scala:620:22
    .io_in_6_bits_addr                (_mshrs_6_io_replay_bits_addr),	// mshrs.scala:620:22
    .io_in_6_bits_is_hella            (_mshrs_6_io_replay_bits_is_hella),	// mshrs.scala:620:22
    .io_in_6_bits_way_en              (_mshrs_6_io_replay_bits_way_en),	// mshrs.scala:620:22
    .io_in_6_bits_sdq_id              (_mshrs_6_io_replay_bits_sdq_id),	// mshrs.scala:620:22
    .io_in_7_valid                    (_mshrs_7_io_replay_valid),	// mshrs.scala:620:22
    .io_in_7_bits_uop_uopc            (_mshrs_7_io_replay_bits_uop_uopc),	// mshrs.scala:620:22
    .io_in_7_bits_uop_inst            (_mshrs_7_io_replay_bits_uop_inst),	// mshrs.scala:620:22
    .io_in_7_bits_uop_debug_inst      (_mshrs_7_io_replay_bits_uop_debug_inst),	// mshrs.scala:620:22
    .io_in_7_bits_uop_is_rvc          (_mshrs_7_io_replay_bits_uop_is_rvc),	// mshrs.scala:620:22
    .io_in_7_bits_uop_debug_pc        (_mshrs_7_io_replay_bits_uop_debug_pc),	// mshrs.scala:620:22
    .io_in_7_bits_uop_iq_type         (_mshrs_7_io_replay_bits_uop_iq_type),	// mshrs.scala:620:22
    .io_in_7_bits_uop_fu_code         (_mshrs_7_io_replay_bits_uop_fu_code),	// mshrs.scala:620:22
    .io_in_7_bits_uop_ctrl_br_type    (_mshrs_7_io_replay_bits_uop_ctrl_br_type),	// mshrs.scala:620:22
    .io_in_7_bits_uop_ctrl_op1_sel    (_mshrs_7_io_replay_bits_uop_ctrl_op1_sel),	// mshrs.scala:620:22
    .io_in_7_bits_uop_ctrl_op2_sel    (_mshrs_7_io_replay_bits_uop_ctrl_op2_sel),	// mshrs.scala:620:22
    .io_in_7_bits_uop_ctrl_imm_sel    (_mshrs_7_io_replay_bits_uop_ctrl_imm_sel),	// mshrs.scala:620:22
    .io_in_7_bits_uop_ctrl_op_fcn     (_mshrs_7_io_replay_bits_uop_ctrl_op_fcn),	// mshrs.scala:620:22
    .io_in_7_bits_uop_ctrl_fcn_dw     (_mshrs_7_io_replay_bits_uop_ctrl_fcn_dw),	// mshrs.scala:620:22
    .io_in_7_bits_uop_ctrl_csr_cmd    (_mshrs_7_io_replay_bits_uop_ctrl_csr_cmd),	// mshrs.scala:620:22
    .io_in_7_bits_uop_ctrl_is_load    (_mshrs_7_io_replay_bits_uop_ctrl_is_load),	// mshrs.scala:620:22
    .io_in_7_bits_uop_ctrl_is_sta     (_mshrs_7_io_replay_bits_uop_ctrl_is_sta),	// mshrs.scala:620:22
    .io_in_7_bits_uop_ctrl_is_std     (_mshrs_7_io_replay_bits_uop_ctrl_is_std),	// mshrs.scala:620:22
    .io_in_7_bits_uop_iw_state        (_mshrs_7_io_replay_bits_uop_iw_state),	// mshrs.scala:620:22
    .io_in_7_bits_uop_iw_p1_poisoned  (_mshrs_7_io_replay_bits_uop_iw_p1_poisoned),	// mshrs.scala:620:22
    .io_in_7_bits_uop_iw_p2_poisoned  (_mshrs_7_io_replay_bits_uop_iw_p2_poisoned),	// mshrs.scala:620:22
    .io_in_7_bits_uop_is_br           (_mshrs_7_io_replay_bits_uop_is_br),	// mshrs.scala:620:22
    .io_in_7_bits_uop_is_jalr         (_mshrs_7_io_replay_bits_uop_is_jalr),	// mshrs.scala:620:22
    .io_in_7_bits_uop_is_jal          (_mshrs_7_io_replay_bits_uop_is_jal),	// mshrs.scala:620:22
    .io_in_7_bits_uop_is_sfb          (_mshrs_7_io_replay_bits_uop_is_sfb),	// mshrs.scala:620:22
    .io_in_7_bits_uop_br_mask         (_mshrs_7_io_replay_bits_uop_br_mask),	// mshrs.scala:620:22
    .io_in_7_bits_uop_br_tag          (_mshrs_7_io_replay_bits_uop_br_tag),	// mshrs.scala:620:22
    .io_in_7_bits_uop_ftq_idx         (_mshrs_7_io_replay_bits_uop_ftq_idx),	// mshrs.scala:620:22
    .io_in_7_bits_uop_edge_inst       (_mshrs_7_io_replay_bits_uop_edge_inst),	// mshrs.scala:620:22
    .io_in_7_bits_uop_pc_lob          (_mshrs_7_io_replay_bits_uop_pc_lob),	// mshrs.scala:620:22
    .io_in_7_bits_uop_taken           (_mshrs_7_io_replay_bits_uop_taken),	// mshrs.scala:620:22
    .io_in_7_bits_uop_imm_packed      (_mshrs_7_io_replay_bits_uop_imm_packed),	// mshrs.scala:620:22
    .io_in_7_bits_uop_csr_addr        (_mshrs_7_io_replay_bits_uop_csr_addr),	// mshrs.scala:620:22
    .io_in_7_bits_uop_rob_idx         (_mshrs_7_io_replay_bits_uop_rob_idx),	// mshrs.scala:620:22
    .io_in_7_bits_uop_ldq_idx         (_mshrs_7_io_replay_bits_uop_ldq_idx),	// mshrs.scala:620:22
    .io_in_7_bits_uop_stq_idx         (_mshrs_7_io_replay_bits_uop_stq_idx),	// mshrs.scala:620:22
    .io_in_7_bits_uop_rxq_idx         (_mshrs_7_io_replay_bits_uop_rxq_idx),	// mshrs.scala:620:22
    .io_in_7_bits_uop_pdst            (_mshrs_7_io_replay_bits_uop_pdst),	// mshrs.scala:620:22
    .io_in_7_bits_uop_prs1            (_mshrs_7_io_replay_bits_uop_prs1),	// mshrs.scala:620:22
    .io_in_7_bits_uop_prs2            (_mshrs_7_io_replay_bits_uop_prs2),	// mshrs.scala:620:22
    .io_in_7_bits_uop_prs3            (_mshrs_7_io_replay_bits_uop_prs3),	// mshrs.scala:620:22
    .io_in_7_bits_uop_ppred           (_mshrs_7_io_replay_bits_uop_ppred),	// mshrs.scala:620:22
    .io_in_7_bits_uop_prs1_busy       (_mshrs_7_io_replay_bits_uop_prs1_busy),	// mshrs.scala:620:22
    .io_in_7_bits_uop_prs2_busy       (_mshrs_7_io_replay_bits_uop_prs2_busy),	// mshrs.scala:620:22
    .io_in_7_bits_uop_prs3_busy       (_mshrs_7_io_replay_bits_uop_prs3_busy),	// mshrs.scala:620:22
    .io_in_7_bits_uop_ppred_busy      (_mshrs_7_io_replay_bits_uop_ppred_busy),	// mshrs.scala:620:22
    .io_in_7_bits_uop_stale_pdst      (_mshrs_7_io_replay_bits_uop_stale_pdst),	// mshrs.scala:620:22
    .io_in_7_bits_uop_exception       (_mshrs_7_io_replay_bits_uop_exception),	// mshrs.scala:620:22
    .io_in_7_bits_uop_exc_cause       (_mshrs_7_io_replay_bits_uop_exc_cause),	// mshrs.scala:620:22
    .io_in_7_bits_uop_bypassable      (_mshrs_7_io_replay_bits_uop_bypassable),	// mshrs.scala:620:22
    .io_in_7_bits_uop_mem_cmd         (_mshrs_7_io_replay_bits_uop_mem_cmd),	// mshrs.scala:620:22
    .io_in_7_bits_uop_mem_size        (_mshrs_7_io_replay_bits_uop_mem_size),	// mshrs.scala:620:22
    .io_in_7_bits_uop_mem_signed      (_mshrs_7_io_replay_bits_uop_mem_signed),	// mshrs.scala:620:22
    .io_in_7_bits_uop_is_fence        (_mshrs_7_io_replay_bits_uop_is_fence),	// mshrs.scala:620:22
    .io_in_7_bits_uop_is_fencei       (_mshrs_7_io_replay_bits_uop_is_fencei),	// mshrs.scala:620:22
    .io_in_7_bits_uop_is_amo          (_mshrs_7_io_replay_bits_uop_is_amo),	// mshrs.scala:620:22
    .io_in_7_bits_uop_uses_ldq        (_mshrs_7_io_replay_bits_uop_uses_ldq),	// mshrs.scala:620:22
    .io_in_7_bits_uop_uses_stq        (_mshrs_7_io_replay_bits_uop_uses_stq),	// mshrs.scala:620:22
    .io_in_7_bits_uop_is_sys_pc2epc   (_mshrs_7_io_replay_bits_uop_is_sys_pc2epc),	// mshrs.scala:620:22
    .io_in_7_bits_uop_is_unique       (_mshrs_7_io_replay_bits_uop_is_unique),	// mshrs.scala:620:22
    .io_in_7_bits_uop_flush_on_commit (_mshrs_7_io_replay_bits_uop_flush_on_commit),	// mshrs.scala:620:22
    .io_in_7_bits_uop_ldst_is_rs1     (_mshrs_7_io_replay_bits_uop_ldst_is_rs1),	// mshrs.scala:620:22
    .io_in_7_bits_uop_ldst            (_mshrs_7_io_replay_bits_uop_ldst),	// mshrs.scala:620:22
    .io_in_7_bits_uop_lrs1            (_mshrs_7_io_replay_bits_uop_lrs1),	// mshrs.scala:620:22
    .io_in_7_bits_uop_lrs2            (_mshrs_7_io_replay_bits_uop_lrs2),	// mshrs.scala:620:22
    .io_in_7_bits_uop_lrs3            (_mshrs_7_io_replay_bits_uop_lrs3),	// mshrs.scala:620:22
    .io_in_7_bits_uop_ldst_val        (_mshrs_7_io_replay_bits_uop_ldst_val),	// mshrs.scala:620:22
    .io_in_7_bits_uop_dst_rtype       (_mshrs_7_io_replay_bits_uop_dst_rtype),	// mshrs.scala:620:22
    .io_in_7_bits_uop_lrs1_rtype      (_mshrs_7_io_replay_bits_uop_lrs1_rtype),	// mshrs.scala:620:22
    .io_in_7_bits_uop_lrs2_rtype      (_mshrs_7_io_replay_bits_uop_lrs2_rtype),	// mshrs.scala:620:22
    .io_in_7_bits_uop_frs3_en         (_mshrs_7_io_replay_bits_uop_frs3_en),	// mshrs.scala:620:22
    .io_in_7_bits_uop_fp_val          (_mshrs_7_io_replay_bits_uop_fp_val),	// mshrs.scala:620:22
    .io_in_7_bits_uop_fp_single       (_mshrs_7_io_replay_bits_uop_fp_single),	// mshrs.scala:620:22
    .io_in_7_bits_uop_xcpt_pf_if      (_mshrs_7_io_replay_bits_uop_xcpt_pf_if),	// mshrs.scala:620:22
    .io_in_7_bits_uop_xcpt_ae_if      (_mshrs_7_io_replay_bits_uop_xcpt_ae_if),	// mshrs.scala:620:22
    .io_in_7_bits_uop_xcpt_ma_if      (_mshrs_7_io_replay_bits_uop_xcpt_ma_if),	// mshrs.scala:620:22
    .io_in_7_bits_uop_bp_debug_if     (_mshrs_7_io_replay_bits_uop_bp_debug_if),	// mshrs.scala:620:22
    .io_in_7_bits_uop_bp_xcpt_if      (_mshrs_7_io_replay_bits_uop_bp_xcpt_if),	// mshrs.scala:620:22
    .io_in_7_bits_uop_debug_fsrc      (_mshrs_7_io_replay_bits_uop_debug_fsrc),	// mshrs.scala:620:22
    .io_in_7_bits_uop_debug_tsrc      (_mshrs_7_io_replay_bits_uop_debug_tsrc),	// mshrs.scala:620:22
    .io_in_7_bits_addr                (_mshrs_7_io_replay_bits_addr),	// mshrs.scala:620:22
    .io_in_7_bits_is_hella            (_mshrs_7_io_replay_bits_is_hella),	// mshrs.scala:620:22
    .io_in_7_bits_way_en              (_mshrs_7_io_replay_bits_way_en),	// mshrs.scala:620:22
    .io_in_7_bits_sdq_id              (_mshrs_7_io_replay_bits_sdq_id),	// mshrs.scala:620:22
    .io_out_ready                     (io_replay_ready),
    .io_in_0_ready                    (_replay_arb_io_in_0_ready),
    .io_in_1_ready                    (_replay_arb_io_in_1_ready),
    .io_in_2_ready                    (_replay_arb_io_in_2_ready),
    .io_in_3_ready                    (_replay_arb_io_in_3_ready),
    .io_in_4_ready                    (_replay_arb_io_in_4_ready),
    .io_in_5_ready                    (_replay_arb_io_in_5_ready),
    .io_in_6_ready                    (_replay_arb_io_in_6_ready),
    .io_in_7_ready                    (_replay_arb_io_in_7_ready),
    .io_out_valid                     (_replay_arb_io_out_valid),
    .io_out_bits_uop_uopc             (io_replay_bits_uop_uopc),
    .io_out_bits_uop_inst             (io_replay_bits_uop_inst),
    .io_out_bits_uop_debug_inst       (io_replay_bits_uop_debug_inst),
    .io_out_bits_uop_is_rvc           (io_replay_bits_uop_is_rvc),
    .io_out_bits_uop_debug_pc         (io_replay_bits_uop_debug_pc),
    .io_out_bits_uop_iq_type          (io_replay_bits_uop_iq_type),
    .io_out_bits_uop_fu_code          (io_replay_bits_uop_fu_code),
    .io_out_bits_uop_ctrl_br_type     (io_replay_bits_uop_ctrl_br_type),
    .io_out_bits_uop_ctrl_op1_sel     (io_replay_bits_uop_ctrl_op1_sel),
    .io_out_bits_uop_ctrl_op2_sel     (io_replay_bits_uop_ctrl_op2_sel),
    .io_out_bits_uop_ctrl_imm_sel     (io_replay_bits_uop_ctrl_imm_sel),
    .io_out_bits_uop_ctrl_op_fcn      (io_replay_bits_uop_ctrl_op_fcn),
    .io_out_bits_uop_ctrl_fcn_dw      (io_replay_bits_uop_ctrl_fcn_dw),
    .io_out_bits_uop_ctrl_csr_cmd     (io_replay_bits_uop_ctrl_csr_cmd),
    .io_out_bits_uop_ctrl_is_load     (io_replay_bits_uop_ctrl_is_load),
    .io_out_bits_uop_ctrl_is_sta      (io_replay_bits_uop_ctrl_is_sta),
    .io_out_bits_uop_ctrl_is_std      (io_replay_bits_uop_ctrl_is_std),
    .io_out_bits_uop_iw_state         (io_replay_bits_uop_iw_state),
    .io_out_bits_uop_iw_p1_poisoned   (io_replay_bits_uop_iw_p1_poisoned),
    .io_out_bits_uop_iw_p2_poisoned   (io_replay_bits_uop_iw_p2_poisoned),
    .io_out_bits_uop_is_br            (io_replay_bits_uop_is_br),
    .io_out_bits_uop_is_jalr          (io_replay_bits_uop_is_jalr),
    .io_out_bits_uop_is_jal           (io_replay_bits_uop_is_jal),
    .io_out_bits_uop_is_sfb           (io_replay_bits_uop_is_sfb),
    .io_out_bits_uop_br_mask          (io_replay_bits_uop_br_mask),
    .io_out_bits_uop_br_tag           (io_replay_bits_uop_br_tag),
    .io_out_bits_uop_ftq_idx          (io_replay_bits_uop_ftq_idx),
    .io_out_bits_uop_edge_inst        (io_replay_bits_uop_edge_inst),
    .io_out_bits_uop_pc_lob           (io_replay_bits_uop_pc_lob),
    .io_out_bits_uop_taken            (io_replay_bits_uop_taken),
    .io_out_bits_uop_imm_packed       (io_replay_bits_uop_imm_packed),
    .io_out_bits_uop_csr_addr         (io_replay_bits_uop_csr_addr),
    .io_out_bits_uop_rob_idx          (io_replay_bits_uop_rob_idx),
    .io_out_bits_uop_ldq_idx          (io_replay_bits_uop_ldq_idx),
    .io_out_bits_uop_stq_idx          (io_replay_bits_uop_stq_idx),
    .io_out_bits_uop_rxq_idx          (io_replay_bits_uop_rxq_idx),
    .io_out_bits_uop_pdst             (io_replay_bits_uop_pdst),
    .io_out_bits_uop_prs1             (io_replay_bits_uop_prs1),
    .io_out_bits_uop_prs2             (io_replay_bits_uop_prs2),
    .io_out_bits_uop_prs3             (io_replay_bits_uop_prs3),
    .io_out_bits_uop_ppred            (io_replay_bits_uop_ppred),
    .io_out_bits_uop_prs1_busy        (io_replay_bits_uop_prs1_busy),
    .io_out_bits_uop_prs2_busy        (io_replay_bits_uop_prs2_busy),
    .io_out_bits_uop_prs3_busy        (io_replay_bits_uop_prs3_busy),
    .io_out_bits_uop_ppred_busy       (io_replay_bits_uop_ppred_busy),
    .io_out_bits_uop_stale_pdst       (io_replay_bits_uop_stale_pdst),
    .io_out_bits_uop_exception        (io_replay_bits_uop_exception),
    .io_out_bits_uop_exc_cause        (io_replay_bits_uop_exc_cause),
    .io_out_bits_uop_bypassable       (io_replay_bits_uop_bypassable),
    .io_out_bits_uop_mem_cmd          (_replay_arb_io_out_bits_uop_mem_cmd),
    .io_out_bits_uop_mem_size         (io_replay_bits_uop_mem_size),
    .io_out_bits_uop_mem_signed       (io_replay_bits_uop_mem_signed),
    .io_out_bits_uop_is_fence         (io_replay_bits_uop_is_fence),
    .io_out_bits_uop_is_fencei        (io_replay_bits_uop_is_fencei),
    .io_out_bits_uop_is_amo           (io_replay_bits_uop_is_amo),
    .io_out_bits_uop_uses_ldq         (io_replay_bits_uop_uses_ldq),
    .io_out_bits_uop_uses_stq         (io_replay_bits_uop_uses_stq),
    .io_out_bits_uop_is_sys_pc2epc    (io_replay_bits_uop_is_sys_pc2epc),
    .io_out_bits_uop_is_unique        (io_replay_bits_uop_is_unique),
    .io_out_bits_uop_flush_on_commit  (io_replay_bits_uop_flush_on_commit),
    .io_out_bits_uop_ldst_is_rs1      (io_replay_bits_uop_ldst_is_rs1),
    .io_out_bits_uop_ldst             (io_replay_bits_uop_ldst),
    .io_out_bits_uop_lrs1             (io_replay_bits_uop_lrs1),
    .io_out_bits_uop_lrs2             (io_replay_bits_uop_lrs2),
    .io_out_bits_uop_lrs3             (io_replay_bits_uop_lrs3),
    .io_out_bits_uop_ldst_val         (io_replay_bits_uop_ldst_val),
    .io_out_bits_uop_dst_rtype        (io_replay_bits_uop_dst_rtype),
    .io_out_bits_uop_lrs1_rtype       (io_replay_bits_uop_lrs1_rtype),
    .io_out_bits_uop_lrs2_rtype       (io_replay_bits_uop_lrs2_rtype),
    .io_out_bits_uop_frs3_en          (io_replay_bits_uop_frs3_en),
    .io_out_bits_uop_fp_val           (io_replay_bits_uop_fp_val),
    .io_out_bits_uop_fp_single        (io_replay_bits_uop_fp_single),
    .io_out_bits_uop_xcpt_pf_if       (io_replay_bits_uop_xcpt_pf_if),
    .io_out_bits_uop_xcpt_ae_if       (io_replay_bits_uop_xcpt_ae_if),
    .io_out_bits_uop_xcpt_ma_if       (io_replay_bits_uop_xcpt_ma_if),
    .io_out_bits_uop_bp_debug_if      (io_replay_bits_uop_bp_debug_if),
    .io_out_bits_uop_bp_xcpt_if       (io_replay_bits_uop_bp_xcpt_if),
    .io_out_bits_uop_debug_fsrc       (io_replay_bits_uop_debug_fsrc),
    .io_out_bits_uop_debug_tsrc       (io_replay_bits_uop_debug_tsrc),
    .io_out_bits_addr                 (io_replay_bits_addr),
    .io_out_bits_is_hella             (io_replay_bits_is_hella),
    .io_out_bits_way_en               (io_replay_bits_way_en),
    .io_out_bits_sdq_id               (_replay_arb_io_out_bits_sdq_id)
  );
  Arbiter_9 resp_arb (	// mshrs.scala:603:30
    .io_in_0_valid                    (_mshrs_0_io_resp_valid),	// mshrs.scala:620:22
    .io_in_0_bits_uop_uopc            (_mshrs_0_io_resp_bits_uop_uopc),	// mshrs.scala:620:22
    .io_in_0_bits_uop_inst            (_mshrs_0_io_resp_bits_uop_inst),	// mshrs.scala:620:22
    .io_in_0_bits_uop_debug_inst      (_mshrs_0_io_resp_bits_uop_debug_inst),	// mshrs.scala:620:22
    .io_in_0_bits_uop_is_rvc          (_mshrs_0_io_resp_bits_uop_is_rvc),	// mshrs.scala:620:22
    .io_in_0_bits_uop_debug_pc        (_mshrs_0_io_resp_bits_uop_debug_pc),	// mshrs.scala:620:22
    .io_in_0_bits_uop_iq_type         (_mshrs_0_io_resp_bits_uop_iq_type),	// mshrs.scala:620:22
    .io_in_0_bits_uop_fu_code         (_mshrs_0_io_resp_bits_uop_fu_code),	// mshrs.scala:620:22
    .io_in_0_bits_uop_ctrl_br_type    (_mshrs_0_io_resp_bits_uop_ctrl_br_type),	// mshrs.scala:620:22
    .io_in_0_bits_uop_ctrl_op1_sel    (_mshrs_0_io_resp_bits_uop_ctrl_op1_sel),	// mshrs.scala:620:22
    .io_in_0_bits_uop_ctrl_op2_sel    (_mshrs_0_io_resp_bits_uop_ctrl_op2_sel),	// mshrs.scala:620:22
    .io_in_0_bits_uop_ctrl_imm_sel    (_mshrs_0_io_resp_bits_uop_ctrl_imm_sel),	// mshrs.scala:620:22
    .io_in_0_bits_uop_ctrl_op_fcn     (_mshrs_0_io_resp_bits_uop_ctrl_op_fcn),	// mshrs.scala:620:22
    .io_in_0_bits_uop_ctrl_fcn_dw     (_mshrs_0_io_resp_bits_uop_ctrl_fcn_dw),	// mshrs.scala:620:22
    .io_in_0_bits_uop_ctrl_csr_cmd    (_mshrs_0_io_resp_bits_uop_ctrl_csr_cmd),	// mshrs.scala:620:22
    .io_in_0_bits_uop_ctrl_is_load    (_mshrs_0_io_resp_bits_uop_ctrl_is_load),	// mshrs.scala:620:22
    .io_in_0_bits_uop_ctrl_is_sta     (_mshrs_0_io_resp_bits_uop_ctrl_is_sta),	// mshrs.scala:620:22
    .io_in_0_bits_uop_ctrl_is_std     (_mshrs_0_io_resp_bits_uop_ctrl_is_std),	// mshrs.scala:620:22
    .io_in_0_bits_uop_iw_state        (_mshrs_0_io_resp_bits_uop_iw_state),	// mshrs.scala:620:22
    .io_in_0_bits_uop_iw_p1_poisoned  (_mshrs_0_io_resp_bits_uop_iw_p1_poisoned),	// mshrs.scala:620:22
    .io_in_0_bits_uop_iw_p2_poisoned  (_mshrs_0_io_resp_bits_uop_iw_p2_poisoned),	// mshrs.scala:620:22
    .io_in_0_bits_uop_is_br           (_mshrs_0_io_resp_bits_uop_is_br),	// mshrs.scala:620:22
    .io_in_0_bits_uop_is_jalr         (_mshrs_0_io_resp_bits_uop_is_jalr),	// mshrs.scala:620:22
    .io_in_0_bits_uop_is_jal          (_mshrs_0_io_resp_bits_uop_is_jal),	// mshrs.scala:620:22
    .io_in_0_bits_uop_is_sfb          (_mshrs_0_io_resp_bits_uop_is_sfb),	// mshrs.scala:620:22
    .io_in_0_bits_uop_br_mask         (_mshrs_0_io_resp_bits_uop_br_mask),	// mshrs.scala:620:22
    .io_in_0_bits_uop_br_tag          (_mshrs_0_io_resp_bits_uop_br_tag),	// mshrs.scala:620:22
    .io_in_0_bits_uop_ftq_idx         (_mshrs_0_io_resp_bits_uop_ftq_idx),	// mshrs.scala:620:22
    .io_in_0_bits_uop_edge_inst       (_mshrs_0_io_resp_bits_uop_edge_inst),	// mshrs.scala:620:22
    .io_in_0_bits_uop_pc_lob          (_mshrs_0_io_resp_bits_uop_pc_lob),	// mshrs.scala:620:22
    .io_in_0_bits_uop_taken           (_mshrs_0_io_resp_bits_uop_taken),	// mshrs.scala:620:22
    .io_in_0_bits_uop_imm_packed      (_mshrs_0_io_resp_bits_uop_imm_packed),	// mshrs.scala:620:22
    .io_in_0_bits_uop_csr_addr        (_mshrs_0_io_resp_bits_uop_csr_addr),	// mshrs.scala:620:22
    .io_in_0_bits_uop_rob_idx         (_mshrs_0_io_resp_bits_uop_rob_idx),	// mshrs.scala:620:22
    .io_in_0_bits_uop_ldq_idx         (_mshrs_0_io_resp_bits_uop_ldq_idx),	// mshrs.scala:620:22
    .io_in_0_bits_uop_stq_idx         (_mshrs_0_io_resp_bits_uop_stq_idx),	// mshrs.scala:620:22
    .io_in_0_bits_uop_rxq_idx         (_mshrs_0_io_resp_bits_uop_rxq_idx),	// mshrs.scala:620:22
    .io_in_0_bits_uop_pdst            (_mshrs_0_io_resp_bits_uop_pdst),	// mshrs.scala:620:22
    .io_in_0_bits_uop_prs1            (_mshrs_0_io_resp_bits_uop_prs1),	// mshrs.scala:620:22
    .io_in_0_bits_uop_prs2            (_mshrs_0_io_resp_bits_uop_prs2),	// mshrs.scala:620:22
    .io_in_0_bits_uop_prs3            (_mshrs_0_io_resp_bits_uop_prs3),	// mshrs.scala:620:22
    .io_in_0_bits_uop_ppred           (_mshrs_0_io_resp_bits_uop_ppred),	// mshrs.scala:620:22
    .io_in_0_bits_uop_prs1_busy       (_mshrs_0_io_resp_bits_uop_prs1_busy),	// mshrs.scala:620:22
    .io_in_0_bits_uop_prs2_busy       (_mshrs_0_io_resp_bits_uop_prs2_busy),	// mshrs.scala:620:22
    .io_in_0_bits_uop_prs3_busy       (_mshrs_0_io_resp_bits_uop_prs3_busy),	// mshrs.scala:620:22
    .io_in_0_bits_uop_ppred_busy      (_mshrs_0_io_resp_bits_uop_ppred_busy),	// mshrs.scala:620:22
    .io_in_0_bits_uop_stale_pdst      (_mshrs_0_io_resp_bits_uop_stale_pdst),	// mshrs.scala:620:22
    .io_in_0_bits_uop_exception       (_mshrs_0_io_resp_bits_uop_exception),	// mshrs.scala:620:22
    .io_in_0_bits_uop_exc_cause       (_mshrs_0_io_resp_bits_uop_exc_cause),	// mshrs.scala:620:22
    .io_in_0_bits_uop_bypassable      (_mshrs_0_io_resp_bits_uop_bypassable),	// mshrs.scala:620:22
    .io_in_0_bits_uop_mem_cmd         (_mshrs_0_io_resp_bits_uop_mem_cmd),	// mshrs.scala:620:22
    .io_in_0_bits_uop_mem_size        (_mshrs_0_io_resp_bits_uop_mem_size),	// mshrs.scala:620:22
    .io_in_0_bits_uop_mem_signed      (_mshrs_0_io_resp_bits_uop_mem_signed),	// mshrs.scala:620:22
    .io_in_0_bits_uop_is_fence        (_mshrs_0_io_resp_bits_uop_is_fence),	// mshrs.scala:620:22
    .io_in_0_bits_uop_is_fencei       (_mshrs_0_io_resp_bits_uop_is_fencei),	// mshrs.scala:620:22
    .io_in_0_bits_uop_is_amo          (_mshrs_0_io_resp_bits_uop_is_amo),	// mshrs.scala:620:22
    .io_in_0_bits_uop_uses_ldq        (_mshrs_0_io_resp_bits_uop_uses_ldq),	// mshrs.scala:620:22
    .io_in_0_bits_uop_uses_stq        (_mshrs_0_io_resp_bits_uop_uses_stq),	// mshrs.scala:620:22
    .io_in_0_bits_uop_is_sys_pc2epc   (_mshrs_0_io_resp_bits_uop_is_sys_pc2epc),	// mshrs.scala:620:22
    .io_in_0_bits_uop_is_unique       (_mshrs_0_io_resp_bits_uop_is_unique),	// mshrs.scala:620:22
    .io_in_0_bits_uop_flush_on_commit (_mshrs_0_io_resp_bits_uop_flush_on_commit),	// mshrs.scala:620:22
    .io_in_0_bits_uop_ldst_is_rs1     (_mshrs_0_io_resp_bits_uop_ldst_is_rs1),	// mshrs.scala:620:22
    .io_in_0_bits_uop_ldst            (_mshrs_0_io_resp_bits_uop_ldst),	// mshrs.scala:620:22
    .io_in_0_bits_uop_lrs1            (_mshrs_0_io_resp_bits_uop_lrs1),	// mshrs.scala:620:22
    .io_in_0_bits_uop_lrs2            (_mshrs_0_io_resp_bits_uop_lrs2),	// mshrs.scala:620:22
    .io_in_0_bits_uop_lrs3            (_mshrs_0_io_resp_bits_uop_lrs3),	// mshrs.scala:620:22
    .io_in_0_bits_uop_ldst_val        (_mshrs_0_io_resp_bits_uop_ldst_val),	// mshrs.scala:620:22
    .io_in_0_bits_uop_dst_rtype       (_mshrs_0_io_resp_bits_uop_dst_rtype),	// mshrs.scala:620:22
    .io_in_0_bits_uop_lrs1_rtype      (_mshrs_0_io_resp_bits_uop_lrs1_rtype),	// mshrs.scala:620:22
    .io_in_0_bits_uop_lrs2_rtype      (_mshrs_0_io_resp_bits_uop_lrs2_rtype),	// mshrs.scala:620:22
    .io_in_0_bits_uop_frs3_en         (_mshrs_0_io_resp_bits_uop_frs3_en),	// mshrs.scala:620:22
    .io_in_0_bits_uop_fp_val          (_mshrs_0_io_resp_bits_uop_fp_val),	// mshrs.scala:620:22
    .io_in_0_bits_uop_fp_single       (_mshrs_0_io_resp_bits_uop_fp_single),	// mshrs.scala:620:22
    .io_in_0_bits_uop_xcpt_pf_if      (_mshrs_0_io_resp_bits_uop_xcpt_pf_if),	// mshrs.scala:620:22
    .io_in_0_bits_uop_xcpt_ae_if      (_mshrs_0_io_resp_bits_uop_xcpt_ae_if),	// mshrs.scala:620:22
    .io_in_0_bits_uop_xcpt_ma_if      (_mshrs_0_io_resp_bits_uop_xcpt_ma_if),	// mshrs.scala:620:22
    .io_in_0_bits_uop_bp_debug_if     (_mshrs_0_io_resp_bits_uop_bp_debug_if),	// mshrs.scala:620:22
    .io_in_0_bits_uop_bp_xcpt_if      (_mshrs_0_io_resp_bits_uop_bp_xcpt_if),	// mshrs.scala:620:22
    .io_in_0_bits_uop_debug_fsrc      (_mshrs_0_io_resp_bits_uop_debug_fsrc),	// mshrs.scala:620:22
    .io_in_0_bits_uop_debug_tsrc      (_mshrs_0_io_resp_bits_uop_debug_tsrc),	// mshrs.scala:620:22
    .io_in_0_bits_data                (_mshrs_0_io_resp_bits_data),	// mshrs.scala:620:22
    .io_in_0_bits_is_hella            (_mshrs_0_io_resp_bits_is_hella),	// mshrs.scala:620:22
    .io_in_1_valid                    (_mshrs_1_io_resp_valid),	// mshrs.scala:620:22
    .io_in_1_bits_uop_uopc            (_mshrs_1_io_resp_bits_uop_uopc),	// mshrs.scala:620:22
    .io_in_1_bits_uop_inst            (_mshrs_1_io_resp_bits_uop_inst),	// mshrs.scala:620:22
    .io_in_1_bits_uop_debug_inst      (_mshrs_1_io_resp_bits_uop_debug_inst),	// mshrs.scala:620:22
    .io_in_1_bits_uop_is_rvc          (_mshrs_1_io_resp_bits_uop_is_rvc),	// mshrs.scala:620:22
    .io_in_1_bits_uop_debug_pc        (_mshrs_1_io_resp_bits_uop_debug_pc),	// mshrs.scala:620:22
    .io_in_1_bits_uop_iq_type         (_mshrs_1_io_resp_bits_uop_iq_type),	// mshrs.scala:620:22
    .io_in_1_bits_uop_fu_code         (_mshrs_1_io_resp_bits_uop_fu_code),	// mshrs.scala:620:22
    .io_in_1_bits_uop_ctrl_br_type    (_mshrs_1_io_resp_bits_uop_ctrl_br_type),	// mshrs.scala:620:22
    .io_in_1_bits_uop_ctrl_op1_sel    (_mshrs_1_io_resp_bits_uop_ctrl_op1_sel),	// mshrs.scala:620:22
    .io_in_1_bits_uop_ctrl_op2_sel    (_mshrs_1_io_resp_bits_uop_ctrl_op2_sel),	// mshrs.scala:620:22
    .io_in_1_bits_uop_ctrl_imm_sel    (_mshrs_1_io_resp_bits_uop_ctrl_imm_sel),	// mshrs.scala:620:22
    .io_in_1_bits_uop_ctrl_op_fcn     (_mshrs_1_io_resp_bits_uop_ctrl_op_fcn),	// mshrs.scala:620:22
    .io_in_1_bits_uop_ctrl_fcn_dw     (_mshrs_1_io_resp_bits_uop_ctrl_fcn_dw),	// mshrs.scala:620:22
    .io_in_1_bits_uop_ctrl_csr_cmd    (_mshrs_1_io_resp_bits_uop_ctrl_csr_cmd),	// mshrs.scala:620:22
    .io_in_1_bits_uop_ctrl_is_load    (_mshrs_1_io_resp_bits_uop_ctrl_is_load),	// mshrs.scala:620:22
    .io_in_1_bits_uop_ctrl_is_sta     (_mshrs_1_io_resp_bits_uop_ctrl_is_sta),	// mshrs.scala:620:22
    .io_in_1_bits_uop_ctrl_is_std     (_mshrs_1_io_resp_bits_uop_ctrl_is_std),	// mshrs.scala:620:22
    .io_in_1_bits_uop_iw_state        (_mshrs_1_io_resp_bits_uop_iw_state),	// mshrs.scala:620:22
    .io_in_1_bits_uop_iw_p1_poisoned  (_mshrs_1_io_resp_bits_uop_iw_p1_poisoned),	// mshrs.scala:620:22
    .io_in_1_bits_uop_iw_p2_poisoned  (_mshrs_1_io_resp_bits_uop_iw_p2_poisoned),	// mshrs.scala:620:22
    .io_in_1_bits_uop_is_br           (_mshrs_1_io_resp_bits_uop_is_br),	// mshrs.scala:620:22
    .io_in_1_bits_uop_is_jalr         (_mshrs_1_io_resp_bits_uop_is_jalr),	// mshrs.scala:620:22
    .io_in_1_bits_uop_is_jal          (_mshrs_1_io_resp_bits_uop_is_jal),	// mshrs.scala:620:22
    .io_in_1_bits_uop_is_sfb          (_mshrs_1_io_resp_bits_uop_is_sfb),	// mshrs.scala:620:22
    .io_in_1_bits_uop_br_mask         (_mshrs_1_io_resp_bits_uop_br_mask),	// mshrs.scala:620:22
    .io_in_1_bits_uop_br_tag          (_mshrs_1_io_resp_bits_uop_br_tag),	// mshrs.scala:620:22
    .io_in_1_bits_uop_ftq_idx         (_mshrs_1_io_resp_bits_uop_ftq_idx),	// mshrs.scala:620:22
    .io_in_1_bits_uop_edge_inst       (_mshrs_1_io_resp_bits_uop_edge_inst),	// mshrs.scala:620:22
    .io_in_1_bits_uop_pc_lob          (_mshrs_1_io_resp_bits_uop_pc_lob),	// mshrs.scala:620:22
    .io_in_1_bits_uop_taken           (_mshrs_1_io_resp_bits_uop_taken),	// mshrs.scala:620:22
    .io_in_1_bits_uop_imm_packed      (_mshrs_1_io_resp_bits_uop_imm_packed),	// mshrs.scala:620:22
    .io_in_1_bits_uop_csr_addr        (_mshrs_1_io_resp_bits_uop_csr_addr),	// mshrs.scala:620:22
    .io_in_1_bits_uop_rob_idx         (_mshrs_1_io_resp_bits_uop_rob_idx),	// mshrs.scala:620:22
    .io_in_1_bits_uop_ldq_idx         (_mshrs_1_io_resp_bits_uop_ldq_idx),	// mshrs.scala:620:22
    .io_in_1_bits_uop_stq_idx         (_mshrs_1_io_resp_bits_uop_stq_idx),	// mshrs.scala:620:22
    .io_in_1_bits_uop_rxq_idx         (_mshrs_1_io_resp_bits_uop_rxq_idx),	// mshrs.scala:620:22
    .io_in_1_bits_uop_pdst            (_mshrs_1_io_resp_bits_uop_pdst),	// mshrs.scala:620:22
    .io_in_1_bits_uop_prs1            (_mshrs_1_io_resp_bits_uop_prs1),	// mshrs.scala:620:22
    .io_in_1_bits_uop_prs2            (_mshrs_1_io_resp_bits_uop_prs2),	// mshrs.scala:620:22
    .io_in_1_bits_uop_prs3            (_mshrs_1_io_resp_bits_uop_prs3),	// mshrs.scala:620:22
    .io_in_1_bits_uop_ppred           (_mshrs_1_io_resp_bits_uop_ppred),	// mshrs.scala:620:22
    .io_in_1_bits_uop_prs1_busy       (_mshrs_1_io_resp_bits_uop_prs1_busy),	// mshrs.scala:620:22
    .io_in_1_bits_uop_prs2_busy       (_mshrs_1_io_resp_bits_uop_prs2_busy),	// mshrs.scala:620:22
    .io_in_1_bits_uop_prs3_busy       (_mshrs_1_io_resp_bits_uop_prs3_busy),	// mshrs.scala:620:22
    .io_in_1_bits_uop_ppred_busy      (_mshrs_1_io_resp_bits_uop_ppred_busy),	// mshrs.scala:620:22
    .io_in_1_bits_uop_stale_pdst      (_mshrs_1_io_resp_bits_uop_stale_pdst),	// mshrs.scala:620:22
    .io_in_1_bits_uop_exception       (_mshrs_1_io_resp_bits_uop_exception),	// mshrs.scala:620:22
    .io_in_1_bits_uop_exc_cause       (_mshrs_1_io_resp_bits_uop_exc_cause),	// mshrs.scala:620:22
    .io_in_1_bits_uop_bypassable      (_mshrs_1_io_resp_bits_uop_bypassable),	// mshrs.scala:620:22
    .io_in_1_bits_uop_mem_cmd         (_mshrs_1_io_resp_bits_uop_mem_cmd),	// mshrs.scala:620:22
    .io_in_1_bits_uop_mem_size        (_mshrs_1_io_resp_bits_uop_mem_size),	// mshrs.scala:620:22
    .io_in_1_bits_uop_mem_signed      (_mshrs_1_io_resp_bits_uop_mem_signed),	// mshrs.scala:620:22
    .io_in_1_bits_uop_is_fence        (_mshrs_1_io_resp_bits_uop_is_fence),	// mshrs.scala:620:22
    .io_in_1_bits_uop_is_fencei       (_mshrs_1_io_resp_bits_uop_is_fencei),	// mshrs.scala:620:22
    .io_in_1_bits_uop_is_amo          (_mshrs_1_io_resp_bits_uop_is_amo),	// mshrs.scala:620:22
    .io_in_1_bits_uop_uses_ldq        (_mshrs_1_io_resp_bits_uop_uses_ldq),	// mshrs.scala:620:22
    .io_in_1_bits_uop_uses_stq        (_mshrs_1_io_resp_bits_uop_uses_stq),	// mshrs.scala:620:22
    .io_in_1_bits_uop_is_sys_pc2epc   (_mshrs_1_io_resp_bits_uop_is_sys_pc2epc),	// mshrs.scala:620:22
    .io_in_1_bits_uop_is_unique       (_mshrs_1_io_resp_bits_uop_is_unique),	// mshrs.scala:620:22
    .io_in_1_bits_uop_flush_on_commit (_mshrs_1_io_resp_bits_uop_flush_on_commit),	// mshrs.scala:620:22
    .io_in_1_bits_uop_ldst_is_rs1     (_mshrs_1_io_resp_bits_uop_ldst_is_rs1),	// mshrs.scala:620:22
    .io_in_1_bits_uop_ldst            (_mshrs_1_io_resp_bits_uop_ldst),	// mshrs.scala:620:22
    .io_in_1_bits_uop_lrs1            (_mshrs_1_io_resp_bits_uop_lrs1),	// mshrs.scala:620:22
    .io_in_1_bits_uop_lrs2            (_mshrs_1_io_resp_bits_uop_lrs2),	// mshrs.scala:620:22
    .io_in_1_bits_uop_lrs3            (_mshrs_1_io_resp_bits_uop_lrs3),	// mshrs.scala:620:22
    .io_in_1_bits_uop_ldst_val        (_mshrs_1_io_resp_bits_uop_ldst_val),	// mshrs.scala:620:22
    .io_in_1_bits_uop_dst_rtype       (_mshrs_1_io_resp_bits_uop_dst_rtype),	// mshrs.scala:620:22
    .io_in_1_bits_uop_lrs1_rtype      (_mshrs_1_io_resp_bits_uop_lrs1_rtype),	// mshrs.scala:620:22
    .io_in_1_bits_uop_lrs2_rtype      (_mshrs_1_io_resp_bits_uop_lrs2_rtype),	// mshrs.scala:620:22
    .io_in_1_bits_uop_frs3_en         (_mshrs_1_io_resp_bits_uop_frs3_en),	// mshrs.scala:620:22
    .io_in_1_bits_uop_fp_val          (_mshrs_1_io_resp_bits_uop_fp_val),	// mshrs.scala:620:22
    .io_in_1_bits_uop_fp_single       (_mshrs_1_io_resp_bits_uop_fp_single),	// mshrs.scala:620:22
    .io_in_1_bits_uop_xcpt_pf_if      (_mshrs_1_io_resp_bits_uop_xcpt_pf_if),	// mshrs.scala:620:22
    .io_in_1_bits_uop_xcpt_ae_if      (_mshrs_1_io_resp_bits_uop_xcpt_ae_if),	// mshrs.scala:620:22
    .io_in_1_bits_uop_xcpt_ma_if      (_mshrs_1_io_resp_bits_uop_xcpt_ma_if),	// mshrs.scala:620:22
    .io_in_1_bits_uop_bp_debug_if     (_mshrs_1_io_resp_bits_uop_bp_debug_if),	// mshrs.scala:620:22
    .io_in_1_bits_uop_bp_xcpt_if      (_mshrs_1_io_resp_bits_uop_bp_xcpt_if),	// mshrs.scala:620:22
    .io_in_1_bits_uop_debug_fsrc      (_mshrs_1_io_resp_bits_uop_debug_fsrc),	// mshrs.scala:620:22
    .io_in_1_bits_uop_debug_tsrc      (_mshrs_1_io_resp_bits_uop_debug_tsrc),	// mshrs.scala:620:22
    .io_in_1_bits_data                (_mshrs_1_io_resp_bits_data),	// mshrs.scala:620:22
    .io_in_1_bits_is_hella            (_mshrs_1_io_resp_bits_is_hella),	// mshrs.scala:620:22
    .io_in_2_valid                    (_mshrs_2_io_resp_valid),	// mshrs.scala:620:22
    .io_in_2_bits_uop_uopc            (_mshrs_2_io_resp_bits_uop_uopc),	// mshrs.scala:620:22
    .io_in_2_bits_uop_inst            (_mshrs_2_io_resp_bits_uop_inst),	// mshrs.scala:620:22
    .io_in_2_bits_uop_debug_inst      (_mshrs_2_io_resp_bits_uop_debug_inst),	// mshrs.scala:620:22
    .io_in_2_bits_uop_is_rvc          (_mshrs_2_io_resp_bits_uop_is_rvc),	// mshrs.scala:620:22
    .io_in_2_bits_uop_debug_pc        (_mshrs_2_io_resp_bits_uop_debug_pc),	// mshrs.scala:620:22
    .io_in_2_bits_uop_iq_type         (_mshrs_2_io_resp_bits_uop_iq_type),	// mshrs.scala:620:22
    .io_in_2_bits_uop_fu_code         (_mshrs_2_io_resp_bits_uop_fu_code),	// mshrs.scala:620:22
    .io_in_2_bits_uop_ctrl_br_type    (_mshrs_2_io_resp_bits_uop_ctrl_br_type),	// mshrs.scala:620:22
    .io_in_2_bits_uop_ctrl_op1_sel    (_mshrs_2_io_resp_bits_uop_ctrl_op1_sel),	// mshrs.scala:620:22
    .io_in_2_bits_uop_ctrl_op2_sel    (_mshrs_2_io_resp_bits_uop_ctrl_op2_sel),	// mshrs.scala:620:22
    .io_in_2_bits_uop_ctrl_imm_sel    (_mshrs_2_io_resp_bits_uop_ctrl_imm_sel),	// mshrs.scala:620:22
    .io_in_2_bits_uop_ctrl_op_fcn     (_mshrs_2_io_resp_bits_uop_ctrl_op_fcn),	// mshrs.scala:620:22
    .io_in_2_bits_uop_ctrl_fcn_dw     (_mshrs_2_io_resp_bits_uop_ctrl_fcn_dw),	// mshrs.scala:620:22
    .io_in_2_bits_uop_ctrl_csr_cmd    (_mshrs_2_io_resp_bits_uop_ctrl_csr_cmd),	// mshrs.scala:620:22
    .io_in_2_bits_uop_ctrl_is_load    (_mshrs_2_io_resp_bits_uop_ctrl_is_load),	// mshrs.scala:620:22
    .io_in_2_bits_uop_ctrl_is_sta     (_mshrs_2_io_resp_bits_uop_ctrl_is_sta),	// mshrs.scala:620:22
    .io_in_2_bits_uop_ctrl_is_std     (_mshrs_2_io_resp_bits_uop_ctrl_is_std),	// mshrs.scala:620:22
    .io_in_2_bits_uop_iw_state        (_mshrs_2_io_resp_bits_uop_iw_state),	// mshrs.scala:620:22
    .io_in_2_bits_uop_iw_p1_poisoned  (_mshrs_2_io_resp_bits_uop_iw_p1_poisoned),	// mshrs.scala:620:22
    .io_in_2_bits_uop_iw_p2_poisoned  (_mshrs_2_io_resp_bits_uop_iw_p2_poisoned),	// mshrs.scala:620:22
    .io_in_2_bits_uop_is_br           (_mshrs_2_io_resp_bits_uop_is_br),	// mshrs.scala:620:22
    .io_in_2_bits_uop_is_jalr         (_mshrs_2_io_resp_bits_uop_is_jalr),	// mshrs.scala:620:22
    .io_in_2_bits_uop_is_jal          (_mshrs_2_io_resp_bits_uop_is_jal),	// mshrs.scala:620:22
    .io_in_2_bits_uop_is_sfb          (_mshrs_2_io_resp_bits_uop_is_sfb),	// mshrs.scala:620:22
    .io_in_2_bits_uop_br_mask         (_mshrs_2_io_resp_bits_uop_br_mask),	// mshrs.scala:620:22
    .io_in_2_bits_uop_br_tag          (_mshrs_2_io_resp_bits_uop_br_tag),	// mshrs.scala:620:22
    .io_in_2_bits_uop_ftq_idx         (_mshrs_2_io_resp_bits_uop_ftq_idx),	// mshrs.scala:620:22
    .io_in_2_bits_uop_edge_inst       (_mshrs_2_io_resp_bits_uop_edge_inst),	// mshrs.scala:620:22
    .io_in_2_bits_uop_pc_lob          (_mshrs_2_io_resp_bits_uop_pc_lob),	// mshrs.scala:620:22
    .io_in_2_bits_uop_taken           (_mshrs_2_io_resp_bits_uop_taken),	// mshrs.scala:620:22
    .io_in_2_bits_uop_imm_packed      (_mshrs_2_io_resp_bits_uop_imm_packed),	// mshrs.scala:620:22
    .io_in_2_bits_uop_csr_addr        (_mshrs_2_io_resp_bits_uop_csr_addr),	// mshrs.scala:620:22
    .io_in_2_bits_uop_rob_idx         (_mshrs_2_io_resp_bits_uop_rob_idx),	// mshrs.scala:620:22
    .io_in_2_bits_uop_ldq_idx         (_mshrs_2_io_resp_bits_uop_ldq_idx),	// mshrs.scala:620:22
    .io_in_2_bits_uop_stq_idx         (_mshrs_2_io_resp_bits_uop_stq_idx),	// mshrs.scala:620:22
    .io_in_2_bits_uop_rxq_idx         (_mshrs_2_io_resp_bits_uop_rxq_idx),	// mshrs.scala:620:22
    .io_in_2_bits_uop_pdst            (_mshrs_2_io_resp_bits_uop_pdst),	// mshrs.scala:620:22
    .io_in_2_bits_uop_prs1            (_mshrs_2_io_resp_bits_uop_prs1),	// mshrs.scala:620:22
    .io_in_2_bits_uop_prs2            (_mshrs_2_io_resp_bits_uop_prs2),	// mshrs.scala:620:22
    .io_in_2_bits_uop_prs3            (_mshrs_2_io_resp_bits_uop_prs3),	// mshrs.scala:620:22
    .io_in_2_bits_uop_ppred           (_mshrs_2_io_resp_bits_uop_ppred),	// mshrs.scala:620:22
    .io_in_2_bits_uop_prs1_busy       (_mshrs_2_io_resp_bits_uop_prs1_busy),	// mshrs.scala:620:22
    .io_in_2_bits_uop_prs2_busy       (_mshrs_2_io_resp_bits_uop_prs2_busy),	// mshrs.scala:620:22
    .io_in_2_bits_uop_prs3_busy       (_mshrs_2_io_resp_bits_uop_prs3_busy),	// mshrs.scala:620:22
    .io_in_2_bits_uop_ppred_busy      (_mshrs_2_io_resp_bits_uop_ppred_busy),	// mshrs.scala:620:22
    .io_in_2_bits_uop_stale_pdst      (_mshrs_2_io_resp_bits_uop_stale_pdst),	// mshrs.scala:620:22
    .io_in_2_bits_uop_exception       (_mshrs_2_io_resp_bits_uop_exception),	// mshrs.scala:620:22
    .io_in_2_bits_uop_exc_cause       (_mshrs_2_io_resp_bits_uop_exc_cause),	// mshrs.scala:620:22
    .io_in_2_bits_uop_bypassable      (_mshrs_2_io_resp_bits_uop_bypassable),	// mshrs.scala:620:22
    .io_in_2_bits_uop_mem_cmd         (_mshrs_2_io_resp_bits_uop_mem_cmd),	// mshrs.scala:620:22
    .io_in_2_bits_uop_mem_size        (_mshrs_2_io_resp_bits_uop_mem_size),	// mshrs.scala:620:22
    .io_in_2_bits_uop_mem_signed      (_mshrs_2_io_resp_bits_uop_mem_signed),	// mshrs.scala:620:22
    .io_in_2_bits_uop_is_fence        (_mshrs_2_io_resp_bits_uop_is_fence),	// mshrs.scala:620:22
    .io_in_2_bits_uop_is_fencei       (_mshrs_2_io_resp_bits_uop_is_fencei),	// mshrs.scala:620:22
    .io_in_2_bits_uop_is_amo          (_mshrs_2_io_resp_bits_uop_is_amo),	// mshrs.scala:620:22
    .io_in_2_bits_uop_uses_ldq        (_mshrs_2_io_resp_bits_uop_uses_ldq),	// mshrs.scala:620:22
    .io_in_2_bits_uop_uses_stq        (_mshrs_2_io_resp_bits_uop_uses_stq),	// mshrs.scala:620:22
    .io_in_2_bits_uop_is_sys_pc2epc   (_mshrs_2_io_resp_bits_uop_is_sys_pc2epc),	// mshrs.scala:620:22
    .io_in_2_bits_uop_is_unique       (_mshrs_2_io_resp_bits_uop_is_unique),	// mshrs.scala:620:22
    .io_in_2_bits_uop_flush_on_commit (_mshrs_2_io_resp_bits_uop_flush_on_commit),	// mshrs.scala:620:22
    .io_in_2_bits_uop_ldst_is_rs1     (_mshrs_2_io_resp_bits_uop_ldst_is_rs1),	// mshrs.scala:620:22
    .io_in_2_bits_uop_ldst            (_mshrs_2_io_resp_bits_uop_ldst),	// mshrs.scala:620:22
    .io_in_2_bits_uop_lrs1            (_mshrs_2_io_resp_bits_uop_lrs1),	// mshrs.scala:620:22
    .io_in_2_bits_uop_lrs2            (_mshrs_2_io_resp_bits_uop_lrs2),	// mshrs.scala:620:22
    .io_in_2_bits_uop_lrs3            (_mshrs_2_io_resp_bits_uop_lrs3),	// mshrs.scala:620:22
    .io_in_2_bits_uop_ldst_val        (_mshrs_2_io_resp_bits_uop_ldst_val),	// mshrs.scala:620:22
    .io_in_2_bits_uop_dst_rtype       (_mshrs_2_io_resp_bits_uop_dst_rtype),	// mshrs.scala:620:22
    .io_in_2_bits_uop_lrs1_rtype      (_mshrs_2_io_resp_bits_uop_lrs1_rtype),	// mshrs.scala:620:22
    .io_in_2_bits_uop_lrs2_rtype      (_mshrs_2_io_resp_bits_uop_lrs2_rtype),	// mshrs.scala:620:22
    .io_in_2_bits_uop_frs3_en         (_mshrs_2_io_resp_bits_uop_frs3_en),	// mshrs.scala:620:22
    .io_in_2_bits_uop_fp_val          (_mshrs_2_io_resp_bits_uop_fp_val),	// mshrs.scala:620:22
    .io_in_2_bits_uop_fp_single       (_mshrs_2_io_resp_bits_uop_fp_single),	// mshrs.scala:620:22
    .io_in_2_bits_uop_xcpt_pf_if      (_mshrs_2_io_resp_bits_uop_xcpt_pf_if),	// mshrs.scala:620:22
    .io_in_2_bits_uop_xcpt_ae_if      (_mshrs_2_io_resp_bits_uop_xcpt_ae_if),	// mshrs.scala:620:22
    .io_in_2_bits_uop_xcpt_ma_if      (_mshrs_2_io_resp_bits_uop_xcpt_ma_if),	// mshrs.scala:620:22
    .io_in_2_bits_uop_bp_debug_if     (_mshrs_2_io_resp_bits_uop_bp_debug_if),	// mshrs.scala:620:22
    .io_in_2_bits_uop_bp_xcpt_if      (_mshrs_2_io_resp_bits_uop_bp_xcpt_if),	// mshrs.scala:620:22
    .io_in_2_bits_uop_debug_fsrc      (_mshrs_2_io_resp_bits_uop_debug_fsrc),	// mshrs.scala:620:22
    .io_in_2_bits_uop_debug_tsrc      (_mshrs_2_io_resp_bits_uop_debug_tsrc),	// mshrs.scala:620:22
    .io_in_2_bits_data                (_mshrs_2_io_resp_bits_data),	// mshrs.scala:620:22
    .io_in_2_bits_is_hella            (_mshrs_2_io_resp_bits_is_hella),	// mshrs.scala:620:22
    .io_in_3_valid                    (_mshrs_3_io_resp_valid),	// mshrs.scala:620:22
    .io_in_3_bits_uop_uopc            (_mshrs_3_io_resp_bits_uop_uopc),	// mshrs.scala:620:22
    .io_in_3_bits_uop_inst            (_mshrs_3_io_resp_bits_uop_inst),	// mshrs.scala:620:22
    .io_in_3_bits_uop_debug_inst      (_mshrs_3_io_resp_bits_uop_debug_inst),	// mshrs.scala:620:22
    .io_in_3_bits_uop_is_rvc          (_mshrs_3_io_resp_bits_uop_is_rvc),	// mshrs.scala:620:22
    .io_in_3_bits_uop_debug_pc        (_mshrs_3_io_resp_bits_uop_debug_pc),	// mshrs.scala:620:22
    .io_in_3_bits_uop_iq_type         (_mshrs_3_io_resp_bits_uop_iq_type),	// mshrs.scala:620:22
    .io_in_3_bits_uop_fu_code         (_mshrs_3_io_resp_bits_uop_fu_code),	// mshrs.scala:620:22
    .io_in_3_bits_uop_ctrl_br_type    (_mshrs_3_io_resp_bits_uop_ctrl_br_type),	// mshrs.scala:620:22
    .io_in_3_bits_uop_ctrl_op1_sel    (_mshrs_3_io_resp_bits_uop_ctrl_op1_sel),	// mshrs.scala:620:22
    .io_in_3_bits_uop_ctrl_op2_sel    (_mshrs_3_io_resp_bits_uop_ctrl_op2_sel),	// mshrs.scala:620:22
    .io_in_3_bits_uop_ctrl_imm_sel    (_mshrs_3_io_resp_bits_uop_ctrl_imm_sel),	// mshrs.scala:620:22
    .io_in_3_bits_uop_ctrl_op_fcn     (_mshrs_3_io_resp_bits_uop_ctrl_op_fcn),	// mshrs.scala:620:22
    .io_in_3_bits_uop_ctrl_fcn_dw     (_mshrs_3_io_resp_bits_uop_ctrl_fcn_dw),	// mshrs.scala:620:22
    .io_in_3_bits_uop_ctrl_csr_cmd    (_mshrs_3_io_resp_bits_uop_ctrl_csr_cmd),	// mshrs.scala:620:22
    .io_in_3_bits_uop_ctrl_is_load    (_mshrs_3_io_resp_bits_uop_ctrl_is_load),	// mshrs.scala:620:22
    .io_in_3_bits_uop_ctrl_is_sta     (_mshrs_3_io_resp_bits_uop_ctrl_is_sta),	// mshrs.scala:620:22
    .io_in_3_bits_uop_ctrl_is_std     (_mshrs_3_io_resp_bits_uop_ctrl_is_std),	// mshrs.scala:620:22
    .io_in_3_bits_uop_iw_state        (_mshrs_3_io_resp_bits_uop_iw_state),	// mshrs.scala:620:22
    .io_in_3_bits_uop_iw_p1_poisoned  (_mshrs_3_io_resp_bits_uop_iw_p1_poisoned),	// mshrs.scala:620:22
    .io_in_3_bits_uop_iw_p2_poisoned  (_mshrs_3_io_resp_bits_uop_iw_p2_poisoned),	// mshrs.scala:620:22
    .io_in_3_bits_uop_is_br           (_mshrs_3_io_resp_bits_uop_is_br),	// mshrs.scala:620:22
    .io_in_3_bits_uop_is_jalr         (_mshrs_3_io_resp_bits_uop_is_jalr),	// mshrs.scala:620:22
    .io_in_3_bits_uop_is_jal          (_mshrs_3_io_resp_bits_uop_is_jal),	// mshrs.scala:620:22
    .io_in_3_bits_uop_is_sfb          (_mshrs_3_io_resp_bits_uop_is_sfb),	// mshrs.scala:620:22
    .io_in_3_bits_uop_br_mask         (_mshrs_3_io_resp_bits_uop_br_mask),	// mshrs.scala:620:22
    .io_in_3_bits_uop_br_tag          (_mshrs_3_io_resp_bits_uop_br_tag),	// mshrs.scala:620:22
    .io_in_3_bits_uop_ftq_idx         (_mshrs_3_io_resp_bits_uop_ftq_idx),	// mshrs.scala:620:22
    .io_in_3_bits_uop_edge_inst       (_mshrs_3_io_resp_bits_uop_edge_inst),	// mshrs.scala:620:22
    .io_in_3_bits_uop_pc_lob          (_mshrs_3_io_resp_bits_uop_pc_lob),	// mshrs.scala:620:22
    .io_in_3_bits_uop_taken           (_mshrs_3_io_resp_bits_uop_taken),	// mshrs.scala:620:22
    .io_in_3_bits_uop_imm_packed      (_mshrs_3_io_resp_bits_uop_imm_packed),	// mshrs.scala:620:22
    .io_in_3_bits_uop_csr_addr        (_mshrs_3_io_resp_bits_uop_csr_addr),	// mshrs.scala:620:22
    .io_in_3_bits_uop_rob_idx         (_mshrs_3_io_resp_bits_uop_rob_idx),	// mshrs.scala:620:22
    .io_in_3_bits_uop_ldq_idx         (_mshrs_3_io_resp_bits_uop_ldq_idx),	// mshrs.scala:620:22
    .io_in_3_bits_uop_stq_idx         (_mshrs_3_io_resp_bits_uop_stq_idx),	// mshrs.scala:620:22
    .io_in_3_bits_uop_rxq_idx         (_mshrs_3_io_resp_bits_uop_rxq_idx),	// mshrs.scala:620:22
    .io_in_3_bits_uop_pdst            (_mshrs_3_io_resp_bits_uop_pdst),	// mshrs.scala:620:22
    .io_in_3_bits_uop_prs1            (_mshrs_3_io_resp_bits_uop_prs1),	// mshrs.scala:620:22
    .io_in_3_bits_uop_prs2            (_mshrs_3_io_resp_bits_uop_prs2),	// mshrs.scala:620:22
    .io_in_3_bits_uop_prs3            (_mshrs_3_io_resp_bits_uop_prs3),	// mshrs.scala:620:22
    .io_in_3_bits_uop_ppred           (_mshrs_3_io_resp_bits_uop_ppred),	// mshrs.scala:620:22
    .io_in_3_bits_uop_prs1_busy       (_mshrs_3_io_resp_bits_uop_prs1_busy),	// mshrs.scala:620:22
    .io_in_3_bits_uop_prs2_busy       (_mshrs_3_io_resp_bits_uop_prs2_busy),	// mshrs.scala:620:22
    .io_in_3_bits_uop_prs3_busy       (_mshrs_3_io_resp_bits_uop_prs3_busy),	// mshrs.scala:620:22
    .io_in_3_bits_uop_ppred_busy      (_mshrs_3_io_resp_bits_uop_ppred_busy),	// mshrs.scala:620:22
    .io_in_3_bits_uop_stale_pdst      (_mshrs_3_io_resp_bits_uop_stale_pdst),	// mshrs.scala:620:22
    .io_in_3_bits_uop_exception       (_mshrs_3_io_resp_bits_uop_exception),	// mshrs.scala:620:22
    .io_in_3_bits_uop_exc_cause       (_mshrs_3_io_resp_bits_uop_exc_cause),	// mshrs.scala:620:22
    .io_in_3_bits_uop_bypassable      (_mshrs_3_io_resp_bits_uop_bypassable),	// mshrs.scala:620:22
    .io_in_3_bits_uop_mem_cmd         (_mshrs_3_io_resp_bits_uop_mem_cmd),	// mshrs.scala:620:22
    .io_in_3_bits_uop_mem_size        (_mshrs_3_io_resp_bits_uop_mem_size),	// mshrs.scala:620:22
    .io_in_3_bits_uop_mem_signed      (_mshrs_3_io_resp_bits_uop_mem_signed),	// mshrs.scala:620:22
    .io_in_3_bits_uop_is_fence        (_mshrs_3_io_resp_bits_uop_is_fence),	// mshrs.scala:620:22
    .io_in_3_bits_uop_is_fencei       (_mshrs_3_io_resp_bits_uop_is_fencei),	// mshrs.scala:620:22
    .io_in_3_bits_uop_is_amo          (_mshrs_3_io_resp_bits_uop_is_amo),	// mshrs.scala:620:22
    .io_in_3_bits_uop_uses_ldq        (_mshrs_3_io_resp_bits_uop_uses_ldq),	// mshrs.scala:620:22
    .io_in_3_bits_uop_uses_stq        (_mshrs_3_io_resp_bits_uop_uses_stq),	// mshrs.scala:620:22
    .io_in_3_bits_uop_is_sys_pc2epc   (_mshrs_3_io_resp_bits_uop_is_sys_pc2epc),	// mshrs.scala:620:22
    .io_in_3_bits_uop_is_unique       (_mshrs_3_io_resp_bits_uop_is_unique),	// mshrs.scala:620:22
    .io_in_3_bits_uop_flush_on_commit (_mshrs_3_io_resp_bits_uop_flush_on_commit),	// mshrs.scala:620:22
    .io_in_3_bits_uop_ldst_is_rs1     (_mshrs_3_io_resp_bits_uop_ldst_is_rs1),	// mshrs.scala:620:22
    .io_in_3_bits_uop_ldst            (_mshrs_3_io_resp_bits_uop_ldst),	// mshrs.scala:620:22
    .io_in_3_bits_uop_lrs1            (_mshrs_3_io_resp_bits_uop_lrs1),	// mshrs.scala:620:22
    .io_in_3_bits_uop_lrs2            (_mshrs_3_io_resp_bits_uop_lrs2),	// mshrs.scala:620:22
    .io_in_3_bits_uop_lrs3            (_mshrs_3_io_resp_bits_uop_lrs3),	// mshrs.scala:620:22
    .io_in_3_bits_uop_ldst_val        (_mshrs_3_io_resp_bits_uop_ldst_val),	// mshrs.scala:620:22
    .io_in_3_bits_uop_dst_rtype       (_mshrs_3_io_resp_bits_uop_dst_rtype),	// mshrs.scala:620:22
    .io_in_3_bits_uop_lrs1_rtype      (_mshrs_3_io_resp_bits_uop_lrs1_rtype),	// mshrs.scala:620:22
    .io_in_3_bits_uop_lrs2_rtype      (_mshrs_3_io_resp_bits_uop_lrs2_rtype),	// mshrs.scala:620:22
    .io_in_3_bits_uop_frs3_en         (_mshrs_3_io_resp_bits_uop_frs3_en),	// mshrs.scala:620:22
    .io_in_3_bits_uop_fp_val          (_mshrs_3_io_resp_bits_uop_fp_val),	// mshrs.scala:620:22
    .io_in_3_bits_uop_fp_single       (_mshrs_3_io_resp_bits_uop_fp_single),	// mshrs.scala:620:22
    .io_in_3_bits_uop_xcpt_pf_if      (_mshrs_3_io_resp_bits_uop_xcpt_pf_if),	// mshrs.scala:620:22
    .io_in_3_bits_uop_xcpt_ae_if      (_mshrs_3_io_resp_bits_uop_xcpt_ae_if),	// mshrs.scala:620:22
    .io_in_3_bits_uop_xcpt_ma_if      (_mshrs_3_io_resp_bits_uop_xcpt_ma_if),	// mshrs.scala:620:22
    .io_in_3_bits_uop_bp_debug_if     (_mshrs_3_io_resp_bits_uop_bp_debug_if),	// mshrs.scala:620:22
    .io_in_3_bits_uop_bp_xcpt_if      (_mshrs_3_io_resp_bits_uop_bp_xcpt_if),	// mshrs.scala:620:22
    .io_in_3_bits_uop_debug_fsrc      (_mshrs_3_io_resp_bits_uop_debug_fsrc),	// mshrs.scala:620:22
    .io_in_3_bits_uop_debug_tsrc      (_mshrs_3_io_resp_bits_uop_debug_tsrc),	// mshrs.scala:620:22
    .io_in_3_bits_data                (_mshrs_3_io_resp_bits_data),	// mshrs.scala:620:22
    .io_in_3_bits_is_hella            (_mshrs_3_io_resp_bits_is_hella),	// mshrs.scala:620:22
    .io_in_4_valid                    (_mshrs_4_io_resp_valid),	// mshrs.scala:620:22
    .io_in_4_bits_uop_uopc            (_mshrs_4_io_resp_bits_uop_uopc),	// mshrs.scala:620:22
    .io_in_4_bits_uop_inst            (_mshrs_4_io_resp_bits_uop_inst),	// mshrs.scala:620:22
    .io_in_4_bits_uop_debug_inst      (_mshrs_4_io_resp_bits_uop_debug_inst),	// mshrs.scala:620:22
    .io_in_4_bits_uop_is_rvc          (_mshrs_4_io_resp_bits_uop_is_rvc),	// mshrs.scala:620:22
    .io_in_4_bits_uop_debug_pc        (_mshrs_4_io_resp_bits_uop_debug_pc),	// mshrs.scala:620:22
    .io_in_4_bits_uop_iq_type         (_mshrs_4_io_resp_bits_uop_iq_type),	// mshrs.scala:620:22
    .io_in_4_bits_uop_fu_code         (_mshrs_4_io_resp_bits_uop_fu_code),	// mshrs.scala:620:22
    .io_in_4_bits_uop_ctrl_br_type    (_mshrs_4_io_resp_bits_uop_ctrl_br_type),	// mshrs.scala:620:22
    .io_in_4_bits_uop_ctrl_op1_sel    (_mshrs_4_io_resp_bits_uop_ctrl_op1_sel),	// mshrs.scala:620:22
    .io_in_4_bits_uop_ctrl_op2_sel    (_mshrs_4_io_resp_bits_uop_ctrl_op2_sel),	// mshrs.scala:620:22
    .io_in_4_bits_uop_ctrl_imm_sel    (_mshrs_4_io_resp_bits_uop_ctrl_imm_sel),	// mshrs.scala:620:22
    .io_in_4_bits_uop_ctrl_op_fcn     (_mshrs_4_io_resp_bits_uop_ctrl_op_fcn),	// mshrs.scala:620:22
    .io_in_4_bits_uop_ctrl_fcn_dw     (_mshrs_4_io_resp_bits_uop_ctrl_fcn_dw),	// mshrs.scala:620:22
    .io_in_4_bits_uop_ctrl_csr_cmd    (_mshrs_4_io_resp_bits_uop_ctrl_csr_cmd),	// mshrs.scala:620:22
    .io_in_4_bits_uop_ctrl_is_load    (_mshrs_4_io_resp_bits_uop_ctrl_is_load),	// mshrs.scala:620:22
    .io_in_4_bits_uop_ctrl_is_sta     (_mshrs_4_io_resp_bits_uop_ctrl_is_sta),	// mshrs.scala:620:22
    .io_in_4_bits_uop_ctrl_is_std     (_mshrs_4_io_resp_bits_uop_ctrl_is_std),	// mshrs.scala:620:22
    .io_in_4_bits_uop_iw_state        (_mshrs_4_io_resp_bits_uop_iw_state),	// mshrs.scala:620:22
    .io_in_4_bits_uop_iw_p1_poisoned  (_mshrs_4_io_resp_bits_uop_iw_p1_poisoned),	// mshrs.scala:620:22
    .io_in_4_bits_uop_iw_p2_poisoned  (_mshrs_4_io_resp_bits_uop_iw_p2_poisoned),	// mshrs.scala:620:22
    .io_in_4_bits_uop_is_br           (_mshrs_4_io_resp_bits_uop_is_br),	// mshrs.scala:620:22
    .io_in_4_bits_uop_is_jalr         (_mshrs_4_io_resp_bits_uop_is_jalr),	// mshrs.scala:620:22
    .io_in_4_bits_uop_is_jal          (_mshrs_4_io_resp_bits_uop_is_jal),	// mshrs.scala:620:22
    .io_in_4_bits_uop_is_sfb          (_mshrs_4_io_resp_bits_uop_is_sfb),	// mshrs.scala:620:22
    .io_in_4_bits_uop_br_mask         (_mshrs_4_io_resp_bits_uop_br_mask),	// mshrs.scala:620:22
    .io_in_4_bits_uop_br_tag          (_mshrs_4_io_resp_bits_uop_br_tag),	// mshrs.scala:620:22
    .io_in_4_bits_uop_ftq_idx         (_mshrs_4_io_resp_bits_uop_ftq_idx),	// mshrs.scala:620:22
    .io_in_4_bits_uop_edge_inst       (_mshrs_4_io_resp_bits_uop_edge_inst),	// mshrs.scala:620:22
    .io_in_4_bits_uop_pc_lob          (_mshrs_4_io_resp_bits_uop_pc_lob),	// mshrs.scala:620:22
    .io_in_4_bits_uop_taken           (_mshrs_4_io_resp_bits_uop_taken),	// mshrs.scala:620:22
    .io_in_4_bits_uop_imm_packed      (_mshrs_4_io_resp_bits_uop_imm_packed),	// mshrs.scala:620:22
    .io_in_4_bits_uop_csr_addr        (_mshrs_4_io_resp_bits_uop_csr_addr),	// mshrs.scala:620:22
    .io_in_4_bits_uop_rob_idx         (_mshrs_4_io_resp_bits_uop_rob_idx),	// mshrs.scala:620:22
    .io_in_4_bits_uop_ldq_idx         (_mshrs_4_io_resp_bits_uop_ldq_idx),	// mshrs.scala:620:22
    .io_in_4_bits_uop_stq_idx         (_mshrs_4_io_resp_bits_uop_stq_idx),	// mshrs.scala:620:22
    .io_in_4_bits_uop_rxq_idx         (_mshrs_4_io_resp_bits_uop_rxq_idx),	// mshrs.scala:620:22
    .io_in_4_bits_uop_pdst            (_mshrs_4_io_resp_bits_uop_pdst),	// mshrs.scala:620:22
    .io_in_4_bits_uop_prs1            (_mshrs_4_io_resp_bits_uop_prs1),	// mshrs.scala:620:22
    .io_in_4_bits_uop_prs2            (_mshrs_4_io_resp_bits_uop_prs2),	// mshrs.scala:620:22
    .io_in_4_bits_uop_prs3            (_mshrs_4_io_resp_bits_uop_prs3),	// mshrs.scala:620:22
    .io_in_4_bits_uop_ppred           (_mshrs_4_io_resp_bits_uop_ppred),	// mshrs.scala:620:22
    .io_in_4_bits_uop_prs1_busy       (_mshrs_4_io_resp_bits_uop_prs1_busy),	// mshrs.scala:620:22
    .io_in_4_bits_uop_prs2_busy       (_mshrs_4_io_resp_bits_uop_prs2_busy),	// mshrs.scala:620:22
    .io_in_4_bits_uop_prs3_busy       (_mshrs_4_io_resp_bits_uop_prs3_busy),	// mshrs.scala:620:22
    .io_in_4_bits_uop_ppred_busy      (_mshrs_4_io_resp_bits_uop_ppred_busy),	// mshrs.scala:620:22
    .io_in_4_bits_uop_stale_pdst      (_mshrs_4_io_resp_bits_uop_stale_pdst),	// mshrs.scala:620:22
    .io_in_4_bits_uop_exception       (_mshrs_4_io_resp_bits_uop_exception),	// mshrs.scala:620:22
    .io_in_4_bits_uop_exc_cause       (_mshrs_4_io_resp_bits_uop_exc_cause),	// mshrs.scala:620:22
    .io_in_4_bits_uop_bypassable      (_mshrs_4_io_resp_bits_uop_bypassable),	// mshrs.scala:620:22
    .io_in_4_bits_uop_mem_cmd         (_mshrs_4_io_resp_bits_uop_mem_cmd),	// mshrs.scala:620:22
    .io_in_4_bits_uop_mem_size        (_mshrs_4_io_resp_bits_uop_mem_size),	// mshrs.scala:620:22
    .io_in_4_bits_uop_mem_signed      (_mshrs_4_io_resp_bits_uop_mem_signed),	// mshrs.scala:620:22
    .io_in_4_bits_uop_is_fence        (_mshrs_4_io_resp_bits_uop_is_fence),	// mshrs.scala:620:22
    .io_in_4_bits_uop_is_fencei       (_mshrs_4_io_resp_bits_uop_is_fencei),	// mshrs.scala:620:22
    .io_in_4_bits_uop_is_amo          (_mshrs_4_io_resp_bits_uop_is_amo),	// mshrs.scala:620:22
    .io_in_4_bits_uop_uses_ldq        (_mshrs_4_io_resp_bits_uop_uses_ldq),	// mshrs.scala:620:22
    .io_in_4_bits_uop_uses_stq        (_mshrs_4_io_resp_bits_uop_uses_stq),	// mshrs.scala:620:22
    .io_in_4_bits_uop_is_sys_pc2epc   (_mshrs_4_io_resp_bits_uop_is_sys_pc2epc),	// mshrs.scala:620:22
    .io_in_4_bits_uop_is_unique       (_mshrs_4_io_resp_bits_uop_is_unique),	// mshrs.scala:620:22
    .io_in_4_bits_uop_flush_on_commit (_mshrs_4_io_resp_bits_uop_flush_on_commit),	// mshrs.scala:620:22
    .io_in_4_bits_uop_ldst_is_rs1     (_mshrs_4_io_resp_bits_uop_ldst_is_rs1),	// mshrs.scala:620:22
    .io_in_4_bits_uop_ldst            (_mshrs_4_io_resp_bits_uop_ldst),	// mshrs.scala:620:22
    .io_in_4_bits_uop_lrs1            (_mshrs_4_io_resp_bits_uop_lrs1),	// mshrs.scala:620:22
    .io_in_4_bits_uop_lrs2            (_mshrs_4_io_resp_bits_uop_lrs2),	// mshrs.scala:620:22
    .io_in_4_bits_uop_lrs3            (_mshrs_4_io_resp_bits_uop_lrs3),	// mshrs.scala:620:22
    .io_in_4_bits_uop_ldst_val        (_mshrs_4_io_resp_bits_uop_ldst_val),	// mshrs.scala:620:22
    .io_in_4_bits_uop_dst_rtype       (_mshrs_4_io_resp_bits_uop_dst_rtype),	// mshrs.scala:620:22
    .io_in_4_bits_uop_lrs1_rtype      (_mshrs_4_io_resp_bits_uop_lrs1_rtype),	// mshrs.scala:620:22
    .io_in_4_bits_uop_lrs2_rtype      (_mshrs_4_io_resp_bits_uop_lrs2_rtype),	// mshrs.scala:620:22
    .io_in_4_bits_uop_frs3_en         (_mshrs_4_io_resp_bits_uop_frs3_en),	// mshrs.scala:620:22
    .io_in_4_bits_uop_fp_val          (_mshrs_4_io_resp_bits_uop_fp_val),	// mshrs.scala:620:22
    .io_in_4_bits_uop_fp_single       (_mshrs_4_io_resp_bits_uop_fp_single),	// mshrs.scala:620:22
    .io_in_4_bits_uop_xcpt_pf_if      (_mshrs_4_io_resp_bits_uop_xcpt_pf_if),	// mshrs.scala:620:22
    .io_in_4_bits_uop_xcpt_ae_if      (_mshrs_4_io_resp_bits_uop_xcpt_ae_if),	// mshrs.scala:620:22
    .io_in_4_bits_uop_xcpt_ma_if      (_mshrs_4_io_resp_bits_uop_xcpt_ma_if),	// mshrs.scala:620:22
    .io_in_4_bits_uop_bp_debug_if     (_mshrs_4_io_resp_bits_uop_bp_debug_if),	// mshrs.scala:620:22
    .io_in_4_bits_uop_bp_xcpt_if      (_mshrs_4_io_resp_bits_uop_bp_xcpt_if),	// mshrs.scala:620:22
    .io_in_4_bits_uop_debug_fsrc      (_mshrs_4_io_resp_bits_uop_debug_fsrc),	// mshrs.scala:620:22
    .io_in_4_bits_uop_debug_tsrc      (_mshrs_4_io_resp_bits_uop_debug_tsrc),	// mshrs.scala:620:22
    .io_in_4_bits_data                (_mshrs_4_io_resp_bits_data),	// mshrs.scala:620:22
    .io_in_4_bits_is_hella            (_mshrs_4_io_resp_bits_is_hella),	// mshrs.scala:620:22
    .io_in_5_valid                    (_mshrs_5_io_resp_valid),	// mshrs.scala:620:22
    .io_in_5_bits_uop_uopc            (_mshrs_5_io_resp_bits_uop_uopc),	// mshrs.scala:620:22
    .io_in_5_bits_uop_inst            (_mshrs_5_io_resp_bits_uop_inst),	// mshrs.scala:620:22
    .io_in_5_bits_uop_debug_inst      (_mshrs_5_io_resp_bits_uop_debug_inst),	// mshrs.scala:620:22
    .io_in_5_bits_uop_is_rvc          (_mshrs_5_io_resp_bits_uop_is_rvc),	// mshrs.scala:620:22
    .io_in_5_bits_uop_debug_pc        (_mshrs_5_io_resp_bits_uop_debug_pc),	// mshrs.scala:620:22
    .io_in_5_bits_uop_iq_type         (_mshrs_5_io_resp_bits_uop_iq_type),	// mshrs.scala:620:22
    .io_in_5_bits_uop_fu_code         (_mshrs_5_io_resp_bits_uop_fu_code),	// mshrs.scala:620:22
    .io_in_5_bits_uop_ctrl_br_type    (_mshrs_5_io_resp_bits_uop_ctrl_br_type),	// mshrs.scala:620:22
    .io_in_5_bits_uop_ctrl_op1_sel    (_mshrs_5_io_resp_bits_uop_ctrl_op1_sel),	// mshrs.scala:620:22
    .io_in_5_bits_uop_ctrl_op2_sel    (_mshrs_5_io_resp_bits_uop_ctrl_op2_sel),	// mshrs.scala:620:22
    .io_in_5_bits_uop_ctrl_imm_sel    (_mshrs_5_io_resp_bits_uop_ctrl_imm_sel),	// mshrs.scala:620:22
    .io_in_5_bits_uop_ctrl_op_fcn     (_mshrs_5_io_resp_bits_uop_ctrl_op_fcn),	// mshrs.scala:620:22
    .io_in_5_bits_uop_ctrl_fcn_dw     (_mshrs_5_io_resp_bits_uop_ctrl_fcn_dw),	// mshrs.scala:620:22
    .io_in_5_bits_uop_ctrl_csr_cmd    (_mshrs_5_io_resp_bits_uop_ctrl_csr_cmd),	// mshrs.scala:620:22
    .io_in_5_bits_uop_ctrl_is_load    (_mshrs_5_io_resp_bits_uop_ctrl_is_load),	// mshrs.scala:620:22
    .io_in_5_bits_uop_ctrl_is_sta     (_mshrs_5_io_resp_bits_uop_ctrl_is_sta),	// mshrs.scala:620:22
    .io_in_5_bits_uop_ctrl_is_std     (_mshrs_5_io_resp_bits_uop_ctrl_is_std),	// mshrs.scala:620:22
    .io_in_5_bits_uop_iw_state        (_mshrs_5_io_resp_bits_uop_iw_state),	// mshrs.scala:620:22
    .io_in_5_bits_uop_iw_p1_poisoned  (_mshrs_5_io_resp_bits_uop_iw_p1_poisoned),	// mshrs.scala:620:22
    .io_in_5_bits_uop_iw_p2_poisoned  (_mshrs_5_io_resp_bits_uop_iw_p2_poisoned),	// mshrs.scala:620:22
    .io_in_5_bits_uop_is_br           (_mshrs_5_io_resp_bits_uop_is_br),	// mshrs.scala:620:22
    .io_in_5_bits_uop_is_jalr         (_mshrs_5_io_resp_bits_uop_is_jalr),	// mshrs.scala:620:22
    .io_in_5_bits_uop_is_jal          (_mshrs_5_io_resp_bits_uop_is_jal),	// mshrs.scala:620:22
    .io_in_5_bits_uop_is_sfb          (_mshrs_5_io_resp_bits_uop_is_sfb),	// mshrs.scala:620:22
    .io_in_5_bits_uop_br_mask         (_mshrs_5_io_resp_bits_uop_br_mask),	// mshrs.scala:620:22
    .io_in_5_bits_uop_br_tag          (_mshrs_5_io_resp_bits_uop_br_tag),	// mshrs.scala:620:22
    .io_in_5_bits_uop_ftq_idx         (_mshrs_5_io_resp_bits_uop_ftq_idx),	// mshrs.scala:620:22
    .io_in_5_bits_uop_edge_inst       (_mshrs_5_io_resp_bits_uop_edge_inst),	// mshrs.scala:620:22
    .io_in_5_bits_uop_pc_lob          (_mshrs_5_io_resp_bits_uop_pc_lob),	// mshrs.scala:620:22
    .io_in_5_bits_uop_taken           (_mshrs_5_io_resp_bits_uop_taken),	// mshrs.scala:620:22
    .io_in_5_bits_uop_imm_packed      (_mshrs_5_io_resp_bits_uop_imm_packed),	// mshrs.scala:620:22
    .io_in_5_bits_uop_csr_addr        (_mshrs_5_io_resp_bits_uop_csr_addr),	// mshrs.scala:620:22
    .io_in_5_bits_uop_rob_idx         (_mshrs_5_io_resp_bits_uop_rob_idx),	// mshrs.scala:620:22
    .io_in_5_bits_uop_ldq_idx         (_mshrs_5_io_resp_bits_uop_ldq_idx),	// mshrs.scala:620:22
    .io_in_5_bits_uop_stq_idx         (_mshrs_5_io_resp_bits_uop_stq_idx),	// mshrs.scala:620:22
    .io_in_5_bits_uop_rxq_idx         (_mshrs_5_io_resp_bits_uop_rxq_idx),	// mshrs.scala:620:22
    .io_in_5_bits_uop_pdst            (_mshrs_5_io_resp_bits_uop_pdst),	// mshrs.scala:620:22
    .io_in_5_bits_uop_prs1            (_mshrs_5_io_resp_bits_uop_prs1),	// mshrs.scala:620:22
    .io_in_5_bits_uop_prs2            (_mshrs_5_io_resp_bits_uop_prs2),	// mshrs.scala:620:22
    .io_in_5_bits_uop_prs3            (_mshrs_5_io_resp_bits_uop_prs3),	// mshrs.scala:620:22
    .io_in_5_bits_uop_ppred           (_mshrs_5_io_resp_bits_uop_ppred),	// mshrs.scala:620:22
    .io_in_5_bits_uop_prs1_busy       (_mshrs_5_io_resp_bits_uop_prs1_busy),	// mshrs.scala:620:22
    .io_in_5_bits_uop_prs2_busy       (_mshrs_5_io_resp_bits_uop_prs2_busy),	// mshrs.scala:620:22
    .io_in_5_bits_uop_prs3_busy       (_mshrs_5_io_resp_bits_uop_prs3_busy),	// mshrs.scala:620:22
    .io_in_5_bits_uop_ppred_busy      (_mshrs_5_io_resp_bits_uop_ppred_busy),	// mshrs.scala:620:22
    .io_in_5_bits_uop_stale_pdst      (_mshrs_5_io_resp_bits_uop_stale_pdst),	// mshrs.scala:620:22
    .io_in_5_bits_uop_exception       (_mshrs_5_io_resp_bits_uop_exception),	// mshrs.scala:620:22
    .io_in_5_bits_uop_exc_cause       (_mshrs_5_io_resp_bits_uop_exc_cause),	// mshrs.scala:620:22
    .io_in_5_bits_uop_bypassable      (_mshrs_5_io_resp_bits_uop_bypassable),	// mshrs.scala:620:22
    .io_in_5_bits_uop_mem_cmd         (_mshrs_5_io_resp_bits_uop_mem_cmd),	// mshrs.scala:620:22
    .io_in_5_bits_uop_mem_size        (_mshrs_5_io_resp_bits_uop_mem_size),	// mshrs.scala:620:22
    .io_in_5_bits_uop_mem_signed      (_mshrs_5_io_resp_bits_uop_mem_signed),	// mshrs.scala:620:22
    .io_in_5_bits_uop_is_fence        (_mshrs_5_io_resp_bits_uop_is_fence),	// mshrs.scala:620:22
    .io_in_5_bits_uop_is_fencei       (_mshrs_5_io_resp_bits_uop_is_fencei),	// mshrs.scala:620:22
    .io_in_5_bits_uop_is_amo          (_mshrs_5_io_resp_bits_uop_is_amo),	// mshrs.scala:620:22
    .io_in_5_bits_uop_uses_ldq        (_mshrs_5_io_resp_bits_uop_uses_ldq),	// mshrs.scala:620:22
    .io_in_5_bits_uop_uses_stq        (_mshrs_5_io_resp_bits_uop_uses_stq),	// mshrs.scala:620:22
    .io_in_5_bits_uop_is_sys_pc2epc   (_mshrs_5_io_resp_bits_uop_is_sys_pc2epc),	// mshrs.scala:620:22
    .io_in_5_bits_uop_is_unique       (_mshrs_5_io_resp_bits_uop_is_unique),	// mshrs.scala:620:22
    .io_in_5_bits_uop_flush_on_commit (_mshrs_5_io_resp_bits_uop_flush_on_commit),	// mshrs.scala:620:22
    .io_in_5_bits_uop_ldst_is_rs1     (_mshrs_5_io_resp_bits_uop_ldst_is_rs1),	// mshrs.scala:620:22
    .io_in_5_bits_uop_ldst            (_mshrs_5_io_resp_bits_uop_ldst),	// mshrs.scala:620:22
    .io_in_5_bits_uop_lrs1            (_mshrs_5_io_resp_bits_uop_lrs1),	// mshrs.scala:620:22
    .io_in_5_bits_uop_lrs2            (_mshrs_5_io_resp_bits_uop_lrs2),	// mshrs.scala:620:22
    .io_in_5_bits_uop_lrs3            (_mshrs_5_io_resp_bits_uop_lrs3),	// mshrs.scala:620:22
    .io_in_5_bits_uop_ldst_val        (_mshrs_5_io_resp_bits_uop_ldst_val),	// mshrs.scala:620:22
    .io_in_5_bits_uop_dst_rtype       (_mshrs_5_io_resp_bits_uop_dst_rtype),	// mshrs.scala:620:22
    .io_in_5_bits_uop_lrs1_rtype      (_mshrs_5_io_resp_bits_uop_lrs1_rtype),	// mshrs.scala:620:22
    .io_in_5_bits_uop_lrs2_rtype      (_mshrs_5_io_resp_bits_uop_lrs2_rtype),	// mshrs.scala:620:22
    .io_in_5_bits_uop_frs3_en         (_mshrs_5_io_resp_bits_uop_frs3_en),	// mshrs.scala:620:22
    .io_in_5_bits_uop_fp_val          (_mshrs_5_io_resp_bits_uop_fp_val),	// mshrs.scala:620:22
    .io_in_5_bits_uop_fp_single       (_mshrs_5_io_resp_bits_uop_fp_single),	// mshrs.scala:620:22
    .io_in_5_bits_uop_xcpt_pf_if      (_mshrs_5_io_resp_bits_uop_xcpt_pf_if),	// mshrs.scala:620:22
    .io_in_5_bits_uop_xcpt_ae_if      (_mshrs_5_io_resp_bits_uop_xcpt_ae_if),	// mshrs.scala:620:22
    .io_in_5_bits_uop_xcpt_ma_if      (_mshrs_5_io_resp_bits_uop_xcpt_ma_if),	// mshrs.scala:620:22
    .io_in_5_bits_uop_bp_debug_if     (_mshrs_5_io_resp_bits_uop_bp_debug_if),	// mshrs.scala:620:22
    .io_in_5_bits_uop_bp_xcpt_if      (_mshrs_5_io_resp_bits_uop_bp_xcpt_if),	// mshrs.scala:620:22
    .io_in_5_bits_uop_debug_fsrc      (_mshrs_5_io_resp_bits_uop_debug_fsrc),	// mshrs.scala:620:22
    .io_in_5_bits_uop_debug_tsrc      (_mshrs_5_io_resp_bits_uop_debug_tsrc),	// mshrs.scala:620:22
    .io_in_5_bits_data                (_mshrs_5_io_resp_bits_data),	// mshrs.scala:620:22
    .io_in_5_bits_is_hella            (_mshrs_5_io_resp_bits_is_hella),	// mshrs.scala:620:22
    .io_in_6_valid                    (_mshrs_6_io_resp_valid),	// mshrs.scala:620:22
    .io_in_6_bits_uop_uopc            (_mshrs_6_io_resp_bits_uop_uopc),	// mshrs.scala:620:22
    .io_in_6_bits_uop_inst            (_mshrs_6_io_resp_bits_uop_inst),	// mshrs.scala:620:22
    .io_in_6_bits_uop_debug_inst      (_mshrs_6_io_resp_bits_uop_debug_inst),	// mshrs.scala:620:22
    .io_in_6_bits_uop_is_rvc          (_mshrs_6_io_resp_bits_uop_is_rvc),	// mshrs.scala:620:22
    .io_in_6_bits_uop_debug_pc        (_mshrs_6_io_resp_bits_uop_debug_pc),	// mshrs.scala:620:22
    .io_in_6_bits_uop_iq_type         (_mshrs_6_io_resp_bits_uop_iq_type),	// mshrs.scala:620:22
    .io_in_6_bits_uop_fu_code         (_mshrs_6_io_resp_bits_uop_fu_code),	// mshrs.scala:620:22
    .io_in_6_bits_uop_ctrl_br_type    (_mshrs_6_io_resp_bits_uop_ctrl_br_type),	// mshrs.scala:620:22
    .io_in_6_bits_uop_ctrl_op1_sel    (_mshrs_6_io_resp_bits_uop_ctrl_op1_sel),	// mshrs.scala:620:22
    .io_in_6_bits_uop_ctrl_op2_sel    (_mshrs_6_io_resp_bits_uop_ctrl_op2_sel),	// mshrs.scala:620:22
    .io_in_6_bits_uop_ctrl_imm_sel    (_mshrs_6_io_resp_bits_uop_ctrl_imm_sel),	// mshrs.scala:620:22
    .io_in_6_bits_uop_ctrl_op_fcn     (_mshrs_6_io_resp_bits_uop_ctrl_op_fcn),	// mshrs.scala:620:22
    .io_in_6_bits_uop_ctrl_fcn_dw     (_mshrs_6_io_resp_bits_uop_ctrl_fcn_dw),	// mshrs.scala:620:22
    .io_in_6_bits_uop_ctrl_csr_cmd    (_mshrs_6_io_resp_bits_uop_ctrl_csr_cmd),	// mshrs.scala:620:22
    .io_in_6_bits_uop_ctrl_is_load    (_mshrs_6_io_resp_bits_uop_ctrl_is_load),	// mshrs.scala:620:22
    .io_in_6_bits_uop_ctrl_is_sta     (_mshrs_6_io_resp_bits_uop_ctrl_is_sta),	// mshrs.scala:620:22
    .io_in_6_bits_uop_ctrl_is_std     (_mshrs_6_io_resp_bits_uop_ctrl_is_std),	// mshrs.scala:620:22
    .io_in_6_bits_uop_iw_state        (_mshrs_6_io_resp_bits_uop_iw_state),	// mshrs.scala:620:22
    .io_in_6_bits_uop_iw_p1_poisoned  (_mshrs_6_io_resp_bits_uop_iw_p1_poisoned),	// mshrs.scala:620:22
    .io_in_6_bits_uop_iw_p2_poisoned  (_mshrs_6_io_resp_bits_uop_iw_p2_poisoned),	// mshrs.scala:620:22
    .io_in_6_bits_uop_is_br           (_mshrs_6_io_resp_bits_uop_is_br),	// mshrs.scala:620:22
    .io_in_6_bits_uop_is_jalr         (_mshrs_6_io_resp_bits_uop_is_jalr),	// mshrs.scala:620:22
    .io_in_6_bits_uop_is_jal          (_mshrs_6_io_resp_bits_uop_is_jal),	// mshrs.scala:620:22
    .io_in_6_bits_uop_is_sfb          (_mshrs_6_io_resp_bits_uop_is_sfb),	// mshrs.scala:620:22
    .io_in_6_bits_uop_br_mask         (_mshrs_6_io_resp_bits_uop_br_mask),	// mshrs.scala:620:22
    .io_in_6_bits_uop_br_tag          (_mshrs_6_io_resp_bits_uop_br_tag),	// mshrs.scala:620:22
    .io_in_6_bits_uop_ftq_idx         (_mshrs_6_io_resp_bits_uop_ftq_idx),	// mshrs.scala:620:22
    .io_in_6_bits_uop_edge_inst       (_mshrs_6_io_resp_bits_uop_edge_inst),	// mshrs.scala:620:22
    .io_in_6_bits_uop_pc_lob          (_mshrs_6_io_resp_bits_uop_pc_lob),	// mshrs.scala:620:22
    .io_in_6_bits_uop_taken           (_mshrs_6_io_resp_bits_uop_taken),	// mshrs.scala:620:22
    .io_in_6_bits_uop_imm_packed      (_mshrs_6_io_resp_bits_uop_imm_packed),	// mshrs.scala:620:22
    .io_in_6_bits_uop_csr_addr        (_mshrs_6_io_resp_bits_uop_csr_addr),	// mshrs.scala:620:22
    .io_in_6_bits_uop_rob_idx         (_mshrs_6_io_resp_bits_uop_rob_idx),	// mshrs.scala:620:22
    .io_in_6_bits_uop_ldq_idx         (_mshrs_6_io_resp_bits_uop_ldq_idx),	// mshrs.scala:620:22
    .io_in_6_bits_uop_stq_idx         (_mshrs_6_io_resp_bits_uop_stq_idx),	// mshrs.scala:620:22
    .io_in_6_bits_uop_rxq_idx         (_mshrs_6_io_resp_bits_uop_rxq_idx),	// mshrs.scala:620:22
    .io_in_6_bits_uop_pdst            (_mshrs_6_io_resp_bits_uop_pdst),	// mshrs.scala:620:22
    .io_in_6_bits_uop_prs1            (_mshrs_6_io_resp_bits_uop_prs1),	// mshrs.scala:620:22
    .io_in_6_bits_uop_prs2            (_mshrs_6_io_resp_bits_uop_prs2),	// mshrs.scala:620:22
    .io_in_6_bits_uop_prs3            (_mshrs_6_io_resp_bits_uop_prs3),	// mshrs.scala:620:22
    .io_in_6_bits_uop_ppred           (_mshrs_6_io_resp_bits_uop_ppred),	// mshrs.scala:620:22
    .io_in_6_bits_uop_prs1_busy       (_mshrs_6_io_resp_bits_uop_prs1_busy),	// mshrs.scala:620:22
    .io_in_6_bits_uop_prs2_busy       (_mshrs_6_io_resp_bits_uop_prs2_busy),	// mshrs.scala:620:22
    .io_in_6_bits_uop_prs3_busy       (_mshrs_6_io_resp_bits_uop_prs3_busy),	// mshrs.scala:620:22
    .io_in_6_bits_uop_ppred_busy      (_mshrs_6_io_resp_bits_uop_ppred_busy),	// mshrs.scala:620:22
    .io_in_6_bits_uop_stale_pdst      (_mshrs_6_io_resp_bits_uop_stale_pdst),	// mshrs.scala:620:22
    .io_in_6_bits_uop_exception       (_mshrs_6_io_resp_bits_uop_exception),	// mshrs.scala:620:22
    .io_in_6_bits_uop_exc_cause       (_mshrs_6_io_resp_bits_uop_exc_cause),	// mshrs.scala:620:22
    .io_in_6_bits_uop_bypassable      (_mshrs_6_io_resp_bits_uop_bypassable),	// mshrs.scala:620:22
    .io_in_6_bits_uop_mem_cmd         (_mshrs_6_io_resp_bits_uop_mem_cmd),	// mshrs.scala:620:22
    .io_in_6_bits_uop_mem_size        (_mshrs_6_io_resp_bits_uop_mem_size),	// mshrs.scala:620:22
    .io_in_6_bits_uop_mem_signed      (_mshrs_6_io_resp_bits_uop_mem_signed),	// mshrs.scala:620:22
    .io_in_6_bits_uop_is_fence        (_mshrs_6_io_resp_bits_uop_is_fence),	// mshrs.scala:620:22
    .io_in_6_bits_uop_is_fencei       (_mshrs_6_io_resp_bits_uop_is_fencei),	// mshrs.scala:620:22
    .io_in_6_bits_uop_is_amo          (_mshrs_6_io_resp_bits_uop_is_amo),	// mshrs.scala:620:22
    .io_in_6_bits_uop_uses_ldq        (_mshrs_6_io_resp_bits_uop_uses_ldq),	// mshrs.scala:620:22
    .io_in_6_bits_uop_uses_stq        (_mshrs_6_io_resp_bits_uop_uses_stq),	// mshrs.scala:620:22
    .io_in_6_bits_uop_is_sys_pc2epc   (_mshrs_6_io_resp_bits_uop_is_sys_pc2epc),	// mshrs.scala:620:22
    .io_in_6_bits_uop_is_unique       (_mshrs_6_io_resp_bits_uop_is_unique),	// mshrs.scala:620:22
    .io_in_6_bits_uop_flush_on_commit (_mshrs_6_io_resp_bits_uop_flush_on_commit),	// mshrs.scala:620:22
    .io_in_6_bits_uop_ldst_is_rs1     (_mshrs_6_io_resp_bits_uop_ldst_is_rs1),	// mshrs.scala:620:22
    .io_in_6_bits_uop_ldst            (_mshrs_6_io_resp_bits_uop_ldst),	// mshrs.scala:620:22
    .io_in_6_bits_uop_lrs1            (_mshrs_6_io_resp_bits_uop_lrs1),	// mshrs.scala:620:22
    .io_in_6_bits_uop_lrs2            (_mshrs_6_io_resp_bits_uop_lrs2),	// mshrs.scala:620:22
    .io_in_6_bits_uop_lrs3            (_mshrs_6_io_resp_bits_uop_lrs3),	// mshrs.scala:620:22
    .io_in_6_bits_uop_ldst_val        (_mshrs_6_io_resp_bits_uop_ldst_val),	// mshrs.scala:620:22
    .io_in_6_bits_uop_dst_rtype       (_mshrs_6_io_resp_bits_uop_dst_rtype),	// mshrs.scala:620:22
    .io_in_6_bits_uop_lrs1_rtype      (_mshrs_6_io_resp_bits_uop_lrs1_rtype),	// mshrs.scala:620:22
    .io_in_6_bits_uop_lrs2_rtype      (_mshrs_6_io_resp_bits_uop_lrs2_rtype),	// mshrs.scala:620:22
    .io_in_6_bits_uop_frs3_en         (_mshrs_6_io_resp_bits_uop_frs3_en),	// mshrs.scala:620:22
    .io_in_6_bits_uop_fp_val          (_mshrs_6_io_resp_bits_uop_fp_val),	// mshrs.scala:620:22
    .io_in_6_bits_uop_fp_single       (_mshrs_6_io_resp_bits_uop_fp_single),	// mshrs.scala:620:22
    .io_in_6_bits_uop_xcpt_pf_if      (_mshrs_6_io_resp_bits_uop_xcpt_pf_if),	// mshrs.scala:620:22
    .io_in_6_bits_uop_xcpt_ae_if      (_mshrs_6_io_resp_bits_uop_xcpt_ae_if),	// mshrs.scala:620:22
    .io_in_6_bits_uop_xcpt_ma_if      (_mshrs_6_io_resp_bits_uop_xcpt_ma_if),	// mshrs.scala:620:22
    .io_in_6_bits_uop_bp_debug_if     (_mshrs_6_io_resp_bits_uop_bp_debug_if),	// mshrs.scala:620:22
    .io_in_6_bits_uop_bp_xcpt_if      (_mshrs_6_io_resp_bits_uop_bp_xcpt_if),	// mshrs.scala:620:22
    .io_in_6_bits_uop_debug_fsrc      (_mshrs_6_io_resp_bits_uop_debug_fsrc),	// mshrs.scala:620:22
    .io_in_6_bits_uop_debug_tsrc      (_mshrs_6_io_resp_bits_uop_debug_tsrc),	// mshrs.scala:620:22
    .io_in_6_bits_data                (_mshrs_6_io_resp_bits_data),	// mshrs.scala:620:22
    .io_in_6_bits_is_hella            (_mshrs_6_io_resp_bits_is_hella),	// mshrs.scala:620:22
    .io_in_7_valid                    (_mshrs_7_io_resp_valid),	// mshrs.scala:620:22
    .io_in_7_bits_uop_uopc            (_mshrs_7_io_resp_bits_uop_uopc),	// mshrs.scala:620:22
    .io_in_7_bits_uop_inst            (_mshrs_7_io_resp_bits_uop_inst),	// mshrs.scala:620:22
    .io_in_7_bits_uop_debug_inst      (_mshrs_7_io_resp_bits_uop_debug_inst),	// mshrs.scala:620:22
    .io_in_7_bits_uop_is_rvc          (_mshrs_7_io_resp_bits_uop_is_rvc),	// mshrs.scala:620:22
    .io_in_7_bits_uop_debug_pc        (_mshrs_7_io_resp_bits_uop_debug_pc),	// mshrs.scala:620:22
    .io_in_7_bits_uop_iq_type         (_mshrs_7_io_resp_bits_uop_iq_type),	// mshrs.scala:620:22
    .io_in_7_bits_uop_fu_code         (_mshrs_7_io_resp_bits_uop_fu_code),	// mshrs.scala:620:22
    .io_in_7_bits_uop_ctrl_br_type    (_mshrs_7_io_resp_bits_uop_ctrl_br_type),	// mshrs.scala:620:22
    .io_in_7_bits_uop_ctrl_op1_sel    (_mshrs_7_io_resp_bits_uop_ctrl_op1_sel),	// mshrs.scala:620:22
    .io_in_7_bits_uop_ctrl_op2_sel    (_mshrs_7_io_resp_bits_uop_ctrl_op2_sel),	// mshrs.scala:620:22
    .io_in_7_bits_uop_ctrl_imm_sel    (_mshrs_7_io_resp_bits_uop_ctrl_imm_sel),	// mshrs.scala:620:22
    .io_in_7_bits_uop_ctrl_op_fcn     (_mshrs_7_io_resp_bits_uop_ctrl_op_fcn),	// mshrs.scala:620:22
    .io_in_7_bits_uop_ctrl_fcn_dw     (_mshrs_7_io_resp_bits_uop_ctrl_fcn_dw),	// mshrs.scala:620:22
    .io_in_7_bits_uop_ctrl_csr_cmd    (_mshrs_7_io_resp_bits_uop_ctrl_csr_cmd),	// mshrs.scala:620:22
    .io_in_7_bits_uop_ctrl_is_load    (_mshrs_7_io_resp_bits_uop_ctrl_is_load),	// mshrs.scala:620:22
    .io_in_7_bits_uop_ctrl_is_sta     (_mshrs_7_io_resp_bits_uop_ctrl_is_sta),	// mshrs.scala:620:22
    .io_in_7_bits_uop_ctrl_is_std     (_mshrs_7_io_resp_bits_uop_ctrl_is_std),	// mshrs.scala:620:22
    .io_in_7_bits_uop_iw_state        (_mshrs_7_io_resp_bits_uop_iw_state),	// mshrs.scala:620:22
    .io_in_7_bits_uop_iw_p1_poisoned  (_mshrs_7_io_resp_bits_uop_iw_p1_poisoned),	// mshrs.scala:620:22
    .io_in_7_bits_uop_iw_p2_poisoned  (_mshrs_7_io_resp_bits_uop_iw_p2_poisoned),	// mshrs.scala:620:22
    .io_in_7_bits_uop_is_br           (_mshrs_7_io_resp_bits_uop_is_br),	// mshrs.scala:620:22
    .io_in_7_bits_uop_is_jalr         (_mshrs_7_io_resp_bits_uop_is_jalr),	// mshrs.scala:620:22
    .io_in_7_bits_uop_is_jal          (_mshrs_7_io_resp_bits_uop_is_jal),	// mshrs.scala:620:22
    .io_in_7_bits_uop_is_sfb          (_mshrs_7_io_resp_bits_uop_is_sfb),	// mshrs.scala:620:22
    .io_in_7_bits_uop_br_mask         (_mshrs_7_io_resp_bits_uop_br_mask),	// mshrs.scala:620:22
    .io_in_7_bits_uop_br_tag          (_mshrs_7_io_resp_bits_uop_br_tag),	// mshrs.scala:620:22
    .io_in_7_bits_uop_ftq_idx         (_mshrs_7_io_resp_bits_uop_ftq_idx),	// mshrs.scala:620:22
    .io_in_7_bits_uop_edge_inst       (_mshrs_7_io_resp_bits_uop_edge_inst),	// mshrs.scala:620:22
    .io_in_7_bits_uop_pc_lob          (_mshrs_7_io_resp_bits_uop_pc_lob),	// mshrs.scala:620:22
    .io_in_7_bits_uop_taken           (_mshrs_7_io_resp_bits_uop_taken),	// mshrs.scala:620:22
    .io_in_7_bits_uop_imm_packed      (_mshrs_7_io_resp_bits_uop_imm_packed),	// mshrs.scala:620:22
    .io_in_7_bits_uop_csr_addr        (_mshrs_7_io_resp_bits_uop_csr_addr),	// mshrs.scala:620:22
    .io_in_7_bits_uop_rob_idx         (_mshrs_7_io_resp_bits_uop_rob_idx),	// mshrs.scala:620:22
    .io_in_7_bits_uop_ldq_idx         (_mshrs_7_io_resp_bits_uop_ldq_idx),	// mshrs.scala:620:22
    .io_in_7_bits_uop_stq_idx         (_mshrs_7_io_resp_bits_uop_stq_idx),	// mshrs.scala:620:22
    .io_in_7_bits_uop_rxq_idx         (_mshrs_7_io_resp_bits_uop_rxq_idx),	// mshrs.scala:620:22
    .io_in_7_bits_uop_pdst            (_mshrs_7_io_resp_bits_uop_pdst),	// mshrs.scala:620:22
    .io_in_7_bits_uop_prs1            (_mshrs_7_io_resp_bits_uop_prs1),	// mshrs.scala:620:22
    .io_in_7_bits_uop_prs2            (_mshrs_7_io_resp_bits_uop_prs2),	// mshrs.scala:620:22
    .io_in_7_bits_uop_prs3            (_mshrs_7_io_resp_bits_uop_prs3),	// mshrs.scala:620:22
    .io_in_7_bits_uop_ppred           (_mshrs_7_io_resp_bits_uop_ppred),	// mshrs.scala:620:22
    .io_in_7_bits_uop_prs1_busy       (_mshrs_7_io_resp_bits_uop_prs1_busy),	// mshrs.scala:620:22
    .io_in_7_bits_uop_prs2_busy       (_mshrs_7_io_resp_bits_uop_prs2_busy),	// mshrs.scala:620:22
    .io_in_7_bits_uop_prs3_busy       (_mshrs_7_io_resp_bits_uop_prs3_busy),	// mshrs.scala:620:22
    .io_in_7_bits_uop_ppred_busy      (_mshrs_7_io_resp_bits_uop_ppred_busy),	// mshrs.scala:620:22
    .io_in_7_bits_uop_stale_pdst      (_mshrs_7_io_resp_bits_uop_stale_pdst),	// mshrs.scala:620:22
    .io_in_7_bits_uop_exception       (_mshrs_7_io_resp_bits_uop_exception),	// mshrs.scala:620:22
    .io_in_7_bits_uop_exc_cause       (_mshrs_7_io_resp_bits_uop_exc_cause),	// mshrs.scala:620:22
    .io_in_7_bits_uop_bypassable      (_mshrs_7_io_resp_bits_uop_bypassable),	// mshrs.scala:620:22
    .io_in_7_bits_uop_mem_cmd         (_mshrs_7_io_resp_bits_uop_mem_cmd),	// mshrs.scala:620:22
    .io_in_7_bits_uop_mem_size        (_mshrs_7_io_resp_bits_uop_mem_size),	// mshrs.scala:620:22
    .io_in_7_bits_uop_mem_signed      (_mshrs_7_io_resp_bits_uop_mem_signed),	// mshrs.scala:620:22
    .io_in_7_bits_uop_is_fence        (_mshrs_7_io_resp_bits_uop_is_fence),	// mshrs.scala:620:22
    .io_in_7_bits_uop_is_fencei       (_mshrs_7_io_resp_bits_uop_is_fencei),	// mshrs.scala:620:22
    .io_in_7_bits_uop_is_amo          (_mshrs_7_io_resp_bits_uop_is_amo),	// mshrs.scala:620:22
    .io_in_7_bits_uop_uses_ldq        (_mshrs_7_io_resp_bits_uop_uses_ldq),	// mshrs.scala:620:22
    .io_in_7_bits_uop_uses_stq        (_mshrs_7_io_resp_bits_uop_uses_stq),	// mshrs.scala:620:22
    .io_in_7_bits_uop_is_sys_pc2epc   (_mshrs_7_io_resp_bits_uop_is_sys_pc2epc),	// mshrs.scala:620:22
    .io_in_7_bits_uop_is_unique       (_mshrs_7_io_resp_bits_uop_is_unique),	// mshrs.scala:620:22
    .io_in_7_bits_uop_flush_on_commit (_mshrs_7_io_resp_bits_uop_flush_on_commit),	// mshrs.scala:620:22
    .io_in_7_bits_uop_ldst_is_rs1     (_mshrs_7_io_resp_bits_uop_ldst_is_rs1),	// mshrs.scala:620:22
    .io_in_7_bits_uop_ldst            (_mshrs_7_io_resp_bits_uop_ldst),	// mshrs.scala:620:22
    .io_in_7_bits_uop_lrs1            (_mshrs_7_io_resp_bits_uop_lrs1),	// mshrs.scala:620:22
    .io_in_7_bits_uop_lrs2            (_mshrs_7_io_resp_bits_uop_lrs2),	// mshrs.scala:620:22
    .io_in_7_bits_uop_lrs3            (_mshrs_7_io_resp_bits_uop_lrs3),	// mshrs.scala:620:22
    .io_in_7_bits_uop_ldst_val        (_mshrs_7_io_resp_bits_uop_ldst_val),	// mshrs.scala:620:22
    .io_in_7_bits_uop_dst_rtype       (_mshrs_7_io_resp_bits_uop_dst_rtype),	// mshrs.scala:620:22
    .io_in_7_bits_uop_lrs1_rtype      (_mshrs_7_io_resp_bits_uop_lrs1_rtype),	// mshrs.scala:620:22
    .io_in_7_bits_uop_lrs2_rtype      (_mshrs_7_io_resp_bits_uop_lrs2_rtype),	// mshrs.scala:620:22
    .io_in_7_bits_uop_frs3_en         (_mshrs_7_io_resp_bits_uop_frs3_en),	// mshrs.scala:620:22
    .io_in_7_bits_uop_fp_val          (_mshrs_7_io_resp_bits_uop_fp_val),	// mshrs.scala:620:22
    .io_in_7_bits_uop_fp_single       (_mshrs_7_io_resp_bits_uop_fp_single),	// mshrs.scala:620:22
    .io_in_7_bits_uop_xcpt_pf_if      (_mshrs_7_io_resp_bits_uop_xcpt_pf_if),	// mshrs.scala:620:22
    .io_in_7_bits_uop_xcpt_ae_if      (_mshrs_7_io_resp_bits_uop_xcpt_ae_if),	// mshrs.scala:620:22
    .io_in_7_bits_uop_xcpt_ma_if      (_mshrs_7_io_resp_bits_uop_xcpt_ma_if),	// mshrs.scala:620:22
    .io_in_7_bits_uop_bp_debug_if     (_mshrs_7_io_resp_bits_uop_bp_debug_if),	// mshrs.scala:620:22
    .io_in_7_bits_uop_bp_xcpt_if      (_mshrs_7_io_resp_bits_uop_bp_xcpt_if),	// mshrs.scala:620:22
    .io_in_7_bits_uop_debug_fsrc      (_mshrs_7_io_resp_bits_uop_debug_fsrc),	// mshrs.scala:620:22
    .io_in_7_bits_uop_debug_tsrc      (_mshrs_7_io_resp_bits_uop_debug_tsrc),	// mshrs.scala:620:22
    .io_in_7_bits_data                (_mshrs_7_io_resp_bits_data),	// mshrs.scala:620:22
    .io_in_7_bits_is_hella            (_mshrs_7_io_resp_bits_is_hella),	// mshrs.scala:620:22
    .io_in_8_valid                    (_mmios_0_io_resp_valid),	// mshrs.scala:710:22
    .io_in_8_bits_uop_uopc            (_mmios_0_io_resp_bits_uop_uopc),	// mshrs.scala:710:22
    .io_in_8_bits_uop_inst            (_mmios_0_io_resp_bits_uop_inst),	// mshrs.scala:710:22
    .io_in_8_bits_uop_debug_inst      (_mmios_0_io_resp_bits_uop_debug_inst),	// mshrs.scala:710:22
    .io_in_8_bits_uop_is_rvc          (_mmios_0_io_resp_bits_uop_is_rvc),	// mshrs.scala:710:22
    .io_in_8_bits_uop_debug_pc        (_mmios_0_io_resp_bits_uop_debug_pc),	// mshrs.scala:710:22
    .io_in_8_bits_uop_iq_type         (_mmios_0_io_resp_bits_uop_iq_type),	// mshrs.scala:710:22
    .io_in_8_bits_uop_fu_code         (_mmios_0_io_resp_bits_uop_fu_code),	// mshrs.scala:710:22
    .io_in_8_bits_uop_ctrl_br_type    (_mmios_0_io_resp_bits_uop_ctrl_br_type),	// mshrs.scala:710:22
    .io_in_8_bits_uop_ctrl_op1_sel    (_mmios_0_io_resp_bits_uop_ctrl_op1_sel),	// mshrs.scala:710:22
    .io_in_8_bits_uop_ctrl_op2_sel    (_mmios_0_io_resp_bits_uop_ctrl_op2_sel),	// mshrs.scala:710:22
    .io_in_8_bits_uop_ctrl_imm_sel    (_mmios_0_io_resp_bits_uop_ctrl_imm_sel),	// mshrs.scala:710:22
    .io_in_8_bits_uop_ctrl_op_fcn     (_mmios_0_io_resp_bits_uop_ctrl_op_fcn),	// mshrs.scala:710:22
    .io_in_8_bits_uop_ctrl_fcn_dw     (_mmios_0_io_resp_bits_uop_ctrl_fcn_dw),	// mshrs.scala:710:22
    .io_in_8_bits_uop_ctrl_csr_cmd    (_mmios_0_io_resp_bits_uop_ctrl_csr_cmd),	// mshrs.scala:710:22
    .io_in_8_bits_uop_ctrl_is_load    (_mmios_0_io_resp_bits_uop_ctrl_is_load),	// mshrs.scala:710:22
    .io_in_8_bits_uop_ctrl_is_sta     (_mmios_0_io_resp_bits_uop_ctrl_is_sta),	// mshrs.scala:710:22
    .io_in_8_bits_uop_ctrl_is_std     (_mmios_0_io_resp_bits_uop_ctrl_is_std),	// mshrs.scala:710:22
    .io_in_8_bits_uop_iw_state        (_mmios_0_io_resp_bits_uop_iw_state),	// mshrs.scala:710:22
    .io_in_8_bits_uop_iw_p1_poisoned  (_mmios_0_io_resp_bits_uop_iw_p1_poisoned),	// mshrs.scala:710:22
    .io_in_8_bits_uop_iw_p2_poisoned  (_mmios_0_io_resp_bits_uop_iw_p2_poisoned),	// mshrs.scala:710:22
    .io_in_8_bits_uop_is_br           (_mmios_0_io_resp_bits_uop_is_br),	// mshrs.scala:710:22
    .io_in_8_bits_uop_is_jalr         (_mmios_0_io_resp_bits_uop_is_jalr),	// mshrs.scala:710:22
    .io_in_8_bits_uop_is_jal          (_mmios_0_io_resp_bits_uop_is_jal),	// mshrs.scala:710:22
    .io_in_8_bits_uop_is_sfb          (_mmios_0_io_resp_bits_uop_is_sfb),	// mshrs.scala:710:22
    .io_in_8_bits_uop_br_mask         (_mmios_0_io_resp_bits_uop_br_mask),	// mshrs.scala:710:22
    .io_in_8_bits_uop_br_tag          (_mmios_0_io_resp_bits_uop_br_tag),	// mshrs.scala:710:22
    .io_in_8_bits_uop_ftq_idx         (_mmios_0_io_resp_bits_uop_ftq_idx),	// mshrs.scala:710:22
    .io_in_8_bits_uop_edge_inst       (_mmios_0_io_resp_bits_uop_edge_inst),	// mshrs.scala:710:22
    .io_in_8_bits_uop_pc_lob          (_mmios_0_io_resp_bits_uop_pc_lob),	// mshrs.scala:710:22
    .io_in_8_bits_uop_taken           (_mmios_0_io_resp_bits_uop_taken),	// mshrs.scala:710:22
    .io_in_8_bits_uop_imm_packed      (_mmios_0_io_resp_bits_uop_imm_packed),	// mshrs.scala:710:22
    .io_in_8_bits_uop_csr_addr        (_mmios_0_io_resp_bits_uop_csr_addr),	// mshrs.scala:710:22
    .io_in_8_bits_uop_rob_idx         (_mmios_0_io_resp_bits_uop_rob_idx),	// mshrs.scala:710:22
    .io_in_8_bits_uop_ldq_idx         (_mmios_0_io_resp_bits_uop_ldq_idx),	// mshrs.scala:710:22
    .io_in_8_bits_uop_stq_idx         (_mmios_0_io_resp_bits_uop_stq_idx),	// mshrs.scala:710:22
    .io_in_8_bits_uop_rxq_idx         (_mmios_0_io_resp_bits_uop_rxq_idx),	// mshrs.scala:710:22
    .io_in_8_bits_uop_pdst            (_mmios_0_io_resp_bits_uop_pdst),	// mshrs.scala:710:22
    .io_in_8_bits_uop_prs1            (_mmios_0_io_resp_bits_uop_prs1),	// mshrs.scala:710:22
    .io_in_8_bits_uop_prs2            (_mmios_0_io_resp_bits_uop_prs2),	// mshrs.scala:710:22
    .io_in_8_bits_uop_prs3            (_mmios_0_io_resp_bits_uop_prs3),	// mshrs.scala:710:22
    .io_in_8_bits_uop_ppred           (_mmios_0_io_resp_bits_uop_ppred),	// mshrs.scala:710:22
    .io_in_8_bits_uop_prs1_busy       (_mmios_0_io_resp_bits_uop_prs1_busy),	// mshrs.scala:710:22
    .io_in_8_bits_uop_prs2_busy       (_mmios_0_io_resp_bits_uop_prs2_busy),	// mshrs.scala:710:22
    .io_in_8_bits_uop_prs3_busy       (_mmios_0_io_resp_bits_uop_prs3_busy),	// mshrs.scala:710:22
    .io_in_8_bits_uop_ppred_busy      (_mmios_0_io_resp_bits_uop_ppred_busy),	// mshrs.scala:710:22
    .io_in_8_bits_uop_stale_pdst      (_mmios_0_io_resp_bits_uop_stale_pdst),	// mshrs.scala:710:22
    .io_in_8_bits_uop_exception       (_mmios_0_io_resp_bits_uop_exception),	// mshrs.scala:710:22
    .io_in_8_bits_uop_exc_cause       (_mmios_0_io_resp_bits_uop_exc_cause),	// mshrs.scala:710:22
    .io_in_8_bits_uop_bypassable      (_mmios_0_io_resp_bits_uop_bypassable),	// mshrs.scala:710:22
    .io_in_8_bits_uop_mem_cmd         (_mmios_0_io_resp_bits_uop_mem_cmd),	// mshrs.scala:710:22
    .io_in_8_bits_uop_mem_size        (_mmios_0_io_resp_bits_uop_mem_size),	// mshrs.scala:710:22
    .io_in_8_bits_uop_mem_signed      (_mmios_0_io_resp_bits_uop_mem_signed),	// mshrs.scala:710:22
    .io_in_8_bits_uop_is_fence        (_mmios_0_io_resp_bits_uop_is_fence),	// mshrs.scala:710:22
    .io_in_8_bits_uop_is_fencei       (_mmios_0_io_resp_bits_uop_is_fencei),	// mshrs.scala:710:22
    .io_in_8_bits_uop_is_amo          (_mmios_0_io_resp_bits_uop_is_amo),	// mshrs.scala:710:22
    .io_in_8_bits_uop_uses_ldq        (_mmios_0_io_resp_bits_uop_uses_ldq),	// mshrs.scala:710:22
    .io_in_8_bits_uop_uses_stq        (_mmios_0_io_resp_bits_uop_uses_stq),	// mshrs.scala:710:22
    .io_in_8_bits_uop_is_sys_pc2epc   (_mmios_0_io_resp_bits_uop_is_sys_pc2epc),	// mshrs.scala:710:22
    .io_in_8_bits_uop_is_unique       (_mmios_0_io_resp_bits_uop_is_unique),	// mshrs.scala:710:22
    .io_in_8_bits_uop_flush_on_commit (_mmios_0_io_resp_bits_uop_flush_on_commit),	// mshrs.scala:710:22
    .io_in_8_bits_uop_ldst_is_rs1     (_mmios_0_io_resp_bits_uop_ldst_is_rs1),	// mshrs.scala:710:22
    .io_in_8_bits_uop_ldst            (_mmios_0_io_resp_bits_uop_ldst),	// mshrs.scala:710:22
    .io_in_8_bits_uop_lrs1            (_mmios_0_io_resp_bits_uop_lrs1),	// mshrs.scala:710:22
    .io_in_8_bits_uop_lrs2            (_mmios_0_io_resp_bits_uop_lrs2),	// mshrs.scala:710:22
    .io_in_8_bits_uop_lrs3            (_mmios_0_io_resp_bits_uop_lrs3),	// mshrs.scala:710:22
    .io_in_8_bits_uop_ldst_val        (_mmios_0_io_resp_bits_uop_ldst_val),	// mshrs.scala:710:22
    .io_in_8_bits_uop_dst_rtype       (_mmios_0_io_resp_bits_uop_dst_rtype),	// mshrs.scala:710:22
    .io_in_8_bits_uop_lrs1_rtype      (_mmios_0_io_resp_bits_uop_lrs1_rtype),	// mshrs.scala:710:22
    .io_in_8_bits_uop_lrs2_rtype      (_mmios_0_io_resp_bits_uop_lrs2_rtype),	// mshrs.scala:710:22
    .io_in_8_bits_uop_frs3_en         (_mmios_0_io_resp_bits_uop_frs3_en),	// mshrs.scala:710:22
    .io_in_8_bits_uop_fp_val          (_mmios_0_io_resp_bits_uop_fp_val),	// mshrs.scala:710:22
    .io_in_8_bits_uop_fp_single       (_mmios_0_io_resp_bits_uop_fp_single),	// mshrs.scala:710:22
    .io_in_8_bits_uop_xcpt_pf_if      (_mmios_0_io_resp_bits_uop_xcpt_pf_if),	// mshrs.scala:710:22
    .io_in_8_bits_uop_xcpt_ae_if      (_mmios_0_io_resp_bits_uop_xcpt_ae_if),	// mshrs.scala:710:22
    .io_in_8_bits_uop_xcpt_ma_if      (_mmios_0_io_resp_bits_uop_xcpt_ma_if),	// mshrs.scala:710:22
    .io_in_8_bits_uop_bp_debug_if     (_mmios_0_io_resp_bits_uop_bp_debug_if),	// mshrs.scala:710:22
    .io_in_8_bits_uop_bp_xcpt_if      (_mmios_0_io_resp_bits_uop_bp_xcpt_if),	// mshrs.scala:710:22
    .io_in_8_bits_uop_debug_fsrc      (_mmios_0_io_resp_bits_uop_debug_fsrc),	// mshrs.scala:710:22
    .io_in_8_bits_uop_debug_tsrc      (_mmios_0_io_resp_bits_uop_debug_tsrc),	// mshrs.scala:710:22
    .io_in_8_bits_data                (_mmios_0_io_resp_bits_data),	// mshrs.scala:710:22
    .io_out_ready                     (_respq_io_enq_ready),	// mshrs.scala:737:21
    .io_in_0_ready                    (_resp_arb_io_in_0_ready),
    .io_in_1_ready                    (_resp_arb_io_in_1_ready),
    .io_in_2_ready                    (_resp_arb_io_in_2_ready),
    .io_in_3_ready                    (_resp_arb_io_in_3_ready),
    .io_in_4_ready                    (_resp_arb_io_in_4_ready),
    .io_in_5_ready                    (_resp_arb_io_in_5_ready),
    .io_in_6_ready                    (_resp_arb_io_in_6_ready),
    .io_in_7_ready                    (_resp_arb_io_in_7_ready),
    .io_in_8_ready                    (_resp_arb_io_in_8_ready),
    .io_out_valid                     (_resp_arb_io_out_valid),
    .io_out_bits_uop_uopc             (_resp_arb_io_out_bits_uop_uopc),
    .io_out_bits_uop_inst             (_resp_arb_io_out_bits_uop_inst),
    .io_out_bits_uop_debug_inst       (_resp_arb_io_out_bits_uop_debug_inst),
    .io_out_bits_uop_is_rvc           (_resp_arb_io_out_bits_uop_is_rvc),
    .io_out_bits_uop_debug_pc         (_resp_arb_io_out_bits_uop_debug_pc),
    .io_out_bits_uop_iq_type          (_resp_arb_io_out_bits_uop_iq_type),
    .io_out_bits_uop_fu_code          (_resp_arb_io_out_bits_uop_fu_code),
    .io_out_bits_uop_ctrl_br_type     (_resp_arb_io_out_bits_uop_ctrl_br_type),
    .io_out_bits_uop_ctrl_op1_sel     (_resp_arb_io_out_bits_uop_ctrl_op1_sel),
    .io_out_bits_uop_ctrl_op2_sel     (_resp_arb_io_out_bits_uop_ctrl_op2_sel),
    .io_out_bits_uop_ctrl_imm_sel     (_resp_arb_io_out_bits_uop_ctrl_imm_sel),
    .io_out_bits_uop_ctrl_op_fcn      (_resp_arb_io_out_bits_uop_ctrl_op_fcn),
    .io_out_bits_uop_ctrl_fcn_dw      (_resp_arb_io_out_bits_uop_ctrl_fcn_dw),
    .io_out_bits_uop_ctrl_csr_cmd     (_resp_arb_io_out_bits_uop_ctrl_csr_cmd),
    .io_out_bits_uop_ctrl_is_load     (_resp_arb_io_out_bits_uop_ctrl_is_load),
    .io_out_bits_uop_ctrl_is_sta      (_resp_arb_io_out_bits_uop_ctrl_is_sta),
    .io_out_bits_uop_ctrl_is_std      (_resp_arb_io_out_bits_uop_ctrl_is_std),
    .io_out_bits_uop_iw_state         (_resp_arb_io_out_bits_uop_iw_state),
    .io_out_bits_uop_iw_p1_poisoned   (_resp_arb_io_out_bits_uop_iw_p1_poisoned),
    .io_out_bits_uop_iw_p2_poisoned   (_resp_arb_io_out_bits_uop_iw_p2_poisoned),
    .io_out_bits_uop_is_br            (_resp_arb_io_out_bits_uop_is_br),
    .io_out_bits_uop_is_jalr          (_resp_arb_io_out_bits_uop_is_jalr),
    .io_out_bits_uop_is_jal           (_resp_arb_io_out_bits_uop_is_jal),
    .io_out_bits_uop_is_sfb           (_resp_arb_io_out_bits_uop_is_sfb),
    .io_out_bits_uop_br_mask          (_resp_arb_io_out_bits_uop_br_mask),
    .io_out_bits_uop_br_tag           (_resp_arb_io_out_bits_uop_br_tag),
    .io_out_bits_uop_ftq_idx          (_resp_arb_io_out_bits_uop_ftq_idx),
    .io_out_bits_uop_edge_inst        (_resp_arb_io_out_bits_uop_edge_inst),
    .io_out_bits_uop_pc_lob           (_resp_arb_io_out_bits_uop_pc_lob),
    .io_out_bits_uop_taken            (_resp_arb_io_out_bits_uop_taken),
    .io_out_bits_uop_imm_packed       (_resp_arb_io_out_bits_uop_imm_packed),
    .io_out_bits_uop_csr_addr         (_resp_arb_io_out_bits_uop_csr_addr),
    .io_out_bits_uop_rob_idx          (_resp_arb_io_out_bits_uop_rob_idx),
    .io_out_bits_uop_ldq_idx          (_resp_arb_io_out_bits_uop_ldq_idx),
    .io_out_bits_uop_stq_idx          (_resp_arb_io_out_bits_uop_stq_idx),
    .io_out_bits_uop_rxq_idx          (_resp_arb_io_out_bits_uop_rxq_idx),
    .io_out_bits_uop_pdst             (_resp_arb_io_out_bits_uop_pdst),
    .io_out_bits_uop_prs1             (_resp_arb_io_out_bits_uop_prs1),
    .io_out_bits_uop_prs2             (_resp_arb_io_out_bits_uop_prs2),
    .io_out_bits_uop_prs3             (_resp_arb_io_out_bits_uop_prs3),
    .io_out_bits_uop_ppred            (_resp_arb_io_out_bits_uop_ppred),
    .io_out_bits_uop_prs1_busy        (_resp_arb_io_out_bits_uop_prs1_busy),
    .io_out_bits_uop_prs2_busy        (_resp_arb_io_out_bits_uop_prs2_busy),
    .io_out_bits_uop_prs3_busy        (_resp_arb_io_out_bits_uop_prs3_busy),
    .io_out_bits_uop_ppred_busy       (_resp_arb_io_out_bits_uop_ppred_busy),
    .io_out_bits_uop_stale_pdst       (_resp_arb_io_out_bits_uop_stale_pdst),
    .io_out_bits_uop_exception        (_resp_arb_io_out_bits_uop_exception),
    .io_out_bits_uop_exc_cause        (_resp_arb_io_out_bits_uop_exc_cause),
    .io_out_bits_uop_bypassable       (_resp_arb_io_out_bits_uop_bypassable),
    .io_out_bits_uop_mem_cmd          (_resp_arb_io_out_bits_uop_mem_cmd),
    .io_out_bits_uop_mem_size         (_resp_arb_io_out_bits_uop_mem_size),
    .io_out_bits_uop_mem_signed       (_resp_arb_io_out_bits_uop_mem_signed),
    .io_out_bits_uop_is_fence         (_resp_arb_io_out_bits_uop_is_fence),
    .io_out_bits_uop_is_fencei        (_resp_arb_io_out_bits_uop_is_fencei),
    .io_out_bits_uop_is_amo           (_resp_arb_io_out_bits_uop_is_amo),
    .io_out_bits_uop_uses_ldq         (_resp_arb_io_out_bits_uop_uses_ldq),
    .io_out_bits_uop_uses_stq         (_resp_arb_io_out_bits_uop_uses_stq),
    .io_out_bits_uop_is_sys_pc2epc    (_resp_arb_io_out_bits_uop_is_sys_pc2epc),
    .io_out_bits_uop_is_unique        (_resp_arb_io_out_bits_uop_is_unique),
    .io_out_bits_uop_flush_on_commit  (_resp_arb_io_out_bits_uop_flush_on_commit),
    .io_out_bits_uop_ldst_is_rs1      (_resp_arb_io_out_bits_uop_ldst_is_rs1),
    .io_out_bits_uop_ldst             (_resp_arb_io_out_bits_uop_ldst),
    .io_out_bits_uop_lrs1             (_resp_arb_io_out_bits_uop_lrs1),
    .io_out_bits_uop_lrs2             (_resp_arb_io_out_bits_uop_lrs2),
    .io_out_bits_uop_lrs3             (_resp_arb_io_out_bits_uop_lrs3),
    .io_out_bits_uop_ldst_val         (_resp_arb_io_out_bits_uop_ldst_val),
    .io_out_bits_uop_dst_rtype        (_resp_arb_io_out_bits_uop_dst_rtype),
    .io_out_bits_uop_lrs1_rtype       (_resp_arb_io_out_bits_uop_lrs1_rtype),
    .io_out_bits_uop_lrs2_rtype       (_resp_arb_io_out_bits_uop_lrs2_rtype),
    .io_out_bits_uop_frs3_en          (_resp_arb_io_out_bits_uop_frs3_en),
    .io_out_bits_uop_fp_val           (_resp_arb_io_out_bits_uop_fp_val),
    .io_out_bits_uop_fp_single        (_resp_arb_io_out_bits_uop_fp_single),
    .io_out_bits_uop_xcpt_pf_if       (_resp_arb_io_out_bits_uop_xcpt_pf_if),
    .io_out_bits_uop_xcpt_ae_if       (_resp_arb_io_out_bits_uop_xcpt_ae_if),
    .io_out_bits_uop_xcpt_ma_if       (_resp_arb_io_out_bits_uop_xcpt_ma_if),
    .io_out_bits_uop_bp_debug_if      (_resp_arb_io_out_bits_uop_bp_debug_if),
    .io_out_bits_uop_bp_xcpt_if       (_resp_arb_io_out_bits_uop_bp_xcpt_if),
    .io_out_bits_uop_debug_fsrc       (_resp_arb_io_out_bits_uop_debug_fsrc),
    .io_out_bits_uop_debug_tsrc       (_resp_arb_io_out_bits_uop_debug_tsrc),
    .io_out_bits_data                 (_resp_arb_io_out_bits_data),
    .io_out_bits_is_hella             (_resp_arb_io_out_bits_is_hella)
  );
  Arbiter_10 refill_arb (	// mshrs.scala:604:30
    .io_in_0_valid       (_mshrs_0_io_refill_valid),	// mshrs.scala:620:22
    .io_in_0_bits_way_en (_mshrs_0_io_refill_bits_way_en),	// mshrs.scala:620:22
    .io_in_0_bits_addr   (_mshrs_0_io_refill_bits_addr),	// mshrs.scala:620:22
    .io_in_0_bits_data   (_mshrs_0_io_refill_bits_data),	// mshrs.scala:620:22
    .io_in_1_valid       (_mshrs_1_io_refill_valid),	// mshrs.scala:620:22
    .io_in_1_bits_way_en (_mshrs_1_io_refill_bits_way_en),	// mshrs.scala:620:22
    .io_in_1_bits_addr   (_mshrs_1_io_refill_bits_addr),	// mshrs.scala:620:22
    .io_in_1_bits_data   (_mshrs_1_io_refill_bits_data),	// mshrs.scala:620:22
    .io_in_2_valid       (_mshrs_2_io_refill_valid),	// mshrs.scala:620:22
    .io_in_2_bits_way_en (_mshrs_2_io_refill_bits_way_en),	// mshrs.scala:620:22
    .io_in_2_bits_addr   (_mshrs_2_io_refill_bits_addr),	// mshrs.scala:620:22
    .io_in_2_bits_data   (_mshrs_2_io_refill_bits_data),	// mshrs.scala:620:22
    .io_in_3_valid       (_mshrs_3_io_refill_valid),	// mshrs.scala:620:22
    .io_in_3_bits_way_en (_mshrs_3_io_refill_bits_way_en),	// mshrs.scala:620:22
    .io_in_3_bits_addr   (_mshrs_3_io_refill_bits_addr),	// mshrs.scala:620:22
    .io_in_3_bits_data   (_mshrs_3_io_refill_bits_data),	// mshrs.scala:620:22
    .io_in_4_valid       (_mshrs_4_io_refill_valid),	// mshrs.scala:620:22
    .io_in_4_bits_way_en (_mshrs_4_io_refill_bits_way_en),	// mshrs.scala:620:22
    .io_in_4_bits_addr   (_mshrs_4_io_refill_bits_addr),	// mshrs.scala:620:22
    .io_in_4_bits_data   (_mshrs_4_io_refill_bits_data),	// mshrs.scala:620:22
    .io_in_5_valid       (_mshrs_5_io_refill_valid),	// mshrs.scala:620:22
    .io_in_5_bits_way_en (_mshrs_5_io_refill_bits_way_en),	// mshrs.scala:620:22
    .io_in_5_bits_addr   (_mshrs_5_io_refill_bits_addr),	// mshrs.scala:620:22
    .io_in_5_bits_data   (_mshrs_5_io_refill_bits_data),	// mshrs.scala:620:22
    .io_in_6_valid       (_mshrs_6_io_refill_valid),	// mshrs.scala:620:22
    .io_in_6_bits_way_en (_mshrs_6_io_refill_bits_way_en),	// mshrs.scala:620:22
    .io_in_6_bits_addr   (_mshrs_6_io_refill_bits_addr),	// mshrs.scala:620:22
    .io_in_6_bits_data   (_mshrs_6_io_refill_bits_data),	// mshrs.scala:620:22
    .io_in_7_valid       (_mshrs_7_io_refill_valid),	// mshrs.scala:620:22
    .io_in_7_bits_way_en (_mshrs_7_io_refill_bits_way_en),	// mshrs.scala:620:22
    .io_in_7_bits_addr   (_mshrs_7_io_refill_bits_addr),	// mshrs.scala:620:22
    .io_in_7_bits_data   (_mshrs_7_io_refill_bits_data),	// mshrs.scala:620:22
    .io_out_ready        (io_refill_ready),
    .io_in_0_ready       (_refill_arb_io_in_0_ready),
    .io_in_1_ready       (_refill_arb_io_in_1_ready),
    .io_in_2_ready       (_refill_arb_io_in_2_ready),
    .io_in_3_ready       (_refill_arb_io_in_3_ready),
    .io_in_4_ready       (_refill_arb_io_in_4_ready),
    .io_in_5_ready       (_refill_arb_io_in_5_ready),
    .io_in_6_ready       (_refill_arb_io_in_6_ready),
    .io_in_7_ready       (_refill_arb_io_in_7_ready),
    .io_out_valid        (io_refill_valid),
    .io_out_bits_way_en  (io_refill_bits_way_en),
    .io_out_bits_addr    (io_refill_bits_addr),
    .io_out_bits_data    (io_refill_bits_data)
  );
  BoomMSHR mshrs_0 (	// mshrs.scala:620:22
    .clock                              (clock),
    .reset                              (reset),
    .io_id                              (3'h0),	// mshrs.scala:621:16
    .io_req_pri_val                     (_mshr_io_req_pri_val_T & pri_val),	// mshrs.scala:618:51, :632:{34,54}
    .io_req_sec_val                     (_mshr_io_req_sec_val_T_3),	// mshrs.scala:637:99
    .io_clear_prefetch
      (io_clear_all & ~_GEN | _GEN & _GEN_87 & cacheable & ~_GEN_86 | io_req_is_probe_0
       & _GEN_87),	// Parameters.scala:137:31, :671:42, mshrs.scala:637:{50,72}, :644:{46,49}, :645:{58,61,82}, :646:21
    .io_brupdate_b1_resolve_mask        (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask     (io_brupdate_b1_mispredict_mask),
    .io_exception                       (io_exception),
    .io_req_uop_uopc                    (_GEN_0),	// Parameters.scala:137:31
    .io_req_uop_inst                    (_GEN_1),	// Parameters.scala:137:31
    .io_req_uop_debug_inst              (_GEN_2),	// Parameters.scala:137:31
    .io_req_uop_is_rvc                  (_GEN_3),	// Parameters.scala:137:31
    .io_req_uop_debug_pc                (_GEN_4),	// Parameters.scala:137:31
    .io_req_uop_iq_type                 (_GEN_5),	// Parameters.scala:137:31
    .io_req_uop_fu_code                 (_GEN_6),	// Parameters.scala:137:31
    .io_req_uop_ctrl_br_type            (_GEN_7),	// Parameters.scala:137:31
    .io_req_uop_ctrl_op1_sel            (_GEN_8),	// Parameters.scala:137:31
    .io_req_uop_ctrl_op2_sel            (_GEN_9),	// Parameters.scala:137:31
    .io_req_uop_ctrl_imm_sel            (_GEN_10),	// Parameters.scala:137:31
    .io_req_uop_ctrl_op_fcn             (_GEN_11),	// Parameters.scala:137:31
    .io_req_uop_ctrl_fcn_dw             (_GEN_12),	// Parameters.scala:137:31
    .io_req_uop_ctrl_csr_cmd            (_GEN_13),	// Parameters.scala:137:31
    .io_req_uop_ctrl_is_load            (_GEN_14),	// Parameters.scala:137:31
    .io_req_uop_ctrl_is_sta             (_GEN_15),	// Parameters.scala:137:31
    .io_req_uop_ctrl_is_std             (_GEN_16),	// Parameters.scala:137:31
    .io_req_uop_iw_state                (_GEN_17),	// Parameters.scala:137:31
    .io_req_uop_iw_p1_poisoned          (_GEN_18),	// Parameters.scala:137:31
    .io_req_uop_iw_p2_poisoned          (_GEN_19),	// Parameters.scala:137:31
    .io_req_uop_is_br                   (_GEN_20),	// Parameters.scala:137:31
    .io_req_uop_is_jalr                 (_GEN_21),	// Parameters.scala:137:31
    .io_req_uop_is_jal                  (_GEN_22),	// Parameters.scala:137:31
    .io_req_uop_is_sfb                  (_GEN_23),	// Parameters.scala:137:31
    .io_req_uop_br_mask                 (_GEN_24),	// Parameters.scala:137:31
    .io_req_uop_br_tag                  (_GEN_25),	// Parameters.scala:137:31
    .io_req_uop_ftq_idx                 (_GEN_26),	// Parameters.scala:137:31
    .io_req_uop_edge_inst               (_GEN_27),	// Parameters.scala:137:31
    .io_req_uop_pc_lob                  (_GEN_28),	// Parameters.scala:137:31
    .io_req_uop_taken                   (_GEN_29),	// Parameters.scala:137:31
    .io_req_uop_imm_packed              (_GEN_30),	// Parameters.scala:137:31
    .io_req_uop_csr_addr                (_GEN_31),	// Parameters.scala:137:31
    .io_req_uop_rob_idx                 (_GEN_32),	// Parameters.scala:137:31
    .io_req_uop_ldq_idx                 (_GEN_33),	// Parameters.scala:137:31
    .io_req_uop_stq_idx                 (_GEN_34),	// Parameters.scala:137:31
    .io_req_uop_rxq_idx                 (_GEN_35),	// Parameters.scala:137:31
    .io_req_uop_pdst                    (_GEN_36),	// Parameters.scala:137:31
    .io_req_uop_prs1                    (_GEN_37),	// Parameters.scala:137:31
    .io_req_uop_prs2                    (_GEN_38),	// Parameters.scala:137:31
    .io_req_uop_prs3                    (_GEN_39),	// Parameters.scala:137:31
    .io_req_uop_ppred                   (_GEN_40),	// Parameters.scala:137:31
    .io_req_uop_prs1_busy               (_GEN_41),	// Parameters.scala:137:31
    .io_req_uop_prs2_busy               (_GEN_42),	// Parameters.scala:137:31
    .io_req_uop_prs3_busy               (_GEN_43),	// Parameters.scala:137:31
    .io_req_uop_ppred_busy              (_GEN_44),	// Parameters.scala:137:31
    .io_req_uop_stale_pdst              (_GEN_45),	// Parameters.scala:137:31
    .io_req_uop_exception               (_GEN_46),	// Parameters.scala:137:31
    .io_req_uop_exc_cause               (_GEN_47),	// Parameters.scala:137:31
    .io_req_uop_bypassable              (_GEN_48),	// Parameters.scala:137:31
    .io_req_uop_mem_cmd                 (_GEN_49),	// Parameters.scala:137:31
    .io_req_uop_mem_size                (_GEN_50),	// Parameters.scala:137:31
    .io_req_uop_mem_signed              (_GEN_51),	// Parameters.scala:137:31
    .io_req_uop_is_fence                (_GEN_52),	// Parameters.scala:137:31
    .io_req_uop_is_fencei               (_GEN_53),	// Parameters.scala:137:31
    .io_req_uop_is_amo                  (_GEN_54),	// Parameters.scala:137:31
    .io_req_uop_uses_ldq                (_GEN_55),	// Parameters.scala:137:31
    .io_req_uop_uses_stq                (_GEN_56),	// Parameters.scala:137:31
    .io_req_uop_is_sys_pc2epc           (_GEN_57),	// Parameters.scala:137:31
    .io_req_uop_is_unique               (_GEN_58),	// Parameters.scala:137:31
    .io_req_uop_flush_on_commit         (_GEN_59),	// Parameters.scala:137:31
    .io_req_uop_ldst_is_rs1             (_GEN_60),	// Parameters.scala:137:31
    .io_req_uop_ldst                    (_GEN_61),	// Parameters.scala:137:31
    .io_req_uop_lrs1                    (_GEN_62),	// Parameters.scala:137:31
    .io_req_uop_lrs2                    (_GEN_63),	// Parameters.scala:137:31
    .io_req_uop_lrs3                    (_GEN_64),	// Parameters.scala:137:31
    .io_req_uop_ldst_val                (_GEN_65),	// Parameters.scala:137:31
    .io_req_uop_dst_rtype               (_GEN_66),	// Parameters.scala:137:31
    .io_req_uop_lrs1_rtype              (_GEN_67),	// Parameters.scala:137:31
    .io_req_uop_lrs2_rtype              (_GEN_68),	// Parameters.scala:137:31
    .io_req_uop_frs3_en                 (_GEN_69),	// Parameters.scala:137:31
    .io_req_uop_fp_val                  (_GEN_70),	// Parameters.scala:137:31
    .io_req_uop_fp_single               (_GEN_71),	// Parameters.scala:137:31
    .io_req_uop_xcpt_pf_if              (_GEN_72),	// Parameters.scala:137:31
    .io_req_uop_xcpt_ae_if              (_GEN_73),	// Parameters.scala:137:31
    .io_req_uop_xcpt_ma_if              (_GEN_74),	// Parameters.scala:137:31
    .io_req_uop_bp_debug_if             (_GEN_75),	// Parameters.scala:137:31
    .io_req_uop_bp_xcpt_if              (_GEN_76),	// Parameters.scala:137:31
    .io_req_uop_debug_fsrc              (_GEN_77),	// Parameters.scala:137:31
    .io_req_uop_debug_tsrc              (_GEN_78),	// Parameters.scala:137:31
    .io_req_addr                        (_cacheable_T_1),	// Parameters.scala:137:31
    .io_req_data                        (_GEN_79),	// Parameters.scala:137:31
    .io_req_is_hella                    (_GEN_80),	// Parameters.scala:137:31
    .io_req_tag_match                   (_GEN_81),	// Parameters.scala:137:31
    .io_req_old_meta_coh_state          (_GEN_82),	// Parameters.scala:137:31
    .io_req_old_meta_tag                (_GEN_83),	// Parameters.scala:137:31
    .io_req_way_en                      (_GEN_84),	// Parameters.scala:137:31
    .io_req_sdq_id                      (sdq_alloc_id),	// Mux.scala:47:69
    .io_req_is_probe                    (io_req_is_probe_0),
    .io_mem_acquire_ready               (io_mem_acquire_ready & (idle | state_0)),	// Arbiter.scala:88:28, :116:26, :121:24, :123:31
    .io_mem_grant_valid                 (_GEN_95 & io_mem_grant_valid),	// mshrs.scala:671:29, :673:{36,45}, :674:25
    .io_mem_grant_bits_opcode           (io_mem_grant_bits_opcode),
    .io_mem_grant_bits_param            (io_mem_grant_bits_param),
    .io_mem_grant_bits_size             (io_mem_grant_bits_size),
    .io_mem_grant_bits_sink             (io_mem_grant_bits_sink),
    .io_mem_grant_bits_data             (io_mem_grant_bits_data),
    .io_mem_finish_ready
      (io_mem_finish_ready & (~beatsLeft_1 | state_1_0)),	// Arbiter.scala:87:30, :88:28, :116:26, :121:24, :123:31
    .io_prober_state_valid              (io_prober_state_valid),
    .io_prober_state_bits               (io_prober_state_bits),
    .io_refill_ready                    (_refill_arb_io_in_0_ready),	// mshrs.scala:604:30
    .io_meta_write_ready                (_meta_write_arb_io_in_0_ready),	// mshrs.scala:599:30
    .io_meta_read_ready                 (_meta_read_arb_io_in_0_ready),	// mshrs.scala:600:30
    .io_meta_resp_valid                 (io_meta_resp_valid),
    .io_meta_resp_bits_coh_state        (io_meta_resp_bits_coh_state),
    .io_wb_req_ready                    (_wb_req_arb_io_in_0_ready),	// mshrs.scala:601:30
    .io_lb_read_ready                   (_lb_read_arb_io_in_0_ready),	// mshrs.scala:569:28
    .io_lb_resp                         (lb_read_data),	// mshrs.scala:576:37, :580:38
    .io_lb_write_ready                  (1'h1),
    .io_replay_ready                    (_replay_arb_io_in_0_ready),	// mshrs.scala:602:30
    .io_resp_ready                      (_resp_arb_io_in_0_ready),	// mshrs.scala:603:30
    .io_wb_resp                         (io_wb_resp),
    .io_req_pri_rdy                     (_mshrs_0_io_req_pri_rdy),
    .io_req_sec_rdy                     (_mshrs_0_io_req_sec_rdy),
    .io_idx_valid                       (_mshrs_0_io_idx_valid),
    .io_idx_bits                        (_mshrs_0_io_idx_bits),
    .io_way_valid                       (_mshrs_0_io_way_valid),
    .io_way_bits                        (_mshrs_0_io_way_bits),
    .io_tag_valid                       (_mshrs_0_io_tag_valid),
    .io_tag_bits                        (_mshrs_0_io_tag_bits),
    .io_mem_acquire_valid               (_mshrs_0_io_mem_acquire_valid),
    .io_mem_acquire_bits_param          (_mshrs_0_io_mem_acquire_bits_param),
    .io_mem_acquire_bits_source         (_mshrs_0_io_mem_acquire_bits_source),
    .io_mem_acquire_bits_address        (_mshrs_0_io_mem_acquire_bits_address),
    .io_mem_grant_ready                 (_mshrs_0_io_mem_grant_ready),
    .io_mem_finish_valid                (_mshrs_0_io_mem_finish_valid),
    .io_mem_finish_bits_sink            (_mshrs_0_io_mem_finish_bits_sink),
    .io_refill_valid                    (_mshrs_0_io_refill_valid),
    .io_refill_bits_way_en              (_mshrs_0_io_refill_bits_way_en),
    .io_refill_bits_addr                (_mshrs_0_io_refill_bits_addr),
    .io_refill_bits_data                (_mshrs_0_io_refill_bits_data),
    .io_meta_write_valid                (_mshrs_0_io_meta_write_valid),
    .io_meta_write_bits_idx             (_mshrs_0_io_meta_write_bits_idx),
    .io_meta_write_bits_way_en          (_mshrs_0_io_meta_write_bits_way_en),
    .io_meta_write_bits_data_coh_state  (_mshrs_0_io_meta_write_bits_data_coh_state),
    .io_meta_write_bits_data_tag        (_mshrs_0_io_meta_write_bits_data_tag),
    .io_meta_read_valid                 (_mshrs_0_io_meta_read_valid),
    .io_meta_read_bits_idx              (_mshrs_0_io_meta_read_bits_idx),
    .io_meta_read_bits_way_en           (_mshrs_0_io_meta_read_bits_way_en),
    .io_meta_read_bits_tag              (_mshrs_0_io_meta_read_bits_tag),
    .io_wb_req_valid                    (_mshrs_0_io_wb_req_valid),
    .io_wb_req_bits_tag                 (_mshrs_0_io_wb_req_bits_tag),
    .io_wb_req_bits_idx                 (_mshrs_0_io_wb_req_bits_idx),
    .io_wb_req_bits_param               (_mshrs_0_io_wb_req_bits_param),
    .io_wb_req_bits_way_en              (_mshrs_0_io_wb_req_bits_way_en),
    .io_commit_val                      (_mshrs_0_io_commit_val),
    .io_commit_addr                     (_mshrs_0_io_commit_addr),
    .io_commit_coh_state                (_mshrs_0_io_commit_coh_state),
    .io_lb_read_valid                   (_mshrs_0_io_lb_read_valid),
    .io_lb_read_bits_id                 (_mshrs_0_io_lb_read_bits_id),
    .io_lb_read_bits_offset             (_mshrs_0_io_lb_read_bits_offset),
    .io_lb_write_valid                  (_mshrs_0_io_lb_write_valid),
    .io_lb_write_bits_id                (_mshrs_0_io_lb_write_bits_id),
    .io_lb_write_bits_offset            (_mshrs_0_io_lb_write_bits_offset),
    .io_lb_write_bits_data              (_mshrs_0_io_lb_write_bits_data),
    .io_replay_valid                    (_mshrs_0_io_replay_valid),
    .io_replay_bits_uop_uopc            (_mshrs_0_io_replay_bits_uop_uopc),
    .io_replay_bits_uop_inst            (_mshrs_0_io_replay_bits_uop_inst),
    .io_replay_bits_uop_debug_inst      (_mshrs_0_io_replay_bits_uop_debug_inst),
    .io_replay_bits_uop_is_rvc          (_mshrs_0_io_replay_bits_uop_is_rvc),
    .io_replay_bits_uop_debug_pc        (_mshrs_0_io_replay_bits_uop_debug_pc),
    .io_replay_bits_uop_iq_type         (_mshrs_0_io_replay_bits_uop_iq_type),
    .io_replay_bits_uop_fu_code         (_mshrs_0_io_replay_bits_uop_fu_code),
    .io_replay_bits_uop_ctrl_br_type    (_mshrs_0_io_replay_bits_uop_ctrl_br_type),
    .io_replay_bits_uop_ctrl_op1_sel    (_mshrs_0_io_replay_bits_uop_ctrl_op1_sel),
    .io_replay_bits_uop_ctrl_op2_sel    (_mshrs_0_io_replay_bits_uop_ctrl_op2_sel),
    .io_replay_bits_uop_ctrl_imm_sel    (_mshrs_0_io_replay_bits_uop_ctrl_imm_sel),
    .io_replay_bits_uop_ctrl_op_fcn     (_mshrs_0_io_replay_bits_uop_ctrl_op_fcn),
    .io_replay_bits_uop_ctrl_fcn_dw     (_mshrs_0_io_replay_bits_uop_ctrl_fcn_dw),
    .io_replay_bits_uop_ctrl_csr_cmd    (_mshrs_0_io_replay_bits_uop_ctrl_csr_cmd),
    .io_replay_bits_uop_ctrl_is_load    (_mshrs_0_io_replay_bits_uop_ctrl_is_load),
    .io_replay_bits_uop_ctrl_is_sta     (_mshrs_0_io_replay_bits_uop_ctrl_is_sta),
    .io_replay_bits_uop_ctrl_is_std     (_mshrs_0_io_replay_bits_uop_ctrl_is_std),
    .io_replay_bits_uop_iw_state        (_mshrs_0_io_replay_bits_uop_iw_state),
    .io_replay_bits_uop_iw_p1_poisoned  (_mshrs_0_io_replay_bits_uop_iw_p1_poisoned),
    .io_replay_bits_uop_iw_p2_poisoned  (_mshrs_0_io_replay_bits_uop_iw_p2_poisoned),
    .io_replay_bits_uop_is_br           (_mshrs_0_io_replay_bits_uop_is_br),
    .io_replay_bits_uop_is_jalr         (_mshrs_0_io_replay_bits_uop_is_jalr),
    .io_replay_bits_uop_is_jal          (_mshrs_0_io_replay_bits_uop_is_jal),
    .io_replay_bits_uop_is_sfb          (_mshrs_0_io_replay_bits_uop_is_sfb),
    .io_replay_bits_uop_br_mask         (_mshrs_0_io_replay_bits_uop_br_mask),
    .io_replay_bits_uop_br_tag          (_mshrs_0_io_replay_bits_uop_br_tag),
    .io_replay_bits_uop_ftq_idx         (_mshrs_0_io_replay_bits_uop_ftq_idx),
    .io_replay_bits_uop_edge_inst       (_mshrs_0_io_replay_bits_uop_edge_inst),
    .io_replay_bits_uop_pc_lob          (_mshrs_0_io_replay_bits_uop_pc_lob),
    .io_replay_bits_uop_taken           (_mshrs_0_io_replay_bits_uop_taken),
    .io_replay_bits_uop_imm_packed      (_mshrs_0_io_replay_bits_uop_imm_packed),
    .io_replay_bits_uop_csr_addr        (_mshrs_0_io_replay_bits_uop_csr_addr),
    .io_replay_bits_uop_rob_idx         (_mshrs_0_io_replay_bits_uop_rob_idx),
    .io_replay_bits_uop_ldq_idx         (_mshrs_0_io_replay_bits_uop_ldq_idx),
    .io_replay_bits_uop_stq_idx         (_mshrs_0_io_replay_bits_uop_stq_idx),
    .io_replay_bits_uop_rxq_idx         (_mshrs_0_io_replay_bits_uop_rxq_idx),
    .io_replay_bits_uop_pdst            (_mshrs_0_io_replay_bits_uop_pdst),
    .io_replay_bits_uop_prs1            (_mshrs_0_io_replay_bits_uop_prs1),
    .io_replay_bits_uop_prs2            (_mshrs_0_io_replay_bits_uop_prs2),
    .io_replay_bits_uop_prs3            (_mshrs_0_io_replay_bits_uop_prs3),
    .io_replay_bits_uop_ppred           (_mshrs_0_io_replay_bits_uop_ppred),
    .io_replay_bits_uop_prs1_busy       (_mshrs_0_io_replay_bits_uop_prs1_busy),
    .io_replay_bits_uop_prs2_busy       (_mshrs_0_io_replay_bits_uop_prs2_busy),
    .io_replay_bits_uop_prs3_busy       (_mshrs_0_io_replay_bits_uop_prs3_busy),
    .io_replay_bits_uop_ppred_busy      (_mshrs_0_io_replay_bits_uop_ppred_busy),
    .io_replay_bits_uop_stale_pdst      (_mshrs_0_io_replay_bits_uop_stale_pdst),
    .io_replay_bits_uop_exception       (_mshrs_0_io_replay_bits_uop_exception),
    .io_replay_bits_uop_exc_cause       (_mshrs_0_io_replay_bits_uop_exc_cause),
    .io_replay_bits_uop_bypassable      (_mshrs_0_io_replay_bits_uop_bypassable),
    .io_replay_bits_uop_mem_cmd         (_mshrs_0_io_replay_bits_uop_mem_cmd),
    .io_replay_bits_uop_mem_size        (_mshrs_0_io_replay_bits_uop_mem_size),
    .io_replay_bits_uop_mem_signed      (_mshrs_0_io_replay_bits_uop_mem_signed),
    .io_replay_bits_uop_is_fence        (_mshrs_0_io_replay_bits_uop_is_fence),
    .io_replay_bits_uop_is_fencei       (_mshrs_0_io_replay_bits_uop_is_fencei),
    .io_replay_bits_uop_is_amo          (_mshrs_0_io_replay_bits_uop_is_amo),
    .io_replay_bits_uop_uses_ldq        (_mshrs_0_io_replay_bits_uop_uses_ldq),
    .io_replay_bits_uop_uses_stq        (_mshrs_0_io_replay_bits_uop_uses_stq),
    .io_replay_bits_uop_is_sys_pc2epc   (_mshrs_0_io_replay_bits_uop_is_sys_pc2epc),
    .io_replay_bits_uop_is_unique       (_mshrs_0_io_replay_bits_uop_is_unique),
    .io_replay_bits_uop_flush_on_commit (_mshrs_0_io_replay_bits_uop_flush_on_commit),
    .io_replay_bits_uop_ldst_is_rs1     (_mshrs_0_io_replay_bits_uop_ldst_is_rs1),
    .io_replay_bits_uop_ldst            (_mshrs_0_io_replay_bits_uop_ldst),
    .io_replay_bits_uop_lrs1            (_mshrs_0_io_replay_bits_uop_lrs1),
    .io_replay_bits_uop_lrs2            (_mshrs_0_io_replay_bits_uop_lrs2),
    .io_replay_bits_uop_lrs3            (_mshrs_0_io_replay_bits_uop_lrs3),
    .io_replay_bits_uop_ldst_val        (_mshrs_0_io_replay_bits_uop_ldst_val),
    .io_replay_bits_uop_dst_rtype       (_mshrs_0_io_replay_bits_uop_dst_rtype),
    .io_replay_bits_uop_lrs1_rtype      (_mshrs_0_io_replay_bits_uop_lrs1_rtype),
    .io_replay_bits_uop_lrs2_rtype      (_mshrs_0_io_replay_bits_uop_lrs2_rtype),
    .io_replay_bits_uop_frs3_en         (_mshrs_0_io_replay_bits_uop_frs3_en),
    .io_replay_bits_uop_fp_val          (_mshrs_0_io_replay_bits_uop_fp_val),
    .io_replay_bits_uop_fp_single       (_mshrs_0_io_replay_bits_uop_fp_single),
    .io_replay_bits_uop_xcpt_pf_if      (_mshrs_0_io_replay_bits_uop_xcpt_pf_if),
    .io_replay_bits_uop_xcpt_ae_if      (_mshrs_0_io_replay_bits_uop_xcpt_ae_if),
    .io_replay_bits_uop_xcpt_ma_if      (_mshrs_0_io_replay_bits_uop_xcpt_ma_if),
    .io_replay_bits_uop_bp_debug_if     (_mshrs_0_io_replay_bits_uop_bp_debug_if),
    .io_replay_bits_uop_bp_xcpt_if      (_mshrs_0_io_replay_bits_uop_bp_xcpt_if),
    .io_replay_bits_uop_debug_fsrc      (_mshrs_0_io_replay_bits_uop_debug_fsrc),
    .io_replay_bits_uop_debug_tsrc      (_mshrs_0_io_replay_bits_uop_debug_tsrc),
    .io_replay_bits_addr                (_mshrs_0_io_replay_bits_addr),
    .io_replay_bits_is_hella            (_mshrs_0_io_replay_bits_is_hella),
    .io_replay_bits_way_en              (_mshrs_0_io_replay_bits_way_en),
    .io_replay_bits_sdq_id              (_mshrs_0_io_replay_bits_sdq_id),
    .io_resp_valid                      (_mshrs_0_io_resp_valid),
    .io_resp_bits_uop_uopc              (_mshrs_0_io_resp_bits_uop_uopc),
    .io_resp_bits_uop_inst              (_mshrs_0_io_resp_bits_uop_inst),
    .io_resp_bits_uop_debug_inst        (_mshrs_0_io_resp_bits_uop_debug_inst),
    .io_resp_bits_uop_is_rvc            (_mshrs_0_io_resp_bits_uop_is_rvc),
    .io_resp_bits_uop_debug_pc          (_mshrs_0_io_resp_bits_uop_debug_pc),
    .io_resp_bits_uop_iq_type           (_mshrs_0_io_resp_bits_uop_iq_type),
    .io_resp_bits_uop_fu_code           (_mshrs_0_io_resp_bits_uop_fu_code),
    .io_resp_bits_uop_ctrl_br_type      (_mshrs_0_io_resp_bits_uop_ctrl_br_type),
    .io_resp_bits_uop_ctrl_op1_sel      (_mshrs_0_io_resp_bits_uop_ctrl_op1_sel),
    .io_resp_bits_uop_ctrl_op2_sel      (_mshrs_0_io_resp_bits_uop_ctrl_op2_sel),
    .io_resp_bits_uop_ctrl_imm_sel      (_mshrs_0_io_resp_bits_uop_ctrl_imm_sel),
    .io_resp_bits_uop_ctrl_op_fcn       (_mshrs_0_io_resp_bits_uop_ctrl_op_fcn),
    .io_resp_bits_uop_ctrl_fcn_dw       (_mshrs_0_io_resp_bits_uop_ctrl_fcn_dw),
    .io_resp_bits_uop_ctrl_csr_cmd      (_mshrs_0_io_resp_bits_uop_ctrl_csr_cmd),
    .io_resp_bits_uop_ctrl_is_load      (_mshrs_0_io_resp_bits_uop_ctrl_is_load),
    .io_resp_bits_uop_ctrl_is_sta       (_mshrs_0_io_resp_bits_uop_ctrl_is_sta),
    .io_resp_bits_uop_ctrl_is_std       (_mshrs_0_io_resp_bits_uop_ctrl_is_std),
    .io_resp_bits_uop_iw_state          (_mshrs_0_io_resp_bits_uop_iw_state),
    .io_resp_bits_uop_iw_p1_poisoned    (_mshrs_0_io_resp_bits_uop_iw_p1_poisoned),
    .io_resp_bits_uop_iw_p2_poisoned    (_mshrs_0_io_resp_bits_uop_iw_p2_poisoned),
    .io_resp_bits_uop_is_br             (_mshrs_0_io_resp_bits_uop_is_br),
    .io_resp_bits_uop_is_jalr           (_mshrs_0_io_resp_bits_uop_is_jalr),
    .io_resp_bits_uop_is_jal            (_mshrs_0_io_resp_bits_uop_is_jal),
    .io_resp_bits_uop_is_sfb            (_mshrs_0_io_resp_bits_uop_is_sfb),
    .io_resp_bits_uop_br_mask           (_mshrs_0_io_resp_bits_uop_br_mask),
    .io_resp_bits_uop_br_tag            (_mshrs_0_io_resp_bits_uop_br_tag),
    .io_resp_bits_uop_ftq_idx           (_mshrs_0_io_resp_bits_uop_ftq_idx),
    .io_resp_bits_uop_edge_inst         (_mshrs_0_io_resp_bits_uop_edge_inst),
    .io_resp_bits_uop_pc_lob            (_mshrs_0_io_resp_bits_uop_pc_lob),
    .io_resp_bits_uop_taken             (_mshrs_0_io_resp_bits_uop_taken),
    .io_resp_bits_uop_imm_packed        (_mshrs_0_io_resp_bits_uop_imm_packed),
    .io_resp_bits_uop_csr_addr          (_mshrs_0_io_resp_bits_uop_csr_addr),
    .io_resp_bits_uop_rob_idx           (_mshrs_0_io_resp_bits_uop_rob_idx),
    .io_resp_bits_uop_ldq_idx           (_mshrs_0_io_resp_bits_uop_ldq_idx),
    .io_resp_bits_uop_stq_idx           (_mshrs_0_io_resp_bits_uop_stq_idx),
    .io_resp_bits_uop_rxq_idx           (_mshrs_0_io_resp_bits_uop_rxq_idx),
    .io_resp_bits_uop_pdst              (_mshrs_0_io_resp_bits_uop_pdst),
    .io_resp_bits_uop_prs1              (_mshrs_0_io_resp_bits_uop_prs1),
    .io_resp_bits_uop_prs2              (_mshrs_0_io_resp_bits_uop_prs2),
    .io_resp_bits_uop_prs3              (_mshrs_0_io_resp_bits_uop_prs3),
    .io_resp_bits_uop_ppred             (_mshrs_0_io_resp_bits_uop_ppred),
    .io_resp_bits_uop_prs1_busy         (_mshrs_0_io_resp_bits_uop_prs1_busy),
    .io_resp_bits_uop_prs2_busy         (_mshrs_0_io_resp_bits_uop_prs2_busy),
    .io_resp_bits_uop_prs3_busy         (_mshrs_0_io_resp_bits_uop_prs3_busy),
    .io_resp_bits_uop_ppred_busy        (_mshrs_0_io_resp_bits_uop_ppred_busy),
    .io_resp_bits_uop_stale_pdst        (_mshrs_0_io_resp_bits_uop_stale_pdst),
    .io_resp_bits_uop_exception         (_mshrs_0_io_resp_bits_uop_exception),
    .io_resp_bits_uop_exc_cause         (_mshrs_0_io_resp_bits_uop_exc_cause),
    .io_resp_bits_uop_bypassable        (_mshrs_0_io_resp_bits_uop_bypassable),
    .io_resp_bits_uop_mem_cmd           (_mshrs_0_io_resp_bits_uop_mem_cmd),
    .io_resp_bits_uop_mem_size          (_mshrs_0_io_resp_bits_uop_mem_size),
    .io_resp_bits_uop_mem_signed        (_mshrs_0_io_resp_bits_uop_mem_signed),
    .io_resp_bits_uop_is_fence          (_mshrs_0_io_resp_bits_uop_is_fence),
    .io_resp_bits_uop_is_fencei         (_mshrs_0_io_resp_bits_uop_is_fencei),
    .io_resp_bits_uop_is_amo            (_mshrs_0_io_resp_bits_uop_is_amo),
    .io_resp_bits_uop_uses_ldq          (_mshrs_0_io_resp_bits_uop_uses_ldq),
    .io_resp_bits_uop_uses_stq          (_mshrs_0_io_resp_bits_uop_uses_stq),
    .io_resp_bits_uop_is_sys_pc2epc     (_mshrs_0_io_resp_bits_uop_is_sys_pc2epc),
    .io_resp_bits_uop_is_unique         (_mshrs_0_io_resp_bits_uop_is_unique),
    .io_resp_bits_uop_flush_on_commit   (_mshrs_0_io_resp_bits_uop_flush_on_commit),
    .io_resp_bits_uop_ldst_is_rs1       (_mshrs_0_io_resp_bits_uop_ldst_is_rs1),
    .io_resp_bits_uop_ldst              (_mshrs_0_io_resp_bits_uop_ldst),
    .io_resp_bits_uop_lrs1              (_mshrs_0_io_resp_bits_uop_lrs1),
    .io_resp_bits_uop_lrs2              (_mshrs_0_io_resp_bits_uop_lrs2),
    .io_resp_bits_uop_lrs3              (_mshrs_0_io_resp_bits_uop_lrs3),
    .io_resp_bits_uop_ldst_val          (_mshrs_0_io_resp_bits_uop_ldst_val),
    .io_resp_bits_uop_dst_rtype         (_mshrs_0_io_resp_bits_uop_dst_rtype),
    .io_resp_bits_uop_lrs1_rtype        (_mshrs_0_io_resp_bits_uop_lrs1_rtype),
    .io_resp_bits_uop_lrs2_rtype        (_mshrs_0_io_resp_bits_uop_lrs2_rtype),
    .io_resp_bits_uop_frs3_en           (_mshrs_0_io_resp_bits_uop_frs3_en),
    .io_resp_bits_uop_fp_val            (_mshrs_0_io_resp_bits_uop_fp_val),
    .io_resp_bits_uop_fp_single         (_mshrs_0_io_resp_bits_uop_fp_single),
    .io_resp_bits_uop_xcpt_pf_if        (_mshrs_0_io_resp_bits_uop_xcpt_pf_if),
    .io_resp_bits_uop_xcpt_ae_if        (_mshrs_0_io_resp_bits_uop_xcpt_ae_if),
    .io_resp_bits_uop_xcpt_ma_if        (_mshrs_0_io_resp_bits_uop_xcpt_ma_if),
    .io_resp_bits_uop_bp_debug_if       (_mshrs_0_io_resp_bits_uop_bp_debug_if),
    .io_resp_bits_uop_bp_xcpt_if        (_mshrs_0_io_resp_bits_uop_bp_xcpt_if),
    .io_resp_bits_uop_debug_fsrc        (_mshrs_0_io_resp_bits_uop_debug_fsrc),
    .io_resp_bits_uop_debug_tsrc        (_mshrs_0_io_resp_bits_uop_debug_tsrc),
    .io_resp_bits_data                  (_mshrs_0_io_resp_bits_data),
    .io_resp_bits_is_hella              (_mshrs_0_io_resp_bits_is_hella),
    .io_probe_rdy                       (_mshrs_0_io_probe_rdy)
  );
  BoomMSHR mshrs_1 (	// mshrs.scala:620:22
    .clock                              (clock),
    .reset                              (reset),
    .io_id                              (3'h1),	// mshrs.scala:621:16
    .io_req_pri_val                     (mshr_alloc_idx_REG == 3'h1 & pri_val),	// mshrs.scala:618:51, :621:16, :632:{34,54}, :694:31
    .io_req_sec_val                     (_mshr_io_req_sec_val_T_7),	// mshrs.scala:637:99
    .io_clear_prefetch
      (io_clear_all & ~_GEN | _GEN & _GEN_88 & cacheable & ~_GEN_86 | io_req_is_probe_0
       & _GEN_88),	// Parameters.scala:137:31, :671:42, mshrs.scala:637:{50,72}, :644:{46,49}, :645:{58,61,82}, :646:21
    .io_brupdate_b1_resolve_mask        (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask     (io_brupdate_b1_mispredict_mask),
    .io_exception                       (io_exception),
    .io_req_uop_uopc                    (_GEN_0),	// Parameters.scala:137:31
    .io_req_uop_inst                    (_GEN_1),	// Parameters.scala:137:31
    .io_req_uop_debug_inst              (_GEN_2),	// Parameters.scala:137:31
    .io_req_uop_is_rvc                  (_GEN_3),	// Parameters.scala:137:31
    .io_req_uop_debug_pc                (_GEN_4),	// Parameters.scala:137:31
    .io_req_uop_iq_type                 (_GEN_5),	// Parameters.scala:137:31
    .io_req_uop_fu_code                 (_GEN_6),	// Parameters.scala:137:31
    .io_req_uop_ctrl_br_type            (_GEN_7),	// Parameters.scala:137:31
    .io_req_uop_ctrl_op1_sel            (_GEN_8),	// Parameters.scala:137:31
    .io_req_uop_ctrl_op2_sel            (_GEN_9),	// Parameters.scala:137:31
    .io_req_uop_ctrl_imm_sel            (_GEN_10),	// Parameters.scala:137:31
    .io_req_uop_ctrl_op_fcn             (_GEN_11),	// Parameters.scala:137:31
    .io_req_uop_ctrl_fcn_dw             (_GEN_12),	// Parameters.scala:137:31
    .io_req_uop_ctrl_csr_cmd            (_GEN_13),	// Parameters.scala:137:31
    .io_req_uop_ctrl_is_load            (_GEN_14),	// Parameters.scala:137:31
    .io_req_uop_ctrl_is_sta             (_GEN_15),	// Parameters.scala:137:31
    .io_req_uop_ctrl_is_std             (_GEN_16),	// Parameters.scala:137:31
    .io_req_uop_iw_state                (_GEN_17),	// Parameters.scala:137:31
    .io_req_uop_iw_p1_poisoned          (_GEN_18),	// Parameters.scala:137:31
    .io_req_uop_iw_p2_poisoned          (_GEN_19),	// Parameters.scala:137:31
    .io_req_uop_is_br                   (_GEN_20),	// Parameters.scala:137:31
    .io_req_uop_is_jalr                 (_GEN_21),	// Parameters.scala:137:31
    .io_req_uop_is_jal                  (_GEN_22),	// Parameters.scala:137:31
    .io_req_uop_is_sfb                  (_GEN_23),	// Parameters.scala:137:31
    .io_req_uop_br_mask                 (_GEN_24),	// Parameters.scala:137:31
    .io_req_uop_br_tag                  (_GEN_25),	// Parameters.scala:137:31
    .io_req_uop_ftq_idx                 (_GEN_26),	// Parameters.scala:137:31
    .io_req_uop_edge_inst               (_GEN_27),	// Parameters.scala:137:31
    .io_req_uop_pc_lob                  (_GEN_28),	// Parameters.scala:137:31
    .io_req_uop_taken                   (_GEN_29),	// Parameters.scala:137:31
    .io_req_uop_imm_packed              (_GEN_30),	// Parameters.scala:137:31
    .io_req_uop_csr_addr                (_GEN_31),	// Parameters.scala:137:31
    .io_req_uop_rob_idx                 (_GEN_32),	// Parameters.scala:137:31
    .io_req_uop_ldq_idx                 (_GEN_33),	// Parameters.scala:137:31
    .io_req_uop_stq_idx                 (_GEN_34),	// Parameters.scala:137:31
    .io_req_uop_rxq_idx                 (_GEN_35),	// Parameters.scala:137:31
    .io_req_uop_pdst                    (_GEN_36),	// Parameters.scala:137:31
    .io_req_uop_prs1                    (_GEN_37),	// Parameters.scala:137:31
    .io_req_uop_prs2                    (_GEN_38),	// Parameters.scala:137:31
    .io_req_uop_prs3                    (_GEN_39),	// Parameters.scala:137:31
    .io_req_uop_ppred                   (_GEN_40),	// Parameters.scala:137:31
    .io_req_uop_prs1_busy               (_GEN_41),	// Parameters.scala:137:31
    .io_req_uop_prs2_busy               (_GEN_42),	// Parameters.scala:137:31
    .io_req_uop_prs3_busy               (_GEN_43),	// Parameters.scala:137:31
    .io_req_uop_ppred_busy              (_GEN_44),	// Parameters.scala:137:31
    .io_req_uop_stale_pdst              (_GEN_45),	// Parameters.scala:137:31
    .io_req_uop_exception               (_GEN_46),	// Parameters.scala:137:31
    .io_req_uop_exc_cause               (_GEN_47),	// Parameters.scala:137:31
    .io_req_uop_bypassable              (_GEN_48),	// Parameters.scala:137:31
    .io_req_uop_mem_cmd                 (_GEN_49),	// Parameters.scala:137:31
    .io_req_uop_mem_size                (_GEN_50),	// Parameters.scala:137:31
    .io_req_uop_mem_signed              (_GEN_51),	// Parameters.scala:137:31
    .io_req_uop_is_fence                (_GEN_52),	// Parameters.scala:137:31
    .io_req_uop_is_fencei               (_GEN_53),	// Parameters.scala:137:31
    .io_req_uop_is_amo                  (_GEN_54),	// Parameters.scala:137:31
    .io_req_uop_uses_ldq                (_GEN_55),	// Parameters.scala:137:31
    .io_req_uop_uses_stq                (_GEN_56),	// Parameters.scala:137:31
    .io_req_uop_is_sys_pc2epc           (_GEN_57),	// Parameters.scala:137:31
    .io_req_uop_is_unique               (_GEN_58),	// Parameters.scala:137:31
    .io_req_uop_flush_on_commit         (_GEN_59),	// Parameters.scala:137:31
    .io_req_uop_ldst_is_rs1             (_GEN_60),	// Parameters.scala:137:31
    .io_req_uop_ldst                    (_GEN_61),	// Parameters.scala:137:31
    .io_req_uop_lrs1                    (_GEN_62),	// Parameters.scala:137:31
    .io_req_uop_lrs2                    (_GEN_63),	// Parameters.scala:137:31
    .io_req_uop_lrs3                    (_GEN_64),	// Parameters.scala:137:31
    .io_req_uop_ldst_val                (_GEN_65),	// Parameters.scala:137:31
    .io_req_uop_dst_rtype               (_GEN_66),	// Parameters.scala:137:31
    .io_req_uop_lrs1_rtype              (_GEN_67),	// Parameters.scala:137:31
    .io_req_uop_lrs2_rtype              (_GEN_68),	// Parameters.scala:137:31
    .io_req_uop_frs3_en                 (_GEN_69),	// Parameters.scala:137:31
    .io_req_uop_fp_val                  (_GEN_70),	// Parameters.scala:137:31
    .io_req_uop_fp_single               (_GEN_71),	// Parameters.scala:137:31
    .io_req_uop_xcpt_pf_if              (_GEN_72),	// Parameters.scala:137:31
    .io_req_uop_xcpt_ae_if              (_GEN_73),	// Parameters.scala:137:31
    .io_req_uop_xcpt_ma_if              (_GEN_74),	// Parameters.scala:137:31
    .io_req_uop_bp_debug_if             (_GEN_75),	// Parameters.scala:137:31
    .io_req_uop_bp_xcpt_if              (_GEN_76),	// Parameters.scala:137:31
    .io_req_uop_debug_fsrc              (_GEN_77),	// Parameters.scala:137:31
    .io_req_uop_debug_tsrc              (_GEN_78),	// Parameters.scala:137:31
    .io_req_addr                        (_cacheable_T_1),	// Parameters.scala:137:31
    .io_req_data                        (_GEN_79),	// Parameters.scala:137:31
    .io_req_is_hella                    (_GEN_80),	// Parameters.scala:137:31
    .io_req_tag_match                   (_GEN_81),	// Parameters.scala:137:31
    .io_req_old_meta_coh_state          (_GEN_82),	// Parameters.scala:137:31
    .io_req_old_meta_tag                (_GEN_83),	// Parameters.scala:137:31
    .io_req_way_en                      (_GEN_84),	// Parameters.scala:137:31
    .io_req_sdq_id                      (sdq_alloc_id),	// Mux.scala:47:69
    .io_req_is_probe                    (io_req_is_probe_0),
    .io_mem_acquire_ready
      (io_mem_acquire_ready & (idle ? ~_mshrs_0_io_mem_acquire_valid : state_1)),	// Arbiter.scala:16:61, :88:28, :116:26, :121:24, :123:31, mshrs.scala:620:22
    .io_mem_grant_valid                 (_GEN_96 & io_mem_grant_valid),	// mshrs.scala:671:29, :673:{36,45}, :674:25
    .io_mem_grant_bits_opcode           (io_mem_grant_bits_opcode),
    .io_mem_grant_bits_param            (io_mem_grant_bits_param),
    .io_mem_grant_bits_size             (io_mem_grant_bits_size),
    .io_mem_grant_bits_sink             (io_mem_grant_bits_sink),
    .io_mem_grant_bits_data             (io_mem_grant_bits_data),
    .io_mem_finish_ready
      (io_mem_finish_ready & (beatsLeft_1 ? state_1_1 : ~_mshrs_0_io_mem_finish_valid)),	// Arbiter.scala:16:61, :87:30, :116:26, :121:24, :123:31, mshrs.scala:620:22
    .io_prober_state_valid              (io_prober_state_valid),
    .io_prober_state_bits               (io_prober_state_bits),
    .io_refill_ready                    (_refill_arb_io_in_1_ready),	// mshrs.scala:604:30
    .io_meta_write_ready                (_meta_write_arb_io_in_1_ready),	// mshrs.scala:599:30
    .io_meta_read_ready                 (_meta_read_arb_io_in_1_ready),	// mshrs.scala:600:30
    .io_meta_resp_valid                 (io_meta_resp_valid),
    .io_meta_resp_bits_coh_state        (io_meta_resp_bits_coh_state),
    .io_wb_req_ready                    (_wb_req_arb_io_in_1_ready),	// mshrs.scala:601:30
    .io_lb_read_ready                   (_lb_read_arb_io_in_1_ready),	// mshrs.scala:569:28
    .io_lb_resp                         (lb_read_data),	// mshrs.scala:576:37, :580:38
    .io_lb_write_ready                  (_lb_write_arb_io_in_1_ready),	// mshrs.scala:570:28
    .io_replay_ready                    (_replay_arb_io_in_1_ready),	// mshrs.scala:602:30
    .io_resp_ready                      (_resp_arb_io_in_1_ready),	// mshrs.scala:603:30
    .io_wb_resp                         (io_wb_resp),
    .io_req_pri_rdy                     (_mshrs_1_io_req_pri_rdy),
    .io_req_sec_rdy                     (_mshrs_1_io_req_sec_rdy),
    .io_idx_valid                       (_mshrs_1_io_idx_valid),
    .io_idx_bits                        (_mshrs_1_io_idx_bits),
    .io_way_valid                       (_mshrs_1_io_way_valid),
    .io_way_bits                        (_mshrs_1_io_way_bits),
    .io_tag_valid                       (_mshrs_1_io_tag_valid),
    .io_tag_bits                        (_mshrs_1_io_tag_bits),
    .io_mem_acquire_valid               (_mshrs_1_io_mem_acquire_valid),
    .io_mem_acquire_bits_param          (_mshrs_1_io_mem_acquire_bits_param),
    .io_mem_acquire_bits_source         (_mshrs_1_io_mem_acquire_bits_source),
    .io_mem_acquire_bits_address        (_mshrs_1_io_mem_acquire_bits_address),
    .io_mem_grant_ready                 (_mshrs_1_io_mem_grant_ready),
    .io_mem_finish_valid                (_mshrs_1_io_mem_finish_valid),
    .io_mem_finish_bits_sink            (_mshrs_1_io_mem_finish_bits_sink),
    .io_refill_valid                    (_mshrs_1_io_refill_valid),
    .io_refill_bits_way_en              (_mshrs_1_io_refill_bits_way_en),
    .io_refill_bits_addr                (_mshrs_1_io_refill_bits_addr),
    .io_refill_bits_data                (_mshrs_1_io_refill_bits_data),
    .io_meta_write_valid                (_mshrs_1_io_meta_write_valid),
    .io_meta_write_bits_idx             (_mshrs_1_io_meta_write_bits_idx),
    .io_meta_write_bits_way_en          (_mshrs_1_io_meta_write_bits_way_en),
    .io_meta_write_bits_data_coh_state  (_mshrs_1_io_meta_write_bits_data_coh_state),
    .io_meta_write_bits_data_tag        (_mshrs_1_io_meta_write_bits_data_tag),
    .io_meta_read_valid                 (_mshrs_1_io_meta_read_valid),
    .io_meta_read_bits_idx              (_mshrs_1_io_meta_read_bits_idx),
    .io_meta_read_bits_way_en           (_mshrs_1_io_meta_read_bits_way_en),
    .io_meta_read_bits_tag              (_mshrs_1_io_meta_read_bits_tag),
    .io_wb_req_valid                    (_mshrs_1_io_wb_req_valid),
    .io_wb_req_bits_tag                 (_mshrs_1_io_wb_req_bits_tag),
    .io_wb_req_bits_idx                 (_mshrs_1_io_wb_req_bits_idx),
    .io_wb_req_bits_param               (_mshrs_1_io_wb_req_bits_param),
    .io_wb_req_bits_way_en              (_mshrs_1_io_wb_req_bits_way_en),
    .io_commit_val                      (_mshrs_1_io_commit_val),
    .io_commit_addr                     (_mshrs_1_io_commit_addr),
    .io_commit_coh_state                (_mshrs_1_io_commit_coh_state),
    .io_lb_read_valid                   (_mshrs_1_io_lb_read_valid),
    .io_lb_read_bits_id                 (_mshrs_1_io_lb_read_bits_id),
    .io_lb_read_bits_offset             (_mshrs_1_io_lb_read_bits_offset),
    .io_lb_write_valid                  (_mshrs_1_io_lb_write_valid),
    .io_lb_write_bits_id                (_mshrs_1_io_lb_write_bits_id),
    .io_lb_write_bits_offset            (_mshrs_1_io_lb_write_bits_offset),
    .io_lb_write_bits_data              (_mshrs_1_io_lb_write_bits_data),
    .io_replay_valid                    (_mshrs_1_io_replay_valid),
    .io_replay_bits_uop_uopc            (_mshrs_1_io_replay_bits_uop_uopc),
    .io_replay_bits_uop_inst            (_mshrs_1_io_replay_bits_uop_inst),
    .io_replay_bits_uop_debug_inst      (_mshrs_1_io_replay_bits_uop_debug_inst),
    .io_replay_bits_uop_is_rvc          (_mshrs_1_io_replay_bits_uop_is_rvc),
    .io_replay_bits_uop_debug_pc        (_mshrs_1_io_replay_bits_uop_debug_pc),
    .io_replay_bits_uop_iq_type         (_mshrs_1_io_replay_bits_uop_iq_type),
    .io_replay_bits_uop_fu_code         (_mshrs_1_io_replay_bits_uop_fu_code),
    .io_replay_bits_uop_ctrl_br_type    (_mshrs_1_io_replay_bits_uop_ctrl_br_type),
    .io_replay_bits_uop_ctrl_op1_sel    (_mshrs_1_io_replay_bits_uop_ctrl_op1_sel),
    .io_replay_bits_uop_ctrl_op2_sel    (_mshrs_1_io_replay_bits_uop_ctrl_op2_sel),
    .io_replay_bits_uop_ctrl_imm_sel    (_mshrs_1_io_replay_bits_uop_ctrl_imm_sel),
    .io_replay_bits_uop_ctrl_op_fcn     (_mshrs_1_io_replay_bits_uop_ctrl_op_fcn),
    .io_replay_bits_uop_ctrl_fcn_dw     (_mshrs_1_io_replay_bits_uop_ctrl_fcn_dw),
    .io_replay_bits_uop_ctrl_csr_cmd    (_mshrs_1_io_replay_bits_uop_ctrl_csr_cmd),
    .io_replay_bits_uop_ctrl_is_load    (_mshrs_1_io_replay_bits_uop_ctrl_is_load),
    .io_replay_bits_uop_ctrl_is_sta     (_mshrs_1_io_replay_bits_uop_ctrl_is_sta),
    .io_replay_bits_uop_ctrl_is_std     (_mshrs_1_io_replay_bits_uop_ctrl_is_std),
    .io_replay_bits_uop_iw_state        (_mshrs_1_io_replay_bits_uop_iw_state),
    .io_replay_bits_uop_iw_p1_poisoned  (_mshrs_1_io_replay_bits_uop_iw_p1_poisoned),
    .io_replay_bits_uop_iw_p2_poisoned  (_mshrs_1_io_replay_bits_uop_iw_p2_poisoned),
    .io_replay_bits_uop_is_br           (_mshrs_1_io_replay_bits_uop_is_br),
    .io_replay_bits_uop_is_jalr         (_mshrs_1_io_replay_bits_uop_is_jalr),
    .io_replay_bits_uop_is_jal          (_mshrs_1_io_replay_bits_uop_is_jal),
    .io_replay_bits_uop_is_sfb          (_mshrs_1_io_replay_bits_uop_is_sfb),
    .io_replay_bits_uop_br_mask         (_mshrs_1_io_replay_bits_uop_br_mask),
    .io_replay_bits_uop_br_tag          (_mshrs_1_io_replay_bits_uop_br_tag),
    .io_replay_bits_uop_ftq_idx         (_mshrs_1_io_replay_bits_uop_ftq_idx),
    .io_replay_bits_uop_edge_inst       (_mshrs_1_io_replay_bits_uop_edge_inst),
    .io_replay_bits_uop_pc_lob          (_mshrs_1_io_replay_bits_uop_pc_lob),
    .io_replay_bits_uop_taken           (_mshrs_1_io_replay_bits_uop_taken),
    .io_replay_bits_uop_imm_packed      (_mshrs_1_io_replay_bits_uop_imm_packed),
    .io_replay_bits_uop_csr_addr        (_mshrs_1_io_replay_bits_uop_csr_addr),
    .io_replay_bits_uop_rob_idx         (_mshrs_1_io_replay_bits_uop_rob_idx),
    .io_replay_bits_uop_ldq_idx         (_mshrs_1_io_replay_bits_uop_ldq_idx),
    .io_replay_bits_uop_stq_idx         (_mshrs_1_io_replay_bits_uop_stq_idx),
    .io_replay_bits_uop_rxq_idx         (_mshrs_1_io_replay_bits_uop_rxq_idx),
    .io_replay_bits_uop_pdst            (_mshrs_1_io_replay_bits_uop_pdst),
    .io_replay_bits_uop_prs1            (_mshrs_1_io_replay_bits_uop_prs1),
    .io_replay_bits_uop_prs2            (_mshrs_1_io_replay_bits_uop_prs2),
    .io_replay_bits_uop_prs3            (_mshrs_1_io_replay_bits_uop_prs3),
    .io_replay_bits_uop_ppred           (_mshrs_1_io_replay_bits_uop_ppred),
    .io_replay_bits_uop_prs1_busy       (_mshrs_1_io_replay_bits_uop_prs1_busy),
    .io_replay_bits_uop_prs2_busy       (_mshrs_1_io_replay_bits_uop_prs2_busy),
    .io_replay_bits_uop_prs3_busy       (_mshrs_1_io_replay_bits_uop_prs3_busy),
    .io_replay_bits_uop_ppred_busy      (_mshrs_1_io_replay_bits_uop_ppred_busy),
    .io_replay_bits_uop_stale_pdst      (_mshrs_1_io_replay_bits_uop_stale_pdst),
    .io_replay_bits_uop_exception       (_mshrs_1_io_replay_bits_uop_exception),
    .io_replay_bits_uop_exc_cause       (_mshrs_1_io_replay_bits_uop_exc_cause),
    .io_replay_bits_uop_bypassable      (_mshrs_1_io_replay_bits_uop_bypassable),
    .io_replay_bits_uop_mem_cmd         (_mshrs_1_io_replay_bits_uop_mem_cmd),
    .io_replay_bits_uop_mem_size        (_mshrs_1_io_replay_bits_uop_mem_size),
    .io_replay_bits_uop_mem_signed      (_mshrs_1_io_replay_bits_uop_mem_signed),
    .io_replay_bits_uop_is_fence        (_mshrs_1_io_replay_bits_uop_is_fence),
    .io_replay_bits_uop_is_fencei       (_mshrs_1_io_replay_bits_uop_is_fencei),
    .io_replay_bits_uop_is_amo          (_mshrs_1_io_replay_bits_uop_is_amo),
    .io_replay_bits_uop_uses_ldq        (_mshrs_1_io_replay_bits_uop_uses_ldq),
    .io_replay_bits_uop_uses_stq        (_mshrs_1_io_replay_bits_uop_uses_stq),
    .io_replay_bits_uop_is_sys_pc2epc   (_mshrs_1_io_replay_bits_uop_is_sys_pc2epc),
    .io_replay_bits_uop_is_unique       (_mshrs_1_io_replay_bits_uop_is_unique),
    .io_replay_bits_uop_flush_on_commit (_mshrs_1_io_replay_bits_uop_flush_on_commit),
    .io_replay_bits_uop_ldst_is_rs1     (_mshrs_1_io_replay_bits_uop_ldst_is_rs1),
    .io_replay_bits_uop_ldst            (_mshrs_1_io_replay_bits_uop_ldst),
    .io_replay_bits_uop_lrs1            (_mshrs_1_io_replay_bits_uop_lrs1),
    .io_replay_bits_uop_lrs2            (_mshrs_1_io_replay_bits_uop_lrs2),
    .io_replay_bits_uop_lrs3            (_mshrs_1_io_replay_bits_uop_lrs3),
    .io_replay_bits_uop_ldst_val        (_mshrs_1_io_replay_bits_uop_ldst_val),
    .io_replay_bits_uop_dst_rtype       (_mshrs_1_io_replay_bits_uop_dst_rtype),
    .io_replay_bits_uop_lrs1_rtype      (_mshrs_1_io_replay_bits_uop_lrs1_rtype),
    .io_replay_bits_uop_lrs2_rtype      (_mshrs_1_io_replay_bits_uop_lrs2_rtype),
    .io_replay_bits_uop_frs3_en         (_mshrs_1_io_replay_bits_uop_frs3_en),
    .io_replay_bits_uop_fp_val          (_mshrs_1_io_replay_bits_uop_fp_val),
    .io_replay_bits_uop_fp_single       (_mshrs_1_io_replay_bits_uop_fp_single),
    .io_replay_bits_uop_xcpt_pf_if      (_mshrs_1_io_replay_bits_uop_xcpt_pf_if),
    .io_replay_bits_uop_xcpt_ae_if      (_mshrs_1_io_replay_bits_uop_xcpt_ae_if),
    .io_replay_bits_uop_xcpt_ma_if      (_mshrs_1_io_replay_bits_uop_xcpt_ma_if),
    .io_replay_bits_uop_bp_debug_if     (_mshrs_1_io_replay_bits_uop_bp_debug_if),
    .io_replay_bits_uop_bp_xcpt_if      (_mshrs_1_io_replay_bits_uop_bp_xcpt_if),
    .io_replay_bits_uop_debug_fsrc      (_mshrs_1_io_replay_bits_uop_debug_fsrc),
    .io_replay_bits_uop_debug_tsrc      (_mshrs_1_io_replay_bits_uop_debug_tsrc),
    .io_replay_bits_addr                (_mshrs_1_io_replay_bits_addr),
    .io_replay_bits_is_hella            (_mshrs_1_io_replay_bits_is_hella),
    .io_replay_bits_way_en              (_mshrs_1_io_replay_bits_way_en),
    .io_replay_bits_sdq_id              (_mshrs_1_io_replay_bits_sdq_id),
    .io_resp_valid                      (_mshrs_1_io_resp_valid),
    .io_resp_bits_uop_uopc              (_mshrs_1_io_resp_bits_uop_uopc),
    .io_resp_bits_uop_inst              (_mshrs_1_io_resp_bits_uop_inst),
    .io_resp_bits_uop_debug_inst        (_mshrs_1_io_resp_bits_uop_debug_inst),
    .io_resp_bits_uop_is_rvc            (_mshrs_1_io_resp_bits_uop_is_rvc),
    .io_resp_bits_uop_debug_pc          (_mshrs_1_io_resp_bits_uop_debug_pc),
    .io_resp_bits_uop_iq_type           (_mshrs_1_io_resp_bits_uop_iq_type),
    .io_resp_bits_uop_fu_code           (_mshrs_1_io_resp_bits_uop_fu_code),
    .io_resp_bits_uop_ctrl_br_type      (_mshrs_1_io_resp_bits_uop_ctrl_br_type),
    .io_resp_bits_uop_ctrl_op1_sel      (_mshrs_1_io_resp_bits_uop_ctrl_op1_sel),
    .io_resp_bits_uop_ctrl_op2_sel      (_mshrs_1_io_resp_bits_uop_ctrl_op2_sel),
    .io_resp_bits_uop_ctrl_imm_sel      (_mshrs_1_io_resp_bits_uop_ctrl_imm_sel),
    .io_resp_bits_uop_ctrl_op_fcn       (_mshrs_1_io_resp_bits_uop_ctrl_op_fcn),
    .io_resp_bits_uop_ctrl_fcn_dw       (_mshrs_1_io_resp_bits_uop_ctrl_fcn_dw),
    .io_resp_bits_uop_ctrl_csr_cmd      (_mshrs_1_io_resp_bits_uop_ctrl_csr_cmd),
    .io_resp_bits_uop_ctrl_is_load      (_mshrs_1_io_resp_bits_uop_ctrl_is_load),
    .io_resp_bits_uop_ctrl_is_sta       (_mshrs_1_io_resp_bits_uop_ctrl_is_sta),
    .io_resp_bits_uop_ctrl_is_std       (_mshrs_1_io_resp_bits_uop_ctrl_is_std),
    .io_resp_bits_uop_iw_state          (_mshrs_1_io_resp_bits_uop_iw_state),
    .io_resp_bits_uop_iw_p1_poisoned    (_mshrs_1_io_resp_bits_uop_iw_p1_poisoned),
    .io_resp_bits_uop_iw_p2_poisoned    (_mshrs_1_io_resp_bits_uop_iw_p2_poisoned),
    .io_resp_bits_uop_is_br             (_mshrs_1_io_resp_bits_uop_is_br),
    .io_resp_bits_uop_is_jalr           (_mshrs_1_io_resp_bits_uop_is_jalr),
    .io_resp_bits_uop_is_jal            (_mshrs_1_io_resp_bits_uop_is_jal),
    .io_resp_bits_uop_is_sfb            (_mshrs_1_io_resp_bits_uop_is_sfb),
    .io_resp_bits_uop_br_mask           (_mshrs_1_io_resp_bits_uop_br_mask),
    .io_resp_bits_uop_br_tag            (_mshrs_1_io_resp_bits_uop_br_tag),
    .io_resp_bits_uop_ftq_idx           (_mshrs_1_io_resp_bits_uop_ftq_idx),
    .io_resp_bits_uop_edge_inst         (_mshrs_1_io_resp_bits_uop_edge_inst),
    .io_resp_bits_uop_pc_lob            (_mshrs_1_io_resp_bits_uop_pc_lob),
    .io_resp_bits_uop_taken             (_mshrs_1_io_resp_bits_uop_taken),
    .io_resp_bits_uop_imm_packed        (_mshrs_1_io_resp_bits_uop_imm_packed),
    .io_resp_bits_uop_csr_addr          (_mshrs_1_io_resp_bits_uop_csr_addr),
    .io_resp_bits_uop_rob_idx           (_mshrs_1_io_resp_bits_uop_rob_idx),
    .io_resp_bits_uop_ldq_idx           (_mshrs_1_io_resp_bits_uop_ldq_idx),
    .io_resp_bits_uop_stq_idx           (_mshrs_1_io_resp_bits_uop_stq_idx),
    .io_resp_bits_uop_rxq_idx           (_mshrs_1_io_resp_bits_uop_rxq_idx),
    .io_resp_bits_uop_pdst              (_mshrs_1_io_resp_bits_uop_pdst),
    .io_resp_bits_uop_prs1              (_mshrs_1_io_resp_bits_uop_prs1),
    .io_resp_bits_uop_prs2              (_mshrs_1_io_resp_bits_uop_prs2),
    .io_resp_bits_uop_prs3              (_mshrs_1_io_resp_bits_uop_prs3),
    .io_resp_bits_uop_ppred             (_mshrs_1_io_resp_bits_uop_ppred),
    .io_resp_bits_uop_prs1_busy         (_mshrs_1_io_resp_bits_uop_prs1_busy),
    .io_resp_bits_uop_prs2_busy         (_mshrs_1_io_resp_bits_uop_prs2_busy),
    .io_resp_bits_uop_prs3_busy         (_mshrs_1_io_resp_bits_uop_prs3_busy),
    .io_resp_bits_uop_ppred_busy        (_mshrs_1_io_resp_bits_uop_ppred_busy),
    .io_resp_bits_uop_stale_pdst        (_mshrs_1_io_resp_bits_uop_stale_pdst),
    .io_resp_bits_uop_exception         (_mshrs_1_io_resp_bits_uop_exception),
    .io_resp_bits_uop_exc_cause         (_mshrs_1_io_resp_bits_uop_exc_cause),
    .io_resp_bits_uop_bypassable        (_mshrs_1_io_resp_bits_uop_bypassable),
    .io_resp_bits_uop_mem_cmd           (_mshrs_1_io_resp_bits_uop_mem_cmd),
    .io_resp_bits_uop_mem_size          (_mshrs_1_io_resp_bits_uop_mem_size),
    .io_resp_bits_uop_mem_signed        (_mshrs_1_io_resp_bits_uop_mem_signed),
    .io_resp_bits_uop_is_fence          (_mshrs_1_io_resp_bits_uop_is_fence),
    .io_resp_bits_uop_is_fencei         (_mshrs_1_io_resp_bits_uop_is_fencei),
    .io_resp_bits_uop_is_amo            (_mshrs_1_io_resp_bits_uop_is_amo),
    .io_resp_bits_uop_uses_ldq          (_mshrs_1_io_resp_bits_uop_uses_ldq),
    .io_resp_bits_uop_uses_stq          (_mshrs_1_io_resp_bits_uop_uses_stq),
    .io_resp_bits_uop_is_sys_pc2epc     (_mshrs_1_io_resp_bits_uop_is_sys_pc2epc),
    .io_resp_bits_uop_is_unique         (_mshrs_1_io_resp_bits_uop_is_unique),
    .io_resp_bits_uop_flush_on_commit   (_mshrs_1_io_resp_bits_uop_flush_on_commit),
    .io_resp_bits_uop_ldst_is_rs1       (_mshrs_1_io_resp_bits_uop_ldst_is_rs1),
    .io_resp_bits_uop_ldst              (_mshrs_1_io_resp_bits_uop_ldst),
    .io_resp_bits_uop_lrs1              (_mshrs_1_io_resp_bits_uop_lrs1),
    .io_resp_bits_uop_lrs2              (_mshrs_1_io_resp_bits_uop_lrs2),
    .io_resp_bits_uop_lrs3              (_mshrs_1_io_resp_bits_uop_lrs3),
    .io_resp_bits_uop_ldst_val          (_mshrs_1_io_resp_bits_uop_ldst_val),
    .io_resp_bits_uop_dst_rtype         (_mshrs_1_io_resp_bits_uop_dst_rtype),
    .io_resp_bits_uop_lrs1_rtype        (_mshrs_1_io_resp_bits_uop_lrs1_rtype),
    .io_resp_bits_uop_lrs2_rtype        (_mshrs_1_io_resp_bits_uop_lrs2_rtype),
    .io_resp_bits_uop_frs3_en           (_mshrs_1_io_resp_bits_uop_frs3_en),
    .io_resp_bits_uop_fp_val            (_mshrs_1_io_resp_bits_uop_fp_val),
    .io_resp_bits_uop_fp_single         (_mshrs_1_io_resp_bits_uop_fp_single),
    .io_resp_bits_uop_xcpt_pf_if        (_mshrs_1_io_resp_bits_uop_xcpt_pf_if),
    .io_resp_bits_uop_xcpt_ae_if        (_mshrs_1_io_resp_bits_uop_xcpt_ae_if),
    .io_resp_bits_uop_xcpt_ma_if        (_mshrs_1_io_resp_bits_uop_xcpt_ma_if),
    .io_resp_bits_uop_bp_debug_if       (_mshrs_1_io_resp_bits_uop_bp_debug_if),
    .io_resp_bits_uop_bp_xcpt_if        (_mshrs_1_io_resp_bits_uop_bp_xcpt_if),
    .io_resp_bits_uop_debug_fsrc        (_mshrs_1_io_resp_bits_uop_debug_fsrc),
    .io_resp_bits_uop_debug_tsrc        (_mshrs_1_io_resp_bits_uop_debug_tsrc),
    .io_resp_bits_data                  (_mshrs_1_io_resp_bits_data),
    .io_resp_bits_is_hella              (_mshrs_1_io_resp_bits_is_hella),
    .io_probe_rdy                       (_mshrs_1_io_probe_rdy)
  );
  BoomMSHR mshrs_2 (	// mshrs.scala:620:22
    .clock                              (clock),
    .reset                              (reset),
    .io_id                              (3'h2),	// mshrs.scala:621:16
    .io_req_pri_val                     (mshr_alloc_idx_REG == 3'h2 & pri_val),	// mshrs.scala:618:51, :621:16, :632:{34,54}, :694:31
    .io_req_sec_val                     (_mshr_io_req_sec_val_T_11),	// mshrs.scala:637:99
    .io_clear_prefetch
      (io_clear_all & ~_GEN | _GEN & _GEN_89 & cacheable & ~_GEN_86 | io_req_is_probe_0
       & _GEN_89),	// Parameters.scala:137:31, :671:42, mshrs.scala:637:{50,72}, :644:{46,49}, :645:{58,61,82}, :646:21
    .io_brupdate_b1_resolve_mask        (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask     (io_brupdate_b1_mispredict_mask),
    .io_exception                       (io_exception),
    .io_req_uop_uopc                    (_GEN_0),	// Parameters.scala:137:31
    .io_req_uop_inst                    (_GEN_1),	// Parameters.scala:137:31
    .io_req_uop_debug_inst              (_GEN_2),	// Parameters.scala:137:31
    .io_req_uop_is_rvc                  (_GEN_3),	// Parameters.scala:137:31
    .io_req_uop_debug_pc                (_GEN_4),	// Parameters.scala:137:31
    .io_req_uop_iq_type                 (_GEN_5),	// Parameters.scala:137:31
    .io_req_uop_fu_code                 (_GEN_6),	// Parameters.scala:137:31
    .io_req_uop_ctrl_br_type            (_GEN_7),	// Parameters.scala:137:31
    .io_req_uop_ctrl_op1_sel            (_GEN_8),	// Parameters.scala:137:31
    .io_req_uop_ctrl_op2_sel            (_GEN_9),	// Parameters.scala:137:31
    .io_req_uop_ctrl_imm_sel            (_GEN_10),	// Parameters.scala:137:31
    .io_req_uop_ctrl_op_fcn             (_GEN_11),	// Parameters.scala:137:31
    .io_req_uop_ctrl_fcn_dw             (_GEN_12),	// Parameters.scala:137:31
    .io_req_uop_ctrl_csr_cmd            (_GEN_13),	// Parameters.scala:137:31
    .io_req_uop_ctrl_is_load            (_GEN_14),	// Parameters.scala:137:31
    .io_req_uop_ctrl_is_sta             (_GEN_15),	// Parameters.scala:137:31
    .io_req_uop_ctrl_is_std             (_GEN_16),	// Parameters.scala:137:31
    .io_req_uop_iw_state                (_GEN_17),	// Parameters.scala:137:31
    .io_req_uop_iw_p1_poisoned          (_GEN_18),	// Parameters.scala:137:31
    .io_req_uop_iw_p2_poisoned          (_GEN_19),	// Parameters.scala:137:31
    .io_req_uop_is_br                   (_GEN_20),	// Parameters.scala:137:31
    .io_req_uop_is_jalr                 (_GEN_21),	// Parameters.scala:137:31
    .io_req_uop_is_jal                  (_GEN_22),	// Parameters.scala:137:31
    .io_req_uop_is_sfb                  (_GEN_23),	// Parameters.scala:137:31
    .io_req_uop_br_mask                 (_GEN_24),	// Parameters.scala:137:31
    .io_req_uop_br_tag                  (_GEN_25),	// Parameters.scala:137:31
    .io_req_uop_ftq_idx                 (_GEN_26),	// Parameters.scala:137:31
    .io_req_uop_edge_inst               (_GEN_27),	// Parameters.scala:137:31
    .io_req_uop_pc_lob                  (_GEN_28),	// Parameters.scala:137:31
    .io_req_uop_taken                   (_GEN_29),	// Parameters.scala:137:31
    .io_req_uop_imm_packed              (_GEN_30),	// Parameters.scala:137:31
    .io_req_uop_csr_addr                (_GEN_31),	// Parameters.scala:137:31
    .io_req_uop_rob_idx                 (_GEN_32),	// Parameters.scala:137:31
    .io_req_uop_ldq_idx                 (_GEN_33),	// Parameters.scala:137:31
    .io_req_uop_stq_idx                 (_GEN_34),	// Parameters.scala:137:31
    .io_req_uop_rxq_idx                 (_GEN_35),	// Parameters.scala:137:31
    .io_req_uop_pdst                    (_GEN_36),	// Parameters.scala:137:31
    .io_req_uop_prs1                    (_GEN_37),	// Parameters.scala:137:31
    .io_req_uop_prs2                    (_GEN_38),	// Parameters.scala:137:31
    .io_req_uop_prs3                    (_GEN_39),	// Parameters.scala:137:31
    .io_req_uop_ppred                   (_GEN_40),	// Parameters.scala:137:31
    .io_req_uop_prs1_busy               (_GEN_41),	// Parameters.scala:137:31
    .io_req_uop_prs2_busy               (_GEN_42),	// Parameters.scala:137:31
    .io_req_uop_prs3_busy               (_GEN_43),	// Parameters.scala:137:31
    .io_req_uop_ppred_busy              (_GEN_44),	// Parameters.scala:137:31
    .io_req_uop_stale_pdst              (_GEN_45),	// Parameters.scala:137:31
    .io_req_uop_exception               (_GEN_46),	// Parameters.scala:137:31
    .io_req_uop_exc_cause               (_GEN_47),	// Parameters.scala:137:31
    .io_req_uop_bypassable              (_GEN_48),	// Parameters.scala:137:31
    .io_req_uop_mem_cmd                 (_GEN_49),	// Parameters.scala:137:31
    .io_req_uop_mem_size                (_GEN_50),	// Parameters.scala:137:31
    .io_req_uop_mem_signed              (_GEN_51),	// Parameters.scala:137:31
    .io_req_uop_is_fence                (_GEN_52),	// Parameters.scala:137:31
    .io_req_uop_is_fencei               (_GEN_53),	// Parameters.scala:137:31
    .io_req_uop_is_amo                  (_GEN_54),	// Parameters.scala:137:31
    .io_req_uop_uses_ldq                (_GEN_55),	// Parameters.scala:137:31
    .io_req_uop_uses_stq                (_GEN_56),	// Parameters.scala:137:31
    .io_req_uop_is_sys_pc2epc           (_GEN_57),	// Parameters.scala:137:31
    .io_req_uop_is_unique               (_GEN_58),	// Parameters.scala:137:31
    .io_req_uop_flush_on_commit         (_GEN_59),	// Parameters.scala:137:31
    .io_req_uop_ldst_is_rs1             (_GEN_60),	// Parameters.scala:137:31
    .io_req_uop_ldst                    (_GEN_61),	// Parameters.scala:137:31
    .io_req_uop_lrs1                    (_GEN_62),	// Parameters.scala:137:31
    .io_req_uop_lrs2                    (_GEN_63),	// Parameters.scala:137:31
    .io_req_uop_lrs3                    (_GEN_64),	// Parameters.scala:137:31
    .io_req_uop_ldst_val                (_GEN_65),	// Parameters.scala:137:31
    .io_req_uop_dst_rtype               (_GEN_66),	// Parameters.scala:137:31
    .io_req_uop_lrs1_rtype              (_GEN_67),	// Parameters.scala:137:31
    .io_req_uop_lrs2_rtype              (_GEN_68),	// Parameters.scala:137:31
    .io_req_uop_frs3_en                 (_GEN_69),	// Parameters.scala:137:31
    .io_req_uop_fp_val                  (_GEN_70),	// Parameters.scala:137:31
    .io_req_uop_fp_single               (_GEN_71),	// Parameters.scala:137:31
    .io_req_uop_xcpt_pf_if              (_GEN_72),	// Parameters.scala:137:31
    .io_req_uop_xcpt_ae_if              (_GEN_73),	// Parameters.scala:137:31
    .io_req_uop_xcpt_ma_if              (_GEN_74),	// Parameters.scala:137:31
    .io_req_uop_bp_debug_if             (_GEN_75),	// Parameters.scala:137:31
    .io_req_uop_bp_xcpt_if              (_GEN_76),	// Parameters.scala:137:31
    .io_req_uop_debug_fsrc              (_GEN_77),	// Parameters.scala:137:31
    .io_req_uop_debug_tsrc              (_GEN_78),	// Parameters.scala:137:31
    .io_req_addr                        (_cacheable_T_1),	// Parameters.scala:137:31
    .io_req_data                        (_GEN_79),	// Parameters.scala:137:31
    .io_req_is_hella                    (_GEN_80),	// Parameters.scala:137:31
    .io_req_tag_match                   (_GEN_81),	// Parameters.scala:137:31
    .io_req_old_meta_coh_state          (_GEN_82),	// Parameters.scala:137:31
    .io_req_old_meta_tag                (_GEN_83),	// Parameters.scala:137:31
    .io_req_way_en                      (_GEN_84),	// Parameters.scala:137:31
    .io_req_sdq_id                      (sdq_alloc_id),	// Mux.scala:47:69
    .io_req_is_probe                    (io_req_is_probe_0),
    .io_mem_acquire_ready
      (io_mem_acquire_ready & (idle ? ~_GEN_108 : state_2)),	// Arbiter.scala:16:61, :88:28, :116:26, :121:24, :123:31, package.scala:244:43
    .io_mem_grant_valid                 (_GEN_97 & io_mem_grant_valid),	// mshrs.scala:671:29, :673:{36,45}, :674:25
    .io_mem_grant_bits_opcode           (io_mem_grant_bits_opcode),
    .io_mem_grant_bits_param            (io_mem_grant_bits_param),
    .io_mem_grant_bits_size             (io_mem_grant_bits_size),
    .io_mem_grant_bits_sink             (io_mem_grant_bits_sink),
    .io_mem_grant_bits_data             (io_mem_grant_bits_data),
    .io_mem_finish_ready
      (io_mem_finish_ready & (beatsLeft_1 ? state_1_2 : ~_GEN_119)),	// Arbiter.scala:16:61, :87:30, :116:26, :121:24, :123:31, package.scala:244:43
    .io_prober_state_valid              (io_prober_state_valid),
    .io_prober_state_bits               (io_prober_state_bits),
    .io_refill_ready                    (_refill_arb_io_in_2_ready),	// mshrs.scala:604:30
    .io_meta_write_ready                (_meta_write_arb_io_in_2_ready),	// mshrs.scala:599:30
    .io_meta_read_ready                 (_meta_read_arb_io_in_2_ready),	// mshrs.scala:600:30
    .io_meta_resp_valid                 (io_meta_resp_valid),
    .io_meta_resp_bits_coh_state        (io_meta_resp_bits_coh_state),
    .io_wb_req_ready                    (_wb_req_arb_io_in_2_ready),	// mshrs.scala:601:30
    .io_lb_read_ready                   (_lb_read_arb_io_in_2_ready),	// mshrs.scala:569:28
    .io_lb_resp                         (lb_read_data),	// mshrs.scala:576:37, :580:38
    .io_lb_write_ready                  (_lb_write_arb_io_in_2_ready),	// mshrs.scala:570:28
    .io_replay_ready                    (_replay_arb_io_in_2_ready),	// mshrs.scala:602:30
    .io_resp_ready                      (_resp_arb_io_in_2_ready),	// mshrs.scala:603:30
    .io_wb_resp                         (io_wb_resp),
    .io_req_pri_rdy                     (_mshrs_2_io_req_pri_rdy),
    .io_req_sec_rdy                     (_mshrs_2_io_req_sec_rdy),
    .io_idx_valid                       (_mshrs_2_io_idx_valid),
    .io_idx_bits                        (_mshrs_2_io_idx_bits),
    .io_way_valid                       (_mshrs_2_io_way_valid),
    .io_way_bits                        (_mshrs_2_io_way_bits),
    .io_tag_valid                       (_mshrs_2_io_tag_valid),
    .io_tag_bits                        (_mshrs_2_io_tag_bits),
    .io_mem_acquire_valid               (_mshrs_2_io_mem_acquire_valid),
    .io_mem_acquire_bits_param          (_mshrs_2_io_mem_acquire_bits_param),
    .io_mem_acquire_bits_source         (_mshrs_2_io_mem_acquire_bits_source),
    .io_mem_acquire_bits_address        (_mshrs_2_io_mem_acquire_bits_address),
    .io_mem_grant_ready                 (_mshrs_2_io_mem_grant_ready),
    .io_mem_finish_valid                (_mshrs_2_io_mem_finish_valid),
    .io_mem_finish_bits_sink            (_mshrs_2_io_mem_finish_bits_sink),
    .io_refill_valid                    (_mshrs_2_io_refill_valid),
    .io_refill_bits_way_en              (_mshrs_2_io_refill_bits_way_en),
    .io_refill_bits_addr                (_mshrs_2_io_refill_bits_addr),
    .io_refill_bits_data                (_mshrs_2_io_refill_bits_data),
    .io_meta_write_valid                (_mshrs_2_io_meta_write_valid),
    .io_meta_write_bits_idx             (_mshrs_2_io_meta_write_bits_idx),
    .io_meta_write_bits_way_en          (_mshrs_2_io_meta_write_bits_way_en),
    .io_meta_write_bits_data_coh_state  (_mshrs_2_io_meta_write_bits_data_coh_state),
    .io_meta_write_bits_data_tag        (_mshrs_2_io_meta_write_bits_data_tag),
    .io_meta_read_valid                 (_mshrs_2_io_meta_read_valid),
    .io_meta_read_bits_idx              (_mshrs_2_io_meta_read_bits_idx),
    .io_meta_read_bits_way_en           (_mshrs_2_io_meta_read_bits_way_en),
    .io_meta_read_bits_tag              (_mshrs_2_io_meta_read_bits_tag),
    .io_wb_req_valid                    (_mshrs_2_io_wb_req_valid),
    .io_wb_req_bits_tag                 (_mshrs_2_io_wb_req_bits_tag),
    .io_wb_req_bits_idx                 (_mshrs_2_io_wb_req_bits_idx),
    .io_wb_req_bits_param               (_mshrs_2_io_wb_req_bits_param),
    .io_wb_req_bits_way_en              (_mshrs_2_io_wb_req_bits_way_en),
    .io_commit_val                      (_mshrs_2_io_commit_val),
    .io_commit_addr                     (_mshrs_2_io_commit_addr),
    .io_commit_coh_state                (_mshrs_2_io_commit_coh_state),
    .io_lb_read_valid                   (_mshrs_2_io_lb_read_valid),
    .io_lb_read_bits_id                 (_mshrs_2_io_lb_read_bits_id),
    .io_lb_read_bits_offset             (_mshrs_2_io_lb_read_bits_offset),
    .io_lb_write_valid                  (_mshrs_2_io_lb_write_valid),
    .io_lb_write_bits_id                (_mshrs_2_io_lb_write_bits_id),
    .io_lb_write_bits_offset            (_mshrs_2_io_lb_write_bits_offset),
    .io_lb_write_bits_data              (_mshrs_2_io_lb_write_bits_data),
    .io_replay_valid                    (_mshrs_2_io_replay_valid),
    .io_replay_bits_uop_uopc            (_mshrs_2_io_replay_bits_uop_uopc),
    .io_replay_bits_uop_inst            (_mshrs_2_io_replay_bits_uop_inst),
    .io_replay_bits_uop_debug_inst      (_mshrs_2_io_replay_bits_uop_debug_inst),
    .io_replay_bits_uop_is_rvc          (_mshrs_2_io_replay_bits_uop_is_rvc),
    .io_replay_bits_uop_debug_pc        (_mshrs_2_io_replay_bits_uop_debug_pc),
    .io_replay_bits_uop_iq_type         (_mshrs_2_io_replay_bits_uop_iq_type),
    .io_replay_bits_uop_fu_code         (_mshrs_2_io_replay_bits_uop_fu_code),
    .io_replay_bits_uop_ctrl_br_type    (_mshrs_2_io_replay_bits_uop_ctrl_br_type),
    .io_replay_bits_uop_ctrl_op1_sel    (_mshrs_2_io_replay_bits_uop_ctrl_op1_sel),
    .io_replay_bits_uop_ctrl_op2_sel    (_mshrs_2_io_replay_bits_uop_ctrl_op2_sel),
    .io_replay_bits_uop_ctrl_imm_sel    (_mshrs_2_io_replay_bits_uop_ctrl_imm_sel),
    .io_replay_bits_uop_ctrl_op_fcn     (_mshrs_2_io_replay_bits_uop_ctrl_op_fcn),
    .io_replay_bits_uop_ctrl_fcn_dw     (_mshrs_2_io_replay_bits_uop_ctrl_fcn_dw),
    .io_replay_bits_uop_ctrl_csr_cmd    (_mshrs_2_io_replay_bits_uop_ctrl_csr_cmd),
    .io_replay_bits_uop_ctrl_is_load    (_mshrs_2_io_replay_bits_uop_ctrl_is_load),
    .io_replay_bits_uop_ctrl_is_sta     (_mshrs_2_io_replay_bits_uop_ctrl_is_sta),
    .io_replay_bits_uop_ctrl_is_std     (_mshrs_2_io_replay_bits_uop_ctrl_is_std),
    .io_replay_bits_uop_iw_state        (_mshrs_2_io_replay_bits_uop_iw_state),
    .io_replay_bits_uop_iw_p1_poisoned  (_mshrs_2_io_replay_bits_uop_iw_p1_poisoned),
    .io_replay_bits_uop_iw_p2_poisoned  (_mshrs_2_io_replay_bits_uop_iw_p2_poisoned),
    .io_replay_bits_uop_is_br           (_mshrs_2_io_replay_bits_uop_is_br),
    .io_replay_bits_uop_is_jalr         (_mshrs_2_io_replay_bits_uop_is_jalr),
    .io_replay_bits_uop_is_jal          (_mshrs_2_io_replay_bits_uop_is_jal),
    .io_replay_bits_uop_is_sfb          (_mshrs_2_io_replay_bits_uop_is_sfb),
    .io_replay_bits_uop_br_mask         (_mshrs_2_io_replay_bits_uop_br_mask),
    .io_replay_bits_uop_br_tag          (_mshrs_2_io_replay_bits_uop_br_tag),
    .io_replay_bits_uop_ftq_idx         (_mshrs_2_io_replay_bits_uop_ftq_idx),
    .io_replay_bits_uop_edge_inst       (_mshrs_2_io_replay_bits_uop_edge_inst),
    .io_replay_bits_uop_pc_lob          (_mshrs_2_io_replay_bits_uop_pc_lob),
    .io_replay_bits_uop_taken           (_mshrs_2_io_replay_bits_uop_taken),
    .io_replay_bits_uop_imm_packed      (_mshrs_2_io_replay_bits_uop_imm_packed),
    .io_replay_bits_uop_csr_addr        (_mshrs_2_io_replay_bits_uop_csr_addr),
    .io_replay_bits_uop_rob_idx         (_mshrs_2_io_replay_bits_uop_rob_idx),
    .io_replay_bits_uop_ldq_idx         (_mshrs_2_io_replay_bits_uop_ldq_idx),
    .io_replay_bits_uop_stq_idx         (_mshrs_2_io_replay_bits_uop_stq_idx),
    .io_replay_bits_uop_rxq_idx         (_mshrs_2_io_replay_bits_uop_rxq_idx),
    .io_replay_bits_uop_pdst            (_mshrs_2_io_replay_bits_uop_pdst),
    .io_replay_bits_uop_prs1            (_mshrs_2_io_replay_bits_uop_prs1),
    .io_replay_bits_uop_prs2            (_mshrs_2_io_replay_bits_uop_prs2),
    .io_replay_bits_uop_prs3            (_mshrs_2_io_replay_bits_uop_prs3),
    .io_replay_bits_uop_ppred           (_mshrs_2_io_replay_bits_uop_ppred),
    .io_replay_bits_uop_prs1_busy       (_mshrs_2_io_replay_bits_uop_prs1_busy),
    .io_replay_bits_uop_prs2_busy       (_mshrs_2_io_replay_bits_uop_prs2_busy),
    .io_replay_bits_uop_prs3_busy       (_mshrs_2_io_replay_bits_uop_prs3_busy),
    .io_replay_bits_uop_ppred_busy      (_mshrs_2_io_replay_bits_uop_ppred_busy),
    .io_replay_bits_uop_stale_pdst      (_mshrs_2_io_replay_bits_uop_stale_pdst),
    .io_replay_bits_uop_exception       (_mshrs_2_io_replay_bits_uop_exception),
    .io_replay_bits_uop_exc_cause       (_mshrs_2_io_replay_bits_uop_exc_cause),
    .io_replay_bits_uop_bypassable      (_mshrs_2_io_replay_bits_uop_bypassable),
    .io_replay_bits_uop_mem_cmd         (_mshrs_2_io_replay_bits_uop_mem_cmd),
    .io_replay_bits_uop_mem_size        (_mshrs_2_io_replay_bits_uop_mem_size),
    .io_replay_bits_uop_mem_signed      (_mshrs_2_io_replay_bits_uop_mem_signed),
    .io_replay_bits_uop_is_fence        (_mshrs_2_io_replay_bits_uop_is_fence),
    .io_replay_bits_uop_is_fencei       (_mshrs_2_io_replay_bits_uop_is_fencei),
    .io_replay_bits_uop_is_amo          (_mshrs_2_io_replay_bits_uop_is_amo),
    .io_replay_bits_uop_uses_ldq        (_mshrs_2_io_replay_bits_uop_uses_ldq),
    .io_replay_bits_uop_uses_stq        (_mshrs_2_io_replay_bits_uop_uses_stq),
    .io_replay_bits_uop_is_sys_pc2epc   (_mshrs_2_io_replay_bits_uop_is_sys_pc2epc),
    .io_replay_bits_uop_is_unique       (_mshrs_2_io_replay_bits_uop_is_unique),
    .io_replay_bits_uop_flush_on_commit (_mshrs_2_io_replay_bits_uop_flush_on_commit),
    .io_replay_bits_uop_ldst_is_rs1     (_mshrs_2_io_replay_bits_uop_ldst_is_rs1),
    .io_replay_bits_uop_ldst            (_mshrs_2_io_replay_bits_uop_ldst),
    .io_replay_bits_uop_lrs1            (_mshrs_2_io_replay_bits_uop_lrs1),
    .io_replay_bits_uop_lrs2            (_mshrs_2_io_replay_bits_uop_lrs2),
    .io_replay_bits_uop_lrs3            (_mshrs_2_io_replay_bits_uop_lrs3),
    .io_replay_bits_uop_ldst_val        (_mshrs_2_io_replay_bits_uop_ldst_val),
    .io_replay_bits_uop_dst_rtype       (_mshrs_2_io_replay_bits_uop_dst_rtype),
    .io_replay_bits_uop_lrs1_rtype      (_mshrs_2_io_replay_bits_uop_lrs1_rtype),
    .io_replay_bits_uop_lrs2_rtype      (_mshrs_2_io_replay_bits_uop_lrs2_rtype),
    .io_replay_bits_uop_frs3_en         (_mshrs_2_io_replay_bits_uop_frs3_en),
    .io_replay_bits_uop_fp_val          (_mshrs_2_io_replay_bits_uop_fp_val),
    .io_replay_bits_uop_fp_single       (_mshrs_2_io_replay_bits_uop_fp_single),
    .io_replay_bits_uop_xcpt_pf_if      (_mshrs_2_io_replay_bits_uop_xcpt_pf_if),
    .io_replay_bits_uop_xcpt_ae_if      (_mshrs_2_io_replay_bits_uop_xcpt_ae_if),
    .io_replay_bits_uop_xcpt_ma_if      (_mshrs_2_io_replay_bits_uop_xcpt_ma_if),
    .io_replay_bits_uop_bp_debug_if     (_mshrs_2_io_replay_bits_uop_bp_debug_if),
    .io_replay_bits_uop_bp_xcpt_if      (_mshrs_2_io_replay_bits_uop_bp_xcpt_if),
    .io_replay_bits_uop_debug_fsrc      (_mshrs_2_io_replay_bits_uop_debug_fsrc),
    .io_replay_bits_uop_debug_tsrc      (_mshrs_2_io_replay_bits_uop_debug_tsrc),
    .io_replay_bits_addr                (_mshrs_2_io_replay_bits_addr),
    .io_replay_bits_is_hella            (_mshrs_2_io_replay_bits_is_hella),
    .io_replay_bits_way_en              (_mshrs_2_io_replay_bits_way_en),
    .io_replay_bits_sdq_id              (_mshrs_2_io_replay_bits_sdq_id),
    .io_resp_valid                      (_mshrs_2_io_resp_valid),
    .io_resp_bits_uop_uopc              (_mshrs_2_io_resp_bits_uop_uopc),
    .io_resp_bits_uop_inst              (_mshrs_2_io_resp_bits_uop_inst),
    .io_resp_bits_uop_debug_inst        (_mshrs_2_io_resp_bits_uop_debug_inst),
    .io_resp_bits_uop_is_rvc            (_mshrs_2_io_resp_bits_uop_is_rvc),
    .io_resp_bits_uop_debug_pc          (_mshrs_2_io_resp_bits_uop_debug_pc),
    .io_resp_bits_uop_iq_type           (_mshrs_2_io_resp_bits_uop_iq_type),
    .io_resp_bits_uop_fu_code           (_mshrs_2_io_resp_bits_uop_fu_code),
    .io_resp_bits_uop_ctrl_br_type      (_mshrs_2_io_resp_bits_uop_ctrl_br_type),
    .io_resp_bits_uop_ctrl_op1_sel      (_mshrs_2_io_resp_bits_uop_ctrl_op1_sel),
    .io_resp_bits_uop_ctrl_op2_sel      (_mshrs_2_io_resp_bits_uop_ctrl_op2_sel),
    .io_resp_bits_uop_ctrl_imm_sel      (_mshrs_2_io_resp_bits_uop_ctrl_imm_sel),
    .io_resp_bits_uop_ctrl_op_fcn       (_mshrs_2_io_resp_bits_uop_ctrl_op_fcn),
    .io_resp_bits_uop_ctrl_fcn_dw       (_mshrs_2_io_resp_bits_uop_ctrl_fcn_dw),
    .io_resp_bits_uop_ctrl_csr_cmd      (_mshrs_2_io_resp_bits_uop_ctrl_csr_cmd),
    .io_resp_bits_uop_ctrl_is_load      (_mshrs_2_io_resp_bits_uop_ctrl_is_load),
    .io_resp_bits_uop_ctrl_is_sta       (_mshrs_2_io_resp_bits_uop_ctrl_is_sta),
    .io_resp_bits_uop_ctrl_is_std       (_mshrs_2_io_resp_bits_uop_ctrl_is_std),
    .io_resp_bits_uop_iw_state          (_mshrs_2_io_resp_bits_uop_iw_state),
    .io_resp_bits_uop_iw_p1_poisoned    (_mshrs_2_io_resp_bits_uop_iw_p1_poisoned),
    .io_resp_bits_uop_iw_p2_poisoned    (_mshrs_2_io_resp_bits_uop_iw_p2_poisoned),
    .io_resp_bits_uop_is_br             (_mshrs_2_io_resp_bits_uop_is_br),
    .io_resp_bits_uop_is_jalr           (_mshrs_2_io_resp_bits_uop_is_jalr),
    .io_resp_bits_uop_is_jal            (_mshrs_2_io_resp_bits_uop_is_jal),
    .io_resp_bits_uop_is_sfb            (_mshrs_2_io_resp_bits_uop_is_sfb),
    .io_resp_bits_uop_br_mask           (_mshrs_2_io_resp_bits_uop_br_mask),
    .io_resp_bits_uop_br_tag            (_mshrs_2_io_resp_bits_uop_br_tag),
    .io_resp_bits_uop_ftq_idx           (_mshrs_2_io_resp_bits_uop_ftq_idx),
    .io_resp_bits_uop_edge_inst         (_mshrs_2_io_resp_bits_uop_edge_inst),
    .io_resp_bits_uop_pc_lob            (_mshrs_2_io_resp_bits_uop_pc_lob),
    .io_resp_bits_uop_taken             (_mshrs_2_io_resp_bits_uop_taken),
    .io_resp_bits_uop_imm_packed        (_mshrs_2_io_resp_bits_uop_imm_packed),
    .io_resp_bits_uop_csr_addr          (_mshrs_2_io_resp_bits_uop_csr_addr),
    .io_resp_bits_uop_rob_idx           (_mshrs_2_io_resp_bits_uop_rob_idx),
    .io_resp_bits_uop_ldq_idx           (_mshrs_2_io_resp_bits_uop_ldq_idx),
    .io_resp_bits_uop_stq_idx           (_mshrs_2_io_resp_bits_uop_stq_idx),
    .io_resp_bits_uop_rxq_idx           (_mshrs_2_io_resp_bits_uop_rxq_idx),
    .io_resp_bits_uop_pdst              (_mshrs_2_io_resp_bits_uop_pdst),
    .io_resp_bits_uop_prs1              (_mshrs_2_io_resp_bits_uop_prs1),
    .io_resp_bits_uop_prs2              (_mshrs_2_io_resp_bits_uop_prs2),
    .io_resp_bits_uop_prs3              (_mshrs_2_io_resp_bits_uop_prs3),
    .io_resp_bits_uop_ppred             (_mshrs_2_io_resp_bits_uop_ppred),
    .io_resp_bits_uop_prs1_busy         (_mshrs_2_io_resp_bits_uop_prs1_busy),
    .io_resp_bits_uop_prs2_busy         (_mshrs_2_io_resp_bits_uop_prs2_busy),
    .io_resp_bits_uop_prs3_busy         (_mshrs_2_io_resp_bits_uop_prs3_busy),
    .io_resp_bits_uop_ppred_busy        (_mshrs_2_io_resp_bits_uop_ppred_busy),
    .io_resp_bits_uop_stale_pdst        (_mshrs_2_io_resp_bits_uop_stale_pdst),
    .io_resp_bits_uop_exception         (_mshrs_2_io_resp_bits_uop_exception),
    .io_resp_bits_uop_exc_cause         (_mshrs_2_io_resp_bits_uop_exc_cause),
    .io_resp_bits_uop_bypassable        (_mshrs_2_io_resp_bits_uop_bypassable),
    .io_resp_bits_uop_mem_cmd           (_mshrs_2_io_resp_bits_uop_mem_cmd),
    .io_resp_bits_uop_mem_size          (_mshrs_2_io_resp_bits_uop_mem_size),
    .io_resp_bits_uop_mem_signed        (_mshrs_2_io_resp_bits_uop_mem_signed),
    .io_resp_bits_uop_is_fence          (_mshrs_2_io_resp_bits_uop_is_fence),
    .io_resp_bits_uop_is_fencei         (_mshrs_2_io_resp_bits_uop_is_fencei),
    .io_resp_bits_uop_is_amo            (_mshrs_2_io_resp_bits_uop_is_amo),
    .io_resp_bits_uop_uses_ldq          (_mshrs_2_io_resp_bits_uop_uses_ldq),
    .io_resp_bits_uop_uses_stq          (_mshrs_2_io_resp_bits_uop_uses_stq),
    .io_resp_bits_uop_is_sys_pc2epc     (_mshrs_2_io_resp_bits_uop_is_sys_pc2epc),
    .io_resp_bits_uop_is_unique         (_mshrs_2_io_resp_bits_uop_is_unique),
    .io_resp_bits_uop_flush_on_commit   (_mshrs_2_io_resp_bits_uop_flush_on_commit),
    .io_resp_bits_uop_ldst_is_rs1       (_mshrs_2_io_resp_bits_uop_ldst_is_rs1),
    .io_resp_bits_uop_ldst              (_mshrs_2_io_resp_bits_uop_ldst),
    .io_resp_bits_uop_lrs1              (_mshrs_2_io_resp_bits_uop_lrs1),
    .io_resp_bits_uop_lrs2              (_mshrs_2_io_resp_bits_uop_lrs2),
    .io_resp_bits_uop_lrs3              (_mshrs_2_io_resp_bits_uop_lrs3),
    .io_resp_bits_uop_ldst_val          (_mshrs_2_io_resp_bits_uop_ldst_val),
    .io_resp_bits_uop_dst_rtype         (_mshrs_2_io_resp_bits_uop_dst_rtype),
    .io_resp_bits_uop_lrs1_rtype        (_mshrs_2_io_resp_bits_uop_lrs1_rtype),
    .io_resp_bits_uop_lrs2_rtype        (_mshrs_2_io_resp_bits_uop_lrs2_rtype),
    .io_resp_bits_uop_frs3_en           (_mshrs_2_io_resp_bits_uop_frs3_en),
    .io_resp_bits_uop_fp_val            (_mshrs_2_io_resp_bits_uop_fp_val),
    .io_resp_bits_uop_fp_single         (_mshrs_2_io_resp_bits_uop_fp_single),
    .io_resp_bits_uop_xcpt_pf_if        (_mshrs_2_io_resp_bits_uop_xcpt_pf_if),
    .io_resp_bits_uop_xcpt_ae_if        (_mshrs_2_io_resp_bits_uop_xcpt_ae_if),
    .io_resp_bits_uop_xcpt_ma_if        (_mshrs_2_io_resp_bits_uop_xcpt_ma_if),
    .io_resp_bits_uop_bp_debug_if       (_mshrs_2_io_resp_bits_uop_bp_debug_if),
    .io_resp_bits_uop_bp_xcpt_if        (_mshrs_2_io_resp_bits_uop_bp_xcpt_if),
    .io_resp_bits_uop_debug_fsrc        (_mshrs_2_io_resp_bits_uop_debug_fsrc),
    .io_resp_bits_uop_debug_tsrc        (_mshrs_2_io_resp_bits_uop_debug_tsrc),
    .io_resp_bits_data                  (_mshrs_2_io_resp_bits_data),
    .io_resp_bits_is_hella              (_mshrs_2_io_resp_bits_is_hella),
    .io_probe_rdy                       (_mshrs_2_io_probe_rdy)
  );
  BoomMSHR mshrs_3 (	// mshrs.scala:620:22
    .clock                              (clock),
    .reset                              (reset),
    .io_id                              (3'h3),	// mshrs.scala:621:16
    .io_req_pri_val                     (mshr_alloc_idx_REG == 3'h3 & pri_val),	// mshrs.scala:618:51, :621:16, :632:{34,54}, :694:31
    .io_req_sec_val                     (_mshr_io_req_sec_val_T_15),	// mshrs.scala:637:99
    .io_clear_prefetch
      (io_clear_all & ~_GEN | _GEN & _GEN_90 & cacheable & ~_GEN_86 | io_req_is_probe_0
       & _GEN_90),	// Parameters.scala:137:31, :671:42, mshrs.scala:637:{50,72}, :644:{46,49}, :645:{58,61,82}, :646:21
    .io_brupdate_b1_resolve_mask        (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask     (io_brupdate_b1_mispredict_mask),
    .io_exception                       (io_exception),
    .io_req_uop_uopc                    (_GEN_0),	// Parameters.scala:137:31
    .io_req_uop_inst                    (_GEN_1),	// Parameters.scala:137:31
    .io_req_uop_debug_inst              (_GEN_2),	// Parameters.scala:137:31
    .io_req_uop_is_rvc                  (_GEN_3),	// Parameters.scala:137:31
    .io_req_uop_debug_pc                (_GEN_4),	// Parameters.scala:137:31
    .io_req_uop_iq_type                 (_GEN_5),	// Parameters.scala:137:31
    .io_req_uop_fu_code                 (_GEN_6),	// Parameters.scala:137:31
    .io_req_uop_ctrl_br_type            (_GEN_7),	// Parameters.scala:137:31
    .io_req_uop_ctrl_op1_sel            (_GEN_8),	// Parameters.scala:137:31
    .io_req_uop_ctrl_op2_sel            (_GEN_9),	// Parameters.scala:137:31
    .io_req_uop_ctrl_imm_sel            (_GEN_10),	// Parameters.scala:137:31
    .io_req_uop_ctrl_op_fcn             (_GEN_11),	// Parameters.scala:137:31
    .io_req_uop_ctrl_fcn_dw             (_GEN_12),	// Parameters.scala:137:31
    .io_req_uop_ctrl_csr_cmd            (_GEN_13),	// Parameters.scala:137:31
    .io_req_uop_ctrl_is_load            (_GEN_14),	// Parameters.scala:137:31
    .io_req_uop_ctrl_is_sta             (_GEN_15),	// Parameters.scala:137:31
    .io_req_uop_ctrl_is_std             (_GEN_16),	// Parameters.scala:137:31
    .io_req_uop_iw_state                (_GEN_17),	// Parameters.scala:137:31
    .io_req_uop_iw_p1_poisoned          (_GEN_18),	// Parameters.scala:137:31
    .io_req_uop_iw_p2_poisoned          (_GEN_19),	// Parameters.scala:137:31
    .io_req_uop_is_br                   (_GEN_20),	// Parameters.scala:137:31
    .io_req_uop_is_jalr                 (_GEN_21),	// Parameters.scala:137:31
    .io_req_uop_is_jal                  (_GEN_22),	// Parameters.scala:137:31
    .io_req_uop_is_sfb                  (_GEN_23),	// Parameters.scala:137:31
    .io_req_uop_br_mask                 (_GEN_24),	// Parameters.scala:137:31
    .io_req_uop_br_tag                  (_GEN_25),	// Parameters.scala:137:31
    .io_req_uop_ftq_idx                 (_GEN_26),	// Parameters.scala:137:31
    .io_req_uop_edge_inst               (_GEN_27),	// Parameters.scala:137:31
    .io_req_uop_pc_lob                  (_GEN_28),	// Parameters.scala:137:31
    .io_req_uop_taken                   (_GEN_29),	// Parameters.scala:137:31
    .io_req_uop_imm_packed              (_GEN_30),	// Parameters.scala:137:31
    .io_req_uop_csr_addr                (_GEN_31),	// Parameters.scala:137:31
    .io_req_uop_rob_idx                 (_GEN_32),	// Parameters.scala:137:31
    .io_req_uop_ldq_idx                 (_GEN_33),	// Parameters.scala:137:31
    .io_req_uop_stq_idx                 (_GEN_34),	// Parameters.scala:137:31
    .io_req_uop_rxq_idx                 (_GEN_35),	// Parameters.scala:137:31
    .io_req_uop_pdst                    (_GEN_36),	// Parameters.scala:137:31
    .io_req_uop_prs1                    (_GEN_37),	// Parameters.scala:137:31
    .io_req_uop_prs2                    (_GEN_38),	// Parameters.scala:137:31
    .io_req_uop_prs3                    (_GEN_39),	// Parameters.scala:137:31
    .io_req_uop_ppred                   (_GEN_40),	// Parameters.scala:137:31
    .io_req_uop_prs1_busy               (_GEN_41),	// Parameters.scala:137:31
    .io_req_uop_prs2_busy               (_GEN_42),	// Parameters.scala:137:31
    .io_req_uop_prs3_busy               (_GEN_43),	// Parameters.scala:137:31
    .io_req_uop_ppred_busy              (_GEN_44),	// Parameters.scala:137:31
    .io_req_uop_stale_pdst              (_GEN_45),	// Parameters.scala:137:31
    .io_req_uop_exception               (_GEN_46),	// Parameters.scala:137:31
    .io_req_uop_exc_cause               (_GEN_47),	// Parameters.scala:137:31
    .io_req_uop_bypassable              (_GEN_48),	// Parameters.scala:137:31
    .io_req_uop_mem_cmd                 (_GEN_49),	// Parameters.scala:137:31
    .io_req_uop_mem_size                (_GEN_50),	// Parameters.scala:137:31
    .io_req_uop_mem_signed              (_GEN_51),	// Parameters.scala:137:31
    .io_req_uop_is_fence                (_GEN_52),	// Parameters.scala:137:31
    .io_req_uop_is_fencei               (_GEN_53),	// Parameters.scala:137:31
    .io_req_uop_is_amo                  (_GEN_54),	// Parameters.scala:137:31
    .io_req_uop_uses_ldq                (_GEN_55),	// Parameters.scala:137:31
    .io_req_uop_uses_stq                (_GEN_56),	// Parameters.scala:137:31
    .io_req_uop_is_sys_pc2epc           (_GEN_57),	// Parameters.scala:137:31
    .io_req_uop_is_unique               (_GEN_58),	// Parameters.scala:137:31
    .io_req_uop_flush_on_commit         (_GEN_59),	// Parameters.scala:137:31
    .io_req_uop_ldst_is_rs1             (_GEN_60),	// Parameters.scala:137:31
    .io_req_uop_ldst                    (_GEN_61),	// Parameters.scala:137:31
    .io_req_uop_lrs1                    (_GEN_62),	// Parameters.scala:137:31
    .io_req_uop_lrs2                    (_GEN_63),	// Parameters.scala:137:31
    .io_req_uop_lrs3                    (_GEN_64),	// Parameters.scala:137:31
    .io_req_uop_ldst_val                (_GEN_65),	// Parameters.scala:137:31
    .io_req_uop_dst_rtype               (_GEN_66),	// Parameters.scala:137:31
    .io_req_uop_lrs1_rtype              (_GEN_67),	// Parameters.scala:137:31
    .io_req_uop_lrs2_rtype              (_GEN_68),	// Parameters.scala:137:31
    .io_req_uop_frs3_en                 (_GEN_69),	// Parameters.scala:137:31
    .io_req_uop_fp_val                  (_GEN_70),	// Parameters.scala:137:31
    .io_req_uop_fp_single               (_GEN_71),	// Parameters.scala:137:31
    .io_req_uop_xcpt_pf_if              (_GEN_72),	// Parameters.scala:137:31
    .io_req_uop_xcpt_ae_if              (_GEN_73),	// Parameters.scala:137:31
    .io_req_uop_xcpt_ma_if              (_GEN_74),	// Parameters.scala:137:31
    .io_req_uop_bp_debug_if             (_GEN_75),	// Parameters.scala:137:31
    .io_req_uop_bp_xcpt_if              (_GEN_76),	// Parameters.scala:137:31
    .io_req_uop_debug_fsrc              (_GEN_77),	// Parameters.scala:137:31
    .io_req_uop_debug_tsrc              (_GEN_78),	// Parameters.scala:137:31
    .io_req_addr                        (_cacheable_T_1),	// Parameters.scala:137:31
    .io_req_data                        (_GEN_79),	// Parameters.scala:137:31
    .io_req_is_hella                    (_GEN_80),	// Parameters.scala:137:31
    .io_req_tag_match                   (_GEN_81),	// Parameters.scala:137:31
    .io_req_old_meta_coh_state          (_GEN_82),	// Parameters.scala:137:31
    .io_req_old_meta_tag                (_GEN_83),	// Parameters.scala:137:31
    .io_req_way_en                      (_GEN_84),	// Parameters.scala:137:31
    .io_req_sdq_id                      (sdq_alloc_id),	// Mux.scala:47:69
    .io_req_is_probe                    (io_req_is_probe_0),
    .io_mem_acquire_ready
      (io_mem_acquire_ready & (idle ? ~_GEN_110 : state_3)),	// Arbiter.scala:16:61, :88:28, :116:26, :121:24, :123:31, package.scala:244:43
    .io_mem_grant_valid                 (_GEN_98 & io_mem_grant_valid),	// mshrs.scala:671:29, :673:{36,45}, :674:25
    .io_mem_grant_bits_opcode           (io_mem_grant_bits_opcode),
    .io_mem_grant_bits_param            (io_mem_grant_bits_param),
    .io_mem_grant_bits_size             (io_mem_grant_bits_size),
    .io_mem_grant_bits_sink             (io_mem_grant_bits_sink),
    .io_mem_grant_bits_data             (io_mem_grant_bits_data),
    .io_mem_finish_ready
      (io_mem_finish_ready & (beatsLeft_1 ? state_1_3 : ~_GEN_121)),	// Arbiter.scala:16:61, :87:30, :116:26, :121:24, :123:31, package.scala:244:43
    .io_prober_state_valid              (io_prober_state_valid),
    .io_prober_state_bits               (io_prober_state_bits),
    .io_refill_ready                    (_refill_arb_io_in_3_ready),	// mshrs.scala:604:30
    .io_meta_write_ready                (_meta_write_arb_io_in_3_ready),	// mshrs.scala:599:30
    .io_meta_read_ready                 (_meta_read_arb_io_in_3_ready),	// mshrs.scala:600:30
    .io_meta_resp_valid                 (io_meta_resp_valid),
    .io_meta_resp_bits_coh_state        (io_meta_resp_bits_coh_state),
    .io_wb_req_ready                    (_wb_req_arb_io_in_3_ready),	// mshrs.scala:601:30
    .io_lb_read_ready                   (_lb_read_arb_io_in_3_ready),	// mshrs.scala:569:28
    .io_lb_resp                         (lb_read_data),	// mshrs.scala:576:37, :580:38
    .io_lb_write_ready                  (_lb_write_arb_io_in_3_ready),	// mshrs.scala:570:28
    .io_replay_ready                    (_replay_arb_io_in_3_ready),	// mshrs.scala:602:30
    .io_resp_ready                      (_resp_arb_io_in_3_ready),	// mshrs.scala:603:30
    .io_wb_resp                         (io_wb_resp),
    .io_req_pri_rdy                     (_mshrs_3_io_req_pri_rdy),
    .io_req_sec_rdy                     (_mshrs_3_io_req_sec_rdy),
    .io_idx_valid                       (_mshrs_3_io_idx_valid),
    .io_idx_bits                        (_mshrs_3_io_idx_bits),
    .io_way_valid                       (_mshrs_3_io_way_valid),
    .io_way_bits                        (_mshrs_3_io_way_bits),
    .io_tag_valid                       (_mshrs_3_io_tag_valid),
    .io_tag_bits                        (_mshrs_3_io_tag_bits),
    .io_mem_acquire_valid               (_mshrs_3_io_mem_acquire_valid),
    .io_mem_acquire_bits_param          (_mshrs_3_io_mem_acquire_bits_param),
    .io_mem_acquire_bits_source         (_mshrs_3_io_mem_acquire_bits_source),
    .io_mem_acquire_bits_address        (_mshrs_3_io_mem_acquire_bits_address),
    .io_mem_grant_ready                 (_mshrs_3_io_mem_grant_ready),
    .io_mem_finish_valid                (_mshrs_3_io_mem_finish_valid),
    .io_mem_finish_bits_sink            (_mshrs_3_io_mem_finish_bits_sink),
    .io_refill_valid                    (_mshrs_3_io_refill_valid),
    .io_refill_bits_way_en              (_mshrs_3_io_refill_bits_way_en),
    .io_refill_bits_addr                (_mshrs_3_io_refill_bits_addr),
    .io_refill_bits_data                (_mshrs_3_io_refill_bits_data),
    .io_meta_write_valid                (_mshrs_3_io_meta_write_valid),
    .io_meta_write_bits_idx             (_mshrs_3_io_meta_write_bits_idx),
    .io_meta_write_bits_way_en          (_mshrs_3_io_meta_write_bits_way_en),
    .io_meta_write_bits_data_coh_state  (_mshrs_3_io_meta_write_bits_data_coh_state),
    .io_meta_write_bits_data_tag        (_mshrs_3_io_meta_write_bits_data_tag),
    .io_meta_read_valid                 (_mshrs_3_io_meta_read_valid),
    .io_meta_read_bits_idx              (_mshrs_3_io_meta_read_bits_idx),
    .io_meta_read_bits_way_en           (_mshrs_3_io_meta_read_bits_way_en),
    .io_meta_read_bits_tag              (_mshrs_3_io_meta_read_bits_tag),
    .io_wb_req_valid                    (_mshrs_3_io_wb_req_valid),
    .io_wb_req_bits_tag                 (_mshrs_3_io_wb_req_bits_tag),
    .io_wb_req_bits_idx                 (_mshrs_3_io_wb_req_bits_idx),
    .io_wb_req_bits_param               (_mshrs_3_io_wb_req_bits_param),
    .io_wb_req_bits_way_en              (_mshrs_3_io_wb_req_bits_way_en),
    .io_commit_val                      (_mshrs_3_io_commit_val),
    .io_commit_addr                     (_mshrs_3_io_commit_addr),
    .io_commit_coh_state                (_mshrs_3_io_commit_coh_state),
    .io_lb_read_valid                   (_mshrs_3_io_lb_read_valid),
    .io_lb_read_bits_id                 (_mshrs_3_io_lb_read_bits_id),
    .io_lb_read_bits_offset             (_mshrs_3_io_lb_read_bits_offset),
    .io_lb_write_valid                  (_mshrs_3_io_lb_write_valid),
    .io_lb_write_bits_id                (_mshrs_3_io_lb_write_bits_id),
    .io_lb_write_bits_offset            (_mshrs_3_io_lb_write_bits_offset),
    .io_lb_write_bits_data              (_mshrs_3_io_lb_write_bits_data),
    .io_replay_valid                    (_mshrs_3_io_replay_valid),
    .io_replay_bits_uop_uopc            (_mshrs_3_io_replay_bits_uop_uopc),
    .io_replay_bits_uop_inst            (_mshrs_3_io_replay_bits_uop_inst),
    .io_replay_bits_uop_debug_inst      (_mshrs_3_io_replay_bits_uop_debug_inst),
    .io_replay_bits_uop_is_rvc          (_mshrs_3_io_replay_bits_uop_is_rvc),
    .io_replay_bits_uop_debug_pc        (_mshrs_3_io_replay_bits_uop_debug_pc),
    .io_replay_bits_uop_iq_type         (_mshrs_3_io_replay_bits_uop_iq_type),
    .io_replay_bits_uop_fu_code         (_mshrs_3_io_replay_bits_uop_fu_code),
    .io_replay_bits_uop_ctrl_br_type    (_mshrs_3_io_replay_bits_uop_ctrl_br_type),
    .io_replay_bits_uop_ctrl_op1_sel    (_mshrs_3_io_replay_bits_uop_ctrl_op1_sel),
    .io_replay_bits_uop_ctrl_op2_sel    (_mshrs_3_io_replay_bits_uop_ctrl_op2_sel),
    .io_replay_bits_uop_ctrl_imm_sel    (_mshrs_3_io_replay_bits_uop_ctrl_imm_sel),
    .io_replay_bits_uop_ctrl_op_fcn     (_mshrs_3_io_replay_bits_uop_ctrl_op_fcn),
    .io_replay_bits_uop_ctrl_fcn_dw     (_mshrs_3_io_replay_bits_uop_ctrl_fcn_dw),
    .io_replay_bits_uop_ctrl_csr_cmd    (_mshrs_3_io_replay_bits_uop_ctrl_csr_cmd),
    .io_replay_bits_uop_ctrl_is_load    (_mshrs_3_io_replay_bits_uop_ctrl_is_load),
    .io_replay_bits_uop_ctrl_is_sta     (_mshrs_3_io_replay_bits_uop_ctrl_is_sta),
    .io_replay_bits_uop_ctrl_is_std     (_mshrs_3_io_replay_bits_uop_ctrl_is_std),
    .io_replay_bits_uop_iw_state        (_mshrs_3_io_replay_bits_uop_iw_state),
    .io_replay_bits_uop_iw_p1_poisoned  (_mshrs_3_io_replay_bits_uop_iw_p1_poisoned),
    .io_replay_bits_uop_iw_p2_poisoned  (_mshrs_3_io_replay_bits_uop_iw_p2_poisoned),
    .io_replay_bits_uop_is_br           (_mshrs_3_io_replay_bits_uop_is_br),
    .io_replay_bits_uop_is_jalr         (_mshrs_3_io_replay_bits_uop_is_jalr),
    .io_replay_bits_uop_is_jal          (_mshrs_3_io_replay_bits_uop_is_jal),
    .io_replay_bits_uop_is_sfb          (_mshrs_3_io_replay_bits_uop_is_sfb),
    .io_replay_bits_uop_br_mask         (_mshrs_3_io_replay_bits_uop_br_mask),
    .io_replay_bits_uop_br_tag          (_mshrs_3_io_replay_bits_uop_br_tag),
    .io_replay_bits_uop_ftq_idx         (_mshrs_3_io_replay_bits_uop_ftq_idx),
    .io_replay_bits_uop_edge_inst       (_mshrs_3_io_replay_bits_uop_edge_inst),
    .io_replay_bits_uop_pc_lob          (_mshrs_3_io_replay_bits_uop_pc_lob),
    .io_replay_bits_uop_taken           (_mshrs_3_io_replay_bits_uop_taken),
    .io_replay_bits_uop_imm_packed      (_mshrs_3_io_replay_bits_uop_imm_packed),
    .io_replay_bits_uop_csr_addr        (_mshrs_3_io_replay_bits_uop_csr_addr),
    .io_replay_bits_uop_rob_idx         (_mshrs_3_io_replay_bits_uop_rob_idx),
    .io_replay_bits_uop_ldq_idx         (_mshrs_3_io_replay_bits_uop_ldq_idx),
    .io_replay_bits_uop_stq_idx         (_mshrs_3_io_replay_bits_uop_stq_idx),
    .io_replay_bits_uop_rxq_idx         (_mshrs_3_io_replay_bits_uop_rxq_idx),
    .io_replay_bits_uop_pdst            (_mshrs_3_io_replay_bits_uop_pdst),
    .io_replay_bits_uop_prs1            (_mshrs_3_io_replay_bits_uop_prs1),
    .io_replay_bits_uop_prs2            (_mshrs_3_io_replay_bits_uop_prs2),
    .io_replay_bits_uop_prs3            (_mshrs_3_io_replay_bits_uop_prs3),
    .io_replay_bits_uop_ppred           (_mshrs_3_io_replay_bits_uop_ppred),
    .io_replay_bits_uop_prs1_busy       (_mshrs_3_io_replay_bits_uop_prs1_busy),
    .io_replay_bits_uop_prs2_busy       (_mshrs_3_io_replay_bits_uop_prs2_busy),
    .io_replay_bits_uop_prs3_busy       (_mshrs_3_io_replay_bits_uop_prs3_busy),
    .io_replay_bits_uop_ppred_busy      (_mshrs_3_io_replay_bits_uop_ppred_busy),
    .io_replay_bits_uop_stale_pdst      (_mshrs_3_io_replay_bits_uop_stale_pdst),
    .io_replay_bits_uop_exception       (_mshrs_3_io_replay_bits_uop_exception),
    .io_replay_bits_uop_exc_cause       (_mshrs_3_io_replay_bits_uop_exc_cause),
    .io_replay_bits_uop_bypassable      (_mshrs_3_io_replay_bits_uop_bypassable),
    .io_replay_bits_uop_mem_cmd         (_mshrs_3_io_replay_bits_uop_mem_cmd),
    .io_replay_bits_uop_mem_size        (_mshrs_3_io_replay_bits_uop_mem_size),
    .io_replay_bits_uop_mem_signed      (_mshrs_3_io_replay_bits_uop_mem_signed),
    .io_replay_bits_uop_is_fence        (_mshrs_3_io_replay_bits_uop_is_fence),
    .io_replay_bits_uop_is_fencei       (_mshrs_3_io_replay_bits_uop_is_fencei),
    .io_replay_bits_uop_is_amo          (_mshrs_3_io_replay_bits_uop_is_amo),
    .io_replay_bits_uop_uses_ldq        (_mshrs_3_io_replay_bits_uop_uses_ldq),
    .io_replay_bits_uop_uses_stq        (_mshrs_3_io_replay_bits_uop_uses_stq),
    .io_replay_bits_uop_is_sys_pc2epc   (_mshrs_3_io_replay_bits_uop_is_sys_pc2epc),
    .io_replay_bits_uop_is_unique       (_mshrs_3_io_replay_bits_uop_is_unique),
    .io_replay_bits_uop_flush_on_commit (_mshrs_3_io_replay_bits_uop_flush_on_commit),
    .io_replay_bits_uop_ldst_is_rs1     (_mshrs_3_io_replay_bits_uop_ldst_is_rs1),
    .io_replay_bits_uop_ldst            (_mshrs_3_io_replay_bits_uop_ldst),
    .io_replay_bits_uop_lrs1            (_mshrs_3_io_replay_bits_uop_lrs1),
    .io_replay_bits_uop_lrs2            (_mshrs_3_io_replay_bits_uop_lrs2),
    .io_replay_bits_uop_lrs3            (_mshrs_3_io_replay_bits_uop_lrs3),
    .io_replay_bits_uop_ldst_val        (_mshrs_3_io_replay_bits_uop_ldst_val),
    .io_replay_bits_uop_dst_rtype       (_mshrs_3_io_replay_bits_uop_dst_rtype),
    .io_replay_bits_uop_lrs1_rtype      (_mshrs_3_io_replay_bits_uop_lrs1_rtype),
    .io_replay_bits_uop_lrs2_rtype      (_mshrs_3_io_replay_bits_uop_lrs2_rtype),
    .io_replay_bits_uop_frs3_en         (_mshrs_3_io_replay_bits_uop_frs3_en),
    .io_replay_bits_uop_fp_val          (_mshrs_3_io_replay_bits_uop_fp_val),
    .io_replay_bits_uop_fp_single       (_mshrs_3_io_replay_bits_uop_fp_single),
    .io_replay_bits_uop_xcpt_pf_if      (_mshrs_3_io_replay_bits_uop_xcpt_pf_if),
    .io_replay_bits_uop_xcpt_ae_if      (_mshrs_3_io_replay_bits_uop_xcpt_ae_if),
    .io_replay_bits_uop_xcpt_ma_if      (_mshrs_3_io_replay_bits_uop_xcpt_ma_if),
    .io_replay_bits_uop_bp_debug_if     (_mshrs_3_io_replay_bits_uop_bp_debug_if),
    .io_replay_bits_uop_bp_xcpt_if      (_mshrs_3_io_replay_bits_uop_bp_xcpt_if),
    .io_replay_bits_uop_debug_fsrc      (_mshrs_3_io_replay_bits_uop_debug_fsrc),
    .io_replay_bits_uop_debug_tsrc      (_mshrs_3_io_replay_bits_uop_debug_tsrc),
    .io_replay_bits_addr                (_mshrs_3_io_replay_bits_addr),
    .io_replay_bits_is_hella            (_mshrs_3_io_replay_bits_is_hella),
    .io_replay_bits_way_en              (_mshrs_3_io_replay_bits_way_en),
    .io_replay_bits_sdq_id              (_mshrs_3_io_replay_bits_sdq_id),
    .io_resp_valid                      (_mshrs_3_io_resp_valid),
    .io_resp_bits_uop_uopc              (_mshrs_3_io_resp_bits_uop_uopc),
    .io_resp_bits_uop_inst              (_mshrs_3_io_resp_bits_uop_inst),
    .io_resp_bits_uop_debug_inst        (_mshrs_3_io_resp_bits_uop_debug_inst),
    .io_resp_bits_uop_is_rvc            (_mshrs_3_io_resp_bits_uop_is_rvc),
    .io_resp_bits_uop_debug_pc          (_mshrs_3_io_resp_bits_uop_debug_pc),
    .io_resp_bits_uop_iq_type           (_mshrs_3_io_resp_bits_uop_iq_type),
    .io_resp_bits_uop_fu_code           (_mshrs_3_io_resp_bits_uop_fu_code),
    .io_resp_bits_uop_ctrl_br_type      (_mshrs_3_io_resp_bits_uop_ctrl_br_type),
    .io_resp_bits_uop_ctrl_op1_sel      (_mshrs_3_io_resp_bits_uop_ctrl_op1_sel),
    .io_resp_bits_uop_ctrl_op2_sel      (_mshrs_3_io_resp_bits_uop_ctrl_op2_sel),
    .io_resp_bits_uop_ctrl_imm_sel      (_mshrs_3_io_resp_bits_uop_ctrl_imm_sel),
    .io_resp_bits_uop_ctrl_op_fcn       (_mshrs_3_io_resp_bits_uop_ctrl_op_fcn),
    .io_resp_bits_uop_ctrl_fcn_dw       (_mshrs_3_io_resp_bits_uop_ctrl_fcn_dw),
    .io_resp_bits_uop_ctrl_csr_cmd      (_mshrs_3_io_resp_bits_uop_ctrl_csr_cmd),
    .io_resp_bits_uop_ctrl_is_load      (_mshrs_3_io_resp_bits_uop_ctrl_is_load),
    .io_resp_bits_uop_ctrl_is_sta       (_mshrs_3_io_resp_bits_uop_ctrl_is_sta),
    .io_resp_bits_uop_ctrl_is_std       (_mshrs_3_io_resp_bits_uop_ctrl_is_std),
    .io_resp_bits_uop_iw_state          (_mshrs_3_io_resp_bits_uop_iw_state),
    .io_resp_bits_uop_iw_p1_poisoned    (_mshrs_3_io_resp_bits_uop_iw_p1_poisoned),
    .io_resp_bits_uop_iw_p2_poisoned    (_mshrs_3_io_resp_bits_uop_iw_p2_poisoned),
    .io_resp_bits_uop_is_br             (_mshrs_3_io_resp_bits_uop_is_br),
    .io_resp_bits_uop_is_jalr           (_mshrs_3_io_resp_bits_uop_is_jalr),
    .io_resp_bits_uop_is_jal            (_mshrs_3_io_resp_bits_uop_is_jal),
    .io_resp_bits_uop_is_sfb            (_mshrs_3_io_resp_bits_uop_is_sfb),
    .io_resp_bits_uop_br_mask           (_mshrs_3_io_resp_bits_uop_br_mask),
    .io_resp_bits_uop_br_tag            (_mshrs_3_io_resp_bits_uop_br_tag),
    .io_resp_bits_uop_ftq_idx           (_mshrs_3_io_resp_bits_uop_ftq_idx),
    .io_resp_bits_uop_edge_inst         (_mshrs_3_io_resp_bits_uop_edge_inst),
    .io_resp_bits_uop_pc_lob            (_mshrs_3_io_resp_bits_uop_pc_lob),
    .io_resp_bits_uop_taken             (_mshrs_3_io_resp_bits_uop_taken),
    .io_resp_bits_uop_imm_packed        (_mshrs_3_io_resp_bits_uop_imm_packed),
    .io_resp_bits_uop_csr_addr          (_mshrs_3_io_resp_bits_uop_csr_addr),
    .io_resp_bits_uop_rob_idx           (_mshrs_3_io_resp_bits_uop_rob_idx),
    .io_resp_bits_uop_ldq_idx           (_mshrs_3_io_resp_bits_uop_ldq_idx),
    .io_resp_bits_uop_stq_idx           (_mshrs_3_io_resp_bits_uop_stq_idx),
    .io_resp_bits_uop_rxq_idx           (_mshrs_3_io_resp_bits_uop_rxq_idx),
    .io_resp_bits_uop_pdst              (_mshrs_3_io_resp_bits_uop_pdst),
    .io_resp_bits_uop_prs1              (_mshrs_3_io_resp_bits_uop_prs1),
    .io_resp_bits_uop_prs2              (_mshrs_3_io_resp_bits_uop_prs2),
    .io_resp_bits_uop_prs3              (_mshrs_3_io_resp_bits_uop_prs3),
    .io_resp_bits_uop_ppred             (_mshrs_3_io_resp_bits_uop_ppred),
    .io_resp_bits_uop_prs1_busy         (_mshrs_3_io_resp_bits_uop_prs1_busy),
    .io_resp_bits_uop_prs2_busy         (_mshrs_3_io_resp_bits_uop_prs2_busy),
    .io_resp_bits_uop_prs3_busy         (_mshrs_3_io_resp_bits_uop_prs3_busy),
    .io_resp_bits_uop_ppred_busy        (_mshrs_3_io_resp_bits_uop_ppred_busy),
    .io_resp_bits_uop_stale_pdst        (_mshrs_3_io_resp_bits_uop_stale_pdst),
    .io_resp_bits_uop_exception         (_mshrs_3_io_resp_bits_uop_exception),
    .io_resp_bits_uop_exc_cause         (_mshrs_3_io_resp_bits_uop_exc_cause),
    .io_resp_bits_uop_bypassable        (_mshrs_3_io_resp_bits_uop_bypassable),
    .io_resp_bits_uop_mem_cmd           (_mshrs_3_io_resp_bits_uop_mem_cmd),
    .io_resp_bits_uop_mem_size          (_mshrs_3_io_resp_bits_uop_mem_size),
    .io_resp_bits_uop_mem_signed        (_mshrs_3_io_resp_bits_uop_mem_signed),
    .io_resp_bits_uop_is_fence          (_mshrs_3_io_resp_bits_uop_is_fence),
    .io_resp_bits_uop_is_fencei         (_mshrs_3_io_resp_bits_uop_is_fencei),
    .io_resp_bits_uop_is_amo            (_mshrs_3_io_resp_bits_uop_is_amo),
    .io_resp_bits_uop_uses_ldq          (_mshrs_3_io_resp_bits_uop_uses_ldq),
    .io_resp_bits_uop_uses_stq          (_mshrs_3_io_resp_bits_uop_uses_stq),
    .io_resp_bits_uop_is_sys_pc2epc     (_mshrs_3_io_resp_bits_uop_is_sys_pc2epc),
    .io_resp_bits_uop_is_unique         (_mshrs_3_io_resp_bits_uop_is_unique),
    .io_resp_bits_uop_flush_on_commit   (_mshrs_3_io_resp_bits_uop_flush_on_commit),
    .io_resp_bits_uop_ldst_is_rs1       (_mshrs_3_io_resp_bits_uop_ldst_is_rs1),
    .io_resp_bits_uop_ldst              (_mshrs_3_io_resp_bits_uop_ldst),
    .io_resp_bits_uop_lrs1              (_mshrs_3_io_resp_bits_uop_lrs1),
    .io_resp_bits_uop_lrs2              (_mshrs_3_io_resp_bits_uop_lrs2),
    .io_resp_bits_uop_lrs3              (_mshrs_3_io_resp_bits_uop_lrs3),
    .io_resp_bits_uop_ldst_val          (_mshrs_3_io_resp_bits_uop_ldst_val),
    .io_resp_bits_uop_dst_rtype         (_mshrs_3_io_resp_bits_uop_dst_rtype),
    .io_resp_bits_uop_lrs1_rtype        (_mshrs_3_io_resp_bits_uop_lrs1_rtype),
    .io_resp_bits_uop_lrs2_rtype        (_mshrs_3_io_resp_bits_uop_lrs2_rtype),
    .io_resp_bits_uop_frs3_en           (_mshrs_3_io_resp_bits_uop_frs3_en),
    .io_resp_bits_uop_fp_val            (_mshrs_3_io_resp_bits_uop_fp_val),
    .io_resp_bits_uop_fp_single         (_mshrs_3_io_resp_bits_uop_fp_single),
    .io_resp_bits_uop_xcpt_pf_if        (_mshrs_3_io_resp_bits_uop_xcpt_pf_if),
    .io_resp_bits_uop_xcpt_ae_if        (_mshrs_3_io_resp_bits_uop_xcpt_ae_if),
    .io_resp_bits_uop_xcpt_ma_if        (_mshrs_3_io_resp_bits_uop_xcpt_ma_if),
    .io_resp_bits_uop_bp_debug_if       (_mshrs_3_io_resp_bits_uop_bp_debug_if),
    .io_resp_bits_uop_bp_xcpt_if        (_mshrs_3_io_resp_bits_uop_bp_xcpt_if),
    .io_resp_bits_uop_debug_fsrc        (_mshrs_3_io_resp_bits_uop_debug_fsrc),
    .io_resp_bits_uop_debug_tsrc        (_mshrs_3_io_resp_bits_uop_debug_tsrc),
    .io_resp_bits_data                  (_mshrs_3_io_resp_bits_data),
    .io_resp_bits_is_hella              (_mshrs_3_io_resp_bits_is_hella),
    .io_probe_rdy                       (_mshrs_3_io_probe_rdy)
  );
  BoomMSHR mshrs_4 (	// mshrs.scala:620:22
    .clock                              (clock),
    .reset                              (reset),
    .io_id                              (3'h4),	// Mux.scala:47:69
    .io_req_pri_val                     (mshr_alloc_idx_REG == 3'h4 & pri_val),	// Mux.scala:47:69, mshrs.scala:618:51, :632:{34,54}, :694:31
    .io_req_sec_val                     (_mshr_io_req_sec_val_T_19),	// mshrs.scala:637:99
    .io_clear_prefetch
      (io_clear_all & ~_GEN | _GEN & _GEN_91 & cacheable & ~_GEN_86 | io_req_is_probe_0
       & _GEN_91),	// Parameters.scala:137:31, :671:42, mshrs.scala:637:{50,72}, :644:{46,49}, :645:{58,61,82}, :646:21
    .io_brupdate_b1_resolve_mask        (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask     (io_brupdate_b1_mispredict_mask),
    .io_exception                       (io_exception),
    .io_req_uop_uopc                    (_GEN_0),	// Parameters.scala:137:31
    .io_req_uop_inst                    (_GEN_1),	// Parameters.scala:137:31
    .io_req_uop_debug_inst              (_GEN_2),	// Parameters.scala:137:31
    .io_req_uop_is_rvc                  (_GEN_3),	// Parameters.scala:137:31
    .io_req_uop_debug_pc                (_GEN_4),	// Parameters.scala:137:31
    .io_req_uop_iq_type                 (_GEN_5),	// Parameters.scala:137:31
    .io_req_uop_fu_code                 (_GEN_6),	// Parameters.scala:137:31
    .io_req_uop_ctrl_br_type            (_GEN_7),	// Parameters.scala:137:31
    .io_req_uop_ctrl_op1_sel            (_GEN_8),	// Parameters.scala:137:31
    .io_req_uop_ctrl_op2_sel            (_GEN_9),	// Parameters.scala:137:31
    .io_req_uop_ctrl_imm_sel            (_GEN_10),	// Parameters.scala:137:31
    .io_req_uop_ctrl_op_fcn             (_GEN_11),	// Parameters.scala:137:31
    .io_req_uop_ctrl_fcn_dw             (_GEN_12),	// Parameters.scala:137:31
    .io_req_uop_ctrl_csr_cmd            (_GEN_13),	// Parameters.scala:137:31
    .io_req_uop_ctrl_is_load            (_GEN_14),	// Parameters.scala:137:31
    .io_req_uop_ctrl_is_sta             (_GEN_15),	// Parameters.scala:137:31
    .io_req_uop_ctrl_is_std             (_GEN_16),	// Parameters.scala:137:31
    .io_req_uop_iw_state                (_GEN_17),	// Parameters.scala:137:31
    .io_req_uop_iw_p1_poisoned          (_GEN_18),	// Parameters.scala:137:31
    .io_req_uop_iw_p2_poisoned          (_GEN_19),	// Parameters.scala:137:31
    .io_req_uop_is_br                   (_GEN_20),	// Parameters.scala:137:31
    .io_req_uop_is_jalr                 (_GEN_21),	// Parameters.scala:137:31
    .io_req_uop_is_jal                  (_GEN_22),	// Parameters.scala:137:31
    .io_req_uop_is_sfb                  (_GEN_23),	// Parameters.scala:137:31
    .io_req_uop_br_mask                 (_GEN_24),	// Parameters.scala:137:31
    .io_req_uop_br_tag                  (_GEN_25),	// Parameters.scala:137:31
    .io_req_uop_ftq_idx                 (_GEN_26),	// Parameters.scala:137:31
    .io_req_uop_edge_inst               (_GEN_27),	// Parameters.scala:137:31
    .io_req_uop_pc_lob                  (_GEN_28),	// Parameters.scala:137:31
    .io_req_uop_taken                   (_GEN_29),	// Parameters.scala:137:31
    .io_req_uop_imm_packed              (_GEN_30),	// Parameters.scala:137:31
    .io_req_uop_csr_addr                (_GEN_31),	// Parameters.scala:137:31
    .io_req_uop_rob_idx                 (_GEN_32),	// Parameters.scala:137:31
    .io_req_uop_ldq_idx                 (_GEN_33),	// Parameters.scala:137:31
    .io_req_uop_stq_idx                 (_GEN_34),	// Parameters.scala:137:31
    .io_req_uop_rxq_idx                 (_GEN_35),	// Parameters.scala:137:31
    .io_req_uop_pdst                    (_GEN_36),	// Parameters.scala:137:31
    .io_req_uop_prs1                    (_GEN_37),	// Parameters.scala:137:31
    .io_req_uop_prs2                    (_GEN_38),	// Parameters.scala:137:31
    .io_req_uop_prs3                    (_GEN_39),	// Parameters.scala:137:31
    .io_req_uop_ppred                   (_GEN_40),	// Parameters.scala:137:31
    .io_req_uop_prs1_busy               (_GEN_41),	// Parameters.scala:137:31
    .io_req_uop_prs2_busy               (_GEN_42),	// Parameters.scala:137:31
    .io_req_uop_prs3_busy               (_GEN_43),	// Parameters.scala:137:31
    .io_req_uop_ppred_busy              (_GEN_44),	// Parameters.scala:137:31
    .io_req_uop_stale_pdst              (_GEN_45),	// Parameters.scala:137:31
    .io_req_uop_exception               (_GEN_46),	// Parameters.scala:137:31
    .io_req_uop_exc_cause               (_GEN_47),	// Parameters.scala:137:31
    .io_req_uop_bypassable              (_GEN_48),	// Parameters.scala:137:31
    .io_req_uop_mem_cmd                 (_GEN_49),	// Parameters.scala:137:31
    .io_req_uop_mem_size                (_GEN_50),	// Parameters.scala:137:31
    .io_req_uop_mem_signed              (_GEN_51),	// Parameters.scala:137:31
    .io_req_uop_is_fence                (_GEN_52),	// Parameters.scala:137:31
    .io_req_uop_is_fencei               (_GEN_53),	// Parameters.scala:137:31
    .io_req_uop_is_amo                  (_GEN_54),	// Parameters.scala:137:31
    .io_req_uop_uses_ldq                (_GEN_55),	// Parameters.scala:137:31
    .io_req_uop_uses_stq                (_GEN_56),	// Parameters.scala:137:31
    .io_req_uop_is_sys_pc2epc           (_GEN_57),	// Parameters.scala:137:31
    .io_req_uop_is_unique               (_GEN_58),	// Parameters.scala:137:31
    .io_req_uop_flush_on_commit         (_GEN_59),	// Parameters.scala:137:31
    .io_req_uop_ldst_is_rs1             (_GEN_60),	// Parameters.scala:137:31
    .io_req_uop_ldst                    (_GEN_61),	// Parameters.scala:137:31
    .io_req_uop_lrs1                    (_GEN_62),	// Parameters.scala:137:31
    .io_req_uop_lrs2                    (_GEN_63),	// Parameters.scala:137:31
    .io_req_uop_lrs3                    (_GEN_64),	// Parameters.scala:137:31
    .io_req_uop_ldst_val                (_GEN_65),	// Parameters.scala:137:31
    .io_req_uop_dst_rtype               (_GEN_66),	// Parameters.scala:137:31
    .io_req_uop_lrs1_rtype              (_GEN_67),	// Parameters.scala:137:31
    .io_req_uop_lrs2_rtype              (_GEN_68),	// Parameters.scala:137:31
    .io_req_uop_frs3_en                 (_GEN_69),	// Parameters.scala:137:31
    .io_req_uop_fp_val                  (_GEN_70),	// Parameters.scala:137:31
    .io_req_uop_fp_single               (_GEN_71),	// Parameters.scala:137:31
    .io_req_uop_xcpt_pf_if              (_GEN_72),	// Parameters.scala:137:31
    .io_req_uop_xcpt_ae_if              (_GEN_73),	// Parameters.scala:137:31
    .io_req_uop_xcpt_ma_if              (_GEN_74),	// Parameters.scala:137:31
    .io_req_uop_bp_debug_if             (_GEN_75),	// Parameters.scala:137:31
    .io_req_uop_bp_xcpt_if              (_GEN_76),	// Parameters.scala:137:31
    .io_req_uop_debug_fsrc              (_GEN_77),	// Parameters.scala:137:31
    .io_req_uop_debug_tsrc              (_GEN_78),	// Parameters.scala:137:31
    .io_req_addr                        (_cacheable_T_1),	// Parameters.scala:137:31
    .io_req_data                        (_GEN_79),	// Parameters.scala:137:31
    .io_req_is_hella                    (_GEN_80),	// Parameters.scala:137:31
    .io_req_tag_match                   (_GEN_81),	// Parameters.scala:137:31
    .io_req_old_meta_coh_state          (_GEN_82),	// Parameters.scala:137:31
    .io_req_old_meta_tag                (_GEN_83),	// Parameters.scala:137:31
    .io_req_way_en                      (_GEN_84),	// Parameters.scala:137:31
    .io_req_sdq_id                      (sdq_alloc_id),	// Mux.scala:47:69
    .io_req_is_probe                    (io_req_is_probe_0),
    .io_mem_acquire_ready
      (io_mem_acquire_ready & (idle ? ~_GEN_109 : state_4)),	// Arbiter.scala:16:61, :88:28, :116:26, :121:24, :123:31, package.scala:244:43
    .io_mem_grant_valid                 (_GEN_99 & io_mem_grant_valid),	// mshrs.scala:671:29, :673:{36,45}, :674:25
    .io_mem_grant_bits_opcode           (io_mem_grant_bits_opcode),
    .io_mem_grant_bits_param            (io_mem_grant_bits_param),
    .io_mem_grant_bits_size             (io_mem_grant_bits_size),
    .io_mem_grant_bits_sink             (io_mem_grant_bits_sink),
    .io_mem_grant_bits_data             (io_mem_grant_bits_data),
    .io_mem_finish_ready
      (io_mem_finish_ready & (beatsLeft_1 ? state_1_4 : ~_GEN_120)),	// Arbiter.scala:16:61, :87:30, :116:26, :121:24, :123:31, package.scala:244:43
    .io_prober_state_valid              (io_prober_state_valid),
    .io_prober_state_bits               (io_prober_state_bits),
    .io_refill_ready                    (_refill_arb_io_in_4_ready),	// mshrs.scala:604:30
    .io_meta_write_ready                (_meta_write_arb_io_in_4_ready),	// mshrs.scala:599:30
    .io_meta_read_ready                 (_meta_read_arb_io_in_4_ready),	// mshrs.scala:600:30
    .io_meta_resp_valid                 (io_meta_resp_valid),
    .io_meta_resp_bits_coh_state        (io_meta_resp_bits_coh_state),
    .io_wb_req_ready                    (_wb_req_arb_io_in_4_ready),	// mshrs.scala:601:30
    .io_lb_read_ready                   (_lb_read_arb_io_in_4_ready),	// mshrs.scala:569:28
    .io_lb_resp                         (lb_read_data),	// mshrs.scala:576:37, :580:38
    .io_lb_write_ready                  (_lb_write_arb_io_in_4_ready),	// mshrs.scala:570:28
    .io_replay_ready                    (_replay_arb_io_in_4_ready),	// mshrs.scala:602:30
    .io_resp_ready                      (_resp_arb_io_in_4_ready),	// mshrs.scala:603:30
    .io_wb_resp                         (io_wb_resp),
    .io_req_pri_rdy                     (_mshrs_4_io_req_pri_rdy),
    .io_req_sec_rdy                     (_mshrs_4_io_req_sec_rdy),
    .io_idx_valid                       (_mshrs_4_io_idx_valid),
    .io_idx_bits                        (_mshrs_4_io_idx_bits),
    .io_way_valid                       (_mshrs_4_io_way_valid),
    .io_way_bits                        (_mshrs_4_io_way_bits),
    .io_tag_valid                       (_mshrs_4_io_tag_valid),
    .io_tag_bits                        (_mshrs_4_io_tag_bits),
    .io_mem_acquire_valid               (_mshrs_4_io_mem_acquire_valid),
    .io_mem_acquire_bits_param          (_mshrs_4_io_mem_acquire_bits_param),
    .io_mem_acquire_bits_source         (_mshrs_4_io_mem_acquire_bits_source),
    .io_mem_acquire_bits_address        (_mshrs_4_io_mem_acquire_bits_address),
    .io_mem_grant_ready                 (_mshrs_4_io_mem_grant_ready),
    .io_mem_finish_valid                (_mshrs_4_io_mem_finish_valid),
    .io_mem_finish_bits_sink            (_mshrs_4_io_mem_finish_bits_sink),
    .io_refill_valid                    (_mshrs_4_io_refill_valid),
    .io_refill_bits_way_en              (_mshrs_4_io_refill_bits_way_en),
    .io_refill_bits_addr                (_mshrs_4_io_refill_bits_addr),
    .io_refill_bits_data                (_mshrs_4_io_refill_bits_data),
    .io_meta_write_valid                (_mshrs_4_io_meta_write_valid),
    .io_meta_write_bits_idx             (_mshrs_4_io_meta_write_bits_idx),
    .io_meta_write_bits_way_en          (_mshrs_4_io_meta_write_bits_way_en),
    .io_meta_write_bits_data_coh_state  (_mshrs_4_io_meta_write_bits_data_coh_state),
    .io_meta_write_bits_data_tag        (_mshrs_4_io_meta_write_bits_data_tag),
    .io_meta_read_valid                 (_mshrs_4_io_meta_read_valid),
    .io_meta_read_bits_idx              (_mshrs_4_io_meta_read_bits_idx),
    .io_meta_read_bits_way_en           (_mshrs_4_io_meta_read_bits_way_en),
    .io_meta_read_bits_tag              (_mshrs_4_io_meta_read_bits_tag),
    .io_wb_req_valid                    (_mshrs_4_io_wb_req_valid),
    .io_wb_req_bits_tag                 (_mshrs_4_io_wb_req_bits_tag),
    .io_wb_req_bits_idx                 (_mshrs_4_io_wb_req_bits_idx),
    .io_wb_req_bits_param               (_mshrs_4_io_wb_req_bits_param),
    .io_wb_req_bits_way_en              (_mshrs_4_io_wb_req_bits_way_en),
    .io_commit_val                      (_mshrs_4_io_commit_val),
    .io_commit_addr                     (_mshrs_4_io_commit_addr),
    .io_commit_coh_state                (_mshrs_4_io_commit_coh_state),
    .io_lb_read_valid                   (_mshrs_4_io_lb_read_valid),
    .io_lb_read_bits_id                 (_mshrs_4_io_lb_read_bits_id),
    .io_lb_read_bits_offset             (_mshrs_4_io_lb_read_bits_offset),
    .io_lb_write_valid                  (_mshrs_4_io_lb_write_valid),
    .io_lb_write_bits_id                (_mshrs_4_io_lb_write_bits_id),
    .io_lb_write_bits_offset            (_mshrs_4_io_lb_write_bits_offset),
    .io_lb_write_bits_data              (_mshrs_4_io_lb_write_bits_data),
    .io_replay_valid                    (_mshrs_4_io_replay_valid),
    .io_replay_bits_uop_uopc            (_mshrs_4_io_replay_bits_uop_uopc),
    .io_replay_bits_uop_inst            (_mshrs_4_io_replay_bits_uop_inst),
    .io_replay_bits_uop_debug_inst      (_mshrs_4_io_replay_bits_uop_debug_inst),
    .io_replay_bits_uop_is_rvc          (_mshrs_4_io_replay_bits_uop_is_rvc),
    .io_replay_bits_uop_debug_pc        (_mshrs_4_io_replay_bits_uop_debug_pc),
    .io_replay_bits_uop_iq_type         (_mshrs_4_io_replay_bits_uop_iq_type),
    .io_replay_bits_uop_fu_code         (_mshrs_4_io_replay_bits_uop_fu_code),
    .io_replay_bits_uop_ctrl_br_type    (_mshrs_4_io_replay_bits_uop_ctrl_br_type),
    .io_replay_bits_uop_ctrl_op1_sel    (_mshrs_4_io_replay_bits_uop_ctrl_op1_sel),
    .io_replay_bits_uop_ctrl_op2_sel    (_mshrs_4_io_replay_bits_uop_ctrl_op2_sel),
    .io_replay_bits_uop_ctrl_imm_sel    (_mshrs_4_io_replay_bits_uop_ctrl_imm_sel),
    .io_replay_bits_uop_ctrl_op_fcn     (_mshrs_4_io_replay_bits_uop_ctrl_op_fcn),
    .io_replay_bits_uop_ctrl_fcn_dw     (_mshrs_4_io_replay_bits_uop_ctrl_fcn_dw),
    .io_replay_bits_uop_ctrl_csr_cmd    (_mshrs_4_io_replay_bits_uop_ctrl_csr_cmd),
    .io_replay_bits_uop_ctrl_is_load    (_mshrs_4_io_replay_bits_uop_ctrl_is_load),
    .io_replay_bits_uop_ctrl_is_sta     (_mshrs_4_io_replay_bits_uop_ctrl_is_sta),
    .io_replay_bits_uop_ctrl_is_std     (_mshrs_4_io_replay_bits_uop_ctrl_is_std),
    .io_replay_bits_uop_iw_state        (_mshrs_4_io_replay_bits_uop_iw_state),
    .io_replay_bits_uop_iw_p1_poisoned  (_mshrs_4_io_replay_bits_uop_iw_p1_poisoned),
    .io_replay_bits_uop_iw_p2_poisoned  (_mshrs_4_io_replay_bits_uop_iw_p2_poisoned),
    .io_replay_bits_uop_is_br           (_mshrs_4_io_replay_bits_uop_is_br),
    .io_replay_bits_uop_is_jalr         (_mshrs_4_io_replay_bits_uop_is_jalr),
    .io_replay_bits_uop_is_jal          (_mshrs_4_io_replay_bits_uop_is_jal),
    .io_replay_bits_uop_is_sfb          (_mshrs_4_io_replay_bits_uop_is_sfb),
    .io_replay_bits_uop_br_mask         (_mshrs_4_io_replay_bits_uop_br_mask),
    .io_replay_bits_uop_br_tag          (_mshrs_4_io_replay_bits_uop_br_tag),
    .io_replay_bits_uop_ftq_idx         (_mshrs_4_io_replay_bits_uop_ftq_idx),
    .io_replay_bits_uop_edge_inst       (_mshrs_4_io_replay_bits_uop_edge_inst),
    .io_replay_bits_uop_pc_lob          (_mshrs_4_io_replay_bits_uop_pc_lob),
    .io_replay_bits_uop_taken           (_mshrs_4_io_replay_bits_uop_taken),
    .io_replay_bits_uop_imm_packed      (_mshrs_4_io_replay_bits_uop_imm_packed),
    .io_replay_bits_uop_csr_addr        (_mshrs_4_io_replay_bits_uop_csr_addr),
    .io_replay_bits_uop_rob_idx         (_mshrs_4_io_replay_bits_uop_rob_idx),
    .io_replay_bits_uop_ldq_idx         (_mshrs_4_io_replay_bits_uop_ldq_idx),
    .io_replay_bits_uop_stq_idx         (_mshrs_4_io_replay_bits_uop_stq_idx),
    .io_replay_bits_uop_rxq_idx         (_mshrs_4_io_replay_bits_uop_rxq_idx),
    .io_replay_bits_uop_pdst            (_mshrs_4_io_replay_bits_uop_pdst),
    .io_replay_bits_uop_prs1            (_mshrs_4_io_replay_bits_uop_prs1),
    .io_replay_bits_uop_prs2            (_mshrs_4_io_replay_bits_uop_prs2),
    .io_replay_bits_uop_prs3            (_mshrs_4_io_replay_bits_uop_prs3),
    .io_replay_bits_uop_ppred           (_mshrs_4_io_replay_bits_uop_ppred),
    .io_replay_bits_uop_prs1_busy       (_mshrs_4_io_replay_bits_uop_prs1_busy),
    .io_replay_bits_uop_prs2_busy       (_mshrs_4_io_replay_bits_uop_prs2_busy),
    .io_replay_bits_uop_prs3_busy       (_mshrs_4_io_replay_bits_uop_prs3_busy),
    .io_replay_bits_uop_ppred_busy      (_mshrs_4_io_replay_bits_uop_ppred_busy),
    .io_replay_bits_uop_stale_pdst      (_mshrs_4_io_replay_bits_uop_stale_pdst),
    .io_replay_bits_uop_exception       (_mshrs_4_io_replay_bits_uop_exception),
    .io_replay_bits_uop_exc_cause       (_mshrs_4_io_replay_bits_uop_exc_cause),
    .io_replay_bits_uop_bypassable      (_mshrs_4_io_replay_bits_uop_bypassable),
    .io_replay_bits_uop_mem_cmd         (_mshrs_4_io_replay_bits_uop_mem_cmd),
    .io_replay_bits_uop_mem_size        (_mshrs_4_io_replay_bits_uop_mem_size),
    .io_replay_bits_uop_mem_signed      (_mshrs_4_io_replay_bits_uop_mem_signed),
    .io_replay_bits_uop_is_fence        (_mshrs_4_io_replay_bits_uop_is_fence),
    .io_replay_bits_uop_is_fencei       (_mshrs_4_io_replay_bits_uop_is_fencei),
    .io_replay_bits_uop_is_amo          (_mshrs_4_io_replay_bits_uop_is_amo),
    .io_replay_bits_uop_uses_ldq        (_mshrs_4_io_replay_bits_uop_uses_ldq),
    .io_replay_bits_uop_uses_stq        (_mshrs_4_io_replay_bits_uop_uses_stq),
    .io_replay_bits_uop_is_sys_pc2epc   (_mshrs_4_io_replay_bits_uop_is_sys_pc2epc),
    .io_replay_bits_uop_is_unique       (_mshrs_4_io_replay_bits_uop_is_unique),
    .io_replay_bits_uop_flush_on_commit (_mshrs_4_io_replay_bits_uop_flush_on_commit),
    .io_replay_bits_uop_ldst_is_rs1     (_mshrs_4_io_replay_bits_uop_ldst_is_rs1),
    .io_replay_bits_uop_ldst            (_mshrs_4_io_replay_bits_uop_ldst),
    .io_replay_bits_uop_lrs1            (_mshrs_4_io_replay_bits_uop_lrs1),
    .io_replay_bits_uop_lrs2            (_mshrs_4_io_replay_bits_uop_lrs2),
    .io_replay_bits_uop_lrs3            (_mshrs_4_io_replay_bits_uop_lrs3),
    .io_replay_bits_uop_ldst_val        (_mshrs_4_io_replay_bits_uop_ldst_val),
    .io_replay_bits_uop_dst_rtype       (_mshrs_4_io_replay_bits_uop_dst_rtype),
    .io_replay_bits_uop_lrs1_rtype      (_mshrs_4_io_replay_bits_uop_lrs1_rtype),
    .io_replay_bits_uop_lrs2_rtype      (_mshrs_4_io_replay_bits_uop_lrs2_rtype),
    .io_replay_bits_uop_frs3_en         (_mshrs_4_io_replay_bits_uop_frs3_en),
    .io_replay_bits_uop_fp_val          (_mshrs_4_io_replay_bits_uop_fp_val),
    .io_replay_bits_uop_fp_single       (_mshrs_4_io_replay_bits_uop_fp_single),
    .io_replay_bits_uop_xcpt_pf_if      (_mshrs_4_io_replay_bits_uop_xcpt_pf_if),
    .io_replay_bits_uop_xcpt_ae_if      (_mshrs_4_io_replay_bits_uop_xcpt_ae_if),
    .io_replay_bits_uop_xcpt_ma_if      (_mshrs_4_io_replay_bits_uop_xcpt_ma_if),
    .io_replay_bits_uop_bp_debug_if     (_mshrs_4_io_replay_bits_uop_bp_debug_if),
    .io_replay_bits_uop_bp_xcpt_if      (_mshrs_4_io_replay_bits_uop_bp_xcpt_if),
    .io_replay_bits_uop_debug_fsrc      (_mshrs_4_io_replay_bits_uop_debug_fsrc),
    .io_replay_bits_uop_debug_tsrc      (_mshrs_4_io_replay_bits_uop_debug_tsrc),
    .io_replay_bits_addr                (_mshrs_4_io_replay_bits_addr),
    .io_replay_bits_is_hella            (_mshrs_4_io_replay_bits_is_hella),
    .io_replay_bits_way_en              (_mshrs_4_io_replay_bits_way_en),
    .io_replay_bits_sdq_id              (_mshrs_4_io_replay_bits_sdq_id),
    .io_resp_valid                      (_mshrs_4_io_resp_valid),
    .io_resp_bits_uop_uopc              (_mshrs_4_io_resp_bits_uop_uopc),
    .io_resp_bits_uop_inst              (_mshrs_4_io_resp_bits_uop_inst),
    .io_resp_bits_uop_debug_inst        (_mshrs_4_io_resp_bits_uop_debug_inst),
    .io_resp_bits_uop_is_rvc            (_mshrs_4_io_resp_bits_uop_is_rvc),
    .io_resp_bits_uop_debug_pc          (_mshrs_4_io_resp_bits_uop_debug_pc),
    .io_resp_bits_uop_iq_type           (_mshrs_4_io_resp_bits_uop_iq_type),
    .io_resp_bits_uop_fu_code           (_mshrs_4_io_resp_bits_uop_fu_code),
    .io_resp_bits_uop_ctrl_br_type      (_mshrs_4_io_resp_bits_uop_ctrl_br_type),
    .io_resp_bits_uop_ctrl_op1_sel      (_mshrs_4_io_resp_bits_uop_ctrl_op1_sel),
    .io_resp_bits_uop_ctrl_op2_sel      (_mshrs_4_io_resp_bits_uop_ctrl_op2_sel),
    .io_resp_bits_uop_ctrl_imm_sel      (_mshrs_4_io_resp_bits_uop_ctrl_imm_sel),
    .io_resp_bits_uop_ctrl_op_fcn       (_mshrs_4_io_resp_bits_uop_ctrl_op_fcn),
    .io_resp_bits_uop_ctrl_fcn_dw       (_mshrs_4_io_resp_bits_uop_ctrl_fcn_dw),
    .io_resp_bits_uop_ctrl_csr_cmd      (_mshrs_4_io_resp_bits_uop_ctrl_csr_cmd),
    .io_resp_bits_uop_ctrl_is_load      (_mshrs_4_io_resp_bits_uop_ctrl_is_load),
    .io_resp_bits_uop_ctrl_is_sta       (_mshrs_4_io_resp_bits_uop_ctrl_is_sta),
    .io_resp_bits_uop_ctrl_is_std       (_mshrs_4_io_resp_bits_uop_ctrl_is_std),
    .io_resp_bits_uop_iw_state          (_mshrs_4_io_resp_bits_uop_iw_state),
    .io_resp_bits_uop_iw_p1_poisoned    (_mshrs_4_io_resp_bits_uop_iw_p1_poisoned),
    .io_resp_bits_uop_iw_p2_poisoned    (_mshrs_4_io_resp_bits_uop_iw_p2_poisoned),
    .io_resp_bits_uop_is_br             (_mshrs_4_io_resp_bits_uop_is_br),
    .io_resp_bits_uop_is_jalr           (_mshrs_4_io_resp_bits_uop_is_jalr),
    .io_resp_bits_uop_is_jal            (_mshrs_4_io_resp_bits_uop_is_jal),
    .io_resp_bits_uop_is_sfb            (_mshrs_4_io_resp_bits_uop_is_sfb),
    .io_resp_bits_uop_br_mask           (_mshrs_4_io_resp_bits_uop_br_mask),
    .io_resp_bits_uop_br_tag            (_mshrs_4_io_resp_bits_uop_br_tag),
    .io_resp_bits_uop_ftq_idx           (_mshrs_4_io_resp_bits_uop_ftq_idx),
    .io_resp_bits_uop_edge_inst         (_mshrs_4_io_resp_bits_uop_edge_inst),
    .io_resp_bits_uop_pc_lob            (_mshrs_4_io_resp_bits_uop_pc_lob),
    .io_resp_bits_uop_taken             (_mshrs_4_io_resp_bits_uop_taken),
    .io_resp_bits_uop_imm_packed        (_mshrs_4_io_resp_bits_uop_imm_packed),
    .io_resp_bits_uop_csr_addr          (_mshrs_4_io_resp_bits_uop_csr_addr),
    .io_resp_bits_uop_rob_idx           (_mshrs_4_io_resp_bits_uop_rob_idx),
    .io_resp_bits_uop_ldq_idx           (_mshrs_4_io_resp_bits_uop_ldq_idx),
    .io_resp_bits_uop_stq_idx           (_mshrs_4_io_resp_bits_uop_stq_idx),
    .io_resp_bits_uop_rxq_idx           (_mshrs_4_io_resp_bits_uop_rxq_idx),
    .io_resp_bits_uop_pdst              (_mshrs_4_io_resp_bits_uop_pdst),
    .io_resp_bits_uop_prs1              (_mshrs_4_io_resp_bits_uop_prs1),
    .io_resp_bits_uop_prs2              (_mshrs_4_io_resp_bits_uop_prs2),
    .io_resp_bits_uop_prs3              (_mshrs_4_io_resp_bits_uop_prs3),
    .io_resp_bits_uop_ppred             (_mshrs_4_io_resp_bits_uop_ppred),
    .io_resp_bits_uop_prs1_busy         (_mshrs_4_io_resp_bits_uop_prs1_busy),
    .io_resp_bits_uop_prs2_busy         (_mshrs_4_io_resp_bits_uop_prs2_busy),
    .io_resp_bits_uop_prs3_busy         (_mshrs_4_io_resp_bits_uop_prs3_busy),
    .io_resp_bits_uop_ppred_busy        (_mshrs_4_io_resp_bits_uop_ppred_busy),
    .io_resp_bits_uop_stale_pdst        (_mshrs_4_io_resp_bits_uop_stale_pdst),
    .io_resp_bits_uop_exception         (_mshrs_4_io_resp_bits_uop_exception),
    .io_resp_bits_uop_exc_cause         (_mshrs_4_io_resp_bits_uop_exc_cause),
    .io_resp_bits_uop_bypassable        (_mshrs_4_io_resp_bits_uop_bypassable),
    .io_resp_bits_uop_mem_cmd           (_mshrs_4_io_resp_bits_uop_mem_cmd),
    .io_resp_bits_uop_mem_size          (_mshrs_4_io_resp_bits_uop_mem_size),
    .io_resp_bits_uop_mem_signed        (_mshrs_4_io_resp_bits_uop_mem_signed),
    .io_resp_bits_uop_is_fence          (_mshrs_4_io_resp_bits_uop_is_fence),
    .io_resp_bits_uop_is_fencei         (_mshrs_4_io_resp_bits_uop_is_fencei),
    .io_resp_bits_uop_is_amo            (_mshrs_4_io_resp_bits_uop_is_amo),
    .io_resp_bits_uop_uses_ldq          (_mshrs_4_io_resp_bits_uop_uses_ldq),
    .io_resp_bits_uop_uses_stq          (_mshrs_4_io_resp_bits_uop_uses_stq),
    .io_resp_bits_uop_is_sys_pc2epc     (_mshrs_4_io_resp_bits_uop_is_sys_pc2epc),
    .io_resp_bits_uop_is_unique         (_mshrs_4_io_resp_bits_uop_is_unique),
    .io_resp_bits_uop_flush_on_commit   (_mshrs_4_io_resp_bits_uop_flush_on_commit),
    .io_resp_bits_uop_ldst_is_rs1       (_mshrs_4_io_resp_bits_uop_ldst_is_rs1),
    .io_resp_bits_uop_ldst              (_mshrs_4_io_resp_bits_uop_ldst),
    .io_resp_bits_uop_lrs1              (_mshrs_4_io_resp_bits_uop_lrs1),
    .io_resp_bits_uop_lrs2              (_mshrs_4_io_resp_bits_uop_lrs2),
    .io_resp_bits_uop_lrs3              (_mshrs_4_io_resp_bits_uop_lrs3),
    .io_resp_bits_uop_ldst_val          (_mshrs_4_io_resp_bits_uop_ldst_val),
    .io_resp_bits_uop_dst_rtype         (_mshrs_4_io_resp_bits_uop_dst_rtype),
    .io_resp_bits_uop_lrs1_rtype        (_mshrs_4_io_resp_bits_uop_lrs1_rtype),
    .io_resp_bits_uop_lrs2_rtype        (_mshrs_4_io_resp_bits_uop_lrs2_rtype),
    .io_resp_bits_uop_frs3_en           (_mshrs_4_io_resp_bits_uop_frs3_en),
    .io_resp_bits_uop_fp_val            (_mshrs_4_io_resp_bits_uop_fp_val),
    .io_resp_bits_uop_fp_single         (_mshrs_4_io_resp_bits_uop_fp_single),
    .io_resp_bits_uop_xcpt_pf_if        (_mshrs_4_io_resp_bits_uop_xcpt_pf_if),
    .io_resp_bits_uop_xcpt_ae_if        (_mshrs_4_io_resp_bits_uop_xcpt_ae_if),
    .io_resp_bits_uop_xcpt_ma_if        (_mshrs_4_io_resp_bits_uop_xcpt_ma_if),
    .io_resp_bits_uop_bp_debug_if       (_mshrs_4_io_resp_bits_uop_bp_debug_if),
    .io_resp_bits_uop_bp_xcpt_if        (_mshrs_4_io_resp_bits_uop_bp_xcpt_if),
    .io_resp_bits_uop_debug_fsrc        (_mshrs_4_io_resp_bits_uop_debug_fsrc),
    .io_resp_bits_uop_debug_tsrc        (_mshrs_4_io_resp_bits_uop_debug_tsrc),
    .io_resp_bits_data                  (_mshrs_4_io_resp_bits_data),
    .io_resp_bits_is_hella              (_mshrs_4_io_resp_bits_is_hella),
    .io_probe_rdy                       (_mshrs_4_io_probe_rdy)
  );
  BoomMSHR mshrs_5 (	// mshrs.scala:620:22
    .clock                              (clock),
    .reset                              (reset),
    .io_id                              (3'h5),	// Mux.scala:47:69
    .io_req_pri_val                     (mshr_alloc_idx_REG == 3'h5 & pri_val),	// Mux.scala:47:69, mshrs.scala:618:51, :632:{34,54}, :694:31
    .io_req_sec_val                     (_mshr_io_req_sec_val_T_23),	// mshrs.scala:637:99
    .io_clear_prefetch
      (io_clear_all & ~_GEN | _GEN & _GEN_92 & cacheable & ~_GEN_86 | io_req_is_probe_0
       & _GEN_92),	// Parameters.scala:137:31, :671:42, mshrs.scala:637:{50,72}, :644:{46,49}, :645:{58,61,82}, :646:21
    .io_brupdate_b1_resolve_mask        (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask     (io_brupdate_b1_mispredict_mask),
    .io_exception                       (io_exception),
    .io_req_uop_uopc                    (_GEN_0),	// Parameters.scala:137:31
    .io_req_uop_inst                    (_GEN_1),	// Parameters.scala:137:31
    .io_req_uop_debug_inst              (_GEN_2),	// Parameters.scala:137:31
    .io_req_uop_is_rvc                  (_GEN_3),	// Parameters.scala:137:31
    .io_req_uop_debug_pc                (_GEN_4),	// Parameters.scala:137:31
    .io_req_uop_iq_type                 (_GEN_5),	// Parameters.scala:137:31
    .io_req_uop_fu_code                 (_GEN_6),	// Parameters.scala:137:31
    .io_req_uop_ctrl_br_type            (_GEN_7),	// Parameters.scala:137:31
    .io_req_uop_ctrl_op1_sel            (_GEN_8),	// Parameters.scala:137:31
    .io_req_uop_ctrl_op2_sel            (_GEN_9),	// Parameters.scala:137:31
    .io_req_uop_ctrl_imm_sel            (_GEN_10),	// Parameters.scala:137:31
    .io_req_uop_ctrl_op_fcn             (_GEN_11),	// Parameters.scala:137:31
    .io_req_uop_ctrl_fcn_dw             (_GEN_12),	// Parameters.scala:137:31
    .io_req_uop_ctrl_csr_cmd            (_GEN_13),	// Parameters.scala:137:31
    .io_req_uop_ctrl_is_load            (_GEN_14),	// Parameters.scala:137:31
    .io_req_uop_ctrl_is_sta             (_GEN_15),	// Parameters.scala:137:31
    .io_req_uop_ctrl_is_std             (_GEN_16),	// Parameters.scala:137:31
    .io_req_uop_iw_state                (_GEN_17),	// Parameters.scala:137:31
    .io_req_uop_iw_p1_poisoned          (_GEN_18),	// Parameters.scala:137:31
    .io_req_uop_iw_p2_poisoned          (_GEN_19),	// Parameters.scala:137:31
    .io_req_uop_is_br                   (_GEN_20),	// Parameters.scala:137:31
    .io_req_uop_is_jalr                 (_GEN_21),	// Parameters.scala:137:31
    .io_req_uop_is_jal                  (_GEN_22),	// Parameters.scala:137:31
    .io_req_uop_is_sfb                  (_GEN_23),	// Parameters.scala:137:31
    .io_req_uop_br_mask                 (_GEN_24),	// Parameters.scala:137:31
    .io_req_uop_br_tag                  (_GEN_25),	// Parameters.scala:137:31
    .io_req_uop_ftq_idx                 (_GEN_26),	// Parameters.scala:137:31
    .io_req_uop_edge_inst               (_GEN_27),	// Parameters.scala:137:31
    .io_req_uop_pc_lob                  (_GEN_28),	// Parameters.scala:137:31
    .io_req_uop_taken                   (_GEN_29),	// Parameters.scala:137:31
    .io_req_uop_imm_packed              (_GEN_30),	// Parameters.scala:137:31
    .io_req_uop_csr_addr                (_GEN_31),	// Parameters.scala:137:31
    .io_req_uop_rob_idx                 (_GEN_32),	// Parameters.scala:137:31
    .io_req_uop_ldq_idx                 (_GEN_33),	// Parameters.scala:137:31
    .io_req_uop_stq_idx                 (_GEN_34),	// Parameters.scala:137:31
    .io_req_uop_rxq_idx                 (_GEN_35),	// Parameters.scala:137:31
    .io_req_uop_pdst                    (_GEN_36),	// Parameters.scala:137:31
    .io_req_uop_prs1                    (_GEN_37),	// Parameters.scala:137:31
    .io_req_uop_prs2                    (_GEN_38),	// Parameters.scala:137:31
    .io_req_uop_prs3                    (_GEN_39),	// Parameters.scala:137:31
    .io_req_uop_ppred                   (_GEN_40),	// Parameters.scala:137:31
    .io_req_uop_prs1_busy               (_GEN_41),	// Parameters.scala:137:31
    .io_req_uop_prs2_busy               (_GEN_42),	// Parameters.scala:137:31
    .io_req_uop_prs3_busy               (_GEN_43),	// Parameters.scala:137:31
    .io_req_uop_ppred_busy              (_GEN_44),	// Parameters.scala:137:31
    .io_req_uop_stale_pdst              (_GEN_45),	// Parameters.scala:137:31
    .io_req_uop_exception               (_GEN_46),	// Parameters.scala:137:31
    .io_req_uop_exc_cause               (_GEN_47),	// Parameters.scala:137:31
    .io_req_uop_bypassable              (_GEN_48),	// Parameters.scala:137:31
    .io_req_uop_mem_cmd                 (_GEN_49),	// Parameters.scala:137:31
    .io_req_uop_mem_size                (_GEN_50),	// Parameters.scala:137:31
    .io_req_uop_mem_signed              (_GEN_51),	// Parameters.scala:137:31
    .io_req_uop_is_fence                (_GEN_52),	// Parameters.scala:137:31
    .io_req_uop_is_fencei               (_GEN_53),	// Parameters.scala:137:31
    .io_req_uop_is_amo                  (_GEN_54),	// Parameters.scala:137:31
    .io_req_uop_uses_ldq                (_GEN_55),	// Parameters.scala:137:31
    .io_req_uop_uses_stq                (_GEN_56),	// Parameters.scala:137:31
    .io_req_uop_is_sys_pc2epc           (_GEN_57),	// Parameters.scala:137:31
    .io_req_uop_is_unique               (_GEN_58),	// Parameters.scala:137:31
    .io_req_uop_flush_on_commit         (_GEN_59),	// Parameters.scala:137:31
    .io_req_uop_ldst_is_rs1             (_GEN_60),	// Parameters.scala:137:31
    .io_req_uop_ldst                    (_GEN_61),	// Parameters.scala:137:31
    .io_req_uop_lrs1                    (_GEN_62),	// Parameters.scala:137:31
    .io_req_uop_lrs2                    (_GEN_63),	// Parameters.scala:137:31
    .io_req_uop_lrs3                    (_GEN_64),	// Parameters.scala:137:31
    .io_req_uop_ldst_val                (_GEN_65),	// Parameters.scala:137:31
    .io_req_uop_dst_rtype               (_GEN_66),	// Parameters.scala:137:31
    .io_req_uop_lrs1_rtype              (_GEN_67),	// Parameters.scala:137:31
    .io_req_uop_lrs2_rtype              (_GEN_68),	// Parameters.scala:137:31
    .io_req_uop_frs3_en                 (_GEN_69),	// Parameters.scala:137:31
    .io_req_uop_fp_val                  (_GEN_70),	// Parameters.scala:137:31
    .io_req_uop_fp_single               (_GEN_71),	// Parameters.scala:137:31
    .io_req_uop_xcpt_pf_if              (_GEN_72),	// Parameters.scala:137:31
    .io_req_uop_xcpt_ae_if              (_GEN_73),	// Parameters.scala:137:31
    .io_req_uop_xcpt_ma_if              (_GEN_74),	// Parameters.scala:137:31
    .io_req_uop_bp_debug_if             (_GEN_75),	// Parameters.scala:137:31
    .io_req_uop_bp_xcpt_if              (_GEN_76),	// Parameters.scala:137:31
    .io_req_uop_debug_fsrc              (_GEN_77),	// Parameters.scala:137:31
    .io_req_uop_debug_tsrc              (_GEN_78),	// Parameters.scala:137:31
    .io_req_addr                        (_cacheable_T_1),	// Parameters.scala:137:31
    .io_req_data                        (_GEN_79),	// Parameters.scala:137:31
    .io_req_is_hella                    (_GEN_80),	// Parameters.scala:137:31
    .io_req_tag_match                   (_GEN_81),	// Parameters.scala:137:31
    .io_req_old_meta_coh_state          (_GEN_82),	// Parameters.scala:137:31
    .io_req_old_meta_tag                (_GEN_83),	// Parameters.scala:137:31
    .io_req_way_en                      (_GEN_84),	// Parameters.scala:137:31
    .io_req_sdq_id                      (sdq_alloc_id),	// Mux.scala:47:69
    .io_req_is_probe                    (io_req_is_probe_0),
    .io_mem_acquire_ready
      (io_mem_acquire_ready & (idle ? ~_GEN_114 : state_5)),	// Arbiter.scala:16:61, :88:28, :116:26, :121:24, :123:31, package.scala:244:43
    .io_mem_grant_valid                 (_GEN_100 & io_mem_grant_valid),	// mshrs.scala:671:29, :673:{36,45}, :674:25
    .io_mem_grant_bits_opcode           (io_mem_grant_bits_opcode),
    .io_mem_grant_bits_param            (io_mem_grant_bits_param),
    .io_mem_grant_bits_size             (io_mem_grant_bits_size),
    .io_mem_grant_bits_sink             (io_mem_grant_bits_sink),
    .io_mem_grant_bits_data             (io_mem_grant_bits_data),
    .io_mem_finish_ready
      (io_mem_finish_ready & (beatsLeft_1 ? state_1_5 : ~_GEN_124)),	// Arbiter.scala:16:61, :87:30, :116:26, :121:24, :123:31, package.scala:244:43
    .io_prober_state_valid              (io_prober_state_valid),
    .io_prober_state_bits               (io_prober_state_bits),
    .io_refill_ready                    (_refill_arb_io_in_5_ready),	// mshrs.scala:604:30
    .io_meta_write_ready                (_meta_write_arb_io_in_5_ready),	// mshrs.scala:599:30
    .io_meta_read_ready                 (_meta_read_arb_io_in_5_ready),	// mshrs.scala:600:30
    .io_meta_resp_valid                 (io_meta_resp_valid),
    .io_meta_resp_bits_coh_state        (io_meta_resp_bits_coh_state),
    .io_wb_req_ready                    (_wb_req_arb_io_in_5_ready),	// mshrs.scala:601:30
    .io_lb_read_ready                   (_lb_read_arb_io_in_5_ready),	// mshrs.scala:569:28
    .io_lb_resp                         (lb_read_data),	// mshrs.scala:576:37, :580:38
    .io_lb_write_ready                  (_lb_write_arb_io_in_5_ready),	// mshrs.scala:570:28
    .io_replay_ready                    (_replay_arb_io_in_5_ready),	// mshrs.scala:602:30
    .io_resp_ready                      (_resp_arb_io_in_5_ready),	// mshrs.scala:603:30
    .io_wb_resp                         (io_wb_resp),
    .io_req_pri_rdy                     (_mshrs_5_io_req_pri_rdy),
    .io_req_sec_rdy                     (_mshrs_5_io_req_sec_rdy),
    .io_idx_valid                       (_mshrs_5_io_idx_valid),
    .io_idx_bits                        (_mshrs_5_io_idx_bits),
    .io_way_valid                       (_mshrs_5_io_way_valid),
    .io_way_bits                        (_mshrs_5_io_way_bits),
    .io_tag_valid                       (_mshrs_5_io_tag_valid),
    .io_tag_bits                        (_mshrs_5_io_tag_bits),
    .io_mem_acquire_valid               (_mshrs_5_io_mem_acquire_valid),
    .io_mem_acquire_bits_param          (_mshrs_5_io_mem_acquire_bits_param),
    .io_mem_acquire_bits_source         (_mshrs_5_io_mem_acquire_bits_source),
    .io_mem_acquire_bits_address        (_mshrs_5_io_mem_acquire_bits_address),
    .io_mem_grant_ready                 (_mshrs_5_io_mem_grant_ready),
    .io_mem_finish_valid                (_mshrs_5_io_mem_finish_valid),
    .io_mem_finish_bits_sink            (_mshrs_5_io_mem_finish_bits_sink),
    .io_refill_valid                    (_mshrs_5_io_refill_valid),
    .io_refill_bits_way_en              (_mshrs_5_io_refill_bits_way_en),
    .io_refill_bits_addr                (_mshrs_5_io_refill_bits_addr),
    .io_refill_bits_data                (_mshrs_5_io_refill_bits_data),
    .io_meta_write_valid                (_mshrs_5_io_meta_write_valid),
    .io_meta_write_bits_idx             (_mshrs_5_io_meta_write_bits_idx),
    .io_meta_write_bits_way_en          (_mshrs_5_io_meta_write_bits_way_en),
    .io_meta_write_bits_data_coh_state  (_mshrs_5_io_meta_write_bits_data_coh_state),
    .io_meta_write_bits_data_tag        (_mshrs_5_io_meta_write_bits_data_tag),
    .io_meta_read_valid                 (_mshrs_5_io_meta_read_valid),
    .io_meta_read_bits_idx              (_mshrs_5_io_meta_read_bits_idx),
    .io_meta_read_bits_way_en           (_mshrs_5_io_meta_read_bits_way_en),
    .io_meta_read_bits_tag              (_mshrs_5_io_meta_read_bits_tag),
    .io_wb_req_valid                    (_mshrs_5_io_wb_req_valid),
    .io_wb_req_bits_tag                 (_mshrs_5_io_wb_req_bits_tag),
    .io_wb_req_bits_idx                 (_mshrs_5_io_wb_req_bits_idx),
    .io_wb_req_bits_param               (_mshrs_5_io_wb_req_bits_param),
    .io_wb_req_bits_way_en              (_mshrs_5_io_wb_req_bits_way_en),
    .io_commit_val                      (_mshrs_5_io_commit_val),
    .io_commit_addr                     (_mshrs_5_io_commit_addr),
    .io_commit_coh_state                (_mshrs_5_io_commit_coh_state),
    .io_lb_read_valid                   (_mshrs_5_io_lb_read_valid),
    .io_lb_read_bits_id                 (_mshrs_5_io_lb_read_bits_id),
    .io_lb_read_bits_offset             (_mshrs_5_io_lb_read_bits_offset),
    .io_lb_write_valid                  (_mshrs_5_io_lb_write_valid),
    .io_lb_write_bits_id                (_mshrs_5_io_lb_write_bits_id),
    .io_lb_write_bits_offset            (_mshrs_5_io_lb_write_bits_offset),
    .io_lb_write_bits_data              (_mshrs_5_io_lb_write_bits_data),
    .io_replay_valid                    (_mshrs_5_io_replay_valid),
    .io_replay_bits_uop_uopc            (_mshrs_5_io_replay_bits_uop_uopc),
    .io_replay_bits_uop_inst            (_mshrs_5_io_replay_bits_uop_inst),
    .io_replay_bits_uop_debug_inst      (_mshrs_5_io_replay_bits_uop_debug_inst),
    .io_replay_bits_uop_is_rvc          (_mshrs_5_io_replay_bits_uop_is_rvc),
    .io_replay_bits_uop_debug_pc        (_mshrs_5_io_replay_bits_uop_debug_pc),
    .io_replay_bits_uop_iq_type         (_mshrs_5_io_replay_bits_uop_iq_type),
    .io_replay_bits_uop_fu_code         (_mshrs_5_io_replay_bits_uop_fu_code),
    .io_replay_bits_uop_ctrl_br_type    (_mshrs_5_io_replay_bits_uop_ctrl_br_type),
    .io_replay_bits_uop_ctrl_op1_sel    (_mshrs_5_io_replay_bits_uop_ctrl_op1_sel),
    .io_replay_bits_uop_ctrl_op2_sel    (_mshrs_5_io_replay_bits_uop_ctrl_op2_sel),
    .io_replay_bits_uop_ctrl_imm_sel    (_mshrs_5_io_replay_bits_uop_ctrl_imm_sel),
    .io_replay_bits_uop_ctrl_op_fcn     (_mshrs_5_io_replay_bits_uop_ctrl_op_fcn),
    .io_replay_bits_uop_ctrl_fcn_dw     (_mshrs_5_io_replay_bits_uop_ctrl_fcn_dw),
    .io_replay_bits_uop_ctrl_csr_cmd    (_mshrs_5_io_replay_bits_uop_ctrl_csr_cmd),
    .io_replay_bits_uop_ctrl_is_load    (_mshrs_5_io_replay_bits_uop_ctrl_is_load),
    .io_replay_bits_uop_ctrl_is_sta     (_mshrs_5_io_replay_bits_uop_ctrl_is_sta),
    .io_replay_bits_uop_ctrl_is_std     (_mshrs_5_io_replay_bits_uop_ctrl_is_std),
    .io_replay_bits_uop_iw_state        (_mshrs_5_io_replay_bits_uop_iw_state),
    .io_replay_bits_uop_iw_p1_poisoned  (_mshrs_5_io_replay_bits_uop_iw_p1_poisoned),
    .io_replay_bits_uop_iw_p2_poisoned  (_mshrs_5_io_replay_bits_uop_iw_p2_poisoned),
    .io_replay_bits_uop_is_br           (_mshrs_5_io_replay_bits_uop_is_br),
    .io_replay_bits_uop_is_jalr         (_mshrs_5_io_replay_bits_uop_is_jalr),
    .io_replay_bits_uop_is_jal          (_mshrs_5_io_replay_bits_uop_is_jal),
    .io_replay_bits_uop_is_sfb          (_mshrs_5_io_replay_bits_uop_is_sfb),
    .io_replay_bits_uop_br_mask         (_mshrs_5_io_replay_bits_uop_br_mask),
    .io_replay_bits_uop_br_tag          (_mshrs_5_io_replay_bits_uop_br_tag),
    .io_replay_bits_uop_ftq_idx         (_mshrs_5_io_replay_bits_uop_ftq_idx),
    .io_replay_bits_uop_edge_inst       (_mshrs_5_io_replay_bits_uop_edge_inst),
    .io_replay_bits_uop_pc_lob          (_mshrs_5_io_replay_bits_uop_pc_lob),
    .io_replay_bits_uop_taken           (_mshrs_5_io_replay_bits_uop_taken),
    .io_replay_bits_uop_imm_packed      (_mshrs_5_io_replay_bits_uop_imm_packed),
    .io_replay_bits_uop_csr_addr        (_mshrs_5_io_replay_bits_uop_csr_addr),
    .io_replay_bits_uop_rob_idx         (_mshrs_5_io_replay_bits_uop_rob_idx),
    .io_replay_bits_uop_ldq_idx         (_mshrs_5_io_replay_bits_uop_ldq_idx),
    .io_replay_bits_uop_stq_idx         (_mshrs_5_io_replay_bits_uop_stq_idx),
    .io_replay_bits_uop_rxq_idx         (_mshrs_5_io_replay_bits_uop_rxq_idx),
    .io_replay_bits_uop_pdst            (_mshrs_5_io_replay_bits_uop_pdst),
    .io_replay_bits_uop_prs1            (_mshrs_5_io_replay_bits_uop_prs1),
    .io_replay_bits_uop_prs2            (_mshrs_5_io_replay_bits_uop_prs2),
    .io_replay_bits_uop_prs3            (_mshrs_5_io_replay_bits_uop_prs3),
    .io_replay_bits_uop_ppred           (_mshrs_5_io_replay_bits_uop_ppred),
    .io_replay_bits_uop_prs1_busy       (_mshrs_5_io_replay_bits_uop_prs1_busy),
    .io_replay_bits_uop_prs2_busy       (_mshrs_5_io_replay_bits_uop_prs2_busy),
    .io_replay_bits_uop_prs3_busy       (_mshrs_5_io_replay_bits_uop_prs3_busy),
    .io_replay_bits_uop_ppred_busy      (_mshrs_5_io_replay_bits_uop_ppred_busy),
    .io_replay_bits_uop_stale_pdst      (_mshrs_5_io_replay_bits_uop_stale_pdst),
    .io_replay_bits_uop_exception       (_mshrs_5_io_replay_bits_uop_exception),
    .io_replay_bits_uop_exc_cause       (_mshrs_5_io_replay_bits_uop_exc_cause),
    .io_replay_bits_uop_bypassable      (_mshrs_5_io_replay_bits_uop_bypassable),
    .io_replay_bits_uop_mem_cmd         (_mshrs_5_io_replay_bits_uop_mem_cmd),
    .io_replay_bits_uop_mem_size        (_mshrs_5_io_replay_bits_uop_mem_size),
    .io_replay_bits_uop_mem_signed      (_mshrs_5_io_replay_bits_uop_mem_signed),
    .io_replay_bits_uop_is_fence        (_mshrs_5_io_replay_bits_uop_is_fence),
    .io_replay_bits_uop_is_fencei       (_mshrs_5_io_replay_bits_uop_is_fencei),
    .io_replay_bits_uop_is_amo          (_mshrs_5_io_replay_bits_uop_is_amo),
    .io_replay_bits_uop_uses_ldq        (_mshrs_5_io_replay_bits_uop_uses_ldq),
    .io_replay_bits_uop_uses_stq        (_mshrs_5_io_replay_bits_uop_uses_stq),
    .io_replay_bits_uop_is_sys_pc2epc   (_mshrs_5_io_replay_bits_uop_is_sys_pc2epc),
    .io_replay_bits_uop_is_unique       (_mshrs_5_io_replay_bits_uop_is_unique),
    .io_replay_bits_uop_flush_on_commit (_mshrs_5_io_replay_bits_uop_flush_on_commit),
    .io_replay_bits_uop_ldst_is_rs1     (_mshrs_5_io_replay_bits_uop_ldst_is_rs1),
    .io_replay_bits_uop_ldst            (_mshrs_5_io_replay_bits_uop_ldst),
    .io_replay_bits_uop_lrs1            (_mshrs_5_io_replay_bits_uop_lrs1),
    .io_replay_bits_uop_lrs2            (_mshrs_5_io_replay_bits_uop_lrs2),
    .io_replay_bits_uop_lrs3            (_mshrs_5_io_replay_bits_uop_lrs3),
    .io_replay_bits_uop_ldst_val        (_mshrs_5_io_replay_bits_uop_ldst_val),
    .io_replay_bits_uop_dst_rtype       (_mshrs_5_io_replay_bits_uop_dst_rtype),
    .io_replay_bits_uop_lrs1_rtype      (_mshrs_5_io_replay_bits_uop_lrs1_rtype),
    .io_replay_bits_uop_lrs2_rtype      (_mshrs_5_io_replay_bits_uop_lrs2_rtype),
    .io_replay_bits_uop_frs3_en         (_mshrs_5_io_replay_bits_uop_frs3_en),
    .io_replay_bits_uop_fp_val          (_mshrs_5_io_replay_bits_uop_fp_val),
    .io_replay_bits_uop_fp_single       (_mshrs_5_io_replay_bits_uop_fp_single),
    .io_replay_bits_uop_xcpt_pf_if      (_mshrs_5_io_replay_bits_uop_xcpt_pf_if),
    .io_replay_bits_uop_xcpt_ae_if      (_mshrs_5_io_replay_bits_uop_xcpt_ae_if),
    .io_replay_bits_uop_xcpt_ma_if      (_mshrs_5_io_replay_bits_uop_xcpt_ma_if),
    .io_replay_bits_uop_bp_debug_if     (_mshrs_5_io_replay_bits_uop_bp_debug_if),
    .io_replay_bits_uop_bp_xcpt_if      (_mshrs_5_io_replay_bits_uop_bp_xcpt_if),
    .io_replay_bits_uop_debug_fsrc      (_mshrs_5_io_replay_bits_uop_debug_fsrc),
    .io_replay_bits_uop_debug_tsrc      (_mshrs_5_io_replay_bits_uop_debug_tsrc),
    .io_replay_bits_addr                (_mshrs_5_io_replay_bits_addr),
    .io_replay_bits_is_hella            (_mshrs_5_io_replay_bits_is_hella),
    .io_replay_bits_way_en              (_mshrs_5_io_replay_bits_way_en),
    .io_replay_bits_sdq_id              (_mshrs_5_io_replay_bits_sdq_id),
    .io_resp_valid                      (_mshrs_5_io_resp_valid),
    .io_resp_bits_uop_uopc              (_mshrs_5_io_resp_bits_uop_uopc),
    .io_resp_bits_uop_inst              (_mshrs_5_io_resp_bits_uop_inst),
    .io_resp_bits_uop_debug_inst        (_mshrs_5_io_resp_bits_uop_debug_inst),
    .io_resp_bits_uop_is_rvc            (_mshrs_5_io_resp_bits_uop_is_rvc),
    .io_resp_bits_uop_debug_pc          (_mshrs_5_io_resp_bits_uop_debug_pc),
    .io_resp_bits_uop_iq_type           (_mshrs_5_io_resp_bits_uop_iq_type),
    .io_resp_bits_uop_fu_code           (_mshrs_5_io_resp_bits_uop_fu_code),
    .io_resp_bits_uop_ctrl_br_type      (_mshrs_5_io_resp_bits_uop_ctrl_br_type),
    .io_resp_bits_uop_ctrl_op1_sel      (_mshrs_5_io_resp_bits_uop_ctrl_op1_sel),
    .io_resp_bits_uop_ctrl_op2_sel      (_mshrs_5_io_resp_bits_uop_ctrl_op2_sel),
    .io_resp_bits_uop_ctrl_imm_sel      (_mshrs_5_io_resp_bits_uop_ctrl_imm_sel),
    .io_resp_bits_uop_ctrl_op_fcn       (_mshrs_5_io_resp_bits_uop_ctrl_op_fcn),
    .io_resp_bits_uop_ctrl_fcn_dw       (_mshrs_5_io_resp_bits_uop_ctrl_fcn_dw),
    .io_resp_bits_uop_ctrl_csr_cmd      (_mshrs_5_io_resp_bits_uop_ctrl_csr_cmd),
    .io_resp_bits_uop_ctrl_is_load      (_mshrs_5_io_resp_bits_uop_ctrl_is_load),
    .io_resp_bits_uop_ctrl_is_sta       (_mshrs_5_io_resp_bits_uop_ctrl_is_sta),
    .io_resp_bits_uop_ctrl_is_std       (_mshrs_5_io_resp_bits_uop_ctrl_is_std),
    .io_resp_bits_uop_iw_state          (_mshrs_5_io_resp_bits_uop_iw_state),
    .io_resp_bits_uop_iw_p1_poisoned    (_mshrs_5_io_resp_bits_uop_iw_p1_poisoned),
    .io_resp_bits_uop_iw_p2_poisoned    (_mshrs_5_io_resp_bits_uop_iw_p2_poisoned),
    .io_resp_bits_uop_is_br             (_mshrs_5_io_resp_bits_uop_is_br),
    .io_resp_bits_uop_is_jalr           (_mshrs_5_io_resp_bits_uop_is_jalr),
    .io_resp_bits_uop_is_jal            (_mshrs_5_io_resp_bits_uop_is_jal),
    .io_resp_bits_uop_is_sfb            (_mshrs_5_io_resp_bits_uop_is_sfb),
    .io_resp_bits_uop_br_mask           (_mshrs_5_io_resp_bits_uop_br_mask),
    .io_resp_bits_uop_br_tag            (_mshrs_5_io_resp_bits_uop_br_tag),
    .io_resp_bits_uop_ftq_idx           (_mshrs_5_io_resp_bits_uop_ftq_idx),
    .io_resp_bits_uop_edge_inst         (_mshrs_5_io_resp_bits_uop_edge_inst),
    .io_resp_bits_uop_pc_lob            (_mshrs_5_io_resp_bits_uop_pc_lob),
    .io_resp_bits_uop_taken             (_mshrs_5_io_resp_bits_uop_taken),
    .io_resp_bits_uop_imm_packed        (_mshrs_5_io_resp_bits_uop_imm_packed),
    .io_resp_bits_uop_csr_addr          (_mshrs_5_io_resp_bits_uop_csr_addr),
    .io_resp_bits_uop_rob_idx           (_mshrs_5_io_resp_bits_uop_rob_idx),
    .io_resp_bits_uop_ldq_idx           (_mshrs_5_io_resp_bits_uop_ldq_idx),
    .io_resp_bits_uop_stq_idx           (_mshrs_5_io_resp_bits_uop_stq_idx),
    .io_resp_bits_uop_rxq_idx           (_mshrs_5_io_resp_bits_uop_rxq_idx),
    .io_resp_bits_uop_pdst              (_mshrs_5_io_resp_bits_uop_pdst),
    .io_resp_bits_uop_prs1              (_mshrs_5_io_resp_bits_uop_prs1),
    .io_resp_bits_uop_prs2              (_mshrs_5_io_resp_bits_uop_prs2),
    .io_resp_bits_uop_prs3              (_mshrs_5_io_resp_bits_uop_prs3),
    .io_resp_bits_uop_ppred             (_mshrs_5_io_resp_bits_uop_ppred),
    .io_resp_bits_uop_prs1_busy         (_mshrs_5_io_resp_bits_uop_prs1_busy),
    .io_resp_bits_uop_prs2_busy         (_mshrs_5_io_resp_bits_uop_prs2_busy),
    .io_resp_bits_uop_prs3_busy         (_mshrs_5_io_resp_bits_uop_prs3_busy),
    .io_resp_bits_uop_ppred_busy        (_mshrs_5_io_resp_bits_uop_ppred_busy),
    .io_resp_bits_uop_stale_pdst        (_mshrs_5_io_resp_bits_uop_stale_pdst),
    .io_resp_bits_uop_exception         (_mshrs_5_io_resp_bits_uop_exception),
    .io_resp_bits_uop_exc_cause         (_mshrs_5_io_resp_bits_uop_exc_cause),
    .io_resp_bits_uop_bypassable        (_mshrs_5_io_resp_bits_uop_bypassable),
    .io_resp_bits_uop_mem_cmd           (_mshrs_5_io_resp_bits_uop_mem_cmd),
    .io_resp_bits_uop_mem_size          (_mshrs_5_io_resp_bits_uop_mem_size),
    .io_resp_bits_uop_mem_signed        (_mshrs_5_io_resp_bits_uop_mem_signed),
    .io_resp_bits_uop_is_fence          (_mshrs_5_io_resp_bits_uop_is_fence),
    .io_resp_bits_uop_is_fencei         (_mshrs_5_io_resp_bits_uop_is_fencei),
    .io_resp_bits_uop_is_amo            (_mshrs_5_io_resp_bits_uop_is_amo),
    .io_resp_bits_uop_uses_ldq          (_mshrs_5_io_resp_bits_uop_uses_ldq),
    .io_resp_bits_uop_uses_stq          (_mshrs_5_io_resp_bits_uop_uses_stq),
    .io_resp_bits_uop_is_sys_pc2epc     (_mshrs_5_io_resp_bits_uop_is_sys_pc2epc),
    .io_resp_bits_uop_is_unique         (_mshrs_5_io_resp_bits_uop_is_unique),
    .io_resp_bits_uop_flush_on_commit   (_mshrs_5_io_resp_bits_uop_flush_on_commit),
    .io_resp_bits_uop_ldst_is_rs1       (_mshrs_5_io_resp_bits_uop_ldst_is_rs1),
    .io_resp_bits_uop_ldst              (_mshrs_5_io_resp_bits_uop_ldst),
    .io_resp_bits_uop_lrs1              (_mshrs_5_io_resp_bits_uop_lrs1),
    .io_resp_bits_uop_lrs2              (_mshrs_5_io_resp_bits_uop_lrs2),
    .io_resp_bits_uop_lrs3              (_mshrs_5_io_resp_bits_uop_lrs3),
    .io_resp_bits_uop_ldst_val          (_mshrs_5_io_resp_bits_uop_ldst_val),
    .io_resp_bits_uop_dst_rtype         (_mshrs_5_io_resp_bits_uop_dst_rtype),
    .io_resp_bits_uop_lrs1_rtype        (_mshrs_5_io_resp_bits_uop_lrs1_rtype),
    .io_resp_bits_uop_lrs2_rtype        (_mshrs_5_io_resp_bits_uop_lrs2_rtype),
    .io_resp_bits_uop_frs3_en           (_mshrs_5_io_resp_bits_uop_frs3_en),
    .io_resp_bits_uop_fp_val            (_mshrs_5_io_resp_bits_uop_fp_val),
    .io_resp_bits_uop_fp_single         (_mshrs_5_io_resp_bits_uop_fp_single),
    .io_resp_bits_uop_xcpt_pf_if        (_mshrs_5_io_resp_bits_uop_xcpt_pf_if),
    .io_resp_bits_uop_xcpt_ae_if        (_mshrs_5_io_resp_bits_uop_xcpt_ae_if),
    .io_resp_bits_uop_xcpt_ma_if        (_mshrs_5_io_resp_bits_uop_xcpt_ma_if),
    .io_resp_bits_uop_bp_debug_if       (_mshrs_5_io_resp_bits_uop_bp_debug_if),
    .io_resp_bits_uop_bp_xcpt_if        (_mshrs_5_io_resp_bits_uop_bp_xcpt_if),
    .io_resp_bits_uop_debug_fsrc        (_mshrs_5_io_resp_bits_uop_debug_fsrc),
    .io_resp_bits_uop_debug_tsrc        (_mshrs_5_io_resp_bits_uop_debug_tsrc),
    .io_resp_bits_data                  (_mshrs_5_io_resp_bits_data),
    .io_resp_bits_is_hella              (_mshrs_5_io_resp_bits_is_hella),
    .io_probe_rdy                       (_mshrs_5_io_probe_rdy)
  );
  BoomMSHR mshrs_6 (	// mshrs.scala:620:22
    .clock                              (clock),
    .reset                              (reset),
    .io_id                              (3'h6),	// ReadyValidCancel.scala:70:19, mshrs.scala:620:22
    .io_req_pri_val                     (mshr_alloc_idx_REG == 3'h6 & pri_val),	// ReadyValidCancel.scala:70:19, mshrs.scala:618:51, :620:22, :632:{34,54}, :694:31
    .io_req_sec_val                     (_mshr_io_req_sec_val_T_27),	// mshrs.scala:637:99
    .io_clear_prefetch
      (io_clear_all & ~_GEN | _GEN & _GEN_93 & cacheable & ~_GEN_86 | io_req_is_probe_0
       & _GEN_93),	// Parameters.scala:137:31, :671:42, mshrs.scala:637:{50,72}, :644:{46,49}, :645:{58,61,82}, :646:21
    .io_brupdate_b1_resolve_mask        (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask     (io_brupdate_b1_mispredict_mask),
    .io_exception                       (io_exception),
    .io_req_uop_uopc                    (_GEN_0),	// Parameters.scala:137:31
    .io_req_uop_inst                    (_GEN_1),	// Parameters.scala:137:31
    .io_req_uop_debug_inst              (_GEN_2),	// Parameters.scala:137:31
    .io_req_uop_is_rvc                  (_GEN_3),	// Parameters.scala:137:31
    .io_req_uop_debug_pc                (_GEN_4),	// Parameters.scala:137:31
    .io_req_uop_iq_type                 (_GEN_5),	// Parameters.scala:137:31
    .io_req_uop_fu_code                 (_GEN_6),	// Parameters.scala:137:31
    .io_req_uop_ctrl_br_type            (_GEN_7),	// Parameters.scala:137:31
    .io_req_uop_ctrl_op1_sel            (_GEN_8),	// Parameters.scala:137:31
    .io_req_uop_ctrl_op2_sel            (_GEN_9),	// Parameters.scala:137:31
    .io_req_uop_ctrl_imm_sel            (_GEN_10),	// Parameters.scala:137:31
    .io_req_uop_ctrl_op_fcn             (_GEN_11),	// Parameters.scala:137:31
    .io_req_uop_ctrl_fcn_dw             (_GEN_12),	// Parameters.scala:137:31
    .io_req_uop_ctrl_csr_cmd            (_GEN_13),	// Parameters.scala:137:31
    .io_req_uop_ctrl_is_load            (_GEN_14),	// Parameters.scala:137:31
    .io_req_uop_ctrl_is_sta             (_GEN_15),	// Parameters.scala:137:31
    .io_req_uop_ctrl_is_std             (_GEN_16),	// Parameters.scala:137:31
    .io_req_uop_iw_state                (_GEN_17),	// Parameters.scala:137:31
    .io_req_uop_iw_p1_poisoned          (_GEN_18),	// Parameters.scala:137:31
    .io_req_uop_iw_p2_poisoned          (_GEN_19),	// Parameters.scala:137:31
    .io_req_uop_is_br                   (_GEN_20),	// Parameters.scala:137:31
    .io_req_uop_is_jalr                 (_GEN_21),	// Parameters.scala:137:31
    .io_req_uop_is_jal                  (_GEN_22),	// Parameters.scala:137:31
    .io_req_uop_is_sfb                  (_GEN_23),	// Parameters.scala:137:31
    .io_req_uop_br_mask                 (_GEN_24),	// Parameters.scala:137:31
    .io_req_uop_br_tag                  (_GEN_25),	// Parameters.scala:137:31
    .io_req_uop_ftq_idx                 (_GEN_26),	// Parameters.scala:137:31
    .io_req_uop_edge_inst               (_GEN_27),	// Parameters.scala:137:31
    .io_req_uop_pc_lob                  (_GEN_28),	// Parameters.scala:137:31
    .io_req_uop_taken                   (_GEN_29),	// Parameters.scala:137:31
    .io_req_uop_imm_packed              (_GEN_30),	// Parameters.scala:137:31
    .io_req_uop_csr_addr                (_GEN_31),	// Parameters.scala:137:31
    .io_req_uop_rob_idx                 (_GEN_32),	// Parameters.scala:137:31
    .io_req_uop_ldq_idx                 (_GEN_33),	// Parameters.scala:137:31
    .io_req_uop_stq_idx                 (_GEN_34),	// Parameters.scala:137:31
    .io_req_uop_rxq_idx                 (_GEN_35),	// Parameters.scala:137:31
    .io_req_uop_pdst                    (_GEN_36),	// Parameters.scala:137:31
    .io_req_uop_prs1                    (_GEN_37),	// Parameters.scala:137:31
    .io_req_uop_prs2                    (_GEN_38),	// Parameters.scala:137:31
    .io_req_uop_prs3                    (_GEN_39),	// Parameters.scala:137:31
    .io_req_uop_ppred                   (_GEN_40),	// Parameters.scala:137:31
    .io_req_uop_prs1_busy               (_GEN_41),	// Parameters.scala:137:31
    .io_req_uop_prs2_busy               (_GEN_42),	// Parameters.scala:137:31
    .io_req_uop_prs3_busy               (_GEN_43),	// Parameters.scala:137:31
    .io_req_uop_ppred_busy              (_GEN_44),	// Parameters.scala:137:31
    .io_req_uop_stale_pdst              (_GEN_45),	// Parameters.scala:137:31
    .io_req_uop_exception               (_GEN_46),	// Parameters.scala:137:31
    .io_req_uop_exc_cause               (_GEN_47),	// Parameters.scala:137:31
    .io_req_uop_bypassable              (_GEN_48),	// Parameters.scala:137:31
    .io_req_uop_mem_cmd                 (_GEN_49),	// Parameters.scala:137:31
    .io_req_uop_mem_size                (_GEN_50),	// Parameters.scala:137:31
    .io_req_uop_mem_signed              (_GEN_51),	// Parameters.scala:137:31
    .io_req_uop_is_fence                (_GEN_52),	// Parameters.scala:137:31
    .io_req_uop_is_fencei               (_GEN_53),	// Parameters.scala:137:31
    .io_req_uop_is_amo                  (_GEN_54),	// Parameters.scala:137:31
    .io_req_uop_uses_ldq                (_GEN_55),	// Parameters.scala:137:31
    .io_req_uop_uses_stq                (_GEN_56),	// Parameters.scala:137:31
    .io_req_uop_is_sys_pc2epc           (_GEN_57),	// Parameters.scala:137:31
    .io_req_uop_is_unique               (_GEN_58),	// Parameters.scala:137:31
    .io_req_uop_flush_on_commit         (_GEN_59),	// Parameters.scala:137:31
    .io_req_uop_ldst_is_rs1             (_GEN_60),	// Parameters.scala:137:31
    .io_req_uop_ldst                    (_GEN_61),	// Parameters.scala:137:31
    .io_req_uop_lrs1                    (_GEN_62),	// Parameters.scala:137:31
    .io_req_uop_lrs2                    (_GEN_63),	// Parameters.scala:137:31
    .io_req_uop_lrs3                    (_GEN_64),	// Parameters.scala:137:31
    .io_req_uop_ldst_val                (_GEN_65),	// Parameters.scala:137:31
    .io_req_uop_dst_rtype               (_GEN_66),	// Parameters.scala:137:31
    .io_req_uop_lrs1_rtype              (_GEN_67),	// Parameters.scala:137:31
    .io_req_uop_lrs2_rtype              (_GEN_68),	// Parameters.scala:137:31
    .io_req_uop_frs3_en                 (_GEN_69),	// Parameters.scala:137:31
    .io_req_uop_fp_val                  (_GEN_70),	// Parameters.scala:137:31
    .io_req_uop_fp_single               (_GEN_71),	// Parameters.scala:137:31
    .io_req_uop_xcpt_pf_if              (_GEN_72),	// Parameters.scala:137:31
    .io_req_uop_xcpt_ae_if              (_GEN_73),	// Parameters.scala:137:31
    .io_req_uop_xcpt_ma_if              (_GEN_74),	// Parameters.scala:137:31
    .io_req_uop_bp_debug_if             (_GEN_75),	// Parameters.scala:137:31
    .io_req_uop_bp_xcpt_if              (_GEN_76),	// Parameters.scala:137:31
    .io_req_uop_debug_fsrc              (_GEN_77),	// Parameters.scala:137:31
    .io_req_uop_debug_tsrc              (_GEN_78),	// Parameters.scala:137:31
    .io_req_addr                        (_cacheable_T_1),	// Parameters.scala:137:31
    .io_req_data                        (_GEN_79),	// Parameters.scala:137:31
    .io_req_is_hella                    (_GEN_80),	// Parameters.scala:137:31
    .io_req_tag_match                   (_GEN_81),	// Parameters.scala:137:31
    .io_req_old_meta_coh_state          (_GEN_82),	// Parameters.scala:137:31
    .io_req_old_meta_tag                (_GEN_83),	// Parameters.scala:137:31
    .io_req_way_en                      (_GEN_84),	// Parameters.scala:137:31
    .io_req_sdq_id                      (sdq_alloc_id),	// Mux.scala:47:69
    .io_req_is_probe                    (io_req_is_probe_0),
    .io_mem_acquire_ready
      (io_mem_acquire_ready & (idle ? ~_GEN_113 : state_6)),	// Arbiter.scala:16:61, :88:28, :116:26, :121:24, :123:31, package.scala:244:43
    .io_mem_grant_valid                 (_GEN_101 & io_mem_grant_valid),	// mshrs.scala:671:29, :673:{36,45}, :674:25
    .io_mem_grant_bits_opcode           (io_mem_grant_bits_opcode),
    .io_mem_grant_bits_param            (io_mem_grant_bits_param),
    .io_mem_grant_bits_size             (io_mem_grant_bits_size),
    .io_mem_grant_bits_sink             (io_mem_grant_bits_sink),
    .io_mem_grant_bits_data             (io_mem_grant_bits_data),
    .io_mem_finish_ready
      (io_mem_finish_ready & (beatsLeft_1 ? state_1_6 : ~_GEN_123)),	// Arbiter.scala:16:61, :87:30, :116:26, :121:24, :123:31, package.scala:244:43
    .io_prober_state_valid              (io_prober_state_valid),
    .io_prober_state_bits               (io_prober_state_bits),
    .io_refill_ready                    (_refill_arb_io_in_6_ready),	// mshrs.scala:604:30
    .io_meta_write_ready                (_meta_write_arb_io_in_6_ready),	// mshrs.scala:599:30
    .io_meta_read_ready                 (_meta_read_arb_io_in_6_ready),	// mshrs.scala:600:30
    .io_meta_resp_valid                 (io_meta_resp_valid),
    .io_meta_resp_bits_coh_state        (io_meta_resp_bits_coh_state),
    .io_wb_req_ready                    (_wb_req_arb_io_in_6_ready),	// mshrs.scala:601:30
    .io_lb_read_ready                   (_lb_read_arb_io_in_6_ready),	// mshrs.scala:569:28
    .io_lb_resp                         (lb_read_data),	// mshrs.scala:576:37, :580:38
    .io_lb_write_ready                  (_lb_write_arb_io_in_6_ready),	// mshrs.scala:570:28
    .io_replay_ready                    (_replay_arb_io_in_6_ready),	// mshrs.scala:602:30
    .io_resp_ready                      (_resp_arb_io_in_6_ready),	// mshrs.scala:603:30
    .io_wb_resp                         (io_wb_resp),
    .io_req_pri_rdy                     (_mshrs_6_io_req_pri_rdy),
    .io_req_sec_rdy                     (_mshrs_6_io_req_sec_rdy),
    .io_idx_valid                       (_mshrs_6_io_idx_valid),
    .io_idx_bits                        (_mshrs_6_io_idx_bits),
    .io_way_valid                       (_mshrs_6_io_way_valid),
    .io_way_bits                        (_mshrs_6_io_way_bits),
    .io_tag_valid                       (_mshrs_6_io_tag_valid),
    .io_tag_bits                        (_mshrs_6_io_tag_bits),
    .io_mem_acquire_valid               (_mshrs_6_io_mem_acquire_valid),
    .io_mem_acquire_bits_param          (_mshrs_6_io_mem_acquire_bits_param),
    .io_mem_acquire_bits_source         (_mshrs_6_io_mem_acquire_bits_source),
    .io_mem_acquire_bits_address        (_mshrs_6_io_mem_acquire_bits_address),
    .io_mem_grant_ready                 (_mshrs_6_io_mem_grant_ready),
    .io_mem_finish_valid                (_mshrs_6_io_mem_finish_valid),
    .io_mem_finish_bits_sink            (_mshrs_6_io_mem_finish_bits_sink),
    .io_refill_valid                    (_mshrs_6_io_refill_valid),
    .io_refill_bits_way_en              (_mshrs_6_io_refill_bits_way_en),
    .io_refill_bits_addr                (_mshrs_6_io_refill_bits_addr),
    .io_refill_bits_data                (_mshrs_6_io_refill_bits_data),
    .io_meta_write_valid                (_mshrs_6_io_meta_write_valid),
    .io_meta_write_bits_idx             (_mshrs_6_io_meta_write_bits_idx),
    .io_meta_write_bits_way_en          (_mshrs_6_io_meta_write_bits_way_en),
    .io_meta_write_bits_data_coh_state  (_mshrs_6_io_meta_write_bits_data_coh_state),
    .io_meta_write_bits_data_tag        (_mshrs_6_io_meta_write_bits_data_tag),
    .io_meta_read_valid                 (_mshrs_6_io_meta_read_valid),
    .io_meta_read_bits_idx              (_mshrs_6_io_meta_read_bits_idx),
    .io_meta_read_bits_way_en           (_mshrs_6_io_meta_read_bits_way_en),
    .io_meta_read_bits_tag              (_mshrs_6_io_meta_read_bits_tag),
    .io_wb_req_valid                    (_mshrs_6_io_wb_req_valid),
    .io_wb_req_bits_tag                 (_mshrs_6_io_wb_req_bits_tag),
    .io_wb_req_bits_idx                 (_mshrs_6_io_wb_req_bits_idx),
    .io_wb_req_bits_param               (_mshrs_6_io_wb_req_bits_param),
    .io_wb_req_bits_way_en              (_mshrs_6_io_wb_req_bits_way_en),
    .io_commit_val                      (_mshrs_6_io_commit_val),
    .io_commit_addr                     (_mshrs_6_io_commit_addr),
    .io_commit_coh_state                (_mshrs_6_io_commit_coh_state),
    .io_lb_read_valid                   (_mshrs_6_io_lb_read_valid),
    .io_lb_read_bits_id                 (_mshrs_6_io_lb_read_bits_id),
    .io_lb_read_bits_offset             (_mshrs_6_io_lb_read_bits_offset),
    .io_lb_write_valid                  (_mshrs_6_io_lb_write_valid),
    .io_lb_write_bits_id                (_mshrs_6_io_lb_write_bits_id),
    .io_lb_write_bits_offset            (_mshrs_6_io_lb_write_bits_offset),
    .io_lb_write_bits_data              (_mshrs_6_io_lb_write_bits_data),
    .io_replay_valid                    (_mshrs_6_io_replay_valid),
    .io_replay_bits_uop_uopc            (_mshrs_6_io_replay_bits_uop_uopc),
    .io_replay_bits_uop_inst            (_mshrs_6_io_replay_bits_uop_inst),
    .io_replay_bits_uop_debug_inst      (_mshrs_6_io_replay_bits_uop_debug_inst),
    .io_replay_bits_uop_is_rvc          (_mshrs_6_io_replay_bits_uop_is_rvc),
    .io_replay_bits_uop_debug_pc        (_mshrs_6_io_replay_bits_uop_debug_pc),
    .io_replay_bits_uop_iq_type         (_mshrs_6_io_replay_bits_uop_iq_type),
    .io_replay_bits_uop_fu_code         (_mshrs_6_io_replay_bits_uop_fu_code),
    .io_replay_bits_uop_ctrl_br_type    (_mshrs_6_io_replay_bits_uop_ctrl_br_type),
    .io_replay_bits_uop_ctrl_op1_sel    (_mshrs_6_io_replay_bits_uop_ctrl_op1_sel),
    .io_replay_bits_uop_ctrl_op2_sel    (_mshrs_6_io_replay_bits_uop_ctrl_op2_sel),
    .io_replay_bits_uop_ctrl_imm_sel    (_mshrs_6_io_replay_bits_uop_ctrl_imm_sel),
    .io_replay_bits_uop_ctrl_op_fcn     (_mshrs_6_io_replay_bits_uop_ctrl_op_fcn),
    .io_replay_bits_uop_ctrl_fcn_dw     (_mshrs_6_io_replay_bits_uop_ctrl_fcn_dw),
    .io_replay_bits_uop_ctrl_csr_cmd    (_mshrs_6_io_replay_bits_uop_ctrl_csr_cmd),
    .io_replay_bits_uop_ctrl_is_load    (_mshrs_6_io_replay_bits_uop_ctrl_is_load),
    .io_replay_bits_uop_ctrl_is_sta     (_mshrs_6_io_replay_bits_uop_ctrl_is_sta),
    .io_replay_bits_uop_ctrl_is_std     (_mshrs_6_io_replay_bits_uop_ctrl_is_std),
    .io_replay_bits_uop_iw_state        (_mshrs_6_io_replay_bits_uop_iw_state),
    .io_replay_bits_uop_iw_p1_poisoned  (_mshrs_6_io_replay_bits_uop_iw_p1_poisoned),
    .io_replay_bits_uop_iw_p2_poisoned  (_mshrs_6_io_replay_bits_uop_iw_p2_poisoned),
    .io_replay_bits_uop_is_br           (_mshrs_6_io_replay_bits_uop_is_br),
    .io_replay_bits_uop_is_jalr         (_mshrs_6_io_replay_bits_uop_is_jalr),
    .io_replay_bits_uop_is_jal          (_mshrs_6_io_replay_bits_uop_is_jal),
    .io_replay_bits_uop_is_sfb          (_mshrs_6_io_replay_bits_uop_is_sfb),
    .io_replay_bits_uop_br_mask         (_mshrs_6_io_replay_bits_uop_br_mask),
    .io_replay_bits_uop_br_tag          (_mshrs_6_io_replay_bits_uop_br_tag),
    .io_replay_bits_uop_ftq_idx         (_mshrs_6_io_replay_bits_uop_ftq_idx),
    .io_replay_bits_uop_edge_inst       (_mshrs_6_io_replay_bits_uop_edge_inst),
    .io_replay_bits_uop_pc_lob          (_mshrs_6_io_replay_bits_uop_pc_lob),
    .io_replay_bits_uop_taken           (_mshrs_6_io_replay_bits_uop_taken),
    .io_replay_bits_uop_imm_packed      (_mshrs_6_io_replay_bits_uop_imm_packed),
    .io_replay_bits_uop_csr_addr        (_mshrs_6_io_replay_bits_uop_csr_addr),
    .io_replay_bits_uop_rob_idx         (_mshrs_6_io_replay_bits_uop_rob_idx),
    .io_replay_bits_uop_ldq_idx         (_mshrs_6_io_replay_bits_uop_ldq_idx),
    .io_replay_bits_uop_stq_idx         (_mshrs_6_io_replay_bits_uop_stq_idx),
    .io_replay_bits_uop_rxq_idx         (_mshrs_6_io_replay_bits_uop_rxq_idx),
    .io_replay_bits_uop_pdst            (_mshrs_6_io_replay_bits_uop_pdst),
    .io_replay_bits_uop_prs1            (_mshrs_6_io_replay_bits_uop_prs1),
    .io_replay_bits_uop_prs2            (_mshrs_6_io_replay_bits_uop_prs2),
    .io_replay_bits_uop_prs3            (_mshrs_6_io_replay_bits_uop_prs3),
    .io_replay_bits_uop_ppred           (_mshrs_6_io_replay_bits_uop_ppred),
    .io_replay_bits_uop_prs1_busy       (_mshrs_6_io_replay_bits_uop_prs1_busy),
    .io_replay_bits_uop_prs2_busy       (_mshrs_6_io_replay_bits_uop_prs2_busy),
    .io_replay_bits_uop_prs3_busy       (_mshrs_6_io_replay_bits_uop_prs3_busy),
    .io_replay_bits_uop_ppred_busy      (_mshrs_6_io_replay_bits_uop_ppred_busy),
    .io_replay_bits_uop_stale_pdst      (_mshrs_6_io_replay_bits_uop_stale_pdst),
    .io_replay_bits_uop_exception       (_mshrs_6_io_replay_bits_uop_exception),
    .io_replay_bits_uop_exc_cause       (_mshrs_6_io_replay_bits_uop_exc_cause),
    .io_replay_bits_uop_bypassable      (_mshrs_6_io_replay_bits_uop_bypassable),
    .io_replay_bits_uop_mem_cmd         (_mshrs_6_io_replay_bits_uop_mem_cmd),
    .io_replay_bits_uop_mem_size        (_mshrs_6_io_replay_bits_uop_mem_size),
    .io_replay_bits_uop_mem_signed      (_mshrs_6_io_replay_bits_uop_mem_signed),
    .io_replay_bits_uop_is_fence        (_mshrs_6_io_replay_bits_uop_is_fence),
    .io_replay_bits_uop_is_fencei       (_mshrs_6_io_replay_bits_uop_is_fencei),
    .io_replay_bits_uop_is_amo          (_mshrs_6_io_replay_bits_uop_is_amo),
    .io_replay_bits_uop_uses_ldq        (_mshrs_6_io_replay_bits_uop_uses_ldq),
    .io_replay_bits_uop_uses_stq        (_mshrs_6_io_replay_bits_uop_uses_stq),
    .io_replay_bits_uop_is_sys_pc2epc   (_mshrs_6_io_replay_bits_uop_is_sys_pc2epc),
    .io_replay_bits_uop_is_unique       (_mshrs_6_io_replay_bits_uop_is_unique),
    .io_replay_bits_uop_flush_on_commit (_mshrs_6_io_replay_bits_uop_flush_on_commit),
    .io_replay_bits_uop_ldst_is_rs1     (_mshrs_6_io_replay_bits_uop_ldst_is_rs1),
    .io_replay_bits_uop_ldst            (_mshrs_6_io_replay_bits_uop_ldst),
    .io_replay_bits_uop_lrs1            (_mshrs_6_io_replay_bits_uop_lrs1),
    .io_replay_bits_uop_lrs2            (_mshrs_6_io_replay_bits_uop_lrs2),
    .io_replay_bits_uop_lrs3            (_mshrs_6_io_replay_bits_uop_lrs3),
    .io_replay_bits_uop_ldst_val        (_mshrs_6_io_replay_bits_uop_ldst_val),
    .io_replay_bits_uop_dst_rtype       (_mshrs_6_io_replay_bits_uop_dst_rtype),
    .io_replay_bits_uop_lrs1_rtype      (_mshrs_6_io_replay_bits_uop_lrs1_rtype),
    .io_replay_bits_uop_lrs2_rtype      (_mshrs_6_io_replay_bits_uop_lrs2_rtype),
    .io_replay_bits_uop_frs3_en         (_mshrs_6_io_replay_bits_uop_frs3_en),
    .io_replay_bits_uop_fp_val          (_mshrs_6_io_replay_bits_uop_fp_val),
    .io_replay_bits_uop_fp_single       (_mshrs_6_io_replay_bits_uop_fp_single),
    .io_replay_bits_uop_xcpt_pf_if      (_mshrs_6_io_replay_bits_uop_xcpt_pf_if),
    .io_replay_bits_uop_xcpt_ae_if      (_mshrs_6_io_replay_bits_uop_xcpt_ae_if),
    .io_replay_bits_uop_xcpt_ma_if      (_mshrs_6_io_replay_bits_uop_xcpt_ma_if),
    .io_replay_bits_uop_bp_debug_if     (_mshrs_6_io_replay_bits_uop_bp_debug_if),
    .io_replay_bits_uop_bp_xcpt_if      (_mshrs_6_io_replay_bits_uop_bp_xcpt_if),
    .io_replay_bits_uop_debug_fsrc      (_mshrs_6_io_replay_bits_uop_debug_fsrc),
    .io_replay_bits_uop_debug_tsrc      (_mshrs_6_io_replay_bits_uop_debug_tsrc),
    .io_replay_bits_addr                (_mshrs_6_io_replay_bits_addr),
    .io_replay_bits_is_hella            (_mshrs_6_io_replay_bits_is_hella),
    .io_replay_bits_way_en              (_mshrs_6_io_replay_bits_way_en),
    .io_replay_bits_sdq_id              (_mshrs_6_io_replay_bits_sdq_id),
    .io_resp_valid                      (_mshrs_6_io_resp_valid),
    .io_resp_bits_uop_uopc              (_mshrs_6_io_resp_bits_uop_uopc),
    .io_resp_bits_uop_inst              (_mshrs_6_io_resp_bits_uop_inst),
    .io_resp_bits_uop_debug_inst        (_mshrs_6_io_resp_bits_uop_debug_inst),
    .io_resp_bits_uop_is_rvc            (_mshrs_6_io_resp_bits_uop_is_rvc),
    .io_resp_bits_uop_debug_pc          (_mshrs_6_io_resp_bits_uop_debug_pc),
    .io_resp_bits_uop_iq_type           (_mshrs_6_io_resp_bits_uop_iq_type),
    .io_resp_bits_uop_fu_code           (_mshrs_6_io_resp_bits_uop_fu_code),
    .io_resp_bits_uop_ctrl_br_type      (_mshrs_6_io_resp_bits_uop_ctrl_br_type),
    .io_resp_bits_uop_ctrl_op1_sel      (_mshrs_6_io_resp_bits_uop_ctrl_op1_sel),
    .io_resp_bits_uop_ctrl_op2_sel      (_mshrs_6_io_resp_bits_uop_ctrl_op2_sel),
    .io_resp_bits_uop_ctrl_imm_sel      (_mshrs_6_io_resp_bits_uop_ctrl_imm_sel),
    .io_resp_bits_uop_ctrl_op_fcn       (_mshrs_6_io_resp_bits_uop_ctrl_op_fcn),
    .io_resp_bits_uop_ctrl_fcn_dw       (_mshrs_6_io_resp_bits_uop_ctrl_fcn_dw),
    .io_resp_bits_uop_ctrl_csr_cmd      (_mshrs_6_io_resp_bits_uop_ctrl_csr_cmd),
    .io_resp_bits_uop_ctrl_is_load      (_mshrs_6_io_resp_bits_uop_ctrl_is_load),
    .io_resp_bits_uop_ctrl_is_sta       (_mshrs_6_io_resp_bits_uop_ctrl_is_sta),
    .io_resp_bits_uop_ctrl_is_std       (_mshrs_6_io_resp_bits_uop_ctrl_is_std),
    .io_resp_bits_uop_iw_state          (_mshrs_6_io_resp_bits_uop_iw_state),
    .io_resp_bits_uop_iw_p1_poisoned    (_mshrs_6_io_resp_bits_uop_iw_p1_poisoned),
    .io_resp_bits_uop_iw_p2_poisoned    (_mshrs_6_io_resp_bits_uop_iw_p2_poisoned),
    .io_resp_bits_uop_is_br             (_mshrs_6_io_resp_bits_uop_is_br),
    .io_resp_bits_uop_is_jalr           (_mshrs_6_io_resp_bits_uop_is_jalr),
    .io_resp_bits_uop_is_jal            (_mshrs_6_io_resp_bits_uop_is_jal),
    .io_resp_bits_uop_is_sfb            (_mshrs_6_io_resp_bits_uop_is_sfb),
    .io_resp_bits_uop_br_mask           (_mshrs_6_io_resp_bits_uop_br_mask),
    .io_resp_bits_uop_br_tag            (_mshrs_6_io_resp_bits_uop_br_tag),
    .io_resp_bits_uop_ftq_idx           (_mshrs_6_io_resp_bits_uop_ftq_idx),
    .io_resp_bits_uop_edge_inst         (_mshrs_6_io_resp_bits_uop_edge_inst),
    .io_resp_bits_uop_pc_lob            (_mshrs_6_io_resp_bits_uop_pc_lob),
    .io_resp_bits_uop_taken             (_mshrs_6_io_resp_bits_uop_taken),
    .io_resp_bits_uop_imm_packed        (_mshrs_6_io_resp_bits_uop_imm_packed),
    .io_resp_bits_uop_csr_addr          (_mshrs_6_io_resp_bits_uop_csr_addr),
    .io_resp_bits_uop_rob_idx           (_mshrs_6_io_resp_bits_uop_rob_idx),
    .io_resp_bits_uop_ldq_idx           (_mshrs_6_io_resp_bits_uop_ldq_idx),
    .io_resp_bits_uop_stq_idx           (_mshrs_6_io_resp_bits_uop_stq_idx),
    .io_resp_bits_uop_rxq_idx           (_mshrs_6_io_resp_bits_uop_rxq_idx),
    .io_resp_bits_uop_pdst              (_mshrs_6_io_resp_bits_uop_pdst),
    .io_resp_bits_uop_prs1              (_mshrs_6_io_resp_bits_uop_prs1),
    .io_resp_bits_uop_prs2              (_mshrs_6_io_resp_bits_uop_prs2),
    .io_resp_bits_uop_prs3              (_mshrs_6_io_resp_bits_uop_prs3),
    .io_resp_bits_uop_ppred             (_mshrs_6_io_resp_bits_uop_ppred),
    .io_resp_bits_uop_prs1_busy         (_mshrs_6_io_resp_bits_uop_prs1_busy),
    .io_resp_bits_uop_prs2_busy         (_mshrs_6_io_resp_bits_uop_prs2_busy),
    .io_resp_bits_uop_prs3_busy         (_mshrs_6_io_resp_bits_uop_prs3_busy),
    .io_resp_bits_uop_ppred_busy        (_mshrs_6_io_resp_bits_uop_ppred_busy),
    .io_resp_bits_uop_stale_pdst        (_mshrs_6_io_resp_bits_uop_stale_pdst),
    .io_resp_bits_uop_exception         (_mshrs_6_io_resp_bits_uop_exception),
    .io_resp_bits_uop_exc_cause         (_mshrs_6_io_resp_bits_uop_exc_cause),
    .io_resp_bits_uop_bypassable        (_mshrs_6_io_resp_bits_uop_bypassable),
    .io_resp_bits_uop_mem_cmd           (_mshrs_6_io_resp_bits_uop_mem_cmd),
    .io_resp_bits_uop_mem_size          (_mshrs_6_io_resp_bits_uop_mem_size),
    .io_resp_bits_uop_mem_signed        (_mshrs_6_io_resp_bits_uop_mem_signed),
    .io_resp_bits_uop_is_fence          (_mshrs_6_io_resp_bits_uop_is_fence),
    .io_resp_bits_uop_is_fencei         (_mshrs_6_io_resp_bits_uop_is_fencei),
    .io_resp_bits_uop_is_amo            (_mshrs_6_io_resp_bits_uop_is_amo),
    .io_resp_bits_uop_uses_ldq          (_mshrs_6_io_resp_bits_uop_uses_ldq),
    .io_resp_bits_uop_uses_stq          (_mshrs_6_io_resp_bits_uop_uses_stq),
    .io_resp_bits_uop_is_sys_pc2epc     (_mshrs_6_io_resp_bits_uop_is_sys_pc2epc),
    .io_resp_bits_uop_is_unique         (_mshrs_6_io_resp_bits_uop_is_unique),
    .io_resp_bits_uop_flush_on_commit   (_mshrs_6_io_resp_bits_uop_flush_on_commit),
    .io_resp_bits_uop_ldst_is_rs1       (_mshrs_6_io_resp_bits_uop_ldst_is_rs1),
    .io_resp_bits_uop_ldst              (_mshrs_6_io_resp_bits_uop_ldst),
    .io_resp_bits_uop_lrs1              (_mshrs_6_io_resp_bits_uop_lrs1),
    .io_resp_bits_uop_lrs2              (_mshrs_6_io_resp_bits_uop_lrs2),
    .io_resp_bits_uop_lrs3              (_mshrs_6_io_resp_bits_uop_lrs3),
    .io_resp_bits_uop_ldst_val          (_mshrs_6_io_resp_bits_uop_ldst_val),
    .io_resp_bits_uop_dst_rtype         (_mshrs_6_io_resp_bits_uop_dst_rtype),
    .io_resp_bits_uop_lrs1_rtype        (_mshrs_6_io_resp_bits_uop_lrs1_rtype),
    .io_resp_bits_uop_lrs2_rtype        (_mshrs_6_io_resp_bits_uop_lrs2_rtype),
    .io_resp_bits_uop_frs3_en           (_mshrs_6_io_resp_bits_uop_frs3_en),
    .io_resp_bits_uop_fp_val            (_mshrs_6_io_resp_bits_uop_fp_val),
    .io_resp_bits_uop_fp_single         (_mshrs_6_io_resp_bits_uop_fp_single),
    .io_resp_bits_uop_xcpt_pf_if        (_mshrs_6_io_resp_bits_uop_xcpt_pf_if),
    .io_resp_bits_uop_xcpt_ae_if        (_mshrs_6_io_resp_bits_uop_xcpt_ae_if),
    .io_resp_bits_uop_xcpt_ma_if        (_mshrs_6_io_resp_bits_uop_xcpt_ma_if),
    .io_resp_bits_uop_bp_debug_if       (_mshrs_6_io_resp_bits_uop_bp_debug_if),
    .io_resp_bits_uop_bp_xcpt_if        (_mshrs_6_io_resp_bits_uop_bp_xcpt_if),
    .io_resp_bits_uop_debug_fsrc        (_mshrs_6_io_resp_bits_uop_debug_fsrc),
    .io_resp_bits_uop_debug_tsrc        (_mshrs_6_io_resp_bits_uop_debug_tsrc),
    .io_resp_bits_data                  (_mshrs_6_io_resp_bits_data),
    .io_resp_bits_is_hella              (_mshrs_6_io_resp_bits_is_hella),
    .io_probe_rdy                       (_mshrs_6_io_probe_rdy)
  );
  BoomMSHR mshrs_7 (	// mshrs.scala:620:22
    .clock                              (clock),
    .reset                              (reset),
    .io_id                              (3'h7),	// Mux.scala:47:69
    .io_req_pri_val                     ((&mshr_alloc_idx_REG) & pri_val),	// mshrs.scala:618:51, :632:{34,54}, :694:31
    .io_req_sec_val                     (_mshr_io_req_sec_val_T_31),	// mshrs.scala:637:99
    .io_clear_prefetch
      (io_clear_all & ~_GEN | _GEN & _GEN_94 & cacheable & ~_GEN_86 | io_req_is_probe_0
       & _GEN_94),	// Parameters.scala:137:31, :671:42, mshrs.scala:637:{50,72}, :644:{46,49}, :645:{58,61,82}, :646:21
    .io_brupdate_b1_resolve_mask        (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask     (io_brupdate_b1_mispredict_mask),
    .io_exception                       (io_exception),
    .io_req_uop_uopc                    (_GEN_0),	// Parameters.scala:137:31
    .io_req_uop_inst                    (_GEN_1),	// Parameters.scala:137:31
    .io_req_uop_debug_inst              (_GEN_2),	// Parameters.scala:137:31
    .io_req_uop_is_rvc                  (_GEN_3),	// Parameters.scala:137:31
    .io_req_uop_debug_pc                (_GEN_4),	// Parameters.scala:137:31
    .io_req_uop_iq_type                 (_GEN_5),	// Parameters.scala:137:31
    .io_req_uop_fu_code                 (_GEN_6),	// Parameters.scala:137:31
    .io_req_uop_ctrl_br_type            (_GEN_7),	// Parameters.scala:137:31
    .io_req_uop_ctrl_op1_sel            (_GEN_8),	// Parameters.scala:137:31
    .io_req_uop_ctrl_op2_sel            (_GEN_9),	// Parameters.scala:137:31
    .io_req_uop_ctrl_imm_sel            (_GEN_10),	// Parameters.scala:137:31
    .io_req_uop_ctrl_op_fcn             (_GEN_11),	// Parameters.scala:137:31
    .io_req_uop_ctrl_fcn_dw             (_GEN_12),	// Parameters.scala:137:31
    .io_req_uop_ctrl_csr_cmd            (_GEN_13),	// Parameters.scala:137:31
    .io_req_uop_ctrl_is_load            (_GEN_14),	// Parameters.scala:137:31
    .io_req_uop_ctrl_is_sta             (_GEN_15),	// Parameters.scala:137:31
    .io_req_uop_ctrl_is_std             (_GEN_16),	// Parameters.scala:137:31
    .io_req_uop_iw_state                (_GEN_17),	// Parameters.scala:137:31
    .io_req_uop_iw_p1_poisoned          (_GEN_18),	// Parameters.scala:137:31
    .io_req_uop_iw_p2_poisoned          (_GEN_19),	// Parameters.scala:137:31
    .io_req_uop_is_br                   (_GEN_20),	// Parameters.scala:137:31
    .io_req_uop_is_jalr                 (_GEN_21),	// Parameters.scala:137:31
    .io_req_uop_is_jal                  (_GEN_22),	// Parameters.scala:137:31
    .io_req_uop_is_sfb                  (_GEN_23),	// Parameters.scala:137:31
    .io_req_uop_br_mask                 (_GEN_24),	// Parameters.scala:137:31
    .io_req_uop_br_tag                  (_GEN_25),	// Parameters.scala:137:31
    .io_req_uop_ftq_idx                 (_GEN_26),	// Parameters.scala:137:31
    .io_req_uop_edge_inst               (_GEN_27),	// Parameters.scala:137:31
    .io_req_uop_pc_lob                  (_GEN_28),	// Parameters.scala:137:31
    .io_req_uop_taken                   (_GEN_29),	// Parameters.scala:137:31
    .io_req_uop_imm_packed              (_GEN_30),	// Parameters.scala:137:31
    .io_req_uop_csr_addr                (_GEN_31),	// Parameters.scala:137:31
    .io_req_uop_rob_idx                 (_GEN_32),	// Parameters.scala:137:31
    .io_req_uop_ldq_idx                 (_GEN_33),	// Parameters.scala:137:31
    .io_req_uop_stq_idx                 (_GEN_34),	// Parameters.scala:137:31
    .io_req_uop_rxq_idx                 (_GEN_35),	// Parameters.scala:137:31
    .io_req_uop_pdst                    (_GEN_36),	// Parameters.scala:137:31
    .io_req_uop_prs1                    (_GEN_37),	// Parameters.scala:137:31
    .io_req_uop_prs2                    (_GEN_38),	// Parameters.scala:137:31
    .io_req_uop_prs3                    (_GEN_39),	// Parameters.scala:137:31
    .io_req_uop_ppred                   (_GEN_40),	// Parameters.scala:137:31
    .io_req_uop_prs1_busy               (_GEN_41),	// Parameters.scala:137:31
    .io_req_uop_prs2_busy               (_GEN_42),	// Parameters.scala:137:31
    .io_req_uop_prs3_busy               (_GEN_43),	// Parameters.scala:137:31
    .io_req_uop_ppred_busy              (_GEN_44),	// Parameters.scala:137:31
    .io_req_uop_stale_pdst              (_GEN_45),	// Parameters.scala:137:31
    .io_req_uop_exception               (_GEN_46),	// Parameters.scala:137:31
    .io_req_uop_exc_cause               (_GEN_47),	// Parameters.scala:137:31
    .io_req_uop_bypassable              (_GEN_48),	// Parameters.scala:137:31
    .io_req_uop_mem_cmd                 (_GEN_49),	// Parameters.scala:137:31
    .io_req_uop_mem_size                (_GEN_50),	// Parameters.scala:137:31
    .io_req_uop_mem_signed              (_GEN_51),	// Parameters.scala:137:31
    .io_req_uop_is_fence                (_GEN_52),	// Parameters.scala:137:31
    .io_req_uop_is_fencei               (_GEN_53),	// Parameters.scala:137:31
    .io_req_uop_is_amo                  (_GEN_54),	// Parameters.scala:137:31
    .io_req_uop_uses_ldq                (_GEN_55),	// Parameters.scala:137:31
    .io_req_uop_uses_stq                (_GEN_56),	// Parameters.scala:137:31
    .io_req_uop_is_sys_pc2epc           (_GEN_57),	// Parameters.scala:137:31
    .io_req_uop_is_unique               (_GEN_58),	// Parameters.scala:137:31
    .io_req_uop_flush_on_commit         (_GEN_59),	// Parameters.scala:137:31
    .io_req_uop_ldst_is_rs1             (_GEN_60),	// Parameters.scala:137:31
    .io_req_uop_ldst                    (_GEN_61),	// Parameters.scala:137:31
    .io_req_uop_lrs1                    (_GEN_62),	// Parameters.scala:137:31
    .io_req_uop_lrs2                    (_GEN_63),	// Parameters.scala:137:31
    .io_req_uop_lrs3                    (_GEN_64),	// Parameters.scala:137:31
    .io_req_uop_ldst_val                (_GEN_65),	// Parameters.scala:137:31
    .io_req_uop_dst_rtype               (_GEN_66),	// Parameters.scala:137:31
    .io_req_uop_lrs1_rtype              (_GEN_67),	// Parameters.scala:137:31
    .io_req_uop_lrs2_rtype              (_GEN_68),	// Parameters.scala:137:31
    .io_req_uop_frs3_en                 (_GEN_69),	// Parameters.scala:137:31
    .io_req_uop_fp_val                  (_GEN_70),	// Parameters.scala:137:31
    .io_req_uop_fp_single               (_GEN_71),	// Parameters.scala:137:31
    .io_req_uop_xcpt_pf_if              (_GEN_72),	// Parameters.scala:137:31
    .io_req_uop_xcpt_ae_if              (_GEN_73),	// Parameters.scala:137:31
    .io_req_uop_xcpt_ma_if              (_GEN_74),	// Parameters.scala:137:31
    .io_req_uop_bp_debug_if             (_GEN_75),	// Parameters.scala:137:31
    .io_req_uop_bp_xcpt_if              (_GEN_76),	// Parameters.scala:137:31
    .io_req_uop_debug_fsrc              (_GEN_77),	// Parameters.scala:137:31
    .io_req_uop_debug_tsrc              (_GEN_78),	// Parameters.scala:137:31
    .io_req_addr                        (_cacheable_T_1),	// Parameters.scala:137:31
    .io_req_data                        (_GEN_79),	// Parameters.scala:137:31
    .io_req_is_hella                    (_GEN_80),	// Parameters.scala:137:31
    .io_req_tag_match                   (_GEN_81),	// Parameters.scala:137:31
    .io_req_old_meta_coh_state          (_GEN_82),	// Parameters.scala:137:31
    .io_req_old_meta_tag                (_GEN_83),	// Parameters.scala:137:31
    .io_req_way_en                      (_GEN_84),	// Parameters.scala:137:31
    .io_req_sdq_id                      (sdq_alloc_id),	// Mux.scala:47:69
    .io_req_is_probe                    (io_req_is_probe_0),
    .io_mem_acquire_ready
      (io_mem_acquire_ready & (idle ? ~_GEN_112 : state_7)),	// Arbiter.scala:16:61, :88:28, :116:26, :121:24, :123:31, package.scala:244:43
    .io_mem_grant_valid                 (_GEN_103 & io_mem_grant_valid),	// mshrs.scala:671:29, :673:{36,45}, :674:25
    .io_mem_grant_bits_opcode           (io_mem_grant_bits_opcode),
    .io_mem_grant_bits_param            (io_mem_grant_bits_param),
    .io_mem_grant_bits_size             (io_mem_grant_bits_size),
    .io_mem_grant_bits_sink             (io_mem_grant_bits_sink),
    .io_mem_grant_bits_data             (io_mem_grant_bits_data),
    .io_mem_finish_ready
      (io_mem_finish_ready & (beatsLeft_1 ? state_1_7 : ~_GEN_122)),	// Arbiter.scala:16:61, :87:30, :116:26, :121:24, :123:31, package.scala:244:43
    .io_prober_state_valid              (io_prober_state_valid),
    .io_prober_state_bits               (io_prober_state_bits),
    .io_refill_ready                    (_refill_arb_io_in_7_ready),	// mshrs.scala:604:30
    .io_meta_write_ready                (_meta_write_arb_io_in_7_ready),	// mshrs.scala:599:30
    .io_meta_read_ready                 (_meta_read_arb_io_in_7_ready),	// mshrs.scala:600:30
    .io_meta_resp_valid                 (io_meta_resp_valid),
    .io_meta_resp_bits_coh_state        (io_meta_resp_bits_coh_state),
    .io_wb_req_ready                    (_wb_req_arb_io_in_7_ready),	// mshrs.scala:601:30
    .io_lb_read_ready                   (_lb_read_arb_io_in_7_ready),	// mshrs.scala:569:28
    .io_lb_resp                         (lb_read_data),	// mshrs.scala:576:37, :580:38
    .io_lb_write_ready                  (_lb_write_arb_io_in_7_ready),	// mshrs.scala:570:28
    .io_replay_ready                    (_replay_arb_io_in_7_ready),	// mshrs.scala:602:30
    .io_resp_ready                      (_resp_arb_io_in_7_ready),	// mshrs.scala:603:30
    .io_wb_resp                         (io_wb_resp),
    .io_req_pri_rdy                     (_mshrs_7_io_req_pri_rdy),
    .io_req_sec_rdy                     (_mshrs_7_io_req_sec_rdy),
    .io_idx_valid                       (_mshrs_7_io_idx_valid),
    .io_idx_bits                        (_mshrs_7_io_idx_bits),
    .io_way_valid                       (_mshrs_7_io_way_valid),
    .io_way_bits                        (_mshrs_7_io_way_bits),
    .io_tag_valid                       (_mshrs_7_io_tag_valid),
    .io_tag_bits                        (_mshrs_7_io_tag_bits),
    .io_mem_acquire_valid               (_mshrs_7_io_mem_acquire_valid),
    .io_mem_acquire_bits_param          (_mshrs_7_io_mem_acquire_bits_param),
    .io_mem_acquire_bits_source         (_mshrs_7_io_mem_acquire_bits_source),
    .io_mem_acquire_bits_address        (_mshrs_7_io_mem_acquire_bits_address),
    .io_mem_grant_ready                 (_mshrs_7_io_mem_grant_ready),
    .io_mem_finish_valid                (_mshrs_7_io_mem_finish_valid),
    .io_mem_finish_bits_sink            (_mshrs_7_io_mem_finish_bits_sink),
    .io_refill_valid                    (_mshrs_7_io_refill_valid),
    .io_refill_bits_way_en              (_mshrs_7_io_refill_bits_way_en),
    .io_refill_bits_addr                (_mshrs_7_io_refill_bits_addr),
    .io_refill_bits_data                (_mshrs_7_io_refill_bits_data),
    .io_meta_write_valid                (_mshrs_7_io_meta_write_valid),
    .io_meta_write_bits_idx             (_mshrs_7_io_meta_write_bits_idx),
    .io_meta_write_bits_way_en          (_mshrs_7_io_meta_write_bits_way_en),
    .io_meta_write_bits_data_coh_state  (_mshrs_7_io_meta_write_bits_data_coh_state),
    .io_meta_write_bits_data_tag        (_mshrs_7_io_meta_write_bits_data_tag),
    .io_meta_read_valid                 (_mshrs_7_io_meta_read_valid),
    .io_meta_read_bits_idx              (_mshrs_7_io_meta_read_bits_idx),
    .io_meta_read_bits_way_en           (_mshrs_7_io_meta_read_bits_way_en),
    .io_meta_read_bits_tag              (_mshrs_7_io_meta_read_bits_tag),
    .io_wb_req_valid                    (_mshrs_7_io_wb_req_valid),
    .io_wb_req_bits_tag                 (_mshrs_7_io_wb_req_bits_tag),
    .io_wb_req_bits_idx                 (_mshrs_7_io_wb_req_bits_idx),
    .io_wb_req_bits_param               (_mshrs_7_io_wb_req_bits_param),
    .io_wb_req_bits_way_en              (_mshrs_7_io_wb_req_bits_way_en),
    .io_commit_val                      (_mshrs_7_io_commit_val),
    .io_commit_addr                     (_mshrs_7_io_commit_addr),
    .io_commit_coh_state                (_mshrs_7_io_commit_coh_state),
    .io_lb_read_valid                   (_mshrs_7_io_lb_read_valid),
    .io_lb_read_bits_id                 (_mshrs_7_io_lb_read_bits_id),
    .io_lb_read_bits_offset             (_mshrs_7_io_lb_read_bits_offset),
    .io_lb_write_valid                  (_mshrs_7_io_lb_write_valid),
    .io_lb_write_bits_id                (_mshrs_7_io_lb_write_bits_id),
    .io_lb_write_bits_offset            (_mshrs_7_io_lb_write_bits_offset),
    .io_lb_write_bits_data              (_mshrs_7_io_lb_write_bits_data),
    .io_replay_valid                    (_mshrs_7_io_replay_valid),
    .io_replay_bits_uop_uopc            (_mshrs_7_io_replay_bits_uop_uopc),
    .io_replay_bits_uop_inst            (_mshrs_7_io_replay_bits_uop_inst),
    .io_replay_bits_uop_debug_inst      (_mshrs_7_io_replay_bits_uop_debug_inst),
    .io_replay_bits_uop_is_rvc          (_mshrs_7_io_replay_bits_uop_is_rvc),
    .io_replay_bits_uop_debug_pc        (_mshrs_7_io_replay_bits_uop_debug_pc),
    .io_replay_bits_uop_iq_type         (_mshrs_7_io_replay_bits_uop_iq_type),
    .io_replay_bits_uop_fu_code         (_mshrs_7_io_replay_bits_uop_fu_code),
    .io_replay_bits_uop_ctrl_br_type    (_mshrs_7_io_replay_bits_uop_ctrl_br_type),
    .io_replay_bits_uop_ctrl_op1_sel    (_mshrs_7_io_replay_bits_uop_ctrl_op1_sel),
    .io_replay_bits_uop_ctrl_op2_sel    (_mshrs_7_io_replay_bits_uop_ctrl_op2_sel),
    .io_replay_bits_uop_ctrl_imm_sel    (_mshrs_7_io_replay_bits_uop_ctrl_imm_sel),
    .io_replay_bits_uop_ctrl_op_fcn     (_mshrs_7_io_replay_bits_uop_ctrl_op_fcn),
    .io_replay_bits_uop_ctrl_fcn_dw     (_mshrs_7_io_replay_bits_uop_ctrl_fcn_dw),
    .io_replay_bits_uop_ctrl_csr_cmd    (_mshrs_7_io_replay_bits_uop_ctrl_csr_cmd),
    .io_replay_bits_uop_ctrl_is_load    (_mshrs_7_io_replay_bits_uop_ctrl_is_load),
    .io_replay_bits_uop_ctrl_is_sta     (_mshrs_7_io_replay_bits_uop_ctrl_is_sta),
    .io_replay_bits_uop_ctrl_is_std     (_mshrs_7_io_replay_bits_uop_ctrl_is_std),
    .io_replay_bits_uop_iw_state        (_mshrs_7_io_replay_bits_uop_iw_state),
    .io_replay_bits_uop_iw_p1_poisoned  (_mshrs_7_io_replay_bits_uop_iw_p1_poisoned),
    .io_replay_bits_uop_iw_p2_poisoned  (_mshrs_7_io_replay_bits_uop_iw_p2_poisoned),
    .io_replay_bits_uop_is_br           (_mshrs_7_io_replay_bits_uop_is_br),
    .io_replay_bits_uop_is_jalr         (_mshrs_7_io_replay_bits_uop_is_jalr),
    .io_replay_bits_uop_is_jal          (_mshrs_7_io_replay_bits_uop_is_jal),
    .io_replay_bits_uop_is_sfb          (_mshrs_7_io_replay_bits_uop_is_sfb),
    .io_replay_bits_uop_br_mask         (_mshrs_7_io_replay_bits_uop_br_mask),
    .io_replay_bits_uop_br_tag          (_mshrs_7_io_replay_bits_uop_br_tag),
    .io_replay_bits_uop_ftq_idx         (_mshrs_7_io_replay_bits_uop_ftq_idx),
    .io_replay_bits_uop_edge_inst       (_mshrs_7_io_replay_bits_uop_edge_inst),
    .io_replay_bits_uop_pc_lob          (_mshrs_7_io_replay_bits_uop_pc_lob),
    .io_replay_bits_uop_taken           (_mshrs_7_io_replay_bits_uop_taken),
    .io_replay_bits_uop_imm_packed      (_mshrs_7_io_replay_bits_uop_imm_packed),
    .io_replay_bits_uop_csr_addr        (_mshrs_7_io_replay_bits_uop_csr_addr),
    .io_replay_bits_uop_rob_idx         (_mshrs_7_io_replay_bits_uop_rob_idx),
    .io_replay_bits_uop_ldq_idx         (_mshrs_7_io_replay_bits_uop_ldq_idx),
    .io_replay_bits_uop_stq_idx         (_mshrs_7_io_replay_bits_uop_stq_idx),
    .io_replay_bits_uop_rxq_idx         (_mshrs_7_io_replay_bits_uop_rxq_idx),
    .io_replay_bits_uop_pdst            (_mshrs_7_io_replay_bits_uop_pdst),
    .io_replay_bits_uop_prs1            (_mshrs_7_io_replay_bits_uop_prs1),
    .io_replay_bits_uop_prs2            (_mshrs_7_io_replay_bits_uop_prs2),
    .io_replay_bits_uop_prs3            (_mshrs_7_io_replay_bits_uop_prs3),
    .io_replay_bits_uop_ppred           (_mshrs_7_io_replay_bits_uop_ppred),
    .io_replay_bits_uop_prs1_busy       (_mshrs_7_io_replay_bits_uop_prs1_busy),
    .io_replay_bits_uop_prs2_busy       (_mshrs_7_io_replay_bits_uop_prs2_busy),
    .io_replay_bits_uop_prs3_busy       (_mshrs_7_io_replay_bits_uop_prs3_busy),
    .io_replay_bits_uop_ppred_busy      (_mshrs_7_io_replay_bits_uop_ppred_busy),
    .io_replay_bits_uop_stale_pdst      (_mshrs_7_io_replay_bits_uop_stale_pdst),
    .io_replay_bits_uop_exception       (_mshrs_7_io_replay_bits_uop_exception),
    .io_replay_bits_uop_exc_cause       (_mshrs_7_io_replay_bits_uop_exc_cause),
    .io_replay_bits_uop_bypassable      (_mshrs_7_io_replay_bits_uop_bypassable),
    .io_replay_bits_uop_mem_cmd         (_mshrs_7_io_replay_bits_uop_mem_cmd),
    .io_replay_bits_uop_mem_size        (_mshrs_7_io_replay_bits_uop_mem_size),
    .io_replay_bits_uop_mem_signed      (_mshrs_7_io_replay_bits_uop_mem_signed),
    .io_replay_bits_uop_is_fence        (_mshrs_7_io_replay_bits_uop_is_fence),
    .io_replay_bits_uop_is_fencei       (_mshrs_7_io_replay_bits_uop_is_fencei),
    .io_replay_bits_uop_is_amo          (_mshrs_7_io_replay_bits_uop_is_amo),
    .io_replay_bits_uop_uses_ldq        (_mshrs_7_io_replay_bits_uop_uses_ldq),
    .io_replay_bits_uop_uses_stq        (_mshrs_7_io_replay_bits_uop_uses_stq),
    .io_replay_bits_uop_is_sys_pc2epc   (_mshrs_7_io_replay_bits_uop_is_sys_pc2epc),
    .io_replay_bits_uop_is_unique       (_mshrs_7_io_replay_bits_uop_is_unique),
    .io_replay_bits_uop_flush_on_commit (_mshrs_7_io_replay_bits_uop_flush_on_commit),
    .io_replay_bits_uop_ldst_is_rs1     (_mshrs_7_io_replay_bits_uop_ldst_is_rs1),
    .io_replay_bits_uop_ldst            (_mshrs_7_io_replay_bits_uop_ldst),
    .io_replay_bits_uop_lrs1            (_mshrs_7_io_replay_bits_uop_lrs1),
    .io_replay_bits_uop_lrs2            (_mshrs_7_io_replay_bits_uop_lrs2),
    .io_replay_bits_uop_lrs3            (_mshrs_7_io_replay_bits_uop_lrs3),
    .io_replay_bits_uop_ldst_val        (_mshrs_7_io_replay_bits_uop_ldst_val),
    .io_replay_bits_uop_dst_rtype       (_mshrs_7_io_replay_bits_uop_dst_rtype),
    .io_replay_bits_uop_lrs1_rtype      (_mshrs_7_io_replay_bits_uop_lrs1_rtype),
    .io_replay_bits_uop_lrs2_rtype      (_mshrs_7_io_replay_bits_uop_lrs2_rtype),
    .io_replay_bits_uop_frs3_en         (_mshrs_7_io_replay_bits_uop_frs3_en),
    .io_replay_bits_uop_fp_val          (_mshrs_7_io_replay_bits_uop_fp_val),
    .io_replay_bits_uop_fp_single       (_mshrs_7_io_replay_bits_uop_fp_single),
    .io_replay_bits_uop_xcpt_pf_if      (_mshrs_7_io_replay_bits_uop_xcpt_pf_if),
    .io_replay_bits_uop_xcpt_ae_if      (_mshrs_7_io_replay_bits_uop_xcpt_ae_if),
    .io_replay_bits_uop_xcpt_ma_if      (_mshrs_7_io_replay_bits_uop_xcpt_ma_if),
    .io_replay_bits_uop_bp_debug_if     (_mshrs_7_io_replay_bits_uop_bp_debug_if),
    .io_replay_bits_uop_bp_xcpt_if      (_mshrs_7_io_replay_bits_uop_bp_xcpt_if),
    .io_replay_bits_uop_debug_fsrc      (_mshrs_7_io_replay_bits_uop_debug_fsrc),
    .io_replay_bits_uop_debug_tsrc      (_mshrs_7_io_replay_bits_uop_debug_tsrc),
    .io_replay_bits_addr                (_mshrs_7_io_replay_bits_addr),
    .io_replay_bits_is_hella            (_mshrs_7_io_replay_bits_is_hella),
    .io_replay_bits_way_en              (_mshrs_7_io_replay_bits_way_en),
    .io_replay_bits_sdq_id              (_mshrs_7_io_replay_bits_sdq_id),
    .io_resp_valid                      (_mshrs_7_io_resp_valid),
    .io_resp_bits_uop_uopc              (_mshrs_7_io_resp_bits_uop_uopc),
    .io_resp_bits_uop_inst              (_mshrs_7_io_resp_bits_uop_inst),
    .io_resp_bits_uop_debug_inst        (_mshrs_7_io_resp_bits_uop_debug_inst),
    .io_resp_bits_uop_is_rvc            (_mshrs_7_io_resp_bits_uop_is_rvc),
    .io_resp_bits_uop_debug_pc          (_mshrs_7_io_resp_bits_uop_debug_pc),
    .io_resp_bits_uop_iq_type           (_mshrs_7_io_resp_bits_uop_iq_type),
    .io_resp_bits_uop_fu_code           (_mshrs_7_io_resp_bits_uop_fu_code),
    .io_resp_bits_uop_ctrl_br_type      (_mshrs_7_io_resp_bits_uop_ctrl_br_type),
    .io_resp_bits_uop_ctrl_op1_sel      (_mshrs_7_io_resp_bits_uop_ctrl_op1_sel),
    .io_resp_bits_uop_ctrl_op2_sel      (_mshrs_7_io_resp_bits_uop_ctrl_op2_sel),
    .io_resp_bits_uop_ctrl_imm_sel      (_mshrs_7_io_resp_bits_uop_ctrl_imm_sel),
    .io_resp_bits_uop_ctrl_op_fcn       (_mshrs_7_io_resp_bits_uop_ctrl_op_fcn),
    .io_resp_bits_uop_ctrl_fcn_dw       (_mshrs_7_io_resp_bits_uop_ctrl_fcn_dw),
    .io_resp_bits_uop_ctrl_csr_cmd      (_mshrs_7_io_resp_bits_uop_ctrl_csr_cmd),
    .io_resp_bits_uop_ctrl_is_load      (_mshrs_7_io_resp_bits_uop_ctrl_is_load),
    .io_resp_bits_uop_ctrl_is_sta       (_mshrs_7_io_resp_bits_uop_ctrl_is_sta),
    .io_resp_bits_uop_ctrl_is_std       (_mshrs_7_io_resp_bits_uop_ctrl_is_std),
    .io_resp_bits_uop_iw_state          (_mshrs_7_io_resp_bits_uop_iw_state),
    .io_resp_bits_uop_iw_p1_poisoned    (_mshrs_7_io_resp_bits_uop_iw_p1_poisoned),
    .io_resp_bits_uop_iw_p2_poisoned    (_mshrs_7_io_resp_bits_uop_iw_p2_poisoned),
    .io_resp_bits_uop_is_br             (_mshrs_7_io_resp_bits_uop_is_br),
    .io_resp_bits_uop_is_jalr           (_mshrs_7_io_resp_bits_uop_is_jalr),
    .io_resp_bits_uop_is_jal            (_mshrs_7_io_resp_bits_uop_is_jal),
    .io_resp_bits_uop_is_sfb            (_mshrs_7_io_resp_bits_uop_is_sfb),
    .io_resp_bits_uop_br_mask           (_mshrs_7_io_resp_bits_uop_br_mask),
    .io_resp_bits_uop_br_tag            (_mshrs_7_io_resp_bits_uop_br_tag),
    .io_resp_bits_uop_ftq_idx           (_mshrs_7_io_resp_bits_uop_ftq_idx),
    .io_resp_bits_uop_edge_inst         (_mshrs_7_io_resp_bits_uop_edge_inst),
    .io_resp_bits_uop_pc_lob            (_mshrs_7_io_resp_bits_uop_pc_lob),
    .io_resp_bits_uop_taken             (_mshrs_7_io_resp_bits_uop_taken),
    .io_resp_bits_uop_imm_packed        (_mshrs_7_io_resp_bits_uop_imm_packed),
    .io_resp_bits_uop_csr_addr          (_mshrs_7_io_resp_bits_uop_csr_addr),
    .io_resp_bits_uop_rob_idx           (_mshrs_7_io_resp_bits_uop_rob_idx),
    .io_resp_bits_uop_ldq_idx           (_mshrs_7_io_resp_bits_uop_ldq_idx),
    .io_resp_bits_uop_stq_idx           (_mshrs_7_io_resp_bits_uop_stq_idx),
    .io_resp_bits_uop_rxq_idx           (_mshrs_7_io_resp_bits_uop_rxq_idx),
    .io_resp_bits_uop_pdst              (_mshrs_7_io_resp_bits_uop_pdst),
    .io_resp_bits_uop_prs1              (_mshrs_7_io_resp_bits_uop_prs1),
    .io_resp_bits_uop_prs2              (_mshrs_7_io_resp_bits_uop_prs2),
    .io_resp_bits_uop_prs3              (_mshrs_7_io_resp_bits_uop_prs3),
    .io_resp_bits_uop_ppred             (_mshrs_7_io_resp_bits_uop_ppred),
    .io_resp_bits_uop_prs1_busy         (_mshrs_7_io_resp_bits_uop_prs1_busy),
    .io_resp_bits_uop_prs2_busy         (_mshrs_7_io_resp_bits_uop_prs2_busy),
    .io_resp_bits_uop_prs3_busy         (_mshrs_7_io_resp_bits_uop_prs3_busy),
    .io_resp_bits_uop_ppred_busy        (_mshrs_7_io_resp_bits_uop_ppred_busy),
    .io_resp_bits_uop_stale_pdst        (_mshrs_7_io_resp_bits_uop_stale_pdst),
    .io_resp_bits_uop_exception         (_mshrs_7_io_resp_bits_uop_exception),
    .io_resp_bits_uop_exc_cause         (_mshrs_7_io_resp_bits_uop_exc_cause),
    .io_resp_bits_uop_bypassable        (_mshrs_7_io_resp_bits_uop_bypassable),
    .io_resp_bits_uop_mem_cmd           (_mshrs_7_io_resp_bits_uop_mem_cmd),
    .io_resp_bits_uop_mem_size          (_mshrs_7_io_resp_bits_uop_mem_size),
    .io_resp_bits_uop_mem_signed        (_mshrs_7_io_resp_bits_uop_mem_signed),
    .io_resp_bits_uop_is_fence          (_mshrs_7_io_resp_bits_uop_is_fence),
    .io_resp_bits_uop_is_fencei         (_mshrs_7_io_resp_bits_uop_is_fencei),
    .io_resp_bits_uop_is_amo            (_mshrs_7_io_resp_bits_uop_is_amo),
    .io_resp_bits_uop_uses_ldq          (_mshrs_7_io_resp_bits_uop_uses_ldq),
    .io_resp_bits_uop_uses_stq          (_mshrs_7_io_resp_bits_uop_uses_stq),
    .io_resp_bits_uop_is_sys_pc2epc     (_mshrs_7_io_resp_bits_uop_is_sys_pc2epc),
    .io_resp_bits_uop_is_unique         (_mshrs_7_io_resp_bits_uop_is_unique),
    .io_resp_bits_uop_flush_on_commit   (_mshrs_7_io_resp_bits_uop_flush_on_commit),
    .io_resp_bits_uop_ldst_is_rs1       (_mshrs_7_io_resp_bits_uop_ldst_is_rs1),
    .io_resp_bits_uop_ldst              (_mshrs_7_io_resp_bits_uop_ldst),
    .io_resp_bits_uop_lrs1              (_mshrs_7_io_resp_bits_uop_lrs1),
    .io_resp_bits_uop_lrs2              (_mshrs_7_io_resp_bits_uop_lrs2),
    .io_resp_bits_uop_lrs3              (_mshrs_7_io_resp_bits_uop_lrs3),
    .io_resp_bits_uop_ldst_val          (_mshrs_7_io_resp_bits_uop_ldst_val),
    .io_resp_bits_uop_dst_rtype         (_mshrs_7_io_resp_bits_uop_dst_rtype),
    .io_resp_bits_uop_lrs1_rtype        (_mshrs_7_io_resp_bits_uop_lrs1_rtype),
    .io_resp_bits_uop_lrs2_rtype        (_mshrs_7_io_resp_bits_uop_lrs2_rtype),
    .io_resp_bits_uop_frs3_en           (_mshrs_7_io_resp_bits_uop_frs3_en),
    .io_resp_bits_uop_fp_val            (_mshrs_7_io_resp_bits_uop_fp_val),
    .io_resp_bits_uop_fp_single         (_mshrs_7_io_resp_bits_uop_fp_single),
    .io_resp_bits_uop_xcpt_pf_if        (_mshrs_7_io_resp_bits_uop_xcpt_pf_if),
    .io_resp_bits_uop_xcpt_ae_if        (_mshrs_7_io_resp_bits_uop_xcpt_ae_if),
    .io_resp_bits_uop_xcpt_ma_if        (_mshrs_7_io_resp_bits_uop_xcpt_ma_if),
    .io_resp_bits_uop_bp_debug_if       (_mshrs_7_io_resp_bits_uop_bp_debug_if),
    .io_resp_bits_uop_bp_xcpt_if        (_mshrs_7_io_resp_bits_uop_bp_xcpt_if),
    .io_resp_bits_uop_debug_fsrc        (_mshrs_7_io_resp_bits_uop_debug_fsrc),
    .io_resp_bits_uop_debug_tsrc        (_mshrs_7_io_resp_bits_uop_debug_tsrc),
    .io_resp_bits_data                  (_mshrs_7_io_resp_bits_data),
    .io_resp_bits_is_hella              (_mshrs_7_io_resp_bits_is_hella),
    .io_probe_rdy                       (_mshrs_7_io_probe_rdy)
  );
  Arbiter_11 mmio_alloc_arb (	// mshrs.scala:703:30
    .io_out_ready  (_GEN & ~cacheable),	// Parameters.scala:137:31, :671:42, mshrs.scala:732:{44,47}
    .io_in_0_ready (_mmio_alloc_arb_io_in_0_ready)
  );
  BoomIOMSHR mmios_0 (	// mshrs.scala:710:22
    .clock                            (clock),
    .reset                            (reset),
    .io_req_valid                     (_mmio_alloc_arb_io_in_0_ready),	// mshrs.scala:703:30
    .io_req_bits_uop_uopc             (_GEN_0),	// Parameters.scala:137:31
    .io_req_bits_uop_inst             (_GEN_1),	// Parameters.scala:137:31
    .io_req_bits_uop_debug_inst       (_GEN_2),	// Parameters.scala:137:31
    .io_req_bits_uop_is_rvc           (_GEN_3),	// Parameters.scala:137:31
    .io_req_bits_uop_debug_pc         (_GEN_4),	// Parameters.scala:137:31
    .io_req_bits_uop_iq_type          (_GEN_5),	// Parameters.scala:137:31
    .io_req_bits_uop_fu_code          (_GEN_6),	// Parameters.scala:137:31
    .io_req_bits_uop_ctrl_br_type     (_GEN_7),	// Parameters.scala:137:31
    .io_req_bits_uop_ctrl_op1_sel     (_GEN_8),	// Parameters.scala:137:31
    .io_req_bits_uop_ctrl_op2_sel     (_GEN_9),	// Parameters.scala:137:31
    .io_req_bits_uop_ctrl_imm_sel     (_GEN_10),	// Parameters.scala:137:31
    .io_req_bits_uop_ctrl_op_fcn      (_GEN_11),	// Parameters.scala:137:31
    .io_req_bits_uop_ctrl_fcn_dw      (_GEN_12),	// Parameters.scala:137:31
    .io_req_bits_uop_ctrl_csr_cmd     (_GEN_13),	// Parameters.scala:137:31
    .io_req_bits_uop_ctrl_is_load     (_GEN_14),	// Parameters.scala:137:31
    .io_req_bits_uop_ctrl_is_sta      (_GEN_15),	// Parameters.scala:137:31
    .io_req_bits_uop_ctrl_is_std      (_GEN_16),	// Parameters.scala:137:31
    .io_req_bits_uop_iw_state         (_GEN_17),	// Parameters.scala:137:31
    .io_req_bits_uop_iw_p1_poisoned   (_GEN_18),	// Parameters.scala:137:31
    .io_req_bits_uop_iw_p2_poisoned   (_GEN_19),	// Parameters.scala:137:31
    .io_req_bits_uop_is_br            (_GEN_20),	// Parameters.scala:137:31
    .io_req_bits_uop_is_jalr          (_GEN_21),	// Parameters.scala:137:31
    .io_req_bits_uop_is_jal           (_GEN_22),	// Parameters.scala:137:31
    .io_req_bits_uop_is_sfb           (_GEN_23),	// Parameters.scala:137:31
    .io_req_bits_uop_br_mask          (_GEN_24),	// Parameters.scala:137:31
    .io_req_bits_uop_br_tag           (_GEN_25),	// Parameters.scala:137:31
    .io_req_bits_uop_ftq_idx          (_GEN_26),	// Parameters.scala:137:31
    .io_req_bits_uop_edge_inst        (_GEN_27),	// Parameters.scala:137:31
    .io_req_bits_uop_pc_lob           (_GEN_28),	// Parameters.scala:137:31
    .io_req_bits_uop_taken            (_GEN_29),	// Parameters.scala:137:31
    .io_req_bits_uop_imm_packed       (_GEN_30),	// Parameters.scala:137:31
    .io_req_bits_uop_csr_addr         (_GEN_31),	// Parameters.scala:137:31
    .io_req_bits_uop_rob_idx          (_GEN_32),	// Parameters.scala:137:31
    .io_req_bits_uop_ldq_idx          (_GEN_33),	// Parameters.scala:137:31
    .io_req_bits_uop_stq_idx          (_GEN_34),	// Parameters.scala:137:31
    .io_req_bits_uop_rxq_idx          (_GEN_35),	// Parameters.scala:137:31
    .io_req_bits_uop_pdst             (_GEN_36),	// Parameters.scala:137:31
    .io_req_bits_uop_prs1             (_GEN_37),	// Parameters.scala:137:31
    .io_req_bits_uop_prs2             (_GEN_38),	// Parameters.scala:137:31
    .io_req_bits_uop_prs3             (_GEN_39),	// Parameters.scala:137:31
    .io_req_bits_uop_ppred            (_GEN_40),	// Parameters.scala:137:31
    .io_req_bits_uop_prs1_busy        (_GEN_41),	// Parameters.scala:137:31
    .io_req_bits_uop_prs2_busy        (_GEN_42),	// Parameters.scala:137:31
    .io_req_bits_uop_prs3_busy        (_GEN_43),	// Parameters.scala:137:31
    .io_req_bits_uop_ppred_busy       (_GEN_44),	// Parameters.scala:137:31
    .io_req_bits_uop_stale_pdst       (_GEN_45),	// Parameters.scala:137:31
    .io_req_bits_uop_exception        (_GEN_46),	// Parameters.scala:137:31
    .io_req_bits_uop_exc_cause        (_GEN_47),	// Parameters.scala:137:31
    .io_req_bits_uop_bypassable       (_GEN_48),	// Parameters.scala:137:31
    .io_req_bits_uop_mem_cmd          (_GEN_49),	// Parameters.scala:137:31
    .io_req_bits_uop_mem_size         (_GEN_50),	// Parameters.scala:137:31
    .io_req_bits_uop_mem_signed       (_GEN_51),	// Parameters.scala:137:31
    .io_req_bits_uop_is_fence         (_GEN_52),	// Parameters.scala:137:31
    .io_req_bits_uop_is_fencei        (_GEN_53),	// Parameters.scala:137:31
    .io_req_bits_uop_is_amo           (_GEN_54),	// Parameters.scala:137:31
    .io_req_bits_uop_uses_ldq         (_GEN_55),	// Parameters.scala:137:31
    .io_req_bits_uop_uses_stq         (_GEN_56),	// Parameters.scala:137:31
    .io_req_bits_uop_is_sys_pc2epc    (_GEN_57),	// Parameters.scala:137:31
    .io_req_bits_uop_is_unique        (_GEN_58),	// Parameters.scala:137:31
    .io_req_bits_uop_flush_on_commit  (_GEN_59),	// Parameters.scala:137:31
    .io_req_bits_uop_ldst_is_rs1      (_GEN_60),	// Parameters.scala:137:31
    .io_req_bits_uop_ldst             (_GEN_61),	// Parameters.scala:137:31
    .io_req_bits_uop_lrs1             (_GEN_62),	// Parameters.scala:137:31
    .io_req_bits_uop_lrs2             (_GEN_63),	// Parameters.scala:137:31
    .io_req_bits_uop_lrs3             (_GEN_64),	// Parameters.scala:137:31
    .io_req_bits_uop_ldst_val         (_GEN_65),	// Parameters.scala:137:31
    .io_req_bits_uop_dst_rtype        (_GEN_66),	// Parameters.scala:137:31
    .io_req_bits_uop_lrs1_rtype       (_GEN_67),	// Parameters.scala:137:31
    .io_req_bits_uop_lrs2_rtype       (_GEN_68),	// Parameters.scala:137:31
    .io_req_bits_uop_frs3_en          (_GEN_69),	// Parameters.scala:137:31
    .io_req_bits_uop_fp_val           (_GEN_70),	// Parameters.scala:137:31
    .io_req_bits_uop_fp_single        (_GEN_71),	// Parameters.scala:137:31
    .io_req_bits_uop_xcpt_pf_if       (_GEN_72),	// Parameters.scala:137:31
    .io_req_bits_uop_xcpt_ae_if       (_GEN_73),	// Parameters.scala:137:31
    .io_req_bits_uop_xcpt_ma_if       (_GEN_74),	// Parameters.scala:137:31
    .io_req_bits_uop_bp_debug_if      (_GEN_75),	// Parameters.scala:137:31
    .io_req_bits_uop_bp_xcpt_if       (_GEN_76),	// Parameters.scala:137:31
    .io_req_bits_uop_debug_fsrc       (_GEN_77),	// Parameters.scala:137:31
    .io_req_bits_uop_debug_tsrc       (_GEN_78),	// Parameters.scala:137:31
    .io_req_bits_addr                 (_cacheable_T_1),	// Parameters.scala:137:31
    .io_req_bits_data                 (_GEN_79),	// Parameters.scala:137:31
    .io_resp_ready                    (_resp_arb_io_in_8_ready),	// mshrs.scala:603:30
    .io_mem_access_ready
      (io_mem_acquire_ready & (idle ? ~_GEN_111 : state_8)),	// Arbiter.scala:16:61, :88:28, :116:26, :121:24, :123:31, package.scala:244:43
    .io_mem_ack_valid                 (io_mem_grant_valid & _mshr_io_mem_ack_valid_T),	// mshrs.scala:720:{49,77}
    .io_mem_ack_bits_data             (io_mem_grant_bits_data),
    .io_req_ready                     (_mmios_0_io_req_ready),
    .io_resp_valid                    (_mmios_0_io_resp_valid),
    .io_resp_bits_uop_uopc            (_mmios_0_io_resp_bits_uop_uopc),
    .io_resp_bits_uop_inst            (_mmios_0_io_resp_bits_uop_inst),
    .io_resp_bits_uop_debug_inst      (_mmios_0_io_resp_bits_uop_debug_inst),
    .io_resp_bits_uop_is_rvc          (_mmios_0_io_resp_bits_uop_is_rvc),
    .io_resp_bits_uop_debug_pc        (_mmios_0_io_resp_bits_uop_debug_pc),
    .io_resp_bits_uop_iq_type         (_mmios_0_io_resp_bits_uop_iq_type),
    .io_resp_bits_uop_fu_code         (_mmios_0_io_resp_bits_uop_fu_code),
    .io_resp_bits_uop_ctrl_br_type    (_mmios_0_io_resp_bits_uop_ctrl_br_type),
    .io_resp_bits_uop_ctrl_op1_sel    (_mmios_0_io_resp_bits_uop_ctrl_op1_sel),
    .io_resp_bits_uop_ctrl_op2_sel    (_mmios_0_io_resp_bits_uop_ctrl_op2_sel),
    .io_resp_bits_uop_ctrl_imm_sel    (_mmios_0_io_resp_bits_uop_ctrl_imm_sel),
    .io_resp_bits_uop_ctrl_op_fcn     (_mmios_0_io_resp_bits_uop_ctrl_op_fcn),
    .io_resp_bits_uop_ctrl_fcn_dw     (_mmios_0_io_resp_bits_uop_ctrl_fcn_dw),
    .io_resp_bits_uop_ctrl_csr_cmd    (_mmios_0_io_resp_bits_uop_ctrl_csr_cmd),
    .io_resp_bits_uop_ctrl_is_load    (_mmios_0_io_resp_bits_uop_ctrl_is_load),
    .io_resp_bits_uop_ctrl_is_sta     (_mmios_0_io_resp_bits_uop_ctrl_is_sta),
    .io_resp_bits_uop_ctrl_is_std     (_mmios_0_io_resp_bits_uop_ctrl_is_std),
    .io_resp_bits_uop_iw_state        (_mmios_0_io_resp_bits_uop_iw_state),
    .io_resp_bits_uop_iw_p1_poisoned  (_mmios_0_io_resp_bits_uop_iw_p1_poisoned),
    .io_resp_bits_uop_iw_p2_poisoned  (_mmios_0_io_resp_bits_uop_iw_p2_poisoned),
    .io_resp_bits_uop_is_br           (_mmios_0_io_resp_bits_uop_is_br),
    .io_resp_bits_uop_is_jalr         (_mmios_0_io_resp_bits_uop_is_jalr),
    .io_resp_bits_uop_is_jal          (_mmios_0_io_resp_bits_uop_is_jal),
    .io_resp_bits_uop_is_sfb          (_mmios_0_io_resp_bits_uop_is_sfb),
    .io_resp_bits_uop_br_mask         (_mmios_0_io_resp_bits_uop_br_mask),
    .io_resp_bits_uop_br_tag          (_mmios_0_io_resp_bits_uop_br_tag),
    .io_resp_bits_uop_ftq_idx         (_mmios_0_io_resp_bits_uop_ftq_idx),
    .io_resp_bits_uop_edge_inst       (_mmios_0_io_resp_bits_uop_edge_inst),
    .io_resp_bits_uop_pc_lob          (_mmios_0_io_resp_bits_uop_pc_lob),
    .io_resp_bits_uop_taken           (_mmios_0_io_resp_bits_uop_taken),
    .io_resp_bits_uop_imm_packed      (_mmios_0_io_resp_bits_uop_imm_packed),
    .io_resp_bits_uop_csr_addr        (_mmios_0_io_resp_bits_uop_csr_addr),
    .io_resp_bits_uop_rob_idx         (_mmios_0_io_resp_bits_uop_rob_idx),
    .io_resp_bits_uop_ldq_idx         (_mmios_0_io_resp_bits_uop_ldq_idx),
    .io_resp_bits_uop_stq_idx         (_mmios_0_io_resp_bits_uop_stq_idx),
    .io_resp_bits_uop_rxq_idx         (_mmios_0_io_resp_bits_uop_rxq_idx),
    .io_resp_bits_uop_pdst            (_mmios_0_io_resp_bits_uop_pdst),
    .io_resp_bits_uop_prs1            (_mmios_0_io_resp_bits_uop_prs1),
    .io_resp_bits_uop_prs2            (_mmios_0_io_resp_bits_uop_prs2),
    .io_resp_bits_uop_prs3            (_mmios_0_io_resp_bits_uop_prs3),
    .io_resp_bits_uop_ppred           (_mmios_0_io_resp_bits_uop_ppred),
    .io_resp_bits_uop_prs1_busy       (_mmios_0_io_resp_bits_uop_prs1_busy),
    .io_resp_bits_uop_prs2_busy       (_mmios_0_io_resp_bits_uop_prs2_busy),
    .io_resp_bits_uop_prs3_busy       (_mmios_0_io_resp_bits_uop_prs3_busy),
    .io_resp_bits_uop_ppred_busy      (_mmios_0_io_resp_bits_uop_ppred_busy),
    .io_resp_bits_uop_stale_pdst      (_mmios_0_io_resp_bits_uop_stale_pdst),
    .io_resp_bits_uop_exception       (_mmios_0_io_resp_bits_uop_exception),
    .io_resp_bits_uop_exc_cause       (_mmios_0_io_resp_bits_uop_exc_cause),
    .io_resp_bits_uop_bypassable      (_mmios_0_io_resp_bits_uop_bypassable),
    .io_resp_bits_uop_mem_cmd         (_mmios_0_io_resp_bits_uop_mem_cmd),
    .io_resp_bits_uop_mem_size        (_mmios_0_io_resp_bits_uop_mem_size),
    .io_resp_bits_uop_mem_signed      (_mmios_0_io_resp_bits_uop_mem_signed),
    .io_resp_bits_uop_is_fence        (_mmios_0_io_resp_bits_uop_is_fence),
    .io_resp_bits_uop_is_fencei       (_mmios_0_io_resp_bits_uop_is_fencei),
    .io_resp_bits_uop_is_amo          (_mmios_0_io_resp_bits_uop_is_amo),
    .io_resp_bits_uop_uses_ldq        (_mmios_0_io_resp_bits_uop_uses_ldq),
    .io_resp_bits_uop_uses_stq        (_mmios_0_io_resp_bits_uop_uses_stq),
    .io_resp_bits_uop_is_sys_pc2epc   (_mmios_0_io_resp_bits_uop_is_sys_pc2epc),
    .io_resp_bits_uop_is_unique       (_mmios_0_io_resp_bits_uop_is_unique),
    .io_resp_bits_uop_flush_on_commit (_mmios_0_io_resp_bits_uop_flush_on_commit),
    .io_resp_bits_uop_ldst_is_rs1     (_mmios_0_io_resp_bits_uop_ldst_is_rs1),
    .io_resp_bits_uop_ldst            (_mmios_0_io_resp_bits_uop_ldst),
    .io_resp_bits_uop_lrs1            (_mmios_0_io_resp_bits_uop_lrs1),
    .io_resp_bits_uop_lrs2            (_mmios_0_io_resp_bits_uop_lrs2),
    .io_resp_bits_uop_lrs3            (_mmios_0_io_resp_bits_uop_lrs3),
    .io_resp_bits_uop_ldst_val        (_mmios_0_io_resp_bits_uop_ldst_val),
    .io_resp_bits_uop_dst_rtype       (_mmios_0_io_resp_bits_uop_dst_rtype),
    .io_resp_bits_uop_lrs1_rtype      (_mmios_0_io_resp_bits_uop_lrs1_rtype),
    .io_resp_bits_uop_lrs2_rtype      (_mmios_0_io_resp_bits_uop_lrs2_rtype),
    .io_resp_bits_uop_frs3_en         (_mmios_0_io_resp_bits_uop_frs3_en),
    .io_resp_bits_uop_fp_val          (_mmios_0_io_resp_bits_uop_fp_val),
    .io_resp_bits_uop_fp_single       (_mmios_0_io_resp_bits_uop_fp_single),
    .io_resp_bits_uop_xcpt_pf_if      (_mmios_0_io_resp_bits_uop_xcpt_pf_if),
    .io_resp_bits_uop_xcpt_ae_if      (_mmios_0_io_resp_bits_uop_xcpt_ae_if),
    .io_resp_bits_uop_xcpt_ma_if      (_mmios_0_io_resp_bits_uop_xcpt_ma_if),
    .io_resp_bits_uop_bp_debug_if     (_mmios_0_io_resp_bits_uop_bp_debug_if),
    .io_resp_bits_uop_bp_xcpt_if      (_mmios_0_io_resp_bits_uop_bp_xcpt_if),
    .io_resp_bits_uop_debug_fsrc      (_mmios_0_io_resp_bits_uop_debug_fsrc),
    .io_resp_bits_uop_debug_tsrc      (_mmios_0_io_resp_bits_uop_debug_tsrc),
    .io_resp_bits_data                (_mmios_0_io_resp_bits_data),
    .io_mem_access_valid              (_mmios_0_io_mem_access_valid),
    .io_mem_access_bits_opcode        (_mmios_0_io_mem_access_bits_opcode),
    .io_mem_access_bits_param         (_mmios_0_io_mem_access_bits_param),
    .io_mem_access_bits_size          (_mmios_0_io_mem_access_bits_size),
    .io_mem_access_bits_source        (_mmios_0_io_mem_access_bits_source),
    .io_mem_access_bits_address       (_mmios_0_io_mem_access_bits_address),
    .io_mem_access_bits_mask          (_mmios_0_io_mem_access_bits_mask),
    .io_mem_access_bits_data          (_mmios_0_io_mem_access_bits_data)
  );
  BranchKillableQueue_8 respq (	// mshrs.scala:737:21
    .clock                           (clock),
    .reset                           (reset),
    .io_enq_valid                    (_resp_arb_io_out_valid),	// mshrs.scala:603:30
    .io_enq_bits_uop_uopc            (_resp_arb_io_out_bits_uop_uopc),	// mshrs.scala:603:30
    .io_enq_bits_uop_inst            (_resp_arb_io_out_bits_uop_inst),	// mshrs.scala:603:30
    .io_enq_bits_uop_debug_inst      (_resp_arb_io_out_bits_uop_debug_inst),	// mshrs.scala:603:30
    .io_enq_bits_uop_is_rvc          (_resp_arb_io_out_bits_uop_is_rvc),	// mshrs.scala:603:30
    .io_enq_bits_uop_debug_pc        (_resp_arb_io_out_bits_uop_debug_pc),	// mshrs.scala:603:30
    .io_enq_bits_uop_iq_type         (_resp_arb_io_out_bits_uop_iq_type),	// mshrs.scala:603:30
    .io_enq_bits_uop_fu_code         (_resp_arb_io_out_bits_uop_fu_code),	// mshrs.scala:603:30
    .io_enq_bits_uop_ctrl_br_type    (_resp_arb_io_out_bits_uop_ctrl_br_type),	// mshrs.scala:603:30
    .io_enq_bits_uop_ctrl_op1_sel    (_resp_arb_io_out_bits_uop_ctrl_op1_sel),	// mshrs.scala:603:30
    .io_enq_bits_uop_ctrl_op2_sel    (_resp_arb_io_out_bits_uop_ctrl_op2_sel),	// mshrs.scala:603:30
    .io_enq_bits_uop_ctrl_imm_sel    (_resp_arb_io_out_bits_uop_ctrl_imm_sel),	// mshrs.scala:603:30
    .io_enq_bits_uop_ctrl_op_fcn     (_resp_arb_io_out_bits_uop_ctrl_op_fcn),	// mshrs.scala:603:30
    .io_enq_bits_uop_ctrl_fcn_dw     (_resp_arb_io_out_bits_uop_ctrl_fcn_dw),	// mshrs.scala:603:30
    .io_enq_bits_uop_ctrl_csr_cmd    (_resp_arb_io_out_bits_uop_ctrl_csr_cmd),	// mshrs.scala:603:30
    .io_enq_bits_uop_ctrl_is_load    (_resp_arb_io_out_bits_uop_ctrl_is_load),	// mshrs.scala:603:30
    .io_enq_bits_uop_ctrl_is_sta     (_resp_arb_io_out_bits_uop_ctrl_is_sta),	// mshrs.scala:603:30
    .io_enq_bits_uop_ctrl_is_std     (_resp_arb_io_out_bits_uop_ctrl_is_std),	// mshrs.scala:603:30
    .io_enq_bits_uop_iw_state        (_resp_arb_io_out_bits_uop_iw_state),	// mshrs.scala:603:30
    .io_enq_bits_uop_iw_p1_poisoned  (_resp_arb_io_out_bits_uop_iw_p1_poisoned),	// mshrs.scala:603:30
    .io_enq_bits_uop_iw_p2_poisoned  (_resp_arb_io_out_bits_uop_iw_p2_poisoned),	// mshrs.scala:603:30
    .io_enq_bits_uop_is_br           (_resp_arb_io_out_bits_uop_is_br),	// mshrs.scala:603:30
    .io_enq_bits_uop_is_jalr         (_resp_arb_io_out_bits_uop_is_jalr),	// mshrs.scala:603:30
    .io_enq_bits_uop_is_jal          (_resp_arb_io_out_bits_uop_is_jal),	// mshrs.scala:603:30
    .io_enq_bits_uop_is_sfb          (_resp_arb_io_out_bits_uop_is_sfb),	// mshrs.scala:603:30
    .io_enq_bits_uop_br_mask         (_resp_arb_io_out_bits_uop_br_mask),	// mshrs.scala:603:30
    .io_enq_bits_uop_br_tag          (_resp_arb_io_out_bits_uop_br_tag),	// mshrs.scala:603:30
    .io_enq_bits_uop_ftq_idx         (_resp_arb_io_out_bits_uop_ftq_idx),	// mshrs.scala:603:30
    .io_enq_bits_uop_edge_inst       (_resp_arb_io_out_bits_uop_edge_inst),	// mshrs.scala:603:30
    .io_enq_bits_uop_pc_lob          (_resp_arb_io_out_bits_uop_pc_lob),	// mshrs.scala:603:30
    .io_enq_bits_uop_taken           (_resp_arb_io_out_bits_uop_taken),	// mshrs.scala:603:30
    .io_enq_bits_uop_imm_packed      (_resp_arb_io_out_bits_uop_imm_packed),	// mshrs.scala:603:30
    .io_enq_bits_uop_csr_addr        (_resp_arb_io_out_bits_uop_csr_addr),	// mshrs.scala:603:30
    .io_enq_bits_uop_rob_idx         (_resp_arb_io_out_bits_uop_rob_idx),	// mshrs.scala:603:30
    .io_enq_bits_uop_ldq_idx         (_resp_arb_io_out_bits_uop_ldq_idx),	// mshrs.scala:603:30
    .io_enq_bits_uop_stq_idx         (_resp_arb_io_out_bits_uop_stq_idx),	// mshrs.scala:603:30
    .io_enq_bits_uop_rxq_idx         (_resp_arb_io_out_bits_uop_rxq_idx),	// mshrs.scala:603:30
    .io_enq_bits_uop_pdst            (_resp_arb_io_out_bits_uop_pdst),	// mshrs.scala:603:30
    .io_enq_bits_uop_prs1            (_resp_arb_io_out_bits_uop_prs1),	// mshrs.scala:603:30
    .io_enq_bits_uop_prs2            (_resp_arb_io_out_bits_uop_prs2),	// mshrs.scala:603:30
    .io_enq_bits_uop_prs3            (_resp_arb_io_out_bits_uop_prs3),	// mshrs.scala:603:30
    .io_enq_bits_uop_ppred           (_resp_arb_io_out_bits_uop_ppred),	// mshrs.scala:603:30
    .io_enq_bits_uop_prs1_busy       (_resp_arb_io_out_bits_uop_prs1_busy),	// mshrs.scala:603:30
    .io_enq_bits_uop_prs2_busy       (_resp_arb_io_out_bits_uop_prs2_busy),	// mshrs.scala:603:30
    .io_enq_bits_uop_prs3_busy       (_resp_arb_io_out_bits_uop_prs3_busy),	// mshrs.scala:603:30
    .io_enq_bits_uop_ppred_busy      (_resp_arb_io_out_bits_uop_ppred_busy),	// mshrs.scala:603:30
    .io_enq_bits_uop_stale_pdst      (_resp_arb_io_out_bits_uop_stale_pdst),	// mshrs.scala:603:30
    .io_enq_bits_uop_exception       (_resp_arb_io_out_bits_uop_exception),	// mshrs.scala:603:30
    .io_enq_bits_uop_exc_cause       (_resp_arb_io_out_bits_uop_exc_cause),	// mshrs.scala:603:30
    .io_enq_bits_uop_bypassable      (_resp_arb_io_out_bits_uop_bypassable),	// mshrs.scala:603:30
    .io_enq_bits_uop_mem_cmd         (_resp_arb_io_out_bits_uop_mem_cmd),	// mshrs.scala:603:30
    .io_enq_bits_uop_mem_size        (_resp_arb_io_out_bits_uop_mem_size),	// mshrs.scala:603:30
    .io_enq_bits_uop_mem_signed      (_resp_arb_io_out_bits_uop_mem_signed),	// mshrs.scala:603:30
    .io_enq_bits_uop_is_fence        (_resp_arb_io_out_bits_uop_is_fence),	// mshrs.scala:603:30
    .io_enq_bits_uop_is_fencei       (_resp_arb_io_out_bits_uop_is_fencei),	// mshrs.scala:603:30
    .io_enq_bits_uop_is_amo          (_resp_arb_io_out_bits_uop_is_amo),	// mshrs.scala:603:30
    .io_enq_bits_uop_uses_ldq        (_resp_arb_io_out_bits_uop_uses_ldq),	// mshrs.scala:603:30
    .io_enq_bits_uop_uses_stq        (_resp_arb_io_out_bits_uop_uses_stq),	// mshrs.scala:603:30
    .io_enq_bits_uop_is_sys_pc2epc   (_resp_arb_io_out_bits_uop_is_sys_pc2epc),	// mshrs.scala:603:30
    .io_enq_bits_uop_is_unique       (_resp_arb_io_out_bits_uop_is_unique),	// mshrs.scala:603:30
    .io_enq_bits_uop_flush_on_commit (_resp_arb_io_out_bits_uop_flush_on_commit),	// mshrs.scala:603:30
    .io_enq_bits_uop_ldst_is_rs1     (_resp_arb_io_out_bits_uop_ldst_is_rs1),	// mshrs.scala:603:30
    .io_enq_bits_uop_ldst            (_resp_arb_io_out_bits_uop_ldst),	// mshrs.scala:603:30
    .io_enq_bits_uop_lrs1            (_resp_arb_io_out_bits_uop_lrs1),	// mshrs.scala:603:30
    .io_enq_bits_uop_lrs2            (_resp_arb_io_out_bits_uop_lrs2),	// mshrs.scala:603:30
    .io_enq_bits_uop_lrs3            (_resp_arb_io_out_bits_uop_lrs3),	// mshrs.scala:603:30
    .io_enq_bits_uop_ldst_val        (_resp_arb_io_out_bits_uop_ldst_val),	// mshrs.scala:603:30
    .io_enq_bits_uop_dst_rtype       (_resp_arb_io_out_bits_uop_dst_rtype),	// mshrs.scala:603:30
    .io_enq_bits_uop_lrs1_rtype      (_resp_arb_io_out_bits_uop_lrs1_rtype),	// mshrs.scala:603:30
    .io_enq_bits_uop_lrs2_rtype      (_resp_arb_io_out_bits_uop_lrs2_rtype),	// mshrs.scala:603:30
    .io_enq_bits_uop_frs3_en         (_resp_arb_io_out_bits_uop_frs3_en),	// mshrs.scala:603:30
    .io_enq_bits_uop_fp_val          (_resp_arb_io_out_bits_uop_fp_val),	// mshrs.scala:603:30
    .io_enq_bits_uop_fp_single       (_resp_arb_io_out_bits_uop_fp_single),	// mshrs.scala:603:30
    .io_enq_bits_uop_xcpt_pf_if      (_resp_arb_io_out_bits_uop_xcpt_pf_if),	// mshrs.scala:603:30
    .io_enq_bits_uop_xcpt_ae_if      (_resp_arb_io_out_bits_uop_xcpt_ae_if),	// mshrs.scala:603:30
    .io_enq_bits_uop_xcpt_ma_if      (_resp_arb_io_out_bits_uop_xcpt_ma_if),	// mshrs.scala:603:30
    .io_enq_bits_uop_bp_debug_if     (_resp_arb_io_out_bits_uop_bp_debug_if),	// mshrs.scala:603:30
    .io_enq_bits_uop_bp_xcpt_if      (_resp_arb_io_out_bits_uop_bp_xcpt_if),	// mshrs.scala:603:30
    .io_enq_bits_uop_debug_fsrc      (_resp_arb_io_out_bits_uop_debug_fsrc),	// mshrs.scala:603:30
    .io_enq_bits_uop_debug_tsrc      (_resp_arb_io_out_bits_uop_debug_tsrc),	// mshrs.scala:603:30
    .io_enq_bits_data                (_resp_arb_io_out_bits_data),	// mshrs.scala:603:30
    .io_enq_bits_is_hella            (_resp_arb_io_out_bits_is_hella),	// mshrs.scala:603:30
    .io_deq_ready                    (io_resp_ready),
    .io_brupdate_b1_resolve_mask     (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask  (io_brupdate_b1_mispredict_mask),
    .io_flush                        (io_exception),
    .io_enq_ready                    (_respq_io_enq_ready),
    .io_deq_valid                    (io_resp_valid),
    .io_deq_bits_uop_br_mask         (io_resp_bits_uop_br_mask),
    .io_deq_bits_uop_ldq_idx         (io_resp_bits_uop_ldq_idx),
    .io_deq_bits_uop_stq_idx         (io_resp_bits_uop_stq_idx),
    .io_deq_bits_uop_is_amo          (io_resp_bits_uop_is_amo),
    .io_deq_bits_uop_uses_ldq        (io_resp_bits_uop_uses_ldq),
    .io_deq_bits_uop_uses_stq        (io_resp_bits_uop_uses_stq),
    .io_deq_bits_data                (io_resp_bits_data),
    .io_deq_bits_is_hella            (io_resp_bits_is_hella)
  );
  assign io_req_0_ready = _io_req_0_ready_output;	// mshrs.scala:744:47
  assign io_req_1_ready = _io_req_1_ready_output;	// mshrs.scala:744:47
  assign io_secondary_miss_0 =
    idx_match_0
    & (idx_matches_0_0 & _mshrs_0_io_way_valid & _way_matches_0_0_T | idx_matches_0_1
       & _mshrs_1_io_way_valid & _way_matches_0_1_T | idx_matches_0_2
       & _mshrs_2_io_way_valid & _way_matches_0_2_T | idx_matches_0_3
       & _mshrs_3_io_way_valid & _way_matches_0_3_T | idx_matches_0_4
       & _mshrs_4_io_way_valid & _way_matches_0_4_T | idx_matches_0_5
       & _mshrs_5_io_way_valid & _way_matches_0_5_T | idx_matches_0_6
       & _mshrs_6_io_way_valid & _way_matches_0_6_T | idx_matches_0_7
       & _mshrs_7_io_way_valid & _way_matches_0_7_T) & ~tag_match_0;	// Mux.scala:27:72, mshrs.scala:594:58, :620:22, :624:46, :626:66, :746:{58,61}
  assign io_secondary_miss_1 =
    idx_match_1
    & (idx_matches_1_0 & _mshrs_0_io_way_valid & _way_matches_1_0_T | idx_matches_1_1
       & _mshrs_1_io_way_valid & _way_matches_1_1_T | idx_matches_1_2
       & _mshrs_2_io_way_valid & _way_matches_1_2_T | idx_matches_1_3
       & _mshrs_3_io_way_valid & _way_matches_1_3_T | idx_matches_1_4
       & _mshrs_4_io_way_valid & _way_matches_1_4_T | idx_matches_1_5
       & _mshrs_5_io_way_valid & _way_matches_1_5_T | idx_matches_1_6
       & _mshrs_6_io_way_valid & _way_matches_1_6_T | idx_matches_1_7
       & _mshrs_7_io_way_valid & _way_matches_1_7_T) & ~tag_match_1;	// Mux.scala:27:72, mshrs.scala:594:58, :620:22, :624:46, :626:66, :746:{58,61}
  assign io_block_hit_0 = idx_match_0 & tag_match_0;	// Mux.scala:27:72, mshrs.scala:594:58, :747:42
  assign io_block_hit_1 = idx_match_1 & tag_match_1;	// Mux.scala:27:72, mshrs.scala:594:58, :747:42
  assign io_mem_acquire_valid = out_9_valid;	// Arbiter.scala:125:29
  assign io_mem_acquire_bits_opcode =
    (_GEN_115 ? 3'h6 : 3'h0)
    | (muxStateEarly_8 ? _mmios_0_io_mem_access_bits_opcode : 3'h0);	// Arbiter.scala:117:30, Mux.scala:27:72, ReadyValidCancel.scala:70:19, mshrs.scala:620:22, :621:16, :710:22
  assign io_mem_acquire_bits_param =
    (muxStateEarly_0 ? _mshrs_0_io_mem_acquire_bits_param : 3'h0)
    | (muxStateEarly_1 ? _mshrs_1_io_mem_acquire_bits_param : 3'h0)
    | (muxStateEarly_2 ? _mshrs_2_io_mem_acquire_bits_param : 3'h0)
    | (muxStateEarly_3 ? _mshrs_3_io_mem_acquire_bits_param : 3'h0)
    | (muxStateEarly_4 ? _mshrs_4_io_mem_acquire_bits_param : 3'h0)
    | (muxStateEarly_5 ? _mshrs_5_io_mem_acquire_bits_param : 3'h0)
    | (muxStateEarly_6 ? _mshrs_6_io_mem_acquire_bits_param : 3'h0)
    | (muxStateEarly_7 ? _mshrs_7_io_mem_acquire_bits_param : 3'h0)
    | (muxStateEarly_8 ? _mmios_0_io_mem_access_bits_param : 3'h0);	// Arbiter.scala:117:30, Mux.scala:27:72, mshrs.scala:620:22, :621:16, :710:22
  assign io_mem_acquire_bits_size =
    (_GEN_115 ? 4'h6 : 4'h0)
    | (muxStateEarly_8 ? _mmios_0_io_mem_access_bits_size : 4'h0);	// Arbiter.scala:117:30, Mux.scala:27:72, :47:69, ReadyValidCancel.scala:70:19, mshrs.scala:620:22, :710:22
  assign io_mem_acquire_bits_source =
    (muxStateEarly_0 ? _mshrs_0_io_mem_acquire_bits_source : 4'h0)
    | (muxStateEarly_1 ? _mshrs_1_io_mem_acquire_bits_source : 4'h0)
    | (muxStateEarly_2 ? _mshrs_2_io_mem_acquire_bits_source : 4'h0)
    | (muxStateEarly_3 ? _mshrs_3_io_mem_acquire_bits_source : 4'h0)
    | (muxStateEarly_4 ? _mshrs_4_io_mem_acquire_bits_source : 4'h0)
    | (muxStateEarly_5 ? _mshrs_5_io_mem_acquire_bits_source : 4'h0)
    | (muxStateEarly_6 ? _mshrs_6_io_mem_acquire_bits_source : 4'h0)
    | (muxStateEarly_7 ? _mshrs_7_io_mem_acquire_bits_source : 4'h0)
    | (muxStateEarly_8 ? _mmios_0_io_mem_access_bits_source : 4'h0);	// Arbiter.scala:117:30, Mux.scala:27:72, :47:69, mshrs.scala:620:22, :710:22
  assign io_mem_acquire_bits_address =
    (muxStateEarly_0 ? _mshrs_0_io_mem_acquire_bits_address : 32'h0)
    | (muxStateEarly_1 ? _mshrs_1_io_mem_acquire_bits_address : 32'h0)
    | (muxStateEarly_2 ? _mshrs_2_io_mem_acquire_bits_address : 32'h0)
    | (muxStateEarly_3 ? _mshrs_3_io_mem_acquire_bits_address : 32'h0)
    | (muxStateEarly_4 ? _mshrs_4_io_mem_acquire_bits_address : 32'h0)
    | (muxStateEarly_5 ? _mshrs_5_io_mem_acquire_bits_address : 32'h0)
    | (muxStateEarly_6 ? _mshrs_6_io_mem_acquire_bits_address : 32'h0)
    | (muxStateEarly_7 ? _mshrs_7_io_mem_acquire_bits_address : 32'h0)
    | (muxStateEarly_8 ? _mmios_0_io_mem_access_bits_address : 32'h0);	// Arbiter.scala:117:30, Mux.scala:27:72, mshrs.scala:620:22, :710:22
  assign io_mem_acquire_bits_mask =
    {8{muxStateEarly_0}} | {8{muxStateEarly_1}} | {8{muxStateEarly_2}}
    | {8{muxStateEarly_3}} | {8{muxStateEarly_4}} | {8{muxStateEarly_5}}
    | {8{muxStateEarly_6}} | {8{muxStateEarly_7}}
    | (muxStateEarly_8 ? _mmios_0_io_mem_access_bits_mask : 8'h0);	// Arbiter.scala:117:30, Mux.scala:27:72, mshrs.scala:710:22
  assign io_mem_acquire_bits_data =
    muxStateEarly_8 ? _mmios_0_io_mem_access_bits_data : 64'h0;	// Arbiter.scala:117:30, Mux.scala:27:72, mshrs.scala:545:65, :620:22, :710:22
  assign io_mem_grant_ready =
    _mshr_io_mem_ack_valid_T
    | (_GEN_103
         ? _mshrs_7_io_mem_grant_ready
         : _GEN_101
             ? _mshrs_6_io_mem_grant_ready
             : _GEN_100
                 ? _mshrs_5_io_mem_grant_ready
                 : _GEN_99
                     ? _mshrs_4_io_mem_grant_ready
                     : _GEN_98
                         ? _mshrs_3_io_mem_grant_ready
                         : _GEN_97
                             ? _mshrs_2_io_mem_grant_ready
                             : _GEN_96
                                 ? _mshrs_1_io_mem_grant_ready
                                 : _GEN_95 & _mshrs_0_io_mem_grant_ready);	// mshrs.scala:614:22, :620:22, :673:{36,45}, :674:25, :720:77, :721:46, :722:26
  assign io_mem_finish_valid = out_18_valid;	// Arbiter.scala:125:29
  assign io_mem_finish_bits_sink =
    ((beatsLeft_1 ? state_1_0 : _mshrs_0_io_mem_finish_valid)
       ? _mshrs_0_io_mem_finish_bits_sink
       : 3'h0)
    | ((beatsLeft_1 ? state_1_1 : earlyWinner_1_1)
         ? _mshrs_1_io_mem_finish_bits_sink
         : 3'h0)
    | ((beatsLeft_1 ? state_1_2 : earlyWinner_1_2)
         ? _mshrs_2_io_mem_finish_bits_sink
         : 3'h0)
    | ((beatsLeft_1 ? state_1_3 : earlyWinner_1_3)
         ? _mshrs_3_io_mem_finish_bits_sink
         : 3'h0)
    | ((beatsLeft_1 ? state_1_4 : earlyWinner_1_4)
         ? _mshrs_4_io_mem_finish_bits_sink
         : 3'h0)
    | ((beatsLeft_1 ? state_1_5 : earlyWinner_1_5)
         ? _mshrs_5_io_mem_finish_bits_sink
         : 3'h0)
    | ((beatsLeft_1 ? state_1_6 : earlyWinner_1_6)
         ? _mshrs_6_io_mem_finish_bits_sink
         : 3'h0)
    | ((beatsLeft_1 ? state_1_7 : earlyWinner_1_7)
         ? _mshrs_7_io_mem_finish_bits_sink
         : 3'h0);	// Arbiter.scala:87:30, :97:79, :116:26, :117:30, Mux.scala:27:72, mshrs.scala:620:22, :621:16
  assign io_replay_valid = _replay_arb_io_out_valid;	// mshrs.scala:602:30
  assign io_replay_bits_uop_mem_cmd = _replay_arb_io_out_bits_uop_mem_cmd;	// mshrs.scala:602:30
  assign io_fence_rdy =
    ~(~_mmios_0_io_req_ready | ~_mshrs_7_io_req_pri_rdy | ~_mshrs_6_io_req_pri_rdy
      | ~_mshrs_5_io_req_pri_rdy | ~_mshrs_4_io_req_pri_rdy | ~_mshrs_3_io_req_pri_rdy
      | ~_mshrs_2_io_req_pri_rdy | ~_mshrs_1_io_req_pri_rdy) & _mshrs_0_io_req_pri_rdy;	// mshrs.scala:620:22, :680:{11,33}, :681:20, :710:22, :726:{11,31}, :727:20
  assign io_probe_rdy =
    ~(~_mshrs_7_io_probe_rdy & idx_matches_1_7 & io_req_is_probe_1
      | ~_mshrs_7_io_probe_rdy & idx_matches_0_7 & io_req_is_probe_0
      | ~_mshrs_6_io_probe_rdy & idx_matches_1_6 & io_req_is_probe_1
      | ~_mshrs_6_io_probe_rdy & idx_matches_0_6 & io_req_is_probe_0
      | ~_mshrs_5_io_probe_rdy & idx_matches_1_5 & io_req_is_probe_1
      | ~_mshrs_5_io_probe_rdy & idx_matches_0_5 & io_req_is_probe_0
      | ~_mshrs_4_io_probe_rdy & idx_matches_1_4 & io_req_is_probe_1
      | ~_mshrs_4_io_probe_rdy & idx_matches_0_4 & io_req_is_probe_0
      | ~_mshrs_3_io_probe_rdy & idx_matches_1_3 & io_req_is_probe_1
      | ~_mshrs_3_io_probe_rdy & idx_matches_0_3 & io_req_is_probe_0
      | ~_mshrs_2_io_probe_rdy & idx_matches_1_2 & io_req_is_probe_1
      | ~_mshrs_2_io_probe_rdy & idx_matches_0_2 & io_req_is_probe_0
      | ~_mshrs_1_io_probe_rdy & idx_matches_1_1 & io_req_is_probe_1
      | ~_mshrs_1_io_probe_rdy & idx_matches_0_1 & io_req_is_probe_0
      | ~_mshrs_0_io_probe_rdy & idx_matches_1_0 & io_req_is_probe_1)
    & ~(~_mshrs_0_io_probe_rdy & idx_matches_0_0 & io_req_is_probe_0);	// Mux.scala:47:69, mshrs.scala:543:21, :613:16, :620:22, :624:46, :684:{13,53,76}, :685:22
endmodule

