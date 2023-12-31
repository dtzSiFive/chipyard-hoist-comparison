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

module FPUUnit(
  input         clock,
                reset,
                io_req_valid,
  input  [6:0]  io_req_bits_uop_uopc,
  input  [31:0] io_req_bits_uop_inst,
                io_req_bits_uop_debug_inst,
  input         io_req_bits_uop_is_rvc,
  input  [39:0] io_req_bits_uop_debug_pc,
  input  [2:0]  io_req_bits_uop_iq_type,
  input  [9:0]  io_req_bits_uop_fu_code,
  input  [3:0]  io_req_bits_uop_ctrl_br_type,
  input  [1:0]  io_req_bits_uop_ctrl_op1_sel,
  input  [2:0]  io_req_bits_uop_ctrl_op2_sel,
                io_req_bits_uop_ctrl_imm_sel,
  input  [3:0]  io_req_bits_uop_ctrl_op_fcn,
  input         io_req_bits_uop_ctrl_fcn_dw,
  input  [2:0]  io_req_bits_uop_ctrl_csr_cmd,
  input         io_req_bits_uop_ctrl_is_load,
                io_req_bits_uop_ctrl_is_sta,
                io_req_bits_uop_ctrl_is_std,
  input  [1:0]  io_req_bits_uop_iw_state,
  input         io_req_bits_uop_iw_p1_poisoned,
                io_req_bits_uop_iw_p2_poisoned,
                io_req_bits_uop_is_br,
                io_req_bits_uop_is_jalr,
                io_req_bits_uop_is_jal,
                io_req_bits_uop_is_sfb,
  input  [19:0] io_req_bits_uop_br_mask,
  input  [4:0]  io_req_bits_uop_br_tag,
  input  [5:0]  io_req_bits_uop_ftq_idx,
  input         io_req_bits_uop_edge_inst,
  input  [5:0]  io_req_bits_uop_pc_lob,
  input         io_req_bits_uop_taken,
  input  [19:0] io_req_bits_uop_imm_packed,
  input  [11:0] io_req_bits_uop_csr_addr,
  input  [6:0]  io_req_bits_uop_rob_idx,
  input  [4:0]  io_req_bits_uop_ldq_idx,
                io_req_bits_uop_stq_idx,
  input  [1:0]  io_req_bits_uop_rxq_idx,
  input  [6:0]  io_req_bits_uop_pdst,
                io_req_bits_uop_prs1,
                io_req_bits_uop_prs2,
                io_req_bits_uop_prs3,
  input  [5:0]  io_req_bits_uop_ppred,
  input         io_req_bits_uop_prs1_busy,
                io_req_bits_uop_prs2_busy,
                io_req_bits_uop_prs3_busy,
                io_req_bits_uop_ppred_busy,
  input  [6:0]  io_req_bits_uop_stale_pdst,
  input         io_req_bits_uop_exception,
  input  [63:0] io_req_bits_uop_exc_cause,
  input         io_req_bits_uop_bypassable,
  input  [4:0]  io_req_bits_uop_mem_cmd,
  input  [1:0]  io_req_bits_uop_mem_size,
  input         io_req_bits_uop_mem_signed,
                io_req_bits_uop_is_fence,
                io_req_bits_uop_is_fencei,
                io_req_bits_uop_is_amo,
                io_req_bits_uop_uses_ldq,
                io_req_bits_uop_uses_stq,
                io_req_bits_uop_is_sys_pc2epc,
                io_req_bits_uop_is_unique,
                io_req_bits_uop_flush_on_commit,
                io_req_bits_uop_ldst_is_rs1,
  input  [5:0]  io_req_bits_uop_ldst,
                io_req_bits_uop_lrs1,
                io_req_bits_uop_lrs2,
                io_req_bits_uop_lrs3,
  input         io_req_bits_uop_ldst_val,
  input  [1:0]  io_req_bits_uop_dst_rtype,
                io_req_bits_uop_lrs1_rtype,
                io_req_bits_uop_lrs2_rtype,
  input         io_req_bits_uop_frs3_en,
                io_req_bits_uop_fp_val,
                io_req_bits_uop_fp_single,
                io_req_bits_uop_xcpt_pf_if,
                io_req_bits_uop_xcpt_ae_if,
                io_req_bits_uop_xcpt_ma_if,
                io_req_bits_uop_bp_debug_if,
                io_req_bits_uop_bp_xcpt_if,
  input  [1:0]  io_req_bits_uop_debug_fsrc,
                io_req_bits_uop_debug_tsrc,
  input  [64:0] io_req_bits_rs1_data,
                io_req_bits_rs2_data,
                io_req_bits_rs3_data,
  input         io_req_bits_kill,
  input  [19:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  input  [2:0]  io_fcsr_rm,
  output        io_resp_valid,
  output [6:0]  io_resp_bits_uop_uopc,
  output [31:0] io_resp_bits_uop_inst,
                io_resp_bits_uop_debug_inst,
  output        io_resp_bits_uop_is_rvc,
  output [39:0] io_resp_bits_uop_debug_pc,
  output [2:0]  io_resp_bits_uop_iq_type,
  output [9:0]  io_resp_bits_uop_fu_code,
  output [3:0]  io_resp_bits_uop_ctrl_br_type,
  output [1:0]  io_resp_bits_uop_ctrl_op1_sel,
  output [2:0]  io_resp_bits_uop_ctrl_op2_sel,
                io_resp_bits_uop_ctrl_imm_sel,
  output [3:0]  io_resp_bits_uop_ctrl_op_fcn,
  output        io_resp_bits_uop_ctrl_fcn_dw,
  output [2:0]  io_resp_bits_uop_ctrl_csr_cmd,
  output        io_resp_bits_uop_ctrl_is_load,
                io_resp_bits_uop_ctrl_is_sta,
                io_resp_bits_uop_ctrl_is_std,
  output [1:0]  io_resp_bits_uop_iw_state,
  output        io_resp_bits_uop_iw_p1_poisoned,
                io_resp_bits_uop_iw_p2_poisoned,
                io_resp_bits_uop_is_br,
                io_resp_bits_uop_is_jalr,
                io_resp_bits_uop_is_jal,
                io_resp_bits_uop_is_sfb,
  output [19:0] io_resp_bits_uop_br_mask,
  output [4:0]  io_resp_bits_uop_br_tag,
  output [5:0]  io_resp_bits_uop_ftq_idx,
  output        io_resp_bits_uop_edge_inst,
  output [5:0]  io_resp_bits_uop_pc_lob,
  output        io_resp_bits_uop_taken,
  output [19:0] io_resp_bits_uop_imm_packed,
  output [11:0] io_resp_bits_uop_csr_addr,
  output [6:0]  io_resp_bits_uop_rob_idx,
  output [4:0]  io_resp_bits_uop_ldq_idx,
                io_resp_bits_uop_stq_idx,
  output [1:0]  io_resp_bits_uop_rxq_idx,
  output [6:0]  io_resp_bits_uop_pdst,
                io_resp_bits_uop_prs1,
                io_resp_bits_uop_prs2,
                io_resp_bits_uop_prs3,
  output [5:0]  io_resp_bits_uop_ppred,
  output        io_resp_bits_uop_prs1_busy,
                io_resp_bits_uop_prs2_busy,
                io_resp_bits_uop_prs3_busy,
                io_resp_bits_uop_ppred_busy,
  output [6:0]  io_resp_bits_uop_stale_pdst,
  output        io_resp_bits_uop_exception,
  output [63:0] io_resp_bits_uop_exc_cause,
  output        io_resp_bits_uop_bypassable,
  output [4:0]  io_resp_bits_uop_mem_cmd,
  output [1:0]  io_resp_bits_uop_mem_size,
  output        io_resp_bits_uop_mem_signed,
                io_resp_bits_uop_is_fence,
                io_resp_bits_uop_is_fencei,
                io_resp_bits_uop_is_amo,
                io_resp_bits_uop_uses_ldq,
                io_resp_bits_uop_uses_stq,
                io_resp_bits_uop_is_sys_pc2epc,
                io_resp_bits_uop_is_unique,
                io_resp_bits_uop_flush_on_commit,
                io_resp_bits_uop_ldst_is_rs1,
  output [5:0]  io_resp_bits_uop_ldst,
                io_resp_bits_uop_lrs1,
                io_resp_bits_uop_lrs2,
                io_resp_bits_uop_lrs3,
  output        io_resp_bits_uop_ldst_val,
  output [1:0]  io_resp_bits_uop_dst_rtype,
                io_resp_bits_uop_lrs1_rtype,
                io_resp_bits_uop_lrs2_rtype,
  output        io_resp_bits_uop_frs3_en,
                io_resp_bits_uop_fp_val,
                io_resp_bits_uop_fp_single,
                io_resp_bits_uop_xcpt_pf_if,
                io_resp_bits_uop_xcpt_ae_if,
                io_resp_bits_uop_xcpt_ma_if,
                io_resp_bits_uop_bp_debug_if,
                io_resp_bits_uop_bp_xcpt_if,
  output [1:0]  io_resp_bits_uop_debug_fsrc,
                io_resp_bits_uop_debug_tsrc,
  output [64:0] io_resp_bits_data,
  output        io_resp_bits_fflags_valid,
  output [6:0]  io_resp_bits_fflags_bits_uop_uopc,
  output [31:0] io_resp_bits_fflags_bits_uop_inst,
                io_resp_bits_fflags_bits_uop_debug_inst,
  output        io_resp_bits_fflags_bits_uop_is_rvc,
  output [39:0] io_resp_bits_fflags_bits_uop_debug_pc,
  output [2:0]  io_resp_bits_fflags_bits_uop_iq_type,
  output [9:0]  io_resp_bits_fflags_bits_uop_fu_code,
  output [3:0]  io_resp_bits_fflags_bits_uop_ctrl_br_type,
  output [1:0]  io_resp_bits_fflags_bits_uop_ctrl_op1_sel,
  output [2:0]  io_resp_bits_fflags_bits_uop_ctrl_op2_sel,
                io_resp_bits_fflags_bits_uop_ctrl_imm_sel,
  output [3:0]  io_resp_bits_fflags_bits_uop_ctrl_op_fcn,
  output        io_resp_bits_fflags_bits_uop_ctrl_fcn_dw,
  output [2:0]  io_resp_bits_fflags_bits_uop_ctrl_csr_cmd,
  output        io_resp_bits_fflags_bits_uop_ctrl_is_load,
                io_resp_bits_fflags_bits_uop_ctrl_is_sta,
                io_resp_bits_fflags_bits_uop_ctrl_is_std,
  output [1:0]  io_resp_bits_fflags_bits_uop_iw_state,
  output        io_resp_bits_fflags_bits_uop_iw_p1_poisoned,
                io_resp_bits_fflags_bits_uop_iw_p2_poisoned,
                io_resp_bits_fflags_bits_uop_is_br,
                io_resp_bits_fflags_bits_uop_is_jalr,
                io_resp_bits_fflags_bits_uop_is_jal,
                io_resp_bits_fflags_bits_uop_is_sfb,
  output [19:0] io_resp_bits_fflags_bits_uop_br_mask,
  output [4:0]  io_resp_bits_fflags_bits_uop_br_tag,
  output [5:0]  io_resp_bits_fflags_bits_uop_ftq_idx,
  output        io_resp_bits_fflags_bits_uop_edge_inst,
  output [5:0]  io_resp_bits_fflags_bits_uop_pc_lob,
  output        io_resp_bits_fflags_bits_uop_taken,
  output [19:0] io_resp_bits_fflags_bits_uop_imm_packed,
  output [11:0] io_resp_bits_fflags_bits_uop_csr_addr,
  output [6:0]  io_resp_bits_fflags_bits_uop_rob_idx,
  output [4:0]  io_resp_bits_fflags_bits_uop_ldq_idx,
                io_resp_bits_fflags_bits_uop_stq_idx,
  output [1:0]  io_resp_bits_fflags_bits_uop_rxq_idx,
  output [6:0]  io_resp_bits_fflags_bits_uop_pdst,
                io_resp_bits_fflags_bits_uop_prs1,
                io_resp_bits_fflags_bits_uop_prs2,
                io_resp_bits_fflags_bits_uop_prs3,
  output [5:0]  io_resp_bits_fflags_bits_uop_ppred,
  output        io_resp_bits_fflags_bits_uop_prs1_busy,
                io_resp_bits_fflags_bits_uop_prs2_busy,
                io_resp_bits_fflags_bits_uop_prs3_busy,
                io_resp_bits_fflags_bits_uop_ppred_busy,
  output [6:0]  io_resp_bits_fflags_bits_uop_stale_pdst,
  output        io_resp_bits_fflags_bits_uop_exception,
  output [63:0] io_resp_bits_fflags_bits_uop_exc_cause,
  output        io_resp_bits_fflags_bits_uop_bypassable,
  output [4:0]  io_resp_bits_fflags_bits_uop_mem_cmd,
  output [1:0]  io_resp_bits_fflags_bits_uop_mem_size,
  output        io_resp_bits_fflags_bits_uop_mem_signed,
                io_resp_bits_fflags_bits_uop_is_fence,
                io_resp_bits_fflags_bits_uop_is_fencei,
                io_resp_bits_fflags_bits_uop_is_amo,
                io_resp_bits_fflags_bits_uop_uses_ldq,
                io_resp_bits_fflags_bits_uop_uses_stq,
                io_resp_bits_fflags_bits_uop_is_sys_pc2epc,
                io_resp_bits_fflags_bits_uop_is_unique,
                io_resp_bits_fflags_bits_uop_flush_on_commit,
                io_resp_bits_fflags_bits_uop_ldst_is_rs1,
  output [5:0]  io_resp_bits_fflags_bits_uop_ldst,
                io_resp_bits_fflags_bits_uop_lrs1,
                io_resp_bits_fflags_bits_uop_lrs2,
                io_resp_bits_fflags_bits_uop_lrs3,
  output        io_resp_bits_fflags_bits_uop_ldst_val,
  output [1:0]  io_resp_bits_fflags_bits_uop_dst_rtype,
                io_resp_bits_fflags_bits_uop_lrs1_rtype,
                io_resp_bits_fflags_bits_uop_lrs2_rtype,
  output        io_resp_bits_fflags_bits_uop_frs3_en,
                io_resp_bits_fflags_bits_uop_fp_val,
                io_resp_bits_fflags_bits_uop_fp_single,
                io_resp_bits_fflags_bits_uop_xcpt_pf_if,
                io_resp_bits_fflags_bits_uop_xcpt_ae_if,
                io_resp_bits_fflags_bits_uop_xcpt_ma_if,
                io_resp_bits_fflags_bits_uop_bp_debug_if,
                io_resp_bits_fflags_bits_uop_bp_xcpt_if,
  output [1:0]  io_resp_bits_fflags_bits_uop_debug_fsrc,
                io_resp_bits_fflags_bits_uop_debug_tsrc,
  output [4:0]  io_resp_bits_fflags_bits_flags
);

  reg         r_valids_0;	// functional-unit.scala:228:27
  reg         r_valids_1;	// functional-unit.scala:228:27
  reg         r_valids_2;	// functional-unit.scala:228:27
  reg         r_valids_3;	// functional-unit.scala:228:27
  reg  [6:0]  r_uops_0_uopc;	// functional-unit.scala:229:23
  reg  [31:0] r_uops_0_inst;	// functional-unit.scala:229:23
  reg  [31:0] r_uops_0_debug_inst;	// functional-unit.scala:229:23
  reg         r_uops_0_is_rvc;	// functional-unit.scala:229:23
  reg  [39:0] r_uops_0_debug_pc;	// functional-unit.scala:229:23
  reg  [2:0]  r_uops_0_iq_type;	// functional-unit.scala:229:23
  reg  [9:0]  r_uops_0_fu_code;	// functional-unit.scala:229:23
  reg  [3:0]  r_uops_0_ctrl_br_type;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_0_ctrl_op1_sel;	// functional-unit.scala:229:23
  reg  [2:0]  r_uops_0_ctrl_op2_sel;	// functional-unit.scala:229:23
  reg  [2:0]  r_uops_0_ctrl_imm_sel;	// functional-unit.scala:229:23
  reg  [3:0]  r_uops_0_ctrl_op_fcn;	// functional-unit.scala:229:23
  reg         r_uops_0_ctrl_fcn_dw;	// functional-unit.scala:229:23
  reg  [2:0]  r_uops_0_ctrl_csr_cmd;	// functional-unit.scala:229:23
  reg         r_uops_0_ctrl_is_load;	// functional-unit.scala:229:23
  reg         r_uops_0_ctrl_is_sta;	// functional-unit.scala:229:23
  reg         r_uops_0_ctrl_is_std;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_0_iw_state;	// functional-unit.scala:229:23
  reg         r_uops_0_iw_p1_poisoned;	// functional-unit.scala:229:23
  reg         r_uops_0_iw_p2_poisoned;	// functional-unit.scala:229:23
  reg         r_uops_0_is_br;	// functional-unit.scala:229:23
  reg         r_uops_0_is_jalr;	// functional-unit.scala:229:23
  reg         r_uops_0_is_jal;	// functional-unit.scala:229:23
  reg         r_uops_0_is_sfb;	// functional-unit.scala:229:23
  reg  [19:0] r_uops_0_br_mask;	// functional-unit.scala:229:23
  reg  [4:0]  r_uops_0_br_tag;	// functional-unit.scala:229:23
  reg  [5:0]  r_uops_0_ftq_idx;	// functional-unit.scala:229:23
  reg         r_uops_0_edge_inst;	// functional-unit.scala:229:23
  reg  [5:0]  r_uops_0_pc_lob;	// functional-unit.scala:229:23
  reg         r_uops_0_taken;	// functional-unit.scala:229:23
  reg  [19:0] r_uops_0_imm_packed;	// functional-unit.scala:229:23
  reg  [11:0] r_uops_0_csr_addr;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_0_rob_idx;	// functional-unit.scala:229:23
  reg  [4:0]  r_uops_0_ldq_idx;	// functional-unit.scala:229:23
  reg  [4:0]  r_uops_0_stq_idx;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_0_rxq_idx;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_0_pdst;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_0_prs1;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_0_prs2;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_0_prs3;	// functional-unit.scala:229:23
  reg  [5:0]  r_uops_0_ppred;	// functional-unit.scala:229:23
  reg         r_uops_0_prs1_busy;	// functional-unit.scala:229:23
  reg         r_uops_0_prs2_busy;	// functional-unit.scala:229:23
  reg         r_uops_0_prs3_busy;	// functional-unit.scala:229:23
  reg         r_uops_0_ppred_busy;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_0_stale_pdst;	// functional-unit.scala:229:23
  reg         r_uops_0_exception;	// functional-unit.scala:229:23
  reg  [63:0] r_uops_0_exc_cause;	// functional-unit.scala:229:23
  reg         r_uops_0_bypassable;	// functional-unit.scala:229:23
  reg  [4:0]  r_uops_0_mem_cmd;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_0_mem_size;	// functional-unit.scala:229:23
  reg         r_uops_0_mem_signed;	// functional-unit.scala:229:23
  reg         r_uops_0_is_fence;	// functional-unit.scala:229:23
  reg         r_uops_0_is_fencei;	// functional-unit.scala:229:23
  reg         r_uops_0_is_amo;	// functional-unit.scala:229:23
  reg         r_uops_0_uses_ldq;	// functional-unit.scala:229:23
  reg         r_uops_0_uses_stq;	// functional-unit.scala:229:23
  reg         r_uops_0_is_sys_pc2epc;	// functional-unit.scala:229:23
  reg         r_uops_0_is_unique;	// functional-unit.scala:229:23
  reg         r_uops_0_flush_on_commit;	// functional-unit.scala:229:23
  reg         r_uops_0_ldst_is_rs1;	// functional-unit.scala:229:23
  reg  [5:0]  r_uops_0_ldst;	// functional-unit.scala:229:23
  reg  [5:0]  r_uops_0_lrs1;	// functional-unit.scala:229:23
  reg  [5:0]  r_uops_0_lrs2;	// functional-unit.scala:229:23
  reg  [5:0]  r_uops_0_lrs3;	// functional-unit.scala:229:23
  reg         r_uops_0_ldst_val;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_0_dst_rtype;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_0_lrs1_rtype;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_0_lrs2_rtype;	// functional-unit.scala:229:23
  reg         r_uops_0_frs3_en;	// functional-unit.scala:229:23
  reg         r_uops_0_fp_val;	// functional-unit.scala:229:23
  reg         r_uops_0_fp_single;	// functional-unit.scala:229:23
  reg         r_uops_0_xcpt_pf_if;	// functional-unit.scala:229:23
  reg         r_uops_0_xcpt_ae_if;	// functional-unit.scala:229:23
  reg         r_uops_0_xcpt_ma_if;	// functional-unit.scala:229:23
  reg         r_uops_0_bp_debug_if;	// functional-unit.scala:229:23
  reg         r_uops_0_bp_xcpt_if;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_0_debug_fsrc;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_0_debug_tsrc;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_1_uopc;	// functional-unit.scala:229:23
  reg  [31:0] r_uops_1_inst;	// functional-unit.scala:229:23
  reg  [31:0] r_uops_1_debug_inst;	// functional-unit.scala:229:23
  reg         r_uops_1_is_rvc;	// functional-unit.scala:229:23
  reg  [39:0] r_uops_1_debug_pc;	// functional-unit.scala:229:23
  reg  [2:0]  r_uops_1_iq_type;	// functional-unit.scala:229:23
  reg  [9:0]  r_uops_1_fu_code;	// functional-unit.scala:229:23
  reg  [3:0]  r_uops_1_ctrl_br_type;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_1_ctrl_op1_sel;	// functional-unit.scala:229:23
  reg  [2:0]  r_uops_1_ctrl_op2_sel;	// functional-unit.scala:229:23
  reg  [2:0]  r_uops_1_ctrl_imm_sel;	// functional-unit.scala:229:23
  reg  [3:0]  r_uops_1_ctrl_op_fcn;	// functional-unit.scala:229:23
  reg         r_uops_1_ctrl_fcn_dw;	// functional-unit.scala:229:23
  reg  [2:0]  r_uops_1_ctrl_csr_cmd;	// functional-unit.scala:229:23
  reg         r_uops_1_ctrl_is_load;	// functional-unit.scala:229:23
  reg         r_uops_1_ctrl_is_sta;	// functional-unit.scala:229:23
  reg         r_uops_1_ctrl_is_std;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_1_iw_state;	// functional-unit.scala:229:23
  reg         r_uops_1_iw_p1_poisoned;	// functional-unit.scala:229:23
  reg         r_uops_1_iw_p2_poisoned;	// functional-unit.scala:229:23
  reg         r_uops_1_is_br;	// functional-unit.scala:229:23
  reg         r_uops_1_is_jalr;	// functional-unit.scala:229:23
  reg         r_uops_1_is_jal;	// functional-unit.scala:229:23
  reg         r_uops_1_is_sfb;	// functional-unit.scala:229:23
  reg  [19:0] r_uops_1_br_mask;	// functional-unit.scala:229:23
  reg  [4:0]  r_uops_1_br_tag;	// functional-unit.scala:229:23
  reg  [5:0]  r_uops_1_ftq_idx;	// functional-unit.scala:229:23
  reg         r_uops_1_edge_inst;	// functional-unit.scala:229:23
  reg  [5:0]  r_uops_1_pc_lob;	// functional-unit.scala:229:23
  reg         r_uops_1_taken;	// functional-unit.scala:229:23
  reg  [19:0] r_uops_1_imm_packed;	// functional-unit.scala:229:23
  reg  [11:0] r_uops_1_csr_addr;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_1_rob_idx;	// functional-unit.scala:229:23
  reg  [4:0]  r_uops_1_ldq_idx;	// functional-unit.scala:229:23
  reg  [4:0]  r_uops_1_stq_idx;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_1_rxq_idx;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_1_pdst;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_1_prs1;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_1_prs2;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_1_prs3;	// functional-unit.scala:229:23
  reg  [5:0]  r_uops_1_ppred;	// functional-unit.scala:229:23
  reg         r_uops_1_prs1_busy;	// functional-unit.scala:229:23
  reg         r_uops_1_prs2_busy;	// functional-unit.scala:229:23
  reg         r_uops_1_prs3_busy;	// functional-unit.scala:229:23
  reg         r_uops_1_ppred_busy;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_1_stale_pdst;	// functional-unit.scala:229:23
  reg         r_uops_1_exception;	// functional-unit.scala:229:23
  reg  [63:0] r_uops_1_exc_cause;	// functional-unit.scala:229:23
  reg         r_uops_1_bypassable;	// functional-unit.scala:229:23
  reg  [4:0]  r_uops_1_mem_cmd;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_1_mem_size;	// functional-unit.scala:229:23
  reg         r_uops_1_mem_signed;	// functional-unit.scala:229:23
  reg         r_uops_1_is_fence;	// functional-unit.scala:229:23
  reg         r_uops_1_is_fencei;	// functional-unit.scala:229:23
  reg         r_uops_1_is_amo;	// functional-unit.scala:229:23
  reg         r_uops_1_uses_ldq;	// functional-unit.scala:229:23
  reg         r_uops_1_uses_stq;	// functional-unit.scala:229:23
  reg         r_uops_1_is_sys_pc2epc;	// functional-unit.scala:229:23
  reg         r_uops_1_is_unique;	// functional-unit.scala:229:23
  reg         r_uops_1_flush_on_commit;	// functional-unit.scala:229:23
  reg         r_uops_1_ldst_is_rs1;	// functional-unit.scala:229:23
  reg  [5:0]  r_uops_1_ldst;	// functional-unit.scala:229:23
  reg  [5:0]  r_uops_1_lrs1;	// functional-unit.scala:229:23
  reg  [5:0]  r_uops_1_lrs2;	// functional-unit.scala:229:23
  reg  [5:0]  r_uops_1_lrs3;	// functional-unit.scala:229:23
  reg         r_uops_1_ldst_val;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_1_dst_rtype;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_1_lrs1_rtype;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_1_lrs2_rtype;	// functional-unit.scala:229:23
  reg         r_uops_1_frs3_en;	// functional-unit.scala:229:23
  reg         r_uops_1_fp_val;	// functional-unit.scala:229:23
  reg         r_uops_1_fp_single;	// functional-unit.scala:229:23
  reg         r_uops_1_xcpt_pf_if;	// functional-unit.scala:229:23
  reg         r_uops_1_xcpt_ae_if;	// functional-unit.scala:229:23
  reg         r_uops_1_xcpt_ma_if;	// functional-unit.scala:229:23
  reg         r_uops_1_bp_debug_if;	// functional-unit.scala:229:23
  reg         r_uops_1_bp_xcpt_if;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_1_debug_fsrc;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_1_debug_tsrc;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_2_uopc;	// functional-unit.scala:229:23
  reg  [31:0] r_uops_2_inst;	// functional-unit.scala:229:23
  reg  [31:0] r_uops_2_debug_inst;	// functional-unit.scala:229:23
  reg         r_uops_2_is_rvc;	// functional-unit.scala:229:23
  reg  [39:0] r_uops_2_debug_pc;	// functional-unit.scala:229:23
  reg  [2:0]  r_uops_2_iq_type;	// functional-unit.scala:229:23
  reg  [9:0]  r_uops_2_fu_code;	// functional-unit.scala:229:23
  reg  [3:0]  r_uops_2_ctrl_br_type;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_2_ctrl_op1_sel;	// functional-unit.scala:229:23
  reg  [2:0]  r_uops_2_ctrl_op2_sel;	// functional-unit.scala:229:23
  reg  [2:0]  r_uops_2_ctrl_imm_sel;	// functional-unit.scala:229:23
  reg  [3:0]  r_uops_2_ctrl_op_fcn;	// functional-unit.scala:229:23
  reg         r_uops_2_ctrl_fcn_dw;	// functional-unit.scala:229:23
  reg  [2:0]  r_uops_2_ctrl_csr_cmd;	// functional-unit.scala:229:23
  reg         r_uops_2_ctrl_is_load;	// functional-unit.scala:229:23
  reg         r_uops_2_ctrl_is_sta;	// functional-unit.scala:229:23
  reg         r_uops_2_ctrl_is_std;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_2_iw_state;	// functional-unit.scala:229:23
  reg         r_uops_2_iw_p1_poisoned;	// functional-unit.scala:229:23
  reg         r_uops_2_iw_p2_poisoned;	// functional-unit.scala:229:23
  reg         r_uops_2_is_br;	// functional-unit.scala:229:23
  reg         r_uops_2_is_jalr;	// functional-unit.scala:229:23
  reg         r_uops_2_is_jal;	// functional-unit.scala:229:23
  reg         r_uops_2_is_sfb;	// functional-unit.scala:229:23
  reg  [19:0] r_uops_2_br_mask;	// functional-unit.scala:229:23
  reg  [4:0]  r_uops_2_br_tag;	// functional-unit.scala:229:23
  reg  [5:0]  r_uops_2_ftq_idx;	// functional-unit.scala:229:23
  reg         r_uops_2_edge_inst;	// functional-unit.scala:229:23
  reg  [5:0]  r_uops_2_pc_lob;	// functional-unit.scala:229:23
  reg         r_uops_2_taken;	// functional-unit.scala:229:23
  reg  [19:0] r_uops_2_imm_packed;	// functional-unit.scala:229:23
  reg  [11:0] r_uops_2_csr_addr;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_2_rob_idx;	// functional-unit.scala:229:23
  reg  [4:0]  r_uops_2_ldq_idx;	// functional-unit.scala:229:23
  reg  [4:0]  r_uops_2_stq_idx;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_2_rxq_idx;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_2_pdst;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_2_prs1;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_2_prs2;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_2_prs3;	// functional-unit.scala:229:23
  reg  [5:0]  r_uops_2_ppred;	// functional-unit.scala:229:23
  reg         r_uops_2_prs1_busy;	// functional-unit.scala:229:23
  reg         r_uops_2_prs2_busy;	// functional-unit.scala:229:23
  reg         r_uops_2_prs3_busy;	// functional-unit.scala:229:23
  reg         r_uops_2_ppred_busy;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_2_stale_pdst;	// functional-unit.scala:229:23
  reg         r_uops_2_exception;	// functional-unit.scala:229:23
  reg  [63:0] r_uops_2_exc_cause;	// functional-unit.scala:229:23
  reg         r_uops_2_bypassable;	// functional-unit.scala:229:23
  reg  [4:0]  r_uops_2_mem_cmd;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_2_mem_size;	// functional-unit.scala:229:23
  reg         r_uops_2_mem_signed;	// functional-unit.scala:229:23
  reg         r_uops_2_is_fence;	// functional-unit.scala:229:23
  reg         r_uops_2_is_fencei;	// functional-unit.scala:229:23
  reg         r_uops_2_is_amo;	// functional-unit.scala:229:23
  reg         r_uops_2_uses_ldq;	// functional-unit.scala:229:23
  reg         r_uops_2_uses_stq;	// functional-unit.scala:229:23
  reg         r_uops_2_is_sys_pc2epc;	// functional-unit.scala:229:23
  reg         r_uops_2_is_unique;	// functional-unit.scala:229:23
  reg         r_uops_2_flush_on_commit;	// functional-unit.scala:229:23
  reg         r_uops_2_ldst_is_rs1;	// functional-unit.scala:229:23
  reg  [5:0]  r_uops_2_ldst;	// functional-unit.scala:229:23
  reg  [5:0]  r_uops_2_lrs1;	// functional-unit.scala:229:23
  reg  [5:0]  r_uops_2_lrs2;	// functional-unit.scala:229:23
  reg  [5:0]  r_uops_2_lrs3;	// functional-unit.scala:229:23
  reg         r_uops_2_ldst_val;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_2_dst_rtype;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_2_lrs1_rtype;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_2_lrs2_rtype;	// functional-unit.scala:229:23
  reg         r_uops_2_frs3_en;	// functional-unit.scala:229:23
  reg         r_uops_2_fp_val;	// functional-unit.scala:229:23
  reg         r_uops_2_fp_single;	// functional-unit.scala:229:23
  reg         r_uops_2_xcpt_pf_if;	// functional-unit.scala:229:23
  reg         r_uops_2_xcpt_ae_if;	// functional-unit.scala:229:23
  reg         r_uops_2_xcpt_ma_if;	// functional-unit.scala:229:23
  reg         r_uops_2_bp_debug_if;	// functional-unit.scala:229:23
  reg         r_uops_2_bp_xcpt_if;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_2_debug_fsrc;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_2_debug_tsrc;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_3_uopc;	// functional-unit.scala:229:23
  reg  [31:0] r_uops_3_inst;	// functional-unit.scala:229:23
  reg  [31:0] r_uops_3_debug_inst;	// functional-unit.scala:229:23
  reg         r_uops_3_is_rvc;	// functional-unit.scala:229:23
  reg  [39:0] r_uops_3_debug_pc;	// functional-unit.scala:229:23
  reg  [2:0]  r_uops_3_iq_type;	// functional-unit.scala:229:23
  reg  [9:0]  r_uops_3_fu_code;	// functional-unit.scala:229:23
  reg  [3:0]  r_uops_3_ctrl_br_type;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_3_ctrl_op1_sel;	// functional-unit.scala:229:23
  reg  [2:0]  r_uops_3_ctrl_op2_sel;	// functional-unit.scala:229:23
  reg  [2:0]  r_uops_3_ctrl_imm_sel;	// functional-unit.scala:229:23
  reg  [3:0]  r_uops_3_ctrl_op_fcn;	// functional-unit.scala:229:23
  reg         r_uops_3_ctrl_fcn_dw;	// functional-unit.scala:229:23
  reg  [2:0]  r_uops_3_ctrl_csr_cmd;	// functional-unit.scala:229:23
  reg         r_uops_3_ctrl_is_load;	// functional-unit.scala:229:23
  reg         r_uops_3_ctrl_is_sta;	// functional-unit.scala:229:23
  reg         r_uops_3_ctrl_is_std;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_3_iw_state;	// functional-unit.scala:229:23
  reg         r_uops_3_iw_p1_poisoned;	// functional-unit.scala:229:23
  reg         r_uops_3_iw_p2_poisoned;	// functional-unit.scala:229:23
  reg         r_uops_3_is_br;	// functional-unit.scala:229:23
  reg         r_uops_3_is_jalr;	// functional-unit.scala:229:23
  reg         r_uops_3_is_jal;	// functional-unit.scala:229:23
  reg         r_uops_3_is_sfb;	// functional-unit.scala:229:23
  reg  [19:0] r_uops_3_br_mask;	// functional-unit.scala:229:23
  reg  [4:0]  r_uops_3_br_tag;	// functional-unit.scala:229:23
  reg  [5:0]  r_uops_3_ftq_idx;	// functional-unit.scala:229:23
  reg         r_uops_3_edge_inst;	// functional-unit.scala:229:23
  reg  [5:0]  r_uops_3_pc_lob;	// functional-unit.scala:229:23
  reg         r_uops_3_taken;	// functional-unit.scala:229:23
  reg  [19:0] r_uops_3_imm_packed;	// functional-unit.scala:229:23
  reg  [11:0] r_uops_3_csr_addr;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_3_rob_idx;	// functional-unit.scala:229:23
  reg  [4:0]  r_uops_3_ldq_idx;	// functional-unit.scala:229:23
  reg  [4:0]  r_uops_3_stq_idx;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_3_rxq_idx;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_3_pdst;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_3_prs1;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_3_prs2;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_3_prs3;	// functional-unit.scala:229:23
  reg  [5:0]  r_uops_3_ppred;	// functional-unit.scala:229:23
  reg         r_uops_3_prs1_busy;	// functional-unit.scala:229:23
  reg         r_uops_3_prs2_busy;	// functional-unit.scala:229:23
  reg         r_uops_3_prs3_busy;	// functional-unit.scala:229:23
  reg         r_uops_3_ppred_busy;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_3_stale_pdst;	// functional-unit.scala:229:23
  reg         r_uops_3_exception;	// functional-unit.scala:229:23
  reg  [63:0] r_uops_3_exc_cause;	// functional-unit.scala:229:23
  reg         r_uops_3_bypassable;	// functional-unit.scala:229:23
  reg  [4:0]  r_uops_3_mem_cmd;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_3_mem_size;	// functional-unit.scala:229:23
  reg         r_uops_3_mem_signed;	// functional-unit.scala:229:23
  reg         r_uops_3_is_fence;	// functional-unit.scala:229:23
  reg         r_uops_3_is_fencei;	// functional-unit.scala:229:23
  reg         r_uops_3_is_amo;	// functional-unit.scala:229:23
  reg         r_uops_3_uses_ldq;	// functional-unit.scala:229:23
  reg         r_uops_3_uses_stq;	// functional-unit.scala:229:23
  reg         r_uops_3_is_sys_pc2epc;	// functional-unit.scala:229:23
  reg         r_uops_3_is_unique;	// functional-unit.scala:229:23
  reg         r_uops_3_flush_on_commit;	// functional-unit.scala:229:23
  reg         r_uops_3_ldst_is_rs1;	// functional-unit.scala:229:23
  reg  [5:0]  r_uops_3_ldst;	// functional-unit.scala:229:23
  reg  [5:0]  r_uops_3_lrs1;	// functional-unit.scala:229:23
  reg  [5:0]  r_uops_3_lrs2;	// functional-unit.scala:229:23
  reg  [5:0]  r_uops_3_lrs3;	// functional-unit.scala:229:23
  reg         r_uops_3_ldst_val;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_3_dst_rtype;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_3_lrs1_rtype;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_3_lrs2_rtype;	// functional-unit.scala:229:23
  reg         r_uops_3_frs3_en;	// functional-unit.scala:229:23
  reg         r_uops_3_fp_val;	// functional-unit.scala:229:23
  reg         r_uops_3_fp_single;	// functional-unit.scala:229:23
  reg         r_uops_3_xcpt_pf_if;	// functional-unit.scala:229:23
  reg         r_uops_3_xcpt_ae_if;	// functional-unit.scala:229:23
  reg         r_uops_3_xcpt_ma_if;	// functional-unit.scala:229:23
  reg         r_uops_3_bp_debug_if;	// functional-unit.scala:229:23
  reg         r_uops_3_bp_xcpt_if;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_3_debug_fsrc;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_3_debug_tsrc;	// functional-unit.scala:229:23
  wire [19:0] _io_resp_bits_uop_br_mask_output =
    r_uops_3_br_mask & ~io_brupdate_b1_resolve_mask;	// functional-unit.scala:229:23, util.scala:85:{25,27}
  always @(posedge clock) begin
    if (reset) begin
      r_valids_0 <= 1'h0;	// functional-unit.scala:228:27
      r_valids_1 <= 1'h0;	// functional-unit.scala:228:27
      r_valids_2 <= 1'h0;	// functional-unit.scala:228:27
      r_valids_3 <= 1'h0;	// functional-unit.scala:228:27
    end
    else begin
      r_valids_0 <=
        io_req_valid & (io_brupdate_b1_mispredict_mask & io_req_bits_uop_br_mask) == 20'h0
        & ~io_req_bits_kill;	// functional-unit.scala:228:27, :232:{84,87}, util.scala:118:{51,59}
      r_valids_1 <=
        r_valids_0 & (io_brupdate_b1_mispredict_mask & r_uops_0_br_mask) == 20'h0
        & ~io_req_bits_kill;	// functional-unit.scala:228:27, :229:23, :232:87, :238:83, util.scala:118:{51,59}
      r_valids_2 <=
        r_valids_1 & (io_brupdate_b1_mispredict_mask & r_uops_1_br_mask) == 20'h0
        & ~io_req_bits_kill;	// functional-unit.scala:228:27, :229:23, :232:87, :238:83, util.scala:118:{51,59}
      r_valids_3 <=
        r_valids_2 & (io_brupdate_b1_mispredict_mask & r_uops_2_br_mask) == 20'h0
        & ~io_req_bits_kill;	// functional-unit.scala:228:27, :229:23, :232:87, :238:83, util.scala:118:{51,59}
    end
    r_uops_0_uopc <= io_req_bits_uop_uopc;	// functional-unit.scala:229:23
    r_uops_0_inst <= io_req_bits_uop_inst;	// functional-unit.scala:229:23
    r_uops_0_debug_inst <= io_req_bits_uop_debug_inst;	// functional-unit.scala:229:23
    r_uops_0_is_rvc <= io_req_bits_uop_is_rvc;	// functional-unit.scala:229:23
    r_uops_0_debug_pc <= io_req_bits_uop_debug_pc;	// functional-unit.scala:229:23
    r_uops_0_iq_type <= io_req_bits_uop_iq_type;	// functional-unit.scala:229:23
    r_uops_0_fu_code <= io_req_bits_uop_fu_code;	// functional-unit.scala:229:23
    r_uops_0_ctrl_br_type <= io_req_bits_uop_ctrl_br_type;	// functional-unit.scala:229:23
    r_uops_0_ctrl_op1_sel <= io_req_bits_uop_ctrl_op1_sel;	// functional-unit.scala:229:23
    r_uops_0_ctrl_op2_sel <= io_req_bits_uop_ctrl_op2_sel;	// functional-unit.scala:229:23
    r_uops_0_ctrl_imm_sel <= io_req_bits_uop_ctrl_imm_sel;	// functional-unit.scala:229:23
    r_uops_0_ctrl_op_fcn <= io_req_bits_uop_ctrl_op_fcn;	// functional-unit.scala:229:23
    r_uops_0_ctrl_fcn_dw <= io_req_bits_uop_ctrl_fcn_dw;	// functional-unit.scala:229:23
    r_uops_0_ctrl_csr_cmd <= io_req_bits_uop_ctrl_csr_cmd;	// functional-unit.scala:229:23
    r_uops_0_ctrl_is_load <= io_req_bits_uop_ctrl_is_load;	// functional-unit.scala:229:23
    r_uops_0_ctrl_is_sta <= io_req_bits_uop_ctrl_is_sta;	// functional-unit.scala:229:23
    r_uops_0_ctrl_is_std <= io_req_bits_uop_ctrl_is_std;	// functional-unit.scala:229:23
    r_uops_0_iw_state <= io_req_bits_uop_iw_state;	// functional-unit.scala:229:23
    r_uops_0_iw_p1_poisoned <= io_req_bits_uop_iw_p1_poisoned;	// functional-unit.scala:229:23
    r_uops_0_iw_p2_poisoned <= io_req_bits_uop_iw_p2_poisoned;	// functional-unit.scala:229:23
    r_uops_0_is_br <= io_req_bits_uop_is_br;	// functional-unit.scala:229:23
    r_uops_0_is_jalr <= io_req_bits_uop_is_jalr;	// functional-unit.scala:229:23
    r_uops_0_is_jal <= io_req_bits_uop_is_jal;	// functional-unit.scala:229:23
    r_uops_0_is_sfb <= io_req_bits_uop_is_sfb;	// functional-unit.scala:229:23
    r_uops_0_br_mask <= io_req_bits_uop_br_mask & ~io_brupdate_b1_resolve_mask;	// functional-unit.scala:229:23, util.scala:85:{25,27}
    r_uops_0_br_tag <= io_req_bits_uop_br_tag;	// functional-unit.scala:229:23
    r_uops_0_ftq_idx <= io_req_bits_uop_ftq_idx;	// functional-unit.scala:229:23
    r_uops_0_edge_inst <= io_req_bits_uop_edge_inst;	// functional-unit.scala:229:23
    r_uops_0_pc_lob <= io_req_bits_uop_pc_lob;	// functional-unit.scala:229:23
    r_uops_0_taken <= io_req_bits_uop_taken;	// functional-unit.scala:229:23
    r_uops_0_imm_packed <= io_req_bits_uop_imm_packed;	// functional-unit.scala:229:23
    r_uops_0_csr_addr <= io_req_bits_uop_csr_addr;	// functional-unit.scala:229:23
    r_uops_0_rob_idx <= io_req_bits_uop_rob_idx;	// functional-unit.scala:229:23
    r_uops_0_ldq_idx <= io_req_bits_uop_ldq_idx;	// functional-unit.scala:229:23
    r_uops_0_stq_idx <= io_req_bits_uop_stq_idx;	// functional-unit.scala:229:23
    r_uops_0_rxq_idx <= io_req_bits_uop_rxq_idx;	// functional-unit.scala:229:23
    r_uops_0_pdst <= io_req_bits_uop_pdst;	// functional-unit.scala:229:23
    r_uops_0_prs1 <= io_req_bits_uop_prs1;	// functional-unit.scala:229:23
    r_uops_0_prs2 <= io_req_bits_uop_prs2;	// functional-unit.scala:229:23
    r_uops_0_prs3 <= io_req_bits_uop_prs3;	// functional-unit.scala:229:23
    r_uops_0_ppred <= io_req_bits_uop_ppred;	// functional-unit.scala:229:23
    r_uops_0_prs1_busy <= io_req_bits_uop_prs1_busy;	// functional-unit.scala:229:23
    r_uops_0_prs2_busy <= io_req_bits_uop_prs2_busy;	// functional-unit.scala:229:23
    r_uops_0_prs3_busy <= io_req_bits_uop_prs3_busy;	// functional-unit.scala:229:23
    r_uops_0_ppred_busy <= io_req_bits_uop_ppred_busy;	// functional-unit.scala:229:23
    r_uops_0_stale_pdst <= io_req_bits_uop_stale_pdst;	// functional-unit.scala:229:23
    r_uops_0_exception <= io_req_bits_uop_exception;	// functional-unit.scala:229:23
    r_uops_0_exc_cause <= io_req_bits_uop_exc_cause;	// functional-unit.scala:229:23
    r_uops_0_bypassable <= io_req_bits_uop_bypassable;	// functional-unit.scala:229:23
    r_uops_0_mem_cmd <= io_req_bits_uop_mem_cmd;	// functional-unit.scala:229:23
    r_uops_0_mem_size <= io_req_bits_uop_mem_size;	// functional-unit.scala:229:23
    r_uops_0_mem_signed <= io_req_bits_uop_mem_signed;	// functional-unit.scala:229:23
    r_uops_0_is_fence <= io_req_bits_uop_is_fence;	// functional-unit.scala:229:23
    r_uops_0_is_fencei <= io_req_bits_uop_is_fencei;	// functional-unit.scala:229:23
    r_uops_0_is_amo <= io_req_bits_uop_is_amo;	// functional-unit.scala:229:23
    r_uops_0_uses_ldq <= io_req_bits_uop_uses_ldq;	// functional-unit.scala:229:23
    r_uops_0_uses_stq <= io_req_bits_uop_uses_stq;	// functional-unit.scala:229:23
    r_uops_0_is_sys_pc2epc <= io_req_bits_uop_is_sys_pc2epc;	// functional-unit.scala:229:23
    r_uops_0_is_unique <= io_req_bits_uop_is_unique;	// functional-unit.scala:229:23
    r_uops_0_flush_on_commit <= io_req_bits_uop_flush_on_commit;	// functional-unit.scala:229:23
    r_uops_0_ldst_is_rs1 <= io_req_bits_uop_ldst_is_rs1;	// functional-unit.scala:229:23
    r_uops_0_ldst <= io_req_bits_uop_ldst;	// functional-unit.scala:229:23
    r_uops_0_lrs1 <= io_req_bits_uop_lrs1;	// functional-unit.scala:229:23
    r_uops_0_lrs2 <= io_req_bits_uop_lrs2;	// functional-unit.scala:229:23
    r_uops_0_lrs3 <= io_req_bits_uop_lrs3;	// functional-unit.scala:229:23
    r_uops_0_ldst_val <= io_req_bits_uop_ldst_val;	// functional-unit.scala:229:23
    r_uops_0_dst_rtype <= io_req_bits_uop_dst_rtype;	// functional-unit.scala:229:23
    r_uops_0_lrs1_rtype <= io_req_bits_uop_lrs1_rtype;	// functional-unit.scala:229:23
    r_uops_0_lrs2_rtype <= io_req_bits_uop_lrs2_rtype;	// functional-unit.scala:229:23
    r_uops_0_frs3_en <= io_req_bits_uop_frs3_en;	// functional-unit.scala:229:23
    r_uops_0_fp_val <= io_req_bits_uop_fp_val;	// functional-unit.scala:229:23
    r_uops_0_fp_single <= io_req_bits_uop_fp_single;	// functional-unit.scala:229:23
    r_uops_0_xcpt_pf_if <= io_req_bits_uop_xcpt_pf_if;	// functional-unit.scala:229:23
    r_uops_0_xcpt_ae_if <= io_req_bits_uop_xcpt_ae_if;	// functional-unit.scala:229:23
    r_uops_0_xcpt_ma_if <= io_req_bits_uop_xcpt_ma_if;	// functional-unit.scala:229:23
    r_uops_0_bp_debug_if <= io_req_bits_uop_bp_debug_if;	// functional-unit.scala:229:23
    r_uops_0_bp_xcpt_if <= io_req_bits_uop_bp_xcpt_if;	// functional-unit.scala:229:23
    r_uops_0_debug_fsrc <= io_req_bits_uop_debug_fsrc;	// functional-unit.scala:229:23
    r_uops_0_debug_tsrc <= io_req_bits_uop_debug_tsrc;	// functional-unit.scala:229:23
    r_uops_1_uopc <= r_uops_0_uopc;	// functional-unit.scala:229:23
    r_uops_1_inst <= r_uops_0_inst;	// functional-unit.scala:229:23
    r_uops_1_debug_inst <= r_uops_0_debug_inst;	// functional-unit.scala:229:23
    r_uops_1_is_rvc <= r_uops_0_is_rvc;	// functional-unit.scala:229:23
    r_uops_1_debug_pc <= r_uops_0_debug_pc;	// functional-unit.scala:229:23
    r_uops_1_iq_type <= r_uops_0_iq_type;	// functional-unit.scala:229:23
    r_uops_1_fu_code <= r_uops_0_fu_code;	// functional-unit.scala:229:23
    r_uops_1_ctrl_br_type <= r_uops_0_ctrl_br_type;	// functional-unit.scala:229:23
    r_uops_1_ctrl_op1_sel <= r_uops_0_ctrl_op1_sel;	// functional-unit.scala:229:23
    r_uops_1_ctrl_op2_sel <= r_uops_0_ctrl_op2_sel;	// functional-unit.scala:229:23
    r_uops_1_ctrl_imm_sel <= r_uops_0_ctrl_imm_sel;	// functional-unit.scala:229:23
    r_uops_1_ctrl_op_fcn <= r_uops_0_ctrl_op_fcn;	// functional-unit.scala:229:23
    r_uops_1_ctrl_fcn_dw <= r_uops_0_ctrl_fcn_dw;	// functional-unit.scala:229:23
    r_uops_1_ctrl_csr_cmd <= r_uops_0_ctrl_csr_cmd;	// functional-unit.scala:229:23
    r_uops_1_ctrl_is_load <= r_uops_0_ctrl_is_load;	// functional-unit.scala:229:23
    r_uops_1_ctrl_is_sta <= r_uops_0_ctrl_is_sta;	// functional-unit.scala:229:23
    r_uops_1_ctrl_is_std <= r_uops_0_ctrl_is_std;	// functional-unit.scala:229:23
    r_uops_1_iw_state <= r_uops_0_iw_state;	// functional-unit.scala:229:23
    r_uops_1_iw_p1_poisoned <= r_uops_0_iw_p1_poisoned;	// functional-unit.scala:229:23
    r_uops_1_iw_p2_poisoned <= r_uops_0_iw_p2_poisoned;	// functional-unit.scala:229:23
    r_uops_1_is_br <= r_uops_0_is_br;	// functional-unit.scala:229:23
    r_uops_1_is_jalr <= r_uops_0_is_jalr;	// functional-unit.scala:229:23
    r_uops_1_is_jal <= r_uops_0_is_jal;	// functional-unit.scala:229:23
    r_uops_1_is_sfb <= r_uops_0_is_sfb;	// functional-unit.scala:229:23
    r_uops_1_br_mask <= r_uops_0_br_mask & ~io_brupdate_b1_resolve_mask;	// functional-unit.scala:229:23, util.scala:85:{25,27}
    r_uops_1_br_tag <= r_uops_0_br_tag;	// functional-unit.scala:229:23
    r_uops_1_ftq_idx <= r_uops_0_ftq_idx;	// functional-unit.scala:229:23
    r_uops_1_edge_inst <= r_uops_0_edge_inst;	// functional-unit.scala:229:23
    r_uops_1_pc_lob <= r_uops_0_pc_lob;	// functional-unit.scala:229:23
    r_uops_1_taken <= r_uops_0_taken;	// functional-unit.scala:229:23
    r_uops_1_imm_packed <= r_uops_0_imm_packed;	// functional-unit.scala:229:23
    r_uops_1_csr_addr <= r_uops_0_csr_addr;	// functional-unit.scala:229:23
    r_uops_1_rob_idx <= r_uops_0_rob_idx;	// functional-unit.scala:229:23
    r_uops_1_ldq_idx <= r_uops_0_ldq_idx;	// functional-unit.scala:229:23
    r_uops_1_stq_idx <= r_uops_0_stq_idx;	// functional-unit.scala:229:23
    r_uops_1_rxq_idx <= r_uops_0_rxq_idx;	// functional-unit.scala:229:23
    r_uops_1_pdst <= r_uops_0_pdst;	// functional-unit.scala:229:23
    r_uops_1_prs1 <= r_uops_0_prs1;	// functional-unit.scala:229:23
    r_uops_1_prs2 <= r_uops_0_prs2;	// functional-unit.scala:229:23
    r_uops_1_prs3 <= r_uops_0_prs3;	// functional-unit.scala:229:23
    r_uops_1_ppred <= r_uops_0_ppred;	// functional-unit.scala:229:23
    r_uops_1_prs1_busy <= r_uops_0_prs1_busy;	// functional-unit.scala:229:23
    r_uops_1_prs2_busy <= r_uops_0_prs2_busy;	// functional-unit.scala:229:23
    r_uops_1_prs3_busy <= r_uops_0_prs3_busy;	// functional-unit.scala:229:23
    r_uops_1_ppred_busy <= r_uops_0_ppred_busy;	// functional-unit.scala:229:23
    r_uops_1_stale_pdst <= r_uops_0_stale_pdst;	// functional-unit.scala:229:23
    r_uops_1_exception <= r_uops_0_exception;	// functional-unit.scala:229:23
    r_uops_1_exc_cause <= r_uops_0_exc_cause;	// functional-unit.scala:229:23
    r_uops_1_bypassable <= r_uops_0_bypassable;	// functional-unit.scala:229:23
    r_uops_1_mem_cmd <= r_uops_0_mem_cmd;	// functional-unit.scala:229:23
    r_uops_1_mem_size <= r_uops_0_mem_size;	// functional-unit.scala:229:23
    r_uops_1_mem_signed <= r_uops_0_mem_signed;	// functional-unit.scala:229:23
    r_uops_1_is_fence <= r_uops_0_is_fence;	// functional-unit.scala:229:23
    r_uops_1_is_fencei <= r_uops_0_is_fencei;	// functional-unit.scala:229:23
    r_uops_1_is_amo <= r_uops_0_is_amo;	// functional-unit.scala:229:23
    r_uops_1_uses_ldq <= r_uops_0_uses_ldq;	// functional-unit.scala:229:23
    r_uops_1_uses_stq <= r_uops_0_uses_stq;	// functional-unit.scala:229:23
    r_uops_1_is_sys_pc2epc <= r_uops_0_is_sys_pc2epc;	// functional-unit.scala:229:23
    r_uops_1_is_unique <= r_uops_0_is_unique;	// functional-unit.scala:229:23
    r_uops_1_flush_on_commit <= r_uops_0_flush_on_commit;	// functional-unit.scala:229:23
    r_uops_1_ldst_is_rs1 <= r_uops_0_ldst_is_rs1;	// functional-unit.scala:229:23
    r_uops_1_ldst <= r_uops_0_ldst;	// functional-unit.scala:229:23
    r_uops_1_lrs1 <= r_uops_0_lrs1;	// functional-unit.scala:229:23
    r_uops_1_lrs2 <= r_uops_0_lrs2;	// functional-unit.scala:229:23
    r_uops_1_lrs3 <= r_uops_0_lrs3;	// functional-unit.scala:229:23
    r_uops_1_ldst_val <= r_uops_0_ldst_val;	// functional-unit.scala:229:23
    r_uops_1_dst_rtype <= r_uops_0_dst_rtype;	// functional-unit.scala:229:23
    r_uops_1_lrs1_rtype <= r_uops_0_lrs1_rtype;	// functional-unit.scala:229:23
    r_uops_1_lrs2_rtype <= r_uops_0_lrs2_rtype;	// functional-unit.scala:229:23
    r_uops_1_frs3_en <= r_uops_0_frs3_en;	// functional-unit.scala:229:23
    r_uops_1_fp_val <= r_uops_0_fp_val;	// functional-unit.scala:229:23
    r_uops_1_fp_single <= r_uops_0_fp_single;	// functional-unit.scala:229:23
    r_uops_1_xcpt_pf_if <= r_uops_0_xcpt_pf_if;	// functional-unit.scala:229:23
    r_uops_1_xcpt_ae_if <= r_uops_0_xcpt_ae_if;	// functional-unit.scala:229:23
    r_uops_1_xcpt_ma_if <= r_uops_0_xcpt_ma_if;	// functional-unit.scala:229:23
    r_uops_1_bp_debug_if <= r_uops_0_bp_debug_if;	// functional-unit.scala:229:23
    r_uops_1_bp_xcpt_if <= r_uops_0_bp_xcpt_if;	// functional-unit.scala:229:23
    r_uops_1_debug_fsrc <= r_uops_0_debug_fsrc;	// functional-unit.scala:229:23
    r_uops_1_debug_tsrc <= r_uops_0_debug_tsrc;	// functional-unit.scala:229:23
    r_uops_2_uopc <= r_uops_1_uopc;	// functional-unit.scala:229:23
    r_uops_2_inst <= r_uops_1_inst;	// functional-unit.scala:229:23
    r_uops_2_debug_inst <= r_uops_1_debug_inst;	// functional-unit.scala:229:23
    r_uops_2_is_rvc <= r_uops_1_is_rvc;	// functional-unit.scala:229:23
    r_uops_2_debug_pc <= r_uops_1_debug_pc;	// functional-unit.scala:229:23
    r_uops_2_iq_type <= r_uops_1_iq_type;	// functional-unit.scala:229:23
    r_uops_2_fu_code <= r_uops_1_fu_code;	// functional-unit.scala:229:23
    r_uops_2_ctrl_br_type <= r_uops_1_ctrl_br_type;	// functional-unit.scala:229:23
    r_uops_2_ctrl_op1_sel <= r_uops_1_ctrl_op1_sel;	// functional-unit.scala:229:23
    r_uops_2_ctrl_op2_sel <= r_uops_1_ctrl_op2_sel;	// functional-unit.scala:229:23
    r_uops_2_ctrl_imm_sel <= r_uops_1_ctrl_imm_sel;	// functional-unit.scala:229:23
    r_uops_2_ctrl_op_fcn <= r_uops_1_ctrl_op_fcn;	// functional-unit.scala:229:23
    r_uops_2_ctrl_fcn_dw <= r_uops_1_ctrl_fcn_dw;	// functional-unit.scala:229:23
    r_uops_2_ctrl_csr_cmd <= r_uops_1_ctrl_csr_cmd;	// functional-unit.scala:229:23
    r_uops_2_ctrl_is_load <= r_uops_1_ctrl_is_load;	// functional-unit.scala:229:23
    r_uops_2_ctrl_is_sta <= r_uops_1_ctrl_is_sta;	// functional-unit.scala:229:23
    r_uops_2_ctrl_is_std <= r_uops_1_ctrl_is_std;	// functional-unit.scala:229:23
    r_uops_2_iw_state <= r_uops_1_iw_state;	// functional-unit.scala:229:23
    r_uops_2_iw_p1_poisoned <= r_uops_1_iw_p1_poisoned;	// functional-unit.scala:229:23
    r_uops_2_iw_p2_poisoned <= r_uops_1_iw_p2_poisoned;	// functional-unit.scala:229:23
    r_uops_2_is_br <= r_uops_1_is_br;	// functional-unit.scala:229:23
    r_uops_2_is_jalr <= r_uops_1_is_jalr;	// functional-unit.scala:229:23
    r_uops_2_is_jal <= r_uops_1_is_jal;	// functional-unit.scala:229:23
    r_uops_2_is_sfb <= r_uops_1_is_sfb;	// functional-unit.scala:229:23
    r_uops_2_br_mask <= r_uops_1_br_mask & ~io_brupdate_b1_resolve_mask;	// functional-unit.scala:229:23, util.scala:85:{25,27}
    r_uops_2_br_tag <= r_uops_1_br_tag;	// functional-unit.scala:229:23
    r_uops_2_ftq_idx <= r_uops_1_ftq_idx;	// functional-unit.scala:229:23
    r_uops_2_edge_inst <= r_uops_1_edge_inst;	// functional-unit.scala:229:23
    r_uops_2_pc_lob <= r_uops_1_pc_lob;	// functional-unit.scala:229:23
    r_uops_2_taken <= r_uops_1_taken;	// functional-unit.scala:229:23
    r_uops_2_imm_packed <= r_uops_1_imm_packed;	// functional-unit.scala:229:23
    r_uops_2_csr_addr <= r_uops_1_csr_addr;	// functional-unit.scala:229:23
    r_uops_2_rob_idx <= r_uops_1_rob_idx;	// functional-unit.scala:229:23
    r_uops_2_ldq_idx <= r_uops_1_ldq_idx;	// functional-unit.scala:229:23
    r_uops_2_stq_idx <= r_uops_1_stq_idx;	// functional-unit.scala:229:23
    r_uops_2_rxq_idx <= r_uops_1_rxq_idx;	// functional-unit.scala:229:23
    r_uops_2_pdst <= r_uops_1_pdst;	// functional-unit.scala:229:23
    r_uops_2_prs1 <= r_uops_1_prs1;	// functional-unit.scala:229:23
    r_uops_2_prs2 <= r_uops_1_prs2;	// functional-unit.scala:229:23
    r_uops_2_prs3 <= r_uops_1_prs3;	// functional-unit.scala:229:23
    r_uops_2_ppred <= r_uops_1_ppred;	// functional-unit.scala:229:23
    r_uops_2_prs1_busy <= r_uops_1_prs1_busy;	// functional-unit.scala:229:23
    r_uops_2_prs2_busy <= r_uops_1_prs2_busy;	// functional-unit.scala:229:23
    r_uops_2_prs3_busy <= r_uops_1_prs3_busy;	// functional-unit.scala:229:23
    r_uops_2_ppred_busy <= r_uops_1_ppred_busy;	// functional-unit.scala:229:23
    r_uops_2_stale_pdst <= r_uops_1_stale_pdst;	// functional-unit.scala:229:23
    r_uops_2_exception <= r_uops_1_exception;	// functional-unit.scala:229:23
    r_uops_2_exc_cause <= r_uops_1_exc_cause;	// functional-unit.scala:229:23
    r_uops_2_bypassable <= r_uops_1_bypassable;	// functional-unit.scala:229:23
    r_uops_2_mem_cmd <= r_uops_1_mem_cmd;	// functional-unit.scala:229:23
    r_uops_2_mem_size <= r_uops_1_mem_size;	// functional-unit.scala:229:23
    r_uops_2_mem_signed <= r_uops_1_mem_signed;	// functional-unit.scala:229:23
    r_uops_2_is_fence <= r_uops_1_is_fence;	// functional-unit.scala:229:23
    r_uops_2_is_fencei <= r_uops_1_is_fencei;	// functional-unit.scala:229:23
    r_uops_2_is_amo <= r_uops_1_is_amo;	// functional-unit.scala:229:23
    r_uops_2_uses_ldq <= r_uops_1_uses_ldq;	// functional-unit.scala:229:23
    r_uops_2_uses_stq <= r_uops_1_uses_stq;	// functional-unit.scala:229:23
    r_uops_2_is_sys_pc2epc <= r_uops_1_is_sys_pc2epc;	// functional-unit.scala:229:23
    r_uops_2_is_unique <= r_uops_1_is_unique;	// functional-unit.scala:229:23
    r_uops_2_flush_on_commit <= r_uops_1_flush_on_commit;	// functional-unit.scala:229:23
    r_uops_2_ldst_is_rs1 <= r_uops_1_ldst_is_rs1;	// functional-unit.scala:229:23
    r_uops_2_ldst <= r_uops_1_ldst;	// functional-unit.scala:229:23
    r_uops_2_lrs1 <= r_uops_1_lrs1;	// functional-unit.scala:229:23
    r_uops_2_lrs2 <= r_uops_1_lrs2;	// functional-unit.scala:229:23
    r_uops_2_lrs3 <= r_uops_1_lrs3;	// functional-unit.scala:229:23
    r_uops_2_ldst_val <= r_uops_1_ldst_val;	// functional-unit.scala:229:23
    r_uops_2_dst_rtype <= r_uops_1_dst_rtype;	// functional-unit.scala:229:23
    r_uops_2_lrs1_rtype <= r_uops_1_lrs1_rtype;	// functional-unit.scala:229:23
    r_uops_2_lrs2_rtype <= r_uops_1_lrs2_rtype;	// functional-unit.scala:229:23
    r_uops_2_frs3_en <= r_uops_1_frs3_en;	// functional-unit.scala:229:23
    r_uops_2_fp_val <= r_uops_1_fp_val;	// functional-unit.scala:229:23
    r_uops_2_fp_single <= r_uops_1_fp_single;	// functional-unit.scala:229:23
    r_uops_2_xcpt_pf_if <= r_uops_1_xcpt_pf_if;	// functional-unit.scala:229:23
    r_uops_2_xcpt_ae_if <= r_uops_1_xcpt_ae_if;	// functional-unit.scala:229:23
    r_uops_2_xcpt_ma_if <= r_uops_1_xcpt_ma_if;	// functional-unit.scala:229:23
    r_uops_2_bp_debug_if <= r_uops_1_bp_debug_if;	// functional-unit.scala:229:23
    r_uops_2_bp_xcpt_if <= r_uops_1_bp_xcpt_if;	// functional-unit.scala:229:23
    r_uops_2_debug_fsrc <= r_uops_1_debug_fsrc;	// functional-unit.scala:229:23
    r_uops_2_debug_tsrc <= r_uops_1_debug_tsrc;	// functional-unit.scala:229:23
    r_uops_3_uopc <= r_uops_2_uopc;	// functional-unit.scala:229:23
    r_uops_3_inst <= r_uops_2_inst;	// functional-unit.scala:229:23
    r_uops_3_debug_inst <= r_uops_2_debug_inst;	// functional-unit.scala:229:23
    r_uops_3_is_rvc <= r_uops_2_is_rvc;	// functional-unit.scala:229:23
    r_uops_3_debug_pc <= r_uops_2_debug_pc;	// functional-unit.scala:229:23
    r_uops_3_iq_type <= r_uops_2_iq_type;	// functional-unit.scala:229:23
    r_uops_3_fu_code <= r_uops_2_fu_code;	// functional-unit.scala:229:23
    r_uops_3_ctrl_br_type <= r_uops_2_ctrl_br_type;	// functional-unit.scala:229:23
    r_uops_3_ctrl_op1_sel <= r_uops_2_ctrl_op1_sel;	// functional-unit.scala:229:23
    r_uops_3_ctrl_op2_sel <= r_uops_2_ctrl_op2_sel;	// functional-unit.scala:229:23
    r_uops_3_ctrl_imm_sel <= r_uops_2_ctrl_imm_sel;	// functional-unit.scala:229:23
    r_uops_3_ctrl_op_fcn <= r_uops_2_ctrl_op_fcn;	// functional-unit.scala:229:23
    r_uops_3_ctrl_fcn_dw <= r_uops_2_ctrl_fcn_dw;	// functional-unit.scala:229:23
    r_uops_3_ctrl_csr_cmd <= r_uops_2_ctrl_csr_cmd;	// functional-unit.scala:229:23
    r_uops_3_ctrl_is_load <= r_uops_2_ctrl_is_load;	// functional-unit.scala:229:23
    r_uops_3_ctrl_is_sta <= r_uops_2_ctrl_is_sta;	// functional-unit.scala:229:23
    r_uops_3_ctrl_is_std <= r_uops_2_ctrl_is_std;	// functional-unit.scala:229:23
    r_uops_3_iw_state <= r_uops_2_iw_state;	// functional-unit.scala:229:23
    r_uops_3_iw_p1_poisoned <= r_uops_2_iw_p1_poisoned;	// functional-unit.scala:229:23
    r_uops_3_iw_p2_poisoned <= r_uops_2_iw_p2_poisoned;	// functional-unit.scala:229:23
    r_uops_3_is_br <= r_uops_2_is_br;	// functional-unit.scala:229:23
    r_uops_3_is_jalr <= r_uops_2_is_jalr;	// functional-unit.scala:229:23
    r_uops_3_is_jal <= r_uops_2_is_jal;	// functional-unit.scala:229:23
    r_uops_3_is_sfb <= r_uops_2_is_sfb;	// functional-unit.scala:229:23
    r_uops_3_br_mask <= r_uops_2_br_mask & ~io_brupdate_b1_resolve_mask;	// functional-unit.scala:229:23, util.scala:85:{25,27}
    r_uops_3_br_tag <= r_uops_2_br_tag;	// functional-unit.scala:229:23
    r_uops_3_ftq_idx <= r_uops_2_ftq_idx;	// functional-unit.scala:229:23
    r_uops_3_edge_inst <= r_uops_2_edge_inst;	// functional-unit.scala:229:23
    r_uops_3_pc_lob <= r_uops_2_pc_lob;	// functional-unit.scala:229:23
    r_uops_3_taken <= r_uops_2_taken;	// functional-unit.scala:229:23
    r_uops_3_imm_packed <= r_uops_2_imm_packed;	// functional-unit.scala:229:23
    r_uops_3_csr_addr <= r_uops_2_csr_addr;	// functional-unit.scala:229:23
    r_uops_3_rob_idx <= r_uops_2_rob_idx;	// functional-unit.scala:229:23
    r_uops_3_ldq_idx <= r_uops_2_ldq_idx;	// functional-unit.scala:229:23
    r_uops_3_stq_idx <= r_uops_2_stq_idx;	// functional-unit.scala:229:23
    r_uops_3_rxq_idx <= r_uops_2_rxq_idx;	// functional-unit.scala:229:23
    r_uops_3_pdst <= r_uops_2_pdst;	// functional-unit.scala:229:23
    r_uops_3_prs1 <= r_uops_2_prs1;	// functional-unit.scala:229:23
    r_uops_3_prs2 <= r_uops_2_prs2;	// functional-unit.scala:229:23
    r_uops_3_prs3 <= r_uops_2_prs3;	// functional-unit.scala:229:23
    r_uops_3_ppred <= r_uops_2_ppred;	// functional-unit.scala:229:23
    r_uops_3_prs1_busy <= r_uops_2_prs1_busy;	// functional-unit.scala:229:23
    r_uops_3_prs2_busy <= r_uops_2_prs2_busy;	// functional-unit.scala:229:23
    r_uops_3_prs3_busy <= r_uops_2_prs3_busy;	// functional-unit.scala:229:23
    r_uops_3_ppred_busy <= r_uops_2_ppred_busy;	// functional-unit.scala:229:23
    r_uops_3_stale_pdst <= r_uops_2_stale_pdst;	// functional-unit.scala:229:23
    r_uops_3_exception <= r_uops_2_exception;	// functional-unit.scala:229:23
    r_uops_3_exc_cause <= r_uops_2_exc_cause;	// functional-unit.scala:229:23
    r_uops_3_bypassable <= r_uops_2_bypassable;	// functional-unit.scala:229:23
    r_uops_3_mem_cmd <= r_uops_2_mem_cmd;	// functional-unit.scala:229:23
    r_uops_3_mem_size <= r_uops_2_mem_size;	// functional-unit.scala:229:23
    r_uops_3_mem_signed <= r_uops_2_mem_signed;	// functional-unit.scala:229:23
    r_uops_3_is_fence <= r_uops_2_is_fence;	// functional-unit.scala:229:23
    r_uops_3_is_fencei <= r_uops_2_is_fencei;	// functional-unit.scala:229:23
    r_uops_3_is_amo <= r_uops_2_is_amo;	// functional-unit.scala:229:23
    r_uops_3_uses_ldq <= r_uops_2_uses_ldq;	// functional-unit.scala:229:23
    r_uops_3_uses_stq <= r_uops_2_uses_stq;	// functional-unit.scala:229:23
    r_uops_3_is_sys_pc2epc <= r_uops_2_is_sys_pc2epc;	// functional-unit.scala:229:23
    r_uops_3_is_unique <= r_uops_2_is_unique;	// functional-unit.scala:229:23
    r_uops_3_flush_on_commit <= r_uops_2_flush_on_commit;	// functional-unit.scala:229:23
    r_uops_3_ldst_is_rs1 <= r_uops_2_ldst_is_rs1;	// functional-unit.scala:229:23
    r_uops_3_ldst <= r_uops_2_ldst;	// functional-unit.scala:229:23
    r_uops_3_lrs1 <= r_uops_2_lrs1;	// functional-unit.scala:229:23
    r_uops_3_lrs2 <= r_uops_2_lrs2;	// functional-unit.scala:229:23
    r_uops_3_lrs3 <= r_uops_2_lrs3;	// functional-unit.scala:229:23
    r_uops_3_ldst_val <= r_uops_2_ldst_val;	// functional-unit.scala:229:23
    r_uops_3_dst_rtype <= r_uops_2_dst_rtype;	// functional-unit.scala:229:23
    r_uops_3_lrs1_rtype <= r_uops_2_lrs1_rtype;	// functional-unit.scala:229:23
    r_uops_3_lrs2_rtype <= r_uops_2_lrs2_rtype;	// functional-unit.scala:229:23
    r_uops_3_frs3_en <= r_uops_2_frs3_en;	// functional-unit.scala:229:23
    r_uops_3_fp_val <= r_uops_2_fp_val;	// functional-unit.scala:229:23
    r_uops_3_fp_single <= r_uops_2_fp_single;	// functional-unit.scala:229:23
    r_uops_3_xcpt_pf_if <= r_uops_2_xcpt_pf_if;	// functional-unit.scala:229:23
    r_uops_3_xcpt_ae_if <= r_uops_2_xcpt_ae_if;	// functional-unit.scala:229:23
    r_uops_3_xcpt_ma_if <= r_uops_2_xcpt_ma_if;	// functional-unit.scala:229:23
    r_uops_3_bp_debug_if <= r_uops_2_bp_debug_if;	// functional-unit.scala:229:23
    r_uops_3_bp_xcpt_if <= r_uops_2_bp_xcpt_if;	// functional-unit.scala:229:23
    r_uops_3_debug_fsrc <= r_uops_2_debug_fsrc;	// functional-unit.scala:229:23
    r_uops_3_debug_tsrc <= r_uops_2_debug_tsrc;	// functional-unit.scala:229:23
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
        r_valids_0 = _RANDOM[6'h0][0];	// functional-unit.scala:228:27
        r_valids_1 = _RANDOM[6'h0][1];	// functional-unit.scala:228:27
        r_valids_2 = _RANDOM[6'h0][2];	// functional-unit.scala:228:27
        r_valids_3 = _RANDOM[6'h0][3];	// functional-unit.scala:228:27
        r_uops_0_uopc = _RANDOM[6'h0][10:4];	// functional-unit.scala:228:27, :229:23
        r_uops_0_inst = {_RANDOM[6'h0][31:11], _RANDOM[6'h1][10:0]};	// functional-unit.scala:228:27, :229:23
        r_uops_0_debug_inst = {_RANDOM[6'h1][31:11], _RANDOM[6'h2][10:0]};	// functional-unit.scala:229:23
        r_uops_0_is_rvc = _RANDOM[6'h2][11];	// functional-unit.scala:229:23
        r_uops_0_debug_pc = {_RANDOM[6'h2][31:12], _RANDOM[6'h3][19:0]};	// functional-unit.scala:229:23
        r_uops_0_iq_type = _RANDOM[6'h3][22:20];	// functional-unit.scala:229:23
        r_uops_0_fu_code = {_RANDOM[6'h3][31:23], _RANDOM[6'h4][0]};	// functional-unit.scala:229:23
        r_uops_0_ctrl_br_type = _RANDOM[6'h4][4:1];	// functional-unit.scala:229:23
        r_uops_0_ctrl_op1_sel = _RANDOM[6'h4][6:5];	// functional-unit.scala:229:23
        r_uops_0_ctrl_op2_sel = _RANDOM[6'h4][9:7];	// functional-unit.scala:229:23
        r_uops_0_ctrl_imm_sel = _RANDOM[6'h4][12:10];	// functional-unit.scala:229:23
        r_uops_0_ctrl_op_fcn = _RANDOM[6'h4][16:13];	// functional-unit.scala:229:23
        r_uops_0_ctrl_fcn_dw = _RANDOM[6'h4][17];	// functional-unit.scala:229:23
        r_uops_0_ctrl_csr_cmd = _RANDOM[6'h4][20:18];	// functional-unit.scala:229:23
        r_uops_0_ctrl_is_load = _RANDOM[6'h4][21];	// functional-unit.scala:229:23
        r_uops_0_ctrl_is_sta = _RANDOM[6'h4][22];	// functional-unit.scala:229:23
        r_uops_0_ctrl_is_std = _RANDOM[6'h4][23];	// functional-unit.scala:229:23
        r_uops_0_iw_state = _RANDOM[6'h4][25:24];	// functional-unit.scala:229:23
        r_uops_0_iw_p1_poisoned = _RANDOM[6'h4][26];	// functional-unit.scala:229:23
        r_uops_0_iw_p2_poisoned = _RANDOM[6'h4][27];	// functional-unit.scala:229:23
        r_uops_0_is_br = _RANDOM[6'h4][28];	// functional-unit.scala:229:23
        r_uops_0_is_jalr = _RANDOM[6'h4][29];	// functional-unit.scala:229:23
        r_uops_0_is_jal = _RANDOM[6'h4][30];	// functional-unit.scala:229:23
        r_uops_0_is_sfb = _RANDOM[6'h4][31];	// functional-unit.scala:229:23
        r_uops_0_br_mask = _RANDOM[6'h5][19:0];	// functional-unit.scala:229:23
        r_uops_0_br_tag = _RANDOM[6'h5][24:20];	// functional-unit.scala:229:23
        r_uops_0_ftq_idx = _RANDOM[6'h5][30:25];	// functional-unit.scala:229:23
        r_uops_0_edge_inst = _RANDOM[6'h5][31];	// functional-unit.scala:229:23
        r_uops_0_pc_lob = _RANDOM[6'h6][5:0];	// functional-unit.scala:229:23
        r_uops_0_taken = _RANDOM[6'h6][6];	// functional-unit.scala:229:23
        r_uops_0_imm_packed = _RANDOM[6'h6][26:7];	// functional-unit.scala:229:23
        r_uops_0_csr_addr = {_RANDOM[6'h6][31:27], _RANDOM[6'h7][6:0]};	// functional-unit.scala:229:23
        r_uops_0_rob_idx = _RANDOM[6'h7][13:7];	// functional-unit.scala:229:23
        r_uops_0_ldq_idx = _RANDOM[6'h7][18:14];	// functional-unit.scala:229:23
        r_uops_0_stq_idx = _RANDOM[6'h7][23:19];	// functional-unit.scala:229:23
        r_uops_0_rxq_idx = _RANDOM[6'h7][25:24];	// functional-unit.scala:229:23
        r_uops_0_pdst = {_RANDOM[6'h7][31:26], _RANDOM[6'h8][0]};	// functional-unit.scala:229:23
        r_uops_0_prs1 = _RANDOM[6'h8][7:1];	// functional-unit.scala:229:23
        r_uops_0_prs2 = _RANDOM[6'h8][14:8];	// functional-unit.scala:229:23
        r_uops_0_prs3 = _RANDOM[6'h8][21:15];	// functional-unit.scala:229:23
        r_uops_0_ppred = _RANDOM[6'h8][27:22];	// functional-unit.scala:229:23
        r_uops_0_prs1_busy = _RANDOM[6'h8][28];	// functional-unit.scala:229:23
        r_uops_0_prs2_busy = _RANDOM[6'h8][29];	// functional-unit.scala:229:23
        r_uops_0_prs3_busy = _RANDOM[6'h8][30];	// functional-unit.scala:229:23
        r_uops_0_ppred_busy = _RANDOM[6'h8][31];	// functional-unit.scala:229:23
        r_uops_0_stale_pdst = _RANDOM[6'h9][6:0];	// functional-unit.scala:229:23
        r_uops_0_exception = _RANDOM[6'h9][7];	// functional-unit.scala:229:23
        r_uops_0_exc_cause = {_RANDOM[6'h9][31:8], _RANDOM[6'hA], _RANDOM[6'hB][7:0]};	// functional-unit.scala:229:23
        r_uops_0_bypassable = _RANDOM[6'hB][8];	// functional-unit.scala:229:23
        r_uops_0_mem_cmd = _RANDOM[6'hB][13:9];	// functional-unit.scala:229:23
        r_uops_0_mem_size = _RANDOM[6'hB][15:14];	// functional-unit.scala:229:23
        r_uops_0_mem_signed = _RANDOM[6'hB][16];	// functional-unit.scala:229:23
        r_uops_0_is_fence = _RANDOM[6'hB][17];	// functional-unit.scala:229:23
        r_uops_0_is_fencei = _RANDOM[6'hB][18];	// functional-unit.scala:229:23
        r_uops_0_is_amo = _RANDOM[6'hB][19];	// functional-unit.scala:229:23
        r_uops_0_uses_ldq = _RANDOM[6'hB][20];	// functional-unit.scala:229:23
        r_uops_0_uses_stq = _RANDOM[6'hB][21];	// functional-unit.scala:229:23
        r_uops_0_is_sys_pc2epc = _RANDOM[6'hB][22];	// functional-unit.scala:229:23
        r_uops_0_is_unique = _RANDOM[6'hB][23];	// functional-unit.scala:229:23
        r_uops_0_flush_on_commit = _RANDOM[6'hB][24];	// functional-unit.scala:229:23
        r_uops_0_ldst_is_rs1 = _RANDOM[6'hB][25];	// functional-unit.scala:229:23
        r_uops_0_ldst = _RANDOM[6'hB][31:26];	// functional-unit.scala:229:23
        r_uops_0_lrs1 = _RANDOM[6'hC][5:0];	// functional-unit.scala:229:23
        r_uops_0_lrs2 = _RANDOM[6'hC][11:6];	// functional-unit.scala:229:23
        r_uops_0_lrs3 = _RANDOM[6'hC][17:12];	// functional-unit.scala:229:23
        r_uops_0_ldst_val = _RANDOM[6'hC][18];	// functional-unit.scala:229:23
        r_uops_0_dst_rtype = _RANDOM[6'hC][20:19];	// functional-unit.scala:229:23
        r_uops_0_lrs1_rtype = _RANDOM[6'hC][22:21];	// functional-unit.scala:229:23
        r_uops_0_lrs2_rtype = _RANDOM[6'hC][24:23];	// functional-unit.scala:229:23
        r_uops_0_frs3_en = _RANDOM[6'hC][25];	// functional-unit.scala:229:23
        r_uops_0_fp_val = _RANDOM[6'hC][26];	// functional-unit.scala:229:23
        r_uops_0_fp_single = _RANDOM[6'hC][27];	// functional-unit.scala:229:23
        r_uops_0_xcpt_pf_if = _RANDOM[6'hC][28];	// functional-unit.scala:229:23
        r_uops_0_xcpt_ae_if = _RANDOM[6'hC][29];	// functional-unit.scala:229:23
        r_uops_0_xcpt_ma_if = _RANDOM[6'hC][30];	// functional-unit.scala:229:23
        r_uops_0_bp_debug_if = _RANDOM[6'hC][31];	// functional-unit.scala:229:23
        r_uops_0_bp_xcpt_if = _RANDOM[6'hD][0];	// functional-unit.scala:229:23
        r_uops_0_debug_fsrc = _RANDOM[6'hD][2:1];	// functional-unit.scala:229:23
        r_uops_0_debug_tsrc = _RANDOM[6'hD][4:3];	// functional-unit.scala:229:23
        r_uops_1_uopc = _RANDOM[6'hD][11:5];	// functional-unit.scala:229:23
        r_uops_1_inst = {_RANDOM[6'hD][31:12], _RANDOM[6'hE][11:0]};	// functional-unit.scala:229:23
        r_uops_1_debug_inst = {_RANDOM[6'hE][31:12], _RANDOM[6'hF][11:0]};	// functional-unit.scala:229:23
        r_uops_1_is_rvc = _RANDOM[6'hF][12];	// functional-unit.scala:229:23
        r_uops_1_debug_pc = {_RANDOM[6'hF][31:13], _RANDOM[6'h10][20:0]};	// functional-unit.scala:229:23
        r_uops_1_iq_type = _RANDOM[6'h10][23:21];	// functional-unit.scala:229:23
        r_uops_1_fu_code = {_RANDOM[6'h10][31:24], _RANDOM[6'h11][1:0]};	// functional-unit.scala:229:23
        r_uops_1_ctrl_br_type = _RANDOM[6'h11][5:2];	// functional-unit.scala:229:23
        r_uops_1_ctrl_op1_sel = _RANDOM[6'h11][7:6];	// functional-unit.scala:229:23
        r_uops_1_ctrl_op2_sel = _RANDOM[6'h11][10:8];	// functional-unit.scala:229:23
        r_uops_1_ctrl_imm_sel = _RANDOM[6'h11][13:11];	// functional-unit.scala:229:23
        r_uops_1_ctrl_op_fcn = _RANDOM[6'h11][17:14];	// functional-unit.scala:229:23
        r_uops_1_ctrl_fcn_dw = _RANDOM[6'h11][18];	// functional-unit.scala:229:23
        r_uops_1_ctrl_csr_cmd = _RANDOM[6'h11][21:19];	// functional-unit.scala:229:23
        r_uops_1_ctrl_is_load = _RANDOM[6'h11][22];	// functional-unit.scala:229:23
        r_uops_1_ctrl_is_sta = _RANDOM[6'h11][23];	// functional-unit.scala:229:23
        r_uops_1_ctrl_is_std = _RANDOM[6'h11][24];	// functional-unit.scala:229:23
        r_uops_1_iw_state = _RANDOM[6'h11][26:25];	// functional-unit.scala:229:23
        r_uops_1_iw_p1_poisoned = _RANDOM[6'h11][27];	// functional-unit.scala:229:23
        r_uops_1_iw_p2_poisoned = _RANDOM[6'h11][28];	// functional-unit.scala:229:23
        r_uops_1_is_br = _RANDOM[6'h11][29];	// functional-unit.scala:229:23
        r_uops_1_is_jalr = _RANDOM[6'h11][30];	// functional-unit.scala:229:23
        r_uops_1_is_jal = _RANDOM[6'h11][31];	// functional-unit.scala:229:23
        r_uops_1_is_sfb = _RANDOM[6'h12][0];	// functional-unit.scala:229:23
        r_uops_1_br_mask = _RANDOM[6'h12][20:1];	// functional-unit.scala:229:23
        r_uops_1_br_tag = _RANDOM[6'h12][25:21];	// functional-unit.scala:229:23
        r_uops_1_ftq_idx = _RANDOM[6'h12][31:26];	// functional-unit.scala:229:23
        r_uops_1_edge_inst = _RANDOM[6'h13][0];	// functional-unit.scala:229:23
        r_uops_1_pc_lob = _RANDOM[6'h13][6:1];	// functional-unit.scala:229:23
        r_uops_1_taken = _RANDOM[6'h13][7];	// functional-unit.scala:229:23
        r_uops_1_imm_packed = _RANDOM[6'h13][27:8];	// functional-unit.scala:229:23
        r_uops_1_csr_addr = {_RANDOM[6'h13][31:28], _RANDOM[6'h14][7:0]};	// functional-unit.scala:229:23
        r_uops_1_rob_idx = _RANDOM[6'h14][14:8];	// functional-unit.scala:229:23
        r_uops_1_ldq_idx = _RANDOM[6'h14][19:15];	// functional-unit.scala:229:23
        r_uops_1_stq_idx = _RANDOM[6'h14][24:20];	// functional-unit.scala:229:23
        r_uops_1_rxq_idx = _RANDOM[6'h14][26:25];	// functional-unit.scala:229:23
        r_uops_1_pdst = {_RANDOM[6'h14][31:27], _RANDOM[6'h15][1:0]};	// functional-unit.scala:229:23
        r_uops_1_prs1 = _RANDOM[6'h15][8:2];	// functional-unit.scala:229:23
        r_uops_1_prs2 = _RANDOM[6'h15][15:9];	// functional-unit.scala:229:23
        r_uops_1_prs3 = _RANDOM[6'h15][22:16];	// functional-unit.scala:229:23
        r_uops_1_ppred = _RANDOM[6'h15][28:23];	// functional-unit.scala:229:23
        r_uops_1_prs1_busy = _RANDOM[6'h15][29];	// functional-unit.scala:229:23
        r_uops_1_prs2_busy = _RANDOM[6'h15][30];	// functional-unit.scala:229:23
        r_uops_1_prs3_busy = _RANDOM[6'h15][31];	// functional-unit.scala:229:23
        r_uops_1_ppred_busy = _RANDOM[6'h16][0];	// functional-unit.scala:229:23
        r_uops_1_stale_pdst = _RANDOM[6'h16][7:1];	// functional-unit.scala:229:23
        r_uops_1_exception = _RANDOM[6'h16][8];	// functional-unit.scala:229:23
        r_uops_1_exc_cause = {_RANDOM[6'h16][31:9], _RANDOM[6'h17], _RANDOM[6'h18][8:0]};	// functional-unit.scala:229:23
        r_uops_1_bypassable = _RANDOM[6'h18][9];	// functional-unit.scala:229:23
        r_uops_1_mem_cmd = _RANDOM[6'h18][14:10];	// functional-unit.scala:229:23
        r_uops_1_mem_size = _RANDOM[6'h18][16:15];	// functional-unit.scala:229:23
        r_uops_1_mem_signed = _RANDOM[6'h18][17];	// functional-unit.scala:229:23
        r_uops_1_is_fence = _RANDOM[6'h18][18];	// functional-unit.scala:229:23
        r_uops_1_is_fencei = _RANDOM[6'h18][19];	// functional-unit.scala:229:23
        r_uops_1_is_amo = _RANDOM[6'h18][20];	// functional-unit.scala:229:23
        r_uops_1_uses_ldq = _RANDOM[6'h18][21];	// functional-unit.scala:229:23
        r_uops_1_uses_stq = _RANDOM[6'h18][22];	// functional-unit.scala:229:23
        r_uops_1_is_sys_pc2epc = _RANDOM[6'h18][23];	// functional-unit.scala:229:23
        r_uops_1_is_unique = _RANDOM[6'h18][24];	// functional-unit.scala:229:23
        r_uops_1_flush_on_commit = _RANDOM[6'h18][25];	// functional-unit.scala:229:23
        r_uops_1_ldst_is_rs1 = _RANDOM[6'h18][26];	// functional-unit.scala:229:23
        r_uops_1_ldst = {_RANDOM[6'h18][31:27], _RANDOM[6'h19][0]};	// functional-unit.scala:229:23
        r_uops_1_lrs1 = _RANDOM[6'h19][6:1];	// functional-unit.scala:229:23
        r_uops_1_lrs2 = _RANDOM[6'h19][12:7];	// functional-unit.scala:229:23
        r_uops_1_lrs3 = _RANDOM[6'h19][18:13];	// functional-unit.scala:229:23
        r_uops_1_ldst_val = _RANDOM[6'h19][19];	// functional-unit.scala:229:23
        r_uops_1_dst_rtype = _RANDOM[6'h19][21:20];	// functional-unit.scala:229:23
        r_uops_1_lrs1_rtype = _RANDOM[6'h19][23:22];	// functional-unit.scala:229:23
        r_uops_1_lrs2_rtype = _RANDOM[6'h19][25:24];	// functional-unit.scala:229:23
        r_uops_1_frs3_en = _RANDOM[6'h19][26];	// functional-unit.scala:229:23
        r_uops_1_fp_val = _RANDOM[6'h19][27];	// functional-unit.scala:229:23
        r_uops_1_fp_single = _RANDOM[6'h19][28];	// functional-unit.scala:229:23
        r_uops_1_xcpt_pf_if = _RANDOM[6'h19][29];	// functional-unit.scala:229:23
        r_uops_1_xcpt_ae_if = _RANDOM[6'h19][30];	// functional-unit.scala:229:23
        r_uops_1_xcpt_ma_if = _RANDOM[6'h19][31];	// functional-unit.scala:229:23
        r_uops_1_bp_debug_if = _RANDOM[6'h1A][0];	// functional-unit.scala:229:23
        r_uops_1_bp_xcpt_if = _RANDOM[6'h1A][1];	// functional-unit.scala:229:23
        r_uops_1_debug_fsrc = _RANDOM[6'h1A][3:2];	// functional-unit.scala:229:23
        r_uops_1_debug_tsrc = _RANDOM[6'h1A][5:4];	// functional-unit.scala:229:23
        r_uops_2_uopc = _RANDOM[6'h1A][12:6];	// functional-unit.scala:229:23
        r_uops_2_inst = {_RANDOM[6'h1A][31:13], _RANDOM[6'h1B][12:0]};	// functional-unit.scala:229:23
        r_uops_2_debug_inst = {_RANDOM[6'h1B][31:13], _RANDOM[6'h1C][12:0]};	// functional-unit.scala:229:23
        r_uops_2_is_rvc = _RANDOM[6'h1C][13];	// functional-unit.scala:229:23
        r_uops_2_debug_pc = {_RANDOM[6'h1C][31:14], _RANDOM[6'h1D][21:0]};	// functional-unit.scala:229:23
        r_uops_2_iq_type = _RANDOM[6'h1D][24:22];	// functional-unit.scala:229:23
        r_uops_2_fu_code = {_RANDOM[6'h1D][31:25], _RANDOM[6'h1E][2:0]};	// functional-unit.scala:229:23
        r_uops_2_ctrl_br_type = _RANDOM[6'h1E][6:3];	// functional-unit.scala:229:23
        r_uops_2_ctrl_op1_sel = _RANDOM[6'h1E][8:7];	// functional-unit.scala:229:23
        r_uops_2_ctrl_op2_sel = _RANDOM[6'h1E][11:9];	// functional-unit.scala:229:23
        r_uops_2_ctrl_imm_sel = _RANDOM[6'h1E][14:12];	// functional-unit.scala:229:23
        r_uops_2_ctrl_op_fcn = _RANDOM[6'h1E][18:15];	// functional-unit.scala:229:23
        r_uops_2_ctrl_fcn_dw = _RANDOM[6'h1E][19];	// functional-unit.scala:229:23
        r_uops_2_ctrl_csr_cmd = _RANDOM[6'h1E][22:20];	// functional-unit.scala:229:23
        r_uops_2_ctrl_is_load = _RANDOM[6'h1E][23];	// functional-unit.scala:229:23
        r_uops_2_ctrl_is_sta = _RANDOM[6'h1E][24];	// functional-unit.scala:229:23
        r_uops_2_ctrl_is_std = _RANDOM[6'h1E][25];	// functional-unit.scala:229:23
        r_uops_2_iw_state = _RANDOM[6'h1E][27:26];	// functional-unit.scala:229:23
        r_uops_2_iw_p1_poisoned = _RANDOM[6'h1E][28];	// functional-unit.scala:229:23
        r_uops_2_iw_p2_poisoned = _RANDOM[6'h1E][29];	// functional-unit.scala:229:23
        r_uops_2_is_br = _RANDOM[6'h1E][30];	// functional-unit.scala:229:23
        r_uops_2_is_jalr = _RANDOM[6'h1E][31];	// functional-unit.scala:229:23
        r_uops_2_is_jal = _RANDOM[6'h1F][0];	// functional-unit.scala:229:23
        r_uops_2_is_sfb = _RANDOM[6'h1F][1];	// functional-unit.scala:229:23
        r_uops_2_br_mask = _RANDOM[6'h1F][21:2];	// functional-unit.scala:229:23
        r_uops_2_br_tag = _RANDOM[6'h1F][26:22];	// functional-unit.scala:229:23
        r_uops_2_ftq_idx = {_RANDOM[6'h1F][31:27], _RANDOM[6'h20][0]};	// functional-unit.scala:229:23
        r_uops_2_edge_inst = _RANDOM[6'h20][1];	// functional-unit.scala:229:23
        r_uops_2_pc_lob = _RANDOM[6'h20][7:2];	// functional-unit.scala:229:23
        r_uops_2_taken = _RANDOM[6'h20][8];	// functional-unit.scala:229:23
        r_uops_2_imm_packed = _RANDOM[6'h20][28:9];	// functional-unit.scala:229:23
        r_uops_2_csr_addr = {_RANDOM[6'h20][31:29], _RANDOM[6'h21][8:0]};	// functional-unit.scala:229:23
        r_uops_2_rob_idx = _RANDOM[6'h21][15:9];	// functional-unit.scala:229:23
        r_uops_2_ldq_idx = _RANDOM[6'h21][20:16];	// functional-unit.scala:229:23
        r_uops_2_stq_idx = _RANDOM[6'h21][25:21];	// functional-unit.scala:229:23
        r_uops_2_rxq_idx = _RANDOM[6'h21][27:26];	// functional-unit.scala:229:23
        r_uops_2_pdst = {_RANDOM[6'h21][31:28], _RANDOM[6'h22][2:0]};	// functional-unit.scala:229:23
        r_uops_2_prs1 = _RANDOM[6'h22][9:3];	// functional-unit.scala:229:23
        r_uops_2_prs2 = _RANDOM[6'h22][16:10];	// functional-unit.scala:229:23
        r_uops_2_prs3 = _RANDOM[6'h22][23:17];	// functional-unit.scala:229:23
        r_uops_2_ppred = _RANDOM[6'h22][29:24];	// functional-unit.scala:229:23
        r_uops_2_prs1_busy = _RANDOM[6'h22][30];	// functional-unit.scala:229:23
        r_uops_2_prs2_busy = _RANDOM[6'h22][31];	// functional-unit.scala:229:23
        r_uops_2_prs3_busy = _RANDOM[6'h23][0];	// functional-unit.scala:229:23
        r_uops_2_ppred_busy = _RANDOM[6'h23][1];	// functional-unit.scala:229:23
        r_uops_2_stale_pdst = _RANDOM[6'h23][8:2];	// functional-unit.scala:229:23
        r_uops_2_exception = _RANDOM[6'h23][9];	// functional-unit.scala:229:23
        r_uops_2_exc_cause = {_RANDOM[6'h23][31:10], _RANDOM[6'h24], _RANDOM[6'h25][9:0]};	// functional-unit.scala:229:23
        r_uops_2_bypassable = _RANDOM[6'h25][10];	// functional-unit.scala:229:23
        r_uops_2_mem_cmd = _RANDOM[6'h25][15:11];	// functional-unit.scala:229:23
        r_uops_2_mem_size = _RANDOM[6'h25][17:16];	// functional-unit.scala:229:23
        r_uops_2_mem_signed = _RANDOM[6'h25][18];	// functional-unit.scala:229:23
        r_uops_2_is_fence = _RANDOM[6'h25][19];	// functional-unit.scala:229:23
        r_uops_2_is_fencei = _RANDOM[6'h25][20];	// functional-unit.scala:229:23
        r_uops_2_is_amo = _RANDOM[6'h25][21];	// functional-unit.scala:229:23
        r_uops_2_uses_ldq = _RANDOM[6'h25][22];	// functional-unit.scala:229:23
        r_uops_2_uses_stq = _RANDOM[6'h25][23];	// functional-unit.scala:229:23
        r_uops_2_is_sys_pc2epc = _RANDOM[6'h25][24];	// functional-unit.scala:229:23
        r_uops_2_is_unique = _RANDOM[6'h25][25];	// functional-unit.scala:229:23
        r_uops_2_flush_on_commit = _RANDOM[6'h25][26];	// functional-unit.scala:229:23
        r_uops_2_ldst_is_rs1 = _RANDOM[6'h25][27];	// functional-unit.scala:229:23
        r_uops_2_ldst = {_RANDOM[6'h25][31:28], _RANDOM[6'h26][1:0]};	// functional-unit.scala:229:23
        r_uops_2_lrs1 = _RANDOM[6'h26][7:2];	// functional-unit.scala:229:23
        r_uops_2_lrs2 = _RANDOM[6'h26][13:8];	// functional-unit.scala:229:23
        r_uops_2_lrs3 = _RANDOM[6'h26][19:14];	// functional-unit.scala:229:23
        r_uops_2_ldst_val = _RANDOM[6'h26][20];	// functional-unit.scala:229:23
        r_uops_2_dst_rtype = _RANDOM[6'h26][22:21];	// functional-unit.scala:229:23
        r_uops_2_lrs1_rtype = _RANDOM[6'h26][24:23];	// functional-unit.scala:229:23
        r_uops_2_lrs2_rtype = _RANDOM[6'h26][26:25];	// functional-unit.scala:229:23
        r_uops_2_frs3_en = _RANDOM[6'h26][27];	// functional-unit.scala:229:23
        r_uops_2_fp_val = _RANDOM[6'h26][28];	// functional-unit.scala:229:23
        r_uops_2_fp_single = _RANDOM[6'h26][29];	// functional-unit.scala:229:23
        r_uops_2_xcpt_pf_if = _RANDOM[6'h26][30];	// functional-unit.scala:229:23
        r_uops_2_xcpt_ae_if = _RANDOM[6'h26][31];	// functional-unit.scala:229:23
        r_uops_2_xcpt_ma_if = _RANDOM[6'h27][0];	// functional-unit.scala:229:23
        r_uops_2_bp_debug_if = _RANDOM[6'h27][1];	// functional-unit.scala:229:23
        r_uops_2_bp_xcpt_if = _RANDOM[6'h27][2];	// functional-unit.scala:229:23
        r_uops_2_debug_fsrc = _RANDOM[6'h27][4:3];	// functional-unit.scala:229:23
        r_uops_2_debug_tsrc = _RANDOM[6'h27][6:5];	// functional-unit.scala:229:23
        r_uops_3_uopc = _RANDOM[6'h27][13:7];	// functional-unit.scala:229:23
        r_uops_3_inst = {_RANDOM[6'h27][31:14], _RANDOM[6'h28][13:0]};	// functional-unit.scala:229:23
        r_uops_3_debug_inst = {_RANDOM[6'h28][31:14], _RANDOM[6'h29][13:0]};	// functional-unit.scala:229:23
        r_uops_3_is_rvc = _RANDOM[6'h29][14];	// functional-unit.scala:229:23
        r_uops_3_debug_pc = {_RANDOM[6'h29][31:15], _RANDOM[6'h2A][22:0]};	// functional-unit.scala:229:23
        r_uops_3_iq_type = _RANDOM[6'h2A][25:23];	// functional-unit.scala:229:23
        r_uops_3_fu_code = {_RANDOM[6'h2A][31:26], _RANDOM[6'h2B][3:0]};	// functional-unit.scala:229:23
        r_uops_3_ctrl_br_type = _RANDOM[6'h2B][7:4];	// functional-unit.scala:229:23
        r_uops_3_ctrl_op1_sel = _RANDOM[6'h2B][9:8];	// functional-unit.scala:229:23
        r_uops_3_ctrl_op2_sel = _RANDOM[6'h2B][12:10];	// functional-unit.scala:229:23
        r_uops_3_ctrl_imm_sel = _RANDOM[6'h2B][15:13];	// functional-unit.scala:229:23
        r_uops_3_ctrl_op_fcn = _RANDOM[6'h2B][19:16];	// functional-unit.scala:229:23
        r_uops_3_ctrl_fcn_dw = _RANDOM[6'h2B][20];	// functional-unit.scala:229:23
        r_uops_3_ctrl_csr_cmd = _RANDOM[6'h2B][23:21];	// functional-unit.scala:229:23
        r_uops_3_ctrl_is_load = _RANDOM[6'h2B][24];	// functional-unit.scala:229:23
        r_uops_3_ctrl_is_sta = _RANDOM[6'h2B][25];	// functional-unit.scala:229:23
        r_uops_3_ctrl_is_std = _RANDOM[6'h2B][26];	// functional-unit.scala:229:23
        r_uops_3_iw_state = _RANDOM[6'h2B][28:27];	// functional-unit.scala:229:23
        r_uops_3_iw_p1_poisoned = _RANDOM[6'h2B][29];	// functional-unit.scala:229:23
        r_uops_3_iw_p2_poisoned = _RANDOM[6'h2B][30];	// functional-unit.scala:229:23
        r_uops_3_is_br = _RANDOM[6'h2B][31];	// functional-unit.scala:229:23
        r_uops_3_is_jalr = _RANDOM[6'h2C][0];	// functional-unit.scala:229:23
        r_uops_3_is_jal = _RANDOM[6'h2C][1];	// functional-unit.scala:229:23
        r_uops_3_is_sfb = _RANDOM[6'h2C][2];	// functional-unit.scala:229:23
        r_uops_3_br_mask = _RANDOM[6'h2C][22:3];	// functional-unit.scala:229:23
        r_uops_3_br_tag = _RANDOM[6'h2C][27:23];	// functional-unit.scala:229:23
        r_uops_3_ftq_idx = {_RANDOM[6'h2C][31:28], _RANDOM[6'h2D][1:0]};	// functional-unit.scala:229:23
        r_uops_3_edge_inst = _RANDOM[6'h2D][2];	// functional-unit.scala:229:23
        r_uops_3_pc_lob = _RANDOM[6'h2D][8:3];	// functional-unit.scala:229:23
        r_uops_3_taken = _RANDOM[6'h2D][9];	// functional-unit.scala:229:23
        r_uops_3_imm_packed = _RANDOM[6'h2D][29:10];	// functional-unit.scala:229:23
        r_uops_3_csr_addr = {_RANDOM[6'h2D][31:30], _RANDOM[6'h2E][9:0]};	// functional-unit.scala:229:23
        r_uops_3_rob_idx = _RANDOM[6'h2E][16:10];	// functional-unit.scala:229:23
        r_uops_3_ldq_idx = _RANDOM[6'h2E][21:17];	// functional-unit.scala:229:23
        r_uops_3_stq_idx = _RANDOM[6'h2E][26:22];	// functional-unit.scala:229:23
        r_uops_3_rxq_idx = _RANDOM[6'h2E][28:27];	// functional-unit.scala:229:23
        r_uops_3_pdst = {_RANDOM[6'h2E][31:29], _RANDOM[6'h2F][3:0]};	// functional-unit.scala:229:23
        r_uops_3_prs1 = _RANDOM[6'h2F][10:4];	// functional-unit.scala:229:23
        r_uops_3_prs2 = _RANDOM[6'h2F][17:11];	// functional-unit.scala:229:23
        r_uops_3_prs3 = _RANDOM[6'h2F][24:18];	// functional-unit.scala:229:23
        r_uops_3_ppred = _RANDOM[6'h2F][30:25];	// functional-unit.scala:229:23
        r_uops_3_prs1_busy = _RANDOM[6'h2F][31];	// functional-unit.scala:229:23
        r_uops_3_prs2_busy = _RANDOM[6'h30][0];	// functional-unit.scala:229:23
        r_uops_3_prs3_busy = _RANDOM[6'h30][1];	// functional-unit.scala:229:23
        r_uops_3_ppred_busy = _RANDOM[6'h30][2];	// functional-unit.scala:229:23
        r_uops_3_stale_pdst = _RANDOM[6'h30][9:3];	// functional-unit.scala:229:23
        r_uops_3_exception = _RANDOM[6'h30][10];	// functional-unit.scala:229:23
        r_uops_3_exc_cause =
          {_RANDOM[6'h30][31:11], _RANDOM[6'h31], _RANDOM[6'h32][10:0]};	// functional-unit.scala:229:23
        r_uops_3_bypassable = _RANDOM[6'h32][11];	// functional-unit.scala:229:23
        r_uops_3_mem_cmd = _RANDOM[6'h32][16:12];	// functional-unit.scala:229:23
        r_uops_3_mem_size = _RANDOM[6'h32][18:17];	// functional-unit.scala:229:23
        r_uops_3_mem_signed = _RANDOM[6'h32][19];	// functional-unit.scala:229:23
        r_uops_3_is_fence = _RANDOM[6'h32][20];	// functional-unit.scala:229:23
        r_uops_3_is_fencei = _RANDOM[6'h32][21];	// functional-unit.scala:229:23
        r_uops_3_is_amo = _RANDOM[6'h32][22];	// functional-unit.scala:229:23
        r_uops_3_uses_ldq = _RANDOM[6'h32][23];	// functional-unit.scala:229:23
        r_uops_3_uses_stq = _RANDOM[6'h32][24];	// functional-unit.scala:229:23
        r_uops_3_is_sys_pc2epc = _RANDOM[6'h32][25];	// functional-unit.scala:229:23
        r_uops_3_is_unique = _RANDOM[6'h32][26];	// functional-unit.scala:229:23
        r_uops_3_flush_on_commit = _RANDOM[6'h32][27];	// functional-unit.scala:229:23
        r_uops_3_ldst_is_rs1 = _RANDOM[6'h32][28];	// functional-unit.scala:229:23
        r_uops_3_ldst = {_RANDOM[6'h32][31:29], _RANDOM[6'h33][2:0]};	// functional-unit.scala:229:23
        r_uops_3_lrs1 = _RANDOM[6'h33][8:3];	// functional-unit.scala:229:23
        r_uops_3_lrs2 = _RANDOM[6'h33][14:9];	// functional-unit.scala:229:23
        r_uops_3_lrs3 = _RANDOM[6'h33][20:15];	// functional-unit.scala:229:23
        r_uops_3_ldst_val = _RANDOM[6'h33][21];	// functional-unit.scala:229:23
        r_uops_3_dst_rtype = _RANDOM[6'h33][23:22];	// functional-unit.scala:229:23
        r_uops_3_lrs1_rtype = _RANDOM[6'h33][25:24];	// functional-unit.scala:229:23
        r_uops_3_lrs2_rtype = _RANDOM[6'h33][27:26];	// functional-unit.scala:229:23
        r_uops_3_frs3_en = _RANDOM[6'h33][28];	// functional-unit.scala:229:23
        r_uops_3_fp_val = _RANDOM[6'h33][29];	// functional-unit.scala:229:23
        r_uops_3_fp_single = _RANDOM[6'h33][30];	// functional-unit.scala:229:23
        r_uops_3_xcpt_pf_if = _RANDOM[6'h33][31];	// functional-unit.scala:229:23
        r_uops_3_xcpt_ae_if = _RANDOM[6'h34][0];	// functional-unit.scala:229:23
        r_uops_3_xcpt_ma_if = _RANDOM[6'h34][1];	// functional-unit.scala:229:23
        r_uops_3_bp_debug_if = _RANDOM[6'h34][2];	// functional-unit.scala:229:23
        r_uops_3_bp_xcpt_if = _RANDOM[6'h34][3];	// functional-unit.scala:229:23
        r_uops_3_debug_fsrc = _RANDOM[6'h34][5:4];	// functional-unit.scala:229:23
        r_uops_3_debug_tsrc = _RANDOM[6'h34][7:6];	// functional-unit.scala:229:23
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  FPU_1 fpu (	// functional-unit.scala:565:19
    .clock                          (clock),
    .reset                          (reset),
    .io_req_valid                   (io_req_valid),
    .io_req_bits_uop_uopc           (io_req_bits_uop_uopc),
    .io_req_bits_uop_imm_packed     (io_req_bits_uop_imm_packed),
    .io_req_bits_rs1_data           (io_req_bits_rs1_data),
    .io_req_bits_rs2_data           (io_req_bits_rs2_data),
    .io_req_bits_rs3_data           (io_req_bits_rs3_data),
    .io_req_bits_fcsr_rm            (io_fcsr_rm),
    .io_resp_bits_data              (io_resp_bits_data),
    .io_resp_bits_fflags_valid      (io_resp_bits_fflags_valid),
    .io_resp_bits_fflags_bits_flags (io_resp_bits_fflags_bits_flags)
  );
  assign io_resp_valid =
    r_valids_3 & (io_brupdate_b1_mispredict_mask & r_uops_3_br_mask) == 20'h0;	// functional-unit.scala:228:27, :229:23, :249:47, util.scala:118:{51,59}
  assign io_resp_bits_uop_uopc = r_uops_3_uopc;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_inst = r_uops_3_inst;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_debug_inst = r_uops_3_debug_inst;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_is_rvc = r_uops_3_is_rvc;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_debug_pc = r_uops_3_debug_pc;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_iq_type = r_uops_3_iq_type;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_fu_code = r_uops_3_fu_code;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_ctrl_br_type = r_uops_3_ctrl_br_type;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_ctrl_op1_sel = r_uops_3_ctrl_op1_sel;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_ctrl_op2_sel = r_uops_3_ctrl_op2_sel;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_ctrl_imm_sel = r_uops_3_ctrl_imm_sel;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_ctrl_op_fcn = r_uops_3_ctrl_op_fcn;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_ctrl_fcn_dw = r_uops_3_ctrl_fcn_dw;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_ctrl_csr_cmd = r_uops_3_ctrl_csr_cmd;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_ctrl_is_load = r_uops_3_ctrl_is_load;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_ctrl_is_sta = r_uops_3_ctrl_is_sta;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_ctrl_is_std = r_uops_3_ctrl_is_std;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_iw_state = r_uops_3_iw_state;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_iw_p1_poisoned = r_uops_3_iw_p1_poisoned;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_iw_p2_poisoned = r_uops_3_iw_p2_poisoned;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_is_br = r_uops_3_is_br;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_is_jalr = r_uops_3_is_jalr;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_is_jal = r_uops_3_is_jal;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_is_sfb = r_uops_3_is_sfb;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_br_mask = _io_resp_bits_uop_br_mask_output;	// util.scala:85:25
  assign io_resp_bits_uop_br_tag = r_uops_3_br_tag;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_ftq_idx = r_uops_3_ftq_idx;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_edge_inst = r_uops_3_edge_inst;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_pc_lob = r_uops_3_pc_lob;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_taken = r_uops_3_taken;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_imm_packed = r_uops_3_imm_packed;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_csr_addr = r_uops_3_csr_addr;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_rob_idx = r_uops_3_rob_idx;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_ldq_idx = r_uops_3_ldq_idx;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_stq_idx = r_uops_3_stq_idx;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_rxq_idx = r_uops_3_rxq_idx;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_pdst = r_uops_3_pdst;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_prs1 = r_uops_3_prs1;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_prs2 = r_uops_3_prs2;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_prs3 = r_uops_3_prs3;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_ppred = r_uops_3_ppred;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_prs1_busy = r_uops_3_prs1_busy;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_prs2_busy = r_uops_3_prs2_busy;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_prs3_busy = r_uops_3_prs3_busy;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_ppred_busy = r_uops_3_ppred_busy;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_stale_pdst = r_uops_3_stale_pdst;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_exception = r_uops_3_exception;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_exc_cause = r_uops_3_exc_cause;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_bypassable = r_uops_3_bypassable;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_mem_cmd = r_uops_3_mem_cmd;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_mem_size = r_uops_3_mem_size;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_mem_signed = r_uops_3_mem_signed;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_is_fence = r_uops_3_is_fence;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_is_fencei = r_uops_3_is_fencei;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_is_amo = r_uops_3_is_amo;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_uses_ldq = r_uops_3_uses_ldq;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_uses_stq = r_uops_3_uses_stq;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_is_sys_pc2epc = r_uops_3_is_sys_pc2epc;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_is_unique = r_uops_3_is_unique;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_flush_on_commit = r_uops_3_flush_on_commit;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_ldst_is_rs1 = r_uops_3_ldst_is_rs1;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_ldst = r_uops_3_ldst;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_lrs1 = r_uops_3_lrs1;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_lrs2 = r_uops_3_lrs2;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_lrs3 = r_uops_3_lrs3;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_ldst_val = r_uops_3_ldst_val;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_dst_rtype = r_uops_3_dst_rtype;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_lrs1_rtype = r_uops_3_lrs1_rtype;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_lrs2_rtype = r_uops_3_lrs2_rtype;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_frs3_en = r_uops_3_frs3_en;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_fp_val = r_uops_3_fp_val;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_fp_single = r_uops_3_fp_single;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_xcpt_pf_if = r_uops_3_xcpt_pf_if;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_xcpt_ae_if = r_uops_3_xcpt_ae_if;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_xcpt_ma_if = r_uops_3_xcpt_ma_if;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_bp_debug_if = r_uops_3_bp_debug_if;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_bp_xcpt_if = r_uops_3_bp_xcpt_if;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_debug_fsrc = r_uops_3_debug_fsrc;	// functional-unit.scala:229:23
  assign io_resp_bits_uop_debug_tsrc = r_uops_3_debug_tsrc;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_uopc = r_uops_3_uopc;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_inst = r_uops_3_inst;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_debug_inst = r_uops_3_debug_inst;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_is_rvc = r_uops_3_is_rvc;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_debug_pc = r_uops_3_debug_pc;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_iq_type = r_uops_3_iq_type;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_fu_code = r_uops_3_fu_code;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_ctrl_br_type = r_uops_3_ctrl_br_type;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_ctrl_op1_sel = r_uops_3_ctrl_op1_sel;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_ctrl_op2_sel = r_uops_3_ctrl_op2_sel;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_ctrl_imm_sel = r_uops_3_ctrl_imm_sel;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_ctrl_op_fcn = r_uops_3_ctrl_op_fcn;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_ctrl_fcn_dw = r_uops_3_ctrl_fcn_dw;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_ctrl_csr_cmd = r_uops_3_ctrl_csr_cmd;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_ctrl_is_load = r_uops_3_ctrl_is_load;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_ctrl_is_sta = r_uops_3_ctrl_is_sta;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_ctrl_is_std = r_uops_3_ctrl_is_std;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_iw_state = r_uops_3_iw_state;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_iw_p1_poisoned = r_uops_3_iw_p1_poisoned;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_iw_p2_poisoned = r_uops_3_iw_p2_poisoned;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_is_br = r_uops_3_is_br;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_is_jalr = r_uops_3_is_jalr;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_is_jal = r_uops_3_is_jal;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_is_sfb = r_uops_3_is_sfb;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_br_mask = _io_resp_bits_uop_br_mask_output;	// util.scala:85:25
  assign io_resp_bits_fflags_bits_uop_br_tag = r_uops_3_br_tag;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_ftq_idx = r_uops_3_ftq_idx;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_edge_inst = r_uops_3_edge_inst;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_pc_lob = r_uops_3_pc_lob;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_taken = r_uops_3_taken;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_imm_packed = r_uops_3_imm_packed;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_csr_addr = r_uops_3_csr_addr;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_rob_idx = r_uops_3_rob_idx;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_ldq_idx = r_uops_3_ldq_idx;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_stq_idx = r_uops_3_stq_idx;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_rxq_idx = r_uops_3_rxq_idx;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_pdst = r_uops_3_pdst;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_prs1 = r_uops_3_prs1;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_prs2 = r_uops_3_prs2;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_prs3 = r_uops_3_prs3;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_ppred = r_uops_3_ppred;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_prs1_busy = r_uops_3_prs1_busy;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_prs2_busy = r_uops_3_prs2_busy;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_prs3_busy = r_uops_3_prs3_busy;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_ppred_busy = r_uops_3_ppred_busy;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_stale_pdst = r_uops_3_stale_pdst;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_exception = r_uops_3_exception;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_exc_cause = r_uops_3_exc_cause;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_bypassable = r_uops_3_bypassable;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_mem_cmd = r_uops_3_mem_cmd;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_mem_size = r_uops_3_mem_size;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_mem_signed = r_uops_3_mem_signed;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_is_fence = r_uops_3_is_fence;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_is_fencei = r_uops_3_is_fencei;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_is_amo = r_uops_3_is_amo;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_uses_ldq = r_uops_3_uses_ldq;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_uses_stq = r_uops_3_uses_stq;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_is_sys_pc2epc = r_uops_3_is_sys_pc2epc;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_is_unique = r_uops_3_is_unique;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_flush_on_commit = r_uops_3_flush_on_commit;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_ldst_is_rs1 = r_uops_3_ldst_is_rs1;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_ldst = r_uops_3_ldst;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_lrs1 = r_uops_3_lrs1;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_lrs2 = r_uops_3_lrs2;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_lrs3 = r_uops_3_lrs3;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_ldst_val = r_uops_3_ldst_val;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_dst_rtype = r_uops_3_dst_rtype;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_lrs1_rtype = r_uops_3_lrs1_rtype;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_lrs2_rtype = r_uops_3_lrs2_rtype;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_frs3_en = r_uops_3_frs3_en;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_fp_val = r_uops_3_fp_val;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_fp_single = r_uops_3_fp_single;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_xcpt_pf_if = r_uops_3_xcpt_pf_if;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_xcpt_ae_if = r_uops_3_xcpt_ae_if;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_xcpt_ma_if = r_uops_3_xcpt_ma_if;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_bp_debug_if = r_uops_3_bp_debug_if;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_bp_xcpt_if = r_uops_3_bp_xcpt_if;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_debug_fsrc = r_uops_3_debug_fsrc;	// functional-unit.scala:229:23
  assign io_resp_bits_fflags_bits_uop_debug_tsrc = r_uops_3_debug_tsrc;	// functional-unit.scala:229:23
endmodule

