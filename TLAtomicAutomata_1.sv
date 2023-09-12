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

module TLAtomicAutomata_1(
  input         clock,
                reset,
                auto_in_a_valid,
  input  [2:0]  auto_in_a_bits_opcode,
                auto_in_a_bits_param,
  input  [3:0]  auto_in_a_bits_size,
  input  [7:0]  auto_in_a_bits_source,
  input  [30:0] auto_in_a_bits_address,
  input  [7:0]  auto_in_a_bits_mask,
  input  [63:0] auto_in_a_bits_data,
  input         auto_in_a_bits_corrupt,
                auto_in_d_ready,
                auto_out_a_ready,
                auto_out_d_valid,
  input  [2:0]  auto_out_d_bits_opcode,
  input  [1:0]  auto_out_d_bits_param,
  input  [3:0]  auto_out_d_bits_size,
  input  [7:0]  auto_out_d_bits_source,
  input         auto_out_d_bits_sink,
                auto_out_d_bits_denied,
  input  [63:0] auto_out_d_bits_data,
  input         auto_out_d_bits_corrupt,
  output        auto_in_a_ready,
                auto_in_d_valid,
  output [2:0]  auto_in_d_bits_opcode,
  output [1:0]  auto_in_d_bits_param,
  output [3:0]  auto_in_d_bits_size,
  output [7:0]  auto_in_d_bits_source,
  output        auto_in_d_bits_sink,
                auto_in_d_bits_denied,
  output [63:0] auto_in_d_bits_data,
  output        auto_in_d_bits_corrupt,
                auto_out_a_valid,
  output [2:0]  auto_out_a_bits_opcode,
                auto_out_a_bits_param,
  output [3:0]  auto_out_a_bits_size,
  output [7:0]  auto_out_a_bits_source,
  output [30:0] auto_out_a_bits_address,
  output [7:0]  auto_out_a_bits_mask,
  output [63:0] auto_out_a_bits_data,
  output        auto_out_a_bits_corrupt,
                auto_out_d_ready
);

  wire        out_1_ready;	// Arbiter.scala:123:31
  reg  [1:0]  cam_s_0_state;	// AtomicAutomata.scala:76:28
  reg  [2:0]  cam_a_0_bits_opcode;	// AtomicAutomata.scala:77:24
  reg  [2:0]  cam_a_0_bits_param;	// AtomicAutomata.scala:77:24
  reg  [3:0]  cam_a_0_bits_size;	// AtomicAutomata.scala:77:24
  reg  [7:0]  cam_a_0_bits_source;	// AtomicAutomata.scala:77:24
  reg  [30:0] cam_a_0_bits_address;	// AtomicAutomata.scala:77:24
  reg  [7:0]  cam_a_0_bits_mask;	// AtomicAutomata.scala:77:24
  reg  [63:0] cam_a_0_bits_data;	// AtomicAutomata.scala:77:24
  reg         cam_a_0_bits_corrupt;	// AtomicAutomata.scala:77:24
  reg         cam_a_0_fifoId;	// AtomicAutomata.scala:77:24
  reg  [3:0]  cam_a_0_lut;	// AtomicAutomata.scala:77:24
  reg  [63:0] cam_d_0_data;	// AtomicAutomata.scala:78:24
  reg         cam_d_0_denied;	// AtomicAutomata.scala:78:24
  reg         cam_d_0_corrupt;	// AtomicAutomata.scala:78:24
  wire        cam_free_0 = cam_s_0_state == 2'h0;	// AtomicAutomata.scala:76:28, :80:44, Bundles.scala:256:54
  wire        winnerQual_0 = cam_s_0_state == 2'h2;	// AtomicAutomata.scala:76:28, :81:44
  wire        _a_canArithmetic_T_3 = auto_in_a_bits_size < 4'h4;	// Parameters.scala:92:42
  wire [6:0]  _GEN =
    {auto_in_a_bits_address[30],
     auto_in_a_bits_address[26:25],
     auto_in_a_bits_address[20],
     auto_in_a_bits_address[16],
     auto_in_a_bits_address[14],
     ~(auto_in_a_bits_address[13])};	// Parameters.scala:137:{31,49,52}
  wire [6:0]  _GEN_0 =
    {auto_in_a_bits_address[30],
     auto_in_a_bits_address[26:25],
     auto_in_a_bits_address[20],
     auto_in_a_bits_address[16],
     auto_in_a_bits_address[14:13] ^ 2'h2};	// AtomicAutomata.scala:81:44, Parameters.scala:137:{31,49,52}
  wire [6:0]  _GEN_1 =
    {auto_in_a_bits_address[30],
     auto_in_a_bits_address[26:25],
     ~(auto_in_a_bits_address[20]),
     auto_in_a_bits_address[16],
     auto_in_a_bits_address[14:13]};	// Parameters.scala:137:{31,49,52}
  wire [5:0]  _a_canArithmetic_T_19 = auto_in_a_bits_address[30:25] ^ 6'h22;	// Parameters.scala:137:31
  wire [6:0]  _GEN_2 =
    {_a_canArithmetic_T_19[5],
     _a_canArithmetic_T_19[1:0],
     auto_in_a_bits_address[20],
     auto_in_a_bits_address[16],
     auto_in_a_bits_address[14:13]};	// Parameters.scala:137:{31,49,52}
  wire        a_isSupported =
    auto_in_a_bits_opcode == 3'h3
      ? _a_canArithmetic_T_3 & (~(|_GEN) | ~(|_GEN_0) | ~(|_GEN_1) | ~(|_GEN_2))
      : auto_in_a_bits_opcode != 3'h2 | _a_canArithmetic_T_3
        & (~(|_GEN) | ~(|_GEN_0) | ~(|_GEN_1) | ~(|_GEN_2));	// AtomicAutomata.scala:90:47, :91:47, :92:{32,63}, Parameters.scala:92:42, :137:{49,52,67}, :670:56, :671:42
  wire [3:0]  _logic_out_T = cam_a_0_lut >> {2'h0, cam_a_0_bits_data[0], cam_d_0_data[0]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_1 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[1], cam_d_0_data[1]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_2 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[2], cam_d_0_data[2]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_3 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[3], cam_d_0_data[3]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_4 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[4], cam_d_0_data[4]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_5 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[5], cam_d_0_data[5]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_6 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[6], cam_d_0_data[6]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_7 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[7], cam_d_0_data[7]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_8 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[8], cam_d_0_data[8]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_9 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[9], cam_d_0_data[9]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_10 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[10], cam_d_0_data[10]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_11 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[11], cam_d_0_data[11]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_12 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[12], cam_d_0_data[12]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_13 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[13], cam_d_0_data[13]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_14 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[14], cam_d_0_data[14]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_15 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[15], cam_d_0_data[15]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_16 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[16], cam_d_0_data[16]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_17 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[17], cam_d_0_data[17]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_18 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[18], cam_d_0_data[18]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_19 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[19], cam_d_0_data[19]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_20 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[20], cam_d_0_data[20]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_21 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[21], cam_d_0_data[21]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_22 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[22], cam_d_0_data[22]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_23 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[23], cam_d_0_data[23]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_24 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[24], cam_d_0_data[24]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_25 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[25], cam_d_0_data[25]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_26 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[26], cam_d_0_data[26]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_27 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[27], cam_d_0_data[27]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_28 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[28], cam_d_0_data[28]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_29 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[29], cam_d_0_data[29]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_30 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[30], cam_d_0_data[30]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_31 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[31], cam_d_0_data[31]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_32 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[32], cam_d_0_data[32]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_33 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[33], cam_d_0_data[33]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_34 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[34], cam_d_0_data[34]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_35 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[35], cam_d_0_data[35]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_36 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[36], cam_d_0_data[36]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_37 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[37], cam_d_0_data[37]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_38 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[38], cam_d_0_data[38]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_39 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[39], cam_d_0_data[39]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_40 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[40], cam_d_0_data[40]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_41 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[41], cam_d_0_data[41]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_42 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[42], cam_d_0_data[42]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_43 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[43], cam_d_0_data[43]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_44 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[44], cam_d_0_data[44]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_45 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[45], cam_d_0_data[45]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_46 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[46], cam_d_0_data[46]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_47 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[47], cam_d_0_data[47]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_48 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[48], cam_d_0_data[48]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_49 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[49], cam_d_0_data[49]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_50 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[50], cam_d_0_data[50]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_51 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[51], cam_d_0_data[51]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_52 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[52], cam_d_0_data[52]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_53 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[53], cam_d_0_data[53]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_54 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[54], cam_d_0_data[54]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_55 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[55], cam_d_0_data[55]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_56 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[56], cam_d_0_data[56]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_57 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[57], cam_d_0_data[57]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_58 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[58], cam_d_0_data[58]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_59 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[59], cam_d_0_data[59]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_60 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[60], cam_d_0_data[60]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_61 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[61], cam_d_0_data[61]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_62 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[62], cam_d_0_data[62]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [3:0]  _logic_out_T_63 =
    cam_a_0_lut >> {2'h0, cam_a_0_bits_data[63], cam_d_0_data[63]};	// AtomicAutomata.scala:77:24, :78:24, :113:{63,73}, :114:57, Bundles.scala:256:54
  wire [6:0]  _GEN_3 = ~(cam_a_0_bits_mask[6:0]) | cam_a_0_bits_mask[7:1];	// AtomicAutomata.scala:77:24, :121:{25,31,39}
  wire [6:0]  _signbit_a_T =
    {cam_a_0_bits_data[55],
     cam_a_0_bits_data[47],
     cam_a_0_bits_data[39],
     cam_a_0_bits_data[31],
     cam_a_0_bits_data[23],
     cam_a_0_bits_data[15],
     cam_a_0_bits_data[7]} & ~_GEN_3;	// AtomicAutomata.scala:77:24, :113:63, :121:{23,31}, :125:38, Cat.scala:30:58
  wire [6:0]  _signbit_d_T =
    {cam_d_0_data[55],
     cam_d_0_data[47],
     cam_d_0_data[39],
     cam_d_0_data[31],
     cam_d_0_data[23],
     cam_d_0_data[15],
     cam_d_0_data[7]} & ~_GEN_3;	// AtomicAutomata.scala:78:24, :113:73, :121:{23,31}, :126:38, Cat.scala:30:58
  wire [5:0]  _GEN_4 = _signbit_a_T[6:1] | _signbit_a_T[5:0];	// AtomicAutomata.scala:125:38, package.scala:244:{43,53}
  wire [3:0]  _GEN_5 = _GEN_4[5:2] | _GEN_4[3:0];	// package.scala:244:{43,53}
  wire        _signext_a_T_21 = _GEN_4[1] | _signbit_a_T[0];	// AtomicAutomata.scala:125:38, package.scala:244:43
  wire [5:0]  _GEN_6 = _signbit_d_T[6:1] | _signbit_d_T[5:0];	// AtomicAutomata.scala:126:38, package.scala:244:{43,53}
  wire [3:0]  _GEN_7 = _GEN_6[5:2] | _GEN_6[3:0];	// package.scala:244:{43,53}
  wire        _signext_d_T_21 = _GEN_6[1] | _signbit_d_T[0];	// AtomicAutomata.scala:126:38, package.scala:244:43
  wire [63:0] wide_mask =
    {{8{cam_a_0_bits_mask[7]}},
     {8{cam_a_0_bits_mask[6]}},
     {8{cam_a_0_bits_mask[5]}},
     {8{cam_a_0_bits_mask[4]}},
     {8{cam_a_0_bits_mask[3]}},
     {8{cam_a_0_bits_mask[2]}},
     {8{cam_a_0_bits_mask[1]}},
     {8{cam_a_0_bits_mask[0]}}};	// AtomicAutomata.scala:77:24, Bitwise.scala:26:51, :72:12, Cat.scala:30:58
  wire [63:0] a_a_ext =
    cam_a_0_bits_data & wide_mask
    | {{8{_GEN_5[3] | _signext_a_T_21}},
       {8{_GEN_5[2] | _GEN_4[0]}},
       {8{_GEN_5[1] | _signbit_a_T[0]}},
       {8{_GEN_5[0]}},
       {8{_signext_a_T_21}},
       {8{_GEN_4[0]}},
       {8{_signbit_a_T[0]}},
       8'h0};	// AtomicAutomata.scala:77:24, :125:38, :131:{28,41}, Bitwise.scala:72:12, Cat.scala:30:58, package.scala:244:43
  wire [63:0] a_d_ext =
    cam_d_0_data & wide_mask
    | {{8{_GEN_7[3] | _signext_d_T_21}},
       {8{_GEN_7[2] | _GEN_6[0]}},
       {8{_GEN_7[1] | _signbit_d_T[0]}},
       {8{_GEN_7[0]}},
       {8{_signext_d_T_21}},
       {8{_GEN_6[0]}},
       {8{_signbit_d_T[0]}},
       8'h0};	// AtomicAutomata.scala:78:24, :126:38, :132:{28,41}, Bitwise.scala:72:12, Cat.scala:30:58, package.scala:244:43
  wire [63:0] _adder_out_T = a_a_ext + ({64{~(cam_a_0_bits_param[2])}} ^ a_d_ext);	// AtomicAutomata.scala:77:24, :119:39, :131:41, :132:41, :133:26, :134:33
  wire        a_allow =
    ~(((&cam_s_0_state) | winnerQual_0) & ~cam_a_0_fifoId) & (a_isSupported | cam_free_0);	// AtomicAutomata.scala:76:28, :77:24, :80:44, :81:44, :82:{49,57}, :92:32, :105:{60,96}, :149:{23,35,53}
  wire        bundleIn_0_a_ready = out_1_ready & a_allow;	// Arbiter.scala:123:31, AtomicAutomata.scala:149:35, :150:38
  wire        validQuals_1 = auto_in_a_valid & a_allow;	// AtomicAutomata.scala:149:35, :151:38
  wire        _source_c_bits_a_mask_T = cam_a_0_bits_size > 4'h2;	// AtomicAutomata.scala:77:24, Misc.scala:205:21
  wire        source_c_bits_a_mask_size = cam_a_0_bits_size[1:0] == 2'h2;	// AtomicAutomata.scala:77:24, :81:44, Misc.scala:208:26, OneHot.scala:64:49
  wire        source_c_bits_a_mask_acc =
    _source_c_bits_a_mask_T | source_c_bits_a_mask_size & ~(cam_a_0_bits_address[2]);	// AtomicAutomata.scala:77:24, Misc.scala:205:21, :208:26, :209:26, :210:20, :214:{29,38}
  wire        source_c_bits_a_mask_acc_1 =
    _source_c_bits_a_mask_T | source_c_bits_a_mask_size & cam_a_0_bits_address[2];	// AtomicAutomata.scala:77:24, Misc.scala:205:21, :208:26, :209:26, :214:{29,38}
  wire        source_c_bits_a_mask_size_1 = cam_a_0_bits_size[1:0] == 2'h1;	// AtomicAutomata.scala:77:24, :197:23, Misc.scala:208:26, OneHot.scala:64:49
  wire        source_c_bits_a_mask_eq_2 =
    ~(cam_a_0_bits_address[2]) & ~(cam_a_0_bits_address[1]);	// AtomicAutomata.scala:77:24, Misc.scala:209:26, :210:20, :213:27
  wire        source_c_bits_a_mask_acc_2 =
    source_c_bits_a_mask_acc | source_c_bits_a_mask_size_1 & source_c_bits_a_mask_eq_2;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        source_c_bits_a_mask_eq_3 =
    ~(cam_a_0_bits_address[2]) & cam_a_0_bits_address[1];	// AtomicAutomata.scala:77:24, Misc.scala:209:26, :210:20, :213:27
  wire        source_c_bits_a_mask_acc_3 =
    source_c_bits_a_mask_acc | source_c_bits_a_mask_size_1 & source_c_bits_a_mask_eq_3;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        source_c_bits_a_mask_eq_4 =
    cam_a_0_bits_address[2] & ~(cam_a_0_bits_address[1]);	// AtomicAutomata.scala:77:24, Misc.scala:209:26, :210:20, :213:27
  wire        source_c_bits_a_mask_acc_4 =
    source_c_bits_a_mask_acc_1 | source_c_bits_a_mask_size_1 & source_c_bits_a_mask_eq_4;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        source_c_bits_a_mask_eq_5 =
    cam_a_0_bits_address[2] & cam_a_0_bits_address[1];	// AtomicAutomata.scala:77:24, Misc.scala:209:26, :213:27
  wire        source_c_bits_a_mask_acc_5 =
    source_c_bits_a_mask_acc_1 | source_c_bits_a_mask_size_1 & source_c_bits_a_mask_eq_5;	// Misc.scala:208:26, :213:27, :214:{29,38}
  reg  [8:0]  beatsLeft;	// Arbiter.scala:87:30
  wire        idle = beatsLeft == 9'h0;	// Arbiter.scala:87:30, :88:28, Edges.scala:228:27
  wire        earlyWinner_1 = ~winnerQual_0 & validQuals_1;	// Arbiter.scala:16:61, :97:79, AtomicAutomata.scala:81:44, :151:38
  wire        _sink_ACancel_earlyValid_T = winnerQual_0 | validQuals_1;	// Arbiter.scala:107:36, AtomicAutomata.scala:81:44, :151:38
  `ifndef SYNTHESIS	// Arbiter.scala:105:13
    always @(posedge clock) begin	// Arbiter.scala:105:13
      if (~(~winnerQual_0 | ~earlyWinner_1 | reset)) begin	// Arbiter.scala:97:79, :105:{13,61,67}, AtomicAutomata.scala:81:44
        if (`ASSERT_VERBOSE_COND_)	// Arbiter.scala:105:13
          $error("Assertion failed\n    at Arbiter.scala:105 assert((prefixOR zip earlyWinner) map { case (p,w) => !p || !w } reduce {_ && _})\n");	// Arbiter.scala:105:13
        if (`STOP_COND_)	// Arbiter.scala:105:13
          $fatal;	// Arbiter.scala:105:13
      end
      if (~(~_sink_ACancel_earlyValid_T | winnerQual_0 | earlyWinner_1 | reset)) begin	// Arbiter.scala:97:79, :107:{14,15,36}, AtomicAutomata.scala:81:44
        if (`ASSERT_VERBOSE_COND_)	// Arbiter.scala:107:14
          $error("Assertion failed\n    at Arbiter.scala:107 assert (!earlyValids.reduce(_||_) || earlyWinner.reduce(_||_))\n");	// Arbiter.scala:107:14
        if (`STOP_COND_)	// Arbiter.scala:107:14
          $fatal;	// Arbiter.scala:107:14
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  reg         state_0;	// Arbiter.scala:116:26
  reg         state_1;	// Arbiter.scala:116:26
  wire        muxStateEarly_0 = idle ? winnerQual_0 : state_0;	// Arbiter.scala:88:28, :116:26, :117:30, AtomicAutomata.scala:81:44
  wire        muxStateEarly_1 = idle ? earlyWinner_1 : state_1;	// Arbiter.scala:88:28, :97:79, :116:26, :117:30
  assign out_1_ready = auto_out_a_ready & (idle ? ~winnerQual_0 : state_1);	// Arbiter.scala:16:61, :88:28, :116:26, :121:24, :123:31, AtomicAutomata.scala:81:44
  wire        out_2_valid =
    idle ? _sink_ACancel_earlyValid_T : state_0 & winnerQual_0 | state_1 & validQuals_1;	// Arbiter.scala:88:28, :107:36, :116:26, :125:29, AtomicAutomata.scala:81:44, :151:38, Mux.scala:27:72
  reg  [8:0]  d_first_counter;	// Edges.scala:228:27
  wire        d_first = d_first_counter == 9'h0;	// Edges.scala:228:27, :230:25
  wire        d_cam_sel_0 =
    cam_a_0_bits_source == auto_out_d_bits_source & (|cam_s_0_state);	// AtomicAutomata.scala:76:28, :77:24, :83:49, :204:53, :205:83
  wire        d_ackd = auto_out_d_bits_opcode == 3'h1;	// AtomicAutomata.scala:213:40
  wire        d_drop = d_first & d_ackd & d_cam_sel_0;	// AtomicAutomata.scala:205:83, :213:40, :232:40, Edges.scala:230:25
  wire        d_replace = d_first & auto_out_d_bits_opcode == 3'h0 & d_cam_sel_0;	// AtomicAutomata.scala:205:83, :214:40, :233:42, Edges.scala:230:25
  wire        bundleIn_0_d_valid = auto_out_d_valid & ~d_drop;	// AtomicAutomata.scala:232:40, :235:{35,38}
  wire        bundleOut_0_d_ready = auto_in_d_ready | d_drop;	// AtomicAutomata.scala:232:40, :236:35
  wire [2:0]  bundleIn_0_d_bits_opcode = d_replace ? 3'h1 : auto_out_d_bits_opcode;	// AtomicAutomata.scala:233:42, :238:19, :239:26, :240:28
  wire        bundleIn_0_d_bits_corrupt =
    d_replace ? cam_d_0_corrupt | auto_out_d_bits_denied : auto_out_d_bits_corrupt;	// AtomicAutomata.scala:78:24, :233:42, :238:19, :239:26, :242:{29,46}
  wire        bundleIn_0_d_bits_denied =
    d_replace & cam_d_0_denied | auto_out_d_bits_denied;	// AtomicAutomata.scala:78:24, :233:42, :238:19, :239:26, :243:29
  always @(posedge clock) begin
    automatic logic _GEN_8;	// AtomicAutomata.scala:77:24, :174:50, :176:23, :177:24
    automatic logic _d_first_T;	// Decoupled.scala:40:37
    automatic logic _GEN_9;	// AtomicAutomata.scala:216:28
    _GEN_8 = out_1_ready & validQuals_1 & ~a_isSupported & cam_free_0;	// Arbiter.scala:123:31, AtomicAutomata.scala:77:24, :80:44, :92:32, :151:38, :153:15, :174:50, :176:23, :177:24
    _d_first_T = bundleOut_0_d_ready & auto_out_d_valid;	// AtomicAutomata.scala:236:35, Decoupled.scala:40:37
    _GEN_9 = _d_first_T & d_first;	// AtomicAutomata.scala:216:28, Decoupled.scala:40:37, Edges.scala:230:25
    if (reset) begin
      cam_s_0_state <= 2'h0;	// AtomicAutomata.scala:76:28, Bundles.scala:256:54
      beatsLeft <= 9'h0;	// Arbiter.scala:87:30, Edges.scala:228:27
      state_0 <= 1'h0;	// Arbiter.scala:116:26, AtomicAutomata.scala:75:23
      state_1 <= 1'h0;	// Arbiter.scala:116:26, AtomicAutomata.scala:75:23
      d_first_counter <= 9'h0;	// Edges.scala:228:27
    end
    else begin
      automatic logic winnerQual_1;	// Arbiter.scala:98:79
      winnerQual_1 = ~winnerQual_0 & validQuals_1;	// Arbiter.scala:16:61, :98:79, AtomicAutomata.scala:81:44, :151:38
      if (_GEN_9 & d_cam_sel_0)	// AtomicAutomata.scala:194:32, :205:83, :216:{28,40}, :225:23, :227:23
        cam_s_0_state <= {d_ackd, 1'h0};	// AtomicAutomata.scala:75:23, :76:28, :213:40, :227:29
      else if (auto_out_a_ready & (idle | state_0) & winnerQual_0)	// Arbiter.scala:88:28, :116:26, :121:24, AtomicAutomata.scala:81:44, :174:50, :194:32, :196:23, :197:23
        cam_s_0_state <= 2'h1;	// AtomicAutomata.scala:76:28, :197:23
      else if (_GEN_8)	// AtomicAutomata.scala:77:24, :174:50, :176:23, :177:24
        cam_s_0_state <= 2'h3;	// AtomicAutomata.scala:76:28, :82:49
      if (idle & auto_out_a_ready) begin	// Arbiter.scala:88:28, :89:24
        if (winnerQual_1 & ~(auto_in_a_bits_opcode[2])) begin	// Arbiter.scala:98:79, :111:73, Edges.scala:91:{28,37}, :220:14
          automatic logic [26:0] _decode_T_1 = 27'hFFF << auto_in_a_bits_size;	// package.scala:234:77
          beatsLeft <= ~(_decode_T_1[11:3]);	// Arbiter.scala:87:30, package.scala:234:{46,77,82}
        end
        else	// Arbiter.scala:111:73, Edges.scala:220:14
          beatsLeft <= 9'h0;	// Arbiter.scala:87:30, Edges.scala:228:27
      end
      else	// Arbiter.scala:89:24
        beatsLeft <= beatsLeft - {8'h0, auto_out_a_ready & out_2_valid};	// Arbiter.scala:87:30, :113:52, :125:29, Bitwise.scala:72:12, ReadyValidCancel.scala:50:33
      if (idle) begin	// Arbiter.scala:88:28
        state_0 <= winnerQual_0;	// Arbiter.scala:116:26, AtomicAutomata.scala:81:44
        state_1 <= winnerQual_1;	// Arbiter.scala:98:79, :116:26
      end
      if (_d_first_T) begin	// Decoupled.scala:40:37
        if (d_first) begin	// Edges.scala:230:25
          if (auto_out_d_bits_opcode[0]) begin	// Edges.scala:105:36
            automatic logic [26:0] _d_first_beats1_decode_T_1 =
              27'hFFF << auto_out_d_bits_size;	// package.scala:234:77
            d_first_counter <= ~(_d_first_beats1_decode_T_1[11:3]);	// Edges.scala:228:27, package.scala:234:{46,77,82}
          end
          else	// Edges.scala:105:36
            d_first_counter <= 9'h0;	// Edges.scala:228:27
        end
        else	// Edges.scala:230:25
          d_first_counter <= d_first_counter - 9'h1;	// Edges.scala:228:27, :229:28
      end
    end
    if (_GEN_8) begin	// AtomicAutomata.scala:77:24, :174:50, :176:23, :177:24
      automatic logic [3:0][3:0] _GEN_10 = {4'hC, 4'h8, 4'hE, 4'h6};	// Mux.scala:80:{57,60}
      cam_a_0_bits_opcode <= auto_in_a_bits_opcode;	// AtomicAutomata.scala:77:24
      cam_a_0_bits_param <= auto_in_a_bits_param;	// AtomicAutomata.scala:77:24
      cam_a_0_bits_size <= auto_in_a_bits_size;	// AtomicAutomata.scala:77:24
      cam_a_0_bits_source <= auto_in_a_bits_source;	// AtomicAutomata.scala:77:24
      cam_a_0_bits_address <= auto_in_a_bits_address;	// AtomicAutomata.scala:77:24
      cam_a_0_bits_mask <= auto_in_a_bits_mask;	// AtomicAutomata.scala:77:24
      cam_a_0_bits_data <= auto_in_a_bits_data;	// AtomicAutomata.scala:77:24
      cam_a_0_bits_corrupt <= auto_in_a_bits_corrupt;	// AtomicAutomata.scala:77:24
      cam_a_0_lut <= _GEN_10[auto_in_a_bits_param[1:0]];	// AtomicAutomata.scala:77:24, :179:52, Mux.scala:80:{57,60}
    end
    cam_a_0_fifoId <= ~_GEN_8 & cam_a_0_fifoId;	// AtomicAutomata.scala:77:24, :174:50, :176:23, :177:24
    if (_GEN_9 & d_cam_sel_0 & d_ackd) begin	// AtomicAutomata.scala:78:24, :205:83, :213:40, :216:{28,40}, :218:33, :219:22
      cam_d_0_data <= auto_out_d_bits_data;	// AtomicAutomata.scala:78:24
      cam_d_0_denied <= auto_out_d_bits_denied;	// AtomicAutomata.scala:78:24
      cam_d_0_corrupt <= auto_out_d_bits_corrupt;	// AtomicAutomata.scala:78:24
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:6];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [2:0] i = 3'h0; i < 3'h7; i += 3'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        cam_s_0_state = _RANDOM[3'h0][1:0];	// AtomicAutomata.scala:76:28
        cam_a_0_bits_opcode = _RANDOM[3'h0][4:2];	// AtomicAutomata.scala:76:28, :77:24
        cam_a_0_bits_param = _RANDOM[3'h0][7:5];	// AtomicAutomata.scala:76:28, :77:24
        cam_a_0_bits_size = _RANDOM[3'h0][11:8];	// AtomicAutomata.scala:76:28, :77:24
        cam_a_0_bits_source = _RANDOM[3'h0][19:12];	// AtomicAutomata.scala:76:28, :77:24
        cam_a_0_bits_address = {_RANDOM[3'h0][31:20], _RANDOM[3'h1][18:0]};	// AtomicAutomata.scala:76:28, :77:24
        cam_a_0_bits_mask = _RANDOM[3'h1][26:19];	// AtomicAutomata.scala:77:24
        cam_a_0_bits_data = {_RANDOM[3'h1][31:27], _RANDOM[3'h2], _RANDOM[3'h3][26:0]};	// AtomicAutomata.scala:77:24
        cam_a_0_bits_corrupt = _RANDOM[3'h3][27];	// AtomicAutomata.scala:77:24
        cam_a_0_fifoId = _RANDOM[3'h3][28];	// AtomicAutomata.scala:77:24
        cam_a_0_lut = {_RANDOM[3'h3][31:29], _RANDOM[3'h4][0]};	// AtomicAutomata.scala:77:24
        cam_d_0_data = {_RANDOM[3'h4][31:1], _RANDOM[3'h5], _RANDOM[3'h6][0]};	// AtomicAutomata.scala:77:24, :78:24
        cam_d_0_denied = _RANDOM[3'h6][1];	// AtomicAutomata.scala:78:24
        cam_d_0_corrupt = _RANDOM[3'h6][2];	// AtomicAutomata.scala:78:24
        beatsLeft = _RANDOM[3'h6][11:3];	// Arbiter.scala:87:30, AtomicAutomata.scala:78:24
        state_0 = _RANDOM[3'h6][12];	// Arbiter.scala:116:26, AtomicAutomata.scala:78:24
        state_1 = _RANDOM[3'h6][13];	// Arbiter.scala:116:26, AtomicAutomata.scala:78:24
        d_first_counter = _RANDOM[3'h6][22:14];	// AtomicAutomata.scala:78:24, Edges.scala:228:27
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  TLMonitor_31 monitor (	// Nodes.scala:24:25
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (bundleIn_0_a_ready),	// AtomicAutomata.scala:150:38
    .io_in_a_valid        (auto_in_a_valid),
    .io_in_a_bits_opcode  (auto_in_a_bits_opcode),
    .io_in_a_bits_param   (auto_in_a_bits_param),
    .io_in_a_bits_size    (auto_in_a_bits_size),
    .io_in_a_bits_source  (auto_in_a_bits_source),
    .io_in_a_bits_address (auto_in_a_bits_address),
    .io_in_a_bits_mask    (auto_in_a_bits_mask),
    .io_in_a_bits_corrupt (auto_in_a_bits_corrupt),
    .io_in_d_ready        (auto_in_d_ready),
    .io_in_d_valid        (bundleIn_0_d_valid),	// AtomicAutomata.scala:235:35
    .io_in_d_bits_opcode  (bundleIn_0_d_bits_opcode),	// AtomicAutomata.scala:238:19, :239:26, :240:28
    .io_in_d_bits_param   (auto_out_d_bits_param),
    .io_in_d_bits_size    (auto_out_d_bits_size),
    .io_in_d_bits_source  (auto_out_d_bits_source),
    .io_in_d_bits_sink    (auto_out_d_bits_sink),
    .io_in_d_bits_denied  (bundleIn_0_d_bits_denied),	// AtomicAutomata.scala:238:19, :239:26, :243:29
    .io_in_d_bits_corrupt (bundleIn_0_d_bits_corrupt)	// AtomicAutomata.scala:238:19, :239:26, :242:29
  );
  assign auto_in_a_ready = bundleIn_0_a_ready;	// AtomicAutomata.scala:150:38
  assign auto_in_d_valid = bundleIn_0_d_valid;	// AtomicAutomata.scala:235:35
  assign auto_in_d_bits_opcode = bundleIn_0_d_bits_opcode;	// AtomicAutomata.scala:238:19, :239:26, :240:28
  assign auto_in_d_bits_param = auto_out_d_bits_param;
  assign auto_in_d_bits_size = auto_out_d_bits_size;
  assign auto_in_d_bits_source = auto_out_d_bits_source;
  assign auto_in_d_bits_sink = auto_out_d_bits_sink;
  assign auto_in_d_bits_denied = bundleIn_0_d_bits_denied;	// AtomicAutomata.scala:238:19, :239:26, :243:29
  assign auto_in_d_bits_data = d_replace ? cam_d_0_data : auto_out_d_bits_data;	// AtomicAutomata.scala:78:24, :233:42, :238:19, :239:26, :241:26
  assign auto_in_d_bits_corrupt = bundleIn_0_d_bits_corrupt;	// AtomicAutomata.scala:238:19, :239:26, :242:29
  assign auto_out_a_valid = out_2_valid;	// Arbiter.scala:125:29
  assign auto_out_a_bits_opcode =
    muxStateEarly_1 ? (a_isSupported ? auto_in_a_bits_opcode : 3'h4) : 3'h0;	// Arbiter.scala:117:30, AtomicAutomata.scala:92:32, :152:24, :153:31, :154:32, Mux.scala:27:72
  assign auto_out_a_bits_param =
    muxStateEarly_1 & a_isSupported ? auto_in_a_bits_param : 3'h0;	// Arbiter.scala:117:30, AtomicAutomata.scala:92:32, Mux.scala:27:72
  assign auto_out_a_bits_size =
    (muxStateEarly_0 ? cam_a_0_bits_size : 4'h0)
    | (muxStateEarly_1 ? auto_in_a_bits_size : 4'h0);	// Arbiter.scala:117:30, AtomicAutomata.scala:77:24, Bundles.scala:256:54, Mux.scala:27:72
  assign auto_out_a_bits_source =
    (muxStateEarly_0 ? cam_a_0_bits_source : 8'h0)
    | (muxStateEarly_1 ? auto_in_a_bits_source : 8'h0);	// Arbiter.scala:117:30, AtomicAutomata.scala:77:24, Bitwise.scala:72:12, Mux.scala:27:72
  assign auto_out_a_bits_address =
    (muxStateEarly_0 ? cam_a_0_bits_address : 31'h0)
    | (muxStateEarly_1 ? auto_in_a_bits_address : 31'h0);	// Arbiter.scala:117:30, AtomicAutomata.scala:77:24, Bundles.scala:256:54, Mux.scala:27:72
  assign auto_out_a_bits_mask =
    (muxStateEarly_0
       ? {source_c_bits_a_mask_acc_5 | source_c_bits_a_mask_eq_5
            & cam_a_0_bits_address[0],
          source_c_bits_a_mask_acc_5 | source_c_bits_a_mask_eq_5
            & ~(cam_a_0_bits_address[0]),
          source_c_bits_a_mask_acc_4 | source_c_bits_a_mask_eq_4
            & cam_a_0_bits_address[0],
          source_c_bits_a_mask_acc_4 | source_c_bits_a_mask_eq_4
            & ~(cam_a_0_bits_address[0]),
          source_c_bits_a_mask_acc_3 | source_c_bits_a_mask_eq_3
            & cam_a_0_bits_address[0],
          source_c_bits_a_mask_acc_3 | source_c_bits_a_mask_eq_3
            & ~(cam_a_0_bits_address[0]),
          source_c_bits_a_mask_acc_2 | source_c_bits_a_mask_eq_2
            & cam_a_0_bits_address[0],
          source_c_bits_a_mask_acc_2 | source_c_bits_a_mask_eq_2
            & ~(cam_a_0_bits_address[0])}
       : 8'h0) | (muxStateEarly_1 ? auto_in_a_bits_mask : 8'h0);	// Arbiter.scala:117:30, AtomicAutomata.scala:77:24, Bitwise.scala:72:12, Cat.scala:30:58, Misc.scala:209:26, :210:20, :213:27, :214:29, Mux.scala:27:72
  assign auto_out_a_bits_data =
    (muxStateEarly_0
       ? (cam_a_0_bits_opcode[0]
            ? {_logic_out_T_63[0],
               _logic_out_T_62[0],
               _logic_out_T_61[0],
               _logic_out_T_60[0],
               _logic_out_T_59[0],
               _logic_out_T_58[0],
               _logic_out_T_57[0],
               _logic_out_T_56[0],
               _logic_out_T_55[0],
               _logic_out_T_54[0],
               _logic_out_T_53[0],
               _logic_out_T_52[0],
               _logic_out_T_51[0],
               _logic_out_T_50[0],
               _logic_out_T_49[0],
               _logic_out_T_48[0],
               _logic_out_T_47[0],
               _logic_out_T_46[0],
               _logic_out_T_45[0],
               _logic_out_T_44[0],
               _logic_out_T_43[0],
               _logic_out_T_42[0],
               _logic_out_T_41[0],
               _logic_out_T_40[0],
               _logic_out_T_39[0],
               _logic_out_T_38[0],
               _logic_out_T_37[0],
               _logic_out_T_36[0],
               _logic_out_T_35[0],
               _logic_out_T_34[0],
               _logic_out_T_33[0],
               _logic_out_T_32[0],
               _logic_out_T_31[0],
               _logic_out_T_30[0],
               _logic_out_T_29[0],
               _logic_out_T_28[0],
               _logic_out_T_27[0],
               _logic_out_T_26[0],
               _logic_out_T_25[0],
               _logic_out_T_24[0],
               _logic_out_T_23[0],
               _logic_out_T_22[0],
               _logic_out_T_21[0],
               _logic_out_T_20[0],
               _logic_out_T_19[0],
               _logic_out_T_18[0],
               _logic_out_T_17[0],
               _logic_out_T_16[0],
               _logic_out_T_15[0],
               _logic_out_T_14[0],
               _logic_out_T_13[0],
               _logic_out_T_12[0],
               _logic_out_T_11[0],
               _logic_out_T_10[0],
               _logic_out_T_9[0],
               _logic_out_T_8[0],
               _logic_out_T_7[0],
               _logic_out_T_6[0],
               _logic_out_T_5[0],
               _logic_out_T_4[0],
               _logic_out_T_3[0],
               _logic_out_T_2[0],
               _logic_out_T_1[0],
               _logic_out_T[0]}
            : cam_a_0_bits_param[2]
                ? _adder_out_T
                : cam_a_0_bits_param[0] == (a_a_ext[63] == a_d_ext[63]
                                              ? ~(_adder_out_T[63])
                                              : cam_a_0_bits_param[1] == a_a_ext[63])
                    ? cam_a_0_bits_data
                    : cam_d_0_data)
       : 64'h0) | (muxStateEarly_1 ? auto_in_a_bits_data : 64'h0);	// Arbiter.scala:117:30, AtomicAutomata.scala:77:24, :78:24, :114:57, :117:42, :118:42, :119:39, :131:41, :132:41, :134:33, :136:{38,49}, :137:{27,39,50,55,65}, :138:31, :139:{28,50}, :145:{14,34}, Bundles.scala:256:54, Cat.scala:30:58, Mux.scala:27:72
  assign auto_out_a_bits_corrupt =
    muxStateEarly_0 & (cam_a_0_bits_corrupt | cam_d_0_corrupt) | muxStateEarly_1
    & auto_in_a_bits_corrupt;	// Arbiter.scala:117:30, AtomicAutomata.scala:77:24, :78:24, :166:45, Mux.scala:27:72
  assign auto_out_d_ready = bundleOut_0_d_ready;	// AtomicAutomata.scala:236:35
endmodule

