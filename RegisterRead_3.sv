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

module RegisterRead_3(
  input         clock,
                reset,
                io_iss_valids_0,
                io_iss_valids_1,
                io_iss_valids_2,
                io_iss_valids_3,
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
  input  [15:0] io_iss_uops_0_br_mask,
  input  [3:0]  io_iss_uops_0_br_tag,
  input  [4:0]  io_iss_uops_0_ftq_idx,
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
  input         io_iss_uops_1_is_rvc,
  input  [9:0]  io_iss_uops_1_fu_code,
  input         io_iss_uops_1_is_br,
                io_iss_uops_1_is_jalr,
                io_iss_uops_1_is_jal,
                io_iss_uops_1_is_sfb,
  input  [15:0] io_iss_uops_1_br_mask,
  input  [3:0]  io_iss_uops_1_br_tag,
  input  [4:0]  io_iss_uops_1_ftq_idx,
  input         io_iss_uops_1_edge_inst,
  input  [5:0]  io_iss_uops_1_pc_lob,
  input         io_iss_uops_1_taken,
  input  [19:0] io_iss_uops_1_imm_packed,
  input  [6:0]  io_iss_uops_1_rob_idx,
  input  [4:0]  io_iss_uops_1_ldq_idx,
                io_iss_uops_1_stq_idx,
  input  [6:0]  io_iss_uops_1_pdst,
                io_iss_uops_1_prs1,
                io_iss_uops_1_prs2,
  input         io_iss_uops_1_bypassable,
  input  [4:0]  io_iss_uops_1_mem_cmd,
  input         io_iss_uops_1_is_amo,
                io_iss_uops_1_uses_stq,
  input  [1:0]  io_iss_uops_1_dst_rtype,
                io_iss_uops_1_lrs1_rtype,
                io_iss_uops_1_lrs2_rtype,
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
  input  [15:0] io_iss_uops_2_br_mask,
  input  [3:0]  io_iss_uops_2_br_tag,
  input  [4:0]  io_iss_uops_2_ftq_idx,
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
  input  [4:0]  io_iss_uops_2_ppred,
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
  input  [15:0] io_iss_uops_3_br_mask,
  input  [3:0]  io_iss_uops_3_br_tag,
  input  [4:0]  io_iss_uops_3_ftq_idx,
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
  input  [63:0] io_rf_read_ports_0_data,
                io_rf_read_ports_1_data,
                io_rf_read_ports_2_data,
                io_rf_read_ports_3_data,
                io_rf_read_ports_4_data,
                io_rf_read_ports_5_data,
                io_rf_read_ports_6_data,
                io_rf_read_ports_7_data,
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
  input         io_kill,
  input  [15:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  output [6:0]  io_rf_read_ports_0_addr,
                io_rf_read_ports_1_addr,
                io_rf_read_ports_2_addr,
                io_rf_read_ports_3_addr,
                io_rf_read_ports_4_addr,
                io_rf_read_ports_5_addr,
                io_rf_read_ports_6_addr,
                io_rf_read_ports_7_addr,
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
  output [15:0] io_exe_reqs_0_bits_uop_br_mask,
  output [3:0]  io_exe_reqs_0_bits_uop_br_tag,
  output [4:0]  io_exe_reqs_0_bits_uop_ftq_idx,
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
  output        io_exe_reqs_1_bits_uop_is_rvc,
  output [9:0]  io_exe_reqs_1_bits_uop_fu_code,
  output [3:0]  io_exe_reqs_1_bits_uop_ctrl_br_type,
  output [1:0]  io_exe_reqs_1_bits_uop_ctrl_op1_sel,
  output [2:0]  io_exe_reqs_1_bits_uop_ctrl_op2_sel,
                io_exe_reqs_1_bits_uop_ctrl_imm_sel,
  output [3:0]  io_exe_reqs_1_bits_uop_ctrl_op_fcn,
  output        io_exe_reqs_1_bits_uop_ctrl_fcn_dw,
                io_exe_reqs_1_bits_uop_is_br,
                io_exe_reqs_1_bits_uop_is_jalr,
                io_exe_reqs_1_bits_uop_is_jal,
                io_exe_reqs_1_bits_uop_is_sfb,
  output [15:0] io_exe_reqs_1_bits_uop_br_mask,
  output [3:0]  io_exe_reqs_1_bits_uop_br_tag,
  output [4:0]  io_exe_reqs_1_bits_uop_ftq_idx,
  output        io_exe_reqs_1_bits_uop_edge_inst,
  output [5:0]  io_exe_reqs_1_bits_uop_pc_lob,
  output        io_exe_reqs_1_bits_uop_taken,
  output [19:0] io_exe_reqs_1_bits_uop_imm_packed,
  output [6:0]  io_exe_reqs_1_bits_uop_rob_idx,
  output [4:0]  io_exe_reqs_1_bits_uop_ldq_idx,
                io_exe_reqs_1_bits_uop_stq_idx,
  output [6:0]  io_exe_reqs_1_bits_uop_pdst,
                io_exe_reqs_1_bits_uop_prs1,
  output        io_exe_reqs_1_bits_uop_bypassable,
                io_exe_reqs_1_bits_uop_is_amo,
                io_exe_reqs_1_bits_uop_uses_stq,
  output [1:0]  io_exe_reqs_1_bits_uop_dst_rtype,
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
  output [2:0]  io_exe_reqs_2_bits_uop_ctrl_csr_cmd,
  output        io_exe_reqs_2_bits_uop_ctrl_is_load,
                io_exe_reqs_2_bits_uop_ctrl_is_sta,
                io_exe_reqs_2_bits_uop_ctrl_is_std,
  output [1:0]  io_exe_reqs_2_bits_uop_iw_state,
  output        io_exe_reqs_2_bits_uop_is_br,
                io_exe_reqs_2_bits_uop_is_jalr,
                io_exe_reqs_2_bits_uop_is_jal,
                io_exe_reqs_2_bits_uop_is_sfb,
  output [15:0] io_exe_reqs_2_bits_uop_br_mask,
  output [3:0]  io_exe_reqs_2_bits_uop_br_tag,
  output [4:0]  io_exe_reqs_2_bits_uop_ftq_idx,
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
  output [4:0]  io_exe_reqs_2_bits_uop_ppred,
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
                io_exe_reqs_3_bits_uop_is_br,
                io_exe_reqs_3_bits_uop_is_jalr,
                io_exe_reqs_3_bits_uop_is_jal,
                io_exe_reqs_3_bits_uop_is_sfb,
  output [15:0] io_exe_reqs_3_bits_uop_br_mask,
  output [3:0]  io_exe_reqs_3_bits_uop_br_tag,
  output [4:0]  io_exe_reqs_3_bits_uop_ftq_idx,
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
                io_exe_reqs_3_bits_rs2_data
);

  wire        _rrd_decode_unit_3_io_rrd_valid;	// register-read.scala:80:33
  wire [6:0]  _rrd_decode_unit_3_io_rrd_uop_uopc;	// register-read.scala:80:33
  wire        _rrd_decode_unit_3_io_rrd_uop_is_rvc;	// register-read.scala:80:33
  wire [9:0]  _rrd_decode_unit_3_io_rrd_uop_fu_code;	// register-read.scala:80:33
  wire [3:0]  _rrd_decode_unit_3_io_rrd_uop_ctrl_br_type;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_3_io_rrd_uop_ctrl_op1_sel;	// register-read.scala:80:33
  wire [2:0]  _rrd_decode_unit_3_io_rrd_uop_ctrl_op2_sel;	// register-read.scala:80:33
  wire [2:0]  _rrd_decode_unit_3_io_rrd_uop_ctrl_imm_sel;	// register-read.scala:80:33
  wire [3:0]  _rrd_decode_unit_3_io_rrd_uop_ctrl_op_fcn;	// register-read.scala:80:33
  wire        _rrd_decode_unit_3_io_rrd_uop_ctrl_fcn_dw;	// register-read.scala:80:33
  wire        _rrd_decode_unit_3_io_rrd_uop_is_br;	// register-read.scala:80:33
  wire        _rrd_decode_unit_3_io_rrd_uop_is_jalr;	// register-read.scala:80:33
  wire        _rrd_decode_unit_3_io_rrd_uop_is_jal;	// register-read.scala:80:33
  wire        _rrd_decode_unit_3_io_rrd_uop_is_sfb;	// register-read.scala:80:33
  wire [15:0] _rrd_decode_unit_3_io_rrd_uop_br_mask;	// register-read.scala:80:33
  wire [3:0]  _rrd_decode_unit_3_io_rrd_uop_br_tag;	// register-read.scala:80:33
  wire [4:0]  _rrd_decode_unit_3_io_rrd_uop_ftq_idx;	// register-read.scala:80:33
  wire        _rrd_decode_unit_3_io_rrd_uop_edge_inst;	// register-read.scala:80:33
  wire [5:0]  _rrd_decode_unit_3_io_rrd_uop_pc_lob;	// register-read.scala:80:33
  wire        _rrd_decode_unit_3_io_rrd_uop_taken;	// register-read.scala:80:33
  wire [19:0] _rrd_decode_unit_3_io_rrd_uop_imm_packed;	// register-read.scala:80:33
  wire [6:0]  _rrd_decode_unit_3_io_rrd_uop_rob_idx;	// register-read.scala:80:33
  wire [4:0]  _rrd_decode_unit_3_io_rrd_uop_ldq_idx;	// register-read.scala:80:33
  wire [4:0]  _rrd_decode_unit_3_io_rrd_uop_stq_idx;	// register-read.scala:80:33
  wire [6:0]  _rrd_decode_unit_3_io_rrd_uop_pdst;	// register-read.scala:80:33
  wire [6:0]  _rrd_decode_unit_3_io_rrd_uop_prs1;	// register-read.scala:80:33
  wire [6:0]  _rrd_decode_unit_3_io_rrd_uop_prs2;	// register-read.scala:80:33
  wire        _rrd_decode_unit_3_io_rrd_uop_bypassable;	// register-read.scala:80:33
  wire        _rrd_decode_unit_3_io_rrd_uop_is_amo;	// register-read.scala:80:33
  wire        _rrd_decode_unit_3_io_rrd_uop_uses_stq;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_3_io_rrd_uop_dst_rtype;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_3_io_rrd_uop_lrs1_rtype;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_3_io_rrd_uop_lrs2_rtype;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_valid;	// register-read.scala:80:33
  wire [6:0]  _rrd_decode_unit_2_io_rrd_uop_uopc;	// register-read.scala:80:33
  wire [31:0] _rrd_decode_unit_2_io_rrd_uop_inst;	// register-read.scala:80:33
  wire [31:0] _rrd_decode_unit_2_io_rrd_uop_debug_inst;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_is_rvc;	// register-read.scala:80:33
  wire [39:0] _rrd_decode_unit_2_io_rrd_uop_debug_pc;	// register-read.scala:80:33
  wire [2:0]  _rrd_decode_unit_2_io_rrd_uop_iq_type;	// register-read.scala:80:33
  wire [9:0]  _rrd_decode_unit_2_io_rrd_uop_fu_code;	// register-read.scala:80:33
  wire [3:0]  _rrd_decode_unit_2_io_rrd_uop_ctrl_br_type;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_2_io_rrd_uop_ctrl_op1_sel;	// register-read.scala:80:33
  wire [2:0]  _rrd_decode_unit_2_io_rrd_uop_ctrl_op2_sel;	// register-read.scala:80:33
  wire [2:0]  _rrd_decode_unit_2_io_rrd_uop_ctrl_imm_sel;	// register-read.scala:80:33
  wire [3:0]  _rrd_decode_unit_2_io_rrd_uop_ctrl_op_fcn;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_ctrl_fcn_dw;	// register-read.scala:80:33
  wire [2:0]  _rrd_decode_unit_2_io_rrd_uop_ctrl_csr_cmd;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_ctrl_is_load;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_ctrl_is_sta;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_ctrl_is_std;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_2_io_rrd_uop_iw_state;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_is_br;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_is_jalr;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_is_jal;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_is_sfb;	// register-read.scala:80:33
  wire [15:0] _rrd_decode_unit_2_io_rrd_uop_br_mask;	// register-read.scala:80:33
  wire [3:0]  _rrd_decode_unit_2_io_rrd_uop_br_tag;	// register-read.scala:80:33
  wire [4:0]  _rrd_decode_unit_2_io_rrd_uop_ftq_idx;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_edge_inst;	// register-read.scala:80:33
  wire [5:0]  _rrd_decode_unit_2_io_rrd_uop_pc_lob;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_taken;	// register-read.scala:80:33
  wire [19:0] _rrd_decode_unit_2_io_rrd_uop_imm_packed;	// register-read.scala:80:33
  wire [11:0] _rrd_decode_unit_2_io_rrd_uop_csr_addr;	// register-read.scala:80:33
  wire [6:0]  _rrd_decode_unit_2_io_rrd_uop_rob_idx;	// register-read.scala:80:33
  wire [4:0]  _rrd_decode_unit_2_io_rrd_uop_ldq_idx;	// register-read.scala:80:33
  wire [4:0]  _rrd_decode_unit_2_io_rrd_uop_stq_idx;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_2_io_rrd_uop_rxq_idx;	// register-read.scala:80:33
  wire [6:0]  _rrd_decode_unit_2_io_rrd_uop_pdst;	// register-read.scala:80:33
  wire [6:0]  _rrd_decode_unit_2_io_rrd_uop_prs1;	// register-read.scala:80:33
  wire [6:0]  _rrd_decode_unit_2_io_rrd_uop_prs2;	// register-read.scala:80:33
  wire [6:0]  _rrd_decode_unit_2_io_rrd_uop_prs3;	// register-read.scala:80:33
  wire [4:0]  _rrd_decode_unit_2_io_rrd_uop_ppred;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_prs1_busy;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_prs2_busy;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_prs3_busy;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_ppred_busy;	// register-read.scala:80:33
  wire [6:0]  _rrd_decode_unit_2_io_rrd_uop_stale_pdst;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_exception;	// register-read.scala:80:33
  wire [63:0] _rrd_decode_unit_2_io_rrd_uop_exc_cause;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_bypassable;	// register-read.scala:80:33
  wire [4:0]  _rrd_decode_unit_2_io_rrd_uop_mem_cmd;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_2_io_rrd_uop_mem_size;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_mem_signed;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_is_fence;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_is_fencei;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_is_amo;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_uses_ldq;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_uses_stq;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_is_sys_pc2epc;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_is_unique;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_flush_on_commit;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_ldst_is_rs1;	// register-read.scala:80:33
  wire [5:0]  _rrd_decode_unit_2_io_rrd_uop_ldst;	// register-read.scala:80:33
  wire [5:0]  _rrd_decode_unit_2_io_rrd_uop_lrs1;	// register-read.scala:80:33
  wire [5:0]  _rrd_decode_unit_2_io_rrd_uop_lrs2;	// register-read.scala:80:33
  wire [5:0]  _rrd_decode_unit_2_io_rrd_uop_lrs3;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_ldst_val;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_2_io_rrd_uop_dst_rtype;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_2_io_rrd_uop_lrs1_rtype;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_2_io_rrd_uop_lrs2_rtype;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_frs3_en;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_fp_val;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_fp_single;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_xcpt_pf_if;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_xcpt_ae_if;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_xcpt_ma_if;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_bp_debug_if;	// register-read.scala:80:33
  wire        _rrd_decode_unit_2_io_rrd_uop_bp_xcpt_if;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_2_io_rrd_uop_debug_fsrc;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_2_io_rrd_uop_debug_tsrc;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_valid;	// register-read.scala:80:33
  wire [6:0]  _rrd_decode_unit_1_io_rrd_uop_uopc;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_is_rvc;	// register-read.scala:80:33
  wire [9:0]  _rrd_decode_unit_1_io_rrd_uop_fu_code;	// register-read.scala:80:33
  wire [3:0]  _rrd_decode_unit_1_io_rrd_uop_ctrl_br_type;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_1_io_rrd_uop_ctrl_op1_sel;	// register-read.scala:80:33
  wire [2:0]  _rrd_decode_unit_1_io_rrd_uop_ctrl_op2_sel;	// register-read.scala:80:33
  wire [2:0]  _rrd_decode_unit_1_io_rrd_uop_ctrl_imm_sel;	// register-read.scala:80:33
  wire [3:0]  _rrd_decode_unit_1_io_rrd_uop_ctrl_op_fcn;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_ctrl_fcn_dw;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_is_br;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_is_jalr;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_is_jal;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_is_sfb;	// register-read.scala:80:33
  wire [15:0] _rrd_decode_unit_1_io_rrd_uop_br_mask;	// register-read.scala:80:33
  wire [3:0]  _rrd_decode_unit_1_io_rrd_uop_br_tag;	// register-read.scala:80:33
  wire [4:0]  _rrd_decode_unit_1_io_rrd_uop_ftq_idx;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_edge_inst;	// register-read.scala:80:33
  wire [5:0]  _rrd_decode_unit_1_io_rrd_uop_pc_lob;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_taken;	// register-read.scala:80:33
  wire [19:0] _rrd_decode_unit_1_io_rrd_uop_imm_packed;	// register-read.scala:80:33
  wire [6:0]  _rrd_decode_unit_1_io_rrd_uop_rob_idx;	// register-read.scala:80:33
  wire [4:0]  _rrd_decode_unit_1_io_rrd_uop_ldq_idx;	// register-read.scala:80:33
  wire [4:0]  _rrd_decode_unit_1_io_rrd_uop_stq_idx;	// register-read.scala:80:33
  wire [6:0]  _rrd_decode_unit_1_io_rrd_uop_pdst;	// register-read.scala:80:33
  wire [6:0]  _rrd_decode_unit_1_io_rrd_uop_prs1;	// register-read.scala:80:33
  wire [6:0]  _rrd_decode_unit_1_io_rrd_uop_prs2;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_bypassable;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_is_amo;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_uses_stq;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_1_io_rrd_uop_dst_rtype;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_1_io_rrd_uop_lrs1_rtype;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_1_io_rrd_uop_lrs2_rtype;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_valid;	// register-read.scala:80:33
  wire [6:0]  _rrd_decode_unit_io_rrd_uop_uopc;	// register-read.scala:80:33
  wire [31:0] _rrd_decode_unit_io_rrd_uop_inst;	// register-read.scala:80:33
  wire [31:0] _rrd_decode_unit_io_rrd_uop_debug_inst;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_is_rvc;	// register-read.scala:80:33
  wire [39:0] _rrd_decode_unit_io_rrd_uop_debug_pc;	// register-read.scala:80:33
  wire [2:0]  _rrd_decode_unit_io_rrd_uop_iq_type;	// register-read.scala:80:33
  wire [9:0]  _rrd_decode_unit_io_rrd_uop_fu_code;	// register-read.scala:80:33
  wire [3:0]  _rrd_decode_unit_io_rrd_uop_ctrl_br_type;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_io_rrd_uop_ctrl_op1_sel;	// register-read.scala:80:33
  wire [2:0]  _rrd_decode_unit_io_rrd_uop_ctrl_op2_sel;	// register-read.scala:80:33
  wire [2:0]  _rrd_decode_unit_io_rrd_uop_ctrl_imm_sel;	// register-read.scala:80:33
  wire [3:0]  _rrd_decode_unit_io_rrd_uop_ctrl_op_fcn;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_ctrl_fcn_dw;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_ctrl_is_load;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_ctrl_is_sta;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_ctrl_is_std;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_io_rrd_uop_iw_state;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_is_br;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_is_jalr;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_is_jal;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_is_sfb;	// register-read.scala:80:33
  wire [15:0] _rrd_decode_unit_io_rrd_uop_br_mask;	// register-read.scala:80:33
  wire [3:0]  _rrd_decode_unit_io_rrd_uop_br_tag;	// register-read.scala:80:33
  wire [4:0]  _rrd_decode_unit_io_rrd_uop_ftq_idx;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_edge_inst;	// register-read.scala:80:33
  wire [5:0]  _rrd_decode_unit_io_rrd_uop_pc_lob;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_taken;	// register-read.scala:80:33
  wire [19:0] _rrd_decode_unit_io_rrd_uop_imm_packed;	// register-read.scala:80:33
  wire [11:0] _rrd_decode_unit_io_rrd_uop_csr_addr;	// register-read.scala:80:33
  wire [6:0]  _rrd_decode_unit_io_rrd_uop_rob_idx;	// register-read.scala:80:33
  wire [4:0]  _rrd_decode_unit_io_rrd_uop_ldq_idx;	// register-read.scala:80:33
  wire [4:0]  _rrd_decode_unit_io_rrd_uop_stq_idx;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_io_rrd_uop_rxq_idx;	// register-read.scala:80:33
  wire [6:0]  _rrd_decode_unit_io_rrd_uop_pdst;	// register-read.scala:80:33
  wire [6:0]  _rrd_decode_unit_io_rrd_uop_prs1;	// register-read.scala:80:33
  wire [6:0]  _rrd_decode_unit_io_rrd_uop_prs2;	// register-read.scala:80:33
  wire [6:0]  _rrd_decode_unit_io_rrd_uop_prs3;	// register-read.scala:80:33
  wire [4:0]  _rrd_decode_unit_io_rrd_uop_ppred;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_prs1_busy;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_prs2_busy;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_prs3_busy;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_ppred_busy;	// register-read.scala:80:33
  wire [6:0]  _rrd_decode_unit_io_rrd_uop_stale_pdst;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_exception;	// register-read.scala:80:33
  wire [63:0] _rrd_decode_unit_io_rrd_uop_exc_cause;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_bypassable;	// register-read.scala:80:33
  wire [4:0]  _rrd_decode_unit_io_rrd_uop_mem_cmd;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_io_rrd_uop_mem_size;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_mem_signed;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_is_fence;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_is_fencei;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_is_amo;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_uses_ldq;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_uses_stq;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_is_sys_pc2epc;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_is_unique;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_flush_on_commit;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_ldst_is_rs1;	// register-read.scala:80:33
  wire [5:0]  _rrd_decode_unit_io_rrd_uop_ldst;	// register-read.scala:80:33
  wire [5:0]  _rrd_decode_unit_io_rrd_uop_lrs1;	// register-read.scala:80:33
  wire [5:0]  _rrd_decode_unit_io_rrd_uop_lrs2;	// register-read.scala:80:33
  wire [5:0]  _rrd_decode_unit_io_rrd_uop_lrs3;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_ldst_val;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_io_rrd_uop_dst_rtype;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_io_rrd_uop_lrs1_rtype;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_io_rrd_uop_lrs2_rtype;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_frs3_en;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_fp_val;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_fp_single;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_xcpt_pf_if;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_xcpt_ae_if;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_xcpt_ma_if;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_bp_debug_if;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_bp_xcpt_if;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_io_rrd_uop_debug_fsrc;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_io_rrd_uop_debug_tsrc;	// register-read.scala:80:33
  reg         exe_reg_valids_0;	// register-read.scala:69:33
  reg         exe_reg_valids_1;	// register-read.scala:69:33
  reg         exe_reg_valids_2;	// register-read.scala:69:33
  reg         exe_reg_valids_3;	// register-read.scala:69:33
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
  reg  [15:0] exe_reg_uops_0_br_mask;	// register-read.scala:70:29
  reg  [3:0]  exe_reg_uops_0_br_tag;	// register-read.scala:70:29
  reg  [4:0]  exe_reg_uops_0_ftq_idx;	// register-read.scala:70:29
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
  reg         exe_reg_uops_1_is_rvc;	// register-read.scala:70:29
  reg  [9:0]  exe_reg_uops_1_fu_code;	// register-read.scala:70:29
  reg  [3:0]  exe_reg_uops_1_ctrl_br_type;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_1_ctrl_op1_sel;	// register-read.scala:70:29
  reg  [2:0]  exe_reg_uops_1_ctrl_op2_sel;	// register-read.scala:70:29
  reg  [2:0]  exe_reg_uops_1_ctrl_imm_sel;	// register-read.scala:70:29
  reg  [3:0]  exe_reg_uops_1_ctrl_op_fcn;	// register-read.scala:70:29
  reg         exe_reg_uops_1_ctrl_fcn_dw;	// register-read.scala:70:29
  reg         exe_reg_uops_1_is_br;	// register-read.scala:70:29
  reg         exe_reg_uops_1_is_jalr;	// register-read.scala:70:29
  reg         exe_reg_uops_1_is_jal;	// register-read.scala:70:29
  reg         exe_reg_uops_1_is_sfb;	// register-read.scala:70:29
  reg  [15:0] exe_reg_uops_1_br_mask;	// register-read.scala:70:29
  reg  [3:0]  exe_reg_uops_1_br_tag;	// register-read.scala:70:29
  reg  [4:0]  exe_reg_uops_1_ftq_idx;	// register-read.scala:70:29
  reg         exe_reg_uops_1_edge_inst;	// register-read.scala:70:29
  reg  [5:0]  exe_reg_uops_1_pc_lob;	// register-read.scala:70:29
  reg         exe_reg_uops_1_taken;	// register-read.scala:70:29
  reg  [19:0] exe_reg_uops_1_imm_packed;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_1_rob_idx;	// register-read.scala:70:29
  reg  [4:0]  exe_reg_uops_1_ldq_idx;	// register-read.scala:70:29
  reg  [4:0]  exe_reg_uops_1_stq_idx;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_1_pdst;	// register-read.scala:70:29
  reg  [6:0]  exe_reg_uops_1_prs1;	// register-read.scala:70:29
  reg         exe_reg_uops_1_bypassable;	// register-read.scala:70:29
  reg         exe_reg_uops_1_is_amo;	// register-read.scala:70:29
  reg         exe_reg_uops_1_uses_stq;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_1_dst_rtype;	// register-read.scala:70:29
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
  reg  [2:0]  exe_reg_uops_2_ctrl_csr_cmd;	// register-read.scala:70:29
  reg         exe_reg_uops_2_ctrl_is_load;	// register-read.scala:70:29
  reg         exe_reg_uops_2_ctrl_is_sta;	// register-read.scala:70:29
  reg         exe_reg_uops_2_ctrl_is_std;	// register-read.scala:70:29
  reg  [1:0]  exe_reg_uops_2_iw_state;	// register-read.scala:70:29
  reg         exe_reg_uops_2_is_br;	// register-read.scala:70:29
  reg         exe_reg_uops_2_is_jalr;	// register-read.scala:70:29
  reg         exe_reg_uops_2_is_jal;	// register-read.scala:70:29
  reg         exe_reg_uops_2_is_sfb;	// register-read.scala:70:29
  reg  [15:0] exe_reg_uops_2_br_mask;	// register-read.scala:70:29
  reg  [3:0]  exe_reg_uops_2_br_tag;	// register-read.scala:70:29
  reg  [4:0]  exe_reg_uops_2_ftq_idx;	// register-read.scala:70:29
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
  reg  [4:0]  exe_reg_uops_2_ppred;	// register-read.scala:70:29
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
  reg         exe_reg_uops_3_is_br;	// register-read.scala:70:29
  reg         exe_reg_uops_3_is_jalr;	// register-read.scala:70:29
  reg         exe_reg_uops_3_is_jal;	// register-read.scala:70:29
  reg         exe_reg_uops_3_is_sfb;	// register-read.scala:70:29
  reg  [15:0] exe_reg_uops_3_br_mask;	// register-read.scala:70:29
  reg  [3:0]  exe_reg_uops_3_br_tag;	// register-read.scala:70:29
  reg  [4:0]  exe_reg_uops_3_ftq_idx;	// register-read.scala:70:29
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
  reg  [63:0] exe_reg_rs1_data_0;	// register-read.scala:71:29
  reg  [63:0] exe_reg_rs1_data_1;	// register-read.scala:71:29
  reg  [63:0] exe_reg_rs1_data_2;	// register-read.scala:71:29
  reg  [63:0] exe_reg_rs1_data_3;	// register-read.scala:71:29
  reg  [63:0] exe_reg_rs2_data_0;	// register-read.scala:72:29
  reg  [63:0] exe_reg_rs2_data_1;	// register-read.scala:72:29
  reg  [63:0] exe_reg_rs2_data_2;	// register-read.scala:72:29
  reg  [63:0] exe_reg_rs2_data_3;	// register-read.scala:72:29
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
  reg  [15:0] rrd_uops_0_REG_br_mask;	// register-read.scala:86:29
  reg  [3:0]  rrd_uops_0_REG_br_tag;	// register-read.scala:86:29
  reg  [4:0]  rrd_uops_0_REG_ftq_idx;	// register-read.scala:86:29
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
  reg         rrd_uops_1_REG_is_rvc;	// register-read.scala:86:29
  reg  [9:0]  rrd_uops_1_REG_fu_code;	// register-read.scala:86:29
  reg  [3:0]  rrd_uops_1_REG_ctrl_br_type;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_1_REG_ctrl_op1_sel;	// register-read.scala:86:29
  reg  [2:0]  rrd_uops_1_REG_ctrl_op2_sel;	// register-read.scala:86:29
  reg  [2:0]  rrd_uops_1_REG_ctrl_imm_sel;	// register-read.scala:86:29
  reg  [3:0]  rrd_uops_1_REG_ctrl_op_fcn;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_ctrl_fcn_dw;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_is_br;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_is_jalr;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_is_jal;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_is_sfb;	// register-read.scala:86:29
  reg  [15:0] rrd_uops_1_REG_br_mask;	// register-read.scala:86:29
  reg  [3:0]  rrd_uops_1_REG_br_tag;	// register-read.scala:86:29
  reg  [4:0]  rrd_uops_1_REG_ftq_idx;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_edge_inst;	// register-read.scala:86:29
  reg  [5:0]  rrd_uops_1_REG_pc_lob;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_taken;	// register-read.scala:86:29
  reg  [19:0] rrd_uops_1_REG_imm_packed;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_1_REG_rob_idx;	// register-read.scala:86:29
  reg  [4:0]  rrd_uops_1_REG_ldq_idx;	// register-read.scala:86:29
  reg  [4:0]  rrd_uops_1_REG_stq_idx;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_1_REG_pdst;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_1_REG_prs1;	// register-read.scala:86:29
  reg  [6:0]  rrd_uops_1_REG_prs2;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_bypassable;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_is_amo;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_uses_stq;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_1_REG_dst_rtype;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_1_REG_lrs1_rtype;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_1_REG_lrs2_rtype;	// register-read.scala:86:29
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
  reg  [2:0]  rrd_uops_2_REG_ctrl_csr_cmd;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_ctrl_is_load;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_ctrl_is_sta;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_ctrl_is_std;	// register-read.scala:86:29
  reg  [1:0]  rrd_uops_2_REG_iw_state;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_is_br;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_is_jalr;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_is_jal;	// register-read.scala:86:29
  reg         rrd_uops_2_REG_is_sfb;	// register-read.scala:86:29
  reg  [15:0] rrd_uops_2_REG_br_mask;	// register-read.scala:86:29
  reg  [3:0]  rrd_uops_2_REG_br_tag;	// register-read.scala:86:29
  reg  [4:0]  rrd_uops_2_REG_ftq_idx;	// register-read.scala:86:29
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
  reg  [4:0]  rrd_uops_2_REG_ppred;	// register-read.scala:86:29
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
  reg         rrd_uops_3_REG_is_br;	// register-read.scala:86:29
  reg         rrd_uops_3_REG_is_jalr;	// register-read.scala:86:29
  reg         rrd_uops_3_REG_is_jal;	// register-read.scala:86:29
  reg         rrd_uops_3_REG_is_sfb;	// register-read.scala:86:29
  reg  [15:0] rrd_uops_3_REG_br_mask;	// register-read.scala:86:29
  reg  [3:0]  rrd_uops_3_REG_br_tag;	// register-read.scala:86:29
  reg  [4:0]  rrd_uops_3_REG_ftq_idx;	// register-read.scala:86:29
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
  reg         rrd_rs1_data_0_REG;	// register-read.scala:124:57
  reg         rrd_rs2_data_0_REG;	// register-read.scala:125:57
  reg         rrd_rs1_data_1_REG;	// register-read.scala:124:57
  reg         rrd_rs2_data_1_REG;	// register-read.scala:125:57
  reg         rrd_rs1_data_2_REG;	// register-read.scala:124:57
  reg         rrd_rs2_data_2_REG;	// register-read.scala:125:57
  reg         rrd_rs1_data_3_REG;	// register-read.scala:124:57
  reg         rrd_rs2_data_3_REG;	// register-read.scala:125:57
  always @(posedge clock) begin
    automatic logic rrd_kill;	// register-read.scala:130:28
    automatic logic rrd_kill_1;	// register-read.scala:130:28
    automatic logic rrd_kill_2;	// register-read.scala:130:28
    automatic logic rrd_kill_3;	// register-read.scala:130:28
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
    automatic logic _GEN_11;	// register-read.scala:174:63
    automatic logic _GEN_12;	// register-read.scala:176:63
    automatic logic _GEN_13;	// register-read.scala:174:63
    automatic logic _GEN_14;	// register-read.scala:176:63
    automatic logic _GEN_15;	// register-read.scala:174:63
    automatic logic _GEN_16;	// register-read.scala:176:63
    rrd_kill = io_kill | (|(io_brupdate_b1_mispredict_mask & rrd_uops_0_REG_br_mask));	// register-read.scala:86:29, :130:28, util.scala:118:{51,59}
    rrd_kill_1 = io_kill | (|(io_brupdate_b1_mispredict_mask & rrd_uops_1_REG_br_mask));	// register-read.scala:86:29, :130:28, util.scala:118:{51,59}
    rrd_kill_2 = io_kill | (|(io_brupdate_b1_mispredict_mask & rrd_uops_2_REG_br_mask));	// register-read.scala:86:29, :130:28, util.scala:118:{51,59}
    rrd_kill_3 = io_kill | (|(io_brupdate_b1_mispredict_mask & rrd_uops_3_REG_br_mask));	// register-read.scala:86:29, :130:28, util.scala:118:{51,59}
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
    _GEN_11 = rrd_uops_1_REG_lrs1_rtype == 2'h0;	// consts.scala:270:20, register-read.scala:86:29, :174:63
    _GEN_12 = rrd_uops_1_REG_lrs2_rtype == 2'h0;	// consts.scala:270:20, register-read.scala:86:29, :176:63
    _GEN_13 = rrd_uops_2_REG_lrs1_rtype == 2'h0;	// consts.scala:270:20, register-read.scala:86:29, :174:63
    _GEN_14 = rrd_uops_2_REG_lrs2_rtype == 2'h0;	// consts.scala:270:20, register-read.scala:86:29, :176:63
    _GEN_15 = rrd_uops_3_REG_lrs1_rtype == 2'h0;	// consts.scala:270:20, register-read.scala:86:29, :174:63
    _GEN_16 = rrd_uops_3_REG_lrs2_rtype == 2'h0;	// consts.scala:270:20, register-read.scala:86:29, :176:63
    if (reset) begin
      exe_reg_valids_0 <= 1'h0;	// register-read.scala:69:33, :80:33
      exe_reg_valids_1 <= 1'h0;	// register-read.scala:69:33, :80:33
      exe_reg_valids_2 <= 1'h0;	// register-read.scala:69:33, :80:33
      exe_reg_valids_3 <= 1'h0;	// register-read.scala:69:33, :80:33
    end
    else begin
      exe_reg_valids_0 <= ~rrd_kill & rrd_valids_0_REG;	// register-read.scala:69:33, :84:29, :130:28, :132:29
      exe_reg_valids_1 <= ~rrd_kill_1 & rrd_valids_1_REG;	// register-read.scala:69:33, :84:29, :130:28, :132:29
      exe_reg_valids_2 <= ~rrd_kill_2 & rrd_valids_2_REG;	// register-read.scala:69:33, :84:29, :130:28, :132:29
      exe_reg_valids_3 <= ~rrd_kill_3 & rrd_valids_3_REG;	// register-read.scala:69:33, :84:29, :130:28, :132:29
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
      exe_reg_uops_0_rob_idx <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_0_ldq_idx <= 5'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_0_stq_idx <= 5'h0;	// register-read.scala:70:29, :103:21
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
      exe_reg_uops_1_fu_code <= 10'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_ctrl_br_type <= 4'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_ctrl_op1_sel <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_ctrl_op2_sel <= 3'h0;	// register-read.scala:70:29, :80:33
      exe_reg_uops_1_ctrl_imm_sel <= 3'h0;	// register-read.scala:70:29, :80:33
      exe_reg_uops_1_ctrl_op_fcn <= 4'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_br_tag <= 4'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_ftq_idx <= 5'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_1_pc_lob <= 6'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_imm_packed <= 20'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_rob_idx <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_1_ldq_idx <= 5'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_1_stq_idx <= 5'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_1_pdst <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_1_prs1 <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_1_dst_rtype <= 2'h2;	// consts.scala:277:20, register-read.scala:70:29
    end
    else begin	// register-read.scala:130:28
      exe_reg_uops_1_uopc <= rrd_uops_1_REG_uopc;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_fu_code <= rrd_uops_1_REG_fu_code;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_ctrl_br_type <= rrd_uops_1_REG_ctrl_br_type;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_ctrl_op1_sel <= rrd_uops_1_REG_ctrl_op1_sel;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_ctrl_op2_sel <= rrd_uops_1_REG_ctrl_op2_sel;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_ctrl_imm_sel <= rrd_uops_1_REG_ctrl_imm_sel;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_ctrl_op_fcn <= rrd_uops_1_REG_ctrl_op_fcn;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_br_tag <= rrd_uops_1_REG_br_tag;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_ftq_idx <= rrd_uops_1_REG_ftq_idx;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_pc_lob <= rrd_uops_1_REG_pc_lob;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_imm_packed <= rrd_uops_1_REG_imm_packed;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_rob_idx <= rrd_uops_1_REG_rob_idx;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_ldq_idx <= rrd_uops_1_REG_ldq_idx;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_stq_idx <= rrd_uops_1_REG_stq_idx;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_pdst <= rrd_uops_1_REG_pdst;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_prs1 <= rrd_uops_1_REG_prs1;	// register-read.scala:70:29, :86:29
      exe_reg_uops_1_dst_rtype <= rrd_uops_1_REG_dst_rtype;	// register-read.scala:70:29, :86:29
    end
    exe_reg_uops_1_is_rvc <= ~rrd_kill_1 & rrd_uops_1_REG_is_rvc;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_ctrl_fcn_dw <= ~rrd_kill_1 & rrd_uops_1_REG_ctrl_fcn_dw;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_is_br <= ~rrd_kill_1 & rrd_uops_1_REG_is_br;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_is_jalr <= ~rrd_kill_1 & rrd_uops_1_REG_is_jalr;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_is_jal <= ~rrd_kill_1 & rrd_uops_1_REG_is_jal;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_is_sfb <= ~rrd_kill_1 & rrd_uops_1_REG_is_sfb;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_br_mask <= rrd_uops_1_REG_br_mask & ~io_brupdate_b1_resolve_mask;	// register-read.scala:70:29, :86:29, util.scala:74:37, :85:25
    exe_reg_uops_1_edge_inst <= ~rrd_kill_1 & rrd_uops_1_REG_edge_inst;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_taken <= ~rrd_kill_1 & rrd_uops_1_REG_taken;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_bypassable <= ~rrd_kill_1 & rrd_uops_1_REG_bypassable;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_is_amo <= ~rrd_kill_1 & rrd_uops_1_REG_is_amo;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_uses_stq <= ~rrd_kill_1 & rrd_uops_1_REG_uses_stq;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    if (rrd_kill_2) begin	// register-read.scala:130:28
      exe_reg_uops_2_uopc <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_2_inst <= 32'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_debug_inst <= 32'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_debug_pc <= 40'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_iq_type <= 3'h0;	// register-read.scala:70:29, :80:33
      exe_reg_uops_2_fu_code <= 10'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_ctrl_br_type <= 4'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_ctrl_op1_sel <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_ctrl_op2_sel <= 3'h0;	// register-read.scala:70:29, :80:33
      exe_reg_uops_2_ctrl_imm_sel <= 3'h0;	// register-read.scala:70:29, :80:33
      exe_reg_uops_2_ctrl_op_fcn <= 4'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_ctrl_csr_cmd <= 3'h0;	// register-read.scala:70:29, :80:33
      exe_reg_uops_2_iw_state <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_br_tag <= 4'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_ftq_idx <= 5'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_2_pc_lob <= 6'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_imm_packed <= 20'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_csr_addr <= 12'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_rob_idx <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_2_ldq_idx <= 5'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_2_stq_idx <= 5'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_2_rxq_idx <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_pdst <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_2_prs1 <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_2_prs2 <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_2_prs3 <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_2_ppred <= 5'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_2_stale_pdst <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_2_exc_cause <= 64'h0;	// register-read.scala:70:29
      exe_reg_uops_2_mem_cmd <= 5'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_2_mem_size <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_ldst <= 6'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_lrs1 <= 6'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_lrs2 <= 6'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_2_lrs3 <= 6'h0;	// consts.scala:270:20, register-read.scala:70:29
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
      exe_reg_uops_2_ctrl_csr_cmd <= rrd_uops_2_REG_ctrl_csr_cmd;	// register-read.scala:70:29, :86:29
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
      exe_reg_uops_3_uopc <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_3_fu_code <= 10'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_3_ctrl_br_type <= 4'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_3_ctrl_op1_sel <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_3_ctrl_op2_sel <= 3'h0;	// register-read.scala:70:29, :80:33
      exe_reg_uops_3_ctrl_imm_sel <= 3'h0;	// register-read.scala:70:29, :80:33
      exe_reg_uops_3_ctrl_op_fcn <= 4'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_3_br_tag <= 4'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_3_ftq_idx <= 5'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_3_pc_lob <= 6'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_3_imm_packed <= 20'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_3_rob_idx <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_3_ldq_idx <= 5'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_3_stq_idx <= 5'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_3_pdst <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_3_prs1 <= 7'h0;	// register-read.scala:70:29
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
    else if (rrd_rs1_data_0_REG)	// register-read.scala:124:57
      exe_reg_rs1_data_0 <= 64'h0;	// register-read.scala:71:29
    else	// register-read.scala:124:57
      exe_reg_rs1_data_0 <= io_rf_read_ports_0_data;	// register-read.scala:71:29
    if (io_bypass_0_valid & rrd_uops_1_REG_prs1 == io_bypass_0_bits_uop_pdst & _GEN
        & _GEN_0 & _GEN_11 & (|rrd_uops_1_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_1 <= io_bypass_0_bits_data;	// register-read.scala:71:29
    else if (io_bypass_1_valid & rrd_uops_1_REG_prs1 == io_bypass_1_bits_uop_pdst & _GEN_3
             & _GEN_4 & _GEN_11 & (|rrd_uops_1_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_1 <= io_bypass_1_bits_data;	// register-read.scala:71:29
    else if (io_bypass_2_valid & rrd_uops_1_REG_prs1 == io_bypass_2_bits_uop_pdst & _GEN_5
             & _GEN_6 & _GEN_11 & (|rrd_uops_1_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_1 <= io_bypass_2_bits_data;	// register-read.scala:71:29
    else if (io_bypass_3_valid & rrd_uops_1_REG_prs1 == io_bypass_3_bits_uop_pdst & _GEN_7
             & _GEN_8 & _GEN_11 & (|rrd_uops_1_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_1 <= io_bypass_3_bits_data;	// register-read.scala:71:29
    else if (io_bypass_4_valid & rrd_uops_1_REG_prs1 == io_bypass_4_bits_uop_pdst & _GEN_9
             & _GEN_10 & _GEN_11 & (|rrd_uops_1_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_1 <= io_bypass_4_bits_data;	// register-read.scala:71:29
    else if (rrd_rs1_data_1_REG)	// register-read.scala:124:57
      exe_reg_rs1_data_1 <= 64'h0;	// register-read.scala:71:29
    else	// register-read.scala:124:57
      exe_reg_rs1_data_1 <= io_rf_read_ports_2_data;	// register-read.scala:71:29
    if (io_bypass_0_valid & rrd_uops_2_REG_prs1 == io_bypass_0_bits_uop_pdst & _GEN
        & _GEN_0 & _GEN_13 & (|rrd_uops_2_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_2 <= io_bypass_0_bits_data;	// register-read.scala:71:29
    else if (io_bypass_1_valid & rrd_uops_2_REG_prs1 == io_bypass_1_bits_uop_pdst & _GEN_3
             & _GEN_4 & _GEN_13 & (|rrd_uops_2_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_2 <= io_bypass_1_bits_data;	// register-read.scala:71:29
    else if (io_bypass_2_valid & rrd_uops_2_REG_prs1 == io_bypass_2_bits_uop_pdst & _GEN_5
             & _GEN_6 & _GEN_13 & (|rrd_uops_2_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_2 <= io_bypass_2_bits_data;	// register-read.scala:71:29
    else if (io_bypass_3_valid & rrd_uops_2_REG_prs1 == io_bypass_3_bits_uop_pdst & _GEN_7
             & _GEN_8 & _GEN_13 & (|rrd_uops_2_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_2 <= io_bypass_3_bits_data;	// register-read.scala:71:29
    else if (io_bypass_4_valid & rrd_uops_2_REG_prs1 == io_bypass_4_bits_uop_pdst & _GEN_9
             & _GEN_10 & _GEN_13 & (|rrd_uops_2_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_2 <= io_bypass_4_bits_data;	// register-read.scala:71:29
    else if (rrd_rs1_data_2_REG)	// register-read.scala:124:57
      exe_reg_rs1_data_2 <= 64'h0;	// register-read.scala:71:29
    else	// register-read.scala:124:57
      exe_reg_rs1_data_2 <= io_rf_read_ports_4_data;	// register-read.scala:71:29
    if (io_bypass_0_valid & rrd_uops_3_REG_prs1 == io_bypass_0_bits_uop_pdst & _GEN
        & _GEN_0 & _GEN_15 & (|rrd_uops_3_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_3 <= io_bypass_0_bits_data;	// register-read.scala:71:29
    else if (io_bypass_1_valid & rrd_uops_3_REG_prs1 == io_bypass_1_bits_uop_pdst & _GEN_3
             & _GEN_4 & _GEN_15 & (|rrd_uops_3_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_3 <= io_bypass_1_bits_data;	// register-read.scala:71:29
    else if (io_bypass_2_valid & rrd_uops_3_REG_prs1 == io_bypass_2_bits_uop_pdst & _GEN_5
             & _GEN_6 & _GEN_15 & (|rrd_uops_3_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_3 <= io_bypass_2_bits_data;	// register-read.scala:71:29
    else if (io_bypass_3_valid & rrd_uops_3_REG_prs1 == io_bypass_3_bits_uop_pdst & _GEN_7
             & _GEN_8 & _GEN_15 & (|rrd_uops_3_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_3 <= io_bypass_3_bits_data;	// register-read.scala:71:29
    else if (io_bypass_4_valid & rrd_uops_3_REG_prs1 == io_bypass_4_bits_uop_pdst & _GEN_9
             & _GEN_10 & _GEN_15 & (|rrd_uops_3_REG_prs1))	// micro-op.scala:149:36, register-read.scala:86:29, :173:50, :174:{38,63,74,83}
      exe_reg_rs1_data_3 <= io_bypass_4_bits_data;	// register-read.scala:71:29
    else if (rrd_rs1_data_3_REG)	// register-read.scala:124:57
      exe_reg_rs1_data_3 <= 64'h0;	// register-read.scala:71:29
    else	// register-read.scala:124:57
      exe_reg_rs1_data_3 <= io_rf_read_ports_6_data;	// register-read.scala:71:29
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
    else if (rrd_rs2_data_0_REG)	// register-read.scala:125:57
      exe_reg_rs2_data_0 <= 64'h0;	// register-read.scala:72:29
    else	// register-read.scala:125:57
      exe_reg_rs2_data_0 <= io_rf_read_ports_1_data;	// register-read.scala:72:29
    if (io_bypass_0_valid & rrd_uops_1_REG_prs2 == io_bypass_0_bits_uop_pdst & _GEN
        & _GEN_0 & _GEN_12 & (|rrd_uops_1_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_1 <= io_bypass_0_bits_data;	// register-read.scala:72:29
    else if (io_bypass_1_valid & rrd_uops_1_REG_prs2 == io_bypass_1_bits_uop_pdst & _GEN_3
             & _GEN_4 & _GEN_12 & (|rrd_uops_1_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_1 <= io_bypass_1_bits_data;	// register-read.scala:72:29
    else if (io_bypass_2_valid & rrd_uops_1_REG_prs2 == io_bypass_2_bits_uop_pdst & _GEN_5
             & _GEN_6 & _GEN_12 & (|rrd_uops_1_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_1 <= io_bypass_2_bits_data;	// register-read.scala:72:29
    else if (io_bypass_3_valid & rrd_uops_1_REG_prs2 == io_bypass_3_bits_uop_pdst & _GEN_7
             & _GEN_8 & _GEN_12 & (|rrd_uops_1_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_1 <= io_bypass_3_bits_data;	// register-read.scala:72:29
    else if (io_bypass_4_valid & rrd_uops_1_REG_prs2 == io_bypass_4_bits_uop_pdst & _GEN_9
             & _GEN_10 & _GEN_12 & (|rrd_uops_1_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_1 <= io_bypass_4_bits_data;	// register-read.scala:72:29
    else if (rrd_rs2_data_1_REG)	// register-read.scala:125:57
      exe_reg_rs2_data_1 <= 64'h0;	// register-read.scala:72:29
    else	// register-read.scala:125:57
      exe_reg_rs2_data_1 <= io_rf_read_ports_3_data;	// register-read.scala:72:29
    if (io_bypass_0_valid & rrd_uops_2_REG_prs2 == io_bypass_0_bits_uop_pdst & _GEN
        & _GEN_0 & _GEN_14 & (|rrd_uops_2_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_2 <= io_bypass_0_bits_data;	// register-read.scala:72:29
    else if (io_bypass_1_valid & rrd_uops_2_REG_prs2 == io_bypass_1_bits_uop_pdst & _GEN_3
             & _GEN_4 & _GEN_14 & (|rrd_uops_2_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_2 <= io_bypass_1_bits_data;	// register-read.scala:72:29
    else if (io_bypass_2_valid & rrd_uops_2_REG_prs2 == io_bypass_2_bits_uop_pdst & _GEN_5
             & _GEN_6 & _GEN_14 & (|rrd_uops_2_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_2 <= io_bypass_2_bits_data;	// register-read.scala:72:29
    else if (io_bypass_3_valid & rrd_uops_2_REG_prs2 == io_bypass_3_bits_uop_pdst & _GEN_7
             & _GEN_8 & _GEN_14 & (|rrd_uops_2_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_2 <= io_bypass_3_bits_data;	// register-read.scala:72:29
    else if (io_bypass_4_valid & rrd_uops_2_REG_prs2 == io_bypass_4_bits_uop_pdst & _GEN_9
             & _GEN_10 & _GEN_14 & (|rrd_uops_2_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_2 <= io_bypass_4_bits_data;	// register-read.scala:72:29
    else if (rrd_rs2_data_2_REG)	// register-read.scala:125:57
      exe_reg_rs2_data_2 <= 64'h0;	// register-read.scala:72:29
    else	// register-read.scala:125:57
      exe_reg_rs2_data_2 <= io_rf_read_ports_5_data;	// register-read.scala:72:29
    if (io_bypass_0_valid & rrd_uops_3_REG_prs2 == io_bypass_0_bits_uop_pdst & _GEN
        & _GEN_0 & _GEN_16 & (|rrd_uops_3_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_3 <= io_bypass_0_bits_data;	// register-read.scala:72:29
    else if (io_bypass_1_valid & rrd_uops_3_REG_prs2 == io_bypass_1_bits_uop_pdst & _GEN_3
             & _GEN_4 & _GEN_16 & (|rrd_uops_3_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_3 <= io_bypass_1_bits_data;	// register-read.scala:72:29
    else if (io_bypass_2_valid & rrd_uops_3_REG_prs2 == io_bypass_2_bits_uop_pdst & _GEN_5
             & _GEN_6 & _GEN_16 & (|rrd_uops_3_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_3 <= io_bypass_2_bits_data;	// register-read.scala:72:29
    else if (io_bypass_3_valid & rrd_uops_3_REG_prs2 == io_bypass_3_bits_uop_pdst & _GEN_7
             & _GEN_8 & _GEN_16 & (|rrd_uops_3_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_3 <= io_bypass_3_bits_data;	// register-read.scala:72:29
    else if (io_bypass_4_valid & rrd_uops_3_REG_prs2 == io_bypass_4_bits_uop_pdst & _GEN_9
             & _GEN_10 & _GEN_16 & (|rrd_uops_3_REG_prs2))	// micro-op.scala:149:36, register-read.scala:86:29, :174:38, :175:50, :176:{63,74,83}
      exe_reg_rs2_data_3 <= io_bypass_4_bits_data;	// register-read.scala:72:29
    else if (rrd_rs2_data_3_REG)	// register-read.scala:125:57
      exe_reg_rs2_data_3 <= 64'h0;	// register-read.scala:72:29
    else	// register-read.scala:125:57
      exe_reg_rs2_data_3 <= io_rf_read_ports_7_data;	// register-read.scala:72:29
    rrd_valids_0_REG <=
      _rrd_decode_unit_io_rrd_valid
      & (io_brupdate_b1_mispredict_mask & _rrd_decode_unit_io_rrd_uop_br_mask) == 16'h0;	// register-read.scala:80:33, :84:{29,59}, util.scala:118:{51,59}
    rrd_uops_0_REG_uopc <= _rrd_decode_unit_io_rrd_uop_uopc;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_inst <= _rrd_decode_unit_io_rrd_uop_inst;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_debug_inst <= _rrd_decode_unit_io_rrd_uop_debug_inst;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_is_rvc <= _rrd_decode_unit_io_rrd_uop_is_rvc;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_debug_pc <= _rrd_decode_unit_io_rrd_uop_debug_pc;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_iq_type <= _rrd_decode_unit_io_rrd_uop_iq_type;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_fu_code <= _rrd_decode_unit_io_rrd_uop_fu_code;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_ctrl_br_type <= _rrd_decode_unit_io_rrd_uop_ctrl_br_type;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_ctrl_op1_sel <= _rrd_decode_unit_io_rrd_uop_ctrl_op1_sel;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_ctrl_op2_sel <= _rrd_decode_unit_io_rrd_uop_ctrl_op2_sel;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_ctrl_imm_sel <= _rrd_decode_unit_io_rrd_uop_ctrl_imm_sel;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_ctrl_op_fcn <= _rrd_decode_unit_io_rrd_uop_ctrl_op_fcn;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_ctrl_fcn_dw <= _rrd_decode_unit_io_rrd_uop_ctrl_fcn_dw;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_ctrl_is_load <= _rrd_decode_unit_io_rrd_uop_ctrl_is_load;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_ctrl_is_sta <= _rrd_decode_unit_io_rrd_uop_ctrl_is_sta;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_ctrl_is_std <= _rrd_decode_unit_io_rrd_uop_ctrl_is_std;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_iw_state <= _rrd_decode_unit_io_rrd_uop_iw_state;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_is_br <= _rrd_decode_unit_io_rrd_uop_is_br;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_is_jalr <= _rrd_decode_unit_io_rrd_uop_is_jalr;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_is_jal <= _rrd_decode_unit_io_rrd_uop_is_jal;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_is_sfb <= _rrd_decode_unit_io_rrd_uop_is_sfb;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_br_mask <=
      _rrd_decode_unit_io_rrd_uop_br_mask & ~io_brupdate_b1_resolve_mask;	// register-read.scala:80:33, :86:29, util.scala:74:{35,37}
    rrd_uops_0_REG_br_tag <= _rrd_decode_unit_io_rrd_uop_br_tag;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_ftq_idx <= _rrd_decode_unit_io_rrd_uop_ftq_idx;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_edge_inst <= _rrd_decode_unit_io_rrd_uop_edge_inst;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_pc_lob <= _rrd_decode_unit_io_rrd_uop_pc_lob;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_taken <= _rrd_decode_unit_io_rrd_uop_taken;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_imm_packed <= _rrd_decode_unit_io_rrd_uop_imm_packed;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_csr_addr <= _rrd_decode_unit_io_rrd_uop_csr_addr;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_rob_idx <= _rrd_decode_unit_io_rrd_uop_rob_idx;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_ldq_idx <= _rrd_decode_unit_io_rrd_uop_ldq_idx;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_stq_idx <= _rrd_decode_unit_io_rrd_uop_stq_idx;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_rxq_idx <= _rrd_decode_unit_io_rrd_uop_rxq_idx;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_pdst <= _rrd_decode_unit_io_rrd_uop_pdst;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_prs1 <= _rrd_decode_unit_io_rrd_uop_prs1;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_prs2 <= _rrd_decode_unit_io_rrd_uop_prs2;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_prs3 <= _rrd_decode_unit_io_rrd_uop_prs3;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_ppred <= _rrd_decode_unit_io_rrd_uop_ppred;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_prs1_busy <= _rrd_decode_unit_io_rrd_uop_prs1_busy;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_prs2_busy <= _rrd_decode_unit_io_rrd_uop_prs2_busy;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_prs3_busy <= _rrd_decode_unit_io_rrd_uop_prs3_busy;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_ppred_busy <= _rrd_decode_unit_io_rrd_uop_ppred_busy;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_stale_pdst <= _rrd_decode_unit_io_rrd_uop_stale_pdst;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_exception <= _rrd_decode_unit_io_rrd_uop_exception;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_exc_cause <= _rrd_decode_unit_io_rrd_uop_exc_cause;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_bypassable <= _rrd_decode_unit_io_rrd_uop_bypassable;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_mem_cmd <= _rrd_decode_unit_io_rrd_uop_mem_cmd;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_mem_size <= _rrd_decode_unit_io_rrd_uop_mem_size;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_mem_signed <= _rrd_decode_unit_io_rrd_uop_mem_signed;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_is_fence <= _rrd_decode_unit_io_rrd_uop_is_fence;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_is_fencei <= _rrd_decode_unit_io_rrd_uop_is_fencei;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_is_amo <= _rrd_decode_unit_io_rrd_uop_is_amo;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_uses_ldq <= _rrd_decode_unit_io_rrd_uop_uses_ldq;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_uses_stq <= _rrd_decode_unit_io_rrd_uop_uses_stq;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_is_sys_pc2epc <= _rrd_decode_unit_io_rrd_uop_is_sys_pc2epc;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_is_unique <= _rrd_decode_unit_io_rrd_uop_is_unique;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_flush_on_commit <= _rrd_decode_unit_io_rrd_uop_flush_on_commit;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_ldst_is_rs1 <= _rrd_decode_unit_io_rrd_uop_ldst_is_rs1;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_ldst <= _rrd_decode_unit_io_rrd_uop_ldst;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_lrs1 <= _rrd_decode_unit_io_rrd_uop_lrs1;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_lrs2 <= _rrd_decode_unit_io_rrd_uop_lrs2;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_lrs3 <= _rrd_decode_unit_io_rrd_uop_lrs3;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_ldst_val <= _rrd_decode_unit_io_rrd_uop_ldst_val;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_dst_rtype <= _rrd_decode_unit_io_rrd_uop_dst_rtype;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_lrs1_rtype <= _rrd_decode_unit_io_rrd_uop_lrs1_rtype;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_lrs2_rtype <= _rrd_decode_unit_io_rrd_uop_lrs2_rtype;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_frs3_en <= _rrd_decode_unit_io_rrd_uop_frs3_en;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_fp_val <= _rrd_decode_unit_io_rrd_uop_fp_val;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_fp_single <= _rrd_decode_unit_io_rrd_uop_fp_single;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_xcpt_pf_if <= _rrd_decode_unit_io_rrd_uop_xcpt_pf_if;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_xcpt_ae_if <= _rrd_decode_unit_io_rrd_uop_xcpt_ae_if;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_xcpt_ma_if <= _rrd_decode_unit_io_rrd_uop_xcpt_ma_if;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_bp_debug_if <= _rrd_decode_unit_io_rrd_uop_bp_debug_if;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_bp_xcpt_if <= _rrd_decode_unit_io_rrd_uop_bp_xcpt_if;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_debug_fsrc <= _rrd_decode_unit_io_rrd_uop_debug_fsrc;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_debug_tsrc <= _rrd_decode_unit_io_rrd_uop_debug_tsrc;	// register-read.scala:80:33, :86:29
    rrd_valids_1_REG <=
      _rrd_decode_unit_1_io_rrd_valid
      & (io_brupdate_b1_mispredict_mask & _rrd_decode_unit_1_io_rrd_uop_br_mask) == 16'h0;	// register-read.scala:80:33, :84:{29,59}, util.scala:118:{51,59}
    rrd_uops_1_REG_uopc <= _rrd_decode_unit_1_io_rrd_uop_uopc;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_is_rvc <= _rrd_decode_unit_1_io_rrd_uop_is_rvc;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_fu_code <= _rrd_decode_unit_1_io_rrd_uop_fu_code;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_ctrl_br_type <= _rrd_decode_unit_1_io_rrd_uop_ctrl_br_type;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_ctrl_op1_sel <= _rrd_decode_unit_1_io_rrd_uop_ctrl_op1_sel;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_ctrl_op2_sel <= _rrd_decode_unit_1_io_rrd_uop_ctrl_op2_sel;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_ctrl_imm_sel <= _rrd_decode_unit_1_io_rrd_uop_ctrl_imm_sel;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_ctrl_op_fcn <= _rrd_decode_unit_1_io_rrd_uop_ctrl_op_fcn;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_ctrl_fcn_dw <= _rrd_decode_unit_1_io_rrd_uop_ctrl_fcn_dw;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_is_br <= _rrd_decode_unit_1_io_rrd_uop_is_br;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_is_jalr <= _rrd_decode_unit_1_io_rrd_uop_is_jalr;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_is_jal <= _rrd_decode_unit_1_io_rrd_uop_is_jal;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_is_sfb <= _rrd_decode_unit_1_io_rrd_uop_is_sfb;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_br_mask <=
      _rrd_decode_unit_1_io_rrd_uop_br_mask & ~io_brupdate_b1_resolve_mask;	// register-read.scala:80:33, :86:29, util.scala:74:{35,37}
    rrd_uops_1_REG_br_tag <= _rrd_decode_unit_1_io_rrd_uop_br_tag;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_ftq_idx <= _rrd_decode_unit_1_io_rrd_uop_ftq_idx;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_edge_inst <= _rrd_decode_unit_1_io_rrd_uop_edge_inst;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_pc_lob <= _rrd_decode_unit_1_io_rrd_uop_pc_lob;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_taken <= _rrd_decode_unit_1_io_rrd_uop_taken;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_imm_packed <= _rrd_decode_unit_1_io_rrd_uop_imm_packed;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_rob_idx <= _rrd_decode_unit_1_io_rrd_uop_rob_idx;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_ldq_idx <= _rrd_decode_unit_1_io_rrd_uop_ldq_idx;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_stq_idx <= _rrd_decode_unit_1_io_rrd_uop_stq_idx;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_pdst <= _rrd_decode_unit_1_io_rrd_uop_pdst;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_prs1 <= _rrd_decode_unit_1_io_rrd_uop_prs1;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_prs2 <= _rrd_decode_unit_1_io_rrd_uop_prs2;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_bypassable <= _rrd_decode_unit_1_io_rrd_uop_bypassable;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_is_amo <= _rrd_decode_unit_1_io_rrd_uop_is_amo;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_uses_stq <= _rrd_decode_unit_1_io_rrd_uop_uses_stq;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_dst_rtype <= _rrd_decode_unit_1_io_rrd_uop_dst_rtype;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_lrs1_rtype <= _rrd_decode_unit_1_io_rrd_uop_lrs1_rtype;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_lrs2_rtype <= _rrd_decode_unit_1_io_rrd_uop_lrs2_rtype;	// register-read.scala:80:33, :86:29
    rrd_valids_2_REG <=
      _rrd_decode_unit_2_io_rrd_valid
      & (io_brupdate_b1_mispredict_mask & _rrd_decode_unit_2_io_rrd_uop_br_mask) == 16'h0;	// register-read.scala:80:33, :84:{29,59}, util.scala:118:{51,59}
    rrd_uops_2_REG_uopc <= _rrd_decode_unit_2_io_rrd_uop_uopc;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_inst <= _rrd_decode_unit_2_io_rrd_uop_inst;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_debug_inst <= _rrd_decode_unit_2_io_rrd_uop_debug_inst;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_is_rvc <= _rrd_decode_unit_2_io_rrd_uop_is_rvc;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_debug_pc <= _rrd_decode_unit_2_io_rrd_uop_debug_pc;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_iq_type <= _rrd_decode_unit_2_io_rrd_uop_iq_type;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_fu_code <= _rrd_decode_unit_2_io_rrd_uop_fu_code;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_ctrl_br_type <= _rrd_decode_unit_2_io_rrd_uop_ctrl_br_type;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_ctrl_op1_sel <= _rrd_decode_unit_2_io_rrd_uop_ctrl_op1_sel;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_ctrl_op2_sel <= _rrd_decode_unit_2_io_rrd_uop_ctrl_op2_sel;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_ctrl_imm_sel <= _rrd_decode_unit_2_io_rrd_uop_ctrl_imm_sel;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_ctrl_op_fcn <= _rrd_decode_unit_2_io_rrd_uop_ctrl_op_fcn;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_ctrl_fcn_dw <= _rrd_decode_unit_2_io_rrd_uop_ctrl_fcn_dw;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_ctrl_csr_cmd <= _rrd_decode_unit_2_io_rrd_uop_ctrl_csr_cmd;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_ctrl_is_load <= _rrd_decode_unit_2_io_rrd_uop_ctrl_is_load;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_ctrl_is_sta <= _rrd_decode_unit_2_io_rrd_uop_ctrl_is_sta;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_ctrl_is_std <= _rrd_decode_unit_2_io_rrd_uop_ctrl_is_std;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_iw_state <= _rrd_decode_unit_2_io_rrd_uop_iw_state;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_is_br <= _rrd_decode_unit_2_io_rrd_uop_is_br;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_is_jalr <= _rrd_decode_unit_2_io_rrd_uop_is_jalr;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_is_jal <= _rrd_decode_unit_2_io_rrd_uop_is_jal;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_is_sfb <= _rrd_decode_unit_2_io_rrd_uop_is_sfb;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_br_mask <=
      _rrd_decode_unit_2_io_rrd_uop_br_mask & ~io_brupdate_b1_resolve_mask;	// register-read.scala:80:33, :86:29, util.scala:74:{35,37}
    rrd_uops_2_REG_br_tag <= _rrd_decode_unit_2_io_rrd_uop_br_tag;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_ftq_idx <= _rrd_decode_unit_2_io_rrd_uop_ftq_idx;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_edge_inst <= _rrd_decode_unit_2_io_rrd_uop_edge_inst;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_pc_lob <= _rrd_decode_unit_2_io_rrd_uop_pc_lob;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_taken <= _rrd_decode_unit_2_io_rrd_uop_taken;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_imm_packed <= _rrd_decode_unit_2_io_rrd_uop_imm_packed;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_csr_addr <= _rrd_decode_unit_2_io_rrd_uop_csr_addr;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_rob_idx <= _rrd_decode_unit_2_io_rrd_uop_rob_idx;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_ldq_idx <= _rrd_decode_unit_2_io_rrd_uop_ldq_idx;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_stq_idx <= _rrd_decode_unit_2_io_rrd_uop_stq_idx;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_rxq_idx <= _rrd_decode_unit_2_io_rrd_uop_rxq_idx;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_pdst <= _rrd_decode_unit_2_io_rrd_uop_pdst;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_prs1 <= _rrd_decode_unit_2_io_rrd_uop_prs1;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_prs2 <= _rrd_decode_unit_2_io_rrd_uop_prs2;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_prs3 <= _rrd_decode_unit_2_io_rrd_uop_prs3;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_ppred <= _rrd_decode_unit_2_io_rrd_uop_ppred;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_prs1_busy <= _rrd_decode_unit_2_io_rrd_uop_prs1_busy;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_prs2_busy <= _rrd_decode_unit_2_io_rrd_uop_prs2_busy;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_prs3_busy <= _rrd_decode_unit_2_io_rrd_uop_prs3_busy;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_ppred_busy <= _rrd_decode_unit_2_io_rrd_uop_ppred_busy;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_stale_pdst <= _rrd_decode_unit_2_io_rrd_uop_stale_pdst;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_exception <= _rrd_decode_unit_2_io_rrd_uop_exception;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_exc_cause <= _rrd_decode_unit_2_io_rrd_uop_exc_cause;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_bypassable <= _rrd_decode_unit_2_io_rrd_uop_bypassable;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_mem_cmd <= _rrd_decode_unit_2_io_rrd_uop_mem_cmd;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_mem_size <= _rrd_decode_unit_2_io_rrd_uop_mem_size;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_mem_signed <= _rrd_decode_unit_2_io_rrd_uop_mem_signed;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_is_fence <= _rrd_decode_unit_2_io_rrd_uop_is_fence;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_is_fencei <= _rrd_decode_unit_2_io_rrd_uop_is_fencei;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_is_amo <= _rrd_decode_unit_2_io_rrd_uop_is_amo;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_uses_ldq <= _rrd_decode_unit_2_io_rrd_uop_uses_ldq;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_uses_stq <= _rrd_decode_unit_2_io_rrd_uop_uses_stq;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_is_sys_pc2epc <= _rrd_decode_unit_2_io_rrd_uop_is_sys_pc2epc;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_is_unique <= _rrd_decode_unit_2_io_rrd_uop_is_unique;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_flush_on_commit <= _rrd_decode_unit_2_io_rrd_uop_flush_on_commit;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_ldst_is_rs1 <= _rrd_decode_unit_2_io_rrd_uop_ldst_is_rs1;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_ldst <= _rrd_decode_unit_2_io_rrd_uop_ldst;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_lrs1 <= _rrd_decode_unit_2_io_rrd_uop_lrs1;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_lrs2 <= _rrd_decode_unit_2_io_rrd_uop_lrs2;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_lrs3 <= _rrd_decode_unit_2_io_rrd_uop_lrs3;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_ldst_val <= _rrd_decode_unit_2_io_rrd_uop_ldst_val;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_dst_rtype <= _rrd_decode_unit_2_io_rrd_uop_dst_rtype;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_lrs1_rtype <= _rrd_decode_unit_2_io_rrd_uop_lrs1_rtype;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_lrs2_rtype <= _rrd_decode_unit_2_io_rrd_uop_lrs2_rtype;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_frs3_en <= _rrd_decode_unit_2_io_rrd_uop_frs3_en;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_fp_val <= _rrd_decode_unit_2_io_rrd_uop_fp_val;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_fp_single <= _rrd_decode_unit_2_io_rrd_uop_fp_single;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_xcpt_pf_if <= _rrd_decode_unit_2_io_rrd_uop_xcpt_pf_if;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_xcpt_ae_if <= _rrd_decode_unit_2_io_rrd_uop_xcpt_ae_if;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_xcpt_ma_if <= _rrd_decode_unit_2_io_rrd_uop_xcpt_ma_if;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_bp_debug_if <= _rrd_decode_unit_2_io_rrd_uop_bp_debug_if;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_bp_xcpt_if <= _rrd_decode_unit_2_io_rrd_uop_bp_xcpt_if;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_debug_fsrc <= _rrd_decode_unit_2_io_rrd_uop_debug_fsrc;	// register-read.scala:80:33, :86:29
    rrd_uops_2_REG_debug_tsrc <= _rrd_decode_unit_2_io_rrd_uop_debug_tsrc;	// register-read.scala:80:33, :86:29
    rrd_valids_3_REG <=
      _rrd_decode_unit_3_io_rrd_valid
      & (io_brupdate_b1_mispredict_mask & _rrd_decode_unit_3_io_rrd_uop_br_mask) == 16'h0;	// register-read.scala:80:33, :84:{29,59}, util.scala:118:{51,59}
    rrd_uops_3_REG_uopc <= _rrd_decode_unit_3_io_rrd_uop_uopc;	// register-read.scala:80:33, :86:29
    rrd_uops_3_REG_is_rvc <= _rrd_decode_unit_3_io_rrd_uop_is_rvc;	// register-read.scala:80:33, :86:29
    rrd_uops_3_REG_fu_code <= _rrd_decode_unit_3_io_rrd_uop_fu_code;	// register-read.scala:80:33, :86:29
    rrd_uops_3_REG_ctrl_br_type <= _rrd_decode_unit_3_io_rrd_uop_ctrl_br_type;	// register-read.scala:80:33, :86:29
    rrd_uops_3_REG_ctrl_op1_sel <= _rrd_decode_unit_3_io_rrd_uop_ctrl_op1_sel;	// register-read.scala:80:33, :86:29
    rrd_uops_3_REG_ctrl_op2_sel <= _rrd_decode_unit_3_io_rrd_uop_ctrl_op2_sel;	// register-read.scala:80:33, :86:29
    rrd_uops_3_REG_ctrl_imm_sel <= _rrd_decode_unit_3_io_rrd_uop_ctrl_imm_sel;	// register-read.scala:80:33, :86:29
    rrd_uops_3_REG_ctrl_op_fcn <= _rrd_decode_unit_3_io_rrd_uop_ctrl_op_fcn;	// register-read.scala:80:33, :86:29
    rrd_uops_3_REG_ctrl_fcn_dw <= _rrd_decode_unit_3_io_rrd_uop_ctrl_fcn_dw;	// register-read.scala:80:33, :86:29
    rrd_uops_3_REG_is_br <= _rrd_decode_unit_3_io_rrd_uop_is_br;	// register-read.scala:80:33, :86:29
    rrd_uops_3_REG_is_jalr <= _rrd_decode_unit_3_io_rrd_uop_is_jalr;	// register-read.scala:80:33, :86:29
    rrd_uops_3_REG_is_jal <= _rrd_decode_unit_3_io_rrd_uop_is_jal;	// register-read.scala:80:33, :86:29
    rrd_uops_3_REG_is_sfb <= _rrd_decode_unit_3_io_rrd_uop_is_sfb;	// register-read.scala:80:33, :86:29
    rrd_uops_3_REG_br_mask <=
      _rrd_decode_unit_3_io_rrd_uop_br_mask & ~io_brupdate_b1_resolve_mask;	// register-read.scala:80:33, :86:29, util.scala:74:{35,37}
    rrd_uops_3_REG_br_tag <= _rrd_decode_unit_3_io_rrd_uop_br_tag;	// register-read.scala:80:33, :86:29
    rrd_uops_3_REG_ftq_idx <= _rrd_decode_unit_3_io_rrd_uop_ftq_idx;	// register-read.scala:80:33, :86:29
    rrd_uops_3_REG_edge_inst <= _rrd_decode_unit_3_io_rrd_uop_edge_inst;	// register-read.scala:80:33, :86:29
    rrd_uops_3_REG_pc_lob <= _rrd_decode_unit_3_io_rrd_uop_pc_lob;	// register-read.scala:80:33, :86:29
    rrd_uops_3_REG_taken <= _rrd_decode_unit_3_io_rrd_uop_taken;	// register-read.scala:80:33, :86:29
    rrd_uops_3_REG_imm_packed <= _rrd_decode_unit_3_io_rrd_uop_imm_packed;	// register-read.scala:80:33, :86:29
    rrd_uops_3_REG_rob_idx <= _rrd_decode_unit_3_io_rrd_uop_rob_idx;	// register-read.scala:80:33, :86:29
    rrd_uops_3_REG_ldq_idx <= _rrd_decode_unit_3_io_rrd_uop_ldq_idx;	// register-read.scala:80:33, :86:29
    rrd_uops_3_REG_stq_idx <= _rrd_decode_unit_3_io_rrd_uop_stq_idx;	// register-read.scala:80:33, :86:29
    rrd_uops_3_REG_pdst <= _rrd_decode_unit_3_io_rrd_uop_pdst;	// register-read.scala:80:33, :86:29
    rrd_uops_3_REG_prs1 <= _rrd_decode_unit_3_io_rrd_uop_prs1;	// register-read.scala:80:33, :86:29
    rrd_uops_3_REG_prs2 <= _rrd_decode_unit_3_io_rrd_uop_prs2;	// register-read.scala:80:33, :86:29
    rrd_uops_3_REG_bypassable <= _rrd_decode_unit_3_io_rrd_uop_bypassable;	// register-read.scala:80:33, :86:29
    rrd_uops_3_REG_is_amo <= _rrd_decode_unit_3_io_rrd_uop_is_amo;	// register-read.scala:80:33, :86:29
    rrd_uops_3_REG_uses_stq <= _rrd_decode_unit_3_io_rrd_uop_uses_stq;	// register-read.scala:80:33, :86:29
    rrd_uops_3_REG_dst_rtype <= _rrd_decode_unit_3_io_rrd_uop_dst_rtype;	// register-read.scala:80:33, :86:29
    rrd_uops_3_REG_lrs1_rtype <= _rrd_decode_unit_3_io_rrd_uop_lrs1_rtype;	// register-read.scala:80:33, :86:29
    rrd_uops_3_REG_lrs2_rtype <= _rrd_decode_unit_3_io_rrd_uop_lrs2_rtype;	// register-read.scala:80:33, :86:29
    rrd_rs1_data_0_REG <= io_iss_uops_0_prs1 == 7'h0;	// register-read.scala:124:{57,67}
    rrd_rs2_data_0_REG <= io_iss_uops_0_prs2 == 7'h0;	// register-read.scala:125:{57,67}
    rrd_rs1_data_1_REG <= io_iss_uops_1_prs1 == 7'h0;	// register-read.scala:124:{57,67}
    rrd_rs2_data_1_REG <= io_iss_uops_1_prs2 == 7'h0;	// register-read.scala:125:{57,67}
    rrd_rs1_data_2_REG <= io_iss_uops_2_prs1 == 7'h0;	// register-read.scala:124:{57,67}
    rrd_rs2_data_2_REG <= io_iss_uops_2_prs2 == 7'h0;	// register-read.scala:125:{57,67}
    rrd_rs1_data_3_REG <= io_iss_uops_3_prs1 == 7'h0;	// register-read.scala:124:{57,67}
    rrd_rs2_data_3_REG <= io_iss_uops_3_prs2 == 7'h0;	// register-read.scala:125:{57,67}
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:127];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [7:0] i = 8'h0; i < 8'h80; i += 8'h1) begin
          _RANDOM[i[6:0]] = `RANDOM;
        end
        exe_reg_valids_0 = _RANDOM[7'h0][0];	// register-read.scala:69:33
        exe_reg_valids_1 = _RANDOM[7'h0][1];	// register-read.scala:69:33
        exe_reg_valids_2 = _RANDOM[7'h0][2];	// register-read.scala:69:33
        exe_reg_valids_3 = _RANDOM[7'h0][3];	// register-read.scala:69:33
        exe_reg_uops_0_uopc = _RANDOM[7'h0][10:4];	// register-read.scala:69:33, :70:29
        exe_reg_uops_0_inst = {_RANDOM[7'h0][31:11], _RANDOM[7'h1][10:0]};	// register-read.scala:69:33, :70:29
        exe_reg_uops_0_debug_inst = {_RANDOM[7'h1][31:11], _RANDOM[7'h2][10:0]};	// register-read.scala:70:29
        exe_reg_uops_0_is_rvc = _RANDOM[7'h2][11];	// register-read.scala:70:29
        exe_reg_uops_0_debug_pc = {_RANDOM[7'h2][31:12], _RANDOM[7'h3][19:0]};	// register-read.scala:70:29
        exe_reg_uops_0_iq_type = _RANDOM[7'h3][22:20];	// register-read.scala:70:29
        exe_reg_uops_0_fu_code = {_RANDOM[7'h3][31:23], _RANDOM[7'h4][0]};	// register-read.scala:70:29
        exe_reg_uops_0_ctrl_br_type = _RANDOM[7'h4][4:1];	// register-read.scala:70:29
        exe_reg_uops_0_ctrl_op1_sel = _RANDOM[7'h4][6:5];	// register-read.scala:70:29
        exe_reg_uops_0_ctrl_op2_sel = _RANDOM[7'h4][9:7];	// register-read.scala:70:29
        exe_reg_uops_0_ctrl_imm_sel = _RANDOM[7'h4][12:10];	// register-read.scala:70:29
        exe_reg_uops_0_ctrl_op_fcn = _RANDOM[7'h4][16:13];	// register-read.scala:70:29
        exe_reg_uops_0_ctrl_fcn_dw = _RANDOM[7'h4][17];	// register-read.scala:70:29
        exe_reg_uops_0_ctrl_is_load = _RANDOM[7'h4][21];	// register-read.scala:70:29
        exe_reg_uops_0_ctrl_is_sta = _RANDOM[7'h4][22];	// register-read.scala:70:29
        exe_reg_uops_0_ctrl_is_std = _RANDOM[7'h4][23];	// register-read.scala:70:29
        exe_reg_uops_0_iw_state = _RANDOM[7'h4][25:24];	// register-read.scala:70:29
        exe_reg_uops_0_is_br = _RANDOM[7'h4][28];	// register-read.scala:70:29
        exe_reg_uops_0_is_jalr = _RANDOM[7'h4][29];	// register-read.scala:70:29
        exe_reg_uops_0_is_jal = _RANDOM[7'h4][30];	// register-read.scala:70:29
        exe_reg_uops_0_is_sfb = _RANDOM[7'h4][31];	// register-read.scala:70:29
        exe_reg_uops_0_br_mask = _RANDOM[7'h5][15:0];	// register-read.scala:70:29
        exe_reg_uops_0_br_tag = _RANDOM[7'h5][19:16];	// register-read.scala:70:29
        exe_reg_uops_0_ftq_idx = _RANDOM[7'h5][24:20];	// register-read.scala:70:29
        exe_reg_uops_0_edge_inst = _RANDOM[7'h5][25];	// register-read.scala:70:29
        exe_reg_uops_0_pc_lob = _RANDOM[7'h5][31:26];	// register-read.scala:70:29
        exe_reg_uops_0_taken = _RANDOM[7'h6][0];	// register-read.scala:70:29
        exe_reg_uops_0_imm_packed = _RANDOM[7'h6][20:1];	// register-read.scala:70:29
        exe_reg_uops_0_csr_addr = {_RANDOM[7'h6][31:21], _RANDOM[7'h7][0]};	// register-read.scala:70:29
        exe_reg_uops_0_rob_idx = _RANDOM[7'h7][7:1];	// register-read.scala:70:29
        exe_reg_uops_0_ldq_idx = _RANDOM[7'h7][12:8];	// register-read.scala:70:29
        exe_reg_uops_0_stq_idx = _RANDOM[7'h7][17:13];	// register-read.scala:70:29
        exe_reg_uops_0_rxq_idx = _RANDOM[7'h7][19:18];	// register-read.scala:70:29
        exe_reg_uops_0_pdst = _RANDOM[7'h7][26:20];	// register-read.scala:70:29
        exe_reg_uops_0_prs1 = {_RANDOM[7'h7][31:27], _RANDOM[7'h8][1:0]};	// register-read.scala:70:29
        exe_reg_uops_0_prs2 = _RANDOM[7'h8][8:2];	// register-read.scala:70:29
        exe_reg_uops_0_prs3 = _RANDOM[7'h8][15:9];	// register-read.scala:70:29
        exe_reg_uops_0_ppred = _RANDOM[7'h8][20:16];	// register-read.scala:70:29
        exe_reg_uops_0_prs1_busy = _RANDOM[7'h8][21];	// register-read.scala:70:29
        exe_reg_uops_0_prs2_busy = _RANDOM[7'h8][22];	// register-read.scala:70:29
        exe_reg_uops_0_prs3_busy = _RANDOM[7'h8][23];	// register-read.scala:70:29
        exe_reg_uops_0_ppred_busy = _RANDOM[7'h8][24];	// register-read.scala:70:29
        exe_reg_uops_0_stale_pdst = _RANDOM[7'h8][31:25];	// register-read.scala:70:29
        exe_reg_uops_0_exception = _RANDOM[7'h9][0];	// register-read.scala:70:29
        exe_reg_uops_0_exc_cause = {_RANDOM[7'h9][31:1], _RANDOM[7'hA], _RANDOM[7'hB][0]};	// register-read.scala:70:29
        exe_reg_uops_0_bypassable = _RANDOM[7'hB][1];	// register-read.scala:70:29
        exe_reg_uops_0_mem_cmd = _RANDOM[7'hB][6:2];	// register-read.scala:70:29
        exe_reg_uops_0_mem_size = _RANDOM[7'hB][8:7];	// register-read.scala:70:29
        exe_reg_uops_0_mem_signed = _RANDOM[7'hB][9];	// register-read.scala:70:29
        exe_reg_uops_0_is_fence = _RANDOM[7'hB][10];	// register-read.scala:70:29
        exe_reg_uops_0_is_fencei = _RANDOM[7'hB][11];	// register-read.scala:70:29
        exe_reg_uops_0_is_amo = _RANDOM[7'hB][12];	// register-read.scala:70:29
        exe_reg_uops_0_uses_ldq = _RANDOM[7'hB][13];	// register-read.scala:70:29
        exe_reg_uops_0_uses_stq = _RANDOM[7'hB][14];	// register-read.scala:70:29
        exe_reg_uops_0_is_sys_pc2epc = _RANDOM[7'hB][15];	// register-read.scala:70:29
        exe_reg_uops_0_is_unique = _RANDOM[7'hB][16];	// register-read.scala:70:29
        exe_reg_uops_0_flush_on_commit = _RANDOM[7'hB][17];	// register-read.scala:70:29
        exe_reg_uops_0_ldst_is_rs1 = _RANDOM[7'hB][18];	// register-read.scala:70:29
        exe_reg_uops_0_ldst = _RANDOM[7'hB][24:19];	// register-read.scala:70:29
        exe_reg_uops_0_lrs1 = _RANDOM[7'hB][30:25];	// register-read.scala:70:29
        exe_reg_uops_0_lrs2 = {_RANDOM[7'hB][31], _RANDOM[7'hC][4:0]};	// register-read.scala:70:29
        exe_reg_uops_0_lrs3 = _RANDOM[7'hC][10:5];	// register-read.scala:70:29
        exe_reg_uops_0_ldst_val = _RANDOM[7'hC][11];	// register-read.scala:70:29
        exe_reg_uops_0_dst_rtype = _RANDOM[7'hC][13:12];	// register-read.scala:70:29
        exe_reg_uops_0_lrs1_rtype = _RANDOM[7'hC][15:14];	// register-read.scala:70:29
        exe_reg_uops_0_lrs2_rtype = _RANDOM[7'hC][17:16];	// register-read.scala:70:29
        exe_reg_uops_0_frs3_en = _RANDOM[7'hC][18];	// register-read.scala:70:29
        exe_reg_uops_0_fp_val = _RANDOM[7'hC][19];	// register-read.scala:70:29
        exe_reg_uops_0_fp_single = _RANDOM[7'hC][20];	// register-read.scala:70:29
        exe_reg_uops_0_xcpt_pf_if = _RANDOM[7'hC][21];	// register-read.scala:70:29
        exe_reg_uops_0_xcpt_ae_if = _RANDOM[7'hC][22];	// register-read.scala:70:29
        exe_reg_uops_0_xcpt_ma_if = _RANDOM[7'hC][23];	// register-read.scala:70:29
        exe_reg_uops_0_bp_debug_if = _RANDOM[7'hC][24];	// register-read.scala:70:29
        exe_reg_uops_0_bp_xcpt_if = _RANDOM[7'hC][25];	// register-read.scala:70:29
        exe_reg_uops_0_debug_fsrc = _RANDOM[7'hC][27:26];	// register-read.scala:70:29
        exe_reg_uops_0_debug_tsrc = _RANDOM[7'hC][29:28];	// register-read.scala:70:29
        exe_reg_uops_1_uopc = {_RANDOM[7'hC][31:30], _RANDOM[7'hD][4:0]};	// register-read.scala:70:29
        exe_reg_uops_1_is_rvc = _RANDOM[7'hF][5];	// register-read.scala:70:29
        exe_reg_uops_1_fu_code = _RANDOM[7'h10][26:17];	// register-read.scala:70:29
        exe_reg_uops_1_ctrl_br_type = _RANDOM[7'h10][30:27];	// register-read.scala:70:29
        exe_reg_uops_1_ctrl_op1_sel = {_RANDOM[7'h10][31], _RANDOM[7'h11][0]};	// register-read.scala:70:29
        exe_reg_uops_1_ctrl_op2_sel = _RANDOM[7'h11][3:1];	// register-read.scala:70:29
        exe_reg_uops_1_ctrl_imm_sel = _RANDOM[7'h11][6:4];	// register-read.scala:70:29
        exe_reg_uops_1_ctrl_op_fcn = _RANDOM[7'h11][10:7];	// register-read.scala:70:29
        exe_reg_uops_1_ctrl_fcn_dw = _RANDOM[7'h11][11];	// register-read.scala:70:29
        exe_reg_uops_1_is_br = _RANDOM[7'h11][22];	// register-read.scala:70:29
        exe_reg_uops_1_is_jalr = _RANDOM[7'h11][23];	// register-read.scala:70:29
        exe_reg_uops_1_is_jal = _RANDOM[7'h11][24];	// register-read.scala:70:29
        exe_reg_uops_1_is_sfb = _RANDOM[7'h11][25];	// register-read.scala:70:29
        exe_reg_uops_1_br_mask = {_RANDOM[7'h11][31:26], _RANDOM[7'h12][9:0]};	// register-read.scala:70:29
        exe_reg_uops_1_br_tag = _RANDOM[7'h12][13:10];	// register-read.scala:70:29
        exe_reg_uops_1_ftq_idx = _RANDOM[7'h12][18:14];	// register-read.scala:70:29
        exe_reg_uops_1_edge_inst = _RANDOM[7'h12][19];	// register-read.scala:70:29
        exe_reg_uops_1_pc_lob = _RANDOM[7'h12][25:20];	// register-read.scala:70:29
        exe_reg_uops_1_taken = _RANDOM[7'h12][26];	// register-read.scala:70:29
        exe_reg_uops_1_imm_packed = {_RANDOM[7'h12][31:27], _RANDOM[7'h13][14:0]};	// register-read.scala:70:29
        exe_reg_uops_1_rob_idx = {_RANDOM[7'h13][31:27], _RANDOM[7'h14][1:0]};	// register-read.scala:70:29
        exe_reg_uops_1_ldq_idx = _RANDOM[7'h14][6:2];	// register-read.scala:70:29
        exe_reg_uops_1_stq_idx = _RANDOM[7'h14][11:7];	// register-read.scala:70:29
        exe_reg_uops_1_pdst = _RANDOM[7'h14][20:14];	// register-read.scala:70:29
        exe_reg_uops_1_prs1 = _RANDOM[7'h14][27:21];	// register-read.scala:70:29
        exe_reg_uops_1_bypassable = _RANDOM[7'h17][27];	// register-read.scala:70:29
        exe_reg_uops_1_is_amo = _RANDOM[7'h18][6];	// register-read.scala:70:29
        exe_reg_uops_1_uses_stq = _RANDOM[7'h18][8];	// register-read.scala:70:29
        exe_reg_uops_1_dst_rtype = _RANDOM[7'h19][7:6];	// register-read.scala:70:29
        exe_reg_uops_2_uopc = _RANDOM[7'h19][30:24];	// register-read.scala:70:29
        exe_reg_uops_2_inst = {_RANDOM[7'h19][31], _RANDOM[7'h1A][30:0]};	// register-read.scala:70:29
        exe_reg_uops_2_debug_inst = {_RANDOM[7'h1A][31], _RANDOM[7'h1B][30:0]};	// register-read.scala:70:29
        exe_reg_uops_2_is_rvc = _RANDOM[7'h1B][31];	// register-read.scala:70:29
        exe_reg_uops_2_debug_pc = {_RANDOM[7'h1C], _RANDOM[7'h1D][7:0]};	// register-read.scala:70:29
        exe_reg_uops_2_iq_type = _RANDOM[7'h1D][10:8];	// register-read.scala:70:29
        exe_reg_uops_2_fu_code = _RANDOM[7'h1D][20:11];	// register-read.scala:70:29
        exe_reg_uops_2_ctrl_br_type = _RANDOM[7'h1D][24:21];	// register-read.scala:70:29
        exe_reg_uops_2_ctrl_op1_sel = _RANDOM[7'h1D][26:25];	// register-read.scala:70:29
        exe_reg_uops_2_ctrl_op2_sel = _RANDOM[7'h1D][29:27];	// register-read.scala:70:29
        exe_reg_uops_2_ctrl_imm_sel = {_RANDOM[7'h1D][31:30], _RANDOM[7'h1E][0]};	// register-read.scala:70:29
        exe_reg_uops_2_ctrl_op_fcn = _RANDOM[7'h1E][4:1];	// register-read.scala:70:29
        exe_reg_uops_2_ctrl_fcn_dw = _RANDOM[7'h1E][5];	// register-read.scala:70:29
        exe_reg_uops_2_ctrl_csr_cmd = _RANDOM[7'h1E][8:6];	// register-read.scala:70:29
        exe_reg_uops_2_ctrl_is_load = _RANDOM[7'h1E][9];	// register-read.scala:70:29
        exe_reg_uops_2_ctrl_is_sta = _RANDOM[7'h1E][10];	// register-read.scala:70:29
        exe_reg_uops_2_ctrl_is_std = _RANDOM[7'h1E][11];	// register-read.scala:70:29
        exe_reg_uops_2_iw_state = _RANDOM[7'h1E][13:12];	// register-read.scala:70:29
        exe_reg_uops_2_is_br = _RANDOM[7'h1E][16];	// register-read.scala:70:29
        exe_reg_uops_2_is_jalr = _RANDOM[7'h1E][17];	// register-read.scala:70:29
        exe_reg_uops_2_is_jal = _RANDOM[7'h1E][18];	// register-read.scala:70:29
        exe_reg_uops_2_is_sfb = _RANDOM[7'h1E][19];	// register-read.scala:70:29
        exe_reg_uops_2_br_mask = {_RANDOM[7'h1E][31:20], _RANDOM[7'h1F][3:0]};	// register-read.scala:70:29
        exe_reg_uops_2_br_tag = _RANDOM[7'h1F][7:4];	// register-read.scala:70:29
        exe_reg_uops_2_ftq_idx = _RANDOM[7'h1F][12:8];	// register-read.scala:70:29
        exe_reg_uops_2_edge_inst = _RANDOM[7'h1F][13];	// register-read.scala:70:29
        exe_reg_uops_2_pc_lob = _RANDOM[7'h1F][19:14];	// register-read.scala:70:29
        exe_reg_uops_2_taken = _RANDOM[7'h1F][20];	// register-read.scala:70:29
        exe_reg_uops_2_imm_packed = {_RANDOM[7'h1F][31:21], _RANDOM[7'h20][8:0]};	// register-read.scala:70:29
        exe_reg_uops_2_csr_addr = _RANDOM[7'h20][20:9];	// register-read.scala:70:29
        exe_reg_uops_2_rob_idx = _RANDOM[7'h20][27:21];	// register-read.scala:70:29
        exe_reg_uops_2_ldq_idx = {_RANDOM[7'h20][31:28], _RANDOM[7'h21][0]};	// register-read.scala:70:29
        exe_reg_uops_2_stq_idx = _RANDOM[7'h21][5:1];	// register-read.scala:70:29
        exe_reg_uops_2_rxq_idx = _RANDOM[7'h21][7:6];	// register-read.scala:70:29
        exe_reg_uops_2_pdst = _RANDOM[7'h21][14:8];	// register-read.scala:70:29
        exe_reg_uops_2_prs1 = _RANDOM[7'h21][21:15];	// register-read.scala:70:29
        exe_reg_uops_2_prs2 = _RANDOM[7'h21][28:22];	// register-read.scala:70:29
        exe_reg_uops_2_prs3 = {_RANDOM[7'h21][31:29], _RANDOM[7'h22][3:0]};	// register-read.scala:70:29
        exe_reg_uops_2_ppred = _RANDOM[7'h22][8:4];	// register-read.scala:70:29
        exe_reg_uops_2_prs1_busy = _RANDOM[7'h22][9];	// register-read.scala:70:29
        exe_reg_uops_2_prs2_busy = _RANDOM[7'h22][10];	// register-read.scala:70:29
        exe_reg_uops_2_prs3_busy = _RANDOM[7'h22][11];	// register-read.scala:70:29
        exe_reg_uops_2_ppred_busy = _RANDOM[7'h22][12];	// register-read.scala:70:29
        exe_reg_uops_2_stale_pdst = _RANDOM[7'h22][19:13];	// register-read.scala:70:29
        exe_reg_uops_2_exception = _RANDOM[7'h22][20];	// register-read.scala:70:29
        exe_reg_uops_2_exc_cause =
          {_RANDOM[7'h22][31:21], _RANDOM[7'h23], _RANDOM[7'h24][20:0]};	// register-read.scala:70:29
        exe_reg_uops_2_bypassable = _RANDOM[7'h24][21];	// register-read.scala:70:29
        exe_reg_uops_2_mem_cmd = _RANDOM[7'h24][26:22];	// register-read.scala:70:29
        exe_reg_uops_2_mem_size = _RANDOM[7'h24][28:27];	// register-read.scala:70:29
        exe_reg_uops_2_mem_signed = _RANDOM[7'h24][29];	// register-read.scala:70:29
        exe_reg_uops_2_is_fence = _RANDOM[7'h24][30];	// register-read.scala:70:29
        exe_reg_uops_2_is_fencei = _RANDOM[7'h24][31];	// register-read.scala:70:29
        exe_reg_uops_2_is_amo = _RANDOM[7'h25][0];	// register-read.scala:70:29
        exe_reg_uops_2_uses_ldq = _RANDOM[7'h25][1];	// register-read.scala:70:29
        exe_reg_uops_2_uses_stq = _RANDOM[7'h25][2];	// register-read.scala:70:29
        exe_reg_uops_2_is_sys_pc2epc = _RANDOM[7'h25][3];	// register-read.scala:70:29
        exe_reg_uops_2_is_unique = _RANDOM[7'h25][4];	// register-read.scala:70:29
        exe_reg_uops_2_flush_on_commit = _RANDOM[7'h25][5];	// register-read.scala:70:29
        exe_reg_uops_2_ldst_is_rs1 = _RANDOM[7'h25][6];	// register-read.scala:70:29
        exe_reg_uops_2_ldst = _RANDOM[7'h25][12:7];	// register-read.scala:70:29
        exe_reg_uops_2_lrs1 = _RANDOM[7'h25][18:13];	// register-read.scala:70:29
        exe_reg_uops_2_lrs2 = _RANDOM[7'h25][24:19];	// register-read.scala:70:29
        exe_reg_uops_2_lrs3 = _RANDOM[7'h25][30:25];	// register-read.scala:70:29
        exe_reg_uops_2_ldst_val = _RANDOM[7'h25][31];	// register-read.scala:70:29
        exe_reg_uops_2_dst_rtype = _RANDOM[7'h26][1:0];	// register-read.scala:70:29
        exe_reg_uops_2_lrs1_rtype = _RANDOM[7'h26][3:2];	// register-read.scala:70:29
        exe_reg_uops_2_lrs2_rtype = _RANDOM[7'h26][5:4];	// register-read.scala:70:29
        exe_reg_uops_2_frs3_en = _RANDOM[7'h26][6];	// register-read.scala:70:29
        exe_reg_uops_2_fp_val = _RANDOM[7'h26][7];	// register-read.scala:70:29
        exe_reg_uops_2_fp_single = _RANDOM[7'h26][8];	// register-read.scala:70:29
        exe_reg_uops_2_xcpt_pf_if = _RANDOM[7'h26][9];	// register-read.scala:70:29
        exe_reg_uops_2_xcpt_ae_if = _RANDOM[7'h26][10];	// register-read.scala:70:29
        exe_reg_uops_2_xcpt_ma_if = _RANDOM[7'h26][11];	// register-read.scala:70:29
        exe_reg_uops_2_bp_debug_if = _RANDOM[7'h26][12];	// register-read.scala:70:29
        exe_reg_uops_2_bp_xcpt_if = _RANDOM[7'h26][13];	// register-read.scala:70:29
        exe_reg_uops_2_debug_fsrc = _RANDOM[7'h26][15:14];	// register-read.scala:70:29
        exe_reg_uops_2_debug_tsrc = _RANDOM[7'h26][17:16];	// register-read.scala:70:29
        exe_reg_uops_3_uopc = _RANDOM[7'h26][24:18];	// register-read.scala:70:29
        exe_reg_uops_3_is_rvc = _RANDOM[7'h28][25];	// register-read.scala:70:29
        exe_reg_uops_3_fu_code = _RANDOM[7'h2A][14:5];	// register-read.scala:70:29
        exe_reg_uops_3_ctrl_br_type = _RANDOM[7'h2A][18:15];	// register-read.scala:70:29
        exe_reg_uops_3_ctrl_op1_sel = _RANDOM[7'h2A][20:19];	// register-read.scala:70:29
        exe_reg_uops_3_ctrl_op2_sel = _RANDOM[7'h2A][23:21];	// register-read.scala:70:29
        exe_reg_uops_3_ctrl_imm_sel = _RANDOM[7'h2A][26:24];	// register-read.scala:70:29
        exe_reg_uops_3_ctrl_op_fcn = _RANDOM[7'h2A][30:27];	// register-read.scala:70:29
        exe_reg_uops_3_ctrl_fcn_dw = _RANDOM[7'h2A][31];	// register-read.scala:70:29
        exe_reg_uops_3_is_br = _RANDOM[7'h2B][10];	// register-read.scala:70:29
        exe_reg_uops_3_is_jalr = _RANDOM[7'h2B][11];	// register-read.scala:70:29
        exe_reg_uops_3_is_jal = _RANDOM[7'h2B][12];	// register-read.scala:70:29
        exe_reg_uops_3_is_sfb = _RANDOM[7'h2B][13];	// register-read.scala:70:29
        exe_reg_uops_3_br_mask = _RANDOM[7'h2B][29:14];	// register-read.scala:70:29
        exe_reg_uops_3_br_tag = {_RANDOM[7'h2B][31:30], _RANDOM[7'h2C][1:0]};	// register-read.scala:70:29
        exe_reg_uops_3_ftq_idx = _RANDOM[7'h2C][6:2];	// register-read.scala:70:29
        exe_reg_uops_3_edge_inst = _RANDOM[7'h2C][7];	// register-read.scala:70:29
        exe_reg_uops_3_pc_lob = _RANDOM[7'h2C][13:8];	// register-read.scala:70:29
        exe_reg_uops_3_taken = _RANDOM[7'h2C][14];	// register-read.scala:70:29
        exe_reg_uops_3_imm_packed = {_RANDOM[7'h2C][31:15], _RANDOM[7'h2D][2:0]};	// register-read.scala:70:29
        exe_reg_uops_3_rob_idx = _RANDOM[7'h2D][21:15];	// register-read.scala:70:29
        exe_reg_uops_3_ldq_idx = _RANDOM[7'h2D][26:22];	// register-read.scala:70:29
        exe_reg_uops_3_stq_idx = _RANDOM[7'h2D][31:27];	// register-read.scala:70:29
        exe_reg_uops_3_pdst = _RANDOM[7'h2E][8:2];	// register-read.scala:70:29
        exe_reg_uops_3_prs1 = _RANDOM[7'h2E][15:9];	// register-read.scala:70:29
        exe_reg_uops_3_bypassable = _RANDOM[7'h31][15];	// register-read.scala:70:29
        exe_reg_uops_3_is_amo = _RANDOM[7'h31][26];	// register-read.scala:70:29
        exe_reg_uops_3_uses_stq = _RANDOM[7'h31][28];	// register-read.scala:70:29
        exe_reg_uops_3_dst_rtype = _RANDOM[7'h32][27:26];	// register-read.scala:70:29
        exe_reg_rs1_data_0 =
          {_RANDOM[7'h33][31:12], _RANDOM[7'h34], _RANDOM[7'h35][11:0]};	// register-read.scala:71:29
        exe_reg_rs1_data_1 =
          {_RANDOM[7'h35][31:12], _RANDOM[7'h36], _RANDOM[7'h37][11:0]};	// register-read.scala:71:29
        exe_reg_rs1_data_2 =
          {_RANDOM[7'h37][31:12], _RANDOM[7'h38], _RANDOM[7'h39][11:0]};	// register-read.scala:71:29
        exe_reg_rs1_data_3 =
          {_RANDOM[7'h39][31:12], _RANDOM[7'h3A], _RANDOM[7'h3B][11:0]};	// register-read.scala:71:29
        exe_reg_rs2_data_0 =
          {_RANDOM[7'h3B][31:12], _RANDOM[7'h3C], _RANDOM[7'h3D][11:0]};	// register-read.scala:71:29, :72:29
        exe_reg_rs2_data_1 =
          {_RANDOM[7'h3D][31:12], _RANDOM[7'h3E], _RANDOM[7'h3F][11:0]};	// register-read.scala:72:29
        exe_reg_rs2_data_2 =
          {_RANDOM[7'h3F][31:12], _RANDOM[7'h40], _RANDOM[7'h41][11:0]};	// register-read.scala:72:29
        exe_reg_rs2_data_3 =
          {_RANDOM[7'h41][31:12], _RANDOM[7'h42], _RANDOM[7'h43][11:0]};	// register-read.scala:72:29
        rrd_valids_0_REG = _RANDOM[7'h4B][16];	// register-read.scala:84:29
        rrd_uops_0_REG_uopc = _RANDOM[7'h4B][23:17];	// register-read.scala:84:29, :86:29
        rrd_uops_0_REG_inst = {_RANDOM[7'h4B][31:24], _RANDOM[7'h4C][23:0]};	// register-read.scala:84:29, :86:29
        rrd_uops_0_REG_debug_inst = {_RANDOM[7'h4C][31:24], _RANDOM[7'h4D][23:0]};	// register-read.scala:86:29
        rrd_uops_0_REG_is_rvc = _RANDOM[7'h4D][24];	// register-read.scala:86:29
        rrd_uops_0_REG_debug_pc =
          {_RANDOM[7'h4D][31:25], _RANDOM[7'h4E], _RANDOM[7'h4F][0]};	// register-read.scala:86:29
        rrd_uops_0_REG_iq_type = _RANDOM[7'h4F][3:1];	// register-read.scala:86:29
        rrd_uops_0_REG_fu_code = _RANDOM[7'h4F][13:4];	// register-read.scala:86:29
        rrd_uops_0_REG_ctrl_br_type = _RANDOM[7'h4F][17:14];	// register-read.scala:86:29
        rrd_uops_0_REG_ctrl_op1_sel = _RANDOM[7'h4F][19:18];	// register-read.scala:86:29
        rrd_uops_0_REG_ctrl_op2_sel = _RANDOM[7'h4F][22:20];	// register-read.scala:86:29
        rrd_uops_0_REG_ctrl_imm_sel = _RANDOM[7'h4F][25:23];	// register-read.scala:86:29
        rrd_uops_0_REG_ctrl_op_fcn = _RANDOM[7'h4F][29:26];	// register-read.scala:86:29
        rrd_uops_0_REG_ctrl_fcn_dw = _RANDOM[7'h4F][30];	// register-read.scala:86:29
        rrd_uops_0_REG_ctrl_is_load = _RANDOM[7'h50][2];	// register-read.scala:86:29
        rrd_uops_0_REG_ctrl_is_sta = _RANDOM[7'h50][3];	// register-read.scala:86:29
        rrd_uops_0_REG_ctrl_is_std = _RANDOM[7'h50][4];	// register-read.scala:86:29
        rrd_uops_0_REG_iw_state = _RANDOM[7'h50][6:5];	// register-read.scala:86:29
        rrd_uops_0_REG_is_br = _RANDOM[7'h50][9];	// register-read.scala:86:29
        rrd_uops_0_REG_is_jalr = _RANDOM[7'h50][10];	// register-read.scala:86:29
        rrd_uops_0_REG_is_jal = _RANDOM[7'h50][11];	// register-read.scala:86:29
        rrd_uops_0_REG_is_sfb = _RANDOM[7'h50][12];	// register-read.scala:86:29
        rrd_uops_0_REG_br_mask = _RANDOM[7'h50][28:13];	// register-read.scala:86:29
        rrd_uops_0_REG_br_tag = {_RANDOM[7'h50][31:29], _RANDOM[7'h51][0]};	// register-read.scala:86:29
        rrd_uops_0_REG_ftq_idx = _RANDOM[7'h51][5:1];	// register-read.scala:86:29
        rrd_uops_0_REG_edge_inst = _RANDOM[7'h51][6];	// register-read.scala:86:29
        rrd_uops_0_REG_pc_lob = _RANDOM[7'h51][12:7];	// register-read.scala:86:29
        rrd_uops_0_REG_taken = _RANDOM[7'h51][13];	// register-read.scala:86:29
        rrd_uops_0_REG_imm_packed = {_RANDOM[7'h51][31:14], _RANDOM[7'h52][1:0]};	// register-read.scala:86:29
        rrd_uops_0_REG_csr_addr = _RANDOM[7'h52][13:2];	// register-read.scala:86:29
        rrd_uops_0_REG_rob_idx = _RANDOM[7'h52][20:14];	// register-read.scala:86:29
        rrd_uops_0_REG_ldq_idx = _RANDOM[7'h52][25:21];	// register-read.scala:86:29
        rrd_uops_0_REG_stq_idx = _RANDOM[7'h52][30:26];	// register-read.scala:86:29
        rrd_uops_0_REG_rxq_idx = {_RANDOM[7'h52][31], _RANDOM[7'h53][0]};	// register-read.scala:86:29
        rrd_uops_0_REG_pdst = _RANDOM[7'h53][7:1];	// register-read.scala:86:29
        rrd_uops_0_REG_prs1 = _RANDOM[7'h53][14:8];	// register-read.scala:86:29
        rrd_uops_0_REG_prs2 = _RANDOM[7'h53][21:15];	// register-read.scala:86:29
        rrd_uops_0_REG_prs3 = _RANDOM[7'h53][28:22];	// register-read.scala:86:29
        rrd_uops_0_REG_ppred = {_RANDOM[7'h53][31:29], _RANDOM[7'h54][1:0]};	// register-read.scala:86:29
        rrd_uops_0_REG_prs1_busy = _RANDOM[7'h54][2];	// register-read.scala:86:29
        rrd_uops_0_REG_prs2_busy = _RANDOM[7'h54][3];	// register-read.scala:86:29
        rrd_uops_0_REG_prs3_busy = _RANDOM[7'h54][4];	// register-read.scala:86:29
        rrd_uops_0_REG_ppred_busy = _RANDOM[7'h54][5];	// register-read.scala:86:29
        rrd_uops_0_REG_stale_pdst = _RANDOM[7'h54][12:6];	// register-read.scala:86:29
        rrd_uops_0_REG_exception = _RANDOM[7'h54][13];	// register-read.scala:86:29
        rrd_uops_0_REG_exc_cause =
          {_RANDOM[7'h54][31:14], _RANDOM[7'h55], _RANDOM[7'h56][13:0]};	// register-read.scala:86:29
        rrd_uops_0_REG_bypassable = _RANDOM[7'h56][14];	// register-read.scala:86:29
        rrd_uops_0_REG_mem_cmd = _RANDOM[7'h56][19:15];	// register-read.scala:86:29
        rrd_uops_0_REG_mem_size = _RANDOM[7'h56][21:20];	// register-read.scala:86:29
        rrd_uops_0_REG_mem_signed = _RANDOM[7'h56][22];	// register-read.scala:86:29
        rrd_uops_0_REG_is_fence = _RANDOM[7'h56][23];	// register-read.scala:86:29
        rrd_uops_0_REG_is_fencei = _RANDOM[7'h56][24];	// register-read.scala:86:29
        rrd_uops_0_REG_is_amo = _RANDOM[7'h56][25];	// register-read.scala:86:29
        rrd_uops_0_REG_uses_ldq = _RANDOM[7'h56][26];	// register-read.scala:86:29
        rrd_uops_0_REG_uses_stq = _RANDOM[7'h56][27];	// register-read.scala:86:29
        rrd_uops_0_REG_is_sys_pc2epc = _RANDOM[7'h56][28];	// register-read.scala:86:29
        rrd_uops_0_REG_is_unique = _RANDOM[7'h56][29];	// register-read.scala:86:29
        rrd_uops_0_REG_flush_on_commit = _RANDOM[7'h56][30];	// register-read.scala:86:29
        rrd_uops_0_REG_ldst_is_rs1 = _RANDOM[7'h56][31];	// register-read.scala:86:29
        rrd_uops_0_REG_ldst = _RANDOM[7'h57][5:0];	// register-read.scala:86:29
        rrd_uops_0_REG_lrs1 = _RANDOM[7'h57][11:6];	// register-read.scala:86:29
        rrd_uops_0_REG_lrs2 = _RANDOM[7'h57][17:12];	// register-read.scala:86:29
        rrd_uops_0_REG_lrs3 = _RANDOM[7'h57][23:18];	// register-read.scala:86:29
        rrd_uops_0_REG_ldst_val = _RANDOM[7'h57][24];	// register-read.scala:86:29
        rrd_uops_0_REG_dst_rtype = _RANDOM[7'h57][26:25];	// register-read.scala:86:29
        rrd_uops_0_REG_lrs1_rtype = _RANDOM[7'h57][28:27];	// register-read.scala:86:29
        rrd_uops_0_REG_lrs2_rtype = _RANDOM[7'h57][30:29];	// register-read.scala:86:29
        rrd_uops_0_REG_frs3_en = _RANDOM[7'h57][31];	// register-read.scala:86:29
        rrd_uops_0_REG_fp_val = _RANDOM[7'h58][0];	// register-read.scala:86:29
        rrd_uops_0_REG_fp_single = _RANDOM[7'h58][1];	// register-read.scala:86:29
        rrd_uops_0_REG_xcpt_pf_if = _RANDOM[7'h58][2];	// register-read.scala:86:29
        rrd_uops_0_REG_xcpt_ae_if = _RANDOM[7'h58][3];	// register-read.scala:86:29
        rrd_uops_0_REG_xcpt_ma_if = _RANDOM[7'h58][4];	// register-read.scala:86:29
        rrd_uops_0_REG_bp_debug_if = _RANDOM[7'h58][5];	// register-read.scala:86:29
        rrd_uops_0_REG_bp_xcpt_if = _RANDOM[7'h58][6];	// register-read.scala:86:29
        rrd_uops_0_REG_debug_fsrc = _RANDOM[7'h58][8:7];	// register-read.scala:86:29
        rrd_uops_0_REG_debug_tsrc = _RANDOM[7'h58][10:9];	// register-read.scala:86:29
        rrd_valids_1_REG = _RANDOM[7'h58][11];	// register-read.scala:84:29, :86:29
        rrd_uops_1_REG_uopc = _RANDOM[7'h58][18:12];	// register-read.scala:86:29
        rrd_uops_1_REG_is_rvc = _RANDOM[7'h5A][19];	// register-read.scala:86:29
        rrd_uops_1_REG_fu_code = {_RANDOM[7'h5B][31], _RANDOM[7'h5C][8:0]};	// register-read.scala:86:29
        rrd_uops_1_REG_ctrl_br_type = _RANDOM[7'h5C][12:9];	// register-read.scala:86:29
        rrd_uops_1_REG_ctrl_op1_sel = _RANDOM[7'h5C][14:13];	// register-read.scala:86:29
        rrd_uops_1_REG_ctrl_op2_sel = _RANDOM[7'h5C][17:15];	// register-read.scala:86:29
        rrd_uops_1_REG_ctrl_imm_sel = _RANDOM[7'h5C][20:18];	// register-read.scala:86:29
        rrd_uops_1_REG_ctrl_op_fcn = _RANDOM[7'h5C][24:21];	// register-read.scala:86:29
        rrd_uops_1_REG_ctrl_fcn_dw = _RANDOM[7'h5C][25];	// register-read.scala:86:29
        rrd_uops_1_REG_is_br = _RANDOM[7'h5D][4];	// register-read.scala:86:29
        rrd_uops_1_REG_is_jalr = _RANDOM[7'h5D][5];	// register-read.scala:86:29
        rrd_uops_1_REG_is_jal = _RANDOM[7'h5D][6];	// register-read.scala:86:29
        rrd_uops_1_REG_is_sfb = _RANDOM[7'h5D][7];	// register-read.scala:86:29
        rrd_uops_1_REG_br_mask = _RANDOM[7'h5D][23:8];	// register-read.scala:86:29
        rrd_uops_1_REG_br_tag = _RANDOM[7'h5D][27:24];	// register-read.scala:86:29
        rrd_uops_1_REG_ftq_idx = {_RANDOM[7'h5D][31:28], _RANDOM[7'h5E][0]};	// register-read.scala:86:29
        rrd_uops_1_REG_edge_inst = _RANDOM[7'h5E][1];	// register-read.scala:86:29
        rrd_uops_1_REG_pc_lob = _RANDOM[7'h5E][7:2];	// register-read.scala:86:29
        rrd_uops_1_REG_taken = _RANDOM[7'h5E][8];	// register-read.scala:86:29
        rrd_uops_1_REG_imm_packed = _RANDOM[7'h5E][28:9];	// register-read.scala:86:29
        rrd_uops_1_REG_rob_idx = _RANDOM[7'h5F][15:9];	// register-read.scala:86:29
        rrd_uops_1_REG_ldq_idx = _RANDOM[7'h5F][20:16];	// register-read.scala:86:29
        rrd_uops_1_REG_stq_idx = _RANDOM[7'h5F][25:21];	// register-read.scala:86:29
        rrd_uops_1_REG_pdst = {_RANDOM[7'h5F][31:28], _RANDOM[7'h60][2:0]};	// register-read.scala:86:29
        rrd_uops_1_REG_prs1 = _RANDOM[7'h60][9:3];	// register-read.scala:86:29
        rrd_uops_1_REG_prs2 = _RANDOM[7'h60][16:10];	// register-read.scala:86:29
        rrd_uops_1_REG_bypassable = _RANDOM[7'h63][9];	// register-read.scala:86:29
        rrd_uops_1_REG_is_amo = _RANDOM[7'h63][20];	// register-read.scala:86:29
        rrd_uops_1_REG_uses_stq = _RANDOM[7'h63][22];	// register-read.scala:86:29
        rrd_uops_1_REG_dst_rtype = _RANDOM[7'h64][21:20];	// register-read.scala:86:29
        rrd_uops_1_REG_lrs1_rtype = _RANDOM[7'h64][23:22];	// register-read.scala:86:29
        rrd_uops_1_REG_lrs2_rtype = _RANDOM[7'h64][25:24];	// register-read.scala:86:29
        rrd_valids_2_REG = _RANDOM[7'h65][6];	// register-read.scala:84:29
        rrd_uops_2_REG_uopc = _RANDOM[7'h65][13:7];	// register-read.scala:84:29, :86:29
        rrd_uops_2_REG_inst = {_RANDOM[7'h65][31:14], _RANDOM[7'h66][13:0]};	// register-read.scala:84:29, :86:29
        rrd_uops_2_REG_debug_inst = {_RANDOM[7'h66][31:14], _RANDOM[7'h67][13:0]};	// register-read.scala:86:29
        rrd_uops_2_REG_is_rvc = _RANDOM[7'h67][14];	// register-read.scala:86:29
        rrd_uops_2_REG_debug_pc = {_RANDOM[7'h67][31:15], _RANDOM[7'h68][22:0]};	// register-read.scala:86:29
        rrd_uops_2_REG_iq_type = _RANDOM[7'h68][25:23];	// register-read.scala:86:29
        rrd_uops_2_REG_fu_code = {_RANDOM[7'h68][31:26], _RANDOM[7'h69][3:0]};	// register-read.scala:86:29
        rrd_uops_2_REG_ctrl_br_type = _RANDOM[7'h69][7:4];	// register-read.scala:86:29
        rrd_uops_2_REG_ctrl_op1_sel = _RANDOM[7'h69][9:8];	// register-read.scala:86:29
        rrd_uops_2_REG_ctrl_op2_sel = _RANDOM[7'h69][12:10];	// register-read.scala:86:29
        rrd_uops_2_REG_ctrl_imm_sel = _RANDOM[7'h69][15:13];	// register-read.scala:86:29
        rrd_uops_2_REG_ctrl_op_fcn = _RANDOM[7'h69][19:16];	// register-read.scala:86:29
        rrd_uops_2_REG_ctrl_fcn_dw = _RANDOM[7'h69][20];	// register-read.scala:86:29
        rrd_uops_2_REG_ctrl_csr_cmd = _RANDOM[7'h69][23:21];	// register-read.scala:86:29
        rrd_uops_2_REG_ctrl_is_load = _RANDOM[7'h69][24];	// register-read.scala:86:29
        rrd_uops_2_REG_ctrl_is_sta = _RANDOM[7'h69][25];	// register-read.scala:86:29
        rrd_uops_2_REG_ctrl_is_std = _RANDOM[7'h69][26];	// register-read.scala:86:29
        rrd_uops_2_REG_iw_state = _RANDOM[7'h69][28:27];	// register-read.scala:86:29
        rrd_uops_2_REG_is_br = _RANDOM[7'h69][31];	// register-read.scala:86:29
        rrd_uops_2_REG_is_jalr = _RANDOM[7'h6A][0];	// register-read.scala:86:29
        rrd_uops_2_REG_is_jal = _RANDOM[7'h6A][1];	// register-read.scala:86:29
        rrd_uops_2_REG_is_sfb = _RANDOM[7'h6A][2];	// register-read.scala:86:29
        rrd_uops_2_REG_br_mask = _RANDOM[7'h6A][18:3];	// register-read.scala:86:29
        rrd_uops_2_REG_br_tag = _RANDOM[7'h6A][22:19];	// register-read.scala:86:29
        rrd_uops_2_REG_ftq_idx = _RANDOM[7'h6A][27:23];	// register-read.scala:86:29
        rrd_uops_2_REG_edge_inst = _RANDOM[7'h6A][28];	// register-read.scala:86:29
        rrd_uops_2_REG_pc_lob = {_RANDOM[7'h6A][31:29], _RANDOM[7'h6B][2:0]};	// register-read.scala:86:29
        rrd_uops_2_REG_taken = _RANDOM[7'h6B][3];	// register-read.scala:86:29
        rrd_uops_2_REG_imm_packed = _RANDOM[7'h6B][23:4];	// register-read.scala:86:29
        rrd_uops_2_REG_csr_addr = {_RANDOM[7'h6B][31:24], _RANDOM[7'h6C][3:0]};	// register-read.scala:86:29
        rrd_uops_2_REG_rob_idx = _RANDOM[7'h6C][10:4];	// register-read.scala:86:29
        rrd_uops_2_REG_ldq_idx = _RANDOM[7'h6C][15:11];	// register-read.scala:86:29
        rrd_uops_2_REG_stq_idx = _RANDOM[7'h6C][20:16];	// register-read.scala:86:29
        rrd_uops_2_REG_rxq_idx = _RANDOM[7'h6C][22:21];	// register-read.scala:86:29
        rrd_uops_2_REG_pdst = _RANDOM[7'h6C][29:23];	// register-read.scala:86:29
        rrd_uops_2_REG_prs1 = {_RANDOM[7'h6C][31:30], _RANDOM[7'h6D][4:0]};	// register-read.scala:86:29
        rrd_uops_2_REG_prs2 = _RANDOM[7'h6D][11:5];	// register-read.scala:86:29
        rrd_uops_2_REG_prs3 = _RANDOM[7'h6D][18:12];	// register-read.scala:86:29
        rrd_uops_2_REG_ppred = _RANDOM[7'h6D][23:19];	// register-read.scala:86:29
        rrd_uops_2_REG_prs1_busy = _RANDOM[7'h6D][24];	// register-read.scala:86:29
        rrd_uops_2_REG_prs2_busy = _RANDOM[7'h6D][25];	// register-read.scala:86:29
        rrd_uops_2_REG_prs3_busy = _RANDOM[7'h6D][26];	// register-read.scala:86:29
        rrd_uops_2_REG_ppred_busy = _RANDOM[7'h6D][27];	// register-read.scala:86:29
        rrd_uops_2_REG_stale_pdst = {_RANDOM[7'h6D][31:28], _RANDOM[7'h6E][2:0]};	// register-read.scala:86:29
        rrd_uops_2_REG_exception = _RANDOM[7'h6E][3];	// register-read.scala:86:29
        rrd_uops_2_REG_exc_cause =
          {_RANDOM[7'h6E][31:4], _RANDOM[7'h6F], _RANDOM[7'h70][3:0]};	// register-read.scala:86:29
        rrd_uops_2_REG_bypassable = _RANDOM[7'h70][4];	// register-read.scala:86:29
        rrd_uops_2_REG_mem_cmd = _RANDOM[7'h70][9:5];	// register-read.scala:86:29
        rrd_uops_2_REG_mem_size = _RANDOM[7'h70][11:10];	// register-read.scala:86:29
        rrd_uops_2_REG_mem_signed = _RANDOM[7'h70][12];	// register-read.scala:86:29
        rrd_uops_2_REG_is_fence = _RANDOM[7'h70][13];	// register-read.scala:86:29
        rrd_uops_2_REG_is_fencei = _RANDOM[7'h70][14];	// register-read.scala:86:29
        rrd_uops_2_REG_is_amo = _RANDOM[7'h70][15];	// register-read.scala:86:29
        rrd_uops_2_REG_uses_ldq = _RANDOM[7'h70][16];	// register-read.scala:86:29
        rrd_uops_2_REG_uses_stq = _RANDOM[7'h70][17];	// register-read.scala:86:29
        rrd_uops_2_REG_is_sys_pc2epc = _RANDOM[7'h70][18];	// register-read.scala:86:29
        rrd_uops_2_REG_is_unique = _RANDOM[7'h70][19];	// register-read.scala:86:29
        rrd_uops_2_REG_flush_on_commit = _RANDOM[7'h70][20];	// register-read.scala:86:29
        rrd_uops_2_REG_ldst_is_rs1 = _RANDOM[7'h70][21];	// register-read.scala:86:29
        rrd_uops_2_REG_ldst = _RANDOM[7'h70][27:22];	// register-read.scala:86:29
        rrd_uops_2_REG_lrs1 = {_RANDOM[7'h70][31:28], _RANDOM[7'h71][1:0]};	// register-read.scala:86:29
        rrd_uops_2_REG_lrs2 = _RANDOM[7'h71][7:2];	// register-read.scala:86:29
        rrd_uops_2_REG_lrs3 = _RANDOM[7'h71][13:8];	// register-read.scala:86:29
        rrd_uops_2_REG_ldst_val = _RANDOM[7'h71][14];	// register-read.scala:86:29
        rrd_uops_2_REG_dst_rtype = _RANDOM[7'h71][16:15];	// register-read.scala:86:29
        rrd_uops_2_REG_lrs1_rtype = _RANDOM[7'h71][18:17];	// register-read.scala:86:29
        rrd_uops_2_REG_lrs2_rtype = _RANDOM[7'h71][20:19];	// register-read.scala:86:29
        rrd_uops_2_REG_frs3_en = _RANDOM[7'h71][21];	// register-read.scala:86:29
        rrd_uops_2_REG_fp_val = _RANDOM[7'h71][22];	// register-read.scala:86:29
        rrd_uops_2_REG_fp_single = _RANDOM[7'h71][23];	// register-read.scala:86:29
        rrd_uops_2_REG_xcpt_pf_if = _RANDOM[7'h71][24];	// register-read.scala:86:29
        rrd_uops_2_REG_xcpt_ae_if = _RANDOM[7'h71][25];	// register-read.scala:86:29
        rrd_uops_2_REG_xcpt_ma_if = _RANDOM[7'h71][26];	// register-read.scala:86:29
        rrd_uops_2_REG_bp_debug_if = _RANDOM[7'h71][27];	// register-read.scala:86:29
        rrd_uops_2_REG_bp_xcpt_if = _RANDOM[7'h71][28];	// register-read.scala:86:29
        rrd_uops_2_REG_debug_fsrc = _RANDOM[7'h71][30:29];	// register-read.scala:86:29
        rrd_uops_2_REG_debug_tsrc = {_RANDOM[7'h71][31], _RANDOM[7'h72][0]};	// register-read.scala:86:29
        rrd_valids_3_REG = _RANDOM[7'h72][1];	// register-read.scala:84:29, :86:29
        rrd_uops_3_REG_uopc = _RANDOM[7'h72][8:2];	// register-read.scala:86:29
        rrd_uops_3_REG_is_rvc = _RANDOM[7'h74][9];	// register-read.scala:86:29
        rrd_uops_3_REG_fu_code = _RANDOM[7'h75][30:21];	// register-read.scala:86:29
        rrd_uops_3_REG_ctrl_br_type = {_RANDOM[7'h75][31], _RANDOM[7'h76][2:0]};	// register-read.scala:86:29
        rrd_uops_3_REG_ctrl_op1_sel = _RANDOM[7'h76][4:3];	// register-read.scala:86:29
        rrd_uops_3_REG_ctrl_op2_sel = _RANDOM[7'h76][7:5];	// register-read.scala:86:29
        rrd_uops_3_REG_ctrl_imm_sel = _RANDOM[7'h76][10:8];	// register-read.scala:86:29
        rrd_uops_3_REG_ctrl_op_fcn = _RANDOM[7'h76][14:11];	// register-read.scala:86:29
        rrd_uops_3_REG_ctrl_fcn_dw = _RANDOM[7'h76][15];	// register-read.scala:86:29
        rrd_uops_3_REG_is_br = _RANDOM[7'h76][26];	// register-read.scala:86:29
        rrd_uops_3_REG_is_jalr = _RANDOM[7'h76][27];	// register-read.scala:86:29
        rrd_uops_3_REG_is_jal = _RANDOM[7'h76][28];	// register-read.scala:86:29
        rrd_uops_3_REG_is_sfb = _RANDOM[7'h76][29];	// register-read.scala:86:29
        rrd_uops_3_REG_br_mask = {_RANDOM[7'h76][31:30], _RANDOM[7'h77][13:0]};	// register-read.scala:86:29
        rrd_uops_3_REG_br_tag = _RANDOM[7'h77][17:14];	// register-read.scala:86:29
        rrd_uops_3_REG_ftq_idx = _RANDOM[7'h77][22:18];	// register-read.scala:86:29
        rrd_uops_3_REG_edge_inst = _RANDOM[7'h77][23];	// register-read.scala:86:29
        rrd_uops_3_REG_pc_lob = _RANDOM[7'h77][29:24];	// register-read.scala:86:29
        rrd_uops_3_REG_taken = _RANDOM[7'h77][30];	// register-read.scala:86:29
        rrd_uops_3_REG_imm_packed = {_RANDOM[7'h77][31], _RANDOM[7'h78][18:0]};	// register-read.scala:86:29
        rrd_uops_3_REG_rob_idx = {_RANDOM[7'h78][31], _RANDOM[7'h79][5:0]};	// register-read.scala:86:29
        rrd_uops_3_REG_ldq_idx = _RANDOM[7'h79][10:6];	// register-read.scala:86:29
        rrd_uops_3_REG_stq_idx = _RANDOM[7'h79][15:11];	// register-read.scala:86:29
        rrd_uops_3_REG_pdst = _RANDOM[7'h79][24:18];	// register-read.scala:86:29
        rrd_uops_3_REG_prs1 = _RANDOM[7'h79][31:25];	// register-read.scala:86:29
        rrd_uops_3_REG_prs2 = _RANDOM[7'h7A][6:0];	// register-read.scala:86:29
        rrd_uops_3_REG_bypassable = _RANDOM[7'h7C][31];	// register-read.scala:86:29
        rrd_uops_3_REG_is_amo = _RANDOM[7'h7D][10];	// register-read.scala:86:29
        rrd_uops_3_REG_uses_stq = _RANDOM[7'h7D][12];	// register-read.scala:86:29
        rrd_uops_3_REG_dst_rtype = _RANDOM[7'h7E][11:10];	// register-read.scala:86:29
        rrd_uops_3_REG_lrs1_rtype = _RANDOM[7'h7E][13:12];	// register-read.scala:86:29
        rrd_uops_3_REG_lrs2_rtype = _RANDOM[7'h7E][15:14];	// register-read.scala:86:29
        rrd_rs1_data_0_REG = _RANDOM[7'h7E][28];	// register-read.scala:86:29, :124:57
        rrd_rs2_data_0_REG = _RANDOM[7'h7E][29];	// register-read.scala:86:29, :125:57
        rrd_rs1_data_1_REG = _RANDOM[7'h7E][30];	// register-read.scala:86:29, :124:57
        rrd_rs2_data_1_REG = _RANDOM[7'h7E][31];	// register-read.scala:86:29, :125:57
        rrd_rs1_data_2_REG = _RANDOM[7'h7F][0];	// register-read.scala:124:57
        rrd_rs2_data_2_REG = _RANDOM[7'h7F][1];	// register-read.scala:124:57, :125:57
        rrd_rs1_data_3_REG = _RANDOM[7'h7F][2];	// register-read.scala:124:57
        rrd_rs2_data_3_REG = _RANDOM[7'h7F][3];	// register-read.scala:124:57, :125:57
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  RegisterReadDecode_9 rrd_decode_unit (	// register-read.scala:80:33
    .io_iss_valid               (io_iss_valids_0),
    .io_iss_uop_uopc            (io_iss_uops_0_uopc),
    .io_iss_uop_inst            (io_iss_uops_0_inst),
    .io_iss_uop_debug_inst      (io_iss_uops_0_debug_inst),
    .io_iss_uop_is_rvc          (io_iss_uops_0_is_rvc),
    .io_iss_uop_debug_pc        (io_iss_uops_0_debug_pc),
    .io_iss_uop_iq_type         (io_iss_uops_0_iq_type),
    .io_iss_uop_fu_code         (io_iss_uops_0_fu_code),
    .io_iss_uop_iw_state        (io_iss_uops_0_iw_state),
    .io_iss_uop_is_br           (io_iss_uops_0_is_br),
    .io_iss_uop_is_jalr         (io_iss_uops_0_is_jalr),
    .io_iss_uop_is_jal          (io_iss_uops_0_is_jal),
    .io_iss_uop_is_sfb          (io_iss_uops_0_is_sfb),
    .io_iss_uop_br_mask         (io_iss_uops_0_br_mask),
    .io_iss_uop_br_tag          (io_iss_uops_0_br_tag),
    .io_iss_uop_ftq_idx         (io_iss_uops_0_ftq_idx),
    .io_iss_uop_edge_inst       (io_iss_uops_0_edge_inst),
    .io_iss_uop_pc_lob          (io_iss_uops_0_pc_lob),
    .io_iss_uop_taken           (io_iss_uops_0_taken),
    .io_iss_uop_imm_packed      (io_iss_uops_0_imm_packed),
    .io_iss_uop_csr_addr        (io_iss_uops_0_csr_addr),
    .io_iss_uop_rob_idx         (io_iss_uops_0_rob_idx),
    .io_iss_uop_ldq_idx         (io_iss_uops_0_ldq_idx),
    .io_iss_uop_stq_idx         (io_iss_uops_0_stq_idx),
    .io_iss_uop_rxq_idx         (io_iss_uops_0_rxq_idx),
    .io_iss_uop_pdst            (io_iss_uops_0_pdst),
    .io_iss_uop_prs1            (io_iss_uops_0_prs1),
    .io_iss_uop_prs2            (io_iss_uops_0_prs2),
    .io_iss_uop_prs3            (io_iss_uops_0_prs3),
    .io_iss_uop_ppred           (io_iss_uops_0_ppred),
    .io_iss_uop_prs1_busy       (io_iss_uops_0_prs1_busy),
    .io_iss_uop_prs2_busy       (io_iss_uops_0_prs2_busy),
    .io_iss_uop_prs3_busy       (io_iss_uops_0_prs3_busy),
    .io_iss_uop_ppred_busy      (io_iss_uops_0_ppred_busy),
    .io_iss_uop_stale_pdst      (io_iss_uops_0_stale_pdst),
    .io_iss_uop_exception       (io_iss_uops_0_exception),
    .io_iss_uop_exc_cause       (io_iss_uops_0_exc_cause),
    .io_iss_uop_bypassable      (io_iss_uops_0_bypassable),
    .io_iss_uop_mem_cmd         (io_iss_uops_0_mem_cmd),
    .io_iss_uop_mem_size        (io_iss_uops_0_mem_size),
    .io_iss_uop_mem_signed      (io_iss_uops_0_mem_signed),
    .io_iss_uop_is_fence        (io_iss_uops_0_is_fence),
    .io_iss_uop_is_fencei       (io_iss_uops_0_is_fencei),
    .io_iss_uop_is_amo          (io_iss_uops_0_is_amo),
    .io_iss_uop_uses_ldq        (io_iss_uops_0_uses_ldq),
    .io_iss_uop_uses_stq        (io_iss_uops_0_uses_stq),
    .io_iss_uop_is_sys_pc2epc   (io_iss_uops_0_is_sys_pc2epc),
    .io_iss_uop_is_unique       (io_iss_uops_0_is_unique),
    .io_iss_uop_flush_on_commit (io_iss_uops_0_flush_on_commit),
    .io_iss_uop_ldst_is_rs1     (io_iss_uops_0_ldst_is_rs1),
    .io_iss_uop_ldst            (io_iss_uops_0_ldst),
    .io_iss_uop_lrs1            (io_iss_uops_0_lrs1),
    .io_iss_uop_lrs2            (io_iss_uops_0_lrs2),
    .io_iss_uop_lrs3            (io_iss_uops_0_lrs3),
    .io_iss_uop_ldst_val        (io_iss_uops_0_ldst_val),
    .io_iss_uop_dst_rtype       (io_iss_uops_0_dst_rtype),
    .io_iss_uop_lrs1_rtype      (io_iss_uops_0_lrs1_rtype),
    .io_iss_uop_lrs2_rtype      (io_iss_uops_0_lrs2_rtype),
    .io_iss_uop_frs3_en         (io_iss_uops_0_frs3_en),
    .io_iss_uop_fp_val          (io_iss_uops_0_fp_val),
    .io_iss_uop_fp_single       (io_iss_uops_0_fp_single),
    .io_iss_uop_xcpt_pf_if      (io_iss_uops_0_xcpt_pf_if),
    .io_iss_uop_xcpt_ae_if      (io_iss_uops_0_xcpt_ae_if),
    .io_iss_uop_xcpt_ma_if      (io_iss_uops_0_xcpt_ma_if),
    .io_iss_uop_bp_debug_if     (io_iss_uops_0_bp_debug_if),
    .io_iss_uop_bp_xcpt_if      (io_iss_uops_0_bp_xcpt_if),
    .io_iss_uop_debug_fsrc      (io_iss_uops_0_debug_fsrc),
    .io_iss_uop_debug_tsrc      (io_iss_uops_0_debug_tsrc),
    .io_rrd_valid               (_rrd_decode_unit_io_rrd_valid),
    .io_rrd_uop_uopc            (_rrd_decode_unit_io_rrd_uop_uopc),
    .io_rrd_uop_inst            (_rrd_decode_unit_io_rrd_uop_inst),
    .io_rrd_uop_debug_inst      (_rrd_decode_unit_io_rrd_uop_debug_inst),
    .io_rrd_uop_is_rvc          (_rrd_decode_unit_io_rrd_uop_is_rvc),
    .io_rrd_uop_debug_pc        (_rrd_decode_unit_io_rrd_uop_debug_pc),
    .io_rrd_uop_iq_type         (_rrd_decode_unit_io_rrd_uop_iq_type),
    .io_rrd_uop_fu_code         (_rrd_decode_unit_io_rrd_uop_fu_code),
    .io_rrd_uop_ctrl_br_type    (_rrd_decode_unit_io_rrd_uop_ctrl_br_type),
    .io_rrd_uop_ctrl_op1_sel    (_rrd_decode_unit_io_rrd_uop_ctrl_op1_sel),
    .io_rrd_uop_ctrl_op2_sel    (_rrd_decode_unit_io_rrd_uop_ctrl_op2_sel),
    .io_rrd_uop_ctrl_imm_sel    (_rrd_decode_unit_io_rrd_uop_ctrl_imm_sel),
    .io_rrd_uop_ctrl_op_fcn     (_rrd_decode_unit_io_rrd_uop_ctrl_op_fcn),
    .io_rrd_uop_ctrl_fcn_dw     (_rrd_decode_unit_io_rrd_uop_ctrl_fcn_dw),
    .io_rrd_uop_ctrl_is_load    (_rrd_decode_unit_io_rrd_uop_ctrl_is_load),
    .io_rrd_uop_ctrl_is_sta     (_rrd_decode_unit_io_rrd_uop_ctrl_is_sta),
    .io_rrd_uop_ctrl_is_std     (_rrd_decode_unit_io_rrd_uop_ctrl_is_std),
    .io_rrd_uop_iw_state        (_rrd_decode_unit_io_rrd_uop_iw_state),
    .io_rrd_uop_is_br           (_rrd_decode_unit_io_rrd_uop_is_br),
    .io_rrd_uop_is_jalr         (_rrd_decode_unit_io_rrd_uop_is_jalr),
    .io_rrd_uop_is_jal          (_rrd_decode_unit_io_rrd_uop_is_jal),
    .io_rrd_uop_is_sfb          (_rrd_decode_unit_io_rrd_uop_is_sfb),
    .io_rrd_uop_br_mask         (_rrd_decode_unit_io_rrd_uop_br_mask),
    .io_rrd_uop_br_tag          (_rrd_decode_unit_io_rrd_uop_br_tag),
    .io_rrd_uop_ftq_idx         (_rrd_decode_unit_io_rrd_uop_ftq_idx),
    .io_rrd_uop_edge_inst       (_rrd_decode_unit_io_rrd_uop_edge_inst),
    .io_rrd_uop_pc_lob          (_rrd_decode_unit_io_rrd_uop_pc_lob),
    .io_rrd_uop_taken           (_rrd_decode_unit_io_rrd_uop_taken),
    .io_rrd_uop_imm_packed      (_rrd_decode_unit_io_rrd_uop_imm_packed),
    .io_rrd_uop_csr_addr        (_rrd_decode_unit_io_rrd_uop_csr_addr),
    .io_rrd_uop_rob_idx         (_rrd_decode_unit_io_rrd_uop_rob_idx),
    .io_rrd_uop_ldq_idx         (_rrd_decode_unit_io_rrd_uop_ldq_idx),
    .io_rrd_uop_stq_idx         (_rrd_decode_unit_io_rrd_uop_stq_idx),
    .io_rrd_uop_rxq_idx         (_rrd_decode_unit_io_rrd_uop_rxq_idx),
    .io_rrd_uop_pdst            (_rrd_decode_unit_io_rrd_uop_pdst),
    .io_rrd_uop_prs1            (_rrd_decode_unit_io_rrd_uop_prs1),
    .io_rrd_uop_prs2            (_rrd_decode_unit_io_rrd_uop_prs2),
    .io_rrd_uop_prs3            (_rrd_decode_unit_io_rrd_uop_prs3),
    .io_rrd_uop_ppred           (_rrd_decode_unit_io_rrd_uop_ppred),
    .io_rrd_uop_prs1_busy       (_rrd_decode_unit_io_rrd_uop_prs1_busy),
    .io_rrd_uop_prs2_busy       (_rrd_decode_unit_io_rrd_uop_prs2_busy),
    .io_rrd_uop_prs3_busy       (_rrd_decode_unit_io_rrd_uop_prs3_busy),
    .io_rrd_uop_ppred_busy      (_rrd_decode_unit_io_rrd_uop_ppred_busy),
    .io_rrd_uop_stale_pdst      (_rrd_decode_unit_io_rrd_uop_stale_pdst),
    .io_rrd_uop_exception       (_rrd_decode_unit_io_rrd_uop_exception),
    .io_rrd_uop_exc_cause       (_rrd_decode_unit_io_rrd_uop_exc_cause),
    .io_rrd_uop_bypassable      (_rrd_decode_unit_io_rrd_uop_bypassable),
    .io_rrd_uop_mem_cmd         (_rrd_decode_unit_io_rrd_uop_mem_cmd),
    .io_rrd_uop_mem_size        (_rrd_decode_unit_io_rrd_uop_mem_size),
    .io_rrd_uop_mem_signed      (_rrd_decode_unit_io_rrd_uop_mem_signed),
    .io_rrd_uop_is_fence        (_rrd_decode_unit_io_rrd_uop_is_fence),
    .io_rrd_uop_is_fencei       (_rrd_decode_unit_io_rrd_uop_is_fencei),
    .io_rrd_uop_is_amo          (_rrd_decode_unit_io_rrd_uop_is_amo),
    .io_rrd_uop_uses_ldq        (_rrd_decode_unit_io_rrd_uop_uses_ldq),
    .io_rrd_uop_uses_stq        (_rrd_decode_unit_io_rrd_uop_uses_stq),
    .io_rrd_uop_is_sys_pc2epc   (_rrd_decode_unit_io_rrd_uop_is_sys_pc2epc),
    .io_rrd_uop_is_unique       (_rrd_decode_unit_io_rrd_uop_is_unique),
    .io_rrd_uop_flush_on_commit (_rrd_decode_unit_io_rrd_uop_flush_on_commit),
    .io_rrd_uop_ldst_is_rs1     (_rrd_decode_unit_io_rrd_uop_ldst_is_rs1),
    .io_rrd_uop_ldst            (_rrd_decode_unit_io_rrd_uop_ldst),
    .io_rrd_uop_lrs1            (_rrd_decode_unit_io_rrd_uop_lrs1),
    .io_rrd_uop_lrs2            (_rrd_decode_unit_io_rrd_uop_lrs2),
    .io_rrd_uop_lrs3            (_rrd_decode_unit_io_rrd_uop_lrs3),
    .io_rrd_uop_ldst_val        (_rrd_decode_unit_io_rrd_uop_ldst_val),
    .io_rrd_uop_dst_rtype       (_rrd_decode_unit_io_rrd_uop_dst_rtype),
    .io_rrd_uop_lrs1_rtype      (_rrd_decode_unit_io_rrd_uop_lrs1_rtype),
    .io_rrd_uop_lrs2_rtype      (_rrd_decode_unit_io_rrd_uop_lrs2_rtype),
    .io_rrd_uop_frs3_en         (_rrd_decode_unit_io_rrd_uop_frs3_en),
    .io_rrd_uop_fp_val          (_rrd_decode_unit_io_rrd_uop_fp_val),
    .io_rrd_uop_fp_single       (_rrd_decode_unit_io_rrd_uop_fp_single),
    .io_rrd_uop_xcpt_pf_if      (_rrd_decode_unit_io_rrd_uop_xcpt_pf_if),
    .io_rrd_uop_xcpt_ae_if      (_rrd_decode_unit_io_rrd_uop_xcpt_ae_if),
    .io_rrd_uop_xcpt_ma_if      (_rrd_decode_unit_io_rrd_uop_xcpt_ma_if),
    .io_rrd_uop_bp_debug_if     (_rrd_decode_unit_io_rrd_uop_bp_debug_if),
    .io_rrd_uop_bp_xcpt_if      (_rrd_decode_unit_io_rrd_uop_bp_xcpt_if),
    .io_rrd_uop_debug_fsrc      (_rrd_decode_unit_io_rrd_uop_debug_fsrc),
    .io_rrd_uop_debug_tsrc      (_rrd_decode_unit_io_rrd_uop_debug_tsrc)
  );
  RegisterReadDecode_10 rrd_decode_unit_1 (	// register-read.scala:80:33
    .io_iss_valid            (io_iss_valids_1),
    .io_iss_uop_uopc         (io_iss_uops_1_uopc),
    .io_iss_uop_is_rvc       (io_iss_uops_1_is_rvc),
    .io_iss_uop_fu_code      (io_iss_uops_1_fu_code),
    .io_iss_uop_is_br        (io_iss_uops_1_is_br),
    .io_iss_uop_is_jalr      (io_iss_uops_1_is_jalr),
    .io_iss_uop_is_jal       (io_iss_uops_1_is_jal),
    .io_iss_uop_is_sfb       (io_iss_uops_1_is_sfb),
    .io_iss_uop_br_mask      (io_iss_uops_1_br_mask),
    .io_iss_uop_br_tag       (io_iss_uops_1_br_tag),
    .io_iss_uop_ftq_idx      (io_iss_uops_1_ftq_idx),
    .io_iss_uop_edge_inst    (io_iss_uops_1_edge_inst),
    .io_iss_uop_pc_lob       (io_iss_uops_1_pc_lob),
    .io_iss_uop_taken        (io_iss_uops_1_taken),
    .io_iss_uop_imm_packed   (io_iss_uops_1_imm_packed),
    .io_iss_uop_rob_idx      (io_iss_uops_1_rob_idx),
    .io_iss_uop_ldq_idx      (io_iss_uops_1_ldq_idx),
    .io_iss_uop_stq_idx      (io_iss_uops_1_stq_idx),
    .io_iss_uop_pdst         (io_iss_uops_1_pdst),
    .io_iss_uop_prs1         (io_iss_uops_1_prs1),
    .io_iss_uop_prs2         (io_iss_uops_1_prs2),
    .io_iss_uop_bypassable   (io_iss_uops_1_bypassable),
    .io_iss_uop_mem_cmd      (io_iss_uops_1_mem_cmd),
    .io_iss_uop_is_amo       (io_iss_uops_1_is_amo),
    .io_iss_uop_uses_stq     (io_iss_uops_1_uses_stq),
    .io_iss_uop_dst_rtype    (io_iss_uops_1_dst_rtype),
    .io_iss_uop_lrs1_rtype   (io_iss_uops_1_lrs1_rtype),
    .io_iss_uop_lrs2_rtype   (io_iss_uops_1_lrs2_rtype),
    .io_rrd_valid            (_rrd_decode_unit_1_io_rrd_valid),
    .io_rrd_uop_uopc         (_rrd_decode_unit_1_io_rrd_uop_uopc),
    .io_rrd_uop_is_rvc       (_rrd_decode_unit_1_io_rrd_uop_is_rvc),
    .io_rrd_uop_fu_code      (_rrd_decode_unit_1_io_rrd_uop_fu_code),
    .io_rrd_uop_ctrl_br_type (_rrd_decode_unit_1_io_rrd_uop_ctrl_br_type),
    .io_rrd_uop_ctrl_op1_sel (_rrd_decode_unit_1_io_rrd_uop_ctrl_op1_sel),
    .io_rrd_uop_ctrl_op2_sel (_rrd_decode_unit_1_io_rrd_uop_ctrl_op2_sel),
    .io_rrd_uop_ctrl_imm_sel (_rrd_decode_unit_1_io_rrd_uop_ctrl_imm_sel),
    .io_rrd_uop_ctrl_op_fcn  (_rrd_decode_unit_1_io_rrd_uop_ctrl_op_fcn),
    .io_rrd_uop_ctrl_fcn_dw  (_rrd_decode_unit_1_io_rrd_uop_ctrl_fcn_dw),
    .io_rrd_uop_is_br        (_rrd_decode_unit_1_io_rrd_uop_is_br),
    .io_rrd_uop_is_jalr      (_rrd_decode_unit_1_io_rrd_uop_is_jalr),
    .io_rrd_uop_is_jal       (_rrd_decode_unit_1_io_rrd_uop_is_jal),
    .io_rrd_uop_is_sfb       (_rrd_decode_unit_1_io_rrd_uop_is_sfb),
    .io_rrd_uop_br_mask      (_rrd_decode_unit_1_io_rrd_uop_br_mask),
    .io_rrd_uop_br_tag       (_rrd_decode_unit_1_io_rrd_uop_br_tag),
    .io_rrd_uop_ftq_idx      (_rrd_decode_unit_1_io_rrd_uop_ftq_idx),
    .io_rrd_uop_edge_inst    (_rrd_decode_unit_1_io_rrd_uop_edge_inst),
    .io_rrd_uop_pc_lob       (_rrd_decode_unit_1_io_rrd_uop_pc_lob),
    .io_rrd_uop_taken        (_rrd_decode_unit_1_io_rrd_uop_taken),
    .io_rrd_uop_imm_packed   (_rrd_decode_unit_1_io_rrd_uop_imm_packed),
    .io_rrd_uop_rob_idx      (_rrd_decode_unit_1_io_rrd_uop_rob_idx),
    .io_rrd_uop_ldq_idx      (_rrd_decode_unit_1_io_rrd_uop_ldq_idx),
    .io_rrd_uop_stq_idx      (_rrd_decode_unit_1_io_rrd_uop_stq_idx),
    .io_rrd_uop_pdst         (_rrd_decode_unit_1_io_rrd_uop_pdst),
    .io_rrd_uop_prs1         (_rrd_decode_unit_1_io_rrd_uop_prs1),
    .io_rrd_uop_prs2         (_rrd_decode_unit_1_io_rrd_uop_prs2),
    .io_rrd_uop_bypassable   (_rrd_decode_unit_1_io_rrd_uop_bypassable),
    .io_rrd_uop_is_amo       (_rrd_decode_unit_1_io_rrd_uop_is_amo),
    .io_rrd_uop_uses_stq     (_rrd_decode_unit_1_io_rrd_uop_uses_stq),
    .io_rrd_uop_dst_rtype    (_rrd_decode_unit_1_io_rrd_uop_dst_rtype),
    .io_rrd_uop_lrs1_rtype   (_rrd_decode_unit_1_io_rrd_uop_lrs1_rtype),
    .io_rrd_uop_lrs2_rtype   (_rrd_decode_unit_1_io_rrd_uop_lrs2_rtype)
  );
  RegisterReadDecode_11 rrd_decode_unit_2 (	// register-read.scala:80:33
    .io_iss_valid               (io_iss_valids_2),
    .io_iss_uop_uopc            (io_iss_uops_2_uopc),
    .io_iss_uop_inst            (io_iss_uops_2_inst),
    .io_iss_uop_debug_inst      (io_iss_uops_2_debug_inst),
    .io_iss_uop_is_rvc          (io_iss_uops_2_is_rvc),
    .io_iss_uop_debug_pc        (io_iss_uops_2_debug_pc),
    .io_iss_uop_iq_type         (io_iss_uops_2_iq_type),
    .io_iss_uop_fu_code         (io_iss_uops_2_fu_code),
    .io_iss_uop_iw_state        (io_iss_uops_2_iw_state),
    .io_iss_uop_is_br           (io_iss_uops_2_is_br),
    .io_iss_uop_is_jalr         (io_iss_uops_2_is_jalr),
    .io_iss_uop_is_jal          (io_iss_uops_2_is_jal),
    .io_iss_uop_is_sfb          (io_iss_uops_2_is_sfb),
    .io_iss_uop_br_mask         (io_iss_uops_2_br_mask),
    .io_iss_uop_br_tag          (io_iss_uops_2_br_tag),
    .io_iss_uop_ftq_idx         (io_iss_uops_2_ftq_idx),
    .io_iss_uop_edge_inst       (io_iss_uops_2_edge_inst),
    .io_iss_uop_pc_lob          (io_iss_uops_2_pc_lob),
    .io_iss_uop_taken           (io_iss_uops_2_taken),
    .io_iss_uop_imm_packed      (io_iss_uops_2_imm_packed),
    .io_iss_uop_csr_addr        (io_iss_uops_2_csr_addr),
    .io_iss_uop_rob_idx         (io_iss_uops_2_rob_idx),
    .io_iss_uop_ldq_idx         (io_iss_uops_2_ldq_idx),
    .io_iss_uop_stq_idx         (io_iss_uops_2_stq_idx),
    .io_iss_uop_rxq_idx         (io_iss_uops_2_rxq_idx),
    .io_iss_uop_pdst            (io_iss_uops_2_pdst),
    .io_iss_uop_prs1            (io_iss_uops_2_prs1),
    .io_iss_uop_prs2            (io_iss_uops_2_prs2),
    .io_iss_uop_prs3            (io_iss_uops_2_prs3),
    .io_iss_uop_ppred           (io_iss_uops_2_ppred),
    .io_iss_uop_prs1_busy       (io_iss_uops_2_prs1_busy),
    .io_iss_uop_prs2_busy       (io_iss_uops_2_prs2_busy),
    .io_iss_uop_prs3_busy       (io_iss_uops_2_prs3_busy),
    .io_iss_uop_ppred_busy      (io_iss_uops_2_ppred_busy),
    .io_iss_uop_stale_pdst      (io_iss_uops_2_stale_pdst),
    .io_iss_uop_exception       (io_iss_uops_2_exception),
    .io_iss_uop_exc_cause       (io_iss_uops_2_exc_cause),
    .io_iss_uop_bypassable      (io_iss_uops_2_bypassable),
    .io_iss_uop_mem_cmd         (io_iss_uops_2_mem_cmd),
    .io_iss_uop_mem_size        (io_iss_uops_2_mem_size),
    .io_iss_uop_mem_signed      (io_iss_uops_2_mem_signed),
    .io_iss_uop_is_fence        (io_iss_uops_2_is_fence),
    .io_iss_uop_is_fencei       (io_iss_uops_2_is_fencei),
    .io_iss_uop_is_amo          (io_iss_uops_2_is_amo),
    .io_iss_uop_uses_ldq        (io_iss_uops_2_uses_ldq),
    .io_iss_uop_uses_stq        (io_iss_uops_2_uses_stq),
    .io_iss_uop_is_sys_pc2epc   (io_iss_uops_2_is_sys_pc2epc),
    .io_iss_uop_is_unique       (io_iss_uops_2_is_unique),
    .io_iss_uop_flush_on_commit (io_iss_uops_2_flush_on_commit),
    .io_iss_uop_ldst_is_rs1     (io_iss_uops_2_ldst_is_rs1),
    .io_iss_uop_ldst            (io_iss_uops_2_ldst),
    .io_iss_uop_lrs1            (io_iss_uops_2_lrs1),
    .io_iss_uop_lrs2            (io_iss_uops_2_lrs2),
    .io_iss_uop_lrs3            (io_iss_uops_2_lrs3),
    .io_iss_uop_ldst_val        (io_iss_uops_2_ldst_val),
    .io_iss_uop_dst_rtype       (io_iss_uops_2_dst_rtype),
    .io_iss_uop_lrs1_rtype      (io_iss_uops_2_lrs1_rtype),
    .io_iss_uop_lrs2_rtype      (io_iss_uops_2_lrs2_rtype),
    .io_iss_uop_frs3_en         (io_iss_uops_2_frs3_en),
    .io_iss_uop_fp_val          (io_iss_uops_2_fp_val),
    .io_iss_uop_fp_single       (io_iss_uops_2_fp_single),
    .io_iss_uop_xcpt_pf_if      (io_iss_uops_2_xcpt_pf_if),
    .io_iss_uop_xcpt_ae_if      (io_iss_uops_2_xcpt_ae_if),
    .io_iss_uop_xcpt_ma_if      (io_iss_uops_2_xcpt_ma_if),
    .io_iss_uop_bp_debug_if     (io_iss_uops_2_bp_debug_if),
    .io_iss_uop_bp_xcpt_if      (io_iss_uops_2_bp_xcpt_if),
    .io_iss_uop_debug_fsrc      (io_iss_uops_2_debug_fsrc),
    .io_iss_uop_debug_tsrc      (io_iss_uops_2_debug_tsrc),
    .io_rrd_valid               (_rrd_decode_unit_2_io_rrd_valid),
    .io_rrd_uop_uopc            (_rrd_decode_unit_2_io_rrd_uop_uopc),
    .io_rrd_uop_inst            (_rrd_decode_unit_2_io_rrd_uop_inst),
    .io_rrd_uop_debug_inst      (_rrd_decode_unit_2_io_rrd_uop_debug_inst),
    .io_rrd_uop_is_rvc          (_rrd_decode_unit_2_io_rrd_uop_is_rvc),
    .io_rrd_uop_debug_pc        (_rrd_decode_unit_2_io_rrd_uop_debug_pc),
    .io_rrd_uop_iq_type         (_rrd_decode_unit_2_io_rrd_uop_iq_type),
    .io_rrd_uop_fu_code         (_rrd_decode_unit_2_io_rrd_uop_fu_code),
    .io_rrd_uop_ctrl_br_type    (_rrd_decode_unit_2_io_rrd_uop_ctrl_br_type),
    .io_rrd_uop_ctrl_op1_sel    (_rrd_decode_unit_2_io_rrd_uop_ctrl_op1_sel),
    .io_rrd_uop_ctrl_op2_sel    (_rrd_decode_unit_2_io_rrd_uop_ctrl_op2_sel),
    .io_rrd_uop_ctrl_imm_sel    (_rrd_decode_unit_2_io_rrd_uop_ctrl_imm_sel),
    .io_rrd_uop_ctrl_op_fcn     (_rrd_decode_unit_2_io_rrd_uop_ctrl_op_fcn),
    .io_rrd_uop_ctrl_fcn_dw     (_rrd_decode_unit_2_io_rrd_uop_ctrl_fcn_dw),
    .io_rrd_uop_ctrl_csr_cmd    (_rrd_decode_unit_2_io_rrd_uop_ctrl_csr_cmd),
    .io_rrd_uop_ctrl_is_load    (_rrd_decode_unit_2_io_rrd_uop_ctrl_is_load),
    .io_rrd_uop_ctrl_is_sta     (_rrd_decode_unit_2_io_rrd_uop_ctrl_is_sta),
    .io_rrd_uop_ctrl_is_std     (_rrd_decode_unit_2_io_rrd_uop_ctrl_is_std),
    .io_rrd_uop_iw_state        (_rrd_decode_unit_2_io_rrd_uop_iw_state),
    .io_rrd_uop_is_br           (_rrd_decode_unit_2_io_rrd_uop_is_br),
    .io_rrd_uop_is_jalr         (_rrd_decode_unit_2_io_rrd_uop_is_jalr),
    .io_rrd_uop_is_jal          (_rrd_decode_unit_2_io_rrd_uop_is_jal),
    .io_rrd_uop_is_sfb          (_rrd_decode_unit_2_io_rrd_uop_is_sfb),
    .io_rrd_uop_br_mask         (_rrd_decode_unit_2_io_rrd_uop_br_mask),
    .io_rrd_uop_br_tag          (_rrd_decode_unit_2_io_rrd_uop_br_tag),
    .io_rrd_uop_ftq_idx         (_rrd_decode_unit_2_io_rrd_uop_ftq_idx),
    .io_rrd_uop_edge_inst       (_rrd_decode_unit_2_io_rrd_uop_edge_inst),
    .io_rrd_uop_pc_lob          (_rrd_decode_unit_2_io_rrd_uop_pc_lob),
    .io_rrd_uop_taken           (_rrd_decode_unit_2_io_rrd_uop_taken),
    .io_rrd_uop_imm_packed      (_rrd_decode_unit_2_io_rrd_uop_imm_packed),
    .io_rrd_uop_csr_addr        (_rrd_decode_unit_2_io_rrd_uop_csr_addr),
    .io_rrd_uop_rob_idx         (_rrd_decode_unit_2_io_rrd_uop_rob_idx),
    .io_rrd_uop_ldq_idx         (_rrd_decode_unit_2_io_rrd_uop_ldq_idx),
    .io_rrd_uop_stq_idx         (_rrd_decode_unit_2_io_rrd_uop_stq_idx),
    .io_rrd_uop_rxq_idx         (_rrd_decode_unit_2_io_rrd_uop_rxq_idx),
    .io_rrd_uop_pdst            (_rrd_decode_unit_2_io_rrd_uop_pdst),
    .io_rrd_uop_prs1            (_rrd_decode_unit_2_io_rrd_uop_prs1),
    .io_rrd_uop_prs2            (_rrd_decode_unit_2_io_rrd_uop_prs2),
    .io_rrd_uop_prs3            (_rrd_decode_unit_2_io_rrd_uop_prs3),
    .io_rrd_uop_ppred           (_rrd_decode_unit_2_io_rrd_uop_ppred),
    .io_rrd_uop_prs1_busy       (_rrd_decode_unit_2_io_rrd_uop_prs1_busy),
    .io_rrd_uop_prs2_busy       (_rrd_decode_unit_2_io_rrd_uop_prs2_busy),
    .io_rrd_uop_prs3_busy       (_rrd_decode_unit_2_io_rrd_uop_prs3_busy),
    .io_rrd_uop_ppred_busy      (_rrd_decode_unit_2_io_rrd_uop_ppred_busy),
    .io_rrd_uop_stale_pdst      (_rrd_decode_unit_2_io_rrd_uop_stale_pdst),
    .io_rrd_uop_exception       (_rrd_decode_unit_2_io_rrd_uop_exception),
    .io_rrd_uop_exc_cause       (_rrd_decode_unit_2_io_rrd_uop_exc_cause),
    .io_rrd_uop_bypassable      (_rrd_decode_unit_2_io_rrd_uop_bypassable),
    .io_rrd_uop_mem_cmd         (_rrd_decode_unit_2_io_rrd_uop_mem_cmd),
    .io_rrd_uop_mem_size        (_rrd_decode_unit_2_io_rrd_uop_mem_size),
    .io_rrd_uop_mem_signed      (_rrd_decode_unit_2_io_rrd_uop_mem_signed),
    .io_rrd_uop_is_fence        (_rrd_decode_unit_2_io_rrd_uop_is_fence),
    .io_rrd_uop_is_fencei       (_rrd_decode_unit_2_io_rrd_uop_is_fencei),
    .io_rrd_uop_is_amo          (_rrd_decode_unit_2_io_rrd_uop_is_amo),
    .io_rrd_uop_uses_ldq        (_rrd_decode_unit_2_io_rrd_uop_uses_ldq),
    .io_rrd_uop_uses_stq        (_rrd_decode_unit_2_io_rrd_uop_uses_stq),
    .io_rrd_uop_is_sys_pc2epc   (_rrd_decode_unit_2_io_rrd_uop_is_sys_pc2epc),
    .io_rrd_uop_is_unique       (_rrd_decode_unit_2_io_rrd_uop_is_unique),
    .io_rrd_uop_flush_on_commit (_rrd_decode_unit_2_io_rrd_uop_flush_on_commit),
    .io_rrd_uop_ldst_is_rs1     (_rrd_decode_unit_2_io_rrd_uop_ldst_is_rs1),
    .io_rrd_uop_ldst            (_rrd_decode_unit_2_io_rrd_uop_ldst),
    .io_rrd_uop_lrs1            (_rrd_decode_unit_2_io_rrd_uop_lrs1),
    .io_rrd_uop_lrs2            (_rrd_decode_unit_2_io_rrd_uop_lrs2),
    .io_rrd_uop_lrs3            (_rrd_decode_unit_2_io_rrd_uop_lrs3),
    .io_rrd_uop_ldst_val        (_rrd_decode_unit_2_io_rrd_uop_ldst_val),
    .io_rrd_uop_dst_rtype       (_rrd_decode_unit_2_io_rrd_uop_dst_rtype),
    .io_rrd_uop_lrs1_rtype      (_rrd_decode_unit_2_io_rrd_uop_lrs1_rtype),
    .io_rrd_uop_lrs2_rtype      (_rrd_decode_unit_2_io_rrd_uop_lrs2_rtype),
    .io_rrd_uop_frs3_en         (_rrd_decode_unit_2_io_rrd_uop_frs3_en),
    .io_rrd_uop_fp_val          (_rrd_decode_unit_2_io_rrd_uop_fp_val),
    .io_rrd_uop_fp_single       (_rrd_decode_unit_2_io_rrd_uop_fp_single),
    .io_rrd_uop_xcpt_pf_if      (_rrd_decode_unit_2_io_rrd_uop_xcpt_pf_if),
    .io_rrd_uop_xcpt_ae_if      (_rrd_decode_unit_2_io_rrd_uop_xcpt_ae_if),
    .io_rrd_uop_xcpt_ma_if      (_rrd_decode_unit_2_io_rrd_uop_xcpt_ma_if),
    .io_rrd_uop_bp_debug_if     (_rrd_decode_unit_2_io_rrd_uop_bp_debug_if),
    .io_rrd_uop_bp_xcpt_if      (_rrd_decode_unit_2_io_rrd_uop_bp_xcpt_if),
    .io_rrd_uop_debug_fsrc      (_rrd_decode_unit_2_io_rrd_uop_debug_fsrc),
    .io_rrd_uop_debug_tsrc      (_rrd_decode_unit_2_io_rrd_uop_debug_tsrc)
  );
  RegisterReadDecode_12 rrd_decode_unit_3 (	// register-read.scala:80:33
    .io_iss_valid            (io_iss_valids_3),
    .io_iss_uop_uopc         (io_iss_uops_3_uopc),
    .io_iss_uop_is_rvc       (io_iss_uops_3_is_rvc),
    .io_iss_uop_fu_code      (io_iss_uops_3_fu_code),
    .io_iss_uop_is_br        (io_iss_uops_3_is_br),
    .io_iss_uop_is_jalr      (io_iss_uops_3_is_jalr),
    .io_iss_uop_is_jal       (io_iss_uops_3_is_jal),
    .io_iss_uop_is_sfb       (io_iss_uops_3_is_sfb),
    .io_iss_uop_br_mask      (io_iss_uops_3_br_mask),
    .io_iss_uop_br_tag       (io_iss_uops_3_br_tag),
    .io_iss_uop_ftq_idx      (io_iss_uops_3_ftq_idx),
    .io_iss_uop_edge_inst    (io_iss_uops_3_edge_inst),
    .io_iss_uop_pc_lob       (io_iss_uops_3_pc_lob),
    .io_iss_uop_taken        (io_iss_uops_3_taken),
    .io_iss_uop_imm_packed   (io_iss_uops_3_imm_packed),
    .io_iss_uop_rob_idx      (io_iss_uops_3_rob_idx),
    .io_iss_uop_ldq_idx      (io_iss_uops_3_ldq_idx),
    .io_iss_uop_stq_idx      (io_iss_uops_3_stq_idx),
    .io_iss_uop_pdst         (io_iss_uops_3_pdst),
    .io_iss_uop_prs1         (io_iss_uops_3_prs1),
    .io_iss_uop_prs2         (io_iss_uops_3_prs2),
    .io_iss_uop_bypassable   (io_iss_uops_3_bypassable),
    .io_iss_uop_mem_cmd      (io_iss_uops_3_mem_cmd),
    .io_iss_uop_is_amo       (io_iss_uops_3_is_amo),
    .io_iss_uop_uses_stq     (io_iss_uops_3_uses_stq),
    .io_iss_uop_dst_rtype    (io_iss_uops_3_dst_rtype),
    .io_iss_uop_lrs1_rtype   (io_iss_uops_3_lrs1_rtype),
    .io_iss_uop_lrs2_rtype   (io_iss_uops_3_lrs2_rtype),
    .io_rrd_valid            (_rrd_decode_unit_3_io_rrd_valid),
    .io_rrd_uop_uopc         (_rrd_decode_unit_3_io_rrd_uop_uopc),
    .io_rrd_uop_is_rvc       (_rrd_decode_unit_3_io_rrd_uop_is_rvc),
    .io_rrd_uop_fu_code      (_rrd_decode_unit_3_io_rrd_uop_fu_code),
    .io_rrd_uop_ctrl_br_type (_rrd_decode_unit_3_io_rrd_uop_ctrl_br_type),
    .io_rrd_uop_ctrl_op1_sel (_rrd_decode_unit_3_io_rrd_uop_ctrl_op1_sel),
    .io_rrd_uop_ctrl_op2_sel (_rrd_decode_unit_3_io_rrd_uop_ctrl_op2_sel),
    .io_rrd_uop_ctrl_imm_sel (_rrd_decode_unit_3_io_rrd_uop_ctrl_imm_sel),
    .io_rrd_uop_ctrl_op_fcn  (_rrd_decode_unit_3_io_rrd_uop_ctrl_op_fcn),
    .io_rrd_uop_ctrl_fcn_dw  (_rrd_decode_unit_3_io_rrd_uop_ctrl_fcn_dw),
    .io_rrd_uop_is_br        (_rrd_decode_unit_3_io_rrd_uop_is_br),
    .io_rrd_uop_is_jalr      (_rrd_decode_unit_3_io_rrd_uop_is_jalr),
    .io_rrd_uop_is_jal       (_rrd_decode_unit_3_io_rrd_uop_is_jal),
    .io_rrd_uop_is_sfb       (_rrd_decode_unit_3_io_rrd_uop_is_sfb),
    .io_rrd_uop_br_mask      (_rrd_decode_unit_3_io_rrd_uop_br_mask),
    .io_rrd_uop_br_tag       (_rrd_decode_unit_3_io_rrd_uop_br_tag),
    .io_rrd_uop_ftq_idx      (_rrd_decode_unit_3_io_rrd_uop_ftq_idx),
    .io_rrd_uop_edge_inst    (_rrd_decode_unit_3_io_rrd_uop_edge_inst),
    .io_rrd_uop_pc_lob       (_rrd_decode_unit_3_io_rrd_uop_pc_lob),
    .io_rrd_uop_taken        (_rrd_decode_unit_3_io_rrd_uop_taken),
    .io_rrd_uop_imm_packed   (_rrd_decode_unit_3_io_rrd_uop_imm_packed),
    .io_rrd_uop_rob_idx      (_rrd_decode_unit_3_io_rrd_uop_rob_idx),
    .io_rrd_uop_ldq_idx      (_rrd_decode_unit_3_io_rrd_uop_ldq_idx),
    .io_rrd_uop_stq_idx      (_rrd_decode_unit_3_io_rrd_uop_stq_idx),
    .io_rrd_uop_pdst         (_rrd_decode_unit_3_io_rrd_uop_pdst),
    .io_rrd_uop_prs1         (_rrd_decode_unit_3_io_rrd_uop_prs1),
    .io_rrd_uop_prs2         (_rrd_decode_unit_3_io_rrd_uop_prs2),
    .io_rrd_uop_bypassable   (_rrd_decode_unit_3_io_rrd_uop_bypassable),
    .io_rrd_uop_is_amo       (_rrd_decode_unit_3_io_rrd_uop_is_amo),
    .io_rrd_uop_uses_stq     (_rrd_decode_unit_3_io_rrd_uop_uses_stq),
    .io_rrd_uop_dst_rtype    (_rrd_decode_unit_3_io_rrd_uop_dst_rtype),
    .io_rrd_uop_lrs1_rtype   (_rrd_decode_unit_3_io_rrd_uop_lrs1_rtype),
    .io_rrd_uop_lrs2_rtype   (_rrd_decode_unit_3_io_rrd_uop_lrs2_rtype)
  );
  assign io_rf_read_ports_0_addr = io_iss_uops_0_prs1;
  assign io_rf_read_ports_1_addr = io_iss_uops_0_prs2;
  assign io_rf_read_ports_2_addr = io_iss_uops_1_prs1;
  assign io_rf_read_ports_3_addr = io_iss_uops_1_prs2;
  assign io_rf_read_ports_4_addr = io_iss_uops_2_prs1;
  assign io_rf_read_ports_5_addr = io_iss_uops_2_prs2;
  assign io_rf_read_ports_6_addr = io_iss_uops_3_prs1;
  assign io_rf_read_ports_7_addr = io_iss_uops_3_prs2;
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
  assign io_exe_reqs_1_bits_uop_is_rvc = exe_reg_uops_1_is_rvc;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_fu_code = exe_reg_uops_1_fu_code;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_ctrl_br_type = exe_reg_uops_1_ctrl_br_type;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_ctrl_op1_sel = exe_reg_uops_1_ctrl_op1_sel;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_ctrl_op2_sel = exe_reg_uops_1_ctrl_op2_sel;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_ctrl_imm_sel = exe_reg_uops_1_ctrl_imm_sel;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_ctrl_op_fcn = exe_reg_uops_1_ctrl_op_fcn;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_ctrl_fcn_dw = exe_reg_uops_1_ctrl_fcn_dw;	// register-read.scala:70:29
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
  assign io_exe_reqs_1_bits_uop_rob_idx = exe_reg_uops_1_rob_idx;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_ldq_idx = exe_reg_uops_1_ldq_idx;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_stq_idx = exe_reg_uops_1_stq_idx;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_pdst = exe_reg_uops_1_pdst;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_prs1 = exe_reg_uops_1_prs1;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_bypassable = exe_reg_uops_1_bypassable;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_is_amo = exe_reg_uops_1_is_amo;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_uses_stq = exe_reg_uops_1_uses_stq;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_dst_rtype = exe_reg_uops_1_dst_rtype;	// register-read.scala:70:29
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
  assign io_exe_reqs_2_bits_uop_ctrl_csr_cmd = exe_reg_uops_2_ctrl_csr_cmd;	// register-read.scala:70:29
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
endmodule

