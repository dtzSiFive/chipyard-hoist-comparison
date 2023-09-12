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

module FPUUnit_3(
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
  input  [11:0] io_req_bits_uop_br_mask,
  input  [3:0]  io_req_bits_uop_br_tag,
  input  [4:0]  io_req_bits_uop_ftq_idx,
  input         io_req_bits_uop_edge_inst,
  input  [5:0]  io_req_bits_uop_pc_lob,
  input         io_req_bits_uop_taken,
  input  [19:0] io_req_bits_uop_imm_packed,
  input  [11:0] io_req_bits_uop_csr_addr,
  input  [5:0]  io_req_bits_uop_rob_idx,
  input  [3:0]  io_req_bits_uop_ldq_idx,
                io_req_bits_uop_stq_idx,
  input  [1:0]  io_req_bits_uop_rxq_idx,
  input  [6:0]  io_req_bits_uop_pdst,
                io_req_bits_uop_prs1,
                io_req_bits_uop_prs2,
                io_req_bits_uop_prs3,
  input  [4:0]  io_req_bits_uop_ppred,
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
  input  [11:0] io_brupdate_b1_resolve_mask,
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
  output [11:0] io_resp_bits_uop_br_mask,
  output [3:0]  io_resp_bits_uop_br_tag,
  output [4:0]  io_resp_bits_uop_ftq_idx,
  output        io_resp_bits_uop_edge_inst,
  output [5:0]  io_resp_bits_uop_pc_lob,
  output        io_resp_bits_uop_taken,
  output [19:0] io_resp_bits_uop_imm_packed,
  output [11:0] io_resp_bits_uop_csr_addr,
  output [5:0]  io_resp_bits_uop_rob_idx,
  output [3:0]  io_resp_bits_uop_ldq_idx,
                io_resp_bits_uop_stq_idx,
  output [1:0]  io_resp_bits_uop_rxq_idx,
  output [6:0]  io_resp_bits_uop_pdst,
                io_resp_bits_uop_prs1,
                io_resp_bits_uop_prs2,
                io_resp_bits_uop_prs3,
  output [4:0]  io_resp_bits_uop_ppred,
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
  output [11:0] io_resp_bits_fflags_bits_uop_br_mask,
  output [3:0]  io_resp_bits_fflags_bits_uop_br_tag,
  output [4:0]  io_resp_bits_fflags_bits_uop_ftq_idx,
  output        io_resp_bits_fflags_bits_uop_edge_inst,
  output [5:0]  io_resp_bits_fflags_bits_uop_pc_lob,
  output        io_resp_bits_fflags_bits_uop_taken,
  output [19:0] io_resp_bits_fflags_bits_uop_imm_packed,
  output [11:0] io_resp_bits_fflags_bits_uop_csr_addr,
  output [5:0]  io_resp_bits_fflags_bits_uop_rob_idx,
  output [3:0]  io_resp_bits_fflags_bits_uop_ldq_idx,
                io_resp_bits_fflags_bits_uop_stq_idx,
  output [1:0]  io_resp_bits_fflags_bits_uop_rxq_idx,
  output [6:0]  io_resp_bits_fflags_bits_uop_pdst,
                io_resp_bits_fflags_bits_uop_prs1,
                io_resp_bits_fflags_bits_uop_prs2,
                io_resp_bits_fflags_bits_uop_prs3,
  output [4:0]  io_resp_bits_fflags_bits_uop_ppred,
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
  reg  [11:0] r_uops_0_br_mask;	// functional-unit.scala:229:23
  reg  [3:0]  r_uops_0_br_tag;	// functional-unit.scala:229:23
  reg  [4:0]  r_uops_0_ftq_idx;	// functional-unit.scala:229:23
  reg         r_uops_0_edge_inst;	// functional-unit.scala:229:23
  reg  [5:0]  r_uops_0_pc_lob;	// functional-unit.scala:229:23
  reg         r_uops_0_taken;	// functional-unit.scala:229:23
  reg  [19:0] r_uops_0_imm_packed;	// functional-unit.scala:229:23
  reg  [11:0] r_uops_0_csr_addr;	// functional-unit.scala:229:23
  reg  [5:0]  r_uops_0_rob_idx;	// functional-unit.scala:229:23
  reg  [3:0]  r_uops_0_ldq_idx;	// functional-unit.scala:229:23
  reg  [3:0]  r_uops_0_stq_idx;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_0_rxq_idx;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_0_pdst;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_0_prs1;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_0_prs2;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_0_prs3;	// functional-unit.scala:229:23
  reg  [4:0]  r_uops_0_ppred;	// functional-unit.scala:229:23
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
  reg  [11:0] r_uops_1_br_mask;	// functional-unit.scala:229:23
  reg  [3:0]  r_uops_1_br_tag;	// functional-unit.scala:229:23
  reg  [4:0]  r_uops_1_ftq_idx;	// functional-unit.scala:229:23
  reg         r_uops_1_edge_inst;	// functional-unit.scala:229:23
  reg  [5:0]  r_uops_1_pc_lob;	// functional-unit.scala:229:23
  reg         r_uops_1_taken;	// functional-unit.scala:229:23
  reg  [19:0] r_uops_1_imm_packed;	// functional-unit.scala:229:23
  reg  [11:0] r_uops_1_csr_addr;	// functional-unit.scala:229:23
  reg  [5:0]  r_uops_1_rob_idx;	// functional-unit.scala:229:23
  reg  [3:0]  r_uops_1_ldq_idx;	// functional-unit.scala:229:23
  reg  [3:0]  r_uops_1_stq_idx;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_1_rxq_idx;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_1_pdst;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_1_prs1;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_1_prs2;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_1_prs3;	// functional-unit.scala:229:23
  reg  [4:0]  r_uops_1_ppred;	// functional-unit.scala:229:23
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
  reg  [11:0] r_uops_2_br_mask;	// functional-unit.scala:229:23
  reg  [3:0]  r_uops_2_br_tag;	// functional-unit.scala:229:23
  reg  [4:0]  r_uops_2_ftq_idx;	// functional-unit.scala:229:23
  reg         r_uops_2_edge_inst;	// functional-unit.scala:229:23
  reg  [5:0]  r_uops_2_pc_lob;	// functional-unit.scala:229:23
  reg         r_uops_2_taken;	// functional-unit.scala:229:23
  reg  [19:0] r_uops_2_imm_packed;	// functional-unit.scala:229:23
  reg  [11:0] r_uops_2_csr_addr;	// functional-unit.scala:229:23
  reg  [5:0]  r_uops_2_rob_idx;	// functional-unit.scala:229:23
  reg  [3:0]  r_uops_2_ldq_idx;	// functional-unit.scala:229:23
  reg  [3:0]  r_uops_2_stq_idx;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_2_rxq_idx;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_2_pdst;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_2_prs1;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_2_prs2;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_2_prs3;	// functional-unit.scala:229:23
  reg  [4:0]  r_uops_2_ppred;	// functional-unit.scala:229:23
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
  reg  [11:0] r_uops_3_br_mask;	// functional-unit.scala:229:23
  reg  [3:0]  r_uops_3_br_tag;	// functional-unit.scala:229:23
  reg  [4:0]  r_uops_3_ftq_idx;	// functional-unit.scala:229:23
  reg         r_uops_3_edge_inst;	// functional-unit.scala:229:23
  reg  [5:0]  r_uops_3_pc_lob;	// functional-unit.scala:229:23
  reg         r_uops_3_taken;	// functional-unit.scala:229:23
  reg  [19:0] r_uops_3_imm_packed;	// functional-unit.scala:229:23
  reg  [11:0] r_uops_3_csr_addr;	// functional-unit.scala:229:23
  reg  [5:0]  r_uops_3_rob_idx;	// functional-unit.scala:229:23
  reg  [3:0]  r_uops_3_ldq_idx;	// functional-unit.scala:229:23
  reg  [3:0]  r_uops_3_stq_idx;	// functional-unit.scala:229:23
  reg  [1:0]  r_uops_3_rxq_idx;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_3_pdst;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_3_prs1;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_3_prs2;	// functional-unit.scala:229:23
  reg  [6:0]  r_uops_3_prs3;	// functional-unit.scala:229:23
  reg  [4:0]  r_uops_3_ppred;	// functional-unit.scala:229:23
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
  wire [11:0] _io_resp_bits_uop_br_mask_output =
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
        io_req_valid & (io_brupdate_b1_mispredict_mask & io_req_bits_uop_br_mask) == 12'h0
        & ~io_req_bits_kill;	// functional-unit.scala:228:27, :232:{84,87}, util.scala:118:{51,59}
      r_valids_1 <=
        r_valids_0 & (io_brupdate_b1_mispredict_mask & r_uops_0_br_mask) == 12'h0
        & ~io_req_bits_kill;	// functional-unit.scala:228:27, :229:23, :232:87, :238:83, util.scala:118:{51,59}
      r_valids_2 <=
        r_valids_1 & (io_brupdate_b1_mispredict_mask & r_uops_1_br_mask) == 12'h0
        & ~io_req_bits_kill;	// functional-unit.scala:228:27, :229:23, :232:87, :238:83, util.scala:118:{51,59}
      r_valids_3 <=
        r_valids_2 & (io_brupdate_b1_mispredict_mask & r_uops_2_br_mask) == 12'h0
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
      automatic logic [31:0] _RANDOM[0:50];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [5:0] i = 6'h0; i < 6'h33; i += 6'h1) begin
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
        r_uops_0_br_mask = _RANDOM[6'h5][11:0];	// functional-unit.scala:229:23
        r_uops_0_br_tag = _RANDOM[6'h5][15:12];	// functional-unit.scala:229:23
        r_uops_0_ftq_idx = _RANDOM[6'h5][20:16];	// functional-unit.scala:229:23
        r_uops_0_edge_inst = _RANDOM[6'h5][21];	// functional-unit.scala:229:23
        r_uops_0_pc_lob = _RANDOM[6'h5][27:22];	// functional-unit.scala:229:23
        r_uops_0_taken = _RANDOM[6'h5][28];	// functional-unit.scala:229:23
        r_uops_0_imm_packed = {_RANDOM[6'h5][31:29], _RANDOM[6'h6][16:0]};	// functional-unit.scala:229:23
        r_uops_0_csr_addr = _RANDOM[6'h6][28:17];	// functional-unit.scala:229:23
        r_uops_0_rob_idx = {_RANDOM[6'h6][31:29], _RANDOM[6'h7][2:0]};	// functional-unit.scala:229:23
        r_uops_0_ldq_idx = _RANDOM[6'h7][6:3];	// functional-unit.scala:229:23
        r_uops_0_stq_idx = _RANDOM[6'h7][10:7];	// functional-unit.scala:229:23
        r_uops_0_rxq_idx = _RANDOM[6'h7][12:11];	// functional-unit.scala:229:23
        r_uops_0_pdst = _RANDOM[6'h7][19:13];	// functional-unit.scala:229:23
        r_uops_0_prs1 = _RANDOM[6'h7][26:20];	// functional-unit.scala:229:23
        r_uops_0_prs2 = {_RANDOM[6'h7][31:27], _RANDOM[6'h8][1:0]};	// functional-unit.scala:229:23
        r_uops_0_prs3 = _RANDOM[6'h8][8:2];	// functional-unit.scala:229:23
        r_uops_0_ppred = _RANDOM[6'h8][13:9];	// functional-unit.scala:229:23
        r_uops_0_prs1_busy = _RANDOM[6'h8][14];	// functional-unit.scala:229:23
        r_uops_0_prs2_busy = _RANDOM[6'h8][15];	// functional-unit.scala:229:23
        r_uops_0_prs3_busy = _RANDOM[6'h8][16];	// functional-unit.scala:229:23
        r_uops_0_ppred_busy = _RANDOM[6'h8][17];	// functional-unit.scala:229:23
        r_uops_0_stale_pdst = _RANDOM[6'h8][24:18];	// functional-unit.scala:229:23
        r_uops_0_exception = _RANDOM[6'h8][25];	// functional-unit.scala:229:23
        r_uops_0_exc_cause = {_RANDOM[6'h8][31:26], _RANDOM[6'h9], _RANDOM[6'hA][25:0]};	// functional-unit.scala:229:23
        r_uops_0_bypassable = _RANDOM[6'hA][26];	// functional-unit.scala:229:23
        r_uops_0_mem_cmd = _RANDOM[6'hA][31:27];	// functional-unit.scala:229:23
        r_uops_0_mem_size = _RANDOM[6'hB][1:0];	// functional-unit.scala:229:23
        r_uops_0_mem_signed = _RANDOM[6'hB][2];	// functional-unit.scala:229:23
        r_uops_0_is_fence = _RANDOM[6'hB][3];	// functional-unit.scala:229:23
        r_uops_0_is_fencei = _RANDOM[6'hB][4];	// functional-unit.scala:229:23
        r_uops_0_is_amo = _RANDOM[6'hB][5];	// functional-unit.scala:229:23
        r_uops_0_uses_ldq = _RANDOM[6'hB][6];	// functional-unit.scala:229:23
        r_uops_0_uses_stq = _RANDOM[6'hB][7];	// functional-unit.scala:229:23
        r_uops_0_is_sys_pc2epc = _RANDOM[6'hB][8];	// functional-unit.scala:229:23
        r_uops_0_is_unique = _RANDOM[6'hB][9];	// functional-unit.scala:229:23
        r_uops_0_flush_on_commit = _RANDOM[6'hB][10];	// functional-unit.scala:229:23
        r_uops_0_ldst_is_rs1 = _RANDOM[6'hB][11];	// functional-unit.scala:229:23
        r_uops_0_ldst = _RANDOM[6'hB][17:12];	// functional-unit.scala:229:23
        r_uops_0_lrs1 = _RANDOM[6'hB][23:18];	// functional-unit.scala:229:23
        r_uops_0_lrs2 = _RANDOM[6'hB][29:24];	// functional-unit.scala:229:23
        r_uops_0_lrs3 = {_RANDOM[6'hB][31:30], _RANDOM[6'hC][3:0]};	// functional-unit.scala:229:23
        r_uops_0_ldst_val = _RANDOM[6'hC][4];	// functional-unit.scala:229:23
        r_uops_0_dst_rtype = _RANDOM[6'hC][6:5];	// functional-unit.scala:229:23
        r_uops_0_lrs1_rtype = _RANDOM[6'hC][8:7];	// functional-unit.scala:229:23
        r_uops_0_lrs2_rtype = _RANDOM[6'hC][10:9];	// functional-unit.scala:229:23
        r_uops_0_frs3_en = _RANDOM[6'hC][11];	// functional-unit.scala:229:23
        r_uops_0_fp_val = _RANDOM[6'hC][12];	// functional-unit.scala:229:23
        r_uops_0_fp_single = _RANDOM[6'hC][13];	// functional-unit.scala:229:23
        r_uops_0_xcpt_pf_if = _RANDOM[6'hC][14];	// functional-unit.scala:229:23
        r_uops_0_xcpt_ae_if = _RANDOM[6'hC][15];	// functional-unit.scala:229:23
        r_uops_0_xcpt_ma_if = _RANDOM[6'hC][16];	// functional-unit.scala:229:23
        r_uops_0_bp_debug_if = _RANDOM[6'hC][17];	// functional-unit.scala:229:23
        r_uops_0_bp_xcpt_if = _RANDOM[6'hC][18];	// functional-unit.scala:229:23
        r_uops_0_debug_fsrc = _RANDOM[6'hC][20:19];	// functional-unit.scala:229:23
        r_uops_0_debug_tsrc = _RANDOM[6'hC][22:21];	// functional-unit.scala:229:23
        r_uops_1_uopc = _RANDOM[6'hC][29:23];	// functional-unit.scala:229:23
        r_uops_1_inst = {_RANDOM[6'hC][31:30], _RANDOM[6'hD][29:0]};	// functional-unit.scala:229:23
        r_uops_1_debug_inst = {_RANDOM[6'hD][31:30], _RANDOM[6'hE][29:0]};	// functional-unit.scala:229:23
        r_uops_1_is_rvc = _RANDOM[6'hE][30];	// functional-unit.scala:229:23
        r_uops_1_debug_pc = {_RANDOM[6'hE][31], _RANDOM[6'hF], _RANDOM[6'h10][6:0]};	// functional-unit.scala:229:23
        r_uops_1_iq_type = _RANDOM[6'h10][9:7];	// functional-unit.scala:229:23
        r_uops_1_fu_code = _RANDOM[6'h10][19:10];	// functional-unit.scala:229:23
        r_uops_1_ctrl_br_type = _RANDOM[6'h10][23:20];	// functional-unit.scala:229:23
        r_uops_1_ctrl_op1_sel = _RANDOM[6'h10][25:24];	// functional-unit.scala:229:23
        r_uops_1_ctrl_op2_sel = _RANDOM[6'h10][28:26];	// functional-unit.scala:229:23
        r_uops_1_ctrl_imm_sel = _RANDOM[6'h10][31:29];	// functional-unit.scala:229:23
        r_uops_1_ctrl_op_fcn = _RANDOM[6'h11][3:0];	// functional-unit.scala:229:23
        r_uops_1_ctrl_fcn_dw = _RANDOM[6'h11][4];	// functional-unit.scala:229:23
        r_uops_1_ctrl_csr_cmd = _RANDOM[6'h11][7:5];	// functional-unit.scala:229:23
        r_uops_1_ctrl_is_load = _RANDOM[6'h11][8];	// functional-unit.scala:229:23
        r_uops_1_ctrl_is_sta = _RANDOM[6'h11][9];	// functional-unit.scala:229:23
        r_uops_1_ctrl_is_std = _RANDOM[6'h11][10];	// functional-unit.scala:229:23
        r_uops_1_iw_state = _RANDOM[6'h11][12:11];	// functional-unit.scala:229:23
        r_uops_1_iw_p1_poisoned = _RANDOM[6'h11][13];	// functional-unit.scala:229:23
        r_uops_1_iw_p2_poisoned = _RANDOM[6'h11][14];	// functional-unit.scala:229:23
        r_uops_1_is_br = _RANDOM[6'h11][15];	// functional-unit.scala:229:23
        r_uops_1_is_jalr = _RANDOM[6'h11][16];	// functional-unit.scala:229:23
        r_uops_1_is_jal = _RANDOM[6'h11][17];	// functional-unit.scala:229:23
        r_uops_1_is_sfb = _RANDOM[6'h11][18];	// functional-unit.scala:229:23
        r_uops_1_br_mask = _RANDOM[6'h11][30:19];	// functional-unit.scala:229:23
        r_uops_1_br_tag = {_RANDOM[6'h11][31], _RANDOM[6'h12][2:0]};	// functional-unit.scala:229:23
        r_uops_1_ftq_idx = _RANDOM[6'h12][7:3];	// functional-unit.scala:229:23
        r_uops_1_edge_inst = _RANDOM[6'h12][8];	// functional-unit.scala:229:23
        r_uops_1_pc_lob = _RANDOM[6'h12][14:9];	// functional-unit.scala:229:23
        r_uops_1_taken = _RANDOM[6'h12][15];	// functional-unit.scala:229:23
        r_uops_1_imm_packed = {_RANDOM[6'h12][31:16], _RANDOM[6'h13][3:0]};	// functional-unit.scala:229:23
        r_uops_1_csr_addr = _RANDOM[6'h13][15:4];	// functional-unit.scala:229:23
        r_uops_1_rob_idx = _RANDOM[6'h13][21:16];	// functional-unit.scala:229:23
        r_uops_1_ldq_idx = _RANDOM[6'h13][25:22];	// functional-unit.scala:229:23
        r_uops_1_stq_idx = _RANDOM[6'h13][29:26];	// functional-unit.scala:229:23
        r_uops_1_rxq_idx = _RANDOM[6'h13][31:30];	// functional-unit.scala:229:23
        r_uops_1_pdst = _RANDOM[6'h14][6:0];	// functional-unit.scala:229:23
        r_uops_1_prs1 = _RANDOM[6'h14][13:7];	// functional-unit.scala:229:23
        r_uops_1_prs2 = _RANDOM[6'h14][20:14];	// functional-unit.scala:229:23
        r_uops_1_prs3 = _RANDOM[6'h14][27:21];	// functional-unit.scala:229:23
        r_uops_1_ppred = {_RANDOM[6'h14][31:28], _RANDOM[6'h15][0]};	// functional-unit.scala:229:23
        r_uops_1_prs1_busy = _RANDOM[6'h15][1];	// functional-unit.scala:229:23
        r_uops_1_prs2_busy = _RANDOM[6'h15][2];	// functional-unit.scala:229:23
        r_uops_1_prs3_busy = _RANDOM[6'h15][3];	// functional-unit.scala:229:23
        r_uops_1_ppred_busy = _RANDOM[6'h15][4];	// functional-unit.scala:229:23
        r_uops_1_stale_pdst = _RANDOM[6'h15][11:5];	// functional-unit.scala:229:23
        r_uops_1_exception = _RANDOM[6'h15][12];	// functional-unit.scala:229:23
        r_uops_1_exc_cause =
          {_RANDOM[6'h15][31:13], _RANDOM[6'h16], _RANDOM[6'h17][12:0]};	// functional-unit.scala:229:23
        r_uops_1_bypassable = _RANDOM[6'h17][13];	// functional-unit.scala:229:23
        r_uops_1_mem_cmd = _RANDOM[6'h17][18:14];	// functional-unit.scala:229:23
        r_uops_1_mem_size = _RANDOM[6'h17][20:19];	// functional-unit.scala:229:23
        r_uops_1_mem_signed = _RANDOM[6'h17][21];	// functional-unit.scala:229:23
        r_uops_1_is_fence = _RANDOM[6'h17][22];	// functional-unit.scala:229:23
        r_uops_1_is_fencei = _RANDOM[6'h17][23];	// functional-unit.scala:229:23
        r_uops_1_is_amo = _RANDOM[6'h17][24];	// functional-unit.scala:229:23
        r_uops_1_uses_ldq = _RANDOM[6'h17][25];	// functional-unit.scala:229:23
        r_uops_1_uses_stq = _RANDOM[6'h17][26];	// functional-unit.scala:229:23
        r_uops_1_is_sys_pc2epc = _RANDOM[6'h17][27];	// functional-unit.scala:229:23
        r_uops_1_is_unique = _RANDOM[6'h17][28];	// functional-unit.scala:229:23
        r_uops_1_flush_on_commit = _RANDOM[6'h17][29];	// functional-unit.scala:229:23
        r_uops_1_ldst_is_rs1 = _RANDOM[6'h17][30];	// functional-unit.scala:229:23
        r_uops_1_ldst = {_RANDOM[6'h17][31], _RANDOM[6'h18][4:0]};	// functional-unit.scala:229:23
        r_uops_1_lrs1 = _RANDOM[6'h18][10:5];	// functional-unit.scala:229:23
        r_uops_1_lrs2 = _RANDOM[6'h18][16:11];	// functional-unit.scala:229:23
        r_uops_1_lrs3 = _RANDOM[6'h18][22:17];	// functional-unit.scala:229:23
        r_uops_1_ldst_val = _RANDOM[6'h18][23];	// functional-unit.scala:229:23
        r_uops_1_dst_rtype = _RANDOM[6'h18][25:24];	// functional-unit.scala:229:23
        r_uops_1_lrs1_rtype = _RANDOM[6'h18][27:26];	// functional-unit.scala:229:23
        r_uops_1_lrs2_rtype = _RANDOM[6'h18][29:28];	// functional-unit.scala:229:23
        r_uops_1_frs3_en = _RANDOM[6'h18][30];	// functional-unit.scala:229:23
        r_uops_1_fp_val = _RANDOM[6'h18][31];	// functional-unit.scala:229:23
        r_uops_1_fp_single = _RANDOM[6'h19][0];	// functional-unit.scala:229:23
        r_uops_1_xcpt_pf_if = _RANDOM[6'h19][1];	// functional-unit.scala:229:23
        r_uops_1_xcpt_ae_if = _RANDOM[6'h19][2];	// functional-unit.scala:229:23
        r_uops_1_xcpt_ma_if = _RANDOM[6'h19][3];	// functional-unit.scala:229:23
        r_uops_1_bp_debug_if = _RANDOM[6'h19][4];	// functional-unit.scala:229:23
        r_uops_1_bp_xcpt_if = _RANDOM[6'h19][5];	// functional-unit.scala:229:23
        r_uops_1_debug_fsrc = _RANDOM[6'h19][7:6];	// functional-unit.scala:229:23
        r_uops_1_debug_tsrc = _RANDOM[6'h19][9:8];	// functional-unit.scala:229:23
        r_uops_2_uopc = _RANDOM[6'h19][16:10];	// functional-unit.scala:229:23
        r_uops_2_inst = {_RANDOM[6'h19][31:17], _RANDOM[6'h1A][16:0]};	// functional-unit.scala:229:23
        r_uops_2_debug_inst = {_RANDOM[6'h1A][31:17], _RANDOM[6'h1B][16:0]};	// functional-unit.scala:229:23
        r_uops_2_is_rvc = _RANDOM[6'h1B][17];	// functional-unit.scala:229:23
        r_uops_2_debug_pc = {_RANDOM[6'h1B][31:18], _RANDOM[6'h1C][25:0]};	// functional-unit.scala:229:23
        r_uops_2_iq_type = _RANDOM[6'h1C][28:26];	// functional-unit.scala:229:23
        r_uops_2_fu_code = {_RANDOM[6'h1C][31:29], _RANDOM[6'h1D][6:0]};	// functional-unit.scala:229:23
        r_uops_2_ctrl_br_type = _RANDOM[6'h1D][10:7];	// functional-unit.scala:229:23
        r_uops_2_ctrl_op1_sel = _RANDOM[6'h1D][12:11];	// functional-unit.scala:229:23
        r_uops_2_ctrl_op2_sel = _RANDOM[6'h1D][15:13];	// functional-unit.scala:229:23
        r_uops_2_ctrl_imm_sel = _RANDOM[6'h1D][18:16];	// functional-unit.scala:229:23
        r_uops_2_ctrl_op_fcn = _RANDOM[6'h1D][22:19];	// functional-unit.scala:229:23
        r_uops_2_ctrl_fcn_dw = _RANDOM[6'h1D][23];	// functional-unit.scala:229:23
        r_uops_2_ctrl_csr_cmd = _RANDOM[6'h1D][26:24];	// functional-unit.scala:229:23
        r_uops_2_ctrl_is_load = _RANDOM[6'h1D][27];	// functional-unit.scala:229:23
        r_uops_2_ctrl_is_sta = _RANDOM[6'h1D][28];	// functional-unit.scala:229:23
        r_uops_2_ctrl_is_std = _RANDOM[6'h1D][29];	// functional-unit.scala:229:23
        r_uops_2_iw_state = _RANDOM[6'h1D][31:30];	// functional-unit.scala:229:23
        r_uops_2_iw_p1_poisoned = _RANDOM[6'h1E][0];	// functional-unit.scala:229:23
        r_uops_2_iw_p2_poisoned = _RANDOM[6'h1E][1];	// functional-unit.scala:229:23
        r_uops_2_is_br = _RANDOM[6'h1E][2];	// functional-unit.scala:229:23
        r_uops_2_is_jalr = _RANDOM[6'h1E][3];	// functional-unit.scala:229:23
        r_uops_2_is_jal = _RANDOM[6'h1E][4];	// functional-unit.scala:229:23
        r_uops_2_is_sfb = _RANDOM[6'h1E][5];	// functional-unit.scala:229:23
        r_uops_2_br_mask = _RANDOM[6'h1E][17:6];	// functional-unit.scala:229:23
        r_uops_2_br_tag = _RANDOM[6'h1E][21:18];	// functional-unit.scala:229:23
        r_uops_2_ftq_idx = _RANDOM[6'h1E][26:22];	// functional-unit.scala:229:23
        r_uops_2_edge_inst = _RANDOM[6'h1E][27];	// functional-unit.scala:229:23
        r_uops_2_pc_lob = {_RANDOM[6'h1E][31:28], _RANDOM[6'h1F][1:0]};	// functional-unit.scala:229:23
        r_uops_2_taken = _RANDOM[6'h1F][2];	// functional-unit.scala:229:23
        r_uops_2_imm_packed = _RANDOM[6'h1F][22:3];	// functional-unit.scala:229:23
        r_uops_2_csr_addr = {_RANDOM[6'h1F][31:23], _RANDOM[6'h20][2:0]};	// functional-unit.scala:229:23
        r_uops_2_rob_idx = _RANDOM[6'h20][8:3];	// functional-unit.scala:229:23
        r_uops_2_ldq_idx = _RANDOM[6'h20][12:9];	// functional-unit.scala:229:23
        r_uops_2_stq_idx = _RANDOM[6'h20][16:13];	// functional-unit.scala:229:23
        r_uops_2_rxq_idx = _RANDOM[6'h20][18:17];	// functional-unit.scala:229:23
        r_uops_2_pdst = _RANDOM[6'h20][25:19];	// functional-unit.scala:229:23
        r_uops_2_prs1 = {_RANDOM[6'h20][31:26], _RANDOM[6'h21][0]};	// functional-unit.scala:229:23
        r_uops_2_prs2 = _RANDOM[6'h21][7:1];	// functional-unit.scala:229:23
        r_uops_2_prs3 = _RANDOM[6'h21][14:8];	// functional-unit.scala:229:23
        r_uops_2_ppred = _RANDOM[6'h21][19:15];	// functional-unit.scala:229:23
        r_uops_2_prs1_busy = _RANDOM[6'h21][20];	// functional-unit.scala:229:23
        r_uops_2_prs2_busy = _RANDOM[6'h21][21];	// functional-unit.scala:229:23
        r_uops_2_prs3_busy = _RANDOM[6'h21][22];	// functional-unit.scala:229:23
        r_uops_2_ppred_busy = _RANDOM[6'h21][23];	// functional-unit.scala:229:23
        r_uops_2_stale_pdst = _RANDOM[6'h21][30:24];	// functional-unit.scala:229:23
        r_uops_2_exception = _RANDOM[6'h21][31];	// functional-unit.scala:229:23
        r_uops_2_exc_cause = {_RANDOM[6'h22], _RANDOM[6'h23]};	// functional-unit.scala:229:23
        r_uops_2_bypassable = _RANDOM[6'h24][0];	// functional-unit.scala:229:23
        r_uops_2_mem_cmd = _RANDOM[6'h24][5:1];	// functional-unit.scala:229:23
        r_uops_2_mem_size = _RANDOM[6'h24][7:6];	// functional-unit.scala:229:23
        r_uops_2_mem_signed = _RANDOM[6'h24][8];	// functional-unit.scala:229:23
        r_uops_2_is_fence = _RANDOM[6'h24][9];	// functional-unit.scala:229:23
        r_uops_2_is_fencei = _RANDOM[6'h24][10];	// functional-unit.scala:229:23
        r_uops_2_is_amo = _RANDOM[6'h24][11];	// functional-unit.scala:229:23
        r_uops_2_uses_ldq = _RANDOM[6'h24][12];	// functional-unit.scala:229:23
        r_uops_2_uses_stq = _RANDOM[6'h24][13];	// functional-unit.scala:229:23
        r_uops_2_is_sys_pc2epc = _RANDOM[6'h24][14];	// functional-unit.scala:229:23
        r_uops_2_is_unique = _RANDOM[6'h24][15];	// functional-unit.scala:229:23
        r_uops_2_flush_on_commit = _RANDOM[6'h24][16];	// functional-unit.scala:229:23
        r_uops_2_ldst_is_rs1 = _RANDOM[6'h24][17];	// functional-unit.scala:229:23
        r_uops_2_ldst = _RANDOM[6'h24][23:18];	// functional-unit.scala:229:23
        r_uops_2_lrs1 = _RANDOM[6'h24][29:24];	// functional-unit.scala:229:23
        r_uops_2_lrs2 = {_RANDOM[6'h24][31:30], _RANDOM[6'h25][3:0]};	// functional-unit.scala:229:23
        r_uops_2_lrs3 = _RANDOM[6'h25][9:4];	// functional-unit.scala:229:23
        r_uops_2_ldst_val = _RANDOM[6'h25][10];	// functional-unit.scala:229:23
        r_uops_2_dst_rtype = _RANDOM[6'h25][12:11];	// functional-unit.scala:229:23
        r_uops_2_lrs1_rtype = _RANDOM[6'h25][14:13];	// functional-unit.scala:229:23
        r_uops_2_lrs2_rtype = _RANDOM[6'h25][16:15];	// functional-unit.scala:229:23
        r_uops_2_frs3_en = _RANDOM[6'h25][17];	// functional-unit.scala:229:23
        r_uops_2_fp_val = _RANDOM[6'h25][18];	// functional-unit.scala:229:23
        r_uops_2_fp_single = _RANDOM[6'h25][19];	// functional-unit.scala:229:23
        r_uops_2_xcpt_pf_if = _RANDOM[6'h25][20];	// functional-unit.scala:229:23
        r_uops_2_xcpt_ae_if = _RANDOM[6'h25][21];	// functional-unit.scala:229:23
        r_uops_2_xcpt_ma_if = _RANDOM[6'h25][22];	// functional-unit.scala:229:23
        r_uops_2_bp_debug_if = _RANDOM[6'h25][23];	// functional-unit.scala:229:23
        r_uops_2_bp_xcpt_if = _RANDOM[6'h25][24];	// functional-unit.scala:229:23
        r_uops_2_debug_fsrc = _RANDOM[6'h25][26:25];	// functional-unit.scala:229:23
        r_uops_2_debug_tsrc = _RANDOM[6'h25][28:27];	// functional-unit.scala:229:23
        r_uops_3_uopc = {_RANDOM[6'h25][31:29], _RANDOM[6'h26][3:0]};	// functional-unit.scala:229:23
        r_uops_3_inst = {_RANDOM[6'h26][31:4], _RANDOM[6'h27][3:0]};	// functional-unit.scala:229:23
        r_uops_3_debug_inst = {_RANDOM[6'h27][31:4], _RANDOM[6'h28][3:0]};	// functional-unit.scala:229:23
        r_uops_3_is_rvc = _RANDOM[6'h28][4];	// functional-unit.scala:229:23
        r_uops_3_debug_pc = {_RANDOM[6'h28][31:5], _RANDOM[6'h29][12:0]};	// functional-unit.scala:229:23
        r_uops_3_iq_type = _RANDOM[6'h29][15:13];	// functional-unit.scala:229:23
        r_uops_3_fu_code = _RANDOM[6'h29][25:16];	// functional-unit.scala:229:23
        r_uops_3_ctrl_br_type = _RANDOM[6'h29][29:26];	// functional-unit.scala:229:23
        r_uops_3_ctrl_op1_sel = _RANDOM[6'h29][31:30];	// functional-unit.scala:229:23
        r_uops_3_ctrl_op2_sel = _RANDOM[6'h2A][2:0];	// functional-unit.scala:229:23
        r_uops_3_ctrl_imm_sel = _RANDOM[6'h2A][5:3];	// functional-unit.scala:229:23
        r_uops_3_ctrl_op_fcn = _RANDOM[6'h2A][9:6];	// functional-unit.scala:229:23
        r_uops_3_ctrl_fcn_dw = _RANDOM[6'h2A][10];	// functional-unit.scala:229:23
        r_uops_3_ctrl_csr_cmd = _RANDOM[6'h2A][13:11];	// functional-unit.scala:229:23
        r_uops_3_ctrl_is_load = _RANDOM[6'h2A][14];	// functional-unit.scala:229:23
        r_uops_3_ctrl_is_sta = _RANDOM[6'h2A][15];	// functional-unit.scala:229:23
        r_uops_3_ctrl_is_std = _RANDOM[6'h2A][16];	// functional-unit.scala:229:23
        r_uops_3_iw_state = _RANDOM[6'h2A][18:17];	// functional-unit.scala:229:23
        r_uops_3_iw_p1_poisoned = _RANDOM[6'h2A][19];	// functional-unit.scala:229:23
        r_uops_3_iw_p2_poisoned = _RANDOM[6'h2A][20];	// functional-unit.scala:229:23
        r_uops_3_is_br = _RANDOM[6'h2A][21];	// functional-unit.scala:229:23
        r_uops_3_is_jalr = _RANDOM[6'h2A][22];	// functional-unit.scala:229:23
        r_uops_3_is_jal = _RANDOM[6'h2A][23];	// functional-unit.scala:229:23
        r_uops_3_is_sfb = _RANDOM[6'h2A][24];	// functional-unit.scala:229:23
        r_uops_3_br_mask = {_RANDOM[6'h2A][31:25], _RANDOM[6'h2B][4:0]};	// functional-unit.scala:229:23
        r_uops_3_br_tag = _RANDOM[6'h2B][8:5];	// functional-unit.scala:229:23
        r_uops_3_ftq_idx = _RANDOM[6'h2B][13:9];	// functional-unit.scala:229:23
        r_uops_3_edge_inst = _RANDOM[6'h2B][14];	// functional-unit.scala:229:23
        r_uops_3_pc_lob = _RANDOM[6'h2B][20:15];	// functional-unit.scala:229:23
        r_uops_3_taken = _RANDOM[6'h2B][21];	// functional-unit.scala:229:23
        r_uops_3_imm_packed = {_RANDOM[6'h2B][31:22], _RANDOM[6'h2C][9:0]};	// functional-unit.scala:229:23
        r_uops_3_csr_addr = _RANDOM[6'h2C][21:10];	// functional-unit.scala:229:23
        r_uops_3_rob_idx = _RANDOM[6'h2C][27:22];	// functional-unit.scala:229:23
        r_uops_3_ldq_idx = _RANDOM[6'h2C][31:28];	// functional-unit.scala:229:23
        r_uops_3_stq_idx = _RANDOM[6'h2D][3:0];	// functional-unit.scala:229:23
        r_uops_3_rxq_idx = _RANDOM[6'h2D][5:4];	// functional-unit.scala:229:23
        r_uops_3_pdst = _RANDOM[6'h2D][12:6];	// functional-unit.scala:229:23
        r_uops_3_prs1 = _RANDOM[6'h2D][19:13];	// functional-unit.scala:229:23
        r_uops_3_prs2 = _RANDOM[6'h2D][26:20];	// functional-unit.scala:229:23
        r_uops_3_prs3 = {_RANDOM[6'h2D][31:27], _RANDOM[6'h2E][1:0]};	// functional-unit.scala:229:23
        r_uops_3_ppred = _RANDOM[6'h2E][6:2];	// functional-unit.scala:229:23
        r_uops_3_prs1_busy = _RANDOM[6'h2E][7];	// functional-unit.scala:229:23
        r_uops_3_prs2_busy = _RANDOM[6'h2E][8];	// functional-unit.scala:229:23
        r_uops_3_prs3_busy = _RANDOM[6'h2E][9];	// functional-unit.scala:229:23
        r_uops_3_ppred_busy = _RANDOM[6'h2E][10];	// functional-unit.scala:229:23
        r_uops_3_stale_pdst = _RANDOM[6'h2E][17:11];	// functional-unit.scala:229:23
        r_uops_3_exception = _RANDOM[6'h2E][18];	// functional-unit.scala:229:23
        r_uops_3_exc_cause =
          {_RANDOM[6'h2E][31:19], _RANDOM[6'h2F], _RANDOM[6'h30][18:0]};	// functional-unit.scala:229:23
        r_uops_3_bypassable = _RANDOM[6'h30][19];	// functional-unit.scala:229:23
        r_uops_3_mem_cmd = _RANDOM[6'h30][24:20];	// functional-unit.scala:229:23
        r_uops_3_mem_size = _RANDOM[6'h30][26:25];	// functional-unit.scala:229:23
        r_uops_3_mem_signed = _RANDOM[6'h30][27];	// functional-unit.scala:229:23
        r_uops_3_is_fence = _RANDOM[6'h30][28];	// functional-unit.scala:229:23
        r_uops_3_is_fencei = _RANDOM[6'h30][29];	// functional-unit.scala:229:23
        r_uops_3_is_amo = _RANDOM[6'h30][30];	// functional-unit.scala:229:23
        r_uops_3_uses_ldq = _RANDOM[6'h30][31];	// functional-unit.scala:229:23
        r_uops_3_uses_stq = _RANDOM[6'h31][0];	// functional-unit.scala:229:23
        r_uops_3_is_sys_pc2epc = _RANDOM[6'h31][1];	// functional-unit.scala:229:23
        r_uops_3_is_unique = _RANDOM[6'h31][2];	// functional-unit.scala:229:23
        r_uops_3_flush_on_commit = _RANDOM[6'h31][3];	// functional-unit.scala:229:23
        r_uops_3_ldst_is_rs1 = _RANDOM[6'h31][4];	// functional-unit.scala:229:23
        r_uops_3_ldst = _RANDOM[6'h31][10:5];	// functional-unit.scala:229:23
        r_uops_3_lrs1 = _RANDOM[6'h31][16:11];	// functional-unit.scala:229:23
        r_uops_3_lrs2 = _RANDOM[6'h31][22:17];	// functional-unit.scala:229:23
        r_uops_3_lrs3 = _RANDOM[6'h31][28:23];	// functional-unit.scala:229:23
        r_uops_3_ldst_val = _RANDOM[6'h31][29];	// functional-unit.scala:229:23
        r_uops_3_dst_rtype = _RANDOM[6'h31][31:30];	// functional-unit.scala:229:23
        r_uops_3_lrs1_rtype = _RANDOM[6'h32][1:0];	// functional-unit.scala:229:23
        r_uops_3_lrs2_rtype = _RANDOM[6'h32][3:2];	// functional-unit.scala:229:23
        r_uops_3_frs3_en = _RANDOM[6'h32][4];	// functional-unit.scala:229:23
        r_uops_3_fp_val = _RANDOM[6'h32][5];	// functional-unit.scala:229:23
        r_uops_3_fp_single = _RANDOM[6'h32][6];	// functional-unit.scala:229:23
        r_uops_3_xcpt_pf_if = _RANDOM[6'h32][7];	// functional-unit.scala:229:23
        r_uops_3_xcpt_ae_if = _RANDOM[6'h32][8];	// functional-unit.scala:229:23
        r_uops_3_xcpt_ma_if = _RANDOM[6'h32][9];	// functional-unit.scala:229:23
        r_uops_3_bp_debug_if = _RANDOM[6'h32][10];	// functional-unit.scala:229:23
        r_uops_3_bp_xcpt_if = _RANDOM[6'h32][11];	// functional-unit.scala:229:23
        r_uops_3_debug_fsrc = _RANDOM[6'h32][13:12];	// functional-unit.scala:229:23
        r_uops_3_debug_tsrc = _RANDOM[6'h32][15:14];	// functional-unit.scala:229:23
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  FPU_4 fpu (	// functional-unit.scala:565:19
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
    r_valids_3 & (io_brupdate_b1_mispredict_mask & r_uops_3_br_mask) == 12'h0;	// functional-unit.scala:228:27, :229:23, :249:47, util.scala:118:{51,59}
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

