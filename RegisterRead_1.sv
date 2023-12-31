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

module RegisterRead_1(
  input         clock,
                reset,
                io_iss_valids_0,
                io_iss_valids_1,
                io_iss_valids_2,
                io_iss_valids_3,
                io_iss_valids_4,
                io_iss_valids_5,
  input  [6:0]  io_iss_uops_0_uopc,
  input  [31:0] io_iss_uops_0_inst,
                io_iss_uops_0_debug_inst,
  input         io_iss_uops_0_is_rvc,
  input  [39:0] io_iss_uops_0_debug_pc,
  input  [2:0]  io_iss_uops_0_iq_type,
  input  [9:0]  io_iss_uops_0_fu_code,
  input  [1:0]  io_iss_uops_0_iw_state,
  input         io_iss_uops_0_is_br,
                io_iss_uops_0_is_jalr,
                io_iss_uops_0_is_jal,
                io_iss_uops_0_is_sfb,
  input  [19:0] io_iss_uops_0_br_mask,
  input  [4:0]  io_iss_uops_0_br_tag,
  input  [5:0]  io_iss_uops_0_ftq_idx,
  input         io_iss_uops_0_edge_inst,
  input  [5:0]  io_iss_uops_0_pc_lob,
  input         io_iss_uops_0_taken,
  input  [19:0] io_iss_uops_0_imm_packed,
  input  [11:0] io_iss_uops_0_csr_addr,
  input  [6:0]  io_iss_uops_0_rob_idx,
  input  [4:0]  io_iss_uops_0_ldq_idx,
                io_iss_uops_0_stq_idx,
  input  [1:0]  io_iss_uops_0_rxq_idx,
  input  [6:0]  io_iss_uops_0_pdst,
                io_iss_uops_0_prs1,
                io_iss_uops_0_prs2,
                io_iss_uops_0_prs3,
  input  [5:0]  io_iss_uops_0_ppred,
  input         io_iss_uops_0_prs1_busy,
                io_iss_uops_0_prs2_busy,
                io_iss_uops_0_prs3_busy,
                io_iss_uops_0_ppred_busy,
  input  [6:0]  io_iss_uops_0_stale_pdst,
  input         io_iss_uops_0_exception,
  input  [63:0] io_iss_uops_0_exc_cause,
  input         io_iss_uops_0_bypassable,
  input  [4:0]  io_iss_uops_0_mem_cmd,
  input  [1:0]  io_iss_uops_0_mem_size,
  input         io_iss_uops_0_mem_signed,
                io_iss_uops_0_is_fence,
                io_iss_uops_0_is_fencei,
                io_iss_uops_0_is_amo,
                io_iss_uops_0_uses_ldq,
                io_iss_uops_0_uses_stq,
                io_iss_uops_0_is_sys_pc2epc,
                io_iss_uops_0_is_unique,
                io_iss_uops_0_flush_on_commit,
                io_iss_uops_0_ldst_is_rs1,
  input  [5:0]  io_iss_uops_0_ldst,
                io_iss_uops_0_lrs1,
                io_iss_uops_0_lrs2,
                io_iss_uops_0_lrs3,
  input         io_iss_uops_0_ldst_val,
  input  [1:0]  io_iss_uops_0_dst_rtype,
                io_iss_uops_0_lrs1_rtype,
                io_iss_uops_0_lrs2_rtype,
  input         io_iss_uops_0_frs3_en,
                io_iss_uops_0_fp_val,
                io_iss_uops_0_fp_single,
                io_iss_uops_0_xcpt_pf_if,
                io_iss_uops_0_xcpt_ae_if,
                io_iss_uops_0_xcpt_ma_if,
                io_iss_uops_0_bp_debug_if,
                io_iss_uops_0_bp_xcpt_if,
  input  [1:0]  io_iss_uops_0_debug_fsrc,
                io_iss_uops_0_debug_tsrc,
  input  [6:0]  io_iss_uops_1_uopc,
  input  [31:0] io_iss_uops_1_inst,
                io_iss_uops_1_debug_inst,
  input         io_iss_uops_1_is_rvc,
  input  [39:0] io_iss_uops_1_debug_pc,
  input  [2:0]  io_iss_uops_1_iq_type,
  input  [9:0]  io_iss_uops_1_fu_code,
  input  [1:0]  io_iss_uops_1_iw_state,
  input         io_iss_uops_1_is_br,
                io_iss_uops_1_is_jalr,
                io_iss_uops_1_is_jal,
                io_iss_uops_1_is_sfb,
  input  [19:0] io_iss_uops_1_br_mask,
  input  [4:0]  io_iss_uops_1_br_tag,
  input  [5:0]  io_iss_uops_1_ftq_idx,
  input         io_iss_uops_1_edge_inst,
  input  [5:0]  io_iss_uops_1_pc_lob,
  input         io_iss_uops_1_taken,
  input  [19:0] io_iss_uops_1_imm_packed,
  input  [11:0] io_iss_uops_1_csr_addr,
  input  [6:0]  io_iss_uops_1_rob_idx,
  input  [4:0]  io_iss_uops_1_ldq_idx,
                io_iss_uops_1_stq_idx,
  input  [1:0]  io_iss_uops_1_rxq_idx,
  input  [6:0]  io_iss_uops_1_pdst,
                io_iss_uops_1_prs1,
                io_iss_uops_1_prs2,
                io_iss_uops_1_prs3,
  input  [5:0]  io_iss_uops_1_ppred,
  input         io_iss_uops_1_prs1_busy,
                io_iss_uops_1_prs2_busy,
                io_iss_uops_1_prs3_busy,
                io_iss_uops_1_ppred_busy,
  input  [6:0]  io_iss_uops_1_stale_pdst,
  input         io_iss_uops_1_exception,
  input  [63:0] io_iss_uops_1_exc_cause,
  input         io_iss_uops_1_bypassable,
  input  [4:0]  io_iss_uops_1_mem_cmd,
  input  [1:0]  io_iss_uops_1_mem_size,
  input         io_iss_uops_1_mem_signed,
                io_iss_uops_1_is_fence,
                io_iss_uops_1_is_fencei,
                io_iss_uops_1_is_amo,
                io_iss_uops_1_uses_ldq,
                io_iss_uops_1_uses_stq,
                io_iss_uops_1_is_sys_pc2epc,
                io_iss_uops_1_is_unique,
                io_iss_uops_1_flush_on_commit,
                io_iss_uops_1_ldst_is_rs1,
  input  [5:0]  io_iss_uops_1_ldst,
                io_iss_uops_1_lrs1,
                io_iss_uops_1_lrs2,
                io_iss_uops_1_lrs3,
  input         io_iss_uops_1_ldst_val,
  input  [1:0]  io_iss_uops_1_dst_rtype,
                io_iss_uops_1_lrs1_rtype,
                io_iss_uops_1_lrs2_rtype,
  input         io_iss_uops_1_frs3_en,
                io_iss_uops_1_fp_val,
                io_iss_uops_1_fp_single,
                io_iss_uops_1_xcpt_pf_if,
                io_iss_uops_1_xcpt_ae_if,
                io_iss_uops_1_xcpt_ma_if,
                io_iss_uops_1_bp_debug_if,
                io_iss_uops_1_bp_xcpt_if,
  input  [1:0]  io_iss_uops_1_debug_fsrc,
                io_iss_uops_1_debug_tsrc,
  input  [6:0]  io_iss_uops_2_uopc,
  input  [31:0] io_iss_uops_2_inst,
                io_iss_uops_2_debug_inst,
  input         io_iss_uops_2_is_rvc,
  input  [39:0] io_iss_uops_2_debug_pc,
  input  [2:0]  io_iss_uops_2_iq_type,
  input  [9:0]  io_iss_uops_2_fu_code,
  input  [1:0]  io_iss_uops_2_iw_state,
  input         io_iss_uops_2_is_br,
                io_iss_uops_2_is_jalr,
                io_iss_uops_2_is_jal,
                io_iss_uops_2_is_sfb,
  input  [19:0] io_iss_uops_2_br_mask,
  input  [4:0]  io_iss_uops_2_br_tag,
  input  [5:0]  io_iss_uops_2_ftq_idx,
  input         io_iss_uops_2_edge_inst,
  input  [5:0]  io_iss_uops_2_pc_lob,
  input         io_iss_uops_2_taken,
  input  [19:0] io_iss_uops_2_imm_packed,
  input  [11:0] io_iss_uops_2_csr_addr,
  input  [6:0]  io_iss_uops_2_rob_idx,
  input  [4:0]  io_iss_uops_2_ldq_idx,
                io_iss_uops_2_stq_idx,
  input  [1:0]  io_iss_uops_2_rxq_idx,
  input  [6:0]  io_iss_uops_2_pdst,
                io_iss_uops_2_prs1,
                io_iss_uops_2_prs2,
                io_iss_uops_2_prs3,
  input  [5:0]  io_iss_uops_2_ppred,
  input         io_iss_uops_2_prs1_busy,
                io_iss_uops_2_prs2_busy,
                io_iss_uops_2_prs3_busy,
                io_iss_uops_2_ppred_busy,
  input  [6:0]  io_iss_uops_2_stale_pdst,
  input         io_iss_uops_2_exception,
  input  [63:0] io_iss_uops_2_exc_cause,
  input         io_iss_uops_2_bypassable,
  input  [4:0]  io_iss_uops_2_mem_cmd,
  input  [1:0]  io_iss_uops_2_mem_size,
  input         io_iss_uops_2_mem_signed,
                io_iss_uops_2_is_fence,
                io_iss_uops_2_is_fencei,
                io_iss_uops_2_is_amo,
                io_iss_uops_2_uses_ldq,
                io_iss_uops_2_uses_stq,
                io_iss_uops_2_is_sys_pc2epc,
                io_iss_uops_2_is_unique,
                io_iss_uops_2_flush_on_commit,
                io_iss_uops_2_ldst_is_rs1,
  input  [5:0]  io_iss_uops_2_ldst,
                io_iss_uops_2_lrs1,
                io_iss_uops_2_lrs2,
                io_iss_uops_2_lrs3,
  input         io_iss_uops_2_ldst_val,
  input  [1:0]  io_iss_uops_2_dst_rtype,
                io_iss_uops_2_lrs1_rtype,
                io_iss_uops_2_lrs2_rtype,
  input         io_iss_uops_2_frs3_en,
                io_iss_uops_2_fp_val,
                io_iss_uops_2_fp_single,
                io_iss_uops_2_xcpt_pf_if,
                io_iss_uops_2_xcpt_ae_if,
                io_iss_uops_2_xcpt_ma_if,
                io_iss_uops_2_bp_debug_if,
                io_iss_uops_2_bp_xcpt_if,
  input  [1:0]  io_iss_uops_2_debug_fsrc,
                io_iss_uops_2_debug_tsrc,
  input  [6:0]  io_iss_uops_3_uopc,
  input         io_iss_uops_3_is_rvc,
  input  [9:0]  io_iss_uops_3_fu_code,
  input         io_iss_uops_3_is_br,
                io_iss_uops_3_is_jalr,
                io_iss_uops_3_is_jal,
                io_iss_uops_3_is_sfb,
  input  [19:0] io_iss_uops_3_br_mask,
  input  [4:0]  io_iss_uops_3_br_tag,
  input  [5:0]  io_iss_uops_3_ftq_idx,
  input         io_iss_uops_3_edge_inst,
  input  [5:0]  io_iss_uops_3_pc_lob,
  input         io_iss_uops_3_taken,
  input  [19:0] io_iss_uops_3_imm_packed,
  input  [6:0]  io_iss_uops_3_rob_idx,
  input  [4:0]  io_iss_uops_3_ldq_idx,
                io_iss_uops_3_stq_idx,
  input  [6:0]  io_iss_uops_3_pdst,
                io_iss_uops_3_prs1,
                io_iss_uops_3_prs2,
  input         io_iss_uops_3_bypassable,
  input  [4:0]  io_iss_uops_3_mem_cmd,
  input         io_iss_uops_3_is_amo,
                io_iss_uops_3_uses_stq,
  input  [1:0]  io_iss_uops_3_dst_rtype,
                io_iss_uops_3_lrs1_rtype,
                io_iss_uops_3_lrs2_rtype,
  input  [6:0]  io_iss_uops_4_uopc,
  input         io_iss_uops_4_is_rvc,
  input  [9:0]  io_iss_uops_4_fu_code,
  input         io_iss_uops_4_is_br,
                io_iss_uops_4_is_jalr,
                io_iss_uops_4_is_jal,
                io_iss_uops_4_is_sfb,
  input  [19:0] io_iss_uops_4_br_mask,
  input  [4:0]  io_iss_uops_4_br_tag,
  input  [5:0]  io_iss_uops_4_ftq_idx,
  input         io_iss_uops_4_edge_inst,
  input  [5:0]  io_iss_uops_4_pc_lob,
  input         io_iss_uops_4_taken,
  input  [19:0] io_iss_uops_4_imm_packed,
  input  [6:0]  io_iss_uops_4_rob_idx,
  input  [4:0]  io_iss_uops_4_ldq_idx,
                io_iss_uops_4_stq_idx,
  input  [6:0]  io_iss_uops_4_pdst,
                io_iss_uops_4_prs1,
                io_iss_uops_4_prs2,
  input         io_iss_uops_4_bypassable,
  input  [4:0]  io_iss_uops_4_mem_cmd,
  input         io_iss_uops_4_is_amo,
                io_iss_uops_4_uses_stq,
  input  [1:0]  io_iss_uops_4_dst_rtype,
                io_iss_uops_4_lrs1_rtype,
                io_iss_uops_4_lrs2_rtype,
  input  [6:0]  io_iss_uops_5_uopc,
  input         io_iss_uops_5_is_rvc,
  input  [9:0]  io_iss_uops_5_fu_code,
  input         io_iss_uops_5_is_br,
                io_iss_uops_5_is_jalr,
                io_iss_uops_5_is_jal,
                io_iss_uops_5_is_sfb,
  input  [19:0] io_iss_uops_5_br_mask,
  input  [4:0]  io_iss_uops_5_br_tag,
  input  [5:0]  io_iss_uops_5_ftq_idx,
  input         io_iss_uops_5_edge_inst,
  input  [5:0]  io_iss_uops_5_pc_lob,
  input         io_iss_uops_5_taken,
  input  [19:0] io_iss_uops_5_imm_packed,
  input  [6:0]  io_iss_uops_5_rob_idx,
  input  [4:0]  io_iss_uops_5_ldq_idx,
                io_iss_uops_5_stq_idx,
  input  [6:0]  io_iss_uops_5_pdst,
                io_iss_uops_5_prs1,
                io_iss_uops_5_prs2,
  input         io_iss_uops_5_bypassable,
  input  [4:0]  io_iss_uops_5_mem_cmd,
  input         io_iss_uops_5_is_amo,
                io_iss_uops_5_uses_stq,
  input  [1:0]  io_iss_uops_5_dst_rtype,
                io_iss_uops_5_lrs1_rtype,
                io_iss_uops_5_lrs2_rtype,
  input  [63:0] io_rf_read_ports_0_data,
                io_rf_read_ports_1_data,
                io_rf_read_ports_2_data,
                io_rf_read_ports_3_data,
                io_rf_read_ports_4_data,
                io_rf_read_ports_5_data,
                io_rf_read_ports_6_data,
                io_rf_read_ports_7_data,
                io_rf_read_ports_8_data,
                io_rf_read_ports_9_data,
                io_rf_read_ports_10_data,
                io_rf_read_ports_11_data,
  input         io_bypass_0_valid,
  input  [6:0]  io_bypass_0_bits_uop_pdst,
  input  [1:0]  io_bypass_0_bits_uop_dst_rtype,
  input  [63:0] io_bypass_0_bits_data,
  input         io_bypass_1_valid,
  input  [6:0]  io_bypass_1_bits_uop_pdst,
  input  [1:0]  io_bypass_1_bits_uop_dst_rtype,
  input  [63:0] io_bypass_1_bits_data,
  input         io_bypass_2_valid,
  input  [6:0]  io_bypass_2_bits_uop_pdst,
  input  [1:0]  io_bypass_2_bits_uop_dst_rtype,
  input  [63:0] io_bypass_2_bits_data,
  input         io_bypass_3_valid,
  input  [6:0]  io_bypass_3_bits_uop_pdst,
  input  [1:0]  io_bypass_3_bits_uop_dst_rtype,
  input  [63:0] io_bypass_3_bits_data,
  input         io_bypass_4_valid,
  input  [6:0]  io_bypass_4_bits_uop_pdst,
  input  [1:0]  io_bypass_4_bits_uop_dst_rtype,
  input  [63:0] io_bypass_4_bits_data,
  input         io_bypass_5_valid,
  input  [6:0]  io_bypass_5_bits_uop_pdst,
  input  [1:0]  io_bypass_5_bits_uop_dst_rtype,
  input  [63:0] io_bypass_5_bits_data,
  input         io_kill,
  input  [19:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  output        io_exe_reqs_0_valid,
  output [6:0]  io_exe_reqs_0_bits_uop_uopc,
  output [31:0] io_exe_reqs_0_bits_uop_inst,
                io_exe_reqs_0_bits_uop_debug_inst,
  output        io_exe_reqs_0_bits_uop_is_rvc,
  output [39:0] io_exe_reqs_0_bits_uop_debug_pc,
  output [2:0]  io_exe_reqs_0_bits_uop_iq_type,
  output [9:0]  io_exe_reqs_0_bits_uop_fu_code,
  output [3:0]  io_exe_reqs_0_bits_uop_ctrl_br_type,
  output [1:0]  io_exe_reqs_0_bits_uop_ctrl_op1_sel,
  output [2:0]  io_exe_reqs_0_bits_uop_ctrl_op2_sel,
                io_exe_reqs_0_bits_uop_ctrl_imm_sel,
  output [3:0]  io_exe_reqs_0_bits_uop_ctrl_op_fcn,
  output        io_exe_reqs_0_bits_uop_ctrl_fcn_dw,
                io_exe_reqs_0_bits_uop_ctrl_is_load,
                io_exe_reqs_0_bits_uop_ctrl_is_sta,
                io_exe_reqs_0_bits_uop_ctrl_is_std,
  output [1:0]  io_exe_reqs_0_bits_uop_iw_state,
  output        io_exe_reqs_0_bits_uop_is_br,
                io_exe_reqs_0_bits_uop_is_jalr,
                io_exe_reqs_0_bits_uop_is_jal,
                io_exe_reqs_0_bits_uop_is_sfb,
  output [19:0] io_exe_reqs_0_bits_uop_br_mask,
  output [4:0]  io_exe_reqs_0_bits_uop_br_tag,
  output [5:0]  io_exe_reqs_0_bits_uop_ftq_idx,
  output        io_exe_reqs_0_bits_uop_edge_inst,
  output [5:0]  io_exe_reqs_0_bits_uop_pc_lob,
  output        io_exe_reqs_0_bits_uop_taken,
  output [19:0] io_exe_reqs_0_bits_uop_imm_packed,
  output [11:0] io_exe_reqs_0_bits_uop_csr_addr,
  output [6:0]  io_exe_reqs_0_bits_uop_rob_idx,
  output [4:0]  io_exe_reqs_0_bits_uop_ldq_idx,
                io_exe_reqs_0_bits_uop_stq_idx,
  output [1:0]  io_exe_reqs_0_bits_uop_rxq_idx,
  output [6:0]  io_exe_reqs_0_bits_uop_pdst,
                io_exe_reqs_0_bits_uop_prs1,
                io_exe_reqs_0_bits_uop_prs2,
                io_exe_reqs_0_bits_uop_prs3,
  output [5:0]  io_exe_reqs_0_bits_uop_ppred,
  output        io_exe_reqs_0_bits_uop_prs1_busy,
                io_exe_reqs_0_bits_uop_prs2_busy,
                io_exe_reqs_0_bits_uop_prs3_busy,
                io_exe_reqs_0_bits_uop_ppred_busy,
  output [6:0]  io_exe_reqs_0_bits_uop_stale_pdst,
  output        io_exe_reqs_0_bits_uop_exception,
  output [63:0] io_exe_reqs_0_bits_uop_exc_cause,
  output        io_exe_reqs_0_bits_uop_bypassable,
  output [4:0]  io_exe_reqs_0_bits_uop_mem_cmd,
  output [1:0]  io_exe_reqs_0_bits_uop_mem_size,
  output        io_exe_reqs_0_bits_uop_mem_signed,
                io_exe_reqs_0_bits_uop_is_fence,
                io_exe_reqs_0_bits_uop_is_fencei,
                io_exe_reqs_0_bits_uop_is_amo,
                io_exe_reqs_0_bits_uop_uses_ldq,
                io_exe_reqs_0_bits_uop_uses_stq,
                io_exe_reqs_0_bits_uop_is_sys_pc2epc,
                io_exe_reqs_0_bits_uop_is_unique,
                io_exe_reqs_0_bits_uop_flush_on_commit,
                io_exe_reqs_0_bits_uop_ldst_is_rs1,
  output [5:0]  io_exe_reqs_0_bits_uop_ldst,
                io_exe_reqs_0_bits_uop_lrs1,
                io_exe_reqs_0_bits_uop_lrs2,
                io_exe_reqs_0_bits_uop_lrs3,
  output        io_exe_reqs_0_bits_uop_ldst_val,
  output [1:0]  io_exe_reqs_0_bits_uop_dst_rtype,
                io_exe_reqs_0_bits_uop_lrs1_rtype,
                io_exe_reqs_0_bits_uop_lrs2_rtype,
  output        io_exe_reqs_0_bits_uop_frs3_en,
                io_exe_reqs_0_bits_uop_fp_val,
                io_exe_reqs_0_bits_uop_fp_single,
                io_exe_reqs_0_bits_uop_xcpt_pf_if,
                io_exe_reqs_0_bits_uop_xcpt_ae_if,
                io_exe_reqs_0_bits_uop_xcpt_ma_if,
                io_exe_reqs_0_bits_uop_bp_debug_if,
                io_exe_reqs_0_bits_uop_bp_xcpt_if,
  output [1:0]  io_exe_reqs_0_bits_uop_debug_fsrc,
                io_exe_reqs_0_bits_uop_debug_tsrc,
  output [63:0] io_exe_reqs_0_bits_rs1_data,
                io_exe_reqs_0_bits_rs2_data,
  output        io_exe_reqs_1_valid,
  output [6:0]  io_exe_reqs_1_bits_uop_uopc,
  output [31:0] io_exe_reqs_1_bits_uop_inst,
                io_exe_reqs_1_bits_uop_debug_inst,
  output        io_exe_reqs_1_bits_uop_is_rvc,
  output [39:0] io_exe_reqs_1_bits_uop_debug_pc,
  output [2:0]  io_exe_reqs_1_bits_uop_iq_type,
  output [9:0]  io_exe_reqs_1_bits_uop_fu_code,
  output [3:0]  io_exe_reqs_1_bits_uop_ctrl_br_type,
  output [1:0]  io_exe_reqs_1_bits_uop_ctrl_op1_sel,
  output [2:0]  io_exe_reqs_1_bits_uop_ctrl_op2_sel,
                io_exe_reqs_1_bits_uop_ctrl_imm_sel,
  output [3:0]  io_exe_reqs_1_bits_uop_ctrl_op_fcn,
  output        io_exe_reqs_1_bits_uop_ctrl_fcn_dw,
                io_exe_reqs_1_bits_uop_ctrl_is_load,
                io_exe_reqs_1_bits_uop_ctrl_is_sta,
                io_exe_reqs_1_bits_uop_ctrl_is_std,
  output [1:0]  io_exe_reqs_1_bits_uop_iw_state,
  output        io_exe_reqs_1_bits_uop_is_br,
                io_exe_reqs_1_bits_uop_is_jalr,
                io_exe_reqs_1_bits_uop_is_jal,
                io_exe_reqs_1_bits_uop_is_sfb,
  output [19:0] io_exe_reqs_1_bits_uop_br_mask,
  output [4:0]  io_exe_reqs_1_bits_uop_br_tag,
  output [5:0]  io_exe_reqs_1_bits_uop_ftq_idx,
  output        io_exe_reqs_1_bits_uop_edge_inst,
  output [5:0]  io_exe_reqs_1_bits_uop_pc_lob,
  output        io_exe_reqs_1_bits_uop_taken,
  output [19:0] io_exe_reqs_1_bits_uop_imm_packed,
  output [11:0] io_exe_reqs_1_bits_uop_csr_addr,
  output [6:0]  io_exe_reqs_1_bits_uop_rob_idx,
  output [4:0]  io_exe_reqs_1_bits_uop_ldq_idx,
                io_exe_reqs_1_bits_uop_stq_idx,
  output [1:0]  io_exe_reqs_1_bits_uop_rxq_idx,
  output [6:0]  io_exe_reqs_1_bits_uop_pdst,
                io_exe_reqs_1_bits_uop_prs1,
                io_exe_reqs_1_bits_uop_prs2,
                io_exe_reqs_1_bits_uop_prs3,
  output [5:0]  io_exe_reqs_1_bits_uop_ppred,
  output        io_exe_reqs_1_bits_uop_prs1_busy,
                io_exe_reqs_1_bits_uop_prs2_busy,
                io_exe_reqs_1_bits_uop_prs3_busy,
                io_exe_reqs_1_bits_uop_ppred_busy,
  output [6:0]  io_exe_reqs_1_bits_uop_stale_pdst,
  output        io_exe_reqs_1_bits_uop_exception,
  output [63:0] io_exe_reqs_1_bits_uop_exc_cause,
  output        io_exe_reqs_1_bits_uop_bypassable,
  output [4:0]  io_exe_reqs_1_bits_uop_mem_cmd,
  output [1:0]  io_exe_reqs_1_bits_uop_mem_size,
  output        io_exe_reqs_1_bits_uop_mem_signed,
                io_exe_reqs_1_bits_uop_is_fence,
                io_exe_reqs_1_bits_uop_is_fencei,
                io_exe_reqs_1_bits_uop_is_amo,
                io_exe_reqs_1_bits_uop_uses_ldq,
                io_exe_reqs_1_bits_uop_uses_stq,
                io_exe_reqs_1_bits_uop_is_sys_pc2epc,
                io_exe_reqs_1_bits_uop_is_unique,
                io_exe_reqs_1_bits_uop_flush_on_commit,
                io_exe_reqs_1_bits_uop_ldst_is_rs1,
  output [5:0]  io_exe_reqs_1_bits_uop_ldst,
                io_exe_reqs_1_bits_uop_lrs1,
                io_exe_reqs_1_bits_uop_lrs2,
                io_exe_reqs_1_bits_uop_lrs3,
  output        io_exe_reqs_1_bits_uop_ldst_val,
  output [1:0]  io_exe_reqs_1_bits_uop_dst_rtype,
                io_exe_reqs_1_bits_uop_lrs1_rtype,
                io_exe_reqs_1_bits_uop_lrs2_rtype,
  output        io_exe_reqs_1_bits_uop_frs3_en,
                io_exe_reqs_1_bits_uop_fp_val,
                io_exe_reqs_1_bits_uop_fp_single,
                io_exe_reqs_1_bits_uop_xcpt_pf_if,
                io_exe_reqs_1_bits_uop_xcpt_ae_if,
                io_exe_reqs_1_bits_uop_xcpt_ma_if,
                io_exe_reqs_1_bits_uop_bp_debug_if,
                io_exe_reqs_1_bits_uop_bp_xcpt_if,
  output [1:0]  io_exe_reqs_1_bits_uop_debug_fsrc,
                io_exe_reqs_1_bits_uop_debug_tsrc,
  output [63:0] io_exe_reqs_1_bits_rs1_data,
                io_exe_reqs_1_bits_rs2_data,
  output        io_exe_reqs_2_valid,
  output [6:0]  io_exe_reqs_2_bits_uop_uopc,
  output [31:0] io_exe_reqs_2_bits_uop_inst,
                io_exe_reqs_2_bits_uop_debug_inst,
  output        io_exe_reqs_2_bits_uop_is_rvc,
  output [39:0] io_exe_reqs_2_bits_uop_debug_pc,
  output [2:0]  io_exe_reqs_2_bits_uop_iq_type,
  output [9:0]  io_exe_reqs_2_bits_uop_fu_code,
  output [3:0]  io_exe_reqs_2_bits_uop_ctrl_br_type,
  output [1:0]  io_exe_reqs_2_bits_uop_ctrl_op1_sel,
  output [2:0]  io_exe_reqs_2_bits_uop_ctrl_op2_sel,
                io_exe_reqs_2_bits_uop_ctrl_imm_sel,
  output [3:0]  io_exe_reqs_2_bits_uop_ctrl_op_fcn,
  output        io_exe_reqs_2_bits_uop_ctrl_fcn_dw,
                io_exe_reqs_2_bits_uop_ctrl_is_load,
                io_exe_reqs_2_bits_uop_ctrl_is_sta,
                io_exe_reqs_2_bits_uop_ctrl_is_std,
  output [1:0]  io_exe_reqs_2_bits_uop_iw_state,
  output        io_exe_reqs_2_bits_uop_is_br,
                io_exe_reqs_2_bits_uop_is_jalr,
                io_exe_reqs_2_bits_uop_is_jal,
                io_exe_reqs_2_bits_uop_is_sfb,
  output [19:0] io_exe_reqs_2_bits_uop_br_mask,
  output [4:0]  io_exe_reqs_2_bits_uop_br_tag,
  output [5:0]  io_exe_reqs_2_bits_uop_ftq_idx,
  output        io_exe_reqs_2_bits_uop_edge_inst,
  output [5:0]  io_exe_reqs_2_bits_uop_pc_lob,
  output        io_exe_reqs_2_bits_uop_taken,
  output [19:0] io_exe_reqs_2_bits_uop_imm_packed,
  output [11:0] io_exe_reqs_2_bits_uop_csr_addr,
  output [6:0]  io_exe_reqs_2_bits_uop_rob_idx,
  output [4:0]  io_exe_reqs_2_bits_uop_ldq_idx,
                io_exe_reqs_2_bits_uop_stq_idx,
  output [1:0]  io_exe_reqs_2_bits_uop_rxq_idx,
  output [6:0]  io_exe_reqs_2_bits_uop_pdst,
                io_exe_reqs_2_bits_uop_prs1,
                io_exe_reqs_2_bits_uop_prs2,
                io_exe_reqs_2_bits_uop_prs3,
  output [5:0]  io_exe_reqs_2_bits_uop_ppred,
  output        io_exe_reqs_2_bits_uop_prs1_busy,
                io_exe_reqs_2_bits_uop_prs2_busy,
                io_exe_reqs_2_bits_uop_prs3_busy,
                io_exe_reqs_2_bits_uop_ppred_busy,
  output [6:0]  io_exe_reqs_2_bits_uop_stale_pdst,
  output        io_exe_reqs_2_bits_uop_exception,
  output [63:0] io_exe_reqs_2_bits_uop_exc_cause,
  output        io_exe_reqs_2_bits_uop_bypassable,
  output [4:0]  io_exe_reqs_2_bits_uop_mem_cmd,
  output [1:0]  io_exe_reqs_2_bits_uop_mem_size,
  output        io_exe_reqs_2_bits_uop_mem_signed,
                io_exe_reqs_2_bits_uop_is_fence,
                io_exe_reqs_2_bits_uop_is_fencei,
                io_exe_reqs_2_bits_uop_is_amo,
                io_exe_reqs_2_bits_uop_uses_ldq,
                io_exe_reqs_2_bits_uop_uses_stq,
                io_exe_reqs_2_bits_uop_is_sys_pc2epc,
                io_exe_reqs_2_bits_uop_is_unique,
                io_exe_reqs_2_bits_uop_flush_on_commit,
                io_exe_reqs_2_bits_uop_ldst_is_rs1,
  output [5:0]  io_exe_reqs_2_bits_uop_ldst,
                io_exe_reqs_2_bits_uop_lrs1,
                io_exe_reqs_2_bits_uop_lrs2,
                io_exe_reqs_2_bits_uop_lrs3,
  output        io_exe_reqs_2_bits_uop_ldst_val,
  output [1:0]  io_exe_reqs_2_bits_uop_dst_rtype,
                io_exe_reqs_2_bits_uop_lrs1_rtype,
                io_exe_reqs_2_bits_uop_lrs2_rtype,
  output        io_exe_reqs_2_bits_uop_frs3_en,
                io_exe_reqs_2_bits_uop_fp_val,
                io_exe_reqs_2_bits_uop_fp_single,
                io_exe_reqs_2_bits_uop_xcpt_pf_if,
                io_exe_reqs_2_bits_uop_xcpt_ae_if,
                io_exe_reqs_2_bits_uop_xcpt_ma_if,
                io_exe_reqs_2_bits_uop_bp_debug_if,
                io_exe_reqs_2_bits_uop_bp_xcpt_if,
  output [1:0]  io_exe_reqs_2_bits_uop_debug_fsrc,
                io_exe_reqs_2_bits_uop_debug_tsrc,
  output [63:0] io_exe_reqs_2_bits_rs1_data,
                io_exe_reqs_2_bits_rs2_data,
  output        io_exe_reqs_3_valid,
  output [6:0]  io_exe_reqs_3_bits_uop_uopc,
  output        io_exe_reqs_3_bits_uop_is_rvc,
  output [9:0]  io_exe_reqs_3_bits_uop_fu_code,
  output [3:0]  io_exe_reqs_3_bits_uop_ctrl_br_type,
  output [1:0]  io_exe_reqs_3_bits_uop_ctrl_op1_sel,
  output [2:0]  io_exe_reqs_3_bits_uop_ctrl_op2_sel,
                io_exe_reqs_3_bits_uop_ctrl_imm_sel,
  output [3:0]  io_exe_reqs_3_bits_uop_ctrl_op_fcn,
  output        io_exe_reqs_3_bits_uop_ctrl_fcn_dw,
  output [2:0]  io_exe_reqs_3_bits_uop_ctrl_csr_cmd,
  output        io_exe_reqs_3_bits_uop_is_br,
                io_exe_reqs_3_bits_uop_is_jalr,
                io_exe_reqs_3_bits_uop_is_jal,
                io_exe_reqs_3_bits_uop_is_sfb,
  output [19:0] io_exe_reqs_3_bits_uop_br_mask,
  output [4:0]  io_exe_reqs_3_bits_uop_br_tag,
  output [5:0]  io_exe_reqs_3_bits_uop_ftq_idx,
  output        io_exe_reqs_3_bits_uop_edge_inst,
  output [5:0]  io_exe_reqs_3_bits_uop_pc_lob,
  output        io_exe_reqs_3_bits_uop_taken,
  output [19:0] io_exe_reqs_3_bits_uop_imm_packed,
  output [6:0]  io_exe_reqs_3_bits_uop_rob_idx,
  output [4:0]  io_exe_reqs_3_bits_uop_ldq_idx,
                io_exe_reqs_3_bits_uop_stq_idx,
  output [6:0]  io_exe_reqs_3_bits_uop_pdst,
                io_exe_reqs_3_bits_uop_prs1,
  output        io_exe_reqs_3_bits_uop_bypassable,
                io_exe_reqs_3_bits_uop_is_amo,
                io_exe_reqs_3_bits_uop_uses_stq,
  output [1:0]  io_exe_reqs_3_bits_uop_dst_rtype,
  output [63:0] io_exe_reqs_3_bits_rs1_data,
                io_exe_reqs_3_bits_rs2_data,
  output        io_exe_reqs_4_valid,
  output [6:0]  io_exe_reqs_4_bits_uop_uopc,
  output        io_exe_reqs_4_bits_uop_is_rvc,
  output [9:0]  io_exe_reqs_4_bits_uop_fu_code,
  output [3:0]  io_exe_reqs_4_bits_uop_ctrl_br_type,
  output [1:0]  io_exe_reqs_4_bits_uop_ctrl_op1_sel,
  output [2:0]  io_exe_reqs_4_bits_uop_ctrl_op2_sel,
                io_exe_reqs_4_bits_uop_ctrl_imm_sel,
  output [3:0]  io_exe_reqs_4_bits_uop_ctrl_op_fcn,
  output        io_exe_reqs_4_bits_uop_ctrl_fcn_dw,
                io_exe_reqs_4_bits_uop_is_br,
                io_exe_reqs_4_bits_uop_is_jalr,
                io_exe_reqs_4_bits_uop_is_jal,
                io_exe_reqs_4_bits_uop_is_sfb,
  output [19:0] io_exe_reqs_4_bits_uop_br_mask,
  output [4:0]  io_exe_reqs_4_bits_uop_br_tag,
  output [5:0]  io_exe_reqs_4_bits_uop_ftq_idx,
  output        io_exe_reqs_4_bits_uop_edge_inst,
  output [5:0]  io_exe_reqs_4_bits_uop_pc_lob,
  output        io_exe_reqs_4_bits_uop_taken,
  output [19:0] io_exe_reqs_4_bits_uop_imm_packed,
  output [6:0]  io_exe_reqs_4_bits_uop_rob_idx,
  output [4:0]  io_exe_reqs_4_bits_uop_ldq_idx,
                io_exe_reqs_4_bits_uop_stq_idx,
  output [6:0]  io_exe_reqs_4_bits_uop_pdst,
                io_exe_reqs_4_bits_uop_prs1,
  output        io_exe_reqs_4_bits_uop_bypassable,
                io_exe_reqs_4_bits_uop_is_amo,
                io_exe_reqs_4_bits_uop_uses_stq,
  output [1:0]  io_exe_reqs_4_bits_uop_dst_rtype,
  output [63:0] io_exe_reqs_4_bits_rs1_data,
                io_exe_reqs_4_bits_rs2_data,
  output        io_exe_reqs_5_valid,
  output [6:0]  io_exe_reqs_5_bits_uop_uopc,
  output        io_exe_reqs_5_bits_uop_is_rvc,
  output [9:0]  io_exe_reqs_5_bits_uop_fu_code,
  output [3:0]  io_exe_reqs_5_bits_uop_ctrl_br_type,
  output [1:0]  io_exe_reqs_5_bits_uop_ctrl_op1_sel,
  output [2:0]  io_exe_reqs_5_bits_uop_ctrl_op2_sel,
                io_exe_reqs_5_bits_uop_ctrl_imm_sel,
  output [3:0]  io_exe_reqs_5_bits_uop_ctrl_op_fcn,
  output        io_exe_reqs_5_bits_uop_ctrl_fcn_dw,
                io_exe_reqs_5_bits_uop_is_br,
                io_exe_reqs_5_bits_uop_is_jalr,
                io_exe_reqs_5_bits_uop_is_jal,
                io_exe_reqs_5_bits_uop_is_sfb,
  output [19:0] io_exe_reqs_5_bits_uop_br_mask,
  output [4:0]  io_exe_reqs_5_bits_uop_br_tag,
  output [5:0]  io_exe_reqs_5_bits_uop_ftq_idx,
  output        io_exe_reqs_5_bits_uop_edge_inst,
  output [5:0]  io_exe_reqs_5_bits_uop_pc_lob,
  output        io_exe_reqs_5_bits_uop_taken,
  output [19:0] io_exe_reqs_5_bits_uop_imm_packed,
  output [6:0]  io_exe_reqs_5_bits_uop_rob_idx,
  output [4:0]  io_exe_reqs_5_bits_uop_ldq_idx,
                io_exe_reqs_5_bits_uop_stq_idx,
  output [6:0]  io_exe_reqs_5_bits_uop_pdst,
                io_exe_reqs_5_bits_uop_prs1,
  output        io_exe_reqs_5_bits_uop_bypassable,
                io_exe_reqs_5_bits_uop_is_amo,
                io_exe_reqs_5_bits_uop_uses_stq,
  output [1:0]  io_exe_reqs_5_bits_uop_dst_rtype,
  output [63:0] io_exe_reqs_5_bits_rs1_data,
                io_exe_reqs_5_bits_rs2_data
);

  wire [3:0]  _rrd_decode_unit_5_io_rrd_uop_ctrl_br_type;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_5_io_rrd_uop_ctrl_op1_sel;	// register-read.scala:80:33
  wire [2:0]  _rrd_decode_unit_5_io_rrd_uop_ctrl_op2_sel;	// register-read.scala:80:33
  wire [2:0]  _rrd_decode_unit_5_io_rrd_uop_ctrl_imm_sel;	// register-read.scala:80:33
  wire [3:0]  _rrd_decode_unit_5_io_rrd_uop_ctrl_op_fcn;	// register-read.scala:80:33
  wire        _rrd_decode_unit_5_io_rrd_uop_ctrl_fcn_dw;	// register-read.scala:80:33
  wire [19:0] _rrd_decode_unit_5_io_rrd_uop_imm_packed;	// register-read.scala:80:33
  wire [3:0]  _rrd_decode_unit_4_io_rrd_uop_ctrl_br_type;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_4_io_rrd_uop_ctrl_op1_sel;	// register-read.scala:80:33
  wire [2:0]  _rrd_decode_unit_4_io_rrd_uop_ctrl_op2_sel;	// register-read.scala:80:33
  wire [2:0]  _rrd_decode_unit_4_io_rrd_uop_ctrl_imm_sel;	// register-read.scala:80:33
  wire [3:0]  _rrd_decode_unit_4_io_rrd_uop_ctrl_op_fcn;	// register-read.scala:80:33
  wire        _rrd_decode_unit_4_io_rrd_uop_ctrl_fcn_dw;	// register-read.scala:80:33
  wire [19:0] _rrd_decode_unit_4_io_rrd_uop_imm_packed;	// register-read.scala:80:33
  wire [3:0]  _rrd_decode_unit_3_io_rrd_uop_ctrl_br_type;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_3_io_rrd_uop_ctrl_op1_sel;	// register-read.scala:80:33
  wire [2:0]  _rrd_decode_unit_3_io_rrd_uop_ctrl_op2_sel;	// register-read.scala:80:33
  wire [2:0]  _rrd_decode_unit_3_io_rrd_uop_ctrl_imm_sel;	// register-read.scala:80:33
  wire [3:0]  _rrd_decode_unit_3_io_rrd_uop_ctrl_op_fcn;	// register-read.scala:80:33
  wire        _rrd_decode_unit_3_io_rrd_uop_ctrl_fcn_dw;	// register-read.scala:80:33
  wire [2:0]  _rrd_decode_unit_3_io_rrd_uop_ctrl_csr_cmd;	// register-read.scala:80:33
  wire [19:0] _rrd_decode_unit_3_io_rrd_uop_imm_packed;	// register-read.scala:80:33
  wire [3:0]  _rrd_decode_unit_2_io_rrd_uop_ctrl_br_type;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_2_io_rrd_uop_ctrl_op1_sel;	// register-read.scala:80:33
  wire [2:0]  _rrd_decode_unit_2_io_rrd_uop_ctrl_op2_sel;	// register-read.scala:80:33
  wire [2:0]  _rrd_decode_unit_2_io_rrd_uop_ctrl_imm_sel;	// register-read.scala:80:33
  wire [3:0]  _rrd_decode_unit_2_io_rrd_uop_ctrl_op_fcn;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_ctrl_fcn_dw;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_ctrl_is_load;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_ctrl_is_sta;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_ctrl_is_std;	// register-read.scala:80:33
  wire [19:0] _rrd_decode_unit_2_io_rrd_uop_imm_packed;	// register-read.scala:80:33
  wire [3:0]  _rrd_decode_unit_1_io_rrd_uop_ctrl_br_type;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_1_io_rrd_uop_ctrl_op1_sel;	// register-read.scala:80:33
  wire [2:0]  _rrd_decode_unit_1_io_rrd_uop_ctrl_op2_sel;	// register-read.scala:80:33
  wire [2:0]  _rrd_decode_unit_1_io_rrd_uop_ctrl_imm_sel;	// register-read.scala:80:33
  wire [3:0]  _rrd_decode_unit_1_io_rrd_uop_ctrl_op_fcn;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_ctrl_fcn_dw;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_ctrl_is_load;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_ctrl_is_sta;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_ctrl_is_std;	// register-read.scala:80:33
  wire [19:0] _rrd_decode_unit_1_io_rrd_uop_imm_packed;	// register-read.scala:80:33
  wire [3:0]  _rrd_decode_unit_io_rrd_uop_ctrl_br_type;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_io_rrd_uop_ctrl_op1_sel;	// register-read.scala:80:33
  wire [2:0]  _rrd_decode_unit_io_rrd_uop_ctrl_op2_sel;	// register-read.scala:80:33
  wire [2:0]  _rrd_decode_unit_io_rrd_uop_ctrl_imm_sel;	// register-read.scala:80:33
  wire [3:0]  _rrd_decode_unit_io_rrd_uop_ctrl_op_fcn;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_ctrl_fcn_dw;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_ctrl_is_load;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_ctrl_is_sta;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_ctrl_is_std;	// register-read.scala:80:33
  wire [19:0] _rrd_decode_unit_io_rrd_uop_imm_packed;	// register-read.scala:80:33
  reg         exe_reg_valids_0;	// register-read.scala:69:33
  reg         exe_reg_valids_1;	// register-read.scala:69:33
  reg         exe_reg_valids_2;	// register-read.scala:69:33
  reg         exe_reg_valids_3;	// register-read.scala:69:33
  reg         exe_reg_valids_4;	// register-read.scala:69:33
  reg         exe_reg_valids_5;	// register-read.scala:69:33
  reg  [6:0]  exe_reg_uops_0_uopc;	// register-read.scala:70:29
  reg  [31:0] exe_reg_uops_0_inst;	// register-read.scala:70:29
  reg  [31:0] exe_reg_uops_0_debug_inst;	// register-read.scala:70:29
  reg         exe_reg_uops_0_is_rvc;	// register-read.scala:70:29
  reg  [39:0] exe_reg_uops_0_debug_pc;	// register-read.scala:70:29
  reg  [2:0]  exe_reg_uops_0_iq_type;	// register-read.scala:70:29
  reg  [9:0]  exe_reg_uops_0_fu_code;	// register-read.scala:70:29
  reg  [3:0]  exe_reg_uops_0_ctrl_br_type;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_0_ctrl_op1_sel;	// register-read.scala:70:29
  reg  [2:0]  exe_reg_uops_0_ctrl_op2_sel;	// register-read.scala:70:29
  reg  [2:0]  exe_reg_uops_0_ctrl_imm_sel;	// register-read.scala:70:29
  reg  [3:0]  exe_reg_uops_0_ctrl_op_fcn;	// register-read.scala:70:29
  reg         exe_reg_uops_0_ctrl_fcn_dw;	// register-read.scala:70:29
  reg         exe_reg_uops_0_ctrl_is_load;	// register-read.scala:70:29
  reg         exe_reg_uops_0_ctrl_is_sta;	// register-read.scala:70:29
  reg         exe_reg_uops_0_ctrl_is_std;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_0_iw_state;	// register-read.scala:70:29
  reg         exe_reg_uops_0_is_br;	// register-read.scala:70:29
  reg         exe_reg_uops_0_is_jalr;	// register-read.scala:70:29
  reg         exe_reg_uops_0_is_jal;	// register-read.scala:70:29
  reg         exe_reg_uops_0_is_sfb;	// register-read.scala:70:29
  reg  [19:0] exe_reg_uops_0_br_mask;	// register-read.scala:70:29
  reg  [4:0]  exe_reg_uops_0_br_tag;	// register-read.scala:70:29
  reg  [5:0]  exe_reg_uops_0_ftq_idx;	// register-read.scala:70:29
  reg         exe_reg_uops_0_edge_inst;	// register-read.scala:70:29
  reg  [5:0]  exe_reg_uops_0_pc_lob;	// register-read.scala:70:29
  reg         exe_reg_uops_0_taken;	// register-read.scala:70:29
  reg  [19:0] exe_reg_uops_0_imm_packed;	// register-read.scala:70:29
  reg  [11:0] exe_reg_uops_0_csr_addr;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_0_rob_idx;	// register-read.scala:70:29
  reg  [4:0]  exe_reg_uops_0_ldq_idx;	// register-read.scala:70:29
  reg  [4:0]  exe_reg_uops_0_stq_idx;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_0_rxq_idx;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_0_pdst;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_0_prs1;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_0_prs2;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_0_prs3;	// register-read.scala:70:29
  reg  [5:0]  exe_reg_uops_0_ppred;	// register-read.scala:70:29
  reg         exe_reg_uops_0_prs1_busy;	// register-read.scala:70:29
  reg         exe_reg_uops_0_prs2_busy;	// register-read.scala:70:29
  reg         exe_reg_uops_0_prs3_busy;	// register-read.scala:70:29
  reg         exe_reg_uops_0_ppred_busy;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_0_stale_pdst;	// register-read.scala:70:29
  reg         exe_reg_uops_0_exception;	// register-read.scala:70:29
  reg  [63:0] exe_reg_uops_0_exc_cause;	// register-read.scala:70:29
  reg         exe_reg_uops_0_bypassable;	// register-read.scala:70:29
  reg  [4:0]  exe_reg_uops_0_mem_cmd;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_0_mem_size;	// register-read.scala:70:29
  reg         exe_reg_uops_0_mem_signed;	// register-read.scala:70:29
  reg         exe_reg_uops_0_is_fence;	// register-read.scala:70:29
  reg         exe_reg_uops_0_is_fencei;	// register-read.scala:70:29
  reg         exe_reg_uops_0_is_amo;	// register-read.scala:70:29
  reg         exe_reg_uops_0_uses_ldq;	// register-read.scala:70:29
  reg         exe_reg_uops_0_uses_stq;	// register-read.scala:70:29
  reg         exe_reg_uops_0_is_sys_pc2epc;	// register-read.scala:70:29
  reg         exe_reg_uops_0_is_unique;	// register-read.scala:70:29
  reg         exe_reg_uops_0_flush_on_commit;	// register-read.scala:70:29
  reg         exe_reg_uops_0_ldst_is_rs1;	// register-read.scala:70:29
  reg  [5:0]  exe_reg_uops_0_ldst;	// register-read.scala:70:29
  reg  [5:0]  exe_reg_uops_0_lrs1;	// register-read.scala:70:29
  reg  [5:0]  exe_reg_uops_0_lrs2;	// register-read.scala:70:29
  reg  [5:0]  exe_reg_uops_0_lrs3;	// register-read.scala:70:29
  reg         exe_reg_uops_0_ldst_val;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_0_dst_rtype;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_0_lrs1_rtype;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_0_lrs2_rtype;	// register-read.scala:70:29
  reg         exe_reg_uops_0_frs3_en;	// register-read.scala:70:29
  reg         exe_reg_uops_0_fp_val;	// register-read.scala:70:29
  reg         exe_reg_uops_0_fp_single;	// register-read.scala:70:29
  reg         exe_reg_uops_0_xcpt_pf_if;	// register-read.scala:70:29
  reg         exe_reg_uops_0_xcpt_ae_if;	// register-read.scala:70:29
  reg         exe_reg_uops_0_xcpt_ma_if;	// register-read.scala:70:29
  reg         exe_reg_uops_0_bp_debug_if;	// register-read.scala:70:29
  reg         exe_reg_uops_0_bp_xcpt_if;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_0_debug_fsrc;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_0_debug_tsrc;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_1_uopc;	// register-read.scala:70:29
  reg  [31:0] exe_reg_uops_1_inst;	// register-read.scala:70:29
  reg  [31:0] exe_reg_uops_1_debug_inst;	// register-read.scala:70:29
  reg         exe_reg_uops_1_is_rvc;	// register-read.scala:70:29
  reg  [39:0] exe_reg_uops_1_debug_pc;	// register-read.scala:70:29
  reg  [2:0]  exe_reg_uops_1_iq_type;	// register-read.scala:70:29
  reg  [9:0]  exe_reg_uops_1_fu_code;	// register-read.scala:70:29
  reg  [3:0]  exe_reg_uops_1_ctrl_br_type;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_1_ctrl_op1_sel;	// register-read.scala:70:29
  reg  [2:0]  exe_reg_uops_1_ctrl_op2_sel;	// register-read.scala:70:29
  reg  [2:0]  exe_reg_uops_1_ctrl_imm_sel;	// register-read.scala:70:29
  reg  [3:0]  exe_reg_uops_1_ctrl_op_fcn;	// register-read.scala:70:29
  reg         exe_reg_uops_1_ctrl_fcn_dw;	// register-read.scala:70:29
  reg         exe_reg_uops_1_ctrl_is_load;	// register-read.scala:70:29
  reg         exe_reg_uops_1_ctrl_is_sta;	// register-read.scala:70:29
  reg         exe_reg_uops_1_ctrl_is_std;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_1_iw_state;	// register-read.scala:70:29
  reg         exe_reg_uops_1_is_br;	// register-read.scala:70:29
  reg         exe_reg_uops_1_is_jalr;	// register-read.scala:70:29
  reg         exe_reg_uops_1_is_jal;	// register-read.scala:70:29
  reg         exe_reg_uops_1_is_sfb;	// register-read.scala:70:29
  reg  [19:0] exe_reg_uops_1_br_mask;	// register-read.scala:70:29
  reg  [4:0]  exe_reg_uops_1_br_tag;	// register-read.scala:70:29
  reg  [5:0]  exe_reg_uops_1_ftq_idx;	// register-read.scala:70:29
  reg         exe_reg_uops_1_edge_inst;	// register-read.scala:70:29
  reg  [5:0]  exe_reg_uops_1_pc_lob;	// register-read.scala:70:29
  reg         exe_reg_uops_1_taken;	// register-read.scala:70:29
  reg  [19:0] exe_reg_uops_1_imm_packed;	// register-read.scala:70:29
  reg  [11:0] exe_reg_uops_1_csr_addr;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_1_rob_idx;	// register-read.scala:70:29
  reg  [4:0]  exe_reg_uops_1_ldq_idx;	// register-read.scala:70:29
  reg  [4:0]  exe_reg_uops_1_stq_idx;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_1_rxq_idx;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_1_pdst;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_1_prs1;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_1_prs2;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_1_prs3;	// register-read.scala:70:29
  reg  [5:0]  exe_reg_uops_1_ppred;	// register-read.scala:70:29
  reg         exe_reg_uops_1_prs1_busy;	// register-read.scala:70:29
  reg         exe_reg_uops_1_prs2_busy;	// register-read.scala:70:29
  reg         exe_reg_uops_1_prs3_busy;	// register-read.scala:70:29
  reg         exe_reg_uops_1_ppred_busy;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_1_stale_pdst;	// register-read.scala:70:29
  reg         exe_reg_uops_1_exception;	// register-read.scala:70:29
  reg  [63:0] exe_reg_uops_1_exc_cause;	// register-read.scala:70:29
  reg         exe_reg_uops_1_bypassable;	// register-read.scala:70:29
  reg  [4:0]  exe_reg_uops_1_mem_cmd;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_1_mem_size;	// register-read.scala:70:29
  reg         exe_reg_uops_1_mem_signed;	// register-read.scala:70:29
  reg         exe_reg_uops_1_is_fence;	// register-read.scala:70:29
  reg         exe_reg_uops_1_is_fencei;	// register-read.scala:70:29
  reg         exe_reg_uops_1_is_amo;	// register-read.scala:70:29
  reg         exe_reg_uops_1_uses_ldq;	// register-read.scala:70:29
  reg         exe_reg_uops_1_uses_stq;	// register-read.scala:70:29
  reg         exe_reg_uops_1_is_sys_pc2epc;	// register-read.scala:70:29
  reg         exe_reg_uops_1_is_unique;	// register-read.scala:70:29
  reg         exe_reg_uops_1_flush_on_commit;	// register-read.scala:70:29
  reg         exe_reg_uops_1_ldst_is_rs1;	// register-read.scala:70:29
  reg  [5:0]  exe_reg_uops_1_ldst;	// register-read.scala:70:29
  reg  [5:0]  exe_reg_uops_1_lrs1;	// register-read.scala:70:29
  reg  [5:0]  exe_reg_uops_1_lrs2;	// register-read.scala:70:29
  reg  [5:0]  exe_reg_uops_1_lrs3;	// register-read.scala:70:29
  reg         exe_reg_uops_1_ldst_val;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_1_dst_rtype;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_1_lrs1_rtype;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_1_lrs2_rtype;	// register-read.scala:70:29
  reg         exe_reg_uops_1_frs3_en;	// register-read.scala:70:29
  reg         exe_reg_uops_1_fp_val;	// register-read.scala:70:29
  reg         exe_reg_uops_1_fp_single;	// register-read.scala:70:29
  reg         exe_reg_uops_1_xcpt_pf_if;	// register-read.scala:70:29
  reg         exe_reg_uops_1_xcpt_ae_if;	// register-read.scala:70:29
  reg         exe_reg_uops_1_xcpt_ma_if;	// register-read.scala:70:29
  reg         exe_reg_uops_1_bp_debug_if;	// register-read.scala:70:29
  reg         exe_reg_uops_1_bp_xcpt_if;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_1_debug_fsrc;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_1_debug_tsrc;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_2_uopc;	// register-read.scala:70:29
  reg  [31:0] exe_reg_uops_2_inst;	// register-read.scala:70:29
  reg  [31:0] exe_reg_uops_2_debug_inst;	// register-read.scala:70:29
  reg         exe_reg_uops_2_is_rvc;	// register-read.scala:70:29
  reg  [39:0] exe_reg_uops_2_debug_pc;	// register-read.scala:70:29
  reg  [2:0]  exe_reg_uops_2_iq_type;	// register-read.scala:70:29
  reg  [9:0]  exe_reg_uops_2_fu_code;	// register-read.scala:70:29
  reg  [3:0]  exe_reg_uops_2_ctrl_br_type;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_2_ctrl_op1_sel;	// register-read.scala:70:29
  reg  [2:0]  exe_reg_uops_2_ctrl_op2_sel;	// register-read.scala:70:29
  reg  [2:0]  exe_reg_uops_2_ctrl_imm_sel;	// register-read.scala:70:29
  reg  [3:0]  exe_reg_uops_2_ctrl_op_fcn;	// register-read.scala:70:29
  reg         exe_reg_uops_2_ctrl_fcn_dw;	// register-read.scala:70:29
  reg         exe_reg_uops_2_ctrl_is_load;	// register-read.scala:70:29
  reg         exe_reg_uops_2_ctrl_is_sta;	// register-read.scala:70:29
  reg         exe_reg_uops_2_ctrl_is_std;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_2_iw_state;	// register-read.scala:70:29
  reg         exe_reg_uops_2_is_br;	// register-read.scala:70:29
  reg         exe_reg_uops_2_is_jalr;	// register-read.scala:70:29
  reg         exe_reg_uops_2_is_jal;	// register-read.scala:70:29
  reg         exe_reg_uops_2_is_sfb;	// register-read.scala:70:29
  reg  [19:0] exe_reg_uops_2_br_mask;	// register-read.scala:70:29
  reg  [4:0]  exe_reg_uops_2_br_tag;	// register-read.scala:70:29
  reg  [5:0]  exe_reg_uops_2_ftq_idx;	// register-read.scala:70:29
  reg         exe_reg_uops_2_edge_inst;	// register-read.scala:70:29
  reg  [5:0]  exe_reg_uops_2_pc_lob;	// register-read.scala:70:29
  reg         exe_reg_uops_2_taken;	// register-read.scala:70:29
  reg  [19:0] exe_reg_uops_2_imm_packed;	// register-read.scala:70:29
  reg  [11:0] exe_reg_uops_2_csr_addr;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_2_rob_idx;	// register-read.scala:70:29
  reg  [4:0]  exe_reg_uops_2_ldq_idx;	// register-read.scala:70:29
  reg  [4:0]  exe_reg_uops_2_stq_idx;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_2_rxq_idx;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_2_pdst;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_2_prs1;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_2_prs2;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_2_prs3;	// register-read.scala:70:29
  reg  [5:0]  exe_reg_uops_2_ppred;	// register-read.scala:70:29
  reg         exe_reg_uops_2_prs1_busy;	// register-read.scala:70:29
  reg         exe_reg_uops_2_prs2_busy;	// register-read.scala:70:29
  reg         exe_reg_uops_2_prs3_busy;	// register-read.scala:70:29
  reg         exe_reg_uops_2_ppred_busy;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_2_stale_pdst;	// register-read.scala:70:29
  reg         exe_reg_uops_2_exception;	// register-read.scala:70:29
  reg  [63:0] exe_reg_uops_2_exc_cause;	// register-read.scala:70:29
  reg         exe_reg_uops_2_bypassable;	// register-read.scala:70:29
  reg  [4:0]  exe_reg_uops_2_mem_cmd;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_2_mem_size;	// register-read.scala:70:29
  reg         exe_reg_uops_2_mem_signed;	// register-read.scala:70:29
  reg         exe_reg_uops_2_is_fence;	// register-read.scala:70:29
  reg         exe_reg_uops_2_is_fencei;	// register-read.scala:70:29
  reg         exe_reg_uops_2_is_amo;	// register-read.scala:70:29
  reg         exe_reg_uops_2_uses_ldq;	// register-read.scala:70:29
  reg         exe_reg_uops_2_uses_stq;	// register-read.scala:70:29
  reg         exe_reg_uops_2_is_sys_pc2epc;	// register-read.scala:70:29
  reg         exe_reg_uops_2_is_unique;	// register-read.scala:70:29
  reg         exe_reg_uops_2_flush_on_commit;	// register-read.scala:70:29
  reg         exe_reg_uops_2_ldst_is_rs1;	// register-read.scala:70:29
  reg  [5:0]  exe_reg_uops_2_ldst;	// register-read.scala:70:29
  reg  [5:0]  exe_reg_uops_2_lrs1;	// register-read.scala:70:29
  reg  [5:0]  exe_reg_uops_2_lrs2;	// register-read.scala:70:29
  reg  [5:0]  exe_reg_uops_2_lrs3;	// register-read.scala:70:29
  reg         exe_reg_uops_2_ldst_val;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_2_dst_rtype;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_2_lrs1_rtype;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_2_lrs2_rtype;	// register-read.scala:70:29
  reg         exe_reg_uops_2_frs3_en;	// register-read.scala:70:29
  reg         exe_reg_uops_2_fp_val;	// register-read.scala:70:29
  reg         exe_reg_uops_2_fp_single;	// register-read.scala:70:29
  reg         exe_reg_uops_2_xcpt_pf_if;	// register-read.scala:70:29
  reg         exe_reg_uops_2_xcpt_ae_if;	// register-read.scala:70:29
  reg         exe_reg_uops_2_xcpt_ma_if;	// register-read.scala:70:29
  reg         exe_reg_uops_2_bp_debug_if;	// register-read.scala:70:29
  reg         exe_reg_uops_2_bp_xcpt_if;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_2_debug_fsrc;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_2_debug_tsrc;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_3_uopc;	// register-read.scala:70:29
  reg         exe_reg_uops_3_is_rvc;	// register-read.scala:70:29
  reg  [9:0]  exe_reg_uops_3_fu_code;	// register-read.scala:70:29
  reg  [3:0]  exe_reg_uops_3_ctrl_br_type;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_3_ctrl_op1_sel;	// register-read.scala:70:29
  reg  [2:0]  exe_reg_uops_3_ctrl_op2_sel;	// register-read.scala:70:29
  reg  [2:0]  exe_reg_uops_3_ctrl_imm_sel;	// register-read.scala:70:29
  reg  [3:0]  exe_reg_uops_3_ctrl_op_fcn;	// register-read.scala:70:29
  reg         exe_reg_uops_3_ctrl_fcn_dw;	// register-read.scala:70:29
  reg  [2:0]  exe_reg_uops_3_ctrl_csr_cmd;	// register-read.scala:70:29
  reg         exe_reg_uops_3_is_br;	// register-read.scala:70:29
  reg         exe_reg_uops_3_is_jalr;	// register-read.scala:70:29
  reg         exe_reg_uops_3_is_jal;	// register-read.scala:70:29
  reg         exe_reg_uops_3_is_sfb;	// register-read.scala:70:29
  reg  [19:0] exe_reg_uops_3_br_mask;	// register-read.scala:70:29
  reg  [4:0]  exe_reg_uops_3_br_tag;	// register-read.scala:70:29
  reg  [5:0]  exe_reg_uops_3_ftq_idx;	// register-read.scala:70:29
  reg         exe_reg_uops_3_edge_inst;	// register-read.scala:70:29
  reg  [5:0]  exe_reg_uops_3_pc_lob;	// register-read.scala:70:29
  reg         exe_reg_uops_3_taken;	// register-read.scala:70:29
  reg  [19:0] exe_reg_uops_3_imm_packed;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_3_rob_idx;	// register-read.scala:70:29
  reg  [4:0]  exe_reg_uops_3_ldq_idx;	// register-read.scala:70:29
  reg  [4:0]  exe_reg_uops_3_stq_idx;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_3_pdst;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_3_prs1;	// register-read.scala:70:29
  reg         exe_reg_uops_3_bypassable;	// register-read.scala:70:29
  reg         exe_reg_uops_3_is_amo;	// register-read.scala:70:29
  reg         exe_reg_uops_3_uses_stq;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_3_dst_rtype;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_4_uopc;	// register-read.scala:70:29
  reg         exe_reg_uops_4_is_rvc;	// register-read.scala:70:29
  reg  [9:0]  exe_reg_uops_4_fu_code;	// register-read.scala:70:29
  reg  [3:0]  exe_reg_uops_4_ctrl_br_type;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_4_ctrl_op1_sel;	// register-read.scala:70:29
  reg  [2:0]  exe_reg_uops_4_ctrl_op2_sel;	// register-read.scala:70:29
  reg  [2:0]  exe_reg_uops_4_ctrl_imm_sel;	// register-read.scala:70:29
  reg  [3:0]  exe_reg_uops_4_ctrl_op_fcn;	// register-read.scala:70:29
  reg         exe_reg_uops_4_ctrl_fcn_dw;	// register-read.scala:70:29
  reg         exe_reg_uops_4_is_br;	// register-read.scala:70:29
  reg         exe_reg_uops_4_is_jalr;	// register-read.scala:70:29
  reg         exe_reg_uops_4_is_jal;	// register-read.scala:70:29
  reg         exe_reg_uops_4_is_sfb;	// register-read.scala:70:29
  reg  [19:0] exe_reg_uops_4_br_mask;	// register-read.scala:70:29
  reg  [4:0]  exe_reg_uops_4_br_tag;	// register-read.scala:70:29
  reg  [5:0]  exe_reg_uops_4_ftq_idx;	// register-read.scala:70:29
  reg         exe_reg_uops_4_edge_inst;	// register-read.scala:70:29
  reg  [5:0]  exe_reg_uops_4_pc_lob;	// register-read.scala:70:29
  reg         exe_reg_uops_4_taken;	// register-read.scala:70:29
  reg  [19:0] exe_reg_uops_4_imm_packed;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_4_rob_idx;	// register-read.scala:70:29
  reg  [4:0]  exe_reg_uops_4_ldq_idx;	// register-read.scala:70:29
  reg  [4:0]  exe_reg_uops_4_stq_idx;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_4_pdst;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_4_prs1;	// register-read.scala:70:29
  reg         exe_reg_uops_4_bypassable;	// register-read.scala:70:29
  reg         exe_reg_uops_4_is_amo;	// register-read.scala:70:29
  reg         exe_reg_uops_4_uses_stq;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_4_dst_rtype;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_5_uopc;	// register-read.scala:70:29
  reg         exe_reg_uops_5_is_rvc;	// register-read.scala:70:29
  reg  [9:0]  exe_reg_uops_5_fu_code;	// register-read.scala:70:29
  reg  [3:0]  exe_reg_uops_5_ctrl_br_type;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_5_ctrl_op1_sel;	// register-read.scala:70:29
  reg  [2:0]  exe_reg_uops_5_ctrl_op2_sel;	// register-read.scala:70:29
  reg  [2:0]  exe_reg_uops_5_ctrl_imm_sel;	// register-read.scala:70:29
  reg  [3:0]  exe_reg_uops_5_ctrl_op_fcn;	// register-read.scala:70:29
  reg         exe_reg_uops_5_ctrl_fcn_dw;	// register-read.scala:70:29
  reg         exe_reg_uops_5_is_br;	// register-read.scala:70:29
  reg         exe_reg_uops_5_is_jalr;	// register-read.scala:70:29
  reg         exe_reg_uops_5_is_jal;	// register-read.scala:70:29
  reg         exe_reg_uops_5_is_sfb;	// register-read.scala:70:29
  reg  [19:0] exe_reg_uops_5_br_mask;	// register-read.scala:70:29
  reg  [4:0]  exe_reg_uops_5_br_tag;	// register-read.scala:70:29
  reg  [5:0]  exe_reg_uops_5_ftq_idx;	// register-read.scala:70:29
  reg         exe_reg_uops_5_edge_inst;	// register-read.scala:70:29
  reg  [5:0]  exe_reg_uops_5_pc_lob;	// register-read.scala:70:29
  reg         exe_reg_uops_5_taken;	// register-read.scala:70:29
  reg  [19:0] exe_reg_uops_5_imm_packed;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_5_rob_idx;	// register-read.scala:70:29
  reg  [4:0]  exe_reg_uops_5_ldq_idx;	// register-read.scala:70:29
  reg  [4:0]  exe_reg_uops_5_stq_idx;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_5_pdst;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_5_prs1;	// register-read.scala:70:29
  reg         exe_reg_uops_5_bypassable;	// register-read.scala:70:29
  reg         exe_reg_uops_5_is_amo;	// register-read.scala:70:29
  reg         exe_reg_uops_5_uses_stq;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_5_dst_rtype;	// register-read.scala:70:29
  reg  [63:0] exe_reg_rs1_data_0;	// register-read.scala:71:29
  reg  [63:0] exe_reg_rs1_data_1;	// register-read.scala:71:29
  reg  [63:0] exe_reg_rs1_data_2;	// register-read.scala:71:29
  reg  [63:0] exe_reg_rs1_data_3;	// register-read.scala:71:29
  reg  [63:0] exe_reg_rs1_data_4;	// register-read.scala:71:29
  reg  [63:0] exe_reg_rs1_data_5;	// register-read.scala:71:29
  reg  [63:0] exe_reg_rs2_data_0;	// register-read.scala:72:29
  reg  [63:0] exe_reg_rs2_data_1;	// register-read.scala:72:29
  reg  [63:0] exe_reg_rs2_data_2;	// register-read.scala:72:29
  reg  [63:0] exe_reg_rs2_data_3;	// register-read.scala:72:29
  reg  [63:0] exe_reg_rs2_data_4;	// register-read.scala:72:29
  reg  [63:0] exe_reg_rs2_data_5;	// register-read.scala:72:29
  reg         rrd_valids_0_REG;	// register-read.scala:84:29
  reg  [6:0]  rrd_uops_0_REG_uopc;	// register-read.scala:86:29
  reg  [31:0] rrd_uops_0_REG_inst;	// register-read.scala:86:29
  reg  [31:0] rrd_uops_0_REG_debug_inst;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_is_rvc;	// register-read.scala:86:29
  reg  [39:0] rrd_uops_0_REG_debug_pc;	// register-read.scala:86:29
  reg  [2:0]  rrd_uops_0_REG_iq_type;	// register-read.scala:86:29
  reg  [9:0]  rrd_uops_0_REG_fu_code;	// register-read.scala:86:29
  reg  [3:0]  rrd_uops_0_REG_ctrl_br_type;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_0_REG_ctrl_op1_sel;	// register-read.scala:86:29
  reg  [2:0]  rrd_uops_0_REG_ctrl_op2_sel;	// register-read.scala:86:29
  reg  [2:0]  rrd_uops_0_REG_ctrl_imm_sel;	// register-read.scala:86:29
  reg  [3:0]  rrd_uops_0_REG_ctrl_op_fcn;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_ctrl_fcn_dw;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_ctrl_is_load;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_ctrl_is_sta;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_ctrl_is_std;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_0_REG_iw_state;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_is_br;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_is_jalr;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_is_jal;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_is_sfb;	// register-read.scala:86:29
  reg  [19:0] rrd_uops_0_REG_br_mask;	// register-read.scala:86:29
  reg  [4:0]  rrd_uops_0_REG_br_tag;	// register-read.scala:86:29
  reg  [5:0]  rrd_uops_0_REG_ftq_idx;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_edge_inst;	// register-read.scala:86:29
  reg  [5:0]  rrd_uops_0_REG_pc_lob;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_taken;	// register-read.scala:86:29
  reg  [19:0] rrd_uops_0_REG_imm_packed;	// register-read.scala:86:29
  reg  [11:0] rrd_uops_0_REG_csr_addr;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_0_REG_rob_idx;	// register-read.scala:86:29
  reg  [4:0]  rrd_uops_0_REG_ldq_idx;	// register-read.scala:86:29
  reg  [4:0]  rrd_uops_0_REG_stq_idx;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_0_REG_rxq_idx;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_0_REG_pdst;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_0_REG_prs1;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_0_REG_prs2;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_0_REG_prs3;	// register-read.scala:86:29
  reg  [5:0]  rrd_uops_0_REG_ppred;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_prs1_busy;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_prs2_busy;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_prs3_busy;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_ppred_busy;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_0_REG_stale_pdst;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_exception;	// register-read.scala:86:29
  reg  [63:0] rrd_uops_0_REG_exc_cause;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_bypassable;	// register-read.scala:86:29
  reg  [4:0]  rrd_uops_0_REG_mem_cmd;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_0_REG_mem_size;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_mem_signed;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_is_fence;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_is_fencei;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_is_amo;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_uses_ldq;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_uses_stq;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_is_sys_pc2epc;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_is_unique;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_flush_on_commit;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_ldst_is_rs1;	// register-read.scala:86:29
  reg  [5:0]  rrd_uops_0_REG_ldst;	// register-read.scala:86:29
  reg  [5:0]  rrd_uops_0_REG_lrs1;	// register-read.scala:86:29
  reg  [5:0]  rrd_uops_0_REG_lrs2;	// register-read.scala:86:29
  reg  [5:0]  rrd_uops_0_REG_lrs3;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_ldst_val;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_0_REG_dst_rtype;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_0_REG_lrs1_rtype;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_0_REG_lrs2_rtype;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_frs3_en;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_fp_val;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_fp_single;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_xcpt_pf_if;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_xcpt_ae_if;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_xcpt_ma_if;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_bp_debug_if;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_bp_xcpt_if;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_0_REG_debug_fsrc;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_0_REG_debug_tsrc;	// register-read.scala:86:29
  reg         rrd_valids_1_REG;	// register-read.scala:84:29
  reg  [6:0]  rrd_uops_1_REG_uopc;	// register-read.scala:86:29
  reg  [31:0] rrd_uops_1_REG_inst;	// register-read.scala:86:29
  reg  [31:0] rrd_uops_1_REG_debug_inst;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_is_rvc;	// register-read.scala:86:29
  reg  [39:0] rrd_uops_1_REG_debug_pc;	// register-read.scala:86:29
  reg  [2:0]  rrd_uops_1_REG_iq_type;	// register-read.scala:86:29
  reg  [9:0]  rrd_uops_1_REG_fu_code;	// register-read.scala:86:29
  reg  [3:0]  rrd_uops_1_REG_ctrl_br_type;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_1_REG_ctrl_op1_sel;	// register-read.scala:86:29
  reg  [2:0]  rrd_uops_1_REG_ctrl_op2_sel;	// register-read.scala:86:29
  reg  [2:0]  rrd_uops_1_REG_ctrl_imm_sel;	// register-read.scala:86:29
  reg  [3:0]  rrd_uops_1_REG_ctrl_op_fcn;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_ctrl_fcn_dw;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_ctrl_is_load;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_ctrl_is_sta;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_ctrl_is_std;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_1_REG_iw_state;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_is_br;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_is_jalr;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_is_jal;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_is_sfb;	// register-read.scala:86:29
  reg  [19:0] rrd_uops_1_REG_br_mask;	// register-read.scala:86:29
  reg  [4:0]  rrd_uops_1_REG_br_tag;	// register-read.scala:86:29
  reg  [5:0]  rrd_uops_1_REG_ftq_idx;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_edge_inst;	// register-read.scala:86:29
  reg  [5:0]  rrd_uops_1_REG_pc_lob;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_taken;	// register-read.scala:86:29
  reg  [19:0] rrd_uops_1_REG_imm_packed;	// register-read.scala:86:29
  reg  [11:0] rrd_uops_1_REG_csr_addr;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_1_REG_rob_idx;	// register-read.scala:86:29
  reg  [4:0]  rrd_uops_1_REG_ldq_idx;	// register-read.scala:86:29
  reg  [4:0]  rrd_uops_1_REG_stq_idx;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_1_REG_rxq_idx;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_1_REG_pdst;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_1_REG_prs1;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_1_REG_prs2;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_1_REG_prs3;	// register-read.scala:86:29
  reg  [5:0]  rrd_uops_1_REG_ppred;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_prs1_busy;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_prs2_busy;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_prs3_busy;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_ppred_busy;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_1_REG_stale_pdst;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_exception;	// register-read.scala:86:29
  reg  [63:0] rrd_uops_1_REG_exc_cause;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_bypassable;	// register-read.scala:86:29
  reg  [4:0]  rrd_uops_1_REG_mem_cmd;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_1_REG_mem_size;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_mem_signed;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_is_fence;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_is_fencei;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_is_amo;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_uses_ldq;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_uses_stq;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_is_sys_pc2epc;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_is_unique;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_flush_on_commit;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_ldst_is_rs1;	// register-read.scala:86:29
  reg  [5:0]  rrd_uops_1_REG_ldst;	// register-read.scala:86:29
  reg  [5:0]  rrd_uops_1_REG_lrs1;	// register-read.scala:86:29
  reg  [5:0]  rrd_uops_1_REG_lrs2;	// register-read.scala:86:29
  reg  [5:0]  rrd_uops_1_REG_lrs3;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_ldst_val;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_1_REG_dst_rtype;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_1_REG_lrs1_rtype;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_1_REG_lrs2_rtype;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_frs3_en;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_fp_val;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_fp_single;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_xcpt_pf_if;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_xcpt_ae_if;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_xcpt_ma_if;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_bp_debug_if;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_bp_xcpt_if;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_1_REG_debug_fsrc;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_1_REG_debug_tsrc;	// register-read.scala:86:29
  reg         rrd_valids_2_REG;	// register-read.scala:84:29
  reg  [6:0]  rrd_uops_2_REG_uopc;	// register-read.scala:86:29
  reg  [31:0] rrd_uops_2_REG_inst;	// register-read.scala:86:29
  reg  [31:0] rrd_uops_2_REG_debug_inst;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_is_rvc;	// register-read.scala:86:29
  reg  [39:0] rrd_uops_2_REG_debug_pc;	// register-read.scala:86:29
  reg  [2:0]  rrd_uops_2_REG_iq_type;	// register-read.scala:86:29
  reg  [9:0]  rrd_uops_2_REG_fu_code;	// register-read.scala:86:29
  reg  [3:0]  rrd_uops_2_REG_ctrl_br_type;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_2_REG_ctrl_op1_sel;	// register-read.scala:86:29
  reg  [2:0]  rrd_uops_2_REG_ctrl_op2_sel;	// register-read.scala:86:29
  reg  [2:0]  rrd_uops_2_REG_ctrl_imm_sel;	// register-read.scala:86:29
  reg  [3:0]  rrd_uops_2_REG_ctrl_op_fcn;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_ctrl_fcn_dw;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_ctrl_is_load;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_ctrl_is_sta;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_ctrl_is_std;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_2_REG_iw_state;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_is_br;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_is_jalr;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_is_jal;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_is_sfb;	// register-read.scala:86:29
  reg  [19:0] rrd_uops_2_REG_br_mask;	// register-read.scala:86:29
  reg  [4:0]  rrd_uops_2_REG_br_tag;	// register-read.scala:86:29
  reg  [5:0]  rrd_uops_2_REG_ftq_idx;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_edge_inst;	// register-read.scala:86:29
  reg  [5:0]  rrd_uops_2_REG_pc_lob;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_taken;	// register-read.scala:86:29
  reg  [19:0] rrd_uops_2_REG_imm_packed;	// register-read.scala:86:29
  reg  [11:0] rrd_uops_2_REG_csr_addr;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_2_REG_rob_idx;	// register-read.scala:86:29
  reg  [4:0]  rrd_uops_2_REG_ldq_idx;	// register-read.scala:86:29
  reg  [4:0]  rrd_uops_2_REG_stq_idx;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_2_REG_rxq_idx;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_2_REG_pdst;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_2_REG_prs1;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_2_REG_prs2;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_2_REG_prs3;	// register-read.scala:86:29
  reg  [5:0]  rrd_uops_2_REG_ppred;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_prs1_busy;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_prs2_busy;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_prs3_busy;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_ppred_busy;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_2_REG_stale_pdst;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_exception;	// register-read.scala:86:29
  reg  [63:0] rrd_uops_2_REG_exc_cause;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_bypassable;	// register-read.scala:86:29
  reg  [4:0]  rrd_uops_2_REG_mem_cmd;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_2_REG_mem_size;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_mem_signed;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_is_fence;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_is_fencei;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_is_amo;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_uses_ldq;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_uses_stq;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_is_sys_pc2epc;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_is_unique;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_flush_on_commit;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_ldst_is_rs1;	// register-read.scala:86:29
  reg  [5:0]  rrd_uops_2_REG_ldst;	// register-read.scala:86:29
  reg  [5:0]  rrd_uops_2_REG_lrs1;	// register-read.scala:86:29
  reg  [5:0]  rrd_uops_2_REG_lrs2;	// register-read.scala:86:29
  reg  [5:0]  rrd_uops_2_REG_lrs3;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_ldst_val;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_2_REG_dst_rtype;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_2_REG_lrs1_rtype;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_2_REG_lrs2_rtype;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_frs3_en;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_fp_val;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_fp_single;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_xcpt_pf_if;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_xcpt_ae_if;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_xcpt_ma_if;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_bp_debug_if;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_bp_xcpt_if;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_2_REG_debug_fsrc;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_2_REG_debug_tsrc;	// register-read.scala:86:29
  reg         rrd_valids_3_REG;	// register-read.scala:84:29
  reg  [6:0]  rrd_uops_3_REG_uopc;	// register-read.scala:86:29
  reg         rrd_uops_3_REG_is_rvc;	// register-read.scala:86:29
  reg  [9:0]  rrd_uops_3_REG_fu_code;	// register-read.scala:86:29
  reg  [3:0]  rrd_uops_3_REG_ctrl_br_type;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_3_REG_ctrl_op1_sel;	// register-read.scala:86:29
  reg  [2:0]  rrd_uops_3_REG_ctrl_op2_sel;	// register-read.scala:86:29
  reg  [2:0]  rrd_uops_3_REG_ctrl_imm_sel;	// register-read.scala:86:29
  reg  [3:0]  rrd_uops_3_REG_ctrl_op_fcn;	// register-read.scala:86:29
  reg         rrd_uops_3_REG_ctrl_fcn_dw;	// register-read.scala:86:29
  reg  [2:0]  rrd_uops_3_REG_ctrl_csr_cmd;	// register-read.scala:86:29
  reg         rrd_uops_3_REG_is_br;	// register-read.scala:86:29
  reg         rrd_uops_3_REG_is_jalr;	// register-read.scala:86:29
  reg         rrd_uops_3_REG_is_jal;	// register-read.scala:86:29
  reg         rrd_uops_3_REG_is_sfb;	// register-read.scala:86:29
  reg  [19:0] rrd_uops_3_REG_br_mask;	// register-read.scala:86:29
  reg  [4:0]  rrd_uops_3_REG_br_tag;	// register-read.scala:86:29
  reg  [5:0]  rrd_uops_3_REG_ftq_idx;	// register-read.scala:86:29
  reg         rrd_uops_3_REG_edge_inst;	// register-read.scala:86:29
  reg  [5:0]  rrd_uops_3_REG_pc_lob;	// register-read.scala:86:29
  reg         rrd_uops_3_REG_taken;	// register-read.scala:86:29
  reg  [19:0] rrd_uops_3_REG_imm_packed;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_3_REG_rob_idx;	// register-read.scala:86:29
  reg  [4:0]  rrd_uops_3_REG_ldq_idx;	// register-read.scala:86:29
  reg  [4:0]  rrd_uops_3_REG_stq_idx;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_3_REG_pdst;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_3_REG_prs1;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_3_REG_prs2;	// register-read.scala:86:29
  reg         rrd_uops_3_REG_bypassable;	// register-read.scala:86:29
  reg         rrd_uops_3_REG_is_amo;	// register-read.scala:86:29
  reg         rrd_uops_3_REG_uses_stq;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_3_REG_dst_rtype;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_3_REG_lrs1_rtype;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_3_REG_lrs2_rtype;	// register-read.scala:86:29
  reg         rrd_valids_4_REG;	// register-read.scala:84:29
  reg  [6:0]  rrd_uops_4_REG_uopc;	// register-read.scala:86:29
  reg         rrd_uops_4_REG_is_rvc;	// register-read.scala:86:29
  reg  [9:0]  rrd_uops_4_REG_fu_code;	// register-read.scala:86:29
  reg  [3:0]  rrd_uops_4_REG_ctrl_br_type;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_4_REG_ctrl_op1_sel;	// register-read.scala:86:29
  reg  [2:0]  rrd_uops_4_REG_ctrl_op2_sel;	// register-read.scala:86:29
  reg  [2:0]  rrd_uops_4_REG_ctrl_imm_sel;	// register-read.scala:86:29
  reg  [3:0]  rrd_uops_4_REG_ctrl_op_fcn;	// register-read.scala:86:29
  reg         rrd_uops_4_REG_ctrl_fcn_dw;	// register-read.scala:86:29
  reg         rrd_uops_4_REG_is_br;	// register-read.scala:86:29
  reg         rrd_uops_4_REG_is_jalr;	// register-read.scala:86:29
  reg         rrd_uops_4_REG_is_jal;	// register-read.scala:86:29
  reg         rrd_uops_4_REG_is_sfb;	// register-read.scala:86:29
  reg  [19:0] rrd_uops_4_REG_br_mask;	// register-read.scala:86:29
  reg  [4:0]  rrd_uops_4_REG_br_tag;	// register-read.scala:86:29
  reg  [5:0]  rrd_uops_4_REG_ftq_idx;	// register-read.scala:86:29
  reg         rrd_uops_4_REG_edge_inst;	// register-read.scala:86:29
  reg  [5:0]  rrd_uops_4_REG_pc_lob;	// register-read.scala:86:29
  reg         rrd_uops_4_REG_taken;	// register-read.scala:86:29
  reg  [19:0] rrd_uops_4_REG_imm_packed;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_4_REG_rob_idx;	// register-read.scala:86:29
  reg  [4:0]  rrd_uops_4_REG_ldq_idx;	// register-read.scala:86:29
  reg  [4:0]  rrd_uops_4_REG_stq_idx;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_4_REG_pdst;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_4_REG_prs1;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_4_REG_prs2;	// register-read.scala:86:29
  reg         rrd_uops_4_REG_bypassable;	// register-read.scala:86:29
  reg         rrd_uops_4_REG_is_amo;	// register-read.scala:86:29
  reg         rrd_uops_4_REG_uses_stq;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_4_REG_dst_rtype;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_4_REG_lrs1_rtype;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_4_REG_lrs2_rtype;	// register-read.scala:86:29
  reg         rrd_valids_5_REG;	// register-read.scala:84:29
  reg  [6:0]  rrd_uops_5_REG_uopc;	// register-read.scala:86:29
  reg         rrd_uops_5_REG_is_rvc;	// register-read.scala:86:29
  reg  [9:0]  rrd_uops_5_REG_fu_code;	// register-read.scala:86:29
  reg  [3:0]  rrd_uops_5_REG_ctrl_br_type;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_5_REG_ctrl_op1_sel;	// register-read.scala:86:29
  reg  [2:0]  rrd_uops_5_REG_ctrl_op2_sel;	// register-read.scala:86:29
  reg  [2:0]  rrd_uops_5_REG_ctrl_imm_sel;	// register-read.scala:86:29
  reg  [3:0]  rrd_uops_5_REG_ctrl_op_fcn;	// register-read.scala:86:29
  reg         rrd_uops_5_REG_ctrl_fcn_dw;	// register-read.scala:86:29
  reg         rrd_uops_5_REG_is_br;	// register-read.scala:86:29
  reg         rrd_uops_5_REG_is_jalr;	// register-read.scala:86:29
  reg         rrd_uops_5_REG_is_jal;	// register-read.scala:86:29
  reg         rrd_uops_5_REG_is_sfb;	// register-read.scala:86:29
  reg  [19:0] rrd_uops_5_REG_br_mask;	// register-read.scala:86:29
  reg  [4:0]  rrd_uops_5_REG_br_tag;	// register-read.scala:86:29
  reg  [5:0]  rrd_uops_5_REG_ftq_idx;	// register-read.scala:86:29
  reg         rrd_uops_5_REG_edge_inst;	// register-read.scala:86:29
  reg  [5:0]  rrd_uops_5_REG_pc_lob;	// register-read.scala:86:29
  reg         rrd_uops_5_REG_taken;	// register-read.scala:86:29
  reg  [19:0] rrd_uops_5_REG_imm_packed;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_5_REG_rob_idx;	// register-read.scala:86:29
  reg  [4:0]  rrd_uops_5_REG_ldq_idx;	// register-read.scala:86:29
  reg  [4:0]  rrd_uops_5_REG_stq_idx;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_5_REG_pdst;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_5_REG_prs1;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_5_REG_prs2;	// register-read.scala:86:29
  reg         rrd_uops_5_REG_bypassable;	// register-read.scala:86:29
  reg         rrd_uops_5_REG_is_amo;	// register-read.scala:86:29
  reg         rrd_uops_5_REG_uses_stq;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_5_REG_dst_rtype;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_5_REG_lrs1_rtype;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_5_REG_lrs2_rtype;	// register-read.scala:86:29
  reg         rrd_rs1_data_0_REG;	// register-read.scala:124:57
  reg         rrd_rs2_data_0_REG;	// register-read.scala:125:57
  reg         rrd_rs1_data_1_REG;	// register-read.scala:124:57
  reg         rrd_rs2_data_1_REG;	// register-read.scala:125:57
  reg         rrd_rs1_data_2_REG;	// register-read.scala:124:57
  reg         rrd_rs2_data_2_REG;	// register-read.scala:125:57
  reg         rrd_rs1_data_3_REG;	// register-read.scala:124:57
  reg         rrd_rs2_data_3_REG;	// register-read.scala:125:57
  reg         rrd_rs1_data_4_REG;	// register-read.scala:124:57
  reg         rrd_rs2_data_4_REG;	// register-read.scala:125:57
  reg         rrd_rs1_data_5_REG;	// register-read.scala:124:57
  reg         rrd_rs2_data_5_REG;	// register-read.scala:125:57
  always @(posedge clock) begin
    automatic logic rrd_kill;	// register-read.scala:130:28
    automatic logic rrd_kill_1;	// register-read.scala:130:28
    automatic logic rrd_kill_2;	// register-read.scala:130:28
    automatic logic rrd_kill_3;	// register-read.scala:130:28
    automatic logic rrd_kill_4;	// register-read.scala:130:28
    automatic logic rrd_kill_5;	// register-read.scala:130:28
    automatic logic _GEN = io_bypass_0_bits_uop_dst_rtype != 2'h2;	// consts.scala:277:20, micro-op.scala:149:36
    automatic logic _GEN_0 = io_bypass_0_bits_uop_dst_rtype == 2'h0;	// consts.scala:270:20, register-read.scala:174:38
    automatic logic _GEN_1;	// register-read.scala:174:63
    automatic logic _GEN_2;	// register-read.scala:176:63
    automatic logic _GEN_3;	// micro-op.scala:149:36
    automatic logic _GEN_4;	// register-read.scala:174:38
    automatic logic _GEN_5;	// micro-op.scala:149:36
    automatic logic _GEN_6;	// register-read.scala:174:38
    automatic logic _GEN_7;	// micro-op.scala:149:36
    automatic logic _GEN_8;	// register-read.scala:174:38
    automatic logic _GEN_9;	// micro-op.scala:149:36
    automatic logic _GEN_10;	// register-read.scala:174:38
    automatic logic _GEN_11;	// micro-op.scala:149:36
    automatic logic _GEN_12;	// register-read.scala:174:38
    automatic logic _GEN_13;	// register-read.scala:174:63
    automatic logic _GEN_14;	// register-read.scala:176:63
    automatic logic _GEN_15;	// register-read.scala:174:63
    automatic logic _GEN_16;	// register-read.scala:176:63
    automatic logic _GEN_17;	// register-read.scala:174:63
    automatic logic _GEN_18;	// register-read.scala:176:63
    automatic logic _GEN_19;	// register-read.scala:174:63
    automatic logic _GEN_20;	// register-read.scala:176:63
    automatic logic _GEN_21;	// register-read.scala:174:63
    automatic logic _GEN_22;	// register-read.scala:176:63
    rrd_kill = io_kill | (|(io_brupdate_b1_mispredict_mask & rrd_uops_0_REG_br_mask));	// register-read.scala:86:29, :130:28, util.scala:118:{51,59}
    rrd_kill_1 = io_kill | (|(io_brupdate_b1_mispredict_mask & rrd_uops_1_REG_br_mask));	// register-read.scala:86:29, :130:28, util.scala:118:{51,59}
    rrd_kill_2 = io_kill | (|(io_brupdate_b1_mispredict_mask & rrd_uops_2_REG_br_mask));	// register-read.scala:86:29, :130:28, util.scala:118:{51,59}
    rrd_kill_3 = io_kill | (|(io_brupdate_b1_mispredict_mask & rrd_uops_3_REG_br_mask));	// register-read.scala:86:29, :130:28, util.scala:118:{51,59}
    rrd_kill_4 = io_kill | (|(io_brupdate_b1_mispredict_mask & rrd_uops_4_REG_br_mask));	// register-read.scala:86:29, :130:28, util.scala:118:{51,59}
    rrd_kill_5 = io_kill | (|(io_brupdate_b1_mispredict_mask & rrd_uops_5_REG_br_mask));	// register-read.scala:86:29, :130:28, util.scala:118:{51,59}
    _GEN_1 = rrd_uops_0_REG_lrs1_rtype == 2'h0;	// consts.scala:270:20, register-read.scala:86:29, :174:63
    _GEN_2 = rrd_uops_0_REG_lrs2_rtype == 2'h0;	// consts.scala:270:20, register-read.scala:86:29, :176:63
    _GEN_3 = io_bypass_1_bits_uop_dst_rtype != 2'h2;	// consts.scala:277:20, micro-op.scala:149:36
    _GEN_4 = io_bypass_1_bits_uop_dst_rtype == 2'h0;	// consts.scala:270:20, register-read.scala:174:38
    _GEN_5 = io_bypass_2_bits_uop_dst_rtype != 2'h2;	// consts.scala:277:20, micro-op.scala:149:36
    _GEN_6 = io_bypass_2_bits_uop_dst_rtype == 2'h0;	// consts.scala:270:20, register-read.scala:174:38
    _GEN_7 = io_bypass_3_bits_uop_dst_rtype != 2'h2;	// consts.scala:277:20, micro-op.scala:149:36
    _GEN_8 = io_bypass_3_bits_uop_dst_rtype == 2'h0;	// consts.scala:270:20, register-read.scala:174:38
    _GEN_9 = io_bypass_4_bits_uop_dst_rtype != 2'h2;	// consts.scala:277:20, micro-op.scala:149:36
    _GEN_10 = io_bypass_4_bits_uop_dst_rtype == 2'h0;	// consts.scala:270:20, register-read.scala:174:38
    _GEN_11 = io_bypass_5_bits_uop_dst_rtype != 2'h2;	// consts.scala:277:20, micro-op.scala:149:36
    _GEN_12 = io_bypass_5_bits_uop_dst_rtype == 2'h0;	// consts.scala:270:20, register-read.scala:174:38
    _GEN_13 = rrd_uops_1_REG_lrs1_rtype == 2'h0;	// consts.scala:270:20, register-read.scala:86:29, :174:63
    _GEN_14 = rrd_uops_1_REG_lrs2_rtype == 2'h0;	// consts.scala:270:20, register-read.scala:86:29, :176:63
    _GEN_15 = rrd_uops_2_REG_lrs1_rtype == 2'h0;	// consts.scala:270:20, register-read.scala:86:29, :174:63
    _GEN_16 = rrd_uops_2_REG_lrs2_rtype == 2'h0;	// consts.scala:270:20, register-read.scala:86:29, :176:63
    _GEN_17 = rrd_uops_3_REG_lrs1_rtype == 2'h0;	// consts.scala:270:20, register-read.scala:86:29, :174:63
    _GEN_18 = rrd_uops_3_REG_lrs2_rtype == 2'h0;	// consts.scala:270:20, register-read.scala:86:29, :176:63
    _GEN_19 = rrd_uops_4_REG_lrs1_rtype == 2'h0;	// consts.scala:270:20, register-read.scala:86:29, :174:63
    _GEN_20 = rrd_uops_4_REG_lrs2_rtype == 2'h0;	// consts.scala:270:20, register-read.scala:86:29, :176:63
    _GEN_21 = rrd_uops_5_REG_lrs1_rtype == 2'h0;	// consts.scala:270:20, register-read.scala:86:29, :174:63
    _GEN_22 = rrd_uops_5_REG_lrs2_rtype == 2'h0;	// consts.scala:270:20, register-read.scala:86:29, :176:63
    if (reset) begin
      exe_reg_valids_0 <= 1'h0;	// register-read.scala:69:33, :80:33
      exe_reg_valids_1 <= 1'h0;	// register-read.scala:69:33, :80:33
      exe_reg_valids_2 <= 1'h0;	// register-read.scala:69:33, :80:33
      exe_reg_valids_3 <= 1'h0;	// register-read.scala:69:33, :80:33
      exe_reg_valids_4 <= 1'h0;	// register-read.scala:69:33, :80:33
      exe_reg_valids_5 <= 1'h0;	// register-read.scala:69:33, :80:33
    end
    else begin
      exe_reg_valids_0 <= ~rrd_kill & rrd_valids_0_REG;	// register-read.scala:69:33, :84:29, :130:28, :132:29
      exe_reg_valids_1 <= ~rrd_kill_1 & rrd_valids_1_REG;	// register-read.scala:69:33, :84:29, :130:28, :132:29
      exe_reg_valids_2 <= ~rrd_kill_2 & rrd_valids_2_REG;	// register-read.scala:69:33, :84:29, :130:28, :132:29
      exe_reg_valids_3 <= ~rrd_kill_3 & rrd_valids_3_REG;	// register-read.scala:69:33, :84:29, :130:28, :132:29
      exe_reg_valids_4 <= ~rrd_kill_4 & rrd_valids_4_REG;	// register-read.scala:69:33, :84:29, :130:28, :132:29
      exe_reg_valids_5 <= ~rrd_kill_5 & rrd_valids_5_REG;	// register-read.scala:69:33, :84:29, :130:28, :132:29
    end
    if (rrd_kill) begin	// register-read.scala:130:28
      exe_reg_uops_0_uopc <= 7'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_inst <= 32'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_debug_inst <= 32'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_debug_pc <= 40'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_iq_type <= 3'h0;	// register-read.scala:70:29, :80:33
      exe_reg_uops_0_fu_code <= 10'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_ctrl_br_type <= 4'h0;	// consts.scala:280:20, register-read.scala:70:29
      exe_reg_uops_0_ctrl_op1_sel <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_ctrl_op2_sel <= 3'h0;	// register-read.scala:70:29, :80:33
      exe_reg_uops_0_ctrl_imm_sel <= 3'h0;	// register-read.scala:70:29, :80:33
      exe_reg_uops_0_ctrl_op_fcn <= 4'h0;	// consts.scala:280:20, register-read.scala:70:29
      exe_reg_uops_0_iw_state <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_br_tag <= 5'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_ftq_idx <= 6'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_0_pc_lob <= 6'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_0_imm_packed <= 20'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_csr_addr <= 12'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_rob_idx <= 7'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_ldq_idx <= 5'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_stq_idx <= 5'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_rxq_idx <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_pdst <= 7'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_prs1 <= 7'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_prs2 <= 7'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_prs3 <= 7'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_ppred <= 6'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_0_stale_pdst <= 7'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_exc_cause <= 64'h0;	// register-read.scala:70:29
      exe_reg_uops_0_mem_cmd <= 5'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_mem_size <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_ldst <= 6'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_0_lrs1 <= 6'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_0_lrs2 <= 6'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_0_lrs3 <= 6'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_0_dst_rtype <= 2'h2;	// consts.scala:277:20, register-read.scala:70:29
      exe_reg_uops_0_lrs1_rtype <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_lrs2_rtype <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_debug_fsrc <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_debug_tsrc <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
    end
    else begin	// register-read.scala:130:28
      exe_reg_uops_0_uopc <= rrd_uops_0_REG_uopc;	// register-read.scala:70:29, :86:29
      exe_reg_uops_0_inst <= rrd_uops_0_REG_inst;	// register-read.scala:70:29, :86:29
      exe_reg_uops_0_debug_inst <= rrd_uops_0_REG_debug_inst;	// register-read.scala:70:29, :86:29
      exe_reg_uops_0_debug_pc <= rrd_uops_0_REG_debug_pc;	// register-read.scala:70:29, :86:29
      exe_reg_uops_0_iq_type <= rrd_uops_0_REG_iq_type;	// register-read.scala:70:29, :86:29
      exe_reg_uops_0_fu_code <= rrd_uops_0_REG_fu_code;	// register-read.scala:70:29, :86:29
      exe_reg_uops_0_ctrl_br_type <= rrd_uops_0_REG_ctrl_br_type;	// register-read.scala:70:29, :86:29
      exe_reg_uops_0_ctrl_op1_sel <= rrd_uops_0_REG_ctrl_op1_sel;	// register-read.scala:70:29, :86:29
      exe_reg_uops_0_ctrl_op2_sel <= rrd_uops_0_REG_ctrl_op2_sel;	// register-read.scala:70:29, :86:29
      exe_reg_uops_0_ctrl_imm_sel <= rrd_uops_0_REG_ctrl_imm_sel;	// register-read.scala:70:29, :86:29
      exe_reg_uops_0_ctrl_op_fcn <= rrd_uops_0_REG_ctrl_op_fcn;	// register-read.scala:70:29, :86:29
      exe_reg_uops_0_iw_state <= rrd_uops_0_REG_iw_state;	// register-read.scala:70:29, :86:29
      exe_reg_uops_0_br_tag <= rrd_uops_0_REG_br_tag;	// register-read.scala:70:29, :86:29
      exe_reg_uops_0_ftq_idx <= rrd_uops_0_REG_ftq_idx;	// register-read.scala:70:29, :86:29
      exe_reg_uops_0_pc_lob <= rrd_uops_0_REG_pc_lob;	// register-read.scala:70:29, :86:29
      exe_reg_uops_0_imm_packed <= rrd_uops_0_REG_imm_packed;	// register-read.scala:70:29, :86:29
      exe_reg_uops_0_csr_addr <= rrd_uops_0_REG_csr_addr;	// register-read.scala:70:29, :86:29
      exe_reg_uops_0_rob_idx <= rrd_uops_0_REG_rob_idx;	// register-read.scala:70:29, :86:29
      exe_reg_uops_0_ldq_idx <= rrd_uops_0_REG_ldq_idx;	// register-read.scala:70:29, :86:29
      exe_reg_uops_0_stq_idx <= rrd_uops_0_REG_stq_idx;	// register-read.scala:70:29, :86:29
      exe_reg_uops_0_rxq_idx <= rrd_uops_0_REG_rxq_idx;	// register-read.scala:70:29, :86:29
      exe_reg_uops_0_pdst <= rrd_uops_0_REG_pdst;	// register-read.scala:70:29, :86:29
      exe_reg_uops_0_prs1 <= rrd_uops_0_REG_prs1;	// register-read.scala:70:29, :86:29
      exe_reg_uops_0_prs2 <= rrd_uops_0_REG_prs2;	// register-read.scala:70:29, :86:29
      exe_reg_uops_0_prs3 <= rrd_uops_0_REG_prs3;	// register-read.scala:70:29, :86:29
      exe_reg_uops_0_ppred <= rrd_uops_0_REG_ppred;	// register-read.scala:70:29, :86:29
      exe_reg_uops_0_stale_pdst <= rrd_uops_0_REG_stale_pdst;	// register-read.scala:70:29, :86:29
      exe_reg_uops_0_exc_cause <= rrd_uops_0_REG_exc_cause;	// register-read.scala:70:29, :86:29
      exe_reg_uops_0_mem_cmd <= rrd_uops_0_REG_mem_cmd;	// register-read.scala:70:29, :86:29
      exe_reg_uops_0_mem_size <= rrd_uops_0_REG_mem_size;	// register-read.scala:70:29, :86:29
      exe_reg_uops_0_ldst <= rrd_uops_0_REG_ldst;	// register-read.scala:70:29, :86:29
      exe_reg_uops_0_lrs1 <= rrd_uops_0_REG_lrs1;	// register-read.scala:70:29, :86:29
      exe_reg_uops_0_lrs2 <= rrd_uops_0_REG_lrs2;	// register-read.scala:70:29, :86:29
      exe_reg_uops_0_lrs3 <= rrd_uops_0_REG_lrs3;	// register-read.scala:70:29, :86:29
      exe_reg_uops_0_dst_rtype <= rrd_uops_0_REG_dst_rtype;	// register-read.scala:70:29, :86:29
      exe_reg_uops_0_lrs1_rtype <= rrd_uops_0_REG_lrs1_rtype;	// register-read.scala:70:29, :86:29
      exe_reg_uops_0_lrs2_rtype <= rrd_uops_0_REG_lrs2_rtype;	// register-read.scala:70:29, :86:29
      exe_reg_uops_0_debug_fsrc <= rrd_uops_0_REG_debug_fsrc;	// register-read.scala:70:29, :86:29
      exe_reg_uops_0_debug_tsrc <= rrd_uops_0_REG_debug_tsrc;	// register-read.scala:70:29, :86:29
    end
    exe_reg_uops_0_is_rvc <= ~rrd_kill & rrd_uops_0_REG_is_rvc;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_0_ctrl_fcn_dw <= ~rrd_kill & rrd_uops_0_REG_ctrl_fcn_dw;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_0_ctrl_is_load <= ~rrd_kill & rrd_uops_0_REG_ctrl_is_load;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_0_ctrl_is_sta <= ~rrd_kill & rrd_uops_0_REG_ctrl_is_sta;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_0_ctrl_is_std <= ~rrd_kill & rrd_uops_0_REG_ctrl_is_std;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_0_is_br <= ~rrd_kill & rrd_uops_0_REG_is_br;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_0_is_jalr <= ~rrd_kill & rrd_uops_0_REG_is_jalr;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_0_is_jal <= ~rrd_kill & rrd_uops_0_REG_is_jal;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_0_is_sfb <= ~rrd_kill & rrd_uops_0_REG_is_sfb;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_0_br_mask <= rrd_uops_0_REG_br_mask & ~io_brupdate_b1_resolve_mask;	// register-read.scala:70:29, :86:29, util.scala:74:37, :85:25
    exe_reg_uops_0_edge_inst <= ~rrd_kill & rrd_uops_0_REG_edge_inst;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_0_taken <= ~rrd_kill & rrd_uops_0_REG_taken;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_0_prs1_busy <= ~rrd_kill & rrd_uops_0_REG_prs1_busy;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_0_prs2_busy <= ~rrd_kill & rrd_uops_0_REG_prs2_busy;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_0_prs3_busy <= ~rrd_kill & rrd_uops_0_REG_prs3_busy;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_0_ppred_busy <= ~rrd_kill & rrd_uops_0_REG_ppred_busy;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_0_exception <= ~rrd_kill & rrd_uops_0_REG_exception;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_0_bypassable <= ~rrd_kill & rrd_uops_0_REG_bypassable;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_0_mem_signed <= ~rrd_kill & rrd_uops_0_REG_mem_signed;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_0_is_fence <= ~rrd_kill & rrd_uops_0_REG_is_fence;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_0_is_fencei <= ~rrd_kill & rrd_uops_0_REG_is_fencei;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_0_is_amo <= ~rrd_kill & rrd_uops_0_REG_is_amo;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_0_uses_ldq <= ~rrd_kill & rrd_uops_0_REG_uses_ldq;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_0_uses_stq <= ~rrd_kill & rrd_uops_0_REG_uses_stq;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_0_is_sys_pc2epc <= ~rrd_kill & rrd_uops_0_REG_is_sys_pc2epc;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_0_is_unique <= ~rrd_kill & rrd_uops_0_REG_is_unique;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_0_flush_on_commit <= ~rrd_kill & rrd_uops_0_REG_flush_on_commit;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_0_ldst_is_rs1 <= ~rrd_kill & rrd_uops_0_REG_ldst_is_rs1;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_0_ldst_val <= ~rrd_kill & rrd_uops_0_REG_ldst_val;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_0_frs3_en <= ~rrd_kill & rrd_uops_0_REG_frs3_en;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_0_fp_val <= ~rrd_kill & rrd_uops_0_REG_fp_val;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_0_fp_single <= ~rrd_kill & rrd_uops_0_REG_fp_single;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_0_xcpt_pf_if <= ~rrd_kill & rrd_uops_0_REG_xcpt_pf_if;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_0_xcpt_ae_if <= ~rrd_kill & rrd_uops_0_REG_xcpt_ae_if;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_0_xcpt_ma_if <= ~rrd_kill & rrd_uops_0_REG_xcpt_ma_if;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_0_bp_debug_if <= ~rrd_kill & rrd_uops_0_REG_bp_debug_if;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_0_bp_xcpt_if <= ~rrd_kill & rrd_uops_0_REG_bp_xcpt_if;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    if (rrd_kill_1) begin	// register-read.scala:130:28
      exe_reg_uops_1_uopc <= 7'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_inst <= 32'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_debug_inst <= 32'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_debug_pc <= 40'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_iq_type <= 3'h0;	// register-read.scala:70:29, :80:33
      exe_reg_uops_1_fu_code <= 10'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_ctrl_br_type <= 4'h0;	// consts.scala:280:20, register-read.scala:70:29
      exe_reg_uops_1_ctrl_op1_sel <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_ctrl_op2_sel <= 3'h0;	// register-read.scala:70:29, :80:33
      exe_reg_uops_1_ctrl_imm_sel <= 3'h0;	// register-read.scala:70:29, :80:33
      exe_reg_uops_1_ctrl_op_fcn <= 4'h0;	// consts.scala:280:20, register-read.scala:70:29
      exe_reg_uops_1_iw_state <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_br_tag <= 5'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_ftq_idx <= 6'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_1_pc_lob <= 6'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_1_imm_packed <= 20'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_csr_addr <= 12'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_rob_idx <= 7'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_ldq_idx <= 5'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_stq_idx <= 5'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_rxq_idx <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_pdst <= 7'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_prs1 <= 7'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_prs2 <= 7'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_prs3 <= 7'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_ppred <= 6'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_1_stale_pdst <= 7'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_exc_cause <= 64'h0;	// register-read.scala:70:29
      exe_reg_uops_1_mem_cmd <= 5'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_mem_size <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_ldst <= 6'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_1_lrs1 <= 6'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_1_lrs2 <= 6'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_1_lrs3 <= 6'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_1_dst_rtype <= 2'h2;	// consts.scala:277:20, register-read.scala:70:29
      exe_reg_uops_1_lrs1_rtype <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_lrs2_rtype <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_debug_fsrc <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_debug_tsrc <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
    end
    else begin	// register-read.scala:130:28
      exe_reg_uops_1_uopc <= rrd_uops_1_REG_uopc;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_inst <= rrd_uops_1_REG_inst;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_debug_inst <= rrd_uops_1_REG_debug_inst;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_debug_pc <= rrd_uops_1_REG_debug_pc;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_iq_type <= rrd_uops_1_REG_iq_type;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_fu_code <= rrd_uops_1_REG_fu_code;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_ctrl_br_type <= rrd_uops_1_REG_ctrl_br_type;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_ctrl_op1_sel <= rrd_uops_1_REG_ctrl_op1_sel;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_ctrl_op2_sel <= rrd_uops_1_REG_ctrl_op2_sel;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_ctrl_imm_sel <= rrd_uops_1_REG_ctrl_imm_sel;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_ctrl_op_fcn <= rrd_uops_1_REG_ctrl_op_fcn;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_iw_state <= rrd_uops_1_REG_iw_state;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_br_tag <= rrd_uops_1_REG_br_tag;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_ftq_idx <= rrd_uops_1_REG_ftq_idx;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_pc_lob <= rrd_uops_1_REG_pc_lob;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_imm_packed <= rrd_uops_1_REG_imm_packed;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_csr_addr <= rrd_uops_1_REG_csr_addr;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_rob_idx <= rrd_uops_1_REG_rob_idx;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_ldq_idx <= rrd_uops_1_REG_ldq_idx;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_stq_idx <= rrd_uops_1_REG_stq_idx;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_rxq_idx <= rrd_uops_1_REG_rxq_idx;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_pdst <= rrd_uops_1_REG_pdst;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_prs1 <= rrd_uops_1_REG_prs1;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_prs2 <= rrd_uops_1_REG_prs2;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_prs3 <= rrd_uops_1_REG_prs3;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_ppred <= rrd_uops_1_REG_ppred;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_stale_pdst <= rrd_uops_1_REG_stale_pdst;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_exc_cause <= rrd_uops_1_REG_exc_cause;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_mem_cmd <= rrd_uops_1_REG_mem_cmd;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_mem_size <= rrd_uops_1_REG_mem_size;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_ldst <= rrd_uops_1_REG_ldst;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_lrs1 <= rrd_uops_1_REG_lrs1;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_lrs2 <= rrd_uops_1_REG_lrs2;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_lrs3 <= rrd_uops_1_REG_lrs3;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_dst_rtype <= rrd_uops_1_REG_dst_rtype;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_lrs1_rtype <= rrd_uops_1_REG_lrs1_rtype;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_lrs2_rtype <= rrd_uops_1_REG_lrs2_rtype;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_debug_fsrc <= rrd_uops_1_REG_debug_fsrc;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_debug_tsrc <= rrd_uops_1_REG_debug_tsrc;	// register-read.scala:70:29, :86:29
    end
    exe_reg_uops_1_is_rvc <= ~rrd_kill_1 & rrd_uops_1_REG_is_rvc;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_ctrl_fcn_dw <= ~rrd_kill_1 & rrd_uops_1_REG_ctrl_fcn_dw;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_ctrl_is_load <= ~rrd_kill_1 & rrd_uops_1_REG_ctrl_is_load;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_ctrl_is_sta <= ~rrd_kill_1 & rrd_uops_1_REG_ctrl_is_sta;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_ctrl_is_std <= ~rrd_kill_1 & rrd_uops_1_REG_ctrl_is_std;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_is_br <= ~rrd_kill_1 & rrd_uops_1_REG_is_br;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_is_jalr <= ~rrd_kill_1 & rrd_uops_1_REG_is_jalr;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_is_jal <= ~rrd_kill_1 & rrd_uops_1_REG_is_jal;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_is_sfb <= ~rrd_kill_1 & rrd_uops_1_REG_is_sfb;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_br_mask <= rrd_uops_1_REG_br_mask & ~io_brupdate_b1_resolve_mask;	// register-read.scala:70:29, :86:29, util.scala:74:37, :85:25
    exe_reg_uops_1_edge_inst <= ~rrd_kill_1 & rrd_uops_1_REG_edge_inst;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_taken <= ~rrd_kill_1 & rrd_uops_1_REG_taken;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_prs1_busy <= ~rrd_kill_1 & rrd_uops_1_REG_prs1_busy;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_prs2_busy <= ~rrd_kill_1 & rrd_uops_1_REG_prs2_busy;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_prs3_busy <= ~rrd_kill_1 & rrd_uops_1_REG_prs3_busy;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_ppred_busy <= ~rrd_kill_1 & rrd_uops_1_REG_ppred_busy;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_exception <= ~rrd_kill_1 & rrd_uops_1_REG_exception;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_bypassable <= ~rrd_kill_1 & rrd_uops_1_REG_bypassable;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_mem_signed <= ~rrd_kill_1 & rrd_uops_1_REG_mem_signed;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_is_fence <= ~rrd_kill_1 & rrd_uops_1_REG_is_fence;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_is_fencei <= ~rrd_kill_1 & rrd_uops_1_REG_is_fencei;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_is_amo <= ~rrd_kill_1 & rrd_uops_1_REG_is_amo;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_uses_ldq <= ~rrd_kill_1 & rrd_uops_1_REG_uses_ldq;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_uses_stq <= ~rrd_kill_1 & rrd_uops_1_REG_uses_stq;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_is_sys_pc2epc <= ~rrd_kill_1 & rrd_uops_1_REG_is_sys_pc2epc;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_is_unique <= ~rrd_kill_1 & rrd_uops_1_REG_is_unique;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_flush_on_commit <= ~rrd_kill_1 & rrd_uops_1_REG_flush_on_commit;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_ldst_is_rs1 <= ~rrd_kill_1 & rrd_uops_1_REG_ldst_is_rs1;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_ldst_val <= ~rrd_kill_1 & rrd_uops_1_REG_ldst_val;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_frs3_en <= ~rrd_kill_1 & rrd_uops_1_REG_frs3_en;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_fp_val <= ~rrd_kill_1 & rrd_uops_1_REG_fp_val;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_fp_single <= ~rrd_kill_1 & rrd_uops_1_REG_fp_single;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_xcpt_pf_if <= ~rrd_kill_1 & rrd_uops_1_REG_xcpt_pf_if;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_xcpt_ae_if <= ~rrd_kill_1 & rrd_uops_1_REG_xcpt_ae_if;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_xcpt_ma_if <= ~rrd_kill_1 & rrd_uops_1_REG_xcpt_ma_if;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_bp_debug_if <= ~rrd_kill_1 & rrd_uops_1_REG_bp_debug_if;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_bp_xcpt_if <= ~rrd_kill_1 & rrd_uops_1_REG_bp_xcpt_if;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    if (rrd_kill_2) begin	// register-read.scala:130:28
      exe_reg_uops_2_uopc <= 7'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_inst <= 32'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_debug_inst <= 32'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_debug_pc <= 40'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_iq_type <= 3'h0;	// register-read.scala:70:29, :80:33
      exe_reg_uops_2_fu_code <= 10'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_ctrl_br_type <= 4'h0;	// consts.scala:280:20, register-read.scala:70:29
      exe_reg_uops_2_ctrl_op1_sel <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_ctrl_op2_sel <= 3'h0;	// register-read.scala:70:29, :80:33
      exe_reg_uops_2_ctrl_imm_sel <= 3'h0;	// register-read.scala:70:29, :80:33
      exe_reg_uops_2_ctrl_op_fcn <= 4'h0;	// consts.scala:280:20, register-read.scala:70:29
      exe_reg_uops_2_iw_state <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_br_tag <= 5'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_ftq_idx <= 6'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_2_pc_lob <= 6'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_2_imm_packed <= 20'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_csr_addr <= 12'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_rob_idx <= 7'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_ldq_idx <= 5'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_stq_idx <= 5'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_rxq_idx <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_pdst <= 7'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_prs1 <= 7'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_prs2 <= 7'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_prs3 <= 7'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_ppred <= 6'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_2_stale_pdst <= 7'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_exc_cause <= 64'h0;	// register-read.scala:70:29
      exe_reg_uops_2_mem_cmd <= 5'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_mem_size <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_ldst <= 6'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_2_lrs1 <= 6'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_2_lrs2 <= 6'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_2_lrs3 <= 6'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_2_dst_rtype <= 2'h2;	// consts.scala:277:20, register-read.scala:70:29
      exe_reg_uops_2_lrs1_rtype <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_lrs2_rtype <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_debug_fsrc <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_debug_tsrc <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
    end
    else begin	// register-read.scala:130:28
      exe_reg_uops_2_uopc <= rrd_uops_2_REG_uopc;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_inst <= rrd_uops_2_REG_inst;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_debug_inst <= rrd_uops_2_REG_debug_inst;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_debug_pc <= rrd_uops_2_REG_debug_pc;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_iq_type <= rrd_uops_2_REG_iq_type;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_fu_code <= rrd_uops_2_REG_fu_code;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_ctrl_br_type <= rrd_uops_2_REG_ctrl_br_type;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_ctrl_op1_sel <= rrd_uops_2_REG_ctrl_op1_sel;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_ctrl_op2_sel <= rrd_uops_2_REG_ctrl_op2_sel;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_ctrl_imm_sel <= rrd_uops_2_REG_ctrl_imm_sel;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_ctrl_op_fcn <= rrd_uops_2_REG_ctrl_op_fcn;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_iw_state <= rrd_uops_2_REG_iw_state;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_br_tag <= rrd_uops_2_REG_br_tag;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_ftq_idx <= rrd_uops_2_REG_ftq_idx;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_pc_lob <= rrd_uops_2_REG_pc_lob;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_imm_packed <= rrd_uops_2_REG_imm_packed;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_csr_addr <= rrd_uops_2_REG_csr_addr;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_rob_idx <= rrd_uops_2_REG_rob_idx;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_ldq_idx <= rrd_uops_2_REG_ldq_idx;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_stq_idx <= rrd_uops_2_REG_stq_idx;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_rxq_idx <= rrd_uops_2_REG_rxq_idx;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_pdst <= rrd_uops_2_REG_pdst;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_prs1 <= rrd_uops_2_REG_prs1;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_prs2 <= rrd_uops_2_REG_prs2;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_prs3 <= rrd_uops_2_REG_prs3;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_ppred <= rrd_uops_2_REG_ppred;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_stale_pdst <= rrd_uops_2_REG_stale_pdst;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_exc_cause <= rrd_uops_2_REG_exc_cause;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_mem_cmd <= rrd_uops_2_REG_mem_cmd;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_mem_size <= rrd_uops_2_REG_mem_size;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_ldst <= rrd_uops_2_REG_ldst;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_lrs1 <= rrd_uops_2_REG_lrs1;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_lrs2 <= rrd_uops_2_REG_lrs2;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_lrs3 <= rrd_uops_2_REG_lrs3;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_dst_rtype <= rrd_uops_2_REG_dst_rtype;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_lrs1_rtype <= rrd_uops_2_REG_lrs1_rtype;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_lrs2_rtype <= rrd_uops_2_REG_lrs2_rtype;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_debug_fsrc <= rrd_uops_2_REG_debug_fsrc;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_debug_tsrc <= rrd_uops_2_REG_debug_tsrc;	// register-read.scala:70:29, :86:29
    end
    exe_reg_uops_2_is_rvc <= ~rrd_kill_2 & rrd_uops_2_REG_is_rvc;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_ctrl_fcn_dw <= ~rrd_kill_2 & rrd_uops_2_REG_ctrl_fcn_dw;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_ctrl_is_load <= ~rrd_kill_2 & rrd_uops_2_REG_ctrl_is_load;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_ctrl_is_sta <= ~rrd_kill_2 & rrd_uops_2_REG_ctrl_is_sta;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_ctrl_is_std <= ~rrd_kill_2 & rrd_uops_2_REG_ctrl_is_std;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_is_br <= ~rrd_kill_2 & rrd_uops_2_REG_is_br;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_is_jalr <= ~rrd_kill_2 & rrd_uops_2_REG_is_jalr;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_is_jal <= ~rrd_kill_2 & rrd_uops_2_REG_is_jal;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_is_sfb <= ~rrd_kill_2 & rrd_uops_2_REG_is_sfb;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_br_mask <= rrd_uops_2_REG_br_mask & ~io_brupdate_b1_resolve_mask;	// register-read.scala:70:29, :86:29, util.scala:74:37, :85:25
    exe_reg_uops_2_edge_inst <= ~rrd_kill_2 & rrd_uops_2_REG_edge_inst;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_taken <= ~rrd_kill_2 & rrd_uops_2_REG_taken;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_prs1_busy <= ~rrd_kill_2 & rrd_uops_2_REG_prs1_busy;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_prs2_busy <= ~rrd_kill_2 & rrd_uops_2_REG_prs2_busy;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_prs3_busy <= ~rrd_kill_2 & rrd_uops_2_REG_prs3_busy;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_ppred_busy <= ~rrd_kill_2 & rrd_uops_2_REG_ppred_busy;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_exception <= ~rrd_kill_2 & rrd_uops_2_REG_exception;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_bypassable <= ~rrd_kill_2 & rrd_uops_2_REG_bypassable;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_mem_signed <= ~rrd_kill_2 & rrd_uops_2_REG_mem_signed;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_is_fence <= ~rrd_kill_2 & rrd_uops_2_REG_is_fence;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_is_fencei <= ~rrd_kill_2 & rrd_uops_2_REG_is_fencei;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_is_amo <= ~rrd_kill_2 & rrd_uops_2_REG_is_amo;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_uses_ldq <= ~rrd_kill_2 & rrd_uops_2_REG_uses_ldq;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_uses_stq <= ~rrd_kill_2 & rrd_uops_2_REG_uses_stq;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_is_sys_pc2epc <= ~rrd_kill_2 & rrd_uops_2_REG_is_sys_pc2epc;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_is_unique <= ~rrd_kill_2 & rrd_uops_2_REG_is_unique;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_flush_on_commit <= ~rrd_kill_2 & rrd_uops_2_REG_flush_on_commit;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_ldst_is_rs1 <= ~rrd_kill_2 & rrd_uops_2_REG_ldst_is_rs1;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_ldst_val <= ~rrd_kill_2 & rrd_uops_2_REG_ldst_val;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_frs3_en <= ~rrd_kill_2 & rrd_uops_2_REG_frs3_en;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_fp_val <= ~rrd_kill_2 & rrd_uops_2_REG_fp_val;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_fp_single <= ~rrd_kill_2 & rrd_uops_2_REG_fp_single;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_xcpt_pf_if <= ~rrd_kill_2 & rrd_uops_2_REG_xcpt_pf_if;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_xcpt_ae_if <= ~rrd_kill_2 & rrd_uops_2_REG_xcpt_ae_if;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_xcpt_ma_if <= ~rrd_kill_2 & rrd_uops_2_REG_xcpt_ma_if;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_bp_debug_if <= ~rrd_kill_2 & rrd_uops_2_REG_bp_debug_if;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_bp_xcpt_if <= ~rrd_kill_2 & rrd_uops_2_REG_bp_xcpt_if;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    if (rrd_kill_3) begin	// register-read.scala:130:28
      exe_reg_uops_3_uopc <= 7'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_3_fu_code <= 10'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_3_ctrl_br_type <= 4'h0;	// consts.scala:280:20, register-read.scala:70:29
      exe_reg_uops_3_ctrl_op1_sel <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_3_ctrl_op2_sel <= 3'h0;	// register-read.scala:70:29, :80:33
      exe_reg_uops_3_ctrl_imm_sel <= 3'h0;	// register-read.scala:70:29, :80:33
      exe_reg_uops_3_ctrl_op_fcn <= 4'h0;	// consts.scala:280:20, register-read.scala:70:29
      exe_reg_uops_3_ctrl_csr_cmd <= 3'h0;	// register-read.scala:70:29, :80:33
      exe_reg_uops_3_br_tag <= 5'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_3_ftq_idx <= 6'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_3_pc_lob <= 6'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_3_imm_packed <= 20'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_3_rob_idx <= 7'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_3_ldq_idx <= 5'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_3_stq_idx <= 5'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_3_pdst <= 7'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_3_prs1 <= 7'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_3_dst_rtype <= 2'h2;	// consts.scala:277:20, register-read.scala:70:29
    end
    else begin	// register-read.scala:130:28
      exe_reg_uops_3_uopc <= rrd_uops_3_REG_uopc;	// register-read.scala:70:29, :86:29
      exe_reg_uops_3_fu_code <= rrd_uops_3_REG_fu_code;	// register-read.scala:70:29, :86:29
      exe_reg_uops_3_ctrl_br_type <= rrd_uops_3_REG_ctrl_br_type;	// register-read.scala:70:29, :86:29
      exe_reg_uops_3_ctrl_op1_sel <= rrd_uops_3_REG_ctrl_op1_sel;	// register-read.scala:70:29, :86:29
      exe_reg_uops_3_ctrl_op2_sel <= rrd_uops_3_REG_ctrl_op2_sel;	// register-read.scala:70:29, :86:29
      exe_reg_uops_3_ctrl_imm_sel <= rrd_uops_3_REG_ctrl_imm_sel;	// register-read.scala:70:29, :86:29
      exe_reg_uops_3_ctrl_op_fcn <= rrd_uops_3_REG_ctrl_op_fcn;	// register-read.scala:70:29, :86:29
      exe_reg_uops_3_ctrl_csr_cmd <= rrd_uops_3_REG_ctrl_csr_cmd;	// register-read.scala:70:29, :86:29
      exe_reg_uops_3_br_tag <= rrd_uops_3_REG_br_tag;	// register-read.scala:70:29, :86:29
      exe_reg_uops_3_ftq_idx <= rrd_uops_3_REG_ftq_idx;	// register-read.scala:70:29, :86:29
      exe_reg_uops_3_pc_lob <= rrd_uops_3_REG_pc_lob;	// register-read.scala:70:29, :86:29
      exe_reg_uops_3_imm_packed <= rrd_uops_3_REG_imm_packed;	// register-read.scala:70:29, :86:29
      exe_reg_uops_3_rob_idx <= rrd_uops_3_REG_rob_idx;	// register-read.scala:70:29, :86:29
      exe_reg_uops_3_ldq_idx <= rrd_uops_3_REG_ldq_idx;	// register-read.scala:70:29, :86:29
      exe_reg_uops_3_stq_idx <= rrd_uops_3_REG_stq_idx;	// register-read.scala:70:29, :86:29
      exe_reg_uops_3_pdst <= rrd_uops_3_REG_pdst;	// register-read.scala:70:29, :86:29
      exe_reg_uops_3_prs1 <= rrd_uops_3_REG_prs1;	// register-read.scala:70:29, :86:29
      exe_reg_uops_3_dst_rtype <= rrd_uops_3_REG_dst_rtype;	// register-read.scala:70:29, :86:29
    end
    exe_reg_uops_3_is_rvc <= ~rrd_kill_3 & rrd_uops_3_REG_is_rvc;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_3_ctrl_fcn_dw <= ~rrd_kill_3 & rrd_uops_3_REG_ctrl_fcn_dw;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_3_is_br <= ~rrd_kill_3 & rrd_uops_3_REG_is_br;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_3_is_jalr <= ~rrd_kill_3 & rrd_uops_3_REG_is_jalr;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_3_is_jal <= ~rrd_kill_3 & rrd_uops_3_REG_is_jal;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_3_is_sfb <= ~rrd_kill_3 & rrd_uops_3_REG_is_sfb;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_3_br_mask <= rrd_uops_3_REG_br_mask & ~io_brupdate_b1_resolve_mask;	// register-read.scala:70:29, :86:29, util.scala:74:37, :85:25
    exe_reg_uops_3_edge_inst <= ~rrd_kill_3 & rrd_uops_3_REG_edge_inst;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_3_taken <= ~rrd_kill_3 & rrd_uops_3_REG_taken;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_3_bypassable <= ~rrd_kill_3 & rrd_uops_3_REG_bypassable;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_3_is_amo <= ~rrd_kill_3 & rrd_uops_3_REG_is_amo;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_3_uses_stq <= ~rrd_kill_3 & rrd_uops_3_REG_uses_stq;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    if (rrd_kill_4) begin	// register-read.scala:130:28
      exe_reg_uops_4_uopc <= 7'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_4_fu_code <= 10'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_4_ctrl_br_type <= 4'h0;	// consts.scala:280:20, register-read.scala:70:29
      exe_reg_uops_4_ctrl_op1_sel <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_4_ctrl_op2_sel <= 3'h0;	// register-read.scala:70:29, :80:33
      exe_reg_uops_4_ctrl_imm_sel <= 3'h0;	// register-read.scala:70:29, :80:33
      exe_reg_uops_4_ctrl_op_fcn <= 4'h0;	// consts.scala:280:20, register-read.scala:70:29
      exe_reg_uops_4_br_tag <= 5'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_4_ftq_idx <= 6'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_4_pc_lob <= 6'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_4_imm_packed <= 20'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_4_rob_idx <= 7'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_4_ldq_idx <= 5'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_4_stq_idx <= 5'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_4_pdst <= 7'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_4_prs1 <= 7'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_4_dst_rtype <= 2'h2;	// consts.scala:277:20, register-read.scala:70:29
    end
    else begin	// register-read.scala:130:28
      exe_reg_uops_4_uopc <= rrd_uops_4_REG_uopc;	// register-read.scala:70:29, :86:29
      exe_reg_uops_4_fu_code <= rrd_uops_4_REG_fu_code;	// register-read.scala:70:29, :86:29
      exe_reg_uops_4_ctrl_br_type <= rrd_uops_4_REG_ctrl_br_type;	// register-read.scala:70:29, :86:29
      exe_reg_uops_4_ctrl_op1_sel <= rrd_uops_4_REG_ctrl_op1_sel;	// register-read.scala:70:29, :86:29
      exe_reg_uops_4_ctrl_op2_sel <= rrd_uops_4_REG_ctrl_op2_sel;	// register-read.scala:70:29, :86:29
      exe_reg_uops_4_ctrl_imm_sel <= rrd_uops_4_REG_ctrl_imm_sel;	// register-read.scala:70:29, :86:29
      exe_reg_uops_4_ctrl_op_fcn <= rrd_uops_4_REG_ctrl_op_fcn;	// register-read.scala:70:29, :86:29
      exe_reg_uops_4_br_tag <= rrd_uops_4_REG_br_tag;	// register-read.scala:70:29, :86:29
      exe_reg_uops_4_ftq_idx <= rrd_uops_4_REG_ftq_idx;	// register-read.scala:70:29, :86:29
      exe_reg_uops_4_pc_lob <= rrd_uops_4_REG_pc_lob;	// register-read.scala:70:29, :86:29
      exe_reg_uops_4_imm_packed <= rrd_uops_4_REG_imm_packed;	// register-read.scala:70:29, :86:29
      exe_reg_uops_4_rob_idx <= rrd_uops_4_REG_rob_idx;	// register-read.scala:70:29, :86:29
      exe_reg_uops_4_ldq_idx <= rrd_uops_4_REG_ldq_idx;	// register-read.scala:70:29, :86:29
      exe_reg_uops_4_stq_idx <= rrd_uops_4_REG_stq_idx;	// register-read.scala:70:29, :86:29
      exe_reg_uops_4_pdst <= rrd_uops_4_REG_pdst;	// register-read.scala:70:29, :86:29
      exe_reg_uops_4_prs1 <= rrd_uops_4_REG_prs1;	// register-read.scala:70:29, :86:29
      exe_reg_uops_4_dst_rtype <= rrd_uops_4_REG_dst_rtype;	// register-read.scala:70:29, :86:29
    end
    exe_reg_uops_4_is_rvc <= ~rrd_kill_4 & rrd_uops_4_REG_is_rvc;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_4_ctrl_fcn_dw <= ~rrd_kill_4 & rrd_uops_4_REG_ctrl_fcn_dw;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_4_is_br <= ~rrd_kill_4 & rrd_uops_4_REG_is_br;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_4_is_jalr <= ~rrd_kill_4 & rrd_uops_4_REG_is_jalr;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_4_is_jal <= ~rrd_kill_4 & rrd_uops_4_REG_is_jal;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_4_is_sfb <= ~rrd_kill_4 & rrd_uops_4_REG_is_sfb;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_4_br_mask <= rrd_uops_4_REG_br_mask & ~io_brupdate_b1_resolve_mask;	// register-read.scala:70:29, :86:29, util.scala:74:37, :85:25
    exe_reg_uops_4_edge_inst <= ~rrd_kill_4 & rrd_uops_4_REG_edge_inst;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_4_taken <= ~rrd_kill_4 & rrd_uops_4_REG_taken;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_4_bypassable <= ~rrd_kill_4 & rrd_uops_4_REG_bypassable;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_4_is_amo <= ~rrd_kill_4 & rrd_uops_4_REG_is_amo;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_4_uses_stq <= ~rrd_kill_4 & rrd_uops_4_REG_uses_stq;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    if (rrd_kill_5) begin	// register-read.scala:130:28
      exe_reg_uops_5_uopc <= 7'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_5_fu_code <= 10'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_5_ctrl_br_type <= 4'h0;	// consts.scala:280:20, register-read.scala:70:29
      exe_reg_uops_5_ctrl_op1_sel <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_5_ctrl_op2_sel <= 3'h0;	// register-read.scala:70:29, :80:33
      exe_reg_uops_5_ctrl_imm_sel <= 3'h0;	// register-read.scala:70:29, :80:33
      exe_reg_uops_5_ctrl_op_fcn <= 4'h0;	// consts.scala:280:20, register-read.scala:70:29
      exe_reg_uops_5_br_tag <= 5'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_5_ftq_idx <= 6'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_5_pc_lob <= 6'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_5_imm_packed <= 20'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_5_rob_idx <= 7'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_5_ldq_idx <= 5'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_5_stq_idx <= 5'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_5_pdst <= 7'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_5_prs1 <= 7'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_5_dst_rtype <= 2'h2;	// consts.scala:277:20, register-read.scala:70:29
    end
    else begin	// register-read.scala:130:28
      exe_reg_uops_5_uopc <= rrd_uops_5_REG_uopc;	// register-read.scala:70:29, :86:29
      exe_reg_uops_5_fu_code <= rrd_uops_5_REG_fu_code;	// register-read.scala:70:29, :86:29
      exe_reg_uops_5_ctrl_br_type <= rrd_uops_5_REG_ctrl_br_type;	// register-read.scala:70:29, :86:29
      exe_reg_uops_5_ctrl_op1_sel <= rrd_uops_5_REG_ctrl_op1_sel;	// register-read.scala:70:29, :86:29
      exe_reg_uops_5_ctrl_op2_sel <= rrd_uops_5_REG_ctrl_op2_sel;	// register-read.scala:70:29, :86:29
      exe_reg_uops_5_ctrl_imm_sel <= rrd_uops_5_REG_ctrl_imm_sel;	// register-read.scala:70:29, :86:29
      exe_reg_uops_5_ctrl_op_fcn <= rrd_uops_5_REG_ctrl_op_fcn;	// register-read.scala:70:29, :86:29
      exe_reg_uops_5_br_tag <= rrd_uops_5_REG_br_tag;	// register-read.scala:70:29, :86:29
      exe_reg_uops_5_ftq_idx <= rrd_uops_5_REG_ftq_idx;	// register-read.scala:70:29, :86:29
      exe_reg_uops_5_pc_lob <= rrd_uops_5_REG_pc_lob;	// register-read.scala:70:29, :86:29
      exe_reg_uops_5_imm_packed <= rrd_uops_5_REG_imm_packed;	// register-read.scala:70:29, :86:29
      exe_reg_uops_5_rob_idx <= rrd_uops_5_REG_rob_idx;	// register-read.scala:70:29, :86:29
      exe_reg_uops_5_ldq_idx <= rrd_uops_5_REG_ldq_idx;	// register-read.scala:70:29, :86:29
      exe_reg_uops_5_stq_idx <= rrd_uops_5_REG_stq_idx;	// register-read.scala:70:29, :86:29
      exe_reg_uops_5_pdst <= rrd_uops_5_REG_pdst;	// register-read.scala:70:29, :86:29
      exe_reg_uops_5_prs1 <= rrd_uops_5_REG_prs1;	// register-read.scala:70:29, :86:29
      exe_reg_uops_5_dst_rtype <= rrd_uops_5_REG_dst_rtype;	// register-read.scala:70:29, :86:29
    end
    exe_reg_uops_5_is_rvc <= ~rrd_kill_5 & rrd_uops_5_REG_is_rvc;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_5_ctrl_fcn_dw <= ~rrd_kill_5 & rrd_uops_5_REG_ctrl_fcn_dw;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_5_is_br <= ~rrd_kill_5 & rrd_uops_5_REG_is_br;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_5_is_jalr <= ~rrd_kill_5 & rrd_uops_5_REG_is_jalr;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_5_is_jal <= ~rrd_kill_5 & rrd_uops_5_REG_is_jal;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_5_is_sfb <= ~rrd_kill_5 & rrd_uops_5_REG_is_sfb;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_5_br_mask <= rrd_uops_5_REG_br_mask & ~io_brupdate_b1_resolve_mask;	// register-read.scala:70:29, :86:29, util.scala:74:37, :85:25
    exe_reg_uops_5_edge_inst <= ~rrd_kill_5 & rrd_uops_5_REG_edge_inst;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_5_taken <= ~rrd_kill_5 & rrd_uops_5_REG_taken;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_5_bypassable <= ~rrd_kill_5 & rrd_uops_5_REG_bypassable;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_5_is_amo <= ~rrd_kill_5 & rrd_uops_5_REG_is_amo;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_5_uses_stq <= ~rrd_kill_5 & rrd_uops_5_REG_uses_stq;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    if (io_bypass_0_valid & rrd_uops_0_REG_prs1 == io_bypass_0_bits_uop_pdst & _GEN
        & _GEN_0 & _GEN_1 & (|rrd_uops_0_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_0 <= io_bypass_0_bits_data;	// register-read.scala:71:29
    else if (io_bypass_1_valid & rrd_uops_0_REG_prs1 == io_bypass_1_bits_uop_pdst & _GEN_3
             & _GEN_4 & _GEN_1 & (|rrd_uops_0_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_0 <= io_bypass_1_bits_data;	// register-read.scala:71:29
    else if (io_bypass_2_valid & rrd_uops_0_REG_prs1 == io_bypass_2_bits_uop_pdst & _GEN_5
             & _GEN_6 & _GEN_1 & (|rrd_uops_0_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_0 <= io_bypass_2_bits_data;	// register-read.scala:71:29
    else if (io_bypass_3_valid & rrd_uops_0_REG_prs1 == io_bypass_3_bits_uop_pdst & _GEN_7
             & _GEN_8 & _GEN_1 & (|rrd_uops_0_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_0 <= io_bypass_3_bits_data;	// register-read.scala:71:29
    else if (io_bypass_4_valid & rrd_uops_0_REG_prs1 == io_bypass_4_bits_uop_pdst & _GEN_9
             & _GEN_10 & _GEN_1 & (|rrd_uops_0_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_0 <= io_bypass_4_bits_data;	// register-read.scala:71:29
    else if (io_bypass_5_valid & rrd_uops_0_REG_prs1 == io_bypass_5_bits_uop_pdst
             & _GEN_11 & _GEN_12 & _GEN_1 & (|rrd_uops_0_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_0 <= io_bypass_5_bits_data;	// register-read.scala:71:29
    else if (rrd_rs1_data_0_REG)	// register-read.scala:124:57
      exe_reg_rs1_data_0 <= 64'h0;	// register-read.scala:71:29
    else	// register-read.scala:124:57
      exe_reg_rs1_data_0 <= io_rf_read_ports_0_data;	// register-read.scala:71:29
    if (io_bypass_0_valid & rrd_uops_1_REG_prs1 == io_bypass_0_bits_uop_pdst & _GEN
        & _GEN_0 & _GEN_13 & (|rrd_uops_1_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_1 <= io_bypass_0_bits_data;	// register-read.scala:71:29
    else if (io_bypass_1_valid & rrd_uops_1_REG_prs1 == io_bypass_1_bits_uop_pdst & _GEN_3
             & _GEN_4 & _GEN_13 & (|rrd_uops_1_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_1 <= io_bypass_1_bits_data;	// register-read.scala:71:29
    else if (io_bypass_2_valid & rrd_uops_1_REG_prs1 == io_bypass_2_bits_uop_pdst & _GEN_5
             & _GEN_6 & _GEN_13 & (|rrd_uops_1_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_1 <= io_bypass_2_bits_data;	// register-read.scala:71:29
    else if (io_bypass_3_valid & rrd_uops_1_REG_prs1 == io_bypass_3_bits_uop_pdst & _GEN_7
             & _GEN_8 & _GEN_13 & (|rrd_uops_1_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_1 <= io_bypass_3_bits_data;	// register-read.scala:71:29
    else if (io_bypass_4_valid & rrd_uops_1_REG_prs1 == io_bypass_4_bits_uop_pdst & _GEN_9
             & _GEN_10 & _GEN_13 & (|rrd_uops_1_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_1 <= io_bypass_4_bits_data;	// register-read.scala:71:29
    else if (io_bypass_5_valid & rrd_uops_1_REG_prs1 == io_bypass_5_bits_uop_pdst
             & _GEN_11 & _GEN_12 & _GEN_13 & (|rrd_uops_1_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_1 <= io_bypass_5_bits_data;	// register-read.scala:71:29
    else if (rrd_rs1_data_1_REG)	// register-read.scala:124:57
      exe_reg_rs1_data_1 <= 64'h0;	// register-read.scala:71:29
    else	// register-read.scala:124:57
      exe_reg_rs1_data_1 <= io_rf_read_ports_2_data;	// register-read.scala:71:29
    if (io_bypass_0_valid & rrd_uops_2_REG_prs1 == io_bypass_0_bits_uop_pdst & _GEN
        & _GEN_0 & _GEN_15 & (|rrd_uops_2_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_2 <= io_bypass_0_bits_data;	// register-read.scala:71:29
    else if (io_bypass_1_valid & rrd_uops_2_REG_prs1 == io_bypass_1_bits_uop_pdst & _GEN_3
             & _GEN_4 & _GEN_15 & (|rrd_uops_2_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_2 <= io_bypass_1_bits_data;	// register-read.scala:71:29
    else if (io_bypass_2_valid & rrd_uops_2_REG_prs1 == io_bypass_2_bits_uop_pdst & _GEN_5
             & _GEN_6 & _GEN_15 & (|rrd_uops_2_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_2 <= io_bypass_2_bits_data;	// register-read.scala:71:29
    else if (io_bypass_3_valid & rrd_uops_2_REG_prs1 == io_bypass_3_bits_uop_pdst & _GEN_7
             & _GEN_8 & _GEN_15 & (|rrd_uops_2_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_2 <= io_bypass_3_bits_data;	// register-read.scala:71:29
    else if (io_bypass_4_valid & rrd_uops_2_REG_prs1 == io_bypass_4_bits_uop_pdst & _GEN_9
             & _GEN_10 & _GEN_15 & (|rrd_uops_2_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_2 <= io_bypass_4_bits_data;	// register-read.scala:71:29
    else if (io_bypass_5_valid & rrd_uops_2_REG_prs1 == io_bypass_5_bits_uop_pdst
             & _GEN_11 & _GEN_12 & _GEN_15 & (|rrd_uops_2_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_2 <= io_bypass_5_bits_data;	// register-read.scala:71:29
    else if (rrd_rs1_data_2_REG)	// register-read.scala:124:57
      exe_reg_rs1_data_2 <= 64'h0;	// register-read.scala:71:29
    else	// register-read.scala:124:57
      exe_reg_rs1_data_2 <= io_rf_read_ports_4_data;	// register-read.scala:71:29
    if (io_bypass_0_valid & rrd_uops_3_REG_prs1 == io_bypass_0_bits_uop_pdst & _GEN
        & _GEN_0 & _GEN_17 & (|rrd_uops_3_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_3 <= io_bypass_0_bits_data;	// register-read.scala:71:29
    else if (io_bypass_1_valid & rrd_uops_3_REG_prs1 == io_bypass_1_bits_uop_pdst & _GEN_3
             & _GEN_4 & _GEN_17 & (|rrd_uops_3_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_3 <= io_bypass_1_bits_data;	// register-read.scala:71:29
    else if (io_bypass_2_valid & rrd_uops_3_REG_prs1 == io_bypass_2_bits_uop_pdst & _GEN_5
             & _GEN_6 & _GEN_17 & (|rrd_uops_3_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_3 <= io_bypass_2_bits_data;	// register-read.scala:71:29
    else if (io_bypass_3_valid & rrd_uops_3_REG_prs1 == io_bypass_3_bits_uop_pdst & _GEN_7
             & _GEN_8 & _GEN_17 & (|rrd_uops_3_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_3 <= io_bypass_3_bits_data;	// register-read.scala:71:29
    else if (io_bypass_4_valid & rrd_uops_3_REG_prs1 == io_bypass_4_bits_uop_pdst & _GEN_9
             & _GEN_10 & _GEN_17 & (|rrd_uops_3_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_3 <= io_bypass_4_bits_data;	// register-read.scala:71:29
    else if (io_bypass_5_valid & rrd_uops_3_REG_prs1 == io_bypass_5_bits_uop_pdst
             & _GEN_11 & _GEN_12 & _GEN_17 & (|rrd_uops_3_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_3 <= io_bypass_5_bits_data;	// register-read.scala:71:29
    else if (rrd_rs1_data_3_REG)	// register-read.scala:124:57
      exe_reg_rs1_data_3 <= 64'h0;	// register-read.scala:71:29
    else	// register-read.scala:124:57
      exe_reg_rs1_data_3 <= io_rf_read_ports_6_data;	// register-read.scala:71:29
    if (io_bypass_0_valid & rrd_uops_4_REG_prs1 == io_bypass_0_bits_uop_pdst & _GEN
        & _GEN_0 & _GEN_19 & (|rrd_uops_4_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_4 <= io_bypass_0_bits_data;	// register-read.scala:71:29
    else if (io_bypass_1_valid & rrd_uops_4_REG_prs1 == io_bypass_1_bits_uop_pdst & _GEN_3
             & _GEN_4 & _GEN_19 & (|rrd_uops_4_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_4 <= io_bypass_1_bits_data;	// register-read.scala:71:29
    else if (io_bypass_2_valid & rrd_uops_4_REG_prs1 == io_bypass_2_bits_uop_pdst & _GEN_5
             & _GEN_6 & _GEN_19 & (|rrd_uops_4_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_4 <= io_bypass_2_bits_data;	// register-read.scala:71:29
    else if (io_bypass_3_valid & rrd_uops_4_REG_prs1 == io_bypass_3_bits_uop_pdst & _GEN_7
             & _GEN_8 & _GEN_19 & (|rrd_uops_4_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_4 <= io_bypass_3_bits_data;	// register-read.scala:71:29
    else if (io_bypass_4_valid & rrd_uops_4_REG_prs1 == io_bypass_4_bits_uop_pdst & _GEN_9
             & _GEN_10 & _GEN_19 & (|rrd_uops_4_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_4 <= io_bypass_4_bits_data;	// register-read.scala:71:29
    else if (io_bypass_5_valid & rrd_uops_4_REG_prs1 == io_bypass_5_bits_uop_pdst
             & _GEN_11 & _GEN_12 & _GEN_19 & (|rrd_uops_4_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_4 <= io_bypass_5_bits_data;	// register-read.scala:71:29
    else if (rrd_rs1_data_4_REG)	// register-read.scala:124:57
      exe_reg_rs1_data_4 <= 64'h0;	// register-read.scala:71:29
    else	// register-read.scala:124:57
      exe_reg_rs1_data_4 <= io_rf_read_ports_8_data;	// register-read.scala:71:29
    if (io_bypass_0_valid & rrd_uops_5_REG_prs1 == io_bypass_0_bits_uop_pdst & _GEN
        & _GEN_0 & _GEN_21 & (|rrd_uops_5_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_5 <= io_bypass_0_bits_data;	// register-read.scala:71:29
    else if (io_bypass_1_valid & rrd_uops_5_REG_prs1 == io_bypass_1_bits_uop_pdst & _GEN_3
             & _GEN_4 & _GEN_21 & (|rrd_uops_5_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_5 <= io_bypass_1_bits_data;	// register-read.scala:71:29
    else if (io_bypass_2_valid & rrd_uops_5_REG_prs1 == io_bypass_2_bits_uop_pdst & _GEN_5
             & _GEN_6 & _GEN_21 & (|rrd_uops_5_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_5 <= io_bypass_2_bits_data;	// register-read.scala:71:29
    else if (io_bypass_3_valid & rrd_uops_5_REG_prs1 == io_bypass_3_bits_uop_pdst & _GEN_7
             & _GEN_8 & _GEN_21 & (|rrd_uops_5_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_5 <= io_bypass_3_bits_data;	// register-read.scala:71:29
    else if (io_bypass_4_valid & rrd_uops_5_REG_prs1 == io_bypass_4_bits_uop_pdst & _GEN_9
             & _GEN_10 & _GEN_21 & (|rrd_uops_5_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_5 <= io_bypass_4_bits_data;	// register-read.scala:71:29
    else if (io_bypass_5_valid & rrd_uops_5_REG_prs1 == io_bypass_5_bits_uop_pdst
             & _GEN_11 & _GEN_12 & _GEN_21 & (|rrd_uops_5_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_5 <= io_bypass_5_bits_data;	// register-read.scala:71:29
    else if (rrd_rs1_data_5_REG)	// register-read.scala:124:57
      exe_reg_rs1_data_5 <= 64'h0;	// register-read.scala:71:29
    else	// register-read.scala:124:57
      exe_reg_rs1_data_5 <= io_rf_read_ports_10_data;	// register-read.scala:71:29
    if (io_bypass_0_valid & rrd_uops_0_REG_prs2 == io_bypass_0_bits_uop_pdst & _GEN
        & _GEN_0 & _GEN_2 & (|rrd_uops_0_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_0 <= io_bypass_0_bits_data;	// register-read.scala:72:29
    else if (io_bypass_1_valid & rrd_uops_0_REG_prs2 == io_bypass_1_bits_uop_pdst & _GEN_3
             & _GEN_4 & _GEN_2 & (|rrd_uops_0_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_0 <= io_bypass_1_bits_data;	// register-read.scala:72:29
    else if (io_bypass_2_valid & rrd_uops_0_REG_prs2 == io_bypass_2_bits_uop_pdst & _GEN_5
             & _GEN_6 & _GEN_2 & (|rrd_uops_0_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_0 <= io_bypass_2_bits_data;	// register-read.scala:72:29
    else if (io_bypass_3_valid & rrd_uops_0_REG_prs2 == io_bypass_3_bits_uop_pdst & _GEN_7
             & _GEN_8 & _GEN_2 & (|rrd_uops_0_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_0 <= io_bypass_3_bits_data;	// register-read.scala:72:29
    else if (io_bypass_4_valid & rrd_uops_0_REG_prs2 == io_bypass_4_bits_uop_pdst & _GEN_9
             & _GEN_10 & _GEN_2 & (|rrd_uops_0_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_0 <= io_bypass_4_bits_data;	// register-read.scala:72:29
    else if (io_bypass_5_valid & rrd_uops_0_REG_prs2 == io_bypass_5_bits_uop_pdst
             & _GEN_11 & _GEN_12 & _GEN_2 & (|rrd_uops_0_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_0 <= io_bypass_5_bits_data;	// register-read.scala:72:29
    else if (rrd_rs2_data_0_REG)	// register-read.scala:125:57
      exe_reg_rs2_data_0 <= 64'h0;	// register-read.scala:72:29
    else	// register-read.scala:125:57
      exe_reg_rs2_data_0 <= io_rf_read_ports_1_data;	// register-read.scala:72:29
    if (io_bypass_0_valid & rrd_uops_1_REG_prs2 == io_bypass_0_bits_uop_pdst & _GEN
        & _GEN_0 & _GEN_14 & (|rrd_uops_1_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_1 <= io_bypass_0_bits_data;	// register-read.scala:72:29
    else if (io_bypass_1_valid & rrd_uops_1_REG_prs2 == io_bypass_1_bits_uop_pdst & _GEN_3
             & _GEN_4 & _GEN_14 & (|rrd_uops_1_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_1 <= io_bypass_1_bits_data;	// register-read.scala:72:29
    else if (io_bypass_2_valid & rrd_uops_1_REG_prs2 == io_bypass_2_bits_uop_pdst & _GEN_5
             & _GEN_6 & _GEN_14 & (|rrd_uops_1_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_1 <= io_bypass_2_bits_data;	// register-read.scala:72:29
    else if (io_bypass_3_valid & rrd_uops_1_REG_prs2 == io_bypass_3_bits_uop_pdst & _GEN_7
             & _GEN_8 & _GEN_14 & (|rrd_uops_1_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_1 <= io_bypass_3_bits_data;	// register-read.scala:72:29
    else if (io_bypass_4_valid & rrd_uops_1_REG_prs2 == io_bypass_4_bits_uop_pdst & _GEN_9
             & _GEN_10 & _GEN_14 & (|rrd_uops_1_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_1 <= io_bypass_4_bits_data;	// register-read.scala:72:29
    else if (io_bypass_5_valid & rrd_uops_1_REG_prs2 == io_bypass_5_bits_uop_pdst
             & _GEN_11 & _GEN_12 & _GEN_14 & (|rrd_uops_1_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_1 <= io_bypass_5_bits_data;	// register-read.scala:72:29
    else if (rrd_rs2_data_1_REG)	// register-read.scala:125:57
      exe_reg_rs2_data_1 <= 64'h0;	// register-read.scala:72:29
    else	// register-read.scala:125:57
      exe_reg_rs2_data_1 <= io_rf_read_ports_3_data;	// register-read.scala:72:29
    if (io_bypass_0_valid & rrd_uops_2_REG_prs2 == io_bypass_0_bits_uop_pdst & _GEN
        & _GEN_0 & _GEN_16 & (|rrd_uops_2_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_2 <= io_bypass_0_bits_data;	// register-read.scala:72:29
    else if (io_bypass_1_valid & rrd_uops_2_REG_prs2 == io_bypass_1_bits_uop_pdst & _GEN_3
             & _GEN_4 & _GEN_16 & (|rrd_uops_2_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_2 <= io_bypass_1_bits_data;	// register-read.scala:72:29
    else if (io_bypass_2_valid & rrd_uops_2_REG_prs2 == io_bypass_2_bits_uop_pdst & _GEN_5
             & _GEN_6 & _GEN_16 & (|rrd_uops_2_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_2 <= io_bypass_2_bits_data;	// register-read.scala:72:29
    else if (io_bypass_3_valid & rrd_uops_2_REG_prs2 == io_bypass_3_bits_uop_pdst & _GEN_7
             & _GEN_8 & _GEN_16 & (|rrd_uops_2_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_2 <= io_bypass_3_bits_data;	// register-read.scala:72:29
    else if (io_bypass_4_valid & rrd_uops_2_REG_prs2 == io_bypass_4_bits_uop_pdst & _GEN_9
             & _GEN_10 & _GEN_16 & (|rrd_uops_2_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_2 <= io_bypass_4_bits_data;	// register-read.scala:72:29
    else if (io_bypass_5_valid & rrd_uops_2_REG_prs2 == io_bypass_5_bits_uop_pdst
             & _GEN_11 & _GEN_12 & _GEN_16 & (|rrd_uops_2_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_2 <= io_bypass_5_bits_data;	// register-read.scala:72:29
    else if (rrd_rs2_data_2_REG)	// register-read.scala:125:57
      exe_reg_rs2_data_2 <= 64'h0;	// register-read.scala:72:29
    else	// register-read.scala:125:57
      exe_reg_rs2_data_2 <= io_rf_read_ports_5_data;	// register-read.scala:72:29
    if (io_bypass_0_valid & rrd_uops_3_REG_prs2 == io_bypass_0_bits_uop_pdst & _GEN
        & _GEN_0 & _GEN_18 & (|rrd_uops_3_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_3 <= io_bypass_0_bits_data;	// register-read.scala:72:29
    else if (io_bypass_1_valid & rrd_uops_3_REG_prs2 == io_bypass_1_bits_uop_pdst & _GEN_3
             & _GEN_4 & _GEN_18 & (|rrd_uops_3_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_3 <= io_bypass_1_bits_data;	// register-read.scala:72:29
    else if (io_bypass_2_valid & rrd_uops_3_REG_prs2 == io_bypass_2_bits_uop_pdst & _GEN_5
             & _GEN_6 & _GEN_18 & (|rrd_uops_3_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_3 <= io_bypass_2_bits_data;	// register-read.scala:72:29
    else if (io_bypass_3_valid & rrd_uops_3_REG_prs2 == io_bypass_3_bits_uop_pdst & _GEN_7
             & _GEN_8 & _GEN_18 & (|rrd_uops_3_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_3 <= io_bypass_3_bits_data;	// register-read.scala:72:29
    else if (io_bypass_4_valid & rrd_uops_3_REG_prs2 == io_bypass_4_bits_uop_pdst & _GEN_9
             & _GEN_10 & _GEN_18 & (|rrd_uops_3_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_3 <= io_bypass_4_bits_data;	// register-read.scala:72:29
    else if (io_bypass_5_valid & rrd_uops_3_REG_prs2 == io_bypass_5_bits_uop_pdst
             & _GEN_11 & _GEN_12 & _GEN_18 & (|rrd_uops_3_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_3 <= io_bypass_5_bits_data;	// register-read.scala:72:29
    else if (rrd_rs2_data_3_REG)	// register-read.scala:125:57
      exe_reg_rs2_data_3 <= 64'h0;	// register-read.scala:72:29
    else	// register-read.scala:125:57
      exe_reg_rs2_data_3 <= io_rf_read_ports_7_data;	// register-read.scala:72:29
    if (io_bypass_0_valid & rrd_uops_4_REG_prs2 == io_bypass_0_bits_uop_pdst & _GEN
        & _GEN_0 & _GEN_20 & (|rrd_uops_4_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_4 <= io_bypass_0_bits_data;	// register-read.scala:72:29
    else if (io_bypass_1_valid & rrd_uops_4_REG_prs2 == io_bypass_1_bits_uop_pdst & _GEN_3
             & _GEN_4 & _GEN_20 & (|rrd_uops_4_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_4 <= io_bypass_1_bits_data;	// register-read.scala:72:29
    else if (io_bypass_2_valid & rrd_uops_4_REG_prs2 == io_bypass_2_bits_uop_pdst & _GEN_5
             & _GEN_6 & _GEN_20 & (|rrd_uops_4_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_4 <= io_bypass_2_bits_data;	// register-read.scala:72:29
    else if (io_bypass_3_valid & rrd_uops_4_REG_prs2 == io_bypass_3_bits_uop_pdst & _GEN_7
             & _GEN_8 & _GEN_20 & (|rrd_uops_4_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_4 <= io_bypass_3_bits_data;	// register-read.scala:72:29
    else if (io_bypass_4_valid & rrd_uops_4_REG_prs2 == io_bypass_4_bits_uop_pdst & _GEN_9
             & _GEN_10 & _GEN_20 & (|rrd_uops_4_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_4 <= io_bypass_4_bits_data;	// register-read.scala:72:29
    else if (io_bypass_5_valid & rrd_uops_4_REG_prs2 == io_bypass_5_bits_uop_pdst
             & _GEN_11 & _GEN_12 & _GEN_20 & (|rrd_uops_4_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_4 <= io_bypass_5_bits_data;	// register-read.scala:72:29
    else if (rrd_rs2_data_4_REG)	// register-read.scala:125:57
      exe_reg_rs2_data_4 <= 64'h0;	// register-read.scala:72:29
    else	// register-read.scala:125:57
      exe_reg_rs2_data_4 <= io_rf_read_ports_9_data;	// register-read.scala:72:29
    if (io_bypass_0_valid & rrd_uops_5_REG_prs2 == io_bypass_0_bits_uop_pdst & _GEN
        & _GEN_0 & _GEN_22 & (|rrd_uops_5_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_5 <= io_bypass_0_bits_data;	// register-read.scala:72:29
    else if (io_bypass_1_valid & rrd_uops_5_REG_prs2 == io_bypass_1_bits_uop_pdst & _GEN_3
             & _GEN_4 & _GEN_22 & (|rrd_uops_5_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_5 <= io_bypass_1_bits_data;	// register-read.scala:72:29
    else if (io_bypass_2_valid & rrd_uops_5_REG_prs2 == io_bypass_2_bits_uop_pdst & _GEN_5
             & _GEN_6 & _GEN_22 & (|rrd_uops_5_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_5 <= io_bypass_2_bits_data;	// register-read.scala:72:29
    else if (io_bypass_3_valid & rrd_uops_5_REG_prs2 == io_bypass_3_bits_uop_pdst & _GEN_7
             & _GEN_8 & _GEN_22 & (|rrd_uops_5_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_5 <= io_bypass_3_bits_data;	// register-read.scala:72:29
    else if (io_bypass_4_valid & rrd_uops_5_REG_prs2 == io_bypass_4_bits_uop_pdst & _GEN_9
             & _GEN_10 & _GEN_22 & (|rrd_uops_5_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_5 <= io_bypass_4_bits_data;	// register-read.scala:72:29
    else if (io_bypass_5_valid & rrd_uops_5_REG_prs2 == io_bypass_5_bits_uop_pdst
             & _GEN_11 & _GEN_12 & _GEN_22 & (|rrd_uops_5_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_5 <= io_bypass_5_bits_data;	// register-read.scala:72:29
    else if (rrd_rs2_data_5_REG)	// register-read.scala:125:57
      exe_reg_rs2_data_5 <= 64'h0;	// register-read.scala:72:29
    else	// register-read.scala:125:57
      exe_reg_rs2_data_5 <= io_rf_read_ports_11_data;	// register-read.scala:72:29
    rrd_valids_0_REG <=
      io_iss_valids_0 & (io_brupdate_b1_mispredict_mask & io_iss_uops_0_br_mask) == 20'h0;	// consts.scala:270:20, register-read.scala:84:{29,59}, util.scala:118:{51,59}
    rrd_uops_0_REG_uopc <= io_iss_uops_0_uopc;	// register-read.scala:86:29
    rrd_uops_0_REG_inst <= io_iss_uops_0_inst;	// register-read.scala:86:29
    rrd_uops_0_REG_debug_inst <= io_iss_uops_0_debug_inst;	// register-read.scala:86:29
    rrd_uops_0_REG_is_rvc <= io_iss_uops_0_is_rvc;	// register-read.scala:86:29
    rrd_uops_0_REG_debug_pc <= io_iss_uops_0_debug_pc;	// register-read.scala:86:29
    rrd_uops_0_REG_iq_type <= io_iss_uops_0_iq_type;	// register-read.scala:86:29
    rrd_uops_0_REG_fu_code <= io_iss_uops_0_fu_code;	// register-read.scala:86:29
    rrd_uops_0_REG_ctrl_br_type <= _rrd_decode_unit_io_rrd_uop_ctrl_br_type;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_ctrl_op1_sel <= _rrd_decode_unit_io_rrd_uop_ctrl_op1_sel;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_ctrl_op2_sel <= _rrd_decode_unit_io_rrd_uop_ctrl_op2_sel;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_ctrl_imm_sel <= _rrd_decode_unit_io_rrd_uop_ctrl_imm_sel;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_ctrl_op_fcn <= _rrd_decode_unit_io_rrd_uop_ctrl_op_fcn;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_ctrl_fcn_dw <= _rrd_decode_unit_io_rrd_uop_ctrl_fcn_dw;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_ctrl_is_load <= _rrd_decode_unit_io_rrd_uop_ctrl_is_load;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_ctrl_is_sta <= _rrd_decode_unit_io_rrd_uop_ctrl_is_sta;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_ctrl_is_std <= _rrd_decode_unit_io_rrd_uop_ctrl_is_std;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_iw_state <= io_iss_uops_0_iw_state;	// register-read.scala:86:29
    rrd_uops_0_REG_is_br <= io_iss_uops_0_is_br;	// register-read.scala:86:29
    rrd_uops_0_REG_is_jalr <= io_iss_uops_0_is_jalr;	// register-read.scala:86:29
    rrd_uops_0_REG_is_jal <= io_iss_uops_0_is_jal;	// register-read.scala:86:29
    rrd_uops_0_REG_is_sfb <= io_iss_uops_0_is_sfb;	// register-read.scala:86:29
    rrd_uops_0_REG_br_mask <= io_iss_uops_0_br_mask & ~io_brupdate_b1_resolve_mask;	// register-read.scala:86:29, util.scala:74:{35,37}
    rrd_uops_0_REG_br_tag <= io_iss_uops_0_br_tag;	// register-read.scala:86:29
    rrd_uops_0_REG_ftq_idx <= io_iss_uops_0_ftq_idx;	// register-read.scala:86:29
    rrd_uops_0_REG_edge_inst <= io_iss_uops_0_edge_inst;	// register-read.scala:86:29
    rrd_uops_0_REG_pc_lob <= io_iss_uops_0_pc_lob;	// register-read.scala:86:29
    rrd_uops_0_REG_taken <= io_iss_uops_0_taken;	// register-read.scala:86:29
    rrd_uops_0_REG_imm_packed <= _rrd_decode_unit_io_rrd_uop_imm_packed;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_csr_addr <= io_iss_uops_0_csr_addr;	// register-read.scala:86:29
    rrd_uops_0_REG_rob_idx <= io_iss_uops_0_rob_idx;	// register-read.scala:86:29
    rrd_uops_0_REG_ldq_idx <= io_iss_uops_0_ldq_idx;	// register-read.scala:86:29
    rrd_uops_0_REG_stq_idx <= io_iss_uops_0_stq_idx;	// register-read.scala:86:29
    rrd_uops_0_REG_rxq_idx <= io_iss_uops_0_rxq_idx;	// register-read.scala:86:29
    rrd_uops_0_REG_pdst <= io_iss_uops_0_pdst;	// register-read.scala:86:29
    rrd_uops_0_REG_prs1 <= io_iss_uops_0_prs1;	// register-read.scala:86:29
    rrd_uops_0_REG_prs2 <= io_iss_uops_0_prs2;	// register-read.scala:86:29
    rrd_uops_0_REG_prs3 <= io_iss_uops_0_prs3;	// register-read.scala:86:29
    rrd_uops_0_REG_ppred <= io_iss_uops_0_ppred;	// register-read.scala:86:29
    rrd_uops_0_REG_prs1_busy <= io_iss_uops_0_prs1_busy;	// register-read.scala:86:29
    rrd_uops_0_REG_prs2_busy <= io_iss_uops_0_prs2_busy;	// register-read.scala:86:29
    rrd_uops_0_REG_prs3_busy <= io_iss_uops_0_prs3_busy;	// register-read.scala:86:29
    rrd_uops_0_REG_ppred_busy <= io_iss_uops_0_ppred_busy;	// register-read.scala:86:29
    rrd_uops_0_REG_stale_pdst <= io_iss_uops_0_stale_pdst;	// register-read.scala:86:29
    rrd_uops_0_REG_exception <= io_iss_uops_0_exception;	// register-read.scala:86:29
    rrd_uops_0_REG_exc_cause <= io_iss_uops_0_exc_cause;	// register-read.scala:86:29
    rrd_uops_0_REG_bypassable <= io_iss_uops_0_bypassable;	// register-read.scala:86:29
    rrd_uops_0_REG_mem_cmd <= io_iss_uops_0_mem_cmd;	// register-read.scala:86:29
    rrd_uops_0_REG_mem_size <= io_iss_uops_0_mem_size;	// register-read.scala:86:29
    rrd_uops_0_REG_mem_signed <= io_iss_uops_0_mem_signed;	// register-read.scala:86:29
    rrd_uops_0_REG_is_fence <= io_iss_uops_0_is_fence;	// register-read.scala:86:29
    rrd_uops_0_REG_is_fencei <= io_iss_uops_0_is_fencei;	// register-read.scala:86:29
    rrd_uops_0_REG_is_amo <= io_iss_uops_0_is_amo;	// register-read.scala:86:29
    rrd_uops_0_REG_uses_ldq <= io_iss_uops_0_uses_ldq;	// register-read.scala:86:29
    rrd_uops_0_REG_uses_stq <= io_iss_uops_0_uses_stq;	// register-read.scala:86:29
    rrd_uops_0_REG_is_sys_pc2epc <= io_iss_uops_0_is_sys_pc2epc;	// register-read.scala:86:29
    rrd_uops_0_REG_is_unique <= io_iss_uops_0_is_unique;	// register-read.scala:86:29
    rrd_uops_0_REG_flush_on_commit <= io_iss_uops_0_flush_on_commit;	// register-read.scala:86:29
    rrd_uops_0_REG_ldst_is_rs1 <= io_iss_uops_0_ldst_is_rs1;	// register-read.scala:86:29
    rrd_uops_0_REG_ldst <= io_iss_uops_0_ldst;	// register-read.scala:86:29
    rrd_uops_0_REG_lrs1 <= io_iss_uops_0_lrs1;	// register-read.scala:86:29
    rrd_uops_0_REG_lrs2 <= io_iss_uops_0_lrs2;	// register-read.scala:86:29
    rrd_uops_0_REG_lrs3 <= io_iss_uops_0_lrs3;	// register-read.scala:86:29
    rrd_uops_0_REG_ldst_val <= io_iss_uops_0_ldst_val;	// register-read.scala:86:29
    rrd_uops_0_REG_dst_rtype <= io_iss_uops_0_dst_rtype;	// register-read.scala:86:29
    rrd_uops_0_REG_lrs1_rtype <= io_iss_uops_0_lrs1_rtype;	// register-read.scala:86:29
    rrd_uops_0_REG_lrs2_rtype <= io_iss_uops_0_lrs2_rtype;	// register-read.scala:86:29
    rrd_uops_0_REG_frs3_en <= io_iss_uops_0_frs3_en;	// register-read.scala:86:29
    rrd_uops_0_REG_fp_val <= io_iss_uops_0_fp_val;	// register-read.scala:86:29
    rrd_uops_0_REG_fp_single <= io_iss_uops_0_fp_single;	// register-read.scala:86:29
    rrd_uops_0_REG_xcpt_pf_if <= io_iss_uops_0_xcpt_pf_if;	// register-read.scala:86:29
    rrd_uops_0_REG_xcpt_ae_if <= io_iss_uops_0_xcpt_ae_if;	// register-read.scala:86:29
    rrd_uops_0_REG_xcpt_ma_if <= io_iss_uops_0_xcpt_ma_if;	// register-read.scala:86:29
    rrd_uops_0_REG_bp_debug_if <= io_iss_uops_0_bp_debug_if;	// register-read.scala:86:29
    rrd_uops_0_REG_bp_xcpt_if <= io_iss_uops_0_bp_xcpt_if;	// register-read.scala:86:29
    rrd_uops_0_REG_debug_fsrc <= io_iss_uops_0_debug_fsrc;	// register-read.scala:86:29
    rrd_uops_0_REG_debug_tsrc <= io_iss_uops_0_debug_tsrc;	// register-read.scala:86:29
    rrd_valids_1_REG <=
      io_iss_valids_1 & (io_brupdate_b1_mispredict_mask & io_iss_uops_1_br_mask) == 20'h0;	// consts.scala:270:20, register-read.scala:84:{29,59}, util.scala:118:{51,59}
    rrd_uops_1_REG_uopc <= io_iss_uops_1_uopc;	// register-read.scala:86:29
    rrd_uops_1_REG_inst <= io_iss_uops_1_inst;	// register-read.scala:86:29
    rrd_uops_1_REG_debug_inst <= io_iss_uops_1_debug_inst;	// register-read.scala:86:29
    rrd_uops_1_REG_is_rvc <= io_iss_uops_1_is_rvc;	// register-read.scala:86:29
    rrd_uops_1_REG_debug_pc <= io_iss_uops_1_debug_pc;	// register-read.scala:86:29
    rrd_uops_1_REG_iq_type <= io_iss_uops_1_iq_type;	// register-read.scala:86:29
    rrd_uops_1_REG_fu_code <= io_iss_uops_1_fu_code;	// register-read.scala:86:29
    rrd_uops_1_REG_ctrl_br_type <= _rrd_decode_unit_1_io_rrd_uop_ctrl_br_type;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_ctrl_op1_sel <= _rrd_decode_unit_1_io_rrd_uop_ctrl_op1_sel;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_ctrl_op2_sel <= _rrd_decode_unit_1_io_rrd_uop_ctrl_op2_sel;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_ctrl_imm_sel <= _rrd_decode_unit_1_io_rrd_uop_ctrl_imm_sel;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_ctrl_op_fcn <= _rrd_decode_unit_1_io_rrd_uop_ctrl_op_fcn;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_ctrl_fcn_dw <= _rrd_decode_unit_1_io_rrd_uop_ctrl_fcn_dw;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_ctrl_is_load <= _rrd_decode_unit_1_io_rrd_uop_ctrl_is_load;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_ctrl_is_sta <= _rrd_decode_unit_1_io_rrd_uop_ctrl_is_sta;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_ctrl_is_std <= _rrd_decode_unit_1_io_rrd_uop_ctrl_is_std;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_iw_state <= io_iss_uops_1_iw_state;	// register-read.scala:86:29
    rrd_uops_1_REG_is_br <= io_iss_uops_1_is_br;	// register-read.scala:86:29
    rrd_uops_1_REG_is_jalr <= io_iss_uops_1_is_jalr;	// register-read.scala:86:29
    rrd_uops_1_REG_is_jal <= io_iss_uops_1_is_jal;	// register-read.scala:86:29
    rrd_uops_1_REG_is_sfb <= io_iss_uops_1_is_sfb;	// register-read.scala:86:29
    rrd_uops_1_REG_br_mask <= io_iss_uops_1_br_mask & ~io_brupdate_b1_resolve_mask;	// register-read.scala:86:29, util.scala:74:{35,37}
    rrd_uops_1_REG_br_tag <= io_iss_uops_1_br_tag;	// register-read.scala:86:29
    rrd_uops_1_REG_ftq_idx <= io_iss_uops_1_ftq_idx;	// register-read.scala:86:29
    rrd_uops_1_REG_edge_inst <= io_iss_uops_1_edge_inst;	// register-read.scala:86:29
    rrd_uops_1_REG_pc_lob <= io_iss_uops_1_pc_lob;	// register-read.scala:86:29
    rrd_uops_1_REG_taken <= io_iss_uops_1_taken;	// register-read.scala:86:29
    rrd_uops_1_REG_imm_packed <= _rrd_decode_unit_1_io_rrd_uop_imm_packed;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_csr_addr <= io_iss_uops_1_csr_addr;	// register-read.scala:86:29
    rrd_uops_1_REG_rob_idx <= io_iss_uops_1_rob_idx;	// register-read.scala:86:29
    rrd_uops_1_REG_ldq_idx <= io_iss_uops_1_ldq_idx;	// register-read.scala:86:29
    rrd_uops_1_REG_stq_idx <= io_iss_uops_1_stq_idx;	// register-read.scala:86:29
    rrd_uops_1_REG_rxq_idx <= io_iss_uops_1_rxq_idx;	// register-read.scala:86:29
    rrd_uops_1_REG_pdst <= io_iss_uops_1_pdst;	// register-read.scala:86:29
    rrd_uops_1_REG_prs1 <= io_iss_uops_1_prs1;	// register-read.scala:86:29
    rrd_uops_1_REG_prs2 <= io_iss_uops_1_prs2;	// register-read.scala:86:29
    rrd_uops_1_REG_prs3 <= io_iss_uops_1_prs3;	// register-read.scala:86:29
    rrd_uops_1_REG_ppred <= io_iss_uops_1_ppred;	// register-read.scala:86:29
    rrd_uops_1_REG_prs1_busy <= io_iss_uops_1_prs1_busy;	// register-read.scala:86:29
    rrd_uops_1_REG_prs2_busy <= io_iss_uops_1_prs2_busy;	// register-read.scala:86:29
    rrd_uops_1_REG_prs3_busy <= io_iss_uops_1_prs3_busy;	// register-read.scala:86:29
    rrd_uops_1_REG_ppred_busy <= io_iss_uops_1_ppred_busy;	// register-read.scala:86:29
    rrd_uops_1_REG_stale_pdst <= io_iss_uops_1_stale_pdst;	// register-read.scala:86:29
    rrd_uops_1_REG_exception <= io_iss_uops_1_exception;	// register-read.scala:86:29
    rrd_uops_1_REG_exc_cause <= io_iss_uops_1_exc_cause;	// register-read.scala:86:29
    rrd_uops_1_REG_bypassable <= io_iss_uops_1_bypassable;	// register-read.scala:86:29
    rrd_uops_1_REG_mem_cmd <= io_iss_uops_1_mem_cmd;	// register-read.scala:86:29
    rrd_uops_1_REG_mem_size <= io_iss_uops_1_mem_size;	// register-read.scala:86:29
    rrd_uops_1_REG_mem_signed <= io_iss_uops_1_mem_signed;	// register-read.scala:86:29
    rrd_uops_1_REG_is_fence <= io_iss_uops_1_is_fence;	// register-read.scala:86:29
    rrd_uops_1_REG_is_fencei <= io_iss_uops_1_is_fencei;	// register-read.scala:86:29
    rrd_uops_1_REG_is_amo <= io_iss_uops_1_is_amo;	// register-read.scala:86:29
    rrd_uops_1_REG_uses_ldq <= io_iss_uops_1_uses_ldq;	// register-read.scala:86:29
    rrd_uops_1_REG_uses_stq <= io_iss_uops_1_uses_stq;	// register-read.scala:86:29
    rrd_uops_1_REG_is_sys_pc2epc <= io_iss_uops_1_is_sys_pc2epc;	// register-read.scala:86:29
    rrd_uops_1_REG_is_unique <= io_iss_uops_1_is_unique;	// register-read.scala:86:29
    rrd_uops_1_REG_flush_on_commit <= io_iss_uops_1_flush_on_commit;	// register-read.scala:86:29
    rrd_uops_1_REG_ldst_is_rs1 <= io_iss_uops_1_ldst_is_rs1;	// register-read.scala:86:29
    rrd_uops_1_REG_ldst <= io_iss_uops_1_ldst;	// register-read.scala:86:29
    rrd_uops_1_REG_lrs1 <= io_iss_uops_1_lrs1;	// register-read.scala:86:29
    rrd_uops_1_REG_lrs2 <= io_iss_uops_1_lrs2;	// register-read.scala:86:29
    rrd_uops_1_REG_lrs3 <= io_iss_uops_1_lrs3;	// register-read.scala:86:29
    rrd_uops_1_REG_ldst_val <= io_iss_uops_1_ldst_val;	// register-read.scala:86:29
    rrd_uops_1_REG_dst_rtype <= io_iss_uops_1_dst_rtype;	// register-read.scala:86:29
    rrd_uops_1_REG_lrs1_rtype <= io_iss_uops_1_lrs1_rtype;	// register-read.scala:86:29
    rrd_uops_1_REG_lrs2_rtype <= io_iss_uops_1_lrs2_rtype;	// register-read.scala:86:29
    rrd_uops_1_REG_frs3_en <= io_iss_uops_1_frs3_en;	// register-read.scala:86:29
    rrd_uops_1_REG_fp_val <= io_iss_uops_1_fp_val;	// register-read.scala:86:29
    rrd_uops_1_REG_fp_single <= io_iss_uops_1_fp_single;	// register-read.scala:86:29
    rrd_uops_1_REG_xcpt_pf_if <= io_iss_uops_1_xcpt_pf_if;	// register-read.scala:86:29
    rrd_uops_1_REG_xcpt_ae_if <= io_iss_uops_1_xcpt_ae_if;	// register-read.scala:86:29
    rrd_uops_1_REG_xcpt_ma_if <= io_iss_uops_1_xcpt_ma_if;	// register-read.scala:86:29
    rrd_uops_1_REG_bp_debug_if <= io_iss_uops_1_bp_debug_if;	// register-read.scala:86:29
    rrd_uops_1_REG_bp_xcpt_if <= io_iss_uops_1_bp_xcpt_if;	// register-read.scala:86:29
    rrd_uops_1_REG_debug_fsrc <= io_iss_uops_1_debug_fsrc;	// register-read.scala:86:29
    rrd_uops_1_REG_debug_tsrc <= io_iss_uops_1_debug_tsrc;	// register-read.scala:86:29
    rrd_valids_2_REG <=
      io_iss_valids_2 & (io_brupdate_b1_mispredict_mask & io_iss_uops_2_br_mask) == 20'h0;	// consts.scala:270:20, register-read.scala:84:{29,59}, util.scala:118:{51,59}
    rrd_uops_2_REG_uopc <= io_iss_uops_2_uopc;	// register-read.scala:86:29
    rrd_uops_2_REG_inst <= io_iss_uops_2_inst;	// register-read.scala:86:29
    rrd_uops_2_REG_debug_inst <= io_iss_uops_2_debug_inst;	// register-read.scala:86:29
    rrd_uops_2_REG_is_rvc <= io_iss_uops_2_is_rvc;	// register-read.scala:86:29
    rrd_uops_2_REG_debug_pc <= io_iss_uops_2_debug_pc;	// register-read.scala:86:29
    rrd_uops_2_REG_iq_type <= io_iss_uops_2_iq_type;	// register-read.scala:86:29
    rrd_uops_2_REG_fu_code <= io_iss_uops_2_fu_code;	// register-read.scala:86:29
    rrd_uops_2_REG_ctrl_br_type <= _rrd_decode_unit_2_io_rrd_uop_ctrl_br_type;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_ctrl_op1_sel <= _rrd_decode_unit_2_io_rrd_uop_ctrl_op1_sel;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_ctrl_op2_sel <= _rrd_decode_unit_2_io_rrd_uop_ctrl_op2_sel;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_ctrl_imm_sel <= _rrd_decode_unit_2_io_rrd_uop_ctrl_imm_sel;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_ctrl_op_fcn <= _rrd_decode_unit_2_io_rrd_uop_ctrl_op_fcn;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_ctrl_fcn_dw <= _rrd_decode_unit_2_io_rrd_uop_ctrl_fcn_dw;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_ctrl_is_load <= _rrd_decode_unit_2_io_rrd_uop_ctrl_is_load;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_ctrl_is_sta <= _rrd_decode_unit_2_io_rrd_uop_ctrl_is_sta;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_ctrl_is_std <= _rrd_decode_unit_2_io_rrd_uop_ctrl_is_std;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_iw_state <= io_iss_uops_2_iw_state;	// register-read.scala:86:29
    rrd_uops_2_REG_is_br <= io_iss_uops_2_is_br;	// register-read.scala:86:29
    rrd_uops_2_REG_is_jalr <= io_iss_uops_2_is_jalr;	// register-read.scala:86:29
    rrd_uops_2_REG_is_jal <= io_iss_uops_2_is_jal;	// register-read.scala:86:29
    rrd_uops_2_REG_is_sfb <= io_iss_uops_2_is_sfb;	// register-read.scala:86:29
    rrd_uops_2_REG_br_mask <= io_iss_uops_2_br_mask & ~io_brupdate_b1_resolve_mask;	// register-read.scala:86:29, util.scala:74:{35,37}
    rrd_uops_2_REG_br_tag <= io_iss_uops_2_br_tag;	// register-read.scala:86:29
    rrd_uops_2_REG_ftq_idx <= io_iss_uops_2_ftq_idx;	// register-read.scala:86:29
    rrd_uops_2_REG_edge_inst <= io_iss_uops_2_edge_inst;	// register-read.scala:86:29
    rrd_uops_2_REG_pc_lob <= io_iss_uops_2_pc_lob;	// register-read.scala:86:29
    rrd_uops_2_REG_taken <= io_iss_uops_2_taken;	// register-read.scala:86:29
    rrd_uops_2_REG_imm_packed <= _rrd_decode_unit_2_io_rrd_uop_imm_packed;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_csr_addr <= io_iss_uops_2_csr_addr;	// register-read.scala:86:29
    rrd_uops_2_REG_rob_idx <= io_iss_uops_2_rob_idx;	// register-read.scala:86:29
    rrd_uops_2_REG_ldq_idx <= io_iss_uops_2_ldq_idx;	// register-read.scala:86:29
    rrd_uops_2_REG_stq_idx <= io_iss_uops_2_stq_idx;	// register-read.scala:86:29
    rrd_uops_2_REG_rxq_idx <= io_iss_uops_2_rxq_idx;	// register-read.scala:86:29
    rrd_uops_2_REG_pdst <= io_iss_uops_2_pdst;	// register-read.scala:86:29
    rrd_uops_2_REG_prs1 <= io_iss_uops_2_prs1;	// register-read.scala:86:29
    rrd_uops_2_REG_prs2 <= io_iss_uops_2_prs2;	// register-read.scala:86:29
    rrd_uops_2_REG_prs3 <= io_iss_uops_2_prs3;	// register-read.scala:86:29
    rrd_uops_2_REG_ppred <= io_iss_uops_2_ppred;	// register-read.scala:86:29
    rrd_uops_2_REG_prs1_busy <= io_iss_uops_2_prs1_busy;	// register-read.scala:86:29
    rrd_uops_2_REG_prs2_busy <= io_iss_uops_2_prs2_busy;	// register-read.scala:86:29
    rrd_uops_2_REG_prs3_busy <= io_iss_uops_2_prs3_busy;	// register-read.scala:86:29
    rrd_uops_2_REG_ppred_busy <= io_iss_uops_2_ppred_busy;	// register-read.scala:86:29
    rrd_uops_2_REG_stale_pdst <= io_iss_uops_2_stale_pdst;	// register-read.scala:86:29
    rrd_uops_2_REG_exception <= io_iss_uops_2_exception;	// register-read.scala:86:29
    rrd_uops_2_REG_exc_cause <= io_iss_uops_2_exc_cause;	// register-read.scala:86:29
    rrd_uops_2_REG_bypassable <= io_iss_uops_2_bypassable;	// register-read.scala:86:29
    rrd_uops_2_REG_mem_cmd <= io_iss_uops_2_mem_cmd;	// register-read.scala:86:29
    rrd_uops_2_REG_mem_size <= io_iss_uops_2_mem_size;	// register-read.scala:86:29
    rrd_uops_2_REG_mem_signed <= io_iss_uops_2_mem_signed;	// register-read.scala:86:29
    rrd_uops_2_REG_is_fence <= io_iss_uops_2_is_fence;	// register-read.scala:86:29
    rrd_uops_2_REG_is_fencei <= io_iss_uops_2_is_fencei;	// register-read.scala:86:29
    rrd_uops_2_REG_is_amo <= io_iss_uops_2_is_amo;	// register-read.scala:86:29
    rrd_uops_2_REG_uses_ldq <= io_iss_uops_2_uses_ldq;	// register-read.scala:86:29
    rrd_uops_2_REG_uses_stq <= io_iss_uops_2_uses_stq;	// register-read.scala:86:29
    rrd_uops_2_REG_is_sys_pc2epc <= io_iss_uops_2_is_sys_pc2epc;	// register-read.scala:86:29
    rrd_uops_2_REG_is_unique <= io_iss_uops_2_is_unique;	// register-read.scala:86:29
    rrd_uops_2_REG_flush_on_commit <= io_iss_uops_2_flush_on_commit;	// register-read.scala:86:29
    rrd_uops_2_REG_ldst_is_rs1 <= io_iss_uops_2_ldst_is_rs1;	// register-read.scala:86:29
    rrd_uops_2_REG_ldst <= io_iss_uops_2_ldst;	// register-read.scala:86:29
    rrd_uops_2_REG_lrs1 <= io_iss_uops_2_lrs1;	// register-read.scala:86:29
    rrd_uops_2_REG_lrs2 <= io_iss_uops_2_lrs2;	// register-read.scala:86:29
    rrd_uops_2_REG_lrs3 <= io_iss_uops_2_lrs3;	// register-read.scala:86:29
    rrd_uops_2_REG_ldst_val <= io_iss_uops_2_ldst_val;	// register-read.scala:86:29
    rrd_uops_2_REG_dst_rtype <= io_iss_uops_2_dst_rtype;	// register-read.scala:86:29
    rrd_uops_2_REG_lrs1_rtype <= io_iss_uops_2_lrs1_rtype;	// register-read.scala:86:29
    rrd_uops_2_REG_lrs2_rtype <= io_iss_uops_2_lrs2_rtype;	// register-read.scala:86:29
    rrd_uops_2_REG_frs3_en <= io_iss_uops_2_frs3_en;	// register-read.scala:86:29
    rrd_uops_2_REG_fp_val <= io_iss_uops_2_fp_val;	// register-read.scala:86:29
    rrd_uops_2_REG_fp_single <= io_iss_uops_2_fp_single;	// register-read.scala:86:29
    rrd_uops_2_REG_xcpt_pf_if <= io_iss_uops_2_xcpt_pf_if;	// register-read.scala:86:29
    rrd_uops_2_REG_xcpt_ae_if <= io_iss_uops_2_xcpt_ae_if;	// register-read.scala:86:29
    rrd_uops_2_REG_xcpt_ma_if <= io_iss_uops_2_xcpt_ma_if;	// register-read.scala:86:29
    rrd_uops_2_REG_bp_debug_if <= io_iss_uops_2_bp_debug_if;	// register-read.scala:86:29
    rrd_uops_2_REG_bp_xcpt_if <= io_iss_uops_2_bp_xcpt_if;	// register-read.scala:86:29
    rrd_uops_2_REG_debug_fsrc <= io_iss_uops_2_debug_fsrc;	// register-read.scala:86:29
    rrd_uops_2_REG_debug_tsrc <= io_iss_uops_2_debug_tsrc;	// register-read.scala:86:29
    rrd_valids_3_REG <=
      io_iss_valids_3 & (io_brupdate_b1_mispredict_mask & io_iss_uops_3_br_mask) == 20'h0;	// consts.scala:270:20, register-read.scala:84:{29,59}, util.scala:118:{51,59}
    rrd_uops_3_REG_uopc <= io_iss_uops_3_uopc;	// register-read.scala:86:29
    rrd_uops_3_REG_is_rvc <= io_iss_uops_3_is_rvc;	// register-read.scala:86:29
    rrd_uops_3_REG_fu_code <= io_iss_uops_3_fu_code;	// register-read.scala:86:29
    rrd_uops_3_REG_ctrl_br_type <= _rrd_decode_unit_3_io_rrd_uop_ctrl_br_type;	// register-read.scala:80:33, :86:29
    rrd_uops_3_REG_ctrl_op1_sel <= _rrd_decode_unit_3_io_rrd_uop_ctrl_op1_sel;	// register-read.scala:80:33, :86:29
    rrd_uops_3_REG_ctrl_op2_sel <= _rrd_decode_unit_3_io_rrd_uop_ctrl_op2_sel;	// register-read.scala:80:33, :86:29
    rrd_uops_3_REG_ctrl_imm_sel <= _rrd_decode_unit_3_io_rrd_uop_ctrl_imm_sel;	// register-read.scala:80:33, :86:29
    rrd_uops_3_REG_ctrl_op_fcn <= _rrd_decode_unit_3_io_rrd_uop_ctrl_op_fcn;	// register-read.scala:80:33, :86:29
    rrd_uops_3_REG_ctrl_fcn_dw <= _rrd_decode_unit_3_io_rrd_uop_ctrl_fcn_dw;	// register-read.scala:80:33, :86:29
    rrd_uops_3_REG_ctrl_csr_cmd <= _rrd_decode_unit_3_io_rrd_uop_ctrl_csr_cmd;	// register-read.scala:80:33, :86:29
    rrd_uops_3_REG_is_br <= io_iss_uops_3_is_br;	// register-read.scala:86:29
    rrd_uops_3_REG_is_jalr <= io_iss_uops_3_is_jalr;	// register-read.scala:86:29
    rrd_uops_3_REG_is_jal <= io_iss_uops_3_is_jal;	// register-read.scala:86:29
    rrd_uops_3_REG_is_sfb <= io_iss_uops_3_is_sfb;	// register-read.scala:86:29
    rrd_uops_3_REG_br_mask <= io_iss_uops_3_br_mask & ~io_brupdate_b1_resolve_mask;	// register-read.scala:86:29, util.scala:74:{35,37}
    rrd_uops_3_REG_br_tag <= io_iss_uops_3_br_tag;	// register-read.scala:86:29
    rrd_uops_3_REG_ftq_idx <= io_iss_uops_3_ftq_idx;	// register-read.scala:86:29
    rrd_uops_3_REG_edge_inst <= io_iss_uops_3_edge_inst;	// register-read.scala:86:29
    rrd_uops_3_REG_pc_lob <= io_iss_uops_3_pc_lob;	// register-read.scala:86:29
    rrd_uops_3_REG_taken <= io_iss_uops_3_taken;	// register-read.scala:86:29
    rrd_uops_3_REG_imm_packed <= _rrd_decode_unit_3_io_rrd_uop_imm_packed;	// register-read.scala:80:33, :86:29
    rrd_uops_3_REG_rob_idx <= io_iss_uops_3_rob_idx;	// register-read.scala:86:29
    rrd_uops_3_REG_ldq_idx <= io_iss_uops_3_ldq_idx;	// register-read.scala:86:29
    rrd_uops_3_REG_stq_idx <= io_iss_uops_3_stq_idx;	// register-read.scala:86:29
    rrd_uops_3_REG_pdst <= io_iss_uops_3_pdst;	// register-read.scala:86:29
    rrd_uops_3_REG_prs1 <= io_iss_uops_3_prs1;	// register-read.scala:86:29
    rrd_uops_3_REG_prs2 <= io_iss_uops_3_prs2;	// register-read.scala:86:29
    rrd_uops_3_REG_bypassable <= io_iss_uops_3_bypassable;	// register-read.scala:86:29
    rrd_uops_3_REG_is_amo <= io_iss_uops_3_is_amo;	// register-read.scala:86:29
    rrd_uops_3_REG_uses_stq <= io_iss_uops_3_uses_stq;	// register-read.scala:86:29
    rrd_uops_3_REG_dst_rtype <= io_iss_uops_3_dst_rtype;	// register-read.scala:86:29
    rrd_uops_3_REG_lrs1_rtype <= io_iss_uops_3_lrs1_rtype;	// register-read.scala:86:29
    rrd_uops_3_REG_lrs2_rtype <= io_iss_uops_3_lrs2_rtype;	// register-read.scala:86:29
    rrd_valids_4_REG <=
      io_iss_valids_4 & (io_brupdate_b1_mispredict_mask & io_iss_uops_4_br_mask) == 20'h0;	// consts.scala:270:20, register-read.scala:84:{29,59}, util.scala:118:{51,59}
    rrd_uops_4_REG_uopc <= io_iss_uops_4_uopc;	// register-read.scala:86:29
    rrd_uops_4_REG_is_rvc <= io_iss_uops_4_is_rvc;	// register-read.scala:86:29
    rrd_uops_4_REG_fu_code <= io_iss_uops_4_fu_code;	// register-read.scala:86:29
    rrd_uops_4_REG_ctrl_br_type <= _rrd_decode_unit_4_io_rrd_uop_ctrl_br_type;	// register-read.scala:80:33, :86:29
    rrd_uops_4_REG_ctrl_op1_sel <= _rrd_decode_unit_4_io_rrd_uop_ctrl_op1_sel;	// register-read.scala:80:33, :86:29
    rrd_uops_4_REG_ctrl_op2_sel <= _rrd_decode_unit_4_io_rrd_uop_ctrl_op2_sel;	// register-read.scala:80:33, :86:29
    rrd_uops_4_REG_ctrl_imm_sel <= _rrd_decode_unit_4_io_rrd_uop_ctrl_imm_sel;	// register-read.scala:80:33, :86:29
    rrd_uops_4_REG_ctrl_op_fcn <= _rrd_decode_unit_4_io_rrd_uop_ctrl_op_fcn;	// register-read.scala:80:33, :86:29
    rrd_uops_4_REG_ctrl_fcn_dw <= _rrd_decode_unit_4_io_rrd_uop_ctrl_fcn_dw;	// register-read.scala:80:33, :86:29
    rrd_uops_4_REG_is_br <= io_iss_uops_4_is_br;	// register-read.scala:86:29
    rrd_uops_4_REG_is_jalr <= io_iss_uops_4_is_jalr;	// register-read.scala:86:29
    rrd_uops_4_REG_is_jal <= io_iss_uops_4_is_jal;	// register-read.scala:86:29
    rrd_uops_4_REG_is_sfb <= io_iss_uops_4_is_sfb;	// register-read.scala:86:29
    rrd_uops_4_REG_br_mask <= io_iss_uops_4_br_mask & ~io_brupdate_b1_resolve_mask;	// register-read.scala:86:29, util.scala:74:{35,37}
    rrd_uops_4_REG_br_tag <= io_iss_uops_4_br_tag;	// register-read.scala:86:29
    rrd_uops_4_REG_ftq_idx <= io_iss_uops_4_ftq_idx;	// register-read.scala:86:29
    rrd_uops_4_REG_edge_inst <= io_iss_uops_4_edge_inst;	// register-read.scala:86:29
    rrd_uops_4_REG_pc_lob <= io_iss_uops_4_pc_lob;	// register-read.scala:86:29
    rrd_uops_4_REG_taken <= io_iss_uops_4_taken;	// register-read.scala:86:29
    rrd_uops_4_REG_imm_packed <= _rrd_decode_unit_4_io_rrd_uop_imm_packed;	// register-read.scala:80:33, :86:29
    rrd_uops_4_REG_rob_idx <= io_iss_uops_4_rob_idx;	// register-read.scala:86:29
    rrd_uops_4_REG_ldq_idx <= io_iss_uops_4_ldq_idx;	// register-read.scala:86:29
    rrd_uops_4_REG_stq_idx <= io_iss_uops_4_stq_idx;	// register-read.scala:86:29
    rrd_uops_4_REG_pdst <= io_iss_uops_4_pdst;	// register-read.scala:86:29
    rrd_uops_4_REG_prs1 <= io_iss_uops_4_prs1;	// register-read.scala:86:29
    rrd_uops_4_REG_prs2 <= io_iss_uops_4_prs2;	// register-read.scala:86:29
    rrd_uops_4_REG_bypassable <= io_iss_uops_4_bypassable;	// register-read.scala:86:29
    rrd_uops_4_REG_is_amo <= io_iss_uops_4_is_amo;	// register-read.scala:86:29
    rrd_uops_4_REG_uses_stq <= io_iss_uops_4_uses_stq;	// register-read.scala:86:29
    rrd_uops_4_REG_dst_rtype <= io_iss_uops_4_dst_rtype;	// register-read.scala:86:29
    rrd_uops_4_REG_lrs1_rtype <= io_iss_uops_4_lrs1_rtype;	// register-read.scala:86:29
    rrd_uops_4_REG_lrs2_rtype <= io_iss_uops_4_lrs2_rtype;	// register-read.scala:86:29
    rrd_valids_5_REG <=
      io_iss_valids_5 & (io_brupdate_b1_mispredict_mask & io_iss_uops_5_br_mask) == 20'h0;	// consts.scala:270:20, register-read.scala:84:{29,59}, util.scala:118:{51,59}
    rrd_uops_5_REG_uopc <= io_iss_uops_5_uopc;	// register-read.scala:86:29
    rrd_uops_5_REG_is_rvc <= io_iss_uops_5_is_rvc;	// register-read.scala:86:29
    rrd_uops_5_REG_fu_code <= io_iss_uops_5_fu_code;	// register-read.scala:86:29
    rrd_uops_5_REG_ctrl_br_type <= _rrd_decode_unit_5_io_rrd_uop_ctrl_br_type;	// register-read.scala:80:33, :86:29
    rrd_uops_5_REG_ctrl_op1_sel <= _rrd_decode_unit_5_io_rrd_uop_ctrl_op1_sel;	// register-read.scala:80:33, :86:29
    rrd_uops_5_REG_ctrl_op2_sel <= _rrd_decode_unit_5_io_rrd_uop_ctrl_op2_sel;	// register-read.scala:80:33, :86:29
    rrd_uops_5_REG_ctrl_imm_sel <= _rrd_decode_unit_5_io_rrd_uop_ctrl_imm_sel;	// register-read.scala:80:33, :86:29
    rrd_uops_5_REG_ctrl_op_fcn <= _rrd_decode_unit_5_io_rrd_uop_ctrl_op_fcn;	// register-read.scala:80:33, :86:29
    rrd_uops_5_REG_ctrl_fcn_dw <= _rrd_decode_unit_5_io_rrd_uop_ctrl_fcn_dw;	// register-read.scala:80:33, :86:29
    rrd_uops_5_REG_is_br <= io_iss_uops_5_is_br;	// register-read.scala:86:29
    rrd_uops_5_REG_is_jalr <= io_iss_uops_5_is_jalr;	// register-read.scala:86:29
    rrd_uops_5_REG_is_jal <= io_iss_uops_5_is_jal;	// register-read.scala:86:29
    rrd_uops_5_REG_is_sfb <= io_iss_uops_5_is_sfb;	// register-read.scala:86:29
    rrd_uops_5_REG_br_mask <= io_iss_uops_5_br_mask & ~io_brupdate_b1_resolve_mask;	// register-read.scala:86:29, util.scala:74:{35,37}
    rrd_uops_5_REG_br_tag <= io_iss_uops_5_br_tag;	// register-read.scala:86:29
    rrd_uops_5_REG_ftq_idx <= io_iss_uops_5_ftq_idx;	// register-read.scala:86:29
    rrd_uops_5_REG_edge_inst <= io_iss_uops_5_edge_inst;	// register-read.scala:86:29
    rrd_uops_5_REG_pc_lob <= io_iss_uops_5_pc_lob;	// register-read.scala:86:29
    rrd_uops_5_REG_taken <= io_iss_uops_5_taken;	// register-read.scala:86:29
    rrd_uops_5_REG_imm_packed <= _rrd_decode_unit_5_io_rrd_uop_imm_packed;	// register-read.scala:80:33, :86:29
    rrd_uops_5_REG_rob_idx <= io_iss_uops_5_rob_idx;	// register-read.scala:86:29
    rrd_uops_5_REG_ldq_idx <= io_iss_uops_5_ldq_idx;	// register-read.scala:86:29
    rrd_uops_5_REG_stq_idx <= io_iss_uops_5_stq_idx;	// register-read.scala:86:29
    rrd_uops_5_REG_pdst <= io_iss_uops_5_pdst;	// register-read.scala:86:29
    rrd_uops_5_REG_prs1 <= io_iss_uops_5_prs1;	// register-read.scala:86:29
    rrd_uops_5_REG_prs2 <= io_iss_uops_5_prs2;	// register-read.scala:86:29
    rrd_uops_5_REG_bypassable <= io_iss_uops_5_bypassable;	// register-read.scala:86:29
    rrd_uops_5_REG_is_amo <= io_iss_uops_5_is_amo;	// register-read.scala:86:29
    rrd_uops_5_REG_uses_stq <= io_iss_uops_5_uses_stq;	// register-read.scala:86:29
    rrd_uops_5_REG_dst_rtype <= io_iss_uops_5_dst_rtype;	// register-read.scala:86:29
    rrd_uops_5_REG_lrs1_rtype <= io_iss_uops_5_lrs1_rtype;	// register-read.scala:86:29
    rrd_uops_5_REG_lrs2_rtype <= io_iss_uops_5_lrs2_rtype;	// register-read.scala:86:29
    rrd_rs1_data_0_REG <= io_iss_uops_0_prs1 == 7'h0;	// consts.scala:270:20, register-read.scala:124:{57,67}
    rrd_rs2_data_0_REG <= io_iss_uops_0_prs2 == 7'h0;	// consts.scala:270:20, register-read.scala:125:{57,67}
    rrd_rs1_data_1_REG <= io_iss_uops_1_prs1 == 7'h0;	// consts.scala:270:20, register-read.scala:124:{57,67}
    rrd_rs2_data_1_REG <= io_iss_uops_1_prs2 == 7'h0;	// consts.scala:270:20, register-read.scala:125:{57,67}
    rrd_rs1_data_2_REG <= io_iss_uops_2_prs1 == 7'h0;	// consts.scala:270:20, register-read.scala:124:{57,67}
    rrd_rs2_data_2_REG <= io_iss_uops_2_prs2 == 7'h0;	// consts.scala:270:20, register-read.scala:125:{57,67}
    rrd_rs1_data_3_REG <= io_iss_uops_3_prs1 == 7'h0;	// consts.scala:270:20, register-read.scala:124:{57,67}
    rrd_rs2_data_3_REG <= io_iss_uops_3_prs2 == 7'h0;	// consts.scala:270:20, register-read.scala:125:{57,67}
    rrd_rs1_data_4_REG <= io_iss_uops_4_prs1 == 7'h0;	// consts.scala:270:20, register-read.scala:124:{57,67}
    rrd_rs2_data_4_REG <= io_iss_uops_4_prs2 == 7'h0;	// consts.scala:270:20, register-read.scala:125:{57,67}
    rrd_rs1_data_5_REG <= io_iss_uops_5_prs1 == 7'h0;	// consts.scala:270:20, register-read.scala:124:{57,67}
    rrd_rs2_data_5_REG <= io_iss_uops_5_prs2 == 7'h0;	// consts.scala:270:20, register-read.scala:125:{57,67}
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:193];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [7:0] i = 8'h0; i < 8'hC2; i += 8'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        exe_reg_valids_0 = _RANDOM[8'h0][0];	// register-read.scala:69:33
        exe_reg_valids_1 = _RANDOM[8'h0][1];	// register-read.scala:69:33
        exe_reg_valids_2 = _RANDOM[8'h0][2];	// register-read.scala:69:33
        exe_reg_valids_3 = _RANDOM[8'h0][3];	// register-read.scala:69:33
        exe_reg_valids_4 = _RANDOM[8'h0][4];	// register-read.scala:69:33
        exe_reg_valids_5 = _RANDOM[8'h0][5];	// register-read.scala:69:33
        exe_reg_uops_0_uopc = _RANDOM[8'h0][12:6];	// register-read.scala:69:33, :70:29
        exe_reg_uops_0_inst = {_RANDOM[8'h0][31:13], _RANDOM[8'h1][12:0]};	// register-read.scala:69:33, :70:29
        exe_reg_uops_0_debug_inst = {_RANDOM[8'h1][31:13], _RANDOM[8'h2][12:0]};	// register-read.scala:70:29
        exe_reg_uops_0_is_rvc = _RANDOM[8'h2][13];	// register-read.scala:70:29
        exe_reg_uops_0_debug_pc = {_RANDOM[8'h2][31:14], _RANDOM[8'h3][21:0]};	// register-read.scala:70:29
        exe_reg_uops_0_iq_type = _RANDOM[8'h3][24:22];	// register-read.scala:70:29
        exe_reg_uops_0_fu_code = {_RANDOM[8'h3][31:25], _RANDOM[8'h4][2:0]};	// register-read.scala:70:29
        exe_reg_uops_0_ctrl_br_type = _RANDOM[8'h4][6:3];	// register-read.scala:70:29
        exe_reg_uops_0_ctrl_op1_sel = _RANDOM[8'h4][8:7];	// register-read.scala:70:29
        exe_reg_uops_0_ctrl_op2_sel = _RANDOM[8'h4][11:9];	// register-read.scala:70:29
        exe_reg_uops_0_ctrl_imm_sel = _RANDOM[8'h4][14:12];	// register-read.scala:70:29
        exe_reg_uops_0_ctrl_op_fcn = _RANDOM[8'h4][18:15];	// register-read.scala:70:29
        exe_reg_uops_0_ctrl_fcn_dw = _RANDOM[8'h4][19];	// register-read.scala:70:29
        exe_reg_uops_0_ctrl_is_load = _RANDOM[8'h4][23];	// register-read.scala:70:29
        exe_reg_uops_0_ctrl_is_sta = _RANDOM[8'h4][24];	// register-read.scala:70:29
        exe_reg_uops_0_ctrl_is_std = _RANDOM[8'h4][25];	// register-read.scala:70:29
        exe_reg_uops_0_iw_state = _RANDOM[8'h4][27:26];	// register-read.scala:70:29
        exe_reg_uops_0_is_br = _RANDOM[8'h4][30];	// register-read.scala:70:29
        exe_reg_uops_0_is_jalr = _RANDOM[8'h4][31];	// register-read.scala:70:29
        exe_reg_uops_0_is_jal = _RANDOM[8'h5][0];	// register-read.scala:70:29
        exe_reg_uops_0_is_sfb = _RANDOM[8'h5][1];	// register-read.scala:70:29
        exe_reg_uops_0_br_mask = _RANDOM[8'h5][21:2];	// register-read.scala:70:29
        exe_reg_uops_0_br_tag = _RANDOM[8'h5][26:22];	// register-read.scala:70:29
        exe_reg_uops_0_ftq_idx = {_RANDOM[8'h5][31:27], _RANDOM[8'h6][0]};	// register-read.scala:70:29
        exe_reg_uops_0_edge_inst = _RANDOM[8'h6][1];	// register-read.scala:70:29
        exe_reg_uops_0_pc_lob = _RANDOM[8'h6][7:2];	// register-read.scala:70:29
        exe_reg_uops_0_taken = _RANDOM[8'h6][8];	// register-read.scala:70:29
        exe_reg_uops_0_imm_packed = _RANDOM[8'h6][28:9];	// register-read.scala:70:29
        exe_reg_uops_0_csr_addr = {_RANDOM[8'h6][31:29], _RANDOM[8'h7][8:0]};	// register-read.scala:70:29
        exe_reg_uops_0_rob_idx = _RANDOM[8'h7][15:9];	// register-read.scala:70:29
        exe_reg_uops_0_ldq_idx = _RANDOM[8'h7][20:16];	// register-read.scala:70:29
        exe_reg_uops_0_stq_idx = _RANDOM[8'h7][25:21];	// register-read.scala:70:29
        exe_reg_uops_0_rxq_idx = _RANDOM[8'h7][27:26];	// register-read.scala:70:29
        exe_reg_uops_0_pdst = {_RANDOM[8'h7][31:28], _RANDOM[8'h8][2:0]};	// register-read.scala:70:29
        exe_reg_uops_0_prs1 = _RANDOM[8'h8][9:3];	// register-read.scala:70:29
        exe_reg_uops_0_prs2 = _RANDOM[8'h8][16:10];	// register-read.scala:70:29
        exe_reg_uops_0_prs3 = _RANDOM[8'h8][23:17];	// register-read.scala:70:29
        exe_reg_uops_0_ppred = _RANDOM[8'h8][29:24];	// register-read.scala:70:29
        exe_reg_uops_0_prs1_busy = _RANDOM[8'h8][30];	// register-read.scala:70:29
        exe_reg_uops_0_prs2_busy = _RANDOM[8'h8][31];	// register-read.scala:70:29
        exe_reg_uops_0_prs3_busy = _RANDOM[8'h9][0];	// register-read.scala:70:29
        exe_reg_uops_0_ppred_busy = _RANDOM[8'h9][1];	// register-read.scala:70:29
        exe_reg_uops_0_stale_pdst = _RANDOM[8'h9][8:2];	// register-read.scala:70:29
        exe_reg_uops_0_exception = _RANDOM[8'h9][9];	// register-read.scala:70:29
        exe_reg_uops_0_exc_cause =
          {_RANDOM[8'h9][31:10], _RANDOM[8'hA], _RANDOM[8'hB][9:0]};	// register-read.scala:70:29
        exe_reg_uops_0_bypassable = _RANDOM[8'hB][10];	// register-read.scala:70:29
        exe_reg_uops_0_mem_cmd = _RANDOM[8'hB][15:11];	// register-read.scala:70:29
        exe_reg_uops_0_mem_size = _RANDOM[8'hB][17:16];	// register-read.scala:70:29
        exe_reg_uops_0_mem_signed = _RANDOM[8'hB][18];	// register-read.scala:70:29
        exe_reg_uops_0_is_fence = _RANDOM[8'hB][19];	// register-read.scala:70:29
        exe_reg_uops_0_is_fencei = _RANDOM[8'hB][20];	// register-read.scala:70:29
        exe_reg_uops_0_is_amo = _RANDOM[8'hB][21];	// register-read.scala:70:29
        exe_reg_uops_0_uses_ldq = _RANDOM[8'hB][22];	// register-read.scala:70:29
        exe_reg_uops_0_uses_stq = _RANDOM[8'hB][23];	// register-read.scala:70:29
        exe_reg_uops_0_is_sys_pc2epc = _RANDOM[8'hB][24];	// register-read.scala:70:29
        exe_reg_uops_0_is_unique = _RANDOM[8'hB][25];	// register-read.scala:70:29
        exe_reg_uops_0_flush_on_commit = _RANDOM[8'hB][26];	// register-read.scala:70:29
        exe_reg_uops_0_ldst_is_rs1 = _RANDOM[8'hB][27];	// register-read.scala:70:29
        exe_reg_uops_0_ldst = {_RANDOM[8'hB][31:28], _RANDOM[8'hC][1:0]};	// register-read.scala:70:29
        exe_reg_uops_0_lrs1 = _RANDOM[8'hC][7:2];	// register-read.scala:70:29
        exe_reg_uops_0_lrs2 = _RANDOM[8'hC][13:8];	// register-read.scala:70:29
        exe_reg_uops_0_lrs3 = _RANDOM[8'hC][19:14];	// register-read.scala:70:29
        exe_reg_uops_0_ldst_val = _RANDOM[8'hC][20];	// register-read.scala:70:29
        exe_reg_uops_0_dst_rtype = _RANDOM[8'hC][22:21];	// register-read.scala:70:29
        exe_reg_uops_0_lrs1_rtype = _RANDOM[8'hC][24:23];	// register-read.scala:70:29
        exe_reg_uops_0_lrs2_rtype = _RANDOM[8'hC][26:25];	// register-read.scala:70:29
        exe_reg_uops_0_frs3_en = _RANDOM[8'hC][27];	// register-read.scala:70:29
        exe_reg_uops_0_fp_val = _RANDOM[8'hC][28];	// register-read.scala:70:29
        exe_reg_uops_0_fp_single = _RANDOM[8'hC][29];	// register-read.scala:70:29
        exe_reg_uops_0_xcpt_pf_if = _RANDOM[8'hC][30];	// register-read.scala:70:29
        exe_reg_uops_0_xcpt_ae_if = _RANDOM[8'hC][31];	// register-read.scala:70:29
        exe_reg_uops_0_xcpt_ma_if = _RANDOM[8'hD][0];	// register-read.scala:70:29
        exe_reg_uops_0_bp_debug_if = _RANDOM[8'hD][1];	// register-read.scala:70:29
        exe_reg_uops_0_bp_xcpt_if = _RANDOM[8'hD][2];	// register-read.scala:70:29
        exe_reg_uops_0_debug_fsrc = _RANDOM[8'hD][4:3];	// register-read.scala:70:29
        exe_reg_uops_0_debug_tsrc = _RANDOM[8'hD][6:5];	// register-read.scala:70:29
        exe_reg_uops_1_uopc = _RANDOM[8'hD][13:7];	// register-read.scala:70:29
        exe_reg_uops_1_inst = {_RANDOM[8'hD][31:14], _RANDOM[8'hE][13:0]};	// register-read.scala:70:29
        exe_reg_uops_1_debug_inst = {_RANDOM[8'hE][31:14], _RANDOM[8'hF][13:0]};	// register-read.scala:70:29
        exe_reg_uops_1_is_rvc = _RANDOM[8'hF][14];	// register-read.scala:70:29
        exe_reg_uops_1_debug_pc = {_RANDOM[8'hF][31:15], _RANDOM[8'h10][22:0]};	// register-read.scala:70:29
        exe_reg_uops_1_iq_type = _RANDOM[8'h10][25:23];	// register-read.scala:70:29
        exe_reg_uops_1_fu_code = {_RANDOM[8'h10][31:26], _RANDOM[8'h11][3:0]};	// register-read.scala:70:29
        exe_reg_uops_1_ctrl_br_type = _RANDOM[8'h11][7:4];	// register-read.scala:70:29
        exe_reg_uops_1_ctrl_op1_sel = _RANDOM[8'h11][9:8];	// register-read.scala:70:29
        exe_reg_uops_1_ctrl_op2_sel = _RANDOM[8'h11][12:10];	// register-read.scala:70:29
        exe_reg_uops_1_ctrl_imm_sel = _RANDOM[8'h11][15:13];	// register-read.scala:70:29
        exe_reg_uops_1_ctrl_op_fcn = _RANDOM[8'h11][19:16];	// register-read.scala:70:29
        exe_reg_uops_1_ctrl_fcn_dw = _RANDOM[8'h11][20];	// register-read.scala:70:29
        exe_reg_uops_1_ctrl_is_load = _RANDOM[8'h11][24];	// register-read.scala:70:29
        exe_reg_uops_1_ctrl_is_sta = _RANDOM[8'h11][25];	// register-read.scala:70:29
        exe_reg_uops_1_ctrl_is_std = _RANDOM[8'h11][26];	// register-read.scala:70:29
        exe_reg_uops_1_iw_state = _RANDOM[8'h11][28:27];	// register-read.scala:70:29
        exe_reg_uops_1_is_br = _RANDOM[8'h11][31];	// register-read.scala:70:29
        exe_reg_uops_1_is_jalr = _RANDOM[8'h12][0];	// register-read.scala:70:29
        exe_reg_uops_1_is_jal = _RANDOM[8'h12][1];	// register-read.scala:70:29
        exe_reg_uops_1_is_sfb = _RANDOM[8'h12][2];	// register-read.scala:70:29
        exe_reg_uops_1_br_mask = _RANDOM[8'h12][22:3];	// register-read.scala:70:29
        exe_reg_uops_1_br_tag = _RANDOM[8'h12][27:23];	// register-read.scala:70:29
        exe_reg_uops_1_ftq_idx = {_RANDOM[8'h12][31:28], _RANDOM[8'h13][1:0]};	// register-read.scala:70:29
        exe_reg_uops_1_edge_inst = _RANDOM[8'h13][2];	// register-read.scala:70:29
        exe_reg_uops_1_pc_lob = _RANDOM[8'h13][8:3];	// register-read.scala:70:29
        exe_reg_uops_1_taken = _RANDOM[8'h13][9];	// register-read.scala:70:29
        exe_reg_uops_1_imm_packed = _RANDOM[8'h13][29:10];	// register-read.scala:70:29
        exe_reg_uops_1_csr_addr = {_RANDOM[8'h13][31:30], _RANDOM[8'h14][9:0]};	// register-read.scala:70:29
        exe_reg_uops_1_rob_idx = _RANDOM[8'h14][16:10];	// register-read.scala:70:29
        exe_reg_uops_1_ldq_idx = _RANDOM[8'h14][21:17];	// register-read.scala:70:29
        exe_reg_uops_1_stq_idx = _RANDOM[8'h14][26:22];	// register-read.scala:70:29
        exe_reg_uops_1_rxq_idx = _RANDOM[8'h14][28:27];	// register-read.scala:70:29
        exe_reg_uops_1_pdst = {_RANDOM[8'h14][31:29], _RANDOM[8'h15][3:0]};	// register-read.scala:70:29
        exe_reg_uops_1_prs1 = _RANDOM[8'h15][10:4];	// register-read.scala:70:29
        exe_reg_uops_1_prs2 = _RANDOM[8'h15][17:11];	// register-read.scala:70:29
        exe_reg_uops_1_prs3 = _RANDOM[8'h15][24:18];	// register-read.scala:70:29
        exe_reg_uops_1_ppred = _RANDOM[8'h15][30:25];	// register-read.scala:70:29
        exe_reg_uops_1_prs1_busy = _RANDOM[8'h15][31];	// register-read.scala:70:29
        exe_reg_uops_1_prs2_busy = _RANDOM[8'h16][0];	// register-read.scala:70:29
        exe_reg_uops_1_prs3_busy = _RANDOM[8'h16][1];	// register-read.scala:70:29
        exe_reg_uops_1_ppred_busy = _RANDOM[8'h16][2];	// register-read.scala:70:29
        exe_reg_uops_1_stale_pdst = _RANDOM[8'h16][9:3];	// register-read.scala:70:29
        exe_reg_uops_1_exception = _RANDOM[8'h16][10];	// register-read.scala:70:29
        exe_reg_uops_1_exc_cause =
          {_RANDOM[8'h16][31:11], _RANDOM[8'h17], _RANDOM[8'h18][10:0]};	// register-read.scala:70:29
        exe_reg_uops_1_bypassable = _RANDOM[8'h18][11];	// register-read.scala:70:29
        exe_reg_uops_1_mem_cmd = _RANDOM[8'h18][16:12];	// register-read.scala:70:29
        exe_reg_uops_1_mem_size = _RANDOM[8'h18][18:17];	// register-read.scala:70:29
        exe_reg_uops_1_mem_signed = _RANDOM[8'h18][19];	// register-read.scala:70:29
        exe_reg_uops_1_is_fence = _RANDOM[8'h18][20];	// register-read.scala:70:29
        exe_reg_uops_1_is_fencei = _RANDOM[8'h18][21];	// register-read.scala:70:29
        exe_reg_uops_1_is_amo = _RANDOM[8'h18][22];	// register-read.scala:70:29
        exe_reg_uops_1_uses_ldq = _RANDOM[8'h18][23];	// register-read.scala:70:29
        exe_reg_uops_1_uses_stq = _RANDOM[8'h18][24];	// register-read.scala:70:29
        exe_reg_uops_1_is_sys_pc2epc = _RANDOM[8'h18][25];	// register-read.scala:70:29
        exe_reg_uops_1_is_unique = _RANDOM[8'h18][26];	// register-read.scala:70:29
        exe_reg_uops_1_flush_on_commit = _RANDOM[8'h18][27];	// register-read.scala:70:29
        exe_reg_uops_1_ldst_is_rs1 = _RANDOM[8'h18][28];	// register-read.scala:70:29
        exe_reg_uops_1_ldst = {_RANDOM[8'h18][31:29], _RANDOM[8'h19][2:0]};	// register-read.scala:70:29
        exe_reg_uops_1_lrs1 = _RANDOM[8'h19][8:3];	// register-read.scala:70:29
        exe_reg_uops_1_lrs2 = _RANDOM[8'h19][14:9];	// register-read.scala:70:29
        exe_reg_uops_1_lrs3 = _RANDOM[8'h19][20:15];	// register-read.scala:70:29
        exe_reg_uops_1_ldst_val = _RANDOM[8'h19][21];	// register-read.scala:70:29
        exe_reg_uops_1_dst_rtype = _RANDOM[8'h19][23:22];	// register-read.scala:70:29
        exe_reg_uops_1_lrs1_rtype = _RANDOM[8'h19][25:24];	// register-read.scala:70:29
        exe_reg_uops_1_lrs2_rtype = _RANDOM[8'h19][27:26];	// register-read.scala:70:29
        exe_reg_uops_1_frs3_en = _RANDOM[8'h19][28];	// register-read.scala:70:29
        exe_reg_uops_1_fp_val = _RANDOM[8'h19][29];	// register-read.scala:70:29
        exe_reg_uops_1_fp_single = _RANDOM[8'h19][30];	// register-read.scala:70:29
        exe_reg_uops_1_xcpt_pf_if = _RANDOM[8'h19][31];	// register-read.scala:70:29
        exe_reg_uops_1_xcpt_ae_if = _RANDOM[8'h1A][0];	// register-read.scala:70:29
        exe_reg_uops_1_xcpt_ma_if = _RANDOM[8'h1A][1];	// register-read.scala:70:29
        exe_reg_uops_1_bp_debug_if = _RANDOM[8'h1A][2];	// register-read.scala:70:29
        exe_reg_uops_1_bp_xcpt_if = _RANDOM[8'h1A][3];	// register-read.scala:70:29
        exe_reg_uops_1_debug_fsrc = _RANDOM[8'h1A][5:4];	// register-read.scala:70:29
        exe_reg_uops_1_debug_tsrc = _RANDOM[8'h1A][7:6];	// register-read.scala:70:29
        exe_reg_uops_2_uopc = _RANDOM[8'h1A][14:8];	// register-read.scala:70:29
        exe_reg_uops_2_inst = {_RANDOM[8'h1A][31:15], _RANDOM[8'h1B][14:0]};	// register-read.scala:70:29
        exe_reg_uops_2_debug_inst = {_RANDOM[8'h1B][31:15], _RANDOM[8'h1C][14:0]};	// register-read.scala:70:29
        exe_reg_uops_2_is_rvc = _RANDOM[8'h1C][15];	// register-read.scala:70:29
        exe_reg_uops_2_debug_pc = {_RANDOM[8'h1C][31:16], _RANDOM[8'h1D][23:0]};	// register-read.scala:70:29
        exe_reg_uops_2_iq_type = _RANDOM[8'h1D][26:24];	// register-read.scala:70:29
        exe_reg_uops_2_fu_code = {_RANDOM[8'h1D][31:27], _RANDOM[8'h1E][4:0]};	// register-read.scala:70:29
        exe_reg_uops_2_ctrl_br_type = _RANDOM[8'h1E][8:5];	// register-read.scala:70:29
        exe_reg_uops_2_ctrl_op1_sel = _RANDOM[8'h1E][10:9];	// register-read.scala:70:29
        exe_reg_uops_2_ctrl_op2_sel = _RANDOM[8'h1E][13:11];	// register-read.scala:70:29
        exe_reg_uops_2_ctrl_imm_sel = _RANDOM[8'h1E][16:14];	// register-read.scala:70:29
        exe_reg_uops_2_ctrl_op_fcn = _RANDOM[8'h1E][20:17];	// register-read.scala:70:29
        exe_reg_uops_2_ctrl_fcn_dw = _RANDOM[8'h1E][21];	// register-read.scala:70:29
        exe_reg_uops_2_ctrl_is_load = _RANDOM[8'h1E][25];	// register-read.scala:70:29
        exe_reg_uops_2_ctrl_is_sta = _RANDOM[8'h1E][26];	// register-read.scala:70:29
        exe_reg_uops_2_ctrl_is_std = _RANDOM[8'h1E][27];	// register-read.scala:70:29
        exe_reg_uops_2_iw_state = _RANDOM[8'h1E][29:28];	// register-read.scala:70:29
        exe_reg_uops_2_is_br = _RANDOM[8'h1F][0];	// register-read.scala:70:29
        exe_reg_uops_2_is_jalr = _RANDOM[8'h1F][1];	// register-read.scala:70:29
        exe_reg_uops_2_is_jal = _RANDOM[8'h1F][2];	// register-read.scala:70:29
        exe_reg_uops_2_is_sfb = _RANDOM[8'h1F][3];	// register-read.scala:70:29
        exe_reg_uops_2_br_mask = _RANDOM[8'h1F][23:4];	// register-read.scala:70:29
        exe_reg_uops_2_br_tag = _RANDOM[8'h1F][28:24];	// register-read.scala:70:29
        exe_reg_uops_2_ftq_idx = {_RANDOM[8'h1F][31:29], _RANDOM[8'h20][2:0]};	// register-read.scala:70:29
        exe_reg_uops_2_edge_inst = _RANDOM[8'h20][3];	// register-read.scala:70:29
        exe_reg_uops_2_pc_lob = _RANDOM[8'h20][9:4];	// register-read.scala:70:29
        exe_reg_uops_2_taken = _RANDOM[8'h20][10];	// register-read.scala:70:29
        exe_reg_uops_2_imm_packed = _RANDOM[8'h20][30:11];	// register-read.scala:70:29
        exe_reg_uops_2_csr_addr = {_RANDOM[8'h20][31], _RANDOM[8'h21][10:0]};	// register-read.scala:70:29
        exe_reg_uops_2_rob_idx = _RANDOM[8'h21][17:11];	// register-read.scala:70:29
        exe_reg_uops_2_ldq_idx = _RANDOM[8'h21][22:18];	// register-read.scala:70:29
        exe_reg_uops_2_stq_idx = _RANDOM[8'h21][27:23];	// register-read.scala:70:29
        exe_reg_uops_2_rxq_idx = _RANDOM[8'h21][29:28];	// register-read.scala:70:29
        exe_reg_uops_2_pdst = {_RANDOM[8'h21][31:30], _RANDOM[8'h22][4:0]};	// register-read.scala:70:29
        exe_reg_uops_2_prs1 = _RANDOM[8'h22][11:5];	// register-read.scala:70:29
        exe_reg_uops_2_prs2 = _RANDOM[8'h22][18:12];	// register-read.scala:70:29
        exe_reg_uops_2_prs3 = _RANDOM[8'h22][25:19];	// register-read.scala:70:29
        exe_reg_uops_2_ppred = _RANDOM[8'h22][31:26];	// register-read.scala:70:29
        exe_reg_uops_2_prs1_busy = _RANDOM[8'h23][0];	// register-read.scala:70:29
        exe_reg_uops_2_prs2_busy = _RANDOM[8'h23][1];	// register-read.scala:70:29
        exe_reg_uops_2_prs3_busy = _RANDOM[8'h23][2];	// register-read.scala:70:29
        exe_reg_uops_2_ppred_busy = _RANDOM[8'h23][3];	// register-read.scala:70:29
        exe_reg_uops_2_stale_pdst = _RANDOM[8'h23][10:4];	// register-read.scala:70:29
        exe_reg_uops_2_exception = _RANDOM[8'h23][11];	// register-read.scala:70:29
        exe_reg_uops_2_exc_cause =
          {_RANDOM[8'h23][31:12], _RANDOM[8'h24], _RANDOM[8'h25][11:0]};	// register-read.scala:70:29
        exe_reg_uops_2_bypassable = _RANDOM[8'h25][12];	// register-read.scala:70:29
        exe_reg_uops_2_mem_cmd = _RANDOM[8'h25][17:13];	// register-read.scala:70:29
        exe_reg_uops_2_mem_size = _RANDOM[8'h25][19:18];	// register-read.scala:70:29
        exe_reg_uops_2_mem_signed = _RANDOM[8'h25][20];	// register-read.scala:70:29
        exe_reg_uops_2_is_fence = _RANDOM[8'h25][21];	// register-read.scala:70:29
        exe_reg_uops_2_is_fencei = _RANDOM[8'h25][22];	// register-read.scala:70:29
        exe_reg_uops_2_is_amo = _RANDOM[8'h25][23];	// register-read.scala:70:29
        exe_reg_uops_2_uses_ldq = _RANDOM[8'h25][24];	// register-read.scala:70:29
        exe_reg_uops_2_uses_stq = _RANDOM[8'h25][25];	// register-read.scala:70:29
        exe_reg_uops_2_is_sys_pc2epc = _RANDOM[8'h25][26];	// register-read.scala:70:29
        exe_reg_uops_2_is_unique = _RANDOM[8'h25][27];	// register-read.scala:70:29
        exe_reg_uops_2_flush_on_commit = _RANDOM[8'h25][28];	// register-read.scala:70:29
        exe_reg_uops_2_ldst_is_rs1 = _RANDOM[8'h25][29];	// register-read.scala:70:29
        exe_reg_uops_2_ldst = {_RANDOM[8'h25][31:30], _RANDOM[8'h26][3:0]};	// register-read.scala:70:29
        exe_reg_uops_2_lrs1 = _RANDOM[8'h26][9:4];	// register-read.scala:70:29
        exe_reg_uops_2_lrs2 = _RANDOM[8'h26][15:10];	// register-read.scala:70:29
        exe_reg_uops_2_lrs3 = _RANDOM[8'h26][21:16];	// register-read.scala:70:29
        exe_reg_uops_2_ldst_val = _RANDOM[8'h26][22];	// register-read.scala:70:29
        exe_reg_uops_2_dst_rtype = _RANDOM[8'h26][24:23];	// register-read.scala:70:29
        exe_reg_uops_2_lrs1_rtype = _RANDOM[8'h26][26:25];	// register-read.scala:70:29
        exe_reg_uops_2_lrs2_rtype = _RANDOM[8'h26][28:27];	// register-read.scala:70:29
        exe_reg_uops_2_frs3_en = _RANDOM[8'h26][29];	// register-read.scala:70:29
        exe_reg_uops_2_fp_val = _RANDOM[8'h26][30];	// register-read.scala:70:29
        exe_reg_uops_2_fp_single = _RANDOM[8'h26][31];	// register-read.scala:70:29
        exe_reg_uops_2_xcpt_pf_if = _RANDOM[8'h27][0];	// register-read.scala:70:29
        exe_reg_uops_2_xcpt_ae_if = _RANDOM[8'h27][1];	// register-read.scala:70:29
        exe_reg_uops_2_xcpt_ma_if = _RANDOM[8'h27][2];	// register-read.scala:70:29
        exe_reg_uops_2_bp_debug_if = _RANDOM[8'h27][3];	// register-read.scala:70:29
        exe_reg_uops_2_bp_xcpt_if = _RANDOM[8'h27][4];	// register-read.scala:70:29
        exe_reg_uops_2_debug_fsrc = _RANDOM[8'h27][6:5];	// register-read.scala:70:29
        exe_reg_uops_2_debug_tsrc = _RANDOM[8'h27][8:7];	// register-read.scala:70:29
        exe_reg_uops_3_uopc = _RANDOM[8'h27][15:9];	// register-read.scala:70:29
        exe_reg_uops_3_is_rvc = _RANDOM[8'h29][16];	// register-read.scala:70:29
        exe_reg_uops_3_fu_code = {_RANDOM[8'h2A][31:28], _RANDOM[8'h2B][5:0]};	// register-read.scala:70:29
        exe_reg_uops_3_ctrl_br_type = _RANDOM[8'h2B][9:6];	// register-read.scala:70:29
        exe_reg_uops_3_ctrl_op1_sel = _RANDOM[8'h2B][11:10];	// register-read.scala:70:29
        exe_reg_uops_3_ctrl_op2_sel = _RANDOM[8'h2B][14:12];	// register-read.scala:70:29
        exe_reg_uops_3_ctrl_imm_sel = _RANDOM[8'h2B][17:15];	// register-read.scala:70:29
        exe_reg_uops_3_ctrl_op_fcn = _RANDOM[8'h2B][21:18];	// register-read.scala:70:29
        exe_reg_uops_3_ctrl_fcn_dw = _RANDOM[8'h2B][22];	// register-read.scala:70:29
        exe_reg_uops_3_ctrl_csr_cmd = _RANDOM[8'h2B][25:23];	// register-read.scala:70:29
        exe_reg_uops_3_is_br = _RANDOM[8'h2C][1];	// register-read.scala:70:29
        exe_reg_uops_3_is_jalr = _RANDOM[8'h2C][2];	// register-read.scala:70:29
        exe_reg_uops_3_is_jal = _RANDOM[8'h2C][3];	// register-read.scala:70:29
        exe_reg_uops_3_is_sfb = _RANDOM[8'h2C][4];	// register-read.scala:70:29
        exe_reg_uops_3_br_mask = _RANDOM[8'h2C][24:5];	// register-read.scala:70:29
        exe_reg_uops_3_br_tag = _RANDOM[8'h2C][29:25];	// register-read.scala:70:29
        exe_reg_uops_3_ftq_idx = {_RANDOM[8'h2C][31:30], _RANDOM[8'h2D][3:0]};	// register-read.scala:70:29
        exe_reg_uops_3_edge_inst = _RANDOM[8'h2D][4];	// register-read.scala:70:29
        exe_reg_uops_3_pc_lob = _RANDOM[8'h2D][10:5];	// register-read.scala:70:29
        exe_reg_uops_3_taken = _RANDOM[8'h2D][11];	// register-read.scala:70:29
        exe_reg_uops_3_imm_packed = _RANDOM[8'h2D][31:12];	// register-read.scala:70:29
        exe_reg_uops_3_rob_idx = _RANDOM[8'h2E][18:12];	// register-read.scala:70:29
        exe_reg_uops_3_ldq_idx = _RANDOM[8'h2E][23:19];	// register-read.scala:70:29
        exe_reg_uops_3_stq_idx = _RANDOM[8'h2E][28:24];	// register-read.scala:70:29
        exe_reg_uops_3_pdst = {_RANDOM[8'h2E][31], _RANDOM[8'h2F][5:0]};	// register-read.scala:70:29
        exe_reg_uops_3_prs1 = _RANDOM[8'h2F][12:6];	// register-read.scala:70:29
        exe_reg_uops_3_bypassable = _RANDOM[8'h32][13];	// register-read.scala:70:29
        exe_reg_uops_3_is_amo = _RANDOM[8'h32][24];	// register-read.scala:70:29
        exe_reg_uops_3_uses_stq = _RANDOM[8'h32][26];	// register-read.scala:70:29
        exe_reg_uops_3_dst_rtype = _RANDOM[8'h33][25:24];	// register-read.scala:70:29
        exe_reg_uops_4_uopc = _RANDOM[8'h34][16:10];	// register-read.scala:70:29
        exe_reg_uops_4_is_rvc = _RANDOM[8'h36][17];	// register-read.scala:70:29
        exe_reg_uops_4_fu_code = {_RANDOM[8'h37][31:29], _RANDOM[8'h38][6:0]};	// register-read.scala:70:29
        exe_reg_uops_4_ctrl_br_type = _RANDOM[8'h38][10:7];	// register-read.scala:70:29
        exe_reg_uops_4_ctrl_op1_sel = _RANDOM[8'h38][12:11];	// register-read.scala:70:29
        exe_reg_uops_4_ctrl_op2_sel = _RANDOM[8'h38][15:13];	// register-read.scala:70:29
        exe_reg_uops_4_ctrl_imm_sel = _RANDOM[8'h38][18:16];	// register-read.scala:70:29
        exe_reg_uops_4_ctrl_op_fcn = _RANDOM[8'h38][22:19];	// register-read.scala:70:29
        exe_reg_uops_4_ctrl_fcn_dw = _RANDOM[8'h38][23];	// register-read.scala:70:29
        exe_reg_uops_4_is_br = _RANDOM[8'h39][2];	// register-read.scala:70:29
        exe_reg_uops_4_is_jalr = _RANDOM[8'h39][3];	// register-read.scala:70:29
        exe_reg_uops_4_is_jal = _RANDOM[8'h39][4];	// register-read.scala:70:29
        exe_reg_uops_4_is_sfb = _RANDOM[8'h39][5];	// register-read.scala:70:29
        exe_reg_uops_4_br_mask = _RANDOM[8'h39][25:6];	// register-read.scala:70:29
        exe_reg_uops_4_br_tag = _RANDOM[8'h39][30:26];	// register-read.scala:70:29
        exe_reg_uops_4_ftq_idx = {_RANDOM[8'h39][31], _RANDOM[8'h3A][4:0]};	// register-read.scala:70:29
        exe_reg_uops_4_edge_inst = _RANDOM[8'h3A][5];	// register-read.scala:70:29
        exe_reg_uops_4_pc_lob = _RANDOM[8'h3A][11:6];	// register-read.scala:70:29
        exe_reg_uops_4_taken = _RANDOM[8'h3A][12];	// register-read.scala:70:29
        exe_reg_uops_4_imm_packed = {_RANDOM[8'h3A][31:13], _RANDOM[8'h3B][0]};	// register-read.scala:70:29
        exe_reg_uops_4_rob_idx = _RANDOM[8'h3B][19:13];	// register-read.scala:70:29
        exe_reg_uops_4_ldq_idx = _RANDOM[8'h3B][24:20];	// register-read.scala:70:29
        exe_reg_uops_4_stq_idx = _RANDOM[8'h3B][29:25];	// register-read.scala:70:29
        exe_reg_uops_4_pdst = _RANDOM[8'h3C][6:0];	// register-read.scala:70:29
        exe_reg_uops_4_prs1 = _RANDOM[8'h3C][13:7];	// register-read.scala:70:29
        exe_reg_uops_4_bypassable = _RANDOM[8'h3F][14];	// register-read.scala:70:29
        exe_reg_uops_4_is_amo = _RANDOM[8'h3F][25];	// register-read.scala:70:29
        exe_reg_uops_4_uses_stq = _RANDOM[8'h3F][27];	// register-read.scala:70:29
        exe_reg_uops_4_dst_rtype = _RANDOM[8'h40][26:25];	// register-read.scala:70:29
        exe_reg_uops_5_uopc = _RANDOM[8'h41][17:11];	// register-read.scala:70:29
        exe_reg_uops_5_is_rvc = _RANDOM[8'h43][18];	// register-read.scala:70:29
        exe_reg_uops_5_fu_code = {_RANDOM[8'h44][31:30], _RANDOM[8'h45][7:0]};	// register-read.scala:70:29
        exe_reg_uops_5_ctrl_br_type = _RANDOM[8'h45][11:8];	// register-read.scala:70:29
        exe_reg_uops_5_ctrl_op1_sel = _RANDOM[8'h45][13:12];	// register-read.scala:70:29
        exe_reg_uops_5_ctrl_op2_sel = _RANDOM[8'h45][16:14];	// register-read.scala:70:29
        exe_reg_uops_5_ctrl_imm_sel = _RANDOM[8'h45][19:17];	// register-read.scala:70:29
        exe_reg_uops_5_ctrl_op_fcn = _RANDOM[8'h45][23:20];	// register-read.scala:70:29
        exe_reg_uops_5_ctrl_fcn_dw = _RANDOM[8'h45][24];	// register-read.scala:70:29
        exe_reg_uops_5_is_br = _RANDOM[8'h46][3];	// register-read.scala:70:29
        exe_reg_uops_5_is_jalr = _RANDOM[8'h46][4];	// register-read.scala:70:29
        exe_reg_uops_5_is_jal = _RANDOM[8'h46][5];	// register-read.scala:70:29
        exe_reg_uops_5_is_sfb = _RANDOM[8'h46][6];	// register-read.scala:70:29
        exe_reg_uops_5_br_mask = _RANDOM[8'h46][26:7];	// register-read.scala:70:29
        exe_reg_uops_5_br_tag = _RANDOM[8'h46][31:27];	// register-read.scala:70:29
        exe_reg_uops_5_ftq_idx = _RANDOM[8'h47][5:0];	// register-read.scala:70:29
        exe_reg_uops_5_edge_inst = _RANDOM[8'h47][6];	// register-read.scala:70:29
        exe_reg_uops_5_pc_lob = _RANDOM[8'h47][12:7];	// register-read.scala:70:29
        exe_reg_uops_5_taken = _RANDOM[8'h47][13];	// register-read.scala:70:29
        exe_reg_uops_5_imm_packed = {_RANDOM[8'h47][31:14], _RANDOM[8'h48][1:0]};	// register-read.scala:70:29
        exe_reg_uops_5_rob_idx = _RANDOM[8'h48][20:14];	// register-read.scala:70:29
        exe_reg_uops_5_ldq_idx = _RANDOM[8'h48][25:21];	// register-read.scala:70:29
        exe_reg_uops_5_stq_idx = _RANDOM[8'h48][30:26];	// register-read.scala:70:29
        exe_reg_uops_5_pdst = _RANDOM[8'h49][7:1];	// register-read.scala:70:29
        exe_reg_uops_5_prs1 = _RANDOM[8'h49][14:8];	// register-read.scala:70:29
        exe_reg_uops_5_bypassable = _RANDOM[8'h4C][15];	// register-read.scala:70:29
        exe_reg_uops_5_is_amo = _RANDOM[8'h4C][26];	// register-read.scala:70:29
        exe_reg_uops_5_uses_stq = _RANDOM[8'h4C][28];	// register-read.scala:70:29
        exe_reg_uops_5_dst_rtype = _RANDOM[8'h4D][27:26];	// register-read.scala:70:29
        exe_reg_rs1_data_0 =
          {_RANDOM[8'h4E][31:12], _RANDOM[8'h4F], _RANDOM[8'h50][11:0]};	// register-read.scala:71:29
        exe_reg_rs1_data_1 =
          {_RANDOM[8'h50][31:12], _RANDOM[8'h51], _RANDOM[8'h52][11:0]};	// register-read.scala:71:29
        exe_reg_rs1_data_2 =
          {_RANDOM[8'h52][31:12], _RANDOM[8'h53], _RANDOM[8'h54][11:0]};	// register-read.scala:71:29
        exe_reg_rs1_data_3 =
          {_RANDOM[8'h54][31:12], _RANDOM[8'h55], _RANDOM[8'h56][11:0]};	// register-read.scala:71:29
        exe_reg_rs1_data_4 =
          {_RANDOM[8'h56][31:12], _RANDOM[8'h57], _RANDOM[8'h58][11:0]};	// register-read.scala:71:29
        exe_reg_rs1_data_5 =
          {_RANDOM[8'h58][31:12], _RANDOM[8'h59], _RANDOM[8'h5A][11:0]};	// register-read.scala:71:29
        exe_reg_rs2_data_0 =
          {_RANDOM[8'h5A][31:12], _RANDOM[8'h5B], _RANDOM[8'h5C][11:0]};	// register-read.scala:71:29, :72:29
        exe_reg_rs2_data_1 =
          {_RANDOM[8'h5C][31:12], _RANDOM[8'h5D], _RANDOM[8'h5E][11:0]};	// register-read.scala:72:29
        exe_reg_rs2_data_2 =
          {_RANDOM[8'h5E][31:12], _RANDOM[8'h5F], _RANDOM[8'h60][11:0]};	// register-read.scala:72:29
        exe_reg_rs2_data_3 =
          {_RANDOM[8'h60][31:12], _RANDOM[8'h61], _RANDOM[8'h62][11:0]};	// register-read.scala:72:29
        exe_reg_rs2_data_4 =
          {_RANDOM[8'h62][31:12], _RANDOM[8'h63], _RANDOM[8'h64][11:0]};	// register-read.scala:72:29
        exe_reg_rs2_data_5 =
          {_RANDOM[8'h64][31:12], _RANDOM[8'h65], _RANDOM[8'h66][11:0]};	// register-read.scala:72:29
        rrd_valids_0_REG = _RANDOM[8'h72][18];	// register-read.scala:84:29
        rrd_uops_0_REG_uopc = _RANDOM[8'h72][25:19];	// register-read.scala:84:29, :86:29
        rrd_uops_0_REG_inst = {_RANDOM[8'h72][31:26], _RANDOM[8'h73][25:0]};	// register-read.scala:84:29, :86:29
        rrd_uops_0_REG_debug_inst = {_RANDOM[8'h73][31:26], _RANDOM[8'h74][25:0]};	// register-read.scala:86:29
        rrd_uops_0_REG_is_rvc = _RANDOM[8'h74][26];	// register-read.scala:86:29
        rrd_uops_0_REG_debug_pc =
          {_RANDOM[8'h74][31:27], _RANDOM[8'h75], _RANDOM[8'h76][2:0]};	// register-read.scala:86:29
        rrd_uops_0_REG_iq_type = _RANDOM[8'h76][5:3];	// register-read.scala:86:29
        rrd_uops_0_REG_fu_code = _RANDOM[8'h76][15:6];	// register-read.scala:86:29
        rrd_uops_0_REG_ctrl_br_type = _RANDOM[8'h76][19:16];	// register-read.scala:86:29
        rrd_uops_0_REG_ctrl_op1_sel = _RANDOM[8'h76][21:20];	// register-read.scala:86:29
        rrd_uops_0_REG_ctrl_op2_sel = _RANDOM[8'h76][24:22];	// register-read.scala:86:29
        rrd_uops_0_REG_ctrl_imm_sel = _RANDOM[8'h76][27:25];	// register-read.scala:86:29
        rrd_uops_0_REG_ctrl_op_fcn = _RANDOM[8'h76][31:28];	// register-read.scala:86:29
        rrd_uops_0_REG_ctrl_fcn_dw = _RANDOM[8'h77][0];	// register-read.scala:86:29
        rrd_uops_0_REG_ctrl_is_load = _RANDOM[8'h77][4];	// register-read.scala:86:29
        rrd_uops_0_REG_ctrl_is_sta = _RANDOM[8'h77][5];	// register-read.scala:86:29
        rrd_uops_0_REG_ctrl_is_std = _RANDOM[8'h77][6];	// register-read.scala:86:29
        rrd_uops_0_REG_iw_state = _RANDOM[8'h77][8:7];	// register-read.scala:86:29
        rrd_uops_0_REG_is_br = _RANDOM[8'h77][11];	// register-read.scala:86:29
        rrd_uops_0_REG_is_jalr = _RANDOM[8'h77][12];	// register-read.scala:86:29
        rrd_uops_0_REG_is_jal = _RANDOM[8'h77][13];	// register-read.scala:86:29
        rrd_uops_0_REG_is_sfb = _RANDOM[8'h77][14];	// register-read.scala:86:29
        rrd_uops_0_REG_br_mask = {_RANDOM[8'h77][31:15], _RANDOM[8'h78][2:0]};	// register-read.scala:86:29
        rrd_uops_0_REG_br_tag = _RANDOM[8'h78][7:3];	// register-read.scala:86:29
        rrd_uops_0_REG_ftq_idx = _RANDOM[8'h78][13:8];	// register-read.scala:86:29
        rrd_uops_0_REG_edge_inst = _RANDOM[8'h78][14];	// register-read.scala:86:29
        rrd_uops_0_REG_pc_lob = _RANDOM[8'h78][20:15];	// register-read.scala:86:29
        rrd_uops_0_REG_taken = _RANDOM[8'h78][21];	// register-read.scala:86:29
        rrd_uops_0_REG_imm_packed = {_RANDOM[8'h78][31:22], _RANDOM[8'h79][9:0]};	// register-read.scala:86:29
        rrd_uops_0_REG_csr_addr = _RANDOM[8'h79][21:10];	// register-read.scala:86:29
        rrd_uops_0_REG_rob_idx = _RANDOM[8'h79][28:22];	// register-read.scala:86:29
        rrd_uops_0_REG_ldq_idx = {_RANDOM[8'h79][31:29], _RANDOM[8'h7A][1:0]};	// register-read.scala:86:29
        rrd_uops_0_REG_stq_idx = _RANDOM[8'h7A][6:2];	// register-read.scala:86:29
        rrd_uops_0_REG_rxq_idx = _RANDOM[8'h7A][8:7];	// register-read.scala:86:29
        rrd_uops_0_REG_pdst = _RANDOM[8'h7A][15:9];	// register-read.scala:86:29
        rrd_uops_0_REG_prs1 = _RANDOM[8'h7A][22:16];	// register-read.scala:86:29
        rrd_uops_0_REG_prs2 = _RANDOM[8'h7A][29:23];	// register-read.scala:86:29
        rrd_uops_0_REG_prs3 = {_RANDOM[8'h7A][31:30], _RANDOM[8'h7B][4:0]};	// register-read.scala:86:29
        rrd_uops_0_REG_ppred = _RANDOM[8'h7B][10:5];	// register-read.scala:86:29
        rrd_uops_0_REG_prs1_busy = _RANDOM[8'h7B][11];	// register-read.scala:86:29
        rrd_uops_0_REG_prs2_busy = _RANDOM[8'h7B][12];	// register-read.scala:86:29
        rrd_uops_0_REG_prs3_busy = _RANDOM[8'h7B][13];	// register-read.scala:86:29
        rrd_uops_0_REG_ppred_busy = _RANDOM[8'h7B][14];	// register-read.scala:86:29
        rrd_uops_0_REG_stale_pdst = _RANDOM[8'h7B][21:15];	// register-read.scala:86:29
        rrd_uops_0_REG_exception = _RANDOM[8'h7B][22];	// register-read.scala:86:29
        rrd_uops_0_REG_exc_cause =
          {_RANDOM[8'h7B][31:23], _RANDOM[8'h7C], _RANDOM[8'h7D][22:0]};	// register-read.scala:86:29
        rrd_uops_0_REG_bypassable = _RANDOM[8'h7D][23];	// register-read.scala:86:29
        rrd_uops_0_REG_mem_cmd = _RANDOM[8'h7D][28:24];	// register-read.scala:86:29
        rrd_uops_0_REG_mem_size = _RANDOM[8'h7D][30:29];	// register-read.scala:86:29
        rrd_uops_0_REG_mem_signed = _RANDOM[8'h7D][31];	// register-read.scala:86:29
        rrd_uops_0_REG_is_fence = _RANDOM[8'h7E][0];	// register-read.scala:86:29
        rrd_uops_0_REG_is_fencei = _RANDOM[8'h7E][1];	// register-read.scala:86:29
        rrd_uops_0_REG_is_amo = _RANDOM[8'h7E][2];	// register-read.scala:86:29
        rrd_uops_0_REG_uses_ldq = _RANDOM[8'h7E][3];	// register-read.scala:86:29
        rrd_uops_0_REG_uses_stq = _RANDOM[8'h7E][4];	// register-read.scala:86:29
        rrd_uops_0_REG_is_sys_pc2epc = _RANDOM[8'h7E][5];	// register-read.scala:86:29
        rrd_uops_0_REG_is_unique = _RANDOM[8'h7E][6];	// register-read.scala:86:29
        rrd_uops_0_REG_flush_on_commit = _RANDOM[8'h7E][7];	// register-read.scala:86:29
        rrd_uops_0_REG_ldst_is_rs1 = _RANDOM[8'h7E][8];	// register-read.scala:86:29
        rrd_uops_0_REG_ldst = _RANDOM[8'h7E][14:9];	// register-read.scala:86:29
        rrd_uops_0_REG_lrs1 = _RANDOM[8'h7E][20:15];	// register-read.scala:86:29
        rrd_uops_0_REG_lrs2 = _RANDOM[8'h7E][26:21];	// register-read.scala:86:29
        rrd_uops_0_REG_lrs3 = {_RANDOM[8'h7E][31:27], _RANDOM[8'h7F][0]};	// register-read.scala:86:29
        rrd_uops_0_REG_ldst_val = _RANDOM[8'h7F][1];	// register-read.scala:86:29
        rrd_uops_0_REG_dst_rtype = _RANDOM[8'h7F][3:2];	// register-read.scala:86:29
        rrd_uops_0_REG_lrs1_rtype = _RANDOM[8'h7F][5:4];	// register-read.scala:86:29
        rrd_uops_0_REG_lrs2_rtype = _RANDOM[8'h7F][7:6];	// register-read.scala:86:29
        rrd_uops_0_REG_frs3_en = _RANDOM[8'h7F][8];	// register-read.scala:86:29
        rrd_uops_0_REG_fp_val = _RANDOM[8'h7F][9];	// register-read.scala:86:29
        rrd_uops_0_REG_fp_single = _RANDOM[8'h7F][10];	// register-read.scala:86:29
        rrd_uops_0_REG_xcpt_pf_if = _RANDOM[8'h7F][11];	// register-read.scala:86:29
        rrd_uops_0_REG_xcpt_ae_if = _RANDOM[8'h7F][12];	// register-read.scala:86:29
        rrd_uops_0_REG_xcpt_ma_if = _RANDOM[8'h7F][13];	// register-read.scala:86:29
        rrd_uops_0_REG_bp_debug_if = _RANDOM[8'h7F][14];	// register-read.scala:86:29
        rrd_uops_0_REG_bp_xcpt_if = _RANDOM[8'h7F][15];	// register-read.scala:86:29
        rrd_uops_0_REG_debug_fsrc = _RANDOM[8'h7F][17:16];	// register-read.scala:86:29
        rrd_uops_0_REG_debug_tsrc = _RANDOM[8'h7F][19:18];	// register-read.scala:86:29
        rrd_valids_1_REG = _RANDOM[8'h7F][20];	// register-read.scala:84:29, :86:29
        rrd_uops_1_REG_uopc = _RANDOM[8'h7F][27:21];	// register-read.scala:86:29
        rrd_uops_1_REG_inst = {_RANDOM[8'h7F][31:28], _RANDOM[8'h80][27:0]};	// register-read.scala:86:29
        rrd_uops_1_REG_debug_inst = {_RANDOM[8'h80][31:28], _RANDOM[8'h81][27:0]};	// register-read.scala:86:29
        rrd_uops_1_REG_is_rvc = _RANDOM[8'h81][28];	// register-read.scala:86:29
        rrd_uops_1_REG_debug_pc =
          {_RANDOM[8'h81][31:29], _RANDOM[8'h82], _RANDOM[8'h83][4:0]};	// register-read.scala:86:29
        rrd_uops_1_REG_iq_type = _RANDOM[8'h83][7:5];	// register-read.scala:86:29
        rrd_uops_1_REG_fu_code = _RANDOM[8'h83][17:8];	// register-read.scala:86:29
        rrd_uops_1_REG_ctrl_br_type = _RANDOM[8'h83][21:18];	// register-read.scala:86:29
        rrd_uops_1_REG_ctrl_op1_sel = _RANDOM[8'h83][23:22];	// register-read.scala:86:29
        rrd_uops_1_REG_ctrl_op2_sel = _RANDOM[8'h83][26:24];	// register-read.scala:86:29
        rrd_uops_1_REG_ctrl_imm_sel = _RANDOM[8'h83][29:27];	// register-read.scala:86:29
        rrd_uops_1_REG_ctrl_op_fcn = {_RANDOM[8'h83][31:30], _RANDOM[8'h84][1:0]};	// register-read.scala:86:29
        rrd_uops_1_REG_ctrl_fcn_dw = _RANDOM[8'h84][2];	// register-read.scala:86:29
        rrd_uops_1_REG_ctrl_is_load = _RANDOM[8'h84][6];	// register-read.scala:86:29
        rrd_uops_1_REG_ctrl_is_sta = _RANDOM[8'h84][7];	// register-read.scala:86:29
        rrd_uops_1_REG_ctrl_is_std = _RANDOM[8'h84][8];	// register-read.scala:86:29
        rrd_uops_1_REG_iw_state = _RANDOM[8'h84][10:9];	// register-read.scala:86:29
        rrd_uops_1_REG_is_br = _RANDOM[8'h84][13];	// register-read.scala:86:29
        rrd_uops_1_REG_is_jalr = _RANDOM[8'h84][14];	// register-read.scala:86:29
        rrd_uops_1_REG_is_jal = _RANDOM[8'h84][15];	// register-read.scala:86:29
        rrd_uops_1_REG_is_sfb = _RANDOM[8'h84][16];	// register-read.scala:86:29
        rrd_uops_1_REG_br_mask = {_RANDOM[8'h84][31:17], _RANDOM[8'h85][4:0]};	// register-read.scala:86:29
        rrd_uops_1_REG_br_tag = _RANDOM[8'h85][9:5];	// register-read.scala:86:29
        rrd_uops_1_REG_ftq_idx = _RANDOM[8'h85][15:10];	// register-read.scala:86:29
        rrd_uops_1_REG_edge_inst = _RANDOM[8'h85][16];	// register-read.scala:86:29
        rrd_uops_1_REG_pc_lob = _RANDOM[8'h85][22:17];	// register-read.scala:86:29
        rrd_uops_1_REG_taken = _RANDOM[8'h85][23];	// register-read.scala:86:29
        rrd_uops_1_REG_imm_packed = {_RANDOM[8'h85][31:24], _RANDOM[8'h86][11:0]};	// register-read.scala:86:29
        rrd_uops_1_REG_csr_addr = _RANDOM[8'h86][23:12];	// register-read.scala:86:29
        rrd_uops_1_REG_rob_idx = _RANDOM[8'h86][30:24];	// register-read.scala:86:29
        rrd_uops_1_REG_ldq_idx = {_RANDOM[8'h86][31], _RANDOM[8'h87][3:0]};	// register-read.scala:86:29
        rrd_uops_1_REG_stq_idx = _RANDOM[8'h87][8:4];	// register-read.scala:86:29
        rrd_uops_1_REG_rxq_idx = _RANDOM[8'h87][10:9];	// register-read.scala:86:29
        rrd_uops_1_REG_pdst = _RANDOM[8'h87][17:11];	// register-read.scala:86:29
        rrd_uops_1_REG_prs1 = _RANDOM[8'h87][24:18];	// register-read.scala:86:29
        rrd_uops_1_REG_prs2 = _RANDOM[8'h87][31:25];	// register-read.scala:86:29
        rrd_uops_1_REG_prs3 = _RANDOM[8'h88][6:0];	// register-read.scala:86:29
        rrd_uops_1_REG_ppred = _RANDOM[8'h88][12:7];	// register-read.scala:86:29
        rrd_uops_1_REG_prs1_busy = _RANDOM[8'h88][13];	// register-read.scala:86:29
        rrd_uops_1_REG_prs2_busy = _RANDOM[8'h88][14];	// register-read.scala:86:29
        rrd_uops_1_REG_prs3_busy = _RANDOM[8'h88][15];	// register-read.scala:86:29
        rrd_uops_1_REG_ppred_busy = _RANDOM[8'h88][16];	// register-read.scala:86:29
        rrd_uops_1_REG_stale_pdst = _RANDOM[8'h88][23:17];	// register-read.scala:86:29
        rrd_uops_1_REG_exception = _RANDOM[8'h88][24];	// register-read.scala:86:29
        rrd_uops_1_REG_exc_cause =
          {_RANDOM[8'h88][31:25], _RANDOM[8'h89], _RANDOM[8'h8A][24:0]};	// register-read.scala:86:29
        rrd_uops_1_REG_bypassable = _RANDOM[8'h8A][25];	// register-read.scala:86:29
        rrd_uops_1_REG_mem_cmd = _RANDOM[8'h8A][30:26];	// register-read.scala:86:29
        rrd_uops_1_REG_mem_size = {_RANDOM[8'h8A][31], _RANDOM[8'h8B][0]};	// register-read.scala:86:29
        rrd_uops_1_REG_mem_signed = _RANDOM[8'h8B][1];	// register-read.scala:86:29
        rrd_uops_1_REG_is_fence = _RANDOM[8'h8B][2];	// register-read.scala:86:29
        rrd_uops_1_REG_is_fencei = _RANDOM[8'h8B][3];	// register-read.scala:86:29
        rrd_uops_1_REG_is_amo = _RANDOM[8'h8B][4];	// register-read.scala:86:29
        rrd_uops_1_REG_uses_ldq = _RANDOM[8'h8B][5];	// register-read.scala:86:29
        rrd_uops_1_REG_uses_stq = _RANDOM[8'h8B][6];	// register-read.scala:86:29
        rrd_uops_1_REG_is_sys_pc2epc = _RANDOM[8'h8B][7];	// register-read.scala:86:29
        rrd_uops_1_REG_is_unique = _RANDOM[8'h8B][8];	// register-read.scala:86:29
        rrd_uops_1_REG_flush_on_commit = _RANDOM[8'h8B][9];	// register-read.scala:86:29
        rrd_uops_1_REG_ldst_is_rs1 = _RANDOM[8'h8B][10];	// register-read.scala:86:29
        rrd_uops_1_REG_ldst = _RANDOM[8'h8B][16:11];	// register-read.scala:86:29
        rrd_uops_1_REG_lrs1 = _RANDOM[8'h8B][22:17];	// register-read.scala:86:29
        rrd_uops_1_REG_lrs2 = _RANDOM[8'h8B][28:23];	// register-read.scala:86:29
        rrd_uops_1_REG_lrs3 = {_RANDOM[8'h8B][31:29], _RANDOM[8'h8C][2:0]};	// register-read.scala:86:29
        rrd_uops_1_REG_ldst_val = _RANDOM[8'h8C][3];	// register-read.scala:86:29
        rrd_uops_1_REG_dst_rtype = _RANDOM[8'h8C][5:4];	// register-read.scala:86:29
        rrd_uops_1_REG_lrs1_rtype = _RANDOM[8'h8C][7:6];	// register-read.scala:86:29
        rrd_uops_1_REG_lrs2_rtype = _RANDOM[8'h8C][9:8];	// register-read.scala:86:29
        rrd_uops_1_REG_frs3_en = _RANDOM[8'h8C][10];	// register-read.scala:86:29
        rrd_uops_1_REG_fp_val = _RANDOM[8'h8C][11];	// register-read.scala:86:29
        rrd_uops_1_REG_fp_single = _RANDOM[8'h8C][12];	// register-read.scala:86:29
        rrd_uops_1_REG_xcpt_pf_if = _RANDOM[8'h8C][13];	// register-read.scala:86:29
        rrd_uops_1_REG_xcpt_ae_if = _RANDOM[8'h8C][14];	// register-read.scala:86:29
        rrd_uops_1_REG_xcpt_ma_if = _RANDOM[8'h8C][15];	// register-read.scala:86:29
        rrd_uops_1_REG_bp_debug_if = _RANDOM[8'h8C][16];	// register-read.scala:86:29
        rrd_uops_1_REG_bp_xcpt_if = _RANDOM[8'h8C][17];	// register-read.scala:86:29
        rrd_uops_1_REG_debug_fsrc = _RANDOM[8'h8C][19:18];	// register-read.scala:86:29
        rrd_uops_1_REG_debug_tsrc = _RANDOM[8'h8C][21:20];	// register-read.scala:86:29
        rrd_valids_2_REG = _RANDOM[8'h8C][22];	// register-read.scala:84:29, :86:29
        rrd_uops_2_REG_uopc = _RANDOM[8'h8C][29:23];	// register-read.scala:86:29
        rrd_uops_2_REG_inst = {_RANDOM[8'h8C][31:30], _RANDOM[8'h8D][29:0]};	// register-read.scala:86:29
        rrd_uops_2_REG_debug_inst = {_RANDOM[8'h8D][31:30], _RANDOM[8'h8E][29:0]};	// register-read.scala:86:29
        rrd_uops_2_REG_is_rvc = _RANDOM[8'h8E][30];	// register-read.scala:86:29
        rrd_uops_2_REG_debug_pc =
          {_RANDOM[8'h8E][31], _RANDOM[8'h8F], _RANDOM[8'h90][6:0]};	// register-read.scala:86:29
        rrd_uops_2_REG_iq_type = _RANDOM[8'h90][9:7];	// register-read.scala:86:29
        rrd_uops_2_REG_fu_code = _RANDOM[8'h90][19:10];	// register-read.scala:86:29
        rrd_uops_2_REG_ctrl_br_type = _RANDOM[8'h90][23:20];	// register-read.scala:86:29
        rrd_uops_2_REG_ctrl_op1_sel = _RANDOM[8'h90][25:24];	// register-read.scala:86:29
        rrd_uops_2_REG_ctrl_op2_sel = _RANDOM[8'h90][28:26];	// register-read.scala:86:29
        rrd_uops_2_REG_ctrl_imm_sel = _RANDOM[8'h90][31:29];	// register-read.scala:86:29
        rrd_uops_2_REG_ctrl_op_fcn = _RANDOM[8'h91][3:0];	// register-read.scala:86:29
        rrd_uops_2_REG_ctrl_fcn_dw = _RANDOM[8'h91][4];	// register-read.scala:86:29
        rrd_uops_2_REG_ctrl_is_load = _RANDOM[8'h91][8];	// register-read.scala:86:29
        rrd_uops_2_REG_ctrl_is_sta = _RANDOM[8'h91][9];	// register-read.scala:86:29
        rrd_uops_2_REG_ctrl_is_std = _RANDOM[8'h91][10];	// register-read.scala:86:29
        rrd_uops_2_REG_iw_state = _RANDOM[8'h91][12:11];	// register-read.scala:86:29
        rrd_uops_2_REG_is_br = _RANDOM[8'h91][15];	// register-read.scala:86:29
        rrd_uops_2_REG_is_jalr = _RANDOM[8'h91][16];	// register-read.scala:86:29
        rrd_uops_2_REG_is_jal = _RANDOM[8'h91][17];	// register-read.scala:86:29
        rrd_uops_2_REG_is_sfb = _RANDOM[8'h91][18];	// register-read.scala:86:29
        rrd_uops_2_REG_br_mask = {_RANDOM[8'h91][31:19], _RANDOM[8'h92][6:0]};	// register-read.scala:86:29
        rrd_uops_2_REG_br_tag = _RANDOM[8'h92][11:7];	// register-read.scala:86:29
        rrd_uops_2_REG_ftq_idx = _RANDOM[8'h92][17:12];	// register-read.scala:86:29
        rrd_uops_2_REG_edge_inst = _RANDOM[8'h92][18];	// register-read.scala:86:29
        rrd_uops_2_REG_pc_lob = _RANDOM[8'h92][24:19];	// register-read.scala:86:29
        rrd_uops_2_REG_taken = _RANDOM[8'h92][25];	// register-read.scala:86:29
        rrd_uops_2_REG_imm_packed = {_RANDOM[8'h92][31:26], _RANDOM[8'h93][13:0]};	// register-read.scala:86:29
        rrd_uops_2_REG_csr_addr = _RANDOM[8'h93][25:14];	// register-read.scala:86:29
        rrd_uops_2_REG_rob_idx = {_RANDOM[8'h93][31:26], _RANDOM[8'h94][0]};	// register-read.scala:86:29
        rrd_uops_2_REG_ldq_idx = _RANDOM[8'h94][5:1];	// register-read.scala:86:29
        rrd_uops_2_REG_stq_idx = _RANDOM[8'h94][10:6];	// register-read.scala:86:29
        rrd_uops_2_REG_rxq_idx = _RANDOM[8'h94][12:11];	// register-read.scala:86:29
        rrd_uops_2_REG_pdst = _RANDOM[8'h94][19:13];	// register-read.scala:86:29
        rrd_uops_2_REG_prs1 = _RANDOM[8'h94][26:20];	// register-read.scala:86:29
        rrd_uops_2_REG_prs2 = {_RANDOM[8'h94][31:27], _RANDOM[8'h95][1:0]};	// register-read.scala:86:29
        rrd_uops_2_REG_prs3 = _RANDOM[8'h95][8:2];	// register-read.scala:86:29
        rrd_uops_2_REG_ppred = _RANDOM[8'h95][14:9];	// register-read.scala:86:29
        rrd_uops_2_REG_prs1_busy = _RANDOM[8'h95][15];	// register-read.scala:86:29
        rrd_uops_2_REG_prs2_busy = _RANDOM[8'h95][16];	// register-read.scala:86:29
        rrd_uops_2_REG_prs3_busy = _RANDOM[8'h95][17];	// register-read.scala:86:29
        rrd_uops_2_REG_ppred_busy = _RANDOM[8'h95][18];	// register-read.scala:86:29
        rrd_uops_2_REG_stale_pdst = _RANDOM[8'h95][25:19];	// register-read.scala:86:29
        rrd_uops_2_REG_exception = _RANDOM[8'h95][26];	// register-read.scala:86:29
        rrd_uops_2_REG_exc_cause =
          {_RANDOM[8'h95][31:27], _RANDOM[8'h96], _RANDOM[8'h97][26:0]};	// register-read.scala:86:29
        rrd_uops_2_REG_bypassable = _RANDOM[8'h97][27];	// register-read.scala:86:29
        rrd_uops_2_REG_mem_cmd = {_RANDOM[8'h97][31:28], _RANDOM[8'h98][0]};	// register-read.scala:86:29
        rrd_uops_2_REG_mem_size = _RANDOM[8'h98][2:1];	// register-read.scala:86:29
        rrd_uops_2_REG_mem_signed = _RANDOM[8'h98][3];	// register-read.scala:86:29
        rrd_uops_2_REG_is_fence = _RANDOM[8'h98][4];	// register-read.scala:86:29
        rrd_uops_2_REG_is_fencei = _RANDOM[8'h98][5];	// register-read.scala:86:29
        rrd_uops_2_REG_is_amo = _RANDOM[8'h98][6];	// register-read.scala:86:29
        rrd_uops_2_REG_uses_ldq = _RANDOM[8'h98][7];	// register-read.scala:86:29
        rrd_uops_2_REG_uses_stq = _RANDOM[8'h98][8];	// register-read.scala:86:29
        rrd_uops_2_REG_is_sys_pc2epc = _RANDOM[8'h98][9];	// register-read.scala:86:29
        rrd_uops_2_REG_is_unique = _RANDOM[8'h98][10];	// register-read.scala:86:29
        rrd_uops_2_REG_flush_on_commit = _RANDOM[8'h98][11];	// register-read.scala:86:29
        rrd_uops_2_REG_ldst_is_rs1 = _RANDOM[8'h98][12];	// register-read.scala:86:29
        rrd_uops_2_REG_ldst = _RANDOM[8'h98][18:13];	// register-read.scala:86:29
        rrd_uops_2_REG_lrs1 = _RANDOM[8'h98][24:19];	// register-read.scala:86:29
        rrd_uops_2_REG_lrs2 = _RANDOM[8'h98][30:25];	// register-read.scala:86:29
        rrd_uops_2_REG_lrs3 = {_RANDOM[8'h98][31], _RANDOM[8'h99][4:0]};	// register-read.scala:86:29
        rrd_uops_2_REG_ldst_val = _RANDOM[8'h99][5];	// register-read.scala:86:29
        rrd_uops_2_REG_dst_rtype = _RANDOM[8'h99][7:6];	// register-read.scala:86:29
        rrd_uops_2_REG_lrs1_rtype = _RANDOM[8'h99][9:8];	// register-read.scala:86:29
        rrd_uops_2_REG_lrs2_rtype = _RANDOM[8'h99][11:10];	// register-read.scala:86:29
        rrd_uops_2_REG_frs3_en = _RANDOM[8'h99][12];	// register-read.scala:86:29
        rrd_uops_2_REG_fp_val = _RANDOM[8'h99][13];	// register-read.scala:86:29
        rrd_uops_2_REG_fp_single = _RANDOM[8'h99][14];	// register-read.scala:86:29
        rrd_uops_2_REG_xcpt_pf_if = _RANDOM[8'h99][15];	// register-read.scala:86:29
        rrd_uops_2_REG_xcpt_ae_if = _RANDOM[8'h99][16];	// register-read.scala:86:29
        rrd_uops_2_REG_xcpt_ma_if = _RANDOM[8'h99][17];	// register-read.scala:86:29
        rrd_uops_2_REG_bp_debug_if = _RANDOM[8'h99][18];	// register-read.scala:86:29
        rrd_uops_2_REG_bp_xcpt_if = _RANDOM[8'h99][19];	// register-read.scala:86:29
        rrd_uops_2_REG_debug_fsrc = _RANDOM[8'h99][21:20];	// register-read.scala:86:29
        rrd_uops_2_REG_debug_tsrc = _RANDOM[8'h99][23:22];	// register-read.scala:86:29
        rrd_valids_3_REG = _RANDOM[8'h99][24];	// register-read.scala:84:29, :86:29
        rrd_uops_3_REG_uopc = _RANDOM[8'h99][31:25];	// register-read.scala:86:29
        rrd_uops_3_REG_is_rvc = _RANDOM[8'h9C][0];	// register-read.scala:86:29
        rrd_uops_3_REG_fu_code = _RANDOM[8'h9D][21:12];	// register-read.scala:86:29
        rrd_uops_3_REG_ctrl_br_type = _RANDOM[8'h9D][25:22];	// register-read.scala:86:29
        rrd_uops_3_REG_ctrl_op1_sel = _RANDOM[8'h9D][27:26];	// register-read.scala:86:29
        rrd_uops_3_REG_ctrl_op2_sel = _RANDOM[8'h9D][30:28];	// register-read.scala:86:29
        rrd_uops_3_REG_ctrl_imm_sel = {_RANDOM[8'h9D][31], _RANDOM[8'h9E][1:0]};	// register-read.scala:86:29
        rrd_uops_3_REG_ctrl_op_fcn = _RANDOM[8'h9E][5:2];	// register-read.scala:86:29
        rrd_uops_3_REG_ctrl_fcn_dw = _RANDOM[8'h9E][6];	// register-read.scala:86:29
        rrd_uops_3_REG_ctrl_csr_cmd = _RANDOM[8'h9E][9:7];	// register-read.scala:86:29
        rrd_uops_3_REG_is_br = _RANDOM[8'h9E][17];	// register-read.scala:86:29
        rrd_uops_3_REG_is_jalr = _RANDOM[8'h9E][18];	// register-read.scala:86:29
        rrd_uops_3_REG_is_jal = _RANDOM[8'h9E][19];	// register-read.scala:86:29
        rrd_uops_3_REG_is_sfb = _RANDOM[8'h9E][20];	// register-read.scala:86:29
        rrd_uops_3_REG_br_mask = {_RANDOM[8'h9E][31:21], _RANDOM[8'h9F][8:0]};	// register-read.scala:86:29
        rrd_uops_3_REG_br_tag = _RANDOM[8'h9F][13:9];	// register-read.scala:86:29
        rrd_uops_3_REG_ftq_idx = _RANDOM[8'h9F][19:14];	// register-read.scala:86:29
        rrd_uops_3_REG_edge_inst = _RANDOM[8'h9F][20];	// register-read.scala:86:29
        rrd_uops_3_REG_pc_lob = _RANDOM[8'h9F][26:21];	// register-read.scala:86:29
        rrd_uops_3_REG_taken = _RANDOM[8'h9F][27];	// register-read.scala:86:29
        rrd_uops_3_REG_imm_packed = {_RANDOM[8'h9F][31:28], _RANDOM[8'hA0][15:0]};	// register-read.scala:86:29
        rrd_uops_3_REG_rob_idx = {_RANDOM[8'hA0][31:28], _RANDOM[8'hA1][2:0]};	// register-read.scala:86:29
        rrd_uops_3_REG_ldq_idx = _RANDOM[8'hA1][7:3];	// register-read.scala:86:29
        rrd_uops_3_REG_stq_idx = _RANDOM[8'hA1][12:8];	// register-read.scala:86:29
        rrd_uops_3_REG_pdst = _RANDOM[8'hA1][21:15];	// register-read.scala:86:29
        rrd_uops_3_REG_prs1 = _RANDOM[8'hA1][28:22];	// register-read.scala:86:29
        rrd_uops_3_REG_prs2 = {_RANDOM[8'hA1][31:29], _RANDOM[8'hA2][3:0]};	// register-read.scala:86:29
        rrd_uops_3_REG_bypassable = _RANDOM[8'hA4][29];	// register-read.scala:86:29
        rrd_uops_3_REG_is_amo = _RANDOM[8'hA5][8];	// register-read.scala:86:29
        rrd_uops_3_REG_uses_stq = _RANDOM[8'hA5][10];	// register-read.scala:86:29
        rrd_uops_3_REG_dst_rtype = _RANDOM[8'hA6][9:8];	// register-read.scala:86:29
        rrd_uops_3_REG_lrs1_rtype = _RANDOM[8'hA6][11:10];	// register-read.scala:86:29
        rrd_uops_3_REG_lrs2_rtype = _RANDOM[8'hA6][13:12];	// register-read.scala:86:29
        rrd_valids_4_REG = _RANDOM[8'hA6][26];	// register-read.scala:84:29, :86:29
        rrd_uops_4_REG_uopc = {_RANDOM[8'hA6][31:27], _RANDOM[8'hA7][1:0]};	// register-read.scala:86:29
        rrd_uops_4_REG_is_rvc = _RANDOM[8'hA9][2];	// register-read.scala:86:29
        rrd_uops_4_REG_fu_code = _RANDOM[8'hAA][23:14];	// register-read.scala:86:29
        rrd_uops_4_REG_ctrl_br_type = _RANDOM[8'hAA][27:24];	// register-read.scala:86:29
        rrd_uops_4_REG_ctrl_op1_sel = _RANDOM[8'hAA][29:28];	// register-read.scala:86:29
        rrd_uops_4_REG_ctrl_op2_sel = {_RANDOM[8'hAA][31:30], _RANDOM[8'hAB][0]};	// register-read.scala:86:29
        rrd_uops_4_REG_ctrl_imm_sel = _RANDOM[8'hAB][3:1];	// register-read.scala:86:29
        rrd_uops_4_REG_ctrl_op_fcn = _RANDOM[8'hAB][7:4];	// register-read.scala:86:29
        rrd_uops_4_REG_ctrl_fcn_dw = _RANDOM[8'hAB][8];	// register-read.scala:86:29
        rrd_uops_4_REG_is_br = _RANDOM[8'hAB][19];	// register-read.scala:86:29
        rrd_uops_4_REG_is_jalr = _RANDOM[8'hAB][20];	// register-read.scala:86:29
        rrd_uops_4_REG_is_jal = _RANDOM[8'hAB][21];	// register-read.scala:86:29
        rrd_uops_4_REG_is_sfb = _RANDOM[8'hAB][22];	// register-read.scala:86:29
        rrd_uops_4_REG_br_mask = {_RANDOM[8'hAB][31:23], _RANDOM[8'hAC][10:0]};	// register-read.scala:86:29
        rrd_uops_4_REG_br_tag = _RANDOM[8'hAC][15:11];	// register-read.scala:86:29
        rrd_uops_4_REG_ftq_idx = _RANDOM[8'hAC][21:16];	// register-read.scala:86:29
        rrd_uops_4_REG_edge_inst = _RANDOM[8'hAC][22];	// register-read.scala:86:29
        rrd_uops_4_REG_pc_lob = _RANDOM[8'hAC][28:23];	// register-read.scala:86:29
        rrd_uops_4_REG_taken = _RANDOM[8'hAC][29];	// register-read.scala:86:29
        rrd_uops_4_REG_imm_packed = {_RANDOM[8'hAC][31:30], _RANDOM[8'hAD][17:0]};	// register-read.scala:86:29
        rrd_uops_4_REG_rob_idx = {_RANDOM[8'hAD][31:30], _RANDOM[8'hAE][4:0]};	// register-read.scala:86:29
        rrd_uops_4_REG_ldq_idx = _RANDOM[8'hAE][9:5];	// register-read.scala:86:29
        rrd_uops_4_REG_stq_idx = _RANDOM[8'hAE][14:10];	// register-read.scala:86:29
        rrd_uops_4_REG_pdst = _RANDOM[8'hAE][23:17];	// register-read.scala:86:29
        rrd_uops_4_REG_prs1 = _RANDOM[8'hAE][30:24];	// register-read.scala:86:29
        rrd_uops_4_REG_prs2 = {_RANDOM[8'hAE][31], _RANDOM[8'hAF][5:0]};	// register-read.scala:86:29
        rrd_uops_4_REG_bypassable = _RANDOM[8'hB1][31];	// register-read.scala:86:29
        rrd_uops_4_REG_is_amo = _RANDOM[8'hB2][10];	// register-read.scala:86:29
        rrd_uops_4_REG_uses_stq = _RANDOM[8'hB2][12];	// register-read.scala:86:29
        rrd_uops_4_REG_dst_rtype = _RANDOM[8'hB3][11:10];	// register-read.scala:86:29
        rrd_uops_4_REG_lrs1_rtype = _RANDOM[8'hB3][13:12];	// register-read.scala:86:29
        rrd_uops_4_REG_lrs2_rtype = _RANDOM[8'hB3][15:14];	// register-read.scala:86:29
        rrd_valids_5_REG = _RANDOM[8'hB3][28];	// register-read.scala:84:29, :86:29
        rrd_uops_5_REG_uopc = {_RANDOM[8'hB3][31:29], _RANDOM[8'hB4][3:0]};	// register-read.scala:86:29
        rrd_uops_5_REG_is_rvc = _RANDOM[8'hB6][4];	// register-read.scala:86:29
        rrd_uops_5_REG_fu_code = _RANDOM[8'hB7][25:16];	// register-read.scala:86:29
        rrd_uops_5_REG_ctrl_br_type = _RANDOM[8'hB7][29:26];	// register-read.scala:86:29
        rrd_uops_5_REG_ctrl_op1_sel = _RANDOM[8'hB7][31:30];	// register-read.scala:86:29
        rrd_uops_5_REG_ctrl_op2_sel = _RANDOM[8'hB8][2:0];	// register-read.scala:86:29
        rrd_uops_5_REG_ctrl_imm_sel = _RANDOM[8'hB8][5:3];	// register-read.scala:86:29
        rrd_uops_5_REG_ctrl_op_fcn = _RANDOM[8'hB8][9:6];	// register-read.scala:86:29
        rrd_uops_5_REG_ctrl_fcn_dw = _RANDOM[8'hB8][10];	// register-read.scala:86:29
        rrd_uops_5_REG_is_br = _RANDOM[8'hB8][21];	// register-read.scala:86:29
        rrd_uops_5_REG_is_jalr = _RANDOM[8'hB8][22];	// register-read.scala:86:29
        rrd_uops_5_REG_is_jal = _RANDOM[8'hB8][23];	// register-read.scala:86:29
        rrd_uops_5_REG_is_sfb = _RANDOM[8'hB8][24];	// register-read.scala:86:29
        rrd_uops_5_REG_br_mask = {_RANDOM[8'hB8][31:25], _RANDOM[8'hB9][12:0]};	// register-read.scala:86:29
        rrd_uops_5_REG_br_tag = _RANDOM[8'hB9][17:13];	// register-read.scala:86:29
        rrd_uops_5_REG_ftq_idx = _RANDOM[8'hB9][23:18];	// register-read.scala:86:29
        rrd_uops_5_REG_edge_inst = _RANDOM[8'hB9][24];	// register-read.scala:86:29
        rrd_uops_5_REG_pc_lob = _RANDOM[8'hB9][30:25];	// register-read.scala:86:29
        rrd_uops_5_REG_taken = _RANDOM[8'hB9][31];	// register-read.scala:86:29
        rrd_uops_5_REG_imm_packed = _RANDOM[8'hBA][19:0];	// register-read.scala:86:29
        rrd_uops_5_REG_rob_idx = _RANDOM[8'hBB][6:0];	// register-read.scala:86:29
        rrd_uops_5_REG_ldq_idx = _RANDOM[8'hBB][11:7];	// register-read.scala:86:29
        rrd_uops_5_REG_stq_idx = _RANDOM[8'hBB][16:12];	// register-read.scala:86:29
        rrd_uops_5_REG_pdst = _RANDOM[8'hBB][25:19];	// register-read.scala:86:29
        rrd_uops_5_REG_prs1 = {_RANDOM[8'hBB][31:26], _RANDOM[8'hBC][0]};	// register-read.scala:86:29
        rrd_uops_5_REG_prs2 = _RANDOM[8'hBC][7:1];	// register-read.scala:86:29
        rrd_uops_5_REG_bypassable = _RANDOM[8'hBF][1];	// register-read.scala:86:29
        rrd_uops_5_REG_is_amo = _RANDOM[8'hBF][12];	// register-read.scala:86:29
        rrd_uops_5_REG_uses_stq = _RANDOM[8'hBF][14];	// register-read.scala:86:29
        rrd_uops_5_REG_dst_rtype = _RANDOM[8'hC0][13:12];	// register-read.scala:86:29
        rrd_uops_5_REG_lrs1_rtype = _RANDOM[8'hC0][15:14];	// register-read.scala:86:29
        rrd_uops_5_REG_lrs2_rtype = _RANDOM[8'hC0][17:16];	// register-read.scala:86:29
        rrd_rs1_data_0_REG = _RANDOM[8'hC0][30];	// register-read.scala:86:29, :124:57
        rrd_rs2_data_0_REG = _RANDOM[8'hC0][31];	// register-read.scala:86:29, :125:57
        rrd_rs1_data_1_REG = _RANDOM[8'hC1][0];	// register-read.scala:124:57
        rrd_rs2_data_1_REG = _RANDOM[8'hC1][1];	// register-read.scala:124:57, :125:57
        rrd_rs1_data_2_REG = _RANDOM[8'hC1][2];	// register-read.scala:124:57
        rrd_rs2_data_2_REG = _RANDOM[8'hC1][3];	// register-read.scala:124:57, :125:57
        rrd_rs1_data_3_REG = _RANDOM[8'hC1][4];	// register-read.scala:124:57
        rrd_rs2_data_3_REG = _RANDOM[8'hC1][5];	// register-read.scala:124:57, :125:57
        rrd_rs1_data_4_REG = _RANDOM[8'hC1][6];	// register-read.scala:124:57
        rrd_rs2_data_4_REG = _RANDOM[8'hC1][7];	// register-read.scala:124:57, :125:57
        rrd_rs1_data_5_REG = _RANDOM[8'hC1][8];	// register-read.scala:124:57
        rrd_rs2_data_5_REG = _RANDOM[8'hC1][9];	// register-read.scala:124:57, :125:57
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  RegisterReadDecode_2 rrd_decode_unit (	// register-read.scala:80:33
    .io_iss_uop_uopc         (io_iss_uops_0_uopc),
    .io_iss_uop_imm_packed   (io_iss_uops_0_imm_packed),
    .io_iss_uop_mem_cmd      (io_iss_uops_0_mem_cmd),
    .io_iss_uop_lrs2_rtype   (io_iss_uops_0_lrs2_rtype),
    .io_rrd_uop_ctrl_br_type (_rrd_decode_unit_io_rrd_uop_ctrl_br_type),
    .io_rrd_uop_ctrl_op1_sel (_rrd_decode_unit_io_rrd_uop_ctrl_op1_sel),
    .io_rrd_uop_ctrl_op2_sel (_rrd_decode_unit_io_rrd_uop_ctrl_op2_sel),
    .io_rrd_uop_ctrl_imm_sel (_rrd_decode_unit_io_rrd_uop_ctrl_imm_sel),
    .io_rrd_uop_ctrl_op_fcn  (_rrd_decode_unit_io_rrd_uop_ctrl_op_fcn),
    .io_rrd_uop_ctrl_fcn_dw  (_rrd_decode_unit_io_rrd_uop_ctrl_fcn_dw),
    .io_rrd_uop_ctrl_is_load (_rrd_decode_unit_io_rrd_uop_ctrl_is_load),
    .io_rrd_uop_ctrl_is_sta  (_rrd_decode_unit_io_rrd_uop_ctrl_is_sta),
    .io_rrd_uop_ctrl_is_std  (_rrd_decode_unit_io_rrd_uop_ctrl_is_std),
    .io_rrd_uop_imm_packed   (_rrd_decode_unit_io_rrd_uop_imm_packed)
  );
  RegisterReadDecode_2 rrd_decode_unit_1 (	// register-read.scala:80:33
    .io_iss_uop_uopc         (io_iss_uops_1_uopc),
    .io_iss_uop_imm_packed   (io_iss_uops_1_imm_packed),
    .io_iss_uop_mem_cmd      (io_iss_uops_1_mem_cmd),
    .io_iss_uop_lrs2_rtype   (io_iss_uops_1_lrs2_rtype),
    .io_rrd_uop_ctrl_br_type (_rrd_decode_unit_1_io_rrd_uop_ctrl_br_type),
    .io_rrd_uop_ctrl_op1_sel (_rrd_decode_unit_1_io_rrd_uop_ctrl_op1_sel),
    .io_rrd_uop_ctrl_op2_sel (_rrd_decode_unit_1_io_rrd_uop_ctrl_op2_sel),
    .io_rrd_uop_ctrl_imm_sel (_rrd_decode_unit_1_io_rrd_uop_ctrl_imm_sel),
    .io_rrd_uop_ctrl_op_fcn  (_rrd_decode_unit_1_io_rrd_uop_ctrl_op_fcn),
    .io_rrd_uop_ctrl_fcn_dw  (_rrd_decode_unit_1_io_rrd_uop_ctrl_fcn_dw),
    .io_rrd_uop_ctrl_is_load (_rrd_decode_unit_1_io_rrd_uop_ctrl_is_load),
    .io_rrd_uop_ctrl_is_sta  (_rrd_decode_unit_1_io_rrd_uop_ctrl_is_sta),
    .io_rrd_uop_ctrl_is_std  (_rrd_decode_unit_1_io_rrd_uop_ctrl_is_std),
    .io_rrd_uop_imm_packed   (_rrd_decode_unit_1_io_rrd_uop_imm_packed)
  );
  RegisterReadDecode_4 rrd_decode_unit_2 (	// register-read.scala:80:33
    .io_iss_uop_uopc         (io_iss_uops_2_uopc),
    .io_iss_uop_imm_packed   (io_iss_uops_2_imm_packed),
    .io_iss_uop_mem_cmd      (io_iss_uops_2_mem_cmd),
    .io_iss_uop_lrs2_rtype   (io_iss_uops_2_lrs2_rtype),
    .io_rrd_uop_ctrl_br_type (_rrd_decode_unit_2_io_rrd_uop_ctrl_br_type),
    .io_rrd_uop_ctrl_op1_sel (_rrd_decode_unit_2_io_rrd_uop_ctrl_op1_sel),
    .io_rrd_uop_ctrl_op2_sel (_rrd_decode_unit_2_io_rrd_uop_ctrl_op2_sel),
    .io_rrd_uop_ctrl_imm_sel (_rrd_decode_unit_2_io_rrd_uop_ctrl_imm_sel),
    .io_rrd_uop_ctrl_op_fcn  (_rrd_decode_unit_2_io_rrd_uop_ctrl_op_fcn),
    .io_rrd_uop_ctrl_fcn_dw  (_rrd_decode_unit_2_io_rrd_uop_ctrl_fcn_dw),
    .io_rrd_uop_ctrl_is_load (_rrd_decode_unit_2_io_rrd_uop_ctrl_is_load),
    .io_rrd_uop_ctrl_is_sta  (_rrd_decode_unit_2_io_rrd_uop_ctrl_is_sta),
    .io_rrd_uop_ctrl_is_std  (_rrd_decode_unit_2_io_rrd_uop_ctrl_is_std),
    .io_rrd_uop_imm_packed   (_rrd_decode_unit_2_io_rrd_uop_imm_packed)
  );
  RegisterReadDecode_5 rrd_decode_unit_3 (	// register-read.scala:80:33
    .io_iss_uop_uopc         (io_iss_uops_3_uopc),
    .io_iss_uop_imm_packed   (io_iss_uops_3_imm_packed),
    .io_iss_uop_prs1         (io_iss_uops_3_prs1),
    .io_iss_uop_mem_cmd      (io_iss_uops_3_mem_cmd),
    .io_rrd_uop_ctrl_br_type (_rrd_decode_unit_3_io_rrd_uop_ctrl_br_type),
    .io_rrd_uop_ctrl_op1_sel (_rrd_decode_unit_3_io_rrd_uop_ctrl_op1_sel),
    .io_rrd_uop_ctrl_op2_sel (_rrd_decode_unit_3_io_rrd_uop_ctrl_op2_sel),
    .io_rrd_uop_ctrl_imm_sel (_rrd_decode_unit_3_io_rrd_uop_ctrl_imm_sel),
    .io_rrd_uop_ctrl_op_fcn  (_rrd_decode_unit_3_io_rrd_uop_ctrl_op_fcn),
    .io_rrd_uop_ctrl_fcn_dw  (_rrd_decode_unit_3_io_rrd_uop_ctrl_fcn_dw),
    .io_rrd_uop_ctrl_csr_cmd (_rrd_decode_unit_3_io_rrd_uop_ctrl_csr_cmd),
    .io_rrd_uop_imm_packed   (_rrd_decode_unit_3_io_rrd_uop_imm_packed)
  );
  RegisterReadDecode_6 rrd_decode_unit_4 (	// register-read.scala:80:33
    .io_iss_uop_uopc         (io_iss_uops_4_uopc),
    .io_iss_uop_imm_packed   (io_iss_uops_4_imm_packed),
    .io_iss_uop_mem_cmd      (io_iss_uops_4_mem_cmd),
    .io_rrd_uop_ctrl_br_type (_rrd_decode_unit_4_io_rrd_uop_ctrl_br_type),
    .io_rrd_uop_ctrl_op1_sel (_rrd_decode_unit_4_io_rrd_uop_ctrl_op1_sel),
    .io_rrd_uop_ctrl_op2_sel (_rrd_decode_unit_4_io_rrd_uop_ctrl_op2_sel),
    .io_rrd_uop_ctrl_imm_sel (_rrd_decode_unit_4_io_rrd_uop_ctrl_imm_sel),
    .io_rrd_uop_ctrl_op_fcn  (_rrd_decode_unit_4_io_rrd_uop_ctrl_op_fcn),
    .io_rrd_uop_ctrl_fcn_dw  (_rrd_decode_unit_4_io_rrd_uop_ctrl_fcn_dw),
    .io_rrd_uop_imm_packed   (_rrd_decode_unit_4_io_rrd_uop_imm_packed)
  );
  RegisterReadDecode_6 rrd_decode_unit_5 (	// register-read.scala:80:33
    .io_iss_uop_uopc         (io_iss_uops_5_uopc),
    .io_iss_uop_imm_packed   (io_iss_uops_5_imm_packed),
    .io_iss_uop_mem_cmd      (io_iss_uops_5_mem_cmd),
    .io_rrd_uop_ctrl_br_type (_rrd_decode_unit_5_io_rrd_uop_ctrl_br_type),
    .io_rrd_uop_ctrl_op1_sel (_rrd_decode_unit_5_io_rrd_uop_ctrl_op1_sel),
    .io_rrd_uop_ctrl_op2_sel (_rrd_decode_unit_5_io_rrd_uop_ctrl_op2_sel),
    .io_rrd_uop_ctrl_imm_sel (_rrd_decode_unit_5_io_rrd_uop_ctrl_imm_sel),
    .io_rrd_uop_ctrl_op_fcn  (_rrd_decode_unit_5_io_rrd_uop_ctrl_op_fcn),
    .io_rrd_uop_ctrl_fcn_dw  (_rrd_decode_unit_5_io_rrd_uop_ctrl_fcn_dw),
    .io_rrd_uop_imm_packed   (_rrd_decode_unit_5_io_rrd_uop_imm_packed)
  );
  assign io_exe_reqs_0_valid = exe_reg_valids_0;	// register-read.scala:69:33
  assign io_exe_reqs_0_bits_uop_uopc = exe_reg_uops_0_uopc;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_inst = exe_reg_uops_0_inst;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_debug_inst = exe_reg_uops_0_debug_inst;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_is_rvc = exe_reg_uops_0_is_rvc;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_debug_pc = exe_reg_uops_0_debug_pc;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_iq_type = exe_reg_uops_0_iq_type;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_fu_code = exe_reg_uops_0_fu_code;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_ctrl_br_type = exe_reg_uops_0_ctrl_br_type;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_ctrl_op1_sel = exe_reg_uops_0_ctrl_op1_sel;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_ctrl_op2_sel = exe_reg_uops_0_ctrl_op2_sel;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_ctrl_imm_sel = exe_reg_uops_0_ctrl_imm_sel;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_ctrl_op_fcn = exe_reg_uops_0_ctrl_op_fcn;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_ctrl_fcn_dw = exe_reg_uops_0_ctrl_fcn_dw;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_ctrl_is_load = exe_reg_uops_0_ctrl_is_load;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_ctrl_is_sta = exe_reg_uops_0_ctrl_is_sta;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_ctrl_is_std = exe_reg_uops_0_ctrl_is_std;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_iw_state = exe_reg_uops_0_iw_state;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_is_br = exe_reg_uops_0_is_br;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_is_jalr = exe_reg_uops_0_is_jalr;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_is_jal = exe_reg_uops_0_is_jal;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_is_sfb = exe_reg_uops_0_is_sfb;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_br_mask = exe_reg_uops_0_br_mask;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_br_tag = exe_reg_uops_0_br_tag;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_ftq_idx = exe_reg_uops_0_ftq_idx;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_edge_inst = exe_reg_uops_0_edge_inst;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_pc_lob = exe_reg_uops_0_pc_lob;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_taken = exe_reg_uops_0_taken;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_imm_packed = exe_reg_uops_0_imm_packed;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_csr_addr = exe_reg_uops_0_csr_addr;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_rob_idx = exe_reg_uops_0_rob_idx;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_ldq_idx = exe_reg_uops_0_ldq_idx;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_stq_idx = exe_reg_uops_0_stq_idx;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_rxq_idx = exe_reg_uops_0_rxq_idx;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_pdst = exe_reg_uops_0_pdst;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_prs1 = exe_reg_uops_0_prs1;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_prs2 = exe_reg_uops_0_prs2;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_prs3 = exe_reg_uops_0_prs3;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_ppred = exe_reg_uops_0_ppred;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_prs1_busy = exe_reg_uops_0_prs1_busy;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_prs2_busy = exe_reg_uops_0_prs2_busy;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_prs3_busy = exe_reg_uops_0_prs3_busy;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_ppred_busy = exe_reg_uops_0_ppred_busy;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_stale_pdst = exe_reg_uops_0_stale_pdst;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_exception = exe_reg_uops_0_exception;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_exc_cause = exe_reg_uops_0_exc_cause;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_bypassable = exe_reg_uops_0_bypassable;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_mem_cmd = exe_reg_uops_0_mem_cmd;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_mem_size = exe_reg_uops_0_mem_size;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_mem_signed = exe_reg_uops_0_mem_signed;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_is_fence = exe_reg_uops_0_is_fence;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_is_fencei = exe_reg_uops_0_is_fencei;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_is_amo = exe_reg_uops_0_is_amo;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_uses_ldq = exe_reg_uops_0_uses_ldq;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_uses_stq = exe_reg_uops_0_uses_stq;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_is_sys_pc2epc = exe_reg_uops_0_is_sys_pc2epc;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_is_unique = exe_reg_uops_0_is_unique;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_flush_on_commit = exe_reg_uops_0_flush_on_commit;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_ldst_is_rs1 = exe_reg_uops_0_ldst_is_rs1;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_ldst = exe_reg_uops_0_ldst;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_lrs1 = exe_reg_uops_0_lrs1;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_lrs2 = exe_reg_uops_0_lrs2;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_lrs3 = exe_reg_uops_0_lrs3;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_ldst_val = exe_reg_uops_0_ldst_val;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_dst_rtype = exe_reg_uops_0_dst_rtype;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_lrs1_rtype = exe_reg_uops_0_lrs1_rtype;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_lrs2_rtype = exe_reg_uops_0_lrs2_rtype;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_frs3_en = exe_reg_uops_0_frs3_en;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_fp_val = exe_reg_uops_0_fp_val;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_fp_single = exe_reg_uops_0_fp_single;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_xcpt_pf_if = exe_reg_uops_0_xcpt_pf_if;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_xcpt_ae_if = exe_reg_uops_0_xcpt_ae_if;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_xcpt_ma_if = exe_reg_uops_0_xcpt_ma_if;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_bp_debug_if = exe_reg_uops_0_bp_debug_if;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_bp_xcpt_if = exe_reg_uops_0_bp_xcpt_if;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_debug_fsrc = exe_reg_uops_0_debug_fsrc;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_debug_tsrc = exe_reg_uops_0_debug_tsrc;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_rs1_data = exe_reg_rs1_data_0;	// register-read.scala:71:29
  assign io_exe_reqs_0_bits_rs2_data = exe_reg_rs2_data_0;	// register-read.scala:72:29
  assign io_exe_reqs_1_valid = exe_reg_valids_1;	// register-read.scala:69:33
  assign io_exe_reqs_1_bits_uop_uopc = exe_reg_uops_1_uopc;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_inst = exe_reg_uops_1_inst;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_debug_inst = exe_reg_uops_1_debug_inst;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_is_rvc = exe_reg_uops_1_is_rvc;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_debug_pc = exe_reg_uops_1_debug_pc;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_iq_type = exe_reg_uops_1_iq_type;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_fu_code = exe_reg_uops_1_fu_code;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_ctrl_br_type = exe_reg_uops_1_ctrl_br_type;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_ctrl_op1_sel = exe_reg_uops_1_ctrl_op1_sel;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_ctrl_op2_sel = exe_reg_uops_1_ctrl_op2_sel;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_ctrl_imm_sel = exe_reg_uops_1_ctrl_imm_sel;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_ctrl_op_fcn = exe_reg_uops_1_ctrl_op_fcn;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_ctrl_fcn_dw = exe_reg_uops_1_ctrl_fcn_dw;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_ctrl_is_load = exe_reg_uops_1_ctrl_is_load;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_ctrl_is_sta = exe_reg_uops_1_ctrl_is_sta;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_ctrl_is_std = exe_reg_uops_1_ctrl_is_std;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_iw_state = exe_reg_uops_1_iw_state;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_is_br = exe_reg_uops_1_is_br;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_is_jalr = exe_reg_uops_1_is_jalr;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_is_jal = exe_reg_uops_1_is_jal;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_is_sfb = exe_reg_uops_1_is_sfb;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_br_mask = exe_reg_uops_1_br_mask;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_br_tag = exe_reg_uops_1_br_tag;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_ftq_idx = exe_reg_uops_1_ftq_idx;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_edge_inst = exe_reg_uops_1_edge_inst;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_pc_lob = exe_reg_uops_1_pc_lob;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_taken = exe_reg_uops_1_taken;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_imm_packed = exe_reg_uops_1_imm_packed;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_csr_addr = exe_reg_uops_1_csr_addr;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_rob_idx = exe_reg_uops_1_rob_idx;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_ldq_idx = exe_reg_uops_1_ldq_idx;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_stq_idx = exe_reg_uops_1_stq_idx;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_rxq_idx = exe_reg_uops_1_rxq_idx;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_pdst = exe_reg_uops_1_pdst;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_prs1 = exe_reg_uops_1_prs1;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_prs2 = exe_reg_uops_1_prs2;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_prs3 = exe_reg_uops_1_prs3;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_ppred = exe_reg_uops_1_ppred;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_prs1_busy = exe_reg_uops_1_prs1_busy;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_prs2_busy = exe_reg_uops_1_prs2_busy;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_prs3_busy = exe_reg_uops_1_prs3_busy;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_ppred_busy = exe_reg_uops_1_ppred_busy;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_stale_pdst = exe_reg_uops_1_stale_pdst;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_exception = exe_reg_uops_1_exception;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_exc_cause = exe_reg_uops_1_exc_cause;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_bypassable = exe_reg_uops_1_bypassable;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_mem_cmd = exe_reg_uops_1_mem_cmd;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_mem_size = exe_reg_uops_1_mem_size;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_mem_signed = exe_reg_uops_1_mem_signed;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_is_fence = exe_reg_uops_1_is_fence;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_is_fencei = exe_reg_uops_1_is_fencei;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_is_amo = exe_reg_uops_1_is_amo;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_uses_ldq = exe_reg_uops_1_uses_ldq;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_uses_stq = exe_reg_uops_1_uses_stq;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_is_sys_pc2epc = exe_reg_uops_1_is_sys_pc2epc;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_is_unique = exe_reg_uops_1_is_unique;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_flush_on_commit = exe_reg_uops_1_flush_on_commit;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_ldst_is_rs1 = exe_reg_uops_1_ldst_is_rs1;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_ldst = exe_reg_uops_1_ldst;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_lrs1 = exe_reg_uops_1_lrs1;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_lrs2 = exe_reg_uops_1_lrs2;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_lrs3 = exe_reg_uops_1_lrs3;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_ldst_val = exe_reg_uops_1_ldst_val;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_dst_rtype = exe_reg_uops_1_dst_rtype;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_lrs1_rtype = exe_reg_uops_1_lrs1_rtype;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_lrs2_rtype = exe_reg_uops_1_lrs2_rtype;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_frs3_en = exe_reg_uops_1_frs3_en;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_fp_val = exe_reg_uops_1_fp_val;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_fp_single = exe_reg_uops_1_fp_single;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_xcpt_pf_if = exe_reg_uops_1_xcpt_pf_if;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_xcpt_ae_if = exe_reg_uops_1_xcpt_ae_if;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_xcpt_ma_if = exe_reg_uops_1_xcpt_ma_if;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_bp_debug_if = exe_reg_uops_1_bp_debug_if;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_bp_xcpt_if = exe_reg_uops_1_bp_xcpt_if;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_debug_fsrc = exe_reg_uops_1_debug_fsrc;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_debug_tsrc = exe_reg_uops_1_debug_tsrc;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_rs1_data = exe_reg_rs1_data_1;	// register-read.scala:71:29
  assign io_exe_reqs_1_bits_rs2_data = exe_reg_rs2_data_1;	// register-read.scala:72:29
  assign io_exe_reqs_2_valid = exe_reg_valids_2;	// register-read.scala:69:33
  assign io_exe_reqs_2_bits_uop_uopc = exe_reg_uops_2_uopc;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_inst = exe_reg_uops_2_inst;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_debug_inst = exe_reg_uops_2_debug_inst;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_is_rvc = exe_reg_uops_2_is_rvc;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_debug_pc = exe_reg_uops_2_debug_pc;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_iq_type = exe_reg_uops_2_iq_type;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_fu_code = exe_reg_uops_2_fu_code;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_ctrl_br_type = exe_reg_uops_2_ctrl_br_type;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_ctrl_op1_sel = exe_reg_uops_2_ctrl_op1_sel;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_ctrl_op2_sel = exe_reg_uops_2_ctrl_op2_sel;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_ctrl_imm_sel = exe_reg_uops_2_ctrl_imm_sel;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_ctrl_op_fcn = exe_reg_uops_2_ctrl_op_fcn;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_ctrl_fcn_dw = exe_reg_uops_2_ctrl_fcn_dw;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_ctrl_is_load = exe_reg_uops_2_ctrl_is_load;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_ctrl_is_sta = exe_reg_uops_2_ctrl_is_sta;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_ctrl_is_std = exe_reg_uops_2_ctrl_is_std;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_iw_state = exe_reg_uops_2_iw_state;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_is_br = exe_reg_uops_2_is_br;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_is_jalr = exe_reg_uops_2_is_jalr;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_is_jal = exe_reg_uops_2_is_jal;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_is_sfb = exe_reg_uops_2_is_sfb;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_br_mask = exe_reg_uops_2_br_mask;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_br_tag = exe_reg_uops_2_br_tag;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_ftq_idx = exe_reg_uops_2_ftq_idx;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_edge_inst = exe_reg_uops_2_edge_inst;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_pc_lob = exe_reg_uops_2_pc_lob;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_taken = exe_reg_uops_2_taken;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_imm_packed = exe_reg_uops_2_imm_packed;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_csr_addr = exe_reg_uops_2_csr_addr;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_rob_idx = exe_reg_uops_2_rob_idx;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_ldq_idx = exe_reg_uops_2_ldq_idx;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_stq_idx = exe_reg_uops_2_stq_idx;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_rxq_idx = exe_reg_uops_2_rxq_idx;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_pdst = exe_reg_uops_2_pdst;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_prs1 = exe_reg_uops_2_prs1;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_prs2 = exe_reg_uops_2_prs2;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_prs3 = exe_reg_uops_2_prs3;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_ppred = exe_reg_uops_2_ppred;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_prs1_busy = exe_reg_uops_2_prs1_busy;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_prs2_busy = exe_reg_uops_2_prs2_busy;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_prs3_busy = exe_reg_uops_2_prs3_busy;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_ppred_busy = exe_reg_uops_2_ppred_busy;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_stale_pdst = exe_reg_uops_2_stale_pdst;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_exception = exe_reg_uops_2_exception;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_exc_cause = exe_reg_uops_2_exc_cause;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_bypassable = exe_reg_uops_2_bypassable;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_mem_cmd = exe_reg_uops_2_mem_cmd;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_mem_size = exe_reg_uops_2_mem_size;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_mem_signed = exe_reg_uops_2_mem_signed;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_is_fence = exe_reg_uops_2_is_fence;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_is_fencei = exe_reg_uops_2_is_fencei;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_is_amo = exe_reg_uops_2_is_amo;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_uses_ldq = exe_reg_uops_2_uses_ldq;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_uses_stq = exe_reg_uops_2_uses_stq;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_is_sys_pc2epc = exe_reg_uops_2_is_sys_pc2epc;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_is_unique = exe_reg_uops_2_is_unique;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_flush_on_commit = exe_reg_uops_2_flush_on_commit;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_ldst_is_rs1 = exe_reg_uops_2_ldst_is_rs1;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_ldst = exe_reg_uops_2_ldst;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_lrs1 = exe_reg_uops_2_lrs1;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_lrs2 = exe_reg_uops_2_lrs2;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_lrs3 = exe_reg_uops_2_lrs3;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_ldst_val = exe_reg_uops_2_ldst_val;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_dst_rtype = exe_reg_uops_2_dst_rtype;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_lrs1_rtype = exe_reg_uops_2_lrs1_rtype;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_lrs2_rtype = exe_reg_uops_2_lrs2_rtype;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_frs3_en = exe_reg_uops_2_frs3_en;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_fp_val = exe_reg_uops_2_fp_val;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_fp_single = exe_reg_uops_2_fp_single;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_xcpt_pf_if = exe_reg_uops_2_xcpt_pf_if;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_xcpt_ae_if = exe_reg_uops_2_xcpt_ae_if;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_xcpt_ma_if = exe_reg_uops_2_xcpt_ma_if;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_bp_debug_if = exe_reg_uops_2_bp_debug_if;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_bp_xcpt_if = exe_reg_uops_2_bp_xcpt_if;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_debug_fsrc = exe_reg_uops_2_debug_fsrc;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_debug_tsrc = exe_reg_uops_2_debug_tsrc;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_rs1_data = exe_reg_rs1_data_2;	// register-read.scala:71:29
  assign io_exe_reqs_2_bits_rs2_data = exe_reg_rs2_data_2;	// register-read.scala:72:29
  assign io_exe_reqs_3_valid = exe_reg_valids_3;	// register-read.scala:69:33
  assign io_exe_reqs_3_bits_uop_uopc = exe_reg_uops_3_uopc;	// register-read.scala:70:29
  assign io_exe_reqs_3_bits_uop_is_rvc = exe_reg_uops_3_is_rvc;	// register-read.scala:70:29
  assign io_exe_reqs_3_bits_uop_fu_code = exe_reg_uops_3_fu_code;	// register-read.scala:70:29
  assign io_exe_reqs_3_bits_uop_ctrl_br_type = exe_reg_uops_3_ctrl_br_type;	// register-read.scala:70:29
  assign io_exe_reqs_3_bits_uop_ctrl_op1_sel = exe_reg_uops_3_ctrl_op1_sel;	// register-read.scala:70:29
  assign io_exe_reqs_3_bits_uop_ctrl_op2_sel = exe_reg_uops_3_ctrl_op2_sel;	// register-read.scala:70:29
  assign io_exe_reqs_3_bits_uop_ctrl_imm_sel = exe_reg_uops_3_ctrl_imm_sel;	// register-read.scala:70:29
  assign io_exe_reqs_3_bits_uop_ctrl_op_fcn = exe_reg_uops_3_ctrl_op_fcn;	// register-read.scala:70:29
  assign io_exe_reqs_3_bits_uop_ctrl_fcn_dw = exe_reg_uops_3_ctrl_fcn_dw;	// register-read.scala:70:29
  assign io_exe_reqs_3_bits_uop_ctrl_csr_cmd = exe_reg_uops_3_ctrl_csr_cmd;	// register-read.scala:70:29
  assign io_exe_reqs_3_bits_uop_is_br = exe_reg_uops_3_is_br;	// register-read.scala:70:29
  assign io_exe_reqs_3_bits_uop_is_jalr = exe_reg_uops_3_is_jalr;	// register-read.scala:70:29
  assign io_exe_reqs_3_bits_uop_is_jal = exe_reg_uops_3_is_jal;	// register-read.scala:70:29
  assign io_exe_reqs_3_bits_uop_is_sfb = exe_reg_uops_3_is_sfb;	// register-read.scala:70:29
  assign io_exe_reqs_3_bits_uop_br_mask = exe_reg_uops_3_br_mask;	// register-read.scala:70:29
  assign io_exe_reqs_3_bits_uop_br_tag = exe_reg_uops_3_br_tag;	// register-read.scala:70:29
  assign io_exe_reqs_3_bits_uop_ftq_idx = exe_reg_uops_3_ftq_idx;	// register-read.scala:70:29
  assign io_exe_reqs_3_bits_uop_edge_inst = exe_reg_uops_3_edge_inst;	// register-read.scala:70:29
  assign io_exe_reqs_3_bits_uop_pc_lob = exe_reg_uops_3_pc_lob;	// register-read.scala:70:29
  assign io_exe_reqs_3_bits_uop_taken = exe_reg_uops_3_taken;	// register-read.scala:70:29
  assign io_exe_reqs_3_bits_uop_imm_packed = exe_reg_uops_3_imm_packed;	// register-read.scala:70:29
  assign io_exe_reqs_3_bits_uop_rob_idx = exe_reg_uops_3_rob_idx;	// register-read.scala:70:29
  assign io_exe_reqs_3_bits_uop_ldq_idx = exe_reg_uops_3_ldq_idx;	// register-read.scala:70:29
  assign io_exe_reqs_3_bits_uop_stq_idx = exe_reg_uops_3_stq_idx;	// register-read.scala:70:29
  assign io_exe_reqs_3_bits_uop_pdst = exe_reg_uops_3_pdst;	// register-read.scala:70:29
  assign io_exe_reqs_3_bits_uop_prs1 = exe_reg_uops_3_prs1;	// register-read.scala:70:29
  assign io_exe_reqs_3_bits_uop_bypassable = exe_reg_uops_3_bypassable;	// register-read.scala:70:29
  assign io_exe_reqs_3_bits_uop_is_amo = exe_reg_uops_3_is_amo;	// register-read.scala:70:29
  assign io_exe_reqs_3_bits_uop_uses_stq = exe_reg_uops_3_uses_stq;	// register-read.scala:70:29
  assign io_exe_reqs_3_bits_uop_dst_rtype = exe_reg_uops_3_dst_rtype;	// register-read.scala:70:29
  assign io_exe_reqs_3_bits_rs1_data = exe_reg_rs1_data_3;	// register-read.scala:71:29
  assign io_exe_reqs_3_bits_rs2_data = exe_reg_rs2_data_3;	// register-read.scala:72:29
  assign io_exe_reqs_4_valid = exe_reg_valids_4;	// register-read.scala:69:33
  assign io_exe_reqs_4_bits_uop_uopc = exe_reg_uops_4_uopc;	// register-read.scala:70:29
  assign io_exe_reqs_4_bits_uop_is_rvc = exe_reg_uops_4_is_rvc;	// register-read.scala:70:29
  assign io_exe_reqs_4_bits_uop_fu_code = exe_reg_uops_4_fu_code;	// register-read.scala:70:29
  assign io_exe_reqs_4_bits_uop_ctrl_br_type = exe_reg_uops_4_ctrl_br_type;	// register-read.scala:70:29
  assign io_exe_reqs_4_bits_uop_ctrl_op1_sel = exe_reg_uops_4_ctrl_op1_sel;	// register-read.scala:70:29
  assign io_exe_reqs_4_bits_uop_ctrl_op2_sel = exe_reg_uops_4_ctrl_op2_sel;	// register-read.scala:70:29
  assign io_exe_reqs_4_bits_uop_ctrl_imm_sel = exe_reg_uops_4_ctrl_imm_sel;	// register-read.scala:70:29
  assign io_exe_reqs_4_bits_uop_ctrl_op_fcn = exe_reg_uops_4_ctrl_op_fcn;	// register-read.scala:70:29
  assign io_exe_reqs_4_bits_uop_ctrl_fcn_dw = exe_reg_uops_4_ctrl_fcn_dw;	// register-read.scala:70:29
  assign io_exe_reqs_4_bits_uop_is_br = exe_reg_uops_4_is_br;	// register-read.scala:70:29
  assign io_exe_reqs_4_bits_uop_is_jalr = exe_reg_uops_4_is_jalr;	// register-read.scala:70:29
  assign io_exe_reqs_4_bits_uop_is_jal = exe_reg_uops_4_is_jal;	// register-read.scala:70:29
  assign io_exe_reqs_4_bits_uop_is_sfb = exe_reg_uops_4_is_sfb;	// register-read.scala:70:29
  assign io_exe_reqs_4_bits_uop_br_mask = exe_reg_uops_4_br_mask;	// register-read.scala:70:29
  assign io_exe_reqs_4_bits_uop_br_tag = exe_reg_uops_4_br_tag;	// register-read.scala:70:29
  assign io_exe_reqs_4_bits_uop_ftq_idx = exe_reg_uops_4_ftq_idx;	// register-read.scala:70:29
  assign io_exe_reqs_4_bits_uop_edge_inst = exe_reg_uops_4_edge_inst;	// register-read.scala:70:29
  assign io_exe_reqs_4_bits_uop_pc_lob = exe_reg_uops_4_pc_lob;	// register-read.scala:70:29
  assign io_exe_reqs_4_bits_uop_taken = exe_reg_uops_4_taken;	// register-read.scala:70:29
  assign io_exe_reqs_4_bits_uop_imm_packed = exe_reg_uops_4_imm_packed;	// register-read.scala:70:29
  assign io_exe_reqs_4_bits_uop_rob_idx = exe_reg_uops_4_rob_idx;	// register-read.scala:70:29
  assign io_exe_reqs_4_bits_uop_ldq_idx = exe_reg_uops_4_ldq_idx;	// register-read.scala:70:29
  assign io_exe_reqs_4_bits_uop_stq_idx = exe_reg_uops_4_stq_idx;	// register-read.scala:70:29
  assign io_exe_reqs_4_bits_uop_pdst = exe_reg_uops_4_pdst;	// register-read.scala:70:29
  assign io_exe_reqs_4_bits_uop_prs1 = exe_reg_uops_4_prs1;	// register-read.scala:70:29
  assign io_exe_reqs_4_bits_uop_bypassable = exe_reg_uops_4_bypassable;	// register-read.scala:70:29
  assign io_exe_reqs_4_bits_uop_is_amo = exe_reg_uops_4_is_amo;	// register-read.scala:70:29
  assign io_exe_reqs_4_bits_uop_uses_stq = exe_reg_uops_4_uses_stq;	// register-read.scala:70:29
  assign io_exe_reqs_4_bits_uop_dst_rtype = exe_reg_uops_4_dst_rtype;	// register-read.scala:70:29
  assign io_exe_reqs_4_bits_rs1_data = exe_reg_rs1_data_4;	// register-read.scala:71:29
  assign io_exe_reqs_4_bits_rs2_data = exe_reg_rs2_data_4;	// register-read.scala:72:29
  assign io_exe_reqs_5_valid = exe_reg_valids_5;	// register-read.scala:69:33
  assign io_exe_reqs_5_bits_uop_uopc = exe_reg_uops_5_uopc;	// register-read.scala:70:29
  assign io_exe_reqs_5_bits_uop_is_rvc = exe_reg_uops_5_is_rvc;	// register-read.scala:70:29
  assign io_exe_reqs_5_bits_uop_fu_code = exe_reg_uops_5_fu_code;	// register-read.scala:70:29
  assign io_exe_reqs_5_bits_uop_ctrl_br_type = exe_reg_uops_5_ctrl_br_type;	// register-read.scala:70:29
  assign io_exe_reqs_5_bits_uop_ctrl_op1_sel = exe_reg_uops_5_ctrl_op1_sel;	// register-read.scala:70:29
  assign io_exe_reqs_5_bits_uop_ctrl_op2_sel = exe_reg_uops_5_ctrl_op2_sel;	// register-read.scala:70:29
  assign io_exe_reqs_5_bits_uop_ctrl_imm_sel = exe_reg_uops_5_ctrl_imm_sel;	// register-read.scala:70:29
  assign io_exe_reqs_5_bits_uop_ctrl_op_fcn = exe_reg_uops_5_ctrl_op_fcn;	// register-read.scala:70:29
  assign io_exe_reqs_5_bits_uop_ctrl_fcn_dw = exe_reg_uops_5_ctrl_fcn_dw;	// register-read.scala:70:29
  assign io_exe_reqs_5_bits_uop_is_br = exe_reg_uops_5_is_br;	// register-read.scala:70:29
  assign io_exe_reqs_5_bits_uop_is_jalr = exe_reg_uops_5_is_jalr;	// register-read.scala:70:29
  assign io_exe_reqs_5_bits_uop_is_jal = exe_reg_uops_5_is_jal;	// register-read.scala:70:29
  assign io_exe_reqs_5_bits_uop_is_sfb = exe_reg_uops_5_is_sfb;	// register-read.scala:70:29
  assign io_exe_reqs_5_bits_uop_br_mask = exe_reg_uops_5_br_mask;	// register-read.scala:70:29
  assign io_exe_reqs_5_bits_uop_br_tag = exe_reg_uops_5_br_tag;	// register-read.scala:70:29
  assign io_exe_reqs_5_bits_uop_ftq_idx = exe_reg_uops_5_ftq_idx;	// register-read.scala:70:29
  assign io_exe_reqs_5_bits_uop_edge_inst = exe_reg_uops_5_edge_inst;	// register-read.scala:70:29
  assign io_exe_reqs_5_bits_uop_pc_lob = exe_reg_uops_5_pc_lob;	// register-read.scala:70:29
  assign io_exe_reqs_5_bits_uop_taken = exe_reg_uops_5_taken;	// register-read.scala:70:29
  assign io_exe_reqs_5_bits_uop_imm_packed = exe_reg_uops_5_imm_packed;	// register-read.scala:70:29
  assign io_exe_reqs_5_bits_uop_rob_idx = exe_reg_uops_5_rob_idx;	// register-read.scala:70:29
  assign io_exe_reqs_5_bits_uop_ldq_idx = exe_reg_uops_5_ldq_idx;	// register-read.scala:70:29
  assign io_exe_reqs_5_bits_uop_stq_idx = exe_reg_uops_5_stq_idx;	// register-read.scala:70:29
  assign io_exe_reqs_5_bits_uop_pdst = exe_reg_uops_5_pdst;	// register-read.scala:70:29
  assign io_exe_reqs_5_bits_uop_prs1 = exe_reg_uops_5_prs1;	// register-read.scala:70:29
  assign io_exe_reqs_5_bits_uop_bypassable = exe_reg_uops_5_bypassable;	// register-read.scala:70:29
  assign io_exe_reqs_5_bits_uop_is_amo = exe_reg_uops_5_is_amo;	// register-read.scala:70:29
  assign io_exe_reqs_5_bits_uop_uses_stq = exe_reg_uops_5_uses_stq;	// register-read.scala:70:29
  assign io_exe_reqs_5_bits_uop_dst_rtype = exe_reg_uops_5_dst_rtype;	// register-read.scala:70:29
  assign io_exe_reqs_5_bits_rs1_data = exe_reg_rs1_data_5;	// register-read.scala:71:29
  assign io_exe_reqs_5_bits_rs2_data = exe_reg_rs2_data_5;	// register-read.scala:72:29
endmodule

