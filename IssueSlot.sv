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

module IssueSlot(
  input         clock,
                reset,
                io_grant,
  input  [19:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  input         io_kill,
                io_clear,
                io_wakeup_ports_0_valid,
  input  [6:0]  io_wakeup_ports_0_bits_pdst,
  input         io_wakeup_ports_1_valid,
  input  [6:0]  io_wakeup_ports_1_bits_pdst,
  input         io_wakeup_ports_2_valid,
  input  [6:0]  io_wakeup_ports_2_bits_pdst,
  input         io_wakeup_ports_3_valid,
  input  [6:0]  io_wakeup_ports_3_bits_pdst,
  input         io_in_uop_valid,
  input  [6:0]  io_in_uop_bits_uopc,
  input  [31:0] io_in_uop_bits_inst,
                io_in_uop_bits_debug_inst,
  input         io_in_uop_bits_is_rvc,
  input  [39:0] io_in_uop_bits_debug_pc,
  input  [2:0]  io_in_uop_bits_iq_type,
  input  [9:0]  io_in_uop_bits_fu_code,
  input  [1:0]  io_in_uop_bits_iw_state,
  input         io_in_uop_bits_is_br,
                io_in_uop_bits_is_jalr,
                io_in_uop_bits_is_jal,
                io_in_uop_bits_is_sfb,
  input  [19:0] io_in_uop_bits_br_mask,
  input  [4:0]  io_in_uop_bits_br_tag,
  input  [5:0]  io_in_uop_bits_ftq_idx,
  input         io_in_uop_bits_edge_inst,
  input  [5:0]  io_in_uop_bits_pc_lob,
  input         io_in_uop_bits_taken,
  input  [19:0] io_in_uop_bits_imm_packed,
  input  [11:0] io_in_uop_bits_csr_addr,
  input  [6:0]  io_in_uop_bits_rob_idx,
  input  [4:0]  io_in_uop_bits_ldq_idx,
                io_in_uop_bits_stq_idx,
  input  [1:0]  io_in_uop_bits_rxq_idx,
  input  [6:0]  io_in_uop_bits_pdst,
                io_in_uop_bits_prs1,
                io_in_uop_bits_prs2,
                io_in_uop_bits_prs3,
  input  [5:0]  io_in_uop_bits_ppred,
  input         io_in_uop_bits_prs1_busy,
                io_in_uop_bits_prs2_busy,
                io_in_uop_bits_prs3_busy,
                io_in_uop_bits_ppred_busy,
  input  [6:0]  io_in_uop_bits_stale_pdst,
  input         io_in_uop_bits_exception,
  input  [63:0] io_in_uop_bits_exc_cause,
  input         io_in_uop_bits_bypassable,
  input  [4:0]  io_in_uop_bits_mem_cmd,
  input  [1:0]  io_in_uop_bits_mem_size,
  input         io_in_uop_bits_mem_signed,
                io_in_uop_bits_is_fence,
                io_in_uop_bits_is_fencei,
                io_in_uop_bits_is_amo,
                io_in_uop_bits_uses_ldq,
                io_in_uop_bits_uses_stq,
                io_in_uop_bits_is_sys_pc2epc,
                io_in_uop_bits_is_unique,
                io_in_uop_bits_flush_on_commit,
                io_in_uop_bits_ldst_is_rs1,
  input  [5:0]  io_in_uop_bits_ldst,
                io_in_uop_bits_lrs1,
                io_in_uop_bits_lrs2,
                io_in_uop_bits_lrs3,
  input         io_in_uop_bits_ldst_val,
  input  [1:0]  io_in_uop_bits_dst_rtype,
                io_in_uop_bits_lrs1_rtype,
                io_in_uop_bits_lrs2_rtype,
  input         io_in_uop_bits_frs3_en,
                io_in_uop_bits_fp_val,
                io_in_uop_bits_fp_single,
                io_in_uop_bits_xcpt_pf_if,
                io_in_uop_bits_xcpt_ae_if,
                io_in_uop_bits_xcpt_ma_if,
                io_in_uop_bits_bp_debug_if,
                io_in_uop_bits_bp_xcpt_if,
  input  [1:0]  io_in_uop_bits_debug_fsrc,
                io_in_uop_bits_debug_tsrc,
  output        io_valid,
                io_will_be_valid,
                io_request,
  output [6:0]  io_out_uop_uopc,
  output [31:0] io_out_uop_inst,
                io_out_uop_debug_inst,
  output        io_out_uop_is_rvc,
  output [39:0] io_out_uop_debug_pc,
  output [2:0]  io_out_uop_iq_type,
  output [9:0]  io_out_uop_fu_code,
  output [1:0]  io_out_uop_iw_state,
  output        io_out_uop_is_br,
                io_out_uop_is_jalr,
                io_out_uop_is_jal,
                io_out_uop_is_sfb,
  output [19:0] io_out_uop_br_mask,
  output [4:0]  io_out_uop_br_tag,
  output [5:0]  io_out_uop_ftq_idx,
  output        io_out_uop_edge_inst,
  output [5:0]  io_out_uop_pc_lob,
  output        io_out_uop_taken,
  output [19:0] io_out_uop_imm_packed,
  output [11:0] io_out_uop_csr_addr,
  output [6:0]  io_out_uop_rob_idx,
  output [4:0]  io_out_uop_ldq_idx,
                io_out_uop_stq_idx,
  output [1:0]  io_out_uop_rxq_idx,
  output [6:0]  io_out_uop_pdst,
                io_out_uop_prs1,
                io_out_uop_prs2,
                io_out_uop_prs3,
  output [5:0]  io_out_uop_ppred,
  output        io_out_uop_prs1_busy,
                io_out_uop_prs2_busy,
                io_out_uop_prs3_busy,
                io_out_uop_ppred_busy,
  output [6:0]  io_out_uop_stale_pdst,
  output        io_out_uop_exception,
  output [63:0] io_out_uop_exc_cause,
  output        io_out_uop_bypassable,
  output [4:0]  io_out_uop_mem_cmd,
  output [1:0]  io_out_uop_mem_size,
  output        io_out_uop_mem_signed,
                io_out_uop_is_fence,
                io_out_uop_is_fencei,
                io_out_uop_is_amo,
                io_out_uop_uses_ldq,
                io_out_uop_uses_stq,
                io_out_uop_is_sys_pc2epc,
                io_out_uop_is_unique,
                io_out_uop_flush_on_commit,
                io_out_uop_ldst_is_rs1,
  output [5:0]  io_out_uop_ldst,
                io_out_uop_lrs1,
                io_out_uop_lrs2,
                io_out_uop_lrs3,
  output        io_out_uop_ldst_val,
  output [1:0]  io_out_uop_dst_rtype,
                io_out_uop_lrs1_rtype,
                io_out_uop_lrs2_rtype,
  output        io_out_uop_frs3_en,
                io_out_uop_fp_val,
                io_out_uop_fp_single,
                io_out_uop_xcpt_pf_if,
                io_out_uop_xcpt_ae_if,
                io_out_uop_xcpt_ma_if,
                io_out_uop_bp_debug_if,
                io_out_uop_bp_xcpt_if,
  output [1:0]  io_out_uop_debug_fsrc,
                io_out_uop_debug_tsrc,
  output [6:0]  io_uop_uopc,
  output [31:0] io_uop_inst,
                io_uop_debug_inst,
  output        io_uop_is_rvc,
  output [39:0] io_uop_debug_pc,
  output [2:0]  io_uop_iq_type,
  output [9:0]  io_uop_fu_code,
  output [1:0]  io_uop_iw_state,
  output        io_uop_is_br,
                io_uop_is_jalr,
                io_uop_is_jal,
                io_uop_is_sfb,
  output [19:0] io_uop_br_mask,
  output [4:0]  io_uop_br_tag,
  output [5:0]  io_uop_ftq_idx,
  output        io_uop_edge_inst,
  output [5:0]  io_uop_pc_lob,
  output        io_uop_taken,
  output [19:0] io_uop_imm_packed,
  output [11:0] io_uop_csr_addr,
  output [6:0]  io_uop_rob_idx,
  output [4:0]  io_uop_ldq_idx,
                io_uop_stq_idx,
  output [1:0]  io_uop_rxq_idx,
  output [6:0]  io_uop_pdst,
                io_uop_prs1,
                io_uop_prs2,
                io_uop_prs3,
  output [5:0]  io_uop_ppred,
  output        io_uop_prs1_busy,
                io_uop_prs2_busy,
                io_uop_prs3_busy,
                io_uop_ppred_busy,
  output [6:0]  io_uop_stale_pdst,
  output        io_uop_exception,
  output [63:0] io_uop_exc_cause,
  output        io_uop_bypassable,
  output [4:0]  io_uop_mem_cmd,
  output [1:0]  io_uop_mem_size,
  output        io_uop_mem_signed,
                io_uop_is_fence,
                io_uop_is_fencei,
                io_uop_is_amo,
                io_uop_uses_ldq,
                io_uop_uses_stq,
                io_uop_is_sys_pc2epc,
                io_uop_is_unique,
                io_uop_flush_on_commit,
                io_uop_ldst_is_rs1,
  output [5:0]  io_uop_ldst,
                io_uop_lrs1,
                io_uop_lrs2,
                io_uop_lrs3,
  output        io_uop_ldst_val,
  output [1:0]  io_uop_dst_rtype,
                io_uop_lrs1_rtype,
                io_uop_lrs2_rtype,
  output        io_uop_frs3_en,
                io_uop_fp_val,
                io_uop_fp_single,
                io_uop_xcpt_pf_if,
                io_uop_xcpt_ae_if,
                io_uop_xcpt_ma_if,
                io_uop_bp_debug_if,
                io_uop_bp_xcpt_if,
  output [1:0]  io_uop_debug_fsrc,
                io_uop_debug_tsrc
);

  reg  [1:0]  state;	// issue-slot.scala:86:22
  reg         p1;	// issue-slot.scala:87:22
  reg         p2;	// issue-slot.scala:88:22
  reg         p3;	// issue-slot.scala:89:22
  reg         ppred;	// issue-slot.scala:90:22
  reg  [6:0]  slot_uop_uopc;	// issue-slot.scala:102:25
  reg  [31:0] slot_uop_inst;	// issue-slot.scala:102:25
  reg  [31:0] slot_uop_debug_inst;	// issue-slot.scala:102:25
  reg         slot_uop_is_rvc;	// issue-slot.scala:102:25
  reg  [39:0] slot_uop_debug_pc;	// issue-slot.scala:102:25
  reg  [2:0]  slot_uop_iq_type;	// issue-slot.scala:102:25
  reg  [9:0]  slot_uop_fu_code;	// issue-slot.scala:102:25
  reg  [1:0]  slot_uop_iw_state;	// issue-slot.scala:102:25
  reg         slot_uop_is_br;	// issue-slot.scala:102:25
  reg         slot_uop_is_jalr;	// issue-slot.scala:102:25
  reg         slot_uop_is_jal;	// issue-slot.scala:102:25
  reg         slot_uop_is_sfb;	// issue-slot.scala:102:25
  reg  [19:0] slot_uop_br_mask;	// issue-slot.scala:102:25
  reg  [4:0]  slot_uop_br_tag;	// issue-slot.scala:102:25
  reg  [5:0]  slot_uop_ftq_idx;	// issue-slot.scala:102:25
  reg         slot_uop_edge_inst;	// issue-slot.scala:102:25
  reg  [5:0]  slot_uop_pc_lob;	// issue-slot.scala:102:25
  reg         slot_uop_taken;	// issue-slot.scala:102:25
  reg  [19:0] slot_uop_imm_packed;	// issue-slot.scala:102:25
  reg  [11:0] slot_uop_csr_addr;	// issue-slot.scala:102:25
  reg  [6:0]  slot_uop_rob_idx;	// issue-slot.scala:102:25
  reg  [4:0]  slot_uop_ldq_idx;	// issue-slot.scala:102:25
  reg  [4:0]  slot_uop_stq_idx;	// issue-slot.scala:102:25
  reg  [1:0]  slot_uop_rxq_idx;	// issue-slot.scala:102:25
  reg  [6:0]  slot_uop_pdst;	// issue-slot.scala:102:25
  reg  [6:0]  slot_uop_prs1;	// issue-slot.scala:102:25
  reg  [6:0]  slot_uop_prs2;	// issue-slot.scala:102:25
  reg  [6:0]  slot_uop_prs3;	// issue-slot.scala:102:25
  reg  [5:0]  slot_uop_ppred;	// issue-slot.scala:102:25
  reg         slot_uop_prs1_busy;	// issue-slot.scala:102:25
  reg         slot_uop_prs2_busy;	// issue-slot.scala:102:25
  reg         slot_uop_prs3_busy;	// issue-slot.scala:102:25
  reg         slot_uop_ppred_busy;	// issue-slot.scala:102:25
  reg  [6:0]  slot_uop_stale_pdst;	// issue-slot.scala:102:25
  reg         slot_uop_exception;	// issue-slot.scala:102:25
  reg  [63:0] slot_uop_exc_cause;	// issue-slot.scala:102:25
  reg         slot_uop_bypassable;	// issue-slot.scala:102:25
  reg  [4:0]  slot_uop_mem_cmd;	// issue-slot.scala:102:25
  reg  [1:0]  slot_uop_mem_size;	// issue-slot.scala:102:25
  reg         slot_uop_mem_signed;	// issue-slot.scala:102:25
  reg         slot_uop_is_fence;	// issue-slot.scala:102:25
  reg         slot_uop_is_fencei;	// issue-slot.scala:102:25
  reg         slot_uop_is_amo;	// issue-slot.scala:102:25
  reg         slot_uop_uses_ldq;	// issue-slot.scala:102:25
  reg         slot_uop_uses_stq;	// issue-slot.scala:102:25
  reg         slot_uop_is_sys_pc2epc;	// issue-slot.scala:102:25
  reg         slot_uop_is_unique;	// issue-slot.scala:102:25
  reg         slot_uop_flush_on_commit;	// issue-slot.scala:102:25
  reg         slot_uop_ldst_is_rs1;	// issue-slot.scala:102:25
  reg  [5:0]  slot_uop_ldst;	// issue-slot.scala:102:25
  reg  [5:0]  slot_uop_lrs1;	// issue-slot.scala:102:25
  reg  [5:0]  slot_uop_lrs2;	// issue-slot.scala:102:25
  reg  [5:0]  slot_uop_lrs3;	// issue-slot.scala:102:25
  reg         slot_uop_ldst_val;	// issue-slot.scala:102:25
  reg  [1:0]  slot_uop_dst_rtype;	// issue-slot.scala:102:25
  reg  [1:0]  slot_uop_lrs1_rtype;	// issue-slot.scala:102:25
  reg  [1:0]  slot_uop_lrs2_rtype;	// issue-slot.scala:102:25
  reg         slot_uop_frs3_en;	// issue-slot.scala:102:25
  reg         slot_uop_fp_val;	// issue-slot.scala:102:25
  reg         slot_uop_fp_single;	// issue-slot.scala:102:25
  reg         slot_uop_xcpt_pf_if;	// issue-slot.scala:102:25
  reg         slot_uop_xcpt_ae_if;	// issue-slot.scala:102:25
  reg         slot_uop_xcpt_ma_if;	// issue-slot.scala:102:25
  reg         slot_uop_bp_debug_if;	// issue-slot.scala:102:25
  reg         slot_uop_bp_xcpt_if;	// issue-slot.scala:102:25
  reg  [1:0]  slot_uop_debug_fsrc;	// issue-slot.scala:102:25
  reg  [1:0]  slot_uop_debug_tsrc;	// issue-slot.scala:102:25
  wire        _GEN = state == 2'h2;	// consts.scala:277:20, issue-slot.scala:86:22, :134:25
  wire        _GEN_0 = io_grant & _GEN;	// issue-slot.scala:134:{15,25}
  wire        _GEN_1 = _GEN_0 & p1;	// issue-slot.scala:87:22, :134:{15,40}
  wire        _GEN_2 = io_grant & state == 2'h1 | _GEN_1 & p2 & ppred;	// issue-slot.scala:86:22, :88:22, :90:22, :133:{26,36,52}, :134:{40,52}
  wire        _GEN_3 = io_kill | _GEN_2;	// issue-slot.scala:102:25, :131:18, :133:52, :134:63, :139:51
  wire        _GEN_4 = _GEN_3 | ~_GEN_1;	// issue-slot.scala:102:25, :131:18, :134:{40,63}, :139:51
  wire        _GEN_5 = _GEN_3 | ~_GEN_0 | p1;	// issue-slot.scala:87:22, :102:25, :131:18, :134:{15,63}, :139:51, :140:62, :142:17
  `ifndef SYNTHESIS	// issue-slot.scala:156:12
    always @(posedge clock) begin	// issue-slot.scala:156:12
      if (io_in_uop_valid & ~(state == 2'h0 | io_clear | io_kill | reset)) begin	// issue-slot.scala:78:26, :86:22, :126:14, :136:62, :137:18, :156:12
        if (`ASSERT_VERBOSE_COND_)	// issue-slot.scala:156:12
          $error("Assertion failed: trying to overwrite a valid issue slot.\n    at issue-slot.scala:156 assert (is_invalid || io.clear || io.kill, \"trying to overwrite a valid issue slot.\")\n");	// issue-slot.scala:156:12
        if (`STOP_COND_)	// issue-slot.scala:156:12
          $fatal;	// issue-slot.scala:156:12
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  wire [19:0] next_br_mask = slot_uop_br_mask & ~io_brupdate_b1_resolve_mask;	// issue-slot.scala:102:25, util.scala:85:{25,27}
  wire        _GEN_6 =
    (|(io_brupdate_b1_mispredict_mask & slot_uop_br_mask)) | io_kill | _GEN_2;	// issue-slot.scala:102:25, :131:18, :132:16, :133:52, :134:63, :136:62, :139:51, :231:50, :232:16, util.scala:118:{51,59}
  wire        _may_vacate_T = state == 2'h1;	// issue-slot.scala:86:22, :133:36, :245:15
  wire        _may_vacate_T_1 = state == 2'h2;	// consts.scala:277:20, issue-slot.scala:86:22, :260:65
  wire        _GEN_7 = p1 & p2 & ppred;	// issue-slot.scala:87:22, :88:22, :90:22, :278:20
  wire        _GEN_8 = p1 & ppred;	// issue-slot.scala:87:22, :90:22, :280:21
  wire        _GEN_9 = ~_may_vacate_T_1 | _GEN_7 | _GEN_8 | ~(p2 & ppred);	// issue-slot.scala:88:22, :90:22, :255:10, :260:65, :277:30, :278:{20,30}, :280:{21,31}, :281:19, :283:{21,31}
  always @(posedge clock) begin
    if (reset) begin
      state <= 2'h0;	// issue-slot.scala:86:22, :126:14, :136:62, :137:18
      p1 <= 1'h0;	// issue-slot.scala:87:22, :175:24, :179:24, :198:35, :210:51, :211:39, :213:19, :217:51, :218:39, :220:19
      p2 <= 1'h0;	// issue-slot.scala:88:22, :175:24, :179:24, :198:35, :210:51, :211:39, :213:19, :217:51, :218:39, :220:19
      p3 <= 1'h0;	// issue-slot.scala:89:22, :175:24, :179:24, :198:35, :210:51, :211:39, :213:19, :217:51, :218:39, :220:19
      ppred <= 1'h0;	// issue-slot.scala:90:22, :175:24, :179:24, :198:35, :210:51, :211:39, :213:19, :217:51, :218:39, :220:19
      slot_uop_uopc <= 7'h0;	// consts.scala:270:20, issue-slot.scala:102:25
      slot_uop_pdst <= 7'h0;	// consts.scala:270:20, issue-slot.scala:102:25
      slot_uop_bypassable <= 1'h0;	// issue-slot.scala:102:25, :175:24, :179:24, :198:35, :210:51, :211:39, :213:19, :217:51, :218:39, :220:19
      slot_uop_uses_ldq <= 1'h0;	// issue-slot.scala:102:25, :175:24, :179:24, :198:35, :210:51, :211:39, :213:19, :217:51, :218:39, :220:19
      slot_uop_uses_stq <= 1'h0;	// issue-slot.scala:102:25, :175:24, :179:24, :198:35, :210:51, :211:39, :213:19, :217:51, :218:39, :220:19
      slot_uop_dst_rtype <= 2'h2;	// consts.scala:277:20, issue-slot.scala:102:25
      slot_uop_fp_val <= 1'h0;	// issue-slot.scala:102:25, :175:24, :179:24, :198:35, :210:51, :211:39, :213:19, :217:51, :218:39, :220:19
    end
    else begin
      automatic logic [6:0] next_uop_prs1;	// issue-slot.scala:103:21
      automatic logic [6:0] next_uop_prs2;	// issue-slot.scala:103:21
      automatic logic [6:0] next_uop_prs3;	// issue-slot.scala:103:21
      next_uop_prs1 = io_in_uop_valid ? io_in_uop_bits_prs1 : slot_uop_prs1;	// issue-slot.scala:102:25, :103:21
      next_uop_prs2 = io_in_uop_valid ? io_in_uop_bits_prs2 : slot_uop_prs2;	// issue-slot.scala:102:25, :103:21
      next_uop_prs3 = io_in_uop_valid ? io_in_uop_bits_prs3 : slot_uop_prs3;	// issue-slot.scala:102:25, :103:21
      if (io_kill)
        state <= 2'h0;	// issue-slot.scala:86:22, :126:14, :136:62, :137:18
      else if (io_in_uop_valid)
        state <= io_in_uop_bits_iw_state;	// issue-slot.scala:86:22
      else if (io_clear | _GEN_6)	// issue-slot.scala:114:26, :115:11, :117:11, :131:18, :132:16, :134:63, :136:62, :139:51, :231:50, :232:16
        state <= 2'h0;	// issue-slot.scala:86:22, :126:14, :136:62, :137:18
      else if (_GEN_0)	// issue-slot.scala:134:15
        state <= 2'h1;	// issue-slot.scala:86:22, :133:36
      p1 <=
        io_wakeup_ports_3_valid & io_wakeup_ports_3_bits_pdst == next_uop_prs1
        | io_wakeup_ports_2_valid & io_wakeup_ports_2_bits_pdst == next_uop_prs1
        | io_wakeup_ports_1_valid & io_wakeup_ports_1_bits_pdst == next_uop_prs1
        | io_wakeup_ports_0_valid & io_wakeup_ports_0_bits_pdst == next_uop_prs1
        | (io_in_uop_valid ? ~io_in_uop_bits_prs1_busy : p1);	// issue-slot.scala:87:22, :103:21, :168:26, :169:{8,11}, :175:45, :185:36, :186:{40,60}, :187:10, :211:39, :212:10
      p2 <=
        io_wakeup_ports_3_valid & io_wakeup_ports_3_bits_pdst == next_uop_prs2
        | io_wakeup_ports_2_valid & io_wakeup_ports_2_bits_pdst == next_uop_prs2
        | io_wakeup_ports_1_valid & io_wakeup_ports_1_bits_pdst == next_uop_prs2
        | io_wakeup_ports_0_valid & io_wakeup_ports_0_bits_pdst == next_uop_prs2
        | (io_in_uop_valid ? ~io_in_uop_bits_prs2_busy : p2);	// issue-slot.scala:88:22, :103:21, :168:26, :170:{8,11}, :179:45, :189:36, :190:{40,60}, :191:10, :218:39, :219:10
      p3 <=
        io_wakeup_ports_3_valid & io_wakeup_ports_3_bits_pdst == next_uop_prs3
        | io_wakeup_ports_2_valid & io_wakeup_ports_2_bits_pdst == next_uop_prs3
        | io_wakeup_ports_1_valid & io_wakeup_ports_1_bits_pdst == next_uop_prs3
        | io_wakeup_ports_0_valid & io_wakeup_ports_0_bits_pdst == next_uop_prs3
        | (io_in_uop_valid ? ~io_in_uop_bits_prs3_busy : p3);	// issue-slot.scala:89:22, :103:21, :168:26, :171:{8,11}, :193:36, :194:{40,60}, :195:10
      if (io_in_uop_valid) begin
        ppred <= ~io_in_uop_bits_ppred_busy;	// issue-slot.scala:90:22, :172:14
        slot_uop_uopc <= io_in_uop_bits_uopc;	// issue-slot.scala:102:25
        slot_uop_pdst <= io_in_uop_bits_pdst;	// issue-slot.scala:102:25
        slot_uop_bypassable <= io_in_uop_bits_bypassable;	// issue-slot.scala:102:25
        slot_uop_uses_ldq <= io_in_uop_bits_uses_ldq;	// issue-slot.scala:102:25
        slot_uop_uses_stq <= io_in_uop_bits_uses_stq;	// issue-slot.scala:102:25
        slot_uop_dst_rtype <= io_in_uop_bits_dst_rtype;	// issue-slot.scala:102:25
        slot_uop_fp_val <= io_in_uop_bits_fp_val;	// issue-slot.scala:102:25
      end
      else if (_GEN_4) begin	// issue-slot.scala:102:25, :131:18, :134:63, :139:51
      end
      else	// issue-slot.scala:102:25, :131:18, :134:63, :139:51
        slot_uop_uopc <= 7'h3;	// issue-slot.scala:102:25, :143:23
    end
    if (io_in_uop_valid) begin
      slot_uop_inst <= io_in_uop_bits_inst;	// issue-slot.scala:102:25
      slot_uop_debug_inst <= io_in_uop_bits_debug_inst;	// issue-slot.scala:102:25
      slot_uop_is_rvc <= io_in_uop_bits_is_rvc;	// issue-slot.scala:102:25
      slot_uop_debug_pc <= io_in_uop_bits_debug_pc;	// issue-slot.scala:102:25
      slot_uop_iq_type <= io_in_uop_bits_iq_type;	// issue-slot.scala:102:25
      slot_uop_fu_code <= io_in_uop_bits_fu_code;	// issue-slot.scala:102:25
      slot_uop_iw_state <= io_in_uop_bits_iw_state;	// issue-slot.scala:102:25
      slot_uop_is_br <= io_in_uop_bits_is_br;	// issue-slot.scala:102:25
      slot_uop_is_jalr <= io_in_uop_bits_is_jalr;	// issue-slot.scala:102:25
      slot_uop_is_jal <= io_in_uop_bits_is_jal;	// issue-slot.scala:102:25
      slot_uop_is_sfb <= io_in_uop_bits_is_sfb;	// issue-slot.scala:102:25
      slot_uop_br_mask <= io_in_uop_bits_br_mask;	// issue-slot.scala:102:25
      slot_uop_br_tag <= io_in_uop_bits_br_tag;	// issue-slot.scala:102:25
      slot_uop_ftq_idx <= io_in_uop_bits_ftq_idx;	// issue-slot.scala:102:25
      slot_uop_edge_inst <= io_in_uop_bits_edge_inst;	// issue-slot.scala:102:25
      slot_uop_pc_lob <= io_in_uop_bits_pc_lob;	// issue-slot.scala:102:25
      slot_uop_taken <= io_in_uop_bits_taken;	// issue-slot.scala:102:25
      slot_uop_imm_packed <= io_in_uop_bits_imm_packed;	// issue-slot.scala:102:25
      slot_uop_csr_addr <= io_in_uop_bits_csr_addr;	// issue-slot.scala:102:25
      slot_uop_rob_idx <= io_in_uop_bits_rob_idx;	// issue-slot.scala:102:25
      slot_uop_ldq_idx <= io_in_uop_bits_ldq_idx;	// issue-slot.scala:102:25
      slot_uop_stq_idx <= io_in_uop_bits_stq_idx;	// issue-slot.scala:102:25
      slot_uop_rxq_idx <= io_in_uop_bits_rxq_idx;	// issue-slot.scala:102:25
      slot_uop_prs1 <= io_in_uop_bits_prs1;	// issue-slot.scala:102:25
      slot_uop_prs2 <= io_in_uop_bits_prs2;	// issue-slot.scala:102:25
      slot_uop_prs3 <= io_in_uop_bits_prs3;	// issue-slot.scala:102:25
      slot_uop_ppred <= io_in_uop_bits_ppred;	// issue-slot.scala:102:25
      slot_uop_prs1_busy <= io_in_uop_bits_prs1_busy;	// issue-slot.scala:102:25
      slot_uop_prs2_busy <= io_in_uop_bits_prs2_busy;	// issue-slot.scala:102:25
      slot_uop_prs3_busy <= io_in_uop_bits_prs3_busy;	// issue-slot.scala:102:25
      slot_uop_ppred_busy <= io_in_uop_bits_ppred_busy;	// issue-slot.scala:102:25
      slot_uop_stale_pdst <= io_in_uop_bits_stale_pdst;	// issue-slot.scala:102:25
      slot_uop_exception <= io_in_uop_bits_exception;	// issue-slot.scala:102:25
      slot_uop_exc_cause <= io_in_uop_bits_exc_cause;	// issue-slot.scala:102:25
      slot_uop_mem_cmd <= io_in_uop_bits_mem_cmd;	// issue-slot.scala:102:25
      slot_uop_mem_size <= io_in_uop_bits_mem_size;	// issue-slot.scala:102:25
      slot_uop_mem_signed <= io_in_uop_bits_mem_signed;	// issue-slot.scala:102:25
      slot_uop_is_fence <= io_in_uop_bits_is_fence;	// issue-slot.scala:102:25
      slot_uop_is_fencei <= io_in_uop_bits_is_fencei;	// issue-slot.scala:102:25
      slot_uop_is_amo <= io_in_uop_bits_is_amo;	// issue-slot.scala:102:25
      slot_uop_is_sys_pc2epc <= io_in_uop_bits_is_sys_pc2epc;	// issue-slot.scala:102:25
      slot_uop_is_unique <= io_in_uop_bits_is_unique;	// issue-slot.scala:102:25
      slot_uop_flush_on_commit <= io_in_uop_bits_flush_on_commit;	// issue-slot.scala:102:25
      slot_uop_ldst_is_rs1 <= io_in_uop_bits_ldst_is_rs1;	// issue-slot.scala:102:25
      slot_uop_ldst <= io_in_uop_bits_ldst;	// issue-slot.scala:102:25
      slot_uop_lrs1 <= io_in_uop_bits_lrs1;	// issue-slot.scala:102:25
      slot_uop_lrs2 <= io_in_uop_bits_lrs2;	// issue-slot.scala:102:25
      slot_uop_lrs3 <= io_in_uop_bits_lrs3;	// issue-slot.scala:102:25
      slot_uop_ldst_val <= io_in_uop_bits_ldst_val;	// issue-slot.scala:102:25
      slot_uop_lrs1_rtype <= io_in_uop_bits_lrs1_rtype;	// issue-slot.scala:102:25
      slot_uop_lrs2_rtype <= io_in_uop_bits_lrs2_rtype;	// issue-slot.scala:102:25
      slot_uop_frs3_en <= io_in_uop_bits_frs3_en;	// issue-slot.scala:102:25
      slot_uop_fp_single <= io_in_uop_bits_fp_single;	// issue-slot.scala:102:25
      slot_uop_xcpt_pf_if <= io_in_uop_bits_xcpt_pf_if;	// issue-slot.scala:102:25
      slot_uop_xcpt_ae_if <= io_in_uop_bits_xcpt_ae_if;	// issue-slot.scala:102:25
      slot_uop_xcpt_ma_if <= io_in_uop_bits_xcpt_ma_if;	// issue-slot.scala:102:25
      slot_uop_bp_debug_if <= io_in_uop_bits_bp_debug_if;	// issue-slot.scala:102:25
      slot_uop_bp_xcpt_if <= io_in_uop_bits_bp_xcpt_if;	// issue-slot.scala:102:25
      slot_uop_debug_fsrc <= io_in_uop_bits_debug_fsrc;	// issue-slot.scala:102:25
      slot_uop_debug_tsrc <= io_in_uop_bits_debug_tsrc;	// issue-slot.scala:102:25
    end
    else begin
      slot_uop_br_mask <= next_br_mask;	// issue-slot.scala:102:25, util.scala:85:25
      if (_GEN_4) begin	// issue-slot.scala:102:25, :131:18, :134:63, :139:51
      end
      else	// issue-slot.scala:102:25, :131:18, :134:63, :139:51
        slot_uop_lrs1_rtype <= 2'h2;	// consts.scala:277:20, issue-slot.scala:102:25
      if (_GEN_5) begin	// issue-slot.scala:102:25, :131:18, :134:63, :139:51
      end
      else	// issue-slot.scala:102:25, :131:18, :134:63, :139:51
        slot_uop_lrs2_rtype <= 2'h2;	// consts.scala:277:20, issue-slot.scala:102:25
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:13];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [3:0] i = 4'h0; i < 4'hE; i += 4'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        state = _RANDOM[4'h0][1:0];	// issue-slot.scala:86:22
        p1 = _RANDOM[4'h0][2];	// issue-slot.scala:86:22, :87:22
        p2 = _RANDOM[4'h0][3];	// issue-slot.scala:86:22, :88:22
        p3 = _RANDOM[4'h0][4];	// issue-slot.scala:86:22, :89:22
        ppred = _RANDOM[4'h0][5];	// issue-slot.scala:86:22, :90:22
        slot_uop_uopc = _RANDOM[4'h0][14:8];	// issue-slot.scala:86:22, :102:25
        slot_uop_inst = {_RANDOM[4'h0][31:15], _RANDOM[4'h1][14:0]};	// issue-slot.scala:86:22, :102:25
        slot_uop_debug_inst = {_RANDOM[4'h1][31:15], _RANDOM[4'h2][14:0]};	// issue-slot.scala:102:25
        slot_uop_is_rvc = _RANDOM[4'h2][15];	// issue-slot.scala:102:25
        slot_uop_debug_pc = {_RANDOM[4'h2][31:16], _RANDOM[4'h3][23:0]};	// issue-slot.scala:102:25
        slot_uop_iq_type = _RANDOM[4'h3][26:24];	// issue-slot.scala:102:25
        slot_uop_fu_code = {_RANDOM[4'h3][31:27], _RANDOM[4'h4][4:0]};	// issue-slot.scala:102:25
        slot_uop_iw_state = _RANDOM[4'h4][29:28];	// issue-slot.scala:102:25
        slot_uop_is_br = _RANDOM[4'h5][0];	// issue-slot.scala:102:25
        slot_uop_is_jalr = _RANDOM[4'h5][1];	// issue-slot.scala:102:25
        slot_uop_is_jal = _RANDOM[4'h5][2];	// issue-slot.scala:102:25
        slot_uop_is_sfb = _RANDOM[4'h5][3];	// issue-slot.scala:102:25
        slot_uop_br_mask = _RANDOM[4'h5][23:4];	// issue-slot.scala:102:25
        slot_uop_br_tag = _RANDOM[4'h5][28:24];	// issue-slot.scala:102:25
        slot_uop_ftq_idx = {_RANDOM[4'h5][31:29], _RANDOM[4'h6][2:0]};	// issue-slot.scala:102:25
        slot_uop_edge_inst = _RANDOM[4'h6][3];	// issue-slot.scala:102:25
        slot_uop_pc_lob = _RANDOM[4'h6][9:4];	// issue-slot.scala:102:25
        slot_uop_taken = _RANDOM[4'h6][10];	// issue-slot.scala:102:25
        slot_uop_imm_packed = _RANDOM[4'h6][30:11];	// issue-slot.scala:102:25
        slot_uop_csr_addr = {_RANDOM[4'h6][31], _RANDOM[4'h7][10:0]};	// issue-slot.scala:102:25
        slot_uop_rob_idx = _RANDOM[4'h7][17:11];	// issue-slot.scala:102:25
        slot_uop_ldq_idx = _RANDOM[4'h7][22:18];	// issue-slot.scala:102:25
        slot_uop_stq_idx = _RANDOM[4'h7][27:23];	// issue-slot.scala:102:25
        slot_uop_rxq_idx = _RANDOM[4'h7][29:28];	// issue-slot.scala:102:25
        slot_uop_pdst = {_RANDOM[4'h7][31:30], _RANDOM[4'h8][4:0]};	// issue-slot.scala:102:25
        slot_uop_prs1 = _RANDOM[4'h8][11:5];	// issue-slot.scala:102:25
        slot_uop_prs2 = _RANDOM[4'h8][18:12];	// issue-slot.scala:102:25
        slot_uop_prs3 = _RANDOM[4'h8][25:19];	// issue-slot.scala:102:25
        slot_uop_ppred = _RANDOM[4'h8][31:26];	// issue-slot.scala:102:25
        slot_uop_prs1_busy = _RANDOM[4'h9][0];	// issue-slot.scala:102:25
        slot_uop_prs2_busy = _RANDOM[4'h9][1];	// issue-slot.scala:102:25
        slot_uop_prs3_busy = _RANDOM[4'h9][2];	// issue-slot.scala:102:25
        slot_uop_ppred_busy = _RANDOM[4'h9][3];	// issue-slot.scala:102:25
        slot_uop_stale_pdst = _RANDOM[4'h9][10:4];	// issue-slot.scala:102:25
        slot_uop_exception = _RANDOM[4'h9][11];	// issue-slot.scala:102:25
        slot_uop_exc_cause = {_RANDOM[4'h9][31:12], _RANDOM[4'hA], _RANDOM[4'hB][11:0]};	// issue-slot.scala:102:25
        slot_uop_bypassable = _RANDOM[4'hB][12];	// issue-slot.scala:102:25
        slot_uop_mem_cmd = _RANDOM[4'hB][17:13];	// issue-slot.scala:102:25
        slot_uop_mem_size = _RANDOM[4'hB][19:18];	// issue-slot.scala:102:25
        slot_uop_mem_signed = _RANDOM[4'hB][20];	// issue-slot.scala:102:25
        slot_uop_is_fence = _RANDOM[4'hB][21];	// issue-slot.scala:102:25
        slot_uop_is_fencei = _RANDOM[4'hB][22];	// issue-slot.scala:102:25
        slot_uop_is_amo = _RANDOM[4'hB][23];	// issue-slot.scala:102:25
        slot_uop_uses_ldq = _RANDOM[4'hB][24];	// issue-slot.scala:102:25
        slot_uop_uses_stq = _RANDOM[4'hB][25];	// issue-slot.scala:102:25
        slot_uop_is_sys_pc2epc = _RANDOM[4'hB][26];	// issue-slot.scala:102:25
        slot_uop_is_unique = _RANDOM[4'hB][27];	// issue-slot.scala:102:25
        slot_uop_flush_on_commit = _RANDOM[4'hB][28];	// issue-slot.scala:102:25
        slot_uop_ldst_is_rs1 = _RANDOM[4'hB][29];	// issue-slot.scala:102:25
        slot_uop_ldst = {_RANDOM[4'hB][31:30], _RANDOM[4'hC][3:0]};	// issue-slot.scala:102:25
        slot_uop_lrs1 = _RANDOM[4'hC][9:4];	// issue-slot.scala:102:25
        slot_uop_lrs2 = _RANDOM[4'hC][15:10];	// issue-slot.scala:102:25
        slot_uop_lrs3 = _RANDOM[4'hC][21:16];	// issue-slot.scala:102:25
        slot_uop_ldst_val = _RANDOM[4'hC][22];	// issue-slot.scala:102:25
        slot_uop_dst_rtype = _RANDOM[4'hC][24:23];	// issue-slot.scala:102:25
        slot_uop_lrs1_rtype = _RANDOM[4'hC][26:25];	// issue-slot.scala:102:25
        slot_uop_lrs2_rtype = _RANDOM[4'hC][28:27];	// issue-slot.scala:102:25
        slot_uop_frs3_en = _RANDOM[4'hC][29];	// issue-slot.scala:102:25
        slot_uop_fp_val = _RANDOM[4'hC][30];	// issue-slot.scala:102:25
        slot_uop_fp_single = _RANDOM[4'hC][31];	// issue-slot.scala:102:25
        slot_uop_xcpt_pf_if = _RANDOM[4'hD][0];	// issue-slot.scala:102:25
        slot_uop_xcpt_ae_if = _RANDOM[4'hD][1];	// issue-slot.scala:102:25
        slot_uop_xcpt_ma_if = _RANDOM[4'hD][2];	// issue-slot.scala:102:25
        slot_uop_bp_debug_if = _RANDOM[4'hD][3];	// issue-slot.scala:102:25
        slot_uop_bp_xcpt_if = _RANDOM[4'hD][4];	// issue-slot.scala:102:25
        slot_uop_debug_fsrc = _RANDOM[4'hD][6:5];	// issue-slot.scala:102:25
        slot_uop_debug_tsrc = _RANDOM[4'hD][8:7];	// issue-slot.scala:102:25
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_valid = |state;	// issue-slot.scala:79:24, :86:22
  assign io_will_be_valid =
    (|state) & ~(io_grant & (_may_vacate_T | _may_vacate_T_1 & p1 & p2 & ppred));	// issue-slot.scala:79:24, :86:22, :87:22, :88:22, :90:22, :245:15, :260:{29,55,65,92}, :262:{32,35}
  assign io_request =
    _may_vacate_T ? p1 & p2 & p3 & ppred & ~io_kill : _GEN & (p1 | p2) & ppred & ~io_kill;	// issue-slot.scala:87:22, :88:22, :89:22, :90:22, :134:25, :241:56, :245:{15,30}, :246:{16,43}, :247:37, :248:{16,23}, :250:16
  assign io_out_uop_uopc = _GEN_4 ? slot_uop_uopc : 7'h3;	// issue-slot.scala:102:25, :131:18, :134:63, :139:51, :143:23
  assign io_out_uop_inst = slot_uop_inst;	// issue-slot.scala:102:25
  assign io_out_uop_debug_inst = slot_uop_debug_inst;	// issue-slot.scala:102:25
  assign io_out_uop_is_rvc = slot_uop_is_rvc;	// issue-slot.scala:102:25
  assign io_out_uop_debug_pc = slot_uop_debug_pc;	// issue-slot.scala:102:25
  assign io_out_uop_iq_type = slot_uop_iq_type;	// issue-slot.scala:102:25
  assign io_out_uop_fu_code = slot_uop_fu_code;	// issue-slot.scala:102:25
  assign io_out_uop_iw_state = _GEN_6 ? 2'h0 : _GEN_0 ? 2'h1 : state;	// issue-slot.scala:86:22, :126:14, :131:18, :132:16, :133:36, :134:{15,63}, :136:62, :137:18, :139:51, :140:62, :141:18, :231:50, :232:16
  assign io_out_uop_is_br = slot_uop_is_br;	// issue-slot.scala:102:25
  assign io_out_uop_is_jalr = slot_uop_is_jalr;	// issue-slot.scala:102:25
  assign io_out_uop_is_jal = slot_uop_is_jal;	// issue-slot.scala:102:25
  assign io_out_uop_is_sfb = slot_uop_is_sfb;	// issue-slot.scala:102:25
  assign io_out_uop_br_mask = next_br_mask;	// util.scala:85:25
  assign io_out_uop_br_tag = slot_uop_br_tag;	// issue-slot.scala:102:25
  assign io_out_uop_ftq_idx = slot_uop_ftq_idx;	// issue-slot.scala:102:25
  assign io_out_uop_edge_inst = slot_uop_edge_inst;	// issue-slot.scala:102:25
  assign io_out_uop_pc_lob = slot_uop_pc_lob;	// issue-slot.scala:102:25
  assign io_out_uop_taken = slot_uop_taken;	// issue-slot.scala:102:25
  assign io_out_uop_imm_packed = slot_uop_imm_packed;	// issue-slot.scala:102:25
  assign io_out_uop_csr_addr = slot_uop_csr_addr;	// issue-slot.scala:102:25
  assign io_out_uop_rob_idx = slot_uop_rob_idx;	// issue-slot.scala:102:25
  assign io_out_uop_ldq_idx = slot_uop_ldq_idx;	// issue-slot.scala:102:25
  assign io_out_uop_stq_idx = slot_uop_stq_idx;	// issue-slot.scala:102:25
  assign io_out_uop_rxq_idx = slot_uop_rxq_idx;	// issue-slot.scala:102:25
  assign io_out_uop_pdst = slot_uop_pdst;	// issue-slot.scala:102:25
  assign io_out_uop_prs1 = slot_uop_prs1;	// issue-slot.scala:102:25
  assign io_out_uop_prs2 = slot_uop_prs2;	// issue-slot.scala:102:25
  assign io_out_uop_prs3 = slot_uop_prs3;	// issue-slot.scala:102:25
  assign io_out_uop_ppred = slot_uop_ppred;	// issue-slot.scala:102:25
  assign io_out_uop_prs1_busy = ~p1;	// issue-slot.scala:87:22, :270:28
  assign io_out_uop_prs2_busy = ~p2;	// issue-slot.scala:88:22, :271:28
  assign io_out_uop_prs3_busy = ~p3;	// issue-slot.scala:89:22, :272:28
  assign io_out_uop_ppred_busy = ~ppred;	// issue-slot.scala:90:22, :273:28
  assign io_out_uop_stale_pdst = slot_uop_stale_pdst;	// issue-slot.scala:102:25
  assign io_out_uop_exception = slot_uop_exception;	// issue-slot.scala:102:25
  assign io_out_uop_exc_cause = slot_uop_exc_cause;	// issue-slot.scala:102:25
  assign io_out_uop_bypassable = slot_uop_bypassable;	// issue-slot.scala:102:25
  assign io_out_uop_mem_cmd = slot_uop_mem_cmd;	// issue-slot.scala:102:25
  assign io_out_uop_mem_size = slot_uop_mem_size;	// issue-slot.scala:102:25
  assign io_out_uop_mem_signed = slot_uop_mem_signed;	// issue-slot.scala:102:25
  assign io_out_uop_is_fence = slot_uop_is_fence;	// issue-slot.scala:102:25
  assign io_out_uop_is_fencei = slot_uop_is_fencei;	// issue-slot.scala:102:25
  assign io_out_uop_is_amo = slot_uop_is_amo;	// issue-slot.scala:102:25
  assign io_out_uop_uses_ldq = slot_uop_uses_ldq;	// issue-slot.scala:102:25
  assign io_out_uop_uses_stq = slot_uop_uses_stq;	// issue-slot.scala:102:25
  assign io_out_uop_is_sys_pc2epc = slot_uop_is_sys_pc2epc;	// issue-slot.scala:102:25
  assign io_out_uop_is_unique = slot_uop_is_unique;	// issue-slot.scala:102:25
  assign io_out_uop_flush_on_commit = slot_uop_flush_on_commit;	// issue-slot.scala:102:25
  assign io_out_uop_ldst_is_rs1 = slot_uop_ldst_is_rs1;	// issue-slot.scala:102:25
  assign io_out_uop_ldst = slot_uop_ldst;	// issue-slot.scala:102:25
  assign io_out_uop_lrs1 = slot_uop_lrs1;	// issue-slot.scala:102:25
  assign io_out_uop_lrs2 = slot_uop_lrs2;	// issue-slot.scala:102:25
  assign io_out_uop_lrs3 = slot_uop_lrs3;	// issue-slot.scala:102:25
  assign io_out_uop_ldst_val = slot_uop_ldst_val;	// issue-slot.scala:102:25
  assign io_out_uop_dst_rtype = slot_uop_dst_rtype;	// issue-slot.scala:102:25
  assign io_out_uop_lrs1_rtype = _GEN_4 ? slot_uop_lrs1_rtype : 2'h2;	// consts.scala:277:20, issue-slot.scala:102:25, :131:18, :134:63, :139:51
  assign io_out_uop_lrs2_rtype = _GEN_5 ? slot_uop_lrs2_rtype : 2'h2;	// consts.scala:277:20, issue-slot.scala:102:25, :131:18, :134:63, :139:51
  assign io_out_uop_frs3_en = slot_uop_frs3_en;	// issue-slot.scala:102:25
  assign io_out_uop_fp_val = slot_uop_fp_val;	// issue-slot.scala:102:25
  assign io_out_uop_fp_single = slot_uop_fp_single;	// issue-slot.scala:102:25
  assign io_out_uop_xcpt_pf_if = slot_uop_xcpt_pf_if;	// issue-slot.scala:102:25
  assign io_out_uop_xcpt_ae_if = slot_uop_xcpt_ae_if;	// issue-slot.scala:102:25
  assign io_out_uop_xcpt_ma_if = slot_uop_xcpt_ma_if;	// issue-slot.scala:102:25
  assign io_out_uop_bp_debug_if = slot_uop_bp_debug_if;	// issue-slot.scala:102:25
  assign io_out_uop_bp_xcpt_if = slot_uop_bp_xcpt_if;	// issue-slot.scala:102:25
  assign io_out_uop_debug_fsrc = slot_uop_debug_fsrc;	// issue-slot.scala:102:25
  assign io_out_uop_debug_tsrc = slot_uop_debug_tsrc;	// issue-slot.scala:102:25
  assign io_uop_uopc = _GEN_9 ? slot_uop_uopc : 7'h3;	// issue-slot.scala:102:25, :143:23, :255:10, :277:30, :278:30
  assign io_uop_inst = slot_uop_inst;	// issue-slot.scala:102:25
  assign io_uop_debug_inst = slot_uop_debug_inst;	// issue-slot.scala:102:25
  assign io_uop_is_rvc = slot_uop_is_rvc;	// issue-slot.scala:102:25
  assign io_uop_debug_pc = slot_uop_debug_pc;	// issue-slot.scala:102:25
  assign io_uop_iq_type = slot_uop_iq_type;	// issue-slot.scala:102:25
  assign io_uop_fu_code = slot_uop_fu_code;	// issue-slot.scala:102:25
  assign io_uop_iw_state = slot_uop_iw_state;	// issue-slot.scala:102:25
  assign io_uop_is_br = slot_uop_is_br;	// issue-slot.scala:102:25
  assign io_uop_is_jalr = slot_uop_is_jalr;	// issue-slot.scala:102:25
  assign io_uop_is_jal = slot_uop_is_jal;	// issue-slot.scala:102:25
  assign io_uop_is_sfb = slot_uop_is_sfb;	// issue-slot.scala:102:25
  assign io_uop_br_mask = slot_uop_br_mask;	// issue-slot.scala:102:25
  assign io_uop_br_tag = slot_uop_br_tag;	// issue-slot.scala:102:25
  assign io_uop_ftq_idx = slot_uop_ftq_idx;	// issue-slot.scala:102:25
  assign io_uop_edge_inst = slot_uop_edge_inst;	// issue-slot.scala:102:25
  assign io_uop_pc_lob = slot_uop_pc_lob;	// issue-slot.scala:102:25
  assign io_uop_taken = slot_uop_taken;	// issue-slot.scala:102:25
  assign io_uop_imm_packed = slot_uop_imm_packed;	// issue-slot.scala:102:25
  assign io_uop_csr_addr = slot_uop_csr_addr;	// issue-slot.scala:102:25
  assign io_uop_rob_idx = slot_uop_rob_idx;	// issue-slot.scala:102:25
  assign io_uop_ldq_idx = slot_uop_ldq_idx;	// issue-slot.scala:102:25
  assign io_uop_stq_idx = slot_uop_stq_idx;	// issue-slot.scala:102:25
  assign io_uop_rxq_idx = slot_uop_rxq_idx;	// issue-slot.scala:102:25
  assign io_uop_pdst = slot_uop_pdst;	// issue-slot.scala:102:25
  assign io_uop_prs1 = slot_uop_prs1;	// issue-slot.scala:102:25
  assign io_uop_prs2 = slot_uop_prs2;	// issue-slot.scala:102:25
  assign io_uop_prs3 = slot_uop_prs3;	// issue-slot.scala:102:25
  assign io_uop_ppred = slot_uop_ppred;	// issue-slot.scala:102:25
  assign io_uop_prs1_busy = slot_uop_prs1_busy;	// issue-slot.scala:102:25
  assign io_uop_prs2_busy = slot_uop_prs2_busy;	// issue-slot.scala:102:25
  assign io_uop_prs3_busy = slot_uop_prs3_busy;	// issue-slot.scala:102:25
  assign io_uop_ppred_busy = slot_uop_ppred_busy;	// issue-slot.scala:102:25
  assign io_uop_stale_pdst = slot_uop_stale_pdst;	// issue-slot.scala:102:25
  assign io_uop_exception = slot_uop_exception;	// issue-slot.scala:102:25
  assign io_uop_exc_cause = slot_uop_exc_cause;	// issue-slot.scala:102:25
  assign io_uop_bypassable = slot_uop_bypassable;	// issue-slot.scala:102:25
  assign io_uop_mem_cmd = slot_uop_mem_cmd;	// issue-slot.scala:102:25
  assign io_uop_mem_size = slot_uop_mem_size;	// issue-slot.scala:102:25
  assign io_uop_mem_signed = slot_uop_mem_signed;	// issue-slot.scala:102:25
  assign io_uop_is_fence = slot_uop_is_fence;	// issue-slot.scala:102:25
  assign io_uop_is_fencei = slot_uop_is_fencei;	// issue-slot.scala:102:25
  assign io_uop_is_amo = slot_uop_is_amo;	// issue-slot.scala:102:25
  assign io_uop_uses_ldq = slot_uop_uses_ldq;	// issue-slot.scala:102:25
  assign io_uop_uses_stq = slot_uop_uses_stq;	// issue-slot.scala:102:25
  assign io_uop_is_sys_pc2epc = slot_uop_is_sys_pc2epc;	// issue-slot.scala:102:25
  assign io_uop_is_unique = slot_uop_is_unique;	// issue-slot.scala:102:25
  assign io_uop_flush_on_commit = slot_uop_flush_on_commit;	// issue-slot.scala:102:25
  assign io_uop_ldst_is_rs1 = slot_uop_ldst_is_rs1;	// issue-slot.scala:102:25
  assign io_uop_ldst = slot_uop_ldst;	// issue-slot.scala:102:25
  assign io_uop_lrs1 = slot_uop_lrs1;	// issue-slot.scala:102:25
  assign io_uop_lrs2 = slot_uop_lrs2;	// issue-slot.scala:102:25
  assign io_uop_lrs3 = slot_uop_lrs3;	// issue-slot.scala:102:25
  assign io_uop_ldst_val = slot_uop_ldst_val;	// issue-slot.scala:102:25
  assign io_uop_dst_rtype = slot_uop_dst_rtype;	// issue-slot.scala:102:25
  assign io_uop_lrs1_rtype = _GEN_9 ? slot_uop_lrs1_rtype : 2'h2;	// consts.scala:277:20, issue-slot.scala:102:25, :255:10, :277:30, :278:30
  assign io_uop_lrs2_rtype =
    ~_may_vacate_T_1 | _GEN_7 | ~_GEN_8 ? slot_uop_lrs2_rtype : 2'h2;	// consts.scala:277:20, issue-slot.scala:102:25, :255:10, :260:65, :277:30, :278:{20,30}, :280:{21,31}
  assign io_uop_frs3_en = slot_uop_frs3_en;	// issue-slot.scala:102:25
  assign io_uop_fp_val = slot_uop_fp_val;	// issue-slot.scala:102:25
  assign io_uop_fp_single = slot_uop_fp_single;	// issue-slot.scala:102:25
  assign io_uop_xcpt_pf_if = slot_uop_xcpt_pf_if;	// issue-slot.scala:102:25
  assign io_uop_xcpt_ae_if = slot_uop_xcpt_ae_if;	// issue-slot.scala:102:25
  assign io_uop_xcpt_ma_if = slot_uop_xcpt_ma_if;	// issue-slot.scala:102:25
  assign io_uop_bp_debug_if = slot_uop_bp_debug_if;	// issue-slot.scala:102:25
  assign io_uop_bp_xcpt_if = slot_uop_bp_xcpt_if;	// issue-slot.scala:102:25
  assign io_uop_debug_fsrc = slot_uop_debug_fsrc;	// issue-slot.scala:102:25
  assign io_uop_debug_tsrc = slot_uop_debug_tsrc;	// issue-slot.scala:102:25
endmodule

