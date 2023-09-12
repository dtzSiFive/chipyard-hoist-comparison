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

module BoomCore_1(
  input         clock,
                reset,
  input  [2:0]  io_hartid,
  input         io_interrupts_debug,
                io_interrupts_mtip,
                io_interrupts_msip,
                io_interrupts_meip,
                io_interrupts_seip,
                io_ifu_fetchpacket_valid,
                io_ifu_fetchpacket_bits_uops_0_valid,
  input  [31:0] io_ifu_fetchpacket_bits_uops_0_bits_inst,
                io_ifu_fetchpacket_bits_uops_0_bits_debug_inst,
  input         io_ifu_fetchpacket_bits_uops_0_bits_is_rvc,
  input  [39:0] io_ifu_fetchpacket_bits_uops_0_bits_debug_pc,
  input  [3:0]  io_ifu_fetchpacket_bits_uops_0_bits_ctrl_br_type,
  input  [1:0]  io_ifu_fetchpacket_bits_uops_0_bits_ctrl_op1_sel,
  input  [2:0]  io_ifu_fetchpacket_bits_uops_0_bits_ctrl_op2_sel,
                io_ifu_fetchpacket_bits_uops_0_bits_ctrl_imm_sel,
  input  [3:0]  io_ifu_fetchpacket_bits_uops_0_bits_ctrl_op_fcn,
  input         io_ifu_fetchpacket_bits_uops_0_bits_ctrl_fcn_dw,
  input  [2:0]  io_ifu_fetchpacket_bits_uops_0_bits_ctrl_csr_cmd,
  input         io_ifu_fetchpacket_bits_uops_0_bits_ctrl_is_load,
                io_ifu_fetchpacket_bits_uops_0_bits_ctrl_is_sta,
                io_ifu_fetchpacket_bits_uops_0_bits_ctrl_is_std,
  input  [1:0]  io_ifu_fetchpacket_bits_uops_0_bits_iw_state,
  input         io_ifu_fetchpacket_bits_uops_0_bits_iw_p1_poisoned,
                io_ifu_fetchpacket_bits_uops_0_bits_iw_p2_poisoned,
                io_ifu_fetchpacket_bits_uops_0_bits_is_sfb,
  input  [4:0]  io_ifu_fetchpacket_bits_uops_0_bits_ftq_idx,
  input         io_ifu_fetchpacket_bits_uops_0_bits_edge_inst,
  input  [5:0]  io_ifu_fetchpacket_bits_uops_0_bits_pc_lob,
  input         io_ifu_fetchpacket_bits_uops_0_bits_taken,
  input  [11:0] io_ifu_fetchpacket_bits_uops_0_bits_csr_addr,
  input  [1:0]  io_ifu_fetchpacket_bits_uops_0_bits_rxq_idx,
  input         io_ifu_fetchpacket_bits_uops_0_bits_xcpt_pf_if,
                io_ifu_fetchpacket_bits_uops_0_bits_xcpt_ae_if,
                io_ifu_fetchpacket_bits_uops_0_bits_xcpt_ma_if,
                io_ifu_fetchpacket_bits_uops_0_bits_bp_debug_if,
                io_ifu_fetchpacket_bits_uops_0_bits_bp_xcpt_if,
  input  [1:0]  io_ifu_fetchpacket_bits_uops_0_bits_debug_fsrc,
                io_ifu_fetchpacket_bits_uops_0_bits_debug_tsrc,
  input         io_ifu_fetchpacket_bits_uops_1_valid,
  input  [31:0] io_ifu_fetchpacket_bits_uops_1_bits_inst,
                io_ifu_fetchpacket_bits_uops_1_bits_debug_inst,
  input         io_ifu_fetchpacket_bits_uops_1_bits_is_rvc,
  input  [39:0] io_ifu_fetchpacket_bits_uops_1_bits_debug_pc,
  input  [3:0]  io_ifu_fetchpacket_bits_uops_1_bits_ctrl_br_type,
  input  [1:0]  io_ifu_fetchpacket_bits_uops_1_bits_ctrl_op1_sel,
  input  [2:0]  io_ifu_fetchpacket_bits_uops_1_bits_ctrl_op2_sel,
                io_ifu_fetchpacket_bits_uops_1_bits_ctrl_imm_sel,
  input  [3:0]  io_ifu_fetchpacket_bits_uops_1_bits_ctrl_op_fcn,
  input         io_ifu_fetchpacket_bits_uops_1_bits_ctrl_fcn_dw,
  input  [2:0]  io_ifu_fetchpacket_bits_uops_1_bits_ctrl_csr_cmd,
  input         io_ifu_fetchpacket_bits_uops_1_bits_ctrl_is_load,
                io_ifu_fetchpacket_bits_uops_1_bits_ctrl_is_sta,
                io_ifu_fetchpacket_bits_uops_1_bits_ctrl_is_std,
  input  [1:0]  io_ifu_fetchpacket_bits_uops_1_bits_iw_state,
  input         io_ifu_fetchpacket_bits_uops_1_bits_iw_p1_poisoned,
                io_ifu_fetchpacket_bits_uops_1_bits_iw_p2_poisoned,
                io_ifu_fetchpacket_bits_uops_1_bits_is_sfb,
  input  [4:0]  io_ifu_fetchpacket_bits_uops_1_bits_ftq_idx,
  input         io_ifu_fetchpacket_bits_uops_1_bits_edge_inst,
  input  [5:0]  io_ifu_fetchpacket_bits_uops_1_bits_pc_lob,
  input         io_ifu_fetchpacket_bits_uops_1_bits_taken,
  input  [11:0] io_ifu_fetchpacket_bits_uops_1_bits_csr_addr,
  input  [1:0]  io_ifu_fetchpacket_bits_uops_1_bits_rxq_idx,
  input         io_ifu_fetchpacket_bits_uops_1_bits_xcpt_pf_if,
                io_ifu_fetchpacket_bits_uops_1_bits_xcpt_ae_if,
                io_ifu_fetchpacket_bits_uops_1_bits_xcpt_ma_if,
                io_ifu_fetchpacket_bits_uops_1_bits_bp_debug_if,
                io_ifu_fetchpacket_bits_uops_1_bits_bp_xcpt_if,
  input  [1:0]  io_ifu_fetchpacket_bits_uops_1_bits_debug_fsrc,
                io_ifu_fetchpacket_bits_uops_1_bits_debug_tsrc,
  input         io_ifu_fetchpacket_bits_uops_2_valid,
  input  [31:0] io_ifu_fetchpacket_bits_uops_2_bits_inst,
                io_ifu_fetchpacket_bits_uops_2_bits_debug_inst,
  input         io_ifu_fetchpacket_bits_uops_2_bits_is_rvc,
  input  [39:0] io_ifu_fetchpacket_bits_uops_2_bits_debug_pc,
  input  [3:0]  io_ifu_fetchpacket_bits_uops_2_bits_ctrl_br_type,
  input  [1:0]  io_ifu_fetchpacket_bits_uops_2_bits_ctrl_op1_sel,
  input  [2:0]  io_ifu_fetchpacket_bits_uops_2_bits_ctrl_op2_sel,
                io_ifu_fetchpacket_bits_uops_2_bits_ctrl_imm_sel,
  input  [3:0]  io_ifu_fetchpacket_bits_uops_2_bits_ctrl_op_fcn,
  input         io_ifu_fetchpacket_bits_uops_2_bits_ctrl_fcn_dw,
  input  [2:0]  io_ifu_fetchpacket_bits_uops_2_bits_ctrl_csr_cmd,
  input         io_ifu_fetchpacket_bits_uops_2_bits_ctrl_is_load,
                io_ifu_fetchpacket_bits_uops_2_bits_ctrl_is_sta,
                io_ifu_fetchpacket_bits_uops_2_bits_ctrl_is_std,
  input  [1:0]  io_ifu_fetchpacket_bits_uops_2_bits_iw_state,
  input         io_ifu_fetchpacket_bits_uops_2_bits_iw_p1_poisoned,
                io_ifu_fetchpacket_bits_uops_2_bits_iw_p2_poisoned,
                io_ifu_fetchpacket_bits_uops_2_bits_is_sfb,
  input  [4:0]  io_ifu_fetchpacket_bits_uops_2_bits_ftq_idx,
  input         io_ifu_fetchpacket_bits_uops_2_bits_edge_inst,
  input  [5:0]  io_ifu_fetchpacket_bits_uops_2_bits_pc_lob,
  input         io_ifu_fetchpacket_bits_uops_2_bits_taken,
  input  [11:0] io_ifu_fetchpacket_bits_uops_2_bits_csr_addr,
  input  [1:0]  io_ifu_fetchpacket_bits_uops_2_bits_rxq_idx,
  input         io_ifu_fetchpacket_bits_uops_2_bits_xcpt_pf_if,
                io_ifu_fetchpacket_bits_uops_2_bits_xcpt_ae_if,
                io_ifu_fetchpacket_bits_uops_2_bits_xcpt_ma_if,
                io_ifu_fetchpacket_bits_uops_2_bits_bp_debug_if,
                io_ifu_fetchpacket_bits_uops_2_bits_bp_xcpt_if,
  input  [1:0]  io_ifu_fetchpacket_bits_uops_2_bits_debug_fsrc,
                io_ifu_fetchpacket_bits_uops_2_bits_debug_tsrc,
  input         io_ifu_get_pc_0_entry_cfi_idx_valid,
  input  [2:0]  io_ifu_get_pc_0_entry_cfi_idx_bits,
  input  [4:0]  io_ifu_get_pc_0_entry_ras_idx,
  input         io_ifu_get_pc_0_entry_start_bank,
  input  [39:0] io_ifu_get_pc_0_pc,
                io_ifu_get_pc_0_com_pc,
  input         io_ifu_get_pc_0_next_val,
  input  [39:0] io_ifu_get_pc_0_next_pc,
  input  [2:0]  io_ifu_get_pc_1_entry_cfi_idx_bits,
  input  [7:0]  io_ifu_get_pc_1_entry_br_mask,
  input         io_ifu_get_pc_1_entry_cfi_is_call,
                io_ifu_get_pc_1_entry_cfi_is_ret,
                io_ifu_get_pc_1_entry_start_bank,
  input  [63:0] io_ifu_get_pc_1_ghist_old_history,
  input         io_ifu_get_pc_1_ghist_current_saw_branch_not_taken,
                io_ifu_get_pc_1_ghist_new_saw_branch_not_taken,
                io_ifu_get_pc_1_ghist_new_saw_branch_taken,
  input  [4:0]  io_ifu_get_pc_1_ghist_ras_idx,
  input  [39:0] io_ifu_get_pc_1_pc,
  input         io_lsu_exe_0_iresp_valid,
  input  [6:0]  io_lsu_exe_0_iresp_bits_uop_rob_idx,
                io_lsu_exe_0_iresp_bits_uop_pdst,
  input         io_lsu_exe_0_iresp_bits_uop_is_amo,
                io_lsu_exe_0_iresp_bits_uop_uses_stq,
  input  [1:0]  io_lsu_exe_0_iresp_bits_uop_dst_rtype,
  input  [63:0] io_lsu_exe_0_iresp_bits_data,
  input         io_lsu_exe_0_fresp_valid,
  input  [6:0]  io_lsu_exe_0_fresp_bits_uop_uopc,
  input  [15:0] io_lsu_exe_0_fresp_bits_uop_br_mask,
  input  [6:0]  io_lsu_exe_0_fresp_bits_uop_rob_idx,
  input  [4:0]  io_lsu_exe_0_fresp_bits_uop_stq_idx,
  input  [6:0]  io_lsu_exe_0_fresp_bits_uop_pdst,
  input  [1:0]  io_lsu_exe_0_fresp_bits_uop_mem_size,
  input         io_lsu_exe_0_fresp_bits_uop_is_amo,
                io_lsu_exe_0_fresp_bits_uop_uses_stq,
  input  [1:0]  io_lsu_exe_0_fresp_bits_uop_dst_rtype,
  input         io_lsu_exe_0_fresp_bits_uop_fp_val,
  input  [64:0] io_lsu_exe_0_fresp_bits_data,
  input  [4:0]  io_lsu_dis_ldq_idx_0,
                io_lsu_dis_ldq_idx_1,
                io_lsu_dis_ldq_idx_2,
                io_lsu_dis_stq_idx_0,
                io_lsu_dis_stq_idx_1,
                io_lsu_dis_stq_idx_2,
  input         io_lsu_ldq_full_0,
                io_lsu_ldq_full_1,
                io_lsu_ldq_full_2,
                io_lsu_stq_full_0,
                io_lsu_stq_full_1,
                io_lsu_stq_full_2,
                io_lsu_fp_stdata_ready,
                io_lsu_clr_bsy_0_valid,
  input  [6:0]  io_lsu_clr_bsy_0_bits,
  input         io_lsu_clr_bsy_1_valid,
  input  [6:0]  io_lsu_clr_bsy_1_bits,
  input         io_lsu_spec_ld_wakeup_0_valid,
  input  [6:0]  io_lsu_spec_ld_wakeup_0_bits,
  input         io_lsu_ld_miss,
                io_lsu_fencei_rdy,
                io_lsu_lxcpt_valid,
  input  [15:0] io_lsu_lxcpt_bits_uop_br_mask,
  input  [6:0]  io_lsu_lxcpt_bits_uop_rob_idx,
  input  [4:0]  io_lsu_lxcpt_bits_cause,
  input  [39:0] io_lsu_lxcpt_bits_badvaddr,
  output        io_ifu_fetchpacket_ready,
  output [4:0]  io_ifu_get_pc_0_ftq_idx,
                io_ifu_get_pc_1_ftq_idx,
  output        io_ifu_sfence_valid,
                io_ifu_sfence_bits_rs1,
                io_ifu_sfence_bits_rs2,
  output [38:0] io_ifu_sfence_bits_addr,
  output [4:0]  io_ifu_brupdate_b2_uop_ftq_idx,
  output [5:0]  io_ifu_brupdate_b2_uop_pc_lob,
  output        io_ifu_brupdate_b2_mispredict,
                io_ifu_brupdate_b2_taken,
                io_ifu_redirect_flush,
                io_ifu_redirect_val,
  output [39:0] io_ifu_redirect_pc,
  output [4:0]  io_ifu_redirect_ftq_idx,
  output [63:0] io_ifu_redirect_ghist_old_history,
  output        io_ifu_redirect_ghist_current_saw_branch_not_taken,
                io_ifu_redirect_ghist_new_saw_branch_not_taken,
                io_ifu_redirect_ghist_new_saw_branch_taken,
  output [4:0]  io_ifu_redirect_ghist_ras_idx,
  output        io_ifu_commit_valid,
  output [31:0] io_ifu_commit_bits,
  output        io_ifu_flush_icache,
  output [3:0]  io_ptw_ptbr_mode,
  output [43:0] io_ptw_ptbr_ppn,
  output        io_ptw_sfence_valid,
                io_ptw_sfence_bits_rs1,
                io_ptw_sfence_bits_rs2,
  output [38:0] io_ptw_sfence_bits_addr,
  output        io_ptw_status_debug,
  output [1:0]  io_ptw_status_dprv,
                io_ptw_status_prv,
  output        io_ptw_status_mxr,
                io_ptw_status_sum,
                io_ptw_pmp_0_cfg_l,
  output [1:0]  io_ptw_pmp_0_cfg_a,
  output        io_ptw_pmp_0_cfg_x,
                io_ptw_pmp_0_cfg_w,
                io_ptw_pmp_0_cfg_r,
  output [29:0] io_ptw_pmp_0_addr,
  output [31:0] io_ptw_pmp_0_mask,
  output        io_ptw_pmp_1_cfg_l,
  output [1:0]  io_ptw_pmp_1_cfg_a,
  output        io_ptw_pmp_1_cfg_x,
                io_ptw_pmp_1_cfg_w,
                io_ptw_pmp_1_cfg_r,
  output [29:0] io_ptw_pmp_1_addr,
  output [31:0] io_ptw_pmp_1_mask,
  output        io_ptw_pmp_2_cfg_l,
  output [1:0]  io_ptw_pmp_2_cfg_a,
  output        io_ptw_pmp_2_cfg_x,
                io_ptw_pmp_2_cfg_w,
                io_ptw_pmp_2_cfg_r,
  output [29:0] io_ptw_pmp_2_addr,
  output [31:0] io_ptw_pmp_2_mask,
  output        io_ptw_pmp_3_cfg_l,
  output [1:0]  io_ptw_pmp_3_cfg_a,
  output        io_ptw_pmp_3_cfg_x,
                io_ptw_pmp_3_cfg_w,
                io_ptw_pmp_3_cfg_r,
  output [29:0] io_ptw_pmp_3_addr,
  output [31:0] io_ptw_pmp_3_mask,
  output        io_ptw_pmp_4_cfg_l,
  output [1:0]  io_ptw_pmp_4_cfg_a,
  output        io_ptw_pmp_4_cfg_x,
                io_ptw_pmp_4_cfg_w,
                io_ptw_pmp_4_cfg_r,
  output [29:0] io_ptw_pmp_4_addr,
  output [31:0] io_ptw_pmp_4_mask,
  output        io_ptw_pmp_5_cfg_l,
  output [1:0]  io_ptw_pmp_5_cfg_a,
  output        io_ptw_pmp_5_cfg_x,
                io_ptw_pmp_5_cfg_w,
                io_ptw_pmp_5_cfg_r,
  output [29:0] io_ptw_pmp_5_addr,
  output [31:0] io_ptw_pmp_5_mask,
  output        io_ptw_pmp_6_cfg_l,
  output [1:0]  io_ptw_pmp_6_cfg_a,
  output        io_ptw_pmp_6_cfg_x,
                io_ptw_pmp_6_cfg_w,
                io_ptw_pmp_6_cfg_r,
  output [29:0] io_ptw_pmp_6_addr,
  output [31:0] io_ptw_pmp_6_mask,
  output        io_ptw_pmp_7_cfg_l,
  output [1:0]  io_ptw_pmp_7_cfg_a,
  output        io_ptw_pmp_7_cfg_x,
                io_ptw_pmp_7_cfg_w,
                io_ptw_pmp_7_cfg_r,
  output [29:0] io_ptw_pmp_7_addr,
  output [31:0] io_ptw_pmp_7_mask,
  output        io_lsu_exe_0_req_valid,
  output [6:0]  io_lsu_exe_0_req_bits_uop_uopc,
  output [31:0] io_lsu_exe_0_req_bits_uop_inst,
                io_lsu_exe_0_req_bits_uop_debug_inst,
  output        io_lsu_exe_0_req_bits_uop_is_rvc,
  output [39:0] io_lsu_exe_0_req_bits_uop_debug_pc,
  output [2:0]  io_lsu_exe_0_req_bits_uop_iq_type,
  output [9:0]  io_lsu_exe_0_req_bits_uop_fu_code,
  output [3:0]  io_lsu_exe_0_req_bits_uop_ctrl_br_type,
  output [1:0]  io_lsu_exe_0_req_bits_uop_ctrl_op1_sel,
  output [2:0]  io_lsu_exe_0_req_bits_uop_ctrl_op2_sel,
                io_lsu_exe_0_req_bits_uop_ctrl_imm_sel,
  output [3:0]  io_lsu_exe_0_req_bits_uop_ctrl_op_fcn,
  output        io_lsu_exe_0_req_bits_uop_ctrl_fcn_dw,
  output [2:0]  io_lsu_exe_0_req_bits_uop_ctrl_csr_cmd,
  output        io_lsu_exe_0_req_bits_uop_ctrl_is_load,
                io_lsu_exe_0_req_bits_uop_ctrl_is_sta,
                io_lsu_exe_0_req_bits_uop_ctrl_is_std,
  output [1:0]  io_lsu_exe_0_req_bits_uop_iw_state,
  output        io_lsu_exe_0_req_bits_uop_iw_p1_poisoned,
                io_lsu_exe_0_req_bits_uop_iw_p2_poisoned,
                io_lsu_exe_0_req_bits_uop_is_br,
                io_lsu_exe_0_req_bits_uop_is_jalr,
                io_lsu_exe_0_req_bits_uop_is_jal,
                io_lsu_exe_0_req_bits_uop_is_sfb,
  output [15:0] io_lsu_exe_0_req_bits_uop_br_mask,
  output [3:0]  io_lsu_exe_0_req_bits_uop_br_tag,
  output [4:0]  io_lsu_exe_0_req_bits_uop_ftq_idx,
  output        io_lsu_exe_0_req_bits_uop_edge_inst,
  output [5:0]  io_lsu_exe_0_req_bits_uop_pc_lob,
  output        io_lsu_exe_0_req_bits_uop_taken,
  output [19:0] io_lsu_exe_0_req_bits_uop_imm_packed,
  output [11:0] io_lsu_exe_0_req_bits_uop_csr_addr,
  output [6:0]  io_lsu_exe_0_req_bits_uop_rob_idx,
  output [4:0]  io_lsu_exe_0_req_bits_uop_ldq_idx,
                io_lsu_exe_0_req_bits_uop_stq_idx,
  output [1:0]  io_lsu_exe_0_req_bits_uop_rxq_idx,
  output [6:0]  io_lsu_exe_0_req_bits_uop_pdst,
                io_lsu_exe_0_req_bits_uop_prs1,
                io_lsu_exe_0_req_bits_uop_prs2,
                io_lsu_exe_0_req_bits_uop_prs3,
  output [4:0]  io_lsu_exe_0_req_bits_uop_ppred,
  output        io_lsu_exe_0_req_bits_uop_prs1_busy,
                io_lsu_exe_0_req_bits_uop_prs2_busy,
                io_lsu_exe_0_req_bits_uop_prs3_busy,
                io_lsu_exe_0_req_bits_uop_ppred_busy,
  output [6:0]  io_lsu_exe_0_req_bits_uop_stale_pdst,
  output        io_lsu_exe_0_req_bits_uop_exception,
  output [63:0] io_lsu_exe_0_req_bits_uop_exc_cause,
  output        io_lsu_exe_0_req_bits_uop_bypassable,
  output [4:0]  io_lsu_exe_0_req_bits_uop_mem_cmd,
  output [1:0]  io_lsu_exe_0_req_bits_uop_mem_size,
  output        io_lsu_exe_0_req_bits_uop_mem_signed,
                io_lsu_exe_0_req_bits_uop_is_fence,
                io_lsu_exe_0_req_bits_uop_is_fencei,
                io_lsu_exe_0_req_bits_uop_is_amo,
                io_lsu_exe_0_req_bits_uop_uses_ldq,
                io_lsu_exe_0_req_bits_uop_uses_stq,
                io_lsu_exe_0_req_bits_uop_is_sys_pc2epc,
                io_lsu_exe_0_req_bits_uop_is_unique,
                io_lsu_exe_0_req_bits_uop_flush_on_commit,
                io_lsu_exe_0_req_bits_uop_ldst_is_rs1,
  output [5:0]  io_lsu_exe_0_req_bits_uop_ldst,
                io_lsu_exe_0_req_bits_uop_lrs1,
                io_lsu_exe_0_req_bits_uop_lrs2,
                io_lsu_exe_0_req_bits_uop_lrs3,
  output        io_lsu_exe_0_req_bits_uop_ldst_val,
  output [1:0]  io_lsu_exe_0_req_bits_uop_dst_rtype,
                io_lsu_exe_0_req_bits_uop_lrs1_rtype,
                io_lsu_exe_0_req_bits_uop_lrs2_rtype,
  output        io_lsu_exe_0_req_bits_uop_frs3_en,
                io_lsu_exe_0_req_bits_uop_fp_val,
                io_lsu_exe_0_req_bits_uop_fp_single,
                io_lsu_exe_0_req_bits_uop_xcpt_pf_if,
                io_lsu_exe_0_req_bits_uop_xcpt_ae_if,
                io_lsu_exe_0_req_bits_uop_xcpt_ma_if,
                io_lsu_exe_0_req_bits_uop_bp_debug_if,
                io_lsu_exe_0_req_bits_uop_bp_xcpt_if,
  output [1:0]  io_lsu_exe_0_req_bits_uop_debug_fsrc,
                io_lsu_exe_0_req_bits_uop_debug_tsrc,
  output [63:0] io_lsu_exe_0_req_bits_data,
  output [39:0] io_lsu_exe_0_req_bits_addr,
  output        io_lsu_exe_0_req_bits_mxcpt_valid,
                io_lsu_exe_0_req_bits_sfence_valid,
                io_lsu_exe_0_req_bits_sfence_bits_rs1,
                io_lsu_exe_0_req_bits_sfence_bits_rs2,
  output [38:0] io_lsu_exe_0_req_bits_sfence_bits_addr,
  output        io_lsu_dis_uops_0_valid,
  output [6:0]  io_lsu_dis_uops_0_bits_uopc,
  output [31:0] io_lsu_dis_uops_0_bits_inst,
                io_lsu_dis_uops_0_bits_debug_inst,
  output        io_lsu_dis_uops_0_bits_is_rvc,
  output [39:0] io_lsu_dis_uops_0_bits_debug_pc,
  output [2:0]  io_lsu_dis_uops_0_bits_iq_type,
  output [9:0]  io_lsu_dis_uops_0_bits_fu_code,
  output [3:0]  io_lsu_dis_uops_0_bits_ctrl_br_type,
  output [1:0]  io_lsu_dis_uops_0_bits_ctrl_op1_sel,
  output [2:0]  io_lsu_dis_uops_0_bits_ctrl_op2_sel,
                io_lsu_dis_uops_0_bits_ctrl_imm_sel,
  output [3:0]  io_lsu_dis_uops_0_bits_ctrl_op_fcn,
  output        io_lsu_dis_uops_0_bits_ctrl_fcn_dw,
  output [2:0]  io_lsu_dis_uops_0_bits_ctrl_csr_cmd,
  output        io_lsu_dis_uops_0_bits_ctrl_is_load,
                io_lsu_dis_uops_0_bits_ctrl_is_sta,
                io_lsu_dis_uops_0_bits_ctrl_is_std,
  output [1:0]  io_lsu_dis_uops_0_bits_iw_state,
  output        io_lsu_dis_uops_0_bits_iw_p1_poisoned,
                io_lsu_dis_uops_0_bits_iw_p2_poisoned,
                io_lsu_dis_uops_0_bits_is_br,
                io_lsu_dis_uops_0_bits_is_jalr,
                io_lsu_dis_uops_0_bits_is_jal,
                io_lsu_dis_uops_0_bits_is_sfb,
  output [15:0] io_lsu_dis_uops_0_bits_br_mask,
  output [3:0]  io_lsu_dis_uops_0_bits_br_tag,
  output [4:0]  io_lsu_dis_uops_0_bits_ftq_idx,
  output        io_lsu_dis_uops_0_bits_edge_inst,
  output [5:0]  io_lsu_dis_uops_0_bits_pc_lob,
  output        io_lsu_dis_uops_0_bits_taken,
  output [19:0] io_lsu_dis_uops_0_bits_imm_packed,
  output [11:0] io_lsu_dis_uops_0_bits_csr_addr,
  output [6:0]  io_lsu_dis_uops_0_bits_rob_idx,
  output [4:0]  io_lsu_dis_uops_0_bits_ldq_idx,
                io_lsu_dis_uops_0_bits_stq_idx,
  output [1:0]  io_lsu_dis_uops_0_bits_rxq_idx,
  output [6:0]  io_lsu_dis_uops_0_bits_pdst,
                io_lsu_dis_uops_0_bits_prs1,
                io_lsu_dis_uops_0_bits_prs2,
                io_lsu_dis_uops_0_bits_prs3,
  output        io_lsu_dis_uops_0_bits_prs1_busy,
                io_lsu_dis_uops_0_bits_prs2_busy,
                io_lsu_dis_uops_0_bits_prs3_busy,
  output [6:0]  io_lsu_dis_uops_0_bits_stale_pdst,
  output        io_lsu_dis_uops_0_bits_exception,
  output [63:0] io_lsu_dis_uops_0_bits_exc_cause,
  output        io_lsu_dis_uops_0_bits_bypassable,
  output [4:0]  io_lsu_dis_uops_0_bits_mem_cmd,
  output [1:0]  io_lsu_dis_uops_0_bits_mem_size,
  output        io_lsu_dis_uops_0_bits_mem_signed,
                io_lsu_dis_uops_0_bits_is_fence,
                io_lsu_dis_uops_0_bits_is_fencei,
                io_lsu_dis_uops_0_bits_is_amo,
                io_lsu_dis_uops_0_bits_uses_ldq,
                io_lsu_dis_uops_0_bits_uses_stq,
                io_lsu_dis_uops_0_bits_is_sys_pc2epc,
                io_lsu_dis_uops_0_bits_is_unique,
                io_lsu_dis_uops_0_bits_flush_on_commit,
                io_lsu_dis_uops_0_bits_ldst_is_rs1,
  output [5:0]  io_lsu_dis_uops_0_bits_ldst,
                io_lsu_dis_uops_0_bits_lrs1,
                io_lsu_dis_uops_0_bits_lrs2,
                io_lsu_dis_uops_0_bits_lrs3,
  output        io_lsu_dis_uops_0_bits_ldst_val,
  output [1:0]  io_lsu_dis_uops_0_bits_dst_rtype,
                io_lsu_dis_uops_0_bits_lrs1_rtype,
                io_lsu_dis_uops_0_bits_lrs2_rtype,
  output        io_lsu_dis_uops_0_bits_frs3_en,
                io_lsu_dis_uops_0_bits_fp_val,
                io_lsu_dis_uops_0_bits_fp_single,
                io_lsu_dis_uops_0_bits_xcpt_pf_if,
                io_lsu_dis_uops_0_bits_xcpt_ae_if,
                io_lsu_dis_uops_0_bits_xcpt_ma_if,
                io_lsu_dis_uops_0_bits_bp_debug_if,
                io_lsu_dis_uops_0_bits_bp_xcpt_if,
  output [1:0]  io_lsu_dis_uops_0_bits_debug_fsrc,
                io_lsu_dis_uops_0_bits_debug_tsrc,
  output        io_lsu_dis_uops_1_valid,
  output [6:0]  io_lsu_dis_uops_1_bits_uopc,
  output [31:0] io_lsu_dis_uops_1_bits_inst,
                io_lsu_dis_uops_1_bits_debug_inst,
  output        io_lsu_dis_uops_1_bits_is_rvc,
  output [39:0] io_lsu_dis_uops_1_bits_debug_pc,
  output [2:0]  io_lsu_dis_uops_1_bits_iq_type,
  output [9:0]  io_lsu_dis_uops_1_bits_fu_code,
  output [3:0]  io_lsu_dis_uops_1_bits_ctrl_br_type,
  output [1:0]  io_lsu_dis_uops_1_bits_ctrl_op1_sel,
  output [2:0]  io_lsu_dis_uops_1_bits_ctrl_op2_sel,
                io_lsu_dis_uops_1_bits_ctrl_imm_sel,
  output [3:0]  io_lsu_dis_uops_1_bits_ctrl_op_fcn,
  output        io_lsu_dis_uops_1_bits_ctrl_fcn_dw,
  output [2:0]  io_lsu_dis_uops_1_bits_ctrl_csr_cmd,
  output        io_lsu_dis_uops_1_bits_ctrl_is_load,
                io_lsu_dis_uops_1_bits_ctrl_is_sta,
                io_lsu_dis_uops_1_bits_ctrl_is_std,
  output [1:0]  io_lsu_dis_uops_1_bits_iw_state,
  output        io_lsu_dis_uops_1_bits_iw_p1_poisoned,
                io_lsu_dis_uops_1_bits_iw_p2_poisoned,
                io_lsu_dis_uops_1_bits_is_br,
                io_lsu_dis_uops_1_bits_is_jalr,
                io_lsu_dis_uops_1_bits_is_jal,
                io_lsu_dis_uops_1_bits_is_sfb,
  output [15:0] io_lsu_dis_uops_1_bits_br_mask,
  output [3:0]  io_lsu_dis_uops_1_bits_br_tag,
  output [4:0]  io_lsu_dis_uops_1_bits_ftq_idx,
  output        io_lsu_dis_uops_1_bits_edge_inst,
  output [5:0]  io_lsu_dis_uops_1_bits_pc_lob,
  output        io_lsu_dis_uops_1_bits_taken,
  output [19:0] io_lsu_dis_uops_1_bits_imm_packed,
  output [11:0] io_lsu_dis_uops_1_bits_csr_addr,
  output [6:0]  io_lsu_dis_uops_1_bits_rob_idx,
  output [4:0]  io_lsu_dis_uops_1_bits_ldq_idx,
                io_lsu_dis_uops_1_bits_stq_idx,
  output [1:0]  io_lsu_dis_uops_1_bits_rxq_idx,
  output [6:0]  io_lsu_dis_uops_1_bits_pdst,
                io_lsu_dis_uops_1_bits_prs1,
                io_lsu_dis_uops_1_bits_prs2,
                io_lsu_dis_uops_1_bits_prs3,
  output        io_lsu_dis_uops_1_bits_prs1_busy,
                io_lsu_dis_uops_1_bits_prs2_busy,
                io_lsu_dis_uops_1_bits_prs3_busy,
  output [6:0]  io_lsu_dis_uops_1_bits_stale_pdst,
  output        io_lsu_dis_uops_1_bits_exception,
  output [63:0] io_lsu_dis_uops_1_bits_exc_cause,
  output        io_lsu_dis_uops_1_bits_bypassable,
  output [4:0]  io_lsu_dis_uops_1_bits_mem_cmd,
  output [1:0]  io_lsu_dis_uops_1_bits_mem_size,
  output        io_lsu_dis_uops_1_bits_mem_signed,
                io_lsu_dis_uops_1_bits_is_fence,
                io_lsu_dis_uops_1_bits_is_fencei,
                io_lsu_dis_uops_1_bits_is_amo,
                io_lsu_dis_uops_1_bits_uses_ldq,
                io_lsu_dis_uops_1_bits_uses_stq,
                io_lsu_dis_uops_1_bits_is_sys_pc2epc,
                io_lsu_dis_uops_1_bits_is_unique,
                io_lsu_dis_uops_1_bits_flush_on_commit,
                io_lsu_dis_uops_1_bits_ldst_is_rs1,
  output [5:0]  io_lsu_dis_uops_1_bits_ldst,
                io_lsu_dis_uops_1_bits_lrs1,
                io_lsu_dis_uops_1_bits_lrs2,
                io_lsu_dis_uops_1_bits_lrs3,
  output        io_lsu_dis_uops_1_bits_ldst_val,
  output [1:0]  io_lsu_dis_uops_1_bits_dst_rtype,
                io_lsu_dis_uops_1_bits_lrs1_rtype,
                io_lsu_dis_uops_1_bits_lrs2_rtype,
  output        io_lsu_dis_uops_1_bits_frs3_en,
                io_lsu_dis_uops_1_bits_fp_val,
                io_lsu_dis_uops_1_bits_fp_single,
                io_lsu_dis_uops_1_bits_xcpt_pf_if,
                io_lsu_dis_uops_1_bits_xcpt_ae_if,
                io_lsu_dis_uops_1_bits_xcpt_ma_if,
                io_lsu_dis_uops_1_bits_bp_debug_if,
                io_lsu_dis_uops_1_bits_bp_xcpt_if,
  output [1:0]  io_lsu_dis_uops_1_bits_debug_fsrc,
                io_lsu_dis_uops_1_bits_debug_tsrc,
  output        io_lsu_dis_uops_2_valid,
  output [6:0]  io_lsu_dis_uops_2_bits_uopc,
  output [31:0] io_lsu_dis_uops_2_bits_inst,
                io_lsu_dis_uops_2_bits_debug_inst,
  output        io_lsu_dis_uops_2_bits_is_rvc,
  output [39:0] io_lsu_dis_uops_2_bits_debug_pc,
  output [2:0]  io_lsu_dis_uops_2_bits_iq_type,
  output [9:0]  io_lsu_dis_uops_2_bits_fu_code,
  output [3:0]  io_lsu_dis_uops_2_bits_ctrl_br_type,
  output [1:0]  io_lsu_dis_uops_2_bits_ctrl_op1_sel,
  output [2:0]  io_lsu_dis_uops_2_bits_ctrl_op2_sel,
                io_lsu_dis_uops_2_bits_ctrl_imm_sel,
  output [3:0]  io_lsu_dis_uops_2_bits_ctrl_op_fcn,
  output        io_lsu_dis_uops_2_bits_ctrl_fcn_dw,
  output [2:0]  io_lsu_dis_uops_2_bits_ctrl_csr_cmd,
  output        io_lsu_dis_uops_2_bits_ctrl_is_load,
                io_lsu_dis_uops_2_bits_ctrl_is_sta,
                io_lsu_dis_uops_2_bits_ctrl_is_std,
  output [1:0]  io_lsu_dis_uops_2_bits_iw_state,
  output        io_lsu_dis_uops_2_bits_iw_p1_poisoned,
                io_lsu_dis_uops_2_bits_iw_p2_poisoned,
                io_lsu_dis_uops_2_bits_is_br,
                io_lsu_dis_uops_2_bits_is_jalr,
                io_lsu_dis_uops_2_bits_is_jal,
                io_lsu_dis_uops_2_bits_is_sfb,
  output [15:0] io_lsu_dis_uops_2_bits_br_mask,
  output [3:0]  io_lsu_dis_uops_2_bits_br_tag,
  output [4:0]  io_lsu_dis_uops_2_bits_ftq_idx,
  output        io_lsu_dis_uops_2_bits_edge_inst,
  output [5:0]  io_lsu_dis_uops_2_bits_pc_lob,
  output        io_lsu_dis_uops_2_bits_taken,
  output [19:0] io_lsu_dis_uops_2_bits_imm_packed,
  output [11:0] io_lsu_dis_uops_2_bits_csr_addr,
  output [6:0]  io_lsu_dis_uops_2_bits_rob_idx,
  output [4:0]  io_lsu_dis_uops_2_bits_ldq_idx,
                io_lsu_dis_uops_2_bits_stq_idx,
  output [1:0]  io_lsu_dis_uops_2_bits_rxq_idx,
  output [6:0]  io_lsu_dis_uops_2_bits_pdst,
                io_lsu_dis_uops_2_bits_prs1,
                io_lsu_dis_uops_2_bits_prs2,
                io_lsu_dis_uops_2_bits_prs3,
  output        io_lsu_dis_uops_2_bits_prs1_busy,
                io_lsu_dis_uops_2_bits_prs2_busy,
                io_lsu_dis_uops_2_bits_prs3_busy,
  output [6:0]  io_lsu_dis_uops_2_bits_stale_pdst,
  output        io_lsu_dis_uops_2_bits_exception,
  output [63:0] io_lsu_dis_uops_2_bits_exc_cause,
  output        io_lsu_dis_uops_2_bits_bypassable,
  output [4:0]  io_lsu_dis_uops_2_bits_mem_cmd,
  output [1:0]  io_lsu_dis_uops_2_bits_mem_size,
  output        io_lsu_dis_uops_2_bits_mem_signed,
                io_lsu_dis_uops_2_bits_is_fence,
                io_lsu_dis_uops_2_bits_is_fencei,
                io_lsu_dis_uops_2_bits_is_amo,
                io_lsu_dis_uops_2_bits_uses_ldq,
                io_lsu_dis_uops_2_bits_uses_stq,
                io_lsu_dis_uops_2_bits_is_sys_pc2epc,
                io_lsu_dis_uops_2_bits_is_unique,
                io_lsu_dis_uops_2_bits_flush_on_commit,
                io_lsu_dis_uops_2_bits_ldst_is_rs1,
  output [5:0]  io_lsu_dis_uops_2_bits_ldst,
                io_lsu_dis_uops_2_bits_lrs1,
                io_lsu_dis_uops_2_bits_lrs2,
                io_lsu_dis_uops_2_bits_lrs3,
  output        io_lsu_dis_uops_2_bits_ldst_val,
  output [1:0]  io_lsu_dis_uops_2_bits_dst_rtype,
                io_lsu_dis_uops_2_bits_lrs1_rtype,
                io_lsu_dis_uops_2_bits_lrs2_rtype,
  output        io_lsu_dis_uops_2_bits_frs3_en,
                io_lsu_dis_uops_2_bits_fp_val,
                io_lsu_dis_uops_2_bits_fp_single,
                io_lsu_dis_uops_2_bits_xcpt_pf_if,
                io_lsu_dis_uops_2_bits_xcpt_ae_if,
                io_lsu_dis_uops_2_bits_xcpt_ma_if,
                io_lsu_dis_uops_2_bits_bp_debug_if,
                io_lsu_dis_uops_2_bits_bp_xcpt_if,
  output [1:0]  io_lsu_dis_uops_2_bits_debug_fsrc,
                io_lsu_dis_uops_2_bits_debug_tsrc,
  output        io_lsu_fp_stdata_valid,
  output [15:0] io_lsu_fp_stdata_bits_uop_br_mask,
  output [6:0]  io_lsu_fp_stdata_bits_uop_rob_idx,
  output [4:0]  io_lsu_fp_stdata_bits_uop_stq_idx,
  output [63:0] io_lsu_fp_stdata_bits_data,
  output        io_lsu_commit_valids_0,
                io_lsu_commit_valids_1,
                io_lsu_commit_valids_2,
                io_lsu_commit_uops_0_uses_ldq,
                io_lsu_commit_uops_0_uses_stq,
                io_lsu_commit_uops_1_uses_ldq,
                io_lsu_commit_uops_1_uses_stq,
                io_lsu_commit_uops_2_uses_ldq,
                io_lsu_commit_uops_2_uses_stq,
                io_lsu_commit_load_at_rob_head,
                io_lsu_fence_dmem,
  output [15:0] io_lsu_brupdate_b1_resolve_mask,
                io_lsu_brupdate_b1_mispredict_mask,
  output [4:0]  io_lsu_brupdate_b2_uop_ldq_idx,
                io_lsu_brupdate_b2_uop_stq_idx,
  output        io_lsu_brupdate_b2_mispredict,
  output [6:0]  io_lsu_rob_head_idx,
  output        io_lsu_exception
);

  wire            dis_stalls_2;	// core.scala:707:62
  wire            dec_xcpts_1;	// core.scala:560:71
  wire            dec_xcpts_0;	// core.scala:560:71
  wire            _ftq_arb_io_in_2_ready;	// core.scala:520:23
  wire [63:0]     _csr_io_rw_rdata;	// core.scala:268:19
  wire            _csr_io_decode_0_fp_illegal;	// core.scala:268:19
  wire            _csr_io_decode_0_read_illegal;	// core.scala:268:19
  wire            _csr_io_decode_0_write_illegal;	// core.scala:268:19
  wire            _csr_io_decode_0_write_flush;	// core.scala:268:19
  wire            _csr_io_decode_0_system_illegal;	// core.scala:268:19
  wire            _csr_io_decode_1_fp_illegal;	// core.scala:268:19
  wire            _csr_io_decode_1_read_illegal;	// core.scala:268:19
  wire            _csr_io_decode_1_write_illegal;	// core.scala:268:19
  wire            _csr_io_decode_1_write_flush;	// core.scala:268:19
  wire            _csr_io_decode_1_system_illegal;	// core.scala:268:19
  wire            _csr_io_decode_2_fp_illegal;	// core.scala:268:19
  wire            _csr_io_decode_2_read_illegal;	// core.scala:268:19
  wire            _csr_io_decode_2_write_illegal;	// core.scala:268:19
  wire            _csr_io_decode_2_write_flush;	// core.scala:268:19
  wire            _csr_io_decode_2_system_illegal;	// core.scala:268:19
  wire            _csr_io_csr_stall;	// core.scala:268:19
  wire            _csr_io_singleStep;	// core.scala:268:19
  wire            _csr_io_status_debug;	// core.scala:268:19
  wire [31:0]     _csr_io_status_isa;	// core.scala:268:19
  wire [39:0]     _csr_io_evec;	// core.scala:268:19
  wire [2:0]      _csr_io_fcsr_rm;	// core.scala:268:19
  wire            _csr_io_interrupt;	// core.scala:268:19
  wire [63:0]     _csr_io_interrupt_cause;	// core.scala:268:19
  wire [63:0]     _csr_io_customCSRs_0_value;	// core.scala:268:19
  wire [6:0]      _rob_io_rob_tail_idx;	// core.scala:140:32
  wire [6:0]      _rob_io_rob_head_idx;	// core.scala:140:32
  wire            _rob_io_commit_valids_0;	// core.scala:140:32
  wire            _rob_io_commit_valids_1;	// core.scala:140:32
  wire            _rob_io_commit_valids_2;	// core.scala:140:32
  wire            _rob_io_commit_arch_valids_0;	// core.scala:140:32
  wire            _rob_io_commit_arch_valids_1;	// core.scala:140:32
  wire            _rob_io_commit_arch_valids_2;	// core.scala:140:32
  wire [4:0]      _rob_io_commit_uops_0_ftq_idx;	// core.scala:140:32
  wire [6:0]      _rob_io_commit_uops_0_pdst;	// core.scala:140:32
  wire [6:0]      _rob_io_commit_uops_0_stale_pdst;	// core.scala:140:32
  wire            _rob_io_commit_uops_0_is_fencei;	// core.scala:140:32
  wire [5:0]      _rob_io_commit_uops_0_ldst;	// core.scala:140:32
  wire            _rob_io_commit_uops_0_ldst_val;	// core.scala:140:32
  wire [1:0]      _rob_io_commit_uops_0_dst_rtype;	// core.scala:140:32
  wire [4:0]      _rob_io_commit_uops_1_ftq_idx;	// core.scala:140:32
  wire [6:0]      _rob_io_commit_uops_1_pdst;	// core.scala:140:32
  wire [6:0]      _rob_io_commit_uops_1_stale_pdst;	// core.scala:140:32
  wire            _rob_io_commit_uops_1_is_fencei;	// core.scala:140:32
  wire [5:0]      _rob_io_commit_uops_1_ldst;	// core.scala:140:32
  wire            _rob_io_commit_uops_1_ldst_val;	// core.scala:140:32
  wire [1:0]      _rob_io_commit_uops_1_dst_rtype;	// core.scala:140:32
  wire [4:0]      _rob_io_commit_uops_2_ftq_idx;	// core.scala:140:32
  wire [6:0]      _rob_io_commit_uops_2_pdst;	// core.scala:140:32
  wire [6:0]      _rob_io_commit_uops_2_stale_pdst;	// core.scala:140:32
  wire            _rob_io_commit_uops_2_is_fencei;	// core.scala:140:32
  wire [5:0]      _rob_io_commit_uops_2_ldst;	// core.scala:140:32
  wire            _rob_io_commit_uops_2_ldst_val;	// core.scala:140:32
  wire [1:0]      _rob_io_commit_uops_2_dst_rtype;	// core.scala:140:32
  wire            _rob_io_commit_fflags_valid;	// core.scala:140:32
  wire [4:0]      _rob_io_commit_fflags_bits;	// core.scala:140:32
  wire            _rob_io_commit_rbk_valids_0;	// core.scala:140:32
  wire            _rob_io_commit_rbk_valids_1;	// core.scala:140:32
  wire            _rob_io_commit_rbk_valids_2;	// core.scala:140:32
  wire            _rob_io_commit_rollback;	// core.scala:140:32
  wire            _rob_io_com_xcpt_valid;	// core.scala:140:32
  wire [4:0]      _rob_io_com_xcpt_bits_ftq_idx;	// core.scala:140:32
  wire            _rob_io_com_xcpt_bits_edge_inst;	// core.scala:140:32
  wire [5:0]      _rob_io_com_xcpt_bits_pc_lob;	// core.scala:140:32
  wire [63:0]     _rob_io_com_xcpt_bits_cause;	// core.scala:140:32
  wire [63:0]     _rob_io_com_xcpt_bits_badvaddr;	// core.scala:140:32
  wire            _rob_io_flush_valid;	// core.scala:140:32
  wire [4:0]      _rob_io_flush_bits_ftq_idx;	// core.scala:140:32
  wire            _rob_io_flush_bits_edge_inst;	// core.scala:140:32
  wire            _rob_io_flush_bits_is_rvc;	// core.scala:140:32
  wire [5:0]      _rob_io_flush_bits_pc_lob;	// core.scala:140:32
  wire [2:0]      _rob_io_flush_bits_flush_typ;	// core.scala:140:32
  wire            _rob_io_empty;	// core.scala:140:32
  wire            _rob_io_ready;	// core.scala:140:32
  wire            _rob_io_flush_frontend;	// core.scala:140:32
  wire [6:0]      _iregister_read_io_rf_read_ports_0_addr;	// core.scala:132:32
  wire [6:0]      _iregister_read_io_rf_read_ports_1_addr;	// core.scala:132:32
  wire [6:0]      _iregister_read_io_rf_read_ports_2_addr;	// core.scala:132:32
  wire [6:0]      _iregister_read_io_rf_read_ports_3_addr;	// core.scala:132:32
  wire [6:0]      _iregister_read_io_rf_read_ports_4_addr;	// core.scala:132:32
  wire [6:0]      _iregister_read_io_rf_read_ports_5_addr;	// core.scala:132:32
  wire [6:0]      _iregister_read_io_rf_read_ports_6_addr;	// core.scala:132:32
  wire [6:0]      _iregister_read_io_rf_read_ports_7_addr;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_0_valid;	// core.scala:132:32
  wire [6:0]      _iregister_read_io_exe_reqs_0_bits_uop_uopc;	// core.scala:132:32
  wire [31:0]     _iregister_read_io_exe_reqs_0_bits_uop_inst;	// core.scala:132:32
  wire [31:0]     _iregister_read_io_exe_reqs_0_bits_uop_debug_inst;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_0_bits_uop_is_rvc;	// core.scala:132:32
  wire [39:0]     _iregister_read_io_exe_reqs_0_bits_uop_debug_pc;	// core.scala:132:32
  wire [2:0]      _iregister_read_io_exe_reqs_0_bits_uop_iq_type;	// core.scala:132:32
  wire [9:0]      _iregister_read_io_exe_reqs_0_bits_uop_fu_code;	// core.scala:132:32
  wire [3:0]      _iregister_read_io_exe_reqs_0_bits_uop_ctrl_br_type;	// core.scala:132:32
  wire [1:0]      _iregister_read_io_exe_reqs_0_bits_uop_ctrl_op1_sel;	// core.scala:132:32
  wire [2:0]      _iregister_read_io_exe_reqs_0_bits_uop_ctrl_op2_sel;	// core.scala:132:32
  wire [2:0]      _iregister_read_io_exe_reqs_0_bits_uop_ctrl_imm_sel;	// core.scala:132:32
  wire [3:0]      _iregister_read_io_exe_reqs_0_bits_uop_ctrl_op_fcn;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_0_bits_uop_ctrl_fcn_dw;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_0_bits_uop_ctrl_is_load;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_0_bits_uop_ctrl_is_sta;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_0_bits_uop_ctrl_is_std;	// core.scala:132:32
  wire [1:0]      _iregister_read_io_exe_reqs_0_bits_uop_iw_state;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_0_bits_uop_is_br;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_0_bits_uop_is_jalr;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_0_bits_uop_is_jal;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_0_bits_uop_is_sfb;	// core.scala:132:32
  wire [15:0]     _iregister_read_io_exe_reqs_0_bits_uop_br_mask;	// core.scala:132:32
  wire [3:0]      _iregister_read_io_exe_reqs_0_bits_uop_br_tag;	// core.scala:132:32
  wire [4:0]      _iregister_read_io_exe_reqs_0_bits_uop_ftq_idx;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_0_bits_uop_edge_inst;	// core.scala:132:32
  wire [5:0]      _iregister_read_io_exe_reqs_0_bits_uop_pc_lob;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_0_bits_uop_taken;	// core.scala:132:32
  wire [19:0]     _iregister_read_io_exe_reqs_0_bits_uop_imm_packed;	// core.scala:132:32
  wire [11:0]     _iregister_read_io_exe_reqs_0_bits_uop_csr_addr;	// core.scala:132:32
  wire [6:0]      _iregister_read_io_exe_reqs_0_bits_uop_rob_idx;	// core.scala:132:32
  wire [4:0]      _iregister_read_io_exe_reqs_0_bits_uop_ldq_idx;	// core.scala:132:32
  wire [4:0]      _iregister_read_io_exe_reqs_0_bits_uop_stq_idx;	// core.scala:132:32
  wire [1:0]      _iregister_read_io_exe_reqs_0_bits_uop_rxq_idx;	// core.scala:132:32
  wire [6:0]      _iregister_read_io_exe_reqs_0_bits_uop_pdst;	// core.scala:132:32
  wire [6:0]      _iregister_read_io_exe_reqs_0_bits_uop_prs1;	// core.scala:132:32
  wire [6:0]      _iregister_read_io_exe_reqs_0_bits_uop_prs2;	// core.scala:132:32
  wire [6:0]      _iregister_read_io_exe_reqs_0_bits_uop_prs3;	// core.scala:132:32
  wire [4:0]      _iregister_read_io_exe_reqs_0_bits_uop_ppred;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_0_bits_uop_prs1_busy;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_0_bits_uop_prs2_busy;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_0_bits_uop_prs3_busy;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_0_bits_uop_ppred_busy;	// core.scala:132:32
  wire [6:0]      _iregister_read_io_exe_reqs_0_bits_uop_stale_pdst;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_0_bits_uop_exception;	// core.scala:132:32
  wire [63:0]     _iregister_read_io_exe_reqs_0_bits_uop_exc_cause;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_0_bits_uop_bypassable;	// core.scala:132:32
  wire [4:0]      _iregister_read_io_exe_reqs_0_bits_uop_mem_cmd;	// core.scala:132:32
  wire [1:0]      _iregister_read_io_exe_reqs_0_bits_uop_mem_size;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_0_bits_uop_mem_signed;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_0_bits_uop_is_fence;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_0_bits_uop_is_fencei;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_0_bits_uop_is_amo;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_0_bits_uop_uses_ldq;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_0_bits_uop_uses_stq;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_0_bits_uop_is_sys_pc2epc;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_0_bits_uop_is_unique;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_0_bits_uop_flush_on_commit;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_0_bits_uop_ldst_is_rs1;	// core.scala:132:32
  wire [5:0]      _iregister_read_io_exe_reqs_0_bits_uop_ldst;	// core.scala:132:32
  wire [5:0]      _iregister_read_io_exe_reqs_0_bits_uop_lrs1;	// core.scala:132:32
  wire [5:0]      _iregister_read_io_exe_reqs_0_bits_uop_lrs2;	// core.scala:132:32
  wire [5:0]      _iregister_read_io_exe_reqs_0_bits_uop_lrs3;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_0_bits_uop_ldst_val;	// core.scala:132:32
  wire [1:0]      _iregister_read_io_exe_reqs_0_bits_uop_dst_rtype;	// core.scala:132:32
  wire [1:0]      _iregister_read_io_exe_reqs_0_bits_uop_lrs1_rtype;	// core.scala:132:32
  wire [1:0]      _iregister_read_io_exe_reqs_0_bits_uop_lrs2_rtype;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_0_bits_uop_frs3_en;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_0_bits_uop_fp_val;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_0_bits_uop_fp_single;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_0_bits_uop_xcpt_pf_if;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_0_bits_uop_xcpt_ae_if;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_0_bits_uop_xcpt_ma_if;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_0_bits_uop_bp_debug_if;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_0_bits_uop_bp_xcpt_if;	// core.scala:132:32
  wire [1:0]      _iregister_read_io_exe_reqs_0_bits_uop_debug_fsrc;	// core.scala:132:32
  wire [1:0]      _iregister_read_io_exe_reqs_0_bits_uop_debug_tsrc;	// core.scala:132:32
  wire [63:0]     _iregister_read_io_exe_reqs_0_bits_rs1_data;	// core.scala:132:32
  wire [63:0]     _iregister_read_io_exe_reqs_0_bits_rs2_data;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_1_valid;	// core.scala:132:32
  wire [6:0]      _iregister_read_io_exe_reqs_1_bits_uop_uopc;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_1_bits_uop_is_rvc;	// core.scala:132:32
  wire [9:0]      _iregister_read_io_exe_reqs_1_bits_uop_fu_code;	// core.scala:132:32
  wire [3:0]      _iregister_read_io_exe_reqs_1_bits_uop_ctrl_br_type;	// core.scala:132:32
  wire [1:0]      _iregister_read_io_exe_reqs_1_bits_uop_ctrl_op1_sel;	// core.scala:132:32
  wire [2:0]      _iregister_read_io_exe_reqs_1_bits_uop_ctrl_op2_sel;	// core.scala:132:32
  wire [2:0]      _iregister_read_io_exe_reqs_1_bits_uop_ctrl_imm_sel;	// core.scala:132:32
  wire [3:0]      _iregister_read_io_exe_reqs_1_bits_uop_ctrl_op_fcn;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_1_bits_uop_ctrl_fcn_dw;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_1_bits_uop_is_br;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_1_bits_uop_is_jalr;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_1_bits_uop_is_jal;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_1_bits_uop_is_sfb;	// core.scala:132:32
  wire [15:0]     _iregister_read_io_exe_reqs_1_bits_uop_br_mask;	// core.scala:132:32
  wire [3:0]      _iregister_read_io_exe_reqs_1_bits_uop_br_tag;	// core.scala:132:32
  wire [4:0]      _iregister_read_io_exe_reqs_1_bits_uop_ftq_idx;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_1_bits_uop_edge_inst;	// core.scala:132:32
  wire [5:0]      _iregister_read_io_exe_reqs_1_bits_uop_pc_lob;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_1_bits_uop_taken;	// core.scala:132:32
  wire [19:0]     _iregister_read_io_exe_reqs_1_bits_uop_imm_packed;	// core.scala:132:32
  wire [6:0]      _iregister_read_io_exe_reqs_1_bits_uop_rob_idx;	// core.scala:132:32
  wire [4:0]      _iregister_read_io_exe_reqs_1_bits_uop_ldq_idx;	// core.scala:132:32
  wire [4:0]      _iregister_read_io_exe_reqs_1_bits_uop_stq_idx;	// core.scala:132:32
  wire [6:0]      _iregister_read_io_exe_reqs_1_bits_uop_pdst;	// core.scala:132:32
  wire [6:0]      _iregister_read_io_exe_reqs_1_bits_uop_prs1;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_1_bits_uop_bypassable;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_1_bits_uop_is_amo;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_1_bits_uop_uses_stq;	// core.scala:132:32
  wire [1:0]      _iregister_read_io_exe_reqs_1_bits_uop_dst_rtype;	// core.scala:132:32
  wire [63:0]     _iregister_read_io_exe_reqs_1_bits_rs1_data;	// core.scala:132:32
  wire [63:0]     _iregister_read_io_exe_reqs_1_bits_rs2_data;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_2_valid;	// core.scala:132:32
  wire [6:0]      _iregister_read_io_exe_reqs_2_bits_uop_uopc;	// core.scala:132:32
  wire [31:0]     _iregister_read_io_exe_reqs_2_bits_uop_inst;	// core.scala:132:32
  wire [31:0]     _iregister_read_io_exe_reqs_2_bits_uop_debug_inst;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_2_bits_uop_is_rvc;	// core.scala:132:32
  wire [39:0]     _iregister_read_io_exe_reqs_2_bits_uop_debug_pc;	// core.scala:132:32
  wire [2:0]      _iregister_read_io_exe_reqs_2_bits_uop_iq_type;	// core.scala:132:32
  wire [9:0]      _iregister_read_io_exe_reqs_2_bits_uop_fu_code;	// core.scala:132:32
  wire [3:0]      _iregister_read_io_exe_reqs_2_bits_uop_ctrl_br_type;	// core.scala:132:32
  wire [1:0]      _iregister_read_io_exe_reqs_2_bits_uop_ctrl_op1_sel;	// core.scala:132:32
  wire [2:0]      _iregister_read_io_exe_reqs_2_bits_uop_ctrl_op2_sel;	// core.scala:132:32
  wire [2:0]      _iregister_read_io_exe_reqs_2_bits_uop_ctrl_imm_sel;	// core.scala:132:32
  wire [3:0]      _iregister_read_io_exe_reqs_2_bits_uop_ctrl_op_fcn;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_2_bits_uop_ctrl_fcn_dw;	// core.scala:132:32
  wire [2:0]      _iregister_read_io_exe_reqs_2_bits_uop_ctrl_csr_cmd;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_2_bits_uop_ctrl_is_load;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_2_bits_uop_ctrl_is_sta;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_2_bits_uop_ctrl_is_std;	// core.scala:132:32
  wire [1:0]      _iregister_read_io_exe_reqs_2_bits_uop_iw_state;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_2_bits_uop_is_br;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_2_bits_uop_is_jalr;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_2_bits_uop_is_jal;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_2_bits_uop_is_sfb;	// core.scala:132:32
  wire [15:0]     _iregister_read_io_exe_reqs_2_bits_uop_br_mask;	// core.scala:132:32
  wire [3:0]      _iregister_read_io_exe_reqs_2_bits_uop_br_tag;	// core.scala:132:32
  wire [4:0]      _iregister_read_io_exe_reqs_2_bits_uop_ftq_idx;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_2_bits_uop_edge_inst;	// core.scala:132:32
  wire [5:0]      _iregister_read_io_exe_reqs_2_bits_uop_pc_lob;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_2_bits_uop_taken;	// core.scala:132:32
  wire [19:0]     _iregister_read_io_exe_reqs_2_bits_uop_imm_packed;	// core.scala:132:32
  wire [11:0]     _iregister_read_io_exe_reqs_2_bits_uop_csr_addr;	// core.scala:132:32
  wire [6:0]      _iregister_read_io_exe_reqs_2_bits_uop_rob_idx;	// core.scala:132:32
  wire [4:0]      _iregister_read_io_exe_reqs_2_bits_uop_ldq_idx;	// core.scala:132:32
  wire [4:0]      _iregister_read_io_exe_reqs_2_bits_uop_stq_idx;	// core.scala:132:32
  wire [1:0]      _iregister_read_io_exe_reqs_2_bits_uop_rxq_idx;	// core.scala:132:32
  wire [6:0]      _iregister_read_io_exe_reqs_2_bits_uop_pdst;	// core.scala:132:32
  wire [6:0]      _iregister_read_io_exe_reqs_2_bits_uop_prs1;	// core.scala:132:32
  wire [6:0]      _iregister_read_io_exe_reqs_2_bits_uop_prs2;	// core.scala:132:32
  wire [6:0]      _iregister_read_io_exe_reqs_2_bits_uop_prs3;	// core.scala:132:32
  wire [4:0]      _iregister_read_io_exe_reqs_2_bits_uop_ppred;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_2_bits_uop_prs1_busy;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_2_bits_uop_prs2_busy;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_2_bits_uop_prs3_busy;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_2_bits_uop_ppred_busy;	// core.scala:132:32
  wire [6:0]      _iregister_read_io_exe_reqs_2_bits_uop_stale_pdst;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_2_bits_uop_exception;	// core.scala:132:32
  wire [63:0]     _iregister_read_io_exe_reqs_2_bits_uop_exc_cause;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_2_bits_uop_bypassable;	// core.scala:132:32
  wire [4:0]      _iregister_read_io_exe_reqs_2_bits_uop_mem_cmd;	// core.scala:132:32
  wire [1:0]      _iregister_read_io_exe_reqs_2_bits_uop_mem_size;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_2_bits_uop_mem_signed;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_2_bits_uop_is_fence;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_2_bits_uop_is_fencei;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_2_bits_uop_is_amo;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_2_bits_uop_uses_ldq;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_2_bits_uop_uses_stq;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_2_bits_uop_is_sys_pc2epc;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_2_bits_uop_is_unique;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_2_bits_uop_flush_on_commit;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_2_bits_uop_ldst_is_rs1;	// core.scala:132:32
  wire [5:0]      _iregister_read_io_exe_reqs_2_bits_uop_ldst;	// core.scala:132:32
  wire [5:0]      _iregister_read_io_exe_reqs_2_bits_uop_lrs1;	// core.scala:132:32
  wire [5:0]      _iregister_read_io_exe_reqs_2_bits_uop_lrs2;	// core.scala:132:32
  wire [5:0]      _iregister_read_io_exe_reqs_2_bits_uop_lrs3;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_2_bits_uop_ldst_val;	// core.scala:132:32
  wire [1:0]      _iregister_read_io_exe_reqs_2_bits_uop_dst_rtype;	// core.scala:132:32
  wire [1:0]      _iregister_read_io_exe_reqs_2_bits_uop_lrs1_rtype;	// core.scala:132:32
  wire [1:0]      _iregister_read_io_exe_reqs_2_bits_uop_lrs2_rtype;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_2_bits_uop_frs3_en;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_2_bits_uop_fp_val;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_2_bits_uop_fp_single;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_2_bits_uop_xcpt_pf_if;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_2_bits_uop_xcpt_ae_if;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_2_bits_uop_xcpt_ma_if;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_2_bits_uop_bp_debug_if;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_2_bits_uop_bp_xcpt_if;	// core.scala:132:32
  wire [1:0]      _iregister_read_io_exe_reqs_2_bits_uop_debug_fsrc;	// core.scala:132:32
  wire [1:0]      _iregister_read_io_exe_reqs_2_bits_uop_debug_tsrc;	// core.scala:132:32
  wire [63:0]     _iregister_read_io_exe_reqs_2_bits_rs1_data;	// core.scala:132:32
  wire [63:0]     _iregister_read_io_exe_reqs_2_bits_rs2_data;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_3_valid;	// core.scala:132:32
  wire [6:0]      _iregister_read_io_exe_reqs_3_bits_uop_uopc;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_3_bits_uop_is_rvc;	// core.scala:132:32
  wire [9:0]      _iregister_read_io_exe_reqs_3_bits_uop_fu_code;	// core.scala:132:32
  wire [3:0]      _iregister_read_io_exe_reqs_3_bits_uop_ctrl_br_type;	// core.scala:132:32
  wire [1:0]      _iregister_read_io_exe_reqs_3_bits_uop_ctrl_op1_sel;	// core.scala:132:32
  wire [2:0]      _iregister_read_io_exe_reqs_3_bits_uop_ctrl_op2_sel;	// core.scala:132:32
  wire [2:0]      _iregister_read_io_exe_reqs_3_bits_uop_ctrl_imm_sel;	// core.scala:132:32
  wire [3:0]      _iregister_read_io_exe_reqs_3_bits_uop_ctrl_op_fcn;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_3_bits_uop_ctrl_fcn_dw;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_3_bits_uop_is_br;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_3_bits_uop_is_jalr;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_3_bits_uop_is_jal;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_3_bits_uop_is_sfb;	// core.scala:132:32
  wire [15:0]     _iregister_read_io_exe_reqs_3_bits_uop_br_mask;	// core.scala:132:32
  wire [3:0]      _iregister_read_io_exe_reqs_3_bits_uop_br_tag;	// core.scala:132:32
  wire [4:0]      _iregister_read_io_exe_reqs_3_bits_uop_ftq_idx;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_3_bits_uop_edge_inst;	// core.scala:132:32
  wire [5:0]      _iregister_read_io_exe_reqs_3_bits_uop_pc_lob;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_3_bits_uop_taken;	// core.scala:132:32
  wire [19:0]     _iregister_read_io_exe_reqs_3_bits_uop_imm_packed;	// core.scala:132:32
  wire [6:0]      _iregister_read_io_exe_reqs_3_bits_uop_rob_idx;	// core.scala:132:32
  wire [4:0]      _iregister_read_io_exe_reqs_3_bits_uop_ldq_idx;	// core.scala:132:32
  wire [4:0]      _iregister_read_io_exe_reqs_3_bits_uop_stq_idx;	// core.scala:132:32
  wire [6:0]      _iregister_read_io_exe_reqs_3_bits_uop_pdst;	// core.scala:132:32
  wire [6:0]      _iregister_read_io_exe_reqs_3_bits_uop_prs1;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_3_bits_uop_bypassable;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_3_bits_uop_is_amo;	// core.scala:132:32
  wire            _iregister_read_io_exe_reqs_3_bits_uop_uses_stq;	// core.scala:132:32
  wire [1:0]      _iregister_read_io_exe_reqs_3_bits_uop_dst_rtype;	// core.scala:132:32
  wire [63:0]     _iregister_read_io_exe_reqs_3_bits_rs1_data;	// core.scala:132:32
  wire [63:0]     _iregister_read_io_exe_reqs_3_bits_rs2_data;	// core.scala:132:32
  wire            _ll_wbarb_io_in_1_ready;	// core.scala:129:32
  wire            _ll_wbarb_io_out_valid;	// core.scala:129:32
  wire [6:0]      _ll_wbarb_io_out_bits_uop_rob_idx;	// core.scala:129:32
  wire [6:0]      _ll_wbarb_io_out_bits_uop_pdst;	// core.scala:129:32
  wire            _ll_wbarb_io_out_bits_uop_is_amo;	// core.scala:129:32
  wire            _ll_wbarb_io_out_bits_uop_uses_stq;	// core.scala:129:32
  wire [1:0]      _ll_wbarb_io_out_bits_uop_dst_rtype;	// core.scala:129:32
  wire [63:0]     _ll_wbarb_io_out_bits_data;	// core.scala:129:32
  wire            _ll_wbarb_io_out_bits_predicated;	// core.scala:129:32
  wire [63:0]     _iregfile_io_read_ports_0_data;	// core.scala:113:32
  wire [63:0]     _iregfile_io_read_ports_1_data;	// core.scala:113:32
  wire [63:0]     _iregfile_io_read_ports_2_data;	// core.scala:113:32
  wire [63:0]     _iregfile_io_read_ports_3_data;	// core.scala:113:32
  wire [63:0]     _iregfile_io_read_ports_4_data;	// core.scala:113:32
  wire [63:0]     _iregfile_io_read_ports_5_data;	// core.scala:113:32
  wire [63:0]     _iregfile_io_read_ports_6_data;	// core.scala:113:32
  wire [63:0]     _iregfile_io_read_ports_7_data;	// core.scala:113:32
  wire            _dispatcher_io_ren_uops_0_ready;	// core.scala:111:32
  wire            _dispatcher_io_ren_uops_1_ready;	// core.scala:111:32
  wire            _dispatcher_io_ren_uops_2_ready;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_0_valid;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_2_0_bits_uopc;	// core.scala:111:32
  wire [31:0]     _dispatcher_io_dis_uops_2_0_bits_inst;	// core.scala:111:32
  wire [31:0]     _dispatcher_io_dis_uops_2_0_bits_debug_inst;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_0_bits_is_rvc;	// core.scala:111:32
  wire [39:0]     _dispatcher_io_dis_uops_2_0_bits_debug_pc;	// core.scala:111:32
  wire [2:0]      _dispatcher_io_dis_uops_2_0_bits_iq_type;	// core.scala:111:32
  wire [9:0]      _dispatcher_io_dis_uops_2_0_bits_fu_code;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_0_bits_is_br;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_0_bits_is_jalr;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_0_bits_is_jal;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_0_bits_is_sfb;	// core.scala:111:32
  wire [15:0]     _dispatcher_io_dis_uops_2_0_bits_br_mask;	// core.scala:111:32
  wire [3:0]      _dispatcher_io_dis_uops_2_0_bits_br_tag;	// core.scala:111:32
  wire [4:0]      _dispatcher_io_dis_uops_2_0_bits_ftq_idx;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_0_bits_edge_inst;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_2_0_bits_pc_lob;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_0_bits_taken;	// core.scala:111:32
  wire [19:0]     _dispatcher_io_dis_uops_2_0_bits_imm_packed;	// core.scala:111:32
  wire [11:0]     _dispatcher_io_dis_uops_2_0_bits_csr_addr;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_2_0_bits_rob_idx;	// core.scala:111:32
  wire [4:0]      _dispatcher_io_dis_uops_2_0_bits_ldq_idx;	// core.scala:111:32
  wire [4:0]      _dispatcher_io_dis_uops_2_0_bits_stq_idx;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_2_0_bits_rxq_idx;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_2_0_bits_pdst;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_2_0_bits_prs1;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_2_0_bits_prs2;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_2_0_bits_prs3;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_0_bits_prs1_busy;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_0_bits_prs2_busy;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_0_bits_prs3_busy;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_2_0_bits_stale_pdst;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_0_bits_exception;	// core.scala:111:32
  wire [63:0]     _dispatcher_io_dis_uops_2_0_bits_exc_cause;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_0_bits_bypassable;	// core.scala:111:32
  wire [4:0]      _dispatcher_io_dis_uops_2_0_bits_mem_cmd;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_2_0_bits_mem_size;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_0_bits_mem_signed;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_0_bits_is_fence;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_0_bits_is_fencei;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_0_bits_is_amo;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_0_bits_uses_ldq;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_0_bits_uses_stq;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_0_bits_is_sys_pc2epc;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_0_bits_is_unique;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_0_bits_flush_on_commit;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_0_bits_ldst_is_rs1;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_2_0_bits_ldst;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_2_0_bits_lrs1;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_2_0_bits_lrs2;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_2_0_bits_lrs3;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_0_bits_ldst_val;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_2_0_bits_dst_rtype;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_2_0_bits_lrs1_rtype;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_2_0_bits_lrs2_rtype;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_0_bits_frs3_en;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_0_bits_fp_val;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_0_bits_fp_single;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_0_bits_xcpt_pf_if;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_0_bits_xcpt_ae_if;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_0_bits_xcpt_ma_if;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_0_bits_bp_debug_if;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_0_bits_bp_xcpt_if;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_2_0_bits_debug_fsrc;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_2_0_bits_debug_tsrc;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_1_valid;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_2_1_bits_uopc;	// core.scala:111:32
  wire [31:0]     _dispatcher_io_dis_uops_2_1_bits_inst;	// core.scala:111:32
  wire [31:0]     _dispatcher_io_dis_uops_2_1_bits_debug_inst;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_1_bits_is_rvc;	// core.scala:111:32
  wire [39:0]     _dispatcher_io_dis_uops_2_1_bits_debug_pc;	// core.scala:111:32
  wire [2:0]      _dispatcher_io_dis_uops_2_1_bits_iq_type;	// core.scala:111:32
  wire [9:0]      _dispatcher_io_dis_uops_2_1_bits_fu_code;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_1_bits_is_br;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_1_bits_is_jalr;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_1_bits_is_jal;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_1_bits_is_sfb;	// core.scala:111:32
  wire [15:0]     _dispatcher_io_dis_uops_2_1_bits_br_mask;	// core.scala:111:32
  wire [3:0]      _dispatcher_io_dis_uops_2_1_bits_br_tag;	// core.scala:111:32
  wire [4:0]      _dispatcher_io_dis_uops_2_1_bits_ftq_idx;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_1_bits_edge_inst;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_2_1_bits_pc_lob;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_1_bits_taken;	// core.scala:111:32
  wire [19:0]     _dispatcher_io_dis_uops_2_1_bits_imm_packed;	// core.scala:111:32
  wire [11:0]     _dispatcher_io_dis_uops_2_1_bits_csr_addr;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_2_1_bits_rob_idx;	// core.scala:111:32
  wire [4:0]      _dispatcher_io_dis_uops_2_1_bits_ldq_idx;	// core.scala:111:32
  wire [4:0]      _dispatcher_io_dis_uops_2_1_bits_stq_idx;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_2_1_bits_rxq_idx;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_2_1_bits_pdst;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_2_1_bits_prs1;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_2_1_bits_prs2;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_2_1_bits_prs3;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_1_bits_prs1_busy;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_1_bits_prs2_busy;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_1_bits_prs3_busy;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_2_1_bits_stale_pdst;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_1_bits_exception;	// core.scala:111:32
  wire [63:0]     _dispatcher_io_dis_uops_2_1_bits_exc_cause;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_1_bits_bypassable;	// core.scala:111:32
  wire [4:0]      _dispatcher_io_dis_uops_2_1_bits_mem_cmd;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_2_1_bits_mem_size;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_1_bits_mem_signed;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_1_bits_is_fence;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_1_bits_is_fencei;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_1_bits_is_amo;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_1_bits_uses_ldq;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_1_bits_uses_stq;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_1_bits_is_sys_pc2epc;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_1_bits_is_unique;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_1_bits_flush_on_commit;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_1_bits_ldst_is_rs1;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_2_1_bits_ldst;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_2_1_bits_lrs1;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_2_1_bits_lrs2;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_2_1_bits_lrs3;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_1_bits_ldst_val;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_2_1_bits_dst_rtype;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_2_1_bits_lrs1_rtype;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_2_1_bits_lrs2_rtype;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_1_bits_frs3_en;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_1_bits_fp_val;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_1_bits_fp_single;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_1_bits_xcpt_pf_if;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_1_bits_xcpt_ae_if;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_1_bits_xcpt_ma_if;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_1_bits_bp_debug_if;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_1_bits_bp_xcpt_if;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_2_1_bits_debug_fsrc;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_2_1_bits_debug_tsrc;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_2_valid;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_2_2_bits_uopc;	// core.scala:111:32
  wire [31:0]     _dispatcher_io_dis_uops_2_2_bits_inst;	// core.scala:111:32
  wire [31:0]     _dispatcher_io_dis_uops_2_2_bits_debug_inst;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_2_bits_is_rvc;	// core.scala:111:32
  wire [39:0]     _dispatcher_io_dis_uops_2_2_bits_debug_pc;	// core.scala:111:32
  wire [2:0]      _dispatcher_io_dis_uops_2_2_bits_iq_type;	// core.scala:111:32
  wire [9:0]      _dispatcher_io_dis_uops_2_2_bits_fu_code;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_2_bits_is_br;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_2_bits_is_jalr;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_2_bits_is_jal;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_2_bits_is_sfb;	// core.scala:111:32
  wire [15:0]     _dispatcher_io_dis_uops_2_2_bits_br_mask;	// core.scala:111:32
  wire [3:0]      _dispatcher_io_dis_uops_2_2_bits_br_tag;	// core.scala:111:32
  wire [4:0]      _dispatcher_io_dis_uops_2_2_bits_ftq_idx;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_2_bits_edge_inst;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_2_2_bits_pc_lob;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_2_bits_taken;	// core.scala:111:32
  wire [19:0]     _dispatcher_io_dis_uops_2_2_bits_imm_packed;	// core.scala:111:32
  wire [11:0]     _dispatcher_io_dis_uops_2_2_bits_csr_addr;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_2_2_bits_rob_idx;	// core.scala:111:32
  wire [4:0]      _dispatcher_io_dis_uops_2_2_bits_ldq_idx;	// core.scala:111:32
  wire [4:0]      _dispatcher_io_dis_uops_2_2_bits_stq_idx;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_2_2_bits_rxq_idx;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_2_2_bits_pdst;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_2_2_bits_prs1;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_2_2_bits_prs2;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_2_2_bits_prs3;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_2_bits_prs1_busy;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_2_bits_prs2_busy;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_2_bits_prs3_busy;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_2_2_bits_stale_pdst;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_2_bits_exception;	// core.scala:111:32
  wire [63:0]     _dispatcher_io_dis_uops_2_2_bits_exc_cause;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_2_bits_bypassable;	// core.scala:111:32
  wire [4:0]      _dispatcher_io_dis_uops_2_2_bits_mem_cmd;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_2_2_bits_mem_size;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_2_bits_mem_signed;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_2_bits_is_fence;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_2_bits_is_fencei;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_2_bits_is_amo;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_2_bits_uses_ldq;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_2_bits_uses_stq;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_2_bits_is_sys_pc2epc;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_2_bits_is_unique;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_2_bits_flush_on_commit;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_2_bits_ldst_is_rs1;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_2_2_bits_ldst;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_2_2_bits_lrs1;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_2_2_bits_lrs2;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_2_2_bits_lrs3;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_2_bits_ldst_val;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_2_2_bits_dst_rtype;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_2_2_bits_lrs1_rtype;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_2_2_bits_lrs2_rtype;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_2_bits_frs3_en;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_2_bits_fp_val;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_2_bits_fp_single;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_2_bits_xcpt_pf_if;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_2_bits_xcpt_ae_if;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_2_bits_xcpt_ma_if;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_2_bits_bp_debug_if;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_2_2_bits_bp_xcpt_if;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_2_2_bits_debug_fsrc;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_2_2_bits_debug_tsrc;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_0_valid;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_1_0_bits_uopc;	// core.scala:111:32
  wire [31:0]     _dispatcher_io_dis_uops_1_0_bits_inst;	// core.scala:111:32
  wire [31:0]     _dispatcher_io_dis_uops_1_0_bits_debug_inst;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_0_bits_is_rvc;	// core.scala:111:32
  wire [39:0]     _dispatcher_io_dis_uops_1_0_bits_debug_pc;	// core.scala:111:32
  wire [2:0]      _dispatcher_io_dis_uops_1_0_bits_iq_type;	// core.scala:111:32
  wire [9:0]      _dispatcher_io_dis_uops_1_0_bits_fu_code;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_0_bits_is_br;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_0_bits_is_jalr;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_0_bits_is_jal;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_0_bits_is_sfb;	// core.scala:111:32
  wire [15:0]     _dispatcher_io_dis_uops_1_0_bits_br_mask;	// core.scala:111:32
  wire [3:0]      _dispatcher_io_dis_uops_1_0_bits_br_tag;	// core.scala:111:32
  wire [4:0]      _dispatcher_io_dis_uops_1_0_bits_ftq_idx;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_0_bits_edge_inst;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_1_0_bits_pc_lob;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_0_bits_taken;	// core.scala:111:32
  wire [19:0]     _dispatcher_io_dis_uops_1_0_bits_imm_packed;	// core.scala:111:32
  wire [11:0]     _dispatcher_io_dis_uops_1_0_bits_csr_addr;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_1_0_bits_rob_idx;	// core.scala:111:32
  wire [4:0]      _dispatcher_io_dis_uops_1_0_bits_ldq_idx;	// core.scala:111:32
  wire [4:0]      _dispatcher_io_dis_uops_1_0_bits_stq_idx;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_1_0_bits_rxq_idx;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_1_0_bits_pdst;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_1_0_bits_prs1;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_1_0_bits_prs2;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_1_0_bits_prs3;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_0_bits_prs1_busy;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_0_bits_prs2_busy;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_1_0_bits_stale_pdst;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_0_bits_exception;	// core.scala:111:32
  wire [63:0]     _dispatcher_io_dis_uops_1_0_bits_exc_cause;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_0_bits_bypassable;	// core.scala:111:32
  wire [4:0]      _dispatcher_io_dis_uops_1_0_bits_mem_cmd;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_1_0_bits_mem_size;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_0_bits_mem_signed;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_0_bits_is_fence;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_0_bits_is_fencei;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_0_bits_is_amo;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_0_bits_uses_ldq;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_0_bits_uses_stq;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_0_bits_is_sys_pc2epc;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_0_bits_is_unique;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_0_bits_flush_on_commit;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_0_bits_ldst_is_rs1;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_1_0_bits_ldst;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_1_0_bits_lrs1;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_1_0_bits_lrs2;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_1_0_bits_lrs3;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_0_bits_ldst_val;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_1_0_bits_dst_rtype;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_1_0_bits_lrs1_rtype;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_1_0_bits_lrs2_rtype;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_0_bits_frs3_en;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_0_bits_fp_val;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_0_bits_fp_single;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_0_bits_xcpt_pf_if;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_0_bits_xcpt_ae_if;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_0_bits_xcpt_ma_if;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_0_bits_bp_debug_if;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_0_bits_bp_xcpt_if;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_1_0_bits_debug_fsrc;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_1_0_bits_debug_tsrc;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_1_valid;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_1_1_bits_uopc;	// core.scala:111:32
  wire [31:0]     _dispatcher_io_dis_uops_1_1_bits_inst;	// core.scala:111:32
  wire [31:0]     _dispatcher_io_dis_uops_1_1_bits_debug_inst;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_1_bits_is_rvc;	// core.scala:111:32
  wire [39:0]     _dispatcher_io_dis_uops_1_1_bits_debug_pc;	// core.scala:111:32
  wire [2:0]      _dispatcher_io_dis_uops_1_1_bits_iq_type;	// core.scala:111:32
  wire [9:0]      _dispatcher_io_dis_uops_1_1_bits_fu_code;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_1_bits_is_br;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_1_bits_is_jalr;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_1_bits_is_jal;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_1_bits_is_sfb;	// core.scala:111:32
  wire [15:0]     _dispatcher_io_dis_uops_1_1_bits_br_mask;	// core.scala:111:32
  wire [3:0]      _dispatcher_io_dis_uops_1_1_bits_br_tag;	// core.scala:111:32
  wire [4:0]      _dispatcher_io_dis_uops_1_1_bits_ftq_idx;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_1_bits_edge_inst;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_1_1_bits_pc_lob;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_1_bits_taken;	// core.scala:111:32
  wire [19:0]     _dispatcher_io_dis_uops_1_1_bits_imm_packed;	// core.scala:111:32
  wire [11:0]     _dispatcher_io_dis_uops_1_1_bits_csr_addr;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_1_1_bits_rob_idx;	// core.scala:111:32
  wire [4:0]      _dispatcher_io_dis_uops_1_1_bits_ldq_idx;	// core.scala:111:32
  wire [4:0]      _dispatcher_io_dis_uops_1_1_bits_stq_idx;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_1_1_bits_rxq_idx;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_1_1_bits_pdst;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_1_1_bits_prs1;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_1_1_bits_prs2;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_1_1_bits_prs3;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_1_bits_prs1_busy;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_1_bits_prs2_busy;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_1_1_bits_stale_pdst;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_1_bits_exception;	// core.scala:111:32
  wire [63:0]     _dispatcher_io_dis_uops_1_1_bits_exc_cause;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_1_bits_bypassable;	// core.scala:111:32
  wire [4:0]      _dispatcher_io_dis_uops_1_1_bits_mem_cmd;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_1_1_bits_mem_size;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_1_bits_mem_signed;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_1_bits_is_fence;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_1_bits_is_fencei;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_1_bits_is_amo;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_1_bits_uses_ldq;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_1_bits_uses_stq;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_1_bits_is_sys_pc2epc;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_1_bits_is_unique;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_1_bits_flush_on_commit;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_1_bits_ldst_is_rs1;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_1_1_bits_ldst;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_1_1_bits_lrs1;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_1_1_bits_lrs2;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_1_1_bits_lrs3;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_1_bits_ldst_val;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_1_1_bits_dst_rtype;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_1_1_bits_lrs1_rtype;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_1_1_bits_lrs2_rtype;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_1_bits_frs3_en;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_1_bits_fp_val;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_1_bits_fp_single;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_1_bits_xcpt_pf_if;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_1_bits_xcpt_ae_if;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_1_bits_xcpt_ma_if;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_1_bits_bp_debug_if;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_1_bits_bp_xcpt_if;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_1_1_bits_debug_fsrc;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_1_1_bits_debug_tsrc;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_2_valid;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_1_2_bits_uopc;	// core.scala:111:32
  wire [31:0]     _dispatcher_io_dis_uops_1_2_bits_inst;	// core.scala:111:32
  wire [31:0]     _dispatcher_io_dis_uops_1_2_bits_debug_inst;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_2_bits_is_rvc;	// core.scala:111:32
  wire [39:0]     _dispatcher_io_dis_uops_1_2_bits_debug_pc;	// core.scala:111:32
  wire [2:0]      _dispatcher_io_dis_uops_1_2_bits_iq_type;	// core.scala:111:32
  wire [9:0]      _dispatcher_io_dis_uops_1_2_bits_fu_code;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_2_bits_is_br;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_2_bits_is_jalr;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_2_bits_is_jal;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_2_bits_is_sfb;	// core.scala:111:32
  wire [15:0]     _dispatcher_io_dis_uops_1_2_bits_br_mask;	// core.scala:111:32
  wire [3:0]      _dispatcher_io_dis_uops_1_2_bits_br_tag;	// core.scala:111:32
  wire [4:0]      _dispatcher_io_dis_uops_1_2_bits_ftq_idx;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_2_bits_edge_inst;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_1_2_bits_pc_lob;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_2_bits_taken;	// core.scala:111:32
  wire [19:0]     _dispatcher_io_dis_uops_1_2_bits_imm_packed;	// core.scala:111:32
  wire [11:0]     _dispatcher_io_dis_uops_1_2_bits_csr_addr;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_1_2_bits_rob_idx;	// core.scala:111:32
  wire [4:0]      _dispatcher_io_dis_uops_1_2_bits_ldq_idx;	// core.scala:111:32
  wire [4:0]      _dispatcher_io_dis_uops_1_2_bits_stq_idx;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_1_2_bits_rxq_idx;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_1_2_bits_pdst;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_1_2_bits_prs1;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_1_2_bits_prs2;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_1_2_bits_prs3;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_2_bits_prs1_busy;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_2_bits_prs2_busy;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_1_2_bits_stale_pdst;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_2_bits_exception;	// core.scala:111:32
  wire [63:0]     _dispatcher_io_dis_uops_1_2_bits_exc_cause;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_2_bits_bypassable;	// core.scala:111:32
  wire [4:0]      _dispatcher_io_dis_uops_1_2_bits_mem_cmd;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_1_2_bits_mem_size;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_2_bits_mem_signed;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_2_bits_is_fence;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_2_bits_is_fencei;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_2_bits_is_amo;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_2_bits_uses_ldq;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_2_bits_uses_stq;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_2_bits_is_sys_pc2epc;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_2_bits_is_unique;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_2_bits_flush_on_commit;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_2_bits_ldst_is_rs1;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_1_2_bits_ldst;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_1_2_bits_lrs1;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_1_2_bits_lrs2;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_1_2_bits_lrs3;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_2_bits_ldst_val;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_1_2_bits_dst_rtype;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_1_2_bits_lrs1_rtype;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_1_2_bits_lrs2_rtype;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_2_bits_frs3_en;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_2_bits_fp_val;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_2_bits_fp_single;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_2_bits_xcpt_pf_if;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_2_bits_xcpt_ae_if;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_2_bits_xcpt_ma_if;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_2_bits_bp_debug_if;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_1_2_bits_bp_xcpt_if;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_1_2_bits_debug_fsrc;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_1_2_bits_debug_tsrc;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_0_valid;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_0_0_bits_uopc;	// core.scala:111:32
  wire [31:0]     _dispatcher_io_dis_uops_0_0_bits_inst;	// core.scala:111:32
  wire [31:0]     _dispatcher_io_dis_uops_0_0_bits_debug_inst;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_0_bits_is_rvc;	// core.scala:111:32
  wire [39:0]     _dispatcher_io_dis_uops_0_0_bits_debug_pc;	// core.scala:111:32
  wire [2:0]      _dispatcher_io_dis_uops_0_0_bits_iq_type;	// core.scala:111:32
  wire [9:0]      _dispatcher_io_dis_uops_0_0_bits_fu_code;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_0_bits_is_br;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_0_bits_is_jalr;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_0_bits_is_jal;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_0_bits_is_sfb;	// core.scala:111:32
  wire [15:0]     _dispatcher_io_dis_uops_0_0_bits_br_mask;	// core.scala:111:32
  wire [3:0]      _dispatcher_io_dis_uops_0_0_bits_br_tag;	// core.scala:111:32
  wire [4:0]      _dispatcher_io_dis_uops_0_0_bits_ftq_idx;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_0_bits_edge_inst;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_0_0_bits_pc_lob;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_0_bits_taken;	// core.scala:111:32
  wire [19:0]     _dispatcher_io_dis_uops_0_0_bits_imm_packed;	// core.scala:111:32
  wire [11:0]     _dispatcher_io_dis_uops_0_0_bits_csr_addr;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_0_0_bits_rob_idx;	// core.scala:111:32
  wire [4:0]      _dispatcher_io_dis_uops_0_0_bits_ldq_idx;	// core.scala:111:32
  wire [4:0]      _dispatcher_io_dis_uops_0_0_bits_stq_idx;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_0_0_bits_rxq_idx;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_0_0_bits_pdst;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_0_0_bits_prs1;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_0_0_bits_prs2;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_0_0_bits_prs3;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_0_bits_prs1_busy;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_0_bits_prs2_busy;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_0_0_bits_stale_pdst;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_0_bits_exception;	// core.scala:111:32
  wire [63:0]     _dispatcher_io_dis_uops_0_0_bits_exc_cause;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_0_bits_bypassable;	// core.scala:111:32
  wire [4:0]      _dispatcher_io_dis_uops_0_0_bits_mem_cmd;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_0_0_bits_mem_size;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_0_bits_mem_signed;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_0_bits_is_fence;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_0_bits_is_fencei;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_0_bits_is_amo;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_0_bits_uses_ldq;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_0_bits_uses_stq;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_0_bits_is_sys_pc2epc;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_0_bits_is_unique;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_0_bits_flush_on_commit;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_0_bits_ldst_is_rs1;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_0_0_bits_ldst;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_0_0_bits_lrs1;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_0_0_bits_lrs2;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_0_0_bits_lrs3;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_0_bits_ldst_val;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_0_0_bits_dst_rtype;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_0_0_bits_lrs1_rtype;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_0_0_bits_lrs2_rtype;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_0_bits_frs3_en;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_0_bits_fp_val;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_0_bits_fp_single;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_0_bits_xcpt_pf_if;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_0_bits_xcpt_ae_if;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_0_bits_xcpt_ma_if;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_0_bits_bp_debug_if;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_0_bits_bp_xcpt_if;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_0_0_bits_debug_fsrc;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_0_0_bits_debug_tsrc;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_1_valid;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_0_1_bits_uopc;	// core.scala:111:32
  wire [31:0]     _dispatcher_io_dis_uops_0_1_bits_inst;	// core.scala:111:32
  wire [31:0]     _dispatcher_io_dis_uops_0_1_bits_debug_inst;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_1_bits_is_rvc;	// core.scala:111:32
  wire [39:0]     _dispatcher_io_dis_uops_0_1_bits_debug_pc;	// core.scala:111:32
  wire [2:0]      _dispatcher_io_dis_uops_0_1_bits_iq_type;	// core.scala:111:32
  wire [9:0]      _dispatcher_io_dis_uops_0_1_bits_fu_code;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_1_bits_is_br;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_1_bits_is_jalr;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_1_bits_is_jal;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_1_bits_is_sfb;	// core.scala:111:32
  wire [15:0]     _dispatcher_io_dis_uops_0_1_bits_br_mask;	// core.scala:111:32
  wire [3:0]      _dispatcher_io_dis_uops_0_1_bits_br_tag;	// core.scala:111:32
  wire [4:0]      _dispatcher_io_dis_uops_0_1_bits_ftq_idx;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_1_bits_edge_inst;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_0_1_bits_pc_lob;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_1_bits_taken;	// core.scala:111:32
  wire [19:0]     _dispatcher_io_dis_uops_0_1_bits_imm_packed;	// core.scala:111:32
  wire [11:0]     _dispatcher_io_dis_uops_0_1_bits_csr_addr;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_0_1_bits_rob_idx;	// core.scala:111:32
  wire [4:0]      _dispatcher_io_dis_uops_0_1_bits_ldq_idx;	// core.scala:111:32
  wire [4:0]      _dispatcher_io_dis_uops_0_1_bits_stq_idx;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_0_1_bits_rxq_idx;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_0_1_bits_pdst;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_0_1_bits_prs1;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_0_1_bits_prs2;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_0_1_bits_prs3;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_1_bits_prs1_busy;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_1_bits_prs2_busy;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_0_1_bits_stale_pdst;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_1_bits_exception;	// core.scala:111:32
  wire [63:0]     _dispatcher_io_dis_uops_0_1_bits_exc_cause;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_1_bits_bypassable;	// core.scala:111:32
  wire [4:0]      _dispatcher_io_dis_uops_0_1_bits_mem_cmd;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_0_1_bits_mem_size;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_1_bits_mem_signed;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_1_bits_is_fence;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_1_bits_is_fencei;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_1_bits_is_amo;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_1_bits_uses_ldq;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_1_bits_uses_stq;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_1_bits_is_sys_pc2epc;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_1_bits_is_unique;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_1_bits_flush_on_commit;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_1_bits_ldst_is_rs1;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_0_1_bits_ldst;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_0_1_bits_lrs1;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_0_1_bits_lrs2;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_0_1_bits_lrs3;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_1_bits_ldst_val;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_0_1_bits_dst_rtype;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_0_1_bits_lrs1_rtype;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_0_1_bits_lrs2_rtype;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_1_bits_frs3_en;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_1_bits_fp_val;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_1_bits_fp_single;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_1_bits_xcpt_pf_if;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_1_bits_xcpt_ae_if;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_1_bits_xcpt_ma_if;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_1_bits_bp_debug_if;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_1_bits_bp_xcpt_if;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_0_1_bits_debug_fsrc;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_0_1_bits_debug_tsrc;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_2_valid;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_0_2_bits_uopc;	// core.scala:111:32
  wire [31:0]     _dispatcher_io_dis_uops_0_2_bits_inst;	// core.scala:111:32
  wire [31:0]     _dispatcher_io_dis_uops_0_2_bits_debug_inst;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_2_bits_is_rvc;	// core.scala:111:32
  wire [39:0]     _dispatcher_io_dis_uops_0_2_bits_debug_pc;	// core.scala:111:32
  wire [2:0]      _dispatcher_io_dis_uops_0_2_bits_iq_type;	// core.scala:111:32
  wire [9:0]      _dispatcher_io_dis_uops_0_2_bits_fu_code;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_2_bits_is_br;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_2_bits_is_jalr;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_2_bits_is_jal;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_2_bits_is_sfb;	// core.scala:111:32
  wire [15:0]     _dispatcher_io_dis_uops_0_2_bits_br_mask;	// core.scala:111:32
  wire [3:0]      _dispatcher_io_dis_uops_0_2_bits_br_tag;	// core.scala:111:32
  wire [4:0]      _dispatcher_io_dis_uops_0_2_bits_ftq_idx;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_2_bits_edge_inst;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_0_2_bits_pc_lob;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_2_bits_taken;	// core.scala:111:32
  wire [19:0]     _dispatcher_io_dis_uops_0_2_bits_imm_packed;	// core.scala:111:32
  wire [11:0]     _dispatcher_io_dis_uops_0_2_bits_csr_addr;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_0_2_bits_rob_idx;	// core.scala:111:32
  wire [4:0]      _dispatcher_io_dis_uops_0_2_bits_ldq_idx;	// core.scala:111:32
  wire [4:0]      _dispatcher_io_dis_uops_0_2_bits_stq_idx;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_0_2_bits_rxq_idx;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_0_2_bits_pdst;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_0_2_bits_prs1;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_0_2_bits_prs2;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_0_2_bits_prs3;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_2_bits_prs1_busy;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_2_bits_prs2_busy;	// core.scala:111:32
  wire [6:0]      _dispatcher_io_dis_uops_0_2_bits_stale_pdst;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_2_bits_exception;	// core.scala:111:32
  wire [63:0]     _dispatcher_io_dis_uops_0_2_bits_exc_cause;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_2_bits_bypassable;	// core.scala:111:32
  wire [4:0]      _dispatcher_io_dis_uops_0_2_bits_mem_cmd;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_0_2_bits_mem_size;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_2_bits_mem_signed;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_2_bits_is_fence;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_2_bits_is_fencei;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_2_bits_is_amo;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_2_bits_uses_ldq;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_2_bits_uses_stq;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_2_bits_is_sys_pc2epc;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_2_bits_is_unique;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_2_bits_flush_on_commit;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_2_bits_ldst_is_rs1;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_0_2_bits_ldst;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_0_2_bits_lrs1;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_0_2_bits_lrs2;	// core.scala:111:32
  wire [5:0]      _dispatcher_io_dis_uops_0_2_bits_lrs3;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_2_bits_ldst_val;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_0_2_bits_dst_rtype;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_0_2_bits_lrs1_rtype;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_0_2_bits_lrs2_rtype;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_2_bits_frs3_en;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_2_bits_fp_val;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_2_bits_fp_single;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_2_bits_xcpt_pf_if;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_2_bits_xcpt_ae_if;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_2_bits_xcpt_ma_if;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_2_bits_bp_debug_if;	// core.scala:111:32
  wire            _dispatcher_io_dis_uops_0_2_bits_bp_xcpt_if;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_0_2_bits_debug_fsrc;	// core.scala:111:32
  wire [1:0]      _dispatcher_io_dis_uops_0_2_bits_debug_tsrc;	// core.scala:111:32
  wire            _int_issue_unit_io_dis_uops_0_ready;	// core.scala:107:32
  wire            _int_issue_unit_io_dis_uops_1_ready;	// core.scala:107:32
  wire            _int_issue_unit_io_dis_uops_2_ready;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_valids_0;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_valids_1;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_valids_2;	// core.scala:107:32
  wire [6:0]      _int_issue_unit_io_iss_uops_0_uopc;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_0_is_rvc;	// core.scala:107:32
  wire [9:0]      _int_issue_unit_io_iss_uops_0_fu_code;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_0_iw_p1_poisoned;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_0_iw_p2_poisoned;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_0_is_br;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_0_is_jalr;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_0_is_jal;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_0_is_sfb;	// core.scala:107:32
  wire [15:0]     _int_issue_unit_io_iss_uops_0_br_mask;	// core.scala:107:32
  wire [3:0]      _int_issue_unit_io_iss_uops_0_br_tag;	// core.scala:107:32
  wire [4:0]      _int_issue_unit_io_iss_uops_0_ftq_idx;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_0_edge_inst;	// core.scala:107:32
  wire [5:0]      _int_issue_unit_io_iss_uops_0_pc_lob;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_0_taken;	// core.scala:107:32
  wire [19:0]     _int_issue_unit_io_iss_uops_0_imm_packed;	// core.scala:107:32
  wire [6:0]      _int_issue_unit_io_iss_uops_0_rob_idx;	// core.scala:107:32
  wire [4:0]      _int_issue_unit_io_iss_uops_0_ldq_idx;	// core.scala:107:32
  wire [4:0]      _int_issue_unit_io_iss_uops_0_stq_idx;	// core.scala:107:32
  wire [6:0]      _int_issue_unit_io_iss_uops_0_pdst;	// core.scala:107:32
  wire [6:0]      _int_issue_unit_io_iss_uops_0_prs1;	// core.scala:107:32
  wire [6:0]      _int_issue_unit_io_iss_uops_0_prs2;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_0_bypassable;	// core.scala:107:32
  wire [4:0]      _int_issue_unit_io_iss_uops_0_mem_cmd;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_0_is_amo;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_0_uses_stq;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_0_ldst_val;	// core.scala:107:32
  wire [1:0]      _int_issue_unit_io_iss_uops_0_dst_rtype;	// core.scala:107:32
  wire [1:0]      _int_issue_unit_io_iss_uops_0_lrs1_rtype;	// core.scala:107:32
  wire [1:0]      _int_issue_unit_io_iss_uops_0_lrs2_rtype;	// core.scala:107:32
  wire [6:0]      _int_issue_unit_io_iss_uops_1_uopc;	// core.scala:107:32
  wire [31:0]     _int_issue_unit_io_iss_uops_1_inst;	// core.scala:107:32
  wire [31:0]     _int_issue_unit_io_iss_uops_1_debug_inst;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_1_is_rvc;	// core.scala:107:32
  wire [39:0]     _int_issue_unit_io_iss_uops_1_debug_pc;	// core.scala:107:32
  wire [2:0]      _int_issue_unit_io_iss_uops_1_iq_type;	// core.scala:107:32
  wire [9:0]      _int_issue_unit_io_iss_uops_1_fu_code;	// core.scala:107:32
  wire [1:0]      _int_issue_unit_io_iss_uops_1_iw_state;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_1_iw_p1_poisoned;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_1_iw_p2_poisoned;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_1_is_br;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_1_is_jalr;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_1_is_jal;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_1_is_sfb;	// core.scala:107:32
  wire [15:0]     _int_issue_unit_io_iss_uops_1_br_mask;	// core.scala:107:32
  wire [3:0]      _int_issue_unit_io_iss_uops_1_br_tag;	// core.scala:107:32
  wire [4:0]      _int_issue_unit_io_iss_uops_1_ftq_idx;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_1_edge_inst;	// core.scala:107:32
  wire [5:0]      _int_issue_unit_io_iss_uops_1_pc_lob;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_1_taken;	// core.scala:107:32
  wire [19:0]     _int_issue_unit_io_iss_uops_1_imm_packed;	// core.scala:107:32
  wire [11:0]     _int_issue_unit_io_iss_uops_1_csr_addr;	// core.scala:107:32
  wire [6:0]      _int_issue_unit_io_iss_uops_1_rob_idx;	// core.scala:107:32
  wire [4:0]      _int_issue_unit_io_iss_uops_1_ldq_idx;	// core.scala:107:32
  wire [4:0]      _int_issue_unit_io_iss_uops_1_stq_idx;	// core.scala:107:32
  wire [1:0]      _int_issue_unit_io_iss_uops_1_rxq_idx;	// core.scala:107:32
  wire [6:0]      _int_issue_unit_io_iss_uops_1_pdst;	// core.scala:107:32
  wire [6:0]      _int_issue_unit_io_iss_uops_1_prs1;	// core.scala:107:32
  wire [6:0]      _int_issue_unit_io_iss_uops_1_prs2;	// core.scala:107:32
  wire [6:0]      _int_issue_unit_io_iss_uops_1_prs3;	// core.scala:107:32
  wire [4:0]      _int_issue_unit_io_iss_uops_1_ppred;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_1_prs1_busy;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_1_prs2_busy;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_1_prs3_busy;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_1_ppred_busy;	// core.scala:107:32
  wire [6:0]      _int_issue_unit_io_iss_uops_1_stale_pdst;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_1_exception;	// core.scala:107:32
  wire [63:0]     _int_issue_unit_io_iss_uops_1_exc_cause;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_1_bypassable;	// core.scala:107:32
  wire [4:0]      _int_issue_unit_io_iss_uops_1_mem_cmd;	// core.scala:107:32
  wire [1:0]      _int_issue_unit_io_iss_uops_1_mem_size;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_1_mem_signed;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_1_is_fence;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_1_is_fencei;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_1_is_amo;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_1_uses_ldq;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_1_uses_stq;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_1_is_sys_pc2epc;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_1_is_unique;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_1_flush_on_commit;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_1_ldst_is_rs1;	// core.scala:107:32
  wire [5:0]      _int_issue_unit_io_iss_uops_1_ldst;	// core.scala:107:32
  wire [5:0]      _int_issue_unit_io_iss_uops_1_lrs1;	// core.scala:107:32
  wire [5:0]      _int_issue_unit_io_iss_uops_1_lrs2;	// core.scala:107:32
  wire [5:0]      _int_issue_unit_io_iss_uops_1_lrs3;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_1_ldst_val;	// core.scala:107:32
  wire [1:0]      _int_issue_unit_io_iss_uops_1_dst_rtype;	// core.scala:107:32
  wire [1:0]      _int_issue_unit_io_iss_uops_1_lrs1_rtype;	// core.scala:107:32
  wire [1:0]      _int_issue_unit_io_iss_uops_1_lrs2_rtype;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_1_frs3_en;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_1_fp_val;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_1_fp_single;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_1_xcpt_pf_if;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_1_xcpt_ae_if;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_1_xcpt_ma_if;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_1_bp_debug_if;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_1_bp_xcpt_if;	// core.scala:107:32
  wire [1:0]      _int_issue_unit_io_iss_uops_1_debug_fsrc;	// core.scala:107:32
  wire [1:0]      _int_issue_unit_io_iss_uops_1_debug_tsrc;	// core.scala:107:32
  wire [6:0]      _int_issue_unit_io_iss_uops_2_uopc;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_2_is_rvc;	// core.scala:107:32
  wire [9:0]      _int_issue_unit_io_iss_uops_2_fu_code;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_2_iw_p1_poisoned;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_2_iw_p2_poisoned;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_2_is_br;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_2_is_jalr;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_2_is_jal;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_2_is_sfb;	// core.scala:107:32
  wire [15:0]     _int_issue_unit_io_iss_uops_2_br_mask;	// core.scala:107:32
  wire [3:0]      _int_issue_unit_io_iss_uops_2_br_tag;	// core.scala:107:32
  wire [4:0]      _int_issue_unit_io_iss_uops_2_ftq_idx;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_2_edge_inst;	// core.scala:107:32
  wire [5:0]      _int_issue_unit_io_iss_uops_2_pc_lob;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_2_taken;	// core.scala:107:32
  wire [19:0]     _int_issue_unit_io_iss_uops_2_imm_packed;	// core.scala:107:32
  wire [6:0]      _int_issue_unit_io_iss_uops_2_rob_idx;	// core.scala:107:32
  wire [4:0]      _int_issue_unit_io_iss_uops_2_ldq_idx;	// core.scala:107:32
  wire [4:0]      _int_issue_unit_io_iss_uops_2_stq_idx;	// core.scala:107:32
  wire [6:0]      _int_issue_unit_io_iss_uops_2_pdst;	// core.scala:107:32
  wire [6:0]      _int_issue_unit_io_iss_uops_2_prs1;	// core.scala:107:32
  wire [6:0]      _int_issue_unit_io_iss_uops_2_prs2;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_2_bypassable;	// core.scala:107:32
  wire [4:0]      _int_issue_unit_io_iss_uops_2_mem_cmd;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_2_is_amo;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_2_uses_stq;	// core.scala:107:32
  wire            _int_issue_unit_io_iss_uops_2_ldst_val;	// core.scala:107:32
  wire [1:0]      _int_issue_unit_io_iss_uops_2_dst_rtype;	// core.scala:107:32
  wire [1:0]      _int_issue_unit_io_iss_uops_2_lrs1_rtype;	// core.scala:107:32
  wire [1:0]      _int_issue_unit_io_iss_uops_2_lrs2_rtype;	// core.scala:107:32
  wire            _mem_issue_unit_io_dis_uops_0_ready;	// core.scala:105:32
  wire            _mem_issue_unit_io_dis_uops_1_ready;	// core.scala:105:32
  wire            _mem_issue_unit_io_dis_uops_2_ready;	// core.scala:105:32
  wire            _mem_issue_unit_io_iss_valids_0;	// core.scala:105:32
  wire [6:0]      _mem_issue_unit_io_iss_uops_0_uopc;	// core.scala:105:32
  wire [31:0]     _mem_issue_unit_io_iss_uops_0_inst;	// core.scala:105:32
  wire [31:0]     _mem_issue_unit_io_iss_uops_0_debug_inst;	// core.scala:105:32
  wire            _mem_issue_unit_io_iss_uops_0_is_rvc;	// core.scala:105:32
  wire [39:0]     _mem_issue_unit_io_iss_uops_0_debug_pc;	// core.scala:105:32
  wire [2:0]      _mem_issue_unit_io_iss_uops_0_iq_type;	// core.scala:105:32
  wire [9:0]      _mem_issue_unit_io_iss_uops_0_fu_code;	// core.scala:105:32
  wire [1:0]      _mem_issue_unit_io_iss_uops_0_iw_state;	// core.scala:105:32
  wire            _mem_issue_unit_io_iss_uops_0_iw_p1_poisoned;	// core.scala:105:32
  wire            _mem_issue_unit_io_iss_uops_0_iw_p2_poisoned;	// core.scala:105:32
  wire            _mem_issue_unit_io_iss_uops_0_is_br;	// core.scala:105:32
  wire            _mem_issue_unit_io_iss_uops_0_is_jalr;	// core.scala:105:32
  wire            _mem_issue_unit_io_iss_uops_0_is_jal;	// core.scala:105:32
  wire            _mem_issue_unit_io_iss_uops_0_is_sfb;	// core.scala:105:32
  wire [15:0]     _mem_issue_unit_io_iss_uops_0_br_mask;	// core.scala:105:32
  wire [3:0]      _mem_issue_unit_io_iss_uops_0_br_tag;	// core.scala:105:32
  wire [4:0]      _mem_issue_unit_io_iss_uops_0_ftq_idx;	// core.scala:105:32
  wire            _mem_issue_unit_io_iss_uops_0_edge_inst;	// core.scala:105:32
  wire [5:0]      _mem_issue_unit_io_iss_uops_0_pc_lob;	// core.scala:105:32
  wire            _mem_issue_unit_io_iss_uops_0_taken;	// core.scala:105:32
  wire [19:0]     _mem_issue_unit_io_iss_uops_0_imm_packed;	// core.scala:105:32
  wire [11:0]     _mem_issue_unit_io_iss_uops_0_csr_addr;	// core.scala:105:32
  wire [6:0]      _mem_issue_unit_io_iss_uops_0_rob_idx;	// core.scala:105:32
  wire [4:0]      _mem_issue_unit_io_iss_uops_0_ldq_idx;	// core.scala:105:32
  wire [4:0]      _mem_issue_unit_io_iss_uops_0_stq_idx;	// core.scala:105:32
  wire [1:0]      _mem_issue_unit_io_iss_uops_0_rxq_idx;	// core.scala:105:32
  wire [6:0]      _mem_issue_unit_io_iss_uops_0_pdst;	// core.scala:105:32
  wire [6:0]      _mem_issue_unit_io_iss_uops_0_prs1;	// core.scala:105:32
  wire [6:0]      _mem_issue_unit_io_iss_uops_0_prs2;	// core.scala:105:32
  wire [6:0]      _mem_issue_unit_io_iss_uops_0_prs3;	// core.scala:105:32
  wire [4:0]      _mem_issue_unit_io_iss_uops_0_ppred;	// core.scala:105:32
  wire            _mem_issue_unit_io_iss_uops_0_prs1_busy;	// core.scala:105:32
  wire            _mem_issue_unit_io_iss_uops_0_prs2_busy;	// core.scala:105:32
  wire            _mem_issue_unit_io_iss_uops_0_prs3_busy;	// core.scala:105:32
  wire            _mem_issue_unit_io_iss_uops_0_ppred_busy;	// core.scala:105:32
  wire [6:0]      _mem_issue_unit_io_iss_uops_0_stale_pdst;	// core.scala:105:32
  wire            _mem_issue_unit_io_iss_uops_0_exception;	// core.scala:105:32
  wire [63:0]     _mem_issue_unit_io_iss_uops_0_exc_cause;	// core.scala:105:32
  wire            _mem_issue_unit_io_iss_uops_0_bypassable;	// core.scala:105:32
  wire [4:0]      _mem_issue_unit_io_iss_uops_0_mem_cmd;	// core.scala:105:32
  wire [1:0]      _mem_issue_unit_io_iss_uops_0_mem_size;	// core.scala:105:32
  wire            _mem_issue_unit_io_iss_uops_0_mem_signed;	// core.scala:105:32
  wire            _mem_issue_unit_io_iss_uops_0_is_fence;	// core.scala:105:32
  wire            _mem_issue_unit_io_iss_uops_0_is_fencei;	// core.scala:105:32
  wire            _mem_issue_unit_io_iss_uops_0_is_amo;	// core.scala:105:32
  wire            _mem_issue_unit_io_iss_uops_0_uses_ldq;	// core.scala:105:32
  wire            _mem_issue_unit_io_iss_uops_0_uses_stq;	// core.scala:105:32
  wire            _mem_issue_unit_io_iss_uops_0_is_sys_pc2epc;	// core.scala:105:32
  wire            _mem_issue_unit_io_iss_uops_0_is_unique;	// core.scala:105:32
  wire            _mem_issue_unit_io_iss_uops_0_flush_on_commit;	// core.scala:105:32
  wire            _mem_issue_unit_io_iss_uops_0_ldst_is_rs1;	// core.scala:105:32
  wire [5:0]      _mem_issue_unit_io_iss_uops_0_ldst;	// core.scala:105:32
  wire [5:0]      _mem_issue_unit_io_iss_uops_0_lrs1;	// core.scala:105:32
  wire [5:0]      _mem_issue_unit_io_iss_uops_0_lrs2;	// core.scala:105:32
  wire [5:0]      _mem_issue_unit_io_iss_uops_0_lrs3;	// core.scala:105:32
  wire            _mem_issue_unit_io_iss_uops_0_ldst_val;	// core.scala:105:32
  wire [1:0]      _mem_issue_unit_io_iss_uops_0_dst_rtype;	// core.scala:105:32
  wire [1:0]      _mem_issue_unit_io_iss_uops_0_lrs1_rtype;	// core.scala:105:32
  wire [1:0]      _mem_issue_unit_io_iss_uops_0_lrs2_rtype;	// core.scala:105:32
  wire            _mem_issue_unit_io_iss_uops_0_frs3_en;	// core.scala:105:32
  wire            _mem_issue_unit_io_iss_uops_0_fp_val;	// core.scala:105:32
  wire            _mem_issue_unit_io_iss_uops_0_fp_single;	// core.scala:105:32
  wire            _mem_issue_unit_io_iss_uops_0_xcpt_pf_if;	// core.scala:105:32
  wire            _mem_issue_unit_io_iss_uops_0_xcpt_ae_if;	// core.scala:105:32
  wire            _mem_issue_unit_io_iss_uops_0_xcpt_ma_if;	// core.scala:105:32
  wire            _mem_issue_unit_io_iss_uops_0_bp_debug_if;	// core.scala:105:32
  wire            _mem_issue_unit_io_iss_uops_0_bp_xcpt_if;	// core.scala:105:32
  wire [1:0]      _mem_issue_unit_io_iss_uops_0_debug_fsrc;	// core.scala:105:32
  wire [1:0]      _mem_issue_unit_io_iss_uops_0_debug_tsrc;	// core.scala:105:32
  wire            _fp_rename_stage_io_ren_stalls_0;	// core.scala:101:46
  wire            _fp_rename_stage_io_ren_stalls_1;	// core.scala:101:46
  wire            _fp_rename_stage_io_ren_stalls_2;	// core.scala:101:46
  wire [6:0]      _fp_rename_stage_io_ren2_uops_0_pdst;	// core.scala:101:46
  wire [6:0]      _fp_rename_stage_io_ren2_uops_0_prs1;	// core.scala:101:46
  wire [6:0]      _fp_rename_stage_io_ren2_uops_0_prs2;	// core.scala:101:46
  wire [6:0]      _fp_rename_stage_io_ren2_uops_0_prs3;	// core.scala:101:46
  wire            _fp_rename_stage_io_ren2_uops_0_prs1_busy;	// core.scala:101:46
  wire            _fp_rename_stage_io_ren2_uops_0_prs2_busy;	// core.scala:101:46
  wire            _fp_rename_stage_io_ren2_uops_0_prs3_busy;	// core.scala:101:46
  wire [6:0]      _fp_rename_stage_io_ren2_uops_0_stale_pdst;	// core.scala:101:46
  wire [6:0]      _fp_rename_stage_io_ren2_uops_1_pdst;	// core.scala:101:46
  wire [6:0]      _fp_rename_stage_io_ren2_uops_1_prs1;	// core.scala:101:46
  wire [6:0]      _fp_rename_stage_io_ren2_uops_1_prs2;	// core.scala:101:46
  wire [6:0]      _fp_rename_stage_io_ren2_uops_1_prs3;	// core.scala:101:46
  wire            _fp_rename_stage_io_ren2_uops_1_prs1_busy;	// core.scala:101:46
  wire            _fp_rename_stage_io_ren2_uops_1_prs2_busy;	// core.scala:101:46
  wire            _fp_rename_stage_io_ren2_uops_1_prs3_busy;	// core.scala:101:46
  wire [6:0]      _fp_rename_stage_io_ren2_uops_1_stale_pdst;	// core.scala:101:46
  wire [6:0]      _fp_rename_stage_io_ren2_uops_2_pdst;	// core.scala:101:46
  wire [6:0]      _fp_rename_stage_io_ren2_uops_2_prs1;	// core.scala:101:46
  wire [6:0]      _fp_rename_stage_io_ren2_uops_2_prs2;	// core.scala:101:46
  wire [6:0]      _fp_rename_stage_io_ren2_uops_2_prs3;	// core.scala:101:46
  wire            _fp_rename_stage_io_ren2_uops_2_prs1_busy;	// core.scala:101:46
  wire            _fp_rename_stage_io_ren2_uops_2_prs2_busy;	// core.scala:101:46
  wire            _fp_rename_stage_io_ren2_uops_2_prs3_busy;	// core.scala:101:46
  wire [6:0]      _fp_rename_stage_io_ren2_uops_2_stale_pdst;	// core.scala:101:46
  wire            _rename_stage_io_ren_stalls_0;	// core.scala:100:32
  wire            _rename_stage_io_ren_stalls_1;	// core.scala:100:32
  wire            _rename_stage_io_ren_stalls_2;	// core.scala:100:32
  wire            _rename_stage_io_ren2_mask_0;	// core.scala:100:32
  wire            _rename_stage_io_ren2_mask_1;	// core.scala:100:32
  wire            _rename_stage_io_ren2_mask_2;	// core.scala:100:32
  wire [6:0]      _rename_stage_io_ren2_uops_0_uopc;	// core.scala:100:32
  wire [31:0]     _rename_stage_io_ren2_uops_0_inst;	// core.scala:100:32
  wire [31:0]     _rename_stage_io_ren2_uops_0_debug_inst;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_0_is_rvc;	// core.scala:100:32
  wire [39:0]     _rename_stage_io_ren2_uops_0_debug_pc;	// core.scala:100:32
  wire [2:0]      _rename_stage_io_ren2_uops_0_iq_type;	// core.scala:100:32
  wire [9:0]      _rename_stage_io_ren2_uops_0_fu_code;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_0_is_br;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_0_is_jalr;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_0_is_jal;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_0_is_sfb;	// core.scala:100:32
  wire [15:0]     _rename_stage_io_ren2_uops_0_br_mask;	// core.scala:100:32
  wire [3:0]      _rename_stage_io_ren2_uops_0_br_tag;	// core.scala:100:32
  wire [4:0]      _rename_stage_io_ren2_uops_0_ftq_idx;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_0_edge_inst;	// core.scala:100:32
  wire [5:0]      _rename_stage_io_ren2_uops_0_pc_lob;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_0_taken;	// core.scala:100:32
  wire [19:0]     _rename_stage_io_ren2_uops_0_imm_packed;	// core.scala:100:32
  wire [11:0]     _rename_stage_io_ren2_uops_0_csr_addr;	// core.scala:100:32
  wire [1:0]      _rename_stage_io_ren2_uops_0_rxq_idx;	// core.scala:100:32
  wire [6:0]      _rename_stage_io_ren2_uops_0_pdst;	// core.scala:100:32
  wire [6:0]      _rename_stage_io_ren2_uops_0_prs1;	// core.scala:100:32
  wire [6:0]      _rename_stage_io_ren2_uops_0_prs2;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_0_prs1_busy;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_0_prs2_busy;	// core.scala:100:32
  wire [6:0]      _rename_stage_io_ren2_uops_0_stale_pdst;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_0_exception;	// core.scala:100:32
  wire [63:0]     _rename_stage_io_ren2_uops_0_exc_cause;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_0_bypassable;	// core.scala:100:32
  wire [4:0]      _rename_stage_io_ren2_uops_0_mem_cmd;	// core.scala:100:32
  wire [1:0]      _rename_stage_io_ren2_uops_0_mem_size;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_0_mem_signed;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_0_is_fence;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_0_is_fencei;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_0_is_amo;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_0_uses_ldq;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_0_uses_stq;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_0_is_sys_pc2epc;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_0_is_unique;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_0_flush_on_commit;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_0_ldst_is_rs1;	// core.scala:100:32
  wire [5:0]      _rename_stage_io_ren2_uops_0_ldst;	// core.scala:100:32
  wire [5:0]      _rename_stage_io_ren2_uops_0_lrs1;	// core.scala:100:32
  wire [5:0]      _rename_stage_io_ren2_uops_0_lrs2;	// core.scala:100:32
  wire [5:0]      _rename_stage_io_ren2_uops_0_lrs3;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_0_ldst_val;	// core.scala:100:32
  wire [1:0]      _rename_stage_io_ren2_uops_0_dst_rtype;	// core.scala:100:32
  wire [1:0]      _rename_stage_io_ren2_uops_0_lrs1_rtype;	// core.scala:100:32
  wire [1:0]      _rename_stage_io_ren2_uops_0_lrs2_rtype;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_0_frs3_en;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_0_fp_val;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_0_fp_single;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_0_xcpt_pf_if;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_0_xcpt_ae_if;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_0_xcpt_ma_if;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_0_bp_debug_if;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_0_bp_xcpt_if;	// core.scala:100:32
  wire [1:0]      _rename_stage_io_ren2_uops_0_debug_fsrc;	// core.scala:100:32
  wire [1:0]      _rename_stage_io_ren2_uops_0_debug_tsrc;	// core.scala:100:32
  wire [6:0]      _rename_stage_io_ren2_uops_1_uopc;	// core.scala:100:32
  wire [31:0]     _rename_stage_io_ren2_uops_1_inst;	// core.scala:100:32
  wire [31:0]     _rename_stage_io_ren2_uops_1_debug_inst;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_1_is_rvc;	// core.scala:100:32
  wire [39:0]     _rename_stage_io_ren2_uops_1_debug_pc;	// core.scala:100:32
  wire [2:0]      _rename_stage_io_ren2_uops_1_iq_type;	// core.scala:100:32
  wire [9:0]      _rename_stage_io_ren2_uops_1_fu_code;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_1_is_br;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_1_is_jalr;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_1_is_jal;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_1_is_sfb;	// core.scala:100:32
  wire [15:0]     _rename_stage_io_ren2_uops_1_br_mask;	// core.scala:100:32
  wire [3:0]      _rename_stage_io_ren2_uops_1_br_tag;	// core.scala:100:32
  wire [4:0]      _rename_stage_io_ren2_uops_1_ftq_idx;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_1_edge_inst;	// core.scala:100:32
  wire [5:0]      _rename_stage_io_ren2_uops_1_pc_lob;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_1_taken;	// core.scala:100:32
  wire [19:0]     _rename_stage_io_ren2_uops_1_imm_packed;	// core.scala:100:32
  wire [11:0]     _rename_stage_io_ren2_uops_1_csr_addr;	// core.scala:100:32
  wire [1:0]      _rename_stage_io_ren2_uops_1_rxq_idx;	// core.scala:100:32
  wire [6:0]      _rename_stage_io_ren2_uops_1_pdst;	// core.scala:100:32
  wire [6:0]      _rename_stage_io_ren2_uops_1_prs1;	// core.scala:100:32
  wire [6:0]      _rename_stage_io_ren2_uops_1_prs2;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_1_prs1_busy;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_1_prs2_busy;	// core.scala:100:32
  wire [6:0]      _rename_stage_io_ren2_uops_1_stale_pdst;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_1_exception;	// core.scala:100:32
  wire [63:0]     _rename_stage_io_ren2_uops_1_exc_cause;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_1_bypassable;	// core.scala:100:32
  wire [4:0]      _rename_stage_io_ren2_uops_1_mem_cmd;	// core.scala:100:32
  wire [1:0]      _rename_stage_io_ren2_uops_1_mem_size;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_1_mem_signed;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_1_is_fence;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_1_is_fencei;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_1_is_amo;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_1_uses_ldq;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_1_uses_stq;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_1_is_sys_pc2epc;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_1_is_unique;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_1_flush_on_commit;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_1_ldst_is_rs1;	// core.scala:100:32
  wire [5:0]      _rename_stage_io_ren2_uops_1_ldst;	// core.scala:100:32
  wire [5:0]      _rename_stage_io_ren2_uops_1_lrs1;	// core.scala:100:32
  wire [5:0]      _rename_stage_io_ren2_uops_1_lrs2;	// core.scala:100:32
  wire [5:0]      _rename_stage_io_ren2_uops_1_lrs3;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_1_ldst_val;	// core.scala:100:32
  wire [1:0]      _rename_stage_io_ren2_uops_1_dst_rtype;	// core.scala:100:32
  wire [1:0]      _rename_stage_io_ren2_uops_1_lrs1_rtype;	// core.scala:100:32
  wire [1:0]      _rename_stage_io_ren2_uops_1_lrs2_rtype;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_1_frs3_en;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_1_fp_val;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_1_fp_single;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_1_xcpt_pf_if;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_1_xcpt_ae_if;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_1_xcpt_ma_if;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_1_bp_debug_if;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_1_bp_xcpt_if;	// core.scala:100:32
  wire [1:0]      _rename_stage_io_ren2_uops_1_debug_fsrc;	// core.scala:100:32
  wire [1:0]      _rename_stage_io_ren2_uops_1_debug_tsrc;	// core.scala:100:32
  wire [6:0]      _rename_stage_io_ren2_uops_2_uopc;	// core.scala:100:32
  wire [31:0]     _rename_stage_io_ren2_uops_2_inst;	// core.scala:100:32
  wire [31:0]     _rename_stage_io_ren2_uops_2_debug_inst;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_2_is_rvc;	// core.scala:100:32
  wire [39:0]     _rename_stage_io_ren2_uops_2_debug_pc;	// core.scala:100:32
  wire [2:0]      _rename_stage_io_ren2_uops_2_iq_type;	// core.scala:100:32
  wire [9:0]      _rename_stage_io_ren2_uops_2_fu_code;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_2_is_br;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_2_is_jalr;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_2_is_jal;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_2_is_sfb;	// core.scala:100:32
  wire [15:0]     _rename_stage_io_ren2_uops_2_br_mask;	// core.scala:100:32
  wire [3:0]      _rename_stage_io_ren2_uops_2_br_tag;	// core.scala:100:32
  wire [4:0]      _rename_stage_io_ren2_uops_2_ftq_idx;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_2_edge_inst;	// core.scala:100:32
  wire [5:0]      _rename_stage_io_ren2_uops_2_pc_lob;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_2_taken;	// core.scala:100:32
  wire [19:0]     _rename_stage_io_ren2_uops_2_imm_packed;	// core.scala:100:32
  wire [11:0]     _rename_stage_io_ren2_uops_2_csr_addr;	// core.scala:100:32
  wire [1:0]      _rename_stage_io_ren2_uops_2_rxq_idx;	// core.scala:100:32
  wire [6:0]      _rename_stage_io_ren2_uops_2_pdst;	// core.scala:100:32
  wire [6:0]      _rename_stage_io_ren2_uops_2_prs1;	// core.scala:100:32
  wire [6:0]      _rename_stage_io_ren2_uops_2_prs2;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_2_prs1_busy;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_2_prs2_busy;	// core.scala:100:32
  wire [6:0]      _rename_stage_io_ren2_uops_2_stale_pdst;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_2_exception;	// core.scala:100:32
  wire [63:0]     _rename_stage_io_ren2_uops_2_exc_cause;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_2_bypassable;	// core.scala:100:32
  wire [4:0]      _rename_stage_io_ren2_uops_2_mem_cmd;	// core.scala:100:32
  wire [1:0]      _rename_stage_io_ren2_uops_2_mem_size;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_2_mem_signed;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_2_is_fence;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_2_is_fencei;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_2_is_amo;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_2_uses_ldq;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_2_uses_stq;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_2_is_sys_pc2epc;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_2_is_unique;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_2_flush_on_commit;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_2_ldst_is_rs1;	// core.scala:100:32
  wire [5:0]      _rename_stage_io_ren2_uops_2_ldst;	// core.scala:100:32
  wire [5:0]      _rename_stage_io_ren2_uops_2_lrs1;	// core.scala:100:32
  wire [5:0]      _rename_stage_io_ren2_uops_2_lrs2;	// core.scala:100:32
  wire [5:0]      _rename_stage_io_ren2_uops_2_lrs3;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_2_ldst_val;	// core.scala:100:32
  wire [1:0]      _rename_stage_io_ren2_uops_2_dst_rtype;	// core.scala:100:32
  wire [1:0]      _rename_stage_io_ren2_uops_2_lrs1_rtype;	// core.scala:100:32
  wire [1:0]      _rename_stage_io_ren2_uops_2_lrs2_rtype;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_2_frs3_en;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_2_fp_val;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_2_fp_single;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_2_xcpt_pf_if;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_2_xcpt_ae_if;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_2_xcpt_ma_if;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_2_bp_debug_if;	// core.scala:100:32
  wire            _rename_stage_io_ren2_uops_2_bp_xcpt_if;	// core.scala:100:32
  wire [1:0]      _rename_stage_io_ren2_uops_2_debug_fsrc;	// core.scala:100:32
  wire [1:0]      _rename_stage_io_ren2_uops_2_debug_tsrc;	// core.scala:100:32
  wire [3:0]      _dec_brmask_logic_io_br_tag_0;	// core.scala:99:32
  wire [3:0]      _dec_brmask_logic_io_br_tag_1;	// core.scala:99:32
  wire [3:0]      _dec_brmask_logic_io_br_tag_2;	// core.scala:99:32
  wire [15:0]     _dec_brmask_logic_io_br_mask_0;	// core.scala:99:32
  wire [15:0]     _dec_brmask_logic_io_br_mask_1;	// core.scala:99:32
  wire [15:0]     _dec_brmask_logic_io_br_mask_2;	// core.scala:99:32
  wire            _dec_brmask_logic_io_is_full_0;	// core.scala:99:32
  wire            _dec_brmask_logic_io_is_full_1;	// core.scala:99:32
  wire            _dec_brmask_logic_io_is_full_2;	// core.scala:99:32
  wire [6:0]      _decode_units_2_io_deq_uop_uopc;	// core.scala:98:79
  wire [31:0]     _decode_units_2_io_deq_uop_inst;	// core.scala:98:79
  wire [31:0]     _decode_units_2_io_deq_uop_debug_inst;	// core.scala:98:79
  wire            _decode_units_2_io_deq_uop_is_rvc;	// core.scala:98:79
  wire [39:0]     _decode_units_2_io_deq_uop_debug_pc;	// core.scala:98:79
  wire [2:0]      _decode_units_2_io_deq_uop_iq_type;	// core.scala:98:79
  wire [9:0]      _decode_units_2_io_deq_uop_fu_code;	// core.scala:98:79
  wire [3:0]      _decode_units_2_io_deq_uop_ctrl_br_type;	// core.scala:98:79
  wire [1:0]      _decode_units_2_io_deq_uop_ctrl_op1_sel;	// core.scala:98:79
  wire [2:0]      _decode_units_2_io_deq_uop_ctrl_op2_sel;	// core.scala:98:79
  wire [2:0]      _decode_units_2_io_deq_uop_ctrl_imm_sel;	// core.scala:98:79
  wire [3:0]      _decode_units_2_io_deq_uop_ctrl_op_fcn;	// core.scala:98:79
  wire            _decode_units_2_io_deq_uop_ctrl_fcn_dw;	// core.scala:98:79
  wire [2:0]      _decode_units_2_io_deq_uop_ctrl_csr_cmd;	// core.scala:98:79
  wire            _decode_units_2_io_deq_uop_ctrl_is_load;	// core.scala:98:79
  wire            _decode_units_2_io_deq_uop_ctrl_is_sta;	// core.scala:98:79
  wire            _decode_units_2_io_deq_uop_ctrl_is_std;	// core.scala:98:79
  wire [1:0]      _decode_units_2_io_deq_uop_iw_state;	// core.scala:98:79
  wire            _decode_units_2_io_deq_uop_iw_p1_poisoned;	// core.scala:98:79
  wire            _decode_units_2_io_deq_uop_iw_p2_poisoned;	// core.scala:98:79
  wire            _decode_units_2_io_deq_uop_is_br;	// core.scala:98:79
  wire            _decode_units_2_io_deq_uop_is_jalr;	// core.scala:98:79
  wire            _decode_units_2_io_deq_uop_is_jal;	// core.scala:98:79
  wire            _decode_units_2_io_deq_uop_is_sfb;	// core.scala:98:79
  wire [4:0]      _decode_units_2_io_deq_uop_ftq_idx;	// core.scala:98:79
  wire            _decode_units_2_io_deq_uop_edge_inst;	// core.scala:98:79
  wire [5:0]      _decode_units_2_io_deq_uop_pc_lob;	// core.scala:98:79
  wire            _decode_units_2_io_deq_uop_taken;	// core.scala:98:79
  wire [19:0]     _decode_units_2_io_deq_uop_imm_packed;	// core.scala:98:79
  wire [11:0]     _decode_units_2_io_deq_uop_csr_addr;	// core.scala:98:79
  wire [1:0]      _decode_units_2_io_deq_uop_rxq_idx;	// core.scala:98:79
  wire            _decode_units_2_io_deq_uop_exception;	// core.scala:98:79
  wire [63:0]     _decode_units_2_io_deq_uop_exc_cause;	// core.scala:98:79
  wire            _decode_units_2_io_deq_uop_bypassable;	// core.scala:98:79
  wire [4:0]      _decode_units_2_io_deq_uop_mem_cmd;	// core.scala:98:79
  wire [1:0]      _decode_units_2_io_deq_uop_mem_size;	// core.scala:98:79
  wire            _decode_units_2_io_deq_uop_mem_signed;	// core.scala:98:79
  wire            _decode_units_2_io_deq_uop_is_fence;	// core.scala:98:79
  wire            _decode_units_2_io_deq_uop_is_fencei;	// core.scala:98:79
  wire            _decode_units_2_io_deq_uop_is_amo;	// core.scala:98:79
  wire            _decode_units_2_io_deq_uop_uses_ldq;	// core.scala:98:79
  wire            _decode_units_2_io_deq_uop_uses_stq;	// core.scala:98:79
  wire            _decode_units_2_io_deq_uop_is_sys_pc2epc;	// core.scala:98:79
  wire            _decode_units_2_io_deq_uop_is_unique;	// core.scala:98:79
  wire            _decode_units_2_io_deq_uop_flush_on_commit;	// core.scala:98:79
  wire [5:0]      _decode_units_2_io_deq_uop_ldst;	// core.scala:98:79
  wire [5:0]      _decode_units_2_io_deq_uop_lrs1;	// core.scala:98:79
  wire [5:0]      _decode_units_2_io_deq_uop_lrs2;	// core.scala:98:79
  wire [5:0]      _decode_units_2_io_deq_uop_lrs3;	// core.scala:98:79
  wire            _decode_units_2_io_deq_uop_ldst_val;	// core.scala:98:79
  wire [1:0]      _decode_units_2_io_deq_uop_dst_rtype;	// core.scala:98:79
  wire [1:0]      _decode_units_2_io_deq_uop_lrs1_rtype;	// core.scala:98:79
  wire [1:0]      _decode_units_2_io_deq_uop_lrs2_rtype;	// core.scala:98:79
  wire            _decode_units_2_io_deq_uop_frs3_en;	// core.scala:98:79
  wire            _decode_units_2_io_deq_uop_fp_val;	// core.scala:98:79
  wire            _decode_units_2_io_deq_uop_fp_single;	// core.scala:98:79
  wire            _decode_units_2_io_deq_uop_xcpt_pf_if;	// core.scala:98:79
  wire            _decode_units_2_io_deq_uop_xcpt_ae_if;	// core.scala:98:79
  wire            _decode_units_2_io_deq_uop_xcpt_ma_if;	// core.scala:98:79
  wire            _decode_units_2_io_deq_uop_bp_debug_if;	// core.scala:98:79
  wire            _decode_units_2_io_deq_uop_bp_xcpt_if;	// core.scala:98:79
  wire [1:0]      _decode_units_2_io_deq_uop_debug_fsrc;	// core.scala:98:79
  wire [1:0]      _decode_units_2_io_deq_uop_debug_tsrc;	// core.scala:98:79
  wire [11:0]     _decode_units_2_io_csr_decode_csr;	// core.scala:98:79
  wire [6:0]      _decode_units_1_io_deq_uop_uopc;	// core.scala:98:79
  wire [31:0]     _decode_units_1_io_deq_uop_inst;	// core.scala:98:79
  wire [31:0]     _decode_units_1_io_deq_uop_debug_inst;	// core.scala:98:79
  wire            _decode_units_1_io_deq_uop_is_rvc;	// core.scala:98:79
  wire [39:0]     _decode_units_1_io_deq_uop_debug_pc;	// core.scala:98:79
  wire [2:0]      _decode_units_1_io_deq_uop_iq_type;	// core.scala:98:79
  wire [9:0]      _decode_units_1_io_deq_uop_fu_code;	// core.scala:98:79
  wire [3:0]      _decode_units_1_io_deq_uop_ctrl_br_type;	// core.scala:98:79
  wire [1:0]      _decode_units_1_io_deq_uop_ctrl_op1_sel;	// core.scala:98:79
  wire [2:0]      _decode_units_1_io_deq_uop_ctrl_op2_sel;	// core.scala:98:79
  wire [2:0]      _decode_units_1_io_deq_uop_ctrl_imm_sel;	// core.scala:98:79
  wire [3:0]      _decode_units_1_io_deq_uop_ctrl_op_fcn;	// core.scala:98:79
  wire            _decode_units_1_io_deq_uop_ctrl_fcn_dw;	// core.scala:98:79
  wire [2:0]      _decode_units_1_io_deq_uop_ctrl_csr_cmd;	// core.scala:98:79
  wire            _decode_units_1_io_deq_uop_ctrl_is_load;	// core.scala:98:79
  wire            _decode_units_1_io_deq_uop_ctrl_is_sta;	// core.scala:98:79
  wire            _decode_units_1_io_deq_uop_ctrl_is_std;	// core.scala:98:79
  wire [1:0]      _decode_units_1_io_deq_uop_iw_state;	// core.scala:98:79
  wire            _decode_units_1_io_deq_uop_iw_p1_poisoned;	// core.scala:98:79
  wire            _decode_units_1_io_deq_uop_iw_p2_poisoned;	// core.scala:98:79
  wire            _decode_units_1_io_deq_uop_is_br;	// core.scala:98:79
  wire            _decode_units_1_io_deq_uop_is_jalr;	// core.scala:98:79
  wire            _decode_units_1_io_deq_uop_is_jal;	// core.scala:98:79
  wire            _decode_units_1_io_deq_uop_is_sfb;	// core.scala:98:79
  wire [4:0]      _decode_units_1_io_deq_uop_ftq_idx;	// core.scala:98:79
  wire            _decode_units_1_io_deq_uop_edge_inst;	// core.scala:98:79
  wire [5:0]      _decode_units_1_io_deq_uop_pc_lob;	// core.scala:98:79
  wire            _decode_units_1_io_deq_uop_taken;	// core.scala:98:79
  wire [19:0]     _decode_units_1_io_deq_uop_imm_packed;	// core.scala:98:79
  wire [11:0]     _decode_units_1_io_deq_uop_csr_addr;	// core.scala:98:79
  wire [1:0]      _decode_units_1_io_deq_uop_rxq_idx;	// core.scala:98:79
  wire            _decode_units_1_io_deq_uop_exception;	// core.scala:98:79
  wire [63:0]     _decode_units_1_io_deq_uop_exc_cause;	// core.scala:98:79
  wire            _decode_units_1_io_deq_uop_bypassable;	// core.scala:98:79
  wire [4:0]      _decode_units_1_io_deq_uop_mem_cmd;	// core.scala:98:79
  wire [1:0]      _decode_units_1_io_deq_uop_mem_size;	// core.scala:98:79
  wire            _decode_units_1_io_deq_uop_mem_signed;	// core.scala:98:79
  wire            _decode_units_1_io_deq_uop_is_fence;	// core.scala:98:79
  wire            _decode_units_1_io_deq_uop_is_fencei;	// core.scala:98:79
  wire            _decode_units_1_io_deq_uop_is_amo;	// core.scala:98:79
  wire            _decode_units_1_io_deq_uop_uses_ldq;	// core.scala:98:79
  wire            _decode_units_1_io_deq_uop_uses_stq;	// core.scala:98:79
  wire            _decode_units_1_io_deq_uop_is_sys_pc2epc;	// core.scala:98:79
  wire            _decode_units_1_io_deq_uop_is_unique;	// core.scala:98:79
  wire            _decode_units_1_io_deq_uop_flush_on_commit;	// core.scala:98:79
  wire [5:0]      _decode_units_1_io_deq_uop_ldst;	// core.scala:98:79
  wire [5:0]      _decode_units_1_io_deq_uop_lrs1;	// core.scala:98:79
  wire [5:0]      _decode_units_1_io_deq_uop_lrs2;	// core.scala:98:79
  wire [5:0]      _decode_units_1_io_deq_uop_lrs3;	// core.scala:98:79
  wire            _decode_units_1_io_deq_uop_ldst_val;	// core.scala:98:79
  wire [1:0]      _decode_units_1_io_deq_uop_dst_rtype;	// core.scala:98:79
  wire [1:0]      _decode_units_1_io_deq_uop_lrs1_rtype;	// core.scala:98:79
  wire [1:0]      _decode_units_1_io_deq_uop_lrs2_rtype;	// core.scala:98:79
  wire            _decode_units_1_io_deq_uop_frs3_en;	// core.scala:98:79
  wire            _decode_units_1_io_deq_uop_fp_val;	// core.scala:98:79
  wire            _decode_units_1_io_deq_uop_fp_single;	// core.scala:98:79
  wire            _decode_units_1_io_deq_uop_xcpt_pf_if;	// core.scala:98:79
  wire            _decode_units_1_io_deq_uop_xcpt_ae_if;	// core.scala:98:79
  wire            _decode_units_1_io_deq_uop_xcpt_ma_if;	// core.scala:98:79
  wire            _decode_units_1_io_deq_uop_bp_debug_if;	// core.scala:98:79
  wire            _decode_units_1_io_deq_uop_bp_xcpt_if;	// core.scala:98:79
  wire [1:0]      _decode_units_1_io_deq_uop_debug_fsrc;	// core.scala:98:79
  wire [1:0]      _decode_units_1_io_deq_uop_debug_tsrc;	// core.scala:98:79
  wire [11:0]     _decode_units_1_io_csr_decode_csr;	// core.scala:98:79
  wire [6:0]      _decode_units_0_io_deq_uop_uopc;	// core.scala:98:79
  wire [31:0]     _decode_units_0_io_deq_uop_inst;	// core.scala:98:79
  wire [31:0]     _decode_units_0_io_deq_uop_debug_inst;	// core.scala:98:79
  wire            _decode_units_0_io_deq_uop_is_rvc;	// core.scala:98:79
  wire [39:0]     _decode_units_0_io_deq_uop_debug_pc;	// core.scala:98:79
  wire [2:0]      _decode_units_0_io_deq_uop_iq_type;	// core.scala:98:79
  wire [9:0]      _decode_units_0_io_deq_uop_fu_code;	// core.scala:98:79
  wire [3:0]      _decode_units_0_io_deq_uop_ctrl_br_type;	// core.scala:98:79
  wire [1:0]      _decode_units_0_io_deq_uop_ctrl_op1_sel;	// core.scala:98:79
  wire [2:0]      _decode_units_0_io_deq_uop_ctrl_op2_sel;	// core.scala:98:79
  wire [2:0]      _decode_units_0_io_deq_uop_ctrl_imm_sel;	// core.scala:98:79
  wire [3:0]      _decode_units_0_io_deq_uop_ctrl_op_fcn;	// core.scala:98:79
  wire            _decode_units_0_io_deq_uop_ctrl_fcn_dw;	// core.scala:98:79
  wire [2:0]      _decode_units_0_io_deq_uop_ctrl_csr_cmd;	// core.scala:98:79
  wire            _decode_units_0_io_deq_uop_ctrl_is_load;	// core.scala:98:79
  wire            _decode_units_0_io_deq_uop_ctrl_is_sta;	// core.scala:98:79
  wire            _decode_units_0_io_deq_uop_ctrl_is_std;	// core.scala:98:79
  wire [1:0]      _decode_units_0_io_deq_uop_iw_state;	// core.scala:98:79
  wire            _decode_units_0_io_deq_uop_iw_p1_poisoned;	// core.scala:98:79
  wire            _decode_units_0_io_deq_uop_iw_p2_poisoned;	// core.scala:98:79
  wire            _decode_units_0_io_deq_uop_is_br;	// core.scala:98:79
  wire            _decode_units_0_io_deq_uop_is_jalr;	// core.scala:98:79
  wire            _decode_units_0_io_deq_uop_is_jal;	// core.scala:98:79
  wire            _decode_units_0_io_deq_uop_is_sfb;	// core.scala:98:79
  wire [4:0]      _decode_units_0_io_deq_uop_ftq_idx;	// core.scala:98:79
  wire            _decode_units_0_io_deq_uop_edge_inst;	// core.scala:98:79
  wire [5:0]      _decode_units_0_io_deq_uop_pc_lob;	// core.scala:98:79
  wire            _decode_units_0_io_deq_uop_taken;	// core.scala:98:79
  wire [19:0]     _decode_units_0_io_deq_uop_imm_packed;	// core.scala:98:79
  wire [11:0]     _decode_units_0_io_deq_uop_csr_addr;	// core.scala:98:79
  wire [1:0]      _decode_units_0_io_deq_uop_rxq_idx;	// core.scala:98:79
  wire            _decode_units_0_io_deq_uop_exception;	// core.scala:98:79
  wire [63:0]     _decode_units_0_io_deq_uop_exc_cause;	// core.scala:98:79
  wire            _decode_units_0_io_deq_uop_bypassable;	// core.scala:98:79
  wire [4:0]      _decode_units_0_io_deq_uop_mem_cmd;	// core.scala:98:79
  wire [1:0]      _decode_units_0_io_deq_uop_mem_size;	// core.scala:98:79
  wire            _decode_units_0_io_deq_uop_mem_signed;	// core.scala:98:79
  wire            _decode_units_0_io_deq_uop_is_fence;	// core.scala:98:79
  wire            _decode_units_0_io_deq_uop_is_fencei;	// core.scala:98:79
  wire            _decode_units_0_io_deq_uop_is_amo;	// core.scala:98:79
  wire            _decode_units_0_io_deq_uop_uses_ldq;	// core.scala:98:79
  wire            _decode_units_0_io_deq_uop_uses_stq;	// core.scala:98:79
  wire            _decode_units_0_io_deq_uop_is_sys_pc2epc;	// core.scala:98:79
  wire            _decode_units_0_io_deq_uop_is_unique;	// core.scala:98:79
  wire            _decode_units_0_io_deq_uop_flush_on_commit;	// core.scala:98:79
  wire [5:0]      _decode_units_0_io_deq_uop_ldst;	// core.scala:98:79
  wire [5:0]      _decode_units_0_io_deq_uop_lrs1;	// core.scala:98:79
  wire [5:0]      _decode_units_0_io_deq_uop_lrs2;	// core.scala:98:79
  wire [5:0]      _decode_units_0_io_deq_uop_lrs3;	// core.scala:98:79
  wire            _decode_units_0_io_deq_uop_ldst_val;	// core.scala:98:79
  wire [1:0]      _decode_units_0_io_deq_uop_dst_rtype;	// core.scala:98:79
  wire [1:0]      _decode_units_0_io_deq_uop_lrs1_rtype;	// core.scala:98:79
  wire [1:0]      _decode_units_0_io_deq_uop_lrs2_rtype;	// core.scala:98:79
  wire            _decode_units_0_io_deq_uop_frs3_en;	// core.scala:98:79
  wire            _decode_units_0_io_deq_uop_fp_val;	// core.scala:98:79
  wire            _decode_units_0_io_deq_uop_fp_single;	// core.scala:98:79
  wire            _decode_units_0_io_deq_uop_xcpt_pf_if;	// core.scala:98:79
  wire            _decode_units_0_io_deq_uop_xcpt_ae_if;	// core.scala:98:79
  wire            _decode_units_0_io_deq_uop_xcpt_ma_if;	// core.scala:98:79
  wire            _decode_units_0_io_deq_uop_bp_debug_if;	// core.scala:98:79
  wire            _decode_units_0_io_deq_uop_bp_xcpt_if;	// core.scala:98:79
  wire [1:0]      _decode_units_0_io_deq_uop_debug_fsrc;	// core.scala:98:79
  wire [1:0]      _decode_units_0_io_deq_uop_debug_tsrc;	// core.scala:98:79
  wire [11:0]     _decode_units_0_io_csr_decode_csr;	// core.scala:98:79
  wire            _fp_pipeline_io_dis_uops_0_ready;	// core.scala:77:37
  wire            _fp_pipeline_io_dis_uops_1_ready;	// core.scala:77:37
  wire            _fp_pipeline_io_dis_uops_2_ready;	// core.scala:77:37
  wire            _fp_pipeline_io_from_int_ready;	// core.scala:77:37
  wire            _fp_pipeline_io_to_int_valid;	// core.scala:77:37
  wire [6:0]      _fp_pipeline_io_to_int_bits_uop_rob_idx;	// core.scala:77:37
  wire [6:0]      _fp_pipeline_io_to_int_bits_uop_pdst;	// core.scala:77:37
  wire            _fp_pipeline_io_to_int_bits_uop_is_amo;	// core.scala:77:37
  wire            _fp_pipeline_io_to_int_bits_uop_uses_stq;	// core.scala:77:37
  wire [1:0]      _fp_pipeline_io_to_int_bits_uop_dst_rtype;	// core.scala:77:37
  wire [63:0]     _fp_pipeline_io_to_int_bits_data;	// core.scala:77:37
  wire            _fp_pipeline_io_to_int_bits_predicated;	// core.scala:77:37
  wire            _fp_pipeline_io_wakeups_0_valid;	// core.scala:77:37
  wire [6:0]      _fp_pipeline_io_wakeups_0_bits_uop_rob_idx;	// core.scala:77:37
  wire [6:0]      _fp_pipeline_io_wakeups_0_bits_uop_pdst;	// core.scala:77:37
  wire [1:0]      _fp_pipeline_io_wakeups_0_bits_uop_dst_rtype;	// core.scala:77:37
  wire            _fp_pipeline_io_wakeups_0_bits_uop_fp_val;	// core.scala:77:37
  wire            _fp_pipeline_io_wakeups_0_bits_predicated;	// core.scala:77:37
  wire            _fp_pipeline_io_wakeups_0_bits_fflags_valid;	// core.scala:77:37
  wire [6:0]      _fp_pipeline_io_wakeups_0_bits_fflags_bits_uop_rob_idx;	// core.scala:77:37
  wire [4:0]      _fp_pipeline_io_wakeups_0_bits_fflags_bits_flags;	// core.scala:77:37
  wire            _fp_pipeline_io_wakeups_1_valid;	// core.scala:77:37
  wire [6:0]      _fp_pipeline_io_wakeups_1_bits_uop_rob_idx;	// core.scala:77:37
  wire [6:0]      _fp_pipeline_io_wakeups_1_bits_uop_pdst;	// core.scala:77:37
  wire [1:0]      _fp_pipeline_io_wakeups_1_bits_uop_dst_rtype;	// core.scala:77:37
  wire            _fp_pipeline_io_wakeups_1_bits_uop_fp_val;	// core.scala:77:37
  wire            _fp_pipeline_io_wakeups_1_bits_fflags_valid;	// core.scala:77:37
  wire [6:0]      _fp_pipeline_io_wakeups_1_bits_fflags_bits_uop_rob_idx;	// core.scala:77:37
  wire [4:0]      _fp_pipeline_io_wakeups_1_bits_fflags_bits_flags;	// core.scala:77:37
  wire            _alu_exe_unit_io_iresp_valid;	// execution-units.scala:119:32
  wire [6:0]      _alu_exe_unit_io_iresp_bits_uop_rob_idx;	// execution-units.scala:119:32
  wire [6:0]      _alu_exe_unit_io_iresp_bits_uop_pdst;	// execution-units.scala:119:32
  wire            _alu_exe_unit_io_iresp_bits_uop_bypassable;	// execution-units.scala:119:32
  wire            _alu_exe_unit_io_iresp_bits_uop_is_amo;	// execution-units.scala:119:32
  wire            _alu_exe_unit_io_iresp_bits_uop_uses_stq;	// execution-units.scala:119:32
  wire [1:0]      _alu_exe_unit_io_iresp_bits_uop_dst_rtype;	// execution-units.scala:119:32
  wire [64:0]     _alu_exe_unit_io_iresp_bits_data;	// execution-units.scala:119:32
  wire            _alu_exe_unit_io_bypass_0_valid;	// execution-units.scala:119:32
  wire [6:0]      _alu_exe_unit_io_bypass_0_bits_uop_pdst;	// execution-units.scala:119:32
  wire [1:0]      _alu_exe_unit_io_bypass_0_bits_uop_dst_rtype;	// execution-units.scala:119:32
  wire [64:0]     _alu_exe_unit_io_bypass_0_bits_data;	// execution-units.scala:119:32
  wire            _alu_exe_unit_io_bypass_1_valid;	// execution-units.scala:119:32
  wire [6:0]      _alu_exe_unit_io_bypass_1_bits_uop_pdst;	// execution-units.scala:119:32
  wire [1:0]      _alu_exe_unit_io_bypass_1_bits_uop_dst_rtype;	// execution-units.scala:119:32
  wire [64:0]     _alu_exe_unit_io_bypass_1_bits_data;	// execution-units.scala:119:32
  wire            _alu_exe_unit_io_bypass_2_valid;	// execution-units.scala:119:32
  wire [6:0]      _alu_exe_unit_io_bypass_2_bits_uop_pdst;	// execution-units.scala:119:32
  wire [1:0]      _alu_exe_unit_io_bypass_2_bits_uop_dst_rtype;	// execution-units.scala:119:32
  wire [64:0]     _alu_exe_unit_io_bypass_2_bits_data;	// execution-units.scala:119:32
  wire            _alu_exe_unit_io_brinfo_uop_is_rvc;	// execution-units.scala:119:32
  wire [15:0]     _alu_exe_unit_io_brinfo_uop_br_mask;	// execution-units.scala:119:32
  wire [3:0]      _alu_exe_unit_io_brinfo_uop_br_tag;	// execution-units.scala:119:32
  wire [4:0]      _alu_exe_unit_io_brinfo_uop_ftq_idx;	// execution-units.scala:119:32
  wire            _alu_exe_unit_io_brinfo_uop_edge_inst;	// execution-units.scala:119:32
  wire [5:0]      _alu_exe_unit_io_brinfo_uop_pc_lob;	// execution-units.scala:119:32
  wire [6:0]      _alu_exe_unit_io_brinfo_uop_rob_idx;	// execution-units.scala:119:32
  wire [4:0]      _alu_exe_unit_io_brinfo_uop_ldq_idx;	// execution-units.scala:119:32
  wire [4:0]      _alu_exe_unit_io_brinfo_uop_stq_idx;	// execution-units.scala:119:32
  wire            _alu_exe_unit_io_brinfo_valid;	// execution-units.scala:119:32
  wire            _alu_exe_unit_io_brinfo_mispredict;	// execution-units.scala:119:32
  wire            _alu_exe_unit_io_brinfo_taken;	// execution-units.scala:119:32
  wire [2:0]      _alu_exe_unit_io_brinfo_cfi_type;	// execution-units.scala:119:32
  wire [1:0]      _alu_exe_unit_io_brinfo_pc_sel;	// execution-units.scala:119:32
  wire [20:0]     _alu_exe_unit_io_brinfo_target_offset;	// execution-units.scala:119:32
  wire [9:0]      _csr_exe_unit_io_fu_types;	// execution-units.scala:119:32
  wire            _csr_exe_unit_io_iresp_valid;	// execution-units.scala:119:32
  wire [2:0]      _csr_exe_unit_io_iresp_bits_uop_ctrl_csr_cmd;	// execution-units.scala:119:32
  wire [11:0]     _csr_exe_unit_io_iresp_bits_uop_csr_addr;	// execution-units.scala:119:32
  wire [6:0]      _csr_exe_unit_io_iresp_bits_uop_rob_idx;	// execution-units.scala:119:32
  wire [6:0]      _csr_exe_unit_io_iresp_bits_uop_pdst;	// execution-units.scala:119:32
  wire            _csr_exe_unit_io_iresp_bits_uop_bypassable;	// execution-units.scala:119:32
  wire            _csr_exe_unit_io_iresp_bits_uop_is_amo;	// execution-units.scala:119:32
  wire            _csr_exe_unit_io_iresp_bits_uop_uses_stq;	// execution-units.scala:119:32
  wire [1:0]      _csr_exe_unit_io_iresp_bits_uop_dst_rtype;	// execution-units.scala:119:32
  wire [64:0]     _csr_exe_unit_io_iresp_bits_data;	// execution-units.scala:119:32
  wire            _csr_exe_unit_io_ll_fresp_valid;	// execution-units.scala:119:32
  wire [6:0]      _csr_exe_unit_io_ll_fresp_bits_uop_uopc;	// execution-units.scala:119:32
  wire [15:0]     _csr_exe_unit_io_ll_fresp_bits_uop_br_mask;	// execution-units.scala:119:32
  wire [6:0]      _csr_exe_unit_io_ll_fresp_bits_uop_rob_idx;	// execution-units.scala:119:32
  wire [4:0]      _csr_exe_unit_io_ll_fresp_bits_uop_stq_idx;	// execution-units.scala:119:32
  wire [6:0]      _csr_exe_unit_io_ll_fresp_bits_uop_pdst;	// execution-units.scala:119:32
  wire            _csr_exe_unit_io_ll_fresp_bits_uop_is_amo;	// execution-units.scala:119:32
  wire            _csr_exe_unit_io_ll_fresp_bits_uop_uses_stq;	// execution-units.scala:119:32
  wire [1:0]      _csr_exe_unit_io_ll_fresp_bits_uop_dst_rtype;	// execution-units.scala:119:32
  wire            _csr_exe_unit_io_ll_fresp_bits_uop_fp_val;	// execution-units.scala:119:32
  wire [64:0]     _csr_exe_unit_io_ll_fresp_bits_data;	// execution-units.scala:119:32
  wire            _csr_exe_unit_io_ll_fresp_bits_predicated;	// execution-units.scala:119:32
  wire            _csr_exe_unit_io_ll_fresp_bits_fflags_valid;	// execution-units.scala:119:32
  wire [6:0]      _csr_exe_unit_io_ll_fresp_bits_fflags_bits_uop_rob_idx;	// execution-units.scala:119:32
  wire [4:0]      _csr_exe_unit_io_ll_fresp_bits_fflags_bits_flags;	// execution-units.scala:119:32
  wire            _csr_exe_unit_io_bypass_0_valid;	// execution-units.scala:119:32
  wire [6:0]      _csr_exe_unit_io_bypass_0_bits_uop_pdst;	// execution-units.scala:119:32
  wire [1:0]      _csr_exe_unit_io_bypass_0_bits_uop_dst_rtype;	// execution-units.scala:119:32
  wire [64:0]     _csr_exe_unit_io_bypass_0_bits_data;	// execution-units.scala:119:32
  wire            _csr_exe_unit_io_brinfo_uop_is_rvc;	// execution-units.scala:119:32
  wire [15:0]     _csr_exe_unit_io_brinfo_uop_br_mask;	// execution-units.scala:119:32
  wire [3:0]      _csr_exe_unit_io_brinfo_uop_br_tag;	// execution-units.scala:119:32
  wire [4:0]      _csr_exe_unit_io_brinfo_uop_ftq_idx;	// execution-units.scala:119:32
  wire            _csr_exe_unit_io_brinfo_uop_edge_inst;	// execution-units.scala:119:32
  wire [5:0]      _csr_exe_unit_io_brinfo_uop_pc_lob;	// execution-units.scala:119:32
  wire [6:0]      _csr_exe_unit_io_brinfo_uop_rob_idx;	// execution-units.scala:119:32
  wire [4:0]      _csr_exe_unit_io_brinfo_uop_ldq_idx;	// execution-units.scala:119:32
  wire [4:0]      _csr_exe_unit_io_brinfo_uop_stq_idx;	// execution-units.scala:119:32
  wire            _csr_exe_unit_io_brinfo_valid;	// execution-units.scala:119:32
  wire            _csr_exe_unit_io_brinfo_mispredict;	// execution-units.scala:119:32
  wire            _csr_exe_unit_io_brinfo_taken;	// execution-units.scala:119:32
  wire [2:0]      _csr_exe_unit_io_brinfo_cfi_type;	// execution-units.scala:119:32
  wire [1:0]      _csr_exe_unit_io_brinfo_pc_sel;	// execution-units.scala:119:32
  wire [20:0]     _csr_exe_unit_io_brinfo_target_offset;	// execution-units.scala:119:32
  wire [9:0]      _jmp_unit_io_fu_types;	// execution-units.scala:119:32
  wire            _jmp_unit_io_iresp_valid;	// execution-units.scala:119:32
  wire [6:0]      _jmp_unit_io_iresp_bits_uop_rob_idx;	// execution-units.scala:119:32
  wire [6:0]      _jmp_unit_io_iresp_bits_uop_pdst;	// execution-units.scala:119:32
  wire            _jmp_unit_io_iresp_bits_uop_bypassable;	// execution-units.scala:119:32
  wire            _jmp_unit_io_iresp_bits_uop_is_amo;	// execution-units.scala:119:32
  wire            _jmp_unit_io_iresp_bits_uop_uses_stq;	// execution-units.scala:119:32
  wire [1:0]      _jmp_unit_io_iresp_bits_uop_dst_rtype;	// execution-units.scala:119:32
  wire [64:0]     _jmp_unit_io_iresp_bits_data;	// execution-units.scala:119:32
  wire            _jmp_unit_io_bypass_0_valid;	// execution-units.scala:119:32
  wire [6:0]      _jmp_unit_io_bypass_0_bits_uop_pdst;	// execution-units.scala:119:32
  wire [1:0]      _jmp_unit_io_bypass_0_bits_uop_dst_rtype;	// execution-units.scala:119:32
  wire [64:0]     _jmp_unit_io_bypass_0_bits_data;	// execution-units.scala:119:32
  wire            _jmp_unit_io_brinfo_uop_is_rvc;	// execution-units.scala:119:32
  wire [15:0]     _jmp_unit_io_brinfo_uop_br_mask;	// execution-units.scala:119:32
  wire [3:0]      _jmp_unit_io_brinfo_uop_br_tag;	// execution-units.scala:119:32
  wire [4:0]      _jmp_unit_io_brinfo_uop_ftq_idx;	// execution-units.scala:119:32
  wire            _jmp_unit_io_brinfo_uop_edge_inst;	// execution-units.scala:119:32
  wire [5:0]      _jmp_unit_io_brinfo_uop_pc_lob;	// execution-units.scala:119:32
  wire [6:0]      _jmp_unit_io_brinfo_uop_rob_idx;	// execution-units.scala:119:32
  wire [4:0]      _jmp_unit_io_brinfo_uop_ldq_idx;	// execution-units.scala:119:32
  wire [4:0]      _jmp_unit_io_brinfo_uop_stq_idx;	// execution-units.scala:119:32
  wire            _jmp_unit_io_brinfo_valid;	// execution-units.scala:119:32
  wire            _jmp_unit_io_brinfo_mispredict;	// execution-units.scala:119:32
  wire            _jmp_unit_io_brinfo_taken;	// execution-units.scala:119:32
  wire [2:0]      _jmp_unit_io_brinfo_cfi_type;	// execution-units.scala:119:32
  wire [1:0]      _jmp_unit_io_brinfo_pc_sel;	// execution-units.scala:119:32
  wire [39:0]     _jmp_unit_io_brinfo_jalr_target;	// execution-units.scala:119:32
  wire [20:0]     _jmp_unit_io_brinfo_target_offset;	// execution-units.scala:119:32
  wire            _mem_units_0_io_ll_iresp_valid;	// execution-units.scala:108:30
  wire [6:0]      _mem_units_0_io_ll_iresp_bits_uop_rob_idx;	// execution-units.scala:108:30
  wire [6:0]      _mem_units_0_io_ll_iresp_bits_uop_pdst;	// execution-units.scala:108:30
  wire            _mem_units_0_io_ll_iresp_bits_uop_is_amo;	// execution-units.scala:108:30
  wire            _mem_units_0_io_ll_iresp_bits_uop_uses_stq;	// execution-units.scala:108:30
  wire [1:0]      _mem_units_0_io_ll_iresp_bits_uop_dst_rtype;	// execution-units.scala:108:30
  wire [64:0]     _mem_units_0_io_ll_iresp_bits_data;	// execution-units.scala:108:30
  wire            _mem_units_0_io_ll_fresp_valid;	// execution-units.scala:108:30
  wire [6:0]      _mem_units_0_io_ll_fresp_bits_uop_uopc;	// execution-units.scala:108:30
  wire [15:0]     _mem_units_0_io_ll_fresp_bits_uop_br_mask;	// execution-units.scala:108:30
  wire [6:0]      _mem_units_0_io_ll_fresp_bits_uop_rob_idx;	// execution-units.scala:108:30
  wire [4:0]      _mem_units_0_io_ll_fresp_bits_uop_stq_idx;	// execution-units.scala:108:30
  wire [6:0]      _mem_units_0_io_ll_fresp_bits_uop_pdst;	// execution-units.scala:108:30
  wire [1:0]      _mem_units_0_io_ll_fresp_bits_uop_mem_size;	// execution-units.scala:108:30
  wire            _mem_units_0_io_ll_fresp_bits_uop_is_amo;	// execution-units.scala:108:30
  wire            _mem_units_0_io_ll_fresp_bits_uop_uses_stq;	// execution-units.scala:108:30
  wire [1:0]      _mem_units_0_io_ll_fresp_bits_uop_dst_rtype;	// execution-units.scala:108:30
  wire            _mem_units_0_io_ll_fresp_bits_uop_fp_val;	// execution-units.scala:108:30
  wire [64:0]     _mem_units_0_io_ll_fresp_bits_data;	// execution-units.scala:108:30
  wire            _mem_units_0_io_lsu_io_req_bits_sfence_valid;	// execution-units.scala:108:30
  wire            _mem_units_0_io_lsu_io_req_bits_sfence_bits_rs1;	// execution-units.scala:108:30
  wire            _mem_units_0_io_lsu_io_req_bits_sfence_bits_rs2;	// execution-units.scala:108:30
  wire [38:0]     _mem_units_0_io_lsu_io_req_bits_sfence_bits_addr;	// execution-units.scala:108:30
  reg             brinfos_0_uop_is_rvc;	// core.scala:179:20
  reg  [15:0]     brinfos_0_uop_br_mask;	// core.scala:179:20
  reg  [3:0]      brinfos_0_uop_br_tag;	// core.scala:179:20
  reg  [4:0]      brinfos_0_uop_ftq_idx;	// core.scala:179:20
  reg             brinfos_0_uop_edge_inst;	// core.scala:179:20
  reg  [5:0]      brinfos_0_uop_pc_lob;	// core.scala:179:20
  reg  [6:0]      brinfos_0_uop_rob_idx;	// core.scala:179:20
  reg  [4:0]      brinfos_0_uop_ldq_idx;	// core.scala:179:20
  reg  [4:0]      brinfos_0_uop_stq_idx;	// core.scala:179:20
  reg             brinfos_0_valid;	// core.scala:179:20
  reg             brinfos_0_mispredict;	// core.scala:179:20
  reg             brinfos_0_taken;	// core.scala:179:20
  reg  [2:0]      brinfos_0_cfi_type;	// core.scala:179:20
  reg  [1:0]      brinfos_0_pc_sel;	// core.scala:179:20
  reg  [20:0]     brinfos_0_target_offset;	// core.scala:179:20
  reg             brinfos_1_uop_is_rvc;	// core.scala:179:20
  reg  [15:0]     brinfos_1_uop_br_mask;	// core.scala:179:20
  reg  [3:0]      brinfos_1_uop_br_tag;	// core.scala:179:20
  reg  [4:0]      brinfos_1_uop_ftq_idx;	// core.scala:179:20
  reg             brinfos_1_uop_edge_inst;	// core.scala:179:20
  reg  [5:0]      brinfos_1_uop_pc_lob;	// core.scala:179:20
  reg  [6:0]      brinfos_1_uop_rob_idx;	// core.scala:179:20
  reg  [4:0]      brinfos_1_uop_ldq_idx;	// core.scala:179:20
  reg  [4:0]      brinfos_1_uop_stq_idx;	// core.scala:179:20
  reg             brinfos_1_valid;	// core.scala:179:20
  reg             brinfos_1_mispredict;	// core.scala:179:20
  reg             brinfos_1_taken;	// core.scala:179:20
  reg  [2:0]      brinfos_1_cfi_type;	// core.scala:179:20
  reg  [1:0]      brinfos_1_pc_sel;	// core.scala:179:20
  reg  [20:0]     brinfos_1_target_offset;	// core.scala:179:20
  reg             brinfos_2_uop_is_rvc;	// core.scala:179:20
  reg  [15:0]     brinfos_2_uop_br_mask;	// core.scala:179:20
  reg  [3:0]      brinfos_2_uop_br_tag;	// core.scala:179:20
  reg  [4:0]      brinfos_2_uop_ftq_idx;	// core.scala:179:20
  reg             brinfos_2_uop_edge_inst;	// core.scala:179:20
  reg  [5:0]      brinfos_2_uop_pc_lob;	// core.scala:179:20
  reg  [6:0]      brinfos_2_uop_rob_idx;	// core.scala:179:20
  reg  [4:0]      brinfos_2_uop_ldq_idx;	// core.scala:179:20
  reg  [4:0]      brinfos_2_uop_stq_idx;	// core.scala:179:20
  reg             brinfos_2_valid;	// core.scala:179:20
  reg             brinfos_2_mispredict;	// core.scala:179:20
  reg             brinfos_2_taken;	// core.scala:179:20
  reg  [2:0]      brinfos_2_cfi_type;	// core.scala:179:20
  reg  [1:0]      brinfos_2_pc_sel;	// core.scala:179:20
  reg  [20:0]     brinfos_2_target_offset;	// core.scala:179:20
  reg             b2_uop_is_rvc;	// core.scala:187:18
  reg  [15:0]     b2_uop_br_mask;	// core.scala:187:18
  reg  [3:0]      b2_uop_br_tag;	// core.scala:187:18
  reg  [4:0]      b2_uop_ftq_idx;	// core.scala:187:18
  reg             b2_uop_edge_inst;	// core.scala:187:18
  reg  [5:0]      b2_uop_pc_lob;	// core.scala:187:18
  reg  [6:0]      b2_uop_rob_idx;	// core.scala:187:18
  reg  [4:0]      b2_uop_ldq_idx;	// core.scala:187:18
  reg  [4:0]      b2_uop_stq_idx;	// core.scala:187:18
  reg             b2_mispredict;	// core.scala:187:18
  reg             b2_taken;	// core.scala:187:18
  reg  [2:0]      b2_cfi_type;	// core.scala:187:18
  reg  [1:0]      b2_pc_sel;	// core.scala:187:18
  reg  [39:0]     b2_jalr_target;	// core.scala:187:18
  reg  [20:0]     b2_target_offset;	// core.scala:187:18
  wire [15:0]     _GEN = {12'h0, brinfos_0_uop_br_tag};	// core.scala:179:20, :196:47
  wire [15:0]     _GEN_0 = {12'h0, brinfos_1_uop_br_tag};	// core.scala:179:20, :196:47
  wire [15:0]     _GEN_1 = {12'h0, brinfos_2_uop_br_tag};	// core.scala:179:20, :196:47
  wire [15:0]     b1_resolve_mask =
    {15'h0, brinfos_0_valid} << _GEN | {15'h0, brinfos_1_valid} << _GEN_0
    | {15'h0, brinfos_2_valid} << _GEN_1;	// core.scala:179:20, :196:{47,72}
  wire            _use_this_mispredict_T_1 = brinfos_0_valid & brinfos_0_mispredict;	// core.scala:179:20, :197:51
  wire            _use_this_mispredict_T_9 = brinfos_1_valid & brinfos_1_mispredict;	// core.scala:179:20, :197:51
  wire            _use_this_mispredict_T_17 = brinfos_2_valid & brinfos_2_mispredict;	// core.scala:179:20, :197:51
  wire [15:0]     b1_mispredict_mask =
    {15'h0, _use_this_mispredict_T_1} << _GEN | {15'h0, _use_this_mispredict_T_9}
    << _GEN_0 | {15'h0, _use_this_mispredict_T_17} << _GEN_1;	// core.scala:196:47, :197:{51,68,93}
  wire            use_this_mispredict_1 =
    ~_use_this_mispredict_T_1 | _use_this_mispredict_T_9
    & (brinfos_1_uop_rob_idx < brinfos_0_uop_rob_idx
       ^ brinfos_1_uop_rob_idx < _rob_io_rob_head_idx
       ^ brinfos_0_uop_rob_idx < _rob_io_rob_head_idx);	// core.scala:140:32, :179:20, :197:51, :203:{31,47}, :204:29, util.scala:363:{52,64,72,78}
  wire            _GEN_2 = _use_this_mispredict_T_1 | _use_this_mispredict_T_9;	// core.scala:197:51, :206:37
  wire [6:0]      _GEN_3 =
    use_this_mispredict_1 ? brinfos_1_uop_rob_idx : brinfos_0_uop_rob_idx;	// core.scala:179:20, :203:47, :207:28
  wire            use_this_mispredict_2 =
    ~_GEN_2 | _use_this_mispredict_T_17
    & (brinfos_2_uop_rob_idx < _GEN_3 ^ brinfos_2_uop_rob_idx < _rob_io_rob_head_idx
       ^ _GEN_3 < _rob_io_rob_head_idx);	// core.scala:140:32, :179:20, :197:51, :203:{31,47}, :204:29, :206:37, :207:28, util.scala:363:{52,64,72,78}
  reg  [39:0]     b2_jalr_target_REG;	// core.scala:215:28
  reg             io_ifu_flush_icache_REG;	// core.scala:383:13
  reg             io_ifu_flush_icache_REG_1;	// core.scala:383:13
  reg             io_ifu_flush_icache_REG_2;	// core.scala:383:13
  reg             REG;	// core.scala:395:16
  reg  [2:0]      flush_typ;	// core.scala:398:28
  reg  [39:0]     io_ifu_redirect_pc_REG;	// core.scala:406:49
  reg  [39:0]     io_ifu_redirect_pc_REG_1;	// core.scala:406:41
  reg  [5:0]      flush_pc_REG;	// core.scala:410:32
  reg             flush_pc_REG_1;	// core.scala:411:36
  wire [39:0]     _flush_pc_T_6 =
    {io_ifu_get_pc_0_pc[39:6], 6'h0} + {34'h0, flush_pc_REG}
    - {38'h0, flush_pc_REG_1, 1'h0};	// core.scala:77:37, :98:79, :100:32, :101:46, :102:33, :105:32, :107:32, :111:32, :119:32, :129:32, :132:32, :140:32, :155:24, :171:24, :172:27, :268:19, :410:{23,32}, :411:{23,36}, :412:36, :683:73, execution-units.scala:108:30, :119:32, util.scala:237:5
  reg             flush_pc_next_REG;	// core.scala:412:49
  reg  [4:0]      io_ifu_redirect_ftq_idx_REG;	// core.scala:417:39
  reg             REG_1;	// core.scala:418:50
  wire            _GEN_4 = b2_mispredict & ~REG_1;	// core.scala:187:18, :418:{39,42,50}
  wire [39:0]     _GEN_5 = {io_ifu_get_pc_1_pc[39:6], b2_uop_pc_lob};	// core.scala:187:18, :421:28
  wire [39:0]     _npc_T_2 =
    _GEN_5 + {37'h0, b2_uop_is_rvc | b2_uop_edge_inst ? 3'h2 : 3'h4};	// core.scala:187:18, :412:{36,41}, :421:{28,33,57}
  wire            _next_ghist_T = b2_cfi_type == 3'h1;	// core.scala:187:18, :431:48
  wire            use_same_ghist =
    _next_ghist_T & ~b2_taken
    & {io_ifu_get_pc_1_pc[39:6], 6'h0} == {_npc_T_2[39:3], 3'h0};	// core.scala:187:18, :421:28, :431:48, :432:{27,46}, :433:47, :490:34, frontend.scala:161:39, util.scala:237:5
  wire [2:0]      cfi_idx = b2_uop_pc_lob[3:1] ^ {io_ifu_get_pc_1_entry_start_bank, 2'h0};	// core.scala:187:18, :426:52, :435:43, :436:10
  wire            _next_ghist_T_3 = io_ifu_get_pc_1_entry_cfi_idx_bits == cfi_idx;	// core.scala:435:43, :445:55
  wire [7:0]      next_ghist_cfi_idx_oh = 8'h1 << cfi_idx;	// OneHot.scala:58:35, core.scala:435:43
  wire [6:0]      _GEN_6 = next_ghist_cfi_idx_oh[6:0] | next_ghist_cfi_idx_oh[7:1];	// OneHot.scala:58:35, core.scala:221:10, util.scala:373:{29,45}
  wire [5:0]      _GEN_7 = _GEN_6[5:0] | next_ghist_cfi_idx_oh[7:2];	// OneHot.scala:58:35, core.scala:221:10, :291:41, util.scala:373:{29,45}
  wire [4:0]      _GEN_8 = _GEN_7[4:0] | next_ghist_cfi_idx_oh[7:3];	// OneHot.scala:58:35, core.scala:291:41, util.scala:373:{29,45}
  wire [3:0]      _GEN_9 = _GEN_8[3:0] | next_ghist_cfi_idx_oh[7:4];	// OneHot.scala:58:35, core.scala:291:41, :412:41, util.scala:373:{29,45}
  wire [2:0]      _GEN_10 = _GEN_9[2:0] | next_ghist_cfi_idx_oh[7:5];	// OneHot.scala:58:35, core.scala:412:41, util.scala:373:{29,45}
  wire [1:0]      _GEN_11 = _GEN_10[1:0] | next_ghist_cfi_idx_oh[7:6];	// OneHot.scala:58:35, util.scala:373:{29,45}
  wire [7:0]      _next_ghist_not_taken_branches_T_17 =
    ~(_next_ghist_T & b2_taken ? next_ghist_cfi_idx_oh : 8'h0);	// OneHot.scala:58:35, core.scala:187:18, :431:48, frontend.scala:91:{69,73,84}
  wire            next_ghist_cfi_in_bank_0 = b2_taken & ~(cfi_idx[2]);	// core.scala:187:18, :435:43, frontend.scala:105:{50,67}
  wire            next_ghist_ignore_second_bank =
    next_ghist_cfi_in_bank_0 | (&(io_ifu_get_pc_1_pc[5:3]));	// frontend.scala:105:50, :106:46, :153:{28,66}
  wire            next_ghist_first_bank_saw_not_taken =
    (|(io_ifu_get_pc_1_entry_br_mask[3:0]
       & {_GEN_9[3], _GEN_10[2], _GEN_11[1], _GEN_11[0] | (&cfi_idx)}
       & _next_ghist_not_taken_branches_T_17[3:0]))
    | io_ifu_get_pc_1_ghist_current_saw_branch_not_taken;	// core.scala:412:41, :435:43, frontend.scala:90:39, :91:{67,69}, :108:{56,72,80}, :161:39, util.scala:373:{29,45}
  wire [63:0]     _GEN_12 = {io_ifu_get_pc_1_ghist_old_history[62:0], 1'h0};	// core.scala:77:37, :98:79, :100:32, :101:46, :102:33, :105:32, :107:32, :111:32, :119:32, :129:32, :132:32, :140:32, :155:24, :171:24, :172:27, :268:19, :683:73, execution-units.scala:108:30, :119:32, frontend.scala:68:75
  wire [63:0]     _GEN_13 = {io_ifu_get_pc_1_ghist_old_history[62:0], 1'h1};	// core.scala:98:79, :129:32, :132:32, :268:19, :520:23, :1132:10, execution-units.scala:108:30, :119:32, frontend.scala:68:{75,80}
  wire [62:0]     _GEN_14 = {io_ifu_get_pc_1_ghist_old_history[61:0], 1'h0};	// core.scala:77:37, :98:79, :100:32, :101:46, :102:33, :105:32, :107:32, :111:32, :119:32, :129:32, :132:32, :140:32, :155:24, :171:24, :172:27, :268:19, :683:73, execution-units.scala:108:30, :119:32, frontend.scala:68:75
  wire [62:0]     _GEN_15 = {io_ifu_get_pc_1_ghist_old_history[61:0], 1'h1};	// core.scala:98:79, :129:32, :132:32, :268:19, :520:23, :1132:10, execution-units.scala:108:30, :119:32, frontend.scala:68:{75,80}
  wire            _io_ifu_redirect_flush_output =
    REG | _GEN_4 | _rob_io_flush_frontend | (|b1_mispredict_mask);	// core.scala:140:32, :197:93, :221:42, :395:{16,38}, :397:27, :418:{39,72}, :429:29, :454:78
  wire            _io_ifu_commit_valid_T =
    _rob_io_commit_valids_0 | _rob_io_commit_valids_1;	// core.scala:140:32, :460:55
  wire [3:0][4:0] _GEN_16 =
    {{_rob_io_commit_uops_0_ftq_idx},
     {_rob_io_commit_uops_2_ftq_idx},
     {_rob_io_commit_uops_1_ftq_idx},
     {_rob_io_commit_uops_0_ftq_idx}};	// core.scala:140:32, :461:29
  reg             io_ifu_sfence_REG_valid;	// core.scala:470:31
  reg             io_ifu_sfence_REG_bits_rs1;	// core.scala:470:31
  reg             io_ifu_sfence_REG_bits_rs2;	// core.scala:470:31
  reg  [38:0]     io_ifu_sfence_REG_bits_addr;	// core.scala:470:31
  reg  [2:0]      dec_finished_mask;	// core.scala:490:34
  wire            dec_valids_0 =
    io_ifu_fetchpacket_valid & io_ifu_fetchpacket_bits_uops_0_valid
    & ~(dec_finished_mask[0]);	// core.scala:490:34, :502:97, :503:{43,61}
  wire            dec_valids_1 =
    io_ifu_fetchpacket_valid & io_ifu_fetchpacket_bits_uops_1_valid
    & ~(dec_finished_mask[1]);	// core.scala:490:34, :502:97, :503:{43,61}
  wire            dec_valids_2 =
    io_ifu_fetchpacket_valid & io_ifu_fetchpacket_bits_uops_2_valid
    & ~(dec_finished_mask[2]);	// core.scala:490:34, :502:97, :503:{43,61}
  reg             jmp_pc_req_valid_REG;	// core.scala:533:30
  reg  [4:0]      jmp_pc_req_bits_REG;	// core.scala:534:30
  wire [3:0][4:0] _GEN_17 =
    {{_decode_units_0_io_deq_uop_ftq_idx},
     {_decode_units_2_io_deq_uop_ftq_idx},
     {_decode_units_1_io_deq_uop_ftq_idx},
     {_decode_units_0_io_deq_uop_ftq_idx}};	// core.scala:98:79, :546:24
  assign dec_xcpts_0 = _decode_units_0_io_deq_uop_exception & dec_valids_0;	// core.scala:98:79, :502:97, :560:71
  assign dec_xcpts_1 = _decode_units_1_io_deq_uop_exception & dec_valids_1;	// core.scala:98:79, :502:97, :560:71
  wire            dec_xcpt_stall =
    (dec_xcpts_0 | dec_xcpts_1 | _decode_units_2_io_deq_uop_exception & dec_valids_2)
    & ~_ftq_arb_io_in_2_ready;	// core.scala:98:79, :502:97, :520:23, :560:71, :561:{42,47,50}
  wire            dec_stalls_0 =
    dec_valids_0
    & (dis_stalls_2 | _rob_io_commit_rollback | dec_xcpt_stall
       | _dec_brmask_logic_io_is_full_0 | (|b1_mispredict_mask) | b2_mispredict
       | _io_ifu_redirect_flush_output);	// core.scala:99:32, :140:32, :187:18, :197:93, :221:42, :395:38, :397:27, :418:72, :429:29, :454:78, :502:97, :561:47, :566:37, :573:23, :707:62
  wire            dec_stalls_1 =
    dec_stalls_0 | dec_valids_1
    & (dis_stalls_2 | _rob_io_commit_rollback | dec_xcpt_stall
       | _dec_brmask_logic_io_is_full_1 | (|b1_mispredict_mask) | b2_mispredict
       | _io_ifu_redirect_flush_output);	// core.scala:99:32, :140:32, :187:18, :197:93, :221:42, :395:38, :397:27, :418:72, :429:29, :454:78, :502:97, :561:47, :566:37, :573:23, :575:62, :707:62
  wire            dec_fire_0 = dec_valids_0 & ~dec_stalls_0;	// core.scala:502:97, :566:37, :576:{58,61}
  wire            dec_fire_1 = dec_valids_1 & ~dec_stalls_1;	// core.scala:502:97, :575:62, :576:{58,61}
  wire            dec_ready =
    dec_valids_2
    & ~(dec_stalls_1 | dec_valids_2
        & (dis_stalls_2 | _rob_io_commit_rollback | dec_xcpt_stall
           | _dec_brmask_logic_io_is_full_2 | (|b1_mispredict_mask) | b2_mispredict
           | _io_ifu_redirect_flush_output));	// core.scala:99:32, :140:32, :187:18, :197:93, :221:42, :395:38, :397:27, :418:72, :429:29, :454:78, :502:97, :561:47, :566:37, :573:23, :575:62, :576:{58,61}, :707:62
  reg             dec_brmask_logic_io_flush_pipeline_REG;	// core.scala:591:48
  wire            _dis_uops_0_prs1_busy_T_2 =
    _rename_stage_io_ren2_uops_0_lrs1_rtype == 2'h1;	// core.scala:100:32, :648:52
  wire            _dis_uops_0_prs1_busy_T =
    _rename_stage_io_ren2_uops_0_lrs1_rtype == 2'h0;	// core.scala:100:32, :426:52, :649:52
  wire [6:0]      dis_uops_0_prs1 =
    _dis_uops_0_prs1_busy_T_2
      ? _fp_rename_stage_io_ren2_uops_0_prs1
      : _dis_uops_0_prs1_busy_T
          ? _rename_stage_io_ren2_uops_0_prs1
          : {1'h0, _rename_stage_io_ren2_uops_0_lrs1};	// core.scala:77:37, :98:79, :100:32, :101:46, :102:33, :105:32, :107:32, :111:32, :119:32, :129:32, :132:32, :140:32, :155:24, :171:24, :172:27, :268:19, :648:{28,52}, :649:{28,52}, :683:73, execution-units.scala:108:30, :119:32
  wire            _dis_uops_0_prs2_busy_T_2 =
    _rename_stage_io_ren2_uops_0_lrs2_rtype == 2'h1;	// core.scala:100:32, :648:52, :650:52
  wire [6:0]      dis_uops_0_prs2 =
    _dis_uops_0_prs2_busy_T_2
      ? _fp_rename_stage_io_ren2_uops_0_prs2
      : _rename_stage_io_ren2_uops_0_prs2;	// core.scala:100:32, :101:46, :650:{28,52}
  wire            _dis_uops_0_stale_pdst_T =
    _rename_stage_io_ren2_uops_0_dst_rtype == 2'h1;	// core.scala:100:32, :648:52, :653:52
  wire [6:0]      dis_uops_0_pdst =
    _dis_uops_0_stale_pdst_T
      ? _fp_rename_stage_io_ren2_uops_0_pdst
      : _rename_stage_io_ren2_uops_0_dst_rtype == 2'h0
          ? _rename_stage_io_ren2_uops_0_pdst
          : 7'h0;	// core.scala:100:32, :101:46, :426:52, :653:{28,52}, :654:{28,52}
  wire [6:0]      dis_uops_0_stale_pdst =
    _dis_uops_0_stale_pdst_T
      ? _fp_rename_stage_io_ren2_uops_0_stale_pdst
      : _rename_stage_io_ren2_uops_0_stale_pdst;	// core.scala:100:32, :101:46, :653:52, :656:34
  wire            dis_uops_0_prs1_busy =
    _rename_stage_io_ren2_uops_0_prs1_busy & _dis_uops_0_prs1_busy_T
    | _fp_rename_stage_io_ren2_uops_0_prs1_busy & _dis_uops_0_prs1_busy_T_2;	// core.scala:100:32, :101:46, :648:52, :649:52, :658:{46,85}, :659:46
  wire            dis_uops_0_prs2_busy =
    _rename_stage_io_ren2_uops_0_prs2_busy
    & _rename_stage_io_ren2_uops_0_lrs2_rtype == 2'h0
    | _fp_rename_stage_io_ren2_uops_0_prs2_busy & _dis_uops_0_prs2_busy_T_2;	// core.scala:100:32, :101:46, :426:52, :650:52, :660:{46,73,85}, :661:46
  wire            dis_uops_0_prs3_busy =
    _fp_rename_stage_io_ren2_uops_0_prs3_busy & _rename_stage_io_ren2_uops_0_frs3_en;	// core.scala:100:32, :101:46, :662:46
  wire            _dis_uops_1_prs1_busy_T_2 =
    _rename_stage_io_ren2_uops_1_lrs1_rtype == 2'h1;	// core.scala:100:32, :648:52
  wire            _dis_uops_1_prs1_busy_T =
    _rename_stage_io_ren2_uops_1_lrs1_rtype == 2'h0;	// core.scala:100:32, :426:52, :649:52
  wire [6:0]      dis_uops_1_prs1 =
    _dis_uops_1_prs1_busy_T_2
      ? _fp_rename_stage_io_ren2_uops_1_prs1
      : _dis_uops_1_prs1_busy_T
          ? _rename_stage_io_ren2_uops_1_prs1
          : {1'h0, _rename_stage_io_ren2_uops_1_lrs1};	// core.scala:77:37, :98:79, :100:32, :101:46, :102:33, :105:32, :107:32, :111:32, :119:32, :129:32, :132:32, :140:32, :155:24, :171:24, :172:27, :268:19, :648:{28,52}, :649:{28,52}, :683:73, execution-units.scala:108:30, :119:32
  wire            _dis_uops_1_prs2_busy_T_2 =
    _rename_stage_io_ren2_uops_1_lrs2_rtype == 2'h1;	// core.scala:100:32, :648:52, :650:52
  wire [6:0]      dis_uops_1_prs2 =
    _dis_uops_1_prs2_busy_T_2
      ? _fp_rename_stage_io_ren2_uops_1_prs2
      : _rename_stage_io_ren2_uops_1_prs2;	// core.scala:100:32, :101:46, :650:{28,52}
  wire            _dis_uops_1_stale_pdst_T =
    _rename_stage_io_ren2_uops_1_dst_rtype == 2'h1;	// core.scala:100:32, :648:52, :653:52
  wire [6:0]      dis_uops_1_pdst =
    _dis_uops_1_stale_pdst_T
      ? _fp_rename_stage_io_ren2_uops_1_pdst
      : _rename_stage_io_ren2_uops_1_dst_rtype == 2'h0
          ? _rename_stage_io_ren2_uops_1_pdst
          : 7'h0;	// core.scala:100:32, :101:46, :426:52, :653:{28,52}, :654:{28,52}
  wire [6:0]      dis_uops_1_stale_pdst =
    _dis_uops_1_stale_pdst_T
      ? _fp_rename_stage_io_ren2_uops_1_stale_pdst
      : _rename_stage_io_ren2_uops_1_stale_pdst;	// core.scala:100:32, :101:46, :653:52, :656:34
  wire            dis_uops_1_prs1_busy =
    _rename_stage_io_ren2_uops_1_prs1_busy & _dis_uops_1_prs1_busy_T
    | _fp_rename_stage_io_ren2_uops_1_prs1_busy & _dis_uops_1_prs1_busy_T_2;	// core.scala:100:32, :101:46, :648:52, :649:52, :658:{46,85}, :659:46
  wire            dis_uops_1_prs2_busy =
    _rename_stage_io_ren2_uops_1_prs2_busy
    & _rename_stage_io_ren2_uops_1_lrs2_rtype == 2'h0
    | _fp_rename_stage_io_ren2_uops_1_prs2_busy & _dis_uops_1_prs2_busy_T_2;	// core.scala:100:32, :101:46, :426:52, :650:52, :660:{46,73,85}, :661:46
  wire            dis_uops_1_prs3_busy =
    _fp_rename_stage_io_ren2_uops_1_prs3_busy & _rename_stage_io_ren2_uops_1_frs3_en;	// core.scala:100:32, :101:46, :662:46
  wire            _dis_uops_2_prs1_busy_T_2 =
    _rename_stage_io_ren2_uops_2_lrs1_rtype == 2'h1;	// core.scala:100:32, :648:52
  wire            _dis_uops_2_prs1_busy_T =
    _rename_stage_io_ren2_uops_2_lrs1_rtype == 2'h0;	// core.scala:100:32, :426:52, :649:52
  wire [6:0]      dis_uops_2_prs1 =
    _dis_uops_2_prs1_busy_T_2
      ? _fp_rename_stage_io_ren2_uops_2_prs1
      : _dis_uops_2_prs1_busy_T
          ? _rename_stage_io_ren2_uops_2_prs1
          : {1'h0, _rename_stage_io_ren2_uops_2_lrs1};	// core.scala:77:37, :98:79, :100:32, :101:46, :102:33, :105:32, :107:32, :111:32, :119:32, :129:32, :132:32, :140:32, :155:24, :171:24, :172:27, :268:19, :648:{28,52}, :649:{28,52}, :683:73, execution-units.scala:108:30, :119:32
  wire            _dis_uops_2_prs2_busy_T_2 =
    _rename_stage_io_ren2_uops_2_lrs2_rtype == 2'h1;	// core.scala:100:32, :648:52, :650:52
  wire [6:0]      dis_uops_2_prs2 =
    _dis_uops_2_prs2_busy_T_2
      ? _fp_rename_stage_io_ren2_uops_2_prs2
      : _rename_stage_io_ren2_uops_2_prs2;	// core.scala:100:32, :101:46, :650:{28,52}
  wire            _dis_uops_2_stale_pdst_T =
    _rename_stage_io_ren2_uops_2_dst_rtype == 2'h1;	// core.scala:100:32, :648:52, :653:52
  wire [6:0]      dis_uops_2_pdst =
    _dis_uops_2_stale_pdst_T
      ? _fp_rename_stage_io_ren2_uops_2_pdst
      : _rename_stage_io_ren2_uops_2_dst_rtype == 2'h0
          ? _rename_stage_io_ren2_uops_2_pdst
          : 7'h0;	// core.scala:100:32, :101:46, :426:52, :653:{28,52}, :654:{28,52}
  wire [6:0]      dis_uops_2_stale_pdst =
    _dis_uops_2_stale_pdst_T
      ? _fp_rename_stage_io_ren2_uops_2_stale_pdst
      : _rename_stage_io_ren2_uops_2_stale_pdst;	// core.scala:100:32, :101:46, :653:52, :656:34
  wire            dis_uops_2_prs1_busy =
    _rename_stage_io_ren2_uops_2_prs1_busy & _dis_uops_2_prs1_busy_T
    | _fp_rename_stage_io_ren2_uops_2_prs1_busy & _dis_uops_2_prs1_busy_T_2;	// core.scala:100:32, :101:46, :648:52, :649:52, :658:{46,85}, :659:46
  wire            dis_uops_2_prs2_busy =
    _rename_stage_io_ren2_uops_2_prs2_busy
    & _rename_stage_io_ren2_uops_2_lrs2_rtype == 2'h0
    | _fp_rename_stage_io_ren2_uops_2_prs2_busy & _dis_uops_2_prs2_busy_T_2;	// core.scala:100:32, :101:46, :426:52, :650:52, :660:{46,73,85}, :661:46
  wire            dis_uops_2_prs3_busy =
    _fp_rename_stage_io_ren2_uops_2_prs3_busy & _rename_stage_io_ren2_uops_2_frs3_en;	// core.scala:100:32, :101:46, :662:46
  wire            dis_prior_slot_unique_1 =
    _rename_stage_io_ren2_mask_0 & _rename_stage_io_ren2_uops_0_is_unique;	// core.scala:100:32, :678:101
  wire            wait_for_empty_pipeline_0 =
    (_rename_stage_io_ren2_uops_0_is_unique | _csr_io_customCSRs_0_value[3])
    & (~_rob_io_empty | ~io_lsu_fencei_rdy);	// core.scala:100:32, :140:32, :268:19, :679:{85,112}, :680:{36,50,53}, parameters.scala:137:49
  wire            wait_for_empty_pipeline_1 =
    (_rename_stage_io_ren2_uops_1_is_unique | _csr_io_customCSRs_0_value[3])
    & (~_rob_io_empty | ~io_lsu_fencei_rdy | _rename_stage_io_ren2_mask_0);	// core.scala:100:32, :140:32, :268:19, :679:{85,112}, :680:{36,53,72}, parameters.scala:137:49
  wire            wait_for_empty_pipeline_2 =
    (_rename_stage_io_ren2_uops_2_is_unique | _csr_io_customCSRs_0_value[3])
    & (~_rob_io_empty | ~io_lsu_fencei_rdy | _rename_stage_io_ren2_mask_0
       | _rename_stage_io_ren2_mask_1);	// core.scala:100:32, :140:32, :268:19, :679:{85,112}, :680:{36,53,72}, parameters.scala:137:49
  wire            dis_stalls_0 =
    _rename_stage_io_ren2_mask_0
    & (~_rob_io_ready | _rename_stage_io_ren_stalls_0 | _fp_rename_stage_io_ren_stalls_0
       | io_lsu_ldq_full_0 & _rename_stage_io_ren2_uops_0_uses_ldq | io_lsu_stq_full_0
       & _rename_stage_io_ren2_uops_0_uses_stq | ~_dispatcher_io_ren_uops_0_ready
       | wait_for_empty_pipeline_0 | (|b1_mispredict_mask) | b2_mispredict
       | _io_ifu_redirect_flush_output);	// core.scala:100:32, :101:46, :111:32, :140:32, :187:18, :197:93, :221:42, :395:38, :397:27, :418:72, :429:29, :454:78, :679:112, :690:37, :691:26, :693:45, :694:45, :695:26, :702:23
  wire            dis_stalls_1 =
    dis_stalls_0 | _rename_stage_io_ren2_mask_1
    & (~_rob_io_ready | _rename_stage_io_ren_stalls_1 | _fp_rename_stage_io_ren_stalls_1
       | io_lsu_ldq_full_1 & _rename_stage_io_ren2_uops_1_uses_ldq | io_lsu_stq_full_1
       & _rename_stage_io_ren2_uops_1_uses_stq | ~_dispatcher_io_ren_uops_1_ready
       | wait_for_empty_pipeline_1 | dis_prior_slot_unique_1 | (|b1_mispredict_mask)
       | b2_mispredict | _io_ifu_redirect_flush_output);	// core.scala:100:32, :101:46, :111:32, :140:32, :187:18, :197:93, :221:42, :395:38, :397:27, :418:72, :429:29, :454:78, :678:101, :679:112, :690:37, :691:26, :693:45, :694:45, :695:26, :702:23, :707:62
  assign dis_stalls_2 =
    dis_stalls_1 | _rename_stage_io_ren2_mask_2
    & (~_rob_io_ready | _rename_stage_io_ren_stalls_2 | _fp_rename_stage_io_ren_stalls_2
       | io_lsu_ldq_full_2 & _rename_stage_io_ren2_uops_2_uses_ldq | io_lsu_stq_full_2
       & _rename_stage_io_ren2_uops_2_uses_stq | ~_dispatcher_io_ren_uops_2_ready
       | wait_for_empty_pipeline_2 | dis_prior_slot_unique_1
       | _rename_stage_io_ren2_mask_1 & _rename_stage_io_ren2_uops_1_is_unique
       | (|b1_mispredict_mask) | b2_mispredict | _io_ifu_redirect_flush_output);	// core.scala:100:32, :101:46, :111:32, :140:32, :187:18, :197:93, :221:42, :395:38, :397:27, :418:72, :429:29, :454:78, :678:101, :679:112, :690:37, :691:26, :693:45, :694:45, :695:26, :702:23, :707:62
  wire            dis_fire_0 = _rename_stage_io_ren2_mask_0 & ~dis_stalls_0;	// core.scala:100:32, :690:37, :708:{62,65}
  wire            dis_fire_1 = _rename_stage_io_ren2_mask_1 & ~dis_stalls_1;	// core.scala:100:32, :707:62, :708:{62,65}
  wire            dis_fire_2 = _rename_stage_io_ren2_mask_2 & ~dis_stalls_2;	// core.scala:100:32, :707:62, :708:{62,65}
  reg             REG_3;	// core.scala:732:16
  reg  [4:0]      io_ifu_commit_bits_REG;	// core.scala:734:35
  wire [6:0]      dis_uops_0_rob_idx = {_rob_io_rob_tail_idx[6:2], 2'h0};	// core.scala:140:32, :291:41, :426:52, :743:{27,54}
  wire [6:0]      dis_uops_1_rob_idx = {_rob_io_rob_tail_idx[6:2], 2'h1};	// core.scala:140:32, :291:41, :648:52, :743:{27,54}
  wire [6:0]      dis_uops_2_rob_idx = {_rob_io_rob_tail_idx[6:2], 2'h2};	// core.scala:140:32, :291:41, :743:{27,54}
  wire            _iregfile_io_write_ports_0_wport_valid_T =
    _ll_wbarb_io_out_bits_uop_dst_rtype == 2'h0;	// core.scala:129:32, :426:52, :789:92
  wire            int_iss_wakeups_0_valid =
    _ll_wbarb_io_out_valid & _iregfile_io_write_ports_0_wport_valid_T;	// core.scala:129:32, :789:{54,92}
  wire            _rob_io_debug_wb_valids_1_T =
    _jmp_unit_io_iresp_bits_uop_dst_rtype != 2'h2;	// core.scala:291:41, execution-units.scala:119:32, micro-op.scala:149:36
  wire            _iregister_read_io_iss_valids_1_T =
    _int_issue_unit_io_iss_uops_0_iw_p1_poisoned
    | _int_issue_unit_io_iss_uops_0_iw_p2_poisoned;	// core.scala:107:32, :822:79
  wire            fast_wakeup_valid =
    _int_issue_unit_io_iss_valids_0 & _int_issue_unit_io_iss_uops_0_bypassable
    & _int_issue_unit_io_iss_uops_0_dst_rtype == 2'h0
    & _int_issue_unit_io_iss_uops_0_ldst_val
    & ~(io_lsu_ld_miss & _iregister_read_io_iss_valids_1_T);	// core.scala:107:32, :426:52, :820:53, :821:52, :822:{31,48,79}
  wire            slow_wakeup_valid =
    _jmp_unit_io_iresp_valid & _rob_io_debug_wb_valids_1_T
    & ~_jmp_unit_io_iresp_bits_uop_bypassable & ~(|_jmp_unit_io_iresp_bits_uop_dst_rtype);	// core.scala:814:78, :828:{33,59}, :829:57, execution-units.scala:119:32, micro-op.scala:149:36
  wire            _rob_io_debug_wb_valids_2_T =
    _csr_exe_unit_io_iresp_bits_uop_dst_rtype != 2'h2;	// core.scala:291:41, execution-units.scala:119:32, micro-op.scala:149:36
  wire            _iregister_read_io_iss_valids_2_T =
    _int_issue_unit_io_iss_uops_1_iw_p1_poisoned
    | _int_issue_unit_io_iss_uops_1_iw_p2_poisoned;	// core.scala:107:32, :822:79
  wire            fast_wakeup_1_valid =
    _int_issue_unit_io_iss_valids_1 & _int_issue_unit_io_iss_uops_1_bypassable
    & _int_issue_unit_io_iss_uops_1_dst_rtype == 2'h0
    & _int_issue_unit_io_iss_uops_1_ldst_val
    & ~(io_lsu_ld_miss & _iregister_read_io_iss_valids_2_T);	// core.scala:107:32, :426:52, :820:53, :821:52, :822:{31,48,79}
  wire            slow_wakeup_1_valid =
    _csr_exe_unit_io_iresp_valid & _rob_io_debug_wb_valids_2_T
    & ~_csr_exe_unit_io_iresp_bits_uop_bypassable
    & ~(|_csr_exe_unit_io_iresp_bits_uop_dst_rtype);	// core.scala:814:78, :828:{33,59}, :829:57, execution-units.scala:119:32, micro-op.scala:149:36
  wire            _rob_io_debug_wb_valids_3_T =
    _alu_exe_unit_io_iresp_bits_uop_dst_rtype != 2'h2;	// core.scala:291:41, execution-units.scala:119:32, micro-op.scala:149:36
  wire            _iregister_read_io_iss_valids_3_T =
    _int_issue_unit_io_iss_uops_2_iw_p1_poisoned
    | _int_issue_unit_io_iss_uops_2_iw_p2_poisoned;	// core.scala:107:32, :822:79
  wire            fast_wakeup_2_valid =
    _int_issue_unit_io_iss_valids_2 & _int_issue_unit_io_iss_uops_2_bypassable
    & _int_issue_unit_io_iss_uops_2_dst_rtype == 2'h0
    & _int_issue_unit_io_iss_uops_2_ldst_val
    & ~(io_lsu_ld_miss & _iregister_read_io_iss_valids_3_T);	// core.scala:107:32, :426:52, :820:53, :821:52, :822:{31,48,79}
  wire            slow_wakeup_2_valid =
    _alu_exe_unit_io_iresp_valid & _rob_io_debug_wb_valids_3_T
    & ~_alu_exe_unit_io_iresp_bits_uop_bypassable
    & ~(|_alu_exe_unit_io_iresp_bits_uop_dst_rtype);	// core.scala:814:78, :828:{33,59}, :829:57, execution-units.scala:119:32, micro-op.scala:149:36
  reg  [4:0]      saturating_loads_counter;	// core.scala:903:41
  reg             pause_mem_REG;	// core.scala:906:26
  reg  [9:0]      REG_4;	// core.scala:919:38
  reg  [9:0]      REG_5;	// core.scala:919:38
  reg             mem_issue_unit_io_flush_pipeline_REG;	// core.scala:940:49
  reg             int_issue_unit_io_flush_pipeline_REG;	// core.scala:940:49
  reg             iregister_read_io_kill_REG;	// core.scala:981:38
  reg  [1:0]      csr_io_retire_REG;	// core.scala:1004:30
  reg             csr_io_exception_REG;	// core.scala:1005:30
  reg  [5:0]      csr_io_pc_REG;	// core.scala:1009:31
  reg             csr_io_pc_REG_1;	// core.scala:1010:35
  reg  [63:0]     csr_io_cause_REG;	// core.scala:1012:30
  reg  [39:0]     csr_io_tval_REG;	// core.scala:1029:12
  reg             io_lsu_exception_REG;	// core.scala:1109:30
  reg             REG_6;	// core.scala:1291:45
  reg             alu_exe_unit_io_req_bits_kill_REG;	// core.scala:1295:45
  reg             alu_exe_unit_io_req_bits_kill_REG_1;	// core.scala:1295:45
  reg             alu_exe_unit_io_req_bits_kill_REG_2;	// core.scala:1295:45
  reg  [4:0]      value_lo;	// Counters.scala:45:37
  reg  [26:0]     value_hi;	// Counters.scala:50:27
  `ifndef SYNTHESIS	// core.scala:221:10
    always @(posedge clock) begin	// core.scala:221:10
      automatic logic _GEN_18 = _jmp_unit_io_iresp_valid & _rob_io_debug_wb_valids_1_T;	// core.scala:814:27, execution-units.scala:119:32, micro-op.scala:149:36
      automatic logic _GEN_19 =
        ~(_GEN_18 & (|_jmp_unit_io_iresp_bits_uop_dst_rtype)) | reset;	// core.scala:814:{13,14,27,51,78}, execution-units.scala:119:32
      automatic logic _GEN_20 =
        _csr_exe_unit_io_iresp_valid & _rob_io_debug_wb_valids_2_T;	// core.scala:814:27, execution-units.scala:119:32, micro-op.scala:149:36
      automatic logic _GEN_21 =
        ~(_GEN_20 & (|_csr_exe_unit_io_iresp_bits_uop_dst_rtype)) | reset;	// core.scala:814:{13,14,27,51,78}, execution-units.scala:119:32
      automatic logic _GEN_22 =
        _alu_exe_unit_io_iresp_valid & _rob_io_debug_wb_valids_3_T;	// core.scala:814:27, execution-units.scala:119:32, micro-op.scala:149:36
      automatic logic _GEN_23 =
        ~(_GEN_22 & (|_alu_exe_unit_io_iresp_bits_uop_dst_rtype)) | reset;	// core.scala:814:{13,14,27,51,78}, execution-units.scala:119:32
      if (~(~(((|b1_mispredict_mask) | b2_mispredict) & _rob_io_commit_rollback)
            | reset)) begin	// core.scala:140:32, :187:18, :197:93, :221:{10,11,42,50}, :222:5
        if (`ASSERT_VERBOSE_COND_)	// core.scala:221:10
          $error("Assertion failed: Can't have a mispredict during rollback.\n    at core.scala:221 assert (!((brupdate.b1.mispredict_mask =/= 0.U || brupdate.b2.mispredict)\n");	// core.scala:221:10
        if (`STOP_COND_)	// core.scala:221:10
          $fatal;	// core.scala:221:10
      end
      if (~(~((_io_ifu_commit_valid_T | _rob_io_commit_valids_2) & _rob_io_com_xcpt_valid)
            | reset)) begin	// core.scala:140:32, :460:55, :465:{9,10,41,45}
        if (`ASSERT_VERBOSE_COND_)	// core.scala:465:9
          $error("Assertion failed: ROB can't commit and except in same cycle!\n    at core.scala:465 assert(!(rob.io.commit.valids.reduce(_|_) && rob.io.com_xcpt.valid),\n");	// core.scala:465:9
        if (`STOP_COND_)	// core.scala:465:9
          $fatal;	// core.scala:465:9
      end
      if (~_GEN_19) begin	// core.scala:814:13
        if (`ASSERT_VERBOSE_COND_)	// core.scala:814:13
          $error("Assertion failed\n    at core.scala:814 assert(!(resp.valid && resp.bits.uop.rf_wen && resp.bits.uop.dst_rtype =/= RT_FIX))\n");	// core.scala:814:13
        if (`STOP_COND_)	// core.scala:814:13
          $fatal;	// core.scala:814:13
      end
      if (~_GEN_21) begin	// core.scala:814:13
        if (`ASSERT_VERBOSE_COND_)	// core.scala:814:13
          $error("Assertion failed\n    at core.scala:814 assert(!(resp.valid && resp.bits.uop.rf_wen && resp.bits.uop.dst_rtype =/= RT_FIX))\n");	// core.scala:814:13
        if (`STOP_COND_)	// core.scala:814:13
          $fatal;	// core.scala:814:13
      end
      if (~_GEN_23) begin	// core.scala:814:13
        if (`ASSERT_VERBOSE_COND_)	// core.scala:814:13
          $error("Assertion failed\n    at core.scala:814 assert(!(resp.valid && resp.bits.uop.rf_wen && resp.bits.uop.dst_rtype =/= RT_FIX))\n");	// core.scala:814:13
        if (`STOP_COND_)	// core.scala:814:13
          $fatal;	// core.scala:814:13
      end
      if (~(~(_GEN_18 & _jmp_unit_io_iresp_bits_uop_dst_rtype == 2'h1) | reset)) begin	// core.scala:648:52, :814:27, :1145:{48,77}, :1157:{14,15}, execution-units.scala:119:32
        if (`ASSERT_VERBOSE_COND_)	// core.scala:1157:14
          $error("Assertion failed: [fppipeline] An FP writeback is being attempted to the Int Regfile.\n    at core.scala:1157 assert (!wbIsValid(RT_FLT), \"[fppipeline] An FP writeback is being attempted to the Int Regfile.\")\n");	// core.scala:1157:14
        if (`STOP_COND_)	// core.scala:1157:14
          $fatal;	// core.scala:1157:14
      end
      if (~(~(_jmp_unit_io_iresp_valid & ~_rob_io_debug_wb_valids_1_T
              & ~(|_jmp_unit_io_iresp_bits_uop_dst_rtype)) | reset)) begin	// core.scala:814:78, :829:57, :1159:{14,15}, :1160:{9,33}, execution-units.scala:119:32, micro-op.scala:149:36
        if (`ASSERT_VERBOSE_COND_)	// core.scala:1159:14
          $error("Assertion failed: [fppipeline] An Int writeback is being attempted with rf_wen disabled.\n    at core.scala:1159 assert (!(wbresp.valid &&\n");	// core.scala:1159:14
        if (`STOP_COND_)	// core.scala:1159:14
          $fatal;	// core.scala:1159:14
      end
      if (~_GEN_19) begin	// core.scala:814:13, :1164:14
        if (`ASSERT_VERBOSE_COND_)	// core.scala:1164:14
          $error("Assertion failed: [fppipeline] writeback being attempted to Int RF with dst != Int type exe_units(1).iresp\n    at core.scala:1164 assert (!(wbresp.valid &&\n");	// core.scala:1164:14
        if (`STOP_COND_)	// core.scala:1164:14
          $fatal;	// core.scala:1164:14
      end
      if (~(~(_GEN_20 & _csr_exe_unit_io_iresp_bits_uop_dst_rtype == 2'h1) | reset)) begin	// core.scala:648:52, :814:27, :1145:{48,77}, :1157:{14,15}, execution-units.scala:119:32
        if (`ASSERT_VERBOSE_COND_)	// core.scala:1157:14
          $error("Assertion failed: [fppipeline] An FP writeback is being attempted to the Int Regfile.\n    at core.scala:1157 assert (!wbIsValid(RT_FLT), \"[fppipeline] An FP writeback is being attempted to the Int Regfile.\")\n");	// core.scala:1157:14
        if (`STOP_COND_)	// core.scala:1157:14
          $fatal;	// core.scala:1157:14
      end
      if (~(~(_csr_exe_unit_io_iresp_valid & ~_rob_io_debug_wb_valids_2_T
              & ~(|_csr_exe_unit_io_iresp_bits_uop_dst_rtype)) | reset)) begin	// core.scala:814:78, :829:57, :1159:{14,15}, :1160:{9,33}, execution-units.scala:119:32, micro-op.scala:149:36
        if (`ASSERT_VERBOSE_COND_)	// core.scala:1159:14
          $error("Assertion failed: [fppipeline] An Int writeback is being attempted with rf_wen disabled.\n    at core.scala:1159 assert (!(wbresp.valid &&\n");	// core.scala:1159:14
        if (`STOP_COND_)	// core.scala:1159:14
          $fatal;	// core.scala:1159:14
      end
      if (~_GEN_21) begin	// core.scala:814:13, :1164:14
        if (`ASSERT_VERBOSE_COND_)	// core.scala:1164:14
          $error("Assertion failed: [fppipeline] writeback being attempted to Int RF with dst != Int type exe_units(2).iresp\n    at core.scala:1164 assert (!(wbresp.valid &&\n");	// core.scala:1164:14
        if (`STOP_COND_)	// core.scala:1164:14
          $fatal;	// core.scala:1164:14
      end
      if (~(~(_GEN_22 & _alu_exe_unit_io_iresp_bits_uop_dst_rtype == 2'h1) | reset)) begin	// core.scala:648:52, :814:27, :1145:{48,77}, :1157:{14,15}, execution-units.scala:119:32
        if (`ASSERT_VERBOSE_COND_)	// core.scala:1157:14
          $error("Assertion failed: [fppipeline] An FP writeback is being attempted to the Int Regfile.\n    at core.scala:1157 assert (!wbIsValid(RT_FLT), \"[fppipeline] An FP writeback is being attempted to the Int Regfile.\")\n");	// core.scala:1157:14
        if (`STOP_COND_)	// core.scala:1157:14
          $fatal;	// core.scala:1157:14
      end
      if (~(~(_alu_exe_unit_io_iresp_valid & ~_rob_io_debug_wb_valids_3_T
              & ~(|_alu_exe_unit_io_iresp_bits_uop_dst_rtype)) | reset)) begin	// core.scala:814:78, :829:57, :1159:{14,15}, :1160:{9,33}, execution-units.scala:119:32, micro-op.scala:149:36
        if (`ASSERT_VERBOSE_COND_)	// core.scala:1159:14
          $error("Assertion failed: [fppipeline] An Int writeback is being attempted with rf_wen disabled.\n    at core.scala:1159 assert (!(wbresp.valid &&\n");	// core.scala:1159:14
        if (`STOP_COND_)	// core.scala:1159:14
          $fatal;	// core.scala:1159:14
      end
      if (~_GEN_23) begin	// core.scala:814:13, :1164:14
        if (`ASSERT_VERBOSE_COND_)	// core.scala:1164:14
          $error("Assertion failed: [fppipeline] writeback being attempted to Int RF with dst != Int type exe_units(3).iresp\n    at core.scala:1164 assert (!(wbresp.valid &&\n");	// core.scala:1164:14
        if (`STOP_COND_)	// core.scala:1164:14
          $fatal;	// core.scala:1164:14
      end
      if (~(~(_fp_pipeline_io_wakeups_0_valid
              & _fp_pipeline_io_wakeups_0_bits_uop_dst_rtype != 2'h1) | reset)) begin	// core.scala:77:37, :648:52, :1251:{14,15,30,59}
        if (`ASSERT_VERBOSE_COND_)	// core.scala:1251:14
          $error("Assertion failed: [core] FP wakeup does not write back to a FP register.\n    at core.scala:1251 assert (!(wakeup.valid && wakeup.bits.uop.dst_rtype =/= RT_FLT),\n");	// core.scala:1251:14
        if (`STOP_COND_)	// core.scala:1251:14
          $fatal;	// core.scala:1251:14
      end
      if (~(~(_fp_pipeline_io_wakeups_0_valid
              & ~_fp_pipeline_io_wakeups_0_bits_uop_fp_val) | reset)) begin	// core.scala:77:37, :1254:{14,15,30,33}
        if (`ASSERT_VERBOSE_COND_)	// core.scala:1254:14
          $error("Assertion failed: [core] FP wakeup does not involve an FP instruction.\n    at core.scala:1254 assert (!(wakeup.valid && !wakeup.bits.uop.fp_val),\n");	// core.scala:1254:14
        if (`STOP_COND_)	// core.scala:1254:14
          $fatal;	// core.scala:1254:14
      end
      if (~(~(_fp_pipeline_io_wakeups_1_valid
              & _fp_pipeline_io_wakeups_1_bits_uop_dst_rtype != 2'h1) | reset)) begin	// core.scala:77:37, :648:52, :1251:{14,15,30,59}
        if (`ASSERT_VERBOSE_COND_)	// core.scala:1251:14
          $error("Assertion failed: [core] FP wakeup does not write back to a FP register.\n    at core.scala:1251 assert (!(wakeup.valid && wakeup.bits.uop.dst_rtype =/= RT_FLT),\n");	// core.scala:1251:14
        if (`STOP_COND_)	// core.scala:1251:14
          $fatal;	// core.scala:1251:14
      end
      if (~(~(_fp_pipeline_io_wakeups_1_valid
              & ~_fp_pipeline_io_wakeups_1_bits_uop_fp_val) | reset)) begin	// core.scala:77:37, :1254:{14,15,30,33}
        if (`ASSERT_VERBOSE_COND_)	// core.scala:1254:14
          $error("Assertion failed: [core] FP wakeup does not involve an FP instruction.\n    at core.scala:1254 assert (!(wakeup.valid && !wakeup.bits.uop.fp_val),\n");	// core.scala:1254:14
        if (`STOP_COND_)	// core.scala:1254:14
          $fatal;	// core.scala:1254:14
      end
      if (~(~_csr_io_singleStep | reset)) begin	// core.scala:268:19, :1282:{10,11}
        if (`ASSERT_VERBOSE_COND_)	// core.scala:1282:10
          $error("Assertion failed: [core] single-step is unsupported.\n    at core.scala:1282 assert (!(csr.io.singleStep), \"[core] single-step is unsupported.\")\n");	// core.scala:1282:10
        if (`STOP_COND_)	// core.scala:1282:10
          $fatal;	// core.scala:1282:10
      end
      if (~(~(_rob_io_com_xcpt_valid & ~_rob_io_flush_valid) | reset)) begin	// core.scala:140:32, :194:37, :1298:{10,11,35}
        if (`ASSERT_VERBOSE_COND_)	// core.scala:1298:10
          $error("Assertion failed: [core] exception occurred, but pipeline flush signal not set!\n    at core.scala:1298 assert (!(rob.io.com_xcpt.valid && !rob.io.flush.valid),\n");	// core.scala:1298:10
        if (`STOP_COND_)	// core.scala:1298:10
          $fatal;	// core.scala:1298:10
      end
      if (~(~(value_hi[8]) | reset)) begin	// Counters.scala:50:27, core.scala:1315:{10,11,30}
        if (`ASSERT_VERBOSE_COND_)	// core.scala:1315:10
          $error("Assertion failed: Pipeline has hung.\n    at core.scala:1315 assert (!(idle_cycles.value(13)), \"Pipeline has hung.\")\n");	// core.scala:1315:10
        if (`STOP_COND_)	// core.scala:1315:10
          $fatal;	// core.scala:1315:10
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    automatic logic            loads_saturating;	// core.scala:902:57
    automatic logic [3:0]      _GEN_24 =
      {{_rename_stage_io_ren2_uops_0_is_sys_pc2epc},
       {_rename_stage_io_ren2_uops_2_is_sys_pc2epc},
       {_rename_stage_io_ren2_uops_1_is_sys_pc2epc},
       {_rename_stage_io_ren2_uops_0_is_sys_pc2epc}};	// core.scala:100:32, :732:39
    automatic logic [3:0][4:0] _GEN_25 =
      {{_rename_stage_io_ren2_uops_0_ftq_idx},
       {_rename_stage_io_ren2_uops_2_ftq_idx},
       {_rename_stage_io_ren2_uops_1_ftq_idx},
       {_rename_stage_io_ren2_uops_0_ftq_idx}};	// core.scala:100:32, :734:35
    loads_saturating =
      _mem_issue_unit_io_iss_valids_0 & _mem_issue_unit_io_iss_uops_0_uses_ldq;	// core.scala:105:32, :902:57
    brinfos_0_uop_is_rvc <= _jmp_unit_io_brinfo_uop_is_rvc;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_0_uop_br_mask <= _jmp_unit_io_brinfo_uop_br_mask;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_0_uop_br_tag <= _jmp_unit_io_brinfo_uop_br_tag;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_0_uop_ftq_idx <= _jmp_unit_io_brinfo_uop_ftq_idx;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_0_uop_edge_inst <= _jmp_unit_io_brinfo_uop_edge_inst;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_0_uop_pc_lob <= _jmp_unit_io_brinfo_uop_pc_lob;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_0_uop_rob_idx <= _jmp_unit_io_brinfo_uop_rob_idx;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_0_uop_ldq_idx <= _jmp_unit_io_brinfo_uop_ldq_idx;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_0_uop_stq_idx <= _jmp_unit_io_brinfo_uop_stq_idx;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_0_valid <= _jmp_unit_io_brinfo_valid & ~_rob_io_flush_valid;	// core.scala:140:32, :179:20, :194:{34,37}, execution-units.scala:119:32
    brinfos_0_mispredict <= _jmp_unit_io_brinfo_mispredict;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_0_taken <= _jmp_unit_io_brinfo_taken;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_0_cfi_type <= _jmp_unit_io_brinfo_cfi_type;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_0_pc_sel <= _jmp_unit_io_brinfo_pc_sel;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_0_target_offset <= _jmp_unit_io_brinfo_target_offset;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_1_uop_is_rvc <= _csr_exe_unit_io_brinfo_uop_is_rvc;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_1_uop_br_mask <= _csr_exe_unit_io_brinfo_uop_br_mask;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_1_uop_br_tag <= _csr_exe_unit_io_brinfo_uop_br_tag;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_1_uop_ftq_idx <= _csr_exe_unit_io_brinfo_uop_ftq_idx;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_1_uop_edge_inst <= _csr_exe_unit_io_brinfo_uop_edge_inst;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_1_uop_pc_lob <= _csr_exe_unit_io_brinfo_uop_pc_lob;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_1_uop_rob_idx <= _csr_exe_unit_io_brinfo_uop_rob_idx;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_1_uop_ldq_idx <= _csr_exe_unit_io_brinfo_uop_ldq_idx;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_1_uop_stq_idx <= _csr_exe_unit_io_brinfo_uop_stq_idx;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_1_valid <= _csr_exe_unit_io_brinfo_valid & ~_rob_io_flush_valid;	// core.scala:140:32, :179:20, :194:{34,37}, execution-units.scala:119:32
    brinfos_1_mispredict <= _csr_exe_unit_io_brinfo_mispredict;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_1_taken <= _csr_exe_unit_io_brinfo_taken;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_1_cfi_type <= _csr_exe_unit_io_brinfo_cfi_type;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_1_pc_sel <= _csr_exe_unit_io_brinfo_pc_sel;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_1_target_offset <= _csr_exe_unit_io_brinfo_target_offset;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_2_uop_is_rvc <= _alu_exe_unit_io_brinfo_uop_is_rvc;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_2_uop_br_mask <= _alu_exe_unit_io_brinfo_uop_br_mask;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_2_uop_br_tag <= _alu_exe_unit_io_brinfo_uop_br_tag;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_2_uop_ftq_idx <= _alu_exe_unit_io_brinfo_uop_ftq_idx;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_2_uop_edge_inst <= _alu_exe_unit_io_brinfo_uop_edge_inst;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_2_uop_pc_lob <= _alu_exe_unit_io_brinfo_uop_pc_lob;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_2_uop_rob_idx <= _alu_exe_unit_io_brinfo_uop_rob_idx;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_2_uop_ldq_idx <= _alu_exe_unit_io_brinfo_uop_ldq_idx;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_2_uop_stq_idx <= _alu_exe_unit_io_brinfo_uop_stq_idx;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_2_valid <= _alu_exe_unit_io_brinfo_valid & ~_rob_io_flush_valid;	// core.scala:140:32, :179:20, :194:{34,37}, execution-units.scala:119:32
    brinfos_2_mispredict <= _alu_exe_unit_io_brinfo_mispredict;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_2_taken <= _alu_exe_unit_io_brinfo_taken;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_2_cfi_type <= _alu_exe_unit_io_brinfo_cfi_type;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_2_pc_sel <= _alu_exe_unit_io_brinfo_pc_sel;	// core.scala:179:20, execution-units.scala:119:32
    brinfos_2_target_offset <= _alu_exe_unit_io_brinfo_target_offset;	// core.scala:179:20, execution-units.scala:119:32
    if (use_this_mispredict_2) begin	// core.scala:203:47
      b2_uop_is_rvc <= brinfos_2_uop_is_rvc;	// core.scala:179:20, :187:18
      b2_uop_br_tag <= brinfos_2_uop_br_tag;	// core.scala:179:20, :187:18
      b2_uop_ftq_idx <= brinfos_2_uop_ftq_idx;	// core.scala:179:20, :187:18
      b2_uop_edge_inst <= brinfos_2_uop_edge_inst;	// core.scala:179:20, :187:18
      b2_uop_pc_lob <= brinfos_2_uop_pc_lob;	// core.scala:179:20, :187:18
      b2_uop_rob_idx <= brinfos_2_uop_rob_idx;	// core.scala:179:20, :187:18
      b2_uop_ldq_idx <= brinfos_2_uop_ldq_idx;	// core.scala:179:20, :187:18
      b2_uop_stq_idx <= brinfos_2_uop_stq_idx;	// core.scala:179:20, :187:18
      b2_taken <= brinfos_2_taken;	// core.scala:179:20, :187:18
      b2_cfi_type <= brinfos_2_cfi_type;	// core.scala:179:20, :187:18
      b2_pc_sel <= brinfos_2_pc_sel;	// core.scala:179:20, :187:18
      b2_target_offset <= brinfos_2_target_offset;	// core.scala:179:20, :187:18
    end
    else if (use_this_mispredict_1) begin	// core.scala:203:47
      b2_uop_is_rvc <= brinfos_1_uop_is_rvc;	// core.scala:179:20, :187:18
      b2_uop_br_tag <= brinfos_1_uop_br_tag;	// core.scala:179:20, :187:18
      b2_uop_ftq_idx <= brinfos_1_uop_ftq_idx;	// core.scala:179:20, :187:18
      b2_uop_edge_inst <= brinfos_1_uop_edge_inst;	// core.scala:179:20, :187:18
      b2_uop_pc_lob <= brinfos_1_uop_pc_lob;	// core.scala:179:20, :187:18
      b2_uop_rob_idx <= brinfos_1_uop_rob_idx;	// core.scala:179:20, :187:18
      b2_uop_ldq_idx <= brinfos_1_uop_ldq_idx;	// core.scala:179:20, :187:18
      b2_uop_stq_idx <= brinfos_1_uop_stq_idx;	// core.scala:179:20, :187:18
      b2_taken <= brinfos_1_taken;	// core.scala:179:20, :187:18
      b2_cfi_type <= brinfos_1_cfi_type;	// core.scala:179:20, :187:18
      b2_pc_sel <= brinfos_1_pc_sel;	// core.scala:179:20, :187:18
      b2_target_offset <= brinfos_1_target_offset;	// core.scala:179:20, :187:18
    end
    else begin	// core.scala:203:47
      b2_uop_is_rvc <= brinfos_0_uop_is_rvc;	// core.scala:179:20, :187:18
      b2_uop_br_tag <= brinfos_0_uop_br_tag;	// core.scala:179:20, :187:18
      b2_uop_ftq_idx <= brinfos_0_uop_ftq_idx;	// core.scala:179:20, :187:18
      b2_uop_edge_inst <= brinfos_0_uop_edge_inst;	// core.scala:179:20, :187:18
      b2_uop_pc_lob <= brinfos_0_uop_pc_lob;	// core.scala:179:20, :187:18
      b2_uop_rob_idx <= brinfos_0_uop_rob_idx;	// core.scala:179:20, :187:18
      b2_uop_ldq_idx <= brinfos_0_uop_ldq_idx;	// core.scala:179:20, :187:18
      b2_uop_stq_idx <= brinfos_0_uop_stq_idx;	// core.scala:179:20, :187:18
      b2_taken <= brinfos_0_taken;	// core.scala:179:20, :187:18
      b2_cfi_type <= brinfos_0_cfi_type;	// core.scala:179:20, :187:18
      b2_pc_sel <= brinfos_0_pc_sel;	// core.scala:179:20, :187:18
      b2_target_offset <= brinfos_0_target_offset;	// core.scala:179:20, :187:18
    end
    b2_uop_br_mask <=
      (use_this_mispredict_2
         ? brinfos_2_uop_br_mask
         : use_this_mispredict_1 ? brinfos_1_uop_br_mask : brinfos_0_uop_br_mask)
      & ~b1_resolve_mask;	// core.scala:179:20, :187:18, :196:72, :203:47, :207:28, util.scala:85:{25,27}
    b2_mispredict <= _GEN_2 | _use_this_mispredict_T_17;	// core.scala:187:18, :197:51, :206:37
    b2_jalr_target <= b2_jalr_target_REG;	// core.scala:187:18, :215:28
    b2_jalr_target_REG <= _jmp_unit_io_brinfo_jalr_target;	// core.scala:215:28, execution-units.scala:119:32
    io_ifu_flush_icache_REG <=
      dec_valids_0 & _decode_units_0_io_deq_uop_is_jalr & _csr_io_status_debug;	// core.scala:98:79, :268:19, :383:{13,51}, :502:97
    io_ifu_flush_icache_REG_1 <=
      dec_valids_1 & _decode_units_1_io_deq_uop_is_jalr & _csr_io_status_debug;	// core.scala:98:79, :268:19, :383:{13,51}, :502:97
    io_ifu_flush_icache_REG_2 <=
      dec_valids_2 & _decode_units_2_io_deq_uop_is_jalr & _csr_io_status_debug;	// core.scala:98:79, :268:19, :383:{13,51}, :502:97
    REG <= _rob_io_flush_valid;	// core.scala:140:32, :395:16
    flush_typ <= _rob_io_flush_bits_flush_typ;	// core.scala:140:32, :398:28
    io_ifu_redirect_pc_REG <= _csr_io_evec;	// core.scala:268:19, :406:49
    io_ifu_redirect_pc_REG_1 <= io_ifu_redirect_pc_REG;	// core.scala:406:{41,49}
    flush_pc_REG <= _rob_io_flush_bits_pc_lob;	// core.scala:140:32, :410:32
    flush_pc_REG_1 <= _rob_io_flush_bits_edge_inst;	// core.scala:140:32, :411:36
    flush_pc_next_REG <= _rob_io_flush_bits_is_rvc;	// core.scala:140:32, :412:49
    io_ifu_redirect_ftq_idx_REG <= _rob_io_flush_bits_ftq_idx;	// core.scala:140:32, :417:39
    REG_1 <= _rob_io_flush_valid;	// core.scala:140:32, :418:50
    io_ifu_sfence_REG_valid <= _mem_units_0_io_lsu_io_req_bits_sfence_valid;	// core.scala:470:31, execution-units.scala:108:30
    io_ifu_sfence_REG_bits_rs1 <= _mem_units_0_io_lsu_io_req_bits_sfence_bits_rs1;	// core.scala:470:31, execution-units.scala:108:30
    io_ifu_sfence_REG_bits_rs2 <= _mem_units_0_io_lsu_io_req_bits_sfence_bits_rs2;	// core.scala:470:31, execution-units.scala:108:30
    io_ifu_sfence_REG_bits_addr <= _mem_units_0_io_lsu_io_req_bits_sfence_bits_addr;	// core.scala:470:31, execution-units.scala:108:30
    jmp_pc_req_valid_REG <=
      _int_issue_unit_io_iss_valids_0 & _int_issue_unit_io_iss_uops_0_fu_code == 10'h2;	// core.scala:107:32, :533:{30,56,90}
    jmp_pc_req_bits_REG <= _int_issue_unit_io_iss_uops_0_ftq_idx;	// core.scala:107:32, :534:30
    dec_brmask_logic_io_flush_pipeline_REG <= _rob_io_flush_valid;	// core.scala:140:32, :591:48
    REG_3 <=
      (dis_fire_0 | dis_fire_1 | dis_fire_2)
      & _GEN_24[dis_fire_0 ? 2'h0 : dis_fire_1 ? 2'h1 : 2'h2];	// Mux.scala:47:69, core.scala:291:41, :426:52, :648:52, :708:62, :732:{16,34,39}
    io_ifu_commit_bits_REG <=
      _GEN_25[_rename_stage_io_ren2_mask_0
                ? 2'h0
                : _rename_stage_io_ren2_mask_1 ? 2'h1 : 2'h2];	// Mux.scala:47:69, core.scala:100:32, :291:41, :426:52, :648:52, :734:35
    pause_mem_REG <= loads_saturating;	// core.scala:902:57, :906:26
    REG_4 <=
      {5'h1F,
       ~(_int_issue_unit_io_iss_valids_0 & _int_issue_unit_io_iss_uops_0_fu_code[4]),
       4'hF};	// core.scala:107:32, :906:73, :918:47, :919:{38,39,43}, micro-op.scala:154:40
    REG_5 <=
      {5'h1F,
       ~(_int_issue_unit_io_iss_valids_2 & _int_issue_unit_io_iss_uops_2_fu_code[4]),
       4'hF};	// core.scala:107:32, :906:73, :918:47, :919:{38,39,43}, micro-op.scala:154:40
    mem_issue_unit_io_flush_pipeline_REG <= _rob_io_flush_valid;	// core.scala:140:32, :940:49
    int_issue_unit_io_flush_pipeline_REG <= _rob_io_flush_valid;	// core.scala:140:32, :940:49
    iregister_read_io_kill_REG <= _rob_io_flush_valid;	// core.scala:140:32, :981:38
    csr_io_retire_REG <=
      {1'h0, _rob_io_commit_arch_valids_0} + {1'h0, _rob_io_commit_arch_valids_1}
      + {1'h0, _rob_io_commit_arch_valids_2};	// Bitwise.scala:47:55, core.scala:77:37, :98:79, :100:32, :101:46, :102:33, :105:32, :107:32, :111:32, :119:32, :129:32, :132:32, :140:32, :155:24, :171:24, :172:27, :268:19, :683:73, :1004:30, execution-units.scala:108:30, :119:32
    csr_io_exception_REG <= _rob_io_com_xcpt_valid;	// core.scala:140:32, :1005:30
    csr_io_pc_REG <= _rob_io_com_xcpt_bits_pc_lob;	// core.scala:140:32, :1009:31
    csr_io_pc_REG_1 <= _rob_io_com_xcpt_bits_edge_inst;	// core.scala:140:32, :1010:35
    csr_io_cause_REG <= _rob_io_com_xcpt_bits_cause;	// core.scala:140:32, :1012:30
    csr_io_tval_REG <=
      {_rob_io_com_xcpt_bits_badvaddr[63:39] == 25'h0
       | (&(_rob_io_com_xcpt_bits_badvaddr[63:39]))
         ? _rob_io_com_xcpt_bits_badvaddr[39]
         : ~(_rob_io_com_xcpt_bits_badvaddr[38]),
       _rob_io_com_xcpt_bits_badvaddr[38:0]};	// Cat.scala:30:58, core.scala:140:32, :1029:12, :1038:25, :1039:{20,23,31,36,48,61,64}, :1040:18
    io_lsu_exception_REG <= _rob_io_flush_valid;	// core.scala:140:32, :1109:30
    REG_6 <= _rob_io_flush_valid;	// core.scala:140:32, :1291:45
    alu_exe_unit_io_req_bits_kill_REG <= _rob_io_flush_valid;	// core.scala:140:32, :1295:45
    alu_exe_unit_io_req_bits_kill_REG_1 <= _rob_io_flush_valid;	// core.scala:140:32, :1295:45
    alu_exe_unit_io_req_bits_kill_REG_2 <= _rob_io_flush_valid;	// core.scala:140:32, :1295:45
    if (reset) begin
      dec_finished_mask <= 3'h0;	// core.scala:490:34
      saturating_loads_counter <= 5'h0;	// core.scala:400:44, :903:41
      value_lo <= 5'h0;	// Counters.scala:45:37, core.scala:400:44
      value_hi <= 27'h0;	// Counters.scala:50:27
    end
    else begin
      if (dec_ready | _io_ifu_redirect_flush_output)	// core.scala:395:38, :397:27, :418:72, :429:29, :454:78, :576:58, :581:19
        dec_finished_mask <= 3'h0;	// core.scala:490:34
      else	// core.scala:581:19
        dec_finished_mask <= {dec_ready, dec_fire_1, dec_fire_0} | dec_finished_mask;	// core.scala:490:34, :576:58, :584:{35,42}
      if (loads_saturating)	// core.scala:902:57
        saturating_loads_counter <= saturating_loads_counter + 5'h1;	// core.scala:903:41, :904:82, util.scala:203:14
      else	// core.scala:902:57
        saturating_loads_counter <= 5'h0;	// core.scala:400:44, :903:41
      if ((|{_rob_io_commit_valids_2, _rob_io_commit_valids_1, _rob_io_commit_valids_0})
          | _csr_io_csr_stall | reset) begin	// core.scala:140:32, :268:19, :1309:{30,37}, :1311:22
        value_lo <= 5'h0;	// Counters.scala:45:37, core.scala:400:44
        value_hi <= 27'h0;	// Counters.scala:50:27
      end
      else begin	// core.scala:1311:22
        automatic logic [5:0] nextSmall;	// Counters.scala:46:33
        nextSmall = {1'h0, value_lo} + 6'h1;	// Counters.scala:45:37, :46:33, core.scala:77:37, :98:79, :100:32, :101:46, :102:33, :105:32, :107:32, :111:32, :119:32, :129:32, :132:32, :140:32, :155:24, :171:24, :172:27, :268:19, :683:73, execution-units.scala:108:30, :119:32, util.scala:203:14
        value_lo <= nextSmall[4:0];	// Counters.scala:45:37, :46:33, :47:27
        if (nextSmall[5])	// Counters.scala:46:33, :51:20
          value_hi <= value_hi + 27'h1;	// Counters.scala:50:27, :51:55
      end
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:99];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [6:0] i = 7'h0; i < 7'h64; i += 7'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        brinfos_0_uop_is_rvc = _RANDOM[7'h2][7];	// core.scala:179:20
        brinfos_0_uop_br_mask = {_RANDOM[7'h4][31:28], _RANDOM[7'h5][11:0]};	// core.scala:179:20
        brinfos_0_uop_br_tag = _RANDOM[7'h5][15:12];	// core.scala:179:20
        brinfos_0_uop_ftq_idx = _RANDOM[7'h5][20:16];	// core.scala:179:20
        brinfos_0_uop_edge_inst = _RANDOM[7'h5][21];	// core.scala:179:20
        brinfos_0_uop_pc_lob = _RANDOM[7'h5][27:22];	// core.scala:179:20
        brinfos_0_uop_rob_idx = {_RANDOM[7'h6][31:29], _RANDOM[7'h7][3:0]};	// core.scala:179:20
        brinfos_0_uop_ldq_idx = _RANDOM[7'h7][8:4];	// core.scala:179:20
        brinfos_0_uop_stq_idx = _RANDOM[7'h7][13:9];	// core.scala:179:20
        brinfos_0_valid = _RANDOM[7'hC][26];	// core.scala:179:20
        brinfos_0_mispredict = _RANDOM[7'hC][27];	// core.scala:179:20
        brinfos_0_taken = _RANDOM[7'hC][28];	// core.scala:179:20
        brinfos_0_cfi_type = _RANDOM[7'hC][31:29];	// core.scala:179:20
        brinfos_0_pc_sel = _RANDOM[7'hD][1:0];	// core.scala:179:20
        brinfos_0_target_offset = _RANDOM[7'hE][30:10];	// core.scala:179:20
        brinfos_1_uop_is_rvc = _RANDOM[7'h11][6];	// core.scala:179:20
        brinfos_1_uop_br_mask = {_RANDOM[7'h13][31:27], _RANDOM[7'h14][10:0]};	// core.scala:179:20
        brinfos_1_uop_br_tag = _RANDOM[7'h14][14:11];	// core.scala:179:20
        brinfos_1_uop_ftq_idx = _RANDOM[7'h14][19:15];	// core.scala:179:20
        brinfos_1_uop_edge_inst = _RANDOM[7'h14][20];	// core.scala:179:20
        brinfos_1_uop_pc_lob = _RANDOM[7'h14][26:21];	// core.scala:179:20
        brinfos_1_uop_rob_idx = {_RANDOM[7'h15][31:28], _RANDOM[7'h16][2:0]};	// core.scala:179:20
        brinfos_1_uop_ldq_idx = _RANDOM[7'h16][7:3];	// core.scala:179:20
        brinfos_1_uop_stq_idx = _RANDOM[7'h16][12:8];	// core.scala:179:20
        brinfos_1_valid = _RANDOM[7'h1B][25];	// core.scala:179:20
        brinfos_1_mispredict = _RANDOM[7'h1B][26];	// core.scala:179:20
        brinfos_1_taken = _RANDOM[7'h1B][27];	// core.scala:179:20
        brinfos_1_cfi_type = _RANDOM[7'h1B][30:28];	// core.scala:179:20
        brinfos_1_pc_sel = {_RANDOM[7'h1B][31], _RANDOM[7'h1C][0]};	// core.scala:179:20
        brinfos_1_target_offset = _RANDOM[7'h1D][29:9];	// core.scala:179:20
        brinfos_2_uop_is_rvc = _RANDOM[7'h20][5];	// core.scala:179:20
        brinfos_2_uop_br_mask = {_RANDOM[7'h22][31:26], _RANDOM[7'h23][9:0]};	// core.scala:179:20
        brinfos_2_uop_br_tag = _RANDOM[7'h23][13:10];	// core.scala:179:20
        brinfos_2_uop_ftq_idx = _RANDOM[7'h23][18:14];	// core.scala:179:20
        brinfos_2_uop_edge_inst = _RANDOM[7'h23][19];	// core.scala:179:20
        brinfos_2_uop_pc_lob = _RANDOM[7'h23][25:20];	// core.scala:179:20
        brinfos_2_uop_rob_idx = {_RANDOM[7'h24][31:27], _RANDOM[7'h25][1:0]};	// core.scala:179:20
        brinfos_2_uop_ldq_idx = _RANDOM[7'h25][6:2];	// core.scala:179:20
        brinfos_2_uop_stq_idx = _RANDOM[7'h25][11:7];	// core.scala:179:20
        brinfos_2_valid = _RANDOM[7'h2A][24];	// core.scala:179:20
        brinfos_2_mispredict = _RANDOM[7'h2A][25];	// core.scala:179:20
        brinfos_2_taken = _RANDOM[7'h2A][26];	// core.scala:179:20
        brinfos_2_cfi_type = _RANDOM[7'h2A][29:27];	// core.scala:179:20
        brinfos_2_pc_sel = _RANDOM[7'h2A][31:30];	// core.scala:179:20
        brinfos_2_target_offset = _RANDOM[7'h2C][28:8];	// core.scala:179:20
        b2_uop_is_rvc = _RANDOM[7'h2F][4];	// core.scala:187:18
        b2_uop_br_mask = {_RANDOM[7'h31][31:25], _RANDOM[7'h32][8:0]};	// core.scala:187:18
        b2_uop_br_tag = _RANDOM[7'h32][12:9];	// core.scala:187:18
        b2_uop_ftq_idx = _RANDOM[7'h32][17:13];	// core.scala:187:18
        b2_uop_edge_inst = _RANDOM[7'h32][18];	// core.scala:187:18
        b2_uop_pc_lob = _RANDOM[7'h32][24:19];	// core.scala:187:18
        b2_uop_rob_idx = {_RANDOM[7'h33][31:26], _RANDOM[7'h34][0]};	// core.scala:187:18
        b2_uop_ldq_idx = _RANDOM[7'h34][5:1];	// core.scala:187:18
        b2_uop_stq_idx = _RANDOM[7'h34][10:6];	// core.scala:187:18
        b2_mispredict = _RANDOM[7'h39][24];	// core.scala:187:18
        b2_taken = _RANDOM[7'h39][25];	// core.scala:187:18
        b2_cfi_type = _RANDOM[7'h39][28:26];	// core.scala:187:18
        b2_pc_sel = _RANDOM[7'h39][30:29];	// core.scala:187:18
        b2_jalr_target = {_RANDOM[7'h39][31], _RANDOM[7'h3A], _RANDOM[7'h3B][6:0]};	// core.scala:187:18
        b2_target_offset = _RANDOM[7'h3B][27:7];	// core.scala:187:18
        b2_jalr_target_REG = {_RANDOM[7'h3B][31:28], _RANDOM[7'h3C], _RANDOM[7'h3D][3:0]};	// core.scala:187:18, :215:28
        io_ifu_flush_icache_REG = _RANDOM[7'h59][4];	// core.scala:383:13
        io_ifu_flush_icache_REG_1 = _RANDOM[7'h59][5];	// core.scala:383:13
        io_ifu_flush_icache_REG_2 = _RANDOM[7'h59][6];	// core.scala:383:13
        REG = _RANDOM[7'h59][7];	// core.scala:383:13, :395:16
        flush_typ = _RANDOM[7'h59][10:8];	// core.scala:383:13, :398:28
        io_ifu_redirect_pc_REG = {_RANDOM[7'h59][31:11], _RANDOM[7'h5A][18:0]};	// core.scala:383:13, :406:49
        io_ifu_redirect_pc_REG_1 = {_RANDOM[7'h5A][31:19], _RANDOM[7'h5B][26:0]};	// core.scala:406:{41,49}
        flush_pc_REG = {_RANDOM[7'h5B][31:27], _RANDOM[7'h5C][0]};	// core.scala:406:41, :410:32
        flush_pc_REG_1 = _RANDOM[7'h5C][1];	// core.scala:410:32, :411:36
        flush_pc_next_REG = _RANDOM[7'h5C][2];	// core.scala:410:32, :412:49
        io_ifu_redirect_ftq_idx_REG = _RANDOM[7'h5C][7:3];	// core.scala:410:32, :417:39
        REG_1 = _RANDOM[7'h5C][8];	// core.scala:410:32, :418:50
        io_ifu_sfence_REG_valid = _RANDOM[7'h5C][10];	// core.scala:410:32, :470:31
        io_ifu_sfence_REG_bits_rs1 = _RANDOM[7'h5C][11];	// core.scala:410:32, :470:31
        io_ifu_sfence_REG_bits_rs2 = _RANDOM[7'h5C][12];	// core.scala:410:32, :470:31
        io_ifu_sfence_REG_bits_addr = {_RANDOM[7'h5C][31:13], _RANDOM[7'h5D][19:0]};	// core.scala:410:32, :470:31
        dec_finished_mask = _RANDOM[7'h5D][23:21];	// core.scala:470:31, :490:34
        jmp_pc_req_valid_REG = _RANDOM[7'h5D][24];	// core.scala:470:31, :533:30
        jmp_pc_req_bits_REG = _RANDOM[7'h5D][29:25];	// core.scala:470:31, :534:30
        dec_brmask_logic_io_flush_pipeline_REG = _RANDOM[7'h5D][30];	// core.scala:470:31, :591:48
        REG_3 = _RANDOM[7'h5D][31];	// core.scala:470:31, :732:16
        io_ifu_commit_bits_REG = _RANDOM[7'h5E][4:0];	// core.scala:734:35
        saturating_loads_counter = _RANDOM[7'h5E][9:5];	// core.scala:734:35, :903:41
        pause_mem_REG = _RANDOM[7'h5E][10];	// core.scala:734:35, :906:26
        REG_4 = _RANDOM[7'h5E][20:11];	// core.scala:734:35, :919:38
        REG_5 = _RANDOM[7'h5E][30:21];	// core.scala:734:35, :919:38
        mem_issue_unit_io_flush_pipeline_REG = _RANDOM[7'h5E][31];	// core.scala:734:35, :940:49
        int_issue_unit_io_flush_pipeline_REG = _RANDOM[7'h5F][0];	// core.scala:940:49
        iregister_read_io_kill_REG = _RANDOM[7'h5F][2];	// core.scala:940:49, :981:38
        csr_io_retire_REG = _RANDOM[7'h5F][4:3];	// core.scala:940:49, :1004:30
        csr_io_exception_REG = _RANDOM[7'h5F][5];	// core.scala:940:49, :1005:30
        csr_io_pc_REG = _RANDOM[7'h5F][11:6];	// core.scala:940:49, :1009:31
        csr_io_pc_REG_1 = _RANDOM[7'h5F][12];	// core.scala:940:49, :1010:35
        csr_io_cause_REG = {_RANDOM[7'h5F][31:13], _RANDOM[7'h60], _RANDOM[7'h61][12:0]};	// core.scala:940:49, :1012:30
        csr_io_tval_REG = {_RANDOM[7'h61][31:13], _RANDOM[7'h62][20:0]};	// core.scala:1012:30, :1029:12
        io_lsu_exception_REG = _RANDOM[7'h62][21];	// core.scala:1029:12, :1109:30
        REG_6 = _RANDOM[7'h62][22];	// core.scala:1029:12, :1291:45
        alu_exe_unit_io_req_bits_kill_REG = _RANDOM[7'h62][24];	// core.scala:1029:12, :1295:45
        alu_exe_unit_io_req_bits_kill_REG_1 = _RANDOM[7'h62][25];	// core.scala:1029:12, :1295:45
        alu_exe_unit_io_req_bits_kill_REG_2 = _RANDOM[7'h62][26];	// core.scala:1029:12, :1295:45
        value_lo = _RANDOM[7'h62][31:27];	// Counters.scala:45:37, core.scala:1029:12
        value_hi = _RANDOM[7'h63][26:0];	// Counters.scala:50:27
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  ALUExeUnit_6 mem_units_0 (	// execution-units.scala:108:30
    .clock                                  (clock),
    .reset                                  (reset),
    .io_req_valid                           (_iregister_read_io_exe_reqs_0_valid),	// core.scala:132:32
    .io_req_bits_uop_uopc                   (_iregister_read_io_exe_reqs_0_bits_uop_uopc),	// core.scala:132:32
    .io_req_bits_uop_inst                   (_iregister_read_io_exe_reqs_0_bits_uop_inst),	// core.scala:132:32
    .io_req_bits_uop_debug_inst
      (_iregister_read_io_exe_reqs_0_bits_uop_debug_inst),	// core.scala:132:32
    .io_req_bits_uop_is_rvc
      (_iregister_read_io_exe_reqs_0_bits_uop_is_rvc),	// core.scala:132:32
    .io_req_bits_uop_debug_pc
      (_iregister_read_io_exe_reqs_0_bits_uop_debug_pc),	// core.scala:132:32
    .io_req_bits_uop_iq_type
      (_iregister_read_io_exe_reqs_0_bits_uop_iq_type),	// core.scala:132:32
    .io_req_bits_uop_fu_code
      (_iregister_read_io_exe_reqs_0_bits_uop_fu_code),	// core.scala:132:32
    .io_req_bits_uop_ctrl_br_type
      (_iregister_read_io_exe_reqs_0_bits_uop_ctrl_br_type),	// core.scala:132:32
    .io_req_bits_uop_ctrl_op1_sel
      (_iregister_read_io_exe_reqs_0_bits_uop_ctrl_op1_sel),	// core.scala:132:32
    .io_req_bits_uop_ctrl_op2_sel
      (_iregister_read_io_exe_reqs_0_bits_uop_ctrl_op2_sel),	// core.scala:132:32
    .io_req_bits_uop_ctrl_imm_sel
      (_iregister_read_io_exe_reqs_0_bits_uop_ctrl_imm_sel),	// core.scala:132:32
    .io_req_bits_uop_ctrl_op_fcn
      (_iregister_read_io_exe_reqs_0_bits_uop_ctrl_op_fcn),	// core.scala:132:32
    .io_req_bits_uop_ctrl_fcn_dw
      (_iregister_read_io_exe_reqs_0_bits_uop_ctrl_fcn_dw),	// core.scala:132:32
    .io_req_bits_uop_ctrl_csr_cmd           (3'h0),	// core.scala:490:34
    .io_req_bits_uop_ctrl_is_load
      (_iregister_read_io_exe_reqs_0_bits_uop_ctrl_is_load),	// core.scala:132:32
    .io_req_bits_uop_ctrl_is_sta
      (_iregister_read_io_exe_reqs_0_bits_uop_ctrl_is_sta),	// core.scala:132:32
    .io_req_bits_uop_ctrl_is_std
      (_iregister_read_io_exe_reqs_0_bits_uop_ctrl_is_std),	// core.scala:132:32
    .io_req_bits_uop_iw_state
      (_iregister_read_io_exe_reqs_0_bits_uop_iw_state),	// core.scala:132:32
    .io_req_bits_uop_iw_p1_poisoned         (1'h0),	// core.scala:77:37, :98:79, :100:32, :101:46, :102:33, :105:32, :107:32, :111:32, :119:32, :129:32, :132:32, :140:32, :155:24, :171:24, :172:27, :268:19, :683:73, execution-units.scala:108:30, :119:32
    .io_req_bits_uop_iw_p2_poisoned         (1'h0),	// core.scala:77:37, :98:79, :100:32, :101:46, :102:33, :105:32, :107:32, :111:32, :119:32, :129:32, :132:32, :140:32, :155:24, :171:24, :172:27, :268:19, :683:73, execution-units.scala:108:30, :119:32
    .io_req_bits_uop_is_br
      (_iregister_read_io_exe_reqs_0_bits_uop_is_br),	// core.scala:132:32
    .io_req_bits_uop_is_jalr
      (_iregister_read_io_exe_reqs_0_bits_uop_is_jalr),	// core.scala:132:32
    .io_req_bits_uop_is_jal
      (_iregister_read_io_exe_reqs_0_bits_uop_is_jal),	// core.scala:132:32
    .io_req_bits_uop_is_sfb
      (_iregister_read_io_exe_reqs_0_bits_uop_is_sfb),	// core.scala:132:32
    .io_req_bits_uop_br_mask
      (_iregister_read_io_exe_reqs_0_bits_uop_br_mask),	// core.scala:132:32
    .io_req_bits_uop_br_tag
      (_iregister_read_io_exe_reqs_0_bits_uop_br_tag),	// core.scala:132:32
    .io_req_bits_uop_ftq_idx
      (_iregister_read_io_exe_reqs_0_bits_uop_ftq_idx),	// core.scala:132:32
    .io_req_bits_uop_edge_inst
      (_iregister_read_io_exe_reqs_0_bits_uop_edge_inst),	// core.scala:132:32
    .io_req_bits_uop_pc_lob
      (_iregister_read_io_exe_reqs_0_bits_uop_pc_lob),	// core.scala:132:32
    .io_req_bits_uop_taken
      (_iregister_read_io_exe_reqs_0_bits_uop_taken),	// core.scala:132:32
    .io_req_bits_uop_imm_packed
      (_iregister_read_io_exe_reqs_0_bits_uop_imm_packed),	// core.scala:132:32
    .io_req_bits_uop_csr_addr
      (_iregister_read_io_exe_reqs_0_bits_uop_csr_addr),	// core.scala:132:32
    .io_req_bits_uop_rob_idx
      (_iregister_read_io_exe_reqs_0_bits_uop_rob_idx),	// core.scala:132:32
    .io_req_bits_uop_ldq_idx
      (_iregister_read_io_exe_reqs_0_bits_uop_ldq_idx),	// core.scala:132:32
    .io_req_bits_uop_stq_idx
      (_iregister_read_io_exe_reqs_0_bits_uop_stq_idx),	// core.scala:132:32
    .io_req_bits_uop_rxq_idx
      (_iregister_read_io_exe_reqs_0_bits_uop_rxq_idx),	// core.scala:132:32
    .io_req_bits_uop_pdst                   (_iregister_read_io_exe_reqs_0_bits_uop_pdst),	// core.scala:132:32
    .io_req_bits_uop_prs1                   (_iregister_read_io_exe_reqs_0_bits_uop_prs1),	// core.scala:132:32
    .io_req_bits_uop_prs2                   (_iregister_read_io_exe_reqs_0_bits_uop_prs2),	// core.scala:132:32
    .io_req_bits_uop_prs3                   (_iregister_read_io_exe_reqs_0_bits_uop_prs3),	// core.scala:132:32
    .io_req_bits_uop_ppred
      (_iregister_read_io_exe_reqs_0_bits_uop_ppred),	// core.scala:132:32
    .io_req_bits_uop_prs1_busy
      (_iregister_read_io_exe_reqs_0_bits_uop_prs1_busy),	// core.scala:132:32
    .io_req_bits_uop_prs2_busy
      (_iregister_read_io_exe_reqs_0_bits_uop_prs2_busy),	// core.scala:132:32
    .io_req_bits_uop_prs3_busy
      (_iregister_read_io_exe_reqs_0_bits_uop_prs3_busy),	// core.scala:132:32
    .io_req_bits_uop_ppred_busy
      (_iregister_read_io_exe_reqs_0_bits_uop_ppred_busy),	// core.scala:132:32
    .io_req_bits_uop_stale_pdst
      (_iregister_read_io_exe_reqs_0_bits_uop_stale_pdst),	// core.scala:132:32
    .io_req_bits_uop_exception
      (_iregister_read_io_exe_reqs_0_bits_uop_exception),	// core.scala:132:32
    .io_req_bits_uop_exc_cause
      (_iregister_read_io_exe_reqs_0_bits_uop_exc_cause),	// core.scala:132:32
    .io_req_bits_uop_bypassable
      (_iregister_read_io_exe_reqs_0_bits_uop_bypassable),	// core.scala:132:32
    .io_req_bits_uop_mem_cmd
      (_iregister_read_io_exe_reqs_0_bits_uop_mem_cmd),	// core.scala:132:32
    .io_req_bits_uop_mem_size
      (_iregister_read_io_exe_reqs_0_bits_uop_mem_size),	// core.scala:132:32
    .io_req_bits_uop_mem_signed
      (_iregister_read_io_exe_reqs_0_bits_uop_mem_signed),	// core.scala:132:32
    .io_req_bits_uop_is_fence
      (_iregister_read_io_exe_reqs_0_bits_uop_is_fence),	// core.scala:132:32
    .io_req_bits_uop_is_fencei
      (_iregister_read_io_exe_reqs_0_bits_uop_is_fencei),	// core.scala:132:32
    .io_req_bits_uop_is_amo
      (_iregister_read_io_exe_reqs_0_bits_uop_is_amo),	// core.scala:132:32
    .io_req_bits_uop_uses_ldq
      (_iregister_read_io_exe_reqs_0_bits_uop_uses_ldq),	// core.scala:132:32
    .io_req_bits_uop_uses_stq
      (_iregister_read_io_exe_reqs_0_bits_uop_uses_stq),	// core.scala:132:32
    .io_req_bits_uop_is_sys_pc2epc
      (_iregister_read_io_exe_reqs_0_bits_uop_is_sys_pc2epc),	// core.scala:132:32
    .io_req_bits_uop_is_unique
      (_iregister_read_io_exe_reqs_0_bits_uop_is_unique),	// core.scala:132:32
    .io_req_bits_uop_flush_on_commit
      (_iregister_read_io_exe_reqs_0_bits_uop_flush_on_commit),	// core.scala:132:32
    .io_req_bits_uop_ldst_is_rs1
      (_iregister_read_io_exe_reqs_0_bits_uop_ldst_is_rs1),	// core.scala:132:32
    .io_req_bits_uop_ldst                   (_iregister_read_io_exe_reqs_0_bits_uop_ldst),	// core.scala:132:32
    .io_req_bits_uop_lrs1                   (_iregister_read_io_exe_reqs_0_bits_uop_lrs1),	// core.scala:132:32
    .io_req_bits_uop_lrs2                   (_iregister_read_io_exe_reqs_0_bits_uop_lrs2),	// core.scala:132:32
    .io_req_bits_uop_lrs3                   (_iregister_read_io_exe_reqs_0_bits_uop_lrs3),	// core.scala:132:32
    .io_req_bits_uop_ldst_val
      (_iregister_read_io_exe_reqs_0_bits_uop_ldst_val),	// core.scala:132:32
    .io_req_bits_uop_dst_rtype
      (_iregister_read_io_exe_reqs_0_bits_uop_dst_rtype),	// core.scala:132:32
    .io_req_bits_uop_lrs1_rtype
      (_iregister_read_io_exe_reqs_0_bits_uop_lrs1_rtype),	// core.scala:132:32
    .io_req_bits_uop_lrs2_rtype
      (_iregister_read_io_exe_reqs_0_bits_uop_lrs2_rtype),	// core.scala:132:32
    .io_req_bits_uop_frs3_en
      (_iregister_read_io_exe_reqs_0_bits_uop_frs3_en),	// core.scala:132:32
    .io_req_bits_uop_fp_val
      (_iregister_read_io_exe_reqs_0_bits_uop_fp_val),	// core.scala:132:32
    .io_req_bits_uop_fp_single
      (_iregister_read_io_exe_reqs_0_bits_uop_fp_single),	// core.scala:132:32
    .io_req_bits_uop_xcpt_pf_if
      (_iregister_read_io_exe_reqs_0_bits_uop_xcpt_pf_if),	// core.scala:132:32
    .io_req_bits_uop_xcpt_ae_if
      (_iregister_read_io_exe_reqs_0_bits_uop_xcpt_ae_if),	// core.scala:132:32
    .io_req_bits_uop_xcpt_ma_if
      (_iregister_read_io_exe_reqs_0_bits_uop_xcpt_ma_if),	// core.scala:132:32
    .io_req_bits_uop_bp_debug_if
      (_iregister_read_io_exe_reqs_0_bits_uop_bp_debug_if),	// core.scala:132:32
    .io_req_bits_uop_bp_xcpt_if
      (_iregister_read_io_exe_reqs_0_bits_uop_bp_xcpt_if),	// core.scala:132:32
    .io_req_bits_uop_debug_fsrc
      (_iregister_read_io_exe_reqs_0_bits_uop_debug_fsrc),	// core.scala:132:32
    .io_req_bits_uop_debug_tsrc
      (_iregister_read_io_exe_reqs_0_bits_uop_debug_tsrc),	// core.scala:132:32
    .io_req_bits_rs1_data
      ({1'h0, _iregister_read_io_exe_reqs_0_bits_rs1_data}),	// core.scala:77:37, :98:79, :100:32, :101:46, :102:33, :105:32, :107:32, :111:32, :119:32, :129:32, :132:32, :140:32, :155:24, :171:24, :172:27, :268:19, :683:73, :1074:23, execution-units.scala:108:30, :119:32
    .io_req_bits_rs2_data
      ({1'h0, _iregister_read_io_exe_reqs_0_bits_rs2_data}),	// core.scala:77:37, :98:79, :100:32, :101:46, :102:33, :105:32, :107:32, :111:32, :119:32, :129:32, :132:32, :140:32, :155:24, :171:24, :172:27, :268:19, :683:73, :1074:23, execution-units.scala:108:30, :119:32
    .io_brupdate_b1_resolve_mask            (b1_resolve_mask),	// core.scala:196:72
    .io_brupdate_b1_mispredict_mask         (b1_mispredict_mask),	// core.scala:197:93
    .io_lsu_io_iresp_valid                  (io_lsu_exe_0_iresp_valid),
    .io_lsu_io_iresp_bits_uop_rob_idx       (io_lsu_exe_0_iresp_bits_uop_rob_idx),
    .io_lsu_io_iresp_bits_uop_pdst          (io_lsu_exe_0_iresp_bits_uop_pdst),
    .io_lsu_io_iresp_bits_uop_is_amo        (io_lsu_exe_0_iresp_bits_uop_is_amo),
    .io_lsu_io_iresp_bits_uop_uses_stq      (io_lsu_exe_0_iresp_bits_uop_uses_stq),
    .io_lsu_io_iresp_bits_uop_dst_rtype     (io_lsu_exe_0_iresp_bits_uop_dst_rtype),
    .io_lsu_io_iresp_bits_data              (io_lsu_exe_0_iresp_bits_data),
    .io_lsu_io_fresp_valid                  (io_lsu_exe_0_fresp_valid),
    .io_lsu_io_fresp_bits_uop_uopc          (io_lsu_exe_0_fresp_bits_uop_uopc),
    .io_lsu_io_fresp_bits_uop_br_mask       (io_lsu_exe_0_fresp_bits_uop_br_mask),
    .io_lsu_io_fresp_bits_uop_rob_idx       (io_lsu_exe_0_fresp_bits_uop_rob_idx),
    .io_lsu_io_fresp_bits_uop_stq_idx       (io_lsu_exe_0_fresp_bits_uop_stq_idx),
    .io_lsu_io_fresp_bits_uop_pdst          (io_lsu_exe_0_fresp_bits_uop_pdst),
    .io_lsu_io_fresp_bits_uop_mem_size      (io_lsu_exe_0_fresp_bits_uop_mem_size),
    .io_lsu_io_fresp_bits_uop_is_amo        (io_lsu_exe_0_fresp_bits_uop_is_amo),
    .io_lsu_io_fresp_bits_uop_uses_stq      (io_lsu_exe_0_fresp_bits_uop_uses_stq),
    .io_lsu_io_fresp_bits_uop_dst_rtype     (io_lsu_exe_0_fresp_bits_uop_dst_rtype),
    .io_lsu_io_fresp_bits_uop_fp_val        (io_lsu_exe_0_fresp_bits_uop_fp_val),
    .io_lsu_io_fresp_bits_data              (io_lsu_exe_0_fresp_bits_data),
    .io_ll_iresp_valid                      (_mem_units_0_io_ll_iresp_valid),
    .io_ll_iresp_bits_uop_rob_idx           (_mem_units_0_io_ll_iresp_bits_uop_rob_idx),
    .io_ll_iresp_bits_uop_pdst              (_mem_units_0_io_ll_iresp_bits_uop_pdst),
    .io_ll_iresp_bits_uop_is_amo            (_mem_units_0_io_ll_iresp_bits_uop_is_amo),
    .io_ll_iresp_bits_uop_uses_stq          (_mem_units_0_io_ll_iresp_bits_uop_uses_stq),
    .io_ll_iresp_bits_uop_dst_rtype         (_mem_units_0_io_ll_iresp_bits_uop_dst_rtype),
    .io_ll_iresp_bits_data                  (_mem_units_0_io_ll_iresp_bits_data),
    .io_ll_fresp_valid                      (_mem_units_0_io_ll_fresp_valid),
    .io_ll_fresp_bits_uop_uopc              (_mem_units_0_io_ll_fresp_bits_uop_uopc),
    .io_ll_fresp_bits_uop_br_mask           (_mem_units_0_io_ll_fresp_bits_uop_br_mask),
    .io_ll_fresp_bits_uop_rob_idx           (_mem_units_0_io_ll_fresp_bits_uop_rob_idx),
    .io_ll_fresp_bits_uop_stq_idx           (_mem_units_0_io_ll_fresp_bits_uop_stq_idx),
    .io_ll_fresp_bits_uop_pdst              (_mem_units_0_io_ll_fresp_bits_uop_pdst),
    .io_ll_fresp_bits_uop_mem_size          (_mem_units_0_io_ll_fresp_bits_uop_mem_size),
    .io_ll_fresp_bits_uop_is_amo            (_mem_units_0_io_ll_fresp_bits_uop_is_amo),
    .io_ll_fresp_bits_uop_uses_stq          (_mem_units_0_io_ll_fresp_bits_uop_uses_stq),
    .io_ll_fresp_bits_uop_dst_rtype         (_mem_units_0_io_ll_fresp_bits_uop_dst_rtype),
    .io_ll_fresp_bits_uop_fp_val            (_mem_units_0_io_ll_fresp_bits_uop_fp_val),
    .io_ll_fresp_bits_data                  (_mem_units_0_io_ll_fresp_bits_data),
    .io_lsu_io_req_valid                    (io_lsu_exe_0_req_valid),
    .io_lsu_io_req_bits_uop_uopc            (io_lsu_exe_0_req_bits_uop_uopc),
    .io_lsu_io_req_bits_uop_inst            (io_lsu_exe_0_req_bits_uop_inst),
    .io_lsu_io_req_bits_uop_debug_inst      (io_lsu_exe_0_req_bits_uop_debug_inst),
    .io_lsu_io_req_bits_uop_is_rvc          (io_lsu_exe_0_req_bits_uop_is_rvc),
    .io_lsu_io_req_bits_uop_debug_pc        (io_lsu_exe_0_req_bits_uop_debug_pc),
    .io_lsu_io_req_bits_uop_iq_type         (io_lsu_exe_0_req_bits_uop_iq_type),
    .io_lsu_io_req_bits_uop_fu_code         (io_lsu_exe_0_req_bits_uop_fu_code),
    .io_lsu_io_req_bits_uop_ctrl_br_type    (io_lsu_exe_0_req_bits_uop_ctrl_br_type),
    .io_lsu_io_req_bits_uop_ctrl_op1_sel    (io_lsu_exe_0_req_bits_uop_ctrl_op1_sel),
    .io_lsu_io_req_bits_uop_ctrl_op2_sel    (io_lsu_exe_0_req_bits_uop_ctrl_op2_sel),
    .io_lsu_io_req_bits_uop_ctrl_imm_sel    (io_lsu_exe_0_req_bits_uop_ctrl_imm_sel),
    .io_lsu_io_req_bits_uop_ctrl_op_fcn     (io_lsu_exe_0_req_bits_uop_ctrl_op_fcn),
    .io_lsu_io_req_bits_uop_ctrl_fcn_dw     (io_lsu_exe_0_req_bits_uop_ctrl_fcn_dw),
    .io_lsu_io_req_bits_uop_ctrl_csr_cmd    (io_lsu_exe_0_req_bits_uop_ctrl_csr_cmd),
    .io_lsu_io_req_bits_uop_ctrl_is_load    (io_lsu_exe_0_req_bits_uop_ctrl_is_load),
    .io_lsu_io_req_bits_uop_ctrl_is_sta     (io_lsu_exe_0_req_bits_uop_ctrl_is_sta),
    .io_lsu_io_req_bits_uop_ctrl_is_std     (io_lsu_exe_0_req_bits_uop_ctrl_is_std),
    .io_lsu_io_req_bits_uop_iw_state        (io_lsu_exe_0_req_bits_uop_iw_state),
    .io_lsu_io_req_bits_uop_iw_p1_poisoned  (io_lsu_exe_0_req_bits_uop_iw_p1_poisoned),
    .io_lsu_io_req_bits_uop_iw_p2_poisoned  (io_lsu_exe_0_req_bits_uop_iw_p2_poisoned),
    .io_lsu_io_req_bits_uop_is_br           (io_lsu_exe_0_req_bits_uop_is_br),
    .io_lsu_io_req_bits_uop_is_jalr         (io_lsu_exe_0_req_bits_uop_is_jalr),
    .io_lsu_io_req_bits_uop_is_jal          (io_lsu_exe_0_req_bits_uop_is_jal),
    .io_lsu_io_req_bits_uop_is_sfb          (io_lsu_exe_0_req_bits_uop_is_sfb),
    .io_lsu_io_req_bits_uop_br_mask         (io_lsu_exe_0_req_bits_uop_br_mask),
    .io_lsu_io_req_bits_uop_br_tag          (io_lsu_exe_0_req_bits_uop_br_tag),
    .io_lsu_io_req_bits_uop_ftq_idx         (io_lsu_exe_0_req_bits_uop_ftq_idx),
    .io_lsu_io_req_bits_uop_edge_inst       (io_lsu_exe_0_req_bits_uop_edge_inst),
    .io_lsu_io_req_bits_uop_pc_lob          (io_lsu_exe_0_req_bits_uop_pc_lob),
    .io_lsu_io_req_bits_uop_taken           (io_lsu_exe_0_req_bits_uop_taken),
    .io_lsu_io_req_bits_uop_imm_packed      (io_lsu_exe_0_req_bits_uop_imm_packed),
    .io_lsu_io_req_bits_uop_csr_addr        (io_lsu_exe_0_req_bits_uop_csr_addr),
    .io_lsu_io_req_bits_uop_rob_idx         (io_lsu_exe_0_req_bits_uop_rob_idx),
    .io_lsu_io_req_bits_uop_ldq_idx         (io_lsu_exe_0_req_bits_uop_ldq_idx),
    .io_lsu_io_req_bits_uop_stq_idx         (io_lsu_exe_0_req_bits_uop_stq_idx),
    .io_lsu_io_req_bits_uop_rxq_idx         (io_lsu_exe_0_req_bits_uop_rxq_idx),
    .io_lsu_io_req_bits_uop_pdst            (io_lsu_exe_0_req_bits_uop_pdst),
    .io_lsu_io_req_bits_uop_prs1            (io_lsu_exe_0_req_bits_uop_prs1),
    .io_lsu_io_req_bits_uop_prs2            (io_lsu_exe_0_req_bits_uop_prs2),
    .io_lsu_io_req_bits_uop_prs3            (io_lsu_exe_0_req_bits_uop_prs3),
    .io_lsu_io_req_bits_uop_ppred           (io_lsu_exe_0_req_bits_uop_ppred),
    .io_lsu_io_req_bits_uop_prs1_busy       (io_lsu_exe_0_req_bits_uop_prs1_busy),
    .io_lsu_io_req_bits_uop_prs2_busy       (io_lsu_exe_0_req_bits_uop_prs2_busy),
    .io_lsu_io_req_bits_uop_prs3_busy       (io_lsu_exe_0_req_bits_uop_prs3_busy),
    .io_lsu_io_req_bits_uop_ppred_busy      (io_lsu_exe_0_req_bits_uop_ppred_busy),
    .io_lsu_io_req_bits_uop_stale_pdst      (io_lsu_exe_0_req_bits_uop_stale_pdst),
    .io_lsu_io_req_bits_uop_exception       (io_lsu_exe_0_req_bits_uop_exception),
    .io_lsu_io_req_bits_uop_exc_cause       (io_lsu_exe_0_req_bits_uop_exc_cause),
    .io_lsu_io_req_bits_uop_bypassable      (io_lsu_exe_0_req_bits_uop_bypassable),
    .io_lsu_io_req_bits_uop_mem_cmd         (io_lsu_exe_0_req_bits_uop_mem_cmd),
    .io_lsu_io_req_bits_uop_mem_size        (io_lsu_exe_0_req_bits_uop_mem_size),
    .io_lsu_io_req_bits_uop_mem_signed      (io_lsu_exe_0_req_bits_uop_mem_signed),
    .io_lsu_io_req_bits_uop_is_fence        (io_lsu_exe_0_req_bits_uop_is_fence),
    .io_lsu_io_req_bits_uop_is_fencei       (io_lsu_exe_0_req_bits_uop_is_fencei),
    .io_lsu_io_req_bits_uop_is_amo          (io_lsu_exe_0_req_bits_uop_is_amo),
    .io_lsu_io_req_bits_uop_uses_ldq        (io_lsu_exe_0_req_bits_uop_uses_ldq),
    .io_lsu_io_req_bits_uop_uses_stq        (io_lsu_exe_0_req_bits_uop_uses_stq),
    .io_lsu_io_req_bits_uop_is_sys_pc2epc   (io_lsu_exe_0_req_bits_uop_is_sys_pc2epc),
    .io_lsu_io_req_bits_uop_is_unique       (io_lsu_exe_0_req_bits_uop_is_unique),
    .io_lsu_io_req_bits_uop_flush_on_commit (io_lsu_exe_0_req_bits_uop_flush_on_commit),
    .io_lsu_io_req_bits_uop_ldst_is_rs1     (io_lsu_exe_0_req_bits_uop_ldst_is_rs1),
    .io_lsu_io_req_bits_uop_ldst            (io_lsu_exe_0_req_bits_uop_ldst),
    .io_lsu_io_req_bits_uop_lrs1            (io_lsu_exe_0_req_bits_uop_lrs1),
    .io_lsu_io_req_bits_uop_lrs2            (io_lsu_exe_0_req_bits_uop_lrs2),
    .io_lsu_io_req_bits_uop_lrs3            (io_lsu_exe_0_req_bits_uop_lrs3),
    .io_lsu_io_req_bits_uop_ldst_val        (io_lsu_exe_0_req_bits_uop_ldst_val),
    .io_lsu_io_req_bits_uop_dst_rtype       (io_lsu_exe_0_req_bits_uop_dst_rtype),
    .io_lsu_io_req_bits_uop_lrs1_rtype      (io_lsu_exe_0_req_bits_uop_lrs1_rtype),
    .io_lsu_io_req_bits_uop_lrs2_rtype      (io_lsu_exe_0_req_bits_uop_lrs2_rtype),
    .io_lsu_io_req_bits_uop_frs3_en         (io_lsu_exe_0_req_bits_uop_frs3_en),
    .io_lsu_io_req_bits_uop_fp_val          (io_lsu_exe_0_req_bits_uop_fp_val),
    .io_lsu_io_req_bits_uop_fp_single       (io_lsu_exe_0_req_bits_uop_fp_single),
    .io_lsu_io_req_bits_uop_xcpt_pf_if      (io_lsu_exe_0_req_bits_uop_xcpt_pf_if),
    .io_lsu_io_req_bits_uop_xcpt_ae_if      (io_lsu_exe_0_req_bits_uop_xcpt_ae_if),
    .io_lsu_io_req_bits_uop_xcpt_ma_if      (io_lsu_exe_0_req_bits_uop_xcpt_ma_if),
    .io_lsu_io_req_bits_uop_bp_debug_if     (io_lsu_exe_0_req_bits_uop_bp_debug_if),
    .io_lsu_io_req_bits_uop_bp_xcpt_if      (io_lsu_exe_0_req_bits_uop_bp_xcpt_if),
    .io_lsu_io_req_bits_uop_debug_fsrc      (io_lsu_exe_0_req_bits_uop_debug_fsrc),
    .io_lsu_io_req_bits_uop_debug_tsrc      (io_lsu_exe_0_req_bits_uop_debug_tsrc),
    .io_lsu_io_req_bits_data                (io_lsu_exe_0_req_bits_data),
    .io_lsu_io_req_bits_addr                (io_lsu_exe_0_req_bits_addr),
    .io_lsu_io_req_bits_mxcpt_valid         (io_lsu_exe_0_req_bits_mxcpt_valid),
    .io_lsu_io_req_bits_sfence_valid
      (_mem_units_0_io_lsu_io_req_bits_sfence_valid),
    .io_lsu_io_req_bits_sfence_bits_rs1
      (_mem_units_0_io_lsu_io_req_bits_sfence_bits_rs1),
    .io_lsu_io_req_bits_sfence_bits_rs2
      (_mem_units_0_io_lsu_io_req_bits_sfence_bits_rs2),
    .io_lsu_io_req_bits_sfence_bits_addr
      (_mem_units_0_io_lsu_io_req_bits_sfence_bits_addr)
  );
  ALUExeUnit_7 jmp_unit (	// execution-units.scala:119:32
    .clock                             (clock),
    .reset                             (reset),
    .io_req_valid                      (_iregister_read_io_exe_reqs_1_valid),	// core.scala:132:32
    .io_req_bits_uop_uopc              (_iregister_read_io_exe_reqs_1_bits_uop_uopc),	// core.scala:132:32
    .io_req_bits_uop_is_rvc            (_iregister_read_io_exe_reqs_1_bits_uop_is_rvc),	// core.scala:132:32
    .io_req_bits_uop_fu_code           (_iregister_read_io_exe_reqs_1_bits_uop_fu_code),	// core.scala:132:32
    .io_req_bits_uop_ctrl_br_type
      (_iregister_read_io_exe_reqs_1_bits_uop_ctrl_br_type),	// core.scala:132:32
    .io_req_bits_uop_ctrl_op1_sel
      (_iregister_read_io_exe_reqs_1_bits_uop_ctrl_op1_sel),	// core.scala:132:32
    .io_req_bits_uop_ctrl_op2_sel
      (_iregister_read_io_exe_reqs_1_bits_uop_ctrl_op2_sel),	// core.scala:132:32
    .io_req_bits_uop_ctrl_imm_sel
      (_iregister_read_io_exe_reqs_1_bits_uop_ctrl_imm_sel),	// core.scala:132:32
    .io_req_bits_uop_ctrl_op_fcn
      (_iregister_read_io_exe_reqs_1_bits_uop_ctrl_op_fcn),	// core.scala:132:32
    .io_req_bits_uop_ctrl_fcn_dw
      (_iregister_read_io_exe_reqs_1_bits_uop_ctrl_fcn_dw),	// core.scala:132:32
    .io_req_bits_uop_is_br             (_iregister_read_io_exe_reqs_1_bits_uop_is_br),	// core.scala:132:32
    .io_req_bits_uop_is_jalr           (_iregister_read_io_exe_reqs_1_bits_uop_is_jalr),	// core.scala:132:32
    .io_req_bits_uop_is_jal            (_iregister_read_io_exe_reqs_1_bits_uop_is_jal),	// core.scala:132:32
    .io_req_bits_uop_is_sfb            (_iregister_read_io_exe_reqs_1_bits_uop_is_sfb),	// core.scala:132:32
    .io_req_bits_uop_br_mask           (_iregister_read_io_exe_reqs_1_bits_uop_br_mask),	// core.scala:132:32
    .io_req_bits_uop_br_tag            (_iregister_read_io_exe_reqs_1_bits_uop_br_tag),	// core.scala:132:32
    .io_req_bits_uop_ftq_idx           (_iregister_read_io_exe_reqs_1_bits_uop_ftq_idx),	// core.scala:132:32
    .io_req_bits_uop_edge_inst         (_iregister_read_io_exe_reqs_1_bits_uop_edge_inst),	// core.scala:132:32
    .io_req_bits_uop_pc_lob            (_iregister_read_io_exe_reqs_1_bits_uop_pc_lob),	// core.scala:132:32
    .io_req_bits_uop_taken             (_iregister_read_io_exe_reqs_1_bits_uop_taken),	// core.scala:132:32
    .io_req_bits_uop_imm_packed
      (_iregister_read_io_exe_reqs_1_bits_uop_imm_packed),	// core.scala:132:32
    .io_req_bits_uop_rob_idx           (_iregister_read_io_exe_reqs_1_bits_uop_rob_idx),	// core.scala:132:32
    .io_req_bits_uop_ldq_idx           (_iregister_read_io_exe_reqs_1_bits_uop_ldq_idx),	// core.scala:132:32
    .io_req_bits_uop_stq_idx           (_iregister_read_io_exe_reqs_1_bits_uop_stq_idx),	// core.scala:132:32
    .io_req_bits_uop_pdst              (_iregister_read_io_exe_reqs_1_bits_uop_pdst),	// core.scala:132:32
    .io_req_bits_uop_prs1              (_iregister_read_io_exe_reqs_1_bits_uop_prs1),	// core.scala:132:32
    .io_req_bits_uop_bypassable
      (_iregister_read_io_exe_reqs_1_bits_uop_bypassable),	// core.scala:132:32
    .io_req_bits_uop_is_amo            (_iregister_read_io_exe_reqs_1_bits_uop_is_amo),	// core.scala:132:32
    .io_req_bits_uop_uses_stq          (_iregister_read_io_exe_reqs_1_bits_uop_uses_stq),	// core.scala:132:32
    .io_req_bits_uop_dst_rtype         (_iregister_read_io_exe_reqs_1_bits_uop_dst_rtype),	// core.scala:132:32
    .io_req_bits_rs1_data
      ({1'h0, _iregister_read_io_exe_reqs_1_bits_rs1_data}),	// core.scala:77:37, :98:79, :100:32, :101:46, :102:33, :105:32, :107:32, :111:32, :119:32, :129:32, :132:32, :140:32, :155:24, :171:24, :172:27, :268:19, :683:73, :1074:23, execution-units.scala:108:30, :119:32
    .io_req_bits_rs2_data
      ({1'h0, _iregister_read_io_exe_reqs_1_bits_rs2_data}),	// core.scala:77:37, :98:79, :100:32, :101:46, :102:33, :105:32, :107:32, :111:32, :119:32, :129:32, :132:32, :140:32, :155:24, :171:24, :172:27, :268:19, :683:73, :1074:23, execution-units.scala:108:30, :119:32
    .io_req_bits_kill                  (alu_exe_unit_io_req_bits_kill_REG),	// core.scala:1295:45
    .io_brupdate_b1_resolve_mask       (b1_resolve_mask),	// core.scala:196:72
    .io_brupdate_b1_mispredict_mask    (b1_mispredict_mask),	// core.scala:197:93
    .io_get_ftq_pc_entry_cfi_idx_valid (io_ifu_get_pc_0_entry_cfi_idx_valid),
    .io_get_ftq_pc_entry_cfi_idx_bits  (io_ifu_get_pc_0_entry_cfi_idx_bits),
    .io_get_ftq_pc_entry_start_bank    (io_ifu_get_pc_0_entry_start_bank),
    .io_get_ftq_pc_pc                  (io_ifu_get_pc_0_pc),
    .io_get_ftq_pc_next_val            (io_ifu_get_pc_0_next_val),
    .io_get_ftq_pc_next_pc             (io_ifu_get_pc_0_next_pc),
    .io_fu_types                       (_jmp_unit_io_fu_types),
    .io_iresp_valid                    (_jmp_unit_io_iresp_valid),
    .io_iresp_bits_uop_rob_idx         (_jmp_unit_io_iresp_bits_uop_rob_idx),
    .io_iresp_bits_uop_pdst            (_jmp_unit_io_iresp_bits_uop_pdst),
    .io_iresp_bits_uop_bypassable      (_jmp_unit_io_iresp_bits_uop_bypassable),
    .io_iresp_bits_uop_is_amo          (_jmp_unit_io_iresp_bits_uop_is_amo),
    .io_iresp_bits_uop_uses_stq        (_jmp_unit_io_iresp_bits_uop_uses_stq),
    .io_iresp_bits_uop_dst_rtype       (_jmp_unit_io_iresp_bits_uop_dst_rtype),
    .io_iresp_bits_data                (_jmp_unit_io_iresp_bits_data),
    .io_bypass_0_valid                 (_jmp_unit_io_bypass_0_valid),
    .io_bypass_0_bits_uop_pdst         (_jmp_unit_io_bypass_0_bits_uop_pdst),
    .io_bypass_0_bits_uop_dst_rtype    (_jmp_unit_io_bypass_0_bits_uop_dst_rtype),
    .io_bypass_0_bits_data             (_jmp_unit_io_bypass_0_bits_data),
    .io_brinfo_uop_is_rvc              (_jmp_unit_io_brinfo_uop_is_rvc),
    .io_brinfo_uop_br_mask             (_jmp_unit_io_brinfo_uop_br_mask),
    .io_brinfo_uop_br_tag              (_jmp_unit_io_brinfo_uop_br_tag),
    .io_brinfo_uop_ftq_idx             (_jmp_unit_io_brinfo_uop_ftq_idx),
    .io_brinfo_uop_edge_inst           (_jmp_unit_io_brinfo_uop_edge_inst),
    .io_brinfo_uop_pc_lob              (_jmp_unit_io_brinfo_uop_pc_lob),
    .io_brinfo_uop_rob_idx             (_jmp_unit_io_brinfo_uop_rob_idx),
    .io_brinfo_uop_ldq_idx             (_jmp_unit_io_brinfo_uop_ldq_idx),
    .io_brinfo_uop_stq_idx             (_jmp_unit_io_brinfo_uop_stq_idx),
    .io_brinfo_valid                   (_jmp_unit_io_brinfo_valid),
    .io_brinfo_mispredict              (_jmp_unit_io_brinfo_mispredict),
    .io_brinfo_taken                   (_jmp_unit_io_brinfo_taken),
    .io_brinfo_cfi_type                (_jmp_unit_io_brinfo_cfi_type),
    .io_brinfo_pc_sel                  (_jmp_unit_io_brinfo_pc_sel),
    .io_brinfo_jalr_target             (_jmp_unit_io_brinfo_jalr_target),
    .io_brinfo_target_offset           (_jmp_unit_io_brinfo_target_offset)
  );
  ALUExeUnit_8 csr_exe_unit (	// execution-units.scala:119:32
    .clock                                    (clock),
    .reset                                    (reset),
    .io_req_valid                             (_iregister_read_io_exe_reqs_2_valid),	// core.scala:132:32
    .io_req_bits_uop_uopc
      (_iregister_read_io_exe_reqs_2_bits_uop_uopc),	// core.scala:132:32
    .io_req_bits_uop_inst
      (_iregister_read_io_exe_reqs_2_bits_uop_inst),	// core.scala:132:32
    .io_req_bits_uop_debug_inst
      (_iregister_read_io_exe_reqs_2_bits_uop_debug_inst),	// core.scala:132:32
    .io_req_bits_uop_is_rvc
      (_iregister_read_io_exe_reqs_2_bits_uop_is_rvc),	// core.scala:132:32
    .io_req_bits_uop_debug_pc
      (_iregister_read_io_exe_reqs_2_bits_uop_debug_pc),	// core.scala:132:32
    .io_req_bits_uop_iq_type
      (_iregister_read_io_exe_reqs_2_bits_uop_iq_type),	// core.scala:132:32
    .io_req_bits_uop_fu_code
      (_iregister_read_io_exe_reqs_2_bits_uop_fu_code),	// core.scala:132:32
    .io_req_bits_uop_ctrl_br_type
      (_iregister_read_io_exe_reqs_2_bits_uop_ctrl_br_type),	// core.scala:132:32
    .io_req_bits_uop_ctrl_op1_sel
      (_iregister_read_io_exe_reqs_2_bits_uop_ctrl_op1_sel),	// core.scala:132:32
    .io_req_bits_uop_ctrl_op2_sel
      (_iregister_read_io_exe_reqs_2_bits_uop_ctrl_op2_sel),	// core.scala:132:32
    .io_req_bits_uop_ctrl_imm_sel
      (_iregister_read_io_exe_reqs_2_bits_uop_ctrl_imm_sel),	// core.scala:132:32
    .io_req_bits_uop_ctrl_op_fcn
      (_iregister_read_io_exe_reqs_2_bits_uop_ctrl_op_fcn),	// core.scala:132:32
    .io_req_bits_uop_ctrl_fcn_dw
      (_iregister_read_io_exe_reqs_2_bits_uop_ctrl_fcn_dw),	// core.scala:132:32
    .io_req_bits_uop_ctrl_csr_cmd
      (_iregister_read_io_exe_reqs_2_bits_uop_ctrl_csr_cmd),	// core.scala:132:32
    .io_req_bits_uop_ctrl_is_load
      (_iregister_read_io_exe_reqs_2_bits_uop_ctrl_is_load),	// core.scala:132:32
    .io_req_bits_uop_ctrl_is_sta
      (_iregister_read_io_exe_reqs_2_bits_uop_ctrl_is_sta),	// core.scala:132:32
    .io_req_bits_uop_ctrl_is_std
      (_iregister_read_io_exe_reqs_2_bits_uop_ctrl_is_std),	// core.scala:132:32
    .io_req_bits_uop_iw_state
      (_iregister_read_io_exe_reqs_2_bits_uop_iw_state),	// core.scala:132:32
    .io_req_bits_uop_iw_p1_poisoned           (1'h0),	// core.scala:77:37, :98:79, :100:32, :101:46, :102:33, :105:32, :107:32, :111:32, :119:32, :129:32, :132:32, :140:32, :155:24, :171:24, :172:27, :268:19, :683:73, execution-units.scala:108:30, :119:32
    .io_req_bits_uop_iw_p2_poisoned           (1'h0),	// core.scala:77:37, :98:79, :100:32, :101:46, :102:33, :105:32, :107:32, :111:32, :119:32, :129:32, :132:32, :140:32, :155:24, :171:24, :172:27, :268:19, :683:73, execution-units.scala:108:30, :119:32
    .io_req_bits_uop_is_br
      (_iregister_read_io_exe_reqs_2_bits_uop_is_br),	// core.scala:132:32
    .io_req_bits_uop_is_jalr
      (_iregister_read_io_exe_reqs_2_bits_uop_is_jalr),	// core.scala:132:32
    .io_req_bits_uop_is_jal
      (_iregister_read_io_exe_reqs_2_bits_uop_is_jal),	// core.scala:132:32
    .io_req_bits_uop_is_sfb
      (_iregister_read_io_exe_reqs_2_bits_uop_is_sfb),	// core.scala:132:32
    .io_req_bits_uop_br_mask
      (_iregister_read_io_exe_reqs_2_bits_uop_br_mask),	// core.scala:132:32
    .io_req_bits_uop_br_tag
      (_iregister_read_io_exe_reqs_2_bits_uop_br_tag),	// core.scala:132:32
    .io_req_bits_uop_ftq_idx
      (_iregister_read_io_exe_reqs_2_bits_uop_ftq_idx),	// core.scala:132:32
    .io_req_bits_uop_edge_inst
      (_iregister_read_io_exe_reqs_2_bits_uop_edge_inst),	// core.scala:132:32
    .io_req_bits_uop_pc_lob
      (_iregister_read_io_exe_reqs_2_bits_uop_pc_lob),	// core.scala:132:32
    .io_req_bits_uop_taken
      (_iregister_read_io_exe_reqs_2_bits_uop_taken),	// core.scala:132:32
    .io_req_bits_uop_imm_packed
      (_iregister_read_io_exe_reqs_2_bits_uop_imm_packed),	// core.scala:132:32
    .io_req_bits_uop_csr_addr
      (_iregister_read_io_exe_reqs_2_bits_uop_csr_addr),	// core.scala:132:32
    .io_req_bits_uop_rob_idx
      (_iregister_read_io_exe_reqs_2_bits_uop_rob_idx),	// core.scala:132:32
    .io_req_bits_uop_ldq_idx
      (_iregister_read_io_exe_reqs_2_bits_uop_ldq_idx),	// core.scala:132:32
    .io_req_bits_uop_stq_idx
      (_iregister_read_io_exe_reqs_2_bits_uop_stq_idx),	// core.scala:132:32
    .io_req_bits_uop_rxq_idx
      (_iregister_read_io_exe_reqs_2_bits_uop_rxq_idx),	// core.scala:132:32
    .io_req_bits_uop_pdst
      (_iregister_read_io_exe_reqs_2_bits_uop_pdst),	// core.scala:132:32
    .io_req_bits_uop_prs1
      (_iregister_read_io_exe_reqs_2_bits_uop_prs1),	// core.scala:132:32
    .io_req_bits_uop_prs2
      (_iregister_read_io_exe_reqs_2_bits_uop_prs2),	// core.scala:132:32
    .io_req_bits_uop_prs3
      (_iregister_read_io_exe_reqs_2_bits_uop_prs3),	// core.scala:132:32
    .io_req_bits_uop_ppred
      (_iregister_read_io_exe_reqs_2_bits_uop_ppred),	// core.scala:132:32
    .io_req_bits_uop_prs1_busy
      (_iregister_read_io_exe_reqs_2_bits_uop_prs1_busy),	// core.scala:132:32
    .io_req_bits_uop_prs2_busy
      (_iregister_read_io_exe_reqs_2_bits_uop_prs2_busy),	// core.scala:132:32
    .io_req_bits_uop_prs3_busy
      (_iregister_read_io_exe_reqs_2_bits_uop_prs3_busy),	// core.scala:132:32
    .io_req_bits_uop_ppred_busy
      (_iregister_read_io_exe_reqs_2_bits_uop_ppred_busy),	// core.scala:132:32
    .io_req_bits_uop_stale_pdst
      (_iregister_read_io_exe_reqs_2_bits_uop_stale_pdst),	// core.scala:132:32
    .io_req_bits_uop_exception
      (_iregister_read_io_exe_reqs_2_bits_uop_exception),	// core.scala:132:32
    .io_req_bits_uop_exc_cause
      (_iregister_read_io_exe_reqs_2_bits_uop_exc_cause),	// core.scala:132:32
    .io_req_bits_uop_bypassable
      (_iregister_read_io_exe_reqs_2_bits_uop_bypassable),	// core.scala:132:32
    .io_req_bits_uop_mem_cmd
      (_iregister_read_io_exe_reqs_2_bits_uop_mem_cmd),	// core.scala:132:32
    .io_req_bits_uop_mem_size
      (_iregister_read_io_exe_reqs_2_bits_uop_mem_size),	// core.scala:132:32
    .io_req_bits_uop_mem_signed
      (_iregister_read_io_exe_reqs_2_bits_uop_mem_signed),	// core.scala:132:32
    .io_req_bits_uop_is_fence
      (_iregister_read_io_exe_reqs_2_bits_uop_is_fence),	// core.scala:132:32
    .io_req_bits_uop_is_fencei
      (_iregister_read_io_exe_reqs_2_bits_uop_is_fencei),	// core.scala:132:32
    .io_req_bits_uop_is_amo
      (_iregister_read_io_exe_reqs_2_bits_uop_is_amo),	// core.scala:132:32
    .io_req_bits_uop_uses_ldq
      (_iregister_read_io_exe_reqs_2_bits_uop_uses_ldq),	// core.scala:132:32
    .io_req_bits_uop_uses_stq
      (_iregister_read_io_exe_reqs_2_bits_uop_uses_stq),	// core.scala:132:32
    .io_req_bits_uop_is_sys_pc2epc
      (_iregister_read_io_exe_reqs_2_bits_uop_is_sys_pc2epc),	// core.scala:132:32
    .io_req_bits_uop_is_unique
      (_iregister_read_io_exe_reqs_2_bits_uop_is_unique),	// core.scala:132:32
    .io_req_bits_uop_flush_on_commit
      (_iregister_read_io_exe_reqs_2_bits_uop_flush_on_commit),	// core.scala:132:32
    .io_req_bits_uop_ldst_is_rs1
      (_iregister_read_io_exe_reqs_2_bits_uop_ldst_is_rs1),	// core.scala:132:32
    .io_req_bits_uop_ldst
      (_iregister_read_io_exe_reqs_2_bits_uop_ldst),	// core.scala:132:32
    .io_req_bits_uop_lrs1
      (_iregister_read_io_exe_reqs_2_bits_uop_lrs1),	// core.scala:132:32
    .io_req_bits_uop_lrs2
      (_iregister_read_io_exe_reqs_2_bits_uop_lrs2),	// core.scala:132:32
    .io_req_bits_uop_lrs3
      (_iregister_read_io_exe_reqs_2_bits_uop_lrs3),	// core.scala:132:32
    .io_req_bits_uop_ldst_val
      (_iregister_read_io_exe_reqs_2_bits_uop_ldst_val),	// core.scala:132:32
    .io_req_bits_uop_dst_rtype
      (_iregister_read_io_exe_reqs_2_bits_uop_dst_rtype),	// core.scala:132:32
    .io_req_bits_uop_lrs1_rtype
      (_iregister_read_io_exe_reqs_2_bits_uop_lrs1_rtype),	// core.scala:132:32
    .io_req_bits_uop_lrs2_rtype
      (_iregister_read_io_exe_reqs_2_bits_uop_lrs2_rtype),	// core.scala:132:32
    .io_req_bits_uop_frs3_en
      (_iregister_read_io_exe_reqs_2_bits_uop_frs3_en),	// core.scala:132:32
    .io_req_bits_uop_fp_val
      (_iregister_read_io_exe_reqs_2_bits_uop_fp_val),	// core.scala:132:32
    .io_req_bits_uop_fp_single
      (_iregister_read_io_exe_reqs_2_bits_uop_fp_single),	// core.scala:132:32
    .io_req_bits_uop_xcpt_pf_if
      (_iregister_read_io_exe_reqs_2_bits_uop_xcpt_pf_if),	// core.scala:132:32
    .io_req_bits_uop_xcpt_ae_if
      (_iregister_read_io_exe_reqs_2_bits_uop_xcpt_ae_if),	// core.scala:132:32
    .io_req_bits_uop_xcpt_ma_if
      (_iregister_read_io_exe_reqs_2_bits_uop_xcpt_ma_if),	// core.scala:132:32
    .io_req_bits_uop_bp_debug_if
      (_iregister_read_io_exe_reqs_2_bits_uop_bp_debug_if),	// core.scala:132:32
    .io_req_bits_uop_bp_xcpt_if
      (_iregister_read_io_exe_reqs_2_bits_uop_bp_xcpt_if),	// core.scala:132:32
    .io_req_bits_uop_debug_fsrc
      (_iregister_read_io_exe_reqs_2_bits_uop_debug_fsrc),	// core.scala:132:32
    .io_req_bits_uop_debug_tsrc
      (_iregister_read_io_exe_reqs_2_bits_uop_debug_tsrc),	// core.scala:132:32
    .io_req_bits_rs1_data
      ({1'h0, _iregister_read_io_exe_reqs_2_bits_rs1_data}),	// core.scala:77:37, :98:79, :100:32, :101:46, :102:33, :105:32, :107:32, :111:32, :119:32, :129:32, :132:32, :140:32, :155:24, :171:24, :172:27, :268:19, :683:73, :1074:23, execution-units.scala:108:30, :119:32
    .io_req_bits_rs2_data
      ({1'h0, _iregister_read_io_exe_reqs_2_bits_rs2_data}),	// core.scala:77:37, :98:79, :100:32, :101:46, :102:33, :105:32, :107:32, :111:32, :119:32, :129:32, :132:32, :140:32, :155:24, :171:24, :172:27, :268:19, :683:73, :1074:23, execution-units.scala:108:30, :119:32
    .io_req_bits_kill                         (alu_exe_unit_io_req_bits_kill_REG_1),	// core.scala:1295:45
    .io_ll_fresp_ready                        (_fp_pipeline_io_from_int_ready),	// core.scala:77:37
    .io_brupdate_b1_resolve_mask              (b1_resolve_mask),	// core.scala:196:72
    .io_brupdate_b1_mispredict_mask           (b1_mispredict_mask),	// core.scala:197:93
    .io_fcsr_rm                               (_csr_io_fcsr_rm),	// core.scala:268:19
    .io_fu_types                              (_csr_exe_unit_io_fu_types),
    .io_iresp_valid                           (_csr_exe_unit_io_iresp_valid),
    .io_iresp_bits_uop_ctrl_csr_cmd
      (_csr_exe_unit_io_iresp_bits_uop_ctrl_csr_cmd),
    .io_iresp_bits_uop_csr_addr               (_csr_exe_unit_io_iresp_bits_uop_csr_addr),
    .io_iresp_bits_uop_rob_idx                (_csr_exe_unit_io_iresp_bits_uop_rob_idx),
    .io_iresp_bits_uop_pdst                   (_csr_exe_unit_io_iresp_bits_uop_pdst),
    .io_iresp_bits_uop_bypassable
      (_csr_exe_unit_io_iresp_bits_uop_bypassable),
    .io_iresp_bits_uop_is_amo                 (_csr_exe_unit_io_iresp_bits_uop_is_amo),
    .io_iresp_bits_uop_uses_stq               (_csr_exe_unit_io_iresp_bits_uop_uses_stq),
    .io_iresp_bits_uop_dst_rtype              (_csr_exe_unit_io_iresp_bits_uop_dst_rtype),
    .io_iresp_bits_data                       (_csr_exe_unit_io_iresp_bits_data),
    .io_ll_fresp_valid                        (_csr_exe_unit_io_ll_fresp_valid),
    .io_ll_fresp_bits_uop_uopc                (_csr_exe_unit_io_ll_fresp_bits_uop_uopc),
    .io_ll_fresp_bits_uop_br_mask
      (_csr_exe_unit_io_ll_fresp_bits_uop_br_mask),
    .io_ll_fresp_bits_uop_rob_idx
      (_csr_exe_unit_io_ll_fresp_bits_uop_rob_idx),
    .io_ll_fresp_bits_uop_stq_idx
      (_csr_exe_unit_io_ll_fresp_bits_uop_stq_idx),
    .io_ll_fresp_bits_uop_pdst                (_csr_exe_unit_io_ll_fresp_bits_uop_pdst),
    .io_ll_fresp_bits_uop_is_amo              (_csr_exe_unit_io_ll_fresp_bits_uop_is_amo),
    .io_ll_fresp_bits_uop_uses_stq
      (_csr_exe_unit_io_ll_fresp_bits_uop_uses_stq),
    .io_ll_fresp_bits_uop_dst_rtype
      (_csr_exe_unit_io_ll_fresp_bits_uop_dst_rtype),
    .io_ll_fresp_bits_uop_fp_val              (_csr_exe_unit_io_ll_fresp_bits_uop_fp_val),
    .io_ll_fresp_bits_data                    (_csr_exe_unit_io_ll_fresp_bits_data),
    .io_ll_fresp_bits_predicated              (_csr_exe_unit_io_ll_fresp_bits_predicated),
    .io_ll_fresp_bits_fflags_valid
      (_csr_exe_unit_io_ll_fresp_bits_fflags_valid),
    .io_ll_fresp_bits_fflags_bits_uop_rob_idx
      (_csr_exe_unit_io_ll_fresp_bits_fflags_bits_uop_rob_idx),
    .io_ll_fresp_bits_fflags_bits_flags
      (_csr_exe_unit_io_ll_fresp_bits_fflags_bits_flags),
    .io_bypass_0_valid                        (_csr_exe_unit_io_bypass_0_valid),
    .io_bypass_0_bits_uop_pdst                (_csr_exe_unit_io_bypass_0_bits_uop_pdst),
    .io_bypass_0_bits_uop_dst_rtype
      (_csr_exe_unit_io_bypass_0_bits_uop_dst_rtype),
    .io_bypass_0_bits_data                    (_csr_exe_unit_io_bypass_0_bits_data),
    .io_brinfo_uop_is_rvc                     (_csr_exe_unit_io_brinfo_uop_is_rvc),
    .io_brinfo_uop_br_mask                    (_csr_exe_unit_io_brinfo_uop_br_mask),
    .io_brinfo_uop_br_tag                     (_csr_exe_unit_io_brinfo_uop_br_tag),
    .io_brinfo_uop_ftq_idx                    (_csr_exe_unit_io_brinfo_uop_ftq_idx),
    .io_brinfo_uop_edge_inst                  (_csr_exe_unit_io_brinfo_uop_edge_inst),
    .io_brinfo_uop_pc_lob                     (_csr_exe_unit_io_brinfo_uop_pc_lob),
    .io_brinfo_uop_rob_idx                    (_csr_exe_unit_io_brinfo_uop_rob_idx),
    .io_brinfo_uop_ldq_idx                    (_csr_exe_unit_io_brinfo_uop_ldq_idx),
    .io_brinfo_uop_stq_idx                    (_csr_exe_unit_io_brinfo_uop_stq_idx),
    .io_brinfo_valid                          (_csr_exe_unit_io_brinfo_valid),
    .io_brinfo_mispredict                     (_csr_exe_unit_io_brinfo_mispredict),
    .io_brinfo_taken                          (_csr_exe_unit_io_brinfo_taken),
    .io_brinfo_cfi_type                       (_csr_exe_unit_io_brinfo_cfi_type),
    .io_brinfo_pc_sel                         (_csr_exe_unit_io_brinfo_pc_sel),
    .io_brinfo_target_offset                  (_csr_exe_unit_io_brinfo_target_offset)
  );
  ALUExeUnit_9 alu_exe_unit (	// execution-units.scala:119:32
    .clock                          (clock),
    .reset                          (reset),
    .io_req_valid                   (_iregister_read_io_exe_reqs_3_valid),	// core.scala:132:32
    .io_req_bits_uop_uopc           (_iregister_read_io_exe_reqs_3_bits_uop_uopc),	// core.scala:132:32
    .io_req_bits_uop_is_rvc         (_iregister_read_io_exe_reqs_3_bits_uop_is_rvc),	// core.scala:132:32
    .io_req_bits_uop_fu_code        (_iregister_read_io_exe_reqs_3_bits_uop_fu_code),	// core.scala:132:32
    .io_req_bits_uop_ctrl_br_type   (_iregister_read_io_exe_reqs_3_bits_uop_ctrl_br_type),	// core.scala:132:32
    .io_req_bits_uop_ctrl_op1_sel   (_iregister_read_io_exe_reqs_3_bits_uop_ctrl_op1_sel),	// core.scala:132:32
    .io_req_bits_uop_ctrl_op2_sel   (_iregister_read_io_exe_reqs_3_bits_uop_ctrl_op2_sel),	// core.scala:132:32
    .io_req_bits_uop_ctrl_imm_sel   (_iregister_read_io_exe_reqs_3_bits_uop_ctrl_imm_sel),	// core.scala:132:32
    .io_req_bits_uop_ctrl_op_fcn    (_iregister_read_io_exe_reqs_3_bits_uop_ctrl_op_fcn),	// core.scala:132:32
    .io_req_bits_uop_ctrl_fcn_dw    (_iregister_read_io_exe_reqs_3_bits_uop_ctrl_fcn_dw),	// core.scala:132:32
    .io_req_bits_uop_is_br          (_iregister_read_io_exe_reqs_3_bits_uop_is_br),	// core.scala:132:32
    .io_req_bits_uop_is_jalr        (_iregister_read_io_exe_reqs_3_bits_uop_is_jalr),	// core.scala:132:32
    .io_req_bits_uop_is_jal         (_iregister_read_io_exe_reqs_3_bits_uop_is_jal),	// core.scala:132:32
    .io_req_bits_uop_is_sfb         (_iregister_read_io_exe_reqs_3_bits_uop_is_sfb),	// core.scala:132:32
    .io_req_bits_uop_br_mask        (_iregister_read_io_exe_reqs_3_bits_uop_br_mask),	// core.scala:132:32
    .io_req_bits_uop_br_tag         (_iregister_read_io_exe_reqs_3_bits_uop_br_tag),	// core.scala:132:32
    .io_req_bits_uop_ftq_idx        (_iregister_read_io_exe_reqs_3_bits_uop_ftq_idx),	// core.scala:132:32
    .io_req_bits_uop_edge_inst      (_iregister_read_io_exe_reqs_3_bits_uop_edge_inst),	// core.scala:132:32
    .io_req_bits_uop_pc_lob         (_iregister_read_io_exe_reqs_3_bits_uop_pc_lob),	// core.scala:132:32
    .io_req_bits_uop_taken          (_iregister_read_io_exe_reqs_3_bits_uop_taken),	// core.scala:132:32
    .io_req_bits_uop_imm_packed     (_iregister_read_io_exe_reqs_3_bits_uop_imm_packed),	// core.scala:132:32
    .io_req_bits_uop_rob_idx        (_iregister_read_io_exe_reqs_3_bits_uop_rob_idx),	// core.scala:132:32
    .io_req_bits_uop_ldq_idx        (_iregister_read_io_exe_reqs_3_bits_uop_ldq_idx),	// core.scala:132:32
    .io_req_bits_uop_stq_idx        (_iregister_read_io_exe_reqs_3_bits_uop_stq_idx),	// core.scala:132:32
    .io_req_bits_uop_pdst           (_iregister_read_io_exe_reqs_3_bits_uop_pdst),	// core.scala:132:32
    .io_req_bits_uop_prs1           (_iregister_read_io_exe_reqs_3_bits_uop_prs1),	// core.scala:132:32
    .io_req_bits_uop_bypassable     (_iregister_read_io_exe_reqs_3_bits_uop_bypassable),	// core.scala:132:32
    .io_req_bits_uop_is_amo         (_iregister_read_io_exe_reqs_3_bits_uop_is_amo),	// core.scala:132:32
    .io_req_bits_uop_uses_stq       (_iregister_read_io_exe_reqs_3_bits_uop_uses_stq),	// core.scala:132:32
    .io_req_bits_uop_dst_rtype      (_iregister_read_io_exe_reqs_3_bits_uop_dst_rtype),	// core.scala:132:32
    .io_req_bits_rs1_data           ({1'h0, _iregister_read_io_exe_reqs_3_bits_rs1_data}),	// core.scala:77:37, :98:79, :100:32, :101:46, :102:33, :105:32, :107:32, :111:32, :119:32, :129:32, :132:32, :140:32, :155:24, :171:24, :172:27, :268:19, :683:73, :1074:23, execution-units.scala:108:30, :119:32
    .io_req_bits_rs2_data           ({1'h0, _iregister_read_io_exe_reqs_3_bits_rs2_data}),	// core.scala:77:37, :98:79, :100:32, :101:46, :102:33, :105:32, :107:32, :111:32, :119:32, :129:32, :132:32, :140:32, :155:24, :171:24, :172:27, :268:19, :683:73, :1074:23, execution-units.scala:108:30, :119:32
    .io_req_bits_kill               (alu_exe_unit_io_req_bits_kill_REG_2),	// core.scala:1295:45
    .io_brupdate_b1_resolve_mask    (b1_resolve_mask),	// core.scala:196:72
    .io_brupdate_b1_mispredict_mask (b1_mispredict_mask),	// core.scala:197:93
    .io_iresp_valid                 (_alu_exe_unit_io_iresp_valid),
    .io_iresp_bits_uop_rob_idx      (_alu_exe_unit_io_iresp_bits_uop_rob_idx),
    .io_iresp_bits_uop_pdst         (_alu_exe_unit_io_iresp_bits_uop_pdst),
    .io_iresp_bits_uop_bypassable   (_alu_exe_unit_io_iresp_bits_uop_bypassable),
    .io_iresp_bits_uop_is_amo       (_alu_exe_unit_io_iresp_bits_uop_is_amo),
    .io_iresp_bits_uop_uses_stq     (_alu_exe_unit_io_iresp_bits_uop_uses_stq),
    .io_iresp_bits_uop_dst_rtype    (_alu_exe_unit_io_iresp_bits_uop_dst_rtype),
    .io_iresp_bits_data             (_alu_exe_unit_io_iresp_bits_data),
    .io_bypass_0_valid              (_alu_exe_unit_io_bypass_0_valid),
    .io_bypass_0_bits_uop_pdst      (_alu_exe_unit_io_bypass_0_bits_uop_pdst),
    .io_bypass_0_bits_uop_dst_rtype (_alu_exe_unit_io_bypass_0_bits_uop_dst_rtype),
    .io_bypass_0_bits_data          (_alu_exe_unit_io_bypass_0_bits_data),
    .io_bypass_1_valid              (_alu_exe_unit_io_bypass_1_valid),
    .io_bypass_1_bits_uop_pdst      (_alu_exe_unit_io_bypass_1_bits_uop_pdst),
    .io_bypass_1_bits_uop_dst_rtype (_alu_exe_unit_io_bypass_1_bits_uop_dst_rtype),
    .io_bypass_1_bits_data          (_alu_exe_unit_io_bypass_1_bits_data),
    .io_bypass_2_valid              (_alu_exe_unit_io_bypass_2_valid),
    .io_bypass_2_bits_uop_pdst      (_alu_exe_unit_io_bypass_2_bits_uop_pdst),
    .io_bypass_2_bits_uop_dst_rtype (_alu_exe_unit_io_bypass_2_bits_uop_dst_rtype),
    .io_bypass_2_bits_data          (_alu_exe_unit_io_bypass_2_bits_data),
    .io_brinfo_uop_is_rvc           (_alu_exe_unit_io_brinfo_uop_is_rvc),
    .io_brinfo_uop_br_mask          (_alu_exe_unit_io_brinfo_uop_br_mask),
    .io_brinfo_uop_br_tag           (_alu_exe_unit_io_brinfo_uop_br_tag),
    .io_brinfo_uop_ftq_idx          (_alu_exe_unit_io_brinfo_uop_ftq_idx),
    .io_brinfo_uop_edge_inst        (_alu_exe_unit_io_brinfo_uop_edge_inst),
    .io_brinfo_uop_pc_lob           (_alu_exe_unit_io_brinfo_uop_pc_lob),
    .io_brinfo_uop_rob_idx          (_alu_exe_unit_io_brinfo_uop_rob_idx),
    .io_brinfo_uop_ldq_idx          (_alu_exe_unit_io_brinfo_uop_ldq_idx),
    .io_brinfo_uop_stq_idx          (_alu_exe_unit_io_brinfo_uop_stq_idx),
    .io_brinfo_valid                (_alu_exe_unit_io_brinfo_valid),
    .io_brinfo_mispredict           (_alu_exe_unit_io_brinfo_mispredict),
    .io_brinfo_taken                (_alu_exe_unit_io_brinfo_taken),
    .io_brinfo_cfi_type             (_alu_exe_unit_io_brinfo_cfi_type),
    .io_brinfo_pc_sel               (_alu_exe_unit_io_brinfo_pc_sel),
    .io_brinfo_target_offset        (_alu_exe_unit_io_brinfo_target_offset)
  );
  FpPipeline_1 fp_pipeline (	// core.scala:77:37
    .clock                                     (clock),
    .reset                                     (reset),
    .io_brupdate_b1_resolve_mask               (b1_resolve_mask),	// core.scala:196:72
    .io_brupdate_b1_mispredict_mask            (b1_mispredict_mask),	// core.scala:197:93
    .io_flush_pipeline                         (REG_6),	// core.scala:1291:45
    .io_fcsr_rm                                (_csr_io_fcsr_rm),	// core.scala:268:19
    .io_dis_uops_0_valid                       (_dispatcher_io_dis_uops_2_0_valid),	// core.scala:111:32
    .io_dis_uops_0_bits_uopc                   (_dispatcher_io_dis_uops_2_0_bits_uopc),	// core.scala:111:32
    .io_dis_uops_0_bits_inst                   (_dispatcher_io_dis_uops_2_0_bits_inst),	// core.scala:111:32
    .io_dis_uops_0_bits_debug_inst
      (_dispatcher_io_dis_uops_2_0_bits_debug_inst),	// core.scala:111:32
    .io_dis_uops_0_bits_is_rvc                 (_dispatcher_io_dis_uops_2_0_bits_is_rvc),	// core.scala:111:32
    .io_dis_uops_0_bits_debug_pc
      (_dispatcher_io_dis_uops_2_0_bits_debug_pc),	// core.scala:111:32
    .io_dis_uops_0_bits_iq_type                (_dispatcher_io_dis_uops_2_0_bits_iq_type),	// core.scala:111:32
    .io_dis_uops_0_bits_fu_code                (_dispatcher_io_dis_uops_2_0_bits_fu_code),	// core.scala:111:32
    .io_dis_uops_0_bits_is_br                  (_dispatcher_io_dis_uops_2_0_bits_is_br),	// core.scala:111:32
    .io_dis_uops_0_bits_is_jalr                (_dispatcher_io_dis_uops_2_0_bits_is_jalr),	// core.scala:111:32
    .io_dis_uops_0_bits_is_jal                 (_dispatcher_io_dis_uops_2_0_bits_is_jal),	// core.scala:111:32
    .io_dis_uops_0_bits_is_sfb                 (_dispatcher_io_dis_uops_2_0_bits_is_sfb),	// core.scala:111:32
    .io_dis_uops_0_bits_br_mask                (_dispatcher_io_dis_uops_2_0_bits_br_mask),	// core.scala:111:32
    .io_dis_uops_0_bits_br_tag                 (_dispatcher_io_dis_uops_2_0_bits_br_tag),	// core.scala:111:32
    .io_dis_uops_0_bits_ftq_idx                (_dispatcher_io_dis_uops_2_0_bits_ftq_idx),	// core.scala:111:32
    .io_dis_uops_0_bits_edge_inst
      (_dispatcher_io_dis_uops_2_0_bits_edge_inst),	// core.scala:111:32
    .io_dis_uops_0_bits_pc_lob                 (_dispatcher_io_dis_uops_2_0_bits_pc_lob),	// core.scala:111:32
    .io_dis_uops_0_bits_taken                  (_dispatcher_io_dis_uops_2_0_bits_taken),	// core.scala:111:32
    .io_dis_uops_0_bits_imm_packed
      (_dispatcher_io_dis_uops_2_0_bits_imm_packed),	// core.scala:111:32
    .io_dis_uops_0_bits_csr_addr
      (_dispatcher_io_dis_uops_2_0_bits_csr_addr),	// core.scala:111:32
    .io_dis_uops_0_bits_rob_idx                (_dispatcher_io_dis_uops_2_0_bits_rob_idx),	// core.scala:111:32
    .io_dis_uops_0_bits_ldq_idx                (_dispatcher_io_dis_uops_2_0_bits_ldq_idx),	// core.scala:111:32
    .io_dis_uops_0_bits_stq_idx                (_dispatcher_io_dis_uops_2_0_bits_stq_idx),	// core.scala:111:32
    .io_dis_uops_0_bits_rxq_idx                (_dispatcher_io_dis_uops_2_0_bits_rxq_idx),	// core.scala:111:32
    .io_dis_uops_0_bits_pdst                   (_dispatcher_io_dis_uops_2_0_bits_pdst),	// core.scala:111:32
    .io_dis_uops_0_bits_prs1                   (_dispatcher_io_dis_uops_2_0_bits_prs1),	// core.scala:111:32
    .io_dis_uops_0_bits_prs2                   (_dispatcher_io_dis_uops_2_0_bits_prs2),	// core.scala:111:32
    .io_dis_uops_0_bits_prs3                   (_dispatcher_io_dis_uops_2_0_bits_prs3),	// core.scala:111:32
    .io_dis_uops_0_bits_prs1_busy
      (_dispatcher_io_dis_uops_2_0_bits_prs1_busy),	// core.scala:111:32
    .io_dis_uops_0_bits_prs2_busy
      (_dispatcher_io_dis_uops_2_0_bits_prs2_busy),	// core.scala:111:32
    .io_dis_uops_0_bits_prs3_busy
      (_dispatcher_io_dis_uops_2_0_bits_prs3_busy),	// core.scala:111:32
    .io_dis_uops_0_bits_stale_pdst
      (_dispatcher_io_dis_uops_2_0_bits_stale_pdst),	// core.scala:111:32
    .io_dis_uops_0_bits_exception
      (_dispatcher_io_dis_uops_2_0_bits_exception),	// core.scala:111:32
    .io_dis_uops_0_bits_exc_cause
      (_dispatcher_io_dis_uops_2_0_bits_exc_cause),	// core.scala:111:32
    .io_dis_uops_0_bits_bypassable
      (_dispatcher_io_dis_uops_2_0_bits_bypassable),	// core.scala:111:32
    .io_dis_uops_0_bits_mem_cmd                (_dispatcher_io_dis_uops_2_0_bits_mem_cmd),	// core.scala:111:32
    .io_dis_uops_0_bits_mem_size
      (_dispatcher_io_dis_uops_2_0_bits_mem_size),	// core.scala:111:32
    .io_dis_uops_0_bits_mem_signed
      (_dispatcher_io_dis_uops_2_0_bits_mem_signed),	// core.scala:111:32
    .io_dis_uops_0_bits_is_fence
      (_dispatcher_io_dis_uops_2_0_bits_is_fence),	// core.scala:111:32
    .io_dis_uops_0_bits_is_fencei
      (_dispatcher_io_dis_uops_2_0_bits_is_fencei),	// core.scala:111:32
    .io_dis_uops_0_bits_is_amo                 (_dispatcher_io_dis_uops_2_0_bits_is_amo),	// core.scala:111:32
    .io_dis_uops_0_bits_uses_ldq
      (_dispatcher_io_dis_uops_2_0_bits_uses_ldq),	// core.scala:111:32
    .io_dis_uops_0_bits_uses_stq
      (_dispatcher_io_dis_uops_2_0_bits_uses_stq),	// core.scala:111:32
    .io_dis_uops_0_bits_is_sys_pc2epc
      (_dispatcher_io_dis_uops_2_0_bits_is_sys_pc2epc),	// core.scala:111:32
    .io_dis_uops_0_bits_is_unique
      (_dispatcher_io_dis_uops_2_0_bits_is_unique),	// core.scala:111:32
    .io_dis_uops_0_bits_flush_on_commit
      (_dispatcher_io_dis_uops_2_0_bits_flush_on_commit),	// core.scala:111:32
    .io_dis_uops_0_bits_ldst_is_rs1
      (_dispatcher_io_dis_uops_2_0_bits_ldst_is_rs1),	// core.scala:111:32
    .io_dis_uops_0_bits_ldst                   (_dispatcher_io_dis_uops_2_0_bits_ldst),	// core.scala:111:32
    .io_dis_uops_0_bits_lrs1                   (_dispatcher_io_dis_uops_2_0_bits_lrs1),	// core.scala:111:32
    .io_dis_uops_0_bits_lrs2                   (_dispatcher_io_dis_uops_2_0_bits_lrs2),	// core.scala:111:32
    .io_dis_uops_0_bits_lrs3                   (_dispatcher_io_dis_uops_2_0_bits_lrs3),	// core.scala:111:32
    .io_dis_uops_0_bits_ldst_val
      (_dispatcher_io_dis_uops_2_0_bits_ldst_val),	// core.scala:111:32
    .io_dis_uops_0_bits_dst_rtype
      (_dispatcher_io_dis_uops_2_0_bits_dst_rtype),	// core.scala:111:32
    .io_dis_uops_0_bits_lrs1_rtype
      (_dispatcher_io_dis_uops_2_0_bits_lrs1_rtype),	// core.scala:111:32
    .io_dis_uops_0_bits_lrs2_rtype
      (_dispatcher_io_dis_uops_2_0_bits_lrs2_rtype),	// core.scala:111:32
    .io_dis_uops_0_bits_frs3_en                (_dispatcher_io_dis_uops_2_0_bits_frs3_en),	// core.scala:111:32
    .io_dis_uops_0_bits_fp_val                 (_dispatcher_io_dis_uops_2_0_bits_fp_val),	// core.scala:111:32
    .io_dis_uops_0_bits_fp_single
      (_dispatcher_io_dis_uops_2_0_bits_fp_single),	// core.scala:111:32
    .io_dis_uops_0_bits_xcpt_pf_if
      (_dispatcher_io_dis_uops_2_0_bits_xcpt_pf_if),	// core.scala:111:32
    .io_dis_uops_0_bits_xcpt_ae_if
      (_dispatcher_io_dis_uops_2_0_bits_xcpt_ae_if),	// core.scala:111:32
    .io_dis_uops_0_bits_xcpt_ma_if
      (_dispatcher_io_dis_uops_2_0_bits_xcpt_ma_if),	// core.scala:111:32
    .io_dis_uops_0_bits_bp_debug_if
      (_dispatcher_io_dis_uops_2_0_bits_bp_debug_if),	// core.scala:111:32
    .io_dis_uops_0_bits_bp_xcpt_if
      (_dispatcher_io_dis_uops_2_0_bits_bp_xcpt_if),	// core.scala:111:32
    .io_dis_uops_0_bits_debug_fsrc
      (_dispatcher_io_dis_uops_2_0_bits_debug_fsrc),	// core.scala:111:32
    .io_dis_uops_0_bits_debug_tsrc
      (_dispatcher_io_dis_uops_2_0_bits_debug_tsrc),	// core.scala:111:32
    .io_dis_uops_1_valid                       (_dispatcher_io_dis_uops_2_1_valid),	// core.scala:111:32
    .io_dis_uops_1_bits_uopc                   (_dispatcher_io_dis_uops_2_1_bits_uopc),	// core.scala:111:32
    .io_dis_uops_1_bits_inst                   (_dispatcher_io_dis_uops_2_1_bits_inst),	// core.scala:111:32
    .io_dis_uops_1_bits_debug_inst
      (_dispatcher_io_dis_uops_2_1_bits_debug_inst),	// core.scala:111:32
    .io_dis_uops_1_bits_is_rvc                 (_dispatcher_io_dis_uops_2_1_bits_is_rvc),	// core.scala:111:32
    .io_dis_uops_1_bits_debug_pc
      (_dispatcher_io_dis_uops_2_1_bits_debug_pc),	// core.scala:111:32
    .io_dis_uops_1_bits_iq_type                (_dispatcher_io_dis_uops_2_1_bits_iq_type),	// core.scala:111:32
    .io_dis_uops_1_bits_fu_code                (_dispatcher_io_dis_uops_2_1_bits_fu_code),	// core.scala:111:32
    .io_dis_uops_1_bits_is_br                  (_dispatcher_io_dis_uops_2_1_bits_is_br),	// core.scala:111:32
    .io_dis_uops_1_bits_is_jalr                (_dispatcher_io_dis_uops_2_1_bits_is_jalr),	// core.scala:111:32
    .io_dis_uops_1_bits_is_jal                 (_dispatcher_io_dis_uops_2_1_bits_is_jal),	// core.scala:111:32
    .io_dis_uops_1_bits_is_sfb                 (_dispatcher_io_dis_uops_2_1_bits_is_sfb),	// core.scala:111:32
    .io_dis_uops_1_bits_br_mask                (_dispatcher_io_dis_uops_2_1_bits_br_mask),	// core.scala:111:32
    .io_dis_uops_1_bits_br_tag                 (_dispatcher_io_dis_uops_2_1_bits_br_tag),	// core.scala:111:32
    .io_dis_uops_1_bits_ftq_idx                (_dispatcher_io_dis_uops_2_1_bits_ftq_idx),	// core.scala:111:32
    .io_dis_uops_1_bits_edge_inst
      (_dispatcher_io_dis_uops_2_1_bits_edge_inst),	// core.scala:111:32
    .io_dis_uops_1_bits_pc_lob                 (_dispatcher_io_dis_uops_2_1_bits_pc_lob),	// core.scala:111:32
    .io_dis_uops_1_bits_taken                  (_dispatcher_io_dis_uops_2_1_bits_taken),	// core.scala:111:32
    .io_dis_uops_1_bits_imm_packed
      (_dispatcher_io_dis_uops_2_1_bits_imm_packed),	// core.scala:111:32
    .io_dis_uops_1_bits_csr_addr
      (_dispatcher_io_dis_uops_2_1_bits_csr_addr),	// core.scala:111:32
    .io_dis_uops_1_bits_rob_idx                (_dispatcher_io_dis_uops_2_1_bits_rob_idx),	// core.scala:111:32
    .io_dis_uops_1_bits_ldq_idx                (_dispatcher_io_dis_uops_2_1_bits_ldq_idx),	// core.scala:111:32
    .io_dis_uops_1_bits_stq_idx                (_dispatcher_io_dis_uops_2_1_bits_stq_idx),	// core.scala:111:32
    .io_dis_uops_1_bits_rxq_idx                (_dispatcher_io_dis_uops_2_1_bits_rxq_idx),	// core.scala:111:32
    .io_dis_uops_1_bits_pdst                   (_dispatcher_io_dis_uops_2_1_bits_pdst),	// core.scala:111:32
    .io_dis_uops_1_bits_prs1                   (_dispatcher_io_dis_uops_2_1_bits_prs1),	// core.scala:111:32
    .io_dis_uops_1_bits_prs2                   (_dispatcher_io_dis_uops_2_1_bits_prs2),	// core.scala:111:32
    .io_dis_uops_1_bits_prs3                   (_dispatcher_io_dis_uops_2_1_bits_prs3),	// core.scala:111:32
    .io_dis_uops_1_bits_prs1_busy
      (_dispatcher_io_dis_uops_2_1_bits_prs1_busy),	// core.scala:111:32
    .io_dis_uops_1_bits_prs2_busy
      (_dispatcher_io_dis_uops_2_1_bits_prs2_busy),	// core.scala:111:32
    .io_dis_uops_1_bits_prs3_busy
      (_dispatcher_io_dis_uops_2_1_bits_prs3_busy),	// core.scala:111:32
    .io_dis_uops_1_bits_stale_pdst
      (_dispatcher_io_dis_uops_2_1_bits_stale_pdst),	// core.scala:111:32
    .io_dis_uops_1_bits_exception
      (_dispatcher_io_dis_uops_2_1_bits_exception),	// core.scala:111:32
    .io_dis_uops_1_bits_exc_cause
      (_dispatcher_io_dis_uops_2_1_bits_exc_cause),	// core.scala:111:32
    .io_dis_uops_1_bits_bypassable
      (_dispatcher_io_dis_uops_2_1_bits_bypassable),	// core.scala:111:32
    .io_dis_uops_1_bits_mem_cmd                (_dispatcher_io_dis_uops_2_1_bits_mem_cmd),	// core.scala:111:32
    .io_dis_uops_1_bits_mem_size
      (_dispatcher_io_dis_uops_2_1_bits_mem_size),	// core.scala:111:32
    .io_dis_uops_1_bits_mem_signed
      (_dispatcher_io_dis_uops_2_1_bits_mem_signed),	// core.scala:111:32
    .io_dis_uops_1_bits_is_fence
      (_dispatcher_io_dis_uops_2_1_bits_is_fence),	// core.scala:111:32
    .io_dis_uops_1_bits_is_fencei
      (_dispatcher_io_dis_uops_2_1_bits_is_fencei),	// core.scala:111:32
    .io_dis_uops_1_bits_is_amo                 (_dispatcher_io_dis_uops_2_1_bits_is_amo),	// core.scala:111:32
    .io_dis_uops_1_bits_uses_ldq
      (_dispatcher_io_dis_uops_2_1_bits_uses_ldq),	// core.scala:111:32
    .io_dis_uops_1_bits_uses_stq
      (_dispatcher_io_dis_uops_2_1_bits_uses_stq),	// core.scala:111:32
    .io_dis_uops_1_bits_is_sys_pc2epc
      (_dispatcher_io_dis_uops_2_1_bits_is_sys_pc2epc),	// core.scala:111:32
    .io_dis_uops_1_bits_is_unique
      (_dispatcher_io_dis_uops_2_1_bits_is_unique),	// core.scala:111:32
    .io_dis_uops_1_bits_flush_on_commit
      (_dispatcher_io_dis_uops_2_1_bits_flush_on_commit),	// core.scala:111:32
    .io_dis_uops_1_bits_ldst_is_rs1
      (_dispatcher_io_dis_uops_2_1_bits_ldst_is_rs1),	// core.scala:111:32
    .io_dis_uops_1_bits_ldst                   (_dispatcher_io_dis_uops_2_1_bits_ldst),	// core.scala:111:32
    .io_dis_uops_1_bits_lrs1                   (_dispatcher_io_dis_uops_2_1_bits_lrs1),	// core.scala:111:32
    .io_dis_uops_1_bits_lrs2                   (_dispatcher_io_dis_uops_2_1_bits_lrs2),	// core.scala:111:32
    .io_dis_uops_1_bits_lrs3                   (_dispatcher_io_dis_uops_2_1_bits_lrs3),	// core.scala:111:32
    .io_dis_uops_1_bits_ldst_val
      (_dispatcher_io_dis_uops_2_1_bits_ldst_val),	// core.scala:111:32
    .io_dis_uops_1_bits_dst_rtype
      (_dispatcher_io_dis_uops_2_1_bits_dst_rtype),	// core.scala:111:32
    .io_dis_uops_1_bits_lrs1_rtype
      (_dispatcher_io_dis_uops_2_1_bits_lrs1_rtype),	// core.scala:111:32
    .io_dis_uops_1_bits_lrs2_rtype
      (_dispatcher_io_dis_uops_2_1_bits_lrs2_rtype),	// core.scala:111:32
    .io_dis_uops_1_bits_frs3_en                (_dispatcher_io_dis_uops_2_1_bits_frs3_en),	// core.scala:111:32
    .io_dis_uops_1_bits_fp_val                 (_dispatcher_io_dis_uops_2_1_bits_fp_val),	// core.scala:111:32
    .io_dis_uops_1_bits_fp_single
      (_dispatcher_io_dis_uops_2_1_bits_fp_single),	// core.scala:111:32
    .io_dis_uops_1_bits_xcpt_pf_if
      (_dispatcher_io_dis_uops_2_1_bits_xcpt_pf_if),	// core.scala:111:32
    .io_dis_uops_1_bits_xcpt_ae_if
      (_dispatcher_io_dis_uops_2_1_bits_xcpt_ae_if),	// core.scala:111:32
    .io_dis_uops_1_bits_xcpt_ma_if
      (_dispatcher_io_dis_uops_2_1_bits_xcpt_ma_if),	// core.scala:111:32
    .io_dis_uops_1_bits_bp_debug_if
      (_dispatcher_io_dis_uops_2_1_bits_bp_debug_if),	// core.scala:111:32
    .io_dis_uops_1_bits_bp_xcpt_if
      (_dispatcher_io_dis_uops_2_1_bits_bp_xcpt_if),	// core.scala:111:32
    .io_dis_uops_1_bits_debug_fsrc
      (_dispatcher_io_dis_uops_2_1_bits_debug_fsrc),	// core.scala:111:32
    .io_dis_uops_1_bits_debug_tsrc
      (_dispatcher_io_dis_uops_2_1_bits_debug_tsrc),	// core.scala:111:32
    .io_dis_uops_2_valid                       (_dispatcher_io_dis_uops_2_2_valid),	// core.scala:111:32
    .io_dis_uops_2_bits_uopc                   (_dispatcher_io_dis_uops_2_2_bits_uopc),	// core.scala:111:32
    .io_dis_uops_2_bits_inst                   (_dispatcher_io_dis_uops_2_2_bits_inst),	// core.scala:111:32
    .io_dis_uops_2_bits_debug_inst
      (_dispatcher_io_dis_uops_2_2_bits_debug_inst),	// core.scala:111:32
    .io_dis_uops_2_bits_is_rvc                 (_dispatcher_io_dis_uops_2_2_bits_is_rvc),	// core.scala:111:32
    .io_dis_uops_2_bits_debug_pc
      (_dispatcher_io_dis_uops_2_2_bits_debug_pc),	// core.scala:111:32
    .io_dis_uops_2_bits_iq_type                (_dispatcher_io_dis_uops_2_2_bits_iq_type),	// core.scala:111:32
    .io_dis_uops_2_bits_fu_code                (_dispatcher_io_dis_uops_2_2_bits_fu_code),	// core.scala:111:32
    .io_dis_uops_2_bits_is_br                  (_dispatcher_io_dis_uops_2_2_bits_is_br),	// core.scala:111:32
    .io_dis_uops_2_bits_is_jalr                (_dispatcher_io_dis_uops_2_2_bits_is_jalr),	// core.scala:111:32
    .io_dis_uops_2_bits_is_jal                 (_dispatcher_io_dis_uops_2_2_bits_is_jal),	// core.scala:111:32
    .io_dis_uops_2_bits_is_sfb                 (_dispatcher_io_dis_uops_2_2_bits_is_sfb),	// core.scala:111:32
    .io_dis_uops_2_bits_br_mask                (_dispatcher_io_dis_uops_2_2_bits_br_mask),	// core.scala:111:32
    .io_dis_uops_2_bits_br_tag                 (_dispatcher_io_dis_uops_2_2_bits_br_tag),	// core.scala:111:32
    .io_dis_uops_2_bits_ftq_idx                (_dispatcher_io_dis_uops_2_2_bits_ftq_idx),	// core.scala:111:32
    .io_dis_uops_2_bits_edge_inst
      (_dispatcher_io_dis_uops_2_2_bits_edge_inst),	// core.scala:111:32
    .io_dis_uops_2_bits_pc_lob                 (_dispatcher_io_dis_uops_2_2_bits_pc_lob),	// core.scala:111:32
    .io_dis_uops_2_bits_taken                  (_dispatcher_io_dis_uops_2_2_bits_taken),	// core.scala:111:32
    .io_dis_uops_2_bits_imm_packed
      (_dispatcher_io_dis_uops_2_2_bits_imm_packed),	// core.scala:111:32
    .io_dis_uops_2_bits_csr_addr
      (_dispatcher_io_dis_uops_2_2_bits_csr_addr),	// core.scala:111:32
    .io_dis_uops_2_bits_rob_idx                (_dispatcher_io_dis_uops_2_2_bits_rob_idx),	// core.scala:111:32
    .io_dis_uops_2_bits_ldq_idx                (_dispatcher_io_dis_uops_2_2_bits_ldq_idx),	// core.scala:111:32
    .io_dis_uops_2_bits_stq_idx                (_dispatcher_io_dis_uops_2_2_bits_stq_idx),	// core.scala:111:32
    .io_dis_uops_2_bits_rxq_idx                (_dispatcher_io_dis_uops_2_2_bits_rxq_idx),	// core.scala:111:32
    .io_dis_uops_2_bits_pdst                   (_dispatcher_io_dis_uops_2_2_bits_pdst),	// core.scala:111:32
    .io_dis_uops_2_bits_prs1                   (_dispatcher_io_dis_uops_2_2_bits_prs1),	// core.scala:111:32
    .io_dis_uops_2_bits_prs2                   (_dispatcher_io_dis_uops_2_2_bits_prs2),	// core.scala:111:32
    .io_dis_uops_2_bits_prs3                   (_dispatcher_io_dis_uops_2_2_bits_prs3),	// core.scala:111:32
    .io_dis_uops_2_bits_prs1_busy
      (_dispatcher_io_dis_uops_2_2_bits_prs1_busy),	// core.scala:111:32
    .io_dis_uops_2_bits_prs2_busy
      (_dispatcher_io_dis_uops_2_2_bits_prs2_busy),	// core.scala:111:32
    .io_dis_uops_2_bits_prs3_busy
      (_dispatcher_io_dis_uops_2_2_bits_prs3_busy),	// core.scala:111:32
    .io_dis_uops_2_bits_stale_pdst
      (_dispatcher_io_dis_uops_2_2_bits_stale_pdst),	// core.scala:111:32
    .io_dis_uops_2_bits_exception
      (_dispatcher_io_dis_uops_2_2_bits_exception),	// core.scala:111:32
    .io_dis_uops_2_bits_exc_cause
      (_dispatcher_io_dis_uops_2_2_bits_exc_cause),	// core.scala:111:32
    .io_dis_uops_2_bits_bypassable
      (_dispatcher_io_dis_uops_2_2_bits_bypassable),	// core.scala:111:32
    .io_dis_uops_2_bits_mem_cmd                (_dispatcher_io_dis_uops_2_2_bits_mem_cmd),	// core.scala:111:32
    .io_dis_uops_2_bits_mem_size
      (_dispatcher_io_dis_uops_2_2_bits_mem_size),	// core.scala:111:32
    .io_dis_uops_2_bits_mem_signed
      (_dispatcher_io_dis_uops_2_2_bits_mem_signed),	// core.scala:111:32
    .io_dis_uops_2_bits_is_fence
      (_dispatcher_io_dis_uops_2_2_bits_is_fence),	// core.scala:111:32
    .io_dis_uops_2_bits_is_fencei
      (_dispatcher_io_dis_uops_2_2_bits_is_fencei),	// core.scala:111:32
    .io_dis_uops_2_bits_is_amo                 (_dispatcher_io_dis_uops_2_2_bits_is_amo),	// core.scala:111:32
    .io_dis_uops_2_bits_uses_ldq
      (_dispatcher_io_dis_uops_2_2_bits_uses_ldq),	// core.scala:111:32
    .io_dis_uops_2_bits_uses_stq
      (_dispatcher_io_dis_uops_2_2_bits_uses_stq),	// core.scala:111:32
    .io_dis_uops_2_bits_is_sys_pc2epc
      (_dispatcher_io_dis_uops_2_2_bits_is_sys_pc2epc),	// core.scala:111:32
    .io_dis_uops_2_bits_is_unique
      (_dispatcher_io_dis_uops_2_2_bits_is_unique),	// core.scala:111:32
    .io_dis_uops_2_bits_flush_on_commit
      (_dispatcher_io_dis_uops_2_2_bits_flush_on_commit),	// core.scala:111:32
    .io_dis_uops_2_bits_ldst_is_rs1
      (_dispatcher_io_dis_uops_2_2_bits_ldst_is_rs1),	// core.scala:111:32
    .io_dis_uops_2_bits_ldst                   (_dispatcher_io_dis_uops_2_2_bits_ldst),	// core.scala:111:32
    .io_dis_uops_2_bits_lrs1                   (_dispatcher_io_dis_uops_2_2_bits_lrs1),	// core.scala:111:32
    .io_dis_uops_2_bits_lrs2                   (_dispatcher_io_dis_uops_2_2_bits_lrs2),	// core.scala:111:32
    .io_dis_uops_2_bits_lrs3                   (_dispatcher_io_dis_uops_2_2_bits_lrs3),	// core.scala:111:32
    .io_dis_uops_2_bits_ldst_val
      (_dispatcher_io_dis_uops_2_2_bits_ldst_val),	// core.scala:111:32
    .io_dis_uops_2_bits_dst_rtype
      (_dispatcher_io_dis_uops_2_2_bits_dst_rtype),	// core.scala:111:32
    .io_dis_uops_2_bits_lrs1_rtype
      (_dispatcher_io_dis_uops_2_2_bits_lrs1_rtype),	// core.scala:111:32
    .io_dis_uops_2_bits_lrs2_rtype
      (_dispatcher_io_dis_uops_2_2_bits_lrs2_rtype),	// core.scala:111:32
    .io_dis_uops_2_bits_frs3_en                (_dispatcher_io_dis_uops_2_2_bits_frs3_en),	// core.scala:111:32
    .io_dis_uops_2_bits_fp_val                 (_dispatcher_io_dis_uops_2_2_bits_fp_val),	// core.scala:111:32
    .io_dis_uops_2_bits_fp_single
      (_dispatcher_io_dis_uops_2_2_bits_fp_single),	// core.scala:111:32
    .io_dis_uops_2_bits_xcpt_pf_if
      (_dispatcher_io_dis_uops_2_2_bits_xcpt_pf_if),	// core.scala:111:32
    .io_dis_uops_2_bits_xcpt_ae_if
      (_dispatcher_io_dis_uops_2_2_bits_xcpt_ae_if),	// core.scala:111:32
    .io_dis_uops_2_bits_xcpt_ma_if
      (_dispatcher_io_dis_uops_2_2_bits_xcpt_ma_if),	// core.scala:111:32
    .io_dis_uops_2_bits_bp_debug_if
      (_dispatcher_io_dis_uops_2_2_bits_bp_debug_if),	// core.scala:111:32
    .io_dis_uops_2_bits_bp_xcpt_if
      (_dispatcher_io_dis_uops_2_2_bits_bp_xcpt_if),	// core.scala:111:32
    .io_dis_uops_2_bits_debug_fsrc
      (_dispatcher_io_dis_uops_2_2_bits_debug_fsrc),	// core.scala:111:32
    .io_dis_uops_2_bits_debug_tsrc
      (_dispatcher_io_dis_uops_2_2_bits_debug_tsrc),	// core.scala:111:32
    .io_ll_wports_0_valid                      (_mem_units_0_io_ll_fresp_valid),	// execution-units.scala:108:30
    .io_ll_wports_0_bits_uop_uopc              (_mem_units_0_io_ll_fresp_bits_uop_uopc),	// execution-units.scala:108:30
    .io_ll_wports_0_bits_uop_br_mask
      (_mem_units_0_io_ll_fresp_bits_uop_br_mask),	// execution-units.scala:108:30
    .io_ll_wports_0_bits_uop_rob_idx
      (_mem_units_0_io_ll_fresp_bits_uop_rob_idx),	// execution-units.scala:108:30
    .io_ll_wports_0_bits_uop_stq_idx
      (_mem_units_0_io_ll_fresp_bits_uop_stq_idx),	// execution-units.scala:108:30
    .io_ll_wports_0_bits_uop_pdst              (_mem_units_0_io_ll_fresp_bits_uop_pdst),	// execution-units.scala:108:30
    .io_ll_wports_0_bits_uop_mem_size
      (_mem_units_0_io_ll_fresp_bits_uop_mem_size),	// execution-units.scala:108:30
    .io_ll_wports_0_bits_uop_is_amo            (_mem_units_0_io_ll_fresp_bits_uop_is_amo),	// execution-units.scala:108:30
    .io_ll_wports_0_bits_uop_uses_stq
      (_mem_units_0_io_ll_fresp_bits_uop_uses_stq),	// execution-units.scala:108:30
    .io_ll_wports_0_bits_uop_dst_rtype
      (_mem_units_0_io_ll_fresp_bits_uop_dst_rtype),	// execution-units.scala:108:30
    .io_ll_wports_0_bits_uop_fp_val            (_mem_units_0_io_ll_fresp_bits_uop_fp_val),	// execution-units.scala:108:30
    .io_ll_wports_0_bits_data                  (_mem_units_0_io_ll_fresp_bits_data),	// execution-units.scala:108:30
    .io_from_int_valid                         (_csr_exe_unit_io_ll_fresp_valid),	// execution-units.scala:119:32
    .io_from_int_bits_uop_uopc                 (_csr_exe_unit_io_ll_fresp_bits_uop_uopc),	// execution-units.scala:119:32
    .io_from_int_bits_uop_br_mask
      (_csr_exe_unit_io_ll_fresp_bits_uop_br_mask),	// execution-units.scala:119:32
    .io_from_int_bits_uop_rob_idx
      (_csr_exe_unit_io_ll_fresp_bits_uop_rob_idx),	// execution-units.scala:119:32
    .io_from_int_bits_uop_stq_idx
      (_csr_exe_unit_io_ll_fresp_bits_uop_stq_idx),	// execution-units.scala:119:32
    .io_from_int_bits_uop_pdst                 (_csr_exe_unit_io_ll_fresp_bits_uop_pdst),	// execution-units.scala:119:32
    .io_from_int_bits_uop_is_amo
      (_csr_exe_unit_io_ll_fresp_bits_uop_is_amo),	// execution-units.scala:119:32
    .io_from_int_bits_uop_uses_stq
      (_csr_exe_unit_io_ll_fresp_bits_uop_uses_stq),	// execution-units.scala:119:32
    .io_from_int_bits_uop_dst_rtype
      (_csr_exe_unit_io_ll_fresp_bits_uop_dst_rtype),	// execution-units.scala:119:32
    .io_from_int_bits_uop_fp_val
      (_csr_exe_unit_io_ll_fresp_bits_uop_fp_val),	// execution-units.scala:119:32
    .io_from_int_bits_data                     (_csr_exe_unit_io_ll_fresp_bits_data),	// execution-units.scala:119:32
    .io_from_int_bits_predicated
      (_csr_exe_unit_io_ll_fresp_bits_predicated),	// execution-units.scala:119:32
    .io_from_int_bits_fflags_valid
      (_csr_exe_unit_io_ll_fresp_bits_fflags_valid),	// execution-units.scala:119:32
    .io_from_int_bits_fflags_bits_uop_rob_idx
      (_csr_exe_unit_io_ll_fresp_bits_fflags_bits_uop_rob_idx),	// execution-units.scala:119:32
    .io_from_int_bits_fflags_bits_flags
      (_csr_exe_unit_io_ll_fresp_bits_fflags_bits_flags),	// execution-units.scala:119:32
    .io_to_sdq_ready                           (io_lsu_fp_stdata_ready),
    .io_to_int_ready                           (_ll_wbarb_io_in_1_ready),	// core.scala:129:32
    .io_dis_uops_0_ready                       (_fp_pipeline_io_dis_uops_0_ready),
    .io_dis_uops_1_ready                       (_fp_pipeline_io_dis_uops_1_ready),
    .io_dis_uops_2_ready                       (_fp_pipeline_io_dis_uops_2_ready),
    .io_from_int_ready                         (_fp_pipeline_io_from_int_ready),
    .io_to_sdq_valid                           (io_lsu_fp_stdata_valid),
    .io_to_sdq_bits_uop_br_mask                (io_lsu_fp_stdata_bits_uop_br_mask),
    .io_to_sdq_bits_uop_rob_idx                (io_lsu_fp_stdata_bits_uop_rob_idx),
    .io_to_sdq_bits_uop_stq_idx                (io_lsu_fp_stdata_bits_uop_stq_idx),
    .io_to_sdq_bits_data                       (io_lsu_fp_stdata_bits_data),
    .io_to_int_valid                           (_fp_pipeline_io_to_int_valid),
    .io_to_int_bits_uop_rob_idx                (_fp_pipeline_io_to_int_bits_uop_rob_idx),
    .io_to_int_bits_uop_pdst                   (_fp_pipeline_io_to_int_bits_uop_pdst),
    .io_to_int_bits_uop_is_amo                 (_fp_pipeline_io_to_int_bits_uop_is_amo),
    .io_to_int_bits_uop_uses_stq               (_fp_pipeline_io_to_int_bits_uop_uses_stq),
    .io_to_int_bits_uop_dst_rtype
      (_fp_pipeline_io_to_int_bits_uop_dst_rtype),
    .io_to_int_bits_data                       (_fp_pipeline_io_to_int_bits_data),
    .io_to_int_bits_predicated                 (_fp_pipeline_io_to_int_bits_predicated),
    .io_wakeups_0_valid                        (_fp_pipeline_io_wakeups_0_valid),
    .io_wakeups_0_bits_uop_rob_idx
      (_fp_pipeline_io_wakeups_0_bits_uop_rob_idx),
    .io_wakeups_0_bits_uop_pdst                (_fp_pipeline_io_wakeups_0_bits_uop_pdst),
    .io_wakeups_0_bits_uop_dst_rtype
      (_fp_pipeline_io_wakeups_0_bits_uop_dst_rtype),
    .io_wakeups_0_bits_uop_fp_val
      (_fp_pipeline_io_wakeups_0_bits_uop_fp_val),
    .io_wakeups_0_bits_predicated
      (_fp_pipeline_io_wakeups_0_bits_predicated),
    .io_wakeups_0_bits_fflags_valid
      (_fp_pipeline_io_wakeups_0_bits_fflags_valid),
    .io_wakeups_0_bits_fflags_bits_uop_rob_idx
      (_fp_pipeline_io_wakeups_0_bits_fflags_bits_uop_rob_idx),
    .io_wakeups_0_bits_fflags_bits_flags
      (_fp_pipeline_io_wakeups_0_bits_fflags_bits_flags),
    .io_wakeups_1_valid                        (_fp_pipeline_io_wakeups_1_valid),
    .io_wakeups_1_bits_uop_rob_idx
      (_fp_pipeline_io_wakeups_1_bits_uop_rob_idx),
    .io_wakeups_1_bits_uop_pdst                (_fp_pipeline_io_wakeups_1_bits_uop_pdst),
    .io_wakeups_1_bits_uop_dst_rtype
      (_fp_pipeline_io_wakeups_1_bits_uop_dst_rtype),
    .io_wakeups_1_bits_uop_fp_val
      (_fp_pipeline_io_wakeups_1_bits_uop_fp_val),
    .io_wakeups_1_bits_fflags_valid
      (_fp_pipeline_io_wakeups_1_bits_fflags_valid),
    .io_wakeups_1_bits_fflags_bits_uop_rob_idx
      (_fp_pipeline_io_wakeups_1_bits_fflags_bits_uop_rob_idx),
    .io_wakeups_1_bits_fflags_bits_flags
      (_fp_pipeline_io_wakeups_1_bits_fflags_bits_flags)
  );
  DecodeUnit_4 decode_units_0 (	// core.scala:98:79
    .io_enq_uop_inst              (io_ifu_fetchpacket_bits_uops_0_bits_inst),
    .io_enq_uop_debug_inst        (io_ifu_fetchpacket_bits_uops_0_bits_debug_inst),
    .io_enq_uop_is_rvc            (io_ifu_fetchpacket_bits_uops_0_bits_is_rvc),
    .io_enq_uop_debug_pc          (io_ifu_fetchpacket_bits_uops_0_bits_debug_pc),
    .io_enq_uop_ctrl_br_type      (io_ifu_fetchpacket_bits_uops_0_bits_ctrl_br_type),
    .io_enq_uop_ctrl_op1_sel      (io_ifu_fetchpacket_bits_uops_0_bits_ctrl_op1_sel),
    .io_enq_uop_ctrl_op2_sel      (io_ifu_fetchpacket_bits_uops_0_bits_ctrl_op2_sel),
    .io_enq_uop_ctrl_imm_sel      (io_ifu_fetchpacket_bits_uops_0_bits_ctrl_imm_sel),
    .io_enq_uop_ctrl_op_fcn       (io_ifu_fetchpacket_bits_uops_0_bits_ctrl_op_fcn),
    .io_enq_uop_ctrl_fcn_dw       (io_ifu_fetchpacket_bits_uops_0_bits_ctrl_fcn_dw),
    .io_enq_uop_ctrl_csr_cmd      (io_ifu_fetchpacket_bits_uops_0_bits_ctrl_csr_cmd),
    .io_enq_uop_ctrl_is_load      (io_ifu_fetchpacket_bits_uops_0_bits_ctrl_is_load),
    .io_enq_uop_ctrl_is_sta       (io_ifu_fetchpacket_bits_uops_0_bits_ctrl_is_sta),
    .io_enq_uop_ctrl_is_std       (io_ifu_fetchpacket_bits_uops_0_bits_ctrl_is_std),
    .io_enq_uop_iw_state          (io_ifu_fetchpacket_bits_uops_0_bits_iw_state),
    .io_enq_uop_iw_p1_poisoned    (io_ifu_fetchpacket_bits_uops_0_bits_iw_p1_poisoned),
    .io_enq_uop_iw_p2_poisoned    (io_ifu_fetchpacket_bits_uops_0_bits_iw_p2_poisoned),
    .io_enq_uop_is_sfb            (io_ifu_fetchpacket_bits_uops_0_bits_is_sfb),
    .io_enq_uop_ftq_idx           (io_ifu_fetchpacket_bits_uops_0_bits_ftq_idx),
    .io_enq_uop_edge_inst         (io_ifu_fetchpacket_bits_uops_0_bits_edge_inst),
    .io_enq_uop_pc_lob            (io_ifu_fetchpacket_bits_uops_0_bits_pc_lob),
    .io_enq_uop_taken             (io_ifu_fetchpacket_bits_uops_0_bits_taken),
    .io_enq_uop_csr_addr          (io_ifu_fetchpacket_bits_uops_0_bits_csr_addr),
    .io_enq_uop_rxq_idx           (io_ifu_fetchpacket_bits_uops_0_bits_rxq_idx),
    .io_enq_uop_xcpt_pf_if        (io_ifu_fetchpacket_bits_uops_0_bits_xcpt_pf_if),
    .io_enq_uop_xcpt_ae_if        (io_ifu_fetchpacket_bits_uops_0_bits_xcpt_ae_if),
    .io_enq_uop_xcpt_ma_if        (io_ifu_fetchpacket_bits_uops_0_bits_xcpt_ma_if),
    .io_enq_uop_bp_debug_if       (io_ifu_fetchpacket_bits_uops_0_bits_bp_debug_if),
    .io_enq_uop_bp_xcpt_if        (io_ifu_fetchpacket_bits_uops_0_bits_bp_xcpt_if),
    .io_enq_uop_debug_fsrc        (io_ifu_fetchpacket_bits_uops_0_bits_debug_fsrc),
    .io_enq_uop_debug_tsrc        (io_ifu_fetchpacket_bits_uops_0_bits_debug_tsrc),
    .io_status_isa                (_csr_io_status_isa),	// core.scala:268:19
    .io_csr_decode_fp_illegal     (_csr_io_decode_0_fp_illegal),	// core.scala:268:19
    .io_csr_decode_read_illegal   (_csr_io_decode_0_read_illegal),	// core.scala:268:19
    .io_csr_decode_write_illegal  (_csr_io_decode_0_write_illegal),	// core.scala:268:19
    .io_csr_decode_write_flush    (_csr_io_decode_0_write_flush),	// core.scala:268:19
    .io_csr_decode_system_illegal (_csr_io_decode_0_system_illegal),	// core.scala:268:19
    .io_interrupt                 (_csr_io_interrupt),	// core.scala:268:19
    .io_interrupt_cause           (_csr_io_interrupt_cause),	// core.scala:268:19
    .io_deq_uop_uopc              (_decode_units_0_io_deq_uop_uopc),
    .io_deq_uop_inst              (_decode_units_0_io_deq_uop_inst),
    .io_deq_uop_debug_inst        (_decode_units_0_io_deq_uop_debug_inst),
    .io_deq_uop_is_rvc            (_decode_units_0_io_deq_uop_is_rvc),
    .io_deq_uop_debug_pc          (_decode_units_0_io_deq_uop_debug_pc),
    .io_deq_uop_iq_type           (_decode_units_0_io_deq_uop_iq_type),
    .io_deq_uop_fu_code           (_decode_units_0_io_deq_uop_fu_code),
    .io_deq_uop_ctrl_br_type      (_decode_units_0_io_deq_uop_ctrl_br_type),
    .io_deq_uop_ctrl_op1_sel      (_decode_units_0_io_deq_uop_ctrl_op1_sel),
    .io_deq_uop_ctrl_op2_sel      (_decode_units_0_io_deq_uop_ctrl_op2_sel),
    .io_deq_uop_ctrl_imm_sel      (_decode_units_0_io_deq_uop_ctrl_imm_sel),
    .io_deq_uop_ctrl_op_fcn       (_decode_units_0_io_deq_uop_ctrl_op_fcn),
    .io_deq_uop_ctrl_fcn_dw       (_decode_units_0_io_deq_uop_ctrl_fcn_dw),
    .io_deq_uop_ctrl_csr_cmd      (_decode_units_0_io_deq_uop_ctrl_csr_cmd),
    .io_deq_uop_ctrl_is_load      (_decode_units_0_io_deq_uop_ctrl_is_load),
    .io_deq_uop_ctrl_is_sta       (_decode_units_0_io_deq_uop_ctrl_is_sta),
    .io_deq_uop_ctrl_is_std       (_decode_units_0_io_deq_uop_ctrl_is_std),
    .io_deq_uop_iw_state          (_decode_units_0_io_deq_uop_iw_state),
    .io_deq_uop_iw_p1_poisoned    (_decode_units_0_io_deq_uop_iw_p1_poisoned),
    .io_deq_uop_iw_p2_poisoned    (_decode_units_0_io_deq_uop_iw_p2_poisoned),
    .io_deq_uop_is_br             (_decode_units_0_io_deq_uop_is_br),
    .io_deq_uop_is_jalr           (_decode_units_0_io_deq_uop_is_jalr),
    .io_deq_uop_is_jal            (_decode_units_0_io_deq_uop_is_jal),
    .io_deq_uop_is_sfb            (_decode_units_0_io_deq_uop_is_sfb),
    .io_deq_uop_ftq_idx           (_decode_units_0_io_deq_uop_ftq_idx),
    .io_deq_uop_edge_inst         (_decode_units_0_io_deq_uop_edge_inst),
    .io_deq_uop_pc_lob            (_decode_units_0_io_deq_uop_pc_lob),
    .io_deq_uop_taken             (_decode_units_0_io_deq_uop_taken),
    .io_deq_uop_imm_packed        (_decode_units_0_io_deq_uop_imm_packed),
    .io_deq_uop_csr_addr          (_decode_units_0_io_deq_uop_csr_addr),
    .io_deq_uop_rxq_idx           (_decode_units_0_io_deq_uop_rxq_idx),
    .io_deq_uop_exception         (_decode_units_0_io_deq_uop_exception),
    .io_deq_uop_exc_cause         (_decode_units_0_io_deq_uop_exc_cause),
    .io_deq_uop_bypassable        (_decode_units_0_io_deq_uop_bypassable),
    .io_deq_uop_mem_cmd           (_decode_units_0_io_deq_uop_mem_cmd),
    .io_deq_uop_mem_size          (_decode_units_0_io_deq_uop_mem_size),
    .io_deq_uop_mem_signed        (_decode_units_0_io_deq_uop_mem_signed),
    .io_deq_uop_is_fence          (_decode_units_0_io_deq_uop_is_fence),
    .io_deq_uop_is_fencei         (_decode_units_0_io_deq_uop_is_fencei),
    .io_deq_uop_is_amo            (_decode_units_0_io_deq_uop_is_amo),
    .io_deq_uop_uses_ldq          (_decode_units_0_io_deq_uop_uses_ldq),
    .io_deq_uop_uses_stq          (_decode_units_0_io_deq_uop_uses_stq),
    .io_deq_uop_is_sys_pc2epc     (_decode_units_0_io_deq_uop_is_sys_pc2epc),
    .io_deq_uop_is_unique         (_decode_units_0_io_deq_uop_is_unique),
    .io_deq_uop_flush_on_commit   (_decode_units_0_io_deq_uop_flush_on_commit),
    .io_deq_uop_ldst              (_decode_units_0_io_deq_uop_ldst),
    .io_deq_uop_lrs1              (_decode_units_0_io_deq_uop_lrs1),
    .io_deq_uop_lrs2              (_decode_units_0_io_deq_uop_lrs2),
    .io_deq_uop_lrs3              (_decode_units_0_io_deq_uop_lrs3),
    .io_deq_uop_ldst_val          (_decode_units_0_io_deq_uop_ldst_val),
    .io_deq_uop_dst_rtype         (_decode_units_0_io_deq_uop_dst_rtype),
    .io_deq_uop_lrs1_rtype        (_decode_units_0_io_deq_uop_lrs1_rtype),
    .io_deq_uop_lrs2_rtype        (_decode_units_0_io_deq_uop_lrs2_rtype),
    .io_deq_uop_frs3_en           (_decode_units_0_io_deq_uop_frs3_en),
    .io_deq_uop_fp_val            (_decode_units_0_io_deq_uop_fp_val),
    .io_deq_uop_fp_single         (_decode_units_0_io_deq_uop_fp_single),
    .io_deq_uop_xcpt_pf_if        (_decode_units_0_io_deq_uop_xcpt_pf_if),
    .io_deq_uop_xcpt_ae_if        (_decode_units_0_io_deq_uop_xcpt_ae_if),
    .io_deq_uop_xcpt_ma_if        (_decode_units_0_io_deq_uop_xcpt_ma_if),
    .io_deq_uop_bp_debug_if       (_decode_units_0_io_deq_uop_bp_debug_if),
    .io_deq_uop_bp_xcpt_if        (_decode_units_0_io_deq_uop_bp_xcpt_if),
    .io_deq_uop_debug_fsrc        (_decode_units_0_io_deq_uop_debug_fsrc),
    .io_deq_uop_debug_tsrc        (_decode_units_0_io_deq_uop_debug_tsrc),
    .io_csr_decode_csr            (_decode_units_0_io_csr_decode_csr)
  );
  DecodeUnit_4 decode_units_1 (	// core.scala:98:79
    .io_enq_uop_inst              (io_ifu_fetchpacket_bits_uops_1_bits_inst),
    .io_enq_uop_debug_inst        (io_ifu_fetchpacket_bits_uops_1_bits_debug_inst),
    .io_enq_uop_is_rvc            (io_ifu_fetchpacket_bits_uops_1_bits_is_rvc),
    .io_enq_uop_debug_pc          (io_ifu_fetchpacket_bits_uops_1_bits_debug_pc),
    .io_enq_uop_ctrl_br_type      (io_ifu_fetchpacket_bits_uops_1_bits_ctrl_br_type),
    .io_enq_uop_ctrl_op1_sel      (io_ifu_fetchpacket_bits_uops_1_bits_ctrl_op1_sel),
    .io_enq_uop_ctrl_op2_sel      (io_ifu_fetchpacket_bits_uops_1_bits_ctrl_op2_sel),
    .io_enq_uop_ctrl_imm_sel      (io_ifu_fetchpacket_bits_uops_1_bits_ctrl_imm_sel),
    .io_enq_uop_ctrl_op_fcn       (io_ifu_fetchpacket_bits_uops_1_bits_ctrl_op_fcn),
    .io_enq_uop_ctrl_fcn_dw       (io_ifu_fetchpacket_bits_uops_1_bits_ctrl_fcn_dw),
    .io_enq_uop_ctrl_csr_cmd      (io_ifu_fetchpacket_bits_uops_1_bits_ctrl_csr_cmd),
    .io_enq_uop_ctrl_is_load      (io_ifu_fetchpacket_bits_uops_1_bits_ctrl_is_load),
    .io_enq_uop_ctrl_is_sta       (io_ifu_fetchpacket_bits_uops_1_bits_ctrl_is_sta),
    .io_enq_uop_ctrl_is_std       (io_ifu_fetchpacket_bits_uops_1_bits_ctrl_is_std),
    .io_enq_uop_iw_state          (io_ifu_fetchpacket_bits_uops_1_bits_iw_state),
    .io_enq_uop_iw_p1_poisoned    (io_ifu_fetchpacket_bits_uops_1_bits_iw_p1_poisoned),
    .io_enq_uop_iw_p2_poisoned    (io_ifu_fetchpacket_bits_uops_1_bits_iw_p2_poisoned),
    .io_enq_uop_is_sfb            (io_ifu_fetchpacket_bits_uops_1_bits_is_sfb),
    .io_enq_uop_ftq_idx           (io_ifu_fetchpacket_bits_uops_1_bits_ftq_idx),
    .io_enq_uop_edge_inst         (io_ifu_fetchpacket_bits_uops_1_bits_edge_inst),
    .io_enq_uop_pc_lob            (io_ifu_fetchpacket_bits_uops_1_bits_pc_lob),
    .io_enq_uop_taken             (io_ifu_fetchpacket_bits_uops_1_bits_taken),
    .io_enq_uop_csr_addr          (io_ifu_fetchpacket_bits_uops_1_bits_csr_addr),
    .io_enq_uop_rxq_idx           (io_ifu_fetchpacket_bits_uops_1_bits_rxq_idx),
    .io_enq_uop_xcpt_pf_if        (io_ifu_fetchpacket_bits_uops_1_bits_xcpt_pf_if),
    .io_enq_uop_xcpt_ae_if        (io_ifu_fetchpacket_bits_uops_1_bits_xcpt_ae_if),
    .io_enq_uop_xcpt_ma_if        (io_ifu_fetchpacket_bits_uops_1_bits_xcpt_ma_if),
    .io_enq_uop_bp_debug_if       (io_ifu_fetchpacket_bits_uops_1_bits_bp_debug_if),
    .io_enq_uop_bp_xcpt_if        (io_ifu_fetchpacket_bits_uops_1_bits_bp_xcpt_if),
    .io_enq_uop_debug_fsrc        (io_ifu_fetchpacket_bits_uops_1_bits_debug_fsrc),
    .io_enq_uop_debug_tsrc        (io_ifu_fetchpacket_bits_uops_1_bits_debug_tsrc),
    .io_status_isa                (_csr_io_status_isa),	// core.scala:268:19
    .io_csr_decode_fp_illegal     (_csr_io_decode_1_fp_illegal),	// core.scala:268:19
    .io_csr_decode_read_illegal   (_csr_io_decode_1_read_illegal),	// core.scala:268:19
    .io_csr_decode_write_illegal  (_csr_io_decode_1_write_illegal),	// core.scala:268:19
    .io_csr_decode_write_flush    (_csr_io_decode_1_write_flush),	// core.scala:268:19
    .io_csr_decode_system_illegal (_csr_io_decode_1_system_illegal),	// core.scala:268:19
    .io_interrupt                 (_csr_io_interrupt),	// core.scala:268:19
    .io_interrupt_cause           (_csr_io_interrupt_cause),	// core.scala:268:19
    .io_deq_uop_uopc              (_decode_units_1_io_deq_uop_uopc),
    .io_deq_uop_inst              (_decode_units_1_io_deq_uop_inst),
    .io_deq_uop_debug_inst        (_decode_units_1_io_deq_uop_debug_inst),
    .io_deq_uop_is_rvc            (_decode_units_1_io_deq_uop_is_rvc),
    .io_deq_uop_debug_pc          (_decode_units_1_io_deq_uop_debug_pc),
    .io_deq_uop_iq_type           (_decode_units_1_io_deq_uop_iq_type),
    .io_deq_uop_fu_code           (_decode_units_1_io_deq_uop_fu_code),
    .io_deq_uop_ctrl_br_type      (_decode_units_1_io_deq_uop_ctrl_br_type),
    .io_deq_uop_ctrl_op1_sel      (_decode_units_1_io_deq_uop_ctrl_op1_sel),
    .io_deq_uop_ctrl_op2_sel      (_decode_units_1_io_deq_uop_ctrl_op2_sel),
    .io_deq_uop_ctrl_imm_sel      (_decode_units_1_io_deq_uop_ctrl_imm_sel),
    .io_deq_uop_ctrl_op_fcn       (_decode_units_1_io_deq_uop_ctrl_op_fcn),
    .io_deq_uop_ctrl_fcn_dw       (_decode_units_1_io_deq_uop_ctrl_fcn_dw),
    .io_deq_uop_ctrl_csr_cmd      (_decode_units_1_io_deq_uop_ctrl_csr_cmd),
    .io_deq_uop_ctrl_is_load      (_decode_units_1_io_deq_uop_ctrl_is_load),
    .io_deq_uop_ctrl_is_sta       (_decode_units_1_io_deq_uop_ctrl_is_sta),
    .io_deq_uop_ctrl_is_std       (_decode_units_1_io_deq_uop_ctrl_is_std),
    .io_deq_uop_iw_state          (_decode_units_1_io_deq_uop_iw_state),
    .io_deq_uop_iw_p1_poisoned    (_decode_units_1_io_deq_uop_iw_p1_poisoned),
    .io_deq_uop_iw_p2_poisoned    (_decode_units_1_io_deq_uop_iw_p2_poisoned),
    .io_deq_uop_is_br             (_decode_units_1_io_deq_uop_is_br),
    .io_deq_uop_is_jalr           (_decode_units_1_io_deq_uop_is_jalr),
    .io_deq_uop_is_jal            (_decode_units_1_io_deq_uop_is_jal),
    .io_deq_uop_is_sfb            (_decode_units_1_io_deq_uop_is_sfb),
    .io_deq_uop_ftq_idx           (_decode_units_1_io_deq_uop_ftq_idx),
    .io_deq_uop_edge_inst         (_decode_units_1_io_deq_uop_edge_inst),
    .io_deq_uop_pc_lob            (_decode_units_1_io_deq_uop_pc_lob),
    .io_deq_uop_taken             (_decode_units_1_io_deq_uop_taken),
    .io_deq_uop_imm_packed        (_decode_units_1_io_deq_uop_imm_packed),
    .io_deq_uop_csr_addr          (_decode_units_1_io_deq_uop_csr_addr),
    .io_deq_uop_rxq_idx           (_decode_units_1_io_deq_uop_rxq_idx),
    .io_deq_uop_exception         (_decode_units_1_io_deq_uop_exception),
    .io_deq_uop_exc_cause         (_decode_units_1_io_deq_uop_exc_cause),
    .io_deq_uop_bypassable        (_decode_units_1_io_deq_uop_bypassable),
    .io_deq_uop_mem_cmd           (_decode_units_1_io_deq_uop_mem_cmd),
    .io_deq_uop_mem_size          (_decode_units_1_io_deq_uop_mem_size),
    .io_deq_uop_mem_signed        (_decode_units_1_io_deq_uop_mem_signed),
    .io_deq_uop_is_fence          (_decode_units_1_io_deq_uop_is_fence),
    .io_deq_uop_is_fencei         (_decode_units_1_io_deq_uop_is_fencei),
    .io_deq_uop_is_amo            (_decode_units_1_io_deq_uop_is_amo),
    .io_deq_uop_uses_ldq          (_decode_units_1_io_deq_uop_uses_ldq),
    .io_deq_uop_uses_stq          (_decode_units_1_io_deq_uop_uses_stq),
    .io_deq_uop_is_sys_pc2epc     (_decode_units_1_io_deq_uop_is_sys_pc2epc),
    .io_deq_uop_is_unique         (_decode_units_1_io_deq_uop_is_unique),
    .io_deq_uop_flush_on_commit   (_decode_units_1_io_deq_uop_flush_on_commit),
    .io_deq_uop_ldst              (_decode_units_1_io_deq_uop_ldst),
    .io_deq_uop_lrs1              (_decode_units_1_io_deq_uop_lrs1),
    .io_deq_uop_lrs2              (_decode_units_1_io_deq_uop_lrs2),
    .io_deq_uop_lrs3              (_decode_units_1_io_deq_uop_lrs3),
    .io_deq_uop_ldst_val          (_decode_units_1_io_deq_uop_ldst_val),
    .io_deq_uop_dst_rtype         (_decode_units_1_io_deq_uop_dst_rtype),
    .io_deq_uop_lrs1_rtype        (_decode_units_1_io_deq_uop_lrs1_rtype),
    .io_deq_uop_lrs2_rtype        (_decode_units_1_io_deq_uop_lrs2_rtype),
    .io_deq_uop_frs3_en           (_decode_units_1_io_deq_uop_frs3_en),
    .io_deq_uop_fp_val            (_decode_units_1_io_deq_uop_fp_val),
    .io_deq_uop_fp_single         (_decode_units_1_io_deq_uop_fp_single),
    .io_deq_uop_xcpt_pf_if        (_decode_units_1_io_deq_uop_xcpt_pf_if),
    .io_deq_uop_xcpt_ae_if        (_decode_units_1_io_deq_uop_xcpt_ae_if),
    .io_deq_uop_xcpt_ma_if        (_decode_units_1_io_deq_uop_xcpt_ma_if),
    .io_deq_uop_bp_debug_if       (_decode_units_1_io_deq_uop_bp_debug_if),
    .io_deq_uop_bp_xcpt_if        (_decode_units_1_io_deq_uop_bp_xcpt_if),
    .io_deq_uop_debug_fsrc        (_decode_units_1_io_deq_uop_debug_fsrc),
    .io_deq_uop_debug_tsrc        (_decode_units_1_io_deq_uop_debug_tsrc),
    .io_csr_decode_csr            (_decode_units_1_io_csr_decode_csr)
  );
  DecodeUnit_4 decode_units_2 (	// core.scala:98:79
    .io_enq_uop_inst              (io_ifu_fetchpacket_bits_uops_2_bits_inst),
    .io_enq_uop_debug_inst        (io_ifu_fetchpacket_bits_uops_2_bits_debug_inst),
    .io_enq_uop_is_rvc            (io_ifu_fetchpacket_bits_uops_2_bits_is_rvc),
    .io_enq_uop_debug_pc          (io_ifu_fetchpacket_bits_uops_2_bits_debug_pc),
    .io_enq_uop_ctrl_br_type      (io_ifu_fetchpacket_bits_uops_2_bits_ctrl_br_type),
    .io_enq_uop_ctrl_op1_sel      (io_ifu_fetchpacket_bits_uops_2_bits_ctrl_op1_sel),
    .io_enq_uop_ctrl_op2_sel      (io_ifu_fetchpacket_bits_uops_2_bits_ctrl_op2_sel),
    .io_enq_uop_ctrl_imm_sel      (io_ifu_fetchpacket_bits_uops_2_bits_ctrl_imm_sel),
    .io_enq_uop_ctrl_op_fcn       (io_ifu_fetchpacket_bits_uops_2_bits_ctrl_op_fcn),
    .io_enq_uop_ctrl_fcn_dw       (io_ifu_fetchpacket_bits_uops_2_bits_ctrl_fcn_dw),
    .io_enq_uop_ctrl_csr_cmd      (io_ifu_fetchpacket_bits_uops_2_bits_ctrl_csr_cmd),
    .io_enq_uop_ctrl_is_load      (io_ifu_fetchpacket_bits_uops_2_bits_ctrl_is_load),
    .io_enq_uop_ctrl_is_sta       (io_ifu_fetchpacket_bits_uops_2_bits_ctrl_is_sta),
    .io_enq_uop_ctrl_is_std       (io_ifu_fetchpacket_bits_uops_2_bits_ctrl_is_std),
    .io_enq_uop_iw_state          (io_ifu_fetchpacket_bits_uops_2_bits_iw_state),
    .io_enq_uop_iw_p1_poisoned    (io_ifu_fetchpacket_bits_uops_2_bits_iw_p1_poisoned),
    .io_enq_uop_iw_p2_poisoned    (io_ifu_fetchpacket_bits_uops_2_bits_iw_p2_poisoned),
    .io_enq_uop_is_sfb            (io_ifu_fetchpacket_bits_uops_2_bits_is_sfb),
    .io_enq_uop_ftq_idx           (io_ifu_fetchpacket_bits_uops_2_bits_ftq_idx),
    .io_enq_uop_edge_inst         (io_ifu_fetchpacket_bits_uops_2_bits_edge_inst),
    .io_enq_uop_pc_lob            (io_ifu_fetchpacket_bits_uops_2_bits_pc_lob),
    .io_enq_uop_taken             (io_ifu_fetchpacket_bits_uops_2_bits_taken),
    .io_enq_uop_csr_addr          (io_ifu_fetchpacket_bits_uops_2_bits_csr_addr),
    .io_enq_uop_rxq_idx           (io_ifu_fetchpacket_bits_uops_2_bits_rxq_idx),
    .io_enq_uop_xcpt_pf_if        (io_ifu_fetchpacket_bits_uops_2_bits_xcpt_pf_if),
    .io_enq_uop_xcpt_ae_if        (io_ifu_fetchpacket_bits_uops_2_bits_xcpt_ae_if),
    .io_enq_uop_xcpt_ma_if        (io_ifu_fetchpacket_bits_uops_2_bits_xcpt_ma_if),
    .io_enq_uop_bp_debug_if       (io_ifu_fetchpacket_bits_uops_2_bits_bp_debug_if),
    .io_enq_uop_bp_xcpt_if        (io_ifu_fetchpacket_bits_uops_2_bits_bp_xcpt_if),
    .io_enq_uop_debug_fsrc        (io_ifu_fetchpacket_bits_uops_2_bits_debug_fsrc),
    .io_enq_uop_debug_tsrc        (io_ifu_fetchpacket_bits_uops_2_bits_debug_tsrc),
    .io_status_isa                (_csr_io_status_isa),	// core.scala:268:19
    .io_csr_decode_fp_illegal     (_csr_io_decode_2_fp_illegal),	// core.scala:268:19
    .io_csr_decode_read_illegal   (_csr_io_decode_2_read_illegal),	// core.scala:268:19
    .io_csr_decode_write_illegal  (_csr_io_decode_2_write_illegal),	// core.scala:268:19
    .io_csr_decode_write_flush    (_csr_io_decode_2_write_flush),	// core.scala:268:19
    .io_csr_decode_system_illegal (_csr_io_decode_2_system_illegal),	// core.scala:268:19
    .io_interrupt                 (_csr_io_interrupt),	// core.scala:268:19
    .io_interrupt_cause           (_csr_io_interrupt_cause),	// core.scala:268:19
    .io_deq_uop_uopc              (_decode_units_2_io_deq_uop_uopc),
    .io_deq_uop_inst              (_decode_units_2_io_deq_uop_inst),
    .io_deq_uop_debug_inst        (_decode_units_2_io_deq_uop_debug_inst),
    .io_deq_uop_is_rvc            (_decode_units_2_io_deq_uop_is_rvc),
    .io_deq_uop_debug_pc          (_decode_units_2_io_deq_uop_debug_pc),
    .io_deq_uop_iq_type           (_decode_units_2_io_deq_uop_iq_type),
    .io_deq_uop_fu_code           (_decode_units_2_io_deq_uop_fu_code),
    .io_deq_uop_ctrl_br_type      (_decode_units_2_io_deq_uop_ctrl_br_type),
    .io_deq_uop_ctrl_op1_sel      (_decode_units_2_io_deq_uop_ctrl_op1_sel),
    .io_deq_uop_ctrl_op2_sel      (_decode_units_2_io_deq_uop_ctrl_op2_sel),
    .io_deq_uop_ctrl_imm_sel      (_decode_units_2_io_deq_uop_ctrl_imm_sel),
    .io_deq_uop_ctrl_op_fcn       (_decode_units_2_io_deq_uop_ctrl_op_fcn),
    .io_deq_uop_ctrl_fcn_dw       (_decode_units_2_io_deq_uop_ctrl_fcn_dw),
    .io_deq_uop_ctrl_csr_cmd      (_decode_units_2_io_deq_uop_ctrl_csr_cmd),
    .io_deq_uop_ctrl_is_load      (_decode_units_2_io_deq_uop_ctrl_is_load),
    .io_deq_uop_ctrl_is_sta       (_decode_units_2_io_deq_uop_ctrl_is_sta),
    .io_deq_uop_ctrl_is_std       (_decode_units_2_io_deq_uop_ctrl_is_std),
    .io_deq_uop_iw_state          (_decode_units_2_io_deq_uop_iw_state),
    .io_deq_uop_iw_p1_poisoned    (_decode_units_2_io_deq_uop_iw_p1_poisoned),
    .io_deq_uop_iw_p2_poisoned    (_decode_units_2_io_deq_uop_iw_p2_poisoned),
    .io_deq_uop_is_br             (_decode_units_2_io_deq_uop_is_br),
    .io_deq_uop_is_jalr           (_decode_units_2_io_deq_uop_is_jalr),
    .io_deq_uop_is_jal            (_decode_units_2_io_deq_uop_is_jal),
    .io_deq_uop_is_sfb            (_decode_units_2_io_deq_uop_is_sfb),
    .io_deq_uop_ftq_idx           (_decode_units_2_io_deq_uop_ftq_idx),
    .io_deq_uop_edge_inst         (_decode_units_2_io_deq_uop_edge_inst),
    .io_deq_uop_pc_lob            (_decode_units_2_io_deq_uop_pc_lob),
    .io_deq_uop_taken             (_decode_units_2_io_deq_uop_taken),
    .io_deq_uop_imm_packed        (_decode_units_2_io_deq_uop_imm_packed),
    .io_deq_uop_csr_addr          (_decode_units_2_io_deq_uop_csr_addr),
    .io_deq_uop_rxq_idx           (_decode_units_2_io_deq_uop_rxq_idx),
    .io_deq_uop_exception         (_decode_units_2_io_deq_uop_exception),
    .io_deq_uop_exc_cause         (_decode_units_2_io_deq_uop_exc_cause),
    .io_deq_uop_bypassable        (_decode_units_2_io_deq_uop_bypassable),
    .io_deq_uop_mem_cmd           (_decode_units_2_io_deq_uop_mem_cmd),
    .io_deq_uop_mem_size          (_decode_units_2_io_deq_uop_mem_size),
    .io_deq_uop_mem_signed        (_decode_units_2_io_deq_uop_mem_signed),
    .io_deq_uop_is_fence          (_decode_units_2_io_deq_uop_is_fence),
    .io_deq_uop_is_fencei         (_decode_units_2_io_deq_uop_is_fencei),
    .io_deq_uop_is_amo            (_decode_units_2_io_deq_uop_is_amo),
    .io_deq_uop_uses_ldq          (_decode_units_2_io_deq_uop_uses_ldq),
    .io_deq_uop_uses_stq          (_decode_units_2_io_deq_uop_uses_stq),
    .io_deq_uop_is_sys_pc2epc     (_decode_units_2_io_deq_uop_is_sys_pc2epc),
    .io_deq_uop_is_unique         (_decode_units_2_io_deq_uop_is_unique),
    .io_deq_uop_flush_on_commit   (_decode_units_2_io_deq_uop_flush_on_commit),
    .io_deq_uop_ldst              (_decode_units_2_io_deq_uop_ldst),
    .io_deq_uop_lrs1              (_decode_units_2_io_deq_uop_lrs1),
    .io_deq_uop_lrs2              (_decode_units_2_io_deq_uop_lrs2),
    .io_deq_uop_lrs3              (_decode_units_2_io_deq_uop_lrs3),
    .io_deq_uop_ldst_val          (_decode_units_2_io_deq_uop_ldst_val),
    .io_deq_uop_dst_rtype         (_decode_units_2_io_deq_uop_dst_rtype),
    .io_deq_uop_lrs1_rtype        (_decode_units_2_io_deq_uop_lrs1_rtype),
    .io_deq_uop_lrs2_rtype        (_decode_units_2_io_deq_uop_lrs2_rtype),
    .io_deq_uop_frs3_en           (_decode_units_2_io_deq_uop_frs3_en),
    .io_deq_uop_fp_val            (_decode_units_2_io_deq_uop_fp_val),
    .io_deq_uop_fp_single         (_decode_units_2_io_deq_uop_fp_single),
    .io_deq_uop_xcpt_pf_if        (_decode_units_2_io_deq_uop_xcpt_pf_if),
    .io_deq_uop_xcpt_ae_if        (_decode_units_2_io_deq_uop_xcpt_ae_if),
    .io_deq_uop_xcpt_ma_if        (_decode_units_2_io_deq_uop_xcpt_ma_if),
    .io_deq_uop_bp_debug_if       (_decode_units_2_io_deq_uop_bp_debug_if),
    .io_deq_uop_bp_xcpt_if        (_decode_units_2_io_deq_uop_bp_xcpt_if),
    .io_deq_uop_debug_fsrc        (_decode_units_2_io_deq_uop_debug_fsrc),
    .io_deq_uop_debug_tsrc        (_decode_units_2_io_deq_uop_debug_tsrc),
    .io_csr_decode_csr            (_decode_units_2_io_csr_decode_csr)
  );
  BranchMaskGenerationLogic_1 dec_brmask_logic (	// core.scala:99:32
    .clock                       (clock),
    .reset                       (reset),
    .io_is_branch_0
      (~(dec_finished_mask[0])
       & (_decode_units_0_io_deq_uop_is_br & ~_decode_units_0_io_deq_uop_is_sfb
          | _decode_units_0_io_deq_uop_is_jalr)),	// core.scala:98:79, :490:34, :503:61, :594:{41,63}, micro-op.scala:146:{33,36,45}
    .io_is_branch_1
      (~(dec_finished_mask[1])
       & (_decode_units_1_io_deq_uop_is_br & ~_decode_units_1_io_deq_uop_is_sfb
          | _decode_units_1_io_deq_uop_is_jalr)),	// core.scala:98:79, :490:34, :503:61, :594:{41,63}, micro-op.scala:146:{33,36,45}
    .io_is_branch_2
      (~(dec_finished_mask[2])
       & (_decode_units_2_io_deq_uop_is_br & ~_decode_units_2_io_deq_uop_is_sfb
          | _decode_units_2_io_deq_uop_is_jalr)),	// core.scala:98:79, :490:34, :503:61, :594:{41,63}, micro-op.scala:146:{33,36,45}
    .io_will_fire_0
      (dec_fire_0
       & (_decode_units_0_io_deq_uop_is_br & ~_decode_units_0_io_deq_uop_is_sfb
          | _decode_units_0_io_deq_uop_is_jalr)),	// core.scala:98:79, :576:58, :595:54, micro-op.scala:146:{33,36,45}
    .io_will_fire_1
      (dec_fire_1
       & (_decode_units_1_io_deq_uop_is_br & ~_decode_units_1_io_deq_uop_is_sfb
          | _decode_units_1_io_deq_uop_is_jalr)),	// core.scala:98:79, :576:58, :595:54, micro-op.scala:146:{33,36,45}
    .io_will_fire_2
      (dec_ready
       & (_decode_units_2_io_deq_uop_is_br & ~_decode_units_2_io_deq_uop_is_sfb
          | _decode_units_2_io_deq_uop_is_jalr)),	// core.scala:98:79, :576:58, :595:54, micro-op.scala:146:{33,36,45}
    .io_brupdate_b1_resolve_mask (b1_resolve_mask),	// core.scala:196:72
    .io_brupdate_b2_uop_br_mask  (b2_uop_br_mask),	// core.scala:187:18
    .io_brupdate_b2_mispredict   (b2_mispredict),	// core.scala:187:18
    .io_flush_pipeline           (dec_brmask_logic_io_flush_pipeline_REG),	// core.scala:591:48
    .io_br_tag_0                 (_dec_brmask_logic_io_br_tag_0),
    .io_br_tag_1                 (_dec_brmask_logic_io_br_tag_1),
    .io_br_tag_2                 (_dec_brmask_logic_io_br_tag_2),
    .io_br_mask_0                (_dec_brmask_logic_io_br_mask_0),
    .io_br_mask_1                (_dec_brmask_logic_io_br_mask_1),
    .io_br_mask_2                (_dec_brmask_logic_io_br_mask_2),
    .io_is_full_0                (_dec_brmask_logic_io_is_full_0),
    .io_is_full_1                (_dec_brmask_logic_io_is_full_1),
    .io_is_full_2                (_dec_brmask_logic_io_is_full_2)
  );
  RenameStage_2 rename_stage (	// core.scala:100:32
    .clock                           (clock),
    .reset                           (reset),
    .io_kill                         (_io_ifu_redirect_flush_output),	// core.scala:395:38, :397:27, :418:72, :429:29, :454:78
    .io_dec_fire_0                   (dec_fire_0),	// core.scala:576:58
    .io_dec_fire_1                   (dec_fire_1),	// core.scala:576:58
    .io_dec_fire_2                   (dec_ready),	// core.scala:576:58
    .io_dec_uops_0_uopc              (_decode_units_0_io_deq_uop_uopc),	// core.scala:98:79
    .io_dec_uops_0_inst              (_decode_units_0_io_deq_uop_inst),	// core.scala:98:79
    .io_dec_uops_0_debug_inst        (_decode_units_0_io_deq_uop_debug_inst),	// core.scala:98:79
    .io_dec_uops_0_is_rvc            (_decode_units_0_io_deq_uop_is_rvc),	// core.scala:98:79
    .io_dec_uops_0_debug_pc          (_decode_units_0_io_deq_uop_debug_pc),	// core.scala:98:79
    .io_dec_uops_0_iq_type           (_decode_units_0_io_deq_uop_iq_type),	// core.scala:98:79
    .io_dec_uops_0_fu_code           (_decode_units_0_io_deq_uop_fu_code),	// core.scala:98:79
    .io_dec_uops_0_ctrl_br_type      (_decode_units_0_io_deq_uop_ctrl_br_type),	// core.scala:98:79
    .io_dec_uops_0_ctrl_op1_sel      (_decode_units_0_io_deq_uop_ctrl_op1_sel),	// core.scala:98:79
    .io_dec_uops_0_ctrl_op2_sel      (_decode_units_0_io_deq_uop_ctrl_op2_sel),	// core.scala:98:79
    .io_dec_uops_0_ctrl_imm_sel      (_decode_units_0_io_deq_uop_ctrl_imm_sel),	// core.scala:98:79
    .io_dec_uops_0_ctrl_op_fcn       (_decode_units_0_io_deq_uop_ctrl_op_fcn),	// core.scala:98:79
    .io_dec_uops_0_ctrl_fcn_dw       (_decode_units_0_io_deq_uop_ctrl_fcn_dw),	// core.scala:98:79
    .io_dec_uops_0_ctrl_csr_cmd      (_decode_units_0_io_deq_uop_ctrl_csr_cmd),	// core.scala:98:79
    .io_dec_uops_0_ctrl_is_load      (_decode_units_0_io_deq_uop_ctrl_is_load),	// core.scala:98:79
    .io_dec_uops_0_ctrl_is_sta       (_decode_units_0_io_deq_uop_ctrl_is_sta),	// core.scala:98:79
    .io_dec_uops_0_ctrl_is_std       (_decode_units_0_io_deq_uop_ctrl_is_std),	// core.scala:98:79
    .io_dec_uops_0_iw_state          (_decode_units_0_io_deq_uop_iw_state),	// core.scala:98:79
    .io_dec_uops_0_iw_p1_poisoned    (_decode_units_0_io_deq_uop_iw_p1_poisoned),	// core.scala:98:79
    .io_dec_uops_0_iw_p2_poisoned    (_decode_units_0_io_deq_uop_iw_p2_poisoned),	// core.scala:98:79
    .io_dec_uops_0_is_br             (_decode_units_0_io_deq_uop_is_br),	// core.scala:98:79
    .io_dec_uops_0_is_jalr           (_decode_units_0_io_deq_uop_is_jalr),	// core.scala:98:79
    .io_dec_uops_0_is_jal            (_decode_units_0_io_deq_uop_is_jal),	// core.scala:98:79
    .io_dec_uops_0_is_sfb            (_decode_units_0_io_deq_uop_is_sfb),	// core.scala:98:79
    .io_dec_uops_0_br_mask           (_dec_brmask_logic_io_br_mask_0),	// core.scala:99:32
    .io_dec_uops_0_br_tag            (_dec_brmask_logic_io_br_tag_0),	// core.scala:99:32
    .io_dec_uops_0_ftq_idx           (_decode_units_0_io_deq_uop_ftq_idx),	// core.scala:98:79
    .io_dec_uops_0_edge_inst         (_decode_units_0_io_deq_uop_edge_inst),	// core.scala:98:79
    .io_dec_uops_0_pc_lob            (_decode_units_0_io_deq_uop_pc_lob),	// core.scala:98:79
    .io_dec_uops_0_taken             (_decode_units_0_io_deq_uop_taken),	// core.scala:98:79
    .io_dec_uops_0_imm_packed        (_decode_units_0_io_deq_uop_imm_packed),	// core.scala:98:79
    .io_dec_uops_0_csr_addr          (_decode_units_0_io_deq_uop_csr_addr),	// core.scala:98:79
    .io_dec_uops_0_rxq_idx           (_decode_units_0_io_deq_uop_rxq_idx),	// core.scala:98:79
    .io_dec_uops_0_exception         (_decode_units_0_io_deq_uop_exception),	// core.scala:98:79
    .io_dec_uops_0_exc_cause         (_decode_units_0_io_deq_uop_exc_cause),	// core.scala:98:79
    .io_dec_uops_0_bypassable        (_decode_units_0_io_deq_uop_bypassable),	// core.scala:98:79
    .io_dec_uops_0_mem_cmd           (_decode_units_0_io_deq_uop_mem_cmd),	// core.scala:98:79
    .io_dec_uops_0_mem_size          (_decode_units_0_io_deq_uop_mem_size),	// core.scala:98:79
    .io_dec_uops_0_mem_signed        (_decode_units_0_io_deq_uop_mem_signed),	// core.scala:98:79
    .io_dec_uops_0_is_fence          (_decode_units_0_io_deq_uop_is_fence),	// core.scala:98:79
    .io_dec_uops_0_is_fencei         (_decode_units_0_io_deq_uop_is_fencei),	// core.scala:98:79
    .io_dec_uops_0_is_amo            (_decode_units_0_io_deq_uop_is_amo),	// core.scala:98:79
    .io_dec_uops_0_uses_ldq          (_decode_units_0_io_deq_uop_uses_ldq),	// core.scala:98:79
    .io_dec_uops_0_uses_stq          (_decode_units_0_io_deq_uop_uses_stq),	// core.scala:98:79
    .io_dec_uops_0_is_sys_pc2epc     (_decode_units_0_io_deq_uop_is_sys_pc2epc),	// core.scala:98:79
    .io_dec_uops_0_is_unique         (_decode_units_0_io_deq_uop_is_unique),	// core.scala:98:79
    .io_dec_uops_0_flush_on_commit   (_decode_units_0_io_deq_uop_flush_on_commit),	// core.scala:98:79
    .io_dec_uops_0_ldst              (_decode_units_0_io_deq_uop_ldst),	// core.scala:98:79
    .io_dec_uops_0_lrs1              (_decode_units_0_io_deq_uop_lrs1),	// core.scala:98:79
    .io_dec_uops_0_lrs2              (_decode_units_0_io_deq_uop_lrs2),	// core.scala:98:79
    .io_dec_uops_0_lrs3              (_decode_units_0_io_deq_uop_lrs3),	// core.scala:98:79
    .io_dec_uops_0_ldst_val          (_decode_units_0_io_deq_uop_ldst_val),	// core.scala:98:79
    .io_dec_uops_0_dst_rtype         (_decode_units_0_io_deq_uop_dst_rtype),	// core.scala:98:79
    .io_dec_uops_0_lrs1_rtype        (_decode_units_0_io_deq_uop_lrs1_rtype),	// core.scala:98:79
    .io_dec_uops_0_lrs2_rtype        (_decode_units_0_io_deq_uop_lrs2_rtype),	// core.scala:98:79
    .io_dec_uops_0_frs3_en           (_decode_units_0_io_deq_uop_frs3_en),	// core.scala:98:79
    .io_dec_uops_0_fp_val            (_decode_units_0_io_deq_uop_fp_val),	// core.scala:98:79
    .io_dec_uops_0_fp_single         (_decode_units_0_io_deq_uop_fp_single),	// core.scala:98:79
    .io_dec_uops_0_xcpt_pf_if        (_decode_units_0_io_deq_uop_xcpt_pf_if),	// core.scala:98:79
    .io_dec_uops_0_xcpt_ae_if        (_decode_units_0_io_deq_uop_xcpt_ae_if),	// core.scala:98:79
    .io_dec_uops_0_xcpt_ma_if        (_decode_units_0_io_deq_uop_xcpt_ma_if),	// core.scala:98:79
    .io_dec_uops_0_bp_debug_if       (_decode_units_0_io_deq_uop_bp_debug_if),	// core.scala:98:79
    .io_dec_uops_0_bp_xcpt_if        (_decode_units_0_io_deq_uop_bp_xcpt_if),	// core.scala:98:79
    .io_dec_uops_0_debug_fsrc        (_decode_units_0_io_deq_uop_debug_fsrc),	// core.scala:98:79
    .io_dec_uops_0_debug_tsrc        (_decode_units_0_io_deq_uop_debug_tsrc),	// core.scala:98:79
    .io_dec_uops_1_uopc              (_decode_units_1_io_deq_uop_uopc),	// core.scala:98:79
    .io_dec_uops_1_inst              (_decode_units_1_io_deq_uop_inst),	// core.scala:98:79
    .io_dec_uops_1_debug_inst        (_decode_units_1_io_deq_uop_debug_inst),	// core.scala:98:79
    .io_dec_uops_1_is_rvc            (_decode_units_1_io_deq_uop_is_rvc),	// core.scala:98:79
    .io_dec_uops_1_debug_pc          (_decode_units_1_io_deq_uop_debug_pc),	// core.scala:98:79
    .io_dec_uops_1_iq_type           (_decode_units_1_io_deq_uop_iq_type),	// core.scala:98:79
    .io_dec_uops_1_fu_code           (_decode_units_1_io_deq_uop_fu_code),	// core.scala:98:79
    .io_dec_uops_1_ctrl_br_type      (_decode_units_1_io_deq_uop_ctrl_br_type),	// core.scala:98:79
    .io_dec_uops_1_ctrl_op1_sel      (_decode_units_1_io_deq_uop_ctrl_op1_sel),	// core.scala:98:79
    .io_dec_uops_1_ctrl_op2_sel      (_decode_units_1_io_deq_uop_ctrl_op2_sel),	// core.scala:98:79
    .io_dec_uops_1_ctrl_imm_sel      (_decode_units_1_io_deq_uop_ctrl_imm_sel),	// core.scala:98:79
    .io_dec_uops_1_ctrl_op_fcn       (_decode_units_1_io_deq_uop_ctrl_op_fcn),	// core.scala:98:79
    .io_dec_uops_1_ctrl_fcn_dw       (_decode_units_1_io_deq_uop_ctrl_fcn_dw),	// core.scala:98:79
    .io_dec_uops_1_ctrl_csr_cmd      (_decode_units_1_io_deq_uop_ctrl_csr_cmd),	// core.scala:98:79
    .io_dec_uops_1_ctrl_is_load      (_decode_units_1_io_deq_uop_ctrl_is_load),	// core.scala:98:79
    .io_dec_uops_1_ctrl_is_sta       (_decode_units_1_io_deq_uop_ctrl_is_sta),	// core.scala:98:79
    .io_dec_uops_1_ctrl_is_std       (_decode_units_1_io_deq_uop_ctrl_is_std),	// core.scala:98:79
    .io_dec_uops_1_iw_state          (_decode_units_1_io_deq_uop_iw_state),	// core.scala:98:79
    .io_dec_uops_1_iw_p1_poisoned    (_decode_units_1_io_deq_uop_iw_p1_poisoned),	// core.scala:98:79
    .io_dec_uops_1_iw_p2_poisoned    (_decode_units_1_io_deq_uop_iw_p2_poisoned),	// core.scala:98:79
    .io_dec_uops_1_is_br             (_decode_units_1_io_deq_uop_is_br),	// core.scala:98:79
    .io_dec_uops_1_is_jalr           (_decode_units_1_io_deq_uop_is_jalr),	// core.scala:98:79
    .io_dec_uops_1_is_jal            (_decode_units_1_io_deq_uop_is_jal),	// core.scala:98:79
    .io_dec_uops_1_is_sfb            (_decode_units_1_io_deq_uop_is_sfb),	// core.scala:98:79
    .io_dec_uops_1_br_mask           (_dec_brmask_logic_io_br_mask_1),	// core.scala:99:32
    .io_dec_uops_1_br_tag            (_dec_brmask_logic_io_br_tag_1),	// core.scala:99:32
    .io_dec_uops_1_ftq_idx           (_decode_units_1_io_deq_uop_ftq_idx),	// core.scala:98:79
    .io_dec_uops_1_edge_inst         (_decode_units_1_io_deq_uop_edge_inst),	// core.scala:98:79
    .io_dec_uops_1_pc_lob            (_decode_units_1_io_deq_uop_pc_lob),	// core.scala:98:79
    .io_dec_uops_1_taken             (_decode_units_1_io_deq_uop_taken),	// core.scala:98:79
    .io_dec_uops_1_imm_packed        (_decode_units_1_io_deq_uop_imm_packed),	// core.scala:98:79
    .io_dec_uops_1_csr_addr          (_decode_units_1_io_deq_uop_csr_addr),	// core.scala:98:79
    .io_dec_uops_1_rxq_idx           (_decode_units_1_io_deq_uop_rxq_idx),	// core.scala:98:79
    .io_dec_uops_1_exception         (_decode_units_1_io_deq_uop_exception),	// core.scala:98:79
    .io_dec_uops_1_exc_cause         (_decode_units_1_io_deq_uop_exc_cause),	// core.scala:98:79
    .io_dec_uops_1_bypassable        (_decode_units_1_io_deq_uop_bypassable),	// core.scala:98:79
    .io_dec_uops_1_mem_cmd           (_decode_units_1_io_deq_uop_mem_cmd),	// core.scala:98:79
    .io_dec_uops_1_mem_size          (_decode_units_1_io_deq_uop_mem_size),	// core.scala:98:79
    .io_dec_uops_1_mem_signed        (_decode_units_1_io_deq_uop_mem_signed),	// core.scala:98:79
    .io_dec_uops_1_is_fence          (_decode_units_1_io_deq_uop_is_fence),	// core.scala:98:79
    .io_dec_uops_1_is_fencei         (_decode_units_1_io_deq_uop_is_fencei),	// core.scala:98:79
    .io_dec_uops_1_is_amo            (_decode_units_1_io_deq_uop_is_amo),	// core.scala:98:79
    .io_dec_uops_1_uses_ldq          (_decode_units_1_io_deq_uop_uses_ldq),	// core.scala:98:79
    .io_dec_uops_1_uses_stq          (_decode_units_1_io_deq_uop_uses_stq),	// core.scala:98:79
    .io_dec_uops_1_is_sys_pc2epc     (_decode_units_1_io_deq_uop_is_sys_pc2epc),	// core.scala:98:79
    .io_dec_uops_1_is_unique         (_decode_units_1_io_deq_uop_is_unique),	// core.scala:98:79
    .io_dec_uops_1_flush_on_commit   (_decode_units_1_io_deq_uop_flush_on_commit),	// core.scala:98:79
    .io_dec_uops_1_ldst              (_decode_units_1_io_deq_uop_ldst),	// core.scala:98:79
    .io_dec_uops_1_lrs1              (_decode_units_1_io_deq_uop_lrs1),	// core.scala:98:79
    .io_dec_uops_1_lrs2              (_decode_units_1_io_deq_uop_lrs2),	// core.scala:98:79
    .io_dec_uops_1_lrs3              (_decode_units_1_io_deq_uop_lrs3),	// core.scala:98:79
    .io_dec_uops_1_ldst_val          (_decode_units_1_io_deq_uop_ldst_val),	// core.scala:98:79
    .io_dec_uops_1_dst_rtype         (_decode_units_1_io_deq_uop_dst_rtype),	// core.scala:98:79
    .io_dec_uops_1_lrs1_rtype        (_decode_units_1_io_deq_uop_lrs1_rtype),	// core.scala:98:79
    .io_dec_uops_1_lrs2_rtype        (_decode_units_1_io_deq_uop_lrs2_rtype),	// core.scala:98:79
    .io_dec_uops_1_frs3_en           (_decode_units_1_io_deq_uop_frs3_en),	// core.scala:98:79
    .io_dec_uops_1_fp_val            (_decode_units_1_io_deq_uop_fp_val),	// core.scala:98:79
    .io_dec_uops_1_fp_single         (_decode_units_1_io_deq_uop_fp_single),	// core.scala:98:79
    .io_dec_uops_1_xcpt_pf_if        (_decode_units_1_io_deq_uop_xcpt_pf_if),	// core.scala:98:79
    .io_dec_uops_1_xcpt_ae_if        (_decode_units_1_io_deq_uop_xcpt_ae_if),	// core.scala:98:79
    .io_dec_uops_1_xcpt_ma_if        (_decode_units_1_io_deq_uop_xcpt_ma_if),	// core.scala:98:79
    .io_dec_uops_1_bp_debug_if       (_decode_units_1_io_deq_uop_bp_debug_if),	// core.scala:98:79
    .io_dec_uops_1_bp_xcpt_if        (_decode_units_1_io_deq_uop_bp_xcpt_if),	// core.scala:98:79
    .io_dec_uops_1_debug_fsrc        (_decode_units_1_io_deq_uop_debug_fsrc),	// core.scala:98:79
    .io_dec_uops_1_debug_tsrc        (_decode_units_1_io_deq_uop_debug_tsrc),	// core.scala:98:79
    .io_dec_uops_2_uopc              (_decode_units_2_io_deq_uop_uopc),	// core.scala:98:79
    .io_dec_uops_2_inst              (_decode_units_2_io_deq_uop_inst),	// core.scala:98:79
    .io_dec_uops_2_debug_inst        (_decode_units_2_io_deq_uop_debug_inst),	// core.scala:98:79
    .io_dec_uops_2_is_rvc            (_decode_units_2_io_deq_uop_is_rvc),	// core.scala:98:79
    .io_dec_uops_2_debug_pc          (_decode_units_2_io_deq_uop_debug_pc),	// core.scala:98:79
    .io_dec_uops_2_iq_type           (_decode_units_2_io_deq_uop_iq_type),	// core.scala:98:79
    .io_dec_uops_2_fu_code           (_decode_units_2_io_deq_uop_fu_code),	// core.scala:98:79
    .io_dec_uops_2_ctrl_br_type      (_decode_units_2_io_deq_uop_ctrl_br_type),	// core.scala:98:79
    .io_dec_uops_2_ctrl_op1_sel      (_decode_units_2_io_deq_uop_ctrl_op1_sel),	// core.scala:98:79
    .io_dec_uops_2_ctrl_op2_sel      (_decode_units_2_io_deq_uop_ctrl_op2_sel),	// core.scala:98:79
    .io_dec_uops_2_ctrl_imm_sel      (_decode_units_2_io_deq_uop_ctrl_imm_sel),	// core.scala:98:79
    .io_dec_uops_2_ctrl_op_fcn       (_decode_units_2_io_deq_uop_ctrl_op_fcn),	// core.scala:98:79
    .io_dec_uops_2_ctrl_fcn_dw       (_decode_units_2_io_deq_uop_ctrl_fcn_dw),	// core.scala:98:79
    .io_dec_uops_2_ctrl_csr_cmd      (_decode_units_2_io_deq_uop_ctrl_csr_cmd),	// core.scala:98:79
    .io_dec_uops_2_ctrl_is_load      (_decode_units_2_io_deq_uop_ctrl_is_load),	// core.scala:98:79
    .io_dec_uops_2_ctrl_is_sta       (_decode_units_2_io_deq_uop_ctrl_is_sta),	// core.scala:98:79
    .io_dec_uops_2_ctrl_is_std       (_decode_units_2_io_deq_uop_ctrl_is_std),	// core.scala:98:79
    .io_dec_uops_2_iw_state          (_decode_units_2_io_deq_uop_iw_state),	// core.scala:98:79
    .io_dec_uops_2_iw_p1_poisoned    (_decode_units_2_io_deq_uop_iw_p1_poisoned),	// core.scala:98:79
    .io_dec_uops_2_iw_p2_poisoned    (_decode_units_2_io_deq_uop_iw_p2_poisoned),	// core.scala:98:79
    .io_dec_uops_2_is_br             (_decode_units_2_io_deq_uop_is_br),	// core.scala:98:79
    .io_dec_uops_2_is_jalr           (_decode_units_2_io_deq_uop_is_jalr),	// core.scala:98:79
    .io_dec_uops_2_is_jal            (_decode_units_2_io_deq_uop_is_jal),	// core.scala:98:79
    .io_dec_uops_2_is_sfb            (_decode_units_2_io_deq_uop_is_sfb),	// core.scala:98:79
    .io_dec_uops_2_br_mask           (_dec_brmask_logic_io_br_mask_2),	// core.scala:99:32
    .io_dec_uops_2_br_tag            (_dec_brmask_logic_io_br_tag_2),	// core.scala:99:32
    .io_dec_uops_2_ftq_idx           (_decode_units_2_io_deq_uop_ftq_idx),	// core.scala:98:79
    .io_dec_uops_2_edge_inst         (_decode_units_2_io_deq_uop_edge_inst),	// core.scala:98:79
    .io_dec_uops_2_pc_lob            (_decode_units_2_io_deq_uop_pc_lob),	// core.scala:98:79
    .io_dec_uops_2_taken             (_decode_units_2_io_deq_uop_taken),	// core.scala:98:79
    .io_dec_uops_2_imm_packed        (_decode_units_2_io_deq_uop_imm_packed),	// core.scala:98:79
    .io_dec_uops_2_csr_addr          (_decode_units_2_io_deq_uop_csr_addr),	// core.scala:98:79
    .io_dec_uops_2_rxq_idx           (_decode_units_2_io_deq_uop_rxq_idx),	// core.scala:98:79
    .io_dec_uops_2_exception         (_decode_units_2_io_deq_uop_exception),	// core.scala:98:79
    .io_dec_uops_2_exc_cause         (_decode_units_2_io_deq_uop_exc_cause),	// core.scala:98:79
    .io_dec_uops_2_bypassable        (_decode_units_2_io_deq_uop_bypassable),	// core.scala:98:79
    .io_dec_uops_2_mem_cmd           (_decode_units_2_io_deq_uop_mem_cmd),	// core.scala:98:79
    .io_dec_uops_2_mem_size          (_decode_units_2_io_deq_uop_mem_size),	// core.scala:98:79
    .io_dec_uops_2_mem_signed        (_decode_units_2_io_deq_uop_mem_signed),	// core.scala:98:79
    .io_dec_uops_2_is_fence          (_decode_units_2_io_deq_uop_is_fence),	// core.scala:98:79
    .io_dec_uops_2_is_fencei         (_decode_units_2_io_deq_uop_is_fencei),	// core.scala:98:79
    .io_dec_uops_2_is_amo            (_decode_units_2_io_deq_uop_is_amo),	// core.scala:98:79
    .io_dec_uops_2_uses_ldq          (_decode_units_2_io_deq_uop_uses_ldq),	// core.scala:98:79
    .io_dec_uops_2_uses_stq          (_decode_units_2_io_deq_uop_uses_stq),	// core.scala:98:79
    .io_dec_uops_2_is_sys_pc2epc     (_decode_units_2_io_deq_uop_is_sys_pc2epc),	// core.scala:98:79
    .io_dec_uops_2_is_unique         (_decode_units_2_io_deq_uop_is_unique),	// core.scala:98:79
    .io_dec_uops_2_flush_on_commit   (_decode_units_2_io_deq_uop_flush_on_commit),	// core.scala:98:79
    .io_dec_uops_2_ldst              (_decode_units_2_io_deq_uop_ldst),	// core.scala:98:79
    .io_dec_uops_2_lrs1              (_decode_units_2_io_deq_uop_lrs1),	// core.scala:98:79
    .io_dec_uops_2_lrs2              (_decode_units_2_io_deq_uop_lrs2),	// core.scala:98:79
    .io_dec_uops_2_lrs3              (_decode_units_2_io_deq_uop_lrs3),	// core.scala:98:79
    .io_dec_uops_2_ldst_val          (_decode_units_2_io_deq_uop_ldst_val),	// core.scala:98:79
    .io_dec_uops_2_dst_rtype         (_decode_units_2_io_deq_uop_dst_rtype),	// core.scala:98:79
    .io_dec_uops_2_lrs1_rtype        (_decode_units_2_io_deq_uop_lrs1_rtype),	// core.scala:98:79
    .io_dec_uops_2_lrs2_rtype        (_decode_units_2_io_deq_uop_lrs2_rtype),	// core.scala:98:79
    .io_dec_uops_2_frs3_en           (_decode_units_2_io_deq_uop_frs3_en),	// core.scala:98:79
    .io_dec_uops_2_fp_val            (_decode_units_2_io_deq_uop_fp_val),	// core.scala:98:79
    .io_dec_uops_2_fp_single         (_decode_units_2_io_deq_uop_fp_single),	// core.scala:98:79
    .io_dec_uops_2_xcpt_pf_if        (_decode_units_2_io_deq_uop_xcpt_pf_if),	// core.scala:98:79
    .io_dec_uops_2_xcpt_ae_if        (_decode_units_2_io_deq_uop_xcpt_ae_if),	// core.scala:98:79
    .io_dec_uops_2_xcpt_ma_if        (_decode_units_2_io_deq_uop_xcpt_ma_if),	// core.scala:98:79
    .io_dec_uops_2_bp_debug_if       (_decode_units_2_io_deq_uop_bp_debug_if),	// core.scala:98:79
    .io_dec_uops_2_bp_xcpt_if        (_decode_units_2_io_deq_uop_bp_xcpt_if),	// core.scala:98:79
    .io_dec_uops_2_debug_fsrc        (_decode_units_2_io_deq_uop_debug_fsrc),	// core.scala:98:79
    .io_dec_uops_2_debug_tsrc        (_decode_units_2_io_deq_uop_debug_tsrc),	// core.scala:98:79
    .io_brupdate_b1_resolve_mask     (b1_resolve_mask),	// core.scala:196:72
    .io_brupdate_b2_uop_br_tag       (b2_uop_br_tag),	// core.scala:187:18
    .io_brupdate_b2_mispredict       (b2_mispredict),	// core.scala:187:18
    .io_dis_fire_0                   (dis_fire_0),	// core.scala:708:62
    .io_dis_fire_1                   (dis_fire_1),	// core.scala:708:62
    .io_dis_fire_2                   (dis_fire_2),	// core.scala:708:62
    .io_dis_ready                    (~dis_stalls_2),	// core.scala:707:62, :708:65
    .io_wakeups_0_valid
      (_ll_wbarb_io_out_valid & _iregfile_io_write_ports_0_wport_valid_T),	// core.scala:129:32, :789:92, :792:54
    .io_wakeups_0_bits_uop_pdst      (_ll_wbarb_io_out_bits_uop_pdst),	// core.scala:129:32
    .io_wakeups_0_bits_uop_dst_rtype (_ll_wbarb_io_out_bits_uop_dst_rtype),	// core.scala:129:32
    .io_wakeups_1_valid              (fast_wakeup_valid),	// core.scala:821:52
    .io_wakeups_1_bits_uop_pdst      (_int_issue_unit_io_iss_uops_0_pdst),	// core.scala:107:32
    .io_wakeups_1_bits_uop_dst_rtype (_int_issue_unit_io_iss_uops_0_dst_rtype),	// core.scala:107:32
    .io_wakeups_2_valid              (slow_wakeup_valid),	// core.scala:828:59
    .io_wakeups_2_bits_uop_pdst      (_jmp_unit_io_iresp_bits_uop_pdst),	// execution-units.scala:119:32
    .io_wakeups_2_bits_uop_dst_rtype (_jmp_unit_io_iresp_bits_uop_dst_rtype),	// execution-units.scala:119:32
    .io_wakeups_3_valid              (fast_wakeup_1_valid),	// core.scala:821:52
    .io_wakeups_3_bits_uop_pdst      (_int_issue_unit_io_iss_uops_1_pdst),	// core.scala:107:32
    .io_wakeups_3_bits_uop_dst_rtype (_int_issue_unit_io_iss_uops_1_dst_rtype),	// core.scala:107:32
    .io_wakeups_4_valid              (slow_wakeup_1_valid),	// core.scala:828:59
    .io_wakeups_4_bits_uop_pdst      (_csr_exe_unit_io_iresp_bits_uop_pdst),	// execution-units.scala:119:32
    .io_wakeups_4_bits_uop_dst_rtype (_csr_exe_unit_io_iresp_bits_uop_dst_rtype),	// execution-units.scala:119:32
    .io_wakeups_5_valid              (fast_wakeup_2_valid),	// core.scala:821:52
    .io_wakeups_5_bits_uop_pdst      (_int_issue_unit_io_iss_uops_2_pdst),	// core.scala:107:32
    .io_wakeups_5_bits_uop_dst_rtype (_int_issue_unit_io_iss_uops_2_dst_rtype),	// core.scala:107:32
    .io_wakeups_6_valid              (slow_wakeup_2_valid),	// core.scala:828:59
    .io_wakeups_6_bits_uop_pdst      (_alu_exe_unit_io_iresp_bits_uop_pdst),	// execution-units.scala:119:32
    .io_wakeups_6_bits_uop_dst_rtype (_alu_exe_unit_io_iresp_bits_uop_dst_rtype),	// execution-units.scala:119:32
    .io_com_valids_0                 (_rob_io_commit_valids_0),	// core.scala:140:32
    .io_com_valids_1                 (_rob_io_commit_valids_1),	// core.scala:140:32
    .io_com_valids_2                 (_rob_io_commit_valids_2),	// core.scala:140:32
    .io_com_uops_0_pdst              (_rob_io_commit_uops_0_pdst),	// core.scala:140:32
    .io_com_uops_0_stale_pdst        (_rob_io_commit_uops_0_stale_pdst),	// core.scala:140:32
    .io_com_uops_0_ldst              (_rob_io_commit_uops_0_ldst),	// core.scala:140:32
    .io_com_uops_0_ldst_val          (_rob_io_commit_uops_0_ldst_val),	// core.scala:140:32
    .io_com_uops_0_dst_rtype         (_rob_io_commit_uops_0_dst_rtype),	// core.scala:140:32
    .io_com_uops_1_pdst              (_rob_io_commit_uops_1_pdst),	// core.scala:140:32
    .io_com_uops_1_stale_pdst        (_rob_io_commit_uops_1_stale_pdst),	// core.scala:140:32
    .io_com_uops_1_ldst              (_rob_io_commit_uops_1_ldst),	// core.scala:140:32
    .io_com_uops_1_ldst_val          (_rob_io_commit_uops_1_ldst_val),	// core.scala:140:32
    .io_com_uops_1_dst_rtype         (_rob_io_commit_uops_1_dst_rtype),	// core.scala:140:32
    .io_com_uops_2_pdst              (_rob_io_commit_uops_2_pdst),	// core.scala:140:32
    .io_com_uops_2_stale_pdst        (_rob_io_commit_uops_2_stale_pdst),	// core.scala:140:32
    .io_com_uops_2_ldst              (_rob_io_commit_uops_2_ldst),	// core.scala:140:32
    .io_com_uops_2_ldst_val          (_rob_io_commit_uops_2_ldst_val),	// core.scala:140:32
    .io_com_uops_2_dst_rtype         (_rob_io_commit_uops_2_dst_rtype),	// core.scala:140:32
    .io_rbk_valids_0                 (_rob_io_commit_rbk_valids_0),	// core.scala:140:32
    .io_rbk_valids_1                 (_rob_io_commit_rbk_valids_1),	// core.scala:140:32
    .io_rbk_valids_2                 (_rob_io_commit_rbk_valids_2),	// core.scala:140:32
    .io_rollback                     (_rob_io_commit_rollback),	// core.scala:140:32
    .io_debug_rob_empty              (_rob_io_empty),	// core.scala:140:32
    .io_ren_stalls_0                 (_rename_stage_io_ren_stalls_0),
    .io_ren_stalls_1                 (_rename_stage_io_ren_stalls_1),
    .io_ren_stalls_2                 (_rename_stage_io_ren_stalls_2),
    .io_ren2_mask_0                  (_rename_stage_io_ren2_mask_0),
    .io_ren2_mask_1                  (_rename_stage_io_ren2_mask_1),
    .io_ren2_mask_2                  (_rename_stage_io_ren2_mask_2),
    .io_ren2_uops_0_uopc             (_rename_stage_io_ren2_uops_0_uopc),
    .io_ren2_uops_0_inst             (_rename_stage_io_ren2_uops_0_inst),
    .io_ren2_uops_0_debug_inst       (_rename_stage_io_ren2_uops_0_debug_inst),
    .io_ren2_uops_0_is_rvc           (_rename_stage_io_ren2_uops_0_is_rvc),
    .io_ren2_uops_0_debug_pc         (_rename_stage_io_ren2_uops_0_debug_pc),
    .io_ren2_uops_0_iq_type          (_rename_stage_io_ren2_uops_0_iq_type),
    .io_ren2_uops_0_fu_code          (_rename_stage_io_ren2_uops_0_fu_code),
    .io_ren2_uops_0_ctrl_br_type     (io_lsu_dis_uops_0_bits_ctrl_br_type),
    .io_ren2_uops_0_ctrl_op1_sel     (io_lsu_dis_uops_0_bits_ctrl_op1_sel),
    .io_ren2_uops_0_ctrl_op2_sel     (io_lsu_dis_uops_0_bits_ctrl_op2_sel),
    .io_ren2_uops_0_ctrl_imm_sel     (io_lsu_dis_uops_0_bits_ctrl_imm_sel),
    .io_ren2_uops_0_ctrl_op_fcn      (io_lsu_dis_uops_0_bits_ctrl_op_fcn),
    .io_ren2_uops_0_ctrl_fcn_dw      (io_lsu_dis_uops_0_bits_ctrl_fcn_dw),
    .io_ren2_uops_0_ctrl_csr_cmd     (io_lsu_dis_uops_0_bits_ctrl_csr_cmd),
    .io_ren2_uops_0_ctrl_is_load     (io_lsu_dis_uops_0_bits_ctrl_is_load),
    .io_ren2_uops_0_ctrl_is_sta      (io_lsu_dis_uops_0_bits_ctrl_is_sta),
    .io_ren2_uops_0_ctrl_is_std      (io_lsu_dis_uops_0_bits_ctrl_is_std),
    .io_ren2_uops_0_iw_state         (io_lsu_dis_uops_0_bits_iw_state),
    .io_ren2_uops_0_iw_p1_poisoned   (io_lsu_dis_uops_0_bits_iw_p1_poisoned),
    .io_ren2_uops_0_iw_p2_poisoned   (io_lsu_dis_uops_0_bits_iw_p2_poisoned),
    .io_ren2_uops_0_is_br            (_rename_stage_io_ren2_uops_0_is_br),
    .io_ren2_uops_0_is_jalr          (_rename_stage_io_ren2_uops_0_is_jalr),
    .io_ren2_uops_0_is_jal           (_rename_stage_io_ren2_uops_0_is_jal),
    .io_ren2_uops_0_is_sfb           (_rename_stage_io_ren2_uops_0_is_sfb),
    .io_ren2_uops_0_br_mask          (_rename_stage_io_ren2_uops_0_br_mask),
    .io_ren2_uops_0_br_tag           (_rename_stage_io_ren2_uops_0_br_tag),
    .io_ren2_uops_0_ftq_idx          (_rename_stage_io_ren2_uops_0_ftq_idx),
    .io_ren2_uops_0_edge_inst        (_rename_stage_io_ren2_uops_0_edge_inst),
    .io_ren2_uops_0_pc_lob           (_rename_stage_io_ren2_uops_0_pc_lob),
    .io_ren2_uops_0_taken            (_rename_stage_io_ren2_uops_0_taken),
    .io_ren2_uops_0_imm_packed       (_rename_stage_io_ren2_uops_0_imm_packed),
    .io_ren2_uops_0_csr_addr         (_rename_stage_io_ren2_uops_0_csr_addr),
    .io_ren2_uops_0_rxq_idx          (_rename_stage_io_ren2_uops_0_rxq_idx),
    .io_ren2_uops_0_pdst             (_rename_stage_io_ren2_uops_0_pdst),
    .io_ren2_uops_0_prs1             (_rename_stage_io_ren2_uops_0_prs1),
    .io_ren2_uops_0_prs2             (_rename_stage_io_ren2_uops_0_prs2),
    .io_ren2_uops_0_prs1_busy        (_rename_stage_io_ren2_uops_0_prs1_busy),
    .io_ren2_uops_0_prs2_busy        (_rename_stage_io_ren2_uops_0_prs2_busy),
    .io_ren2_uops_0_stale_pdst       (_rename_stage_io_ren2_uops_0_stale_pdst),
    .io_ren2_uops_0_exception        (_rename_stage_io_ren2_uops_0_exception),
    .io_ren2_uops_0_exc_cause        (_rename_stage_io_ren2_uops_0_exc_cause),
    .io_ren2_uops_0_bypassable       (_rename_stage_io_ren2_uops_0_bypassable),
    .io_ren2_uops_0_mem_cmd          (_rename_stage_io_ren2_uops_0_mem_cmd),
    .io_ren2_uops_0_mem_size         (_rename_stage_io_ren2_uops_0_mem_size),
    .io_ren2_uops_0_mem_signed       (_rename_stage_io_ren2_uops_0_mem_signed),
    .io_ren2_uops_0_is_fence         (_rename_stage_io_ren2_uops_0_is_fence),
    .io_ren2_uops_0_is_fencei        (_rename_stage_io_ren2_uops_0_is_fencei),
    .io_ren2_uops_0_is_amo           (_rename_stage_io_ren2_uops_0_is_amo),
    .io_ren2_uops_0_uses_ldq         (_rename_stage_io_ren2_uops_0_uses_ldq),
    .io_ren2_uops_0_uses_stq         (_rename_stage_io_ren2_uops_0_uses_stq),
    .io_ren2_uops_0_is_sys_pc2epc    (_rename_stage_io_ren2_uops_0_is_sys_pc2epc),
    .io_ren2_uops_0_is_unique        (_rename_stage_io_ren2_uops_0_is_unique),
    .io_ren2_uops_0_flush_on_commit  (_rename_stage_io_ren2_uops_0_flush_on_commit),
    .io_ren2_uops_0_ldst_is_rs1      (_rename_stage_io_ren2_uops_0_ldst_is_rs1),
    .io_ren2_uops_0_ldst             (_rename_stage_io_ren2_uops_0_ldst),
    .io_ren2_uops_0_lrs1             (_rename_stage_io_ren2_uops_0_lrs1),
    .io_ren2_uops_0_lrs2             (_rename_stage_io_ren2_uops_0_lrs2),
    .io_ren2_uops_0_lrs3             (_rename_stage_io_ren2_uops_0_lrs3),
    .io_ren2_uops_0_ldst_val         (_rename_stage_io_ren2_uops_0_ldst_val),
    .io_ren2_uops_0_dst_rtype        (_rename_stage_io_ren2_uops_0_dst_rtype),
    .io_ren2_uops_0_lrs1_rtype       (_rename_stage_io_ren2_uops_0_lrs1_rtype),
    .io_ren2_uops_0_lrs2_rtype       (_rename_stage_io_ren2_uops_0_lrs2_rtype),
    .io_ren2_uops_0_frs3_en          (_rename_stage_io_ren2_uops_0_frs3_en),
    .io_ren2_uops_0_fp_val           (_rename_stage_io_ren2_uops_0_fp_val),
    .io_ren2_uops_0_fp_single        (_rename_stage_io_ren2_uops_0_fp_single),
    .io_ren2_uops_0_xcpt_pf_if       (_rename_stage_io_ren2_uops_0_xcpt_pf_if),
    .io_ren2_uops_0_xcpt_ae_if       (_rename_stage_io_ren2_uops_0_xcpt_ae_if),
    .io_ren2_uops_0_xcpt_ma_if       (_rename_stage_io_ren2_uops_0_xcpt_ma_if),
    .io_ren2_uops_0_bp_debug_if      (_rename_stage_io_ren2_uops_0_bp_debug_if),
    .io_ren2_uops_0_bp_xcpt_if       (_rename_stage_io_ren2_uops_0_bp_xcpt_if),
    .io_ren2_uops_0_debug_fsrc       (_rename_stage_io_ren2_uops_0_debug_fsrc),
    .io_ren2_uops_0_debug_tsrc       (_rename_stage_io_ren2_uops_0_debug_tsrc),
    .io_ren2_uops_1_uopc             (_rename_stage_io_ren2_uops_1_uopc),
    .io_ren2_uops_1_inst             (_rename_stage_io_ren2_uops_1_inst),
    .io_ren2_uops_1_debug_inst       (_rename_stage_io_ren2_uops_1_debug_inst),
    .io_ren2_uops_1_is_rvc           (_rename_stage_io_ren2_uops_1_is_rvc),
    .io_ren2_uops_1_debug_pc         (_rename_stage_io_ren2_uops_1_debug_pc),
    .io_ren2_uops_1_iq_type          (_rename_stage_io_ren2_uops_1_iq_type),
    .io_ren2_uops_1_fu_code          (_rename_stage_io_ren2_uops_1_fu_code),
    .io_ren2_uops_1_ctrl_br_type     (io_lsu_dis_uops_1_bits_ctrl_br_type),
    .io_ren2_uops_1_ctrl_op1_sel     (io_lsu_dis_uops_1_bits_ctrl_op1_sel),
    .io_ren2_uops_1_ctrl_op2_sel     (io_lsu_dis_uops_1_bits_ctrl_op2_sel),
    .io_ren2_uops_1_ctrl_imm_sel     (io_lsu_dis_uops_1_bits_ctrl_imm_sel),
    .io_ren2_uops_1_ctrl_op_fcn      (io_lsu_dis_uops_1_bits_ctrl_op_fcn),
    .io_ren2_uops_1_ctrl_fcn_dw      (io_lsu_dis_uops_1_bits_ctrl_fcn_dw),
    .io_ren2_uops_1_ctrl_csr_cmd     (io_lsu_dis_uops_1_bits_ctrl_csr_cmd),
    .io_ren2_uops_1_ctrl_is_load     (io_lsu_dis_uops_1_bits_ctrl_is_load),
    .io_ren2_uops_1_ctrl_is_sta      (io_lsu_dis_uops_1_bits_ctrl_is_sta),
    .io_ren2_uops_1_ctrl_is_std      (io_lsu_dis_uops_1_bits_ctrl_is_std),
    .io_ren2_uops_1_iw_state         (io_lsu_dis_uops_1_bits_iw_state),
    .io_ren2_uops_1_iw_p1_poisoned   (io_lsu_dis_uops_1_bits_iw_p1_poisoned),
    .io_ren2_uops_1_iw_p2_poisoned   (io_lsu_dis_uops_1_bits_iw_p2_poisoned),
    .io_ren2_uops_1_is_br            (_rename_stage_io_ren2_uops_1_is_br),
    .io_ren2_uops_1_is_jalr          (_rename_stage_io_ren2_uops_1_is_jalr),
    .io_ren2_uops_1_is_jal           (_rename_stage_io_ren2_uops_1_is_jal),
    .io_ren2_uops_1_is_sfb           (_rename_stage_io_ren2_uops_1_is_sfb),
    .io_ren2_uops_1_br_mask          (_rename_stage_io_ren2_uops_1_br_mask),
    .io_ren2_uops_1_br_tag           (_rename_stage_io_ren2_uops_1_br_tag),
    .io_ren2_uops_1_ftq_idx          (_rename_stage_io_ren2_uops_1_ftq_idx),
    .io_ren2_uops_1_edge_inst        (_rename_stage_io_ren2_uops_1_edge_inst),
    .io_ren2_uops_1_pc_lob           (_rename_stage_io_ren2_uops_1_pc_lob),
    .io_ren2_uops_1_taken            (_rename_stage_io_ren2_uops_1_taken),
    .io_ren2_uops_1_imm_packed       (_rename_stage_io_ren2_uops_1_imm_packed),
    .io_ren2_uops_1_csr_addr         (_rename_stage_io_ren2_uops_1_csr_addr),
    .io_ren2_uops_1_rxq_idx          (_rename_stage_io_ren2_uops_1_rxq_idx),
    .io_ren2_uops_1_pdst             (_rename_stage_io_ren2_uops_1_pdst),
    .io_ren2_uops_1_prs1             (_rename_stage_io_ren2_uops_1_prs1),
    .io_ren2_uops_1_prs2             (_rename_stage_io_ren2_uops_1_prs2),
    .io_ren2_uops_1_prs1_busy        (_rename_stage_io_ren2_uops_1_prs1_busy),
    .io_ren2_uops_1_prs2_busy        (_rename_stage_io_ren2_uops_1_prs2_busy),
    .io_ren2_uops_1_stale_pdst       (_rename_stage_io_ren2_uops_1_stale_pdst),
    .io_ren2_uops_1_exception        (_rename_stage_io_ren2_uops_1_exception),
    .io_ren2_uops_1_exc_cause        (_rename_stage_io_ren2_uops_1_exc_cause),
    .io_ren2_uops_1_bypassable       (_rename_stage_io_ren2_uops_1_bypassable),
    .io_ren2_uops_1_mem_cmd          (_rename_stage_io_ren2_uops_1_mem_cmd),
    .io_ren2_uops_1_mem_size         (_rename_stage_io_ren2_uops_1_mem_size),
    .io_ren2_uops_1_mem_signed       (_rename_stage_io_ren2_uops_1_mem_signed),
    .io_ren2_uops_1_is_fence         (_rename_stage_io_ren2_uops_1_is_fence),
    .io_ren2_uops_1_is_fencei        (_rename_stage_io_ren2_uops_1_is_fencei),
    .io_ren2_uops_1_is_amo           (_rename_stage_io_ren2_uops_1_is_amo),
    .io_ren2_uops_1_uses_ldq         (_rename_stage_io_ren2_uops_1_uses_ldq),
    .io_ren2_uops_1_uses_stq         (_rename_stage_io_ren2_uops_1_uses_stq),
    .io_ren2_uops_1_is_sys_pc2epc    (_rename_stage_io_ren2_uops_1_is_sys_pc2epc),
    .io_ren2_uops_1_is_unique        (_rename_stage_io_ren2_uops_1_is_unique),
    .io_ren2_uops_1_flush_on_commit  (_rename_stage_io_ren2_uops_1_flush_on_commit),
    .io_ren2_uops_1_ldst_is_rs1      (_rename_stage_io_ren2_uops_1_ldst_is_rs1),
    .io_ren2_uops_1_ldst             (_rename_stage_io_ren2_uops_1_ldst),
    .io_ren2_uops_1_lrs1             (_rename_stage_io_ren2_uops_1_lrs1),
    .io_ren2_uops_1_lrs2             (_rename_stage_io_ren2_uops_1_lrs2),
    .io_ren2_uops_1_lrs3             (_rename_stage_io_ren2_uops_1_lrs3),
    .io_ren2_uops_1_ldst_val         (_rename_stage_io_ren2_uops_1_ldst_val),
    .io_ren2_uops_1_dst_rtype        (_rename_stage_io_ren2_uops_1_dst_rtype),
    .io_ren2_uops_1_lrs1_rtype       (_rename_stage_io_ren2_uops_1_lrs1_rtype),
    .io_ren2_uops_1_lrs2_rtype       (_rename_stage_io_ren2_uops_1_lrs2_rtype),
    .io_ren2_uops_1_frs3_en          (_rename_stage_io_ren2_uops_1_frs3_en),
    .io_ren2_uops_1_fp_val           (_rename_stage_io_ren2_uops_1_fp_val),
    .io_ren2_uops_1_fp_single        (_rename_stage_io_ren2_uops_1_fp_single),
    .io_ren2_uops_1_xcpt_pf_if       (_rename_stage_io_ren2_uops_1_xcpt_pf_if),
    .io_ren2_uops_1_xcpt_ae_if       (_rename_stage_io_ren2_uops_1_xcpt_ae_if),
    .io_ren2_uops_1_xcpt_ma_if       (_rename_stage_io_ren2_uops_1_xcpt_ma_if),
    .io_ren2_uops_1_bp_debug_if      (_rename_stage_io_ren2_uops_1_bp_debug_if),
    .io_ren2_uops_1_bp_xcpt_if       (_rename_stage_io_ren2_uops_1_bp_xcpt_if),
    .io_ren2_uops_1_debug_fsrc       (_rename_stage_io_ren2_uops_1_debug_fsrc),
    .io_ren2_uops_1_debug_tsrc       (_rename_stage_io_ren2_uops_1_debug_tsrc),
    .io_ren2_uops_2_uopc             (_rename_stage_io_ren2_uops_2_uopc),
    .io_ren2_uops_2_inst             (_rename_stage_io_ren2_uops_2_inst),
    .io_ren2_uops_2_debug_inst       (_rename_stage_io_ren2_uops_2_debug_inst),
    .io_ren2_uops_2_is_rvc           (_rename_stage_io_ren2_uops_2_is_rvc),
    .io_ren2_uops_2_debug_pc         (_rename_stage_io_ren2_uops_2_debug_pc),
    .io_ren2_uops_2_iq_type          (_rename_stage_io_ren2_uops_2_iq_type),
    .io_ren2_uops_2_fu_code          (_rename_stage_io_ren2_uops_2_fu_code),
    .io_ren2_uops_2_ctrl_br_type     (io_lsu_dis_uops_2_bits_ctrl_br_type),
    .io_ren2_uops_2_ctrl_op1_sel     (io_lsu_dis_uops_2_bits_ctrl_op1_sel),
    .io_ren2_uops_2_ctrl_op2_sel     (io_lsu_dis_uops_2_bits_ctrl_op2_sel),
    .io_ren2_uops_2_ctrl_imm_sel     (io_lsu_dis_uops_2_bits_ctrl_imm_sel),
    .io_ren2_uops_2_ctrl_op_fcn      (io_lsu_dis_uops_2_bits_ctrl_op_fcn),
    .io_ren2_uops_2_ctrl_fcn_dw      (io_lsu_dis_uops_2_bits_ctrl_fcn_dw),
    .io_ren2_uops_2_ctrl_csr_cmd     (io_lsu_dis_uops_2_bits_ctrl_csr_cmd),
    .io_ren2_uops_2_ctrl_is_load     (io_lsu_dis_uops_2_bits_ctrl_is_load),
    .io_ren2_uops_2_ctrl_is_sta      (io_lsu_dis_uops_2_bits_ctrl_is_sta),
    .io_ren2_uops_2_ctrl_is_std      (io_lsu_dis_uops_2_bits_ctrl_is_std),
    .io_ren2_uops_2_iw_state         (io_lsu_dis_uops_2_bits_iw_state),
    .io_ren2_uops_2_iw_p1_poisoned   (io_lsu_dis_uops_2_bits_iw_p1_poisoned),
    .io_ren2_uops_2_iw_p2_poisoned   (io_lsu_dis_uops_2_bits_iw_p2_poisoned),
    .io_ren2_uops_2_is_br            (_rename_stage_io_ren2_uops_2_is_br),
    .io_ren2_uops_2_is_jalr          (_rename_stage_io_ren2_uops_2_is_jalr),
    .io_ren2_uops_2_is_jal           (_rename_stage_io_ren2_uops_2_is_jal),
    .io_ren2_uops_2_is_sfb           (_rename_stage_io_ren2_uops_2_is_sfb),
    .io_ren2_uops_2_br_mask          (_rename_stage_io_ren2_uops_2_br_mask),
    .io_ren2_uops_2_br_tag           (_rename_stage_io_ren2_uops_2_br_tag),
    .io_ren2_uops_2_ftq_idx          (_rename_stage_io_ren2_uops_2_ftq_idx),
    .io_ren2_uops_2_edge_inst        (_rename_stage_io_ren2_uops_2_edge_inst),
    .io_ren2_uops_2_pc_lob           (_rename_stage_io_ren2_uops_2_pc_lob),
    .io_ren2_uops_2_taken            (_rename_stage_io_ren2_uops_2_taken),
    .io_ren2_uops_2_imm_packed       (_rename_stage_io_ren2_uops_2_imm_packed),
    .io_ren2_uops_2_csr_addr         (_rename_stage_io_ren2_uops_2_csr_addr),
    .io_ren2_uops_2_rxq_idx          (_rename_stage_io_ren2_uops_2_rxq_idx),
    .io_ren2_uops_2_pdst             (_rename_stage_io_ren2_uops_2_pdst),
    .io_ren2_uops_2_prs1             (_rename_stage_io_ren2_uops_2_prs1),
    .io_ren2_uops_2_prs2             (_rename_stage_io_ren2_uops_2_prs2),
    .io_ren2_uops_2_prs1_busy        (_rename_stage_io_ren2_uops_2_prs1_busy),
    .io_ren2_uops_2_prs2_busy        (_rename_stage_io_ren2_uops_2_prs2_busy),
    .io_ren2_uops_2_stale_pdst       (_rename_stage_io_ren2_uops_2_stale_pdst),
    .io_ren2_uops_2_exception        (_rename_stage_io_ren2_uops_2_exception),
    .io_ren2_uops_2_exc_cause        (_rename_stage_io_ren2_uops_2_exc_cause),
    .io_ren2_uops_2_bypassable       (_rename_stage_io_ren2_uops_2_bypassable),
    .io_ren2_uops_2_mem_cmd          (_rename_stage_io_ren2_uops_2_mem_cmd),
    .io_ren2_uops_2_mem_size         (_rename_stage_io_ren2_uops_2_mem_size),
    .io_ren2_uops_2_mem_signed       (_rename_stage_io_ren2_uops_2_mem_signed),
    .io_ren2_uops_2_is_fence         (_rename_stage_io_ren2_uops_2_is_fence),
    .io_ren2_uops_2_is_fencei        (_rename_stage_io_ren2_uops_2_is_fencei),
    .io_ren2_uops_2_is_amo           (_rename_stage_io_ren2_uops_2_is_amo),
    .io_ren2_uops_2_uses_ldq         (_rename_stage_io_ren2_uops_2_uses_ldq),
    .io_ren2_uops_2_uses_stq         (_rename_stage_io_ren2_uops_2_uses_stq),
    .io_ren2_uops_2_is_sys_pc2epc    (_rename_stage_io_ren2_uops_2_is_sys_pc2epc),
    .io_ren2_uops_2_is_unique        (_rename_stage_io_ren2_uops_2_is_unique),
    .io_ren2_uops_2_flush_on_commit  (_rename_stage_io_ren2_uops_2_flush_on_commit),
    .io_ren2_uops_2_ldst_is_rs1      (_rename_stage_io_ren2_uops_2_ldst_is_rs1),
    .io_ren2_uops_2_ldst             (_rename_stage_io_ren2_uops_2_ldst),
    .io_ren2_uops_2_lrs1             (_rename_stage_io_ren2_uops_2_lrs1),
    .io_ren2_uops_2_lrs2             (_rename_stage_io_ren2_uops_2_lrs2),
    .io_ren2_uops_2_lrs3             (_rename_stage_io_ren2_uops_2_lrs3),
    .io_ren2_uops_2_ldst_val         (_rename_stage_io_ren2_uops_2_ldst_val),
    .io_ren2_uops_2_dst_rtype        (_rename_stage_io_ren2_uops_2_dst_rtype),
    .io_ren2_uops_2_lrs1_rtype       (_rename_stage_io_ren2_uops_2_lrs1_rtype),
    .io_ren2_uops_2_lrs2_rtype       (_rename_stage_io_ren2_uops_2_lrs2_rtype),
    .io_ren2_uops_2_frs3_en          (_rename_stage_io_ren2_uops_2_frs3_en),
    .io_ren2_uops_2_fp_val           (_rename_stage_io_ren2_uops_2_fp_val),
    .io_ren2_uops_2_fp_single        (_rename_stage_io_ren2_uops_2_fp_single),
    .io_ren2_uops_2_xcpt_pf_if       (_rename_stage_io_ren2_uops_2_xcpt_pf_if),
    .io_ren2_uops_2_xcpt_ae_if       (_rename_stage_io_ren2_uops_2_xcpt_ae_if),
    .io_ren2_uops_2_xcpt_ma_if       (_rename_stage_io_ren2_uops_2_xcpt_ma_if),
    .io_ren2_uops_2_bp_debug_if      (_rename_stage_io_ren2_uops_2_bp_debug_if),
    .io_ren2_uops_2_bp_xcpt_if       (_rename_stage_io_ren2_uops_2_bp_xcpt_if),
    .io_ren2_uops_2_debug_fsrc       (_rename_stage_io_ren2_uops_2_debug_fsrc),
    .io_ren2_uops_2_debug_tsrc       (_rename_stage_io_ren2_uops_2_debug_tsrc)
  );
  RenameStage_3 fp_rename_stage (	// core.scala:101:46
    .clock                           (clock),
    .reset                           (reset),
    .io_kill                         (_io_ifu_redirect_flush_output),	// core.scala:395:38, :397:27, :418:72, :429:29, :454:78
    .io_dec_uops_0_is_br             (_decode_units_0_io_deq_uop_is_br),	// core.scala:98:79
    .io_dec_uops_0_is_jalr           (_decode_units_0_io_deq_uop_is_jalr),	// core.scala:98:79
    .io_dec_uops_0_is_sfb            (_decode_units_0_io_deq_uop_is_sfb),	// core.scala:98:79
    .io_dec_uops_0_br_tag            (_dec_brmask_logic_io_br_tag_0),	// core.scala:99:32
    .io_dec_uops_0_ldst              (_decode_units_0_io_deq_uop_ldst),	// core.scala:98:79
    .io_dec_uops_0_lrs1              (_decode_units_0_io_deq_uop_lrs1),	// core.scala:98:79
    .io_dec_uops_0_lrs2              (_decode_units_0_io_deq_uop_lrs2),	// core.scala:98:79
    .io_dec_uops_0_lrs3              (_decode_units_0_io_deq_uop_lrs3),	// core.scala:98:79
    .io_dec_uops_0_ldst_val          (_decode_units_0_io_deq_uop_ldst_val),	// core.scala:98:79
    .io_dec_uops_0_dst_rtype         (_decode_units_0_io_deq_uop_dst_rtype),	// core.scala:98:79
    .io_dec_uops_0_lrs1_rtype        (_decode_units_0_io_deq_uop_lrs1_rtype),	// core.scala:98:79
    .io_dec_uops_0_lrs2_rtype        (_decode_units_0_io_deq_uop_lrs2_rtype),	// core.scala:98:79
    .io_dec_uops_0_frs3_en           (_decode_units_0_io_deq_uop_frs3_en),	// core.scala:98:79
    .io_dec_uops_1_is_br             (_decode_units_1_io_deq_uop_is_br),	// core.scala:98:79
    .io_dec_uops_1_is_jalr           (_decode_units_1_io_deq_uop_is_jalr),	// core.scala:98:79
    .io_dec_uops_1_is_sfb            (_decode_units_1_io_deq_uop_is_sfb),	// core.scala:98:79
    .io_dec_uops_1_br_tag            (_dec_brmask_logic_io_br_tag_1),	// core.scala:99:32
    .io_dec_uops_1_ldst              (_decode_units_1_io_deq_uop_ldst),	// core.scala:98:79
    .io_dec_uops_1_lrs1              (_decode_units_1_io_deq_uop_lrs1),	// core.scala:98:79
    .io_dec_uops_1_lrs2              (_decode_units_1_io_deq_uop_lrs2),	// core.scala:98:79
    .io_dec_uops_1_lrs3              (_decode_units_1_io_deq_uop_lrs3),	// core.scala:98:79
    .io_dec_uops_1_ldst_val          (_decode_units_1_io_deq_uop_ldst_val),	// core.scala:98:79
    .io_dec_uops_1_dst_rtype         (_decode_units_1_io_deq_uop_dst_rtype),	// core.scala:98:79
    .io_dec_uops_1_lrs1_rtype        (_decode_units_1_io_deq_uop_lrs1_rtype),	// core.scala:98:79
    .io_dec_uops_1_lrs2_rtype        (_decode_units_1_io_deq_uop_lrs2_rtype),	// core.scala:98:79
    .io_dec_uops_1_frs3_en           (_decode_units_1_io_deq_uop_frs3_en),	// core.scala:98:79
    .io_dec_uops_2_is_br             (_decode_units_2_io_deq_uop_is_br),	// core.scala:98:79
    .io_dec_uops_2_is_jalr           (_decode_units_2_io_deq_uop_is_jalr),	// core.scala:98:79
    .io_dec_uops_2_is_sfb            (_decode_units_2_io_deq_uop_is_sfb),	// core.scala:98:79
    .io_dec_uops_2_br_tag            (_dec_brmask_logic_io_br_tag_2),	// core.scala:99:32
    .io_dec_uops_2_ldst              (_decode_units_2_io_deq_uop_ldst),	// core.scala:98:79
    .io_dec_uops_2_lrs1              (_decode_units_2_io_deq_uop_lrs1),	// core.scala:98:79
    .io_dec_uops_2_lrs2              (_decode_units_2_io_deq_uop_lrs2),	// core.scala:98:79
    .io_dec_uops_2_lrs3              (_decode_units_2_io_deq_uop_lrs3),	// core.scala:98:79
    .io_dec_uops_2_ldst_val          (_decode_units_2_io_deq_uop_ldst_val),	// core.scala:98:79
    .io_dec_uops_2_dst_rtype         (_decode_units_2_io_deq_uop_dst_rtype),	// core.scala:98:79
    .io_dec_uops_2_lrs1_rtype        (_decode_units_2_io_deq_uop_lrs1_rtype),	// core.scala:98:79
    .io_dec_uops_2_lrs2_rtype        (_decode_units_2_io_deq_uop_lrs2_rtype),	// core.scala:98:79
    .io_dec_uops_2_frs3_en           (_decode_units_2_io_deq_uop_frs3_en),	// core.scala:98:79
    .io_brupdate_b2_uop_br_tag       (b2_uop_br_tag),	// core.scala:187:18
    .io_brupdate_b2_mispredict       (b2_mispredict),	// core.scala:187:18
    .io_dis_fire_0                   (dis_fire_0),	// core.scala:708:62
    .io_dis_fire_1                   (dis_fire_1),	// core.scala:708:62
    .io_dis_fire_2                   (dis_fire_2),	// core.scala:708:62
    .io_dis_ready                    (~dis_stalls_2),	// core.scala:707:62, :708:65
    .io_wakeups_0_valid              (_fp_pipeline_io_wakeups_0_valid),	// core.scala:77:37
    .io_wakeups_0_bits_uop_pdst      (_fp_pipeline_io_wakeups_0_bits_uop_pdst),	// core.scala:77:37
    .io_wakeups_0_bits_uop_dst_rtype (_fp_pipeline_io_wakeups_0_bits_uop_dst_rtype),	// core.scala:77:37
    .io_wakeups_1_valid              (_fp_pipeline_io_wakeups_1_valid),	// core.scala:77:37
    .io_wakeups_1_bits_uop_pdst      (_fp_pipeline_io_wakeups_1_bits_uop_pdst),	// core.scala:77:37
    .io_wakeups_1_bits_uop_dst_rtype (_fp_pipeline_io_wakeups_1_bits_uop_dst_rtype),	// core.scala:77:37
    .io_com_valids_0                 (_rob_io_commit_valids_0),	// core.scala:140:32
    .io_com_valids_1                 (_rob_io_commit_valids_1),	// core.scala:140:32
    .io_com_valids_2                 (_rob_io_commit_valids_2),	// core.scala:140:32
    .io_com_uops_0_pdst              (_rob_io_commit_uops_0_pdst),	// core.scala:140:32
    .io_com_uops_0_stale_pdst        (_rob_io_commit_uops_0_stale_pdst),	// core.scala:140:32
    .io_com_uops_0_ldst              (_rob_io_commit_uops_0_ldst),	// core.scala:140:32
    .io_com_uops_0_ldst_val          (_rob_io_commit_uops_0_ldst_val),	// core.scala:140:32
    .io_com_uops_0_dst_rtype         (_rob_io_commit_uops_0_dst_rtype),	// core.scala:140:32
    .io_com_uops_1_pdst              (_rob_io_commit_uops_1_pdst),	// core.scala:140:32
    .io_com_uops_1_stale_pdst        (_rob_io_commit_uops_1_stale_pdst),	// core.scala:140:32
    .io_com_uops_1_ldst              (_rob_io_commit_uops_1_ldst),	// core.scala:140:32
    .io_com_uops_1_ldst_val          (_rob_io_commit_uops_1_ldst_val),	// core.scala:140:32
    .io_com_uops_1_dst_rtype         (_rob_io_commit_uops_1_dst_rtype),	// core.scala:140:32
    .io_com_uops_2_pdst              (_rob_io_commit_uops_2_pdst),	// core.scala:140:32
    .io_com_uops_2_stale_pdst        (_rob_io_commit_uops_2_stale_pdst),	// core.scala:140:32
    .io_com_uops_2_ldst              (_rob_io_commit_uops_2_ldst),	// core.scala:140:32
    .io_com_uops_2_ldst_val          (_rob_io_commit_uops_2_ldst_val),	// core.scala:140:32
    .io_com_uops_2_dst_rtype         (_rob_io_commit_uops_2_dst_rtype),	// core.scala:140:32
    .io_rbk_valids_0                 (_rob_io_commit_rbk_valids_0),	// core.scala:140:32
    .io_rbk_valids_1                 (_rob_io_commit_rbk_valids_1),	// core.scala:140:32
    .io_rbk_valids_2                 (_rob_io_commit_rbk_valids_2),	// core.scala:140:32
    .io_rollback                     (_rob_io_commit_rollback),	// core.scala:140:32
    .io_debug_rob_empty              (_rob_io_empty),	// core.scala:140:32
    .io_ren_stalls_0                 (_fp_rename_stage_io_ren_stalls_0),
    .io_ren_stalls_1                 (_fp_rename_stage_io_ren_stalls_1),
    .io_ren_stalls_2                 (_fp_rename_stage_io_ren_stalls_2),
    .io_ren2_uops_0_pdst             (_fp_rename_stage_io_ren2_uops_0_pdst),
    .io_ren2_uops_0_prs1             (_fp_rename_stage_io_ren2_uops_0_prs1),
    .io_ren2_uops_0_prs2             (_fp_rename_stage_io_ren2_uops_0_prs2),
    .io_ren2_uops_0_prs3             (_fp_rename_stage_io_ren2_uops_0_prs3),
    .io_ren2_uops_0_prs1_busy        (_fp_rename_stage_io_ren2_uops_0_prs1_busy),
    .io_ren2_uops_0_prs2_busy        (_fp_rename_stage_io_ren2_uops_0_prs2_busy),
    .io_ren2_uops_0_prs3_busy        (_fp_rename_stage_io_ren2_uops_0_prs3_busy),
    .io_ren2_uops_0_stale_pdst       (_fp_rename_stage_io_ren2_uops_0_stale_pdst),
    .io_ren2_uops_1_pdst             (_fp_rename_stage_io_ren2_uops_1_pdst),
    .io_ren2_uops_1_prs1             (_fp_rename_stage_io_ren2_uops_1_prs1),
    .io_ren2_uops_1_prs2             (_fp_rename_stage_io_ren2_uops_1_prs2),
    .io_ren2_uops_1_prs3             (_fp_rename_stage_io_ren2_uops_1_prs3),
    .io_ren2_uops_1_prs1_busy        (_fp_rename_stage_io_ren2_uops_1_prs1_busy),
    .io_ren2_uops_1_prs2_busy        (_fp_rename_stage_io_ren2_uops_1_prs2_busy),
    .io_ren2_uops_1_prs3_busy        (_fp_rename_stage_io_ren2_uops_1_prs3_busy),
    .io_ren2_uops_1_stale_pdst       (_fp_rename_stage_io_ren2_uops_1_stale_pdst),
    .io_ren2_uops_2_pdst             (_fp_rename_stage_io_ren2_uops_2_pdst),
    .io_ren2_uops_2_prs1             (_fp_rename_stage_io_ren2_uops_2_prs1),
    .io_ren2_uops_2_prs2             (_fp_rename_stage_io_ren2_uops_2_prs2),
    .io_ren2_uops_2_prs3             (_fp_rename_stage_io_ren2_uops_2_prs3),
    .io_ren2_uops_2_prs1_busy        (_fp_rename_stage_io_ren2_uops_2_prs1_busy),
    .io_ren2_uops_2_prs2_busy        (_fp_rename_stage_io_ren2_uops_2_prs2_busy),
    .io_ren2_uops_2_prs3_busy        (_fp_rename_stage_io_ren2_uops_2_prs3_busy),
    .io_ren2_uops_2_stale_pdst       (_fp_rename_stage_io_ren2_uops_2_stale_pdst)
  );
  IssueUnitCollapsing_4 mem_issue_unit (	// core.scala:105:32
    .clock                              (clock),
    .reset                              (reset),
    .io_dis_uops_0_valid                (_dispatcher_io_dis_uops_0_0_valid),	// core.scala:111:32
    .io_dis_uops_0_bits_uopc            (_dispatcher_io_dis_uops_0_0_bits_uopc),	// core.scala:111:32
    .io_dis_uops_0_bits_inst            (_dispatcher_io_dis_uops_0_0_bits_inst),	// core.scala:111:32
    .io_dis_uops_0_bits_debug_inst      (_dispatcher_io_dis_uops_0_0_bits_debug_inst),	// core.scala:111:32
    .io_dis_uops_0_bits_is_rvc          (_dispatcher_io_dis_uops_0_0_bits_is_rvc),	// core.scala:111:32
    .io_dis_uops_0_bits_debug_pc        (_dispatcher_io_dis_uops_0_0_bits_debug_pc),	// core.scala:111:32
    .io_dis_uops_0_bits_iq_type         (_dispatcher_io_dis_uops_0_0_bits_iq_type),	// core.scala:111:32
    .io_dis_uops_0_bits_fu_code         (_dispatcher_io_dis_uops_0_0_bits_fu_code),	// core.scala:111:32
    .io_dis_uops_0_bits_is_br           (_dispatcher_io_dis_uops_0_0_bits_is_br),	// core.scala:111:32
    .io_dis_uops_0_bits_is_jalr         (_dispatcher_io_dis_uops_0_0_bits_is_jalr),	// core.scala:111:32
    .io_dis_uops_0_bits_is_jal          (_dispatcher_io_dis_uops_0_0_bits_is_jal),	// core.scala:111:32
    .io_dis_uops_0_bits_is_sfb          (_dispatcher_io_dis_uops_0_0_bits_is_sfb),	// core.scala:111:32
    .io_dis_uops_0_bits_br_mask         (_dispatcher_io_dis_uops_0_0_bits_br_mask),	// core.scala:111:32
    .io_dis_uops_0_bits_br_tag          (_dispatcher_io_dis_uops_0_0_bits_br_tag),	// core.scala:111:32
    .io_dis_uops_0_bits_ftq_idx         (_dispatcher_io_dis_uops_0_0_bits_ftq_idx),	// core.scala:111:32
    .io_dis_uops_0_bits_edge_inst       (_dispatcher_io_dis_uops_0_0_bits_edge_inst),	// core.scala:111:32
    .io_dis_uops_0_bits_pc_lob          (_dispatcher_io_dis_uops_0_0_bits_pc_lob),	// core.scala:111:32
    .io_dis_uops_0_bits_taken           (_dispatcher_io_dis_uops_0_0_bits_taken),	// core.scala:111:32
    .io_dis_uops_0_bits_imm_packed      (_dispatcher_io_dis_uops_0_0_bits_imm_packed),	// core.scala:111:32
    .io_dis_uops_0_bits_csr_addr        (_dispatcher_io_dis_uops_0_0_bits_csr_addr),	// core.scala:111:32
    .io_dis_uops_0_bits_rob_idx         (_dispatcher_io_dis_uops_0_0_bits_rob_idx),	// core.scala:111:32
    .io_dis_uops_0_bits_ldq_idx         (_dispatcher_io_dis_uops_0_0_bits_ldq_idx),	// core.scala:111:32
    .io_dis_uops_0_bits_stq_idx         (_dispatcher_io_dis_uops_0_0_bits_stq_idx),	// core.scala:111:32
    .io_dis_uops_0_bits_rxq_idx         (_dispatcher_io_dis_uops_0_0_bits_rxq_idx),	// core.scala:111:32
    .io_dis_uops_0_bits_pdst            (_dispatcher_io_dis_uops_0_0_bits_pdst),	// core.scala:111:32
    .io_dis_uops_0_bits_prs1            (_dispatcher_io_dis_uops_0_0_bits_prs1),	// core.scala:111:32
    .io_dis_uops_0_bits_prs2            (_dispatcher_io_dis_uops_0_0_bits_prs2),	// core.scala:111:32
    .io_dis_uops_0_bits_prs3            (_dispatcher_io_dis_uops_0_0_bits_prs3),	// core.scala:111:32
    .io_dis_uops_0_bits_prs1_busy       (_dispatcher_io_dis_uops_0_0_bits_prs1_busy),	// core.scala:111:32
    .io_dis_uops_0_bits_prs2_busy       (_dispatcher_io_dis_uops_0_0_bits_prs2_busy),	// core.scala:111:32
    .io_dis_uops_0_bits_stale_pdst      (_dispatcher_io_dis_uops_0_0_bits_stale_pdst),	// core.scala:111:32
    .io_dis_uops_0_bits_exception       (_dispatcher_io_dis_uops_0_0_bits_exception),	// core.scala:111:32
    .io_dis_uops_0_bits_exc_cause       (_dispatcher_io_dis_uops_0_0_bits_exc_cause),	// core.scala:111:32
    .io_dis_uops_0_bits_bypassable      (_dispatcher_io_dis_uops_0_0_bits_bypassable),	// core.scala:111:32
    .io_dis_uops_0_bits_mem_cmd         (_dispatcher_io_dis_uops_0_0_bits_mem_cmd),	// core.scala:111:32
    .io_dis_uops_0_bits_mem_size        (_dispatcher_io_dis_uops_0_0_bits_mem_size),	// core.scala:111:32
    .io_dis_uops_0_bits_mem_signed      (_dispatcher_io_dis_uops_0_0_bits_mem_signed),	// core.scala:111:32
    .io_dis_uops_0_bits_is_fence        (_dispatcher_io_dis_uops_0_0_bits_is_fence),	// core.scala:111:32
    .io_dis_uops_0_bits_is_fencei       (_dispatcher_io_dis_uops_0_0_bits_is_fencei),	// core.scala:111:32
    .io_dis_uops_0_bits_is_amo          (_dispatcher_io_dis_uops_0_0_bits_is_amo),	// core.scala:111:32
    .io_dis_uops_0_bits_uses_ldq        (_dispatcher_io_dis_uops_0_0_bits_uses_ldq),	// core.scala:111:32
    .io_dis_uops_0_bits_uses_stq        (_dispatcher_io_dis_uops_0_0_bits_uses_stq),	// core.scala:111:32
    .io_dis_uops_0_bits_is_sys_pc2epc   (_dispatcher_io_dis_uops_0_0_bits_is_sys_pc2epc),	// core.scala:111:32
    .io_dis_uops_0_bits_is_unique       (_dispatcher_io_dis_uops_0_0_bits_is_unique),	// core.scala:111:32
    .io_dis_uops_0_bits_flush_on_commit
      (_dispatcher_io_dis_uops_0_0_bits_flush_on_commit),	// core.scala:111:32
    .io_dis_uops_0_bits_ldst_is_rs1     (_dispatcher_io_dis_uops_0_0_bits_ldst_is_rs1),	// core.scala:111:32
    .io_dis_uops_0_bits_ldst            (_dispatcher_io_dis_uops_0_0_bits_ldst),	// core.scala:111:32
    .io_dis_uops_0_bits_lrs1            (_dispatcher_io_dis_uops_0_0_bits_lrs1),	// core.scala:111:32
    .io_dis_uops_0_bits_lrs2            (_dispatcher_io_dis_uops_0_0_bits_lrs2),	// core.scala:111:32
    .io_dis_uops_0_bits_lrs3            (_dispatcher_io_dis_uops_0_0_bits_lrs3),	// core.scala:111:32
    .io_dis_uops_0_bits_ldst_val        (_dispatcher_io_dis_uops_0_0_bits_ldst_val),	// core.scala:111:32
    .io_dis_uops_0_bits_dst_rtype       (_dispatcher_io_dis_uops_0_0_bits_dst_rtype),	// core.scala:111:32
    .io_dis_uops_0_bits_lrs1_rtype      (_dispatcher_io_dis_uops_0_0_bits_lrs1_rtype),	// core.scala:111:32
    .io_dis_uops_0_bits_lrs2_rtype      (_dispatcher_io_dis_uops_0_0_bits_lrs2_rtype),	// core.scala:111:32
    .io_dis_uops_0_bits_frs3_en         (_dispatcher_io_dis_uops_0_0_bits_frs3_en),	// core.scala:111:32
    .io_dis_uops_0_bits_fp_val          (_dispatcher_io_dis_uops_0_0_bits_fp_val),	// core.scala:111:32
    .io_dis_uops_0_bits_fp_single       (_dispatcher_io_dis_uops_0_0_bits_fp_single),	// core.scala:111:32
    .io_dis_uops_0_bits_xcpt_pf_if      (_dispatcher_io_dis_uops_0_0_bits_xcpt_pf_if),	// core.scala:111:32
    .io_dis_uops_0_bits_xcpt_ae_if      (_dispatcher_io_dis_uops_0_0_bits_xcpt_ae_if),	// core.scala:111:32
    .io_dis_uops_0_bits_xcpt_ma_if      (_dispatcher_io_dis_uops_0_0_bits_xcpt_ma_if),	// core.scala:111:32
    .io_dis_uops_0_bits_bp_debug_if     (_dispatcher_io_dis_uops_0_0_bits_bp_debug_if),	// core.scala:111:32
    .io_dis_uops_0_bits_bp_xcpt_if      (_dispatcher_io_dis_uops_0_0_bits_bp_xcpt_if),	// core.scala:111:32
    .io_dis_uops_0_bits_debug_fsrc      (_dispatcher_io_dis_uops_0_0_bits_debug_fsrc),	// core.scala:111:32
    .io_dis_uops_0_bits_debug_tsrc      (_dispatcher_io_dis_uops_0_0_bits_debug_tsrc),	// core.scala:111:32
    .io_dis_uops_1_valid                (_dispatcher_io_dis_uops_0_1_valid),	// core.scala:111:32
    .io_dis_uops_1_bits_uopc            (_dispatcher_io_dis_uops_0_1_bits_uopc),	// core.scala:111:32
    .io_dis_uops_1_bits_inst            (_dispatcher_io_dis_uops_0_1_bits_inst),	// core.scala:111:32
    .io_dis_uops_1_bits_debug_inst      (_dispatcher_io_dis_uops_0_1_bits_debug_inst),	// core.scala:111:32
    .io_dis_uops_1_bits_is_rvc          (_dispatcher_io_dis_uops_0_1_bits_is_rvc),	// core.scala:111:32
    .io_dis_uops_1_bits_debug_pc        (_dispatcher_io_dis_uops_0_1_bits_debug_pc),	// core.scala:111:32
    .io_dis_uops_1_bits_iq_type         (_dispatcher_io_dis_uops_0_1_bits_iq_type),	// core.scala:111:32
    .io_dis_uops_1_bits_fu_code         (_dispatcher_io_dis_uops_0_1_bits_fu_code),	// core.scala:111:32
    .io_dis_uops_1_bits_is_br           (_dispatcher_io_dis_uops_0_1_bits_is_br),	// core.scala:111:32
    .io_dis_uops_1_bits_is_jalr         (_dispatcher_io_dis_uops_0_1_bits_is_jalr),	// core.scala:111:32
    .io_dis_uops_1_bits_is_jal          (_dispatcher_io_dis_uops_0_1_bits_is_jal),	// core.scala:111:32
    .io_dis_uops_1_bits_is_sfb          (_dispatcher_io_dis_uops_0_1_bits_is_sfb),	// core.scala:111:32
    .io_dis_uops_1_bits_br_mask         (_dispatcher_io_dis_uops_0_1_bits_br_mask),	// core.scala:111:32
    .io_dis_uops_1_bits_br_tag          (_dispatcher_io_dis_uops_0_1_bits_br_tag),	// core.scala:111:32
    .io_dis_uops_1_bits_ftq_idx         (_dispatcher_io_dis_uops_0_1_bits_ftq_idx),	// core.scala:111:32
    .io_dis_uops_1_bits_edge_inst       (_dispatcher_io_dis_uops_0_1_bits_edge_inst),	// core.scala:111:32
    .io_dis_uops_1_bits_pc_lob          (_dispatcher_io_dis_uops_0_1_bits_pc_lob),	// core.scala:111:32
    .io_dis_uops_1_bits_taken           (_dispatcher_io_dis_uops_0_1_bits_taken),	// core.scala:111:32
    .io_dis_uops_1_bits_imm_packed      (_dispatcher_io_dis_uops_0_1_bits_imm_packed),	// core.scala:111:32
    .io_dis_uops_1_bits_csr_addr        (_dispatcher_io_dis_uops_0_1_bits_csr_addr),	// core.scala:111:32
    .io_dis_uops_1_bits_rob_idx         (_dispatcher_io_dis_uops_0_1_bits_rob_idx),	// core.scala:111:32
    .io_dis_uops_1_bits_ldq_idx         (_dispatcher_io_dis_uops_0_1_bits_ldq_idx),	// core.scala:111:32
    .io_dis_uops_1_bits_stq_idx         (_dispatcher_io_dis_uops_0_1_bits_stq_idx),	// core.scala:111:32
    .io_dis_uops_1_bits_rxq_idx         (_dispatcher_io_dis_uops_0_1_bits_rxq_idx),	// core.scala:111:32
    .io_dis_uops_1_bits_pdst            (_dispatcher_io_dis_uops_0_1_bits_pdst),	// core.scala:111:32
    .io_dis_uops_1_bits_prs1            (_dispatcher_io_dis_uops_0_1_bits_prs1),	// core.scala:111:32
    .io_dis_uops_1_bits_prs2            (_dispatcher_io_dis_uops_0_1_bits_prs2),	// core.scala:111:32
    .io_dis_uops_1_bits_prs3            (_dispatcher_io_dis_uops_0_1_bits_prs3),	// core.scala:111:32
    .io_dis_uops_1_bits_prs1_busy       (_dispatcher_io_dis_uops_0_1_bits_prs1_busy),	// core.scala:111:32
    .io_dis_uops_1_bits_prs2_busy       (_dispatcher_io_dis_uops_0_1_bits_prs2_busy),	// core.scala:111:32
    .io_dis_uops_1_bits_stale_pdst      (_dispatcher_io_dis_uops_0_1_bits_stale_pdst),	// core.scala:111:32
    .io_dis_uops_1_bits_exception       (_dispatcher_io_dis_uops_0_1_bits_exception),	// core.scala:111:32
    .io_dis_uops_1_bits_exc_cause       (_dispatcher_io_dis_uops_0_1_bits_exc_cause),	// core.scala:111:32
    .io_dis_uops_1_bits_bypassable      (_dispatcher_io_dis_uops_0_1_bits_bypassable),	// core.scala:111:32
    .io_dis_uops_1_bits_mem_cmd         (_dispatcher_io_dis_uops_0_1_bits_mem_cmd),	// core.scala:111:32
    .io_dis_uops_1_bits_mem_size        (_dispatcher_io_dis_uops_0_1_bits_mem_size),	// core.scala:111:32
    .io_dis_uops_1_bits_mem_signed      (_dispatcher_io_dis_uops_0_1_bits_mem_signed),	// core.scala:111:32
    .io_dis_uops_1_bits_is_fence        (_dispatcher_io_dis_uops_0_1_bits_is_fence),	// core.scala:111:32
    .io_dis_uops_1_bits_is_fencei       (_dispatcher_io_dis_uops_0_1_bits_is_fencei),	// core.scala:111:32
    .io_dis_uops_1_bits_is_amo          (_dispatcher_io_dis_uops_0_1_bits_is_amo),	// core.scala:111:32
    .io_dis_uops_1_bits_uses_ldq        (_dispatcher_io_dis_uops_0_1_bits_uses_ldq),	// core.scala:111:32
    .io_dis_uops_1_bits_uses_stq        (_dispatcher_io_dis_uops_0_1_bits_uses_stq),	// core.scala:111:32
    .io_dis_uops_1_bits_is_sys_pc2epc   (_dispatcher_io_dis_uops_0_1_bits_is_sys_pc2epc),	// core.scala:111:32
    .io_dis_uops_1_bits_is_unique       (_dispatcher_io_dis_uops_0_1_bits_is_unique),	// core.scala:111:32
    .io_dis_uops_1_bits_flush_on_commit
      (_dispatcher_io_dis_uops_0_1_bits_flush_on_commit),	// core.scala:111:32
    .io_dis_uops_1_bits_ldst_is_rs1     (_dispatcher_io_dis_uops_0_1_bits_ldst_is_rs1),	// core.scala:111:32
    .io_dis_uops_1_bits_ldst            (_dispatcher_io_dis_uops_0_1_bits_ldst),	// core.scala:111:32
    .io_dis_uops_1_bits_lrs1            (_dispatcher_io_dis_uops_0_1_bits_lrs1),	// core.scala:111:32
    .io_dis_uops_1_bits_lrs2            (_dispatcher_io_dis_uops_0_1_bits_lrs2),	// core.scala:111:32
    .io_dis_uops_1_bits_lrs3            (_dispatcher_io_dis_uops_0_1_bits_lrs3),	// core.scala:111:32
    .io_dis_uops_1_bits_ldst_val        (_dispatcher_io_dis_uops_0_1_bits_ldst_val),	// core.scala:111:32
    .io_dis_uops_1_bits_dst_rtype       (_dispatcher_io_dis_uops_0_1_bits_dst_rtype),	// core.scala:111:32
    .io_dis_uops_1_bits_lrs1_rtype      (_dispatcher_io_dis_uops_0_1_bits_lrs1_rtype),	// core.scala:111:32
    .io_dis_uops_1_bits_lrs2_rtype      (_dispatcher_io_dis_uops_0_1_bits_lrs2_rtype),	// core.scala:111:32
    .io_dis_uops_1_bits_frs3_en         (_dispatcher_io_dis_uops_0_1_bits_frs3_en),	// core.scala:111:32
    .io_dis_uops_1_bits_fp_val          (_dispatcher_io_dis_uops_0_1_bits_fp_val),	// core.scala:111:32
    .io_dis_uops_1_bits_fp_single       (_dispatcher_io_dis_uops_0_1_bits_fp_single),	// core.scala:111:32
    .io_dis_uops_1_bits_xcpt_pf_if      (_dispatcher_io_dis_uops_0_1_bits_xcpt_pf_if),	// core.scala:111:32
    .io_dis_uops_1_bits_xcpt_ae_if      (_dispatcher_io_dis_uops_0_1_bits_xcpt_ae_if),	// core.scala:111:32
    .io_dis_uops_1_bits_xcpt_ma_if      (_dispatcher_io_dis_uops_0_1_bits_xcpt_ma_if),	// core.scala:111:32
    .io_dis_uops_1_bits_bp_debug_if     (_dispatcher_io_dis_uops_0_1_bits_bp_debug_if),	// core.scala:111:32
    .io_dis_uops_1_bits_bp_xcpt_if      (_dispatcher_io_dis_uops_0_1_bits_bp_xcpt_if),	// core.scala:111:32
    .io_dis_uops_1_bits_debug_fsrc      (_dispatcher_io_dis_uops_0_1_bits_debug_fsrc),	// core.scala:111:32
    .io_dis_uops_1_bits_debug_tsrc      (_dispatcher_io_dis_uops_0_1_bits_debug_tsrc),	// core.scala:111:32
    .io_dis_uops_2_valid                (_dispatcher_io_dis_uops_0_2_valid),	// core.scala:111:32
    .io_dis_uops_2_bits_uopc            (_dispatcher_io_dis_uops_0_2_bits_uopc),	// core.scala:111:32
    .io_dis_uops_2_bits_inst            (_dispatcher_io_dis_uops_0_2_bits_inst),	// core.scala:111:32
    .io_dis_uops_2_bits_debug_inst      (_dispatcher_io_dis_uops_0_2_bits_debug_inst),	// core.scala:111:32
    .io_dis_uops_2_bits_is_rvc          (_dispatcher_io_dis_uops_0_2_bits_is_rvc),	// core.scala:111:32
    .io_dis_uops_2_bits_debug_pc        (_dispatcher_io_dis_uops_0_2_bits_debug_pc),	// core.scala:111:32
    .io_dis_uops_2_bits_iq_type         (_dispatcher_io_dis_uops_0_2_bits_iq_type),	// core.scala:111:32
    .io_dis_uops_2_bits_fu_code         (_dispatcher_io_dis_uops_0_2_bits_fu_code),	// core.scala:111:32
    .io_dis_uops_2_bits_is_br           (_dispatcher_io_dis_uops_0_2_bits_is_br),	// core.scala:111:32
    .io_dis_uops_2_bits_is_jalr         (_dispatcher_io_dis_uops_0_2_bits_is_jalr),	// core.scala:111:32
    .io_dis_uops_2_bits_is_jal          (_dispatcher_io_dis_uops_0_2_bits_is_jal),	// core.scala:111:32
    .io_dis_uops_2_bits_is_sfb          (_dispatcher_io_dis_uops_0_2_bits_is_sfb),	// core.scala:111:32
    .io_dis_uops_2_bits_br_mask         (_dispatcher_io_dis_uops_0_2_bits_br_mask),	// core.scala:111:32
    .io_dis_uops_2_bits_br_tag          (_dispatcher_io_dis_uops_0_2_bits_br_tag),	// core.scala:111:32
    .io_dis_uops_2_bits_ftq_idx         (_dispatcher_io_dis_uops_0_2_bits_ftq_idx),	// core.scala:111:32
    .io_dis_uops_2_bits_edge_inst       (_dispatcher_io_dis_uops_0_2_bits_edge_inst),	// core.scala:111:32
    .io_dis_uops_2_bits_pc_lob          (_dispatcher_io_dis_uops_0_2_bits_pc_lob),	// core.scala:111:32
    .io_dis_uops_2_bits_taken           (_dispatcher_io_dis_uops_0_2_bits_taken),	// core.scala:111:32
    .io_dis_uops_2_bits_imm_packed      (_dispatcher_io_dis_uops_0_2_bits_imm_packed),	// core.scala:111:32
    .io_dis_uops_2_bits_csr_addr        (_dispatcher_io_dis_uops_0_2_bits_csr_addr),	// core.scala:111:32
    .io_dis_uops_2_bits_rob_idx         (_dispatcher_io_dis_uops_0_2_bits_rob_idx),	// core.scala:111:32
    .io_dis_uops_2_bits_ldq_idx         (_dispatcher_io_dis_uops_0_2_bits_ldq_idx),	// core.scala:111:32
    .io_dis_uops_2_bits_stq_idx         (_dispatcher_io_dis_uops_0_2_bits_stq_idx),	// core.scala:111:32
    .io_dis_uops_2_bits_rxq_idx         (_dispatcher_io_dis_uops_0_2_bits_rxq_idx),	// core.scala:111:32
    .io_dis_uops_2_bits_pdst            (_dispatcher_io_dis_uops_0_2_bits_pdst),	// core.scala:111:32
    .io_dis_uops_2_bits_prs1            (_dispatcher_io_dis_uops_0_2_bits_prs1),	// core.scala:111:32
    .io_dis_uops_2_bits_prs2            (_dispatcher_io_dis_uops_0_2_bits_prs2),	// core.scala:111:32
    .io_dis_uops_2_bits_prs3            (_dispatcher_io_dis_uops_0_2_bits_prs3),	// core.scala:111:32
    .io_dis_uops_2_bits_prs1_busy       (_dispatcher_io_dis_uops_0_2_bits_prs1_busy),	// core.scala:111:32
    .io_dis_uops_2_bits_prs2_busy       (_dispatcher_io_dis_uops_0_2_bits_prs2_busy),	// core.scala:111:32
    .io_dis_uops_2_bits_stale_pdst      (_dispatcher_io_dis_uops_0_2_bits_stale_pdst),	// core.scala:111:32
    .io_dis_uops_2_bits_exception       (_dispatcher_io_dis_uops_0_2_bits_exception),	// core.scala:111:32
    .io_dis_uops_2_bits_exc_cause       (_dispatcher_io_dis_uops_0_2_bits_exc_cause),	// core.scala:111:32
    .io_dis_uops_2_bits_bypassable      (_dispatcher_io_dis_uops_0_2_bits_bypassable),	// core.scala:111:32
    .io_dis_uops_2_bits_mem_cmd         (_dispatcher_io_dis_uops_0_2_bits_mem_cmd),	// core.scala:111:32
    .io_dis_uops_2_bits_mem_size        (_dispatcher_io_dis_uops_0_2_bits_mem_size),	// core.scala:111:32
    .io_dis_uops_2_bits_mem_signed      (_dispatcher_io_dis_uops_0_2_bits_mem_signed),	// core.scala:111:32
    .io_dis_uops_2_bits_is_fence        (_dispatcher_io_dis_uops_0_2_bits_is_fence),	// core.scala:111:32
    .io_dis_uops_2_bits_is_fencei       (_dispatcher_io_dis_uops_0_2_bits_is_fencei),	// core.scala:111:32
    .io_dis_uops_2_bits_is_amo          (_dispatcher_io_dis_uops_0_2_bits_is_amo),	// core.scala:111:32
    .io_dis_uops_2_bits_uses_ldq        (_dispatcher_io_dis_uops_0_2_bits_uses_ldq),	// core.scala:111:32
    .io_dis_uops_2_bits_uses_stq        (_dispatcher_io_dis_uops_0_2_bits_uses_stq),	// core.scala:111:32
    .io_dis_uops_2_bits_is_sys_pc2epc   (_dispatcher_io_dis_uops_0_2_bits_is_sys_pc2epc),	// core.scala:111:32
    .io_dis_uops_2_bits_is_unique       (_dispatcher_io_dis_uops_0_2_bits_is_unique),	// core.scala:111:32
    .io_dis_uops_2_bits_flush_on_commit
      (_dispatcher_io_dis_uops_0_2_bits_flush_on_commit),	// core.scala:111:32
    .io_dis_uops_2_bits_ldst_is_rs1     (_dispatcher_io_dis_uops_0_2_bits_ldst_is_rs1),	// core.scala:111:32
    .io_dis_uops_2_bits_ldst            (_dispatcher_io_dis_uops_0_2_bits_ldst),	// core.scala:111:32
    .io_dis_uops_2_bits_lrs1            (_dispatcher_io_dis_uops_0_2_bits_lrs1),	// core.scala:111:32
    .io_dis_uops_2_bits_lrs2            (_dispatcher_io_dis_uops_0_2_bits_lrs2),	// core.scala:111:32
    .io_dis_uops_2_bits_lrs3            (_dispatcher_io_dis_uops_0_2_bits_lrs3),	// core.scala:111:32
    .io_dis_uops_2_bits_ldst_val        (_dispatcher_io_dis_uops_0_2_bits_ldst_val),	// core.scala:111:32
    .io_dis_uops_2_bits_dst_rtype       (_dispatcher_io_dis_uops_0_2_bits_dst_rtype),	// core.scala:111:32
    .io_dis_uops_2_bits_lrs1_rtype      (_dispatcher_io_dis_uops_0_2_bits_lrs1_rtype),	// core.scala:111:32
    .io_dis_uops_2_bits_lrs2_rtype      (_dispatcher_io_dis_uops_0_2_bits_lrs2_rtype),	// core.scala:111:32
    .io_dis_uops_2_bits_frs3_en         (_dispatcher_io_dis_uops_0_2_bits_frs3_en),	// core.scala:111:32
    .io_dis_uops_2_bits_fp_val          (_dispatcher_io_dis_uops_0_2_bits_fp_val),	// core.scala:111:32
    .io_dis_uops_2_bits_fp_single       (_dispatcher_io_dis_uops_0_2_bits_fp_single),	// core.scala:111:32
    .io_dis_uops_2_bits_xcpt_pf_if      (_dispatcher_io_dis_uops_0_2_bits_xcpt_pf_if),	// core.scala:111:32
    .io_dis_uops_2_bits_xcpt_ae_if      (_dispatcher_io_dis_uops_0_2_bits_xcpt_ae_if),	// core.scala:111:32
    .io_dis_uops_2_bits_xcpt_ma_if      (_dispatcher_io_dis_uops_0_2_bits_xcpt_ma_if),	// core.scala:111:32
    .io_dis_uops_2_bits_bp_debug_if     (_dispatcher_io_dis_uops_0_2_bits_bp_debug_if),	// core.scala:111:32
    .io_dis_uops_2_bits_bp_xcpt_if      (_dispatcher_io_dis_uops_0_2_bits_bp_xcpt_if),	// core.scala:111:32
    .io_dis_uops_2_bits_debug_fsrc      (_dispatcher_io_dis_uops_0_2_bits_debug_fsrc),	// core.scala:111:32
    .io_dis_uops_2_bits_debug_tsrc      (_dispatcher_io_dis_uops_0_2_bits_debug_tsrc),	// core.scala:111:32
    .io_wakeup_ports_0_valid            (int_iss_wakeups_0_valid),	// core.scala:789:54
    .io_wakeup_ports_0_bits_pdst        (_ll_wbarb_io_out_bits_uop_pdst),	// core.scala:129:32
    .io_wakeup_ports_1_valid            (fast_wakeup_valid),	// core.scala:821:52
    .io_wakeup_ports_1_bits_pdst        (_int_issue_unit_io_iss_uops_0_pdst),	// core.scala:107:32
    .io_wakeup_ports_2_valid            (slow_wakeup_valid),	// core.scala:828:59
    .io_wakeup_ports_2_bits_pdst        (_jmp_unit_io_iresp_bits_uop_pdst),	// execution-units.scala:119:32
    .io_wakeup_ports_3_valid            (fast_wakeup_1_valid),	// core.scala:821:52
    .io_wakeup_ports_3_bits_pdst        (_int_issue_unit_io_iss_uops_1_pdst),	// core.scala:107:32
    .io_wakeup_ports_4_valid            (slow_wakeup_1_valid),	// core.scala:828:59
    .io_wakeup_ports_4_bits_pdst        (_csr_exe_unit_io_iresp_bits_uop_pdst),	// execution-units.scala:119:32
    .io_wakeup_ports_5_valid            (fast_wakeup_2_valid),	// core.scala:821:52
    .io_wakeup_ports_5_bits_pdst        (_int_issue_unit_io_iss_uops_2_pdst),	// core.scala:107:32
    .io_wakeup_ports_6_valid            (slow_wakeup_2_valid),	// core.scala:828:59
    .io_wakeup_ports_6_bits_pdst        (_alu_exe_unit_io_iresp_bits_uop_pdst),	// execution-units.scala:119:32
    .io_spec_ld_wakeup_0_valid          (io_lsu_spec_ld_wakeup_0_valid),
    .io_spec_ld_wakeup_0_bits           (io_lsu_spec_ld_wakeup_0_bits),
    .io_fu_types_0
      ({7'h0, ~(pause_mem_REG & (&saturating_loads_counter)), 2'h0}),	// core.scala:426:52, :903:41, :906:{26,45,73}, :925:53
    .io_brupdate_b1_resolve_mask        (b1_resolve_mask),	// core.scala:196:72
    .io_brupdate_b1_mispredict_mask     (b1_mispredict_mask),	// core.scala:197:93
    .io_flush_pipeline                  (mem_issue_unit_io_flush_pipeline_REG),	// core.scala:940:49
    .io_ld_miss                         (io_lsu_ld_miss),
    .io_dis_uops_0_ready                (_mem_issue_unit_io_dis_uops_0_ready),
    .io_dis_uops_1_ready                (_mem_issue_unit_io_dis_uops_1_ready),
    .io_dis_uops_2_ready                (_mem_issue_unit_io_dis_uops_2_ready),
    .io_iss_valids_0                    (_mem_issue_unit_io_iss_valids_0),
    .io_iss_uops_0_uopc                 (_mem_issue_unit_io_iss_uops_0_uopc),
    .io_iss_uops_0_inst                 (_mem_issue_unit_io_iss_uops_0_inst),
    .io_iss_uops_0_debug_inst           (_mem_issue_unit_io_iss_uops_0_debug_inst),
    .io_iss_uops_0_is_rvc               (_mem_issue_unit_io_iss_uops_0_is_rvc),
    .io_iss_uops_0_debug_pc             (_mem_issue_unit_io_iss_uops_0_debug_pc),
    .io_iss_uops_0_iq_type              (_mem_issue_unit_io_iss_uops_0_iq_type),
    .io_iss_uops_0_fu_code              (_mem_issue_unit_io_iss_uops_0_fu_code),
    .io_iss_uops_0_iw_state             (_mem_issue_unit_io_iss_uops_0_iw_state),
    .io_iss_uops_0_iw_p1_poisoned       (_mem_issue_unit_io_iss_uops_0_iw_p1_poisoned),
    .io_iss_uops_0_iw_p2_poisoned       (_mem_issue_unit_io_iss_uops_0_iw_p2_poisoned),
    .io_iss_uops_0_is_br                (_mem_issue_unit_io_iss_uops_0_is_br),
    .io_iss_uops_0_is_jalr              (_mem_issue_unit_io_iss_uops_0_is_jalr),
    .io_iss_uops_0_is_jal               (_mem_issue_unit_io_iss_uops_0_is_jal),
    .io_iss_uops_0_is_sfb               (_mem_issue_unit_io_iss_uops_0_is_sfb),
    .io_iss_uops_0_br_mask              (_mem_issue_unit_io_iss_uops_0_br_mask),
    .io_iss_uops_0_br_tag               (_mem_issue_unit_io_iss_uops_0_br_tag),
    .io_iss_uops_0_ftq_idx              (_mem_issue_unit_io_iss_uops_0_ftq_idx),
    .io_iss_uops_0_edge_inst            (_mem_issue_unit_io_iss_uops_0_edge_inst),
    .io_iss_uops_0_pc_lob               (_mem_issue_unit_io_iss_uops_0_pc_lob),
    .io_iss_uops_0_taken                (_mem_issue_unit_io_iss_uops_0_taken),
    .io_iss_uops_0_imm_packed           (_mem_issue_unit_io_iss_uops_0_imm_packed),
    .io_iss_uops_0_csr_addr             (_mem_issue_unit_io_iss_uops_0_csr_addr),
    .io_iss_uops_0_rob_idx              (_mem_issue_unit_io_iss_uops_0_rob_idx),
    .io_iss_uops_0_ldq_idx              (_mem_issue_unit_io_iss_uops_0_ldq_idx),
    .io_iss_uops_0_stq_idx              (_mem_issue_unit_io_iss_uops_0_stq_idx),
    .io_iss_uops_0_rxq_idx              (_mem_issue_unit_io_iss_uops_0_rxq_idx),
    .io_iss_uops_0_pdst                 (_mem_issue_unit_io_iss_uops_0_pdst),
    .io_iss_uops_0_prs1                 (_mem_issue_unit_io_iss_uops_0_prs1),
    .io_iss_uops_0_prs2                 (_mem_issue_unit_io_iss_uops_0_prs2),
    .io_iss_uops_0_prs3                 (_mem_issue_unit_io_iss_uops_0_prs3),
    .io_iss_uops_0_ppred                (_mem_issue_unit_io_iss_uops_0_ppred),
    .io_iss_uops_0_prs1_busy            (_mem_issue_unit_io_iss_uops_0_prs1_busy),
    .io_iss_uops_0_prs2_busy            (_mem_issue_unit_io_iss_uops_0_prs2_busy),
    .io_iss_uops_0_prs3_busy            (_mem_issue_unit_io_iss_uops_0_prs3_busy),
    .io_iss_uops_0_ppred_busy           (_mem_issue_unit_io_iss_uops_0_ppred_busy),
    .io_iss_uops_0_stale_pdst           (_mem_issue_unit_io_iss_uops_0_stale_pdst),
    .io_iss_uops_0_exception            (_mem_issue_unit_io_iss_uops_0_exception),
    .io_iss_uops_0_exc_cause            (_mem_issue_unit_io_iss_uops_0_exc_cause),
    .io_iss_uops_0_bypassable           (_mem_issue_unit_io_iss_uops_0_bypassable),
    .io_iss_uops_0_mem_cmd              (_mem_issue_unit_io_iss_uops_0_mem_cmd),
    .io_iss_uops_0_mem_size             (_mem_issue_unit_io_iss_uops_0_mem_size),
    .io_iss_uops_0_mem_signed           (_mem_issue_unit_io_iss_uops_0_mem_signed),
    .io_iss_uops_0_is_fence             (_mem_issue_unit_io_iss_uops_0_is_fence),
    .io_iss_uops_0_is_fencei            (_mem_issue_unit_io_iss_uops_0_is_fencei),
    .io_iss_uops_0_is_amo               (_mem_issue_unit_io_iss_uops_0_is_amo),
    .io_iss_uops_0_uses_ldq             (_mem_issue_unit_io_iss_uops_0_uses_ldq),
    .io_iss_uops_0_uses_stq             (_mem_issue_unit_io_iss_uops_0_uses_stq),
    .io_iss_uops_0_is_sys_pc2epc        (_mem_issue_unit_io_iss_uops_0_is_sys_pc2epc),
    .io_iss_uops_0_is_unique            (_mem_issue_unit_io_iss_uops_0_is_unique),
    .io_iss_uops_0_flush_on_commit      (_mem_issue_unit_io_iss_uops_0_flush_on_commit),
    .io_iss_uops_0_ldst_is_rs1          (_mem_issue_unit_io_iss_uops_0_ldst_is_rs1),
    .io_iss_uops_0_ldst                 (_mem_issue_unit_io_iss_uops_0_ldst),
    .io_iss_uops_0_lrs1                 (_mem_issue_unit_io_iss_uops_0_lrs1),
    .io_iss_uops_0_lrs2                 (_mem_issue_unit_io_iss_uops_0_lrs2),
    .io_iss_uops_0_lrs3                 (_mem_issue_unit_io_iss_uops_0_lrs3),
    .io_iss_uops_0_ldst_val             (_mem_issue_unit_io_iss_uops_0_ldst_val),
    .io_iss_uops_0_dst_rtype            (_mem_issue_unit_io_iss_uops_0_dst_rtype),
    .io_iss_uops_0_lrs1_rtype           (_mem_issue_unit_io_iss_uops_0_lrs1_rtype),
    .io_iss_uops_0_lrs2_rtype           (_mem_issue_unit_io_iss_uops_0_lrs2_rtype),
    .io_iss_uops_0_frs3_en              (_mem_issue_unit_io_iss_uops_0_frs3_en),
    .io_iss_uops_0_fp_val               (_mem_issue_unit_io_iss_uops_0_fp_val),
    .io_iss_uops_0_fp_single            (_mem_issue_unit_io_iss_uops_0_fp_single),
    .io_iss_uops_0_xcpt_pf_if           (_mem_issue_unit_io_iss_uops_0_xcpt_pf_if),
    .io_iss_uops_0_xcpt_ae_if           (_mem_issue_unit_io_iss_uops_0_xcpt_ae_if),
    .io_iss_uops_0_xcpt_ma_if           (_mem_issue_unit_io_iss_uops_0_xcpt_ma_if),
    .io_iss_uops_0_bp_debug_if          (_mem_issue_unit_io_iss_uops_0_bp_debug_if),
    .io_iss_uops_0_bp_xcpt_if           (_mem_issue_unit_io_iss_uops_0_bp_xcpt_if),
    .io_iss_uops_0_debug_fsrc           (_mem_issue_unit_io_iss_uops_0_debug_fsrc),
    .io_iss_uops_0_debug_tsrc           (_mem_issue_unit_io_iss_uops_0_debug_tsrc)
  );
  IssueUnitCollapsing_5 int_issue_unit (	// core.scala:107:32
    .clock                              (clock),
    .reset                              (reset),
    .io_dis_uops_0_valid                (_dispatcher_io_dis_uops_1_0_valid),	// core.scala:111:32
    .io_dis_uops_0_bits_uopc            (_dispatcher_io_dis_uops_1_0_bits_uopc),	// core.scala:111:32
    .io_dis_uops_0_bits_inst            (_dispatcher_io_dis_uops_1_0_bits_inst),	// core.scala:111:32
    .io_dis_uops_0_bits_debug_inst      (_dispatcher_io_dis_uops_1_0_bits_debug_inst),	// core.scala:111:32
    .io_dis_uops_0_bits_is_rvc          (_dispatcher_io_dis_uops_1_0_bits_is_rvc),	// core.scala:111:32
    .io_dis_uops_0_bits_debug_pc        (_dispatcher_io_dis_uops_1_0_bits_debug_pc),	// core.scala:111:32
    .io_dis_uops_0_bits_iq_type         (_dispatcher_io_dis_uops_1_0_bits_iq_type),	// core.scala:111:32
    .io_dis_uops_0_bits_fu_code         (_dispatcher_io_dis_uops_1_0_bits_fu_code),	// core.scala:111:32
    .io_dis_uops_0_bits_is_br           (_dispatcher_io_dis_uops_1_0_bits_is_br),	// core.scala:111:32
    .io_dis_uops_0_bits_is_jalr         (_dispatcher_io_dis_uops_1_0_bits_is_jalr),	// core.scala:111:32
    .io_dis_uops_0_bits_is_jal          (_dispatcher_io_dis_uops_1_0_bits_is_jal),	// core.scala:111:32
    .io_dis_uops_0_bits_is_sfb          (_dispatcher_io_dis_uops_1_0_bits_is_sfb),	// core.scala:111:32
    .io_dis_uops_0_bits_br_mask         (_dispatcher_io_dis_uops_1_0_bits_br_mask),	// core.scala:111:32
    .io_dis_uops_0_bits_br_tag          (_dispatcher_io_dis_uops_1_0_bits_br_tag),	// core.scala:111:32
    .io_dis_uops_0_bits_ftq_idx         (_dispatcher_io_dis_uops_1_0_bits_ftq_idx),	// core.scala:111:32
    .io_dis_uops_0_bits_edge_inst       (_dispatcher_io_dis_uops_1_0_bits_edge_inst),	// core.scala:111:32
    .io_dis_uops_0_bits_pc_lob          (_dispatcher_io_dis_uops_1_0_bits_pc_lob),	// core.scala:111:32
    .io_dis_uops_0_bits_taken           (_dispatcher_io_dis_uops_1_0_bits_taken),	// core.scala:111:32
    .io_dis_uops_0_bits_imm_packed      (_dispatcher_io_dis_uops_1_0_bits_imm_packed),	// core.scala:111:32
    .io_dis_uops_0_bits_csr_addr        (_dispatcher_io_dis_uops_1_0_bits_csr_addr),	// core.scala:111:32
    .io_dis_uops_0_bits_rob_idx         (_dispatcher_io_dis_uops_1_0_bits_rob_idx),	// core.scala:111:32
    .io_dis_uops_0_bits_ldq_idx         (_dispatcher_io_dis_uops_1_0_bits_ldq_idx),	// core.scala:111:32
    .io_dis_uops_0_bits_stq_idx         (_dispatcher_io_dis_uops_1_0_bits_stq_idx),	// core.scala:111:32
    .io_dis_uops_0_bits_rxq_idx         (_dispatcher_io_dis_uops_1_0_bits_rxq_idx),	// core.scala:111:32
    .io_dis_uops_0_bits_pdst            (_dispatcher_io_dis_uops_1_0_bits_pdst),	// core.scala:111:32
    .io_dis_uops_0_bits_prs1            (_dispatcher_io_dis_uops_1_0_bits_prs1),	// core.scala:111:32
    .io_dis_uops_0_bits_prs2            (_dispatcher_io_dis_uops_1_0_bits_prs2),	// core.scala:111:32
    .io_dis_uops_0_bits_prs3            (_dispatcher_io_dis_uops_1_0_bits_prs3),	// core.scala:111:32
    .io_dis_uops_0_bits_prs1_busy       (_dispatcher_io_dis_uops_1_0_bits_prs1_busy),	// core.scala:111:32
    .io_dis_uops_0_bits_prs2_busy       (_dispatcher_io_dis_uops_1_0_bits_prs2_busy),	// core.scala:111:32
    .io_dis_uops_0_bits_stale_pdst      (_dispatcher_io_dis_uops_1_0_bits_stale_pdst),	// core.scala:111:32
    .io_dis_uops_0_bits_exception       (_dispatcher_io_dis_uops_1_0_bits_exception),	// core.scala:111:32
    .io_dis_uops_0_bits_exc_cause       (_dispatcher_io_dis_uops_1_0_bits_exc_cause),	// core.scala:111:32
    .io_dis_uops_0_bits_bypassable      (_dispatcher_io_dis_uops_1_0_bits_bypassable),	// core.scala:111:32
    .io_dis_uops_0_bits_mem_cmd         (_dispatcher_io_dis_uops_1_0_bits_mem_cmd),	// core.scala:111:32
    .io_dis_uops_0_bits_mem_size        (_dispatcher_io_dis_uops_1_0_bits_mem_size),	// core.scala:111:32
    .io_dis_uops_0_bits_mem_signed      (_dispatcher_io_dis_uops_1_0_bits_mem_signed),	// core.scala:111:32
    .io_dis_uops_0_bits_is_fence        (_dispatcher_io_dis_uops_1_0_bits_is_fence),	// core.scala:111:32
    .io_dis_uops_0_bits_is_fencei       (_dispatcher_io_dis_uops_1_0_bits_is_fencei),	// core.scala:111:32
    .io_dis_uops_0_bits_is_amo          (_dispatcher_io_dis_uops_1_0_bits_is_amo),	// core.scala:111:32
    .io_dis_uops_0_bits_uses_ldq        (_dispatcher_io_dis_uops_1_0_bits_uses_ldq),	// core.scala:111:32
    .io_dis_uops_0_bits_uses_stq        (_dispatcher_io_dis_uops_1_0_bits_uses_stq),	// core.scala:111:32
    .io_dis_uops_0_bits_is_sys_pc2epc   (_dispatcher_io_dis_uops_1_0_bits_is_sys_pc2epc),	// core.scala:111:32
    .io_dis_uops_0_bits_is_unique       (_dispatcher_io_dis_uops_1_0_bits_is_unique),	// core.scala:111:32
    .io_dis_uops_0_bits_flush_on_commit
      (_dispatcher_io_dis_uops_1_0_bits_flush_on_commit),	// core.scala:111:32
    .io_dis_uops_0_bits_ldst_is_rs1     (_dispatcher_io_dis_uops_1_0_bits_ldst_is_rs1),	// core.scala:111:32
    .io_dis_uops_0_bits_ldst            (_dispatcher_io_dis_uops_1_0_bits_ldst),	// core.scala:111:32
    .io_dis_uops_0_bits_lrs1            (_dispatcher_io_dis_uops_1_0_bits_lrs1),	// core.scala:111:32
    .io_dis_uops_0_bits_lrs2            (_dispatcher_io_dis_uops_1_0_bits_lrs2),	// core.scala:111:32
    .io_dis_uops_0_bits_lrs3            (_dispatcher_io_dis_uops_1_0_bits_lrs3),	// core.scala:111:32
    .io_dis_uops_0_bits_ldst_val        (_dispatcher_io_dis_uops_1_0_bits_ldst_val),	// core.scala:111:32
    .io_dis_uops_0_bits_dst_rtype       (_dispatcher_io_dis_uops_1_0_bits_dst_rtype),	// core.scala:111:32
    .io_dis_uops_0_bits_lrs1_rtype      (_dispatcher_io_dis_uops_1_0_bits_lrs1_rtype),	// core.scala:111:32
    .io_dis_uops_0_bits_lrs2_rtype      (_dispatcher_io_dis_uops_1_0_bits_lrs2_rtype),	// core.scala:111:32
    .io_dis_uops_0_bits_frs3_en         (_dispatcher_io_dis_uops_1_0_bits_frs3_en),	// core.scala:111:32
    .io_dis_uops_0_bits_fp_val          (_dispatcher_io_dis_uops_1_0_bits_fp_val),	// core.scala:111:32
    .io_dis_uops_0_bits_fp_single       (_dispatcher_io_dis_uops_1_0_bits_fp_single),	// core.scala:111:32
    .io_dis_uops_0_bits_xcpt_pf_if      (_dispatcher_io_dis_uops_1_0_bits_xcpt_pf_if),	// core.scala:111:32
    .io_dis_uops_0_bits_xcpt_ae_if      (_dispatcher_io_dis_uops_1_0_bits_xcpt_ae_if),	// core.scala:111:32
    .io_dis_uops_0_bits_xcpt_ma_if      (_dispatcher_io_dis_uops_1_0_bits_xcpt_ma_if),	// core.scala:111:32
    .io_dis_uops_0_bits_bp_debug_if     (_dispatcher_io_dis_uops_1_0_bits_bp_debug_if),	// core.scala:111:32
    .io_dis_uops_0_bits_bp_xcpt_if      (_dispatcher_io_dis_uops_1_0_bits_bp_xcpt_if),	// core.scala:111:32
    .io_dis_uops_0_bits_debug_fsrc      (_dispatcher_io_dis_uops_1_0_bits_debug_fsrc),	// core.scala:111:32
    .io_dis_uops_0_bits_debug_tsrc      (_dispatcher_io_dis_uops_1_0_bits_debug_tsrc),	// core.scala:111:32
    .io_dis_uops_1_valid                (_dispatcher_io_dis_uops_1_1_valid),	// core.scala:111:32
    .io_dis_uops_1_bits_uopc            (_dispatcher_io_dis_uops_1_1_bits_uopc),	// core.scala:111:32
    .io_dis_uops_1_bits_inst            (_dispatcher_io_dis_uops_1_1_bits_inst),	// core.scala:111:32
    .io_dis_uops_1_bits_debug_inst      (_dispatcher_io_dis_uops_1_1_bits_debug_inst),	// core.scala:111:32
    .io_dis_uops_1_bits_is_rvc          (_dispatcher_io_dis_uops_1_1_bits_is_rvc),	// core.scala:111:32
    .io_dis_uops_1_bits_debug_pc        (_dispatcher_io_dis_uops_1_1_bits_debug_pc),	// core.scala:111:32
    .io_dis_uops_1_bits_iq_type         (_dispatcher_io_dis_uops_1_1_bits_iq_type),	// core.scala:111:32
    .io_dis_uops_1_bits_fu_code         (_dispatcher_io_dis_uops_1_1_bits_fu_code),	// core.scala:111:32
    .io_dis_uops_1_bits_is_br           (_dispatcher_io_dis_uops_1_1_bits_is_br),	// core.scala:111:32
    .io_dis_uops_1_bits_is_jalr         (_dispatcher_io_dis_uops_1_1_bits_is_jalr),	// core.scala:111:32
    .io_dis_uops_1_bits_is_jal          (_dispatcher_io_dis_uops_1_1_bits_is_jal),	// core.scala:111:32
    .io_dis_uops_1_bits_is_sfb          (_dispatcher_io_dis_uops_1_1_bits_is_sfb),	// core.scala:111:32
    .io_dis_uops_1_bits_br_mask         (_dispatcher_io_dis_uops_1_1_bits_br_mask),	// core.scala:111:32
    .io_dis_uops_1_bits_br_tag          (_dispatcher_io_dis_uops_1_1_bits_br_tag),	// core.scala:111:32
    .io_dis_uops_1_bits_ftq_idx         (_dispatcher_io_dis_uops_1_1_bits_ftq_idx),	// core.scala:111:32
    .io_dis_uops_1_bits_edge_inst       (_dispatcher_io_dis_uops_1_1_bits_edge_inst),	// core.scala:111:32
    .io_dis_uops_1_bits_pc_lob          (_dispatcher_io_dis_uops_1_1_bits_pc_lob),	// core.scala:111:32
    .io_dis_uops_1_bits_taken           (_dispatcher_io_dis_uops_1_1_bits_taken),	// core.scala:111:32
    .io_dis_uops_1_bits_imm_packed      (_dispatcher_io_dis_uops_1_1_bits_imm_packed),	// core.scala:111:32
    .io_dis_uops_1_bits_csr_addr        (_dispatcher_io_dis_uops_1_1_bits_csr_addr),	// core.scala:111:32
    .io_dis_uops_1_bits_rob_idx         (_dispatcher_io_dis_uops_1_1_bits_rob_idx),	// core.scala:111:32
    .io_dis_uops_1_bits_ldq_idx         (_dispatcher_io_dis_uops_1_1_bits_ldq_idx),	// core.scala:111:32
    .io_dis_uops_1_bits_stq_idx         (_dispatcher_io_dis_uops_1_1_bits_stq_idx),	// core.scala:111:32
    .io_dis_uops_1_bits_rxq_idx         (_dispatcher_io_dis_uops_1_1_bits_rxq_idx),	// core.scala:111:32
    .io_dis_uops_1_bits_pdst            (_dispatcher_io_dis_uops_1_1_bits_pdst),	// core.scala:111:32
    .io_dis_uops_1_bits_prs1            (_dispatcher_io_dis_uops_1_1_bits_prs1),	// core.scala:111:32
    .io_dis_uops_1_bits_prs2            (_dispatcher_io_dis_uops_1_1_bits_prs2),	// core.scala:111:32
    .io_dis_uops_1_bits_prs3            (_dispatcher_io_dis_uops_1_1_bits_prs3),	// core.scala:111:32
    .io_dis_uops_1_bits_prs1_busy       (_dispatcher_io_dis_uops_1_1_bits_prs1_busy),	// core.scala:111:32
    .io_dis_uops_1_bits_prs2_busy       (_dispatcher_io_dis_uops_1_1_bits_prs2_busy),	// core.scala:111:32
    .io_dis_uops_1_bits_stale_pdst      (_dispatcher_io_dis_uops_1_1_bits_stale_pdst),	// core.scala:111:32
    .io_dis_uops_1_bits_exception       (_dispatcher_io_dis_uops_1_1_bits_exception),	// core.scala:111:32
    .io_dis_uops_1_bits_exc_cause       (_dispatcher_io_dis_uops_1_1_bits_exc_cause),	// core.scala:111:32
    .io_dis_uops_1_bits_bypassable      (_dispatcher_io_dis_uops_1_1_bits_bypassable),	// core.scala:111:32
    .io_dis_uops_1_bits_mem_cmd         (_dispatcher_io_dis_uops_1_1_bits_mem_cmd),	// core.scala:111:32
    .io_dis_uops_1_bits_mem_size        (_dispatcher_io_dis_uops_1_1_bits_mem_size),	// core.scala:111:32
    .io_dis_uops_1_bits_mem_signed      (_dispatcher_io_dis_uops_1_1_bits_mem_signed),	// core.scala:111:32
    .io_dis_uops_1_bits_is_fence        (_dispatcher_io_dis_uops_1_1_bits_is_fence),	// core.scala:111:32
    .io_dis_uops_1_bits_is_fencei       (_dispatcher_io_dis_uops_1_1_bits_is_fencei),	// core.scala:111:32
    .io_dis_uops_1_bits_is_amo          (_dispatcher_io_dis_uops_1_1_bits_is_amo),	// core.scala:111:32
    .io_dis_uops_1_bits_uses_ldq        (_dispatcher_io_dis_uops_1_1_bits_uses_ldq),	// core.scala:111:32
    .io_dis_uops_1_bits_uses_stq        (_dispatcher_io_dis_uops_1_1_bits_uses_stq),	// core.scala:111:32
    .io_dis_uops_1_bits_is_sys_pc2epc   (_dispatcher_io_dis_uops_1_1_bits_is_sys_pc2epc),	// core.scala:111:32
    .io_dis_uops_1_bits_is_unique       (_dispatcher_io_dis_uops_1_1_bits_is_unique),	// core.scala:111:32
    .io_dis_uops_1_bits_flush_on_commit
      (_dispatcher_io_dis_uops_1_1_bits_flush_on_commit),	// core.scala:111:32
    .io_dis_uops_1_bits_ldst_is_rs1     (_dispatcher_io_dis_uops_1_1_bits_ldst_is_rs1),	// core.scala:111:32
    .io_dis_uops_1_bits_ldst            (_dispatcher_io_dis_uops_1_1_bits_ldst),	// core.scala:111:32
    .io_dis_uops_1_bits_lrs1            (_dispatcher_io_dis_uops_1_1_bits_lrs1),	// core.scala:111:32
    .io_dis_uops_1_bits_lrs2            (_dispatcher_io_dis_uops_1_1_bits_lrs2),	// core.scala:111:32
    .io_dis_uops_1_bits_lrs3            (_dispatcher_io_dis_uops_1_1_bits_lrs3),	// core.scala:111:32
    .io_dis_uops_1_bits_ldst_val        (_dispatcher_io_dis_uops_1_1_bits_ldst_val),	// core.scala:111:32
    .io_dis_uops_1_bits_dst_rtype       (_dispatcher_io_dis_uops_1_1_bits_dst_rtype),	// core.scala:111:32
    .io_dis_uops_1_bits_lrs1_rtype      (_dispatcher_io_dis_uops_1_1_bits_lrs1_rtype),	// core.scala:111:32
    .io_dis_uops_1_bits_lrs2_rtype      (_dispatcher_io_dis_uops_1_1_bits_lrs2_rtype),	// core.scala:111:32
    .io_dis_uops_1_bits_frs3_en         (_dispatcher_io_dis_uops_1_1_bits_frs3_en),	// core.scala:111:32
    .io_dis_uops_1_bits_fp_val          (_dispatcher_io_dis_uops_1_1_bits_fp_val),	// core.scala:111:32
    .io_dis_uops_1_bits_fp_single       (_dispatcher_io_dis_uops_1_1_bits_fp_single),	// core.scala:111:32
    .io_dis_uops_1_bits_xcpt_pf_if      (_dispatcher_io_dis_uops_1_1_bits_xcpt_pf_if),	// core.scala:111:32
    .io_dis_uops_1_bits_xcpt_ae_if      (_dispatcher_io_dis_uops_1_1_bits_xcpt_ae_if),	// core.scala:111:32
    .io_dis_uops_1_bits_xcpt_ma_if      (_dispatcher_io_dis_uops_1_1_bits_xcpt_ma_if),	// core.scala:111:32
    .io_dis_uops_1_bits_bp_debug_if     (_dispatcher_io_dis_uops_1_1_bits_bp_debug_if),	// core.scala:111:32
    .io_dis_uops_1_bits_bp_xcpt_if      (_dispatcher_io_dis_uops_1_1_bits_bp_xcpt_if),	// core.scala:111:32
    .io_dis_uops_1_bits_debug_fsrc      (_dispatcher_io_dis_uops_1_1_bits_debug_fsrc),	// core.scala:111:32
    .io_dis_uops_1_bits_debug_tsrc      (_dispatcher_io_dis_uops_1_1_bits_debug_tsrc),	// core.scala:111:32
    .io_dis_uops_2_valid                (_dispatcher_io_dis_uops_1_2_valid),	// core.scala:111:32
    .io_dis_uops_2_bits_uopc            (_dispatcher_io_dis_uops_1_2_bits_uopc),	// core.scala:111:32
    .io_dis_uops_2_bits_inst            (_dispatcher_io_dis_uops_1_2_bits_inst),	// core.scala:111:32
    .io_dis_uops_2_bits_debug_inst      (_dispatcher_io_dis_uops_1_2_bits_debug_inst),	// core.scala:111:32
    .io_dis_uops_2_bits_is_rvc          (_dispatcher_io_dis_uops_1_2_bits_is_rvc),	// core.scala:111:32
    .io_dis_uops_2_bits_debug_pc        (_dispatcher_io_dis_uops_1_2_bits_debug_pc),	// core.scala:111:32
    .io_dis_uops_2_bits_iq_type         (_dispatcher_io_dis_uops_1_2_bits_iq_type),	// core.scala:111:32
    .io_dis_uops_2_bits_fu_code         (_dispatcher_io_dis_uops_1_2_bits_fu_code),	// core.scala:111:32
    .io_dis_uops_2_bits_is_br           (_dispatcher_io_dis_uops_1_2_bits_is_br),	// core.scala:111:32
    .io_dis_uops_2_bits_is_jalr         (_dispatcher_io_dis_uops_1_2_bits_is_jalr),	// core.scala:111:32
    .io_dis_uops_2_bits_is_jal          (_dispatcher_io_dis_uops_1_2_bits_is_jal),	// core.scala:111:32
    .io_dis_uops_2_bits_is_sfb          (_dispatcher_io_dis_uops_1_2_bits_is_sfb),	// core.scala:111:32
    .io_dis_uops_2_bits_br_mask         (_dispatcher_io_dis_uops_1_2_bits_br_mask),	// core.scala:111:32
    .io_dis_uops_2_bits_br_tag          (_dispatcher_io_dis_uops_1_2_bits_br_tag),	// core.scala:111:32
    .io_dis_uops_2_bits_ftq_idx         (_dispatcher_io_dis_uops_1_2_bits_ftq_idx),	// core.scala:111:32
    .io_dis_uops_2_bits_edge_inst       (_dispatcher_io_dis_uops_1_2_bits_edge_inst),	// core.scala:111:32
    .io_dis_uops_2_bits_pc_lob          (_dispatcher_io_dis_uops_1_2_bits_pc_lob),	// core.scala:111:32
    .io_dis_uops_2_bits_taken           (_dispatcher_io_dis_uops_1_2_bits_taken),	// core.scala:111:32
    .io_dis_uops_2_bits_imm_packed      (_dispatcher_io_dis_uops_1_2_bits_imm_packed),	// core.scala:111:32
    .io_dis_uops_2_bits_csr_addr        (_dispatcher_io_dis_uops_1_2_bits_csr_addr),	// core.scala:111:32
    .io_dis_uops_2_bits_rob_idx         (_dispatcher_io_dis_uops_1_2_bits_rob_idx),	// core.scala:111:32
    .io_dis_uops_2_bits_ldq_idx         (_dispatcher_io_dis_uops_1_2_bits_ldq_idx),	// core.scala:111:32
    .io_dis_uops_2_bits_stq_idx         (_dispatcher_io_dis_uops_1_2_bits_stq_idx),	// core.scala:111:32
    .io_dis_uops_2_bits_rxq_idx         (_dispatcher_io_dis_uops_1_2_bits_rxq_idx),	// core.scala:111:32
    .io_dis_uops_2_bits_pdst            (_dispatcher_io_dis_uops_1_2_bits_pdst),	// core.scala:111:32
    .io_dis_uops_2_bits_prs1            (_dispatcher_io_dis_uops_1_2_bits_prs1),	// core.scala:111:32
    .io_dis_uops_2_bits_prs2            (_dispatcher_io_dis_uops_1_2_bits_prs2),	// core.scala:111:32
    .io_dis_uops_2_bits_prs3            (_dispatcher_io_dis_uops_1_2_bits_prs3),	// core.scala:111:32
    .io_dis_uops_2_bits_prs1_busy       (_dispatcher_io_dis_uops_1_2_bits_prs1_busy),	// core.scala:111:32
    .io_dis_uops_2_bits_prs2_busy       (_dispatcher_io_dis_uops_1_2_bits_prs2_busy),	// core.scala:111:32
    .io_dis_uops_2_bits_stale_pdst      (_dispatcher_io_dis_uops_1_2_bits_stale_pdst),	// core.scala:111:32
    .io_dis_uops_2_bits_exception       (_dispatcher_io_dis_uops_1_2_bits_exception),	// core.scala:111:32
    .io_dis_uops_2_bits_exc_cause       (_dispatcher_io_dis_uops_1_2_bits_exc_cause),	// core.scala:111:32
    .io_dis_uops_2_bits_bypassable      (_dispatcher_io_dis_uops_1_2_bits_bypassable),	// core.scala:111:32
    .io_dis_uops_2_bits_mem_cmd         (_dispatcher_io_dis_uops_1_2_bits_mem_cmd),	// core.scala:111:32
    .io_dis_uops_2_bits_mem_size        (_dispatcher_io_dis_uops_1_2_bits_mem_size),	// core.scala:111:32
    .io_dis_uops_2_bits_mem_signed      (_dispatcher_io_dis_uops_1_2_bits_mem_signed),	// core.scala:111:32
    .io_dis_uops_2_bits_is_fence        (_dispatcher_io_dis_uops_1_2_bits_is_fence),	// core.scala:111:32
    .io_dis_uops_2_bits_is_fencei       (_dispatcher_io_dis_uops_1_2_bits_is_fencei),	// core.scala:111:32
    .io_dis_uops_2_bits_is_amo          (_dispatcher_io_dis_uops_1_2_bits_is_amo),	// core.scala:111:32
    .io_dis_uops_2_bits_uses_ldq        (_dispatcher_io_dis_uops_1_2_bits_uses_ldq),	// core.scala:111:32
    .io_dis_uops_2_bits_uses_stq        (_dispatcher_io_dis_uops_1_2_bits_uses_stq),	// core.scala:111:32
    .io_dis_uops_2_bits_is_sys_pc2epc   (_dispatcher_io_dis_uops_1_2_bits_is_sys_pc2epc),	// core.scala:111:32
    .io_dis_uops_2_bits_is_unique       (_dispatcher_io_dis_uops_1_2_bits_is_unique),	// core.scala:111:32
    .io_dis_uops_2_bits_flush_on_commit
      (_dispatcher_io_dis_uops_1_2_bits_flush_on_commit),	// core.scala:111:32
    .io_dis_uops_2_bits_ldst_is_rs1     (_dispatcher_io_dis_uops_1_2_bits_ldst_is_rs1),	// core.scala:111:32
    .io_dis_uops_2_bits_ldst            (_dispatcher_io_dis_uops_1_2_bits_ldst),	// core.scala:111:32
    .io_dis_uops_2_bits_lrs1            (_dispatcher_io_dis_uops_1_2_bits_lrs1),	// core.scala:111:32
    .io_dis_uops_2_bits_lrs2            (_dispatcher_io_dis_uops_1_2_bits_lrs2),	// core.scala:111:32
    .io_dis_uops_2_bits_lrs3            (_dispatcher_io_dis_uops_1_2_bits_lrs3),	// core.scala:111:32
    .io_dis_uops_2_bits_ldst_val        (_dispatcher_io_dis_uops_1_2_bits_ldst_val),	// core.scala:111:32
    .io_dis_uops_2_bits_dst_rtype       (_dispatcher_io_dis_uops_1_2_bits_dst_rtype),	// core.scala:111:32
    .io_dis_uops_2_bits_lrs1_rtype      (_dispatcher_io_dis_uops_1_2_bits_lrs1_rtype),	// core.scala:111:32
    .io_dis_uops_2_bits_lrs2_rtype      (_dispatcher_io_dis_uops_1_2_bits_lrs2_rtype),	// core.scala:111:32
    .io_dis_uops_2_bits_frs3_en         (_dispatcher_io_dis_uops_1_2_bits_frs3_en),	// core.scala:111:32
    .io_dis_uops_2_bits_fp_val          (_dispatcher_io_dis_uops_1_2_bits_fp_val),	// core.scala:111:32
    .io_dis_uops_2_bits_fp_single       (_dispatcher_io_dis_uops_1_2_bits_fp_single),	// core.scala:111:32
    .io_dis_uops_2_bits_xcpt_pf_if      (_dispatcher_io_dis_uops_1_2_bits_xcpt_pf_if),	// core.scala:111:32
    .io_dis_uops_2_bits_xcpt_ae_if      (_dispatcher_io_dis_uops_1_2_bits_xcpt_ae_if),	// core.scala:111:32
    .io_dis_uops_2_bits_xcpt_ma_if      (_dispatcher_io_dis_uops_1_2_bits_xcpt_ma_if),	// core.scala:111:32
    .io_dis_uops_2_bits_bp_debug_if     (_dispatcher_io_dis_uops_1_2_bits_bp_debug_if),	// core.scala:111:32
    .io_dis_uops_2_bits_bp_xcpt_if      (_dispatcher_io_dis_uops_1_2_bits_bp_xcpt_if),	// core.scala:111:32
    .io_dis_uops_2_bits_debug_fsrc      (_dispatcher_io_dis_uops_1_2_bits_debug_fsrc),	// core.scala:111:32
    .io_dis_uops_2_bits_debug_tsrc      (_dispatcher_io_dis_uops_1_2_bits_debug_tsrc),	// core.scala:111:32
    .io_wakeup_ports_0_valid            (int_iss_wakeups_0_valid),	// core.scala:789:54
    .io_wakeup_ports_0_bits_pdst        (_ll_wbarb_io_out_bits_uop_pdst),	// core.scala:129:32
    .io_wakeup_ports_1_valid            (fast_wakeup_valid),	// core.scala:821:52
    .io_wakeup_ports_1_bits_pdst        (_int_issue_unit_io_iss_uops_0_pdst),	// core.scala:107:32
    .io_wakeup_ports_2_valid            (slow_wakeup_valid),	// core.scala:828:59
    .io_wakeup_ports_2_bits_pdst        (_jmp_unit_io_iresp_bits_uop_pdst),	// execution-units.scala:119:32
    .io_wakeup_ports_3_valid            (fast_wakeup_1_valid),	// core.scala:821:52
    .io_wakeup_ports_3_bits_pdst        (_int_issue_unit_io_iss_uops_1_pdst),	// core.scala:107:32
    .io_wakeup_ports_4_valid            (slow_wakeup_1_valid),	// core.scala:828:59
    .io_wakeup_ports_4_bits_pdst        (_csr_exe_unit_io_iresp_bits_uop_pdst),	// execution-units.scala:119:32
    .io_wakeup_ports_5_valid            (fast_wakeup_2_valid),	// core.scala:821:52
    .io_wakeup_ports_5_bits_pdst        (_int_issue_unit_io_iss_uops_2_pdst),	// core.scala:107:32
    .io_wakeup_ports_6_valid            (slow_wakeup_2_valid),	// core.scala:828:59
    .io_wakeup_ports_6_bits_pdst        (_alu_exe_unit_io_iresp_bits_uop_pdst),	// execution-units.scala:119:32
    .io_spec_ld_wakeup_0_valid          (io_lsu_spec_ld_wakeup_0_valid),
    .io_spec_ld_wakeup_0_bits           (io_lsu_spec_ld_wakeup_0_bits),
    .io_fu_types_0                      (_jmp_unit_io_fu_types & REG_4),	// core.scala:919:{29,38}, execution-units.scala:119:32
    .io_fu_types_1                      (_csr_exe_unit_io_fu_types),	// execution-units.scala:119:32
    .io_fu_types_2                      (REG_5 & 10'h9),	// core.scala:919:{29,38}, execution-units.scala:119:32
    .io_brupdate_b1_resolve_mask        (b1_resolve_mask),	// core.scala:196:72
    .io_brupdate_b1_mispredict_mask     (b1_mispredict_mask),	// core.scala:197:93
    .io_flush_pipeline                  (int_issue_unit_io_flush_pipeline_REG),	// core.scala:940:49
    .io_ld_miss                         (io_lsu_ld_miss),
    .io_dis_uops_0_ready                (_int_issue_unit_io_dis_uops_0_ready),
    .io_dis_uops_1_ready                (_int_issue_unit_io_dis_uops_1_ready),
    .io_dis_uops_2_ready                (_int_issue_unit_io_dis_uops_2_ready),
    .io_iss_valids_0                    (_int_issue_unit_io_iss_valids_0),
    .io_iss_valids_1                    (_int_issue_unit_io_iss_valids_1),
    .io_iss_valids_2                    (_int_issue_unit_io_iss_valids_2),
    .io_iss_uops_0_uopc                 (_int_issue_unit_io_iss_uops_0_uopc),
    .io_iss_uops_0_is_rvc               (_int_issue_unit_io_iss_uops_0_is_rvc),
    .io_iss_uops_0_fu_code              (_int_issue_unit_io_iss_uops_0_fu_code),
    .io_iss_uops_0_iw_p1_poisoned       (_int_issue_unit_io_iss_uops_0_iw_p1_poisoned),
    .io_iss_uops_0_iw_p2_poisoned       (_int_issue_unit_io_iss_uops_0_iw_p2_poisoned),
    .io_iss_uops_0_is_br                (_int_issue_unit_io_iss_uops_0_is_br),
    .io_iss_uops_0_is_jalr              (_int_issue_unit_io_iss_uops_0_is_jalr),
    .io_iss_uops_0_is_jal               (_int_issue_unit_io_iss_uops_0_is_jal),
    .io_iss_uops_0_is_sfb               (_int_issue_unit_io_iss_uops_0_is_sfb),
    .io_iss_uops_0_br_mask              (_int_issue_unit_io_iss_uops_0_br_mask),
    .io_iss_uops_0_br_tag               (_int_issue_unit_io_iss_uops_0_br_tag),
    .io_iss_uops_0_ftq_idx              (_int_issue_unit_io_iss_uops_0_ftq_idx),
    .io_iss_uops_0_edge_inst            (_int_issue_unit_io_iss_uops_0_edge_inst),
    .io_iss_uops_0_pc_lob               (_int_issue_unit_io_iss_uops_0_pc_lob),
    .io_iss_uops_0_taken                (_int_issue_unit_io_iss_uops_0_taken),
    .io_iss_uops_0_imm_packed           (_int_issue_unit_io_iss_uops_0_imm_packed),
    .io_iss_uops_0_rob_idx              (_int_issue_unit_io_iss_uops_0_rob_idx),
    .io_iss_uops_0_ldq_idx              (_int_issue_unit_io_iss_uops_0_ldq_idx),
    .io_iss_uops_0_stq_idx              (_int_issue_unit_io_iss_uops_0_stq_idx),
    .io_iss_uops_0_pdst                 (_int_issue_unit_io_iss_uops_0_pdst),
    .io_iss_uops_0_prs1                 (_int_issue_unit_io_iss_uops_0_prs1),
    .io_iss_uops_0_prs2                 (_int_issue_unit_io_iss_uops_0_prs2),
    .io_iss_uops_0_bypassable           (_int_issue_unit_io_iss_uops_0_bypassable),
    .io_iss_uops_0_mem_cmd              (_int_issue_unit_io_iss_uops_0_mem_cmd),
    .io_iss_uops_0_is_amo               (_int_issue_unit_io_iss_uops_0_is_amo),
    .io_iss_uops_0_uses_stq             (_int_issue_unit_io_iss_uops_0_uses_stq),
    .io_iss_uops_0_ldst_val             (_int_issue_unit_io_iss_uops_0_ldst_val),
    .io_iss_uops_0_dst_rtype            (_int_issue_unit_io_iss_uops_0_dst_rtype),
    .io_iss_uops_0_lrs1_rtype           (_int_issue_unit_io_iss_uops_0_lrs1_rtype),
    .io_iss_uops_0_lrs2_rtype           (_int_issue_unit_io_iss_uops_0_lrs2_rtype),
    .io_iss_uops_1_uopc                 (_int_issue_unit_io_iss_uops_1_uopc),
    .io_iss_uops_1_inst                 (_int_issue_unit_io_iss_uops_1_inst),
    .io_iss_uops_1_debug_inst           (_int_issue_unit_io_iss_uops_1_debug_inst),
    .io_iss_uops_1_is_rvc               (_int_issue_unit_io_iss_uops_1_is_rvc),
    .io_iss_uops_1_debug_pc             (_int_issue_unit_io_iss_uops_1_debug_pc),
    .io_iss_uops_1_iq_type              (_int_issue_unit_io_iss_uops_1_iq_type),
    .io_iss_uops_1_fu_code              (_int_issue_unit_io_iss_uops_1_fu_code),
    .io_iss_uops_1_iw_state             (_int_issue_unit_io_iss_uops_1_iw_state),
    .io_iss_uops_1_iw_p1_poisoned       (_int_issue_unit_io_iss_uops_1_iw_p1_poisoned),
    .io_iss_uops_1_iw_p2_poisoned       (_int_issue_unit_io_iss_uops_1_iw_p2_poisoned),
    .io_iss_uops_1_is_br                (_int_issue_unit_io_iss_uops_1_is_br),
    .io_iss_uops_1_is_jalr              (_int_issue_unit_io_iss_uops_1_is_jalr),
    .io_iss_uops_1_is_jal               (_int_issue_unit_io_iss_uops_1_is_jal),
    .io_iss_uops_1_is_sfb               (_int_issue_unit_io_iss_uops_1_is_sfb),
    .io_iss_uops_1_br_mask              (_int_issue_unit_io_iss_uops_1_br_mask),
    .io_iss_uops_1_br_tag               (_int_issue_unit_io_iss_uops_1_br_tag),
    .io_iss_uops_1_ftq_idx              (_int_issue_unit_io_iss_uops_1_ftq_idx),
    .io_iss_uops_1_edge_inst            (_int_issue_unit_io_iss_uops_1_edge_inst),
    .io_iss_uops_1_pc_lob               (_int_issue_unit_io_iss_uops_1_pc_lob),
    .io_iss_uops_1_taken                (_int_issue_unit_io_iss_uops_1_taken),
    .io_iss_uops_1_imm_packed           (_int_issue_unit_io_iss_uops_1_imm_packed),
    .io_iss_uops_1_csr_addr             (_int_issue_unit_io_iss_uops_1_csr_addr),
    .io_iss_uops_1_rob_idx              (_int_issue_unit_io_iss_uops_1_rob_idx),
    .io_iss_uops_1_ldq_idx              (_int_issue_unit_io_iss_uops_1_ldq_idx),
    .io_iss_uops_1_stq_idx              (_int_issue_unit_io_iss_uops_1_stq_idx),
    .io_iss_uops_1_rxq_idx              (_int_issue_unit_io_iss_uops_1_rxq_idx),
    .io_iss_uops_1_pdst                 (_int_issue_unit_io_iss_uops_1_pdst),
    .io_iss_uops_1_prs1                 (_int_issue_unit_io_iss_uops_1_prs1),
    .io_iss_uops_1_prs2                 (_int_issue_unit_io_iss_uops_1_prs2),
    .io_iss_uops_1_prs3                 (_int_issue_unit_io_iss_uops_1_prs3),
    .io_iss_uops_1_ppred                (_int_issue_unit_io_iss_uops_1_ppred),
    .io_iss_uops_1_prs1_busy            (_int_issue_unit_io_iss_uops_1_prs1_busy),
    .io_iss_uops_1_prs2_busy            (_int_issue_unit_io_iss_uops_1_prs2_busy),
    .io_iss_uops_1_prs3_busy            (_int_issue_unit_io_iss_uops_1_prs3_busy),
    .io_iss_uops_1_ppred_busy           (_int_issue_unit_io_iss_uops_1_ppred_busy),
    .io_iss_uops_1_stale_pdst           (_int_issue_unit_io_iss_uops_1_stale_pdst),
    .io_iss_uops_1_exception            (_int_issue_unit_io_iss_uops_1_exception),
    .io_iss_uops_1_exc_cause            (_int_issue_unit_io_iss_uops_1_exc_cause),
    .io_iss_uops_1_bypassable           (_int_issue_unit_io_iss_uops_1_bypassable),
    .io_iss_uops_1_mem_cmd              (_int_issue_unit_io_iss_uops_1_mem_cmd),
    .io_iss_uops_1_mem_size             (_int_issue_unit_io_iss_uops_1_mem_size),
    .io_iss_uops_1_mem_signed           (_int_issue_unit_io_iss_uops_1_mem_signed),
    .io_iss_uops_1_is_fence             (_int_issue_unit_io_iss_uops_1_is_fence),
    .io_iss_uops_1_is_fencei            (_int_issue_unit_io_iss_uops_1_is_fencei),
    .io_iss_uops_1_is_amo               (_int_issue_unit_io_iss_uops_1_is_amo),
    .io_iss_uops_1_uses_ldq             (_int_issue_unit_io_iss_uops_1_uses_ldq),
    .io_iss_uops_1_uses_stq             (_int_issue_unit_io_iss_uops_1_uses_stq),
    .io_iss_uops_1_is_sys_pc2epc        (_int_issue_unit_io_iss_uops_1_is_sys_pc2epc),
    .io_iss_uops_1_is_unique            (_int_issue_unit_io_iss_uops_1_is_unique),
    .io_iss_uops_1_flush_on_commit      (_int_issue_unit_io_iss_uops_1_flush_on_commit),
    .io_iss_uops_1_ldst_is_rs1          (_int_issue_unit_io_iss_uops_1_ldst_is_rs1),
    .io_iss_uops_1_ldst                 (_int_issue_unit_io_iss_uops_1_ldst),
    .io_iss_uops_1_lrs1                 (_int_issue_unit_io_iss_uops_1_lrs1),
    .io_iss_uops_1_lrs2                 (_int_issue_unit_io_iss_uops_1_lrs2),
    .io_iss_uops_1_lrs3                 (_int_issue_unit_io_iss_uops_1_lrs3),
    .io_iss_uops_1_ldst_val             (_int_issue_unit_io_iss_uops_1_ldst_val),
    .io_iss_uops_1_dst_rtype            (_int_issue_unit_io_iss_uops_1_dst_rtype),
    .io_iss_uops_1_lrs1_rtype           (_int_issue_unit_io_iss_uops_1_lrs1_rtype),
    .io_iss_uops_1_lrs2_rtype           (_int_issue_unit_io_iss_uops_1_lrs2_rtype),
    .io_iss_uops_1_frs3_en              (_int_issue_unit_io_iss_uops_1_frs3_en),
    .io_iss_uops_1_fp_val               (_int_issue_unit_io_iss_uops_1_fp_val),
    .io_iss_uops_1_fp_single            (_int_issue_unit_io_iss_uops_1_fp_single),
    .io_iss_uops_1_xcpt_pf_if           (_int_issue_unit_io_iss_uops_1_xcpt_pf_if),
    .io_iss_uops_1_xcpt_ae_if           (_int_issue_unit_io_iss_uops_1_xcpt_ae_if),
    .io_iss_uops_1_xcpt_ma_if           (_int_issue_unit_io_iss_uops_1_xcpt_ma_if),
    .io_iss_uops_1_bp_debug_if          (_int_issue_unit_io_iss_uops_1_bp_debug_if),
    .io_iss_uops_1_bp_xcpt_if           (_int_issue_unit_io_iss_uops_1_bp_xcpt_if),
    .io_iss_uops_1_debug_fsrc           (_int_issue_unit_io_iss_uops_1_debug_fsrc),
    .io_iss_uops_1_debug_tsrc           (_int_issue_unit_io_iss_uops_1_debug_tsrc),
    .io_iss_uops_2_uopc                 (_int_issue_unit_io_iss_uops_2_uopc),
    .io_iss_uops_2_is_rvc               (_int_issue_unit_io_iss_uops_2_is_rvc),
    .io_iss_uops_2_fu_code              (_int_issue_unit_io_iss_uops_2_fu_code),
    .io_iss_uops_2_iw_p1_poisoned       (_int_issue_unit_io_iss_uops_2_iw_p1_poisoned),
    .io_iss_uops_2_iw_p2_poisoned       (_int_issue_unit_io_iss_uops_2_iw_p2_poisoned),
    .io_iss_uops_2_is_br                (_int_issue_unit_io_iss_uops_2_is_br),
    .io_iss_uops_2_is_jalr              (_int_issue_unit_io_iss_uops_2_is_jalr),
    .io_iss_uops_2_is_jal               (_int_issue_unit_io_iss_uops_2_is_jal),
    .io_iss_uops_2_is_sfb               (_int_issue_unit_io_iss_uops_2_is_sfb),
    .io_iss_uops_2_br_mask              (_int_issue_unit_io_iss_uops_2_br_mask),
    .io_iss_uops_2_br_tag               (_int_issue_unit_io_iss_uops_2_br_tag),
    .io_iss_uops_2_ftq_idx              (_int_issue_unit_io_iss_uops_2_ftq_idx),
    .io_iss_uops_2_edge_inst            (_int_issue_unit_io_iss_uops_2_edge_inst),
    .io_iss_uops_2_pc_lob               (_int_issue_unit_io_iss_uops_2_pc_lob),
    .io_iss_uops_2_taken                (_int_issue_unit_io_iss_uops_2_taken),
    .io_iss_uops_2_imm_packed           (_int_issue_unit_io_iss_uops_2_imm_packed),
    .io_iss_uops_2_rob_idx              (_int_issue_unit_io_iss_uops_2_rob_idx),
    .io_iss_uops_2_ldq_idx              (_int_issue_unit_io_iss_uops_2_ldq_idx),
    .io_iss_uops_2_stq_idx              (_int_issue_unit_io_iss_uops_2_stq_idx),
    .io_iss_uops_2_pdst                 (_int_issue_unit_io_iss_uops_2_pdst),
    .io_iss_uops_2_prs1                 (_int_issue_unit_io_iss_uops_2_prs1),
    .io_iss_uops_2_prs2                 (_int_issue_unit_io_iss_uops_2_prs2),
    .io_iss_uops_2_bypassable           (_int_issue_unit_io_iss_uops_2_bypassable),
    .io_iss_uops_2_mem_cmd              (_int_issue_unit_io_iss_uops_2_mem_cmd),
    .io_iss_uops_2_is_amo               (_int_issue_unit_io_iss_uops_2_is_amo),
    .io_iss_uops_2_uses_stq             (_int_issue_unit_io_iss_uops_2_uses_stq),
    .io_iss_uops_2_ldst_val             (_int_issue_unit_io_iss_uops_2_ldst_val),
    .io_iss_uops_2_dst_rtype            (_int_issue_unit_io_iss_uops_2_dst_rtype),
    .io_iss_uops_2_lrs1_rtype           (_int_issue_unit_io_iss_uops_2_lrs1_rtype),
    .io_iss_uops_2_lrs2_rtype           (_int_issue_unit_io_iss_uops_2_lrs2_rtype)
  );
  BasicDispatcher_1 dispatcher (	// core.scala:111:32
    .io_ren_uops_0_valid                  (dis_fire_0),	// core.scala:708:62
    .io_ren_uops_0_bits_uopc              (_rename_stage_io_ren2_uops_0_uopc),	// core.scala:100:32
    .io_ren_uops_0_bits_inst              (_rename_stage_io_ren2_uops_0_inst),	// core.scala:100:32
    .io_ren_uops_0_bits_debug_inst        (_rename_stage_io_ren2_uops_0_debug_inst),	// core.scala:100:32
    .io_ren_uops_0_bits_is_rvc            (_rename_stage_io_ren2_uops_0_is_rvc),	// core.scala:100:32
    .io_ren_uops_0_bits_debug_pc          (_rename_stage_io_ren2_uops_0_debug_pc),	// core.scala:100:32
    .io_ren_uops_0_bits_iq_type           (_rename_stage_io_ren2_uops_0_iq_type),	// core.scala:100:32
    .io_ren_uops_0_bits_fu_code           (_rename_stage_io_ren2_uops_0_fu_code),	// core.scala:100:32
    .io_ren_uops_0_bits_is_br             (_rename_stage_io_ren2_uops_0_is_br),	// core.scala:100:32
    .io_ren_uops_0_bits_is_jalr           (_rename_stage_io_ren2_uops_0_is_jalr),	// core.scala:100:32
    .io_ren_uops_0_bits_is_jal            (_rename_stage_io_ren2_uops_0_is_jal),	// core.scala:100:32
    .io_ren_uops_0_bits_is_sfb            (_rename_stage_io_ren2_uops_0_is_sfb),	// core.scala:100:32
    .io_ren_uops_0_bits_br_mask           (_rename_stage_io_ren2_uops_0_br_mask),	// core.scala:100:32
    .io_ren_uops_0_bits_br_tag            (_rename_stage_io_ren2_uops_0_br_tag),	// core.scala:100:32
    .io_ren_uops_0_bits_ftq_idx           (_rename_stage_io_ren2_uops_0_ftq_idx),	// core.scala:100:32
    .io_ren_uops_0_bits_edge_inst         (_rename_stage_io_ren2_uops_0_edge_inst),	// core.scala:100:32
    .io_ren_uops_0_bits_pc_lob            (_rename_stage_io_ren2_uops_0_pc_lob),	// core.scala:100:32
    .io_ren_uops_0_bits_taken             (_rename_stage_io_ren2_uops_0_taken),	// core.scala:100:32
    .io_ren_uops_0_bits_imm_packed        (_rename_stage_io_ren2_uops_0_imm_packed),	// core.scala:100:32
    .io_ren_uops_0_bits_csr_addr          (_rename_stage_io_ren2_uops_0_csr_addr),	// core.scala:100:32
    .io_ren_uops_0_bits_rob_idx           (dis_uops_0_rob_idx),	// core.scala:743:27
    .io_ren_uops_0_bits_ldq_idx           (io_lsu_dis_ldq_idx_0),
    .io_ren_uops_0_bits_stq_idx           (io_lsu_dis_stq_idx_0),
    .io_ren_uops_0_bits_rxq_idx           (_rename_stage_io_ren2_uops_0_rxq_idx),	// core.scala:100:32
    .io_ren_uops_0_bits_pdst              (dis_uops_0_pdst),	// core.scala:653:28
    .io_ren_uops_0_bits_prs1              (dis_uops_0_prs1),	// core.scala:648:28
    .io_ren_uops_0_bits_prs2              (dis_uops_0_prs2),	// core.scala:650:28
    .io_ren_uops_0_bits_prs3              (_fp_rename_stage_io_ren2_uops_0_prs3),	// core.scala:101:46
    .io_ren_uops_0_bits_prs1_busy         (dis_uops_0_prs1_busy),	// core.scala:658:85
    .io_ren_uops_0_bits_prs2_busy         (dis_uops_0_prs2_busy),	// core.scala:660:85
    .io_ren_uops_0_bits_prs3_busy         (dis_uops_0_prs3_busy),	// core.scala:662:46
    .io_ren_uops_0_bits_stale_pdst        (dis_uops_0_stale_pdst),	// core.scala:656:34
    .io_ren_uops_0_bits_exception         (_rename_stage_io_ren2_uops_0_exception),	// core.scala:100:32
    .io_ren_uops_0_bits_exc_cause         (_rename_stage_io_ren2_uops_0_exc_cause),	// core.scala:100:32
    .io_ren_uops_0_bits_bypassable        (_rename_stage_io_ren2_uops_0_bypassable),	// core.scala:100:32
    .io_ren_uops_0_bits_mem_cmd           (_rename_stage_io_ren2_uops_0_mem_cmd),	// core.scala:100:32
    .io_ren_uops_0_bits_mem_size          (_rename_stage_io_ren2_uops_0_mem_size),	// core.scala:100:32
    .io_ren_uops_0_bits_mem_signed        (_rename_stage_io_ren2_uops_0_mem_signed),	// core.scala:100:32
    .io_ren_uops_0_bits_is_fence          (_rename_stage_io_ren2_uops_0_is_fence),	// core.scala:100:32
    .io_ren_uops_0_bits_is_fencei         (_rename_stage_io_ren2_uops_0_is_fencei),	// core.scala:100:32
    .io_ren_uops_0_bits_is_amo            (_rename_stage_io_ren2_uops_0_is_amo),	// core.scala:100:32
    .io_ren_uops_0_bits_uses_ldq          (_rename_stage_io_ren2_uops_0_uses_ldq),	// core.scala:100:32
    .io_ren_uops_0_bits_uses_stq          (_rename_stage_io_ren2_uops_0_uses_stq),	// core.scala:100:32
    .io_ren_uops_0_bits_is_sys_pc2epc     (_rename_stage_io_ren2_uops_0_is_sys_pc2epc),	// core.scala:100:32
    .io_ren_uops_0_bits_is_unique         (_rename_stage_io_ren2_uops_0_is_unique),	// core.scala:100:32
    .io_ren_uops_0_bits_flush_on_commit   (_rename_stage_io_ren2_uops_0_flush_on_commit),	// core.scala:100:32
    .io_ren_uops_0_bits_ldst_is_rs1       (_rename_stage_io_ren2_uops_0_ldst_is_rs1),	// core.scala:100:32
    .io_ren_uops_0_bits_ldst              (_rename_stage_io_ren2_uops_0_ldst),	// core.scala:100:32
    .io_ren_uops_0_bits_lrs1              (_rename_stage_io_ren2_uops_0_lrs1),	// core.scala:100:32
    .io_ren_uops_0_bits_lrs2              (_rename_stage_io_ren2_uops_0_lrs2),	// core.scala:100:32
    .io_ren_uops_0_bits_lrs3              (_rename_stage_io_ren2_uops_0_lrs3),	// core.scala:100:32
    .io_ren_uops_0_bits_ldst_val          (_rename_stage_io_ren2_uops_0_ldst_val),	// core.scala:100:32
    .io_ren_uops_0_bits_dst_rtype         (_rename_stage_io_ren2_uops_0_dst_rtype),	// core.scala:100:32
    .io_ren_uops_0_bits_lrs1_rtype        (_rename_stage_io_ren2_uops_0_lrs1_rtype),	// core.scala:100:32
    .io_ren_uops_0_bits_lrs2_rtype        (_rename_stage_io_ren2_uops_0_lrs2_rtype),	// core.scala:100:32
    .io_ren_uops_0_bits_frs3_en           (_rename_stage_io_ren2_uops_0_frs3_en),	// core.scala:100:32
    .io_ren_uops_0_bits_fp_val            (_rename_stage_io_ren2_uops_0_fp_val),	// core.scala:100:32
    .io_ren_uops_0_bits_fp_single         (_rename_stage_io_ren2_uops_0_fp_single),	// core.scala:100:32
    .io_ren_uops_0_bits_xcpt_pf_if        (_rename_stage_io_ren2_uops_0_xcpt_pf_if),	// core.scala:100:32
    .io_ren_uops_0_bits_xcpt_ae_if        (_rename_stage_io_ren2_uops_0_xcpt_ae_if),	// core.scala:100:32
    .io_ren_uops_0_bits_xcpt_ma_if        (_rename_stage_io_ren2_uops_0_xcpt_ma_if),	// core.scala:100:32
    .io_ren_uops_0_bits_bp_debug_if       (_rename_stage_io_ren2_uops_0_bp_debug_if),	// core.scala:100:32
    .io_ren_uops_0_bits_bp_xcpt_if        (_rename_stage_io_ren2_uops_0_bp_xcpt_if),	// core.scala:100:32
    .io_ren_uops_0_bits_debug_fsrc        (_rename_stage_io_ren2_uops_0_debug_fsrc),	// core.scala:100:32
    .io_ren_uops_0_bits_debug_tsrc        (_rename_stage_io_ren2_uops_0_debug_tsrc),	// core.scala:100:32
    .io_ren_uops_1_valid                  (dis_fire_1),	// core.scala:708:62
    .io_ren_uops_1_bits_uopc              (_rename_stage_io_ren2_uops_1_uopc),	// core.scala:100:32
    .io_ren_uops_1_bits_inst              (_rename_stage_io_ren2_uops_1_inst),	// core.scala:100:32
    .io_ren_uops_1_bits_debug_inst        (_rename_stage_io_ren2_uops_1_debug_inst),	// core.scala:100:32
    .io_ren_uops_1_bits_is_rvc            (_rename_stage_io_ren2_uops_1_is_rvc),	// core.scala:100:32
    .io_ren_uops_1_bits_debug_pc          (_rename_stage_io_ren2_uops_1_debug_pc),	// core.scala:100:32
    .io_ren_uops_1_bits_iq_type           (_rename_stage_io_ren2_uops_1_iq_type),	// core.scala:100:32
    .io_ren_uops_1_bits_fu_code           (_rename_stage_io_ren2_uops_1_fu_code),	// core.scala:100:32
    .io_ren_uops_1_bits_is_br             (_rename_stage_io_ren2_uops_1_is_br),	// core.scala:100:32
    .io_ren_uops_1_bits_is_jalr           (_rename_stage_io_ren2_uops_1_is_jalr),	// core.scala:100:32
    .io_ren_uops_1_bits_is_jal            (_rename_stage_io_ren2_uops_1_is_jal),	// core.scala:100:32
    .io_ren_uops_1_bits_is_sfb            (_rename_stage_io_ren2_uops_1_is_sfb),	// core.scala:100:32
    .io_ren_uops_1_bits_br_mask           (_rename_stage_io_ren2_uops_1_br_mask),	// core.scala:100:32
    .io_ren_uops_1_bits_br_tag            (_rename_stage_io_ren2_uops_1_br_tag),	// core.scala:100:32
    .io_ren_uops_1_bits_ftq_idx           (_rename_stage_io_ren2_uops_1_ftq_idx),	// core.scala:100:32
    .io_ren_uops_1_bits_edge_inst         (_rename_stage_io_ren2_uops_1_edge_inst),	// core.scala:100:32
    .io_ren_uops_1_bits_pc_lob            (_rename_stage_io_ren2_uops_1_pc_lob),	// core.scala:100:32
    .io_ren_uops_1_bits_taken             (_rename_stage_io_ren2_uops_1_taken),	// core.scala:100:32
    .io_ren_uops_1_bits_imm_packed        (_rename_stage_io_ren2_uops_1_imm_packed),	// core.scala:100:32
    .io_ren_uops_1_bits_csr_addr          (_rename_stage_io_ren2_uops_1_csr_addr),	// core.scala:100:32
    .io_ren_uops_1_bits_rob_idx           (dis_uops_1_rob_idx),	// core.scala:743:27
    .io_ren_uops_1_bits_ldq_idx           (io_lsu_dis_ldq_idx_1),
    .io_ren_uops_1_bits_stq_idx           (io_lsu_dis_stq_idx_1),
    .io_ren_uops_1_bits_rxq_idx           (_rename_stage_io_ren2_uops_1_rxq_idx),	// core.scala:100:32
    .io_ren_uops_1_bits_pdst              (dis_uops_1_pdst),	// core.scala:653:28
    .io_ren_uops_1_bits_prs1              (dis_uops_1_prs1),	// core.scala:648:28
    .io_ren_uops_1_bits_prs2              (dis_uops_1_prs2),	// core.scala:650:28
    .io_ren_uops_1_bits_prs3              (_fp_rename_stage_io_ren2_uops_1_prs3),	// core.scala:101:46
    .io_ren_uops_1_bits_prs1_busy         (dis_uops_1_prs1_busy),	// core.scala:658:85
    .io_ren_uops_1_bits_prs2_busy         (dis_uops_1_prs2_busy),	// core.scala:660:85
    .io_ren_uops_1_bits_prs3_busy         (dis_uops_1_prs3_busy),	// core.scala:662:46
    .io_ren_uops_1_bits_stale_pdst        (dis_uops_1_stale_pdst),	// core.scala:656:34
    .io_ren_uops_1_bits_exception         (_rename_stage_io_ren2_uops_1_exception),	// core.scala:100:32
    .io_ren_uops_1_bits_exc_cause         (_rename_stage_io_ren2_uops_1_exc_cause),	// core.scala:100:32
    .io_ren_uops_1_bits_bypassable        (_rename_stage_io_ren2_uops_1_bypassable),	// core.scala:100:32
    .io_ren_uops_1_bits_mem_cmd           (_rename_stage_io_ren2_uops_1_mem_cmd),	// core.scala:100:32
    .io_ren_uops_1_bits_mem_size          (_rename_stage_io_ren2_uops_1_mem_size),	// core.scala:100:32
    .io_ren_uops_1_bits_mem_signed        (_rename_stage_io_ren2_uops_1_mem_signed),	// core.scala:100:32
    .io_ren_uops_1_bits_is_fence          (_rename_stage_io_ren2_uops_1_is_fence),	// core.scala:100:32
    .io_ren_uops_1_bits_is_fencei         (_rename_stage_io_ren2_uops_1_is_fencei),	// core.scala:100:32
    .io_ren_uops_1_bits_is_amo            (_rename_stage_io_ren2_uops_1_is_amo),	// core.scala:100:32
    .io_ren_uops_1_bits_uses_ldq          (_rename_stage_io_ren2_uops_1_uses_ldq),	// core.scala:100:32
    .io_ren_uops_1_bits_uses_stq          (_rename_stage_io_ren2_uops_1_uses_stq),	// core.scala:100:32
    .io_ren_uops_1_bits_is_sys_pc2epc     (_rename_stage_io_ren2_uops_1_is_sys_pc2epc),	// core.scala:100:32
    .io_ren_uops_1_bits_is_unique         (_rename_stage_io_ren2_uops_1_is_unique),	// core.scala:100:32
    .io_ren_uops_1_bits_flush_on_commit   (_rename_stage_io_ren2_uops_1_flush_on_commit),	// core.scala:100:32
    .io_ren_uops_1_bits_ldst_is_rs1       (_rename_stage_io_ren2_uops_1_ldst_is_rs1),	// core.scala:100:32
    .io_ren_uops_1_bits_ldst              (_rename_stage_io_ren2_uops_1_ldst),	// core.scala:100:32
    .io_ren_uops_1_bits_lrs1              (_rename_stage_io_ren2_uops_1_lrs1),	// core.scala:100:32
    .io_ren_uops_1_bits_lrs2              (_rename_stage_io_ren2_uops_1_lrs2),	// core.scala:100:32
    .io_ren_uops_1_bits_lrs3              (_rename_stage_io_ren2_uops_1_lrs3),	// core.scala:100:32
    .io_ren_uops_1_bits_ldst_val          (_rename_stage_io_ren2_uops_1_ldst_val),	// core.scala:100:32
    .io_ren_uops_1_bits_dst_rtype         (_rename_stage_io_ren2_uops_1_dst_rtype),	// core.scala:100:32
    .io_ren_uops_1_bits_lrs1_rtype        (_rename_stage_io_ren2_uops_1_lrs1_rtype),	// core.scala:100:32
    .io_ren_uops_1_bits_lrs2_rtype        (_rename_stage_io_ren2_uops_1_lrs2_rtype),	// core.scala:100:32
    .io_ren_uops_1_bits_frs3_en           (_rename_stage_io_ren2_uops_1_frs3_en),	// core.scala:100:32
    .io_ren_uops_1_bits_fp_val            (_rename_stage_io_ren2_uops_1_fp_val),	// core.scala:100:32
    .io_ren_uops_1_bits_fp_single         (_rename_stage_io_ren2_uops_1_fp_single),	// core.scala:100:32
    .io_ren_uops_1_bits_xcpt_pf_if        (_rename_stage_io_ren2_uops_1_xcpt_pf_if),	// core.scala:100:32
    .io_ren_uops_1_bits_xcpt_ae_if        (_rename_stage_io_ren2_uops_1_xcpt_ae_if),	// core.scala:100:32
    .io_ren_uops_1_bits_xcpt_ma_if        (_rename_stage_io_ren2_uops_1_xcpt_ma_if),	// core.scala:100:32
    .io_ren_uops_1_bits_bp_debug_if       (_rename_stage_io_ren2_uops_1_bp_debug_if),	// core.scala:100:32
    .io_ren_uops_1_bits_bp_xcpt_if        (_rename_stage_io_ren2_uops_1_bp_xcpt_if),	// core.scala:100:32
    .io_ren_uops_1_bits_debug_fsrc        (_rename_stage_io_ren2_uops_1_debug_fsrc),	// core.scala:100:32
    .io_ren_uops_1_bits_debug_tsrc        (_rename_stage_io_ren2_uops_1_debug_tsrc),	// core.scala:100:32
    .io_ren_uops_2_valid                  (dis_fire_2),	// core.scala:708:62
    .io_ren_uops_2_bits_uopc              (_rename_stage_io_ren2_uops_2_uopc),	// core.scala:100:32
    .io_ren_uops_2_bits_inst              (_rename_stage_io_ren2_uops_2_inst),	// core.scala:100:32
    .io_ren_uops_2_bits_debug_inst        (_rename_stage_io_ren2_uops_2_debug_inst),	// core.scala:100:32
    .io_ren_uops_2_bits_is_rvc            (_rename_stage_io_ren2_uops_2_is_rvc),	// core.scala:100:32
    .io_ren_uops_2_bits_debug_pc          (_rename_stage_io_ren2_uops_2_debug_pc),	// core.scala:100:32
    .io_ren_uops_2_bits_iq_type           (_rename_stage_io_ren2_uops_2_iq_type),	// core.scala:100:32
    .io_ren_uops_2_bits_fu_code           (_rename_stage_io_ren2_uops_2_fu_code),	// core.scala:100:32
    .io_ren_uops_2_bits_is_br             (_rename_stage_io_ren2_uops_2_is_br),	// core.scala:100:32
    .io_ren_uops_2_bits_is_jalr           (_rename_stage_io_ren2_uops_2_is_jalr),	// core.scala:100:32
    .io_ren_uops_2_bits_is_jal            (_rename_stage_io_ren2_uops_2_is_jal),	// core.scala:100:32
    .io_ren_uops_2_bits_is_sfb            (_rename_stage_io_ren2_uops_2_is_sfb),	// core.scala:100:32
    .io_ren_uops_2_bits_br_mask           (_rename_stage_io_ren2_uops_2_br_mask),	// core.scala:100:32
    .io_ren_uops_2_bits_br_tag            (_rename_stage_io_ren2_uops_2_br_tag),	// core.scala:100:32
    .io_ren_uops_2_bits_ftq_idx           (_rename_stage_io_ren2_uops_2_ftq_idx),	// core.scala:100:32
    .io_ren_uops_2_bits_edge_inst         (_rename_stage_io_ren2_uops_2_edge_inst),	// core.scala:100:32
    .io_ren_uops_2_bits_pc_lob            (_rename_stage_io_ren2_uops_2_pc_lob),	// core.scala:100:32
    .io_ren_uops_2_bits_taken             (_rename_stage_io_ren2_uops_2_taken),	// core.scala:100:32
    .io_ren_uops_2_bits_imm_packed        (_rename_stage_io_ren2_uops_2_imm_packed),	// core.scala:100:32
    .io_ren_uops_2_bits_csr_addr          (_rename_stage_io_ren2_uops_2_csr_addr),	// core.scala:100:32
    .io_ren_uops_2_bits_rob_idx           (dis_uops_2_rob_idx),	// core.scala:743:27
    .io_ren_uops_2_bits_ldq_idx           (io_lsu_dis_ldq_idx_2),
    .io_ren_uops_2_bits_stq_idx           (io_lsu_dis_stq_idx_2),
    .io_ren_uops_2_bits_rxq_idx           (_rename_stage_io_ren2_uops_2_rxq_idx),	// core.scala:100:32
    .io_ren_uops_2_bits_pdst              (dis_uops_2_pdst),	// core.scala:653:28
    .io_ren_uops_2_bits_prs1              (dis_uops_2_prs1),	// core.scala:648:28
    .io_ren_uops_2_bits_prs2              (dis_uops_2_prs2),	// core.scala:650:28
    .io_ren_uops_2_bits_prs3              (_fp_rename_stage_io_ren2_uops_2_prs3),	// core.scala:101:46
    .io_ren_uops_2_bits_prs1_busy         (dis_uops_2_prs1_busy),	// core.scala:658:85
    .io_ren_uops_2_bits_prs2_busy         (dis_uops_2_prs2_busy),	// core.scala:660:85
    .io_ren_uops_2_bits_prs3_busy         (dis_uops_2_prs3_busy),	// core.scala:662:46
    .io_ren_uops_2_bits_stale_pdst        (dis_uops_2_stale_pdst),	// core.scala:656:34
    .io_ren_uops_2_bits_exception         (_rename_stage_io_ren2_uops_2_exception),	// core.scala:100:32
    .io_ren_uops_2_bits_exc_cause         (_rename_stage_io_ren2_uops_2_exc_cause),	// core.scala:100:32
    .io_ren_uops_2_bits_bypassable        (_rename_stage_io_ren2_uops_2_bypassable),	// core.scala:100:32
    .io_ren_uops_2_bits_mem_cmd           (_rename_stage_io_ren2_uops_2_mem_cmd),	// core.scala:100:32
    .io_ren_uops_2_bits_mem_size          (_rename_stage_io_ren2_uops_2_mem_size),	// core.scala:100:32
    .io_ren_uops_2_bits_mem_signed        (_rename_stage_io_ren2_uops_2_mem_signed),	// core.scala:100:32
    .io_ren_uops_2_bits_is_fence          (_rename_stage_io_ren2_uops_2_is_fence),	// core.scala:100:32
    .io_ren_uops_2_bits_is_fencei         (_rename_stage_io_ren2_uops_2_is_fencei),	// core.scala:100:32
    .io_ren_uops_2_bits_is_amo            (_rename_stage_io_ren2_uops_2_is_amo),	// core.scala:100:32
    .io_ren_uops_2_bits_uses_ldq          (_rename_stage_io_ren2_uops_2_uses_ldq),	// core.scala:100:32
    .io_ren_uops_2_bits_uses_stq          (_rename_stage_io_ren2_uops_2_uses_stq),	// core.scala:100:32
    .io_ren_uops_2_bits_is_sys_pc2epc     (_rename_stage_io_ren2_uops_2_is_sys_pc2epc),	// core.scala:100:32
    .io_ren_uops_2_bits_is_unique         (_rename_stage_io_ren2_uops_2_is_unique),	// core.scala:100:32
    .io_ren_uops_2_bits_flush_on_commit   (_rename_stage_io_ren2_uops_2_flush_on_commit),	// core.scala:100:32
    .io_ren_uops_2_bits_ldst_is_rs1       (_rename_stage_io_ren2_uops_2_ldst_is_rs1),	// core.scala:100:32
    .io_ren_uops_2_bits_ldst              (_rename_stage_io_ren2_uops_2_ldst),	// core.scala:100:32
    .io_ren_uops_2_bits_lrs1              (_rename_stage_io_ren2_uops_2_lrs1),	// core.scala:100:32
    .io_ren_uops_2_bits_lrs2              (_rename_stage_io_ren2_uops_2_lrs2),	// core.scala:100:32
    .io_ren_uops_2_bits_lrs3              (_rename_stage_io_ren2_uops_2_lrs3),	// core.scala:100:32
    .io_ren_uops_2_bits_ldst_val          (_rename_stage_io_ren2_uops_2_ldst_val),	// core.scala:100:32
    .io_ren_uops_2_bits_dst_rtype         (_rename_stage_io_ren2_uops_2_dst_rtype),	// core.scala:100:32
    .io_ren_uops_2_bits_lrs1_rtype        (_rename_stage_io_ren2_uops_2_lrs1_rtype),	// core.scala:100:32
    .io_ren_uops_2_bits_lrs2_rtype        (_rename_stage_io_ren2_uops_2_lrs2_rtype),	// core.scala:100:32
    .io_ren_uops_2_bits_frs3_en           (_rename_stage_io_ren2_uops_2_frs3_en),	// core.scala:100:32
    .io_ren_uops_2_bits_fp_val            (_rename_stage_io_ren2_uops_2_fp_val),	// core.scala:100:32
    .io_ren_uops_2_bits_fp_single         (_rename_stage_io_ren2_uops_2_fp_single),	// core.scala:100:32
    .io_ren_uops_2_bits_xcpt_pf_if        (_rename_stage_io_ren2_uops_2_xcpt_pf_if),	// core.scala:100:32
    .io_ren_uops_2_bits_xcpt_ae_if        (_rename_stage_io_ren2_uops_2_xcpt_ae_if),	// core.scala:100:32
    .io_ren_uops_2_bits_xcpt_ma_if        (_rename_stage_io_ren2_uops_2_xcpt_ma_if),	// core.scala:100:32
    .io_ren_uops_2_bits_bp_debug_if       (_rename_stage_io_ren2_uops_2_bp_debug_if),	// core.scala:100:32
    .io_ren_uops_2_bits_bp_xcpt_if        (_rename_stage_io_ren2_uops_2_bp_xcpt_if),	// core.scala:100:32
    .io_ren_uops_2_bits_debug_fsrc        (_rename_stage_io_ren2_uops_2_debug_fsrc),	// core.scala:100:32
    .io_ren_uops_2_bits_debug_tsrc        (_rename_stage_io_ren2_uops_2_debug_tsrc),	// core.scala:100:32
    .io_dis_uops_2_0_ready                (_fp_pipeline_io_dis_uops_0_ready),	// core.scala:77:37
    .io_dis_uops_2_1_ready                (_fp_pipeline_io_dis_uops_1_ready),	// core.scala:77:37
    .io_dis_uops_2_2_ready                (_fp_pipeline_io_dis_uops_2_ready),	// core.scala:77:37
    .io_dis_uops_1_0_ready                (_int_issue_unit_io_dis_uops_0_ready),	// core.scala:107:32
    .io_dis_uops_1_1_ready                (_int_issue_unit_io_dis_uops_1_ready),	// core.scala:107:32
    .io_dis_uops_1_2_ready                (_int_issue_unit_io_dis_uops_2_ready),	// core.scala:107:32
    .io_dis_uops_0_0_ready                (_mem_issue_unit_io_dis_uops_0_ready),	// core.scala:105:32
    .io_dis_uops_0_1_ready                (_mem_issue_unit_io_dis_uops_1_ready),	// core.scala:105:32
    .io_dis_uops_0_2_ready                (_mem_issue_unit_io_dis_uops_2_ready),	// core.scala:105:32
    .io_ren_uops_0_ready                  (_dispatcher_io_ren_uops_0_ready),
    .io_ren_uops_1_ready                  (_dispatcher_io_ren_uops_1_ready),
    .io_ren_uops_2_ready                  (_dispatcher_io_ren_uops_2_ready),
    .io_dis_uops_2_0_valid                (_dispatcher_io_dis_uops_2_0_valid),
    .io_dis_uops_2_0_bits_uopc            (_dispatcher_io_dis_uops_2_0_bits_uopc),
    .io_dis_uops_2_0_bits_inst            (_dispatcher_io_dis_uops_2_0_bits_inst),
    .io_dis_uops_2_0_bits_debug_inst      (_dispatcher_io_dis_uops_2_0_bits_debug_inst),
    .io_dis_uops_2_0_bits_is_rvc          (_dispatcher_io_dis_uops_2_0_bits_is_rvc),
    .io_dis_uops_2_0_bits_debug_pc        (_dispatcher_io_dis_uops_2_0_bits_debug_pc),
    .io_dis_uops_2_0_bits_iq_type         (_dispatcher_io_dis_uops_2_0_bits_iq_type),
    .io_dis_uops_2_0_bits_fu_code         (_dispatcher_io_dis_uops_2_0_bits_fu_code),
    .io_dis_uops_2_0_bits_is_br           (_dispatcher_io_dis_uops_2_0_bits_is_br),
    .io_dis_uops_2_0_bits_is_jalr         (_dispatcher_io_dis_uops_2_0_bits_is_jalr),
    .io_dis_uops_2_0_bits_is_jal          (_dispatcher_io_dis_uops_2_0_bits_is_jal),
    .io_dis_uops_2_0_bits_is_sfb          (_dispatcher_io_dis_uops_2_0_bits_is_sfb),
    .io_dis_uops_2_0_bits_br_mask         (_dispatcher_io_dis_uops_2_0_bits_br_mask),
    .io_dis_uops_2_0_bits_br_tag          (_dispatcher_io_dis_uops_2_0_bits_br_tag),
    .io_dis_uops_2_0_bits_ftq_idx         (_dispatcher_io_dis_uops_2_0_bits_ftq_idx),
    .io_dis_uops_2_0_bits_edge_inst       (_dispatcher_io_dis_uops_2_0_bits_edge_inst),
    .io_dis_uops_2_0_bits_pc_lob          (_dispatcher_io_dis_uops_2_0_bits_pc_lob),
    .io_dis_uops_2_0_bits_taken           (_dispatcher_io_dis_uops_2_0_bits_taken),
    .io_dis_uops_2_0_bits_imm_packed      (_dispatcher_io_dis_uops_2_0_bits_imm_packed),
    .io_dis_uops_2_0_bits_csr_addr        (_dispatcher_io_dis_uops_2_0_bits_csr_addr),
    .io_dis_uops_2_0_bits_rob_idx         (_dispatcher_io_dis_uops_2_0_bits_rob_idx),
    .io_dis_uops_2_0_bits_ldq_idx         (_dispatcher_io_dis_uops_2_0_bits_ldq_idx),
    .io_dis_uops_2_0_bits_stq_idx         (_dispatcher_io_dis_uops_2_0_bits_stq_idx),
    .io_dis_uops_2_0_bits_rxq_idx         (_dispatcher_io_dis_uops_2_0_bits_rxq_idx),
    .io_dis_uops_2_0_bits_pdst            (_dispatcher_io_dis_uops_2_0_bits_pdst),
    .io_dis_uops_2_0_bits_prs1            (_dispatcher_io_dis_uops_2_0_bits_prs1),
    .io_dis_uops_2_0_bits_prs2            (_dispatcher_io_dis_uops_2_0_bits_prs2),
    .io_dis_uops_2_0_bits_prs3            (_dispatcher_io_dis_uops_2_0_bits_prs3),
    .io_dis_uops_2_0_bits_prs1_busy       (_dispatcher_io_dis_uops_2_0_bits_prs1_busy),
    .io_dis_uops_2_0_bits_prs2_busy       (_dispatcher_io_dis_uops_2_0_bits_prs2_busy),
    .io_dis_uops_2_0_bits_prs3_busy       (_dispatcher_io_dis_uops_2_0_bits_prs3_busy),
    .io_dis_uops_2_0_bits_stale_pdst      (_dispatcher_io_dis_uops_2_0_bits_stale_pdst),
    .io_dis_uops_2_0_bits_exception       (_dispatcher_io_dis_uops_2_0_bits_exception),
    .io_dis_uops_2_0_bits_exc_cause       (_dispatcher_io_dis_uops_2_0_bits_exc_cause),
    .io_dis_uops_2_0_bits_bypassable      (_dispatcher_io_dis_uops_2_0_bits_bypassable),
    .io_dis_uops_2_0_bits_mem_cmd         (_dispatcher_io_dis_uops_2_0_bits_mem_cmd),
    .io_dis_uops_2_0_bits_mem_size        (_dispatcher_io_dis_uops_2_0_bits_mem_size),
    .io_dis_uops_2_0_bits_mem_signed      (_dispatcher_io_dis_uops_2_0_bits_mem_signed),
    .io_dis_uops_2_0_bits_is_fence        (_dispatcher_io_dis_uops_2_0_bits_is_fence),
    .io_dis_uops_2_0_bits_is_fencei       (_dispatcher_io_dis_uops_2_0_bits_is_fencei),
    .io_dis_uops_2_0_bits_is_amo          (_dispatcher_io_dis_uops_2_0_bits_is_amo),
    .io_dis_uops_2_0_bits_uses_ldq        (_dispatcher_io_dis_uops_2_0_bits_uses_ldq),
    .io_dis_uops_2_0_bits_uses_stq        (_dispatcher_io_dis_uops_2_0_bits_uses_stq),
    .io_dis_uops_2_0_bits_is_sys_pc2epc
      (_dispatcher_io_dis_uops_2_0_bits_is_sys_pc2epc),
    .io_dis_uops_2_0_bits_is_unique       (_dispatcher_io_dis_uops_2_0_bits_is_unique),
    .io_dis_uops_2_0_bits_flush_on_commit
      (_dispatcher_io_dis_uops_2_0_bits_flush_on_commit),
    .io_dis_uops_2_0_bits_ldst_is_rs1     (_dispatcher_io_dis_uops_2_0_bits_ldst_is_rs1),
    .io_dis_uops_2_0_bits_ldst            (_dispatcher_io_dis_uops_2_0_bits_ldst),
    .io_dis_uops_2_0_bits_lrs1            (_dispatcher_io_dis_uops_2_0_bits_lrs1),
    .io_dis_uops_2_0_bits_lrs2            (_dispatcher_io_dis_uops_2_0_bits_lrs2),
    .io_dis_uops_2_0_bits_lrs3            (_dispatcher_io_dis_uops_2_0_bits_lrs3),
    .io_dis_uops_2_0_bits_ldst_val        (_dispatcher_io_dis_uops_2_0_bits_ldst_val),
    .io_dis_uops_2_0_bits_dst_rtype       (_dispatcher_io_dis_uops_2_0_bits_dst_rtype),
    .io_dis_uops_2_0_bits_lrs1_rtype      (_dispatcher_io_dis_uops_2_0_bits_lrs1_rtype),
    .io_dis_uops_2_0_bits_lrs2_rtype      (_dispatcher_io_dis_uops_2_0_bits_lrs2_rtype),
    .io_dis_uops_2_0_bits_frs3_en         (_dispatcher_io_dis_uops_2_0_bits_frs3_en),
    .io_dis_uops_2_0_bits_fp_val          (_dispatcher_io_dis_uops_2_0_bits_fp_val),
    .io_dis_uops_2_0_bits_fp_single       (_dispatcher_io_dis_uops_2_0_bits_fp_single),
    .io_dis_uops_2_0_bits_xcpt_pf_if      (_dispatcher_io_dis_uops_2_0_bits_xcpt_pf_if),
    .io_dis_uops_2_0_bits_xcpt_ae_if      (_dispatcher_io_dis_uops_2_0_bits_xcpt_ae_if),
    .io_dis_uops_2_0_bits_xcpt_ma_if      (_dispatcher_io_dis_uops_2_0_bits_xcpt_ma_if),
    .io_dis_uops_2_0_bits_bp_debug_if     (_dispatcher_io_dis_uops_2_0_bits_bp_debug_if),
    .io_dis_uops_2_0_bits_bp_xcpt_if      (_dispatcher_io_dis_uops_2_0_bits_bp_xcpt_if),
    .io_dis_uops_2_0_bits_debug_fsrc      (_dispatcher_io_dis_uops_2_0_bits_debug_fsrc),
    .io_dis_uops_2_0_bits_debug_tsrc      (_dispatcher_io_dis_uops_2_0_bits_debug_tsrc),
    .io_dis_uops_2_1_valid                (_dispatcher_io_dis_uops_2_1_valid),
    .io_dis_uops_2_1_bits_uopc            (_dispatcher_io_dis_uops_2_1_bits_uopc),
    .io_dis_uops_2_1_bits_inst            (_dispatcher_io_dis_uops_2_1_bits_inst),
    .io_dis_uops_2_1_bits_debug_inst      (_dispatcher_io_dis_uops_2_1_bits_debug_inst),
    .io_dis_uops_2_1_bits_is_rvc          (_dispatcher_io_dis_uops_2_1_bits_is_rvc),
    .io_dis_uops_2_1_bits_debug_pc        (_dispatcher_io_dis_uops_2_1_bits_debug_pc),
    .io_dis_uops_2_1_bits_iq_type         (_dispatcher_io_dis_uops_2_1_bits_iq_type),
    .io_dis_uops_2_1_bits_fu_code         (_dispatcher_io_dis_uops_2_1_bits_fu_code),
    .io_dis_uops_2_1_bits_is_br           (_dispatcher_io_dis_uops_2_1_bits_is_br),
    .io_dis_uops_2_1_bits_is_jalr         (_dispatcher_io_dis_uops_2_1_bits_is_jalr),
    .io_dis_uops_2_1_bits_is_jal          (_dispatcher_io_dis_uops_2_1_bits_is_jal),
    .io_dis_uops_2_1_bits_is_sfb          (_dispatcher_io_dis_uops_2_1_bits_is_sfb),
    .io_dis_uops_2_1_bits_br_mask         (_dispatcher_io_dis_uops_2_1_bits_br_mask),
    .io_dis_uops_2_1_bits_br_tag          (_dispatcher_io_dis_uops_2_1_bits_br_tag),
    .io_dis_uops_2_1_bits_ftq_idx         (_dispatcher_io_dis_uops_2_1_bits_ftq_idx),
    .io_dis_uops_2_1_bits_edge_inst       (_dispatcher_io_dis_uops_2_1_bits_edge_inst),
    .io_dis_uops_2_1_bits_pc_lob          (_dispatcher_io_dis_uops_2_1_bits_pc_lob),
    .io_dis_uops_2_1_bits_taken           (_dispatcher_io_dis_uops_2_1_bits_taken),
    .io_dis_uops_2_1_bits_imm_packed      (_dispatcher_io_dis_uops_2_1_bits_imm_packed),
    .io_dis_uops_2_1_bits_csr_addr        (_dispatcher_io_dis_uops_2_1_bits_csr_addr),
    .io_dis_uops_2_1_bits_rob_idx         (_dispatcher_io_dis_uops_2_1_bits_rob_idx),
    .io_dis_uops_2_1_bits_ldq_idx         (_dispatcher_io_dis_uops_2_1_bits_ldq_idx),
    .io_dis_uops_2_1_bits_stq_idx         (_dispatcher_io_dis_uops_2_1_bits_stq_idx),
    .io_dis_uops_2_1_bits_rxq_idx         (_dispatcher_io_dis_uops_2_1_bits_rxq_idx),
    .io_dis_uops_2_1_bits_pdst            (_dispatcher_io_dis_uops_2_1_bits_pdst),
    .io_dis_uops_2_1_bits_prs1            (_dispatcher_io_dis_uops_2_1_bits_prs1),
    .io_dis_uops_2_1_bits_prs2            (_dispatcher_io_dis_uops_2_1_bits_prs2),
    .io_dis_uops_2_1_bits_prs3            (_dispatcher_io_dis_uops_2_1_bits_prs3),
    .io_dis_uops_2_1_bits_prs1_busy       (_dispatcher_io_dis_uops_2_1_bits_prs1_busy),
    .io_dis_uops_2_1_bits_prs2_busy       (_dispatcher_io_dis_uops_2_1_bits_prs2_busy),
    .io_dis_uops_2_1_bits_prs3_busy       (_dispatcher_io_dis_uops_2_1_bits_prs3_busy),
    .io_dis_uops_2_1_bits_stale_pdst      (_dispatcher_io_dis_uops_2_1_bits_stale_pdst),
    .io_dis_uops_2_1_bits_exception       (_dispatcher_io_dis_uops_2_1_bits_exception),
    .io_dis_uops_2_1_bits_exc_cause       (_dispatcher_io_dis_uops_2_1_bits_exc_cause),
    .io_dis_uops_2_1_bits_bypassable      (_dispatcher_io_dis_uops_2_1_bits_bypassable),
    .io_dis_uops_2_1_bits_mem_cmd         (_dispatcher_io_dis_uops_2_1_bits_mem_cmd),
    .io_dis_uops_2_1_bits_mem_size        (_dispatcher_io_dis_uops_2_1_bits_mem_size),
    .io_dis_uops_2_1_bits_mem_signed      (_dispatcher_io_dis_uops_2_1_bits_mem_signed),
    .io_dis_uops_2_1_bits_is_fence        (_dispatcher_io_dis_uops_2_1_bits_is_fence),
    .io_dis_uops_2_1_bits_is_fencei       (_dispatcher_io_dis_uops_2_1_bits_is_fencei),
    .io_dis_uops_2_1_bits_is_amo          (_dispatcher_io_dis_uops_2_1_bits_is_amo),
    .io_dis_uops_2_1_bits_uses_ldq        (_dispatcher_io_dis_uops_2_1_bits_uses_ldq),
    .io_dis_uops_2_1_bits_uses_stq        (_dispatcher_io_dis_uops_2_1_bits_uses_stq),
    .io_dis_uops_2_1_bits_is_sys_pc2epc
      (_dispatcher_io_dis_uops_2_1_bits_is_sys_pc2epc),
    .io_dis_uops_2_1_bits_is_unique       (_dispatcher_io_dis_uops_2_1_bits_is_unique),
    .io_dis_uops_2_1_bits_flush_on_commit
      (_dispatcher_io_dis_uops_2_1_bits_flush_on_commit),
    .io_dis_uops_2_1_bits_ldst_is_rs1     (_dispatcher_io_dis_uops_2_1_bits_ldst_is_rs1),
    .io_dis_uops_2_1_bits_ldst            (_dispatcher_io_dis_uops_2_1_bits_ldst),
    .io_dis_uops_2_1_bits_lrs1            (_dispatcher_io_dis_uops_2_1_bits_lrs1),
    .io_dis_uops_2_1_bits_lrs2            (_dispatcher_io_dis_uops_2_1_bits_lrs2),
    .io_dis_uops_2_1_bits_lrs3            (_dispatcher_io_dis_uops_2_1_bits_lrs3),
    .io_dis_uops_2_1_bits_ldst_val        (_dispatcher_io_dis_uops_2_1_bits_ldst_val),
    .io_dis_uops_2_1_bits_dst_rtype       (_dispatcher_io_dis_uops_2_1_bits_dst_rtype),
    .io_dis_uops_2_1_bits_lrs1_rtype      (_dispatcher_io_dis_uops_2_1_bits_lrs1_rtype),
    .io_dis_uops_2_1_bits_lrs2_rtype      (_dispatcher_io_dis_uops_2_1_bits_lrs2_rtype),
    .io_dis_uops_2_1_bits_frs3_en         (_dispatcher_io_dis_uops_2_1_bits_frs3_en),
    .io_dis_uops_2_1_bits_fp_val          (_dispatcher_io_dis_uops_2_1_bits_fp_val),
    .io_dis_uops_2_1_bits_fp_single       (_dispatcher_io_dis_uops_2_1_bits_fp_single),
    .io_dis_uops_2_1_bits_xcpt_pf_if      (_dispatcher_io_dis_uops_2_1_bits_xcpt_pf_if),
    .io_dis_uops_2_1_bits_xcpt_ae_if      (_dispatcher_io_dis_uops_2_1_bits_xcpt_ae_if),
    .io_dis_uops_2_1_bits_xcpt_ma_if      (_dispatcher_io_dis_uops_2_1_bits_xcpt_ma_if),
    .io_dis_uops_2_1_bits_bp_debug_if     (_dispatcher_io_dis_uops_2_1_bits_bp_debug_if),
    .io_dis_uops_2_1_bits_bp_xcpt_if      (_dispatcher_io_dis_uops_2_1_bits_bp_xcpt_if),
    .io_dis_uops_2_1_bits_debug_fsrc      (_dispatcher_io_dis_uops_2_1_bits_debug_fsrc),
    .io_dis_uops_2_1_bits_debug_tsrc      (_dispatcher_io_dis_uops_2_1_bits_debug_tsrc),
    .io_dis_uops_2_2_valid                (_dispatcher_io_dis_uops_2_2_valid),
    .io_dis_uops_2_2_bits_uopc            (_dispatcher_io_dis_uops_2_2_bits_uopc),
    .io_dis_uops_2_2_bits_inst            (_dispatcher_io_dis_uops_2_2_bits_inst),
    .io_dis_uops_2_2_bits_debug_inst      (_dispatcher_io_dis_uops_2_2_bits_debug_inst),
    .io_dis_uops_2_2_bits_is_rvc          (_dispatcher_io_dis_uops_2_2_bits_is_rvc),
    .io_dis_uops_2_2_bits_debug_pc        (_dispatcher_io_dis_uops_2_2_bits_debug_pc),
    .io_dis_uops_2_2_bits_iq_type         (_dispatcher_io_dis_uops_2_2_bits_iq_type),
    .io_dis_uops_2_2_bits_fu_code         (_dispatcher_io_dis_uops_2_2_bits_fu_code),
    .io_dis_uops_2_2_bits_is_br           (_dispatcher_io_dis_uops_2_2_bits_is_br),
    .io_dis_uops_2_2_bits_is_jalr         (_dispatcher_io_dis_uops_2_2_bits_is_jalr),
    .io_dis_uops_2_2_bits_is_jal          (_dispatcher_io_dis_uops_2_2_bits_is_jal),
    .io_dis_uops_2_2_bits_is_sfb          (_dispatcher_io_dis_uops_2_2_bits_is_sfb),
    .io_dis_uops_2_2_bits_br_mask         (_dispatcher_io_dis_uops_2_2_bits_br_mask),
    .io_dis_uops_2_2_bits_br_tag          (_dispatcher_io_dis_uops_2_2_bits_br_tag),
    .io_dis_uops_2_2_bits_ftq_idx         (_dispatcher_io_dis_uops_2_2_bits_ftq_idx),
    .io_dis_uops_2_2_bits_edge_inst       (_dispatcher_io_dis_uops_2_2_bits_edge_inst),
    .io_dis_uops_2_2_bits_pc_lob          (_dispatcher_io_dis_uops_2_2_bits_pc_lob),
    .io_dis_uops_2_2_bits_taken           (_dispatcher_io_dis_uops_2_2_bits_taken),
    .io_dis_uops_2_2_bits_imm_packed      (_dispatcher_io_dis_uops_2_2_bits_imm_packed),
    .io_dis_uops_2_2_bits_csr_addr        (_dispatcher_io_dis_uops_2_2_bits_csr_addr),
    .io_dis_uops_2_2_bits_rob_idx         (_dispatcher_io_dis_uops_2_2_bits_rob_idx),
    .io_dis_uops_2_2_bits_ldq_idx         (_dispatcher_io_dis_uops_2_2_bits_ldq_idx),
    .io_dis_uops_2_2_bits_stq_idx         (_dispatcher_io_dis_uops_2_2_bits_stq_idx),
    .io_dis_uops_2_2_bits_rxq_idx         (_dispatcher_io_dis_uops_2_2_bits_rxq_idx),
    .io_dis_uops_2_2_bits_pdst            (_dispatcher_io_dis_uops_2_2_bits_pdst),
    .io_dis_uops_2_2_bits_prs1            (_dispatcher_io_dis_uops_2_2_bits_prs1),
    .io_dis_uops_2_2_bits_prs2            (_dispatcher_io_dis_uops_2_2_bits_prs2),
    .io_dis_uops_2_2_bits_prs3            (_dispatcher_io_dis_uops_2_2_bits_prs3),
    .io_dis_uops_2_2_bits_prs1_busy       (_dispatcher_io_dis_uops_2_2_bits_prs1_busy),
    .io_dis_uops_2_2_bits_prs2_busy       (_dispatcher_io_dis_uops_2_2_bits_prs2_busy),
    .io_dis_uops_2_2_bits_prs3_busy       (_dispatcher_io_dis_uops_2_2_bits_prs3_busy),
    .io_dis_uops_2_2_bits_stale_pdst      (_dispatcher_io_dis_uops_2_2_bits_stale_pdst),
    .io_dis_uops_2_2_bits_exception       (_dispatcher_io_dis_uops_2_2_bits_exception),
    .io_dis_uops_2_2_bits_exc_cause       (_dispatcher_io_dis_uops_2_2_bits_exc_cause),
    .io_dis_uops_2_2_bits_bypassable      (_dispatcher_io_dis_uops_2_2_bits_bypassable),
    .io_dis_uops_2_2_bits_mem_cmd         (_dispatcher_io_dis_uops_2_2_bits_mem_cmd),
    .io_dis_uops_2_2_bits_mem_size        (_dispatcher_io_dis_uops_2_2_bits_mem_size),
    .io_dis_uops_2_2_bits_mem_signed      (_dispatcher_io_dis_uops_2_2_bits_mem_signed),
    .io_dis_uops_2_2_bits_is_fence        (_dispatcher_io_dis_uops_2_2_bits_is_fence),
    .io_dis_uops_2_2_bits_is_fencei       (_dispatcher_io_dis_uops_2_2_bits_is_fencei),
    .io_dis_uops_2_2_bits_is_amo          (_dispatcher_io_dis_uops_2_2_bits_is_amo),
    .io_dis_uops_2_2_bits_uses_ldq        (_dispatcher_io_dis_uops_2_2_bits_uses_ldq),
    .io_dis_uops_2_2_bits_uses_stq        (_dispatcher_io_dis_uops_2_2_bits_uses_stq),
    .io_dis_uops_2_2_bits_is_sys_pc2epc
      (_dispatcher_io_dis_uops_2_2_bits_is_sys_pc2epc),
    .io_dis_uops_2_2_bits_is_unique       (_dispatcher_io_dis_uops_2_2_bits_is_unique),
    .io_dis_uops_2_2_bits_flush_on_commit
      (_dispatcher_io_dis_uops_2_2_bits_flush_on_commit),
    .io_dis_uops_2_2_bits_ldst_is_rs1     (_dispatcher_io_dis_uops_2_2_bits_ldst_is_rs1),
    .io_dis_uops_2_2_bits_ldst            (_dispatcher_io_dis_uops_2_2_bits_ldst),
    .io_dis_uops_2_2_bits_lrs1            (_dispatcher_io_dis_uops_2_2_bits_lrs1),
    .io_dis_uops_2_2_bits_lrs2            (_dispatcher_io_dis_uops_2_2_bits_lrs2),
    .io_dis_uops_2_2_bits_lrs3            (_dispatcher_io_dis_uops_2_2_bits_lrs3),
    .io_dis_uops_2_2_bits_ldst_val        (_dispatcher_io_dis_uops_2_2_bits_ldst_val),
    .io_dis_uops_2_2_bits_dst_rtype       (_dispatcher_io_dis_uops_2_2_bits_dst_rtype),
    .io_dis_uops_2_2_bits_lrs1_rtype      (_dispatcher_io_dis_uops_2_2_bits_lrs1_rtype),
    .io_dis_uops_2_2_bits_lrs2_rtype      (_dispatcher_io_dis_uops_2_2_bits_lrs2_rtype),
    .io_dis_uops_2_2_bits_frs3_en         (_dispatcher_io_dis_uops_2_2_bits_frs3_en),
    .io_dis_uops_2_2_bits_fp_val          (_dispatcher_io_dis_uops_2_2_bits_fp_val),
    .io_dis_uops_2_2_bits_fp_single       (_dispatcher_io_dis_uops_2_2_bits_fp_single),
    .io_dis_uops_2_2_bits_xcpt_pf_if      (_dispatcher_io_dis_uops_2_2_bits_xcpt_pf_if),
    .io_dis_uops_2_2_bits_xcpt_ae_if      (_dispatcher_io_dis_uops_2_2_bits_xcpt_ae_if),
    .io_dis_uops_2_2_bits_xcpt_ma_if      (_dispatcher_io_dis_uops_2_2_bits_xcpt_ma_if),
    .io_dis_uops_2_2_bits_bp_debug_if     (_dispatcher_io_dis_uops_2_2_bits_bp_debug_if),
    .io_dis_uops_2_2_bits_bp_xcpt_if      (_dispatcher_io_dis_uops_2_2_bits_bp_xcpt_if),
    .io_dis_uops_2_2_bits_debug_fsrc      (_dispatcher_io_dis_uops_2_2_bits_debug_fsrc),
    .io_dis_uops_2_2_bits_debug_tsrc      (_dispatcher_io_dis_uops_2_2_bits_debug_tsrc),
    .io_dis_uops_1_0_valid                (_dispatcher_io_dis_uops_1_0_valid),
    .io_dis_uops_1_0_bits_uopc            (_dispatcher_io_dis_uops_1_0_bits_uopc),
    .io_dis_uops_1_0_bits_inst            (_dispatcher_io_dis_uops_1_0_bits_inst),
    .io_dis_uops_1_0_bits_debug_inst      (_dispatcher_io_dis_uops_1_0_bits_debug_inst),
    .io_dis_uops_1_0_bits_is_rvc          (_dispatcher_io_dis_uops_1_0_bits_is_rvc),
    .io_dis_uops_1_0_bits_debug_pc        (_dispatcher_io_dis_uops_1_0_bits_debug_pc),
    .io_dis_uops_1_0_bits_iq_type         (_dispatcher_io_dis_uops_1_0_bits_iq_type),
    .io_dis_uops_1_0_bits_fu_code         (_dispatcher_io_dis_uops_1_0_bits_fu_code),
    .io_dis_uops_1_0_bits_is_br           (_dispatcher_io_dis_uops_1_0_bits_is_br),
    .io_dis_uops_1_0_bits_is_jalr         (_dispatcher_io_dis_uops_1_0_bits_is_jalr),
    .io_dis_uops_1_0_bits_is_jal          (_dispatcher_io_dis_uops_1_0_bits_is_jal),
    .io_dis_uops_1_0_bits_is_sfb          (_dispatcher_io_dis_uops_1_0_bits_is_sfb),
    .io_dis_uops_1_0_bits_br_mask         (_dispatcher_io_dis_uops_1_0_bits_br_mask),
    .io_dis_uops_1_0_bits_br_tag          (_dispatcher_io_dis_uops_1_0_bits_br_tag),
    .io_dis_uops_1_0_bits_ftq_idx         (_dispatcher_io_dis_uops_1_0_bits_ftq_idx),
    .io_dis_uops_1_0_bits_edge_inst       (_dispatcher_io_dis_uops_1_0_bits_edge_inst),
    .io_dis_uops_1_0_bits_pc_lob          (_dispatcher_io_dis_uops_1_0_bits_pc_lob),
    .io_dis_uops_1_0_bits_taken           (_dispatcher_io_dis_uops_1_0_bits_taken),
    .io_dis_uops_1_0_bits_imm_packed      (_dispatcher_io_dis_uops_1_0_bits_imm_packed),
    .io_dis_uops_1_0_bits_csr_addr        (_dispatcher_io_dis_uops_1_0_bits_csr_addr),
    .io_dis_uops_1_0_bits_rob_idx         (_dispatcher_io_dis_uops_1_0_bits_rob_idx),
    .io_dis_uops_1_0_bits_ldq_idx         (_dispatcher_io_dis_uops_1_0_bits_ldq_idx),
    .io_dis_uops_1_0_bits_stq_idx         (_dispatcher_io_dis_uops_1_0_bits_stq_idx),
    .io_dis_uops_1_0_bits_rxq_idx         (_dispatcher_io_dis_uops_1_0_bits_rxq_idx),
    .io_dis_uops_1_0_bits_pdst            (_dispatcher_io_dis_uops_1_0_bits_pdst),
    .io_dis_uops_1_0_bits_prs1            (_dispatcher_io_dis_uops_1_0_bits_prs1),
    .io_dis_uops_1_0_bits_prs2            (_dispatcher_io_dis_uops_1_0_bits_prs2),
    .io_dis_uops_1_0_bits_prs3            (_dispatcher_io_dis_uops_1_0_bits_prs3),
    .io_dis_uops_1_0_bits_prs1_busy       (_dispatcher_io_dis_uops_1_0_bits_prs1_busy),
    .io_dis_uops_1_0_bits_prs2_busy       (_dispatcher_io_dis_uops_1_0_bits_prs2_busy),
    .io_dis_uops_1_0_bits_stale_pdst      (_dispatcher_io_dis_uops_1_0_bits_stale_pdst),
    .io_dis_uops_1_0_bits_exception       (_dispatcher_io_dis_uops_1_0_bits_exception),
    .io_dis_uops_1_0_bits_exc_cause       (_dispatcher_io_dis_uops_1_0_bits_exc_cause),
    .io_dis_uops_1_0_bits_bypassable      (_dispatcher_io_dis_uops_1_0_bits_bypassable),
    .io_dis_uops_1_0_bits_mem_cmd         (_dispatcher_io_dis_uops_1_0_bits_mem_cmd),
    .io_dis_uops_1_0_bits_mem_size        (_dispatcher_io_dis_uops_1_0_bits_mem_size),
    .io_dis_uops_1_0_bits_mem_signed      (_dispatcher_io_dis_uops_1_0_bits_mem_signed),
    .io_dis_uops_1_0_bits_is_fence        (_dispatcher_io_dis_uops_1_0_bits_is_fence),
    .io_dis_uops_1_0_bits_is_fencei       (_dispatcher_io_dis_uops_1_0_bits_is_fencei),
    .io_dis_uops_1_0_bits_is_amo          (_dispatcher_io_dis_uops_1_0_bits_is_amo),
    .io_dis_uops_1_0_bits_uses_ldq        (_dispatcher_io_dis_uops_1_0_bits_uses_ldq),
    .io_dis_uops_1_0_bits_uses_stq        (_dispatcher_io_dis_uops_1_0_bits_uses_stq),
    .io_dis_uops_1_0_bits_is_sys_pc2epc
      (_dispatcher_io_dis_uops_1_0_bits_is_sys_pc2epc),
    .io_dis_uops_1_0_bits_is_unique       (_dispatcher_io_dis_uops_1_0_bits_is_unique),
    .io_dis_uops_1_0_bits_flush_on_commit
      (_dispatcher_io_dis_uops_1_0_bits_flush_on_commit),
    .io_dis_uops_1_0_bits_ldst_is_rs1     (_dispatcher_io_dis_uops_1_0_bits_ldst_is_rs1),
    .io_dis_uops_1_0_bits_ldst            (_dispatcher_io_dis_uops_1_0_bits_ldst),
    .io_dis_uops_1_0_bits_lrs1            (_dispatcher_io_dis_uops_1_0_bits_lrs1),
    .io_dis_uops_1_0_bits_lrs2            (_dispatcher_io_dis_uops_1_0_bits_lrs2),
    .io_dis_uops_1_0_bits_lrs3            (_dispatcher_io_dis_uops_1_0_bits_lrs3),
    .io_dis_uops_1_0_bits_ldst_val        (_dispatcher_io_dis_uops_1_0_bits_ldst_val),
    .io_dis_uops_1_0_bits_dst_rtype       (_dispatcher_io_dis_uops_1_0_bits_dst_rtype),
    .io_dis_uops_1_0_bits_lrs1_rtype      (_dispatcher_io_dis_uops_1_0_bits_lrs1_rtype),
    .io_dis_uops_1_0_bits_lrs2_rtype      (_dispatcher_io_dis_uops_1_0_bits_lrs2_rtype),
    .io_dis_uops_1_0_bits_frs3_en         (_dispatcher_io_dis_uops_1_0_bits_frs3_en),
    .io_dis_uops_1_0_bits_fp_val          (_dispatcher_io_dis_uops_1_0_bits_fp_val),
    .io_dis_uops_1_0_bits_fp_single       (_dispatcher_io_dis_uops_1_0_bits_fp_single),
    .io_dis_uops_1_0_bits_xcpt_pf_if      (_dispatcher_io_dis_uops_1_0_bits_xcpt_pf_if),
    .io_dis_uops_1_0_bits_xcpt_ae_if      (_dispatcher_io_dis_uops_1_0_bits_xcpt_ae_if),
    .io_dis_uops_1_0_bits_xcpt_ma_if      (_dispatcher_io_dis_uops_1_0_bits_xcpt_ma_if),
    .io_dis_uops_1_0_bits_bp_debug_if     (_dispatcher_io_dis_uops_1_0_bits_bp_debug_if),
    .io_dis_uops_1_0_bits_bp_xcpt_if      (_dispatcher_io_dis_uops_1_0_bits_bp_xcpt_if),
    .io_dis_uops_1_0_bits_debug_fsrc      (_dispatcher_io_dis_uops_1_0_bits_debug_fsrc),
    .io_dis_uops_1_0_bits_debug_tsrc      (_dispatcher_io_dis_uops_1_0_bits_debug_tsrc),
    .io_dis_uops_1_1_valid                (_dispatcher_io_dis_uops_1_1_valid),
    .io_dis_uops_1_1_bits_uopc            (_dispatcher_io_dis_uops_1_1_bits_uopc),
    .io_dis_uops_1_1_bits_inst            (_dispatcher_io_dis_uops_1_1_bits_inst),
    .io_dis_uops_1_1_bits_debug_inst      (_dispatcher_io_dis_uops_1_1_bits_debug_inst),
    .io_dis_uops_1_1_bits_is_rvc          (_dispatcher_io_dis_uops_1_1_bits_is_rvc),
    .io_dis_uops_1_1_bits_debug_pc        (_dispatcher_io_dis_uops_1_1_bits_debug_pc),
    .io_dis_uops_1_1_bits_iq_type         (_dispatcher_io_dis_uops_1_1_bits_iq_type),
    .io_dis_uops_1_1_bits_fu_code         (_dispatcher_io_dis_uops_1_1_bits_fu_code),
    .io_dis_uops_1_1_bits_is_br           (_dispatcher_io_dis_uops_1_1_bits_is_br),
    .io_dis_uops_1_1_bits_is_jalr         (_dispatcher_io_dis_uops_1_1_bits_is_jalr),
    .io_dis_uops_1_1_bits_is_jal          (_dispatcher_io_dis_uops_1_1_bits_is_jal),
    .io_dis_uops_1_1_bits_is_sfb          (_dispatcher_io_dis_uops_1_1_bits_is_sfb),
    .io_dis_uops_1_1_bits_br_mask         (_dispatcher_io_dis_uops_1_1_bits_br_mask),
    .io_dis_uops_1_1_bits_br_tag          (_dispatcher_io_dis_uops_1_1_bits_br_tag),
    .io_dis_uops_1_1_bits_ftq_idx         (_dispatcher_io_dis_uops_1_1_bits_ftq_idx),
    .io_dis_uops_1_1_bits_edge_inst       (_dispatcher_io_dis_uops_1_1_bits_edge_inst),
    .io_dis_uops_1_1_bits_pc_lob          (_dispatcher_io_dis_uops_1_1_bits_pc_lob),
    .io_dis_uops_1_1_bits_taken           (_dispatcher_io_dis_uops_1_1_bits_taken),
    .io_dis_uops_1_1_bits_imm_packed      (_dispatcher_io_dis_uops_1_1_bits_imm_packed),
    .io_dis_uops_1_1_bits_csr_addr        (_dispatcher_io_dis_uops_1_1_bits_csr_addr),
    .io_dis_uops_1_1_bits_rob_idx         (_dispatcher_io_dis_uops_1_1_bits_rob_idx),
    .io_dis_uops_1_1_bits_ldq_idx         (_dispatcher_io_dis_uops_1_1_bits_ldq_idx),
    .io_dis_uops_1_1_bits_stq_idx         (_dispatcher_io_dis_uops_1_1_bits_stq_idx),
    .io_dis_uops_1_1_bits_rxq_idx         (_dispatcher_io_dis_uops_1_1_bits_rxq_idx),
    .io_dis_uops_1_1_bits_pdst            (_dispatcher_io_dis_uops_1_1_bits_pdst),
    .io_dis_uops_1_1_bits_prs1            (_dispatcher_io_dis_uops_1_1_bits_prs1),
    .io_dis_uops_1_1_bits_prs2            (_dispatcher_io_dis_uops_1_1_bits_prs2),
    .io_dis_uops_1_1_bits_prs3            (_dispatcher_io_dis_uops_1_1_bits_prs3),
    .io_dis_uops_1_1_bits_prs1_busy       (_dispatcher_io_dis_uops_1_1_bits_prs1_busy),
    .io_dis_uops_1_1_bits_prs2_busy       (_dispatcher_io_dis_uops_1_1_bits_prs2_busy),
    .io_dis_uops_1_1_bits_stale_pdst      (_dispatcher_io_dis_uops_1_1_bits_stale_pdst),
    .io_dis_uops_1_1_bits_exception       (_dispatcher_io_dis_uops_1_1_bits_exception),
    .io_dis_uops_1_1_bits_exc_cause       (_dispatcher_io_dis_uops_1_1_bits_exc_cause),
    .io_dis_uops_1_1_bits_bypassable      (_dispatcher_io_dis_uops_1_1_bits_bypassable),
    .io_dis_uops_1_1_bits_mem_cmd         (_dispatcher_io_dis_uops_1_1_bits_mem_cmd),
    .io_dis_uops_1_1_bits_mem_size        (_dispatcher_io_dis_uops_1_1_bits_mem_size),
    .io_dis_uops_1_1_bits_mem_signed      (_dispatcher_io_dis_uops_1_1_bits_mem_signed),
    .io_dis_uops_1_1_bits_is_fence        (_dispatcher_io_dis_uops_1_1_bits_is_fence),
    .io_dis_uops_1_1_bits_is_fencei       (_dispatcher_io_dis_uops_1_1_bits_is_fencei),
    .io_dis_uops_1_1_bits_is_amo          (_dispatcher_io_dis_uops_1_1_bits_is_amo),
    .io_dis_uops_1_1_bits_uses_ldq        (_dispatcher_io_dis_uops_1_1_bits_uses_ldq),
    .io_dis_uops_1_1_bits_uses_stq        (_dispatcher_io_dis_uops_1_1_bits_uses_stq),
    .io_dis_uops_1_1_bits_is_sys_pc2epc
      (_dispatcher_io_dis_uops_1_1_bits_is_sys_pc2epc),
    .io_dis_uops_1_1_bits_is_unique       (_dispatcher_io_dis_uops_1_1_bits_is_unique),
    .io_dis_uops_1_1_bits_flush_on_commit
      (_dispatcher_io_dis_uops_1_1_bits_flush_on_commit),
    .io_dis_uops_1_1_bits_ldst_is_rs1     (_dispatcher_io_dis_uops_1_1_bits_ldst_is_rs1),
    .io_dis_uops_1_1_bits_ldst            (_dispatcher_io_dis_uops_1_1_bits_ldst),
    .io_dis_uops_1_1_bits_lrs1            (_dispatcher_io_dis_uops_1_1_bits_lrs1),
    .io_dis_uops_1_1_bits_lrs2            (_dispatcher_io_dis_uops_1_1_bits_lrs2),
    .io_dis_uops_1_1_bits_lrs3            (_dispatcher_io_dis_uops_1_1_bits_lrs3),
    .io_dis_uops_1_1_bits_ldst_val        (_dispatcher_io_dis_uops_1_1_bits_ldst_val),
    .io_dis_uops_1_1_bits_dst_rtype       (_dispatcher_io_dis_uops_1_1_bits_dst_rtype),
    .io_dis_uops_1_1_bits_lrs1_rtype      (_dispatcher_io_dis_uops_1_1_bits_lrs1_rtype),
    .io_dis_uops_1_1_bits_lrs2_rtype      (_dispatcher_io_dis_uops_1_1_bits_lrs2_rtype),
    .io_dis_uops_1_1_bits_frs3_en         (_dispatcher_io_dis_uops_1_1_bits_frs3_en),
    .io_dis_uops_1_1_bits_fp_val          (_dispatcher_io_dis_uops_1_1_bits_fp_val),
    .io_dis_uops_1_1_bits_fp_single       (_dispatcher_io_dis_uops_1_1_bits_fp_single),
    .io_dis_uops_1_1_bits_xcpt_pf_if      (_dispatcher_io_dis_uops_1_1_bits_xcpt_pf_if),
    .io_dis_uops_1_1_bits_xcpt_ae_if      (_dispatcher_io_dis_uops_1_1_bits_xcpt_ae_if),
    .io_dis_uops_1_1_bits_xcpt_ma_if      (_dispatcher_io_dis_uops_1_1_bits_xcpt_ma_if),
    .io_dis_uops_1_1_bits_bp_debug_if     (_dispatcher_io_dis_uops_1_1_bits_bp_debug_if),
    .io_dis_uops_1_1_bits_bp_xcpt_if      (_dispatcher_io_dis_uops_1_1_bits_bp_xcpt_if),
    .io_dis_uops_1_1_bits_debug_fsrc      (_dispatcher_io_dis_uops_1_1_bits_debug_fsrc),
    .io_dis_uops_1_1_bits_debug_tsrc      (_dispatcher_io_dis_uops_1_1_bits_debug_tsrc),
    .io_dis_uops_1_2_valid                (_dispatcher_io_dis_uops_1_2_valid),
    .io_dis_uops_1_2_bits_uopc            (_dispatcher_io_dis_uops_1_2_bits_uopc),
    .io_dis_uops_1_2_bits_inst            (_dispatcher_io_dis_uops_1_2_bits_inst),
    .io_dis_uops_1_2_bits_debug_inst      (_dispatcher_io_dis_uops_1_2_bits_debug_inst),
    .io_dis_uops_1_2_bits_is_rvc          (_dispatcher_io_dis_uops_1_2_bits_is_rvc),
    .io_dis_uops_1_2_bits_debug_pc        (_dispatcher_io_dis_uops_1_2_bits_debug_pc),
    .io_dis_uops_1_2_bits_iq_type         (_dispatcher_io_dis_uops_1_2_bits_iq_type),
    .io_dis_uops_1_2_bits_fu_code         (_dispatcher_io_dis_uops_1_2_bits_fu_code),
    .io_dis_uops_1_2_bits_is_br           (_dispatcher_io_dis_uops_1_2_bits_is_br),
    .io_dis_uops_1_2_bits_is_jalr         (_dispatcher_io_dis_uops_1_2_bits_is_jalr),
    .io_dis_uops_1_2_bits_is_jal          (_dispatcher_io_dis_uops_1_2_bits_is_jal),
    .io_dis_uops_1_2_bits_is_sfb          (_dispatcher_io_dis_uops_1_2_bits_is_sfb),
    .io_dis_uops_1_2_bits_br_mask         (_dispatcher_io_dis_uops_1_2_bits_br_mask),
    .io_dis_uops_1_2_bits_br_tag          (_dispatcher_io_dis_uops_1_2_bits_br_tag),
    .io_dis_uops_1_2_bits_ftq_idx         (_dispatcher_io_dis_uops_1_2_bits_ftq_idx),
    .io_dis_uops_1_2_bits_edge_inst       (_dispatcher_io_dis_uops_1_2_bits_edge_inst),
    .io_dis_uops_1_2_bits_pc_lob          (_dispatcher_io_dis_uops_1_2_bits_pc_lob),
    .io_dis_uops_1_2_bits_taken           (_dispatcher_io_dis_uops_1_2_bits_taken),
    .io_dis_uops_1_2_bits_imm_packed      (_dispatcher_io_dis_uops_1_2_bits_imm_packed),
    .io_dis_uops_1_2_bits_csr_addr        (_dispatcher_io_dis_uops_1_2_bits_csr_addr),
    .io_dis_uops_1_2_bits_rob_idx         (_dispatcher_io_dis_uops_1_2_bits_rob_idx),
    .io_dis_uops_1_2_bits_ldq_idx         (_dispatcher_io_dis_uops_1_2_bits_ldq_idx),
    .io_dis_uops_1_2_bits_stq_idx         (_dispatcher_io_dis_uops_1_2_bits_stq_idx),
    .io_dis_uops_1_2_bits_rxq_idx         (_dispatcher_io_dis_uops_1_2_bits_rxq_idx),
    .io_dis_uops_1_2_bits_pdst            (_dispatcher_io_dis_uops_1_2_bits_pdst),
    .io_dis_uops_1_2_bits_prs1            (_dispatcher_io_dis_uops_1_2_bits_prs1),
    .io_dis_uops_1_2_bits_prs2            (_dispatcher_io_dis_uops_1_2_bits_prs2),
    .io_dis_uops_1_2_bits_prs3            (_dispatcher_io_dis_uops_1_2_bits_prs3),
    .io_dis_uops_1_2_bits_prs1_busy       (_dispatcher_io_dis_uops_1_2_bits_prs1_busy),
    .io_dis_uops_1_2_bits_prs2_busy       (_dispatcher_io_dis_uops_1_2_bits_prs2_busy),
    .io_dis_uops_1_2_bits_stale_pdst      (_dispatcher_io_dis_uops_1_2_bits_stale_pdst),
    .io_dis_uops_1_2_bits_exception       (_dispatcher_io_dis_uops_1_2_bits_exception),
    .io_dis_uops_1_2_bits_exc_cause       (_dispatcher_io_dis_uops_1_2_bits_exc_cause),
    .io_dis_uops_1_2_bits_bypassable      (_dispatcher_io_dis_uops_1_2_bits_bypassable),
    .io_dis_uops_1_2_bits_mem_cmd         (_dispatcher_io_dis_uops_1_2_bits_mem_cmd),
    .io_dis_uops_1_2_bits_mem_size        (_dispatcher_io_dis_uops_1_2_bits_mem_size),
    .io_dis_uops_1_2_bits_mem_signed      (_dispatcher_io_dis_uops_1_2_bits_mem_signed),
    .io_dis_uops_1_2_bits_is_fence        (_dispatcher_io_dis_uops_1_2_bits_is_fence),
    .io_dis_uops_1_2_bits_is_fencei       (_dispatcher_io_dis_uops_1_2_bits_is_fencei),
    .io_dis_uops_1_2_bits_is_amo          (_dispatcher_io_dis_uops_1_2_bits_is_amo),
    .io_dis_uops_1_2_bits_uses_ldq        (_dispatcher_io_dis_uops_1_2_bits_uses_ldq),
    .io_dis_uops_1_2_bits_uses_stq        (_dispatcher_io_dis_uops_1_2_bits_uses_stq),
    .io_dis_uops_1_2_bits_is_sys_pc2epc
      (_dispatcher_io_dis_uops_1_2_bits_is_sys_pc2epc),
    .io_dis_uops_1_2_bits_is_unique       (_dispatcher_io_dis_uops_1_2_bits_is_unique),
    .io_dis_uops_1_2_bits_flush_on_commit
      (_dispatcher_io_dis_uops_1_2_bits_flush_on_commit),
    .io_dis_uops_1_2_bits_ldst_is_rs1     (_dispatcher_io_dis_uops_1_2_bits_ldst_is_rs1),
    .io_dis_uops_1_2_bits_ldst            (_dispatcher_io_dis_uops_1_2_bits_ldst),
    .io_dis_uops_1_2_bits_lrs1            (_dispatcher_io_dis_uops_1_2_bits_lrs1),
    .io_dis_uops_1_2_bits_lrs2            (_dispatcher_io_dis_uops_1_2_bits_lrs2),
    .io_dis_uops_1_2_bits_lrs3            (_dispatcher_io_dis_uops_1_2_bits_lrs3),
    .io_dis_uops_1_2_bits_ldst_val        (_dispatcher_io_dis_uops_1_2_bits_ldst_val),
    .io_dis_uops_1_2_bits_dst_rtype       (_dispatcher_io_dis_uops_1_2_bits_dst_rtype),
    .io_dis_uops_1_2_bits_lrs1_rtype      (_dispatcher_io_dis_uops_1_2_bits_lrs1_rtype),
    .io_dis_uops_1_2_bits_lrs2_rtype      (_dispatcher_io_dis_uops_1_2_bits_lrs2_rtype),
    .io_dis_uops_1_2_bits_frs3_en         (_dispatcher_io_dis_uops_1_2_bits_frs3_en),
    .io_dis_uops_1_2_bits_fp_val          (_dispatcher_io_dis_uops_1_2_bits_fp_val),
    .io_dis_uops_1_2_bits_fp_single       (_dispatcher_io_dis_uops_1_2_bits_fp_single),
    .io_dis_uops_1_2_bits_xcpt_pf_if      (_dispatcher_io_dis_uops_1_2_bits_xcpt_pf_if),
    .io_dis_uops_1_2_bits_xcpt_ae_if      (_dispatcher_io_dis_uops_1_2_bits_xcpt_ae_if),
    .io_dis_uops_1_2_bits_xcpt_ma_if      (_dispatcher_io_dis_uops_1_2_bits_xcpt_ma_if),
    .io_dis_uops_1_2_bits_bp_debug_if     (_dispatcher_io_dis_uops_1_2_bits_bp_debug_if),
    .io_dis_uops_1_2_bits_bp_xcpt_if      (_dispatcher_io_dis_uops_1_2_bits_bp_xcpt_if),
    .io_dis_uops_1_2_bits_debug_fsrc      (_dispatcher_io_dis_uops_1_2_bits_debug_fsrc),
    .io_dis_uops_1_2_bits_debug_tsrc      (_dispatcher_io_dis_uops_1_2_bits_debug_tsrc),
    .io_dis_uops_0_0_valid                (_dispatcher_io_dis_uops_0_0_valid),
    .io_dis_uops_0_0_bits_uopc            (_dispatcher_io_dis_uops_0_0_bits_uopc),
    .io_dis_uops_0_0_bits_inst            (_dispatcher_io_dis_uops_0_0_bits_inst),
    .io_dis_uops_0_0_bits_debug_inst      (_dispatcher_io_dis_uops_0_0_bits_debug_inst),
    .io_dis_uops_0_0_bits_is_rvc          (_dispatcher_io_dis_uops_0_0_bits_is_rvc),
    .io_dis_uops_0_0_bits_debug_pc        (_dispatcher_io_dis_uops_0_0_bits_debug_pc),
    .io_dis_uops_0_0_bits_iq_type         (_dispatcher_io_dis_uops_0_0_bits_iq_type),
    .io_dis_uops_0_0_bits_fu_code         (_dispatcher_io_dis_uops_0_0_bits_fu_code),
    .io_dis_uops_0_0_bits_is_br           (_dispatcher_io_dis_uops_0_0_bits_is_br),
    .io_dis_uops_0_0_bits_is_jalr         (_dispatcher_io_dis_uops_0_0_bits_is_jalr),
    .io_dis_uops_0_0_bits_is_jal          (_dispatcher_io_dis_uops_0_0_bits_is_jal),
    .io_dis_uops_0_0_bits_is_sfb          (_dispatcher_io_dis_uops_0_0_bits_is_sfb),
    .io_dis_uops_0_0_bits_br_mask         (_dispatcher_io_dis_uops_0_0_bits_br_mask),
    .io_dis_uops_0_0_bits_br_tag          (_dispatcher_io_dis_uops_0_0_bits_br_tag),
    .io_dis_uops_0_0_bits_ftq_idx         (_dispatcher_io_dis_uops_0_0_bits_ftq_idx),
    .io_dis_uops_0_0_bits_edge_inst       (_dispatcher_io_dis_uops_0_0_bits_edge_inst),
    .io_dis_uops_0_0_bits_pc_lob          (_dispatcher_io_dis_uops_0_0_bits_pc_lob),
    .io_dis_uops_0_0_bits_taken           (_dispatcher_io_dis_uops_0_0_bits_taken),
    .io_dis_uops_0_0_bits_imm_packed      (_dispatcher_io_dis_uops_0_0_bits_imm_packed),
    .io_dis_uops_0_0_bits_csr_addr        (_dispatcher_io_dis_uops_0_0_bits_csr_addr),
    .io_dis_uops_0_0_bits_rob_idx         (_dispatcher_io_dis_uops_0_0_bits_rob_idx),
    .io_dis_uops_0_0_bits_ldq_idx         (_dispatcher_io_dis_uops_0_0_bits_ldq_idx),
    .io_dis_uops_0_0_bits_stq_idx         (_dispatcher_io_dis_uops_0_0_bits_stq_idx),
    .io_dis_uops_0_0_bits_rxq_idx         (_dispatcher_io_dis_uops_0_0_bits_rxq_idx),
    .io_dis_uops_0_0_bits_pdst            (_dispatcher_io_dis_uops_0_0_bits_pdst),
    .io_dis_uops_0_0_bits_prs1            (_dispatcher_io_dis_uops_0_0_bits_prs1),
    .io_dis_uops_0_0_bits_prs2            (_dispatcher_io_dis_uops_0_0_bits_prs2),
    .io_dis_uops_0_0_bits_prs3            (_dispatcher_io_dis_uops_0_0_bits_prs3),
    .io_dis_uops_0_0_bits_prs1_busy       (_dispatcher_io_dis_uops_0_0_bits_prs1_busy),
    .io_dis_uops_0_0_bits_prs2_busy       (_dispatcher_io_dis_uops_0_0_bits_prs2_busy),
    .io_dis_uops_0_0_bits_stale_pdst      (_dispatcher_io_dis_uops_0_0_bits_stale_pdst),
    .io_dis_uops_0_0_bits_exception       (_dispatcher_io_dis_uops_0_0_bits_exception),
    .io_dis_uops_0_0_bits_exc_cause       (_dispatcher_io_dis_uops_0_0_bits_exc_cause),
    .io_dis_uops_0_0_bits_bypassable      (_dispatcher_io_dis_uops_0_0_bits_bypassable),
    .io_dis_uops_0_0_bits_mem_cmd         (_dispatcher_io_dis_uops_0_0_bits_mem_cmd),
    .io_dis_uops_0_0_bits_mem_size        (_dispatcher_io_dis_uops_0_0_bits_mem_size),
    .io_dis_uops_0_0_bits_mem_signed      (_dispatcher_io_dis_uops_0_0_bits_mem_signed),
    .io_dis_uops_0_0_bits_is_fence        (_dispatcher_io_dis_uops_0_0_bits_is_fence),
    .io_dis_uops_0_0_bits_is_fencei       (_dispatcher_io_dis_uops_0_0_bits_is_fencei),
    .io_dis_uops_0_0_bits_is_amo          (_dispatcher_io_dis_uops_0_0_bits_is_amo),
    .io_dis_uops_0_0_bits_uses_ldq        (_dispatcher_io_dis_uops_0_0_bits_uses_ldq),
    .io_dis_uops_0_0_bits_uses_stq        (_dispatcher_io_dis_uops_0_0_bits_uses_stq),
    .io_dis_uops_0_0_bits_is_sys_pc2epc
      (_dispatcher_io_dis_uops_0_0_bits_is_sys_pc2epc),
    .io_dis_uops_0_0_bits_is_unique       (_dispatcher_io_dis_uops_0_0_bits_is_unique),
    .io_dis_uops_0_0_bits_flush_on_commit
      (_dispatcher_io_dis_uops_0_0_bits_flush_on_commit),
    .io_dis_uops_0_0_bits_ldst_is_rs1     (_dispatcher_io_dis_uops_0_0_bits_ldst_is_rs1),
    .io_dis_uops_0_0_bits_ldst            (_dispatcher_io_dis_uops_0_0_bits_ldst),
    .io_dis_uops_0_0_bits_lrs1            (_dispatcher_io_dis_uops_0_0_bits_lrs1),
    .io_dis_uops_0_0_bits_lrs2            (_dispatcher_io_dis_uops_0_0_bits_lrs2),
    .io_dis_uops_0_0_bits_lrs3            (_dispatcher_io_dis_uops_0_0_bits_lrs3),
    .io_dis_uops_0_0_bits_ldst_val        (_dispatcher_io_dis_uops_0_0_bits_ldst_val),
    .io_dis_uops_0_0_bits_dst_rtype       (_dispatcher_io_dis_uops_0_0_bits_dst_rtype),
    .io_dis_uops_0_0_bits_lrs1_rtype      (_dispatcher_io_dis_uops_0_0_bits_lrs1_rtype),
    .io_dis_uops_0_0_bits_lrs2_rtype      (_dispatcher_io_dis_uops_0_0_bits_lrs2_rtype),
    .io_dis_uops_0_0_bits_frs3_en         (_dispatcher_io_dis_uops_0_0_bits_frs3_en),
    .io_dis_uops_0_0_bits_fp_val          (_dispatcher_io_dis_uops_0_0_bits_fp_val),
    .io_dis_uops_0_0_bits_fp_single       (_dispatcher_io_dis_uops_0_0_bits_fp_single),
    .io_dis_uops_0_0_bits_xcpt_pf_if      (_dispatcher_io_dis_uops_0_0_bits_xcpt_pf_if),
    .io_dis_uops_0_0_bits_xcpt_ae_if      (_dispatcher_io_dis_uops_0_0_bits_xcpt_ae_if),
    .io_dis_uops_0_0_bits_xcpt_ma_if      (_dispatcher_io_dis_uops_0_0_bits_xcpt_ma_if),
    .io_dis_uops_0_0_bits_bp_debug_if     (_dispatcher_io_dis_uops_0_0_bits_bp_debug_if),
    .io_dis_uops_0_0_bits_bp_xcpt_if      (_dispatcher_io_dis_uops_0_0_bits_bp_xcpt_if),
    .io_dis_uops_0_0_bits_debug_fsrc      (_dispatcher_io_dis_uops_0_0_bits_debug_fsrc),
    .io_dis_uops_0_0_bits_debug_tsrc      (_dispatcher_io_dis_uops_0_0_bits_debug_tsrc),
    .io_dis_uops_0_1_valid                (_dispatcher_io_dis_uops_0_1_valid),
    .io_dis_uops_0_1_bits_uopc            (_dispatcher_io_dis_uops_0_1_bits_uopc),
    .io_dis_uops_0_1_bits_inst            (_dispatcher_io_dis_uops_0_1_bits_inst),
    .io_dis_uops_0_1_bits_debug_inst      (_dispatcher_io_dis_uops_0_1_bits_debug_inst),
    .io_dis_uops_0_1_bits_is_rvc          (_dispatcher_io_dis_uops_0_1_bits_is_rvc),
    .io_dis_uops_0_1_bits_debug_pc        (_dispatcher_io_dis_uops_0_1_bits_debug_pc),
    .io_dis_uops_0_1_bits_iq_type         (_dispatcher_io_dis_uops_0_1_bits_iq_type),
    .io_dis_uops_0_1_bits_fu_code         (_dispatcher_io_dis_uops_0_1_bits_fu_code),
    .io_dis_uops_0_1_bits_is_br           (_dispatcher_io_dis_uops_0_1_bits_is_br),
    .io_dis_uops_0_1_bits_is_jalr         (_dispatcher_io_dis_uops_0_1_bits_is_jalr),
    .io_dis_uops_0_1_bits_is_jal          (_dispatcher_io_dis_uops_0_1_bits_is_jal),
    .io_dis_uops_0_1_bits_is_sfb          (_dispatcher_io_dis_uops_0_1_bits_is_sfb),
    .io_dis_uops_0_1_bits_br_mask         (_dispatcher_io_dis_uops_0_1_bits_br_mask),
    .io_dis_uops_0_1_bits_br_tag          (_dispatcher_io_dis_uops_0_1_bits_br_tag),
    .io_dis_uops_0_1_bits_ftq_idx         (_dispatcher_io_dis_uops_0_1_bits_ftq_idx),
    .io_dis_uops_0_1_bits_edge_inst       (_dispatcher_io_dis_uops_0_1_bits_edge_inst),
    .io_dis_uops_0_1_bits_pc_lob          (_dispatcher_io_dis_uops_0_1_bits_pc_lob),
    .io_dis_uops_0_1_bits_taken           (_dispatcher_io_dis_uops_0_1_bits_taken),
    .io_dis_uops_0_1_bits_imm_packed      (_dispatcher_io_dis_uops_0_1_bits_imm_packed),
    .io_dis_uops_0_1_bits_csr_addr        (_dispatcher_io_dis_uops_0_1_bits_csr_addr),
    .io_dis_uops_0_1_bits_rob_idx         (_dispatcher_io_dis_uops_0_1_bits_rob_idx),
    .io_dis_uops_0_1_bits_ldq_idx         (_dispatcher_io_dis_uops_0_1_bits_ldq_idx),
    .io_dis_uops_0_1_bits_stq_idx         (_dispatcher_io_dis_uops_0_1_bits_stq_idx),
    .io_dis_uops_0_1_bits_rxq_idx         (_dispatcher_io_dis_uops_0_1_bits_rxq_idx),
    .io_dis_uops_0_1_bits_pdst            (_dispatcher_io_dis_uops_0_1_bits_pdst),
    .io_dis_uops_0_1_bits_prs1            (_dispatcher_io_dis_uops_0_1_bits_prs1),
    .io_dis_uops_0_1_bits_prs2            (_dispatcher_io_dis_uops_0_1_bits_prs2),
    .io_dis_uops_0_1_bits_prs3            (_dispatcher_io_dis_uops_0_1_bits_prs3),
    .io_dis_uops_0_1_bits_prs1_busy       (_dispatcher_io_dis_uops_0_1_bits_prs1_busy),
    .io_dis_uops_0_1_bits_prs2_busy       (_dispatcher_io_dis_uops_0_1_bits_prs2_busy),
    .io_dis_uops_0_1_bits_stale_pdst      (_dispatcher_io_dis_uops_0_1_bits_stale_pdst),
    .io_dis_uops_0_1_bits_exception       (_dispatcher_io_dis_uops_0_1_bits_exception),
    .io_dis_uops_0_1_bits_exc_cause       (_dispatcher_io_dis_uops_0_1_bits_exc_cause),
    .io_dis_uops_0_1_bits_bypassable      (_dispatcher_io_dis_uops_0_1_bits_bypassable),
    .io_dis_uops_0_1_bits_mem_cmd         (_dispatcher_io_dis_uops_0_1_bits_mem_cmd),
    .io_dis_uops_0_1_bits_mem_size        (_dispatcher_io_dis_uops_0_1_bits_mem_size),
    .io_dis_uops_0_1_bits_mem_signed      (_dispatcher_io_dis_uops_0_1_bits_mem_signed),
    .io_dis_uops_0_1_bits_is_fence        (_dispatcher_io_dis_uops_0_1_bits_is_fence),
    .io_dis_uops_0_1_bits_is_fencei       (_dispatcher_io_dis_uops_0_1_bits_is_fencei),
    .io_dis_uops_0_1_bits_is_amo          (_dispatcher_io_dis_uops_0_1_bits_is_amo),
    .io_dis_uops_0_1_bits_uses_ldq        (_dispatcher_io_dis_uops_0_1_bits_uses_ldq),
    .io_dis_uops_0_1_bits_uses_stq        (_dispatcher_io_dis_uops_0_1_bits_uses_stq),
    .io_dis_uops_0_1_bits_is_sys_pc2epc
      (_dispatcher_io_dis_uops_0_1_bits_is_sys_pc2epc),
    .io_dis_uops_0_1_bits_is_unique       (_dispatcher_io_dis_uops_0_1_bits_is_unique),
    .io_dis_uops_0_1_bits_flush_on_commit
      (_dispatcher_io_dis_uops_0_1_bits_flush_on_commit),
    .io_dis_uops_0_1_bits_ldst_is_rs1     (_dispatcher_io_dis_uops_0_1_bits_ldst_is_rs1),
    .io_dis_uops_0_1_bits_ldst            (_dispatcher_io_dis_uops_0_1_bits_ldst),
    .io_dis_uops_0_1_bits_lrs1            (_dispatcher_io_dis_uops_0_1_bits_lrs1),
    .io_dis_uops_0_1_bits_lrs2            (_dispatcher_io_dis_uops_0_1_bits_lrs2),
    .io_dis_uops_0_1_bits_lrs3            (_dispatcher_io_dis_uops_0_1_bits_lrs3),
    .io_dis_uops_0_1_bits_ldst_val        (_dispatcher_io_dis_uops_0_1_bits_ldst_val),
    .io_dis_uops_0_1_bits_dst_rtype       (_dispatcher_io_dis_uops_0_1_bits_dst_rtype),
    .io_dis_uops_0_1_bits_lrs1_rtype      (_dispatcher_io_dis_uops_0_1_bits_lrs1_rtype),
    .io_dis_uops_0_1_bits_lrs2_rtype      (_dispatcher_io_dis_uops_0_1_bits_lrs2_rtype),
    .io_dis_uops_0_1_bits_frs3_en         (_dispatcher_io_dis_uops_0_1_bits_frs3_en),
    .io_dis_uops_0_1_bits_fp_val          (_dispatcher_io_dis_uops_0_1_bits_fp_val),
    .io_dis_uops_0_1_bits_fp_single       (_dispatcher_io_dis_uops_0_1_bits_fp_single),
    .io_dis_uops_0_1_bits_xcpt_pf_if      (_dispatcher_io_dis_uops_0_1_bits_xcpt_pf_if),
    .io_dis_uops_0_1_bits_xcpt_ae_if      (_dispatcher_io_dis_uops_0_1_bits_xcpt_ae_if),
    .io_dis_uops_0_1_bits_xcpt_ma_if      (_dispatcher_io_dis_uops_0_1_bits_xcpt_ma_if),
    .io_dis_uops_0_1_bits_bp_debug_if     (_dispatcher_io_dis_uops_0_1_bits_bp_debug_if),
    .io_dis_uops_0_1_bits_bp_xcpt_if      (_dispatcher_io_dis_uops_0_1_bits_bp_xcpt_if),
    .io_dis_uops_0_1_bits_debug_fsrc      (_dispatcher_io_dis_uops_0_1_bits_debug_fsrc),
    .io_dis_uops_0_1_bits_debug_tsrc      (_dispatcher_io_dis_uops_0_1_bits_debug_tsrc),
    .io_dis_uops_0_2_valid                (_dispatcher_io_dis_uops_0_2_valid),
    .io_dis_uops_0_2_bits_uopc            (_dispatcher_io_dis_uops_0_2_bits_uopc),
    .io_dis_uops_0_2_bits_inst            (_dispatcher_io_dis_uops_0_2_bits_inst),
    .io_dis_uops_0_2_bits_debug_inst      (_dispatcher_io_dis_uops_0_2_bits_debug_inst),
    .io_dis_uops_0_2_bits_is_rvc          (_dispatcher_io_dis_uops_0_2_bits_is_rvc),
    .io_dis_uops_0_2_bits_debug_pc        (_dispatcher_io_dis_uops_0_2_bits_debug_pc),
    .io_dis_uops_0_2_bits_iq_type         (_dispatcher_io_dis_uops_0_2_bits_iq_type),
    .io_dis_uops_0_2_bits_fu_code         (_dispatcher_io_dis_uops_0_2_bits_fu_code),
    .io_dis_uops_0_2_bits_is_br           (_dispatcher_io_dis_uops_0_2_bits_is_br),
    .io_dis_uops_0_2_bits_is_jalr         (_dispatcher_io_dis_uops_0_2_bits_is_jalr),
    .io_dis_uops_0_2_bits_is_jal          (_dispatcher_io_dis_uops_0_2_bits_is_jal),
    .io_dis_uops_0_2_bits_is_sfb          (_dispatcher_io_dis_uops_0_2_bits_is_sfb),
    .io_dis_uops_0_2_bits_br_mask         (_dispatcher_io_dis_uops_0_2_bits_br_mask),
    .io_dis_uops_0_2_bits_br_tag          (_dispatcher_io_dis_uops_0_2_bits_br_tag),
    .io_dis_uops_0_2_bits_ftq_idx         (_dispatcher_io_dis_uops_0_2_bits_ftq_idx),
    .io_dis_uops_0_2_bits_edge_inst       (_dispatcher_io_dis_uops_0_2_bits_edge_inst),
    .io_dis_uops_0_2_bits_pc_lob          (_dispatcher_io_dis_uops_0_2_bits_pc_lob),
    .io_dis_uops_0_2_bits_taken           (_dispatcher_io_dis_uops_0_2_bits_taken),
    .io_dis_uops_0_2_bits_imm_packed      (_dispatcher_io_dis_uops_0_2_bits_imm_packed),
    .io_dis_uops_0_2_bits_csr_addr        (_dispatcher_io_dis_uops_0_2_bits_csr_addr),
    .io_dis_uops_0_2_bits_rob_idx         (_dispatcher_io_dis_uops_0_2_bits_rob_idx),
    .io_dis_uops_0_2_bits_ldq_idx         (_dispatcher_io_dis_uops_0_2_bits_ldq_idx),
    .io_dis_uops_0_2_bits_stq_idx         (_dispatcher_io_dis_uops_0_2_bits_stq_idx),
    .io_dis_uops_0_2_bits_rxq_idx         (_dispatcher_io_dis_uops_0_2_bits_rxq_idx),
    .io_dis_uops_0_2_bits_pdst            (_dispatcher_io_dis_uops_0_2_bits_pdst),
    .io_dis_uops_0_2_bits_prs1            (_dispatcher_io_dis_uops_0_2_bits_prs1),
    .io_dis_uops_0_2_bits_prs2            (_dispatcher_io_dis_uops_0_2_bits_prs2),
    .io_dis_uops_0_2_bits_prs3            (_dispatcher_io_dis_uops_0_2_bits_prs3),
    .io_dis_uops_0_2_bits_prs1_busy       (_dispatcher_io_dis_uops_0_2_bits_prs1_busy),
    .io_dis_uops_0_2_bits_prs2_busy       (_dispatcher_io_dis_uops_0_2_bits_prs2_busy),
    .io_dis_uops_0_2_bits_stale_pdst      (_dispatcher_io_dis_uops_0_2_bits_stale_pdst),
    .io_dis_uops_0_2_bits_exception       (_dispatcher_io_dis_uops_0_2_bits_exception),
    .io_dis_uops_0_2_bits_exc_cause       (_dispatcher_io_dis_uops_0_2_bits_exc_cause),
    .io_dis_uops_0_2_bits_bypassable      (_dispatcher_io_dis_uops_0_2_bits_bypassable),
    .io_dis_uops_0_2_bits_mem_cmd         (_dispatcher_io_dis_uops_0_2_bits_mem_cmd),
    .io_dis_uops_0_2_bits_mem_size        (_dispatcher_io_dis_uops_0_2_bits_mem_size),
    .io_dis_uops_0_2_bits_mem_signed      (_dispatcher_io_dis_uops_0_2_bits_mem_signed),
    .io_dis_uops_0_2_bits_is_fence        (_dispatcher_io_dis_uops_0_2_bits_is_fence),
    .io_dis_uops_0_2_bits_is_fencei       (_dispatcher_io_dis_uops_0_2_bits_is_fencei),
    .io_dis_uops_0_2_bits_is_amo          (_dispatcher_io_dis_uops_0_2_bits_is_amo),
    .io_dis_uops_0_2_bits_uses_ldq        (_dispatcher_io_dis_uops_0_2_bits_uses_ldq),
    .io_dis_uops_0_2_bits_uses_stq        (_dispatcher_io_dis_uops_0_2_bits_uses_stq),
    .io_dis_uops_0_2_bits_is_sys_pc2epc
      (_dispatcher_io_dis_uops_0_2_bits_is_sys_pc2epc),
    .io_dis_uops_0_2_bits_is_unique       (_dispatcher_io_dis_uops_0_2_bits_is_unique),
    .io_dis_uops_0_2_bits_flush_on_commit
      (_dispatcher_io_dis_uops_0_2_bits_flush_on_commit),
    .io_dis_uops_0_2_bits_ldst_is_rs1     (_dispatcher_io_dis_uops_0_2_bits_ldst_is_rs1),
    .io_dis_uops_0_2_bits_ldst            (_dispatcher_io_dis_uops_0_2_bits_ldst),
    .io_dis_uops_0_2_bits_lrs1            (_dispatcher_io_dis_uops_0_2_bits_lrs1),
    .io_dis_uops_0_2_bits_lrs2            (_dispatcher_io_dis_uops_0_2_bits_lrs2),
    .io_dis_uops_0_2_bits_lrs3            (_dispatcher_io_dis_uops_0_2_bits_lrs3),
    .io_dis_uops_0_2_bits_ldst_val        (_dispatcher_io_dis_uops_0_2_bits_ldst_val),
    .io_dis_uops_0_2_bits_dst_rtype       (_dispatcher_io_dis_uops_0_2_bits_dst_rtype),
    .io_dis_uops_0_2_bits_lrs1_rtype      (_dispatcher_io_dis_uops_0_2_bits_lrs1_rtype),
    .io_dis_uops_0_2_bits_lrs2_rtype      (_dispatcher_io_dis_uops_0_2_bits_lrs2_rtype),
    .io_dis_uops_0_2_bits_frs3_en         (_dispatcher_io_dis_uops_0_2_bits_frs3_en),
    .io_dis_uops_0_2_bits_fp_val          (_dispatcher_io_dis_uops_0_2_bits_fp_val),
    .io_dis_uops_0_2_bits_fp_single       (_dispatcher_io_dis_uops_0_2_bits_fp_single),
    .io_dis_uops_0_2_bits_xcpt_pf_if      (_dispatcher_io_dis_uops_0_2_bits_xcpt_pf_if),
    .io_dis_uops_0_2_bits_xcpt_ae_if      (_dispatcher_io_dis_uops_0_2_bits_xcpt_ae_if),
    .io_dis_uops_0_2_bits_xcpt_ma_if      (_dispatcher_io_dis_uops_0_2_bits_xcpt_ma_if),
    .io_dis_uops_0_2_bits_bp_debug_if     (_dispatcher_io_dis_uops_0_2_bits_bp_debug_if),
    .io_dis_uops_0_2_bits_bp_xcpt_if      (_dispatcher_io_dis_uops_0_2_bits_bp_xcpt_if),
    .io_dis_uops_0_2_bits_debug_fsrc      (_dispatcher_io_dis_uops_0_2_bits_debug_fsrc),
    .io_dis_uops_0_2_bits_debug_tsrc      (_dispatcher_io_dis_uops_0_2_bits_debug_tsrc)
  );
  RegisterFileSynthesizable_4 iregfile (	// core.scala:113:32
    .clock                      (clock),
    .reset                      (reset),
    .io_read_ports_0_addr       (_iregister_read_io_rf_read_ports_0_addr),	// core.scala:132:32
    .io_read_ports_1_addr       (_iregister_read_io_rf_read_ports_1_addr),	// core.scala:132:32
    .io_read_ports_2_addr       (_iregister_read_io_rf_read_ports_2_addr),	// core.scala:132:32
    .io_read_ports_3_addr       (_iregister_read_io_rf_read_ports_3_addr),	// core.scala:132:32
    .io_read_ports_4_addr       (_iregister_read_io_rf_read_ports_4_addr),	// core.scala:132:32
    .io_read_ports_5_addr       (_iregister_read_io_rf_read_ports_5_addr),	// core.scala:132:32
    .io_read_ports_6_addr       (_iregister_read_io_rf_read_ports_6_addr),	// core.scala:132:32
    .io_read_ports_7_addr       (_iregister_read_io_rf_read_ports_7_addr),	// core.scala:132:32
    .io_write_ports_0_valid
      (_ll_wbarb_io_out_valid & _iregfile_io_write_ports_0_wport_valid_T),	// core.scala:129:32, :789:92, regfile.scala:57:35
    .io_write_ports_0_bits_addr (_ll_wbarb_io_out_bits_uop_pdst),	// core.scala:129:32
    .io_write_ports_0_bits_data (_ll_wbarb_io_out_bits_data),	// core.scala:129:32
    .io_write_ports_1_valid
      (_jmp_unit_io_iresp_valid & _rob_io_debug_wb_valids_1_T
       & ~(|_jmp_unit_io_iresp_bits_uop_dst_rtype)),	// core.scala:814:78, :829:57, :1145:48, execution-units.scala:119:32, micro-op.scala:149:36
    .io_write_ports_1_bits_addr (_jmp_unit_io_iresp_bits_uop_pdst),	// execution-units.scala:119:32
    .io_write_ports_1_bits_data (_jmp_unit_io_iresp_bits_data[63:0]),	// core.scala:1154:50, execution-units.scala:119:32
    .io_write_ports_2_valid
      (_csr_exe_unit_io_iresp_valid & _rob_io_debug_wb_valids_2_T
       & ~(|_csr_exe_unit_io_iresp_bits_uop_dst_rtype)),	// core.scala:814:78, :829:57, :1145:48, execution-units.scala:119:32, micro-op.scala:149:36
    .io_write_ports_2_bits_addr (_csr_exe_unit_io_iresp_bits_uop_pdst),	// execution-units.scala:119:32
    .io_write_ports_2_bits_data
      ((|_csr_exe_unit_io_iresp_bits_uop_ctrl_csr_cmd)
         ? _csr_io_rw_rdata
         : _csr_exe_unit_io_iresp_bits_data[63:0]),	// core.scala:268:19, :1000:25, :1146:53, :1152:56, execution-units.scala:119:32
    .io_write_ports_3_valid
      (_alu_exe_unit_io_iresp_valid & _rob_io_debug_wb_valids_3_T
       & ~(|_alu_exe_unit_io_iresp_bits_uop_dst_rtype)),	// core.scala:814:78, :829:57, :1145:48, execution-units.scala:119:32, micro-op.scala:149:36
    .io_write_ports_3_bits_addr (_alu_exe_unit_io_iresp_bits_uop_pdst),	// execution-units.scala:119:32
    .io_write_ports_3_bits_data (_alu_exe_unit_io_iresp_bits_data[63:0]),	// core.scala:1154:50, execution-units.scala:119:32
    .io_read_ports_0_data       (_iregfile_io_read_ports_0_data),
    .io_read_ports_1_data       (_iregfile_io_read_ports_1_data),
    .io_read_ports_2_data       (_iregfile_io_read_ports_2_data),
    .io_read_ports_3_data       (_iregfile_io_read_ports_3_data),
    .io_read_ports_4_data       (_iregfile_io_read_ports_4_data),
    .io_read_ports_5_data       (_iregfile_io_read_ports_5_data),
    .io_read_ports_6_data       (_iregfile_io_read_ports_6_data),
    .io_read_ports_7_data       (_iregfile_io_read_ports_7_data)
  );
  Arbiter_42 ll_wbarb (	// core.scala:129:32
    .io_in_0_valid              (_mem_units_0_io_ll_iresp_valid),	// execution-units.scala:108:30
    .io_in_0_bits_uop_rob_idx   (_mem_units_0_io_ll_iresp_bits_uop_rob_idx),	// execution-units.scala:108:30
    .io_in_0_bits_uop_pdst      (_mem_units_0_io_ll_iresp_bits_uop_pdst),	// execution-units.scala:108:30
    .io_in_0_bits_uop_is_amo    (_mem_units_0_io_ll_iresp_bits_uop_is_amo),	// execution-units.scala:108:30
    .io_in_0_bits_uop_uses_stq  (_mem_units_0_io_ll_iresp_bits_uop_uses_stq),	// execution-units.scala:108:30
    .io_in_0_bits_uop_dst_rtype (_mem_units_0_io_ll_iresp_bits_uop_dst_rtype),	// execution-units.scala:108:30
    .io_in_0_bits_data          (_mem_units_0_io_ll_iresp_bits_data[63:0]),	// core.scala:1131:21, execution-units.scala:108:30
    .io_in_1_valid              (_fp_pipeline_io_to_int_valid),	// core.scala:77:37
    .io_in_1_bits_uop_rob_idx   (_fp_pipeline_io_to_int_bits_uop_rob_idx),	// core.scala:77:37
    .io_in_1_bits_uop_pdst      (_fp_pipeline_io_to_int_bits_uop_pdst),	// core.scala:77:37
    .io_in_1_bits_uop_is_amo    (_fp_pipeline_io_to_int_bits_uop_is_amo),	// core.scala:77:37
    .io_in_1_bits_uop_uses_stq  (_fp_pipeline_io_to_int_bits_uop_uses_stq),	// core.scala:77:37
    .io_in_1_bits_uop_dst_rtype (_fp_pipeline_io_to_int_bits_uop_dst_rtype),	// core.scala:77:37
    .io_in_1_bits_data          (_fp_pipeline_io_to_int_bits_data),	// core.scala:77:37
    .io_in_1_bits_predicated    (_fp_pipeline_io_to_int_bits_predicated),	// core.scala:77:37
    .io_in_1_ready              (_ll_wbarb_io_in_1_ready),
    .io_out_valid               (_ll_wbarb_io_out_valid),
    .io_out_bits_uop_rob_idx    (_ll_wbarb_io_out_bits_uop_rob_idx),
    .io_out_bits_uop_pdst       (_ll_wbarb_io_out_bits_uop_pdst),
    .io_out_bits_uop_is_amo     (_ll_wbarb_io_out_bits_uop_is_amo),
    .io_out_bits_uop_uses_stq   (_ll_wbarb_io_out_bits_uop_uses_stq),
    .io_out_bits_uop_dst_rtype  (_ll_wbarb_io_out_bits_uop_dst_rtype),
    .io_out_bits_data           (_ll_wbarb_io_out_bits_data),
    .io_out_bits_predicated     (_ll_wbarb_io_out_bits_predicated)
  );
  RegisterRead_3 iregister_read (	// core.scala:132:32
    .clock                                  (clock),
    .reset                                  (reset),
    .io_iss_valids_0
      (_mem_issue_unit_io_iss_valids_0
       & ~(io_lsu_ld_miss
           & (_mem_issue_unit_io_iss_uops_0_iw_p1_poisoned
              | _mem_issue_unit_io_iss_uops_0_iw_p2_poisoned))),	// core.scala:105:32, :975:{21,24,41,72}
    .io_iss_valids_1
      (_int_issue_unit_io_iss_valids_0
       & ~(io_lsu_ld_miss & _iregister_read_io_iss_valids_1_T)),	// core.scala:107:32, :822:79, :975:{21,24,41}
    .io_iss_valids_2
      (_int_issue_unit_io_iss_valids_1
       & ~(io_lsu_ld_miss & _iregister_read_io_iss_valids_2_T)),	// core.scala:107:32, :822:79, :975:{21,24,41}
    .io_iss_valids_3
      (_int_issue_unit_io_iss_valids_2
       & ~(io_lsu_ld_miss & _iregister_read_io_iss_valids_3_T)),	// core.scala:107:32, :822:79, :975:{21,24,41}
    .io_iss_uops_0_uopc                     (_mem_issue_unit_io_iss_uops_0_uopc),	// core.scala:105:32
    .io_iss_uops_0_inst                     (_mem_issue_unit_io_iss_uops_0_inst),	// core.scala:105:32
    .io_iss_uops_0_debug_inst               (_mem_issue_unit_io_iss_uops_0_debug_inst),	// core.scala:105:32
    .io_iss_uops_0_is_rvc                   (_mem_issue_unit_io_iss_uops_0_is_rvc),	// core.scala:105:32
    .io_iss_uops_0_debug_pc                 (_mem_issue_unit_io_iss_uops_0_debug_pc),	// core.scala:105:32
    .io_iss_uops_0_iq_type                  (_mem_issue_unit_io_iss_uops_0_iq_type),	// core.scala:105:32
    .io_iss_uops_0_fu_code                  (_mem_issue_unit_io_iss_uops_0_fu_code),	// core.scala:105:32
    .io_iss_uops_0_iw_state                 (_mem_issue_unit_io_iss_uops_0_iw_state),	// core.scala:105:32
    .io_iss_uops_0_is_br                    (_mem_issue_unit_io_iss_uops_0_is_br),	// core.scala:105:32
    .io_iss_uops_0_is_jalr                  (_mem_issue_unit_io_iss_uops_0_is_jalr),	// core.scala:105:32
    .io_iss_uops_0_is_jal                   (_mem_issue_unit_io_iss_uops_0_is_jal),	// core.scala:105:32
    .io_iss_uops_0_is_sfb                   (_mem_issue_unit_io_iss_uops_0_is_sfb),	// core.scala:105:32
    .io_iss_uops_0_br_mask                  (_mem_issue_unit_io_iss_uops_0_br_mask),	// core.scala:105:32
    .io_iss_uops_0_br_tag                   (_mem_issue_unit_io_iss_uops_0_br_tag),	// core.scala:105:32
    .io_iss_uops_0_ftq_idx                  (_mem_issue_unit_io_iss_uops_0_ftq_idx),	// core.scala:105:32
    .io_iss_uops_0_edge_inst                (_mem_issue_unit_io_iss_uops_0_edge_inst),	// core.scala:105:32
    .io_iss_uops_0_pc_lob                   (_mem_issue_unit_io_iss_uops_0_pc_lob),	// core.scala:105:32
    .io_iss_uops_0_taken                    (_mem_issue_unit_io_iss_uops_0_taken),	// core.scala:105:32
    .io_iss_uops_0_imm_packed               (_mem_issue_unit_io_iss_uops_0_imm_packed),	// core.scala:105:32
    .io_iss_uops_0_csr_addr                 (_mem_issue_unit_io_iss_uops_0_csr_addr),	// core.scala:105:32
    .io_iss_uops_0_rob_idx                  (_mem_issue_unit_io_iss_uops_0_rob_idx),	// core.scala:105:32
    .io_iss_uops_0_ldq_idx                  (_mem_issue_unit_io_iss_uops_0_ldq_idx),	// core.scala:105:32
    .io_iss_uops_0_stq_idx                  (_mem_issue_unit_io_iss_uops_0_stq_idx),	// core.scala:105:32
    .io_iss_uops_0_rxq_idx                  (_mem_issue_unit_io_iss_uops_0_rxq_idx),	// core.scala:105:32
    .io_iss_uops_0_pdst                     (_mem_issue_unit_io_iss_uops_0_pdst),	// core.scala:105:32
    .io_iss_uops_0_prs1                     (_mem_issue_unit_io_iss_uops_0_prs1),	// core.scala:105:32
    .io_iss_uops_0_prs2                     (_mem_issue_unit_io_iss_uops_0_prs2),	// core.scala:105:32
    .io_iss_uops_0_prs3                     (_mem_issue_unit_io_iss_uops_0_prs3),	// core.scala:105:32
    .io_iss_uops_0_ppred                    (_mem_issue_unit_io_iss_uops_0_ppred),	// core.scala:105:32
    .io_iss_uops_0_prs1_busy                (_mem_issue_unit_io_iss_uops_0_prs1_busy),	// core.scala:105:32
    .io_iss_uops_0_prs2_busy                (_mem_issue_unit_io_iss_uops_0_prs2_busy),	// core.scala:105:32
    .io_iss_uops_0_prs3_busy                (_mem_issue_unit_io_iss_uops_0_prs3_busy),	// core.scala:105:32
    .io_iss_uops_0_ppred_busy               (_mem_issue_unit_io_iss_uops_0_ppred_busy),	// core.scala:105:32
    .io_iss_uops_0_stale_pdst               (_mem_issue_unit_io_iss_uops_0_stale_pdst),	// core.scala:105:32
    .io_iss_uops_0_exception                (_mem_issue_unit_io_iss_uops_0_exception),	// core.scala:105:32
    .io_iss_uops_0_exc_cause                (_mem_issue_unit_io_iss_uops_0_exc_cause),	// core.scala:105:32
    .io_iss_uops_0_bypassable               (_mem_issue_unit_io_iss_uops_0_bypassable),	// core.scala:105:32
    .io_iss_uops_0_mem_cmd                  (_mem_issue_unit_io_iss_uops_0_mem_cmd),	// core.scala:105:32
    .io_iss_uops_0_mem_size                 (_mem_issue_unit_io_iss_uops_0_mem_size),	// core.scala:105:32
    .io_iss_uops_0_mem_signed               (_mem_issue_unit_io_iss_uops_0_mem_signed),	// core.scala:105:32
    .io_iss_uops_0_is_fence                 (_mem_issue_unit_io_iss_uops_0_is_fence),	// core.scala:105:32
    .io_iss_uops_0_is_fencei                (_mem_issue_unit_io_iss_uops_0_is_fencei),	// core.scala:105:32
    .io_iss_uops_0_is_amo                   (_mem_issue_unit_io_iss_uops_0_is_amo),	// core.scala:105:32
    .io_iss_uops_0_uses_ldq                 (_mem_issue_unit_io_iss_uops_0_uses_ldq),	// core.scala:105:32
    .io_iss_uops_0_uses_stq                 (_mem_issue_unit_io_iss_uops_0_uses_stq),	// core.scala:105:32
    .io_iss_uops_0_is_sys_pc2epc            (_mem_issue_unit_io_iss_uops_0_is_sys_pc2epc),	// core.scala:105:32
    .io_iss_uops_0_is_unique                (_mem_issue_unit_io_iss_uops_0_is_unique),	// core.scala:105:32
    .io_iss_uops_0_flush_on_commit
      (_mem_issue_unit_io_iss_uops_0_flush_on_commit),	// core.scala:105:32
    .io_iss_uops_0_ldst_is_rs1              (_mem_issue_unit_io_iss_uops_0_ldst_is_rs1),	// core.scala:105:32
    .io_iss_uops_0_ldst                     (_mem_issue_unit_io_iss_uops_0_ldst),	// core.scala:105:32
    .io_iss_uops_0_lrs1                     (_mem_issue_unit_io_iss_uops_0_lrs1),	// core.scala:105:32
    .io_iss_uops_0_lrs2                     (_mem_issue_unit_io_iss_uops_0_lrs2),	// core.scala:105:32
    .io_iss_uops_0_lrs3                     (_mem_issue_unit_io_iss_uops_0_lrs3),	// core.scala:105:32
    .io_iss_uops_0_ldst_val                 (_mem_issue_unit_io_iss_uops_0_ldst_val),	// core.scala:105:32
    .io_iss_uops_0_dst_rtype                (_mem_issue_unit_io_iss_uops_0_dst_rtype),	// core.scala:105:32
    .io_iss_uops_0_lrs1_rtype               (_mem_issue_unit_io_iss_uops_0_lrs1_rtype),	// core.scala:105:32
    .io_iss_uops_0_lrs2_rtype               (_mem_issue_unit_io_iss_uops_0_lrs2_rtype),	// core.scala:105:32
    .io_iss_uops_0_frs3_en                  (_mem_issue_unit_io_iss_uops_0_frs3_en),	// core.scala:105:32
    .io_iss_uops_0_fp_val                   (_mem_issue_unit_io_iss_uops_0_fp_val),	// core.scala:105:32
    .io_iss_uops_0_fp_single                (_mem_issue_unit_io_iss_uops_0_fp_single),	// core.scala:105:32
    .io_iss_uops_0_xcpt_pf_if               (_mem_issue_unit_io_iss_uops_0_xcpt_pf_if),	// core.scala:105:32
    .io_iss_uops_0_xcpt_ae_if               (_mem_issue_unit_io_iss_uops_0_xcpt_ae_if),	// core.scala:105:32
    .io_iss_uops_0_xcpt_ma_if               (_mem_issue_unit_io_iss_uops_0_xcpt_ma_if),	// core.scala:105:32
    .io_iss_uops_0_bp_debug_if              (_mem_issue_unit_io_iss_uops_0_bp_debug_if),	// core.scala:105:32
    .io_iss_uops_0_bp_xcpt_if               (_mem_issue_unit_io_iss_uops_0_bp_xcpt_if),	// core.scala:105:32
    .io_iss_uops_0_debug_fsrc               (_mem_issue_unit_io_iss_uops_0_debug_fsrc),	// core.scala:105:32
    .io_iss_uops_0_debug_tsrc               (_mem_issue_unit_io_iss_uops_0_debug_tsrc),	// core.scala:105:32
    .io_iss_uops_1_uopc                     (_int_issue_unit_io_iss_uops_0_uopc),	// core.scala:107:32
    .io_iss_uops_1_is_rvc                   (_int_issue_unit_io_iss_uops_0_is_rvc),	// core.scala:107:32
    .io_iss_uops_1_fu_code                  (_int_issue_unit_io_iss_uops_0_fu_code),	// core.scala:107:32
    .io_iss_uops_1_is_br                    (_int_issue_unit_io_iss_uops_0_is_br),	// core.scala:107:32
    .io_iss_uops_1_is_jalr                  (_int_issue_unit_io_iss_uops_0_is_jalr),	// core.scala:107:32
    .io_iss_uops_1_is_jal                   (_int_issue_unit_io_iss_uops_0_is_jal),	// core.scala:107:32
    .io_iss_uops_1_is_sfb                   (_int_issue_unit_io_iss_uops_0_is_sfb),	// core.scala:107:32
    .io_iss_uops_1_br_mask                  (_int_issue_unit_io_iss_uops_0_br_mask),	// core.scala:107:32
    .io_iss_uops_1_br_tag                   (_int_issue_unit_io_iss_uops_0_br_tag),	// core.scala:107:32
    .io_iss_uops_1_ftq_idx                  (_int_issue_unit_io_iss_uops_0_ftq_idx),	// core.scala:107:32
    .io_iss_uops_1_edge_inst                (_int_issue_unit_io_iss_uops_0_edge_inst),	// core.scala:107:32
    .io_iss_uops_1_pc_lob                   (_int_issue_unit_io_iss_uops_0_pc_lob),	// core.scala:107:32
    .io_iss_uops_1_taken                    (_int_issue_unit_io_iss_uops_0_taken),	// core.scala:107:32
    .io_iss_uops_1_imm_packed               (_int_issue_unit_io_iss_uops_0_imm_packed),	// core.scala:107:32
    .io_iss_uops_1_rob_idx                  (_int_issue_unit_io_iss_uops_0_rob_idx),	// core.scala:107:32
    .io_iss_uops_1_ldq_idx                  (_int_issue_unit_io_iss_uops_0_ldq_idx),	// core.scala:107:32
    .io_iss_uops_1_stq_idx                  (_int_issue_unit_io_iss_uops_0_stq_idx),	// core.scala:107:32
    .io_iss_uops_1_pdst                     (_int_issue_unit_io_iss_uops_0_pdst),	// core.scala:107:32
    .io_iss_uops_1_prs1                     (_int_issue_unit_io_iss_uops_0_prs1),	// core.scala:107:32
    .io_iss_uops_1_prs2                     (_int_issue_unit_io_iss_uops_0_prs2),	// core.scala:107:32
    .io_iss_uops_1_bypassable               (_int_issue_unit_io_iss_uops_0_bypassable),	// core.scala:107:32
    .io_iss_uops_1_mem_cmd                  (_int_issue_unit_io_iss_uops_0_mem_cmd),	// core.scala:107:32
    .io_iss_uops_1_is_amo                   (_int_issue_unit_io_iss_uops_0_is_amo),	// core.scala:107:32
    .io_iss_uops_1_uses_stq                 (_int_issue_unit_io_iss_uops_0_uses_stq),	// core.scala:107:32
    .io_iss_uops_1_dst_rtype                (_int_issue_unit_io_iss_uops_0_dst_rtype),	// core.scala:107:32
    .io_iss_uops_1_lrs1_rtype               (_int_issue_unit_io_iss_uops_0_lrs1_rtype),	// core.scala:107:32
    .io_iss_uops_1_lrs2_rtype               (_int_issue_unit_io_iss_uops_0_lrs2_rtype),	// core.scala:107:32
    .io_iss_uops_2_uopc                     (_int_issue_unit_io_iss_uops_1_uopc),	// core.scala:107:32
    .io_iss_uops_2_inst                     (_int_issue_unit_io_iss_uops_1_inst),	// core.scala:107:32
    .io_iss_uops_2_debug_inst               (_int_issue_unit_io_iss_uops_1_debug_inst),	// core.scala:107:32
    .io_iss_uops_2_is_rvc                   (_int_issue_unit_io_iss_uops_1_is_rvc),	// core.scala:107:32
    .io_iss_uops_2_debug_pc                 (_int_issue_unit_io_iss_uops_1_debug_pc),	// core.scala:107:32
    .io_iss_uops_2_iq_type                  (_int_issue_unit_io_iss_uops_1_iq_type),	// core.scala:107:32
    .io_iss_uops_2_fu_code                  (_int_issue_unit_io_iss_uops_1_fu_code),	// core.scala:107:32
    .io_iss_uops_2_iw_state                 (_int_issue_unit_io_iss_uops_1_iw_state),	// core.scala:107:32
    .io_iss_uops_2_is_br                    (_int_issue_unit_io_iss_uops_1_is_br),	// core.scala:107:32
    .io_iss_uops_2_is_jalr                  (_int_issue_unit_io_iss_uops_1_is_jalr),	// core.scala:107:32
    .io_iss_uops_2_is_jal                   (_int_issue_unit_io_iss_uops_1_is_jal),	// core.scala:107:32
    .io_iss_uops_2_is_sfb                   (_int_issue_unit_io_iss_uops_1_is_sfb),	// core.scala:107:32
    .io_iss_uops_2_br_mask                  (_int_issue_unit_io_iss_uops_1_br_mask),	// core.scala:107:32
    .io_iss_uops_2_br_tag                   (_int_issue_unit_io_iss_uops_1_br_tag),	// core.scala:107:32
    .io_iss_uops_2_ftq_idx                  (_int_issue_unit_io_iss_uops_1_ftq_idx),	// core.scala:107:32
    .io_iss_uops_2_edge_inst                (_int_issue_unit_io_iss_uops_1_edge_inst),	// core.scala:107:32
    .io_iss_uops_2_pc_lob                   (_int_issue_unit_io_iss_uops_1_pc_lob),	// core.scala:107:32
    .io_iss_uops_2_taken                    (_int_issue_unit_io_iss_uops_1_taken),	// core.scala:107:32
    .io_iss_uops_2_imm_packed               (_int_issue_unit_io_iss_uops_1_imm_packed),	// core.scala:107:32
    .io_iss_uops_2_csr_addr                 (_int_issue_unit_io_iss_uops_1_csr_addr),	// core.scala:107:32
    .io_iss_uops_2_rob_idx                  (_int_issue_unit_io_iss_uops_1_rob_idx),	// core.scala:107:32
    .io_iss_uops_2_ldq_idx                  (_int_issue_unit_io_iss_uops_1_ldq_idx),	// core.scala:107:32
    .io_iss_uops_2_stq_idx                  (_int_issue_unit_io_iss_uops_1_stq_idx),	// core.scala:107:32
    .io_iss_uops_2_rxq_idx                  (_int_issue_unit_io_iss_uops_1_rxq_idx),	// core.scala:107:32
    .io_iss_uops_2_pdst                     (_int_issue_unit_io_iss_uops_1_pdst),	// core.scala:107:32
    .io_iss_uops_2_prs1                     (_int_issue_unit_io_iss_uops_1_prs1),	// core.scala:107:32
    .io_iss_uops_2_prs2                     (_int_issue_unit_io_iss_uops_1_prs2),	// core.scala:107:32
    .io_iss_uops_2_prs3                     (_int_issue_unit_io_iss_uops_1_prs3),	// core.scala:107:32
    .io_iss_uops_2_ppred                    (_int_issue_unit_io_iss_uops_1_ppred),	// core.scala:107:32
    .io_iss_uops_2_prs1_busy                (_int_issue_unit_io_iss_uops_1_prs1_busy),	// core.scala:107:32
    .io_iss_uops_2_prs2_busy                (_int_issue_unit_io_iss_uops_1_prs2_busy),	// core.scala:107:32
    .io_iss_uops_2_prs3_busy                (_int_issue_unit_io_iss_uops_1_prs3_busy),	// core.scala:107:32
    .io_iss_uops_2_ppred_busy               (_int_issue_unit_io_iss_uops_1_ppred_busy),	// core.scala:107:32
    .io_iss_uops_2_stale_pdst               (_int_issue_unit_io_iss_uops_1_stale_pdst),	// core.scala:107:32
    .io_iss_uops_2_exception                (_int_issue_unit_io_iss_uops_1_exception),	// core.scala:107:32
    .io_iss_uops_2_exc_cause                (_int_issue_unit_io_iss_uops_1_exc_cause),	// core.scala:107:32
    .io_iss_uops_2_bypassable               (_int_issue_unit_io_iss_uops_1_bypassable),	// core.scala:107:32
    .io_iss_uops_2_mem_cmd                  (_int_issue_unit_io_iss_uops_1_mem_cmd),	// core.scala:107:32
    .io_iss_uops_2_mem_size                 (_int_issue_unit_io_iss_uops_1_mem_size),	// core.scala:107:32
    .io_iss_uops_2_mem_signed               (_int_issue_unit_io_iss_uops_1_mem_signed),	// core.scala:107:32
    .io_iss_uops_2_is_fence                 (_int_issue_unit_io_iss_uops_1_is_fence),	// core.scala:107:32
    .io_iss_uops_2_is_fencei                (_int_issue_unit_io_iss_uops_1_is_fencei),	// core.scala:107:32
    .io_iss_uops_2_is_amo                   (_int_issue_unit_io_iss_uops_1_is_amo),	// core.scala:107:32
    .io_iss_uops_2_uses_ldq                 (_int_issue_unit_io_iss_uops_1_uses_ldq),	// core.scala:107:32
    .io_iss_uops_2_uses_stq                 (_int_issue_unit_io_iss_uops_1_uses_stq),	// core.scala:107:32
    .io_iss_uops_2_is_sys_pc2epc            (_int_issue_unit_io_iss_uops_1_is_sys_pc2epc),	// core.scala:107:32
    .io_iss_uops_2_is_unique                (_int_issue_unit_io_iss_uops_1_is_unique),	// core.scala:107:32
    .io_iss_uops_2_flush_on_commit
      (_int_issue_unit_io_iss_uops_1_flush_on_commit),	// core.scala:107:32
    .io_iss_uops_2_ldst_is_rs1              (_int_issue_unit_io_iss_uops_1_ldst_is_rs1),	// core.scala:107:32
    .io_iss_uops_2_ldst                     (_int_issue_unit_io_iss_uops_1_ldst),	// core.scala:107:32
    .io_iss_uops_2_lrs1                     (_int_issue_unit_io_iss_uops_1_lrs1),	// core.scala:107:32
    .io_iss_uops_2_lrs2                     (_int_issue_unit_io_iss_uops_1_lrs2),	// core.scala:107:32
    .io_iss_uops_2_lrs3                     (_int_issue_unit_io_iss_uops_1_lrs3),	// core.scala:107:32
    .io_iss_uops_2_ldst_val                 (_int_issue_unit_io_iss_uops_1_ldst_val),	// core.scala:107:32
    .io_iss_uops_2_dst_rtype                (_int_issue_unit_io_iss_uops_1_dst_rtype),	// core.scala:107:32
    .io_iss_uops_2_lrs1_rtype               (_int_issue_unit_io_iss_uops_1_lrs1_rtype),	// core.scala:107:32
    .io_iss_uops_2_lrs2_rtype               (_int_issue_unit_io_iss_uops_1_lrs2_rtype),	// core.scala:107:32
    .io_iss_uops_2_frs3_en                  (_int_issue_unit_io_iss_uops_1_frs3_en),	// core.scala:107:32
    .io_iss_uops_2_fp_val                   (_int_issue_unit_io_iss_uops_1_fp_val),	// core.scala:107:32
    .io_iss_uops_2_fp_single                (_int_issue_unit_io_iss_uops_1_fp_single),	// core.scala:107:32
    .io_iss_uops_2_xcpt_pf_if               (_int_issue_unit_io_iss_uops_1_xcpt_pf_if),	// core.scala:107:32
    .io_iss_uops_2_xcpt_ae_if               (_int_issue_unit_io_iss_uops_1_xcpt_ae_if),	// core.scala:107:32
    .io_iss_uops_2_xcpt_ma_if               (_int_issue_unit_io_iss_uops_1_xcpt_ma_if),	// core.scala:107:32
    .io_iss_uops_2_bp_debug_if              (_int_issue_unit_io_iss_uops_1_bp_debug_if),	// core.scala:107:32
    .io_iss_uops_2_bp_xcpt_if               (_int_issue_unit_io_iss_uops_1_bp_xcpt_if),	// core.scala:107:32
    .io_iss_uops_2_debug_fsrc               (_int_issue_unit_io_iss_uops_1_debug_fsrc),	// core.scala:107:32
    .io_iss_uops_2_debug_tsrc               (_int_issue_unit_io_iss_uops_1_debug_tsrc),	// core.scala:107:32
    .io_iss_uops_3_uopc                     (_int_issue_unit_io_iss_uops_2_uopc),	// core.scala:107:32
    .io_iss_uops_3_is_rvc                   (_int_issue_unit_io_iss_uops_2_is_rvc),	// core.scala:107:32
    .io_iss_uops_3_fu_code                  (_int_issue_unit_io_iss_uops_2_fu_code),	// core.scala:107:32
    .io_iss_uops_3_is_br                    (_int_issue_unit_io_iss_uops_2_is_br),	// core.scala:107:32
    .io_iss_uops_3_is_jalr                  (_int_issue_unit_io_iss_uops_2_is_jalr),	// core.scala:107:32
    .io_iss_uops_3_is_jal                   (_int_issue_unit_io_iss_uops_2_is_jal),	// core.scala:107:32
    .io_iss_uops_3_is_sfb                   (_int_issue_unit_io_iss_uops_2_is_sfb),	// core.scala:107:32
    .io_iss_uops_3_br_mask                  (_int_issue_unit_io_iss_uops_2_br_mask),	// core.scala:107:32
    .io_iss_uops_3_br_tag                   (_int_issue_unit_io_iss_uops_2_br_tag),	// core.scala:107:32
    .io_iss_uops_3_ftq_idx                  (_int_issue_unit_io_iss_uops_2_ftq_idx),	// core.scala:107:32
    .io_iss_uops_3_edge_inst                (_int_issue_unit_io_iss_uops_2_edge_inst),	// core.scala:107:32
    .io_iss_uops_3_pc_lob                   (_int_issue_unit_io_iss_uops_2_pc_lob),	// core.scala:107:32
    .io_iss_uops_3_taken                    (_int_issue_unit_io_iss_uops_2_taken),	// core.scala:107:32
    .io_iss_uops_3_imm_packed               (_int_issue_unit_io_iss_uops_2_imm_packed),	// core.scala:107:32
    .io_iss_uops_3_rob_idx                  (_int_issue_unit_io_iss_uops_2_rob_idx),	// core.scala:107:32
    .io_iss_uops_3_ldq_idx                  (_int_issue_unit_io_iss_uops_2_ldq_idx),	// core.scala:107:32
    .io_iss_uops_3_stq_idx                  (_int_issue_unit_io_iss_uops_2_stq_idx),	// core.scala:107:32
    .io_iss_uops_3_pdst                     (_int_issue_unit_io_iss_uops_2_pdst),	// core.scala:107:32
    .io_iss_uops_3_prs1                     (_int_issue_unit_io_iss_uops_2_prs1),	// core.scala:107:32
    .io_iss_uops_3_prs2                     (_int_issue_unit_io_iss_uops_2_prs2),	// core.scala:107:32
    .io_iss_uops_3_bypassable               (_int_issue_unit_io_iss_uops_2_bypassable),	// core.scala:107:32
    .io_iss_uops_3_mem_cmd                  (_int_issue_unit_io_iss_uops_2_mem_cmd),	// core.scala:107:32
    .io_iss_uops_3_is_amo                   (_int_issue_unit_io_iss_uops_2_is_amo),	// core.scala:107:32
    .io_iss_uops_3_uses_stq                 (_int_issue_unit_io_iss_uops_2_uses_stq),	// core.scala:107:32
    .io_iss_uops_3_dst_rtype                (_int_issue_unit_io_iss_uops_2_dst_rtype),	// core.scala:107:32
    .io_iss_uops_3_lrs1_rtype               (_int_issue_unit_io_iss_uops_2_lrs1_rtype),	// core.scala:107:32
    .io_iss_uops_3_lrs2_rtype               (_int_issue_unit_io_iss_uops_2_lrs2_rtype),	// core.scala:107:32
    .io_rf_read_ports_0_data                (_iregfile_io_read_ports_0_data),	// core.scala:113:32
    .io_rf_read_ports_1_data                (_iregfile_io_read_ports_1_data),	// core.scala:113:32
    .io_rf_read_ports_2_data                (_iregfile_io_read_ports_2_data),	// core.scala:113:32
    .io_rf_read_ports_3_data                (_iregfile_io_read_ports_3_data),	// core.scala:113:32
    .io_rf_read_ports_4_data                (_iregfile_io_read_ports_4_data),	// core.scala:113:32
    .io_rf_read_ports_5_data                (_iregfile_io_read_ports_5_data),	// core.scala:113:32
    .io_rf_read_ports_6_data                (_iregfile_io_read_ports_6_data),	// core.scala:113:32
    .io_rf_read_ports_7_data                (_iregfile_io_read_ports_7_data),	// core.scala:113:32
    .io_bypass_0_valid                      (_jmp_unit_io_bypass_0_valid),	// execution-units.scala:119:32
    .io_bypass_0_bits_uop_pdst              (_jmp_unit_io_bypass_0_bits_uop_pdst),	// execution-units.scala:119:32
    .io_bypass_0_bits_uop_dst_rtype         (_jmp_unit_io_bypass_0_bits_uop_dst_rtype),	// execution-units.scala:119:32
    .io_bypass_0_bits_data                  (_jmp_unit_io_bypass_0_bits_data[63:0]),	// core.scala:1078:32, execution-units.scala:119:32
    .io_bypass_1_valid                      (_csr_exe_unit_io_bypass_0_valid),	// execution-units.scala:119:32
    .io_bypass_1_bits_uop_pdst              (_csr_exe_unit_io_bypass_0_bits_uop_pdst),	// execution-units.scala:119:32
    .io_bypass_1_bits_uop_dst_rtype
      (_csr_exe_unit_io_bypass_0_bits_uop_dst_rtype),	// execution-units.scala:119:32
    .io_bypass_1_bits_data                  (_csr_exe_unit_io_bypass_0_bits_data[63:0]),	// core.scala:1078:32, execution-units.scala:119:32
    .io_bypass_2_valid                      (_alu_exe_unit_io_bypass_0_valid),	// execution-units.scala:119:32
    .io_bypass_2_bits_uop_pdst              (_alu_exe_unit_io_bypass_0_bits_uop_pdst),	// execution-units.scala:119:32
    .io_bypass_2_bits_uop_dst_rtype
      (_alu_exe_unit_io_bypass_0_bits_uop_dst_rtype),	// execution-units.scala:119:32
    .io_bypass_2_bits_data                  (_alu_exe_unit_io_bypass_0_bits_data[63:0]),	// core.scala:1078:32, execution-units.scala:119:32
    .io_bypass_3_valid                      (_alu_exe_unit_io_bypass_1_valid),	// execution-units.scala:119:32
    .io_bypass_3_bits_uop_pdst              (_alu_exe_unit_io_bypass_1_bits_uop_pdst),	// execution-units.scala:119:32
    .io_bypass_3_bits_uop_dst_rtype
      (_alu_exe_unit_io_bypass_1_bits_uop_dst_rtype),	// execution-units.scala:119:32
    .io_bypass_3_bits_data                  (_alu_exe_unit_io_bypass_1_bits_data[63:0]),	// core.scala:1078:32, execution-units.scala:119:32
    .io_bypass_4_valid                      (_alu_exe_unit_io_bypass_2_valid),	// execution-units.scala:119:32
    .io_bypass_4_bits_uop_pdst              (_alu_exe_unit_io_bypass_2_bits_uop_pdst),	// execution-units.scala:119:32
    .io_bypass_4_bits_uop_dst_rtype
      (_alu_exe_unit_io_bypass_2_bits_uop_dst_rtype),	// execution-units.scala:119:32
    .io_bypass_4_bits_data                  (_alu_exe_unit_io_bypass_2_bits_data[63:0]),	// core.scala:1078:32, execution-units.scala:119:32
    .io_kill                                (iregister_read_io_kill_REG),	// core.scala:981:38
    .io_brupdate_b1_resolve_mask            (b1_resolve_mask),	// core.scala:196:72
    .io_brupdate_b1_mispredict_mask         (b1_mispredict_mask),	// core.scala:197:93
    .io_rf_read_ports_0_addr                (_iregister_read_io_rf_read_ports_0_addr),
    .io_rf_read_ports_1_addr                (_iregister_read_io_rf_read_ports_1_addr),
    .io_rf_read_ports_2_addr                (_iregister_read_io_rf_read_ports_2_addr),
    .io_rf_read_ports_3_addr                (_iregister_read_io_rf_read_ports_3_addr),
    .io_rf_read_ports_4_addr                (_iregister_read_io_rf_read_ports_4_addr),
    .io_rf_read_ports_5_addr                (_iregister_read_io_rf_read_ports_5_addr),
    .io_rf_read_ports_6_addr                (_iregister_read_io_rf_read_ports_6_addr),
    .io_rf_read_ports_7_addr                (_iregister_read_io_rf_read_ports_7_addr),
    .io_exe_reqs_0_valid                    (_iregister_read_io_exe_reqs_0_valid),
    .io_exe_reqs_0_bits_uop_uopc            (_iregister_read_io_exe_reqs_0_bits_uop_uopc),
    .io_exe_reqs_0_bits_uop_inst            (_iregister_read_io_exe_reqs_0_bits_uop_inst),
    .io_exe_reqs_0_bits_uop_debug_inst
      (_iregister_read_io_exe_reqs_0_bits_uop_debug_inst),
    .io_exe_reqs_0_bits_uop_is_rvc
      (_iregister_read_io_exe_reqs_0_bits_uop_is_rvc),
    .io_exe_reqs_0_bits_uop_debug_pc
      (_iregister_read_io_exe_reqs_0_bits_uop_debug_pc),
    .io_exe_reqs_0_bits_uop_iq_type
      (_iregister_read_io_exe_reqs_0_bits_uop_iq_type),
    .io_exe_reqs_0_bits_uop_fu_code
      (_iregister_read_io_exe_reqs_0_bits_uop_fu_code),
    .io_exe_reqs_0_bits_uop_ctrl_br_type
      (_iregister_read_io_exe_reqs_0_bits_uop_ctrl_br_type),
    .io_exe_reqs_0_bits_uop_ctrl_op1_sel
      (_iregister_read_io_exe_reqs_0_bits_uop_ctrl_op1_sel),
    .io_exe_reqs_0_bits_uop_ctrl_op2_sel
      (_iregister_read_io_exe_reqs_0_bits_uop_ctrl_op2_sel),
    .io_exe_reqs_0_bits_uop_ctrl_imm_sel
      (_iregister_read_io_exe_reqs_0_bits_uop_ctrl_imm_sel),
    .io_exe_reqs_0_bits_uop_ctrl_op_fcn
      (_iregister_read_io_exe_reqs_0_bits_uop_ctrl_op_fcn),
    .io_exe_reqs_0_bits_uop_ctrl_fcn_dw
      (_iregister_read_io_exe_reqs_0_bits_uop_ctrl_fcn_dw),
    .io_exe_reqs_0_bits_uop_ctrl_is_load
      (_iregister_read_io_exe_reqs_0_bits_uop_ctrl_is_load),
    .io_exe_reqs_0_bits_uop_ctrl_is_sta
      (_iregister_read_io_exe_reqs_0_bits_uop_ctrl_is_sta),
    .io_exe_reqs_0_bits_uop_ctrl_is_std
      (_iregister_read_io_exe_reqs_0_bits_uop_ctrl_is_std),
    .io_exe_reqs_0_bits_uop_iw_state
      (_iregister_read_io_exe_reqs_0_bits_uop_iw_state),
    .io_exe_reqs_0_bits_uop_is_br
      (_iregister_read_io_exe_reqs_0_bits_uop_is_br),
    .io_exe_reqs_0_bits_uop_is_jalr
      (_iregister_read_io_exe_reqs_0_bits_uop_is_jalr),
    .io_exe_reqs_0_bits_uop_is_jal
      (_iregister_read_io_exe_reqs_0_bits_uop_is_jal),
    .io_exe_reqs_0_bits_uop_is_sfb
      (_iregister_read_io_exe_reqs_0_bits_uop_is_sfb),
    .io_exe_reqs_0_bits_uop_br_mask
      (_iregister_read_io_exe_reqs_0_bits_uop_br_mask),
    .io_exe_reqs_0_bits_uop_br_tag
      (_iregister_read_io_exe_reqs_0_bits_uop_br_tag),
    .io_exe_reqs_0_bits_uop_ftq_idx
      (_iregister_read_io_exe_reqs_0_bits_uop_ftq_idx),
    .io_exe_reqs_0_bits_uop_edge_inst
      (_iregister_read_io_exe_reqs_0_bits_uop_edge_inst),
    .io_exe_reqs_0_bits_uop_pc_lob
      (_iregister_read_io_exe_reqs_0_bits_uop_pc_lob),
    .io_exe_reqs_0_bits_uop_taken
      (_iregister_read_io_exe_reqs_0_bits_uop_taken),
    .io_exe_reqs_0_bits_uop_imm_packed
      (_iregister_read_io_exe_reqs_0_bits_uop_imm_packed),
    .io_exe_reqs_0_bits_uop_csr_addr
      (_iregister_read_io_exe_reqs_0_bits_uop_csr_addr),
    .io_exe_reqs_0_bits_uop_rob_idx
      (_iregister_read_io_exe_reqs_0_bits_uop_rob_idx),
    .io_exe_reqs_0_bits_uop_ldq_idx
      (_iregister_read_io_exe_reqs_0_bits_uop_ldq_idx),
    .io_exe_reqs_0_bits_uop_stq_idx
      (_iregister_read_io_exe_reqs_0_bits_uop_stq_idx),
    .io_exe_reqs_0_bits_uop_rxq_idx
      (_iregister_read_io_exe_reqs_0_bits_uop_rxq_idx),
    .io_exe_reqs_0_bits_uop_pdst            (_iregister_read_io_exe_reqs_0_bits_uop_pdst),
    .io_exe_reqs_0_bits_uop_prs1            (_iregister_read_io_exe_reqs_0_bits_uop_prs1),
    .io_exe_reqs_0_bits_uop_prs2            (_iregister_read_io_exe_reqs_0_bits_uop_prs2),
    .io_exe_reqs_0_bits_uop_prs3            (_iregister_read_io_exe_reqs_0_bits_uop_prs3),
    .io_exe_reqs_0_bits_uop_ppred
      (_iregister_read_io_exe_reqs_0_bits_uop_ppred),
    .io_exe_reqs_0_bits_uop_prs1_busy
      (_iregister_read_io_exe_reqs_0_bits_uop_prs1_busy),
    .io_exe_reqs_0_bits_uop_prs2_busy
      (_iregister_read_io_exe_reqs_0_bits_uop_prs2_busy),
    .io_exe_reqs_0_bits_uop_prs3_busy
      (_iregister_read_io_exe_reqs_0_bits_uop_prs3_busy),
    .io_exe_reqs_0_bits_uop_ppred_busy
      (_iregister_read_io_exe_reqs_0_bits_uop_ppred_busy),
    .io_exe_reqs_0_bits_uop_stale_pdst
      (_iregister_read_io_exe_reqs_0_bits_uop_stale_pdst),
    .io_exe_reqs_0_bits_uop_exception
      (_iregister_read_io_exe_reqs_0_bits_uop_exception),
    .io_exe_reqs_0_bits_uop_exc_cause
      (_iregister_read_io_exe_reqs_0_bits_uop_exc_cause),
    .io_exe_reqs_0_bits_uop_bypassable
      (_iregister_read_io_exe_reqs_0_bits_uop_bypassable),
    .io_exe_reqs_0_bits_uop_mem_cmd
      (_iregister_read_io_exe_reqs_0_bits_uop_mem_cmd),
    .io_exe_reqs_0_bits_uop_mem_size
      (_iregister_read_io_exe_reqs_0_bits_uop_mem_size),
    .io_exe_reqs_0_bits_uop_mem_signed
      (_iregister_read_io_exe_reqs_0_bits_uop_mem_signed),
    .io_exe_reqs_0_bits_uop_is_fence
      (_iregister_read_io_exe_reqs_0_bits_uop_is_fence),
    .io_exe_reqs_0_bits_uop_is_fencei
      (_iregister_read_io_exe_reqs_0_bits_uop_is_fencei),
    .io_exe_reqs_0_bits_uop_is_amo
      (_iregister_read_io_exe_reqs_0_bits_uop_is_amo),
    .io_exe_reqs_0_bits_uop_uses_ldq
      (_iregister_read_io_exe_reqs_0_bits_uop_uses_ldq),
    .io_exe_reqs_0_bits_uop_uses_stq
      (_iregister_read_io_exe_reqs_0_bits_uop_uses_stq),
    .io_exe_reqs_0_bits_uop_is_sys_pc2epc
      (_iregister_read_io_exe_reqs_0_bits_uop_is_sys_pc2epc),
    .io_exe_reqs_0_bits_uop_is_unique
      (_iregister_read_io_exe_reqs_0_bits_uop_is_unique),
    .io_exe_reqs_0_bits_uop_flush_on_commit
      (_iregister_read_io_exe_reqs_0_bits_uop_flush_on_commit),
    .io_exe_reqs_0_bits_uop_ldst_is_rs1
      (_iregister_read_io_exe_reqs_0_bits_uop_ldst_is_rs1),
    .io_exe_reqs_0_bits_uop_ldst            (_iregister_read_io_exe_reqs_0_bits_uop_ldst),
    .io_exe_reqs_0_bits_uop_lrs1            (_iregister_read_io_exe_reqs_0_bits_uop_lrs1),
    .io_exe_reqs_0_bits_uop_lrs2            (_iregister_read_io_exe_reqs_0_bits_uop_lrs2),
    .io_exe_reqs_0_bits_uop_lrs3            (_iregister_read_io_exe_reqs_0_bits_uop_lrs3),
    .io_exe_reqs_0_bits_uop_ldst_val
      (_iregister_read_io_exe_reqs_0_bits_uop_ldst_val),
    .io_exe_reqs_0_bits_uop_dst_rtype
      (_iregister_read_io_exe_reqs_0_bits_uop_dst_rtype),
    .io_exe_reqs_0_bits_uop_lrs1_rtype
      (_iregister_read_io_exe_reqs_0_bits_uop_lrs1_rtype),
    .io_exe_reqs_0_bits_uop_lrs2_rtype
      (_iregister_read_io_exe_reqs_0_bits_uop_lrs2_rtype),
    .io_exe_reqs_0_bits_uop_frs3_en
      (_iregister_read_io_exe_reqs_0_bits_uop_frs3_en),
    .io_exe_reqs_0_bits_uop_fp_val
      (_iregister_read_io_exe_reqs_0_bits_uop_fp_val),
    .io_exe_reqs_0_bits_uop_fp_single
      (_iregister_read_io_exe_reqs_0_bits_uop_fp_single),
    .io_exe_reqs_0_bits_uop_xcpt_pf_if
      (_iregister_read_io_exe_reqs_0_bits_uop_xcpt_pf_if),
    .io_exe_reqs_0_bits_uop_xcpt_ae_if
      (_iregister_read_io_exe_reqs_0_bits_uop_xcpt_ae_if),
    .io_exe_reqs_0_bits_uop_xcpt_ma_if
      (_iregister_read_io_exe_reqs_0_bits_uop_xcpt_ma_if),
    .io_exe_reqs_0_bits_uop_bp_debug_if
      (_iregister_read_io_exe_reqs_0_bits_uop_bp_debug_if),
    .io_exe_reqs_0_bits_uop_bp_xcpt_if
      (_iregister_read_io_exe_reqs_0_bits_uop_bp_xcpt_if),
    .io_exe_reqs_0_bits_uop_debug_fsrc
      (_iregister_read_io_exe_reqs_0_bits_uop_debug_fsrc),
    .io_exe_reqs_0_bits_uop_debug_tsrc
      (_iregister_read_io_exe_reqs_0_bits_uop_debug_tsrc),
    .io_exe_reqs_0_bits_rs1_data            (_iregister_read_io_exe_reqs_0_bits_rs1_data),
    .io_exe_reqs_0_bits_rs2_data            (_iregister_read_io_exe_reqs_0_bits_rs2_data),
    .io_exe_reqs_1_valid                    (_iregister_read_io_exe_reqs_1_valid),
    .io_exe_reqs_1_bits_uop_uopc            (_iregister_read_io_exe_reqs_1_bits_uop_uopc),
    .io_exe_reqs_1_bits_uop_is_rvc
      (_iregister_read_io_exe_reqs_1_bits_uop_is_rvc),
    .io_exe_reqs_1_bits_uop_fu_code
      (_iregister_read_io_exe_reqs_1_bits_uop_fu_code),
    .io_exe_reqs_1_bits_uop_ctrl_br_type
      (_iregister_read_io_exe_reqs_1_bits_uop_ctrl_br_type),
    .io_exe_reqs_1_bits_uop_ctrl_op1_sel
      (_iregister_read_io_exe_reqs_1_bits_uop_ctrl_op1_sel),
    .io_exe_reqs_1_bits_uop_ctrl_op2_sel
      (_iregister_read_io_exe_reqs_1_bits_uop_ctrl_op2_sel),
    .io_exe_reqs_1_bits_uop_ctrl_imm_sel
      (_iregister_read_io_exe_reqs_1_bits_uop_ctrl_imm_sel),
    .io_exe_reqs_1_bits_uop_ctrl_op_fcn
      (_iregister_read_io_exe_reqs_1_bits_uop_ctrl_op_fcn),
    .io_exe_reqs_1_bits_uop_ctrl_fcn_dw
      (_iregister_read_io_exe_reqs_1_bits_uop_ctrl_fcn_dw),
    .io_exe_reqs_1_bits_uop_is_br
      (_iregister_read_io_exe_reqs_1_bits_uop_is_br),
    .io_exe_reqs_1_bits_uop_is_jalr
      (_iregister_read_io_exe_reqs_1_bits_uop_is_jalr),
    .io_exe_reqs_1_bits_uop_is_jal
      (_iregister_read_io_exe_reqs_1_bits_uop_is_jal),
    .io_exe_reqs_1_bits_uop_is_sfb
      (_iregister_read_io_exe_reqs_1_bits_uop_is_sfb),
    .io_exe_reqs_1_bits_uop_br_mask
      (_iregister_read_io_exe_reqs_1_bits_uop_br_mask),
    .io_exe_reqs_1_bits_uop_br_tag
      (_iregister_read_io_exe_reqs_1_bits_uop_br_tag),
    .io_exe_reqs_1_bits_uop_ftq_idx
      (_iregister_read_io_exe_reqs_1_bits_uop_ftq_idx),
    .io_exe_reqs_1_bits_uop_edge_inst
      (_iregister_read_io_exe_reqs_1_bits_uop_edge_inst),
    .io_exe_reqs_1_bits_uop_pc_lob
      (_iregister_read_io_exe_reqs_1_bits_uop_pc_lob),
    .io_exe_reqs_1_bits_uop_taken
      (_iregister_read_io_exe_reqs_1_bits_uop_taken),
    .io_exe_reqs_1_bits_uop_imm_packed
      (_iregister_read_io_exe_reqs_1_bits_uop_imm_packed),
    .io_exe_reqs_1_bits_uop_rob_idx
      (_iregister_read_io_exe_reqs_1_bits_uop_rob_idx),
    .io_exe_reqs_1_bits_uop_ldq_idx
      (_iregister_read_io_exe_reqs_1_bits_uop_ldq_idx),
    .io_exe_reqs_1_bits_uop_stq_idx
      (_iregister_read_io_exe_reqs_1_bits_uop_stq_idx),
    .io_exe_reqs_1_bits_uop_pdst            (_iregister_read_io_exe_reqs_1_bits_uop_pdst),
    .io_exe_reqs_1_bits_uop_prs1            (_iregister_read_io_exe_reqs_1_bits_uop_prs1),
    .io_exe_reqs_1_bits_uop_bypassable
      (_iregister_read_io_exe_reqs_1_bits_uop_bypassable),
    .io_exe_reqs_1_bits_uop_is_amo
      (_iregister_read_io_exe_reqs_1_bits_uop_is_amo),
    .io_exe_reqs_1_bits_uop_uses_stq
      (_iregister_read_io_exe_reqs_1_bits_uop_uses_stq),
    .io_exe_reqs_1_bits_uop_dst_rtype
      (_iregister_read_io_exe_reqs_1_bits_uop_dst_rtype),
    .io_exe_reqs_1_bits_rs1_data            (_iregister_read_io_exe_reqs_1_bits_rs1_data),
    .io_exe_reqs_1_bits_rs2_data            (_iregister_read_io_exe_reqs_1_bits_rs2_data),
    .io_exe_reqs_2_valid                    (_iregister_read_io_exe_reqs_2_valid),
    .io_exe_reqs_2_bits_uop_uopc            (_iregister_read_io_exe_reqs_2_bits_uop_uopc),
    .io_exe_reqs_2_bits_uop_inst            (_iregister_read_io_exe_reqs_2_bits_uop_inst),
    .io_exe_reqs_2_bits_uop_debug_inst
      (_iregister_read_io_exe_reqs_2_bits_uop_debug_inst),
    .io_exe_reqs_2_bits_uop_is_rvc
      (_iregister_read_io_exe_reqs_2_bits_uop_is_rvc),
    .io_exe_reqs_2_bits_uop_debug_pc
      (_iregister_read_io_exe_reqs_2_bits_uop_debug_pc),
    .io_exe_reqs_2_bits_uop_iq_type
      (_iregister_read_io_exe_reqs_2_bits_uop_iq_type),
    .io_exe_reqs_2_bits_uop_fu_code
      (_iregister_read_io_exe_reqs_2_bits_uop_fu_code),
    .io_exe_reqs_2_bits_uop_ctrl_br_type
      (_iregister_read_io_exe_reqs_2_bits_uop_ctrl_br_type),
    .io_exe_reqs_2_bits_uop_ctrl_op1_sel
      (_iregister_read_io_exe_reqs_2_bits_uop_ctrl_op1_sel),
    .io_exe_reqs_2_bits_uop_ctrl_op2_sel
      (_iregister_read_io_exe_reqs_2_bits_uop_ctrl_op2_sel),
    .io_exe_reqs_2_bits_uop_ctrl_imm_sel
      (_iregister_read_io_exe_reqs_2_bits_uop_ctrl_imm_sel),
    .io_exe_reqs_2_bits_uop_ctrl_op_fcn
      (_iregister_read_io_exe_reqs_2_bits_uop_ctrl_op_fcn),
    .io_exe_reqs_2_bits_uop_ctrl_fcn_dw
      (_iregister_read_io_exe_reqs_2_bits_uop_ctrl_fcn_dw),
    .io_exe_reqs_2_bits_uop_ctrl_csr_cmd
      (_iregister_read_io_exe_reqs_2_bits_uop_ctrl_csr_cmd),
    .io_exe_reqs_2_bits_uop_ctrl_is_load
      (_iregister_read_io_exe_reqs_2_bits_uop_ctrl_is_load),
    .io_exe_reqs_2_bits_uop_ctrl_is_sta
      (_iregister_read_io_exe_reqs_2_bits_uop_ctrl_is_sta),
    .io_exe_reqs_2_bits_uop_ctrl_is_std
      (_iregister_read_io_exe_reqs_2_bits_uop_ctrl_is_std),
    .io_exe_reqs_2_bits_uop_iw_state
      (_iregister_read_io_exe_reqs_2_bits_uop_iw_state),
    .io_exe_reqs_2_bits_uop_is_br
      (_iregister_read_io_exe_reqs_2_bits_uop_is_br),
    .io_exe_reqs_2_bits_uop_is_jalr
      (_iregister_read_io_exe_reqs_2_bits_uop_is_jalr),
    .io_exe_reqs_2_bits_uop_is_jal
      (_iregister_read_io_exe_reqs_2_bits_uop_is_jal),
    .io_exe_reqs_2_bits_uop_is_sfb
      (_iregister_read_io_exe_reqs_2_bits_uop_is_sfb),
    .io_exe_reqs_2_bits_uop_br_mask
      (_iregister_read_io_exe_reqs_2_bits_uop_br_mask),
    .io_exe_reqs_2_bits_uop_br_tag
      (_iregister_read_io_exe_reqs_2_bits_uop_br_tag),
    .io_exe_reqs_2_bits_uop_ftq_idx
      (_iregister_read_io_exe_reqs_2_bits_uop_ftq_idx),
    .io_exe_reqs_2_bits_uop_edge_inst
      (_iregister_read_io_exe_reqs_2_bits_uop_edge_inst),
    .io_exe_reqs_2_bits_uop_pc_lob
      (_iregister_read_io_exe_reqs_2_bits_uop_pc_lob),
    .io_exe_reqs_2_bits_uop_taken
      (_iregister_read_io_exe_reqs_2_bits_uop_taken),
    .io_exe_reqs_2_bits_uop_imm_packed
      (_iregister_read_io_exe_reqs_2_bits_uop_imm_packed),
    .io_exe_reqs_2_bits_uop_csr_addr
      (_iregister_read_io_exe_reqs_2_bits_uop_csr_addr),
    .io_exe_reqs_2_bits_uop_rob_idx
      (_iregister_read_io_exe_reqs_2_bits_uop_rob_idx),
    .io_exe_reqs_2_bits_uop_ldq_idx
      (_iregister_read_io_exe_reqs_2_bits_uop_ldq_idx),
    .io_exe_reqs_2_bits_uop_stq_idx
      (_iregister_read_io_exe_reqs_2_bits_uop_stq_idx),
    .io_exe_reqs_2_bits_uop_rxq_idx
      (_iregister_read_io_exe_reqs_2_bits_uop_rxq_idx),
    .io_exe_reqs_2_bits_uop_pdst            (_iregister_read_io_exe_reqs_2_bits_uop_pdst),
    .io_exe_reqs_2_bits_uop_prs1            (_iregister_read_io_exe_reqs_2_bits_uop_prs1),
    .io_exe_reqs_2_bits_uop_prs2            (_iregister_read_io_exe_reqs_2_bits_uop_prs2),
    .io_exe_reqs_2_bits_uop_prs3            (_iregister_read_io_exe_reqs_2_bits_uop_prs3),
    .io_exe_reqs_2_bits_uop_ppred
      (_iregister_read_io_exe_reqs_2_bits_uop_ppred),
    .io_exe_reqs_2_bits_uop_prs1_busy
      (_iregister_read_io_exe_reqs_2_bits_uop_prs1_busy),
    .io_exe_reqs_2_bits_uop_prs2_busy
      (_iregister_read_io_exe_reqs_2_bits_uop_prs2_busy),
    .io_exe_reqs_2_bits_uop_prs3_busy
      (_iregister_read_io_exe_reqs_2_bits_uop_prs3_busy),
    .io_exe_reqs_2_bits_uop_ppred_busy
      (_iregister_read_io_exe_reqs_2_bits_uop_ppred_busy),
    .io_exe_reqs_2_bits_uop_stale_pdst
      (_iregister_read_io_exe_reqs_2_bits_uop_stale_pdst),
    .io_exe_reqs_2_bits_uop_exception
      (_iregister_read_io_exe_reqs_2_bits_uop_exception),
    .io_exe_reqs_2_bits_uop_exc_cause
      (_iregister_read_io_exe_reqs_2_bits_uop_exc_cause),
    .io_exe_reqs_2_bits_uop_bypassable
      (_iregister_read_io_exe_reqs_2_bits_uop_bypassable),
    .io_exe_reqs_2_bits_uop_mem_cmd
      (_iregister_read_io_exe_reqs_2_bits_uop_mem_cmd),
    .io_exe_reqs_2_bits_uop_mem_size
      (_iregister_read_io_exe_reqs_2_bits_uop_mem_size),
    .io_exe_reqs_2_bits_uop_mem_signed
      (_iregister_read_io_exe_reqs_2_bits_uop_mem_signed),
    .io_exe_reqs_2_bits_uop_is_fence
      (_iregister_read_io_exe_reqs_2_bits_uop_is_fence),
    .io_exe_reqs_2_bits_uop_is_fencei
      (_iregister_read_io_exe_reqs_2_bits_uop_is_fencei),
    .io_exe_reqs_2_bits_uop_is_amo
      (_iregister_read_io_exe_reqs_2_bits_uop_is_amo),
    .io_exe_reqs_2_bits_uop_uses_ldq
      (_iregister_read_io_exe_reqs_2_bits_uop_uses_ldq),
    .io_exe_reqs_2_bits_uop_uses_stq
      (_iregister_read_io_exe_reqs_2_bits_uop_uses_stq),
    .io_exe_reqs_2_bits_uop_is_sys_pc2epc
      (_iregister_read_io_exe_reqs_2_bits_uop_is_sys_pc2epc),
    .io_exe_reqs_2_bits_uop_is_unique
      (_iregister_read_io_exe_reqs_2_bits_uop_is_unique),
    .io_exe_reqs_2_bits_uop_flush_on_commit
      (_iregister_read_io_exe_reqs_2_bits_uop_flush_on_commit),
    .io_exe_reqs_2_bits_uop_ldst_is_rs1
      (_iregister_read_io_exe_reqs_2_bits_uop_ldst_is_rs1),
    .io_exe_reqs_2_bits_uop_ldst            (_iregister_read_io_exe_reqs_2_bits_uop_ldst),
    .io_exe_reqs_2_bits_uop_lrs1            (_iregister_read_io_exe_reqs_2_bits_uop_lrs1),
    .io_exe_reqs_2_bits_uop_lrs2            (_iregister_read_io_exe_reqs_2_bits_uop_lrs2),
    .io_exe_reqs_2_bits_uop_lrs3            (_iregister_read_io_exe_reqs_2_bits_uop_lrs3),
    .io_exe_reqs_2_bits_uop_ldst_val
      (_iregister_read_io_exe_reqs_2_bits_uop_ldst_val),
    .io_exe_reqs_2_bits_uop_dst_rtype
      (_iregister_read_io_exe_reqs_2_bits_uop_dst_rtype),
    .io_exe_reqs_2_bits_uop_lrs1_rtype
      (_iregister_read_io_exe_reqs_2_bits_uop_lrs1_rtype),
    .io_exe_reqs_2_bits_uop_lrs2_rtype
      (_iregister_read_io_exe_reqs_2_bits_uop_lrs2_rtype),
    .io_exe_reqs_2_bits_uop_frs3_en
      (_iregister_read_io_exe_reqs_2_bits_uop_frs3_en),
    .io_exe_reqs_2_bits_uop_fp_val
      (_iregister_read_io_exe_reqs_2_bits_uop_fp_val),
    .io_exe_reqs_2_bits_uop_fp_single
      (_iregister_read_io_exe_reqs_2_bits_uop_fp_single),
    .io_exe_reqs_2_bits_uop_xcpt_pf_if
      (_iregister_read_io_exe_reqs_2_bits_uop_xcpt_pf_if),
    .io_exe_reqs_2_bits_uop_xcpt_ae_if
      (_iregister_read_io_exe_reqs_2_bits_uop_xcpt_ae_if),
    .io_exe_reqs_2_bits_uop_xcpt_ma_if
      (_iregister_read_io_exe_reqs_2_bits_uop_xcpt_ma_if),
    .io_exe_reqs_2_bits_uop_bp_debug_if
      (_iregister_read_io_exe_reqs_2_bits_uop_bp_debug_if),
    .io_exe_reqs_2_bits_uop_bp_xcpt_if
      (_iregister_read_io_exe_reqs_2_bits_uop_bp_xcpt_if),
    .io_exe_reqs_2_bits_uop_debug_fsrc
      (_iregister_read_io_exe_reqs_2_bits_uop_debug_fsrc),
    .io_exe_reqs_2_bits_uop_debug_tsrc
      (_iregister_read_io_exe_reqs_2_bits_uop_debug_tsrc),
    .io_exe_reqs_2_bits_rs1_data            (_iregister_read_io_exe_reqs_2_bits_rs1_data),
    .io_exe_reqs_2_bits_rs2_data            (_iregister_read_io_exe_reqs_2_bits_rs2_data),
    .io_exe_reqs_3_valid                    (_iregister_read_io_exe_reqs_3_valid),
    .io_exe_reqs_3_bits_uop_uopc            (_iregister_read_io_exe_reqs_3_bits_uop_uopc),
    .io_exe_reqs_3_bits_uop_is_rvc
      (_iregister_read_io_exe_reqs_3_bits_uop_is_rvc),
    .io_exe_reqs_3_bits_uop_fu_code
      (_iregister_read_io_exe_reqs_3_bits_uop_fu_code),
    .io_exe_reqs_3_bits_uop_ctrl_br_type
      (_iregister_read_io_exe_reqs_3_bits_uop_ctrl_br_type),
    .io_exe_reqs_3_bits_uop_ctrl_op1_sel
      (_iregister_read_io_exe_reqs_3_bits_uop_ctrl_op1_sel),
    .io_exe_reqs_3_bits_uop_ctrl_op2_sel
      (_iregister_read_io_exe_reqs_3_bits_uop_ctrl_op2_sel),
    .io_exe_reqs_3_bits_uop_ctrl_imm_sel
      (_iregister_read_io_exe_reqs_3_bits_uop_ctrl_imm_sel),
    .io_exe_reqs_3_bits_uop_ctrl_op_fcn
      (_iregister_read_io_exe_reqs_3_bits_uop_ctrl_op_fcn),
    .io_exe_reqs_3_bits_uop_ctrl_fcn_dw
      (_iregister_read_io_exe_reqs_3_bits_uop_ctrl_fcn_dw),
    .io_exe_reqs_3_bits_uop_is_br
      (_iregister_read_io_exe_reqs_3_bits_uop_is_br),
    .io_exe_reqs_3_bits_uop_is_jalr
      (_iregister_read_io_exe_reqs_3_bits_uop_is_jalr),
    .io_exe_reqs_3_bits_uop_is_jal
      (_iregister_read_io_exe_reqs_3_bits_uop_is_jal),
    .io_exe_reqs_3_bits_uop_is_sfb
      (_iregister_read_io_exe_reqs_3_bits_uop_is_sfb),
    .io_exe_reqs_3_bits_uop_br_mask
      (_iregister_read_io_exe_reqs_3_bits_uop_br_mask),
    .io_exe_reqs_3_bits_uop_br_tag
      (_iregister_read_io_exe_reqs_3_bits_uop_br_tag),
    .io_exe_reqs_3_bits_uop_ftq_idx
      (_iregister_read_io_exe_reqs_3_bits_uop_ftq_idx),
    .io_exe_reqs_3_bits_uop_edge_inst
      (_iregister_read_io_exe_reqs_3_bits_uop_edge_inst),
    .io_exe_reqs_3_bits_uop_pc_lob
      (_iregister_read_io_exe_reqs_3_bits_uop_pc_lob),
    .io_exe_reqs_3_bits_uop_taken
      (_iregister_read_io_exe_reqs_3_bits_uop_taken),
    .io_exe_reqs_3_bits_uop_imm_packed
      (_iregister_read_io_exe_reqs_3_bits_uop_imm_packed),
    .io_exe_reqs_3_bits_uop_rob_idx
      (_iregister_read_io_exe_reqs_3_bits_uop_rob_idx),
    .io_exe_reqs_3_bits_uop_ldq_idx
      (_iregister_read_io_exe_reqs_3_bits_uop_ldq_idx),
    .io_exe_reqs_3_bits_uop_stq_idx
      (_iregister_read_io_exe_reqs_3_bits_uop_stq_idx),
    .io_exe_reqs_3_bits_uop_pdst            (_iregister_read_io_exe_reqs_3_bits_uop_pdst),
    .io_exe_reqs_3_bits_uop_prs1            (_iregister_read_io_exe_reqs_3_bits_uop_prs1),
    .io_exe_reqs_3_bits_uop_bypassable
      (_iregister_read_io_exe_reqs_3_bits_uop_bypassable),
    .io_exe_reqs_3_bits_uop_is_amo
      (_iregister_read_io_exe_reqs_3_bits_uop_is_amo),
    .io_exe_reqs_3_bits_uop_uses_stq
      (_iregister_read_io_exe_reqs_3_bits_uop_uses_stq),
    .io_exe_reqs_3_bits_uop_dst_rtype
      (_iregister_read_io_exe_reqs_3_bits_uop_dst_rtype),
    .io_exe_reqs_3_bits_rs1_data            (_iregister_read_io_exe_reqs_3_bits_rs1_data),
    .io_exe_reqs_3_bits_rs2_data            (_iregister_read_io_exe_reqs_3_bits_rs2_data)
  );
  Rob_1 rob (	// core.scala:140:32
    .clock                          (clock),
    .reset                          (reset),
    .io_enq_valids_0                (dis_fire_0),	// core.scala:708:62
    .io_enq_valids_1                (dis_fire_1),	// core.scala:708:62
    .io_enq_valids_2                (dis_fire_2),	// core.scala:708:62
    .io_enq_uops_0_uopc             (_rename_stage_io_ren2_uops_0_uopc),	// core.scala:100:32
    .io_enq_uops_0_is_rvc           (_rename_stage_io_ren2_uops_0_is_rvc),	// core.scala:100:32
    .io_enq_uops_0_is_br            (_rename_stage_io_ren2_uops_0_is_br),	// core.scala:100:32
    .io_enq_uops_0_is_jalr          (_rename_stage_io_ren2_uops_0_is_jalr),	// core.scala:100:32
    .io_enq_uops_0_br_mask          (_rename_stage_io_ren2_uops_0_br_mask),	// core.scala:100:32
    .io_enq_uops_0_ftq_idx          (_rename_stage_io_ren2_uops_0_ftq_idx),	// core.scala:100:32
    .io_enq_uops_0_edge_inst        (_rename_stage_io_ren2_uops_0_edge_inst),	// core.scala:100:32
    .io_enq_uops_0_pc_lob           (_rename_stage_io_ren2_uops_0_pc_lob),	// core.scala:100:32
    .io_enq_uops_0_rob_idx          (dis_uops_0_rob_idx),	// core.scala:743:27
    .io_enq_uops_0_pdst             (dis_uops_0_pdst),	// core.scala:653:28
    .io_enq_uops_0_stale_pdst       (dis_uops_0_stale_pdst),	// core.scala:656:34
    .io_enq_uops_0_exception        (_rename_stage_io_ren2_uops_0_exception),	// core.scala:100:32
    .io_enq_uops_0_exc_cause        (_rename_stage_io_ren2_uops_0_exc_cause),	// core.scala:100:32
    .io_enq_uops_0_is_fence         (_rename_stage_io_ren2_uops_0_is_fence),	// core.scala:100:32
    .io_enq_uops_0_is_fencei        (_rename_stage_io_ren2_uops_0_is_fencei),	// core.scala:100:32
    .io_enq_uops_0_uses_ldq         (_rename_stage_io_ren2_uops_0_uses_ldq),	// core.scala:100:32
    .io_enq_uops_0_uses_stq         (_rename_stage_io_ren2_uops_0_uses_stq),	// core.scala:100:32
    .io_enq_uops_0_is_sys_pc2epc    (_rename_stage_io_ren2_uops_0_is_sys_pc2epc),	// core.scala:100:32
    .io_enq_uops_0_is_unique        (_rename_stage_io_ren2_uops_0_is_unique),	// core.scala:100:32
    .io_enq_uops_0_flush_on_commit  (_rename_stage_io_ren2_uops_0_flush_on_commit),	// core.scala:100:32
    .io_enq_uops_0_ldst             (_rename_stage_io_ren2_uops_0_ldst),	// core.scala:100:32
    .io_enq_uops_0_ldst_val         (_rename_stage_io_ren2_uops_0_ldst_val),	// core.scala:100:32
    .io_enq_uops_0_dst_rtype        (_rename_stage_io_ren2_uops_0_dst_rtype),	// core.scala:100:32
    .io_enq_uops_0_fp_val           (_rename_stage_io_ren2_uops_0_fp_val),	// core.scala:100:32
    .io_enq_uops_1_uopc             (_rename_stage_io_ren2_uops_1_uopc),	// core.scala:100:32
    .io_enq_uops_1_is_rvc           (_rename_stage_io_ren2_uops_1_is_rvc),	// core.scala:100:32
    .io_enq_uops_1_is_br            (_rename_stage_io_ren2_uops_1_is_br),	// core.scala:100:32
    .io_enq_uops_1_is_jalr          (_rename_stage_io_ren2_uops_1_is_jalr),	// core.scala:100:32
    .io_enq_uops_1_br_mask          (_rename_stage_io_ren2_uops_1_br_mask),	// core.scala:100:32
    .io_enq_uops_1_ftq_idx          (_rename_stage_io_ren2_uops_1_ftq_idx),	// core.scala:100:32
    .io_enq_uops_1_edge_inst        (_rename_stage_io_ren2_uops_1_edge_inst),	// core.scala:100:32
    .io_enq_uops_1_pc_lob           (_rename_stage_io_ren2_uops_1_pc_lob),	// core.scala:100:32
    .io_enq_uops_1_rob_idx          (dis_uops_1_rob_idx),	// core.scala:743:27
    .io_enq_uops_1_pdst             (dis_uops_1_pdst),	// core.scala:653:28
    .io_enq_uops_1_stale_pdst       (dis_uops_1_stale_pdst),	// core.scala:656:34
    .io_enq_uops_1_exception        (_rename_stage_io_ren2_uops_1_exception),	// core.scala:100:32
    .io_enq_uops_1_exc_cause        (_rename_stage_io_ren2_uops_1_exc_cause),	// core.scala:100:32
    .io_enq_uops_1_is_fence         (_rename_stage_io_ren2_uops_1_is_fence),	// core.scala:100:32
    .io_enq_uops_1_is_fencei        (_rename_stage_io_ren2_uops_1_is_fencei),	// core.scala:100:32
    .io_enq_uops_1_uses_ldq         (_rename_stage_io_ren2_uops_1_uses_ldq),	// core.scala:100:32
    .io_enq_uops_1_uses_stq         (_rename_stage_io_ren2_uops_1_uses_stq),	// core.scala:100:32
    .io_enq_uops_1_is_sys_pc2epc    (_rename_stage_io_ren2_uops_1_is_sys_pc2epc),	// core.scala:100:32
    .io_enq_uops_1_is_unique        (_rename_stage_io_ren2_uops_1_is_unique),	// core.scala:100:32
    .io_enq_uops_1_flush_on_commit  (_rename_stage_io_ren2_uops_1_flush_on_commit),	// core.scala:100:32
    .io_enq_uops_1_ldst             (_rename_stage_io_ren2_uops_1_ldst),	// core.scala:100:32
    .io_enq_uops_1_ldst_val         (_rename_stage_io_ren2_uops_1_ldst_val),	// core.scala:100:32
    .io_enq_uops_1_dst_rtype        (_rename_stage_io_ren2_uops_1_dst_rtype),	// core.scala:100:32
    .io_enq_uops_1_fp_val           (_rename_stage_io_ren2_uops_1_fp_val),	// core.scala:100:32
    .io_enq_uops_2_uopc             (_rename_stage_io_ren2_uops_2_uopc),	// core.scala:100:32
    .io_enq_uops_2_is_rvc           (_rename_stage_io_ren2_uops_2_is_rvc),	// core.scala:100:32
    .io_enq_uops_2_is_br            (_rename_stage_io_ren2_uops_2_is_br),	// core.scala:100:32
    .io_enq_uops_2_is_jalr          (_rename_stage_io_ren2_uops_2_is_jalr),	// core.scala:100:32
    .io_enq_uops_2_br_mask          (_rename_stage_io_ren2_uops_2_br_mask),	// core.scala:100:32
    .io_enq_uops_2_ftq_idx          (_rename_stage_io_ren2_uops_2_ftq_idx),	// core.scala:100:32
    .io_enq_uops_2_edge_inst        (_rename_stage_io_ren2_uops_2_edge_inst),	// core.scala:100:32
    .io_enq_uops_2_pc_lob           (_rename_stage_io_ren2_uops_2_pc_lob),	// core.scala:100:32
    .io_enq_uops_2_rob_idx          (dis_uops_2_rob_idx),	// core.scala:743:27
    .io_enq_uops_2_pdst             (dis_uops_2_pdst),	// core.scala:653:28
    .io_enq_uops_2_stale_pdst       (dis_uops_2_stale_pdst),	// core.scala:656:34
    .io_enq_uops_2_exception        (_rename_stage_io_ren2_uops_2_exception),	// core.scala:100:32
    .io_enq_uops_2_exc_cause        (_rename_stage_io_ren2_uops_2_exc_cause),	// core.scala:100:32
    .io_enq_uops_2_is_fence         (_rename_stage_io_ren2_uops_2_is_fence),	// core.scala:100:32
    .io_enq_uops_2_is_fencei        (_rename_stage_io_ren2_uops_2_is_fencei),	// core.scala:100:32
    .io_enq_uops_2_uses_ldq         (_rename_stage_io_ren2_uops_2_uses_ldq),	// core.scala:100:32
    .io_enq_uops_2_uses_stq         (_rename_stage_io_ren2_uops_2_uses_stq),	// core.scala:100:32
    .io_enq_uops_2_is_sys_pc2epc    (_rename_stage_io_ren2_uops_2_is_sys_pc2epc),	// core.scala:100:32
    .io_enq_uops_2_is_unique        (_rename_stage_io_ren2_uops_2_is_unique),	// core.scala:100:32
    .io_enq_uops_2_flush_on_commit  (_rename_stage_io_ren2_uops_2_flush_on_commit),	// core.scala:100:32
    .io_enq_uops_2_ldst             (_rename_stage_io_ren2_uops_2_ldst),	// core.scala:100:32
    .io_enq_uops_2_ldst_val         (_rename_stage_io_ren2_uops_2_ldst_val),	// core.scala:100:32
    .io_enq_uops_2_dst_rtype        (_rename_stage_io_ren2_uops_2_dst_rtype),	// core.scala:100:32
    .io_enq_uops_2_fp_val           (_rename_stage_io_ren2_uops_2_fp_val),	// core.scala:100:32
    .io_enq_partial_stall           (dis_stalls_2),	// core.scala:707:62
    .io_xcpt_fetch_pc               (io_ifu_get_pc_0_pc),
    .io_brupdate_b1_resolve_mask    (b1_resolve_mask),	// core.scala:196:72
    .io_brupdate_b1_mispredict_mask (b1_mispredict_mask),	// core.scala:197:93
    .io_brupdate_b2_uop_rob_idx     (b2_uop_rob_idx),	// core.scala:187:18
    .io_brupdate_b2_mispredict      (b2_mispredict),	// core.scala:187:18
    .io_wb_resps_0_valid
      (_ll_wbarb_io_out_valid
       & ~(_ll_wbarb_io_out_bits_uop_uses_stq & ~_ll_wbarb_io_out_bits_uop_is_amo)),	// core.scala:129:32, :1202:{54,57,75,78}
    .io_wb_resps_0_bits_uop_rob_idx (_ll_wbarb_io_out_bits_uop_rob_idx),	// core.scala:129:32
    .io_wb_resps_0_bits_uop_pdst    (_ll_wbarb_io_out_bits_uop_pdst),	// core.scala:129:32
    .io_wb_resps_0_bits_predicated  (_ll_wbarb_io_out_bits_predicated),	// core.scala:129:32
    .io_wb_resps_1_valid
      (_jmp_unit_io_iresp_valid
       & ~(_jmp_unit_io_iresp_bits_uop_uses_stq & ~_jmp_unit_io_iresp_bits_uop_is_amo)),	// core.scala:1223:{48,51,69,72}, execution-units.scala:119:32
    .io_wb_resps_1_bits_uop_rob_idx (_jmp_unit_io_iresp_bits_uop_rob_idx),	// execution-units.scala:119:32
    .io_wb_resps_1_bits_uop_pdst    (_jmp_unit_io_iresp_bits_uop_pdst),	// execution-units.scala:119:32
    .io_wb_resps_2_valid
      (_csr_exe_unit_io_iresp_valid
       & ~(_csr_exe_unit_io_iresp_bits_uop_uses_stq
           & ~_csr_exe_unit_io_iresp_bits_uop_is_amo)),	// core.scala:1223:{48,51,69,72}, execution-units.scala:119:32
    .io_wb_resps_2_bits_uop_rob_idx (_csr_exe_unit_io_iresp_bits_uop_rob_idx),	// execution-units.scala:119:32
    .io_wb_resps_2_bits_uop_pdst    (_csr_exe_unit_io_iresp_bits_uop_pdst),	// execution-units.scala:119:32
    .io_wb_resps_3_valid
      (_alu_exe_unit_io_iresp_valid
       & ~(_alu_exe_unit_io_iresp_bits_uop_uses_stq
           & ~_alu_exe_unit_io_iresp_bits_uop_is_amo)),	// core.scala:1223:{48,51,69,72}, execution-units.scala:119:32
    .io_wb_resps_3_bits_uop_rob_idx (_alu_exe_unit_io_iresp_bits_uop_rob_idx),	// execution-units.scala:119:32
    .io_wb_resps_3_bits_uop_pdst    (_alu_exe_unit_io_iresp_bits_uop_pdst),	// execution-units.scala:119:32
    .io_wb_resps_4_valid            (_fp_pipeline_io_wakeups_0_valid),	// core.scala:77:37
    .io_wb_resps_4_bits_uop_rob_idx (_fp_pipeline_io_wakeups_0_bits_uop_rob_idx),	// core.scala:77:37
    .io_wb_resps_4_bits_uop_pdst    (_fp_pipeline_io_wakeups_0_bits_uop_pdst),	// core.scala:77:37
    .io_wb_resps_4_bits_predicated  (_fp_pipeline_io_wakeups_0_bits_predicated),	// core.scala:77:37
    .io_wb_resps_5_valid            (_fp_pipeline_io_wakeups_1_valid),	// core.scala:77:37
    .io_wb_resps_5_bits_uop_rob_idx (_fp_pipeline_io_wakeups_1_bits_uop_rob_idx),	// core.scala:77:37
    .io_wb_resps_5_bits_uop_pdst    (_fp_pipeline_io_wakeups_1_bits_uop_pdst),	// core.scala:77:37
    .io_lsu_clr_bsy_0_valid         (io_lsu_clr_bsy_0_valid),
    .io_lsu_clr_bsy_0_bits          (io_lsu_clr_bsy_0_bits),
    .io_lsu_clr_bsy_1_valid         (io_lsu_clr_bsy_1_valid),
    .io_lsu_clr_bsy_1_bits          (io_lsu_clr_bsy_1_bits),
    .io_fflags_0_valid              (_fp_pipeline_io_wakeups_0_bits_fflags_valid),	// core.scala:77:37
    .io_fflags_0_bits_uop_rob_idx
      (_fp_pipeline_io_wakeups_0_bits_fflags_bits_uop_rob_idx),	// core.scala:77:37
    .io_fflags_0_bits_flags         (_fp_pipeline_io_wakeups_0_bits_fflags_bits_flags),	// core.scala:77:37
    .io_fflags_1_valid              (_fp_pipeline_io_wakeups_1_bits_fflags_valid),	// core.scala:77:37
    .io_fflags_1_bits_uop_rob_idx
      (_fp_pipeline_io_wakeups_1_bits_fflags_bits_uop_rob_idx),	// core.scala:77:37
    .io_fflags_1_bits_flags         (_fp_pipeline_io_wakeups_1_bits_fflags_bits_flags),	// core.scala:77:37
    .io_lxcpt_valid                 (io_lsu_lxcpt_valid),
    .io_lxcpt_bits_uop_br_mask      (io_lsu_lxcpt_bits_uop_br_mask),
    .io_lxcpt_bits_uop_rob_idx      (io_lsu_lxcpt_bits_uop_rob_idx),
    .io_lxcpt_bits_cause            (io_lsu_lxcpt_bits_cause),
    .io_lxcpt_bits_badvaddr         (io_lsu_lxcpt_bits_badvaddr),
    .io_csr_stall                   (_csr_io_csr_stall),	// core.scala:268:19
    .io_rob_tail_idx                (_rob_io_rob_tail_idx),
    .io_rob_head_idx                (_rob_io_rob_head_idx),
    .io_commit_valids_0             (_rob_io_commit_valids_0),
    .io_commit_valids_1             (_rob_io_commit_valids_1),
    .io_commit_valids_2             (_rob_io_commit_valids_2),
    .io_commit_arch_valids_0        (_rob_io_commit_arch_valids_0),
    .io_commit_arch_valids_1        (_rob_io_commit_arch_valids_1),
    .io_commit_arch_valids_2        (_rob_io_commit_arch_valids_2),
    .io_commit_uops_0_ftq_idx       (_rob_io_commit_uops_0_ftq_idx),
    .io_commit_uops_0_pdst          (_rob_io_commit_uops_0_pdst),
    .io_commit_uops_0_stale_pdst    (_rob_io_commit_uops_0_stale_pdst),
    .io_commit_uops_0_is_fencei     (_rob_io_commit_uops_0_is_fencei),
    .io_commit_uops_0_uses_ldq      (io_lsu_commit_uops_0_uses_ldq),
    .io_commit_uops_0_uses_stq      (io_lsu_commit_uops_0_uses_stq),
    .io_commit_uops_0_ldst          (_rob_io_commit_uops_0_ldst),
    .io_commit_uops_0_ldst_val      (_rob_io_commit_uops_0_ldst_val),
    .io_commit_uops_0_dst_rtype     (_rob_io_commit_uops_0_dst_rtype),
    .io_commit_uops_1_ftq_idx       (_rob_io_commit_uops_1_ftq_idx),
    .io_commit_uops_1_pdst          (_rob_io_commit_uops_1_pdst),
    .io_commit_uops_1_stale_pdst    (_rob_io_commit_uops_1_stale_pdst),
    .io_commit_uops_1_is_fencei     (_rob_io_commit_uops_1_is_fencei),
    .io_commit_uops_1_uses_ldq      (io_lsu_commit_uops_1_uses_ldq),
    .io_commit_uops_1_uses_stq      (io_lsu_commit_uops_1_uses_stq),
    .io_commit_uops_1_ldst          (_rob_io_commit_uops_1_ldst),
    .io_commit_uops_1_ldst_val      (_rob_io_commit_uops_1_ldst_val),
    .io_commit_uops_1_dst_rtype     (_rob_io_commit_uops_1_dst_rtype),
    .io_commit_uops_2_ftq_idx       (_rob_io_commit_uops_2_ftq_idx),
    .io_commit_uops_2_pdst          (_rob_io_commit_uops_2_pdst),
    .io_commit_uops_2_stale_pdst    (_rob_io_commit_uops_2_stale_pdst),
    .io_commit_uops_2_is_fencei     (_rob_io_commit_uops_2_is_fencei),
    .io_commit_uops_2_uses_ldq      (io_lsu_commit_uops_2_uses_ldq),
    .io_commit_uops_2_uses_stq      (io_lsu_commit_uops_2_uses_stq),
    .io_commit_uops_2_ldst          (_rob_io_commit_uops_2_ldst),
    .io_commit_uops_2_ldst_val      (_rob_io_commit_uops_2_ldst_val),
    .io_commit_uops_2_dst_rtype     (_rob_io_commit_uops_2_dst_rtype),
    .io_commit_fflags_valid         (_rob_io_commit_fflags_valid),
    .io_commit_fflags_bits          (_rob_io_commit_fflags_bits),
    .io_commit_rbk_valids_0         (_rob_io_commit_rbk_valids_0),
    .io_commit_rbk_valids_1         (_rob_io_commit_rbk_valids_1),
    .io_commit_rbk_valids_2         (_rob_io_commit_rbk_valids_2),
    .io_commit_rollback             (_rob_io_commit_rollback),
    .io_com_load_is_at_rob_head     (io_lsu_commit_load_at_rob_head),
    .io_com_xcpt_valid              (_rob_io_com_xcpt_valid),
    .io_com_xcpt_bits_ftq_idx       (_rob_io_com_xcpt_bits_ftq_idx),
    .io_com_xcpt_bits_edge_inst     (_rob_io_com_xcpt_bits_edge_inst),
    .io_com_xcpt_bits_pc_lob        (_rob_io_com_xcpt_bits_pc_lob),
    .io_com_xcpt_bits_cause         (_rob_io_com_xcpt_bits_cause),
    .io_com_xcpt_bits_badvaddr      (_rob_io_com_xcpt_bits_badvaddr),
    .io_flush_valid                 (_rob_io_flush_valid),
    .io_flush_bits_ftq_idx          (_rob_io_flush_bits_ftq_idx),
    .io_flush_bits_edge_inst        (_rob_io_flush_bits_edge_inst),
    .io_flush_bits_is_rvc           (_rob_io_flush_bits_is_rvc),
    .io_flush_bits_pc_lob           (_rob_io_flush_bits_pc_lob),
    .io_flush_bits_flush_typ        (_rob_io_flush_bits_flush_typ),
    .io_empty                       (_rob_io_empty),
    .io_ready                       (_rob_io_ready),
    .io_flush_frontend              (_rob_io_flush_frontend)
  );
  CSRFile_4 csr (	// core.scala:268:19
    .clock                      (clock),
    .reset                      (reset),
    .io_ungated_clock           (clock),
    .io_interrupts_debug        (io_interrupts_debug),
    .io_interrupts_mtip         (io_interrupts_mtip),
    .io_interrupts_msip         (io_interrupts_msip),
    .io_interrupts_meip         (io_interrupts_meip),
    .io_interrupts_seip         (io_interrupts_seip),
    .io_hartid                  (io_hartid),
    .io_rw_addr                 (_csr_exe_unit_io_iresp_bits_uop_csr_addr),	// execution-units.scala:119:32
    .io_rw_cmd
      (_csr_exe_unit_io_iresp_bits_uop_ctrl_csr_cmd
       & {_csr_exe_unit_io_iresp_valid, 2'h3}),	// CSR.scala:132:{9,11,15}, execution-units.scala:119:32
    .io_rw_wdata                (_csr_exe_unit_io_iresp_bits_data[63:0]),	// core.scala:1000:25, execution-units.scala:119:32
    .io_decode_0_csr            (_decode_units_0_io_csr_decode_csr),	// core.scala:98:79
    .io_decode_1_csr            (_decode_units_1_io_csr_decode_csr),	// core.scala:98:79
    .io_decode_2_csr            (_decode_units_2_io_csr_decode_csr),	// core.scala:98:79
    .io_exception               (csr_io_exception_REG),	// core.scala:1005:30
    .io_retire                  (csr_io_retire_REG),	// core.scala:1004:30
    .io_cause                   (csr_io_cause_REG),	// core.scala:1012:30
    .io_pc
      ({io_ifu_get_pc_0_com_pc[39:6], 6'h0} + {34'h0, csr_io_pc_REG}
       - {38'h0, csr_io_pc_REG_1, 1'h0}),	// core.scala:77:37, :98:79, :100:32, :101:46, :102:33, :105:32, :107:32, :111:32, :119:32, :129:32, :132:32, :140:32, :155:24, :171:24, :172:27, :268:19, :410:23, :412:36, :683:73, :1009:{22,31}, :1010:{22,35}, execution-units.scala:108:30, :119:32, util.scala:237:5
    .io_tval
      (csr_io_exception_REG
       & (csr_io_cause_REG == 64'h3 | csr_io_cause_REG == 64'h4
          | csr_io_cause_REG == 64'h6 | csr_io_cause_REG == 64'h5
          | csr_io_cause_REG == 64'h7 | csr_io_cause_REG == 64'h1
          | csr_io_cause_REG == 64'hD | csr_io_cause_REG == 64'hF
          | csr_io_cause_REG == 64'hC)
         ? csr_io_tval_REG
         : 40'h0),	// core.scala:536:26, :1005:30, :1012:30, :1015:37, :1028:21, :1029:12, package.scala:15:47, :72:59
    .io_fcsr_flags_valid        (_rob_io_commit_fflags_valid),	// core.scala:140:32
    .io_fcsr_flags_bits         (_rob_io_commit_fflags_bits),	// core.scala:140:32
    .io_set_fs_dirty            (_rob_io_commit_fflags_valid),	// core.scala:140:32
    .io_rw_rdata                (_csr_io_rw_rdata),
    .io_decode_0_fp_illegal     (_csr_io_decode_0_fp_illegal),
    .io_decode_0_read_illegal   (_csr_io_decode_0_read_illegal),
    .io_decode_0_write_illegal  (_csr_io_decode_0_write_illegal),
    .io_decode_0_write_flush    (_csr_io_decode_0_write_flush),
    .io_decode_0_system_illegal (_csr_io_decode_0_system_illegal),
    .io_decode_1_fp_illegal     (_csr_io_decode_1_fp_illegal),
    .io_decode_1_read_illegal   (_csr_io_decode_1_read_illegal),
    .io_decode_1_write_illegal  (_csr_io_decode_1_write_illegal),
    .io_decode_1_write_flush    (_csr_io_decode_1_write_flush),
    .io_decode_1_system_illegal (_csr_io_decode_1_system_illegal),
    .io_decode_2_fp_illegal     (_csr_io_decode_2_fp_illegal),
    .io_decode_2_read_illegal   (_csr_io_decode_2_read_illegal),
    .io_decode_2_write_illegal  (_csr_io_decode_2_write_illegal),
    .io_decode_2_write_flush    (_csr_io_decode_2_write_flush),
    .io_decode_2_system_illegal (_csr_io_decode_2_system_illegal),
    .io_csr_stall               (_csr_io_csr_stall),
    .io_singleStep              (_csr_io_singleStep),
    .io_status_debug            (_csr_io_status_debug),
    .io_status_isa              (_csr_io_status_isa),
    .io_status_dprv             (io_ptw_status_dprv),
    .io_status_prv              (io_ptw_status_prv),
    .io_status_mxr              (io_ptw_status_mxr),
    .io_status_sum              (io_ptw_status_sum),
    .io_ptbr_mode               (io_ptw_ptbr_mode),
    .io_ptbr_ppn                (io_ptw_ptbr_ppn),
    .io_evec                    (_csr_io_evec),
    .io_fcsr_rm                 (_csr_io_fcsr_rm),
    .io_interrupt               (_csr_io_interrupt),
    .io_interrupt_cause         (_csr_io_interrupt_cause),
    .io_pmp_0_cfg_l             (io_ptw_pmp_0_cfg_l),
    .io_pmp_0_cfg_a             (io_ptw_pmp_0_cfg_a),
    .io_pmp_0_cfg_x             (io_ptw_pmp_0_cfg_x),
    .io_pmp_0_cfg_w             (io_ptw_pmp_0_cfg_w),
    .io_pmp_0_cfg_r             (io_ptw_pmp_0_cfg_r),
    .io_pmp_0_addr              (io_ptw_pmp_0_addr),
    .io_pmp_0_mask              (io_ptw_pmp_0_mask),
    .io_pmp_1_cfg_l             (io_ptw_pmp_1_cfg_l),
    .io_pmp_1_cfg_a             (io_ptw_pmp_1_cfg_a),
    .io_pmp_1_cfg_x             (io_ptw_pmp_1_cfg_x),
    .io_pmp_1_cfg_w             (io_ptw_pmp_1_cfg_w),
    .io_pmp_1_cfg_r             (io_ptw_pmp_1_cfg_r),
    .io_pmp_1_addr              (io_ptw_pmp_1_addr),
    .io_pmp_1_mask              (io_ptw_pmp_1_mask),
    .io_pmp_2_cfg_l             (io_ptw_pmp_2_cfg_l),
    .io_pmp_2_cfg_a             (io_ptw_pmp_2_cfg_a),
    .io_pmp_2_cfg_x             (io_ptw_pmp_2_cfg_x),
    .io_pmp_2_cfg_w             (io_ptw_pmp_2_cfg_w),
    .io_pmp_2_cfg_r             (io_ptw_pmp_2_cfg_r),
    .io_pmp_2_addr              (io_ptw_pmp_2_addr),
    .io_pmp_2_mask              (io_ptw_pmp_2_mask),
    .io_pmp_3_cfg_l             (io_ptw_pmp_3_cfg_l),
    .io_pmp_3_cfg_a             (io_ptw_pmp_3_cfg_a),
    .io_pmp_3_cfg_x             (io_ptw_pmp_3_cfg_x),
    .io_pmp_3_cfg_w             (io_ptw_pmp_3_cfg_w),
    .io_pmp_3_cfg_r             (io_ptw_pmp_3_cfg_r),
    .io_pmp_3_addr              (io_ptw_pmp_3_addr),
    .io_pmp_3_mask              (io_ptw_pmp_3_mask),
    .io_pmp_4_cfg_l             (io_ptw_pmp_4_cfg_l),
    .io_pmp_4_cfg_a             (io_ptw_pmp_4_cfg_a),
    .io_pmp_4_cfg_x             (io_ptw_pmp_4_cfg_x),
    .io_pmp_4_cfg_w             (io_ptw_pmp_4_cfg_w),
    .io_pmp_4_cfg_r             (io_ptw_pmp_4_cfg_r),
    .io_pmp_4_addr              (io_ptw_pmp_4_addr),
    .io_pmp_4_mask              (io_ptw_pmp_4_mask),
    .io_pmp_5_cfg_l             (io_ptw_pmp_5_cfg_l),
    .io_pmp_5_cfg_a             (io_ptw_pmp_5_cfg_a),
    .io_pmp_5_cfg_x             (io_ptw_pmp_5_cfg_x),
    .io_pmp_5_cfg_w             (io_ptw_pmp_5_cfg_w),
    .io_pmp_5_cfg_r             (io_ptw_pmp_5_cfg_r),
    .io_pmp_5_addr              (io_ptw_pmp_5_addr),
    .io_pmp_5_mask              (io_ptw_pmp_5_mask),
    .io_pmp_6_cfg_l             (io_ptw_pmp_6_cfg_l),
    .io_pmp_6_cfg_a             (io_ptw_pmp_6_cfg_a),
    .io_pmp_6_cfg_x             (io_ptw_pmp_6_cfg_x),
    .io_pmp_6_cfg_w             (io_ptw_pmp_6_cfg_w),
    .io_pmp_6_cfg_r             (io_ptw_pmp_6_cfg_r),
    .io_pmp_6_addr              (io_ptw_pmp_6_addr),
    .io_pmp_6_mask              (io_ptw_pmp_6_mask),
    .io_pmp_7_cfg_l             (io_ptw_pmp_7_cfg_l),
    .io_pmp_7_cfg_a             (io_ptw_pmp_7_cfg_a),
    .io_pmp_7_cfg_x             (io_ptw_pmp_7_cfg_x),
    .io_pmp_7_cfg_w             (io_ptw_pmp_7_cfg_w),
    .io_pmp_7_cfg_r             (io_ptw_pmp_7_cfg_r),
    .io_pmp_7_addr              (io_ptw_pmp_7_addr),
    .io_pmp_7_mask              (io_ptw_pmp_7_mask),
    .io_customCSRs_0_value      (_csr_io_customCSRs_0_value)
  );
  Arbiter_43 ftq_arb (	// core.scala:520:23
    .io_in_0_valid (_rob_io_flush_valid),	// core.scala:140:32
    .io_in_0_bits  (_rob_io_flush_bits_ftq_idx),	// core.scala:140:32
    .io_in_1_valid (jmp_pc_req_valid_REG),	// core.scala:533:30
    .io_in_1_bits  (jmp_pc_req_bits_REG),	// core.scala:534:30
    .io_in_2_bits  (_GEN_17[dec_xcpts_0 ? 2'h0 : dec_xcpts_1 ? 2'h1 : 2'h2]),	// Mux.scala:47:69, core.scala:291:41, :426:52, :546:24, :560:71, :648:52
    .io_in_2_ready (_ftq_arb_io_in_2_ready),
    .io_out_bits   (io_ifu_get_pc_0_ftq_idx)
  );
  assign io_ifu_fetchpacket_ready = dec_ready;	// core.scala:576:58
  assign io_ifu_get_pc_1_ftq_idx =
    use_this_mispredict_2
      ? brinfos_2_uop_ftq_idx
      : use_this_mispredict_1 ? brinfos_1_uop_ftq_idx : brinfos_0_uop_ftq_idx;	// core.scala:179:20, :203:47, :207:28
  assign io_ifu_sfence_valid = io_ifu_sfence_REG_valid;	// core.scala:470:31
  assign io_ifu_sfence_bits_rs1 = io_ifu_sfence_REG_bits_rs1;	// core.scala:470:31
  assign io_ifu_sfence_bits_rs2 = io_ifu_sfence_REG_bits_rs2;	// core.scala:470:31
  assign io_ifu_sfence_bits_addr = io_ifu_sfence_REG_bits_addr;	// core.scala:470:31
  assign io_ifu_brupdate_b2_uop_ftq_idx = b2_uop_ftq_idx;	// core.scala:187:18
  assign io_ifu_brupdate_b2_uop_pc_lob = b2_uop_pc_lob;	// core.scala:187:18
  assign io_ifu_brupdate_b2_mispredict = b2_mispredict;	// core.scala:187:18
  assign io_ifu_brupdate_b2_taken = b2_taken;	// core.scala:187:18
  assign io_ifu_redirect_flush = _io_ifu_redirect_flush_output;	// core.scala:395:38, :397:27, :418:72, :429:29, :454:78
  assign io_ifu_redirect_val = REG | _GEN_4;	// core.scala:395:{16,38}, :396:27, :418:{39,72}
  assign io_ifu_redirect_pc =
    REG
      ? (flush_typ[0]
           ? (flush_typ == 3'h3 ? io_ifu_redirect_pc_REG_1 : _csr_io_evec)
           : flush_typ == 3'h2
               ? _flush_pc_T_6
               : _flush_pc_T_6 + {37'h0, flush_pc_next_REG ? 3'h2 : 3'h4})
      : b2_pc_sel == 2'h0
          ? _npc_T_2
          : b2_cfi_type == 3'h3
              ? b2_jalr_target
              : _GEN_5 + {{19{b2_target_offset[20]}}, b2_target_offset}
                + {{39{b2_uop_edge_inst}}, 1'h0};	// core.scala:77:37, :98:79, :100:32, :101:46, :102:33, :105:32, :107:32, :111:32, :119:32, :129:32, :132:32, :140:32, :155:24, :171:24, :172:27, :187:18, :268:19, :395:{16,38}, :398:28, :404:45, :405:{27,33,44}, :406:41, :411:23, :412:{36,41,49}, :413:{26,32}, :418:72, :421:28, :423:{43,71}, :425:{22,44}, :426:{32,52}, :683:73, execution-units.scala:108:30, :119:32, rob.scala:166:40, :167:40
  assign io_ifu_redirect_ftq_idx = REG ? io_ifu_redirect_ftq_idx_REG : b2_uop_ftq_idx;	// core.scala:187:18, :395:{16,38}, :417:{29,39}, :418:72
  assign io_ifu_redirect_ghist_old_history =
    REG
      ? 64'h0
      : use_same_ghist
          ? io_ifu_get_pc_1_ghist_old_history
          : next_ghist_ignore_second_bank
              ? (io_ifu_get_pc_1_ghist_new_saw_branch_taken
                   ? _GEN_13
                   : io_ifu_get_pc_1_ghist_new_saw_branch_not_taken
                       ? _GEN_12
                       : io_ifu_get_pc_1_ghist_old_history)
              : _next_ghist_T & next_ghist_cfi_in_bank_0
                  ? {io_ifu_get_pc_1_ghist_new_saw_branch_taken
                       ? _GEN_15
                       : io_ifu_get_pc_1_ghist_new_saw_branch_not_taken
                           ? _GEN_14
                           : io_ifu_get_pc_1_ghist_old_history[62:0],
                     1'h1}
                  : next_ghist_first_bank_saw_not_taken
                      ? {io_ifu_get_pc_1_ghist_new_saw_branch_taken
                           ? _GEN_15
                           : io_ifu_get_pc_1_ghist_new_saw_branch_not_taken
                               ? _GEN_14
                               : io_ifu_get_pc_1_ghist_old_history[62:0],
                         1'h0}
                      : io_ifu_get_pc_1_ghist_new_saw_branch_taken
                          ? _GEN_13
                          : io_ifu_get_pc_1_ghist_new_saw_branch_not_taken
                              ? _GEN_12
                              : io_ifu_get_pc_1_ghist_old_history;	// core.scala:77:37, :98:79, :100:32, :101:46, :102:33, :105:32, :107:32, :111:32, :119:32, :129:32, :132:32, :140:32, :155:24, :171:24, :172:27, :268:19, :395:{16,38}, :403:27, :418:72, :431:48, :432:46, :449:35, :520:23, :683:73, :1132:10, execution-units.scala:108:30, :119:32, frontend.scala:68:{12,75,80}, :69:12, :105:50, :106:46, :108:80, :110:33, :111:33, :115:{33,39,50,115}, :116:{39,110}
  assign io_ifu_redirect_ghist_current_saw_branch_not_taken = REG | use_same_ghist;	// core.scala:395:{16,38}, :403:27, :418:72, :432:46
  assign io_ifu_redirect_ghist_new_saw_branch_not_taken =
    ~REG
    & (use_same_ghist
         ? io_ifu_get_pc_1_ghist_new_saw_branch_not_taken
         : next_ghist_ignore_second_bank
             ? next_ghist_first_bank_saw_not_taken
             : (|(io_ifu_get_pc_1_entry_br_mask[7:4]
                  & {&cfi_idx, _GEN_6[6], _GEN_7[5], _GEN_8[4]}
                  & _next_ghist_not_taken_branches_T_17[7:4])));	// core.scala:221:10, :291:41, :395:{16,38}, :403:27, :412:41, :418:72, :432:46, :435:43, :449:35, frontend.scala:90:39, :91:{67,69}, :106:46, :108:80, :110:33, :112:46, :119:{46,67,92}, :161:39, util.scala:373:{29,45}
  assign io_ifu_redirect_ghist_new_saw_branch_taken =
    ~REG
    & (use_same_ghist
         ? io_ifu_get_pc_1_ghist_new_saw_branch_taken
         : next_ghist_ignore_second_bank
             ? _next_ghist_T & next_ghist_cfi_in_bank_0
             : b2_taken & _next_ghist_T & ~next_ghist_cfi_in_bank_0);	// core.scala:187:18, :395:{16,38}, :403:27, :418:72, :431:48, :432:46, :449:35, frontend.scala:105:50, :106:46, :110:33, :113:{46,59}, :120:{46,85,88}
  assign io_ifu_redirect_ghist_ras_idx =
    REG
      ? io_ifu_get_pc_0_entry_ras_idx
      : use_same_ghist
          ? io_ifu_get_pc_1_ghist_ras_idx
          : io_ifu_get_pc_1_entry_cfi_is_call & _next_ghist_T_3
              ? io_ifu_get_pc_1_ghist_ras_idx + 5'h1
              : io_ifu_get_pc_1_entry_cfi_is_ret & _next_ghist_T_3
                  ? io_ifu_get_pc_1_ghist_ras_idx - 5'h1
                  : io_ifu_get_pc_1_ghist_ras_idx;	// core.scala:395:{16,38}, :403:27, :418:72, :432:46, :445:{29,55}, :446:29, :449:35, frontend.scala:124:31, :125:31, util.scala:203:14, :220:14
  assign io_ifu_commit_valid =
    REG_3 | _io_ifu_commit_valid_T | _rob_io_commit_valids_2 | _rob_io_com_xcpt_valid;	// core.scala:140:32, :460:{23,55}, :732:{16,94}, :733:25
  assign io_ifu_commit_bits =
    {27'h0,
     REG_3
       ? io_ifu_commit_bits_REG
       : _rob_io_com_xcpt_valid
           ? _rob_io_com_xcpt_bits_ftq_idx
           : _GEN_16[2'h2
             - (_rob_io_commit_valids_2 ? 2'h0 : _rob_io_commit_valids_1 ? 2'h1 : 2'h2)]};	// Mux.scala:47:69, core.scala:140:32, :291:41, :426:52, :459:42, :461:{23,29}, :648:52, :732:{16,94}, :734:{25,35}
  assign io_ifu_flush_icache =
    _rob_io_commit_arch_valids_0 & _rob_io_commit_uops_0_is_fencei
    | io_ifu_flush_icache_REG | _rob_io_commit_arch_valids_1
    & _rob_io_commit_uops_1_is_fencei | io_ifu_flush_icache_REG_1
    | _rob_io_commit_arch_valids_2 & _rob_io_commit_uops_2_is_fencei
    | io_ifu_flush_icache_REG_2;	// core.scala:140:32, :382:35, :383:13, :384:13
  assign io_ptw_sfence_valid = io_ifu_sfence_REG_valid;	// core.scala:470:31
  assign io_ptw_sfence_bits_rs1 = io_ifu_sfence_REG_bits_rs1;	// core.scala:470:31
  assign io_ptw_sfence_bits_rs2 = io_ifu_sfence_REG_bits_rs2;	// core.scala:470:31
  assign io_ptw_sfence_bits_addr = io_ifu_sfence_REG_bits_addr;	// core.scala:470:31
  assign io_ptw_status_debug = _csr_io_status_debug;	// core.scala:268:19
  assign io_lsu_exe_0_req_bits_sfence_valid =
    _mem_units_0_io_lsu_io_req_bits_sfence_valid;	// execution-units.scala:108:30
  assign io_lsu_exe_0_req_bits_sfence_bits_rs1 =
    _mem_units_0_io_lsu_io_req_bits_sfence_bits_rs1;	// execution-units.scala:108:30
  assign io_lsu_exe_0_req_bits_sfence_bits_rs2 =
    _mem_units_0_io_lsu_io_req_bits_sfence_bits_rs2;	// execution-units.scala:108:30
  assign io_lsu_exe_0_req_bits_sfence_bits_addr =
    _mem_units_0_io_lsu_io_req_bits_sfence_bits_addr;	// execution-units.scala:108:30
  assign io_lsu_dis_uops_0_valid = dis_fire_0;	// core.scala:708:62
  assign io_lsu_dis_uops_0_bits_uopc = _rename_stage_io_ren2_uops_0_uopc;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_inst = _rename_stage_io_ren2_uops_0_inst;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_debug_inst = _rename_stage_io_ren2_uops_0_debug_inst;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_is_rvc = _rename_stage_io_ren2_uops_0_is_rvc;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_debug_pc = _rename_stage_io_ren2_uops_0_debug_pc;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_iq_type = _rename_stage_io_ren2_uops_0_iq_type;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_fu_code = _rename_stage_io_ren2_uops_0_fu_code;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_is_br = _rename_stage_io_ren2_uops_0_is_br;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_is_jalr = _rename_stage_io_ren2_uops_0_is_jalr;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_is_jal = _rename_stage_io_ren2_uops_0_is_jal;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_is_sfb = _rename_stage_io_ren2_uops_0_is_sfb;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_br_mask = _rename_stage_io_ren2_uops_0_br_mask;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_br_tag = _rename_stage_io_ren2_uops_0_br_tag;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_ftq_idx = _rename_stage_io_ren2_uops_0_ftq_idx;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_edge_inst = _rename_stage_io_ren2_uops_0_edge_inst;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_pc_lob = _rename_stage_io_ren2_uops_0_pc_lob;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_taken = _rename_stage_io_ren2_uops_0_taken;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_imm_packed = _rename_stage_io_ren2_uops_0_imm_packed;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_csr_addr = _rename_stage_io_ren2_uops_0_csr_addr;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_rob_idx = dis_uops_0_rob_idx;	// core.scala:743:27
  assign io_lsu_dis_uops_0_bits_ldq_idx = io_lsu_dis_ldq_idx_0;
  assign io_lsu_dis_uops_0_bits_stq_idx = io_lsu_dis_stq_idx_0;
  assign io_lsu_dis_uops_0_bits_rxq_idx = _rename_stage_io_ren2_uops_0_rxq_idx;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_pdst = dis_uops_0_pdst;	// core.scala:653:28
  assign io_lsu_dis_uops_0_bits_prs1 = dis_uops_0_prs1;	// core.scala:648:28
  assign io_lsu_dis_uops_0_bits_prs2 = dis_uops_0_prs2;	// core.scala:650:28
  assign io_lsu_dis_uops_0_bits_prs3 = _fp_rename_stage_io_ren2_uops_0_prs3;	// core.scala:101:46
  assign io_lsu_dis_uops_0_bits_prs1_busy = dis_uops_0_prs1_busy;	// core.scala:658:85
  assign io_lsu_dis_uops_0_bits_prs2_busy = dis_uops_0_prs2_busy;	// core.scala:660:85
  assign io_lsu_dis_uops_0_bits_prs3_busy = dis_uops_0_prs3_busy;	// core.scala:662:46
  assign io_lsu_dis_uops_0_bits_stale_pdst = dis_uops_0_stale_pdst;	// core.scala:656:34
  assign io_lsu_dis_uops_0_bits_exception = _rename_stage_io_ren2_uops_0_exception;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_exc_cause = _rename_stage_io_ren2_uops_0_exc_cause;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_bypassable = _rename_stage_io_ren2_uops_0_bypassable;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_mem_cmd = _rename_stage_io_ren2_uops_0_mem_cmd;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_mem_size = _rename_stage_io_ren2_uops_0_mem_size;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_mem_signed = _rename_stage_io_ren2_uops_0_mem_signed;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_is_fence = _rename_stage_io_ren2_uops_0_is_fence;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_is_fencei = _rename_stage_io_ren2_uops_0_is_fencei;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_is_amo = _rename_stage_io_ren2_uops_0_is_amo;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_uses_ldq = _rename_stage_io_ren2_uops_0_uses_ldq;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_uses_stq = _rename_stage_io_ren2_uops_0_uses_stq;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_is_sys_pc2epc =
    _rename_stage_io_ren2_uops_0_is_sys_pc2epc;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_is_unique = _rename_stage_io_ren2_uops_0_is_unique;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_flush_on_commit =
    _rename_stage_io_ren2_uops_0_flush_on_commit;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_ldst_is_rs1 = _rename_stage_io_ren2_uops_0_ldst_is_rs1;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_ldst = _rename_stage_io_ren2_uops_0_ldst;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_lrs1 = _rename_stage_io_ren2_uops_0_lrs1;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_lrs2 = _rename_stage_io_ren2_uops_0_lrs2;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_lrs3 = _rename_stage_io_ren2_uops_0_lrs3;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_ldst_val = _rename_stage_io_ren2_uops_0_ldst_val;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_dst_rtype = _rename_stage_io_ren2_uops_0_dst_rtype;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_lrs1_rtype = _rename_stage_io_ren2_uops_0_lrs1_rtype;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_lrs2_rtype = _rename_stage_io_ren2_uops_0_lrs2_rtype;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_frs3_en = _rename_stage_io_ren2_uops_0_frs3_en;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_fp_val = _rename_stage_io_ren2_uops_0_fp_val;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_fp_single = _rename_stage_io_ren2_uops_0_fp_single;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_xcpt_pf_if = _rename_stage_io_ren2_uops_0_xcpt_pf_if;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_xcpt_ae_if = _rename_stage_io_ren2_uops_0_xcpt_ae_if;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_xcpt_ma_if = _rename_stage_io_ren2_uops_0_xcpt_ma_if;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_bp_debug_if = _rename_stage_io_ren2_uops_0_bp_debug_if;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_bp_xcpt_if = _rename_stage_io_ren2_uops_0_bp_xcpt_if;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_debug_fsrc = _rename_stage_io_ren2_uops_0_debug_fsrc;	// core.scala:100:32
  assign io_lsu_dis_uops_0_bits_debug_tsrc = _rename_stage_io_ren2_uops_0_debug_tsrc;	// core.scala:100:32
  assign io_lsu_dis_uops_1_valid = dis_fire_1;	// core.scala:708:62
  assign io_lsu_dis_uops_1_bits_uopc = _rename_stage_io_ren2_uops_1_uopc;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_inst = _rename_stage_io_ren2_uops_1_inst;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_debug_inst = _rename_stage_io_ren2_uops_1_debug_inst;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_is_rvc = _rename_stage_io_ren2_uops_1_is_rvc;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_debug_pc = _rename_stage_io_ren2_uops_1_debug_pc;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_iq_type = _rename_stage_io_ren2_uops_1_iq_type;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_fu_code = _rename_stage_io_ren2_uops_1_fu_code;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_is_br = _rename_stage_io_ren2_uops_1_is_br;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_is_jalr = _rename_stage_io_ren2_uops_1_is_jalr;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_is_jal = _rename_stage_io_ren2_uops_1_is_jal;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_is_sfb = _rename_stage_io_ren2_uops_1_is_sfb;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_br_mask = _rename_stage_io_ren2_uops_1_br_mask;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_br_tag = _rename_stage_io_ren2_uops_1_br_tag;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_ftq_idx = _rename_stage_io_ren2_uops_1_ftq_idx;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_edge_inst = _rename_stage_io_ren2_uops_1_edge_inst;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_pc_lob = _rename_stage_io_ren2_uops_1_pc_lob;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_taken = _rename_stage_io_ren2_uops_1_taken;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_imm_packed = _rename_stage_io_ren2_uops_1_imm_packed;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_csr_addr = _rename_stage_io_ren2_uops_1_csr_addr;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_rob_idx = dis_uops_1_rob_idx;	// core.scala:743:27
  assign io_lsu_dis_uops_1_bits_ldq_idx = io_lsu_dis_ldq_idx_1;
  assign io_lsu_dis_uops_1_bits_stq_idx = io_lsu_dis_stq_idx_1;
  assign io_lsu_dis_uops_1_bits_rxq_idx = _rename_stage_io_ren2_uops_1_rxq_idx;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_pdst = dis_uops_1_pdst;	// core.scala:653:28
  assign io_lsu_dis_uops_1_bits_prs1 = dis_uops_1_prs1;	// core.scala:648:28
  assign io_lsu_dis_uops_1_bits_prs2 = dis_uops_1_prs2;	// core.scala:650:28
  assign io_lsu_dis_uops_1_bits_prs3 = _fp_rename_stage_io_ren2_uops_1_prs3;	// core.scala:101:46
  assign io_lsu_dis_uops_1_bits_prs1_busy = dis_uops_1_prs1_busy;	// core.scala:658:85
  assign io_lsu_dis_uops_1_bits_prs2_busy = dis_uops_1_prs2_busy;	// core.scala:660:85
  assign io_lsu_dis_uops_1_bits_prs3_busy = dis_uops_1_prs3_busy;	// core.scala:662:46
  assign io_lsu_dis_uops_1_bits_stale_pdst = dis_uops_1_stale_pdst;	// core.scala:656:34
  assign io_lsu_dis_uops_1_bits_exception = _rename_stage_io_ren2_uops_1_exception;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_exc_cause = _rename_stage_io_ren2_uops_1_exc_cause;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_bypassable = _rename_stage_io_ren2_uops_1_bypassable;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_mem_cmd = _rename_stage_io_ren2_uops_1_mem_cmd;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_mem_size = _rename_stage_io_ren2_uops_1_mem_size;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_mem_signed = _rename_stage_io_ren2_uops_1_mem_signed;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_is_fence = _rename_stage_io_ren2_uops_1_is_fence;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_is_fencei = _rename_stage_io_ren2_uops_1_is_fencei;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_is_amo = _rename_stage_io_ren2_uops_1_is_amo;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_uses_ldq = _rename_stage_io_ren2_uops_1_uses_ldq;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_uses_stq = _rename_stage_io_ren2_uops_1_uses_stq;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_is_sys_pc2epc =
    _rename_stage_io_ren2_uops_1_is_sys_pc2epc;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_is_unique = _rename_stage_io_ren2_uops_1_is_unique;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_flush_on_commit =
    _rename_stage_io_ren2_uops_1_flush_on_commit;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_ldst_is_rs1 = _rename_stage_io_ren2_uops_1_ldst_is_rs1;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_ldst = _rename_stage_io_ren2_uops_1_ldst;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_lrs1 = _rename_stage_io_ren2_uops_1_lrs1;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_lrs2 = _rename_stage_io_ren2_uops_1_lrs2;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_lrs3 = _rename_stage_io_ren2_uops_1_lrs3;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_ldst_val = _rename_stage_io_ren2_uops_1_ldst_val;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_dst_rtype = _rename_stage_io_ren2_uops_1_dst_rtype;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_lrs1_rtype = _rename_stage_io_ren2_uops_1_lrs1_rtype;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_lrs2_rtype = _rename_stage_io_ren2_uops_1_lrs2_rtype;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_frs3_en = _rename_stage_io_ren2_uops_1_frs3_en;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_fp_val = _rename_stage_io_ren2_uops_1_fp_val;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_fp_single = _rename_stage_io_ren2_uops_1_fp_single;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_xcpt_pf_if = _rename_stage_io_ren2_uops_1_xcpt_pf_if;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_xcpt_ae_if = _rename_stage_io_ren2_uops_1_xcpt_ae_if;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_xcpt_ma_if = _rename_stage_io_ren2_uops_1_xcpt_ma_if;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_bp_debug_if = _rename_stage_io_ren2_uops_1_bp_debug_if;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_bp_xcpt_if = _rename_stage_io_ren2_uops_1_bp_xcpt_if;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_debug_fsrc = _rename_stage_io_ren2_uops_1_debug_fsrc;	// core.scala:100:32
  assign io_lsu_dis_uops_1_bits_debug_tsrc = _rename_stage_io_ren2_uops_1_debug_tsrc;	// core.scala:100:32
  assign io_lsu_dis_uops_2_valid = dis_fire_2;	// core.scala:708:62
  assign io_lsu_dis_uops_2_bits_uopc = _rename_stage_io_ren2_uops_2_uopc;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_inst = _rename_stage_io_ren2_uops_2_inst;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_debug_inst = _rename_stage_io_ren2_uops_2_debug_inst;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_is_rvc = _rename_stage_io_ren2_uops_2_is_rvc;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_debug_pc = _rename_stage_io_ren2_uops_2_debug_pc;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_iq_type = _rename_stage_io_ren2_uops_2_iq_type;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_fu_code = _rename_stage_io_ren2_uops_2_fu_code;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_is_br = _rename_stage_io_ren2_uops_2_is_br;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_is_jalr = _rename_stage_io_ren2_uops_2_is_jalr;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_is_jal = _rename_stage_io_ren2_uops_2_is_jal;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_is_sfb = _rename_stage_io_ren2_uops_2_is_sfb;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_br_mask = _rename_stage_io_ren2_uops_2_br_mask;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_br_tag = _rename_stage_io_ren2_uops_2_br_tag;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_ftq_idx = _rename_stage_io_ren2_uops_2_ftq_idx;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_edge_inst = _rename_stage_io_ren2_uops_2_edge_inst;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_pc_lob = _rename_stage_io_ren2_uops_2_pc_lob;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_taken = _rename_stage_io_ren2_uops_2_taken;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_imm_packed = _rename_stage_io_ren2_uops_2_imm_packed;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_csr_addr = _rename_stage_io_ren2_uops_2_csr_addr;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_rob_idx = dis_uops_2_rob_idx;	// core.scala:743:27
  assign io_lsu_dis_uops_2_bits_ldq_idx = io_lsu_dis_ldq_idx_2;
  assign io_lsu_dis_uops_2_bits_stq_idx = io_lsu_dis_stq_idx_2;
  assign io_lsu_dis_uops_2_bits_rxq_idx = _rename_stage_io_ren2_uops_2_rxq_idx;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_pdst = dis_uops_2_pdst;	// core.scala:653:28
  assign io_lsu_dis_uops_2_bits_prs1 = dis_uops_2_prs1;	// core.scala:648:28
  assign io_lsu_dis_uops_2_bits_prs2 = dis_uops_2_prs2;	// core.scala:650:28
  assign io_lsu_dis_uops_2_bits_prs3 = _fp_rename_stage_io_ren2_uops_2_prs3;	// core.scala:101:46
  assign io_lsu_dis_uops_2_bits_prs1_busy = dis_uops_2_prs1_busy;	// core.scala:658:85
  assign io_lsu_dis_uops_2_bits_prs2_busy = dis_uops_2_prs2_busy;	// core.scala:660:85
  assign io_lsu_dis_uops_2_bits_prs3_busy = dis_uops_2_prs3_busy;	// core.scala:662:46
  assign io_lsu_dis_uops_2_bits_stale_pdst = dis_uops_2_stale_pdst;	// core.scala:656:34
  assign io_lsu_dis_uops_2_bits_exception = _rename_stage_io_ren2_uops_2_exception;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_exc_cause = _rename_stage_io_ren2_uops_2_exc_cause;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_bypassable = _rename_stage_io_ren2_uops_2_bypassable;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_mem_cmd = _rename_stage_io_ren2_uops_2_mem_cmd;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_mem_size = _rename_stage_io_ren2_uops_2_mem_size;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_mem_signed = _rename_stage_io_ren2_uops_2_mem_signed;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_is_fence = _rename_stage_io_ren2_uops_2_is_fence;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_is_fencei = _rename_stage_io_ren2_uops_2_is_fencei;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_is_amo = _rename_stage_io_ren2_uops_2_is_amo;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_uses_ldq = _rename_stage_io_ren2_uops_2_uses_ldq;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_uses_stq = _rename_stage_io_ren2_uops_2_uses_stq;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_is_sys_pc2epc =
    _rename_stage_io_ren2_uops_2_is_sys_pc2epc;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_is_unique = _rename_stage_io_ren2_uops_2_is_unique;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_flush_on_commit =
    _rename_stage_io_ren2_uops_2_flush_on_commit;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_ldst_is_rs1 = _rename_stage_io_ren2_uops_2_ldst_is_rs1;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_ldst = _rename_stage_io_ren2_uops_2_ldst;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_lrs1 = _rename_stage_io_ren2_uops_2_lrs1;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_lrs2 = _rename_stage_io_ren2_uops_2_lrs2;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_lrs3 = _rename_stage_io_ren2_uops_2_lrs3;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_ldst_val = _rename_stage_io_ren2_uops_2_ldst_val;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_dst_rtype = _rename_stage_io_ren2_uops_2_dst_rtype;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_lrs1_rtype = _rename_stage_io_ren2_uops_2_lrs1_rtype;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_lrs2_rtype = _rename_stage_io_ren2_uops_2_lrs2_rtype;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_frs3_en = _rename_stage_io_ren2_uops_2_frs3_en;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_fp_val = _rename_stage_io_ren2_uops_2_fp_val;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_fp_single = _rename_stage_io_ren2_uops_2_fp_single;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_xcpt_pf_if = _rename_stage_io_ren2_uops_2_xcpt_pf_if;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_xcpt_ae_if = _rename_stage_io_ren2_uops_2_xcpt_ae_if;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_xcpt_ma_if = _rename_stage_io_ren2_uops_2_xcpt_ma_if;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_bp_debug_if = _rename_stage_io_ren2_uops_2_bp_debug_if;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_bp_xcpt_if = _rename_stage_io_ren2_uops_2_bp_xcpt_if;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_debug_fsrc = _rename_stage_io_ren2_uops_2_debug_fsrc;	// core.scala:100:32
  assign io_lsu_dis_uops_2_bits_debug_tsrc = _rename_stage_io_ren2_uops_2_debug_tsrc;	// core.scala:100:32
  assign io_lsu_commit_valids_0 = _rob_io_commit_valids_0;	// core.scala:140:32
  assign io_lsu_commit_valids_1 = _rob_io_commit_valids_1;	// core.scala:140:32
  assign io_lsu_commit_valids_2 = _rob_io_commit_valids_2;	// core.scala:140:32
  assign io_lsu_fence_dmem =
    _rename_stage_io_ren2_mask_0 & wait_for_empty_pipeline_0
    | _rename_stage_io_ren2_mask_1 & wait_for_empty_pipeline_1
    | _rename_stage_io_ren2_mask_2 & wait_for_empty_pipeline_2;	// core.scala:100:32, :679:112, :705:{86,101}
  assign io_lsu_brupdate_b1_resolve_mask = b1_resolve_mask;	// core.scala:196:72
  assign io_lsu_brupdate_b1_mispredict_mask = b1_mispredict_mask;	// core.scala:197:93
  assign io_lsu_brupdate_b2_uop_ldq_idx = b2_uop_ldq_idx;	// core.scala:187:18
  assign io_lsu_brupdate_b2_uop_stq_idx = b2_uop_stq_idx;	// core.scala:187:18
  assign io_lsu_brupdate_b2_mispredict = b2_mispredict;	// core.scala:187:18
  assign io_lsu_rob_head_idx = _rob_io_rob_head_idx;	// core.scala:140:32
  assign io_lsu_exception = io_lsu_exception_REG;	// core.scala:1109:30
endmodule

