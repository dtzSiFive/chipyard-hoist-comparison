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

module CLINT(
  input         clock,
                reset,
                auto_in_a_valid,
  input  [2:0]  auto_in_a_bits_opcode,
                auto_in_a_bits_param,
  input  [1:0]  auto_in_a_bits_size,
  input  [11:0] auto_in_a_bits_source,
  input  [25:0] auto_in_a_bits_address,
  input  [7:0]  auto_in_a_bits_mask,
  input  [63:0] auto_in_a_bits_data,
  input         auto_in_a_bits_corrupt,
                auto_in_d_ready,
                io_rtcTick,
  output        auto_int_out_5_0,
                auto_int_out_5_1,
                auto_int_out_4_0,
                auto_int_out_4_1,
                auto_int_out_3_0,
                auto_int_out_3_1,
                auto_int_out_2_0,
                auto_int_out_2_1,
                auto_int_out_1_0,
                auto_int_out_1_1,
                auto_int_out_0_0,
                auto_int_out_0_1,
  output [2:0]  auto_in_d_bits_opcode,
  output [63:0] auto_in_d_bits_data
);

  wire              out_woready_31;	// RegisterRouter.scala:79:24
  wire              out_woready_39;	// RegisterRouter.scala:79:24
  wire              out_woready_59;	// RegisterRouter.scala:79:24
  wire              out_woready_67;	// RegisterRouter.scala:79:24
  wire              out_woready_11;	// RegisterRouter.scala:79:24
  wire              out_woready_51;	// RegisterRouter.scala:79:24
  wire              out_woready_23;	// RegisterRouter.scala:79:24
  reg  [63:0]       time_0;	// CLINT.scala:69:23
  reg  [63:0]       pad;	// CLINT.scala:73:41
  reg  [63:0]       pad_1;	// CLINT.scala:73:41
  reg  [63:0]       pad_2;	// CLINT.scala:73:41
  reg  [63:0]       pad_3;	// CLINT.scala:73:41
  reg  [63:0]       pad_4;	// CLINT.scala:73:41
  reg  [63:0]       pad_5;	// CLINT.scala:73:41
  reg               ipi_0;	// CLINT.scala:74:41
  reg               ipi_1;	// CLINT.scala:74:41
  reg               ipi_2;	// CLINT.scala:74:41
  reg               ipi_3;	// CLINT.scala:74:41
  reg               ipi_4;	// CLINT.scala:74:41
  reg               ipi_5;	// CLINT.scala:74:41
  wire              out_front_bits_read = auto_in_a_bits_opcode == 3'h4;	// RegisterRouter.scala:68:36
  wire [8:0]        _GEN = {auto_in_a_bits_address[15], auto_in_a_bits_address[13:6]};	// RegisterRouter.scala:79:24
  wire              _out_out_bits_data_WIRE_13 = _GEN == 9'h0;	// RegisterRouter.scala:79:24
  wire              valids_1_0 = out_woready_11 & auto_in_a_bits_mask[0];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_1_1 = out_woready_11 & auto_in_a_bits_mask[1];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_1_2 = out_woready_11 & auto_in_a_bits_mask[2];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_1_3 = out_woready_11 & auto_in_a_bits_mask[3];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_1_4 = out_woready_11 & auto_in_a_bits_mask[4];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_1_5 = out_woready_11 & auto_in_a_bits_mask[5];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_1_6 = out_woready_11 & auto_in_a_bits_mask[6];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_1_7 = out_woready_11 & auto_in_a_bits_mask[7];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_6_0 = out_woready_23 & auto_in_a_bits_mask[0];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_6_1 = out_woready_23 & auto_in_a_bits_mask[1];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_6_2 = out_woready_23 & auto_in_a_bits_mask[2];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_6_3 = out_woready_23 & auto_in_a_bits_mask[3];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_6_4 = out_woready_23 & auto_in_a_bits_mask[4];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_6_5 = out_woready_23 & auto_in_a_bits_mask[5];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_6_6 = out_woready_23 & auto_in_a_bits_mask[6];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_6_7 = out_woready_23 & auto_in_a_bits_mask[7];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_5_0 = out_woready_31 & auto_in_a_bits_mask[0];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_5_1 = out_woready_31 & auto_in_a_bits_mask[1];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_5_2 = out_woready_31 & auto_in_a_bits_mask[2];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_5_3 = out_woready_31 & auto_in_a_bits_mask[3];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_5_4 = out_woready_31 & auto_in_a_bits_mask[4];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_5_5 = out_woready_31 & auto_in_a_bits_mask[5];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_5_6 = out_woready_31 & auto_in_a_bits_mask[6];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_5_7 = out_woready_31 & auto_in_a_bits_mask[7];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_4_0 = out_woready_39 & auto_in_a_bits_mask[0];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_4_1 = out_woready_39 & auto_in_a_bits_mask[1];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_4_2 = out_woready_39 & auto_in_a_bits_mask[2];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_4_3 = out_woready_39 & auto_in_a_bits_mask[3];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_4_4 = out_woready_39 & auto_in_a_bits_mask[4];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_4_5 = out_woready_39 & auto_in_a_bits_mask[5];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_4_6 = out_woready_39 & auto_in_a_bits_mask[6];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_4_7 = out_woready_39 & auto_in_a_bits_mask[7];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_0 = out_woready_51 & auto_in_a_bits_mask[0];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_1 = out_woready_51 & auto_in_a_bits_mask[1];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_2 = out_woready_51 & auto_in_a_bits_mask[2];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_3 = out_woready_51 & auto_in_a_bits_mask[3];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_4 = out_woready_51 & auto_in_a_bits_mask[4];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_5 = out_woready_51 & auto_in_a_bits_mask[5];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_6 = out_woready_51 & auto_in_a_bits_mask[6];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_7 = out_woready_51 & auto_in_a_bits_mask[7];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_3_0 = out_woready_59 & auto_in_a_bits_mask[0];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_3_1 = out_woready_59 & auto_in_a_bits_mask[1];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_3_2 = out_woready_59 & auto_in_a_bits_mask[2];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_3_3 = out_woready_59 & auto_in_a_bits_mask[3];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_3_4 = out_woready_59 & auto_in_a_bits_mask[4];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_3_5 = out_woready_59 & auto_in_a_bits_mask[5];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_3_6 = out_woready_59 & auto_in_a_bits_mask[6];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_3_7 = out_woready_59 & auto_in_a_bits_mask[7];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_2_0 = out_woready_67 & auto_in_a_bits_mask[0];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_2_1 = out_woready_67 & auto_in_a_bits_mask[1];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_2_2 = out_woready_67 & auto_in_a_bits_mask[2];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_2_3 = out_woready_67 & auto_in_a_bits_mask[3];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_2_4 = out_woready_67 & auto_in_a_bits_mask[4];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_2_5 = out_woready_67 & auto_in_a_bits_mask[5];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_2_6 = out_woready_67 & auto_in_a_bits_mask[6];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire              valids_2_7 = out_woready_67 & auto_in_a_bits_mask[7];	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
  wire [3:0]        out_oindex =
    {auto_in_a_bits_address[14], auto_in_a_bits_address[5:3]};	// Cat.scala:30:58, RegisterRouter.scala:79:24
  wire [3:0]        _GEN_0 = {auto_in_a_bits_address[14], auto_in_a_bits_address[5:3]};	// Cat.scala:30:58, OneHot.scala:58:35, RegisterRouter.scala:79:24
  wire              _out_wofireMux_T_2 =
    auto_in_a_valid & auto_in_d_ready & ~out_front_bits_read;	// RegisterRouter.scala:68:36, :79:24
  wire              out_woready_2 =
    _out_wofireMux_T_2 & _GEN_0 == 4'h0 & _out_out_bits_data_WIRE_13;	// OneHot.scala:58:35, RegisterRouter.scala:79:24
  wire              out_woready_14 =
    _out_wofireMux_T_2 & _GEN_0 == 4'h1 & _out_out_bits_data_WIRE_13;	// OneHot.scala:58:35, RegisterRouter.scala:79:24
  wire              out_woready_42 =
    _out_wofireMux_T_2 & _GEN_0 == 4'h2 & _out_out_bits_data_WIRE_13;	// OneHot.scala:58:35, RegisterRouter.scala:79:24
  assign out_woready_23 = _out_wofireMux_T_2 & _GEN_0 == 4'h7 & (&_GEN);	// OneHot.scala:58:35, RegisterRouter.scala:79:24
  assign out_woready_51 =
    _out_wofireMux_T_2 & _GEN_0 == 4'h8 & _out_out_bits_data_WIRE_13;	// OneHot.scala:58:35, RegisterRouter.scala:79:24
  assign out_woready_11 =
    _out_wofireMux_T_2 & _GEN_0 == 4'h9 & _out_out_bits_data_WIRE_13;	// OneHot.scala:58:35, RegisterRouter.scala:79:24
  assign out_woready_67 =
    _out_wofireMux_T_2 & _GEN_0 == 4'hA & _out_out_bits_data_WIRE_13;	// OneHot.scala:58:35, RegisterRouter.scala:79:24
  assign out_woready_59 =
    _out_wofireMux_T_2 & _GEN_0 == 4'hB & _out_out_bits_data_WIRE_13;	// OneHot.scala:58:35, RegisterRouter.scala:79:24
  assign out_woready_39 =
    _out_wofireMux_T_2 & _GEN_0 == 4'hC & _out_out_bits_data_WIRE_13;	// OneHot.scala:58:35, RegisterRouter.scala:79:24
  assign out_woready_31 =
    _out_wofireMux_T_2 & _GEN_0 == 4'hD & _out_out_bits_data_WIRE_13;	// OneHot.scala:58:35, RegisterRouter.scala:79:24
  wire [15:0]       _GEN_1 =
    {{1'h1},
     {1'h1},
     {_out_out_bits_data_WIRE_13},
     {_out_out_bits_data_WIRE_13},
     {_out_out_bits_data_WIRE_13},
     {_out_out_bits_data_WIRE_13},
     {_out_out_bits_data_WIRE_13},
     {_out_out_bits_data_WIRE_13},
     {&_GEN},
     {1'h1},
     {1'h1},
     {1'h1},
     {1'h1},
     {_out_out_bits_data_WIRE_13},
     {_out_out_bits_data_WIRE_13},
     {_out_out_bits_data_WIRE_13}};	// CLINT.scala:70:38, MuxLiteral.scala:48:10, RegisterRouter.scala:79:24
  wire [15:0][63:0] _GEN_2 =
    {{64'h0},
     {64'h0},
     {pad_5},
     {pad_4},
     {pad_3},
     {pad_2},
     {pad_1},
     {pad},
     {time_0},
     {64'h0},
     {64'h0},
     {64'h0},
     {64'h0},
     {{31'h0, ipi_5, 31'h0, ipi_4}},
     {{31'h0, ipi_3, 31'h0, ipi_2}},
     {{31'h0, ipi_1, 31'h0, ipi_0}}};	// CLINT.scala:69:23, :73:41, :74:41, MuxLiteral.scala:48:10, RegisterRouter.scala:79:24
  wire [2:0]        bundleIn_0_d_bits_opcode = {2'h0, out_front_bits_read};	// RegisterRouter.scala:68:36, :94:19
  always @(posedge clock) begin
    if (reset) begin
      time_0 <= 64'h0;	// CLINT.scala:69:23
      ipi_0 <= 1'h0;	// CLINT.scala:73:41, :74:41
      ipi_1 <= 1'h0;	// CLINT.scala:73:41, :74:41
      ipi_2 <= 1'h0;	// CLINT.scala:73:41, :74:41
      ipi_3 <= 1'h0;	// CLINT.scala:73:41, :74:41
      ipi_4 <= 1'h0;	// CLINT.scala:73:41, :74:41
      ipi_5 <= 1'h0;	// CLINT.scala:73:41, :74:41
    end
    else begin
      if (valids_6_0 | valids_6_1 | valids_6_2 | valids_6_3 | valids_6_4 | valids_6_5
          | valids_6_6 | valids_6_7)	// RegField.scala:154:27, RegisterRouter.scala:79:24
        time_0 <=
          {valids_6_7 ? auto_in_a_bits_data[63:56] : time_0[63:56],
           valids_6_6 ? auto_in_a_bits_data[55:48] : time_0[55:48],
           valids_6_5 ? auto_in_a_bits_data[47:40] : time_0[47:40],
           valids_6_4 ? auto_in_a_bits_data[39:32] : time_0[39:32],
           valids_6_3 ? auto_in_a_bits_data[31:24] : time_0[31:24],
           valids_6_2 ? auto_in_a_bits_data[23:16] : time_0[23:16],
           valids_6_1 ? auto_in_a_bits_data[15:8] : time_0[15:8],
           valids_6_0 ? auto_in_a_bits_data[7:0] : time_0[7:0]};	// CLINT.scala:69:23, RegField.scala:151:53, :154:52, :158:{20,33}, RegisterRouter.scala:79:24
      else if (io_rtcTick)
        time_0 <= time_0 + 64'h1;	// CLINT.scala:69:23, :70:38
      if (out_woready_2 & auto_in_a_bits_mask[0])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        ipi_0 <= auto_in_a_bits_data[0];	// CLINT.scala:74:41, RegisterRouter.scala:79:24
      if (out_woready_2 & auto_in_a_bits_mask[4])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        ipi_1 <= auto_in_a_bits_data[32];	// CLINT.scala:74:41, RegisterRouter.scala:79:24
      if (out_woready_14 & auto_in_a_bits_mask[0])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        ipi_2 <= auto_in_a_bits_data[0];	// CLINT.scala:74:41, RegisterRouter.scala:79:24
      if (out_woready_14 & auto_in_a_bits_mask[4])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        ipi_3 <= auto_in_a_bits_data[32];	// CLINT.scala:74:41, RegisterRouter.scala:79:24
      if (out_woready_42 & auto_in_a_bits_mask[0])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        ipi_4 <= auto_in_a_bits_data[0];	// CLINT.scala:74:41, RegisterRouter.scala:79:24
      if (out_woready_42 & auto_in_a_bits_mask[4])	// Bitwise.scala:26:51, RegisterRouter.scala:79:24
        ipi_5 <= auto_in_a_bits_data[32];	// CLINT.scala:74:41, RegisterRouter.scala:79:24
    end
    if (valids_0 | valids_1 | valids_2 | valids_3 | valids_4 | valids_5 | valids_6
        | valids_7)	// RegField.scala:154:27, RegisterRouter.scala:79:24
      pad <=
        {valids_7 ? auto_in_a_bits_data[63:56] : pad[63:56],
         valids_6 ? auto_in_a_bits_data[55:48] : pad[55:48],
         valids_5 ? auto_in_a_bits_data[47:40] : pad[47:40],
         valids_4 ? auto_in_a_bits_data[39:32] : pad[39:32],
         valids_3 ? auto_in_a_bits_data[31:24] : pad[31:24],
         valids_2 ? auto_in_a_bits_data[23:16] : pad[23:16],
         valids_1 ? auto_in_a_bits_data[15:8] : pad[15:8],
         valids_0 ? auto_in_a_bits_data[7:0] : pad[7:0]};	// CLINT.scala:73:41, RegField.scala:151:53, :154:52, :158:{20,33}, RegisterRouter.scala:79:24
    if (valids_1_0 | valids_1_1 | valids_1_2 | valids_1_3 | valids_1_4 | valids_1_5
        | valids_1_6 | valids_1_7)	// RegField.scala:154:27, RegisterRouter.scala:79:24
      pad_1 <=
        {valids_1_7 ? auto_in_a_bits_data[63:56] : pad_1[63:56],
         valids_1_6 ? auto_in_a_bits_data[55:48] : pad_1[55:48],
         valids_1_5 ? auto_in_a_bits_data[47:40] : pad_1[47:40],
         valids_1_4 ? auto_in_a_bits_data[39:32] : pad_1[39:32],
         valids_1_3 ? auto_in_a_bits_data[31:24] : pad_1[31:24],
         valids_1_2 ? auto_in_a_bits_data[23:16] : pad_1[23:16],
         valids_1_1 ? auto_in_a_bits_data[15:8] : pad_1[15:8],
         valids_1_0 ? auto_in_a_bits_data[7:0] : pad_1[7:0]};	// CLINT.scala:73:41, RegField.scala:151:53, :154:52, :158:{20,33}, RegisterRouter.scala:79:24
    if (valids_2_0 | valids_2_1 | valids_2_2 | valids_2_3 | valids_2_4 | valids_2_5
        | valids_2_6 | valids_2_7)	// RegField.scala:154:27, RegisterRouter.scala:79:24
      pad_2 <=
        {valids_2_7 ? auto_in_a_bits_data[63:56] : pad_2[63:56],
         valids_2_6 ? auto_in_a_bits_data[55:48] : pad_2[55:48],
         valids_2_5 ? auto_in_a_bits_data[47:40] : pad_2[47:40],
         valids_2_4 ? auto_in_a_bits_data[39:32] : pad_2[39:32],
         valids_2_3 ? auto_in_a_bits_data[31:24] : pad_2[31:24],
         valids_2_2 ? auto_in_a_bits_data[23:16] : pad_2[23:16],
         valids_2_1 ? auto_in_a_bits_data[15:8] : pad_2[15:8],
         valids_2_0 ? auto_in_a_bits_data[7:0] : pad_2[7:0]};	// CLINT.scala:73:41, RegField.scala:151:53, :154:52, :158:{20,33}, RegisterRouter.scala:79:24
    if (valids_3_0 | valids_3_1 | valids_3_2 | valids_3_3 | valids_3_4 | valids_3_5
        | valids_3_6 | valids_3_7)	// RegField.scala:154:27, RegisterRouter.scala:79:24
      pad_3 <=
        {valids_3_7 ? auto_in_a_bits_data[63:56] : pad_3[63:56],
         valids_3_6 ? auto_in_a_bits_data[55:48] : pad_3[55:48],
         valids_3_5 ? auto_in_a_bits_data[47:40] : pad_3[47:40],
         valids_3_4 ? auto_in_a_bits_data[39:32] : pad_3[39:32],
         valids_3_3 ? auto_in_a_bits_data[31:24] : pad_3[31:24],
         valids_3_2 ? auto_in_a_bits_data[23:16] : pad_3[23:16],
         valids_3_1 ? auto_in_a_bits_data[15:8] : pad_3[15:8],
         valids_3_0 ? auto_in_a_bits_data[7:0] : pad_3[7:0]};	// CLINT.scala:73:41, RegField.scala:151:53, :154:52, :158:{20,33}, RegisterRouter.scala:79:24
    if (valids_4_0 | valids_4_1 | valids_4_2 | valids_4_3 | valids_4_4 | valids_4_5
        | valids_4_6 | valids_4_7)	// RegField.scala:154:27, RegisterRouter.scala:79:24
      pad_4 <=
        {valids_4_7 ? auto_in_a_bits_data[63:56] : pad_4[63:56],
         valids_4_6 ? auto_in_a_bits_data[55:48] : pad_4[55:48],
         valids_4_5 ? auto_in_a_bits_data[47:40] : pad_4[47:40],
         valids_4_4 ? auto_in_a_bits_data[39:32] : pad_4[39:32],
         valids_4_3 ? auto_in_a_bits_data[31:24] : pad_4[31:24],
         valids_4_2 ? auto_in_a_bits_data[23:16] : pad_4[23:16],
         valids_4_1 ? auto_in_a_bits_data[15:8] : pad_4[15:8],
         valids_4_0 ? auto_in_a_bits_data[7:0] : pad_4[7:0]};	// CLINT.scala:73:41, RegField.scala:151:53, :154:52, :158:{20,33}, RegisterRouter.scala:79:24
    if (valids_5_0 | valids_5_1 | valids_5_2 | valids_5_3 | valids_5_4 | valids_5_5
        | valids_5_6 | valids_5_7)	// RegField.scala:154:27, RegisterRouter.scala:79:24
      pad_5 <=
        {valids_5_7 ? auto_in_a_bits_data[63:56] : pad_5[63:56],
         valids_5_6 ? auto_in_a_bits_data[55:48] : pad_5[55:48],
         valids_5_5 ? auto_in_a_bits_data[47:40] : pad_5[47:40],
         valids_5_4 ? auto_in_a_bits_data[39:32] : pad_5[39:32],
         valids_5_3 ? auto_in_a_bits_data[31:24] : pad_5[31:24],
         valids_5_2 ? auto_in_a_bits_data[23:16] : pad_5[23:16],
         valids_5_1 ? auto_in_a_bits_data[15:8] : pad_5[15:8],
         valids_5_0 ? auto_in_a_bits_data[7:0] : pad_5[7:0]};	// CLINT.scala:73:41, RegField.scala:151:53, :154:52, :158:{20,33}, RegisterRouter.scala:79:24
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:14];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [3:0] i = 4'h0; i < 4'hF; i += 4'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        time_0 = {_RANDOM[4'h0], _RANDOM[4'h1]};	// CLINT.scala:69:23
        pad = {_RANDOM[4'h2], _RANDOM[4'h3]};	// CLINT.scala:73:41
        pad_1 = {_RANDOM[4'h4], _RANDOM[4'h5]};	// CLINT.scala:73:41
        pad_2 = {_RANDOM[4'h6], _RANDOM[4'h7]};	// CLINT.scala:73:41
        pad_3 = {_RANDOM[4'h8], _RANDOM[4'h9]};	// CLINT.scala:73:41
        pad_4 = {_RANDOM[4'hA], _RANDOM[4'hB]};	// CLINT.scala:73:41
        pad_5 = {_RANDOM[4'hC], _RANDOM[4'hD]};	// CLINT.scala:73:41
        ipi_0 = _RANDOM[4'hE][0];	// CLINT.scala:74:41
        ipi_1 = _RANDOM[4'hE][1];	// CLINT.scala:74:41
        ipi_2 = _RANDOM[4'hE][2];	// CLINT.scala:74:41
        ipi_3 = _RANDOM[4'hE][3];	// CLINT.scala:74:41
        ipi_4 = _RANDOM[4'hE][4];	// CLINT.scala:74:41
        ipi_5 = _RANDOM[4'hE][5];	// CLINT.scala:74:41
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  TLMonitor_69 monitor (	// Nodes.scala:24:25
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (auto_in_d_ready),
    .io_in_a_valid        (auto_in_a_valid),
    .io_in_a_bits_opcode  (auto_in_a_bits_opcode),
    .io_in_a_bits_param   (auto_in_a_bits_param),
    .io_in_a_bits_size    (auto_in_a_bits_size),
    .io_in_a_bits_source  (auto_in_a_bits_source),
    .io_in_a_bits_address (auto_in_a_bits_address),
    .io_in_a_bits_mask    (auto_in_a_bits_mask),
    .io_in_a_bits_corrupt (auto_in_a_bits_corrupt),
    .io_in_d_ready        (auto_in_d_ready),
    .io_in_d_valid        (auto_in_a_valid),
    .io_in_d_bits_opcode  (bundleIn_0_d_bits_opcode),	// RegisterRouter.scala:94:19
    .io_in_d_bits_size    (auto_in_a_bits_size),
    .io_in_d_bits_source  (auto_in_a_bits_source)
  );
  assign auto_int_out_5_0 = ipi_5;	// CLINT.scala:74:41
  assign auto_int_out_5_1 = time_0 >= pad_5;	// CLINT.scala:69:23, :73:41, :79:43
  assign auto_int_out_4_0 = ipi_4;	// CLINT.scala:74:41
  assign auto_int_out_4_1 = time_0 >= pad_4;	// CLINT.scala:69:23, :73:41, :79:43
  assign auto_int_out_3_0 = ipi_3;	// CLINT.scala:74:41
  assign auto_int_out_3_1 = time_0 >= pad_3;	// CLINT.scala:69:23, :73:41, :79:43
  assign auto_int_out_2_0 = ipi_2;	// CLINT.scala:74:41
  assign auto_int_out_2_1 = time_0 >= pad_2;	// CLINT.scala:69:23, :73:41, :79:43
  assign auto_int_out_1_0 = ipi_1;	// CLINT.scala:74:41
  assign auto_int_out_1_1 = time_0 >= pad_1;	// CLINT.scala:69:23, :73:41, :79:43
  assign auto_int_out_0_0 = ipi_0;	// CLINT.scala:74:41
  assign auto_int_out_0_1 = time_0 >= pad;	// CLINT.scala:69:23, :73:41, :79:43
  assign auto_in_d_bits_opcode = bundleIn_0_d_bits_opcode;	// RegisterRouter.scala:94:19
  assign auto_in_d_bits_data = _GEN_1[out_oindex] ? _GEN_2[out_oindex] : 64'h0;	// CLINT.scala:69:23, Cat.scala:30:58, MuxLiteral.scala:48:10, RegisterRouter.scala:79:24
endmodule

