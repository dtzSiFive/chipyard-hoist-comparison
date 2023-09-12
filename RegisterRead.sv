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

module RegisterRead(
  input         clock,
                reset,
                io_iss_valids_0,
                io_iss_valids_1,
  input  [6:0]  io_iss_uops_0_uopc,
  input  [31:0] io_iss_uops_0_inst,
                io_iss_uops_0_debug_inst,
  input         io_iss_uops_0_is_rvc,
  input  [39:0] io_iss_uops_0_debug_pc,
  input  [2:0]  io_iss_uops_0_iq_type,
  input  [9:0]  io_iss_uops_0_fu_code,
  input  [1:0]  io_iss_uops_0_iw_state,
  input         io_iss_uops_0_iw_p1_poisoned,
                io_iss_uops_0_iw_p2_poisoned,
                io_iss_uops_0_is_br,
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
  input         io_iss_uops_1_iw_p1_poisoned,
                io_iss_uops_1_iw_p2_poisoned,
                io_iss_uops_1_is_br,
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
  input  [64:0] io_rf_read_ports_0_data,
                io_rf_read_ports_1_data,
                io_rf_read_ports_2_data,
                io_rf_read_ports_3_data,
                io_rf_read_ports_4_data,
                io_rf_read_ports_5_data,
  input         io_kill,
  input  [19:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  output [6:0]  io_rf_read_ports_0_addr,
                io_rf_read_ports_1_addr,
                io_rf_read_ports_2_addr,
                io_rf_read_ports_3_addr,
                io_rf_read_ports_4_addr,
                io_rf_read_ports_5_addr,
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
  output        io_exe_reqs_0_bits_uop_iw_p1_poisoned,
                io_exe_reqs_0_bits_uop_iw_p2_poisoned,
                io_exe_reqs_0_bits_uop_is_br,
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
  output [64:0] io_exe_reqs_0_bits_rs1_data,
                io_exe_reqs_0_bits_rs2_data,
                io_exe_reqs_0_bits_rs3_data,
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
  output        io_exe_reqs_1_bits_uop_iw_p1_poisoned,
                io_exe_reqs_1_bits_uop_iw_p2_poisoned,
                io_exe_reqs_1_bits_uop_is_br,
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
  output [64:0] io_exe_reqs_1_bits_rs1_data,
                io_exe_reqs_1_bits_rs2_data,
                io_exe_reqs_1_bits_rs3_data
);

  wire        _rrd_decode_unit_1_io_rrd_valid;	// register-read.scala:80:33
  wire [6:0]  _rrd_decode_unit_1_io_rrd_uop_uopc;	// register-read.scala:80:33
  wire [31:0] _rrd_decode_unit_1_io_rrd_uop_inst;	// register-read.scala:80:33
  wire [31:0] _rrd_decode_unit_1_io_rrd_uop_debug_inst;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_is_rvc;	// register-read.scala:80:33
  wire [39:0] _rrd_decode_unit_1_io_rrd_uop_debug_pc;	// register-read.scala:80:33
  wire [2:0]  _rrd_decode_unit_1_io_rrd_uop_iq_type;	// register-read.scala:80:33
  wire [9:0]  _rrd_decode_unit_1_io_rrd_uop_fu_code;	// register-read.scala:80:33
  wire [3:0]  _rrd_decode_unit_1_io_rrd_uop_ctrl_br_type;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_1_io_rrd_uop_ctrl_op1_sel;	// register-read.scala:80:33
  wire [2:0]  _rrd_decode_unit_1_io_rrd_uop_ctrl_op2_sel;	// register-read.scala:80:33
  wire [2:0]  _rrd_decode_unit_1_io_rrd_uop_ctrl_imm_sel;	// register-read.scala:80:33
  wire [3:0]  _rrd_decode_unit_1_io_rrd_uop_ctrl_op_fcn;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_ctrl_fcn_dw;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_ctrl_is_load;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_ctrl_is_sta;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_ctrl_is_std;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_1_io_rrd_uop_iw_state;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_iw_p1_poisoned;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_iw_p2_poisoned;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_is_br;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_is_jalr;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_is_jal;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_is_sfb;	// register-read.scala:80:33
  wire [19:0] _rrd_decode_unit_1_io_rrd_uop_br_mask;	// register-read.scala:80:33
  wire [4:0]  _rrd_decode_unit_1_io_rrd_uop_br_tag;	// register-read.scala:80:33
  wire [5:0]  _rrd_decode_unit_1_io_rrd_uop_ftq_idx;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_edge_inst;	// register-read.scala:80:33
  wire [5:0]  _rrd_decode_unit_1_io_rrd_uop_pc_lob;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_taken;	// register-read.scala:80:33
  wire [19:0] _rrd_decode_unit_1_io_rrd_uop_imm_packed;	// register-read.scala:80:33
  wire [11:0] _rrd_decode_unit_1_io_rrd_uop_csr_addr;	// register-read.scala:80:33
  wire [6:0]  _rrd_decode_unit_1_io_rrd_uop_rob_idx;	// register-read.scala:80:33
  wire [4:0]  _rrd_decode_unit_1_io_rrd_uop_ldq_idx;	// register-read.scala:80:33
  wire [4:0]  _rrd_decode_unit_1_io_rrd_uop_stq_idx;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_1_io_rrd_uop_rxq_idx;	// register-read.scala:80:33
  wire [6:0]  _rrd_decode_unit_1_io_rrd_uop_pdst;	// register-read.scala:80:33
  wire [6:0]  _rrd_decode_unit_1_io_rrd_uop_prs1;	// register-read.scala:80:33
  wire [6:0]  _rrd_decode_unit_1_io_rrd_uop_prs2;	// register-read.scala:80:33
  wire [6:0]  _rrd_decode_unit_1_io_rrd_uop_prs3;	// register-read.scala:80:33
  wire [5:0]  _rrd_decode_unit_1_io_rrd_uop_ppred;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_prs1_busy;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_prs2_busy;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_prs3_busy;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_ppred_busy;	// register-read.scala:80:33
  wire [6:0]  _rrd_decode_unit_1_io_rrd_uop_stale_pdst;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_exception;	// register-read.scala:80:33
  wire [63:0] _rrd_decode_unit_1_io_rrd_uop_exc_cause;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_bypassable;	// register-read.scala:80:33
  wire [4:0]  _rrd_decode_unit_1_io_rrd_uop_mem_cmd;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_1_io_rrd_uop_mem_size;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_mem_signed;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_is_fence;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_is_fencei;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_is_amo;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_uses_ldq;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_uses_stq;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_is_sys_pc2epc;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_is_unique;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_flush_on_commit;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_ldst_is_rs1;	// register-read.scala:80:33
  wire [5:0]  _rrd_decode_unit_1_io_rrd_uop_ldst;	// register-read.scala:80:33
  wire [5:0]  _rrd_decode_unit_1_io_rrd_uop_lrs1;	// register-read.scala:80:33
  wire [5:0]  _rrd_decode_unit_1_io_rrd_uop_lrs2;	// register-read.scala:80:33
  wire [5:0]  _rrd_decode_unit_1_io_rrd_uop_lrs3;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_ldst_val;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_1_io_rrd_uop_dst_rtype;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_1_io_rrd_uop_lrs1_rtype;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_1_io_rrd_uop_lrs2_rtype;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_frs3_en;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_fp_val;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_fp_single;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_xcpt_pf_if;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_xcpt_ae_if;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_xcpt_ma_if;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_bp_debug_if;	// register-read.scala:80:33
  wire        _rrd_decode_unit_1_io_rrd_uop_bp_xcpt_if;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_1_io_rrd_uop_debug_fsrc;	// register-read.scala:80:33
  wire [1:0]  _rrd_decode_unit_1_io_rrd_uop_debug_tsrc;	// register-read.scala:80:33
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
  wire        _rrd_decode_unit_io_rrd_uop_iw_p1_poisoned;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_iw_p2_poisoned;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_is_br;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_is_jalr;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_is_jal;	// register-read.scala:80:33
  wire        _rrd_decode_unit_io_rrd_uop_is_sfb;	// register-read.scala:80:33
  wire [19:0] _rrd_decode_unit_io_rrd_uop_br_mask;	// register-read.scala:80:33
  wire [4:0]  _rrd_decode_unit_io_rrd_uop_br_tag;	// register-read.scala:80:33
  wire [5:0]  _rrd_decode_unit_io_rrd_uop_ftq_idx;	// register-read.scala:80:33
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
  wire [5:0]  _rrd_decode_unit_io_rrd_uop_ppred;	// register-read.scala:80:33
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
  reg         exe_reg_uops_0_iw_p1_poisoned;	// register-read.scala:70:29
  reg         exe_reg_uops_0_iw_p2_poisoned;	// register-read.scala:70:29
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
  reg         exe_reg_uops_1_iw_p1_poisoned;	// register-read.scala:70:29
  reg         exe_reg_uops_1_iw_p2_poisoned;	// register-read.scala:70:29
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
  reg  [64:0] exe_reg_rs1_data_0;	// register-read.scala:71:29
  reg  [64:0] exe_reg_rs1_data_1;	// register-read.scala:71:29
  reg  [64:0] exe_reg_rs2_data_0;	// register-read.scala:72:29
  reg  [64:0] exe_reg_rs2_data_1;	// register-read.scala:72:29
  reg  [64:0] exe_reg_rs3_data_0;	// register-read.scala:73:29
  reg  [64:0] exe_reg_rs3_data_1;	// register-read.scala:73:29
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
  reg         rrd_uops_0_REG_iw_p1_poisoned;	// register-read.scala:86:29
  reg         rrd_uops_0_REG_iw_p2_poisoned;	// register-read.scala:86:29
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
  reg         rrd_uops_1_REG_iw_p1_poisoned;	// register-read.scala:86:29
  reg         rrd_uops_1_REG_iw_p2_poisoned;	// register-read.scala:86:29
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
  reg         rrd_rs1_data_0_REG;	// register-read.scala:124:57
  reg         rrd_rs2_data_0_REG;	// register-read.scala:125:57
  reg         rrd_rs3_data_0_REG;	// register-read.scala:126:57
  reg         rrd_rs1_data_1_REG;	// register-read.scala:124:57
  reg         rrd_rs2_data_1_REG;	// register-read.scala:125:57
  reg         rrd_rs3_data_1_REG;	// register-read.scala:126:57
  always @(posedge clock) begin
    automatic logic rrd_kill;	// register-read.scala:130:28
    automatic logic rrd_kill_1;	// register-read.scala:130:28
    rrd_kill = io_kill | (|(io_brupdate_b1_mispredict_mask & rrd_uops_0_REG_br_mask));	// register-read.scala:86:29, :130:28, util.scala:118:{51,59}
    rrd_kill_1 = io_kill | (|(io_brupdate_b1_mispredict_mask & rrd_uops_1_REG_br_mask));	// register-read.scala:86:29, :130:28, util.scala:118:{51,59}
    if (reset) begin
      exe_reg_valids_0 <= 1'h0;	// register-read.scala:69:33
      exe_reg_valids_1 <= 1'h0;	// register-read.scala:69:33
    end
    else begin
      exe_reg_valids_0 <= ~rrd_kill & rrd_valids_0_REG;	// register-read.scala:69:33, :84:29, :130:28, :132:29
      exe_reg_valids_1 <= ~rrd_kill_1 & rrd_valids_1_REG;	// register-read.scala:69:33, :84:29, :130:28, :132:29
    end
    if (rrd_kill) begin	// register-read.scala:130:28
      exe_reg_uops_0_uopc <= 7'h0;	// register-read.scala:70:29
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
      exe_reg_uops_0_rob_idx <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_0_ldq_idx <= 5'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_stq_idx <= 5'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_rxq_idx <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_0_pdst <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_0_prs1 <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_0_prs2 <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_0_prs3 <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_0_ppred <= 6'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_0_stale_pdst <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_0_exc_cause <= 64'h0;	// consts.scala:270:20, register-read.scala:70:29
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
    exe_reg_uops_0_iw_p1_poisoned <= ~rrd_kill & rrd_uops_0_REG_iw_p1_poisoned;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_0_iw_p2_poisoned <= ~rrd_kill & rrd_uops_0_REG_iw_p2_poisoned;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
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
      exe_reg_uops_1_rob_idx <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_1_ldq_idx <= 5'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_stq_idx <= 5'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_rxq_idx <= 2'h0;	// consts.scala:270:20, register-read.scala:70:29
      exe_reg_uops_1_pdst <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_1_prs1 <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_1_prs2 <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_1_prs3 <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_1_ppred <= 6'h0;	// register-read.scala:70:29, :103:21
      exe_reg_uops_1_stale_pdst <= 7'h0;	// register-read.scala:70:29
      exe_reg_uops_1_exc_cause <= 64'h0;	// consts.scala:270:20, register-read.scala:70:29
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
    exe_reg_uops_1_iw_p1_poisoned <= ~rrd_kill_1 & rrd_uops_1_REG_iw_p1_poisoned;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
    exe_reg_uops_1_iw_p2_poisoned <= ~rrd_kill_1 & rrd_uops_1_REG_iw_p2_poisoned;	// register-read.scala:70:29, :86:29, :130:28, :132:29, :134:29
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
    if (rrd_rs1_data_0_REG)	// register-read.scala:124:57
      exe_reg_rs1_data_0 <= 65'h0;	// Mux.scala:98:16, register-read.scala:71:29
    else	// register-read.scala:124:57
      exe_reg_rs1_data_0 <= io_rf_read_ports_0_data;	// register-read.scala:71:29
    if (rrd_rs1_data_1_REG)	// register-read.scala:124:57
      exe_reg_rs1_data_1 <= 65'h0;	// Mux.scala:98:16, register-read.scala:71:29
    else	// register-read.scala:124:57
      exe_reg_rs1_data_1 <= io_rf_read_ports_3_data;	// register-read.scala:71:29
    if (rrd_rs2_data_0_REG)	// register-read.scala:125:57
      exe_reg_rs2_data_0 <= 65'h0;	// Mux.scala:98:16, register-read.scala:72:29
    else	// register-read.scala:125:57
      exe_reg_rs2_data_0 <= io_rf_read_ports_1_data;	// register-read.scala:72:29
    if (rrd_rs2_data_1_REG)	// register-read.scala:125:57
      exe_reg_rs2_data_1 <= 65'h0;	// Mux.scala:98:16, register-read.scala:72:29
    else	// register-read.scala:125:57
      exe_reg_rs2_data_1 <= io_rf_read_ports_4_data;	// register-read.scala:72:29
    if (rrd_rs3_data_0_REG)	// register-read.scala:126:57
      exe_reg_rs3_data_0 <= 65'h0;	// Mux.scala:98:16, register-read.scala:73:29
    else	// register-read.scala:126:57
      exe_reg_rs3_data_0 <= io_rf_read_ports_2_data;	// register-read.scala:73:29
    if (rrd_rs3_data_1_REG)	// register-read.scala:126:57
      exe_reg_rs3_data_1 <= 65'h0;	// Mux.scala:98:16, register-read.scala:73:29
    else	// register-read.scala:126:57
      exe_reg_rs3_data_1 <= io_rf_read_ports_5_data;	// register-read.scala:73:29
    rrd_valids_0_REG <=
      _rrd_decode_unit_io_rrd_valid
      & (io_brupdate_b1_mispredict_mask & _rrd_decode_unit_io_rrd_uop_br_mask) == 20'h0;	// consts.scala:270:20, register-read.scala:80:33, :84:{29,59}, util.scala:118:{51,59}
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
    rrd_uops_0_REG_iw_p1_poisoned <= _rrd_decode_unit_io_rrd_uop_iw_p1_poisoned;	// register-read.scala:80:33, :86:29
    rrd_uops_0_REG_iw_p2_poisoned <= _rrd_decode_unit_io_rrd_uop_iw_p2_poisoned;	// register-read.scala:80:33, :86:29
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
      & (io_brupdate_b1_mispredict_mask & _rrd_decode_unit_1_io_rrd_uop_br_mask) == 20'h0;	// consts.scala:270:20, register-read.scala:80:33, :84:{29,59}, util.scala:118:{51,59}
    rrd_uops_1_REG_uopc <= _rrd_decode_unit_1_io_rrd_uop_uopc;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_inst <= _rrd_decode_unit_1_io_rrd_uop_inst;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_debug_inst <= _rrd_decode_unit_1_io_rrd_uop_debug_inst;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_is_rvc <= _rrd_decode_unit_1_io_rrd_uop_is_rvc;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_debug_pc <= _rrd_decode_unit_1_io_rrd_uop_debug_pc;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_iq_type <= _rrd_decode_unit_1_io_rrd_uop_iq_type;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_fu_code <= _rrd_decode_unit_1_io_rrd_uop_fu_code;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_ctrl_br_type <= _rrd_decode_unit_1_io_rrd_uop_ctrl_br_type;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_ctrl_op1_sel <= _rrd_decode_unit_1_io_rrd_uop_ctrl_op1_sel;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_ctrl_op2_sel <= _rrd_decode_unit_1_io_rrd_uop_ctrl_op2_sel;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_ctrl_imm_sel <= _rrd_decode_unit_1_io_rrd_uop_ctrl_imm_sel;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_ctrl_op_fcn <= _rrd_decode_unit_1_io_rrd_uop_ctrl_op_fcn;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_ctrl_fcn_dw <= _rrd_decode_unit_1_io_rrd_uop_ctrl_fcn_dw;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_ctrl_is_load <= _rrd_decode_unit_1_io_rrd_uop_ctrl_is_load;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_ctrl_is_sta <= _rrd_decode_unit_1_io_rrd_uop_ctrl_is_sta;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_ctrl_is_std <= _rrd_decode_unit_1_io_rrd_uop_ctrl_is_std;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_iw_state <= _rrd_decode_unit_1_io_rrd_uop_iw_state;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_iw_p1_poisoned <= _rrd_decode_unit_1_io_rrd_uop_iw_p1_poisoned;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_iw_p2_poisoned <= _rrd_decode_unit_1_io_rrd_uop_iw_p2_poisoned;	// register-read.scala:80:33, :86:29
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
    rrd_uops_1_REG_csr_addr <= _rrd_decode_unit_1_io_rrd_uop_csr_addr;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_rob_idx <= _rrd_decode_unit_1_io_rrd_uop_rob_idx;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_ldq_idx <= _rrd_decode_unit_1_io_rrd_uop_ldq_idx;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_stq_idx <= _rrd_decode_unit_1_io_rrd_uop_stq_idx;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_rxq_idx <= _rrd_decode_unit_1_io_rrd_uop_rxq_idx;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_pdst <= _rrd_decode_unit_1_io_rrd_uop_pdst;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_prs1 <= _rrd_decode_unit_1_io_rrd_uop_prs1;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_prs2 <= _rrd_decode_unit_1_io_rrd_uop_prs2;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_prs3 <= _rrd_decode_unit_1_io_rrd_uop_prs3;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_ppred <= _rrd_decode_unit_1_io_rrd_uop_ppred;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_prs1_busy <= _rrd_decode_unit_1_io_rrd_uop_prs1_busy;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_prs2_busy <= _rrd_decode_unit_1_io_rrd_uop_prs2_busy;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_prs3_busy <= _rrd_decode_unit_1_io_rrd_uop_prs3_busy;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_ppred_busy <= _rrd_decode_unit_1_io_rrd_uop_ppred_busy;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_stale_pdst <= _rrd_decode_unit_1_io_rrd_uop_stale_pdst;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_exception <= _rrd_decode_unit_1_io_rrd_uop_exception;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_exc_cause <= _rrd_decode_unit_1_io_rrd_uop_exc_cause;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_bypassable <= _rrd_decode_unit_1_io_rrd_uop_bypassable;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_mem_cmd <= _rrd_decode_unit_1_io_rrd_uop_mem_cmd;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_mem_size <= _rrd_decode_unit_1_io_rrd_uop_mem_size;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_mem_signed <= _rrd_decode_unit_1_io_rrd_uop_mem_signed;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_is_fence <= _rrd_decode_unit_1_io_rrd_uop_is_fence;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_is_fencei <= _rrd_decode_unit_1_io_rrd_uop_is_fencei;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_is_amo <= _rrd_decode_unit_1_io_rrd_uop_is_amo;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_uses_ldq <= _rrd_decode_unit_1_io_rrd_uop_uses_ldq;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_uses_stq <= _rrd_decode_unit_1_io_rrd_uop_uses_stq;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_is_sys_pc2epc <= _rrd_decode_unit_1_io_rrd_uop_is_sys_pc2epc;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_is_unique <= _rrd_decode_unit_1_io_rrd_uop_is_unique;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_flush_on_commit <= _rrd_decode_unit_1_io_rrd_uop_flush_on_commit;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_ldst_is_rs1 <= _rrd_decode_unit_1_io_rrd_uop_ldst_is_rs1;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_ldst <= _rrd_decode_unit_1_io_rrd_uop_ldst;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_lrs1 <= _rrd_decode_unit_1_io_rrd_uop_lrs1;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_lrs2 <= _rrd_decode_unit_1_io_rrd_uop_lrs2;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_lrs3 <= _rrd_decode_unit_1_io_rrd_uop_lrs3;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_ldst_val <= _rrd_decode_unit_1_io_rrd_uop_ldst_val;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_dst_rtype <= _rrd_decode_unit_1_io_rrd_uop_dst_rtype;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_lrs1_rtype <= _rrd_decode_unit_1_io_rrd_uop_lrs1_rtype;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_lrs2_rtype <= _rrd_decode_unit_1_io_rrd_uop_lrs2_rtype;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_frs3_en <= _rrd_decode_unit_1_io_rrd_uop_frs3_en;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_fp_val <= _rrd_decode_unit_1_io_rrd_uop_fp_val;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_fp_single <= _rrd_decode_unit_1_io_rrd_uop_fp_single;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_xcpt_pf_if <= _rrd_decode_unit_1_io_rrd_uop_xcpt_pf_if;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_xcpt_ae_if <= _rrd_decode_unit_1_io_rrd_uop_xcpt_ae_if;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_xcpt_ma_if <= _rrd_decode_unit_1_io_rrd_uop_xcpt_ma_if;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_bp_debug_if <= _rrd_decode_unit_1_io_rrd_uop_bp_debug_if;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_bp_xcpt_if <= _rrd_decode_unit_1_io_rrd_uop_bp_xcpt_if;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_debug_fsrc <= _rrd_decode_unit_1_io_rrd_uop_debug_fsrc;	// register-read.scala:80:33, :86:29
    rrd_uops_1_REG_debug_tsrc <= _rrd_decode_unit_1_io_rrd_uop_debug_tsrc;	// register-read.scala:80:33, :86:29
    rrd_rs1_data_0_REG <= io_iss_uops_0_prs1 == 7'h0;	// register-read.scala:124:{57,67}
    rrd_rs2_data_0_REG <= io_iss_uops_0_prs2 == 7'h0;	// register-read.scala:125:{57,67}
    rrd_rs3_data_0_REG <= io_iss_uops_0_prs3 == 7'h0;	// register-read.scala:126:{57,67}
    rrd_rs1_data_1_REG <= io_iss_uops_1_prs1 == 7'h0;	// register-read.scala:124:{57,67}
    rrd_rs2_data_1_REG <= io_iss_uops_1_prs2 == 7'h0;	// register-read.scala:125:{57,67}
    rrd_rs3_data_1_REG <= io_iss_uops_1_prs3 == 7'h0;	// register-read.scala:126:{57,67}
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:64];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [6:0] i = 7'h0; i < 7'h41; i += 7'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        exe_reg_valids_0 = _RANDOM[7'h0][0];	// register-read.scala:69:33
        exe_reg_valids_1 = _RANDOM[7'h0][1];	// register-read.scala:69:33
        exe_reg_uops_0_uopc = _RANDOM[7'h0][8:2];	// register-read.scala:69:33, :70:29
        exe_reg_uops_0_inst = {_RANDOM[7'h0][31:9], _RANDOM[7'h1][8:0]};	// register-read.scala:69:33, :70:29
        exe_reg_uops_0_debug_inst = {_RANDOM[7'h1][31:9], _RANDOM[7'h2][8:0]};	// register-read.scala:70:29
        exe_reg_uops_0_is_rvc = _RANDOM[7'h2][9];	// register-read.scala:70:29
        exe_reg_uops_0_debug_pc = {_RANDOM[7'h2][31:10], _RANDOM[7'h3][17:0]};	// register-read.scala:70:29
        exe_reg_uops_0_iq_type = _RANDOM[7'h3][20:18];	// register-read.scala:70:29
        exe_reg_uops_0_fu_code = _RANDOM[7'h3][30:21];	// register-read.scala:70:29
        exe_reg_uops_0_ctrl_br_type = {_RANDOM[7'h3][31], _RANDOM[7'h4][2:0]};	// register-read.scala:70:29
        exe_reg_uops_0_ctrl_op1_sel = _RANDOM[7'h4][4:3];	// register-read.scala:70:29
        exe_reg_uops_0_ctrl_op2_sel = _RANDOM[7'h4][7:5];	// register-read.scala:70:29
        exe_reg_uops_0_ctrl_imm_sel = _RANDOM[7'h4][10:8];	// register-read.scala:70:29
        exe_reg_uops_0_ctrl_op_fcn = _RANDOM[7'h4][14:11];	// register-read.scala:70:29
        exe_reg_uops_0_ctrl_fcn_dw = _RANDOM[7'h4][15];	// register-read.scala:70:29
        exe_reg_uops_0_ctrl_is_load = _RANDOM[7'h4][19];	// register-read.scala:70:29
        exe_reg_uops_0_ctrl_is_sta = _RANDOM[7'h4][20];	// register-read.scala:70:29
        exe_reg_uops_0_ctrl_is_std = _RANDOM[7'h4][21];	// register-read.scala:70:29
        exe_reg_uops_0_iw_state = _RANDOM[7'h4][23:22];	// register-read.scala:70:29
        exe_reg_uops_0_iw_p1_poisoned = _RANDOM[7'h4][24];	// register-read.scala:70:29
        exe_reg_uops_0_iw_p2_poisoned = _RANDOM[7'h4][25];	// register-read.scala:70:29
        exe_reg_uops_0_is_br = _RANDOM[7'h4][26];	// register-read.scala:70:29
        exe_reg_uops_0_is_jalr = _RANDOM[7'h4][27];	// register-read.scala:70:29
        exe_reg_uops_0_is_jal = _RANDOM[7'h4][28];	// register-read.scala:70:29
        exe_reg_uops_0_is_sfb = _RANDOM[7'h4][29];	// register-read.scala:70:29
        exe_reg_uops_0_br_mask = {_RANDOM[7'h4][31:30], _RANDOM[7'h5][17:0]};	// register-read.scala:70:29
        exe_reg_uops_0_br_tag = _RANDOM[7'h5][22:18];	// register-read.scala:70:29
        exe_reg_uops_0_ftq_idx = _RANDOM[7'h5][28:23];	// register-read.scala:70:29
        exe_reg_uops_0_edge_inst = _RANDOM[7'h5][29];	// register-read.scala:70:29
        exe_reg_uops_0_pc_lob = {_RANDOM[7'h5][31:30], _RANDOM[7'h6][3:0]};	// register-read.scala:70:29
        exe_reg_uops_0_taken = _RANDOM[7'h6][4];	// register-read.scala:70:29
        exe_reg_uops_0_imm_packed = _RANDOM[7'h6][24:5];	// register-read.scala:70:29
        exe_reg_uops_0_csr_addr = {_RANDOM[7'h6][31:25], _RANDOM[7'h7][4:0]};	// register-read.scala:70:29
        exe_reg_uops_0_rob_idx = _RANDOM[7'h7][11:5];	// register-read.scala:70:29
        exe_reg_uops_0_ldq_idx = _RANDOM[7'h7][16:12];	// register-read.scala:70:29
        exe_reg_uops_0_stq_idx = _RANDOM[7'h7][21:17];	// register-read.scala:70:29
        exe_reg_uops_0_rxq_idx = _RANDOM[7'h7][23:22];	// register-read.scala:70:29
        exe_reg_uops_0_pdst = _RANDOM[7'h7][30:24];	// register-read.scala:70:29
        exe_reg_uops_0_prs1 = {_RANDOM[7'h7][31], _RANDOM[7'h8][5:0]};	// register-read.scala:70:29
        exe_reg_uops_0_prs2 = _RANDOM[7'h8][12:6];	// register-read.scala:70:29
        exe_reg_uops_0_prs3 = _RANDOM[7'h8][19:13];	// register-read.scala:70:29
        exe_reg_uops_0_ppred = _RANDOM[7'h8][25:20];	// register-read.scala:70:29
        exe_reg_uops_0_prs1_busy = _RANDOM[7'h8][26];	// register-read.scala:70:29
        exe_reg_uops_0_prs2_busy = _RANDOM[7'h8][27];	// register-read.scala:70:29
        exe_reg_uops_0_prs3_busy = _RANDOM[7'h8][28];	// register-read.scala:70:29
        exe_reg_uops_0_ppred_busy = _RANDOM[7'h8][29];	// register-read.scala:70:29
        exe_reg_uops_0_stale_pdst = {_RANDOM[7'h8][31:30], _RANDOM[7'h9][4:0]};	// register-read.scala:70:29
        exe_reg_uops_0_exception = _RANDOM[7'h9][5];	// register-read.scala:70:29
        exe_reg_uops_0_exc_cause =
          {_RANDOM[7'h9][31:6], _RANDOM[7'hA], _RANDOM[7'hB][5:0]};	// register-read.scala:70:29
        exe_reg_uops_0_bypassable = _RANDOM[7'hB][6];	// register-read.scala:70:29
        exe_reg_uops_0_mem_cmd = _RANDOM[7'hB][11:7];	// register-read.scala:70:29
        exe_reg_uops_0_mem_size = _RANDOM[7'hB][13:12];	// register-read.scala:70:29
        exe_reg_uops_0_mem_signed = _RANDOM[7'hB][14];	// register-read.scala:70:29
        exe_reg_uops_0_is_fence = _RANDOM[7'hB][15];	// register-read.scala:70:29
        exe_reg_uops_0_is_fencei = _RANDOM[7'hB][16];	// register-read.scala:70:29
        exe_reg_uops_0_is_amo = _RANDOM[7'hB][17];	// register-read.scala:70:29
        exe_reg_uops_0_uses_ldq = _RANDOM[7'hB][18];	// register-read.scala:70:29
        exe_reg_uops_0_uses_stq = _RANDOM[7'hB][19];	// register-read.scala:70:29
        exe_reg_uops_0_is_sys_pc2epc = _RANDOM[7'hB][20];	// register-read.scala:70:29
        exe_reg_uops_0_is_unique = _RANDOM[7'hB][21];	// register-read.scala:70:29
        exe_reg_uops_0_flush_on_commit = _RANDOM[7'hB][22];	// register-read.scala:70:29
        exe_reg_uops_0_ldst_is_rs1 = _RANDOM[7'hB][23];	// register-read.scala:70:29
        exe_reg_uops_0_ldst = _RANDOM[7'hB][29:24];	// register-read.scala:70:29
        exe_reg_uops_0_lrs1 = {_RANDOM[7'hB][31:30], _RANDOM[7'hC][3:0]};	// register-read.scala:70:29
        exe_reg_uops_0_lrs2 = _RANDOM[7'hC][9:4];	// register-read.scala:70:29
        exe_reg_uops_0_lrs3 = _RANDOM[7'hC][15:10];	// register-read.scala:70:29
        exe_reg_uops_0_ldst_val = _RANDOM[7'hC][16];	// register-read.scala:70:29
        exe_reg_uops_0_dst_rtype = _RANDOM[7'hC][18:17];	// register-read.scala:70:29
        exe_reg_uops_0_lrs1_rtype = _RANDOM[7'hC][20:19];	// register-read.scala:70:29
        exe_reg_uops_0_lrs2_rtype = _RANDOM[7'hC][22:21];	// register-read.scala:70:29
        exe_reg_uops_0_frs3_en = _RANDOM[7'hC][23];	// register-read.scala:70:29
        exe_reg_uops_0_fp_val = _RANDOM[7'hC][24];	// register-read.scala:70:29
        exe_reg_uops_0_fp_single = _RANDOM[7'hC][25];	// register-read.scala:70:29
        exe_reg_uops_0_xcpt_pf_if = _RANDOM[7'hC][26];	// register-read.scala:70:29
        exe_reg_uops_0_xcpt_ae_if = _RANDOM[7'hC][27];	// register-read.scala:70:29
        exe_reg_uops_0_xcpt_ma_if = _RANDOM[7'hC][28];	// register-read.scala:70:29
        exe_reg_uops_0_bp_debug_if = _RANDOM[7'hC][29];	// register-read.scala:70:29
        exe_reg_uops_0_bp_xcpt_if = _RANDOM[7'hC][30];	// register-read.scala:70:29
        exe_reg_uops_0_debug_fsrc = {_RANDOM[7'hC][31], _RANDOM[7'hD][0]};	// register-read.scala:70:29
        exe_reg_uops_0_debug_tsrc = _RANDOM[7'hD][2:1];	// register-read.scala:70:29
        exe_reg_uops_1_uopc = _RANDOM[7'hD][9:3];	// register-read.scala:70:29
        exe_reg_uops_1_inst = {_RANDOM[7'hD][31:10], _RANDOM[7'hE][9:0]};	// register-read.scala:70:29
        exe_reg_uops_1_debug_inst = {_RANDOM[7'hE][31:10], _RANDOM[7'hF][9:0]};	// register-read.scala:70:29
        exe_reg_uops_1_is_rvc = _RANDOM[7'hF][10];	// register-read.scala:70:29
        exe_reg_uops_1_debug_pc = {_RANDOM[7'hF][31:11], _RANDOM[7'h10][18:0]};	// register-read.scala:70:29
        exe_reg_uops_1_iq_type = _RANDOM[7'h10][21:19];	// register-read.scala:70:29
        exe_reg_uops_1_fu_code = _RANDOM[7'h10][31:22];	// register-read.scala:70:29
        exe_reg_uops_1_ctrl_br_type = _RANDOM[7'h11][3:0];	// register-read.scala:70:29
        exe_reg_uops_1_ctrl_op1_sel = _RANDOM[7'h11][5:4];	// register-read.scala:70:29
        exe_reg_uops_1_ctrl_op2_sel = _RANDOM[7'h11][8:6];	// register-read.scala:70:29
        exe_reg_uops_1_ctrl_imm_sel = _RANDOM[7'h11][11:9];	// register-read.scala:70:29
        exe_reg_uops_1_ctrl_op_fcn = _RANDOM[7'h11][15:12];	// register-read.scala:70:29
        exe_reg_uops_1_ctrl_fcn_dw = _RANDOM[7'h11][16];	// register-read.scala:70:29
        exe_reg_uops_1_ctrl_is_load = _RANDOM[7'h11][20];	// register-read.scala:70:29
        exe_reg_uops_1_ctrl_is_sta = _RANDOM[7'h11][21];	// register-read.scala:70:29
        exe_reg_uops_1_ctrl_is_std = _RANDOM[7'h11][22];	// register-read.scala:70:29
        exe_reg_uops_1_iw_state = _RANDOM[7'h11][24:23];	// register-read.scala:70:29
        exe_reg_uops_1_iw_p1_poisoned = _RANDOM[7'h11][25];	// register-read.scala:70:29
        exe_reg_uops_1_iw_p2_poisoned = _RANDOM[7'h11][26];	// register-read.scala:70:29
        exe_reg_uops_1_is_br = _RANDOM[7'h11][27];	// register-read.scala:70:29
        exe_reg_uops_1_is_jalr = _RANDOM[7'h11][28];	// register-read.scala:70:29
        exe_reg_uops_1_is_jal = _RANDOM[7'h11][29];	// register-read.scala:70:29
        exe_reg_uops_1_is_sfb = _RANDOM[7'h11][30];	// register-read.scala:70:29
        exe_reg_uops_1_br_mask = {_RANDOM[7'h11][31], _RANDOM[7'h12][18:0]};	// register-read.scala:70:29
        exe_reg_uops_1_br_tag = _RANDOM[7'h12][23:19];	// register-read.scala:70:29
        exe_reg_uops_1_ftq_idx = _RANDOM[7'h12][29:24];	// register-read.scala:70:29
        exe_reg_uops_1_edge_inst = _RANDOM[7'h12][30];	// register-read.scala:70:29
        exe_reg_uops_1_pc_lob = {_RANDOM[7'h12][31], _RANDOM[7'h13][4:0]};	// register-read.scala:70:29
        exe_reg_uops_1_taken = _RANDOM[7'h13][5];	// register-read.scala:70:29
        exe_reg_uops_1_imm_packed = _RANDOM[7'h13][25:6];	// register-read.scala:70:29
        exe_reg_uops_1_csr_addr = {_RANDOM[7'h13][31:26], _RANDOM[7'h14][5:0]};	// register-read.scala:70:29
        exe_reg_uops_1_rob_idx = _RANDOM[7'h14][12:6];	// register-read.scala:70:29
        exe_reg_uops_1_ldq_idx = _RANDOM[7'h14][17:13];	// register-read.scala:70:29
        exe_reg_uops_1_stq_idx = _RANDOM[7'h14][22:18];	// register-read.scala:70:29
        exe_reg_uops_1_rxq_idx = _RANDOM[7'h14][24:23];	// register-read.scala:70:29
        exe_reg_uops_1_pdst = _RANDOM[7'h14][31:25];	// register-read.scala:70:29
        exe_reg_uops_1_prs1 = _RANDOM[7'h15][6:0];	// register-read.scala:70:29
        exe_reg_uops_1_prs2 = _RANDOM[7'h15][13:7];	// register-read.scala:70:29
        exe_reg_uops_1_prs3 = _RANDOM[7'h15][20:14];	// register-read.scala:70:29
        exe_reg_uops_1_ppred = _RANDOM[7'h15][26:21];	// register-read.scala:70:29
        exe_reg_uops_1_prs1_busy = _RANDOM[7'h15][27];	// register-read.scala:70:29
        exe_reg_uops_1_prs2_busy = _RANDOM[7'h15][28];	// register-read.scala:70:29
        exe_reg_uops_1_prs3_busy = _RANDOM[7'h15][29];	// register-read.scala:70:29
        exe_reg_uops_1_ppred_busy = _RANDOM[7'h15][30];	// register-read.scala:70:29
        exe_reg_uops_1_stale_pdst = {_RANDOM[7'h15][31], _RANDOM[7'h16][5:0]};	// register-read.scala:70:29
        exe_reg_uops_1_exception = _RANDOM[7'h16][6];	// register-read.scala:70:29
        exe_reg_uops_1_exc_cause =
          {_RANDOM[7'h16][31:7], _RANDOM[7'h17], _RANDOM[7'h18][6:0]};	// register-read.scala:70:29
        exe_reg_uops_1_bypassable = _RANDOM[7'h18][7];	// register-read.scala:70:29
        exe_reg_uops_1_mem_cmd = _RANDOM[7'h18][12:8];	// register-read.scala:70:29
        exe_reg_uops_1_mem_size = _RANDOM[7'h18][14:13];	// register-read.scala:70:29
        exe_reg_uops_1_mem_signed = _RANDOM[7'h18][15];	// register-read.scala:70:29
        exe_reg_uops_1_is_fence = _RANDOM[7'h18][16];	// register-read.scala:70:29
        exe_reg_uops_1_is_fencei = _RANDOM[7'h18][17];	// register-read.scala:70:29
        exe_reg_uops_1_is_amo = _RANDOM[7'h18][18];	// register-read.scala:70:29
        exe_reg_uops_1_uses_ldq = _RANDOM[7'h18][19];	// register-read.scala:70:29
        exe_reg_uops_1_uses_stq = _RANDOM[7'h18][20];	// register-read.scala:70:29
        exe_reg_uops_1_is_sys_pc2epc = _RANDOM[7'h18][21];	// register-read.scala:70:29
        exe_reg_uops_1_is_unique = _RANDOM[7'h18][22];	// register-read.scala:70:29
        exe_reg_uops_1_flush_on_commit = _RANDOM[7'h18][23];	// register-read.scala:70:29
        exe_reg_uops_1_ldst_is_rs1 = _RANDOM[7'h18][24];	// register-read.scala:70:29
        exe_reg_uops_1_ldst = _RANDOM[7'h18][30:25];	// register-read.scala:70:29
        exe_reg_uops_1_lrs1 = {_RANDOM[7'h18][31], _RANDOM[7'h19][4:0]};	// register-read.scala:70:29
        exe_reg_uops_1_lrs2 = _RANDOM[7'h19][10:5];	// register-read.scala:70:29
        exe_reg_uops_1_lrs3 = _RANDOM[7'h19][16:11];	// register-read.scala:70:29
        exe_reg_uops_1_ldst_val = _RANDOM[7'h19][17];	// register-read.scala:70:29
        exe_reg_uops_1_dst_rtype = _RANDOM[7'h19][19:18];	// register-read.scala:70:29
        exe_reg_uops_1_lrs1_rtype = _RANDOM[7'h19][21:20];	// register-read.scala:70:29
        exe_reg_uops_1_lrs2_rtype = _RANDOM[7'h19][23:22];	// register-read.scala:70:29
        exe_reg_uops_1_frs3_en = _RANDOM[7'h19][24];	// register-read.scala:70:29
        exe_reg_uops_1_fp_val = _RANDOM[7'h19][25];	// register-read.scala:70:29
        exe_reg_uops_1_fp_single = _RANDOM[7'h19][26];	// register-read.scala:70:29
        exe_reg_uops_1_xcpt_pf_if = _RANDOM[7'h19][27];	// register-read.scala:70:29
        exe_reg_uops_1_xcpt_ae_if = _RANDOM[7'h19][28];	// register-read.scala:70:29
        exe_reg_uops_1_xcpt_ma_if = _RANDOM[7'h19][29];	// register-read.scala:70:29
        exe_reg_uops_1_bp_debug_if = _RANDOM[7'h19][30];	// register-read.scala:70:29
        exe_reg_uops_1_bp_xcpt_if = _RANDOM[7'h19][31];	// register-read.scala:70:29
        exe_reg_uops_1_debug_fsrc = _RANDOM[7'h1A][1:0];	// register-read.scala:70:29
        exe_reg_uops_1_debug_tsrc = _RANDOM[7'h1A][3:2];	// register-read.scala:70:29
        exe_reg_rs1_data_0 = {_RANDOM[7'h1A][31:4], _RANDOM[7'h1B], _RANDOM[7'h1C][4:0]};	// register-read.scala:70:29, :71:29
        exe_reg_rs1_data_1 = {_RANDOM[7'h1C][31:5], _RANDOM[7'h1D], _RANDOM[7'h1E][5:0]};	// register-read.scala:71:29
        exe_reg_rs2_data_0 = {_RANDOM[7'h1E][31:6], _RANDOM[7'h1F], _RANDOM[7'h20][6:0]};	// register-read.scala:71:29, :72:29
        exe_reg_rs2_data_1 = {_RANDOM[7'h20][31:7], _RANDOM[7'h21], _RANDOM[7'h22][7:0]};	// register-read.scala:72:29
        exe_reg_rs3_data_0 = {_RANDOM[7'h22][31:8], _RANDOM[7'h23], _RANDOM[7'h24][8:0]};	// register-read.scala:72:29, :73:29
        exe_reg_rs3_data_1 = {_RANDOM[7'h24][31:9], _RANDOM[7'h25], _RANDOM[7'h26][9:0]};	// register-read.scala:73:29
        rrd_valids_0_REG = _RANDOM[7'h26][12];	// register-read.scala:73:29, :84:29
        rrd_uops_0_REG_uopc = _RANDOM[7'h26][19:13];	// register-read.scala:73:29, :86:29
        rrd_uops_0_REG_inst = {_RANDOM[7'h26][31:20], _RANDOM[7'h27][19:0]};	// register-read.scala:73:29, :86:29
        rrd_uops_0_REG_debug_inst = {_RANDOM[7'h27][31:20], _RANDOM[7'h28][19:0]};	// register-read.scala:86:29
        rrd_uops_0_REG_is_rvc = _RANDOM[7'h28][20];	// register-read.scala:86:29
        rrd_uops_0_REG_debug_pc = {_RANDOM[7'h28][31:21], _RANDOM[7'h29][28:0]};	// register-read.scala:86:29
        rrd_uops_0_REG_iq_type = _RANDOM[7'h29][31:29];	// register-read.scala:86:29
        rrd_uops_0_REG_fu_code = _RANDOM[7'h2A][9:0];	// register-read.scala:86:29
        rrd_uops_0_REG_ctrl_br_type = _RANDOM[7'h2A][13:10];	// register-read.scala:86:29
        rrd_uops_0_REG_ctrl_op1_sel = _RANDOM[7'h2A][15:14];	// register-read.scala:86:29
        rrd_uops_0_REG_ctrl_op2_sel = _RANDOM[7'h2A][18:16];	// register-read.scala:86:29
        rrd_uops_0_REG_ctrl_imm_sel = _RANDOM[7'h2A][21:19];	// register-read.scala:86:29
        rrd_uops_0_REG_ctrl_op_fcn = _RANDOM[7'h2A][25:22];	// register-read.scala:86:29
        rrd_uops_0_REG_ctrl_fcn_dw = _RANDOM[7'h2A][26];	// register-read.scala:86:29
        rrd_uops_0_REG_ctrl_is_load = _RANDOM[7'h2A][30];	// register-read.scala:86:29
        rrd_uops_0_REG_ctrl_is_sta = _RANDOM[7'h2A][31];	// register-read.scala:86:29
        rrd_uops_0_REG_ctrl_is_std = _RANDOM[7'h2B][0];	// register-read.scala:86:29
        rrd_uops_0_REG_iw_state = _RANDOM[7'h2B][2:1];	// register-read.scala:86:29
        rrd_uops_0_REG_iw_p1_poisoned = _RANDOM[7'h2B][3];	// register-read.scala:86:29
        rrd_uops_0_REG_iw_p2_poisoned = _RANDOM[7'h2B][4];	// register-read.scala:86:29
        rrd_uops_0_REG_is_br = _RANDOM[7'h2B][5];	// register-read.scala:86:29
        rrd_uops_0_REG_is_jalr = _RANDOM[7'h2B][6];	// register-read.scala:86:29
        rrd_uops_0_REG_is_jal = _RANDOM[7'h2B][7];	// register-read.scala:86:29
        rrd_uops_0_REG_is_sfb = _RANDOM[7'h2B][8];	// register-read.scala:86:29
        rrd_uops_0_REG_br_mask = _RANDOM[7'h2B][28:9];	// register-read.scala:86:29
        rrd_uops_0_REG_br_tag = {_RANDOM[7'h2B][31:29], _RANDOM[7'h2C][1:0]};	// register-read.scala:86:29
        rrd_uops_0_REG_ftq_idx = _RANDOM[7'h2C][7:2];	// register-read.scala:86:29
        rrd_uops_0_REG_edge_inst = _RANDOM[7'h2C][8];	// register-read.scala:86:29
        rrd_uops_0_REG_pc_lob = _RANDOM[7'h2C][14:9];	// register-read.scala:86:29
        rrd_uops_0_REG_taken = _RANDOM[7'h2C][15];	// register-read.scala:86:29
        rrd_uops_0_REG_imm_packed = {_RANDOM[7'h2C][31:16], _RANDOM[7'h2D][3:0]};	// register-read.scala:86:29
        rrd_uops_0_REG_csr_addr = _RANDOM[7'h2D][15:4];	// register-read.scala:86:29
        rrd_uops_0_REG_rob_idx = _RANDOM[7'h2D][22:16];	// register-read.scala:86:29
        rrd_uops_0_REG_ldq_idx = _RANDOM[7'h2D][27:23];	// register-read.scala:86:29
        rrd_uops_0_REG_stq_idx = {_RANDOM[7'h2D][31:28], _RANDOM[7'h2E][0]};	// register-read.scala:86:29
        rrd_uops_0_REG_rxq_idx = _RANDOM[7'h2E][2:1];	// register-read.scala:86:29
        rrd_uops_0_REG_pdst = _RANDOM[7'h2E][9:3];	// register-read.scala:86:29
        rrd_uops_0_REG_prs1 = _RANDOM[7'h2E][16:10];	// register-read.scala:86:29
        rrd_uops_0_REG_prs2 = _RANDOM[7'h2E][23:17];	// register-read.scala:86:29
        rrd_uops_0_REG_prs3 = _RANDOM[7'h2E][30:24];	// register-read.scala:86:29
        rrd_uops_0_REG_ppred = {_RANDOM[7'h2E][31], _RANDOM[7'h2F][4:0]};	// register-read.scala:86:29
        rrd_uops_0_REG_prs1_busy = _RANDOM[7'h2F][5];	// register-read.scala:86:29
        rrd_uops_0_REG_prs2_busy = _RANDOM[7'h2F][6];	// register-read.scala:86:29
        rrd_uops_0_REG_prs3_busy = _RANDOM[7'h2F][7];	// register-read.scala:86:29
        rrd_uops_0_REG_ppred_busy = _RANDOM[7'h2F][8];	// register-read.scala:86:29
        rrd_uops_0_REG_stale_pdst = _RANDOM[7'h2F][15:9];	// register-read.scala:86:29
        rrd_uops_0_REG_exception = _RANDOM[7'h2F][16];	// register-read.scala:86:29
        rrd_uops_0_REG_exc_cause =
          {_RANDOM[7'h2F][31:17], _RANDOM[7'h30], _RANDOM[7'h31][16:0]};	// register-read.scala:86:29
        rrd_uops_0_REG_bypassable = _RANDOM[7'h31][17];	// register-read.scala:86:29
        rrd_uops_0_REG_mem_cmd = _RANDOM[7'h31][22:18];	// register-read.scala:86:29
        rrd_uops_0_REG_mem_size = _RANDOM[7'h31][24:23];	// register-read.scala:86:29
        rrd_uops_0_REG_mem_signed = _RANDOM[7'h31][25];	// register-read.scala:86:29
        rrd_uops_0_REG_is_fence = _RANDOM[7'h31][26];	// register-read.scala:86:29
        rrd_uops_0_REG_is_fencei = _RANDOM[7'h31][27];	// register-read.scala:86:29
        rrd_uops_0_REG_is_amo = _RANDOM[7'h31][28];	// register-read.scala:86:29
        rrd_uops_0_REG_uses_ldq = _RANDOM[7'h31][29];	// register-read.scala:86:29
        rrd_uops_0_REG_uses_stq = _RANDOM[7'h31][30];	// register-read.scala:86:29
        rrd_uops_0_REG_is_sys_pc2epc = _RANDOM[7'h31][31];	// register-read.scala:86:29
        rrd_uops_0_REG_is_unique = _RANDOM[7'h32][0];	// register-read.scala:86:29
        rrd_uops_0_REG_flush_on_commit = _RANDOM[7'h32][1];	// register-read.scala:86:29
        rrd_uops_0_REG_ldst_is_rs1 = _RANDOM[7'h32][2];	// register-read.scala:86:29
        rrd_uops_0_REG_ldst = _RANDOM[7'h32][8:3];	// register-read.scala:86:29
        rrd_uops_0_REG_lrs1 = _RANDOM[7'h32][14:9];	// register-read.scala:86:29
        rrd_uops_0_REG_lrs2 = _RANDOM[7'h32][20:15];	// register-read.scala:86:29
        rrd_uops_0_REG_lrs3 = _RANDOM[7'h32][26:21];	// register-read.scala:86:29
        rrd_uops_0_REG_ldst_val = _RANDOM[7'h32][27];	// register-read.scala:86:29
        rrd_uops_0_REG_dst_rtype = _RANDOM[7'h32][29:28];	// register-read.scala:86:29
        rrd_uops_0_REG_lrs1_rtype = _RANDOM[7'h32][31:30];	// register-read.scala:86:29
        rrd_uops_0_REG_lrs2_rtype = _RANDOM[7'h33][1:0];	// register-read.scala:86:29
        rrd_uops_0_REG_frs3_en = _RANDOM[7'h33][2];	// register-read.scala:86:29
        rrd_uops_0_REG_fp_val = _RANDOM[7'h33][3];	// register-read.scala:86:29
        rrd_uops_0_REG_fp_single = _RANDOM[7'h33][4];	// register-read.scala:86:29
        rrd_uops_0_REG_xcpt_pf_if = _RANDOM[7'h33][5];	// register-read.scala:86:29
        rrd_uops_0_REG_xcpt_ae_if = _RANDOM[7'h33][6];	// register-read.scala:86:29
        rrd_uops_0_REG_xcpt_ma_if = _RANDOM[7'h33][7];	// register-read.scala:86:29
        rrd_uops_0_REG_bp_debug_if = _RANDOM[7'h33][8];	// register-read.scala:86:29
        rrd_uops_0_REG_bp_xcpt_if = _RANDOM[7'h33][9];	// register-read.scala:86:29
        rrd_uops_0_REG_debug_fsrc = _RANDOM[7'h33][11:10];	// register-read.scala:86:29
        rrd_uops_0_REG_debug_tsrc = _RANDOM[7'h33][13:12];	// register-read.scala:86:29
        rrd_valids_1_REG = _RANDOM[7'h33][14];	// register-read.scala:84:29, :86:29
        rrd_uops_1_REG_uopc = _RANDOM[7'h33][21:15];	// register-read.scala:86:29
        rrd_uops_1_REG_inst = {_RANDOM[7'h33][31:22], _RANDOM[7'h34][21:0]};	// register-read.scala:86:29
        rrd_uops_1_REG_debug_inst = {_RANDOM[7'h34][31:22], _RANDOM[7'h35][21:0]};	// register-read.scala:86:29
        rrd_uops_1_REG_is_rvc = _RANDOM[7'h35][22];	// register-read.scala:86:29
        rrd_uops_1_REG_debug_pc = {_RANDOM[7'h35][31:23], _RANDOM[7'h36][30:0]};	// register-read.scala:86:29
        rrd_uops_1_REG_iq_type = {_RANDOM[7'h36][31], _RANDOM[7'h37][1:0]};	// register-read.scala:86:29
        rrd_uops_1_REG_fu_code = _RANDOM[7'h37][11:2];	// register-read.scala:86:29
        rrd_uops_1_REG_ctrl_br_type = _RANDOM[7'h37][15:12];	// register-read.scala:86:29
        rrd_uops_1_REG_ctrl_op1_sel = _RANDOM[7'h37][17:16];	// register-read.scala:86:29
        rrd_uops_1_REG_ctrl_op2_sel = _RANDOM[7'h37][20:18];	// register-read.scala:86:29
        rrd_uops_1_REG_ctrl_imm_sel = _RANDOM[7'h37][23:21];	// register-read.scala:86:29
        rrd_uops_1_REG_ctrl_op_fcn = _RANDOM[7'h37][27:24];	// register-read.scala:86:29
        rrd_uops_1_REG_ctrl_fcn_dw = _RANDOM[7'h37][28];	// register-read.scala:86:29
        rrd_uops_1_REG_ctrl_is_load = _RANDOM[7'h38][0];	// register-read.scala:86:29
        rrd_uops_1_REG_ctrl_is_sta = _RANDOM[7'h38][1];	// register-read.scala:86:29
        rrd_uops_1_REG_ctrl_is_std = _RANDOM[7'h38][2];	// register-read.scala:86:29
        rrd_uops_1_REG_iw_state = _RANDOM[7'h38][4:3];	// register-read.scala:86:29
        rrd_uops_1_REG_iw_p1_poisoned = _RANDOM[7'h38][5];	// register-read.scala:86:29
        rrd_uops_1_REG_iw_p2_poisoned = _RANDOM[7'h38][6];	// register-read.scala:86:29
        rrd_uops_1_REG_is_br = _RANDOM[7'h38][7];	// register-read.scala:86:29
        rrd_uops_1_REG_is_jalr = _RANDOM[7'h38][8];	// register-read.scala:86:29
        rrd_uops_1_REG_is_jal = _RANDOM[7'h38][9];	// register-read.scala:86:29
        rrd_uops_1_REG_is_sfb = _RANDOM[7'h38][10];	// register-read.scala:86:29
        rrd_uops_1_REG_br_mask = _RANDOM[7'h38][30:11];	// register-read.scala:86:29
        rrd_uops_1_REG_br_tag = {_RANDOM[7'h38][31], _RANDOM[7'h39][3:0]};	// register-read.scala:86:29
        rrd_uops_1_REG_ftq_idx = _RANDOM[7'h39][9:4];	// register-read.scala:86:29
        rrd_uops_1_REG_edge_inst = _RANDOM[7'h39][10];	// register-read.scala:86:29
        rrd_uops_1_REG_pc_lob = _RANDOM[7'h39][16:11];	// register-read.scala:86:29
        rrd_uops_1_REG_taken = _RANDOM[7'h39][17];	// register-read.scala:86:29
        rrd_uops_1_REG_imm_packed = {_RANDOM[7'h39][31:18], _RANDOM[7'h3A][5:0]};	// register-read.scala:86:29
        rrd_uops_1_REG_csr_addr = _RANDOM[7'h3A][17:6];	// register-read.scala:86:29
        rrd_uops_1_REG_rob_idx = _RANDOM[7'h3A][24:18];	// register-read.scala:86:29
        rrd_uops_1_REG_ldq_idx = _RANDOM[7'h3A][29:25];	// register-read.scala:86:29
        rrd_uops_1_REG_stq_idx = {_RANDOM[7'h3A][31:30], _RANDOM[7'h3B][2:0]};	// register-read.scala:86:29
        rrd_uops_1_REG_rxq_idx = _RANDOM[7'h3B][4:3];	// register-read.scala:86:29
        rrd_uops_1_REG_pdst = _RANDOM[7'h3B][11:5];	// register-read.scala:86:29
        rrd_uops_1_REG_prs1 = _RANDOM[7'h3B][18:12];	// register-read.scala:86:29
        rrd_uops_1_REG_prs2 = _RANDOM[7'h3B][25:19];	// register-read.scala:86:29
        rrd_uops_1_REG_prs3 = {_RANDOM[7'h3B][31:26], _RANDOM[7'h3C][0]};	// register-read.scala:86:29
        rrd_uops_1_REG_ppred = _RANDOM[7'h3C][6:1];	// register-read.scala:86:29
        rrd_uops_1_REG_prs1_busy = _RANDOM[7'h3C][7];	// register-read.scala:86:29
        rrd_uops_1_REG_prs2_busy = _RANDOM[7'h3C][8];	// register-read.scala:86:29
        rrd_uops_1_REG_prs3_busy = _RANDOM[7'h3C][9];	// register-read.scala:86:29
        rrd_uops_1_REG_ppred_busy = _RANDOM[7'h3C][10];	// register-read.scala:86:29
        rrd_uops_1_REG_stale_pdst = _RANDOM[7'h3C][17:11];	// register-read.scala:86:29
        rrd_uops_1_REG_exception = _RANDOM[7'h3C][18];	// register-read.scala:86:29
        rrd_uops_1_REG_exc_cause =
          {_RANDOM[7'h3C][31:19], _RANDOM[7'h3D], _RANDOM[7'h3E][18:0]};	// register-read.scala:86:29
        rrd_uops_1_REG_bypassable = _RANDOM[7'h3E][19];	// register-read.scala:86:29
        rrd_uops_1_REG_mem_cmd = _RANDOM[7'h3E][24:20];	// register-read.scala:86:29
        rrd_uops_1_REG_mem_size = _RANDOM[7'h3E][26:25];	// register-read.scala:86:29
        rrd_uops_1_REG_mem_signed = _RANDOM[7'h3E][27];	// register-read.scala:86:29
        rrd_uops_1_REG_is_fence = _RANDOM[7'h3E][28];	// register-read.scala:86:29
        rrd_uops_1_REG_is_fencei = _RANDOM[7'h3E][29];	// register-read.scala:86:29
        rrd_uops_1_REG_is_amo = _RANDOM[7'h3E][30];	// register-read.scala:86:29
        rrd_uops_1_REG_uses_ldq = _RANDOM[7'h3E][31];	// register-read.scala:86:29
        rrd_uops_1_REG_uses_stq = _RANDOM[7'h3F][0];	// register-read.scala:86:29
        rrd_uops_1_REG_is_sys_pc2epc = _RANDOM[7'h3F][1];	// register-read.scala:86:29
        rrd_uops_1_REG_is_unique = _RANDOM[7'h3F][2];	// register-read.scala:86:29
        rrd_uops_1_REG_flush_on_commit = _RANDOM[7'h3F][3];	// register-read.scala:86:29
        rrd_uops_1_REG_ldst_is_rs1 = _RANDOM[7'h3F][4];	// register-read.scala:86:29
        rrd_uops_1_REG_ldst = _RANDOM[7'h3F][10:5];	// register-read.scala:86:29
        rrd_uops_1_REG_lrs1 = _RANDOM[7'h3F][16:11];	// register-read.scala:86:29
        rrd_uops_1_REG_lrs2 = _RANDOM[7'h3F][22:17];	// register-read.scala:86:29
        rrd_uops_1_REG_lrs3 = _RANDOM[7'h3F][28:23];	// register-read.scala:86:29
        rrd_uops_1_REG_ldst_val = _RANDOM[7'h3F][29];	// register-read.scala:86:29
        rrd_uops_1_REG_dst_rtype = _RANDOM[7'h3F][31:30];	// register-read.scala:86:29
        rrd_uops_1_REG_lrs1_rtype = _RANDOM[7'h40][1:0];	// register-read.scala:86:29
        rrd_uops_1_REG_lrs2_rtype = _RANDOM[7'h40][3:2];	// register-read.scala:86:29
        rrd_uops_1_REG_frs3_en = _RANDOM[7'h40][4];	// register-read.scala:86:29
        rrd_uops_1_REG_fp_val = _RANDOM[7'h40][5];	// register-read.scala:86:29
        rrd_uops_1_REG_fp_single = _RANDOM[7'h40][6];	// register-read.scala:86:29
        rrd_uops_1_REG_xcpt_pf_if = _RANDOM[7'h40][7];	// register-read.scala:86:29
        rrd_uops_1_REG_xcpt_ae_if = _RANDOM[7'h40][8];	// register-read.scala:86:29
        rrd_uops_1_REG_xcpt_ma_if = _RANDOM[7'h40][9];	// register-read.scala:86:29
        rrd_uops_1_REG_bp_debug_if = _RANDOM[7'h40][10];	// register-read.scala:86:29
        rrd_uops_1_REG_bp_xcpt_if = _RANDOM[7'h40][11];	// register-read.scala:86:29
        rrd_uops_1_REG_debug_fsrc = _RANDOM[7'h40][13:12];	// register-read.scala:86:29
        rrd_uops_1_REG_debug_tsrc = _RANDOM[7'h40][15:14];	// register-read.scala:86:29
        rrd_rs1_data_0_REG = _RANDOM[7'h40][16];	// register-read.scala:86:29, :124:57
        rrd_rs2_data_0_REG = _RANDOM[7'h40][17];	// register-read.scala:86:29, :125:57
        rrd_rs3_data_0_REG = _RANDOM[7'h40][18];	// register-read.scala:86:29, :126:57
        rrd_rs1_data_1_REG = _RANDOM[7'h40][19];	// register-read.scala:86:29, :124:57
        rrd_rs2_data_1_REG = _RANDOM[7'h40][20];	// register-read.scala:86:29, :125:57
        rrd_rs3_data_1_REG = _RANDOM[7'h40][21];	// register-read.scala:86:29, :126:57
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  RegisterReadDecode rrd_decode_unit (	// register-read.scala:80:33
    .io_iss_valid               (io_iss_valids_0),
    .io_iss_uop_uopc            (io_iss_uops_0_uopc),
    .io_iss_uop_inst            (io_iss_uops_0_inst),
    .io_iss_uop_debug_inst      (io_iss_uops_0_debug_inst),
    .io_iss_uop_is_rvc          (io_iss_uops_0_is_rvc),
    .io_iss_uop_debug_pc        (io_iss_uops_0_debug_pc),
    .io_iss_uop_iq_type         (io_iss_uops_0_iq_type),
    .io_iss_uop_fu_code         (io_iss_uops_0_fu_code),
    .io_iss_uop_iw_state        (io_iss_uops_0_iw_state),
    .io_iss_uop_iw_p1_poisoned  (io_iss_uops_0_iw_p1_poisoned),
    .io_iss_uop_iw_p2_poisoned  (io_iss_uops_0_iw_p2_poisoned),
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
    .io_rrd_uop_iw_p1_poisoned  (_rrd_decode_unit_io_rrd_uop_iw_p1_poisoned),
    .io_rrd_uop_iw_p2_poisoned  (_rrd_decode_unit_io_rrd_uop_iw_p2_poisoned),
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
  RegisterReadDecode_1 rrd_decode_unit_1 (	// register-read.scala:80:33
    .io_iss_valid               (io_iss_valids_1),
    .io_iss_uop_uopc            (io_iss_uops_1_uopc),
    .io_iss_uop_inst            (io_iss_uops_1_inst),
    .io_iss_uop_debug_inst      (io_iss_uops_1_debug_inst),
    .io_iss_uop_is_rvc          (io_iss_uops_1_is_rvc),
    .io_iss_uop_debug_pc        (io_iss_uops_1_debug_pc),
    .io_iss_uop_iq_type         (io_iss_uops_1_iq_type),
    .io_iss_uop_fu_code         (io_iss_uops_1_fu_code),
    .io_iss_uop_iw_state        (io_iss_uops_1_iw_state),
    .io_iss_uop_iw_p1_poisoned  (io_iss_uops_1_iw_p1_poisoned),
    .io_iss_uop_iw_p2_poisoned  (io_iss_uops_1_iw_p2_poisoned),
    .io_iss_uop_is_br           (io_iss_uops_1_is_br),
    .io_iss_uop_is_jalr         (io_iss_uops_1_is_jalr),
    .io_iss_uop_is_jal          (io_iss_uops_1_is_jal),
    .io_iss_uop_is_sfb          (io_iss_uops_1_is_sfb),
    .io_iss_uop_br_mask         (io_iss_uops_1_br_mask),
    .io_iss_uop_br_tag          (io_iss_uops_1_br_tag),
    .io_iss_uop_ftq_idx         (io_iss_uops_1_ftq_idx),
    .io_iss_uop_edge_inst       (io_iss_uops_1_edge_inst),
    .io_iss_uop_pc_lob          (io_iss_uops_1_pc_lob),
    .io_iss_uop_taken           (io_iss_uops_1_taken),
    .io_iss_uop_imm_packed      (io_iss_uops_1_imm_packed),
    .io_iss_uop_csr_addr        (io_iss_uops_1_csr_addr),
    .io_iss_uop_rob_idx         (io_iss_uops_1_rob_idx),
    .io_iss_uop_ldq_idx         (io_iss_uops_1_ldq_idx),
    .io_iss_uop_stq_idx         (io_iss_uops_1_stq_idx),
    .io_iss_uop_rxq_idx         (io_iss_uops_1_rxq_idx),
    .io_iss_uop_pdst            (io_iss_uops_1_pdst),
    .io_iss_uop_prs1            (io_iss_uops_1_prs1),
    .io_iss_uop_prs2            (io_iss_uops_1_prs2),
    .io_iss_uop_prs3            (io_iss_uops_1_prs3),
    .io_iss_uop_ppred           (io_iss_uops_1_ppred),
    .io_iss_uop_prs1_busy       (io_iss_uops_1_prs1_busy),
    .io_iss_uop_prs2_busy       (io_iss_uops_1_prs2_busy),
    .io_iss_uop_prs3_busy       (io_iss_uops_1_prs3_busy),
    .io_iss_uop_ppred_busy      (io_iss_uops_1_ppred_busy),
    .io_iss_uop_stale_pdst      (io_iss_uops_1_stale_pdst),
    .io_iss_uop_exception       (io_iss_uops_1_exception),
    .io_iss_uop_exc_cause       (io_iss_uops_1_exc_cause),
    .io_iss_uop_bypassable      (io_iss_uops_1_bypassable),
    .io_iss_uop_mem_cmd         (io_iss_uops_1_mem_cmd),
    .io_iss_uop_mem_size        (io_iss_uops_1_mem_size),
    .io_iss_uop_mem_signed      (io_iss_uops_1_mem_signed),
    .io_iss_uop_is_fence        (io_iss_uops_1_is_fence),
    .io_iss_uop_is_fencei       (io_iss_uops_1_is_fencei),
    .io_iss_uop_is_amo          (io_iss_uops_1_is_amo),
    .io_iss_uop_uses_ldq        (io_iss_uops_1_uses_ldq),
    .io_iss_uop_uses_stq        (io_iss_uops_1_uses_stq),
    .io_iss_uop_is_sys_pc2epc   (io_iss_uops_1_is_sys_pc2epc),
    .io_iss_uop_is_unique       (io_iss_uops_1_is_unique),
    .io_iss_uop_flush_on_commit (io_iss_uops_1_flush_on_commit),
    .io_iss_uop_ldst_is_rs1     (io_iss_uops_1_ldst_is_rs1),
    .io_iss_uop_ldst            (io_iss_uops_1_ldst),
    .io_iss_uop_lrs1            (io_iss_uops_1_lrs1),
    .io_iss_uop_lrs2            (io_iss_uops_1_lrs2),
    .io_iss_uop_lrs3            (io_iss_uops_1_lrs3),
    .io_iss_uop_ldst_val        (io_iss_uops_1_ldst_val),
    .io_iss_uop_dst_rtype       (io_iss_uops_1_dst_rtype),
    .io_iss_uop_lrs1_rtype      (io_iss_uops_1_lrs1_rtype),
    .io_iss_uop_lrs2_rtype      (io_iss_uops_1_lrs2_rtype),
    .io_iss_uop_frs3_en         (io_iss_uops_1_frs3_en),
    .io_iss_uop_fp_val          (io_iss_uops_1_fp_val),
    .io_iss_uop_fp_single       (io_iss_uops_1_fp_single),
    .io_iss_uop_xcpt_pf_if      (io_iss_uops_1_xcpt_pf_if),
    .io_iss_uop_xcpt_ae_if      (io_iss_uops_1_xcpt_ae_if),
    .io_iss_uop_xcpt_ma_if      (io_iss_uops_1_xcpt_ma_if),
    .io_iss_uop_bp_debug_if     (io_iss_uops_1_bp_debug_if),
    .io_iss_uop_bp_xcpt_if      (io_iss_uops_1_bp_xcpt_if),
    .io_iss_uop_debug_fsrc      (io_iss_uops_1_debug_fsrc),
    .io_iss_uop_debug_tsrc      (io_iss_uops_1_debug_tsrc),
    .io_rrd_valid               (_rrd_decode_unit_1_io_rrd_valid),
    .io_rrd_uop_uopc            (_rrd_decode_unit_1_io_rrd_uop_uopc),
    .io_rrd_uop_inst            (_rrd_decode_unit_1_io_rrd_uop_inst),
    .io_rrd_uop_debug_inst      (_rrd_decode_unit_1_io_rrd_uop_debug_inst),
    .io_rrd_uop_is_rvc          (_rrd_decode_unit_1_io_rrd_uop_is_rvc),
    .io_rrd_uop_debug_pc        (_rrd_decode_unit_1_io_rrd_uop_debug_pc),
    .io_rrd_uop_iq_type         (_rrd_decode_unit_1_io_rrd_uop_iq_type),
    .io_rrd_uop_fu_code         (_rrd_decode_unit_1_io_rrd_uop_fu_code),
    .io_rrd_uop_ctrl_br_type    (_rrd_decode_unit_1_io_rrd_uop_ctrl_br_type),
    .io_rrd_uop_ctrl_op1_sel    (_rrd_decode_unit_1_io_rrd_uop_ctrl_op1_sel),
    .io_rrd_uop_ctrl_op2_sel    (_rrd_decode_unit_1_io_rrd_uop_ctrl_op2_sel),
    .io_rrd_uop_ctrl_imm_sel    (_rrd_decode_unit_1_io_rrd_uop_ctrl_imm_sel),
    .io_rrd_uop_ctrl_op_fcn     (_rrd_decode_unit_1_io_rrd_uop_ctrl_op_fcn),
    .io_rrd_uop_ctrl_fcn_dw     (_rrd_decode_unit_1_io_rrd_uop_ctrl_fcn_dw),
    .io_rrd_uop_ctrl_is_load    (_rrd_decode_unit_1_io_rrd_uop_ctrl_is_load),
    .io_rrd_uop_ctrl_is_sta     (_rrd_decode_unit_1_io_rrd_uop_ctrl_is_sta),
    .io_rrd_uop_ctrl_is_std     (_rrd_decode_unit_1_io_rrd_uop_ctrl_is_std),
    .io_rrd_uop_iw_state        (_rrd_decode_unit_1_io_rrd_uop_iw_state),
    .io_rrd_uop_iw_p1_poisoned  (_rrd_decode_unit_1_io_rrd_uop_iw_p1_poisoned),
    .io_rrd_uop_iw_p2_poisoned  (_rrd_decode_unit_1_io_rrd_uop_iw_p2_poisoned),
    .io_rrd_uop_is_br           (_rrd_decode_unit_1_io_rrd_uop_is_br),
    .io_rrd_uop_is_jalr         (_rrd_decode_unit_1_io_rrd_uop_is_jalr),
    .io_rrd_uop_is_jal          (_rrd_decode_unit_1_io_rrd_uop_is_jal),
    .io_rrd_uop_is_sfb          (_rrd_decode_unit_1_io_rrd_uop_is_sfb),
    .io_rrd_uop_br_mask         (_rrd_decode_unit_1_io_rrd_uop_br_mask),
    .io_rrd_uop_br_tag          (_rrd_decode_unit_1_io_rrd_uop_br_tag),
    .io_rrd_uop_ftq_idx         (_rrd_decode_unit_1_io_rrd_uop_ftq_idx),
    .io_rrd_uop_edge_inst       (_rrd_decode_unit_1_io_rrd_uop_edge_inst),
    .io_rrd_uop_pc_lob          (_rrd_decode_unit_1_io_rrd_uop_pc_lob),
    .io_rrd_uop_taken           (_rrd_decode_unit_1_io_rrd_uop_taken),
    .io_rrd_uop_imm_packed      (_rrd_decode_unit_1_io_rrd_uop_imm_packed),
    .io_rrd_uop_csr_addr        (_rrd_decode_unit_1_io_rrd_uop_csr_addr),
    .io_rrd_uop_rob_idx         (_rrd_decode_unit_1_io_rrd_uop_rob_idx),
    .io_rrd_uop_ldq_idx         (_rrd_decode_unit_1_io_rrd_uop_ldq_idx),
    .io_rrd_uop_stq_idx         (_rrd_decode_unit_1_io_rrd_uop_stq_idx),
    .io_rrd_uop_rxq_idx         (_rrd_decode_unit_1_io_rrd_uop_rxq_idx),
    .io_rrd_uop_pdst            (_rrd_decode_unit_1_io_rrd_uop_pdst),
    .io_rrd_uop_prs1            (_rrd_decode_unit_1_io_rrd_uop_prs1),
    .io_rrd_uop_prs2            (_rrd_decode_unit_1_io_rrd_uop_prs2),
    .io_rrd_uop_prs3            (_rrd_decode_unit_1_io_rrd_uop_prs3),
    .io_rrd_uop_ppred           (_rrd_decode_unit_1_io_rrd_uop_ppred),
    .io_rrd_uop_prs1_busy       (_rrd_decode_unit_1_io_rrd_uop_prs1_busy),
    .io_rrd_uop_prs2_busy       (_rrd_decode_unit_1_io_rrd_uop_prs2_busy),
    .io_rrd_uop_prs3_busy       (_rrd_decode_unit_1_io_rrd_uop_prs3_busy),
    .io_rrd_uop_ppred_busy      (_rrd_decode_unit_1_io_rrd_uop_ppred_busy),
    .io_rrd_uop_stale_pdst      (_rrd_decode_unit_1_io_rrd_uop_stale_pdst),
    .io_rrd_uop_exception       (_rrd_decode_unit_1_io_rrd_uop_exception),
    .io_rrd_uop_exc_cause       (_rrd_decode_unit_1_io_rrd_uop_exc_cause),
    .io_rrd_uop_bypassable      (_rrd_decode_unit_1_io_rrd_uop_bypassable),
    .io_rrd_uop_mem_cmd         (_rrd_decode_unit_1_io_rrd_uop_mem_cmd),
    .io_rrd_uop_mem_size        (_rrd_decode_unit_1_io_rrd_uop_mem_size),
    .io_rrd_uop_mem_signed      (_rrd_decode_unit_1_io_rrd_uop_mem_signed),
    .io_rrd_uop_is_fence        (_rrd_decode_unit_1_io_rrd_uop_is_fence),
    .io_rrd_uop_is_fencei       (_rrd_decode_unit_1_io_rrd_uop_is_fencei),
    .io_rrd_uop_is_amo          (_rrd_decode_unit_1_io_rrd_uop_is_amo),
    .io_rrd_uop_uses_ldq        (_rrd_decode_unit_1_io_rrd_uop_uses_ldq),
    .io_rrd_uop_uses_stq        (_rrd_decode_unit_1_io_rrd_uop_uses_stq),
    .io_rrd_uop_is_sys_pc2epc   (_rrd_decode_unit_1_io_rrd_uop_is_sys_pc2epc),
    .io_rrd_uop_is_unique       (_rrd_decode_unit_1_io_rrd_uop_is_unique),
    .io_rrd_uop_flush_on_commit (_rrd_decode_unit_1_io_rrd_uop_flush_on_commit),
    .io_rrd_uop_ldst_is_rs1     (_rrd_decode_unit_1_io_rrd_uop_ldst_is_rs1),
    .io_rrd_uop_ldst            (_rrd_decode_unit_1_io_rrd_uop_ldst),
    .io_rrd_uop_lrs1            (_rrd_decode_unit_1_io_rrd_uop_lrs1),
    .io_rrd_uop_lrs2            (_rrd_decode_unit_1_io_rrd_uop_lrs2),
    .io_rrd_uop_lrs3            (_rrd_decode_unit_1_io_rrd_uop_lrs3),
    .io_rrd_uop_ldst_val        (_rrd_decode_unit_1_io_rrd_uop_ldst_val),
    .io_rrd_uop_dst_rtype       (_rrd_decode_unit_1_io_rrd_uop_dst_rtype),
    .io_rrd_uop_lrs1_rtype      (_rrd_decode_unit_1_io_rrd_uop_lrs1_rtype),
    .io_rrd_uop_lrs2_rtype      (_rrd_decode_unit_1_io_rrd_uop_lrs2_rtype),
    .io_rrd_uop_frs3_en         (_rrd_decode_unit_1_io_rrd_uop_frs3_en),
    .io_rrd_uop_fp_val          (_rrd_decode_unit_1_io_rrd_uop_fp_val),
    .io_rrd_uop_fp_single       (_rrd_decode_unit_1_io_rrd_uop_fp_single),
    .io_rrd_uop_xcpt_pf_if      (_rrd_decode_unit_1_io_rrd_uop_xcpt_pf_if),
    .io_rrd_uop_xcpt_ae_if      (_rrd_decode_unit_1_io_rrd_uop_xcpt_ae_if),
    .io_rrd_uop_xcpt_ma_if      (_rrd_decode_unit_1_io_rrd_uop_xcpt_ma_if),
    .io_rrd_uop_bp_debug_if     (_rrd_decode_unit_1_io_rrd_uop_bp_debug_if),
    .io_rrd_uop_bp_xcpt_if      (_rrd_decode_unit_1_io_rrd_uop_bp_xcpt_if),
    .io_rrd_uop_debug_fsrc      (_rrd_decode_unit_1_io_rrd_uop_debug_fsrc),
    .io_rrd_uop_debug_tsrc      (_rrd_decode_unit_1_io_rrd_uop_debug_tsrc)
  );
  assign io_rf_read_ports_0_addr = io_iss_uops_0_prs1;
  assign io_rf_read_ports_1_addr = io_iss_uops_0_prs2;
  assign io_rf_read_ports_2_addr = io_iss_uops_0_prs3;
  assign io_rf_read_ports_3_addr = io_iss_uops_1_prs1;
  assign io_rf_read_ports_4_addr = io_iss_uops_1_prs2;
  assign io_rf_read_ports_5_addr = io_iss_uops_1_prs3;
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
  assign io_exe_reqs_0_bits_uop_iw_p1_poisoned = exe_reg_uops_0_iw_p1_poisoned;	// register-read.scala:70:29
  assign io_exe_reqs_0_bits_uop_iw_p2_poisoned = exe_reg_uops_0_iw_p2_poisoned;	// register-read.scala:70:29
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
  assign io_exe_reqs_0_bits_rs3_data = exe_reg_rs3_data_0;	// register-read.scala:73:29
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
  assign io_exe_reqs_1_bits_uop_iw_p1_poisoned = exe_reg_uops_1_iw_p1_poisoned;	// register-read.scala:70:29
  assign io_exe_reqs_1_bits_uop_iw_p2_poisoned = exe_reg_uops_1_iw_p2_poisoned;	// register-read.scala:70:29
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
  assign io_exe_reqs_1_bits_rs3_data = exe_reg_rs3_data_1;	// register-read.scala:73:29
endmodule

