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

module RegisterRead_5(
  input         clock,
                reset,
                io_iss_valids_0,
                io_iss_valids_1,
                io_iss_valids_2,
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
  input  [11:0] io_iss_uops_0_br_mask,
  input  [3:0]  io_iss_uops_0_br_tag,
  input  [4:0]  io_iss_uops_0_ftq_idx,
  input         io_iss_uops_0_edge_inst,
  input  [5:0]  io_iss_uops_0_pc_lob,
  input         io_iss_uops_0_taken,
  input  [19:0] io_iss_uops_0_imm_packed,
  input  [11:0] io_iss_uops_0_csr_addr,
  input  [5:0]  io_iss_uops_0_rob_idx,
  input  [3:0]  io_iss_uops_0_ldq_idx,
                io_iss_uops_0_stq_idx,
  input  [1:0]  io_iss_uops_0_rxq_idx,
  input  [6:0]  io_iss_uops_0_pdst,
                io_iss_uops_0_prs1,
                io_iss_uops_0_prs2,
                io_iss_uops_0_prs3,
  input  [4:0]  io_iss_uops_0_ppred,
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
  input  [11:0] io_iss_uops_1_br_mask,
  input  [3:0]  io_iss_uops_1_br_tag,
  input  [4:0]  io_iss_uops_1_ftq_idx,
  input         io_iss_uops_1_edge_inst,
  input  [5:0]  io_iss_uops_1_pc_lob,
  input         io_iss_uops_1_taken,
  input  [19:0] io_iss_uops_1_imm_packed,
  input  [11:0] io_iss_uops_1_csr_addr,
  input  [5:0]  io_iss_uops_1_rob_idx,
  input  [3:0]  io_iss_uops_1_ldq_idx,
                io_iss_uops_1_stq_idx,
  input  [1:0]  io_iss_uops_1_rxq_idx,
  input  [6:0]  io_iss_uops_1_pdst,
                io_iss_uops_1_prs1,
                io_iss_uops_1_prs2,
                io_iss_uops_1_prs3,
  input  [4:0]  io_iss_uops_1_ppred,
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
  input         io_iss_uops_2_is_rvc,
  input  [9:0]  io_iss_uops_2_fu_code,
  input         io_iss_uops_2_is_br,
                io_iss_uops_2_is_jalr,
                io_iss_uops_2_is_jal,
                io_iss_uops_2_is_sfb,
  input  [11:0] io_iss_uops_2_br_mask,
  input  [3:0]  io_iss_uops_2_br_tag,
  input  [4:0]  io_iss_uops_2_ftq_idx,
  input         io_iss_uops_2_edge_inst,
  input  [5:0]  io_iss_uops_2_pc_lob,
  input         io_iss_uops_2_taken,
  input  [19:0] io_iss_uops_2_imm_packed,
  input  [5:0]  io_iss_uops_2_rob_idx,
  input  [3:0]  io_iss_uops_2_ldq_idx,
                io_iss_uops_2_stq_idx,
  input  [6:0]  io_iss_uops_2_pdst,
                io_iss_uops_2_prs1,
                io_iss_uops_2_prs2,
  input         io_iss_uops_2_bypassable,
  input  [4:0]  io_iss_uops_2_mem_cmd,
  input         io_iss_uops_2_is_amo,
                io_iss_uops_2_uses_stq,
  input  [1:0]  io_iss_uops_2_dst_rtype,
                io_iss_uops_2_lrs1_rtype,
                io_iss_uops_2_lrs2_rtype,
  input  [63:0] io_rf_read_ports_0_data,
                io_rf_read_ports_1_data,
                io_rf_read_ports_2_data,
                io_rf_read_ports_3_data,
                io_rf_read_ports_4_data,
                io_rf_read_ports_5_data,
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
  input         io_kill,
  input  [11:0] io_brupdate_b1_resolve_mask,
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
  output [11:0] io_exe_reqs_0_bits_uop_br_mask,
  output [3:0]  io_exe_reqs_0_bits_uop_br_tag,
  output [4:0]  io_exe_reqs_0_bits_uop_ftq_idx,
  output        io_exe_reqs_0_bits_uop_edge_inst,
  output [5:0]  io_exe_reqs_0_bits_uop_pc_lob,
  output        io_exe_reqs_0_bits_uop_taken,
  output [19:0] io_exe_reqs_0_bits_uop_imm_packed,
  output [11:0] io_exe_reqs_0_bits_uop_csr_addr,
  output [5:0]  io_exe_reqs_0_bits_uop_rob_idx,
  output [3:0]  io_exe_reqs_0_bits_uop_ldq_idx,
                io_exe_reqs_0_bits_uop_stq_idx,
  output [1:0]  io_exe_reqs_0_bits_uop_rxq_idx,
  output [6:0]  io_exe_reqs_0_bits_uop_pdst,
                io_exe_reqs_0_bits_uop_prs1,
                io_exe_reqs_0_bits_uop_prs2,
                io_exe_reqs_0_bits_uop_prs3,
  output [4:0]  io_exe_reqs_0_bits_uop_ppred,
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
  output [11:0] io_exe_reqs_1_bits_uop_br_mask,
  output [3:0]  io_exe_reqs_1_bits_uop_br_tag,
  output [4:0]  io_exe_reqs_1_bits_uop_ftq_idx,
  output        io_exe_reqs_1_bits_uop_edge_inst,
  output [5:0]  io_exe_reqs_1_bits_uop_pc_lob,
  output        io_exe_reqs_1_bits_uop_taken,
  output [19:0] io_exe_reqs_1_bits_uop_imm_packed,
  output [11:0] io_exe_reqs_1_bits_uop_csr_addr,
  output [5:0]  io_exe_reqs_1_bits_uop_rob_idx,
  output [3:0]  io_exe_reqs_1_bits_uop_ldq_idx,
                io_exe_reqs_1_bits_uop_stq_idx,
  output [1:0]  io_exe_reqs_1_bits_uop_rxq_idx,
  output [6:0]  io_exe_reqs_1_bits_uop_pdst,
                io_exe_reqs_1_bits_uop_prs1,
                io_exe_reqs_1_bits_uop_prs2,
                io_exe_reqs_1_bits_uop_prs3,
  output [4:0]  io_exe_reqs_1_bits_uop_ppred,
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
  output        io_exe_reqs_2_bits_uop_is_rvc,
  output [9:0]  io_exe_reqs_2_bits_uop_fu_code,
  output [3:0]  io_exe_reqs_2_bits_uop_ctrl_br_type,
  output [1:0]  io_exe_reqs_2_bits_uop_ctrl_op1_sel,
  output [2:0]  io_exe_reqs_2_bits_uop_ctrl_op2_sel,
                io_exe_reqs_2_bits_uop_ctrl_imm_sel,
  output [3:0]  io_exe_reqs_2_bits_uop_ctrl_op_fcn,
  output        io_exe_reqs_2_bits_uop_ctrl_fcn_dw,
  output [2:0]  io_exe_reqs_2_bits_uop_ctrl_csr_cmd,
  output        io_exe_reqs_2_bits_uop_is_br,
                io_exe_reqs_2_bits_uop_is_jalr,
                io_exe_reqs_2_bits_uop_is_jal,
                io_exe_reqs_2_bits_uop_is_sfb,
  output [11:0] io_exe_reqs_2_bits_uop_br_mask,
  output [3:0]  io_exe_reqs_2_bits_uop_br_tag,
  output [4:0]  io_exe_reqs_2_bits_uop_ftq_idx,
  output        io_exe_reqs_2_bits_uop_edge_inst,
  output [5:0]  io_exe_reqs_2_bits_uop_pc_lob,
  output        io_exe_reqs_2_bits_uop_taken,
  output [19:0] io_exe_reqs_2_bits_uop_imm_packed,
  output [5:0]  io_exe_reqs_2_bits_uop_rob_idx,
  output [3:0]  io_exe_reqs_2_bits_uop_ldq_idx,
                io_exe_reqs_2_bits_uop_stq_idx,
  output [6:0]  io_exe_reqs_2_bits_uop_pdst,
                io_exe_reqs_2_bits_uop_prs1,
  output        io_exe_reqs_2_bits_uop_bypassable,
                io_exe_reqs_2_bits_uop_is_amo,
                io_exe_reqs_2_bits_uop_uses_stq,
  output [1:0]  io_exe_reqs_2_bits_uop_dst_rtype,
  output [63:0] io_exe_reqs_2_bits_rs1_data,
                io_exe_reqs_2_bits_rs2_data
);

  wire [3:0]  _rrd_decode_unit_2_io_rrd_uop_ctrl_br_type;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_2_io_rrd_uop_ctrl_op1_sel;	// register-read.scala:80:33
  wire [2:0]  _rrd_decode_unit_2_io_rrd_uop_ctrl_op2_sel;	// register-read.scala:80:33
  wire [2:0]  _rrd_decode_unit_2_io_rrd_uop_ctrl_imm_sel;	// register-read.scala:80:33
  wire [3:0]  _rrd_decode_unit_2_io_rrd_uop_ctrl_op_fcn;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_ctrl_fcn_dw;	// register-read.scala:80:33
  wire [2:0]  _rrd_decode_unit_2_io_rrd_uop_ctrl_csr_cmd;	// register-read.scala:80:33
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
  reg  [11:0] exe_reg_uops_0_br_mask;	// register-read.scala:70:29
  reg  [3:0]  exe_reg_uops_0_br_tag;	// register-read.scala:70:29
  reg  [4:0]  exe_reg_uops_0_ftq_idx;	// register-read.scala:70:29
  reg         exe_reg_uops_0_edge_inst;	// register-read.scala:70:29
  reg  [5:0]  exe_reg_uops_0_pc_lob;	// register-read.scala:70:29
  reg         exe_reg_uops_0_taken;	// register-read.scala:70:29
  reg  [19:0] exe_reg_uops_0_imm_packed;	// register-read.scala:70:29
  reg  [11:0] exe_reg_uops_0_csr_addr;	// register-read.scala:70:29
  reg  [5:0]  exe_reg_uops_0_rob_idx;	// register-read.scala:70:29
  reg  [3:0]  exe_reg_uops_0_ldq_idx;	// register-read.scala:70:29
  reg  [3:0]  exe_reg_uops_0_stq_idx;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_0_rxq_idx;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_0_pdst;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_0_prs1;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_0_prs2;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_0_prs3;	// register-read.scala:70:29
  reg  [4:0]  exe_reg_uops_0_ppred;	// register-read.scala:70:29
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
  reg  [11:0] exe_reg_uops_1_br_mask;	// register-read.scala:70:29
  reg  [3:0]  exe_reg_uops_1_br_tag;	// register-read.scala:70:29
  reg  [4:0]  exe_reg_uops_1_ftq_idx;	// register-read.scala:70:29
  reg         exe_reg_uops_1_edge_inst;	// register-read.scala:70:29
  reg  [5:0]  exe_reg_uops_1_pc_lob;	// register-read.scala:70:29
  reg         exe_reg_uops_1_taken;	// register-read.scala:70:29
  reg  [19:0] exe_reg_uops_1_imm_packed;	// register-read.scala:70:29
  reg  [11:0] exe_reg_uops_1_csr_addr;	// register-read.scala:70:29
  reg  [5:0]  exe_reg_uops_1_rob_idx;	// register-read.scala:70:29
  reg  [3:0]  exe_reg_uops_1_ldq_idx;	// register-read.scala:70:29
  reg  [3:0]  exe_reg_uops_1_stq_idx;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_1_rxq_idx;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_1_pdst;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_1_prs1;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_1_prs2;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_1_prs3;	// register-read.scala:70:29
  reg  [4:0]  exe_reg_uops_1_ppred;	// register-read.scala:70:29
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
  reg         exe_reg_uops_2_is_rvc;	// register-read.scala:70:29
  reg  [9:0]  exe_reg_uops_2_fu_code;	// register-read.scala:70:29
  reg  [3:0]  exe_reg_uops_2_ctrl_br_type;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_2_ctrl_op1_sel;	// register-read.scala:70:29
  reg  [2:0]  exe_reg_uops_2_ctrl_op2_sel;	// register-read.scala:70:29
  reg  [2:0]  exe_reg_uops_2_ctrl_imm_sel;	// register-read.scala:70:29
  reg  [3:0]  exe_reg_uops_2_ctrl_op_fcn;	// register-read.scala:70:29
  reg         exe_reg_uops_2_ctrl_fcn_dw;	// register-read.scala:70:29
  reg  [2:0]  exe_reg_uops_2_ctrl_csr_cmd;	// register-read.scala:70:29
  reg         exe_reg_uops_2_is_br;	// register-read.scala:70:29
  reg         exe_reg_uops_2_is_jalr;	// register-read.scala:70:29
  reg         exe_reg_uops_2_is_jal;	// register-read.scala:70:29
  reg         exe_reg_uops_2_is_sfb;	// register-read.scala:70:29
  reg  [11:0] exe_reg_uops_2_br_mask;	// register-read.scala:70:29
  reg  [3:0]  exe_reg_uops_2_br_tag;	// register-read.scala:70:29
  reg  [4:0]  exe_reg_uops_2_ftq_idx;	// register-read.scala:70:29
  reg         exe_reg_uops_2_edge_inst;	// register-read.scala:70:29
  reg  [5:0]  exe_reg_uops_2_pc_lob;	// register-read.scala:70:29
  reg         exe_reg_uops_2_taken;	// register-read.scala:70:29
  reg  [19:0] exe_reg_uops_2_imm_packed;	// register-read.scala:70:29
  reg  [5:0]  exe_reg_uops_2_rob_idx;	// register-read.scala:70:29
  reg  [3:0]  exe_reg_uops_2_ldq_idx;	// register-read.scala:70:29
  reg  [3:0]  exe_reg_uops_2_stq_idx;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_2_pdst;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_2_prs1;	// register-read.scala:70:29
  reg         exe_reg_uops_2_bypassable;	// register-read.scala:70:29
  reg         exe_reg_uops_2_is_amo;	// register-read.scala:70:29
  reg         exe_reg_uops_2_uses_stq;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_2_dst_rtype;	// register-read.scala:70:29
  reg  [63:0] exe_reg_rs1_data_0;	// register-read.scala:71:29
  reg  [63:0] exe_reg_rs1_data_1;	// register-read.scala:71:29
  reg  [63:0] exe_reg_rs1_data_2;	// register-read.scala:71:29
  reg  [63:0] exe_reg_rs2_data_0;	// register-read.scala:72:29
  reg  [63:0] exe_reg_rs2_data_1;	// register-read.scala:72:29
  reg  [63:0] exe_reg_rs2_data_2;	// register-read.scala:72:29
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
  reg  [11:0] rrd_uops_0_REG_br_mask;	// register-read.scala:86:29
  reg  [3:0]  rrd_uops_0_REG_br_tag;	// register-read.scala:86:29
  reg  [4:0]  rrd_uops_0_REG_ftq_idx;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_edge_inst;	// register-read.scala:86:29
  reg  [5:0]  rrd_uops_0_REG_pc_lob;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_taken;	// register-read.scala:86:29
  reg  [19:0] rrd_uops_0_REG_imm_packed;	// register-read.scala:86:29
  reg  [11:0] rrd_uops_0_REG_csr_addr;	// register-read.scala:86:29
  reg  [5:0]  rrd_uops_0_REG_rob_idx;	// register-read.scala:86:29
  reg  [3:0]  rrd_uops_0_REG_ldq_idx;	// register-read.scala:86:29
  reg  [3:0]  rrd_uops_0_REG_stq_idx;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_0_REG_rxq_idx;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_0_REG_pdst;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_0_REG_prs1;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_0_REG_prs2;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_0_REG_prs3;	// register-read.scala:86:29
  reg  [4:0]  rrd_uops_0_REG_ppred;	// register-read.scala:86:29
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
  reg  [11:0] rrd_uops_1_REG_br_mask;	// register-read.scala:86:29
  reg  [3:0]  rrd_uops_1_REG_br_tag;	// register-read.scala:86:29
  reg  [4:0]  rrd_uops_1_REG_ftq_idx;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_edge_inst;	// register-read.scala:86:29
  reg  [5:0]  rrd_uops_1_REG_pc_lob;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_taken;	// register-read.scala:86:29
  reg  [19:0] rrd_uops_1_REG_imm_packed;	// register-read.scala:86:29
  reg  [11:0] rrd_uops_1_REG_csr_addr;	// register-read.scala:86:29
  reg  [5:0]  rrd_uops_1_REG_rob_idx;	// register-read.scala:86:29
  reg  [3:0]  rrd_uops_1_REG_ldq_idx;	// register-read.scala:86:29
  reg  [3:0]  rrd_uops_1_REG_stq_idx;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_1_REG_rxq_idx;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_1_REG_pdst;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_1_REG_prs1;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_1_REG_prs2;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_1_REG_prs3;	// register-read.scala:86:29
  reg  [4:0]  rrd_uops_1_REG_ppred;	// register-read.scala:86:29
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
  reg         rrd_uops_2_REG_is_rvc;	// register-read.scala:86:29
  reg  [9:0]  rrd_uops_2_REG_fu_code;	// register-read.scala:86:29
  reg  [3:0]  rrd_uops_2_REG_ctrl_br_type;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_2_REG_ctrl_op1_sel;	// register-read.scala:86:29
  reg  [2:0]  rrd_uops_2_REG_ctrl_op2_sel;	// register-read.scala:86:29
  reg  [2:0]  rrd_uops_2_REG_ctrl_imm_sel;	// register-read.scala:86:29
  reg  [3:0]  rrd_uops_2_REG_ctrl_op_fcn;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_ctrl_fcn_dw;	// register-read.scala:86:29
  reg  [2:0]  rrd_uops_2_REG_ctrl_csr_cmd;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_is_br;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_is_jalr;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_is_jal;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_is_sfb;	// register-read.scala:86:29
  reg  [11:0] rrd_uops_2_REG_br_mask;	// register-read.scala:86:29
  reg  [3:0]  rrd_uops_2_REG_br_tag;	// register-read.scala:86:29
  reg  [4:0]  rrd_uops_2_REG_ftq_idx;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_edge_inst;	// register-read.scala:86:29
  reg  [5:0]  rrd_uops_2_REG_pc_lob;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_taken;	// register-read.scala:86:29
  reg  [19:0] rrd_uops_2_REG_imm_packed;	// register-read.scala:86:29
  reg  [5:0]  rrd_uops_2_REG_rob_idx;	// register-read.scala:86:29
  reg  [3:0]  rrd_uops_2_REG_ldq_idx;	// register-read.scala:86:29
  reg  [3:0]  rrd_uops_2_REG_stq_idx;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_2_REG_pdst;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_2_REG_prs1;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_2_REG_prs2;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_bypassable;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_is_amo;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_uses_stq;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_2_REG_dst_rtype;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_2_REG_lrs1_rtype;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_2_REG_lrs2_rtype;	// register-read.scala:86:29
  reg         rrd_rs1_data_0_REG;	// register-read.scala:124:57
  reg         rrd_rs2_data_0_REG;	// register-read.scala:125:57
  reg         rrd_rs1_data_1_REG;	// register-read.scala:124:57
  reg         rrd_rs2_data_1_REG;	// register-read.scala:125:57
  reg         rrd_rs1_data_2_REG;	// register-read.scala:124:57
  reg         rrd_rs2_data_2_REG;	// register-read.scala:125:57
  always @(posedge clock) begin
    automatic logic rrd_kill;	// register-read.scala:130:28
    automatic logic rrd_kill_1;	// register-read.scala:130:28
    automatic logic rrd_kill_2;	// register-read.scala:130:28
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
    automatic logic _GEN_9;	// register-read.scala:174:63
    automatic logic _GEN_10;	// register-read.scala:176:63
    automatic logic _GEN_11;	// register-read.scala:174:63
    automatic logic _GEN_12;	// register-read.scala:176:63
    rrd_kill = io_kill | (|(io_brupdate_b1_mispredict_mask & rrd_uops_0_REG_br_mask));	// register-read.scala:86:29, :130:28, util.scala:118:{51,59}
    rrd_kill_1 = io_kill | (|(io_brupdate_b1_mispredict_mask & rrd_uops_1_REG_br_mask));	// register-read.scala:86:29, :130:28, util.scala:118:{51,59}
    rrd_kill_2 = io_kill | (|(io_brupdate_b1_mispredict_mask & rrd_uops_2_REG_br_mask));	// register-read.scala:86:29, :130:28, util.scala:118:{51,59}
    _GEN_1 = rrd_uops_0_REG_lrs1_rtype == 2'h0;	// consts.scala:270:20, register-read.scala:86:29, :174:63
    _GEN_2 = rrd_uops_0_REG_lrs2_rtype == 2'h0;	// consts.scala:270:20, register-read.scala:86:29, :176:63
    _GEN_3 = io_bypass_1_bits_uop_dst_rtype != 2'h2;	// consts.scala:277:20, micro-op.scala:149:36
    _GEN_4 = io_bypass_1_bits_uop_dst_rtype == 2'h0;	// consts.scala:270:20, register-read.scala:174:38
    _GEN_5 = io_bypass_2_bits_uop_dst_rtype != 2'h2;	// consts.scala:277:20, micro-op.scala:149:36
    _GEN_6 = io_bypass_2_bits_uop_dst_rtype == 2'h0;	// consts.scala:270:20, register-read.scala:174:38
    _GEN_7 = io_bypass_3_bits_uop_dst_rtype != 2'h2;	// consts.scala:277:20, micro-op.scala:149:36
    _GEN_8 = io_bypass_3_bits_uop_dst_rtype == 2'h0;	// consts.scala:270:20, register-read.scala:174:38
    _GEN_9 = rrd_uops_1_REG_lrs1_rtype == 2'h0;	// consts.scala:270:20, register-read.scala:86:29, :174:63
    _GEN_10 = rrd_uops_1_REG_lrs2_rtype == 2'h0;	// consts.scala:270:20, register-read.scala:86:29, :176:63
    _GEN_11 = rrd_uops_2_REG_lrs1_rtype == 2'h0;	// consts.scala:270:20, register-read.scala:86:29, :174:63
    _GEN_12 = rrd_uops_2_REG_lrs2_rtype == 2'h0;	// consts.scala:270:20, register-read.scala:86:29, :176:63
    if (reset) begin
      exe_reg_valids_0 <= 1'h0;	// register-read.scala:69:33, :80:33
      exe_reg_valids_1 <= 1'h0;	// register-read.scala:69:33, :80:33
      exe_reg_valids_2 <= 1'h0;	// register-read.scala:69:33, :80:33
    end
    else begin
      exe_reg_valids_0 <= ~rrd_kill & rrd_valids_0_REG;	// register-read.scala:69:33, :84:29, :130:28, :132:29
      exe_reg_valids_1 <= ~rrd_kill_1 & rrd_valids_1_REG;	// register-read.scala:69:33, :84:29, :130:28, :132:29
      exe_reg_valids_2 <= ~rrd_kill_2 & rrd_valids_2_REG;	// register-read.scala:69:33, :84:29, :130:28, :132:29
    end
    if (rrd_kill) begin	// register-read.scala:130:28
      exe_reg_uops_0_uopc <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_0_inst <= 32'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_debug_inst <= 32'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_debug_pc <= 40'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_iq_type <= 3'h0;	// register-read.scala:70:29, :80:33
      exe_reg_uops_0_fu_code <= 10'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_ctrl_br_type <= 4'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_ctrl_op1_sel <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_ctrl_op2_sel <= 3'h0;	// register-read.scala:70:29, :80:33
      exe_reg_uops_0_ctrl_imm_sel <= 3'h0;	// register-read.scala:70:29, :80:33
      exe_reg_uops_0_ctrl_op_fcn <= 4'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_iw_state <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_br_tag <= 4'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_ftq_idx <= 5'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_0_pc_lob <= 6'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_imm_packed <= 20'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_csr_addr <= 12'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_rob_idx <= 6'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_ldq_idx <= 4'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_stq_idx <= 4'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_rxq_idx <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_pdst <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_0_prs1 <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_0_prs2 <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_0_prs3 <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_0_ppred <= 5'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_0_stale_pdst <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_0_exc_cause <= 64'h0;	// register-read.scala:70:29
      exe_reg_uops_0_mem_cmd <= 5'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_0_mem_size <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_ldst <= 6'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_lrs1 <= 6'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_lrs2 <= 6'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_lrs3 <= 6'h0;	// consts.scala:270:20, register-read.scala:70:29
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
      exe_reg_uops_1_uopc <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_1_inst <= 32'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_debug_inst <= 32'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_debug_pc <= 40'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_iq_type <= 3'h0;	// register-read.scala:70:29, :80:33
      exe_reg_uops_1_fu_code <= 10'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_ctrl_br_type <= 4'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_ctrl_op1_sel <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_ctrl_op2_sel <= 3'h0;	// register-read.scala:70:29, :80:33
      exe_reg_uops_1_ctrl_imm_sel <= 3'h0;	// register-read.scala:70:29, :80:33
      exe_reg_uops_1_ctrl_op_fcn <= 4'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_iw_state <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_br_tag <= 4'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_ftq_idx <= 5'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_1_pc_lob <= 6'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_imm_packed <= 20'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_csr_addr <= 12'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_rob_idx <= 6'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_ldq_idx <= 4'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_stq_idx <= 4'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_rxq_idx <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_pdst <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_1_prs1 <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_1_prs2 <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_1_prs3 <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_1_ppred <= 5'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_1_stale_pdst <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_1_exc_cause <= 64'h0;	// register-read.scala:70:29
      exe_reg_uops_1_mem_cmd <= 5'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_1_mem_size <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_ldst <= 6'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_lrs1 <= 6'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_lrs2 <= 6'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_lrs3 <= 6'h0;	// consts.scala:270:20, register-read.scala:70:29
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
      exe_reg_uops_2_uopc <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_2_fu_code <= 10'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_ctrl_br_type <= 4'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_ctrl_op1_sel <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_ctrl_op2_sel <= 3'h0;	// register-read.scala:70:29, :80:33
      exe_reg_uops_2_ctrl_imm_sel <= 3'h0;	// register-read.scala:70:29, :80:33
      exe_reg_uops_2_ctrl_op_fcn <= 4'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_ctrl_csr_cmd <= 3'h0;	// register-read.scala:70:29, :80:33
      exe_reg_uops_2_br_tag <= 4'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_ftq_idx <= 5'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_2_pc_lob <= 6'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_imm_packed <= 20'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_rob_idx <= 6'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_ldq_idx <= 4'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_stq_idx <= 4'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_pdst <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_2_prs1 <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_2_dst_rtype <= 2'h2;	// consts.scala:277:20, register-read.scala:70:29
    end
    else begin	// register-read.scala:130:28
      exe_reg_uops_2_uopc <= rrd_uops_2_REG_uopc;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_fu_code <= rrd_uops_2_REG_fu_code;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_ctrl_br_type <= rrd_uops_2_REG_ctrl_br_type;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_ctrl_op1_sel <= rrd_uops_2_REG_ctrl_op1_sel;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_ctrl_op2_sel <= rrd_uops_2_REG_ctrl_op2_sel;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_ctrl_imm_sel <= rrd_uops_2_REG_ctrl_imm_sel;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_ctrl_op_fcn <= rrd_uops_2_REG_ctrl_op_fcn;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_ctrl_csr_cmd <= rrd_uops_2_REG_ctrl_csr_cmd;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_br_tag <= rrd_uops_2_REG_br_tag;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_ftq_idx <= rrd_uops_2_REG_ftq_idx;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_pc_lob <= rrd_uops_2_REG_pc_lob;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_imm_packed <= rrd_uops_2_REG_imm_packed;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_rob_idx <= rrd_uops_2_REG_rob_idx;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_ldq_idx <= rrd_uops_2_REG_ldq_idx;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_stq_idx <= rrd_uops_2_REG_stq_idx;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_pdst <= rrd_uops_2_REG_pdst;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_prs1 <= rrd_uops_2_REG_prs1;	// register-read.scala:70:29, :86:29
      exe_reg_uops_2_dst_rtype <= rrd_uops_2_REG_dst_rtype;	// register-read.scala:70:29, :86:29
    end
    exe_reg_uops_2_is_rvc <= ~rrd_kill_2 & rrd_uops_2_REG_is_rvc;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_ctrl_fcn_dw <= ~rrd_kill_2 & rrd_uops_2_REG_ctrl_fcn_dw;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_is_br <= ~rrd_kill_2 & rrd_uops_2_REG_is_br;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_is_jalr <= ~rrd_kill_2 & rrd_uops_2_REG_is_jalr;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_is_jal <= ~rrd_kill_2 & rrd_uops_2_REG_is_jal;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_is_sfb <= ~rrd_kill_2 & rrd_uops_2_REG_is_sfb;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_br_mask <= rrd_uops_2_REG_br_mask & ~io_brupdate_b1_resolve_mask;	// register-read.scala:70:29, :86:29, util.scala:74:37, :85:25
    exe_reg_uops_2_edge_inst <= ~rrd_kill_2 & rrd_uops_2_REG_edge_inst;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_taken <= ~rrd_kill_2 & rrd_uops_2_REG_taken;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_bypassable <= ~rrd_kill_2 & rrd_uops_2_REG_bypassable;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_is_amo <= ~rrd_kill_2 & rrd_uops_2_REG_is_amo;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_2_uses_stq <= ~rrd_kill_2 & rrd_uops_2_REG_uses_stq;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
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
    else if (rrd_rs1_data_0_REG)	// register-read.scala:124:57
      exe_reg_rs1_data_0 <= 64'h0;	// register-read.scala:71:29
    else	// register-read.scala:124:57
      exe_reg_rs1_data_0 <= io_rf_read_ports_0_data;	// register-read.scala:71:29
    if (io_bypass_0_valid & rrd_uops_1_REG_prs1 == io_bypass_0_bits_uop_pdst & _GEN
        & _GEN_0 & _GEN_9 & (|rrd_uops_1_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_1 <= io_bypass_0_bits_data;	// register-read.scala:71:29
    else if (io_bypass_1_valid & rrd_uops_1_REG_prs1 == io_bypass_1_bits_uop_pdst & _GEN_3
             & _GEN_4 & _GEN_9 & (|rrd_uops_1_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_1 <= io_bypass_1_bits_data;	// register-read.scala:71:29
    else if (io_bypass_2_valid & rrd_uops_1_REG_prs1 == io_bypass_2_bits_uop_pdst & _GEN_5
             & _GEN_6 & _GEN_9 & (|rrd_uops_1_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_1 <= io_bypass_2_bits_data;	// register-read.scala:71:29
    else if (io_bypass_3_valid & rrd_uops_1_REG_prs1 == io_bypass_3_bits_uop_pdst & _GEN_7
             & _GEN_8 & _GEN_9 & (|rrd_uops_1_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_1 <= io_bypass_3_bits_data;	// register-read.scala:71:29
    else if (rrd_rs1_data_1_REG)	// register-read.scala:124:57
      exe_reg_rs1_data_1 <= 64'h0;	// register-read.scala:71:29
    else	// register-read.scala:124:57
      exe_reg_rs1_data_1 <= io_rf_read_ports_2_data;	// register-read.scala:71:29
    if (io_bypass_0_valid & rrd_uops_2_REG_prs1 == io_bypass_0_bits_uop_pdst & _GEN
        & _GEN_0 & _GEN_11 & (|rrd_uops_2_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_2 <= io_bypass_0_bits_data;	// register-read.scala:71:29
    else if (io_bypass_1_valid & rrd_uops_2_REG_prs1 == io_bypass_1_bits_uop_pdst & _GEN_3
             & _GEN_4 & _GEN_11 & (|rrd_uops_2_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_2 <= io_bypass_1_bits_data;	// register-read.scala:71:29
    else if (io_bypass_2_valid & rrd_uops_2_REG_prs1 == io_bypass_2_bits_uop_pdst & _GEN_5
             & _GEN_6 & _GEN_11 & (|rrd_uops_2_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_2 <= io_bypass_2_bits_data;	// register-read.scala:71:29
    else if (io_bypass_3_valid & rrd_uops_2_REG_prs1 == io_bypass_3_bits_uop_pdst & _GEN_7
             & _GEN_8 & _GEN_11 & (|rrd_uops_2_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_2 <= io_bypass_3_bits_data;	// register-read.scala:71:29
    else if (rrd_rs1_data_2_REG)	// register-read.scala:124:57
      exe_reg_rs1_data_2 <= 64'h0;	// register-read.scala:71:29
    else	// register-read.scala:124:57
      exe_reg_rs1_data_2 <= io_rf_read_ports_4_data;	// register-read.scala:71:29
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
    else if (rrd_rs2_data_0_REG)	// register-read.scala:125:57
      exe_reg_rs2_data_0 <= 64'h0;	// register-read.scala:72:29
    else	// register-read.scala:125:57
      exe_reg_rs2_data_0 <= io_rf_read_ports_1_data;	// register-read.scala:72:29
    if (io_bypass_0_valid & rrd_uops_1_REG_prs2 == io_bypass_0_bits_uop_pdst & _GEN
        & _GEN_0 & _GEN_10 & (|rrd_uops_1_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_1 <= io_bypass_0_bits_data;	// register-read.scala:72:29
    else if (io_bypass_1_valid & rrd_uops_1_REG_prs2 == io_bypass_1_bits_uop_pdst & _GEN_3
             & _GEN_4 & _GEN_10 & (|rrd_uops_1_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_1 <= io_bypass_1_bits_data;	// register-read.scala:72:29
    else if (io_bypass_2_valid & rrd_uops_1_REG_prs2 == io_bypass_2_bits_uop_pdst & _GEN_5
             & _GEN_6 & _GEN_10 & (|rrd_uops_1_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_1 <= io_bypass_2_bits_data;	// register-read.scala:72:29
    else if (io_bypass_3_valid & rrd_uops_1_REG_prs2 == io_bypass_3_bits_uop_pdst & _GEN_7
             & _GEN_8 & _GEN_10 & (|rrd_uops_1_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_1 <= io_bypass_3_bits_data;	// register-read.scala:72:29
    else if (rrd_rs2_data_1_REG)	// register-read.scala:125:57
      exe_reg_rs2_data_1 <= 64'h0;	// register-read.scala:72:29
    else	// register-read.scala:125:57
      exe_reg_rs2_data_1 <= io_rf_read_ports_3_data;	// register-read.scala:72:29
    if (io_bypass_0_valid & rrd_uops_2_REG_prs2 == io_bypass_0_bits_uop_pdst & _GEN
        & _GEN_0 & _GEN_12 & (|rrd_uops_2_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_2 <= io_bypass_0_bits_data;	// register-read.scala:72:29
    else if (io_bypass_1_valid & rrd_uops_2_REG_prs2 == io_bypass_1_bits_uop_pdst & _GEN_3
             & _GEN_4 & _GEN_12 & (|rrd_uops_2_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_2 <= io_bypass_1_bits_data;	// register-read.scala:72:29
    else if (io_bypass_2_valid & rrd_uops_2_REG_prs2 == io_bypass_2_bits_uop_pdst & _GEN_5
             & _GEN_6 & _GEN_12 & (|rrd_uops_2_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_2 <= io_bypass_2_bits_data;	// register-read.scala:72:29
    else if (io_bypass_3_valid & rrd_uops_2_REG_prs2 == io_bypass_3_bits_uop_pdst & _GEN_7
             & _GEN_8 & _GEN_12 & (|rrd_uops_2_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_2 <= io_bypass_3_bits_data;	// register-read.scala:72:29
    else if (rrd_rs2_data_2_REG)	// register-read.scala:125:57
      exe_reg_rs2_data_2 <= 64'h0;	// register-read.scala:72:29
    else	// register-read.scala:125:57
      exe_reg_rs2_data_2 <= io_rf_read_ports_5_data;	// register-read.scala:72:29
    rrd_valids_0_REG <=
      io_iss_valids_0 & (io_brupdate_b1_mispredict_mask & io_iss_uops_0_br_mask) == 12'h0;	// consts.scala:270:20, register-read.scala:84:{29,59}, util.scala:118:{51,59}
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
      io_iss_valids_1 & (io_brupdate_b1_mispredict_mask & io_iss_uops_1_br_mask) == 12'h0;	// consts.scala:270:20, register-read.scala:84:{29,59}, util.scala:118:{51,59}
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
      io_iss_valids_2 & (io_brupdate_b1_mispredict_mask & io_iss_uops_2_br_mask) == 12'h0;	// consts.scala:270:20, register-read.scala:84:{29,59}, util.scala:118:{51,59}
    rrd_uops_2_REG_uopc <= io_iss_uops_2_uopc;	// register-read.scala:86:29
    rrd_uops_2_REG_is_rvc <= io_iss_uops_2_is_rvc;	// register-read.scala:86:29
    rrd_uops_2_REG_fu_code <= io_iss_uops_2_fu_code;	// register-read.scala:86:29
    rrd_uops_2_REG_ctrl_br_type <= _rrd_decode_unit_2_io_rrd_uop_ctrl_br_type;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_ctrl_op1_sel <= _rrd_decode_unit_2_io_rrd_uop_ctrl_op1_sel;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_ctrl_op2_sel <= _rrd_decode_unit_2_io_rrd_uop_ctrl_op2_sel;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_ctrl_imm_sel <= _rrd_decode_unit_2_io_rrd_uop_ctrl_imm_sel;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_ctrl_op_fcn <= _rrd_decode_unit_2_io_rrd_uop_ctrl_op_fcn;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_ctrl_fcn_dw <= _rrd_decode_unit_2_io_rrd_uop_ctrl_fcn_dw;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_ctrl_csr_cmd <= _rrd_decode_unit_2_io_rrd_uop_ctrl_csr_cmd;	// register-read.scala:80:33, :86:29
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
    rrd_uops_2_REG_rob_idx <= io_iss_uops_2_rob_idx;	// register-read.scala:86:29
    rrd_uops_2_REG_ldq_idx <= io_iss_uops_2_ldq_idx;	// register-read.scala:86:29
    rrd_uops_2_REG_stq_idx <= io_iss_uops_2_stq_idx;	// register-read.scala:86:29
    rrd_uops_2_REG_pdst <= io_iss_uops_2_pdst;	// register-read.scala:86:29
    rrd_uops_2_REG_prs1 <= io_iss_uops_2_prs1;	// register-read.scala:86:29
    rrd_uops_2_REG_prs2 <= io_iss_uops_2_prs2;	// register-read.scala:86:29
    rrd_uops_2_REG_bypassable <= io_iss_uops_2_bypassable;	// register-read.scala:86:29
    rrd_uops_2_REG_is_amo <= io_iss_uops_2_is_amo;	// register-read.scala:86:29
    rrd_uops_2_REG_uses_stq <= io_iss_uops_2_uses_stq;	// register-read.scala:86:29
    rrd_uops_2_REG_dst_rtype <= io_iss_uops_2_dst_rtype;	// register-read.scala:86:29
    rrd_uops_2_REG_lrs1_rtype <= io_iss_uops_2_lrs1_rtype;	// register-read.scala:86:29
    rrd_uops_2_REG_lrs2_rtype <= io_iss_uops_2_lrs2_rtype;	// register-read.scala:86:29
    rrd_rs1_data_0_REG <= io_iss_uops_0_prs1 == 7'h0;	// register-read.scala:124:{57,67}
    rrd_rs2_data_0_REG <= io_iss_uops_0_prs2 == 7'h0;	// register-read.scala:125:{57,67}
    rrd_rs1_data_1_REG <= io_iss_uops_1_prs1 == 7'h0;	// register-read.scala:124:{57,67}
    rrd_rs2_data_1_REG <= io_iss_uops_1_prs2 == 7'h0;	// register-read.scala:125:{57,67}
    rrd_rs1_data_2_REG <= io_iss_uops_2_prs1 == 7'h0;	// register-read.scala:124:{57,67}
    rrd_rs2_data_2_REG <= io_iss_uops_2_prs2 == 7'h0;	// register-read.scala:125:{57,67}
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:94];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [6:0] i = 7'h0; i < 7'h5F; i += 7'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        exe_reg_valids_0 = _RANDOM[7'h0][0];	// register-read.scala:69:33
        exe_reg_valids_1 = _RANDOM[7'h0][1];	// register-read.scala:69:33
        exe_reg_valids_2 = _RANDOM[7'h0][2];	// register-read.scala:69:33
        exe_reg_uops_0_uopc = _RANDOM[7'h0][9:3];	// register-read.scala:69:33, :70:29
        exe_reg_uops_0_inst = {_RANDOM[7'h0][31:10], _RANDOM[7'h1][9:0]};	// register-read.scala:69:33, :70:29
        exe_reg_uops_0_debug_inst = {_RANDOM[7'h1][31:10], _RANDOM[7'h2][9:0]};	// register-read.scala:70:29
        exe_reg_uops_0_is_rvc = _RANDOM[7'h2][10];	// register-read.scala:70:29
        exe_reg_uops_0_debug_pc = {_RANDOM[7'h2][31:11], _RANDOM[7'h3][18:0]};	// register-read.scala:70:29
        exe_reg_uops_0_iq_type = _RANDOM[7'h3][21:19];	// register-read.scala:70:29
        exe_reg_uops_0_fu_code = _RANDOM[7'h3][31:22];	// register-read.scala:70:29
        exe_reg_uops_0_ctrl_br_type = _RANDOM[7'h4][3:0];	// register-read.scala:70:29
        exe_reg_uops_0_ctrl_op1_sel = _RANDOM[7'h4][5:4];	// register-read.scala:70:29
        exe_reg_uops_0_ctrl_op2_sel = _RANDOM[7'h4][8:6];	// register-read.scala:70:29
        exe_reg_uops_0_ctrl_imm_sel = _RANDOM[7'h4][11:9];	// register-read.scala:70:29
        exe_reg_uops_0_ctrl_op_fcn = _RANDOM[7'h4][15:12];	// register-read.scala:70:29
        exe_reg_uops_0_ctrl_fcn_dw = _RANDOM[7'h4][16];	// register-read.scala:70:29
        exe_reg_uops_0_ctrl_is_load = _RANDOM[7'h4][20];	// register-read.scala:70:29
        exe_reg_uops_0_ctrl_is_sta = _RANDOM[7'h4][21];	// register-read.scala:70:29
        exe_reg_uops_0_ctrl_is_std = _RANDOM[7'h4][22];	// register-read.scala:70:29
        exe_reg_uops_0_iw_state = _RANDOM[7'h4][24:23];	// register-read.scala:70:29
        exe_reg_uops_0_is_br = _RANDOM[7'h4][27];	// register-read.scala:70:29
        exe_reg_uops_0_is_jalr = _RANDOM[7'h4][28];	// register-read.scala:70:29
        exe_reg_uops_0_is_jal = _RANDOM[7'h4][29];	// register-read.scala:70:29
        exe_reg_uops_0_is_sfb = _RANDOM[7'h4][30];	// register-read.scala:70:29
        exe_reg_uops_0_br_mask = {_RANDOM[7'h4][31], _RANDOM[7'h5][10:0]};	// register-read.scala:70:29
        exe_reg_uops_0_br_tag = _RANDOM[7'h5][14:11];	// register-read.scala:70:29
        exe_reg_uops_0_ftq_idx = _RANDOM[7'h5][19:15];	// register-read.scala:70:29
        exe_reg_uops_0_edge_inst = _RANDOM[7'h5][20];	// register-read.scala:70:29
        exe_reg_uops_0_pc_lob = _RANDOM[7'h5][26:21];	// register-read.scala:70:29
        exe_reg_uops_0_taken = _RANDOM[7'h5][27];	// register-read.scala:70:29
        exe_reg_uops_0_imm_packed = {_RANDOM[7'h5][31:28], _RANDOM[7'h6][15:0]};	// register-read.scala:70:29
        exe_reg_uops_0_csr_addr = _RANDOM[7'h6][27:16];	// register-read.scala:70:29
        exe_reg_uops_0_rob_idx = {_RANDOM[7'h6][31:28], _RANDOM[7'h7][1:0]};	// register-read.scala:70:29
        exe_reg_uops_0_ldq_idx = _RANDOM[7'h7][5:2];	// register-read.scala:70:29
        exe_reg_uops_0_stq_idx = _RANDOM[7'h7][9:6];	// register-read.scala:70:29
        exe_reg_uops_0_rxq_idx = _RANDOM[7'h7][11:10];	// register-read.scala:70:29
        exe_reg_uops_0_pdst = _RANDOM[7'h7][18:12];	// register-read.scala:70:29
        exe_reg_uops_0_prs1 = _RANDOM[7'h7][25:19];	// register-read.scala:70:29
        exe_reg_uops_0_prs2 = {_RANDOM[7'h7][31:26], _RANDOM[7'h8][0]};	// register-read.scala:70:29
        exe_reg_uops_0_prs3 = _RANDOM[7'h8][7:1];	// register-read.scala:70:29
        exe_reg_uops_0_ppred = _RANDOM[7'h8][12:8];	// register-read.scala:70:29
        exe_reg_uops_0_prs1_busy = _RANDOM[7'h8][13];	// register-read.scala:70:29
        exe_reg_uops_0_prs2_busy = _RANDOM[7'h8][14];	// register-read.scala:70:29
        exe_reg_uops_0_prs3_busy = _RANDOM[7'h8][15];	// register-read.scala:70:29
        exe_reg_uops_0_ppred_busy = _RANDOM[7'h8][16];	// register-read.scala:70:29
        exe_reg_uops_0_stale_pdst = _RANDOM[7'h8][23:17];	// register-read.scala:70:29
        exe_reg_uops_0_exception = _RANDOM[7'h8][24];	// register-read.scala:70:29
        exe_reg_uops_0_exc_cause =
          {_RANDOM[7'h8][31:25], _RANDOM[7'h9], _RANDOM[7'hA][24:0]};	// register-read.scala:70:29
        exe_reg_uops_0_bypassable = _RANDOM[7'hA][25];	// register-read.scala:70:29
        exe_reg_uops_0_mem_cmd = _RANDOM[7'hA][30:26];	// register-read.scala:70:29
        exe_reg_uops_0_mem_size = {_RANDOM[7'hA][31], _RANDOM[7'hB][0]};	// register-read.scala:70:29
        exe_reg_uops_0_mem_signed = _RANDOM[7'hB][1];	// register-read.scala:70:29
        exe_reg_uops_0_is_fence = _RANDOM[7'hB][2];	// register-read.scala:70:29
        exe_reg_uops_0_is_fencei = _RANDOM[7'hB][3];	// register-read.scala:70:29
        exe_reg_uops_0_is_amo = _RANDOM[7'hB][4];	// register-read.scala:70:29
        exe_reg_uops_0_uses_ldq = _RANDOM[7'hB][5];	// register-read.scala:70:29
        exe_reg_uops_0_uses_stq = _RANDOM[7'hB][6];	// register-read.scala:70:29
        exe_reg_uops_0_is_sys_pc2epc = _RANDOM[7'hB][7];	// register-read.scala:70:29
        exe_reg_uops_0_is_unique = _RANDOM[7'hB][8];	// register-read.scala:70:29
        exe_reg_uops_0_flush_on_commit = _RANDOM[7'hB][9];	// register-read.scala:70:29
        exe_reg_uops_0_ldst_is_rs1 = _RANDOM[7'hB][10];	// register-read.scala:70:29
        exe_reg_uops_0_ldst = _RANDOM[7'hB][16:11];	// register-read.scala:70:29
        exe_reg_uops_0_lrs1 = _RANDOM[7'hB][22:17];	// register-read.scala:70:29
        exe_reg_uops_0_lrs2 = _RANDOM[7'hB][28:23];	// register-read.scala:70:29
        exe_reg_uops_0_lrs3 = {_RANDOM[7'hB][31:29], _RANDOM[7'hC][2:0]};	// register-read.scala:70:29
        exe_reg_uops_0_ldst_val = _RANDOM[7'hC][3];	// register-read.scala:70:29
        exe_reg_uops_0_dst_rtype = _RANDOM[7'hC][5:4];	// register-read.scala:70:29
        exe_reg_uops_0_lrs1_rtype = _RANDOM[7'hC][7:6];	// register-read.scala:70:29
        exe_reg_uops_0_lrs2_rtype = _RANDOM[7'hC][9:8];	// register-read.scala:70:29
        exe_reg_uops_0_frs3_en = _RANDOM[7'hC][10];	// register-read.scala:70:29
        exe_reg_uops_0_fp_val = _RANDOM[7'hC][11];	// register-read.scala:70:29
        exe_reg_uops_0_fp_single = _RANDOM[7'hC][12];	// register-read.scala:70:29
        exe_reg_uops_0_xcpt_pf_if = _RANDOM[7'hC][13];	// register-read.scala:70:29
        exe_reg_uops_0_xcpt_ae_if = _RANDOM[7'hC][14];	// register-read.scala:70:29
        exe_reg_uops_0_xcpt_ma_if = _RANDOM[7'hC][15];	// register-read.scala:70:29
        exe_reg_uops_0_bp_debug_if = _RANDOM[7'hC][16];	// register-read.scala:70:29
        exe_reg_uops_0_bp_xcpt_if = _RANDOM[7'hC][17];	// register-read.scala:70:29
        exe_reg_uops_0_debug_fsrc = _RANDOM[7'hC][19:18];	// register-read.scala:70:29
        exe_reg_uops_0_debug_tsrc = _RANDOM[7'hC][21:20];	// register-read.scala:70:29
        exe_reg_uops_1_uopc = _RANDOM[7'hC][28:22];	// register-read.scala:70:29
        exe_reg_uops_1_inst = {_RANDOM[7'hC][31:29], _RANDOM[7'hD][28:0]};	// register-read.scala:70:29
        exe_reg_uops_1_debug_inst = {_RANDOM[7'hD][31:29], _RANDOM[7'hE][28:0]};	// register-read.scala:70:29
        exe_reg_uops_1_is_rvc = _RANDOM[7'hE][29];	// register-read.scala:70:29
        exe_reg_uops_1_debug_pc =
          {_RANDOM[7'hE][31:30], _RANDOM[7'hF], _RANDOM[7'h10][5:0]};	// register-read.scala:70:29
        exe_reg_uops_1_iq_type = _RANDOM[7'h10][8:6];	// register-read.scala:70:29
        exe_reg_uops_1_fu_code = _RANDOM[7'h10][18:9];	// register-read.scala:70:29
        exe_reg_uops_1_ctrl_br_type = _RANDOM[7'h10][22:19];	// register-read.scala:70:29
        exe_reg_uops_1_ctrl_op1_sel = _RANDOM[7'h10][24:23];	// register-read.scala:70:29
        exe_reg_uops_1_ctrl_op2_sel = _RANDOM[7'h10][27:25];	// register-read.scala:70:29
        exe_reg_uops_1_ctrl_imm_sel = _RANDOM[7'h10][30:28];	// register-read.scala:70:29
        exe_reg_uops_1_ctrl_op_fcn = {_RANDOM[7'h10][31], _RANDOM[7'h11][2:0]};	// register-read.scala:70:29
        exe_reg_uops_1_ctrl_fcn_dw = _RANDOM[7'h11][3];	// register-read.scala:70:29
        exe_reg_uops_1_ctrl_is_load = _RANDOM[7'h11][7];	// register-read.scala:70:29
        exe_reg_uops_1_ctrl_is_sta = _RANDOM[7'h11][8];	// register-read.scala:70:29
        exe_reg_uops_1_ctrl_is_std = _RANDOM[7'h11][9];	// register-read.scala:70:29
        exe_reg_uops_1_iw_state = _RANDOM[7'h11][11:10];	// register-read.scala:70:29
        exe_reg_uops_1_is_br = _RANDOM[7'h11][14];	// register-read.scala:70:29
        exe_reg_uops_1_is_jalr = _RANDOM[7'h11][15];	// register-read.scala:70:29
        exe_reg_uops_1_is_jal = _RANDOM[7'h11][16];	// register-read.scala:70:29
        exe_reg_uops_1_is_sfb = _RANDOM[7'h11][17];	// register-read.scala:70:29
        exe_reg_uops_1_br_mask = _RANDOM[7'h11][29:18];	// register-read.scala:70:29
        exe_reg_uops_1_br_tag = {_RANDOM[7'h11][31:30], _RANDOM[7'h12][1:0]};	// register-read.scala:70:29
        exe_reg_uops_1_ftq_idx = _RANDOM[7'h12][6:2];	// register-read.scala:70:29
        exe_reg_uops_1_edge_inst = _RANDOM[7'h12][7];	// register-read.scala:70:29
        exe_reg_uops_1_pc_lob = _RANDOM[7'h12][13:8];	// register-read.scala:70:29
        exe_reg_uops_1_taken = _RANDOM[7'h12][14];	// register-read.scala:70:29
        exe_reg_uops_1_imm_packed = {_RANDOM[7'h12][31:15], _RANDOM[7'h13][2:0]};	// register-read.scala:70:29
        exe_reg_uops_1_csr_addr = _RANDOM[7'h13][14:3];	// register-read.scala:70:29
        exe_reg_uops_1_rob_idx = _RANDOM[7'h13][20:15];	// register-read.scala:70:29
        exe_reg_uops_1_ldq_idx = _RANDOM[7'h13][24:21];	// register-read.scala:70:29
        exe_reg_uops_1_stq_idx = _RANDOM[7'h13][28:25];	// register-read.scala:70:29
        exe_reg_uops_1_rxq_idx = _RANDOM[7'h13][30:29];	// register-read.scala:70:29
        exe_reg_uops_1_pdst = {_RANDOM[7'h13][31], _RANDOM[7'h14][5:0]};	// register-read.scala:70:29
        exe_reg_uops_1_prs1 = _RANDOM[7'h14][12:6];	// register-read.scala:70:29
        exe_reg_uops_1_prs2 = _RANDOM[7'h14][19:13];	// register-read.scala:70:29
        exe_reg_uops_1_prs3 = _RANDOM[7'h14][26:20];	// register-read.scala:70:29
        exe_reg_uops_1_ppred = _RANDOM[7'h14][31:27];	// register-read.scala:70:29
        exe_reg_uops_1_prs1_busy = _RANDOM[7'h15][0];	// register-read.scala:70:29
        exe_reg_uops_1_prs2_busy = _RANDOM[7'h15][1];	// register-read.scala:70:29
        exe_reg_uops_1_prs3_busy = _RANDOM[7'h15][2];	// register-read.scala:70:29
        exe_reg_uops_1_ppred_busy = _RANDOM[7'h15][3];	// register-read.scala:70:29
        exe_reg_uops_1_stale_pdst = _RANDOM[7'h15][10:4];	// register-read.scala:70:29
        exe_reg_uops_1_exception = _RANDOM[7'h15][11];	// register-read.scala:70:29
        exe_reg_uops_1_exc_cause =
          {_RANDOM[7'h15][31:12], _RANDOM[7'h16], _RANDOM[7'h17][11:0]};	// register-read.scala:70:29
        exe_reg_uops_1_bypassable = _RANDOM[7'h17][12];	// register-read.scala:70:29
        exe_reg_uops_1_mem_cmd = _RANDOM[7'h17][17:13];	// register-read.scala:70:29
        exe_reg_uops_1_mem_size = _RANDOM[7'h17][19:18];	// register-read.scala:70:29
        exe_reg_uops_1_mem_signed = _RANDOM[7'h17][20];	// register-read.scala:70:29
        exe_reg_uops_1_is_fence = _RANDOM[7'h17][21];	// register-read.scala:70:29
        exe_reg_uops_1_is_fencei = _RANDOM[7'h17][22];	// register-read.scala:70:29
        exe_reg_uops_1_is_amo = _RANDOM[7'h17][23];	// register-read.scala:70:29
        exe_reg_uops_1_uses_ldq = _RANDOM[7'h17][24];	// register-read.scala:70:29
        exe_reg_uops_1_uses_stq = _RANDOM[7'h17][25];	// register-read.scala:70:29
        exe_reg_uops_1_is_sys_pc2epc = _RANDOM[7'h17][26];	// register-read.scala:70:29
        exe_reg_uops_1_is_unique = _RANDOM[7'h17][27];	// register-read.scala:70:29
        exe_reg_uops_1_flush_on_commit = _RANDOM[7'h17][28];	// register-read.scala:70:29
        exe_reg_uops_1_ldst_is_rs1 = _RANDOM[7'h17][29];	// register-read.scala:70:29
        exe_reg_uops_1_ldst = {_RANDOM[7'h17][31:30], _RANDOM[7'h18][3:0]};	// register-read.scala:70:29
        exe_reg_uops_1_lrs1 = _RANDOM[7'h18][9:4];	// register-read.scala:70:29
        exe_reg_uops_1_lrs2 = _RANDOM[7'h18][15:10];	// register-read.scala:70:29
        exe_reg_uops_1_lrs3 = _RANDOM[7'h18][21:16];	// register-read.scala:70:29
        exe_reg_uops_1_ldst_val = _RANDOM[7'h18][22];	// register-read.scala:70:29
        exe_reg_uops_1_dst_rtype = _RANDOM[7'h18][24:23];	// register-read.scala:70:29
        exe_reg_uops_1_lrs1_rtype = _RANDOM[7'h18][26:25];	// register-read.scala:70:29
        exe_reg_uops_1_lrs2_rtype = _RANDOM[7'h18][28:27];	// register-read.scala:70:29
        exe_reg_uops_1_frs3_en = _RANDOM[7'h18][29];	// register-read.scala:70:29
        exe_reg_uops_1_fp_val = _RANDOM[7'h18][30];	// register-read.scala:70:29
        exe_reg_uops_1_fp_single = _RANDOM[7'h18][31];	// register-read.scala:70:29
        exe_reg_uops_1_xcpt_pf_if = _RANDOM[7'h19][0];	// register-read.scala:70:29
        exe_reg_uops_1_xcpt_ae_if = _RANDOM[7'h19][1];	// register-read.scala:70:29
        exe_reg_uops_1_xcpt_ma_if = _RANDOM[7'h19][2];	// register-read.scala:70:29
        exe_reg_uops_1_bp_debug_if = _RANDOM[7'h19][3];	// register-read.scala:70:29
        exe_reg_uops_1_bp_xcpt_if = _RANDOM[7'h19][4];	// register-read.scala:70:29
        exe_reg_uops_1_debug_fsrc = _RANDOM[7'h19][6:5];	// register-read.scala:70:29
        exe_reg_uops_1_debug_tsrc = _RANDOM[7'h19][8:7];	// register-read.scala:70:29
        exe_reg_uops_2_uopc = _RANDOM[7'h19][15:9];	// register-read.scala:70:29
        exe_reg_uops_2_is_rvc = _RANDOM[7'h1B][16];	// register-read.scala:70:29
        exe_reg_uops_2_fu_code = {_RANDOM[7'h1C][31:28], _RANDOM[7'h1D][5:0]};	// register-read.scala:70:29
        exe_reg_uops_2_ctrl_br_type = _RANDOM[7'h1D][9:6];	// register-read.scala:70:29
        exe_reg_uops_2_ctrl_op1_sel = _RANDOM[7'h1D][11:10];	// register-read.scala:70:29
        exe_reg_uops_2_ctrl_op2_sel = _RANDOM[7'h1D][14:12];	// register-read.scala:70:29
        exe_reg_uops_2_ctrl_imm_sel = _RANDOM[7'h1D][17:15];	// register-read.scala:70:29
        exe_reg_uops_2_ctrl_op_fcn = _RANDOM[7'h1D][21:18];	// register-read.scala:70:29
        exe_reg_uops_2_ctrl_fcn_dw = _RANDOM[7'h1D][22];	// register-read.scala:70:29
        exe_reg_uops_2_ctrl_csr_cmd = _RANDOM[7'h1D][25:23];	// register-read.scala:70:29
        exe_reg_uops_2_is_br = _RANDOM[7'h1E][1];	// register-read.scala:70:29
        exe_reg_uops_2_is_jalr = _RANDOM[7'h1E][2];	// register-read.scala:70:29
        exe_reg_uops_2_is_jal = _RANDOM[7'h1E][3];	// register-read.scala:70:29
        exe_reg_uops_2_is_sfb = _RANDOM[7'h1E][4];	// register-read.scala:70:29
        exe_reg_uops_2_br_mask = _RANDOM[7'h1E][16:5];	// register-read.scala:70:29
        exe_reg_uops_2_br_tag = _RANDOM[7'h1E][20:17];	// register-read.scala:70:29
        exe_reg_uops_2_ftq_idx = _RANDOM[7'h1E][25:21];	// register-read.scala:70:29
        exe_reg_uops_2_edge_inst = _RANDOM[7'h1E][26];	// register-read.scala:70:29
        exe_reg_uops_2_pc_lob = {_RANDOM[7'h1E][31:27], _RANDOM[7'h1F][0]};	// register-read.scala:70:29
        exe_reg_uops_2_taken = _RANDOM[7'h1F][1];	// register-read.scala:70:29
        exe_reg_uops_2_imm_packed = _RANDOM[7'h1F][21:2];	// register-read.scala:70:29
        exe_reg_uops_2_rob_idx = _RANDOM[7'h20][7:2];	// register-read.scala:70:29
        exe_reg_uops_2_ldq_idx = _RANDOM[7'h20][11:8];	// register-read.scala:70:29
        exe_reg_uops_2_stq_idx = _RANDOM[7'h20][15:12];	// register-read.scala:70:29
        exe_reg_uops_2_pdst = _RANDOM[7'h20][24:18];	// register-read.scala:70:29
        exe_reg_uops_2_prs1 = _RANDOM[7'h20][31:25];	// register-read.scala:70:29
        exe_reg_uops_2_bypassable = _RANDOM[7'h23][31];	// register-read.scala:70:29
        exe_reg_uops_2_is_amo = _RANDOM[7'h24][10];	// register-read.scala:70:29
        exe_reg_uops_2_uses_stq = _RANDOM[7'h24][12];	// register-read.scala:70:29
        exe_reg_uops_2_dst_rtype = _RANDOM[7'h25][11:10];	// register-read.scala:70:29
        exe_reg_rs1_data_0 =
          {_RANDOM[7'h25][31:28], _RANDOM[7'h26], _RANDOM[7'h27][27:0]};	// register-read.scala:70:29, :71:29
        exe_reg_rs1_data_1 =
          {_RANDOM[7'h27][31:28], _RANDOM[7'h28], _RANDOM[7'h29][27:0]};	// register-read.scala:71:29
        exe_reg_rs1_data_2 =
          {_RANDOM[7'h29][31:28], _RANDOM[7'h2A], _RANDOM[7'h2B][27:0]};	// register-read.scala:71:29
        exe_reg_rs2_data_0 =
          {_RANDOM[7'h2B][31:28], _RANDOM[7'h2C], _RANDOM[7'h2D][27:0]};	// register-read.scala:71:29, :72:29
        exe_reg_rs2_data_1 =
          {_RANDOM[7'h2D][31:28], _RANDOM[7'h2E], _RANDOM[7'h2F][27:0]};	// register-read.scala:72:29
        exe_reg_rs2_data_2 =
          {_RANDOM[7'h2F][31:28], _RANDOM[7'h30], _RANDOM[7'h31][27:0]};	// register-read.scala:72:29
        rrd_valids_0_REG = _RANDOM[7'h37][31];	// register-read.scala:84:29
        rrd_uops_0_REG_uopc = _RANDOM[7'h38][6:0];	// register-read.scala:86:29
        rrd_uops_0_REG_inst = {_RANDOM[7'h38][31:7], _RANDOM[7'h39][6:0]};	// register-read.scala:86:29
        rrd_uops_0_REG_debug_inst = {_RANDOM[7'h39][31:7], _RANDOM[7'h3A][6:0]};	// register-read.scala:86:29
        rrd_uops_0_REG_is_rvc = _RANDOM[7'h3A][7];	// register-read.scala:86:29
        rrd_uops_0_REG_debug_pc = {_RANDOM[7'h3A][31:8], _RANDOM[7'h3B][15:0]};	// register-read.scala:86:29
        rrd_uops_0_REG_iq_type = _RANDOM[7'h3B][18:16];	// register-read.scala:86:29
        rrd_uops_0_REG_fu_code = _RANDOM[7'h3B][28:19];	// register-read.scala:86:29
        rrd_uops_0_REG_ctrl_br_type = {_RANDOM[7'h3B][31:29], _RANDOM[7'h3C][0]};	// register-read.scala:86:29
        rrd_uops_0_REG_ctrl_op1_sel = _RANDOM[7'h3C][2:1];	// register-read.scala:86:29
        rrd_uops_0_REG_ctrl_op2_sel = _RANDOM[7'h3C][5:3];	// register-read.scala:86:29
        rrd_uops_0_REG_ctrl_imm_sel = _RANDOM[7'h3C][8:6];	// register-read.scala:86:29
        rrd_uops_0_REG_ctrl_op_fcn = _RANDOM[7'h3C][12:9];	// register-read.scala:86:29
        rrd_uops_0_REG_ctrl_fcn_dw = _RANDOM[7'h3C][13];	// register-read.scala:86:29
        rrd_uops_0_REG_ctrl_is_load = _RANDOM[7'h3C][17];	// register-read.scala:86:29
        rrd_uops_0_REG_ctrl_is_sta = _RANDOM[7'h3C][18];	// register-read.scala:86:29
        rrd_uops_0_REG_ctrl_is_std = _RANDOM[7'h3C][19];	// register-read.scala:86:29
        rrd_uops_0_REG_iw_state = _RANDOM[7'h3C][21:20];	// register-read.scala:86:29
        rrd_uops_0_REG_is_br = _RANDOM[7'h3C][24];	// register-read.scala:86:29
        rrd_uops_0_REG_is_jalr = _RANDOM[7'h3C][25];	// register-read.scala:86:29
        rrd_uops_0_REG_is_jal = _RANDOM[7'h3C][26];	// register-read.scala:86:29
        rrd_uops_0_REG_is_sfb = _RANDOM[7'h3C][27];	// register-read.scala:86:29
        rrd_uops_0_REG_br_mask = {_RANDOM[7'h3C][31:28], _RANDOM[7'h3D][7:0]};	// register-read.scala:86:29
        rrd_uops_0_REG_br_tag = _RANDOM[7'h3D][11:8];	// register-read.scala:86:29
        rrd_uops_0_REG_ftq_idx = _RANDOM[7'h3D][16:12];	// register-read.scala:86:29
        rrd_uops_0_REG_edge_inst = _RANDOM[7'h3D][17];	// register-read.scala:86:29
        rrd_uops_0_REG_pc_lob = _RANDOM[7'h3D][23:18];	// register-read.scala:86:29
        rrd_uops_0_REG_taken = _RANDOM[7'h3D][24];	// register-read.scala:86:29
        rrd_uops_0_REG_imm_packed = {_RANDOM[7'h3D][31:25], _RANDOM[7'h3E][12:0]};	// register-read.scala:86:29
        rrd_uops_0_REG_csr_addr = _RANDOM[7'h3E][24:13];	// register-read.scala:86:29
        rrd_uops_0_REG_rob_idx = _RANDOM[7'h3E][30:25];	// register-read.scala:86:29
        rrd_uops_0_REG_ldq_idx = {_RANDOM[7'h3E][31], _RANDOM[7'h3F][2:0]};	// register-read.scala:86:29
        rrd_uops_0_REG_stq_idx = _RANDOM[7'h3F][6:3];	// register-read.scala:86:29
        rrd_uops_0_REG_rxq_idx = _RANDOM[7'h3F][8:7];	// register-read.scala:86:29
        rrd_uops_0_REG_pdst = _RANDOM[7'h3F][15:9];	// register-read.scala:86:29
        rrd_uops_0_REG_prs1 = _RANDOM[7'h3F][22:16];	// register-read.scala:86:29
        rrd_uops_0_REG_prs2 = _RANDOM[7'h3F][29:23];	// register-read.scala:86:29
        rrd_uops_0_REG_prs3 = {_RANDOM[7'h3F][31:30], _RANDOM[7'h40][4:0]};	// register-read.scala:86:29
        rrd_uops_0_REG_ppred = _RANDOM[7'h40][9:5];	// register-read.scala:86:29
        rrd_uops_0_REG_prs1_busy = _RANDOM[7'h40][10];	// register-read.scala:86:29
        rrd_uops_0_REG_prs2_busy = _RANDOM[7'h40][11];	// register-read.scala:86:29
        rrd_uops_0_REG_prs3_busy = _RANDOM[7'h40][12];	// register-read.scala:86:29
        rrd_uops_0_REG_ppred_busy = _RANDOM[7'h40][13];	// register-read.scala:86:29
        rrd_uops_0_REG_stale_pdst = _RANDOM[7'h40][20:14];	// register-read.scala:86:29
        rrd_uops_0_REG_exception = _RANDOM[7'h40][21];	// register-read.scala:86:29
        rrd_uops_0_REG_exc_cause =
          {_RANDOM[7'h40][31:22], _RANDOM[7'h41], _RANDOM[7'h42][21:0]};	// register-read.scala:86:29
        rrd_uops_0_REG_bypassable = _RANDOM[7'h42][22];	// register-read.scala:86:29
        rrd_uops_0_REG_mem_cmd = _RANDOM[7'h42][27:23];	// register-read.scala:86:29
        rrd_uops_0_REG_mem_size = _RANDOM[7'h42][29:28];	// register-read.scala:86:29
        rrd_uops_0_REG_mem_signed = _RANDOM[7'h42][30];	// register-read.scala:86:29
        rrd_uops_0_REG_is_fence = _RANDOM[7'h42][31];	// register-read.scala:86:29
        rrd_uops_0_REG_is_fencei = _RANDOM[7'h43][0];	// register-read.scala:86:29
        rrd_uops_0_REG_is_amo = _RANDOM[7'h43][1];	// register-read.scala:86:29
        rrd_uops_0_REG_uses_ldq = _RANDOM[7'h43][2];	// register-read.scala:86:29
        rrd_uops_0_REG_uses_stq = _RANDOM[7'h43][3];	// register-read.scala:86:29
        rrd_uops_0_REG_is_sys_pc2epc = _RANDOM[7'h43][4];	// register-read.scala:86:29
        rrd_uops_0_REG_is_unique = _RANDOM[7'h43][5];	// register-read.scala:86:29
        rrd_uops_0_REG_flush_on_commit = _RANDOM[7'h43][6];	// register-read.scala:86:29
        rrd_uops_0_REG_ldst_is_rs1 = _RANDOM[7'h43][7];	// register-read.scala:86:29
        rrd_uops_0_REG_ldst = _RANDOM[7'h43][13:8];	// register-read.scala:86:29
        rrd_uops_0_REG_lrs1 = _RANDOM[7'h43][19:14];	// register-read.scala:86:29
        rrd_uops_0_REG_lrs2 = _RANDOM[7'h43][25:20];	// register-read.scala:86:29
        rrd_uops_0_REG_lrs3 = _RANDOM[7'h43][31:26];	// register-read.scala:86:29
        rrd_uops_0_REG_ldst_val = _RANDOM[7'h44][0];	// register-read.scala:86:29
        rrd_uops_0_REG_dst_rtype = _RANDOM[7'h44][2:1];	// register-read.scala:86:29
        rrd_uops_0_REG_lrs1_rtype = _RANDOM[7'h44][4:3];	// register-read.scala:86:29
        rrd_uops_0_REG_lrs2_rtype = _RANDOM[7'h44][6:5];	// register-read.scala:86:29
        rrd_uops_0_REG_frs3_en = _RANDOM[7'h44][7];	// register-read.scala:86:29
        rrd_uops_0_REG_fp_val = _RANDOM[7'h44][8];	// register-read.scala:86:29
        rrd_uops_0_REG_fp_single = _RANDOM[7'h44][9];	// register-read.scala:86:29
        rrd_uops_0_REG_xcpt_pf_if = _RANDOM[7'h44][10];	// register-read.scala:86:29
        rrd_uops_0_REG_xcpt_ae_if = _RANDOM[7'h44][11];	// register-read.scala:86:29
        rrd_uops_0_REG_xcpt_ma_if = _RANDOM[7'h44][12];	// register-read.scala:86:29
        rrd_uops_0_REG_bp_debug_if = _RANDOM[7'h44][13];	// register-read.scala:86:29
        rrd_uops_0_REG_bp_xcpt_if = _RANDOM[7'h44][14];	// register-read.scala:86:29
        rrd_uops_0_REG_debug_fsrc = _RANDOM[7'h44][16:15];	// register-read.scala:86:29
        rrd_uops_0_REG_debug_tsrc = _RANDOM[7'h44][18:17];	// register-read.scala:86:29
        rrd_valids_1_REG = _RANDOM[7'h44][19];	// register-read.scala:84:29, :86:29
        rrd_uops_1_REG_uopc = _RANDOM[7'h44][26:20];	// register-read.scala:86:29
        rrd_uops_1_REG_inst = {_RANDOM[7'h44][31:27], _RANDOM[7'h45][26:0]};	// register-read.scala:86:29
        rrd_uops_1_REG_debug_inst = {_RANDOM[7'h45][31:27], _RANDOM[7'h46][26:0]};	// register-read.scala:86:29
        rrd_uops_1_REG_is_rvc = _RANDOM[7'h46][27];	// register-read.scala:86:29
        rrd_uops_1_REG_debug_pc =
          {_RANDOM[7'h46][31:28], _RANDOM[7'h47], _RANDOM[7'h48][3:0]};	// register-read.scala:86:29
        rrd_uops_1_REG_iq_type = _RANDOM[7'h48][6:4];	// register-read.scala:86:29
        rrd_uops_1_REG_fu_code = _RANDOM[7'h48][16:7];	// register-read.scala:86:29
        rrd_uops_1_REG_ctrl_br_type = _RANDOM[7'h48][20:17];	// register-read.scala:86:29
        rrd_uops_1_REG_ctrl_op1_sel = _RANDOM[7'h48][22:21];	// register-read.scala:86:29
        rrd_uops_1_REG_ctrl_op2_sel = _RANDOM[7'h48][25:23];	// register-read.scala:86:29
        rrd_uops_1_REG_ctrl_imm_sel = _RANDOM[7'h48][28:26];	// register-read.scala:86:29
        rrd_uops_1_REG_ctrl_op_fcn = {_RANDOM[7'h48][31:29], _RANDOM[7'h49][0]};	// register-read.scala:86:29
        rrd_uops_1_REG_ctrl_fcn_dw = _RANDOM[7'h49][1];	// register-read.scala:86:29
        rrd_uops_1_REG_ctrl_is_load = _RANDOM[7'h49][5];	// register-read.scala:86:29
        rrd_uops_1_REG_ctrl_is_sta = _RANDOM[7'h49][6];	// register-read.scala:86:29
        rrd_uops_1_REG_ctrl_is_std = _RANDOM[7'h49][7];	// register-read.scala:86:29
        rrd_uops_1_REG_iw_state = _RANDOM[7'h49][9:8];	// register-read.scala:86:29
        rrd_uops_1_REG_is_br = _RANDOM[7'h49][12];	// register-read.scala:86:29
        rrd_uops_1_REG_is_jalr = _RANDOM[7'h49][13];	// register-read.scala:86:29
        rrd_uops_1_REG_is_jal = _RANDOM[7'h49][14];	// register-read.scala:86:29
        rrd_uops_1_REG_is_sfb = _RANDOM[7'h49][15];	// register-read.scala:86:29
        rrd_uops_1_REG_br_mask = _RANDOM[7'h49][27:16];	// register-read.scala:86:29
        rrd_uops_1_REG_br_tag = _RANDOM[7'h49][31:28];	// register-read.scala:86:29
        rrd_uops_1_REG_ftq_idx = _RANDOM[7'h4A][4:0];	// register-read.scala:86:29
        rrd_uops_1_REG_edge_inst = _RANDOM[7'h4A][5];	// register-read.scala:86:29
        rrd_uops_1_REG_pc_lob = _RANDOM[7'h4A][11:6];	// register-read.scala:86:29
        rrd_uops_1_REG_taken = _RANDOM[7'h4A][12];	// register-read.scala:86:29
        rrd_uops_1_REG_imm_packed = {_RANDOM[7'h4A][31:13], _RANDOM[7'h4B][0]};	// register-read.scala:86:29
        rrd_uops_1_REG_csr_addr = _RANDOM[7'h4B][12:1];	// register-read.scala:86:29
        rrd_uops_1_REG_rob_idx = _RANDOM[7'h4B][18:13];	// register-read.scala:86:29
        rrd_uops_1_REG_ldq_idx = _RANDOM[7'h4B][22:19];	// register-read.scala:86:29
        rrd_uops_1_REG_stq_idx = _RANDOM[7'h4B][26:23];	// register-read.scala:86:29
        rrd_uops_1_REG_rxq_idx = _RANDOM[7'h4B][28:27];	// register-read.scala:86:29
        rrd_uops_1_REG_pdst = {_RANDOM[7'h4B][31:29], _RANDOM[7'h4C][3:0]};	// register-read.scala:86:29
        rrd_uops_1_REG_prs1 = _RANDOM[7'h4C][10:4];	// register-read.scala:86:29
        rrd_uops_1_REG_prs2 = _RANDOM[7'h4C][17:11];	// register-read.scala:86:29
        rrd_uops_1_REG_prs3 = _RANDOM[7'h4C][24:18];	// register-read.scala:86:29
        rrd_uops_1_REG_ppred = _RANDOM[7'h4C][29:25];	// register-read.scala:86:29
        rrd_uops_1_REG_prs1_busy = _RANDOM[7'h4C][30];	// register-read.scala:86:29
        rrd_uops_1_REG_prs2_busy = _RANDOM[7'h4C][31];	// register-read.scala:86:29
        rrd_uops_1_REG_prs3_busy = _RANDOM[7'h4D][0];	// register-read.scala:86:29
        rrd_uops_1_REG_ppred_busy = _RANDOM[7'h4D][1];	// register-read.scala:86:29
        rrd_uops_1_REG_stale_pdst = _RANDOM[7'h4D][8:2];	// register-read.scala:86:29
        rrd_uops_1_REG_exception = _RANDOM[7'h4D][9];	// register-read.scala:86:29
        rrd_uops_1_REG_exc_cause =
          {_RANDOM[7'h4D][31:10], _RANDOM[7'h4E], _RANDOM[7'h4F][9:0]};	// register-read.scala:86:29
        rrd_uops_1_REG_bypassable = _RANDOM[7'h4F][10];	// register-read.scala:86:29
        rrd_uops_1_REG_mem_cmd = _RANDOM[7'h4F][15:11];	// register-read.scala:86:29
        rrd_uops_1_REG_mem_size = _RANDOM[7'h4F][17:16];	// register-read.scala:86:29
        rrd_uops_1_REG_mem_signed = _RANDOM[7'h4F][18];	// register-read.scala:86:29
        rrd_uops_1_REG_is_fence = _RANDOM[7'h4F][19];	// register-read.scala:86:29
        rrd_uops_1_REG_is_fencei = _RANDOM[7'h4F][20];	// register-read.scala:86:29
        rrd_uops_1_REG_is_amo = _RANDOM[7'h4F][21];	// register-read.scala:86:29
        rrd_uops_1_REG_uses_ldq = _RANDOM[7'h4F][22];	// register-read.scala:86:29
        rrd_uops_1_REG_uses_stq = _RANDOM[7'h4F][23];	// register-read.scala:86:29
        rrd_uops_1_REG_is_sys_pc2epc = _RANDOM[7'h4F][24];	// register-read.scala:86:29
        rrd_uops_1_REG_is_unique = _RANDOM[7'h4F][25];	// register-read.scala:86:29
        rrd_uops_1_REG_flush_on_commit = _RANDOM[7'h4F][26];	// register-read.scala:86:29
        rrd_uops_1_REG_ldst_is_rs1 = _RANDOM[7'h4F][27];	// register-read.scala:86:29
        rrd_uops_1_REG_ldst = {_RANDOM[7'h4F][31:28], _RANDOM[7'h50][1:0]};	// register-read.scala:86:29
        rrd_uops_1_REG_lrs1 = _RANDOM[7'h50][7:2];	// register-read.scala:86:29
        rrd_uops_1_REG_lrs2 = _RANDOM[7'h50][13:8];	// register-read.scala:86:29
        rrd_uops_1_REG_lrs3 = _RANDOM[7'h50][19:14];	// register-read.scala:86:29
        rrd_uops_1_REG_ldst_val = _RANDOM[7'h50][20];	// register-read.scala:86:29
        rrd_uops_1_REG_dst_rtype = _RANDOM[7'h50][22:21];	// register-read.scala:86:29
        rrd_uops_1_REG_lrs1_rtype = _RANDOM[7'h50][24:23];	// register-read.scala:86:29
        rrd_uops_1_REG_lrs2_rtype = _RANDOM[7'h50][26:25];	// register-read.scala:86:29
        rrd_uops_1_REG_frs3_en = _RANDOM[7'h50][27];	// register-read.scala:86:29
        rrd_uops_1_REG_fp_val = _RANDOM[7'h50][28];	// register-read.scala:86:29
        rrd_uops_1_REG_fp_single = _RANDOM[7'h50][29];	// register-read.scala:86:29
        rrd_uops_1_REG_xcpt_pf_if = _RANDOM[7'h50][30];	// register-read.scala:86:29
        rrd_uops_1_REG_xcpt_ae_if = _RANDOM[7'h50][31];	// register-read.scala:86:29
        rrd_uops_1_REG_xcpt_ma_if = _RANDOM[7'h51][0];	// register-read.scala:86:29
        rrd_uops_1_REG_bp_debug_if = _RANDOM[7'h51][1];	// register-read.scala:86:29
        rrd_uops_1_REG_bp_xcpt_if = _RANDOM[7'h51][2];	// register-read.scala:86:29
        rrd_uops_1_REG_debug_fsrc = _RANDOM[7'h51][4:3];	// register-read.scala:86:29
        rrd_uops_1_REG_debug_tsrc = _RANDOM[7'h51][6:5];	// register-read.scala:86:29
        rrd_valids_2_REG = _RANDOM[7'h51][7];	// register-read.scala:84:29, :86:29
        rrd_uops_2_REG_uopc = _RANDOM[7'h51][14:8];	// register-read.scala:86:29
        rrd_uops_2_REG_is_rvc = _RANDOM[7'h53][15];	// register-read.scala:86:29
        rrd_uops_2_REG_fu_code = {_RANDOM[7'h54][31:27], _RANDOM[7'h55][4:0]};	// register-read.scala:86:29
        rrd_uops_2_REG_ctrl_br_type = _RANDOM[7'h55][8:5];	// register-read.scala:86:29
        rrd_uops_2_REG_ctrl_op1_sel = _RANDOM[7'h55][10:9];	// register-read.scala:86:29
        rrd_uops_2_REG_ctrl_op2_sel = _RANDOM[7'h55][13:11];	// register-read.scala:86:29
        rrd_uops_2_REG_ctrl_imm_sel = _RANDOM[7'h55][16:14];	// register-read.scala:86:29
        rrd_uops_2_REG_ctrl_op_fcn = _RANDOM[7'h55][20:17];	// register-read.scala:86:29
        rrd_uops_2_REG_ctrl_fcn_dw = _RANDOM[7'h55][21];	// register-read.scala:86:29
        rrd_uops_2_REG_ctrl_csr_cmd = _RANDOM[7'h55][24:22];	// register-read.scala:86:29
        rrd_uops_2_REG_is_br = _RANDOM[7'h56][0];	// register-read.scala:86:29
        rrd_uops_2_REG_is_jalr = _RANDOM[7'h56][1];	// register-read.scala:86:29
        rrd_uops_2_REG_is_jal = _RANDOM[7'h56][2];	// register-read.scala:86:29
        rrd_uops_2_REG_is_sfb = _RANDOM[7'h56][3];	// register-read.scala:86:29
        rrd_uops_2_REG_br_mask = _RANDOM[7'h56][15:4];	// register-read.scala:86:29
        rrd_uops_2_REG_br_tag = _RANDOM[7'h56][19:16];	// register-read.scala:86:29
        rrd_uops_2_REG_ftq_idx = _RANDOM[7'h56][24:20];	// register-read.scala:86:29
        rrd_uops_2_REG_edge_inst = _RANDOM[7'h56][25];	// register-read.scala:86:29
        rrd_uops_2_REG_pc_lob = _RANDOM[7'h56][31:26];	// register-read.scala:86:29
        rrd_uops_2_REG_taken = _RANDOM[7'h57][0];	// register-read.scala:86:29
        rrd_uops_2_REG_imm_packed = _RANDOM[7'h57][20:1];	// register-read.scala:86:29
        rrd_uops_2_REG_rob_idx = _RANDOM[7'h58][6:1];	// register-read.scala:86:29
        rrd_uops_2_REG_ldq_idx = _RANDOM[7'h58][10:7];	// register-read.scala:86:29
        rrd_uops_2_REG_stq_idx = _RANDOM[7'h58][14:11];	// register-read.scala:86:29
        rrd_uops_2_REG_pdst = _RANDOM[7'h58][23:17];	// register-read.scala:86:29
        rrd_uops_2_REG_prs1 = _RANDOM[7'h58][30:24];	// register-read.scala:86:29
        rrd_uops_2_REG_prs2 = {_RANDOM[7'h58][31], _RANDOM[7'h59][5:0]};	// register-read.scala:86:29
        rrd_uops_2_REG_bypassable = _RANDOM[7'h5B][30];	// register-read.scala:86:29
        rrd_uops_2_REG_is_amo = _RANDOM[7'h5C][9];	// register-read.scala:86:29
        rrd_uops_2_REG_uses_stq = _RANDOM[7'h5C][11];	// register-read.scala:86:29
        rrd_uops_2_REG_dst_rtype = _RANDOM[7'h5D][10:9];	// register-read.scala:86:29
        rrd_uops_2_REG_lrs1_rtype = _RANDOM[7'h5D][12:11];	// register-read.scala:86:29
        rrd_uops_2_REG_lrs2_rtype = _RANDOM[7'h5D][14:13];	// register-read.scala:86:29
        rrd_rs1_data_0_REG = _RANDOM[7'h5D][27];	// register-read.scala:86:29, :124:57
        rrd_rs2_data_0_REG = _RANDOM[7'h5D][28];	// register-read.scala:86:29, :125:57
        rrd_rs1_data_1_REG = _RANDOM[7'h5D][29];	// register-read.scala:86:29, :124:57
        rrd_rs2_data_1_REG = _RANDOM[7'h5D][30];	// register-read.scala:86:29, :125:57
        rrd_rs1_data_2_REG = _RANDOM[7'h5D][31];	// register-read.scala:86:29, :124:57
        rrd_rs2_data_2_REG = _RANDOM[7'h5E][0];	// register-read.scala:125:57
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  RegisterReadDecode_14 rrd_decode_unit (	// register-read.scala:80:33
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
  RegisterReadDecode_15 rrd_decode_unit_1 (	// register-read.scala:80:33
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
  RegisterReadDecode_16 rrd_decode_unit_2 (	// register-read.scala:80:33
    .io_iss_uop_uopc         (io_iss_uops_2_uopc),
    .io_iss_uop_imm_packed   (io_iss_uops_2_imm_packed),
    .io_iss_uop_prs1         (io_iss_uops_2_prs1),
    .io_iss_uop_mem_cmd      (io_iss_uops_2_mem_cmd),
    .io_rrd_uop_ctrl_br_type (_rrd_decode_unit_2_io_rrd_uop_ctrl_br_type),
    .io_rrd_uop_ctrl_op1_sel (_rrd_decode_unit_2_io_rrd_uop_ctrl_op1_sel),
    .io_rrd_uop_ctrl_op2_sel (_rrd_decode_unit_2_io_rrd_uop_ctrl_op2_sel),
    .io_rrd_uop_ctrl_imm_sel (_rrd_decode_unit_2_io_rrd_uop_ctrl_imm_sel),
    .io_rrd_uop_ctrl_op_fcn  (_rrd_decode_unit_2_io_rrd_uop_ctrl_op_fcn),
    .io_rrd_uop_ctrl_fcn_dw  (_rrd_decode_unit_2_io_rrd_uop_ctrl_fcn_dw),
    .io_rrd_uop_ctrl_csr_cmd (_rrd_decode_unit_2_io_rrd_uop_ctrl_csr_cmd),
    .io_rrd_uop_imm_packed   (_rrd_decode_unit_2_io_rrd_uop_imm_packed)
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
  assign io_exe_reqs_2_bits_uop_is_rvc = exe_reg_uops_2_is_rvc;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_fu_code = exe_reg_uops_2_fu_code;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_ctrl_br_type = exe_reg_uops_2_ctrl_br_type;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_ctrl_op1_sel = exe_reg_uops_2_ctrl_op1_sel;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_ctrl_op2_sel = exe_reg_uops_2_ctrl_op2_sel;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_ctrl_imm_sel = exe_reg_uops_2_ctrl_imm_sel;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_ctrl_op_fcn = exe_reg_uops_2_ctrl_op_fcn;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_ctrl_fcn_dw = exe_reg_uops_2_ctrl_fcn_dw;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_ctrl_csr_cmd = exe_reg_uops_2_ctrl_csr_cmd;	// register-read.scala:70:29
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
  assign io_exe_reqs_2_bits_uop_rob_idx = exe_reg_uops_2_rob_idx;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_ldq_idx = exe_reg_uops_2_ldq_idx;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_stq_idx = exe_reg_uops_2_stq_idx;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_pdst = exe_reg_uops_2_pdst;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_prs1 = exe_reg_uops_2_prs1;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_bypassable = exe_reg_uops_2_bypassable;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_is_amo = exe_reg_uops_2_is_amo;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_uses_stq = exe_reg_uops_2_uses_stq;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_uop_dst_rtype = exe_reg_uops_2_dst_rtype;	// register-read.scala:70:29
  assign io_exe_reqs_2_bits_rs1_data = exe_reg_rs1_data_2;	// register-read.scala:71:29
  assign io_exe_reqs_2_bits_rs2_data = exe_reg_rs2_data_2;	// register-read.scala:72:29
endmodule

