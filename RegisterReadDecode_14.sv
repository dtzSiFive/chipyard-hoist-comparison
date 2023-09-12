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

module RegisterReadDecode_14(
  input  [6:0]  io_iss_uop_uopc,
  input  [19:0] io_iss_uop_imm_packed,
  input  [4:0]  io_iss_uop_mem_cmd,
  input  [1:0]  io_iss_uop_lrs2_rtype,
  output [3:0]  io_rrd_uop_ctrl_br_type,
  output [1:0]  io_rrd_uop_ctrl_op1_sel,
  output [2:0]  io_rrd_uop_ctrl_op2_sel,
                io_rrd_uop_ctrl_imm_sel,
  output [3:0]  io_rrd_uop_ctrl_op_fcn,
  output        io_rrd_uop_ctrl_fcn_dw,
                io_rrd_uop_ctrl_is_load,
                io_rrd_uop_ctrl_is_sta,
                io_rrd_uop_ctrl_is_std,
  output [19:0] io_rrd_uop_imm_packed
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
  assign io_rrd_uop_imm_packed =
    _io_rrd_uop_ctrl_is_sta_T_1 | _io_rrd_uop_ctrl_is_load_T & io_iss_uop_mem_cmd == 5'h6
      ? 20'h0
      : io_iss_uop_imm_packed;	// Decode.scala:14:121, func-unit-decode.scala:320:16, :343:{39,69,91,103}, :344:27
endmodule

