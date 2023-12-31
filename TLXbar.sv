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

module TLXbar(
  input         clock,
                reset,
                auto_in_6_a_valid,
  input  [2:0]  auto_in_6_a_bits_opcode,
                auto_in_6_a_bits_param,
  input  [3:0]  auto_in_6_a_bits_size,
  input  [2:0]  auto_in_6_a_bits_source,
  input  [31:0] auto_in_6_a_bits_address,
  input  [7:0]  auto_in_6_a_bits_mask,
  input  [63:0] auto_in_6_a_bits_data,
  input         auto_in_6_a_bits_corrupt,
                auto_in_6_b_ready,
                auto_in_6_c_valid,
  input  [2:0]  auto_in_6_c_bits_opcode,
                auto_in_6_c_bits_param,
  input  [3:0]  auto_in_6_c_bits_size,
  input  [2:0]  auto_in_6_c_bits_source,
  input  [31:0] auto_in_6_c_bits_address,
  input  [63:0] auto_in_6_c_bits_data,
  input         auto_in_6_c_bits_corrupt,
                auto_in_6_d_ready,
                auto_in_6_e_valid,
  input  [2:0]  auto_in_6_e_bits_sink,
  input         auto_in_5_a_valid,
  input  [2:0]  auto_in_5_a_bits_opcode,
                auto_in_5_a_bits_param,
  input  [3:0]  auto_in_5_a_bits_size,
                auto_in_5_a_bits_source,
  input  [31:0] auto_in_5_a_bits_address,
  input  [7:0]  auto_in_5_a_bits_mask,
  input  [63:0] auto_in_5_a_bits_data,
  input         auto_in_5_a_bits_corrupt,
                auto_in_5_b_ready,
                auto_in_5_c_valid,
  input  [2:0]  auto_in_5_c_bits_opcode,
                auto_in_5_c_bits_param,
  input  [3:0]  auto_in_5_c_bits_size,
                auto_in_5_c_bits_source,
  input  [31:0] auto_in_5_c_bits_address,
  input  [63:0] auto_in_5_c_bits_data,
  input         auto_in_5_c_bits_corrupt,
                auto_in_5_d_ready,
                auto_in_5_e_valid,
  input  [2:0]  auto_in_5_e_bits_sink,
  input         auto_in_4_a_valid,
  input  [2:0]  auto_in_4_a_bits_opcode,
                auto_in_4_a_bits_param,
  input  [3:0]  auto_in_4_a_bits_size,
  input  [4:0]  auto_in_4_a_bits_source,
  input  [31:0] auto_in_4_a_bits_address,
  input  [7:0]  auto_in_4_a_bits_mask,
  input  [63:0] auto_in_4_a_bits_data,
  input         auto_in_4_a_bits_corrupt,
                auto_in_4_b_ready,
                auto_in_4_c_valid,
  input  [2:0]  auto_in_4_c_bits_opcode,
                auto_in_4_c_bits_param,
  input  [3:0]  auto_in_4_c_bits_size,
  input  [4:0]  auto_in_4_c_bits_source,
  input  [31:0] auto_in_4_c_bits_address,
  input  [63:0] auto_in_4_c_bits_data,
  input         auto_in_4_c_bits_corrupt,
                auto_in_4_d_ready,
                auto_in_4_e_valid,
  input  [2:0]  auto_in_4_e_bits_sink,
  input         auto_in_3_a_valid,
  input  [2:0]  auto_in_3_a_bits_opcode,
                auto_in_3_a_bits_param,
  input  [3:0]  auto_in_3_a_bits_size,
  input  [1:0]  auto_in_3_a_bits_source,
  input  [31:0] auto_in_3_a_bits_address,
  input  [7:0]  auto_in_3_a_bits_mask,
  input  [63:0] auto_in_3_a_bits_data,
  input         auto_in_3_a_bits_corrupt,
                auto_in_3_b_ready,
                auto_in_3_c_valid,
  input  [2:0]  auto_in_3_c_bits_opcode,
                auto_in_3_c_bits_param,
  input  [3:0]  auto_in_3_c_bits_size,
  input  [1:0]  auto_in_3_c_bits_source,
  input  [31:0] auto_in_3_c_bits_address,
  input  [63:0] auto_in_3_c_bits_data,
  input         auto_in_3_c_bits_corrupt,
                auto_in_3_d_ready,
                auto_in_3_e_valid,
  input  [2:0]  auto_in_3_e_bits_sink,
  input         auto_in_2_a_valid,
  input  [2:0]  auto_in_2_a_bits_opcode,
                auto_in_2_a_bits_param,
  input  [3:0]  auto_in_2_a_bits_size,
  input  [1:0]  auto_in_2_a_bits_source,
  input  [31:0] auto_in_2_a_bits_address,
  input  [7:0]  auto_in_2_a_bits_mask,
  input  [63:0] auto_in_2_a_bits_data,
  input         auto_in_2_a_bits_corrupt,
                auto_in_2_b_ready,
                auto_in_2_c_valid,
  input  [2:0]  auto_in_2_c_bits_opcode,
                auto_in_2_c_bits_param,
  input  [3:0]  auto_in_2_c_bits_size,
  input  [1:0]  auto_in_2_c_bits_source,
  input  [31:0] auto_in_2_c_bits_address,
  input  [63:0] auto_in_2_c_bits_data,
  input         auto_in_2_c_bits_corrupt,
                auto_in_2_d_ready,
                auto_in_2_e_valid,
  input  [2:0]  auto_in_2_e_bits_sink,
  input         auto_in_1_a_valid,
  input  [2:0]  auto_in_1_a_bits_opcode,
                auto_in_1_a_bits_param,
  input  [3:0]  auto_in_1_a_bits_size,
  input  [1:0]  auto_in_1_a_bits_source,
  input  [31:0] auto_in_1_a_bits_address,
  input  [7:0]  auto_in_1_a_bits_mask,
  input  [63:0] auto_in_1_a_bits_data,
  input         auto_in_1_a_bits_corrupt,
                auto_in_1_b_ready,
                auto_in_1_c_valid,
  input  [2:0]  auto_in_1_c_bits_opcode,
                auto_in_1_c_bits_param,
  input  [3:0]  auto_in_1_c_bits_size,
  input  [1:0]  auto_in_1_c_bits_source,
  input  [31:0] auto_in_1_c_bits_address,
  input  [63:0] auto_in_1_c_bits_data,
  input         auto_in_1_c_bits_corrupt,
                auto_in_1_d_ready,
                auto_in_1_e_valid,
  input  [2:0]  auto_in_1_e_bits_sink,
  input         auto_in_0_a_valid,
  input  [2:0]  auto_in_0_a_bits_opcode,
                auto_in_0_a_bits_param,
  input  [3:0]  auto_in_0_a_bits_size,
  input         auto_in_0_a_bits_source,
  input  [31:0] auto_in_0_a_bits_address,
  input  [7:0]  auto_in_0_a_bits_mask,
  input  [63:0] auto_in_0_a_bits_data,
  input         auto_in_0_a_bits_corrupt,
                auto_in_0_d_ready,
                auto_out_1_a_ready,
                auto_out_1_b_valid,
  input  [1:0]  auto_out_1_b_bits_param,
  input  [6:0]  auto_out_1_b_bits_source,
  input  [31:0] auto_out_1_b_bits_address,
  input         auto_out_1_c_ready,
                auto_out_1_d_valid,
  input  [2:0]  auto_out_1_d_bits_opcode,
  input  [1:0]  auto_out_1_d_bits_param,
  input  [2:0]  auto_out_1_d_bits_size,
  input  [6:0]  auto_out_1_d_bits_source,
  input  [2:0]  auto_out_1_d_bits_sink,
  input         auto_out_1_d_bits_denied,
  input  [63:0] auto_out_1_d_bits_data,
  input         auto_out_1_d_bits_corrupt,
                auto_out_0_a_ready,
                auto_out_0_d_valid,
  input  [2:0]  auto_out_0_d_bits_opcode,
  input  [1:0]  auto_out_0_d_bits_param,
  input  [3:0]  auto_out_0_d_bits_size,
  input  [6:0]  auto_out_0_d_bits_source,
  input         auto_out_0_d_bits_sink,
                auto_out_0_d_bits_denied,
  input  [63:0] auto_out_0_d_bits_data,
  input         auto_out_0_d_bits_corrupt,
  output        auto_in_6_a_ready,
                auto_in_6_b_valid,
  output [2:0]  auto_in_6_b_bits_source,
  output        auto_in_6_c_ready,
                auto_in_6_d_valid,
  output [2:0]  auto_in_6_d_bits_opcode,
  output [1:0]  auto_in_6_d_bits_param,
  output [3:0]  auto_in_6_d_bits_size,
  output [2:0]  auto_in_6_d_bits_source,
                auto_in_6_d_bits_sink,
  output        auto_in_6_d_bits_denied,
  output [63:0] auto_in_6_d_bits_data,
  output        auto_in_6_d_bits_corrupt,
                auto_in_6_e_ready,
                auto_in_5_a_ready,
                auto_in_5_b_valid,
  output [3:0]  auto_in_5_b_bits_source,
  output        auto_in_5_c_ready,
                auto_in_5_d_valid,
  output [2:0]  auto_in_5_d_bits_opcode,
  output [1:0]  auto_in_5_d_bits_param,
  output [3:0]  auto_in_5_d_bits_size,
                auto_in_5_d_bits_source,
  output [2:0]  auto_in_5_d_bits_sink,
  output        auto_in_5_d_bits_denied,
  output [63:0] auto_in_5_d_bits_data,
  output        auto_in_5_d_bits_corrupt,
                auto_in_5_e_ready,
                auto_in_4_a_ready,
                auto_in_4_b_valid,
  output [4:0]  auto_in_4_b_bits_source,
  output        auto_in_4_c_ready,
                auto_in_4_d_valid,
  output [2:0]  auto_in_4_d_bits_opcode,
  output [1:0]  auto_in_4_d_bits_param,
  output [3:0]  auto_in_4_d_bits_size,
  output [4:0]  auto_in_4_d_bits_source,
  output [2:0]  auto_in_4_d_bits_sink,
  output        auto_in_4_d_bits_denied,
  output [63:0] auto_in_4_d_bits_data,
  output        auto_in_4_d_bits_corrupt,
                auto_in_4_e_ready,
                auto_in_3_a_ready,
                auto_in_3_b_valid,
  output [1:0]  auto_in_3_b_bits_source,
  output        auto_in_3_c_ready,
                auto_in_3_d_valid,
  output [2:0]  auto_in_3_d_bits_opcode,
  output [1:0]  auto_in_3_d_bits_param,
  output [3:0]  auto_in_3_d_bits_size,
  output [1:0]  auto_in_3_d_bits_source,
  output [2:0]  auto_in_3_d_bits_sink,
  output        auto_in_3_d_bits_denied,
  output [63:0] auto_in_3_d_bits_data,
  output        auto_in_3_d_bits_corrupt,
                auto_in_3_e_ready,
                auto_in_2_a_ready,
                auto_in_2_b_valid,
  output [1:0]  auto_in_2_b_bits_source,
  output        auto_in_2_c_ready,
                auto_in_2_d_valid,
  output [2:0]  auto_in_2_d_bits_opcode,
  output [1:0]  auto_in_2_d_bits_param,
  output [3:0]  auto_in_2_d_bits_size,
  output [1:0]  auto_in_2_d_bits_source,
  output [2:0]  auto_in_2_d_bits_sink,
  output        auto_in_2_d_bits_denied,
  output [63:0] auto_in_2_d_bits_data,
  output        auto_in_2_d_bits_corrupt,
                auto_in_2_e_ready,
                auto_in_1_a_ready,
                auto_in_1_b_valid,
  output [1:0]  auto_in_1_b_bits_source,
  output        auto_in_1_c_ready,
                auto_in_1_d_valid,
  output [2:0]  auto_in_1_d_bits_opcode,
  output [1:0]  auto_in_1_d_bits_param,
  output [3:0]  auto_in_1_d_bits_size,
  output [1:0]  auto_in_1_d_bits_source,
  output [2:0]  auto_in_1_d_bits_sink,
  output        auto_in_1_d_bits_denied,
  output [63:0] auto_in_1_d_bits_data,
  output        auto_in_1_d_bits_corrupt,
                auto_in_1_e_ready,
                auto_in_0_a_ready,
                auto_in_0_d_valid,
  output [2:0]  auto_in_0_d_bits_opcode,
  output [1:0]  auto_in_0_d_bits_param,
  output [3:0]  auto_in_0_d_bits_size,
  output [2:0]  auto_in_0_d_bits_sink,
  output        auto_in_0_d_bits_denied,
  output [63:0] auto_in_0_d_bits_data,
  output        auto_in_0_d_bits_corrupt,
                auto_out_1_a_valid,
  output [2:0]  auto_out_1_a_bits_opcode,
                auto_out_1_a_bits_param,
                auto_out_1_a_bits_size,
  output [6:0]  auto_out_1_a_bits_source,
  output [31:0] auto_out_1_a_bits_address,
  output [7:0]  auto_out_1_a_bits_mask,
  output [63:0] auto_out_1_a_bits_data,
  output        auto_out_1_a_bits_corrupt,
                auto_out_1_b_ready,
                auto_out_1_c_valid,
  output [2:0]  auto_out_1_c_bits_opcode,
                auto_out_1_c_bits_param,
                auto_out_1_c_bits_size,
  output [6:0]  auto_out_1_c_bits_source,
  output [31:0] auto_out_1_c_bits_address,
  output [63:0] auto_out_1_c_bits_data,
  output        auto_out_1_c_bits_corrupt,
                auto_out_1_d_ready,
                auto_out_1_e_valid,
  output [2:0]  auto_out_1_e_bits_sink,
  output        auto_out_0_a_valid,
  output [2:0]  auto_out_0_a_bits_opcode,
                auto_out_0_a_bits_param,
  output [3:0]  auto_out_0_a_bits_size,
  output [6:0]  auto_out_0_a_bits_source,
  output [30:0] auto_out_0_a_bits_address,
  output [7:0]  auto_out_0_a_bits_mask,
  output [63:0] auto_out_0_a_bits_data,
  output        auto_out_0_a_bits_corrupt,
                auto_out_0_d_ready
);

  wire        allowed_10_1;	// Arbiter.scala:121:24
  wire        allowed_10_0;	// Arbiter.scala:121:24
  wire        allowed_9_1;	// Arbiter.scala:121:24
  wire        allowed_9_0;	// Arbiter.scala:121:24
  wire        allowed_8_1;	// Arbiter.scala:121:24
  wire        allowed_8_0;	// Arbiter.scala:121:24
  wire        allowed_7_1;	// Arbiter.scala:121:24
  wire        allowed_7_0;	// Arbiter.scala:121:24
  wire        allowed_6_1;	// Arbiter.scala:121:24
  wire        allowed_6_0;	// Arbiter.scala:121:24
  wire        allowed_5_1;	// Arbiter.scala:121:24
  wire        allowed_5_0;	// Arbiter.scala:121:24
  wire        allowed_4_1;	// Arbiter.scala:121:24
  wire        allowed_4_0;	// Arbiter.scala:121:24
  wire        allowed_1_6;	// Arbiter.scala:121:24
  wire        allowed_1_5;	// Arbiter.scala:121:24
  wire        allowed_1_4;	// Arbiter.scala:121:24
  wire        allowed_1_3;	// Arbiter.scala:121:24
  wire        allowed_1_2;	// Arbiter.scala:121:24
  wire        allowed_1_1;	// Arbiter.scala:121:24
  wire        allowed_1_0;	// Arbiter.scala:121:24
  wire        allowed_6;	// Arbiter.scala:121:24
  wire        allowed_5;	// Arbiter.scala:121:24
  wire        allowed_4;	// Arbiter.scala:121:24
  wire        allowed_3;	// Arbiter.scala:121:24
  wire        allowed_2;	// Arbiter.scala:121:24
  wire        allowed_1;	// Arbiter.scala:121:24
  wire        allowed_0;	// Arbiter.scala:121:24
  wire [6:0]  portsAOI_filtered_1_bits_source = {6'h22, auto_in_0_a_bits_source};	// Xbar.scala:237:55
  wire [6:0]  portsAOI_filtered_1_1_bits_source = {5'h10, auto_in_1_a_bits_source};	// Parameters.scala:54:32, Xbar.scala:237:55
  wire [6:0]  portsAOI_filtered_2_1_bits_source = {5'hF, auto_in_2_a_bits_source};	// Parameters.scala:54:32, Xbar.scala:237:29
  wire [6:0]  portsAOI_filtered_3_1_bits_source = {5'hE, auto_in_3_a_bits_source};	// Parameters.scala:54:32, Xbar.scala:237:29
  wire [6:0]  portsAOI_filtered_4_1_bits_source = {2'h0, auto_in_4_a_bits_source};	// Xbar.scala:237:29, :254:26
  wire [6:0]  portsAOI_filtered_5_1_bits_source = {3'h2, auto_in_5_a_bits_source};	// Xbar.scala:237:29
  wire [6:0]  portsAOI_filtered_6_1_bits_source = {4'h6, auto_in_6_a_bits_source};	// Parameters.scala:54:32, Xbar.scala:237:29
  wire [2:0]  out_55_bits_sink = {2'h0, auto_out_0_d_bits_sink};	// Xbar.scala:254:26, :323:28
  wire [3:0]  out_56_bits_size = {1'h0, auto_out_1_d_bits_size};	// BundleMap.scala:247:19, Bundle_ACancel.scala:55:22
  wire [3:0]  _GEN = auto_in_0_a_bits_address[28:25] ^ 4'hA;	// Parameters.scala:137:31
  wire        requestAIO_0_0 =
    {auto_in_0_a_bits_address[31],
     auto_in_0_a_bits_address[28],
     auto_in_0_a_bits_address[26:25],
     auto_in_0_a_bits_address[17]} == 5'h0
    | {auto_in_0_a_bits_address[31],
       auto_in_0_a_bits_address[28],
       auto_in_0_a_bits_address[26],
       ~(auto_in_0_a_bits_address[25]),
       auto_in_0_a_bits_address[20],
       auto_in_0_a_bits_address[17]} == 6'h0
    | {auto_in_0_a_bits_address[31],
       auto_in_0_a_bits_address[28],
       ~(auto_in_0_a_bits_address[26])} == 3'h0
    | {auto_in_0_a_bits_address[31],
       _GEN[3],
       _GEN[1:0],
       auto_in_0_a_bits_address[20],
       auto_in_0_a_bits_address[17]} == 6'h0;	// Bundles.scala:257:54, Parameters.scala:137:{31,49,52,67}, Xbar.scala:237:55, :363:92
  wire        requestAIO_0_1 =
    {auto_in_0_a_bits_address[31],
     auto_in_0_a_bits_address[28],
     auto_in_0_a_bits_address[26:25],
     auto_in_0_a_bits_address[20],
     ~(auto_in_0_a_bits_address[17])} == 6'h0
    | {auto_in_0_a_bits_address[31],
       ~(auto_in_0_a_bits_address[28]),
       auto_in_0_a_bits_address[26:25],
       auto_in_0_a_bits_address[20],
       auto_in_0_a_bits_address[17]} == 6'h0
    | {~(auto_in_0_a_bits_address[31]), auto_in_0_a_bits_address[28]} == 2'h0;	// Parameters.scala:137:{31,49,52,67}, Xbar.scala:237:55, :254:26, :363:92
  wire [3:0]  _GEN_0 = auto_in_1_a_bits_address[28:25] ^ 4'hA;	// Parameters.scala:137:31
  wire        requestAIO_1_0 =
    {auto_in_1_a_bits_address[31],
     auto_in_1_a_bits_address[28],
     auto_in_1_a_bits_address[26:25],
     auto_in_1_a_bits_address[17]} == 5'h0
    | {auto_in_1_a_bits_address[31],
       auto_in_1_a_bits_address[28],
       auto_in_1_a_bits_address[26],
       ~(auto_in_1_a_bits_address[25]),
       auto_in_1_a_bits_address[20],
       auto_in_1_a_bits_address[17]} == 6'h0
    | {auto_in_1_a_bits_address[31],
       auto_in_1_a_bits_address[28],
       ~(auto_in_1_a_bits_address[26])} == 3'h0
    | {auto_in_1_a_bits_address[31],
       _GEN_0[3],
       _GEN_0[1:0],
       auto_in_1_a_bits_address[20],
       auto_in_1_a_bits_address[17]} == 6'h0;	// Bundles.scala:257:54, Parameters.scala:137:{31,49,52,67}, Xbar.scala:237:55, :363:92
  wire        requestAIO_1_1 =
    {auto_in_1_a_bits_address[31],
     auto_in_1_a_bits_address[28],
     auto_in_1_a_bits_address[26:25],
     auto_in_1_a_bits_address[20],
     ~(auto_in_1_a_bits_address[17])} == 6'h0
    | {auto_in_1_a_bits_address[31],
       ~(auto_in_1_a_bits_address[28]),
       auto_in_1_a_bits_address[26:25],
       auto_in_1_a_bits_address[20],
       auto_in_1_a_bits_address[17]} == 6'h0
    | {~(auto_in_1_a_bits_address[31]), auto_in_1_a_bits_address[28]} == 2'h0;	// Parameters.scala:137:{31,49,52,67}, Xbar.scala:237:55, :254:26, :363:92
  wire [3:0]  _GEN_1 = auto_in_2_a_bits_address[28:25] ^ 4'hA;	// Parameters.scala:137:31
  wire        requestAIO_2_0 =
    {auto_in_2_a_bits_address[31],
     auto_in_2_a_bits_address[28],
     auto_in_2_a_bits_address[26:25],
     auto_in_2_a_bits_address[17]} == 5'h0
    | {auto_in_2_a_bits_address[31],
       auto_in_2_a_bits_address[28],
       auto_in_2_a_bits_address[26],
       ~(auto_in_2_a_bits_address[25]),
       auto_in_2_a_bits_address[20],
       auto_in_2_a_bits_address[17]} == 6'h0
    | {auto_in_2_a_bits_address[31],
       auto_in_2_a_bits_address[28],
       ~(auto_in_2_a_bits_address[26])} == 3'h0
    | {auto_in_2_a_bits_address[31],
       _GEN_1[3],
       _GEN_1[1:0],
       auto_in_2_a_bits_address[20],
       auto_in_2_a_bits_address[17]} == 6'h0;	// Bundles.scala:257:54, Parameters.scala:137:{31,49,52,67}, Xbar.scala:237:55, :363:92
  wire        requestAIO_2_1 =
    {auto_in_2_a_bits_address[31],
     auto_in_2_a_bits_address[28],
     auto_in_2_a_bits_address[26:25],
     auto_in_2_a_bits_address[20],
     ~(auto_in_2_a_bits_address[17])} == 6'h0
    | {auto_in_2_a_bits_address[31],
       ~(auto_in_2_a_bits_address[28]),
       auto_in_2_a_bits_address[26:25],
       auto_in_2_a_bits_address[20],
       auto_in_2_a_bits_address[17]} == 6'h0
    | {~(auto_in_2_a_bits_address[31]), auto_in_2_a_bits_address[28]} == 2'h0;	// Parameters.scala:137:{31,49,52,67}, Xbar.scala:237:55, :254:26, :363:92
  wire [3:0]  _GEN_2 = auto_in_3_a_bits_address[28:25] ^ 4'hA;	// Parameters.scala:137:31
  wire        requestAIO_3_0 =
    {auto_in_3_a_bits_address[31],
     auto_in_3_a_bits_address[28],
     auto_in_3_a_bits_address[26:25],
     auto_in_3_a_bits_address[17]} == 5'h0
    | {auto_in_3_a_bits_address[31],
       auto_in_3_a_bits_address[28],
       auto_in_3_a_bits_address[26],
       ~(auto_in_3_a_bits_address[25]),
       auto_in_3_a_bits_address[20],
       auto_in_3_a_bits_address[17]} == 6'h0
    | {auto_in_3_a_bits_address[31],
       auto_in_3_a_bits_address[28],
       ~(auto_in_3_a_bits_address[26])} == 3'h0
    | {auto_in_3_a_bits_address[31],
       _GEN_2[3],
       _GEN_2[1:0],
       auto_in_3_a_bits_address[20],
       auto_in_3_a_bits_address[17]} == 6'h0;	// Bundles.scala:257:54, Parameters.scala:137:{31,49,52,67}, Xbar.scala:237:55, :363:92
  wire        requestAIO_3_1 =
    {auto_in_3_a_bits_address[31],
     auto_in_3_a_bits_address[28],
     auto_in_3_a_bits_address[26:25],
     auto_in_3_a_bits_address[20],
     ~(auto_in_3_a_bits_address[17])} == 6'h0
    | {auto_in_3_a_bits_address[31],
       ~(auto_in_3_a_bits_address[28]),
       auto_in_3_a_bits_address[26:25],
       auto_in_3_a_bits_address[20],
       auto_in_3_a_bits_address[17]} == 6'h0
    | {~(auto_in_3_a_bits_address[31]), auto_in_3_a_bits_address[28]} == 2'h0;	// Parameters.scala:137:{31,49,52,67}, Xbar.scala:237:55, :254:26, :363:92
  wire [3:0]  _GEN_3 = auto_in_4_a_bits_address[28:25] ^ 4'hA;	// Parameters.scala:137:31
  wire        requestAIO_4_0 =
    {auto_in_4_a_bits_address[31],
     auto_in_4_a_bits_address[28],
     auto_in_4_a_bits_address[26:25],
     auto_in_4_a_bits_address[17]} == 5'h0
    | {auto_in_4_a_bits_address[31],
       auto_in_4_a_bits_address[28],
       auto_in_4_a_bits_address[26],
       ~(auto_in_4_a_bits_address[25]),
       auto_in_4_a_bits_address[20],
       auto_in_4_a_bits_address[17]} == 6'h0
    | {auto_in_4_a_bits_address[31],
       auto_in_4_a_bits_address[28],
       ~(auto_in_4_a_bits_address[26])} == 3'h0
    | {auto_in_4_a_bits_address[31],
       _GEN_3[3],
       _GEN_3[1:0],
       auto_in_4_a_bits_address[20],
       auto_in_4_a_bits_address[17]} == 6'h0;	// Bundles.scala:257:54, Parameters.scala:137:{31,49,52,67}, Xbar.scala:237:55, :363:92
  wire        requestAIO_4_1 =
    {auto_in_4_a_bits_address[31],
     auto_in_4_a_bits_address[28],
     auto_in_4_a_bits_address[26:25],
     auto_in_4_a_bits_address[20],
     ~(auto_in_4_a_bits_address[17])} == 6'h0
    | {auto_in_4_a_bits_address[31],
       ~(auto_in_4_a_bits_address[28]),
       auto_in_4_a_bits_address[26:25],
       auto_in_4_a_bits_address[20],
       auto_in_4_a_bits_address[17]} == 6'h0
    | {~(auto_in_4_a_bits_address[31]), auto_in_4_a_bits_address[28]} == 2'h0;	// Parameters.scala:137:{31,49,52,67}, Xbar.scala:237:55, :254:26, :363:92
  wire [3:0]  _GEN_4 = auto_in_5_a_bits_address[28:25] ^ 4'hA;	// Parameters.scala:137:31
  wire        requestAIO_5_0 =
    {auto_in_5_a_bits_address[31],
     auto_in_5_a_bits_address[28],
     auto_in_5_a_bits_address[26:25],
     auto_in_5_a_bits_address[17]} == 5'h0
    | {auto_in_5_a_bits_address[31],
       auto_in_5_a_bits_address[28],
       auto_in_5_a_bits_address[26],
       ~(auto_in_5_a_bits_address[25]),
       auto_in_5_a_bits_address[20],
       auto_in_5_a_bits_address[17]} == 6'h0
    | {auto_in_5_a_bits_address[31],
       auto_in_5_a_bits_address[28],
       ~(auto_in_5_a_bits_address[26])} == 3'h0
    | {auto_in_5_a_bits_address[31],
       _GEN_4[3],
       _GEN_4[1:0],
       auto_in_5_a_bits_address[20],
       auto_in_5_a_bits_address[17]} == 6'h0;	// Bundles.scala:257:54, Parameters.scala:137:{31,49,52,67}, Xbar.scala:237:55, :363:92
  wire        requestAIO_5_1 =
    {auto_in_5_a_bits_address[31],
     auto_in_5_a_bits_address[28],
     auto_in_5_a_bits_address[26:25],
     auto_in_5_a_bits_address[20],
     ~(auto_in_5_a_bits_address[17])} == 6'h0
    | {auto_in_5_a_bits_address[31],
       ~(auto_in_5_a_bits_address[28]),
       auto_in_5_a_bits_address[26:25],
       auto_in_5_a_bits_address[20],
       auto_in_5_a_bits_address[17]} == 6'h0
    | {~(auto_in_5_a_bits_address[31]), auto_in_5_a_bits_address[28]} == 2'h0;	// Parameters.scala:137:{31,49,52,67}, Xbar.scala:237:55, :254:26, :363:92
  wire [3:0]  _GEN_5 = auto_in_6_a_bits_address[28:25] ^ 4'hA;	// Parameters.scala:137:31
  wire        requestAIO_6_0 =
    {auto_in_6_a_bits_address[31],
     auto_in_6_a_bits_address[28],
     auto_in_6_a_bits_address[26:25],
     auto_in_6_a_bits_address[17]} == 5'h0
    | {auto_in_6_a_bits_address[31],
       auto_in_6_a_bits_address[28],
       auto_in_6_a_bits_address[26],
       ~(auto_in_6_a_bits_address[25]),
       auto_in_6_a_bits_address[20],
       auto_in_6_a_bits_address[17]} == 6'h0
    | {auto_in_6_a_bits_address[31],
       auto_in_6_a_bits_address[28],
       ~(auto_in_6_a_bits_address[26])} == 3'h0
    | {auto_in_6_a_bits_address[31],
       _GEN_5[3],
       _GEN_5[1:0],
       auto_in_6_a_bits_address[20],
       auto_in_6_a_bits_address[17]} == 6'h0;	// Bundles.scala:257:54, Parameters.scala:137:{31,49,52,67}, Xbar.scala:237:55, :363:92
  wire        requestAIO_6_1 =
    {auto_in_6_a_bits_address[31],
     auto_in_6_a_bits_address[28],
     auto_in_6_a_bits_address[26:25],
     auto_in_6_a_bits_address[20],
     ~(auto_in_6_a_bits_address[17])} == 6'h0
    | {auto_in_6_a_bits_address[31],
       ~(auto_in_6_a_bits_address[28]),
       auto_in_6_a_bits_address[26:25],
       auto_in_6_a_bits_address[20],
       auto_in_6_a_bits_address[17]} == 6'h0
    | {~(auto_in_6_a_bits_address[31]), auto_in_6_a_bits_address[28]} == 2'h0;	// Parameters.scala:137:{31,49,52,67}, Xbar.scala:237:55, :254:26, :363:92
  wire        requestBOI_1_1 = auto_out_1_b_bits_source[6:2] == 5'h10;	// Parameters.scala:54:{10,32}
  wire        requestBOI_1_2 = auto_out_1_b_bits_source[6:2] == 5'hF;	// Parameters.scala:54:{10,32}
  wire        requestBOI_1_3 = auto_out_1_b_bits_source[6:2] == 5'hE;	// Parameters.scala:54:{10,32}
  wire        requestBOI_1_4 = auto_out_1_b_bits_source[6:5] == 2'h0;	// Parameters.scala:54:{10,32}, Xbar.scala:254:26
  wire        requestBOI_1_5 = auto_out_1_b_bits_source[6:4] == 3'h2;	// Parameters.scala:54:{10,32}
  wire        requestBOI_1_6 = auto_out_1_b_bits_source[6:3] == 4'h6;	// Parameters.scala:54:{10,32}
  wire        requestDOI_0_0 = auto_out_0_d_bits_source == 7'h44;	// Parameters.scala:46:9, Xbar.scala:237:55
  wire        requestDOI_0_1 = auto_out_0_d_bits_source[6:2] == 5'h10;	// Parameters.scala:54:{10,32}
  wire        requestDOI_0_2 = auto_out_0_d_bits_source[6:2] == 5'hF;	// Parameters.scala:54:{10,32}
  wire        requestDOI_0_3 = auto_out_0_d_bits_source[6:2] == 5'hE;	// Parameters.scala:54:{10,32}
  wire        requestDOI_0_4 = auto_out_0_d_bits_source[6:5] == 2'h0;	// Parameters.scala:54:{10,32}, Xbar.scala:254:26
  wire        requestDOI_0_5 = auto_out_0_d_bits_source[6:4] == 3'h2;	// Parameters.scala:54:{10,32}
  wire        requestDOI_0_6 = auto_out_0_d_bits_source[6:3] == 4'h6;	// Parameters.scala:54:{10,32}
  wire        requestDOI_1_0 = auto_out_1_d_bits_source == 7'h44;	// Parameters.scala:46:9, Xbar.scala:237:55
  wire        requestDOI_1_1 = auto_out_1_d_bits_source[6:2] == 5'h10;	// Parameters.scala:54:{10,32}
  wire        requestDOI_1_2 = auto_out_1_d_bits_source[6:2] == 5'hF;	// Parameters.scala:54:{10,32}
  wire        requestDOI_1_3 = auto_out_1_d_bits_source[6:2] == 5'hE;	// Parameters.scala:54:{10,32}
  wire        requestDOI_1_4 = auto_out_1_d_bits_source[6:5] == 2'h0;	// Parameters.scala:54:{10,32}, Xbar.scala:254:26
  wire        requestDOI_1_5 = auto_out_1_d_bits_source[6:4] == 3'h2;	// Parameters.scala:54:{10,32}
  wire        requestDOI_1_6 = auto_out_1_d_bits_source[6:3] == 4'h6;	// Parameters.scala:54:{10,32}
  wire        validQuals_0 = auto_in_0_a_valid & requestAIO_0_0;	// Xbar.scala:363:92, :428:50
  wire        validQuals_0_1 = auto_in_0_a_valid & requestAIO_0_1;	// Xbar.scala:363:92, :428:50
  wire        _portsAOI_in_0_a_ready_WIRE =
    requestAIO_0_0 & auto_out_0_a_ready & allowed_0 | requestAIO_0_1 & auto_out_1_a_ready
    & allowed_1_0;	// Arbiter.scala:121:24, Mux.scala:27:72, Xbar.scala:363:92
  wire        validQuals_1 = auto_in_1_a_valid & requestAIO_1_0;	// Xbar.scala:363:92, :428:50
  wire        validQuals_1_1 = auto_in_1_a_valid & requestAIO_1_1;	// Xbar.scala:363:92, :428:50
  wire        _portsAOI_in_1_a_ready_WIRE =
    requestAIO_1_0 & auto_out_0_a_ready & allowed_1 | requestAIO_1_1 & auto_out_1_a_ready
    & allowed_1_1;	// Arbiter.scala:121:24, Mux.scala:27:72, Xbar.scala:363:92
  wire        validQuals_2 = auto_in_2_a_valid & requestAIO_2_0;	// Xbar.scala:363:92, :428:50
  wire        validQuals_2_1 = auto_in_2_a_valid & requestAIO_2_1;	// Xbar.scala:363:92, :428:50
  wire        _portsAOI_in_2_a_ready_WIRE =
    requestAIO_2_0 & auto_out_0_a_ready & allowed_2 | requestAIO_2_1 & auto_out_1_a_ready
    & allowed_1_2;	// Arbiter.scala:121:24, Mux.scala:27:72, Xbar.scala:363:92
  wire        validQuals_3 = auto_in_3_a_valid & requestAIO_3_0;	// Xbar.scala:363:92, :428:50
  wire        validQuals_3_1 = auto_in_3_a_valid & requestAIO_3_1;	// Xbar.scala:363:92, :428:50
  wire        _portsAOI_in_3_a_ready_WIRE =
    requestAIO_3_0 & auto_out_0_a_ready & allowed_3 | requestAIO_3_1 & auto_out_1_a_ready
    & allowed_1_3;	// Arbiter.scala:121:24, Mux.scala:27:72, Xbar.scala:363:92
  wire        validQuals_4 = auto_in_4_a_valid & requestAIO_4_0;	// Xbar.scala:363:92, :428:50
  wire        validQuals_4_1 = auto_in_4_a_valid & requestAIO_4_1;	// Xbar.scala:363:92, :428:50
  wire        _portsAOI_in_4_a_ready_WIRE =
    requestAIO_4_0 & auto_out_0_a_ready & allowed_4 | requestAIO_4_1 & auto_out_1_a_ready
    & allowed_1_4;	// Arbiter.scala:121:24, Mux.scala:27:72, Xbar.scala:363:92
  wire        validQuals_5 = auto_in_5_a_valid & requestAIO_5_0;	// Xbar.scala:363:92, :428:50
  wire        validQuals_5_1 = auto_in_5_a_valid & requestAIO_5_1;	// Xbar.scala:363:92, :428:50
  wire        _portsAOI_in_5_a_ready_WIRE =
    requestAIO_5_0 & auto_out_0_a_ready & allowed_5 | requestAIO_5_1 & auto_out_1_a_ready
    & allowed_1_5;	// Arbiter.scala:121:24, Mux.scala:27:72, Xbar.scala:363:92
  wire        validQuals_6 = auto_in_6_a_valid & requestAIO_6_0;	// Xbar.scala:363:92, :428:50
  wire        validQuals_6_1 = auto_in_6_a_valid & requestAIO_6_1;	// Xbar.scala:363:92, :428:50
  wire        _portsAOI_in_6_a_ready_WIRE =
    requestAIO_6_0 & auto_out_0_a_ready & allowed_6 | requestAIO_6_1 & auto_out_1_a_ready
    & allowed_1_6;	// Arbiter.scala:121:24, Mux.scala:27:72, Xbar.scala:363:92
  wire        out_29_valid = auto_out_1_b_valid & requestBOI_1_1;	// Parameters.scala:54:32, Xbar.scala:179:40
  wire        out_34_valid = auto_out_1_b_valid & requestBOI_1_2;	// Parameters.scala:54:32, Xbar.scala:179:40
  wire        out_39_valid = auto_out_1_b_valid & requestBOI_1_3;	// Parameters.scala:54:32, Xbar.scala:179:40
  wire        out_44_valid = auto_out_1_b_valid & requestBOI_1_4;	// Parameters.scala:54:32, Xbar.scala:179:40
  wire        out_49_valid = auto_out_1_b_valid & requestBOI_1_5;	// Parameters.scala:54:32, Xbar.scala:179:40
  wire        out_54_valid = auto_out_1_b_valid & requestBOI_1_6;	// Parameters.scala:54:32, Xbar.scala:179:40
  wire        validQuals_0_4 = auto_out_0_d_valid & requestDOI_0_0;	// Parameters.scala:46:9, Xbar.scala:179:40
  wire        validQuals_0_5 = auto_out_0_d_valid & requestDOI_0_1;	// Parameters.scala:54:32, Xbar.scala:179:40
  wire        validQuals_0_6 = auto_out_0_d_valid & requestDOI_0_2;	// Parameters.scala:54:32, Xbar.scala:179:40
  wire        validQuals_0_7 = auto_out_0_d_valid & requestDOI_0_3;	// Parameters.scala:54:32, Xbar.scala:179:40
  wire        validQuals_0_8 = auto_out_0_d_valid & requestDOI_0_4;	// Parameters.scala:54:32, Xbar.scala:179:40
  wire        validQuals_0_9 = auto_out_0_d_valid & requestDOI_0_5;	// Parameters.scala:54:32, Xbar.scala:179:40
  wire        validQuals_0_10 = auto_out_0_d_valid & requestDOI_0_6;	// Parameters.scala:54:32, Xbar.scala:179:40
  wire        validQuals_1_4 = auto_out_1_d_valid & requestDOI_1_0;	// Parameters.scala:46:9, Xbar.scala:179:40
  wire        validQuals_1_5 = auto_out_1_d_valid & requestDOI_1_1;	// Parameters.scala:54:32, Xbar.scala:179:40
  wire        validQuals_1_6 = auto_out_1_d_valid & requestDOI_1_2;	// Parameters.scala:54:32, Xbar.scala:179:40
  wire        validQuals_1_7 = auto_out_1_d_valid & requestDOI_1_3;	// Parameters.scala:54:32, Xbar.scala:179:40
  wire        validQuals_1_8 = auto_out_1_d_valid & requestDOI_1_4;	// Parameters.scala:54:32, Xbar.scala:179:40
  wire        validQuals_1_9 = auto_out_1_d_valid & requestDOI_1_5;	// Parameters.scala:54:32, Xbar.scala:179:40
  wire        validQuals_1_10 = auto_out_1_d_valid & requestDOI_1_6;	// Parameters.scala:54:32, Xbar.scala:179:40
  reg  [8:0]  beatsLeft;	// Arbiter.scala:87:30
  wire        idle = beatsLeft == 9'h0;	// Arbiter.scala:87:30, :88:28, Edges.scala:220:14
  wire [6:0]  readys_filter_lo =
    {validQuals_6,
     validQuals_5,
     validQuals_4,
     validQuals_3,
     validQuals_2,
     validQuals_1,
     validQuals_0};	// Cat.scala:30:58, Xbar.scala:428:50
  reg  [6:0]  readys_mask;	// Arbiter.scala:23:23
  wire [6:0]  readys_filter_hi = readys_filter_lo & ~readys_mask;	// Arbiter.scala:23:23, :24:{28,30}, Cat.scala:30:58
  wire [11:0] _GEN_6 =
    {readys_filter_hi[5:0],
     validQuals_6,
     validQuals_5,
     validQuals_4,
     validQuals_3,
     validQuals_2,
     validQuals_1}
    | {readys_filter_hi,
       validQuals_6,
       validQuals_5,
       validQuals_4,
       validQuals_3,
       validQuals_2};	// Arbiter.scala:24:28, Xbar.scala:428:50, package.scala:253:{43,48}
  wire [10:0] _GEN_7 = _GEN_6[10:0] | {readys_filter_hi[6], _GEN_6[11:2]};	// Arbiter.scala:24:28, package.scala:253:{43,48}
  wire [8:0]  _GEN_8 = _GEN_7[8:0] | {readys_filter_hi[6], _GEN_6[11], _GEN_7[10:4]};	// Arbiter.scala:24:28, package.scala:253:{43,48}
  wire [6:0]  readys_readys =
    ~({readys_mask[6],
       readys_filter_hi[6] | readys_mask[5],
       _GEN_6[11] | readys_mask[4],
       _GEN_7[10:9] | readys_mask[3:2],
       _GEN_8[8:7] | readys_mask[1:0]} & _GEN_8[6:0]);	// Arbiter.scala:23:23, :24:28, :25:58, :26:{18,29,39}, package.scala:253:43
  wire        prefixOR_1 = readys_readys[0] & validQuals_0;	// Arbiter.scala:26:18, :95:86, :97:79, Xbar.scala:428:50
  wire        earlyWinner_1 = readys_readys[1] & validQuals_1;	// Arbiter.scala:26:18, :95:86, :97:79, Xbar.scala:428:50
  wire        earlyWinner_2 = readys_readys[2] & validQuals_2;	// Arbiter.scala:26:18, :95:86, :97:79, Xbar.scala:428:50
  wire        earlyWinner_3 = readys_readys[3] & validQuals_3;	// Arbiter.scala:26:18, :95:86, :97:79, Xbar.scala:428:50
  wire        earlyWinner_4 = readys_readys[4] & validQuals_4;	// Arbiter.scala:26:18, :95:86, :97:79, Xbar.scala:428:50
  wire        earlyWinner_5 = readys_readys[5] & validQuals_5;	// Arbiter.scala:26:18, :95:86, :97:79, Xbar.scala:428:50
  wire        earlyWinner_6 = readys_readys[6] & validQuals_6;	// Arbiter.scala:26:18, :95:86, :97:79, Xbar.scala:428:50
  wire        _out_0_a_earlyValid_T = validQuals_0 | validQuals_1;	// Arbiter.scala:107:36, Xbar.scala:428:50
  reg         state_0;	// Arbiter.scala:116:26
  reg         state_1;	// Arbiter.scala:116:26
  reg         state_2;	// Arbiter.scala:116:26
  reg         state_3;	// Arbiter.scala:116:26
  reg         state_4;	// Arbiter.scala:116:26
  reg         state_5;	// Arbiter.scala:116:26
  reg         state_6;	// Arbiter.scala:116:26
  wire        muxStateEarly_0 = idle ? prefixOR_1 : state_0;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        muxStateEarly_1 = idle ? earlyWinner_1 : state_1;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        muxStateEarly_2 = idle ? earlyWinner_2 : state_2;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        muxStateEarly_3 = idle ? earlyWinner_3 : state_3;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        muxStateEarly_4 = idle ? earlyWinner_4 : state_4;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        muxStateEarly_5 = idle ? earlyWinner_5 : state_5;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        muxStateEarly_6 = idle ? earlyWinner_6 : state_6;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  assign allowed_0 = idle ? readys_readys[0] : state_0;	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24
  assign allowed_1 = idle ? readys_readys[1] : state_1;	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24
  assign allowed_2 = idle ? readys_readys[2] : state_2;	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24
  assign allowed_3 = idle ? readys_readys[3] : state_3;	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24
  assign allowed_4 = idle ? readys_readys[4] : state_4;	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24
  assign allowed_5 = idle ? readys_readys[5] : state_5;	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24
  assign allowed_6 = idle ? readys_readys[6] : state_6;	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24
  wire        bundleOut_0_out_1_valid =
    idle
      ? _out_0_a_earlyValid_T | validQuals_2 | validQuals_3 | validQuals_4 | validQuals_5
        | validQuals_6
      : state_0 & validQuals_0 | state_1 & validQuals_1 | state_2 & validQuals_2 | state_3
        & validQuals_3 | state_4 & validQuals_4 | state_5 & validQuals_5 | state_6
        & validQuals_6;	// Arbiter.scala:88:28, :107:36, :116:26, :125:{29,56}, Mux.scala:27:72, Xbar.scala:428:50
  reg  [8:0]  beatsLeft_1;	// Arbiter.scala:87:30
  wire        idle_1 = beatsLeft_1 == 9'h0;	// Arbiter.scala:87:30, :88:28, Edges.scala:220:14
  wire [6:0]  readys_filter_lo_1 =
    {validQuals_6_1,
     validQuals_5_1,
     validQuals_4_1,
     validQuals_3_1,
     validQuals_2_1,
     validQuals_1_1,
     validQuals_0_1};	// Cat.scala:30:58, Xbar.scala:428:50
  reg  [6:0]  readys_mask_1;	// Arbiter.scala:23:23
  wire [6:0]  readys_filter_hi_1 = readys_filter_lo_1 & ~readys_mask_1;	// Arbiter.scala:23:23, :24:{28,30}, Cat.scala:30:58
  wire [11:0] _GEN_9 =
    {readys_filter_hi_1[5:0],
     validQuals_6_1,
     validQuals_5_1,
     validQuals_4_1,
     validQuals_3_1,
     validQuals_2_1,
     validQuals_1_1}
    | {readys_filter_hi_1,
       validQuals_6_1,
       validQuals_5_1,
       validQuals_4_1,
       validQuals_3_1,
       validQuals_2_1};	// Arbiter.scala:24:28, Xbar.scala:428:50, package.scala:253:{43,48}
  wire [10:0] _GEN_10 = _GEN_9[10:0] | {readys_filter_hi_1[6], _GEN_9[11:2]};	// Arbiter.scala:24:28, package.scala:253:{43,48}
  wire [8:0]  _GEN_11 = _GEN_10[8:0] | {readys_filter_hi_1[6], _GEN_9[11], _GEN_10[10:4]};	// Arbiter.scala:24:28, package.scala:253:{43,48}
  wire [6:0]  readys_readys_1 =
    ~({readys_mask_1[6],
       readys_filter_hi_1[6] | readys_mask_1[5],
       _GEN_9[11] | readys_mask_1[4],
       _GEN_10[10:9] | readys_mask_1[3:2],
       _GEN_11[8:7] | readys_mask_1[1:0]} & _GEN_11[6:0]);	// Arbiter.scala:23:23, :24:28, :25:58, :26:{18,29,39}, package.scala:253:43
  wire        prefixOR_1_1 = readys_readys_1[0] & validQuals_0_1;	// Arbiter.scala:26:18, :95:86, :97:79, Xbar.scala:428:50
  wire        earlyWinner_1_1 = readys_readys_1[1] & validQuals_1_1;	// Arbiter.scala:26:18, :95:86, :97:79, Xbar.scala:428:50
  wire        earlyWinner_1_2 = readys_readys_1[2] & validQuals_2_1;	// Arbiter.scala:26:18, :95:86, :97:79, Xbar.scala:428:50
  wire        earlyWinner_1_3 = readys_readys_1[3] & validQuals_3_1;	// Arbiter.scala:26:18, :95:86, :97:79, Xbar.scala:428:50
  wire        earlyWinner_1_4 = readys_readys_1[4] & validQuals_4_1;	// Arbiter.scala:26:18, :95:86, :97:79, Xbar.scala:428:50
  wire        earlyWinner_1_5 = readys_readys_1[5] & validQuals_5_1;	// Arbiter.scala:26:18, :95:86, :97:79, Xbar.scala:428:50
  wire        earlyWinner_1_6 = readys_readys_1[6] & validQuals_6_1;	// Arbiter.scala:26:18, :95:86, :97:79, Xbar.scala:428:50
  wire        _out_1_a_earlyValid_T = validQuals_0_1 | validQuals_1_1;	// Arbiter.scala:107:36, Xbar.scala:428:50
  reg         state_1_0;	// Arbiter.scala:116:26
  reg         state_1_1;	// Arbiter.scala:116:26
  reg         state_1_2;	// Arbiter.scala:116:26
  reg         state_1_3;	// Arbiter.scala:116:26
  reg         state_1_4;	// Arbiter.scala:116:26
  reg         state_1_5;	// Arbiter.scala:116:26
  reg         state_1_6;	// Arbiter.scala:116:26
  wire        muxStateEarly_1_0 = idle_1 ? prefixOR_1_1 : state_1_0;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        muxStateEarly_1_1 = idle_1 ? earlyWinner_1_1 : state_1_1;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        muxStateEarly_1_2 = idle_1 ? earlyWinner_1_2 : state_1_2;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        muxStateEarly_1_3 = idle_1 ? earlyWinner_1_3 : state_1_3;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        muxStateEarly_1_4 = idle_1 ? earlyWinner_1_4 : state_1_4;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        muxStateEarly_1_5 = idle_1 ? earlyWinner_1_5 : state_1_5;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        muxStateEarly_1_6 = idle_1 ? earlyWinner_1_6 : state_1_6;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  assign allowed_1_0 = idle_1 ? readys_readys_1[0] : state_1_0;	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24
  assign allowed_1_1 = idle_1 ? readys_readys_1[1] : state_1_1;	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24
  assign allowed_1_2 = idle_1 ? readys_readys_1[2] : state_1_2;	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24
  assign allowed_1_3 = idle_1 ? readys_readys_1[3] : state_1_3;	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24
  assign allowed_1_4 = idle_1 ? readys_readys_1[4] : state_1_4;	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24
  assign allowed_1_5 = idle_1 ? readys_readys_1[5] : state_1_5;	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24
  assign allowed_1_6 = idle_1 ? readys_readys_1[6] : state_1_6;	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24
  wire        bundleOut_1_out_1_valid =
    idle_1
      ? _out_1_a_earlyValid_T | validQuals_2_1 | validQuals_3_1 | validQuals_4_1
        | validQuals_5_1 | validQuals_6_1
      : state_1_0 & validQuals_0_1 | state_1_1 & validQuals_1_1 | state_1_2
        & validQuals_2_1 | state_1_3 & validQuals_3_1 | state_1_4 & validQuals_4_1
        | state_1_5 & validQuals_5_1 | state_1_6 & validQuals_6_1;	// Arbiter.scala:88:28, :107:36, :116:26, :125:{29,56}, Mux.scala:27:72, Xbar.scala:428:50
  reg  [8:0]  beatsLeft_2;	// Arbiter.scala:87:30
  wire        idle_2 = beatsLeft_2 == 9'h0;	// Arbiter.scala:87:30, :88:28, Edges.scala:220:14
  wire [5:0]  readys_filter_lo_2 =
    {auto_in_6_c_valid,
     auto_in_5_c_valid,
     auto_in_4_c_valid,
     auto_in_3_c_valid,
     auto_in_2_c_valid,
     auto_in_1_c_valid};	// Cat.scala:30:58
  reg  [5:0]  readys_mask_2;	// Arbiter.scala:23:23
  wire [5:0]  readys_filter_hi_2 = readys_filter_lo_2 & ~readys_mask_2;	// Arbiter.scala:23:23, :24:{28,30}, Cat.scala:30:58
  wire [9:0]  _GEN_12 =
    {readys_filter_hi_2[4:0],
     auto_in_6_c_valid,
     auto_in_5_c_valid,
     auto_in_4_c_valid,
     auto_in_3_c_valid,
     auto_in_2_c_valid}
    | {readys_filter_hi_2,
       auto_in_6_c_valid,
       auto_in_5_c_valid,
       auto_in_4_c_valid,
       auto_in_3_c_valid};	// Arbiter.scala:24:28, package.scala:253:{43,48}
  wire [8:0]  _GEN_13 = _GEN_12[8:0] | {readys_filter_hi_2[5], _GEN_12[9:2]};	// Arbiter.scala:24:28, package.scala:253:{43,48}
  wire [6:0]  _GEN_14 = _GEN_13[6:0] | {readys_filter_hi_2[5], _GEN_12[9], _GEN_13[8:4]};	// Arbiter.scala:24:28, package.scala:253:{43,48}
  wire [5:0]  readys_readys_2 =
    ~({readys_mask_2[5],
       readys_filter_hi_2[5] | readys_mask_2[4],
       _GEN_12[9] | readys_mask_2[3],
       _GEN_13[8:7] | readys_mask_2[2:1],
       _GEN_14[6] | readys_mask_2[0]} & _GEN_14[5:0]);	// Arbiter.scala:23:23, :24:28, :25:58, :26:{18,29,39}, package.scala:253:43
  wire        prefixOR_1_2 = readys_readys_2[0] & auto_in_1_c_valid;	// Arbiter.scala:26:18, :95:86, :97:79
  wire        earlyWinner_2_1 = readys_readys_2[1] & auto_in_2_c_valid;	// Arbiter.scala:26:18, :95:86, :97:79
  wire        earlyWinner_2_2 = readys_readys_2[2] & auto_in_3_c_valid;	// Arbiter.scala:26:18, :95:86, :97:79
  wire        earlyWinner_2_3 = readys_readys_2[3] & auto_in_4_c_valid;	// Arbiter.scala:26:18, :95:86, :97:79
  wire        earlyWinner_2_4 = readys_readys_2[4] & auto_in_5_c_valid;	// Arbiter.scala:26:18, :95:86, :97:79
  wire        earlyWinner_2_5 = readys_readys_2[5] & auto_in_6_c_valid;	// Arbiter.scala:26:18, :95:86, :97:79
  wire        _sink_ACancel_earlyValid_T = auto_in_1_c_valid | auto_in_2_c_valid;	// Arbiter.scala:107:36
  reg         state_2_0;	// Arbiter.scala:116:26
  reg         state_2_1;	// Arbiter.scala:116:26
  reg         state_2_2;	// Arbiter.scala:116:26
  reg         state_2_3;	// Arbiter.scala:116:26
  reg         state_2_4;	// Arbiter.scala:116:26
  reg         state_2_5;	// Arbiter.scala:116:26
  wire        muxStateEarly_2_0 = idle_2 ? prefixOR_1_2 : state_2_0;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        muxStateEarly_2_1 = idle_2 ? earlyWinner_2_1 : state_2_1;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        muxStateEarly_2_2 = idle_2 ? earlyWinner_2_2 : state_2_2;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        muxStateEarly_2_3 = idle_2 ? earlyWinner_2_3 : state_2_3;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        muxStateEarly_2_4 = idle_2 ? earlyWinner_2_4 : state_2_4;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        muxStateEarly_2_5 = idle_2 ? earlyWinner_2_5 : state_2_5;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        out_10_ready =
    auto_out_1_c_ready & (idle_2 ? readys_readys_2[0] : state_2_0);	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24, :123:31
  wire        out_11_ready =
    auto_out_1_c_ready & (idle_2 ? readys_readys_2[1] : state_2_1);	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24, :123:31
  wire        out_12_ready =
    auto_out_1_c_ready & (idle_2 ? readys_readys_2[2] : state_2_2);	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24, :123:31
  wire        out_13_ready =
    auto_out_1_c_ready & (idle_2 ? readys_readys_2[3] : state_2_3);	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24, :123:31
  wire        out_14_ready =
    auto_out_1_c_ready & (idle_2 ? readys_readys_2[4] : state_2_4);	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24, :123:31
  wire        out_15_ready =
    auto_out_1_c_ready & (idle_2 ? readys_readys_2[5] : state_2_5);	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24, :123:31
  wire        bundleOut_1_out_c_valid =
    idle_2
      ? _sink_ACancel_earlyValid_T | auto_in_3_c_valid | auto_in_4_c_valid
        | auto_in_5_c_valid | auto_in_6_c_valid
      : state_2_0 & auto_in_1_c_valid | state_2_1 & auto_in_2_c_valid | state_2_2
        & auto_in_3_c_valid | state_2_3 & auto_in_4_c_valid | state_2_4
        & auto_in_5_c_valid | state_2_5 & auto_in_6_c_valid;	// Arbiter.scala:88:28, :107:36, :116:26, :125:{29,56}, Mux.scala:27:72
  reg         beatsLeft_3;	// Arbiter.scala:87:30
  wire [5:0]  readys_filter_lo_3 =
    {auto_in_6_e_valid,
     auto_in_5_e_valid,
     auto_in_4_e_valid,
     auto_in_3_e_valid,
     auto_in_2_e_valid,
     auto_in_1_e_valid};	// Cat.scala:30:58
  reg  [5:0]  readys_mask_3;	// Arbiter.scala:23:23
  wire [5:0]  readys_filter_hi_3 = readys_filter_lo_3 & ~readys_mask_3;	// Arbiter.scala:23:23, :24:{28,30}, Cat.scala:30:58
  wire [9:0]  _GEN_15 =
    {readys_filter_hi_3[4:0],
     auto_in_6_e_valid,
     auto_in_5_e_valid,
     auto_in_4_e_valid,
     auto_in_3_e_valid,
     auto_in_2_e_valid}
    | {readys_filter_hi_3,
       auto_in_6_e_valid,
       auto_in_5_e_valid,
       auto_in_4_e_valid,
       auto_in_3_e_valid};	// Arbiter.scala:24:28, package.scala:253:{43,48}
  wire [8:0]  _GEN_16 = _GEN_15[8:0] | {readys_filter_hi_3[5], _GEN_15[9:2]};	// Arbiter.scala:24:28, package.scala:253:{43,48}
  wire [6:0]  _GEN_17 = _GEN_16[6:0] | {readys_filter_hi_3[5], _GEN_15[9], _GEN_16[8:4]};	// Arbiter.scala:24:28, package.scala:253:{43,48}
  wire [5:0]  readys_readys_3 =
    ~({readys_mask_3[5],
       readys_filter_hi_3[5] | readys_mask_3[4],
       _GEN_15[9] | readys_mask_3[3],
       _GEN_16[8:7] | readys_mask_3[2:1],
       _GEN_17[6] | readys_mask_3[0]} & _GEN_17[5:0]);	// Arbiter.scala:23:23, :24:28, :25:58, :26:{18,29,39}, package.scala:253:43
  wire        prefixOR_1_3 = readys_readys_3[0] & auto_in_1_e_valid;	// Arbiter.scala:26:18, :95:86, :97:79
  wire        earlyWinner_3_1 = readys_readys_3[1] & auto_in_2_e_valid;	// Arbiter.scala:26:18, :95:86, :97:79
  wire        earlyWinner_3_2 = readys_readys_3[2] & auto_in_3_e_valid;	// Arbiter.scala:26:18, :95:86, :97:79
  wire        earlyWinner_3_3 = readys_readys_3[3] & auto_in_4_e_valid;	// Arbiter.scala:26:18, :95:86, :97:79
  wire        earlyWinner_3_4 = readys_readys_3[4] & auto_in_5_e_valid;	// Arbiter.scala:26:18, :95:86, :97:79
  wire        earlyWinner_3_5 = readys_readys_3[5] & auto_in_6_e_valid;	// Arbiter.scala:26:18, :95:86, :97:79
  wire        _sink_ACancel_earlyValid_T_17 = auto_in_1_e_valid | auto_in_2_e_valid;	// Arbiter.scala:107:36
  reg         state_3_0;	// Arbiter.scala:116:26
  reg         state_3_1;	// Arbiter.scala:116:26
  reg         state_3_2;	// Arbiter.scala:116:26
  reg         state_3_3;	// Arbiter.scala:116:26
  reg         state_3_4;	// Arbiter.scala:116:26
  reg         state_3_5;	// Arbiter.scala:116:26
  wire        out_17_ready = beatsLeft_3 ? state_3_0 : readys_readys_3[0];	// Arbiter.scala:26:18, :87:30, :95:86, :116:26, :121:24
  wire        out_18_ready = beatsLeft_3 ? state_3_1 : readys_readys_3[1];	// Arbiter.scala:26:18, :87:30, :95:86, :116:26, :121:24
  wire        out_19_ready = beatsLeft_3 ? state_3_2 : readys_readys_3[2];	// Arbiter.scala:26:18, :87:30, :95:86, :116:26, :121:24
  wire        out_20_ready = beatsLeft_3 ? state_3_3 : readys_readys_3[3];	// Arbiter.scala:26:18, :87:30, :95:86, :116:26, :121:24
  wire        out_21_ready = beatsLeft_3 ? state_3_4 : readys_readys_3[4];	// Arbiter.scala:26:18, :87:30, :95:86, :116:26, :121:24
  wire        out_22_ready = beatsLeft_3 ? state_3_5 : readys_readys_3[5];	// Arbiter.scala:26:18, :87:30, :95:86, :116:26, :121:24
  wire        bundleOut_1_out_e_valid =
    beatsLeft_3
      ? state_3_0 & auto_in_1_e_valid | state_3_1 & auto_in_2_e_valid | state_3_2
        & auto_in_3_e_valid | state_3_3 & auto_in_4_e_valid | state_3_4
        & auto_in_5_e_valid | state_3_5 & auto_in_6_e_valid
      : _sink_ACancel_earlyValid_T_17 | auto_in_3_e_valid | auto_in_4_e_valid
        | auto_in_5_e_valid | auto_in_6_e_valid;	// Arbiter.scala:87:30, :107:36, :116:26, :125:{29,56}, Mux.scala:27:72
  reg  [8:0]  beatsLeft_4;	// Arbiter.scala:87:30
  wire        idle_4 = beatsLeft_4 == 9'h0;	// Arbiter.scala:87:30, :88:28, Edges.scala:220:14
  wire [1:0]  readys_filter_lo_4 = {validQuals_1_4, validQuals_0_4};	// Cat.scala:30:58, Xbar.scala:179:40
  reg  [1:0]  readys_mask_4;	// Arbiter.scala:23:23
  wire [1:0]  readys_filter_hi_4 = readys_filter_lo_4 & ~readys_mask_4;	// Arbiter.scala:23:23, :24:{28,30}, Cat.scala:30:58
  wire [1:0]  readys_readys_4 =
    ~({readys_mask_4[1], readys_filter_hi_4[1] | readys_mask_4[0]}
      & ({readys_filter_hi_4[0], validQuals_1_4} | readys_filter_hi_4));	// Arbiter.scala:23:23, :24:28, :25:58, :26:{18,29,39}, Xbar.scala:179:40, package.scala:253:43
  wire        prefixOR_1_4 = readys_readys_4[0] & validQuals_0_4;	// Arbiter.scala:26:18, :95:86, :97:79, Xbar.scala:179:40
  wire        earlyWinner_4_1 = readys_readys_4[1] & validQuals_1_4;	// Arbiter.scala:26:18, :95:86, :97:79, Xbar.scala:179:40
  wire        _sink_ACancel_earlyValid_T_34 = validQuals_0_4 | validQuals_1_4;	// Arbiter.scala:107:36, Xbar.scala:179:40
  reg         state_4_0;	// Arbiter.scala:116:26
  reg         state_4_1;	// Arbiter.scala:116:26
  wire        muxStateEarly_4_0 = idle_4 ? prefixOR_1_4 : state_4_0;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        muxStateEarly_4_1 = idle_4 ? earlyWinner_4_1 : state_4_1;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  assign allowed_4_0 = idle_4 ? readys_readys_4[0] : state_4_0;	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24
  assign allowed_4_1 = idle_4 ? readys_readys_4[1] : state_4_1;	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24
  wire        out_27_valid =
    idle_4
      ? _sink_ACancel_earlyValid_T_34
      : state_4_0 & validQuals_0_4 | state_4_1 & validQuals_1_4;	// Arbiter.scala:88:28, :107:36, :116:26, :125:29, Mux.scala:27:72, Xbar.scala:179:40
  wire        out_27_bits_corrupt =
    muxStateEarly_4_0 & auto_out_0_d_bits_corrupt | muxStateEarly_4_1
    & auto_out_1_d_bits_corrupt;	// Arbiter.scala:117:30, Mux.scala:27:72
  wire        out_27_bits_denied =
    muxStateEarly_4_0 & auto_out_0_d_bits_denied | muxStateEarly_4_1
    & auto_out_1_d_bits_denied;	// Arbiter.scala:117:30, Mux.scala:27:72
  wire [2:0]  out_27_bits_sink =
    (muxStateEarly_4_0 ? out_55_bits_sink : 3'h0)
    | (muxStateEarly_4_1 ? auto_out_1_d_bits_sink : 3'h0);	// Arbiter.scala:117:30, Mux.scala:27:72, Xbar.scala:323:28
  wire [3:0]  out_27_bits_size =
    (muxStateEarly_4_0 ? auto_out_0_d_bits_size : 4'h0)
    | (muxStateEarly_4_1 ? out_56_bits_size : 4'h0);	// Arbiter.scala:117:30, BundleMap.scala:247:19, Bundles.scala:257:54, Mux.scala:27:72
  wire [1:0]  out_27_bits_param =
    (muxStateEarly_4_0 ? auto_out_0_d_bits_param : 2'h0)
    | (muxStateEarly_4_1 ? auto_out_1_d_bits_param : 2'h0);	// Arbiter.scala:117:30, Mux.scala:27:72, Xbar.scala:254:26
  wire [2:0]  out_27_bits_opcode =
    (muxStateEarly_4_0 ? auto_out_0_d_bits_opcode : 3'h0)
    | (muxStateEarly_4_1 ? auto_out_1_d_bits_opcode : 3'h0);	// Arbiter.scala:117:30, Mux.scala:27:72
  reg  [8:0]  beatsLeft_5;	// Arbiter.scala:87:30
  wire        idle_5 = beatsLeft_5 == 9'h0;	// Arbiter.scala:87:30, :88:28, Edges.scala:220:14
  wire [1:0]  readys_filter_lo_5 = {validQuals_1_5, validQuals_0_5};	// Cat.scala:30:58, Xbar.scala:179:40
  reg  [1:0]  readys_mask_5;	// Arbiter.scala:23:23
  wire [1:0]  readys_filter_hi_5 = readys_filter_lo_5 & ~readys_mask_5;	// Arbiter.scala:23:23, :24:{28,30}, Cat.scala:30:58
  wire [1:0]  readys_readys_5 =
    ~({readys_mask_5[1], readys_filter_hi_5[1] | readys_mask_5[0]}
      & ({readys_filter_hi_5[0], validQuals_1_5} | readys_filter_hi_5));	// Arbiter.scala:23:23, :24:28, :25:58, :26:{18,29,39}, Xbar.scala:179:40, package.scala:253:43
  wire        prefixOR_1_5 = readys_readys_5[0] & validQuals_0_5;	// Arbiter.scala:26:18, :95:86, :97:79, Xbar.scala:179:40
  wire        earlyWinner_5_1 = readys_readys_5[1] & validQuals_1_5;	// Arbiter.scala:26:18, :95:86, :97:79, Xbar.scala:179:40
  wire        _sink_ACancel_earlyValid_T_39 = validQuals_0_5 | validQuals_1_5;	// Arbiter.scala:107:36, Xbar.scala:179:40
  reg         state_5_0;	// Arbiter.scala:116:26
  reg         state_5_1;	// Arbiter.scala:116:26
  wire        muxStateEarly_5_0 = idle_5 ? prefixOR_1_5 : state_5_0;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        muxStateEarly_5_1 = idle_5 ? earlyWinner_5_1 : state_5_1;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  assign allowed_5_0 = idle_5 ? readys_readys_5[0] : state_5_0;	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24
  assign allowed_5_1 = idle_5 ? readys_readys_5[1] : state_5_1;	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24
  wire        out_32_valid =
    idle_5
      ? _sink_ACancel_earlyValid_T_39
      : state_5_0 & validQuals_0_5 | state_5_1 & validQuals_1_5;	// Arbiter.scala:88:28, :107:36, :116:26, :125:29, Mux.scala:27:72, Xbar.scala:179:40
  wire        out_32_bits_corrupt =
    muxStateEarly_5_0 & auto_out_0_d_bits_corrupt | muxStateEarly_5_1
    & auto_out_1_d_bits_corrupt;	// Arbiter.scala:117:30, Mux.scala:27:72
  wire        out_32_bits_denied =
    muxStateEarly_5_0 & auto_out_0_d_bits_denied | muxStateEarly_5_1
    & auto_out_1_d_bits_denied;	// Arbiter.scala:117:30, Mux.scala:27:72
  wire [2:0]  out_32_bits_sink =
    (muxStateEarly_5_0 ? out_55_bits_sink : 3'h0)
    | (muxStateEarly_5_1 ? auto_out_1_d_bits_sink : 3'h0);	// Arbiter.scala:117:30, Mux.scala:27:72, Xbar.scala:323:28
  wire [1:0]  out_32_bits_source =
    (muxStateEarly_5_0 ? auto_out_0_d_bits_source[1:0] : 2'h0)
    | (muxStateEarly_5_1 ? auto_out_1_d_bits_source[1:0] : 2'h0);	// Arbiter.scala:117:30, Mux.scala:27:72, Xbar.scala:254:26
  wire [3:0]  out_32_bits_size =
    (muxStateEarly_5_0 ? auto_out_0_d_bits_size : 4'h0)
    | (muxStateEarly_5_1 ? out_56_bits_size : 4'h0);	// Arbiter.scala:117:30, BundleMap.scala:247:19, Bundles.scala:257:54, Mux.scala:27:72
  wire [1:0]  out_32_bits_param =
    (muxStateEarly_5_0 ? auto_out_0_d_bits_param : 2'h0)
    | (muxStateEarly_5_1 ? auto_out_1_d_bits_param : 2'h0);	// Arbiter.scala:117:30, Mux.scala:27:72, Xbar.scala:254:26
  wire [2:0]  out_32_bits_opcode =
    (muxStateEarly_5_0 ? auto_out_0_d_bits_opcode : 3'h0)
    | (muxStateEarly_5_1 ? auto_out_1_d_bits_opcode : 3'h0);	// Arbiter.scala:117:30, Mux.scala:27:72
  reg  [8:0]  beatsLeft_6;	// Arbiter.scala:87:30
  wire        idle_6 = beatsLeft_6 == 9'h0;	// Arbiter.scala:87:30, :88:28, Edges.scala:220:14
  wire [1:0]  readys_filter_lo_6 = {validQuals_1_6, validQuals_0_6};	// Cat.scala:30:58, Xbar.scala:179:40
  reg  [1:0]  readys_mask_6;	// Arbiter.scala:23:23
  wire [1:0]  readys_filter_hi_6 = readys_filter_lo_6 & ~readys_mask_6;	// Arbiter.scala:23:23, :24:{28,30}, Cat.scala:30:58
  wire [1:0]  readys_readys_6 =
    ~({readys_mask_6[1], readys_filter_hi_6[1] | readys_mask_6[0]}
      & ({readys_filter_hi_6[0], validQuals_1_6} | readys_filter_hi_6));	// Arbiter.scala:23:23, :24:28, :25:58, :26:{18,29,39}, Xbar.scala:179:40, package.scala:253:43
  wire        prefixOR_1_6 = readys_readys_6[0] & validQuals_0_6;	// Arbiter.scala:26:18, :95:86, :97:79, Xbar.scala:179:40
  wire        earlyWinner_6_1 = readys_readys_6[1] & validQuals_1_6;	// Arbiter.scala:26:18, :95:86, :97:79, Xbar.scala:179:40
  wire        _sink_ACancel_earlyValid_T_44 = validQuals_0_6 | validQuals_1_6;	// Arbiter.scala:107:36, Xbar.scala:179:40
  reg         state_6_0;	// Arbiter.scala:116:26
  reg         state_6_1;	// Arbiter.scala:116:26
  wire        muxStateEarly_6_0 = idle_6 ? prefixOR_1_6 : state_6_0;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        muxStateEarly_6_1 = idle_6 ? earlyWinner_6_1 : state_6_1;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  assign allowed_6_0 = idle_6 ? readys_readys_6[0] : state_6_0;	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24
  assign allowed_6_1 = idle_6 ? readys_readys_6[1] : state_6_1;	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24
  wire        out_37_valid =
    idle_6
      ? _sink_ACancel_earlyValid_T_44
      : state_6_0 & validQuals_0_6 | state_6_1 & validQuals_1_6;	// Arbiter.scala:88:28, :107:36, :116:26, :125:29, Mux.scala:27:72, Xbar.scala:179:40
  wire        out_37_bits_corrupt =
    muxStateEarly_6_0 & auto_out_0_d_bits_corrupt | muxStateEarly_6_1
    & auto_out_1_d_bits_corrupt;	// Arbiter.scala:117:30, Mux.scala:27:72
  wire        out_37_bits_denied =
    muxStateEarly_6_0 & auto_out_0_d_bits_denied | muxStateEarly_6_1
    & auto_out_1_d_bits_denied;	// Arbiter.scala:117:30, Mux.scala:27:72
  wire [2:0]  out_37_bits_sink =
    (muxStateEarly_6_0 ? out_55_bits_sink : 3'h0)
    | (muxStateEarly_6_1 ? auto_out_1_d_bits_sink : 3'h0);	// Arbiter.scala:117:30, Mux.scala:27:72, Xbar.scala:323:28
  wire [1:0]  out_37_bits_source =
    (muxStateEarly_6_0 ? auto_out_0_d_bits_source[1:0] : 2'h0)
    | (muxStateEarly_6_1 ? auto_out_1_d_bits_source[1:0] : 2'h0);	// Arbiter.scala:117:30, Mux.scala:27:72, Xbar.scala:254:26
  wire [3:0]  out_37_bits_size =
    (muxStateEarly_6_0 ? auto_out_0_d_bits_size : 4'h0)
    | (muxStateEarly_6_1 ? out_56_bits_size : 4'h0);	// Arbiter.scala:117:30, BundleMap.scala:247:19, Bundles.scala:257:54, Mux.scala:27:72
  wire [1:0]  out_37_bits_param =
    (muxStateEarly_6_0 ? auto_out_0_d_bits_param : 2'h0)
    | (muxStateEarly_6_1 ? auto_out_1_d_bits_param : 2'h0);	// Arbiter.scala:117:30, Mux.scala:27:72, Xbar.scala:254:26
  wire [2:0]  out_37_bits_opcode =
    (muxStateEarly_6_0 ? auto_out_0_d_bits_opcode : 3'h0)
    | (muxStateEarly_6_1 ? auto_out_1_d_bits_opcode : 3'h0);	// Arbiter.scala:117:30, Mux.scala:27:72
  reg  [8:0]  beatsLeft_7;	// Arbiter.scala:87:30
  wire        idle_7 = beatsLeft_7 == 9'h0;	// Arbiter.scala:87:30, :88:28, Edges.scala:220:14
  wire [1:0]  readys_filter_lo_7 = {validQuals_1_7, validQuals_0_7};	// Cat.scala:30:58, Xbar.scala:179:40
  reg  [1:0]  readys_mask_7;	// Arbiter.scala:23:23
  wire [1:0]  readys_filter_hi_7 = readys_filter_lo_7 & ~readys_mask_7;	// Arbiter.scala:23:23, :24:{28,30}, Cat.scala:30:58
  wire [1:0]  readys_readys_7 =
    ~({readys_mask_7[1], readys_filter_hi_7[1] | readys_mask_7[0]}
      & ({readys_filter_hi_7[0], validQuals_1_7} | readys_filter_hi_7));	// Arbiter.scala:23:23, :24:28, :25:58, :26:{18,29,39}, Xbar.scala:179:40, package.scala:253:43
  wire        prefixOR_1_7 = readys_readys_7[0] & validQuals_0_7;	// Arbiter.scala:26:18, :95:86, :97:79, Xbar.scala:179:40
  wire        earlyWinner_7_1 = readys_readys_7[1] & validQuals_1_7;	// Arbiter.scala:26:18, :95:86, :97:79, Xbar.scala:179:40
  wire        _sink_ACancel_earlyValid_T_49 = validQuals_0_7 | validQuals_1_7;	// Arbiter.scala:107:36, Xbar.scala:179:40
  reg         state_7_0;	// Arbiter.scala:116:26
  reg         state_7_1;	// Arbiter.scala:116:26
  wire        muxStateEarly_7_0 = idle_7 ? prefixOR_1_7 : state_7_0;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        muxStateEarly_7_1 = idle_7 ? earlyWinner_7_1 : state_7_1;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  assign allowed_7_0 = idle_7 ? readys_readys_7[0] : state_7_0;	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24
  assign allowed_7_1 = idle_7 ? readys_readys_7[1] : state_7_1;	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24
  wire        out_42_valid =
    idle_7
      ? _sink_ACancel_earlyValid_T_49
      : state_7_0 & validQuals_0_7 | state_7_1 & validQuals_1_7;	// Arbiter.scala:88:28, :107:36, :116:26, :125:29, Mux.scala:27:72, Xbar.scala:179:40
  wire        out_42_bits_corrupt =
    muxStateEarly_7_0 & auto_out_0_d_bits_corrupt | muxStateEarly_7_1
    & auto_out_1_d_bits_corrupt;	// Arbiter.scala:117:30, Mux.scala:27:72
  wire        out_42_bits_denied =
    muxStateEarly_7_0 & auto_out_0_d_bits_denied | muxStateEarly_7_1
    & auto_out_1_d_bits_denied;	// Arbiter.scala:117:30, Mux.scala:27:72
  wire [2:0]  out_42_bits_sink =
    (muxStateEarly_7_0 ? out_55_bits_sink : 3'h0)
    | (muxStateEarly_7_1 ? auto_out_1_d_bits_sink : 3'h0);	// Arbiter.scala:117:30, Mux.scala:27:72, Xbar.scala:323:28
  wire [1:0]  out_42_bits_source =
    (muxStateEarly_7_0 ? auto_out_0_d_bits_source[1:0] : 2'h0)
    | (muxStateEarly_7_1 ? auto_out_1_d_bits_source[1:0] : 2'h0);	// Arbiter.scala:117:30, Mux.scala:27:72, Xbar.scala:254:26
  wire [3:0]  out_42_bits_size =
    (muxStateEarly_7_0 ? auto_out_0_d_bits_size : 4'h0)
    | (muxStateEarly_7_1 ? out_56_bits_size : 4'h0);	// Arbiter.scala:117:30, BundleMap.scala:247:19, Bundles.scala:257:54, Mux.scala:27:72
  wire [1:0]  out_42_bits_param =
    (muxStateEarly_7_0 ? auto_out_0_d_bits_param : 2'h0)
    | (muxStateEarly_7_1 ? auto_out_1_d_bits_param : 2'h0);	// Arbiter.scala:117:30, Mux.scala:27:72, Xbar.scala:254:26
  wire [2:0]  out_42_bits_opcode =
    (muxStateEarly_7_0 ? auto_out_0_d_bits_opcode : 3'h0)
    | (muxStateEarly_7_1 ? auto_out_1_d_bits_opcode : 3'h0);	// Arbiter.scala:117:30, Mux.scala:27:72
  reg  [8:0]  beatsLeft_8;	// Arbiter.scala:87:30
  wire        idle_8 = beatsLeft_8 == 9'h0;	// Arbiter.scala:87:30, :88:28, Edges.scala:220:14
  wire [1:0]  readys_filter_lo_8 = {validQuals_1_8, validQuals_0_8};	// Cat.scala:30:58, Xbar.scala:179:40
  reg  [1:0]  readys_mask_8;	// Arbiter.scala:23:23
  wire [1:0]  readys_filter_hi_8 = readys_filter_lo_8 & ~readys_mask_8;	// Arbiter.scala:23:23, :24:{28,30}, Cat.scala:30:58
  wire [1:0]  readys_readys_8 =
    ~({readys_mask_8[1], readys_filter_hi_8[1] | readys_mask_8[0]}
      & ({readys_filter_hi_8[0], validQuals_1_8} | readys_filter_hi_8));	// Arbiter.scala:23:23, :24:28, :25:58, :26:{18,29,39}, Xbar.scala:179:40, package.scala:253:43
  wire        prefixOR_1_8 = readys_readys_8[0] & validQuals_0_8;	// Arbiter.scala:26:18, :95:86, :97:79, Xbar.scala:179:40
  wire        earlyWinner_8_1 = readys_readys_8[1] & validQuals_1_8;	// Arbiter.scala:26:18, :95:86, :97:79, Xbar.scala:179:40
  wire        _sink_ACancel_earlyValid_T_54 = validQuals_0_8 | validQuals_1_8;	// Arbiter.scala:107:36, Xbar.scala:179:40
  reg         state_8_0;	// Arbiter.scala:116:26
  reg         state_8_1;	// Arbiter.scala:116:26
  wire        muxStateEarly_8_0 = idle_8 ? prefixOR_1_8 : state_8_0;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        muxStateEarly_8_1 = idle_8 ? earlyWinner_8_1 : state_8_1;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  assign allowed_8_0 = idle_8 ? readys_readys_8[0] : state_8_0;	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24
  assign allowed_8_1 = idle_8 ? readys_readys_8[1] : state_8_1;	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24
  wire        out_47_valid =
    idle_8
      ? _sink_ACancel_earlyValid_T_54
      : state_8_0 & validQuals_0_8 | state_8_1 & validQuals_1_8;	// Arbiter.scala:88:28, :107:36, :116:26, :125:29, Mux.scala:27:72, Xbar.scala:179:40
  wire        out_47_bits_corrupt =
    muxStateEarly_8_0 & auto_out_0_d_bits_corrupt | muxStateEarly_8_1
    & auto_out_1_d_bits_corrupt;	// Arbiter.scala:117:30, Mux.scala:27:72
  wire        out_47_bits_denied =
    muxStateEarly_8_0 & auto_out_0_d_bits_denied | muxStateEarly_8_1
    & auto_out_1_d_bits_denied;	// Arbiter.scala:117:30, Mux.scala:27:72
  wire [2:0]  out_47_bits_sink =
    (muxStateEarly_8_0 ? out_55_bits_sink : 3'h0)
    | (muxStateEarly_8_1 ? auto_out_1_d_bits_sink : 3'h0);	// Arbiter.scala:117:30, Mux.scala:27:72, Xbar.scala:323:28
  wire [4:0]  out_47_bits_source =
    (muxStateEarly_8_0 ? auto_out_0_d_bits_source[4:0] : 5'h0)
    | (muxStateEarly_8_1 ? auto_out_1_d_bits_source[4:0] : 5'h0);	// Arbiter.scala:117:30, Bundles.scala:257:54, Mux.scala:27:72
  wire [3:0]  out_47_bits_size =
    (muxStateEarly_8_0 ? auto_out_0_d_bits_size : 4'h0)
    | (muxStateEarly_8_1 ? out_56_bits_size : 4'h0);	// Arbiter.scala:117:30, BundleMap.scala:247:19, Bundles.scala:257:54, Mux.scala:27:72
  wire [1:0]  out_47_bits_param =
    (muxStateEarly_8_0 ? auto_out_0_d_bits_param : 2'h0)
    | (muxStateEarly_8_1 ? auto_out_1_d_bits_param : 2'h0);	// Arbiter.scala:117:30, Mux.scala:27:72, Xbar.scala:254:26
  wire [2:0]  out_47_bits_opcode =
    (muxStateEarly_8_0 ? auto_out_0_d_bits_opcode : 3'h0)
    | (muxStateEarly_8_1 ? auto_out_1_d_bits_opcode : 3'h0);	// Arbiter.scala:117:30, Mux.scala:27:72
  reg  [8:0]  beatsLeft_9;	// Arbiter.scala:87:30
  wire        idle_9 = beatsLeft_9 == 9'h0;	// Arbiter.scala:87:30, :88:28, Edges.scala:220:14
  wire [1:0]  readys_filter_lo_9 = {validQuals_1_9, validQuals_0_9};	// Cat.scala:30:58, Xbar.scala:179:40
  reg  [1:0]  readys_mask_9;	// Arbiter.scala:23:23
  wire [1:0]  readys_filter_hi_9 = readys_filter_lo_9 & ~readys_mask_9;	// Arbiter.scala:23:23, :24:{28,30}, Cat.scala:30:58
  wire [1:0]  readys_readys_9 =
    ~({readys_mask_9[1], readys_filter_hi_9[1] | readys_mask_9[0]}
      & ({readys_filter_hi_9[0], validQuals_1_9} | readys_filter_hi_9));	// Arbiter.scala:23:23, :24:28, :25:58, :26:{18,29,39}, Xbar.scala:179:40, package.scala:253:43
  wire        prefixOR_1_9 = readys_readys_9[0] & validQuals_0_9;	// Arbiter.scala:26:18, :95:86, :97:79, Xbar.scala:179:40
  wire        earlyWinner_9_1 = readys_readys_9[1] & validQuals_1_9;	// Arbiter.scala:26:18, :95:86, :97:79, Xbar.scala:179:40
  wire        _sink_ACancel_earlyValid_T_59 = validQuals_0_9 | validQuals_1_9;	// Arbiter.scala:107:36, Xbar.scala:179:40
  reg         state_9_0;	// Arbiter.scala:116:26
  reg         state_9_1;	// Arbiter.scala:116:26
  wire        muxStateEarly_9_0 = idle_9 ? prefixOR_1_9 : state_9_0;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        muxStateEarly_9_1 = idle_9 ? earlyWinner_9_1 : state_9_1;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  assign allowed_9_0 = idle_9 ? readys_readys_9[0] : state_9_0;	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24
  assign allowed_9_1 = idle_9 ? readys_readys_9[1] : state_9_1;	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24
  wire        out_52_valid =
    idle_9
      ? _sink_ACancel_earlyValid_T_59
      : state_9_0 & validQuals_0_9 | state_9_1 & validQuals_1_9;	// Arbiter.scala:88:28, :107:36, :116:26, :125:29, Mux.scala:27:72, Xbar.scala:179:40
  wire        out_52_bits_corrupt =
    muxStateEarly_9_0 & auto_out_0_d_bits_corrupt | muxStateEarly_9_1
    & auto_out_1_d_bits_corrupt;	// Arbiter.scala:117:30, Mux.scala:27:72
  wire        out_52_bits_denied =
    muxStateEarly_9_0 & auto_out_0_d_bits_denied | muxStateEarly_9_1
    & auto_out_1_d_bits_denied;	// Arbiter.scala:117:30, Mux.scala:27:72
  wire [2:0]  out_52_bits_sink =
    (muxStateEarly_9_0 ? out_55_bits_sink : 3'h0)
    | (muxStateEarly_9_1 ? auto_out_1_d_bits_sink : 3'h0);	// Arbiter.scala:117:30, Mux.scala:27:72, Xbar.scala:323:28
  wire [3:0]  out_52_bits_source =
    (muxStateEarly_9_0 ? auto_out_0_d_bits_source[3:0] : 4'h0)
    | (muxStateEarly_9_1 ? auto_out_1_d_bits_source[3:0] : 4'h0);	// Arbiter.scala:117:30, Bundles.scala:257:54, Mux.scala:27:72
  wire [3:0]  out_52_bits_size =
    (muxStateEarly_9_0 ? auto_out_0_d_bits_size : 4'h0)
    | (muxStateEarly_9_1 ? out_56_bits_size : 4'h0);	// Arbiter.scala:117:30, BundleMap.scala:247:19, Bundles.scala:257:54, Mux.scala:27:72
  wire [1:0]  out_52_bits_param =
    (muxStateEarly_9_0 ? auto_out_0_d_bits_param : 2'h0)
    | (muxStateEarly_9_1 ? auto_out_1_d_bits_param : 2'h0);	// Arbiter.scala:117:30, Mux.scala:27:72, Xbar.scala:254:26
  wire [2:0]  out_52_bits_opcode =
    (muxStateEarly_9_0 ? auto_out_0_d_bits_opcode : 3'h0)
    | (muxStateEarly_9_1 ? auto_out_1_d_bits_opcode : 3'h0);	// Arbiter.scala:117:30, Mux.scala:27:72
  reg  [8:0]  beatsLeft_10;	// Arbiter.scala:87:30
  wire        idle_10 = beatsLeft_10 == 9'h0;	// Arbiter.scala:87:30, :88:28, Edges.scala:220:14
  wire [1:0]  readys_filter_lo_10 = {validQuals_1_10, validQuals_0_10};	// Cat.scala:30:58, Xbar.scala:179:40
  reg  [1:0]  readys_mask_10;	// Arbiter.scala:23:23
  wire [1:0]  readys_filter_hi_10 = readys_filter_lo_10 & ~readys_mask_10;	// Arbiter.scala:23:23, :24:{28,30}, Cat.scala:30:58
  wire [1:0]  readys_readys_10 =
    ~({readys_mask_10[1], readys_filter_hi_10[1] | readys_mask_10[0]}
      & ({readys_filter_hi_10[0], validQuals_1_10} | readys_filter_hi_10));	// Arbiter.scala:23:23, :24:28, :25:58, :26:{18,29,39}, Xbar.scala:179:40, package.scala:253:43
  wire        prefixOR_1_10 = readys_readys_10[0] & validQuals_0_10;	// Arbiter.scala:26:18, :95:86, :97:79, Xbar.scala:179:40
  wire        earlyWinner_10_1 = readys_readys_10[1] & validQuals_1_10;	// Arbiter.scala:26:18, :95:86, :97:79, Xbar.scala:179:40
  wire        _sink_ACancel_earlyValid_T_64 = validQuals_0_10 | validQuals_1_10;	// Arbiter.scala:107:36, Xbar.scala:179:40
  `ifndef SYNTHESIS	// Arbiter.scala:105:13
    always @(posedge clock) begin	// Arbiter.scala:105:13
      automatic logic prefixOR_2 = prefixOR_1 | earlyWinner_1;	// Arbiter.scala:97:79, :104:53
      automatic logic prefixOR_3 = prefixOR_2 | earlyWinner_2;	// Arbiter.scala:97:79, :104:53
      automatic logic prefixOR_4 = prefixOR_3 | earlyWinner_3;	// Arbiter.scala:97:79, :104:53
      automatic logic prefixOR_5 = prefixOR_4 | earlyWinner_4;	// Arbiter.scala:97:79, :104:53
      automatic logic prefixOR_2_1 = prefixOR_1_1 | earlyWinner_1_1;	// Arbiter.scala:97:79, :104:53
      automatic logic prefixOR_3_1 = prefixOR_2_1 | earlyWinner_1_2;	// Arbiter.scala:97:79, :104:53
      automatic logic prefixOR_4_1 = prefixOR_3_1 | earlyWinner_1_3;	// Arbiter.scala:97:79, :104:53
      automatic logic prefixOR_5_1 = prefixOR_4_1 | earlyWinner_1_4;	// Arbiter.scala:97:79, :104:53
      automatic logic prefixOR_2_2 = prefixOR_1_2 | earlyWinner_2_1;	// Arbiter.scala:97:79, :104:53
      automatic logic prefixOR_3_2 = prefixOR_2_2 | earlyWinner_2_2;	// Arbiter.scala:97:79, :104:53
      automatic logic prefixOR_4_2 = prefixOR_3_2 | earlyWinner_2_3;	// Arbiter.scala:97:79, :104:53
      automatic logic prefixOR_2_3 = prefixOR_1_3 | earlyWinner_3_1;	// Arbiter.scala:97:79, :104:53
      automatic logic prefixOR_3_3 = prefixOR_2_3 | earlyWinner_3_2;	// Arbiter.scala:97:79, :104:53
      automatic logic prefixOR_4_3 = prefixOR_3_3 | earlyWinner_3_3;	// Arbiter.scala:97:79, :104:53
      if (~((~prefixOR_1 | ~earlyWinner_1) & (~prefixOR_2 | ~earlyWinner_2)
            & (~prefixOR_3 | ~earlyWinner_3) & (~prefixOR_4 | ~earlyWinner_4)
            & (~prefixOR_5 | ~earlyWinner_5)
            & (~(prefixOR_5 | earlyWinner_5) | ~earlyWinner_6) | reset)) begin	// Arbiter.scala:97:79, :104:53, :105:{13,61,64,67,82}
        if (`ASSERT_VERBOSE_COND_)	// Arbiter.scala:105:13
          $error("Assertion failed\n    at Arbiter.scala:105 assert((prefixOR zip earlyWinner) map { case (p,w) => !p || !w } reduce {_ && _})\n");	// Arbiter.scala:105:13
        if (`STOP_COND_)	// Arbiter.scala:105:13
          $fatal;	// Arbiter.scala:105:13
      end
      if (~(~(_out_0_a_earlyValid_T | validQuals_2 | validQuals_3 | validQuals_4
              | validQuals_5 | validQuals_6) | prefixOR_1 | earlyWinner_1 | earlyWinner_2
            | earlyWinner_3 | earlyWinner_4 | earlyWinner_5 | earlyWinner_6
            | reset)) begin	// Arbiter.scala:97:79, :107:{14,15,36}, Xbar.scala:428:50
        if (`ASSERT_VERBOSE_COND_)	// Arbiter.scala:107:14
          $error("Assertion failed\n    at Arbiter.scala:107 assert (!earlyValids.reduce(_||_) || earlyWinner.reduce(_||_))\n");	// Arbiter.scala:107:14
        if (`STOP_COND_)	// Arbiter.scala:107:14
          $fatal;	// Arbiter.scala:107:14
      end
      if (~((~prefixOR_1_1 | ~earlyWinner_1_1) & (~prefixOR_2_1 | ~earlyWinner_1_2)
            & (~prefixOR_3_1 | ~earlyWinner_1_3) & (~prefixOR_4_1 | ~earlyWinner_1_4)
            & (~prefixOR_5_1 | ~earlyWinner_1_5)
            & (~(prefixOR_5_1 | earlyWinner_1_5) | ~earlyWinner_1_6) | reset)) begin	// Arbiter.scala:97:79, :104:53, :105:{13,61,64,67,82}
        if (`ASSERT_VERBOSE_COND_)	// Arbiter.scala:105:13
          $error("Assertion failed\n    at Arbiter.scala:105 assert((prefixOR zip earlyWinner) map { case (p,w) => !p || !w } reduce {_ && _})\n");	// Arbiter.scala:105:13
        if (`STOP_COND_)	// Arbiter.scala:105:13
          $fatal;	// Arbiter.scala:105:13
      end
      if (~(~(_out_1_a_earlyValid_T | validQuals_2_1 | validQuals_3_1 | validQuals_4_1
              | validQuals_5_1 | validQuals_6_1) | prefixOR_1_1 | earlyWinner_1_1
            | earlyWinner_1_2 | earlyWinner_1_3 | earlyWinner_1_4 | earlyWinner_1_5
            | earlyWinner_1_6 | reset)) begin	// Arbiter.scala:97:79, :107:{14,15,36}, Xbar.scala:428:50
        if (`ASSERT_VERBOSE_COND_)	// Arbiter.scala:107:14
          $error("Assertion failed\n    at Arbiter.scala:107 assert (!earlyValids.reduce(_||_) || earlyWinner.reduce(_||_))\n");	// Arbiter.scala:107:14
        if (`STOP_COND_)	// Arbiter.scala:107:14
          $fatal;	// Arbiter.scala:107:14
      end
      if (~((~prefixOR_1_2 | ~earlyWinner_2_1) & (~prefixOR_2_2 | ~earlyWinner_2_2)
            & (~prefixOR_3_2 | ~earlyWinner_2_3) & (~prefixOR_4_2 | ~earlyWinner_2_4)
            & (~(prefixOR_4_2 | earlyWinner_2_4) | ~earlyWinner_2_5) | reset)) begin	// Arbiter.scala:97:79, :104:53, :105:{13,61,64,67,82}
        if (`ASSERT_VERBOSE_COND_)	// Arbiter.scala:105:13
          $error("Assertion failed\n    at Arbiter.scala:105 assert((prefixOR zip earlyWinner) map { case (p,w) => !p || !w } reduce {_ && _})\n");	// Arbiter.scala:105:13
        if (`STOP_COND_)	// Arbiter.scala:105:13
          $fatal;	// Arbiter.scala:105:13
      end
      if (~(~(_sink_ACancel_earlyValid_T | auto_in_3_c_valid | auto_in_4_c_valid
              | auto_in_5_c_valid | auto_in_6_c_valid) | prefixOR_1_2 | earlyWinner_2_1
            | earlyWinner_2_2 | earlyWinner_2_3 | earlyWinner_2_4 | earlyWinner_2_5
            | reset)) begin	// Arbiter.scala:97:79, :107:{14,15,36}
        if (`ASSERT_VERBOSE_COND_)	// Arbiter.scala:107:14
          $error("Assertion failed\n    at Arbiter.scala:107 assert (!earlyValids.reduce(_||_) || earlyWinner.reduce(_||_))\n");	// Arbiter.scala:107:14
        if (`STOP_COND_)	// Arbiter.scala:107:14
          $fatal;	// Arbiter.scala:107:14
      end
      if (~((~prefixOR_1_3 | ~earlyWinner_3_1) & (~prefixOR_2_3 | ~earlyWinner_3_2)
            & (~prefixOR_3_3 | ~earlyWinner_3_3) & (~prefixOR_4_3 | ~earlyWinner_3_4)
            & (~(prefixOR_4_3 | earlyWinner_3_4) | ~earlyWinner_3_5) | reset)) begin	// Arbiter.scala:97:79, :104:53, :105:{13,61,64,67,82}
        if (`ASSERT_VERBOSE_COND_)	// Arbiter.scala:105:13
          $error("Assertion failed\n    at Arbiter.scala:105 assert((prefixOR zip earlyWinner) map { case (p,w) => !p || !w } reduce {_ && _})\n");	// Arbiter.scala:105:13
        if (`STOP_COND_)	// Arbiter.scala:105:13
          $fatal;	// Arbiter.scala:105:13
      end
      if (~(~(_sink_ACancel_earlyValid_T_17 | auto_in_3_e_valid | auto_in_4_e_valid
              | auto_in_5_e_valid | auto_in_6_e_valid) | prefixOR_1_3 | earlyWinner_3_1
            | earlyWinner_3_2 | earlyWinner_3_3 | earlyWinner_3_4 | earlyWinner_3_5
            | reset)) begin	// Arbiter.scala:97:79, :107:{14,15,36}
        if (`ASSERT_VERBOSE_COND_)	// Arbiter.scala:107:14
          $error("Assertion failed\n    at Arbiter.scala:107 assert (!earlyValids.reduce(_||_) || earlyWinner.reduce(_||_))\n");	// Arbiter.scala:107:14
        if (`STOP_COND_)	// Arbiter.scala:107:14
          $fatal;	// Arbiter.scala:107:14
      end
      if (~(~prefixOR_1_4 | ~earlyWinner_4_1 | reset)) begin	// Arbiter.scala:97:79, :105:{13,61,67}
        if (`ASSERT_VERBOSE_COND_)	// Arbiter.scala:105:13
          $error("Assertion failed\n    at Arbiter.scala:105 assert((prefixOR zip earlyWinner) map { case (p,w) => !p || !w } reduce {_ && _})\n");	// Arbiter.scala:105:13
        if (`STOP_COND_)	// Arbiter.scala:105:13
          $fatal;	// Arbiter.scala:105:13
      end
      if (~(~_sink_ACancel_earlyValid_T_34 | prefixOR_1_4 | earlyWinner_4_1
            | reset)) begin	// Arbiter.scala:97:79, :107:{14,15,36}
        if (`ASSERT_VERBOSE_COND_)	// Arbiter.scala:107:14
          $error("Assertion failed\n    at Arbiter.scala:107 assert (!earlyValids.reduce(_||_) || earlyWinner.reduce(_||_))\n");	// Arbiter.scala:107:14
        if (`STOP_COND_)	// Arbiter.scala:107:14
          $fatal;	// Arbiter.scala:107:14
      end
      if (~(~prefixOR_1_5 | ~earlyWinner_5_1 | reset)) begin	// Arbiter.scala:97:79, :105:{13,61,67}
        if (`ASSERT_VERBOSE_COND_)	// Arbiter.scala:105:13
          $error("Assertion failed\n    at Arbiter.scala:105 assert((prefixOR zip earlyWinner) map { case (p,w) => !p || !w } reduce {_ && _})\n");	// Arbiter.scala:105:13
        if (`STOP_COND_)	// Arbiter.scala:105:13
          $fatal;	// Arbiter.scala:105:13
      end
      if (~(~_sink_ACancel_earlyValid_T_39 | prefixOR_1_5 | earlyWinner_5_1
            | reset)) begin	// Arbiter.scala:97:79, :107:{14,15,36}
        if (`ASSERT_VERBOSE_COND_)	// Arbiter.scala:107:14
          $error("Assertion failed\n    at Arbiter.scala:107 assert (!earlyValids.reduce(_||_) || earlyWinner.reduce(_||_))\n");	// Arbiter.scala:107:14
        if (`STOP_COND_)	// Arbiter.scala:107:14
          $fatal;	// Arbiter.scala:107:14
      end
      if (~(~prefixOR_1_6 | ~earlyWinner_6_1 | reset)) begin	// Arbiter.scala:97:79, :105:{13,61,67}
        if (`ASSERT_VERBOSE_COND_)	// Arbiter.scala:105:13
          $error("Assertion failed\n    at Arbiter.scala:105 assert((prefixOR zip earlyWinner) map { case (p,w) => !p || !w } reduce {_ && _})\n");	// Arbiter.scala:105:13
        if (`STOP_COND_)	// Arbiter.scala:105:13
          $fatal;	// Arbiter.scala:105:13
      end
      if (~(~_sink_ACancel_earlyValid_T_44 | prefixOR_1_6 | earlyWinner_6_1
            | reset)) begin	// Arbiter.scala:97:79, :107:{14,15,36}
        if (`ASSERT_VERBOSE_COND_)	// Arbiter.scala:107:14
          $error("Assertion failed\n    at Arbiter.scala:107 assert (!earlyValids.reduce(_||_) || earlyWinner.reduce(_||_))\n");	// Arbiter.scala:107:14
        if (`STOP_COND_)	// Arbiter.scala:107:14
          $fatal;	// Arbiter.scala:107:14
      end
      if (~(~prefixOR_1_7 | ~earlyWinner_7_1 | reset)) begin	// Arbiter.scala:97:79, :105:{13,61,67}
        if (`ASSERT_VERBOSE_COND_)	// Arbiter.scala:105:13
          $error("Assertion failed\n    at Arbiter.scala:105 assert((prefixOR zip earlyWinner) map { case (p,w) => !p || !w } reduce {_ && _})\n");	// Arbiter.scala:105:13
        if (`STOP_COND_)	// Arbiter.scala:105:13
          $fatal;	// Arbiter.scala:105:13
      end
      if (~(~_sink_ACancel_earlyValid_T_49 | prefixOR_1_7 | earlyWinner_7_1
            | reset)) begin	// Arbiter.scala:97:79, :107:{14,15,36}
        if (`ASSERT_VERBOSE_COND_)	// Arbiter.scala:107:14
          $error("Assertion failed\n    at Arbiter.scala:107 assert (!earlyValids.reduce(_||_) || earlyWinner.reduce(_||_))\n");	// Arbiter.scala:107:14
        if (`STOP_COND_)	// Arbiter.scala:107:14
          $fatal;	// Arbiter.scala:107:14
      end
      if (~(~prefixOR_1_8 | ~earlyWinner_8_1 | reset)) begin	// Arbiter.scala:97:79, :105:{13,61,67}
        if (`ASSERT_VERBOSE_COND_)	// Arbiter.scala:105:13
          $error("Assertion failed\n    at Arbiter.scala:105 assert((prefixOR zip earlyWinner) map { case (p,w) => !p || !w } reduce {_ && _})\n");	// Arbiter.scala:105:13
        if (`STOP_COND_)	// Arbiter.scala:105:13
          $fatal;	// Arbiter.scala:105:13
      end
      if (~(~_sink_ACancel_earlyValid_T_54 | prefixOR_1_8 | earlyWinner_8_1
            | reset)) begin	// Arbiter.scala:97:79, :107:{14,15,36}
        if (`ASSERT_VERBOSE_COND_)	// Arbiter.scala:107:14
          $error("Assertion failed\n    at Arbiter.scala:107 assert (!earlyValids.reduce(_||_) || earlyWinner.reduce(_||_))\n");	// Arbiter.scala:107:14
        if (`STOP_COND_)	// Arbiter.scala:107:14
          $fatal;	// Arbiter.scala:107:14
      end
      if (~(~prefixOR_1_9 | ~earlyWinner_9_1 | reset)) begin	// Arbiter.scala:97:79, :105:{13,61,67}
        if (`ASSERT_VERBOSE_COND_)	// Arbiter.scala:105:13
          $error("Assertion failed\n    at Arbiter.scala:105 assert((prefixOR zip earlyWinner) map { case (p,w) => !p || !w } reduce {_ && _})\n");	// Arbiter.scala:105:13
        if (`STOP_COND_)	// Arbiter.scala:105:13
          $fatal;	// Arbiter.scala:105:13
      end
      if (~(~_sink_ACancel_earlyValid_T_59 | prefixOR_1_9 | earlyWinner_9_1
            | reset)) begin	// Arbiter.scala:97:79, :107:{14,15,36}
        if (`ASSERT_VERBOSE_COND_)	// Arbiter.scala:107:14
          $error("Assertion failed\n    at Arbiter.scala:107 assert (!earlyValids.reduce(_||_) || earlyWinner.reduce(_||_))\n");	// Arbiter.scala:107:14
        if (`STOP_COND_)	// Arbiter.scala:107:14
          $fatal;	// Arbiter.scala:107:14
      end
      if (~(~prefixOR_1_10 | ~earlyWinner_10_1 | reset)) begin	// Arbiter.scala:97:79, :105:{13,61,67}
        if (`ASSERT_VERBOSE_COND_)	// Arbiter.scala:105:13
          $error("Assertion failed\n    at Arbiter.scala:105 assert((prefixOR zip earlyWinner) map { case (p,w) => !p || !w } reduce {_ && _})\n");	// Arbiter.scala:105:13
        if (`STOP_COND_)	// Arbiter.scala:105:13
          $fatal;	// Arbiter.scala:105:13
      end
      if (~(~_sink_ACancel_earlyValid_T_64 | prefixOR_1_10 | earlyWinner_10_1
            | reset)) begin	// Arbiter.scala:97:79, :107:{14,15,36}
        if (`ASSERT_VERBOSE_COND_)	// Arbiter.scala:107:14
          $error("Assertion failed\n    at Arbiter.scala:107 assert (!earlyValids.reduce(_||_) || earlyWinner.reduce(_||_))\n");	// Arbiter.scala:107:14
        if (`STOP_COND_)	// Arbiter.scala:107:14
          $fatal;	// Arbiter.scala:107:14
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  reg         state_10_0;	// Arbiter.scala:116:26
  reg         state_10_1;	// Arbiter.scala:116:26
  wire        muxStateEarly_10_0 = idle_10 ? prefixOR_1_10 : state_10_0;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  wire        muxStateEarly_10_1 = idle_10 ? earlyWinner_10_1 : state_10_1;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  assign allowed_10_0 = idle_10 ? readys_readys_10[0] : state_10_0;	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24
  assign allowed_10_1 = idle_10 ? readys_readys_10[1] : state_10_1;	// Arbiter.scala:26:18, :88:28, :95:86, :116:26, :121:24
  wire        out_57_valid =
    idle_10
      ? _sink_ACancel_earlyValid_T_64
      : state_10_0 & validQuals_0_10 | state_10_1 & validQuals_1_10;	// Arbiter.scala:88:28, :107:36, :116:26, :125:29, Mux.scala:27:72, Xbar.scala:179:40
  wire        out_57_bits_corrupt =
    muxStateEarly_10_0 & auto_out_0_d_bits_corrupt | muxStateEarly_10_1
    & auto_out_1_d_bits_corrupt;	// Arbiter.scala:117:30, Mux.scala:27:72
  wire        out_57_bits_denied =
    muxStateEarly_10_0 & auto_out_0_d_bits_denied | muxStateEarly_10_1
    & auto_out_1_d_bits_denied;	// Arbiter.scala:117:30, Mux.scala:27:72
  wire [2:0]  out_57_bits_sink =
    (muxStateEarly_10_0 ? out_55_bits_sink : 3'h0)
    | (muxStateEarly_10_1 ? auto_out_1_d_bits_sink : 3'h0);	// Arbiter.scala:117:30, Mux.scala:27:72, Xbar.scala:323:28
  wire [2:0]  out_57_bits_source =
    (muxStateEarly_10_0 ? auto_out_0_d_bits_source[2:0] : 3'h0)
    | (muxStateEarly_10_1 ? auto_out_1_d_bits_source[2:0] : 3'h0);	// Arbiter.scala:117:30, Mux.scala:27:72
  wire [3:0]  out_57_bits_size =
    (muxStateEarly_10_0 ? auto_out_0_d_bits_size : 4'h0)
    | (muxStateEarly_10_1 ? out_56_bits_size : 4'h0);	// Arbiter.scala:117:30, BundleMap.scala:247:19, Bundles.scala:257:54, Mux.scala:27:72
  wire [1:0]  out_57_bits_param =
    (muxStateEarly_10_0 ? auto_out_0_d_bits_param : 2'h0)
    | (muxStateEarly_10_1 ? auto_out_1_d_bits_param : 2'h0);	// Arbiter.scala:117:30, Mux.scala:27:72, Xbar.scala:254:26
  wire [2:0]  out_57_bits_opcode =
    (muxStateEarly_10_0 ? auto_out_0_d_bits_opcode : 3'h0)
    | (muxStateEarly_10_1 ? auto_out_1_d_bits_opcode : 3'h0);	// Arbiter.scala:117:30, Mux.scala:27:72
  always @(posedge clock) begin
    if (reset) begin
      beatsLeft <= 9'h0;	// Arbiter.scala:87:30, Edges.scala:220:14
      readys_mask <= 7'h7F;	// Arbiter.scala:23:23
      state_0 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      state_1 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      state_2 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      state_3 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      state_4 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      state_5 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      state_6 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      beatsLeft_1 <= 9'h0;	// Arbiter.scala:87:30, Edges.scala:220:14
      readys_mask_1 <= 7'h7F;	// Arbiter.scala:23:23
      state_1_0 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      state_1_1 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      state_1_2 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      state_1_3 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      state_1_4 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      state_1_5 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      state_1_6 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      beatsLeft_2 <= 9'h0;	// Arbiter.scala:87:30, Edges.scala:220:14
      readys_mask_2 <= 6'h3F;	// Arbiter.scala:23:23, package.scala:234:70
      state_2_0 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      state_2_1 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      state_2_2 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      state_2_3 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      state_2_4 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      state_2_5 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      beatsLeft_3 <= 1'h0;	// Arbiter.scala:87:30, Bundle_ACancel.scala:55:22
      readys_mask_3 <= 6'h3F;	// Arbiter.scala:23:23, package.scala:234:70
      state_3_0 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      state_3_1 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      state_3_2 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      state_3_3 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      state_3_4 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      state_3_5 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      beatsLeft_4 <= 9'h0;	// Arbiter.scala:87:30, Edges.scala:220:14
      readys_mask_4 <= 2'h3;	// Arbiter.scala:23:23, Parameters.scala:57:20
      state_4_0 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      state_4_1 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      beatsLeft_5 <= 9'h0;	// Arbiter.scala:87:30, Edges.scala:220:14
      readys_mask_5 <= 2'h3;	// Arbiter.scala:23:23, Parameters.scala:57:20
      state_5_0 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      state_5_1 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      beatsLeft_6 <= 9'h0;	// Arbiter.scala:87:30, Edges.scala:220:14
      readys_mask_6 <= 2'h3;	// Arbiter.scala:23:23, Parameters.scala:57:20
      state_6_0 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      state_6_1 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      beatsLeft_7 <= 9'h0;	// Arbiter.scala:87:30, Edges.scala:220:14
      readys_mask_7 <= 2'h3;	// Arbiter.scala:23:23, Parameters.scala:57:20
      state_7_0 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      state_7_1 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      beatsLeft_8 <= 9'h0;	// Arbiter.scala:87:30, Edges.scala:220:14
      readys_mask_8 <= 2'h3;	// Arbiter.scala:23:23, Parameters.scala:57:20
      state_8_0 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      state_8_1 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      beatsLeft_9 <= 9'h0;	// Arbiter.scala:87:30, Edges.scala:220:14
      readys_mask_9 <= 2'h3;	// Arbiter.scala:23:23, Parameters.scala:57:20
      state_9_0 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      state_9_1 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      beatsLeft_10 <= 9'h0;	// Arbiter.scala:87:30, Edges.scala:220:14
      readys_mask_10 <= 2'h3;	// Arbiter.scala:23:23, Parameters.scala:57:20
      state_10_0 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
      state_10_1 <= 1'h0;	// Arbiter.scala:116:26, Bundle_ACancel.scala:55:22
    end
    else begin
      automatic logic [26:0] _beatsAI_decode_T_1 = 27'hFFF << auto_in_0_a_bits_size;	// package.scala:234:77
      automatic logic [26:0] _beatsAI_decode_T_5 = 27'hFFF << auto_in_1_a_bits_size;	// package.scala:234:77
      automatic logic [26:0] _beatsAI_decode_T_9 = 27'hFFF << auto_in_2_a_bits_size;	// package.scala:234:77
      automatic logic [26:0] _beatsAI_decode_T_13 = 27'hFFF << auto_in_3_a_bits_size;	// package.scala:234:77
      automatic logic [26:0] _beatsAI_decode_T_17 = 27'hFFF << auto_in_4_a_bits_size;	// package.scala:234:77
      automatic logic [26:0] _beatsAI_decode_T_21 = 27'hFFF << auto_in_5_a_bits_size;	// package.scala:234:77
      automatic logic [26:0] _beatsAI_decode_T_25 = 27'hFFF << auto_in_6_a_bits_size;	// package.scala:234:77
      automatic logic [26:0] _beatsDO_decode_T_1 = 27'hFFF << auto_out_0_d_bits_size;	// package.scala:234:77
      automatic logic [20:0] _beatsDO_decode_T_5 = 21'h3F << auto_out_1_d_bits_size;	// package.scala:234:77
      automatic logic        latch = idle & auto_out_0_a_ready;	// Arbiter.scala:88:28, :89:24
      automatic logic        winnerQual_0;	// Arbiter.scala:98:79
      automatic logic        winnerQual_1;	// Arbiter.scala:98:79
      automatic logic        winnerQual_2;	// Arbiter.scala:98:79
      automatic logic        winnerQual_3;	// Arbiter.scala:98:79
      automatic logic        winnerQual_4;	// Arbiter.scala:98:79
      automatic logic        winnerQual_5;	// Arbiter.scala:98:79
      automatic logic        winnerQual_6;	// Arbiter.scala:98:79
      automatic logic        latch_1 = idle_1 & auto_out_1_a_ready;	// Arbiter.scala:88:28, :89:24
      automatic logic        winnerQual_1_0;	// Arbiter.scala:98:79
      automatic logic        winnerQual_1_1;	// Arbiter.scala:98:79
      automatic logic        winnerQual_1_2;	// Arbiter.scala:98:79
      automatic logic        winnerQual_1_3;	// Arbiter.scala:98:79
      automatic logic        winnerQual_1_4;	// Arbiter.scala:98:79
      automatic logic        winnerQual_1_5;	// Arbiter.scala:98:79
      automatic logic        winnerQual_1_6;	// Arbiter.scala:98:79
      automatic logic        latch_2 = idle_2 & auto_out_1_c_ready;	// Arbiter.scala:88:28, :89:24
      automatic logic        winnerQual_2_0;	// Arbiter.scala:98:79
      automatic logic        winnerQual_2_1;	// Arbiter.scala:98:79
      automatic logic        winnerQual_2_2;	// Arbiter.scala:98:79
      automatic logic        winnerQual_2_3;	// Arbiter.scala:98:79
      automatic logic        winnerQual_2_4;	// Arbiter.scala:98:79
      automatic logic        winnerQual_2_5;	// Arbiter.scala:98:79
      automatic logic        latch_4 = idle_4 & auto_in_0_d_ready;	// Arbiter.scala:88:28, :89:24
      automatic logic        winnerQual_4_0;	// Arbiter.scala:98:79
      automatic logic        winnerQual_4_1;	// Arbiter.scala:98:79
      automatic logic        latch_5 = idle_5 & auto_in_1_d_ready;	// Arbiter.scala:88:28, :89:24
      automatic logic        winnerQual_5_0;	// Arbiter.scala:98:79
      automatic logic        winnerQual_5_1;	// Arbiter.scala:98:79
      automatic logic        latch_6 = idle_6 & auto_in_2_d_ready;	// Arbiter.scala:88:28, :89:24
      automatic logic        winnerQual_6_0;	// Arbiter.scala:98:79
      automatic logic        winnerQual_6_1;	// Arbiter.scala:98:79
      automatic logic        latch_7 = idle_7 & auto_in_3_d_ready;	// Arbiter.scala:88:28, :89:24
      automatic logic        winnerQual_7_0;	// Arbiter.scala:98:79
      automatic logic        winnerQual_7_1;	// Arbiter.scala:98:79
      automatic logic        latch_8 = idle_8 & auto_in_4_d_ready;	// Arbiter.scala:88:28, :89:24
      automatic logic        winnerQual_8_0;	// Arbiter.scala:98:79
      automatic logic        winnerQual_8_1;	// Arbiter.scala:98:79
      automatic logic        latch_9 = idle_9 & auto_in_5_d_ready;	// Arbiter.scala:88:28, :89:24
      automatic logic        winnerQual_9_0;	// Arbiter.scala:98:79
      automatic logic        winnerQual_9_1;	// Arbiter.scala:98:79
      automatic logic        latch_10 = idle_10 & auto_in_6_d_ready;	// Arbiter.scala:88:28, :89:24
      automatic logic        winnerQual_10_0;	// Arbiter.scala:98:79
      automatic logic        winnerQual_10_1;	// Arbiter.scala:98:79
      winnerQual_0 = readys_readys[0] & validQuals_0;	// Arbiter.scala:26:18, :95:86, :98:79, Xbar.scala:428:50
      winnerQual_1 = readys_readys[1] & validQuals_1;	// Arbiter.scala:26:18, :95:86, :98:79, Xbar.scala:428:50
      winnerQual_2 = readys_readys[2] & validQuals_2;	// Arbiter.scala:26:18, :95:86, :98:79, Xbar.scala:428:50
      winnerQual_3 = readys_readys[3] & validQuals_3;	// Arbiter.scala:26:18, :95:86, :98:79, Xbar.scala:428:50
      winnerQual_4 = readys_readys[4] & validQuals_4;	// Arbiter.scala:26:18, :95:86, :98:79, Xbar.scala:428:50
      winnerQual_5 = readys_readys[5] & validQuals_5;	// Arbiter.scala:26:18, :95:86, :98:79, Xbar.scala:428:50
      winnerQual_6 = readys_readys[6] & validQuals_6;	// Arbiter.scala:26:18, :95:86, :98:79, Xbar.scala:428:50
      winnerQual_1_0 = readys_readys_1[0] & validQuals_0_1;	// Arbiter.scala:26:18, :95:86, :98:79, Xbar.scala:428:50
      winnerQual_1_1 = readys_readys_1[1] & validQuals_1_1;	// Arbiter.scala:26:18, :95:86, :98:79, Xbar.scala:428:50
      winnerQual_1_2 = readys_readys_1[2] & validQuals_2_1;	// Arbiter.scala:26:18, :95:86, :98:79, Xbar.scala:428:50
      winnerQual_1_3 = readys_readys_1[3] & validQuals_3_1;	// Arbiter.scala:26:18, :95:86, :98:79, Xbar.scala:428:50
      winnerQual_1_4 = readys_readys_1[4] & validQuals_4_1;	// Arbiter.scala:26:18, :95:86, :98:79, Xbar.scala:428:50
      winnerQual_1_5 = readys_readys_1[5] & validQuals_5_1;	// Arbiter.scala:26:18, :95:86, :98:79, Xbar.scala:428:50
      winnerQual_1_6 = readys_readys_1[6] & validQuals_6_1;	// Arbiter.scala:26:18, :95:86, :98:79, Xbar.scala:428:50
      winnerQual_2_0 = readys_readys_2[0] & auto_in_1_c_valid;	// Arbiter.scala:26:18, :95:86, :98:79
      winnerQual_2_1 = readys_readys_2[1] & auto_in_2_c_valid;	// Arbiter.scala:26:18, :95:86, :98:79
      winnerQual_2_2 = readys_readys_2[2] & auto_in_3_c_valid;	// Arbiter.scala:26:18, :95:86, :98:79
      winnerQual_2_3 = readys_readys_2[3] & auto_in_4_c_valid;	// Arbiter.scala:26:18, :95:86, :98:79
      winnerQual_2_4 = readys_readys_2[4] & auto_in_5_c_valid;	// Arbiter.scala:26:18, :95:86, :98:79
      winnerQual_2_5 = readys_readys_2[5] & auto_in_6_c_valid;	// Arbiter.scala:26:18, :95:86, :98:79
      winnerQual_4_0 = readys_readys_4[0] & validQuals_0_4;	// Arbiter.scala:26:18, :95:86, :98:79, Xbar.scala:179:40
      winnerQual_4_1 = readys_readys_4[1] & validQuals_1_4;	// Arbiter.scala:26:18, :95:86, :98:79, Xbar.scala:179:40
      winnerQual_5_0 = readys_readys_5[0] & validQuals_0_5;	// Arbiter.scala:26:18, :95:86, :98:79, Xbar.scala:179:40
      winnerQual_5_1 = readys_readys_5[1] & validQuals_1_5;	// Arbiter.scala:26:18, :95:86, :98:79, Xbar.scala:179:40
      winnerQual_6_0 = readys_readys_6[0] & validQuals_0_6;	// Arbiter.scala:26:18, :95:86, :98:79, Xbar.scala:179:40
      winnerQual_6_1 = readys_readys_6[1] & validQuals_1_6;	// Arbiter.scala:26:18, :95:86, :98:79, Xbar.scala:179:40
      winnerQual_7_0 = readys_readys_7[0] & validQuals_0_7;	// Arbiter.scala:26:18, :95:86, :98:79, Xbar.scala:179:40
      winnerQual_7_1 = readys_readys_7[1] & validQuals_1_7;	// Arbiter.scala:26:18, :95:86, :98:79, Xbar.scala:179:40
      winnerQual_8_0 = readys_readys_8[0] & validQuals_0_8;	// Arbiter.scala:26:18, :95:86, :98:79, Xbar.scala:179:40
      winnerQual_8_1 = readys_readys_8[1] & validQuals_1_8;	// Arbiter.scala:26:18, :95:86, :98:79, Xbar.scala:179:40
      winnerQual_9_0 = readys_readys_9[0] & validQuals_0_9;	// Arbiter.scala:26:18, :95:86, :98:79, Xbar.scala:179:40
      winnerQual_9_1 = readys_readys_9[1] & validQuals_1_9;	// Arbiter.scala:26:18, :95:86, :98:79, Xbar.scala:179:40
      winnerQual_10_0 = readys_readys_10[0] & validQuals_0_10;	// Arbiter.scala:26:18, :95:86, :98:79, Xbar.scala:179:40
      winnerQual_10_1 = readys_readys_10[1] & validQuals_1_10;	// Arbiter.scala:26:18, :95:86, :98:79, Xbar.scala:179:40
      if (latch)	// Arbiter.scala:89:24
        beatsLeft <=
          (winnerQual_0 & ~(auto_in_0_a_bits_opcode[2])
             ? ~(_beatsAI_decode_T_1[11:3])
             : 9'h0)
          | (winnerQual_1 & ~(auto_in_1_a_bits_opcode[2])
               ? ~(_beatsAI_decode_T_5[11:3])
               : 9'h0)
          | (winnerQual_2 & ~(auto_in_2_a_bits_opcode[2])
               ? ~(_beatsAI_decode_T_9[11:3])
               : 9'h0)
          | (winnerQual_3 & ~(auto_in_3_a_bits_opcode[2])
               ? ~(_beatsAI_decode_T_13[11:3])
               : 9'h0)
          | (winnerQual_4 & ~(auto_in_4_a_bits_opcode[2])
               ? ~(_beatsAI_decode_T_17[11:3])
               : 9'h0)
          | (winnerQual_5 & ~(auto_in_5_a_bits_opcode[2])
               ? ~(_beatsAI_decode_T_21[11:3])
               : 9'h0)
          | (winnerQual_6 & ~(auto_in_6_a_bits_opcode[2])
               ? ~(_beatsAI_decode_T_25[11:3])
               : 9'h0);	// Arbiter.scala:87:30, :98:79, :111:73, :112:44, Edges.scala:91:{28,37}, :220:14, package.scala:234:{46,77,82}
      else	// Arbiter.scala:89:24
        beatsLeft <= beatsLeft - {8'h0, auto_out_0_a_ready & bundleOut_0_out_1_valid};	// Arbiter.scala:87:30, :113:52, :125:29, ReadyValidCancel.scala:50:33, Xbar.scala:254:26
      if (latch & (|readys_filter_lo)) begin	// Arbiter.scala:27:{18,27}, :89:24, Cat.scala:30:58
        automatic logic [6:0] _readys_mask_T = readys_readys & readys_filter_lo;	// Arbiter.scala:26:18, :28:29, Cat.scala:30:58
        automatic logic [6:0] _readys_mask_T_3 =
          _readys_mask_T | {_readys_mask_T[5:0], 1'h0};	// Arbiter.scala:28:29, Bundle_ACancel.scala:55:22, package.scala:244:{43,53}
        automatic logic [6:0] _readys_mask_T_6 =
          _readys_mask_T_3 | {_readys_mask_T_3[4:0], 2'h0};	// Xbar.scala:254:26, package.scala:244:{43,53}
        readys_mask <= _readys_mask_T_6 | {_readys_mask_T_6[2:0], 4'h0};	// Arbiter.scala:23:23, Bundles.scala:257:54, package.scala:244:{43,53}
      end
      if (idle) begin	// Arbiter.scala:88:28
        state_0 <= winnerQual_0;	// Arbiter.scala:98:79, :116:26
        state_1 <= winnerQual_1;	// Arbiter.scala:98:79, :116:26
        state_2 <= winnerQual_2;	// Arbiter.scala:98:79, :116:26
        state_3 <= winnerQual_3;	// Arbiter.scala:98:79, :116:26
        state_4 <= winnerQual_4;	// Arbiter.scala:98:79, :116:26
        state_5 <= winnerQual_5;	// Arbiter.scala:98:79, :116:26
        state_6 <= winnerQual_6;	// Arbiter.scala:98:79, :116:26
      end
      if (latch_1)	// Arbiter.scala:89:24
        beatsLeft_1 <=
          (winnerQual_1_0 & ~(auto_in_0_a_bits_opcode[2])
             ? ~(_beatsAI_decode_T_1[11:3])
             : 9'h0)
          | (winnerQual_1_1 & ~(auto_in_1_a_bits_opcode[2])
               ? ~(_beatsAI_decode_T_5[11:3])
               : 9'h0)
          | (winnerQual_1_2 & ~(auto_in_2_a_bits_opcode[2])
               ? ~(_beatsAI_decode_T_9[11:3])
               : 9'h0)
          | (winnerQual_1_3 & ~(auto_in_3_a_bits_opcode[2])
               ? ~(_beatsAI_decode_T_13[11:3])
               : 9'h0)
          | (winnerQual_1_4 & ~(auto_in_4_a_bits_opcode[2])
               ? ~(_beatsAI_decode_T_17[11:3])
               : 9'h0)
          | (winnerQual_1_5 & ~(auto_in_5_a_bits_opcode[2])
               ? ~(_beatsAI_decode_T_21[11:3])
               : 9'h0)
          | (winnerQual_1_6 & ~(auto_in_6_a_bits_opcode[2])
               ? ~(_beatsAI_decode_T_25[11:3])
               : 9'h0);	// Arbiter.scala:87:30, :98:79, :111:73, :112:44, Edges.scala:91:{28,37}, :220:14, package.scala:234:{46,77,82}
      else	// Arbiter.scala:89:24
        beatsLeft_1 <= beatsLeft_1 - {8'h0, auto_out_1_a_ready & bundleOut_1_out_1_valid};	// Arbiter.scala:87:30, :113:52, :125:29, ReadyValidCancel.scala:50:33, Xbar.scala:254:26
      if (latch_1 & (|readys_filter_lo_1)) begin	// Arbiter.scala:27:{18,27}, :89:24, Cat.scala:30:58
        automatic logic [6:0] _readys_mask_T_11 = readys_readys_1 & readys_filter_lo_1;	// Arbiter.scala:26:18, :28:29, Cat.scala:30:58
        automatic logic [6:0] _readys_mask_T_14 =
          _readys_mask_T_11 | {_readys_mask_T_11[5:0], 1'h0};	// Arbiter.scala:28:29, Bundle_ACancel.scala:55:22, package.scala:244:{43,53}
        automatic logic [6:0] _readys_mask_T_17 =
          _readys_mask_T_14 | {_readys_mask_T_14[4:0], 2'h0};	// Xbar.scala:254:26, package.scala:244:{43,53}
        readys_mask_1 <= _readys_mask_T_17 | {_readys_mask_T_17[2:0], 4'h0};	// Arbiter.scala:23:23, Bundles.scala:257:54, package.scala:244:{43,53}
      end
      if (idle_1) begin	// Arbiter.scala:88:28
        state_1_0 <= winnerQual_1_0;	// Arbiter.scala:98:79, :116:26
        state_1_1 <= winnerQual_1_1;	// Arbiter.scala:98:79, :116:26
        state_1_2 <= winnerQual_1_2;	// Arbiter.scala:98:79, :116:26
        state_1_3 <= winnerQual_1_3;	// Arbiter.scala:98:79, :116:26
        state_1_4 <= winnerQual_1_4;	// Arbiter.scala:98:79, :116:26
        state_1_5 <= winnerQual_1_5;	// Arbiter.scala:98:79, :116:26
        state_1_6 <= winnerQual_1_6;	// Arbiter.scala:98:79, :116:26
      end
      if (latch_2) begin	// Arbiter.scala:89:24
        automatic logic [26:0] _beatsCI_decode_T_25 = 27'hFFF << auto_in_6_c_bits_size;	// package.scala:234:77
        automatic logic [26:0] _beatsCI_decode_T_21 = 27'hFFF << auto_in_5_c_bits_size;	// package.scala:234:77
        automatic logic [26:0] _beatsCI_decode_T_17 = 27'hFFF << auto_in_4_c_bits_size;	// package.scala:234:77
        automatic logic [26:0] _beatsCI_decode_T_13 = 27'hFFF << auto_in_3_c_bits_size;	// package.scala:234:77
        automatic logic [26:0] _beatsCI_decode_T_9 = 27'hFFF << auto_in_2_c_bits_size;	// package.scala:234:77
        automatic logic [26:0] _beatsCI_decode_T_5 = 27'hFFF << auto_in_1_c_bits_size;	// package.scala:234:77
        beatsLeft_2 <=
          (winnerQual_2_0 & auto_in_1_c_bits_opcode[0]
             ? ~(_beatsCI_decode_T_5[11:3])
             : 9'h0)
          | (winnerQual_2_1 & auto_in_2_c_bits_opcode[0]
               ? ~(_beatsCI_decode_T_9[11:3])
               : 9'h0)
          | (winnerQual_2_2 & auto_in_3_c_bits_opcode[0]
               ? ~(_beatsCI_decode_T_13[11:3])
               : 9'h0)
          | (winnerQual_2_3 & auto_in_4_c_bits_opcode[0]
               ? ~(_beatsCI_decode_T_17[11:3])
               : 9'h0)
          | (winnerQual_2_4 & auto_in_5_c_bits_opcode[0]
               ? ~(_beatsCI_decode_T_21[11:3])
               : 9'h0)
          | (winnerQual_2_5 & auto_in_6_c_bits_opcode[0]
               ? ~(_beatsCI_decode_T_25[11:3])
               : 9'h0);	// Arbiter.scala:87:30, :98:79, :111:73, :112:44, Edges.scala:101:36, :220:14, package.scala:234:{46,77,82}
      end
      else	// Arbiter.scala:89:24
        beatsLeft_2 <= beatsLeft_2 - {8'h0, auto_out_1_c_ready & bundleOut_1_out_c_valid};	// Arbiter.scala:87:30, :113:52, :125:29, ReadyValidCancel.scala:50:33, Xbar.scala:254:26
      if (latch_2 & (|readys_filter_lo_2)) begin	// Arbiter.scala:27:{18,27}, :89:24, Cat.scala:30:58
        automatic logic [5:0] _readys_mask_T_22 = readys_readys_2 & readys_filter_lo_2;	// Arbiter.scala:26:18, :28:29, Cat.scala:30:58
        automatic logic [5:0] _readys_mask_T_25 =
          _readys_mask_T_22 | {_readys_mask_T_22[4:0], 1'h0};	// Arbiter.scala:28:29, Bundle_ACancel.scala:55:22, package.scala:244:{43,53}
        automatic logic [5:0] _readys_mask_T_28 =
          _readys_mask_T_25 | {_readys_mask_T_25[3:0], 2'h0};	// Xbar.scala:254:26, package.scala:244:{43,53}
        readys_mask_2 <= _readys_mask_T_28 | {_readys_mask_T_28[1:0], 4'h0};	// Arbiter.scala:23:23, Bundles.scala:257:54, package.scala:244:{43,53}
      end
      if (idle_2) begin	// Arbiter.scala:88:28
        state_2_0 <= winnerQual_2_0;	// Arbiter.scala:98:79, :116:26
        state_2_1 <= winnerQual_2_1;	// Arbiter.scala:98:79, :116:26
        state_2_2 <= winnerQual_2_2;	// Arbiter.scala:98:79, :116:26
        state_2_3 <= winnerQual_2_3;	// Arbiter.scala:98:79, :116:26
        state_2_4 <= winnerQual_2_4;	// Arbiter.scala:98:79, :116:26
        state_2_5 <= winnerQual_2_5;	// Arbiter.scala:98:79, :116:26
      end
      beatsLeft_3 <= beatsLeft_3 & beatsLeft_3 - bundleOut_1_out_e_valid;	// Arbiter.scala:87:30, :113:{23,52}, :125:29
      if (~beatsLeft_3 & (|readys_filter_lo_3)) begin	// Arbiter.scala:27:{18,27}, :87:30, :88:28, Cat.scala:30:58
        automatic logic [5:0] _readys_mask_T_33 = readys_readys_3 & readys_filter_lo_3;	// Arbiter.scala:26:18, :28:29, Cat.scala:30:58
        automatic logic [5:0] _readys_mask_T_36 =
          _readys_mask_T_33 | {_readys_mask_T_33[4:0], 1'h0};	// Arbiter.scala:28:29, Bundle_ACancel.scala:55:22, package.scala:244:{43,53}
        automatic logic [5:0] _readys_mask_T_39 =
          _readys_mask_T_36 | {_readys_mask_T_36[3:0], 2'h0};	// Xbar.scala:254:26, package.scala:244:{43,53}
        readys_mask_3 <= _readys_mask_T_39 | {_readys_mask_T_39[1:0], 4'h0};	// Arbiter.scala:23:23, Bundles.scala:257:54, package.scala:244:{43,53}
      end
      if (beatsLeft_3) begin	// Arbiter.scala:87:30
      end
      else begin	// Arbiter.scala:87:30
        state_3_0 <= readys_readys_3[0] & auto_in_1_e_valid;	// Arbiter.scala:26:18, :95:86, :98:79, :116:26
        state_3_1 <= readys_readys_3[1] & auto_in_2_e_valid;	// Arbiter.scala:26:18, :95:86, :98:79, :116:26
        state_3_2 <= readys_readys_3[2] & auto_in_3_e_valid;	// Arbiter.scala:26:18, :95:86, :98:79, :116:26
        state_3_3 <= readys_readys_3[3] & auto_in_4_e_valid;	// Arbiter.scala:26:18, :95:86, :98:79, :116:26
        state_3_4 <= readys_readys_3[4] & auto_in_5_e_valid;	// Arbiter.scala:26:18, :95:86, :98:79, :116:26
        state_3_5 <= readys_readys_3[5] & auto_in_6_e_valid;	// Arbiter.scala:26:18, :95:86, :98:79, :116:26
      end
      if (latch_4) begin	// Arbiter.scala:89:24
        automatic logic [8:0] maskedBeats_0_4;	// Arbiter.scala:111:73, Edges.scala:220:14
        maskedBeats_0_4 =
          winnerQual_4_0 & auto_out_0_d_bits_opcode[0]
            ? ~(_beatsDO_decode_T_1[11:3])
            : 9'h0;	// Arbiter.scala:98:79, :111:73, Edges.scala:105:36, :220:14, package.scala:234:{46,77,82}
        beatsLeft_4 <=
          {maskedBeats_0_4[8:3],
           maskedBeats_0_4[2:0]
             | (winnerQual_4_1 & auto_out_1_d_bits_opcode[0]
                  ? ~(_beatsDO_decode_T_5[5:3])
                  : 3'h0)};	// Arbiter.scala:87:30, :98:79, :111:73, :112:44, Edges.scala:105:36, :220:14, package.scala:234:{46,77,82}
      end
      else	// Arbiter.scala:89:24
        beatsLeft_4 <= beatsLeft_4 - {8'h0, auto_in_0_d_ready & out_27_valid};	// Arbiter.scala:87:30, :113:52, :125:29, ReadyValidCancel.scala:50:33, Xbar.scala:254:26
      if (latch_4 & (|readys_filter_lo_4)) begin	// Arbiter.scala:27:{18,27}, :89:24, Cat.scala:30:58
        automatic logic [1:0] _readys_mask_T_44 = readys_readys_4 & readys_filter_lo_4;	// Arbiter.scala:26:18, :28:29, Cat.scala:30:58
        readys_mask_4 <= _readys_mask_T_44 | {_readys_mask_T_44[0], 1'h0};	// Arbiter.scala:23:23, :28:29, Bundle_ACancel.scala:55:22, package.scala:244:{43,53}
      end
      if (idle_4) begin	// Arbiter.scala:88:28
        state_4_0 <= winnerQual_4_0;	// Arbiter.scala:98:79, :116:26
        state_4_1 <= winnerQual_4_1;	// Arbiter.scala:98:79, :116:26
      end
      if (latch_5) begin	// Arbiter.scala:89:24
        automatic logic [8:0] maskedBeats_0_5;	// Arbiter.scala:111:73, Edges.scala:220:14
        maskedBeats_0_5 =
          winnerQual_5_0 & auto_out_0_d_bits_opcode[0]
            ? ~(_beatsDO_decode_T_1[11:3])
            : 9'h0;	// Arbiter.scala:98:79, :111:73, Edges.scala:105:36, :220:14, package.scala:234:{46,77,82}
        beatsLeft_5 <=
          {maskedBeats_0_5[8:3],
           maskedBeats_0_5[2:0]
             | (winnerQual_5_1 & auto_out_1_d_bits_opcode[0]
                  ? ~(_beatsDO_decode_T_5[5:3])
                  : 3'h0)};	// Arbiter.scala:87:30, :98:79, :111:73, :112:44, Edges.scala:105:36, :220:14, package.scala:234:{46,77,82}
      end
      else	// Arbiter.scala:89:24
        beatsLeft_5 <= beatsLeft_5 - {8'h0, auto_in_1_d_ready & out_32_valid};	// Arbiter.scala:87:30, :113:52, :125:29, ReadyValidCancel.scala:50:33, Xbar.scala:254:26
      if (latch_5 & (|readys_filter_lo_5)) begin	// Arbiter.scala:27:{18,27}, :89:24, Cat.scala:30:58
        automatic logic [1:0] _readys_mask_T_49 = readys_readys_5 & readys_filter_lo_5;	// Arbiter.scala:26:18, :28:29, Cat.scala:30:58
        readys_mask_5 <= _readys_mask_T_49 | {_readys_mask_T_49[0], 1'h0};	// Arbiter.scala:23:23, :28:29, Bundle_ACancel.scala:55:22, package.scala:244:{43,53}
      end
      if (idle_5) begin	// Arbiter.scala:88:28
        state_5_0 <= winnerQual_5_0;	// Arbiter.scala:98:79, :116:26
        state_5_1 <= winnerQual_5_1;	// Arbiter.scala:98:79, :116:26
      end
      if (latch_6) begin	// Arbiter.scala:89:24
        automatic logic [8:0] maskedBeats_0_6;	// Arbiter.scala:111:73, Edges.scala:220:14
        maskedBeats_0_6 =
          winnerQual_6_0 & auto_out_0_d_bits_opcode[0]
            ? ~(_beatsDO_decode_T_1[11:3])
            : 9'h0;	// Arbiter.scala:98:79, :111:73, Edges.scala:105:36, :220:14, package.scala:234:{46,77,82}
        beatsLeft_6 <=
          {maskedBeats_0_6[8:3],
           maskedBeats_0_6[2:0]
             | (winnerQual_6_1 & auto_out_1_d_bits_opcode[0]
                  ? ~(_beatsDO_decode_T_5[5:3])
                  : 3'h0)};	// Arbiter.scala:87:30, :98:79, :111:73, :112:44, Edges.scala:105:36, :220:14, package.scala:234:{46,77,82}
      end
      else	// Arbiter.scala:89:24
        beatsLeft_6 <= beatsLeft_6 - {8'h0, auto_in_2_d_ready & out_37_valid};	// Arbiter.scala:87:30, :113:52, :125:29, ReadyValidCancel.scala:50:33, Xbar.scala:254:26
      if (latch_6 & (|readys_filter_lo_6)) begin	// Arbiter.scala:27:{18,27}, :89:24, Cat.scala:30:58
        automatic logic [1:0] _readys_mask_T_54 = readys_readys_6 & readys_filter_lo_6;	// Arbiter.scala:26:18, :28:29, Cat.scala:30:58
        readys_mask_6 <= _readys_mask_T_54 | {_readys_mask_T_54[0], 1'h0};	// Arbiter.scala:23:23, :28:29, Bundle_ACancel.scala:55:22, package.scala:244:{43,53}
      end
      if (idle_6) begin	// Arbiter.scala:88:28
        state_6_0 <= winnerQual_6_0;	// Arbiter.scala:98:79, :116:26
        state_6_1 <= winnerQual_6_1;	// Arbiter.scala:98:79, :116:26
      end
      if (latch_7) begin	// Arbiter.scala:89:24
        automatic logic [8:0] maskedBeats_0_7;	// Arbiter.scala:111:73, Edges.scala:220:14
        maskedBeats_0_7 =
          winnerQual_7_0 & auto_out_0_d_bits_opcode[0]
            ? ~(_beatsDO_decode_T_1[11:3])
            : 9'h0;	// Arbiter.scala:98:79, :111:73, Edges.scala:105:36, :220:14, package.scala:234:{46,77,82}
        beatsLeft_7 <=
          {maskedBeats_0_7[8:3],
           maskedBeats_0_7[2:0]
             | (winnerQual_7_1 & auto_out_1_d_bits_opcode[0]
                  ? ~(_beatsDO_decode_T_5[5:3])
                  : 3'h0)};	// Arbiter.scala:87:30, :98:79, :111:73, :112:44, Edges.scala:105:36, :220:14, package.scala:234:{46,77,82}
      end
      else	// Arbiter.scala:89:24
        beatsLeft_7 <= beatsLeft_7 - {8'h0, auto_in_3_d_ready & out_42_valid};	// Arbiter.scala:87:30, :113:52, :125:29, ReadyValidCancel.scala:50:33, Xbar.scala:254:26
      if (latch_7 & (|readys_filter_lo_7)) begin	// Arbiter.scala:27:{18,27}, :89:24, Cat.scala:30:58
        automatic logic [1:0] _readys_mask_T_59 = readys_readys_7 & readys_filter_lo_7;	// Arbiter.scala:26:18, :28:29, Cat.scala:30:58
        readys_mask_7 <= _readys_mask_T_59 | {_readys_mask_T_59[0], 1'h0};	// Arbiter.scala:23:23, :28:29, Bundle_ACancel.scala:55:22, package.scala:244:{43,53}
      end
      if (idle_7) begin	// Arbiter.scala:88:28
        state_7_0 <= winnerQual_7_0;	// Arbiter.scala:98:79, :116:26
        state_7_1 <= winnerQual_7_1;	// Arbiter.scala:98:79, :116:26
      end
      if (latch_8) begin	// Arbiter.scala:89:24
        automatic logic [8:0] maskedBeats_0_8;	// Arbiter.scala:111:73, Edges.scala:220:14
        maskedBeats_0_8 =
          winnerQual_8_0 & auto_out_0_d_bits_opcode[0]
            ? ~(_beatsDO_decode_T_1[11:3])
            : 9'h0;	// Arbiter.scala:98:79, :111:73, Edges.scala:105:36, :220:14, package.scala:234:{46,77,82}
        beatsLeft_8 <=
          {maskedBeats_0_8[8:3],
           maskedBeats_0_8[2:0]
             | (winnerQual_8_1 & auto_out_1_d_bits_opcode[0]
                  ? ~(_beatsDO_decode_T_5[5:3])
                  : 3'h0)};	// Arbiter.scala:87:30, :98:79, :111:73, :112:44, Edges.scala:105:36, :220:14, package.scala:234:{46,77,82}
      end
      else	// Arbiter.scala:89:24
        beatsLeft_8 <= beatsLeft_8 - {8'h0, auto_in_4_d_ready & out_47_valid};	// Arbiter.scala:87:30, :113:52, :125:29, ReadyValidCancel.scala:50:33, Xbar.scala:254:26
      if (latch_8 & (|readys_filter_lo_8)) begin	// Arbiter.scala:27:{18,27}, :89:24, Cat.scala:30:58
        automatic logic [1:0] _readys_mask_T_64 = readys_readys_8 & readys_filter_lo_8;	// Arbiter.scala:26:18, :28:29, Cat.scala:30:58
        readys_mask_8 <= _readys_mask_T_64 | {_readys_mask_T_64[0], 1'h0};	// Arbiter.scala:23:23, :28:29, Bundle_ACancel.scala:55:22, package.scala:244:{43,53}
      end
      if (idle_8) begin	// Arbiter.scala:88:28
        state_8_0 <= winnerQual_8_0;	// Arbiter.scala:98:79, :116:26
        state_8_1 <= winnerQual_8_1;	// Arbiter.scala:98:79, :116:26
      end
      if (latch_9) begin	// Arbiter.scala:89:24
        automatic logic [8:0] maskedBeats_0_9;	// Arbiter.scala:111:73, Edges.scala:220:14
        maskedBeats_0_9 =
          winnerQual_9_0 & auto_out_0_d_bits_opcode[0]
            ? ~(_beatsDO_decode_T_1[11:3])
            : 9'h0;	// Arbiter.scala:98:79, :111:73, Edges.scala:105:36, :220:14, package.scala:234:{46,77,82}
        beatsLeft_9 <=
          {maskedBeats_0_9[8:3],
           maskedBeats_0_9[2:0]
             | (winnerQual_9_1 & auto_out_1_d_bits_opcode[0]
                  ? ~(_beatsDO_decode_T_5[5:3])
                  : 3'h0)};	// Arbiter.scala:87:30, :98:79, :111:73, :112:44, Edges.scala:105:36, :220:14, package.scala:234:{46,77,82}
      end
      else	// Arbiter.scala:89:24
        beatsLeft_9 <= beatsLeft_9 - {8'h0, auto_in_5_d_ready & out_52_valid};	// Arbiter.scala:87:30, :113:52, :125:29, ReadyValidCancel.scala:50:33, Xbar.scala:254:26
      if (latch_9 & (|readys_filter_lo_9)) begin	// Arbiter.scala:27:{18,27}, :89:24, Cat.scala:30:58
        automatic logic [1:0] _readys_mask_T_69 = readys_readys_9 & readys_filter_lo_9;	// Arbiter.scala:26:18, :28:29, Cat.scala:30:58
        readys_mask_9 <= _readys_mask_T_69 | {_readys_mask_T_69[0], 1'h0};	// Arbiter.scala:23:23, :28:29, Bundle_ACancel.scala:55:22, package.scala:244:{43,53}
      end
      if (idle_9) begin	// Arbiter.scala:88:28
        state_9_0 <= winnerQual_9_0;	// Arbiter.scala:98:79, :116:26
        state_9_1 <= winnerQual_9_1;	// Arbiter.scala:98:79, :116:26
      end
      if (latch_10) begin	// Arbiter.scala:89:24
        automatic logic [8:0] maskedBeats_0_10;	// Arbiter.scala:111:73, Edges.scala:220:14
        maskedBeats_0_10 =
          winnerQual_10_0 & auto_out_0_d_bits_opcode[0]
            ? ~(_beatsDO_decode_T_1[11:3])
            : 9'h0;	// Arbiter.scala:98:79, :111:73, Edges.scala:105:36, :220:14, package.scala:234:{46,77,82}
        beatsLeft_10 <=
          {maskedBeats_0_10[8:3],
           maskedBeats_0_10[2:0]
             | (winnerQual_10_1 & auto_out_1_d_bits_opcode[0]
                  ? ~(_beatsDO_decode_T_5[5:3])
                  : 3'h0)};	// Arbiter.scala:87:30, :98:79, :111:73, :112:44, Edges.scala:105:36, :220:14, package.scala:234:{46,77,82}
      end
      else	// Arbiter.scala:89:24
        beatsLeft_10 <= beatsLeft_10 - {8'h0, auto_in_6_d_ready & out_57_valid};	// Arbiter.scala:87:30, :113:52, :125:29, ReadyValidCancel.scala:50:33, Xbar.scala:254:26
      if (latch_10 & (|readys_filter_lo_10)) begin	// Arbiter.scala:27:{18,27}, :89:24, Cat.scala:30:58
        automatic logic [1:0] _readys_mask_T_74 = readys_readys_10 & readys_filter_lo_10;	// Arbiter.scala:26:18, :28:29, Cat.scala:30:58
        readys_mask_10 <= _readys_mask_T_74 | {_readys_mask_T_74[0], 1'h0};	// Arbiter.scala:23:23, :28:29, Bundle_ACancel.scala:55:22, package.scala:244:{43,53}
      end
      if (idle_10) begin	// Arbiter.scala:88:28
        state_10_0 <= winnerQual_10_0;	// Arbiter.scala:98:79, :116:26
        state_10_1 <= winnerQual_10_1;	// Arbiter.scala:98:79, :116:26
      end
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:5];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [2:0] i = 3'h0; i < 3'h6; i += 3'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        beatsLeft = _RANDOM[3'h0][8:0];	// Arbiter.scala:87:30
        readys_mask = _RANDOM[3'h0][15:9];	// Arbiter.scala:23:23, :87:30
        state_0 = _RANDOM[3'h0][16];	// Arbiter.scala:87:30, :116:26
        state_1 = _RANDOM[3'h0][17];	// Arbiter.scala:87:30, :116:26
        state_2 = _RANDOM[3'h0][18];	// Arbiter.scala:87:30, :116:26
        state_3 = _RANDOM[3'h0][19];	// Arbiter.scala:87:30, :116:26
        state_4 = _RANDOM[3'h0][20];	// Arbiter.scala:87:30, :116:26
        state_5 = _RANDOM[3'h0][21];	// Arbiter.scala:87:30, :116:26
        state_6 = _RANDOM[3'h0][22];	// Arbiter.scala:87:30, :116:26
        beatsLeft_1 = _RANDOM[3'h0][31:23];	// Arbiter.scala:87:30
        readys_mask_1 = _RANDOM[3'h1][6:0];	// Arbiter.scala:23:23
        state_1_0 = _RANDOM[3'h1][7];	// Arbiter.scala:23:23, :116:26
        state_1_1 = _RANDOM[3'h1][8];	// Arbiter.scala:23:23, :116:26
        state_1_2 = _RANDOM[3'h1][9];	// Arbiter.scala:23:23, :116:26
        state_1_3 = _RANDOM[3'h1][10];	// Arbiter.scala:23:23, :116:26
        state_1_4 = _RANDOM[3'h1][11];	// Arbiter.scala:23:23, :116:26
        state_1_5 = _RANDOM[3'h1][12];	// Arbiter.scala:23:23, :116:26
        state_1_6 = _RANDOM[3'h1][13];	// Arbiter.scala:23:23, :116:26
        beatsLeft_2 = _RANDOM[3'h1][22:14];	// Arbiter.scala:23:23, :87:30
        readys_mask_2 = _RANDOM[3'h1][28:23];	// Arbiter.scala:23:23
        state_2_0 = _RANDOM[3'h1][29];	// Arbiter.scala:23:23, :116:26
        state_2_1 = _RANDOM[3'h1][30];	// Arbiter.scala:23:23, :116:26
        state_2_2 = _RANDOM[3'h1][31];	// Arbiter.scala:23:23, :116:26
        state_2_3 = _RANDOM[3'h2][0];	// Arbiter.scala:116:26
        state_2_4 = _RANDOM[3'h2][1];	// Arbiter.scala:116:26
        state_2_5 = _RANDOM[3'h2][2];	// Arbiter.scala:116:26
        beatsLeft_3 = _RANDOM[3'h2][3];	// Arbiter.scala:87:30, :116:26
        readys_mask_3 = _RANDOM[3'h2][9:4];	// Arbiter.scala:23:23, :116:26
        state_3_0 = _RANDOM[3'h2][10];	// Arbiter.scala:116:26
        state_3_1 = _RANDOM[3'h2][11];	// Arbiter.scala:116:26
        state_3_2 = _RANDOM[3'h2][12];	// Arbiter.scala:116:26
        state_3_3 = _RANDOM[3'h2][13];	// Arbiter.scala:116:26
        state_3_4 = _RANDOM[3'h2][14];	// Arbiter.scala:116:26
        state_3_5 = _RANDOM[3'h2][15];	// Arbiter.scala:116:26
        beatsLeft_4 = _RANDOM[3'h2][24:16];	// Arbiter.scala:87:30, :116:26
        readys_mask_4 = _RANDOM[3'h2][26:25];	// Arbiter.scala:23:23, :116:26
        state_4_0 = _RANDOM[3'h2][27];	// Arbiter.scala:116:26
        state_4_1 = _RANDOM[3'h2][28];	// Arbiter.scala:116:26
        beatsLeft_5 = {_RANDOM[3'h2][31:29], _RANDOM[3'h3][5:0]};	// Arbiter.scala:87:30, :116:26
        readys_mask_5 = _RANDOM[3'h3][7:6];	// Arbiter.scala:23:23, :87:30
        state_5_0 = _RANDOM[3'h3][8];	// Arbiter.scala:87:30, :116:26
        state_5_1 = _RANDOM[3'h3][9];	// Arbiter.scala:87:30, :116:26
        beatsLeft_6 = _RANDOM[3'h3][18:10];	// Arbiter.scala:87:30
        readys_mask_6 = _RANDOM[3'h3][20:19];	// Arbiter.scala:23:23, :87:30
        state_6_0 = _RANDOM[3'h3][21];	// Arbiter.scala:87:30, :116:26
        state_6_1 = _RANDOM[3'h3][22];	// Arbiter.scala:87:30, :116:26
        beatsLeft_7 = _RANDOM[3'h3][31:23];	// Arbiter.scala:87:30
        readys_mask_7 = _RANDOM[3'h4][1:0];	// Arbiter.scala:23:23
        state_7_0 = _RANDOM[3'h4][2];	// Arbiter.scala:23:23, :116:26
        state_7_1 = _RANDOM[3'h4][3];	// Arbiter.scala:23:23, :116:26
        beatsLeft_8 = _RANDOM[3'h4][12:4];	// Arbiter.scala:23:23, :87:30
        readys_mask_8 = _RANDOM[3'h4][14:13];	// Arbiter.scala:23:23
        state_8_0 = _RANDOM[3'h4][15];	// Arbiter.scala:23:23, :116:26
        state_8_1 = _RANDOM[3'h4][16];	// Arbiter.scala:23:23, :116:26
        beatsLeft_9 = _RANDOM[3'h4][25:17];	// Arbiter.scala:23:23, :87:30
        readys_mask_9 = _RANDOM[3'h4][27:26];	// Arbiter.scala:23:23
        state_9_0 = _RANDOM[3'h4][28];	// Arbiter.scala:23:23, :116:26
        state_9_1 = _RANDOM[3'h4][29];	// Arbiter.scala:23:23, :116:26
        beatsLeft_10 = {_RANDOM[3'h4][31:30], _RANDOM[3'h5][6:0]};	// Arbiter.scala:23:23, :87:30
        readys_mask_10 = _RANDOM[3'h5][8:7];	// Arbiter.scala:23:23, :87:30
        state_10_0 = _RANDOM[3'h5][9];	// Arbiter.scala:87:30, :116:26
        state_10_1 = _RANDOM[3'h5][10];	// Arbiter.scala:87:30, :116:26
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  TLMonitor monitor (	// Nodes.scala:24:25
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (_portsAOI_in_0_a_ready_WIRE),	// Mux.scala:27:72
    .io_in_a_valid        (auto_in_0_a_valid),
    .io_in_a_bits_opcode  (auto_in_0_a_bits_opcode),
    .io_in_a_bits_param   (auto_in_0_a_bits_param),
    .io_in_a_bits_size    (auto_in_0_a_bits_size),
    .io_in_a_bits_source  (auto_in_0_a_bits_source),
    .io_in_a_bits_address (auto_in_0_a_bits_address),
    .io_in_a_bits_mask    (auto_in_0_a_bits_mask),
    .io_in_a_bits_corrupt (auto_in_0_a_bits_corrupt),
    .io_in_d_ready        (auto_in_0_d_ready),
    .io_in_d_valid        (out_27_valid),	// Arbiter.scala:125:29
    .io_in_d_bits_opcode  (out_27_bits_opcode),	// Mux.scala:27:72
    .io_in_d_bits_param   (out_27_bits_param),	// Mux.scala:27:72
    .io_in_d_bits_size    (out_27_bits_size),	// Mux.scala:27:72
    .io_in_d_bits_sink    (out_27_bits_sink),	// Mux.scala:27:72
    .io_in_d_bits_denied  (out_27_bits_denied),	// Mux.scala:27:72
    .io_in_d_bits_corrupt (out_27_bits_corrupt)	// Mux.scala:27:72
  );
  TLMonitor_1 monitor_1 (	// Nodes.scala:24:25
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (_portsAOI_in_1_a_ready_WIRE),	// Mux.scala:27:72
    .io_in_a_valid        (auto_in_1_a_valid),
    .io_in_a_bits_opcode  (auto_in_1_a_bits_opcode),
    .io_in_a_bits_param   (auto_in_1_a_bits_param),
    .io_in_a_bits_size    (auto_in_1_a_bits_size),
    .io_in_a_bits_source  (auto_in_1_a_bits_source),
    .io_in_a_bits_address (auto_in_1_a_bits_address),
    .io_in_a_bits_mask    (auto_in_1_a_bits_mask),
    .io_in_a_bits_corrupt (auto_in_1_a_bits_corrupt),
    .io_in_b_ready        (auto_in_1_b_ready),
    .io_in_b_valid        (out_29_valid),	// Xbar.scala:179:40
    .io_in_b_bits_param   (auto_out_1_b_bits_param),
    .io_in_b_bits_source  (auto_out_1_b_bits_source[1:0]),	// Xbar.scala:228:69
    .io_in_b_bits_address (auto_out_1_b_bits_address),
    .io_in_c_ready        (out_10_ready),	// Arbiter.scala:123:31
    .io_in_c_valid        (auto_in_1_c_valid),
    .io_in_c_bits_opcode  (auto_in_1_c_bits_opcode),
    .io_in_c_bits_param   (auto_in_1_c_bits_param),
    .io_in_c_bits_size    (auto_in_1_c_bits_size),
    .io_in_c_bits_source  (auto_in_1_c_bits_source),
    .io_in_c_bits_address (auto_in_1_c_bits_address),
    .io_in_c_bits_corrupt (auto_in_1_c_bits_corrupt),
    .io_in_d_ready        (auto_in_1_d_ready),
    .io_in_d_valid        (out_32_valid),	// Arbiter.scala:125:29
    .io_in_d_bits_opcode  (out_32_bits_opcode),	// Mux.scala:27:72
    .io_in_d_bits_param   (out_32_bits_param),	// Mux.scala:27:72
    .io_in_d_bits_size    (out_32_bits_size),	// Mux.scala:27:72
    .io_in_d_bits_source  (out_32_bits_source),	// Mux.scala:27:72
    .io_in_d_bits_sink    (out_32_bits_sink),	// Mux.scala:27:72
    .io_in_d_bits_denied  (out_32_bits_denied),	// Mux.scala:27:72
    .io_in_d_bits_corrupt (out_32_bits_corrupt),	// Mux.scala:27:72
    .io_in_e_ready        (out_17_ready),	// Arbiter.scala:121:24
    .io_in_e_valid        (auto_in_1_e_valid),
    .io_in_e_bits_sink    (auto_in_1_e_bits_sink)
  );
  TLMonitor_1 monitor_2 (	// Nodes.scala:24:25
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (_portsAOI_in_2_a_ready_WIRE),	// Mux.scala:27:72
    .io_in_a_valid        (auto_in_2_a_valid),
    .io_in_a_bits_opcode  (auto_in_2_a_bits_opcode),
    .io_in_a_bits_param   (auto_in_2_a_bits_param),
    .io_in_a_bits_size    (auto_in_2_a_bits_size),
    .io_in_a_bits_source  (auto_in_2_a_bits_source),
    .io_in_a_bits_address (auto_in_2_a_bits_address),
    .io_in_a_bits_mask    (auto_in_2_a_bits_mask),
    .io_in_a_bits_corrupt (auto_in_2_a_bits_corrupt),
    .io_in_b_ready        (auto_in_2_b_ready),
    .io_in_b_valid        (out_34_valid),	// Xbar.scala:179:40
    .io_in_b_bits_param   (auto_out_1_b_bits_param),
    .io_in_b_bits_source  (auto_out_1_b_bits_source[1:0]),	// Xbar.scala:228:69
    .io_in_b_bits_address (auto_out_1_b_bits_address),
    .io_in_c_ready        (out_11_ready),	// Arbiter.scala:123:31
    .io_in_c_valid        (auto_in_2_c_valid),
    .io_in_c_bits_opcode  (auto_in_2_c_bits_opcode),
    .io_in_c_bits_param   (auto_in_2_c_bits_param),
    .io_in_c_bits_size    (auto_in_2_c_bits_size),
    .io_in_c_bits_source  (auto_in_2_c_bits_source),
    .io_in_c_bits_address (auto_in_2_c_bits_address),
    .io_in_c_bits_corrupt (auto_in_2_c_bits_corrupt),
    .io_in_d_ready        (auto_in_2_d_ready),
    .io_in_d_valid        (out_37_valid),	// Arbiter.scala:125:29
    .io_in_d_bits_opcode  (out_37_bits_opcode),	// Mux.scala:27:72
    .io_in_d_bits_param   (out_37_bits_param),	// Mux.scala:27:72
    .io_in_d_bits_size    (out_37_bits_size),	// Mux.scala:27:72
    .io_in_d_bits_source  (out_37_bits_source),	// Mux.scala:27:72
    .io_in_d_bits_sink    (out_37_bits_sink),	// Mux.scala:27:72
    .io_in_d_bits_denied  (out_37_bits_denied),	// Mux.scala:27:72
    .io_in_d_bits_corrupt (out_37_bits_corrupt),	// Mux.scala:27:72
    .io_in_e_ready        (out_18_ready),	// Arbiter.scala:121:24
    .io_in_e_valid        (auto_in_2_e_valid),
    .io_in_e_bits_sink    (auto_in_2_e_bits_sink)
  );
  TLMonitor_1 monitor_3 (	// Nodes.scala:24:25
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (_portsAOI_in_3_a_ready_WIRE),	// Mux.scala:27:72
    .io_in_a_valid        (auto_in_3_a_valid),
    .io_in_a_bits_opcode  (auto_in_3_a_bits_opcode),
    .io_in_a_bits_param   (auto_in_3_a_bits_param),
    .io_in_a_bits_size    (auto_in_3_a_bits_size),
    .io_in_a_bits_source  (auto_in_3_a_bits_source),
    .io_in_a_bits_address (auto_in_3_a_bits_address),
    .io_in_a_bits_mask    (auto_in_3_a_bits_mask),
    .io_in_a_bits_corrupt (auto_in_3_a_bits_corrupt),
    .io_in_b_ready        (auto_in_3_b_ready),
    .io_in_b_valid        (out_39_valid),	// Xbar.scala:179:40
    .io_in_b_bits_param   (auto_out_1_b_bits_param),
    .io_in_b_bits_source  (auto_out_1_b_bits_source[1:0]),	// Xbar.scala:228:69
    .io_in_b_bits_address (auto_out_1_b_bits_address),
    .io_in_c_ready        (out_12_ready),	// Arbiter.scala:123:31
    .io_in_c_valid        (auto_in_3_c_valid),
    .io_in_c_bits_opcode  (auto_in_3_c_bits_opcode),
    .io_in_c_bits_param   (auto_in_3_c_bits_param),
    .io_in_c_bits_size    (auto_in_3_c_bits_size),
    .io_in_c_bits_source  (auto_in_3_c_bits_source),
    .io_in_c_bits_address (auto_in_3_c_bits_address),
    .io_in_c_bits_corrupt (auto_in_3_c_bits_corrupt),
    .io_in_d_ready        (auto_in_3_d_ready),
    .io_in_d_valid        (out_42_valid),	// Arbiter.scala:125:29
    .io_in_d_bits_opcode  (out_42_bits_opcode),	// Mux.scala:27:72
    .io_in_d_bits_param   (out_42_bits_param),	// Mux.scala:27:72
    .io_in_d_bits_size    (out_42_bits_size),	// Mux.scala:27:72
    .io_in_d_bits_source  (out_42_bits_source),	// Mux.scala:27:72
    .io_in_d_bits_sink    (out_42_bits_sink),	// Mux.scala:27:72
    .io_in_d_bits_denied  (out_42_bits_denied),	// Mux.scala:27:72
    .io_in_d_bits_corrupt (out_42_bits_corrupt),	// Mux.scala:27:72
    .io_in_e_ready        (out_19_ready),	// Arbiter.scala:121:24
    .io_in_e_valid        (auto_in_3_e_valid),
    .io_in_e_bits_sink    (auto_in_3_e_bits_sink)
  );
  TLMonitor_4 monitor_4 (	// Nodes.scala:24:25
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (_portsAOI_in_4_a_ready_WIRE),	// Mux.scala:27:72
    .io_in_a_valid        (auto_in_4_a_valid),
    .io_in_a_bits_opcode  (auto_in_4_a_bits_opcode),
    .io_in_a_bits_param   (auto_in_4_a_bits_param),
    .io_in_a_bits_size    (auto_in_4_a_bits_size),
    .io_in_a_bits_source  (auto_in_4_a_bits_source),
    .io_in_a_bits_address (auto_in_4_a_bits_address),
    .io_in_a_bits_mask    (auto_in_4_a_bits_mask),
    .io_in_a_bits_corrupt (auto_in_4_a_bits_corrupt),
    .io_in_b_ready        (auto_in_4_b_ready),
    .io_in_b_valid        (out_44_valid),	// Xbar.scala:179:40
    .io_in_b_bits_param   (auto_out_1_b_bits_param),
    .io_in_b_bits_source  (auto_out_1_b_bits_source[4:0]),	// Xbar.scala:228:69
    .io_in_b_bits_address (auto_out_1_b_bits_address),
    .io_in_c_ready        (out_13_ready),	// Arbiter.scala:123:31
    .io_in_c_valid        (auto_in_4_c_valid),
    .io_in_c_bits_opcode  (auto_in_4_c_bits_opcode),
    .io_in_c_bits_param   (auto_in_4_c_bits_param),
    .io_in_c_bits_size    (auto_in_4_c_bits_size),
    .io_in_c_bits_source  (auto_in_4_c_bits_source),
    .io_in_c_bits_address (auto_in_4_c_bits_address),
    .io_in_c_bits_corrupt (auto_in_4_c_bits_corrupt),
    .io_in_d_ready        (auto_in_4_d_ready),
    .io_in_d_valid        (out_47_valid),	// Arbiter.scala:125:29
    .io_in_d_bits_opcode  (out_47_bits_opcode),	// Mux.scala:27:72
    .io_in_d_bits_param   (out_47_bits_param),	// Mux.scala:27:72
    .io_in_d_bits_size    (out_47_bits_size),	// Mux.scala:27:72
    .io_in_d_bits_source  (out_47_bits_source),	// Mux.scala:27:72
    .io_in_d_bits_sink    (out_47_bits_sink),	// Mux.scala:27:72
    .io_in_d_bits_denied  (out_47_bits_denied),	// Mux.scala:27:72
    .io_in_d_bits_corrupt (out_47_bits_corrupt),	// Mux.scala:27:72
    .io_in_e_ready        (out_20_ready),	// Arbiter.scala:121:24
    .io_in_e_valid        (auto_in_4_e_valid),
    .io_in_e_bits_sink    (auto_in_4_e_bits_sink)
  );
  TLMonitor_5 monitor_5 (	// Nodes.scala:24:25
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (_portsAOI_in_5_a_ready_WIRE),	// Mux.scala:27:72
    .io_in_a_valid        (auto_in_5_a_valid),
    .io_in_a_bits_opcode  (auto_in_5_a_bits_opcode),
    .io_in_a_bits_param   (auto_in_5_a_bits_param),
    .io_in_a_bits_size    (auto_in_5_a_bits_size),
    .io_in_a_bits_source  (auto_in_5_a_bits_source),
    .io_in_a_bits_address (auto_in_5_a_bits_address),
    .io_in_a_bits_mask    (auto_in_5_a_bits_mask),
    .io_in_a_bits_corrupt (auto_in_5_a_bits_corrupt),
    .io_in_b_ready        (auto_in_5_b_ready),
    .io_in_b_valid        (out_49_valid),	// Xbar.scala:179:40
    .io_in_b_bits_param   (auto_out_1_b_bits_param),
    .io_in_b_bits_source  (auto_out_1_b_bits_source[3:0]),	// Xbar.scala:228:69
    .io_in_b_bits_address (auto_out_1_b_bits_address),
    .io_in_c_ready        (out_14_ready),	// Arbiter.scala:123:31
    .io_in_c_valid        (auto_in_5_c_valid),
    .io_in_c_bits_opcode  (auto_in_5_c_bits_opcode),
    .io_in_c_bits_param   (auto_in_5_c_bits_param),
    .io_in_c_bits_size    (auto_in_5_c_bits_size),
    .io_in_c_bits_source  (auto_in_5_c_bits_source),
    .io_in_c_bits_address (auto_in_5_c_bits_address),
    .io_in_c_bits_corrupt (auto_in_5_c_bits_corrupt),
    .io_in_d_ready        (auto_in_5_d_ready),
    .io_in_d_valid        (out_52_valid),	// Arbiter.scala:125:29
    .io_in_d_bits_opcode  (out_52_bits_opcode),	// Mux.scala:27:72
    .io_in_d_bits_param   (out_52_bits_param),	// Mux.scala:27:72
    .io_in_d_bits_size    (out_52_bits_size),	// Mux.scala:27:72
    .io_in_d_bits_source  (out_52_bits_source),	// Mux.scala:27:72
    .io_in_d_bits_sink    (out_52_bits_sink),	// Mux.scala:27:72
    .io_in_d_bits_denied  (out_52_bits_denied),	// Mux.scala:27:72
    .io_in_d_bits_corrupt (out_52_bits_corrupt),	// Mux.scala:27:72
    .io_in_e_ready        (out_21_ready),	// Arbiter.scala:121:24
    .io_in_e_valid        (auto_in_5_e_valid),
    .io_in_e_bits_sink    (auto_in_5_e_bits_sink)
  );
  TLMonitor_6 monitor_6 (	// Nodes.scala:24:25
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (_portsAOI_in_6_a_ready_WIRE),	// Mux.scala:27:72
    .io_in_a_valid        (auto_in_6_a_valid),
    .io_in_a_bits_opcode  (auto_in_6_a_bits_opcode),
    .io_in_a_bits_param   (auto_in_6_a_bits_param),
    .io_in_a_bits_size    (auto_in_6_a_bits_size),
    .io_in_a_bits_source  (auto_in_6_a_bits_source),
    .io_in_a_bits_address (auto_in_6_a_bits_address),
    .io_in_a_bits_mask    (auto_in_6_a_bits_mask),
    .io_in_a_bits_corrupt (auto_in_6_a_bits_corrupt),
    .io_in_b_ready        (auto_in_6_b_ready),
    .io_in_b_valid        (out_54_valid),	// Xbar.scala:179:40
    .io_in_b_bits_param   (auto_out_1_b_bits_param),
    .io_in_b_bits_source  (auto_out_1_b_bits_source[2:0]),	// Xbar.scala:228:69
    .io_in_b_bits_address (auto_out_1_b_bits_address),
    .io_in_c_ready        (out_15_ready),	// Arbiter.scala:123:31
    .io_in_c_valid        (auto_in_6_c_valid),
    .io_in_c_bits_opcode  (auto_in_6_c_bits_opcode),
    .io_in_c_bits_param   (auto_in_6_c_bits_param),
    .io_in_c_bits_size    (auto_in_6_c_bits_size),
    .io_in_c_bits_source  (auto_in_6_c_bits_source),
    .io_in_c_bits_address (auto_in_6_c_bits_address),
    .io_in_c_bits_corrupt (auto_in_6_c_bits_corrupt),
    .io_in_d_ready        (auto_in_6_d_ready),
    .io_in_d_valid        (out_57_valid),	// Arbiter.scala:125:29
    .io_in_d_bits_opcode  (out_57_bits_opcode),	// Mux.scala:27:72
    .io_in_d_bits_param   (out_57_bits_param),	// Mux.scala:27:72
    .io_in_d_bits_size    (out_57_bits_size),	// Mux.scala:27:72
    .io_in_d_bits_source  (out_57_bits_source),	// Mux.scala:27:72
    .io_in_d_bits_sink    (out_57_bits_sink),	// Mux.scala:27:72
    .io_in_d_bits_denied  (out_57_bits_denied),	// Mux.scala:27:72
    .io_in_d_bits_corrupt (out_57_bits_corrupt),	// Mux.scala:27:72
    .io_in_e_ready        (out_22_ready),	// Arbiter.scala:121:24
    .io_in_e_valid        (auto_in_6_e_valid),
    .io_in_e_bits_sink    (auto_in_6_e_bits_sink)
  );
  assign auto_in_6_a_ready = _portsAOI_in_6_a_ready_WIRE;	// Mux.scala:27:72
  assign auto_in_6_b_valid = out_54_valid;	// Xbar.scala:179:40
  assign auto_in_6_b_bits_source = auto_out_1_b_bits_source[2:0];	// Xbar.scala:228:69
  assign auto_in_6_c_ready = out_15_ready;	// Arbiter.scala:123:31
  assign auto_in_6_d_valid = out_57_valid;	// Arbiter.scala:125:29
  assign auto_in_6_d_bits_opcode = out_57_bits_opcode;	// Mux.scala:27:72
  assign auto_in_6_d_bits_param = out_57_bits_param;	// Mux.scala:27:72
  assign auto_in_6_d_bits_size = out_57_bits_size;	// Mux.scala:27:72
  assign auto_in_6_d_bits_source = out_57_bits_source;	// Mux.scala:27:72
  assign auto_in_6_d_bits_sink = out_57_bits_sink;	// Mux.scala:27:72
  assign auto_in_6_d_bits_denied = out_57_bits_denied;	// Mux.scala:27:72
  assign auto_in_6_d_bits_data =
    (muxStateEarly_10_0 ? auto_out_0_d_bits_data : 64'h0)
    | (muxStateEarly_10_1 ? auto_out_1_d_bits_data : 64'h0);	// Arbiter.scala:117:30, Bundles.scala:257:54, Mux.scala:27:72
  assign auto_in_6_d_bits_corrupt = out_57_bits_corrupt;	// Mux.scala:27:72
  assign auto_in_6_e_ready = out_22_ready;	// Arbiter.scala:121:24
  assign auto_in_5_a_ready = _portsAOI_in_5_a_ready_WIRE;	// Mux.scala:27:72
  assign auto_in_5_b_valid = out_49_valid;	// Xbar.scala:179:40
  assign auto_in_5_b_bits_source = auto_out_1_b_bits_source[3:0];	// Xbar.scala:228:69
  assign auto_in_5_c_ready = out_14_ready;	// Arbiter.scala:123:31
  assign auto_in_5_d_valid = out_52_valid;	// Arbiter.scala:125:29
  assign auto_in_5_d_bits_opcode = out_52_bits_opcode;	// Mux.scala:27:72
  assign auto_in_5_d_bits_param = out_52_bits_param;	// Mux.scala:27:72
  assign auto_in_5_d_bits_size = out_52_bits_size;	// Mux.scala:27:72
  assign auto_in_5_d_bits_source = out_52_bits_source;	// Mux.scala:27:72
  assign auto_in_5_d_bits_sink = out_52_bits_sink;	// Mux.scala:27:72
  assign auto_in_5_d_bits_denied = out_52_bits_denied;	// Mux.scala:27:72
  assign auto_in_5_d_bits_data =
    (muxStateEarly_9_0 ? auto_out_0_d_bits_data : 64'h0)
    | (muxStateEarly_9_1 ? auto_out_1_d_bits_data : 64'h0);	// Arbiter.scala:117:30, Bundles.scala:257:54, Mux.scala:27:72
  assign auto_in_5_d_bits_corrupt = out_52_bits_corrupt;	// Mux.scala:27:72
  assign auto_in_5_e_ready = out_21_ready;	// Arbiter.scala:121:24
  assign auto_in_4_a_ready = _portsAOI_in_4_a_ready_WIRE;	// Mux.scala:27:72
  assign auto_in_4_b_valid = out_44_valid;	// Xbar.scala:179:40
  assign auto_in_4_b_bits_source = auto_out_1_b_bits_source[4:0];	// Xbar.scala:228:69
  assign auto_in_4_c_ready = out_13_ready;	// Arbiter.scala:123:31
  assign auto_in_4_d_valid = out_47_valid;	// Arbiter.scala:125:29
  assign auto_in_4_d_bits_opcode = out_47_bits_opcode;	// Mux.scala:27:72
  assign auto_in_4_d_bits_param = out_47_bits_param;	// Mux.scala:27:72
  assign auto_in_4_d_bits_size = out_47_bits_size;	// Mux.scala:27:72
  assign auto_in_4_d_bits_source = out_47_bits_source;	// Mux.scala:27:72
  assign auto_in_4_d_bits_sink = out_47_bits_sink;	// Mux.scala:27:72
  assign auto_in_4_d_bits_denied = out_47_bits_denied;	// Mux.scala:27:72
  assign auto_in_4_d_bits_data =
    (muxStateEarly_8_0 ? auto_out_0_d_bits_data : 64'h0)
    | (muxStateEarly_8_1 ? auto_out_1_d_bits_data : 64'h0);	// Arbiter.scala:117:30, Bundles.scala:257:54, Mux.scala:27:72
  assign auto_in_4_d_bits_corrupt = out_47_bits_corrupt;	// Mux.scala:27:72
  assign auto_in_4_e_ready = out_20_ready;	// Arbiter.scala:121:24
  assign auto_in_3_a_ready = _portsAOI_in_3_a_ready_WIRE;	// Mux.scala:27:72
  assign auto_in_3_b_valid = out_39_valid;	// Xbar.scala:179:40
  assign auto_in_3_b_bits_source = auto_out_1_b_bits_source[1:0];	// Xbar.scala:228:69
  assign auto_in_3_c_ready = out_12_ready;	// Arbiter.scala:123:31
  assign auto_in_3_d_valid = out_42_valid;	// Arbiter.scala:125:29
  assign auto_in_3_d_bits_opcode = out_42_bits_opcode;	// Mux.scala:27:72
  assign auto_in_3_d_bits_param = out_42_bits_param;	// Mux.scala:27:72
  assign auto_in_3_d_bits_size = out_42_bits_size;	// Mux.scala:27:72
  assign auto_in_3_d_bits_source = out_42_bits_source;	// Mux.scala:27:72
  assign auto_in_3_d_bits_sink = out_42_bits_sink;	// Mux.scala:27:72
  assign auto_in_3_d_bits_denied = out_42_bits_denied;	// Mux.scala:27:72
  assign auto_in_3_d_bits_data =
    (muxStateEarly_7_0 ? auto_out_0_d_bits_data : 64'h0)
    | (muxStateEarly_7_1 ? auto_out_1_d_bits_data : 64'h0);	// Arbiter.scala:117:30, Bundles.scala:257:54, Mux.scala:27:72
  assign auto_in_3_d_bits_corrupt = out_42_bits_corrupt;	// Mux.scala:27:72
  assign auto_in_3_e_ready = out_19_ready;	// Arbiter.scala:121:24
  assign auto_in_2_a_ready = _portsAOI_in_2_a_ready_WIRE;	// Mux.scala:27:72
  assign auto_in_2_b_valid = out_34_valid;	// Xbar.scala:179:40
  assign auto_in_2_b_bits_source = auto_out_1_b_bits_source[1:0];	// Xbar.scala:228:69
  assign auto_in_2_c_ready = out_11_ready;	// Arbiter.scala:123:31
  assign auto_in_2_d_valid = out_37_valid;	// Arbiter.scala:125:29
  assign auto_in_2_d_bits_opcode = out_37_bits_opcode;	// Mux.scala:27:72
  assign auto_in_2_d_bits_param = out_37_bits_param;	// Mux.scala:27:72
  assign auto_in_2_d_bits_size = out_37_bits_size;	// Mux.scala:27:72
  assign auto_in_2_d_bits_source = out_37_bits_source;	// Mux.scala:27:72
  assign auto_in_2_d_bits_sink = out_37_bits_sink;	// Mux.scala:27:72
  assign auto_in_2_d_bits_denied = out_37_bits_denied;	// Mux.scala:27:72
  assign auto_in_2_d_bits_data =
    (muxStateEarly_6_0 ? auto_out_0_d_bits_data : 64'h0)
    | (muxStateEarly_6_1 ? auto_out_1_d_bits_data : 64'h0);	// Arbiter.scala:117:30, Bundles.scala:257:54, Mux.scala:27:72
  assign auto_in_2_d_bits_corrupt = out_37_bits_corrupt;	// Mux.scala:27:72
  assign auto_in_2_e_ready = out_18_ready;	// Arbiter.scala:121:24
  assign auto_in_1_a_ready = _portsAOI_in_1_a_ready_WIRE;	// Mux.scala:27:72
  assign auto_in_1_b_valid = out_29_valid;	// Xbar.scala:179:40
  assign auto_in_1_b_bits_source = auto_out_1_b_bits_source[1:0];	// Xbar.scala:228:69
  assign auto_in_1_c_ready = out_10_ready;	// Arbiter.scala:123:31
  assign auto_in_1_d_valid = out_32_valid;	// Arbiter.scala:125:29
  assign auto_in_1_d_bits_opcode = out_32_bits_opcode;	// Mux.scala:27:72
  assign auto_in_1_d_bits_param = out_32_bits_param;	// Mux.scala:27:72
  assign auto_in_1_d_bits_size = out_32_bits_size;	// Mux.scala:27:72
  assign auto_in_1_d_bits_source = out_32_bits_source;	// Mux.scala:27:72
  assign auto_in_1_d_bits_sink = out_32_bits_sink;	// Mux.scala:27:72
  assign auto_in_1_d_bits_denied = out_32_bits_denied;	// Mux.scala:27:72
  assign auto_in_1_d_bits_data =
    (muxStateEarly_5_0 ? auto_out_0_d_bits_data : 64'h0)
    | (muxStateEarly_5_1 ? auto_out_1_d_bits_data : 64'h0);	// Arbiter.scala:117:30, Bundles.scala:257:54, Mux.scala:27:72
  assign auto_in_1_d_bits_corrupt = out_32_bits_corrupt;	// Mux.scala:27:72
  assign auto_in_1_e_ready = out_17_ready;	// Arbiter.scala:121:24
  assign auto_in_0_a_ready = _portsAOI_in_0_a_ready_WIRE;	// Mux.scala:27:72
  assign auto_in_0_d_valid = out_27_valid;	// Arbiter.scala:125:29
  assign auto_in_0_d_bits_opcode = out_27_bits_opcode;	// Mux.scala:27:72
  assign auto_in_0_d_bits_param = out_27_bits_param;	// Mux.scala:27:72
  assign auto_in_0_d_bits_size = out_27_bits_size;	// Mux.scala:27:72
  assign auto_in_0_d_bits_sink = out_27_bits_sink;	// Mux.scala:27:72
  assign auto_in_0_d_bits_denied = out_27_bits_denied;	// Mux.scala:27:72
  assign auto_in_0_d_bits_data =
    (muxStateEarly_4_0 ? auto_out_0_d_bits_data : 64'h0)
    | (muxStateEarly_4_1 ? auto_out_1_d_bits_data : 64'h0);	// Arbiter.scala:117:30, Bundles.scala:257:54, Mux.scala:27:72
  assign auto_in_0_d_bits_corrupt = out_27_bits_corrupt;	// Mux.scala:27:72
  assign auto_out_1_a_valid = bundleOut_1_out_1_valid;	// Arbiter.scala:125:29
  assign auto_out_1_a_bits_opcode =
    (muxStateEarly_1_0 ? auto_in_0_a_bits_opcode : 3'h0)
    | (muxStateEarly_1_1 ? auto_in_1_a_bits_opcode : 3'h0)
    | (muxStateEarly_1_2 ? auto_in_2_a_bits_opcode : 3'h0)
    | (muxStateEarly_1_3 ? auto_in_3_a_bits_opcode : 3'h0)
    | (muxStateEarly_1_4 ? auto_in_4_a_bits_opcode : 3'h0)
    | (muxStateEarly_1_5 ? auto_in_5_a_bits_opcode : 3'h0)
    | (muxStateEarly_1_6 ? auto_in_6_a_bits_opcode : 3'h0);	// Arbiter.scala:117:30, Mux.scala:27:72
  assign auto_out_1_a_bits_param =
    (muxStateEarly_1_0 ? auto_in_0_a_bits_param : 3'h0)
    | (muxStateEarly_1_1 ? auto_in_1_a_bits_param : 3'h0)
    | (muxStateEarly_1_2 ? auto_in_2_a_bits_param : 3'h0)
    | (muxStateEarly_1_3 ? auto_in_3_a_bits_param : 3'h0)
    | (muxStateEarly_1_4 ? auto_in_4_a_bits_param : 3'h0)
    | (muxStateEarly_1_5 ? auto_in_5_a_bits_param : 3'h0)
    | (muxStateEarly_1_6 ? auto_in_6_a_bits_param : 3'h0);	// Arbiter.scala:117:30, Mux.scala:27:72
  assign auto_out_1_a_bits_size =
    (muxStateEarly_1_0 ? auto_in_0_a_bits_size[2:0] : 3'h0)
    | (muxStateEarly_1_1 ? auto_in_1_a_bits_size[2:0] : 3'h0)
    | (muxStateEarly_1_2 ? auto_in_2_a_bits_size[2:0] : 3'h0)
    | (muxStateEarly_1_3 ? auto_in_3_a_bits_size[2:0] : 3'h0)
    | (muxStateEarly_1_4 ? auto_in_4_a_bits_size[2:0] : 3'h0)
    | (muxStateEarly_1_5 ? auto_in_5_a_bits_size[2:0] : 3'h0)
    | (muxStateEarly_1_6 ? auto_in_6_a_bits_size[2:0] : 3'h0);	// Arbiter.scala:117:30, Mux.scala:27:72
  assign auto_out_1_a_bits_source =
    (muxStateEarly_1_0 ? portsAOI_filtered_1_bits_source : 7'h0)
    | (muxStateEarly_1_1 ? portsAOI_filtered_1_1_bits_source : 7'h0)
    | (muxStateEarly_1_2 ? portsAOI_filtered_2_1_bits_source : 7'h0)
    | (muxStateEarly_1_3 ? portsAOI_filtered_3_1_bits_source : 7'h0)
    | (muxStateEarly_1_4 ? portsAOI_filtered_4_1_bits_source : 7'h0)
    | (muxStateEarly_1_5 ? portsAOI_filtered_5_1_bits_source : 7'h0)
    | (muxStateEarly_1_6 ? portsAOI_filtered_6_1_bits_source : 7'h0);	// Arbiter.scala:117:30, Mux.scala:27:72, Xbar.scala:237:{29,55}, :262:23
  assign auto_out_1_a_bits_address =
    (muxStateEarly_1_0 ? auto_in_0_a_bits_address : 32'h0)
    | (muxStateEarly_1_1 ? auto_in_1_a_bits_address : 32'h0)
    | (muxStateEarly_1_2 ? auto_in_2_a_bits_address : 32'h0)
    | (muxStateEarly_1_3 ? auto_in_3_a_bits_address : 32'h0)
    | (muxStateEarly_1_4 ? auto_in_4_a_bits_address : 32'h0)
    | (muxStateEarly_1_5 ? auto_in_5_a_bits_address : 32'h0)
    | (muxStateEarly_1_6 ? auto_in_6_a_bits_address : 32'h0);	// Arbiter.scala:117:30, Bundles.scala:257:54, Mux.scala:27:72
  assign auto_out_1_a_bits_mask =
    (muxStateEarly_1_0 ? auto_in_0_a_bits_mask : 8'h0)
    | (muxStateEarly_1_1 ? auto_in_1_a_bits_mask : 8'h0)
    | (muxStateEarly_1_2 ? auto_in_2_a_bits_mask : 8'h0)
    | (muxStateEarly_1_3 ? auto_in_3_a_bits_mask : 8'h0)
    | (muxStateEarly_1_4 ? auto_in_4_a_bits_mask : 8'h0)
    | (muxStateEarly_1_5 ? auto_in_5_a_bits_mask : 8'h0)
    | (muxStateEarly_1_6 ? auto_in_6_a_bits_mask : 8'h0);	// Arbiter.scala:117:30, Mux.scala:27:72, Xbar.scala:254:26
  assign auto_out_1_a_bits_data =
    (muxStateEarly_1_0 ? auto_in_0_a_bits_data : 64'h0)
    | (muxStateEarly_1_1 ? auto_in_1_a_bits_data : 64'h0)
    | (muxStateEarly_1_2 ? auto_in_2_a_bits_data : 64'h0)
    | (muxStateEarly_1_3 ? auto_in_3_a_bits_data : 64'h0)
    | (muxStateEarly_1_4 ? auto_in_4_a_bits_data : 64'h0)
    | (muxStateEarly_1_5 ? auto_in_5_a_bits_data : 64'h0)
    | (muxStateEarly_1_6 ? auto_in_6_a_bits_data : 64'h0);	// Arbiter.scala:117:30, Bundles.scala:257:54, Mux.scala:27:72
  assign auto_out_1_a_bits_corrupt =
    muxStateEarly_1_0 & auto_in_0_a_bits_corrupt | muxStateEarly_1_1
    & auto_in_1_a_bits_corrupt | muxStateEarly_1_2 & auto_in_2_a_bits_corrupt
    | muxStateEarly_1_3 & auto_in_3_a_bits_corrupt | muxStateEarly_1_4
    & auto_in_4_a_bits_corrupt | muxStateEarly_1_5 & auto_in_5_a_bits_corrupt
    | muxStateEarly_1_6 & auto_in_6_a_bits_corrupt;	// Arbiter.scala:117:30, Mux.scala:27:72
  assign auto_out_1_b_ready =
    requestBOI_1_1 & auto_in_1_b_ready | requestBOI_1_2 & auto_in_2_b_ready
    | requestBOI_1_3 & auto_in_3_b_ready | requestBOI_1_4 & auto_in_4_b_ready
    | requestBOI_1_5 & auto_in_5_b_ready | requestBOI_1_6 & auto_in_6_b_ready;	// Mux.scala:27:72, Parameters.scala:54:32
  assign auto_out_1_c_valid = bundleOut_1_out_c_valid;	// Arbiter.scala:125:29
  assign auto_out_1_c_bits_opcode =
    (muxStateEarly_2_0 ? auto_in_1_c_bits_opcode : 3'h0)
    | (muxStateEarly_2_1 ? auto_in_2_c_bits_opcode : 3'h0)
    | (muxStateEarly_2_2 ? auto_in_3_c_bits_opcode : 3'h0)
    | (muxStateEarly_2_3 ? auto_in_4_c_bits_opcode : 3'h0)
    | (muxStateEarly_2_4 ? auto_in_5_c_bits_opcode : 3'h0)
    | (muxStateEarly_2_5 ? auto_in_6_c_bits_opcode : 3'h0);	// Arbiter.scala:117:30, Mux.scala:27:72
  assign auto_out_1_c_bits_param =
    (muxStateEarly_2_0 ? auto_in_1_c_bits_param : 3'h0)
    | (muxStateEarly_2_1 ? auto_in_2_c_bits_param : 3'h0)
    | (muxStateEarly_2_2 ? auto_in_3_c_bits_param : 3'h0)
    | (muxStateEarly_2_3 ? auto_in_4_c_bits_param : 3'h0)
    | (muxStateEarly_2_4 ? auto_in_5_c_bits_param : 3'h0)
    | (muxStateEarly_2_5 ? auto_in_6_c_bits_param : 3'h0);	// Arbiter.scala:117:30, Mux.scala:27:72
  assign auto_out_1_c_bits_size =
    (muxStateEarly_2_0 ? auto_in_1_c_bits_size[2:0] : 3'h0)
    | (muxStateEarly_2_1 ? auto_in_2_c_bits_size[2:0] : 3'h0)
    | (muxStateEarly_2_2 ? auto_in_3_c_bits_size[2:0] : 3'h0)
    | (muxStateEarly_2_3 ? auto_in_4_c_bits_size[2:0] : 3'h0)
    | (muxStateEarly_2_4 ? auto_in_5_c_bits_size[2:0] : 3'h0)
    | (muxStateEarly_2_5 ? auto_in_6_c_bits_size[2:0] : 3'h0);	// Arbiter.scala:117:30, Mux.scala:27:72
  assign auto_out_1_c_bits_source =
    (muxStateEarly_2_0 ? {5'h10, auto_in_1_c_bits_source} : 7'h0)
    | (muxStateEarly_2_1 ? {5'hF, auto_in_2_c_bits_source} : 7'h0)
    | (muxStateEarly_2_2 ? {5'hE, auto_in_3_c_bits_source} : 7'h0)
    | (muxStateEarly_2_3 ? {2'h0, auto_in_4_c_bits_source} : 7'h0)
    | (muxStateEarly_2_4 ? {3'h2, auto_in_5_c_bits_source} : 7'h0)
    | (muxStateEarly_2_5 ? {4'h6, auto_in_6_c_bits_source} : 7'h0);	// Arbiter.scala:117:30, Mux.scala:27:72, Parameters.scala:54:32, Xbar.scala:254:26, :259:{29,55}, :262:23
  assign auto_out_1_c_bits_address =
    (muxStateEarly_2_0 ? auto_in_1_c_bits_address : 32'h0)
    | (muxStateEarly_2_1 ? auto_in_2_c_bits_address : 32'h0)
    | (muxStateEarly_2_2 ? auto_in_3_c_bits_address : 32'h0)
    | (muxStateEarly_2_3 ? auto_in_4_c_bits_address : 32'h0)
    | (muxStateEarly_2_4 ? auto_in_5_c_bits_address : 32'h0)
    | (muxStateEarly_2_5 ? auto_in_6_c_bits_address : 32'h0);	// Arbiter.scala:117:30, Bundles.scala:257:54, Mux.scala:27:72
  assign auto_out_1_c_bits_data =
    (muxStateEarly_2_0 ? auto_in_1_c_bits_data : 64'h0)
    | (muxStateEarly_2_1 ? auto_in_2_c_bits_data : 64'h0)
    | (muxStateEarly_2_2 ? auto_in_3_c_bits_data : 64'h0)
    | (muxStateEarly_2_3 ? auto_in_4_c_bits_data : 64'h0)
    | (muxStateEarly_2_4 ? auto_in_5_c_bits_data : 64'h0)
    | (muxStateEarly_2_5 ? auto_in_6_c_bits_data : 64'h0);	// Arbiter.scala:117:30, Bundles.scala:257:54, Mux.scala:27:72
  assign auto_out_1_c_bits_corrupt =
    muxStateEarly_2_0 & auto_in_1_c_bits_corrupt | muxStateEarly_2_1
    & auto_in_2_c_bits_corrupt | muxStateEarly_2_2 & auto_in_3_c_bits_corrupt
    | muxStateEarly_2_3 & auto_in_4_c_bits_corrupt | muxStateEarly_2_4
    & auto_in_5_c_bits_corrupt | muxStateEarly_2_5 & auto_in_6_c_bits_corrupt;	// Arbiter.scala:117:30, Mux.scala:27:72
  assign auto_out_1_d_ready =
    requestDOI_1_0 & auto_in_0_d_ready & allowed_4_1 | requestDOI_1_1 & auto_in_1_d_ready
    & allowed_5_1 | requestDOI_1_2 & auto_in_2_d_ready & allowed_6_1 | requestDOI_1_3
    & auto_in_3_d_ready & allowed_7_1 | requestDOI_1_4 & auto_in_4_d_ready & allowed_8_1
    | requestDOI_1_5 & auto_in_5_d_ready & allowed_9_1 | requestDOI_1_6
    & auto_in_6_d_ready & allowed_10_1;	// Arbiter.scala:121:24, Mux.scala:27:72, Parameters.scala:46:9, :54:32
  assign auto_out_1_e_valid = bundleOut_1_out_e_valid;	// Arbiter.scala:125:29
  assign auto_out_1_e_bits_sink =
    ((beatsLeft_3 ? state_3_0 : prefixOR_1_3) ? auto_in_1_e_bits_sink : 3'h0)
    | ((beatsLeft_3 ? state_3_1 : earlyWinner_3_1) ? auto_in_2_e_bits_sink : 3'h0)
    | ((beatsLeft_3 ? state_3_2 : earlyWinner_3_2) ? auto_in_3_e_bits_sink : 3'h0)
    | ((beatsLeft_3 ? state_3_3 : earlyWinner_3_3) ? auto_in_4_e_bits_sink : 3'h0)
    | ((beatsLeft_3 ? state_3_4 : earlyWinner_3_4) ? auto_in_5_e_bits_sink : 3'h0)
    | ((beatsLeft_3 ? state_3_5 : earlyWinner_3_5) ? auto_in_6_e_bits_sink : 3'h0);	// Arbiter.scala:87:30, :97:79, :116:26, :117:30, Mux.scala:27:72
  assign auto_out_0_a_valid = bundleOut_0_out_1_valid;	// Arbiter.scala:125:29
  assign auto_out_0_a_bits_opcode =
    (muxStateEarly_0 ? auto_in_0_a_bits_opcode : 3'h0)
    | (muxStateEarly_1 ? auto_in_1_a_bits_opcode : 3'h0)
    | (muxStateEarly_2 ? auto_in_2_a_bits_opcode : 3'h0)
    | (muxStateEarly_3 ? auto_in_3_a_bits_opcode : 3'h0)
    | (muxStateEarly_4 ? auto_in_4_a_bits_opcode : 3'h0)
    | (muxStateEarly_5 ? auto_in_5_a_bits_opcode : 3'h0)
    | (muxStateEarly_6 ? auto_in_6_a_bits_opcode : 3'h0);	// Arbiter.scala:117:30, Mux.scala:27:72
  assign auto_out_0_a_bits_param =
    (muxStateEarly_0 ? auto_in_0_a_bits_param : 3'h0)
    | (muxStateEarly_1 ? auto_in_1_a_bits_param : 3'h0)
    | (muxStateEarly_2 ? auto_in_2_a_bits_param : 3'h0)
    | (muxStateEarly_3 ? auto_in_3_a_bits_param : 3'h0)
    | (muxStateEarly_4 ? auto_in_4_a_bits_param : 3'h0)
    | (muxStateEarly_5 ? auto_in_5_a_bits_param : 3'h0)
    | (muxStateEarly_6 ? auto_in_6_a_bits_param : 3'h0);	// Arbiter.scala:117:30, Mux.scala:27:72
  assign auto_out_0_a_bits_size =
    (muxStateEarly_0 ? auto_in_0_a_bits_size : 4'h0)
    | (muxStateEarly_1 ? auto_in_1_a_bits_size : 4'h0)
    | (muxStateEarly_2 ? auto_in_2_a_bits_size : 4'h0)
    | (muxStateEarly_3 ? auto_in_3_a_bits_size : 4'h0)
    | (muxStateEarly_4 ? auto_in_4_a_bits_size : 4'h0)
    | (muxStateEarly_5 ? auto_in_5_a_bits_size : 4'h0)
    | (muxStateEarly_6 ? auto_in_6_a_bits_size : 4'h0);	// Arbiter.scala:117:30, Bundles.scala:257:54, Mux.scala:27:72
  assign auto_out_0_a_bits_source =
    (muxStateEarly_0 ? portsAOI_filtered_1_bits_source : 7'h0)
    | (muxStateEarly_1 ? portsAOI_filtered_1_1_bits_source : 7'h0)
    | (muxStateEarly_2 ? portsAOI_filtered_2_1_bits_source : 7'h0)
    | (muxStateEarly_3 ? portsAOI_filtered_3_1_bits_source : 7'h0)
    | (muxStateEarly_4 ? portsAOI_filtered_4_1_bits_source : 7'h0)
    | (muxStateEarly_5 ? portsAOI_filtered_5_1_bits_source : 7'h0)
    | (muxStateEarly_6 ? portsAOI_filtered_6_1_bits_source : 7'h0);	// Arbiter.scala:117:30, Mux.scala:27:72, Xbar.scala:237:{29,55}, :262:23
  assign auto_out_0_a_bits_address =
    (muxStateEarly_0 ? auto_in_0_a_bits_address[30:0] : 31'h0)
    | (muxStateEarly_1 ? auto_in_1_a_bits_address[30:0] : 31'h0)
    | (muxStateEarly_2 ? auto_in_2_a_bits_address[30:0] : 31'h0)
    | (muxStateEarly_3 ? auto_in_3_a_bits_address[30:0] : 31'h0)
    | (muxStateEarly_4 ? auto_in_4_a_bits_address[30:0] : 31'h0)
    | (muxStateEarly_5 ? auto_in_5_a_bits_address[30:0] : 31'h0)
    | (muxStateEarly_6 ? auto_in_6_a_bits_address[30:0] : 31'h0);	// Arbiter.scala:117:30, Bundles.scala:257:54, Mux.scala:27:72
  assign auto_out_0_a_bits_mask =
    (muxStateEarly_0 ? auto_in_0_a_bits_mask : 8'h0)
    | (muxStateEarly_1 ? auto_in_1_a_bits_mask : 8'h0)
    | (muxStateEarly_2 ? auto_in_2_a_bits_mask : 8'h0)
    | (muxStateEarly_3 ? auto_in_3_a_bits_mask : 8'h0)
    | (muxStateEarly_4 ? auto_in_4_a_bits_mask : 8'h0)
    | (muxStateEarly_5 ? auto_in_5_a_bits_mask : 8'h0)
    | (muxStateEarly_6 ? auto_in_6_a_bits_mask : 8'h0);	// Arbiter.scala:117:30, Mux.scala:27:72, Xbar.scala:254:26
  assign auto_out_0_a_bits_data =
    (muxStateEarly_0 ? auto_in_0_a_bits_data : 64'h0)
    | (muxStateEarly_1 ? auto_in_1_a_bits_data : 64'h0)
    | (muxStateEarly_2 ? auto_in_2_a_bits_data : 64'h0)
    | (muxStateEarly_3 ? auto_in_3_a_bits_data : 64'h0)
    | (muxStateEarly_4 ? auto_in_4_a_bits_data : 64'h0)
    | (muxStateEarly_5 ? auto_in_5_a_bits_data : 64'h0)
    | (muxStateEarly_6 ? auto_in_6_a_bits_data : 64'h0);	// Arbiter.scala:117:30, Bundles.scala:257:54, Mux.scala:27:72
  assign auto_out_0_a_bits_corrupt =
    muxStateEarly_0 & auto_in_0_a_bits_corrupt | muxStateEarly_1
    & auto_in_1_a_bits_corrupt | muxStateEarly_2 & auto_in_2_a_bits_corrupt
    | muxStateEarly_3 & auto_in_3_a_bits_corrupt | muxStateEarly_4
    & auto_in_4_a_bits_corrupt | muxStateEarly_5 & auto_in_5_a_bits_corrupt
    | muxStateEarly_6 & auto_in_6_a_bits_corrupt;	// Arbiter.scala:117:30, Mux.scala:27:72
  assign auto_out_0_d_ready =
    requestDOI_0_0 & auto_in_0_d_ready & allowed_4_0 | requestDOI_0_1 & auto_in_1_d_ready
    & allowed_5_0 | requestDOI_0_2 & auto_in_2_d_ready & allowed_6_0 | requestDOI_0_3
    & auto_in_3_d_ready & allowed_7_0 | requestDOI_0_4 & auto_in_4_d_ready & allowed_8_0
    | requestDOI_0_5 & auto_in_5_d_ready & allowed_9_0 | requestDOI_0_6
    & auto_in_6_d_ready & allowed_10_0;	// Arbiter.scala:121:24, Mux.scala:27:72, Parameters.scala:46:9, :54:32
endmodule

