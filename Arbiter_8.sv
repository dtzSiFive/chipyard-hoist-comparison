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

module Arbiter_8(
  input         io_in_0_valid,
  input  [6:0]  io_in_0_bits_uop_uopc,
  input  [31:0] io_in_0_bits_uop_inst,
                io_in_0_bits_uop_debug_inst,
  input         io_in_0_bits_uop_is_rvc,
  input  [39:0] io_in_0_bits_uop_debug_pc,
  input  [2:0]  io_in_0_bits_uop_iq_type,
  input  [9:0]  io_in_0_bits_uop_fu_code,
  input  [3:0]  io_in_0_bits_uop_ctrl_br_type,
  input  [1:0]  io_in_0_bits_uop_ctrl_op1_sel,
  input  [2:0]  io_in_0_bits_uop_ctrl_op2_sel,
                io_in_0_bits_uop_ctrl_imm_sel,
  input  [3:0]  io_in_0_bits_uop_ctrl_op_fcn,
  input         io_in_0_bits_uop_ctrl_fcn_dw,
  input  [2:0]  io_in_0_bits_uop_ctrl_csr_cmd,
  input         io_in_0_bits_uop_ctrl_is_load,
                io_in_0_bits_uop_ctrl_is_sta,
                io_in_0_bits_uop_ctrl_is_std,
  input  [1:0]  io_in_0_bits_uop_iw_state,
  input         io_in_0_bits_uop_iw_p1_poisoned,
                io_in_0_bits_uop_iw_p2_poisoned,
                io_in_0_bits_uop_is_br,
                io_in_0_bits_uop_is_jalr,
                io_in_0_bits_uop_is_jal,
                io_in_0_bits_uop_is_sfb,
  input  [19:0] io_in_0_bits_uop_br_mask,
  input  [4:0]  io_in_0_bits_uop_br_tag,
  input  [5:0]  io_in_0_bits_uop_ftq_idx,
  input         io_in_0_bits_uop_edge_inst,
  input  [5:0]  io_in_0_bits_uop_pc_lob,
  input         io_in_0_bits_uop_taken,
  input  [19:0] io_in_0_bits_uop_imm_packed,
  input  [11:0] io_in_0_bits_uop_csr_addr,
  input  [6:0]  io_in_0_bits_uop_rob_idx,
  input  [4:0]  io_in_0_bits_uop_ldq_idx,
                io_in_0_bits_uop_stq_idx,
  input  [1:0]  io_in_0_bits_uop_rxq_idx,
  input  [6:0]  io_in_0_bits_uop_pdst,
                io_in_0_bits_uop_prs1,
                io_in_0_bits_uop_prs2,
                io_in_0_bits_uop_prs3,
  input  [5:0]  io_in_0_bits_uop_ppred,
  input         io_in_0_bits_uop_prs1_busy,
                io_in_0_bits_uop_prs2_busy,
                io_in_0_bits_uop_prs3_busy,
                io_in_0_bits_uop_ppred_busy,
  input  [6:0]  io_in_0_bits_uop_stale_pdst,
  input         io_in_0_bits_uop_exception,
  input  [63:0] io_in_0_bits_uop_exc_cause,
  input         io_in_0_bits_uop_bypassable,
  input  [4:0]  io_in_0_bits_uop_mem_cmd,
  input  [1:0]  io_in_0_bits_uop_mem_size,
  input         io_in_0_bits_uop_mem_signed,
                io_in_0_bits_uop_is_fence,
                io_in_0_bits_uop_is_fencei,
                io_in_0_bits_uop_is_amo,
                io_in_0_bits_uop_uses_ldq,
                io_in_0_bits_uop_uses_stq,
                io_in_0_bits_uop_is_sys_pc2epc,
                io_in_0_bits_uop_is_unique,
                io_in_0_bits_uop_flush_on_commit,
                io_in_0_bits_uop_ldst_is_rs1,
  input  [5:0]  io_in_0_bits_uop_ldst,
                io_in_0_bits_uop_lrs1,
                io_in_0_bits_uop_lrs2,
                io_in_0_bits_uop_lrs3,
  input         io_in_0_bits_uop_ldst_val,
  input  [1:0]  io_in_0_bits_uop_dst_rtype,
                io_in_0_bits_uop_lrs1_rtype,
                io_in_0_bits_uop_lrs2_rtype,
  input         io_in_0_bits_uop_frs3_en,
                io_in_0_bits_uop_fp_val,
                io_in_0_bits_uop_fp_single,
                io_in_0_bits_uop_xcpt_pf_if,
                io_in_0_bits_uop_xcpt_ae_if,
                io_in_0_bits_uop_xcpt_ma_if,
                io_in_0_bits_uop_bp_debug_if,
                io_in_0_bits_uop_bp_xcpt_if,
  input  [1:0]  io_in_0_bits_uop_debug_fsrc,
                io_in_0_bits_uop_debug_tsrc,
  input  [39:0] io_in_0_bits_addr,
  input         io_in_0_bits_is_hella,
  input  [7:0]  io_in_0_bits_way_en,
  input  [4:0]  io_in_0_bits_sdq_id,
  input         io_in_1_valid,
  input  [6:0]  io_in_1_bits_uop_uopc,
  input  [31:0] io_in_1_bits_uop_inst,
                io_in_1_bits_uop_debug_inst,
  input         io_in_1_bits_uop_is_rvc,
  input  [39:0] io_in_1_bits_uop_debug_pc,
  input  [2:0]  io_in_1_bits_uop_iq_type,
  input  [9:0]  io_in_1_bits_uop_fu_code,
  input  [3:0]  io_in_1_bits_uop_ctrl_br_type,
  input  [1:0]  io_in_1_bits_uop_ctrl_op1_sel,
  input  [2:0]  io_in_1_bits_uop_ctrl_op2_sel,
                io_in_1_bits_uop_ctrl_imm_sel,
  input  [3:0]  io_in_1_bits_uop_ctrl_op_fcn,
  input         io_in_1_bits_uop_ctrl_fcn_dw,
  input  [2:0]  io_in_1_bits_uop_ctrl_csr_cmd,
  input         io_in_1_bits_uop_ctrl_is_load,
                io_in_1_bits_uop_ctrl_is_sta,
                io_in_1_bits_uop_ctrl_is_std,
  input  [1:0]  io_in_1_bits_uop_iw_state,
  input         io_in_1_bits_uop_iw_p1_poisoned,
                io_in_1_bits_uop_iw_p2_poisoned,
                io_in_1_bits_uop_is_br,
                io_in_1_bits_uop_is_jalr,
                io_in_1_bits_uop_is_jal,
                io_in_1_bits_uop_is_sfb,
  input  [19:0] io_in_1_bits_uop_br_mask,
  input  [4:0]  io_in_1_bits_uop_br_tag,
  input  [5:0]  io_in_1_bits_uop_ftq_idx,
  input         io_in_1_bits_uop_edge_inst,
  input  [5:0]  io_in_1_bits_uop_pc_lob,
  input         io_in_1_bits_uop_taken,
  input  [19:0] io_in_1_bits_uop_imm_packed,
  input  [11:0] io_in_1_bits_uop_csr_addr,
  input  [6:0]  io_in_1_bits_uop_rob_idx,
  input  [4:0]  io_in_1_bits_uop_ldq_idx,
                io_in_1_bits_uop_stq_idx,
  input  [1:0]  io_in_1_bits_uop_rxq_idx,
  input  [6:0]  io_in_1_bits_uop_pdst,
                io_in_1_bits_uop_prs1,
                io_in_1_bits_uop_prs2,
                io_in_1_bits_uop_prs3,
  input  [5:0]  io_in_1_bits_uop_ppred,
  input         io_in_1_bits_uop_prs1_busy,
                io_in_1_bits_uop_prs2_busy,
                io_in_1_bits_uop_prs3_busy,
                io_in_1_bits_uop_ppred_busy,
  input  [6:0]  io_in_1_bits_uop_stale_pdst,
  input         io_in_1_bits_uop_exception,
  input  [63:0] io_in_1_bits_uop_exc_cause,
  input         io_in_1_bits_uop_bypassable,
  input  [4:0]  io_in_1_bits_uop_mem_cmd,
  input  [1:0]  io_in_1_bits_uop_mem_size,
  input         io_in_1_bits_uop_mem_signed,
                io_in_1_bits_uop_is_fence,
                io_in_1_bits_uop_is_fencei,
                io_in_1_bits_uop_is_amo,
                io_in_1_bits_uop_uses_ldq,
                io_in_1_bits_uop_uses_stq,
                io_in_1_bits_uop_is_sys_pc2epc,
                io_in_1_bits_uop_is_unique,
                io_in_1_bits_uop_flush_on_commit,
                io_in_1_bits_uop_ldst_is_rs1,
  input  [5:0]  io_in_1_bits_uop_ldst,
                io_in_1_bits_uop_lrs1,
                io_in_1_bits_uop_lrs2,
                io_in_1_bits_uop_lrs3,
  input         io_in_1_bits_uop_ldst_val,
  input  [1:0]  io_in_1_bits_uop_dst_rtype,
                io_in_1_bits_uop_lrs1_rtype,
                io_in_1_bits_uop_lrs2_rtype,
  input         io_in_1_bits_uop_frs3_en,
                io_in_1_bits_uop_fp_val,
                io_in_1_bits_uop_fp_single,
                io_in_1_bits_uop_xcpt_pf_if,
                io_in_1_bits_uop_xcpt_ae_if,
                io_in_1_bits_uop_xcpt_ma_if,
                io_in_1_bits_uop_bp_debug_if,
                io_in_1_bits_uop_bp_xcpt_if,
  input  [1:0]  io_in_1_bits_uop_debug_fsrc,
                io_in_1_bits_uop_debug_tsrc,
  input  [39:0] io_in_1_bits_addr,
  input         io_in_1_bits_is_hella,
  input  [7:0]  io_in_1_bits_way_en,
  input  [4:0]  io_in_1_bits_sdq_id,
  input         io_in_2_valid,
  input  [6:0]  io_in_2_bits_uop_uopc,
  input  [31:0] io_in_2_bits_uop_inst,
                io_in_2_bits_uop_debug_inst,
  input         io_in_2_bits_uop_is_rvc,
  input  [39:0] io_in_2_bits_uop_debug_pc,
  input  [2:0]  io_in_2_bits_uop_iq_type,
  input  [9:0]  io_in_2_bits_uop_fu_code,
  input  [3:0]  io_in_2_bits_uop_ctrl_br_type,
  input  [1:0]  io_in_2_bits_uop_ctrl_op1_sel,
  input  [2:0]  io_in_2_bits_uop_ctrl_op2_sel,
                io_in_2_bits_uop_ctrl_imm_sel,
  input  [3:0]  io_in_2_bits_uop_ctrl_op_fcn,
  input         io_in_2_bits_uop_ctrl_fcn_dw,
  input  [2:0]  io_in_2_bits_uop_ctrl_csr_cmd,
  input         io_in_2_bits_uop_ctrl_is_load,
                io_in_2_bits_uop_ctrl_is_sta,
                io_in_2_bits_uop_ctrl_is_std,
  input  [1:0]  io_in_2_bits_uop_iw_state,
  input         io_in_2_bits_uop_iw_p1_poisoned,
                io_in_2_bits_uop_iw_p2_poisoned,
                io_in_2_bits_uop_is_br,
                io_in_2_bits_uop_is_jalr,
                io_in_2_bits_uop_is_jal,
                io_in_2_bits_uop_is_sfb,
  input  [19:0] io_in_2_bits_uop_br_mask,
  input  [4:0]  io_in_2_bits_uop_br_tag,
  input  [5:0]  io_in_2_bits_uop_ftq_idx,
  input         io_in_2_bits_uop_edge_inst,
  input  [5:0]  io_in_2_bits_uop_pc_lob,
  input         io_in_2_bits_uop_taken,
  input  [19:0] io_in_2_bits_uop_imm_packed,
  input  [11:0] io_in_2_bits_uop_csr_addr,
  input  [6:0]  io_in_2_bits_uop_rob_idx,
  input  [4:0]  io_in_2_bits_uop_ldq_idx,
                io_in_2_bits_uop_stq_idx,
  input  [1:0]  io_in_2_bits_uop_rxq_idx,
  input  [6:0]  io_in_2_bits_uop_pdst,
                io_in_2_bits_uop_prs1,
                io_in_2_bits_uop_prs2,
                io_in_2_bits_uop_prs3,
  input  [5:0]  io_in_2_bits_uop_ppred,
  input         io_in_2_bits_uop_prs1_busy,
                io_in_2_bits_uop_prs2_busy,
                io_in_2_bits_uop_prs3_busy,
                io_in_2_bits_uop_ppred_busy,
  input  [6:0]  io_in_2_bits_uop_stale_pdst,
  input         io_in_2_bits_uop_exception,
  input  [63:0] io_in_2_bits_uop_exc_cause,
  input         io_in_2_bits_uop_bypassable,
  input  [4:0]  io_in_2_bits_uop_mem_cmd,
  input  [1:0]  io_in_2_bits_uop_mem_size,
  input         io_in_2_bits_uop_mem_signed,
                io_in_2_bits_uop_is_fence,
                io_in_2_bits_uop_is_fencei,
                io_in_2_bits_uop_is_amo,
                io_in_2_bits_uop_uses_ldq,
                io_in_2_bits_uop_uses_stq,
                io_in_2_bits_uop_is_sys_pc2epc,
                io_in_2_bits_uop_is_unique,
                io_in_2_bits_uop_flush_on_commit,
                io_in_2_bits_uop_ldst_is_rs1,
  input  [5:0]  io_in_2_bits_uop_ldst,
                io_in_2_bits_uop_lrs1,
                io_in_2_bits_uop_lrs2,
                io_in_2_bits_uop_lrs3,
  input         io_in_2_bits_uop_ldst_val,
  input  [1:0]  io_in_2_bits_uop_dst_rtype,
                io_in_2_bits_uop_lrs1_rtype,
                io_in_2_bits_uop_lrs2_rtype,
  input         io_in_2_bits_uop_frs3_en,
                io_in_2_bits_uop_fp_val,
                io_in_2_bits_uop_fp_single,
                io_in_2_bits_uop_xcpt_pf_if,
                io_in_2_bits_uop_xcpt_ae_if,
                io_in_2_bits_uop_xcpt_ma_if,
                io_in_2_bits_uop_bp_debug_if,
                io_in_2_bits_uop_bp_xcpt_if,
  input  [1:0]  io_in_2_bits_uop_debug_fsrc,
                io_in_2_bits_uop_debug_tsrc,
  input  [39:0] io_in_2_bits_addr,
  input         io_in_2_bits_is_hella,
  input  [7:0]  io_in_2_bits_way_en,
  input  [4:0]  io_in_2_bits_sdq_id,
  input         io_in_3_valid,
  input  [6:0]  io_in_3_bits_uop_uopc,
  input  [31:0] io_in_3_bits_uop_inst,
                io_in_3_bits_uop_debug_inst,
  input         io_in_3_bits_uop_is_rvc,
  input  [39:0] io_in_3_bits_uop_debug_pc,
  input  [2:0]  io_in_3_bits_uop_iq_type,
  input  [9:0]  io_in_3_bits_uop_fu_code,
  input  [3:0]  io_in_3_bits_uop_ctrl_br_type,
  input  [1:0]  io_in_3_bits_uop_ctrl_op1_sel,
  input  [2:0]  io_in_3_bits_uop_ctrl_op2_sel,
                io_in_3_bits_uop_ctrl_imm_sel,
  input  [3:0]  io_in_3_bits_uop_ctrl_op_fcn,
  input         io_in_3_bits_uop_ctrl_fcn_dw,
  input  [2:0]  io_in_3_bits_uop_ctrl_csr_cmd,
  input         io_in_3_bits_uop_ctrl_is_load,
                io_in_3_bits_uop_ctrl_is_sta,
                io_in_3_bits_uop_ctrl_is_std,
  input  [1:0]  io_in_3_bits_uop_iw_state,
  input         io_in_3_bits_uop_iw_p1_poisoned,
                io_in_3_bits_uop_iw_p2_poisoned,
                io_in_3_bits_uop_is_br,
                io_in_3_bits_uop_is_jalr,
                io_in_3_bits_uop_is_jal,
                io_in_3_bits_uop_is_sfb,
  input  [19:0] io_in_3_bits_uop_br_mask,
  input  [4:0]  io_in_3_bits_uop_br_tag,
  input  [5:0]  io_in_3_bits_uop_ftq_idx,
  input         io_in_3_bits_uop_edge_inst,
  input  [5:0]  io_in_3_bits_uop_pc_lob,
  input         io_in_3_bits_uop_taken,
  input  [19:0] io_in_3_bits_uop_imm_packed,
  input  [11:0] io_in_3_bits_uop_csr_addr,
  input  [6:0]  io_in_3_bits_uop_rob_idx,
  input  [4:0]  io_in_3_bits_uop_ldq_idx,
                io_in_3_bits_uop_stq_idx,
  input  [1:0]  io_in_3_bits_uop_rxq_idx,
  input  [6:0]  io_in_3_bits_uop_pdst,
                io_in_3_bits_uop_prs1,
                io_in_3_bits_uop_prs2,
                io_in_3_bits_uop_prs3,
  input  [5:0]  io_in_3_bits_uop_ppred,
  input         io_in_3_bits_uop_prs1_busy,
                io_in_3_bits_uop_prs2_busy,
                io_in_3_bits_uop_prs3_busy,
                io_in_3_bits_uop_ppred_busy,
  input  [6:0]  io_in_3_bits_uop_stale_pdst,
  input         io_in_3_bits_uop_exception,
  input  [63:0] io_in_3_bits_uop_exc_cause,
  input         io_in_3_bits_uop_bypassable,
  input  [4:0]  io_in_3_bits_uop_mem_cmd,
  input  [1:0]  io_in_3_bits_uop_mem_size,
  input         io_in_3_bits_uop_mem_signed,
                io_in_3_bits_uop_is_fence,
                io_in_3_bits_uop_is_fencei,
                io_in_3_bits_uop_is_amo,
                io_in_3_bits_uop_uses_ldq,
                io_in_3_bits_uop_uses_stq,
                io_in_3_bits_uop_is_sys_pc2epc,
                io_in_3_bits_uop_is_unique,
                io_in_3_bits_uop_flush_on_commit,
                io_in_3_bits_uop_ldst_is_rs1,
  input  [5:0]  io_in_3_bits_uop_ldst,
                io_in_3_bits_uop_lrs1,
                io_in_3_bits_uop_lrs2,
                io_in_3_bits_uop_lrs3,
  input         io_in_3_bits_uop_ldst_val,
  input  [1:0]  io_in_3_bits_uop_dst_rtype,
                io_in_3_bits_uop_lrs1_rtype,
                io_in_3_bits_uop_lrs2_rtype,
  input         io_in_3_bits_uop_frs3_en,
                io_in_3_bits_uop_fp_val,
                io_in_3_bits_uop_fp_single,
                io_in_3_bits_uop_xcpt_pf_if,
                io_in_3_bits_uop_xcpt_ae_if,
                io_in_3_bits_uop_xcpt_ma_if,
                io_in_3_bits_uop_bp_debug_if,
                io_in_3_bits_uop_bp_xcpt_if,
  input  [1:0]  io_in_3_bits_uop_debug_fsrc,
                io_in_3_bits_uop_debug_tsrc,
  input  [39:0] io_in_3_bits_addr,
  input         io_in_3_bits_is_hella,
  input  [7:0]  io_in_3_bits_way_en,
  input  [4:0]  io_in_3_bits_sdq_id,
  input         io_in_4_valid,
  input  [6:0]  io_in_4_bits_uop_uopc,
  input  [31:0] io_in_4_bits_uop_inst,
                io_in_4_bits_uop_debug_inst,
  input         io_in_4_bits_uop_is_rvc,
  input  [39:0] io_in_4_bits_uop_debug_pc,
  input  [2:0]  io_in_4_bits_uop_iq_type,
  input  [9:0]  io_in_4_bits_uop_fu_code,
  input  [3:0]  io_in_4_bits_uop_ctrl_br_type,
  input  [1:0]  io_in_4_bits_uop_ctrl_op1_sel,
  input  [2:0]  io_in_4_bits_uop_ctrl_op2_sel,
                io_in_4_bits_uop_ctrl_imm_sel,
  input  [3:0]  io_in_4_bits_uop_ctrl_op_fcn,
  input         io_in_4_bits_uop_ctrl_fcn_dw,
  input  [2:0]  io_in_4_bits_uop_ctrl_csr_cmd,
  input         io_in_4_bits_uop_ctrl_is_load,
                io_in_4_bits_uop_ctrl_is_sta,
                io_in_4_bits_uop_ctrl_is_std,
  input  [1:0]  io_in_4_bits_uop_iw_state,
  input         io_in_4_bits_uop_iw_p1_poisoned,
                io_in_4_bits_uop_iw_p2_poisoned,
                io_in_4_bits_uop_is_br,
                io_in_4_bits_uop_is_jalr,
                io_in_4_bits_uop_is_jal,
                io_in_4_bits_uop_is_sfb,
  input  [19:0] io_in_4_bits_uop_br_mask,
  input  [4:0]  io_in_4_bits_uop_br_tag,
  input  [5:0]  io_in_4_bits_uop_ftq_idx,
  input         io_in_4_bits_uop_edge_inst,
  input  [5:0]  io_in_4_bits_uop_pc_lob,
  input         io_in_4_bits_uop_taken,
  input  [19:0] io_in_4_bits_uop_imm_packed,
  input  [11:0] io_in_4_bits_uop_csr_addr,
  input  [6:0]  io_in_4_bits_uop_rob_idx,
  input  [4:0]  io_in_4_bits_uop_ldq_idx,
                io_in_4_bits_uop_stq_idx,
  input  [1:0]  io_in_4_bits_uop_rxq_idx,
  input  [6:0]  io_in_4_bits_uop_pdst,
                io_in_4_bits_uop_prs1,
                io_in_4_bits_uop_prs2,
                io_in_4_bits_uop_prs3,
  input  [5:0]  io_in_4_bits_uop_ppred,
  input         io_in_4_bits_uop_prs1_busy,
                io_in_4_bits_uop_prs2_busy,
                io_in_4_bits_uop_prs3_busy,
                io_in_4_bits_uop_ppred_busy,
  input  [6:0]  io_in_4_bits_uop_stale_pdst,
  input         io_in_4_bits_uop_exception,
  input  [63:0] io_in_4_bits_uop_exc_cause,
  input         io_in_4_bits_uop_bypassable,
  input  [4:0]  io_in_4_bits_uop_mem_cmd,
  input  [1:0]  io_in_4_bits_uop_mem_size,
  input         io_in_4_bits_uop_mem_signed,
                io_in_4_bits_uop_is_fence,
                io_in_4_bits_uop_is_fencei,
                io_in_4_bits_uop_is_amo,
                io_in_4_bits_uop_uses_ldq,
                io_in_4_bits_uop_uses_stq,
                io_in_4_bits_uop_is_sys_pc2epc,
                io_in_4_bits_uop_is_unique,
                io_in_4_bits_uop_flush_on_commit,
                io_in_4_bits_uop_ldst_is_rs1,
  input  [5:0]  io_in_4_bits_uop_ldst,
                io_in_4_bits_uop_lrs1,
                io_in_4_bits_uop_lrs2,
                io_in_4_bits_uop_lrs3,
  input         io_in_4_bits_uop_ldst_val,
  input  [1:0]  io_in_4_bits_uop_dst_rtype,
                io_in_4_bits_uop_lrs1_rtype,
                io_in_4_bits_uop_lrs2_rtype,
  input         io_in_4_bits_uop_frs3_en,
                io_in_4_bits_uop_fp_val,
                io_in_4_bits_uop_fp_single,
                io_in_4_bits_uop_xcpt_pf_if,
                io_in_4_bits_uop_xcpt_ae_if,
                io_in_4_bits_uop_xcpt_ma_if,
                io_in_4_bits_uop_bp_debug_if,
                io_in_4_bits_uop_bp_xcpt_if,
  input  [1:0]  io_in_4_bits_uop_debug_fsrc,
                io_in_4_bits_uop_debug_tsrc,
  input  [39:0] io_in_4_bits_addr,
  input         io_in_4_bits_is_hella,
  input  [7:0]  io_in_4_bits_way_en,
  input  [4:0]  io_in_4_bits_sdq_id,
  input         io_in_5_valid,
  input  [6:0]  io_in_5_bits_uop_uopc,
  input  [31:0] io_in_5_bits_uop_inst,
                io_in_5_bits_uop_debug_inst,
  input         io_in_5_bits_uop_is_rvc,
  input  [39:0] io_in_5_bits_uop_debug_pc,
  input  [2:0]  io_in_5_bits_uop_iq_type,
  input  [9:0]  io_in_5_bits_uop_fu_code,
  input  [3:0]  io_in_5_bits_uop_ctrl_br_type,
  input  [1:0]  io_in_5_bits_uop_ctrl_op1_sel,
  input  [2:0]  io_in_5_bits_uop_ctrl_op2_sel,
                io_in_5_bits_uop_ctrl_imm_sel,
  input  [3:0]  io_in_5_bits_uop_ctrl_op_fcn,
  input         io_in_5_bits_uop_ctrl_fcn_dw,
  input  [2:0]  io_in_5_bits_uop_ctrl_csr_cmd,
  input         io_in_5_bits_uop_ctrl_is_load,
                io_in_5_bits_uop_ctrl_is_sta,
                io_in_5_bits_uop_ctrl_is_std,
  input  [1:0]  io_in_5_bits_uop_iw_state,
  input         io_in_5_bits_uop_iw_p1_poisoned,
                io_in_5_bits_uop_iw_p2_poisoned,
                io_in_5_bits_uop_is_br,
                io_in_5_bits_uop_is_jalr,
                io_in_5_bits_uop_is_jal,
                io_in_5_bits_uop_is_sfb,
  input  [19:0] io_in_5_bits_uop_br_mask,
  input  [4:0]  io_in_5_bits_uop_br_tag,
  input  [5:0]  io_in_5_bits_uop_ftq_idx,
  input         io_in_5_bits_uop_edge_inst,
  input  [5:0]  io_in_5_bits_uop_pc_lob,
  input         io_in_5_bits_uop_taken,
  input  [19:0] io_in_5_bits_uop_imm_packed,
  input  [11:0] io_in_5_bits_uop_csr_addr,
  input  [6:0]  io_in_5_bits_uop_rob_idx,
  input  [4:0]  io_in_5_bits_uop_ldq_idx,
                io_in_5_bits_uop_stq_idx,
  input  [1:0]  io_in_5_bits_uop_rxq_idx,
  input  [6:0]  io_in_5_bits_uop_pdst,
                io_in_5_bits_uop_prs1,
                io_in_5_bits_uop_prs2,
                io_in_5_bits_uop_prs3,
  input  [5:0]  io_in_5_bits_uop_ppred,
  input         io_in_5_bits_uop_prs1_busy,
                io_in_5_bits_uop_prs2_busy,
                io_in_5_bits_uop_prs3_busy,
                io_in_5_bits_uop_ppred_busy,
  input  [6:0]  io_in_5_bits_uop_stale_pdst,
  input         io_in_5_bits_uop_exception,
  input  [63:0] io_in_5_bits_uop_exc_cause,
  input         io_in_5_bits_uop_bypassable,
  input  [4:0]  io_in_5_bits_uop_mem_cmd,
  input  [1:0]  io_in_5_bits_uop_mem_size,
  input         io_in_5_bits_uop_mem_signed,
                io_in_5_bits_uop_is_fence,
                io_in_5_bits_uop_is_fencei,
                io_in_5_bits_uop_is_amo,
                io_in_5_bits_uop_uses_ldq,
                io_in_5_bits_uop_uses_stq,
                io_in_5_bits_uop_is_sys_pc2epc,
                io_in_5_bits_uop_is_unique,
                io_in_5_bits_uop_flush_on_commit,
                io_in_5_bits_uop_ldst_is_rs1,
  input  [5:0]  io_in_5_bits_uop_ldst,
                io_in_5_bits_uop_lrs1,
                io_in_5_bits_uop_lrs2,
                io_in_5_bits_uop_lrs3,
  input         io_in_5_bits_uop_ldst_val,
  input  [1:0]  io_in_5_bits_uop_dst_rtype,
                io_in_5_bits_uop_lrs1_rtype,
                io_in_5_bits_uop_lrs2_rtype,
  input         io_in_5_bits_uop_frs3_en,
                io_in_5_bits_uop_fp_val,
                io_in_5_bits_uop_fp_single,
                io_in_5_bits_uop_xcpt_pf_if,
                io_in_5_bits_uop_xcpt_ae_if,
                io_in_5_bits_uop_xcpt_ma_if,
                io_in_5_bits_uop_bp_debug_if,
                io_in_5_bits_uop_bp_xcpt_if,
  input  [1:0]  io_in_5_bits_uop_debug_fsrc,
                io_in_5_bits_uop_debug_tsrc,
  input  [39:0] io_in_5_bits_addr,
  input         io_in_5_bits_is_hella,
  input  [7:0]  io_in_5_bits_way_en,
  input  [4:0]  io_in_5_bits_sdq_id,
  input         io_in_6_valid,
  input  [6:0]  io_in_6_bits_uop_uopc,
  input  [31:0] io_in_6_bits_uop_inst,
                io_in_6_bits_uop_debug_inst,
  input         io_in_6_bits_uop_is_rvc,
  input  [39:0] io_in_6_bits_uop_debug_pc,
  input  [2:0]  io_in_6_bits_uop_iq_type,
  input  [9:0]  io_in_6_bits_uop_fu_code,
  input  [3:0]  io_in_6_bits_uop_ctrl_br_type,
  input  [1:0]  io_in_6_bits_uop_ctrl_op1_sel,
  input  [2:0]  io_in_6_bits_uop_ctrl_op2_sel,
                io_in_6_bits_uop_ctrl_imm_sel,
  input  [3:0]  io_in_6_bits_uop_ctrl_op_fcn,
  input         io_in_6_bits_uop_ctrl_fcn_dw,
  input  [2:0]  io_in_6_bits_uop_ctrl_csr_cmd,
  input         io_in_6_bits_uop_ctrl_is_load,
                io_in_6_bits_uop_ctrl_is_sta,
                io_in_6_bits_uop_ctrl_is_std,
  input  [1:0]  io_in_6_bits_uop_iw_state,
  input         io_in_6_bits_uop_iw_p1_poisoned,
                io_in_6_bits_uop_iw_p2_poisoned,
                io_in_6_bits_uop_is_br,
                io_in_6_bits_uop_is_jalr,
                io_in_6_bits_uop_is_jal,
                io_in_6_bits_uop_is_sfb,
  input  [19:0] io_in_6_bits_uop_br_mask,
  input  [4:0]  io_in_6_bits_uop_br_tag,
  input  [5:0]  io_in_6_bits_uop_ftq_idx,
  input         io_in_6_bits_uop_edge_inst,
  input  [5:0]  io_in_6_bits_uop_pc_lob,
  input         io_in_6_bits_uop_taken,
  input  [19:0] io_in_6_bits_uop_imm_packed,
  input  [11:0] io_in_6_bits_uop_csr_addr,
  input  [6:0]  io_in_6_bits_uop_rob_idx,
  input  [4:0]  io_in_6_bits_uop_ldq_idx,
                io_in_6_bits_uop_stq_idx,
  input  [1:0]  io_in_6_bits_uop_rxq_idx,
  input  [6:0]  io_in_6_bits_uop_pdst,
                io_in_6_bits_uop_prs1,
                io_in_6_bits_uop_prs2,
                io_in_6_bits_uop_prs3,
  input  [5:0]  io_in_6_bits_uop_ppred,
  input         io_in_6_bits_uop_prs1_busy,
                io_in_6_bits_uop_prs2_busy,
                io_in_6_bits_uop_prs3_busy,
                io_in_6_bits_uop_ppred_busy,
  input  [6:0]  io_in_6_bits_uop_stale_pdst,
  input         io_in_6_bits_uop_exception,
  input  [63:0] io_in_6_bits_uop_exc_cause,
  input         io_in_6_bits_uop_bypassable,
  input  [4:0]  io_in_6_bits_uop_mem_cmd,
  input  [1:0]  io_in_6_bits_uop_mem_size,
  input         io_in_6_bits_uop_mem_signed,
                io_in_6_bits_uop_is_fence,
                io_in_6_bits_uop_is_fencei,
                io_in_6_bits_uop_is_amo,
                io_in_6_bits_uop_uses_ldq,
                io_in_6_bits_uop_uses_stq,
                io_in_6_bits_uop_is_sys_pc2epc,
                io_in_6_bits_uop_is_unique,
                io_in_6_bits_uop_flush_on_commit,
                io_in_6_bits_uop_ldst_is_rs1,
  input  [5:0]  io_in_6_bits_uop_ldst,
                io_in_6_bits_uop_lrs1,
                io_in_6_bits_uop_lrs2,
                io_in_6_bits_uop_lrs3,
  input         io_in_6_bits_uop_ldst_val,
  input  [1:0]  io_in_6_bits_uop_dst_rtype,
                io_in_6_bits_uop_lrs1_rtype,
                io_in_6_bits_uop_lrs2_rtype,
  input         io_in_6_bits_uop_frs3_en,
                io_in_6_bits_uop_fp_val,
                io_in_6_bits_uop_fp_single,
                io_in_6_bits_uop_xcpt_pf_if,
                io_in_6_bits_uop_xcpt_ae_if,
                io_in_6_bits_uop_xcpt_ma_if,
                io_in_6_bits_uop_bp_debug_if,
                io_in_6_bits_uop_bp_xcpt_if,
  input  [1:0]  io_in_6_bits_uop_debug_fsrc,
                io_in_6_bits_uop_debug_tsrc,
  input  [39:0] io_in_6_bits_addr,
  input         io_in_6_bits_is_hella,
  input  [7:0]  io_in_6_bits_way_en,
  input  [4:0]  io_in_6_bits_sdq_id,
  input         io_in_7_valid,
  input  [6:0]  io_in_7_bits_uop_uopc,
  input  [31:0] io_in_7_bits_uop_inst,
                io_in_7_bits_uop_debug_inst,
  input         io_in_7_bits_uop_is_rvc,
  input  [39:0] io_in_7_bits_uop_debug_pc,
  input  [2:0]  io_in_7_bits_uop_iq_type,
  input  [9:0]  io_in_7_bits_uop_fu_code,
  input  [3:0]  io_in_7_bits_uop_ctrl_br_type,
  input  [1:0]  io_in_7_bits_uop_ctrl_op1_sel,
  input  [2:0]  io_in_7_bits_uop_ctrl_op2_sel,
                io_in_7_bits_uop_ctrl_imm_sel,
  input  [3:0]  io_in_7_bits_uop_ctrl_op_fcn,
  input         io_in_7_bits_uop_ctrl_fcn_dw,
  input  [2:0]  io_in_7_bits_uop_ctrl_csr_cmd,
  input         io_in_7_bits_uop_ctrl_is_load,
                io_in_7_bits_uop_ctrl_is_sta,
                io_in_7_bits_uop_ctrl_is_std,
  input  [1:0]  io_in_7_bits_uop_iw_state,
  input         io_in_7_bits_uop_iw_p1_poisoned,
                io_in_7_bits_uop_iw_p2_poisoned,
                io_in_7_bits_uop_is_br,
                io_in_7_bits_uop_is_jalr,
                io_in_7_bits_uop_is_jal,
                io_in_7_bits_uop_is_sfb,
  input  [19:0] io_in_7_bits_uop_br_mask,
  input  [4:0]  io_in_7_bits_uop_br_tag,
  input  [5:0]  io_in_7_bits_uop_ftq_idx,
  input         io_in_7_bits_uop_edge_inst,
  input  [5:0]  io_in_7_bits_uop_pc_lob,
  input         io_in_7_bits_uop_taken,
  input  [19:0] io_in_7_bits_uop_imm_packed,
  input  [11:0] io_in_7_bits_uop_csr_addr,
  input  [6:0]  io_in_7_bits_uop_rob_idx,
  input  [4:0]  io_in_7_bits_uop_ldq_idx,
                io_in_7_bits_uop_stq_idx,
  input  [1:0]  io_in_7_bits_uop_rxq_idx,
  input  [6:0]  io_in_7_bits_uop_pdst,
                io_in_7_bits_uop_prs1,
                io_in_7_bits_uop_prs2,
                io_in_7_bits_uop_prs3,
  input  [5:0]  io_in_7_bits_uop_ppred,
  input         io_in_7_bits_uop_prs1_busy,
                io_in_7_bits_uop_prs2_busy,
                io_in_7_bits_uop_prs3_busy,
                io_in_7_bits_uop_ppred_busy,
  input  [6:0]  io_in_7_bits_uop_stale_pdst,
  input         io_in_7_bits_uop_exception,
  input  [63:0] io_in_7_bits_uop_exc_cause,
  input         io_in_7_bits_uop_bypassable,
  input  [4:0]  io_in_7_bits_uop_mem_cmd,
  input  [1:0]  io_in_7_bits_uop_mem_size,
  input         io_in_7_bits_uop_mem_signed,
                io_in_7_bits_uop_is_fence,
                io_in_7_bits_uop_is_fencei,
                io_in_7_bits_uop_is_amo,
                io_in_7_bits_uop_uses_ldq,
                io_in_7_bits_uop_uses_stq,
                io_in_7_bits_uop_is_sys_pc2epc,
                io_in_7_bits_uop_is_unique,
                io_in_7_bits_uop_flush_on_commit,
                io_in_7_bits_uop_ldst_is_rs1,
  input  [5:0]  io_in_7_bits_uop_ldst,
                io_in_7_bits_uop_lrs1,
                io_in_7_bits_uop_lrs2,
                io_in_7_bits_uop_lrs3,
  input         io_in_7_bits_uop_ldst_val,
  input  [1:0]  io_in_7_bits_uop_dst_rtype,
                io_in_7_bits_uop_lrs1_rtype,
                io_in_7_bits_uop_lrs2_rtype,
  input         io_in_7_bits_uop_frs3_en,
                io_in_7_bits_uop_fp_val,
                io_in_7_bits_uop_fp_single,
                io_in_7_bits_uop_xcpt_pf_if,
                io_in_7_bits_uop_xcpt_ae_if,
                io_in_7_bits_uop_xcpt_ma_if,
                io_in_7_bits_uop_bp_debug_if,
                io_in_7_bits_uop_bp_xcpt_if,
  input  [1:0]  io_in_7_bits_uop_debug_fsrc,
                io_in_7_bits_uop_debug_tsrc,
  input  [39:0] io_in_7_bits_addr,
  input         io_in_7_bits_is_hella,
  input  [7:0]  io_in_7_bits_way_en,
  input  [4:0]  io_in_7_bits_sdq_id,
  input         io_out_ready,
  output        io_in_1_ready,
                io_in_2_ready,
                io_in_3_ready,
                io_in_4_ready,
                io_in_5_ready,
                io_in_6_ready,
                io_in_7_ready,
                io_out_valid,
  output [6:0]  io_out_bits_uop_uopc,
  output [31:0] io_out_bits_uop_inst,
                io_out_bits_uop_debug_inst,
  output        io_out_bits_uop_is_rvc,
  output [39:0] io_out_bits_uop_debug_pc,
  output [2:0]  io_out_bits_uop_iq_type,
  output [9:0]  io_out_bits_uop_fu_code,
  output [3:0]  io_out_bits_uop_ctrl_br_type,
  output [1:0]  io_out_bits_uop_ctrl_op1_sel,
  output [2:0]  io_out_bits_uop_ctrl_op2_sel,
                io_out_bits_uop_ctrl_imm_sel,
  output [3:0]  io_out_bits_uop_ctrl_op_fcn,
  output        io_out_bits_uop_ctrl_fcn_dw,
  output [2:0]  io_out_bits_uop_ctrl_csr_cmd,
  output        io_out_bits_uop_ctrl_is_load,
                io_out_bits_uop_ctrl_is_sta,
                io_out_bits_uop_ctrl_is_std,
  output [1:0]  io_out_bits_uop_iw_state,
  output        io_out_bits_uop_iw_p1_poisoned,
                io_out_bits_uop_iw_p2_poisoned,
                io_out_bits_uop_is_br,
                io_out_bits_uop_is_jalr,
                io_out_bits_uop_is_jal,
                io_out_bits_uop_is_sfb,
  output [19:0] io_out_bits_uop_br_mask,
  output [4:0]  io_out_bits_uop_br_tag,
  output [5:0]  io_out_bits_uop_ftq_idx,
  output        io_out_bits_uop_edge_inst,
  output [5:0]  io_out_bits_uop_pc_lob,
  output        io_out_bits_uop_taken,
  output [19:0] io_out_bits_uop_imm_packed,
  output [11:0] io_out_bits_uop_csr_addr,
  output [6:0]  io_out_bits_uop_rob_idx,
  output [4:0]  io_out_bits_uop_ldq_idx,
                io_out_bits_uop_stq_idx,
  output [1:0]  io_out_bits_uop_rxq_idx,
  output [6:0]  io_out_bits_uop_pdst,
                io_out_bits_uop_prs1,
                io_out_bits_uop_prs2,
                io_out_bits_uop_prs3,
  output [5:0]  io_out_bits_uop_ppred,
  output        io_out_bits_uop_prs1_busy,
                io_out_bits_uop_prs2_busy,
                io_out_bits_uop_prs3_busy,
                io_out_bits_uop_ppred_busy,
  output [6:0]  io_out_bits_uop_stale_pdst,
  output        io_out_bits_uop_exception,
  output [63:0] io_out_bits_uop_exc_cause,
  output        io_out_bits_uop_bypassable,
  output [4:0]  io_out_bits_uop_mem_cmd,
  output [1:0]  io_out_bits_uop_mem_size,
  output        io_out_bits_uop_mem_signed,
                io_out_bits_uop_is_fence,
                io_out_bits_uop_is_fencei,
                io_out_bits_uop_is_amo,
                io_out_bits_uop_uses_ldq,
                io_out_bits_uop_uses_stq,
                io_out_bits_uop_is_sys_pc2epc,
                io_out_bits_uop_is_unique,
                io_out_bits_uop_flush_on_commit,
                io_out_bits_uop_ldst_is_rs1,
  output [5:0]  io_out_bits_uop_ldst,
                io_out_bits_uop_lrs1,
                io_out_bits_uop_lrs2,
                io_out_bits_uop_lrs3,
  output        io_out_bits_uop_ldst_val,
  output [1:0]  io_out_bits_uop_dst_rtype,
                io_out_bits_uop_lrs1_rtype,
                io_out_bits_uop_lrs2_rtype,
  output        io_out_bits_uop_frs3_en,
                io_out_bits_uop_fp_val,
                io_out_bits_uop_fp_single,
                io_out_bits_uop_xcpt_pf_if,
                io_out_bits_uop_xcpt_ae_if,
                io_out_bits_uop_xcpt_ma_if,
                io_out_bits_uop_bp_debug_if,
                io_out_bits_uop_bp_xcpt_if,
  output [1:0]  io_out_bits_uop_debug_fsrc,
                io_out_bits_uop_debug_tsrc,
  output [39:0] io_out_bits_addr,
  output        io_out_bits_is_hella,
  output [7:0]  io_out_bits_way_en,
  output [4:0]  io_out_bits_sdq_id
);

  wire _grant_T = io_in_0_valid | io_in_1_valid;	// Arbiter.scala:31:68
  wire _grant_T_1 = _grant_T | io_in_2_valid;	// Arbiter.scala:31:68
  wire _grant_T_2 = _grant_T_1 | io_in_3_valid;	// Arbiter.scala:31:68
  wire _grant_T_3 = _grant_T_2 | io_in_4_valid;	// Arbiter.scala:31:68
  wire _grant_T_4 = _grant_T_3 | io_in_5_valid;	// Arbiter.scala:31:68
  wire _io_out_valid_T = _grant_T_4 | io_in_6_valid;	// Arbiter.scala:31:68
  assign io_in_1_ready = ~io_in_0_valid & io_out_ready;	// Arbiter.scala:31:78, :134:19
  assign io_in_2_ready = ~_grant_T & io_out_ready;	// Arbiter.scala:31:{68,78}, :134:19
  assign io_in_3_ready = ~_grant_T_1 & io_out_ready;	// Arbiter.scala:31:{68,78}, :134:19
  assign io_in_4_ready = ~_grant_T_2 & io_out_ready;	// Arbiter.scala:31:{68,78}, :134:19
  assign io_in_5_ready = ~_grant_T_3 & io_out_ready;	// Arbiter.scala:31:{68,78}, :134:19
  assign io_in_6_ready = ~_grant_T_4 & io_out_ready;	// Arbiter.scala:31:{68,78}, :134:19
  assign io_in_7_ready = ~_io_out_valid_T & io_out_ready;	// Arbiter.scala:31:{68,78}, :134:19
  assign io_out_valid = _io_out_valid_T | io_in_7_valid;	// Arbiter.scala:31:68, :135:31
  assign io_out_bits_uop_uopc =
    io_in_0_valid
      ? io_in_0_bits_uop_uopc
      : io_in_1_valid
          ? io_in_1_bits_uop_uopc
          : io_in_2_valid
              ? io_in_2_bits_uop_uopc
              : io_in_3_valid
                  ? io_in_3_bits_uop_uopc
                  : io_in_4_valid
                      ? io_in_4_bits_uop_uopc
                      : io_in_5_valid
                          ? io_in_5_bits_uop_uopc
                          : io_in_6_valid ? io_in_6_bits_uop_uopc : io_in_7_bits_uop_uopc;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_inst =
    io_in_0_valid
      ? io_in_0_bits_uop_inst
      : io_in_1_valid
          ? io_in_1_bits_uop_inst
          : io_in_2_valid
              ? io_in_2_bits_uop_inst
              : io_in_3_valid
                  ? io_in_3_bits_uop_inst
                  : io_in_4_valid
                      ? io_in_4_bits_uop_inst
                      : io_in_5_valid
                          ? io_in_5_bits_uop_inst
                          : io_in_6_valid ? io_in_6_bits_uop_inst : io_in_7_bits_uop_inst;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_debug_inst =
    io_in_0_valid
      ? io_in_0_bits_uop_debug_inst
      : io_in_1_valid
          ? io_in_1_bits_uop_debug_inst
          : io_in_2_valid
              ? io_in_2_bits_uop_debug_inst
              : io_in_3_valid
                  ? io_in_3_bits_uop_debug_inst
                  : io_in_4_valid
                      ? io_in_4_bits_uop_debug_inst
                      : io_in_5_valid
                          ? io_in_5_bits_uop_debug_inst
                          : io_in_6_valid
                              ? io_in_6_bits_uop_debug_inst
                              : io_in_7_bits_uop_debug_inst;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_is_rvc =
    io_in_0_valid
      ? io_in_0_bits_uop_is_rvc
      : io_in_1_valid
          ? io_in_1_bits_uop_is_rvc
          : io_in_2_valid
              ? io_in_2_bits_uop_is_rvc
              : io_in_3_valid
                  ? io_in_3_bits_uop_is_rvc
                  : io_in_4_valid
                      ? io_in_4_bits_uop_is_rvc
                      : io_in_5_valid
                          ? io_in_5_bits_uop_is_rvc
                          : io_in_6_valid
                              ? io_in_6_bits_uop_is_rvc
                              : io_in_7_bits_uop_is_rvc;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_debug_pc =
    io_in_0_valid
      ? io_in_0_bits_uop_debug_pc
      : io_in_1_valid
          ? io_in_1_bits_uop_debug_pc
          : io_in_2_valid
              ? io_in_2_bits_uop_debug_pc
              : io_in_3_valid
                  ? io_in_3_bits_uop_debug_pc
                  : io_in_4_valid
                      ? io_in_4_bits_uop_debug_pc
                      : io_in_5_valid
                          ? io_in_5_bits_uop_debug_pc
                          : io_in_6_valid
                              ? io_in_6_bits_uop_debug_pc
                              : io_in_7_bits_uop_debug_pc;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_iq_type =
    io_in_0_valid
      ? io_in_0_bits_uop_iq_type
      : io_in_1_valid
          ? io_in_1_bits_uop_iq_type
          : io_in_2_valid
              ? io_in_2_bits_uop_iq_type
              : io_in_3_valid
                  ? io_in_3_bits_uop_iq_type
                  : io_in_4_valid
                      ? io_in_4_bits_uop_iq_type
                      : io_in_5_valid
                          ? io_in_5_bits_uop_iq_type
                          : io_in_6_valid
                              ? io_in_6_bits_uop_iq_type
                              : io_in_7_bits_uop_iq_type;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_fu_code =
    io_in_0_valid
      ? io_in_0_bits_uop_fu_code
      : io_in_1_valid
          ? io_in_1_bits_uop_fu_code
          : io_in_2_valid
              ? io_in_2_bits_uop_fu_code
              : io_in_3_valid
                  ? io_in_3_bits_uop_fu_code
                  : io_in_4_valid
                      ? io_in_4_bits_uop_fu_code
                      : io_in_5_valid
                          ? io_in_5_bits_uop_fu_code
                          : io_in_6_valid
                              ? io_in_6_bits_uop_fu_code
                              : io_in_7_bits_uop_fu_code;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_ctrl_br_type =
    io_in_0_valid
      ? io_in_0_bits_uop_ctrl_br_type
      : io_in_1_valid
          ? io_in_1_bits_uop_ctrl_br_type
          : io_in_2_valid
              ? io_in_2_bits_uop_ctrl_br_type
              : io_in_3_valid
                  ? io_in_3_bits_uop_ctrl_br_type
                  : io_in_4_valid
                      ? io_in_4_bits_uop_ctrl_br_type
                      : io_in_5_valid
                          ? io_in_5_bits_uop_ctrl_br_type
                          : io_in_6_valid
                              ? io_in_6_bits_uop_ctrl_br_type
                              : io_in_7_bits_uop_ctrl_br_type;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_ctrl_op1_sel =
    io_in_0_valid
      ? io_in_0_bits_uop_ctrl_op1_sel
      : io_in_1_valid
          ? io_in_1_bits_uop_ctrl_op1_sel
          : io_in_2_valid
              ? io_in_2_bits_uop_ctrl_op1_sel
              : io_in_3_valid
                  ? io_in_3_bits_uop_ctrl_op1_sel
                  : io_in_4_valid
                      ? io_in_4_bits_uop_ctrl_op1_sel
                      : io_in_5_valid
                          ? io_in_5_bits_uop_ctrl_op1_sel
                          : io_in_6_valid
                              ? io_in_6_bits_uop_ctrl_op1_sel
                              : io_in_7_bits_uop_ctrl_op1_sel;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_ctrl_op2_sel =
    io_in_0_valid
      ? io_in_0_bits_uop_ctrl_op2_sel
      : io_in_1_valid
          ? io_in_1_bits_uop_ctrl_op2_sel
          : io_in_2_valid
              ? io_in_2_bits_uop_ctrl_op2_sel
              : io_in_3_valid
                  ? io_in_3_bits_uop_ctrl_op2_sel
                  : io_in_4_valid
                      ? io_in_4_bits_uop_ctrl_op2_sel
                      : io_in_5_valid
                          ? io_in_5_bits_uop_ctrl_op2_sel
                          : io_in_6_valid
                              ? io_in_6_bits_uop_ctrl_op2_sel
                              : io_in_7_bits_uop_ctrl_op2_sel;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_ctrl_imm_sel =
    io_in_0_valid
      ? io_in_0_bits_uop_ctrl_imm_sel
      : io_in_1_valid
          ? io_in_1_bits_uop_ctrl_imm_sel
          : io_in_2_valid
              ? io_in_2_bits_uop_ctrl_imm_sel
              : io_in_3_valid
                  ? io_in_3_bits_uop_ctrl_imm_sel
                  : io_in_4_valid
                      ? io_in_4_bits_uop_ctrl_imm_sel
                      : io_in_5_valid
                          ? io_in_5_bits_uop_ctrl_imm_sel
                          : io_in_6_valid
                              ? io_in_6_bits_uop_ctrl_imm_sel
                              : io_in_7_bits_uop_ctrl_imm_sel;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_ctrl_op_fcn =
    io_in_0_valid
      ? io_in_0_bits_uop_ctrl_op_fcn
      : io_in_1_valid
          ? io_in_1_bits_uop_ctrl_op_fcn
          : io_in_2_valid
              ? io_in_2_bits_uop_ctrl_op_fcn
              : io_in_3_valid
                  ? io_in_3_bits_uop_ctrl_op_fcn
                  : io_in_4_valid
                      ? io_in_4_bits_uop_ctrl_op_fcn
                      : io_in_5_valid
                          ? io_in_5_bits_uop_ctrl_op_fcn
                          : io_in_6_valid
                              ? io_in_6_bits_uop_ctrl_op_fcn
                              : io_in_7_bits_uop_ctrl_op_fcn;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_ctrl_fcn_dw =
    io_in_0_valid
      ? io_in_0_bits_uop_ctrl_fcn_dw
      : io_in_1_valid
          ? io_in_1_bits_uop_ctrl_fcn_dw
          : io_in_2_valid
              ? io_in_2_bits_uop_ctrl_fcn_dw
              : io_in_3_valid
                  ? io_in_3_bits_uop_ctrl_fcn_dw
                  : io_in_4_valid
                      ? io_in_4_bits_uop_ctrl_fcn_dw
                      : io_in_5_valid
                          ? io_in_5_bits_uop_ctrl_fcn_dw
                          : io_in_6_valid
                              ? io_in_6_bits_uop_ctrl_fcn_dw
                              : io_in_7_bits_uop_ctrl_fcn_dw;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_ctrl_csr_cmd =
    io_in_0_valid
      ? io_in_0_bits_uop_ctrl_csr_cmd
      : io_in_1_valid
          ? io_in_1_bits_uop_ctrl_csr_cmd
          : io_in_2_valid
              ? io_in_2_bits_uop_ctrl_csr_cmd
              : io_in_3_valid
                  ? io_in_3_bits_uop_ctrl_csr_cmd
                  : io_in_4_valid
                      ? io_in_4_bits_uop_ctrl_csr_cmd
                      : io_in_5_valid
                          ? io_in_5_bits_uop_ctrl_csr_cmd
                          : io_in_6_valid
                              ? io_in_6_bits_uop_ctrl_csr_cmd
                              : io_in_7_bits_uop_ctrl_csr_cmd;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_ctrl_is_load =
    io_in_0_valid
      ? io_in_0_bits_uop_ctrl_is_load
      : io_in_1_valid
          ? io_in_1_bits_uop_ctrl_is_load
          : io_in_2_valid
              ? io_in_2_bits_uop_ctrl_is_load
              : io_in_3_valid
                  ? io_in_3_bits_uop_ctrl_is_load
                  : io_in_4_valid
                      ? io_in_4_bits_uop_ctrl_is_load
                      : io_in_5_valid
                          ? io_in_5_bits_uop_ctrl_is_load
                          : io_in_6_valid
                              ? io_in_6_bits_uop_ctrl_is_load
                              : io_in_7_bits_uop_ctrl_is_load;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_ctrl_is_sta =
    io_in_0_valid
      ? io_in_0_bits_uop_ctrl_is_sta
      : io_in_1_valid
          ? io_in_1_bits_uop_ctrl_is_sta
          : io_in_2_valid
              ? io_in_2_bits_uop_ctrl_is_sta
              : io_in_3_valid
                  ? io_in_3_bits_uop_ctrl_is_sta
                  : io_in_4_valid
                      ? io_in_4_bits_uop_ctrl_is_sta
                      : io_in_5_valid
                          ? io_in_5_bits_uop_ctrl_is_sta
                          : io_in_6_valid
                              ? io_in_6_bits_uop_ctrl_is_sta
                              : io_in_7_bits_uop_ctrl_is_sta;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_ctrl_is_std =
    io_in_0_valid
      ? io_in_0_bits_uop_ctrl_is_std
      : io_in_1_valid
          ? io_in_1_bits_uop_ctrl_is_std
          : io_in_2_valid
              ? io_in_2_bits_uop_ctrl_is_std
              : io_in_3_valid
                  ? io_in_3_bits_uop_ctrl_is_std
                  : io_in_4_valid
                      ? io_in_4_bits_uop_ctrl_is_std
                      : io_in_5_valid
                          ? io_in_5_bits_uop_ctrl_is_std
                          : io_in_6_valid
                              ? io_in_6_bits_uop_ctrl_is_std
                              : io_in_7_bits_uop_ctrl_is_std;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_iw_state =
    io_in_0_valid
      ? io_in_0_bits_uop_iw_state
      : io_in_1_valid
          ? io_in_1_bits_uop_iw_state
          : io_in_2_valid
              ? io_in_2_bits_uop_iw_state
              : io_in_3_valid
                  ? io_in_3_bits_uop_iw_state
                  : io_in_4_valid
                      ? io_in_4_bits_uop_iw_state
                      : io_in_5_valid
                          ? io_in_5_bits_uop_iw_state
                          : io_in_6_valid
                              ? io_in_6_bits_uop_iw_state
                              : io_in_7_bits_uop_iw_state;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_iw_p1_poisoned =
    io_in_0_valid
      ? io_in_0_bits_uop_iw_p1_poisoned
      : io_in_1_valid
          ? io_in_1_bits_uop_iw_p1_poisoned
          : io_in_2_valid
              ? io_in_2_bits_uop_iw_p1_poisoned
              : io_in_3_valid
                  ? io_in_3_bits_uop_iw_p1_poisoned
                  : io_in_4_valid
                      ? io_in_4_bits_uop_iw_p1_poisoned
                      : io_in_5_valid
                          ? io_in_5_bits_uop_iw_p1_poisoned
                          : io_in_6_valid
                              ? io_in_6_bits_uop_iw_p1_poisoned
                              : io_in_7_bits_uop_iw_p1_poisoned;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_iw_p2_poisoned =
    io_in_0_valid
      ? io_in_0_bits_uop_iw_p2_poisoned
      : io_in_1_valid
          ? io_in_1_bits_uop_iw_p2_poisoned
          : io_in_2_valid
              ? io_in_2_bits_uop_iw_p2_poisoned
              : io_in_3_valid
                  ? io_in_3_bits_uop_iw_p2_poisoned
                  : io_in_4_valid
                      ? io_in_4_bits_uop_iw_p2_poisoned
                      : io_in_5_valid
                          ? io_in_5_bits_uop_iw_p2_poisoned
                          : io_in_6_valid
                              ? io_in_6_bits_uop_iw_p2_poisoned
                              : io_in_7_bits_uop_iw_p2_poisoned;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_is_br =
    io_in_0_valid
      ? io_in_0_bits_uop_is_br
      : io_in_1_valid
          ? io_in_1_bits_uop_is_br
          : io_in_2_valid
              ? io_in_2_bits_uop_is_br
              : io_in_3_valid
                  ? io_in_3_bits_uop_is_br
                  : io_in_4_valid
                      ? io_in_4_bits_uop_is_br
                      : io_in_5_valid
                          ? io_in_5_bits_uop_is_br
                          : io_in_6_valid
                              ? io_in_6_bits_uop_is_br
                              : io_in_7_bits_uop_is_br;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_is_jalr =
    io_in_0_valid
      ? io_in_0_bits_uop_is_jalr
      : io_in_1_valid
          ? io_in_1_bits_uop_is_jalr
          : io_in_2_valid
              ? io_in_2_bits_uop_is_jalr
              : io_in_3_valid
                  ? io_in_3_bits_uop_is_jalr
                  : io_in_4_valid
                      ? io_in_4_bits_uop_is_jalr
                      : io_in_5_valid
                          ? io_in_5_bits_uop_is_jalr
                          : io_in_6_valid
                              ? io_in_6_bits_uop_is_jalr
                              : io_in_7_bits_uop_is_jalr;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_is_jal =
    io_in_0_valid
      ? io_in_0_bits_uop_is_jal
      : io_in_1_valid
          ? io_in_1_bits_uop_is_jal
          : io_in_2_valid
              ? io_in_2_bits_uop_is_jal
              : io_in_3_valid
                  ? io_in_3_bits_uop_is_jal
                  : io_in_4_valid
                      ? io_in_4_bits_uop_is_jal
                      : io_in_5_valid
                          ? io_in_5_bits_uop_is_jal
                          : io_in_6_valid
                              ? io_in_6_bits_uop_is_jal
                              : io_in_7_bits_uop_is_jal;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_is_sfb =
    io_in_0_valid
      ? io_in_0_bits_uop_is_sfb
      : io_in_1_valid
          ? io_in_1_bits_uop_is_sfb
          : io_in_2_valid
              ? io_in_2_bits_uop_is_sfb
              : io_in_3_valid
                  ? io_in_3_bits_uop_is_sfb
                  : io_in_4_valid
                      ? io_in_4_bits_uop_is_sfb
                      : io_in_5_valid
                          ? io_in_5_bits_uop_is_sfb
                          : io_in_6_valid
                              ? io_in_6_bits_uop_is_sfb
                              : io_in_7_bits_uop_is_sfb;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_br_mask =
    io_in_0_valid
      ? io_in_0_bits_uop_br_mask
      : io_in_1_valid
          ? io_in_1_bits_uop_br_mask
          : io_in_2_valid
              ? io_in_2_bits_uop_br_mask
              : io_in_3_valid
                  ? io_in_3_bits_uop_br_mask
                  : io_in_4_valid
                      ? io_in_4_bits_uop_br_mask
                      : io_in_5_valid
                          ? io_in_5_bits_uop_br_mask
                          : io_in_6_valid
                              ? io_in_6_bits_uop_br_mask
                              : io_in_7_bits_uop_br_mask;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_br_tag =
    io_in_0_valid
      ? io_in_0_bits_uop_br_tag
      : io_in_1_valid
          ? io_in_1_bits_uop_br_tag
          : io_in_2_valid
              ? io_in_2_bits_uop_br_tag
              : io_in_3_valid
                  ? io_in_3_bits_uop_br_tag
                  : io_in_4_valid
                      ? io_in_4_bits_uop_br_tag
                      : io_in_5_valid
                          ? io_in_5_bits_uop_br_tag
                          : io_in_6_valid
                              ? io_in_6_bits_uop_br_tag
                              : io_in_7_bits_uop_br_tag;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_ftq_idx =
    io_in_0_valid
      ? io_in_0_bits_uop_ftq_idx
      : io_in_1_valid
          ? io_in_1_bits_uop_ftq_idx
          : io_in_2_valid
              ? io_in_2_bits_uop_ftq_idx
              : io_in_3_valid
                  ? io_in_3_bits_uop_ftq_idx
                  : io_in_4_valid
                      ? io_in_4_bits_uop_ftq_idx
                      : io_in_5_valid
                          ? io_in_5_bits_uop_ftq_idx
                          : io_in_6_valid
                              ? io_in_6_bits_uop_ftq_idx
                              : io_in_7_bits_uop_ftq_idx;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_edge_inst =
    io_in_0_valid
      ? io_in_0_bits_uop_edge_inst
      : io_in_1_valid
          ? io_in_1_bits_uop_edge_inst
          : io_in_2_valid
              ? io_in_2_bits_uop_edge_inst
              : io_in_3_valid
                  ? io_in_3_bits_uop_edge_inst
                  : io_in_4_valid
                      ? io_in_4_bits_uop_edge_inst
                      : io_in_5_valid
                          ? io_in_5_bits_uop_edge_inst
                          : io_in_6_valid
                              ? io_in_6_bits_uop_edge_inst
                              : io_in_7_bits_uop_edge_inst;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_pc_lob =
    io_in_0_valid
      ? io_in_0_bits_uop_pc_lob
      : io_in_1_valid
          ? io_in_1_bits_uop_pc_lob
          : io_in_2_valid
              ? io_in_2_bits_uop_pc_lob
              : io_in_3_valid
                  ? io_in_3_bits_uop_pc_lob
                  : io_in_4_valid
                      ? io_in_4_bits_uop_pc_lob
                      : io_in_5_valid
                          ? io_in_5_bits_uop_pc_lob
                          : io_in_6_valid
                              ? io_in_6_bits_uop_pc_lob
                              : io_in_7_bits_uop_pc_lob;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_taken =
    io_in_0_valid
      ? io_in_0_bits_uop_taken
      : io_in_1_valid
          ? io_in_1_bits_uop_taken
          : io_in_2_valid
              ? io_in_2_bits_uop_taken
              : io_in_3_valid
                  ? io_in_3_bits_uop_taken
                  : io_in_4_valid
                      ? io_in_4_bits_uop_taken
                      : io_in_5_valid
                          ? io_in_5_bits_uop_taken
                          : io_in_6_valid
                              ? io_in_6_bits_uop_taken
                              : io_in_7_bits_uop_taken;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_imm_packed =
    io_in_0_valid
      ? io_in_0_bits_uop_imm_packed
      : io_in_1_valid
          ? io_in_1_bits_uop_imm_packed
          : io_in_2_valid
              ? io_in_2_bits_uop_imm_packed
              : io_in_3_valid
                  ? io_in_3_bits_uop_imm_packed
                  : io_in_4_valid
                      ? io_in_4_bits_uop_imm_packed
                      : io_in_5_valid
                          ? io_in_5_bits_uop_imm_packed
                          : io_in_6_valid
                              ? io_in_6_bits_uop_imm_packed
                              : io_in_7_bits_uop_imm_packed;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_csr_addr =
    io_in_0_valid
      ? io_in_0_bits_uop_csr_addr
      : io_in_1_valid
          ? io_in_1_bits_uop_csr_addr
          : io_in_2_valid
              ? io_in_2_bits_uop_csr_addr
              : io_in_3_valid
                  ? io_in_3_bits_uop_csr_addr
                  : io_in_4_valid
                      ? io_in_4_bits_uop_csr_addr
                      : io_in_5_valid
                          ? io_in_5_bits_uop_csr_addr
                          : io_in_6_valid
                              ? io_in_6_bits_uop_csr_addr
                              : io_in_7_bits_uop_csr_addr;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_rob_idx =
    io_in_0_valid
      ? io_in_0_bits_uop_rob_idx
      : io_in_1_valid
          ? io_in_1_bits_uop_rob_idx
          : io_in_2_valid
              ? io_in_2_bits_uop_rob_idx
              : io_in_3_valid
                  ? io_in_3_bits_uop_rob_idx
                  : io_in_4_valid
                      ? io_in_4_bits_uop_rob_idx
                      : io_in_5_valid
                          ? io_in_5_bits_uop_rob_idx
                          : io_in_6_valid
                              ? io_in_6_bits_uop_rob_idx
                              : io_in_7_bits_uop_rob_idx;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_ldq_idx =
    io_in_0_valid
      ? io_in_0_bits_uop_ldq_idx
      : io_in_1_valid
          ? io_in_1_bits_uop_ldq_idx
          : io_in_2_valid
              ? io_in_2_bits_uop_ldq_idx
              : io_in_3_valid
                  ? io_in_3_bits_uop_ldq_idx
                  : io_in_4_valid
                      ? io_in_4_bits_uop_ldq_idx
                      : io_in_5_valid
                          ? io_in_5_bits_uop_ldq_idx
                          : io_in_6_valid
                              ? io_in_6_bits_uop_ldq_idx
                              : io_in_7_bits_uop_ldq_idx;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_stq_idx =
    io_in_0_valid
      ? io_in_0_bits_uop_stq_idx
      : io_in_1_valid
          ? io_in_1_bits_uop_stq_idx
          : io_in_2_valid
              ? io_in_2_bits_uop_stq_idx
              : io_in_3_valid
                  ? io_in_3_bits_uop_stq_idx
                  : io_in_4_valid
                      ? io_in_4_bits_uop_stq_idx
                      : io_in_5_valid
                          ? io_in_5_bits_uop_stq_idx
                          : io_in_6_valid
                              ? io_in_6_bits_uop_stq_idx
                              : io_in_7_bits_uop_stq_idx;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_rxq_idx =
    io_in_0_valid
      ? io_in_0_bits_uop_rxq_idx
      : io_in_1_valid
          ? io_in_1_bits_uop_rxq_idx
          : io_in_2_valid
              ? io_in_2_bits_uop_rxq_idx
              : io_in_3_valid
                  ? io_in_3_bits_uop_rxq_idx
                  : io_in_4_valid
                      ? io_in_4_bits_uop_rxq_idx
                      : io_in_5_valid
                          ? io_in_5_bits_uop_rxq_idx
                          : io_in_6_valid
                              ? io_in_6_bits_uop_rxq_idx
                              : io_in_7_bits_uop_rxq_idx;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_pdst =
    io_in_0_valid
      ? io_in_0_bits_uop_pdst
      : io_in_1_valid
          ? io_in_1_bits_uop_pdst
          : io_in_2_valid
              ? io_in_2_bits_uop_pdst
              : io_in_3_valid
                  ? io_in_3_bits_uop_pdst
                  : io_in_4_valid
                      ? io_in_4_bits_uop_pdst
                      : io_in_5_valid
                          ? io_in_5_bits_uop_pdst
                          : io_in_6_valid ? io_in_6_bits_uop_pdst : io_in_7_bits_uop_pdst;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_prs1 =
    io_in_0_valid
      ? io_in_0_bits_uop_prs1
      : io_in_1_valid
          ? io_in_1_bits_uop_prs1
          : io_in_2_valid
              ? io_in_2_bits_uop_prs1
              : io_in_3_valid
                  ? io_in_3_bits_uop_prs1
                  : io_in_4_valid
                      ? io_in_4_bits_uop_prs1
                      : io_in_5_valid
                          ? io_in_5_bits_uop_prs1
                          : io_in_6_valid ? io_in_6_bits_uop_prs1 : io_in_7_bits_uop_prs1;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_prs2 =
    io_in_0_valid
      ? io_in_0_bits_uop_prs2
      : io_in_1_valid
          ? io_in_1_bits_uop_prs2
          : io_in_2_valid
              ? io_in_2_bits_uop_prs2
              : io_in_3_valid
                  ? io_in_3_bits_uop_prs2
                  : io_in_4_valid
                      ? io_in_4_bits_uop_prs2
                      : io_in_5_valid
                          ? io_in_5_bits_uop_prs2
                          : io_in_6_valid ? io_in_6_bits_uop_prs2 : io_in_7_bits_uop_prs2;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_prs3 =
    io_in_0_valid
      ? io_in_0_bits_uop_prs3
      : io_in_1_valid
          ? io_in_1_bits_uop_prs3
          : io_in_2_valid
              ? io_in_2_bits_uop_prs3
              : io_in_3_valid
                  ? io_in_3_bits_uop_prs3
                  : io_in_4_valid
                      ? io_in_4_bits_uop_prs3
                      : io_in_5_valid
                          ? io_in_5_bits_uop_prs3
                          : io_in_6_valid ? io_in_6_bits_uop_prs3 : io_in_7_bits_uop_prs3;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_ppred =
    io_in_0_valid
      ? io_in_0_bits_uop_ppred
      : io_in_1_valid
          ? io_in_1_bits_uop_ppred
          : io_in_2_valid
              ? io_in_2_bits_uop_ppred
              : io_in_3_valid
                  ? io_in_3_bits_uop_ppred
                  : io_in_4_valid
                      ? io_in_4_bits_uop_ppred
                      : io_in_5_valid
                          ? io_in_5_bits_uop_ppred
                          : io_in_6_valid
                              ? io_in_6_bits_uop_ppred
                              : io_in_7_bits_uop_ppred;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_prs1_busy =
    io_in_0_valid
      ? io_in_0_bits_uop_prs1_busy
      : io_in_1_valid
          ? io_in_1_bits_uop_prs1_busy
          : io_in_2_valid
              ? io_in_2_bits_uop_prs1_busy
              : io_in_3_valid
                  ? io_in_3_bits_uop_prs1_busy
                  : io_in_4_valid
                      ? io_in_4_bits_uop_prs1_busy
                      : io_in_5_valid
                          ? io_in_5_bits_uop_prs1_busy
                          : io_in_6_valid
                              ? io_in_6_bits_uop_prs1_busy
                              : io_in_7_bits_uop_prs1_busy;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_prs2_busy =
    io_in_0_valid
      ? io_in_0_bits_uop_prs2_busy
      : io_in_1_valid
          ? io_in_1_bits_uop_prs2_busy
          : io_in_2_valid
              ? io_in_2_bits_uop_prs2_busy
              : io_in_3_valid
                  ? io_in_3_bits_uop_prs2_busy
                  : io_in_4_valid
                      ? io_in_4_bits_uop_prs2_busy
                      : io_in_5_valid
                          ? io_in_5_bits_uop_prs2_busy
                          : io_in_6_valid
                              ? io_in_6_bits_uop_prs2_busy
                              : io_in_7_bits_uop_prs2_busy;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_prs3_busy =
    io_in_0_valid
      ? io_in_0_bits_uop_prs3_busy
      : io_in_1_valid
          ? io_in_1_bits_uop_prs3_busy
          : io_in_2_valid
              ? io_in_2_bits_uop_prs3_busy
              : io_in_3_valid
                  ? io_in_3_bits_uop_prs3_busy
                  : io_in_4_valid
                      ? io_in_4_bits_uop_prs3_busy
                      : io_in_5_valid
                          ? io_in_5_bits_uop_prs3_busy
                          : io_in_6_valid
                              ? io_in_6_bits_uop_prs3_busy
                              : io_in_7_bits_uop_prs3_busy;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_ppred_busy =
    io_in_0_valid
      ? io_in_0_bits_uop_ppred_busy
      : io_in_1_valid
          ? io_in_1_bits_uop_ppred_busy
          : io_in_2_valid
              ? io_in_2_bits_uop_ppred_busy
              : io_in_3_valid
                  ? io_in_3_bits_uop_ppred_busy
                  : io_in_4_valid
                      ? io_in_4_bits_uop_ppred_busy
                      : io_in_5_valid
                          ? io_in_5_bits_uop_ppred_busy
                          : io_in_6_valid
                              ? io_in_6_bits_uop_ppred_busy
                              : io_in_7_bits_uop_ppred_busy;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_stale_pdst =
    io_in_0_valid
      ? io_in_0_bits_uop_stale_pdst
      : io_in_1_valid
          ? io_in_1_bits_uop_stale_pdst
          : io_in_2_valid
              ? io_in_2_bits_uop_stale_pdst
              : io_in_3_valid
                  ? io_in_3_bits_uop_stale_pdst
                  : io_in_4_valid
                      ? io_in_4_bits_uop_stale_pdst
                      : io_in_5_valid
                          ? io_in_5_bits_uop_stale_pdst
                          : io_in_6_valid
                              ? io_in_6_bits_uop_stale_pdst
                              : io_in_7_bits_uop_stale_pdst;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_exception =
    io_in_0_valid
      ? io_in_0_bits_uop_exception
      : io_in_1_valid
          ? io_in_1_bits_uop_exception
          : io_in_2_valid
              ? io_in_2_bits_uop_exception
              : io_in_3_valid
                  ? io_in_3_bits_uop_exception
                  : io_in_4_valid
                      ? io_in_4_bits_uop_exception
                      : io_in_5_valid
                          ? io_in_5_bits_uop_exception
                          : io_in_6_valid
                              ? io_in_6_bits_uop_exception
                              : io_in_7_bits_uop_exception;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_exc_cause =
    io_in_0_valid
      ? io_in_0_bits_uop_exc_cause
      : io_in_1_valid
          ? io_in_1_bits_uop_exc_cause
          : io_in_2_valid
              ? io_in_2_bits_uop_exc_cause
              : io_in_3_valid
                  ? io_in_3_bits_uop_exc_cause
                  : io_in_4_valid
                      ? io_in_4_bits_uop_exc_cause
                      : io_in_5_valid
                          ? io_in_5_bits_uop_exc_cause
                          : io_in_6_valid
                              ? io_in_6_bits_uop_exc_cause
                              : io_in_7_bits_uop_exc_cause;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_bypassable =
    io_in_0_valid
      ? io_in_0_bits_uop_bypassable
      : io_in_1_valid
          ? io_in_1_bits_uop_bypassable
          : io_in_2_valid
              ? io_in_2_bits_uop_bypassable
              : io_in_3_valid
                  ? io_in_3_bits_uop_bypassable
                  : io_in_4_valid
                      ? io_in_4_bits_uop_bypassable
                      : io_in_5_valid
                          ? io_in_5_bits_uop_bypassable
                          : io_in_6_valid
                              ? io_in_6_bits_uop_bypassable
                              : io_in_7_bits_uop_bypassable;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_mem_cmd =
    io_in_0_valid
      ? io_in_0_bits_uop_mem_cmd
      : io_in_1_valid
          ? io_in_1_bits_uop_mem_cmd
          : io_in_2_valid
              ? io_in_2_bits_uop_mem_cmd
              : io_in_3_valid
                  ? io_in_3_bits_uop_mem_cmd
                  : io_in_4_valid
                      ? io_in_4_bits_uop_mem_cmd
                      : io_in_5_valid
                          ? io_in_5_bits_uop_mem_cmd
                          : io_in_6_valid
                              ? io_in_6_bits_uop_mem_cmd
                              : io_in_7_bits_uop_mem_cmd;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_mem_size =
    io_in_0_valid
      ? io_in_0_bits_uop_mem_size
      : io_in_1_valid
          ? io_in_1_bits_uop_mem_size
          : io_in_2_valid
              ? io_in_2_bits_uop_mem_size
              : io_in_3_valid
                  ? io_in_3_bits_uop_mem_size
                  : io_in_4_valid
                      ? io_in_4_bits_uop_mem_size
                      : io_in_5_valid
                          ? io_in_5_bits_uop_mem_size
                          : io_in_6_valid
                              ? io_in_6_bits_uop_mem_size
                              : io_in_7_bits_uop_mem_size;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_mem_signed =
    io_in_0_valid
      ? io_in_0_bits_uop_mem_signed
      : io_in_1_valid
          ? io_in_1_bits_uop_mem_signed
          : io_in_2_valid
              ? io_in_2_bits_uop_mem_signed
              : io_in_3_valid
                  ? io_in_3_bits_uop_mem_signed
                  : io_in_4_valid
                      ? io_in_4_bits_uop_mem_signed
                      : io_in_5_valid
                          ? io_in_5_bits_uop_mem_signed
                          : io_in_6_valid
                              ? io_in_6_bits_uop_mem_signed
                              : io_in_7_bits_uop_mem_signed;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_is_fence =
    io_in_0_valid
      ? io_in_0_bits_uop_is_fence
      : io_in_1_valid
          ? io_in_1_bits_uop_is_fence
          : io_in_2_valid
              ? io_in_2_bits_uop_is_fence
              : io_in_3_valid
                  ? io_in_3_bits_uop_is_fence
                  : io_in_4_valid
                      ? io_in_4_bits_uop_is_fence
                      : io_in_5_valid
                          ? io_in_5_bits_uop_is_fence
                          : io_in_6_valid
                              ? io_in_6_bits_uop_is_fence
                              : io_in_7_bits_uop_is_fence;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_is_fencei =
    io_in_0_valid
      ? io_in_0_bits_uop_is_fencei
      : io_in_1_valid
          ? io_in_1_bits_uop_is_fencei
          : io_in_2_valid
              ? io_in_2_bits_uop_is_fencei
              : io_in_3_valid
                  ? io_in_3_bits_uop_is_fencei
                  : io_in_4_valid
                      ? io_in_4_bits_uop_is_fencei
                      : io_in_5_valid
                          ? io_in_5_bits_uop_is_fencei
                          : io_in_6_valid
                              ? io_in_6_bits_uop_is_fencei
                              : io_in_7_bits_uop_is_fencei;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_is_amo =
    io_in_0_valid
      ? io_in_0_bits_uop_is_amo
      : io_in_1_valid
          ? io_in_1_bits_uop_is_amo
          : io_in_2_valid
              ? io_in_2_bits_uop_is_amo
              : io_in_3_valid
                  ? io_in_3_bits_uop_is_amo
                  : io_in_4_valid
                      ? io_in_4_bits_uop_is_amo
                      : io_in_5_valid
                          ? io_in_5_bits_uop_is_amo
                          : io_in_6_valid
                              ? io_in_6_bits_uop_is_amo
                              : io_in_7_bits_uop_is_amo;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_uses_ldq =
    io_in_0_valid
      ? io_in_0_bits_uop_uses_ldq
      : io_in_1_valid
          ? io_in_1_bits_uop_uses_ldq
          : io_in_2_valid
              ? io_in_2_bits_uop_uses_ldq
              : io_in_3_valid
                  ? io_in_3_bits_uop_uses_ldq
                  : io_in_4_valid
                      ? io_in_4_bits_uop_uses_ldq
                      : io_in_5_valid
                          ? io_in_5_bits_uop_uses_ldq
                          : io_in_6_valid
                              ? io_in_6_bits_uop_uses_ldq
                              : io_in_7_bits_uop_uses_ldq;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_uses_stq =
    io_in_0_valid
      ? io_in_0_bits_uop_uses_stq
      : io_in_1_valid
          ? io_in_1_bits_uop_uses_stq
          : io_in_2_valid
              ? io_in_2_bits_uop_uses_stq
              : io_in_3_valid
                  ? io_in_3_bits_uop_uses_stq
                  : io_in_4_valid
                      ? io_in_4_bits_uop_uses_stq
                      : io_in_5_valid
                          ? io_in_5_bits_uop_uses_stq
                          : io_in_6_valid
                              ? io_in_6_bits_uop_uses_stq
                              : io_in_7_bits_uop_uses_stq;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_is_sys_pc2epc =
    io_in_0_valid
      ? io_in_0_bits_uop_is_sys_pc2epc
      : io_in_1_valid
          ? io_in_1_bits_uop_is_sys_pc2epc
          : io_in_2_valid
              ? io_in_2_bits_uop_is_sys_pc2epc
              : io_in_3_valid
                  ? io_in_3_bits_uop_is_sys_pc2epc
                  : io_in_4_valid
                      ? io_in_4_bits_uop_is_sys_pc2epc
                      : io_in_5_valid
                          ? io_in_5_bits_uop_is_sys_pc2epc
                          : io_in_6_valid
                              ? io_in_6_bits_uop_is_sys_pc2epc
                              : io_in_7_bits_uop_is_sys_pc2epc;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_is_unique =
    io_in_0_valid
      ? io_in_0_bits_uop_is_unique
      : io_in_1_valid
          ? io_in_1_bits_uop_is_unique
          : io_in_2_valid
              ? io_in_2_bits_uop_is_unique
              : io_in_3_valid
                  ? io_in_3_bits_uop_is_unique
                  : io_in_4_valid
                      ? io_in_4_bits_uop_is_unique
                      : io_in_5_valid
                          ? io_in_5_bits_uop_is_unique
                          : io_in_6_valid
                              ? io_in_6_bits_uop_is_unique
                              : io_in_7_bits_uop_is_unique;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_flush_on_commit =
    io_in_0_valid
      ? io_in_0_bits_uop_flush_on_commit
      : io_in_1_valid
          ? io_in_1_bits_uop_flush_on_commit
          : io_in_2_valid
              ? io_in_2_bits_uop_flush_on_commit
              : io_in_3_valid
                  ? io_in_3_bits_uop_flush_on_commit
                  : io_in_4_valid
                      ? io_in_4_bits_uop_flush_on_commit
                      : io_in_5_valid
                          ? io_in_5_bits_uop_flush_on_commit
                          : io_in_6_valid
                              ? io_in_6_bits_uop_flush_on_commit
                              : io_in_7_bits_uop_flush_on_commit;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_ldst_is_rs1 =
    io_in_0_valid
      ? io_in_0_bits_uop_ldst_is_rs1
      : io_in_1_valid
          ? io_in_1_bits_uop_ldst_is_rs1
          : io_in_2_valid
              ? io_in_2_bits_uop_ldst_is_rs1
              : io_in_3_valid
                  ? io_in_3_bits_uop_ldst_is_rs1
                  : io_in_4_valid
                      ? io_in_4_bits_uop_ldst_is_rs1
                      : io_in_5_valid
                          ? io_in_5_bits_uop_ldst_is_rs1
                          : io_in_6_valid
                              ? io_in_6_bits_uop_ldst_is_rs1
                              : io_in_7_bits_uop_ldst_is_rs1;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_ldst =
    io_in_0_valid
      ? io_in_0_bits_uop_ldst
      : io_in_1_valid
          ? io_in_1_bits_uop_ldst
          : io_in_2_valid
              ? io_in_2_bits_uop_ldst
              : io_in_3_valid
                  ? io_in_3_bits_uop_ldst
                  : io_in_4_valid
                      ? io_in_4_bits_uop_ldst
                      : io_in_5_valid
                          ? io_in_5_bits_uop_ldst
                          : io_in_6_valid ? io_in_6_bits_uop_ldst : io_in_7_bits_uop_ldst;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_lrs1 =
    io_in_0_valid
      ? io_in_0_bits_uop_lrs1
      : io_in_1_valid
          ? io_in_1_bits_uop_lrs1
          : io_in_2_valid
              ? io_in_2_bits_uop_lrs1
              : io_in_3_valid
                  ? io_in_3_bits_uop_lrs1
                  : io_in_4_valid
                      ? io_in_4_bits_uop_lrs1
                      : io_in_5_valid
                          ? io_in_5_bits_uop_lrs1
                          : io_in_6_valid ? io_in_6_bits_uop_lrs1 : io_in_7_bits_uop_lrs1;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_lrs2 =
    io_in_0_valid
      ? io_in_0_bits_uop_lrs2
      : io_in_1_valid
          ? io_in_1_bits_uop_lrs2
          : io_in_2_valid
              ? io_in_2_bits_uop_lrs2
              : io_in_3_valid
                  ? io_in_3_bits_uop_lrs2
                  : io_in_4_valid
                      ? io_in_4_bits_uop_lrs2
                      : io_in_5_valid
                          ? io_in_5_bits_uop_lrs2
                          : io_in_6_valid ? io_in_6_bits_uop_lrs2 : io_in_7_bits_uop_lrs2;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_lrs3 =
    io_in_0_valid
      ? io_in_0_bits_uop_lrs3
      : io_in_1_valid
          ? io_in_1_bits_uop_lrs3
          : io_in_2_valid
              ? io_in_2_bits_uop_lrs3
              : io_in_3_valid
                  ? io_in_3_bits_uop_lrs3
                  : io_in_4_valid
                      ? io_in_4_bits_uop_lrs3
                      : io_in_5_valid
                          ? io_in_5_bits_uop_lrs3
                          : io_in_6_valid ? io_in_6_bits_uop_lrs3 : io_in_7_bits_uop_lrs3;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_ldst_val =
    io_in_0_valid
      ? io_in_0_bits_uop_ldst_val
      : io_in_1_valid
          ? io_in_1_bits_uop_ldst_val
          : io_in_2_valid
              ? io_in_2_bits_uop_ldst_val
              : io_in_3_valid
                  ? io_in_3_bits_uop_ldst_val
                  : io_in_4_valid
                      ? io_in_4_bits_uop_ldst_val
                      : io_in_5_valid
                          ? io_in_5_bits_uop_ldst_val
                          : io_in_6_valid
                              ? io_in_6_bits_uop_ldst_val
                              : io_in_7_bits_uop_ldst_val;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_dst_rtype =
    io_in_0_valid
      ? io_in_0_bits_uop_dst_rtype
      : io_in_1_valid
          ? io_in_1_bits_uop_dst_rtype
          : io_in_2_valid
              ? io_in_2_bits_uop_dst_rtype
              : io_in_3_valid
                  ? io_in_3_bits_uop_dst_rtype
                  : io_in_4_valid
                      ? io_in_4_bits_uop_dst_rtype
                      : io_in_5_valid
                          ? io_in_5_bits_uop_dst_rtype
                          : io_in_6_valid
                              ? io_in_6_bits_uop_dst_rtype
                              : io_in_7_bits_uop_dst_rtype;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_lrs1_rtype =
    io_in_0_valid
      ? io_in_0_bits_uop_lrs1_rtype
      : io_in_1_valid
          ? io_in_1_bits_uop_lrs1_rtype
          : io_in_2_valid
              ? io_in_2_bits_uop_lrs1_rtype
              : io_in_3_valid
                  ? io_in_3_bits_uop_lrs1_rtype
                  : io_in_4_valid
                      ? io_in_4_bits_uop_lrs1_rtype
                      : io_in_5_valid
                          ? io_in_5_bits_uop_lrs1_rtype
                          : io_in_6_valid
                              ? io_in_6_bits_uop_lrs1_rtype
                              : io_in_7_bits_uop_lrs1_rtype;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_lrs2_rtype =
    io_in_0_valid
      ? io_in_0_bits_uop_lrs2_rtype
      : io_in_1_valid
          ? io_in_1_bits_uop_lrs2_rtype
          : io_in_2_valid
              ? io_in_2_bits_uop_lrs2_rtype
              : io_in_3_valid
                  ? io_in_3_bits_uop_lrs2_rtype
                  : io_in_4_valid
                      ? io_in_4_bits_uop_lrs2_rtype
                      : io_in_5_valid
                          ? io_in_5_bits_uop_lrs2_rtype
                          : io_in_6_valid
                              ? io_in_6_bits_uop_lrs2_rtype
                              : io_in_7_bits_uop_lrs2_rtype;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_frs3_en =
    io_in_0_valid
      ? io_in_0_bits_uop_frs3_en
      : io_in_1_valid
          ? io_in_1_bits_uop_frs3_en
          : io_in_2_valid
              ? io_in_2_bits_uop_frs3_en
              : io_in_3_valid
                  ? io_in_3_bits_uop_frs3_en
                  : io_in_4_valid
                      ? io_in_4_bits_uop_frs3_en
                      : io_in_5_valid
                          ? io_in_5_bits_uop_frs3_en
                          : io_in_6_valid
                              ? io_in_6_bits_uop_frs3_en
                              : io_in_7_bits_uop_frs3_en;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_fp_val =
    io_in_0_valid
      ? io_in_0_bits_uop_fp_val
      : io_in_1_valid
          ? io_in_1_bits_uop_fp_val
          : io_in_2_valid
              ? io_in_2_bits_uop_fp_val
              : io_in_3_valid
                  ? io_in_3_bits_uop_fp_val
                  : io_in_4_valid
                      ? io_in_4_bits_uop_fp_val
                      : io_in_5_valid
                          ? io_in_5_bits_uop_fp_val
                          : io_in_6_valid
                              ? io_in_6_bits_uop_fp_val
                              : io_in_7_bits_uop_fp_val;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_fp_single =
    io_in_0_valid
      ? io_in_0_bits_uop_fp_single
      : io_in_1_valid
          ? io_in_1_bits_uop_fp_single
          : io_in_2_valid
              ? io_in_2_bits_uop_fp_single
              : io_in_3_valid
                  ? io_in_3_bits_uop_fp_single
                  : io_in_4_valid
                      ? io_in_4_bits_uop_fp_single
                      : io_in_5_valid
                          ? io_in_5_bits_uop_fp_single
                          : io_in_6_valid
                              ? io_in_6_bits_uop_fp_single
                              : io_in_7_bits_uop_fp_single;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_xcpt_pf_if =
    io_in_0_valid
      ? io_in_0_bits_uop_xcpt_pf_if
      : io_in_1_valid
          ? io_in_1_bits_uop_xcpt_pf_if
          : io_in_2_valid
              ? io_in_2_bits_uop_xcpt_pf_if
              : io_in_3_valid
                  ? io_in_3_bits_uop_xcpt_pf_if
                  : io_in_4_valid
                      ? io_in_4_bits_uop_xcpt_pf_if
                      : io_in_5_valid
                          ? io_in_5_bits_uop_xcpt_pf_if
                          : io_in_6_valid
                              ? io_in_6_bits_uop_xcpt_pf_if
                              : io_in_7_bits_uop_xcpt_pf_if;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_xcpt_ae_if =
    io_in_0_valid
      ? io_in_0_bits_uop_xcpt_ae_if
      : io_in_1_valid
          ? io_in_1_bits_uop_xcpt_ae_if
          : io_in_2_valid
              ? io_in_2_bits_uop_xcpt_ae_if
              : io_in_3_valid
                  ? io_in_3_bits_uop_xcpt_ae_if
                  : io_in_4_valid
                      ? io_in_4_bits_uop_xcpt_ae_if
                      : io_in_5_valid
                          ? io_in_5_bits_uop_xcpt_ae_if
                          : io_in_6_valid
                              ? io_in_6_bits_uop_xcpt_ae_if
                              : io_in_7_bits_uop_xcpt_ae_if;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_xcpt_ma_if =
    io_in_0_valid
      ? io_in_0_bits_uop_xcpt_ma_if
      : io_in_1_valid
          ? io_in_1_bits_uop_xcpt_ma_if
          : io_in_2_valid
              ? io_in_2_bits_uop_xcpt_ma_if
              : io_in_3_valid
                  ? io_in_3_bits_uop_xcpt_ma_if
                  : io_in_4_valid
                      ? io_in_4_bits_uop_xcpt_ma_if
                      : io_in_5_valid
                          ? io_in_5_bits_uop_xcpt_ma_if
                          : io_in_6_valid
                              ? io_in_6_bits_uop_xcpt_ma_if
                              : io_in_7_bits_uop_xcpt_ma_if;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_bp_debug_if =
    io_in_0_valid
      ? io_in_0_bits_uop_bp_debug_if
      : io_in_1_valid
          ? io_in_1_bits_uop_bp_debug_if
          : io_in_2_valid
              ? io_in_2_bits_uop_bp_debug_if
              : io_in_3_valid
                  ? io_in_3_bits_uop_bp_debug_if
                  : io_in_4_valid
                      ? io_in_4_bits_uop_bp_debug_if
                      : io_in_5_valid
                          ? io_in_5_bits_uop_bp_debug_if
                          : io_in_6_valid
                              ? io_in_6_bits_uop_bp_debug_if
                              : io_in_7_bits_uop_bp_debug_if;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_bp_xcpt_if =
    io_in_0_valid
      ? io_in_0_bits_uop_bp_xcpt_if
      : io_in_1_valid
          ? io_in_1_bits_uop_bp_xcpt_if
          : io_in_2_valid
              ? io_in_2_bits_uop_bp_xcpt_if
              : io_in_3_valid
                  ? io_in_3_bits_uop_bp_xcpt_if
                  : io_in_4_valid
                      ? io_in_4_bits_uop_bp_xcpt_if
                      : io_in_5_valid
                          ? io_in_5_bits_uop_bp_xcpt_if
                          : io_in_6_valid
                              ? io_in_6_bits_uop_bp_xcpt_if
                              : io_in_7_bits_uop_bp_xcpt_if;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_debug_fsrc =
    io_in_0_valid
      ? io_in_0_bits_uop_debug_fsrc
      : io_in_1_valid
          ? io_in_1_bits_uop_debug_fsrc
          : io_in_2_valid
              ? io_in_2_bits_uop_debug_fsrc
              : io_in_3_valid
                  ? io_in_3_bits_uop_debug_fsrc
                  : io_in_4_valid
                      ? io_in_4_bits_uop_debug_fsrc
                      : io_in_5_valid
                          ? io_in_5_bits_uop_debug_fsrc
                          : io_in_6_valid
                              ? io_in_6_bits_uop_debug_fsrc
                              : io_in_7_bits_uop_debug_fsrc;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_debug_tsrc =
    io_in_0_valid
      ? io_in_0_bits_uop_debug_tsrc
      : io_in_1_valid
          ? io_in_1_bits_uop_debug_tsrc
          : io_in_2_valid
              ? io_in_2_bits_uop_debug_tsrc
              : io_in_3_valid
                  ? io_in_3_bits_uop_debug_tsrc
                  : io_in_4_valid
                      ? io_in_4_bits_uop_debug_tsrc
                      : io_in_5_valid
                          ? io_in_5_bits_uop_debug_tsrc
                          : io_in_6_valid
                              ? io_in_6_bits_uop_debug_tsrc
                              : io_in_7_bits_uop_debug_tsrc;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_addr =
    io_in_0_valid
      ? io_in_0_bits_addr
      : io_in_1_valid
          ? io_in_1_bits_addr
          : io_in_2_valid
              ? io_in_2_bits_addr
              : io_in_3_valid
                  ? io_in_3_bits_addr
                  : io_in_4_valid
                      ? io_in_4_bits_addr
                      : io_in_5_valid
                          ? io_in_5_bits_addr
                          : io_in_6_valid ? io_in_6_bits_addr : io_in_7_bits_addr;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_is_hella =
    io_in_0_valid
      ? io_in_0_bits_is_hella
      : io_in_1_valid
          ? io_in_1_bits_is_hella
          : io_in_2_valid
              ? io_in_2_bits_is_hella
              : io_in_3_valid
                  ? io_in_3_bits_is_hella
                  : io_in_4_valid
                      ? io_in_4_bits_is_hella
                      : io_in_5_valid
                          ? io_in_5_bits_is_hella
                          : io_in_6_valid ? io_in_6_bits_is_hella : io_in_7_bits_is_hella;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_way_en =
    io_in_0_valid
      ? io_in_0_bits_way_en
      : io_in_1_valid
          ? io_in_1_bits_way_en
          : io_in_2_valid
              ? io_in_2_bits_way_en
              : io_in_3_valid
                  ? io_in_3_bits_way_en
                  : io_in_4_valid
                      ? io_in_4_bits_way_en
                      : io_in_5_valid
                          ? io_in_5_bits_way_en
                          : io_in_6_valid ? io_in_6_bits_way_en : io_in_7_bits_way_en;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_sdq_id =
    io_in_0_valid
      ? io_in_0_bits_sdq_id
      : io_in_1_valid
          ? io_in_1_bits_sdq_id
          : io_in_2_valid
              ? io_in_2_bits_sdq_id
              : io_in_3_valid
                  ? io_in_3_bits_sdq_id
                  : io_in_4_valid
                      ? io_in_4_bits_sdq_id
                      : io_in_5_valid
                          ? io_in_5_bits_sdq_id
                          : io_in_6_valid ? io_in_6_bits_sdq_id : io_in_7_bits_sdq_id;	// Arbiter.scala:124:15, :126:27, :128:19
endmodule

