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

module BranchKillableQueue_19(
  input         clock,
                reset,
                io_enq_valid,
  input  [6:0]  io_enq_bits_uop_uopc,
  input  [31:0] io_enq_bits_uop_inst,
                io_enq_bits_uop_debug_inst,
  input         io_enq_bits_uop_is_rvc,
  input  [39:0] io_enq_bits_uop_debug_pc,
  input  [2:0]  io_enq_bits_uop_iq_type,
  input  [9:0]  io_enq_bits_uop_fu_code,
  input  [3:0]  io_enq_bits_uop_ctrl_br_type,
  input  [1:0]  io_enq_bits_uop_ctrl_op1_sel,
  input  [2:0]  io_enq_bits_uop_ctrl_op2_sel,
                io_enq_bits_uop_ctrl_imm_sel,
  input  [3:0]  io_enq_bits_uop_ctrl_op_fcn,
  input         io_enq_bits_uop_ctrl_fcn_dw,
  input  [2:0]  io_enq_bits_uop_ctrl_csr_cmd,
  input         io_enq_bits_uop_ctrl_is_load,
                io_enq_bits_uop_ctrl_is_sta,
                io_enq_bits_uop_ctrl_is_std,
  input  [1:0]  io_enq_bits_uop_iw_state,
  input         io_enq_bits_uop_iw_p1_poisoned,
                io_enq_bits_uop_iw_p2_poisoned,
                io_enq_bits_uop_is_br,
                io_enq_bits_uop_is_jalr,
                io_enq_bits_uop_is_jal,
                io_enq_bits_uop_is_sfb,
  input  [15:0] io_enq_bits_uop_br_mask,
  input  [3:0]  io_enq_bits_uop_br_tag,
  input  [4:0]  io_enq_bits_uop_ftq_idx,
  input         io_enq_bits_uop_edge_inst,
  input  [5:0]  io_enq_bits_uop_pc_lob,
  input         io_enq_bits_uop_taken,
  input  [19:0] io_enq_bits_uop_imm_packed,
  input  [11:0] io_enq_bits_uop_csr_addr,
  input  [6:0]  io_enq_bits_uop_rob_idx,
  input  [4:0]  io_enq_bits_uop_ldq_idx,
                io_enq_bits_uop_stq_idx,
  input  [1:0]  io_enq_bits_uop_rxq_idx,
  input  [6:0]  io_enq_bits_uop_pdst,
                io_enq_bits_uop_prs1,
                io_enq_bits_uop_prs2,
                io_enq_bits_uop_prs3,
  input  [4:0]  io_enq_bits_uop_ppred,
  input         io_enq_bits_uop_prs1_busy,
                io_enq_bits_uop_prs2_busy,
                io_enq_bits_uop_prs3_busy,
                io_enq_bits_uop_ppred_busy,
  input  [6:0]  io_enq_bits_uop_stale_pdst,
  input         io_enq_bits_uop_exception,
  input  [63:0] io_enq_bits_uop_exc_cause,
  input         io_enq_bits_uop_bypassable,
  input  [4:0]  io_enq_bits_uop_mem_cmd,
  input  [1:0]  io_enq_bits_uop_mem_size,
  input         io_enq_bits_uop_mem_signed,
                io_enq_bits_uop_is_fence,
                io_enq_bits_uop_is_fencei,
                io_enq_bits_uop_is_amo,
                io_enq_bits_uop_uses_ldq,
                io_enq_bits_uop_uses_stq,
                io_enq_bits_uop_is_sys_pc2epc,
                io_enq_bits_uop_is_unique,
                io_enq_bits_uop_flush_on_commit,
                io_enq_bits_uop_ldst_is_rs1,
  input  [5:0]  io_enq_bits_uop_ldst,
                io_enq_bits_uop_lrs1,
                io_enq_bits_uop_lrs2,
                io_enq_bits_uop_lrs3,
  input         io_enq_bits_uop_ldst_val,
  input  [1:0]  io_enq_bits_uop_dst_rtype,
                io_enq_bits_uop_lrs1_rtype,
                io_enq_bits_uop_lrs2_rtype,
  input         io_enq_bits_uop_frs3_en,
                io_enq_bits_uop_fp_val,
                io_enq_bits_uop_fp_single,
                io_enq_bits_uop_xcpt_pf_if,
                io_enq_bits_uop_xcpt_ae_if,
                io_enq_bits_uop_xcpt_ma_if,
                io_enq_bits_uop_bp_debug_if,
                io_enq_bits_uop_bp_xcpt_if,
  input  [1:0]  io_enq_bits_uop_debug_fsrc,
                io_enq_bits_uop_debug_tsrc,
  input  [64:0] io_enq_bits_data,
  input         io_deq_ready,
  input  [15:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  input         io_flush,
  output        io_enq_ready,
                io_deq_valid,
  output [6:0]  io_deq_bits_uop_uopc,
  output [15:0] io_deq_bits_uop_br_mask,
  output [6:0]  io_deq_bits_uop_rob_idx,
  output [4:0]  io_deq_bits_uop_stq_idx,
  output [6:0]  io_deq_bits_uop_pdst,
  output        io_deq_bits_uop_is_amo,
                io_deq_bits_uop_uses_stq,
  output [1:0]  io_deq_bits_uop_dst_rtype,
  output        io_deq_bits_uop_fp_val,
  output [64:0] io_deq_bits_data,
  output        io_deq_bits_predicated,
                io_deq_bits_fflags_valid,
  output [6:0]  io_deq_bits_fflags_bits_uop_rob_idx,
  output [4:0]  io_deq_bits_fflags_bits_flags,
  output        io_empty
);

  wire [78:0]      _ram_ext_R0_data;	// util.scala:464:20
  reg              valids_0;	// util.scala:465:24
  reg              valids_1;	// util.scala:465:24
  reg              valids_2;	// util.scala:465:24
  reg  [6:0]       uops_0_uopc;	// util.scala:466:20
  reg  [15:0]      uops_0_br_mask;	// util.scala:466:20
  reg  [6:0]       uops_0_rob_idx;	// util.scala:466:20
  reg  [4:0]       uops_0_stq_idx;	// util.scala:466:20
  reg  [6:0]       uops_0_pdst;	// util.scala:466:20
  reg              uops_0_is_amo;	// util.scala:466:20
  reg              uops_0_uses_stq;	// util.scala:466:20
  reg  [1:0]       uops_0_dst_rtype;	// util.scala:466:20
  reg              uops_0_fp_val;	// util.scala:466:20
  reg  [6:0]       uops_1_uopc;	// util.scala:466:20
  reg  [15:0]      uops_1_br_mask;	// util.scala:466:20
  reg  [6:0]       uops_1_rob_idx;	// util.scala:466:20
  reg  [4:0]       uops_1_stq_idx;	// util.scala:466:20
  reg  [6:0]       uops_1_pdst;	// util.scala:466:20
  reg              uops_1_is_amo;	// util.scala:466:20
  reg              uops_1_uses_stq;	// util.scala:466:20
  reg  [1:0]       uops_1_dst_rtype;	// util.scala:466:20
  reg              uops_1_fp_val;	// util.scala:466:20
  reg  [6:0]       uops_2_uopc;	// util.scala:466:20
  reg  [15:0]      uops_2_br_mask;	// util.scala:466:20
  reg  [6:0]       uops_2_rob_idx;	// util.scala:466:20
  reg  [4:0]       uops_2_stq_idx;	// util.scala:466:20
  reg  [6:0]       uops_2_pdst;	// util.scala:466:20
  reg              uops_2_is_amo;	// util.scala:466:20
  reg              uops_2_uses_stq;	// util.scala:466:20
  reg  [1:0]       uops_2_dst_rtype;	// util.scala:466:20
  reg              uops_2_fp_val;	// util.scala:466:20
  reg  [1:0]       value;	// Counter.scala:60:40
  reg  [1:0]       value_1;	// Counter.scala:60:40
  reg              maybe_full;	// util.scala:470:27
  wire             ptr_match = value == value_1;	// Counter.scala:60:40, util.scala:472:33
  wire             _io_empty_output = ptr_match & ~maybe_full;	// util.scala:470:27, :472:33, :473:{25,28}
  wire             full = ptr_match & maybe_full;	// util.scala:470:27, :472:33, :474:24
  wire [3:0]       _GEN = {{valids_0}, {valids_2}, {valids_1}, {valids_0}};	// util.scala:465:24, :476:42
  wire             _GEN_0 = _GEN[value_1];	// Counter.scala:60:40, util.scala:476:42
  wire [3:0][6:0]  _GEN_1 = {{uops_0_uopc}, {uops_2_uopc}, {uops_1_uopc}, {uops_0_uopc}};	// util.scala:466:20, :508:19
  wire [3:0][15:0] _GEN_2 =
    {{uops_0_br_mask}, {uops_2_br_mask}, {uops_1_br_mask}, {uops_0_br_mask}};	// util.scala:466:20, :508:19
  wire [15:0]      out_uop_br_mask = _GEN_2[value_1];	// Counter.scala:60:40, util.scala:508:19
  wire [3:0][6:0]  _GEN_3 =
    {{uops_0_rob_idx}, {uops_2_rob_idx}, {uops_1_rob_idx}, {uops_0_rob_idx}};	// util.scala:466:20, :508:19
  wire [3:0][4:0]  _GEN_4 =
    {{uops_0_stq_idx}, {uops_2_stq_idx}, {uops_1_stq_idx}, {uops_0_stq_idx}};	// util.scala:466:20, :508:19
  wire [3:0][6:0]  _GEN_5 = {{uops_0_pdst}, {uops_2_pdst}, {uops_1_pdst}, {uops_0_pdst}};	// util.scala:466:20, :508:19
  wire [3:0]       _GEN_6 =
    {{uops_0_is_amo}, {uops_2_is_amo}, {uops_1_is_amo}, {uops_0_is_amo}};	// util.scala:466:20, :508:19
  wire [3:0]       _GEN_7 =
    {{uops_0_uses_stq}, {uops_2_uses_stq}, {uops_1_uses_stq}, {uops_0_uses_stq}};	// util.scala:466:20, :508:19
  wire [3:0][1:0]  _GEN_8 =
    {{uops_0_dst_rtype}, {uops_2_dst_rtype}, {uops_1_dst_rtype}, {uops_0_dst_rtype}};	// util.scala:466:20, :508:19
  wire [3:0]       _GEN_9 =
    {{uops_0_fp_val}, {uops_2_fp_val}, {uops_1_fp_val}, {uops_0_fp_val}};	// util.scala:466:20, :508:19
  wire             do_deq =
    ~_io_empty_output & (io_deq_ready | ~_GEN_0) & ~_io_empty_output;	// util.scala:473:25, :476:{39,42,69}, :510:27, :515:21, :517:19, :520:14
  wire             do_enq = ~(_io_empty_output & io_deq_ready) & ~full & io_enq_valid;	// util.scala:473:25, :474:24, :504:19, :515:21, :521:{27,36}
  always @(posedge clock) begin
    automatic logic        _GEN_10;	// util.scala:489:33
    automatic logic        _GEN_11;	// util.scala:481:16, :487:17, :489:33
    automatic logic        _GEN_12;	// util.scala:489:33
    automatic logic        _GEN_13;	// util.scala:481:16, :487:17, :489:33
    automatic logic        _GEN_14;	// util.scala:489:33
    automatic logic        _GEN_15;	// util.scala:481:16, :487:17, :489:33
    automatic logic [15:0] _uops_br_mask_T_1;	// util.scala:85:25
    _GEN_10 = value == 2'h0;	// Counter.scala:60:40, util.scala:489:33
    _GEN_11 = do_enq & _GEN_10;	// util.scala:481:16, :487:17, :489:33, :515:21, :521:{27,36}
    _GEN_12 = value == 2'h1;	// Counter.scala:60:40, util.scala:489:33
    _GEN_13 = do_enq & _GEN_12;	// util.scala:481:16, :487:17, :489:33, :515:21, :521:{27,36}
    _GEN_14 = value == 2'h2;	// Counter.scala:60:40, :72:24, util.scala:489:33
    _GEN_15 = do_enq & _GEN_14;	// util.scala:481:16, :487:17, :489:33, :515:21, :521:{27,36}
    _uops_br_mask_T_1 = io_enq_bits_uop_br_mask & ~io_brupdate_b1_resolve_mask;	// util.scala:85:{25,27}
    if (reset) begin
      valids_0 <= 1'h0;	// util.scala:465:24
      valids_1 <= 1'h0;	// util.scala:465:24
      valids_2 <= 1'h0;	// util.scala:465:24
      value <= 2'h0;	// Counter.scala:60:40
      value_1 <= 2'h0;	// Counter.scala:60:40
      maybe_full <= 1'h0;	// util.scala:470:27
    end
    else begin
      valids_0 <=
        ~(do_deq & value_1 == 2'h0)
        & (_GEN_11 | valids_0 & (io_brupdate_b1_mispredict_mask & uops_0_br_mask) == 16'h0
           & ~io_flush);	// Counter.scala:60:40, util.scala:118:{51,59}, :465:24, :466:20, :481:{16,69,72}, :487:17, :489:33, :495:17, :496:27, :515:21, :520:14
      valids_1 <=
        ~(do_deq & value_1 == 2'h1)
        & (_GEN_13 | valids_1 & (io_brupdate_b1_mispredict_mask & uops_1_br_mask) == 16'h0
           & ~io_flush);	// Counter.scala:60:40, util.scala:118:{51,59}, :465:24, :466:20, :481:{16,69,72}, :487:17, :489:33, :495:17, :496:27, :515:21, :520:14
      valids_2 <=
        ~(do_deq & value_1 == 2'h2)
        & (_GEN_15 | valids_2 & (io_brupdate_b1_mispredict_mask & uops_2_br_mask) == 16'h0
           & ~io_flush);	// Counter.scala:60:40, :72:24, util.scala:118:{51,59}, :465:24, :466:20, :481:{16,69,72}, :487:17, :489:33, :495:17, :496:27, :515:21, :520:14
      if (do_enq) begin	// util.scala:515:21, :521:{27,36}
        if (value == 2'h2)	// Counter.scala:60:40, :72:24
          value <= 2'h0;	// Counter.scala:60:40
        else	// Counter.scala:72:24
          value <= value + 2'h1;	// Counter.scala:60:40, :76:24, util.scala:489:33
      end
      if (do_deq) begin	// util.scala:515:21, :520:14
        if (value_1 == 2'h2)	// Counter.scala:60:40, :72:24
          value_1 <= 2'h0;	// Counter.scala:60:40
        else	// Counter.scala:72:24
          value_1 <= value_1 + 2'h1;	// Counter.scala:60:40, :76:24, util.scala:489:33
      end
      if (do_enq != do_deq)	// util.scala:500:16, :515:21, :520:14, :521:{27,36}
        maybe_full <= do_enq;	// util.scala:470:27, :515:21, :521:{27,36}
    end
    if (_GEN_11) begin	// util.scala:481:16, :487:17, :489:33
      uops_0_uopc <= io_enq_bits_uop_uopc;	// util.scala:466:20
      uops_0_rob_idx <= io_enq_bits_uop_rob_idx;	// util.scala:466:20
      uops_0_stq_idx <= io_enq_bits_uop_stq_idx;	// util.scala:466:20
      uops_0_pdst <= io_enq_bits_uop_pdst;	// util.scala:466:20
      uops_0_is_amo <= io_enq_bits_uop_is_amo;	// util.scala:466:20
      uops_0_uses_stq <= io_enq_bits_uop_uses_stq;	// util.scala:466:20
      uops_0_dst_rtype <= io_enq_bits_uop_dst_rtype;	// util.scala:466:20
      uops_0_fp_val <= io_enq_bits_uop_fp_val;	// util.scala:466:20
    end
    if (do_enq & _GEN_10)	// util.scala:482:22, :487:17, :489:33, :491:33, :515:21, :521:{27,36}
      uops_0_br_mask <= _uops_br_mask_T_1;	// util.scala:85:25, :466:20
    else	// util.scala:482:22, :487:17, :491:33
      uops_0_br_mask <= ({16{~valids_0}} | ~io_brupdate_b1_resolve_mask) & uops_0_br_mask;	// util.scala:89:23, :465:24, :466:20, :482:22, :483:23
    if (_GEN_13) begin	// util.scala:481:16, :487:17, :489:33
      uops_1_uopc <= io_enq_bits_uop_uopc;	// util.scala:466:20
      uops_1_rob_idx <= io_enq_bits_uop_rob_idx;	// util.scala:466:20
      uops_1_stq_idx <= io_enq_bits_uop_stq_idx;	// util.scala:466:20
      uops_1_pdst <= io_enq_bits_uop_pdst;	// util.scala:466:20
      uops_1_is_amo <= io_enq_bits_uop_is_amo;	// util.scala:466:20
      uops_1_uses_stq <= io_enq_bits_uop_uses_stq;	// util.scala:466:20
      uops_1_dst_rtype <= io_enq_bits_uop_dst_rtype;	// util.scala:466:20
      uops_1_fp_val <= io_enq_bits_uop_fp_val;	// util.scala:466:20
    end
    if (do_enq & _GEN_12)	// util.scala:482:22, :487:17, :489:33, :491:33, :515:21, :521:{27,36}
      uops_1_br_mask <= _uops_br_mask_T_1;	// util.scala:85:25, :466:20
    else	// util.scala:482:22, :487:17, :491:33
      uops_1_br_mask <= ({16{~valids_1}} | ~io_brupdate_b1_resolve_mask) & uops_1_br_mask;	// util.scala:89:23, :465:24, :466:20, :482:22, :483:23
    if (_GEN_15) begin	// util.scala:481:16, :487:17, :489:33
      uops_2_uopc <= io_enq_bits_uop_uopc;	// util.scala:466:20
      uops_2_rob_idx <= io_enq_bits_uop_rob_idx;	// util.scala:466:20
      uops_2_stq_idx <= io_enq_bits_uop_stq_idx;	// util.scala:466:20
      uops_2_pdst <= io_enq_bits_uop_pdst;	// util.scala:466:20
      uops_2_is_amo <= io_enq_bits_uop_is_amo;	// util.scala:466:20
      uops_2_uses_stq <= io_enq_bits_uop_uses_stq;	// util.scala:466:20
      uops_2_dst_rtype <= io_enq_bits_uop_dst_rtype;	// util.scala:466:20
      uops_2_fp_val <= io_enq_bits_uop_fp_val;	// util.scala:466:20
    end
    if (do_enq & _GEN_14)	// util.scala:482:22, :487:17, :489:33, :491:33, :515:21, :521:{27,36}
      uops_2_br_mask <= _uops_br_mask_T_1;	// util.scala:85:25, :466:20
    else	// util.scala:482:22, :487:17, :491:33
      uops_2_br_mask <= ({16{~valids_2}} | ~io_brupdate_b1_resolve_mask) & uops_2_br_mask;	// util.scala:89:23, :465:24, :466:20, :482:22, :483:23
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:38];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [5:0] i = 6'h0; i < 6'h27; i += 6'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        valids_0 = _RANDOM[6'h0][0];	// util.scala:465:24
        valids_1 = _RANDOM[6'h0][1];	// util.scala:465:24
        valids_2 = _RANDOM[6'h0][2];	// util.scala:465:24
        uops_0_uopc = _RANDOM[6'h0][9:3];	// util.scala:465:24, :466:20
        uops_0_br_mask = {_RANDOM[6'h4][31], _RANDOM[6'h5][14:0]};	// util.scala:466:20
        uops_0_rob_idx = _RANDOM[6'h7][6:0];	// util.scala:466:20
        uops_0_stq_idx = _RANDOM[6'h7][16:12];	// util.scala:466:20
        uops_0_pdst = _RANDOM[6'h7][25:19];	// util.scala:466:20
        uops_0_is_amo = _RANDOM[6'hB][11];	// util.scala:466:20
        uops_0_uses_stq = _RANDOM[6'hB][13];	// util.scala:466:20
        uops_0_dst_rtype = _RANDOM[6'hC][12:11];	// util.scala:466:20
        uops_0_fp_val = _RANDOM[6'hC][18];	// util.scala:466:20
        uops_1_uopc = {_RANDOM[6'hC][31:29], _RANDOM[6'hD][3:0]};	// util.scala:466:20
        uops_1_br_mask = {_RANDOM[6'h11][31:25], _RANDOM[6'h12][8:0]};	// util.scala:466:20
        uops_1_rob_idx = {_RANDOM[6'h13][31:26], _RANDOM[6'h14][0]};	// util.scala:466:20
        uops_1_stq_idx = _RANDOM[6'h14][10:6];	// util.scala:466:20
        uops_1_pdst = _RANDOM[6'h14][19:13];	// util.scala:466:20
        uops_1_is_amo = _RANDOM[6'h18][5];	// util.scala:466:20
        uops_1_uses_stq = _RANDOM[6'h18][7];	// util.scala:466:20
        uops_1_dst_rtype = _RANDOM[6'h19][6:5];	// util.scala:466:20
        uops_1_fp_val = _RANDOM[6'h19][12];	// util.scala:466:20
        uops_2_uopc = _RANDOM[6'h19][29:23];	// util.scala:466:20
        uops_2_br_mask = {_RANDOM[6'h1E][31:19], _RANDOM[6'h1F][2:0]};	// util.scala:466:20
        uops_2_rob_idx = _RANDOM[6'h20][26:20];	// util.scala:466:20
        uops_2_stq_idx = _RANDOM[6'h21][4:0];	// util.scala:466:20
        uops_2_pdst = _RANDOM[6'h21][13:7];	// util.scala:466:20
        uops_2_is_amo = _RANDOM[6'h24][31];	// util.scala:466:20
        uops_2_uses_stq = _RANDOM[6'h25][1];	// util.scala:466:20
        uops_2_dst_rtype = {_RANDOM[6'h25][31], _RANDOM[6'h26][0]};	// util.scala:466:20
        uops_2_fp_val = _RANDOM[6'h26][6];	// util.scala:466:20
        value = _RANDOM[6'h26][18:17];	// Counter.scala:60:40, util.scala:466:20
        value_1 = _RANDOM[6'h26][20:19];	// Counter.scala:60:40, util.scala:466:20
        maybe_full = _RANDOM[6'h26][21];	// util.scala:466:20, :470:27
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  ram_3x79 ram_ext (	// util.scala:464:20
    .R0_addr (value_1),	// Counter.scala:60:40
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (value),	// Counter.scala:60:40
    .W0_en   (do_enq),	// util.scala:515:21, :521:{27,36}
    .W0_clk  (clock),
    .W0_data ({14'h0, io_enq_bits_data}),	// util.scala:464:20
    .R0_data (_ram_ext_R0_data)
  );
  assign io_enq_ready = ~full;	// util.scala:474:24, :504:19
  assign io_deq_valid =
    _io_empty_output
      ? io_enq_valid
      : ~_io_empty_output & _GEN_0
        & (io_brupdate_b1_mispredict_mask & out_uop_br_mask) == 16'h0 & ~io_flush;	// util.scala:118:{51,59}, :473:25, :476:{42,69}, :508:19, :509:{27,108,111}, :515:21, :516:20
  assign io_deq_bits_uop_uopc = _io_empty_output ? io_enq_bits_uop_uopc : _GEN_1[value_1];	// Counter.scala:60:40, util.scala:473:25, :508:19, :510:27, :515:21, :517:19
  assign io_deq_bits_uop_br_mask =
    _io_empty_output
      ? io_enq_bits_uop_br_mask & ~io_brupdate_b1_resolve_mask
      : out_uop_br_mask & ~io_brupdate_b1_resolve_mask;	// util.scala:85:{25,27}, :473:25, :508:19, :511:27, :515:21, :518:31
  assign io_deq_bits_uop_rob_idx =
    _io_empty_output ? io_enq_bits_uop_rob_idx : _GEN_3[value_1];	// Counter.scala:60:40, util.scala:473:25, :508:19, :510:27, :515:21, :517:19
  assign io_deq_bits_uop_stq_idx =
    _io_empty_output ? io_enq_bits_uop_stq_idx : _GEN_4[value_1];	// Counter.scala:60:40, util.scala:473:25, :508:19, :510:27, :515:21, :517:19
  assign io_deq_bits_uop_pdst = _io_empty_output ? io_enq_bits_uop_pdst : _GEN_5[value_1];	// Counter.scala:60:40, util.scala:473:25, :508:19, :510:27, :515:21, :517:19
  assign io_deq_bits_uop_is_amo =
    _io_empty_output ? io_enq_bits_uop_is_amo : _GEN_6[value_1];	// Counter.scala:60:40, util.scala:473:25, :508:19, :510:27, :515:21, :517:19
  assign io_deq_bits_uop_uses_stq =
    _io_empty_output ? io_enq_bits_uop_uses_stq : _GEN_7[value_1];	// Counter.scala:60:40, util.scala:473:25, :508:19, :510:27, :515:21, :517:19
  assign io_deq_bits_uop_dst_rtype =
    _io_empty_output ? io_enq_bits_uop_dst_rtype : _GEN_8[value_1];	// Counter.scala:60:40, util.scala:473:25, :508:19, :510:27, :515:21, :517:19
  assign io_deq_bits_uop_fp_val =
    _io_empty_output ? io_enq_bits_uop_fp_val : _GEN_9[value_1];	// Counter.scala:60:40, util.scala:473:25, :508:19, :510:27, :515:21, :517:19
  assign io_deq_bits_data = _io_empty_output ? io_enq_bits_data : _ram_ext_R0_data[64:0];	// util.scala:464:20, :473:25, :510:27, :515:21, :517:19
  assign io_deq_bits_predicated = ~_io_empty_output & _ram_ext_R0_data[65];	// util.scala:464:20, :473:25, :510:27, :515:21, :517:19
  assign io_deq_bits_fflags_valid = ~_io_empty_output & _ram_ext_R0_data[66];	// util.scala:464:20, :473:25, :510:27, :515:21, :517:19
  assign io_deq_bits_fflags_bits_uop_rob_idx =
    _io_empty_output ? 7'h0 : _ram_ext_R0_data[73:67];	// util.scala:464:20, :473:25, :510:27, :515:21, :517:19
  assign io_deq_bits_fflags_bits_flags =
    _io_empty_output ? 5'h0 : _ram_ext_R0_data[78:74];	// util.scala:464:20, :473:25, :510:27, :515:21, :517:19
  assign io_empty = _io_empty_output;	// util.scala:473:25
endmodule

