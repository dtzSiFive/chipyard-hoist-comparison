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

module ALU(
  input         io_dw,
  input  [3:0]  io_fn,
  input  [63:0] io_in2,
                io_in1,
  output [63:0] io_out,
                io_adder_out,
  output        io_cmp_out
);

  wire [63:0] in2_inv = {64{io_fn[3]}} ^ io_in2;	// ALU.scala:40:29, :61:20
  wire [63:0] in1_xor_in2 = io_in1 ^ in2_inv;	// ALU.scala:61:20, :62:28
  wire [63:0] _io_adder_out_T_3 = io_in1 + in2_inv + {63'h0, io_fn[3]};	// ALU.scala:40:29, :61:20, :63:36, :90:43
  wire        slt =
    io_in1[63] == io_in2[63] ? _io_adder_out_T_3[63] : io_fn[1] ? io_in2[63] : io_in1[63];	// ALU.scala:42:35, :63:36, :67:{8,15,24,34,56}, :68:8
  wire [31:0] hi = io_dw ? io_in1[63:32] : {32{io_fn[3] & io_in1[31]}};	// ALU.scala:40:29, :76:{46,55}, :77:{24,48}, Bitwise.scala:72:12
  wire        _shout_T = io_fn == 4'h5;	// ALU.scala:81:24
  wire        _shout_T_1 = io_fn == 4'hB;	// ALU.scala:81:44
  wire [31:0] _GEN = {io_in1[31:16], 16'h0} | hi & 32'hFFFF;	// ALU.scala:77:24, Bitwise.scala:103:{31,39,75}
  wire [31:0] _GEN_0 =
    {{io_in1[15:0], _GEN[31:24]} & 24'hFF00FF, 8'h0} | _GEN & 32'hFF00FF;	// Bitwise.scala:103:{21,31,39,46,75}
  wire [31:0] _GEN_1 =
    {{io_in1[7:0], _GEN_0[31:12]} & 28'hF0F0F0F, 4'h0} | _GEN_0 & 32'hF0F0F0F;	// Bitwise.scala:103:{21,31,39,46,75}
  wire [45:0] _GEN_2 =
    {io_in1[3:0], _GEN_1, _GEN_0[7:4], _GEN[11:8], _GEN[15:14]} & 46'h333333333333;	// Bitwise.scala:103:{21,31,39,46}
  wire [31:0] _GEN_3 = _GEN_2[45:14] | _GEN_1 & 32'h33333333;	// Bitwise.scala:103:{31,39,75}
  wire [1:0]  _GEN_4 = _GEN_2[11:10] | _GEN_0[5:4];	// Bitwise.scala:103:{31,39}
  wire [7:0]  _GEN_5 = {_GEN_2[5:0], 2'h0} | {_GEN[15:12], hi[19:16]} & 8'h33;	// ALU.scala:77:24, Bitwise.scala:103:{21,31,39,75}
  wire [54:0] _GEN_6 =
    {io_in1[1:0],
     _GEN_3,
     _GEN_1[3:2],
     _GEN_4,
     _GEN_0[7:6],
     _GEN[9:8],
     _GEN_5,
     hi[19:18],
     hi[21:20],
     hi[23]} & 55'h55555555555555;	// ALU.scala:77:24, Bitwise.scala:103:{21,31,39,46}
  wire [63:0] shin =
    _shout_T | _shout_T_1
      ? {hi, io_in1[31:0]}
      : {io_in1[0],
         _GEN_6[54:23] | _GEN_3 & 32'h55555555,
         _GEN_3[1],
         _GEN_6[21] | _GEN_1[2],
         {_GEN_1[3], 1'h0} | _GEN_4 & 2'h1,
         _GEN_6[18:15] | {_GEN_0[7:6], _GEN[9:8]} & 4'h5,
         _GEN_6[14:7] | _GEN_5 & 8'h55,
         _GEN_5[1],
         _GEN_6[5] | hi[18],
         hi[19],
         hi[20],
         {_GEN_6[2:0], 1'h0} | {hi[23:22], hi[25:24]} & 4'h5,
         hi[25],
         hi[26],
         hi[27],
         hi[28],
         hi[29],
         hi[30],
         hi[31]};	// ALU.scala:63:26, :77:24, :79:34, :81:{17,24,35,44}, Bitwise.scala:103:{21,31,39,46,75}, Cat.scala:30:58
  wire [64:0] _shout_r_T_4 =
    $signed($signed({io_fn[3] & shin[63], shin})
            >>> {59'h0, io_in2[5] & io_dw, io_in2[4:0]});	// ALU.scala:40:29, :78:{29,33,60}, :81:17, :82:{35,41,64}, Cat.scala:30:58
  wire [15:0] _GEN_7 =
    {{_shout_r_T_4[23:16], _shout_r_T_4[31:28]} & 12'hF0F, 4'h0}
    | {_shout_r_T_4[31:24], _shout_r_T_4[39:32]} & 16'hF0F;	// ALU.scala:82:{64,73}, Bitwise.scala:103:{21,31,39,75}
  wire [37:0] _GEN_8 =
    {_shout_r_T_4[11:8],
     _shout_r_T_4[15:12],
     _shout_r_T_4[19:16],
     _GEN_7,
     _shout_r_T_4[39:36],
     _shout_r_T_4[43:40],
     _shout_r_T_4[47:46]} & 38'h3333333333;	// ALU.scala:82:64, Bitwise.scala:103:{21,31,39}
  wire [7:0]  _GEN_9 = _GEN_8[37:30] | {_shout_r_T_4[15:12], _shout_r_T_4[19:16]} & 8'h33;	// ALU.scala:82:64, Bitwise.scala:103:{31,39,75}
  wire [15:0] _GEN_10 = _GEN_8[29:14] | _GEN_7 & 16'h3333;	// Bitwise.scala:103:{31,39,75}
  wire [1:0]  _GEN_11 = _GEN_8[11:10] | _shout_r_T_4[37:36];	// ALU.scala:82:64, Bitwise.scala:103:{31,39}
  wire [7:0]  _GEN_12 =
    {_GEN_8[5:0], 2'h0} | {_shout_r_T_4[47:44], _shout_r_T_4[51:48]} & 8'h33;	// ALU.scala:82:64, Bitwise.scala:103:{21,31,39,75}
  wire [50:0] _GEN_13 =
    {_shout_r_T_4[5:4],
     _shout_r_T_4[7:6],
     _shout_r_T_4[9:8],
     _GEN_9,
     _GEN_10,
     _GEN_7[3:2],
     _GEN_11,
     _shout_r_T_4[39:38],
     _shout_r_T_4[41:40],
     _GEN_12,
     _shout_r_T_4[51:50],
     _shout_r_T_4[53:52],
     _shout_r_T_4[55]} & 51'h5555555555555;	// ALU.scala:82:64, Bitwise.scala:103:{21,31,39}
  wire        _logic_T_4 = io_fn == 4'h6;	// ALU.scala:88:45
  wire [63:0] out =
    io_fn == 4'h0 | io_fn == 4'hA
      ? _io_adder_out_T_3
      : {63'h0, io_fn > 4'hB & slt} | (io_fn == 4'h4 | _logic_T_4 ? in1_xor_in2 : 64'h0)
        | (_logic_T_4 | io_fn == 4'h7 ? io_in1 & io_in2 : 64'h0)
        | (_shout_T | _shout_T_1 ? _shout_r_T_4[63:0] : 64'h0)
        | (io_fn == 4'h1
             ? {_shout_r_T_4[0],
                _shout_r_T_4[1],
                _shout_r_T_4[2],
                _shout_r_T_4[3],
                _shout_r_T_4[4],
                _GEN_13[50:47] | {_shout_r_T_4[7:6], _shout_r_T_4[9:8]} & 4'h5,
                _GEN_13[46:39] | _GEN_9 & 8'h55,
                _GEN_13[38:23] | _GEN_10 & 16'h5555,
                _GEN_10[1],
                _GEN_13[21] | _GEN_7[2],
                {_GEN_7[3], 1'h0} | _GEN_11 & 2'h1,
                _GEN_13[18:15] | {_shout_r_T_4[39:38], _shout_r_T_4[41:40]} & 4'h5,
                _GEN_13[14:7] | _GEN_12 & 8'h55,
                _GEN_12[1],
                _GEN_13[5] | _shout_r_T_4[50],
                _shout_r_T_4[51],
                _shout_r_T_4[52],
                {_GEN_13[2:0], 1'h0} | {_shout_r_T_4[55:54], _shout_r_T_4[57:56]} & 4'h5,
                _shout_r_T_4[57],
                _shout_r_T_4[58],
                _shout_r_T_4[59],
                _shout_r_T_4[60],
                _shout_r_T_4[61],
                _shout_r_T_4[62],
                _shout_r_T_4[63]}
             : 64'h0);	// ALU.scala:41:30, :62:28, :63:{26,36}, :67:8, :81:{24,44}, :82:{64,73}, :84:{18,35}, :85:{18,25}, :88:{18,25,36,45}, :89:{18,35,44,63}, :90:{35,43,51}, :91:{16,23,34,43}, Bitwise.scala:103:{21,31,39,46,75}
  assign io_out = io_dw ? out : {{32{out[31]}}, out[31:0]};	// ALU.scala:91:16, :93:10, :96:{28,37,56,66}, Bitwise.scala:72:12, Cat.scala:30:58
  assign io_adder_out = _io_adder_out_T_3;	// ALU.scala:63:36
  assign io_cmp_out = io_fn[0] ^ (io_fn[3] ? slt : in1_xor_in2 == 64'h0);	// ALU.scala:40:29, :43:35, :62:28, :67:8, :69:{36,41,68}, :84:18
endmodule

