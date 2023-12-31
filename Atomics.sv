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

module Atomics(
  input         io_write,
  input  [2:0]  io_a_opcode,
                io_a_param,
  input  [7:0]  io_a_mask,
  input  [63:0] io_a_data,
                io_data_in,
  output [63:0] io_data_out
);

  wire [3:0][3:0] _GEN = {4'hC, 4'h8, 4'hE, 4'h6};	// Atomics.scala:42:8
  wire [7:0]      signBit = io_a_mask & {1'h1, ~(io_a_mask[7:1])};	// Atomics.scala:23:{27,42}, Cat.scala:30:58
  wire [63:0]     _sum_T_18 =
    ({{8{io_a_mask[7]}},
      {8{io_a_mask[6]}},
      {8{io_a_mask[5]}},
      {8{io_a_mask[4]}},
      {8{io_a_mask[3]}},
      {8{io_a_mask[2]}},
      {8{io_a_mask[1]}},
      {8{io_a_mask[0]}}} & io_a_data) + ({64{~(io_a_param[2])}} ^ io_data_in);	// Atomics.scala:19:28, :24:18, :25:{44,57}, Bitwise.scala:26:51, :72:12, Cat.scala:30:58
  wire [7:0]      _sign_a_T_57 =
    {io_a_data[63],
     io_a_data[55],
     io_a_data[47],
     io_a_data[39],
     io_a_data[31],
     io_a_data[23],
     io_a_data[15],
     io_a_data[7]} & signBit;	// Atomics.scala:23:27, :26:{36,83}, Cat.scala:30:58
  wire [3:0]      _GEN_0 = _GEN[io_a_param[1:0]];	// Atomics.scala:40:15, :42:8
  wire [3:0]      _logical_T_1 = _GEN_0 >> {2'h0, io_a_data[0], io_data_in[0]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_3 = _GEN_0 >> {2'h0, io_a_data[1], io_data_in[1]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_5 = _GEN_0 >> {2'h0, io_a_data[2], io_data_in[2]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_7 = _GEN_0 >> {2'h0, io_a_data[3], io_data_in[3]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_9 = _GEN_0 >> {2'h0, io_a_data[4], io_data_in[4]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_11 = _GEN_0 >> {2'h0, io_a_data[5], io_data_in[5]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_13 = _GEN_0 >> {2'h0, io_a_data[6], io_data_in[6]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_15 = _GEN_0 >> {2'h0, io_a_data[7], io_data_in[7]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_17 = _GEN_0 >> {2'h0, io_a_data[8], io_data_in[8]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_19 = _GEN_0 >> {2'h0, io_a_data[9], io_data_in[9]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_21 = _GEN_0 >> {2'h0, io_a_data[10], io_data_in[10]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_23 = _GEN_0 >> {2'h0, io_a_data[11], io_data_in[11]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_25 = _GEN_0 >> {2'h0, io_a_data[12], io_data_in[12]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_27 = _GEN_0 >> {2'h0, io_a_data[13], io_data_in[13]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_29 = _GEN_0 >> {2'h0, io_a_data[14], io_data_in[14]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_31 = _GEN_0 >> {2'h0, io_a_data[15], io_data_in[15]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_33 = _GEN_0 >> {2'h0, io_a_data[16], io_data_in[16]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_35 = _GEN_0 >> {2'h0, io_a_data[17], io_data_in[17]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_37 = _GEN_0 >> {2'h0, io_a_data[18], io_data_in[18]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_39 = _GEN_0 >> {2'h0, io_a_data[19], io_data_in[19]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_41 = _GEN_0 >> {2'h0, io_a_data[20], io_data_in[20]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_43 = _GEN_0 >> {2'h0, io_a_data[21], io_data_in[21]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_45 = _GEN_0 >> {2'h0, io_a_data[22], io_data_in[22]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_47 = _GEN_0 >> {2'h0, io_a_data[23], io_data_in[23]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_49 = _GEN_0 >> {2'h0, io_a_data[24], io_data_in[24]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_51 = _GEN_0 >> {2'h0, io_a_data[25], io_data_in[25]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_53 = _GEN_0 >> {2'h0, io_a_data[26], io_data_in[26]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_55 = _GEN_0 >> {2'h0, io_a_data[27], io_data_in[27]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_57 = _GEN_0 >> {2'h0, io_a_data[28], io_data_in[28]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_59 = _GEN_0 >> {2'h0, io_a_data[29], io_data_in[29]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_61 = _GEN_0 >> {2'h0, io_a_data[30], io_data_in[30]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_63 = _GEN_0 >> {2'h0, io_a_data[31], io_data_in[31]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_65 = _GEN_0 >> {2'h0, io_a_data[32], io_data_in[32]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_67 = _GEN_0 >> {2'h0, io_a_data[33], io_data_in[33]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_69 = _GEN_0 >> {2'h0, io_a_data[34], io_data_in[34]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_71 = _GEN_0 >> {2'h0, io_a_data[35], io_data_in[35]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_73 = _GEN_0 >> {2'h0, io_a_data[36], io_data_in[36]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_75 = _GEN_0 >> {2'h0, io_a_data[37], io_data_in[37]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_77 = _GEN_0 >> {2'h0, io_a_data[38], io_data_in[38]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_79 = _GEN_0 >> {2'h0, io_a_data[39], io_data_in[39]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_81 = _GEN_0 >> {2'h0, io_a_data[40], io_data_in[40]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_83 = _GEN_0 >> {2'h0, io_a_data[41], io_data_in[41]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_85 = _GEN_0 >> {2'h0, io_a_data[42], io_data_in[42]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_87 = _GEN_0 >> {2'h0, io_a_data[43], io_data_in[43]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_89 = _GEN_0 >> {2'h0, io_a_data[44], io_data_in[44]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_91 = _GEN_0 >> {2'h0, io_a_data[45], io_data_in[45]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_93 = _GEN_0 >> {2'h0, io_a_data[46], io_data_in[46]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_95 = _GEN_0 >> {2'h0, io_a_data[47], io_data_in[47]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_97 = _GEN_0 >> {2'h0, io_a_data[48], io_data_in[48]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_99 = _GEN_0 >> {2'h0, io_a_data[49], io_data_in[49]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_101 = _GEN_0 >> {2'h0, io_a_data[50], io_data_in[50]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_103 = _GEN_0 >> {2'h0, io_a_data[51], io_data_in[51]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_105 = _GEN_0 >> {2'h0, io_a_data[52], io_data_in[52]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_107 = _GEN_0 >> {2'h0, io_a_data[53], io_data_in[53]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_109 = _GEN_0 >> {2'h0, io_a_data[54], io_data_in[54]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_111 = _GEN_0 >> {2'h0, io_a_data[55], io_data_in[55]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_113 = _GEN_0 >> {2'h0, io_a_data[56], io_data_in[56]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_115 = _GEN_0 >> {2'h0, io_a_data[57], io_data_in[57]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_117 = _GEN_0 >> {2'h0, io_a_data[58], io_data_in[58]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_119 = _GEN_0 >> {2'h0, io_a_data[59], io_data_in[59]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_121 = _GEN_0 >> {2'h0, io_a_data[60], io_data_in[60]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_123 = _GEN_0 >> {2'h0, io_a_data[61], io_data_in[61]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_125 = _GEN_0 >> {2'h0, io_a_data[62], io_data_in[62]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [3:0]      _logical_T_127 = _GEN_0 >> {2'h0, io_a_data[63], io_data_in[63]};	// Atomics.scala:26:36, :42:8, :46:42
  wire [7:0][1:0] _GEN_1 =
    {{2'h0},
     {2'h0},
     {2'h0},
     {2'h0},
     {2'h3},
     {io_a_param[2]
        ? 2'h2
        : {1'h0,
           io_a_param[0] == ((|_sign_a_T_57) == (|({io_data_in[63],
                                                    io_data_in[55],
                                                    io_data_in[47],
                                                    io_data_in[39],
                                                    io_data_in[31],
                                                    io_data_in[23],
                                                    io_data_in[15],
                                                    io_data_in[7]} & signBit))
                               ? ({_sum_T_18[63],
                                   _sum_T_18[55],
                                   _sum_T_18[47],
                                   _sum_T_18[39],
                                   _sum_T_18[31],
                                   _sum_T_18[23],
                                   _sum_T_18[15],
                                   _sum_T_18[7]} & signBit) == 8'h0
                               : io_a_param[1] == (|_sign_a_T_57))}},
     {2'h1},
     {2'h1}};	// Atomics.scala:19:28, :20:28, :21:28, :23:27, :25:57, :26:{36,83,97}, :30:32, :31:{21,29}, :32:25, :46:{19,42}, :49:8, Bitwise.scala:72:12, Cat.scala:30:58
  wire [1:0]      select = io_write ? 2'h1 : _GEN_1[io_a_opcode];	// Atomics.scala:46:{19,42}
  wire [3:0][7:0] _GEN_2 =
    {{{_logical_T_31[0],
       _logical_T_29[0],
       _logical_T_27[0],
       _logical_T_25[0],
       _logical_T_23[0],
       _logical_T_21[0],
       _logical_T_19[0],
       _logical_T_17[0]}},
     {_sum_T_18[15:8]},
     {io_a_data[15:8]},
     {io_data_in[15:8]}};	// Atomics.scala:25:57, :42:8, :60:55, Cat.scala:30:58
  wire [3:0][7:0] _GEN_3 =
    {{{_logical_T_15[0],
       _logical_T_13[0],
       _logical_T_11[0],
       _logical_T_9[0],
       _logical_T_7[0],
       _logical_T_5[0],
       _logical_T_3[0],
       _logical_T_1[0]}},
     {_sum_T_18[7:0]},
     {io_a_data[7:0]},
     {io_data_in[7:0]}};	// Atomics.scala:25:57, :42:8, :60:55, Cat.scala:30:58
  wire [3:0][7:0] _GEN_4 =
    {{{_logical_T_63[0],
       _logical_T_61[0],
       _logical_T_59[0],
       _logical_T_57[0],
       _logical_T_55[0],
       _logical_T_53[0],
       _logical_T_51[0],
       _logical_T_49[0]}},
     {_sum_T_18[31:24]},
     {io_a_data[31:24]},
     {io_data_in[31:24]}};	// Atomics.scala:25:57, :42:8, :60:55, Cat.scala:30:58
  wire [3:0][7:0] _GEN_5 =
    {{{_logical_T_47[0],
       _logical_T_45[0],
       _logical_T_43[0],
       _logical_T_41[0],
       _logical_T_39[0],
       _logical_T_37[0],
       _logical_T_35[0],
       _logical_T_33[0]}},
     {_sum_T_18[23:16]},
     {io_a_data[23:16]},
     {io_data_in[23:16]}};	// Atomics.scala:25:57, :42:8, :60:55, Cat.scala:30:58
  wire [3:0][7:0] _GEN_6 =
    {{{_logical_T_95[0],
       _logical_T_93[0],
       _logical_T_91[0],
       _logical_T_89[0],
       _logical_T_87[0],
       _logical_T_85[0],
       _logical_T_83[0],
       _logical_T_81[0]}},
     {_sum_T_18[47:40]},
     {io_a_data[47:40]},
     {io_data_in[47:40]}};	// Atomics.scala:25:57, :42:8, :60:55, Cat.scala:30:58
  wire [3:0][7:0] _GEN_7 =
    {{{_logical_T_79[0],
       _logical_T_77[0],
       _logical_T_75[0],
       _logical_T_73[0],
       _logical_T_71[0],
       _logical_T_69[0],
       _logical_T_67[0],
       _logical_T_65[0]}},
     {_sum_T_18[39:32]},
     {io_a_data[39:32]},
     {io_data_in[39:32]}};	// Atomics.scala:25:57, :42:8, :60:55, Cat.scala:30:58
  wire [3:0][7:0] _GEN_8 =
    {{{_logical_T_127[0],
       _logical_T_125[0],
       _logical_T_123[0],
       _logical_T_121[0],
       _logical_T_119[0],
       _logical_T_117[0],
       _logical_T_115[0],
       _logical_T_113[0]}},
     {_sum_T_18[63:56]},
     {io_a_data[63:56]},
     {io_data_in[63:56]}};	// Atomics.scala:25:57, :42:8, :60:55, Cat.scala:30:58
  wire [3:0][7:0] _GEN_9 =
    {{{_logical_T_111[0],
       _logical_T_109[0],
       _logical_T_107[0],
       _logical_T_105[0],
       _logical_T_103[0],
       _logical_T_101[0],
       _logical_T_99[0],
       _logical_T_97[0]}},
     {_sum_T_18[55:48]},
     {io_a_data[55:48]},
     {io_data_in[55:48]}};	// Atomics.scala:25:57, :42:8, :60:55, Cat.scala:30:58
  assign io_data_out =
    {_GEN_8[io_a_mask[7] ? select : 2'h0],
     _GEN_9[io_a_mask[6] ? select : 2'h0],
     _GEN_6[io_a_mask[5] ? select : 2'h0],
     _GEN_7[io_a_mask[4] ? select : 2'h0],
     _GEN_4[io_a_mask[3] ? select : 2'h0],
     _GEN_5[io_a_mask[2] ? select : 2'h0],
     _GEN_2[io_a_mask[1] ? select : 2'h0],
     _GEN_3[io_a_mask[0] ? select : 2'h0]};	// Atomics.scala:46:{19,42}, :58:47, Bitwise.scala:26:51, Cat.scala:30:58
endmodule

