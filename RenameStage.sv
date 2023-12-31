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

module RenameStage(
  input         clock,
                reset,
                io_kill,
                io_dec_fire_0,
                io_dec_fire_1,
                io_dec_fire_2,
                io_dec_fire_3,
  input  [6:0]  io_dec_uops_0_uopc,
  input  [31:0] io_dec_uops_0_inst,
                io_dec_uops_0_debug_inst,
  input         io_dec_uops_0_is_rvc,
  input  [39:0] io_dec_uops_0_debug_pc,
  input  [2:0]  io_dec_uops_0_iq_type,
  input  [9:0]  io_dec_uops_0_fu_code,
  input  [3:0]  io_dec_uops_0_ctrl_br_type,
  input  [1:0]  io_dec_uops_0_ctrl_op1_sel,
  input  [2:0]  io_dec_uops_0_ctrl_op2_sel,
                io_dec_uops_0_ctrl_imm_sel,
  input  [3:0]  io_dec_uops_0_ctrl_op_fcn,
  input         io_dec_uops_0_ctrl_fcn_dw,
  input  [2:0]  io_dec_uops_0_ctrl_csr_cmd,
  input         io_dec_uops_0_ctrl_is_load,
                io_dec_uops_0_ctrl_is_sta,
                io_dec_uops_0_ctrl_is_std,
  input  [1:0]  io_dec_uops_0_iw_state,
  input         io_dec_uops_0_iw_p1_poisoned,
                io_dec_uops_0_iw_p2_poisoned,
                io_dec_uops_0_is_br,
                io_dec_uops_0_is_jalr,
                io_dec_uops_0_is_jal,
                io_dec_uops_0_is_sfb,
  input  [19:0] io_dec_uops_0_br_mask,
  input  [4:0]  io_dec_uops_0_br_tag,
  input  [5:0]  io_dec_uops_0_ftq_idx,
  input         io_dec_uops_0_edge_inst,
  input  [5:0]  io_dec_uops_0_pc_lob,
  input         io_dec_uops_0_taken,
  input  [19:0] io_dec_uops_0_imm_packed,
  input  [11:0] io_dec_uops_0_csr_addr,
  input  [1:0]  io_dec_uops_0_rxq_idx,
  input         io_dec_uops_0_exception,
  input  [63:0] io_dec_uops_0_exc_cause,
  input         io_dec_uops_0_bypassable,
  input  [4:0]  io_dec_uops_0_mem_cmd,
  input  [1:0]  io_dec_uops_0_mem_size,
  input         io_dec_uops_0_mem_signed,
                io_dec_uops_0_is_fence,
                io_dec_uops_0_is_fencei,
                io_dec_uops_0_is_amo,
                io_dec_uops_0_uses_ldq,
                io_dec_uops_0_uses_stq,
                io_dec_uops_0_is_sys_pc2epc,
                io_dec_uops_0_is_unique,
                io_dec_uops_0_flush_on_commit,
  input  [5:0]  io_dec_uops_0_ldst,
                io_dec_uops_0_lrs1,
                io_dec_uops_0_lrs2,
                io_dec_uops_0_lrs3,
  input         io_dec_uops_0_ldst_val,
  input  [1:0]  io_dec_uops_0_dst_rtype,
                io_dec_uops_0_lrs1_rtype,
                io_dec_uops_0_lrs2_rtype,
  input         io_dec_uops_0_frs3_en,
                io_dec_uops_0_fp_val,
                io_dec_uops_0_fp_single,
                io_dec_uops_0_xcpt_pf_if,
                io_dec_uops_0_xcpt_ae_if,
                io_dec_uops_0_xcpt_ma_if,
                io_dec_uops_0_bp_debug_if,
                io_dec_uops_0_bp_xcpt_if,
  input  [1:0]  io_dec_uops_0_debug_fsrc,
                io_dec_uops_0_debug_tsrc,
  input  [6:0]  io_dec_uops_1_uopc,
  input  [31:0] io_dec_uops_1_inst,
                io_dec_uops_1_debug_inst,
  input         io_dec_uops_1_is_rvc,
  input  [39:0] io_dec_uops_1_debug_pc,
  input  [2:0]  io_dec_uops_1_iq_type,
  input  [9:0]  io_dec_uops_1_fu_code,
  input  [3:0]  io_dec_uops_1_ctrl_br_type,
  input  [1:0]  io_dec_uops_1_ctrl_op1_sel,
  input  [2:0]  io_dec_uops_1_ctrl_op2_sel,
                io_dec_uops_1_ctrl_imm_sel,
  input  [3:0]  io_dec_uops_1_ctrl_op_fcn,
  input         io_dec_uops_1_ctrl_fcn_dw,
  input  [2:0]  io_dec_uops_1_ctrl_csr_cmd,
  input         io_dec_uops_1_ctrl_is_load,
                io_dec_uops_1_ctrl_is_sta,
                io_dec_uops_1_ctrl_is_std,
  input  [1:0]  io_dec_uops_1_iw_state,
  input         io_dec_uops_1_iw_p1_poisoned,
                io_dec_uops_1_iw_p2_poisoned,
                io_dec_uops_1_is_br,
                io_dec_uops_1_is_jalr,
                io_dec_uops_1_is_jal,
                io_dec_uops_1_is_sfb,
  input  [19:0] io_dec_uops_1_br_mask,
  input  [4:0]  io_dec_uops_1_br_tag,
  input  [5:0]  io_dec_uops_1_ftq_idx,
  input         io_dec_uops_1_edge_inst,
  input  [5:0]  io_dec_uops_1_pc_lob,
  input         io_dec_uops_1_taken,
  input  [19:0] io_dec_uops_1_imm_packed,
  input  [11:0] io_dec_uops_1_csr_addr,
  input  [1:0]  io_dec_uops_1_rxq_idx,
  input         io_dec_uops_1_exception,
  input  [63:0] io_dec_uops_1_exc_cause,
  input         io_dec_uops_1_bypassable,
  input  [4:0]  io_dec_uops_1_mem_cmd,
  input  [1:0]  io_dec_uops_1_mem_size,
  input         io_dec_uops_1_mem_signed,
                io_dec_uops_1_is_fence,
                io_dec_uops_1_is_fencei,
                io_dec_uops_1_is_amo,
                io_dec_uops_1_uses_ldq,
                io_dec_uops_1_uses_stq,
                io_dec_uops_1_is_sys_pc2epc,
                io_dec_uops_1_is_unique,
                io_dec_uops_1_flush_on_commit,
  input  [5:0]  io_dec_uops_1_ldst,
                io_dec_uops_1_lrs1,
                io_dec_uops_1_lrs2,
                io_dec_uops_1_lrs3,
  input         io_dec_uops_1_ldst_val,
  input  [1:0]  io_dec_uops_1_dst_rtype,
                io_dec_uops_1_lrs1_rtype,
                io_dec_uops_1_lrs2_rtype,
  input         io_dec_uops_1_frs3_en,
                io_dec_uops_1_fp_val,
                io_dec_uops_1_fp_single,
                io_dec_uops_1_xcpt_pf_if,
                io_dec_uops_1_xcpt_ae_if,
                io_dec_uops_1_xcpt_ma_if,
                io_dec_uops_1_bp_debug_if,
                io_dec_uops_1_bp_xcpt_if,
  input  [1:0]  io_dec_uops_1_debug_fsrc,
                io_dec_uops_1_debug_tsrc,
  input  [6:0]  io_dec_uops_2_uopc,
  input  [31:0] io_dec_uops_2_inst,
                io_dec_uops_2_debug_inst,
  input         io_dec_uops_2_is_rvc,
  input  [39:0] io_dec_uops_2_debug_pc,
  input  [2:0]  io_dec_uops_2_iq_type,
  input  [9:0]  io_dec_uops_2_fu_code,
  input  [3:0]  io_dec_uops_2_ctrl_br_type,
  input  [1:0]  io_dec_uops_2_ctrl_op1_sel,
  input  [2:0]  io_dec_uops_2_ctrl_op2_sel,
                io_dec_uops_2_ctrl_imm_sel,
  input  [3:0]  io_dec_uops_2_ctrl_op_fcn,
  input         io_dec_uops_2_ctrl_fcn_dw,
  input  [2:0]  io_dec_uops_2_ctrl_csr_cmd,
  input         io_dec_uops_2_ctrl_is_load,
                io_dec_uops_2_ctrl_is_sta,
                io_dec_uops_2_ctrl_is_std,
  input  [1:0]  io_dec_uops_2_iw_state,
  input         io_dec_uops_2_iw_p1_poisoned,
                io_dec_uops_2_iw_p2_poisoned,
                io_dec_uops_2_is_br,
                io_dec_uops_2_is_jalr,
                io_dec_uops_2_is_jal,
                io_dec_uops_2_is_sfb,
  input  [19:0] io_dec_uops_2_br_mask,
  input  [4:0]  io_dec_uops_2_br_tag,
  input  [5:0]  io_dec_uops_2_ftq_idx,
  input         io_dec_uops_2_edge_inst,
  input  [5:0]  io_dec_uops_2_pc_lob,
  input         io_dec_uops_2_taken,
  input  [19:0] io_dec_uops_2_imm_packed,
  input  [11:0] io_dec_uops_2_csr_addr,
  input  [1:0]  io_dec_uops_2_rxq_idx,
  input         io_dec_uops_2_exception,
  input  [63:0] io_dec_uops_2_exc_cause,
  input         io_dec_uops_2_bypassable,
  input  [4:0]  io_dec_uops_2_mem_cmd,
  input  [1:0]  io_dec_uops_2_mem_size,
  input         io_dec_uops_2_mem_signed,
                io_dec_uops_2_is_fence,
                io_dec_uops_2_is_fencei,
                io_dec_uops_2_is_amo,
                io_dec_uops_2_uses_ldq,
                io_dec_uops_2_uses_stq,
                io_dec_uops_2_is_sys_pc2epc,
                io_dec_uops_2_is_unique,
                io_dec_uops_2_flush_on_commit,
  input  [5:0]  io_dec_uops_2_ldst,
                io_dec_uops_2_lrs1,
                io_dec_uops_2_lrs2,
                io_dec_uops_2_lrs3,
  input         io_dec_uops_2_ldst_val,
  input  [1:0]  io_dec_uops_2_dst_rtype,
                io_dec_uops_2_lrs1_rtype,
                io_dec_uops_2_lrs2_rtype,
  input         io_dec_uops_2_frs3_en,
                io_dec_uops_2_fp_val,
                io_dec_uops_2_fp_single,
                io_dec_uops_2_xcpt_pf_if,
                io_dec_uops_2_xcpt_ae_if,
                io_dec_uops_2_xcpt_ma_if,
                io_dec_uops_2_bp_debug_if,
                io_dec_uops_2_bp_xcpt_if,
  input  [1:0]  io_dec_uops_2_debug_fsrc,
                io_dec_uops_2_debug_tsrc,
  input  [6:0]  io_dec_uops_3_uopc,
  input  [31:0] io_dec_uops_3_inst,
                io_dec_uops_3_debug_inst,
  input         io_dec_uops_3_is_rvc,
  input  [39:0] io_dec_uops_3_debug_pc,
  input  [2:0]  io_dec_uops_3_iq_type,
  input  [9:0]  io_dec_uops_3_fu_code,
  input  [3:0]  io_dec_uops_3_ctrl_br_type,
  input  [1:0]  io_dec_uops_3_ctrl_op1_sel,
  input  [2:0]  io_dec_uops_3_ctrl_op2_sel,
                io_dec_uops_3_ctrl_imm_sel,
  input  [3:0]  io_dec_uops_3_ctrl_op_fcn,
  input         io_dec_uops_3_ctrl_fcn_dw,
  input  [2:0]  io_dec_uops_3_ctrl_csr_cmd,
  input         io_dec_uops_3_ctrl_is_load,
                io_dec_uops_3_ctrl_is_sta,
                io_dec_uops_3_ctrl_is_std,
  input  [1:0]  io_dec_uops_3_iw_state,
  input         io_dec_uops_3_iw_p1_poisoned,
                io_dec_uops_3_iw_p2_poisoned,
                io_dec_uops_3_is_br,
                io_dec_uops_3_is_jalr,
                io_dec_uops_3_is_jal,
                io_dec_uops_3_is_sfb,
  input  [19:0] io_dec_uops_3_br_mask,
  input  [4:0]  io_dec_uops_3_br_tag,
  input  [5:0]  io_dec_uops_3_ftq_idx,
  input         io_dec_uops_3_edge_inst,
  input  [5:0]  io_dec_uops_3_pc_lob,
  input         io_dec_uops_3_taken,
  input  [19:0] io_dec_uops_3_imm_packed,
  input  [11:0] io_dec_uops_3_csr_addr,
  input  [1:0]  io_dec_uops_3_rxq_idx,
  input         io_dec_uops_3_exception,
  input  [63:0] io_dec_uops_3_exc_cause,
  input         io_dec_uops_3_bypassable,
  input  [4:0]  io_dec_uops_3_mem_cmd,
  input  [1:0]  io_dec_uops_3_mem_size,
  input         io_dec_uops_3_mem_signed,
                io_dec_uops_3_is_fence,
                io_dec_uops_3_is_fencei,
                io_dec_uops_3_is_amo,
                io_dec_uops_3_uses_ldq,
                io_dec_uops_3_uses_stq,
                io_dec_uops_3_is_sys_pc2epc,
                io_dec_uops_3_is_unique,
                io_dec_uops_3_flush_on_commit,
  input  [5:0]  io_dec_uops_3_ldst,
                io_dec_uops_3_lrs1,
                io_dec_uops_3_lrs2,
                io_dec_uops_3_lrs3,
  input         io_dec_uops_3_ldst_val,
  input  [1:0]  io_dec_uops_3_dst_rtype,
                io_dec_uops_3_lrs1_rtype,
                io_dec_uops_3_lrs2_rtype,
  input         io_dec_uops_3_frs3_en,
                io_dec_uops_3_fp_val,
                io_dec_uops_3_fp_single,
                io_dec_uops_3_xcpt_pf_if,
                io_dec_uops_3_xcpt_ae_if,
                io_dec_uops_3_xcpt_ma_if,
                io_dec_uops_3_bp_debug_if,
                io_dec_uops_3_bp_xcpt_if,
  input  [1:0]  io_dec_uops_3_debug_fsrc,
                io_dec_uops_3_debug_tsrc,
  input  [19:0] io_brupdate_b1_resolve_mask,
  input  [4:0]  io_brupdate_b2_uop_br_tag,
  input         io_brupdate_b2_mispredict,
                io_dis_fire_0,
                io_dis_fire_1,
                io_dis_fire_2,
                io_dis_fire_3,
                io_dis_ready,
                io_wakeups_0_valid,
  input  [6:0]  io_wakeups_0_bits_uop_pdst,
  input  [1:0]  io_wakeups_0_bits_uop_dst_rtype,
  input         io_wakeups_1_valid,
  input  [6:0]  io_wakeups_1_bits_uop_pdst,
  input  [1:0]  io_wakeups_1_bits_uop_dst_rtype,
  input         io_wakeups_2_valid,
  input  [6:0]  io_wakeups_2_bits_uop_pdst,
  input  [1:0]  io_wakeups_2_bits_uop_dst_rtype,
  input         io_wakeups_3_valid,
  input  [6:0]  io_wakeups_3_bits_uop_pdst,
  input  [1:0]  io_wakeups_3_bits_uop_dst_rtype,
  input         io_wakeups_4_valid,
  input  [6:0]  io_wakeups_4_bits_uop_pdst,
  input  [1:0]  io_wakeups_4_bits_uop_dst_rtype,
  input         io_wakeups_5_valid,
  input  [6:0]  io_wakeups_5_bits_uop_pdst,
  input  [1:0]  io_wakeups_5_bits_uop_dst_rtype,
  input         io_wakeups_6_valid,
  input  [6:0]  io_wakeups_6_bits_uop_pdst,
  input  [1:0]  io_wakeups_6_bits_uop_dst_rtype,
  input         io_wakeups_7_valid,
  input  [6:0]  io_wakeups_7_bits_uop_pdst,
  input  [1:0]  io_wakeups_7_bits_uop_dst_rtype,
  input         io_wakeups_8_valid,
  input  [6:0]  io_wakeups_8_bits_uop_pdst,
  input  [1:0]  io_wakeups_8_bits_uop_dst_rtype,
  input         io_wakeups_9_valid,
  input  [6:0]  io_wakeups_9_bits_uop_pdst,
  input  [1:0]  io_wakeups_9_bits_uop_dst_rtype,
  input         io_com_valids_0,
                io_com_valids_1,
                io_com_valids_2,
                io_com_valids_3,
  input  [6:0]  io_com_uops_0_pdst,
                io_com_uops_0_stale_pdst,
  input  [5:0]  io_com_uops_0_ldst,
  input         io_com_uops_0_ldst_val,
  input  [1:0]  io_com_uops_0_dst_rtype,
  input  [6:0]  io_com_uops_1_pdst,
                io_com_uops_1_stale_pdst,
  input  [5:0]  io_com_uops_1_ldst,
  input         io_com_uops_1_ldst_val,
  input  [1:0]  io_com_uops_1_dst_rtype,
  input  [6:0]  io_com_uops_2_pdst,
                io_com_uops_2_stale_pdst,
  input  [5:0]  io_com_uops_2_ldst,
  input         io_com_uops_2_ldst_val,
  input  [1:0]  io_com_uops_2_dst_rtype,
  input  [6:0]  io_com_uops_3_pdst,
                io_com_uops_3_stale_pdst,
  input  [5:0]  io_com_uops_3_ldst,
  input         io_com_uops_3_ldst_val,
  input  [1:0]  io_com_uops_3_dst_rtype,
  input         io_rbk_valids_0,
                io_rbk_valids_1,
                io_rbk_valids_2,
                io_rbk_valids_3,
                io_rollback,
                io_debug_rob_empty,
  output        io_ren_stalls_0,
                io_ren_stalls_1,
                io_ren_stalls_2,
                io_ren_stalls_3,
                io_ren2_mask_0,
                io_ren2_mask_1,
                io_ren2_mask_2,
                io_ren2_mask_3,
  output [6:0]  io_ren2_uops_0_uopc,
  output [31:0] io_ren2_uops_0_inst,
                io_ren2_uops_0_debug_inst,
  output        io_ren2_uops_0_is_rvc,
  output [39:0] io_ren2_uops_0_debug_pc,
  output [2:0]  io_ren2_uops_0_iq_type,
  output [9:0]  io_ren2_uops_0_fu_code,
  output [3:0]  io_ren2_uops_0_ctrl_br_type,
  output [1:0]  io_ren2_uops_0_ctrl_op1_sel,
  output [2:0]  io_ren2_uops_0_ctrl_op2_sel,
                io_ren2_uops_0_ctrl_imm_sel,
  output [3:0]  io_ren2_uops_0_ctrl_op_fcn,
  output        io_ren2_uops_0_ctrl_fcn_dw,
  output [2:0]  io_ren2_uops_0_ctrl_csr_cmd,
  output        io_ren2_uops_0_ctrl_is_load,
                io_ren2_uops_0_ctrl_is_sta,
                io_ren2_uops_0_ctrl_is_std,
  output [1:0]  io_ren2_uops_0_iw_state,
  output        io_ren2_uops_0_iw_p1_poisoned,
                io_ren2_uops_0_iw_p2_poisoned,
                io_ren2_uops_0_is_br,
                io_ren2_uops_0_is_jalr,
                io_ren2_uops_0_is_jal,
                io_ren2_uops_0_is_sfb,
  output [19:0] io_ren2_uops_0_br_mask,
  output [4:0]  io_ren2_uops_0_br_tag,
  output [5:0]  io_ren2_uops_0_ftq_idx,
  output        io_ren2_uops_0_edge_inst,
  output [5:0]  io_ren2_uops_0_pc_lob,
  output        io_ren2_uops_0_taken,
  output [19:0] io_ren2_uops_0_imm_packed,
  output [11:0] io_ren2_uops_0_csr_addr,
  output [1:0]  io_ren2_uops_0_rxq_idx,
  output [6:0]  io_ren2_uops_0_pdst,
                io_ren2_uops_0_prs1,
                io_ren2_uops_0_prs2,
  output        io_ren2_uops_0_prs1_busy,
                io_ren2_uops_0_prs2_busy,
  output [6:0]  io_ren2_uops_0_stale_pdst,
  output        io_ren2_uops_0_exception,
  output [63:0] io_ren2_uops_0_exc_cause,
  output        io_ren2_uops_0_bypassable,
  output [4:0]  io_ren2_uops_0_mem_cmd,
  output [1:0]  io_ren2_uops_0_mem_size,
  output        io_ren2_uops_0_mem_signed,
                io_ren2_uops_0_is_fence,
                io_ren2_uops_0_is_fencei,
                io_ren2_uops_0_is_amo,
                io_ren2_uops_0_uses_ldq,
                io_ren2_uops_0_uses_stq,
                io_ren2_uops_0_is_sys_pc2epc,
                io_ren2_uops_0_is_unique,
                io_ren2_uops_0_flush_on_commit,
                io_ren2_uops_0_ldst_is_rs1,
  output [5:0]  io_ren2_uops_0_ldst,
                io_ren2_uops_0_lrs1,
                io_ren2_uops_0_lrs2,
                io_ren2_uops_0_lrs3,
  output        io_ren2_uops_0_ldst_val,
  output [1:0]  io_ren2_uops_0_dst_rtype,
                io_ren2_uops_0_lrs1_rtype,
                io_ren2_uops_0_lrs2_rtype,
  output        io_ren2_uops_0_frs3_en,
                io_ren2_uops_0_fp_val,
                io_ren2_uops_0_fp_single,
                io_ren2_uops_0_xcpt_pf_if,
                io_ren2_uops_0_xcpt_ae_if,
                io_ren2_uops_0_xcpt_ma_if,
                io_ren2_uops_0_bp_debug_if,
                io_ren2_uops_0_bp_xcpt_if,
  output [1:0]  io_ren2_uops_0_debug_fsrc,
                io_ren2_uops_0_debug_tsrc,
  output [6:0]  io_ren2_uops_1_uopc,
  output [31:0] io_ren2_uops_1_inst,
                io_ren2_uops_1_debug_inst,
  output        io_ren2_uops_1_is_rvc,
  output [39:0] io_ren2_uops_1_debug_pc,
  output [2:0]  io_ren2_uops_1_iq_type,
  output [9:0]  io_ren2_uops_1_fu_code,
  output [3:0]  io_ren2_uops_1_ctrl_br_type,
  output [1:0]  io_ren2_uops_1_ctrl_op1_sel,
  output [2:0]  io_ren2_uops_1_ctrl_op2_sel,
                io_ren2_uops_1_ctrl_imm_sel,
  output [3:0]  io_ren2_uops_1_ctrl_op_fcn,
  output        io_ren2_uops_1_ctrl_fcn_dw,
  output [2:0]  io_ren2_uops_1_ctrl_csr_cmd,
  output        io_ren2_uops_1_ctrl_is_load,
                io_ren2_uops_1_ctrl_is_sta,
                io_ren2_uops_1_ctrl_is_std,
  output [1:0]  io_ren2_uops_1_iw_state,
  output        io_ren2_uops_1_iw_p1_poisoned,
                io_ren2_uops_1_iw_p2_poisoned,
                io_ren2_uops_1_is_br,
                io_ren2_uops_1_is_jalr,
                io_ren2_uops_1_is_jal,
                io_ren2_uops_1_is_sfb,
  output [19:0] io_ren2_uops_1_br_mask,
  output [4:0]  io_ren2_uops_1_br_tag,
  output [5:0]  io_ren2_uops_1_ftq_idx,
  output        io_ren2_uops_1_edge_inst,
  output [5:0]  io_ren2_uops_1_pc_lob,
  output        io_ren2_uops_1_taken,
  output [19:0] io_ren2_uops_1_imm_packed,
  output [11:0] io_ren2_uops_1_csr_addr,
  output [1:0]  io_ren2_uops_1_rxq_idx,
  output [6:0]  io_ren2_uops_1_pdst,
                io_ren2_uops_1_prs1,
                io_ren2_uops_1_prs2,
  output        io_ren2_uops_1_prs1_busy,
                io_ren2_uops_1_prs2_busy,
  output [6:0]  io_ren2_uops_1_stale_pdst,
  output        io_ren2_uops_1_exception,
  output [63:0] io_ren2_uops_1_exc_cause,
  output        io_ren2_uops_1_bypassable,
  output [4:0]  io_ren2_uops_1_mem_cmd,
  output [1:0]  io_ren2_uops_1_mem_size,
  output        io_ren2_uops_1_mem_signed,
                io_ren2_uops_1_is_fence,
                io_ren2_uops_1_is_fencei,
                io_ren2_uops_1_is_amo,
                io_ren2_uops_1_uses_ldq,
                io_ren2_uops_1_uses_stq,
                io_ren2_uops_1_is_sys_pc2epc,
                io_ren2_uops_1_is_unique,
                io_ren2_uops_1_flush_on_commit,
                io_ren2_uops_1_ldst_is_rs1,
  output [5:0]  io_ren2_uops_1_ldst,
                io_ren2_uops_1_lrs1,
                io_ren2_uops_1_lrs2,
                io_ren2_uops_1_lrs3,
  output        io_ren2_uops_1_ldst_val,
  output [1:0]  io_ren2_uops_1_dst_rtype,
                io_ren2_uops_1_lrs1_rtype,
                io_ren2_uops_1_lrs2_rtype,
  output        io_ren2_uops_1_frs3_en,
                io_ren2_uops_1_fp_val,
                io_ren2_uops_1_fp_single,
                io_ren2_uops_1_xcpt_pf_if,
                io_ren2_uops_1_xcpt_ae_if,
                io_ren2_uops_1_xcpt_ma_if,
                io_ren2_uops_1_bp_debug_if,
                io_ren2_uops_1_bp_xcpt_if,
  output [1:0]  io_ren2_uops_1_debug_fsrc,
                io_ren2_uops_1_debug_tsrc,
  output [6:0]  io_ren2_uops_2_uopc,
  output [31:0] io_ren2_uops_2_inst,
                io_ren2_uops_2_debug_inst,
  output        io_ren2_uops_2_is_rvc,
  output [39:0] io_ren2_uops_2_debug_pc,
  output [2:0]  io_ren2_uops_2_iq_type,
  output [9:0]  io_ren2_uops_2_fu_code,
  output [3:0]  io_ren2_uops_2_ctrl_br_type,
  output [1:0]  io_ren2_uops_2_ctrl_op1_sel,
  output [2:0]  io_ren2_uops_2_ctrl_op2_sel,
                io_ren2_uops_2_ctrl_imm_sel,
  output [3:0]  io_ren2_uops_2_ctrl_op_fcn,
  output        io_ren2_uops_2_ctrl_fcn_dw,
  output [2:0]  io_ren2_uops_2_ctrl_csr_cmd,
  output        io_ren2_uops_2_ctrl_is_load,
                io_ren2_uops_2_ctrl_is_sta,
                io_ren2_uops_2_ctrl_is_std,
  output [1:0]  io_ren2_uops_2_iw_state,
  output        io_ren2_uops_2_iw_p1_poisoned,
                io_ren2_uops_2_iw_p2_poisoned,
                io_ren2_uops_2_is_br,
                io_ren2_uops_2_is_jalr,
                io_ren2_uops_2_is_jal,
                io_ren2_uops_2_is_sfb,
  output [19:0] io_ren2_uops_2_br_mask,
  output [4:0]  io_ren2_uops_2_br_tag,
  output [5:0]  io_ren2_uops_2_ftq_idx,
  output        io_ren2_uops_2_edge_inst,
  output [5:0]  io_ren2_uops_2_pc_lob,
  output        io_ren2_uops_2_taken,
  output [19:0] io_ren2_uops_2_imm_packed,
  output [11:0] io_ren2_uops_2_csr_addr,
  output [1:0]  io_ren2_uops_2_rxq_idx,
  output [6:0]  io_ren2_uops_2_pdst,
                io_ren2_uops_2_prs1,
                io_ren2_uops_2_prs2,
  output        io_ren2_uops_2_prs1_busy,
                io_ren2_uops_2_prs2_busy,
  output [6:0]  io_ren2_uops_2_stale_pdst,
  output        io_ren2_uops_2_exception,
  output [63:0] io_ren2_uops_2_exc_cause,
  output        io_ren2_uops_2_bypassable,
  output [4:0]  io_ren2_uops_2_mem_cmd,
  output [1:0]  io_ren2_uops_2_mem_size,
  output        io_ren2_uops_2_mem_signed,
                io_ren2_uops_2_is_fence,
                io_ren2_uops_2_is_fencei,
                io_ren2_uops_2_is_amo,
                io_ren2_uops_2_uses_ldq,
                io_ren2_uops_2_uses_stq,
                io_ren2_uops_2_is_sys_pc2epc,
                io_ren2_uops_2_is_unique,
                io_ren2_uops_2_flush_on_commit,
                io_ren2_uops_2_ldst_is_rs1,
  output [5:0]  io_ren2_uops_2_ldst,
                io_ren2_uops_2_lrs1,
                io_ren2_uops_2_lrs2,
                io_ren2_uops_2_lrs3,
  output        io_ren2_uops_2_ldst_val,
  output [1:0]  io_ren2_uops_2_dst_rtype,
                io_ren2_uops_2_lrs1_rtype,
                io_ren2_uops_2_lrs2_rtype,
  output        io_ren2_uops_2_frs3_en,
                io_ren2_uops_2_fp_val,
                io_ren2_uops_2_fp_single,
                io_ren2_uops_2_xcpt_pf_if,
                io_ren2_uops_2_xcpt_ae_if,
                io_ren2_uops_2_xcpt_ma_if,
                io_ren2_uops_2_bp_debug_if,
                io_ren2_uops_2_bp_xcpt_if,
  output [1:0]  io_ren2_uops_2_debug_fsrc,
                io_ren2_uops_2_debug_tsrc,
  output [6:0]  io_ren2_uops_3_uopc,
  output [31:0] io_ren2_uops_3_inst,
                io_ren2_uops_3_debug_inst,
  output        io_ren2_uops_3_is_rvc,
  output [39:0] io_ren2_uops_3_debug_pc,
  output [2:0]  io_ren2_uops_3_iq_type,
  output [9:0]  io_ren2_uops_3_fu_code,
  output [3:0]  io_ren2_uops_3_ctrl_br_type,
  output [1:0]  io_ren2_uops_3_ctrl_op1_sel,
  output [2:0]  io_ren2_uops_3_ctrl_op2_sel,
                io_ren2_uops_3_ctrl_imm_sel,
  output [3:0]  io_ren2_uops_3_ctrl_op_fcn,
  output        io_ren2_uops_3_ctrl_fcn_dw,
  output [2:0]  io_ren2_uops_3_ctrl_csr_cmd,
  output        io_ren2_uops_3_ctrl_is_load,
                io_ren2_uops_3_ctrl_is_sta,
                io_ren2_uops_3_ctrl_is_std,
  output [1:0]  io_ren2_uops_3_iw_state,
  output        io_ren2_uops_3_iw_p1_poisoned,
                io_ren2_uops_3_iw_p2_poisoned,
                io_ren2_uops_3_is_br,
                io_ren2_uops_3_is_jalr,
                io_ren2_uops_3_is_jal,
                io_ren2_uops_3_is_sfb,
  output [19:0] io_ren2_uops_3_br_mask,
  output [4:0]  io_ren2_uops_3_br_tag,
  output [5:0]  io_ren2_uops_3_ftq_idx,
  output        io_ren2_uops_3_edge_inst,
  output [5:0]  io_ren2_uops_3_pc_lob,
  output        io_ren2_uops_3_taken,
  output [19:0] io_ren2_uops_3_imm_packed,
  output [11:0] io_ren2_uops_3_csr_addr,
  output [1:0]  io_ren2_uops_3_rxq_idx,
  output [6:0]  io_ren2_uops_3_pdst,
                io_ren2_uops_3_prs1,
                io_ren2_uops_3_prs2,
  output        io_ren2_uops_3_prs1_busy,
                io_ren2_uops_3_prs2_busy,
  output [6:0]  io_ren2_uops_3_stale_pdst,
  output        io_ren2_uops_3_exception,
  output [63:0] io_ren2_uops_3_exc_cause,
  output        io_ren2_uops_3_bypassable,
  output [4:0]  io_ren2_uops_3_mem_cmd,
  output [1:0]  io_ren2_uops_3_mem_size,
  output        io_ren2_uops_3_mem_signed,
                io_ren2_uops_3_is_fence,
                io_ren2_uops_3_is_fencei,
                io_ren2_uops_3_is_amo,
                io_ren2_uops_3_uses_ldq,
                io_ren2_uops_3_uses_stq,
                io_ren2_uops_3_is_sys_pc2epc,
                io_ren2_uops_3_is_unique,
                io_ren2_uops_3_flush_on_commit,
                io_ren2_uops_3_ldst_is_rs1,
  output [5:0]  io_ren2_uops_3_ldst,
                io_ren2_uops_3_lrs1,
                io_ren2_uops_3_lrs2,
                io_ren2_uops_3_lrs3,
  output        io_ren2_uops_3_ldst_val,
  output [1:0]  io_ren2_uops_3_dst_rtype,
                io_ren2_uops_3_lrs1_rtype,
                io_ren2_uops_3_lrs2_rtype,
  output        io_ren2_uops_3_frs3_en,
                io_ren2_uops_3_fp_val,
                io_ren2_uops_3_fp_single,
                io_ren2_uops_3_xcpt_pf_if,
                io_ren2_uops_3_xcpt_ae_if,
                io_ren2_uops_3_xcpt_ma_if,
                io_ren2_uops_3_bp_debug_if,
                io_ren2_uops_3_bp_xcpt_if,
  output [1:0]  io_ren2_uops_3_debug_fsrc,
                io_ren2_uops_3_debug_tsrc
);

  wire [6:0]  io_ren2_uops_3_newuop_pdst;	// rename-stage.scala:303:20
  wire [6:0]  io_ren2_uops_2_newuop_pdst;	// rename-stage.scala:303:20
  wire [6:0]  io_ren2_uops_1_newuop_pdst;	// rename-stage.scala:303:20
  wire [6:0]  io_ren2_uops_0_newuop_pdst;	// rename-stage.scala:303:20
  wire        _busytable_io_busy_resps_0_prs1_busy;	// rename-stage.scala:221:25
  wire        _busytable_io_busy_resps_0_prs2_busy;	// rename-stage.scala:221:25
  wire        _busytable_io_busy_resps_1_prs1_busy;	// rename-stage.scala:221:25
  wire        _busytable_io_busy_resps_1_prs2_busy;	// rename-stage.scala:221:25
  wire        _busytable_io_busy_resps_2_prs1_busy;	// rename-stage.scala:221:25
  wire        _busytable_io_busy_resps_2_prs2_busy;	// rename-stage.scala:221:25
  wire        _busytable_io_busy_resps_3_prs1_busy;	// rename-stage.scala:221:25
  wire        _busytable_io_busy_resps_3_prs2_busy;	// rename-stage.scala:221:25
  wire        _freelist_io_alloc_pregs_0_valid;	// rename-stage.scala:217:24
  wire [6:0]  _freelist_io_alloc_pregs_0_bits;	// rename-stage.scala:217:24
  wire        _freelist_io_alloc_pregs_1_valid;	// rename-stage.scala:217:24
  wire [6:0]  _freelist_io_alloc_pregs_1_bits;	// rename-stage.scala:217:24
  wire        _freelist_io_alloc_pregs_2_valid;	// rename-stage.scala:217:24
  wire [6:0]  _freelist_io_alloc_pregs_2_bits;	// rename-stage.scala:217:24
  wire        _freelist_io_alloc_pregs_3_valid;	// rename-stage.scala:217:24
  wire [6:0]  _freelist_io_alloc_pregs_3_bits;	// rename-stage.scala:217:24
  wire [6:0]  _maptable_io_map_resps_0_prs1;	// rename-stage.scala:211:24
  wire [6:0]  _maptable_io_map_resps_0_prs2;	// rename-stage.scala:211:24
  wire [6:0]  _maptable_io_map_resps_0_stale_pdst;	// rename-stage.scala:211:24
  wire [6:0]  _maptable_io_map_resps_1_prs1;	// rename-stage.scala:211:24
  wire [6:0]  _maptable_io_map_resps_1_prs2;	// rename-stage.scala:211:24
  wire [6:0]  _maptable_io_map_resps_1_stale_pdst;	// rename-stage.scala:211:24
  wire [6:0]  _maptable_io_map_resps_2_prs1;	// rename-stage.scala:211:24
  wire [6:0]  _maptable_io_map_resps_2_prs2;	// rename-stage.scala:211:24
  wire [6:0]  _maptable_io_map_resps_2_stale_pdst;	// rename-stage.scala:211:24
  wire [6:0]  _maptable_io_map_resps_3_prs1;	// rename-stage.scala:211:24
  wire [6:0]  _maptable_io_map_resps_3_prs2;	// rename-stage.scala:211:24
  wire [6:0]  _maptable_io_map_resps_3_stale_pdst;	// rename-stage.scala:211:24
  reg         r_valid;	// rename-stage.scala:118:27
  reg  [6:0]  r_uop_uopc;	// rename-stage.scala:119:23
  reg  [31:0] r_uop_inst;	// rename-stage.scala:119:23
  reg  [31:0] r_uop_debug_inst;	// rename-stage.scala:119:23
  reg         r_uop_is_rvc;	// rename-stage.scala:119:23
  reg  [39:0] r_uop_debug_pc;	// rename-stage.scala:119:23
  reg  [2:0]  r_uop_iq_type;	// rename-stage.scala:119:23
  reg  [9:0]  r_uop_fu_code;	// rename-stage.scala:119:23
  reg  [3:0]  r_uop_ctrl_br_type;	// rename-stage.scala:119:23
  reg  [1:0]  r_uop_ctrl_op1_sel;	// rename-stage.scala:119:23
  reg  [2:0]  r_uop_ctrl_op2_sel;	// rename-stage.scala:119:23
  reg  [2:0]  r_uop_ctrl_imm_sel;	// rename-stage.scala:119:23
  reg  [3:0]  r_uop_ctrl_op_fcn;	// rename-stage.scala:119:23
  reg         r_uop_ctrl_fcn_dw;	// rename-stage.scala:119:23
  reg  [2:0]  r_uop_ctrl_csr_cmd;	// rename-stage.scala:119:23
  reg         r_uop_ctrl_is_load;	// rename-stage.scala:119:23
  reg         r_uop_ctrl_is_sta;	// rename-stage.scala:119:23
  reg         r_uop_ctrl_is_std;	// rename-stage.scala:119:23
  reg  [1:0]  r_uop_iw_state;	// rename-stage.scala:119:23
  reg         r_uop_iw_p1_poisoned;	// rename-stage.scala:119:23
  reg         r_uop_iw_p2_poisoned;	// rename-stage.scala:119:23
  reg         r_uop_is_br;	// rename-stage.scala:119:23
  reg         r_uop_is_jalr;	// rename-stage.scala:119:23
  reg         r_uop_is_jal;	// rename-stage.scala:119:23
  reg         r_uop_is_sfb;	// rename-stage.scala:119:23
  reg  [19:0] r_uop_br_mask;	// rename-stage.scala:119:23
  reg  [4:0]  r_uop_br_tag;	// rename-stage.scala:119:23
  reg  [5:0]  r_uop_ftq_idx;	// rename-stage.scala:119:23
  reg         r_uop_edge_inst;	// rename-stage.scala:119:23
  reg  [5:0]  r_uop_pc_lob;	// rename-stage.scala:119:23
  reg         r_uop_taken;	// rename-stage.scala:119:23
  reg  [19:0] r_uop_imm_packed;	// rename-stage.scala:119:23
  reg  [11:0] r_uop_csr_addr;	// rename-stage.scala:119:23
  reg  [1:0]  r_uop_rxq_idx;	// rename-stage.scala:119:23
  reg  [6:0]  r_uop_prs1;	// rename-stage.scala:119:23
  reg  [6:0]  r_uop_prs2;	// rename-stage.scala:119:23
  reg  [6:0]  r_uop_stale_pdst;	// rename-stage.scala:119:23
  reg         r_uop_exception;	// rename-stage.scala:119:23
  reg  [63:0] r_uop_exc_cause;	// rename-stage.scala:119:23
  reg         r_uop_bypassable;	// rename-stage.scala:119:23
  reg  [4:0]  r_uop_mem_cmd;	// rename-stage.scala:119:23
  reg  [1:0]  r_uop_mem_size;	// rename-stage.scala:119:23
  reg         r_uop_mem_signed;	// rename-stage.scala:119:23
  reg         r_uop_is_fence;	// rename-stage.scala:119:23
  reg         r_uop_is_fencei;	// rename-stage.scala:119:23
  reg         r_uop_is_amo;	// rename-stage.scala:119:23
  reg         r_uop_uses_ldq;	// rename-stage.scala:119:23
  reg         r_uop_uses_stq;	// rename-stage.scala:119:23
  reg         r_uop_is_sys_pc2epc;	// rename-stage.scala:119:23
  reg         r_uop_is_unique;	// rename-stage.scala:119:23
  reg         r_uop_flush_on_commit;	// rename-stage.scala:119:23
  reg         r_uop_ldst_is_rs1;	// rename-stage.scala:119:23
  reg  [5:0]  r_uop_ldst;	// rename-stage.scala:119:23
  reg  [5:0]  r_uop_lrs1;	// rename-stage.scala:119:23
  reg  [5:0]  r_uop_lrs2;	// rename-stage.scala:119:23
  reg  [5:0]  r_uop_lrs3;	// rename-stage.scala:119:23
  reg         r_uop_ldst_val;	// rename-stage.scala:119:23
  reg  [1:0]  r_uop_dst_rtype;	// rename-stage.scala:119:23
  reg  [1:0]  r_uop_lrs1_rtype;	// rename-stage.scala:119:23
  reg  [1:0]  r_uop_lrs2_rtype;	// rename-stage.scala:119:23
  reg         r_uop_frs3_en;	// rename-stage.scala:119:23
  reg         r_uop_fp_val;	// rename-stage.scala:119:23
  reg         r_uop_fp_single;	// rename-stage.scala:119:23
  reg         r_uop_xcpt_pf_if;	// rename-stage.scala:119:23
  reg         r_uop_xcpt_ae_if;	// rename-stage.scala:119:23
  reg         r_uop_xcpt_ma_if;	// rename-stage.scala:119:23
  reg         r_uop_bp_debug_if;	// rename-stage.scala:119:23
  reg         r_uop_bp_xcpt_if;	// rename-stage.scala:119:23
  reg  [1:0]  r_uop_debug_fsrc;	// rename-stage.scala:119:23
  reg  [1:0]  r_uop_debug_tsrc;	// rename-stage.scala:119:23
  reg         r_valid_1;	// rename-stage.scala:118:27
  reg  [6:0]  r_uop_1_uopc;	// rename-stage.scala:119:23
  reg  [31:0] r_uop_1_inst;	// rename-stage.scala:119:23
  reg  [31:0] r_uop_1_debug_inst;	// rename-stage.scala:119:23
  reg         r_uop_1_is_rvc;	// rename-stage.scala:119:23
  reg  [39:0] r_uop_1_debug_pc;	// rename-stage.scala:119:23
  reg  [2:0]  r_uop_1_iq_type;	// rename-stage.scala:119:23
  reg  [9:0]  r_uop_1_fu_code;	// rename-stage.scala:119:23
  reg  [3:0]  r_uop_1_ctrl_br_type;	// rename-stage.scala:119:23
  reg  [1:0]  r_uop_1_ctrl_op1_sel;	// rename-stage.scala:119:23
  reg  [2:0]  r_uop_1_ctrl_op2_sel;	// rename-stage.scala:119:23
  reg  [2:0]  r_uop_1_ctrl_imm_sel;	// rename-stage.scala:119:23
  reg  [3:0]  r_uop_1_ctrl_op_fcn;	// rename-stage.scala:119:23
  reg         r_uop_1_ctrl_fcn_dw;	// rename-stage.scala:119:23
  reg  [2:0]  r_uop_1_ctrl_csr_cmd;	// rename-stage.scala:119:23
  reg         r_uop_1_ctrl_is_load;	// rename-stage.scala:119:23
  reg         r_uop_1_ctrl_is_sta;	// rename-stage.scala:119:23
  reg         r_uop_1_ctrl_is_std;	// rename-stage.scala:119:23
  reg  [1:0]  r_uop_1_iw_state;	// rename-stage.scala:119:23
  reg         r_uop_1_iw_p1_poisoned;	// rename-stage.scala:119:23
  reg         r_uop_1_iw_p2_poisoned;	// rename-stage.scala:119:23
  reg         r_uop_1_is_br;	// rename-stage.scala:119:23
  reg         r_uop_1_is_jalr;	// rename-stage.scala:119:23
  reg         r_uop_1_is_jal;	// rename-stage.scala:119:23
  reg         r_uop_1_is_sfb;	// rename-stage.scala:119:23
  reg  [19:0] r_uop_1_br_mask;	// rename-stage.scala:119:23
  reg  [4:0]  r_uop_1_br_tag;	// rename-stage.scala:119:23
  reg  [5:0]  r_uop_1_ftq_idx;	// rename-stage.scala:119:23
  reg         r_uop_1_edge_inst;	// rename-stage.scala:119:23
  reg  [5:0]  r_uop_1_pc_lob;	// rename-stage.scala:119:23
  reg         r_uop_1_taken;	// rename-stage.scala:119:23
  reg  [19:0] r_uop_1_imm_packed;	// rename-stage.scala:119:23
  reg  [11:0] r_uop_1_csr_addr;	// rename-stage.scala:119:23
  reg  [1:0]  r_uop_1_rxq_idx;	// rename-stage.scala:119:23
  reg  [6:0]  r_uop_1_prs1;	// rename-stage.scala:119:23
  reg  [6:0]  r_uop_1_prs2;	// rename-stage.scala:119:23
  reg  [6:0]  r_uop_1_stale_pdst;	// rename-stage.scala:119:23
  reg         r_uop_1_exception;	// rename-stage.scala:119:23
  reg  [63:0] r_uop_1_exc_cause;	// rename-stage.scala:119:23
  reg         r_uop_1_bypassable;	// rename-stage.scala:119:23
  reg  [4:0]  r_uop_1_mem_cmd;	// rename-stage.scala:119:23
  reg  [1:0]  r_uop_1_mem_size;	// rename-stage.scala:119:23
  reg         r_uop_1_mem_signed;	// rename-stage.scala:119:23
  reg         r_uop_1_is_fence;	// rename-stage.scala:119:23
  reg         r_uop_1_is_fencei;	// rename-stage.scala:119:23
  reg         r_uop_1_is_amo;	// rename-stage.scala:119:23
  reg         r_uop_1_uses_ldq;	// rename-stage.scala:119:23
  reg         r_uop_1_uses_stq;	// rename-stage.scala:119:23
  reg         r_uop_1_is_sys_pc2epc;	// rename-stage.scala:119:23
  reg         r_uop_1_is_unique;	// rename-stage.scala:119:23
  reg         r_uop_1_flush_on_commit;	// rename-stage.scala:119:23
  reg         r_uop_1_ldst_is_rs1;	// rename-stage.scala:119:23
  reg  [5:0]  r_uop_1_ldst;	// rename-stage.scala:119:23
  reg  [5:0]  r_uop_1_lrs1;	// rename-stage.scala:119:23
  reg  [5:0]  r_uop_1_lrs2;	// rename-stage.scala:119:23
  reg  [5:0]  r_uop_1_lrs3;	// rename-stage.scala:119:23
  reg         r_uop_1_ldst_val;	// rename-stage.scala:119:23
  reg  [1:0]  r_uop_1_dst_rtype;	// rename-stage.scala:119:23
  reg  [1:0]  r_uop_1_lrs1_rtype;	// rename-stage.scala:119:23
  reg  [1:0]  r_uop_1_lrs2_rtype;	// rename-stage.scala:119:23
  reg         r_uop_1_frs3_en;	// rename-stage.scala:119:23
  reg         r_uop_1_fp_val;	// rename-stage.scala:119:23
  reg         r_uop_1_fp_single;	// rename-stage.scala:119:23
  reg         r_uop_1_xcpt_pf_if;	// rename-stage.scala:119:23
  reg         r_uop_1_xcpt_ae_if;	// rename-stage.scala:119:23
  reg         r_uop_1_xcpt_ma_if;	// rename-stage.scala:119:23
  reg         r_uop_1_bp_debug_if;	// rename-stage.scala:119:23
  reg         r_uop_1_bp_xcpt_if;	// rename-stage.scala:119:23
  reg  [1:0]  r_uop_1_debug_fsrc;	// rename-stage.scala:119:23
  reg  [1:0]  r_uop_1_debug_tsrc;	// rename-stage.scala:119:23
  reg         r_valid_2;	// rename-stage.scala:118:27
  reg  [6:0]  r_uop_2_uopc;	// rename-stage.scala:119:23
  reg  [31:0] r_uop_2_inst;	// rename-stage.scala:119:23
  reg  [31:0] r_uop_2_debug_inst;	// rename-stage.scala:119:23
  reg         r_uop_2_is_rvc;	// rename-stage.scala:119:23
  reg  [39:0] r_uop_2_debug_pc;	// rename-stage.scala:119:23
  reg  [2:0]  r_uop_2_iq_type;	// rename-stage.scala:119:23
  reg  [9:0]  r_uop_2_fu_code;	// rename-stage.scala:119:23
  reg  [3:0]  r_uop_2_ctrl_br_type;	// rename-stage.scala:119:23
  reg  [1:0]  r_uop_2_ctrl_op1_sel;	// rename-stage.scala:119:23
  reg  [2:0]  r_uop_2_ctrl_op2_sel;	// rename-stage.scala:119:23
  reg  [2:0]  r_uop_2_ctrl_imm_sel;	// rename-stage.scala:119:23
  reg  [3:0]  r_uop_2_ctrl_op_fcn;	// rename-stage.scala:119:23
  reg         r_uop_2_ctrl_fcn_dw;	// rename-stage.scala:119:23
  reg  [2:0]  r_uop_2_ctrl_csr_cmd;	// rename-stage.scala:119:23
  reg         r_uop_2_ctrl_is_load;	// rename-stage.scala:119:23
  reg         r_uop_2_ctrl_is_sta;	// rename-stage.scala:119:23
  reg         r_uop_2_ctrl_is_std;	// rename-stage.scala:119:23
  reg  [1:0]  r_uop_2_iw_state;	// rename-stage.scala:119:23
  reg         r_uop_2_iw_p1_poisoned;	// rename-stage.scala:119:23
  reg         r_uop_2_iw_p2_poisoned;	// rename-stage.scala:119:23
  reg         r_uop_2_is_br;	// rename-stage.scala:119:23
  reg         r_uop_2_is_jalr;	// rename-stage.scala:119:23
  reg         r_uop_2_is_jal;	// rename-stage.scala:119:23
  reg         r_uop_2_is_sfb;	// rename-stage.scala:119:23
  reg  [19:0] r_uop_2_br_mask;	// rename-stage.scala:119:23
  reg  [4:0]  r_uop_2_br_tag;	// rename-stage.scala:119:23
  reg  [5:0]  r_uop_2_ftq_idx;	// rename-stage.scala:119:23
  reg         r_uop_2_edge_inst;	// rename-stage.scala:119:23
  reg  [5:0]  r_uop_2_pc_lob;	// rename-stage.scala:119:23
  reg         r_uop_2_taken;	// rename-stage.scala:119:23
  reg  [19:0] r_uop_2_imm_packed;	// rename-stage.scala:119:23
  reg  [11:0] r_uop_2_csr_addr;	// rename-stage.scala:119:23
  reg  [1:0]  r_uop_2_rxq_idx;	// rename-stage.scala:119:23
  reg  [6:0]  r_uop_2_prs1;	// rename-stage.scala:119:23
  reg  [6:0]  r_uop_2_prs2;	// rename-stage.scala:119:23
  reg  [6:0]  r_uop_2_stale_pdst;	// rename-stage.scala:119:23
  reg         r_uop_2_exception;	// rename-stage.scala:119:23
  reg  [63:0] r_uop_2_exc_cause;	// rename-stage.scala:119:23
  reg         r_uop_2_bypassable;	// rename-stage.scala:119:23
  reg  [4:0]  r_uop_2_mem_cmd;	// rename-stage.scala:119:23
  reg  [1:0]  r_uop_2_mem_size;	// rename-stage.scala:119:23
  reg         r_uop_2_mem_signed;	// rename-stage.scala:119:23
  reg         r_uop_2_is_fence;	// rename-stage.scala:119:23
  reg         r_uop_2_is_fencei;	// rename-stage.scala:119:23
  reg         r_uop_2_is_amo;	// rename-stage.scala:119:23
  reg         r_uop_2_uses_ldq;	// rename-stage.scala:119:23
  reg         r_uop_2_uses_stq;	// rename-stage.scala:119:23
  reg         r_uop_2_is_sys_pc2epc;	// rename-stage.scala:119:23
  reg         r_uop_2_is_unique;	// rename-stage.scala:119:23
  reg         r_uop_2_flush_on_commit;	// rename-stage.scala:119:23
  reg         r_uop_2_ldst_is_rs1;	// rename-stage.scala:119:23
  reg  [5:0]  r_uop_2_ldst;	// rename-stage.scala:119:23
  reg  [5:0]  r_uop_2_lrs1;	// rename-stage.scala:119:23
  reg  [5:0]  r_uop_2_lrs2;	// rename-stage.scala:119:23
  reg  [5:0]  r_uop_2_lrs3;	// rename-stage.scala:119:23
  reg         r_uop_2_ldst_val;	// rename-stage.scala:119:23
  reg  [1:0]  r_uop_2_dst_rtype;	// rename-stage.scala:119:23
  reg  [1:0]  r_uop_2_lrs1_rtype;	// rename-stage.scala:119:23
  reg  [1:0]  r_uop_2_lrs2_rtype;	// rename-stage.scala:119:23
  reg         r_uop_2_frs3_en;	// rename-stage.scala:119:23
  reg         r_uop_2_fp_val;	// rename-stage.scala:119:23
  reg         r_uop_2_fp_single;	// rename-stage.scala:119:23
  reg         r_uop_2_xcpt_pf_if;	// rename-stage.scala:119:23
  reg         r_uop_2_xcpt_ae_if;	// rename-stage.scala:119:23
  reg         r_uop_2_xcpt_ma_if;	// rename-stage.scala:119:23
  reg         r_uop_2_bp_debug_if;	// rename-stage.scala:119:23
  reg         r_uop_2_bp_xcpt_if;	// rename-stage.scala:119:23
  reg  [1:0]  r_uop_2_debug_fsrc;	// rename-stage.scala:119:23
  reg  [1:0]  r_uop_2_debug_tsrc;	// rename-stage.scala:119:23
  reg         r_valid_3;	// rename-stage.scala:118:27
  reg  [6:0]  r_uop_3_uopc;	// rename-stage.scala:119:23
  reg  [31:0] r_uop_3_inst;	// rename-stage.scala:119:23
  reg  [31:0] r_uop_3_debug_inst;	// rename-stage.scala:119:23
  reg         r_uop_3_is_rvc;	// rename-stage.scala:119:23
  reg  [39:0] r_uop_3_debug_pc;	// rename-stage.scala:119:23
  reg  [2:0]  r_uop_3_iq_type;	// rename-stage.scala:119:23
  reg  [9:0]  r_uop_3_fu_code;	// rename-stage.scala:119:23
  reg  [3:0]  r_uop_3_ctrl_br_type;	// rename-stage.scala:119:23
  reg  [1:0]  r_uop_3_ctrl_op1_sel;	// rename-stage.scala:119:23
  reg  [2:0]  r_uop_3_ctrl_op2_sel;	// rename-stage.scala:119:23
  reg  [2:0]  r_uop_3_ctrl_imm_sel;	// rename-stage.scala:119:23
  reg  [3:0]  r_uop_3_ctrl_op_fcn;	// rename-stage.scala:119:23
  reg         r_uop_3_ctrl_fcn_dw;	// rename-stage.scala:119:23
  reg  [2:0]  r_uop_3_ctrl_csr_cmd;	// rename-stage.scala:119:23
  reg         r_uop_3_ctrl_is_load;	// rename-stage.scala:119:23
  reg         r_uop_3_ctrl_is_sta;	// rename-stage.scala:119:23
  reg         r_uop_3_ctrl_is_std;	// rename-stage.scala:119:23
  reg  [1:0]  r_uop_3_iw_state;	// rename-stage.scala:119:23
  reg         r_uop_3_iw_p1_poisoned;	// rename-stage.scala:119:23
  reg         r_uop_3_iw_p2_poisoned;	// rename-stage.scala:119:23
  reg         r_uop_3_is_br;	// rename-stage.scala:119:23
  reg         r_uop_3_is_jalr;	// rename-stage.scala:119:23
  reg         r_uop_3_is_jal;	// rename-stage.scala:119:23
  reg         r_uop_3_is_sfb;	// rename-stage.scala:119:23
  reg  [19:0] r_uop_3_br_mask;	// rename-stage.scala:119:23
  reg  [4:0]  r_uop_3_br_tag;	// rename-stage.scala:119:23
  reg  [5:0]  r_uop_3_ftq_idx;	// rename-stage.scala:119:23
  reg         r_uop_3_edge_inst;	// rename-stage.scala:119:23
  reg  [5:0]  r_uop_3_pc_lob;	// rename-stage.scala:119:23
  reg         r_uop_3_taken;	// rename-stage.scala:119:23
  reg  [19:0] r_uop_3_imm_packed;	// rename-stage.scala:119:23
  reg  [11:0] r_uop_3_csr_addr;	// rename-stage.scala:119:23
  reg  [1:0]  r_uop_3_rxq_idx;	// rename-stage.scala:119:23
  reg  [6:0]  r_uop_3_prs1;	// rename-stage.scala:119:23
  reg  [6:0]  r_uop_3_prs2;	// rename-stage.scala:119:23
  reg  [6:0]  r_uop_3_stale_pdst;	// rename-stage.scala:119:23
  reg         r_uop_3_exception;	// rename-stage.scala:119:23
  reg  [63:0] r_uop_3_exc_cause;	// rename-stage.scala:119:23
  reg         r_uop_3_bypassable;	// rename-stage.scala:119:23
  reg  [4:0]  r_uop_3_mem_cmd;	// rename-stage.scala:119:23
  reg  [1:0]  r_uop_3_mem_size;	// rename-stage.scala:119:23
  reg         r_uop_3_mem_signed;	// rename-stage.scala:119:23
  reg         r_uop_3_is_fence;	// rename-stage.scala:119:23
  reg         r_uop_3_is_fencei;	// rename-stage.scala:119:23
  reg         r_uop_3_is_amo;	// rename-stage.scala:119:23
  reg         r_uop_3_uses_ldq;	// rename-stage.scala:119:23
  reg         r_uop_3_uses_stq;	// rename-stage.scala:119:23
  reg         r_uop_3_is_sys_pc2epc;	// rename-stage.scala:119:23
  reg         r_uop_3_is_unique;	// rename-stage.scala:119:23
  reg         r_uop_3_flush_on_commit;	// rename-stage.scala:119:23
  reg         r_uop_3_ldst_is_rs1;	// rename-stage.scala:119:23
  reg  [5:0]  r_uop_3_ldst;	// rename-stage.scala:119:23
  reg  [5:0]  r_uop_3_lrs1;	// rename-stage.scala:119:23
  reg  [5:0]  r_uop_3_lrs2;	// rename-stage.scala:119:23
  reg  [5:0]  r_uop_3_lrs3;	// rename-stage.scala:119:23
  reg         r_uop_3_ldst_val;	// rename-stage.scala:119:23
  reg  [1:0]  r_uop_3_dst_rtype;	// rename-stage.scala:119:23
  reg  [1:0]  r_uop_3_lrs1_rtype;	// rename-stage.scala:119:23
  reg  [1:0]  r_uop_3_lrs2_rtype;	// rename-stage.scala:119:23
  reg         r_uop_3_frs3_en;	// rename-stage.scala:119:23
  reg         r_uop_3_fp_val;	// rename-stage.scala:119:23
  reg         r_uop_3_fp_single;	// rename-stage.scala:119:23
  reg         r_uop_3_xcpt_pf_if;	// rename-stage.scala:119:23
  reg         r_uop_3_xcpt_ae_if;	// rename-stage.scala:119:23
  reg         r_uop_3_xcpt_ma_if;	// rename-stage.scala:119:23
  reg         r_uop_3_bp_debug_if;	// rename-stage.scala:119:23
  reg         r_uop_3_bp_xcpt_if;	// rename-stage.scala:119:23
  reg  [1:0]  r_uop_3_debug_fsrc;	// rename-stage.scala:119:23
  reg  [1:0]  r_uop_3_debug_tsrc;	// rename-stage.scala:119:23
  wire        _io_ren_stalls_0_T = r_uop_dst_rtype == 2'h0;	// rename-stage.scala:119:23, :237:78
  wire        ren2_alloc_reqs_0 = r_uop_ldst_val & _io_ren_stalls_0_T & io_dis_fire_0;	// rename-stage.scala:119:23, :237:{78,88}
  wire        ren2_br_tags_0_valid =
    io_dis_fire_0 & (r_uop_is_br & ~r_uop_is_sfb | r_uop_is_jalr);	// micro-op.scala:146:{33,36,45}, rename-stage.scala:119:23, :238:43
  wire        _rbk_valids_0_T = io_com_uops_0_dst_rtype == 2'h0;	// rename-stage.scala:237:78, :240:82
  wire        rbk_valids_0 = io_com_uops_0_ldst_val & _rbk_valids_0_T & io_rbk_valids_0;	// rename-stage.scala:240:82, :241:92
  wire        _io_ren_stalls_1_T = r_uop_1_dst_rtype == 2'h0;	// rename-stage.scala:119:23, :237:78
  wire        ren2_alloc_reqs_1 = r_uop_1_ldst_val & _io_ren_stalls_1_T & io_dis_fire_1;	// rename-stage.scala:119:23, :237:{78,88}
  wire        ren2_br_tags_1_valid =
    io_dis_fire_1 & (r_uop_1_is_br & ~r_uop_1_is_sfb | r_uop_1_is_jalr);	// micro-op.scala:146:{33,36,45}, rename-stage.scala:119:23, :238:43
  wire        _rbk_valids_1_T = io_com_uops_1_dst_rtype == 2'h0;	// rename-stage.scala:237:78, :240:82
  wire        rbk_valids_1 = io_com_uops_1_ldst_val & _rbk_valids_1_T & io_rbk_valids_1;	// rename-stage.scala:240:82, :241:92
  wire        _io_ren_stalls_2_T = r_uop_2_dst_rtype == 2'h0;	// rename-stage.scala:119:23, :237:78
  wire        ren2_alloc_reqs_2 = r_uop_2_ldst_val & _io_ren_stalls_2_T & io_dis_fire_2;	// rename-stage.scala:119:23, :237:{78,88}
  wire        ren2_br_tags_2_valid =
    io_dis_fire_2 & (r_uop_2_is_br & ~r_uop_2_is_sfb | r_uop_2_is_jalr);	// micro-op.scala:146:{33,36,45}, rename-stage.scala:119:23, :238:43
  wire        _rbk_valids_2_T = io_com_uops_2_dst_rtype == 2'h0;	// rename-stage.scala:237:78, :240:82
  wire        rbk_valids_2 = io_com_uops_2_ldst_val & _rbk_valids_2_T & io_rbk_valids_2;	// rename-stage.scala:240:82, :241:92
  wire        _io_ren_stalls_3_T = r_uop_3_dst_rtype == 2'h0;	// rename-stage.scala:119:23, :237:78
  wire        ren2_alloc_reqs_3 = r_uop_3_ldst_val & _io_ren_stalls_3_T & io_dis_fire_3;	// rename-stage.scala:119:23, :237:{78,88}
  wire        ren2_br_tags_3_valid =
    io_dis_fire_3 & (r_uop_3_is_br & ~r_uop_3_is_sfb | r_uop_3_is_jalr);	// micro-op.scala:146:{33,36,45}, rename-stage.scala:119:23, :238:43
  wire        _rbk_valids_3_T = io_com_uops_3_dst_rtype == 2'h0;	// rename-stage.scala:237:78, :240:82
  wire        rbk_valids_3 = io_com_uops_3_ldst_val & _rbk_valids_3_T & io_rbk_valids_3;	// rename-stage.scala:240:82, :241:92
  assign io_ren2_uops_0_newuop_pdst =
    (|r_uop_ldst) ? _freelist_io_alloc_pregs_0_bits : 7'h0;	// rename-stage.scala:119:23, :201:30, :217:24, :303:{20,30}
  assign io_ren2_uops_1_newuop_pdst =
    (|r_uop_1_ldst) ? _freelist_io_alloc_pregs_1_bits : 7'h0;	// rename-stage.scala:119:23, :201:30, :217:24, :303:{20,30}
  assign io_ren2_uops_2_newuop_pdst =
    (|r_uop_2_ldst) ? _freelist_io_alloc_pregs_2_bits : 7'h0;	// rename-stage.scala:119:23, :201:30, :217:24, :303:{20,30}
  assign io_ren2_uops_3_newuop_pdst =
    (|r_uop_3_ldst) ? _freelist_io_alloc_pregs_3_bits : 7'h0;	// rename-stage.scala:119:23, :201:30, :217:24, :303:{20,30}
  `ifndef SYNTHESIS	// rename-stage.scala:297:10
    always @(posedge clock) begin	// rename-stage.scala:297:10
      if (~((~ren2_alloc_reqs_0 | (|_freelist_io_alloc_pregs_0_bits))
            & (~ren2_alloc_reqs_1 | (|_freelist_io_alloc_pregs_1_bits))
            & (~ren2_alloc_reqs_2 | (|_freelist_io_alloc_pregs_2_bits))
            & (~ren2_alloc_reqs_3 | (|_freelist_io_alloc_pregs_3_bits)) | reset)) begin	// rename-stage.scala:217:24, :237:88, :297:{10,74,77,87,105}
        if (`ASSERT_VERBOSE_COND_)	// rename-stage.scala:297:10
          $error("Assertion failed: [rename-stage] A uop is trying to allocate the zero physical register.\n    at rename-stage.scala:297 assert (ren2_alloc_reqs zip freelist.io.alloc_pregs map {case (r,p) => !r || p.bits =/= 0.U} reduce (_&&_),\n");	// rename-stage.scala:297:10
        if (`STOP_COND_)	// rename-stage.scala:297:10
          $fatal;	// rename-stage.scala:297:10
      end
      if (~(~(io_wakeups_0_valid & (|io_wakeups_0_bits_uop_dst_rtype) | io_wakeups_1_valid
              & (|io_wakeups_1_bits_uop_dst_rtype) | io_wakeups_2_valid
              & (|io_wakeups_2_bits_uop_dst_rtype) | io_wakeups_3_valid
              & (|io_wakeups_3_bits_uop_dst_rtype) | io_wakeups_4_valid
              & (|io_wakeups_4_bits_uop_dst_rtype) | io_wakeups_5_valid
              & (|io_wakeups_5_bits_uop_dst_rtype) | io_wakeups_6_valid
              & (|io_wakeups_6_bits_uop_dst_rtype) | io_wakeups_7_valid
              & (|io_wakeups_7_bits_uop_dst_rtype) | io_wakeups_8_valid
              & (|io_wakeups_8_bits_uop_dst_rtype) | io_wakeups_9_valid
              & (|io_wakeups_9_bits_uop_dst_rtype)) | reset)) begin	// rename-stage.scala:314:{10,11,41,65,84}
        if (`ASSERT_VERBOSE_COND_)	// rename-stage.scala:314:10
          $error("Assertion failed: [rename] Wakeup has wrong rtype.\n    at rename-stage.scala:314 assert (!(io.wakeups.map(x => x.valid && x.bits.uop.dst_rtype =/= rtype).reduce(_||_)),\n");	// rename-stage.scala:314:10
        if (`STOP_COND_)	// rename-stage.scala:314:10
          $fatal;	// rename-stage.scala:314:10
      end
      if (~(~(r_valid & _busytable_io_busy_resps_0_prs1_busy & r_uop_lrs1 == 6'h0)
            | reset)) begin	// rename-stage.scala:118:27, :119:23, :221:25, :325:{12,13,59,71}
        if (`ASSERT_VERBOSE_COND_)	// rename-stage.scala:325:12
          $error("Assertion failed: [rename] x0 is busy??\n    at rename-stage.scala:325 assert (!(valid && busy.prs1_busy && rtype === RT_FIX && uop.lrs1 === 0.U), \"[rename] x0 is busy??\")\n");	// rename-stage.scala:325:12
        if (`STOP_COND_)	// rename-stage.scala:325:12
          $fatal;	// rename-stage.scala:325:12
      end
      if (~(~(r_valid & _busytable_io_busy_resps_0_prs2_busy & r_uop_lrs2 == 6'h0)
            | reset)) begin	// rename-stage.scala:118:27, :119:23, :221:25, :326:{12,13,59,71}
        if (`ASSERT_VERBOSE_COND_)	// rename-stage.scala:326:12
          $error("Assertion failed: [rename] x0 is busy??\n    at rename-stage.scala:326 assert (!(valid && busy.prs2_busy && rtype === RT_FIX && uop.lrs2 === 0.U), \"[rename] x0 is busy??\")\n");	// rename-stage.scala:326:12
        if (`STOP_COND_)	// rename-stage.scala:326:12
          $fatal;	// rename-stage.scala:326:12
      end
      if (~(~(r_valid_1 & _busytable_io_busy_resps_1_prs1_busy & r_uop_1_lrs1 == 6'h0)
            | reset)) begin	// rename-stage.scala:118:27, :119:23, :221:25, :325:{12,13,59,71}
        if (`ASSERT_VERBOSE_COND_)	// rename-stage.scala:325:12
          $error("Assertion failed: [rename] x0 is busy??\n    at rename-stage.scala:325 assert (!(valid && busy.prs1_busy && rtype === RT_FIX && uop.lrs1 === 0.U), \"[rename] x0 is busy??\")\n");	// rename-stage.scala:325:12
        if (`STOP_COND_)	// rename-stage.scala:325:12
          $fatal;	// rename-stage.scala:325:12
      end
      if (~(~(r_valid_1 & _busytable_io_busy_resps_1_prs2_busy & r_uop_1_lrs2 == 6'h0)
            | reset)) begin	// rename-stage.scala:118:27, :119:23, :221:25, :326:{12,13,59,71}
        if (`ASSERT_VERBOSE_COND_)	// rename-stage.scala:326:12
          $error("Assertion failed: [rename] x0 is busy??\n    at rename-stage.scala:326 assert (!(valid && busy.prs2_busy && rtype === RT_FIX && uop.lrs2 === 0.U), \"[rename] x0 is busy??\")\n");	// rename-stage.scala:326:12
        if (`STOP_COND_)	// rename-stage.scala:326:12
          $fatal;	// rename-stage.scala:326:12
      end
      if (~(~(r_valid_2 & _busytable_io_busy_resps_2_prs1_busy & r_uop_2_lrs1 == 6'h0)
            | reset)) begin	// rename-stage.scala:118:27, :119:23, :221:25, :325:{12,13,59,71}
        if (`ASSERT_VERBOSE_COND_)	// rename-stage.scala:325:12
          $error("Assertion failed: [rename] x0 is busy??\n    at rename-stage.scala:325 assert (!(valid && busy.prs1_busy && rtype === RT_FIX && uop.lrs1 === 0.U), \"[rename] x0 is busy??\")\n");	// rename-stage.scala:325:12
        if (`STOP_COND_)	// rename-stage.scala:325:12
          $fatal;	// rename-stage.scala:325:12
      end
      if (~(~(r_valid_2 & _busytable_io_busy_resps_2_prs2_busy & r_uop_2_lrs2 == 6'h0)
            | reset)) begin	// rename-stage.scala:118:27, :119:23, :221:25, :326:{12,13,59,71}
        if (`ASSERT_VERBOSE_COND_)	// rename-stage.scala:326:12
          $error("Assertion failed: [rename] x0 is busy??\n    at rename-stage.scala:326 assert (!(valid && busy.prs2_busy && rtype === RT_FIX && uop.lrs2 === 0.U), \"[rename] x0 is busy??\")\n");	// rename-stage.scala:326:12
        if (`STOP_COND_)	// rename-stage.scala:326:12
          $fatal;	// rename-stage.scala:326:12
      end
      if (~(~(r_valid_3 & _busytable_io_busy_resps_3_prs1_busy & r_uop_3_lrs1 == 6'h0)
            | reset)) begin	// rename-stage.scala:118:27, :119:23, :221:25, :325:{12,13,59,71}
        if (`ASSERT_VERBOSE_COND_)	// rename-stage.scala:325:12
          $error("Assertion failed: [rename] x0 is busy??\n    at rename-stage.scala:325 assert (!(valid && busy.prs1_busy && rtype === RT_FIX && uop.lrs1 === 0.U), \"[rename] x0 is busy??\")\n");	// rename-stage.scala:325:12
        if (`STOP_COND_)	// rename-stage.scala:325:12
          $fatal;	// rename-stage.scala:325:12
      end
      if (~(~(r_valid_3 & _busytable_io_busy_resps_3_prs2_busy & r_uop_3_lrs2 == 6'h0)
            | reset)) begin	// rename-stage.scala:118:27, :119:23, :221:25, :326:{12,13,59,71}
        if (`ASSERT_VERBOSE_COND_)	// rename-stage.scala:326:12
          $error("Assertion failed: [rename] x0 is busy??\n    at rename-stage.scala:326 assert (!(valid && busy.prs2_busy && rtype === RT_FIX && uop.lrs2 === 0.U), \"[rename] x0 is busy??\")\n");	// rename-stage.scala:326:12
        if (`STOP_COND_)	// rename-stage.scala:326:12
          $fatal;	// rename-stage.scala:326:12
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  wire        bypassed_uop_bypass_sel_rs1_0 =
    ren2_alloc_reqs_0 & r_uop_ldst == r_uop_1_lrs1;	// rename-stage.scala:119:23, :174:{77,87}, :237:88
  wire        bypassed_uop_bypass_sel_rs2_0 =
    ren2_alloc_reqs_0 & r_uop_ldst == r_uop_1_lrs2;	// rename-stage.scala:119:23, :175:{77,87}, :237:88
  wire        bypassed_uop_bypass_hits_rs1_0_1 =
    ren2_alloc_reqs_0 & r_uop_ldst == r_uop_2_lrs1;	// rename-stage.scala:119:23, :174:{77,87}, :237:88
  wire        bypassed_uop_bypass_hits_rs1_1 =
    ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_2_lrs1;	// rename-stage.scala:119:23, :174:{77,87}, :237:88
  wire        bypassed_uop_bypass_hits_rs2_0_1 =
    ren2_alloc_reqs_0 & r_uop_ldst == r_uop_2_lrs2;	// rename-stage.scala:119:23, :175:{77,87}, :237:88
  wire        bypassed_uop_bypass_hits_rs2_1 =
    ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_2_lrs2;	// rename-stage.scala:119:23, :175:{77,87}, :237:88
  wire        bypassed_uop_bypass_hits_dst_0_1 =
    ren2_alloc_reqs_0 & r_uop_ldst == r_uop_2_ldst;	// rename-stage.scala:119:23, :177:{77,87}, :237:88
  wire        bypassed_uop_bypass_hits_dst_1 =
    ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_2_ldst;	// rename-stage.scala:119:23, :177:{77,87}, :237:88
  wire [1:0]  bypassed_uop_bypass_sel_rs1_enc_1 =
    bypassed_uop_bypass_hits_rs1_1 ? 2'h1 : {bypassed_uop_bypass_hits_rs1_0_1, 1'h0};	// Mux.scala:47:69, rename-stage.scala:105:29, :174:77, :221:25
  wire [1:0]  bypassed_uop_bypass_sel_rs2_enc_1 =
    bypassed_uop_bypass_hits_rs2_1 ? 2'h1 : {bypassed_uop_bypass_hits_rs2_0_1, 1'h0};	// Mux.scala:47:69, rename-stage.scala:105:29, :175:77, :221:25
  wire [1:0]  bypassed_uop_bypass_sel_dst_enc_1 =
    bypassed_uop_bypass_hits_dst_1 ? 2'h1 : {bypassed_uop_bypass_hits_dst_0_1, 1'h0};	// Mux.scala:47:69, rename-stage.scala:105:29, :177:77, :221:25
  wire        bypassed_uop_do_bypass_rs1 =
    bypassed_uop_bypass_hits_rs1_0_1 | bypassed_uop_bypass_hits_rs1_1;	// rename-stage.scala:174:77, :184:49
  wire        bypassed_uop_do_bypass_rs2 =
    bypassed_uop_bypass_hits_rs2_0_1 | bypassed_uop_bypass_hits_rs2_1;	// rename-stage.scala:175:77, :185:49
  wire        bypassed_uop_bypass_hits_rs1_0_2 =
    ren2_alloc_reqs_0 & r_uop_ldst == r_uop_3_lrs1;	// rename-stage.scala:119:23, :174:{77,87}, :237:88
  wire        bypassed_uop_bypass_hits_rs1_1_1 =
    ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_3_lrs1;	// rename-stage.scala:119:23, :174:{77,87}, :237:88
  wire        bypassed_uop_bypass_hits_rs1_2 =
    ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_3_lrs1;	// rename-stage.scala:119:23, :174:{77,87}, :237:88
  wire        bypassed_uop_bypass_hits_rs2_0_2 =
    ren2_alloc_reqs_0 & r_uop_ldst == r_uop_3_lrs2;	// rename-stage.scala:119:23, :175:{77,87}, :237:88
  wire        bypassed_uop_bypass_hits_rs2_1_1 =
    ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_3_lrs2;	// rename-stage.scala:119:23, :175:{77,87}, :237:88
  wire        bypassed_uop_bypass_hits_rs2_2 =
    ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_3_lrs2;	// rename-stage.scala:119:23, :175:{77,87}, :237:88
  wire        bypassed_uop_bypass_hits_dst_0_2 =
    ren2_alloc_reqs_0 & r_uop_ldst == r_uop_3_ldst;	// rename-stage.scala:119:23, :177:{77,87}, :237:88
  wire        bypassed_uop_bypass_hits_dst_1_1 =
    ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_3_ldst;	// rename-stage.scala:119:23, :177:{77,87}, :237:88
  wire        bypassed_uop_bypass_hits_dst_2 =
    ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_3_ldst;	// rename-stage.scala:119:23, :177:{77,87}, :237:88
  wire [2:0]  bypassed_uop_bypass_sel_rs1_enc_2 =
    bypassed_uop_bypass_hits_rs1_2
      ? 3'h1
      : bypassed_uop_bypass_hits_rs1_1_1
          ? 3'h2
          : {bypassed_uop_bypass_hits_rs1_0_2, 2'h0};	// Mux.scala:47:69, rename-stage.scala:174:77, :237:78
  wire [2:0]  bypassed_uop_bypass_sel_rs2_enc_2 =
    bypassed_uop_bypass_hits_rs2_2
      ? 3'h1
      : bypassed_uop_bypass_hits_rs2_1_1
          ? 3'h2
          : {bypassed_uop_bypass_hits_rs2_0_2, 2'h0};	// Mux.scala:47:69, rename-stage.scala:175:77, :237:78
  wire [2:0]  bypassed_uop_bypass_sel_dst_enc_2 =
    bypassed_uop_bypass_hits_dst_2
      ? 3'h1
      : bypassed_uop_bypass_hits_dst_1_1
          ? 3'h2
          : {bypassed_uop_bypass_hits_dst_0_2, 2'h0};	// Mux.scala:47:69, rename-stage.scala:177:77, :237:78
  wire        bypassed_uop_do_bypass_rs1_1 =
    bypassed_uop_bypass_hits_rs1_0_2 | bypassed_uop_bypass_hits_rs1_1_1
    | bypassed_uop_bypass_hits_rs1_2;	// rename-stage.scala:174:77, :184:49
  wire        bypassed_uop_do_bypass_rs2_1 =
    bypassed_uop_bypass_hits_rs2_0_2 | bypassed_uop_bypass_hits_rs2_1_1
    | bypassed_uop_bypass_hits_rs2_2;	// rename-stage.scala:175:77, :185:49
  always @(posedge clock) begin
    automatic logic       _GEN;	// rename-stage.scala:122:14, :124:20, :126:30
    automatic logic [5:0] r_uop_newuop_lrs2;	// rename-stage.scala:122:14, :124:20, :126:30
    automatic logic [5:0] r_uop_newuop_lrs1;	// rename-stage.scala:122:14, :124:20, :126:30
    automatic logic [5:0] r_uop_newuop_ldst;	// rename-stage.scala:122:14, :124:20, :126:30
    automatic logic       r_uop_bypass_hits_rs1_0;	// rename-stage.scala:174:77
    automatic logic       r_uop_bypass_hits_rs1_1;	// rename-stage.scala:174:77
    automatic logic       r_uop_bypass_hits_rs1_2;	// rename-stage.scala:174:77
    automatic logic       r_uop_bypass_hits_rs1_3;	// rename-stage.scala:174:77
    automatic logic       r_uop_bypass_hits_rs2_0;	// rename-stage.scala:175:77
    automatic logic       r_uop_bypass_hits_rs2_1;	// rename-stage.scala:175:77
    automatic logic       r_uop_bypass_hits_rs2_2;	// rename-stage.scala:175:77
    automatic logic       r_uop_bypass_hits_rs2_3;	// rename-stage.scala:175:77
    automatic logic       r_uop_bypass_hits_dst_0;	// rename-stage.scala:177:77
    automatic logic       r_uop_bypass_hits_dst_1;	// rename-stage.scala:177:77
    automatic logic       r_uop_bypass_hits_dst_2;	// rename-stage.scala:177:77
    automatic logic       r_uop_bypass_hits_dst_3;	// rename-stage.scala:177:77
    automatic logic [5:0] r_uop_newuop_1_lrs2;	// rename-stage.scala:122:14, :124:20, :126:30
    automatic logic [5:0] r_uop_newuop_1_lrs1;	// rename-stage.scala:122:14, :124:20, :126:30
    automatic logic [5:0] r_uop_newuop_1_ldst;	// rename-stage.scala:122:14, :124:20, :126:30
    automatic logic       r_uop_bypass_hits_rs1_0_1;	// rename-stage.scala:174:77
    automatic logic       r_uop_bypass_hits_rs1_1_1;	// rename-stage.scala:174:77
    automatic logic       r_uop_bypass_hits_rs1_2_1;	// rename-stage.scala:174:77
    automatic logic       r_uop_bypass_hits_rs1_3_1;	// rename-stage.scala:174:77
    automatic logic       r_uop_bypass_hits_rs2_0_1;	// rename-stage.scala:175:77
    automatic logic       r_uop_bypass_hits_rs2_1_1;	// rename-stage.scala:175:77
    automatic logic       r_uop_bypass_hits_rs2_2_1;	// rename-stage.scala:175:77
    automatic logic       r_uop_bypass_hits_rs2_3_1;	// rename-stage.scala:175:77
    automatic logic       r_uop_bypass_hits_dst_0_1;	// rename-stage.scala:177:77
    automatic logic       r_uop_bypass_hits_dst_1_1;	// rename-stage.scala:177:77
    automatic logic       r_uop_bypass_hits_dst_2_1;	// rename-stage.scala:177:77
    automatic logic       r_uop_bypass_hits_dst_3_1;	// rename-stage.scala:177:77
    automatic logic [5:0] r_uop_newuop_2_lrs2;	// rename-stage.scala:122:14, :124:20, :126:30
    automatic logic [5:0] r_uop_newuop_2_lrs1;	// rename-stage.scala:122:14, :124:20, :126:30
    automatic logic [5:0] r_uop_newuop_2_ldst;	// rename-stage.scala:122:14, :124:20, :126:30
    automatic logic       r_uop_bypass_hits_rs1_0_2;	// rename-stage.scala:174:77
    automatic logic       r_uop_bypass_hits_rs1_1_2;	// rename-stage.scala:174:77
    automatic logic       r_uop_bypass_hits_rs1_2_2;	// rename-stage.scala:174:77
    automatic logic       r_uop_bypass_hits_rs1_3_2;	// rename-stage.scala:174:77
    automatic logic       r_uop_bypass_hits_rs2_0_2;	// rename-stage.scala:175:77
    automatic logic       r_uop_bypass_hits_rs2_1_2;	// rename-stage.scala:175:77
    automatic logic       r_uop_bypass_hits_rs2_2_2;	// rename-stage.scala:175:77
    automatic logic       r_uop_bypass_hits_rs2_3_2;	// rename-stage.scala:175:77
    automatic logic       r_uop_bypass_hits_dst_0_2;	// rename-stage.scala:177:77
    automatic logic       r_uop_bypass_hits_dst_1_2;	// rename-stage.scala:177:77
    automatic logic       r_uop_bypass_hits_dst_2_2;	// rename-stage.scala:177:77
    automatic logic       r_uop_bypass_hits_dst_3_2;	// rename-stage.scala:177:77
    automatic logic [5:0] r_uop_newuop_3_lrs2;	// rename-stage.scala:122:14, :124:20, :126:30
    automatic logic [5:0] r_uop_newuop_3_lrs1;	// rename-stage.scala:122:14, :124:20, :126:30
    automatic logic [5:0] r_uop_newuop_3_ldst;	// rename-stage.scala:122:14, :124:20, :126:30
    automatic logic       r_uop_bypass_hits_rs1_0_3;	// rename-stage.scala:174:77
    automatic logic       r_uop_bypass_hits_rs1_1_3;	// rename-stage.scala:174:77
    automatic logic       r_uop_bypass_hits_rs1_2_3;	// rename-stage.scala:174:77
    automatic logic       r_uop_bypass_hits_rs1_3_3;	// rename-stage.scala:174:77
    automatic logic       r_uop_bypass_hits_rs2_0_3;	// rename-stage.scala:175:77
    automatic logic       r_uop_bypass_hits_rs2_1_3;	// rename-stage.scala:175:77
    automatic logic       r_uop_bypass_hits_rs2_2_3;	// rename-stage.scala:175:77
    automatic logic       r_uop_bypass_hits_rs2_3_3;	// rename-stage.scala:175:77
    automatic logic       r_uop_bypass_hits_dst_0_3;	// rename-stage.scala:177:77
    automatic logic       r_uop_bypass_hits_dst_1_3;	// rename-stage.scala:177:77
    automatic logic       r_uop_bypass_hits_dst_2_3;	// rename-stage.scala:177:77
    automatic logic       r_uop_bypass_hits_dst_3_3;	// rename-stage.scala:177:77
    _GEN = io_kill | ~io_dis_ready;	// rename-stage.scala:122:14, :124:20, :126:30
    r_uop_newuop_lrs2 = _GEN ? r_uop_lrs2 : io_dec_uops_0_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30
    r_uop_newuop_lrs1 = _GEN ? r_uop_lrs1 : io_dec_uops_0_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30
    r_uop_newuop_ldst = _GEN ? r_uop_ldst : io_dec_uops_0_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30
    r_uop_bypass_hits_rs1_0 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_newuop_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :174:{77,87}, :237:88
    r_uop_bypass_hits_rs1_1 = ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_newuop_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :174:{77,87}, :237:88
    r_uop_bypass_hits_rs1_2 = ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_newuop_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :174:{77,87}, :237:88
    r_uop_bypass_hits_rs1_3 = ren2_alloc_reqs_3 & r_uop_3_ldst == r_uop_newuop_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :174:{77,87}, :237:88
    r_uop_bypass_hits_rs2_0 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_newuop_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :175:{77,87}, :237:88
    r_uop_bypass_hits_rs2_1 = ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_newuop_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :175:{77,87}, :237:88
    r_uop_bypass_hits_rs2_2 = ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_newuop_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :175:{77,87}, :237:88
    r_uop_bypass_hits_rs2_3 = ren2_alloc_reqs_3 & r_uop_3_ldst == r_uop_newuop_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :175:{77,87}, :237:88
    r_uop_bypass_hits_dst_0 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_newuop_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :177:{77,87}, :237:88
    r_uop_bypass_hits_dst_1 = ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_newuop_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :177:{77,87}, :237:88
    r_uop_bypass_hits_dst_2 = ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_newuop_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :177:{77,87}, :237:88
    r_uop_bypass_hits_dst_3 = ren2_alloc_reqs_3 & r_uop_3_ldst == r_uop_newuop_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :177:{77,87}, :237:88
    r_uop_newuop_1_lrs2 = _GEN ? r_uop_1_lrs2 : io_dec_uops_1_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30
    r_uop_newuop_1_lrs1 = _GEN ? r_uop_1_lrs1 : io_dec_uops_1_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30
    r_uop_newuop_1_ldst = _GEN ? r_uop_1_ldst : io_dec_uops_1_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30
    r_uop_bypass_hits_rs1_0_1 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_newuop_1_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :174:{77,87}, :237:88
    r_uop_bypass_hits_rs1_1_1 = ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_newuop_1_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :174:{77,87}, :237:88
    r_uop_bypass_hits_rs1_2_1 = ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_newuop_1_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :174:{77,87}, :237:88
    r_uop_bypass_hits_rs1_3_1 = ren2_alloc_reqs_3 & r_uop_3_ldst == r_uop_newuop_1_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :174:{77,87}, :237:88
    r_uop_bypass_hits_rs2_0_1 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_newuop_1_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :175:{77,87}, :237:88
    r_uop_bypass_hits_rs2_1_1 = ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_newuop_1_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :175:{77,87}, :237:88
    r_uop_bypass_hits_rs2_2_1 = ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_newuop_1_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :175:{77,87}, :237:88
    r_uop_bypass_hits_rs2_3_1 = ren2_alloc_reqs_3 & r_uop_3_ldst == r_uop_newuop_1_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :175:{77,87}, :237:88
    r_uop_bypass_hits_dst_0_1 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_newuop_1_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :177:{77,87}, :237:88
    r_uop_bypass_hits_dst_1_1 = ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_newuop_1_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :177:{77,87}, :237:88
    r_uop_bypass_hits_dst_2_1 = ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_newuop_1_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :177:{77,87}, :237:88
    r_uop_bypass_hits_dst_3_1 = ren2_alloc_reqs_3 & r_uop_3_ldst == r_uop_newuop_1_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :177:{77,87}, :237:88
    r_uop_newuop_2_lrs2 = _GEN ? r_uop_2_lrs2 : io_dec_uops_2_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30
    r_uop_newuop_2_lrs1 = _GEN ? r_uop_2_lrs1 : io_dec_uops_2_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30
    r_uop_newuop_2_ldst = _GEN ? r_uop_2_ldst : io_dec_uops_2_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30
    r_uop_bypass_hits_rs1_0_2 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_newuop_2_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :174:{77,87}, :237:88
    r_uop_bypass_hits_rs1_1_2 = ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_newuop_2_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :174:{77,87}, :237:88
    r_uop_bypass_hits_rs1_2_2 = ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_newuop_2_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :174:{77,87}, :237:88
    r_uop_bypass_hits_rs1_3_2 = ren2_alloc_reqs_3 & r_uop_3_ldst == r_uop_newuop_2_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :174:{77,87}, :237:88
    r_uop_bypass_hits_rs2_0_2 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_newuop_2_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :175:{77,87}, :237:88
    r_uop_bypass_hits_rs2_1_2 = ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_newuop_2_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :175:{77,87}, :237:88
    r_uop_bypass_hits_rs2_2_2 = ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_newuop_2_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :175:{77,87}, :237:88
    r_uop_bypass_hits_rs2_3_2 = ren2_alloc_reqs_3 & r_uop_3_ldst == r_uop_newuop_2_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :175:{77,87}, :237:88
    r_uop_bypass_hits_dst_0_2 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_newuop_2_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :177:{77,87}, :237:88
    r_uop_bypass_hits_dst_1_2 = ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_newuop_2_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :177:{77,87}, :237:88
    r_uop_bypass_hits_dst_2_2 = ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_newuop_2_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :177:{77,87}, :237:88
    r_uop_bypass_hits_dst_3_2 = ren2_alloc_reqs_3 & r_uop_3_ldst == r_uop_newuop_2_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :177:{77,87}, :237:88
    r_uop_newuop_3_lrs2 = _GEN ? r_uop_3_lrs2 : io_dec_uops_3_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30
    r_uop_newuop_3_lrs1 = _GEN ? r_uop_3_lrs1 : io_dec_uops_3_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30
    r_uop_newuop_3_ldst = _GEN ? r_uop_3_ldst : io_dec_uops_3_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30
    r_uop_bypass_hits_rs1_0_3 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_newuop_3_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :174:{77,87}, :237:88
    r_uop_bypass_hits_rs1_1_3 = ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_newuop_3_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :174:{77,87}, :237:88
    r_uop_bypass_hits_rs1_2_3 = ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_newuop_3_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :174:{77,87}, :237:88
    r_uop_bypass_hits_rs1_3_3 = ren2_alloc_reqs_3 & r_uop_3_ldst == r_uop_newuop_3_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :174:{77,87}, :237:88
    r_uop_bypass_hits_rs2_0_3 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_newuop_3_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :175:{77,87}, :237:88
    r_uop_bypass_hits_rs2_1_3 = ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_newuop_3_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :175:{77,87}, :237:88
    r_uop_bypass_hits_rs2_2_3 = ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_newuop_3_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :175:{77,87}, :237:88
    r_uop_bypass_hits_rs2_3_3 = ren2_alloc_reqs_3 & r_uop_3_ldst == r_uop_newuop_3_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :175:{77,87}, :237:88
    r_uop_bypass_hits_dst_0_3 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_newuop_3_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :177:{77,87}, :237:88
    r_uop_bypass_hits_dst_1_3 = ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_newuop_3_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :177:{77,87}, :237:88
    r_uop_bypass_hits_dst_2_3 = ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_newuop_3_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :177:{77,87}, :237:88
    r_uop_bypass_hits_dst_3_3 = ren2_alloc_reqs_3 & r_uop_3_ldst == r_uop_newuop_3_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :177:{77,87}, :237:88
    if (reset) begin
      r_valid <= 1'h0;	// rename-stage.scala:105:29, :118:27, :221:25
      r_valid_1 <= 1'h0;	// rename-stage.scala:105:29, :118:27, :221:25
      r_valid_2 <= 1'h0;	// rename-stage.scala:105:29, :118:27, :221:25
      r_valid_3 <= 1'h0;	// rename-stage.scala:105:29, :118:27, :221:25
    end
    else begin
      r_valid <= ~io_kill & (io_dis_ready ? io_dec_fire_0 : r_valid & ~io_dis_fire_0);	// rename-stage.scala:118:27, :124:20, :125:15, :126:30, :127:15, :130:{15,26,29}
      r_valid_1 <= ~io_kill & (io_dis_ready ? io_dec_fire_1 : r_valid_1 & ~io_dis_fire_1);	// rename-stage.scala:118:27, :124:20, :125:15, :126:30, :127:15, :130:{15,26,29}
      r_valid_2 <= ~io_kill & (io_dis_ready ? io_dec_fire_2 : r_valid_2 & ~io_dis_fire_2);	// rename-stage.scala:118:27, :124:20, :125:15, :126:30, :127:15, :130:{15,26,29}
      r_valid_3 <= ~io_kill & (io_dis_ready ? io_dec_fire_3 : r_valid_3 & ~io_dis_fire_3);	// rename-stage.scala:118:27, :124:20, :125:15, :126:30, :127:15, :130:{15,26,29}
    end
    if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else begin	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_uopc <= io_dec_uops_0_uopc;	// rename-stage.scala:119:23
      r_uop_inst <= io_dec_uops_0_inst;	// rename-stage.scala:119:23
      r_uop_debug_inst <= io_dec_uops_0_debug_inst;	// rename-stage.scala:119:23
      r_uop_is_rvc <= io_dec_uops_0_is_rvc;	// rename-stage.scala:119:23
      r_uop_debug_pc <= io_dec_uops_0_debug_pc;	// rename-stage.scala:119:23
      r_uop_iq_type <= io_dec_uops_0_iq_type;	// rename-stage.scala:119:23
      r_uop_fu_code <= io_dec_uops_0_fu_code;	// rename-stage.scala:119:23
      r_uop_ctrl_br_type <= io_dec_uops_0_ctrl_br_type;	// rename-stage.scala:119:23
      r_uop_ctrl_op1_sel <= io_dec_uops_0_ctrl_op1_sel;	// rename-stage.scala:119:23
      r_uop_ctrl_op2_sel <= io_dec_uops_0_ctrl_op2_sel;	// rename-stage.scala:119:23
      r_uop_ctrl_imm_sel <= io_dec_uops_0_ctrl_imm_sel;	// rename-stage.scala:119:23
      r_uop_ctrl_op_fcn <= io_dec_uops_0_ctrl_op_fcn;	// rename-stage.scala:119:23
      r_uop_ctrl_fcn_dw <= io_dec_uops_0_ctrl_fcn_dw;	// rename-stage.scala:119:23
      r_uop_ctrl_csr_cmd <= io_dec_uops_0_ctrl_csr_cmd;	// rename-stage.scala:119:23
      r_uop_ctrl_is_load <= io_dec_uops_0_ctrl_is_load;	// rename-stage.scala:119:23
      r_uop_ctrl_is_sta <= io_dec_uops_0_ctrl_is_sta;	// rename-stage.scala:119:23
      r_uop_ctrl_is_std <= io_dec_uops_0_ctrl_is_std;	// rename-stage.scala:119:23
      r_uop_iw_state <= io_dec_uops_0_iw_state;	// rename-stage.scala:119:23
      r_uop_iw_p1_poisoned <= io_dec_uops_0_iw_p1_poisoned;	// rename-stage.scala:119:23
      r_uop_iw_p2_poisoned <= io_dec_uops_0_iw_p2_poisoned;	// rename-stage.scala:119:23
      r_uop_is_br <= io_dec_uops_0_is_br;	// rename-stage.scala:119:23
      r_uop_is_jalr <= io_dec_uops_0_is_jalr;	// rename-stage.scala:119:23
      r_uop_is_jal <= io_dec_uops_0_is_jal;	// rename-stage.scala:119:23
      r_uop_is_sfb <= io_dec_uops_0_is_sfb;	// rename-stage.scala:119:23
    end
    r_uop_br_mask <=
      (_GEN ? r_uop_br_mask : io_dec_uops_0_br_mask) & ~io_brupdate_b1_resolve_mask;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, util.scala:74:{35,37}
    if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else begin	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_br_tag <= io_dec_uops_0_br_tag;	// rename-stage.scala:119:23
      r_uop_ftq_idx <= io_dec_uops_0_ftq_idx;	// rename-stage.scala:119:23
      r_uop_edge_inst <= io_dec_uops_0_edge_inst;	// rename-stage.scala:119:23
      r_uop_pc_lob <= io_dec_uops_0_pc_lob;	// rename-stage.scala:119:23
      r_uop_taken <= io_dec_uops_0_taken;	// rename-stage.scala:119:23
      r_uop_imm_packed <= io_dec_uops_0_imm_packed;	// rename-stage.scala:119:23
      r_uop_csr_addr <= io_dec_uops_0_csr_addr;	// rename-stage.scala:119:23
      r_uop_rxq_idx <= io_dec_uops_0_rxq_idx;	// rename-stage.scala:119:23
    end
    if (r_uop_bypass_hits_rs1_0 | r_uop_bypass_hits_rs1_1 | r_uop_bypass_hits_rs1_2
        | r_uop_bypass_hits_rs1_3) begin	// rename-stage.scala:174:77, :184:49
      automatic logic [3:0] r_uop_bypass_sel_rs1_enc;	// Mux.scala:47:69
      r_uop_bypass_sel_rs1_enc =
        r_uop_bypass_hits_rs1_3
          ? 4'h1
          : r_uop_bypass_hits_rs1_2
              ? 4'h2
              : r_uop_bypass_hits_rs1_1 ? 4'h4 : {r_uop_bypass_hits_rs1_0, 3'h0};	// Mux.scala:47:69, rename-stage.scala:174:77
      r_uop_prs1 <=
        (r_uop_bypass_sel_rs1_enc[3] & (|r_uop_ldst)
           ? _freelist_io_alloc_pregs_0_bits
           : 7'h0)
        | (r_uop_bypass_sel_rs1_enc[2] & (|r_uop_1_ldst)
             ? _freelist_io_alloc_pregs_1_bits
             : 7'h0)
        | (r_uop_bypass_sel_rs1_enc[1] & (|r_uop_2_ldst)
             ? _freelist_io_alloc_pregs_2_bits
             : 7'h0)
        | (r_uop_bypass_sel_rs1_enc[0] & (|r_uop_3_ldst)
             ? _freelist_io_alloc_pregs_3_bits
             : 7'h0);	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :201:30, :217:24, :303:30
    end
    else if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_prs1 <= _maptable_io_map_resps_0_prs1;	// rename-stage.scala:119:23, :211:24
    if (r_uop_bypass_hits_rs2_0 | r_uop_bypass_hits_rs2_1 | r_uop_bypass_hits_rs2_2
        | r_uop_bypass_hits_rs2_3) begin	// rename-stage.scala:175:77, :185:49
      automatic logic [3:0] r_uop_bypass_sel_rs2_enc;	// Mux.scala:47:69
      r_uop_bypass_sel_rs2_enc =
        r_uop_bypass_hits_rs2_3
          ? 4'h1
          : r_uop_bypass_hits_rs2_2
              ? 4'h2
              : r_uop_bypass_hits_rs2_1 ? 4'h4 : {r_uop_bypass_hits_rs2_0, 3'h0};	// Mux.scala:47:69, rename-stage.scala:175:77
      r_uop_prs2 <=
        (r_uop_bypass_sel_rs2_enc[3] & (|r_uop_ldst)
           ? _freelist_io_alloc_pregs_0_bits
           : 7'h0)
        | (r_uop_bypass_sel_rs2_enc[2] & (|r_uop_1_ldst)
             ? _freelist_io_alloc_pregs_1_bits
             : 7'h0)
        | (r_uop_bypass_sel_rs2_enc[1] & (|r_uop_2_ldst)
             ? _freelist_io_alloc_pregs_2_bits
             : 7'h0)
        | (r_uop_bypass_sel_rs2_enc[0] & (|r_uop_3_ldst)
             ? _freelist_io_alloc_pregs_3_bits
             : 7'h0);	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :201:30, :217:24, :303:30
    end
    else if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_prs2 <= _maptable_io_map_resps_0_prs2;	// rename-stage.scala:119:23, :211:24
    if (r_uop_bypass_hits_dst_0 | r_uop_bypass_hits_dst_1 | r_uop_bypass_hits_dst_2
        | r_uop_bypass_hits_dst_3) begin	// rename-stage.scala:177:77, :187:49
      automatic logic [3:0] r_uop_bypass_sel_dst_enc;	// Mux.scala:47:69
      r_uop_bypass_sel_dst_enc =
        r_uop_bypass_hits_dst_3
          ? 4'h1
          : r_uop_bypass_hits_dst_2
              ? 4'h2
              : r_uop_bypass_hits_dst_1 ? 4'h4 : {r_uop_bypass_hits_dst_0, 3'h0};	// Mux.scala:47:69, rename-stage.scala:177:77
      r_uop_stale_pdst <=
        (r_uop_bypass_sel_dst_enc[3] & (|r_uop_ldst)
           ? _freelist_io_alloc_pregs_0_bits
           : 7'h0)
        | (r_uop_bypass_sel_dst_enc[2] & (|r_uop_1_ldst)
             ? _freelist_io_alloc_pregs_1_bits
             : 7'h0)
        | (r_uop_bypass_sel_dst_enc[1] & (|r_uop_2_ldst)
             ? _freelist_io_alloc_pregs_2_bits
             : 7'h0)
        | (r_uop_bypass_sel_dst_enc[0] & (|r_uop_3_ldst)
             ? _freelist_io_alloc_pregs_3_bits
             : 7'h0);	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :201:30, :217:24, :303:30
    end
    else if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_stale_pdst <= _maptable_io_map_resps_0_stale_pdst;	// rename-stage.scala:119:23, :211:24
    if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else begin	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_exception <= io_dec_uops_0_exception;	// rename-stage.scala:119:23
      r_uop_exc_cause <= io_dec_uops_0_exc_cause;	// rename-stage.scala:119:23
      r_uop_bypassable <= io_dec_uops_0_bypassable;	// rename-stage.scala:119:23
      r_uop_mem_cmd <= io_dec_uops_0_mem_cmd;	// rename-stage.scala:119:23
      r_uop_mem_size <= io_dec_uops_0_mem_size;	// rename-stage.scala:119:23
      r_uop_mem_signed <= io_dec_uops_0_mem_signed;	// rename-stage.scala:119:23
      r_uop_is_fence <= io_dec_uops_0_is_fence;	// rename-stage.scala:119:23
      r_uop_is_fencei <= io_dec_uops_0_is_fencei;	// rename-stage.scala:119:23
      r_uop_is_amo <= io_dec_uops_0_is_amo;	// rename-stage.scala:119:23
      r_uop_uses_ldq <= io_dec_uops_0_uses_ldq;	// rename-stage.scala:119:23
      r_uop_uses_stq <= io_dec_uops_0_uses_stq;	// rename-stage.scala:119:23
      r_uop_is_sys_pc2epc <= io_dec_uops_0_is_sys_pc2epc;	// rename-stage.scala:119:23
      r_uop_is_unique <= io_dec_uops_0_is_unique;	// rename-stage.scala:119:23
      r_uop_flush_on_commit <= io_dec_uops_0_flush_on_commit;	// rename-stage.scala:119:23
    end
    r_uop_ldst_is_rs1 <= _GEN & r_uop_ldst_is_rs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30
    if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else begin	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_ldst <= io_dec_uops_0_ldst;	// rename-stage.scala:119:23
      r_uop_lrs1 <= io_dec_uops_0_lrs1;	// rename-stage.scala:119:23
      r_uop_lrs2 <= io_dec_uops_0_lrs2;	// rename-stage.scala:119:23
      r_uop_lrs3 <= io_dec_uops_0_lrs3;	// rename-stage.scala:119:23
      r_uop_ldst_val <= io_dec_uops_0_ldst_val;	// rename-stage.scala:119:23
      r_uop_dst_rtype <= io_dec_uops_0_dst_rtype;	// rename-stage.scala:119:23
      r_uop_lrs1_rtype <= io_dec_uops_0_lrs1_rtype;	// rename-stage.scala:119:23
      r_uop_lrs2_rtype <= io_dec_uops_0_lrs2_rtype;	// rename-stage.scala:119:23
      r_uop_frs3_en <= io_dec_uops_0_frs3_en;	// rename-stage.scala:119:23
      r_uop_fp_val <= io_dec_uops_0_fp_val;	// rename-stage.scala:119:23
      r_uop_fp_single <= io_dec_uops_0_fp_single;	// rename-stage.scala:119:23
      r_uop_xcpt_pf_if <= io_dec_uops_0_xcpt_pf_if;	// rename-stage.scala:119:23
      r_uop_xcpt_ae_if <= io_dec_uops_0_xcpt_ae_if;	// rename-stage.scala:119:23
      r_uop_xcpt_ma_if <= io_dec_uops_0_xcpt_ma_if;	// rename-stage.scala:119:23
      r_uop_bp_debug_if <= io_dec_uops_0_bp_debug_if;	// rename-stage.scala:119:23
      r_uop_bp_xcpt_if <= io_dec_uops_0_bp_xcpt_if;	// rename-stage.scala:119:23
      r_uop_debug_fsrc <= io_dec_uops_0_debug_fsrc;	// rename-stage.scala:119:23
      r_uop_debug_tsrc <= io_dec_uops_0_debug_tsrc;	// rename-stage.scala:119:23
      r_uop_1_uopc <= io_dec_uops_1_uopc;	// rename-stage.scala:119:23
      r_uop_1_inst <= io_dec_uops_1_inst;	// rename-stage.scala:119:23
      r_uop_1_debug_inst <= io_dec_uops_1_debug_inst;	// rename-stage.scala:119:23
      r_uop_1_is_rvc <= io_dec_uops_1_is_rvc;	// rename-stage.scala:119:23
      r_uop_1_debug_pc <= io_dec_uops_1_debug_pc;	// rename-stage.scala:119:23
      r_uop_1_iq_type <= io_dec_uops_1_iq_type;	// rename-stage.scala:119:23
      r_uop_1_fu_code <= io_dec_uops_1_fu_code;	// rename-stage.scala:119:23
      r_uop_1_ctrl_br_type <= io_dec_uops_1_ctrl_br_type;	// rename-stage.scala:119:23
      r_uop_1_ctrl_op1_sel <= io_dec_uops_1_ctrl_op1_sel;	// rename-stage.scala:119:23
      r_uop_1_ctrl_op2_sel <= io_dec_uops_1_ctrl_op2_sel;	// rename-stage.scala:119:23
      r_uop_1_ctrl_imm_sel <= io_dec_uops_1_ctrl_imm_sel;	// rename-stage.scala:119:23
      r_uop_1_ctrl_op_fcn <= io_dec_uops_1_ctrl_op_fcn;	// rename-stage.scala:119:23
      r_uop_1_ctrl_fcn_dw <= io_dec_uops_1_ctrl_fcn_dw;	// rename-stage.scala:119:23
      r_uop_1_ctrl_csr_cmd <= io_dec_uops_1_ctrl_csr_cmd;	// rename-stage.scala:119:23
      r_uop_1_ctrl_is_load <= io_dec_uops_1_ctrl_is_load;	// rename-stage.scala:119:23
      r_uop_1_ctrl_is_sta <= io_dec_uops_1_ctrl_is_sta;	// rename-stage.scala:119:23
      r_uop_1_ctrl_is_std <= io_dec_uops_1_ctrl_is_std;	// rename-stage.scala:119:23
      r_uop_1_iw_state <= io_dec_uops_1_iw_state;	// rename-stage.scala:119:23
      r_uop_1_iw_p1_poisoned <= io_dec_uops_1_iw_p1_poisoned;	// rename-stage.scala:119:23
      r_uop_1_iw_p2_poisoned <= io_dec_uops_1_iw_p2_poisoned;	// rename-stage.scala:119:23
      r_uop_1_is_br <= io_dec_uops_1_is_br;	// rename-stage.scala:119:23
      r_uop_1_is_jalr <= io_dec_uops_1_is_jalr;	// rename-stage.scala:119:23
      r_uop_1_is_jal <= io_dec_uops_1_is_jal;	// rename-stage.scala:119:23
      r_uop_1_is_sfb <= io_dec_uops_1_is_sfb;	// rename-stage.scala:119:23
    end
    r_uop_1_br_mask <=
      (_GEN ? r_uop_1_br_mask : io_dec_uops_1_br_mask) & ~io_brupdate_b1_resolve_mask;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, util.scala:74:{35,37}
    if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else begin	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_1_br_tag <= io_dec_uops_1_br_tag;	// rename-stage.scala:119:23
      r_uop_1_ftq_idx <= io_dec_uops_1_ftq_idx;	// rename-stage.scala:119:23
      r_uop_1_edge_inst <= io_dec_uops_1_edge_inst;	// rename-stage.scala:119:23
      r_uop_1_pc_lob <= io_dec_uops_1_pc_lob;	// rename-stage.scala:119:23
      r_uop_1_taken <= io_dec_uops_1_taken;	// rename-stage.scala:119:23
      r_uop_1_imm_packed <= io_dec_uops_1_imm_packed;	// rename-stage.scala:119:23
      r_uop_1_csr_addr <= io_dec_uops_1_csr_addr;	// rename-stage.scala:119:23
      r_uop_1_rxq_idx <= io_dec_uops_1_rxq_idx;	// rename-stage.scala:119:23
    end
    if (r_uop_bypass_hits_rs1_0_1 | r_uop_bypass_hits_rs1_1_1 | r_uop_bypass_hits_rs1_2_1
        | r_uop_bypass_hits_rs1_3_1) begin	// rename-stage.scala:174:77, :184:49
      automatic logic [3:0] r_uop_bypass_sel_rs1_enc_1;	// Mux.scala:47:69
      r_uop_bypass_sel_rs1_enc_1 =
        r_uop_bypass_hits_rs1_3_1
          ? 4'h1
          : r_uop_bypass_hits_rs1_2_1
              ? 4'h2
              : r_uop_bypass_hits_rs1_1_1 ? 4'h4 : {r_uop_bypass_hits_rs1_0_1, 3'h0};	// Mux.scala:47:69, rename-stage.scala:174:77
      r_uop_1_prs1 <=
        (r_uop_bypass_sel_rs1_enc_1[3] & (|r_uop_ldst)
           ? _freelist_io_alloc_pregs_0_bits
           : 7'h0)
        | (r_uop_bypass_sel_rs1_enc_1[2] & (|r_uop_1_ldst)
             ? _freelist_io_alloc_pregs_1_bits
             : 7'h0)
        | (r_uop_bypass_sel_rs1_enc_1[1] & (|r_uop_2_ldst)
             ? _freelist_io_alloc_pregs_2_bits
             : 7'h0)
        | (r_uop_bypass_sel_rs1_enc_1[0] & (|r_uop_3_ldst)
             ? _freelist_io_alloc_pregs_3_bits
             : 7'h0);	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :201:30, :217:24, :303:30
    end
    else if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_1_prs1 <= _maptable_io_map_resps_1_prs1;	// rename-stage.scala:119:23, :211:24
    if (r_uop_bypass_hits_rs2_0_1 | r_uop_bypass_hits_rs2_1_1 | r_uop_bypass_hits_rs2_2_1
        | r_uop_bypass_hits_rs2_3_1) begin	// rename-stage.scala:175:77, :185:49
      automatic logic [3:0] r_uop_bypass_sel_rs2_enc_1;	// Mux.scala:47:69
      r_uop_bypass_sel_rs2_enc_1 =
        r_uop_bypass_hits_rs2_3_1
          ? 4'h1
          : r_uop_bypass_hits_rs2_2_1
              ? 4'h2
              : r_uop_bypass_hits_rs2_1_1 ? 4'h4 : {r_uop_bypass_hits_rs2_0_1, 3'h0};	// Mux.scala:47:69, rename-stage.scala:175:77
      r_uop_1_prs2 <=
        (r_uop_bypass_sel_rs2_enc_1[3] & (|r_uop_ldst)
           ? _freelist_io_alloc_pregs_0_bits
           : 7'h0)
        | (r_uop_bypass_sel_rs2_enc_1[2] & (|r_uop_1_ldst)
             ? _freelist_io_alloc_pregs_1_bits
             : 7'h0)
        | (r_uop_bypass_sel_rs2_enc_1[1] & (|r_uop_2_ldst)
             ? _freelist_io_alloc_pregs_2_bits
             : 7'h0)
        | (r_uop_bypass_sel_rs2_enc_1[0] & (|r_uop_3_ldst)
             ? _freelist_io_alloc_pregs_3_bits
             : 7'h0);	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :201:30, :217:24, :303:30
    end
    else if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_1_prs2 <= _maptable_io_map_resps_1_prs2;	// rename-stage.scala:119:23, :211:24
    if (r_uop_bypass_hits_dst_0_1 | r_uop_bypass_hits_dst_1_1 | r_uop_bypass_hits_dst_2_1
        | r_uop_bypass_hits_dst_3_1) begin	// rename-stage.scala:177:77, :187:49
      automatic logic [3:0] r_uop_bypass_sel_dst_enc_1;	// Mux.scala:47:69
      r_uop_bypass_sel_dst_enc_1 =
        r_uop_bypass_hits_dst_3_1
          ? 4'h1
          : r_uop_bypass_hits_dst_2_1
              ? 4'h2
              : r_uop_bypass_hits_dst_1_1 ? 4'h4 : {r_uop_bypass_hits_dst_0_1, 3'h0};	// Mux.scala:47:69, rename-stage.scala:177:77
      r_uop_1_stale_pdst <=
        (r_uop_bypass_sel_dst_enc_1[3] & (|r_uop_ldst)
           ? _freelist_io_alloc_pregs_0_bits
           : 7'h0)
        | (r_uop_bypass_sel_dst_enc_1[2] & (|r_uop_1_ldst)
             ? _freelist_io_alloc_pregs_1_bits
             : 7'h0)
        | (r_uop_bypass_sel_dst_enc_1[1] & (|r_uop_2_ldst)
             ? _freelist_io_alloc_pregs_2_bits
             : 7'h0)
        | (r_uop_bypass_sel_dst_enc_1[0] & (|r_uop_3_ldst)
             ? _freelist_io_alloc_pregs_3_bits
             : 7'h0);	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :201:30, :217:24, :303:30
    end
    else if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_1_stale_pdst <= _maptable_io_map_resps_1_stale_pdst;	// rename-stage.scala:119:23, :211:24
    if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else begin	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_1_exception <= io_dec_uops_1_exception;	// rename-stage.scala:119:23
      r_uop_1_exc_cause <= io_dec_uops_1_exc_cause;	// rename-stage.scala:119:23
      r_uop_1_bypassable <= io_dec_uops_1_bypassable;	// rename-stage.scala:119:23
      r_uop_1_mem_cmd <= io_dec_uops_1_mem_cmd;	// rename-stage.scala:119:23
      r_uop_1_mem_size <= io_dec_uops_1_mem_size;	// rename-stage.scala:119:23
      r_uop_1_mem_signed <= io_dec_uops_1_mem_signed;	// rename-stage.scala:119:23
      r_uop_1_is_fence <= io_dec_uops_1_is_fence;	// rename-stage.scala:119:23
      r_uop_1_is_fencei <= io_dec_uops_1_is_fencei;	// rename-stage.scala:119:23
      r_uop_1_is_amo <= io_dec_uops_1_is_amo;	// rename-stage.scala:119:23
      r_uop_1_uses_ldq <= io_dec_uops_1_uses_ldq;	// rename-stage.scala:119:23
      r_uop_1_uses_stq <= io_dec_uops_1_uses_stq;	// rename-stage.scala:119:23
      r_uop_1_is_sys_pc2epc <= io_dec_uops_1_is_sys_pc2epc;	// rename-stage.scala:119:23
      r_uop_1_is_unique <= io_dec_uops_1_is_unique;	// rename-stage.scala:119:23
      r_uop_1_flush_on_commit <= io_dec_uops_1_flush_on_commit;	// rename-stage.scala:119:23
    end
    r_uop_1_ldst_is_rs1 <= _GEN & r_uop_1_ldst_is_rs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30
    if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else begin	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_1_ldst <= io_dec_uops_1_ldst;	// rename-stage.scala:119:23
      r_uop_1_lrs1 <= io_dec_uops_1_lrs1;	// rename-stage.scala:119:23
      r_uop_1_lrs2 <= io_dec_uops_1_lrs2;	// rename-stage.scala:119:23
      r_uop_1_lrs3 <= io_dec_uops_1_lrs3;	// rename-stage.scala:119:23
      r_uop_1_ldst_val <= io_dec_uops_1_ldst_val;	// rename-stage.scala:119:23
      r_uop_1_dst_rtype <= io_dec_uops_1_dst_rtype;	// rename-stage.scala:119:23
      r_uop_1_lrs1_rtype <= io_dec_uops_1_lrs1_rtype;	// rename-stage.scala:119:23
      r_uop_1_lrs2_rtype <= io_dec_uops_1_lrs2_rtype;	// rename-stage.scala:119:23
      r_uop_1_frs3_en <= io_dec_uops_1_frs3_en;	// rename-stage.scala:119:23
      r_uop_1_fp_val <= io_dec_uops_1_fp_val;	// rename-stage.scala:119:23
      r_uop_1_fp_single <= io_dec_uops_1_fp_single;	// rename-stage.scala:119:23
      r_uop_1_xcpt_pf_if <= io_dec_uops_1_xcpt_pf_if;	// rename-stage.scala:119:23
      r_uop_1_xcpt_ae_if <= io_dec_uops_1_xcpt_ae_if;	// rename-stage.scala:119:23
      r_uop_1_xcpt_ma_if <= io_dec_uops_1_xcpt_ma_if;	// rename-stage.scala:119:23
      r_uop_1_bp_debug_if <= io_dec_uops_1_bp_debug_if;	// rename-stage.scala:119:23
      r_uop_1_bp_xcpt_if <= io_dec_uops_1_bp_xcpt_if;	// rename-stage.scala:119:23
      r_uop_1_debug_fsrc <= io_dec_uops_1_debug_fsrc;	// rename-stage.scala:119:23
      r_uop_1_debug_tsrc <= io_dec_uops_1_debug_tsrc;	// rename-stage.scala:119:23
      r_uop_2_uopc <= io_dec_uops_2_uopc;	// rename-stage.scala:119:23
      r_uop_2_inst <= io_dec_uops_2_inst;	// rename-stage.scala:119:23
      r_uop_2_debug_inst <= io_dec_uops_2_debug_inst;	// rename-stage.scala:119:23
      r_uop_2_is_rvc <= io_dec_uops_2_is_rvc;	// rename-stage.scala:119:23
      r_uop_2_debug_pc <= io_dec_uops_2_debug_pc;	// rename-stage.scala:119:23
      r_uop_2_iq_type <= io_dec_uops_2_iq_type;	// rename-stage.scala:119:23
      r_uop_2_fu_code <= io_dec_uops_2_fu_code;	// rename-stage.scala:119:23
      r_uop_2_ctrl_br_type <= io_dec_uops_2_ctrl_br_type;	// rename-stage.scala:119:23
      r_uop_2_ctrl_op1_sel <= io_dec_uops_2_ctrl_op1_sel;	// rename-stage.scala:119:23
      r_uop_2_ctrl_op2_sel <= io_dec_uops_2_ctrl_op2_sel;	// rename-stage.scala:119:23
      r_uop_2_ctrl_imm_sel <= io_dec_uops_2_ctrl_imm_sel;	// rename-stage.scala:119:23
      r_uop_2_ctrl_op_fcn <= io_dec_uops_2_ctrl_op_fcn;	// rename-stage.scala:119:23
      r_uop_2_ctrl_fcn_dw <= io_dec_uops_2_ctrl_fcn_dw;	// rename-stage.scala:119:23
      r_uop_2_ctrl_csr_cmd <= io_dec_uops_2_ctrl_csr_cmd;	// rename-stage.scala:119:23
      r_uop_2_ctrl_is_load <= io_dec_uops_2_ctrl_is_load;	// rename-stage.scala:119:23
      r_uop_2_ctrl_is_sta <= io_dec_uops_2_ctrl_is_sta;	// rename-stage.scala:119:23
      r_uop_2_ctrl_is_std <= io_dec_uops_2_ctrl_is_std;	// rename-stage.scala:119:23
      r_uop_2_iw_state <= io_dec_uops_2_iw_state;	// rename-stage.scala:119:23
      r_uop_2_iw_p1_poisoned <= io_dec_uops_2_iw_p1_poisoned;	// rename-stage.scala:119:23
      r_uop_2_iw_p2_poisoned <= io_dec_uops_2_iw_p2_poisoned;	// rename-stage.scala:119:23
      r_uop_2_is_br <= io_dec_uops_2_is_br;	// rename-stage.scala:119:23
      r_uop_2_is_jalr <= io_dec_uops_2_is_jalr;	// rename-stage.scala:119:23
      r_uop_2_is_jal <= io_dec_uops_2_is_jal;	// rename-stage.scala:119:23
      r_uop_2_is_sfb <= io_dec_uops_2_is_sfb;	// rename-stage.scala:119:23
    end
    r_uop_2_br_mask <=
      (_GEN ? r_uop_2_br_mask : io_dec_uops_2_br_mask) & ~io_brupdate_b1_resolve_mask;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, util.scala:74:{35,37}
    if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else begin	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_2_br_tag <= io_dec_uops_2_br_tag;	// rename-stage.scala:119:23
      r_uop_2_ftq_idx <= io_dec_uops_2_ftq_idx;	// rename-stage.scala:119:23
      r_uop_2_edge_inst <= io_dec_uops_2_edge_inst;	// rename-stage.scala:119:23
      r_uop_2_pc_lob <= io_dec_uops_2_pc_lob;	// rename-stage.scala:119:23
      r_uop_2_taken <= io_dec_uops_2_taken;	// rename-stage.scala:119:23
      r_uop_2_imm_packed <= io_dec_uops_2_imm_packed;	// rename-stage.scala:119:23
      r_uop_2_csr_addr <= io_dec_uops_2_csr_addr;	// rename-stage.scala:119:23
      r_uop_2_rxq_idx <= io_dec_uops_2_rxq_idx;	// rename-stage.scala:119:23
    end
    if (r_uop_bypass_hits_rs1_0_2 | r_uop_bypass_hits_rs1_1_2 | r_uop_bypass_hits_rs1_2_2
        | r_uop_bypass_hits_rs1_3_2) begin	// rename-stage.scala:174:77, :184:49
      automatic logic [3:0] r_uop_bypass_sel_rs1_enc_2;	// Mux.scala:47:69
      r_uop_bypass_sel_rs1_enc_2 =
        r_uop_bypass_hits_rs1_3_2
          ? 4'h1
          : r_uop_bypass_hits_rs1_2_2
              ? 4'h2
              : r_uop_bypass_hits_rs1_1_2 ? 4'h4 : {r_uop_bypass_hits_rs1_0_2, 3'h0};	// Mux.scala:47:69, rename-stage.scala:174:77
      r_uop_2_prs1 <=
        (r_uop_bypass_sel_rs1_enc_2[3] & (|r_uop_ldst)
           ? _freelist_io_alloc_pregs_0_bits
           : 7'h0)
        | (r_uop_bypass_sel_rs1_enc_2[2] & (|r_uop_1_ldst)
             ? _freelist_io_alloc_pregs_1_bits
             : 7'h0)
        | (r_uop_bypass_sel_rs1_enc_2[1] & (|r_uop_2_ldst)
             ? _freelist_io_alloc_pregs_2_bits
             : 7'h0)
        | (r_uop_bypass_sel_rs1_enc_2[0] & (|r_uop_3_ldst)
             ? _freelist_io_alloc_pregs_3_bits
             : 7'h0);	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :201:30, :217:24, :303:30
    end
    else if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_2_prs1 <= _maptable_io_map_resps_2_prs1;	// rename-stage.scala:119:23, :211:24
    if (r_uop_bypass_hits_rs2_0_2 | r_uop_bypass_hits_rs2_1_2 | r_uop_bypass_hits_rs2_2_2
        | r_uop_bypass_hits_rs2_3_2) begin	// rename-stage.scala:175:77, :185:49
      automatic logic [3:0] r_uop_bypass_sel_rs2_enc_2;	// Mux.scala:47:69
      r_uop_bypass_sel_rs2_enc_2 =
        r_uop_bypass_hits_rs2_3_2
          ? 4'h1
          : r_uop_bypass_hits_rs2_2_2
              ? 4'h2
              : r_uop_bypass_hits_rs2_1_2 ? 4'h4 : {r_uop_bypass_hits_rs2_0_2, 3'h0};	// Mux.scala:47:69, rename-stage.scala:175:77
      r_uop_2_prs2 <=
        (r_uop_bypass_sel_rs2_enc_2[3] & (|r_uop_ldst)
           ? _freelist_io_alloc_pregs_0_bits
           : 7'h0)
        | (r_uop_bypass_sel_rs2_enc_2[2] & (|r_uop_1_ldst)
             ? _freelist_io_alloc_pregs_1_bits
             : 7'h0)
        | (r_uop_bypass_sel_rs2_enc_2[1] & (|r_uop_2_ldst)
             ? _freelist_io_alloc_pregs_2_bits
             : 7'h0)
        | (r_uop_bypass_sel_rs2_enc_2[0] & (|r_uop_3_ldst)
             ? _freelist_io_alloc_pregs_3_bits
             : 7'h0);	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :201:30, :217:24, :303:30
    end
    else if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_2_prs2 <= _maptable_io_map_resps_2_prs2;	// rename-stage.scala:119:23, :211:24
    if (r_uop_bypass_hits_dst_0_2 | r_uop_bypass_hits_dst_1_2 | r_uop_bypass_hits_dst_2_2
        | r_uop_bypass_hits_dst_3_2) begin	// rename-stage.scala:177:77, :187:49
      automatic logic [3:0] r_uop_bypass_sel_dst_enc_2;	// Mux.scala:47:69
      r_uop_bypass_sel_dst_enc_2 =
        r_uop_bypass_hits_dst_3_2
          ? 4'h1
          : r_uop_bypass_hits_dst_2_2
              ? 4'h2
              : r_uop_bypass_hits_dst_1_2 ? 4'h4 : {r_uop_bypass_hits_dst_0_2, 3'h0};	// Mux.scala:47:69, rename-stage.scala:177:77
      r_uop_2_stale_pdst <=
        (r_uop_bypass_sel_dst_enc_2[3] & (|r_uop_ldst)
           ? _freelist_io_alloc_pregs_0_bits
           : 7'h0)
        | (r_uop_bypass_sel_dst_enc_2[2] & (|r_uop_1_ldst)
             ? _freelist_io_alloc_pregs_1_bits
             : 7'h0)
        | (r_uop_bypass_sel_dst_enc_2[1] & (|r_uop_2_ldst)
             ? _freelist_io_alloc_pregs_2_bits
             : 7'h0)
        | (r_uop_bypass_sel_dst_enc_2[0] & (|r_uop_3_ldst)
             ? _freelist_io_alloc_pregs_3_bits
             : 7'h0);	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :201:30, :217:24, :303:30
    end
    else if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_2_stale_pdst <= _maptable_io_map_resps_2_stale_pdst;	// rename-stage.scala:119:23, :211:24
    if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else begin	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_2_exception <= io_dec_uops_2_exception;	// rename-stage.scala:119:23
      r_uop_2_exc_cause <= io_dec_uops_2_exc_cause;	// rename-stage.scala:119:23
      r_uop_2_bypassable <= io_dec_uops_2_bypassable;	// rename-stage.scala:119:23
      r_uop_2_mem_cmd <= io_dec_uops_2_mem_cmd;	// rename-stage.scala:119:23
      r_uop_2_mem_size <= io_dec_uops_2_mem_size;	// rename-stage.scala:119:23
      r_uop_2_mem_signed <= io_dec_uops_2_mem_signed;	// rename-stage.scala:119:23
      r_uop_2_is_fence <= io_dec_uops_2_is_fence;	// rename-stage.scala:119:23
      r_uop_2_is_fencei <= io_dec_uops_2_is_fencei;	// rename-stage.scala:119:23
      r_uop_2_is_amo <= io_dec_uops_2_is_amo;	// rename-stage.scala:119:23
      r_uop_2_uses_ldq <= io_dec_uops_2_uses_ldq;	// rename-stage.scala:119:23
      r_uop_2_uses_stq <= io_dec_uops_2_uses_stq;	// rename-stage.scala:119:23
      r_uop_2_is_sys_pc2epc <= io_dec_uops_2_is_sys_pc2epc;	// rename-stage.scala:119:23
      r_uop_2_is_unique <= io_dec_uops_2_is_unique;	// rename-stage.scala:119:23
      r_uop_2_flush_on_commit <= io_dec_uops_2_flush_on_commit;	// rename-stage.scala:119:23
    end
    r_uop_2_ldst_is_rs1 <= _GEN & r_uop_2_ldst_is_rs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30
    if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else begin	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_2_ldst <= io_dec_uops_2_ldst;	// rename-stage.scala:119:23
      r_uop_2_lrs1 <= io_dec_uops_2_lrs1;	// rename-stage.scala:119:23
      r_uop_2_lrs2 <= io_dec_uops_2_lrs2;	// rename-stage.scala:119:23
      r_uop_2_lrs3 <= io_dec_uops_2_lrs3;	// rename-stage.scala:119:23
      r_uop_2_ldst_val <= io_dec_uops_2_ldst_val;	// rename-stage.scala:119:23
      r_uop_2_dst_rtype <= io_dec_uops_2_dst_rtype;	// rename-stage.scala:119:23
      r_uop_2_lrs1_rtype <= io_dec_uops_2_lrs1_rtype;	// rename-stage.scala:119:23
      r_uop_2_lrs2_rtype <= io_dec_uops_2_lrs2_rtype;	// rename-stage.scala:119:23
      r_uop_2_frs3_en <= io_dec_uops_2_frs3_en;	// rename-stage.scala:119:23
      r_uop_2_fp_val <= io_dec_uops_2_fp_val;	// rename-stage.scala:119:23
      r_uop_2_fp_single <= io_dec_uops_2_fp_single;	// rename-stage.scala:119:23
      r_uop_2_xcpt_pf_if <= io_dec_uops_2_xcpt_pf_if;	// rename-stage.scala:119:23
      r_uop_2_xcpt_ae_if <= io_dec_uops_2_xcpt_ae_if;	// rename-stage.scala:119:23
      r_uop_2_xcpt_ma_if <= io_dec_uops_2_xcpt_ma_if;	// rename-stage.scala:119:23
      r_uop_2_bp_debug_if <= io_dec_uops_2_bp_debug_if;	// rename-stage.scala:119:23
      r_uop_2_bp_xcpt_if <= io_dec_uops_2_bp_xcpt_if;	// rename-stage.scala:119:23
      r_uop_2_debug_fsrc <= io_dec_uops_2_debug_fsrc;	// rename-stage.scala:119:23
      r_uop_2_debug_tsrc <= io_dec_uops_2_debug_tsrc;	// rename-stage.scala:119:23
      r_uop_3_uopc <= io_dec_uops_3_uopc;	// rename-stage.scala:119:23
      r_uop_3_inst <= io_dec_uops_3_inst;	// rename-stage.scala:119:23
      r_uop_3_debug_inst <= io_dec_uops_3_debug_inst;	// rename-stage.scala:119:23
      r_uop_3_is_rvc <= io_dec_uops_3_is_rvc;	// rename-stage.scala:119:23
      r_uop_3_debug_pc <= io_dec_uops_3_debug_pc;	// rename-stage.scala:119:23
      r_uop_3_iq_type <= io_dec_uops_3_iq_type;	// rename-stage.scala:119:23
      r_uop_3_fu_code <= io_dec_uops_3_fu_code;	// rename-stage.scala:119:23
      r_uop_3_ctrl_br_type <= io_dec_uops_3_ctrl_br_type;	// rename-stage.scala:119:23
      r_uop_3_ctrl_op1_sel <= io_dec_uops_3_ctrl_op1_sel;	// rename-stage.scala:119:23
      r_uop_3_ctrl_op2_sel <= io_dec_uops_3_ctrl_op2_sel;	// rename-stage.scala:119:23
      r_uop_3_ctrl_imm_sel <= io_dec_uops_3_ctrl_imm_sel;	// rename-stage.scala:119:23
      r_uop_3_ctrl_op_fcn <= io_dec_uops_3_ctrl_op_fcn;	// rename-stage.scala:119:23
      r_uop_3_ctrl_fcn_dw <= io_dec_uops_3_ctrl_fcn_dw;	// rename-stage.scala:119:23
      r_uop_3_ctrl_csr_cmd <= io_dec_uops_3_ctrl_csr_cmd;	// rename-stage.scala:119:23
      r_uop_3_ctrl_is_load <= io_dec_uops_3_ctrl_is_load;	// rename-stage.scala:119:23
      r_uop_3_ctrl_is_sta <= io_dec_uops_3_ctrl_is_sta;	// rename-stage.scala:119:23
      r_uop_3_ctrl_is_std <= io_dec_uops_3_ctrl_is_std;	// rename-stage.scala:119:23
      r_uop_3_iw_state <= io_dec_uops_3_iw_state;	// rename-stage.scala:119:23
      r_uop_3_iw_p1_poisoned <= io_dec_uops_3_iw_p1_poisoned;	// rename-stage.scala:119:23
      r_uop_3_iw_p2_poisoned <= io_dec_uops_3_iw_p2_poisoned;	// rename-stage.scala:119:23
      r_uop_3_is_br <= io_dec_uops_3_is_br;	// rename-stage.scala:119:23
      r_uop_3_is_jalr <= io_dec_uops_3_is_jalr;	// rename-stage.scala:119:23
      r_uop_3_is_jal <= io_dec_uops_3_is_jal;	// rename-stage.scala:119:23
      r_uop_3_is_sfb <= io_dec_uops_3_is_sfb;	// rename-stage.scala:119:23
    end
    r_uop_3_br_mask <=
      (_GEN ? r_uop_3_br_mask : io_dec_uops_3_br_mask) & ~io_brupdate_b1_resolve_mask;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, util.scala:74:{35,37}
    if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else begin	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_3_br_tag <= io_dec_uops_3_br_tag;	// rename-stage.scala:119:23
      r_uop_3_ftq_idx <= io_dec_uops_3_ftq_idx;	// rename-stage.scala:119:23
      r_uop_3_edge_inst <= io_dec_uops_3_edge_inst;	// rename-stage.scala:119:23
      r_uop_3_pc_lob <= io_dec_uops_3_pc_lob;	// rename-stage.scala:119:23
      r_uop_3_taken <= io_dec_uops_3_taken;	// rename-stage.scala:119:23
      r_uop_3_imm_packed <= io_dec_uops_3_imm_packed;	// rename-stage.scala:119:23
      r_uop_3_csr_addr <= io_dec_uops_3_csr_addr;	// rename-stage.scala:119:23
      r_uop_3_rxq_idx <= io_dec_uops_3_rxq_idx;	// rename-stage.scala:119:23
    end
    if (r_uop_bypass_hits_rs1_0_3 | r_uop_bypass_hits_rs1_1_3 | r_uop_bypass_hits_rs1_2_3
        | r_uop_bypass_hits_rs1_3_3) begin	// rename-stage.scala:174:77, :184:49
      automatic logic [3:0] r_uop_bypass_sel_rs1_enc_3;	// Mux.scala:47:69
      r_uop_bypass_sel_rs1_enc_3 =
        r_uop_bypass_hits_rs1_3_3
          ? 4'h1
          : r_uop_bypass_hits_rs1_2_3
              ? 4'h2
              : r_uop_bypass_hits_rs1_1_3 ? 4'h4 : {r_uop_bypass_hits_rs1_0_3, 3'h0};	// Mux.scala:47:69, rename-stage.scala:174:77
      r_uop_3_prs1 <=
        (r_uop_bypass_sel_rs1_enc_3[3] & (|r_uop_ldst)
           ? _freelist_io_alloc_pregs_0_bits
           : 7'h0)
        | (r_uop_bypass_sel_rs1_enc_3[2] & (|r_uop_1_ldst)
             ? _freelist_io_alloc_pregs_1_bits
             : 7'h0)
        | (r_uop_bypass_sel_rs1_enc_3[1] & (|r_uop_2_ldst)
             ? _freelist_io_alloc_pregs_2_bits
             : 7'h0)
        | (r_uop_bypass_sel_rs1_enc_3[0] & (|r_uop_3_ldst)
             ? _freelist_io_alloc_pregs_3_bits
             : 7'h0);	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :201:30, :217:24, :303:30
    end
    else if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_3_prs1 <= _maptable_io_map_resps_3_prs1;	// rename-stage.scala:119:23, :211:24
    if (r_uop_bypass_hits_rs2_0_3 | r_uop_bypass_hits_rs2_1_3 | r_uop_bypass_hits_rs2_2_3
        | r_uop_bypass_hits_rs2_3_3) begin	// rename-stage.scala:175:77, :185:49
      automatic logic [3:0] r_uop_bypass_sel_rs2_enc_3;	// Mux.scala:47:69
      r_uop_bypass_sel_rs2_enc_3 =
        r_uop_bypass_hits_rs2_3_3
          ? 4'h1
          : r_uop_bypass_hits_rs2_2_3
              ? 4'h2
              : r_uop_bypass_hits_rs2_1_3 ? 4'h4 : {r_uop_bypass_hits_rs2_0_3, 3'h0};	// Mux.scala:47:69, rename-stage.scala:175:77
      r_uop_3_prs2 <=
        (r_uop_bypass_sel_rs2_enc_3[3] & (|r_uop_ldst)
           ? _freelist_io_alloc_pregs_0_bits
           : 7'h0)
        | (r_uop_bypass_sel_rs2_enc_3[2] & (|r_uop_1_ldst)
             ? _freelist_io_alloc_pregs_1_bits
             : 7'h0)
        | (r_uop_bypass_sel_rs2_enc_3[1] & (|r_uop_2_ldst)
             ? _freelist_io_alloc_pregs_2_bits
             : 7'h0)
        | (r_uop_bypass_sel_rs2_enc_3[0] & (|r_uop_3_ldst)
             ? _freelist_io_alloc_pregs_3_bits
             : 7'h0);	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :201:30, :217:24, :303:30
    end
    else if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_3_prs2 <= _maptable_io_map_resps_3_prs2;	// rename-stage.scala:119:23, :211:24
    if (r_uop_bypass_hits_dst_0_3 | r_uop_bypass_hits_dst_1_3 | r_uop_bypass_hits_dst_2_3
        | r_uop_bypass_hits_dst_3_3) begin	// rename-stage.scala:177:77, :187:49
      automatic logic [3:0] r_uop_bypass_sel_dst_enc_3;	// Mux.scala:47:69
      r_uop_bypass_sel_dst_enc_3 =
        r_uop_bypass_hits_dst_3_3
          ? 4'h1
          : r_uop_bypass_hits_dst_2_3
              ? 4'h2
              : r_uop_bypass_hits_dst_1_3 ? 4'h4 : {r_uop_bypass_hits_dst_0_3, 3'h0};	// Mux.scala:47:69, rename-stage.scala:177:77
      r_uop_3_stale_pdst <=
        (r_uop_bypass_sel_dst_enc_3[3] & (|r_uop_ldst)
           ? _freelist_io_alloc_pregs_0_bits
           : 7'h0)
        | (r_uop_bypass_sel_dst_enc_3[2] & (|r_uop_1_ldst)
             ? _freelist_io_alloc_pregs_1_bits
             : 7'h0)
        | (r_uop_bypass_sel_dst_enc_3[1] & (|r_uop_2_ldst)
             ? _freelist_io_alloc_pregs_2_bits
             : 7'h0)
        | (r_uop_bypass_sel_dst_enc_3[0] & (|r_uop_3_ldst)
             ? _freelist_io_alloc_pregs_3_bits
             : 7'h0);	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :201:30, :217:24, :303:30
    end
    else if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_3_stale_pdst <= _maptable_io_map_resps_3_stale_pdst;	// rename-stage.scala:119:23, :211:24
    if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else begin	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_3_exception <= io_dec_uops_3_exception;	// rename-stage.scala:119:23
      r_uop_3_exc_cause <= io_dec_uops_3_exc_cause;	// rename-stage.scala:119:23
      r_uop_3_bypassable <= io_dec_uops_3_bypassable;	// rename-stage.scala:119:23
      r_uop_3_mem_cmd <= io_dec_uops_3_mem_cmd;	// rename-stage.scala:119:23
      r_uop_3_mem_size <= io_dec_uops_3_mem_size;	// rename-stage.scala:119:23
      r_uop_3_mem_signed <= io_dec_uops_3_mem_signed;	// rename-stage.scala:119:23
      r_uop_3_is_fence <= io_dec_uops_3_is_fence;	// rename-stage.scala:119:23
      r_uop_3_is_fencei <= io_dec_uops_3_is_fencei;	// rename-stage.scala:119:23
      r_uop_3_is_amo <= io_dec_uops_3_is_amo;	// rename-stage.scala:119:23
      r_uop_3_uses_ldq <= io_dec_uops_3_uses_ldq;	// rename-stage.scala:119:23
      r_uop_3_uses_stq <= io_dec_uops_3_uses_stq;	// rename-stage.scala:119:23
      r_uop_3_is_sys_pc2epc <= io_dec_uops_3_is_sys_pc2epc;	// rename-stage.scala:119:23
      r_uop_3_is_unique <= io_dec_uops_3_is_unique;	// rename-stage.scala:119:23
      r_uop_3_flush_on_commit <= io_dec_uops_3_flush_on_commit;	// rename-stage.scala:119:23
    end
    r_uop_3_ldst_is_rs1 <= _GEN & r_uop_3_ldst_is_rs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30
    if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else begin	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_3_ldst <= io_dec_uops_3_ldst;	// rename-stage.scala:119:23
      r_uop_3_lrs1 <= io_dec_uops_3_lrs1;	// rename-stage.scala:119:23
      r_uop_3_lrs2 <= io_dec_uops_3_lrs2;	// rename-stage.scala:119:23
      r_uop_3_lrs3 <= io_dec_uops_3_lrs3;	// rename-stage.scala:119:23
      r_uop_3_ldst_val <= io_dec_uops_3_ldst_val;	// rename-stage.scala:119:23
      r_uop_3_dst_rtype <= io_dec_uops_3_dst_rtype;	// rename-stage.scala:119:23
      r_uop_3_lrs1_rtype <= io_dec_uops_3_lrs1_rtype;	// rename-stage.scala:119:23
      r_uop_3_lrs2_rtype <= io_dec_uops_3_lrs2_rtype;	// rename-stage.scala:119:23
      r_uop_3_frs3_en <= io_dec_uops_3_frs3_en;	// rename-stage.scala:119:23
      r_uop_3_fp_val <= io_dec_uops_3_fp_val;	// rename-stage.scala:119:23
      r_uop_3_fp_single <= io_dec_uops_3_fp_single;	// rename-stage.scala:119:23
      r_uop_3_xcpt_pf_if <= io_dec_uops_3_xcpt_pf_if;	// rename-stage.scala:119:23
      r_uop_3_xcpt_ae_if <= io_dec_uops_3_xcpt_ae_if;	// rename-stage.scala:119:23
      r_uop_3_xcpt_ma_if <= io_dec_uops_3_xcpt_ma_if;	// rename-stage.scala:119:23
      r_uop_3_bp_debug_if <= io_dec_uops_3_bp_debug_if;	// rename-stage.scala:119:23
      r_uop_3_bp_xcpt_if <= io_dec_uops_3_bp_xcpt_if;	// rename-stage.scala:119:23
      r_uop_3_debug_fsrc <= io_dec_uops_3_debug_fsrc;	// rename-stage.scala:119:23
      r_uop_3_debug_tsrc <= io_dec_uops_3_debug_tsrc;	// rename-stage.scala:119:23
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:52];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [5:0] i = 6'h0; i < 6'h35; i += 6'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        r_valid = _RANDOM[6'h0][0];	// rename-stage.scala:118:27
        r_uop_uopc = _RANDOM[6'h0][7:1];	// rename-stage.scala:118:27, :119:23
        r_uop_inst = {_RANDOM[6'h0][31:8], _RANDOM[6'h1][7:0]};	// rename-stage.scala:118:27, :119:23
        r_uop_debug_inst = {_RANDOM[6'h1][31:8], _RANDOM[6'h2][7:0]};	// rename-stage.scala:119:23
        r_uop_is_rvc = _RANDOM[6'h2][8];	// rename-stage.scala:119:23
        r_uop_debug_pc = {_RANDOM[6'h2][31:9], _RANDOM[6'h3][16:0]};	// rename-stage.scala:119:23
        r_uop_iq_type = _RANDOM[6'h3][19:17];	// rename-stage.scala:119:23
        r_uop_fu_code = _RANDOM[6'h3][29:20];	// rename-stage.scala:119:23
        r_uop_ctrl_br_type = {_RANDOM[6'h3][31:30], _RANDOM[6'h4][1:0]};	// rename-stage.scala:119:23
        r_uop_ctrl_op1_sel = _RANDOM[6'h4][3:2];	// rename-stage.scala:119:23
        r_uop_ctrl_op2_sel = _RANDOM[6'h4][6:4];	// rename-stage.scala:119:23
        r_uop_ctrl_imm_sel = _RANDOM[6'h4][9:7];	// rename-stage.scala:119:23
        r_uop_ctrl_op_fcn = _RANDOM[6'h4][13:10];	// rename-stage.scala:119:23
        r_uop_ctrl_fcn_dw = _RANDOM[6'h4][14];	// rename-stage.scala:119:23
        r_uop_ctrl_csr_cmd = _RANDOM[6'h4][17:15];	// rename-stage.scala:119:23
        r_uop_ctrl_is_load = _RANDOM[6'h4][18];	// rename-stage.scala:119:23
        r_uop_ctrl_is_sta = _RANDOM[6'h4][19];	// rename-stage.scala:119:23
        r_uop_ctrl_is_std = _RANDOM[6'h4][20];	// rename-stage.scala:119:23
        r_uop_iw_state = _RANDOM[6'h4][22:21];	// rename-stage.scala:119:23
        r_uop_iw_p1_poisoned = _RANDOM[6'h4][23];	// rename-stage.scala:119:23
        r_uop_iw_p2_poisoned = _RANDOM[6'h4][24];	// rename-stage.scala:119:23
        r_uop_is_br = _RANDOM[6'h4][25];	// rename-stage.scala:119:23
        r_uop_is_jalr = _RANDOM[6'h4][26];	// rename-stage.scala:119:23
        r_uop_is_jal = _RANDOM[6'h4][27];	// rename-stage.scala:119:23
        r_uop_is_sfb = _RANDOM[6'h4][28];	// rename-stage.scala:119:23
        r_uop_br_mask = {_RANDOM[6'h4][31:29], _RANDOM[6'h5][16:0]};	// rename-stage.scala:119:23
        r_uop_br_tag = _RANDOM[6'h5][21:17];	// rename-stage.scala:119:23
        r_uop_ftq_idx = _RANDOM[6'h5][27:22];	// rename-stage.scala:119:23
        r_uop_edge_inst = _RANDOM[6'h5][28];	// rename-stage.scala:119:23
        r_uop_pc_lob = {_RANDOM[6'h5][31:29], _RANDOM[6'h6][2:0]};	// rename-stage.scala:119:23
        r_uop_taken = _RANDOM[6'h6][3];	// rename-stage.scala:119:23
        r_uop_imm_packed = _RANDOM[6'h6][23:4];	// rename-stage.scala:119:23
        r_uop_csr_addr = {_RANDOM[6'h6][31:24], _RANDOM[6'h7][3:0]};	// rename-stage.scala:119:23
        r_uop_rxq_idx = _RANDOM[6'h7][22:21];	// rename-stage.scala:119:23
        r_uop_prs1 = {_RANDOM[6'h7][31:30], _RANDOM[6'h8][4:0]};	// rename-stage.scala:119:23
        r_uop_prs2 = _RANDOM[6'h8][11:5];	// rename-stage.scala:119:23
        r_uop_stale_pdst = {_RANDOM[6'h8][31:29], _RANDOM[6'h9][3:0]};	// rename-stage.scala:119:23
        r_uop_exception = _RANDOM[6'h9][4];	// rename-stage.scala:119:23
        r_uop_exc_cause = {_RANDOM[6'h9][31:5], _RANDOM[6'hA], _RANDOM[6'hB][4:0]};	// rename-stage.scala:119:23
        r_uop_bypassable = _RANDOM[6'hB][5];	// rename-stage.scala:119:23
        r_uop_mem_cmd = _RANDOM[6'hB][10:6];	// rename-stage.scala:119:23
        r_uop_mem_size = _RANDOM[6'hB][12:11];	// rename-stage.scala:119:23
        r_uop_mem_signed = _RANDOM[6'hB][13];	// rename-stage.scala:119:23
        r_uop_is_fence = _RANDOM[6'hB][14];	// rename-stage.scala:119:23
        r_uop_is_fencei = _RANDOM[6'hB][15];	// rename-stage.scala:119:23
        r_uop_is_amo = _RANDOM[6'hB][16];	// rename-stage.scala:119:23
        r_uop_uses_ldq = _RANDOM[6'hB][17];	// rename-stage.scala:119:23
        r_uop_uses_stq = _RANDOM[6'hB][18];	// rename-stage.scala:119:23
        r_uop_is_sys_pc2epc = _RANDOM[6'hB][19];	// rename-stage.scala:119:23
        r_uop_is_unique = _RANDOM[6'hB][20];	// rename-stage.scala:119:23
        r_uop_flush_on_commit = _RANDOM[6'hB][21];	// rename-stage.scala:119:23
        r_uop_ldst_is_rs1 = _RANDOM[6'hB][22];	// rename-stage.scala:119:23
        r_uop_ldst = _RANDOM[6'hB][28:23];	// rename-stage.scala:119:23
        r_uop_lrs1 = {_RANDOM[6'hB][31:29], _RANDOM[6'hC][2:0]};	// rename-stage.scala:119:23
        r_uop_lrs2 = _RANDOM[6'hC][8:3];	// rename-stage.scala:119:23
        r_uop_lrs3 = _RANDOM[6'hC][14:9];	// rename-stage.scala:119:23
        r_uop_ldst_val = _RANDOM[6'hC][15];	// rename-stage.scala:119:23
        r_uop_dst_rtype = _RANDOM[6'hC][17:16];	// rename-stage.scala:119:23
        r_uop_lrs1_rtype = _RANDOM[6'hC][19:18];	// rename-stage.scala:119:23
        r_uop_lrs2_rtype = _RANDOM[6'hC][21:20];	// rename-stage.scala:119:23
        r_uop_frs3_en = _RANDOM[6'hC][22];	// rename-stage.scala:119:23
        r_uop_fp_val = _RANDOM[6'hC][23];	// rename-stage.scala:119:23
        r_uop_fp_single = _RANDOM[6'hC][24];	// rename-stage.scala:119:23
        r_uop_xcpt_pf_if = _RANDOM[6'hC][25];	// rename-stage.scala:119:23
        r_uop_xcpt_ae_if = _RANDOM[6'hC][26];	// rename-stage.scala:119:23
        r_uop_xcpt_ma_if = _RANDOM[6'hC][27];	// rename-stage.scala:119:23
        r_uop_bp_debug_if = _RANDOM[6'hC][28];	// rename-stage.scala:119:23
        r_uop_bp_xcpt_if = _RANDOM[6'hC][29];	// rename-stage.scala:119:23
        r_uop_debug_fsrc = _RANDOM[6'hC][31:30];	// rename-stage.scala:119:23
        r_uop_debug_tsrc = _RANDOM[6'hD][1:0];	// rename-stage.scala:119:23
        r_valid_1 = _RANDOM[6'hD][2];	// rename-stage.scala:118:27, :119:23
        r_uop_1_uopc = _RANDOM[6'hD][9:3];	// rename-stage.scala:119:23
        r_uop_1_inst = {_RANDOM[6'hD][31:10], _RANDOM[6'hE][9:0]};	// rename-stage.scala:119:23
        r_uop_1_debug_inst = {_RANDOM[6'hE][31:10], _RANDOM[6'hF][9:0]};	// rename-stage.scala:119:23
        r_uop_1_is_rvc = _RANDOM[6'hF][10];	// rename-stage.scala:119:23
        r_uop_1_debug_pc = {_RANDOM[6'hF][31:11], _RANDOM[6'h10][18:0]};	// rename-stage.scala:119:23
        r_uop_1_iq_type = _RANDOM[6'h10][21:19];	// rename-stage.scala:119:23
        r_uop_1_fu_code = _RANDOM[6'h10][31:22];	// rename-stage.scala:119:23
        r_uop_1_ctrl_br_type = _RANDOM[6'h11][3:0];	// rename-stage.scala:119:23
        r_uop_1_ctrl_op1_sel = _RANDOM[6'h11][5:4];	// rename-stage.scala:119:23
        r_uop_1_ctrl_op2_sel = _RANDOM[6'h11][8:6];	// rename-stage.scala:119:23
        r_uop_1_ctrl_imm_sel = _RANDOM[6'h11][11:9];	// rename-stage.scala:119:23
        r_uop_1_ctrl_op_fcn = _RANDOM[6'h11][15:12];	// rename-stage.scala:119:23
        r_uop_1_ctrl_fcn_dw = _RANDOM[6'h11][16];	// rename-stage.scala:119:23
        r_uop_1_ctrl_csr_cmd = _RANDOM[6'h11][19:17];	// rename-stage.scala:119:23
        r_uop_1_ctrl_is_load = _RANDOM[6'h11][20];	// rename-stage.scala:119:23
        r_uop_1_ctrl_is_sta = _RANDOM[6'h11][21];	// rename-stage.scala:119:23
        r_uop_1_ctrl_is_std = _RANDOM[6'h11][22];	// rename-stage.scala:119:23
        r_uop_1_iw_state = _RANDOM[6'h11][24:23];	// rename-stage.scala:119:23
        r_uop_1_iw_p1_poisoned = _RANDOM[6'h11][25];	// rename-stage.scala:119:23
        r_uop_1_iw_p2_poisoned = _RANDOM[6'h11][26];	// rename-stage.scala:119:23
        r_uop_1_is_br = _RANDOM[6'h11][27];	// rename-stage.scala:119:23
        r_uop_1_is_jalr = _RANDOM[6'h11][28];	// rename-stage.scala:119:23
        r_uop_1_is_jal = _RANDOM[6'h11][29];	// rename-stage.scala:119:23
        r_uop_1_is_sfb = _RANDOM[6'h11][30];	// rename-stage.scala:119:23
        r_uop_1_br_mask = {_RANDOM[6'h11][31], _RANDOM[6'h12][18:0]};	// rename-stage.scala:119:23
        r_uop_1_br_tag = _RANDOM[6'h12][23:19];	// rename-stage.scala:119:23
        r_uop_1_ftq_idx = _RANDOM[6'h12][29:24];	// rename-stage.scala:119:23
        r_uop_1_edge_inst = _RANDOM[6'h12][30];	// rename-stage.scala:119:23
        r_uop_1_pc_lob = {_RANDOM[6'h12][31], _RANDOM[6'h13][4:0]};	// rename-stage.scala:119:23
        r_uop_1_taken = _RANDOM[6'h13][5];	// rename-stage.scala:119:23
        r_uop_1_imm_packed = _RANDOM[6'h13][25:6];	// rename-stage.scala:119:23
        r_uop_1_csr_addr = {_RANDOM[6'h13][31:26], _RANDOM[6'h14][5:0]};	// rename-stage.scala:119:23
        r_uop_1_rxq_idx = _RANDOM[6'h14][24:23];	// rename-stage.scala:119:23
        r_uop_1_prs1 = _RANDOM[6'h15][6:0];	// rename-stage.scala:119:23
        r_uop_1_prs2 = _RANDOM[6'h15][13:7];	// rename-stage.scala:119:23
        r_uop_1_stale_pdst = {_RANDOM[6'h15][31], _RANDOM[6'h16][5:0]};	// rename-stage.scala:119:23
        r_uop_1_exception = _RANDOM[6'h16][6];	// rename-stage.scala:119:23
        r_uop_1_exc_cause = {_RANDOM[6'h16][31:7], _RANDOM[6'h17], _RANDOM[6'h18][6:0]};	// rename-stage.scala:119:23
        r_uop_1_bypassable = _RANDOM[6'h18][7];	// rename-stage.scala:119:23
        r_uop_1_mem_cmd = _RANDOM[6'h18][12:8];	// rename-stage.scala:119:23
        r_uop_1_mem_size = _RANDOM[6'h18][14:13];	// rename-stage.scala:119:23
        r_uop_1_mem_signed = _RANDOM[6'h18][15];	// rename-stage.scala:119:23
        r_uop_1_is_fence = _RANDOM[6'h18][16];	// rename-stage.scala:119:23
        r_uop_1_is_fencei = _RANDOM[6'h18][17];	// rename-stage.scala:119:23
        r_uop_1_is_amo = _RANDOM[6'h18][18];	// rename-stage.scala:119:23
        r_uop_1_uses_ldq = _RANDOM[6'h18][19];	// rename-stage.scala:119:23
        r_uop_1_uses_stq = _RANDOM[6'h18][20];	// rename-stage.scala:119:23
        r_uop_1_is_sys_pc2epc = _RANDOM[6'h18][21];	// rename-stage.scala:119:23
        r_uop_1_is_unique = _RANDOM[6'h18][22];	// rename-stage.scala:119:23
        r_uop_1_flush_on_commit = _RANDOM[6'h18][23];	// rename-stage.scala:119:23
        r_uop_1_ldst_is_rs1 = _RANDOM[6'h18][24];	// rename-stage.scala:119:23
        r_uop_1_ldst = _RANDOM[6'h18][30:25];	// rename-stage.scala:119:23
        r_uop_1_lrs1 = {_RANDOM[6'h18][31], _RANDOM[6'h19][4:0]};	// rename-stage.scala:119:23
        r_uop_1_lrs2 = _RANDOM[6'h19][10:5];	// rename-stage.scala:119:23
        r_uop_1_lrs3 = _RANDOM[6'h19][16:11];	// rename-stage.scala:119:23
        r_uop_1_ldst_val = _RANDOM[6'h19][17];	// rename-stage.scala:119:23
        r_uop_1_dst_rtype = _RANDOM[6'h19][19:18];	// rename-stage.scala:119:23
        r_uop_1_lrs1_rtype = _RANDOM[6'h19][21:20];	// rename-stage.scala:119:23
        r_uop_1_lrs2_rtype = _RANDOM[6'h19][23:22];	// rename-stage.scala:119:23
        r_uop_1_frs3_en = _RANDOM[6'h19][24];	// rename-stage.scala:119:23
        r_uop_1_fp_val = _RANDOM[6'h19][25];	// rename-stage.scala:119:23
        r_uop_1_fp_single = _RANDOM[6'h19][26];	// rename-stage.scala:119:23
        r_uop_1_xcpt_pf_if = _RANDOM[6'h19][27];	// rename-stage.scala:119:23
        r_uop_1_xcpt_ae_if = _RANDOM[6'h19][28];	// rename-stage.scala:119:23
        r_uop_1_xcpt_ma_if = _RANDOM[6'h19][29];	// rename-stage.scala:119:23
        r_uop_1_bp_debug_if = _RANDOM[6'h19][30];	// rename-stage.scala:119:23
        r_uop_1_bp_xcpt_if = _RANDOM[6'h19][31];	// rename-stage.scala:119:23
        r_uop_1_debug_fsrc = _RANDOM[6'h1A][1:0];	// rename-stage.scala:119:23
        r_uop_1_debug_tsrc = _RANDOM[6'h1A][3:2];	// rename-stage.scala:119:23
        r_valid_2 = _RANDOM[6'h1A][4];	// rename-stage.scala:118:27, :119:23
        r_uop_2_uopc = _RANDOM[6'h1A][11:5];	// rename-stage.scala:119:23
        r_uop_2_inst = {_RANDOM[6'h1A][31:12], _RANDOM[6'h1B][11:0]};	// rename-stage.scala:119:23
        r_uop_2_debug_inst = {_RANDOM[6'h1B][31:12], _RANDOM[6'h1C][11:0]};	// rename-stage.scala:119:23
        r_uop_2_is_rvc = _RANDOM[6'h1C][12];	// rename-stage.scala:119:23
        r_uop_2_debug_pc = {_RANDOM[6'h1C][31:13], _RANDOM[6'h1D][20:0]};	// rename-stage.scala:119:23
        r_uop_2_iq_type = _RANDOM[6'h1D][23:21];	// rename-stage.scala:119:23
        r_uop_2_fu_code = {_RANDOM[6'h1D][31:24], _RANDOM[6'h1E][1:0]};	// rename-stage.scala:119:23
        r_uop_2_ctrl_br_type = _RANDOM[6'h1E][5:2];	// rename-stage.scala:119:23
        r_uop_2_ctrl_op1_sel = _RANDOM[6'h1E][7:6];	// rename-stage.scala:119:23
        r_uop_2_ctrl_op2_sel = _RANDOM[6'h1E][10:8];	// rename-stage.scala:119:23
        r_uop_2_ctrl_imm_sel = _RANDOM[6'h1E][13:11];	// rename-stage.scala:119:23
        r_uop_2_ctrl_op_fcn = _RANDOM[6'h1E][17:14];	// rename-stage.scala:119:23
        r_uop_2_ctrl_fcn_dw = _RANDOM[6'h1E][18];	// rename-stage.scala:119:23
        r_uop_2_ctrl_csr_cmd = _RANDOM[6'h1E][21:19];	// rename-stage.scala:119:23
        r_uop_2_ctrl_is_load = _RANDOM[6'h1E][22];	// rename-stage.scala:119:23
        r_uop_2_ctrl_is_sta = _RANDOM[6'h1E][23];	// rename-stage.scala:119:23
        r_uop_2_ctrl_is_std = _RANDOM[6'h1E][24];	// rename-stage.scala:119:23
        r_uop_2_iw_state = _RANDOM[6'h1E][26:25];	// rename-stage.scala:119:23
        r_uop_2_iw_p1_poisoned = _RANDOM[6'h1E][27];	// rename-stage.scala:119:23
        r_uop_2_iw_p2_poisoned = _RANDOM[6'h1E][28];	// rename-stage.scala:119:23
        r_uop_2_is_br = _RANDOM[6'h1E][29];	// rename-stage.scala:119:23
        r_uop_2_is_jalr = _RANDOM[6'h1E][30];	// rename-stage.scala:119:23
        r_uop_2_is_jal = _RANDOM[6'h1E][31];	// rename-stage.scala:119:23
        r_uop_2_is_sfb = _RANDOM[6'h1F][0];	// rename-stage.scala:119:23
        r_uop_2_br_mask = _RANDOM[6'h1F][20:1];	// rename-stage.scala:119:23
        r_uop_2_br_tag = _RANDOM[6'h1F][25:21];	// rename-stage.scala:119:23
        r_uop_2_ftq_idx = _RANDOM[6'h1F][31:26];	// rename-stage.scala:119:23
        r_uop_2_edge_inst = _RANDOM[6'h20][0];	// rename-stage.scala:119:23
        r_uop_2_pc_lob = _RANDOM[6'h20][6:1];	// rename-stage.scala:119:23
        r_uop_2_taken = _RANDOM[6'h20][7];	// rename-stage.scala:119:23
        r_uop_2_imm_packed = _RANDOM[6'h20][27:8];	// rename-stage.scala:119:23
        r_uop_2_csr_addr = {_RANDOM[6'h20][31:28], _RANDOM[6'h21][7:0]};	// rename-stage.scala:119:23
        r_uop_2_rxq_idx = _RANDOM[6'h21][26:25];	// rename-stage.scala:119:23
        r_uop_2_prs1 = _RANDOM[6'h22][8:2];	// rename-stage.scala:119:23
        r_uop_2_prs2 = _RANDOM[6'h22][15:9];	// rename-stage.scala:119:23
        r_uop_2_stale_pdst = _RANDOM[6'h23][7:1];	// rename-stage.scala:119:23
        r_uop_2_exception = _RANDOM[6'h23][8];	// rename-stage.scala:119:23
        r_uop_2_exc_cause = {_RANDOM[6'h23][31:9], _RANDOM[6'h24], _RANDOM[6'h25][8:0]};	// rename-stage.scala:119:23
        r_uop_2_bypassable = _RANDOM[6'h25][9];	// rename-stage.scala:119:23
        r_uop_2_mem_cmd = _RANDOM[6'h25][14:10];	// rename-stage.scala:119:23
        r_uop_2_mem_size = _RANDOM[6'h25][16:15];	// rename-stage.scala:119:23
        r_uop_2_mem_signed = _RANDOM[6'h25][17];	// rename-stage.scala:119:23
        r_uop_2_is_fence = _RANDOM[6'h25][18];	// rename-stage.scala:119:23
        r_uop_2_is_fencei = _RANDOM[6'h25][19];	// rename-stage.scala:119:23
        r_uop_2_is_amo = _RANDOM[6'h25][20];	// rename-stage.scala:119:23
        r_uop_2_uses_ldq = _RANDOM[6'h25][21];	// rename-stage.scala:119:23
        r_uop_2_uses_stq = _RANDOM[6'h25][22];	// rename-stage.scala:119:23
        r_uop_2_is_sys_pc2epc = _RANDOM[6'h25][23];	// rename-stage.scala:119:23
        r_uop_2_is_unique = _RANDOM[6'h25][24];	// rename-stage.scala:119:23
        r_uop_2_flush_on_commit = _RANDOM[6'h25][25];	// rename-stage.scala:119:23
        r_uop_2_ldst_is_rs1 = _RANDOM[6'h25][26];	// rename-stage.scala:119:23
        r_uop_2_ldst = {_RANDOM[6'h25][31:27], _RANDOM[6'h26][0]};	// rename-stage.scala:119:23
        r_uop_2_lrs1 = _RANDOM[6'h26][6:1];	// rename-stage.scala:119:23
        r_uop_2_lrs2 = _RANDOM[6'h26][12:7];	// rename-stage.scala:119:23
        r_uop_2_lrs3 = _RANDOM[6'h26][18:13];	// rename-stage.scala:119:23
        r_uop_2_ldst_val = _RANDOM[6'h26][19];	// rename-stage.scala:119:23
        r_uop_2_dst_rtype = _RANDOM[6'h26][21:20];	// rename-stage.scala:119:23
        r_uop_2_lrs1_rtype = _RANDOM[6'h26][23:22];	// rename-stage.scala:119:23
        r_uop_2_lrs2_rtype = _RANDOM[6'h26][25:24];	// rename-stage.scala:119:23
        r_uop_2_frs3_en = _RANDOM[6'h26][26];	// rename-stage.scala:119:23
        r_uop_2_fp_val = _RANDOM[6'h26][27];	// rename-stage.scala:119:23
        r_uop_2_fp_single = _RANDOM[6'h26][28];	// rename-stage.scala:119:23
        r_uop_2_xcpt_pf_if = _RANDOM[6'h26][29];	// rename-stage.scala:119:23
        r_uop_2_xcpt_ae_if = _RANDOM[6'h26][30];	// rename-stage.scala:119:23
        r_uop_2_xcpt_ma_if = _RANDOM[6'h26][31];	// rename-stage.scala:119:23
        r_uop_2_bp_debug_if = _RANDOM[6'h27][0];	// rename-stage.scala:119:23
        r_uop_2_bp_xcpt_if = _RANDOM[6'h27][1];	// rename-stage.scala:119:23
        r_uop_2_debug_fsrc = _RANDOM[6'h27][3:2];	// rename-stage.scala:119:23
        r_uop_2_debug_tsrc = _RANDOM[6'h27][5:4];	// rename-stage.scala:119:23
        r_valid_3 = _RANDOM[6'h27][6];	// rename-stage.scala:118:27, :119:23
        r_uop_3_uopc = _RANDOM[6'h27][13:7];	// rename-stage.scala:119:23
        r_uop_3_inst = {_RANDOM[6'h27][31:14], _RANDOM[6'h28][13:0]};	// rename-stage.scala:119:23
        r_uop_3_debug_inst = {_RANDOM[6'h28][31:14], _RANDOM[6'h29][13:0]};	// rename-stage.scala:119:23
        r_uop_3_is_rvc = _RANDOM[6'h29][14];	// rename-stage.scala:119:23
        r_uop_3_debug_pc = {_RANDOM[6'h29][31:15], _RANDOM[6'h2A][22:0]};	// rename-stage.scala:119:23
        r_uop_3_iq_type = _RANDOM[6'h2A][25:23];	// rename-stage.scala:119:23
        r_uop_3_fu_code = {_RANDOM[6'h2A][31:26], _RANDOM[6'h2B][3:0]};	// rename-stage.scala:119:23
        r_uop_3_ctrl_br_type = _RANDOM[6'h2B][7:4];	// rename-stage.scala:119:23
        r_uop_3_ctrl_op1_sel = _RANDOM[6'h2B][9:8];	// rename-stage.scala:119:23
        r_uop_3_ctrl_op2_sel = _RANDOM[6'h2B][12:10];	// rename-stage.scala:119:23
        r_uop_3_ctrl_imm_sel = _RANDOM[6'h2B][15:13];	// rename-stage.scala:119:23
        r_uop_3_ctrl_op_fcn = _RANDOM[6'h2B][19:16];	// rename-stage.scala:119:23
        r_uop_3_ctrl_fcn_dw = _RANDOM[6'h2B][20];	// rename-stage.scala:119:23
        r_uop_3_ctrl_csr_cmd = _RANDOM[6'h2B][23:21];	// rename-stage.scala:119:23
        r_uop_3_ctrl_is_load = _RANDOM[6'h2B][24];	// rename-stage.scala:119:23
        r_uop_3_ctrl_is_sta = _RANDOM[6'h2B][25];	// rename-stage.scala:119:23
        r_uop_3_ctrl_is_std = _RANDOM[6'h2B][26];	// rename-stage.scala:119:23
        r_uop_3_iw_state = _RANDOM[6'h2B][28:27];	// rename-stage.scala:119:23
        r_uop_3_iw_p1_poisoned = _RANDOM[6'h2B][29];	// rename-stage.scala:119:23
        r_uop_3_iw_p2_poisoned = _RANDOM[6'h2B][30];	// rename-stage.scala:119:23
        r_uop_3_is_br = _RANDOM[6'h2B][31];	// rename-stage.scala:119:23
        r_uop_3_is_jalr = _RANDOM[6'h2C][0];	// rename-stage.scala:119:23
        r_uop_3_is_jal = _RANDOM[6'h2C][1];	// rename-stage.scala:119:23
        r_uop_3_is_sfb = _RANDOM[6'h2C][2];	// rename-stage.scala:119:23
        r_uop_3_br_mask = _RANDOM[6'h2C][22:3];	// rename-stage.scala:119:23
        r_uop_3_br_tag = _RANDOM[6'h2C][27:23];	// rename-stage.scala:119:23
        r_uop_3_ftq_idx = {_RANDOM[6'h2C][31:28], _RANDOM[6'h2D][1:0]};	// rename-stage.scala:119:23
        r_uop_3_edge_inst = _RANDOM[6'h2D][2];	// rename-stage.scala:119:23
        r_uop_3_pc_lob = _RANDOM[6'h2D][8:3];	// rename-stage.scala:119:23
        r_uop_3_taken = _RANDOM[6'h2D][9];	// rename-stage.scala:119:23
        r_uop_3_imm_packed = _RANDOM[6'h2D][29:10];	// rename-stage.scala:119:23
        r_uop_3_csr_addr = {_RANDOM[6'h2D][31:30], _RANDOM[6'h2E][9:0]};	// rename-stage.scala:119:23
        r_uop_3_rxq_idx = _RANDOM[6'h2E][28:27];	// rename-stage.scala:119:23
        r_uop_3_prs1 = _RANDOM[6'h2F][10:4];	// rename-stage.scala:119:23
        r_uop_3_prs2 = _RANDOM[6'h2F][17:11];	// rename-stage.scala:119:23
        r_uop_3_stale_pdst = _RANDOM[6'h30][9:3];	// rename-stage.scala:119:23
        r_uop_3_exception = _RANDOM[6'h30][10];	// rename-stage.scala:119:23
        r_uop_3_exc_cause = {_RANDOM[6'h30][31:11], _RANDOM[6'h31], _RANDOM[6'h32][10:0]};	// rename-stage.scala:119:23
        r_uop_3_bypassable = _RANDOM[6'h32][11];	// rename-stage.scala:119:23
        r_uop_3_mem_cmd = _RANDOM[6'h32][16:12];	// rename-stage.scala:119:23
        r_uop_3_mem_size = _RANDOM[6'h32][18:17];	// rename-stage.scala:119:23
        r_uop_3_mem_signed = _RANDOM[6'h32][19];	// rename-stage.scala:119:23
        r_uop_3_is_fence = _RANDOM[6'h32][20];	// rename-stage.scala:119:23
        r_uop_3_is_fencei = _RANDOM[6'h32][21];	// rename-stage.scala:119:23
        r_uop_3_is_amo = _RANDOM[6'h32][22];	// rename-stage.scala:119:23
        r_uop_3_uses_ldq = _RANDOM[6'h32][23];	// rename-stage.scala:119:23
        r_uop_3_uses_stq = _RANDOM[6'h32][24];	// rename-stage.scala:119:23
        r_uop_3_is_sys_pc2epc = _RANDOM[6'h32][25];	// rename-stage.scala:119:23
        r_uop_3_is_unique = _RANDOM[6'h32][26];	// rename-stage.scala:119:23
        r_uop_3_flush_on_commit = _RANDOM[6'h32][27];	// rename-stage.scala:119:23
        r_uop_3_ldst_is_rs1 = _RANDOM[6'h32][28];	// rename-stage.scala:119:23
        r_uop_3_ldst = {_RANDOM[6'h32][31:29], _RANDOM[6'h33][2:0]};	// rename-stage.scala:119:23
        r_uop_3_lrs1 = _RANDOM[6'h33][8:3];	// rename-stage.scala:119:23
        r_uop_3_lrs2 = _RANDOM[6'h33][14:9];	// rename-stage.scala:119:23
        r_uop_3_lrs3 = _RANDOM[6'h33][20:15];	// rename-stage.scala:119:23
        r_uop_3_ldst_val = _RANDOM[6'h33][21];	// rename-stage.scala:119:23
        r_uop_3_dst_rtype = _RANDOM[6'h33][23:22];	// rename-stage.scala:119:23
        r_uop_3_lrs1_rtype = _RANDOM[6'h33][25:24];	// rename-stage.scala:119:23
        r_uop_3_lrs2_rtype = _RANDOM[6'h33][27:26];	// rename-stage.scala:119:23
        r_uop_3_frs3_en = _RANDOM[6'h33][28];	// rename-stage.scala:119:23
        r_uop_3_fp_val = _RANDOM[6'h33][29];	// rename-stage.scala:119:23
        r_uop_3_fp_single = _RANDOM[6'h33][30];	// rename-stage.scala:119:23
        r_uop_3_xcpt_pf_if = _RANDOM[6'h33][31];	// rename-stage.scala:119:23
        r_uop_3_xcpt_ae_if = _RANDOM[6'h34][0];	// rename-stage.scala:119:23
        r_uop_3_xcpt_ma_if = _RANDOM[6'h34][1];	// rename-stage.scala:119:23
        r_uop_3_bp_debug_if = _RANDOM[6'h34][2];	// rename-stage.scala:119:23
        r_uop_3_bp_xcpt_if = _RANDOM[6'h34][3];	// rename-stage.scala:119:23
        r_uop_3_debug_fsrc = _RANDOM[6'h34][5:4];	// rename-stage.scala:119:23
        r_uop_3_debug_tsrc = _RANDOM[6'h34][7:6];	// rename-stage.scala:119:23
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  RenameMapTable maptable (	// rename-stage.scala:211:24
    .clock                     (clock),
    .reset                     (reset),
    .io_map_reqs_0_lrs1        (io_dec_uops_0_lrs1),
    .io_map_reqs_0_lrs2        (io_dec_uops_0_lrs2),
    .io_map_reqs_0_ldst        (io_dec_uops_0_ldst),
    .io_map_reqs_1_lrs1        (io_dec_uops_1_lrs1),
    .io_map_reqs_1_lrs2        (io_dec_uops_1_lrs2),
    .io_map_reqs_1_ldst        (io_dec_uops_1_ldst),
    .io_map_reqs_2_lrs1        (io_dec_uops_2_lrs1),
    .io_map_reqs_2_lrs2        (io_dec_uops_2_lrs2),
    .io_map_reqs_2_ldst        (io_dec_uops_2_ldst),
    .io_map_reqs_3_lrs1        (io_dec_uops_3_lrs1),
    .io_map_reqs_3_lrs2        (io_dec_uops_3_lrs2),
    .io_map_reqs_3_ldst        (io_dec_uops_3_ldst),
    .io_remap_reqs_0_ldst      (io_rollback ? io_com_uops_3_ldst : r_uop_ldst),	// rename-stage.scala:119:23, :259:30
    .io_remap_reqs_0_pdst
      (io_rollback ? io_com_uops_3_stale_pdst : io_ren2_uops_0_newuop_pdst),	// rename-stage.scala:260:30, :303:20
    .io_remap_reqs_0_valid     (ren2_alloc_reqs_0 | rbk_valids_3),	// rename-stage.scala:237:88, :241:92, :263:38
    .io_remap_reqs_1_ldst      (io_rollback ? io_com_uops_2_ldst : r_uop_1_ldst),	// rename-stage.scala:119:23, :259:30
    .io_remap_reqs_1_pdst
      (io_rollback ? io_com_uops_2_stale_pdst : io_ren2_uops_1_newuop_pdst),	// rename-stage.scala:260:30, :303:20
    .io_remap_reqs_1_valid     (ren2_alloc_reqs_1 | rbk_valids_2),	// rename-stage.scala:237:88, :241:92, :263:38
    .io_remap_reqs_2_ldst      (io_rollback ? io_com_uops_1_ldst : r_uop_2_ldst),	// rename-stage.scala:119:23, :259:30
    .io_remap_reqs_2_pdst
      (io_rollback ? io_com_uops_1_stale_pdst : io_ren2_uops_2_newuop_pdst),	// rename-stage.scala:260:30, :303:20
    .io_remap_reqs_2_valid     (ren2_alloc_reqs_2 | rbk_valids_1),	// rename-stage.scala:237:88, :241:92, :263:38
    .io_remap_reqs_3_ldst      (io_rollback ? io_com_uops_0_ldst : r_uop_3_ldst),	// rename-stage.scala:119:23, :259:30
    .io_remap_reqs_3_pdst
      (io_rollback ? io_com_uops_0_stale_pdst : io_ren2_uops_3_newuop_pdst),	// rename-stage.scala:260:30, :303:20
    .io_remap_reqs_3_valid     (ren2_alloc_reqs_3 | rbk_valids_0),	// rename-stage.scala:237:88, :241:92, :263:38
    .io_ren_br_tags_0_valid    (ren2_br_tags_0_valid),	// rename-stage.scala:238:43
    .io_ren_br_tags_0_bits     (r_uop_br_tag),	// rename-stage.scala:119:23
    .io_ren_br_tags_1_valid    (ren2_br_tags_1_valid),	// rename-stage.scala:238:43
    .io_ren_br_tags_1_bits     (r_uop_1_br_tag),	// rename-stage.scala:119:23
    .io_ren_br_tags_2_valid    (ren2_br_tags_2_valid),	// rename-stage.scala:238:43
    .io_ren_br_tags_2_bits     (r_uop_2_br_tag),	// rename-stage.scala:119:23
    .io_ren_br_tags_3_valid    (ren2_br_tags_3_valid),	// rename-stage.scala:238:43
    .io_ren_br_tags_3_bits     (r_uop_3_br_tag),	// rename-stage.scala:119:23
    .io_brupdate_b2_uop_br_tag (io_brupdate_b2_uop_br_tag),
    .io_brupdate_b2_mispredict (io_brupdate_b2_mispredict),
    .io_rollback               (io_rollback),
    .io_map_resps_0_prs1       (_maptable_io_map_resps_0_prs1),
    .io_map_resps_0_prs2       (_maptable_io_map_resps_0_prs2),
    .io_map_resps_0_stale_pdst (_maptable_io_map_resps_0_stale_pdst),
    .io_map_resps_1_prs1       (_maptable_io_map_resps_1_prs1),
    .io_map_resps_1_prs2       (_maptable_io_map_resps_1_prs2),
    .io_map_resps_1_stale_pdst (_maptable_io_map_resps_1_stale_pdst),
    .io_map_resps_2_prs1       (_maptable_io_map_resps_2_prs1),
    .io_map_resps_2_prs2       (_maptable_io_map_resps_2_prs2),
    .io_map_resps_2_stale_pdst (_maptable_io_map_resps_2_stale_pdst),
    .io_map_resps_3_prs1       (_maptable_io_map_resps_3_prs1),
    .io_map_resps_3_prs2       (_maptable_io_map_resps_3_prs2),
    .io_map_resps_3_stale_pdst (_maptable_io_map_resps_3_stale_pdst)
  );
  RenameFreeList freelist (	// rename-stage.scala:217:24
    .clock                     (clock),
    .reset                     (reset),
    .io_reqs_0                 (ren2_alloc_reqs_0),	// rename-stage.scala:237:88
    .io_reqs_1                 (ren2_alloc_reqs_1),	// rename-stage.scala:237:88
    .io_reqs_2                 (ren2_alloc_reqs_2),	// rename-stage.scala:237:88
    .io_reqs_3                 (ren2_alloc_reqs_3),	// rename-stage.scala:237:88
    .io_dealloc_pregs_0_valid
      (io_com_uops_0_ldst_val & _rbk_valids_0_T & io_com_valids_0 | rbk_valids_0),	// rename-stage.scala:240:{82,92}, :241:92, :290:37
    .io_dealloc_pregs_0_bits
      (io_rollback ? io_com_uops_0_pdst : io_com_uops_0_stale_pdst),	// rename-stage.scala:292:33
    .io_dealloc_pregs_1_valid
      (io_com_uops_1_ldst_val & _rbk_valids_1_T & io_com_valids_1 | rbk_valids_1),	// rename-stage.scala:240:{82,92}, :241:92, :290:37
    .io_dealloc_pregs_1_bits
      (io_rollback ? io_com_uops_1_pdst : io_com_uops_1_stale_pdst),	// rename-stage.scala:292:33
    .io_dealloc_pregs_2_valid
      (io_com_uops_2_ldst_val & _rbk_valids_2_T & io_com_valids_2 | rbk_valids_2),	// rename-stage.scala:240:{82,92}, :241:92, :290:37
    .io_dealloc_pregs_2_bits
      (io_rollback ? io_com_uops_2_pdst : io_com_uops_2_stale_pdst),	// rename-stage.scala:292:33
    .io_dealloc_pregs_3_valid
      (io_com_uops_3_ldst_val & _rbk_valids_3_T & io_com_valids_3 | rbk_valids_3),	// rename-stage.scala:240:{82,92}, :241:92, :290:37
    .io_dealloc_pregs_3_bits
      (io_rollback ? io_com_uops_3_pdst : io_com_uops_3_stale_pdst),	// rename-stage.scala:292:33
    .io_ren_br_tags_0_valid    (ren2_br_tags_0_valid),	// rename-stage.scala:238:43
    .io_ren_br_tags_0_bits     (r_uop_br_tag),	// rename-stage.scala:119:23
    .io_ren_br_tags_1_valid    (ren2_br_tags_1_valid),	// rename-stage.scala:238:43
    .io_ren_br_tags_1_bits     (r_uop_1_br_tag),	// rename-stage.scala:119:23
    .io_ren_br_tags_2_valid    (ren2_br_tags_2_valid),	// rename-stage.scala:238:43
    .io_ren_br_tags_2_bits     (r_uop_2_br_tag),	// rename-stage.scala:119:23
    .io_ren_br_tags_3_valid    (ren2_br_tags_3_valid),	// rename-stage.scala:238:43
    .io_ren_br_tags_3_bits     (r_uop_3_br_tag),	// rename-stage.scala:119:23
    .io_brupdate_b2_uop_br_tag (io_brupdate_b2_uop_br_tag),
    .io_brupdate_b2_mispredict (io_brupdate_b2_mispredict),
    .io_debug_pipeline_empty   (io_debug_rob_empty),
    .io_alloc_pregs_0_valid    (_freelist_io_alloc_pregs_0_valid),
    .io_alloc_pregs_0_bits     (_freelist_io_alloc_pregs_0_bits),
    .io_alloc_pregs_1_valid    (_freelist_io_alloc_pregs_1_valid),
    .io_alloc_pregs_1_bits     (_freelist_io_alloc_pregs_1_bits),
    .io_alloc_pregs_2_valid    (_freelist_io_alloc_pregs_2_valid),
    .io_alloc_pregs_2_bits     (_freelist_io_alloc_pregs_2_bits),
    .io_alloc_pregs_3_valid    (_freelist_io_alloc_pregs_3_valid),
    .io_alloc_pregs_3_bits     (_freelist_io_alloc_pregs_3_bits)
  );
  RenameBusyTable busytable (	// rename-stage.scala:221:25
    .clock                     (clock),
    .reset                     (reset),
    .io_ren_uops_0_pdst        (io_ren2_uops_0_newuop_pdst),	// rename-stage.scala:303:20
    .io_ren_uops_0_prs1        (r_uop_prs1),	// rename-stage.scala:119:23
    .io_ren_uops_0_prs2        (r_uop_prs2),	// rename-stage.scala:119:23
    .io_ren_uops_1_pdst        (io_ren2_uops_1_newuop_pdst),	// rename-stage.scala:303:20
    .io_ren_uops_1_prs1        (r_uop_1_prs1),	// rename-stage.scala:119:23
    .io_ren_uops_1_prs2        (r_uop_1_prs2),	// rename-stage.scala:119:23
    .io_ren_uops_2_pdst        (io_ren2_uops_2_newuop_pdst),	// rename-stage.scala:303:20
    .io_ren_uops_2_prs1        (r_uop_2_prs1),	// rename-stage.scala:119:23
    .io_ren_uops_2_prs2        (r_uop_2_prs2),	// rename-stage.scala:119:23
    .io_ren_uops_3_pdst        (io_ren2_uops_3_newuop_pdst),	// rename-stage.scala:303:20
    .io_ren_uops_3_prs1        (r_uop_3_prs1),	// rename-stage.scala:119:23
    .io_ren_uops_3_prs2        (r_uop_3_prs2),	// rename-stage.scala:119:23
    .io_rebusy_reqs_0          (ren2_alloc_reqs_0),	// rename-stage.scala:237:88
    .io_rebusy_reqs_1          (ren2_alloc_reqs_1),	// rename-stage.scala:237:88
    .io_rebusy_reqs_2          (ren2_alloc_reqs_2),	// rename-stage.scala:237:88
    .io_rebusy_reqs_3          (ren2_alloc_reqs_3),	// rename-stage.scala:237:88
    .io_wb_pdsts_0             (io_wakeups_0_bits_uop_pdst),
    .io_wb_pdsts_1             (io_wakeups_1_bits_uop_pdst),
    .io_wb_pdsts_2             (io_wakeups_2_bits_uop_pdst),
    .io_wb_pdsts_3             (io_wakeups_3_bits_uop_pdst),
    .io_wb_pdsts_4             (io_wakeups_4_bits_uop_pdst),
    .io_wb_pdsts_5             (io_wakeups_5_bits_uop_pdst),
    .io_wb_pdsts_6             (io_wakeups_6_bits_uop_pdst),
    .io_wb_pdsts_7             (io_wakeups_7_bits_uop_pdst),
    .io_wb_pdsts_8             (io_wakeups_8_bits_uop_pdst),
    .io_wb_pdsts_9             (io_wakeups_9_bits_uop_pdst),
    .io_wb_valids_0            (io_wakeups_0_valid),
    .io_wb_valids_1            (io_wakeups_1_valid),
    .io_wb_valids_2            (io_wakeups_2_valid),
    .io_wb_valids_3            (io_wakeups_3_valid),
    .io_wb_valids_4            (io_wakeups_4_valid),
    .io_wb_valids_5            (io_wakeups_5_valid),
    .io_wb_valids_6            (io_wakeups_6_valid),
    .io_wb_valids_7            (io_wakeups_7_valid),
    .io_wb_valids_8            (io_wakeups_8_valid),
    .io_wb_valids_9            (io_wakeups_9_valid),
    .io_busy_resps_0_prs1_busy (_busytable_io_busy_resps_0_prs1_busy),
    .io_busy_resps_0_prs2_busy (_busytable_io_busy_resps_0_prs2_busy),
    .io_busy_resps_1_prs1_busy (_busytable_io_busy_resps_1_prs1_busy),
    .io_busy_resps_1_prs2_busy (_busytable_io_busy_resps_1_prs2_busy),
    .io_busy_resps_2_prs1_busy (_busytable_io_busy_resps_2_prs1_busy),
    .io_busy_resps_2_prs2_busy (_busytable_io_busy_resps_2_prs2_busy),
    .io_busy_resps_3_prs1_busy (_busytable_io_busy_resps_3_prs1_busy),
    .io_busy_resps_3_prs2_busy (_busytable_io_busy_resps_3_prs2_busy)
  );
  assign io_ren_stalls_0 = _io_ren_stalls_0_T & ~_freelist_io_alloc_pregs_0_valid;	// rename-stage.scala:217:24, :237:78, :336:{60,63}
  assign io_ren_stalls_1 = _io_ren_stalls_1_T & ~_freelist_io_alloc_pregs_1_valid;	// rename-stage.scala:217:24, :237:78, :336:{60,63}
  assign io_ren_stalls_2 = _io_ren_stalls_2_T & ~_freelist_io_alloc_pregs_2_valid;	// rename-stage.scala:217:24, :237:78, :336:{60,63}
  assign io_ren_stalls_3 = _io_ren_stalls_3_T & ~_freelist_io_alloc_pregs_3_valid;	// rename-stage.scala:217:24, :237:78, :336:{60,63}
  assign io_ren2_mask_0 = r_valid;	// rename-stage.scala:118:27
  assign io_ren2_mask_1 = r_valid_1;	// rename-stage.scala:118:27
  assign io_ren2_mask_2 = r_valid_2;	// rename-stage.scala:118:27
  assign io_ren2_mask_3 = r_valid_3;	// rename-stage.scala:118:27
  assign io_ren2_uops_0_uopc = r_uop_uopc;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_inst = r_uop_inst;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_debug_inst = r_uop_debug_inst;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_is_rvc = r_uop_is_rvc;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_debug_pc = r_uop_debug_pc;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_iq_type = r_uop_iq_type;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_fu_code = r_uop_fu_code;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_ctrl_br_type = r_uop_ctrl_br_type;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_ctrl_op1_sel = r_uop_ctrl_op1_sel;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_ctrl_op2_sel = r_uop_ctrl_op2_sel;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_ctrl_imm_sel = r_uop_ctrl_imm_sel;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_ctrl_op_fcn = r_uop_ctrl_op_fcn;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_ctrl_fcn_dw = r_uop_ctrl_fcn_dw;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_ctrl_csr_cmd = r_uop_ctrl_csr_cmd;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_ctrl_is_load = r_uop_ctrl_is_load;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_ctrl_is_sta = r_uop_ctrl_is_sta;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_ctrl_is_std = r_uop_ctrl_is_std;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_iw_state = r_uop_iw_state;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_iw_p1_poisoned = r_uop_iw_p1_poisoned;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_iw_p2_poisoned = r_uop_iw_p2_poisoned;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_is_br = r_uop_is_br;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_is_jalr = r_uop_is_jalr;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_is_jal = r_uop_is_jal;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_is_sfb = r_uop_is_sfb;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_br_mask = r_uop_br_mask & ~io_brupdate_b1_resolve_mask;	// rename-stage.scala:119:23, util.scala:74:{35,37}
  assign io_ren2_uops_0_br_tag = r_uop_br_tag;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_ftq_idx = r_uop_ftq_idx;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_edge_inst = r_uop_edge_inst;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_pc_lob = r_uop_pc_lob;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_taken = r_uop_taken;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_imm_packed = r_uop_imm_packed;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_csr_addr = r_uop_csr_addr;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_rxq_idx = r_uop_rxq_idx;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_pdst = io_ren2_uops_0_newuop_pdst;	// rename-stage.scala:303:20
  assign io_ren2_uops_0_prs1 = r_uop_prs1;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_prs2 = r_uop_prs2;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_prs1_busy =
    r_uop_lrs1_rtype == 2'h0 & _busytable_io_busy_resps_0_prs1_busy;	// rename-stage.scala:119:23, :221:25, :237:78, :320:{37,47}
  assign io_ren2_uops_0_prs2_busy =
    r_uop_lrs2_rtype == 2'h0 & _busytable_io_busy_resps_0_prs2_busy;	// rename-stage.scala:119:23, :221:25, :237:78, :321:{37,47}
  assign io_ren2_uops_0_stale_pdst = r_uop_stale_pdst;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_exception = r_uop_exception;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_exc_cause = r_uop_exc_cause;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_bypassable = r_uop_bypassable;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_mem_cmd = r_uop_mem_cmd;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_mem_size = r_uop_mem_size;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_mem_signed = r_uop_mem_signed;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_is_fence = r_uop_is_fence;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_is_fencei = r_uop_is_fencei;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_is_amo = r_uop_is_amo;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_uses_ldq = r_uop_uses_ldq;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_uses_stq = r_uop_uses_stq;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_is_sys_pc2epc = r_uop_is_sys_pc2epc;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_is_unique = r_uop_is_unique;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_flush_on_commit = r_uop_flush_on_commit;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_ldst_is_rs1 = r_uop_ldst_is_rs1;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_ldst = r_uop_ldst;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_lrs1 = r_uop_lrs1;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_lrs2 = r_uop_lrs2;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_lrs3 = r_uop_lrs3;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_ldst_val = r_uop_ldst_val;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_dst_rtype = r_uop_dst_rtype;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_lrs1_rtype = r_uop_lrs1_rtype;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_lrs2_rtype = r_uop_lrs2_rtype;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_frs3_en = r_uop_frs3_en;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_fp_val = r_uop_fp_val;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_fp_single = r_uop_fp_single;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_xcpt_pf_if = r_uop_xcpt_pf_if;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_xcpt_ae_if = r_uop_xcpt_ae_if;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_xcpt_ma_if = r_uop_xcpt_ma_if;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_bp_debug_if = r_uop_bp_debug_if;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_bp_xcpt_if = r_uop_bp_xcpt_if;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_debug_fsrc = r_uop_debug_fsrc;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_debug_tsrc = r_uop_debug_tsrc;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_uopc = r_uop_1_uopc;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_inst = r_uop_1_inst;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_debug_inst = r_uop_1_debug_inst;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_is_rvc = r_uop_1_is_rvc;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_debug_pc = r_uop_1_debug_pc;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_iq_type = r_uop_1_iq_type;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_fu_code = r_uop_1_fu_code;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_ctrl_br_type = r_uop_1_ctrl_br_type;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_ctrl_op1_sel = r_uop_1_ctrl_op1_sel;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_ctrl_op2_sel = r_uop_1_ctrl_op2_sel;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_ctrl_imm_sel = r_uop_1_ctrl_imm_sel;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_ctrl_op_fcn = r_uop_1_ctrl_op_fcn;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_ctrl_fcn_dw = r_uop_1_ctrl_fcn_dw;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_ctrl_csr_cmd = r_uop_1_ctrl_csr_cmd;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_ctrl_is_load = r_uop_1_ctrl_is_load;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_ctrl_is_sta = r_uop_1_ctrl_is_sta;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_ctrl_is_std = r_uop_1_ctrl_is_std;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_iw_state = r_uop_1_iw_state;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_iw_p1_poisoned = r_uop_1_iw_p1_poisoned;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_iw_p2_poisoned = r_uop_1_iw_p2_poisoned;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_is_br = r_uop_1_is_br;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_is_jalr = r_uop_1_is_jalr;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_is_jal = r_uop_1_is_jal;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_is_sfb = r_uop_1_is_sfb;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_br_mask = r_uop_1_br_mask & ~io_brupdate_b1_resolve_mask;	// rename-stage.scala:119:23, util.scala:74:{35,37}
  assign io_ren2_uops_1_br_tag = r_uop_1_br_tag;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_ftq_idx = r_uop_1_ftq_idx;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_edge_inst = r_uop_1_edge_inst;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_pc_lob = r_uop_1_pc_lob;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_taken = r_uop_1_taken;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_imm_packed = r_uop_1_imm_packed;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_csr_addr = r_uop_1_csr_addr;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_rxq_idx = r_uop_1_rxq_idx;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_pdst = io_ren2_uops_1_newuop_pdst;	// rename-stage.scala:303:20
  assign io_ren2_uops_1_prs1 =
    bypassed_uop_bypass_sel_rs1_0 ? io_ren2_uops_0_newuop_pdst : r_uop_1_prs1;	// rename-stage.scala:119:23, :172:18, :174:77, :191:{26,52}, :303:20
  assign io_ren2_uops_1_prs2 =
    bypassed_uop_bypass_sel_rs2_0 ? io_ren2_uops_0_newuop_pdst : r_uop_1_prs2;	// rename-stage.scala:119:23, :172:18, :175:77, :192:{26,52}, :303:20
  assign io_ren2_uops_1_prs1_busy =
    r_uop_1_lrs1_rtype == 2'h0 & _busytable_io_busy_resps_1_prs1_busy
    | bypassed_uop_bypass_sel_rs1_0;	// rename-stage.scala:119:23, :174:77, :196:45, :221:25, :237:78, :320:{37,47}
  assign io_ren2_uops_1_prs2_busy =
    r_uop_1_lrs2_rtype == 2'h0 & _busytable_io_busy_resps_1_prs2_busy
    | bypassed_uop_bypass_sel_rs2_0;	// rename-stage.scala:119:23, :175:77, :197:45, :221:25, :237:78, :321:{37,47}
  assign io_ren2_uops_1_stale_pdst =
    ren2_alloc_reqs_0 & r_uop_ldst == r_uop_1_ldst
      ? io_ren2_uops_0_newuop_pdst
      : r_uop_1_stale_pdst;	// rename-stage.scala:119:23, :172:18, :177:{77,87}, :194:{26,52}, :237:88, :303:20
  assign io_ren2_uops_1_exception = r_uop_1_exception;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_exc_cause = r_uop_1_exc_cause;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_bypassable = r_uop_1_bypassable;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_mem_cmd = r_uop_1_mem_cmd;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_mem_size = r_uop_1_mem_size;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_mem_signed = r_uop_1_mem_signed;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_is_fence = r_uop_1_is_fence;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_is_fencei = r_uop_1_is_fencei;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_is_amo = r_uop_1_is_amo;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_uses_ldq = r_uop_1_uses_ldq;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_uses_stq = r_uop_1_uses_stq;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_is_sys_pc2epc = r_uop_1_is_sys_pc2epc;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_is_unique = r_uop_1_is_unique;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_flush_on_commit = r_uop_1_flush_on_commit;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_ldst_is_rs1 = r_uop_1_ldst_is_rs1;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_ldst = r_uop_1_ldst;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_lrs1 = r_uop_1_lrs1;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_lrs2 = r_uop_1_lrs2;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_lrs3 = r_uop_1_lrs3;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_ldst_val = r_uop_1_ldst_val;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_dst_rtype = r_uop_1_dst_rtype;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_lrs1_rtype = r_uop_1_lrs1_rtype;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_lrs2_rtype = r_uop_1_lrs2_rtype;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_frs3_en = r_uop_1_frs3_en;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_fp_val = r_uop_1_fp_val;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_fp_single = r_uop_1_fp_single;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_xcpt_pf_if = r_uop_1_xcpt_pf_if;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_xcpt_ae_if = r_uop_1_xcpt_ae_if;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_xcpt_ma_if = r_uop_1_xcpt_ma_if;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_bp_debug_if = r_uop_1_bp_debug_if;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_bp_xcpt_if = r_uop_1_bp_xcpt_if;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_debug_fsrc = r_uop_1_debug_fsrc;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_debug_tsrc = r_uop_1_debug_tsrc;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_uopc = r_uop_2_uopc;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_inst = r_uop_2_inst;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_debug_inst = r_uop_2_debug_inst;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_is_rvc = r_uop_2_is_rvc;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_debug_pc = r_uop_2_debug_pc;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_iq_type = r_uop_2_iq_type;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_fu_code = r_uop_2_fu_code;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_ctrl_br_type = r_uop_2_ctrl_br_type;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_ctrl_op1_sel = r_uop_2_ctrl_op1_sel;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_ctrl_op2_sel = r_uop_2_ctrl_op2_sel;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_ctrl_imm_sel = r_uop_2_ctrl_imm_sel;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_ctrl_op_fcn = r_uop_2_ctrl_op_fcn;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_ctrl_fcn_dw = r_uop_2_ctrl_fcn_dw;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_ctrl_csr_cmd = r_uop_2_ctrl_csr_cmd;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_ctrl_is_load = r_uop_2_ctrl_is_load;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_ctrl_is_sta = r_uop_2_ctrl_is_sta;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_ctrl_is_std = r_uop_2_ctrl_is_std;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_iw_state = r_uop_2_iw_state;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_iw_p1_poisoned = r_uop_2_iw_p1_poisoned;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_iw_p2_poisoned = r_uop_2_iw_p2_poisoned;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_is_br = r_uop_2_is_br;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_is_jalr = r_uop_2_is_jalr;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_is_jal = r_uop_2_is_jal;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_is_sfb = r_uop_2_is_sfb;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_br_mask = r_uop_2_br_mask & ~io_brupdate_b1_resolve_mask;	// rename-stage.scala:119:23, util.scala:74:{35,37}
  assign io_ren2_uops_2_br_tag = r_uop_2_br_tag;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_ftq_idx = r_uop_2_ftq_idx;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_edge_inst = r_uop_2_edge_inst;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_pc_lob = r_uop_2_pc_lob;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_taken = r_uop_2_taken;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_imm_packed = r_uop_2_imm_packed;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_csr_addr = r_uop_2_csr_addr;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_rxq_idx = r_uop_2_rxq_idx;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_pdst = io_ren2_uops_2_newuop_pdst;	// rename-stage.scala:303:20
  assign io_ren2_uops_2_prs1 =
    bypassed_uop_do_bypass_rs1
      ? (bypassed_uop_bypass_sel_rs1_enc_1[1] & (|r_uop_ldst)
           ? _freelist_io_alloc_pregs_0_bits
           : 7'h0)
        | (bypassed_uop_bypass_sel_rs1_enc_1[0] & (|r_uop_1_ldst)
             ? _freelist_io_alloc_pregs_1_bits
             : 7'h0)
      : r_uop_2_prs1;	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :172:18, :184:49, :191:{26,52}, :201:30, :217:24, :303:30
  assign io_ren2_uops_2_prs2 =
    bypassed_uop_do_bypass_rs2
      ? (bypassed_uop_bypass_sel_rs2_enc_1[1] & (|r_uop_ldst)
           ? _freelist_io_alloc_pregs_0_bits
           : 7'h0)
        | (bypassed_uop_bypass_sel_rs2_enc_1[0] & (|r_uop_1_ldst)
             ? _freelist_io_alloc_pregs_1_bits
             : 7'h0)
      : r_uop_2_prs2;	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :172:18, :185:49, :192:{26,52}, :201:30, :217:24, :303:30
  assign io_ren2_uops_2_prs1_busy =
    r_uop_2_lrs1_rtype == 2'h0 & _busytable_io_busy_resps_2_prs1_busy
    | bypassed_uop_do_bypass_rs1;	// rename-stage.scala:119:23, :184:49, :196:45, :221:25, :237:78, :320:{37,47}
  assign io_ren2_uops_2_prs2_busy =
    r_uop_2_lrs2_rtype == 2'h0 & _busytable_io_busy_resps_2_prs2_busy
    | bypassed_uop_do_bypass_rs2;	// rename-stage.scala:119:23, :185:49, :197:45, :221:25, :237:78, :321:{37,47}
  assign io_ren2_uops_2_stale_pdst =
    bypassed_uop_bypass_hits_dst_0_1 | bypassed_uop_bypass_hits_dst_1
      ? (bypassed_uop_bypass_sel_dst_enc_1[1] & (|r_uop_ldst)
           ? _freelist_io_alloc_pregs_0_bits
           : 7'h0)
        | (bypassed_uop_bypass_sel_dst_enc_1[0] & (|r_uop_1_ldst)
             ? _freelist_io_alloc_pregs_1_bits
             : 7'h0)
      : r_uop_2_stale_pdst;	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :172:18, :177:77, :187:49, :194:{26,52}, :201:30, :217:24, :303:30
  assign io_ren2_uops_2_exception = r_uop_2_exception;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_exc_cause = r_uop_2_exc_cause;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_bypassable = r_uop_2_bypassable;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_mem_cmd = r_uop_2_mem_cmd;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_mem_size = r_uop_2_mem_size;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_mem_signed = r_uop_2_mem_signed;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_is_fence = r_uop_2_is_fence;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_is_fencei = r_uop_2_is_fencei;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_is_amo = r_uop_2_is_amo;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_uses_ldq = r_uop_2_uses_ldq;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_uses_stq = r_uop_2_uses_stq;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_is_sys_pc2epc = r_uop_2_is_sys_pc2epc;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_is_unique = r_uop_2_is_unique;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_flush_on_commit = r_uop_2_flush_on_commit;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_ldst_is_rs1 = r_uop_2_ldst_is_rs1;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_ldst = r_uop_2_ldst;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_lrs1 = r_uop_2_lrs1;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_lrs2 = r_uop_2_lrs2;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_lrs3 = r_uop_2_lrs3;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_ldst_val = r_uop_2_ldst_val;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_dst_rtype = r_uop_2_dst_rtype;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_lrs1_rtype = r_uop_2_lrs1_rtype;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_lrs2_rtype = r_uop_2_lrs2_rtype;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_frs3_en = r_uop_2_frs3_en;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_fp_val = r_uop_2_fp_val;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_fp_single = r_uop_2_fp_single;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_xcpt_pf_if = r_uop_2_xcpt_pf_if;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_xcpt_ae_if = r_uop_2_xcpt_ae_if;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_xcpt_ma_if = r_uop_2_xcpt_ma_if;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_bp_debug_if = r_uop_2_bp_debug_if;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_bp_xcpt_if = r_uop_2_bp_xcpt_if;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_debug_fsrc = r_uop_2_debug_fsrc;	// rename-stage.scala:119:23
  assign io_ren2_uops_2_debug_tsrc = r_uop_2_debug_tsrc;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_uopc = r_uop_3_uopc;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_inst = r_uop_3_inst;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_debug_inst = r_uop_3_debug_inst;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_is_rvc = r_uop_3_is_rvc;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_debug_pc = r_uop_3_debug_pc;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_iq_type = r_uop_3_iq_type;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_fu_code = r_uop_3_fu_code;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_ctrl_br_type = r_uop_3_ctrl_br_type;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_ctrl_op1_sel = r_uop_3_ctrl_op1_sel;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_ctrl_op2_sel = r_uop_3_ctrl_op2_sel;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_ctrl_imm_sel = r_uop_3_ctrl_imm_sel;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_ctrl_op_fcn = r_uop_3_ctrl_op_fcn;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_ctrl_fcn_dw = r_uop_3_ctrl_fcn_dw;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_ctrl_csr_cmd = r_uop_3_ctrl_csr_cmd;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_ctrl_is_load = r_uop_3_ctrl_is_load;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_ctrl_is_sta = r_uop_3_ctrl_is_sta;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_ctrl_is_std = r_uop_3_ctrl_is_std;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_iw_state = r_uop_3_iw_state;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_iw_p1_poisoned = r_uop_3_iw_p1_poisoned;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_iw_p2_poisoned = r_uop_3_iw_p2_poisoned;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_is_br = r_uop_3_is_br;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_is_jalr = r_uop_3_is_jalr;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_is_jal = r_uop_3_is_jal;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_is_sfb = r_uop_3_is_sfb;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_br_mask = r_uop_3_br_mask & ~io_brupdate_b1_resolve_mask;	// rename-stage.scala:119:23, util.scala:74:{35,37}
  assign io_ren2_uops_3_br_tag = r_uop_3_br_tag;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_ftq_idx = r_uop_3_ftq_idx;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_edge_inst = r_uop_3_edge_inst;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_pc_lob = r_uop_3_pc_lob;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_taken = r_uop_3_taken;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_imm_packed = r_uop_3_imm_packed;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_csr_addr = r_uop_3_csr_addr;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_rxq_idx = r_uop_3_rxq_idx;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_pdst = io_ren2_uops_3_newuop_pdst;	// rename-stage.scala:303:20
  assign io_ren2_uops_3_prs1 =
    bypassed_uop_do_bypass_rs1_1
      ? (bypassed_uop_bypass_sel_rs1_enc_2[2] & (|r_uop_ldst)
           ? _freelist_io_alloc_pregs_0_bits
           : 7'h0)
        | (bypassed_uop_bypass_sel_rs1_enc_2[1] & (|r_uop_1_ldst)
             ? _freelist_io_alloc_pregs_1_bits
             : 7'h0)
        | (bypassed_uop_bypass_sel_rs1_enc_2[0] & (|r_uop_2_ldst)
             ? _freelist_io_alloc_pregs_2_bits
             : 7'h0)
      : r_uop_3_prs1;	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :172:18, :184:49, :191:{26,52}, :201:30, :217:24, :303:30
  assign io_ren2_uops_3_prs2 =
    bypassed_uop_do_bypass_rs2_1
      ? (bypassed_uop_bypass_sel_rs2_enc_2[2] & (|r_uop_ldst)
           ? _freelist_io_alloc_pregs_0_bits
           : 7'h0)
        | (bypassed_uop_bypass_sel_rs2_enc_2[1] & (|r_uop_1_ldst)
             ? _freelist_io_alloc_pregs_1_bits
             : 7'h0)
        | (bypassed_uop_bypass_sel_rs2_enc_2[0] & (|r_uop_2_ldst)
             ? _freelist_io_alloc_pregs_2_bits
             : 7'h0)
      : r_uop_3_prs2;	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :172:18, :185:49, :192:{26,52}, :201:30, :217:24, :303:30
  assign io_ren2_uops_3_prs1_busy =
    r_uop_3_lrs1_rtype == 2'h0 & _busytable_io_busy_resps_3_prs1_busy
    | bypassed_uop_do_bypass_rs1_1;	// rename-stage.scala:119:23, :184:49, :196:45, :221:25, :237:78, :320:{37,47}
  assign io_ren2_uops_3_prs2_busy =
    r_uop_3_lrs2_rtype == 2'h0 & _busytable_io_busy_resps_3_prs2_busy
    | bypassed_uop_do_bypass_rs2_1;	// rename-stage.scala:119:23, :185:49, :197:45, :221:25, :237:78, :321:{37,47}
  assign io_ren2_uops_3_stale_pdst =
    bypassed_uop_bypass_hits_dst_0_2 | bypassed_uop_bypass_hits_dst_1_1
    | bypassed_uop_bypass_hits_dst_2
      ? (bypassed_uop_bypass_sel_dst_enc_2[2] & (|r_uop_ldst)
           ? _freelist_io_alloc_pregs_0_bits
           : 7'h0)
        | (bypassed_uop_bypass_sel_dst_enc_2[1] & (|r_uop_1_ldst)
             ? _freelist_io_alloc_pregs_1_bits
             : 7'h0)
        | (bypassed_uop_bypass_sel_dst_enc_2[0] & (|r_uop_2_ldst)
             ? _freelist_io_alloc_pregs_2_bits
             : 7'h0)
      : r_uop_3_stale_pdst;	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :172:18, :177:77, :187:49, :194:{26,52}, :201:30, :217:24, :303:30
  assign io_ren2_uops_3_exception = r_uop_3_exception;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_exc_cause = r_uop_3_exc_cause;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_bypassable = r_uop_3_bypassable;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_mem_cmd = r_uop_3_mem_cmd;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_mem_size = r_uop_3_mem_size;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_mem_signed = r_uop_3_mem_signed;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_is_fence = r_uop_3_is_fence;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_is_fencei = r_uop_3_is_fencei;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_is_amo = r_uop_3_is_amo;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_uses_ldq = r_uop_3_uses_ldq;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_uses_stq = r_uop_3_uses_stq;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_is_sys_pc2epc = r_uop_3_is_sys_pc2epc;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_is_unique = r_uop_3_is_unique;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_flush_on_commit = r_uop_3_flush_on_commit;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_ldst_is_rs1 = r_uop_3_ldst_is_rs1;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_ldst = r_uop_3_ldst;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_lrs1 = r_uop_3_lrs1;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_lrs2 = r_uop_3_lrs2;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_lrs3 = r_uop_3_lrs3;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_ldst_val = r_uop_3_ldst_val;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_dst_rtype = r_uop_3_dst_rtype;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_lrs1_rtype = r_uop_3_lrs1_rtype;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_lrs2_rtype = r_uop_3_lrs2_rtype;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_frs3_en = r_uop_3_frs3_en;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_fp_val = r_uop_3_fp_val;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_fp_single = r_uop_3_fp_single;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_xcpt_pf_if = r_uop_3_xcpt_pf_if;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_xcpt_ae_if = r_uop_3_xcpt_ae_if;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_xcpt_ma_if = r_uop_3_xcpt_ma_if;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_bp_debug_if = r_uop_3_bp_debug_if;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_bp_xcpt_if = r_uop_3_bp_xcpt_if;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_debug_fsrc = r_uop_3_debug_fsrc;	// rename-stage.scala:119:23
  assign io_ren2_uops_3_debug_tsrc = r_uop_3_debug_tsrc;	// rename-stage.scala:119:23
endmodule

