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

module RegisterReadDecode_12(
  input  [6:0]  io_iss_uop_uopc,
  input  [19:0] io_iss_uop_imm_packed,
  input  [4:0]  io_iss_uop_mem_cmd,
  output [3:0]  io_rrd_uop_ctrl_br_type,
  output [1:0]  io_rrd_uop_ctrl_op1_sel,
  output [2:0]  io_rrd_uop_ctrl_op2_sel,
                io_rrd_uop_ctrl_imm_sel,
  output [3:0]  io_rrd_uop_ctrl_op_fcn,
  output        io_rrd_uop_ctrl_fcn_dw,
  output [19:0] io_rrd_uop_imm_packed
);

  wire _rrd_cs_decoder_bit_T_3 = io_iss_uop_uopc == 7'h19;	// Decode.scala:14:121
  wire _rrd_cs_decoder_bit_T_1 = io_iss_uop_uopc == 7'h1A;	// Decode.scala:14:121
  wire _rrd_cs_decoder_bit_T_2 = io_iss_uop_uopc == 7'h1C;	// Decode.scala:14:121
  wire _rrd_cs_decoder_bit_T_7 = io_iss_uop_uopc == 7'h18;	// Decode.scala:14:121
  wire _rrd_cs_decoder_bit_T_6 = io_iss_uop_uopc == 7'h1D;	// Decode.scala:14:121
  wire _rrd_cs_decoder_bit_T_10 = io_iss_uop_uopc == 7'h1B;	// Decode.scala:14:121
  wire _rrd_cs_decoder_bit_T_14 = io_iss_uop_uopc == 7'h36;	// Decode.scala:14:121
  wire _rrd_cs_decoder_bit_T_18 = io_iss_uop_uopc == 7'h3A;	// Decode.scala:14:121
  wire _rrd_cs_decoder_bit_T_19 = io_iss_uop_uopc == 7'h3B;	// Decode.scala:14:121
  wire _rrd_cs_decoder_bit_T_20 = io_iss_uop_uopc == 7'h3C;	// Decode.scala:14:121
  wire _rrd_cs_decoder_bit_T_21 = io_iss_uop_uopc == 7'h3D;	// Decode.scala:14:121
  wire _rrd_cs_decoder_bit_T_22 = io_iss_uop_uopc == 7'h3E;	// Decode.scala:14:121
  wire _rrd_cs_decoder_bit_T_23 = io_iss_uop_uopc == 7'h3F;	// Decode.scala:14:121
  wire _rrd_cs_decoder_bit_T_24 = io_iss_uop_uopc == 7'h40;	// Decode.scala:14:121
  wire _rrd_cs_decoder_bit_T_113 = io_iss_uop_uopc == 7'h6;	// Decode.scala:14:121
  wire _rrd_cs_decoder_bit_T_51 = io_iss_uop_uopc == 7'hC;	// Decode.scala:14:121
  wire _rrd_cs_decoder_bit_T_52 = io_iss_uop_uopc == 7'hD;	// Decode.scala:14:121
  wire _rrd_cs_decoder_bit_T_53 = io_iss_uop_uopc == 7'h2E;	// Decode.scala:14:121
  wire _rrd_cs_decoder_bit_T_54 = io_iss_uop_uopc == 7'h30;	// Decode.scala:14:121
  wire _rrd_cs_decoder_bit_T_55 = io_iss_uop_uopc == 7'h32;	// Decode.scala:14:121
  wire _rrd_cs_decoder_bit_T_57 = io_iss_uop_uopc == 7'h13;	// Decode.scala:14:121
  wire _rrd_cs_decoder_bit_T_58 = io_iss_uop_uopc == 7'h16;	// Decode.scala:14:121
  wire _rrd_cs_decoder_bit_T_59 = io_iss_uop_uopc == 7'h17;	// Decode.scala:14:121
  wire _rrd_cs_decoder_bit_T_60 = io_iss_uop_uopc == 7'h2F;	// Decode.scala:14:121
  wire _rrd_cs_decoder_bit_T_61 = io_iss_uop_uopc == 7'h31;	// Decode.scala:14:121
  wire _rrd_cs_decoder_bit_T_62 = io_iss_uop_uopc == 7'h33;	// Decode.scala:14:121
  wire _rrd_cs_decoder_bit_T_82 = io_iss_uop_uopc == 7'h7;	// Decode.scala:14:121
  wire _rrd_cs_decoder_bit_T_83 = io_iss_uop_uopc == 7'hA;	// Decode.scala:14:121
  wire _rrd_cs_decoder_bit_T_84 = io_iss_uop_uopc == 7'h10;	// Decode.scala:14:121
  wire _rrd_cs_decoder_bit_T_85 = io_iss_uop_uopc == 7'h12;	// Decode.scala:14:121
  wire _rrd_cs_decoder_bit_T_86 = io_iss_uop_uopc == 7'h14;	// Decode.scala:14:121
  wire _rrd_cs_decoder_bit_T_87 = io_iss_uop_uopc == 7'h2D;	// Decode.scala:14:121
  wire _rrd_cs_decoder_bit_T_138 = io_iss_uop_uopc == 7'h9;	// Decode.scala:14:121
  wire _rrd_cs_decoder_bit_T_111 = io_iss_uop_uopc == 7'h11;	// Decode.scala:14:121
  wire rrd_cs_decoder_lo_4 =
    {io_iss_uop_uopc[5], io_iss_uop_uopc[3], io_iss_uop_uopc[1:0]} == 4'h0;	// Decode.scala:14:{65,121}
  assign io_rrd_uop_ctrl_br_type =
    {1'h0,
     _rrd_cs_decoder_bit_T_10 | _rrd_cs_decoder_bit_T_2 | _rrd_cs_decoder_bit_T_6,
     _rrd_cs_decoder_bit_T_7 | _rrd_cs_decoder_bit_T_1 | _rrd_cs_decoder_bit_T_6,
     _rrd_cs_decoder_bit_T_3 | _rrd_cs_decoder_bit_T_1 | _rrd_cs_decoder_bit_T_2};	// Cat.scala:30:58, Decode.scala:14:121, :15:30
  assign io_rrd_uop_ctrl_op1_sel =
    {1'h0, {io_iss_uop_uopc[6], io_iss_uop_uopc[4:3], io_iss_uop_uopc[1:0]} == 5'h0};	// Cat.scala:30:58, Decode.scala:14:{65,121}, :15:30
  assign io_rrd_uop_ctrl_op2_sel =
    {2'h0,
     {io_iss_uop_uopc[6:4], io_iss_uop_uopc[1]} == 4'h0
       | {io_iss_uop_uopc[6], io_iss_uop_uopc[4:3]} == 3'h0
       | {io_iss_uop_uopc[6], io_iss_uop_uopc[4], io_iss_uop_uopc[2]} == 3'h0
       | {io_iss_uop_uopc[5], io_iss_uop_uopc[3:2], io_iss_uop_uopc[0]} == 4'h8
       | {io_iss_uop_uopc[5:4], io_iss_uop_uopc[1:0]} == 4'hA};	// Cat.scala:30:58, Decode.scala:14:{65,121}, :15:30, func-unit-decode.scala:341:109
  assign io_rrd_uop_ctrl_imm_sel =
    {1'h0, rrd_cs_decoder_lo_4 | io_iss_uop_uopc[5:4] == 2'h1, rrd_cs_decoder_lo_4};	// Cat.scala:30:58, Decode.scala:14:{65,121}, :15:30
  assign io_rrd_uop_ctrl_op_fcn =
    {_rrd_cs_decoder_bit_T_138 | _rrd_cs_decoder_bit_T_83 | _rrd_cs_decoder_bit_T_51
       | _rrd_cs_decoder_bit_T_54 | _rrd_cs_decoder_bit_T_84 | _rrd_cs_decoder_bit_T_111
       | _rrd_cs_decoder_bit_T_85 | _rrd_cs_decoder_bit_T_58 | _rrd_cs_decoder_bit_T_87
       | _rrd_cs_decoder_bit_T_61 | _rrd_cs_decoder_bit_T_7 | _rrd_cs_decoder_bit_T_3
       | _rrd_cs_decoder_bit_T_1 | _rrd_cs_decoder_bit_T_10 | _rrd_cs_decoder_bit_T_2
       | _rrd_cs_decoder_bit_T_6,
     _rrd_cs_decoder_bit_T_113 | _rrd_cs_decoder_bit_T_82 | io_iss_uop_uopc == 7'h8
       | _rrd_cs_decoder_bit_T_138 | _rrd_cs_decoder_bit_T_83 | _rrd_cs_decoder_bit_T_52
       | _rrd_cs_decoder_bit_T_55 | _rrd_cs_decoder_bit_T_111 | _rrd_cs_decoder_bit_T_85
       | _rrd_cs_decoder_bit_T_57 | _rrd_cs_decoder_bit_T_86 | io_iss_uop_uopc == 7'h15
       | _rrd_cs_decoder_bit_T_59 | _rrd_cs_decoder_bit_T_62 | _rrd_cs_decoder_bit_T_1
       | _rrd_cs_decoder_bit_T_10 | _rrd_cs_decoder_bit_T_2 | _rrd_cs_decoder_bit_T_6
       | io_iss_uop_uopc == 7'h39 | _rrd_cs_decoder_bit_T_18 | _rrd_cs_decoder_bit_T_19
       | _rrd_cs_decoder_bit_T_20 | _rrd_cs_decoder_bit_T_21 | _rrd_cs_decoder_bit_T_22
       | _rrd_cs_decoder_bit_T_23 | _rrd_cs_decoder_bit_T_24,
     _rrd_cs_decoder_bit_T_113 | _rrd_cs_decoder_bit_T_82 | _rrd_cs_decoder_bit_T_83
       | _rrd_cs_decoder_bit_T_51 | _rrd_cs_decoder_bit_T_54 | _rrd_cs_decoder_bit_T_84
       | _rrd_cs_decoder_bit_T_85 | _rrd_cs_decoder_bit_T_57 | _rrd_cs_decoder_bit_T_86
       | _rrd_cs_decoder_bit_T_58 | _rrd_cs_decoder_bit_T_87 | _rrd_cs_decoder_bit_T_61
       | _rrd_cs_decoder_bit_T_7 | _rrd_cs_decoder_bit_T_3 | _rrd_cs_decoder_bit_T_10
       | _rrd_cs_decoder_bit_T_6 | _rrd_cs_decoder_bit_T_14 | io_iss_uop_uopc == 7'h37
       | _rrd_cs_decoder_bit_T_19 | _rrd_cs_decoder_bit_T_20 | _rrd_cs_decoder_bit_T_23
       | _rrd_cs_decoder_bit_T_24,
     _rrd_cs_decoder_bit_T_113 | io_iss_uop_uopc == 7'hB | _rrd_cs_decoder_bit_T_51
       | _rrd_cs_decoder_bit_T_52 | _rrd_cs_decoder_bit_T_53 | _rrd_cs_decoder_bit_T_54
       | _rrd_cs_decoder_bit_T_55 | io_iss_uop_uopc == 7'hE | _rrd_cs_decoder_bit_T_57
       | _rrd_cs_decoder_bit_T_58 | _rrd_cs_decoder_bit_T_59 | _rrd_cs_decoder_bit_T_60
       | _rrd_cs_decoder_bit_T_61 | _rrd_cs_decoder_bit_T_62 | io_iss_uop_uopc == 7'h35
       | _rrd_cs_decoder_bit_T_14 | _rrd_cs_decoder_bit_T_18 | _rrd_cs_decoder_bit_T_20
       | _rrd_cs_decoder_bit_T_22 | _rrd_cs_decoder_bit_T_24};	// Cat.scala:30:58, Decode.scala:14:121, :15:30
  assign io_rrd_uop_ctrl_fcn_dw =
    ~(io_iss_uop_uopc == 7'h2B | _rrd_cs_decoder_bit_T_53 | _rrd_cs_decoder_bit_T_54
      | _rrd_cs_decoder_bit_T_55 | io_iss_uop_uopc == 7'h2C | _rrd_cs_decoder_bit_T_87
      | _rrd_cs_decoder_bit_T_60 | _rrd_cs_decoder_bit_T_61 | _rrd_cs_decoder_bit_T_62
      | io_iss_uop_uopc == 7'h38 | _rrd_cs_decoder_bit_T_21 | _rrd_cs_decoder_bit_T_22
      | _rrd_cs_decoder_bit_T_23 | _rrd_cs_decoder_bit_T_24);	// Decode.scala:14:121, :15:30, :40:35
  assign io_rrd_uop_imm_packed =
    io_iss_uop_uopc == 7'h43 | io_iss_uop_uopc == 7'h1 & io_iss_uop_mem_cmd == 5'h6
      ? 20'h0
      : io_iss_uop_imm_packed;	// func-unit-decode.scala:320:16, :339:46, :340:76, :343:{39,69,91,103}, :344:27
endmodule

