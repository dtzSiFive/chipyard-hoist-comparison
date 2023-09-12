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

module ALUExeUnit_6(
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
  input  [15:0] io_req_bits_uop_br_mask,
  input  [3:0]  io_req_bits_uop_br_tag,
  input  [4:0]  io_req_bits_uop_ftq_idx,
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
  input  [15:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  input         io_lsu_io_iresp_valid,
  input  [6:0]  io_lsu_io_iresp_bits_uop_rob_idx,
                io_lsu_io_iresp_bits_uop_pdst,
  input         io_lsu_io_iresp_bits_uop_is_amo,
                io_lsu_io_iresp_bits_uop_uses_stq,
  input  [1:0]  io_lsu_io_iresp_bits_uop_dst_rtype,
  input  [63:0] io_lsu_io_iresp_bits_data,
  input         io_lsu_io_fresp_valid,
  input  [6:0]  io_lsu_io_fresp_bits_uop_uopc,
  input  [15:0] io_lsu_io_fresp_bits_uop_br_mask,
  input  [6:0]  io_lsu_io_fresp_bits_uop_rob_idx,
  input  [4:0]  io_lsu_io_fresp_bits_uop_stq_idx,
  input  [6:0]  io_lsu_io_fresp_bits_uop_pdst,
  input  [1:0]  io_lsu_io_fresp_bits_uop_mem_size,
  input         io_lsu_io_fresp_bits_uop_is_amo,
                io_lsu_io_fresp_bits_uop_uses_stq,
  input  [1:0]  io_lsu_io_fresp_bits_uop_dst_rtype,
  input         io_lsu_io_fresp_bits_uop_fp_val,
  input  [64:0] io_lsu_io_fresp_bits_data,
  output        io_ll_iresp_valid,
  output [6:0]  io_ll_iresp_bits_uop_rob_idx,
                io_ll_iresp_bits_uop_pdst,
  output        io_ll_iresp_bits_uop_is_amo,
                io_ll_iresp_bits_uop_uses_stq,
  output [1:0]  io_ll_iresp_bits_uop_dst_rtype,
  output [64:0] io_ll_iresp_bits_data,
  output        io_ll_fresp_valid,
  output [6:0]  io_ll_fresp_bits_uop_uopc,
  output [15:0] io_ll_fresp_bits_uop_br_mask,
  output [6:0]  io_ll_fresp_bits_uop_rob_idx,
  output [4:0]  io_ll_fresp_bits_uop_stq_idx,
  output [6:0]  io_ll_fresp_bits_uop_pdst,
  output [1:0]  io_ll_fresp_bits_uop_mem_size,
  output        io_ll_fresp_bits_uop_is_amo,
                io_ll_fresp_bits_uop_uses_stq,
  output [1:0]  io_ll_fresp_bits_uop_dst_rtype,
  output        io_ll_fresp_bits_uop_fp_val,
  output [64:0] io_ll_fresp_bits_data,
  output        io_lsu_io_req_valid,
  output [6:0]  io_lsu_io_req_bits_uop_uopc,
  output [31:0] io_lsu_io_req_bits_uop_inst,
                io_lsu_io_req_bits_uop_debug_inst,
  output        io_lsu_io_req_bits_uop_is_rvc,
  output [39:0] io_lsu_io_req_bits_uop_debug_pc,
  output [2:0]  io_lsu_io_req_bits_uop_iq_type,
  output [9:0]  io_lsu_io_req_bits_uop_fu_code,
  output [3:0]  io_lsu_io_req_bits_uop_ctrl_br_type,
  output [1:0]  io_lsu_io_req_bits_uop_ctrl_op1_sel,
  output [2:0]  io_lsu_io_req_bits_uop_ctrl_op2_sel,
                io_lsu_io_req_bits_uop_ctrl_imm_sel,
  output [3:0]  io_lsu_io_req_bits_uop_ctrl_op_fcn,
  output        io_lsu_io_req_bits_uop_ctrl_fcn_dw,
  output [2:0]  io_lsu_io_req_bits_uop_ctrl_csr_cmd,
  output        io_lsu_io_req_bits_uop_ctrl_is_load,
                io_lsu_io_req_bits_uop_ctrl_is_sta,
                io_lsu_io_req_bits_uop_ctrl_is_std,
  output [1:0]  io_lsu_io_req_bits_uop_iw_state,
  output        io_lsu_io_req_bits_uop_iw_p1_poisoned,
                io_lsu_io_req_bits_uop_iw_p2_poisoned,
                io_lsu_io_req_bits_uop_is_br,
                io_lsu_io_req_bits_uop_is_jalr,
                io_lsu_io_req_bits_uop_is_jal,
                io_lsu_io_req_bits_uop_is_sfb,
  output [15:0] io_lsu_io_req_bits_uop_br_mask,
  output [3:0]  io_lsu_io_req_bits_uop_br_tag,
  output [4:0]  io_lsu_io_req_bits_uop_ftq_idx,
  output        io_lsu_io_req_bits_uop_edge_inst,
  output [5:0]  io_lsu_io_req_bits_uop_pc_lob,
  output        io_lsu_io_req_bits_uop_taken,
  output [19:0] io_lsu_io_req_bits_uop_imm_packed,
  output [11:0] io_lsu_io_req_bits_uop_csr_addr,
  output [6:0]  io_lsu_io_req_bits_uop_rob_idx,
  output [4:0]  io_lsu_io_req_bits_uop_ldq_idx,
                io_lsu_io_req_bits_uop_stq_idx,
  output [1:0]  io_lsu_io_req_bits_uop_rxq_idx,
  output [6:0]  io_lsu_io_req_bits_uop_pdst,
                io_lsu_io_req_bits_uop_prs1,
                io_lsu_io_req_bits_uop_prs2,
                io_lsu_io_req_bits_uop_prs3,
  output [4:0]  io_lsu_io_req_bits_uop_ppred,
  output        io_lsu_io_req_bits_uop_prs1_busy,
                io_lsu_io_req_bits_uop_prs2_busy,
                io_lsu_io_req_bits_uop_prs3_busy,
                io_lsu_io_req_bits_uop_ppred_busy,
  output [6:0]  io_lsu_io_req_bits_uop_stale_pdst,
  output        io_lsu_io_req_bits_uop_exception,
  output [63:0] io_lsu_io_req_bits_uop_exc_cause,
  output        io_lsu_io_req_bits_uop_bypassable,
  output [4:0]  io_lsu_io_req_bits_uop_mem_cmd,
  output [1:0]  io_lsu_io_req_bits_uop_mem_size,
  output        io_lsu_io_req_bits_uop_mem_signed,
                io_lsu_io_req_bits_uop_is_fence,
                io_lsu_io_req_bits_uop_is_fencei,
                io_lsu_io_req_bits_uop_is_amo,
                io_lsu_io_req_bits_uop_uses_ldq,
                io_lsu_io_req_bits_uop_uses_stq,
                io_lsu_io_req_bits_uop_is_sys_pc2epc,
                io_lsu_io_req_bits_uop_is_unique,
                io_lsu_io_req_bits_uop_flush_on_commit,
                io_lsu_io_req_bits_uop_ldst_is_rs1,
  output [5:0]  io_lsu_io_req_bits_uop_ldst,
                io_lsu_io_req_bits_uop_lrs1,
                io_lsu_io_req_bits_uop_lrs2,
                io_lsu_io_req_bits_uop_lrs3,
  output        io_lsu_io_req_bits_uop_ldst_val,
  output [1:0]  io_lsu_io_req_bits_uop_dst_rtype,
                io_lsu_io_req_bits_uop_lrs1_rtype,
                io_lsu_io_req_bits_uop_lrs2_rtype,
  output        io_lsu_io_req_bits_uop_frs3_en,
                io_lsu_io_req_bits_uop_fp_val,
                io_lsu_io_req_bits_uop_fp_single,
                io_lsu_io_req_bits_uop_xcpt_pf_if,
                io_lsu_io_req_bits_uop_xcpt_ae_if,
                io_lsu_io_req_bits_uop_xcpt_ma_if,
                io_lsu_io_req_bits_uop_bp_debug_if,
                io_lsu_io_req_bits_uop_bp_xcpt_if,
  output [1:0]  io_lsu_io_req_bits_uop_debug_fsrc,
                io_lsu_io_req_bits_uop_debug_tsrc,
  output [63:0] io_lsu_io_req_bits_data,
  output [39:0] io_lsu_io_req_bits_addr,
  output        io_lsu_io_req_bits_mxcpt_valid,
                io_lsu_io_req_bits_sfence_valid,
                io_lsu_io_req_bits_sfence_bits_rs1,
                io_lsu_io_req_bits_sfence_bits_rs2,
  output [38:0] io_lsu_io_req_bits_sfence_bits_addr
);

  wire [64:0] _maddrcalc_io_resp_bits_data;	// execution-unit.scala:379:27
  MemAddrCalcUnit_2 maddrcalc (	// execution-unit.scala:379:27
    .clock                            (clock),
    .reset                            (reset),
    .io_req_valid                     (io_req_valid & io_req_bits_uop_fu_code[2]),	// execution-unit.scala:381:45, micro-op.scala:154:40
    .io_req_bits_uop_uopc             (io_req_bits_uop_uopc),
    .io_req_bits_uop_inst             (io_req_bits_uop_inst),
    .io_req_bits_uop_debug_inst       (io_req_bits_uop_debug_inst),
    .io_req_bits_uop_is_rvc           (io_req_bits_uop_is_rvc),
    .io_req_bits_uop_debug_pc         (io_req_bits_uop_debug_pc),
    .io_req_bits_uop_iq_type          (io_req_bits_uop_iq_type),
    .io_req_bits_uop_fu_code          (io_req_bits_uop_fu_code),
    .io_req_bits_uop_ctrl_br_type     (io_req_bits_uop_ctrl_br_type),
    .io_req_bits_uop_ctrl_op1_sel     (io_req_bits_uop_ctrl_op1_sel),
    .io_req_bits_uop_ctrl_op2_sel     (io_req_bits_uop_ctrl_op2_sel),
    .io_req_bits_uop_ctrl_imm_sel     (io_req_bits_uop_ctrl_imm_sel),
    .io_req_bits_uop_ctrl_op_fcn      (io_req_bits_uop_ctrl_op_fcn),
    .io_req_bits_uop_ctrl_fcn_dw      (io_req_bits_uop_ctrl_fcn_dw),
    .io_req_bits_uop_ctrl_csr_cmd     (io_req_bits_uop_ctrl_csr_cmd),
    .io_req_bits_uop_ctrl_is_load     (io_req_bits_uop_ctrl_is_load),
    .io_req_bits_uop_ctrl_is_sta      (io_req_bits_uop_ctrl_is_sta),
    .io_req_bits_uop_ctrl_is_std      (io_req_bits_uop_ctrl_is_std),
    .io_req_bits_uop_iw_state         (io_req_bits_uop_iw_state),
    .io_req_bits_uop_iw_p1_poisoned   (io_req_bits_uop_iw_p1_poisoned),
    .io_req_bits_uop_iw_p2_poisoned   (io_req_bits_uop_iw_p2_poisoned),
    .io_req_bits_uop_is_br            (io_req_bits_uop_is_br),
    .io_req_bits_uop_is_jalr          (io_req_bits_uop_is_jalr),
    .io_req_bits_uop_is_jal           (io_req_bits_uop_is_jal),
    .io_req_bits_uop_is_sfb           (io_req_bits_uop_is_sfb),
    .io_req_bits_uop_br_mask          (io_req_bits_uop_br_mask),
    .io_req_bits_uop_br_tag           (io_req_bits_uop_br_tag),
    .io_req_bits_uop_ftq_idx          (io_req_bits_uop_ftq_idx),
    .io_req_bits_uop_edge_inst        (io_req_bits_uop_edge_inst),
    .io_req_bits_uop_pc_lob           (io_req_bits_uop_pc_lob),
    .io_req_bits_uop_taken            (io_req_bits_uop_taken),
    .io_req_bits_uop_imm_packed       (io_req_bits_uop_imm_packed),
    .io_req_bits_uop_csr_addr         (io_req_bits_uop_csr_addr),
    .io_req_bits_uop_rob_idx          (io_req_bits_uop_rob_idx),
    .io_req_bits_uop_ldq_idx          (io_req_bits_uop_ldq_idx),
    .io_req_bits_uop_stq_idx          (io_req_bits_uop_stq_idx),
    .io_req_bits_uop_rxq_idx          (io_req_bits_uop_rxq_idx),
    .io_req_bits_uop_pdst             (io_req_bits_uop_pdst),
    .io_req_bits_uop_prs1             (io_req_bits_uop_prs1),
    .io_req_bits_uop_prs2             (io_req_bits_uop_prs2),
    .io_req_bits_uop_prs3             (io_req_bits_uop_prs3),
    .io_req_bits_uop_ppred            (io_req_bits_uop_ppred),
    .io_req_bits_uop_prs1_busy        (io_req_bits_uop_prs1_busy),
    .io_req_bits_uop_prs2_busy        (io_req_bits_uop_prs2_busy),
    .io_req_bits_uop_prs3_busy        (io_req_bits_uop_prs3_busy),
    .io_req_bits_uop_ppred_busy       (io_req_bits_uop_ppred_busy),
    .io_req_bits_uop_stale_pdst       (io_req_bits_uop_stale_pdst),
    .io_req_bits_uop_exception        (io_req_bits_uop_exception),
    .io_req_bits_uop_exc_cause        (io_req_bits_uop_exc_cause),
    .io_req_bits_uop_bypassable       (io_req_bits_uop_bypassable),
    .io_req_bits_uop_mem_cmd          (io_req_bits_uop_mem_cmd),
    .io_req_bits_uop_mem_size         (io_req_bits_uop_mem_size),
    .io_req_bits_uop_mem_signed       (io_req_bits_uop_mem_signed),
    .io_req_bits_uop_is_fence         (io_req_bits_uop_is_fence),
    .io_req_bits_uop_is_fencei        (io_req_bits_uop_is_fencei),
    .io_req_bits_uop_is_amo           (io_req_bits_uop_is_amo),
    .io_req_bits_uop_uses_ldq         (io_req_bits_uop_uses_ldq),
    .io_req_bits_uop_uses_stq         (io_req_bits_uop_uses_stq),
    .io_req_bits_uop_is_sys_pc2epc    (io_req_bits_uop_is_sys_pc2epc),
    .io_req_bits_uop_is_unique        (io_req_bits_uop_is_unique),
    .io_req_bits_uop_flush_on_commit  (io_req_bits_uop_flush_on_commit),
    .io_req_bits_uop_ldst_is_rs1      (io_req_bits_uop_ldst_is_rs1),
    .io_req_bits_uop_ldst             (io_req_bits_uop_ldst),
    .io_req_bits_uop_lrs1             (io_req_bits_uop_lrs1),
    .io_req_bits_uop_lrs2             (io_req_bits_uop_lrs2),
    .io_req_bits_uop_lrs3             (io_req_bits_uop_lrs3),
    .io_req_bits_uop_ldst_val         (io_req_bits_uop_ldst_val),
    .io_req_bits_uop_dst_rtype        (io_req_bits_uop_dst_rtype),
    .io_req_bits_uop_lrs1_rtype       (io_req_bits_uop_lrs1_rtype),
    .io_req_bits_uop_lrs2_rtype       (io_req_bits_uop_lrs2_rtype),
    .io_req_bits_uop_frs3_en          (io_req_bits_uop_frs3_en),
    .io_req_bits_uop_fp_val           (io_req_bits_uop_fp_val),
    .io_req_bits_uop_fp_single        (io_req_bits_uop_fp_single),
    .io_req_bits_uop_xcpt_pf_if       (io_req_bits_uop_xcpt_pf_if),
    .io_req_bits_uop_xcpt_ae_if       (io_req_bits_uop_xcpt_ae_if),
    .io_req_bits_uop_xcpt_ma_if       (io_req_bits_uop_xcpt_ma_if),
    .io_req_bits_uop_bp_debug_if      (io_req_bits_uop_bp_debug_if),
    .io_req_bits_uop_bp_xcpt_if       (io_req_bits_uop_bp_xcpt_if),
    .io_req_bits_uop_debug_fsrc       (io_req_bits_uop_debug_fsrc),
    .io_req_bits_uop_debug_tsrc       (io_req_bits_uop_debug_tsrc),
    .io_req_bits_rs1_data             (io_req_bits_rs1_data),
    .io_req_bits_rs2_data             (io_req_bits_rs2_data),
    .io_brupdate_b1_resolve_mask      (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask   (io_brupdate_b1_mispredict_mask),
    .io_resp_valid                    (io_lsu_io_req_valid),
    .io_resp_bits_uop_uopc            (io_lsu_io_req_bits_uop_uopc),
    .io_resp_bits_uop_inst            (io_lsu_io_req_bits_uop_inst),
    .io_resp_bits_uop_debug_inst      (io_lsu_io_req_bits_uop_debug_inst),
    .io_resp_bits_uop_is_rvc          (io_lsu_io_req_bits_uop_is_rvc),
    .io_resp_bits_uop_debug_pc        (io_lsu_io_req_bits_uop_debug_pc),
    .io_resp_bits_uop_iq_type         (io_lsu_io_req_bits_uop_iq_type),
    .io_resp_bits_uop_fu_code         (io_lsu_io_req_bits_uop_fu_code),
    .io_resp_bits_uop_ctrl_br_type    (io_lsu_io_req_bits_uop_ctrl_br_type),
    .io_resp_bits_uop_ctrl_op1_sel    (io_lsu_io_req_bits_uop_ctrl_op1_sel),
    .io_resp_bits_uop_ctrl_op2_sel    (io_lsu_io_req_bits_uop_ctrl_op2_sel),
    .io_resp_bits_uop_ctrl_imm_sel    (io_lsu_io_req_bits_uop_ctrl_imm_sel),
    .io_resp_bits_uop_ctrl_op_fcn     (io_lsu_io_req_bits_uop_ctrl_op_fcn),
    .io_resp_bits_uop_ctrl_fcn_dw     (io_lsu_io_req_bits_uop_ctrl_fcn_dw),
    .io_resp_bits_uop_ctrl_csr_cmd    (io_lsu_io_req_bits_uop_ctrl_csr_cmd),
    .io_resp_bits_uop_ctrl_is_load    (io_lsu_io_req_bits_uop_ctrl_is_load),
    .io_resp_bits_uop_ctrl_is_sta     (io_lsu_io_req_bits_uop_ctrl_is_sta),
    .io_resp_bits_uop_ctrl_is_std     (io_lsu_io_req_bits_uop_ctrl_is_std),
    .io_resp_bits_uop_iw_state        (io_lsu_io_req_bits_uop_iw_state),
    .io_resp_bits_uop_iw_p1_poisoned  (io_lsu_io_req_bits_uop_iw_p1_poisoned),
    .io_resp_bits_uop_iw_p2_poisoned  (io_lsu_io_req_bits_uop_iw_p2_poisoned),
    .io_resp_bits_uop_is_br           (io_lsu_io_req_bits_uop_is_br),
    .io_resp_bits_uop_is_jalr         (io_lsu_io_req_bits_uop_is_jalr),
    .io_resp_bits_uop_is_jal          (io_lsu_io_req_bits_uop_is_jal),
    .io_resp_bits_uop_is_sfb          (io_lsu_io_req_bits_uop_is_sfb),
    .io_resp_bits_uop_br_mask         (io_lsu_io_req_bits_uop_br_mask),
    .io_resp_bits_uop_br_tag          (io_lsu_io_req_bits_uop_br_tag),
    .io_resp_bits_uop_ftq_idx         (io_lsu_io_req_bits_uop_ftq_idx),
    .io_resp_bits_uop_edge_inst       (io_lsu_io_req_bits_uop_edge_inst),
    .io_resp_bits_uop_pc_lob          (io_lsu_io_req_bits_uop_pc_lob),
    .io_resp_bits_uop_taken           (io_lsu_io_req_bits_uop_taken),
    .io_resp_bits_uop_imm_packed      (io_lsu_io_req_bits_uop_imm_packed),
    .io_resp_bits_uop_csr_addr        (io_lsu_io_req_bits_uop_csr_addr),
    .io_resp_bits_uop_rob_idx         (io_lsu_io_req_bits_uop_rob_idx),
    .io_resp_bits_uop_ldq_idx         (io_lsu_io_req_bits_uop_ldq_idx),
    .io_resp_bits_uop_stq_idx         (io_lsu_io_req_bits_uop_stq_idx),
    .io_resp_bits_uop_rxq_idx         (io_lsu_io_req_bits_uop_rxq_idx),
    .io_resp_bits_uop_pdst            (io_lsu_io_req_bits_uop_pdst),
    .io_resp_bits_uop_prs1            (io_lsu_io_req_bits_uop_prs1),
    .io_resp_bits_uop_prs2            (io_lsu_io_req_bits_uop_prs2),
    .io_resp_bits_uop_prs3            (io_lsu_io_req_bits_uop_prs3),
    .io_resp_bits_uop_ppred           (io_lsu_io_req_bits_uop_ppred),
    .io_resp_bits_uop_prs1_busy       (io_lsu_io_req_bits_uop_prs1_busy),
    .io_resp_bits_uop_prs2_busy       (io_lsu_io_req_bits_uop_prs2_busy),
    .io_resp_bits_uop_prs3_busy       (io_lsu_io_req_bits_uop_prs3_busy),
    .io_resp_bits_uop_ppred_busy      (io_lsu_io_req_bits_uop_ppred_busy),
    .io_resp_bits_uop_stale_pdst      (io_lsu_io_req_bits_uop_stale_pdst),
    .io_resp_bits_uop_exception       (io_lsu_io_req_bits_uop_exception),
    .io_resp_bits_uop_exc_cause       (io_lsu_io_req_bits_uop_exc_cause),
    .io_resp_bits_uop_bypassable      (io_lsu_io_req_bits_uop_bypassable),
    .io_resp_bits_uop_mem_cmd         (io_lsu_io_req_bits_uop_mem_cmd),
    .io_resp_bits_uop_mem_size        (io_lsu_io_req_bits_uop_mem_size),
    .io_resp_bits_uop_mem_signed      (io_lsu_io_req_bits_uop_mem_signed),
    .io_resp_bits_uop_is_fence        (io_lsu_io_req_bits_uop_is_fence),
    .io_resp_bits_uop_is_fencei       (io_lsu_io_req_bits_uop_is_fencei),
    .io_resp_bits_uop_is_amo          (io_lsu_io_req_bits_uop_is_amo),
    .io_resp_bits_uop_uses_ldq        (io_lsu_io_req_bits_uop_uses_ldq),
    .io_resp_bits_uop_uses_stq        (io_lsu_io_req_bits_uop_uses_stq),
    .io_resp_bits_uop_is_sys_pc2epc   (io_lsu_io_req_bits_uop_is_sys_pc2epc),
    .io_resp_bits_uop_is_unique       (io_lsu_io_req_bits_uop_is_unique),
    .io_resp_bits_uop_flush_on_commit (io_lsu_io_req_bits_uop_flush_on_commit),
    .io_resp_bits_uop_ldst_is_rs1     (io_lsu_io_req_bits_uop_ldst_is_rs1),
    .io_resp_bits_uop_ldst            (io_lsu_io_req_bits_uop_ldst),
    .io_resp_bits_uop_lrs1            (io_lsu_io_req_bits_uop_lrs1),
    .io_resp_bits_uop_lrs2            (io_lsu_io_req_bits_uop_lrs2),
    .io_resp_bits_uop_lrs3            (io_lsu_io_req_bits_uop_lrs3),
    .io_resp_bits_uop_ldst_val        (io_lsu_io_req_bits_uop_ldst_val),
    .io_resp_bits_uop_dst_rtype       (io_lsu_io_req_bits_uop_dst_rtype),
    .io_resp_bits_uop_lrs1_rtype      (io_lsu_io_req_bits_uop_lrs1_rtype),
    .io_resp_bits_uop_lrs2_rtype      (io_lsu_io_req_bits_uop_lrs2_rtype),
    .io_resp_bits_uop_frs3_en         (io_lsu_io_req_bits_uop_frs3_en),
    .io_resp_bits_uop_fp_val          (io_lsu_io_req_bits_uop_fp_val),
    .io_resp_bits_uop_fp_single       (io_lsu_io_req_bits_uop_fp_single),
    .io_resp_bits_uop_xcpt_pf_if      (io_lsu_io_req_bits_uop_xcpt_pf_if),
    .io_resp_bits_uop_xcpt_ae_if      (io_lsu_io_req_bits_uop_xcpt_ae_if),
    .io_resp_bits_uop_xcpt_ma_if      (io_lsu_io_req_bits_uop_xcpt_ma_if),
    .io_resp_bits_uop_bp_debug_if     (io_lsu_io_req_bits_uop_bp_debug_if),
    .io_resp_bits_uop_bp_xcpt_if      (io_lsu_io_req_bits_uop_bp_xcpt_if),
    .io_resp_bits_uop_debug_fsrc      (io_lsu_io_req_bits_uop_debug_fsrc),
    .io_resp_bits_uop_debug_tsrc      (io_lsu_io_req_bits_uop_debug_tsrc),
    .io_resp_bits_data                (_maddrcalc_io_resp_bits_data),
    .io_resp_bits_addr                (io_lsu_io_req_bits_addr),
    .io_resp_bits_mxcpt_valid         (io_lsu_io_req_bits_mxcpt_valid),
    .io_resp_bits_sfence_valid        (io_lsu_io_req_bits_sfence_valid),
    .io_resp_bits_sfence_bits_rs1     (io_lsu_io_req_bits_sfence_bits_rs1),
    .io_resp_bits_sfence_bits_rs2     (io_lsu_io_req_bits_sfence_bits_rs2),
    .io_resp_bits_sfence_bits_addr    (io_lsu_io_req_bits_sfence_bits_addr)
  );
  assign io_ll_iresp_valid = io_lsu_io_iresp_valid;
  assign io_ll_iresp_bits_uop_rob_idx = io_lsu_io_iresp_bits_uop_rob_idx;
  assign io_ll_iresp_bits_uop_pdst = io_lsu_io_iresp_bits_uop_pdst;
  assign io_ll_iresp_bits_uop_is_amo = io_lsu_io_iresp_bits_uop_is_amo;
  assign io_ll_iresp_bits_uop_uses_stq = io_lsu_io_iresp_bits_uop_uses_stq;
  assign io_ll_iresp_bits_uop_dst_rtype = io_lsu_io_iresp_bits_uop_dst_rtype;
  assign io_ll_iresp_bits_data = {1'h0, io_lsu_io_iresp_bits_data};	// execution-unit.scala:392:17
  assign io_ll_fresp_valid = io_lsu_io_fresp_valid;
  assign io_ll_fresp_bits_uop_uopc = io_lsu_io_fresp_bits_uop_uopc;
  assign io_ll_fresp_bits_uop_br_mask = io_lsu_io_fresp_bits_uop_br_mask;
  assign io_ll_fresp_bits_uop_rob_idx = io_lsu_io_fresp_bits_uop_rob_idx;
  assign io_ll_fresp_bits_uop_stq_idx = io_lsu_io_fresp_bits_uop_stq_idx;
  assign io_ll_fresp_bits_uop_pdst = io_lsu_io_fresp_bits_uop_pdst;
  assign io_ll_fresp_bits_uop_mem_size = io_lsu_io_fresp_bits_uop_mem_size;
  assign io_ll_fresp_bits_uop_is_amo = io_lsu_io_fresp_bits_uop_is_amo;
  assign io_ll_fresp_bits_uop_uses_stq = io_lsu_io_fresp_bits_uop_uses_stq;
  assign io_ll_fresp_bits_uop_dst_rtype = io_lsu_io_fresp_bits_uop_dst_rtype;
  assign io_ll_fresp_bits_uop_fp_val = io_lsu_io_fresp_bits_uop_fp_val;
  assign io_ll_fresp_bits_data = io_lsu_io_fresp_bits_data;
  assign io_lsu_io_req_bits_data = _maddrcalc_io_resp_bits_data[63:0];	// execution-unit.scala:379:27, :390:19
endmodule

