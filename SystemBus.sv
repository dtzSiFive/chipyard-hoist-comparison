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

module SystemBus(
  input         auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_valid,
  input  [2:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_bits_opcode,
                auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_bits_param,
  input  [3:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_bits_size,
  input  [2:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_bits_source,
  input  [31:0] auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_bits_address,
  input  [7:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_bits_mask,
  input  [63:0] auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_bits_data,
  input         auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_bits_corrupt,
                auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_b_ready,
                auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_c_valid,
  input  [2:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_c_bits_opcode,
                auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_c_bits_param,
  input  [3:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_c_bits_size,
  input  [2:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_c_bits_source,
  input  [31:0] auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_c_bits_address,
  input  [63:0] auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_c_bits_data,
  input         auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_c_bits_corrupt,
                auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_ready,
                auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_e_valid,
  input  [2:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_e_bits_sink,
  input         auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_valid,
  input  [2:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_bits_opcode,
                auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_bits_param,
  input  [3:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_bits_size,
                auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_bits_source,
  input  [31:0] auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_bits_address,
  input  [7:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_bits_mask,
  input  [63:0] auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_bits_data,
  input         auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_bits_corrupt,
                auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_b_ready,
                auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_c_valid,
  input  [2:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_c_bits_opcode,
                auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_c_bits_param,
  input  [3:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_c_bits_size,
                auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_c_bits_source,
  input  [31:0] auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_c_bits_address,
  input  [63:0] auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_c_bits_data,
  input         auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_c_bits_corrupt,
                auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_ready,
                auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_e_valid,
  input  [2:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_e_bits_sink,
  input         auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_valid,
  input  [2:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_bits_opcode,
                auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_bits_param,
  input  [3:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_bits_size,
  input  [4:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_bits_source,
  input  [31:0] auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_bits_address,
  input  [7:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_bits_mask,
  input  [63:0] auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_bits_data,
  input         auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_bits_corrupt,
                auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_b_ready,
                auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_c_valid,
  input  [2:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_c_bits_opcode,
                auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_c_bits_param,
  input  [3:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_c_bits_size,
  input  [4:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_c_bits_source,
  input  [31:0] auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_c_bits_address,
  input  [63:0] auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_c_bits_data,
  input         auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_c_bits_corrupt,
                auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_ready,
                auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_e_valid,
  input  [2:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_e_bits_sink,
  input         auto_coupler_from_tile_tl_master_clock_xing_in_2_a_valid,
  input  [2:0]  auto_coupler_from_tile_tl_master_clock_xing_in_2_a_bits_opcode,
                auto_coupler_from_tile_tl_master_clock_xing_in_2_a_bits_param,
  input  [3:0]  auto_coupler_from_tile_tl_master_clock_xing_in_2_a_bits_size,
  input  [1:0]  auto_coupler_from_tile_tl_master_clock_xing_in_2_a_bits_source,
  input  [31:0] auto_coupler_from_tile_tl_master_clock_xing_in_2_a_bits_address,
  input  [7:0]  auto_coupler_from_tile_tl_master_clock_xing_in_2_a_bits_mask,
  input  [63:0] auto_coupler_from_tile_tl_master_clock_xing_in_2_a_bits_data,
  input         auto_coupler_from_tile_tl_master_clock_xing_in_2_a_bits_corrupt,
                auto_coupler_from_tile_tl_master_clock_xing_in_2_b_ready,
                auto_coupler_from_tile_tl_master_clock_xing_in_2_c_valid,
  input  [2:0]  auto_coupler_from_tile_tl_master_clock_xing_in_2_c_bits_opcode,
                auto_coupler_from_tile_tl_master_clock_xing_in_2_c_bits_param,
  input  [3:0]  auto_coupler_from_tile_tl_master_clock_xing_in_2_c_bits_size,
  input  [1:0]  auto_coupler_from_tile_tl_master_clock_xing_in_2_c_bits_source,
  input  [31:0] auto_coupler_from_tile_tl_master_clock_xing_in_2_c_bits_address,
  input  [63:0] auto_coupler_from_tile_tl_master_clock_xing_in_2_c_bits_data,
  input         auto_coupler_from_tile_tl_master_clock_xing_in_2_c_bits_corrupt,
                auto_coupler_from_tile_tl_master_clock_xing_in_2_d_ready,
                auto_coupler_from_tile_tl_master_clock_xing_in_2_e_valid,
  input  [2:0]  auto_coupler_from_tile_tl_master_clock_xing_in_2_e_bits_sink,
  input         auto_coupler_from_tile_tl_master_clock_xing_in_1_a_valid,
  input  [2:0]  auto_coupler_from_tile_tl_master_clock_xing_in_1_a_bits_opcode,
                auto_coupler_from_tile_tl_master_clock_xing_in_1_a_bits_param,
  input  [3:0]  auto_coupler_from_tile_tl_master_clock_xing_in_1_a_bits_size,
  input  [1:0]  auto_coupler_from_tile_tl_master_clock_xing_in_1_a_bits_source,
  input  [31:0] auto_coupler_from_tile_tl_master_clock_xing_in_1_a_bits_address,
  input  [7:0]  auto_coupler_from_tile_tl_master_clock_xing_in_1_a_bits_mask,
  input  [63:0] auto_coupler_from_tile_tl_master_clock_xing_in_1_a_bits_data,
  input         auto_coupler_from_tile_tl_master_clock_xing_in_1_a_bits_corrupt,
                auto_coupler_from_tile_tl_master_clock_xing_in_1_b_ready,
                auto_coupler_from_tile_tl_master_clock_xing_in_1_c_valid,
  input  [2:0]  auto_coupler_from_tile_tl_master_clock_xing_in_1_c_bits_opcode,
                auto_coupler_from_tile_tl_master_clock_xing_in_1_c_bits_param,
  input  [3:0]  auto_coupler_from_tile_tl_master_clock_xing_in_1_c_bits_size,
  input  [1:0]  auto_coupler_from_tile_tl_master_clock_xing_in_1_c_bits_source,
  input  [31:0] auto_coupler_from_tile_tl_master_clock_xing_in_1_c_bits_address,
  input  [63:0] auto_coupler_from_tile_tl_master_clock_xing_in_1_c_bits_data,
  input         auto_coupler_from_tile_tl_master_clock_xing_in_1_c_bits_corrupt,
                auto_coupler_from_tile_tl_master_clock_xing_in_1_d_ready,
                auto_coupler_from_tile_tl_master_clock_xing_in_1_e_valid,
  input  [2:0]  auto_coupler_from_tile_tl_master_clock_xing_in_1_e_bits_sink,
  input         auto_coupler_from_tile_tl_master_clock_xing_in_0_a_valid,
  input  [2:0]  auto_coupler_from_tile_tl_master_clock_xing_in_0_a_bits_opcode,
                auto_coupler_from_tile_tl_master_clock_xing_in_0_a_bits_param,
  input  [3:0]  auto_coupler_from_tile_tl_master_clock_xing_in_0_a_bits_size,
  input  [1:0]  auto_coupler_from_tile_tl_master_clock_xing_in_0_a_bits_source,
  input  [31:0] auto_coupler_from_tile_tl_master_clock_xing_in_0_a_bits_address,
  input  [7:0]  auto_coupler_from_tile_tl_master_clock_xing_in_0_a_bits_mask,
  input  [63:0] auto_coupler_from_tile_tl_master_clock_xing_in_0_a_bits_data,
  input         auto_coupler_from_tile_tl_master_clock_xing_in_0_a_bits_corrupt,
                auto_coupler_from_tile_tl_master_clock_xing_in_0_b_ready,
                auto_coupler_from_tile_tl_master_clock_xing_in_0_c_valid,
  input  [2:0]  auto_coupler_from_tile_tl_master_clock_xing_in_0_c_bits_opcode,
                auto_coupler_from_tile_tl_master_clock_xing_in_0_c_bits_param,
  input  [3:0]  auto_coupler_from_tile_tl_master_clock_xing_in_0_c_bits_size,
  input  [1:0]  auto_coupler_from_tile_tl_master_clock_xing_in_0_c_bits_source,
  input  [31:0] auto_coupler_from_tile_tl_master_clock_xing_in_0_c_bits_address,
  input  [63:0] auto_coupler_from_tile_tl_master_clock_xing_in_0_c_bits_data,
  input         auto_coupler_from_tile_tl_master_clock_xing_in_0_c_bits_corrupt,
                auto_coupler_from_tile_tl_master_clock_xing_in_0_d_ready,
                auto_coupler_from_tile_tl_master_clock_xing_in_0_e_valid,
  input  [2:0]  auto_coupler_from_tile_tl_master_clock_xing_in_0_e_bits_sink,
  input         auto_coupler_to_bus_named_subsystem_l2_widget_out_a_ready,
                auto_coupler_to_bus_named_subsystem_l2_widget_out_b_valid,
  input  [1:0]  auto_coupler_to_bus_named_subsystem_l2_widget_out_b_bits_param,
  input  [6:0]  auto_coupler_to_bus_named_subsystem_l2_widget_out_b_bits_source,
  input  [31:0] auto_coupler_to_bus_named_subsystem_l2_widget_out_b_bits_address,
  input         auto_coupler_to_bus_named_subsystem_l2_widget_out_c_ready,
                auto_coupler_to_bus_named_subsystem_l2_widget_out_d_valid,
  input  [2:0]  auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_opcode,
  input  [1:0]  auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_param,
  input  [2:0]  auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_size,
  input  [6:0]  auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_source,
  input  [2:0]  auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_sink,
  input         auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_denied,
  input  [63:0] auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_data,
  input         auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_corrupt,
                auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_valid,
  input  [2:0]  auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_opcode,
                auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_param,
  input  [3:0]  auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_size,
  input         auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_source,
  input  [31:0] auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_address,
  input  [7:0]  auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_mask,
  input  [63:0] auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_data,
  input         auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_corrupt,
                auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_ready,
                auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_ready,
                auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_valid,
  input  [2:0]  auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_opcode,
  input  [1:0]  auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_param,
  input  [3:0]  auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_size,
  input  [6:0]  auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_source,
  input         auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_sink,
                auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_denied,
  input  [63:0] auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_data,
  input         auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_corrupt,
                auto_subsystem_sbus_clock_groups_in_member_subsystem_sbus_0_clock,
                auto_subsystem_sbus_clock_groups_in_member_subsystem_sbus_0_reset,
  output        auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_ready,
                auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_b_valid,
  output [2:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_b_bits_source,
  output        auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_c_ready,
                auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_valid,
  output [2:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_opcode,
  output [1:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_param,
  output [3:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_size,
  output [2:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_source,
                auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_sink,
  output        auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_denied,
  output [63:0] auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_data,
  output        auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_corrupt,
                auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_e_ready,
                auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_ready,
                auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_b_valid,
  output [3:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_b_bits_source,
  output        auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_c_ready,
                auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_valid,
  output [2:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_opcode,
  output [1:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_param,
  output [3:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_size,
                auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_source,
  output [2:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_sink,
  output        auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_denied,
  output [63:0] auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_data,
  output        auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_corrupt,
                auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_e_ready,
                auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_ready,
                auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_b_valid,
  output [4:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_b_bits_source,
  output        auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_c_ready,
                auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_valid,
  output [2:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_opcode,
  output [1:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_param,
  output [3:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_size,
  output [4:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_source,
  output [2:0]  auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_sink,
  output        auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_denied,
  output [63:0] auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_data,
  output        auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_corrupt,
                auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_e_ready,
                auto_coupler_from_tile_tl_master_clock_xing_in_2_a_ready,
                auto_coupler_from_tile_tl_master_clock_xing_in_2_b_valid,
  output [1:0]  auto_coupler_from_tile_tl_master_clock_xing_in_2_b_bits_source,
  output        auto_coupler_from_tile_tl_master_clock_xing_in_2_c_ready,
                auto_coupler_from_tile_tl_master_clock_xing_in_2_d_valid,
  output [2:0]  auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_opcode,
  output [1:0]  auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_param,
  output [3:0]  auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_size,
  output [1:0]  auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_source,
  output [2:0]  auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_sink,
  output        auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_denied,
  output [63:0] auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_data,
  output        auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_corrupt,
                auto_coupler_from_tile_tl_master_clock_xing_in_2_e_ready,
                auto_coupler_from_tile_tl_master_clock_xing_in_1_a_ready,
                auto_coupler_from_tile_tl_master_clock_xing_in_1_b_valid,
  output [1:0]  auto_coupler_from_tile_tl_master_clock_xing_in_1_b_bits_source,
  output        auto_coupler_from_tile_tl_master_clock_xing_in_1_c_ready,
                auto_coupler_from_tile_tl_master_clock_xing_in_1_d_valid,
  output [2:0]  auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_opcode,
  output [1:0]  auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_param,
  output [3:0]  auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_size,
  output [1:0]  auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_source,
  output [2:0]  auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_sink,
  output        auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_denied,
  output [63:0] auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_data,
  output        auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_corrupt,
                auto_coupler_from_tile_tl_master_clock_xing_in_1_e_ready,
                auto_coupler_from_tile_tl_master_clock_xing_in_0_a_ready,
                auto_coupler_from_tile_tl_master_clock_xing_in_0_b_valid,
  output [1:0]  auto_coupler_from_tile_tl_master_clock_xing_in_0_b_bits_source,
  output        auto_coupler_from_tile_tl_master_clock_xing_in_0_c_ready,
                auto_coupler_from_tile_tl_master_clock_xing_in_0_d_valid,
  output [2:0]  auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_opcode,
  output [1:0]  auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_param,
  output [3:0]  auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_size,
  output [1:0]  auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_source,
  output [2:0]  auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_sink,
  output        auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_denied,
  output [63:0] auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_data,
  output        auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_corrupt,
                auto_coupler_from_tile_tl_master_clock_xing_in_0_e_ready,
                auto_coupler_to_bus_named_subsystem_l2_widget_out_a_valid,
  output [2:0]  auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_opcode,
                auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_param,
                auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_size,
  output [6:0]  auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_source,
  output [31:0] auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_address,
  output [7:0]  auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_mask,
  output [63:0] auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_data,
  output        auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_corrupt,
                auto_coupler_to_bus_named_subsystem_l2_widget_out_b_ready,
                auto_coupler_to_bus_named_subsystem_l2_widget_out_c_valid,
  output [2:0]  auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_opcode,
                auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_param,
                auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_size,
  output [6:0]  auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_source,
  output [31:0] auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_address,
  output [63:0] auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_data,
  output        auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_corrupt,
                auto_coupler_to_bus_named_subsystem_l2_widget_out_d_ready,
                auto_coupler_to_bus_named_subsystem_l2_widget_out_e_valid,
  output [2:0]  auto_coupler_to_bus_named_subsystem_l2_widget_out_e_bits_sink,
  output        auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_ready,
                auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_valid,
  output [2:0]  auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_opcode,
  output [1:0]  auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_param,
  output [3:0]  auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_size,
  output [2:0]  auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_sink,
  output        auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_denied,
  output [63:0] auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_data,
  output        auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_corrupt,
                auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_valid,
  output [2:0]  auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_opcode,
                auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_param,
  output [3:0]  auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_size,
  output [6:0]  auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_source,
  output [30:0] auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_address,
  output [7:0]  auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_mask,
  output [63:0] auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_data,
  output        auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_corrupt,
                auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_ready
);

  wire       _system_bus_xbar_auto_in_6_a_ready;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_6_b_valid;	// SystemBus.scala:40:43
  wire [2:0] _system_bus_xbar_auto_in_6_b_bits_source;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_6_c_ready;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_6_d_valid;	// SystemBus.scala:40:43
  wire [2:0] _system_bus_xbar_auto_in_6_d_bits_opcode;	// SystemBus.scala:40:43
  wire [1:0] _system_bus_xbar_auto_in_6_d_bits_param;	// SystemBus.scala:40:43
  wire [3:0] _system_bus_xbar_auto_in_6_d_bits_size;	// SystemBus.scala:40:43
  wire [2:0] _system_bus_xbar_auto_in_6_d_bits_source;	// SystemBus.scala:40:43
  wire [2:0] _system_bus_xbar_auto_in_6_d_bits_sink;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_6_d_bits_denied;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_6_d_bits_corrupt;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_6_e_ready;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_5_a_ready;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_5_b_valid;	// SystemBus.scala:40:43
  wire [3:0] _system_bus_xbar_auto_in_5_b_bits_source;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_5_c_ready;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_5_d_valid;	// SystemBus.scala:40:43
  wire [2:0] _system_bus_xbar_auto_in_5_d_bits_opcode;	// SystemBus.scala:40:43
  wire [1:0] _system_bus_xbar_auto_in_5_d_bits_param;	// SystemBus.scala:40:43
  wire [3:0] _system_bus_xbar_auto_in_5_d_bits_size;	// SystemBus.scala:40:43
  wire [3:0] _system_bus_xbar_auto_in_5_d_bits_source;	// SystemBus.scala:40:43
  wire [2:0] _system_bus_xbar_auto_in_5_d_bits_sink;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_5_d_bits_denied;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_5_d_bits_corrupt;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_5_e_ready;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_4_a_ready;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_4_b_valid;	// SystemBus.scala:40:43
  wire [4:0] _system_bus_xbar_auto_in_4_b_bits_source;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_4_c_ready;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_4_d_valid;	// SystemBus.scala:40:43
  wire [2:0] _system_bus_xbar_auto_in_4_d_bits_opcode;	// SystemBus.scala:40:43
  wire [1:0] _system_bus_xbar_auto_in_4_d_bits_param;	// SystemBus.scala:40:43
  wire [3:0] _system_bus_xbar_auto_in_4_d_bits_size;	// SystemBus.scala:40:43
  wire [4:0] _system_bus_xbar_auto_in_4_d_bits_source;	// SystemBus.scala:40:43
  wire [2:0] _system_bus_xbar_auto_in_4_d_bits_sink;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_4_d_bits_denied;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_4_d_bits_corrupt;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_4_e_ready;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_3_a_ready;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_3_b_valid;	// SystemBus.scala:40:43
  wire [1:0] _system_bus_xbar_auto_in_3_b_bits_source;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_3_c_ready;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_3_d_valid;	// SystemBus.scala:40:43
  wire [2:0] _system_bus_xbar_auto_in_3_d_bits_opcode;	// SystemBus.scala:40:43
  wire [1:0] _system_bus_xbar_auto_in_3_d_bits_param;	// SystemBus.scala:40:43
  wire [3:0] _system_bus_xbar_auto_in_3_d_bits_size;	// SystemBus.scala:40:43
  wire [1:0] _system_bus_xbar_auto_in_3_d_bits_source;	// SystemBus.scala:40:43
  wire [2:0] _system_bus_xbar_auto_in_3_d_bits_sink;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_3_d_bits_denied;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_3_d_bits_corrupt;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_3_e_ready;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_2_a_ready;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_2_b_valid;	// SystemBus.scala:40:43
  wire [1:0] _system_bus_xbar_auto_in_2_b_bits_source;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_2_c_ready;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_2_d_valid;	// SystemBus.scala:40:43
  wire [2:0] _system_bus_xbar_auto_in_2_d_bits_opcode;	// SystemBus.scala:40:43
  wire [1:0] _system_bus_xbar_auto_in_2_d_bits_param;	// SystemBus.scala:40:43
  wire [3:0] _system_bus_xbar_auto_in_2_d_bits_size;	// SystemBus.scala:40:43
  wire [1:0] _system_bus_xbar_auto_in_2_d_bits_source;	// SystemBus.scala:40:43
  wire [2:0] _system_bus_xbar_auto_in_2_d_bits_sink;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_2_d_bits_denied;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_2_d_bits_corrupt;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_2_e_ready;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_1_a_ready;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_1_b_valid;	// SystemBus.scala:40:43
  wire [1:0] _system_bus_xbar_auto_in_1_b_bits_source;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_1_c_ready;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_1_d_valid;	// SystemBus.scala:40:43
  wire [2:0] _system_bus_xbar_auto_in_1_d_bits_opcode;	// SystemBus.scala:40:43
  wire [1:0] _system_bus_xbar_auto_in_1_d_bits_param;	// SystemBus.scala:40:43
  wire [3:0] _system_bus_xbar_auto_in_1_d_bits_size;	// SystemBus.scala:40:43
  wire [1:0] _system_bus_xbar_auto_in_1_d_bits_source;	// SystemBus.scala:40:43
  wire [2:0] _system_bus_xbar_auto_in_1_d_bits_sink;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_1_d_bits_denied;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_1_d_bits_corrupt;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_1_e_ready;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_0_a_ready;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_0_d_valid;	// SystemBus.scala:40:43
  wire [2:0] _system_bus_xbar_auto_in_0_d_bits_opcode;	// SystemBus.scala:40:43
  wire [1:0] _system_bus_xbar_auto_in_0_d_bits_param;	// SystemBus.scala:40:43
  wire [3:0] _system_bus_xbar_auto_in_0_d_bits_size;	// SystemBus.scala:40:43
  wire [2:0] _system_bus_xbar_auto_in_0_d_bits_sink;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_0_d_bits_denied;	// SystemBus.scala:40:43
  wire       _system_bus_xbar_auto_in_0_d_bits_corrupt;	// SystemBus.scala:40:43
  TLXbar system_bus_xbar (	// SystemBus.scala:40:43
    .clock
      (auto_subsystem_sbus_clock_groups_in_member_subsystem_sbus_0_clock),
    .reset
      (auto_subsystem_sbus_clock_groups_in_member_subsystem_sbus_0_reset),
    .auto_in_6_a_valid
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_valid),
    .auto_in_6_a_bits_opcode
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_bits_opcode),
    .auto_in_6_a_bits_param
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_bits_param),
    .auto_in_6_a_bits_size
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_bits_size),
    .auto_in_6_a_bits_source
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_bits_source),
    .auto_in_6_a_bits_address
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_bits_address),
    .auto_in_6_a_bits_mask
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_bits_mask),
    .auto_in_6_a_bits_data
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_bits_data),
    .auto_in_6_a_bits_corrupt
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_bits_corrupt),
    .auto_in_6_b_ready
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_b_ready),
    .auto_in_6_c_valid
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_c_valid),
    .auto_in_6_c_bits_opcode
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_c_bits_opcode),
    .auto_in_6_c_bits_param
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_c_bits_param),
    .auto_in_6_c_bits_size
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_c_bits_size),
    .auto_in_6_c_bits_source
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_c_bits_source),
    .auto_in_6_c_bits_address
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_c_bits_address),
    .auto_in_6_c_bits_data
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_c_bits_data),
    .auto_in_6_c_bits_corrupt
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_c_bits_corrupt),
    .auto_in_6_d_ready
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_ready),
    .auto_in_6_e_valid
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_e_valid),
    .auto_in_6_e_bits_sink
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_e_bits_sink),
    .auto_in_5_a_valid
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_valid),
    .auto_in_5_a_bits_opcode
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_bits_opcode),
    .auto_in_5_a_bits_param
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_bits_param),
    .auto_in_5_a_bits_size
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_bits_size),
    .auto_in_5_a_bits_source
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_bits_source),
    .auto_in_5_a_bits_address
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_bits_address),
    .auto_in_5_a_bits_mask
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_bits_mask),
    .auto_in_5_a_bits_data
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_bits_data),
    .auto_in_5_a_bits_corrupt
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_bits_corrupt),
    .auto_in_5_b_ready
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_b_ready),
    .auto_in_5_c_valid
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_c_valid),
    .auto_in_5_c_bits_opcode
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_c_bits_opcode),
    .auto_in_5_c_bits_param
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_c_bits_param),
    .auto_in_5_c_bits_size
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_c_bits_size),
    .auto_in_5_c_bits_source
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_c_bits_source),
    .auto_in_5_c_bits_address
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_c_bits_address),
    .auto_in_5_c_bits_data
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_c_bits_data),
    .auto_in_5_c_bits_corrupt
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_c_bits_corrupt),
    .auto_in_5_d_ready
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_ready),
    .auto_in_5_e_valid
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_e_valid),
    .auto_in_5_e_bits_sink
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_e_bits_sink),
    .auto_in_4_a_valid
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_valid),
    .auto_in_4_a_bits_opcode
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_bits_opcode),
    .auto_in_4_a_bits_param
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_bits_param),
    .auto_in_4_a_bits_size
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_bits_size),
    .auto_in_4_a_bits_source
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_bits_source),
    .auto_in_4_a_bits_address
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_bits_address),
    .auto_in_4_a_bits_mask
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_bits_mask),
    .auto_in_4_a_bits_data
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_bits_data),
    .auto_in_4_a_bits_corrupt
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_bits_corrupt),
    .auto_in_4_b_ready
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_b_ready),
    .auto_in_4_c_valid
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_c_valid),
    .auto_in_4_c_bits_opcode
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_c_bits_opcode),
    .auto_in_4_c_bits_param
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_c_bits_param),
    .auto_in_4_c_bits_size
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_c_bits_size),
    .auto_in_4_c_bits_source
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_c_bits_source),
    .auto_in_4_c_bits_address
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_c_bits_address),
    .auto_in_4_c_bits_data
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_c_bits_data),
    .auto_in_4_c_bits_corrupt
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_c_bits_corrupt),
    .auto_in_4_d_ready
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_ready),
    .auto_in_4_e_valid
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_e_valid),
    .auto_in_4_e_bits_sink
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_e_bits_sink),
    .auto_in_3_a_valid         (auto_coupler_from_tile_tl_master_clock_xing_in_2_a_valid),
    .auto_in_3_a_bits_opcode
      (auto_coupler_from_tile_tl_master_clock_xing_in_2_a_bits_opcode),
    .auto_in_3_a_bits_param
      (auto_coupler_from_tile_tl_master_clock_xing_in_2_a_bits_param),
    .auto_in_3_a_bits_size
      (auto_coupler_from_tile_tl_master_clock_xing_in_2_a_bits_size),
    .auto_in_3_a_bits_source
      (auto_coupler_from_tile_tl_master_clock_xing_in_2_a_bits_source),
    .auto_in_3_a_bits_address
      (auto_coupler_from_tile_tl_master_clock_xing_in_2_a_bits_address),
    .auto_in_3_a_bits_mask
      (auto_coupler_from_tile_tl_master_clock_xing_in_2_a_bits_mask),
    .auto_in_3_a_bits_data
      (auto_coupler_from_tile_tl_master_clock_xing_in_2_a_bits_data),
    .auto_in_3_a_bits_corrupt
      (auto_coupler_from_tile_tl_master_clock_xing_in_2_a_bits_corrupt),
    .auto_in_3_b_ready         (auto_coupler_from_tile_tl_master_clock_xing_in_2_b_ready),
    .auto_in_3_c_valid         (auto_coupler_from_tile_tl_master_clock_xing_in_2_c_valid),
    .auto_in_3_c_bits_opcode
      (auto_coupler_from_tile_tl_master_clock_xing_in_2_c_bits_opcode),
    .auto_in_3_c_bits_param
      (auto_coupler_from_tile_tl_master_clock_xing_in_2_c_bits_param),
    .auto_in_3_c_bits_size
      (auto_coupler_from_tile_tl_master_clock_xing_in_2_c_bits_size),
    .auto_in_3_c_bits_source
      (auto_coupler_from_tile_tl_master_clock_xing_in_2_c_bits_source),
    .auto_in_3_c_bits_address
      (auto_coupler_from_tile_tl_master_clock_xing_in_2_c_bits_address),
    .auto_in_3_c_bits_data
      (auto_coupler_from_tile_tl_master_clock_xing_in_2_c_bits_data),
    .auto_in_3_c_bits_corrupt
      (auto_coupler_from_tile_tl_master_clock_xing_in_2_c_bits_corrupt),
    .auto_in_3_d_ready         (auto_coupler_from_tile_tl_master_clock_xing_in_2_d_ready),
    .auto_in_3_e_valid         (auto_coupler_from_tile_tl_master_clock_xing_in_2_e_valid),
    .auto_in_3_e_bits_sink
      (auto_coupler_from_tile_tl_master_clock_xing_in_2_e_bits_sink),
    .auto_in_2_a_valid         (auto_coupler_from_tile_tl_master_clock_xing_in_1_a_valid),
    .auto_in_2_a_bits_opcode
      (auto_coupler_from_tile_tl_master_clock_xing_in_1_a_bits_opcode),
    .auto_in_2_a_bits_param
      (auto_coupler_from_tile_tl_master_clock_xing_in_1_a_bits_param),
    .auto_in_2_a_bits_size
      (auto_coupler_from_tile_tl_master_clock_xing_in_1_a_bits_size),
    .auto_in_2_a_bits_source
      (auto_coupler_from_tile_tl_master_clock_xing_in_1_a_bits_source),
    .auto_in_2_a_bits_address
      (auto_coupler_from_tile_tl_master_clock_xing_in_1_a_bits_address),
    .auto_in_2_a_bits_mask
      (auto_coupler_from_tile_tl_master_clock_xing_in_1_a_bits_mask),
    .auto_in_2_a_bits_data
      (auto_coupler_from_tile_tl_master_clock_xing_in_1_a_bits_data),
    .auto_in_2_a_bits_corrupt
      (auto_coupler_from_tile_tl_master_clock_xing_in_1_a_bits_corrupt),
    .auto_in_2_b_ready         (auto_coupler_from_tile_tl_master_clock_xing_in_1_b_ready),
    .auto_in_2_c_valid         (auto_coupler_from_tile_tl_master_clock_xing_in_1_c_valid),
    .auto_in_2_c_bits_opcode
      (auto_coupler_from_tile_tl_master_clock_xing_in_1_c_bits_opcode),
    .auto_in_2_c_bits_param
      (auto_coupler_from_tile_tl_master_clock_xing_in_1_c_bits_param),
    .auto_in_2_c_bits_size
      (auto_coupler_from_tile_tl_master_clock_xing_in_1_c_bits_size),
    .auto_in_2_c_bits_source
      (auto_coupler_from_tile_tl_master_clock_xing_in_1_c_bits_source),
    .auto_in_2_c_bits_address
      (auto_coupler_from_tile_tl_master_clock_xing_in_1_c_bits_address),
    .auto_in_2_c_bits_data
      (auto_coupler_from_tile_tl_master_clock_xing_in_1_c_bits_data),
    .auto_in_2_c_bits_corrupt
      (auto_coupler_from_tile_tl_master_clock_xing_in_1_c_bits_corrupt),
    .auto_in_2_d_ready         (auto_coupler_from_tile_tl_master_clock_xing_in_1_d_ready),
    .auto_in_2_e_valid         (auto_coupler_from_tile_tl_master_clock_xing_in_1_e_valid),
    .auto_in_2_e_bits_sink
      (auto_coupler_from_tile_tl_master_clock_xing_in_1_e_bits_sink),
    .auto_in_1_a_valid         (auto_coupler_from_tile_tl_master_clock_xing_in_0_a_valid),
    .auto_in_1_a_bits_opcode
      (auto_coupler_from_tile_tl_master_clock_xing_in_0_a_bits_opcode),
    .auto_in_1_a_bits_param
      (auto_coupler_from_tile_tl_master_clock_xing_in_0_a_bits_param),
    .auto_in_1_a_bits_size
      (auto_coupler_from_tile_tl_master_clock_xing_in_0_a_bits_size),
    .auto_in_1_a_bits_source
      (auto_coupler_from_tile_tl_master_clock_xing_in_0_a_bits_source),
    .auto_in_1_a_bits_address
      (auto_coupler_from_tile_tl_master_clock_xing_in_0_a_bits_address),
    .auto_in_1_a_bits_mask
      (auto_coupler_from_tile_tl_master_clock_xing_in_0_a_bits_mask),
    .auto_in_1_a_bits_data
      (auto_coupler_from_tile_tl_master_clock_xing_in_0_a_bits_data),
    .auto_in_1_a_bits_corrupt
      (auto_coupler_from_tile_tl_master_clock_xing_in_0_a_bits_corrupt),
    .auto_in_1_b_ready         (auto_coupler_from_tile_tl_master_clock_xing_in_0_b_ready),
    .auto_in_1_c_valid         (auto_coupler_from_tile_tl_master_clock_xing_in_0_c_valid),
    .auto_in_1_c_bits_opcode
      (auto_coupler_from_tile_tl_master_clock_xing_in_0_c_bits_opcode),
    .auto_in_1_c_bits_param
      (auto_coupler_from_tile_tl_master_clock_xing_in_0_c_bits_param),
    .auto_in_1_c_bits_size
      (auto_coupler_from_tile_tl_master_clock_xing_in_0_c_bits_size),
    .auto_in_1_c_bits_source
      (auto_coupler_from_tile_tl_master_clock_xing_in_0_c_bits_source),
    .auto_in_1_c_bits_address
      (auto_coupler_from_tile_tl_master_clock_xing_in_0_c_bits_address),
    .auto_in_1_c_bits_data
      (auto_coupler_from_tile_tl_master_clock_xing_in_0_c_bits_data),
    .auto_in_1_c_bits_corrupt
      (auto_coupler_from_tile_tl_master_clock_xing_in_0_c_bits_corrupt),
    .auto_in_1_d_ready         (auto_coupler_from_tile_tl_master_clock_xing_in_0_d_ready),
    .auto_in_1_e_valid         (auto_coupler_from_tile_tl_master_clock_xing_in_0_e_valid),
    .auto_in_1_e_bits_sink
      (auto_coupler_from_tile_tl_master_clock_xing_in_0_e_bits_sink),
    .auto_in_0_a_valid
      (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_valid),
    .auto_in_0_a_bits_opcode
      (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_opcode),
    .auto_in_0_a_bits_param
      (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_param),
    .auto_in_0_a_bits_size
      (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_size),
    .auto_in_0_a_bits_source
      (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_source),
    .auto_in_0_a_bits_address
      (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_address),
    .auto_in_0_a_bits_mask
      (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_mask),
    .auto_in_0_a_bits_data
      (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_data),
    .auto_in_0_a_bits_corrupt
      (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_corrupt),
    .auto_in_0_d_ready
      (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_ready),
    .auto_out_1_a_ready
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_a_ready),
    .auto_out_1_b_valid
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_b_valid),
    .auto_out_1_b_bits_param
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_b_bits_param),
    .auto_out_1_b_bits_source
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_b_bits_source),
    .auto_out_1_b_bits_address
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_b_bits_address),
    .auto_out_1_c_ready
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_c_ready),
    .auto_out_1_d_valid
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_d_valid),
    .auto_out_1_d_bits_opcode
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_opcode),
    .auto_out_1_d_bits_param
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_param),
    .auto_out_1_d_bits_size
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_size),
    .auto_out_1_d_bits_source
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_source),
    .auto_out_1_d_bits_sink
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_sink),
    .auto_out_1_d_bits_denied
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_denied),
    .auto_out_1_d_bits_data
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_data),
    .auto_out_1_d_bits_corrupt
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_d_bits_corrupt),
    .auto_out_0_a_ready
      (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_ready),
    .auto_out_0_d_valid
      (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_valid),
    .auto_out_0_d_bits_opcode
      (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_opcode),
    .auto_out_0_d_bits_param
      (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_param),
    .auto_out_0_d_bits_size
      (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_size),
    .auto_out_0_d_bits_source
      (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_source),
    .auto_out_0_d_bits_sink
      (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_sink),
    .auto_out_0_d_bits_denied
      (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_denied),
    .auto_out_0_d_bits_data
      (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_data),
    .auto_out_0_d_bits_corrupt
      (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_bits_corrupt),
    .auto_in_6_a_ready         (_system_bus_xbar_auto_in_6_a_ready),
    .auto_in_6_b_valid         (_system_bus_xbar_auto_in_6_b_valid),
    .auto_in_6_b_bits_source   (_system_bus_xbar_auto_in_6_b_bits_source),
    .auto_in_6_c_ready         (_system_bus_xbar_auto_in_6_c_ready),
    .auto_in_6_d_valid         (_system_bus_xbar_auto_in_6_d_valid),
    .auto_in_6_d_bits_opcode   (_system_bus_xbar_auto_in_6_d_bits_opcode),
    .auto_in_6_d_bits_param    (_system_bus_xbar_auto_in_6_d_bits_param),
    .auto_in_6_d_bits_size     (_system_bus_xbar_auto_in_6_d_bits_size),
    .auto_in_6_d_bits_source   (_system_bus_xbar_auto_in_6_d_bits_source),
    .auto_in_6_d_bits_sink     (_system_bus_xbar_auto_in_6_d_bits_sink),
    .auto_in_6_d_bits_denied   (_system_bus_xbar_auto_in_6_d_bits_denied),
    .auto_in_6_d_bits_data
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_data),
    .auto_in_6_d_bits_corrupt  (_system_bus_xbar_auto_in_6_d_bits_corrupt),
    .auto_in_6_e_ready         (_system_bus_xbar_auto_in_6_e_ready),
    .auto_in_5_a_ready         (_system_bus_xbar_auto_in_5_a_ready),
    .auto_in_5_b_valid         (_system_bus_xbar_auto_in_5_b_valid),
    .auto_in_5_b_bits_source   (_system_bus_xbar_auto_in_5_b_bits_source),
    .auto_in_5_c_ready         (_system_bus_xbar_auto_in_5_c_ready),
    .auto_in_5_d_valid         (_system_bus_xbar_auto_in_5_d_valid),
    .auto_in_5_d_bits_opcode   (_system_bus_xbar_auto_in_5_d_bits_opcode),
    .auto_in_5_d_bits_param    (_system_bus_xbar_auto_in_5_d_bits_param),
    .auto_in_5_d_bits_size     (_system_bus_xbar_auto_in_5_d_bits_size),
    .auto_in_5_d_bits_source   (_system_bus_xbar_auto_in_5_d_bits_source),
    .auto_in_5_d_bits_sink     (_system_bus_xbar_auto_in_5_d_bits_sink),
    .auto_in_5_d_bits_denied   (_system_bus_xbar_auto_in_5_d_bits_denied),
    .auto_in_5_d_bits_data
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_data),
    .auto_in_5_d_bits_corrupt  (_system_bus_xbar_auto_in_5_d_bits_corrupt),
    .auto_in_5_e_ready         (_system_bus_xbar_auto_in_5_e_ready),
    .auto_in_4_a_ready         (_system_bus_xbar_auto_in_4_a_ready),
    .auto_in_4_b_valid         (_system_bus_xbar_auto_in_4_b_valid),
    .auto_in_4_b_bits_source   (_system_bus_xbar_auto_in_4_b_bits_source),
    .auto_in_4_c_ready         (_system_bus_xbar_auto_in_4_c_ready),
    .auto_in_4_d_valid         (_system_bus_xbar_auto_in_4_d_valid),
    .auto_in_4_d_bits_opcode   (_system_bus_xbar_auto_in_4_d_bits_opcode),
    .auto_in_4_d_bits_param    (_system_bus_xbar_auto_in_4_d_bits_param),
    .auto_in_4_d_bits_size     (_system_bus_xbar_auto_in_4_d_bits_size),
    .auto_in_4_d_bits_source   (_system_bus_xbar_auto_in_4_d_bits_source),
    .auto_in_4_d_bits_sink     (_system_bus_xbar_auto_in_4_d_bits_sink),
    .auto_in_4_d_bits_denied   (_system_bus_xbar_auto_in_4_d_bits_denied),
    .auto_in_4_d_bits_data
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_data),
    .auto_in_4_d_bits_corrupt  (_system_bus_xbar_auto_in_4_d_bits_corrupt),
    .auto_in_4_e_ready         (_system_bus_xbar_auto_in_4_e_ready),
    .auto_in_3_a_ready         (_system_bus_xbar_auto_in_3_a_ready),
    .auto_in_3_b_valid         (_system_bus_xbar_auto_in_3_b_valid),
    .auto_in_3_b_bits_source   (_system_bus_xbar_auto_in_3_b_bits_source),
    .auto_in_3_c_ready         (_system_bus_xbar_auto_in_3_c_ready),
    .auto_in_3_d_valid         (_system_bus_xbar_auto_in_3_d_valid),
    .auto_in_3_d_bits_opcode   (_system_bus_xbar_auto_in_3_d_bits_opcode),
    .auto_in_3_d_bits_param    (_system_bus_xbar_auto_in_3_d_bits_param),
    .auto_in_3_d_bits_size     (_system_bus_xbar_auto_in_3_d_bits_size),
    .auto_in_3_d_bits_source   (_system_bus_xbar_auto_in_3_d_bits_source),
    .auto_in_3_d_bits_sink     (_system_bus_xbar_auto_in_3_d_bits_sink),
    .auto_in_3_d_bits_denied   (_system_bus_xbar_auto_in_3_d_bits_denied),
    .auto_in_3_d_bits_data
      (auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_data),
    .auto_in_3_d_bits_corrupt  (_system_bus_xbar_auto_in_3_d_bits_corrupt),
    .auto_in_3_e_ready         (_system_bus_xbar_auto_in_3_e_ready),
    .auto_in_2_a_ready         (_system_bus_xbar_auto_in_2_a_ready),
    .auto_in_2_b_valid         (_system_bus_xbar_auto_in_2_b_valid),
    .auto_in_2_b_bits_source   (_system_bus_xbar_auto_in_2_b_bits_source),
    .auto_in_2_c_ready         (_system_bus_xbar_auto_in_2_c_ready),
    .auto_in_2_d_valid         (_system_bus_xbar_auto_in_2_d_valid),
    .auto_in_2_d_bits_opcode   (_system_bus_xbar_auto_in_2_d_bits_opcode),
    .auto_in_2_d_bits_param    (_system_bus_xbar_auto_in_2_d_bits_param),
    .auto_in_2_d_bits_size     (_system_bus_xbar_auto_in_2_d_bits_size),
    .auto_in_2_d_bits_source   (_system_bus_xbar_auto_in_2_d_bits_source),
    .auto_in_2_d_bits_sink     (_system_bus_xbar_auto_in_2_d_bits_sink),
    .auto_in_2_d_bits_denied   (_system_bus_xbar_auto_in_2_d_bits_denied),
    .auto_in_2_d_bits_data
      (auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_data),
    .auto_in_2_d_bits_corrupt  (_system_bus_xbar_auto_in_2_d_bits_corrupt),
    .auto_in_2_e_ready         (_system_bus_xbar_auto_in_2_e_ready),
    .auto_in_1_a_ready         (_system_bus_xbar_auto_in_1_a_ready),
    .auto_in_1_b_valid         (_system_bus_xbar_auto_in_1_b_valid),
    .auto_in_1_b_bits_source   (_system_bus_xbar_auto_in_1_b_bits_source),
    .auto_in_1_c_ready         (_system_bus_xbar_auto_in_1_c_ready),
    .auto_in_1_d_valid         (_system_bus_xbar_auto_in_1_d_valid),
    .auto_in_1_d_bits_opcode   (_system_bus_xbar_auto_in_1_d_bits_opcode),
    .auto_in_1_d_bits_param    (_system_bus_xbar_auto_in_1_d_bits_param),
    .auto_in_1_d_bits_size     (_system_bus_xbar_auto_in_1_d_bits_size),
    .auto_in_1_d_bits_source   (_system_bus_xbar_auto_in_1_d_bits_source),
    .auto_in_1_d_bits_sink     (_system_bus_xbar_auto_in_1_d_bits_sink),
    .auto_in_1_d_bits_denied   (_system_bus_xbar_auto_in_1_d_bits_denied),
    .auto_in_1_d_bits_data
      (auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_data),
    .auto_in_1_d_bits_corrupt  (_system_bus_xbar_auto_in_1_d_bits_corrupt),
    .auto_in_1_e_ready         (_system_bus_xbar_auto_in_1_e_ready),
    .auto_in_0_a_ready         (_system_bus_xbar_auto_in_0_a_ready),
    .auto_in_0_d_valid         (_system_bus_xbar_auto_in_0_d_valid),
    .auto_in_0_d_bits_opcode   (_system_bus_xbar_auto_in_0_d_bits_opcode),
    .auto_in_0_d_bits_param    (_system_bus_xbar_auto_in_0_d_bits_param),
    .auto_in_0_d_bits_size     (_system_bus_xbar_auto_in_0_d_bits_size),
    .auto_in_0_d_bits_sink     (_system_bus_xbar_auto_in_0_d_bits_sink),
    .auto_in_0_d_bits_denied   (_system_bus_xbar_auto_in_0_d_bits_denied),
    .auto_in_0_d_bits_data
      (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_data),
    .auto_in_0_d_bits_corrupt  (_system_bus_xbar_auto_in_0_d_bits_corrupt),
    .auto_out_1_a_valid
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_a_valid),
    .auto_out_1_a_bits_opcode
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_opcode),
    .auto_out_1_a_bits_param
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_param),
    .auto_out_1_a_bits_size
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_size),
    .auto_out_1_a_bits_source
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_source),
    .auto_out_1_a_bits_address
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_address),
    .auto_out_1_a_bits_mask
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_mask),
    .auto_out_1_a_bits_data
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_data),
    .auto_out_1_a_bits_corrupt
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_a_bits_corrupt),
    .auto_out_1_b_ready
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_b_ready),
    .auto_out_1_c_valid
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_c_valid),
    .auto_out_1_c_bits_opcode
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_opcode),
    .auto_out_1_c_bits_param
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_param),
    .auto_out_1_c_bits_size
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_size),
    .auto_out_1_c_bits_source
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_source),
    .auto_out_1_c_bits_address
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_address),
    .auto_out_1_c_bits_data
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_data),
    .auto_out_1_c_bits_corrupt
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_c_bits_corrupt),
    .auto_out_1_d_ready
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_d_ready),
    .auto_out_1_e_valid
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_e_valid),
    .auto_out_1_e_bits_sink
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_e_bits_sink),
    .auto_out_0_a_valid
      (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_valid),
    .auto_out_0_a_bits_opcode
      (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_opcode),
    .auto_out_0_a_bits_param
      (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_param),
    .auto_out_0_a_bits_size
      (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_size),
    .auto_out_0_a_bits_source
      (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_source),
    .auto_out_0_a_bits_address
      (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_address),
    .auto_out_0_a_bits_mask
      (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_mask),
    .auto_out_0_a_bits_data
      (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_data),
    .auto_out_0_a_bits_corrupt
      (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_a_bits_corrupt),
    .auto_out_0_d_ready
      (auto_coupler_to_bus_named_subsystem_cbus_bus_xing_out_d_ready)
  );
  TLFIFOFixer fixer (	// FIFOFixer.scala:144:27
    .clock
      (auto_subsystem_sbus_clock_groups_in_member_subsystem_sbus_0_clock),
    .reset
      (auto_subsystem_sbus_clock_groups_in_member_subsystem_sbus_0_reset),
    .auto_in_6_a_valid
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_valid),
    .auto_in_6_a_bits_opcode
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_bits_opcode),
    .auto_in_6_a_bits_param
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_bits_param),
    .auto_in_6_a_bits_size
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_bits_size),
    .auto_in_6_a_bits_source
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_bits_source),
    .auto_in_6_a_bits_address
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_bits_address),
    .auto_in_6_a_bits_mask
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_bits_mask),
    .auto_in_6_a_bits_corrupt
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_bits_corrupt),
    .auto_in_6_b_ready
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_b_ready),
    .auto_in_6_c_valid
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_c_valid),
    .auto_in_6_c_bits_opcode
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_c_bits_opcode),
    .auto_in_6_c_bits_param
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_c_bits_param),
    .auto_in_6_c_bits_size
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_c_bits_size),
    .auto_in_6_c_bits_source
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_c_bits_source),
    .auto_in_6_c_bits_address
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_c_bits_address),
    .auto_in_6_c_bits_corrupt
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_c_bits_corrupt),
    .auto_in_6_d_ready
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_ready),
    .auto_in_6_e_valid
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_e_valid),
    .auto_in_6_e_bits_sink
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_e_bits_sink),
    .auto_in_5_a_valid
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_valid),
    .auto_in_5_a_bits_opcode
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_bits_opcode),
    .auto_in_5_a_bits_param
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_bits_param),
    .auto_in_5_a_bits_size
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_bits_size),
    .auto_in_5_a_bits_source
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_bits_source),
    .auto_in_5_a_bits_address
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_bits_address),
    .auto_in_5_a_bits_mask
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_bits_mask),
    .auto_in_5_a_bits_corrupt
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_bits_corrupt),
    .auto_in_5_b_ready
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_b_ready),
    .auto_in_5_c_valid
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_c_valid),
    .auto_in_5_c_bits_opcode
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_c_bits_opcode),
    .auto_in_5_c_bits_param
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_c_bits_param),
    .auto_in_5_c_bits_size
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_c_bits_size),
    .auto_in_5_c_bits_source
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_c_bits_source),
    .auto_in_5_c_bits_address
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_c_bits_address),
    .auto_in_5_c_bits_corrupt
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_c_bits_corrupt),
    .auto_in_5_d_ready
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_ready),
    .auto_in_5_e_valid
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_e_valid),
    .auto_in_5_e_bits_sink
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_e_bits_sink),
    .auto_in_4_a_valid
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_valid),
    .auto_in_4_a_bits_opcode
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_bits_opcode),
    .auto_in_4_a_bits_param
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_bits_param),
    .auto_in_4_a_bits_size
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_bits_size),
    .auto_in_4_a_bits_source
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_bits_source),
    .auto_in_4_a_bits_address
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_bits_address),
    .auto_in_4_a_bits_mask
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_bits_mask),
    .auto_in_4_a_bits_corrupt
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_bits_corrupt),
    .auto_in_4_b_ready
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_b_ready),
    .auto_in_4_c_valid
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_c_valid),
    .auto_in_4_c_bits_opcode
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_c_bits_opcode),
    .auto_in_4_c_bits_param
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_c_bits_param),
    .auto_in_4_c_bits_size
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_c_bits_size),
    .auto_in_4_c_bits_source
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_c_bits_source),
    .auto_in_4_c_bits_address
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_c_bits_address),
    .auto_in_4_c_bits_corrupt
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_c_bits_corrupt),
    .auto_in_4_d_ready
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_ready),
    .auto_in_4_e_valid
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_e_valid),
    .auto_in_4_e_bits_sink
      (auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_e_bits_sink),
    .auto_in_3_a_valid         (auto_coupler_from_tile_tl_master_clock_xing_in_2_a_valid),
    .auto_in_3_a_bits_opcode
      (auto_coupler_from_tile_tl_master_clock_xing_in_2_a_bits_opcode),
    .auto_in_3_a_bits_param
      (auto_coupler_from_tile_tl_master_clock_xing_in_2_a_bits_param),
    .auto_in_3_a_bits_size
      (auto_coupler_from_tile_tl_master_clock_xing_in_2_a_bits_size),
    .auto_in_3_a_bits_source
      (auto_coupler_from_tile_tl_master_clock_xing_in_2_a_bits_source),
    .auto_in_3_a_bits_address
      (auto_coupler_from_tile_tl_master_clock_xing_in_2_a_bits_address),
    .auto_in_3_a_bits_mask
      (auto_coupler_from_tile_tl_master_clock_xing_in_2_a_bits_mask),
    .auto_in_3_a_bits_corrupt
      (auto_coupler_from_tile_tl_master_clock_xing_in_2_a_bits_corrupt),
    .auto_in_3_b_ready         (auto_coupler_from_tile_tl_master_clock_xing_in_2_b_ready),
    .auto_in_3_c_valid         (auto_coupler_from_tile_tl_master_clock_xing_in_2_c_valid),
    .auto_in_3_c_bits_opcode
      (auto_coupler_from_tile_tl_master_clock_xing_in_2_c_bits_opcode),
    .auto_in_3_c_bits_param
      (auto_coupler_from_tile_tl_master_clock_xing_in_2_c_bits_param),
    .auto_in_3_c_bits_size
      (auto_coupler_from_tile_tl_master_clock_xing_in_2_c_bits_size),
    .auto_in_3_c_bits_source
      (auto_coupler_from_tile_tl_master_clock_xing_in_2_c_bits_source),
    .auto_in_3_c_bits_address
      (auto_coupler_from_tile_tl_master_clock_xing_in_2_c_bits_address),
    .auto_in_3_c_bits_corrupt
      (auto_coupler_from_tile_tl_master_clock_xing_in_2_c_bits_corrupt),
    .auto_in_3_d_ready         (auto_coupler_from_tile_tl_master_clock_xing_in_2_d_ready),
    .auto_in_3_e_valid         (auto_coupler_from_tile_tl_master_clock_xing_in_2_e_valid),
    .auto_in_3_e_bits_sink
      (auto_coupler_from_tile_tl_master_clock_xing_in_2_e_bits_sink),
    .auto_in_2_a_valid         (auto_coupler_from_tile_tl_master_clock_xing_in_1_a_valid),
    .auto_in_2_a_bits_opcode
      (auto_coupler_from_tile_tl_master_clock_xing_in_1_a_bits_opcode),
    .auto_in_2_a_bits_param
      (auto_coupler_from_tile_tl_master_clock_xing_in_1_a_bits_param),
    .auto_in_2_a_bits_size
      (auto_coupler_from_tile_tl_master_clock_xing_in_1_a_bits_size),
    .auto_in_2_a_bits_source
      (auto_coupler_from_tile_tl_master_clock_xing_in_1_a_bits_source),
    .auto_in_2_a_bits_address
      (auto_coupler_from_tile_tl_master_clock_xing_in_1_a_bits_address),
    .auto_in_2_a_bits_mask
      (auto_coupler_from_tile_tl_master_clock_xing_in_1_a_bits_mask),
    .auto_in_2_a_bits_corrupt
      (auto_coupler_from_tile_tl_master_clock_xing_in_1_a_bits_corrupt),
    .auto_in_2_b_ready         (auto_coupler_from_tile_tl_master_clock_xing_in_1_b_ready),
    .auto_in_2_c_valid         (auto_coupler_from_tile_tl_master_clock_xing_in_1_c_valid),
    .auto_in_2_c_bits_opcode
      (auto_coupler_from_tile_tl_master_clock_xing_in_1_c_bits_opcode),
    .auto_in_2_c_bits_param
      (auto_coupler_from_tile_tl_master_clock_xing_in_1_c_bits_param),
    .auto_in_2_c_bits_size
      (auto_coupler_from_tile_tl_master_clock_xing_in_1_c_bits_size),
    .auto_in_2_c_bits_source
      (auto_coupler_from_tile_tl_master_clock_xing_in_1_c_bits_source),
    .auto_in_2_c_bits_address
      (auto_coupler_from_tile_tl_master_clock_xing_in_1_c_bits_address),
    .auto_in_2_c_bits_corrupt
      (auto_coupler_from_tile_tl_master_clock_xing_in_1_c_bits_corrupt),
    .auto_in_2_d_ready         (auto_coupler_from_tile_tl_master_clock_xing_in_1_d_ready),
    .auto_in_2_e_valid         (auto_coupler_from_tile_tl_master_clock_xing_in_1_e_valid),
    .auto_in_2_e_bits_sink
      (auto_coupler_from_tile_tl_master_clock_xing_in_1_e_bits_sink),
    .auto_in_1_a_valid         (auto_coupler_from_tile_tl_master_clock_xing_in_0_a_valid),
    .auto_in_1_a_bits_opcode
      (auto_coupler_from_tile_tl_master_clock_xing_in_0_a_bits_opcode),
    .auto_in_1_a_bits_param
      (auto_coupler_from_tile_tl_master_clock_xing_in_0_a_bits_param),
    .auto_in_1_a_bits_size
      (auto_coupler_from_tile_tl_master_clock_xing_in_0_a_bits_size),
    .auto_in_1_a_bits_source
      (auto_coupler_from_tile_tl_master_clock_xing_in_0_a_bits_source),
    .auto_in_1_a_bits_address
      (auto_coupler_from_tile_tl_master_clock_xing_in_0_a_bits_address),
    .auto_in_1_a_bits_mask
      (auto_coupler_from_tile_tl_master_clock_xing_in_0_a_bits_mask),
    .auto_in_1_a_bits_corrupt
      (auto_coupler_from_tile_tl_master_clock_xing_in_0_a_bits_corrupt),
    .auto_in_1_b_ready         (auto_coupler_from_tile_tl_master_clock_xing_in_0_b_ready),
    .auto_in_1_c_valid         (auto_coupler_from_tile_tl_master_clock_xing_in_0_c_valid),
    .auto_in_1_c_bits_opcode
      (auto_coupler_from_tile_tl_master_clock_xing_in_0_c_bits_opcode),
    .auto_in_1_c_bits_param
      (auto_coupler_from_tile_tl_master_clock_xing_in_0_c_bits_param),
    .auto_in_1_c_bits_size
      (auto_coupler_from_tile_tl_master_clock_xing_in_0_c_bits_size),
    .auto_in_1_c_bits_source
      (auto_coupler_from_tile_tl_master_clock_xing_in_0_c_bits_source),
    .auto_in_1_c_bits_address
      (auto_coupler_from_tile_tl_master_clock_xing_in_0_c_bits_address),
    .auto_in_1_c_bits_corrupt
      (auto_coupler_from_tile_tl_master_clock_xing_in_0_c_bits_corrupt),
    .auto_in_1_d_ready         (auto_coupler_from_tile_tl_master_clock_xing_in_0_d_ready),
    .auto_in_1_e_valid         (auto_coupler_from_tile_tl_master_clock_xing_in_0_e_valid),
    .auto_in_1_e_bits_sink
      (auto_coupler_from_tile_tl_master_clock_xing_in_0_e_bits_sink),
    .auto_in_0_a_valid
      (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_valid),
    .auto_in_0_a_bits_opcode
      (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_opcode),
    .auto_in_0_a_bits_param
      (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_param),
    .auto_in_0_a_bits_size
      (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_size),
    .auto_in_0_a_bits_source
      (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_source),
    .auto_in_0_a_bits_address
      (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_address),
    .auto_in_0_a_bits_mask
      (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_mask),
    .auto_in_0_a_bits_corrupt
      (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_bits_corrupt),
    .auto_in_0_d_ready
      (auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_ready),
    .auto_out_6_a_ready        (_system_bus_xbar_auto_in_6_a_ready),	// SystemBus.scala:40:43
    .auto_out_6_b_valid        (_system_bus_xbar_auto_in_6_b_valid),	// SystemBus.scala:40:43
    .auto_out_6_b_bits_param
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_b_bits_param),
    .auto_out_6_b_bits_source  (_system_bus_xbar_auto_in_6_b_bits_source),	// SystemBus.scala:40:43
    .auto_out_6_b_bits_address
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_b_bits_address),
    .auto_out_6_c_ready        (_system_bus_xbar_auto_in_6_c_ready),	// SystemBus.scala:40:43
    .auto_out_6_d_valid        (_system_bus_xbar_auto_in_6_d_valid),	// SystemBus.scala:40:43
    .auto_out_6_d_bits_opcode  (_system_bus_xbar_auto_in_6_d_bits_opcode),	// SystemBus.scala:40:43
    .auto_out_6_d_bits_param   (_system_bus_xbar_auto_in_6_d_bits_param),	// SystemBus.scala:40:43
    .auto_out_6_d_bits_size    (_system_bus_xbar_auto_in_6_d_bits_size),	// SystemBus.scala:40:43
    .auto_out_6_d_bits_source  (_system_bus_xbar_auto_in_6_d_bits_source),	// SystemBus.scala:40:43
    .auto_out_6_d_bits_sink    (_system_bus_xbar_auto_in_6_d_bits_sink),	// SystemBus.scala:40:43
    .auto_out_6_d_bits_denied  (_system_bus_xbar_auto_in_6_d_bits_denied),	// SystemBus.scala:40:43
    .auto_out_6_d_bits_corrupt (_system_bus_xbar_auto_in_6_d_bits_corrupt),	// SystemBus.scala:40:43
    .auto_out_6_e_ready        (_system_bus_xbar_auto_in_6_e_ready),	// SystemBus.scala:40:43
    .auto_out_5_a_ready        (_system_bus_xbar_auto_in_5_a_ready),	// SystemBus.scala:40:43
    .auto_out_5_b_valid        (_system_bus_xbar_auto_in_5_b_valid),	// SystemBus.scala:40:43
    .auto_out_5_b_bits_param
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_b_bits_param),
    .auto_out_5_b_bits_source  (_system_bus_xbar_auto_in_5_b_bits_source),	// SystemBus.scala:40:43
    .auto_out_5_b_bits_address
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_b_bits_address),
    .auto_out_5_c_ready        (_system_bus_xbar_auto_in_5_c_ready),	// SystemBus.scala:40:43
    .auto_out_5_d_valid        (_system_bus_xbar_auto_in_5_d_valid),	// SystemBus.scala:40:43
    .auto_out_5_d_bits_opcode  (_system_bus_xbar_auto_in_5_d_bits_opcode),	// SystemBus.scala:40:43
    .auto_out_5_d_bits_param   (_system_bus_xbar_auto_in_5_d_bits_param),	// SystemBus.scala:40:43
    .auto_out_5_d_bits_size    (_system_bus_xbar_auto_in_5_d_bits_size),	// SystemBus.scala:40:43
    .auto_out_5_d_bits_source  (_system_bus_xbar_auto_in_5_d_bits_source),	// SystemBus.scala:40:43
    .auto_out_5_d_bits_sink    (_system_bus_xbar_auto_in_5_d_bits_sink),	// SystemBus.scala:40:43
    .auto_out_5_d_bits_denied  (_system_bus_xbar_auto_in_5_d_bits_denied),	// SystemBus.scala:40:43
    .auto_out_5_d_bits_corrupt (_system_bus_xbar_auto_in_5_d_bits_corrupt),	// SystemBus.scala:40:43
    .auto_out_5_e_ready        (_system_bus_xbar_auto_in_5_e_ready),	// SystemBus.scala:40:43
    .auto_out_4_a_ready        (_system_bus_xbar_auto_in_4_a_ready),	// SystemBus.scala:40:43
    .auto_out_4_b_valid        (_system_bus_xbar_auto_in_4_b_valid),	// SystemBus.scala:40:43
    .auto_out_4_b_bits_param
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_b_bits_param),
    .auto_out_4_b_bits_source  (_system_bus_xbar_auto_in_4_b_bits_source),	// SystemBus.scala:40:43
    .auto_out_4_b_bits_address
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_b_bits_address),
    .auto_out_4_c_ready        (_system_bus_xbar_auto_in_4_c_ready),	// SystemBus.scala:40:43
    .auto_out_4_d_valid        (_system_bus_xbar_auto_in_4_d_valid),	// SystemBus.scala:40:43
    .auto_out_4_d_bits_opcode  (_system_bus_xbar_auto_in_4_d_bits_opcode),	// SystemBus.scala:40:43
    .auto_out_4_d_bits_param   (_system_bus_xbar_auto_in_4_d_bits_param),	// SystemBus.scala:40:43
    .auto_out_4_d_bits_size    (_system_bus_xbar_auto_in_4_d_bits_size),	// SystemBus.scala:40:43
    .auto_out_4_d_bits_source  (_system_bus_xbar_auto_in_4_d_bits_source),	// SystemBus.scala:40:43
    .auto_out_4_d_bits_sink    (_system_bus_xbar_auto_in_4_d_bits_sink),	// SystemBus.scala:40:43
    .auto_out_4_d_bits_denied  (_system_bus_xbar_auto_in_4_d_bits_denied),	// SystemBus.scala:40:43
    .auto_out_4_d_bits_corrupt (_system_bus_xbar_auto_in_4_d_bits_corrupt),	// SystemBus.scala:40:43
    .auto_out_4_e_ready        (_system_bus_xbar_auto_in_4_e_ready),	// SystemBus.scala:40:43
    .auto_out_3_a_ready        (_system_bus_xbar_auto_in_3_a_ready),	// SystemBus.scala:40:43
    .auto_out_3_b_valid        (_system_bus_xbar_auto_in_3_b_valid),	// SystemBus.scala:40:43
    .auto_out_3_b_bits_param
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_b_bits_param),
    .auto_out_3_b_bits_source  (_system_bus_xbar_auto_in_3_b_bits_source),	// SystemBus.scala:40:43
    .auto_out_3_b_bits_address
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_b_bits_address),
    .auto_out_3_c_ready        (_system_bus_xbar_auto_in_3_c_ready),	// SystemBus.scala:40:43
    .auto_out_3_d_valid        (_system_bus_xbar_auto_in_3_d_valid),	// SystemBus.scala:40:43
    .auto_out_3_d_bits_opcode  (_system_bus_xbar_auto_in_3_d_bits_opcode),	// SystemBus.scala:40:43
    .auto_out_3_d_bits_param   (_system_bus_xbar_auto_in_3_d_bits_param),	// SystemBus.scala:40:43
    .auto_out_3_d_bits_size    (_system_bus_xbar_auto_in_3_d_bits_size),	// SystemBus.scala:40:43
    .auto_out_3_d_bits_source  (_system_bus_xbar_auto_in_3_d_bits_source),	// SystemBus.scala:40:43
    .auto_out_3_d_bits_sink    (_system_bus_xbar_auto_in_3_d_bits_sink),	// SystemBus.scala:40:43
    .auto_out_3_d_bits_denied  (_system_bus_xbar_auto_in_3_d_bits_denied),	// SystemBus.scala:40:43
    .auto_out_3_d_bits_corrupt (_system_bus_xbar_auto_in_3_d_bits_corrupt),	// SystemBus.scala:40:43
    .auto_out_3_e_ready        (_system_bus_xbar_auto_in_3_e_ready),	// SystemBus.scala:40:43
    .auto_out_2_a_ready        (_system_bus_xbar_auto_in_2_a_ready),	// SystemBus.scala:40:43
    .auto_out_2_b_valid        (_system_bus_xbar_auto_in_2_b_valid),	// SystemBus.scala:40:43
    .auto_out_2_b_bits_param
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_b_bits_param),
    .auto_out_2_b_bits_source  (_system_bus_xbar_auto_in_2_b_bits_source),	// SystemBus.scala:40:43
    .auto_out_2_b_bits_address
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_b_bits_address),
    .auto_out_2_c_ready        (_system_bus_xbar_auto_in_2_c_ready),	// SystemBus.scala:40:43
    .auto_out_2_d_valid        (_system_bus_xbar_auto_in_2_d_valid),	// SystemBus.scala:40:43
    .auto_out_2_d_bits_opcode  (_system_bus_xbar_auto_in_2_d_bits_opcode),	// SystemBus.scala:40:43
    .auto_out_2_d_bits_param   (_system_bus_xbar_auto_in_2_d_bits_param),	// SystemBus.scala:40:43
    .auto_out_2_d_bits_size    (_system_bus_xbar_auto_in_2_d_bits_size),	// SystemBus.scala:40:43
    .auto_out_2_d_bits_source  (_system_bus_xbar_auto_in_2_d_bits_source),	// SystemBus.scala:40:43
    .auto_out_2_d_bits_sink    (_system_bus_xbar_auto_in_2_d_bits_sink),	// SystemBus.scala:40:43
    .auto_out_2_d_bits_denied  (_system_bus_xbar_auto_in_2_d_bits_denied),	// SystemBus.scala:40:43
    .auto_out_2_d_bits_corrupt (_system_bus_xbar_auto_in_2_d_bits_corrupt),	// SystemBus.scala:40:43
    .auto_out_2_e_ready        (_system_bus_xbar_auto_in_2_e_ready),	// SystemBus.scala:40:43
    .auto_out_1_a_ready        (_system_bus_xbar_auto_in_1_a_ready),	// SystemBus.scala:40:43
    .auto_out_1_b_valid        (_system_bus_xbar_auto_in_1_b_valid),	// SystemBus.scala:40:43
    .auto_out_1_b_bits_param
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_b_bits_param),
    .auto_out_1_b_bits_source  (_system_bus_xbar_auto_in_1_b_bits_source),	// SystemBus.scala:40:43
    .auto_out_1_b_bits_address
      (auto_coupler_to_bus_named_subsystem_l2_widget_out_b_bits_address),
    .auto_out_1_c_ready        (_system_bus_xbar_auto_in_1_c_ready),	// SystemBus.scala:40:43
    .auto_out_1_d_valid        (_system_bus_xbar_auto_in_1_d_valid),	// SystemBus.scala:40:43
    .auto_out_1_d_bits_opcode  (_system_bus_xbar_auto_in_1_d_bits_opcode),	// SystemBus.scala:40:43
    .auto_out_1_d_bits_param   (_system_bus_xbar_auto_in_1_d_bits_param),	// SystemBus.scala:40:43
    .auto_out_1_d_bits_size    (_system_bus_xbar_auto_in_1_d_bits_size),	// SystemBus.scala:40:43
    .auto_out_1_d_bits_source  (_system_bus_xbar_auto_in_1_d_bits_source),	// SystemBus.scala:40:43
    .auto_out_1_d_bits_sink    (_system_bus_xbar_auto_in_1_d_bits_sink),	// SystemBus.scala:40:43
    .auto_out_1_d_bits_denied  (_system_bus_xbar_auto_in_1_d_bits_denied),	// SystemBus.scala:40:43
    .auto_out_1_d_bits_corrupt (_system_bus_xbar_auto_in_1_d_bits_corrupt),	// SystemBus.scala:40:43
    .auto_out_1_e_ready        (_system_bus_xbar_auto_in_1_e_ready),	// SystemBus.scala:40:43
    .auto_out_0_a_ready        (_system_bus_xbar_auto_in_0_a_ready),	// SystemBus.scala:40:43
    .auto_out_0_d_valid        (_system_bus_xbar_auto_in_0_d_valid),	// SystemBus.scala:40:43
    .auto_out_0_d_bits_opcode  (_system_bus_xbar_auto_in_0_d_bits_opcode),	// SystemBus.scala:40:43
    .auto_out_0_d_bits_param   (_system_bus_xbar_auto_in_0_d_bits_param),	// SystemBus.scala:40:43
    .auto_out_0_d_bits_size    (_system_bus_xbar_auto_in_0_d_bits_size),	// SystemBus.scala:40:43
    .auto_out_0_d_bits_sink    (_system_bus_xbar_auto_in_0_d_bits_sink),	// SystemBus.scala:40:43
    .auto_out_0_d_bits_denied  (_system_bus_xbar_auto_in_0_d_bits_denied),	// SystemBus.scala:40:43
    .auto_out_0_d_bits_corrupt (_system_bus_xbar_auto_in_0_d_bits_corrupt)	// SystemBus.scala:40:43
  );
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_a_ready =
    _system_bus_xbar_auto_in_6_a_ready;	// SystemBus.scala:40:43
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_b_valid =
    _system_bus_xbar_auto_in_6_b_valid;	// SystemBus.scala:40:43
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_b_bits_source =
    _system_bus_xbar_auto_in_6_b_bits_source;	// SystemBus.scala:40:43
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_c_ready =
    _system_bus_xbar_auto_in_6_c_ready;	// SystemBus.scala:40:43
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_valid =
    _system_bus_xbar_auto_in_6_d_valid;	// SystemBus.scala:40:43
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_opcode =
    _system_bus_xbar_auto_in_6_d_bits_opcode;	// SystemBus.scala:40:43
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_param =
    _system_bus_xbar_auto_in_6_d_bits_param;	// SystemBus.scala:40:43
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_size =
    _system_bus_xbar_auto_in_6_d_bits_size;	// SystemBus.scala:40:43
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_source =
    _system_bus_xbar_auto_in_6_d_bits_source;	// SystemBus.scala:40:43
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_sink =
    _system_bus_xbar_auto_in_6_d_bits_sink;	// SystemBus.scala:40:43
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_denied =
    _system_bus_xbar_auto_in_6_d_bits_denied;	// SystemBus.scala:40:43
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_d_bits_corrupt =
    _system_bus_xbar_auto_in_6_d_bits_corrupt;	// SystemBus.scala:40:43
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_2_e_ready =
    _system_bus_xbar_auto_in_6_e_ready;	// SystemBus.scala:40:43
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_a_ready =
    _system_bus_xbar_auto_in_5_a_ready;	// SystemBus.scala:40:43
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_b_valid =
    _system_bus_xbar_auto_in_5_b_valid;	// SystemBus.scala:40:43
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_b_bits_source =
    _system_bus_xbar_auto_in_5_b_bits_source;	// SystemBus.scala:40:43
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_c_ready =
    _system_bus_xbar_auto_in_5_c_ready;	// SystemBus.scala:40:43
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_valid =
    _system_bus_xbar_auto_in_5_d_valid;	// SystemBus.scala:40:43
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_opcode =
    _system_bus_xbar_auto_in_5_d_bits_opcode;	// SystemBus.scala:40:43
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_param =
    _system_bus_xbar_auto_in_5_d_bits_param;	// SystemBus.scala:40:43
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_size =
    _system_bus_xbar_auto_in_5_d_bits_size;	// SystemBus.scala:40:43
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_source =
    _system_bus_xbar_auto_in_5_d_bits_source;	// SystemBus.scala:40:43
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_sink =
    _system_bus_xbar_auto_in_5_d_bits_sink;	// SystemBus.scala:40:43
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_denied =
    _system_bus_xbar_auto_in_5_d_bits_denied;	// SystemBus.scala:40:43
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_d_bits_corrupt =
    _system_bus_xbar_auto_in_5_d_bits_corrupt;	// SystemBus.scala:40:43
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_1_e_ready =
    _system_bus_xbar_auto_in_5_e_ready;	// SystemBus.scala:40:43
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_a_ready =
    _system_bus_xbar_auto_in_4_a_ready;	// SystemBus.scala:40:43
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_b_valid =
    _system_bus_xbar_auto_in_4_b_valid;	// SystemBus.scala:40:43
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_b_bits_source =
    _system_bus_xbar_auto_in_4_b_bits_source;	// SystemBus.scala:40:43
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_c_ready =
    _system_bus_xbar_auto_in_4_c_ready;	// SystemBus.scala:40:43
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_valid =
    _system_bus_xbar_auto_in_4_d_valid;	// SystemBus.scala:40:43
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_opcode =
    _system_bus_xbar_auto_in_4_d_bits_opcode;	// SystemBus.scala:40:43
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_param =
    _system_bus_xbar_auto_in_4_d_bits_param;	// SystemBus.scala:40:43
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_size =
    _system_bus_xbar_auto_in_4_d_bits_size;	// SystemBus.scala:40:43
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_source =
    _system_bus_xbar_auto_in_4_d_bits_source;	// SystemBus.scala:40:43
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_sink =
    _system_bus_xbar_auto_in_4_d_bits_sink;	// SystemBus.scala:40:43
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_denied =
    _system_bus_xbar_auto_in_4_d_bits_denied;	// SystemBus.scala:40:43
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_d_bits_corrupt =
    _system_bus_xbar_auto_in_4_d_bits_corrupt;	// SystemBus.scala:40:43
  assign auto_coupler_from_boom_tile_tl_master_clock_xing_in_0_e_ready =
    _system_bus_xbar_auto_in_4_e_ready;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_2_a_ready =
    _system_bus_xbar_auto_in_3_a_ready;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_2_b_valid =
    _system_bus_xbar_auto_in_3_b_valid;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_2_b_bits_source =
    _system_bus_xbar_auto_in_3_b_bits_source;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_2_c_ready =
    _system_bus_xbar_auto_in_3_c_ready;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_2_d_valid =
    _system_bus_xbar_auto_in_3_d_valid;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_opcode =
    _system_bus_xbar_auto_in_3_d_bits_opcode;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_param =
    _system_bus_xbar_auto_in_3_d_bits_param;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_size =
    _system_bus_xbar_auto_in_3_d_bits_size;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_source =
    _system_bus_xbar_auto_in_3_d_bits_source;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_sink =
    _system_bus_xbar_auto_in_3_d_bits_sink;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_denied =
    _system_bus_xbar_auto_in_3_d_bits_denied;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_2_d_bits_corrupt =
    _system_bus_xbar_auto_in_3_d_bits_corrupt;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_2_e_ready =
    _system_bus_xbar_auto_in_3_e_ready;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_1_a_ready =
    _system_bus_xbar_auto_in_2_a_ready;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_1_b_valid =
    _system_bus_xbar_auto_in_2_b_valid;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_1_b_bits_source =
    _system_bus_xbar_auto_in_2_b_bits_source;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_1_c_ready =
    _system_bus_xbar_auto_in_2_c_ready;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_1_d_valid =
    _system_bus_xbar_auto_in_2_d_valid;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_opcode =
    _system_bus_xbar_auto_in_2_d_bits_opcode;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_param =
    _system_bus_xbar_auto_in_2_d_bits_param;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_size =
    _system_bus_xbar_auto_in_2_d_bits_size;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_source =
    _system_bus_xbar_auto_in_2_d_bits_source;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_sink =
    _system_bus_xbar_auto_in_2_d_bits_sink;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_denied =
    _system_bus_xbar_auto_in_2_d_bits_denied;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_1_d_bits_corrupt =
    _system_bus_xbar_auto_in_2_d_bits_corrupt;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_1_e_ready =
    _system_bus_xbar_auto_in_2_e_ready;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_0_a_ready =
    _system_bus_xbar_auto_in_1_a_ready;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_0_b_valid =
    _system_bus_xbar_auto_in_1_b_valid;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_0_b_bits_source =
    _system_bus_xbar_auto_in_1_b_bits_source;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_0_c_ready =
    _system_bus_xbar_auto_in_1_c_ready;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_0_d_valid =
    _system_bus_xbar_auto_in_1_d_valid;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_opcode =
    _system_bus_xbar_auto_in_1_d_bits_opcode;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_param =
    _system_bus_xbar_auto_in_1_d_bits_param;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_size =
    _system_bus_xbar_auto_in_1_d_bits_size;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_source =
    _system_bus_xbar_auto_in_1_d_bits_source;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_sink =
    _system_bus_xbar_auto_in_1_d_bits_sink;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_denied =
    _system_bus_xbar_auto_in_1_d_bits_denied;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_0_d_bits_corrupt =
    _system_bus_xbar_auto_in_1_d_bits_corrupt;	// SystemBus.scala:40:43
  assign auto_coupler_from_tile_tl_master_clock_xing_in_0_e_ready =
    _system_bus_xbar_auto_in_1_e_ready;	// SystemBus.scala:40:43
  assign auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_a_ready =
    _system_bus_xbar_auto_in_0_a_ready;	// SystemBus.scala:40:43
  assign auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_valid =
    _system_bus_xbar_auto_in_0_d_valid;	// SystemBus.scala:40:43
  assign auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_opcode =
    _system_bus_xbar_auto_in_0_d_bits_opcode;	// SystemBus.scala:40:43
  assign auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_param =
    _system_bus_xbar_auto_in_0_d_bits_param;	// SystemBus.scala:40:43
  assign auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_size =
    _system_bus_xbar_auto_in_0_d_bits_size;	// SystemBus.scala:40:43
  assign auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_sink =
    _system_bus_xbar_auto_in_0_d_bits_sink;	// SystemBus.scala:40:43
  assign auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_denied =
    _system_bus_xbar_auto_in_0_d_bits_denied;	// SystemBus.scala:40:43
  assign auto_coupler_from_bus_named_subsystem_fbus_bus_xing_in_d_bits_corrupt =
    _system_bus_xbar_auto_in_0_d_bits_corrupt;	// SystemBus.scala:40:43
endmodule

