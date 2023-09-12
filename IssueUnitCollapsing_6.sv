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

module IssueUnitCollapsing_6(
  input         clock,
                reset,
                io_dis_uops_0_valid,
  input  [6:0]  io_dis_uops_0_bits_uopc,
  input  [31:0] io_dis_uops_0_bits_inst,
                io_dis_uops_0_bits_debug_inst,
  input         io_dis_uops_0_bits_is_rvc,
  input  [39:0] io_dis_uops_0_bits_debug_pc,
  input  [2:0]  io_dis_uops_0_bits_iq_type,
  input  [9:0]  io_dis_uops_0_bits_fu_code,
  input         io_dis_uops_0_bits_is_br,
                io_dis_uops_0_bits_is_jalr,
                io_dis_uops_0_bits_is_jal,
                io_dis_uops_0_bits_is_sfb,
  input  [11:0] io_dis_uops_0_bits_br_mask,
  input  [3:0]  io_dis_uops_0_bits_br_tag,
  input  [4:0]  io_dis_uops_0_bits_ftq_idx,
  input         io_dis_uops_0_bits_edge_inst,
  input  [5:0]  io_dis_uops_0_bits_pc_lob,
  input         io_dis_uops_0_bits_taken,
  input  [19:0] io_dis_uops_0_bits_imm_packed,
  input  [11:0] io_dis_uops_0_bits_csr_addr,
  input  [5:0]  io_dis_uops_0_bits_rob_idx,
  input  [3:0]  io_dis_uops_0_bits_ldq_idx,
                io_dis_uops_0_bits_stq_idx,
  input  [1:0]  io_dis_uops_0_bits_rxq_idx,
  input  [6:0]  io_dis_uops_0_bits_pdst,
                io_dis_uops_0_bits_prs1,
                io_dis_uops_0_bits_prs2,
                io_dis_uops_0_bits_prs3,
  input         io_dis_uops_0_bits_prs1_busy,
                io_dis_uops_0_bits_prs2_busy,
                io_dis_uops_0_bits_prs3_busy,
  input  [6:0]  io_dis_uops_0_bits_stale_pdst,
  input         io_dis_uops_0_bits_exception,
  input  [63:0] io_dis_uops_0_bits_exc_cause,
  input         io_dis_uops_0_bits_bypassable,
  input  [4:0]  io_dis_uops_0_bits_mem_cmd,
  input  [1:0]  io_dis_uops_0_bits_mem_size,
  input         io_dis_uops_0_bits_mem_signed,
                io_dis_uops_0_bits_is_fence,
                io_dis_uops_0_bits_is_fencei,
                io_dis_uops_0_bits_is_amo,
                io_dis_uops_0_bits_uses_ldq,
                io_dis_uops_0_bits_uses_stq,
                io_dis_uops_0_bits_is_sys_pc2epc,
                io_dis_uops_0_bits_is_unique,
                io_dis_uops_0_bits_flush_on_commit,
                io_dis_uops_0_bits_ldst_is_rs1,
  input  [5:0]  io_dis_uops_0_bits_ldst,
                io_dis_uops_0_bits_lrs1,
                io_dis_uops_0_bits_lrs2,
                io_dis_uops_0_bits_lrs3,
  input         io_dis_uops_0_bits_ldst_val,
  input  [1:0]  io_dis_uops_0_bits_dst_rtype,
                io_dis_uops_0_bits_lrs1_rtype,
                io_dis_uops_0_bits_lrs2_rtype,
  input         io_dis_uops_0_bits_frs3_en,
                io_dis_uops_0_bits_fp_val,
                io_dis_uops_0_bits_fp_single,
                io_dis_uops_0_bits_xcpt_pf_if,
                io_dis_uops_0_bits_xcpt_ae_if,
                io_dis_uops_0_bits_xcpt_ma_if,
                io_dis_uops_0_bits_bp_debug_if,
                io_dis_uops_0_bits_bp_xcpt_if,
  input  [1:0]  io_dis_uops_0_bits_debug_fsrc,
                io_dis_uops_0_bits_debug_tsrc,
  input         io_dis_uops_1_valid,
  input  [6:0]  io_dis_uops_1_bits_uopc,
  input  [31:0] io_dis_uops_1_bits_inst,
                io_dis_uops_1_bits_debug_inst,
  input         io_dis_uops_1_bits_is_rvc,
  input  [39:0] io_dis_uops_1_bits_debug_pc,
  input  [2:0]  io_dis_uops_1_bits_iq_type,
  input  [9:0]  io_dis_uops_1_bits_fu_code,
  input         io_dis_uops_1_bits_is_br,
                io_dis_uops_1_bits_is_jalr,
                io_dis_uops_1_bits_is_jal,
                io_dis_uops_1_bits_is_sfb,
  input  [11:0] io_dis_uops_1_bits_br_mask,
  input  [3:0]  io_dis_uops_1_bits_br_tag,
  input  [4:0]  io_dis_uops_1_bits_ftq_idx,
  input         io_dis_uops_1_bits_edge_inst,
  input  [5:0]  io_dis_uops_1_bits_pc_lob,
  input         io_dis_uops_1_bits_taken,
  input  [19:0] io_dis_uops_1_bits_imm_packed,
  input  [11:0] io_dis_uops_1_bits_csr_addr,
  input  [5:0]  io_dis_uops_1_bits_rob_idx,
  input  [3:0]  io_dis_uops_1_bits_ldq_idx,
                io_dis_uops_1_bits_stq_idx,
  input  [1:0]  io_dis_uops_1_bits_rxq_idx,
  input  [6:0]  io_dis_uops_1_bits_pdst,
                io_dis_uops_1_bits_prs1,
                io_dis_uops_1_bits_prs2,
                io_dis_uops_1_bits_prs3,
  input         io_dis_uops_1_bits_prs1_busy,
                io_dis_uops_1_bits_prs2_busy,
                io_dis_uops_1_bits_prs3_busy,
  input  [6:0]  io_dis_uops_1_bits_stale_pdst,
  input         io_dis_uops_1_bits_exception,
  input  [63:0] io_dis_uops_1_bits_exc_cause,
  input         io_dis_uops_1_bits_bypassable,
  input  [4:0]  io_dis_uops_1_bits_mem_cmd,
  input  [1:0]  io_dis_uops_1_bits_mem_size,
  input         io_dis_uops_1_bits_mem_signed,
                io_dis_uops_1_bits_is_fence,
                io_dis_uops_1_bits_is_fencei,
                io_dis_uops_1_bits_is_amo,
                io_dis_uops_1_bits_uses_ldq,
                io_dis_uops_1_bits_uses_stq,
                io_dis_uops_1_bits_is_sys_pc2epc,
                io_dis_uops_1_bits_is_unique,
                io_dis_uops_1_bits_flush_on_commit,
                io_dis_uops_1_bits_ldst_is_rs1,
  input  [5:0]  io_dis_uops_1_bits_ldst,
                io_dis_uops_1_bits_lrs1,
                io_dis_uops_1_bits_lrs2,
                io_dis_uops_1_bits_lrs3,
  input         io_dis_uops_1_bits_ldst_val,
  input  [1:0]  io_dis_uops_1_bits_dst_rtype,
                io_dis_uops_1_bits_lrs1_rtype,
                io_dis_uops_1_bits_lrs2_rtype,
  input         io_dis_uops_1_bits_frs3_en,
                io_dis_uops_1_bits_fp_val,
                io_dis_uops_1_bits_fp_single,
                io_dis_uops_1_bits_xcpt_pf_if,
                io_dis_uops_1_bits_xcpt_ae_if,
                io_dis_uops_1_bits_xcpt_ma_if,
                io_dis_uops_1_bits_bp_debug_if,
                io_dis_uops_1_bits_bp_xcpt_if,
  input  [1:0]  io_dis_uops_1_bits_debug_fsrc,
                io_dis_uops_1_bits_debug_tsrc,
  input         io_wakeup_ports_0_valid,
  input  [6:0]  io_wakeup_ports_0_bits_pdst,
  input         io_wakeup_ports_1_valid,
  input  [6:0]  io_wakeup_ports_1_bits_pdst,
  input  [9:0]  io_fu_types_0,
  input  [11:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  input         io_flush_pipeline,
  output        io_dis_uops_0_ready,
                io_dis_uops_1_ready,
                io_iss_valids_0,
  output [6:0]  io_iss_uops_0_uopc,
  output [31:0] io_iss_uops_0_inst,
                io_iss_uops_0_debug_inst,
  output        io_iss_uops_0_is_rvc,
  output [39:0] io_iss_uops_0_debug_pc,
  output [2:0]  io_iss_uops_0_iq_type,
  output [9:0]  io_iss_uops_0_fu_code,
  output [1:0]  io_iss_uops_0_iw_state,
  output        io_iss_uops_0_iw_p1_poisoned,
                io_iss_uops_0_iw_p2_poisoned,
                io_iss_uops_0_is_br,
                io_iss_uops_0_is_jalr,
                io_iss_uops_0_is_jal,
                io_iss_uops_0_is_sfb,
  output [11:0] io_iss_uops_0_br_mask,
  output [3:0]  io_iss_uops_0_br_tag,
  output [4:0]  io_iss_uops_0_ftq_idx,
  output        io_iss_uops_0_edge_inst,
  output [5:0]  io_iss_uops_0_pc_lob,
  output        io_iss_uops_0_taken,
  output [19:0] io_iss_uops_0_imm_packed,
  output [11:0] io_iss_uops_0_csr_addr,
  output [5:0]  io_iss_uops_0_rob_idx,
  output [3:0]  io_iss_uops_0_ldq_idx,
                io_iss_uops_0_stq_idx,
  output [1:0]  io_iss_uops_0_rxq_idx,
  output [6:0]  io_iss_uops_0_pdst,
                io_iss_uops_0_prs1,
                io_iss_uops_0_prs2,
                io_iss_uops_0_prs3,
  output [4:0]  io_iss_uops_0_ppred,
  output        io_iss_uops_0_prs1_busy,
                io_iss_uops_0_prs2_busy,
                io_iss_uops_0_prs3_busy,
                io_iss_uops_0_ppred_busy,
  output [6:0]  io_iss_uops_0_stale_pdst,
  output        io_iss_uops_0_exception,
  output [63:0] io_iss_uops_0_exc_cause,
  output        io_iss_uops_0_bypassable,
  output [4:0]  io_iss_uops_0_mem_cmd,
  output [1:0]  io_iss_uops_0_mem_size,
  output        io_iss_uops_0_mem_signed,
                io_iss_uops_0_is_fence,
                io_iss_uops_0_is_fencei,
                io_iss_uops_0_is_amo,
                io_iss_uops_0_uses_ldq,
                io_iss_uops_0_uses_stq,
                io_iss_uops_0_is_sys_pc2epc,
                io_iss_uops_0_is_unique,
                io_iss_uops_0_flush_on_commit,
                io_iss_uops_0_ldst_is_rs1,
  output [5:0]  io_iss_uops_0_ldst,
                io_iss_uops_0_lrs1,
                io_iss_uops_0_lrs2,
                io_iss_uops_0_lrs3,
  output        io_iss_uops_0_ldst_val,
  output [1:0]  io_iss_uops_0_dst_rtype,
                io_iss_uops_0_lrs1_rtype,
                io_iss_uops_0_lrs2_rtype,
  output        io_iss_uops_0_frs3_en,
                io_iss_uops_0_fp_val,
                io_iss_uops_0_fp_single,
                io_iss_uops_0_xcpt_pf_if,
                io_iss_uops_0_xcpt_ae_if,
                io_iss_uops_0_xcpt_ma_if,
                io_iss_uops_0_bp_debug_if,
                io_iss_uops_0_bp_xcpt_if,
  output [1:0]  io_iss_uops_0_debug_fsrc,
                io_iss_uops_0_debug_tsrc
);

  wire        issue_slots_15_grant;	// issue-unit-age-ordered.scala:118:56
  wire        issue_slots_14_grant;	// issue-unit-age-ordered.scala:118:56
  wire        issue_slots_13_grant;	// issue-unit-age-ordered.scala:118:56
  wire        issue_slots_12_grant;	// issue-unit-age-ordered.scala:118:56
  wire        issue_slots_11_grant;	// issue-unit-age-ordered.scala:118:56
  wire        issue_slots_10_grant;	// issue-unit-age-ordered.scala:118:56
  wire        issue_slots_9_grant;	// issue-unit-age-ordered.scala:118:56
  wire        issue_slots_8_grant;	// issue-unit-age-ordered.scala:118:56
  wire        issue_slots_7_grant;	// issue-unit-age-ordered.scala:118:56
  wire        issue_slots_6_grant;	// issue-unit-age-ordered.scala:118:56
  wire        issue_slots_5_grant;	// issue-unit-age-ordered.scala:118:56
  wire        issue_slots_4_grant;	// issue-unit-age-ordered.scala:118:56
  wire        issue_slots_3_grant;	// issue-unit-age-ordered.scala:118:56
  wire        issue_slots_2_grant;	// issue-unit-age-ordered.scala:118:56
  wire        issue_slots_1_grant;	// issue-unit-age-ordered.scala:118:56
  wire        issue_slots_0_grant;	// issue-unit-age-ordered.scala:118:40
  wire [1:0]  next_14;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44
  wire [1:0]  next_13;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44
  wire [1:0]  next_12;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44
  wire [1:0]  next_11;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44
  wire [1:0]  next_10;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44
  wire [1:0]  next_9;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44
  wire [1:0]  next_8;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44
  wire [1:0]  next_7;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44
  wire [1:0]  next_6;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44
  wire [1:0]  next_5;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44
  wire [1:0]  next_4;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44
  wire [1:0]  next_3;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44
  wire [1:0]  next_2;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44
  wire [1:0]  next_1;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44
  wire        _slots_15_io_valid;	// issue-unit.scala:153:73
  wire        _slots_15_io_will_be_valid;	// issue-unit.scala:153:73
  wire        _slots_15_io_request;	// issue-unit.scala:153:73
  wire [6:0]  _slots_15_io_out_uop_uopc;	// issue-unit.scala:153:73
  wire [31:0] _slots_15_io_out_uop_inst;	// issue-unit.scala:153:73
  wire [31:0] _slots_15_io_out_uop_debug_inst;	// issue-unit.scala:153:73
  wire        _slots_15_io_out_uop_is_rvc;	// issue-unit.scala:153:73
  wire [39:0] _slots_15_io_out_uop_debug_pc;	// issue-unit.scala:153:73
  wire [2:0]  _slots_15_io_out_uop_iq_type;	// issue-unit.scala:153:73
  wire [9:0]  _slots_15_io_out_uop_fu_code;	// issue-unit.scala:153:73
  wire [1:0]  _slots_15_io_out_uop_iw_state;	// issue-unit.scala:153:73
  wire        _slots_15_io_out_uop_is_br;	// issue-unit.scala:153:73
  wire        _slots_15_io_out_uop_is_jalr;	// issue-unit.scala:153:73
  wire        _slots_15_io_out_uop_is_jal;	// issue-unit.scala:153:73
  wire        _slots_15_io_out_uop_is_sfb;	// issue-unit.scala:153:73
  wire [11:0] _slots_15_io_out_uop_br_mask;	// issue-unit.scala:153:73
  wire [3:0]  _slots_15_io_out_uop_br_tag;	// issue-unit.scala:153:73
  wire [4:0]  _slots_15_io_out_uop_ftq_idx;	// issue-unit.scala:153:73
  wire        _slots_15_io_out_uop_edge_inst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_15_io_out_uop_pc_lob;	// issue-unit.scala:153:73
  wire        _slots_15_io_out_uop_taken;	// issue-unit.scala:153:73
  wire [19:0] _slots_15_io_out_uop_imm_packed;	// issue-unit.scala:153:73
  wire [11:0] _slots_15_io_out_uop_csr_addr;	// issue-unit.scala:153:73
  wire [5:0]  _slots_15_io_out_uop_rob_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_15_io_out_uop_ldq_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_15_io_out_uop_stq_idx;	// issue-unit.scala:153:73
  wire [1:0]  _slots_15_io_out_uop_rxq_idx;	// issue-unit.scala:153:73
  wire [6:0]  _slots_15_io_out_uop_pdst;	// issue-unit.scala:153:73
  wire [6:0]  _slots_15_io_out_uop_prs1;	// issue-unit.scala:153:73
  wire [6:0]  _slots_15_io_out_uop_prs2;	// issue-unit.scala:153:73
  wire [6:0]  _slots_15_io_out_uop_prs3;	// issue-unit.scala:153:73
  wire [4:0]  _slots_15_io_out_uop_ppred;	// issue-unit.scala:153:73
  wire        _slots_15_io_out_uop_prs1_busy;	// issue-unit.scala:153:73
  wire        _slots_15_io_out_uop_prs2_busy;	// issue-unit.scala:153:73
  wire        _slots_15_io_out_uop_prs3_busy;	// issue-unit.scala:153:73
  wire        _slots_15_io_out_uop_ppred_busy;	// issue-unit.scala:153:73
  wire [6:0]  _slots_15_io_out_uop_stale_pdst;	// issue-unit.scala:153:73
  wire        _slots_15_io_out_uop_exception;	// issue-unit.scala:153:73
  wire [63:0] _slots_15_io_out_uop_exc_cause;	// issue-unit.scala:153:73
  wire        _slots_15_io_out_uop_bypassable;	// issue-unit.scala:153:73
  wire [4:0]  _slots_15_io_out_uop_mem_cmd;	// issue-unit.scala:153:73
  wire [1:0]  _slots_15_io_out_uop_mem_size;	// issue-unit.scala:153:73
  wire        _slots_15_io_out_uop_mem_signed;	// issue-unit.scala:153:73
  wire        _slots_15_io_out_uop_is_fence;	// issue-unit.scala:153:73
  wire        _slots_15_io_out_uop_is_fencei;	// issue-unit.scala:153:73
  wire        _slots_15_io_out_uop_is_amo;	// issue-unit.scala:153:73
  wire        _slots_15_io_out_uop_uses_ldq;	// issue-unit.scala:153:73
  wire        _slots_15_io_out_uop_uses_stq;	// issue-unit.scala:153:73
  wire        _slots_15_io_out_uop_is_sys_pc2epc;	// issue-unit.scala:153:73
  wire        _slots_15_io_out_uop_is_unique;	// issue-unit.scala:153:73
  wire        _slots_15_io_out_uop_flush_on_commit;	// issue-unit.scala:153:73
  wire        _slots_15_io_out_uop_ldst_is_rs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_15_io_out_uop_ldst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_15_io_out_uop_lrs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_15_io_out_uop_lrs2;	// issue-unit.scala:153:73
  wire [5:0]  _slots_15_io_out_uop_lrs3;	// issue-unit.scala:153:73
  wire        _slots_15_io_out_uop_ldst_val;	// issue-unit.scala:153:73
  wire [1:0]  _slots_15_io_out_uop_dst_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_15_io_out_uop_lrs1_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_15_io_out_uop_lrs2_rtype;	// issue-unit.scala:153:73
  wire        _slots_15_io_out_uop_frs3_en;	// issue-unit.scala:153:73
  wire        _slots_15_io_out_uop_fp_val;	// issue-unit.scala:153:73
  wire        _slots_15_io_out_uop_fp_single;	// issue-unit.scala:153:73
  wire        _slots_15_io_out_uop_xcpt_pf_if;	// issue-unit.scala:153:73
  wire        _slots_15_io_out_uop_xcpt_ae_if;	// issue-unit.scala:153:73
  wire        _slots_15_io_out_uop_xcpt_ma_if;	// issue-unit.scala:153:73
  wire        _slots_15_io_out_uop_bp_debug_if;	// issue-unit.scala:153:73
  wire        _slots_15_io_out_uop_bp_xcpt_if;	// issue-unit.scala:153:73
  wire [1:0]  _slots_15_io_out_uop_debug_fsrc;	// issue-unit.scala:153:73
  wire [1:0]  _slots_15_io_out_uop_debug_tsrc;	// issue-unit.scala:153:73
  wire [6:0]  _slots_15_io_uop_uopc;	// issue-unit.scala:153:73
  wire [31:0] _slots_15_io_uop_inst;	// issue-unit.scala:153:73
  wire [31:0] _slots_15_io_uop_debug_inst;	// issue-unit.scala:153:73
  wire        _slots_15_io_uop_is_rvc;	// issue-unit.scala:153:73
  wire [39:0] _slots_15_io_uop_debug_pc;	// issue-unit.scala:153:73
  wire [2:0]  _slots_15_io_uop_iq_type;	// issue-unit.scala:153:73
  wire [9:0]  _slots_15_io_uop_fu_code;	// issue-unit.scala:153:73
  wire [1:0]  _slots_15_io_uop_iw_state;	// issue-unit.scala:153:73
  wire        _slots_15_io_uop_is_br;	// issue-unit.scala:153:73
  wire        _slots_15_io_uop_is_jalr;	// issue-unit.scala:153:73
  wire        _slots_15_io_uop_is_jal;	// issue-unit.scala:153:73
  wire        _slots_15_io_uop_is_sfb;	// issue-unit.scala:153:73
  wire [11:0] _slots_15_io_uop_br_mask;	// issue-unit.scala:153:73
  wire [3:0]  _slots_15_io_uop_br_tag;	// issue-unit.scala:153:73
  wire [4:0]  _slots_15_io_uop_ftq_idx;	// issue-unit.scala:153:73
  wire        _slots_15_io_uop_edge_inst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_15_io_uop_pc_lob;	// issue-unit.scala:153:73
  wire        _slots_15_io_uop_taken;	// issue-unit.scala:153:73
  wire [19:0] _slots_15_io_uop_imm_packed;	// issue-unit.scala:153:73
  wire [11:0] _slots_15_io_uop_csr_addr;	// issue-unit.scala:153:73
  wire [5:0]  _slots_15_io_uop_rob_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_15_io_uop_ldq_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_15_io_uop_stq_idx;	// issue-unit.scala:153:73
  wire [1:0]  _slots_15_io_uop_rxq_idx;	// issue-unit.scala:153:73
  wire [6:0]  _slots_15_io_uop_pdst;	// issue-unit.scala:153:73
  wire [6:0]  _slots_15_io_uop_prs1;	// issue-unit.scala:153:73
  wire [6:0]  _slots_15_io_uop_prs2;	// issue-unit.scala:153:73
  wire [6:0]  _slots_15_io_uop_prs3;	// issue-unit.scala:153:73
  wire [4:0]  _slots_15_io_uop_ppred;	// issue-unit.scala:153:73
  wire        _slots_15_io_uop_prs1_busy;	// issue-unit.scala:153:73
  wire        _slots_15_io_uop_prs2_busy;	// issue-unit.scala:153:73
  wire        _slots_15_io_uop_prs3_busy;	// issue-unit.scala:153:73
  wire        _slots_15_io_uop_ppred_busy;	// issue-unit.scala:153:73
  wire [6:0]  _slots_15_io_uop_stale_pdst;	// issue-unit.scala:153:73
  wire        _slots_15_io_uop_exception;	// issue-unit.scala:153:73
  wire [63:0] _slots_15_io_uop_exc_cause;	// issue-unit.scala:153:73
  wire        _slots_15_io_uop_bypassable;	// issue-unit.scala:153:73
  wire [4:0]  _slots_15_io_uop_mem_cmd;	// issue-unit.scala:153:73
  wire [1:0]  _slots_15_io_uop_mem_size;	// issue-unit.scala:153:73
  wire        _slots_15_io_uop_mem_signed;	// issue-unit.scala:153:73
  wire        _slots_15_io_uop_is_fence;	// issue-unit.scala:153:73
  wire        _slots_15_io_uop_is_fencei;	// issue-unit.scala:153:73
  wire        _slots_15_io_uop_is_amo;	// issue-unit.scala:153:73
  wire        _slots_15_io_uop_uses_ldq;	// issue-unit.scala:153:73
  wire        _slots_15_io_uop_uses_stq;	// issue-unit.scala:153:73
  wire        _slots_15_io_uop_is_sys_pc2epc;	// issue-unit.scala:153:73
  wire        _slots_15_io_uop_is_unique;	// issue-unit.scala:153:73
  wire        _slots_15_io_uop_flush_on_commit;	// issue-unit.scala:153:73
  wire        _slots_15_io_uop_ldst_is_rs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_15_io_uop_ldst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_15_io_uop_lrs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_15_io_uop_lrs2;	// issue-unit.scala:153:73
  wire [5:0]  _slots_15_io_uop_lrs3;	// issue-unit.scala:153:73
  wire        _slots_15_io_uop_ldst_val;	// issue-unit.scala:153:73
  wire [1:0]  _slots_15_io_uop_dst_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_15_io_uop_lrs1_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_15_io_uop_lrs2_rtype;	// issue-unit.scala:153:73
  wire        _slots_15_io_uop_frs3_en;	// issue-unit.scala:153:73
  wire        _slots_15_io_uop_fp_val;	// issue-unit.scala:153:73
  wire        _slots_15_io_uop_fp_single;	// issue-unit.scala:153:73
  wire        _slots_15_io_uop_xcpt_pf_if;	// issue-unit.scala:153:73
  wire        _slots_15_io_uop_xcpt_ae_if;	// issue-unit.scala:153:73
  wire        _slots_15_io_uop_xcpt_ma_if;	// issue-unit.scala:153:73
  wire        _slots_15_io_uop_bp_debug_if;	// issue-unit.scala:153:73
  wire        _slots_15_io_uop_bp_xcpt_if;	// issue-unit.scala:153:73
  wire [1:0]  _slots_15_io_uop_debug_fsrc;	// issue-unit.scala:153:73
  wire [1:0]  _slots_15_io_uop_debug_tsrc;	// issue-unit.scala:153:73
  wire        _slots_14_io_valid;	// issue-unit.scala:153:73
  wire        _slots_14_io_will_be_valid;	// issue-unit.scala:153:73
  wire        _slots_14_io_request;	// issue-unit.scala:153:73
  wire [6:0]  _slots_14_io_out_uop_uopc;	// issue-unit.scala:153:73
  wire [31:0] _slots_14_io_out_uop_inst;	// issue-unit.scala:153:73
  wire [31:0] _slots_14_io_out_uop_debug_inst;	// issue-unit.scala:153:73
  wire        _slots_14_io_out_uop_is_rvc;	// issue-unit.scala:153:73
  wire [39:0] _slots_14_io_out_uop_debug_pc;	// issue-unit.scala:153:73
  wire [2:0]  _slots_14_io_out_uop_iq_type;	// issue-unit.scala:153:73
  wire [9:0]  _slots_14_io_out_uop_fu_code;	// issue-unit.scala:153:73
  wire [1:0]  _slots_14_io_out_uop_iw_state;	// issue-unit.scala:153:73
  wire        _slots_14_io_out_uop_is_br;	// issue-unit.scala:153:73
  wire        _slots_14_io_out_uop_is_jalr;	// issue-unit.scala:153:73
  wire        _slots_14_io_out_uop_is_jal;	// issue-unit.scala:153:73
  wire        _slots_14_io_out_uop_is_sfb;	// issue-unit.scala:153:73
  wire [11:0] _slots_14_io_out_uop_br_mask;	// issue-unit.scala:153:73
  wire [3:0]  _slots_14_io_out_uop_br_tag;	// issue-unit.scala:153:73
  wire [4:0]  _slots_14_io_out_uop_ftq_idx;	// issue-unit.scala:153:73
  wire        _slots_14_io_out_uop_edge_inst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_14_io_out_uop_pc_lob;	// issue-unit.scala:153:73
  wire        _slots_14_io_out_uop_taken;	// issue-unit.scala:153:73
  wire [19:0] _slots_14_io_out_uop_imm_packed;	// issue-unit.scala:153:73
  wire [11:0] _slots_14_io_out_uop_csr_addr;	// issue-unit.scala:153:73
  wire [5:0]  _slots_14_io_out_uop_rob_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_14_io_out_uop_ldq_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_14_io_out_uop_stq_idx;	// issue-unit.scala:153:73
  wire [1:0]  _slots_14_io_out_uop_rxq_idx;	// issue-unit.scala:153:73
  wire [6:0]  _slots_14_io_out_uop_pdst;	// issue-unit.scala:153:73
  wire [6:0]  _slots_14_io_out_uop_prs1;	// issue-unit.scala:153:73
  wire [6:0]  _slots_14_io_out_uop_prs2;	// issue-unit.scala:153:73
  wire [6:0]  _slots_14_io_out_uop_prs3;	// issue-unit.scala:153:73
  wire [4:0]  _slots_14_io_out_uop_ppred;	// issue-unit.scala:153:73
  wire        _slots_14_io_out_uop_prs1_busy;	// issue-unit.scala:153:73
  wire        _slots_14_io_out_uop_prs2_busy;	// issue-unit.scala:153:73
  wire        _slots_14_io_out_uop_prs3_busy;	// issue-unit.scala:153:73
  wire        _slots_14_io_out_uop_ppred_busy;	// issue-unit.scala:153:73
  wire [6:0]  _slots_14_io_out_uop_stale_pdst;	// issue-unit.scala:153:73
  wire        _slots_14_io_out_uop_exception;	// issue-unit.scala:153:73
  wire [63:0] _slots_14_io_out_uop_exc_cause;	// issue-unit.scala:153:73
  wire        _slots_14_io_out_uop_bypassable;	// issue-unit.scala:153:73
  wire [4:0]  _slots_14_io_out_uop_mem_cmd;	// issue-unit.scala:153:73
  wire [1:0]  _slots_14_io_out_uop_mem_size;	// issue-unit.scala:153:73
  wire        _slots_14_io_out_uop_mem_signed;	// issue-unit.scala:153:73
  wire        _slots_14_io_out_uop_is_fence;	// issue-unit.scala:153:73
  wire        _slots_14_io_out_uop_is_fencei;	// issue-unit.scala:153:73
  wire        _slots_14_io_out_uop_is_amo;	// issue-unit.scala:153:73
  wire        _slots_14_io_out_uop_uses_ldq;	// issue-unit.scala:153:73
  wire        _slots_14_io_out_uop_uses_stq;	// issue-unit.scala:153:73
  wire        _slots_14_io_out_uop_is_sys_pc2epc;	// issue-unit.scala:153:73
  wire        _slots_14_io_out_uop_is_unique;	// issue-unit.scala:153:73
  wire        _slots_14_io_out_uop_flush_on_commit;	// issue-unit.scala:153:73
  wire        _slots_14_io_out_uop_ldst_is_rs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_14_io_out_uop_ldst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_14_io_out_uop_lrs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_14_io_out_uop_lrs2;	// issue-unit.scala:153:73
  wire [5:0]  _slots_14_io_out_uop_lrs3;	// issue-unit.scala:153:73
  wire        _slots_14_io_out_uop_ldst_val;	// issue-unit.scala:153:73
  wire [1:0]  _slots_14_io_out_uop_dst_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_14_io_out_uop_lrs1_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_14_io_out_uop_lrs2_rtype;	// issue-unit.scala:153:73
  wire        _slots_14_io_out_uop_frs3_en;	// issue-unit.scala:153:73
  wire        _slots_14_io_out_uop_fp_val;	// issue-unit.scala:153:73
  wire        _slots_14_io_out_uop_fp_single;	// issue-unit.scala:153:73
  wire        _slots_14_io_out_uop_xcpt_pf_if;	// issue-unit.scala:153:73
  wire        _slots_14_io_out_uop_xcpt_ae_if;	// issue-unit.scala:153:73
  wire        _slots_14_io_out_uop_xcpt_ma_if;	// issue-unit.scala:153:73
  wire        _slots_14_io_out_uop_bp_debug_if;	// issue-unit.scala:153:73
  wire        _slots_14_io_out_uop_bp_xcpt_if;	// issue-unit.scala:153:73
  wire [1:0]  _slots_14_io_out_uop_debug_fsrc;	// issue-unit.scala:153:73
  wire [1:0]  _slots_14_io_out_uop_debug_tsrc;	// issue-unit.scala:153:73
  wire [6:0]  _slots_14_io_uop_uopc;	// issue-unit.scala:153:73
  wire [31:0] _slots_14_io_uop_inst;	// issue-unit.scala:153:73
  wire [31:0] _slots_14_io_uop_debug_inst;	// issue-unit.scala:153:73
  wire        _slots_14_io_uop_is_rvc;	// issue-unit.scala:153:73
  wire [39:0] _slots_14_io_uop_debug_pc;	// issue-unit.scala:153:73
  wire [2:0]  _slots_14_io_uop_iq_type;	// issue-unit.scala:153:73
  wire [9:0]  _slots_14_io_uop_fu_code;	// issue-unit.scala:153:73
  wire [1:0]  _slots_14_io_uop_iw_state;	// issue-unit.scala:153:73
  wire        _slots_14_io_uop_is_br;	// issue-unit.scala:153:73
  wire        _slots_14_io_uop_is_jalr;	// issue-unit.scala:153:73
  wire        _slots_14_io_uop_is_jal;	// issue-unit.scala:153:73
  wire        _slots_14_io_uop_is_sfb;	// issue-unit.scala:153:73
  wire [11:0] _slots_14_io_uop_br_mask;	// issue-unit.scala:153:73
  wire [3:0]  _slots_14_io_uop_br_tag;	// issue-unit.scala:153:73
  wire [4:0]  _slots_14_io_uop_ftq_idx;	// issue-unit.scala:153:73
  wire        _slots_14_io_uop_edge_inst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_14_io_uop_pc_lob;	// issue-unit.scala:153:73
  wire        _slots_14_io_uop_taken;	// issue-unit.scala:153:73
  wire [19:0] _slots_14_io_uop_imm_packed;	// issue-unit.scala:153:73
  wire [11:0] _slots_14_io_uop_csr_addr;	// issue-unit.scala:153:73
  wire [5:0]  _slots_14_io_uop_rob_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_14_io_uop_ldq_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_14_io_uop_stq_idx;	// issue-unit.scala:153:73
  wire [1:0]  _slots_14_io_uop_rxq_idx;	// issue-unit.scala:153:73
  wire [6:0]  _slots_14_io_uop_pdst;	// issue-unit.scala:153:73
  wire [6:0]  _slots_14_io_uop_prs1;	// issue-unit.scala:153:73
  wire [6:0]  _slots_14_io_uop_prs2;	// issue-unit.scala:153:73
  wire [6:0]  _slots_14_io_uop_prs3;	// issue-unit.scala:153:73
  wire [4:0]  _slots_14_io_uop_ppred;	// issue-unit.scala:153:73
  wire        _slots_14_io_uop_prs1_busy;	// issue-unit.scala:153:73
  wire        _slots_14_io_uop_prs2_busy;	// issue-unit.scala:153:73
  wire        _slots_14_io_uop_prs3_busy;	// issue-unit.scala:153:73
  wire        _slots_14_io_uop_ppred_busy;	// issue-unit.scala:153:73
  wire [6:0]  _slots_14_io_uop_stale_pdst;	// issue-unit.scala:153:73
  wire        _slots_14_io_uop_exception;	// issue-unit.scala:153:73
  wire [63:0] _slots_14_io_uop_exc_cause;	// issue-unit.scala:153:73
  wire        _slots_14_io_uop_bypassable;	// issue-unit.scala:153:73
  wire [4:0]  _slots_14_io_uop_mem_cmd;	// issue-unit.scala:153:73
  wire [1:0]  _slots_14_io_uop_mem_size;	// issue-unit.scala:153:73
  wire        _slots_14_io_uop_mem_signed;	// issue-unit.scala:153:73
  wire        _slots_14_io_uop_is_fence;	// issue-unit.scala:153:73
  wire        _slots_14_io_uop_is_fencei;	// issue-unit.scala:153:73
  wire        _slots_14_io_uop_is_amo;	// issue-unit.scala:153:73
  wire        _slots_14_io_uop_uses_ldq;	// issue-unit.scala:153:73
  wire        _slots_14_io_uop_uses_stq;	// issue-unit.scala:153:73
  wire        _slots_14_io_uop_is_sys_pc2epc;	// issue-unit.scala:153:73
  wire        _slots_14_io_uop_is_unique;	// issue-unit.scala:153:73
  wire        _slots_14_io_uop_flush_on_commit;	// issue-unit.scala:153:73
  wire        _slots_14_io_uop_ldst_is_rs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_14_io_uop_ldst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_14_io_uop_lrs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_14_io_uop_lrs2;	// issue-unit.scala:153:73
  wire [5:0]  _slots_14_io_uop_lrs3;	// issue-unit.scala:153:73
  wire        _slots_14_io_uop_ldst_val;	// issue-unit.scala:153:73
  wire [1:0]  _slots_14_io_uop_dst_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_14_io_uop_lrs1_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_14_io_uop_lrs2_rtype;	// issue-unit.scala:153:73
  wire        _slots_14_io_uop_frs3_en;	// issue-unit.scala:153:73
  wire        _slots_14_io_uop_fp_val;	// issue-unit.scala:153:73
  wire        _slots_14_io_uop_fp_single;	// issue-unit.scala:153:73
  wire        _slots_14_io_uop_xcpt_pf_if;	// issue-unit.scala:153:73
  wire        _slots_14_io_uop_xcpt_ae_if;	// issue-unit.scala:153:73
  wire        _slots_14_io_uop_xcpt_ma_if;	// issue-unit.scala:153:73
  wire        _slots_14_io_uop_bp_debug_if;	// issue-unit.scala:153:73
  wire        _slots_14_io_uop_bp_xcpt_if;	// issue-unit.scala:153:73
  wire [1:0]  _slots_14_io_uop_debug_fsrc;	// issue-unit.scala:153:73
  wire [1:0]  _slots_14_io_uop_debug_tsrc;	// issue-unit.scala:153:73
  wire        _slots_13_io_valid;	// issue-unit.scala:153:73
  wire        _slots_13_io_will_be_valid;	// issue-unit.scala:153:73
  wire        _slots_13_io_request;	// issue-unit.scala:153:73
  wire [6:0]  _slots_13_io_out_uop_uopc;	// issue-unit.scala:153:73
  wire [31:0] _slots_13_io_out_uop_inst;	// issue-unit.scala:153:73
  wire [31:0] _slots_13_io_out_uop_debug_inst;	// issue-unit.scala:153:73
  wire        _slots_13_io_out_uop_is_rvc;	// issue-unit.scala:153:73
  wire [39:0] _slots_13_io_out_uop_debug_pc;	// issue-unit.scala:153:73
  wire [2:0]  _slots_13_io_out_uop_iq_type;	// issue-unit.scala:153:73
  wire [9:0]  _slots_13_io_out_uop_fu_code;	// issue-unit.scala:153:73
  wire [1:0]  _slots_13_io_out_uop_iw_state;	// issue-unit.scala:153:73
  wire        _slots_13_io_out_uop_is_br;	// issue-unit.scala:153:73
  wire        _slots_13_io_out_uop_is_jalr;	// issue-unit.scala:153:73
  wire        _slots_13_io_out_uop_is_jal;	// issue-unit.scala:153:73
  wire        _slots_13_io_out_uop_is_sfb;	// issue-unit.scala:153:73
  wire [11:0] _slots_13_io_out_uop_br_mask;	// issue-unit.scala:153:73
  wire [3:0]  _slots_13_io_out_uop_br_tag;	// issue-unit.scala:153:73
  wire [4:0]  _slots_13_io_out_uop_ftq_idx;	// issue-unit.scala:153:73
  wire        _slots_13_io_out_uop_edge_inst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_13_io_out_uop_pc_lob;	// issue-unit.scala:153:73
  wire        _slots_13_io_out_uop_taken;	// issue-unit.scala:153:73
  wire [19:0] _slots_13_io_out_uop_imm_packed;	// issue-unit.scala:153:73
  wire [11:0] _slots_13_io_out_uop_csr_addr;	// issue-unit.scala:153:73
  wire [5:0]  _slots_13_io_out_uop_rob_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_13_io_out_uop_ldq_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_13_io_out_uop_stq_idx;	// issue-unit.scala:153:73
  wire [1:0]  _slots_13_io_out_uop_rxq_idx;	// issue-unit.scala:153:73
  wire [6:0]  _slots_13_io_out_uop_pdst;	// issue-unit.scala:153:73
  wire [6:0]  _slots_13_io_out_uop_prs1;	// issue-unit.scala:153:73
  wire [6:0]  _slots_13_io_out_uop_prs2;	// issue-unit.scala:153:73
  wire [6:0]  _slots_13_io_out_uop_prs3;	// issue-unit.scala:153:73
  wire [4:0]  _slots_13_io_out_uop_ppred;	// issue-unit.scala:153:73
  wire        _slots_13_io_out_uop_prs1_busy;	// issue-unit.scala:153:73
  wire        _slots_13_io_out_uop_prs2_busy;	// issue-unit.scala:153:73
  wire        _slots_13_io_out_uop_prs3_busy;	// issue-unit.scala:153:73
  wire        _slots_13_io_out_uop_ppred_busy;	// issue-unit.scala:153:73
  wire [6:0]  _slots_13_io_out_uop_stale_pdst;	// issue-unit.scala:153:73
  wire        _slots_13_io_out_uop_exception;	// issue-unit.scala:153:73
  wire [63:0] _slots_13_io_out_uop_exc_cause;	// issue-unit.scala:153:73
  wire        _slots_13_io_out_uop_bypassable;	// issue-unit.scala:153:73
  wire [4:0]  _slots_13_io_out_uop_mem_cmd;	// issue-unit.scala:153:73
  wire [1:0]  _slots_13_io_out_uop_mem_size;	// issue-unit.scala:153:73
  wire        _slots_13_io_out_uop_mem_signed;	// issue-unit.scala:153:73
  wire        _slots_13_io_out_uop_is_fence;	// issue-unit.scala:153:73
  wire        _slots_13_io_out_uop_is_fencei;	// issue-unit.scala:153:73
  wire        _slots_13_io_out_uop_is_amo;	// issue-unit.scala:153:73
  wire        _slots_13_io_out_uop_uses_ldq;	// issue-unit.scala:153:73
  wire        _slots_13_io_out_uop_uses_stq;	// issue-unit.scala:153:73
  wire        _slots_13_io_out_uop_is_sys_pc2epc;	// issue-unit.scala:153:73
  wire        _slots_13_io_out_uop_is_unique;	// issue-unit.scala:153:73
  wire        _slots_13_io_out_uop_flush_on_commit;	// issue-unit.scala:153:73
  wire        _slots_13_io_out_uop_ldst_is_rs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_13_io_out_uop_ldst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_13_io_out_uop_lrs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_13_io_out_uop_lrs2;	// issue-unit.scala:153:73
  wire [5:0]  _slots_13_io_out_uop_lrs3;	// issue-unit.scala:153:73
  wire        _slots_13_io_out_uop_ldst_val;	// issue-unit.scala:153:73
  wire [1:0]  _slots_13_io_out_uop_dst_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_13_io_out_uop_lrs1_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_13_io_out_uop_lrs2_rtype;	// issue-unit.scala:153:73
  wire        _slots_13_io_out_uop_frs3_en;	// issue-unit.scala:153:73
  wire        _slots_13_io_out_uop_fp_val;	// issue-unit.scala:153:73
  wire        _slots_13_io_out_uop_fp_single;	// issue-unit.scala:153:73
  wire        _slots_13_io_out_uop_xcpt_pf_if;	// issue-unit.scala:153:73
  wire        _slots_13_io_out_uop_xcpt_ae_if;	// issue-unit.scala:153:73
  wire        _slots_13_io_out_uop_xcpt_ma_if;	// issue-unit.scala:153:73
  wire        _slots_13_io_out_uop_bp_debug_if;	// issue-unit.scala:153:73
  wire        _slots_13_io_out_uop_bp_xcpt_if;	// issue-unit.scala:153:73
  wire [1:0]  _slots_13_io_out_uop_debug_fsrc;	// issue-unit.scala:153:73
  wire [1:0]  _slots_13_io_out_uop_debug_tsrc;	// issue-unit.scala:153:73
  wire [6:0]  _slots_13_io_uop_uopc;	// issue-unit.scala:153:73
  wire [31:0] _slots_13_io_uop_inst;	// issue-unit.scala:153:73
  wire [31:0] _slots_13_io_uop_debug_inst;	// issue-unit.scala:153:73
  wire        _slots_13_io_uop_is_rvc;	// issue-unit.scala:153:73
  wire [39:0] _slots_13_io_uop_debug_pc;	// issue-unit.scala:153:73
  wire [2:0]  _slots_13_io_uop_iq_type;	// issue-unit.scala:153:73
  wire [9:0]  _slots_13_io_uop_fu_code;	// issue-unit.scala:153:73
  wire [1:0]  _slots_13_io_uop_iw_state;	// issue-unit.scala:153:73
  wire        _slots_13_io_uop_is_br;	// issue-unit.scala:153:73
  wire        _slots_13_io_uop_is_jalr;	// issue-unit.scala:153:73
  wire        _slots_13_io_uop_is_jal;	// issue-unit.scala:153:73
  wire        _slots_13_io_uop_is_sfb;	// issue-unit.scala:153:73
  wire [11:0] _slots_13_io_uop_br_mask;	// issue-unit.scala:153:73
  wire [3:0]  _slots_13_io_uop_br_tag;	// issue-unit.scala:153:73
  wire [4:0]  _slots_13_io_uop_ftq_idx;	// issue-unit.scala:153:73
  wire        _slots_13_io_uop_edge_inst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_13_io_uop_pc_lob;	// issue-unit.scala:153:73
  wire        _slots_13_io_uop_taken;	// issue-unit.scala:153:73
  wire [19:0] _slots_13_io_uop_imm_packed;	// issue-unit.scala:153:73
  wire [11:0] _slots_13_io_uop_csr_addr;	// issue-unit.scala:153:73
  wire [5:0]  _slots_13_io_uop_rob_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_13_io_uop_ldq_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_13_io_uop_stq_idx;	// issue-unit.scala:153:73
  wire [1:0]  _slots_13_io_uop_rxq_idx;	// issue-unit.scala:153:73
  wire [6:0]  _slots_13_io_uop_pdst;	// issue-unit.scala:153:73
  wire [6:0]  _slots_13_io_uop_prs1;	// issue-unit.scala:153:73
  wire [6:0]  _slots_13_io_uop_prs2;	// issue-unit.scala:153:73
  wire [6:0]  _slots_13_io_uop_prs3;	// issue-unit.scala:153:73
  wire [4:0]  _slots_13_io_uop_ppred;	// issue-unit.scala:153:73
  wire        _slots_13_io_uop_prs1_busy;	// issue-unit.scala:153:73
  wire        _slots_13_io_uop_prs2_busy;	// issue-unit.scala:153:73
  wire        _slots_13_io_uop_prs3_busy;	// issue-unit.scala:153:73
  wire        _slots_13_io_uop_ppred_busy;	// issue-unit.scala:153:73
  wire [6:0]  _slots_13_io_uop_stale_pdst;	// issue-unit.scala:153:73
  wire        _slots_13_io_uop_exception;	// issue-unit.scala:153:73
  wire [63:0] _slots_13_io_uop_exc_cause;	// issue-unit.scala:153:73
  wire        _slots_13_io_uop_bypassable;	// issue-unit.scala:153:73
  wire [4:0]  _slots_13_io_uop_mem_cmd;	// issue-unit.scala:153:73
  wire [1:0]  _slots_13_io_uop_mem_size;	// issue-unit.scala:153:73
  wire        _slots_13_io_uop_mem_signed;	// issue-unit.scala:153:73
  wire        _slots_13_io_uop_is_fence;	// issue-unit.scala:153:73
  wire        _slots_13_io_uop_is_fencei;	// issue-unit.scala:153:73
  wire        _slots_13_io_uop_is_amo;	// issue-unit.scala:153:73
  wire        _slots_13_io_uop_uses_ldq;	// issue-unit.scala:153:73
  wire        _slots_13_io_uop_uses_stq;	// issue-unit.scala:153:73
  wire        _slots_13_io_uop_is_sys_pc2epc;	// issue-unit.scala:153:73
  wire        _slots_13_io_uop_is_unique;	// issue-unit.scala:153:73
  wire        _slots_13_io_uop_flush_on_commit;	// issue-unit.scala:153:73
  wire        _slots_13_io_uop_ldst_is_rs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_13_io_uop_ldst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_13_io_uop_lrs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_13_io_uop_lrs2;	// issue-unit.scala:153:73
  wire [5:0]  _slots_13_io_uop_lrs3;	// issue-unit.scala:153:73
  wire        _slots_13_io_uop_ldst_val;	// issue-unit.scala:153:73
  wire [1:0]  _slots_13_io_uop_dst_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_13_io_uop_lrs1_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_13_io_uop_lrs2_rtype;	// issue-unit.scala:153:73
  wire        _slots_13_io_uop_frs3_en;	// issue-unit.scala:153:73
  wire        _slots_13_io_uop_fp_val;	// issue-unit.scala:153:73
  wire        _slots_13_io_uop_fp_single;	// issue-unit.scala:153:73
  wire        _slots_13_io_uop_xcpt_pf_if;	// issue-unit.scala:153:73
  wire        _slots_13_io_uop_xcpt_ae_if;	// issue-unit.scala:153:73
  wire        _slots_13_io_uop_xcpt_ma_if;	// issue-unit.scala:153:73
  wire        _slots_13_io_uop_bp_debug_if;	// issue-unit.scala:153:73
  wire        _slots_13_io_uop_bp_xcpt_if;	// issue-unit.scala:153:73
  wire [1:0]  _slots_13_io_uop_debug_fsrc;	// issue-unit.scala:153:73
  wire [1:0]  _slots_13_io_uop_debug_tsrc;	// issue-unit.scala:153:73
  wire        _slots_12_io_valid;	// issue-unit.scala:153:73
  wire        _slots_12_io_will_be_valid;	// issue-unit.scala:153:73
  wire        _slots_12_io_request;	// issue-unit.scala:153:73
  wire [6:0]  _slots_12_io_out_uop_uopc;	// issue-unit.scala:153:73
  wire [31:0] _slots_12_io_out_uop_inst;	// issue-unit.scala:153:73
  wire [31:0] _slots_12_io_out_uop_debug_inst;	// issue-unit.scala:153:73
  wire        _slots_12_io_out_uop_is_rvc;	// issue-unit.scala:153:73
  wire [39:0] _slots_12_io_out_uop_debug_pc;	// issue-unit.scala:153:73
  wire [2:0]  _slots_12_io_out_uop_iq_type;	// issue-unit.scala:153:73
  wire [9:0]  _slots_12_io_out_uop_fu_code;	// issue-unit.scala:153:73
  wire [1:0]  _slots_12_io_out_uop_iw_state;	// issue-unit.scala:153:73
  wire        _slots_12_io_out_uop_is_br;	// issue-unit.scala:153:73
  wire        _slots_12_io_out_uop_is_jalr;	// issue-unit.scala:153:73
  wire        _slots_12_io_out_uop_is_jal;	// issue-unit.scala:153:73
  wire        _slots_12_io_out_uop_is_sfb;	// issue-unit.scala:153:73
  wire [11:0] _slots_12_io_out_uop_br_mask;	// issue-unit.scala:153:73
  wire [3:0]  _slots_12_io_out_uop_br_tag;	// issue-unit.scala:153:73
  wire [4:0]  _slots_12_io_out_uop_ftq_idx;	// issue-unit.scala:153:73
  wire        _slots_12_io_out_uop_edge_inst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_12_io_out_uop_pc_lob;	// issue-unit.scala:153:73
  wire        _slots_12_io_out_uop_taken;	// issue-unit.scala:153:73
  wire [19:0] _slots_12_io_out_uop_imm_packed;	// issue-unit.scala:153:73
  wire [11:0] _slots_12_io_out_uop_csr_addr;	// issue-unit.scala:153:73
  wire [5:0]  _slots_12_io_out_uop_rob_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_12_io_out_uop_ldq_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_12_io_out_uop_stq_idx;	// issue-unit.scala:153:73
  wire [1:0]  _slots_12_io_out_uop_rxq_idx;	// issue-unit.scala:153:73
  wire [6:0]  _slots_12_io_out_uop_pdst;	// issue-unit.scala:153:73
  wire [6:0]  _slots_12_io_out_uop_prs1;	// issue-unit.scala:153:73
  wire [6:0]  _slots_12_io_out_uop_prs2;	// issue-unit.scala:153:73
  wire [6:0]  _slots_12_io_out_uop_prs3;	// issue-unit.scala:153:73
  wire [4:0]  _slots_12_io_out_uop_ppred;	// issue-unit.scala:153:73
  wire        _slots_12_io_out_uop_prs1_busy;	// issue-unit.scala:153:73
  wire        _slots_12_io_out_uop_prs2_busy;	// issue-unit.scala:153:73
  wire        _slots_12_io_out_uop_prs3_busy;	// issue-unit.scala:153:73
  wire        _slots_12_io_out_uop_ppred_busy;	// issue-unit.scala:153:73
  wire [6:0]  _slots_12_io_out_uop_stale_pdst;	// issue-unit.scala:153:73
  wire        _slots_12_io_out_uop_exception;	// issue-unit.scala:153:73
  wire [63:0] _slots_12_io_out_uop_exc_cause;	// issue-unit.scala:153:73
  wire        _slots_12_io_out_uop_bypassable;	// issue-unit.scala:153:73
  wire [4:0]  _slots_12_io_out_uop_mem_cmd;	// issue-unit.scala:153:73
  wire [1:0]  _slots_12_io_out_uop_mem_size;	// issue-unit.scala:153:73
  wire        _slots_12_io_out_uop_mem_signed;	// issue-unit.scala:153:73
  wire        _slots_12_io_out_uop_is_fence;	// issue-unit.scala:153:73
  wire        _slots_12_io_out_uop_is_fencei;	// issue-unit.scala:153:73
  wire        _slots_12_io_out_uop_is_amo;	// issue-unit.scala:153:73
  wire        _slots_12_io_out_uop_uses_ldq;	// issue-unit.scala:153:73
  wire        _slots_12_io_out_uop_uses_stq;	// issue-unit.scala:153:73
  wire        _slots_12_io_out_uop_is_sys_pc2epc;	// issue-unit.scala:153:73
  wire        _slots_12_io_out_uop_is_unique;	// issue-unit.scala:153:73
  wire        _slots_12_io_out_uop_flush_on_commit;	// issue-unit.scala:153:73
  wire        _slots_12_io_out_uop_ldst_is_rs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_12_io_out_uop_ldst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_12_io_out_uop_lrs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_12_io_out_uop_lrs2;	// issue-unit.scala:153:73
  wire [5:0]  _slots_12_io_out_uop_lrs3;	// issue-unit.scala:153:73
  wire        _slots_12_io_out_uop_ldst_val;	// issue-unit.scala:153:73
  wire [1:0]  _slots_12_io_out_uop_dst_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_12_io_out_uop_lrs1_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_12_io_out_uop_lrs2_rtype;	// issue-unit.scala:153:73
  wire        _slots_12_io_out_uop_frs3_en;	// issue-unit.scala:153:73
  wire        _slots_12_io_out_uop_fp_val;	// issue-unit.scala:153:73
  wire        _slots_12_io_out_uop_fp_single;	// issue-unit.scala:153:73
  wire        _slots_12_io_out_uop_xcpt_pf_if;	// issue-unit.scala:153:73
  wire        _slots_12_io_out_uop_xcpt_ae_if;	// issue-unit.scala:153:73
  wire        _slots_12_io_out_uop_xcpt_ma_if;	// issue-unit.scala:153:73
  wire        _slots_12_io_out_uop_bp_debug_if;	// issue-unit.scala:153:73
  wire        _slots_12_io_out_uop_bp_xcpt_if;	// issue-unit.scala:153:73
  wire [1:0]  _slots_12_io_out_uop_debug_fsrc;	// issue-unit.scala:153:73
  wire [1:0]  _slots_12_io_out_uop_debug_tsrc;	// issue-unit.scala:153:73
  wire [6:0]  _slots_12_io_uop_uopc;	// issue-unit.scala:153:73
  wire [31:0] _slots_12_io_uop_inst;	// issue-unit.scala:153:73
  wire [31:0] _slots_12_io_uop_debug_inst;	// issue-unit.scala:153:73
  wire        _slots_12_io_uop_is_rvc;	// issue-unit.scala:153:73
  wire [39:0] _slots_12_io_uop_debug_pc;	// issue-unit.scala:153:73
  wire [2:0]  _slots_12_io_uop_iq_type;	// issue-unit.scala:153:73
  wire [9:0]  _slots_12_io_uop_fu_code;	// issue-unit.scala:153:73
  wire [1:0]  _slots_12_io_uop_iw_state;	// issue-unit.scala:153:73
  wire        _slots_12_io_uop_is_br;	// issue-unit.scala:153:73
  wire        _slots_12_io_uop_is_jalr;	// issue-unit.scala:153:73
  wire        _slots_12_io_uop_is_jal;	// issue-unit.scala:153:73
  wire        _slots_12_io_uop_is_sfb;	// issue-unit.scala:153:73
  wire [11:0] _slots_12_io_uop_br_mask;	// issue-unit.scala:153:73
  wire [3:0]  _slots_12_io_uop_br_tag;	// issue-unit.scala:153:73
  wire [4:0]  _slots_12_io_uop_ftq_idx;	// issue-unit.scala:153:73
  wire        _slots_12_io_uop_edge_inst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_12_io_uop_pc_lob;	// issue-unit.scala:153:73
  wire        _slots_12_io_uop_taken;	// issue-unit.scala:153:73
  wire [19:0] _slots_12_io_uop_imm_packed;	// issue-unit.scala:153:73
  wire [11:0] _slots_12_io_uop_csr_addr;	// issue-unit.scala:153:73
  wire [5:0]  _slots_12_io_uop_rob_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_12_io_uop_ldq_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_12_io_uop_stq_idx;	// issue-unit.scala:153:73
  wire [1:0]  _slots_12_io_uop_rxq_idx;	// issue-unit.scala:153:73
  wire [6:0]  _slots_12_io_uop_pdst;	// issue-unit.scala:153:73
  wire [6:0]  _slots_12_io_uop_prs1;	// issue-unit.scala:153:73
  wire [6:0]  _slots_12_io_uop_prs2;	// issue-unit.scala:153:73
  wire [6:0]  _slots_12_io_uop_prs3;	// issue-unit.scala:153:73
  wire [4:0]  _slots_12_io_uop_ppred;	// issue-unit.scala:153:73
  wire        _slots_12_io_uop_prs1_busy;	// issue-unit.scala:153:73
  wire        _slots_12_io_uop_prs2_busy;	// issue-unit.scala:153:73
  wire        _slots_12_io_uop_prs3_busy;	// issue-unit.scala:153:73
  wire        _slots_12_io_uop_ppred_busy;	// issue-unit.scala:153:73
  wire [6:0]  _slots_12_io_uop_stale_pdst;	// issue-unit.scala:153:73
  wire        _slots_12_io_uop_exception;	// issue-unit.scala:153:73
  wire [63:0] _slots_12_io_uop_exc_cause;	// issue-unit.scala:153:73
  wire        _slots_12_io_uop_bypassable;	// issue-unit.scala:153:73
  wire [4:0]  _slots_12_io_uop_mem_cmd;	// issue-unit.scala:153:73
  wire [1:0]  _slots_12_io_uop_mem_size;	// issue-unit.scala:153:73
  wire        _slots_12_io_uop_mem_signed;	// issue-unit.scala:153:73
  wire        _slots_12_io_uop_is_fence;	// issue-unit.scala:153:73
  wire        _slots_12_io_uop_is_fencei;	// issue-unit.scala:153:73
  wire        _slots_12_io_uop_is_amo;	// issue-unit.scala:153:73
  wire        _slots_12_io_uop_uses_ldq;	// issue-unit.scala:153:73
  wire        _slots_12_io_uop_uses_stq;	// issue-unit.scala:153:73
  wire        _slots_12_io_uop_is_sys_pc2epc;	// issue-unit.scala:153:73
  wire        _slots_12_io_uop_is_unique;	// issue-unit.scala:153:73
  wire        _slots_12_io_uop_flush_on_commit;	// issue-unit.scala:153:73
  wire        _slots_12_io_uop_ldst_is_rs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_12_io_uop_ldst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_12_io_uop_lrs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_12_io_uop_lrs2;	// issue-unit.scala:153:73
  wire [5:0]  _slots_12_io_uop_lrs3;	// issue-unit.scala:153:73
  wire        _slots_12_io_uop_ldst_val;	// issue-unit.scala:153:73
  wire [1:0]  _slots_12_io_uop_dst_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_12_io_uop_lrs1_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_12_io_uop_lrs2_rtype;	// issue-unit.scala:153:73
  wire        _slots_12_io_uop_frs3_en;	// issue-unit.scala:153:73
  wire        _slots_12_io_uop_fp_val;	// issue-unit.scala:153:73
  wire        _slots_12_io_uop_fp_single;	// issue-unit.scala:153:73
  wire        _slots_12_io_uop_xcpt_pf_if;	// issue-unit.scala:153:73
  wire        _slots_12_io_uop_xcpt_ae_if;	// issue-unit.scala:153:73
  wire        _slots_12_io_uop_xcpt_ma_if;	// issue-unit.scala:153:73
  wire        _slots_12_io_uop_bp_debug_if;	// issue-unit.scala:153:73
  wire        _slots_12_io_uop_bp_xcpt_if;	// issue-unit.scala:153:73
  wire [1:0]  _slots_12_io_uop_debug_fsrc;	// issue-unit.scala:153:73
  wire [1:0]  _slots_12_io_uop_debug_tsrc;	// issue-unit.scala:153:73
  wire        _slots_11_io_valid;	// issue-unit.scala:153:73
  wire        _slots_11_io_will_be_valid;	// issue-unit.scala:153:73
  wire        _slots_11_io_request;	// issue-unit.scala:153:73
  wire [6:0]  _slots_11_io_out_uop_uopc;	// issue-unit.scala:153:73
  wire [31:0] _slots_11_io_out_uop_inst;	// issue-unit.scala:153:73
  wire [31:0] _slots_11_io_out_uop_debug_inst;	// issue-unit.scala:153:73
  wire        _slots_11_io_out_uop_is_rvc;	// issue-unit.scala:153:73
  wire [39:0] _slots_11_io_out_uop_debug_pc;	// issue-unit.scala:153:73
  wire [2:0]  _slots_11_io_out_uop_iq_type;	// issue-unit.scala:153:73
  wire [9:0]  _slots_11_io_out_uop_fu_code;	// issue-unit.scala:153:73
  wire [1:0]  _slots_11_io_out_uop_iw_state;	// issue-unit.scala:153:73
  wire        _slots_11_io_out_uop_is_br;	// issue-unit.scala:153:73
  wire        _slots_11_io_out_uop_is_jalr;	// issue-unit.scala:153:73
  wire        _slots_11_io_out_uop_is_jal;	// issue-unit.scala:153:73
  wire        _slots_11_io_out_uop_is_sfb;	// issue-unit.scala:153:73
  wire [11:0] _slots_11_io_out_uop_br_mask;	// issue-unit.scala:153:73
  wire [3:0]  _slots_11_io_out_uop_br_tag;	// issue-unit.scala:153:73
  wire [4:0]  _slots_11_io_out_uop_ftq_idx;	// issue-unit.scala:153:73
  wire        _slots_11_io_out_uop_edge_inst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_11_io_out_uop_pc_lob;	// issue-unit.scala:153:73
  wire        _slots_11_io_out_uop_taken;	// issue-unit.scala:153:73
  wire [19:0] _slots_11_io_out_uop_imm_packed;	// issue-unit.scala:153:73
  wire [11:0] _slots_11_io_out_uop_csr_addr;	// issue-unit.scala:153:73
  wire [5:0]  _slots_11_io_out_uop_rob_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_11_io_out_uop_ldq_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_11_io_out_uop_stq_idx;	// issue-unit.scala:153:73
  wire [1:0]  _slots_11_io_out_uop_rxq_idx;	// issue-unit.scala:153:73
  wire [6:0]  _slots_11_io_out_uop_pdst;	// issue-unit.scala:153:73
  wire [6:0]  _slots_11_io_out_uop_prs1;	// issue-unit.scala:153:73
  wire [6:0]  _slots_11_io_out_uop_prs2;	// issue-unit.scala:153:73
  wire [6:0]  _slots_11_io_out_uop_prs3;	// issue-unit.scala:153:73
  wire [4:0]  _slots_11_io_out_uop_ppred;	// issue-unit.scala:153:73
  wire        _slots_11_io_out_uop_prs1_busy;	// issue-unit.scala:153:73
  wire        _slots_11_io_out_uop_prs2_busy;	// issue-unit.scala:153:73
  wire        _slots_11_io_out_uop_prs3_busy;	// issue-unit.scala:153:73
  wire        _slots_11_io_out_uop_ppred_busy;	// issue-unit.scala:153:73
  wire [6:0]  _slots_11_io_out_uop_stale_pdst;	// issue-unit.scala:153:73
  wire        _slots_11_io_out_uop_exception;	// issue-unit.scala:153:73
  wire [63:0] _slots_11_io_out_uop_exc_cause;	// issue-unit.scala:153:73
  wire        _slots_11_io_out_uop_bypassable;	// issue-unit.scala:153:73
  wire [4:0]  _slots_11_io_out_uop_mem_cmd;	// issue-unit.scala:153:73
  wire [1:0]  _slots_11_io_out_uop_mem_size;	// issue-unit.scala:153:73
  wire        _slots_11_io_out_uop_mem_signed;	// issue-unit.scala:153:73
  wire        _slots_11_io_out_uop_is_fence;	// issue-unit.scala:153:73
  wire        _slots_11_io_out_uop_is_fencei;	// issue-unit.scala:153:73
  wire        _slots_11_io_out_uop_is_amo;	// issue-unit.scala:153:73
  wire        _slots_11_io_out_uop_uses_ldq;	// issue-unit.scala:153:73
  wire        _slots_11_io_out_uop_uses_stq;	// issue-unit.scala:153:73
  wire        _slots_11_io_out_uop_is_sys_pc2epc;	// issue-unit.scala:153:73
  wire        _slots_11_io_out_uop_is_unique;	// issue-unit.scala:153:73
  wire        _slots_11_io_out_uop_flush_on_commit;	// issue-unit.scala:153:73
  wire        _slots_11_io_out_uop_ldst_is_rs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_11_io_out_uop_ldst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_11_io_out_uop_lrs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_11_io_out_uop_lrs2;	// issue-unit.scala:153:73
  wire [5:0]  _slots_11_io_out_uop_lrs3;	// issue-unit.scala:153:73
  wire        _slots_11_io_out_uop_ldst_val;	// issue-unit.scala:153:73
  wire [1:0]  _slots_11_io_out_uop_dst_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_11_io_out_uop_lrs1_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_11_io_out_uop_lrs2_rtype;	// issue-unit.scala:153:73
  wire        _slots_11_io_out_uop_frs3_en;	// issue-unit.scala:153:73
  wire        _slots_11_io_out_uop_fp_val;	// issue-unit.scala:153:73
  wire        _slots_11_io_out_uop_fp_single;	// issue-unit.scala:153:73
  wire        _slots_11_io_out_uop_xcpt_pf_if;	// issue-unit.scala:153:73
  wire        _slots_11_io_out_uop_xcpt_ae_if;	// issue-unit.scala:153:73
  wire        _slots_11_io_out_uop_xcpt_ma_if;	// issue-unit.scala:153:73
  wire        _slots_11_io_out_uop_bp_debug_if;	// issue-unit.scala:153:73
  wire        _slots_11_io_out_uop_bp_xcpt_if;	// issue-unit.scala:153:73
  wire [1:0]  _slots_11_io_out_uop_debug_fsrc;	// issue-unit.scala:153:73
  wire [1:0]  _slots_11_io_out_uop_debug_tsrc;	// issue-unit.scala:153:73
  wire [6:0]  _slots_11_io_uop_uopc;	// issue-unit.scala:153:73
  wire [31:0] _slots_11_io_uop_inst;	// issue-unit.scala:153:73
  wire [31:0] _slots_11_io_uop_debug_inst;	// issue-unit.scala:153:73
  wire        _slots_11_io_uop_is_rvc;	// issue-unit.scala:153:73
  wire [39:0] _slots_11_io_uop_debug_pc;	// issue-unit.scala:153:73
  wire [2:0]  _slots_11_io_uop_iq_type;	// issue-unit.scala:153:73
  wire [9:0]  _slots_11_io_uop_fu_code;	// issue-unit.scala:153:73
  wire [1:0]  _slots_11_io_uop_iw_state;	// issue-unit.scala:153:73
  wire        _slots_11_io_uop_is_br;	// issue-unit.scala:153:73
  wire        _slots_11_io_uop_is_jalr;	// issue-unit.scala:153:73
  wire        _slots_11_io_uop_is_jal;	// issue-unit.scala:153:73
  wire        _slots_11_io_uop_is_sfb;	// issue-unit.scala:153:73
  wire [11:0] _slots_11_io_uop_br_mask;	// issue-unit.scala:153:73
  wire [3:0]  _slots_11_io_uop_br_tag;	// issue-unit.scala:153:73
  wire [4:0]  _slots_11_io_uop_ftq_idx;	// issue-unit.scala:153:73
  wire        _slots_11_io_uop_edge_inst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_11_io_uop_pc_lob;	// issue-unit.scala:153:73
  wire        _slots_11_io_uop_taken;	// issue-unit.scala:153:73
  wire [19:0] _slots_11_io_uop_imm_packed;	// issue-unit.scala:153:73
  wire [11:0] _slots_11_io_uop_csr_addr;	// issue-unit.scala:153:73
  wire [5:0]  _slots_11_io_uop_rob_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_11_io_uop_ldq_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_11_io_uop_stq_idx;	// issue-unit.scala:153:73
  wire [1:0]  _slots_11_io_uop_rxq_idx;	// issue-unit.scala:153:73
  wire [6:0]  _slots_11_io_uop_pdst;	// issue-unit.scala:153:73
  wire [6:0]  _slots_11_io_uop_prs1;	// issue-unit.scala:153:73
  wire [6:0]  _slots_11_io_uop_prs2;	// issue-unit.scala:153:73
  wire [6:0]  _slots_11_io_uop_prs3;	// issue-unit.scala:153:73
  wire [4:0]  _slots_11_io_uop_ppred;	// issue-unit.scala:153:73
  wire        _slots_11_io_uop_prs1_busy;	// issue-unit.scala:153:73
  wire        _slots_11_io_uop_prs2_busy;	// issue-unit.scala:153:73
  wire        _slots_11_io_uop_prs3_busy;	// issue-unit.scala:153:73
  wire        _slots_11_io_uop_ppred_busy;	// issue-unit.scala:153:73
  wire [6:0]  _slots_11_io_uop_stale_pdst;	// issue-unit.scala:153:73
  wire        _slots_11_io_uop_exception;	// issue-unit.scala:153:73
  wire [63:0] _slots_11_io_uop_exc_cause;	// issue-unit.scala:153:73
  wire        _slots_11_io_uop_bypassable;	// issue-unit.scala:153:73
  wire [4:0]  _slots_11_io_uop_mem_cmd;	// issue-unit.scala:153:73
  wire [1:0]  _slots_11_io_uop_mem_size;	// issue-unit.scala:153:73
  wire        _slots_11_io_uop_mem_signed;	// issue-unit.scala:153:73
  wire        _slots_11_io_uop_is_fence;	// issue-unit.scala:153:73
  wire        _slots_11_io_uop_is_fencei;	// issue-unit.scala:153:73
  wire        _slots_11_io_uop_is_amo;	// issue-unit.scala:153:73
  wire        _slots_11_io_uop_uses_ldq;	// issue-unit.scala:153:73
  wire        _slots_11_io_uop_uses_stq;	// issue-unit.scala:153:73
  wire        _slots_11_io_uop_is_sys_pc2epc;	// issue-unit.scala:153:73
  wire        _slots_11_io_uop_is_unique;	// issue-unit.scala:153:73
  wire        _slots_11_io_uop_flush_on_commit;	// issue-unit.scala:153:73
  wire        _slots_11_io_uop_ldst_is_rs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_11_io_uop_ldst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_11_io_uop_lrs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_11_io_uop_lrs2;	// issue-unit.scala:153:73
  wire [5:0]  _slots_11_io_uop_lrs3;	// issue-unit.scala:153:73
  wire        _slots_11_io_uop_ldst_val;	// issue-unit.scala:153:73
  wire [1:0]  _slots_11_io_uop_dst_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_11_io_uop_lrs1_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_11_io_uop_lrs2_rtype;	// issue-unit.scala:153:73
  wire        _slots_11_io_uop_frs3_en;	// issue-unit.scala:153:73
  wire        _slots_11_io_uop_fp_val;	// issue-unit.scala:153:73
  wire        _slots_11_io_uop_fp_single;	// issue-unit.scala:153:73
  wire        _slots_11_io_uop_xcpt_pf_if;	// issue-unit.scala:153:73
  wire        _slots_11_io_uop_xcpt_ae_if;	// issue-unit.scala:153:73
  wire        _slots_11_io_uop_xcpt_ma_if;	// issue-unit.scala:153:73
  wire        _slots_11_io_uop_bp_debug_if;	// issue-unit.scala:153:73
  wire        _slots_11_io_uop_bp_xcpt_if;	// issue-unit.scala:153:73
  wire [1:0]  _slots_11_io_uop_debug_fsrc;	// issue-unit.scala:153:73
  wire [1:0]  _slots_11_io_uop_debug_tsrc;	// issue-unit.scala:153:73
  wire        _slots_10_io_valid;	// issue-unit.scala:153:73
  wire        _slots_10_io_will_be_valid;	// issue-unit.scala:153:73
  wire        _slots_10_io_request;	// issue-unit.scala:153:73
  wire [6:0]  _slots_10_io_out_uop_uopc;	// issue-unit.scala:153:73
  wire [31:0] _slots_10_io_out_uop_inst;	// issue-unit.scala:153:73
  wire [31:0] _slots_10_io_out_uop_debug_inst;	// issue-unit.scala:153:73
  wire        _slots_10_io_out_uop_is_rvc;	// issue-unit.scala:153:73
  wire [39:0] _slots_10_io_out_uop_debug_pc;	// issue-unit.scala:153:73
  wire [2:0]  _slots_10_io_out_uop_iq_type;	// issue-unit.scala:153:73
  wire [9:0]  _slots_10_io_out_uop_fu_code;	// issue-unit.scala:153:73
  wire [1:0]  _slots_10_io_out_uop_iw_state;	// issue-unit.scala:153:73
  wire        _slots_10_io_out_uop_is_br;	// issue-unit.scala:153:73
  wire        _slots_10_io_out_uop_is_jalr;	// issue-unit.scala:153:73
  wire        _slots_10_io_out_uop_is_jal;	// issue-unit.scala:153:73
  wire        _slots_10_io_out_uop_is_sfb;	// issue-unit.scala:153:73
  wire [11:0] _slots_10_io_out_uop_br_mask;	// issue-unit.scala:153:73
  wire [3:0]  _slots_10_io_out_uop_br_tag;	// issue-unit.scala:153:73
  wire [4:0]  _slots_10_io_out_uop_ftq_idx;	// issue-unit.scala:153:73
  wire        _slots_10_io_out_uop_edge_inst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_10_io_out_uop_pc_lob;	// issue-unit.scala:153:73
  wire        _slots_10_io_out_uop_taken;	// issue-unit.scala:153:73
  wire [19:0] _slots_10_io_out_uop_imm_packed;	// issue-unit.scala:153:73
  wire [11:0] _slots_10_io_out_uop_csr_addr;	// issue-unit.scala:153:73
  wire [5:0]  _slots_10_io_out_uop_rob_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_10_io_out_uop_ldq_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_10_io_out_uop_stq_idx;	// issue-unit.scala:153:73
  wire [1:0]  _slots_10_io_out_uop_rxq_idx;	// issue-unit.scala:153:73
  wire [6:0]  _slots_10_io_out_uop_pdst;	// issue-unit.scala:153:73
  wire [6:0]  _slots_10_io_out_uop_prs1;	// issue-unit.scala:153:73
  wire [6:0]  _slots_10_io_out_uop_prs2;	// issue-unit.scala:153:73
  wire [6:0]  _slots_10_io_out_uop_prs3;	// issue-unit.scala:153:73
  wire [4:0]  _slots_10_io_out_uop_ppred;	// issue-unit.scala:153:73
  wire        _slots_10_io_out_uop_prs1_busy;	// issue-unit.scala:153:73
  wire        _slots_10_io_out_uop_prs2_busy;	// issue-unit.scala:153:73
  wire        _slots_10_io_out_uop_prs3_busy;	// issue-unit.scala:153:73
  wire        _slots_10_io_out_uop_ppred_busy;	// issue-unit.scala:153:73
  wire [6:0]  _slots_10_io_out_uop_stale_pdst;	// issue-unit.scala:153:73
  wire        _slots_10_io_out_uop_exception;	// issue-unit.scala:153:73
  wire [63:0] _slots_10_io_out_uop_exc_cause;	// issue-unit.scala:153:73
  wire        _slots_10_io_out_uop_bypassable;	// issue-unit.scala:153:73
  wire [4:0]  _slots_10_io_out_uop_mem_cmd;	// issue-unit.scala:153:73
  wire [1:0]  _slots_10_io_out_uop_mem_size;	// issue-unit.scala:153:73
  wire        _slots_10_io_out_uop_mem_signed;	// issue-unit.scala:153:73
  wire        _slots_10_io_out_uop_is_fence;	// issue-unit.scala:153:73
  wire        _slots_10_io_out_uop_is_fencei;	// issue-unit.scala:153:73
  wire        _slots_10_io_out_uop_is_amo;	// issue-unit.scala:153:73
  wire        _slots_10_io_out_uop_uses_ldq;	// issue-unit.scala:153:73
  wire        _slots_10_io_out_uop_uses_stq;	// issue-unit.scala:153:73
  wire        _slots_10_io_out_uop_is_sys_pc2epc;	// issue-unit.scala:153:73
  wire        _slots_10_io_out_uop_is_unique;	// issue-unit.scala:153:73
  wire        _slots_10_io_out_uop_flush_on_commit;	// issue-unit.scala:153:73
  wire        _slots_10_io_out_uop_ldst_is_rs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_10_io_out_uop_ldst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_10_io_out_uop_lrs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_10_io_out_uop_lrs2;	// issue-unit.scala:153:73
  wire [5:0]  _slots_10_io_out_uop_lrs3;	// issue-unit.scala:153:73
  wire        _slots_10_io_out_uop_ldst_val;	// issue-unit.scala:153:73
  wire [1:0]  _slots_10_io_out_uop_dst_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_10_io_out_uop_lrs1_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_10_io_out_uop_lrs2_rtype;	// issue-unit.scala:153:73
  wire        _slots_10_io_out_uop_frs3_en;	// issue-unit.scala:153:73
  wire        _slots_10_io_out_uop_fp_val;	// issue-unit.scala:153:73
  wire        _slots_10_io_out_uop_fp_single;	// issue-unit.scala:153:73
  wire        _slots_10_io_out_uop_xcpt_pf_if;	// issue-unit.scala:153:73
  wire        _slots_10_io_out_uop_xcpt_ae_if;	// issue-unit.scala:153:73
  wire        _slots_10_io_out_uop_xcpt_ma_if;	// issue-unit.scala:153:73
  wire        _slots_10_io_out_uop_bp_debug_if;	// issue-unit.scala:153:73
  wire        _slots_10_io_out_uop_bp_xcpt_if;	// issue-unit.scala:153:73
  wire [1:0]  _slots_10_io_out_uop_debug_fsrc;	// issue-unit.scala:153:73
  wire [1:0]  _slots_10_io_out_uop_debug_tsrc;	// issue-unit.scala:153:73
  wire [6:0]  _slots_10_io_uop_uopc;	// issue-unit.scala:153:73
  wire [31:0] _slots_10_io_uop_inst;	// issue-unit.scala:153:73
  wire [31:0] _slots_10_io_uop_debug_inst;	// issue-unit.scala:153:73
  wire        _slots_10_io_uop_is_rvc;	// issue-unit.scala:153:73
  wire [39:0] _slots_10_io_uop_debug_pc;	// issue-unit.scala:153:73
  wire [2:0]  _slots_10_io_uop_iq_type;	// issue-unit.scala:153:73
  wire [9:0]  _slots_10_io_uop_fu_code;	// issue-unit.scala:153:73
  wire [1:0]  _slots_10_io_uop_iw_state;	// issue-unit.scala:153:73
  wire        _slots_10_io_uop_is_br;	// issue-unit.scala:153:73
  wire        _slots_10_io_uop_is_jalr;	// issue-unit.scala:153:73
  wire        _slots_10_io_uop_is_jal;	// issue-unit.scala:153:73
  wire        _slots_10_io_uop_is_sfb;	// issue-unit.scala:153:73
  wire [11:0] _slots_10_io_uop_br_mask;	// issue-unit.scala:153:73
  wire [3:0]  _slots_10_io_uop_br_tag;	// issue-unit.scala:153:73
  wire [4:0]  _slots_10_io_uop_ftq_idx;	// issue-unit.scala:153:73
  wire        _slots_10_io_uop_edge_inst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_10_io_uop_pc_lob;	// issue-unit.scala:153:73
  wire        _slots_10_io_uop_taken;	// issue-unit.scala:153:73
  wire [19:0] _slots_10_io_uop_imm_packed;	// issue-unit.scala:153:73
  wire [11:0] _slots_10_io_uop_csr_addr;	// issue-unit.scala:153:73
  wire [5:0]  _slots_10_io_uop_rob_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_10_io_uop_ldq_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_10_io_uop_stq_idx;	// issue-unit.scala:153:73
  wire [1:0]  _slots_10_io_uop_rxq_idx;	// issue-unit.scala:153:73
  wire [6:0]  _slots_10_io_uop_pdst;	// issue-unit.scala:153:73
  wire [6:0]  _slots_10_io_uop_prs1;	// issue-unit.scala:153:73
  wire [6:0]  _slots_10_io_uop_prs2;	// issue-unit.scala:153:73
  wire [6:0]  _slots_10_io_uop_prs3;	// issue-unit.scala:153:73
  wire [4:0]  _slots_10_io_uop_ppred;	// issue-unit.scala:153:73
  wire        _slots_10_io_uop_prs1_busy;	// issue-unit.scala:153:73
  wire        _slots_10_io_uop_prs2_busy;	// issue-unit.scala:153:73
  wire        _slots_10_io_uop_prs3_busy;	// issue-unit.scala:153:73
  wire        _slots_10_io_uop_ppred_busy;	// issue-unit.scala:153:73
  wire [6:0]  _slots_10_io_uop_stale_pdst;	// issue-unit.scala:153:73
  wire        _slots_10_io_uop_exception;	// issue-unit.scala:153:73
  wire [63:0] _slots_10_io_uop_exc_cause;	// issue-unit.scala:153:73
  wire        _slots_10_io_uop_bypassable;	// issue-unit.scala:153:73
  wire [4:0]  _slots_10_io_uop_mem_cmd;	// issue-unit.scala:153:73
  wire [1:0]  _slots_10_io_uop_mem_size;	// issue-unit.scala:153:73
  wire        _slots_10_io_uop_mem_signed;	// issue-unit.scala:153:73
  wire        _slots_10_io_uop_is_fence;	// issue-unit.scala:153:73
  wire        _slots_10_io_uop_is_fencei;	// issue-unit.scala:153:73
  wire        _slots_10_io_uop_is_amo;	// issue-unit.scala:153:73
  wire        _slots_10_io_uop_uses_ldq;	// issue-unit.scala:153:73
  wire        _slots_10_io_uop_uses_stq;	// issue-unit.scala:153:73
  wire        _slots_10_io_uop_is_sys_pc2epc;	// issue-unit.scala:153:73
  wire        _slots_10_io_uop_is_unique;	// issue-unit.scala:153:73
  wire        _slots_10_io_uop_flush_on_commit;	// issue-unit.scala:153:73
  wire        _slots_10_io_uop_ldst_is_rs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_10_io_uop_ldst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_10_io_uop_lrs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_10_io_uop_lrs2;	// issue-unit.scala:153:73
  wire [5:0]  _slots_10_io_uop_lrs3;	// issue-unit.scala:153:73
  wire        _slots_10_io_uop_ldst_val;	// issue-unit.scala:153:73
  wire [1:0]  _slots_10_io_uop_dst_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_10_io_uop_lrs1_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_10_io_uop_lrs2_rtype;	// issue-unit.scala:153:73
  wire        _slots_10_io_uop_frs3_en;	// issue-unit.scala:153:73
  wire        _slots_10_io_uop_fp_val;	// issue-unit.scala:153:73
  wire        _slots_10_io_uop_fp_single;	// issue-unit.scala:153:73
  wire        _slots_10_io_uop_xcpt_pf_if;	// issue-unit.scala:153:73
  wire        _slots_10_io_uop_xcpt_ae_if;	// issue-unit.scala:153:73
  wire        _slots_10_io_uop_xcpt_ma_if;	// issue-unit.scala:153:73
  wire        _slots_10_io_uop_bp_debug_if;	// issue-unit.scala:153:73
  wire        _slots_10_io_uop_bp_xcpt_if;	// issue-unit.scala:153:73
  wire [1:0]  _slots_10_io_uop_debug_fsrc;	// issue-unit.scala:153:73
  wire [1:0]  _slots_10_io_uop_debug_tsrc;	// issue-unit.scala:153:73
  wire        _slots_9_io_valid;	// issue-unit.scala:153:73
  wire        _slots_9_io_will_be_valid;	// issue-unit.scala:153:73
  wire        _slots_9_io_request;	// issue-unit.scala:153:73
  wire [6:0]  _slots_9_io_out_uop_uopc;	// issue-unit.scala:153:73
  wire [31:0] _slots_9_io_out_uop_inst;	// issue-unit.scala:153:73
  wire [31:0] _slots_9_io_out_uop_debug_inst;	// issue-unit.scala:153:73
  wire        _slots_9_io_out_uop_is_rvc;	// issue-unit.scala:153:73
  wire [39:0] _slots_9_io_out_uop_debug_pc;	// issue-unit.scala:153:73
  wire [2:0]  _slots_9_io_out_uop_iq_type;	// issue-unit.scala:153:73
  wire [9:0]  _slots_9_io_out_uop_fu_code;	// issue-unit.scala:153:73
  wire [1:0]  _slots_9_io_out_uop_iw_state;	// issue-unit.scala:153:73
  wire        _slots_9_io_out_uop_is_br;	// issue-unit.scala:153:73
  wire        _slots_9_io_out_uop_is_jalr;	// issue-unit.scala:153:73
  wire        _slots_9_io_out_uop_is_jal;	// issue-unit.scala:153:73
  wire        _slots_9_io_out_uop_is_sfb;	// issue-unit.scala:153:73
  wire [11:0] _slots_9_io_out_uop_br_mask;	// issue-unit.scala:153:73
  wire [3:0]  _slots_9_io_out_uop_br_tag;	// issue-unit.scala:153:73
  wire [4:0]  _slots_9_io_out_uop_ftq_idx;	// issue-unit.scala:153:73
  wire        _slots_9_io_out_uop_edge_inst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_9_io_out_uop_pc_lob;	// issue-unit.scala:153:73
  wire        _slots_9_io_out_uop_taken;	// issue-unit.scala:153:73
  wire [19:0] _slots_9_io_out_uop_imm_packed;	// issue-unit.scala:153:73
  wire [11:0] _slots_9_io_out_uop_csr_addr;	// issue-unit.scala:153:73
  wire [5:0]  _slots_9_io_out_uop_rob_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_9_io_out_uop_ldq_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_9_io_out_uop_stq_idx;	// issue-unit.scala:153:73
  wire [1:0]  _slots_9_io_out_uop_rxq_idx;	// issue-unit.scala:153:73
  wire [6:0]  _slots_9_io_out_uop_pdst;	// issue-unit.scala:153:73
  wire [6:0]  _slots_9_io_out_uop_prs1;	// issue-unit.scala:153:73
  wire [6:0]  _slots_9_io_out_uop_prs2;	// issue-unit.scala:153:73
  wire [6:0]  _slots_9_io_out_uop_prs3;	// issue-unit.scala:153:73
  wire [4:0]  _slots_9_io_out_uop_ppred;	// issue-unit.scala:153:73
  wire        _slots_9_io_out_uop_prs1_busy;	// issue-unit.scala:153:73
  wire        _slots_9_io_out_uop_prs2_busy;	// issue-unit.scala:153:73
  wire        _slots_9_io_out_uop_prs3_busy;	// issue-unit.scala:153:73
  wire        _slots_9_io_out_uop_ppred_busy;	// issue-unit.scala:153:73
  wire [6:0]  _slots_9_io_out_uop_stale_pdst;	// issue-unit.scala:153:73
  wire        _slots_9_io_out_uop_exception;	// issue-unit.scala:153:73
  wire [63:0] _slots_9_io_out_uop_exc_cause;	// issue-unit.scala:153:73
  wire        _slots_9_io_out_uop_bypassable;	// issue-unit.scala:153:73
  wire [4:0]  _slots_9_io_out_uop_mem_cmd;	// issue-unit.scala:153:73
  wire [1:0]  _slots_9_io_out_uop_mem_size;	// issue-unit.scala:153:73
  wire        _slots_9_io_out_uop_mem_signed;	// issue-unit.scala:153:73
  wire        _slots_9_io_out_uop_is_fence;	// issue-unit.scala:153:73
  wire        _slots_9_io_out_uop_is_fencei;	// issue-unit.scala:153:73
  wire        _slots_9_io_out_uop_is_amo;	// issue-unit.scala:153:73
  wire        _slots_9_io_out_uop_uses_ldq;	// issue-unit.scala:153:73
  wire        _slots_9_io_out_uop_uses_stq;	// issue-unit.scala:153:73
  wire        _slots_9_io_out_uop_is_sys_pc2epc;	// issue-unit.scala:153:73
  wire        _slots_9_io_out_uop_is_unique;	// issue-unit.scala:153:73
  wire        _slots_9_io_out_uop_flush_on_commit;	// issue-unit.scala:153:73
  wire        _slots_9_io_out_uop_ldst_is_rs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_9_io_out_uop_ldst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_9_io_out_uop_lrs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_9_io_out_uop_lrs2;	// issue-unit.scala:153:73
  wire [5:0]  _slots_9_io_out_uop_lrs3;	// issue-unit.scala:153:73
  wire        _slots_9_io_out_uop_ldst_val;	// issue-unit.scala:153:73
  wire [1:0]  _slots_9_io_out_uop_dst_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_9_io_out_uop_lrs1_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_9_io_out_uop_lrs2_rtype;	// issue-unit.scala:153:73
  wire        _slots_9_io_out_uop_frs3_en;	// issue-unit.scala:153:73
  wire        _slots_9_io_out_uop_fp_val;	// issue-unit.scala:153:73
  wire        _slots_9_io_out_uop_fp_single;	// issue-unit.scala:153:73
  wire        _slots_9_io_out_uop_xcpt_pf_if;	// issue-unit.scala:153:73
  wire        _slots_9_io_out_uop_xcpt_ae_if;	// issue-unit.scala:153:73
  wire        _slots_9_io_out_uop_xcpt_ma_if;	// issue-unit.scala:153:73
  wire        _slots_9_io_out_uop_bp_debug_if;	// issue-unit.scala:153:73
  wire        _slots_9_io_out_uop_bp_xcpt_if;	// issue-unit.scala:153:73
  wire [1:0]  _slots_9_io_out_uop_debug_fsrc;	// issue-unit.scala:153:73
  wire [1:0]  _slots_9_io_out_uop_debug_tsrc;	// issue-unit.scala:153:73
  wire [6:0]  _slots_9_io_uop_uopc;	// issue-unit.scala:153:73
  wire [31:0] _slots_9_io_uop_inst;	// issue-unit.scala:153:73
  wire [31:0] _slots_9_io_uop_debug_inst;	// issue-unit.scala:153:73
  wire        _slots_9_io_uop_is_rvc;	// issue-unit.scala:153:73
  wire [39:0] _slots_9_io_uop_debug_pc;	// issue-unit.scala:153:73
  wire [2:0]  _slots_9_io_uop_iq_type;	// issue-unit.scala:153:73
  wire [9:0]  _slots_9_io_uop_fu_code;	// issue-unit.scala:153:73
  wire [1:0]  _slots_9_io_uop_iw_state;	// issue-unit.scala:153:73
  wire        _slots_9_io_uop_is_br;	// issue-unit.scala:153:73
  wire        _slots_9_io_uop_is_jalr;	// issue-unit.scala:153:73
  wire        _slots_9_io_uop_is_jal;	// issue-unit.scala:153:73
  wire        _slots_9_io_uop_is_sfb;	// issue-unit.scala:153:73
  wire [11:0] _slots_9_io_uop_br_mask;	// issue-unit.scala:153:73
  wire [3:0]  _slots_9_io_uop_br_tag;	// issue-unit.scala:153:73
  wire [4:0]  _slots_9_io_uop_ftq_idx;	// issue-unit.scala:153:73
  wire        _slots_9_io_uop_edge_inst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_9_io_uop_pc_lob;	// issue-unit.scala:153:73
  wire        _slots_9_io_uop_taken;	// issue-unit.scala:153:73
  wire [19:0] _slots_9_io_uop_imm_packed;	// issue-unit.scala:153:73
  wire [11:0] _slots_9_io_uop_csr_addr;	// issue-unit.scala:153:73
  wire [5:0]  _slots_9_io_uop_rob_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_9_io_uop_ldq_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_9_io_uop_stq_idx;	// issue-unit.scala:153:73
  wire [1:0]  _slots_9_io_uop_rxq_idx;	// issue-unit.scala:153:73
  wire [6:0]  _slots_9_io_uop_pdst;	// issue-unit.scala:153:73
  wire [6:0]  _slots_9_io_uop_prs1;	// issue-unit.scala:153:73
  wire [6:0]  _slots_9_io_uop_prs2;	// issue-unit.scala:153:73
  wire [6:0]  _slots_9_io_uop_prs3;	// issue-unit.scala:153:73
  wire [4:0]  _slots_9_io_uop_ppred;	// issue-unit.scala:153:73
  wire        _slots_9_io_uop_prs1_busy;	// issue-unit.scala:153:73
  wire        _slots_9_io_uop_prs2_busy;	// issue-unit.scala:153:73
  wire        _slots_9_io_uop_prs3_busy;	// issue-unit.scala:153:73
  wire        _slots_9_io_uop_ppred_busy;	// issue-unit.scala:153:73
  wire [6:0]  _slots_9_io_uop_stale_pdst;	// issue-unit.scala:153:73
  wire        _slots_9_io_uop_exception;	// issue-unit.scala:153:73
  wire [63:0] _slots_9_io_uop_exc_cause;	// issue-unit.scala:153:73
  wire        _slots_9_io_uop_bypassable;	// issue-unit.scala:153:73
  wire [4:0]  _slots_9_io_uop_mem_cmd;	// issue-unit.scala:153:73
  wire [1:0]  _slots_9_io_uop_mem_size;	// issue-unit.scala:153:73
  wire        _slots_9_io_uop_mem_signed;	// issue-unit.scala:153:73
  wire        _slots_9_io_uop_is_fence;	// issue-unit.scala:153:73
  wire        _slots_9_io_uop_is_fencei;	// issue-unit.scala:153:73
  wire        _slots_9_io_uop_is_amo;	// issue-unit.scala:153:73
  wire        _slots_9_io_uop_uses_ldq;	// issue-unit.scala:153:73
  wire        _slots_9_io_uop_uses_stq;	// issue-unit.scala:153:73
  wire        _slots_9_io_uop_is_sys_pc2epc;	// issue-unit.scala:153:73
  wire        _slots_9_io_uop_is_unique;	// issue-unit.scala:153:73
  wire        _slots_9_io_uop_flush_on_commit;	// issue-unit.scala:153:73
  wire        _slots_9_io_uop_ldst_is_rs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_9_io_uop_ldst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_9_io_uop_lrs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_9_io_uop_lrs2;	// issue-unit.scala:153:73
  wire [5:0]  _slots_9_io_uop_lrs3;	// issue-unit.scala:153:73
  wire        _slots_9_io_uop_ldst_val;	// issue-unit.scala:153:73
  wire [1:0]  _slots_9_io_uop_dst_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_9_io_uop_lrs1_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_9_io_uop_lrs2_rtype;	// issue-unit.scala:153:73
  wire        _slots_9_io_uop_frs3_en;	// issue-unit.scala:153:73
  wire        _slots_9_io_uop_fp_val;	// issue-unit.scala:153:73
  wire        _slots_9_io_uop_fp_single;	// issue-unit.scala:153:73
  wire        _slots_9_io_uop_xcpt_pf_if;	// issue-unit.scala:153:73
  wire        _slots_9_io_uop_xcpt_ae_if;	// issue-unit.scala:153:73
  wire        _slots_9_io_uop_xcpt_ma_if;	// issue-unit.scala:153:73
  wire        _slots_9_io_uop_bp_debug_if;	// issue-unit.scala:153:73
  wire        _slots_9_io_uop_bp_xcpt_if;	// issue-unit.scala:153:73
  wire [1:0]  _slots_9_io_uop_debug_fsrc;	// issue-unit.scala:153:73
  wire [1:0]  _slots_9_io_uop_debug_tsrc;	// issue-unit.scala:153:73
  wire        _slots_8_io_valid;	// issue-unit.scala:153:73
  wire        _slots_8_io_will_be_valid;	// issue-unit.scala:153:73
  wire        _slots_8_io_request;	// issue-unit.scala:153:73
  wire [6:0]  _slots_8_io_out_uop_uopc;	// issue-unit.scala:153:73
  wire [31:0] _slots_8_io_out_uop_inst;	// issue-unit.scala:153:73
  wire [31:0] _slots_8_io_out_uop_debug_inst;	// issue-unit.scala:153:73
  wire        _slots_8_io_out_uop_is_rvc;	// issue-unit.scala:153:73
  wire [39:0] _slots_8_io_out_uop_debug_pc;	// issue-unit.scala:153:73
  wire [2:0]  _slots_8_io_out_uop_iq_type;	// issue-unit.scala:153:73
  wire [9:0]  _slots_8_io_out_uop_fu_code;	// issue-unit.scala:153:73
  wire [1:0]  _slots_8_io_out_uop_iw_state;	// issue-unit.scala:153:73
  wire        _slots_8_io_out_uop_is_br;	// issue-unit.scala:153:73
  wire        _slots_8_io_out_uop_is_jalr;	// issue-unit.scala:153:73
  wire        _slots_8_io_out_uop_is_jal;	// issue-unit.scala:153:73
  wire        _slots_8_io_out_uop_is_sfb;	// issue-unit.scala:153:73
  wire [11:0] _slots_8_io_out_uop_br_mask;	// issue-unit.scala:153:73
  wire [3:0]  _slots_8_io_out_uop_br_tag;	// issue-unit.scala:153:73
  wire [4:0]  _slots_8_io_out_uop_ftq_idx;	// issue-unit.scala:153:73
  wire        _slots_8_io_out_uop_edge_inst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_8_io_out_uop_pc_lob;	// issue-unit.scala:153:73
  wire        _slots_8_io_out_uop_taken;	// issue-unit.scala:153:73
  wire [19:0] _slots_8_io_out_uop_imm_packed;	// issue-unit.scala:153:73
  wire [11:0] _slots_8_io_out_uop_csr_addr;	// issue-unit.scala:153:73
  wire [5:0]  _slots_8_io_out_uop_rob_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_8_io_out_uop_ldq_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_8_io_out_uop_stq_idx;	// issue-unit.scala:153:73
  wire [1:0]  _slots_8_io_out_uop_rxq_idx;	// issue-unit.scala:153:73
  wire [6:0]  _slots_8_io_out_uop_pdst;	// issue-unit.scala:153:73
  wire [6:0]  _slots_8_io_out_uop_prs1;	// issue-unit.scala:153:73
  wire [6:0]  _slots_8_io_out_uop_prs2;	// issue-unit.scala:153:73
  wire [6:0]  _slots_8_io_out_uop_prs3;	// issue-unit.scala:153:73
  wire [4:0]  _slots_8_io_out_uop_ppred;	// issue-unit.scala:153:73
  wire        _slots_8_io_out_uop_prs1_busy;	// issue-unit.scala:153:73
  wire        _slots_8_io_out_uop_prs2_busy;	// issue-unit.scala:153:73
  wire        _slots_8_io_out_uop_prs3_busy;	// issue-unit.scala:153:73
  wire        _slots_8_io_out_uop_ppred_busy;	// issue-unit.scala:153:73
  wire [6:0]  _slots_8_io_out_uop_stale_pdst;	// issue-unit.scala:153:73
  wire        _slots_8_io_out_uop_exception;	// issue-unit.scala:153:73
  wire [63:0] _slots_8_io_out_uop_exc_cause;	// issue-unit.scala:153:73
  wire        _slots_8_io_out_uop_bypassable;	// issue-unit.scala:153:73
  wire [4:0]  _slots_8_io_out_uop_mem_cmd;	// issue-unit.scala:153:73
  wire [1:0]  _slots_8_io_out_uop_mem_size;	// issue-unit.scala:153:73
  wire        _slots_8_io_out_uop_mem_signed;	// issue-unit.scala:153:73
  wire        _slots_8_io_out_uop_is_fence;	// issue-unit.scala:153:73
  wire        _slots_8_io_out_uop_is_fencei;	// issue-unit.scala:153:73
  wire        _slots_8_io_out_uop_is_amo;	// issue-unit.scala:153:73
  wire        _slots_8_io_out_uop_uses_ldq;	// issue-unit.scala:153:73
  wire        _slots_8_io_out_uop_uses_stq;	// issue-unit.scala:153:73
  wire        _slots_8_io_out_uop_is_sys_pc2epc;	// issue-unit.scala:153:73
  wire        _slots_8_io_out_uop_is_unique;	// issue-unit.scala:153:73
  wire        _slots_8_io_out_uop_flush_on_commit;	// issue-unit.scala:153:73
  wire        _slots_8_io_out_uop_ldst_is_rs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_8_io_out_uop_ldst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_8_io_out_uop_lrs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_8_io_out_uop_lrs2;	// issue-unit.scala:153:73
  wire [5:0]  _slots_8_io_out_uop_lrs3;	// issue-unit.scala:153:73
  wire        _slots_8_io_out_uop_ldst_val;	// issue-unit.scala:153:73
  wire [1:0]  _slots_8_io_out_uop_dst_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_8_io_out_uop_lrs1_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_8_io_out_uop_lrs2_rtype;	// issue-unit.scala:153:73
  wire        _slots_8_io_out_uop_frs3_en;	// issue-unit.scala:153:73
  wire        _slots_8_io_out_uop_fp_val;	// issue-unit.scala:153:73
  wire        _slots_8_io_out_uop_fp_single;	// issue-unit.scala:153:73
  wire        _slots_8_io_out_uop_xcpt_pf_if;	// issue-unit.scala:153:73
  wire        _slots_8_io_out_uop_xcpt_ae_if;	// issue-unit.scala:153:73
  wire        _slots_8_io_out_uop_xcpt_ma_if;	// issue-unit.scala:153:73
  wire        _slots_8_io_out_uop_bp_debug_if;	// issue-unit.scala:153:73
  wire        _slots_8_io_out_uop_bp_xcpt_if;	// issue-unit.scala:153:73
  wire [1:0]  _slots_8_io_out_uop_debug_fsrc;	// issue-unit.scala:153:73
  wire [1:0]  _slots_8_io_out_uop_debug_tsrc;	// issue-unit.scala:153:73
  wire [6:0]  _slots_8_io_uop_uopc;	// issue-unit.scala:153:73
  wire [31:0] _slots_8_io_uop_inst;	// issue-unit.scala:153:73
  wire [31:0] _slots_8_io_uop_debug_inst;	// issue-unit.scala:153:73
  wire        _slots_8_io_uop_is_rvc;	// issue-unit.scala:153:73
  wire [39:0] _slots_8_io_uop_debug_pc;	// issue-unit.scala:153:73
  wire [2:0]  _slots_8_io_uop_iq_type;	// issue-unit.scala:153:73
  wire [9:0]  _slots_8_io_uop_fu_code;	// issue-unit.scala:153:73
  wire [1:0]  _slots_8_io_uop_iw_state;	// issue-unit.scala:153:73
  wire        _slots_8_io_uop_is_br;	// issue-unit.scala:153:73
  wire        _slots_8_io_uop_is_jalr;	// issue-unit.scala:153:73
  wire        _slots_8_io_uop_is_jal;	// issue-unit.scala:153:73
  wire        _slots_8_io_uop_is_sfb;	// issue-unit.scala:153:73
  wire [11:0] _slots_8_io_uop_br_mask;	// issue-unit.scala:153:73
  wire [3:0]  _slots_8_io_uop_br_tag;	// issue-unit.scala:153:73
  wire [4:0]  _slots_8_io_uop_ftq_idx;	// issue-unit.scala:153:73
  wire        _slots_8_io_uop_edge_inst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_8_io_uop_pc_lob;	// issue-unit.scala:153:73
  wire        _slots_8_io_uop_taken;	// issue-unit.scala:153:73
  wire [19:0] _slots_8_io_uop_imm_packed;	// issue-unit.scala:153:73
  wire [11:0] _slots_8_io_uop_csr_addr;	// issue-unit.scala:153:73
  wire [5:0]  _slots_8_io_uop_rob_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_8_io_uop_ldq_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_8_io_uop_stq_idx;	// issue-unit.scala:153:73
  wire [1:0]  _slots_8_io_uop_rxq_idx;	// issue-unit.scala:153:73
  wire [6:0]  _slots_8_io_uop_pdst;	// issue-unit.scala:153:73
  wire [6:0]  _slots_8_io_uop_prs1;	// issue-unit.scala:153:73
  wire [6:0]  _slots_8_io_uop_prs2;	// issue-unit.scala:153:73
  wire [6:0]  _slots_8_io_uop_prs3;	// issue-unit.scala:153:73
  wire [4:0]  _slots_8_io_uop_ppred;	// issue-unit.scala:153:73
  wire        _slots_8_io_uop_prs1_busy;	// issue-unit.scala:153:73
  wire        _slots_8_io_uop_prs2_busy;	// issue-unit.scala:153:73
  wire        _slots_8_io_uop_prs3_busy;	// issue-unit.scala:153:73
  wire        _slots_8_io_uop_ppred_busy;	// issue-unit.scala:153:73
  wire [6:0]  _slots_8_io_uop_stale_pdst;	// issue-unit.scala:153:73
  wire        _slots_8_io_uop_exception;	// issue-unit.scala:153:73
  wire [63:0] _slots_8_io_uop_exc_cause;	// issue-unit.scala:153:73
  wire        _slots_8_io_uop_bypassable;	// issue-unit.scala:153:73
  wire [4:0]  _slots_8_io_uop_mem_cmd;	// issue-unit.scala:153:73
  wire [1:0]  _slots_8_io_uop_mem_size;	// issue-unit.scala:153:73
  wire        _slots_8_io_uop_mem_signed;	// issue-unit.scala:153:73
  wire        _slots_8_io_uop_is_fence;	// issue-unit.scala:153:73
  wire        _slots_8_io_uop_is_fencei;	// issue-unit.scala:153:73
  wire        _slots_8_io_uop_is_amo;	// issue-unit.scala:153:73
  wire        _slots_8_io_uop_uses_ldq;	// issue-unit.scala:153:73
  wire        _slots_8_io_uop_uses_stq;	// issue-unit.scala:153:73
  wire        _slots_8_io_uop_is_sys_pc2epc;	// issue-unit.scala:153:73
  wire        _slots_8_io_uop_is_unique;	// issue-unit.scala:153:73
  wire        _slots_8_io_uop_flush_on_commit;	// issue-unit.scala:153:73
  wire        _slots_8_io_uop_ldst_is_rs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_8_io_uop_ldst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_8_io_uop_lrs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_8_io_uop_lrs2;	// issue-unit.scala:153:73
  wire [5:0]  _slots_8_io_uop_lrs3;	// issue-unit.scala:153:73
  wire        _slots_8_io_uop_ldst_val;	// issue-unit.scala:153:73
  wire [1:0]  _slots_8_io_uop_dst_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_8_io_uop_lrs1_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_8_io_uop_lrs2_rtype;	// issue-unit.scala:153:73
  wire        _slots_8_io_uop_frs3_en;	// issue-unit.scala:153:73
  wire        _slots_8_io_uop_fp_val;	// issue-unit.scala:153:73
  wire        _slots_8_io_uop_fp_single;	// issue-unit.scala:153:73
  wire        _slots_8_io_uop_xcpt_pf_if;	// issue-unit.scala:153:73
  wire        _slots_8_io_uop_xcpt_ae_if;	// issue-unit.scala:153:73
  wire        _slots_8_io_uop_xcpt_ma_if;	// issue-unit.scala:153:73
  wire        _slots_8_io_uop_bp_debug_if;	// issue-unit.scala:153:73
  wire        _slots_8_io_uop_bp_xcpt_if;	// issue-unit.scala:153:73
  wire [1:0]  _slots_8_io_uop_debug_fsrc;	// issue-unit.scala:153:73
  wire [1:0]  _slots_8_io_uop_debug_tsrc;	// issue-unit.scala:153:73
  wire        _slots_7_io_valid;	// issue-unit.scala:153:73
  wire        _slots_7_io_will_be_valid;	// issue-unit.scala:153:73
  wire        _slots_7_io_request;	// issue-unit.scala:153:73
  wire [6:0]  _slots_7_io_out_uop_uopc;	// issue-unit.scala:153:73
  wire [31:0] _slots_7_io_out_uop_inst;	// issue-unit.scala:153:73
  wire [31:0] _slots_7_io_out_uop_debug_inst;	// issue-unit.scala:153:73
  wire        _slots_7_io_out_uop_is_rvc;	// issue-unit.scala:153:73
  wire [39:0] _slots_7_io_out_uop_debug_pc;	// issue-unit.scala:153:73
  wire [2:0]  _slots_7_io_out_uop_iq_type;	// issue-unit.scala:153:73
  wire [9:0]  _slots_7_io_out_uop_fu_code;	// issue-unit.scala:153:73
  wire [1:0]  _slots_7_io_out_uop_iw_state;	// issue-unit.scala:153:73
  wire        _slots_7_io_out_uop_is_br;	// issue-unit.scala:153:73
  wire        _slots_7_io_out_uop_is_jalr;	// issue-unit.scala:153:73
  wire        _slots_7_io_out_uop_is_jal;	// issue-unit.scala:153:73
  wire        _slots_7_io_out_uop_is_sfb;	// issue-unit.scala:153:73
  wire [11:0] _slots_7_io_out_uop_br_mask;	// issue-unit.scala:153:73
  wire [3:0]  _slots_7_io_out_uop_br_tag;	// issue-unit.scala:153:73
  wire [4:0]  _slots_7_io_out_uop_ftq_idx;	// issue-unit.scala:153:73
  wire        _slots_7_io_out_uop_edge_inst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_7_io_out_uop_pc_lob;	// issue-unit.scala:153:73
  wire        _slots_7_io_out_uop_taken;	// issue-unit.scala:153:73
  wire [19:0] _slots_7_io_out_uop_imm_packed;	// issue-unit.scala:153:73
  wire [11:0] _slots_7_io_out_uop_csr_addr;	// issue-unit.scala:153:73
  wire [5:0]  _slots_7_io_out_uop_rob_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_7_io_out_uop_ldq_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_7_io_out_uop_stq_idx;	// issue-unit.scala:153:73
  wire [1:0]  _slots_7_io_out_uop_rxq_idx;	// issue-unit.scala:153:73
  wire [6:0]  _slots_7_io_out_uop_pdst;	// issue-unit.scala:153:73
  wire [6:0]  _slots_7_io_out_uop_prs1;	// issue-unit.scala:153:73
  wire [6:0]  _slots_7_io_out_uop_prs2;	// issue-unit.scala:153:73
  wire [6:0]  _slots_7_io_out_uop_prs3;	// issue-unit.scala:153:73
  wire [4:0]  _slots_7_io_out_uop_ppred;	// issue-unit.scala:153:73
  wire        _slots_7_io_out_uop_prs1_busy;	// issue-unit.scala:153:73
  wire        _slots_7_io_out_uop_prs2_busy;	// issue-unit.scala:153:73
  wire        _slots_7_io_out_uop_prs3_busy;	// issue-unit.scala:153:73
  wire        _slots_7_io_out_uop_ppred_busy;	// issue-unit.scala:153:73
  wire [6:0]  _slots_7_io_out_uop_stale_pdst;	// issue-unit.scala:153:73
  wire        _slots_7_io_out_uop_exception;	// issue-unit.scala:153:73
  wire [63:0] _slots_7_io_out_uop_exc_cause;	// issue-unit.scala:153:73
  wire        _slots_7_io_out_uop_bypassable;	// issue-unit.scala:153:73
  wire [4:0]  _slots_7_io_out_uop_mem_cmd;	// issue-unit.scala:153:73
  wire [1:0]  _slots_7_io_out_uop_mem_size;	// issue-unit.scala:153:73
  wire        _slots_7_io_out_uop_mem_signed;	// issue-unit.scala:153:73
  wire        _slots_7_io_out_uop_is_fence;	// issue-unit.scala:153:73
  wire        _slots_7_io_out_uop_is_fencei;	// issue-unit.scala:153:73
  wire        _slots_7_io_out_uop_is_amo;	// issue-unit.scala:153:73
  wire        _slots_7_io_out_uop_uses_ldq;	// issue-unit.scala:153:73
  wire        _slots_7_io_out_uop_uses_stq;	// issue-unit.scala:153:73
  wire        _slots_7_io_out_uop_is_sys_pc2epc;	// issue-unit.scala:153:73
  wire        _slots_7_io_out_uop_is_unique;	// issue-unit.scala:153:73
  wire        _slots_7_io_out_uop_flush_on_commit;	// issue-unit.scala:153:73
  wire        _slots_7_io_out_uop_ldst_is_rs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_7_io_out_uop_ldst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_7_io_out_uop_lrs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_7_io_out_uop_lrs2;	// issue-unit.scala:153:73
  wire [5:0]  _slots_7_io_out_uop_lrs3;	// issue-unit.scala:153:73
  wire        _slots_7_io_out_uop_ldst_val;	// issue-unit.scala:153:73
  wire [1:0]  _slots_7_io_out_uop_dst_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_7_io_out_uop_lrs1_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_7_io_out_uop_lrs2_rtype;	// issue-unit.scala:153:73
  wire        _slots_7_io_out_uop_frs3_en;	// issue-unit.scala:153:73
  wire        _slots_7_io_out_uop_fp_val;	// issue-unit.scala:153:73
  wire        _slots_7_io_out_uop_fp_single;	// issue-unit.scala:153:73
  wire        _slots_7_io_out_uop_xcpt_pf_if;	// issue-unit.scala:153:73
  wire        _slots_7_io_out_uop_xcpt_ae_if;	// issue-unit.scala:153:73
  wire        _slots_7_io_out_uop_xcpt_ma_if;	// issue-unit.scala:153:73
  wire        _slots_7_io_out_uop_bp_debug_if;	// issue-unit.scala:153:73
  wire        _slots_7_io_out_uop_bp_xcpt_if;	// issue-unit.scala:153:73
  wire [1:0]  _slots_7_io_out_uop_debug_fsrc;	// issue-unit.scala:153:73
  wire [1:0]  _slots_7_io_out_uop_debug_tsrc;	// issue-unit.scala:153:73
  wire [6:0]  _slots_7_io_uop_uopc;	// issue-unit.scala:153:73
  wire [31:0] _slots_7_io_uop_inst;	// issue-unit.scala:153:73
  wire [31:0] _slots_7_io_uop_debug_inst;	// issue-unit.scala:153:73
  wire        _slots_7_io_uop_is_rvc;	// issue-unit.scala:153:73
  wire [39:0] _slots_7_io_uop_debug_pc;	// issue-unit.scala:153:73
  wire [2:0]  _slots_7_io_uop_iq_type;	// issue-unit.scala:153:73
  wire [9:0]  _slots_7_io_uop_fu_code;	// issue-unit.scala:153:73
  wire [1:0]  _slots_7_io_uop_iw_state;	// issue-unit.scala:153:73
  wire        _slots_7_io_uop_is_br;	// issue-unit.scala:153:73
  wire        _slots_7_io_uop_is_jalr;	// issue-unit.scala:153:73
  wire        _slots_7_io_uop_is_jal;	// issue-unit.scala:153:73
  wire        _slots_7_io_uop_is_sfb;	// issue-unit.scala:153:73
  wire [11:0] _slots_7_io_uop_br_mask;	// issue-unit.scala:153:73
  wire [3:0]  _slots_7_io_uop_br_tag;	// issue-unit.scala:153:73
  wire [4:0]  _slots_7_io_uop_ftq_idx;	// issue-unit.scala:153:73
  wire        _slots_7_io_uop_edge_inst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_7_io_uop_pc_lob;	// issue-unit.scala:153:73
  wire        _slots_7_io_uop_taken;	// issue-unit.scala:153:73
  wire [19:0] _slots_7_io_uop_imm_packed;	// issue-unit.scala:153:73
  wire [11:0] _slots_7_io_uop_csr_addr;	// issue-unit.scala:153:73
  wire [5:0]  _slots_7_io_uop_rob_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_7_io_uop_ldq_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_7_io_uop_stq_idx;	// issue-unit.scala:153:73
  wire [1:0]  _slots_7_io_uop_rxq_idx;	// issue-unit.scala:153:73
  wire [6:0]  _slots_7_io_uop_pdst;	// issue-unit.scala:153:73
  wire [6:0]  _slots_7_io_uop_prs1;	// issue-unit.scala:153:73
  wire [6:0]  _slots_7_io_uop_prs2;	// issue-unit.scala:153:73
  wire [6:0]  _slots_7_io_uop_prs3;	// issue-unit.scala:153:73
  wire [4:0]  _slots_7_io_uop_ppred;	// issue-unit.scala:153:73
  wire        _slots_7_io_uop_prs1_busy;	// issue-unit.scala:153:73
  wire        _slots_7_io_uop_prs2_busy;	// issue-unit.scala:153:73
  wire        _slots_7_io_uop_prs3_busy;	// issue-unit.scala:153:73
  wire        _slots_7_io_uop_ppred_busy;	// issue-unit.scala:153:73
  wire [6:0]  _slots_7_io_uop_stale_pdst;	// issue-unit.scala:153:73
  wire        _slots_7_io_uop_exception;	// issue-unit.scala:153:73
  wire [63:0] _slots_7_io_uop_exc_cause;	// issue-unit.scala:153:73
  wire        _slots_7_io_uop_bypassable;	// issue-unit.scala:153:73
  wire [4:0]  _slots_7_io_uop_mem_cmd;	// issue-unit.scala:153:73
  wire [1:0]  _slots_7_io_uop_mem_size;	// issue-unit.scala:153:73
  wire        _slots_7_io_uop_mem_signed;	// issue-unit.scala:153:73
  wire        _slots_7_io_uop_is_fence;	// issue-unit.scala:153:73
  wire        _slots_7_io_uop_is_fencei;	// issue-unit.scala:153:73
  wire        _slots_7_io_uop_is_amo;	// issue-unit.scala:153:73
  wire        _slots_7_io_uop_uses_ldq;	// issue-unit.scala:153:73
  wire        _slots_7_io_uop_uses_stq;	// issue-unit.scala:153:73
  wire        _slots_7_io_uop_is_sys_pc2epc;	// issue-unit.scala:153:73
  wire        _slots_7_io_uop_is_unique;	// issue-unit.scala:153:73
  wire        _slots_7_io_uop_flush_on_commit;	// issue-unit.scala:153:73
  wire        _slots_7_io_uop_ldst_is_rs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_7_io_uop_ldst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_7_io_uop_lrs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_7_io_uop_lrs2;	// issue-unit.scala:153:73
  wire [5:0]  _slots_7_io_uop_lrs3;	// issue-unit.scala:153:73
  wire        _slots_7_io_uop_ldst_val;	// issue-unit.scala:153:73
  wire [1:0]  _slots_7_io_uop_dst_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_7_io_uop_lrs1_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_7_io_uop_lrs2_rtype;	// issue-unit.scala:153:73
  wire        _slots_7_io_uop_frs3_en;	// issue-unit.scala:153:73
  wire        _slots_7_io_uop_fp_val;	// issue-unit.scala:153:73
  wire        _slots_7_io_uop_fp_single;	// issue-unit.scala:153:73
  wire        _slots_7_io_uop_xcpt_pf_if;	// issue-unit.scala:153:73
  wire        _slots_7_io_uop_xcpt_ae_if;	// issue-unit.scala:153:73
  wire        _slots_7_io_uop_xcpt_ma_if;	// issue-unit.scala:153:73
  wire        _slots_7_io_uop_bp_debug_if;	// issue-unit.scala:153:73
  wire        _slots_7_io_uop_bp_xcpt_if;	// issue-unit.scala:153:73
  wire [1:0]  _slots_7_io_uop_debug_fsrc;	// issue-unit.scala:153:73
  wire [1:0]  _slots_7_io_uop_debug_tsrc;	// issue-unit.scala:153:73
  wire        _slots_6_io_valid;	// issue-unit.scala:153:73
  wire        _slots_6_io_will_be_valid;	// issue-unit.scala:153:73
  wire        _slots_6_io_request;	// issue-unit.scala:153:73
  wire [6:0]  _slots_6_io_out_uop_uopc;	// issue-unit.scala:153:73
  wire [31:0] _slots_6_io_out_uop_inst;	// issue-unit.scala:153:73
  wire [31:0] _slots_6_io_out_uop_debug_inst;	// issue-unit.scala:153:73
  wire        _slots_6_io_out_uop_is_rvc;	// issue-unit.scala:153:73
  wire [39:0] _slots_6_io_out_uop_debug_pc;	// issue-unit.scala:153:73
  wire [2:0]  _slots_6_io_out_uop_iq_type;	// issue-unit.scala:153:73
  wire [9:0]  _slots_6_io_out_uop_fu_code;	// issue-unit.scala:153:73
  wire [1:0]  _slots_6_io_out_uop_iw_state;	// issue-unit.scala:153:73
  wire        _slots_6_io_out_uop_is_br;	// issue-unit.scala:153:73
  wire        _slots_6_io_out_uop_is_jalr;	// issue-unit.scala:153:73
  wire        _slots_6_io_out_uop_is_jal;	// issue-unit.scala:153:73
  wire        _slots_6_io_out_uop_is_sfb;	// issue-unit.scala:153:73
  wire [11:0] _slots_6_io_out_uop_br_mask;	// issue-unit.scala:153:73
  wire [3:0]  _slots_6_io_out_uop_br_tag;	// issue-unit.scala:153:73
  wire [4:0]  _slots_6_io_out_uop_ftq_idx;	// issue-unit.scala:153:73
  wire        _slots_6_io_out_uop_edge_inst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_6_io_out_uop_pc_lob;	// issue-unit.scala:153:73
  wire        _slots_6_io_out_uop_taken;	// issue-unit.scala:153:73
  wire [19:0] _slots_6_io_out_uop_imm_packed;	// issue-unit.scala:153:73
  wire [11:0] _slots_6_io_out_uop_csr_addr;	// issue-unit.scala:153:73
  wire [5:0]  _slots_6_io_out_uop_rob_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_6_io_out_uop_ldq_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_6_io_out_uop_stq_idx;	// issue-unit.scala:153:73
  wire [1:0]  _slots_6_io_out_uop_rxq_idx;	// issue-unit.scala:153:73
  wire [6:0]  _slots_6_io_out_uop_pdst;	// issue-unit.scala:153:73
  wire [6:0]  _slots_6_io_out_uop_prs1;	// issue-unit.scala:153:73
  wire [6:0]  _slots_6_io_out_uop_prs2;	// issue-unit.scala:153:73
  wire [6:0]  _slots_6_io_out_uop_prs3;	// issue-unit.scala:153:73
  wire [4:0]  _slots_6_io_out_uop_ppred;	// issue-unit.scala:153:73
  wire        _slots_6_io_out_uop_prs1_busy;	// issue-unit.scala:153:73
  wire        _slots_6_io_out_uop_prs2_busy;	// issue-unit.scala:153:73
  wire        _slots_6_io_out_uop_prs3_busy;	// issue-unit.scala:153:73
  wire        _slots_6_io_out_uop_ppred_busy;	// issue-unit.scala:153:73
  wire [6:0]  _slots_6_io_out_uop_stale_pdst;	// issue-unit.scala:153:73
  wire        _slots_6_io_out_uop_exception;	// issue-unit.scala:153:73
  wire [63:0] _slots_6_io_out_uop_exc_cause;	// issue-unit.scala:153:73
  wire        _slots_6_io_out_uop_bypassable;	// issue-unit.scala:153:73
  wire [4:0]  _slots_6_io_out_uop_mem_cmd;	// issue-unit.scala:153:73
  wire [1:0]  _slots_6_io_out_uop_mem_size;	// issue-unit.scala:153:73
  wire        _slots_6_io_out_uop_mem_signed;	// issue-unit.scala:153:73
  wire        _slots_6_io_out_uop_is_fence;	// issue-unit.scala:153:73
  wire        _slots_6_io_out_uop_is_fencei;	// issue-unit.scala:153:73
  wire        _slots_6_io_out_uop_is_amo;	// issue-unit.scala:153:73
  wire        _slots_6_io_out_uop_uses_ldq;	// issue-unit.scala:153:73
  wire        _slots_6_io_out_uop_uses_stq;	// issue-unit.scala:153:73
  wire        _slots_6_io_out_uop_is_sys_pc2epc;	// issue-unit.scala:153:73
  wire        _slots_6_io_out_uop_is_unique;	// issue-unit.scala:153:73
  wire        _slots_6_io_out_uop_flush_on_commit;	// issue-unit.scala:153:73
  wire        _slots_6_io_out_uop_ldst_is_rs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_6_io_out_uop_ldst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_6_io_out_uop_lrs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_6_io_out_uop_lrs2;	// issue-unit.scala:153:73
  wire [5:0]  _slots_6_io_out_uop_lrs3;	// issue-unit.scala:153:73
  wire        _slots_6_io_out_uop_ldst_val;	// issue-unit.scala:153:73
  wire [1:0]  _slots_6_io_out_uop_dst_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_6_io_out_uop_lrs1_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_6_io_out_uop_lrs2_rtype;	// issue-unit.scala:153:73
  wire        _slots_6_io_out_uop_frs3_en;	// issue-unit.scala:153:73
  wire        _slots_6_io_out_uop_fp_val;	// issue-unit.scala:153:73
  wire        _slots_6_io_out_uop_fp_single;	// issue-unit.scala:153:73
  wire        _slots_6_io_out_uop_xcpt_pf_if;	// issue-unit.scala:153:73
  wire        _slots_6_io_out_uop_xcpt_ae_if;	// issue-unit.scala:153:73
  wire        _slots_6_io_out_uop_xcpt_ma_if;	// issue-unit.scala:153:73
  wire        _slots_6_io_out_uop_bp_debug_if;	// issue-unit.scala:153:73
  wire        _slots_6_io_out_uop_bp_xcpt_if;	// issue-unit.scala:153:73
  wire [1:0]  _slots_6_io_out_uop_debug_fsrc;	// issue-unit.scala:153:73
  wire [1:0]  _slots_6_io_out_uop_debug_tsrc;	// issue-unit.scala:153:73
  wire [6:0]  _slots_6_io_uop_uopc;	// issue-unit.scala:153:73
  wire [31:0] _slots_6_io_uop_inst;	// issue-unit.scala:153:73
  wire [31:0] _slots_6_io_uop_debug_inst;	// issue-unit.scala:153:73
  wire        _slots_6_io_uop_is_rvc;	// issue-unit.scala:153:73
  wire [39:0] _slots_6_io_uop_debug_pc;	// issue-unit.scala:153:73
  wire [2:0]  _slots_6_io_uop_iq_type;	// issue-unit.scala:153:73
  wire [9:0]  _slots_6_io_uop_fu_code;	// issue-unit.scala:153:73
  wire [1:0]  _slots_6_io_uop_iw_state;	// issue-unit.scala:153:73
  wire        _slots_6_io_uop_is_br;	// issue-unit.scala:153:73
  wire        _slots_6_io_uop_is_jalr;	// issue-unit.scala:153:73
  wire        _slots_6_io_uop_is_jal;	// issue-unit.scala:153:73
  wire        _slots_6_io_uop_is_sfb;	// issue-unit.scala:153:73
  wire [11:0] _slots_6_io_uop_br_mask;	// issue-unit.scala:153:73
  wire [3:0]  _slots_6_io_uop_br_tag;	// issue-unit.scala:153:73
  wire [4:0]  _slots_6_io_uop_ftq_idx;	// issue-unit.scala:153:73
  wire        _slots_6_io_uop_edge_inst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_6_io_uop_pc_lob;	// issue-unit.scala:153:73
  wire        _slots_6_io_uop_taken;	// issue-unit.scala:153:73
  wire [19:0] _slots_6_io_uop_imm_packed;	// issue-unit.scala:153:73
  wire [11:0] _slots_6_io_uop_csr_addr;	// issue-unit.scala:153:73
  wire [5:0]  _slots_6_io_uop_rob_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_6_io_uop_ldq_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_6_io_uop_stq_idx;	// issue-unit.scala:153:73
  wire [1:0]  _slots_6_io_uop_rxq_idx;	// issue-unit.scala:153:73
  wire [6:0]  _slots_6_io_uop_pdst;	// issue-unit.scala:153:73
  wire [6:0]  _slots_6_io_uop_prs1;	// issue-unit.scala:153:73
  wire [6:0]  _slots_6_io_uop_prs2;	// issue-unit.scala:153:73
  wire [6:0]  _slots_6_io_uop_prs3;	// issue-unit.scala:153:73
  wire [4:0]  _slots_6_io_uop_ppred;	// issue-unit.scala:153:73
  wire        _slots_6_io_uop_prs1_busy;	// issue-unit.scala:153:73
  wire        _slots_6_io_uop_prs2_busy;	// issue-unit.scala:153:73
  wire        _slots_6_io_uop_prs3_busy;	// issue-unit.scala:153:73
  wire        _slots_6_io_uop_ppred_busy;	// issue-unit.scala:153:73
  wire [6:0]  _slots_6_io_uop_stale_pdst;	// issue-unit.scala:153:73
  wire        _slots_6_io_uop_exception;	// issue-unit.scala:153:73
  wire [63:0] _slots_6_io_uop_exc_cause;	// issue-unit.scala:153:73
  wire        _slots_6_io_uop_bypassable;	// issue-unit.scala:153:73
  wire [4:0]  _slots_6_io_uop_mem_cmd;	// issue-unit.scala:153:73
  wire [1:0]  _slots_6_io_uop_mem_size;	// issue-unit.scala:153:73
  wire        _slots_6_io_uop_mem_signed;	// issue-unit.scala:153:73
  wire        _slots_6_io_uop_is_fence;	// issue-unit.scala:153:73
  wire        _slots_6_io_uop_is_fencei;	// issue-unit.scala:153:73
  wire        _slots_6_io_uop_is_amo;	// issue-unit.scala:153:73
  wire        _slots_6_io_uop_uses_ldq;	// issue-unit.scala:153:73
  wire        _slots_6_io_uop_uses_stq;	// issue-unit.scala:153:73
  wire        _slots_6_io_uop_is_sys_pc2epc;	// issue-unit.scala:153:73
  wire        _slots_6_io_uop_is_unique;	// issue-unit.scala:153:73
  wire        _slots_6_io_uop_flush_on_commit;	// issue-unit.scala:153:73
  wire        _slots_6_io_uop_ldst_is_rs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_6_io_uop_ldst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_6_io_uop_lrs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_6_io_uop_lrs2;	// issue-unit.scala:153:73
  wire [5:0]  _slots_6_io_uop_lrs3;	// issue-unit.scala:153:73
  wire        _slots_6_io_uop_ldst_val;	// issue-unit.scala:153:73
  wire [1:0]  _slots_6_io_uop_dst_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_6_io_uop_lrs1_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_6_io_uop_lrs2_rtype;	// issue-unit.scala:153:73
  wire        _slots_6_io_uop_frs3_en;	// issue-unit.scala:153:73
  wire        _slots_6_io_uop_fp_val;	// issue-unit.scala:153:73
  wire        _slots_6_io_uop_fp_single;	// issue-unit.scala:153:73
  wire        _slots_6_io_uop_xcpt_pf_if;	// issue-unit.scala:153:73
  wire        _slots_6_io_uop_xcpt_ae_if;	// issue-unit.scala:153:73
  wire        _slots_6_io_uop_xcpt_ma_if;	// issue-unit.scala:153:73
  wire        _slots_6_io_uop_bp_debug_if;	// issue-unit.scala:153:73
  wire        _slots_6_io_uop_bp_xcpt_if;	// issue-unit.scala:153:73
  wire [1:0]  _slots_6_io_uop_debug_fsrc;	// issue-unit.scala:153:73
  wire [1:0]  _slots_6_io_uop_debug_tsrc;	// issue-unit.scala:153:73
  wire        _slots_5_io_valid;	// issue-unit.scala:153:73
  wire        _slots_5_io_will_be_valid;	// issue-unit.scala:153:73
  wire        _slots_5_io_request;	// issue-unit.scala:153:73
  wire [6:0]  _slots_5_io_out_uop_uopc;	// issue-unit.scala:153:73
  wire [31:0] _slots_5_io_out_uop_inst;	// issue-unit.scala:153:73
  wire [31:0] _slots_5_io_out_uop_debug_inst;	// issue-unit.scala:153:73
  wire        _slots_5_io_out_uop_is_rvc;	// issue-unit.scala:153:73
  wire [39:0] _slots_5_io_out_uop_debug_pc;	// issue-unit.scala:153:73
  wire [2:0]  _slots_5_io_out_uop_iq_type;	// issue-unit.scala:153:73
  wire [9:0]  _slots_5_io_out_uop_fu_code;	// issue-unit.scala:153:73
  wire [1:0]  _slots_5_io_out_uop_iw_state;	// issue-unit.scala:153:73
  wire        _slots_5_io_out_uop_is_br;	// issue-unit.scala:153:73
  wire        _slots_5_io_out_uop_is_jalr;	// issue-unit.scala:153:73
  wire        _slots_5_io_out_uop_is_jal;	// issue-unit.scala:153:73
  wire        _slots_5_io_out_uop_is_sfb;	// issue-unit.scala:153:73
  wire [11:0] _slots_5_io_out_uop_br_mask;	// issue-unit.scala:153:73
  wire [3:0]  _slots_5_io_out_uop_br_tag;	// issue-unit.scala:153:73
  wire [4:0]  _slots_5_io_out_uop_ftq_idx;	// issue-unit.scala:153:73
  wire        _slots_5_io_out_uop_edge_inst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_5_io_out_uop_pc_lob;	// issue-unit.scala:153:73
  wire        _slots_5_io_out_uop_taken;	// issue-unit.scala:153:73
  wire [19:0] _slots_5_io_out_uop_imm_packed;	// issue-unit.scala:153:73
  wire [11:0] _slots_5_io_out_uop_csr_addr;	// issue-unit.scala:153:73
  wire [5:0]  _slots_5_io_out_uop_rob_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_5_io_out_uop_ldq_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_5_io_out_uop_stq_idx;	// issue-unit.scala:153:73
  wire [1:0]  _slots_5_io_out_uop_rxq_idx;	// issue-unit.scala:153:73
  wire [6:0]  _slots_5_io_out_uop_pdst;	// issue-unit.scala:153:73
  wire [6:0]  _slots_5_io_out_uop_prs1;	// issue-unit.scala:153:73
  wire [6:0]  _slots_5_io_out_uop_prs2;	// issue-unit.scala:153:73
  wire [6:0]  _slots_5_io_out_uop_prs3;	// issue-unit.scala:153:73
  wire [4:0]  _slots_5_io_out_uop_ppred;	// issue-unit.scala:153:73
  wire        _slots_5_io_out_uop_prs1_busy;	// issue-unit.scala:153:73
  wire        _slots_5_io_out_uop_prs2_busy;	// issue-unit.scala:153:73
  wire        _slots_5_io_out_uop_prs3_busy;	// issue-unit.scala:153:73
  wire        _slots_5_io_out_uop_ppred_busy;	// issue-unit.scala:153:73
  wire [6:0]  _slots_5_io_out_uop_stale_pdst;	// issue-unit.scala:153:73
  wire        _slots_5_io_out_uop_exception;	// issue-unit.scala:153:73
  wire [63:0] _slots_5_io_out_uop_exc_cause;	// issue-unit.scala:153:73
  wire        _slots_5_io_out_uop_bypassable;	// issue-unit.scala:153:73
  wire [4:0]  _slots_5_io_out_uop_mem_cmd;	// issue-unit.scala:153:73
  wire [1:0]  _slots_5_io_out_uop_mem_size;	// issue-unit.scala:153:73
  wire        _slots_5_io_out_uop_mem_signed;	// issue-unit.scala:153:73
  wire        _slots_5_io_out_uop_is_fence;	// issue-unit.scala:153:73
  wire        _slots_5_io_out_uop_is_fencei;	// issue-unit.scala:153:73
  wire        _slots_5_io_out_uop_is_amo;	// issue-unit.scala:153:73
  wire        _slots_5_io_out_uop_uses_ldq;	// issue-unit.scala:153:73
  wire        _slots_5_io_out_uop_uses_stq;	// issue-unit.scala:153:73
  wire        _slots_5_io_out_uop_is_sys_pc2epc;	// issue-unit.scala:153:73
  wire        _slots_5_io_out_uop_is_unique;	// issue-unit.scala:153:73
  wire        _slots_5_io_out_uop_flush_on_commit;	// issue-unit.scala:153:73
  wire        _slots_5_io_out_uop_ldst_is_rs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_5_io_out_uop_ldst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_5_io_out_uop_lrs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_5_io_out_uop_lrs2;	// issue-unit.scala:153:73
  wire [5:0]  _slots_5_io_out_uop_lrs3;	// issue-unit.scala:153:73
  wire        _slots_5_io_out_uop_ldst_val;	// issue-unit.scala:153:73
  wire [1:0]  _slots_5_io_out_uop_dst_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_5_io_out_uop_lrs1_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_5_io_out_uop_lrs2_rtype;	// issue-unit.scala:153:73
  wire        _slots_5_io_out_uop_frs3_en;	// issue-unit.scala:153:73
  wire        _slots_5_io_out_uop_fp_val;	// issue-unit.scala:153:73
  wire        _slots_5_io_out_uop_fp_single;	// issue-unit.scala:153:73
  wire        _slots_5_io_out_uop_xcpt_pf_if;	// issue-unit.scala:153:73
  wire        _slots_5_io_out_uop_xcpt_ae_if;	// issue-unit.scala:153:73
  wire        _slots_5_io_out_uop_xcpt_ma_if;	// issue-unit.scala:153:73
  wire        _slots_5_io_out_uop_bp_debug_if;	// issue-unit.scala:153:73
  wire        _slots_5_io_out_uop_bp_xcpt_if;	// issue-unit.scala:153:73
  wire [1:0]  _slots_5_io_out_uop_debug_fsrc;	// issue-unit.scala:153:73
  wire [1:0]  _slots_5_io_out_uop_debug_tsrc;	// issue-unit.scala:153:73
  wire [6:0]  _slots_5_io_uop_uopc;	// issue-unit.scala:153:73
  wire [31:0] _slots_5_io_uop_inst;	// issue-unit.scala:153:73
  wire [31:0] _slots_5_io_uop_debug_inst;	// issue-unit.scala:153:73
  wire        _slots_5_io_uop_is_rvc;	// issue-unit.scala:153:73
  wire [39:0] _slots_5_io_uop_debug_pc;	// issue-unit.scala:153:73
  wire [2:0]  _slots_5_io_uop_iq_type;	// issue-unit.scala:153:73
  wire [9:0]  _slots_5_io_uop_fu_code;	// issue-unit.scala:153:73
  wire [1:0]  _slots_5_io_uop_iw_state;	// issue-unit.scala:153:73
  wire        _slots_5_io_uop_is_br;	// issue-unit.scala:153:73
  wire        _slots_5_io_uop_is_jalr;	// issue-unit.scala:153:73
  wire        _slots_5_io_uop_is_jal;	// issue-unit.scala:153:73
  wire        _slots_5_io_uop_is_sfb;	// issue-unit.scala:153:73
  wire [11:0] _slots_5_io_uop_br_mask;	// issue-unit.scala:153:73
  wire [3:0]  _slots_5_io_uop_br_tag;	// issue-unit.scala:153:73
  wire [4:0]  _slots_5_io_uop_ftq_idx;	// issue-unit.scala:153:73
  wire        _slots_5_io_uop_edge_inst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_5_io_uop_pc_lob;	// issue-unit.scala:153:73
  wire        _slots_5_io_uop_taken;	// issue-unit.scala:153:73
  wire [19:0] _slots_5_io_uop_imm_packed;	// issue-unit.scala:153:73
  wire [11:0] _slots_5_io_uop_csr_addr;	// issue-unit.scala:153:73
  wire [5:0]  _slots_5_io_uop_rob_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_5_io_uop_ldq_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_5_io_uop_stq_idx;	// issue-unit.scala:153:73
  wire [1:0]  _slots_5_io_uop_rxq_idx;	// issue-unit.scala:153:73
  wire [6:0]  _slots_5_io_uop_pdst;	// issue-unit.scala:153:73
  wire [6:0]  _slots_5_io_uop_prs1;	// issue-unit.scala:153:73
  wire [6:0]  _slots_5_io_uop_prs2;	// issue-unit.scala:153:73
  wire [6:0]  _slots_5_io_uop_prs3;	// issue-unit.scala:153:73
  wire [4:0]  _slots_5_io_uop_ppred;	// issue-unit.scala:153:73
  wire        _slots_5_io_uop_prs1_busy;	// issue-unit.scala:153:73
  wire        _slots_5_io_uop_prs2_busy;	// issue-unit.scala:153:73
  wire        _slots_5_io_uop_prs3_busy;	// issue-unit.scala:153:73
  wire        _slots_5_io_uop_ppred_busy;	// issue-unit.scala:153:73
  wire [6:0]  _slots_5_io_uop_stale_pdst;	// issue-unit.scala:153:73
  wire        _slots_5_io_uop_exception;	// issue-unit.scala:153:73
  wire [63:0] _slots_5_io_uop_exc_cause;	// issue-unit.scala:153:73
  wire        _slots_5_io_uop_bypassable;	// issue-unit.scala:153:73
  wire [4:0]  _slots_5_io_uop_mem_cmd;	// issue-unit.scala:153:73
  wire [1:0]  _slots_5_io_uop_mem_size;	// issue-unit.scala:153:73
  wire        _slots_5_io_uop_mem_signed;	// issue-unit.scala:153:73
  wire        _slots_5_io_uop_is_fence;	// issue-unit.scala:153:73
  wire        _slots_5_io_uop_is_fencei;	// issue-unit.scala:153:73
  wire        _slots_5_io_uop_is_amo;	// issue-unit.scala:153:73
  wire        _slots_5_io_uop_uses_ldq;	// issue-unit.scala:153:73
  wire        _slots_5_io_uop_uses_stq;	// issue-unit.scala:153:73
  wire        _slots_5_io_uop_is_sys_pc2epc;	// issue-unit.scala:153:73
  wire        _slots_5_io_uop_is_unique;	// issue-unit.scala:153:73
  wire        _slots_5_io_uop_flush_on_commit;	// issue-unit.scala:153:73
  wire        _slots_5_io_uop_ldst_is_rs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_5_io_uop_ldst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_5_io_uop_lrs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_5_io_uop_lrs2;	// issue-unit.scala:153:73
  wire [5:0]  _slots_5_io_uop_lrs3;	// issue-unit.scala:153:73
  wire        _slots_5_io_uop_ldst_val;	// issue-unit.scala:153:73
  wire [1:0]  _slots_5_io_uop_dst_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_5_io_uop_lrs1_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_5_io_uop_lrs2_rtype;	// issue-unit.scala:153:73
  wire        _slots_5_io_uop_frs3_en;	// issue-unit.scala:153:73
  wire        _slots_5_io_uop_fp_val;	// issue-unit.scala:153:73
  wire        _slots_5_io_uop_fp_single;	// issue-unit.scala:153:73
  wire        _slots_5_io_uop_xcpt_pf_if;	// issue-unit.scala:153:73
  wire        _slots_5_io_uop_xcpt_ae_if;	// issue-unit.scala:153:73
  wire        _slots_5_io_uop_xcpt_ma_if;	// issue-unit.scala:153:73
  wire        _slots_5_io_uop_bp_debug_if;	// issue-unit.scala:153:73
  wire        _slots_5_io_uop_bp_xcpt_if;	// issue-unit.scala:153:73
  wire [1:0]  _slots_5_io_uop_debug_fsrc;	// issue-unit.scala:153:73
  wire [1:0]  _slots_5_io_uop_debug_tsrc;	// issue-unit.scala:153:73
  wire        _slots_4_io_valid;	// issue-unit.scala:153:73
  wire        _slots_4_io_will_be_valid;	// issue-unit.scala:153:73
  wire        _slots_4_io_request;	// issue-unit.scala:153:73
  wire [6:0]  _slots_4_io_out_uop_uopc;	// issue-unit.scala:153:73
  wire [31:0] _slots_4_io_out_uop_inst;	// issue-unit.scala:153:73
  wire [31:0] _slots_4_io_out_uop_debug_inst;	// issue-unit.scala:153:73
  wire        _slots_4_io_out_uop_is_rvc;	// issue-unit.scala:153:73
  wire [39:0] _slots_4_io_out_uop_debug_pc;	// issue-unit.scala:153:73
  wire [2:0]  _slots_4_io_out_uop_iq_type;	// issue-unit.scala:153:73
  wire [9:0]  _slots_4_io_out_uop_fu_code;	// issue-unit.scala:153:73
  wire [1:0]  _slots_4_io_out_uop_iw_state;	// issue-unit.scala:153:73
  wire        _slots_4_io_out_uop_is_br;	// issue-unit.scala:153:73
  wire        _slots_4_io_out_uop_is_jalr;	// issue-unit.scala:153:73
  wire        _slots_4_io_out_uop_is_jal;	// issue-unit.scala:153:73
  wire        _slots_4_io_out_uop_is_sfb;	// issue-unit.scala:153:73
  wire [11:0] _slots_4_io_out_uop_br_mask;	// issue-unit.scala:153:73
  wire [3:0]  _slots_4_io_out_uop_br_tag;	// issue-unit.scala:153:73
  wire [4:0]  _slots_4_io_out_uop_ftq_idx;	// issue-unit.scala:153:73
  wire        _slots_4_io_out_uop_edge_inst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_4_io_out_uop_pc_lob;	// issue-unit.scala:153:73
  wire        _slots_4_io_out_uop_taken;	// issue-unit.scala:153:73
  wire [19:0] _slots_4_io_out_uop_imm_packed;	// issue-unit.scala:153:73
  wire [11:0] _slots_4_io_out_uop_csr_addr;	// issue-unit.scala:153:73
  wire [5:0]  _slots_4_io_out_uop_rob_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_4_io_out_uop_ldq_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_4_io_out_uop_stq_idx;	// issue-unit.scala:153:73
  wire [1:0]  _slots_4_io_out_uop_rxq_idx;	// issue-unit.scala:153:73
  wire [6:0]  _slots_4_io_out_uop_pdst;	// issue-unit.scala:153:73
  wire [6:0]  _slots_4_io_out_uop_prs1;	// issue-unit.scala:153:73
  wire [6:0]  _slots_4_io_out_uop_prs2;	// issue-unit.scala:153:73
  wire [6:0]  _slots_4_io_out_uop_prs3;	// issue-unit.scala:153:73
  wire [4:0]  _slots_4_io_out_uop_ppred;	// issue-unit.scala:153:73
  wire        _slots_4_io_out_uop_prs1_busy;	// issue-unit.scala:153:73
  wire        _slots_4_io_out_uop_prs2_busy;	// issue-unit.scala:153:73
  wire        _slots_4_io_out_uop_prs3_busy;	// issue-unit.scala:153:73
  wire        _slots_4_io_out_uop_ppred_busy;	// issue-unit.scala:153:73
  wire [6:0]  _slots_4_io_out_uop_stale_pdst;	// issue-unit.scala:153:73
  wire        _slots_4_io_out_uop_exception;	// issue-unit.scala:153:73
  wire [63:0] _slots_4_io_out_uop_exc_cause;	// issue-unit.scala:153:73
  wire        _slots_4_io_out_uop_bypassable;	// issue-unit.scala:153:73
  wire [4:0]  _slots_4_io_out_uop_mem_cmd;	// issue-unit.scala:153:73
  wire [1:0]  _slots_4_io_out_uop_mem_size;	// issue-unit.scala:153:73
  wire        _slots_4_io_out_uop_mem_signed;	// issue-unit.scala:153:73
  wire        _slots_4_io_out_uop_is_fence;	// issue-unit.scala:153:73
  wire        _slots_4_io_out_uop_is_fencei;	// issue-unit.scala:153:73
  wire        _slots_4_io_out_uop_is_amo;	// issue-unit.scala:153:73
  wire        _slots_4_io_out_uop_uses_ldq;	// issue-unit.scala:153:73
  wire        _slots_4_io_out_uop_uses_stq;	// issue-unit.scala:153:73
  wire        _slots_4_io_out_uop_is_sys_pc2epc;	// issue-unit.scala:153:73
  wire        _slots_4_io_out_uop_is_unique;	// issue-unit.scala:153:73
  wire        _slots_4_io_out_uop_flush_on_commit;	// issue-unit.scala:153:73
  wire        _slots_4_io_out_uop_ldst_is_rs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_4_io_out_uop_ldst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_4_io_out_uop_lrs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_4_io_out_uop_lrs2;	// issue-unit.scala:153:73
  wire [5:0]  _slots_4_io_out_uop_lrs3;	// issue-unit.scala:153:73
  wire        _slots_4_io_out_uop_ldst_val;	// issue-unit.scala:153:73
  wire [1:0]  _slots_4_io_out_uop_dst_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_4_io_out_uop_lrs1_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_4_io_out_uop_lrs2_rtype;	// issue-unit.scala:153:73
  wire        _slots_4_io_out_uop_frs3_en;	// issue-unit.scala:153:73
  wire        _slots_4_io_out_uop_fp_val;	// issue-unit.scala:153:73
  wire        _slots_4_io_out_uop_fp_single;	// issue-unit.scala:153:73
  wire        _slots_4_io_out_uop_xcpt_pf_if;	// issue-unit.scala:153:73
  wire        _slots_4_io_out_uop_xcpt_ae_if;	// issue-unit.scala:153:73
  wire        _slots_4_io_out_uop_xcpt_ma_if;	// issue-unit.scala:153:73
  wire        _slots_4_io_out_uop_bp_debug_if;	// issue-unit.scala:153:73
  wire        _slots_4_io_out_uop_bp_xcpt_if;	// issue-unit.scala:153:73
  wire [1:0]  _slots_4_io_out_uop_debug_fsrc;	// issue-unit.scala:153:73
  wire [1:0]  _slots_4_io_out_uop_debug_tsrc;	// issue-unit.scala:153:73
  wire [6:0]  _slots_4_io_uop_uopc;	// issue-unit.scala:153:73
  wire [31:0] _slots_4_io_uop_inst;	// issue-unit.scala:153:73
  wire [31:0] _slots_4_io_uop_debug_inst;	// issue-unit.scala:153:73
  wire        _slots_4_io_uop_is_rvc;	// issue-unit.scala:153:73
  wire [39:0] _slots_4_io_uop_debug_pc;	// issue-unit.scala:153:73
  wire [2:0]  _slots_4_io_uop_iq_type;	// issue-unit.scala:153:73
  wire [9:0]  _slots_4_io_uop_fu_code;	// issue-unit.scala:153:73
  wire [1:0]  _slots_4_io_uop_iw_state;	// issue-unit.scala:153:73
  wire        _slots_4_io_uop_is_br;	// issue-unit.scala:153:73
  wire        _slots_4_io_uop_is_jalr;	// issue-unit.scala:153:73
  wire        _slots_4_io_uop_is_jal;	// issue-unit.scala:153:73
  wire        _slots_4_io_uop_is_sfb;	// issue-unit.scala:153:73
  wire [11:0] _slots_4_io_uop_br_mask;	// issue-unit.scala:153:73
  wire [3:0]  _slots_4_io_uop_br_tag;	// issue-unit.scala:153:73
  wire [4:0]  _slots_4_io_uop_ftq_idx;	// issue-unit.scala:153:73
  wire        _slots_4_io_uop_edge_inst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_4_io_uop_pc_lob;	// issue-unit.scala:153:73
  wire        _slots_4_io_uop_taken;	// issue-unit.scala:153:73
  wire [19:0] _slots_4_io_uop_imm_packed;	// issue-unit.scala:153:73
  wire [11:0] _slots_4_io_uop_csr_addr;	// issue-unit.scala:153:73
  wire [5:0]  _slots_4_io_uop_rob_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_4_io_uop_ldq_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_4_io_uop_stq_idx;	// issue-unit.scala:153:73
  wire [1:0]  _slots_4_io_uop_rxq_idx;	// issue-unit.scala:153:73
  wire [6:0]  _slots_4_io_uop_pdst;	// issue-unit.scala:153:73
  wire [6:0]  _slots_4_io_uop_prs1;	// issue-unit.scala:153:73
  wire [6:0]  _slots_4_io_uop_prs2;	// issue-unit.scala:153:73
  wire [6:0]  _slots_4_io_uop_prs3;	// issue-unit.scala:153:73
  wire [4:0]  _slots_4_io_uop_ppred;	// issue-unit.scala:153:73
  wire        _slots_4_io_uop_prs1_busy;	// issue-unit.scala:153:73
  wire        _slots_4_io_uop_prs2_busy;	// issue-unit.scala:153:73
  wire        _slots_4_io_uop_prs3_busy;	// issue-unit.scala:153:73
  wire        _slots_4_io_uop_ppred_busy;	// issue-unit.scala:153:73
  wire [6:0]  _slots_4_io_uop_stale_pdst;	// issue-unit.scala:153:73
  wire        _slots_4_io_uop_exception;	// issue-unit.scala:153:73
  wire [63:0] _slots_4_io_uop_exc_cause;	// issue-unit.scala:153:73
  wire        _slots_4_io_uop_bypassable;	// issue-unit.scala:153:73
  wire [4:0]  _slots_4_io_uop_mem_cmd;	// issue-unit.scala:153:73
  wire [1:0]  _slots_4_io_uop_mem_size;	// issue-unit.scala:153:73
  wire        _slots_4_io_uop_mem_signed;	// issue-unit.scala:153:73
  wire        _slots_4_io_uop_is_fence;	// issue-unit.scala:153:73
  wire        _slots_4_io_uop_is_fencei;	// issue-unit.scala:153:73
  wire        _slots_4_io_uop_is_amo;	// issue-unit.scala:153:73
  wire        _slots_4_io_uop_uses_ldq;	// issue-unit.scala:153:73
  wire        _slots_4_io_uop_uses_stq;	// issue-unit.scala:153:73
  wire        _slots_4_io_uop_is_sys_pc2epc;	// issue-unit.scala:153:73
  wire        _slots_4_io_uop_is_unique;	// issue-unit.scala:153:73
  wire        _slots_4_io_uop_flush_on_commit;	// issue-unit.scala:153:73
  wire        _slots_4_io_uop_ldst_is_rs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_4_io_uop_ldst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_4_io_uop_lrs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_4_io_uop_lrs2;	// issue-unit.scala:153:73
  wire [5:0]  _slots_4_io_uop_lrs3;	// issue-unit.scala:153:73
  wire        _slots_4_io_uop_ldst_val;	// issue-unit.scala:153:73
  wire [1:0]  _slots_4_io_uop_dst_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_4_io_uop_lrs1_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_4_io_uop_lrs2_rtype;	// issue-unit.scala:153:73
  wire        _slots_4_io_uop_frs3_en;	// issue-unit.scala:153:73
  wire        _slots_4_io_uop_fp_val;	// issue-unit.scala:153:73
  wire        _slots_4_io_uop_fp_single;	// issue-unit.scala:153:73
  wire        _slots_4_io_uop_xcpt_pf_if;	// issue-unit.scala:153:73
  wire        _slots_4_io_uop_xcpt_ae_if;	// issue-unit.scala:153:73
  wire        _slots_4_io_uop_xcpt_ma_if;	// issue-unit.scala:153:73
  wire        _slots_4_io_uop_bp_debug_if;	// issue-unit.scala:153:73
  wire        _slots_4_io_uop_bp_xcpt_if;	// issue-unit.scala:153:73
  wire [1:0]  _slots_4_io_uop_debug_fsrc;	// issue-unit.scala:153:73
  wire [1:0]  _slots_4_io_uop_debug_tsrc;	// issue-unit.scala:153:73
  wire        _slots_3_io_valid;	// issue-unit.scala:153:73
  wire        _slots_3_io_will_be_valid;	// issue-unit.scala:153:73
  wire        _slots_3_io_request;	// issue-unit.scala:153:73
  wire [6:0]  _slots_3_io_out_uop_uopc;	// issue-unit.scala:153:73
  wire [31:0] _slots_3_io_out_uop_inst;	// issue-unit.scala:153:73
  wire [31:0] _slots_3_io_out_uop_debug_inst;	// issue-unit.scala:153:73
  wire        _slots_3_io_out_uop_is_rvc;	// issue-unit.scala:153:73
  wire [39:0] _slots_3_io_out_uop_debug_pc;	// issue-unit.scala:153:73
  wire [2:0]  _slots_3_io_out_uop_iq_type;	// issue-unit.scala:153:73
  wire [9:0]  _slots_3_io_out_uop_fu_code;	// issue-unit.scala:153:73
  wire [1:0]  _slots_3_io_out_uop_iw_state;	// issue-unit.scala:153:73
  wire        _slots_3_io_out_uop_is_br;	// issue-unit.scala:153:73
  wire        _slots_3_io_out_uop_is_jalr;	// issue-unit.scala:153:73
  wire        _slots_3_io_out_uop_is_jal;	// issue-unit.scala:153:73
  wire        _slots_3_io_out_uop_is_sfb;	// issue-unit.scala:153:73
  wire [11:0] _slots_3_io_out_uop_br_mask;	// issue-unit.scala:153:73
  wire [3:0]  _slots_3_io_out_uop_br_tag;	// issue-unit.scala:153:73
  wire [4:0]  _slots_3_io_out_uop_ftq_idx;	// issue-unit.scala:153:73
  wire        _slots_3_io_out_uop_edge_inst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_3_io_out_uop_pc_lob;	// issue-unit.scala:153:73
  wire        _slots_3_io_out_uop_taken;	// issue-unit.scala:153:73
  wire [19:0] _slots_3_io_out_uop_imm_packed;	// issue-unit.scala:153:73
  wire [11:0] _slots_3_io_out_uop_csr_addr;	// issue-unit.scala:153:73
  wire [5:0]  _slots_3_io_out_uop_rob_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_3_io_out_uop_ldq_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_3_io_out_uop_stq_idx;	// issue-unit.scala:153:73
  wire [1:0]  _slots_3_io_out_uop_rxq_idx;	// issue-unit.scala:153:73
  wire [6:0]  _slots_3_io_out_uop_pdst;	// issue-unit.scala:153:73
  wire [6:0]  _slots_3_io_out_uop_prs1;	// issue-unit.scala:153:73
  wire [6:0]  _slots_3_io_out_uop_prs2;	// issue-unit.scala:153:73
  wire [6:0]  _slots_3_io_out_uop_prs3;	// issue-unit.scala:153:73
  wire [4:0]  _slots_3_io_out_uop_ppred;	// issue-unit.scala:153:73
  wire        _slots_3_io_out_uop_prs1_busy;	// issue-unit.scala:153:73
  wire        _slots_3_io_out_uop_prs2_busy;	// issue-unit.scala:153:73
  wire        _slots_3_io_out_uop_prs3_busy;	// issue-unit.scala:153:73
  wire        _slots_3_io_out_uop_ppred_busy;	// issue-unit.scala:153:73
  wire [6:0]  _slots_3_io_out_uop_stale_pdst;	// issue-unit.scala:153:73
  wire        _slots_3_io_out_uop_exception;	// issue-unit.scala:153:73
  wire [63:0] _slots_3_io_out_uop_exc_cause;	// issue-unit.scala:153:73
  wire        _slots_3_io_out_uop_bypassable;	// issue-unit.scala:153:73
  wire [4:0]  _slots_3_io_out_uop_mem_cmd;	// issue-unit.scala:153:73
  wire [1:0]  _slots_3_io_out_uop_mem_size;	// issue-unit.scala:153:73
  wire        _slots_3_io_out_uop_mem_signed;	// issue-unit.scala:153:73
  wire        _slots_3_io_out_uop_is_fence;	// issue-unit.scala:153:73
  wire        _slots_3_io_out_uop_is_fencei;	// issue-unit.scala:153:73
  wire        _slots_3_io_out_uop_is_amo;	// issue-unit.scala:153:73
  wire        _slots_3_io_out_uop_uses_ldq;	// issue-unit.scala:153:73
  wire        _slots_3_io_out_uop_uses_stq;	// issue-unit.scala:153:73
  wire        _slots_3_io_out_uop_is_sys_pc2epc;	// issue-unit.scala:153:73
  wire        _slots_3_io_out_uop_is_unique;	// issue-unit.scala:153:73
  wire        _slots_3_io_out_uop_flush_on_commit;	// issue-unit.scala:153:73
  wire        _slots_3_io_out_uop_ldst_is_rs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_3_io_out_uop_ldst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_3_io_out_uop_lrs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_3_io_out_uop_lrs2;	// issue-unit.scala:153:73
  wire [5:0]  _slots_3_io_out_uop_lrs3;	// issue-unit.scala:153:73
  wire        _slots_3_io_out_uop_ldst_val;	// issue-unit.scala:153:73
  wire [1:0]  _slots_3_io_out_uop_dst_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_3_io_out_uop_lrs1_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_3_io_out_uop_lrs2_rtype;	// issue-unit.scala:153:73
  wire        _slots_3_io_out_uop_frs3_en;	// issue-unit.scala:153:73
  wire        _slots_3_io_out_uop_fp_val;	// issue-unit.scala:153:73
  wire        _slots_3_io_out_uop_fp_single;	// issue-unit.scala:153:73
  wire        _slots_3_io_out_uop_xcpt_pf_if;	// issue-unit.scala:153:73
  wire        _slots_3_io_out_uop_xcpt_ae_if;	// issue-unit.scala:153:73
  wire        _slots_3_io_out_uop_xcpt_ma_if;	// issue-unit.scala:153:73
  wire        _slots_3_io_out_uop_bp_debug_if;	// issue-unit.scala:153:73
  wire        _slots_3_io_out_uop_bp_xcpt_if;	// issue-unit.scala:153:73
  wire [1:0]  _slots_3_io_out_uop_debug_fsrc;	// issue-unit.scala:153:73
  wire [1:0]  _slots_3_io_out_uop_debug_tsrc;	// issue-unit.scala:153:73
  wire [6:0]  _slots_3_io_uop_uopc;	// issue-unit.scala:153:73
  wire [31:0] _slots_3_io_uop_inst;	// issue-unit.scala:153:73
  wire [31:0] _slots_3_io_uop_debug_inst;	// issue-unit.scala:153:73
  wire        _slots_3_io_uop_is_rvc;	// issue-unit.scala:153:73
  wire [39:0] _slots_3_io_uop_debug_pc;	// issue-unit.scala:153:73
  wire [2:0]  _slots_3_io_uop_iq_type;	// issue-unit.scala:153:73
  wire [9:0]  _slots_3_io_uop_fu_code;	// issue-unit.scala:153:73
  wire [1:0]  _slots_3_io_uop_iw_state;	// issue-unit.scala:153:73
  wire        _slots_3_io_uop_is_br;	// issue-unit.scala:153:73
  wire        _slots_3_io_uop_is_jalr;	// issue-unit.scala:153:73
  wire        _slots_3_io_uop_is_jal;	// issue-unit.scala:153:73
  wire        _slots_3_io_uop_is_sfb;	// issue-unit.scala:153:73
  wire [11:0] _slots_3_io_uop_br_mask;	// issue-unit.scala:153:73
  wire [3:0]  _slots_3_io_uop_br_tag;	// issue-unit.scala:153:73
  wire [4:0]  _slots_3_io_uop_ftq_idx;	// issue-unit.scala:153:73
  wire        _slots_3_io_uop_edge_inst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_3_io_uop_pc_lob;	// issue-unit.scala:153:73
  wire        _slots_3_io_uop_taken;	// issue-unit.scala:153:73
  wire [19:0] _slots_3_io_uop_imm_packed;	// issue-unit.scala:153:73
  wire [11:0] _slots_3_io_uop_csr_addr;	// issue-unit.scala:153:73
  wire [5:0]  _slots_3_io_uop_rob_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_3_io_uop_ldq_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_3_io_uop_stq_idx;	// issue-unit.scala:153:73
  wire [1:0]  _slots_3_io_uop_rxq_idx;	// issue-unit.scala:153:73
  wire [6:0]  _slots_3_io_uop_pdst;	// issue-unit.scala:153:73
  wire [6:0]  _slots_3_io_uop_prs1;	// issue-unit.scala:153:73
  wire [6:0]  _slots_3_io_uop_prs2;	// issue-unit.scala:153:73
  wire [6:0]  _slots_3_io_uop_prs3;	// issue-unit.scala:153:73
  wire [4:0]  _slots_3_io_uop_ppred;	// issue-unit.scala:153:73
  wire        _slots_3_io_uop_prs1_busy;	// issue-unit.scala:153:73
  wire        _slots_3_io_uop_prs2_busy;	// issue-unit.scala:153:73
  wire        _slots_3_io_uop_prs3_busy;	// issue-unit.scala:153:73
  wire        _slots_3_io_uop_ppred_busy;	// issue-unit.scala:153:73
  wire [6:0]  _slots_3_io_uop_stale_pdst;	// issue-unit.scala:153:73
  wire        _slots_3_io_uop_exception;	// issue-unit.scala:153:73
  wire [63:0] _slots_3_io_uop_exc_cause;	// issue-unit.scala:153:73
  wire        _slots_3_io_uop_bypassable;	// issue-unit.scala:153:73
  wire [4:0]  _slots_3_io_uop_mem_cmd;	// issue-unit.scala:153:73
  wire [1:0]  _slots_3_io_uop_mem_size;	// issue-unit.scala:153:73
  wire        _slots_3_io_uop_mem_signed;	// issue-unit.scala:153:73
  wire        _slots_3_io_uop_is_fence;	// issue-unit.scala:153:73
  wire        _slots_3_io_uop_is_fencei;	// issue-unit.scala:153:73
  wire        _slots_3_io_uop_is_amo;	// issue-unit.scala:153:73
  wire        _slots_3_io_uop_uses_ldq;	// issue-unit.scala:153:73
  wire        _slots_3_io_uop_uses_stq;	// issue-unit.scala:153:73
  wire        _slots_3_io_uop_is_sys_pc2epc;	// issue-unit.scala:153:73
  wire        _slots_3_io_uop_is_unique;	// issue-unit.scala:153:73
  wire        _slots_3_io_uop_flush_on_commit;	// issue-unit.scala:153:73
  wire        _slots_3_io_uop_ldst_is_rs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_3_io_uop_ldst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_3_io_uop_lrs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_3_io_uop_lrs2;	// issue-unit.scala:153:73
  wire [5:0]  _slots_3_io_uop_lrs3;	// issue-unit.scala:153:73
  wire        _slots_3_io_uop_ldst_val;	// issue-unit.scala:153:73
  wire [1:0]  _slots_3_io_uop_dst_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_3_io_uop_lrs1_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_3_io_uop_lrs2_rtype;	// issue-unit.scala:153:73
  wire        _slots_3_io_uop_frs3_en;	// issue-unit.scala:153:73
  wire        _slots_3_io_uop_fp_val;	// issue-unit.scala:153:73
  wire        _slots_3_io_uop_fp_single;	// issue-unit.scala:153:73
  wire        _slots_3_io_uop_xcpt_pf_if;	// issue-unit.scala:153:73
  wire        _slots_3_io_uop_xcpt_ae_if;	// issue-unit.scala:153:73
  wire        _slots_3_io_uop_xcpt_ma_if;	// issue-unit.scala:153:73
  wire        _slots_3_io_uop_bp_debug_if;	// issue-unit.scala:153:73
  wire        _slots_3_io_uop_bp_xcpt_if;	// issue-unit.scala:153:73
  wire [1:0]  _slots_3_io_uop_debug_fsrc;	// issue-unit.scala:153:73
  wire [1:0]  _slots_3_io_uop_debug_tsrc;	// issue-unit.scala:153:73
  wire        _slots_2_io_valid;	// issue-unit.scala:153:73
  wire        _slots_2_io_will_be_valid;	// issue-unit.scala:153:73
  wire        _slots_2_io_request;	// issue-unit.scala:153:73
  wire [6:0]  _slots_2_io_out_uop_uopc;	// issue-unit.scala:153:73
  wire [31:0] _slots_2_io_out_uop_inst;	// issue-unit.scala:153:73
  wire [31:0] _slots_2_io_out_uop_debug_inst;	// issue-unit.scala:153:73
  wire        _slots_2_io_out_uop_is_rvc;	// issue-unit.scala:153:73
  wire [39:0] _slots_2_io_out_uop_debug_pc;	// issue-unit.scala:153:73
  wire [2:0]  _slots_2_io_out_uop_iq_type;	// issue-unit.scala:153:73
  wire [9:0]  _slots_2_io_out_uop_fu_code;	// issue-unit.scala:153:73
  wire [1:0]  _slots_2_io_out_uop_iw_state;	// issue-unit.scala:153:73
  wire        _slots_2_io_out_uop_is_br;	// issue-unit.scala:153:73
  wire        _slots_2_io_out_uop_is_jalr;	// issue-unit.scala:153:73
  wire        _slots_2_io_out_uop_is_jal;	// issue-unit.scala:153:73
  wire        _slots_2_io_out_uop_is_sfb;	// issue-unit.scala:153:73
  wire [11:0] _slots_2_io_out_uop_br_mask;	// issue-unit.scala:153:73
  wire [3:0]  _slots_2_io_out_uop_br_tag;	// issue-unit.scala:153:73
  wire [4:0]  _slots_2_io_out_uop_ftq_idx;	// issue-unit.scala:153:73
  wire        _slots_2_io_out_uop_edge_inst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_2_io_out_uop_pc_lob;	// issue-unit.scala:153:73
  wire        _slots_2_io_out_uop_taken;	// issue-unit.scala:153:73
  wire [19:0] _slots_2_io_out_uop_imm_packed;	// issue-unit.scala:153:73
  wire [11:0] _slots_2_io_out_uop_csr_addr;	// issue-unit.scala:153:73
  wire [5:0]  _slots_2_io_out_uop_rob_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_2_io_out_uop_ldq_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_2_io_out_uop_stq_idx;	// issue-unit.scala:153:73
  wire [1:0]  _slots_2_io_out_uop_rxq_idx;	// issue-unit.scala:153:73
  wire [6:0]  _slots_2_io_out_uop_pdst;	// issue-unit.scala:153:73
  wire [6:0]  _slots_2_io_out_uop_prs1;	// issue-unit.scala:153:73
  wire [6:0]  _slots_2_io_out_uop_prs2;	// issue-unit.scala:153:73
  wire [6:0]  _slots_2_io_out_uop_prs3;	// issue-unit.scala:153:73
  wire [4:0]  _slots_2_io_out_uop_ppred;	// issue-unit.scala:153:73
  wire        _slots_2_io_out_uop_prs1_busy;	// issue-unit.scala:153:73
  wire        _slots_2_io_out_uop_prs2_busy;	// issue-unit.scala:153:73
  wire        _slots_2_io_out_uop_prs3_busy;	// issue-unit.scala:153:73
  wire        _slots_2_io_out_uop_ppred_busy;	// issue-unit.scala:153:73
  wire [6:0]  _slots_2_io_out_uop_stale_pdst;	// issue-unit.scala:153:73
  wire        _slots_2_io_out_uop_exception;	// issue-unit.scala:153:73
  wire [63:0] _slots_2_io_out_uop_exc_cause;	// issue-unit.scala:153:73
  wire        _slots_2_io_out_uop_bypassable;	// issue-unit.scala:153:73
  wire [4:0]  _slots_2_io_out_uop_mem_cmd;	// issue-unit.scala:153:73
  wire [1:0]  _slots_2_io_out_uop_mem_size;	// issue-unit.scala:153:73
  wire        _slots_2_io_out_uop_mem_signed;	// issue-unit.scala:153:73
  wire        _slots_2_io_out_uop_is_fence;	// issue-unit.scala:153:73
  wire        _slots_2_io_out_uop_is_fencei;	// issue-unit.scala:153:73
  wire        _slots_2_io_out_uop_is_amo;	// issue-unit.scala:153:73
  wire        _slots_2_io_out_uop_uses_ldq;	// issue-unit.scala:153:73
  wire        _slots_2_io_out_uop_uses_stq;	// issue-unit.scala:153:73
  wire        _slots_2_io_out_uop_is_sys_pc2epc;	// issue-unit.scala:153:73
  wire        _slots_2_io_out_uop_is_unique;	// issue-unit.scala:153:73
  wire        _slots_2_io_out_uop_flush_on_commit;	// issue-unit.scala:153:73
  wire        _slots_2_io_out_uop_ldst_is_rs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_2_io_out_uop_ldst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_2_io_out_uop_lrs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_2_io_out_uop_lrs2;	// issue-unit.scala:153:73
  wire [5:0]  _slots_2_io_out_uop_lrs3;	// issue-unit.scala:153:73
  wire        _slots_2_io_out_uop_ldst_val;	// issue-unit.scala:153:73
  wire [1:0]  _slots_2_io_out_uop_dst_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_2_io_out_uop_lrs1_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_2_io_out_uop_lrs2_rtype;	// issue-unit.scala:153:73
  wire        _slots_2_io_out_uop_frs3_en;	// issue-unit.scala:153:73
  wire        _slots_2_io_out_uop_fp_val;	// issue-unit.scala:153:73
  wire        _slots_2_io_out_uop_fp_single;	// issue-unit.scala:153:73
  wire        _slots_2_io_out_uop_xcpt_pf_if;	// issue-unit.scala:153:73
  wire        _slots_2_io_out_uop_xcpt_ae_if;	// issue-unit.scala:153:73
  wire        _slots_2_io_out_uop_xcpt_ma_if;	// issue-unit.scala:153:73
  wire        _slots_2_io_out_uop_bp_debug_if;	// issue-unit.scala:153:73
  wire        _slots_2_io_out_uop_bp_xcpt_if;	// issue-unit.scala:153:73
  wire [1:0]  _slots_2_io_out_uop_debug_fsrc;	// issue-unit.scala:153:73
  wire [1:0]  _slots_2_io_out_uop_debug_tsrc;	// issue-unit.scala:153:73
  wire [6:0]  _slots_2_io_uop_uopc;	// issue-unit.scala:153:73
  wire [31:0] _slots_2_io_uop_inst;	// issue-unit.scala:153:73
  wire [31:0] _slots_2_io_uop_debug_inst;	// issue-unit.scala:153:73
  wire        _slots_2_io_uop_is_rvc;	// issue-unit.scala:153:73
  wire [39:0] _slots_2_io_uop_debug_pc;	// issue-unit.scala:153:73
  wire [2:0]  _slots_2_io_uop_iq_type;	// issue-unit.scala:153:73
  wire [9:0]  _slots_2_io_uop_fu_code;	// issue-unit.scala:153:73
  wire [1:0]  _slots_2_io_uop_iw_state;	// issue-unit.scala:153:73
  wire        _slots_2_io_uop_is_br;	// issue-unit.scala:153:73
  wire        _slots_2_io_uop_is_jalr;	// issue-unit.scala:153:73
  wire        _slots_2_io_uop_is_jal;	// issue-unit.scala:153:73
  wire        _slots_2_io_uop_is_sfb;	// issue-unit.scala:153:73
  wire [11:0] _slots_2_io_uop_br_mask;	// issue-unit.scala:153:73
  wire [3:0]  _slots_2_io_uop_br_tag;	// issue-unit.scala:153:73
  wire [4:0]  _slots_2_io_uop_ftq_idx;	// issue-unit.scala:153:73
  wire        _slots_2_io_uop_edge_inst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_2_io_uop_pc_lob;	// issue-unit.scala:153:73
  wire        _slots_2_io_uop_taken;	// issue-unit.scala:153:73
  wire [19:0] _slots_2_io_uop_imm_packed;	// issue-unit.scala:153:73
  wire [11:0] _slots_2_io_uop_csr_addr;	// issue-unit.scala:153:73
  wire [5:0]  _slots_2_io_uop_rob_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_2_io_uop_ldq_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_2_io_uop_stq_idx;	// issue-unit.scala:153:73
  wire [1:0]  _slots_2_io_uop_rxq_idx;	// issue-unit.scala:153:73
  wire [6:0]  _slots_2_io_uop_pdst;	// issue-unit.scala:153:73
  wire [6:0]  _slots_2_io_uop_prs1;	// issue-unit.scala:153:73
  wire [6:0]  _slots_2_io_uop_prs2;	// issue-unit.scala:153:73
  wire [6:0]  _slots_2_io_uop_prs3;	// issue-unit.scala:153:73
  wire [4:0]  _slots_2_io_uop_ppred;	// issue-unit.scala:153:73
  wire        _slots_2_io_uop_prs1_busy;	// issue-unit.scala:153:73
  wire        _slots_2_io_uop_prs2_busy;	// issue-unit.scala:153:73
  wire        _slots_2_io_uop_prs3_busy;	// issue-unit.scala:153:73
  wire        _slots_2_io_uop_ppred_busy;	// issue-unit.scala:153:73
  wire [6:0]  _slots_2_io_uop_stale_pdst;	// issue-unit.scala:153:73
  wire        _slots_2_io_uop_exception;	// issue-unit.scala:153:73
  wire [63:0] _slots_2_io_uop_exc_cause;	// issue-unit.scala:153:73
  wire        _slots_2_io_uop_bypassable;	// issue-unit.scala:153:73
  wire [4:0]  _slots_2_io_uop_mem_cmd;	// issue-unit.scala:153:73
  wire [1:0]  _slots_2_io_uop_mem_size;	// issue-unit.scala:153:73
  wire        _slots_2_io_uop_mem_signed;	// issue-unit.scala:153:73
  wire        _slots_2_io_uop_is_fence;	// issue-unit.scala:153:73
  wire        _slots_2_io_uop_is_fencei;	// issue-unit.scala:153:73
  wire        _slots_2_io_uop_is_amo;	// issue-unit.scala:153:73
  wire        _slots_2_io_uop_uses_ldq;	// issue-unit.scala:153:73
  wire        _slots_2_io_uop_uses_stq;	// issue-unit.scala:153:73
  wire        _slots_2_io_uop_is_sys_pc2epc;	// issue-unit.scala:153:73
  wire        _slots_2_io_uop_is_unique;	// issue-unit.scala:153:73
  wire        _slots_2_io_uop_flush_on_commit;	// issue-unit.scala:153:73
  wire        _slots_2_io_uop_ldst_is_rs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_2_io_uop_ldst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_2_io_uop_lrs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_2_io_uop_lrs2;	// issue-unit.scala:153:73
  wire [5:0]  _slots_2_io_uop_lrs3;	// issue-unit.scala:153:73
  wire        _slots_2_io_uop_ldst_val;	// issue-unit.scala:153:73
  wire [1:0]  _slots_2_io_uop_dst_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_2_io_uop_lrs1_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_2_io_uop_lrs2_rtype;	// issue-unit.scala:153:73
  wire        _slots_2_io_uop_frs3_en;	// issue-unit.scala:153:73
  wire        _slots_2_io_uop_fp_val;	// issue-unit.scala:153:73
  wire        _slots_2_io_uop_fp_single;	// issue-unit.scala:153:73
  wire        _slots_2_io_uop_xcpt_pf_if;	// issue-unit.scala:153:73
  wire        _slots_2_io_uop_xcpt_ae_if;	// issue-unit.scala:153:73
  wire        _slots_2_io_uop_xcpt_ma_if;	// issue-unit.scala:153:73
  wire        _slots_2_io_uop_bp_debug_if;	// issue-unit.scala:153:73
  wire        _slots_2_io_uop_bp_xcpt_if;	// issue-unit.scala:153:73
  wire [1:0]  _slots_2_io_uop_debug_fsrc;	// issue-unit.scala:153:73
  wire [1:0]  _slots_2_io_uop_debug_tsrc;	// issue-unit.scala:153:73
  wire        _slots_1_io_valid;	// issue-unit.scala:153:73
  wire        _slots_1_io_will_be_valid;	// issue-unit.scala:153:73
  wire        _slots_1_io_request;	// issue-unit.scala:153:73
  wire [6:0]  _slots_1_io_out_uop_uopc;	// issue-unit.scala:153:73
  wire [31:0] _slots_1_io_out_uop_inst;	// issue-unit.scala:153:73
  wire [31:0] _slots_1_io_out_uop_debug_inst;	// issue-unit.scala:153:73
  wire        _slots_1_io_out_uop_is_rvc;	// issue-unit.scala:153:73
  wire [39:0] _slots_1_io_out_uop_debug_pc;	// issue-unit.scala:153:73
  wire [2:0]  _slots_1_io_out_uop_iq_type;	// issue-unit.scala:153:73
  wire [9:0]  _slots_1_io_out_uop_fu_code;	// issue-unit.scala:153:73
  wire [1:0]  _slots_1_io_out_uop_iw_state;	// issue-unit.scala:153:73
  wire        _slots_1_io_out_uop_is_br;	// issue-unit.scala:153:73
  wire        _slots_1_io_out_uop_is_jalr;	// issue-unit.scala:153:73
  wire        _slots_1_io_out_uop_is_jal;	// issue-unit.scala:153:73
  wire        _slots_1_io_out_uop_is_sfb;	// issue-unit.scala:153:73
  wire [11:0] _slots_1_io_out_uop_br_mask;	// issue-unit.scala:153:73
  wire [3:0]  _slots_1_io_out_uop_br_tag;	// issue-unit.scala:153:73
  wire [4:0]  _slots_1_io_out_uop_ftq_idx;	// issue-unit.scala:153:73
  wire        _slots_1_io_out_uop_edge_inst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_1_io_out_uop_pc_lob;	// issue-unit.scala:153:73
  wire        _slots_1_io_out_uop_taken;	// issue-unit.scala:153:73
  wire [19:0] _slots_1_io_out_uop_imm_packed;	// issue-unit.scala:153:73
  wire [11:0] _slots_1_io_out_uop_csr_addr;	// issue-unit.scala:153:73
  wire [5:0]  _slots_1_io_out_uop_rob_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_1_io_out_uop_ldq_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_1_io_out_uop_stq_idx;	// issue-unit.scala:153:73
  wire [1:0]  _slots_1_io_out_uop_rxq_idx;	// issue-unit.scala:153:73
  wire [6:0]  _slots_1_io_out_uop_pdst;	// issue-unit.scala:153:73
  wire [6:0]  _slots_1_io_out_uop_prs1;	// issue-unit.scala:153:73
  wire [6:0]  _slots_1_io_out_uop_prs2;	// issue-unit.scala:153:73
  wire [6:0]  _slots_1_io_out_uop_prs3;	// issue-unit.scala:153:73
  wire [4:0]  _slots_1_io_out_uop_ppred;	// issue-unit.scala:153:73
  wire        _slots_1_io_out_uop_prs1_busy;	// issue-unit.scala:153:73
  wire        _slots_1_io_out_uop_prs2_busy;	// issue-unit.scala:153:73
  wire        _slots_1_io_out_uop_prs3_busy;	// issue-unit.scala:153:73
  wire        _slots_1_io_out_uop_ppred_busy;	// issue-unit.scala:153:73
  wire [6:0]  _slots_1_io_out_uop_stale_pdst;	// issue-unit.scala:153:73
  wire        _slots_1_io_out_uop_exception;	// issue-unit.scala:153:73
  wire [63:0] _slots_1_io_out_uop_exc_cause;	// issue-unit.scala:153:73
  wire        _slots_1_io_out_uop_bypassable;	// issue-unit.scala:153:73
  wire [4:0]  _slots_1_io_out_uop_mem_cmd;	// issue-unit.scala:153:73
  wire [1:0]  _slots_1_io_out_uop_mem_size;	// issue-unit.scala:153:73
  wire        _slots_1_io_out_uop_mem_signed;	// issue-unit.scala:153:73
  wire        _slots_1_io_out_uop_is_fence;	// issue-unit.scala:153:73
  wire        _slots_1_io_out_uop_is_fencei;	// issue-unit.scala:153:73
  wire        _slots_1_io_out_uop_is_amo;	// issue-unit.scala:153:73
  wire        _slots_1_io_out_uop_uses_ldq;	// issue-unit.scala:153:73
  wire        _slots_1_io_out_uop_uses_stq;	// issue-unit.scala:153:73
  wire        _slots_1_io_out_uop_is_sys_pc2epc;	// issue-unit.scala:153:73
  wire        _slots_1_io_out_uop_is_unique;	// issue-unit.scala:153:73
  wire        _slots_1_io_out_uop_flush_on_commit;	// issue-unit.scala:153:73
  wire        _slots_1_io_out_uop_ldst_is_rs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_1_io_out_uop_ldst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_1_io_out_uop_lrs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_1_io_out_uop_lrs2;	// issue-unit.scala:153:73
  wire [5:0]  _slots_1_io_out_uop_lrs3;	// issue-unit.scala:153:73
  wire        _slots_1_io_out_uop_ldst_val;	// issue-unit.scala:153:73
  wire [1:0]  _slots_1_io_out_uop_dst_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_1_io_out_uop_lrs1_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_1_io_out_uop_lrs2_rtype;	// issue-unit.scala:153:73
  wire        _slots_1_io_out_uop_frs3_en;	// issue-unit.scala:153:73
  wire        _slots_1_io_out_uop_fp_val;	// issue-unit.scala:153:73
  wire        _slots_1_io_out_uop_fp_single;	// issue-unit.scala:153:73
  wire        _slots_1_io_out_uop_xcpt_pf_if;	// issue-unit.scala:153:73
  wire        _slots_1_io_out_uop_xcpt_ae_if;	// issue-unit.scala:153:73
  wire        _slots_1_io_out_uop_xcpt_ma_if;	// issue-unit.scala:153:73
  wire        _slots_1_io_out_uop_bp_debug_if;	// issue-unit.scala:153:73
  wire        _slots_1_io_out_uop_bp_xcpt_if;	// issue-unit.scala:153:73
  wire [1:0]  _slots_1_io_out_uop_debug_fsrc;	// issue-unit.scala:153:73
  wire [1:0]  _slots_1_io_out_uop_debug_tsrc;	// issue-unit.scala:153:73
  wire [6:0]  _slots_1_io_uop_uopc;	// issue-unit.scala:153:73
  wire [31:0] _slots_1_io_uop_inst;	// issue-unit.scala:153:73
  wire [31:0] _slots_1_io_uop_debug_inst;	// issue-unit.scala:153:73
  wire        _slots_1_io_uop_is_rvc;	// issue-unit.scala:153:73
  wire [39:0] _slots_1_io_uop_debug_pc;	// issue-unit.scala:153:73
  wire [2:0]  _slots_1_io_uop_iq_type;	// issue-unit.scala:153:73
  wire [9:0]  _slots_1_io_uop_fu_code;	// issue-unit.scala:153:73
  wire [1:0]  _slots_1_io_uop_iw_state;	// issue-unit.scala:153:73
  wire        _slots_1_io_uop_is_br;	// issue-unit.scala:153:73
  wire        _slots_1_io_uop_is_jalr;	// issue-unit.scala:153:73
  wire        _slots_1_io_uop_is_jal;	// issue-unit.scala:153:73
  wire        _slots_1_io_uop_is_sfb;	// issue-unit.scala:153:73
  wire [11:0] _slots_1_io_uop_br_mask;	// issue-unit.scala:153:73
  wire [3:0]  _slots_1_io_uop_br_tag;	// issue-unit.scala:153:73
  wire [4:0]  _slots_1_io_uop_ftq_idx;	// issue-unit.scala:153:73
  wire        _slots_1_io_uop_edge_inst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_1_io_uop_pc_lob;	// issue-unit.scala:153:73
  wire        _slots_1_io_uop_taken;	// issue-unit.scala:153:73
  wire [19:0] _slots_1_io_uop_imm_packed;	// issue-unit.scala:153:73
  wire [11:0] _slots_1_io_uop_csr_addr;	// issue-unit.scala:153:73
  wire [5:0]  _slots_1_io_uop_rob_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_1_io_uop_ldq_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_1_io_uop_stq_idx;	// issue-unit.scala:153:73
  wire [1:0]  _slots_1_io_uop_rxq_idx;	// issue-unit.scala:153:73
  wire [6:0]  _slots_1_io_uop_pdst;	// issue-unit.scala:153:73
  wire [6:0]  _slots_1_io_uop_prs1;	// issue-unit.scala:153:73
  wire [6:0]  _slots_1_io_uop_prs2;	// issue-unit.scala:153:73
  wire [6:0]  _slots_1_io_uop_prs3;	// issue-unit.scala:153:73
  wire [4:0]  _slots_1_io_uop_ppred;	// issue-unit.scala:153:73
  wire        _slots_1_io_uop_prs1_busy;	// issue-unit.scala:153:73
  wire        _slots_1_io_uop_prs2_busy;	// issue-unit.scala:153:73
  wire        _slots_1_io_uop_prs3_busy;	// issue-unit.scala:153:73
  wire        _slots_1_io_uop_ppred_busy;	// issue-unit.scala:153:73
  wire [6:0]  _slots_1_io_uop_stale_pdst;	// issue-unit.scala:153:73
  wire        _slots_1_io_uop_exception;	// issue-unit.scala:153:73
  wire [63:0] _slots_1_io_uop_exc_cause;	// issue-unit.scala:153:73
  wire        _slots_1_io_uop_bypassable;	// issue-unit.scala:153:73
  wire [4:0]  _slots_1_io_uop_mem_cmd;	// issue-unit.scala:153:73
  wire [1:0]  _slots_1_io_uop_mem_size;	// issue-unit.scala:153:73
  wire        _slots_1_io_uop_mem_signed;	// issue-unit.scala:153:73
  wire        _slots_1_io_uop_is_fence;	// issue-unit.scala:153:73
  wire        _slots_1_io_uop_is_fencei;	// issue-unit.scala:153:73
  wire        _slots_1_io_uop_is_amo;	// issue-unit.scala:153:73
  wire        _slots_1_io_uop_uses_ldq;	// issue-unit.scala:153:73
  wire        _slots_1_io_uop_uses_stq;	// issue-unit.scala:153:73
  wire        _slots_1_io_uop_is_sys_pc2epc;	// issue-unit.scala:153:73
  wire        _slots_1_io_uop_is_unique;	// issue-unit.scala:153:73
  wire        _slots_1_io_uop_flush_on_commit;	// issue-unit.scala:153:73
  wire        _slots_1_io_uop_ldst_is_rs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_1_io_uop_ldst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_1_io_uop_lrs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_1_io_uop_lrs2;	// issue-unit.scala:153:73
  wire [5:0]  _slots_1_io_uop_lrs3;	// issue-unit.scala:153:73
  wire        _slots_1_io_uop_ldst_val;	// issue-unit.scala:153:73
  wire [1:0]  _slots_1_io_uop_dst_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_1_io_uop_lrs1_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_1_io_uop_lrs2_rtype;	// issue-unit.scala:153:73
  wire        _slots_1_io_uop_frs3_en;	// issue-unit.scala:153:73
  wire        _slots_1_io_uop_fp_val;	// issue-unit.scala:153:73
  wire        _slots_1_io_uop_fp_single;	// issue-unit.scala:153:73
  wire        _slots_1_io_uop_xcpt_pf_if;	// issue-unit.scala:153:73
  wire        _slots_1_io_uop_xcpt_ae_if;	// issue-unit.scala:153:73
  wire        _slots_1_io_uop_xcpt_ma_if;	// issue-unit.scala:153:73
  wire        _slots_1_io_uop_bp_debug_if;	// issue-unit.scala:153:73
  wire        _slots_1_io_uop_bp_xcpt_if;	// issue-unit.scala:153:73
  wire [1:0]  _slots_1_io_uop_debug_fsrc;	// issue-unit.scala:153:73
  wire [1:0]  _slots_1_io_uop_debug_tsrc;	// issue-unit.scala:153:73
  wire        _slots_0_io_valid;	// issue-unit.scala:153:73
  wire        _slots_0_io_will_be_valid;	// issue-unit.scala:153:73
  wire        _slots_0_io_request;	// issue-unit.scala:153:73
  wire [6:0]  _slots_0_io_uop_uopc;	// issue-unit.scala:153:73
  wire [31:0] _slots_0_io_uop_inst;	// issue-unit.scala:153:73
  wire [31:0] _slots_0_io_uop_debug_inst;	// issue-unit.scala:153:73
  wire        _slots_0_io_uop_is_rvc;	// issue-unit.scala:153:73
  wire [39:0] _slots_0_io_uop_debug_pc;	// issue-unit.scala:153:73
  wire [2:0]  _slots_0_io_uop_iq_type;	// issue-unit.scala:153:73
  wire [9:0]  _slots_0_io_uop_fu_code;	// issue-unit.scala:153:73
  wire [1:0]  _slots_0_io_uop_iw_state;	// issue-unit.scala:153:73
  wire        _slots_0_io_uop_is_br;	// issue-unit.scala:153:73
  wire        _slots_0_io_uop_is_jalr;	// issue-unit.scala:153:73
  wire        _slots_0_io_uop_is_jal;	// issue-unit.scala:153:73
  wire        _slots_0_io_uop_is_sfb;	// issue-unit.scala:153:73
  wire [11:0] _slots_0_io_uop_br_mask;	// issue-unit.scala:153:73
  wire [3:0]  _slots_0_io_uop_br_tag;	// issue-unit.scala:153:73
  wire [4:0]  _slots_0_io_uop_ftq_idx;	// issue-unit.scala:153:73
  wire        _slots_0_io_uop_edge_inst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_0_io_uop_pc_lob;	// issue-unit.scala:153:73
  wire        _slots_0_io_uop_taken;	// issue-unit.scala:153:73
  wire [19:0] _slots_0_io_uop_imm_packed;	// issue-unit.scala:153:73
  wire [11:0] _slots_0_io_uop_csr_addr;	// issue-unit.scala:153:73
  wire [5:0]  _slots_0_io_uop_rob_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_0_io_uop_ldq_idx;	// issue-unit.scala:153:73
  wire [3:0]  _slots_0_io_uop_stq_idx;	// issue-unit.scala:153:73
  wire [1:0]  _slots_0_io_uop_rxq_idx;	// issue-unit.scala:153:73
  wire [6:0]  _slots_0_io_uop_pdst;	// issue-unit.scala:153:73
  wire [6:0]  _slots_0_io_uop_prs1;	// issue-unit.scala:153:73
  wire [6:0]  _slots_0_io_uop_prs2;	// issue-unit.scala:153:73
  wire [6:0]  _slots_0_io_uop_prs3;	// issue-unit.scala:153:73
  wire [4:0]  _slots_0_io_uop_ppred;	// issue-unit.scala:153:73
  wire        _slots_0_io_uop_prs1_busy;	// issue-unit.scala:153:73
  wire        _slots_0_io_uop_prs2_busy;	// issue-unit.scala:153:73
  wire        _slots_0_io_uop_prs3_busy;	// issue-unit.scala:153:73
  wire        _slots_0_io_uop_ppred_busy;	// issue-unit.scala:153:73
  wire [6:0]  _slots_0_io_uop_stale_pdst;	// issue-unit.scala:153:73
  wire        _slots_0_io_uop_exception;	// issue-unit.scala:153:73
  wire [63:0] _slots_0_io_uop_exc_cause;	// issue-unit.scala:153:73
  wire        _slots_0_io_uop_bypassable;	// issue-unit.scala:153:73
  wire [4:0]  _slots_0_io_uop_mem_cmd;	// issue-unit.scala:153:73
  wire [1:0]  _slots_0_io_uop_mem_size;	// issue-unit.scala:153:73
  wire        _slots_0_io_uop_mem_signed;	// issue-unit.scala:153:73
  wire        _slots_0_io_uop_is_fence;	// issue-unit.scala:153:73
  wire        _slots_0_io_uop_is_fencei;	// issue-unit.scala:153:73
  wire        _slots_0_io_uop_is_amo;	// issue-unit.scala:153:73
  wire        _slots_0_io_uop_uses_ldq;	// issue-unit.scala:153:73
  wire        _slots_0_io_uop_uses_stq;	// issue-unit.scala:153:73
  wire        _slots_0_io_uop_is_sys_pc2epc;	// issue-unit.scala:153:73
  wire        _slots_0_io_uop_is_unique;	// issue-unit.scala:153:73
  wire        _slots_0_io_uop_flush_on_commit;	// issue-unit.scala:153:73
  wire        _slots_0_io_uop_ldst_is_rs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_0_io_uop_ldst;	// issue-unit.scala:153:73
  wire [5:0]  _slots_0_io_uop_lrs1;	// issue-unit.scala:153:73
  wire [5:0]  _slots_0_io_uop_lrs2;	// issue-unit.scala:153:73
  wire [5:0]  _slots_0_io_uop_lrs3;	// issue-unit.scala:153:73
  wire        _slots_0_io_uop_ldst_val;	// issue-unit.scala:153:73
  wire [1:0]  _slots_0_io_uop_dst_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_0_io_uop_lrs1_rtype;	// issue-unit.scala:153:73
  wire [1:0]  _slots_0_io_uop_lrs2_rtype;	// issue-unit.scala:153:73
  wire        _slots_0_io_uop_frs3_en;	// issue-unit.scala:153:73
  wire        _slots_0_io_uop_fp_val;	// issue-unit.scala:153:73
  wire        _slots_0_io_uop_fp_single;	// issue-unit.scala:153:73
  wire        _slots_0_io_uop_xcpt_pf_if;	// issue-unit.scala:153:73
  wire        _slots_0_io_uop_xcpt_ae_if;	// issue-unit.scala:153:73
  wire        _slots_0_io_uop_xcpt_ma_if;	// issue-unit.scala:153:73
  wire        _slots_0_io_uop_bp_debug_if;	// issue-unit.scala:153:73
  wire        _slots_0_io_uop_bp_xcpt_if;	// issue-unit.scala:153:73
  wire [1:0]  _slots_0_io_uop_debug_fsrc;	// issue-unit.scala:153:73
  wire [1:0]  _slots_0_io_uop_debug_tsrc;	// issue-unit.scala:153:73
  wire        _GEN = io_dis_uops_0_bits_uopc == 7'h2;	// issue-unit.scala:138:38
  wire [1:0]  uops_16_lrs1_rtype = _GEN ? 2'h2 : io_dis_uops_0_bits_lrs1_rtype;	// issue-unit.scala:120:17, :138:{38,50}, :139:32
  wire        uops_16_prs1_busy = ~_GEN & io_dis_uops_0_bits_prs1_busy;	// issue-unit.scala:120:17, :138:{38,50}, :140:32
  wire        _GEN_0 = io_dis_uops_1_bits_uopc == 7'h2;	// issue-unit.scala:138:38
  `ifndef SYNTHESIS	// issue-unit.scala:172:10
    always @(posedge clock) begin	// issue-unit.scala:172:10
      if (~({1'h0,
             {1'h0,
              {1'h0, {1'h0, issue_slots_0_grant} + {1'h0, issue_slots_1_grant}}
                + {1'h0, {1'h0, issue_slots_2_grant} + {1'h0, issue_slots_3_grant}}}
               + {1'h0,
                  {1'h0, {1'h0, issue_slots_4_grant} + {1'h0, issue_slots_5_grant}}
                    + {1'h0, {1'h0, issue_slots_6_grant} + {1'h0, issue_slots_7_grant}}}}
            + {1'h0,
               {1'h0,
                {1'h0, {1'h0, issue_slots_8_grant} + {1'h0, issue_slots_9_grant}}
                  + {1'h0, {1'h0, issue_slots_10_grant} + {1'h0, issue_slots_11_grant}}}
                 + {1'h0,
                    {1'h0, {1'h0, issue_slots_12_grant} + {1'h0, issue_slots_13_grant}}
                      + {1'h0,
                         {1'h0, issue_slots_14_grant}
                           + {1'h0, issue_slots_15_grant}}}} < 5'h2 | reset)) begin	// Bitwise.scala:47:55, issue-unit-age-ordered.scala:118:{40,56}, issue-unit.scala:172:{10,51}
        if (`ASSERT_VERBOSE_COND_)	// issue-unit.scala:172:10
          $error("Assertion failed: [issue] window giving out too many grants.\n    at issue-unit.scala:172 assert (PopCount(issue_slots.map(s => s.grant)) <= issueWidth.U, \"[issue] window giving out too many grants.\")\n");	// issue-unit.scala:172:10
        if (`STOP_COND_)	// issue-unit.scala:172:10
          $fatal;	// issue-unit.scala:172:10
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  assign next_1 =
    _slots_0_io_valid & ~_slots_1_io_valid
      ? 2'h1
      : _slots_1_io_valid ? {1'h0, ~_slots_0_io_valid} : {~_slots_0_io_valid, 1'h0};	// issue-unit-age-ordered.scala:39:38, :44:11, :45:{29,37}, :46:13, :47:44, :48:13, issue-unit.scala:123:26, :153:73
  assign next_2 =
    next_1 == 2'h0 & ~_slots_2_io_valid
      ? 2'h1
      : next_1[1] | _slots_2_io_valid ? next_1 : {next_1[0], 1'h0};	// consts.scala:270:20, issue-unit-age-ordered.scala:39:38, :44:11, :45:{21,29,37}, :46:13, :47:{28,44}, :48:13, issue-unit.scala:123:26, :153:73
  assign next_3 =
    next_2 == 2'h0 & ~_slots_3_io_valid
      ? 2'h1
      : next_2[1] | _slots_3_io_valid ? next_2 : {next_2[0], 1'h0};	// consts.scala:270:20, issue-unit-age-ordered.scala:39:38, :44:11, :45:{21,29,37}, :46:13, :47:{28,44}, :48:13, issue-unit.scala:123:26, :153:73
  assign next_4 =
    next_3 == 2'h0 & ~_slots_4_io_valid
      ? 2'h1
      : next_3[1] | _slots_4_io_valid ? next_3 : {next_3[0], 1'h0};	// consts.scala:270:20, issue-unit-age-ordered.scala:39:38, :44:11, :45:{21,29,37}, :46:13, :47:{28,44}, :48:13, issue-unit.scala:123:26, :153:73
  assign next_5 =
    next_4 == 2'h0 & ~_slots_5_io_valid
      ? 2'h1
      : next_4[1] | _slots_5_io_valid ? next_4 : {next_4[0], 1'h0};	// consts.scala:270:20, issue-unit-age-ordered.scala:39:38, :44:11, :45:{21,29,37}, :46:13, :47:{28,44}, :48:13, issue-unit.scala:123:26, :153:73
  assign next_6 =
    next_5 == 2'h0 & ~_slots_6_io_valid
      ? 2'h1
      : next_5[1] | _slots_6_io_valid ? next_5 : {next_5[0], 1'h0};	// consts.scala:270:20, issue-unit-age-ordered.scala:39:38, :44:11, :45:{21,29,37}, :46:13, :47:{28,44}, :48:13, issue-unit.scala:123:26, :153:73
  assign next_7 =
    next_6 == 2'h0 & ~_slots_7_io_valid
      ? 2'h1
      : next_6[1] | _slots_7_io_valid ? next_6 : {next_6[0], 1'h0};	// consts.scala:270:20, issue-unit-age-ordered.scala:39:38, :44:11, :45:{21,29,37}, :46:13, :47:{28,44}, :48:13, issue-unit.scala:123:26, :153:73
  assign next_8 =
    next_7 == 2'h0 & ~_slots_8_io_valid
      ? 2'h1
      : next_7[1] | _slots_8_io_valid ? next_7 : {next_7[0], 1'h0};	// consts.scala:270:20, issue-unit-age-ordered.scala:39:38, :44:11, :45:{21,29,37}, :46:13, :47:{28,44}, :48:13, issue-unit.scala:123:26, :153:73
  assign next_9 =
    next_8 == 2'h0 & ~_slots_9_io_valid
      ? 2'h1
      : next_8[1] | _slots_9_io_valid ? next_8 : {next_8[0], 1'h0};	// consts.scala:270:20, issue-unit-age-ordered.scala:39:38, :44:11, :45:{21,29,37}, :46:13, :47:{28,44}, :48:13, issue-unit.scala:123:26, :153:73
  assign next_10 =
    next_9 == 2'h0 & ~_slots_10_io_valid
      ? 2'h1
      : next_9[1] | _slots_10_io_valid ? next_9 : {next_9[0], 1'h0};	// consts.scala:270:20, issue-unit-age-ordered.scala:39:38, :44:11, :45:{21,29,37}, :46:13, :47:{28,44}, :48:13, issue-unit.scala:123:26, :153:73
  assign next_11 =
    next_10 == 2'h0 & ~_slots_11_io_valid
      ? 2'h1
      : next_10[1] | _slots_11_io_valid ? next_10 : {next_10[0], 1'h0};	// consts.scala:270:20, issue-unit-age-ordered.scala:39:38, :44:11, :45:{21,29,37}, :46:13, :47:{28,44}, :48:13, issue-unit.scala:123:26, :153:73
  assign next_12 =
    next_11 == 2'h0 & ~_slots_12_io_valid
      ? 2'h1
      : next_11[1] | _slots_12_io_valid ? next_11 : {next_11[0], 1'h0};	// consts.scala:270:20, issue-unit-age-ordered.scala:39:38, :44:11, :45:{21,29,37}, :46:13, :47:{28,44}, :48:13, issue-unit.scala:123:26, :153:73
  assign next_13 =
    next_12 == 2'h0 & ~_slots_13_io_valid
      ? 2'h1
      : next_12[1] | _slots_13_io_valid ? next_12 : {next_12[0], 1'h0};	// consts.scala:270:20, issue-unit-age-ordered.scala:39:38, :44:11, :45:{21,29,37}, :46:13, :47:{28,44}, :48:13, issue-unit.scala:123:26, :153:73
  assign next_14 =
    next_13 == 2'h0 & ~_slots_14_io_valid
      ? 2'h1
      : next_13[1] | _slots_14_io_valid ? next_13 : {next_13[0], 1'h0};	// consts.scala:270:20, issue-unit-age-ordered.scala:39:38, :44:11, :45:{21,29,37}, :46:13, :47:{28,44}, :48:13, issue-unit.scala:123:26, :153:73
  wire [1:0]  next_15 =
    next_14 == 2'h0 & ~_slots_15_io_valid
      ? 2'h1
      : next_14[1] | _slots_15_io_valid ? next_14 : {next_14[0], 1'h0};	// consts.scala:270:20, issue-unit-age-ordered.scala:39:38, :44:11, :45:{21,29,37}, :46:13, :47:{28,44}, :48:13, issue-unit.scala:123:26, :153:73
  wire        will_be_valid_16 =
    io_dis_uops_0_valid & ~io_dis_uops_0_bits_exception & ~io_dis_uops_0_bits_is_fence
    & ~io_dis_uops_0_bits_is_fencei;	// issue-unit-age-ordered.scala:62:57, :63:{57,79}, :64:57
  wire        _GEN_1 = next_1 == 2'h2;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :71:28, issue-unit.scala:139:32
  wire        issue_slots_0_in_uop_valid =
    _GEN_1 ? _slots_2_io_will_be_valid : ~_slots_0_io_valid & _slots_1_io_will_be_valid;	// issue-unit-age-ordered.scala:39:38, :68:33, :71:{28,48}, :72:37, issue-unit.scala:153:73
  wire        _GEN_2 = next_2 == 2'h2;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :71:28, issue-unit.scala:139:32
  wire        issue_slots_1_in_uop_valid =
    _GEN_2 ? _slots_3_io_will_be_valid : next_1 == 2'h1 & _slots_2_io_will_be_valid;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :68:33, :71:{28,48}, :72:37, issue-unit.scala:123:26, :153:73
  wire        _GEN_3 = next_3 == 2'h2;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :71:28, issue-unit.scala:139:32
  wire        issue_slots_2_in_uop_valid =
    _GEN_3 ? _slots_4_io_will_be_valid : next_2 == 2'h1 & _slots_3_io_will_be_valid;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :68:33, :71:{28,48}, :72:37, issue-unit.scala:123:26, :153:73
  wire        _GEN_4 = next_4 == 2'h2;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :71:28, issue-unit.scala:139:32
  wire        issue_slots_3_in_uop_valid =
    _GEN_4 ? _slots_5_io_will_be_valid : next_3 == 2'h1 & _slots_4_io_will_be_valid;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :68:33, :71:{28,48}, :72:37, issue-unit.scala:123:26, :153:73
  wire        _GEN_5 = next_5 == 2'h2;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :71:28, issue-unit.scala:139:32
  wire        issue_slots_4_in_uop_valid =
    _GEN_5 ? _slots_6_io_will_be_valid : next_4 == 2'h1 & _slots_5_io_will_be_valid;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :68:33, :71:{28,48}, :72:37, issue-unit.scala:123:26, :153:73
  wire        _GEN_6 = next_6 == 2'h2;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :71:28, issue-unit.scala:139:32
  wire        issue_slots_5_in_uop_valid =
    _GEN_6 ? _slots_7_io_will_be_valid : next_5 == 2'h1 & _slots_6_io_will_be_valid;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :68:33, :71:{28,48}, :72:37, issue-unit.scala:123:26, :153:73
  wire        _GEN_7 = next_7 == 2'h2;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :71:28, issue-unit.scala:139:32
  wire        issue_slots_6_in_uop_valid =
    _GEN_7 ? _slots_8_io_will_be_valid : next_6 == 2'h1 & _slots_7_io_will_be_valid;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :68:33, :71:{28,48}, :72:37, issue-unit.scala:123:26, :153:73
  wire        _GEN_8 = next_8 == 2'h2;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :71:28, issue-unit.scala:139:32
  wire        issue_slots_7_in_uop_valid =
    _GEN_8 ? _slots_9_io_will_be_valid : next_7 == 2'h1 & _slots_8_io_will_be_valid;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :68:33, :71:{28,48}, :72:37, issue-unit.scala:123:26, :153:73
  wire        _GEN_9 = next_9 == 2'h2;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :71:28, issue-unit.scala:139:32
  wire        issue_slots_8_in_uop_valid =
    _GEN_9 ? _slots_10_io_will_be_valid : next_8 == 2'h1 & _slots_9_io_will_be_valid;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :68:33, :71:{28,48}, :72:37, issue-unit.scala:123:26, :153:73
  wire        _GEN_10 = next_10 == 2'h2;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :71:28, issue-unit.scala:139:32
  wire        issue_slots_9_in_uop_valid =
    _GEN_10 ? _slots_11_io_will_be_valid : next_9 == 2'h1 & _slots_10_io_will_be_valid;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :68:33, :71:{28,48}, :72:37, issue-unit.scala:123:26, :153:73
  wire        _GEN_11 = next_11 == 2'h2;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :71:28, issue-unit.scala:139:32
  wire        issue_slots_10_in_uop_valid =
    _GEN_11 ? _slots_12_io_will_be_valid : next_10 == 2'h1 & _slots_11_io_will_be_valid;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :68:33, :71:{28,48}, :72:37, issue-unit.scala:123:26, :153:73
  wire        _GEN_12 = next_12 == 2'h2;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :71:28, issue-unit.scala:139:32
  wire        issue_slots_11_in_uop_valid =
    _GEN_12 ? _slots_13_io_will_be_valid : next_11 == 2'h1 & _slots_12_io_will_be_valid;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :68:33, :71:{28,48}, :72:37, issue-unit.scala:123:26, :153:73
  wire        _GEN_13 = next_13 == 2'h2;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :71:28, issue-unit.scala:139:32
  wire        issue_slots_12_in_uop_valid =
    _GEN_13 ? _slots_14_io_will_be_valid : next_12 == 2'h1 & _slots_13_io_will_be_valid;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :68:33, :71:{28,48}, :72:37, issue-unit.scala:123:26, :153:73
  wire        _GEN_14 = next_14 == 2'h2;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :71:28, issue-unit.scala:139:32
  wire        issue_slots_13_in_uop_valid =
    _GEN_14 ? _slots_15_io_will_be_valid : next_13 == 2'h1 & _slots_14_io_will_be_valid;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :68:33, :71:{28,48}, :72:37, issue-unit.scala:123:26, :153:73
  wire        _GEN_15 = next_15 == 2'h2;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :71:28, issue-unit.scala:139:32
  wire        issue_slots_14_in_uop_valid =
    _GEN_15 ? will_be_valid_16 : next_14 == 2'h1 & _slots_15_io_will_be_valid;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :63:79, :68:33, :71:{28,48}, :72:37, issue-unit.scala:123:26, :153:73
  wire        _GEN_16 =
    (next_15 == 2'h0 & ~io_dis_uops_0_valid
       ? 2'h1
       : next_15[1] | io_dis_uops_0_valid ? next_15 : {next_15[0], 1'h0}) == 2'h2;	// consts.scala:270:20, issue-unit-age-ordered.scala:39:82, :44:11, :45:{21,29,37}, :46:13, :47:{28,44}, :48:13, :71:28, issue-unit.scala:123:26, :139:32
  wire        issue_slots_15_in_uop_valid =
    _GEN_16
      ? io_dis_uops_1_valid & ~io_dis_uops_1_bits_exception & ~io_dis_uops_1_bits_is_fence
        & ~io_dis_uops_1_bits_is_fencei
      : next_15 == 2'h1 & will_be_valid_16;	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :62:57, :63:{57,79}, :64:57, :68:33, :71:{28,48}, :72:37, issue-unit.scala:123:26
  reg         io_dis_uops_0_ready_REG;	// issue-unit-age-ordered.scala:87:36
  reg         io_dis_uops_1_ready_REG;	// issue-unit-age-ordered.scala:87:36
  assign issue_slots_0_grant =
    _slots_0_io_request & (|(_slots_0_io_uop_fu_code & io_fu_types_0));	// issue-unit-age-ordered.scala:116:{54,72}, :118:40, issue-unit.scala:153:73
  wire        _GEN_17 =
    _slots_1_io_request & (|(_slots_1_io_uop_fu_code & io_fu_types_0));	// issue-unit-age-ordered.scala:116:{54,72}, :118:40, issue-unit.scala:153:73
  assign issue_slots_1_grant = _GEN_17 & ~issue_slots_0_grant;	// issue-unit-age-ordered.scala:118:{40,56,59}
  wire        _GEN_18 = _GEN_17 | issue_slots_0_grant;	// issue-unit-age-ordered.scala:118:40, :124:69
  wire        _GEN_19 =
    _slots_2_io_request & (|(_slots_2_io_uop_fu_code & io_fu_types_0));	// issue-unit-age-ordered.scala:116:{54,72}, :118:40, issue-unit.scala:153:73
  assign issue_slots_2_grant = _GEN_19 & ~_GEN_18;	// issue-unit-age-ordered.scala:118:{40,56,59}, :124:69
  wire        _GEN_20 = _GEN_19 | _GEN_18;	// issue-unit-age-ordered.scala:118:40, :124:69
  wire        _GEN_21 =
    _slots_3_io_request & (|(_slots_3_io_uop_fu_code & io_fu_types_0));	// issue-unit-age-ordered.scala:116:{54,72}, :118:40, issue-unit.scala:153:73
  assign issue_slots_3_grant = _GEN_21 & ~_GEN_20;	// issue-unit-age-ordered.scala:118:{40,56,59}, :124:69
  wire        _GEN_22 = _GEN_21 | _GEN_20;	// issue-unit-age-ordered.scala:118:40, :124:69
  wire        _GEN_23 =
    _slots_4_io_request & (|(_slots_4_io_uop_fu_code & io_fu_types_0));	// issue-unit-age-ordered.scala:116:{54,72}, :118:40, issue-unit.scala:153:73
  assign issue_slots_4_grant = _GEN_23 & ~_GEN_22;	// issue-unit-age-ordered.scala:118:{40,56,59}, :124:69
  wire        _GEN_24 = _GEN_23 | _GEN_22;	// issue-unit-age-ordered.scala:118:40, :124:69
  wire        _GEN_25 =
    _slots_5_io_request & (|(_slots_5_io_uop_fu_code & io_fu_types_0));	// issue-unit-age-ordered.scala:116:{54,72}, :118:40, issue-unit.scala:153:73
  assign issue_slots_5_grant = _GEN_25 & ~_GEN_24;	// issue-unit-age-ordered.scala:118:{40,56,59}, :124:69
  wire        _GEN_26 = _GEN_25 | _GEN_24;	// issue-unit-age-ordered.scala:118:40, :124:69
  wire        _GEN_27 =
    _slots_6_io_request & (|(_slots_6_io_uop_fu_code & io_fu_types_0));	// issue-unit-age-ordered.scala:116:{54,72}, :118:40, issue-unit.scala:153:73
  assign issue_slots_6_grant = _GEN_27 & ~_GEN_26;	// issue-unit-age-ordered.scala:118:{40,56,59}, :124:69
  wire        _GEN_28 = _GEN_27 | _GEN_26;	// issue-unit-age-ordered.scala:118:40, :124:69
  wire        _GEN_29 =
    _slots_7_io_request & (|(_slots_7_io_uop_fu_code & io_fu_types_0));	// issue-unit-age-ordered.scala:116:{54,72}, :118:40, issue-unit.scala:153:73
  assign issue_slots_7_grant = _GEN_29 & ~_GEN_28;	// issue-unit-age-ordered.scala:118:{40,56,59}, :124:69
  wire        _GEN_30 = _GEN_29 | _GEN_28;	// issue-unit-age-ordered.scala:118:40, :124:69
  wire        _GEN_31 =
    _slots_8_io_request & (|(_slots_8_io_uop_fu_code & io_fu_types_0));	// issue-unit-age-ordered.scala:116:{54,72}, :118:40, issue-unit.scala:153:73
  assign issue_slots_8_grant = _GEN_31 & ~_GEN_30;	// issue-unit-age-ordered.scala:118:{40,56,59}, :124:69
  wire        _GEN_32 = _GEN_31 | _GEN_30;	// issue-unit-age-ordered.scala:118:40, :124:69
  wire        _GEN_33 =
    _slots_9_io_request & (|(_slots_9_io_uop_fu_code & io_fu_types_0));	// issue-unit-age-ordered.scala:116:{54,72}, :118:40, issue-unit.scala:153:73
  assign issue_slots_9_grant = _GEN_33 & ~_GEN_32;	// issue-unit-age-ordered.scala:118:{40,56,59}, :124:69
  wire        _GEN_34 = _GEN_33 | _GEN_32;	// issue-unit-age-ordered.scala:118:40, :124:69
  wire        _GEN_35 =
    _slots_10_io_request & (|(_slots_10_io_uop_fu_code & io_fu_types_0));	// issue-unit-age-ordered.scala:116:{54,72}, :118:40, issue-unit.scala:153:73
  assign issue_slots_10_grant = _GEN_35 & ~_GEN_34;	// issue-unit-age-ordered.scala:118:{40,56,59}, :124:69
  wire        _GEN_36 = _GEN_35 | _GEN_34;	// issue-unit-age-ordered.scala:118:40, :124:69
  wire        _GEN_37 =
    _slots_11_io_request & (|(_slots_11_io_uop_fu_code & io_fu_types_0));	// issue-unit-age-ordered.scala:116:{54,72}, :118:40, issue-unit.scala:153:73
  assign issue_slots_11_grant = _GEN_37 & ~_GEN_36;	// issue-unit-age-ordered.scala:118:{40,56,59}, :124:69
  wire        _GEN_38 = _GEN_37 | _GEN_36;	// issue-unit-age-ordered.scala:118:40, :124:69
  wire        _GEN_39 =
    _slots_12_io_request & (|(_slots_12_io_uop_fu_code & io_fu_types_0));	// issue-unit-age-ordered.scala:116:{54,72}, :118:40, issue-unit.scala:153:73
  assign issue_slots_12_grant = _GEN_39 & ~_GEN_38;	// issue-unit-age-ordered.scala:118:{40,56,59}, :124:69
  wire        _GEN_40 = _GEN_39 | _GEN_38;	// issue-unit-age-ordered.scala:118:40, :124:69
  wire        _GEN_41 =
    _slots_13_io_request & (|(_slots_13_io_uop_fu_code & io_fu_types_0));	// issue-unit-age-ordered.scala:116:{54,72}, :118:40, issue-unit.scala:153:73
  assign issue_slots_13_grant = _GEN_41 & ~_GEN_40;	// issue-unit-age-ordered.scala:118:{40,56,59}, :124:69
  wire        _GEN_42 = _GEN_41 | _GEN_40;	// issue-unit-age-ordered.scala:118:40, :124:69
  wire        _GEN_43 =
    _slots_14_io_request & (|(_slots_14_io_uop_fu_code & io_fu_types_0));	// issue-unit-age-ordered.scala:116:{54,72}, :118:40, issue-unit.scala:153:73
  assign issue_slots_14_grant = _GEN_43 & ~_GEN_42;	// issue-unit-age-ordered.scala:118:{40,56,59}, :124:69
  assign issue_slots_15_grant =
    _slots_15_io_request & (|(_slots_15_io_uop_fu_code & io_fu_types_0))
    & ~(_GEN_43 | _GEN_42);	// issue-unit-age-ordered.scala:116:{54,72}, :118:{40,56,59}, :124:69, issue-unit.scala:153:73
  always @(posedge clock) begin
    automatic logic [4:0] num_available =
      {1'h0,
       {1'h0,
        {1'h0,
         {1'h0, ~_slots_0_io_will_be_valid & ~issue_slots_0_in_uop_valid}
           + {1'h0,
              (~_slots_1_io_will_be_valid | ~_slots_0_io_valid)
                & ~issue_slots_1_in_uop_valid}}
          + {1'h0,
             {1'h0,
              (~_slots_2_io_will_be_valid | (|next_1)) & ~issue_slots_2_in_uop_valid}
               + {1'h0,
                  (~_slots_3_io_will_be_valid | (|next_2))
                    & ~issue_slots_3_in_uop_valid}}}
         + {1'h0,
            {1'h0,
             {1'h0,
              (~_slots_4_io_will_be_valid | (|next_3)) & ~issue_slots_4_in_uop_valid}
               + {1'h0,
                  (~_slots_5_io_will_be_valid | (|next_4)) & ~issue_slots_5_in_uop_valid}}
              + {1'h0,
                 {1'h0,
                  (~_slots_6_io_will_be_valid | (|next_5)) & ~issue_slots_6_in_uop_valid}
                   + {1'h0,
                      (~_slots_7_io_will_be_valid | (|next_6))
                        & ~issue_slots_7_in_uop_valid}}}}
      + {1'h0,
         {1'h0,
          {1'h0,
           {1'h0, (~_slots_8_io_will_be_valid | (|next_7)) & ~issue_slots_8_in_uop_valid}
             + {1'h0,
                (~_slots_9_io_will_be_valid | (|next_8)) & ~issue_slots_9_in_uop_valid}}
            + {1'h0,
               {1'h0,
                (~_slots_10_io_will_be_valid | (|next_9)) & ~issue_slots_10_in_uop_valid}
                 + {1'h0,
                    (~_slots_11_io_will_be_valid | (|next_10))
                      & ~issue_slots_11_in_uop_valid}}}
           + {1'h0,
              {1'h0,
               {1'h0,
                (~_slots_12_io_will_be_valid | (|next_11)) & ~issue_slots_12_in_uop_valid}
                 + {1'h0,
                    (~_slots_13_io_will_be_valid | (|next_12))
                      & ~issue_slots_13_in_uop_valid}}
                + {1'h0,
                   {1'h0,
                    (~_slots_14_io_will_be_valid | (|next_13))
                      & ~issue_slots_14_in_uop_valid}
                     + {1'h0,
                        (~_slots_15_io_will_be_valid | (|next_14))
                          & ~issue_slots_15_in_uop_valid}}}};	// Bitwise.scala:47:55, issue-unit-age-ordered.scala:39:38, :45:37, :46:13, :47:44, :71:48, :72:37, :76:49, :84:{30,60,85,88}, issue-unit.scala:153:73
    io_dis_uops_0_ready_REG <= |num_available;	// Bitwise.scala:47:55, issue-unit-age-ordered.scala:87:{36,51}
    io_dis_uops_1_ready_REG <= |(num_available[4:1]);	// Bitwise.scala:47:55, issue-unit-age-ordered.scala:87:{36,51}
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:0];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        _RANDOM[/*Zero width*/ 1'b0] = `RANDOM;
        io_dis_uops_0_ready_REG = _RANDOM[/*Zero width*/ 1'b0][0];	// issue-unit-age-ordered.scala:87:36
        io_dis_uops_1_ready_REG = _RANDOM[/*Zero width*/ 1'b0][1];	// issue-unit-age-ordered.scala:87:36
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  IssueSlot_168 slots_0 (	// issue-unit.scala:153:73
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_0_grant),	// issue-unit-age-ordered.scala:118:40
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (1'h0),
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_in_uop_valid                (issue_slots_0_in_uop_valid),	// issue-unit-age-ordered.scala:71:48, :72:37
    .io_in_uop_bits_uopc
      (_GEN_1 ? _slots_2_io_out_uop_uopc : _slots_1_io_out_uop_uopc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_inst
      (_GEN_1 ? _slots_2_io_out_uop_inst : _slots_1_io_out_uop_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_inst
      (_GEN_1 ? _slots_2_io_out_uop_debug_inst : _slots_1_io_out_uop_debug_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_rvc
      (_GEN_1 ? _slots_2_io_out_uop_is_rvc : _slots_1_io_out_uop_is_rvc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_pc
      (_GEN_1 ? _slots_2_io_out_uop_debug_pc : _slots_1_io_out_uop_debug_pc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_iq_type
      (_GEN_1 ? _slots_2_io_out_uop_iq_type : _slots_1_io_out_uop_iq_type),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fu_code
      (_GEN_1 ? _slots_2_io_out_uop_fu_code : _slots_1_io_out_uop_fu_code),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_iw_state
      (_GEN_1 ? _slots_2_io_out_uop_iw_state : _slots_1_io_out_uop_iw_state),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_br
      (_GEN_1 ? _slots_2_io_out_uop_is_br : _slots_1_io_out_uop_is_br),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_jalr
      (_GEN_1 ? _slots_2_io_out_uop_is_jalr : _slots_1_io_out_uop_is_jalr),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_jal
      (_GEN_1 ? _slots_2_io_out_uop_is_jal : _slots_1_io_out_uop_is_jal),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_sfb
      (_GEN_1 ? _slots_2_io_out_uop_is_sfb : _slots_1_io_out_uop_is_sfb),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_br_mask
      (_GEN_1 ? _slots_2_io_out_uop_br_mask : _slots_1_io_out_uop_br_mask),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_br_tag
      (_GEN_1 ? _slots_2_io_out_uop_br_tag : _slots_1_io_out_uop_br_tag),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ftq_idx
      (_GEN_1 ? _slots_2_io_out_uop_ftq_idx : _slots_1_io_out_uop_ftq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_edge_inst
      (_GEN_1 ? _slots_2_io_out_uop_edge_inst : _slots_1_io_out_uop_edge_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_pc_lob
      (_GEN_1 ? _slots_2_io_out_uop_pc_lob : _slots_1_io_out_uop_pc_lob),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_taken
      (_GEN_1 ? _slots_2_io_out_uop_taken : _slots_1_io_out_uop_taken),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_imm_packed
      (_GEN_1 ? _slots_2_io_out_uop_imm_packed : _slots_1_io_out_uop_imm_packed),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_csr_addr
      (_GEN_1 ? _slots_2_io_out_uop_csr_addr : _slots_1_io_out_uop_csr_addr),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_rob_idx
      (_GEN_1 ? _slots_2_io_out_uop_rob_idx : _slots_1_io_out_uop_rob_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldq_idx
      (_GEN_1 ? _slots_2_io_out_uop_ldq_idx : _slots_1_io_out_uop_ldq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_stq_idx
      (_GEN_1 ? _slots_2_io_out_uop_stq_idx : _slots_1_io_out_uop_stq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_rxq_idx
      (_GEN_1 ? _slots_2_io_out_uop_rxq_idx : _slots_1_io_out_uop_rxq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_pdst
      (_GEN_1 ? _slots_2_io_out_uop_pdst : _slots_1_io_out_uop_pdst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs1
      (_GEN_1 ? _slots_2_io_out_uop_prs1 : _slots_1_io_out_uop_prs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs2
      (_GEN_1 ? _slots_2_io_out_uop_prs2 : _slots_1_io_out_uop_prs2),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs3
      (_GEN_1 ? _slots_2_io_out_uop_prs3 : _slots_1_io_out_uop_prs3),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ppred
      (_GEN_1 ? _slots_2_io_out_uop_ppred : _slots_1_io_out_uop_ppred),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs1_busy
      (_GEN_1 ? _slots_2_io_out_uop_prs1_busy : _slots_1_io_out_uop_prs1_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs2_busy
      (_GEN_1 ? _slots_2_io_out_uop_prs2_busy : _slots_1_io_out_uop_prs2_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs3_busy
      (_GEN_1 ? _slots_2_io_out_uop_prs3_busy : _slots_1_io_out_uop_prs3_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ppred_busy
      (_GEN_1 ? _slots_2_io_out_uop_ppred_busy : _slots_1_io_out_uop_ppred_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_stale_pdst
      (_GEN_1 ? _slots_2_io_out_uop_stale_pdst : _slots_1_io_out_uop_stale_pdst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_exception
      (_GEN_1 ? _slots_2_io_out_uop_exception : _slots_1_io_out_uop_exception),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_exc_cause
      (_GEN_1 ? _slots_2_io_out_uop_exc_cause : _slots_1_io_out_uop_exc_cause),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bypassable
      (_GEN_1 ? _slots_2_io_out_uop_bypassable : _slots_1_io_out_uop_bypassable),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_cmd
      (_GEN_1 ? _slots_2_io_out_uop_mem_cmd : _slots_1_io_out_uop_mem_cmd),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_size
      (_GEN_1 ? _slots_2_io_out_uop_mem_size : _slots_1_io_out_uop_mem_size),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_signed
      (_GEN_1 ? _slots_2_io_out_uop_mem_signed : _slots_1_io_out_uop_mem_signed),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_fence
      (_GEN_1 ? _slots_2_io_out_uop_is_fence : _slots_1_io_out_uop_is_fence),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_fencei
      (_GEN_1 ? _slots_2_io_out_uop_is_fencei : _slots_1_io_out_uop_is_fencei),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_amo
      (_GEN_1 ? _slots_2_io_out_uop_is_amo : _slots_1_io_out_uop_is_amo),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_uses_ldq
      (_GEN_1 ? _slots_2_io_out_uop_uses_ldq : _slots_1_io_out_uop_uses_ldq),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_uses_stq
      (_GEN_1 ? _slots_2_io_out_uop_uses_stq : _slots_1_io_out_uop_uses_stq),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_sys_pc2epc
      (_GEN_1 ? _slots_2_io_out_uop_is_sys_pc2epc : _slots_1_io_out_uop_is_sys_pc2epc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_unique
      (_GEN_1 ? _slots_2_io_out_uop_is_unique : _slots_1_io_out_uop_is_unique),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_flush_on_commit
      (_GEN_1
         ? _slots_2_io_out_uop_flush_on_commit
         : _slots_1_io_out_uop_flush_on_commit),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst_is_rs1
      (_GEN_1 ? _slots_2_io_out_uop_ldst_is_rs1 : _slots_1_io_out_uop_ldst_is_rs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst
      (_GEN_1 ? _slots_2_io_out_uop_ldst : _slots_1_io_out_uop_ldst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs1
      (_GEN_1 ? _slots_2_io_out_uop_lrs1 : _slots_1_io_out_uop_lrs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs2
      (_GEN_1 ? _slots_2_io_out_uop_lrs2 : _slots_1_io_out_uop_lrs2),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs3
      (_GEN_1 ? _slots_2_io_out_uop_lrs3 : _slots_1_io_out_uop_lrs3),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst_val
      (_GEN_1 ? _slots_2_io_out_uop_ldst_val : _slots_1_io_out_uop_ldst_val),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_dst_rtype
      (_GEN_1 ? _slots_2_io_out_uop_dst_rtype : _slots_1_io_out_uop_dst_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs1_rtype
      (_GEN_1 ? _slots_2_io_out_uop_lrs1_rtype : _slots_1_io_out_uop_lrs1_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs2_rtype
      (_GEN_1 ? _slots_2_io_out_uop_lrs2_rtype : _slots_1_io_out_uop_lrs2_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_frs3_en
      (_GEN_1 ? _slots_2_io_out_uop_frs3_en : _slots_1_io_out_uop_frs3_en),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fp_val
      (_GEN_1 ? _slots_2_io_out_uop_fp_val : _slots_1_io_out_uop_fp_val),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fp_single
      (_GEN_1 ? _slots_2_io_out_uop_fp_single : _slots_1_io_out_uop_fp_single),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_pf_if
      (_GEN_1 ? _slots_2_io_out_uop_xcpt_pf_if : _slots_1_io_out_uop_xcpt_pf_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_ae_if
      (_GEN_1 ? _slots_2_io_out_uop_xcpt_ae_if : _slots_1_io_out_uop_xcpt_ae_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_ma_if
      (_GEN_1 ? _slots_2_io_out_uop_xcpt_ma_if : _slots_1_io_out_uop_xcpt_ma_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bp_debug_if
      (_GEN_1 ? _slots_2_io_out_uop_bp_debug_if : _slots_1_io_out_uop_bp_debug_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bp_xcpt_if
      (_GEN_1 ? _slots_2_io_out_uop_bp_xcpt_if : _slots_1_io_out_uop_bp_xcpt_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_fsrc
      (_GEN_1 ? _slots_2_io_out_uop_debug_fsrc : _slots_1_io_out_uop_debug_fsrc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_tsrc
      (_GEN_1 ? _slots_2_io_out_uop_debug_tsrc : _slots_1_io_out_uop_debug_tsrc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_valid                       (_slots_0_io_valid),
    .io_will_be_valid               (_slots_0_io_will_be_valid),
    .io_request                     (_slots_0_io_request),
    .io_out_uop_uopc                (/* unused */),
    .io_out_uop_inst                (/* unused */),
    .io_out_uop_debug_inst          (/* unused */),
    .io_out_uop_is_rvc              (/* unused */),
    .io_out_uop_debug_pc            (/* unused */),
    .io_out_uop_iq_type             (/* unused */),
    .io_out_uop_fu_code             (/* unused */),
    .io_out_uop_iw_state            (/* unused */),
    .io_out_uop_is_br               (/* unused */),
    .io_out_uop_is_jalr             (/* unused */),
    .io_out_uop_is_jal              (/* unused */),
    .io_out_uop_is_sfb              (/* unused */),
    .io_out_uop_br_mask             (/* unused */),
    .io_out_uop_br_tag              (/* unused */),
    .io_out_uop_ftq_idx             (/* unused */),
    .io_out_uop_edge_inst           (/* unused */),
    .io_out_uop_pc_lob              (/* unused */),
    .io_out_uop_taken               (/* unused */),
    .io_out_uop_imm_packed          (/* unused */),
    .io_out_uop_csr_addr            (/* unused */),
    .io_out_uop_rob_idx             (/* unused */),
    .io_out_uop_ldq_idx             (/* unused */),
    .io_out_uop_stq_idx             (/* unused */),
    .io_out_uop_rxq_idx             (/* unused */),
    .io_out_uop_pdst                (/* unused */),
    .io_out_uop_prs1                (/* unused */),
    .io_out_uop_prs2                (/* unused */),
    .io_out_uop_prs3                (/* unused */),
    .io_out_uop_ppred               (/* unused */),
    .io_out_uop_prs1_busy           (/* unused */),
    .io_out_uop_prs2_busy           (/* unused */),
    .io_out_uop_prs3_busy           (/* unused */),
    .io_out_uop_ppred_busy          (/* unused */),
    .io_out_uop_stale_pdst          (/* unused */),
    .io_out_uop_exception           (/* unused */),
    .io_out_uop_exc_cause           (/* unused */),
    .io_out_uop_bypassable          (/* unused */),
    .io_out_uop_mem_cmd             (/* unused */),
    .io_out_uop_mem_size            (/* unused */),
    .io_out_uop_mem_signed          (/* unused */),
    .io_out_uop_is_fence            (/* unused */),
    .io_out_uop_is_fencei           (/* unused */),
    .io_out_uop_is_amo              (/* unused */),
    .io_out_uop_uses_ldq            (/* unused */),
    .io_out_uop_uses_stq            (/* unused */),
    .io_out_uop_is_sys_pc2epc       (/* unused */),
    .io_out_uop_is_unique           (/* unused */),
    .io_out_uop_flush_on_commit     (/* unused */),
    .io_out_uop_ldst_is_rs1         (/* unused */),
    .io_out_uop_ldst                (/* unused */),
    .io_out_uop_lrs1                (/* unused */),
    .io_out_uop_lrs2                (/* unused */),
    .io_out_uop_lrs3                (/* unused */),
    .io_out_uop_ldst_val            (/* unused */),
    .io_out_uop_dst_rtype           (/* unused */),
    .io_out_uop_lrs1_rtype          (/* unused */),
    .io_out_uop_lrs2_rtype          (/* unused */),
    .io_out_uop_frs3_en             (/* unused */),
    .io_out_uop_fp_val              (/* unused */),
    .io_out_uop_fp_single           (/* unused */),
    .io_out_uop_xcpt_pf_if          (/* unused */),
    .io_out_uop_xcpt_ae_if          (/* unused */),
    .io_out_uop_xcpt_ma_if          (/* unused */),
    .io_out_uop_bp_debug_if         (/* unused */),
    .io_out_uop_bp_xcpt_if          (/* unused */),
    .io_out_uop_debug_fsrc          (/* unused */),
    .io_out_uop_debug_tsrc          (/* unused */),
    .io_uop_uopc                    (_slots_0_io_uop_uopc),
    .io_uop_inst                    (_slots_0_io_uop_inst),
    .io_uop_debug_inst              (_slots_0_io_uop_debug_inst),
    .io_uop_is_rvc                  (_slots_0_io_uop_is_rvc),
    .io_uop_debug_pc                (_slots_0_io_uop_debug_pc),
    .io_uop_iq_type                 (_slots_0_io_uop_iq_type),
    .io_uop_fu_code                 (_slots_0_io_uop_fu_code),
    .io_uop_iw_state                (_slots_0_io_uop_iw_state),
    .io_uop_is_br                   (_slots_0_io_uop_is_br),
    .io_uop_is_jalr                 (_slots_0_io_uop_is_jalr),
    .io_uop_is_jal                  (_slots_0_io_uop_is_jal),
    .io_uop_is_sfb                  (_slots_0_io_uop_is_sfb),
    .io_uop_br_mask                 (_slots_0_io_uop_br_mask),
    .io_uop_br_tag                  (_slots_0_io_uop_br_tag),
    .io_uop_ftq_idx                 (_slots_0_io_uop_ftq_idx),
    .io_uop_edge_inst               (_slots_0_io_uop_edge_inst),
    .io_uop_pc_lob                  (_slots_0_io_uop_pc_lob),
    .io_uop_taken                   (_slots_0_io_uop_taken),
    .io_uop_imm_packed              (_slots_0_io_uop_imm_packed),
    .io_uop_csr_addr                (_slots_0_io_uop_csr_addr),
    .io_uop_rob_idx                 (_slots_0_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_0_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_0_io_uop_stq_idx),
    .io_uop_rxq_idx                 (_slots_0_io_uop_rxq_idx),
    .io_uop_pdst                    (_slots_0_io_uop_pdst),
    .io_uop_prs1                    (_slots_0_io_uop_prs1),
    .io_uop_prs2                    (_slots_0_io_uop_prs2),
    .io_uop_prs3                    (_slots_0_io_uop_prs3),
    .io_uop_ppred                   (_slots_0_io_uop_ppred),
    .io_uop_prs1_busy               (_slots_0_io_uop_prs1_busy),
    .io_uop_prs2_busy               (_slots_0_io_uop_prs2_busy),
    .io_uop_prs3_busy               (_slots_0_io_uop_prs3_busy),
    .io_uop_ppred_busy              (_slots_0_io_uop_ppred_busy),
    .io_uop_stale_pdst              (_slots_0_io_uop_stale_pdst),
    .io_uop_exception               (_slots_0_io_uop_exception),
    .io_uop_exc_cause               (_slots_0_io_uop_exc_cause),
    .io_uop_bypassable              (_slots_0_io_uop_bypassable),
    .io_uop_mem_cmd                 (_slots_0_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_0_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_0_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_0_io_uop_is_fence),
    .io_uop_is_fencei               (_slots_0_io_uop_is_fencei),
    .io_uop_is_amo                  (_slots_0_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_0_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_0_io_uop_uses_stq),
    .io_uop_is_sys_pc2epc           (_slots_0_io_uop_is_sys_pc2epc),
    .io_uop_is_unique               (_slots_0_io_uop_is_unique),
    .io_uop_flush_on_commit         (_slots_0_io_uop_flush_on_commit),
    .io_uop_ldst_is_rs1             (_slots_0_io_uop_ldst_is_rs1),
    .io_uop_ldst                    (_slots_0_io_uop_ldst),
    .io_uop_lrs1                    (_slots_0_io_uop_lrs1),
    .io_uop_lrs2                    (_slots_0_io_uop_lrs2),
    .io_uop_lrs3                    (_slots_0_io_uop_lrs3),
    .io_uop_ldst_val                (_slots_0_io_uop_ldst_val),
    .io_uop_dst_rtype               (_slots_0_io_uop_dst_rtype),
    .io_uop_lrs1_rtype              (_slots_0_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_0_io_uop_lrs2_rtype),
    .io_uop_frs3_en                 (_slots_0_io_uop_frs3_en),
    .io_uop_fp_val                  (_slots_0_io_uop_fp_val),
    .io_uop_fp_single               (_slots_0_io_uop_fp_single),
    .io_uop_xcpt_pf_if              (_slots_0_io_uop_xcpt_pf_if),
    .io_uop_xcpt_ae_if              (_slots_0_io_uop_xcpt_ae_if),
    .io_uop_xcpt_ma_if              (_slots_0_io_uop_xcpt_ma_if),
    .io_uop_bp_debug_if             (_slots_0_io_uop_bp_debug_if),
    .io_uop_bp_xcpt_if              (_slots_0_io_uop_bp_xcpt_if),
    .io_uop_debug_fsrc              (_slots_0_io_uop_debug_fsrc),
    .io_uop_debug_tsrc              (_slots_0_io_uop_debug_tsrc)
  );
  IssueSlot_168 slots_1 (	// issue-unit.scala:153:73
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_1_grant),	// issue-unit-age-ordered.scala:118:56
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (~_slots_0_io_valid),	// issue-unit-age-ordered.scala:39:38, issue-unit.scala:153:73
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_in_uop_valid                (issue_slots_1_in_uop_valid),	// issue-unit-age-ordered.scala:71:48, :72:37
    .io_in_uop_bits_uopc
      (_GEN_2 ? _slots_3_io_out_uop_uopc : _slots_2_io_out_uop_uopc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_inst
      (_GEN_2 ? _slots_3_io_out_uop_inst : _slots_2_io_out_uop_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_inst
      (_GEN_2 ? _slots_3_io_out_uop_debug_inst : _slots_2_io_out_uop_debug_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_rvc
      (_GEN_2 ? _slots_3_io_out_uop_is_rvc : _slots_2_io_out_uop_is_rvc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_pc
      (_GEN_2 ? _slots_3_io_out_uop_debug_pc : _slots_2_io_out_uop_debug_pc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_iq_type
      (_GEN_2 ? _slots_3_io_out_uop_iq_type : _slots_2_io_out_uop_iq_type),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fu_code
      (_GEN_2 ? _slots_3_io_out_uop_fu_code : _slots_2_io_out_uop_fu_code),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_iw_state
      (_GEN_2 ? _slots_3_io_out_uop_iw_state : _slots_2_io_out_uop_iw_state),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_br
      (_GEN_2 ? _slots_3_io_out_uop_is_br : _slots_2_io_out_uop_is_br),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_jalr
      (_GEN_2 ? _slots_3_io_out_uop_is_jalr : _slots_2_io_out_uop_is_jalr),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_jal
      (_GEN_2 ? _slots_3_io_out_uop_is_jal : _slots_2_io_out_uop_is_jal),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_sfb
      (_GEN_2 ? _slots_3_io_out_uop_is_sfb : _slots_2_io_out_uop_is_sfb),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_br_mask
      (_GEN_2 ? _slots_3_io_out_uop_br_mask : _slots_2_io_out_uop_br_mask),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_br_tag
      (_GEN_2 ? _slots_3_io_out_uop_br_tag : _slots_2_io_out_uop_br_tag),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ftq_idx
      (_GEN_2 ? _slots_3_io_out_uop_ftq_idx : _slots_2_io_out_uop_ftq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_edge_inst
      (_GEN_2 ? _slots_3_io_out_uop_edge_inst : _slots_2_io_out_uop_edge_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_pc_lob
      (_GEN_2 ? _slots_3_io_out_uop_pc_lob : _slots_2_io_out_uop_pc_lob),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_taken
      (_GEN_2 ? _slots_3_io_out_uop_taken : _slots_2_io_out_uop_taken),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_imm_packed
      (_GEN_2 ? _slots_3_io_out_uop_imm_packed : _slots_2_io_out_uop_imm_packed),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_csr_addr
      (_GEN_2 ? _slots_3_io_out_uop_csr_addr : _slots_2_io_out_uop_csr_addr),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_rob_idx
      (_GEN_2 ? _slots_3_io_out_uop_rob_idx : _slots_2_io_out_uop_rob_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldq_idx
      (_GEN_2 ? _slots_3_io_out_uop_ldq_idx : _slots_2_io_out_uop_ldq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_stq_idx
      (_GEN_2 ? _slots_3_io_out_uop_stq_idx : _slots_2_io_out_uop_stq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_rxq_idx
      (_GEN_2 ? _slots_3_io_out_uop_rxq_idx : _slots_2_io_out_uop_rxq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_pdst
      (_GEN_2 ? _slots_3_io_out_uop_pdst : _slots_2_io_out_uop_pdst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs1
      (_GEN_2 ? _slots_3_io_out_uop_prs1 : _slots_2_io_out_uop_prs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs2
      (_GEN_2 ? _slots_3_io_out_uop_prs2 : _slots_2_io_out_uop_prs2),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs3
      (_GEN_2 ? _slots_3_io_out_uop_prs3 : _slots_2_io_out_uop_prs3),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ppred
      (_GEN_2 ? _slots_3_io_out_uop_ppred : _slots_2_io_out_uop_ppred),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs1_busy
      (_GEN_2 ? _slots_3_io_out_uop_prs1_busy : _slots_2_io_out_uop_prs1_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs2_busy
      (_GEN_2 ? _slots_3_io_out_uop_prs2_busy : _slots_2_io_out_uop_prs2_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs3_busy
      (_GEN_2 ? _slots_3_io_out_uop_prs3_busy : _slots_2_io_out_uop_prs3_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ppred_busy
      (_GEN_2 ? _slots_3_io_out_uop_ppred_busy : _slots_2_io_out_uop_ppred_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_stale_pdst
      (_GEN_2 ? _slots_3_io_out_uop_stale_pdst : _slots_2_io_out_uop_stale_pdst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_exception
      (_GEN_2 ? _slots_3_io_out_uop_exception : _slots_2_io_out_uop_exception),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_exc_cause
      (_GEN_2 ? _slots_3_io_out_uop_exc_cause : _slots_2_io_out_uop_exc_cause),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bypassable
      (_GEN_2 ? _slots_3_io_out_uop_bypassable : _slots_2_io_out_uop_bypassable),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_cmd
      (_GEN_2 ? _slots_3_io_out_uop_mem_cmd : _slots_2_io_out_uop_mem_cmd),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_size
      (_GEN_2 ? _slots_3_io_out_uop_mem_size : _slots_2_io_out_uop_mem_size),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_signed
      (_GEN_2 ? _slots_3_io_out_uop_mem_signed : _slots_2_io_out_uop_mem_signed),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_fence
      (_GEN_2 ? _slots_3_io_out_uop_is_fence : _slots_2_io_out_uop_is_fence),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_fencei
      (_GEN_2 ? _slots_3_io_out_uop_is_fencei : _slots_2_io_out_uop_is_fencei),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_amo
      (_GEN_2 ? _slots_3_io_out_uop_is_amo : _slots_2_io_out_uop_is_amo),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_uses_ldq
      (_GEN_2 ? _slots_3_io_out_uop_uses_ldq : _slots_2_io_out_uop_uses_ldq),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_uses_stq
      (_GEN_2 ? _slots_3_io_out_uop_uses_stq : _slots_2_io_out_uop_uses_stq),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_sys_pc2epc
      (_GEN_2 ? _slots_3_io_out_uop_is_sys_pc2epc : _slots_2_io_out_uop_is_sys_pc2epc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_unique
      (_GEN_2 ? _slots_3_io_out_uop_is_unique : _slots_2_io_out_uop_is_unique),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_flush_on_commit
      (_GEN_2
         ? _slots_3_io_out_uop_flush_on_commit
         : _slots_2_io_out_uop_flush_on_commit),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst_is_rs1
      (_GEN_2 ? _slots_3_io_out_uop_ldst_is_rs1 : _slots_2_io_out_uop_ldst_is_rs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst
      (_GEN_2 ? _slots_3_io_out_uop_ldst : _slots_2_io_out_uop_ldst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs1
      (_GEN_2 ? _slots_3_io_out_uop_lrs1 : _slots_2_io_out_uop_lrs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs2
      (_GEN_2 ? _slots_3_io_out_uop_lrs2 : _slots_2_io_out_uop_lrs2),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs3
      (_GEN_2 ? _slots_3_io_out_uop_lrs3 : _slots_2_io_out_uop_lrs3),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst_val
      (_GEN_2 ? _slots_3_io_out_uop_ldst_val : _slots_2_io_out_uop_ldst_val),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_dst_rtype
      (_GEN_2 ? _slots_3_io_out_uop_dst_rtype : _slots_2_io_out_uop_dst_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs1_rtype
      (_GEN_2 ? _slots_3_io_out_uop_lrs1_rtype : _slots_2_io_out_uop_lrs1_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs2_rtype
      (_GEN_2 ? _slots_3_io_out_uop_lrs2_rtype : _slots_2_io_out_uop_lrs2_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_frs3_en
      (_GEN_2 ? _slots_3_io_out_uop_frs3_en : _slots_2_io_out_uop_frs3_en),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fp_val
      (_GEN_2 ? _slots_3_io_out_uop_fp_val : _slots_2_io_out_uop_fp_val),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fp_single
      (_GEN_2 ? _slots_3_io_out_uop_fp_single : _slots_2_io_out_uop_fp_single),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_pf_if
      (_GEN_2 ? _slots_3_io_out_uop_xcpt_pf_if : _slots_2_io_out_uop_xcpt_pf_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_ae_if
      (_GEN_2 ? _slots_3_io_out_uop_xcpt_ae_if : _slots_2_io_out_uop_xcpt_ae_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_ma_if
      (_GEN_2 ? _slots_3_io_out_uop_xcpt_ma_if : _slots_2_io_out_uop_xcpt_ma_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bp_debug_if
      (_GEN_2 ? _slots_3_io_out_uop_bp_debug_if : _slots_2_io_out_uop_bp_debug_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bp_xcpt_if
      (_GEN_2 ? _slots_3_io_out_uop_bp_xcpt_if : _slots_2_io_out_uop_bp_xcpt_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_fsrc
      (_GEN_2 ? _slots_3_io_out_uop_debug_fsrc : _slots_2_io_out_uop_debug_fsrc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_tsrc
      (_GEN_2 ? _slots_3_io_out_uop_debug_tsrc : _slots_2_io_out_uop_debug_tsrc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_valid                       (_slots_1_io_valid),
    .io_will_be_valid               (_slots_1_io_will_be_valid),
    .io_request                     (_slots_1_io_request),
    .io_out_uop_uopc                (_slots_1_io_out_uop_uopc),
    .io_out_uop_inst                (_slots_1_io_out_uop_inst),
    .io_out_uop_debug_inst          (_slots_1_io_out_uop_debug_inst),
    .io_out_uop_is_rvc              (_slots_1_io_out_uop_is_rvc),
    .io_out_uop_debug_pc            (_slots_1_io_out_uop_debug_pc),
    .io_out_uop_iq_type             (_slots_1_io_out_uop_iq_type),
    .io_out_uop_fu_code             (_slots_1_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_1_io_out_uop_iw_state),
    .io_out_uop_is_br               (_slots_1_io_out_uop_is_br),
    .io_out_uop_is_jalr             (_slots_1_io_out_uop_is_jalr),
    .io_out_uop_is_jal              (_slots_1_io_out_uop_is_jal),
    .io_out_uop_is_sfb              (_slots_1_io_out_uop_is_sfb),
    .io_out_uop_br_mask             (_slots_1_io_out_uop_br_mask),
    .io_out_uop_br_tag              (_slots_1_io_out_uop_br_tag),
    .io_out_uop_ftq_idx             (_slots_1_io_out_uop_ftq_idx),
    .io_out_uop_edge_inst           (_slots_1_io_out_uop_edge_inst),
    .io_out_uop_pc_lob              (_slots_1_io_out_uop_pc_lob),
    .io_out_uop_taken               (_slots_1_io_out_uop_taken),
    .io_out_uop_imm_packed          (_slots_1_io_out_uop_imm_packed),
    .io_out_uop_csr_addr            (_slots_1_io_out_uop_csr_addr),
    .io_out_uop_rob_idx             (_slots_1_io_out_uop_rob_idx),
    .io_out_uop_ldq_idx             (_slots_1_io_out_uop_ldq_idx),
    .io_out_uop_stq_idx             (_slots_1_io_out_uop_stq_idx),
    .io_out_uop_rxq_idx             (_slots_1_io_out_uop_rxq_idx),
    .io_out_uop_pdst                (_slots_1_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_1_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_1_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_1_io_out_uop_prs3),
    .io_out_uop_ppred               (_slots_1_io_out_uop_ppred),
    .io_out_uop_prs1_busy           (_slots_1_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_1_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_1_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_1_io_out_uop_ppred_busy),
    .io_out_uop_stale_pdst          (_slots_1_io_out_uop_stale_pdst),
    .io_out_uop_exception           (_slots_1_io_out_uop_exception),
    .io_out_uop_exc_cause           (_slots_1_io_out_uop_exc_cause),
    .io_out_uop_bypassable          (_slots_1_io_out_uop_bypassable),
    .io_out_uop_mem_cmd             (_slots_1_io_out_uop_mem_cmd),
    .io_out_uop_mem_size            (_slots_1_io_out_uop_mem_size),
    .io_out_uop_mem_signed          (_slots_1_io_out_uop_mem_signed),
    .io_out_uop_is_fence            (_slots_1_io_out_uop_is_fence),
    .io_out_uop_is_fencei           (_slots_1_io_out_uop_is_fencei),
    .io_out_uop_is_amo              (_slots_1_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_1_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_1_io_out_uop_uses_stq),
    .io_out_uop_is_sys_pc2epc       (_slots_1_io_out_uop_is_sys_pc2epc),
    .io_out_uop_is_unique           (_slots_1_io_out_uop_is_unique),
    .io_out_uop_flush_on_commit     (_slots_1_io_out_uop_flush_on_commit),
    .io_out_uop_ldst_is_rs1         (_slots_1_io_out_uop_ldst_is_rs1),
    .io_out_uop_ldst                (_slots_1_io_out_uop_ldst),
    .io_out_uop_lrs1                (_slots_1_io_out_uop_lrs1),
    .io_out_uop_lrs2                (_slots_1_io_out_uop_lrs2),
    .io_out_uop_lrs3                (_slots_1_io_out_uop_lrs3),
    .io_out_uop_ldst_val            (_slots_1_io_out_uop_ldst_val),
    .io_out_uop_dst_rtype           (_slots_1_io_out_uop_dst_rtype),
    .io_out_uop_lrs1_rtype          (_slots_1_io_out_uop_lrs1_rtype),
    .io_out_uop_lrs2_rtype          (_slots_1_io_out_uop_lrs2_rtype),
    .io_out_uop_frs3_en             (_slots_1_io_out_uop_frs3_en),
    .io_out_uop_fp_val              (_slots_1_io_out_uop_fp_val),
    .io_out_uop_fp_single           (_slots_1_io_out_uop_fp_single),
    .io_out_uop_xcpt_pf_if          (_slots_1_io_out_uop_xcpt_pf_if),
    .io_out_uop_xcpt_ae_if          (_slots_1_io_out_uop_xcpt_ae_if),
    .io_out_uop_xcpt_ma_if          (_slots_1_io_out_uop_xcpt_ma_if),
    .io_out_uop_bp_debug_if         (_slots_1_io_out_uop_bp_debug_if),
    .io_out_uop_bp_xcpt_if          (_slots_1_io_out_uop_bp_xcpt_if),
    .io_out_uop_debug_fsrc          (_slots_1_io_out_uop_debug_fsrc),
    .io_out_uop_debug_tsrc          (_slots_1_io_out_uop_debug_tsrc),
    .io_uop_uopc                    (_slots_1_io_uop_uopc),
    .io_uop_inst                    (_slots_1_io_uop_inst),
    .io_uop_debug_inst              (_slots_1_io_uop_debug_inst),
    .io_uop_is_rvc                  (_slots_1_io_uop_is_rvc),
    .io_uop_debug_pc                (_slots_1_io_uop_debug_pc),
    .io_uop_iq_type                 (_slots_1_io_uop_iq_type),
    .io_uop_fu_code                 (_slots_1_io_uop_fu_code),
    .io_uop_iw_state                (_slots_1_io_uop_iw_state),
    .io_uop_is_br                   (_slots_1_io_uop_is_br),
    .io_uop_is_jalr                 (_slots_1_io_uop_is_jalr),
    .io_uop_is_jal                  (_slots_1_io_uop_is_jal),
    .io_uop_is_sfb                  (_slots_1_io_uop_is_sfb),
    .io_uop_br_mask                 (_slots_1_io_uop_br_mask),
    .io_uop_br_tag                  (_slots_1_io_uop_br_tag),
    .io_uop_ftq_idx                 (_slots_1_io_uop_ftq_idx),
    .io_uop_edge_inst               (_slots_1_io_uop_edge_inst),
    .io_uop_pc_lob                  (_slots_1_io_uop_pc_lob),
    .io_uop_taken                   (_slots_1_io_uop_taken),
    .io_uop_imm_packed              (_slots_1_io_uop_imm_packed),
    .io_uop_csr_addr                (_slots_1_io_uop_csr_addr),
    .io_uop_rob_idx                 (_slots_1_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_1_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_1_io_uop_stq_idx),
    .io_uop_rxq_idx                 (_slots_1_io_uop_rxq_idx),
    .io_uop_pdst                    (_slots_1_io_uop_pdst),
    .io_uop_prs1                    (_slots_1_io_uop_prs1),
    .io_uop_prs2                    (_slots_1_io_uop_prs2),
    .io_uop_prs3                    (_slots_1_io_uop_prs3),
    .io_uop_ppred                   (_slots_1_io_uop_ppred),
    .io_uop_prs1_busy               (_slots_1_io_uop_prs1_busy),
    .io_uop_prs2_busy               (_slots_1_io_uop_prs2_busy),
    .io_uop_prs3_busy               (_slots_1_io_uop_prs3_busy),
    .io_uop_ppred_busy              (_slots_1_io_uop_ppred_busy),
    .io_uop_stale_pdst              (_slots_1_io_uop_stale_pdst),
    .io_uop_exception               (_slots_1_io_uop_exception),
    .io_uop_exc_cause               (_slots_1_io_uop_exc_cause),
    .io_uop_bypassable              (_slots_1_io_uop_bypassable),
    .io_uop_mem_cmd                 (_slots_1_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_1_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_1_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_1_io_uop_is_fence),
    .io_uop_is_fencei               (_slots_1_io_uop_is_fencei),
    .io_uop_is_amo                  (_slots_1_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_1_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_1_io_uop_uses_stq),
    .io_uop_is_sys_pc2epc           (_slots_1_io_uop_is_sys_pc2epc),
    .io_uop_is_unique               (_slots_1_io_uop_is_unique),
    .io_uop_flush_on_commit         (_slots_1_io_uop_flush_on_commit),
    .io_uop_ldst_is_rs1             (_slots_1_io_uop_ldst_is_rs1),
    .io_uop_ldst                    (_slots_1_io_uop_ldst),
    .io_uop_lrs1                    (_slots_1_io_uop_lrs1),
    .io_uop_lrs2                    (_slots_1_io_uop_lrs2),
    .io_uop_lrs3                    (_slots_1_io_uop_lrs3),
    .io_uop_ldst_val                (_slots_1_io_uop_ldst_val),
    .io_uop_dst_rtype               (_slots_1_io_uop_dst_rtype),
    .io_uop_lrs1_rtype              (_slots_1_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_1_io_uop_lrs2_rtype),
    .io_uop_frs3_en                 (_slots_1_io_uop_frs3_en),
    .io_uop_fp_val                  (_slots_1_io_uop_fp_val),
    .io_uop_fp_single               (_slots_1_io_uop_fp_single),
    .io_uop_xcpt_pf_if              (_slots_1_io_uop_xcpt_pf_if),
    .io_uop_xcpt_ae_if              (_slots_1_io_uop_xcpt_ae_if),
    .io_uop_xcpt_ma_if              (_slots_1_io_uop_xcpt_ma_if),
    .io_uop_bp_debug_if             (_slots_1_io_uop_bp_debug_if),
    .io_uop_bp_xcpt_if              (_slots_1_io_uop_bp_xcpt_if),
    .io_uop_debug_fsrc              (_slots_1_io_uop_debug_fsrc),
    .io_uop_debug_tsrc              (_slots_1_io_uop_debug_tsrc)
  );
  IssueSlot_168 slots_2 (	// issue-unit.scala:153:73
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_2_grant),	// issue-unit-age-ordered.scala:118:56
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|next_1),	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :76:49
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_in_uop_valid                (issue_slots_2_in_uop_valid),	// issue-unit-age-ordered.scala:71:48, :72:37
    .io_in_uop_bits_uopc
      (_GEN_3 ? _slots_4_io_out_uop_uopc : _slots_3_io_out_uop_uopc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_inst
      (_GEN_3 ? _slots_4_io_out_uop_inst : _slots_3_io_out_uop_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_inst
      (_GEN_3 ? _slots_4_io_out_uop_debug_inst : _slots_3_io_out_uop_debug_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_rvc
      (_GEN_3 ? _slots_4_io_out_uop_is_rvc : _slots_3_io_out_uop_is_rvc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_pc
      (_GEN_3 ? _slots_4_io_out_uop_debug_pc : _slots_3_io_out_uop_debug_pc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_iq_type
      (_GEN_3 ? _slots_4_io_out_uop_iq_type : _slots_3_io_out_uop_iq_type),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fu_code
      (_GEN_3 ? _slots_4_io_out_uop_fu_code : _slots_3_io_out_uop_fu_code),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_iw_state
      (_GEN_3 ? _slots_4_io_out_uop_iw_state : _slots_3_io_out_uop_iw_state),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_br
      (_GEN_3 ? _slots_4_io_out_uop_is_br : _slots_3_io_out_uop_is_br),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_jalr
      (_GEN_3 ? _slots_4_io_out_uop_is_jalr : _slots_3_io_out_uop_is_jalr),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_jal
      (_GEN_3 ? _slots_4_io_out_uop_is_jal : _slots_3_io_out_uop_is_jal),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_sfb
      (_GEN_3 ? _slots_4_io_out_uop_is_sfb : _slots_3_io_out_uop_is_sfb),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_br_mask
      (_GEN_3 ? _slots_4_io_out_uop_br_mask : _slots_3_io_out_uop_br_mask),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_br_tag
      (_GEN_3 ? _slots_4_io_out_uop_br_tag : _slots_3_io_out_uop_br_tag),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ftq_idx
      (_GEN_3 ? _slots_4_io_out_uop_ftq_idx : _slots_3_io_out_uop_ftq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_edge_inst
      (_GEN_3 ? _slots_4_io_out_uop_edge_inst : _slots_3_io_out_uop_edge_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_pc_lob
      (_GEN_3 ? _slots_4_io_out_uop_pc_lob : _slots_3_io_out_uop_pc_lob),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_taken
      (_GEN_3 ? _slots_4_io_out_uop_taken : _slots_3_io_out_uop_taken),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_imm_packed
      (_GEN_3 ? _slots_4_io_out_uop_imm_packed : _slots_3_io_out_uop_imm_packed),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_csr_addr
      (_GEN_3 ? _slots_4_io_out_uop_csr_addr : _slots_3_io_out_uop_csr_addr),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_rob_idx
      (_GEN_3 ? _slots_4_io_out_uop_rob_idx : _slots_3_io_out_uop_rob_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldq_idx
      (_GEN_3 ? _slots_4_io_out_uop_ldq_idx : _slots_3_io_out_uop_ldq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_stq_idx
      (_GEN_3 ? _slots_4_io_out_uop_stq_idx : _slots_3_io_out_uop_stq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_rxq_idx
      (_GEN_3 ? _slots_4_io_out_uop_rxq_idx : _slots_3_io_out_uop_rxq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_pdst
      (_GEN_3 ? _slots_4_io_out_uop_pdst : _slots_3_io_out_uop_pdst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs1
      (_GEN_3 ? _slots_4_io_out_uop_prs1 : _slots_3_io_out_uop_prs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs2
      (_GEN_3 ? _slots_4_io_out_uop_prs2 : _slots_3_io_out_uop_prs2),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs3
      (_GEN_3 ? _slots_4_io_out_uop_prs3 : _slots_3_io_out_uop_prs3),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ppred
      (_GEN_3 ? _slots_4_io_out_uop_ppred : _slots_3_io_out_uop_ppred),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs1_busy
      (_GEN_3 ? _slots_4_io_out_uop_prs1_busy : _slots_3_io_out_uop_prs1_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs2_busy
      (_GEN_3 ? _slots_4_io_out_uop_prs2_busy : _slots_3_io_out_uop_prs2_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs3_busy
      (_GEN_3 ? _slots_4_io_out_uop_prs3_busy : _slots_3_io_out_uop_prs3_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ppred_busy
      (_GEN_3 ? _slots_4_io_out_uop_ppred_busy : _slots_3_io_out_uop_ppred_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_stale_pdst
      (_GEN_3 ? _slots_4_io_out_uop_stale_pdst : _slots_3_io_out_uop_stale_pdst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_exception
      (_GEN_3 ? _slots_4_io_out_uop_exception : _slots_3_io_out_uop_exception),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_exc_cause
      (_GEN_3 ? _slots_4_io_out_uop_exc_cause : _slots_3_io_out_uop_exc_cause),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bypassable
      (_GEN_3 ? _slots_4_io_out_uop_bypassable : _slots_3_io_out_uop_bypassable),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_cmd
      (_GEN_3 ? _slots_4_io_out_uop_mem_cmd : _slots_3_io_out_uop_mem_cmd),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_size
      (_GEN_3 ? _slots_4_io_out_uop_mem_size : _slots_3_io_out_uop_mem_size),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_signed
      (_GEN_3 ? _slots_4_io_out_uop_mem_signed : _slots_3_io_out_uop_mem_signed),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_fence
      (_GEN_3 ? _slots_4_io_out_uop_is_fence : _slots_3_io_out_uop_is_fence),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_fencei
      (_GEN_3 ? _slots_4_io_out_uop_is_fencei : _slots_3_io_out_uop_is_fencei),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_amo
      (_GEN_3 ? _slots_4_io_out_uop_is_amo : _slots_3_io_out_uop_is_amo),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_uses_ldq
      (_GEN_3 ? _slots_4_io_out_uop_uses_ldq : _slots_3_io_out_uop_uses_ldq),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_uses_stq
      (_GEN_3 ? _slots_4_io_out_uop_uses_stq : _slots_3_io_out_uop_uses_stq),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_sys_pc2epc
      (_GEN_3 ? _slots_4_io_out_uop_is_sys_pc2epc : _slots_3_io_out_uop_is_sys_pc2epc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_unique
      (_GEN_3 ? _slots_4_io_out_uop_is_unique : _slots_3_io_out_uop_is_unique),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_flush_on_commit
      (_GEN_3
         ? _slots_4_io_out_uop_flush_on_commit
         : _slots_3_io_out_uop_flush_on_commit),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst_is_rs1
      (_GEN_3 ? _slots_4_io_out_uop_ldst_is_rs1 : _slots_3_io_out_uop_ldst_is_rs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst
      (_GEN_3 ? _slots_4_io_out_uop_ldst : _slots_3_io_out_uop_ldst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs1
      (_GEN_3 ? _slots_4_io_out_uop_lrs1 : _slots_3_io_out_uop_lrs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs2
      (_GEN_3 ? _slots_4_io_out_uop_lrs2 : _slots_3_io_out_uop_lrs2),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs3
      (_GEN_3 ? _slots_4_io_out_uop_lrs3 : _slots_3_io_out_uop_lrs3),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst_val
      (_GEN_3 ? _slots_4_io_out_uop_ldst_val : _slots_3_io_out_uop_ldst_val),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_dst_rtype
      (_GEN_3 ? _slots_4_io_out_uop_dst_rtype : _slots_3_io_out_uop_dst_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs1_rtype
      (_GEN_3 ? _slots_4_io_out_uop_lrs1_rtype : _slots_3_io_out_uop_lrs1_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs2_rtype
      (_GEN_3 ? _slots_4_io_out_uop_lrs2_rtype : _slots_3_io_out_uop_lrs2_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_frs3_en
      (_GEN_3 ? _slots_4_io_out_uop_frs3_en : _slots_3_io_out_uop_frs3_en),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fp_val
      (_GEN_3 ? _slots_4_io_out_uop_fp_val : _slots_3_io_out_uop_fp_val),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fp_single
      (_GEN_3 ? _slots_4_io_out_uop_fp_single : _slots_3_io_out_uop_fp_single),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_pf_if
      (_GEN_3 ? _slots_4_io_out_uop_xcpt_pf_if : _slots_3_io_out_uop_xcpt_pf_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_ae_if
      (_GEN_3 ? _slots_4_io_out_uop_xcpt_ae_if : _slots_3_io_out_uop_xcpt_ae_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_ma_if
      (_GEN_3 ? _slots_4_io_out_uop_xcpt_ma_if : _slots_3_io_out_uop_xcpt_ma_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bp_debug_if
      (_GEN_3 ? _slots_4_io_out_uop_bp_debug_if : _slots_3_io_out_uop_bp_debug_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bp_xcpt_if
      (_GEN_3 ? _slots_4_io_out_uop_bp_xcpt_if : _slots_3_io_out_uop_bp_xcpt_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_fsrc
      (_GEN_3 ? _slots_4_io_out_uop_debug_fsrc : _slots_3_io_out_uop_debug_fsrc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_tsrc
      (_GEN_3 ? _slots_4_io_out_uop_debug_tsrc : _slots_3_io_out_uop_debug_tsrc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_valid                       (_slots_2_io_valid),
    .io_will_be_valid               (_slots_2_io_will_be_valid),
    .io_request                     (_slots_2_io_request),
    .io_out_uop_uopc                (_slots_2_io_out_uop_uopc),
    .io_out_uop_inst                (_slots_2_io_out_uop_inst),
    .io_out_uop_debug_inst          (_slots_2_io_out_uop_debug_inst),
    .io_out_uop_is_rvc              (_slots_2_io_out_uop_is_rvc),
    .io_out_uop_debug_pc            (_slots_2_io_out_uop_debug_pc),
    .io_out_uop_iq_type             (_slots_2_io_out_uop_iq_type),
    .io_out_uop_fu_code             (_slots_2_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_2_io_out_uop_iw_state),
    .io_out_uop_is_br               (_slots_2_io_out_uop_is_br),
    .io_out_uop_is_jalr             (_slots_2_io_out_uop_is_jalr),
    .io_out_uop_is_jal              (_slots_2_io_out_uop_is_jal),
    .io_out_uop_is_sfb              (_slots_2_io_out_uop_is_sfb),
    .io_out_uop_br_mask             (_slots_2_io_out_uop_br_mask),
    .io_out_uop_br_tag              (_slots_2_io_out_uop_br_tag),
    .io_out_uop_ftq_idx             (_slots_2_io_out_uop_ftq_idx),
    .io_out_uop_edge_inst           (_slots_2_io_out_uop_edge_inst),
    .io_out_uop_pc_lob              (_slots_2_io_out_uop_pc_lob),
    .io_out_uop_taken               (_slots_2_io_out_uop_taken),
    .io_out_uop_imm_packed          (_slots_2_io_out_uop_imm_packed),
    .io_out_uop_csr_addr            (_slots_2_io_out_uop_csr_addr),
    .io_out_uop_rob_idx             (_slots_2_io_out_uop_rob_idx),
    .io_out_uop_ldq_idx             (_slots_2_io_out_uop_ldq_idx),
    .io_out_uop_stq_idx             (_slots_2_io_out_uop_stq_idx),
    .io_out_uop_rxq_idx             (_slots_2_io_out_uop_rxq_idx),
    .io_out_uop_pdst                (_slots_2_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_2_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_2_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_2_io_out_uop_prs3),
    .io_out_uop_ppred               (_slots_2_io_out_uop_ppred),
    .io_out_uop_prs1_busy           (_slots_2_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_2_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_2_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_2_io_out_uop_ppred_busy),
    .io_out_uop_stale_pdst          (_slots_2_io_out_uop_stale_pdst),
    .io_out_uop_exception           (_slots_2_io_out_uop_exception),
    .io_out_uop_exc_cause           (_slots_2_io_out_uop_exc_cause),
    .io_out_uop_bypassable          (_slots_2_io_out_uop_bypassable),
    .io_out_uop_mem_cmd             (_slots_2_io_out_uop_mem_cmd),
    .io_out_uop_mem_size            (_slots_2_io_out_uop_mem_size),
    .io_out_uop_mem_signed          (_slots_2_io_out_uop_mem_signed),
    .io_out_uop_is_fence            (_slots_2_io_out_uop_is_fence),
    .io_out_uop_is_fencei           (_slots_2_io_out_uop_is_fencei),
    .io_out_uop_is_amo              (_slots_2_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_2_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_2_io_out_uop_uses_stq),
    .io_out_uop_is_sys_pc2epc       (_slots_2_io_out_uop_is_sys_pc2epc),
    .io_out_uop_is_unique           (_slots_2_io_out_uop_is_unique),
    .io_out_uop_flush_on_commit     (_slots_2_io_out_uop_flush_on_commit),
    .io_out_uop_ldst_is_rs1         (_slots_2_io_out_uop_ldst_is_rs1),
    .io_out_uop_ldst                (_slots_2_io_out_uop_ldst),
    .io_out_uop_lrs1                (_slots_2_io_out_uop_lrs1),
    .io_out_uop_lrs2                (_slots_2_io_out_uop_lrs2),
    .io_out_uop_lrs3                (_slots_2_io_out_uop_lrs3),
    .io_out_uop_ldst_val            (_slots_2_io_out_uop_ldst_val),
    .io_out_uop_dst_rtype           (_slots_2_io_out_uop_dst_rtype),
    .io_out_uop_lrs1_rtype          (_slots_2_io_out_uop_lrs1_rtype),
    .io_out_uop_lrs2_rtype          (_slots_2_io_out_uop_lrs2_rtype),
    .io_out_uop_frs3_en             (_slots_2_io_out_uop_frs3_en),
    .io_out_uop_fp_val              (_slots_2_io_out_uop_fp_val),
    .io_out_uop_fp_single           (_slots_2_io_out_uop_fp_single),
    .io_out_uop_xcpt_pf_if          (_slots_2_io_out_uop_xcpt_pf_if),
    .io_out_uop_xcpt_ae_if          (_slots_2_io_out_uop_xcpt_ae_if),
    .io_out_uop_xcpt_ma_if          (_slots_2_io_out_uop_xcpt_ma_if),
    .io_out_uop_bp_debug_if         (_slots_2_io_out_uop_bp_debug_if),
    .io_out_uop_bp_xcpt_if          (_slots_2_io_out_uop_bp_xcpt_if),
    .io_out_uop_debug_fsrc          (_slots_2_io_out_uop_debug_fsrc),
    .io_out_uop_debug_tsrc          (_slots_2_io_out_uop_debug_tsrc),
    .io_uop_uopc                    (_slots_2_io_uop_uopc),
    .io_uop_inst                    (_slots_2_io_uop_inst),
    .io_uop_debug_inst              (_slots_2_io_uop_debug_inst),
    .io_uop_is_rvc                  (_slots_2_io_uop_is_rvc),
    .io_uop_debug_pc                (_slots_2_io_uop_debug_pc),
    .io_uop_iq_type                 (_slots_2_io_uop_iq_type),
    .io_uop_fu_code                 (_slots_2_io_uop_fu_code),
    .io_uop_iw_state                (_slots_2_io_uop_iw_state),
    .io_uop_is_br                   (_slots_2_io_uop_is_br),
    .io_uop_is_jalr                 (_slots_2_io_uop_is_jalr),
    .io_uop_is_jal                  (_slots_2_io_uop_is_jal),
    .io_uop_is_sfb                  (_slots_2_io_uop_is_sfb),
    .io_uop_br_mask                 (_slots_2_io_uop_br_mask),
    .io_uop_br_tag                  (_slots_2_io_uop_br_tag),
    .io_uop_ftq_idx                 (_slots_2_io_uop_ftq_idx),
    .io_uop_edge_inst               (_slots_2_io_uop_edge_inst),
    .io_uop_pc_lob                  (_slots_2_io_uop_pc_lob),
    .io_uop_taken                   (_slots_2_io_uop_taken),
    .io_uop_imm_packed              (_slots_2_io_uop_imm_packed),
    .io_uop_csr_addr                (_slots_2_io_uop_csr_addr),
    .io_uop_rob_idx                 (_slots_2_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_2_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_2_io_uop_stq_idx),
    .io_uop_rxq_idx                 (_slots_2_io_uop_rxq_idx),
    .io_uop_pdst                    (_slots_2_io_uop_pdst),
    .io_uop_prs1                    (_slots_2_io_uop_prs1),
    .io_uop_prs2                    (_slots_2_io_uop_prs2),
    .io_uop_prs3                    (_slots_2_io_uop_prs3),
    .io_uop_ppred                   (_slots_2_io_uop_ppred),
    .io_uop_prs1_busy               (_slots_2_io_uop_prs1_busy),
    .io_uop_prs2_busy               (_slots_2_io_uop_prs2_busy),
    .io_uop_prs3_busy               (_slots_2_io_uop_prs3_busy),
    .io_uop_ppred_busy              (_slots_2_io_uop_ppred_busy),
    .io_uop_stale_pdst              (_slots_2_io_uop_stale_pdst),
    .io_uop_exception               (_slots_2_io_uop_exception),
    .io_uop_exc_cause               (_slots_2_io_uop_exc_cause),
    .io_uop_bypassable              (_slots_2_io_uop_bypassable),
    .io_uop_mem_cmd                 (_slots_2_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_2_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_2_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_2_io_uop_is_fence),
    .io_uop_is_fencei               (_slots_2_io_uop_is_fencei),
    .io_uop_is_amo                  (_slots_2_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_2_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_2_io_uop_uses_stq),
    .io_uop_is_sys_pc2epc           (_slots_2_io_uop_is_sys_pc2epc),
    .io_uop_is_unique               (_slots_2_io_uop_is_unique),
    .io_uop_flush_on_commit         (_slots_2_io_uop_flush_on_commit),
    .io_uop_ldst_is_rs1             (_slots_2_io_uop_ldst_is_rs1),
    .io_uop_ldst                    (_slots_2_io_uop_ldst),
    .io_uop_lrs1                    (_slots_2_io_uop_lrs1),
    .io_uop_lrs2                    (_slots_2_io_uop_lrs2),
    .io_uop_lrs3                    (_slots_2_io_uop_lrs3),
    .io_uop_ldst_val                (_slots_2_io_uop_ldst_val),
    .io_uop_dst_rtype               (_slots_2_io_uop_dst_rtype),
    .io_uop_lrs1_rtype              (_slots_2_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_2_io_uop_lrs2_rtype),
    .io_uop_frs3_en                 (_slots_2_io_uop_frs3_en),
    .io_uop_fp_val                  (_slots_2_io_uop_fp_val),
    .io_uop_fp_single               (_slots_2_io_uop_fp_single),
    .io_uop_xcpt_pf_if              (_slots_2_io_uop_xcpt_pf_if),
    .io_uop_xcpt_ae_if              (_slots_2_io_uop_xcpt_ae_if),
    .io_uop_xcpt_ma_if              (_slots_2_io_uop_xcpt_ma_if),
    .io_uop_bp_debug_if             (_slots_2_io_uop_bp_debug_if),
    .io_uop_bp_xcpt_if              (_slots_2_io_uop_bp_xcpt_if),
    .io_uop_debug_fsrc              (_slots_2_io_uop_debug_fsrc),
    .io_uop_debug_tsrc              (_slots_2_io_uop_debug_tsrc)
  );
  IssueSlot_168 slots_3 (	// issue-unit.scala:153:73
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_3_grant),	// issue-unit-age-ordered.scala:118:56
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|next_2),	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :76:49
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_in_uop_valid                (issue_slots_3_in_uop_valid),	// issue-unit-age-ordered.scala:71:48, :72:37
    .io_in_uop_bits_uopc
      (_GEN_4 ? _slots_5_io_out_uop_uopc : _slots_4_io_out_uop_uopc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_inst
      (_GEN_4 ? _slots_5_io_out_uop_inst : _slots_4_io_out_uop_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_inst
      (_GEN_4 ? _slots_5_io_out_uop_debug_inst : _slots_4_io_out_uop_debug_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_rvc
      (_GEN_4 ? _slots_5_io_out_uop_is_rvc : _slots_4_io_out_uop_is_rvc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_pc
      (_GEN_4 ? _slots_5_io_out_uop_debug_pc : _slots_4_io_out_uop_debug_pc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_iq_type
      (_GEN_4 ? _slots_5_io_out_uop_iq_type : _slots_4_io_out_uop_iq_type),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fu_code
      (_GEN_4 ? _slots_5_io_out_uop_fu_code : _slots_4_io_out_uop_fu_code),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_iw_state
      (_GEN_4 ? _slots_5_io_out_uop_iw_state : _slots_4_io_out_uop_iw_state),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_br
      (_GEN_4 ? _slots_5_io_out_uop_is_br : _slots_4_io_out_uop_is_br),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_jalr
      (_GEN_4 ? _slots_5_io_out_uop_is_jalr : _slots_4_io_out_uop_is_jalr),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_jal
      (_GEN_4 ? _slots_5_io_out_uop_is_jal : _slots_4_io_out_uop_is_jal),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_sfb
      (_GEN_4 ? _slots_5_io_out_uop_is_sfb : _slots_4_io_out_uop_is_sfb),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_br_mask
      (_GEN_4 ? _slots_5_io_out_uop_br_mask : _slots_4_io_out_uop_br_mask),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_br_tag
      (_GEN_4 ? _slots_5_io_out_uop_br_tag : _slots_4_io_out_uop_br_tag),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ftq_idx
      (_GEN_4 ? _slots_5_io_out_uop_ftq_idx : _slots_4_io_out_uop_ftq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_edge_inst
      (_GEN_4 ? _slots_5_io_out_uop_edge_inst : _slots_4_io_out_uop_edge_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_pc_lob
      (_GEN_4 ? _slots_5_io_out_uop_pc_lob : _slots_4_io_out_uop_pc_lob),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_taken
      (_GEN_4 ? _slots_5_io_out_uop_taken : _slots_4_io_out_uop_taken),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_imm_packed
      (_GEN_4 ? _slots_5_io_out_uop_imm_packed : _slots_4_io_out_uop_imm_packed),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_csr_addr
      (_GEN_4 ? _slots_5_io_out_uop_csr_addr : _slots_4_io_out_uop_csr_addr),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_rob_idx
      (_GEN_4 ? _slots_5_io_out_uop_rob_idx : _slots_4_io_out_uop_rob_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldq_idx
      (_GEN_4 ? _slots_5_io_out_uop_ldq_idx : _slots_4_io_out_uop_ldq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_stq_idx
      (_GEN_4 ? _slots_5_io_out_uop_stq_idx : _slots_4_io_out_uop_stq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_rxq_idx
      (_GEN_4 ? _slots_5_io_out_uop_rxq_idx : _slots_4_io_out_uop_rxq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_pdst
      (_GEN_4 ? _slots_5_io_out_uop_pdst : _slots_4_io_out_uop_pdst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs1
      (_GEN_4 ? _slots_5_io_out_uop_prs1 : _slots_4_io_out_uop_prs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs2
      (_GEN_4 ? _slots_5_io_out_uop_prs2 : _slots_4_io_out_uop_prs2),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs3
      (_GEN_4 ? _slots_5_io_out_uop_prs3 : _slots_4_io_out_uop_prs3),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ppred
      (_GEN_4 ? _slots_5_io_out_uop_ppred : _slots_4_io_out_uop_ppred),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs1_busy
      (_GEN_4 ? _slots_5_io_out_uop_prs1_busy : _slots_4_io_out_uop_prs1_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs2_busy
      (_GEN_4 ? _slots_5_io_out_uop_prs2_busy : _slots_4_io_out_uop_prs2_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs3_busy
      (_GEN_4 ? _slots_5_io_out_uop_prs3_busy : _slots_4_io_out_uop_prs3_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ppred_busy
      (_GEN_4 ? _slots_5_io_out_uop_ppred_busy : _slots_4_io_out_uop_ppred_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_stale_pdst
      (_GEN_4 ? _slots_5_io_out_uop_stale_pdst : _slots_4_io_out_uop_stale_pdst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_exception
      (_GEN_4 ? _slots_5_io_out_uop_exception : _slots_4_io_out_uop_exception),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_exc_cause
      (_GEN_4 ? _slots_5_io_out_uop_exc_cause : _slots_4_io_out_uop_exc_cause),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bypassable
      (_GEN_4 ? _slots_5_io_out_uop_bypassable : _slots_4_io_out_uop_bypassable),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_cmd
      (_GEN_4 ? _slots_5_io_out_uop_mem_cmd : _slots_4_io_out_uop_mem_cmd),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_size
      (_GEN_4 ? _slots_5_io_out_uop_mem_size : _slots_4_io_out_uop_mem_size),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_signed
      (_GEN_4 ? _slots_5_io_out_uop_mem_signed : _slots_4_io_out_uop_mem_signed),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_fence
      (_GEN_4 ? _slots_5_io_out_uop_is_fence : _slots_4_io_out_uop_is_fence),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_fencei
      (_GEN_4 ? _slots_5_io_out_uop_is_fencei : _slots_4_io_out_uop_is_fencei),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_amo
      (_GEN_4 ? _slots_5_io_out_uop_is_amo : _slots_4_io_out_uop_is_amo),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_uses_ldq
      (_GEN_4 ? _slots_5_io_out_uop_uses_ldq : _slots_4_io_out_uop_uses_ldq),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_uses_stq
      (_GEN_4 ? _slots_5_io_out_uop_uses_stq : _slots_4_io_out_uop_uses_stq),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_sys_pc2epc
      (_GEN_4 ? _slots_5_io_out_uop_is_sys_pc2epc : _slots_4_io_out_uop_is_sys_pc2epc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_unique
      (_GEN_4 ? _slots_5_io_out_uop_is_unique : _slots_4_io_out_uop_is_unique),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_flush_on_commit
      (_GEN_4
         ? _slots_5_io_out_uop_flush_on_commit
         : _slots_4_io_out_uop_flush_on_commit),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst_is_rs1
      (_GEN_4 ? _slots_5_io_out_uop_ldst_is_rs1 : _slots_4_io_out_uop_ldst_is_rs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst
      (_GEN_4 ? _slots_5_io_out_uop_ldst : _slots_4_io_out_uop_ldst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs1
      (_GEN_4 ? _slots_5_io_out_uop_lrs1 : _slots_4_io_out_uop_lrs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs2
      (_GEN_4 ? _slots_5_io_out_uop_lrs2 : _slots_4_io_out_uop_lrs2),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs3
      (_GEN_4 ? _slots_5_io_out_uop_lrs3 : _slots_4_io_out_uop_lrs3),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst_val
      (_GEN_4 ? _slots_5_io_out_uop_ldst_val : _slots_4_io_out_uop_ldst_val),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_dst_rtype
      (_GEN_4 ? _slots_5_io_out_uop_dst_rtype : _slots_4_io_out_uop_dst_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs1_rtype
      (_GEN_4 ? _slots_5_io_out_uop_lrs1_rtype : _slots_4_io_out_uop_lrs1_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs2_rtype
      (_GEN_4 ? _slots_5_io_out_uop_lrs2_rtype : _slots_4_io_out_uop_lrs2_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_frs3_en
      (_GEN_4 ? _slots_5_io_out_uop_frs3_en : _slots_4_io_out_uop_frs3_en),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fp_val
      (_GEN_4 ? _slots_5_io_out_uop_fp_val : _slots_4_io_out_uop_fp_val),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fp_single
      (_GEN_4 ? _slots_5_io_out_uop_fp_single : _slots_4_io_out_uop_fp_single),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_pf_if
      (_GEN_4 ? _slots_5_io_out_uop_xcpt_pf_if : _slots_4_io_out_uop_xcpt_pf_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_ae_if
      (_GEN_4 ? _slots_5_io_out_uop_xcpt_ae_if : _slots_4_io_out_uop_xcpt_ae_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_ma_if
      (_GEN_4 ? _slots_5_io_out_uop_xcpt_ma_if : _slots_4_io_out_uop_xcpt_ma_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bp_debug_if
      (_GEN_4 ? _slots_5_io_out_uop_bp_debug_if : _slots_4_io_out_uop_bp_debug_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bp_xcpt_if
      (_GEN_4 ? _slots_5_io_out_uop_bp_xcpt_if : _slots_4_io_out_uop_bp_xcpt_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_fsrc
      (_GEN_4 ? _slots_5_io_out_uop_debug_fsrc : _slots_4_io_out_uop_debug_fsrc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_tsrc
      (_GEN_4 ? _slots_5_io_out_uop_debug_tsrc : _slots_4_io_out_uop_debug_tsrc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_valid                       (_slots_3_io_valid),
    .io_will_be_valid               (_slots_3_io_will_be_valid),
    .io_request                     (_slots_3_io_request),
    .io_out_uop_uopc                (_slots_3_io_out_uop_uopc),
    .io_out_uop_inst                (_slots_3_io_out_uop_inst),
    .io_out_uop_debug_inst          (_slots_3_io_out_uop_debug_inst),
    .io_out_uop_is_rvc              (_slots_3_io_out_uop_is_rvc),
    .io_out_uop_debug_pc            (_slots_3_io_out_uop_debug_pc),
    .io_out_uop_iq_type             (_slots_3_io_out_uop_iq_type),
    .io_out_uop_fu_code             (_slots_3_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_3_io_out_uop_iw_state),
    .io_out_uop_is_br               (_slots_3_io_out_uop_is_br),
    .io_out_uop_is_jalr             (_slots_3_io_out_uop_is_jalr),
    .io_out_uop_is_jal              (_slots_3_io_out_uop_is_jal),
    .io_out_uop_is_sfb              (_slots_3_io_out_uop_is_sfb),
    .io_out_uop_br_mask             (_slots_3_io_out_uop_br_mask),
    .io_out_uop_br_tag              (_slots_3_io_out_uop_br_tag),
    .io_out_uop_ftq_idx             (_slots_3_io_out_uop_ftq_idx),
    .io_out_uop_edge_inst           (_slots_3_io_out_uop_edge_inst),
    .io_out_uop_pc_lob              (_slots_3_io_out_uop_pc_lob),
    .io_out_uop_taken               (_slots_3_io_out_uop_taken),
    .io_out_uop_imm_packed          (_slots_3_io_out_uop_imm_packed),
    .io_out_uop_csr_addr            (_slots_3_io_out_uop_csr_addr),
    .io_out_uop_rob_idx             (_slots_3_io_out_uop_rob_idx),
    .io_out_uop_ldq_idx             (_slots_3_io_out_uop_ldq_idx),
    .io_out_uop_stq_idx             (_slots_3_io_out_uop_stq_idx),
    .io_out_uop_rxq_idx             (_slots_3_io_out_uop_rxq_idx),
    .io_out_uop_pdst                (_slots_3_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_3_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_3_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_3_io_out_uop_prs3),
    .io_out_uop_ppred               (_slots_3_io_out_uop_ppred),
    .io_out_uop_prs1_busy           (_slots_3_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_3_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_3_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_3_io_out_uop_ppred_busy),
    .io_out_uop_stale_pdst          (_slots_3_io_out_uop_stale_pdst),
    .io_out_uop_exception           (_slots_3_io_out_uop_exception),
    .io_out_uop_exc_cause           (_slots_3_io_out_uop_exc_cause),
    .io_out_uop_bypassable          (_slots_3_io_out_uop_bypassable),
    .io_out_uop_mem_cmd             (_slots_3_io_out_uop_mem_cmd),
    .io_out_uop_mem_size            (_slots_3_io_out_uop_mem_size),
    .io_out_uop_mem_signed          (_slots_3_io_out_uop_mem_signed),
    .io_out_uop_is_fence            (_slots_3_io_out_uop_is_fence),
    .io_out_uop_is_fencei           (_slots_3_io_out_uop_is_fencei),
    .io_out_uop_is_amo              (_slots_3_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_3_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_3_io_out_uop_uses_stq),
    .io_out_uop_is_sys_pc2epc       (_slots_3_io_out_uop_is_sys_pc2epc),
    .io_out_uop_is_unique           (_slots_3_io_out_uop_is_unique),
    .io_out_uop_flush_on_commit     (_slots_3_io_out_uop_flush_on_commit),
    .io_out_uop_ldst_is_rs1         (_slots_3_io_out_uop_ldst_is_rs1),
    .io_out_uop_ldst                (_slots_3_io_out_uop_ldst),
    .io_out_uop_lrs1                (_slots_3_io_out_uop_lrs1),
    .io_out_uop_lrs2                (_slots_3_io_out_uop_lrs2),
    .io_out_uop_lrs3                (_slots_3_io_out_uop_lrs3),
    .io_out_uop_ldst_val            (_slots_3_io_out_uop_ldst_val),
    .io_out_uop_dst_rtype           (_slots_3_io_out_uop_dst_rtype),
    .io_out_uop_lrs1_rtype          (_slots_3_io_out_uop_lrs1_rtype),
    .io_out_uop_lrs2_rtype          (_slots_3_io_out_uop_lrs2_rtype),
    .io_out_uop_frs3_en             (_slots_3_io_out_uop_frs3_en),
    .io_out_uop_fp_val              (_slots_3_io_out_uop_fp_val),
    .io_out_uop_fp_single           (_slots_3_io_out_uop_fp_single),
    .io_out_uop_xcpt_pf_if          (_slots_3_io_out_uop_xcpt_pf_if),
    .io_out_uop_xcpt_ae_if          (_slots_3_io_out_uop_xcpt_ae_if),
    .io_out_uop_xcpt_ma_if          (_slots_3_io_out_uop_xcpt_ma_if),
    .io_out_uop_bp_debug_if         (_slots_3_io_out_uop_bp_debug_if),
    .io_out_uop_bp_xcpt_if          (_slots_3_io_out_uop_bp_xcpt_if),
    .io_out_uop_debug_fsrc          (_slots_3_io_out_uop_debug_fsrc),
    .io_out_uop_debug_tsrc          (_slots_3_io_out_uop_debug_tsrc),
    .io_uop_uopc                    (_slots_3_io_uop_uopc),
    .io_uop_inst                    (_slots_3_io_uop_inst),
    .io_uop_debug_inst              (_slots_3_io_uop_debug_inst),
    .io_uop_is_rvc                  (_slots_3_io_uop_is_rvc),
    .io_uop_debug_pc                (_slots_3_io_uop_debug_pc),
    .io_uop_iq_type                 (_slots_3_io_uop_iq_type),
    .io_uop_fu_code                 (_slots_3_io_uop_fu_code),
    .io_uop_iw_state                (_slots_3_io_uop_iw_state),
    .io_uop_is_br                   (_slots_3_io_uop_is_br),
    .io_uop_is_jalr                 (_slots_3_io_uop_is_jalr),
    .io_uop_is_jal                  (_slots_3_io_uop_is_jal),
    .io_uop_is_sfb                  (_slots_3_io_uop_is_sfb),
    .io_uop_br_mask                 (_slots_3_io_uop_br_mask),
    .io_uop_br_tag                  (_slots_3_io_uop_br_tag),
    .io_uop_ftq_idx                 (_slots_3_io_uop_ftq_idx),
    .io_uop_edge_inst               (_slots_3_io_uop_edge_inst),
    .io_uop_pc_lob                  (_slots_3_io_uop_pc_lob),
    .io_uop_taken                   (_slots_3_io_uop_taken),
    .io_uop_imm_packed              (_slots_3_io_uop_imm_packed),
    .io_uop_csr_addr                (_slots_3_io_uop_csr_addr),
    .io_uop_rob_idx                 (_slots_3_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_3_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_3_io_uop_stq_idx),
    .io_uop_rxq_idx                 (_slots_3_io_uop_rxq_idx),
    .io_uop_pdst                    (_slots_3_io_uop_pdst),
    .io_uop_prs1                    (_slots_3_io_uop_prs1),
    .io_uop_prs2                    (_slots_3_io_uop_prs2),
    .io_uop_prs3                    (_slots_3_io_uop_prs3),
    .io_uop_ppred                   (_slots_3_io_uop_ppred),
    .io_uop_prs1_busy               (_slots_3_io_uop_prs1_busy),
    .io_uop_prs2_busy               (_slots_3_io_uop_prs2_busy),
    .io_uop_prs3_busy               (_slots_3_io_uop_prs3_busy),
    .io_uop_ppred_busy              (_slots_3_io_uop_ppred_busy),
    .io_uop_stale_pdst              (_slots_3_io_uop_stale_pdst),
    .io_uop_exception               (_slots_3_io_uop_exception),
    .io_uop_exc_cause               (_slots_3_io_uop_exc_cause),
    .io_uop_bypassable              (_slots_3_io_uop_bypassable),
    .io_uop_mem_cmd                 (_slots_3_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_3_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_3_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_3_io_uop_is_fence),
    .io_uop_is_fencei               (_slots_3_io_uop_is_fencei),
    .io_uop_is_amo                  (_slots_3_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_3_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_3_io_uop_uses_stq),
    .io_uop_is_sys_pc2epc           (_slots_3_io_uop_is_sys_pc2epc),
    .io_uop_is_unique               (_slots_3_io_uop_is_unique),
    .io_uop_flush_on_commit         (_slots_3_io_uop_flush_on_commit),
    .io_uop_ldst_is_rs1             (_slots_3_io_uop_ldst_is_rs1),
    .io_uop_ldst                    (_slots_3_io_uop_ldst),
    .io_uop_lrs1                    (_slots_3_io_uop_lrs1),
    .io_uop_lrs2                    (_slots_3_io_uop_lrs2),
    .io_uop_lrs3                    (_slots_3_io_uop_lrs3),
    .io_uop_ldst_val                (_slots_3_io_uop_ldst_val),
    .io_uop_dst_rtype               (_slots_3_io_uop_dst_rtype),
    .io_uop_lrs1_rtype              (_slots_3_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_3_io_uop_lrs2_rtype),
    .io_uop_frs3_en                 (_slots_3_io_uop_frs3_en),
    .io_uop_fp_val                  (_slots_3_io_uop_fp_val),
    .io_uop_fp_single               (_slots_3_io_uop_fp_single),
    .io_uop_xcpt_pf_if              (_slots_3_io_uop_xcpt_pf_if),
    .io_uop_xcpt_ae_if              (_slots_3_io_uop_xcpt_ae_if),
    .io_uop_xcpt_ma_if              (_slots_3_io_uop_xcpt_ma_if),
    .io_uop_bp_debug_if             (_slots_3_io_uop_bp_debug_if),
    .io_uop_bp_xcpt_if              (_slots_3_io_uop_bp_xcpt_if),
    .io_uop_debug_fsrc              (_slots_3_io_uop_debug_fsrc),
    .io_uop_debug_tsrc              (_slots_3_io_uop_debug_tsrc)
  );
  IssueSlot_168 slots_4 (	// issue-unit.scala:153:73
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_4_grant),	// issue-unit-age-ordered.scala:118:56
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|next_3),	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :76:49
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_in_uop_valid                (issue_slots_4_in_uop_valid),	// issue-unit-age-ordered.scala:71:48, :72:37
    .io_in_uop_bits_uopc
      (_GEN_5 ? _slots_6_io_out_uop_uopc : _slots_5_io_out_uop_uopc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_inst
      (_GEN_5 ? _slots_6_io_out_uop_inst : _slots_5_io_out_uop_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_inst
      (_GEN_5 ? _slots_6_io_out_uop_debug_inst : _slots_5_io_out_uop_debug_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_rvc
      (_GEN_5 ? _slots_6_io_out_uop_is_rvc : _slots_5_io_out_uop_is_rvc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_pc
      (_GEN_5 ? _slots_6_io_out_uop_debug_pc : _slots_5_io_out_uop_debug_pc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_iq_type
      (_GEN_5 ? _slots_6_io_out_uop_iq_type : _slots_5_io_out_uop_iq_type),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fu_code
      (_GEN_5 ? _slots_6_io_out_uop_fu_code : _slots_5_io_out_uop_fu_code),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_iw_state
      (_GEN_5 ? _slots_6_io_out_uop_iw_state : _slots_5_io_out_uop_iw_state),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_br
      (_GEN_5 ? _slots_6_io_out_uop_is_br : _slots_5_io_out_uop_is_br),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_jalr
      (_GEN_5 ? _slots_6_io_out_uop_is_jalr : _slots_5_io_out_uop_is_jalr),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_jal
      (_GEN_5 ? _slots_6_io_out_uop_is_jal : _slots_5_io_out_uop_is_jal),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_sfb
      (_GEN_5 ? _slots_6_io_out_uop_is_sfb : _slots_5_io_out_uop_is_sfb),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_br_mask
      (_GEN_5 ? _slots_6_io_out_uop_br_mask : _slots_5_io_out_uop_br_mask),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_br_tag
      (_GEN_5 ? _slots_6_io_out_uop_br_tag : _slots_5_io_out_uop_br_tag),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ftq_idx
      (_GEN_5 ? _slots_6_io_out_uop_ftq_idx : _slots_5_io_out_uop_ftq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_edge_inst
      (_GEN_5 ? _slots_6_io_out_uop_edge_inst : _slots_5_io_out_uop_edge_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_pc_lob
      (_GEN_5 ? _slots_6_io_out_uop_pc_lob : _slots_5_io_out_uop_pc_lob),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_taken
      (_GEN_5 ? _slots_6_io_out_uop_taken : _slots_5_io_out_uop_taken),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_imm_packed
      (_GEN_5 ? _slots_6_io_out_uop_imm_packed : _slots_5_io_out_uop_imm_packed),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_csr_addr
      (_GEN_5 ? _slots_6_io_out_uop_csr_addr : _slots_5_io_out_uop_csr_addr),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_rob_idx
      (_GEN_5 ? _slots_6_io_out_uop_rob_idx : _slots_5_io_out_uop_rob_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldq_idx
      (_GEN_5 ? _slots_6_io_out_uop_ldq_idx : _slots_5_io_out_uop_ldq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_stq_idx
      (_GEN_5 ? _slots_6_io_out_uop_stq_idx : _slots_5_io_out_uop_stq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_rxq_idx
      (_GEN_5 ? _slots_6_io_out_uop_rxq_idx : _slots_5_io_out_uop_rxq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_pdst
      (_GEN_5 ? _slots_6_io_out_uop_pdst : _slots_5_io_out_uop_pdst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs1
      (_GEN_5 ? _slots_6_io_out_uop_prs1 : _slots_5_io_out_uop_prs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs2
      (_GEN_5 ? _slots_6_io_out_uop_prs2 : _slots_5_io_out_uop_prs2),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs3
      (_GEN_5 ? _slots_6_io_out_uop_prs3 : _slots_5_io_out_uop_prs3),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ppred
      (_GEN_5 ? _slots_6_io_out_uop_ppred : _slots_5_io_out_uop_ppred),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs1_busy
      (_GEN_5 ? _slots_6_io_out_uop_prs1_busy : _slots_5_io_out_uop_prs1_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs2_busy
      (_GEN_5 ? _slots_6_io_out_uop_prs2_busy : _slots_5_io_out_uop_prs2_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs3_busy
      (_GEN_5 ? _slots_6_io_out_uop_prs3_busy : _slots_5_io_out_uop_prs3_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ppred_busy
      (_GEN_5 ? _slots_6_io_out_uop_ppred_busy : _slots_5_io_out_uop_ppred_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_stale_pdst
      (_GEN_5 ? _slots_6_io_out_uop_stale_pdst : _slots_5_io_out_uop_stale_pdst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_exception
      (_GEN_5 ? _slots_6_io_out_uop_exception : _slots_5_io_out_uop_exception),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_exc_cause
      (_GEN_5 ? _slots_6_io_out_uop_exc_cause : _slots_5_io_out_uop_exc_cause),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bypassable
      (_GEN_5 ? _slots_6_io_out_uop_bypassable : _slots_5_io_out_uop_bypassable),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_cmd
      (_GEN_5 ? _slots_6_io_out_uop_mem_cmd : _slots_5_io_out_uop_mem_cmd),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_size
      (_GEN_5 ? _slots_6_io_out_uop_mem_size : _slots_5_io_out_uop_mem_size),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_signed
      (_GEN_5 ? _slots_6_io_out_uop_mem_signed : _slots_5_io_out_uop_mem_signed),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_fence
      (_GEN_5 ? _slots_6_io_out_uop_is_fence : _slots_5_io_out_uop_is_fence),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_fencei
      (_GEN_5 ? _slots_6_io_out_uop_is_fencei : _slots_5_io_out_uop_is_fencei),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_amo
      (_GEN_5 ? _slots_6_io_out_uop_is_amo : _slots_5_io_out_uop_is_amo),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_uses_ldq
      (_GEN_5 ? _slots_6_io_out_uop_uses_ldq : _slots_5_io_out_uop_uses_ldq),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_uses_stq
      (_GEN_5 ? _slots_6_io_out_uop_uses_stq : _slots_5_io_out_uop_uses_stq),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_sys_pc2epc
      (_GEN_5 ? _slots_6_io_out_uop_is_sys_pc2epc : _slots_5_io_out_uop_is_sys_pc2epc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_unique
      (_GEN_5 ? _slots_6_io_out_uop_is_unique : _slots_5_io_out_uop_is_unique),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_flush_on_commit
      (_GEN_5
         ? _slots_6_io_out_uop_flush_on_commit
         : _slots_5_io_out_uop_flush_on_commit),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst_is_rs1
      (_GEN_5 ? _slots_6_io_out_uop_ldst_is_rs1 : _slots_5_io_out_uop_ldst_is_rs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst
      (_GEN_5 ? _slots_6_io_out_uop_ldst : _slots_5_io_out_uop_ldst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs1
      (_GEN_5 ? _slots_6_io_out_uop_lrs1 : _slots_5_io_out_uop_lrs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs2
      (_GEN_5 ? _slots_6_io_out_uop_lrs2 : _slots_5_io_out_uop_lrs2),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs3
      (_GEN_5 ? _slots_6_io_out_uop_lrs3 : _slots_5_io_out_uop_lrs3),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst_val
      (_GEN_5 ? _slots_6_io_out_uop_ldst_val : _slots_5_io_out_uop_ldst_val),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_dst_rtype
      (_GEN_5 ? _slots_6_io_out_uop_dst_rtype : _slots_5_io_out_uop_dst_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs1_rtype
      (_GEN_5 ? _slots_6_io_out_uop_lrs1_rtype : _slots_5_io_out_uop_lrs1_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs2_rtype
      (_GEN_5 ? _slots_6_io_out_uop_lrs2_rtype : _slots_5_io_out_uop_lrs2_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_frs3_en
      (_GEN_5 ? _slots_6_io_out_uop_frs3_en : _slots_5_io_out_uop_frs3_en),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fp_val
      (_GEN_5 ? _slots_6_io_out_uop_fp_val : _slots_5_io_out_uop_fp_val),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fp_single
      (_GEN_5 ? _slots_6_io_out_uop_fp_single : _slots_5_io_out_uop_fp_single),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_pf_if
      (_GEN_5 ? _slots_6_io_out_uop_xcpt_pf_if : _slots_5_io_out_uop_xcpt_pf_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_ae_if
      (_GEN_5 ? _slots_6_io_out_uop_xcpt_ae_if : _slots_5_io_out_uop_xcpt_ae_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_ma_if
      (_GEN_5 ? _slots_6_io_out_uop_xcpt_ma_if : _slots_5_io_out_uop_xcpt_ma_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bp_debug_if
      (_GEN_5 ? _slots_6_io_out_uop_bp_debug_if : _slots_5_io_out_uop_bp_debug_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bp_xcpt_if
      (_GEN_5 ? _slots_6_io_out_uop_bp_xcpt_if : _slots_5_io_out_uop_bp_xcpt_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_fsrc
      (_GEN_5 ? _slots_6_io_out_uop_debug_fsrc : _slots_5_io_out_uop_debug_fsrc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_tsrc
      (_GEN_5 ? _slots_6_io_out_uop_debug_tsrc : _slots_5_io_out_uop_debug_tsrc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_valid                       (_slots_4_io_valid),
    .io_will_be_valid               (_slots_4_io_will_be_valid),
    .io_request                     (_slots_4_io_request),
    .io_out_uop_uopc                (_slots_4_io_out_uop_uopc),
    .io_out_uop_inst                (_slots_4_io_out_uop_inst),
    .io_out_uop_debug_inst          (_slots_4_io_out_uop_debug_inst),
    .io_out_uop_is_rvc              (_slots_4_io_out_uop_is_rvc),
    .io_out_uop_debug_pc            (_slots_4_io_out_uop_debug_pc),
    .io_out_uop_iq_type             (_slots_4_io_out_uop_iq_type),
    .io_out_uop_fu_code             (_slots_4_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_4_io_out_uop_iw_state),
    .io_out_uop_is_br               (_slots_4_io_out_uop_is_br),
    .io_out_uop_is_jalr             (_slots_4_io_out_uop_is_jalr),
    .io_out_uop_is_jal              (_slots_4_io_out_uop_is_jal),
    .io_out_uop_is_sfb              (_slots_4_io_out_uop_is_sfb),
    .io_out_uop_br_mask             (_slots_4_io_out_uop_br_mask),
    .io_out_uop_br_tag              (_slots_4_io_out_uop_br_tag),
    .io_out_uop_ftq_idx             (_slots_4_io_out_uop_ftq_idx),
    .io_out_uop_edge_inst           (_slots_4_io_out_uop_edge_inst),
    .io_out_uop_pc_lob              (_slots_4_io_out_uop_pc_lob),
    .io_out_uop_taken               (_slots_4_io_out_uop_taken),
    .io_out_uop_imm_packed          (_slots_4_io_out_uop_imm_packed),
    .io_out_uop_csr_addr            (_slots_4_io_out_uop_csr_addr),
    .io_out_uop_rob_idx             (_slots_4_io_out_uop_rob_idx),
    .io_out_uop_ldq_idx             (_slots_4_io_out_uop_ldq_idx),
    .io_out_uop_stq_idx             (_slots_4_io_out_uop_stq_idx),
    .io_out_uop_rxq_idx             (_slots_4_io_out_uop_rxq_idx),
    .io_out_uop_pdst                (_slots_4_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_4_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_4_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_4_io_out_uop_prs3),
    .io_out_uop_ppred               (_slots_4_io_out_uop_ppred),
    .io_out_uop_prs1_busy           (_slots_4_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_4_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_4_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_4_io_out_uop_ppred_busy),
    .io_out_uop_stale_pdst          (_slots_4_io_out_uop_stale_pdst),
    .io_out_uop_exception           (_slots_4_io_out_uop_exception),
    .io_out_uop_exc_cause           (_slots_4_io_out_uop_exc_cause),
    .io_out_uop_bypassable          (_slots_4_io_out_uop_bypassable),
    .io_out_uop_mem_cmd             (_slots_4_io_out_uop_mem_cmd),
    .io_out_uop_mem_size            (_slots_4_io_out_uop_mem_size),
    .io_out_uop_mem_signed          (_slots_4_io_out_uop_mem_signed),
    .io_out_uop_is_fence            (_slots_4_io_out_uop_is_fence),
    .io_out_uop_is_fencei           (_slots_4_io_out_uop_is_fencei),
    .io_out_uop_is_amo              (_slots_4_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_4_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_4_io_out_uop_uses_stq),
    .io_out_uop_is_sys_pc2epc       (_slots_4_io_out_uop_is_sys_pc2epc),
    .io_out_uop_is_unique           (_slots_4_io_out_uop_is_unique),
    .io_out_uop_flush_on_commit     (_slots_4_io_out_uop_flush_on_commit),
    .io_out_uop_ldst_is_rs1         (_slots_4_io_out_uop_ldst_is_rs1),
    .io_out_uop_ldst                (_slots_4_io_out_uop_ldst),
    .io_out_uop_lrs1                (_slots_4_io_out_uop_lrs1),
    .io_out_uop_lrs2                (_slots_4_io_out_uop_lrs2),
    .io_out_uop_lrs3                (_slots_4_io_out_uop_lrs3),
    .io_out_uop_ldst_val            (_slots_4_io_out_uop_ldst_val),
    .io_out_uop_dst_rtype           (_slots_4_io_out_uop_dst_rtype),
    .io_out_uop_lrs1_rtype          (_slots_4_io_out_uop_lrs1_rtype),
    .io_out_uop_lrs2_rtype          (_slots_4_io_out_uop_lrs2_rtype),
    .io_out_uop_frs3_en             (_slots_4_io_out_uop_frs3_en),
    .io_out_uop_fp_val              (_slots_4_io_out_uop_fp_val),
    .io_out_uop_fp_single           (_slots_4_io_out_uop_fp_single),
    .io_out_uop_xcpt_pf_if          (_slots_4_io_out_uop_xcpt_pf_if),
    .io_out_uop_xcpt_ae_if          (_slots_4_io_out_uop_xcpt_ae_if),
    .io_out_uop_xcpt_ma_if          (_slots_4_io_out_uop_xcpt_ma_if),
    .io_out_uop_bp_debug_if         (_slots_4_io_out_uop_bp_debug_if),
    .io_out_uop_bp_xcpt_if          (_slots_4_io_out_uop_bp_xcpt_if),
    .io_out_uop_debug_fsrc          (_slots_4_io_out_uop_debug_fsrc),
    .io_out_uop_debug_tsrc          (_slots_4_io_out_uop_debug_tsrc),
    .io_uop_uopc                    (_slots_4_io_uop_uopc),
    .io_uop_inst                    (_slots_4_io_uop_inst),
    .io_uop_debug_inst              (_slots_4_io_uop_debug_inst),
    .io_uop_is_rvc                  (_slots_4_io_uop_is_rvc),
    .io_uop_debug_pc                (_slots_4_io_uop_debug_pc),
    .io_uop_iq_type                 (_slots_4_io_uop_iq_type),
    .io_uop_fu_code                 (_slots_4_io_uop_fu_code),
    .io_uop_iw_state                (_slots_4_io_uop_iw_state),
    .io_uop_is_br                   (_slots_4_io_uop_is_br),
    .io_uop_is_jalr                 (_slots_4_io_uop_is_jalr),
    .io_uop_is_jal                  (_slots_4_io_uop_is_jal),
    .io_uop_is_sfb                  (_slots_4_io_uop_is_sfb),
    .io_uop_br_mask                 (_slots_4_io_uop_br_mask),
    .io_uop_br_tag                  (_slots_4_io_uop_br_tag),
    .io_uop_ftq_idx                 (_slots_4_io_uop_ftq_idx),
    .io_uop_edge_inst               (_slots_4_io_uop_edge_inst),
    .io_uop_pc_lob                  (_slots_4_io_uop_pc_lob),
    .io_uop_taken                   (_slots_4_io_uop_taken),
    .io_uop_imm_packed              (_slots_4_io_uop_imm_packed),
    .io_uop_csr_addr                (_slots_4_io_uop_csr_addr),
    .io_uop_rob_idx                 (_slots_4_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_4_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_4_io_uop_stq_idx),
    .io_uop_rxq_idx                 (_slots_4_io_uop_rxq_idx),
    .io_uop_pdst                    (_slots_4_io_uop_pdst),
    .io_uop_prs1                    (_slots_4_io_uop_prs1),
    .io_uop_prs2                    (_slots_4_io_uop_prs2),
    .io_uop_prs3                    (_slots_4_io_uop_prs3),
    .io_uop_ppred                   (_slots_4_io_uop_ppred),
    .io_uop_prs1_busy               (_slots_4_io_uop_prs1_busy),
    .io_uop_prs2_busy               (_slots_4_io_uop_prs2_busy),
    .io_uop_prs3_busy               (_slots_4_io_uop_prs3_busy),
    .io_uop_ppred_busy              (_slots_4_io_uop_ppred_busy),
    .io_uop_stale_pdst              (_slots_4_io_uop_stale_pdst),
    .io_uop_exception               (_slots_4_io_uop_exception),
    .io_uop_exc_cause               (_slots_4_io_uop_exc_cause),
    .io_uop_bypassable              (_slots_4_io_uop_bypassable),
    .io_uop_mem_cmd                 (_slots_4_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_4_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_4_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_4_io_uop_is_fence),
    .io_uop_is_fencei               (_slots_4_io_uop_is_fencei),
    .io_uop_is_amo                  (_slots_4_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_4_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_4_io_uop_uses_stq),
    .io_uop_is_sys_pc2epc           (_slots_4_io_uop_is_sys_pc2epc),
    .io_uop_is_unique               (_slots_4_io_uop_is_unique),
    .io_uop_flush_on_commit         (_slots_4_io_uop_flush_on_commit),
    .io_uop_ldst_is_rs1             (_slots_4_io_uop_ldst_is_rs1),
    .io_uop_ldst                    (_slots_4_io_uop_ldst),
    .io_uop_lrs1                    (_slots_4_io_uop_lrs1),
    .io_uop_lrs2                    (_slots_4_io_uop_lrs2),
    .io_uop_lrs3                    (_slots_4_io_uop_lrs3),
    .io_uop_ldst_val                (_slots_4_io_uop_ldst_val),
    .io_uop_dst_rtype               (_slots_4_io_uop_dst_rtype),
    .io_uop_lrs1_rtype              (_slots_4_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_4_io_uop_lrs2_rtype),
    .io_uop_frs3_en                 (_slots_4_io_uop_frs3_en),
    .io_uop_fp_val                  (_slots_4_io_uop_fp_val),
    .io_uop_fp_single               (_slots_4_io_uop_fp_single),
    .io_uop_xcpt_pf_if              (_slots_4_io_uop_xcpt_pf_if),
    .io_uop_xcpt_ae_if              (_slots_4_io_uop_xcpt_ae_if),
    .io_uop_xcpt_ma_if              (_slots_4_io_uop_xcpt_ma_if),
    .io_uop_bp_debug_if             (_slots_4_io_uop_bp_debug_if),
    .io_uop_bp_xcpt_if              (_slots_4_io_uop_bp_xcpt_if),
    .io_uop_debug_fsrc              (_slots_4_io_uop_debug_fsrc),
    .io_uop_debug_tsrc              (_slots_4_io_uop_debug_tsrc)
  );
  IssueSlot_168 slots_5 (	// issue-unit.scala:153:73
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_5_grant),	// issue-unit-age-ordered.scala:118:56
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|next_4),	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :76:49
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_in_uop_valid                (issue_slots_5_in_uop_valid),	// issue-unit-age-ordered.scala:71:48, :72:37
    .io_in_uop_bits_uopc
      (_GEN_6 ? _slots_7_io_out_uop_uopc : _slots_6_io_out_uop_uopc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_inst
      (_GEN_6 ? _slots_7_io_out_uop_inst : _slots_6_io_out_uop_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_inst
      (_GEN_6 ? _slots_7_io_out_uop_debug_inst : _slots_6_io_out_uop_debug_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_rvc
      (_GEN_6 ? _slots_7_io_out_uop_is_rvc : _slots_6_io_out_uop_is_rvc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_pc
      (_GEN_6 ? _slots_7_io_out_uop_debug_pc : _slots_6_io_out_uop_debug_pc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_iq_type
      (_GEN_6 ? _slots_7_io_out_uop_iq_type : _slots_6_io_out_uop_iq_type),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fu_code
      (_GEN_6 ? _slots_7_io_out_uop_fu_code : _slots_6_io_out_uop_fu_code),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_iw_state
      (_GEN_6 ? _slots_7_io_out_uop_iw_state : _slots_6_io_out_uop_iw_state),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_br
      (_GEN_6 ? _slots_7_io_out_uop_is_br : _slots_6_io_out_uop_is_br),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_jalr
      (_GEN_6 ? _slots_7_io_out_uop_is_jalr : _slots_6_io_out_uop_is_jalr),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_jal
      (_GEN_6 ? _slots_7_io_out_uop_is_jal : _slots_6_io_out_uop_is_jal),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_sfb
      (_GEN_6 ? _slots_7_io_out_uop_is_sfb : _slots_6_io_out_uop_is_sfb),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_br_mask
      (_GEN_6 ? _slots_7_io_out_uop_br_mask : _slots_6_io_out_uop_br_mask),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_br_tag
      (_GEN_6 ? _slots_7_io_out_uop_br_tag : _slots_6_io_out_uop_br_tag),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ftq_idx
      (_GEN_6 ? _slots_7_io_out_uop_ftq_idx : _slots_6_io_out_uop_ftq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_edge_inst
      (_GEN_6 ? _slots_7_io_out_uop_edge_inst : _slots_6_io_out_uop_edge_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_pc_lob
      (_GEN_6 ? _slots_7_io_out_uop_pc_lob : _slots_6_io_out_uop_pc_lob),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_taken
      (_GEN_6 ? _slots_7_io_out_uop_taken : _slots_6_io_out_uop_taken),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_imm_packed
      (_GEN_6 ? _slots_7_io_out_uop_imm_packed : _slots_6_io_out_uop_imm_packed),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_csr_addr
      (_GEN_6 ? _slots_7_io_out_uop_csr_addr : _slots_6_io_out_uop_csr_addr),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_rob_idx
      (_GEN_6 ? _slots_7_io_out_uop_rob_idx : _slots_6_io_out_uop_rob_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldq_idx
      (_GEN_6 ? _slots_7_io_out_uop_ldq_idx : _slots_6_io_out_uop_ldq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_stq_idx
      (_GEN_6 ? _slots_7_io_out_uop_stq_idx : _slots_6_io_out_uop_stq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_rxq_idx
      (_GEN_6 ? _slots_7_io_out_uop_rxq_idx : _slots_6_io_out_uop_rxq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_pdst
      (_GEN_6 ? _slots_7_io_out_uop_pdst : _slots_6_io_out_uop_pdst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs1
      (_GEN_6 ? _slots_7_io_out_uop_prs1 : _slots_6_io_out_uop_prs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs2
      (_GEN_6 ? _slots_7_io_out_uop_prs2 : _slots_6_io_out_uop_prs2),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs3
      (_GEN_6 ? _slots_7_io_out_uop_prs3 : _slots_6_io_out_uop_prs3),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ppred
      (_GEN_6 ? _slots_7_io_out_uop_ppred : _slots_6_io_out_uop_ppred),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs1_busy
      (_GEN_6 ? _slots_7_io_out_uop_prs1_busy : _slots_6_io_out_uop_prs1_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs2_busy
      (_GEN_6 ? _slots_7_io_out_uop_prs2_busy : _slots_6_io_out_uop_prs2_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs3_busy
      (_GEN_6 ? _slots_7_io_out_uop_prs3_busy : _slots_6_io_out_uop_prs3_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ppred_busy
      (_GEN_6 ? _slots_7_io_out_uop_ppred_busy : _slots_6_io_out_uop_ppred_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_stale_pdst
      (_GEN_6 ? _slots_7_io_out_uop_stale_pdst : _slots_6_io_out_uop_stale_pdst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_exception
      (_GEN_6 ? _slots_7_io_out_uop_exception : _slots_6_io_out_uop_exception),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_exc_cause
      (_GEN_6 ? _slots_7_io_out_uop_exc_cause : _slots_6_io_out_uop_exc_cause),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bypassable
      (_GEN_6 ? _slots_7_io_out_uop_bypassable : _slots_6_io_out_uop_bypassable),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_cmd
      (_GEN_6 ? _slots_7_io_out_uop_mem_cmd : _slots_6_io_out_uop_mem_cmd),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_size
      (_GEN_6 ? _slots_7_io_out_uop_mem_size : _slots_6_io_out_uop_mem_size),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_signed
      (_GEN_6 ? _slots_7_io_out_uop_mem_signed : _slots_6_io_out_uop_mem_signed),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_fence
      (_GEN_6 ? _slots_7_io_out_uop_is_fence : _slots_6_io_out_uop_is_fence),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_fencei
      (_GEN_6 ? _slots_7_io_out_uop_is_fencei : _slots_6_io_out_uop_is_fencei),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_amo
      (_GEN_6 ? _slots_7_io_out_uop_is_amo : _slots_6_io_out_uop_is_amo),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_uses_ldq
      (_GEN_6 ? _slots_7_io_out_uop_uses_ldq : _slots_6_io_out_uop_uses_ldq),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_uses_stq
      (_GEN_6 ? _slots_7_io_out_uop_uses_stq : _slots_6_io_out_uop_uses_stq),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_sys_pc2epc
      (_GEN_6 ? _slots_7_io_out_uop_is_sys_pc2epc : _slots_6_io_out_uop_is_sys_pc2epc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_unique
      (_GEN_6 ? _slots_7_io_out_uop_is_unique : _slots_6_io_out_uop_is_unique),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_flush_on_commit
      (_GEN_6
         ? _slots_7_io_out_uop_flush_on_commit
         : _slots_6_io_out_uop_flush_on_commit),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst_is_rs1
      (_GEN_6 ? _slots_7_io_out_uop_ldst_is_rs1 : _slots_6_io_out_uop_ldst_is_rs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst
      (_GEN_6 ? _slots_7_io_out_uop_ldst : _slots_6_io_out_uop_ldst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs1
      (_GEN_6 ? _slots_7_io_out_uop_lrs1 : _slots_6_io_out_uop_lrs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs2
      (_GEN_6 ? _slots_7_io_out_uop_lrs2 : _slots_6_io_out_uop_lrs2),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs3
      (_GEN_6 ? _slots_7_io_out_uop_lrs3 : _slots_6_io_out_uop_lrs3),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst_val
      (_GEN_6 ? _slots_7_io_out_uop_ldst_val : _slots_6_io_out_uop_ldst_val),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_dst_rtype
      (_GEN_6 ? _slots_7_io_out_uop_dst_rtype : _slots_6_io_out_uop_dst_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs1_rtype
      (_GEN_6 ? _slots_7_io_out_uop_lrs1_rtype : _slots_6_io_out_uop_lrs1_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs2_rtype
      (_GEN_6 ? _slots_7_io_out_uop_lrs2_rtype : _slots_6_io_out_uop_lrs2_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_frs3_en
      (_GEN_6 ? _slots_7_io_out_uop_frs3_en : _slots_6_io_out_uop_frs3_en),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fp_val
      (_GEN_6 ? _slots_7_io_out_uop_fp_val : _slots_6_io_out_uop_fp_val),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fp_single
      (_GEN_6 ? _slots_7_io_out_uop_fp_single : _slots_6_io_out_uop_fp_single),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_pf_if
      (_GEN_6 ? _slots_7_io_out_uop_xcpt_pf_if : _slots_6_io_out_uop_xcpt_pf_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_ae_if
      (_GEN_6 ? _slots_7_io_out_uop_xcpt_ae_if : _slots_6_io_out_uop_xcpt_ae_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_ma_if
      (_GEN_6 ? _slots_7_io_out_uop_xcpt_ma_if : _slots_6_io_out_uop_xcpt_ma_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bp_debug_if
      (_GEN_6 ? _slots_7_io_out_uop_bp_debug_if : _slots_6_io_out_uop_bp_debug_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bp_xcpt_if
      (_GEN_6 ? _slots_7_io_out_uop_bp_xcpt_if : _slots_6_io_out_uop_bp_xcpt_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_fsrc
      (_GEN_6 ? _slots_7_io_out_uop_debug_fsrc : _slots_6_io_out_uop_debug_fsrc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_tsrc
      (_GEN_6 ? _slots_7_io_out_uop_debug_tsrc : _slots_6_io_out_uop_debug_tsrc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_valid                       (_slots_5_io_valid),
    .io_will_be_valid               (_slots_5_io_will_be_valid),
    .io_request                     (_slots_5_io_request),
    .io_out_uop_uopc                (_slots_5_io_out_uop_uopc),
    .io_out_uop_inst                (_slots_5_io_out_uop_inst),
    .io_out_uop_debug_inst          (_slots_5_io_out_uop_debug_inst),
    .io_out_uop_is_rvc              (_slots_5_io_out_uop_is_rvc),
    .io_out_uop_debug_pc            (_slots_5_io_out_uop_debug_pc),
    .io_out_uop_iq_type             (_slots_5_io_out_uop_iq_type),
    .io_out_uop_fu_code             (_slots_5_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_5_io_out_uop_iw_state),
    .io_out_uop_is_br               (_slots_5_io_out_uop_is_br),
    .io_out_uop_is_jalr             (_slots_5_io_out_uop_is_jalr),
    .io_out_uop_is_jal              (_slots_5_io_out_uop_is_jal),
    .io_out_uop_is_sfb              (_slots_5_io_out_uop_is_sfb),
    .io_out_uop_br_mask             (_slots_5_io_out_uop_br_mask),
    .io_out_uop_br_tag              (_slots_5_io_out_uop_br_tag),
    .io_out_uop_ftq_idx             (_slots_5_io_out_uop_ftq_idx),
    .io_out_uop_edge_inst           (_slots_5_io_out_uop_edge_inst),
    .io_out_uop_pc_lob              (_slots_5_io_out_uop_pc_lob),
    .io_out_uop_taken               (_slots_5_io_out_uop_taken),
    .io_out_uop_imm_packed          (_slots_5_io_out_uop_imm_packed),
    .io_out_uop_csr_addr            (_slots_5_io_out_uop_csr_addr),
    .io_out_uop_rob_idx             (_slots_5_io_out_uop_rob_idx),
    .io_out_uop_ldq_idx             (_slots_5_io_out_uop_ldq_idx),
    .io_out_uop_stq_idx             (_slots_5_io_out_uop_stq_idx),
    .io_out_uop_rxq_idx             (_slots_5_io_out_uop_rxq_idx),
    .io_out_uop_pdst                (_slots_5_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_5_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_5_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_5_io_out_uop_prs3),
    .io_out_uop_ppred               (_slots_5_io_out_uop_ppred),
    .io_out_uop_prs1_busy           (_slots_5_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_5_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_5_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_5_io_out_uop_ppred_busy),
    .io_out_uop_stale_pdst          (_slots_5_io_out_uop_stale_pdst),
    .io_out_uop_exception           (_slots_5_io_out_uop_exception),
    .io_out_uop_exc_cause           (_slots_5_io_out_uop_exc_cause),
    .io_out_uop_bypassable          (_slots_5_io_out_uop_bypassable),
    .io_out_uop_mem_cmd             (_slots_5_io_out_uop_mem_cmd),
    .io_out_uop_mem_size            (_slots_5_io_out_uop_mem_size),
    .io_out_uop_mem_signed          (_slots_5_io_out_uop_mem_signed),
    .io_out_uop_is_fence            (_slots_5_io_out_uop_is_fence),
    .io_out_uop_is_fencei           (_slots_5_io_out_uop_is_fencei),
    .io_out_uop_is_amo              (_slots_5_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_5_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_5_io_out_uop_uses_stq),
    .io_out_uop_is_sys_pc2epc       (_slots_5_io_out_uop_is_sys_pc2epc),
    .io_out_uop_is_unique           (_slots_5_io_out_uop_is_unique),
    .io_out_uop_flush_on_commit     (_slots_5_io_out_uop_flush_on_commit),
    .io_out_uop_ldst_is_rs1         (_slots_5_io_out_uop_ldst_is_rs1),
    .io_out_uop_ldst                (_slots_5_io_out_uop_ldst),
    .io_out_uop_lrs1                (_slots_5_io_out_uop_lrs1),
    .io_out_uop_lrs2                (_slots_5_io_out_uop_lrs2),
    .io_out_uop_lrs3                (_slots_5_io_out_uop_lrs3),
    .io_out_uop_ldst_val            (_slots_5_io_out_uop_ldst_val),
    .io_out_uop_dst_rtype           (_slots_5_io_out_uop_dst_rtype),
    .io_out_uop_lrs1_rtype          (_slots_5_io_out_uop_lrs1_rtype),
    .io_out_uop_lrs2_rtype          (_slots_5_io_out_uop_lrs2_rtype),
    .io_out_uop_frs3_en             (_slots_5_io_out_uop_frs3_en),
    .io_out_uop_fp_val              (_slots_5_io_out_uop_fp_val),
    .io_out_uop_fp_single           (_slots_5_io_out_uop_fp_single),
    .io_out_uop_xcpt_pf_if          (_slots_5_io_out_uop_xcpt_pf_if),
    .io_out_uop_xcpt_ae_if          (_slots_5_io_out_uop_xcpt_ae_if),
    .io_out_uop_xcpt_ma_if          (_slots_5_io_out_uop_xcpt_ma_if),
    .io_out_uop_bp_debug_if         (_slots_5_io_out_uop_bp_debug_if),
    .io_out_uop_bp_xcpt_if          (_slots_5_io_out_uop_bp_xcpt_if),
    .io_out_uop_debug_fsrc          (_slots_5_io_out_uop_debug_fsrc),
    .io_out_uop_debug_tsrc          (_slots_5_io_out_uop_debug_tsrc),
    .io_uop_uopc                    (_slots_5_io_uop_uopc),
    .io_uop_inst                    (_slots_5_io_uop_inst),
    .io_uop_debug_inst              (_slots_5_io_uop_debug_inst),
    .io_uop_is_rvc                  (_slots_5_io_uop_is_rvc),
    .io_uop_debug_pc                (_slots_5_io_uop_debug_pc),
    .io_uop_iq_type                 (_slots_5_io_uop_iq_type),
    .io_uop_fu_code                 (_slots_5_io_uop_fu_code),
    .io_uop_iw_state                (_slots_5_io_uop_iw_state),
    .io_uop_is_br                   (_slots_5_io_uop_is_br),
    .io_uop_is_jalr                 (_slots_5_io_uop_is_jalr),
    .io_uop_is_jal                  (_slots_5_io_uop_is_jal),
    .io_uop_is_sfb                  (_slots_5_io_uop_is_sfb),
    .io_uop_br_mask                 (_slots_5_io_uop_br_mask),
    .io_uop_br_tag                  (_slots_5_io_uop_br_tag),
    .io_uop_ftq_idx                 (_slots_5_io_uop_ftq_idx),
    .io_uop_edge_inst               (_slots_5_io_uop_edge_inst),
    .io_uop_pc_lob                  (_slots_5_io_uop_pc_lob),
    .io_uop_taken                   (_slots_5_io_uop_taken),
    .io_uop_imm_packed              (_slots_5_io_uop_imm_packed),
    .io_uop_csr_addr                (_slots_5_io_uop_csr_addr),
    .io_uop_rob_idx                 (_slots_5_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_5_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_5_io_uop_stq_idx),
    .io_uop_rxq_idx                 (_slots_5_io_uop_rxq_idx),
    .io_uop_pdst                    (_slots_5_io_uop_pdst),
    .io_uop_prs1                    (_slots_5_io_uop_prs1),
    .io_uop_prs2                    (_slots_5_io_uop_prs2),
    .io_uop_prs3                    (_slots_5_io_uop_prs3),
    .io_uop_ppred                   (_slots_5_io_uop_ppred),
    .io_uop_prs1_busy               (_slots_5_io_uop_prs1_busy),
    .io_uop_prs2_busy               (_slots_5_io_uop_prs2_busy),
    .io_uop_prs3_busy               (_slots_5_io_uop_prs3_busy),
    .io_uop_ppred_busy              (_slots_5_io_uop_ppred_busy),
    .io_uop_stale_pdst              (_slots_5_io_uop_stale_pdst),
    .io_uop_exception               (_slots_5_io_uop_exception),
    .io_uop_exc_cause               (_slots_5_io_uop_exc_cause),
    .io_uop_bypassable              (_slots_5_io_uop_bypassable),
    .io_uop_mem_cmd                 (_slots_5_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_5_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_5_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_5_io_uop_is_fence),
    .io_uop_is_fencei               (_slots_5_io_uop_is_fencei),
    .io_uop_is_amo                  (_slots_5_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_5_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_5_io_uop_uses_stq),
    .io_uop_is_sys_pc2epc           (_slots_5_io_uop_is_sys_pc2epc),
    .io_uop_is_unique               (_slots_5_io_uop_is_unique),
    .io_uop_flush_on_commit         (_slots_5_io_uop_flush_on_commit),
    .io_uop_ldst_is_rs1             (_slots_5_io_uop_ldst_is_rs1),
    .io_uop_ldst                    (_slots_5_io_uop_ldst),
    .io_uop_lrs1                    (_slots_5_io_uop_lrs1),
    .io_uop_lrs2                    (_slots_5_io_uop_lrs2),
    .io_uop_lrs3                    (_slots_5_io_uop_lrs3),
    .io_uop_ldst_val                (_slots_5_io_uop_ldst_val),
    .io_uop_dst_rtype               (_slots_5_io_uop_dst_rtype),
    .io_uop_lrs1_rtype              (_slots_5_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_5_io_uop_lrs2_rtype),
    .io_uop_frs3_en                 (_slots_5_io_uop_frs3_en),
    .io_uop_fp_val                  (_slots_5_io_uop_fp_val),
    .io_uop_fp_single               (_slots_5_io_uop_fp_single),
    .io_uop_xcpt_pf_if              (_slots_5_io_uop_xcpt_pf_if),
    .io_uop_xcpt_ae_if              (_slots_5_io_uop_xcpt_ae_if),
    .io_uop_xcpt_ma_if              (_slots_5_io_uop_xcpt_ma_if),
    .io_uop_bp_debug_if             (_slots_5_io_uop_bp_debug_if),
    .io_uop_bp_xcpt_if              (_slots_5_io_uop_bp_xcpt_if),
    .io_uop_debug_fsrc              (_slots_5_io_uop_debug_fsrc),
    .io_uop_debug_tsrc              (_slots_5_io_uop_debug_tsrc)
  );
  IssueSlot_168 slots_6 (	// issue-unit.scala:153:73
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_6_grant),	// issue-unit-age-ordered.scala:118:56
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|next_5),	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :76:49
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_in_uop_valid                (issue_slots_6_in_uop_valid),	// issue-unit-age-ordered.scala:71:48, :72:37
    .io_in_uop_bits_uopc
      (_GEN_7 ? _slots_8_io_out_uop_uopc : _slots_7_io_out_uop_uopc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_inst
      (_GEN_7 ? _slots_8_io_out_uop_inst : _slots_7_io_out_uop_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_inst
      (_GEN_7 ? _slots_8_io_out_uop_debug_inst : _slots_7_io_out_uop_debug_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_rvc
      (_GEN_7 ? _slots_8_io_out_uop_is_rvc : _slots_7_io_out_uop_is_rvc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_pc
      (_GEN_7 ? _slots_8_io_out_uop_debug_pc : _slots_7_io_out_uop_debug_pc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_iq_type
      (_GEN_7 ? _slots_8_io_out_uop_iq_type : _slots_7_io_out_uop_iq_type),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fu_code
      (_GEN_7 ? _slots_8_io_out_uop_fu_code : _slots_7_io_out_uop_fu_code),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_iw_state
      (_GEN_7 ? _slots_8_io_out_uop_iw_state : _slots_7_io_out_uop_iw_state),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_br
      (_GEN_7 ? _slots_8_io_out_uop_is_br : _slots_7_io_out_uop_is_br),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_jalr
      (_GEN_7 ? _slots_8_io_out_uop_is_jalr : _slots_7_io_out_uop_is_jalr),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_jal
      (_GEN_7 ? _slots_8_io_out_uop_is_jal : _slots_7_io_out_uop_is_jal),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_sfb
      (_GEN_7 ? _slots_8_io_out_uop_is_sfb : _slots_7_io_out_uop_is_sfb),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_br_mask
      (_GEN_7 ? _slots_8_io_out_uop_br_mask : _slots_7_io_out_uop_br_mask),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_br_tag
      (_GEN_7 ? _slots_8_io_out_uop_br_tag : _slots_7_io_out_uop_br_tag),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ftq_idx
      (_GEN_7 ? _slots_8_io_out_uop_ftq_idx : _slots_7_io_out_uop_ftq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_edge_inst
      (_GEN_7 ? _slots_8_io_out_uop_edge_inst : _slots_7_io_out_uop_edge_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_pc_lob
      (_GEN_7 ? _slots_8_io_out_uop_pc_lob : _slots_7_io_out_uop_pc_lob),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_taken
      (_GEN_7 ? _slots_8_io_out_uop_taken : _slots_7_io_out_uop_taken),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_imm_packed
      (_GEN_7 ? _slots_8_io_out_uop_imm_packed : _slots_7_io_out_uop_imm_packed),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_csr_addr
      (_GEN_7 ? _slots_8_io_out_uop_csr_addr : _slots_7_io_out_uop_csr_addr),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_rob_idx
      (_GEN_7 ? _slots_8_io_out_uop_rob_idx : _slots_7_io_out_uop_rob_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldq_idx
      (_GEN_7 ? _slots_8_io_out_uop_ldq_idx : _slots_7_io_out_uop_ldq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_stq_idx
      (_GEN_7 ? _slots_8_io_out_uop_stq_idx : _slots_7_io_out_uop_stq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_rxq_idx
      (_GEN_7 ? _slots_8_io_out_uop_rxq_idx : _slots_7_io_out_uop_rxq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_pdst
      (_GEN_7 ? _slots_8_io_out_uop_pdst : _slots_7_io_out_uop_pdst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs1
      (_GEN_7 ? _slots_8_io_out_uop_prs1 : _slots_7_io_out_uop_prs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs2
      (_GEN_7 ? _slots_8_io_out_uop_prs2 : _slots_7_io_out_uop_prs2),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs3
      (_GEN_7 ? _slots_8_io_out_uop_prs3 : _slots_7_io_out_uop_prs3),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ppred
      (_GEN_7 ? _slots_8_io_out_uop_ppred : _slots_7_io_out_uop_ppred),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs1_busy
      (_GEN_7 ? _slots_8_io_out_uop_prs1_busy : _slots_7_io_out_uop_prs1_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs2_busy
      (_GEN_7 ? _slots_8_io_out_uop_prs2_busy : _slots_7_io_out_uop_prs2_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs3_busy
      (_GEN_7 ? _slots_8_io_out_uop_prs3_busy : _slots_7_io_out_uop_prs3_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ppred_busy
      (_GEN_7 ? _slots_8_io_out_uop_ppred_busy : _slots_7_io_out_uop_ppred_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_stale_pdst
      (_GEN_7 ? _slots_8_io_out_uop_stale_pdst : _slots_7_io_out_uop_stale_pdst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_exception
      (_GEN_7 ? _slots_8_io_out_uop_exception : _slots_7_io_out_uop_exception),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_exc_cause
      (_GEN_7 ? _slots_8_io_out_uop_exc_cause : _slots_7_io_out_uop_exc_cause),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bypassable
      (_GEN_7 ? _slots_8_io_out_uop_bypassable : _slots_7_io_out_uop_bypassable),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_cmd
      (_GEN_7 ? _slots_8_io_out_uop_mem_cmd : _slots_7_io_out_uop_mem_cmd),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_size
      (_GEN_7 ? _slots_8_io_out_uop_mem_size : _slots_7_io_out_uop_mem_size),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_signed
      (_GEN_7 ? _slots_8_io_out_uop_mem_signed : _slots_7_io_out_uop_mem_signed),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_fence
      (_GEN_7 ? _slots_8_io_out_uop_is_fence : _slots_7_io_out_uop_is_fence),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_fencei
      (_GEN_7 ? _slots_8_io_out_uop_is_fencei : _slots_7_io_out_uop_is_fencei),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_amo
      (_GEN_7 ? _slots_8_io_out_uop_is_amo : _slots_7_io_out_uop_is_amo),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_uses_ldq
      (_GEN_7 ? _slots_8_io_out_uop_uses_ldq : _slots_7_io_out_uop_uses_ldq),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_uses_stq
      (_GEN_7 ? _slots_8_io_out_uop_uses_stq : _slots_7_io_out_uop_uses_stq),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_sys_pc2epc
      (_GEN_7 ? _slots_8_io_out_uop_is_sys_pc2epc : _slots_7_io_out_uop_is_sys_pc2epc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_unique
      (_GEN_7 ? _slots_8_io_out_uop_is_unique : _slots_7_io_out_uop_is_unique),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_flush_on_commit
      (_GEN_7
         ? _slots_8_io_out_uop_flush_on_commit
         : _slots_7_io_out_uop_flush_on_commit),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst_is_rs1
      (_GEN_7 ? _slots_8_io_out_uop_ldst_is_rs1 : _slots_7_io_out_uop_ldst_is_rs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst
      (_GEN_7 ? _slots_8_io_out_uop_ldst : _slots_7_io_out_uop_ldst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs1
      (_GEN_7 ? _slots_8_io_out_uop_lrs1 : _slots_7_io_out_uop_lrs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs2
      (_GEN_7 ? _slots_8_io_out_uop_lrs2 : _slots_7_io_out_uop_lrs2),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs3
      (_GEN_7 ? _slots_8_io_out_uop_lrs3 : _slots_7_io_out_uop_lrs3),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst_val
      (_GEN_7 ? _slots_8_io_out_uop_ldst_val : _slots_7_io_out_uop_ldst_val),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_dst_rtype
      (_GEN_7 ? _slots_8_io_out_uop_dst_rtype : _slots_7_io_out_uop_dst_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs1_rtype
      (_GEN_7 ? _slots_8_io_out_uop_lrs1_rtype : _slots_7_io_out_uop_lrs1_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs2_rtype
      (_GEN_7 ? _slots_8_io_out_uop_lrs2_rtype : _slots_7_io_out_uop_lrs2_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_frs3_en
      (_GEN_7 ? _slots_8_io_out_uop_frs3_en : _slots_7_io_out_uop_frs3_en),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fp_val
      (_GEN_7 ? _slots_8_io_out_uop_fp_val : _slots_7_io_out_uop_fp_val),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fp_single
      (_GEN_7 ? _slots_8_io_out_uop_fp_single : _slots_7_io_out_uop_fp_single),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_pf_if
      (_GEN_7 ? _slots_8_io_out_uop_xcpt_pf_if : _slots_7_io_out_uop_xcpt_pf_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_ae_if
      (_GEN_7 ? _slots_8_io_out_uop_xcpt_ae_if : _slots_7_io_out_uop_xcpt_ae_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_ma_if
      (_GEN_7 ? _slots_8_io_out_uop_xcpt_ma_if : _slots_7_io_out_uop_xcpt_ma_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bp_debug_if
      (_GEN_7 ? _slots_8_io_out_uop_bp_debug_if : _slots_7_io_out_uop_bp_debug_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bp_xcpt_if
      (_GEN_7 ? _slots_8_io_out_uop_bp_xcpt_if : _slots_7_io_out_uop_bp_xcpt_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_fsrc
      (_GEN_7 ? _slots_8_io_out_uop_debug_fsrc : _slots_7_io_out_uop_debug_fsrc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_tsrc
      (_GEN_7 ? _slots_8_io_out_uop_debug_tsrc : _slots_7_io_out_uop_debug_tsrc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_valid                       (_slots_6_io_valid),
    .io_will_be_valid               (_slots_6_io_will_be_valid),
    .io_request                     (_slots_6_io_request),
    .io_out_uop_uopc                (_slots_6_io_out_uop_uopc),
    .io_out_uop_inst                (_slots_6_io_out_uop_inst),
    .io_out_uop_debug_inst          (_slots_6_io_out_uop_debug_inst),
    .io_out_uop_is_rvc              (_slots_6_io_out_uop_is_rvc),
    .io_out_uop_debug_pc            (_slots_6_io_out_uop_debug_pc),
    .io_out_uop_iq_type             (_slots_6_io_out_uop_iq_type),
    .io_out_uop_fu_code             (_slots_6_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_6_io_out_uop_iw_state),
    .io_out_uop_is_br               (_slots_6_io_out_uop_is_br),
    .io_out_uop_is_jalr             (_slots_6_io_out_uop_is_jalr),
    .io_out_uop_is_jal              (_slots_6_io_out_uop_is_jal),
    .io_out_uop_is_sfb              (_slots_6_io_out_uop_is_sfb),
    .io_out_uop_br_mask             (_slots_6_io_out_uop_br_mask),
    .io_out_uop_br_tag              (_slots_6_io_out_uop_br_tag),
    .io_out_uop_ftq_idx             (_slots_6_io_out_uop_ftq_idx),
    .io_out_uop_edge_inst           (_slots_6_io_out_uop_edge_inst),
    .io_out_uop_pc_lob              (_slots_6_io_out_uop_pc_lob),
    .io_out_uop_taken               (_slots_6_io_out_uop_taken),
    .io_out_uop_imm_packed          (_slots_6_io_out_uop_imm_packed),
    .io_out_uop_csr_addr            (_slots_6_io_out_uop_csr_addr),
    .io_out_uop_rob_idx             (_slots_6_io_out_uop_rob_idx),
    .io_out_uop_ldq_idx             (_slots_6_io_out_uop_ldq_idx),
    .io_out_uop_stq_idx             (_slots_6_io_out_uop_stq_idx),
    .io_out_uop_rxq_idx             (_slots_6_io_out_uop_rxq_idx),
    .io_out_uop_pdst                (_slots_6_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_6_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_6_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_6_io_out_uop_prs3),
    .io_out_uop_ppred               (_slots_6_io_out_uop_ppred),
    .io_out_uop_prs1_busy           (_slots_6_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_6_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_6_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_6_io_out_uop_ppred_busy),
    .io_out_uop_stale_pdst          (_slots_6_io_out_uop_stale_pdst),
    .io_out_uop_exception           (_slots_6_io_out_uop_exception),
    .io_out_uop_exc_cause           (_slots_6_io_out_uop_exc_cause),
    .io_out_uop_bypassable          (_slots_6_io_out_uop_bypassable),
    .io_out_uop_mem_cmd             (_slots_6_io_out_uop_mem_cmd),
    .io_out_uop_mem_size            (_slots_6_io_out_uop_mem_size),
    .io_out_uop_mem_signed          (_slots_6_io_out_uop_mem_signed),
    .io_out_uop_is_fence            (_slots_6_io_out_uop_is_fence),
    .io_out_uop_is_fencei           (_slots_6_io_out_uop_is_fencei),
    .io_out_uop_is_amo              (_slots_6_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_6_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_6_io_out_uop_uses_stq),
    .io_out_uop_is_sys_pc2epc       (_slots_6_io_out_uop_is_sys_pc2epc),
    .io_out_uop_is_unique           (_slots_6_io_out_uop_is_unique),
    .io_out_uop_flush_on_commit     (_slots_6_io_out_uop_flush_on_commit),
    .io_out_uop_ldst_is_rs1         (_slots_6_io_out_uop_ldst_is_rs1),
    .io_out_uop_ldst                (_slots_6_io_out_uop_ldst),
    .io_out_uop_lrs1                (_slots_6_io_out_uop_lrs1),
    .io_out_uop_lrs2                (_slots_6_io_out_uop_lrs2),
    .io_out_uop_lrs3                (_slots_6_io_out_uop_lrs3),
    .io_out_uop_ldst_val            (_slots_6_io_out_uop_ldst_val),
    .io_out_uop_dst_rtype           (_slots_6_io_out_uop_dst_rtype),
    .io_out_uop_lrs1_rtype          (_slots_6_io_out_uop_lrs1_rtype),
    .io_out_uop_lrs2_rtype          (_slots_6_io_out_uop_lrs2_rtype),
    .io_out_uop_frs3_en             (_slots_6_io_out_uop_frs3_en),
    .io_out_uop_fp_val              (_slots_6_io_out_uop_fp_val),
    .io_out_uop_fp_single           (_slots_6_io_out_uop_fp_single),
    .io_out_uop_xcpt_pf_if          (_slots_6_io_out_uop_xcpt_pf_if),
    .io_out_uop_xcpt_ae_if          (_slots_6_io_out_uop_xcpt_ae_if),
    .io_out_uop_xcpt_ma_if          (_slots_6_io_out_uop_xcpt_ma_if),
    .io_out_uop_bp_debug_if         (_slots_6_io_out_uop_bp_debug_if),
    .io_out_uop_bp_xcpt_if          (_slots_6_io_out_uop_bp_xcpt_if),
    .io_out_uop_debug_fsrc          (_slots_6_io_out_uop_debug_fsrc),
    .io_out_uop_debug_tsrc          (_slots_6_io_out_uop_debug_tsrc),
    .io_uop_uopc                    (_slots_6_io_uop_uopc),
    .io_uop_inst                    (_slots_6_io_uop_inst),
    .io_uop_debug_inst              (_slots_6_io_uop_debug_inst),
    .io_uop_is_rvc                  (_slots_6_io_uop_is_rvc),
    .io_uop_debug_pc                (_slots_6_io_uop_debug_pc),
    .io_uop_iq_type                 (_slots_6_io_uop_iq_type),
    .io_uop_fu_code                 (_slots_6_io_uop_fu_code),
    .io_uop_iw_state                (_slots_6_io_uop_iw_state),
    .io_uop_is_br                   (_slots_6_io_uop_is_br),
    .io_uop_is_jalr                 (_slots_6_io_uop_is_jalr),
    .io_uop_is_jal                  (_slots_6_io_uop_is_jal),
    .io_uop_is_sfb                  (_slots_6_io_uop_is_sfb),
    .io_uop_br_mask                 (_slots_6_io_uop_br_mask),
    .io_uop_br_tag                  (_slots_6_io_uop_br_tag),
    .io_uop_ftq_idx                 (_slots_6_io_uop_ftq_idx),
    .io_uop_edge_inst               (_slots_6_io_uop_edge_inst),
    .io_uop_pc_lob                  (_slots_6_io_uop_pc_lob),
    .io_uop_taken                   (_slots_6_io_uop_taken),
    .io_uop_imm_packed              (_slots_6_io_uop_imm_packed),
    .io_uop_csr_addr                (_slots_6_io_uop_csr_addr),
    .io_uop_rob_idx                 (_slots_6_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_6_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_6_io_uop_stq_idx),
    .io_uop_rxq_idx                 (_slots_6_io_uop_rxq_idx),
    .io_uop_pdst                    (_slots_6_io_uop_pdst),
    .io_uop_prs1                    (_slots_6_io_uop_prs1),
    .io_uop_prs2                    (_slots_6_io_uop_prs2),
    .io_uop_prs3                    (_slots_6_io_uop_prs3),
    .io_uop_ppred                   (_slots_6_io_uop_ppred),
    .io_uop_prs1_busy               (_slots_6_io_uop_prs1_busy),
    .io_uop_prs2_busy               (_slots_6_io_uop_prs2_busy),
    .io_uop_prs3_busy               (_slots_6_io_uop_prs3_busy),
    .io_uop_ppred_busy              (_slots_6_io_uop_ppred_busy),
    .io_uop_stale_pdst              (_slots_6_io_uop_stale_pdst),
    .io_uop_exception               (_slots_6_io_uop_exception),
    .io_uop_exc_cause               (_slots_6_io_uop_exc_cause),
    .io_uop_bypassable              (_slots_6_io_uop_bypassable),
    .io_uop_mem_cmd                 (_slots_6_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_6_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_6_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_6_io_uop_is_fence),
    .io_uop_is_fencei               (_slots_6_io_uop_is_fencei),
    .io_uop_is_amo                  (_slots_6_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_6_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_6_io_uop_uses_stq),
    .io_uop_is_sys_pc2epc           (_slots_6_io_uop_is_sys_pc2epc),
    .io_uop_is_unique               (_slots_6_io_uop_is_unique),
    .io_uop_flush_on_commit         (_slots_6_io_uop_flush_on_commit),
    .io_uop_ldst_is_rs1             (_slots_6_io_uop_ldst_is_rs1),
    .io_uop_ldst                    (_slots_6_io_uop_ldst),
    .io_uop_lrs1                    (_slots_6_io_uop_lrs1),
    .io_uop_lrs2                    (_slots_6_io_uop_lrs2),
    .io_uop_lrs3                    (_slots_6_io_uop_lrs3),
    .io_uop_ldst_val                (_slots_6_io_uop_ldst_val),
    .io_uop_dst_rtype               (_slots_6_io_uop_dst_rtype),
    .io_uop_lrs1_rtype              (_slots_6_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_6_io_uop_lrs2_rtype),
    .io_uop_frs3_en                 (_slots_6_io_uop_frs3_en),
    .io_uop_fp_val                  (_slots_6_io_uop_fp_val),
    .io_uop_fp_single               (_slots_6_io_uop_fp_single),
    .io_uop_xcpt_pf_if              (_slots_6_io_uop_xcpt_pf_if),
    .io_uop_xcpt_ae_if              (_slots_6_io_uop_xcpt_ae_if),
    .io_uop_xcpt_ma_if              (_slots_6_io_uop_xcpt_ma_if),
    .io_uop_bp_debug_if             (_slots_6_io_uop_bp_debug_if),
    .io_uop_bp_xcpt_if              (_slots_6_io_uop_bp_xcpt_if),
    .io_uop_debug_fsrc              (_slots_6_io_uop_debug_fsrc),
    .io_uop_debug_tsrc              (_slots_6_io_uop_debug_tsrc)
  );
  IssueSlot_168 slots_7 (	// issue-unit.scala:153:73
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_7_grant),	// issue-unit-age-ordered.scala:118:56
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|next_6),	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :76:49
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_in_uop_valid                (issue_slots_7_in_uop_valid),	// issue-unit-age-ordered.scala:71:48, :72:37
    .io_in_uop_bits_uopc
      (_GEN_8 ? _slots_9_io_out_uop_uopc : _slots_8_io_out_uop_uopc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_inst
      (_GEN_8 ? _slots_9_io_out_uop_inst : _slots_8_io_out_uop_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_inst
      (_GEN_8 ? _slots_9_io_out_uop_debug_inst : _slots_8_io_out_uop_debug_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_rvc
      (_GEN_8 ? _slots_9_io_out_uop_is_rvc : _slots_8_io_out_uop_is_rvc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_pc
      (_GEN_8 ? _slots_9_io_out_uop_debug_pc : _slots_8_io_out_uop_debug_pc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_iq_type
      (_GEN_8 ? _slots_9_io_out_uop_iq_type : _slots_8_io_out_uop_iq_type),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fu_code
      (_GEN_8 ? _slots_9_io_out_uop_fu_code : _slots_8_io_out_uop_fu_code),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_iw_state
      (_GEN_8 ? _slots_9_io_out_uop_iw_state : _slots_8_io_out_uop_iw_state),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_br
      (_GEN_8 ? _slots_9_io_out_uop_is_br : _slots_8_io_out_uop_is_br),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_jalr
      (_GEN_8 ? _slots_9_io_out_uop_is_jalr : _slots_8_io_out_uop_is_jalr),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_jal
      (_GEN_8 ? _slots_9_io_out_uop_is_jal : _slots_8_io_out_uop_is_jal),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_sfb
      (_GEN_8 ? _slots_9_io_out_uop_is_sfb : _slots_8_io_out_uop_is_sfb),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_br_mask
      (_GEN_8 ? _slots_9_io_out_uop_br_mask : _slots_8_io_out_uop_br_mask),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_br_tag
      (_GEN_8 ? _slots_9_io_out_uop_br_tag : _slots_8_io_out_uop_br_tag),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ftq_idx
      (_GEN_8 ? _slots_9_io_out_uop_ftq_idx : _slots_8_io_out_uop_ftq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_edge_inst
      (_GEN_8 ? _slots_9_io_out_uop_edge_inst : _slots_8_io_out_uop_edge_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_pc_lob
      (_GEN_8 ? _slots_9_io_out_uop_pc_lob : _slots_8_io_out_uop_pc_lob),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_taken
      (_GEN_8 ? _slots_9_io_out_uop_taken : _slots_8_io_out_uop_taken),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_imm_packed
      (_GEN_8 ? _slots_9_io_out_uop_imm_packed : _slots_8_io_out_uop_imm_packed),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_csr_addr
      (_GEN_8 ? _slots_9_io_out_uop_csr_addr : _slots_8_io_out_uop_csr_addr),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_rob_idx
      (_GEN_8 ? _slots_9_io_out_uop_rob_idx : _slots_8_io_out_uop_rob_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldq_idx
      (_GEN_8 ? _slots_9_io_out_uop_ldq_idx : _slots_8_io_out_uop_ldq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_stq_idx
      (_GEN_8 ? _slots_9_io_out_uop_stq_idx : _slots_8_io_out_uop_stq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_rxq_idx
      (_GEN_8 ? _slots_9_io_out_uop_rxq_idx : _slots_8_io_out_uop_rxq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_pdst
      (_GEN_8 ? _slots_9_io_out_uop_pdst : _slots_8_io_out_uop_pdst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs1
      (_GEN_8 ? _slots_9_io_out_uop_prs1 : _slots_8_io_out_uop_prs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs2
      (_GEN_8 ? _slots_9_io_out_uop_prs2 : _slots_8_io_out_uop_prs2),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs3
      (_GEN_8 ? _slots_9_io_out_uop_prs3 : _slots_8_io_out_uop_prs3),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ppred
      (_GEN_8 ? _slots_9_io_out_uop_ppred : _slots_8_io_out_uop_ppred),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs1_busy
      (_GEN_8 ? _slots_9_io_out_uop_prs1_busy : _slots_8_io_out_uop_prs1_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs2_busy
      (_GEN_8 ? _slots_9_io_out_uop_prs2_busy : _slots_8_io_out_uop_prs2_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs3_busy
      (_GEN_8 ? _slots_9_io_out_uop_prs3_busy : _slots_8_io_out_uop_prs3_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ppred_busy
      (_GEN_8 ? _slots_9_io_out_uop_ppred_busy : _slots_8_io_out_uop_ppred_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_stale_pdst
      (_GEN_8 ? _slots_9_io_out_uop_stale_pdst : _slots_8_io_out_uop_stale_pdst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_exception
      (_GEN_8 ? _slots_9_io_out_uop_exception : _slots_8_io_out_uop_exception),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_exc_cause
      (_GEN_8 ? _slots_9_io_out_uop_exc_cause : _slots_8_io_out_uop_exc_cause),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bypassable
      (_GEN_8 ? _slots_9_io_out_uop_bypassable : _slots_8_io_out_uop_bypassable),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_cmd
      (_GEN_8 ? _slots_9_io_out_uop_mem_cmd : _slots_8_io_out_uop_mem_cmd),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_size
      (_GEN_8 ? _slots_9_io_out_uop_mem_size : _slots_8_io_out_uop_mem_size),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_signed
      (_GEN_8 ? _slots_9_io_out_uop_mem_signed : _slots_8_io_out_uop_mem_signed),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_fence
      (_GEN_8 ? _slots_9_io_out_uop_is_fence : _slots_8_io_out_uop_is_fence),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_fencei
      (_GEN_8 ? _slots_9_io_out_uop_is_fencei : _slots_8_io_out_uop_is_fencei),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_amo
      (_GEN_8 ? _slots_9_io_out_uop_is_amo : _slots_8_io_out_uop_is_amo),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_uses_ldq
      (_GEN_8 ? _slots_9_io_out_uop_uses_ldq : _slots_8_io_out_uop_uses_ldq),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_uses_stq
      (_GEN_8 ? _slots_9_io_out_uop_uses_stq : _slots_8_io_out_uop_uses_stq),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_sys_pc2epc
      (_GEN_8 ? _slots_9_io_out_uop_is_sys_pc2epc : _slots_8_io_out_uop_is_sys_pc2epc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_unique
      (_GEN_8 ? _slots_9_io_out_uop_is_unique : _slots_8_io_out_uop_is_unique),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_flush_on_commit
      (_GEN_8
         ? _slots_9_io_out_uop_flush_on_commit
         : _slots_8_io_out_uop_flush_on_commit),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst_is_rs1
      (_GEN_8 ? _slots_9_io_out_uop_ldst_is_rs1 : _slots_8_io_out_uop_ldst_is_rs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst
      (_GEN_8 ? _slots_9_io_out_uop_ldst : _slots_8_io_out_uop_ldst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs1
      (_GEN_8 ? _slots_9_io_out_uop_lrs1 : _slots_8_io_out_uop_lrs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs2
      (_GEN_8 ? _slots_9_io_out_uop_lrs2 : _slots_8_io_out_uop_lrs2),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs3
      (_GEN_8 ? _slots_9_io_out_uop_lrs3 : _slots_8_io_out_uop_lrs3),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst_val
      (_GEN_8 ? _slots_9_io_out_uop_ldst_val : _slots_8_io_out_uop_ldst_val),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_dst_rtype
      (_GEN_8 ? _slots_9_io_out_uop_dst_rtype : _slots_8_io_out_uop_dst_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs1_rtype
      (_GEN_8 ? _slots_9_io_out_uop_lrs1_rtype : _slots_8_io_out_uop_lrs1_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs2_rtype
      (_GEN_8 ? _slots_9_io_out_uop_lrs2_rtype : _slots_8_io_out_uop_lrs2_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_frs3_en
      (_GEN_8 ? _slots_9_io_out_uop_frs3_en : _slots_8_io_out_uop_frs3_en),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fp_val
      (_GEN_8 ? _slots_9_io_out_uop_fp_val : _slots_8_io_out_uop_fp_val),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fp_single
      (_GEN_8 ? _slots_9_io_out_uop_fp_single : _slots_8_io_out_uop_fp_single),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_pf_if
      (_GEN_8 ? _slots_9_io_out_uop_xcpt_pf_if : _slots_8_io_out_uop_xcpt_pf_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_ae_if
      (_GEN_8 ? _slots_9_io_out_uop_xcpt_ae_if : _slots_8_io_out_uop_xcpt_ae_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_ma_if
      (_GEN_8 ? _slots_9_io_out_uop_xcpt_ma_if : _slots_8_io_out_uop_xcpt_ma_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bp_debug_if
      (_GEN_8 ? _slots_9_io_out_uop_bp_debug_if : _slots_8_io_out_uop_bp_debug_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bp_xcpt_if
      (_GEN_8 ? _slots_9_io_out_uop_bp_xcpt_if : _slots_8_io_out_uop_bp_xcpt_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_fsrc
      (_GEN_8 ? _slots_9_io_out_uop_debug_fsrc : _slots_8_io_out_uop_debug_fsrc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_tsrc
      (_GEN_8 ? _slots_9_io_out_uop_debug_tsrc : _slots_8_io_out_uop_debug_tsrc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_valid                       (_slots_7_io_valid),
    .io_will_be_valid               (_slots_7_io_will_be_valid),
    .io_request                     (_slots_7_io_request),
    .io_out_uop_uopc                (_slots_7_io_out_uop_uopc),
    .io_out_uop_inst                (_slots_7_io_out_uop_inst),
    .io_out_uop_debug_inst          (_slots_7_io_out_uop_debug_inst),
    .io_out_uop_is_rvc              (_slots_7_io_out_uop_is_rvc),
    .io_out_uop_debug_pc            (_slots_7_io_out_uop_debug_pc),
    .io_out_uop_iq_type             (_slots_7_io_out_uop_iq_type),
    .io_out_uop_fu_code             (_slots_7_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_7_io_out_uop_iw_state),
    .io_out_uop_is_br               (_slots_7_io_out_uop_is_br),
    .io_out_uop_is_jalr             (_slots_7_io_out_uop_is_jalr),
    .io_out_uop_is_jal              (_slots_7_io_out_uop_is_jal),
    .io_out_uop_is_sfb              (_slots_7_io_out_uop_is_sfb),
    .io_out_uop_br_mask             (_slots_7_io_out_uop_br_mask),
    .io_out_uop_br_tag              (_slots_7_io_out_uop_br_tag),
    .io_out_uop_ftq_idx             (_slots_7_io_out_uop_ftq_idx),
    .io_out_uop_edge_inst           (_slots_7_io_out_uop_edge_inst),
    .io_out_uop_pc_lob              (_slots_7_io_out_uop_pc_lob),
    .io_out_uop_taken               (_slots_7_io_out_uop_taken),
    .io_out_uop_imm_packed          (_slots_7_io_out_uop_imm_packed),
    .io_out_uop_csr_addr            (_slots_7_io_out_uop_csr_addr),
    .io_out_uop_rob_idx             (_slots_7_io_out_uop_rob_idx),
    .io_out_uop_ldq_idx             (_slots_7_io_out_uop_ldq_idx),
    .io_out_uop_stq_idx             (_slots_7_io_out_uop_stq_idx),
    .io_out_uop_rxq_idx             (_slots_7_io_out_uop_rxq_idx),
    .io_out_uop_pdst                (_slots_7_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_7_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_7_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_7_io_out_uop_prs3),
    .io_out_uop_ppred               (_slots_7_io_out_uop_ppred),
    .io_out_uop_prs1_busy           (_slots_7_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_7_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_7_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_7_io_out_uop_ppred_busy),
    .io_out_uop_stale_pdst          (_slots_7_io_out_uop_stale_pdst),
    .io_out_uop_exception           (_slots_7_io_out_uop_exception),
    .io_out_uop_exc_cause           (_slots_7_io_out_uop_exc_cause),
    .io_out_uop_bypassable          (_slots_7_io_out_uop_bypassable),
    .io_out_uop_mem_cmd             (_slots_7_io_out_uop_mem_cmd),
    .io_out_uop_mem_size            (_slots_7_io_out_uop_mem_size),
    .io_out_uop_mem_signed          (_slots_7_io_out_uop_mem_signed),
    .io_out_uop_is_fence            (_slots_7_io_out_uop_is_fence),
    .io_out_uop_is_fencei           (_slots_7_io_out_uop_is_fencei),
    .io_out_uop_is_amo              (_slots_7_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_7_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_7_io_out_uop_uses_stq),
    .io_out_uop_is_sys_pc2epc       (_slots_7_io_out_uop_is_sys_pc2epc),
    .io_out_uop_is_unique           (_slots_7_io_out_uop_is_unique),
    .io_out_uop_flush_on_commit     (_slots_7_io_out_uop_flush_on_commit),
    .io_out_uop_ldst_is_rs1         (_slots_7_io_out_uop_ldst_is_rs1),
    .io_out_uop_ldst                (_slots_7_io_out_uop_ldst),
    .io_out_uop_lrs1                (_slots_7_io_out_uop_lrs1),
    .io_out_uop_lrs2                (_slots_7_io_out_uop_lrs2),
    .io_out_uop_lrs3                (_slots_7_io_out_uop_lrs3),
    .io_out_uop_ldst_val            (_slots_7_io_out_uop_ldst_val),
    .io_out_uop_dst_rtype           (_slots_7_io_out_uop_dst_rtype),
    .io_out_uop_lrs1_rtype          (_slots_7_io_out_uop_lrs1_rtype),
    .io_out_uop_lrs2_rtype          (_slots_7_io_out_uop_lrs2_rtype),
    .io_out_uop_frs3_en             (_slots_7_io_out_uop_frs3_en),
    .io_out_uop_fp_val              (_slots_7_io_out_uop_fp_val),
    .io_out_uop_fp_single           (_slots_7_io_out_uop_fp_single),
    .io_out_uop_xcpt_pf_if          (_slots_7_io_out_uop_xcpt_pf_if),
    .io_out_uop_xcpt_ae_if          (_slots_7_io_out_uop_xcpt_ae_if),
    .io_out_uop_xcpt_ma_if          (_slots_7_io_out_uop_xcpt_ma_if),
    .io_out_uop_bp_debug_if         (_slots_7_io_out_uop_bp_debug_if),
    .io_out_uop_bp_xcpt_if          (_slots_7_io_out_uop_bp_xcpt_if),
    .io_out_uop_debug_fsrc          (_slots_7_io_out_uop_debug_fsrc),
    .io_out_uop_debug_tsrc          (_slots_7_io_out_uop_debug_tsrc),
    .io_uop_uopc                    (_slots_7_io_uop_uopc),
    .io_uop_inst                    (_slots_7_io_uop_inst),
    .io_uop_debug_inst              (_slots_7_io_uop_debug_inst),
    .io_uop_is_rvc                  (_slots_7_io_uop_is_rvc),
    .io_uop_debug_pc                (_slots_7_io_uop_debug_pc),
    .io_uop_iq_type                 (_slots_7_io_uop_iq_type),
    .io_uop_fu_code                 (_slots_7_io_uop_fu_code),
    .io_uop_iw_state                (_slots_7_io_uop_iw_state),
    .io_uop_is_br                   (_slots_7_io_uop_is_br),
    .io_uop_is_jalr                 (_slots_7_io_uop_is_jalr),
    .io_uop_is_jal                  (_slots_7_io_uop_is_jal),
    .io_uop_is_sfb                  (_slots_7_io_uop_is_sfb),
    .io_uop_br_mask                 (_slots_7_io_uop_br_mask),
    .io_uop_br_tag                  (_slots_7_io_uop_br_tag),
    .io_uop_ftq_idx                 (_slots_7_io_uop_ftq_idx),
    .io_uop_edge_inst               (_slots_7_io_uop_edge_inst),
    .io_uop_pc_lob                  (_slots_7_io_uop_pc_lob),
    .io_uop_taken                   (_slots_7_io_uop_taken),
    .io_uop_imm_packed              (_slots_7_io_uop_imm_packed),
    .io_uop_csr_addr                (_slots_7_io_uop_csr_addr),
    .io_uop_rob_idx                 (_slots_7_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_7_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_7_io_uop_stq_idx),
    .io_uop_rxq_idx                 (_slots_7_io_uop_rxq_idx),
    .io_uop_pdst                    (_slots_7_io_uop_pdst),
    .io_uop_prs1                    (_slots_7_io_uop_prs1),
    .io_uop_prs2                    (_slots_7_io_uop_prs2),
    .io_uop_prs3                    (_slots_7_io_uop_prs3),
    .io_uop_ppred                   (_slots_7_io_uop_ppred),
    .io_uop_prs1_busy               (_slots_7_io_uop_prs1_busy),
    .io_uop_prs2_busy               (_slots_7_io_uop_prs2_busy),
    .io_uop_prs3_busy               (_slots_7_io_uop_prs3_busy),
    .io_uop_ppred_busy              (_slots_7_io_uop_ppred_busy),
    .io_uop_stale_pdst              (_slots_7_io_uop_stale_pdst),
    .io_uop_exception               (_slots_7_io_uop_exception),
    .io_uop_exc_cause               (_slots_7_io_uop_exc_cause),
    .io_uop_bypassable              (_slots_7_io_uop_bypassable),
    .io_uop_mem_cmd                 (_slots_7_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_7_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_7_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_7_io_uop_is_fence),
    .io_uop_is_fencei               (_slots_7_io_uop_is_fencei),
    .io_uop_is_amo                  (_slots_7_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_7_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_7_io_uop_uses_stq),
    .io_uop_is_sys_pc2epc           (_slots_7_io_uop_is_sys_pc2epc),
    .io_uop_is_unique               (_slots_7_io_uop_is_unique),
    .io_uop_flush_on_commit         (_slots_7_io_uop_flush_on_commit),
    .io_uop_ldst_is_rs1             (_slots_7_io_uop_ldst_is_rs1),
    .io_uop_ldst                    (_slots_7_io_uop_ldst),
    .io_uop_lrs1                    (_slots_7_io_uop_lrs1),
    .io_uop_lrs2                    (_slots_7_io_uop_lrs2),
    .io_uop_lrs3                    (_slots_7_io_uop_lrs3),
    .io_uop_ldst_val                (_slots_7_io_uop_ldst_val),
    .io_uop_dst_rtype               (_slots_7_io_uop_dst_rtype),
    .io_uop_lrs1_rtype              (_slots_7_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_7_io_uop_lrs2_rtype),
    .io_uop_frs3_en                 (_slots_7_io_uop_frs3_en),
    .io_uop_fp_val                  (_slots_7_io_uop_fp_val),
    .io_uop_fp_single               (_slots_7_io_uop_fp_single),
    .io_uop_xcpt_pf_if              (_slots_7_io_uop_xcpt_pf_if),
    .io_uop_xcpt_ae_if              (_slots_7_io_uop_xcpt_ae_if),
    .io_uop_xcpt_ma_if              (_slots_7_io_uop_xcpt_ma_if),
    .io_uop_bp_debug_if             (_slots_7_io_uop_bp_debug_if),
    .io_uop_bp_xcpt_if              (_slots_7_io_uop_bp_xcpt_if),
    .io_uop_debug_fsrc              (_slots_7_io_uop_debug_fsrc),
    .io_uop_debug_tsrc              (_slots_7_io_uop_debug_tsrc)
  );
  IssueSlot_168 slots_8 (	// issue-unit.scala:153:73
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_8_grant),	// issue-unit-age-ordered.scala:118:56
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|next_7),	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :76:49
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_in_uop_valid                (issue_slots_8_in_uop_valid),	// issue-unit-age-ordered.scala:71:48, :72:37
    .io_in_uop_bits_uopc
      (_GEN_9 ? _slots_10_io_out_uop_uopc : _slots_9_io_out_uop_uopc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_inst
      (_GEN_9 ? _slots_10_io_out_uop_inst : _slots_9_io_out_uop_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_inst
      (_GEN_9 ? _slots_10_io_out_uop_debug_inst : _slots_9_io_out_uop_debug_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_rvc
      (_GEN_9 ? _slots_10_io_out_uop_is_rvc : _slots_9_io_out_uop_is_rvc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_pc
      (_GEN_9 ? _slots_10_io_out_uop_debug_pc : _slots_9_io_out_uop_debug_pc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_iq_type
      (_GEN_9 ? _slots_10_io_out_uop_iq_type : _slots_9_io_out_uop_iq_type),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fu_code
      (_GEN_9 ? _slots_10_io_out_uop_fu_code : _slots_9_io_out_uop_fu_code),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_iw_state
      (_GEN_9 ? _slots_10_io_out_uop_iw_state : _slots_9_io_out_uop_iw_state),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_br
      (_GEN_9 ? _slots_10_io_out_uop_is_br : _slots_9_io_out_uop_is_br),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_jalr
      (_GEN_9 ? _slots_10_io_out_uop_is_jalr : _slots_9_io_out_uop_is_jalr),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_jal
      (_GEN_9 ? _slots_10_io_out_uop_is_jal : _slots_9_io_out_uop_is_jal),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_sfb
      (_GEN_9 ? _slots_10_io_out_uop_is_sfb : _slots_9_io_out_uop_is_sfb),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_br_mask
      (_GEN_9 ? _slots_10_io_out_uop_br_mask : _slots_9_io_out_uop_br_mask),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_br_tag
      (_GEN_9 ? _slots_10_io_out_uop_br_tag : _slots_9_io_out_uop_br_tag),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ftq_idx
      (_GEN_9 ? _slots_10_io_out_uop_ftq_idx : _slots_9_io_out_uop_ftq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_edge_inst
      (_GEN_9 ? _slots_10_io_out_uop_edge_inst : _slots_9_io_out_uop_edge_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_pc_lob
      (_GEN_9 ? _slots_10_io_out_uop_pc_lob : _slots_9_io_out_uop_pc_lob),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_taken
      (_GEN_9 ? _slots_10_io_out_uop_taken : _slots_9_io_out_uop_taken),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_imm_packed
      (_GEN_9 ? _slots_10_io_out_uop_imm_packed : _slots_9_io_out_uop_imm_packed),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_csr_addr
      (_GEN_9 ? _slots_10_io_out_uop_csr_addr : _slots_9_io_out_uop_csr_addr),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_rob_idx
      (_GEN_9 ? _slots_10_io_out_uop_rob_idx : _slots_9_io_out_uop_rob_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldq_idx
      (_GEN_9 ? _slots_10_io_out_uop_ldq_idx : _slots_9_io_out_uop_ldq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_stq_idx
      (_GEN_9 ? _slots_10_io_out_uop_stq_idx : _slots_9_io_out_uop_stq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_rxq_idx
      (_GEN_9 ? _slots_10_io_out_uop_rxq_idx : _slots_9_io_out_uop_rxq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_pdst
      (_GEN_9 ? _slots_10_io_out_uop_pdst : _slots_9_io_out_uop_pdst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs1
      (_GEN_9 ? _slots_10_io_out_uop_prs1 : _slots_9_io_out_uop_prs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs2
      (_GEN_9 ? _slots_10_io_out_uop_prs2 : _slots_9_io_out_uop_prs2),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs3
      (_GEN_9 ? _slots_10_io_out_uop_prs3 : _slots_9_io_out_uop_prs3),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ppred
      (_GEN_9 ? _slots_10_io_out_uop_ppred : _slots_9_io_out_uop_ppred),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs1_busy
      (_GEN_9 ? _slots_10_io_out_uop_prs1_busy : _slots_9_io_out_uop_prs1_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs2_busy
      (_GEN_9 ? _slots_10_io_out_uop_prs2_busy : _slots_9_io_out_uop_prs2_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs3_busy
      (_GEN_9 ? _slots_10_io_out_uop_prs3_busy : _slots_9_io_out_uop_prs3_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ppred_busy
      (_GEN_9 ? _slots_10_io_out_uop_ppred_busy : _slots_9_io_out_uop_ppred_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_stale_pdst
      (_GEN_9 ? _slots_10_io_out_uop_stale_pdst : _slots_9_io_out_uop_stale_pdst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_exception
      (_GEN_9 ? _slots_10_io_out_uop_exception : _slots_9_io_out_uop_exception),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_exc_cause
      (_GEN_9 ? _slots_10_io_out_uop_exc_cause : _slots_9_io_out_uop_exc_cause),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bypassable
      (_GEN_9 ? _slots_10_io_out_uop_bypassable : _slots_9_io_out_uop_bypassable),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_cmd
      (_GEN_9 ? _slots_10_io_out_uop_mem_cmd : _slots_9_io_out_uop_mem_cmd),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_size
      (_GEN_9 ? _slots_10_io_out_uop_mem_size : _slots_9_io_out_uop_mem_size),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_signed
      (_GEN_9 ? _slots_10_io_out_uop_mem_signed : _slots_9_io_out_uop_mem_signed),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_fence
      (_GEN_9 ? _slots_10_io_out_uop_is_fence : _slots_9_io_out_uop_is_fence),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_fencei
      (_GEN_9 ? _slots_10_io_out_uop_is_fencei : _slots_9_io_out_uop_is_fencei),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_amo
      (_GEN_9 ? _slots_10_io_out_uop_is_amo : _slots_9_io_out_uop_is_amo),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_uses_ldq
      (_GEN_9 ? _slots_10_io_out_uop_uses_ldq : _slots_9_io_out_uop_uses_ldq),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_uses_stq
      (_GEN_9 ? _slots_10_io_out_uop_uses_stq : _slots_9_io_out_uop_uses_stq),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_sys_pc2epc
      (_GEN_9 ? _slots_10_io_out_uop_is_sys_pc2epc : _slots_9_io_out_uop_is_sys_pc2epc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_unique
      (_GEN_9 ? _slots_10_io_out_uop_is_unique : _slots_9_io_out_uop_is_unique),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_flush_on_commit
      (_GEN_9
         ? _slots_10_io_out_uop_flush_on_commit
         : _slots_9_io_out_uop_flush_on_commit),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst_is_rs1
      (_GEN_9 ? _slots_10_io_out_uop_ldst_is_rs1 : _slots_9_io_out_uop_ldst_is_rs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst
      (_GEN_9 ? _slots_10_io_out_uop_ldst : _slots_9_io_out_uop_ldst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs1
      (_GEN_9 ? _slots_10_io_out_uop_lrs1 : _slots_9_io_out_uop_lrs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs2
      (_GEN_9 ? _slots_10_io_out_uop_lrs2 : _slots_9_io_out_uop_lrs2),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs3
      (_GEN_9 ? _slots_10_io_out_uop_lrs3 : _slots_9_io_out_uop_lrs3),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst_val
      (_GEN_9 ? _slots_10_io_out_uop_ldst_val : _slots_9_io_out_uop_ldst_val),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_dst_rtype
      (_GEN_9 ? _slots_10_io_out_uop_dst_rtype : _slots_9_io_out_uop_dst_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs1_rtype
      (_GEN_9 ? _slots_10_io_out_uop_lrs1_rtype : _slots_9_io_out_uop_lrs1_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs2_rtype
      (_GEN_9 ? _slots_10_io_out_uop_lrs2_rtype : _slots_9_io_out_uop_lrs2_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_frs3_en
      (_GEN_9 ? _slots_10_io_out_uop_frs3_en : _slots_9_io_out_uop_frs3_en),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fp_val
      (_GEN_9 ? _slots_10_io_out_uop_fp_val : _slots_9_io_out_uop_fp_val),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fp_single
      (_GEN_9 ? _slots_10_io_out_uop_fp_single : _slots_9_io_out_uop_fp_single),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_pf_if
      (_GEN_9 ? _slots_10_io_out_uop_xcpt_pf_if : _slots_9_io_out_uop_xcpt_pf_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_ae_if
      (_GEN_9 ? _slots_10_io_out_uop_xcpt_ae_if : _slots_9_io_out_uop_xcpt_ae_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_ma_if
      (_GEN_9 ? _slots_10_io_out_uop_xcpt_ma_if : _slots_9_io_out_uop_xcpt_ma_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bp_debug_if
      (_GEN_9 ? _slots_10_io_out_uop_bp_debug_if : _slots_9_io_out_uop_bp_debug_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bp_xcpt_if
      (_GEN_9 ? _slots_10_io_out_uop_bp_xcpt_if : _slots_9_io_out_uop_bp_xcpt_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_fsrc
      (_GEN_9 ? _slots_10_io_out_uop_debug_fsrc : _slots_9_io_out_uop_debug_fsrc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_tsrc
      (_GEN_9 ? _slots_10_io_out_uop_debug_tsrc : _slots_9_io_out_uop_debug_tsrc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_valid                       (_slots_8_io_valid),
    .io_will_be_valid               (_slots_8_io_will_be_valid),
    .io_request                     (_slots_8_io_request),
    .io_out_uop_uopc                (_slots_8_io_out_uop_uopc),
    .io_out_uop_inst                (_slots_8_io_out_uop_inst),
    .io_out_uop_debug_inst          (_slots_8_io_out_uop_debug_inst),
    .io_out_uop_is_rvc              (_slots_8_io_out_uop_is_rvc),
    .io_out_uop_debug_pc            (_slots_8_io_out_uop_debug_pc),
    .io_out_uop_iq_type             (_slots_8_io_out_uop_iq_type),
    .io_out_uop_fu_code             (_slots_8_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_8_io_out_uop_iw_state),
    .io_out_uop_is_br               (_slots_8_io_out_uop_is_br),
    .io_out_uop_is_jalr             (_slots_8_io_out_uop_is_jalr),
    .io_out_uop_is_jal              (_slots_8_io_out_uop_is_jal),
    .io_out_uop_is_sfb              (_slots_8_io_out_uop_is_sfb),
    .io_out_uop_br_mask             (_slots_8_io_out_uop_br_mask),
    .io_out_uop_br_tag              (_slots_8_io_out_uop_br_tag),
    .io_out_uop_ftq_idx             (_slots_8_io_out_uop_ftq_idx),
    .io_out_uop_edge_inst           (_slots_8_io_out_uop_edge_inst),
    .io_out_uop_pc_lob              (_slots_8_io_out_uop_pc_lob),
    .io_out_uop_taken               (_slots_8_io_out_uop_taken),
    .io_out_uop_imm_packed          (_slots_8_io_out_uop_imm_packed),
    .io_out_uop_csr_addr            (_slots_8_io_out_uop_csr_addr),
    .io_out_uop_rob_idx             (_slots_8_io_out_uop_rob_idx),
    .io_out_uop_ldq_idx             (_slots_8_io_out_uop_ldq_idx),
    .io_out_uop_stq_idx             (_slots_8_io_out_uop_stq_idx),
    .io_out_uop_rxq_idx             (_slots_8_io_out_uop_rxq_idx),
    .io_out_uop_pdst                (_slots_8_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_8_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_8_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_8_io_out_uop_prs3),
    .io_out_uop_ppred               (_slots_8_io_out_uop_ppred),
    .io_out_uop_prs1_busy           (_slots_8_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_8_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_8_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_8_io_out_uop_ppred_busy),
    .io_out_uop_stale_pdst          (_slots_8_io_out_uop_stale_pdst),
    .io_out_uop_exception           (_slots_8_io_out_uop_exception),
    .io_out_uop_exc_cause           (_slots_8_io_out_uop_exc_cause),
    .io_out_uop_bypassable          (_slots_8_io_out_uop_bypassable),
    .io_out_uop_mem_cmd             (_slots_8_io_out_uop_mem_cmd),
    .io_out_uop_mem_size            (_slots_8_io_out_uop_mem_size),
    .io_out_uop_mem_signed          (_slots_8_io_out_uop_mem_signed),
    .io_out_uop_is_fence            (_slots_8_io_out_uop_is_fence),
    .io_out_uop_is_fencei           (_slots_8_io_out_uop_is_fencei),
    .io_out_uop_is_amo              (_slots_8_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_8_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_8_io_out_uop_uses_stq),
    .io_out_uop_is_sys_pc2epc       (_slots_8_io_out_uop_is_sys_pc2epc),
    .io_out_uop_is_unique           (_slots_8_io_out_uop_is_unique),
    .io_out_uop_flush_on_commit     (_slots_8_io_out_uop_flush_on_commit),
    .io_out_uop_ldst_is_rs1         (_slots_8_io_out_uop_ldst_is_rs1),
    .io_out_uop_ldst                (_slots_8_io_out_uop_ldst),
    .io_out_uop_lrs1                (_slots_8_io_out_uop_lrs1),
    .io_out_uop_lrs2                (_slots_8_io_out_uop_lrs2),
    .io_out_uop_lrs3                (_slots_8_io_out_uop_lrs3),
    .io_out_uop_ldst_val            (_slots_8_io_out_uop_ldst_val),
    .io_out_uop_dst_rtype           (_slots_8_io_out_uop_dst_rtype),
    .io_out_uop_lrs1_rtype          (_slots_8_io_out_uop_lrs1_rtype),
    .io_out_uop_lrs2_rtype          (_slots_8_io_out_uop_lrs2_rtype),
    .io_out_uop_frs3_en             (_slots_8_io_out_uop_frs3_en),
    .io_out_uop_fp_val              (_slots_8_io_out_uop_fp_val),
    .io_out_uop_fp_single           (_slots_8_io_out_uop_fp_single),
    .io_out_uop_xcpt_pf_if          (_slots_8_io_out_uop_xcpt_pf_if),
    .io_out_uop_xcpt_ae_if          (_slots_8_io_out_uop_xcpt_ae_if),
    .io_out_uop_xcpt_ma_if          (_slots_8_io_out_uop_xcpt_ma_if),
    .io_out_uop_bp_debug_if         (_slots_8_io_out_uop_bp_debug_if),
    .io_out_uop_bp_xcpt_if          (_slots_8_io_out_uop_bp_xcpt_if),
    .io_out_uop_debug_fsrc          (_slots_8_io_out_uop_debug_fsrc),
    .io_out_uop_debug_tsrc          (_slots_8_io_out_uop_debug_tsrc),
    .io_uop_uopc                    (_slots_8_io_uop_uopc),
    .io_uop_inst                    (_slots_8_io_uop_inst),
    .io_uop_debug_inst              (_slots_8_io_uop_debug_inst),
    .io_uop_is_rvc                  (_slots_8_io_uop_is_rvc),
    .io_uop_debug_pc                (_slots_8_io_uop_debug_pc),
    .io_uop_iq_type                 (_slots_8_io_uop_iq_type),
    .io_uop_fu_code                 (_slots_8_io_uop_fu_code),
    .io_uop_iw_state                (_slots_8_io_uop_iw_state),
    .io_uop_is_br                   (_slots_8_io_uop_is_br),
    .io_uop_is_jalr                 (_slots_8_io_uop_is_jalr),
    .io_uop_is_jal                  (_slots_8_io_uop_is_jal),
    .io_uop_is_sfb                  (_slots_8_io_uop_is_sfb),
    .io_uop_br_mask                 (_slots_8_io_uop_br_mask),
    .io_uop_br_tag                  (_slots_8_io_uop_br_tag),
    .io_uop_ftq_idx                 (_slots_8_io_uop_ftq_idx),
    .io_uop_edge_inst               (_slots_8_io_uop_edge_inst),
    .io_uop_pc_lob                  (_slots_8_io_uop_pc_lob),
    .io_uop_taken                   (_slots_8_io_uop_taken),
    .io_uop_imm_packed              (_slots_8_io_uop_imm_packed),
    .io_uop_csr_addr                (_slots_8_io_uop_csr_addr),
    .io_uop_rob_idx                 (_slots_8_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_8_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_8_io_uop_stq_idx),
    .io_uop_rxq_idx                 (_slots_8_io_uop_rxq_idx),
    .io_uop_pdst                    (_slots_8_io_uop_pdst),
    .io_uop_prs1                    (_slots_8_io_uop_prs1),
    .io_uop_prs2                    (_slots_8_io_uop_prs2),
    .io_uop_prs3                    (_slots_8_io_uop_prs3),
    .io_uop_ppred                   (_slots_8_io_uop_ppred),
    .io_uop_prs1_busy               (_slots_8_io_uop_prs1_busy),
    .io_uop_prs2_busy               (_slots_8_io_uop_prs2_busy),
    .io_uop_prs3_busy               (_slots_8_io_uop_prs3_busy),
    .io_uop_ppred_busy              (_slots_8_io_uop_ppred_busy),
    .io_uop_stale_pdst              (_slots_8_io_uop_stale_pdst),
    .io_uop_exception               (_slots_8_io_uop_exception),
    .io_uop_exc_cause               (_slots_8_io_uop_exc_cause),
    .io_uop_bypassable              (_slots_8_io_uop_bypassable),
    .io_uop_mem_cmd                 (_slots_8_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_8_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_8_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_8_io_uop_is_fence),
    .io_uop_is_fencei               (_slots_8_io_uop_is_fencei),
    .io_uop_is_amo                  (_slots_8_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_8_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_8_io_uop_uses_stq),
    .io_uop_is_sys_pc2epc           (_slots_8_io_uop_is_sys_pc2epc),
    .io_uop_is_unique               (_slots_8_io_uop_is_unique),
    .io_uop_flush_on_commit         (_slots_8_io_uop_flush_on_commit),
    .io_uop_ldst_is_rs1             (_slots_8_io_uop_ldst_is_rs1),
    .io_uop_ldst                    (_slots_8_io_uop_ldst),
    .io_uop_lrs1                    (_slots_8_io_uop_lrs1),
    .io_uop_lrs2                    (_slots_8_io_uop_lrs2),
    .io_uop_lrs3                    (_slots_8_io_uop_lrs3),
    .io_uop_ldst_val                (_slots_8_io_uop_ldst_val),
    .io_uop_dst_rtype               (_slots_8_io_uop_dst_rtype),
    .io_uop_lrs1_rtype              (_slots_8_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_8_io_uop_lrs2_rtype),
    .io_uop_frs3_en                 (_slots_8_io_uop_frs3_en),
    .io_uop_fp_val                  (_slots_8_io_uop_fp_val),
    .io_uop_fp_single               (_slots_8_io_uop_fp_single),
    .io_uop_xcpt_pf_if              (_slots_8_io_uop_xcpt_pf_if),
    .io_uop_xcpt_ae_if              (_slots_8_io_uop_xcpt_ae_if),
    .io_uop_xcpt_ma_if              (_slots_8_io_uop_xcpt_ma_if),
    .io_uop_bp_debug_if             (_slots_8_io_uop_bp_debug_if),
    .io_uop_bp_xcpt_if              (_slots_8_io_uop_bp_xcpt_if),
    .io_uop_debug_fsrc              (_slots_8_io_uop_debug_fsrc),
    .io_uop_debug_tsrc              (_slots_8_io_uop_debug_tsrc)
  );
  IssueSlot_168 slots_9 (	// issue-unit.scala:153:73
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_9_grant),	// issue-unit-age-ordered.scala:118:56
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|next_8),	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :76:49
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_in_uop_valid                (issue_slots_9_in_uop_valid),	// issue-unit-age-ordered.scala:71:48, :72:37
    .io_in_uop_bits_uopc
      (_GEN_10 ? _slots_11_io_out_uop_uopc : _slots_10_io_out_uop_uopc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_inst
      (_GEN_10 ? _slots_11_io_out_uop_inst : _slots_10_io_out_uop_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_inst
      (_GEN_10 ? _slots_11_io_out_uop_debug_inst : _slots_10_io_out_uop_debug_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_rvc
      (_GEN_10 ? _slots_11_io_out_uop_is_rvc : _slots_10_io_out_uop_is_rvc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_pc
      (_GEN_10 ? _slots_11_io_out_uop_debug_pc : _slots_10_io_out_uop_debug_pc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_iq_type
      (_GEN_10 ? _slots_11_io_out_uop_iq_type : _slots_10_io_out_uop_iq_type),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fu_code
      (_GEN_10 ? _slots_11_io_out_uop_fu_code : _slots_10_io_out_uop_fu_code),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_iw_state
      (_GEN_10 ? _slots_11_io_out_uop_iw_state : _slots_10_io_out_uop_iw_state),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_br
      (_GEN_10 ? _slots_11_io_out_uop_is_br : _slots_10_io_out_uop_is_br),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_jalr
      (_GEN_10 ? _slots_11_io_out_uop_is_jalr : _slots_10_io_out_uop_is_jalr),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_jal
      (_GEN_10 ? _slots_11_io_out_uop_is_jal : _slots_10_io_out_uop_is_jal),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_sfb
      (_GEN_10 ? _slots_11_io_out_uop_is_sfb : _slots_10_io_out_uop_is_sfb),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_br_mask
      (_GEN_10 ? _slots_11_io_out_uop_br_mask : _slots_10_io_out_uop_br_mask),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_br_tag
      (_GEN_10 ? _slots_11_io_out_uop_br_tag : _slots_10_io_out_uop_br_tag),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ftq_idx
      (_GEN_10 ? _slots_11_io_out_uop_ftq_idx : _slots_10_io_out_uop_ftq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_edge_inst
      (_GEN_10 ? _slots_11_io_out_uop_edge_inst : _slots_10_io_out_uop_edge_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_pc_lob
      (_GEN_10 ? _slots_11_io_out_uop_pc_lob : _slots_10_io_out_uop_pc_lob),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_taken
      (_GEN_10 ? _slots_11_io_out_uop_taken : _slots_10_io_out_uop_taken),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_imm_packed
      (_GEN_10 ? _slots_11_io_out_uop_imm_packed : _slots_10_io_out_uop_imm_packed),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_csr_addr
      (_GEN_10 ? _slots_11_io_out_uop_csr_addr : _slots_10_io_out_uop_csr_addr),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_rob_idx
      (_GEN_10 ? _slots_11_io_out_uop_rob_idx : _slots_10_io_out_uop_rob_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldq_idx
      (_GEN_10 ? _slots_11_io_out_uop_ldq_idx : _slots_10_io_out_uop_ldq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_stq_idx
      (_GEN_10 ? _slots_11_io_out_uop_stq_idx : _slots_10_io_out_uop_stq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_rxq_idx
      (_GEN_10 ? _slots_11_io_out_uop_rxq_idx : _slots_10_io_out_uop_rxq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_pdst
      (_GEN_10 ? _slots_11_io_out_uop_pdst : _slots_10_io_out_uop_pdst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs1
      (_GEN_10 ? _slots_11_io_out_uop_prs1 : _slots_10_io_out_uop_prs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs2
      (_GEN_10 ? _slots_11_io_out_uop_prs2 : _slots_10_io_out_uop_prs2),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs3
      (_GEN_10 ? _slots_11_io_out_uop_prs3 : _slots_10_io_out_uop_prs3),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ppred
      (_GEN_10 ? _slots_11_io_out_uop_ppred : _slots_10_io_out_uop_ppred),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs1_busy
      (_GEN_10 ? _slots_11_io_out_uop_prs1_busy : _slots_10_io_out_uop_prs1_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs2_busy
      (_GEN_10 ? _slots_11_io_out_uop_prs2_busy : _slots_10_io_out_uop_prs2_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs3_busy
      (_GEN_10 ? _slots_11_io_out_uop_prs3_busy : _slots_10_io_out_uop_prs3_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ppred_busy
      (_GEN_10 ? _slots_11_io_out_uop_ppred_busy : _slots_10_io_out_uop_ppred_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_stale_pdst
      (_GEN_10 ? _slots_11_io_out_uop_stale_pdst : _slots_10_io_out_uop_stale_pdst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_exception
      (_GEN_10 ? _slots_11_io_out_uop_exception : _slots_10_io_out_uop_exception),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_exc_cause
      (_GEN_10 ? _slots_11_io_out_uop_exc_cause : _slots_10_io_out_uop_exc_cause),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bypassable
      (_GEN_10 ? _slots_11_io_out_uop_bypassable : _slots_10_io_out_uop_bypassable),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_cmd
      (_GEN_10 ? _slots_11_io_out_uop_mem_cmd : _slots_10_io_out_uop_mem_cmd),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_size
      (_GEN_10 ? _slots_11_io_out_uop_mem_size : _slots_10_io_out_uop_mem_size),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_signed
      (_GEN_10 ? _slots_11_io_out_uop_mem_signed : _slots_10_io_out_uop_mem_signed),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_fence
      (_GEN_10 ? _slots_11_io_out_uop_is_fence : _slots_10_io_out_uop_is_fence),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_fencei
      (_GEN_10 ? _slots_11_io_out_uop_is_fencei : _slots_10_io_out_uop_is_fencei),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_amo
      (_GEN_10 ? _slots_11_io_out_uop_is_amo : _slots_10_io_out_uop_is_amo),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_uses_ldq
      (_GEN_10 ? _slots_11_io_out_uop_uses_ldq : _slots_10_io_out_uop_uses_ldq),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_uses_stq
      (_GEN_10 ? _slots_11_io_out_uop_uses_stq : _slots_10_io_out_uop_uses_stq),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_sys_pc2epc
      (_GEN_10 ? _slots_11_io_out_uop_is_sys_pc2epc : _slots_10_io_out_uop_is_sys_pc2epc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_unique
      (_GEN_10 ? _slots_11_io_out_uop_is_unique : _slots_10_io_out_uop_is_unique),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_flush_on_commit
      (_GEN_10
         ? _slots_11_io_out_uop_flush_on_commit
         : _slots_10_io_out_uop_flush_on_commit),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst_is_rs1
      (_GEN_10 ? _slots_11_io_out_uop_ldst_is_rs1 : _slots_10_io_out_uop_ldst_is_rs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst
      (_GEN_10 ? _slots_11_io_out_uop_ldst : _slots_10_io_out_uop_ldst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs1
      (_GEN_10 ? _slots_11_io_out_uop_lrs1 : _slots_10_io_out_uop_lrs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs2
      (_GEN_10 ? _slots_11_io_out_uop_lrs2 : _slots_10_io_out_uop_lrs2),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs3
      (_GEN_10 ? _slots_11_io_out_uop_lrs3 : _slots_10_io_out_uop_lrs3),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst_val
      (_GEN_10 ? _slots_11_io_out_uop_ldst_val : _slots_10_io_out_uop_ldst_val),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_dst_rtype
      (_GEN_10 ? _slots_11_io_out_uop_dst_rtype : _slots_10_io_out_uop_dst_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs1_rtype
      (_GEN_10 ? _slots_11_io_out_uop_lrs1_rtype : _slots_10_io_out_uop_lrs1_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs2_rtype
      (_GEN_10 ? _slots_11_io_out_uop_lrs2_rtype : _slots_10_io_out_uop_lrs2_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_frs3_en
      (_GEN_10 ? _slots_11_io_out_uop_frs3_en : _slots_10_io_out_uop_frs3_en),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fp_val
      (_GEN_10 ? _slots_11_io_out_uop_fp_val : _slots_10_io_out_uop_fp_val),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fp_single
      (_GEN_10 ? _slots_11_io_out_uop_fp_single : _slots_10_io_out_uop_fp_single),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_pf_if
      (_GEN_10 ? _slots_11_io_out_uop_xcpt_pf_if : _slots_10_io_out_uop_xcpt_pf_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_ae_if
      (_GEN_10 ? _slots_11_io_out_uop_xcpt_ae_if : _slots_10_io_out_uop_xcpt_ae_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_ma_if
      (_GEN_10 ? _slots_11_io_out_uop_xcpt_ma_if : _slots_10_io_out_uop_xcpt_ma_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bp_debug_if
      (_GEN_10 ? _slots_11_io_out_uop_bp_debug_if : _slots_10_io_out_uop_bp_debug_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bp_xcpt_if
      (_GEN_10 ? _slots_11_io_out_uop_bp_xcpt_if : _slots_10_io_out_uop_bp_xcpt_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_fsrc
      (_GEN_10 ? _slots_11_io_out_uop_debug_fsrc : _slots_10_io_out_uop_debug_fsrc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_tsrc
      (_GEN_10 ? _slots_11_io_out_uop_debug_tsrc : _slots_10_io_out_uop_debug_tsrc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_valid                       (_slots_9_io_valid),
    .io_will_be_valid               (_slots_9_io_will_be_valid),
    .io_request                     (_slots_9_io_request),
    .io_out_uop_uopc                (_slots_9_io_out_uop_uopc),
    .io_out_uop_inst                (_slots_9_io_out_uop_inst),
    .io_out_uop_debug_inst          (_slots_9_io_out_uop_debug_inst),
    .io_out_uop_is_rvc              (_slots_9_io_out_uop_is_rvc),
    .io_out_uop_debug_pc            (_slots_9_io_out_uop_debug_pc),
    .io_out_uop_iq_type             (_slots_9_io_out_uop_iq_type),
    .io_out_uop_fu_code             (_slots_9_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_9_io_out_uop_iw_state),
    .io_out_uop_is_br               (_slots_9_io_out_uop_is_br),
    .io_out_uop_is_jalr             (_slots_9_io_out_uop_is_jalr),
    .io_out_uop_is_jal              (_slots_9_io_out_uop_is_jal),
    .io_out_uop_is_sfb              (_slots_9_io_out_uop_is_sfb),
    .io_out_uop_br_mask             (_slots_9_io_out_uop_br_mask),
    .io_out_uop_br_tag              (_slots_9_io_out_uop_br_tag),
    .io_out_uop_ftq_idx             (_slots_9_io_out_uop_ftq_idx),
    .io_out_uop_edge_inst           (_slots_9_io_out_uop_edge_inst),
    .io_out_uop_pc_lob              (_slots_9_io_out_uop_pc_lob),
    .io_out_uop_taken               (_slots_9_io_out_uop_taken),
    .io_out_uop_imm_packed          (_slots_9_io_out_uop_imm_packed),
    .io_out_uop_csr_addr            (_slots_9_io_out_uop_csr_addr),
    .io_out_uop_rob_idx             (_slots_9_io_out_uop_rob_idx),
    .io_out_uop_ldq_idx             (_slots_9_io_out_uop_ldq_idx),
    .io_out_uop_stq_idx             (_slots_9_io_out_uop_stq_idx),
    .io_out_uop_rxq_idx             (_slots_9_io_out_uop_rxq_idx),
    .io_out_uop_pdst                (_slots_9_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_9_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_9_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_9_io_out_uop_prs3),
    .io_out_uop_ppred               (_slots_9_io_out_uop_ppred),
    .io_out_uop_prs1_busy           (_slots_9_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_9_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_9_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_9_io_out_uop_ppred_busy),
    .io_out_uop_stale_pdst          (_slots_9_io_out_uop_stale_pdst),
    .io_out_uop_exception           (_slots_9_io_out_uop_exception),
    .io_out_uop_exc_cause           (_slots_9_io_out_uop_exc_cause),
    .io_out_uop_bypassable          (_slots_9_io_out_uop_bypassable),
    .io_out_uop_mem_cmd             (_slots_9_io_out_uop_mem_cmd),
    .io_out_uop_mem_size            (_slots_9_io_out_uop_mem_size),
    .io_out_uop_mem_signed          (_slots_9_io_out_uop_mem_signed),
    .io_out_uop_is_fence            (_slots_9_io_out_uop_is_fence),
    .io_out_uop_is_fencei           (_slots_9_io_out_uop_is_fencei),
    .io_out_uop_is_amo              (_slots_9_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_9_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_9_io_out_uop_uses_stq),
    .io_out_uop_is_sys_pc2epc       (_slots_9_io_out_uop_is_sys_pc2epc),
    .io_out_uop_is_unique           (_slots_9_io_out_uop_is_unique),
    .io_out_uop_flush_on_commit     (_slots_9_io_out_uop_flush_on_commit),
    .io_out_uop_ldst_is_rs1         (_slots_9_io_out_uop_ldst_is_rs1),
    .io_out_uop_ldst                (_slots_9_io_out_uop_ldst),
    .io_out_uop_lrs1                (_slots_9_io_out_uop_lrs1),
    .io_out_uop_lrs2                (_slots_9_io_out_uop_lrs2),
    .io_out_uop_lrs3                (_slots_9_io_out_uop_lrs3),
    .io_out_uop_ldst_val            (_slots_9_io_out_uop_ldst_val),
    .io_out_uop_dst_rtype           (_slots_9_io_out_uop_dst_rtype),
    .io_out_uop_lrs1_rtype          (_slots_9_io_out_uop_lrs1_rtype),
    .io_out_uop_lrs2_rtype          (_slots_9_io_out_uop_lrs2_rtype),
    .io_out_uop_frs3_en             (_slots_9_io_out_uop_frs3_en),
    .io_out_uop_fp_val              (_slots_9_io_out_uop_fp_val),
    .io_out_uop_fp_single           (_slots_9_io_out_uop_fp_single),
    .io_out_uop_xcpt_pf_if          (_slots_9_io_out_uop_xcpt_pf_if),
    .io_out_uop_xcpt_ae_if          (_slots_9_io_out_uop_xcpt_ae_if),
    .io_out_uop_xcpt_ma_if          (_slots_9_io_out_uop_xcpt_ma_if),
    .io_out_uop_bp_debug_if         (_slots_9_io_out_uop_bp_debug_if),
    .io_out_uop_bp_xcpt_if          (_slots_9_io_out_uop_bp_xcpt_if),
    .io_out_uop_debug_fsrc          (_slots_9_io_out_uop_debug_fsrc),
    .io_out_uop_debug_tsrc          (_slots_9_io_out_uop_debug_tsrc),
    .io_uop_uopc                    (_slots_9_io_uop_uopc),
    .io_uop_inst                    (_slots_9_io_uop_inst),
    .io_uop_debug_inst              (_slots_9_io_uop_debug_inst),
    .io_uop_is_rvc                  (_slots_9_io_uop_is_rvc),
    .io_uop_debug_pc                (_slots_9_io_uop_debug_pc),
    .io_uop_iq_type                 (_slots_9_io_uop_iq_type),
    .io_uop_fu_code                 (_slots_9_io_uop_fu_code),
    .io_uop_iw_state                (_slots_9_io_uop_iw_state),
    .io_uop_is_br                   (_slots_9_io_uop_is_br),
    .io_uop_is_jalr                 (_slots_9_io_uop_is_jalr),
    .io_uop_is_jal                  (_slots_9_io_uop_is_jal),
    .io_uop_is_sfb                  (_slots_9_io_uop_is_sfb),
    .io_uop_br_mask                 (_slots_9_io_uop_br_mask),
    .io_uop_br_tag                  (_slots_9_io_uop_br_tag),
    .io_uop_ftq_idx                 (_slots_9_io_uop_ftq_idx),
    .io_uop_edge_inst               (_slots_9_io_uop_edge_inst),
    .io_uop_pc_lob                  (_slots_9_io_uop_pc_lob),
    .io_uop_taken                   (_slots_9_io_uop_taken),
    .io_uop_imm_packed              (_slots_9_io_uop_imm_packed),
    .io_uop_csr_addr                (_slots_9_io_uop_csr_addr),
    .io_uop_rob_idx                 (_slots_9_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_9_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_9_io_uop_stq_idx),
    .io_uop_rxq_idx                 (_slots_9_io_uop_rxq_idx),
    .io_uop_pdst                    (_slots_9_io_uop_pdst),
    .io_uop_prs1                    (_slots_9_io_uop_prs1),
    .io_uop_prs2                    (_slots_9_io_uop_prs2),
    .io_uop_prs3                    (_slots_9_io_uop_prs3),
    .io_uop_ppred                   (_slots_9_io_uop_ppred),
    .io_uop_prs1_busy               (_slots_9_io_uop_prs1_busy),
    .io_uop_prs2_busy               (_slots_9_io_uop_prs2_busy),
    .io_uop_prs3_busy               (_slots_9_io_uop_prs3_busy),
    .io_uop_ppred_busy              (_slots_9_io_uop_ppred_busy),
    .io_uop_stale_pdst              (_slots_9_io_uop_stale_pdst),
    .io_uop_exception               (_slots_9_io_uop_exception),
    .io_uop_exc_cause               (_slots_9_io_uop_exc_cause),
    .io_uop_bypassable              (_slots_9_io_uop_bypassable),
    .io_uop_mem_cmd                 (_slots_9_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_9_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_9_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_9_io_uop_is_fence),
    .io_uop_is_fencei               (_slots_9_io_uop_is_fencei),
    .io_uop_is_amo                  (_slots_9_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_9_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_9_io_uop_uses_stq),
    .io_uop_is_sys_pc2epc           (_slots_9_io_uop_is_sys_pc2epc),
    .io_uop_is_unique               (_slots_9_io_uop_is_unique),
    .io_uop_flush_on_commit         (_slots_9_io_uop_flush_on_commit),
    .io_uop_ldst_is_rs1             (_slots_9_io_uop_ldst_is_rs1),
    .io_uop_ldst                    (_slots_9_io_uop_ldst),
    .io_uop_lrs1                    (_slots_9_io_uop_lrs1),
    .io_uop_lrs2                    (_slots_9_io_uop_lrs2),
    .io_uop_lrs3                    (_slots_9_io_uop_lrs3),
    .io_uop_ldst_val                (_slots_9_io_uop_ldst_val),
    .io_uop_dst_rtype               (_slots_9_io_uop_dst_rtype),
    .io_uop_lrs1_rtype              (_slots_9_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_9_io_uop_lrs2_rtype),
    .io_uop_frs3_en                 (_slots_9_io_uop_frs3_en),
    .io_uop_fp_val                  (_slots_9_io_uop_fp_val),
    .io_uop_fp_single               (_slots_9_io_uop_fp_single),
    .io_uop_xcpt_pf_if              (_slots_9_io_uop_xcpt_pf_if),
    .io_uop_xcpt_ae_if              (_slots_9_io_uop_xcpt_ae_if),
    .io_uop_xcpt_ma_if              (_slots_9_io_uop_xcpt_ma_if),
    .io_uop_bp_debug_if             (_slots_9_io_uop_bp_debug_if),
    .io_uop_bp_xcpt_if              (_slots_9_io_uop_bp_xcpt_if),
    .io_uop_debug_fsrc              (_slots_9_io_uop_debug_fsrc),
    .io_uop_debug_tsrc              (_slots_9_io_uop_debug_tsrc)
  );
  IssueSlot_168 slots_10 (	// issue-unit.scala:153:73
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_10_grant),	// issue-unit-age-ordered.scala:118:56
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|next_9),	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :76:49
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_in_uop_valid                (issue_slots_10_in_uop_valid),	// issue-unit-age-ordered.scala:71:48, :72:37
    .io_in_uop_bits_uopc
      (_GEN_11 ? _slots_12_io_out_uop_uopc : _slots_11_io_out_uop_uopc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_inst
      (_GEN_11 ? _slots_12_io_out_uop_inst : _slots_11_io_out_uop_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_inst
      (_GEN_11 ? _slots_12_io_out_uop_debug_inst : _slots_11_io_out_uop_debug_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_rvc
      (_GEN_11 ? _slots_12_io_out_uop_is_rvc : _slots_11_io_out_uop_is_rvc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_pc
      (_GEN_11 ? _slots_12_io_out_uop_debug_pc : _slots_11_io_out_uop_debug_pc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_iq_type
      (_GEN_11 ? _slots_12_io_out_uop_iq_type : _slots_11_io_out_uop_iq_type),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fu_code
      (_GEN_11 ? _slots_12_io_out_uop_fu_code : _slots_11_io_out_uop_fu_code),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_iw_state
      (_GEN_11 ? _slots_12_io_out_uop_iw_state : _slots_11_io_out_uop_iw_state),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_br
      (_GEN_11 ? _slots_12_io_out_uop_is_br : _slots_11_io_out_uop_is_br),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_jalr
      (_GEN_11 ? _slots_12_io_out_uop_is_jalr : _slots_11_io_out_uop_is_jalr),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_jal
      (_GEN_11 ? _slots_12_io_out_uop_is_jal : _slots_11_io_out_uop_is_jal),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_sfb
      (_GEN_11 ? _slots_12_io_out_uop_is_sfb : _slots_11_io_out_uop_is_sfb),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_br_mask
      (_GEN_11 ? _slots_12_io_out_uop_br_mask : _slots_11_io_out_uop_br_mask),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_br_tag
      (_GEN_11 ? _slots_12_io_out_uop_br_tag : _slots_11_io_out_uop_br_tag),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ftq_idx
      (_GEN_11 ? _slots_12_io_out_uop_ftq_idx : _slots_11_io_out_uop_ftq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_edge_inst
      (_GEN_11 ? _slots_12_io_out_uop_edge_inst : _slots_11_io_out_uop_edge_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_pc_lob
      (_GEN_11 ? _slots_12_io_out_uop_pc_lob : _slots_11_io_out_uop_pc_lob),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_taken
      (_GEN_11 ? _slots_12_io_out_uop_taken : _slots_11_io_out_uop_taken),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_imm_packed
      (_GEN_11 ? _slots_12_io_out_uop_imm_packed : _slots_11_io_out_uop_imm_packed),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_csr_addr
      (_GEN_11 ? _slots_12_io_out_uop_csr_addr : _slots_11_io_out_uop_csr_addr),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_rob_idx
      (_GEN_11 ? _slots_12_io_out_uop_rob_idx : _slots_11_io_out_uop_rob_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldq_idx
      (_GEN_11 ? _slots_12_io_out_uop_ldq_idx : _slots_11_io_out_uop_ldq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_stq_idx
      (_GEN_11 ? _slots_12_io_out_uop_stq_idx : _slots_11_io_out_uop_stq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_rxq_idx
      (_GEN_11 ? _slots_12_io_out_uop_rxq_idx : _slots_11_io_out_uop_rxq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_pdst
      (_GEN_11 ? _slots_12_io_out_uop_pdst : _slots_11_io_out_uop_pdst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs1
      (_GEN_11 ? _slots_12_io_out_uop_prs1 : _slots_11_io_out_uop_prs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs2
      (_GEN_11 ? _slots_12_io_out_uop_prs2 : _slots_11_io_out_uop_prs2),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs3
      (_GEN_11 ? _slots_12_io_out_uop_prs3 : _slots_11_io_out_uop_prs3),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ppred
      (_GEN_11 ? _slots_12_io_out_uop_ppred : _slots_11_io_out_uop_ppred),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs1_busy
      (_GEN_11 ? _slots_12_io_out_uop_prs1_busy : _slots_11_io_out_uop_prs1_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs2_busy
      (_GEN_11 ? _slots_12_io_out_uop_prs2_busy : _slots_11_io_out_uop_prs2_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs3_busy
      (_GEN_11 ? _slots_12_io_out_uop_prs3_busy : _slots_11_io_out_uop_prs3_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ppred_busy
      (_GEN_11 ? _slots_12_io_out_uop_ppred_busy : _slots_11_io_out_uop_ppred_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_stale_pdst
      (_GEN_11 ? _slots_12_io_out_uop_stale_pdst : _slots_11_io_out_uop_stale_pdst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_exception
      (_GEN_11 ? _slots_12_io_out_uop_exception : _slots_11_io_out_uop_exception),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_exc_cause
      (_GEN_11 ? _slots_12_io_out_uop_exc_cause : _slots_11_io_out_uop_exc_cause),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bypassable
      (_GEN_11 ? _slots_12_io_out_uop_bypassable : _slots_11_io_out_uop_bypassable),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_cmd
      (_GEN_11 ? _slots_12_io_out_uop_mem_cmd : _slots_11_io_out_uop_mem_cmd),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_size
      (_GEN_11 ? _slots_12_io_out_uop_mem_size : _slots_11_io_out_uop_mem_size),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_signed
      (_GEN_11 ? _slots_12_io_out_uop_mem_signed : _slots_11_io_out_uop_mem_signed),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_fence
      (_GEN_11 ? _slots_12_io_out_uop_is_fence : _slots_11_io_out_uop_is_fence),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_fencei
      (_GEN_11 ? _slots_12_io_out_uop_is_fencei : _slots_11_io_out_uop_is_fencei),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_amo
      (_GEN_11 ? _slots_12_io_out_uop_is_amo : _slots_11_io_out_uop_is_amo),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_uses_ldq
      (_GEN_11 ? _slots_12_io_out_uop_uses_ldq : _slots_11_io_out_uop_uses_ldq),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_uses_stq
      (_GEN_11 ? _slots_12_io_out_uop_uses_stq : _slots_11_io_out_uop_uses_stq),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_sys_pc2epc
      (_GEN_11 ? _slots_12_io_out_uop_is_sys_pc2epc : _slots_11_io_out_uop_is_sys_pc2epc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_unique
      (_GEN_11 ? _slots_12_io_out_uop_is_unique : _slots_11_io_out_uop_is_unique),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_flush_on_commit
      (_GEN_11
         ? _slots_12_io_out_uop_flush_on_commit
         : _slots_11_io_out_uop_flush_on_commit),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst_is_rs1
      (_GEN_11 ? _slots_12_io_out_uop_ldst_is_rs1 : _slots_11_io_out_uop_ldst_is_rs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst
      (_GEN_11 ? _slots_12_io_out_uop_ldst : _slots_11_io_out_uop_ldst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs1
      (_GEN_11 ? _slots_12_io_out_uop_lrs1 : _slots_11_io_out_uop_lrs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs2
      (_GEN_11 ? _slots_12_io_out_uop_lrs2 : _slots_11_io_out_uop_lrs2),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs3
      (_GEN_11 ? _slots_12_io_out_uop_lrs3 : _slots_11_io_out_uop_lrs3),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst_val
      (_GEN_11 ? _slots_12_io_out_uop_ldst_val : _slots_11_io_out_uop_ldst_val),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_dst_rtype
      (_GEN_11 ? _slots_12_io_out_uop_dst_rtype : _slots_11_io_out_uop_dst_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs1_rtype
      (_GEN_11 ? _slots_12_io_out_uop_lrs1_rtype : _slots_11_io_out_uop_lrs1_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs2_rtype
      (_GEN_11 ? _slots_12_io_out_uop_lrs2_rtype : _slots_11_io_out_uop_lrs2_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_frs3_en
      (_GEN_11 ? _slots_12_io_out_uop_frs3_en : _slots_11_io_out_uop_frs3_en),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fp_val
      (_GEN_11 ? _slots_12_io_out_uop_fp_val : _slots_11_io_out_uop_fp_val),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fp_single
      (_GEN_11 ? _slots_12_io_out_uop_fp_single : _slots_11_io_out_uop_fp_single),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_pf_if
      (_GEN_11 ? _slots_12_io_out_uop_xcpt_pf_if : _slots_11_io_out_uop_xcpt_pf_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_ae_if
      (_GEN_11 ? _slots_12_io_out_uop_xcpt_ae_if : _slots_11_io_out_uop_xcpt_ae_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_ma_if
      (_GEN_11 ? _slots_12_io_out_uop_xcpt_ma_if : _slots_11_io_out_uop_xcpt_ma_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bp_debug_if
      (_GEN_11 ? _slots_12_io_out_uop_bp_debug_if : _slots_11_io_out_uop_bp_debug_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bp_xcpt_if
      (_GEN_11 ? _slots_12_io_out_uop_bp_xcpt_if : _slots_11_io_out_uop_bp_xcpt_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_fsrc
      (_GEN_11 ? _slots_12_io_out_uop_debug_fsrc : _slots_11_io_out_uop_debug_fsrc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_tsrc
      (_GEN_11 ? _slots_12_io_out_uop_debug_tsrc : _slots_11_io_out_uop_debug_tsrc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_valid                       (_slots_10_io_valid),
    .io_will_be_valid               (_slots_10_io_will_be_valid),
    .io_request                     (_slots_10_io_request),
    .io_out_uop_uopc                (_slots_10_io_out_uop_uopc),
    .io_out_uop_inst                (_slots_10_io_out_uop_inst),
    .io_out_uop_debug_inst          (_slots_10_io_out_uop_debug_inst),
    .io_out_uop_is_rvc              (_slots_10_io_out_uop_is_rvc),
    .io_out_uop_debug_pc            (_slots_10_io_out_uop_debug_pc),
    .io_out_uop_iq_type             (_slots_10_io_out_uop_iq_type),
    .io_out_uop_fu_code             (_slots_10_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_10_io_out_uop_iw_state),
    .io_out_uop_is_br               (_slots_10_io_out_uop_is_br),
    .io_out_uop_is_jalr             (_slots_10_io_out_uop_is_jalr),
    .io_out_uop_is_jal              (_slots_10_io_out_uop_is_jal),
    .io_out_uop_is_sfb              (_slots_10_io_out_uop_is_sfb),
    .io_out_uop_br_mask             (_slots_10_io_out_uop_br_mask),
    .io_out_uop_br_tag              (_slots_10_io_out_uop_br_tag),
    .io_out_uop_ftq_idx             (_slots_10_io_out_uop_ftq_idx),
    .io_out_uop_edge_inst           (_slots_10_io_out_uop_edge_inst),
    .io_out_uop_pc_lob              (_slots_10_io_out_uop_pc_lob),
    .io_out_uop_taken               (_slots_10_io_out_uop_taken),
    .io_out_uop_imm_packed          (_slots_10_io_out_uop_imm_packed),
    .io_out_uop_csr_addr            (_slots_10_io_out_uop_csr_addr),
    .io_out_uop_rob_idx             (_slots_10_io_out_uop_rob_idx),
    .io_out_uop_ldq_idx             (_slots_10_io_out_uop_ldq_idx),
    .io_out_uop_stq_idx             (_slots_10_io_out_uop_stq_idx),
    .io_out_uop_rxq_idx             (_slots_10_io_out_uop_rxq_idx),
    .io_out_uop_pdst                (_slots_10_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_10_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_10_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_10_io_out_uop_prs3),
    .io_out_uop_ppred               (_slots_10_io_out_uop_ppred),
    .io_out_uop_prs1_busy           (_slots_10_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_10_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_10_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_10_io_out_uop_ppred_busy),
    .io_out_uop_stale_pdst          (_slots_10_io_out_uop_stale_pdst),
    .io_out_uop_exception           (_slots_10_io_out_uop_exception),
    .io_out_uop_exc_cause           (_slots_10_io_out_uop_exc_cause),
    .io_out_uop_bypassable          (_slots_10_io_out_uop_bypassable),
    .io_out_uop_mem_cmd             (_slots_10_io_out_uop_mem_cmd),
    .io_out_uop_mem_size            (_slots_10_io_out_uop_mem_size),
    .io_out_uop_mem_signed          (_slots_10_io_out_uop_mem_signed),
    .io_out_uop_is_fence            (_slots_10_io_out_uop_is_fence),
    .io_out_uop_is_fencei           (_slots_10_io_out_uop_is_fencei),
    .io_out_uop_is_amo              (_slots_10_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_10_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_10_io_out_uop_uses_stq),
    .io_out_uop_is_sys_pc2epc       (_slots_10_io_out_uop_is_sys_pc2epc),
    .io_out_uop_is_unique           (_slots_10_io_out_uop_is_unique),
    .io_out_uop_flush_on_commit     (_slots_10_io_out_uop_flush_on_commit),
    .io_out_uop_ldst_is_rs1         (_slots_10_io_out_uop_ldst_is_rs1),
    .io_out_uop_ldst                (_slots_10_io_out_uop_ldst),
    .io_out_uop_lrs1                (_slots_10_io_out_uop_lrs1),
    .io_out_uop_lrs2                (_slots_10_io_out_uop_lrs2),
    .io_out_uop_lrs3                (_slots_10_io_out_uop_lrs3),
    .io_out_uop_ldst_val            (_slots_10_io_out_uop_ldst_val),
    .io_out_uop_dst_rtype           (_slots_10_io_out_uop_dst_rtype),
    .io_out_uop_lrs1_rtype          (_slots_10_io_out_uop_lrs1_rtype),
    .io_out_uop_lrs2_rtype          (_slots_10_io_out_uop_lrs2_rtype),
    .io_out_uop_frs3_en             (_slots_10_io_out_uop_frs3_en),
    .io_out_uop_fp_val              (_slots_10_io_out_uop_fp_val),
    .io_out_uop_fp_single           (_slots_10_io_out_uop_fp_single),
    .io_out_uop_xcpt_pf_if          (_slots_10_io_out_uop_xcpt_pf_if),
    .io_out_uop_xcpt_ae_if          (_slots_10_io_out_uop_xcpt_ae_if),
    .io_out_uop_xcpt_ma_if          (_slots_10_io_out_uop_xcpt_ma_if),
    .io_out_uop_bp_debug_if         (_slots_10_io_out_uop_bp_debug_if),
    .io_out_uop_bp_xcpt_if          (_slots_10_io_out_uop_bp_xcpt_if),
    .io_out_uop_debug_fsrc          (_slots_10_io_out_uop_debug_fsrc),
    .io_out_uop_debug_tsrc          (_slots_10_io_out_uop_debug_tsrc),
    .io_uop_uopc                    (_slots_10_io_uop_uopc),
    .io_uop_inst                    (_slots_10_io_uop_inst),
    .io_uop_debug_inst              (_slots_10_io_uop_debug_inst),
    .io_uop_is_rvc                  (_slots_10_io_uop_is_rvc),
    .io_uop_debug_pc                (_slots_10_io_uop_debug_pc),
    .io_uop_iq_type                 (_slots_10_io_uop_iq_type),
    .io_uop_fu_code                 (_slots_10_io_uop_fu_code),
    .io_uop_iw_state                (_slots_10_io_uop_iw_state),
    .io_uop_is_br                   (_slots_10_io_uop_is_br),
    .io_uop_is_jalr                 (_slots_10_io_uop_is_jalr),
    .io_uop_is_jal                  (_slots_10_io_uop_is_jal),
    .io_uop_is_sfb                  (_slots_10_io_uop_is_sfb),
    .io_uop_br_mask                 (_slots_10_io_uop_br_mask),
    .io_uop_br_tag                  (_slots_10_io_uop_br_tag),
    .io_uop_ftq_idx                 (_slots_10_io_uop_ftq_idx),
    .io_uop_edge_inst               (_slots_10_io_uop_edge_inst),
    .io_uop_pc_lob                  (_slots_10_io_uop_pc_lob),
    .io_uop_taken                   (_slots_10_io_uop_taken),
    .io_uop_imm_packed              (_slots_10_io_uop_imm_packed),
    .io_uop_csr_addr                (_slots_10_io_uop_csr_addr),
    .io_uop_rob_idx                 (_slots_10_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_10_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_10_io_uop_stq_idx),
    .io_uop_rxq_idx                 (_slots_10_io_uop_rxq_idx),
    .io_uop_pdst                    (_slots_10_io_uop_pdst),
    .io_uop_prs1                    (_slots_10_io_uop_prs1),
    .io_uop_prs2                    (_slots_10_io_uop_prs2),
    .io_uop_prs3                    (_slots_10_io_uop_prs3),
    .io_uop_ppred                   (_slots_10_io_uop_ppred),
    .io_uop_prs1_busy               (_slots_10_io_uop_prs1_busy),
    .io_uop_prs2_busy               (_slots_10_io_uop_prs2_busy),
    .io_uop_prs3_busy               (_slots_10_io_uop_prs3_busy),
    .io_uop_ppred_busy              (_slots_10_io_uop_ppred_busy),
    .io_uop_stale_pdst              (_slots_10_io_uop_stale_pdst),
    .io_uop_exception               (_slots_10_io_uop_exception),
    .io_uop_exc_cause               (_slots_10_io_uop_exc_cause),
    .io_uop_bypassable              (_slots_10_io_uop_bypassable),
    .io_uop_mem_cmd                 (_slots_10_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_10_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_10_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_10_io_uop_is_fence),
    .io_uop_is_fencei               (_slots_10_io_uop_is_fencei),
    .io_uop_is_amo                  (_slots_10_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_10_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_10_io_uop_uses_stq),
    .io_uop_is_sys_pc2epc           (_slots_10_io_uop_is_sys_pc2epc),
    .io_uop_is_unique               (_slots_10_io_uop_is_unique),
    .io_uop_flush_on_commit         (_slots_10_io_uop_flush_on_commit),
    .io_uop_ldst_is_rs1             (_slots_10_io_uop_ldst_is_rs1),
    .io_uop_ldst                    (_slots_10_io_uop_ldst),
    .io_uop_lrs1                    (_slots_10_io_uop_lrs1),
    .io_uop_lrs2                    (_slots_10_io_uop_lrs2),
    .io_uop_lrs3                    (_slots_10_io_uop_lrs3),
    .io_uop_ldst_val                (_slots_10_io_uop_ldst_val),
    .io_uop_dst_rtype               (_slots_10_io_uop_dst_rtype),
    .io_uop_lrs1_rtype              (_slots_10_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_10_io_uop_lrs2_rtype),
    .io_uop_frs3_en                 (_slots_10_io_uop_frs3_en),
    .io_uop_fp_val                  (_slots_10_io_uop_fp_val),
    .io_uop_fp_single               (_slots_10_io_uop_fp_single),
    .io_uop_xcpt_pf_if              (_slots_10_io_uop_xcpt_pf_if),
    .io_uop_xcpt_ae_if              (_slots_10_io_uop_xcpt_ae_if),
    .io_uop_xcpt_ma_if              (_slots_10_io_uop_xcpt_ma_if),
    .io_uop_bp_debug_if             (_slots_10_io_uop_bp_debug_if),
    .io_uop_bp_xcpt_if              (_slots_10_io_uop_bp_xcpt_if),
    .io_uop_debug_fsrc              (_slots_10_io_uop_debug_fsrc),
    .io_uop_debug_tsrc              (_slots_10_io_uop_debug_tsrc)
  );
  IssueSlot_168 slots_11 (	// issue-unit.scala:153:73
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_11_grant),	// issue-unit-age-ordered.scala:118:56
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|next_10),	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :76:49
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_in_uop_valid                (issue_slots_11_in_uop_valid),	// issue-unit-age-ordered.scala:71:48, :72:37
    .io_in_uop_bits_uopc
      (_GEN_12 ? _slots_13_io_out_uop_uopc : _slots_12_io_out_uop_uopc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_inst
      (_GEN_12 ? _slots_13_io_out_uop_inst : _slots_12_io_out_uop_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_inst
      (_GEN_12 ? _slots_13_io_out_uop_debug_inst : _slots_12_io_out_uop_debug_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_rvc
      (_GEN_12 ? _slots_13_io_out_uop_is_rvc : _slots_12_io_out_uop_is_rvc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_pc
      (_GEN_12 ? _slots_13_io_out_uop_debug_pc : _slots_12_io_out_uop_debug_pc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_iq_type
      (_GEN_12 ? _slots_13_io_out_uop_iq_type : _slots_12_io_out_uop_iq_type),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fu_code
      (_GEN_12 ? _slots_13_io_out_uop_fu_code : _slots_12_io_out_uop_fu_code),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_iw_state
      (_GEN_12 ? _slots_13_io_out_uop_iw_state : _slots_12_io_out_uop_iw_state),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_br
      (_GEN_12 ? _slots_13_io_out_uop_is_br : _slots_12_io_out_uop_is_br),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_jalr
      (_GEN_12 ? _slots_13_io_out_uop_is_jalr : _slots_12_io_out_uop_is_jalr),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_jal
      (_GEN_12 ? _slots_13_io_out_uop_is_jal : _slots_12_io_out_uop_is_jal),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_sfb
      (_GEN_12 ? _slots_13_io_out_uop_is_sfb : _slots_12_io_out_uop_is_sfb),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_br_mask
      (_GEN_12 ? _slots_13_io_out_uop_br_mask : _slots_12_io_out_uop_br_mask),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_br_tag
      (_GEN_12 ? _slots_13_io_out_uop_br_tag : _slots_12_io_out_uop_br_tag),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ftq_idx
      (_GEN_12 ? _slots_13_io_out_uop_ftq_idx : _slots_12_io_out_uop_ftq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_edge_inst
      (_GEN_12 ? _slots_13_io_out_uop_edge_inst : _slots_12_io_out_uop_edge_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_pc_lob
      (_GEN_12 ? _slots_13_io_out_uop_pc_lob : _slots_12_io_out_uop_pc_lob),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_taken
      (_GEN_12 ? _slots_13_io_out_uop_taken : _slots_12_io_out_uop_taken),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_imm_packed
      (_GEN_12 ? _slots_13_io_out_uop_imm_packed : _slots_12_io_out_uop_imm_packed),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_csr_addr
      (_GEN_12 ? _slots_13_io_out_uop_csr_addr : _slots_12_io_out_uop_csr_addr),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_rob_idx
      (_GEN_12 ? _slots_13_io_out_uop_rob_idx : _slots_12_io_out_uop_rob_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldq_idx
      (_GEN_12 ? _slots_13_io_out_uop_ldq_idx : _slots_12_io_out_uop_ldq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_stq_idx
      (_GEN_12 ? _slots_13_io_out_uop_stq_idx : _slots_12_io_out_uop_stq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_rxq_idx
      (_GEN_12 ? _slots_13_io_out_uop_rxq_idx : _slots_12_io_out_uop_rxq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_pdst
      (_GEN_12 ? _slots_13_io_out_uop_pdst : _slots_12_io_out_uop_pdst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs1
      (_GEN_12 ? _slots_13_io_out_uop_prs1 : _slots_12_io_out_uop_prs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs2
      (_GEN_12 ? _slots_13_io_out_uop_prs2 : _slots_12_io_out_uop_prs2),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs3
      (_GEN_12 ? _slots_13_io_out_uop_prs3 : _slots_12_io_out_uop_prs3),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ppred
      (_GEN_12 ? _slots_13_io_out_uop_ppred : _slots_12_io_out_uop_ppred),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs1_busy
      (_GEN_12 ? _slots_13_io_out_uop_prs1_busy : _slots_12_io_out_uop_prs1_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs2_busy
      (_GEN_12 ? _slots_13_io_out_uop_prs2_busy : _slots_12_io_out_uop_prs2_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs3_busy
      (_GEN_12 ? _slots_13_io_out_uop_prs3_busy : _slots_12_io_out_uop_prs3_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ppred_busy
      (_GEN_12 ? _slots_13_io_out_uop_ppred_busy : _slots_12_io_out_uop_ppred_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_stale_pdst
      (_GEN_12 ? _slots_13_io_out_uop_stale_pdst : _slots_12_io_out_uop_stale_pdst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_exception
      (_GEN_12 ? _slots_13_io_out_uop_exception : _slots_12_io_out_uop_exception),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_exc_cause
      (_GEN_12 ? _slots_13_io_out_uop_exc_cause : _slots_12_io_out_uop_exc_cause),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bypassable
      (_GEN_12 ? _slots_13_io_out_uop_bypassable : _slots_12_io_out_uop_bypassable),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_cmd
      (_GEN_12 ? _slots_13_io_out_uop_mem_cmd : _slots_12_io_out_uop_mem_cmd),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_size
      (_GEN_12 ? _slots_13_io_out_uop_mem_size : _slots_12_io_out_uop_mem_size),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_signed
      (_GEN_12 ? _slots_13_io_out_uop_mem_signed : _slots_12_io_out_uop_mem_signed),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_fence
      (_GEN_12 ? _slots_13_io_out_uop_is_fence : _slots_12_io_out_uop_is_fence),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_fencei
      (_GEN_12 ? _slots_13_io_out_uop_is_fencei : _slots_12_io_out_uop_is_fencei),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_amo
      (_GEN_12 ? _slots_13_io_out_uop_is_amo : _slots_12_io_out_uop_is_amo),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_uses_ldq
      (_GEN_12 ? _slots_13_io_out_uop_uses_ldq : _slots_12_io_out_uop_uses_ldq),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_uses_stq
      (_GEN_12 ? _slots_13_io_out_uop_uses_stq : _slots_12_io_out_uop_uses_stq),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_sys_pc2epc
      (_GEN_12 ? _slots_13_io_out_uop_is_sys_pc2epc : _slots_12_io_out_uop_is_sys_pc2epc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_unique
      (_GEN_12 ? _slots_13_io_out_uop_is_unique : _slots_12_io_out_uop_is_unique),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_flush_on_commit
      (_GEN_12
         ? _slots_13_io_out_uop_flush_on_commit
         : _slots_12_io_out_uop_flush_on_commit),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst_is_rs1
      (_GEN_12 ? _slots_13_io_out_uop_ldst_is_rs1 : _slots_12_io_out_uop_ldst_is_rs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst
      (_GEN_12 ? _slots_13_io_out_uop_ldst : _slots_12_io_out_uop_ldst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs1
      (_GEN_12 ? _slots_13_io_out_uop_lrs1 : _slots_12_io_out_uop_lrs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs2
      (_GEN_12 ? _slots_13_io_out_uop_lrs2 : _slots_12_io_out_uop_lrs2),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs3
      (_GEN_12 ? _slots_13_io_out_uop_lrs3 : _slots_12_io_out_uop_lrs3),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst_val
      (_GEN_12 ? _slots_13_io_out_uop_ldst_val : _slots_12_io_out_uop_ldst_val),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_dst_rtype
      (_GEN_12 ? _slots_13_io_out_uop_dst_rtype : _slots_12_io_out_uop_dst_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs1_rtype
      (_GEN_12 ? _slots_13_io_out_uop_lrs1_rtype : _slots_12_io_out_uop_lrs1_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs2_rtype
      (_GEN_12 ? _slots_13_io_out_uop_lrs2_rtype : _slots_12_io_out_uop_lrs2_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_frs3_en
      (_GEN_12 ? _slots_13_io_out_uop_frs3_en : _slots_12_io_out_uop_frs3_en),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fp_val
      (_GEN_12 ? _slots_13_io_out_uop_fp_val : _slots_12_io_out_uop_fp_val),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fp_single
      (_GEN_12 ? _slots_13_io_out_uop_fp_single : _slots_12_io_out_uop_fp_single),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_pf_if
      (_GEN_12 ? _slots_13_io_out_uop_xcpt_pf_if : _slots_12_io_out_uop_xcpt_pf_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_ae_if
      (_GEN_12 ? _slots_13_io_out_uop_xcpt_ae_if : _slots_12_io_out_uop_xcpt_ae_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_ma_if
      (_GEN_12 ? _slots_13_io_out_uop_xcpt_ma_if : _slots_12_io_out_uop_xcpt_ma_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bp_debug_if
      (_GEN_12 ? _slots_13_io_out_uop_bp_debug_if : _slots_12_io_out_uop_bp_debug_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bp_xcpt_if
      (_GEN_12 ? _slots_13_io_out_uop_bp_xcpt_if : _slots_12_io_out_uop_bp_xcpt_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_fsrc
      (_GEN_12 ? _slots_13_io_out_uop_debug_fsrc : _slots_12_io_out_uop_debug_fsrc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_tsrc
      (_GEN_12 ? _slots_13_io_out_uop_debug_tsrc : _slots_12_io_out_uop_debug_tsrc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_valid                       (_slots_11_io_valid),
    .io_will_be_valid               (_slots_11_io_will_be_valid),
    .io_request                     (_slots_11_io_request),
    .io_out_uop_uopc                (_slots_11_io_out_uop_uopc),
    .io_out_uop_inst                (_slots_11_io_out_uop_inst),
    .io_out_uop_debug_inst          (_slots_11_io_out_uop_debug_inst),
    .io_out_uop_is_rvc              (_slots_11_io_out_uop_is_rvc),
    .io_out_uop_debug_pc            (_slots_11_io_out_uop_debug_pc),
    .io_out_uop_iq_type             (_slots_11_io_out_uop_iq_type),
    .io_out_uop_fu_code             (_slots_11_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_11_io_out_uop_iw_state),
    .io_out_uop_is_br               (_slots_11_io_out_uop_is_br),
    .io_out_uop_is_jalr             (_slots_11_io_out_uop_is_jalr),
    .io_out_uop_is_jal              (_slots_11_io_out_uop_is_jal),
    .io_out_uop_is_sfb              (_slots_11_io_out_uop_is_sfb),
    .io_out_uop_br_mask             (_slots_11_io_out_uop_br_mask),
    .io_out_uop_br_tag              (_slots_11_io_out_uop_br_tag),
    .io_out_uop_ftq_idx             (_slots_11_io_out_uop_ftq_idx),
    .io_out_uop_edge_inst           (_slots_11_io_out_uop_edge_inst),
    .io_out_uop_pc_lob              (_slots_11_io_out_uop_pc_lob),
    .io_out_uop_taken               (_slots_11_io_out_uop_taken),
    .io_out_uop_imm_packed          (_slots_11_io_out_uop_imm_packed),
    .io_out_uop_csr_addr            (_slots_11_io_out_uop_csr_addr),
    .io_out_uop_rob_idx             (_slots_11_io_out_uop_rob_idx),
    .io_out_uop_ldq_idx             (_slots_11_io_out_uop_ldq_idx),
    .io_out_uop_stq_idx             (_slots_11_io_out_uop_stq_idx),
    .io_out_uop_rxq_idx             (_slots_11_io_out_uop_rxq_idx),
    .io_out_uop_pdst                (_slots_11_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_11_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_11_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_11_io_out_uop_prs3),
    .io_out_uop_ppred               (_slots_11_io_out_uop_ppred),
    .io_out_uop_prs1_busy           (_slots_11_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_11_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_11_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_11_io_out_uop_ppred_busy),
    .io_out_uop_stale_pdst          (_slots_11_io_out_uop_stale_pdst),
    .io_out_uop_exception           (_slots_11_io_out_uop_exception),
    .io_out_uop_exc_cause           (_slots_11_io_out_uop_exc_cause),
    .io_out_uop_bypassable          (_slots_11_io_out_uop_bypassable),
    .io_out_uop_mem_cmd             (_slots_11_io_out_uop_mem_cmd),
    .io_out_uop_mem_size            (_slots_11_io_out_uop_mem_size),
    .io_out_uop_mem_signed          (_slots_11_io_out_uop_mem_signed),
    .io_out_uop_is_fence            (_slots_11_io_out_uop_is_fence),
    .io_out_uop_is_fencei           (_slots_11_io_out_uop_is_fencei),
    .io_out_uop_is_amo              (_slots_11_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_11_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_11_io_out_uop_uses_stq),
    .io_out_uop_is_sys_pc2epc       (_slots_11_io_out_uop_is_sys_pc2epc),
    .io_out_uop_is_unique           (_slots_11_io_out_uop_is_unique),
    .io_out_uop_flush_on_commit     (_slots_11_io_out_uop_flush_on_commit),
    .io_out_uop_ldst_is_rs1         (_slots_11_io_out_uop_ldst_is_rs1),
    .io_out_uop_ldst                (_slots_11_io_out_uop_ldst),
    .io_out_uop_lrs1                (_slots_11_io_out_uop_lrs1),
    .io_out_uop_lrs2                (_slots_11_io_out_uop_lrs2),
    .io_out_uop_lrs3                (_slots_11_io_out_uop_lrs3),
    .io_out_uop_ldst_val            (_slots_11_io_out_uop_ldst_val),
    .io_out_uop_dst_rtype           (_slots_11_io_out_uop_dst_rtype),
    .io_out_uop_lrs1_rtype          (_slots_11_io_out_uop_lrs1_rtype),
    .io_out_uop_lrs2_rtype          (_slots_11_io_out_uop_lrs2_rtype),
    .io_out_uop_frs3_en             (_slots_11_io_out_uop_frs3_en),
    .io_out_uop_fp_val              (_slots_11_io_out_uop_fp_val),
    .io_out_uop_fp_single           (_slots_11_io_out_uop_fp_single),
    .io_out_uop_xcpt_pf_if          (_slots_11_io_out_uop_xcpt_pf_if),
    .io_out_uop_xcpt_ae_if          (_slots_11_io_out_uop_xcpt_ae_if),
    .io_out_uop_xcpt_ma_if          (_slots_11_io_out_uop_xcpt_ma_if),
    .io_out_uop_bp_debug_if         (_slots_11_io_out_uop_bp_debug_if),
    .io_out_uop_bp_xcpt_if          (_slots_11_io_out_uop_bp_xcpt_if),
    .io_out_uop_debug_fsrc          (_slots_11_io_out_uop_debug_fsrc),
    .io_out_uop_debug_tsrc          (_slots_11_io_out_uop_debug_tsrc),
    .io_uop_uopc                    (_slots_11_io_uop_uopc),
    .io_uop_inst                    (_slots_11_io_uop_inst),
    .io_uop_debug_inst              (_slots_11_io_uop_debug_inst),
    .io_uop_is_rvc                  (_slots_11_io_uop_is_rvc),
    .io_uop_debug_pc                (_slots_11_io_uop_debug_pc),
    .io_uop_iq_type                 (_slots_11_io_uop_iq_type),
    .io_uop_fu_code                 (_slots_11_io_uop_fu_code),
    .io_uop_iw_state                (_slots_11_io_uop_iw_state),
    .io_uop_is_br                   (_slots_11_io_uop_is_br),
    .io_uop_is_jalr                 (_slots_11_io_uop_is_jalr),
    .io_uop_is_jal                  (_slots_11_io_uop_is_jal),
    .io_uop_is_sfb                  (_slots_11_io_uop_is_sfb),
    .io_uop_br_mask                 (_slots_11_io_uop_br_mask),
    .io_uop_br_tag                  (_slots_11_io_uop_br_tag),
    .io_uop_ftq_idx                 (_slots_11_io_uop_ftq_idx),
    .io_uop_edge_inst               (_slots_11_io_uop_edge_inst),
    .io_uop_pc_lob                  (_slots_11_io_uop_pc_lob),
    .io_uop_taken                   (_slots_11_io_uop_taken),
    .io_uop_imm_packed              (_slots_11_io_uop_imm_packed),
    .io_uop_csr_addr                (_slots_11_io_uop_csr_addr),
    .io_uop_rob_idx                 (_slots_11_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_11_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_11_io_uop_stq_idx),
    .io_uop_rxq_idx                 (_slots_11_io_uop_rxq_idx),
    .io_uop_pdst                    (_slots_11_io_uop_pdst),
    .io_uop_prs1                    (_slots_11_io_uop_prs1),
    .io_uop_prs2                    (_slots_11_io_uop_prs2),
    .io_uop_prs3                    (_slots_11_io_uop_prs3),
    .io_uop_ppred                   (_slots_11_io_uop_ppred),
    .io_uop_prs1_busy               (_slots_11_io_uop_prs1_busy),
    .io_uop_prs2_busy               (_slots_11_io_uop_prs2_busy),
    .io_uop_prs3_busy               (_slots_11_io_uop_prs3_busy),
    .io_uop_ppred_busy              (_slots_11_io_uop_ppred_busy),
    .io_uop_stale_pdst              (_slots_11_io_uop_stale_pdst),
    .io_uop_exception               (_slots_11_io_uop_exception),
    .io_uop_exc_cause               (_slots_11_io_uop_exc_cause),
    .io_uop_bypassable              (_slots_11_io_uop_bypassable),
    .io_uop_mem_cmd                 (_slots_11_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_11_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_11_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_11_io_uop_is_fence),
    .io_uop_is_fencei               (_slots_11_io_uop_is_fencei),
    .io_uop_is_amo                  (_slots_11_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_11_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_11_io_uop_uses_stq),
    .io_uop_is_sys_pc2epc           (_slots_11_io_uop_is_sys_pc2epc),
    .io_uop_is_unique               (_slots_11_io_uop_is_unique),
    .io_uop_flush_on_commit         (_slots_11_io_uop_flush_on_commit),
    .io_uop_ldst_is_rs1             (_slots_11_io_uop_ldst_is_rs1),
    .io_uop_ldst                    (_slots_11_io_uop_ldst),
    .io_uop_lrs1                    (_slots_11_io_uop_lrs1),
    .io_uop_lrs2                    (_slots_11_io_uop_lrs2),
    .io_uop_lrs3                    (_slots_11_io_uop_lrs3),
    .io_uop_ldst_val                (_slots_11_io_uop_ldst_val),
    .io_uop_dst_rtype               (_slots_11_io_uop_dst_rtype),
    .io_uop_lrs1_rtype              (_slots_11_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_11_io_uop_lrs2_rtype),
    .io_uop_frs3_en                 (_slots_11_io_uop_frs3_en),
    .io_uop_fp_val                  (_slots_11_io_uop_fp_val),
    .io_uop_fp_single               (_slots_11_io_uop_fp_single),
    .io_uop_xcpt_pf_if              (_slots_11_io_uop_xcpt_pf_if),
    .io_uop_xcpt_ae_if              (_slots_11_io_uop_xcpt_ae_if),
    .io_uop_xcpt_ma_if              (_slots_11_io_uop_xcpt_ma_if),
    .io_uop_bp_debug_if             (_slots_11_io_uop_bp_debug_if),
    .io_uop_bp_xcpt_if              (_slots_11_io_uop_bp_xcpt_if),
    .io_uop_debug_fsrc              (_slots_11_io_uop_debug_fsrc),
    .io_uop_debug_tsrc              (_slots_11_io_uop_debug_tsrc)
  );
  IssueSlot_168 slots_12 (	// issue-unit.scala:153:73
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_12_grant),	// issue-unit-age-ordered.scala:118:56
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|next_11),	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :76:49
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_in_uop_valid                (issue_slots_12_in_uop_valid),	// issue-unit-age-ordered.scala:71:48, :72:37
    .io_in_uop_bits_uopc
      (_GEN_13 ? _slots_14_io_out_uop_uopc : _slots_13_io_out_uop_uopc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_inst
      (_GEN_13 ? _slots_14_io_out_uop_inst : _slots_13_io_out_uop_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_inst
      (_GEN_13 ? _slots_14_io_out_uop_debug_inst : _slots_13_io_out_uop_debug_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_rvc
      (_GEN_13 ? _slots_14_io_out_uop_is_rvc : _slots_13_io_out_uop_is_rvc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_pc
      (_GEN_13 ? _slots_14_io_out_uop_debug_pc : _slots_13_io_out_uop_debug_pc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_iq_type
      (_GEN_13 ? _slots_14_io_out_uop_iq_type : _slots_13_io_out_uop_iq_type),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fu_code
      (_GEN_13 ? _slots_14_io_out_uop_fu_code : _slots_13_io_out_uop_fu_code),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_iw_state
      (_GEN_13 ? _slots_14_io_out_uop_iw_state : _slots_13_io_out_uop_iw_state),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_br
      (_GEN_13 ? _slots_14_io_out_uop_is_br : _slots_13_io_out_uop_is_br),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_jalr
      (_GEN_13 ? _slots_14_io_out_uop_is_jalr : _slots_13_io_out_uop_is_jalr),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_jal
      (_GEN_13 ? _slots_14_io_out_uop_is_jal : _slots_13_io_out_uop_is_jal),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_sfb
      (_GEN_13 ? _slots_14_io_out_uop_is_sfb : _slots_13_io_out_uop_is_sfb),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_br_mask
      (_GEN_13 ? _slots_14_io_out_uop_br_mask : _slots_13_io_out_uop_br_mask),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_br_tag
      (_GEN_13 ? _slots_14_io_out_uop_br_tag : _slots_13_io_out_uop_br_tag),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ftq_idx
      (_GEN_13 ? _slots_14_io_out_uop_ftq_idx : _slots_13_io_out_uop_ftq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_edge_inst
      (_GEN_13 ? _slots_14_io_out_uop_edge_inst : _slots_13_io_out_uop_edge_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_pc_lob
      (_GEN_13 ? _slots_14_io_out_uop_pc_lob : _slots_13_io_out_uop_pc_lob),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_taken
      (_GEN_13 ? _slots_14_io_out_uop_taken : _slots_13_io_out_uop_taken),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_imm_packed
      (_GEN_13 ? _slots_14_io_out_uop_imm_packed : _slots_13_io_out_uop_imm_packed),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_csr_addr
      (_GEN_13 ? _slots_14_io_out_uop_csr_addr : _slots_13_io_out_uop_csr_addr),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_rob_idx
      (_GEN_13 ? _slots_14_io_out_uop_rob_idx : _slots_13_io_out_uop_rob_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldq_idx
      (_GEN_13 ? _slots_14_io_out_uop_ldq_idx : _slots_13_io_out_uop_ldq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_stq_idx
      (_GEN_13 ? _slots_14_io_out_uop_stq_idx : _slots_13_io_out_uop_stq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_rxq_idx
      (_GEN_13 ? _slots_14_io_out_uop_rxq_idx : _slots_13_io_out_uop_rxq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_pdst
      (_GEN_13 ? _slots_14_io_out_uop_pdst : _slots_13_io_out_uop_pdst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs1
      (_GEN_13 ? _slots_14_io_out_uop_prs1 : _slots_13_io_out_uop_prs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs2
      (_GEN_13 ? _slots_14_io_out_uop_prs2 : _slots_13_io_out_uop_prs2),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs3
      (_GEN_13 ? _slots_14_io_out_uop_prs3 : _slots_13_io_out_uop_prs3),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ppred
      (_GEN_13 ? _slots_14_io_out_uop_ppred : _slots_13_io_out_uop_ppred),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs1_busy
      (_GEN_13 ? _slots_14_io_out_uop_prs1_busy : _slots_13_io_out_uop_prs1_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs2_busy
      (_GEN_13 ? _slots_14_io_out_uop_prs2_busy : _slots_13_io_out_uop_prs2_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs3_busy
      (_GEN_13 ? _slots_14_io_out_uop_prs3_busy : _slots_13_io_out_uop_prs3_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ppred_busy
      (_GEN_13 ? _slots_14_io_out_uop_ppred_busy : _slots_13_io_out_uop_ppred_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_stale_pdst
      (_GEN_13 ? _slots_14_io_out_uop_stale_pdst : _slots_13_io_out_uop_stale_pdst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_exception
      (_GEN_13 ? _slots_14_io_out_uop_exception : _slots_13_io_out_uop_exception),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_exc_cause
      (_GEN_13 ? _slots_14_io_out_uop_exc_cause : _slots_13_io_out_uop_exc_cause),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bypassable
      (_GEN_13 ? _slots_14_io_out_uop_bypassable : _slots_13_io_out_uop_bypassable),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_cmd
      (_GEN_13 ? _slots_14_io_out_uop_mem_cmd : _slots_13_io_out_uop_mem_cmd),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_size
      (_GEN_13 ? _slots_14_io_out_uop_mem_size : _slots_13_io_out_uop_mem_size),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_signed
      (_GEN_13 ? _slots_14_io_out_uop_mem_signed : _slots_13_io_out_uop_mem_signed),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_fence
      (_GEN_13 ? _slots_14_io_out_uop_is_fence : _slots_13_io_out_uop_is_fence),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_fencei
      (_GEN_13 ? _slots_14_io_out_uop_is_fencei : _slots_13_io_out_uop_is_fencei),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_amo
      (_GEN_13 ? _slots_14_io_out_uop_is_amo : _slots_13_io_out_uop_is_amo),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_uses_ldq
      (_GEN_13 ? _slots_14_io_out_uop_uses_ldq : _slots_13_io_out_uop_uses_ldq),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_uses_stq
      (_GEN_13 ? _slots_14_io_out_uop_uses_stq : _slots_13_io_out_uop_uses_stq),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_sys_pc2epc
      (_GEN_13 ? _slots_14_io_out_uop_is_sys_pc2epc : _slots_13_io_out_uop_is_sys_pc2epc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_unique
      (_GEN_13 ? _slots_14_io_out_uop_is_unique : _slots_13_io_out_uop_is_unique),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_flush_on_commit
      (_GEN_13
         ? _slots_14_io_out_uop_flush_on_commit
         : _slots_13_io_out_uop_flush_on_commit),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst_is_rs1
      (_GEN_13 ? _slots_14_io_out_uop_ldst_is_rs1 : _slots_13_io_out_uop_ldst_is_rs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst
      (_GEN_13 ? _slots_14_io_out_uop_ldst : _slots_13_io_out_uop_ldst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs1
      (_GEN_13 ? _slots_14_io_out_uop_lrs1 : _slots_13_io_out_uop_lrs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs2
      (_GEN_13 ? _slots_14_io_out_uop_lrs2 : _slots_13_io_out_uop_lrs2),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs3
      (_GEN_13 ? _slots_14_io_out_uop_lrs3 : _slots_13_io_out_uop_lrs3),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst_val
      (_GEN_13 ? _slots_14_io_out_uop_ldst_val : _slots_13_io_out_uop_ldst_val),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_dst_rtype
      (_GEN_13 ? _slots_14_io_out_uop_dst_rtype : _slots_13_io_out_uop_dst_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs1_rtype
      (_GEN_13 ? _slots_14_io_out_uop_lrs1_rtype : _slots_13_io_out_uop_lrs1_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs2_rtype
      (_GEN_13 ? _slots_14_io_out_uop_lrs2_rtype : _slots_13_io_out_uop_lrs2_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_frs3_en
      (_GEN_13 ? _slots_14_io_out_uop_frs3_en : _slots_13_io_out_uop_frs3_en),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fp_val
      (_GEN_13 ? _slots_14_io_out_uop_fp_val : _slots_13_io_out_uop_fp_val),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fp_single
      (_GEN_13 ? _slots_14_io_out_uop_fp_single : _slots_13_io_out_uop_fp_single),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_pf_if
      (_GEN_13 ? _slots_14_io_out_uop_xcpt_pf_if : _slots_13_io_out_uop_xcpt_pf_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_ae_if
      (_GEN_13 ? _slots_14_io_out_uop_xcpt_ae_if : _slots_13_io_out_uop_xcpt_ae_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_ma_if
      (_GEN_13 ? _slots_14_io_out_uop_xcpt_ma_if : _slots_13_io_out_uop_xcpt_ma_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bp_debug_if
      (_GEN_13 ? _slots_14_io_out_uop_bp_debug_if : _slots_13_io_out_uop_bp_debug_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bp_xcpt_if
      (_GEN_13 ? _slots_14_io_out_uop_bp_xcpt_if : _slots_13_io_out_uop_bp_xcpt_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_fsrc
      (_GEN_13 ? _slots_14_io_out_uop_debug_fsrc : _slots_13_io_out_uop_debug_fsrc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_tsrc
      (_GEN_13 ? _slots_14_io_out_uop_debug_tsrc : _slots_13_io_out_uop_debug_tsrc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_valid                       (_slots_12_io_valid),
    .io_will_be_valid               (_slots_12_io_will_be_valid),
    .io_request                     (_slots_12_io_request),
    .io_out_uop_uopc                (_slots_12_io_out_uop_uopc),
    .io_out_uop_inst                (_slots_12_io_out_uop_inst),
    .io_out_uop_debug_inst          (_slots_12_io_out_uop_debug_inst),
    .io_out_uop_is_rvc              (_slots_12_io_out_uop_is_rvc),
    .io_out_uop_debug_pc            (_slots_12_io_out_uop_debug_pc),
    .io_out_uop_iq_type             (_slots_12_io_out_uop_iq_type),
    .io_out_uop_fu_code             (_slots_12_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_12_io_out_uop_iw_state),
    .io_out_uop_is_br               (_slots_12_io_out_uop_is_br),
    .io_out_uop_is_jalr             (_slots_12_io_out_uop_is_jalr),
    .io_out_uop_is_jal              (_slots_12_io_out_uop_is_jal),
    .io_out_uop_is_sfb              (_slots_12_io_out_uop_is_sfb),
    .io_out_uop_br_mask             (_slots_12_io_out_uop_br_mask),
    .io_out_uop_br_tag              (_slots_12_io_out_uop_br_tag),
    .io_out_uop_ftq_idx             (_slots_12_io_out_uop_ftq_idx),
    .io_out_uop_edge_inst           (_slots_12_io_out_uop_edge_inst),
    .io_out_uop_pc_lob              (_slots_12_io_out_uop_pc_lob),
    .io_out_uop_taken               (_slots_12_io_out_uop_taken),
    .io_out_uop_imm_packed          (_slots_12_io_out_uop_imm_packed),
    .io_out_uop_csr_addr            (_slots_12_io_out_uop_csr_addr),
    .io_out_uop_rob_idx             (_slots_12_io_out_uop_rob_idx),
    .io_out_uop_ldq_idx             (_slots_12_io_out_uop_ldq_idx),
    .io_out_uop_stq_idx             (_slots_12_io_out_uop_stq_idx),
    .io_out_uop_rxq_idx             (_slots_12_io_out_uop_rxq_idx),
    .io_out_uop_pdst                (_slots_12_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_12_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_12_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_12_io_out_uop_prs3),
    .io_out_uop_ppred               (_slots_12_io_out_uop_ppred),
    .io_out_uop_prs1_busy           (_slots_12_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_12_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_12_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_12_io_out_uop_ppred_busy),
    .io_out_uop_stale_pdst          (_slots_12_io_out_uop_stale_pdst),
    .io_out_uop_exception           (_slots_12_io_out_uop_exception),
    .io_out_uop_exc_cause           (_slots_12_io_out_uop_exc_cause),
    .io_out_uop_bypassable          (_slots_12_io_out_uop_bypassable),
    .io_out_uop_mem_cmd             (_slots_12_io_out_uop_mem_cmd),
    .io_out_uop_mem_size            (_slots_12_io_out_uop_mem_size),
    .io_out_uop_mem_signed          (_slots_12_io_out_uop_mem_signed),
    .io_out_uop_is_fence            (_slots_12_io_out_uop_is_fence),
    .io_out_uop_is_fencei           (_slots_12_io_out_uop_is_fencei),
    .io_out_uop_is_amo              (_slots_12_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_12_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_12_io_out_uop_uses_stq),
    .io_out_uop_is_sys_pc2epc       (_slots_12_io_out_uop_is_sys_pc2epc),
    .io_out_uop_is_unique           (_slots_12_io_out_uop_is_unique),
    .io_out_uop_flush_on_commit     (_slots_12_io_out_uop_flush_on_commit),
    .io_out_uop_ldst_is_rs1         (_slots_12_io_out_uop_ldst_is_rs1),
    .io_out_uop_ldst                (_slots_12_io_out_uop_ldst),
    .io_out_uop_lrs1                (_slots_12_io_out_uop_lrs1),
    .io_out_uop_lrs2                (_slots_12_io_out_uop_lrs2),
    .io_out_uop_lrs3                (_slots_12_io_out_uop_lrs3),
    .io_out_uop_ldst_val            (_slots_12_io_out_uop_ldst_val),
    .io_out_uop_dst_rtype           (_slots_12_io_out_uop_dst_rtype),
    .io_out_uop_lrs1_rtype          (_slots_12_io_out_uop_lrs1_rtype),
    .io_out_uop_lrs2_rtype          (_slots_12_io_out_uop_lrs2_rtype),
    .io_out_uop_frs3_en             (_slots_12_io_out_uop_frs3_en),
    .io_out_uop_fp_val              (_slots_12_io_out_uop_fp_val),
    .io_out_uop_fp_single           (_slots_12_io_out_uop_fp_single),
    .io_out_uop_xcpt_pf_if          (_slots_12_io_out_uop_xcpt_pf_if),
    .io_out_uop_xcpt_ae_if          (_slots_12_io_out_uop_xcpt_ae_if),
    .io_out_uop_xcpt_ma_if          (_slots_12_io_out_uop_xcpt_ma_if),
    .io_out_uop_bp_debug_if         (_slots_12_io_out_uop_bp_debug_if),
    .io_out_uop_bp_xcpt_if          (_slots_12_io_out_uop_bp_xcpt_if),
    .io_out_uop_debug_fsrc          (_slots_12_io_out_uop_debug_fsrc),
    .io_out_uop_debug_tsrc          (_slots_12_io_out_uop_debug_tsrc),
    .io_uop_uopc                    (_slots_12_io_uop_uopc),
    .io_uop_inst                    (_slots_12_io_uop_inst),
    .io_uop_debug_inst              (_slots_12_io_uop_debug_inst),
    .io_uop_is_rvc                  (_slots_12_io_uop_is_rvc),
    .io_uop_debug_pc                (_slots_12_io_uop_debug_pc),
    .io_uop_iq_type                 (_slots_12_io_uop_iq_type),
    .io_uop_fu_code                 (_slots_12_io_uop_fu_code),
    .io_uop_iw_state                (_slots_12_io_uop_iw_state),
    .io_uop_is_br                   (_slots_12_io_uop_is_br),
    .io_uop_is_jalr                 (_slots_12_io_uop_is_jalr),
    .io_uop_is_jal                  (_slots_12_io_uop_is_jal),
    .io_uop_is_sfb                  (_slots_12_io_uop_is_sfb),
    .io_uop_br_mask                 (_slots_12_io_uop_br_mask),
    .io_uop_br_tag                  (_slots_12_io_uop_br_tag),
    .io_uop_ftq_idx                 (_slots_12_io_uop_ftq_idx),
    .io_uop_edge_inst               (_slots_12_io_uop_edge_inst),
    .io_uop_pc_lob                  (_slots_12_io_uop_pc_lob),
    .io_uop_taken                   (_slots_12_io_uop_taken),
    .io_uop_imm_packed              (_slots_12_io_uop_imm_packed),
    .io_uop_csr_addr                (_slots_12_io_uop_csr_addr),
    .io_uop_rob_idx                 (_slots_12_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_12_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_12_io_uop_stq_idx),
    .io_uop_rxq_idx                 (_slots_12_io_uop_rxq_idx),
    .io_uop_pdst                    (_slots_12_io_uop_pdst),
    .io_uop_prs1                    (_slots_12_io_uop_prs1),
    .io_uop_prs2                    (_slots_12_io_uop_prs2),
    .io_uop_prs3                    (_slots_12_io_uop_prs3),
    .io_uop_ppred                   (_slots_12_io_uop_ppred),
    .io_uop_prs1_busy               (_slots_12_io_uop_prs1_busy),
    .io_uop_prs2_busy               (_slots_12_io_uop_prs2_busy),
    .io_uop_prs3_busy               (_slots_12_io_uop_prs3_busy),
    .io_uop_ppred_busy              (_slots_12_io_uop_ppred_busy),
    .io_uop_stale_pdst              (_slots_12_io_uop_stale_pdst),
    .io_uop_exception               (_slots_12_io_uop_exception),
    .io_uop_exc_cause               (_slots_12_io_uop_exc_cause),
    .io_uop_bypassable              (_slots_12_io_uop_bypassable),
    .io_uop_mem_cmd                 (_slots_12_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_12_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_12_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_12_io_uop_is_fence),
    .io_uop_is_fencei               (_slots_12_io_uop_is_fencei),
    .io_uop_is_amo                  (_slots_12_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_12_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_12_io_uop_uses_stq),
    .io_uop_is_sys_pc2epc           (_slots_12_io_uop_is_sys_pc2epc),
    .io_uop_is_unique               (_slots_12_io_uop_is_unique),
    .io_uop_flush_on_commit         (_slots_12_io_uop_flush_on_commit),
    .io_uop_ldst_is_rs1             (_slots_12_io_uop_ldst_is_rs1),
    .io_uop_ldst                    (_slots_12_io_uop_ldst),
    .io_uop_lrs1                    (_slots_12_io_uop_lrs1),
    .io_uop_lrs2                    (_slots_12_io_uop_lrs2),
    .io_uop_lrs3                    (_slots_12_io_uop_lrs3),
    .io_uop_ldst_val                (_slots_12_io_uop_ldst_val),
    .io_uop_dst_rtype               (_slots_12_io_uop_dst_rtype),
    .io_uop_lrs1_rtype              (_slots_12_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_12_io_uop_lrs2_rtype),
    .io_uop_frs3_en                 (_slots_12_io_uop_frs3_en),
    .io_uop_fp_val                  (_slots_12_io_uop_fp_val),
    .io_uop_fp_single               (_slots_12_io_uop_fp_single),
    .io_uop_xcpt_pf_if              (_slots_12_io_uop_xcpt_pf_if),
    .io_uop_xcpt_ae_if              (_slots_12_io_uop_xcpt_ae_if),
    .io_uop_xcpt_ma_if              (_slots_12_io_uop_xcpt_ma_if),
    .io_uop_bp_debug_if             (_slots_12_io_uop_bp_debug_if),
    .io_uop_bp_xcpt_if              (_slots_12_io_uop_bp_xcpt_if),
    .io_uop_debug_fsrc              (_slots_12_io_uop_debug_fsrc),
    .io_uop_debug_tsrc              (_slots_12_io_uop_debug_tsrc)
  );
  IssueSlot_168 slots_13 (	// issue-unit.scala:153:73
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_13_grant),	// issue-unit-age-ordered.scala:118:56
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|next_12),	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :76:49
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_in_uop_valid                (issue_slots_13_in_uop_valid),	// issue-unit-age-ordered.scala:71:48, :72:37
    .io_in_uop_bits_uopc
      (_GEN_14 ? _slots_15_io_out_uop_uopc : _slots_14_io_out_uop_uopc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_inst
      (_GEN_14 ? _slots_15_io_out_uop_inst : _slots_14_io_out_uop_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_inst
      (_GEN_14 ? _slots_15_io_out_uop_debug_inst : _slots_14_io_out_uop_debug_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_rvc
      (_GEN_14 ? _slots_15_io_out_uop_is_rvc : _slots_14_io_out_uop_is_rvc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_pc
      (_GEN_14 ? _slots_15_io_out_uop_debug_pc : _slots_14_io_out_uop_debug_pc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_iq_type
      (_GEN_14 ? _slots_15_io_out_uop_iq_type : _slots_14_io_out_uop_iq_type),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fu_code
      (_GEN_14 ? _slots_15_io_out_uop_fu_code : _slots_14_io_out_uop_fu_code),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_iw_state
      (_GEN_14 ? _slots_15_io_out_uop_iw_state : _slots_14_io_out_uop_iw_state),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_br
      (_GEN_14 ? _slots_15_io_out_uop_is_br : _slots_14_io_out_uop_is_br),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_jalr
      (_GEN_14 ? _slots_15_io_out_uop_is_jalr : _slots_14_io_out_uop_is_jalr),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_jal
      (_GEN_14 ? _slots_15_io_out_uop_is_jal : _slots_14_io_out_uop_is_jal),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_sfb
      (_GEN_14 ? _slots_15_io_out_uop_is_sfb : _slots_14_io_out_uop_is_sfb),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_br_mask
      (_GEN_14 ? _slots_15_io_out_uop_br_mask : _slots_14_io_out_uop_br_mask),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_br_tag
      (_GEN_14 ? _slots_15_io_out_uop_br_tag : _slots_14_io_out_uop_br_tag),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ftq_idx
      (_GEN_14 ? _slots_15_io_out_uop_ftq_idx : _slots_14_io_out_uop_ftq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_edge_inst
      (_GEN_14 ? _slots_15_io_out_uop_edge_inst : _slots_14_io_out_uop_edge_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_pc_lob
      (_GEN_14 ? _slots_15_io_out_uop_pc_lob : _slots_14_io_out_uop_pc_lob),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_taken
      (_GEN_14 ? _slots_15_io_out_uop_taken : _slots_14_io_out_uop_taken),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_imm_packed
      (_GEN_14 ? _slots_15_io_out_uop_imm_packed : _slots_14_io_out_uop_imm_packed),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_csr_addr
      (_GEN_14 ? _slots_15_io_out_uop_csr_addr : _slots_14_io_out_uop_csr_addr),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_rob_idx
      (_GEN_14 ? _slots_15_io_out_uop_rob_idx : _slots_14_io_out_uop_rob_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldq_idx
      (_GEN_14 ? _slots_15_io_out_uop_ldq_idx : _slots_14_io_out_uop_ldq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_stq_idx
      (_GEN_14 ? _slots_15_io_out_uop_stq_idx : _slots_14_io_out_uop_stq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_rxq_idx
      (_GEN_14 ? _slots_15_io_out_uop_rxq_idx : _slots_14_io_out_uop_rxq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_pdst
      (_GEN_14 ? _slots_15_io_out_uop_pdst : _slots_14_io_out_uop_pdst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs1
      (_GEN_14 ? _slots_15_io_out_uop_prs1 : _slots_14_io_out_uop_prs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs2
      (_GEN_14 ? _slots_15_io_out_uop_prs2 : _slots_14_io_out_uop_prs2),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs3
      (_GEN_14 ? _slots_15_io_out_uop_prs3 : _slots_14_io_out_uop_prs3),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ppred
      (_GEN_14 ? _slots_15_io_out_uop_ppred : _slots_14_io_out_uop_ppred),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs1_busy
      (_GEN_14 ? _slots_15_io_out_uop_prs1_busy : _slots_14_io_out_uop_prs1_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs2_busy
      (_GEN_14 ? _slots_15_io_out_uop_prs2_busy : _slots_14_io_out_uop_prs2_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs3_busy
      (_GEN_14 ? _slots_15_io_out_uop_prs3_busy : _slots_14_io_out_uop_prs3_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ppred_busy
      (_GEN_14 ? _slots_15_io_out_uop_ppred_busy : _slots_14_io_out_uop_ppred_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_stale_pdst
      (_GEN_14 ? _slots_15_io_out_uop_stale_pdst : _slots_14_io_out_uop_stale_pdst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_exception
      (_GEN_14 ? _slots_15_io_out_uop_exception : _slots_14_io_out_uop_exception),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_exc_cause
      (_GEN_14 ? _slots_15_io_out_uop_exc_cause : _slots_14_io_out_uop_exc_cause),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bypassable
      (_GEN_14 ? _slots_15_io_out_uop_bypassable : _slots_14_io_out_uop_bypassable),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_cmd
      (_GEN_14 ? _slots_15_io_out_uop_mem_cmd : _slots_14_io_out_uop_mem_cmd),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_size
      (_GEN_14 ? _slots_15_io_out_uop_mem_size : _slots_14_io_out_uop_mem_size),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_signed
      (_GEN_14 ? _slots_15_io_out_uop_mem_signed : _slots_14_io_out_uop_mem_signed),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_fence
      (_GEN_14 ? _slots_15_io_out_uop_is_fence : _slots_14_io_out_uop_is_fence),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_fencei
      (_GEN_14 ? _slots_15_io_out_uop_is_fencei : _slots_14_io_out_uop_is_fencei),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_amo
      (_GEN_14 ? _slots_15_io_out_uop_is_amo : _slots_14_io_out_uop_is_amo),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_uses_ldq
      (_GEN_14 ? _slots_15_io_out_uop_uses_ldq : _slots_14_io_out_uop_uses_ldq),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_uses_stq
      (_GEN_14 ? _slots_15_io_out_uop_uses_stq : _slots_14_io_out_uop_uses_stq),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_sys_pc2epc
      (_GEN_14 ? _slots_15_io_out_uop_is_sys_pc2epc : _slots_14_io_out_uop_is_sys_pc2epc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_unique
      (_GEN_14 ? _slots_15_io_out_uop_is_unique : _slots_14_io_out_uop_is_unique),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_flush_on_commit
      (_GEN_14
         ? _slots_15_io_out_uop_flush_on_commit
         : _slots_14_io_out_uop_flush_on_commit),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst_is_rs1
      (_GEN_14 ? _slots_15_io_out_uop_ldst_is_rs1 : _slots_14_io_out_uop_ldst_is_rs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst
      (_GEN_14 ? _slots_15_io_out_uop_ldst : _slots_14_io_out_uop_ldst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs1
      (_GEN_14 ? _slots_15_io_out_uop_lrs1 : _slots_14_io_out_uop_lrs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs2
      (_GEN_14 ? _slots_15_io_out_uop_lrs2 : _slots_14_io_out_uop_lrs2),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs3
      (_GEN_14 ? _slots_15_io_out_uop_lrs3 : _slots_14_io_out_uop_lrs3),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst_val
      (_GEN_14 ? _slots_15_io_out_uop_ldst_val : _slots_14_io_out_uop_ldst_val),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_dst_rtype
      (_GEN_14 ? _slots_15_io_out_uop_dst_rtype : _slots_14_io_out_uop_dst_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs1_rtype
      (_GEN_14 ? _slots_15_io_out_uop_lrs1_rtype : _slots_14_io_out_uop_lrs1_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs2_rtype
      (_GEN_14 ? _slots_15_io_out_uop_lrs2_rtype : _slots_14_io_out_uop_lrs2_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_frs3_en
      (_GEN_14 ? _slots_15_io_out_uop_frs3_en : _slots_14_io_out_uop_frs3_en),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fp_val
      (_GEN_14 ? _slots_15_io_out_uop_fp_val : _slots_14_io_out_uop_fp_val),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fp_single
      (_GEN_14 ? _slots_15_io_out_uop_fp_single : _slots_14_io_out_uop_fp_single),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_pf_if
      (_GEN_14 ? _slots_15_io_out_uop_xcpt_pf_if : _slots_14_io_out_uop_xcpt_pf_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_ae_if
      (_GEN_14 ? _slots_15_io_out_uop_xcpt_ae_if : _slots_14_io_out_uop_xcpt_ae_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_ma_if
      (_GEN_14 ? _slots_15_io_out_uop_xcpt_ma_if : _slots_14_io_out_uop_xcpt_ma_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bp_debug_if
      (_GEN_14 ? _slots_15_io_out_uop_bp_debug_if : _slots_14_io_out_uop_bp_debug_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bp_xcpt_if
      (_GEN_14 ? _slots_15_io_out_uop_bp_xcpt_if : _slots_14_io_out_uop_bp_xcpt_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_fsrc
      (_GEN_14 ? _slots_15_io_out_uop_debug_fsrc : _slots_14_io_out_uop_debug_fsrc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_tsrc
      (_GEN_14 ? _slots_15_io_out_uop_debug_tsrc : _slots_14_io_out_uop_debug_tsrc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_valid                       (_slots_13_io_valid),
    .io_will_be_valid               (_slots_13_io_will_be_valid),
    .io_request                     (_slots_13_io_request),
    .io_out_uop_uopc                (_slots_13_io_out_uop_uopc),
    .io_out_uop_inst                (_slots_13_io_out_uop_inst),
    .io_out_uop_debug_inst          (_slots_13_io_out_uop_debug_inst),
    .io_out_uop_is_rvc              (_slots_13_io_out_uop_is_rvc),
    .io_out_uop_debug_pc            (_slots_13_io_out_uop_debug_pc),
    .io_out_uop_iq_type             (_slots_13_io_out_uop_iq_type),
    .io_out_uop_fu_code             (_slots_13_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_13_io_out_uop_iw_state),
    .io_out_uop_is_br               (_slots_13_io_out_uop_is_br),
    .io_out_uop_is_jalr             (_slots_13_io_out_uop_is_jalr),
    .io_out_uop_is_jal              (_slots_13_io_out_uop_is_jal),
    .io_out_uop_is_sfb              (_slots_13_io_out_uop_is_sfb),
    .io_out_uop_br_mask             (_slots_13_io_out_uop_br_mask),
    .io_out_uop_br_tag              (_slots_13_io_out_uop_br_tag),
    .io_out_uop_ftq_idx             (_slots_13_io_out_uop_ftq_idx),
    .io_out_uop_edge_inst           (_slots_13_io_out_uop_edge_inst),
    .io_out_uop_pc_lob              (_slots_13_io_out_uop_pc_lob),
    .io_out_uop_taken               (_slots_13_io_out_uop_taken),
    .io_out_uop_imm_packed          (_slots_13_io_out_uop_imm_packed),
    .io_out_uop_csr_addr            (_slots_13_io_out_uop_csr_addr),
    .io_out_uop_rob_idx             (_slots_13_io_out_uop_rob_idx),
    .io_out_uop_ldq_idx             (_slots_13_io_out_uop_ldq_idx),
    .io_out_uop_stq_idx             (_slots_13_io_out_uop_stq_idx),
    .io_out_uop_rxq_idx             (_slots_13_io_out_uop_rxq_idx),
    .io_out_uop_pdst                (_slots_13_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_13_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_13_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_13_io_out_uop_prs3),
    .io_out_uop_ppred               (_slots_13_io_out_uop_ppred),
    .io_out_uop_prs1_busy           (_slots_13_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_13_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_13_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_13_io_out_uop_ppred_busy),
    .io_out_uop_stale_pdst          (_slots_13_io_out_uop_stale_pdst),
    .io_out_uop_exception           (_slots_13_io_out_uop_exception),
    .io_out_uop_exc_cause           (_slots_13_io_out_uop_exc_cause),
    .io_out_uop_bypassable          (_slots_13_io_out_uop_bypassable),
    .io_out_uop_mem_cmd             (_slots_13_io_out_uop_mem_cmd),
    .io_out_uop_mem_size            (_slots_13_io_out_uop_mem_size),
    .io_out_uop_mem_signed          (_slots_13_io_out_uop_mem_signed),
    .io_out_uop_is_fence            (_slots_13_io_out_uop_is_fence),
    .io_out_uop_is_fencei           (_slots_13_io_out_uop_is_fencei),
    .io_out_uop_is_amo              (_slots_13_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_13_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_13_io_out_uop_uses_stq),
    .io_out_uop_is_sys_pc2epc       (_slots_13_io_out_uop_is_sys_pc2epc),
    .io_out_uop_is_unique           (_slots_13_io_out_uop_is_unique),
    .io_out_uop_flush_on_commit     (_slots_13_io_out_uop_flush_on_commit),
    .io_out_uop_ldst_is_rs1         (_slots_13_io_out_uop_ldst_is_rs1),
    .io_out_uop_ldst                (_slots_13_io_out_uop_ldst),
    .io_out_uop_lrs1                (_slots_13_io_out_uop_lrs1),
    .io_out_uop_lrs2                (_slots_13_io_out_uop_lrs2),
    .io_out_uop_lrs3                (_slots_13_io_out_uop_lrs3),
    .io_out_uop_ldst_val            (_slots_13_io_out_uop_ldst_val),
    .io_out_uop_dst_rtype           (_slots_13_io_out_uop_dst_rtype),
    .io_out_uop_lrs1_rtype          (_slots_13_io_out_uop_lrs1_rtype),
    .io_out_uop_lrs2_rtype          (_slots_13_io_out_uop_lrs2_rtype),
    .io_out_uop_frs3_en             (_slots_13_io_out_uop_frs3_en),
    .io_out_uop_fp_val              (_slots_13_io_out_uop_fp_val),
    .io_out_uop_fp_single           (_slots_13_io_out_uop_fp_single),
    .io_out_uop_xcpt_pf_if          (_slots_13_io_out_uop_xcpt_pf_if),
    .io_out_uop_xcpt_ae_if          (_slots_13_io_out_uop_xcpt_ae_if),
    .io_out_uop_xcpt_ma_if          (_slots_13_io_out_uop_xcpt_ma_if),
    .io_out_uop_bp_debug_if         (_slots_13_io_out_uop_bp_debug_if),
    .io_out_uop_bp_xcpt_if          (_slots_13_io_out_uop_bp_xcpt_if),
    .io_out_uop_debug_fsrc          (_slots_13_io_out_uop_debug_fsrc),
    .io_out_uop_debug_tsrc          (_slots_13_io_out_uop_debug_tsrc),
    .io_uop_uopc                    (_slots_13_io_uop_uopc),
    .io_uop_inst                    (_slots_13_io_uop_inst),
    .io_uop_debug_inst              (_slots_13_io_uop_debug_inst),
    .io_uop_is_rvc                  (_slots_13_io_uop_is_rvc),
    .io_uop_debug_pc                (_slots_13_io_uop_debug_pc),
    .io_uop_iq_type                 (_slots_13_io_uop_iq_type),
    .io_uop_fu_code                 (_slots_13_io_uop_fu_code),
    .io_uop_iw_state                (_slots_13_io_uop_iw_state),
    .io_uop_is_br                   (_slots_13_io_uop_is_br),
    .io_uop_is_jalr                 (_slots_13_io_uop_is_jalr),
    .io_uop_is_jal                  (_slots_13_io_uop_is_jal),
    .io_uop_is_sfb                  (_slots_13_io_uop_is_sfb),
    .io_uop_br_mask                 (_slots_13_io_uop_br_mask),
    .io_uop_br_tag                  (_slots_13_io_uop_br_tag),
    .io_uop_ftq_idx                 (_slots_13_io_uop_ftq_idx),
    .io_uop_edge_inst               (_slots_13_io_uop_edge_inst),
    .io_uop_pc_lob                  (_slots_13_io_uop_pc_lob),
    .io_uop_taken                   (_slots_13_io_uop_taken),
    .io_uop_imm_packed              (_slots_13_io_uop_imm_packed),
    .io_uop_csr_addr                (_slots_13_io_uop_csr_addr),
    .io_uop_rob_idx                 (_slots_13_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_13_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_13_io_uop_stq_idx),
    .io_uop_rxq_idx                 (_slots_13_io_uop_rxq_idx),
    .io_uop_pdst                    (_slots_13_io_uop_pdst),
    .io_uop_prs1                    (_slots_13_io_uop_prs1),
    .io_uop_prs2                    (_slots_13_io_uop_prs2),
    .io_uop_prs3                    (_slots_13_io_uop_prs3),
    .io_uop_ppred                   (_slots_13_io_uop_ppred),
    .io_uop_prs1_busy               (_slots_13_io_uop_prs1_busy),
    .io_uop_prs2_busy               (_slots_13_io_uop_prs2_busy),
    .io_uop_prs3_busy               (_slots_13_io_uop_prs3_busy),
    .io_uop_ppred_busy              (_slots_13_io_uop_ppred_busy),
    .io_uop_stale_pdst              (_slots_13_io_uop_stale_pdst),
    .io_uop_exception               (_slots_13_io_uop_exception),
    .io_uop_exc_cause               (_slots_13_io_uop_exc_cause),
    .io_uop_bypassable              (_slots_13_io_uop_bypassable),
    .io_uop_mem_cmd                 (_slots_13_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_13_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_13_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_13_io_uop_is_fence),
    .io_uop_is_fencei               (_slots_13_io_uop_is_fencei),
    .io_uop_is_amo                  (_slots_13_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_13_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_13_io_uop_uses_stq),
    .io_uop_is_sys_pc2epc           (_slots_13_io_uop_is_sys_pc2epc),
    .io_uop_is_unique               (_slots_13_io_uop_is_unique),
    .io_uop_flush_on_commit         (_slots_13_io_uop_flush_on_commit),
    .io_uop_ldst_is_rs1             (_slots_13_io_uop_ldst_is_rs1),
    .io_uop_ldst                    (_slots_13_io_uop_ldst),
    .io_uop_lrs1                    (_slots_13_io_uop_lrs1),
    .io_uop_lrs2                    (_slots_13_io_uop_lrs2),
    .io_uop_lrs3                    (_slots_13_io_uop_lrs3),
    .io_uop_ldst_val                (_slots_13_io_uop_ldst_val),
    .io_uop_dst_rtype               (_slots_13_io_uop_dst_rtype),
    .io_uop_lrs1_rtype              (_slots_13_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_13_io_uop_lrs2_rtype),
    .io_uop_frs3_en                 (_slots_13_io_uop_frs3_en),
    .io_uop_fp_val                  (_slots_13_io_uop_fp_val),
    .io_uop_fp_single               (_slots_13_io_uop_fp_single),
    .io_uop_xcpt_pf_if              (_slots_13_io_uop_xcpt_pf_if),
    .io_uop_xcpt_ae_if              (_slots_13_io_uop_xcpt_ae_if),
    .io_uop_xcpt_ma_if              (_slots_13_io_uop_xcpt_ma_if),
    .io_uop_bp_debug_if             (_slots_13_io_uop_bp_debug_if),
    .io_uop_bp_xcpt_if              (_slots_13_io_uop_bp_xcpt_if),
    .io_uop_debug_fsrc              (_slots_13_io_uop_debug_fsrc),
    .io_uop_debug_tsrc              (_slots_13_io_uop_debug_tsrc)
  );
  IssueSlot_168 slots_14 (	// issue-unit.scala:153:73
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_14_grant),	// issue-unit-age-ordered.scala:118:56
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|next_13),	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :76:49
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_in_uop_valid                (issue_slots_14_in_uop_valid),	// issue-unit-age-ordered.scala:71:48, :72:37
    .io_in_uop_bits_uopc
      (_GEN_15 ? io_dis_uops_0_bits_uopc : _slots_15_io_out_uop_uopc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_inst
      (_GEN_15 ? io_dis_uops_0_bits_inst : _slots_15_io_out_uop_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_inst
      (_GEN_15 ? io_dis_uops_0_bits_debug_inst : _slots_15_io_out_uop_debug_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_rvc
      (_GEN_15 ? io_dis_uops_0_bits_is_rvc : _slots_15_io_out_uop_is_rvc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_pc
      (_GEN_15 ? io_dis_uops_0_bits_debug_pc : _slots_15_io_out_uop_debug_pc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_iq_type
      (_GEN_15 ? io_dis_uops_0_bits_iq_type : _slots_15_io_out_uop_iq_type),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fu_code
      (_GEN_15 ? io_dis_uops_0_bits_fu_code : _slots_15_io_out_uop_fu_code),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_iw_state        (_GEN_15 ? 2'h1 : _slots_15_io_out_uop_iw_state),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:123:26, :153:73
    .io_in_uop_bits_is_br
      (_GEN_15 ? io_dis_uops_0_bits_is_br : _slots_15_io_out_uop_is_br),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_jalr
      (_GEN_15 ? io_dis_uops_0_bits_is_jalr : _slots_15_io_out_uop_is_jalr),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_jal
      (_GEN_15 ? io_dis_uops_0_bits_is_jal : _slots_15_io_out_uop_is_jal),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_sfb
      (_GEN_15 ? io_dis_uops_0_bits_is_sfb : _slots_15_io_out_uop_is_sfb),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_br_mask
      (_GEN_15 ? io_dis_uops_0_bits_br_mask : _slots_15_io_out_uop_br_mask),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_br_tag
      (_GEN_15 ? io_dis_uops_0_bits_br_tag : _slots_15_io_out_uop_br_tag),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ftq_idx
      (_GEN_15 ? io_dis_uops_0_bits_ftq_idx : _slots_15_io_out_uop_ftq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_edge_inst
      (_GEN_15 ? io_dis_uops_0_bits_edge_inst : _slots_15_io_out_uop_edge_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_pc_lob
      (_GEN_15 ? io_dis_uops_0_bits_pc_lob : _slots_15_io_out_uop_pc_lob),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_taken
      (_GEN_15 ? io_dis_uops_0_bits_taken : _slots_15_io_out_uop_taken),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_imm_packed
      (_GEN_15 ? io_dis_uops_0_bits_imm_packed : _slots_15_io_out_uop_imm_packed),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_csr_addr
      (_GEN_15 ? io_dis_uops_0_bits_csr_addr : _slots_15_io_out_uop_csr_addr),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_rob_idx
      (_GEN_15 ? io_dis_uops_0_bits_rob_idx : _slots_15_io_out_uop_rob_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldq_idx
      (_GEN_15 ? io_dis_uops_0_bits_ldq_idx : _slots_15_io_out_uop_ldq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_stq_idx
      (_GEN_15 ? io_dis_uops_0_bits_stq_idx : _slots_15_io_out_uop_stq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_rxq_idx
      (_GEN_15 ? io_dis_uops_0_bits_rxq_idx : _slots_15_io_out_uop_rxq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_pdst
      (_GEN_15 ? io_dis_uops_0_bits_pdst : _slots_15_io_out_uop_pdst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs1
      (_GEN_15 ? io_dis_uops_0_bits_prs1 : _slots_15_io_out_uop_prs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs2
      (_GEN_15 ? io_dis_uops_0_bits_prs2 : _slots_15_io_out_uop_prs2),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs3
      (_GEN_15 ? io_dis_uops_0_bits_prs3 : _slots_15_io_out_uop_prs3),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ppred           (_GEN_15 ? 5'h0 : _slots_15_io_out_uop_ppred),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73, :154:28
    .io_in_uop_bits_prs1_busy
      (_GEN_15 ? uops_16_prs1_busy : _slots_15_io_out_uop_prs1_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:120:17, :138:50, :140:32, :153:73
    .io_in_uop_bits_prs2_busy
      (_GEN_15 ? io_dis_uops_0_bits_prs2_busy : _slots_15_io_out_uop_prs2_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_prs3_busy
      (_GEN_15 ? io_dis_uops_0_bits_prs3_busy : _slots_15_io_out_uop_prs3_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ppred_busy      (~_GEN_15 & _slots_15_io_out_uop_ppred_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_stale_pdst
      (_GEN_15 ? io_dis_uops_0_bits_stale_pdst : _slots_15_io_out_uop_stale_pdst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_exception
      (_GEN_15 ? io_dis_uops_0_bits_exception : _slots_15_io_out_uop_exception),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_exc_cause
      (_GEN_15 ? io_dis_uops_0_bits_exc_cause : _slots_15_io_out_uop_exc_cause),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bypassable
      (_GEN_15 ? io_dis_uops_0_bits_bypassable : _slots_15_io_out_uop_bypassable),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_cmd
      (_GEN_15 ? io_dis_uops_0_bits_mem_cmd : _slots_15_io_out_uop_mem_cmd),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_size
      (_GEN_15 ? io_dis_uops_0_bits_mem_size : _slots_15_io_out_uop_mem_size),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_mem_signed
      (_GEN_15 ? io_dis_uops_0_bits_mem_signed : _slots_15_io_out_uop_mem_signed),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_fence
      (_GEN_15 ? io_dis_uops_0_bits_is_fence : _slots_15_io_out_uop_is_fence),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_fencei
      (_GEN_15 ? io_dis_uops_0_bits_is_fencei : _slots_15_io_out_uop_is_fencei),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_amo
      (_GEN_15 ? io_dis_uops_0_bits_is_amo : _slots_15_io_out_uop_is_amo),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_uses_ldq
      (_GEN_15 ? io_dis_uops_0_bits_uses_ldq : _slots_15_io_out_uop_uses_ldq),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_uses_stq
      (_GEN_15 ? io_dis_uops_0_bits_uses_stq : _slots_15_io_out_uop_uses_stq),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_sys_pc2epc
      (_GEN_15 ? io_dis_uops_0_bits_is_sys_pc2epc : _slots_15_io_out_uop_is_sys_pc2epc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_is_unique
      (_GEN_15 ? io_dis_uops_0_bits_is_unique : _slots_15_io_out_uop_is_unique),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_flush_on_commit
      (_GEN_15
         ? io_dis_uops_0_bits_flush_on_commit
         : _slots_15_io_out_uop_flush_on_commit),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst_is_rs1
      (_GEN_15 ? io_dis_uops_0_bits_ldst_is_rs1 : _slots_15_io_out_uop_ldst_is_rs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst
      (_GEN_15 ? io_dis_uops_0_bits_ldst : _slots_15_io_out_uop_ldst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs1
      (_GEN_15 ? io_dis_uops_0_bits_lrs1 : _slots_15_io_out_uop_lrs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs2
      (_GEN_15 ? io_dis_uops_0_bits_lrs2 : _slots_15_io_out_uop_lrs2),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs3
      (_GEN_15 ? io_dis_uops_0_bits_lrs3 : _slots_15_io_out_uop_lrs3),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_ldst_val
      (_GEN_15 ? io_dis_uops_0_bits_ldst_val : _slots_15_io_out_uop_ldst_val),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_dst_rtype
      (_GEN_15 ? io_dis_uops_0_bits_dst_rtype : _slots_15_io_out_uop_dst_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_lrs1_rtype
      (_GEN_15 ? uops_16_lrs1_rtype : _slots_15_io_out_uop_lrs1_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:120:17, :138:50, :139:32, :153:73
    .io_in_uop_bits_lrs2_rtype
      (_GEN_15 ? io_dis_uops_0_bits_lrs2_rtype : _slots_15_io_out_uop_lrs2_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_frs3_en
      (_GEN_15 ? io_dis_uops_0_bits_frs3_en : _slots_15_io_out_uop_frs3_en),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fp_val
      (_GEN_15 ? io_dis_uops_0_bits_fp_val : _slots_15_io_out_uop_fp_val),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_fp_single
      (_GEN_15 ? io_dis_uops_0_bits_fp_single : _slots_15_io_out_uop_fp_single),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_pf_if
      (_GEN_15 ? io_dis_uops_0_bits_xcpt_pf_if : _slots_15_io_out_uop_xcpt_pf_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_ae_if
      (_GEN_15 ? io_dis_uops_0_bits_xcpt_ae_if : _slots_15_io_out_uop_xcpt_ae_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_xcpt_ma_if
      (_GEN_15 ? io_dis_uops_0_bits_xcpt_ma_if : _slots_15_io_out_uop_xcpt_ma_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bp_debug_if
      (_GEN_15 ? io_dis_uops_0_bits_bp_debug_if : _slots_15_io_out_uop_bp_debug_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_bp_xcpt_if
      (_GEN_15 ? io_dis_uops_0_bits_bp_xcpt_if : _slots_15_io_out_uop_bp_xcpt_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_fsrc
      (_GEN_15 ? io_dis_uops_0_bits_debug_fsrc : _slots_15_io_out_uop_debug_fsrc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_in_uop_bits_debug_tsrc
      (_GEN_15 ? io_dis_uops_0_bits_debug_tsrc : _slots_15_io_out_uop_debug_tsrc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:153:73
    .io_valid                       (_slots_14_io_valid),
    .io_will_be_valid               (_slots_14_io_will_be_valid),
    .io_request                     (_slots_14_io_request),
    .io_out_uop_uopc                (_slots_14_io_out_uop_uopc),
    .io_out_uop_inst                (_slots_14_io_out_uop_inst),
    .io_out_uop_debug_inst          (_slots_14_io_out_uop_debug_inst),
    .io_out_uop_is_rvc              (_slots_14_io_out_uop_is_rvc),
    .io_out_uop_debug_pc            (_slots_14_io_out_uop_debug_pc),
    .io_out_uop_iq_type             (_slots_14_io_out_uop_iq_type),
    .io_out_uop_fu_code             (_slots_14_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_14_io_out_uop_iw_state),
    .io_out_uop_is_br               (_slots_14_io_out_uop_is_br),
    .io_out_uop_is_jalr             (_slots_14_io_out_uop_is_jalr),
    .io_out_uop_is_jal              (_slots_14_io_out_uop_is_jal),
    .io_out_uop_is_sfb              (_slots_14_io_out_uop_is_sfb),
    .io_out_uop_br_mask             (_slots_14_io_out_uop_br_mask),
    .io_out_uop_br_tag              (_slots_14_io_out_uop_br_tag),
    .io_out_uop_ftq_idx             (_slots_14_io_out_uop_ftq_idx),
    .io_out_uop_edge_inst           (_slots_14_io_out_uop_edge_inst),
    .io_out_uop_pc_lob              (_slots_14_io_out_uop_pc_lob),
    .io_out_uop_taken               (_slots_14_io_out_uop_taken),
    .io_out_uop_imm_packed          (_slots_14_io_out_uop_imm_packed),
    .io_out_uop_csr_addr            (_slots_14_io_out_uop_csr_addr),
    .io_out_uop_rob_idx             (_slots_14_io_out_uop_rob_idx),
    .io_out_uop_ldq_idx             (_slots_14_io_out_uop_ldq_idx),
    .io_out_uop_stq_idx             (_slots_14_io_out_uop_stq_idx),
    .io_out_uop_rxq_idx             (_slots_14_io_out_uop_rxq_idx),
    .io_out_uop_pdst                (_slots_14_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_14_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_14_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_14_io_out_uop_prs3),
    .io_out_uop_ppred               (_slots_14_io_out_uop_ppred),
    .io_out_uop_prs1_busy           (_slots_14_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_14_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_14_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_14_io_out_uop_ppred_busy),
    .io_out_uop_stale_pdst          (_slots_14_io_out_uop_stale_pdst),
    .io_out_uop_exception           (_slots_14_io_out_uop_exception),
    .io_out_uop_exc_cause           (_slots_14_io_out_uop_exc_cause),
    .io_out_uop_bypassable          (_slots_14_io_out_uop_bypassable),
    .io_out_uop_mem_cmd             (_slots_14_io_out_uop_mem_cmd),
    .io_out_uop_mem_size            (_slots_14_io_out_uop_mem_size),
    .io_out_uop_mem_signed          (_slots_14_io_out_uop_mem_signed),
    .io_out_uop_is_fence            (_slots_14_io_out_uop_is_fence),
    .io_out_uop_is_fencei           (_slots_14_io_out_uop_is_fencei),
    .io_out_uop_is_amo              (_slots_14_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_14_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_14_io_out_uop_uses_stq),
    .io_out_uop_is_sys_pc2epc       (_slots_14_io_out_uop_is_sys_pc2epc),
    .io_out_uop_is_unique           (_slots_14_io_out_uop_is_unique),
    .io_out_uop_flush_on_commit     (_slots_14_io_out_uop_flush_on_commit),
    .io_out_uop_ldst_is_rs1         (_slots_14_io_out_uop_ldst_is_rs1),
    .io_out_uop_ldst                (_slots_14_io_out_uop_ldst),
    .io_out_uop_lrs1                (_slots_14_io_out_uop_lrs1),
    .io_out_uop_lrs2                (_slots_14_io_out_uop_lrs2),
    .io_out_uop_lrs3                (_slots_14_io_out_uop_lrs3),
    .io_out_uop_ldst_val            (_slots_14_io_out_uop_ldst_val),
    .io_out_uop_dst_rtype           (_slots_14_io_out_uop_dst_rtype),
    .io_out_uop_lrs1_rtype          (_slots_14_io_out_uop_lrs1_rtype),
    .io_out_uop_lrs2_rtype          (_slots_14_io_out_uop_lrs2_rtype),
    .io_out_uop_frs3_en             (_slots_14_io_out_uop_frs3_en),
    .io_out_uop_fp_val              (_slots_14_io_out_uop_fp_val),
    .io_out_uop_fp_single           (_slots_14_io_out_uop_fp_single),
    .io_out_uop_xcpt_pf_if          (_slots_14_io_out_uop_xcpt_pf_if),
    .io_out_uop_xcpt_ae_if          (_slots_14_io_out_uop_xcpt_ae_if),
    .io_out_uop_xcpt_ma_if          (_slots_14_io_out_uop_xcpt_ma_if),
    .io_out_uop_bp_debug_if         (_slots_14_io_out_uop_bp_debug_if),
    .io_out_uop_bp_xcpt_if          (_slots_14_io_out_uop_bp_xcpt_if),
    .io_out_uop_debug_fsrc          (_slots_14_io_out_uop_debug_fsrc),
    .io_out_uop_debug_tsrc          (_slots_14_io_out_uop_debug_tsrc),
    .io_uop_uopc                    (_slots_14_io_uop_uopc),
    .io_uop_inst                    (_slots_14_io_uop_inst),
    .io_uop_debug_inst              (_slots_14_io_uop_debug_inst),
    .io_uop_is_rvc                  (_slots_14_io_uop_is_rvc),
    .io_uop_debug_pc                (_slots_14_io_uop_debug_pc),
    .io_uop_iq_type                 (_slots_14_io_uop_iq_type),
    .io_uop_fu_code                 (_slots_14_io_uop_fu_code),
    .io_uop_iw_state                (_slots_14_io_uop_iw_state),
    .io_uop_is_br                   (_slots_14_io_uop_is_br),
    .io_uop_is_jalr                 (_slots_14_io_uop_is_jalr),
    .io_uop_is_jal                  (_slots_14_io_uop_is_jal),
    .io_uop_is_sfb                  (_slots_14_io_uop_is_sfb),
    .io_uop_br_mask                 (_slots_14_io_uop_br_mask),
    .io_uop_br_tag                  (_slots_14_io_uop_br_tag),
    .io_uop_ftq_idx                 (_slots_14_io_uop_ftq_idx),
    .io_uop_edge_inst               (_slots_14_io_uop_edge_inst),
    .io_uop_pc_lob                  (_slots_14_io_uop_pc_lob),
    .io_uop_taken                   (_slots_14_io_uop_taken),
    .io_uop_imm_packed              (_slots_14_io_uop_imm_packed),
    .io_uop_csr_addr                (_slots_14_io_uop_csr_addr),
    .io_uop_rob_idx                 (_slots_14_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_14_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_14_io_uop_stq_idx),
    .io_uop_rxq_idx                 (_slots_14_io_uop_rxq_idx),
    .io_uop_pdst                    (_slots_14_io_uop_pdst),
    .io_uop_prs1                    (_slots_14_io_uop_prs1),
    .io_uop_prs2                    (_slots_14_io_uop_prs2),
    .io_uop_prs3                    (_slots_14_io_uop_prs3),
    .io_uop_ppred                   (_slots_14_io_uop_ppred),
    .io_uop_prs1_busy               (_slots_14_io_uop_prs1_busy),
    .io_uop_prs2_busy               (_slots_14_io_uop_prs2_busy),
    .io_uop_prs3_busy               (_slots_14_io_uop_prs3_busy),
    .io_uop_ppred_busy              (_slots_14_io_uop_ppred_busy),
    .io_uop_stale_pdst              (_slots_14_io_uop_stale_pdst),
    .io_uop_exception               (_slots_14_io_uop_exception),
    .io_uop_exc_cause               (_slots_14_io_uop_exc_cause),
    .io_uop_bypassable              (_slots_14_io_uop_bypassable),
    .io_uop_mem_cmd                 (_slots_14_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_14_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_14_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_14_io_uop_is_fence),
    .io_uop_is_fencei               (_slots_14_io_uop_is_fencei),
    .io_uop_is_amo                  (_slots_14_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_14_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_14_io_uop_uses_stq),
    .io_uop_is_sys_pc2epc           (_slots_14_io_uop_is_sys_pc2epc),
    .io_uop_is_unique               (_slots_14_io_uop_is_unique),
    .io_uop_flush_on_commit         (_slots_14_io_uop_flush_on_commit),
    .io_uop_ldst_is_rs1             (_slots_14_io_uop_ldst_is_rs1),
    .io_uop_ldst                    (_slots_14_io_uop_ldst),
    .io_uop_lrs1                    (_slots_14_io_uop_lrs1),
    .io_uop_lrs2                    (_slots_14_io_uop_lrs2),
    .io_uop_lrs3                    (_slots_14_io_uop_lrs3),
    .io_uop_ldst_val                (_slots_14_io_uop_ldst_val),
    .io_uop_dst_rtype               (_slots_14_io_uop_dst_rtype),
    .io_uop_lrs1_rtype              (_slots_14_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_14_io_uop_lrs2_rtype),
    .io_uop_frs3_en                 (_slots_14_io_uop_frs3_en),
    .io_uop_fp_val                  (_slots_14_io_uop_fp_val),
    .io_uop_fp_single               (_slots_14_io_uop_fp_single),
    .io_uop_xcpt_pf_if              (_slots_14_io_uop_xcpt_pf_if),
    .io_uop_xcpt_ae_if              (_slots_14_io_uop_xcpt_ae_if),
    .io_uop_xcpt_ma_if              (_slots_14_io_uop_xcpt_ma_if),
    .io_uop_bp_debug_if             (_slots_14_io_uop_bp_debug_if),
    .io_uop_bp_xcpt_if              (_slots_14_io_uop_bp_xcpt_if),
    .io_uop_debug_fsrc              (_slots_14_io_uop_debug_fsrc),
    .io_uop_debug_tsrc              (_slots_14_io_uop_debug_tsrc)
  );
  IssueSlot_168 slots_15 (	// issue-unit.scala:153:73
    .clock                          (clock),
    .reset                          (reset),
    .io_grant                       (issue_slots_15_grant),	// issue-unit-age-ordered.scala:118:56
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_kill                        (io_flush_pipeline),
    .io_clear                       (|next_14),	// issue-unit-age-ordered.scala:45:37, :46:13, :47:44, :76:49
    .io_wakeup_ports_0_valid        (io_wakeup_ports_0_valid),
    .io_wakeup_ports_0_bits_pdst    (io_wakeup_ports_0_bits_pdst),
    .io_wakeup_ports_1_valid        (io_wakeup_ports_1_valid),
    .io_wakeup_ports_1_bits_pdst    (io_wakeup_ports_1_bits_pdst),
    .io_in_uop_valid                (issue_slots_15_in_uop_valid),	// issue-unit-age-ordered.scala:71:48, :72:37
    .io_in_uop_bits_uopc
      (_GEN_16 ? io_dis_uops_1_bits_uopc : io_dis_uops_0_bits_uopc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_inst
      (_GEN_16 ? io_dis_uops_1_bits_inst : io_dis_uops_0_bits_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_debug_inst
      (_GEN_16 ? io_dis_uops_1_bits_debug_inst : io_dis_uops_0_bits_debug_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_is_rvc
      (_GEN_16 ? io_dis_uops_1_bits_is_rvc : io_dis_uops_0_bits_is_rvc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_debug_pc
      (_GEN_16 ? io_dis_uops_1_bits_debug_pc : io_dis_uops_0_bits_debug_pc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_iq_type
      (_GEN_16 ? io_dis_uops_1_bits_iq_type : io_dis_uops_0_bits_iq_type),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_fu_code
      (_GEN_16 ? io_dis_uops_1_bits_fu_code : io_dis_uops_0_bits_fu_code),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_iw_state        (2'h1),	// issue-unit.scala:123:26
    .io_in_uop_bits_is_br
      (_GEN_16 ? io_dis_uops_1_bits_is_br : io_dis_uops_0_bits_is_br),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_is_jalr
      (_GEN_16 ? io_dis_uops_1_bits_is_jalr : io_dis_uops_0_bits_is_jalr),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_is_jal
      (_GEN_16 ? io_dis_uops_1_bits_is_jal : io_dis_uops_0_bits_is_jal),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_is_sfb
      (_GEN_16 ? io_dis_uops_1_bits_is_sfb : io_dis_uops_0_bits_is_sfb),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_br_mask
      (_GEN_16 ? io_dis_uops_1_bits_br_mask : io_dis_uops_0_bits_br_mask),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_br_tag
      (_GEN_16 ? io_dis_uops_1_bits_br_tag : io_dis_uops_0_bits_br_tag),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_ftq_idx
      (_GEN_16 ? io_dis_uops_1_bits_ftq_idx : io_dis_uops_0_bits_ftq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_edge_inst
      (_GEN_16 ? io_dis_uops_1_bits_edge_inst : io_dis_uops_0_bits_edge_inst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_pc_lob
      (_GEN_16 ? io_dis_uops_1_bits_pc_lob : io_dis_uops_0_bits_pc_lob),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_taken
      (_GEN_16 ? io_dis_uops_1_bits_taken : io_dis_uops_0_bits_taken),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_imm_packed
      (_GEN_16 ? io_dis_uops_1_bits_imm_packed : io_dis_uops_0_bits_imm_packed),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_csr_addr
      (_GEN_16 ? io_dis_uops_1_bits_csr_addr : io_dis_uops_0_bits_csr_addr),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_rob_idx
      (_GEN_16 ? io_dis_uops_1_bits_rob_idx : io_dis_uops_0_bits_rob_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_ldq_idx
      (_GEN_16 ? io_dis_uops_1_bits_ldq_idx : io_dis_uops_0_bits_ldq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_stq_idx
      (_GEN_16 ? io_dis_uops_1_bits_stq_idx : io_dis_uops_0_bits_stq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_rxq_idx
      (_GEN_16 ? io_dis_uops_1_bits_rxq_idx : io_dis_uops_0_bits_rxq_idx),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_pdst
      (_GEN_16 ? io_dis_uops_1_bits_pdst : io_dis_uops_0_bits_pdst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_prs1
      (_GEN_16 ? io_dis_uops_1_bits_prs1 : io_dis_uops_0_bits_prs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_prs2
      (_GEN_16 ? io_dis_uops_1_bits_prs2 : io_dis_uops_0_bits_prs2),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_prs3
      (_GEN_16 ? io_dis_uops_1_bits_prs3 : io_dis_uops_0_bits_prs3),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_ppred           (5'h0),	// issue-unit.scala:153:73, :154:28
    .io_in_uop_bits_prs1_busy
      (_GEN_16 ? ~_GEN_0 & io_dis_uops_1_bits_prs1_busy : uops_16_prs1_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:120:17, :138:{38,50}, :140:32
    .io_in_uop_bits_prs2_busy
      (_GEN_16 ? io_dis_uops_1_bits_prs2_busy : io_dis_uops_0_bits_prs2_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_prs3_busy
      (_GEN_16 ? io_dis_uops_1_bits_prs3_busy : io_dis_uops_0_bits_prs3_busy),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_ppred_busy      (1'h0),
    .io_in_uop_bits_stale_pdst
      (_GEN_16 ? io_dis_uops_1_bits_stale_pdst : io_dis_uops_0_bits_stale_pdst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_exception
      (_GEN_16 ? io_dis_uops_1_bits_exception : io_dis_uops_0_bits_exception),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_exc_cause
      (_GEN_16 ? io_dis_uops_1_bits_exc_cause : io_dis_uops_0_bits_exc_cause),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_bypassable
      (_GEN_16 ? io_dis_uops_1_bits_bypassable : io_dis_uops_0_bits_bypassable),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_mem_cmd
      (_GEN_16 ? io_dis_uops_1_bits_mem_cmd : io_dis_uops_0_bits_mem_cmd),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_mem_size
      (_GEN_16 ? io_dis_uops_1_bits_mem_size : io_dis_uops_0_bits_mem_size),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_mem_signed
      (_GEN_16 ? io_dis_uops_1_bits_mem_signed : io_dis_uops_0_bits_mem_signed),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_is_fence
      (_GEN_16 ? io_dis_uops_1_bits_is_fence : io_dis_uops_0_bits_is_fence),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_is_fencei
      (_GEN_16 ? io_dis_uops_1_bits_is_fencei : io_dis_uops_0_bits_is_fencei),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_is_amo
      (_GEN_16 ? io_dis_uops_1_bits_is_amo : io_dis_uops_0_bits_is_amo),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_uses_ldq
      (_GEN_16 ? io_dis_uops_1_bits_uses_ldq : io_dis_uops_0_bits_uses_ldq),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_uses_stq
      (_GEN_16 ? io_dis_uops_1_bits_uses_stq : io_dis_uops_0_bits_uses_stq),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_is_sys_pc2epc
      (_GEN_16 ? io_dis_uops_1_bits_is_sys_pc2epc : io_dis_uops_0_bits_is_sys_pc2epc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_is_unique
      (_GEN_16 ? io_dis_uops_1_bits_is_unique : io_dis_uops_0_bits_is_unique),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_flush_on_commit
      (_GEN_16 ? io_dis_uops_1_bits_flush_on_commit : io_dis_uops_0_bits_flush_on_commit),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_ldst_is_rs1
      (_GEN_16 ? io_dis_uops_1_bits_ldst_is_rs1 : io_dis_uops_0_bits_ldst_is_rs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_ldst
      (_GEN_16 ? io_dis_uops_1_bits_ldst : io_dis_uops_0_bits_ldst),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_lrs1
      (_GEN_16 ? io_dis_uops_1_bits_lrs1 : io_dis_uops_0_bits_lrs1),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_lrs2
      (_GEN_16 ? io_dis_uops_1_bits_lrs2 : io_dis_uops_0_bits_lrs2),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_lrs3
      (_GEN_16 ? io_dis_uops_1_bits_lrs3 : io_dis_uops_0_bits_lrs3),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_ldst_val
      (_GEN_16 ? io_dis_uops_1_bits_ldst_val : io_dis_uops_0_bits_ldst_val),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_dst_rtype
      (_GEN_16 ? io_dis_uops_1_bits_dst_rtype : io_dis_uops_0_bits_dst_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_lrs1_rtype
      (_GEN_16 ? (_GEN_0 ? 2'h2 : io_dis_uops_1_bits_lrs1_rtype) : uops_16_lrs1_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37, issue-unit.scala:120:17, :138:{38,50}, :139:32
    .io_in_uop_bits_lrs2_rtype
      (_GEN_16 ? io_dis_uops_1_bits_lrs2_rtype : io_dis_uops_0_bits_lrs2_rtype),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_frs3_en
      (_GEN_16 ? io_dis_uops_1_bits_frs3_en : io_dis_uops_0_bits_frs3_en),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_fp_val
      (_GEN_16 ? io_dis_uops_1_bits_fp_val : io_dis_uops_0_bits_fp_val),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_fp_single
      (_GEN_16 ? io_dis_uops_1_bits_fp_single : io_dis_uops_0_bits_fp_single),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_xcpt_pf_if
      (_GEN_16 ? io_dis_uops_1_bits_xcpt_pf_if : io_dis_uops_0_bits_xcpt_pf_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_xcpt_ae_if
      (_GEN_16 ? io_dis_uops_1_bits_xcpt_ae_if : io_dis_uops_0_bits_xcpt_ae_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_xcpt_ma_if
      (_GEN_16 ? io_dis_uops_1_bits_xcpt_ma_if : io_dis_uops_0_bits_xcpt_ma_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_bp_debug_if
      (_GEN_16 ? io_dis_uops_1_bits_bp_debug_if : io_dis_uops_0_bits_bp_debug_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_bp_xcpt_if
      (_GEN_16 ? io_dis_uops_1_bits_bp_xcpt_if : io_dis_uops_0_bits_bp_xcpt_if),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_debug_fsrc
      (_GEN_16 ? io_dis_uops_1_bits_debug_fsrc : io_dis_uops_0_bits_debug_fsrc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_in_uop_bits_debug_tsrc
      (_GEN_16 ? io_dis_uops_1_bits_debug_tsrc : io_dis_uops_0_bits_debug_tsrc),	// issue-unit-age-ordered.scala:71:{28,48}, :73:37
    .io_valid                       (_slots_15_io_valid),
    .io_will_be_valid               (_slots_15_io_will_be_valid),
    .io_request                     (_slots_15_io_request),
    .io_out_uop_uopc                (_slots_15_io_out_uop_uopc),
    .io_out_uop_inst                (_slots_15_io_out_uop_inst),
    .io_out_uop_debug_inst          (_slots_15_io_out_uop_debug_inst),
    .io_out_uop_is_rvc              (_slots_15_io_out_uop_is_rvc),
    .io_out_uop_debug_pc            (_slots_15_io_out_uop_debug_pc),
    .io_out_uop_iq_type             (_slots_15_io_out_uop_iq_type),
    .io_out_uop_fu_code             (_slots_15_io_out_uop_fu_code),
    .io_out_uop_iw_state            (_slots_15_io_out_uop_iw_state),
    .io_out_uop_is_br               (_slots_15_io_out_uop_is_br),
    .io_out_uop_is_jalr             (_slots_15_io_out_uop_is_jalr),
    .io_out_uop_is_jal              (_slots_15_io_out_uop_is_jal),
    .io_out_uop_is_sfb              (_slots_15_io_out_uop_is_sfb),
    .io_out_uop_br_mask             (_slots_15_io_out_uop_br_mask),
    .io_out_uop_br_tag              (_slots_15_io_out_uop_br_tag),
    .io_out_uop_ftq_idx             (_slots_15_io_out_uop_ftq_idx),
    .io_out_uop_edge_inst           (_slots_15_io_out_uop_edge_inst),
    .io_out_uop_pc_lob              (_slots_15_io_out_uop_pc_lob),
    .io_out_uop_taken               (_slots_15_io_out_uop_taken),
    .io_out_uop_imm_packed          (_slots_15_io_out_uop_imm_packed),
    .io_out_uop_csr_addr            (_slots_15_io_out_uop_csr_addr),
    .io_out_uop_rob_idx             (_slots_15_io_out_uop_rob_idx),
    .io_out_uop_ldq_idx             (_slots_15_io_out_uop_ldq_idx),
    .io_out_uop_stq_idx             (_slots_15_io_out_uop_stq_idx),
    .io_out_uop_rxq_idx             (_slots_15_io_out_uop_rxq_idx),
    .io_out_uop_pdst                (_slots_15_io_out_uop_pdst),
    .io_out_uop_prs1                (_slots_15_io_out_uop_prs1),
    .io_out_uop_prs2                (_slots_15_io_out_uop_prs2),
    .io_out_uop_prs3                (_slots_15_io_out_uop_prs3),
    .io_out_uop_ppred               (_slots_15_io_out_uop_ppred),
    .io_out_uop_prs1_busy           (_slots_15_io_out_uop_prs1_busy),
    .io_out_uop_prs2_busy           (_slots_15_io_out_uop_prs2_busy),
    .io_out_uop_prs3_busy           (_slots_15_io_out_uop_prs3_busy),
    .io_out_uop_ppred_busy          (_slots_15_io_out_uop_ppred_busy),
    .io_out_uop_stale_pdst          (_slots_15_io_out_uop_stale_pdst),
    .io_out_uop_exception           (_slots_15_io_out_uop_exception),
    .io_out_uop_exc_cause           (_slots_15_io_out_uop_exc_cause),
    .io_out_uop_bypassable          (_slots_15_io_out_uop_bypassable),
    .io_out_uop_mem_cmd             (_slots_15_io_out_uop_mem_cmd),
    .io_out_uop_mem_size            (_slots_15_io_out_uop_mem_size),
    .io_out_uop_mem_signed          (_slots_15_io_out_uop_mem_signed),
    .io_out_uop_is_fence            (_slots_15_io_out_uop_is_fence),
    .io_out_uop_is_fencei           (_slots_15_io_out_uop_is_fencei),
    .io_out_uop_is_amo              (_slots_15_io_out_uop_is_amo),
    .io_out_uop_uses_ldq            (_slots_15_io_out_uop_uses_ldq),
    .io_out_uop_uses_stq            (_slots_15_io_out_uop_uses_stq),
    .io_out_uop_is_sys_pc2epc       (_slots_15_io_out_uop_is_sys_pc2epc),
    .io_out_uop_is_unique           (_slots_15_io_out_uop_is_unique),
    .io_out_uop_flush_on_commit     (_slots_15_io_out_uop_flush_on_commit),
    .io_out_uop_ldst_is_rs1         (_slots_15_io_out_uop_ldst_is_rs1),
    .io_out_uop_ldst                (_slots_15_io_out_uop_ldst),
    .io_out_uop_lrs1                (_slots_15_io_out_uop_lrs1),
    .io_out_uop_lrs2                (_slots_15_io_out_uop_lrs2),
    .io_out_uop_lrs3                (_slots_15_io_out_uop_lrs3),
    .io_out_uop_ldst_val            (_slots_15_io_out_uop_ldst_val),
    .io_out_uop_dst_rtype           (_slots_15_io_out_uop_dst_rtype),
    .io_out_uop_lrs1_rtype          (_slots_15_io_out_uop_lrs1_rtype),
    .io_out_uop_lrs2_rtype          (_slots_15_io_out_uop_lrs2_rtype),
    .io_out_uop_frs3_en             (_slots_15_io_out_uop_frs3_en),
    .io_out_uop_fp_val              (_slots_15_io_out_uop_fp_val),
    .io_out_uop_fp_single           (_slots_15_io_out_uop_fp_single),
    .io_out_uop_xcpt_pf_if          (_slots_15_io_out_uop_xcpt_pf_if),
    .io_out_uop_xcpt_ae_if          (_slots_15_io_out_uop_xcpt_ae_if),
    .io_out_uop_xcpt_ma_if          (_slots_15_io_out_uop_xcpt_ma_if),
    .io_out_uop_bp_debug_if         (_slots_15_io_out_uop_bp_debug_if),
    .io_out_uop_bp_xcpt_if          (_slots_15_io_out_uop_bp_xcpt_if),
    .io_out_uop_debug_fsrc          (_slots_15_io_out_uop_debug_fsrc),
    .io_out_uop_debug_tsrc          (_slots_15_io_out_uop_debug_tsrc),
    .io_uop_uopc                    (_slots_15_io_uop_uopc),
    .io_uop_inst                    (_slots_15_io_uop_inst),
    .io_uop_debug_inst              (_slots_15_io_uop_debug_inst),
    .io_uop_is_rvc                  (_slots_15_io_uop_is_rvc),
    .io_uop_debug_pc                (_slots_15_io_uop_debug_pc),
    .io_uop_iq_type                 (_slots_15_io_uop_iq_type),
    .io_uop_fu_code                 (_slots_15_io_uop_fu_code),
    .io_uop_iw_state                (_slots_15_io_uop_iw_state),
    .io_uop_is_br                   (_slots_15_io_uop_is_br),
    .io_uop_is_jalr                 (_slots_15_io_uop_is_jalr),
    .io_uop_is_jal                  (_slots_15_io_uop_is_jal),
    .io_uop_is_sfb                  (_slots_15_io_uop_is_sfb),
    .io_uop_br_mask                 (_slots_15_io_uop_br_mask),
    .io_uop_br_tag                  (_slots_15_io_uop_br_tag),
    .io_uop_ftq_idx                 (_slots_15_io_uop_ftq_idx),
    .io_uop_edge_inst               (_slots_15_io_uop_edge_inst),
    .io_uop_pc_lob                  (_slots_15_io_uop_pc_lob),
    .io_uop_taken                   (_slots_15_io_uop_taken),
    .io_uop_imm_packed              (_slots_15_io_uop_imm_packed),
    .io_uop_csr_addr                (_slots_15_io_uop_csr_addr),
    .io_uop_rob_idx                 (_slots_15_io_uop_rob_idx),
    .io_uop_ldq_idx                 (_slots_15_io_uop_ldq_idx),
    .io_uop_stq_idx                 (_slots_15_io_uop_stq_idx),
    .io_uop_rxq_idx                 (_slots_15_io_uop_rxq_idx),
    .io_uop_pdst                    (_slots_15_io_uop_pdst),
    .io_uop_prs1                    (_slots_15_io_uop_prs1),
    .io_uop_prs2                    (_slots_15_io_uop_prs2),
    .io_uop_prs3                    (_slots_15_io_uop_prs3),
    .io_uop_ppred                   (_slots_15_io_uop_ppred),
    .io_uop_prs1_busy               (_slots_15_io_uop_prs1_busy),
    .io_uop_prs2_busy               (_slots_15_io_uop_prs2_busy),
    .io_uop_prs3_busy               (_slots_15_io_uop_prs3_busy),
    .io_uop_ppred_busy              (_slots_15_io_uop_ppred_busy),
    .io_uop_stale_pdst              (_slots_15_io_uop_stale_pdst),
    .io_uop_exception               (_slots_15_io_uop_exception),
    .io_uop_exc_cause               (_slots_15_io_uop_exc_cause),
    .io_uop_bypassable              (_slots_15_io_uop_bypassable),
    .io_uop_mem_cmd                 (_slots_15_io_uop_mem_cmd),
    .io_uop_mem_size                (_slots_15_io_uop_mem_size),
    .io_uop_mem_signed              (_slots_15_io_uop_mem_signed),
    .io_uop_is_fence                (_slots_15_io_uop_is_fence),
    .io_uop_is_fencei               (_slots_15_io_uop_is_fencei),
    .io_uop_is_amo                  (_slots_15_io_uop_is_amo),
    .io_uop_uses_ldq                (_slots_15_io_uop_uses_ldq),
    .io_uop_uses_stq                (_slots_15_io_uop_uses_stq),
    .io_uop_is_sys_pc2epc           (_slots_15_io_uop_is_sys_pc2epc),
    .io_uop_is_unique               (_slots_15_io_uop_is_unique),
    .io_uop_flush_on_commit         (_slots_15_io_uop_flush_on_commit),
    .io_uop_ldst_is_rs1             (_slots_15_io_uop_ldst_is_rs1),
    .io_uop_ldst                    (_slots_15_io_uop_ldst),
    .io_uop_lrs1                    (_slots_15_io_uop_lrs1),
    .io_uop_lrs2                    (_slots_15_io_uop_lrs2),
    .io_uop_lrs3                    (_slots_15_io_uop_lrs3),
    .io_uop_ldst_val                (_slots_15_io_uop_ldst_val),
    .io_uop_dst_rtype               (_slots_15_io_uop_dst_rtype),
    .io_uop_lrs1_rtype              (_slots_15_io_uop_lrs1_rtype),
    .io_uop_lrs2_rtype              (_slots_15_io_uop_lrs2_rtype),
    .io_uop_frs3_en                 (_slots_15_io_uop_frs3_en),
    .io_uop_fp_val                  (_slots_15_io_uop_fp_val),
    .io_uop_fp_single               (_slots_15_io_uop_fp_single),
    .io_uop_xcpt_pf_if              (_slots_15_io_uop_xcpt_pf_if),
    .io_uop_xcpt_ae_if              (_slots_15_io_uop_xcpt_ae_if),
    .io_uop_xcpt_ma_if              (_slots_15_io_uop_xcpt_ma_if),
    .io_uop_bp_debug_if             (_slots_15_io_uop_bp_debug_if),
    .io_uop_bp_xcpt_if              (_slots_15_io_uop_bp_xcpt_if),
    .io_uop_debug_fsrc              (_slots_15_io_uop_debug_fsrc),
    .io_uop_debug_tsrc              (_slots_15_io_uop_debug_tsrc)
  );
  assign io_dis_uops_0_ready = io_dis_uops_0_ready_REG;	// issue-unit-age-ordered.scala:87:36
  assign io_dis_uops_1_ready = io_dis_uops_1_ready_REG;	// issue-unit-age-ordered.scala:87:36
  assign io_iss_valids_0 =
    issue_slots_15_grant | issue_slots_14_grant | issue_slots_13_grant
    | issue_slots_12_grant | issue_slots_11_grant | issue_slots_10_grant
    | issue_slots_9_grant | issue_slots_8_grant | issue_slots_7_grant
    | issue_slots_6_grant | issue_slots_5_grant | issue_slots_4_grant
    | issue_slots_3_grant | issue_slots_2_grant | issue_slots_1_grant
    | issue_slots_0_grant;	// issue-unit-age-ordered.scala:118:{40,56,76}, :120:26
  assign io_iss_uops_0_uopc =
    issue_slots_15_grant
      ? _slots_15_io_uop_uopc
      : issue_slots_14_grant
          ? _slots_14_io_uop_uopc
          : issue_slots_13_grant
              ? _slots_13_io_uop_uopc
              : issue_slots_12_grant
                  ? _slots_12_io_uop_uopc
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_uopc
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_uopc
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_uopc
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_uopc
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_uopc
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_uopc
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_uopc
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_uopc
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_uopc
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_uopc
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_uopc
                                                              : issue_slots_0_grant
                                                                  ? _slots_0_io_uop_uopc
                                                                  : 7'h0;	// consts.scala:270:20, issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_inst =
    issue_slots_15_grant
      ? _slots_15_io_uop_inst
      : issue_slots_14_grant
          ? _slots_14_io_uop_inst
          : issue_slots_13_grant
              ? _slots_13_io_uop_inst
              : issue_slots_12_grant
                  ? _slots_12_io_uop_inst
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_inst
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_inst
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_inst
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_inst
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_inst
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_inst
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_inst
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_inst
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_inst
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_inst
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_inst
                                                              : issue_slots_0_grant
                                                                  ? _slots_0_io_uop_inst
                                                                  : 32'h0;	// consts.scala:270:20, issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_debug_inst =
    issue_slots_15_grant
      ? _slots_15_io_uop_debug_inst
      : issue_slots_14_grant
          ? _slots_14_io_uop_debug_inst
          : issue_slots_13_grant
              ? _slots_13_io_uop_debug_inst
              : issue_slots_12_grant
                  ? _slots_12_io_uop_debug_inst
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_debug_inst
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_debug_inst
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_debug_inst
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_debug_inst
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_debug_inst
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_debug_inst
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_debug_inst
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_debug_inst
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_debug_inst
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_debug_inst
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_debug_inst
                                                              : issue_slots_0_grant
                                                                  ? _slots_0_io_uop_debug_inst
                                                                  : 32'h0;	// consts.scala:270:20, issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_is_rvc =
    issue_slots_15_grant
      ? _slots_15_io_uop_is_rvc
      : issue_slots_14_grant
          ? _slots_14_io_uop_is_rvc
          : issue_slots_13_grant
              ? _slots_13_io_uop_is_rvc
              : issue_slots_12_grant
                  ? _slots_12_io_uop_is_rvc
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_is_rvc
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_is_rvc
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_is_rvc
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_is_rvc
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_is_rvc
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_is_rvc
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_is_rvc
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_is_rvc
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_is_rvc
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_is_rvc
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_is_rvc
                                                              : issue_slots_0_grant
                                                                & _slots_0_io_uop_is_rvc;	// issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_debug_pc =
    issue_slots_15_grant
      ? _slots_15_io_uop_debug_pc
      : issue_slots_14_grant
          ? _slots_14_io_uop_debug_pc
          : issue_slots_13_grant
              ? _slots_13_io_uop_debug_pc
              : issue_slots_12_grant
                  ? _slots_12_io_uop_debug_pc
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_debug_pc
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_debug_pc
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_debug_pc
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_debug_pc
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_debug_pc
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_debug_pc
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_debug_pc
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_debug_pc
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_debug_pc
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_debug_pc
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_debug_pc
                                                              : issue_slots_0_grant
                                                                  ? _slots_0_io_uop_debug_pc
                                                                  : 40'h0;	// consts.scala:270:20, issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_iq_type =
    issue_slots_15_grant
      ? _slots_15_io_uop_iq_type
      : issue_slots_14_grant
          ? _slots_14_io_uop_iq_type
          : issue_slots_13_grant
              ? _slots_13_io_uop_iq_type
              : issue_slots_12_grant
                  ? _slots_12_io_uop_iq_type
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_iq_type
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_iq_type
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_iq_type
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_iq_type
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_iq_type
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_iq_type
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_iq_type
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_iq_type
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_iq_type
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_iq_type
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_iq_type
                                                              : issue_slots_0_grant
                                                                  ? _slots_0_io_uop_iq_type
                                                                  : 3'h0;	// consts.scala:270:20, issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_fu_code =
    issue_slots_15_grant
      ? _slots_15_io_uop_fu_code
      : issue_slots_14_grant
          ? _slots_14_io_uop_fu_code
          : issue_slots_13_grant
              ? _slots_13_io_uop_fu_code
              : issue_slots_12_grant
                  ? _slots_12_io_uop_fu_code
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_fu_code
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_fu_code
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_fu_code
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_fu_code
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_fu_code
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_fu_code
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_fu_code
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_fu_code
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_fu_code
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_fu_code
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_fu_code
                                                              : issue_slots_0_grant
                                                                  ? _slots_0_io_uop_fu_code
                                                                  : 10'h0;	// consts.scala:270:20, issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_iw_state =
    issue_slots_15_grant
      ? _slots_15_io_uop_iw_state
      : issue_slots_14_grant
          ? _slots_14_io_uop_iw_state
          : issue_slots_13_grant
              ? _slots_13_io_uop_iw_state
              : issue_slots_12_grant
                  ? _slots_12_io_uop_iw_state
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_iw_state
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_iw_state
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_iw_state
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_iw_state
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_iw_state
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_iw_state
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_iw_state
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_iw_state
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_iw_state
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_iw_state
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_iw_state
                                                              : issue_slots_0_grant
                                                                  ? _slots_0_io_uop_iw_state
                                                                  : 2'h0;	// consts.scala:270:20, issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_iw_p1_poisoned = 1'h0;
  assign io_iss_uops_0_iw_p2_poisoned = 1'h0;
  assign io_iss_uops_0_is_br =
    issue_slots_15_grant
      ? _slots_15_io_uop_is_br
      : issue_slots_14_grant
          ? _slots_14_io_uop_is_br
          : issue_slots_13_grant
              ? _slots_13_io_uop_is_br
              : issue_slots_12_grant
                  ? _slots_12_io_uop_is_br
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_is_br
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_is_br
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_is_br
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_is_br
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_is_br
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_is_br
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_is_br
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_is_br
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_is_br
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_is_br
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_is_br
                                                              : issue_slots_0_grant
                                                                & _slots_0_io_uop_is_br;	// issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_is_jalr =
    issue_slots_15_grant
      ? _slots_15_io_uop_is_jalr
      : issue_slots_14_grant
          ? _slots_14_io_uop_is_jalr
          : issue_slots_13_grant
              ? _slots_13_io_uop_is_jalr
              : issue_slots_12_grant
                  ? _slots_12_io_uop_is_jalr
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_is_jalr
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_is_jalr
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_is_jalr
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_is_jalr
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_is_jalr
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_is_jalr
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_is_jalr
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_is_jalr
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_is_jalr
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_is_jalr
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_is_jalr
                                                              : issue_slots_0_grant
                                                                & _slots_0_io_uop_is_jalr;	// issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_is_jal =
    issue_slots_15_grant
      ? _slots_15_io_uop_is_jal
      : issue_slots_14_grant
          ? _slots_14_io_uop_is_jal
          : issue_slots_13_grant
              ? _slots_13_io_uop_is_jal
              : issue_slots_12_grant
                  ? _slots_12_io_uop_is_jal
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_is_jal
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_is_jal
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_is_jal
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_is_jal
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_is_jal
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_is_jal
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_is_jal
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_is_jal
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_is_jal
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_is_jal
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_is_jal
                                                              : issue_slots_0_grant
                                                                & _slots_0_io_uop_is_jal;	// issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_is_sfb =
    issue_slots_15_grant
      ? _slots_15_io_uop_is_sfb
      : issue_slots_14_grant
          ? _slots_14_io_uop_is_sfb
          : issue_slots_13_grant
              ? _slots_13_io_uop_is_sfb
              : issue_slots_12_grant
                  ? _slots_12_io_uop_is_sfb
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_is_sfb
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_is_sfb
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_is_sfb
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_is_sfb
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_is_sfb
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_is_sfb
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_is_sfb
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_is_sfb
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_is_sfb
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_is_sfb
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_is_sfb
                                                              : issue_slots_0_grant
                                                                & _slots_0_io_uop_is_sfb;	// issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_br_mask =
    issue_slots_15_grant
      ? _slots_15_io_uop_br_mask
      : issue_slots_14_grant
          ? _slots_14_io_uop_br_mask
          : issue_slots_13_grant
              ? _slots_13_io_uop_br_mask
              : issue_slots_12_grant
                  ? _slots_12_io_uop_br_mask
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_br_mask
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_br_mask
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_br_mask
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_br_mask
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_br_mask
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_br_mask
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_br_mask
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_br_mask
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_br_mask
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_br_mask
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_br_mask
                                                              : issue_slots_0_grant
                                                                  ? _slots_0_io_uop_br_mask
                                                                  : 12'h0;	// consts.scala:270:20, issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_br_tag =
    issue_slots_15_grant
      ? _slots_15_io_uop_br_tag
      : issue_slots_14_grant
          ? _slots_14_io_uop_br_tag
          : issue_slots_13_grant
              ? _slots_13_io_uop_br_tag
              : issue_slots_12_grant
                  ? _slots_12_io_uop_br_tag
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_br_tag
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_br_tag
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_br_tag
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_br_tag
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_br_tag
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_br_tag
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_br_tag
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_br_tag
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_br_tag
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_br_tag
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_br_tag
                                                              : issue_slots_0_grant
                                                                  ? _slots_0_io_uop_br_tag
                                                                  : 4'h0;	// consts.scala:270:20, issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_ftq_idx =
    issue_slots_15_grant
      ? _slots_15_io_uop_ftq_idx
      : issue_slots_14_grant
          ? _slots_14_io_uop_ftq_idx
          : issue_slots_13_grant
              ? _slots_13_io_uop_ftq_idx
              : issue_slots_12_grant
                  ? _slots_12_io_uop_ftq_idx
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_ftq_idx
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_ftq_idx
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_ftq_idx
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_ftq_idx
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_ftq_idx
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_ftq_idx
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_ftq_idx
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_ftq_idx
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_ftq_idx
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_ftq_idx
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_ftq_idx
                                                              : issue_slots_0_grant
                                                                  ? _slots_0_io_uop_ftq_idx
                                                                  : 5'h0;	// issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73, :154:28
  assign io_iss_uops_0_edge_inst =
    issue_slots_15_grant
      ? _slots_15_io_uop_edge_inst
      : issue_slots_14_grant
          ? _slots_14_io_uop_edge_inst
          : issue_slots_13_grant
              ? _slots_13_io_uop_edge_inst
              : issue_slots_12_grant
                  ? _slots_12_io_uop_edge_inst
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_edge_inst
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_edge_inst
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_edge_inst
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_edge_inst
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_edge_inst
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_edge_inst
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_edge_inst
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_edge_inst
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_edge_inst
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_edge_inst
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_edge_inst
                                                              : issue_slots_0_grant
                                                                & _slots_0_io_uop_edge_inst;	// issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_pc_lob =
    issue_slots_15_grant
      ? _slots_15_io_uop_pc_lob
      : issue_slots_14_grant
          ? _slots_14_io_uop_pc_lob
          : issue_slots_13_grant
              ? _slots_13_io_uop_pc_lob
              : issue_slots_12_grant
                  ? _slots_12_io_uop_pc_lob
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_pc_lob
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_pc_lob
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_pc_lob
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_pc_lob
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_pc_lob
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_pc_lob
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_pc_lob
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_pc_lob
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_pc_lob
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_pc_lob
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_pc_lob
                                                              : issue_slots_0_grant
                                                                  ? _slots_0_io_uop_pc_lob
                                                                  : 6'h0;	// consts.scala:270:20, issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_taken =
    issue_slots_15_grant
      ? _slots_15_io_uop_taken
      : issue_slots_14_grant
          ? _slots_14_io_uop_taken
          : issue_slots_13_grant
              ? _slots_13_io_uop_taken
              : issue_slots_12_grant
                  ? _slots_12_io_uop_taken
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_taken
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_taken
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_taken
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_taken
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_taken
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_taken
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_taken
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_taken
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_taken
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_taken
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_taken
                                                              : issue_slots_0_grant
                                                                & _slots_0_io_uop_taken;	// issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_imm_packed =
    issue_slots_15_grant
      ? _slots_15_io_uop_imm_packed
      : issue_slots_14_grant
          ? _slots_14_io_uop_imm_packed
          : issue_slots_13_grant
              ? _slots_13_io_uop_imm_packed
              : issue_slots_12_grant
                  ? _slots_12_io_uop_imm_packed
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_imm_packed
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_imm_packed
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_imm_packed
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_imm_packed
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_imm_packed
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_imm_packed
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_imm_packed
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_imm_packed
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_imm_packed
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_imm_packed
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_imm_packed
                                                              : issue_slots_0_grant
                                                                  ? _slots_0_io_uop_imm_packed
                                                                  : 20'h0;	// consts.scala:270:20, issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_csr_addr =
    issue_slots_15_grant
      ? _slots_15_io_uop_csr_addr
      : issue_slots_14_grant
          ? _slots_14_io_uop_csr_addr
          : issue_slots_13_grant
              ? _slots_13_io_uop_csr_addr
              : issue_slots_12_grant
                  ? _slots_12_io_uop_csr_addr
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_csr_addr
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_csr_addr
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_csr_addr
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_csr_addr
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_csr_addr
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_csr_addr
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_csr_addr
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_csr_addr
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_csr_addr
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_csr_addr
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_csr_addr
                                                              : issue_slots_0_grant
                                                                  ? _slots_0_io_uop_csr_addr
                                                                  : 12'h0;	// consts.scala:270:20, issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_rob_idx =
    issue_slots_15_grant
      ? _slots_15_io_uop_rob_idx
      : issue_slots_14_grant
          ? _slots_14_io_uop_rob_idx
          : issue_slots_13_grant
              ? _slots_13_io_uop_rob_idx
              : issue_slots_12_grant
                  ? _slots_12_io_uop_rob_idx
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_rob_idx
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_rob_idx
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_rob_idx
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_rob_idx
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_rob_idx
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_rob_idx
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_rob_idx
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_rob_idx
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_rob_idx
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_rob_idx
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_rob_idx
                                                              : issue_slots_0_grant
                                                                  ? _slots_0_io_uop_rob_idx
                                                                  : 6'h0;	// consts.scala:270:20, issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_ldq_idx =
    issue_slots_15_grant
      ? _slots_15_io_uop_ldq_idx
      : issue_slots_14_grant
          ? _slots_14_io_uop_ldq_idx
          : issue_slots_13_grant
              ? _slots_13_io_uop_ldq_idx
              : issue_slots_12_grant
                  ? _slots_12_io_uop_ldq_idx
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_ldq_idx
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_ldq_idx
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_ldq_idx
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_ldq_idx
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_ldq_idx
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_ldq_idx
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_ldq_idx
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_ldq_idx
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_ldq_idx
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_ldq_idx
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_ldq_idx
                                                              : issue_slots_0_grant
                                                                  ? _slots_0_io_uop_ldq_idx
                                                                  : 4'h0;	// consts.scala:270:20, issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_stq_idx =
    issue_slots_15_grant
      ? _slots_15_io_uop_stq_idx
      : issue_slots_14_grant
          ? _slots_14_io_uop_stq_idx
          : issue_slots_13_grant
              ? _slots_13_io_uop_stq_idx
              : issue_slots_12_grant
                  ? _slots_12_io_uop_stq_idx
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_stq_idx
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_stq_idx
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_stq_idx
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_stq_idx
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_stq_idx
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_stq_idx
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_stq_idx
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_stq_idx
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_stq_idx
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_stq_idx
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_stq_idx
                                                              : issue_slots_0_grant
                                                                  ? _slots_0_io_uop_stq_idx
                                                                  : 4'h0;	// consts.scala:270:20, issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_rxq_idx =
    issue_slots_15_grant
      ? _slots_15_io_uop_rxq_idx
      : issue_slots_14_grant
          ? _slots_14_io_uop_rxq_idx
          : issue_slots_13_grant
              ? _slots_13_io_uop_rxq_idx
              : issue_slots_12_grant
                  ? _slots_12_io_uop_rxq_idx
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_rxq_idx
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_rxq_idx
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_rxq_idx
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_rxq_idx
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_rxq_idx
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_rxq_idx
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_rxq_idx
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_rxq_idx
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_rxq_idx
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_rxq_idx
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_rxq_idx
                                                              : issue_slots_0_grant
                                                                  ? _slots_0_io_uop_rxq_idx
                                                                  : 2'h0;	// consts.scala:270:20, issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_pdst =
    issue_slots_15_grant
      ? _slots_15_io_uop_pdst
      : issue_slots_14_grant
          ? _slots_14_io_uop_pdst
          : issue_slots_13_grant
              ? _slots_13_io_uop_pdst
              : issue_slots_12_grant
                  ? _slots_12_io_uop_pdst
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_pdst
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_pdst
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_pdst
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_pdst
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_pdst
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_pdst
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_pdst
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_pdst
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_pdst
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_pdst
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_pdst
                                                              : issue_slots_0_grant
                                                                  ? _slots_0_io_uop_pdst
                                                                  : 7'h0;	// consts.scala:270:20, issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_prs1 =
    issue_slots_15_grant
      ? _slots_15_io_uop_prs1
      : issue_slots_14_grant
          ? _slots_14_io_uop_prs1
          : issue_slots_13_grant
              ? _slots_13_io_uop_prs1
              : issue_slots_12_grant
                  ? _slots_12_io_uop_prs1
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_prs1
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_prs1
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_prs1
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_prs1
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_prs1
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_prs1
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_prs1
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_prs1
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_prs1
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_prs1
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_prs1
                                                              : issue_slots_0_grant
                                                                  ? _slots_0_io_uop_prs1
                                                                  : 7'h0;	// consts.scala:270:20, issue-unit-age-ordered.scala:98:25, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_prs2 =
    issue_slots_15_grant
      ? _slots_15_io_uop_prs2
      : issue_slots_14_grant
          ? _slots_14_io_uop_prs2
          : issue_slots_13_grant
              ? _slots_13_io_uop_prs2
              : issue_slots_12_grant
                  ? _slots_12_io_uop_prs2
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_prs2
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_prs2
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_prs2
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_prs2
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_prs2
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_prs2
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_prs2
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_prs2
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_prs2
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_prs2
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_prs2
                                                              : issue_slots_0_grant
                                                                  ? _slots_0_io_uop_prs2
                                                                  : 7'h0;	// consts.scala:270:20, issue-unit-age-ordered.scala:99:25, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_prs3 =
    issue_slots_15_grant
      ? _slots_15_io_uop_prs3
      : issue_slots_14_grant
          ? _slots_14_io_uop_prs3
          : issue_slots_13_grant
              ? _slots_13_io_uop_prs3
              : issue_slots_12_grant
                  ? _slots_12_io_uop_prs3
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_prs3
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_prs3
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_prs3
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_prs3
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_prs3
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_prs3
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_prs3
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_prs3
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_prs3
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_prs3
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_prs3
                                                              : issue_slots_0_grant
                                                                  ? _slots_0_io_uop_prs3
                                                                  : 7'h0;	// consts.scala:270:20, issue-unit-age-ordered.scala:100:25, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_ppred =
    issue_slots_15_grant
      ? _slots_15_io_uop_ppred
      : issue_slots_14_grant
          ? _slots_14_io_uop_ppred
          : issue_slots_13_grant
              ? _slots_13_io_uop_ppred
              : issue_slots_12_grant
                  ? _slots_12_io_uop_ppred
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_ppred
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_ppred
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_ppred
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_ppred
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_ppred
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_ppred
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_ppred
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_ppred
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_ppred
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_ppred
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_ppred
                                                              : issue_slots_0_grant
                                                                  ? _slots_0_io_uop_ppred
                                                                  : 5'h0;	// issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73, :154:28
  assign io_iss_uops_0_prs1_busy =
    issue_slots_15_grant
      ? _slots_15_io_uop_prs1_busy
      : issue_slots_14_grant
          ? _slots_14_io_uop_prs1_busy
          : issue_slots_13_grant
              ? _slots_13_io_uop_prs1_busy
              : issue_slots_12_grant
                  ? _slots_12_io_uop_prs1_busy
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_prs1_busy
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_prs1_busy
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_prs1_busy
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_prs1_busy
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_prs1_busy
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_prs1_busy
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_prs1_busy
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_prs1_busy
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_prs1_busy
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_prs1_busy
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_prs1_busy
                                                              : issue_slots_0_grant
                                                                & _slots_0_io_uop_prs1_busy;	// issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_prs2_busy =
    issue_slots_15_grant
      ? _slots_15_io_uop_prs2_busy
      : issue_slots_14_grant
          ? _slots_14_io_uop_prs2_busy
          : issue_slots_13_grant
              ? _slots_13_io_uop_prs2_busy
              : issue_slots_12_grant
                  ? _slots_12_io_uop_prs2_busy
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_prs2_busy
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_prs2_busy
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_prs2_busy
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_prs2_busy
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_prs2_busy
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_prs2_busy
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_prs2_busy
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_prs2_busy
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_prs2_busy
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_prs2_busy
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_prs2_busy
                                                              : issue_slots_0_grant
                                                                & _slots_0_io_uop_prs2_busy;	// issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_prs3_busy =
    issue_slots_15_grant
      ? _slots_15_io_uop_prs3_busy
      : issue_slots_14_grant
          ? _slots_14_io_uop_prs3_busy
          : issue_slots_13_grant
              ? _slots_13_io_uop_prs3_busy
              : issue_slots_12_grant
                  ? _slots_12_io_uop_prs3_busy
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_prs3_busy
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_prs3_busy
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_prs3_busy
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_prs3_busy
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_prs3_busy
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_prs3_busy
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_prs3_busy
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_prs3_busy
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_prs3_busy
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_prs3_busy
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_prs3_busy
                                                              : issue_slots_0_grant
                                                                & _slots_0_io_uop_prs3_busy;	// issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_ppred_busy =
    issue_slots_15_grant
      ? _slots_15_io_uop_ppred_busy
      : issue_slots_14_grant
          ? _slots_14_io_uop_ppred_busy
          : issue_slots_13_grant
              ? _slots_13_io_uop_ppred_busy
              : issue_slots_12_grant
                  ? _slots_12_io_uop_ppred_busy
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_ppred_busy
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_ppred_busy
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_ppred_busy
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_ppred_busy
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_ppred_busy
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_ppred_busy
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_ppred_busy
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_ppred_busy
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_ppred_busy
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_ppred_busy
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_ppred_busy
                                                              : issue_slots_0_grant
                                                                & _slots_0_io_uop_ppred_busy;	// issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_stale_pdst =
    issue_slots_15_grant
      ? _slots_15_io_uop_stale_pdst
      : issue_slots_14_grant
          ? _slots_14_io_uop_stale_pdst
          : issue_slots_13_grant
              ? _slots_13_io_uop_stale_pdst
              : issue_slots_12_grant
                  ? _slots_12_io_uop_stale_pdst
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_stale_pdst
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_stale_pdst
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_stale_pdst
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_stale_pdst
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_stale_pdst
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_stale_pdst
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_stale_pdst
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_stale_pdst
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_stale_pdst
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_stale_pdst
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_stale_pdst
                                                              : issue_slots_0_grant
                                                                  ? _slots_0_io_uop_stale_pdst
                                                                  : 7'h0;	// consts.scala:270:20, issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_exception =
    issue_slots_15_grant
      ? _slots_15_io_uop_exception
      : issue_slots_14_grant
          ? _slots_14_io_uop_exception
          : issue_slots_13_grant
              ? _slots_13_io_uop_exception
              : issue_slots_12_grant
                  ? _slots_12_io_uop_exception
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_exception
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_exception
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_exception
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_exception
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_exception
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_exception
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_exception
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_exception
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_exception
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_exception
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_exception
                                                              : issue_slots_0_grant
                                                                & _slots_0_io_uop_exception;	// issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_exc_cause =
    issue_slots_15_grant
      ? _slots_15_io_uop_exc_cause
      : issue_slots_14_grant
          ? _slots_14_io_uop_exc_cause
          : issue_slots_13_grant
              ? _slots_13_io_uop_exc_cause
              : issue_slots_12_grant
                  ? _slots_12_io_uop_exc_cause
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_exc_cause
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_exc_cause
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_exc_cause
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_exc_cause
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_exc_cause
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_exc_cause
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_exc_cause
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_exc_cause
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_exc_cause
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_exc_cause
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_exc_cause
                                                              : issue_slots_0_grant
                                                                  ? _slots_0_io_uop_exc_cause
                                                                  : 64'h0;	// consts.scala:270:20, issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_bypassable =
    issue_slots_15_grant
      ? _slots_15_io_uop_bypassable
      : issue_slots_14_grant
          ? _slots_14_io_uop_bypassable
          : issue_slots_13_grant
              ? _slots_13_io_uop_bypassable
              : issue_slots_12_grant
                  ? _slots_12_io_uop_bypassable
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_bypassable
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_bypassable
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_bypassable
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_bypassable
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_bypassable
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_bypassable
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_bypassable
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_bypassable
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_bypassable
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_bypassable
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_bypassable
                                                              : issue_slots_0_grant
                                                                & _slots_0_io_uop_bypassable;	// issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_mem_cmd =
    issue_slots_15_grant
      ? _slots_15_io_uop_mem_cmd
      : issue_slots_14_grant
          ? _slots_14_io_uop_mem_cmd
          : issue_slots_13_grant
              ? _slots_13_io_uop_mem_cmd
              : issue_slots_12_grant
                  ? _slots_12_io_uop_mem_cmd
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_mem_cmd
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_mem_cmd
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_mem_cmd
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_mem_cmd
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_mem_cmd
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_mem_cmd
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_mem_cmd
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_mem_cmd
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_mem_cmd
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_mem_cmd
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_mem_cmd
                                                              : issue_slots_0_grant
                                                                  ? _slots_0_io_uop_mem_cmd
                                                                  : 5'h0;	// issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73, :154:28
  assign io_iss_uops_0_mem_size =
    issue_slots_15_grant
      ? _slots_15_io_uop_mem_size
      : issue_slots_14_grant
          ? _slots_14_io_uop_mem_size
          : issue_slots_13_grant
              ? _slots_13_io_uop_mem_size
              : issue_slots_12_grant
                  ? _slots_12_io_uop_mem_size
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_mem_size
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_mem_size
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_mem_size
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_mem_size
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_mem_size
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_mem_size
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_mem_size
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_mem_size
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_mem_size
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_mem_size
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_mem_size
                                                              : issue_slots_0_grant
                                                                  ? _slots_0_io_uop_mem_size
                                                                  : 2'h0;	// consts.scala:270:20, issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_mem_signed =
    issue_slots_15_grant
      ? _slots_15_io_uop_mem_signed
      : issue_slots_14_grant
          ? _slots_14_io_uop_mem_signed
          : issue_slots_13_grant
              ? _slots_13_io_uop_mem_signed
              : issue_slots_12_grant
                  ? _slots_12_io_uop_mem_signed
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_mem_signed
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_mem_signed
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_mem_signed
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_mem_signed
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_mem_signed
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_mem_signed
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_mem_signed
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_mem_signed
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_mem_signed
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_mem_signed
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_mem_signed
                                                              : issue_slots_0_grant
                                                                & _slots_0_io_uop_mem_signed;	// issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_is_fence =
    issue_slots_15_grant
      ? _slots_15_io_uop_is_fence
      : issue_slots_14_grant
          ? _slots_14_io_uop_is_fence
          : issue_slots_13_grant
              ? _slots_13_io_uop_is_fence
              : issue_slots_12_grant
                  ? _slots_12_io_uop_is_fence
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_is_fence
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_is_fence
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_is_fence
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_is_fence
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_is_fence
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_is_fence
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_is_fence
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_is_fence
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_is_fence
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_is_fence
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_is_fence
                                                              : issue_slots_0_grant
                                                                & _slots_0_io_uop_is_fence;	// issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_is_fencei =
    issue_slots_15_grant
      ? _slots_15_io_uop_is_fencei
      : issue_slots_14_grant
          ? _slots_14_io_uop_is_fencei
          : issue_slots_13_grant
              ? _slots_13_io_uop_is_fencei
              : issue_slots_12_grant
                  ? _slots_12_io_uop_is_fencei
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_is_fencei
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_is_fencei
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_is_fencei
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_is_fencei
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_is_fencei
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_is_fencei
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_is_fencei
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_is_fencei
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_is_fencei
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_is_fencei
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_is_fencei
                                                              : issue_slots_0_grant
                                                                & _slots_0_io_uop_is_fencei;	// issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_is_amo =
    issue_slots_15_grant
      ? _slots_15_io_uop_is_amo
      : issue_slots_14_grant
          ? _slots_14_io_uop_is_amo
          : issue_slots_13_grant
              ? _slots_13_io_uop_is_amo
              : issue_slots_12_grant
                  ? _slots_12_io_uop_is_amo
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_is_amo
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_is_amo
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_is_amo
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_is_amo
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_is_amo
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_is_amo
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_is_amo
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_is_amo
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_is_amo
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_is_amo
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_is_amo
                                                              : issue_slots_0_grant
                                                                & _slots_0_io_uop_is_amo;	// issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_uses_ldq =
    issue_slots_15_grant
      ? _slots_15_io_uop_uses_ldq
      : issue_slots_14_grant
          ? _slots_14_io_uop_uses_ldq
          : issue_slots_13_grant
              ? _slots_13_io_uop_uses_ldq
              : issue_slots_12_grant
                  ? _slots_12_io_uop_uses_ldq
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_uses_ldq
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_uses_ldq
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_uses_ldq
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_uses_ldq
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_uses_ldq
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_uses_ldq
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_uses_ldq
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_uses_ldq
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_uses_ldq
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_uses_ldq
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_uses_ldq
                                                              : issue_slots_0_grant
                                                                & _slots_0_io_uop_uses_ldq;	// issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_uses_stq =
    issue_slots_15_grant
      ? _slots_15_io_uop_uses_stq
      : issue_slots_14_grant
          ? _slots_14_io_uop_uses_stq
          : issue_slots_13_grant
              ? _slots_13_io_uop_uses_stq
              : issue_slots_12_grant
                  ? _slots_12_io_uop_uses_stq
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_uses_stq
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_uses_stq
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_uses_stq
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_uses_stq
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_uses_stq
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_uses_stq
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_uses_stq
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_uses_stq
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_uses_stq
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_uses_stq
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_uses_stq
                                                              : issue_slots_0_grant
                                                                & _slots_0_io_uop_uses_stq;	// issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_is_sys_pc2epc =
    issue_slots_15_grant
      ? _slots_15_io_uop_is_sys_pc2epc
      : issue_slots_14_grant
          ? _slots_14_io_uop_is_sys_pc2epc
          : issue_slots_13_grant
              ? _slots_13_io_uop_is_sys_pc2epc
              : issue_slots_12_grant
                  ? _slots_12_io_uop_is_sys_pc2epc
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_is_sys_pc2epc
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_is_sys_pc2epc
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_is_sys_pc2epc
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_is_sys_pc2epc
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_is_sys_pc2epc
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_is_sys_pc2epc
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_is_sys_pc2epc
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_is_sys_pc2epc
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_is_sys_pc2epc
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_is_sys_pc2epc
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_is_sys_pc2epc
                                                              : issue_slots_0_grant
                                                                & _slots_0_io_uop_is_sys_pc2epc;	// issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_is_unique =
    issue_slots_15_grant
      ? _slots_15_io_uop_is_unique
      : issue_slots_14_grant
          ? _slots_14_io_uop_is_unique
          : issue_slots_13_grant
              ? _slots_13_io_uop_is_unique
              : issue_slots_12_grant
                  ? _slots_12_io_uop_is_unique
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_is_unique
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_is_unique
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_is_unique
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_is_unique
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_is_unique
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_is_unique
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_is_unique
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_is_unique
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_is_unique
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_is_unique
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_is_unique
                                                              : issue_slots_0_grant
                                                                & _slots_0_io_uop_is_unique;	// issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_flush_on_commit =
    issue_slots_15_grant
      ? _slots_15_io_uop_flush_on_commit
      : issue_slots_14_grant
          ? _slots_14_io_uop_flush_on_commit
          : issue_slots_13_grant
              ? _slots_13_io_uop_flush_on_commit
              : issue_slots_12_grant
                  ? _slots_12_io_uop_flush_on_commit
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_flush_on_commit
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_flush_on_commit
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_flush_on_commit
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_flush_on_commit
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_flush_on_commit
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_flush_on_commit
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_flush_on_commit
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_flush_on_commit
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_flush_on_commit
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_flush_on_commit
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_flush_on_commit
                                                              : issue_slots_0_grant
                                                                & _slots_0_io_uop_flush_on_commit;	// issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_ldst_is_rs1 =
    issue_slots_15_grant
      ? _slots_15_io_uop_ldst_is_rs1
      : issue_slots_14_grant
          ? _slots_14_io_uop_ldst_is_rs1
          : issue_slots_13_grant
              ? _slots_13_io_uop_ldst_is_rs1
              : issue_slots_12_grant
                  ? _slots_12_io_uop_ldst_is_rs1
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_ldst_is_rs1
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_ldst_is_rs1
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_ldst_is_rs1
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_ldst_is_rs1
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_ldst_is_rs1
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_ldst_is_rs1
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_ldst_is_rs1
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_ldst_is_rs1
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_ldst_is_rs1
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_ldst_is_rs1
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_ldst_is_rs1
                                                              : issue_slots_0_grant
                                                                & _slots_0_io_uop_ldst_is_rs1;	// issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_ldst =
    issue_slots_15_grant
      ? _slots_15_io_uop_ldst
      : issue_slots_14_grant
          ? _slots_14_io_uop_ldst
          : issue_slots_13_grant
              ? _slots_13_io_uop_ldst
              : issue_slots_12_grant
                  ? _slots_12_io_uop_ldst
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_ldst
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_ldst
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_ldst
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_ldst
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_ldst
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_ldst
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_ldst
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_ldst
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_ldst
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_ldst
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_ldst
                                                              : issue_slots_0_grant
                                                                  ? _slots_0_io_uop_ldst
                                                                  : 6'h0;	// consts.scala:270:20, issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_lrs1 =
    issue_slots_15_grant
      ? _slots_15_io_uop_lrs1
      : issue_slots_14_grant
          ? _slots_14_io_uop_lrs1
          : issue_slots_13_grant
              ? _slots_13_io_uop_lrs1
              : issue_slots_12_grant
                  ? _slots_12_io_uop_lrs1
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_lrs1
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_lrs1
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_lrs1
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_lrs1
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_lrs1
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_lrs1
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_lrs1
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_lrs1
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_lrs1
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_lrs1
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_lrs1
                                                              : issue_slots_0_grant
                                                                  ? _slots_0_io_uop_lrs1
                                                                  : 6'h0;	// consts.scala:270:20, issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_lrs2 =
    issue_slots_15_grant
      ? _slots_15_io_uop_lrs2
      : issue_slots_14_grant
          ? _slots_14_io_uop_lrs2
          : issue_slots_13_grant
              ? _slots_13_io_uop_lrs2
              : issue_slots_12_grant
                  ? _slots_12_io_uop_lrs2
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_lrs2
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_lrs2
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_lrs2
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_lrs2
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_lrs2
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_lrs2
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_lrs2
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_lrs2
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_lrs2
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_lrs2
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_lrs2
                                                              : issue_slots_0_grant
                                                                  ? _slots_0_io_uop_lrs2
                                                                  : 6'h0;	// consts.scala:270:20, issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_lrs3 =
    issue_slots_15_grant
      ? _slots_15_io_uop_lrs3
      : issue_slots_14_grant
          ? _slots_14_io_uop_lrs3
          : issue_slots_13_grant
              ? _slots_13_io_uop_lrs3
              : issue_slots_12_grant
                  ? _slots_12_io_uop_lrs3
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_lrs3
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_lrs3
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_lrs3
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_lrs3
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_lrs3
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_lrs3
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_lrs3
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_lrs3
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_lrs3
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_lrs3
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_lrs3
                                                              : issue_slots_0_grant
                                                                  ? _slots_0_io_uop_lrs3
                                                                  : 6'h0;	// consts.scala:270:20, issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_ldst_val =
    issue_slots_15_grant
      ? _slots_15_io_uop_ldst_val
      : issue_slots_14_grant
          ? _slots_14_io_uop_ldst_val
          : issue_slots_13_grant
              ? _slots_13_io_uop_ldst_val
              : issue_slots_12_grant
                  ? _slots_12_io_uop_ldst_val
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_ldst_val
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_ldst_val
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_ldst_val
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_ldst_val
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_ldst_val
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_ldst_val
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_ldst_val
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_ldst_val
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_ldst_val
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_ldst_val
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_ldst_val
                                                              : issue_slots_0_grant
                                                                & _slots_0_io_uop_ldst_val;	// issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_dst_rtype =
    issue_slots_15_grant
      ? _slots_15_io_uop_dst_rtype
      : issue_slots_14_grant
          ? _slots_14_io_uop_dst_rtype
          : issue_slots_13_grant
              ? _slots_13_io_uop_dst_rtype
              : issue_slots_12_grant
                  ? _slots_12_io_uop_dst_rtype
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_dst_rtype
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_dst_rtype
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_dst_rtype
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_dst_rtype
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_dst_rtype
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_dst_rtype
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_dst_rtype
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_dst_rtype
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_dst_rtype
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_dst_rtype
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_dst_rtype
                                                              : issue_slots_0_grant
                                                                  ? _slots_0_io_uop_dst_rtype
                                                                  : 2'h2;	// issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:139:32, :153:73
  assign io_iss_uops_0_lrs1_rtype =
    issue_slots_15_grant
      ? _slots_15_io_uop_lrs1_rtype
      : issue_slots_14_grant
          ? _slots_14_io_uop_lrs1_rtype
          : issue_slots_13_grant
              ? _slots_13_io_uop_lrs1_rtype
              : issue_slots_12_grant
                  ? _slots_12_io_uop_lrs1_rtype
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_lrs1_rtype
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_lrs1_rtype
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_lrs1_rtype
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_lrs1_rtype
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_lrs1_rtype
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_lrs1_rtype
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_lrs1_rtype
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_lrs1_rtype
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_lrs1_rtype
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_lrs1_rtype
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_lrs1_rtype
                                                              : issue_slots_0_grant
                                                                  ? _slots_0_io_uop_lrs1_rtype
                                                                  : 2'h2;	// issue-unit-age-ordered.scala:101:31, :118:{40,56,76}, :121:24, issue-unit.scala:139:32, :153:73
  assign io_iss_uops_0_lrs2_rtype =
    issue_slots_15_grant
      ? _slots_15_io_uop_lrs2_rtype
      : issue_slots_14_grant
          ? _slots_14_io_uop_lrs2_rtype
          : issue_slots_13_grant
              ? _slots_13_io_uop_lrs2_rtype
              : issue_slots_12_grant
                  ? _slots_12_io_uop_lrs2_rtype
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_lrs2_rtype
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_lrs2_rtype
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_lrs2_rtype
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_lrs2_rtype
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_lrs2_rtype
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_lrs2_rtype
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_lrs2_rtype
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_lrs2_rtype
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_lrs2_rtype
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_lrs2_rtype
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_lrs2_rtype
                                                              : issue_slots_0_grant
                                                                  ? _slots_0_io_uop_lrs2_rtype
                                                                  : 2'h2;	// issue-unit-age-ordered.scala:102:31, :118:{40,56,76}, :121:24, issue-unit.scala:139:32, :153:73
  assign io_iss_uops_0_frs3_en =
    issue_slots_15_grant
      ? _slots_15_io_uop_frs3_en
      : issue_slots_14_grant
          ? _slots_14_io_uop_frs3_en
          : issue_slots_13_grant
              ? _slots_13_io_uop_frs3_en
              : issue_slots_12_grant
                  ? _slots_12_io_uop_frs3_en
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_frs3_en
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_frs3_en
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_frs3_en
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_frs3_en
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_frs3_en
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_frs3_en
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_frs3_en
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_frs3_en
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_frs3_en
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_frs3_en
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_frs3_en
                                                              : issue_slots_0_grant
                                                                & _slots_0_io_uop_frs3_en;	// issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_fp_val =
    issue_slots_15_grant
      ? _slots_15_io_uop_fp_val
      : issue_slots_14_grant
          ? _slots_14_io_uop_fp_val
          : issue_slots_13_grant
              ? _slots_13_io_uop_fp_val
              : issue_slots_12_grant
                  ? _slots_12_io_uop_fp_val
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_fp_val
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_fp_val
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_fp_val
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_fp_val
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_fp_val
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_fp_val
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_fp_val
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_fp_val
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_fp_val
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_fp_val
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_fp_val
                                                              : issue_slots_0_grant
                                                                & _slots_0_io_uop_fp_val;	// issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_fp_single =
    issue_slots_15_grant
      ? _slots_15_io_uop_fp_single
      : issue_slots_14_grant
          ? _slots_14_io_uop_fp_single
          : issue_slots_13_grant
              ? _slots_13_io_uop_fp_single
              : issue_slots_12_grant
                  ? _slots_12_io_uop_fp_single
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_fp_single
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_fp_single
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_fp_single
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_fp_single
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_fp_single
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_fp_single
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_fp_single
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_fp_single
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_fp_single
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_fp_single
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_fp_single
                                                              : issue_slots_0_grant
                                                                & _slots_0_io_uop_fp_single;	// issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_xcpt_pf_if =
    issue_slots_15_grant
      ? _slots_15_io_uop_xcpt_pf_if
      : issue_slots_14_grant
          ? _slots_14_io_uop_xcpt_pf_if
          : issue_slots_13_grant
              ? _slots_13_io_uop_xcpt_pf_if
              : issue_slots_12_grant
                  ? _slots_12_io_uop_xcpt_pf_if
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_xcpt_pf_if
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_xcpt_pf_if
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_xcpt_pf_if
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_xcpt_pf_if
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_xcpt_pf_if
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_xcpt_pf_if
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_xcpt_pf_if
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_xcpt_pf_if
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_xcpt_pf_if
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_xcpt_pf_if
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_xcpt_pf_if
                                                              : issue_slots_0_grant
                                                                & _slots_0_io_uop_xcpt_pf_if;	// issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_xcpt_ae_if =
    issue_slots_15_grant
      ? _slots_15_io_uop_xcpt_ae_if
      : issue_slots_14_grant
          ? _slots_14_io_uop_xcpt_ae_if
          : issue_slots_13_grant
              ? _slots_13_io_uop_xcpt_ae_if
              : issue_slots_12_grant
                  ? _slots_12_io_uop_xcpt_ae_if
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_xcpt_ae_if
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_xcpt_ae_if
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_xcpt_ae_if
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_xcpt_ae_if
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_xcpt_ae_if
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_xcpt_ae_if
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_xcpt_ae_if
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_xcpt_ae_if
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_xcpt_ae_if
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_xcpt_ae_if
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_xcpt_ae_if
                                                              : issue_slots_0_grant
                                                                & _slots_0_io_uop_xcpt_ae_if;	// issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_xcpt_ma_if =
    issue_slots_15_grant
      ? _slots_15_io_uop_xcpt_ma_if
      : issue_slots_14_grant
          ? _slots_14_io_uop_xcpt_ma_if
          : issue_slots_13_grant
              ? _slots_13_io_uop_xcpt_ma_if
              : issue_slots_12_grant
                  ? _slots_12_io_uop_xcpt_ma_if
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_xcpt_ma_if
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_xcpt_ma_if
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_xcpt_ma_if
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_xcpt_ma_if
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_xcpt_ma_if
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_xcpt_ma_if
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_xcpt_ma_if
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_xcpt_ma_if
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_xcpt_ma_if
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_xcpt_ma_if
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_xcpt_ma_if
                                                              : issue_slots_0_grant
                                                                & _slots_0_io_uop_xcpt_ma_if;	// issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_bp_debug_if =
    issue_slots_15_grant
      ? _slots_15_io_uop_bp_debug_if
      : issue_slots_14_grant
          ? _slots_14_io_uop_bp_debug_if
          : issue_slots_13_grant
              ? _slots_13_io_uop_bp_debug_if
              : issue_slots_12_grant
                  ? _slots_12_io_uop_bp_debug_if
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_bp_debug_if
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_bp_debug_if
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_bp_debug_if
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_bp_debug_if
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_bp_debug_if
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_bp_debug_if
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_bp_debug_if
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_bp_debug_if
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_bp_debug_if
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_bp_debug_if
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_bp_debug_if
                                                              : issue_slots_0_grant
                                                                & _slots_0_io_uop_bp_debug_if;	// issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_bp_xcpt_if =
    issue_slots_15_grant
      ? _slots_15_io_uop_bp_xcpt_if
      : issue_slots_14_grant
          ? _slots_14_io_uop_bp_xcpt_if
          : issue_slots_13_grant
              ? _slots_13_io_uop_bp_xcpt_if
              : issue_slots_12_grant
                  ? _slots_12_io_uop_bp_xcpt_if
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_bp_xcpt_if
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_bp_xcpt_if
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_bp_xcpt_if
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_bp_xcpt_if
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_bp_xcpt_if
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_bp_xcpt_if
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_bp_xcpt_if
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_bp_xcpt_if
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_bp_xcpt_if
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_bp_xcpt_if
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_bp_xcpt_if
                                                              : issue_slots_0_grant
                                                                & _slots_0_io_uop_bp_xcpt_if;	// issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_debug_fsrc =
    issue_slots_15_grant
      ? _slots_15_io_uop_debug_fsrc
      : issue_slots_14_grant
          ? _slots_14_io_uop_debug_fsrc
          : issue_slots_13_grant
              ? _slots_13_io_uop_debug_fsrc
              : issue_slots_12_grant
                  ? _slots_12_io_uop_debug_fsrc
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_debug_fsrc
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_debug_fsrc
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_debug_fsrc
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_debug_fsrc
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_debug_fsrc
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_debug_fsrc
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_debug_fsrc
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_debug_fsrc
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_debug_fsrc
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_debug_fsrc
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_debug_fsrc
                                                              : issue_slots_0_grant
                                                                  ? _slots_0_io_uop_debug_fsrc
                                                                  : 2'h0;	// consts.scala:270:20, issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
  assign io_iss_uops_0_debug_tsrc =
    issue_slots_15_grant
      ? _slots_15_io_uop_debug_tsrc
      : issue_slots_14_grant
          ? _slots_14_io_uop_debug_tsrc
          : issue_slots_13_grant
              ? _slots_13_io_uop_debug_tsrc
              : issue_slots_12_grant
                  ? _slots_12_io_uop_debug_tsrc
                  : issue_slots_11_grant
                      ? _slots_11_io_uop_debug_tsrc
                      : issue_slots_10_grant
                          ? _slots_10_io_uop_debug_tsrc
                          : issue_slots_9_grant
                              ? _slots_9_io_uop_debug_tsrc
                              : issue_slots_8_grant
                                  ? _slots_8_io_uop_debug_tsrc
                                  : issue_slots_7_grant
                                      ? _slots_7_io_uop_debug_tsrc
                                      : issue_slots_6_grant
                                          ? _slots_6_io_uop_debug_tsrc
                                          : issue_slots_5_grant
                                              ? _slots_5_io_uop_debug_tsrc
                                              : issue_slots_4_grant
                                                  ? _slots_4_io_uop_debug_tsrc
                                                  : issue_slots_3_grant
                                                      ? _slots_3_io_uop_debug_tsrc
                                                      : issue_slots_2_grant
                                                          ? _slots_2_io_uop_debug_tsrc
                                                          : issue_slots_1_grant
                                                              ? _slots_1_io_uop_debug_tsrc
                                                              : issue_slots_0_grant
                                                                  ? _slots_0_io_uop_debug_tsrc
                                                                  : 2'h0;	// consts.scala:270:20, issue-unit-age-ordered.scala:96:22, :118:{40,56,76}, :121:24, issue-unit.scala:153:73
endmodule

