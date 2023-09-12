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

module RegisterReadDecode_10(
  input         io_iss_valid,
  input  [6:0]  io_iss_uop_uopc,
  input         io_iss_uop_is_rvc,
  input  [9:0]  io_iss_uop_fu_code,
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
  input  [6:0]  io_iss_uop_rob_idx,
  input  [4:0]  io_iss_uop_ldq_idx,
                io_iss_uop_stq_idx,
  input  [6:0]  io_iss_uop_pdst,
                io_iss_uop_prs1,
                io_iss_uop_prs2,
  input         io_iss_uop_bypassable,
  input  [4:0]  io_iss_uop_mem_cmd,
  input         io_iss_uop_is_amo,
                io_iss_uop_uses_stq,
  input  [1:0]  io_iss_uop_dst_rtype,
                io_iss_uop_lrs1_rtype,
                io_iss_uop_lrs2_rtype,
  output        io_rrd_valid,
  output [6:0]  io_rrd_uop_uopc,
  output        io_rrd_uop_is_rvc,
  output [9:0]  io_rrd_uop_fu_code,
  output [3:0]  io_rrd_uop_ctrl_br_type,
  output [1:0]  io_rrd_uop_ctrl_op1_sel,
  output [2:0]  io_rrd_uop_ctrl_op2_sel,
                io_rrd_uop_ctrl_imm_sel,
  output [3:0]  io_rrd_uop_ctrl_op_fcn,
  output        io_rrd_uop_ctrl_fcn_dw,
                io_rrd_uop_is_br,
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
  output [6:0]  io_rrd_uop_rob_idx,
  output [4:0]  io_rrd_uop_ldq_idx,
                io_rrd_uop_stq_idx,
  output [6:0]  io_rrd_uop_pdst,
                io_rrd_uop_prs1,
                io_rrd_uop_prs2,
  output        io_rrd_uop_bypassable,
                io_rrd_uop_is_amo,
                io_rrd_uop_uses_stq,
  output [1:0]  io_rrd_uop_dst_rtype,
                io_rrd_uop_lrs1_rtype,
                io_rrd_uop_lrs2_rtype
);

  wire       _rrd_cs_decoder_bit_T_4 = io_iss_uop_uopc == 7'h19;	// Decode.scala:14:121
  wire       _rrd_cs_decoder_bit_T_1 = io_iss_uop_uopc == 7'h1A;	// Decode.scala:14:121
  wire       _rrd_cs_decoder_bit_T_2 = io_iss_uop_uopc == 7'h1C;	// Decode.scala:14:121
  wire       _rrd_cs_decoder_bit_T_3 = io_iss_uop_uopc == 7'h25;	// Decode.scala:14:121
  wire       _rrd_cs_decoder_bit_T_9 = io_iss_uop_uopc == 7'h18;	// Decode.scala:14:121
  wire       _rrd_cs_decoder_bit_T_8 = io_iss_uop_uopc == 7'h1D;	// Decode.scala:14:121
  wire       _rrd_cs_decoder_bit_T_13 = io_iss_uop_uopc == 7'h1B;	// Decode.scala:14:121
  wire       _rrd_cs_decoder_bit_T_19 = io_iss_uop_uopc == 7'h36;	// Decode.scala:14:121
  wire       _rrd_cs_decoder_bit_T_23 = io_iss_uop_uopc == 7'h3A;	// Decode.scala:14:121
  wire       _rrd_cs_decoder_bit_T_24 = io_iss_uop_uopc == 7'h3B;	// Decode.scala:14:121
  wire       _rrd_cs_decoder_bit_T_25 = io_iss_uop_uopc == 7'h3C;	// Decode.scala:14:121
  wire       _rrd_cs_decoder_bit_T_26 = io_iss_uop_uopc == 7'h3D;	// Decode.scala:14:121
  wire       _rrd_cs_decoder_bit_T_27 = io_iss_uop_uopc == 7'h3E;	// Decode.scala:14:121
  wire       _rrd_cs_decoder_bit_T_28 = io_iss_uop_uopc == 7'h3F;	// Decode.scala:14:121
  wire       _rrd_cs_decoder_bit_T_29 = io_iss_uop_uopc == 7'h40;	// Decode.scala:14:121
  wire       _rrd_cs_decoder_bit_T_118 = io_iss_uop_uopc == 7'h6;	// Decode.scala:14:121
  wire       _rrd_cs_decoder_bit_T_56 = io_iss_uop_uopc == 7'hC;	// Decode.scala:14:121
  wire       _rrd_cs_decoder_bit_T_57 = io_iss_uop_uopc == 7'hD;	// Decode.scala:14:121
  wire       _rrd_cs_decoder_bit_T_58 = io_iss_uop_uopc == 7'h2E;	// Decode.scala:14:121
  wire       _rrd_cs_decoder_bit_T_59 = io_iss_uop_uopc == 7'h30;	// Decode.scala:14:121
  wire       _rrd_cs_decoder_bit_T_60 = io_iss_uop_uopc == 7'h32;	// Decode.scala:14:121
  wire       _rrd_cs_decoder_bit_T_62 = io_iss_uop_uopc == 7'h13;	// Decode.scala:14:121
  wire       _rrd_cs_decoder_bit_T_63 = io_iss_uop_uopc == 7'h16;	// Decode.scala:14:121
  wire       _rrd_cs_decoder_bit_T_64 = io_iss_uop_uopc == 7'h17;	// Decode.scala:14:121
  wire       _rrd_cs_decoder_bit_T_65 = io_iss_uop_uopc == 7'h2F;	// Decode.scala:14:121
  wire       _rrd_cs_decoder_bit_T_66 = io_iss_uop_uopc == 7'h31;	// Decode.scala:14:121
  wire       _rrd_cs_decoder_bit_T_67 = io_iss_uop_uopc == 7'h33;	// Decode.scala:14:121
  wire       _rrd_cs_decoder_bit_T_87 = io_iss_uop_uopc == 7'h7;	// Decode.scala:14:121
  wire       _rrd_cs_decoder_bit_T_88 = io_iss_uop_uopc == 7'hA;	// Decode.scala:14:121
  wire       _rrd_cs_decoder_bit_T_89 = io_iss_uop_uopc == 7'h10;	// Decode.scala:14:121
  wire       _rrd_cs_decoder_bit_T_90 = io_iss_uop_uopc == 7'h12;	// Decode.scala:14:121
  wire       _rrd_cs_decoder_bit_T_91 = io_iss_uop_uopc == 7'h14;	// Decode.scala:14:121
  wire       _rrd_cs_decoder_bit_T_92 = io_iss_uop_uopc == 7'h2D;	// Decode.scala:14:121
  wire       _rrd_cs_decoder_bit_T_143 = io_iss_uop_uopc == 7'h9;	// Decode.scala:14:121
  wire       _rrd_cs_decoder_bit_T_116 = io_iss_uop_uopc == 7'h11;	// Decode.scala:14:121
  wire [3:0] _GEN = {io_iss_uop_uopc[5], io_iss_uop_uopc[3], io_iss_uop_uopc[1:0]};	// Decode.scala:14:65
  wire       _rrd_cs_decoder_T_30 = _GEN == 4'h0;	// Decode.scala:14:{65,121}
  wire       _rrd_cs_decoder_T_26 = _GEN == 4'hB;	// Decode.scala:14:{65,121}
  assign io_rrd_valid = io_iss_valid;
  assign io_rrd_uop_uopc = io_iss_uop_uopc;
  assign io_rrd_uop_is_rvc = io_iss_uop_is_rvc;
  assign io_rrd_uop_fu_code = io_iss_uop_fu_code;
  assign io_rrd_uop_ctrl_br_type =
    {io_iss_uop_uopc == 7'h26,
     _rrd_cs_decoder_bit_T_13 | _rrd_cs_decoder_bit_T_2 | _rrd_cs_decoder_bit_T_8
       | _rrd_cs_decoder_bit_T_3,
     _rrd_cs_decoder_bit_T_9 | _rrd_cs_decoder_bit_T_1 | _rrd_cs_decoder_bit_T_8
       | _rrd_cs_decoder_bit_T_3,
     _rrd_cs_decoder_bit_T_4 | _rrd_cs_decoder_bit_T_1 | _rrd_cs_decoder_bit_T_2
       | _rrd_cs_decoder_bit_T_3};	// Cat.scala:30:58, Decode.scala:14:121, :15:30
  assign io_rrd_uop_ctrl_op1_sel =
    {io_iss_uop_uopc[5:3] == 3'h4,
     {io_iss_uop_uopc[6], io_iss_uop_uopc[4:3], io_iss_uop_uopc[1:0]} == 5'h0};	// Cat.scala:30:58, Decode.scala:14:{65,121}
  assign io_rrd_uop_ctrl_op2_sel =
    {1'h0,
     {io_iss_uop_uopc[5:3], io_iss_uop_uopc[1]} == 4'h8
       | {io_iss_uop_uopc[5:3], io_iss_uop_uopc[0]} == 4'h8,
     {io_iss_uop_uopc[6:4], io_iss_uop_uopc[1]} == 4'h0
       | {io_iss_uop_uopc[6], io_iss_uop_uopc[4:3]} == 3'h0
       | {io_iss_uop_uopc[6], io_iss_uop_uopc[4], io_iss_uop_uopc[2]} == 3'h0
       | {io_iss_uop_uopc[5], io_iss_uop_uopc[3:2], io_iss_uop_uopc[0]} == 4'h8
       | {io_iss_uop_uopc[5:4], io_iss_uop_uopc[1:0]} == 4'hA};	// Cat.scala:30:58, Decode.scala:14:{65,121}, :15:30
  assign io_rrd_uop_ctrl_imm_sel =
    {{io_iss_uop_uopc[5:4], io_iss_uop_uopc[1]} == 3'h4,
     _rrd_cs_decoder_T_30 | io_iss_uop_uopc[5:4] == 2'h1 | _rrd_cs_decoder_T_26,
     _rrd_cs_decoder_T_30 | _rrd_cs_decoder_T_26};	// Cat.scala:30:58, Decode.scala:14:{65,121}, :15:30
  assign io_rrd_uop_ctrl_op_fcn =
    {_rrd_cs_decoder_bit_T_143 | _rrd_cs_decoder_bit_T_88 | _rrd_cs_decoder_bit_T_56
       | _rrd_cs_decoder_bit_T_59 | _rrd_cs_decoder_bit_T_89 | _rrd_cs_decoder_bit_T_116
       | _rrd_cs_decoder_bit_T_90 | _rrd_cs_decoder_bit_T_63 | _rrd_cs_decoder_bit_T_92
       | _rrd_cs_decoder_bit_T_66 | _rrd_cs_decoder_bit_T_9 | _rrd_cs_decoder_bit_T_4
       | _rrd_cs_decoder_bit_T_1 | _rrd_cs_decoder_bit_T_13 | _rrd_cs_decoder_bit_T_2
       | _rrd_cs_decoder_bit_T_8,
     _rrd_cs_decoder_bit_T_118 | _rrd_cs_decoder_bit_T_87 | io_iss_uop_uopc == 7'h8
       | _rrd_cs_decoder_bit_T_143 | _rrd_cs_decoder_bit_T_88 | _rrd_cs_decoder_bit_T_57
       | _rrd_cs_decoder_bit_T_60 | _rrd_cs_decoder_bit_T_116 | _rrd_cs_decoder_bit_T_90
       | _rrd_cs_decoder_bit_T_62 | _rrd_cs_decoder_bit_T_91 | io_iss_uop_uopc == 7'h15
       | _rrd_cs_decoder_bit_T_64 | _rrd_cs_decoder_bit_T_67 | _rrd_cs_decoder_bit_T_1
       | _rrd_cs_decoder_bit_T_13 | _rrd_cs_decoder_bit_T_2 | _rrd_cs_decoder_bit_T_8
       | io_iss_uop_uopc == 7'h39 | _rrd_cs_decoder_bit_T_23 | _rrd_cs_decoder_bit_T_24
       | _rrd_cs_decoder_bit_T_25 | _rrd_cs_decoder_bit_T_26 | _rrd_cs_decoder_bit_T_27
       | _rrd_cs_decoder_bit_T_28 | _rrd_cs_decoder_bit_T_29,
     _rrd_cs_decoder_bit_T_118 | _rrd_cs_decoder_bit_T_87 | _rrd_cs_decoder_bit_T_88
       | _rrd_cs_decoder_bit_T_56 | _rrd_cs_decoder_bit_T_59 | _rrd_cs_decoder_bit_T_89
       | _rrd_cs_decoder_bit_T_90 | _rrd_cs_decoder_bit_T_62 | _rrd_cs_decoder_bit_T_91
       | _rrd_cs_decoder_bit_T_63 | _rrd_cs_decoder_bit_T_92 | _rrd_cs_decoder_bit_T_66
       | _rrd_cs_decoder_bit_T_9 | _rrd_cs_decoder_bit_T_4 | _rrd_cs_decoder_bit_T_13
       | _rrd_cs_decoder_bit_T_8 | _rrd_cs_decoder_bit_T_19 | io_iss_uop_uopc == 7'h37
       | _rrd_cs_decoder_bit_T_24 | _rrd_cs_decoder_bit_T_25 | _rrd_cs_decoder_bit_T_28
       | _rrd_cs_decoder_bit_T_29,
     _rrd_cs_decoder_bit_T_118 | io_iss_uop_uopc == 7'hB | _rrd_cs_decoder_bit_T_56
       | _rrd_cs_decoder_bit_T_57 | _rrd_cs_decoder_bit_T_58 | _rrd_cs_decoder_bit_T_59
       | _rrd_cs_decoder_bit_T_60 | io_iss_uop_uopc == 7'hE | _rrd_cs_decoder_bit_T_62
       | _rrd_cs_decoder_bit_T_63 | _rrd_cs_decoder_bit_T_64 | _rrd_cs_decoder_bit_T_65
       | _rrd_cs_decoder_bit_T_66 | _rrd_cs_decoder_bit_T_67 | io_iss_uop_uopc == 7'h35
       | _rrd_cs_decoder_bit_T_19 | _rrd_cs_decoder_bit_T_23 | _rrd_cs_decoder_bit_T_25
       | _rrd_cs_decoder_bit_T_27 | _rrd_cs_decoder_bit_T_29};	// Cat.scala:30:58, Decode.scala:14:121, :15:30
  assign io_rrd_uop_ctrl_fcn_dw =
    ~(io_iss_uop_uopc == 7'h2B | _rrd_cs_decoder_bit_T_58 | _rrd_cs_decoder_bit_T_59
      | _rrd_cs_decoder_bit_T_60 | io_iss_uop_uopc == 7'h2C | _rrd_cs_decoder_bit_T_92
      | _rrd_cs_decoder_bit_T_65 | _rrd_cs_decoder_bit_T_66 | _rrd_cs_decoder_bit_T_67
      | io_iss_uop_uopc == 7'h38 | _rrd_cs_decoder_bit_T_26 | _rrd_cs_decoder_bit_T_27
      | _rrd_cs_decoder_bit_T_28 | _rrd_cs_decoder_bit_T_29);	// Decode.scala:14:121, :15:30, :40:35
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
    io_iss_uop_uopc == 7'h43 | io_iss_uop_uopc == 7'h1 & io_iss_uop_mem_cmd == 5'h6
      ? 20'h0
      : io_iss_uop_imm_packed;	// func-unit-decode.scala:320:16, :339:46, :340:76, :343:{39,69,91,103}, :344:27
  assign io_rrd_uop_rob_idx = io_iss_uop_rob_idx;
  assign io_rrd_uop_ldq_idx = io_iss_uop_ldq_idx;
  assign io_rrd_uop_stq_idx = io_iss_uop_stq_idx;
  assign io_rrd_uop_pdst = io_iss_uop_pdst;
  assign io_rrd_uop_prs1 = io_iss_uop_prs1;
  assign io_rrd_uop_prs2 = io_iss_uop_prs2;
  assign io_rrd_uop_bypassable = io_iss_uop_bypassable;
  assign io_rrd_uop_is_amo = io_iss_uop_is_amo;
  assign io_rrd_uop_uses_stq = io_iss_uop_uses_stq;
  assign io_rrd_uop_dst_rtype = io_iss_uop_dst_rtype;
  assign io_rrd_uop_lrs1_rtype = io_iss_uop_lrs1_rtype;
  assign io_rrd_uop_lrs2_rtype = io_iss_uop_lrs2_rtype;
endmodule

