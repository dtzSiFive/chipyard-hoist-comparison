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

module BranchKillableQueue_8(
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
  input  [19:0] io_enq_bits_uop_br_mask,
  input  [4:0]  io_enq_bits_uop_br_tag,
  input  [5:0]  io_enq_bits_uop_ftq_idx,
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
  input  [5:0]  io_enq_bits_uop_ppred,
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
  input  [63:0] io_enq_bits_data,
  input         io_enq_bits_is_hella,
                io_deq_ready,
  input  [19:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  input         io_flush,
  output        io_enq_ready,
                io_deq_valid,
  output [19:0] io_deq_bits_uop_br_mask,
  output [4:0]  io_deq_bits_uop_ldq_idx,
                io_deq_bits_uop_stq_idx,
  output        io_deq_bits_uop_is_amo,
                io_deq_bits_uop_uses_ldq,
                io_deq_bits_uop_uses_stq,
  output [63:0] io_deq_bits_data,
  output        io_deq_bits_is_hella
);

  wire [64:0]      _ram_ext_R0_data;	// util.scala:464:20
  reg              valids_0;	// util.scala:465:24
  reg              valids_1;	// util.scala:465:24
  reg              valids_2;	// util.scala:465:24
  reg              valids_3;	// util.scala:465:24
  reg  [19:0]      uops_0_br_mask;	// util.scala:466:20
  reg  [4:0]       uops_0_ldq_idx;	// util.scala:466:20
  reg  [4:0]       uops_0_stq_idx;	// util.scala:466:20
  reg              uops_0_is_amo;	// util.scala:466:20
  reg              uops_0_uses_ldq;	// util.scala:466:20
  reg              uops_0_uses_stq;	// util.scala:466:20
  reg  [19:0]      uops_1_br_mask;	// util.scala:466:20
  reg  [4:0]       uops_1_ldq_idx;	// util.scala:466:20
  reg  [4:0]       uops_1_stq_idx;	// util.scala:466:20
  reg              uops_1_is_amo;	// util.scala:466:20
  reg              uops_1_uses_ldq;	// util.scala:466:20
  reg              uops_1_uses_stq;	// util.scala:466:20
  reg  [19:0]      uops_2_br_mask;	// util.scala:466:20
  reg  [4:0]       uops_2_ldq_idx;	// util.scala:466:20
  reg  [4:0]       uops_2_stq_idx;	// util.scala:466:20
  reg              uops_2_is_amo;	// util.scala:466:20
  reg              uops_2_uses_ldq;	// util.scala:466:20
  reg              uops_2_uses_stq;	// util.scala:466:20
  reg  [19:0]      uops_3_br_mask;	// util.scala:466:20
  reg  [4:0]       uops_3_ldq_idx;	// util.scala:466:20
  reg  [4:0]       uops_3_stq_idx;	// util.scala:466:20
  reg              uops_3_is_amo;	// util.scala:466:20
  reg              uops_3_uses_ldq;	// util.scala:466:20
  reg              uops_3_uses_stq;	// util.scala:466:20
  reg  [1:0]       value;	// Counter.scala:60:40
  reg  [1:0]       value_1;	// Counter.scala:60:40
  reg              maybe_full;	// util.scala:470:27
  wire             ptr_match = value == value_1;	// Counter.scala:60:40, util.scala:472:33
  wire             _io_empty_T_1 = ptr_match & ~maybe_full;	// util.scala:470:27, :472:33, :473:{25,28}
  wire             full = ptr_match & maybe_full;	// util.scala:470:27, :472:33, :474:24
  wire             do_enq = ~full & io_enq_valid;	// Decoupled.scala:40:37, util.scala:474:24, :504:19
  wire [3:0]       _GEN = {{valids_3}, {valids_2}, {valids_1}, {valids_0}};	// util.scala:465:24, :476:42
  wire             _GEN_0 = _GEN[value_1];	// Counter.scala:60:40, util.scala:476:42
  wire [3:0][19:0] _GEN_1 =
    {{uops_3_br_mask}, {uops_2_br_mask}, {uops_1_br_mask}, {uops_0_br_mask}};	// util.scala:466:20, :508:19
  wire [19:0]      out_uop_br_mask = _GEN_1[value_1];	// Counter.scala:60:40, util.scala:508:19
  wire [3:0][4:0]  _GEN_2 =
    {{uops_3_ldq_idx}, {uops_2_ldq_idx}, {uops_1_ldq_idx}, {uops_0_ldq_idx}};	// util.scala:466:20, :508:19
  wire [3:0][4:0]  _GEN_3 =
    {{uops_3_stq_idx}, {uops_2_stq_idx}, {uops_1_stq_idx}, {uops_0_stq_idx}};	// util.scala:466:20, :508:19
  wire [3:0]       _GEN_4 =
    {{uops_3_is_amo}, {uops_2_is_amo}, {uops_1_is_amo}, {uops_0_is_amo}};	// util.scala:466:20, :508:19
  wire [3:0]       _GEN_5 =
    {{uops_3_uses_ldq}, {uops_2_uses_ldq}, {uops_1_uses_ldq}, {uops_0_uses_ldq}};	// util.scala:466:20, :508:19
  wire             out_uop_uses_ldq = _GEN_5[value_1];	// Counter.scala:60:40, util.scala:508:19
  wire [3:0]       _GEN_6 =
    {{uops_3_uses_stq}, {uops_2_uses_stq}, {uops_1_uses_stq}, {uops_0_uses_stq}};	// util.scala:466:20, :508:19
  always @(posedge clock) begin
    automatic logic        _GEN_7;	// util.scala:489:33
    automatic logic        _GEN_8;	// util.scala:481:16, :487:17, :489:33
    automatic logic        _GEN_9;	// util.scala:489:33
    automatic logic        _GEN_10;	// util.scala:481:16, :487:17, :489:33
    automatic logic        _GEN_11;	// util.scala:489:33
    automatic logic        _GEN_12;	// util.scala:481:16, :487:17, :489:33
    automatic logic        _GEN_13;	// util.scala:481:16, :487:17, :489:33
    automatic logic [19:0] _uops_br_mask_T_1;	// util.scala:85:25
    _GEN_7 = value == 2'h0;	// Counter.scala:60:40, util.scala:489:33
    _GEN_8 = do_enq & _GEN_7;	// Decoupled.scala:40:37, util.scala:481:16, :487:17, :489:33
    _GEN_9 = value == 2'h1;	// Counter.scala:60:40, util.scala:489:33
    _GEN_10 = do_enq & _GEN_9;	// Decoupled.scala:40:37, util.scala:481:16, :487:17, :489:33
    _GEN_11 = value == 2'h2;	// Counter.scala:60:40, util.scala:489:33
    _GEN_12 = do_enq & _GEN_11;	// Decoupled.scala:40:37, util.scala:481:16, :487:17, :489:33
    _GEN_13 = do_enq & (&value);	// Counter.scala:60:40, Decoupled.scala:40:37, util.scala:481:16, :487:17, :489:33
    _uops_br_mask_T_1 = io_enq_bits_uop_br_mask & ~io_brupdate_b1_resolve_mask;	// util.scala:85:{25,27}
    if (reset) begin
      valids_0 <= 1'h0;	// util.scala:464:20, :465:24
      valids_1 <= 1'h0;	// util.scala:464:20, :465:24
      valids_2 <= 1'h0;	// util.scala:464:20, :465:24
      valids_3 <= 1'h0;	// util.scala:464:20, :465:24
      value <= 2'h0;	// Counter.scala:60:40
      value_1 <= 2'h0;	// Counter.scala:60:40
      maybe_full <= 1'h0;	// util.scala:464:20, :470:27
    end
    else begin
      automatic logic do_deq = (io_deq_ready | ~_GEN_0) & ~_io_empty_T_1;	// util.scala:473:25, :476:{39,42,66,69}
      valids_0 <=
        ~(do_deq & value_1 == 2'h0)
        & (_GEN_8 | valids_0 & (io_brupdate_b1_mispredict_mask & uops_0_br_mask) == 20'h0
           & ~(io_flush & uops_0_uses_ldq));	// Counter.scala:60:40, util.scala:118:{51,59}, :465:24, :466:20, :476:66, :481:{16,69,72,83}, :487:17, :489:33, :495:17, :496:27
      valids_1 <=
        ~(do_deq & value_1 == 2'h1)
        & (_GEN_10 | valids_1 & (io_brupdate_b1_mispredict_mask & uops_1_br_mask) == 20'h0
           & ~(io_flush & uops_1_uses_ldq));	// Counter.scala:60:40, util.scala:118:{51,59}, :465:24, :466:20, :476:66, :481:{16,69,72,83}, :487:17, :489:33, :495:17, :496:27
      valids_2 <=
        ~(do_deq & value_1 == 2'h2)
        & (_GEN_12 | valids_2 & (io_brupdate_b1_mispredict_mask & uops_2_br_mask) == 20'h0
           & ~(io_flush & uops_2_uses_ldq));	// Counter.scala:60:40, util.scala:118:{51,59}, :465:24, :466:20, :476:66, :481:{16,69,72,83}, :487:17, :489:33, :495:17, :496:27
      valids_3 <=
        ~(do_deq & (&value_1))
        & (_GEN_13 | valids_3 & (io_brupdate_b1_mispredict_mask & uops_3_br_mask) == 20'h0
           & ~(io_flush & uops_3_uses_ldq));	// Counter.scala:60:40, util.scala:118:{51,59}, :465:24, :466:20, :476:66, :481:{16,69,72,83}, :487:17, :489:33, :495:17, :496:27
      if (do_enq)	// Decoupled.scala:40:37
        value <= value + 2'h1;	// Counter.scala:60:40, :76:24, util.scala:489:33
      if (do_deq)	// util.scala:476:66
        value_1 <= value_1 + 2'h1;	// Counter.scala:60:40, :76:24, util.scala:489:33
      if (do_enq != do_deq)	// Decoupled.scala:40:37, util.scala:476:66, :500:16
        maybe_full <= do_enq;	// Decoupled.scala:40:37, util.scala:470:27
    end
    if (do_enq & _GEN_7)	// Decoupled.scala:40:37, util.scala:482:22, :487:17, :489:33, :491:33
      uops_0_br_mask <= _uops_br_mask_T_1;	// util.scala:85:25, :466:20
    else	// util.scala:482:22, :487:17, :491:33
      uops_0_br_mask <= ({20{~valids_0}} | ~io_brupdate_b1_resolve_mask) & uops_0_br_mask;	// util.scala:89:23, :465:24, :466:20, :482:22, :483:23
    if (_GEN_8) begin	// util.scala:481:16, :487:17, :489:33
      uops_0_ldq_idx <= io_enq_bits_uop_ldq_idx;	// util.scala:466:20
      uops_0_stq_idx <= io_enq_bits_uop_stq_idx;	// util.scala:466:20
      uops_0_is_amo <= io_enq_bits_uop_is_amo;	// util.scala:466:20
      uops_0_uses_ldq <= io_enq_bits_uop_uses_ldq;	// util.scala:466:20
      uops_0_uses_stq <= io_enq_bits_uop_uses_stq;	// util.scala:466:20
    end
    if (do_enq & _GEN_9)	// Decoupled.scala:40:37, util.scala:482:22, :487:17, :489:33, :491:33
      uops_1_br_mask <= _uops_br_mask_T_1;	// util.scala:85:25, :466:20
    else	// util.scala:482:22, :487:17, :491:33
      uops_1_br_mask <= ({20{~valids_1}} | ~io_brupdate_b1_resolve_mask) & uops_1_br_mask;	// util.scala:89:23, :465:24, :466:20, :482:22, :483:23
    if (_GEN_10) begin	// util.scala:481:16, :487:17, :489:33
      uops_1_ldq_idx <= io_enq_bits_uop_ldq_idx;	// util.scala:466:20
      uops_1_stq_idx <= io_enq_bits_uop_stq_idx;	// util.scala:466:20
      uops_1_is_amo <= io_enq_bits_uop_is_amo;	// util.scala:466:20
      uops_1_uses_ldq <= io_enq_bits_uop_uses_ldq;	// util.scala:466:20
      uops_1_uses_stq <= io_enq_bits_uop_uses_stq;	// util.scala:466:20
    end
    if (do_enq & _GEN_11)	// Decoupled.scala:40:37, util.scala:482:22, :487:17, :489:33, :491:33
      uops_2_br_mask <= _uops_br_mask_T_1;	// util.scala:85:25, :466:20
    else	// util.scala:482:22, :487:17, :491:33
      uops_2_br_mask <= ({20{~valids_2}} | ~io_brupdate_b1_resolve_mask) & uops_2_br_mask;	// util.scala:89:23, :465:24, :466:20, :482:22, :483:23
    if (_GEN_12) begin	// util.scala:481:16, :487:17, :489:33
      uops_2_ldq_idx <= io_enq_bits_uop_ldq_idx;	// util.scala:466:20
      uops_2_stq_idx <= io_enq_bits_uop_stq_idx;	// util.scala:466:20
      uops_2_is_amo <= io_enq_bits_uop_is_amo;	// util.scala:466:20
      uops_2_uses_ldq <= io_enq_bits_uop_uses_ldq;	// util.scala:466:20
      uops_2_uses_stq <= io_enq_bits_uop_uses_stq;	// util.scala:466:20
    end
    if (do_enq & (&value))	// Counter.scala:60:40, Decoupled.scala:40:37, util.scala:482:22, :487:17, :489:33, :491:33
      uops_3_br_mask <= _uops_br_mask_T_1;	// util.scala:85:25, :466:20
    else	// util.scala:482:22, :487:17, :491:33
      uops_3_br_mask <= ({20{~valids_3}} | ~io_brupdate_b1_resolve_mask) & uops_3_br_mask;	// util.scala:89:23, :465:24, :466:20, :482:22, :483:23
    if (_GEN_13) begin	// util.scala:481:16, :487:17, :489:33
      uops_3_ldq_idx <= io_enq_bits_uop_ldq_idx;	// util.scala:466:20
      uops_3_stq_idx <= io_enq_bits_uop_stq_idx;	// util.scala:466:20
      uops_3_is_amo <= io_enq_bits_uop_is_amo;	// util.scala:466:20
      uops_3_uses_ldq <= io_enq_bits_uop_uses_ldq;	// util.scala:466:20
      uops_3_uses_stq <= io_enq_bits_uop_uses_stq;	// util.scala:466:20
    end
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
        valids_0 = _RANDOM[6'h0][0];	// util.scala:465:24
        valids_1 = _RANDOM[6'h0][1];	// util.scala:465:24
        valids_2 = _RANDOM[6'h0][2];	// util.scala:465:24
        valids_3 = _RANDOM[6'h0][3];	// util.scala:465:24
        uops_0_br_mask = _RANDOM[6'h5][19:0];	// util.scala:466:20
        uops_0_ldq_idx = _RANDOM[6'h7][18:14];	// util.scala:466:20
        uops_0_stq_idx = _RANDOM[6'h7][23:19];	// util.scala:466:20
        uops_0_is_amo = _RANDOM[6'hB][19];	// util.scala:466:20
        uops_0_uses_ldq = _RANDOM[6'hB][20];	// util.scala:466:20
        uops_0_uses_stq = _RANDOM[6'hB][21];	// util.scala:466:20
        uops_1_br_mask = _RANDOM[6'h12][20:1];	// util.scala:466:20
        uops_1_ldq_idx = _RANDOM[6'h14][19:15];	// util.scala:466:20
        uops_1_stq_idx = _RANDOM[6'h14][24:20];	// util.scala:466:20
        uops_1_is_amo = _RANDOM[6'h18][20];	// util.scala:466:20
        uops_1_uses_ldq = _RANDOM[6'h18][21];	// util.scala:466:20
        uops_1_uses_stq = _RANDOM[6'h18][22];	// util.scala:466:20
        uops_2_br_mask = _RANDOM[6'h1F][21:2];	// util.scala:466:20
        uops_2_ldq_idx = _RANDOM[6'h21][20:16];	// util.scala:466:20
        uops_2_stq_idx = _RANDOM[6'h21][25:21];	// util.scala:466:20
        uops_2_is_amo = _RANDOM[6'h25][21];	// util.scala:466:20
        uops_2_uses_ldq = _RANDOM[6'h25][22];	// util.scala:466:20
        uops_2_uses_stq = _RANDOM[6'h25][23];	// util.scala:466:20
        uops_3_br_mask = _RANDOM[6'h2C][22:3];	// util.scala:466:20
        uops_3_ldq_idx = _RANDOM[6'h2E][21:17];	// util.scala:466:20
        uops_3_stq_idx = _RANDOM[6'h2E][26:22];	// util.scala:466:20
        uops_3_is_amo = _RANDOM[6'h32][22];	// util.scala:466:20
        uops_3_uses_ldq = _RANDOM[6'h32][23];	// util.scala:466:20
        uops_3_uses_stq = _RANDOM[6'h32][24];	// util.scala:466:20
        value = _RANDOM[6'h34][9:8];	// Counter.scala:60:40
        value_1 = _RANDOM[6'h34][11:10];	// Counter.scala:60:40
        maybe_full = _RANDOM[6'h34][12];	// Counter.scala:60:40, util.scala:470:27
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  ram_4x65 ram_ext (	// util.scala:464:20
    .R0_addr (value_1),	// Counter.scala:60:40
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (value),	// Counter.scala:60:40
    .W0_en   (do_enq),	// Decoupled.scala:40:37
    .W0_clk  (clock),
    .W0_data ({io_enq_bits_is_hella, io_enq_bits_data}),	// util.scala:464:20
    .R0_data (_ram_ext_R0_data)
  );
  assign io_enq_ready = ~full;	// util.scala:474:24, :504:19
  assign io_deq_valid =
    ~_io_empty_T_1 & _GEN_0 & (io_brupdate_b1_mispredict_mask & out_uop_br_mask) == 20'h0
    & ~(io_flush & out_uop_uses_ldq);	// util.scala:118:{51,59}, :473:25, :476:{42,69}, :508:19, :509:{108,111,122}
  assign io_deq_bits_uop_br_mask = out_uop_br_mask & ~io_brupdate_b1_resolve_mask;	// util.scala:85:{25,27}, :508:19
  assign io_deq_bits_uop_ldq_idx = _GEN_2[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_stq_idx = _GEN_3[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_is_amo = _GEN_4[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_uses_ldq = out_uop_uses_ldq;	// util.scala:508:19
  assign io_deq_bits_uop_uses_stq = _GEN_6[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_data = _ram_ext_R0_data[63:0];	// util.scala:464:20
  assign io_deq_bits_is_hella = _ram_ext_R0_data[64];	// util.scala:464:20
endmodule

