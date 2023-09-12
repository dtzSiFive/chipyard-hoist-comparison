// Generated by CIRCT firtool-1.54.0-29-gc3332a678
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

module FPUExeUnit_1(
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
  output        io_fresp_valid,
  output [6:0]  io_fresp_bits_uop_rob_idx,
                io_fresp_bits_uop_pdst,
  output        io_fresp_bits_uop_is_amo,
                io_fresp_bits_uop_uses_ldq,
                io_fresp_bits_uop_uses_stq,
  output [1:0]  io_fresp_bits_uop_dst_rtype,
  output        io_fresp_bits_uop_fp_val,
  output [64:0] io_fresp_bits_data,
  output        io_fresp_bits_fflags_valid,
  output [6:0]  io_fresp_bits_fflags_bits_uop_rob_idx,
  output [4:0]  io_fresp_bits_fflags_bits_flags
);

  wire       _fpu_io_resp_valid;	// execution-unit.scala:468:17
  wire [9:0] _fpu_io_resp_bits_uop_fu_code;	// execution-unit.scala:468:17
  wire       _fpu_io_resp_bits_fflags_valid;	// execution-unit.scala:468:17
  wire [6:0] _fpu_io_resp_bits_fflags_bits_uop_rob_idx;	// execution-unit.scala:468:17
  wire [4:0] _fpu_io_resp_bits_fflags_bits_flags;	// execution-unit.scala:468:17
  FPUUnit fpu (	// execution-unit.scala:468:17
    .clock                                        (clock),
    .reset                                        (reset),
    .io_req_valid
      (io_req_valid & (io_req_bits_uop_fu_code[6] | io_req_bits_uop_fu_code[9])),	// execution-unit.scala:469:46, :470:69, micro-op.scala:154:40
    .io_req_bits_uop_uopc                         (io_req_bits_uop_uopc),
    .io_req_bits_uop_inst                         (io_req_bits_uop_inst),
    .io_req_bits_uop_debug_inst                   (io_req_bits_uop_debug_inst),
    .io_req_bits_uop_is_rvc                       (io_req_bits_uop_is_rvc),
    .io_req_bits_uop_debug_pc                     (io_req_bits_uop_debug_pc),
    .io_req_bits_uop_iq_type                      (io_req_bits_uop_iq_type),
    .io_req_bits_uop_fu_code                      (io_req_bits_uop_fu_code),
    .io_req_bits_uop_ctrl_br_type                 (io_req_bits_uop_ctrl_br_type),
    .io_req_bits_uop_ctrl_op1_sel                 (io_req_bits_uop_ctrl_op1_sel),
    .io_req_bits_uop_ctrl_op2_sel                 (io_req_bits_uop_ctrl_op2_sel),
    .io_req_bits_uop_ctrl_imm_sel                 (io_req_bits_uop_ctrl_imm_sel),
    .io_req_bits_uop_ctrl_op_fcn                  (io_req_bits_uop_ctrl_op_fcn),
    .io_req_bits_uop_ctrl_fcn_dw                  (io_req_bits_uop_ctrl_fcn_dw),
    .io_req_bits_uop_ctrl_csr_cmd                 (io_req_bits_uop_ctrl_csr_cmd),
    .io_req_bits_uop_ctrl_is_load                 (io_req_bits_uop_ctrl_is_load),
    .io_req_bits_uop_ctrl_is_sta                  (io_req_bits_uop_ctrl_is_sta),
    .io_req_bits_uop_ctrl_is_std                  (io_req_bits_uop_ctrl_is_std),
    .io_req_bits_uop_iw_state                     (io_req_bits_uop_iw_state),
    .io_req_bits_uop_iw_p1_poisoned               (io_req_bits_uop_iw_p1_poisoned),
    .io_req_bits_uop_iw_p2_poisoned               (io_req_bits_uop_iw_p2_poisoned),
    .io_req_bits_uop_is_br                        (io_req_bits_uop_is_br),
    .io_req_bits_uop_is_jalr                      (io_req_bits_uop_is_jalr),
    .io_req_bits_uop_is_jal                       (io_req_bits_uop_is_jal),
    .io_req_bits_uop_is_sfb                       (io_req_bits_uop_is_sfb),
    .io_req_bits_uop_br_mask                      (io_req_bits_uop_br_mask),
    .io_req_bits_uop_br_tag                       (io_req_bits_uop_br_tag),
    .io_req_bits_uop_ftq_idx                      (io_req_bits_uop_ftq_idx),
    .io_req_bits_uop_edge_inst                    (io_req_bits_uop_edge_inst),
    .io_req_bits_uop_pc_lob                       (io_req_bits_uop_pc_lob),
    .io_req_bits_uop_taken                        (io_req_bits_uop_taken),
    .io_req_bits_uop_imm_packed                   (io_req_bits_uop_imm_packed),
    .io_req_bits_uop_csr_addr                     (io_req_bits_uop_csr_addr),
    .io_req_bits_uop_rob_idx                      (io_req_bits_uop_rob_idx),
    .io_req_bits_uop_ldq_idx                      (io_req_bits_uop_ldq_idx),
    .io_req_bits_uop_stq_idx                      (io_req_bits_uop_stq_idx),
    .io_req_bits_uop_rxq_idx                      (io_req_bits_uop_rxq_idx),
    .io_req_bits_uop_pdst                         (io_req_bits_uop_pdst),
    .io_req_bits_uop_prs1                         (io_req_bits_uop_prs1),
    .io_req_bits_uop_prs2                         (io_req_bits_uop_prs2),
    .io_req_bits_uop_prs3                         (io_req_bits_uop_prs3),
    .io_req_bits_uop_ppred                        (io_req_bits_uop_ppred),
    .io_req_bits_uop_prs1_busy                    (io_req_bits_uop_prs1_busy),
    .io_req_bits_uop_prs2_busy                    (io_req_bits_uop_prs2_busy),
    .io_req_bits_uop_prs3_busy                    (io_req_bits_uop_prs3_busy),
    .io_req_bits_uop_ppred_busy                   (io_req_bits_uop_ppred_busy),
    .io_req_bits_uop_stale_pdst                   (io_req_bits_uop_stale_pdst),
    .io_req_bits_uop_exception                    (io_req_bits_uop_exception),
    .io_req_bits_uop_exc_cause                    (io_req_bits_uop_exc_cause),
    .io_req_bits_uop_bypassable                   (io_req_bits_uop_bypassable),
    .io_req_bits_uop_mem_cmd                      (io_req_bits_uop_mem_cmd),
    .io_req_bits_uop_mem_size                     (io_req_bits_uop_mem_size),
    .io_req_bits_uop_mem_signed                   (io_req_bits_uop_mem_signed),
    .io_req_bits_uop_is_fence                     (io_req_bits_uop_is_fence),
    .io_req_bits_uop_is_fencei                    (io_req_bits_uop_is_fencei),
    .io_req_bits_uop_is_amo                       (io_req_bits_uop_is_amo),
    .io_req_bits_uop_uses_ldq                     (io_req_bits_uop_uses_ldq),
    .io_req_bits_uop_uses_stq                     (io_req_bits_uop_uses_stq),
    .io_req_bits_uop_is_sys_pc2epc                (io_req_bits_uop_is_sys_pc2epc),
    .io_req_bits_uop_is_unique                    (io_req_bits_uop_is_unique),
    .io_req_bits_uop_flush_on_commit              (io_req_bits_uop_flush_on_commit),
    .io_req_bits_uop_ldst_is_rs1                  (io_req_bits_uop_ldst_is_rs1),
    .io_req_bits_uop_ldst                         (io_req_bits_uop_ldst),
    .io_req_bits_uop_lrs1                         (io_req_bits_uop_lrs1),
    .io_req_bits_uop_lrs2                         (io_req_bits_uop_lrs2),
    .io_req_bits_uop_lrs3                         (io_req_bits_uop_lrs3),
    .io_req_bits_uop_ldst_val                     (io_req_bits_uop_ldst_val),
    .io_req_bits_uop_dst_rtype                    (io_req_bits_uop_dst_rtype),
    .io_req_bits_uop_lrs1_rtype                   (io_req_bits_uop_lrs1_rtype),
    .io_req_bits_uop_lrs2_rtype                   (io_req_bits_uop_lrs2_rtype),
    .io_req_bits_uop_frs3_en                      (io_req_bits_uop_frs3_en),
    .io_req_bits_uop_fp_val                       (io_req_bits_uop_fp_val),
    .io_req_bits_uop_fp_single                    (io_req_bits_uop_fp_single),
    .io_req_bits_uop_xcpt_pf_if                   (io_req_bits_uop_xcpt_pf_if),
    .io_req_bits_uop_xcpt_ae_if                   (io_req_bits_uop_xcpt_ae_if),
    .io_req_bits_uop_xcpt_ma_if                   (io_req_bits_uop_xcpt_ma_if),
    .io_req_bits_uop_bp_debug_if                  (io_req_bits_uop_bp_debug_if),
    .io_req_bits_uop_bp_xcpt_if                   (io_req_bits_uop_bp_xcpt_if),
    .io_req_bits_uop_debug_fsrc                   (io_req_bits_uop_debug_fsrc),
    .io_req_bits_uop_debug_tsrc                   (io_req_bits_uop_debug_tsrc),
    .io_req_bits_rs1_data                         (io_req_bits_rs1_data),
    .io_req_bits_rs2_data                         (io_req_bits_rs2_data),
    .io_req_bits_rs3_data                         (io_req_bits_rs3_data),
    .io_req_bits_kill                             (io_req_bits_kill),
    .io_brupdate_b1_resolve_mask                  (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask               (io_brupdate_b1_mispredict_mask),
    .io_fcsr_rm                                   (io_fcsr_rm),
    .io_resp_valid                                (_fpu_io_resp_valid),
    .io_resp_bits_uop_uopc                        (/* unused */),
    .io_resp_bits_uop_inst                        (/* unused */),
    .io_resp_bits_uop_debug_inst                  (/* unused */),
    .io_resp_bits_uop_is_rvc                      (/* unused */),
    .io_resp_bits_uop_debug_pc                    (/* unused */),
    .io_resp_bits_uop_iq_type                     (/* unused */),
    .io_resp_bits_uop_fu_code                     (_fpu_io_resp_bits_uop_fu_code),
    .io_resp_bits_uop_ctrl_br_type                (/* unused */),
    .io_resp_bits_uop_ctrl_op1_sel                (/* unused */),
    .io_resp_bits_uop_ctrl_op2_sel                (/* unused */),
    .io_resp_bits_uop_ctrl_imm_sel                (/* unused */),
    .io_resp_bits_uop_ctrl_op_fcn                 (/* unused */),
    .io_resp_bits_uop_ctrl_fcn_dw                 (/* unused */),
    .io_resp_bits_uop_ctrl_csr_cmd                (/* unused */),
    .io_resp_bits_uop_ctrl_is_load                (/* unused */),
    .io_resp_bits_uop_ctrl_is_sta                 (/* unused */),
    .io_resp_bits_uop_ctrl_is_std                 (/* unused */),
    .io_resp_bits_uop_iw_state                    (/* unused */),
    .io_resp_bits_uop_iw_p1_poisoned              (/* unused */),
    .io_resp_bits_uop_iw_p2_poisoned              (/* unused */),
    .io_resp_bits_uop_is_br                       (/* unused */),
    .io_resp_bits_uop_is_jalr                     (/* unused */),
    .io_resp_bits_uop_is_jal                      (/* unused */),
    .io_resp_bits_uop_is_sfb                      (/* unused */),
    .io_resp_bits_uop_br_mask                     (/* unused */),
    .io_resp_bits_uop_br_tag                      (/* unused */),
    .io_resp_bits_uop_ftq_idx                     (/* unused */),
    .io_resp_bits_uop_edge_inst                   (/* unused */),
    .io_resp_bits_uop_pc_lob                      (/* unused */),
    .io_resp_bits_uop_taken                       (/* unused */),
    .io_resp_bits_uop_imm_packed                  (/* unused */),
    .io_resp_bits_uop_csr_addr                    (/* unused */),
    .io_resp_bits_uop_rob_idx                     (io_fresp_bits_uop_rob_idx),
    .io_resp_bits_uop_ldq_idx                     (/* unused */),
    .io_resp_bits_uop_stq_idx                     (/* unused */),
    .io_resp_bits_uop_rxq_idx                     (/* unused */),
    .io_resp_bits_uop_pdst                        (io_fresp_bits_uop_pdst),
    .io_resp_bits_uop_prs1                        (/* unused */),
    .io_resp_bits_uop_prs2                        (/* unused */),
    .io_resp_bits_uop_prs3                        (/* unused */),
    .io_resp_bits_uop_ppred                       (/* unused */),
    .io_resp_bits_uop_prs1_busy                   (/* unused */),
    .io_resp_bits_uop_prs2_busy                   (/* unused */),
    .io_resp_bits_uop_prs3_busy                   (/* unused */),
    .io_resp_bits_uop_ppred_busy                  (/* unused */),
    .io_resp_bits_uop_stale_pdst                  (/* unused */),
    .io_resp_bits_uop_exception                   (/* unused */),
    .io_resp_bits_uop_exc_cause                   (/* unused */),
    .io_resp_bits_uop_bypassable                  (/* unused */),
    .io_resp_bits_uop_mem_cmd                     (/* unused */),
    .io_resp_bits_uop_mem_size                    (/* unused */),
    .io_resp_bits_uop_mem_signed                  (/* unused */),
    .io_resp_bits_uop_is_fence                    (/* unused */),
    .io_resp_bits_uop_is_fencei                   (/* unused */),
    .io_resp_bits_uop_is_amo                      (io_fresp_bits_uop_is_amo),
    .io_resp_bits_uop_uses_ldq                    (io_fresp_bits_uop_uses_ldq),
    .io_resp_bits_uop_uses_stq                    (io_fresp_bits_uop_uses_stq),
    .io_resp_bits_uop_is_sys_pc2epc               (/* unused */),
    .io_resp_bits_uop_is_unique                   (/* unused */),
    .io_resp_bits_uop_flush_on_commit             (/* unused */),
    .io_resp_bits_uop_ldst_is_rs1                 (/* unused */),
    .io_resp_bits_uop_ldst                        (/* unused */),
    .io_resp_bits_uop_lrs1                        (/* unused */),
    .io_resp_bits_uop_lrs2                        (/* unused */),
    .io_resp_bits_uop_lrs3                        (/* unused */),
    .io_resp_bits_uop_ldst_val                    (/* unused */),
    .io_resp_bits_uop_dst_rtype                   (io_fresp_bits_uop_dst_rtype),
    .io_resp_bits_uop_lrs1_rtype                  (/* unused */),
    .io_resp_bits_uop_lrs2_rtype                  (/* unused */),
    .io_resp_bits_uop_frs3_en                     (/* unused */),
    .io_resp_bits_uop_fp_val                      (io_fresp_bits_uop_fp_val),
    .io_resp_bits_uop_fp_single                   (/* unused */),
    .io_resp_bits_uop_xcpt_pf_if                  (/* unused */),
    .io_resp_bits_uop_xcpt_ae_if                  (/* unused */),
    .io_resp_bits_uop_xcpt_ma_if                  (/* unused */),
    .io_resp_bits_uop_bp_debug_if                 (/* unused */),
    .io_resp_bits_uop_bp_xcpt_if                  (/* unused */),
    .io_resp_bits_uop_debug_fsrc                  (/* unused */),
    .io_resp_bits_uop_debug_tsrc                  (/* unused */),
    .io_resp_bits_data                            (io_fresp_bits_data),
    .io_resp_bits_fflags_valid                    (_fpu_io_resp_bits_fflags_valid),
    .io_resp_bits_fflags_bits_uop_uopc            (/* unused */),
    .io_resp_bits_fflags_bits_uop_inst            (/* unused */),
    .io_resp_bits_fflags_bits_uop_debug_inst      (/* unused */),
    .io_resp_bits_fflags_bits_uop_is_rvc          (/* unused */),
    .io_resp_bits_fflags_bits_uop_debug_pc        (/* unused */),
    .io_resp_bits_fflags_bits_uop_iq_type         (/* unused */),
    .io_resp_bits_fflags_bits_uop_fu_code         (/* unused */),
    .io_resp_bits_fflags_bits_uop_ctrl_br_type    (/* unused */),
    .io_resp_bits_fflags_bits_uop_ctrl_op1_sel    (/* unused */),
    .io_resp_bits_fflags_bits_uop_ctrl_op2_sel    (/* unused */),
    .io_resp_bits_fflags_bits_uop_ctrl_imm_sel    (/* unused */),
    .io_resp_bits_fflags_bits_uop_ctrl_op_fcn     (/* unused */),
    .io_resp_bits_fflags_bits_uop_ctrl_fcn_dw     (/* unused */),
    .io_resp_bits_fflags_bits_uop_ctrl_csr_cmd    (/* unused */),
    .io_resp_bits_fflags_bits_uop_ctrl_is_load    (/* unused */),
    .io_resp_bits_fflags_bits_uop_ctrl_is_sta     (/* unused */),
    .io_resp_bits_fflags_bits_uop_ctrl_is_std     (/* unused */),
    .io_resp_bits_fflags_bits_uop_iw_state        (/* unused */),
    .io_resp_bits_fflags_bits_uop_iw_p1_poisoned  (/* unused */),
    .io_resp_bits_fflags_bits_uop_iw_p2_poisoned  (/* unused */),
    .io_resp_bits_fflags_bits_uop_is_br           (/* unused */),
    .io_resp_bits_fflags_bits_uop_is_jalr         (/* unused */),
    .io_resp_bits_fflags_bits_uop_is_jal          (/* unused */),
    .io_resp_bits_fflags_bits_uop_is_sfb          (/* unused */),
    .io_resp_bits_fflags_bits_uop_br_mask         (/* unused */),
    .io_resp_bits_fflags_bits_uop_br_tag          (/* unused */),
    .io_resp_bits_fflags_bits_uop_ftq_idx         (/* unused */),
    .io_resp_bits_fflags_bits_uop_edge_inst       (/* unused */),
    .io_resp_bits_fflags_bits_uop_pc_lob          (/* unused */),
    .io_resp_bits_fflags_bits_uop_taken           (/* unused */),
    .io_resp_bits_fflags_bits_uop_imm_packed      (/* unused */),
    .io_resp_bits_fflags_bits_uop_csr_addr        (/* unused */),
    .io_resp_bits_fflags_bits_uop_rob_idx
      (_fpu_io_resp_bits_fflags_bits_uop_rob_idx),
    .io_resp_bits_fflags_bits_uop_ldq_idx         (/* unused */),
    .io_resp_bits_fflags_bits_uop_stq_idx         (/* unused */),
    .io_resp_bits_fflags_bits_uop_rxq_idx         (/* unused */),
    .io_resp_bits_fflags_bits_uop_pdst            (/* unused */),
    .io_resp_bits_fflags_bits_uop_prs1            (/* unused */),
    .io_resp_bits_fflags_bits_uop_prs2            (/* unused */),
    .io_resp_bits_fflags_bits_uop_prs3            (/* unused */),
    .io_resp_bits_fflags_bits_uop_ppred           (/* unused */),
    .io_resp_bits_fflags_bits_uop_prs1_busy       (/* unused */),
    .io_resp_bits_fflags_bits_uop_prs2_busy       (/* unused */),
    .io_resp_bits_fflags_bits_uop_prs3_busy       (/* unused */),
    .io_resp_bits_fflags_bits_uop_ppred_busy      (/* unused */),
    .io_resp_bits_fflags_bits_uop_stale_pdst      (/* unused */),
    .io_resp_bits_fflags_bits_uop_exception       (/* unused */),
    .io_resp_bits_fflags_bits_uop_exc_cause       (/* unused */),
    .io_resp_bits_fflags_bits_uop_bypassable      (/* unused */),
    .io_resp_bits_fflags_bits_uop_mem_cmd         (/* unused */),
    .io_resp_bits_fflags_bits_uop_mem_size        (/* unused */),
    .io_resp_bits_fflags_bits_uop_mem_signed      (/* unused */),
    .io_resp_bits_fflags_bits_uop_is_fence        (/* unused */),
    .io_resp_bits_fflags_bits_uop_is_fencei       (/* unused */),
    .io_resp_bits_fflags_bits_uop_is_amo          (/* unused */),
    .io_resp_bits_fflags_bits_uop_uses_ldq        (/* unused */),
    .io_resp_bits_fflags_bits_uop_uses_stq        (/* unused */),
    .io_resp_bits_fflags_bits_uop_is_sys_pc2epc   (/* unused */),
    .io_resp_bits_fflags_bits_uop_is_unique       (/* unused */),
    .io_resp_bits_fflags_bits_uop_flush_on_commit (/* unused */),
    .io_resp_bits_fflags_bits_uop_ldst_is_rs1     (/* unused */),
    .io_resp_bits_fflags_bits_uop_ldst            (/* unused */),
    .io_resp_bits_fflags_bits_uop_lrs1            (/* unused */),
    .io_resp_bits_fflags_bits_uop_lrs2            (/* unused */),
    .io_resp_bits_fflags_bits_uop_lrs3            (/* unused */),
    .io_resp_bits_fflags_bits_uop_ldst_val        (/* unused */),
    .io_resp_bits_fflags_bits_uop_dst_rtype       (/* unused */),
    .io_resp_bits_fflags_bits_uop_lrs1_rtype      (/* unused */),
    .io_resp_bits_fflags_bits_uop_lrs2_rtype      (/* unused */),
    .io_resp_bits_fflags_bits_uop_frs3_en         (/* unused */),
    .io_resp_bits_fflags_bits_uop_fp_val          (/* unused */),
    .io_resp_bits_fflags_bits_uop_fp_single       (/* unused */),
    .io_resp_bits_fflags_bits_uop_xcpt_pf_if      (/* unused */),
    .io_resp_bits_fflags_bits_uop_xcpt_ae_if      (/* unused */),
    .io_resp_bits_fflags_bits_uop_xcpt_ma_if      (/* unused */),
    .io_resp_bits_fflags_bits_uop_bp_debug_if     (/* unused */),
    .io_resp_bits_fflags_bits_uop_bp_xcpt_if      (/* unused */),
    .io_resp_bits_fflags_bits_uop_debug_fsrc      (/* unused */),
    .io_resp_bits_fflags_bits_uop_debug_tsrc      (/* unused */),
    .io_resp_bits_fflags_bits_flags               (_fpu_io_resp_bits_fflags_bits_flags)
  );
  assign io_fresp_valid =
    _fpu_io_resp_valid & ~(_fpu_io_resp_valid & _fpu_io_resp_bits_uop_fu_code[9]);	// execution-unit.scala:468:17, :516:69, :517:{27,47}, micro-op.scala:154:40
  assign io_fresp_bits_fflags_valid = _fpu_io_resp_valid & _fpu_io_resp_bits_fflags_valid;	// execution-unit.scala:468:17, :521:30
  assign io_fresp_bits_fflags_bits_uop_rob_idx =
    _fpu_io_resp_valid ? _fpu_io_resp_bits_fflags_bits_uop_rob_idx : 7'h0;	// execution-unit.scala:468:17, :490:20, :521:30
  assign io_fresp_bits_fflags_bits_flags =
    _fpu_io_resp_valid ? _fpu_io_resp_bits_fflags_bits_flags : 5'h0;	// execution-unit.scala:468:17, :490:20, :521:30
endmodule

