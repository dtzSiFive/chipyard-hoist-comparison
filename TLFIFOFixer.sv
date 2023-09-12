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

module TLFIFOFixer(
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
                auto_out_6_a_ready,
                auto_out_6_b_valid,
  input  [1:0]  auto_out_6_b_bits_param,
  input  [2:0]  auto_out_6_b_bits_source,
  input  [31:0] auto_out_6_b_bits_address,
  input         auto_out_6_c_ready,
                auto_out_6_d_valid,
  input  [2:0]  auto_out_6_d_bits_opcode,
  input  [1:0]  auto_out_6_d_bits_param,
  input  [3:0]  auto_out_6_d_bits_size,
  input  [2:0]  auto_out_6_d_bits_source,
                auto_out_6_d_bits_sink,
  input         auto_out_6_d_bits_denied,
  input  [63:0] auto_out_6_d_bits_data,
  input         auto_out_6_d_bits_corrupt,
                auto_out_6_e_ready,
                auto_out_5_a_ready,
                auto_out_5_b_valid,
  input  [1:0]  auto_out_5_b_bits_param,
  input  [3:0]  auto_out_5_b_bits_source,
  input  [31:0] auto_out_5_b_bits_address,
  input         auto_out_5_c_ready,
                auto_out_5_d_valid,
  input  [2:0]  auto_out_5_d_bits_opcode,
  input  [1:0]  auto_out_5_d_bits_param,
  input  [3:0]  auto_out_5_d_bits_size,
                auto_out_5_d_bits_source,
  input  [2:0]  auto_out_5_d_bits_sink,
  input         auto_out_5_d_bits_denied,
  input  [63:0] auto_out_5_d_bits_data,
  input         auto_out_5_d_bits_corrupt,
                auto_out_5_e_ready,
                auto_out_4_a_ready,
                auto_out_4_b_valid,
  input  [1:0]  auto_out_4_b_bits_param,
  input  [4:0]  auto_out_4_b_bits_source,
  input  [31:0] auto_out_4_b_bits_address,
  input         auto_out_4_c_ready,
                auto_out_4_d_valid,
  input  [2:0]  auto_out_4_d_bits_opcode,
  input  [1:0]  auto_out_4_d_bits_param,
  input  [3:0]  auto_out_4_d_bits_size,
  input  [4:0]  auto_out_4_d_bits_source,
  input  [2:0]  auto_out_4_d_bits_sink,
  input         auto_out_4_d_bits_denied,
  input  [63:0] auto_out_4_d_bits_data,
  input         auto_out_4_d_bits_corrupt,
                auto_out_4_e_ready,
                auto_out_3_a_ready,
                auto_out_3_b_valid,
  input  [1:0]  auto_out_3_b_bits_param,
                auto_out_3_b_bits_source,
  input  [31:0] auto_out_3_b_bits_address,
  input         auto_out_3_c_ready,
                auto_out_3_d_valid,
  input  [2:0]  auto_out_3_d_bits_opcode,
  input  [1:0]  auto_out_3_d_bits_param,
  input  [3:0]  auto_out_3_d_bits_size,
  input  [1:0]  auto_out_3_d_bits_source,
  input  [2:0]  auto_out_3_d_bits_sink,
  input         auto_out_3_d_bits_denied,
  input  [63:0] auto_out_3_d_bits_data,
  input         auto_out_3_d_bits_corrupt,
                auto_out_3_e_ready,
                auto_out_2_a_ready,
                auto_out_2_b_valid,
  input  [1:0]  auto_out_2_b_bits_param,
                auto_out_2_b_bits_source,
  input  [31:0] auto_out_2_b_bits_address,
  input         auto_out_2_c_ready,
                auto_out_2_d_valid,
  input  [2:0]  auto_out_2_d_bits_opcode,
  input  [1:0]  auto_out_2_d_bits_param,
  input  [3:0]  auto_out_2_d_bits_size,
  input  [1:0]  auto_out_2_d_bits_source,
  input  [2:0]  auto_out_2_d_bits_sink,
  input         auto_out_2_d_bits_denied,
  input  [63:0] auto_out_2_d_bits_data,
  input         auto_out_2_d_bits_corrupt,
                auto_out_2_e_ready,
                auto_out_1_a_ready,
                auto_out_1_b_valid,
  input  [1:0]  auto_out_1_b_bits_param,
                auto_out_1_b_bits_source,
  input  [31:0] auto_out_1_b_bits_address,
  input         auto_out_1_c_ready,
                auto_out_1_d_valid,
  input  [2:0]  auto_out_1_d_bits_opcode,
  input  [1:0]  auto_out_1_d_bits_param,
  input  [3:0]  auto_out_1_d_bits_size,
  input  [1:0]  auto_out_1_d_bits_source,
  input  [2:0]  auto_out_1_d_bits_sink,
  input         auto_out_1_d_bits_denied,
  input  [63:0] auto_out_1_d_bits_data,
  input         auto_out_1_d_bits_corrupt,
                auto_out_1_e_ready,
                auto_out_0_a_ready,
                auto_out_0_d_valid,
  input  [2:0]  auto_out_0_d_bits_opcode,
  input  [1:0]  auto_out_0_d_bits_param,
  input  [3:0]  auto_out_0_d_bits_size,
  input  [2:0]  auto_out_0_d_bits_sink,
  input         auto_out_0_d_bits_denied,
  input  [63:0] auto_out_0_d_bits_data,
  input         auto_out_0_d_bits_corrupt,
  output        auto_in_6_a_ready,
                auto_in_6_b_valid,
  output [1:0]  auto_in_6_b_bits_param,
  output [2:0]  auto_in_6_b_bits_source,
  output [31:0] auto_in_6_b_bits_address,
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
  output [1:0]  auto_in_5_b_bits_param,
  output [3:0]  auto_in_5_b_bits_source,
  output [31:0] auto_in_5_b_bits_address,
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
  output [1:0]  auto_in_4_b_bits_param,
  output [4:0]  auto_in_4_b_bits_source,
  output [31:0] auto_in_4_b_bits_address,
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
  output [1:0]  auto_in_3_b_bits_param,
                auto_in_3_b_bits_source,
  output [31:0] auto_in_3_b_bits_address,
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
  output [1:0]  auto_in_2_b_bits_param,
                auto_in_2_b_bits_source,
  output [31:0] auto_in_2_b_bits_address,
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
  output [1:0]  auto_in_1_b_bits_param,
                auto_in_1_b_bits_source,
  output [31:0] auto_in_1_b_bits_address,
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
                auto_out_6_a_valid,
  output [2:0]  auto_out_6_a_bits_opcode,
                auto_out_6_a_bits_param,
  output [3:0]  auto_out_6_a_bits_size,
  output [2:0]  auto_out_6_a_bits_source,
  output [31:0] auto_out_6_a_bits_address,
  output [7:0]  auto_out_6_a_bits_mask,
  output [63:0] auto_out_6_a_bits_data,
  output        auto_out_6_a_bits_corrupt,
                auto_out_6_b_ready,
                auto_out_6_c_valid,
  output [2:0]  auto_out_6_c_bits_opcode,
                auto_out_6_c_bits_param,
  output [3:0]  auto_out_6_c_bits_size,
  output [2:0]  auto_out_6_c_bits_source,
  output [31:0] auto_out_6_c_bits_address,
  output [63:0] auto_out_6_c_bits_data,
  output        auto_out_6_c_bits_corrupt,
                auto_out_6_d_ready,
                auto_out_6_e_valid,
  output [2:0]  auto_out_6_e_bits_sink,
  output        auto_out_5_a_valid,
  output [2:0]  auto_out_5_a_bits_opcode,
                auto_out_5_a_bits_param,
  output [3:0]  auto_out_5_a_bits_size,
                auto_out_5_a_bits_source,
  output [31:0] auto_out_5_a_bits_address,
  output [7:0]  auto_out_5_a_bits_mask,
  output [63:0] auto_out_5_a_bits_data,
  output        auto_out_5_a_bits_corrupt,
                auto_out_5_b_ready,
                auto_out_5_c_valid,
  output [2:0]  auto_out_5_c_bits_opcode,
                auto_out_5_c_bits_param,
  output [3:0]  auto_out_5_c_bits_size,
                auto_out_5_c_bits_source,
  output [31:0] auto_out_5_c_bits_address,
  output [63:0] auto_out_5_c_bits_data,
  output        auto_out_5_c_bits_corrupt,
                auto_out_5_d_ready,
                auto_out_5_e_valid,
  output [2:0]  auto_out_5_e_bits_sink,
  output        auto_out_4_a_valid,
  output [2:0]  auto_out_4_a_bits_opcode,
                auto_out_4_a_bits_param,
  output [3:0]  auto_out_4_a_bits_size,
  output [4:0]  auto_out_4_a_bits_source,
  output [31:0] auto_out_4_a_bits_address,
  output [7:0]  auto_out_4_a_bits_mask,
  output [63:0] auto_out_4_a_bits_data,
  output        auto_out_4_a_bits_corrupt,
                auto_out_4_b_ready,
                auto_out_4_c_valid,
  output [2:0]  auto_out_4_c_bits_opcode,
                auto_out_4_c_bits_param,
  output [3:0]  auto_out_4_c_bits_size,
  output [4:0]  auto_out_4_c_bits_source,
  output [31:0] auto_out_4_c_bits_address,
  output [63:0] auto_out_4_c_bits_data,
  output        auto_out_4_c_bits_corrupt,
                auto_out_4_d_ready,
                auto_out_4_e_valid,
  output [2:0]  auto_out_4_e_bits_sink,
  output        auto_out_3_a_valid,
  output [2:0]  auto_out_3_a_bits_opcode,
                auto_out_3_a_bits_param,
  output [3:0]  auto_out_3_a_bits_size,
  output [1:0]  auto_out_3_a_bits_source,
  output [31:0] auto_out_3_a_bits_address,
  output [7:0]  auto_out_3_a_bits_mask,
  output [63:0] auto_out_3_a_bits_data,
  output        auto_out_3_a_bits_corrupt,
                auto_out_3_b_ready,
                auto_out_3_c_valid,
  output [2:0]  auto_out_3_c_bits_opcode,
                auto_out_3_c_bits_param,
  output [3:0]  auto_out_3_c_bits_size,
  output [1:0]  auto_out_3_c_bits_source,
  output [31:0] auto_out_3_c_bits_address,
  output [63:0] auto_out_3_c_bits_data,
  output        auto_out_3_c_bits_corrupt,
                auto_out_3_d_ready,
                auto_out_3_e_valid,
  output [2:0]  auto_out_3_e_bits_sink,
  output        auto_out_2_a_valid,
  output [2:0]  auto_out_2_a_bits_opcode,
                auto_out_2_a_bits_param,
  output [3:0]  auto_out_2_a_bits_size,
  output [1:0]  auto_out_2_a_bits_source,
  output [31:0] auto_out_2_a_bits_address,
  output [7:0]  auto_out_2_a_bits_mask,
  output [63:0] auto_out_2_a_bits_data,
  output        auto_out_2_a_bits_corrupt,
                auto_out_2_b_ready,
                auto_out_2_c_valid,
  output [2:0]  auto_out_2_c_bits_opcode,
                auto_out_2_c_bits_param,
  output [3:0]  auto_out_2_c_bits_size,
  output [1:0]  auto_out_2_c_bits_source,
  output [31:0] auto_out_2_c_bits_address,
  output [63:0] auto_out_2_c_bits_data,
  output        auto_out_2_c_bits_corrupt,
                auto_out_2_d_ready,
                auto_out_2_e_valid,
  output [2:0]  auto_out_2_e_bits_sink,
  output        auto_out_1_a_valid,
  output [2:0]  auto_out_1_a_bits_opcode,
                auto_out_1_a_bits_param,
  output [3:0]  auto_out_1_a_bits_size,
  output [1:0]  auto_out_1_a_bits_source,
  output [31:0] auto_out_1_a_bits_address,
  output [7:0]  auto_out_1_a_bits_mask,
  output [63:0] auto_out_1_a_bits_data,
  output        auto_out_1_a_bits_corrupt,
                auto_out_1_b_ready,
                auto_out_1_c_valid,
  output [2:0]  auto_out_1_c_bits_opcode,
                auto_out_1_c_bits_param,
  output [3:0]  auto_out_1_c_bits_size,
  output [1:0]  auto_out_1_c_bits_source,
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
  output        auto_out_0_a_bits_source,
  output [31:0] auto_out_0_a_bits_address,
  output [7:0]  auto_out_0_a_bits_mask,
  output [63:0] auto_out_0_a_bits_data,
  output        auto_out_0_a_bits_corrupt,
                auto_out_0_d_ready
);

  TLMonitor_7 monitor (	// Nodes.scala:24:25
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (auto_out_0_a_ready),
    .io_in_a_valid        (auto_in_0_a_valid),
    .io_in_a_bits_opcode  (auto_in_0_a_bits_opcode),
    .io_in_a_bits_param   (auto_in_0_a_bits_param),
    .io_in_a_bits_size    (auto_in_0_a_bits_size),
    .io_in_a_bits_source  (auto_in_0_a_bits_source),
    .io_in_a_bits_address (auto_in_0_a_bits_address),
    .io_in_a_bits_mask    (auto_in_0_a_bits_mask),
    .io_in_a_bits_corrupt (auto_in_0_a_bits_corrupt),
    .io_in_d_ready        (auto_in_0_d_ready),
    .io_in_d_valid        (auto_out_0_d_valid),
    .io_in_d_bits_opcode  (auto_out_0_d_bits_opcode),
    .io_in_d_bits_param   (auto_out_0_d_bits_param),
    .io_in_d_bits_size    (auto_out_0_d_bits_size),
    .io_in_d_bits_sink    (auto_out_0_d_bits_sink),
    .io_in_d_bits_denied  (auto_out_0_d_bits_denied),
    .io_in_d_bits_corrupt (auto_out_0_d_bits_corrupt)
  );
  TLMonitor_8 monitor_1 (	// Nodes.scala:24:25
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (auto_out_1_a_ready),
    .io_in_a_valid        (auto_in_1_a_valid),
    .io_in_a_bits_opcode  (auto_in_1_a_bits_opcode),
    .io_in_a_bits_param   (auto_in_1_a_bits_param),
    .io_in_a_bits_size    (auto_in_1_a_bits_size),
    .io_in_a_bits_source  (auto_in_1_a_bits_source),
    .io_in_a_bits_address (auto_in_1_a_bits_address),
    .io_in_a_bits_mask    (auto_in_1_a_bits_mask),
    .io_in_a_bits_corrupt (auto_in_1_a_bits_corrupt),
    .io_in_b_ready        (auto_in_1_b_ready),
    .io_in_b_valid        (auto_out_1_b_valid),
    .io_in_b_bits_param   (auto_out_1_b_bits_param),
    .io_in_b_bits_source  (auto_out_1_b_bits_source),
    .io_in_b_bits_address (auto_out_1_b_bits_address),
    .io_in_c_ready        (auto_out_1_c_ready),
    .io_in_c_valid        (auto_in_1_c_valid),
    .io_in_c_bits_opcode  (auto_in_1_c_bits_opcode),
    .io_in_c_bits_param   (auto_in_1_c_bits_param),
    .io_in_c_bits_size    (auto_in_1_c_bits_size),
    .io_in_c_bits_source  (auto_in_1_c_bits_source),
    .io_in_c_bits_address (auto_in_1_c_bits_address),
    .io_in_c_bits_corrupt (auto_in_1_c_bits_corrupt),
    .io_in_d_ready        (auto_in_1_d_ready),
    .io_in_d_valid        (auto_out_1_d_valid),
    .io_in_d_bits_opcode  (auto_out_1_d_bits_opcode),
    .io_in_d_bits_param   (auto_out_1_d_bits_param),
    .io_in_d_bits_size    (auto_out_1_d_bits_size),
    .io_in_d_bits_source  (auto_out_1_d_bits_source),
    .io_in_d_bits_sink    (auto_out_1_d_bits_sink),
    .io_in_d_bits_denied  (auto_out_1_d_bits_denied),
    .io_in_d_bits_corrupt (auto_out_1_d_bits_corrupt),
    .io_in_e_ready        (auto_out_1_e_ready),
    .io_in_e_valid        (auto_in_1_e_valid),
    .io_in_e_bits_sink    (auto_in_1_e_bits_sink)
  );
  TLMonitor_8 monitor_2 (	// Nodes.scala:24:25
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (auto_out_2_a_ready),
    .io_in_a_valid        (auto_in_2_a_valid),
    .io_in_a_bits_opcode  (auto_in_2_a_bits_opcode),
    .io_in_a_bits_param   (auto_in_2_a_bits_param),
    .io_in_a_bits_size    (auto_in_2_a_bits_size),
    .io_in_a_bits_source  (auto_in_2_a_bits_source),
    .io_in_a_bits_address (auto_in_2_a_bits_address),
    .io_in_a_bits_mask    (auto_in_2_a_bits_mask),
    .io_in_a_bits_corrupt (auto_in_2_a_bits_corrupt),
    .io_in_b_ready        (auto_in_2_b_ready),
    .io_in_b_valid        (auto_out_2_b_valid),
    .io_in_b_bits_param   (auto_out_2_b_bits_param),
    .io_in_b_bits_source  (auto_out_2_b_bits_source),
    .io_in_b_bits_address (auto_out_2_b_bits_address),
    .io_in_c_ready        (auto_out_2_c_ready),
    .io_in_c_valid        (auto_in_2_c_valid),
    .io_in_c_bits_opcode  (auto_in_2_c_bits_opcode),
    .io_in_c_bits_param   (auto_in_2_c_bits_param),
    .io_in_c_bits_size    (auto_in_2_c_bits_size),
    .io_in_c_bits_source  (auto_in_2_c_bits_source),
    .io_in_c_bits_address (auto_in_2_c_bits_address),
    .io_in_c_bits_corrupt (auto_in_2_c_bits_corrupt),
    .io_in_d_ready        (auto_in_2_d_ready),
    .io_in_d_valid        (auto_out_2_d_valid),
    .io_in_d_bits_opcode  (auto_out_2_d_bits_opcode),
    .io_in_d_bits_param   (auto_out_2_d_bits_param),
    .io_in_d_bits_size    (auto_out_2_d_bits_size),
    .io_in_d_bits_source  (auto_out_2_d_bits_source),
    .io_in_d_bits_sink    (auto_out_2_d_bits_sink),
    .io_in_d_bits_denied  (auto_out_2_d_bits_denied),
    .io_in_d_bits_corrupt (auto_out_2_d_bits_corrupt),
    .io_in_e_ready        (auto_out_2_e_ready),
    .io_in_e_valid        (auto_in_2_e_valid),
    .io_in_e_bits_sink    (auto_in_2_e_bits_sink)
  );
  TLMonitor_8 monitor_3 (	// Nodes.scala:24:25
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (auto_out_3_a_ready),
    .io_in_a_valid        (auto_in_3_a_valid),
    .io_in_a_bits_opcode  (auto_in_3_a_bits_opcode),
    .io_in_a_bits_param   (auto_in_3_a_bits_param),
    .io_in_a_bits_size    (auto_in_3_a_bits_size),
    .io_in_a_bits_source  (auto_in_3_a_bits_source),
    .io_in_a_bits_address (auto_in_3_a_bits_address),
    .io_in_a_bits_mask    (auto_in_3_a_bits_mask),
    .io_in_a_bits_corrupt (auto_in_3_a_bits_corrupt),
    .io_in_b_ready        (auto_in_3_b_ready),
    .io_in_b_valid        (auto_out_3_b_valid),
    .io_in_b_bits_param   (auto_out_3_b_bits_param),
    .io_in_b_bits_source  (auto_out_3_b_bits_source),
    .io_in_b_bits_address (auto_out_3_b_bits_address),
    .io_in_c_ready        (auto_out_3_c_ready),
    .io_in_c_valid        (auto_in_3_c_valid),
    .io_in_c_bits_opcode  (auto_in_3_c_bits_opcode),
    .io_in_c_bits_param   (auto_in_3_c_bits_param),
    .io_in_c_bits_size    (auto_in_3_c_bits_size),
    .io_in_c_bits_source  (auto_in_3_c_bits_source),
    .io_in_c_bits_address (auto_in_3_c_bits_address),
    .io_in_c_bits_corrupt (auto_in_3_c_bits_corrupt),
    .io_in_d_ready        (auto_in_3_d_ready),
    .io_in_d_valid        (auto_out_3_d_valid),
    .io_in_d_bits_opcode  (auto_out_3_d_bits_opcode),
    .io_in_d_bits_param   (auto_out_3_d_bits_param),
    .io_in_d_bits_size    (auto_out_3_d_bits_size),
    .io_in_d_bits_source  (auto_out_3_d_bits_source),
    .io_in_d_bits_sink    (auto_out_3_d_bits_sink),
    .io_in_d_bits_denied  (auto_out_3_d_bits_denied),
    .io_in_d_bits_corrupt (auto_out_3_d_bits_corrupt),
    .io_in_e_ready        (auto_out_3_e_ready),
    .io_in_e_valid        (auto_in_3_e_valid),
    .io_in_e_bits_sink    (auto_in_3_e_bits_sink)
  );
  TLMonitor_11 monitor_4 (	// Nodes.scala:24:25
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (auto_out_4_a_ready),
    .io_in_a_valid        (auto_in_4_a_valid),
    .io_in_a_bits_opcode  (auto_in_4_a_bits_opcode),
    .io_in_a_bits_param   (auto_in_4_a_bits_param),
    .io_in_a_bits_size    (auto_in_4_a_bits_size),
    .io_in_a_bits_source  (auto_in_4_a_bits_source),
    .io_in_a_bits_address (auto_in_4_a_bits_address),
    .io_in_a_bits_mask    (auto_in_4_a_bits_mask),
    .io_in_a_bits_corrupt (auto_in_4_a_bits_corrupt),
    .io_in_b_ready        (auto_in_4_b_ready),
    .io_in_b_valid        (auto_out_4_b_valid),
    .io_in_b_bits_param   (auto_out_4_b_bits_param),
    .io_in_b_bits_source  (auto_out_4_b_bits_source),
    .io_in_b_bits_address (auto_out_4_b_bits_address),
    .io_in_c_ready        (auto_out_4_c_ready),
    .io_in_c_valid        (auto_in_4_c_valid),
    .io_in_c_bits_opcode  (auto_in_4_c_bits_opcode),
    .io_in_c_bits_param   (auto_in_4_c_bits_param),
    .io_in_c_bits_size    (auto_in_4_c_bits_size),
    .io_in_c_bits_source  (auto_in_4_c_bits_source),
    .io_in_c_bits_address (auto_in_4_c_bits_address),
    .io_in_c_bits_corrupt (auto_in_4_c_bits_corrupt),
    .io_in_d_ready        (auto_in_4_d_ready),
    .io_in_d_valid        (auto_out_4_d_valid),
    .io_in_d_bits_opcode  (auto_out_4_d_bits_opcode),
    .io_in_d_bits_param   (auto_out_4_d_bits_param),
    .io_in_d_bits_size    (auto_out_4_d_bits_size),
    .io_in_d_bits_source  (auto_out_4_d_bits_source),
    .io_in_d_bits_sink    (auto_out_4_d_bits_sink),
    .io_in_d_bits_denied  (auto_out_4_d_bits_denied),
    .io_in_d_bits_corrupt (auto_out_4_d_bits_corrupt),
    .io_in_e_ready        (auto_out_4_e_ready),
    .io_in_e_valid        (auto_in_4_e_valid),
    .io_in_e_bits_sink    (auto_in_4_e_bits_sink)
  );
  TLMonitor_12 monitor_5 (	// Nodes.scala:24:25
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (auto_out_5_a_ready),
    .io_in_a_valid        (auto_in_5_a_valid),
    .io_in_a_bits_opcode  (auto_in_5_a_bits_opcode),
    .io_in_a_bits_param   (auto_in_5_a_bits_param),
    .io_in_a_bits_size    (auto_in_5_a_bits_size),
    .io_in_a_bits_source  (auto_in_5_a_bits_source),
    .io_in_a_bits_address (auto_in_5_a_bits_address),
    .io_in_a_bits_mask    (auto_in_5_a_bits_mask),
    .io_in_a_bits_corrupt (auto_in_5_a_bits_corrupt),
    .io_in_b_ready        (auto_in_5_b_ready),
    .io_in_b_valid        (auto_out_5_b_valid),
    .io_in_b_bits_param   (auto_out_5_b_bits_param),
    .io_in_b_bits_source  (auto_out_5_b_bits_source),
    .io_in_b_bits_address (auto_out_5_b_bits_address),
    .io_in_c_ready        (auto_out_5_c_ready),
    .io_in_c_valid        (auto_in_5_c_valid),
    .io_in_c_bits_opcode  (auto_in_5_c_bits_opcode),
    .io_in_c_bits_param   (auto_in_5_c_bits_param),
    .io_in_c_bits_size    (auto_in_5_c_bits_size),
    .io_in_c_bits_source  (auto_in_5_c_bits_source),
    .io_in_c_bits_address (auto_in_5_c_bits_address),
    .io_in_c_bits_corrupt (auto_in_5_c_bits_corrupt),
    .io_in_d_ready        (auto_in_5_d_ready),
    .io_in_d_valid        (auto_out_5_d_valid),
    .io_in_d_bits_opcode  (auto_out_5_d_bits_opcode),
    .io_in_d_bits_param   (auto_out_5_d_bits_param),
    .io_in_d_bits_size    (auto_out_5_d_bits_size),
    .io_in_d_bits_source  (auto_out_5_d_bits_source),
    .io_in_d_bits_sink    (auto_out_5_d_bits_sink),
    .io_in_d_bits_denied  (auto_out_5_d_bits_denied),
    .io_in_d_bits_corrupt (auto_out_5_d_bits_corrupt),
    .io_in_e_ready        (auto_out_5_e_ready),
    .io_in_e_valid        (auto_in_5_e_valid),
    .io_in_e_bits_sink    (auto_in_5_e_bits_sink)
  );
  TLMonitor_13 monitor_6 (	// Nodes.scala:24:25
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (auto_out_6_a_ready),
    .io_in_a_valid        (auto_in_6_a_valid),
    .io_in_a_bits_opcode  (auto_in_6_a_bits_opcode),
    .io_in_a_bits_param   (auto_in_6_a_bits_param),
    .io_in_a_bits_size    (auto_in_6_a_bits_size),
    .io_in_a_bits_source  (auto_in_6_a_bits_source),
    .io_in_a_bits_address (auto_in_6_a_bits_address),
    .io_in_a_bits_mask    (auto_in_6_a_bits_mask),
    .io_in_a_bits_corrupt (auto_in_6_a_bits_corrupt),
    .io_in_b_ready        (auto_in_6_b_ready),
    .io_in_b_valid        (auto_out_6_b_valid),
    .io_in_b_bits_param   (auto_out_6_b_bits_param),
    .io_in_b_bits_source  (auto_out_6_b_bits_source),
    .io_in_b_bits_address (auto_out_6_b_bits_address),
    .io_in_c_ready        (auto_out_6_c_ready),
    .io_in_c_valid        (auto_in_6_c_valid),
    .io_in_c_bits_opcode  (auto_in_6_c_bits_opcode),
    .io_in_c_bits_param   (auto_in_6_c_bits_param),
    .io_in_c_bits_size    (auto_in_6_c_bits_size),
    .io_in_c_bits_source  (auto_in_6_c_bits_source),
    .io_in_c_bits_address (auto_in_6_c_bits_address),
    .io_in_c_bits_corrupt (auto_in_6_c_bits_corrupt),
    .io_in_d_ready        (auto_in_6_d_ready),
    .io_in_d_valid        (auto_out_6_d_valid),
    .io_in_d_bits_opcode  (auto_out_6_d_bits_opcode),
    .io_in_d_bits_param   (auto_out_6_d_bits_param),
    .io_in_d_bits_size    (auto_out_6_d_bits_size),
    .io_in_d_bits_source  (auto_out_6_d_bits_source),
    .io_in_d_bits_sink    (auto_out_6_d_bits_sink),
    .io_in_d_bits_denied  (auto_out_6_d_bits_denied),
    .io_in_d_bits_corrupt (auto_out_6_d_bits_corrupt),
    .io_in_e_ready        (auto_out_6_e_ready),
    .io_in_e_valid        (auto_in_6_e_valid),
    .io_in_e_bits_sink    (auto_in_6_e_bits_sink)
  );
  assign auto_in_6_a_ready = auto_out_6_a_ready;
  assign auto_in_6_b_valid = auto_out_6_b_valid;
  assign auto_in_6_b_bits_param = auto_out_6_b_bits_param;
  assign auto_in_6_b_bits_source = auto_out_6_b_bits_source;
  assign auto_in_6_b_bits_address = auto_out_6_b_bits_address;
  assign auto_in_6_c_ready = auto_out_6_c_ready;
  assign auto_in_6_d_valid = auto_out_6_d_valid;
  assign auto_in_6_d_bits_opcode = auto_out_6_d_bits_opcode;
  assign auto_in_6_d_bits_param = auto_out_6_d_bits_param;
  assign auto_in_6_d_bits_size = auto_out_6_d_bits_size;
  assign auto_in_6_d_bits_source = auto_out_6_d_bits_source;
  assign auto_in_6_d_bits_sink = auto_out_6_d_bits_sink;
  assign auto_in_6_d_bits_denied = auto_out_6_d_bits_denied;
  assign auto_in_6_d_bits_data = auto_out_6_d_bits_data;
  assign auto_in_6_d_bits_corrupt = auto_out_6_d_bits_corrupt;
  assign auto_in_6_e_ready = auto_out_6_e_ready;
  assign auto_in_5_a_ready = auto_out_5_a_ready;
  assign auto_in_5_b_valid = auto_out_5_b_valid;
  assign auto_in_5_b_bits_param = auto_out_5_b_bits_param;
  assign auto_in_5_b_bits_source = auto_out_5_b_bits_source;
  assign auto_in_5_b_bits_address = auto_out_5_b_bits_address;
  assign auto_in_5_c_ready = auto_out_5_c_ready;
  assign auto_in_5_d_valid = auto_out_5_d_valid;
  assign auto_in_5_d_bits_opcode = auto_out_5_d_bits_opcode;
  assign auto_in_5_d_bits_param = auto_out_5_d_bits_param;
  assign auto_in_5_d_bits_size = auto_out_5_d_bits_size;
  assign auto_in_5_d_bits_source = auto_out_5_d_bits_source;
  assign auto_in_5_d_bits_sink = auto_out_5_d_bits_sink;
  assign auto_in_5_d_bits_denied = auto_out_5_d_bits_denied;
  assign auto_in_5_d_bits_data = auto_out_5_d_bits_data;
  assign auto_in_5_d_bits_corrupt = auto_out_5_d_bits_corrupt;
  assign auto_in_5_e_ready = auto_out_5_e_ready;
  assign auto_in_4_a_ready = auto_out_4_a_ready;
  assign auto_in_4_b_valid = auto_out_4_b_valid;
  assign auto_in_4_b_bits_param = auto_out_4_b_bits_param;
  assign auto_in_4_b_bits_source = auto_out_4_b_bits_source;
  assign auto_in_4_b_bits_address = auto_out_4_b_bits_address;
  assign auto_in_4_c_ready = auto_out_4_c_ready;
  assign auto_in_4_d_valid = auto_out_4_d_valid;
  assign auto_in_4_d_bits_opcode = auto_out_4_d_bits_opcode;
  assign auto_in_4_d_bits_param = auto_out_4_d_bits_param;
  assign auto_in_4_d_bits_size = auto_out_4_d_bits_size;
  assign auto_in_4_d_bits_source = auto_out_4_d_bits_source;
  assign auto_in_4_d_bits_sink = auto_out_4_d_bits_sink;
  assign auto_in_4_d_bits_denied = auto_out_4_d_bits_denied;
  assign auto_in_4_d_bits_data = auto_out_4_d_bits_data;
  assign auto_in_4_d_bits_corrupt = auto_out_4_d_bits_corrupt;
  assign auto_in_4_e_ready = auto_out_4_e_ready;
  assign auto_in_3_a_ready = auto_out_3_a_ready;
  assign auto_in_3_b_valid = auto_out_3_b_valid;
  assign auto_in_3_b_bits_param = auto_out_3_b_bits_param;
  assign auto_in_3_b_bits_source = auto_out_3_b_bits_source;
  assign auto_in_3_b_bits_address = auto_out_3_b_bits_address;
  assign auto_in_3_c_ready = auto_out_3_c_ready;
  assign auto_in_3_d_valid = auto_out_3_d_valid;
  assign auto_in_3_d_bits_opcode = auto_out_3_d_bits_opcode;
  assign auto_in_3_d_bits_param = auto_out_3_d_bits_param;
  assign auto_in_3_d_bits_size = auto_out_3_d_bits_size;
  assign auto_in_3_d_bits_source = auto_out_3_d_bits_source;
  assign auto_in_3_d_bits_sink = auto_out_3_d_bits_sink;
  assign auto_in_3_d_bits_denied = auto_out_3_d_bits_denied;
  assign auto_in_3_d_bits_data = auto_out_3_d_bits_data;
  assign auto_in_3_d_bits_corrupt = auto_out_3_d_bits_corrupt;
  assign auto_in_3_e_ready = auto_out_3_e_ready;
  assign auto_in_2_a_ready = auto_out_2_a_ready;
  assign auto_in_2_b_valid = auto_out_2_b_valid;
  assign auto_in_2_b_bits_param = auto_out_2_b_bits_param;
  assign auto_in_2_b_bits_source = auto_out_2_b_bits_source;
  assign auto_in_2_b_bits_address = auto_out_2_b_bits_address;
  assign auto_in_2_c_ready = auto_out_2_c_ready;
  assign auto_in_2_d_valid = auto_out_2_d_valid;
  assign auto_in_2_d_bits_opcode = auto_out_2_d_bits_opcode;
  assign auto_in_2_d_bits_param = auto_out_2_d_bits_param;
  assign auto_in_2_d_bits_size = auto_out_2_d_bits_size;
  assign auto_in_2_d_bits_source = auto_out_2_d_bits_source;
  assign auto_in_2_d_bits_sink = auto_out_2_d_bits_sink;
  assign auto_in_2_d_bits_denied = auto_out_2_d_bits_denied;
  assign auto_in_2_d_bits_data = auto_out_2_d_bits_data;
  assign auto_in_2_d_bits_corrupt = auto_out_2_d_bits_corrupt;
  assign auto_in_2_e_ready = auto_out_2_e_ready;
  assign auto_in_1_a_ready = auto_out_1_a_ready;
  assign auto_in_1_b_valid = auto_out_1_b_valid;
  assign auto_in_1_b_bits_param = auto_out_1_b_bits_param;
  assign auto_in_1_b_bits_source = auto_out_1_b_bits_source;
  assign auto_in_1_b_bits_address = auto_out_1_b_bits_address;
  assign auto_in_1_c_ready = auto_out_1_c_ready;
  assign auto_in_1_d_valid = auto_out_1_d_valid;
  assign auto_in_1_d_bits_opcode = auto_out_1_d_bits_opcode;
  assign auto_in_1_d_bits_param = auto_out_1_d_bits_param;
  assign auto_in_1_d_bits_size = auto_out_1_d_bits_size;
  assign auto_in_1_d_bits_source = auto_out_1_d_bits_source;
  assign auto_in_1_d_bits_sink = auto_out_1_d_bits_sink;
  assign auto_in_1_d_bits_denied = auto_out_1_d_bits_denied;
  assign auto_in_1_d_bits_data = auto_out_1_d_bits_data;
  assign auto_in_1_d_bits_corrupt = auto_out_1_d_bits_corrupt;
  assign auto_in_1_e_ready = auto_out_1_e_ready;
  assign auto_in_0_a_ready = auto_out_0_a_ready;
  assign auto_in_0_d_valid = auto_out_0_d_valid;
  assign auto_in_0_d_bits_opcode = auto_out_0_d_bits_opcode;
  assign auto_in_0_d_bits_param = auto_out_0_d_bits_param;
  assign auto_in_0_d_bits_size = auto_out_0_d_bits_size;
  assign auto_in_0_d_bits_sink = auto_out_0_d_bits_sink;
  assign auto_in_0_d_bits_denied = auto_out_0_d_bits_denied;
  assign auto_in_0_d_bits_data = auto_out_0_d_bits_data;
  assign auto_in_0_d_bits_corrupt = auto_out_0_d_bits_corrupt;
  assign auto_out_6_a_valid = auto_in_6_a_valid;
  assign auto_out_6_a_bits_opcode = auto_in_6_a_bits_opcode;
  assign auto_out_6_a_bits_param = auto_in_6_a_bits_param;
  assign auto_out_6_a_bits_size = auto_in_6_a_bits_size;
  assign auto_out_6_a_bits_source = auto_in_6_a_bits_source;
  assign auto_out_6_a_bits_address = auto_in_6_a_bits_address;
  assign auto_out_6_a_bits_mask = auto_in_6_a_bits_mask;
  assign auto_out_6_a_bits_data = auto_in_6_a_bits_data;
  assign auto_out_6_a_bits_corrupt = auto_in_6_a_bits_corrupt;
  assign auto_out_6_b_ready = auto_in_6_b_ready;
  assign auto_out_6_c_valid = auto_in_6_c_valid;
  assign auto_out_6_c_bits_opcode = auto_in_6_c_bits_opcode;
  assign auto_out_6_c_bits_param = auto_in_6_c_bits_param;
  assign auto_out_6_c_bits_size = auto_in_6_c_bits_size;
  assign auto_out_6_c_bits_source = auto_in_6_c_bits_source;
  assign auto_out_6_c_bits_address = auto_in_6_c_bits_address;
  assign auto_out_6_c_bits_data = auto_in_6_c_bits_data;
  assign auto_out_6_c_bits_corrupt = auto_in_6_c_bits_corrupt;
  assign auto_out_6_d_ready = auto_in_6_d_ready;
  assign auto_out_6_e_valid = auto_in_6_e_valid;
  assign auto_out_6_e_bits_sink = auto_in_6_e_bits_sink;
  assign auto_out_5_a_valid = auto_in_5_a_valid;
  assign auto_out_5_a_bits_opcode = auto_in_5_a_bits_opcode;
  assign auto_out_5_a_bits_param = auto_in_5_a_bits_param;
  assign auto_out_5_a_bits_size = auto_in_5_a_bits_size;
  assign auto_out_5_a_bits_source = auto_in_5_a_bits_source;
  assign auto_out_5_a_bits_address = auto_in_5_a_bits_address;
  assign auto_out_5_a_bits_mask = auto_in_5_a_bits_mask;
  assign auto_out_5_a_bits_data = auto_in_5_a_bits_data;
  assign auto_out_5_a_bits_corrupt = auto_in_5_a_bits_corrupt;
  assign auto_out_5_b_ready = auto_in_5_b_ready;
  assign auto_out_5_c_valid = auto_in_5_c_valid;
  assign auto_out_5_c_bits_opcode = auto_in_5_c_bits_opcode;
  assign auto_out_5_c_bits_param = auto_in_5_c_bits_param;
  assign auto_out_5_c_bits_size = auto_in_5_c_bits_size;
  assign auto_out_5_c_bits_source = auto_in_5_c_bits_source;
  assign auto_out_5_c_bits_address = auto_in_5_c_bits_address;
  assign auto_out_5_c_bits_data = auto_in_5_c_bits_data;
  assign auto_out_5_c_bits_corrupt = auto_in_5_c_bits_corrupt;
  assign auto_out_5_d_ready = auto_in_5_d_ready;
  assign auto_out_5_e_valid = auto_in_5_e_valid;
  assign auto_out_5_e_bits_sink = auto_in_5_e_bits_sink;
  assign auto_out_4_a_valid = auto_in_4_a_valid;
  assign auto_out_4_a_bits_opcode = auto_in_4_a_bits_opcode;
  assign auto_out_4_a_bits_param = auto_in_4_a_bits_param;
  assign auto_out_4_a_bits_size = auto_in_4_a_bits_size;
  assign auto_out_4_a_bits_source = auto_in_4_a_bits_source;
  assign auto_out_4_a_bits_address = auto_in_4_a_bits_address;
  assign auto_out_4_a_bits_mask = auto_in_4_a_bits_mask;
  assign auto_out_4_a_bits_data = auto_in_4_a_bits_data;
  assign auto_out_4_a_bits_corrupt = auto_in_4_a_bits_corrupt;
  assign auto_out_4_b_ready = auto_in_4_b_ready;
  assign auto_out_4_c_valid = auto_in_4_c_valid;
  assign auto_out_4_c_bits_opcode = auto_in_4_c_bits_opcode;
  assign auto_out_4_c_bits_param = auto_in_4_c_bits_param;
  assign auto_out_4_c_bits_size = auto_in_4_c_bits_size;
  assign auto_out_4_c_bits_source = auto_in_4_c_bits_source;
  assign auto_out_4_c_bits_address = auto_in_4_c_bits_address;
  assign auto_out_4_c_bits_data = auto_in_4_c_bits_data;
  assign auto_out_4_c_bits_corrupt = auto_in_4_c_bits_corrupt;
  assign auto_out_4_d_ready = auto_in_4_d_ready;
  assign auto_out_4_e_valid = auto_in_4_e_valid;
  assign auto_out_4_e_bits_sink = auto_in_4_e_bits_sink;
  assign auto_out_3_a_valid = auto_in_3_a_valid;
  assign auto_out_3_a_bits_opcode = auto_in_3_a_bits_opcode;
  assign auto_out_3_a_bits_param = auto_in_3_a_bits_param;
  assign auto_out_3_a_bits_size = auto_in_3_a_bits_size;
  assign auto_out_3_a_bits_source = auto_in_3_a_bits_source;
  assign auto_out_3_a_bits_address = auto_in_3_a_bits_address;
  assign auto_out_3_a_bits_mask = auto_in_3_a_bits_mask;
  assign auto_out_3_a_bits_data = auto_in_3_a_bits_data;
  assign auto_out_3_a_bits_corrupt = auto_in_3_a_bits_corrupt;
  assign auto_out_3_b_ready = auto_in_3_b_ready;
  assign auto_out_3_c_valid = auto_in_3_c_valid;
  assign auto_out_3_c_bits_opcode = auto_in_3_c_bits_opcode;
  assign auto_out_3_c_bits_param = auto_in_3_c_bits_param;
  assign auto_out_3_c_bits_size = auto_in_3_c_bits_size;
  assign auto_out_3_c_bits_source = auto_in_3_c_bits_source;
  assign auto_out_3_c_bits_address = auto_in_3_c_bits_address;
  assign auto_out_3_c_bits_data = auto_in_3_c_bits_data;
  assign auto_out_3_c_bits_corrupt = auto_in_3_c_bits_corrupt;
  assign auto_out_3_d_ready = auto_in_3_d_ready;
  assign auto_out_3_e_valid = auto_in_3_e_valid;
  assign auto_out_3_e_bits_sink = auto_in_3_e_bits_sink;
  assign auto_out_2_a_valid = auto_in_2_a_valid;
  assign auto_out_2_a_bits_opcode = auto_in_2_a_bits_opcode;
  assign auto_out_2_a_bits_param = auto_in_2_a_bits_param;
  assign auto_out_2_a_bits_size = auto_in_2_a_bits_size;
  assign auto_out_2_a_bits_source = auto_in_2_a_bits_source;
  assign auto_out_2_a_bits_address = auto_in_2_a_bits_address;
  assign auto_out_2_a_bits_mask = auto_in_2_a_bits_mask;
  assign auto_out_2_a_bits_data = auto_in_2_a_bits_data;
  assign auto_out_2_a_bits_corrupt = auto_in_2_a_bits_corrupt;
  assign auto_out_2_b_ready = auto_in_2_b_ready;
  assign auto_out_2_c_valid = auto_in_2_c_valid;
  assign auto_out_2_c_bits_opcode = auto_in_2_c_bits_opcode;
  assign auto_out_2_c_bits_param = auto_in_2_c_bits_param;
  assign auto_out_2_c_bits_size = auto_in_2_c_bits_size;
  assign auto_out_2_c_bits_source = auto_in_2_c_bits_source;
  assign auto_out_2_c_bits_address = auto_in_2_c_bits_address;
  assign auto_out_2_c_bits_data = auto_in_2_c_bits_data;
  assign auto_out_2_c_bits_corrupt = auto_in_2_c_bits_corrupt;
  assign auto_out_2_d_ready = auto_in_2_d_ready;
  assign auto_out_2_e_valid = auto_in_2_e_valid;
  assign auto_out_2_e_bits_sink = auto_in_2_e_bits_sink;
  assign auto_out_1_a_valid = auto_in_1_a_valid;
  assign auto_out_1_a_bits_opcode = auto_in_1_a_bits_opcode;
  assign auto_out_1_a_bits_param = auto_in_1_a_bits_param;
  assign auto_out_1_a_bits_size = auto_in_1_a_bits_size;
  assign auto_out_1_a_bits_source = auto_in_1_a_bits_source;
  assign auto_out_1_a_bits_address = auto_in_1_a_bits_address;
  assign auto_out_1_a_bits_mask = auto_in_1_a_bits_mask;
  assign auto_out_1_a_bits_data = auto_in_1_a_bits_data;
  assign auto_out_1_a_bits_corrupt = auto_in_1_a_bits_corrupt;
  assign auto_out_1_b_ready = auto_in_1_b_ready;
  assign auto_out_1_c_valid = auto_in_1_c_valid;
  assign auto_out_1_c_bits_opcode = auto_in_1_c_bits_opcode;
  assign auto_out_1_c_bits_param = auto_in_1_c_bits_param;
  assign auto_out_1_c_bits_size = auto_in_1_c_bits_size;
  assign auto_out_1_c_bits_source = auto_in_1_c_bits_source;
  assign auto_out_1_c_bits_address = auto_in_1_c_bits_address;
  assign auto_out_1_c_bits_data = auto_in_1_c_bits_data;
  assign auto_out_1_c_bits_corrupt = auto_in_1_c_bits_corrupt;
  assign auto_out_1_d_ready = auto_in_1_d_ready;
  assign auto_out_1_e_valid = auto_in_1_e_valid;
  assign auto_out_1_e_bits_sink = auto_in_1_e_bits_sink;
  assign auto_out_0_a_valid = auto_in_0_a_valid;
  assign auto_out_0_a_bits_opcode = auto_in_0_a_bits_opcode;
  assign auto_out_0_a_bits_param = auto_in_0_a_bits_param;
  assign auto_out_0_a_bits_size = auto_in_0_a_bits_size;
  assign auto_out_0_a_bits_source = auto_in_0_a_bits_source;
  assign auto_out_0_a_bits_address = auto_in_0_a_bits_address;
  assign auto_out_0_a_bits_mask = auto_in_0_a_bits_mask;
  assign auto_out_0_a_bits_data = auto_in_0_a_bits_data;
  assign auto_out_0_a_bits_corrupt = auto_in_0_a_bits_corrupt;
  assign auto_out_0_d_ready = auto_in_0_d_ready;
endmodule

