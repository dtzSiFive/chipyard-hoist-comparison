// Generated by CIRCT firtool-1.54.0-30-g7bb1650e3
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

module RegisterReadDecode_9(
  input         io_iss_valid,
  input  [6:0]  io_iss_uop_uopc,
  input  [31:0] io_iss_uop_inst,
                io_iss_uop_debug_inst,
  input         io_iss_uop_is_rvc,
  input  [39:0] io_iss_uop_debug_pc,
  input  [2:0]  io_iss_uop_iq_type,
  input  [9:0]  io_iss_uop_fu_code,
  input  [1:0]  io_iss_uop_iw_state,
  input         io_iss_uop_is_br,
                io_iss_uop_is_jalr,
                io_iss_uop_is_jal,
                io_iss_uop_is_sfb,
  input  [15:0] io_iss_uop_br_mask,
  input  [3:0]  io_iss_uop_br_tag,
  input  [4:0]  io_iss_uop_ftq_idx,
  input         io_iss_uop_edge_inst,
  input  [5:0]  io_iss_uop_pc_lob,
  input         io_iss_uop_taken,
  input  [19:0] io_iss_uop_imm_packed,
  input  [11:0] io_iss_uop_csr_addr,
  input  [6:0]  io_iss_uop_rob_idx,
  input  [4:0]  io_iss_uop_ldq_idx,
                io_iss_uop_stq_idx,
  input  [1:0]  io_iss_uop_rxq_idx,
  input  [6:0]  io_iss_uop_pdst,
                io_iss_uop_prs1,
                io_iss_uop_prs2,
                io_iss_uop_prs3,
  input  [4:0]  io_iss_uop_ppred,
  input         io_iss_uop_prs1_busy,
                io_iss_uop_prs2_busy,
                io_iss_uop_prs3_busy,
                io_iss_uop_ppred_busy,
  input  [6:0]  io_iss_uop_stale_pdst,
  input         io_iss_uop_exception,
  input  [63:0] io_iss_uop_exc_cause,
  input         io_iss_uop_bypassable,
  input  [4:0]  io_iss_uop_mem_cmd,
  input  [1:0]  io_iss_uop_mem_size,
  input         io_iss_uop_mem_signed,
                io_iss_uop_is_fence,
                io_iss_uop_is_fencei,
                io_iss_uop_is_amo,
                io_iss_uop_uses_ldq,
                io_iss_uop_uses_stq,
                io_iss_uop_is_sys_pc2epc,
                io_iss_uop_is_unique,
                io_iss_uop_flush_on_commit,
                io_iss_uop_ldst_is_rs1,
  input  [5:0]  io_iss_uop_ldst,
                io_iss_uop_lrs1,
                io_iss_uop_lrs2,
                io_iss_uop_lrs3,
  input         io_iss_uop_ldst_val,
  input  [1:0]  io_iss_uop_dst_rtype,
                io_iss_uop_lrs1_rtype,
                io_iss_uop_lrs2_rtype,
  input         io_iss_uop_frs3_en,
                io_iss_uop_fp_val,
                io_iss_uop_fp_single,
                io_iss_uop_xcpt_pf_if,
                io_iss_uop_xcpt_ae_if,
                io_iss_uop_xcpt_ma_if,
                io_iss_uop_bp_debug_if,
                io_iss_uop_bp_xcpt_if,
  input  [1:0]  io_iss_uop_debug_fsrc,
                io_iss_uop_debug_tsrc,
  output        io_rrd_valid,
  output [6:0]  io_rrd_uop_uopc,
  output [31:0] io_rrd_uop_inst,
                io_rrd_uop_debug_inst,
  output        io_rrd_uop_is_rvc,
  output [39:0] io_rrd_uop_debug_pc,
  output [2:0]  io_rrd_uop_iq_type,
  output [9:0]  io_rrd_uop_fu_code,
  output [3:0]  io_rrd_uop_ctrl_br_type,
  output [1:0]  io_rrd_uop_ctrl_op1_sel,
  output [2:0]  io_rrd_uop_ctrl_op2_sel,
                io_rrd_uop_ctrl_imm_sel,
  output [3:0]  io_rrd_uop_ctrl_op_fcn,
  output        io_rrd_uop_ctrl_fcn_dw,
                io_rrd_uop_ctrl_is_load,
                io_rrd_uop_ctrl_is_sta,
                io_rrd_uop_ctrl_is_std,
  output [1:0]  io_rrd_uop_iw_state,
  output        io_rrd_uop_is_br,
                io_rrd_uop_is_jalr,
                io_rrd_uop_is_jal,
                io_rrd_uop_is_sfb,
  output [15:0] io_rrd_uop_br_mask,
  output [3:0]  io_rrd_uop_br_tag,
  output [4:0]  io_rrd_uop_ftq_idx,
  output        io_rrd_uop_edge_inst,
  output [5:0]  io_rrd_uop_pc_lob,
  output        io_rrd_uop_taken,
  output [19:0] io_rrd_uop_imm_packed,
  output [11:0] io_rrd_uop_csr_addr,
  output [6:0]  io_rrd_uop_rob_idx,
  output [4:0]  io_rrd_uop_ldq_idx,
                io_rrd_uop_stq_idx,
  output [1:0]  io_rrd_uop_rxq_idx,
  output [6:0]  io_rrd_uop_pdst,
                io_rrd_uop_prs1,
                io_rrd_uop_prs2,
                io_rrd_uop_prs3,
  output [4:0]  io_rrd_uop_ppred,
  output        io_rrd_uop_prs1_busy,
                io_rrd_uop_prs2_busy,
                io_rrd_uop_prs3_busy,
                io_rrd_uop_ppred_busy,
  output [6:0]  io_rrd_uop_stale_pdst,
  output        io_rrd_uop_exception,
  output [63:0] io_rrd_uop_exc_cause,
  output        io_rrd_uop_bypassable,
  output [4:0]  io_rrd_uop_mem_cmd,
  output [1:0]  io_rrd_uop_mem_size,
  output        io_rrd_uop_mem_signed,
                io_rrd_uop_is_fence,
                io_rrd_uop_is_fencei,
                io_rrd_uop_is_amo,
                io_rrd_uop_uses_ldq,
                io_rrd_uop_uses_stq,
                io_rrd_uop_is_sys_pc2epc,
                io_rrd_uop_is_unique,
                io_rrd_uop_flush_on_commit,
                io_rrd_uop_ldst_is_rs1,
  output [5:0]  io_rrd_uop_ldst,
                io_rrd_uop_lrs1,
                io_rrd_uop_lrs2,
                io_rrd_uop_lrs3,
  output        io_rrd_uop_ldst_val,
  output [1:0]  io_rrd_uop_dst_rtype,
                io_rrd_uop_lrs1_rtype,
                io_rrd_uop_lrs2_rtype,
  output        io_rrd_uop_frs3_en,
                io_rrd_uop_fp_val,
                io_rrd_uop_fp_single,
                io_rrd_uop_xcpt_pf_if,
                io_rrd_uop_xcpt_ae_if,
                io_rrd_uop_xcpt_ma_if,
                io_rrd_uop_bp_debug_if,
                io_rrd_uop_bp_xcpt_if,
  output [1:0]  io_rrd_uop_debug_fsrc,
                io_rrd_uop_debug_tsrc
);

  wire       _rrd_cs_decoder_bit_T_1 = io_iss_uop_uopc == 7'h1A;	// Decode.scala:14:121
  wire       _rrd_cs_decoder_bit_T_2 = io_iss_uop_uopc == 7'h1C;	// Decode.scala:14:121
  wire       _rrd_cs_decoder_bit_T_6 = io_iss_uop_uopc == 7'h1D;	// Decode.scala:14:121
  wire       _io_rrd_uop_ctrl_is_load_T = io_iss_uop_uopc == 7'h1;	// Decode.scala:14:121
  wire       _io_rrd_uop_ctrl_is_sta_T_1 = io_iss_uop_uopc == 7'h43;	// Decode.scala:14:121
  wire [5:0] _GEN = {io_iss_uop_uopc[6:4], io_iss_uop_uopc[2:0]};	// Decode.scala:14:65
  wire [5:0] _GEN_0 = {io_iss_uop_uopc[6:5], io_iss_uop_uopc[3:0]};	// Decode.scala:14:65
  wire [4:0] _GEN_1 = {io_iss_uop_uopc[6:3], io_iss_uop_uopc[0]};	// Decode.scala:14:65
  wire [5:0] _GEN_2 = {io_iss_uop_uopc[6:3], io_iss_uop_uopc[1:0]};	// Decode.scala:14:65
  wire       _rrd_cs_decoder_bit_T_51 = io_iss_uop_uopc == 7'h2D;	// Decode.scala:14:121
  wire       _rrd_cs_decoder_bit_T_80 = io_iss_uop_uopc[6:1] == 6'h3;	// Decode.scala:14:{65,121}
  wire [4:0] _GEN_3 = {io_iss_uop_uopc[6:4], io_iss_uop_uopc[2:1]};	// Decode.scala:14:65
  wire [4:0] _GEN_4 = {io_iss_uop_uopc[6], io_iss_uop_uopc[4:1]};	// Decode.scala:14:65
  wire       _rrd_cs_decoder_T_28 =
    {io_iss_uop_uopc[5], io_iss_uop_uopc[3], io_iss_uop_uopc[1:0]} == 4'h0;	// Decode.scala:14:{65,121}
  wire       _io_rrd_uop_ctrl_is_sta_output =
    io_iss_uop_uopc == 7'h2 | _io_rrd_uop_ctrl_is_sta_T_1;	// Decode.scala:14:121, func-unit-decode.scala:340:57
  assign io_rrd_valid = io_iss_valid;
  assign io_rrd_uop_uopc = io_iss_uop_uopc;
  assign io_rrd_uop_inst = io_iss_uop_inst;
  assign io_rrd_uop_debug_inst = io_iss_uop_debug_inst;
  assign io_rrd_uop_is_rvc = io_iss_uop_is_rvc;
  assign io_rrd_uop_debug_pc = io_iss_uop_debug_pc;
  assign io_rrd_uop_iq_type = io_iss_uop_iq_type;
  assign io_rrd_uop_fu_code = io_iss_uop_fu_code;
  assign io_rrd_uop_ctrl_br_type =
    {1'h0,
     io_iss_uop_uopc == 7'h1B | _rrd_cs_decoder_bit_T_2 | _rrd_cs_decoder_bit_T_6,
     io_iss_uop_uopc == 7'h18 | _rrd_cs_decoder_bit_T_1 | _rrd_cs_decoder_bit_T_6,
     io_iss_uop_uopc == 7'h19 | _rrd_cs_decoder_bit_T_1 | _rrd_cs_decoder_bit_T_2};	// Cat.scala:30:58, Decode.scala:14:121, :15:30
  assign io_rrd_uop_ctrl_op1_sel =
    {1'h0, {io_iss_uop_uopc[4:3], io_iss_uop_uopc[1:0]} == 4'h0};	// Cat.scala:30:58, Decode.scala:14:{65,121}, :15:30
  assign io_rrd_uop_ctrl_op2_sel =
    {1'h0,
     io_iss_uop_uopc[6:5] == 2'h2,
     {io_iss_uop_uopc[5:4], io_iss_uop_uopc[1]} == 3'h0 | io_iss_uop_uopc[4:2] == 3'h1
       | {io_iss_uop_uopc[6], io_iss_uop_uopc[3:2]} == 3'h2
       | {io_iss_uop_uopc[5], io_iss_uop_uopc[3], io_iss_uop_uopc[0]} == 3'h4
       | {io_iss_uop_uopc[5], io_iss_uop_uopc[1:0]} == 3'h6
       | {io_iss_uop_uopc[4:3], io_iss_uop_uopc[0]} == 3'h0};	// Cat.scala:30:58, Decode.scala:14:{65,121}, :15:30
  assign io_rrd_uop_ctrl_imm_sel =
    {1'h0,
     _rrd_cs_decoder_T_28 | io_iss_uop_uopc[5:4] == 2'h1,
     {io_iss_uop_uopc[5], io_iss_uop_uopc[3:2], io_iss_uop_uopc[0]} == 4'h0
       | _rrd_cs_decoder_T_28};	// Cat.scala:30:58, Decode.scala:14:{65,121}, :15:30
  assign io_rrd_uop_ctrl_op_fcn =
    {_GEN_0 == 6'h9 | _GEN_0 == 6'hA | _GEN_0 == 6'hC | _GEN_4 == 5'h8 | _GEN_2 == 6'hA
       | io_iss_uop_uopc[6:2] == 5'h6 | {io_iss_uop_uopc[6:3], io_iss_uop_uopc[1]} == 5'h6
       | _rrd_cs_decoder_bit_T_51,
     _rrd_cs_decoder_bit_T_80 | _GEN_1 == 5'h5 | _GEN_3 == 5'h5 | _GEN_4 == 5'h9
       | _GEN_3 == 5'h6 | {io_iss_uop_uopc[6:2], io_iss_uop_uopc[0]} == 6'h4
       | _GEN_2 == 6'h5,
     io_iss_uop_uopc == 7'hA | io_iss_uop_uopc == 7'hC | _GEN_1 == 5'h4 | _GEN_2 == 6'hD
       | _rrd_cs_decoder_bit_T_51 | io_iss_uop_uopc[6:1] == 6'h18
       | _rrd_cs_decoder_bit_T_80 | _GEN == 6'hB | _GEN == 6'h8,
     _GEN == 6'h3 | io_iss_uop_uopc[6:1] == 6'h6 | io_iss_uop_uopc[6:1] == 6'h17
       | io_iss_uop_uopc[6:2] == 5'hC | _GEN == 6'h6 | _GEN_0 == 6'h3
       | io_iss_uop_uopc[6:1] == 6'hB};	// Cat.scala:30:58, Decode.scala:14:{65,121}, :15:30, func-unit-decode.scala:343:91
  assign io_rrd_uop_ctrl_fcn_dw =
    ~(io_iss_uop_uopc == 7'h2B | io_iss_uop_uopc == 7'h2E | io_iss_uop_uopc == 7'h30
      | io_iss_uop_uopc == 7'h32 | io_iss_uop_uopc == 7'h2C | _rrd_cs_decoder_bit_T_51
      | io_iss_uop_uopc == 7'h2F | io_iss_uop_uopc == 7'h31 | io_iss_uop_uopc == 7'h33);	// Decode.scala:14:121, :15:30, :40:35
  assign io_rrd_uop_ctrl_is_load = _io_rrd_uop_ctrl_is_load_T;	// Decode.scala:14:121
  assign io_rrd_uop_ctrl_is_sta = _io_rrd_uop_ctrl_is_sta_output;	// func-unit-decode.scala:340:57
  assign io_rrd_uop_ctrl_is_std =
    io_iss_uop_uopc == 7'h3 | _io_rrd_uop_ctrl_is_sta_output
    & io_iss_uop_lrs2_rtype == 2'h0;	// Decode.scala:14:121, func-unit-decode.scala:340:57, :341:{57,84,109}
  assign io_rrd_uop_iw_state = io_iss_uop_iw_state;
  assign io_rrd_uop_is_br = io_iss_uop_is_br;
  assign io_rrd_uop_is_jalr = io_iss_uop_is_jalr;
  assign io_rrd_uop_is_jal = io_iss_uop_is_jal;
  assign io_rrd_uop_is_sfb = io_iss_uop_is_sfb;
  assign io_rrd_uop_br_mask = io_iss_uop_br_mask;
  assign io_rrd_uop_br_tag = io_iss_uop_br_tag;
  assign io_rrd_uop_ftq_idx = io_iss_uop_ftq_idx;
  assign io_rrd_uop_edge_inst = io_iss_uop_edge_inst;
  assign io_rrd_uop_pc_lob = io_iss_uop_pc_lob;
  assign io_rrd_uop_taken = io_iss_uop_taken;
  assign io_rrd_uop_imm_packed =
    _io_rrd_uop_ctrl_is_sta_T_1 | _io_rrd_uop_ctrl_is_load_T & io_iss_uop_mem_cmd == 5'h6
      ? 20'h0
      : io_iss_uop_imm_packed;	// Decode.scala:14:121, func-unit-decode.scala:320:16, :343:{39,69,91,103}, :344:27
  assign io_rrd_uop_csr_addr = io_iss_uop_csr_addr;
  assign io_rrd_uop_rob_idx = io_iss_uop_rob_idx;
  assign io_rrd_uop_ldq_idx = io_iss_uop_ldq_idx;
  assign io_rrd_uop_stq_idx = io_iss_uop_stq_idx;
  assign io_rrd_uop_rxq_idx = io_iss_uop_rxq_idx;
  assign io_rrd_uop_pdst = io_iss_uop_pdst;
  assign io_rrd_uop_prs1 = io_iss_uop_prs1;
  assign io_rrd_uop_prs2 = io_iss_uop_prs2;
  assign io_rrd_uop_prs3 = io_iss_uop_prs3;
  assign io_rrd_uop_ppred = io_iss_uop_ppred;
  assign io_rrd_uop_prs1_busy = io_iss_uop_prs1_busy;
  assign io_rrd_uop_prs2_busy = io_iss_uop_prs2_busy;
  assign io_rrd_uop_prs3_busy = io_iss_uop_prs3_busy;
  assign io_rrd_uop_ppred_busy = io_iss_uop_ppred_busy;
  assign io_rrd_uop_stale_pdst = io_iss_uop_stale_pdst;
  assign io_rrd_uop_exception = io_iss_uop_exception;
  assign io_rrd_uop_exc_cause = io_iss_uop_exc_cause;
  assign io_rrd_uop_bypassable = io_iss_uop_bypassable;
  assign io_rrd_uop_mem_cmd = io_iss_uop_mem_cmd;
  assign io_rrd_uop_mem_size = io_iss_uop_mem_size;
  assign io_rrd_uop_mem_signed = io_iss_uop_mem_signed;
  assign io_rrd_uop_is_fence = io_iss_uop_is_fence;
  assign io_rrd_uop_is_fencei = io_iss_uop_is_fencei;
  assign io_rrd_uop_is_amo = io_iss_uop_is_amo;
  assign io_rrd_uop_uses_ldq = io_iss_uop_uses_ldq;
  assign io_rrd_uop_uses_stq = io_iss_uop_uses_stq;
  assign io_rrd_uop_is_sys_pc2epc = io_iss_uop_is_sys_pc2epc;
  assign io_rrd_uop_is_unique = io_iss_uop_is_unique;
  assign io_rrd_uop_flush_on_commit = io_iss_uop_flush_on_commit;
  assign io_rrd_uop_ldst_is_rs1 = io_iss_uop_ldst_is_rs1;
  assign io_rrd_uop_ldst = io_iss_uop_ldst;
  assign io_rrd_uop_lrs1 = io_iss_uop_lrs1;
  assign io_rrd_uop_lrs2 = io_iss_uop_lrs2;
  assign io_rrd_uop_lrs3 = io_iss_uop_lrs3;
  assign io_rrd_uop_ldst_val = io_iss_uop_ldst_val;
  assign io_rrd_uop_dst_rtype = io_iss_uop_dst_rtype;
  assign io_rrd_uop_lrs1_rtype = io_iss_uop_lrs1_rtype;
  assign io_rrd_uop_lrs2_rtype = io_iss_uop_lrs2_rtype;
  assign io_rrd_uop_frs3_en = io_iss_uop_frs3_en;
  assign io_rrd_uop_fp_val = io_iss_uop_fp_val;
  assign io_rrd_uop_fp_single = io_iss_uop_fp_single;
  assign io_rrd_uop_xcpt_pf_if = io_iss_uop_xcpt_pf_if;
  assign io_rrd_uop_xcpt_ae_if = io_iss_uop_xcpt_ae_if;
  assign io_rrd_uop_xcpt_ma_if = io_iss_uop_xcpt_ma_if;
  assign io_rrd_uop_bp_debug_if = io_iss_uop_bp_debug_if;
  assign io_rrd_uop_bp_xcpt_if = io_iss_uop_bp_xcpt_if;
  assign io_rrd_uop_debug_fsrc = io_iss_uop_debug_fsrc;
  assign io_rrd_uop_debug_tsrc = io_iss_uop_debug_tsrc;
endmodule
