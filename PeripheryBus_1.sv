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

module PeripheryBus_1(
  input         auto_coupler_to_bootrom_fragmenter_out_a_ready,
                auto_coupler_to_bootrom_fragmenter_out_d_valid,
  input  [1:0]  auto_coupler_to_bootrom_fragmenter_out_d_bits_size,
  input  [11:0] auto_coupler_to_bootrom_fragmenter_out_d_bits_source,
  input  [63:0] auto_coupler_to_bootrom_fragmenter_out_d_bits_data,
  input         auto_coupler_to_debug_fragmenter_out_a_ready,
                auto_coupler_to_debug_fragmenter_out_d_valid,
  input  [2:0]  auto_coupler_to_debug_fragmenter_out_d_bits_opcode,
  input  [1:0]  auto_coupler_to_debug_fragmenter_out_d_bits_size,
  input  [11:0] auto_coupler_to_debug_fragmenter_out_d_bits_source,
  input  [63:0] auto_coupler_to_debug_fragmenter_out_d_bits_data,
  input         auto_coupler_to_clint_fragmenter_out_a_ready,
                auto_coupler_to_clint_fragmenter_out_d_valid,
  input  [2:0]  auto_coupler_to_clint_fragmenter_out_d_bits_opcode,
  input  [1:0]  auto_coupler_to_clint_fragmenter_out_d_bits_size,
  input  [11:0] auto_coupler_to_clint_fragmenter_out_d_bits_source,
  input  [63:0] auto_coupler_to_clint_fragmenter_out_d_bits_data,
  input         auto_coupler_to_plic_fragmenter_out_a_ready,
                auto_coupler_to_plic_fragmenter_out_d_valid,
  input  [2:0]  auto_coupler_to_plic_fragmenter_out_d_bits_opcode,
  input  [1:0]  auto_coupler_to_plic_fragmenter_out_d_bits_size,
  input  [11:0] auto_coupler_to_plic_fragmenter_out_d_bits_source,
  input  [63:0] auto_coupler_to_plic_fragmenter_out_d_bits_data,
  input         auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_ready,
                auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_d_valid,
  input  [2:0]  auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_d_bits_opcode,
  input  [1:0]  auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_d_bits_param,
  input  [2:0]  auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_d_bits_size,
  input  [7:0]  auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_d_bits_source,
  input         auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_d_bits_sink,
                auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_d_bits_denied,
  input  [63:0] auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_d_bits_data,
  input         auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_d_bits_corrupt,
                auto_coupler_to_l2_ctrl_buffer_out_a_ready,
                auto_coupler_to_l2_ctrl_buffer_out_d_valid,
  input  [2:0]  auto_coupler_to_l2_ctrl_buffer_out_d_bits_opcode,
  input  [1:0]  auto_coupler_to_l2_ctrl_buffer_out_d_bits_size,
  input  [11:0] auto_coupler_to_l2_ctrl_buffer_out_d_bits_source,
  input  [63:0] auto_coupler_to_l2_ctrl_buffer_out_d_bits_data,
  input         auto_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_clock,
                auto_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_reset,
                auto_bus_xing_in_a_valid,
  input  [2:0]  auto_bus_xing_in_a_bits_opcode,
                auto_bus_xing_in_a_bits_param,
  input  [3:0]  auto_bus_xing_in_a_bits_size,
  input  [6:0]  auto_bus_xing_in_a_bits_source,
  input  [30:0] auto_bus_xing_in_a_bits_address,
  input  [7:0]  auto_bus_xing_in_a_bits_mask,
  input  [63:0] auto_bus_xing_in_a_bits_data,
  input         auto_bus_xing_in_a_bits_corrupt,
                auto_bus_xing_in_d_ready,
                custom_boot,
  output        auto_coupler_to_bootrom_fragmenter_out_a_valid,
  output [2:0]  auto_coupler_to_bootrom_fragmenter_out_a_bits_opcode,
                auto_coupler_to_bootrom_fragmenter_out_a_bits_param,
  output [1:0]  auto_coupler_to_bootrom_fragmenter_out_a_bits_size,
  output [11:0] auto_coupler_to_bootrom_fragmenter_out_a_bits_source,
  output [16:0] auto_coupler_to_bootrom_fragmenter_out_a_bits_address,
  output [7:0]  auto_coupler_to_bootrom_fragmenter_out_a_bits_mask,
  output        auto_coupler_to_bootrom_fragmenter_out_a_bits_corrupt,
                auto_coupler_to_bootrom_fragmenter_out_d_ready,
                auto_coupler_to_debug_fragmenter_out_a_valid,
  output [2:0]  auto_coupler_to_debug_fragmenter_out_a_bits_opcode,
                auto_coupler_to_debug_fragmenter_out_a_bits_param,
  output [1:0]  auto_coupler_to_debug_fragmenter_out_a_bits_size,
  output [11:0] auto_coupler_to_debug_fragmenter_out_a_bits_source,
                auto_coupler_to_debug_fragmenter_out_a_bits_address,
  output [7:0]  auto_coupler_to_debug_fragmenter_out_a_bits_mask,
  output [63:0] auto_coupler_to_debug_fragmenter_out_a_bits_data,
  output        auto_coupler_to_debug_fragmenter_out_a_bits_corrupt,
                auto_coupler_to_debug_fragmenter_out_d_ready,
                auto_coupler_to_clint_fragmenter_out_a_valid,
  output [2:0]  auto_coupler_to_clint_fragmenter_out_a_bits_opcode,
                auto_coupler_to_clint_fragmenter_out_a_bits_param,
  output [1:0]  auto_coupler_to_clint_fragmenter_out_a_bits_size,
  output [11:0] auto_coupler_to_clint_fragmenter_out_a_bits_source,
  output [25:0] auto_coupler_to_clint_fragmenter_out_a_bits_address,
  output [7:0]  auto_coupler_to_clint_fragmenter_out_a_bits_mask,
  output [63:0] auto_coupler_to_clint_fragmenter_out_a_bits_data,
  output        auto_coupler_to_clint_fragmenter_out_a_bits_corrupt,
                auto_coupler_to_clint_fragmenter_out_d_ready,
                auto_coupler_to_plic_fragmenter_out_a_valid,
  output [2:0]  auto_coupler_to_plic_fragmenter_out_a_bits_opcode,
                auto_coupler_to_plic_fragmenter_out_a_bits_param,
  output [1:0]  auto_coupler_to_plic_fragmenter_out_a_bits_size,
  output [11:0] auto_coupler_to_plic_fragmenter_out_a_bits_source,
  output [27:0] auto_coupler_to_plic_fragmenter_out_a_bits_address,
  output [7:0]  auto_coupler_to_plic_fragmenter_out_a_bits_mask,
  output [63:0] auto_coupler_to_plic_fragmenter_out_a_bits_data,
  output        auto_coupler_to_plic_fragmenter_out_a_bits_corrupt,
                auto_coupler_to_plic_fragmenter_out_d_ready,
                auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_valid,
  output [2:0]  auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_opcode,
                auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_param,
                auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_size,
  output [7:0]  auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_source,
  output [30:0] auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_address,
  output [7:0]  auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_mask,
  output [63:0] auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_data,
  output        auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_corrupt,
                auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_d_ready,
                auto_coupler_to_l2_ctrl_buffer_out_a_valid,
  output [2:0]  auto_coupler_to_l2_ctrl_buffer_out_a_bits_opcode,
                auto_coupler_to_l2_ctrl_buffer_out_a_bits_param,
  output [1:0]  auto_coupler_to_l2_ctrl_buffer_out_a_bits_size,
  output [11:0] auto_coupler_to_l2_ctrl_buffer_out_a_bits_source,
  output [25:0] auto_coupler_to_l2_ctrl_buffer_out_a_bits_address,
  output [7:0]  auto_coupler_to_l2_ctrl_buffer_out_a_bits_mask,
  output [63:0] auto_coupler_to_l2_ctrl_buffer_out_a_bits_data,
  output        auto_coupler_to_l2_ctrl_buffer_out_a_bits_corrupt,
                auto_coupler_to_l2_ctrl_buffer_out_d_ready,
                auto_bus_xing_in_a_ready,
                auto_bus_xing_in_d_valid,
  output [2:0]  auto_bus_xing_in_d_bits_opcode,
  output [1:0]  auto_bus_xing_in_d_bits_param,
  output [3:0]  auto_bus_xing_in_d_bits_size,
  output [6:0]  auto_bus_xing_in_d_bits_source,
  output        auto_bus_xing_in_d_bits_sink,
                auto_bus_xing_in_d_bits_denied,
  output [63:0] auto_bus_xing_in_d_bits_data,
  output        auto_bus_xing_in_d_bits_corrupt
);

  wire        _coupler_to_bootrom_auto_tl_in_a_ready;	// LazyModule.scala:432:27
  wire [2:0]  _coupler_to_bootrom_auto_tl_in_d_bits_size;	// LazyModule.scala:432:27
  wire [7:0]  _coupler_to_bootrom_auto_tl_in_d_bits_source;	// LazyModule.scala:432:27
  wire        _coupler_to_debug_auto_tl_in_a_ready;	// LazyModule.scala:432:27
  wire        _coupler_to_debug_auto_tl_in_d_valid;	// LazyModule.scala:432:27
  wire [2:0]  _coupler_to_debug_auto_tl_in_d_bits_size;	// LazyModule.scala:432:27
  wire [7:0]  _coupler_to_debug_auto_tl_in_d_bits_source;	// LazyModule.scala:432:27
  wire        _coupler_to_clint_auto_tl_in_a_ready;	// LazyModule.scala:432:27
  wire        _coupler_to_clint_auto_tl_in_d_valid;	// LazyModule.scala:432:27
  wire [2:0]  _coupler_to_clint_auto_tl_in_d_bits_size;	// LazyModule.scala:432:27
  wire [7:0]  _coupler_to_clint_auto_tl_in_d_bits_source;	// LazyModule.scala:432:27
  wire        _coupler_to_plic_auto_tl_in_a_ready;	// LazyModule.scala:432:27
  wire        _coupler_to_plic_auto_tl_in_d_valid;	// LazyModule.scala:432:27
  wire [2:0]  _coupler_to_plic_auto_tl_in_d_bits_size;	// LazyModule.scala:432:27
  wire [7:0]  _coupler_to_plic_auto_tl_in_d_bits_source;	// LazyModule.scala:432:27
  wire        _coupler_to_l2_ctrl_auto_tl_in_a_ready;	// LazyModule.scala:432:27
  wire        _coupler_to_l2_ctrl_auto_tl_in_d_valid;	// LazyModule.scala:432:27
  wire [2:0]  _coupler_to_l2_ctrl_auto_tl_in_d_bits_opcode;	// LazyModule.scala:432:27
  wire [1:0]  _coupler_to_l2_ctrl_auto_tl_in_d_bits_param;	// LazyModule.scala:432:27
  wire [2:0]  _coupler_to_l2_ctrl_auto_tl_in_d_bits_size;	// LazyModule.scala:432:27
  wire [7:0]  _coupler_to_l2_ctrl_auto_tl_in_d_bits_source;	// LazyModule.scala:432:27
  wire        _coupler_to_l2_ctrl_auto_tl_in_d_bits_sink;	// LazyModule.scala:432:27
  wire        _coupler_to_l2_ctrl_auto_tl_in_d_bits_denied;	// LazyModule.scala:432:27
  wire [63:0] _coupler_to_l2_ctrl_auto_tl_in_d_bits_data;	// LazyModule.scala:432:27
  wire        _coupler_to_l2_ctrl_auto_tl_in_d_bits_corrupt;	// LazyModule.scala:432:27
  wire        _wrapped_error_device_auto_buffer_in_a_ready;	// LazyModule.scala:432:27
  wire        _wrapped_error_device_auto_buffer_in_d_valid;	// LazyModule.scala:432:27
  wire [2:0]  _wrapped_error_device_auto_buffer_in_d_bits_opcode;	// LazyModule.scala:432:27
  wire [1:0]  _wrapped_error_device_auto_buffer_in_d_bits_param;	// LazyModule.scala:432:27
  wire [3:0]  _wrapped_error_device_auto_buffer_in_d_bits_size;	// LazyModule.scala:432:27
  wire [7:0]  _wrapped_error_device_auto_buffer_in_d_bits_source;	// LazyModule.scala:432:27
  wire        _wrapped_error_device_auto_buffer_in_d_bits_sink;	// LazyModule.scala:432:27
  wire        _wrapped_error_device_auto_buffer_in_d_bits_denied;	// LazyModule.scala:432:27
  wire [63:0] _wrapped_error_device_auto_buffer_in_d_bits_data;	// LazyModule.scala:432:27
  wire        _wrapped_error_device_auto_buffer_in_d_bits_corrupt;	// LazyModule.scala:432:27
  wire        _atomics_auto_in_a_ready;	// AtomicAutomata.scala:283:29
  wire        _atomics_auto_in_d_valid;	// AtomicAutomata.scala:283:29
  wire [2:0]  _atomics_auto_in_d_bits_opcode;	// AtomicAutomata.scala:283:29
  wire        _atomics_auto_in_d_bits_denied;	// AtomicAutomata.scala:283:29
  wire        _atomics_auto_in_d_bits_corrupt;	// AtomicAutomata.scala:283:29
  wire        _atomics_auto_out_a_valid;	// AtomicAutomata.scala:283:29
  wire [2:0]  _atomics_auto_out_a_bits_opcode;	// AtomicAutomata.scala:283:29
  wire [2:0]  _atomics_auto_out_a_bits_param;	// AtomicAutomata.scala:283:29
  wire [3:0]  _atomics_auto_out_a_bits_size;	// AtomicAutomata.scala:283:29
  wire [7:0]  _atomics_auto_out_a_bits_source;	// AtomicAutomata.scala:283:29
  wire [30:0] _atomics_auto_out_a_bits_address;	// AtomicAutomata.scala:283:29
  wire [7:0]  _atomics_auto_out_a_bits_mask;	// AtomicAutomata.scala:283:29
  wire [63:0] _atomics_auto_out_a_bits_data;	// AtomicAutomata.scala:283:29
  wire        _atomics_auto_out_a_bits_corrupt;	// AtomicAutomata.scala:283:29
  wire        _atomics_auto_out_d_ready;	// AtomicAutomata.scala:283:29
  wire        _buffer_auto_in_a_ready;	// Buffer.scala:68:28
  wire        _buffer_auto_in_d_valid;	// Buffer.scala:68:28
  wire [2:0]  _buffer_auto_in_d_bits_opcode;	// Buffer.scala:68:28
  wire [1:0]  _buffer_auto_in_d_bits_param;	// Buffer.scala:68:28
  wire [3:0]  _buffer_auto_in_d_bits_size;	// Buffer.scala:68:28
  wire [7:0]  _buffer_auto_in_d_bits_source;	// Buffer.scala:68:28
  wire        _buffer_auto_in_d_bits_sink;	// Buffer.scala:68:28
  wire        _buffer_auto_in_d_bits_denied;	// Buffer.scala:68:28
  wire [63:0] _buffer_auto_in_d_bits_data;	// Buffer.scala:68:28
  wire        _buffer_auto_in_d_bits_corrupt;	// Buffer.scala:68:28
  wire        _buffer_auto_out_a_valid;	// Buffer.scala:68:28
  wire [2:0]  _buffer_auto_out_a_bits_opcode;	// Buffer.scala:68:28
  wire [2:0]  _buffer_auto_out_a_bits_param;	// Buffer.scala:68:28
  wire [3:0]  _buffer_auto_out_a_bits_size;	// Buffer.scala:68:28
  wire [7:0]  _buffer_auto_out_a_bits_source;	// Buffer.scala:68:28
  wire [30:0] _buffer_auto_out_a_bits_address;	// Buffer.scala:68:28
  wire [7:0]  _buffer_auto_out_a_bits_mask;	// Buffer.scala:68:28
  wire [63:0] _buffer_auto_out_a_bits_data;	// Buffer.scala:68:28
  wire        _buffer_auto_out_a_bits_corrupt;	// Buffer.scala:68:28
  wire        _buffer_auto_out_d_ready;	// Buffer.scala:68:28
  wire        _out_xbar_auto_in_a_ready;	// PeripheryBus.scala:50:30
  wire        _out_xbar_auto_in_d_valid;	// PeripheryBus.scala:50:30
  wire [2:0]  _out_xbar_auto_in_d_bits_opcode;	// PeripheryBus.scala:50:30
  wire [1:0]  _out_xbar_auto_in_d_bits_param;	// PeripheryBus.scala:50:30
  wire [3:0]  _out_xbar_auto_in_d_bits_size;	// PeripheryBus.scala:50:30
  wire [7:0]  _out_xbar_auto_in_d_bits_source;	// PeripheryBus.scala:50:30
  wire        _out_xbar_auto_in_d_bits_sink;	// PeripheryBus.scala:50:30
  wire        _out_xbar_auto_in_d_bits_denied;	// PeripheryBus.scala:50:30
  wire [63:0] _out_xbar_auto_in_d_bits_data;	// PeripheryBus.scala:50:30
  wire        _out_xbar_auto_in_d_bits_corrupt;	// PeripheryBus.scala:50:30
  wire        _out_xbar_auto_out_6_a_valid;	// PeripheryBus.scala:50:30
  wire [2:0]  _out_xbar_auto_out_6_a_bits_size;	// PeripheryBus.scala:50:30
  wire [16:0] _out_xbar_auto_out_6_a_bits_address;	// PeripheryBus.scala:50:30
  wire        _out_xbar_auto_out_6_d_ready;	// PeripheryBus.scala:50:30
  wire        _out_xbar_auto_out_5_a_valid;	// PeripheryBus.scala:50:30
  wire [2:0]  _out_xbar_auto_out_5_a_bits_size;	// PeripheryBus.scala:50:30
  wire [11:0] _out_xbar_auto_out_5_a_bits_address;	// PeripheryBus.scala:50:30
  wire        _out_xbar_auto_out_5_d_ready;	// PeripheryBus.scala:50:30
  wire        _out_xbar_auto_out_4_a_valid;	// PeripheryBus.scala:50:30
  wire [2:0]  _out_xbar_auto_out_4_a_bits_size;	// PeripheryBus.scala:50:30
  wire [25:0] _out_xbar_auto_out_4_a_bits_address;	// PeripheryBus.scala:50:30
  wire        _out_xbar_auto_out_4_d_ready;	// PeripheryBus.scala:50:30
  wire        _out_xbar_auto_out_3_a_valid;	// PeripheryBus.scala:50:30
  wire [2:0]  _out_xbar_auto_out_3_a_bits_size;	// PeripheryBus.scala:50:30
  wire [27:0] _out_xbar_auto_out_3_a_bits_address;	// PeripheryBus.scala:50:30
  wire        _out_xbar_auto_out_3_d_ready;	// PeripheryBus.scala:50:30
  wire        _out_xbar_auto_out_1_a_valid;	// PeripheryBus.scala:50:30
  wire [2:0]  _out_xbar_auto_out_1_a_bits_size;	// PeripheryBus.scala:50:30
  wire [25:0] _out_xbar_auto_out_1_a_bits_address;	// PeripheryBus.scala:50:30
  wire        _out_xbar_auto_out_1_d_ready;	// PeripheryBus.scala:50:30
  wire        _out_xbar_auto_out_0_a_valid;	// PeripheryBus.scala:50:30
  wire [13:0] _out_xbar_auto_out_0_a_bits_address;	// PeripheryBus.scala:50:30
  wire        _out_xbar_auto_out_0_d_ready;	// PeripheryBus.scala:50:30
  wire        _in_xbar_auto_in_1_a_ready;	// PeripheryBus.scala:49:29
  wire        _in_xbar_auto_in_1_d_valid;	// PeripheryBus.scala:49:29
  wire        _in_xbar_auto_out_a_valid;	// PeripheryBus.scala:49:29
  wire [2:0]  _in_xbar_auto_out_a_bits_opcode;	// PeripheryBus.scala:49:29
  wire [2:0]  _in_xbar_auto_out_a_bits_param;	// PeripheryBus.scala:49:29
  wire [3:0]  _in_xbar_auto_out_a_bits_size;	// PeripheryBus.scala:49:29
  wire [7:0]  _in_xbar_auto_out_a_bits_source;	// PeripheryBus.scala:49:29
  wire [30:0] _in_xbar_auto_out_a_bits_address;	// PeripheryBus.scala:49:29
  wire [7:0]  _in_xbar_auto_out_a_bits_mask;	// PeripheryBus.scala:49:29
  wire [63:0] _in_xbar_auto_out_a_bits_data;	// PeripheryBus.scala:49:29
  wire        _in_xbar_auto_out_a_bits_corrupt;	// PeripheryBus.scala:49:29
  wire        _in_xbar_auto_out_d_ready;	// PeripheryBus.scala:49:29
  reg  [2:0]  state;	// CustomBootPin.scala:46:28
  wire        _GEN = state == 3'h1;	// Conditional.scala:37:30, CustomBootPin.scala:46:28, :51:54
  wire        bundleOut_0_1_a_valid = (|state) & (_GEN | state != 3'h2 & state == 3'h3);	// Conditional.scala:37:30, :39:67, :40:58, CustomBootPin.scala:46:28, :47:20, :53:24, :60:40, :62:68
  always @(posedge auto_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_clock) begin
    if (auto_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_reset)
      state <= 3'h0;	// CustomBootPin.scala:46:28
    else begin
      automatic logic            _GEN_0 =
        _in_xbar_auto_in_1_a_ready & bundleOut_0_1_a_valid;	// Conditional.scala:39:67, :40:58, CustomBootPin.scala:47:20, Decoupled.scala:40:37, PeripheryBus.scala:49:29
      automatic logic [2:0]      _GEN_1;	// Conditional.scala:39:67, CustomBootPin.scala:46:28, :74:{43,51}
      automatic logic [7:0][2:0] _GEN_2;	// Conditional.scala:37:30, :39:67, :40:58, CustomBootPin.scala:51:46, :60:32, :62:60, :71:32, :73:52
      _GEN_1 = state == 3'h5 & ~custom_boot ? 3'h0 : state;	// Conditional.scala:37:30, :39:67, CustomBootPin.scala:46:28, :73:60, :74:{29,43,51}
      _GEN_2 =
        {{_GEN_1},
         {_GEN_1},
         {_GEN_1},
         {_in_xbar_auto_in_1_d_valid ? 3'h5 : state},
         {_GEN_0 ? 3'h4 : state},
         {_in_xbar_auto_in_1_d_valid ? 3'h3 : state},
         {_GEN_0 ? 3'h2 : state},
         {custom_boot ? 3'h1 : state}};	// Conditional.scala:37:30, :39:67, :40:58, CustomBootPin.scala:46:28, :51:{46,54}, :60:{32,40}, :62:{60,68}, :71:{32,40}, :73:{52,60}, :74:{43,51}, Decoupled.scala:40:37, PeripheryBus.scala:49:29
      state <= _GEN_2[state];	// Conditional.scala:37:30, :39:67, :40:58, CustomBootPin.scala:46:28, :51:46, :60:32, :62:60, :71:32, :73:52
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:0];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        _RANDOM[/*Zero width*/ 1'b0] = `RANDOM;
        state = _RANDOM[/*Zero width*/ 1'b0][2:0];	// CustomBootPin.scala:46:28
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  TLFIFOFixer_2 fixer (	// PeripheryBus.scala:47:33
    .clock
      (auto_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_clock),
    .reset
      (auto_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_reset),
    .auto_in_a_valid         (_buffer_auto_out_a_valid),	// Buffer.scala:68:28
    .auto_in_a_bits_opcode   (_buffer_auto_out_a_bits_opcode),	// Buffer.scala:68:28
    .auto_in_a_bits_param    (_buffer_auto_out_a_bits_param),	// Buffer.scala:68:28
    .auto_in_a_bits_size     (_buffer_auto_out_a_bits_size),	// Buffer.scala:68:28
    .auto_in_a_bits_source   (_buffer_auto_out_a_bits_source),	// Buffer.scala:68:28
    .auto_in_a_bits_address  (_buffer_auto_out_a_bits_address),	// Buffer.scala:68:28
    .auto_in_a_bits_mask     (_buffer_auto_out_a_bits_mask),	// Buffer.scala:68:28
    .auto_in_a_bits_corrupt  (_buffer_auto_out_a_bits_corrupt),	// Buffer.scala:68:28
    .auto_in_d_ready         (_buffer_auto_out_d_ready),	// Buffer.scala:68:28
    .auto_out_a_ready        (_out_xbar_auto_in_a_ready),	// PeripheryBus.scala:50:30
    .auto_out_d_valid        (_out_xbar_auto_in_d_valid),	// PeripheryBus.scala:50:30
    .auto_out_d_bits_opcode  (_out_xbar_auto_in_d_bits_opcode),	// PeripheryBus.scala:50:30
    .auto_out_d_bits_param   (_out_xbar_auto_in_d_bits_param),	// PeripheryBus.scala:50:30
    .auto_out_d_bits_size    (_out_xbar_auto_in_d_bits_size),	// PeripheryBus.scala:50:30
    .auto_out_d_bits_source  (_out_xbar_auto_in_d_bits_source),	// PeripheryBus.scala:50:30
    .auto_out_d_bits_sink    (_out_xbar_auto_in_d_bits_sink),	// PeripheryBus.scala:50:30
    .auto_out_d_bits_denied  (_out_xbar_auto_in_d_bits_denied),	// PeripheryBus.scala:50:30
    .auto_out_d_bits_corrupt (_out_xbar_auto_in_d_bits_corrupt)	// PeripheryBus.scala:50:30
  );
  TLXbar_4 in_xbar (	// PeripheryBus.scala:49:29
    .clock
      (auto_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_clock),
    .reset
      (auto_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_reset),
    .auto_in_1_a_valid        (bundleOut_0_1_a_valid),	// Conditional.scala:39:67, :40:58, CustomBootPin.scala:47:20
    .auto_in_1_a_bits_address (_GEN ? 31'h4000 : 31'h2000000),	// Conditional.scala:37:30, :39:67, CustomBootPin.scala:54:23, Edges.scala:470:15
    .auto_in_1_a_bits_data    (_GEN ? 64'h80000000 : 64'h1),	// Conditional.scala:37:30, :39:67, CustomBootPin.scala:54:23, Edges.scala:472:15
    .auto_in_0_a_valid        (auto_bus_xing_in_a_valid),
    .auto_in_0_a_bits_opcode  (auto_bus_xing_in_a_bits_opcode),
    .auto_in_0_a_bits_param   (auto_bus_xing_in_a_bits_param),
    .auto_in_0_a_bits_size    (auto_bus_xing_in_a_bits_size),
    .auto_in_0_a_bits_source  (auto_bus_xing_in_a_bits_source),
    .auto_in_0_a_bits_address (auto_bus_xing_in_a_bits_address),
    .auto_in_0_a_bits_mask    (auto_bus_xing_in_a_bits_mask),
    .auto_in_0_a_bits_data    (auto_bus_xing_in_a_bits_data),
    .auto_in_0_a_bits_corrupt (auto_bus_xing_in_a_bits_corrupt),
    .auto_in_0_d_ready        (auto_bus_xing_in_d_ready),
    .auto_out_a_ready         (_atomics_auto_in_a_ready),	// AtomicAutomata.scala:283:29
    .auto_out_d_valid         (_atomics_auto_in_d_valid),	// AtomicAutomata.scala:283:29
    .auto_out_d_bits_opcode   (_atomics_auto_in_d_bits_opcode),	// AtomicAutomata.scala:283:29
    .auto_out_d_bits_param    (_buffer_auto_in_d_bits_param),	// Buffer.scala:68:28
    .auto_out_d_bits_size     (_buffer_auto_in_d_bits_size),	// Buffer.scala:68:28
    .auto_out_d_bits_source   (_buffer_auto_in_d_bits_source),	// Buffer.scala:68:28
    .auto_out_d_bits_sink     (_buffer_auto_in_d_bits_sink),	// Buffer.scala:68:28
    .auto_out_d_bits_denied   (_atomics_auto_in_d_bits_denied),	// AtomicAutomata.scala:283:29
    .auto_out_d_bits_corrupt  (_atomics_auto_in_d_bits_corrupt),	// AtomicAutomata.scala:283:29
    .auto_in_1_a_ready        (_in_xbar_auto_in_1_a_ready),
    .auto_in_1_d_valid        (_in_xbar_auto_in_1_d_valid),
    .auto_in_0_a_ready        (auto_bus_xing_in_a_ready),
    .auto_in_0_d_valid        (auto_bus_xing_in_d_valid),
    .auto_in_0_d_bits_source  (auto_bus_xing_in_d_bits_source),
    .auto_out_a_valid         (_in_xbar_auto_out_a_valid),
    .auto_out_a_bits_opcode   (_in_xbar_auto_out_a_bits_opcode),
    .auto_out_a_bits_param    (_in_xbar_auto_out_a_bits_param),
    .auto_out_a_bits_size     (_in_xbar_auto_out_a_bits_size),
    .auto_out_a_bits_source   (_in_xbar_auto_out_a_bits_source),
    .auto_out_a_bits_address  (_in_xbar_auto_out_a_bits_address),
    .auto_out_a_bits_mask     (_in_xbar_auto_out_a_bits_mask),
    .auto_out_a_bits_data     (_in_xbar_auto_out_a_bits_data),
    .auto_out_a_bits_corrupt  (_in_xbar_auto_out_a_bits_corrupt),
    .auto_out_d_ready         (_in_xbar_auto_out_d_ready)
  );
  TLXbar_5 out_xbar (	// PeripheryBus.scala:50:30
    .clock
      (auto_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_clock),
    .reset
      (auto_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_reset),
    .auto_in_a_valid           (_buffer_auto_out_a_valid),	// Buffer.scala:68:28
    .auto_in_a_bits_opcode     (_buffer_auto_out_a_bits_opcode),	// Buffer.scala:68:28
    .auto_in_a_bits_param      (_buffer_auto_out_a_bits_param),	// Buffer.scala:68:28
    .auto_in_a_bits_size       (_buffer_auto_out_a_bits_size),	// Buffer.scala:68:28
    .auto_in_a_bits_source     (_buffer_auto_out_a_bits_source),	// Buffer.scala:68:28
    .auto_in_a_bits_address    (_buffer_auto_out_a_bits_address),	// Buffer.scala:68:28
    .auto_in_a_bits_mask       (_buffer_auto_out_a_bits_mask),	// Buffer.scala:68:28
    .auto_in_a_bits_corrupt    (_buffer_auto_out_a_bits_corrupt),	// Buffer.scala:68:28
    .auto_in_d_ready           (_buffer_auto_out_d_ready),	// Buffer.scala:68:28
    .auto_out_6_a_ready        (_coupler_to_bootrom_auto_tl_in_a_ready),	// LazyModule.scala:432:27
    .auto_out_6_d_valid        (auto_coupler_to_bootrom_fragmenter_out_d_valid),
    .auto_out_6_d_bits_size    (_coupler_to_bootrom_auto_tl_in_d_bits_size),	// LazyModule.scala:432:27
    .auto_out_6_d_bits_source  (_coupler_to_bootrom_auto_tl_in_d_bits_source),	// LazyModule.scala:432:27
    .auto_out_6_d_bits_data    (auto_coupler_to_bootrom_fragmenter_out_d_bits_data),
    .auto_out_5_a_ready        (_coupler_to_debug_auto_tl_in_a_ready),	// LazyModule.scala:432:27
    .auto_out_5_d_valid        (_coupler_to_debug_auto_tl_in_d_valid),	// LazyModule.scala:432:27
    .auto_out_5_d_bits_opcode  (auto_coupler_to_debug_fragmenter_out_d_bits_opcode),
    .auto_out_5_d_bits_size    (_coupler_to_debug_auto_tl_in_d_bits_size),	// LazyModule.scala:432:27
    .auto_out_5_d_bits_source  (_coupler_to_debug_auto_tl_in_d_bits_source),	// LazyModule.scala:432:27
    .auto_out_5_d_bits_data    (auto_coupler_to_debug_fragmenter_out_d_bits_data),
    .auto_out_4_a_ready        (_coupler_to_clint_auto_tl_in_a_ready),	// LazyModule.scala:432:27
    .auto_out_4_d_valid        (_coupler_to_clint_auto_tl_in_d_valid),	// LazyModule.scala:432:27
    .auto_out_4_d_bits_opcode  (auto_coupler_to_clint_fragmenter_out_d_bits_opcode),
    .auto_out_4_d_bits_size    (_coupler_to_clint_auto_tl_in_d_bits_size),	// LazyModule.scala:432:27
    .auto_out_4_d_bits_source  (_coupler_to_clint_auto_tl_in_d_bits_source),	// LazyModule.scala:432:27
    .auto_out_4_d_bits_data    (auto_coupler_to_clint_fragmenter_out_d_bits_data),
    .auto_out_3_a_ready        (_coupler_to_plic_auto_tl_in_a_ready),	// LazyModule.scala:432:27
    .auto_out_3_d_valid        (_coupler_to_plic_auto_tl_in_d_valid),	// LazyModule.scala:432:27
    .auto_out_3_d_bits_opcode  (auto_coupler_to_plic_fragmenter_out_d_bits_opcode),
    .auto_out_3_d_bits_size    (_coupler_to_plic_auto_tl_in_d_bits_size),	// LazyModule.scala:432:27
    .auto_out_3_d_bits_source  (_coupler_to_plic_auto_tl_in_d_bits_source),	// LazyModule.scala:432:27
    .auto_out_3_d_bits_data    (auto_coupler_to_plic_fragmenter_out_d_bits_data),
    .auto_out_2_a_ready
      (auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_ready),
    .auto_out_2_d_valid
      (auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_d_valid),
    .auto_out_2_d_bits_opcode
      (auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_d_bits_opcode),
    .auto_out_2_d_bits_param
      (auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_d_bits_param),
    .auto_out_2_d_bits_size
      (auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_d_bits_size),
    .auto_out_2_d_bits_source
      (auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_d_bits_source),
    .auto_out_2_d_bits_sink
      (auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_d_bits_sink),
    .auto_out_2_d_bits_denied
      (auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_d_bits_denied),
    .auto_out_2_d_bits_data
      (auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_d_bits_data),
    .auto_out_2_d_bits_corrupt
      (auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_d_bits_corrupt),
    .auto_out_1_a_ready        (_coupler_to_l2_ctrl_auto_tl_in_a_ready),	// LazyModule.scala:432:27
    .auto_out_1_d_valid        (_coupler_to_l2_ctrl_auto_tl_in_d_valid),	// LazyModule.scala:432:27
    .auto_out_1_d_bits_opcode  (_coupler_to_l2_ctrl_auto_tl_in_d_bits_opcode),	// LazyModule.scala:432:27
    .auto_out_1_d_bits_param   (_coupler_to_l2_ctrl_auto_tl_in_d_bits_param),	// LazyModule.scala:432:27
    .auto_out_1_d_bits_size    (_coupler_to_l2_ctrl_auto_tl_in_d_bits_size),	// LazyModule.scala:432:27
    .auto_out_1_d_bits_source  (_coupler_to_l2_ctrl_auto_tl_in_d_bits_source),	// LazyModule.scala:432:27
    .auto_out_1_d_bits_sink    (_coupler_to_l2_ctrl_auto_tl_in_d_bits_sink),	// LazyModule.scala:432:27
    .auto_out_1_d_bits_denied  (_coupler_to_l2_ctrl_auto_tl_in_d_bits_denied),	// LazyModule.scala:432:27
    .auto_out_1_d_bits_data    (_coupler_to_l2_ctrl_auto_tl_in_d_bits_data),	// LazyModule.scala:432:27
    .auto_out_1_d_bits_corrupt (_coupler_to_l2_ctrl_auto_tl_in_d_bits_corrupt),	// LazyModule.scala:432:27
    .auto_out_0_a_ready        (_wrapped_error_device_auto_buffer_in_a_ready),	// LazyModule.scala:432:27
    .auto_out_0_d_valid        (_wrapped_error_device_auto_buffer_in_d_valid),	// LazyModule.scala:432:27
    .auto_out_0_d_bits_opcode  (_wrapped_error_device_auto_buffer_in_d_bits_opcode),	// LazyModule.scala:432:27
    .auto_out_0_d_bits_param   (_wrapped_error_device_auto_buffer_in_d_bits_param),	// LazyModule.scala:432:27
    .auto_out_0_d_bits_size    (_wrapped_error_device_auto_buffer_in_d_bits_size),	// LazyModule.scala:432:27
    .auto_out_0_d_bits_source  (_wrapped_error_device_auto_buffer_in_d_bits_source),	// LazyModule.scala:432:27
    .auto_out_0_d_bits_sink    (_wrapped_error_device_auto_buffer_in_d_bits_sink),	// LazyModule.scala:432:27
    .auto_out_0_d_bits_denied  (_wrapped_error_device_auto_buffer_in_d_bits_denied),	// LazyModule.scala:432:27
    .auto_out_0_d_bits_data    (_wrapped_error_device_auto_buffer_in_d_bits_data),	// LazyModule.scala:432:27
    .auto_out_0_d_bits_corrupt (_wrapped_error_device_auto_buffer_in_d_bits_corrupt),	// LazyModule.scala:432:27
    .auto_in_a_ready           (_out_xbar_auto_in_a_ready),
    .auto_in_d_valid           (_out_xbar_auto_in_d_valid),
    .auto_in_d_bits_opcode     (_out_xbar_auto_in_d_bits_opcode),
    .auto_in_d_bits_param      (_out_xbar_auto_in_d_bits_param),
    .auto_in_d_bits_size       (_out_xbar_auto_in_d_bits_size),
    .auto_in_d_bits_source     (_out_xbar_auto_in_d_bits_source),
    .auto_in_d_bits_sink       (_out_xbar_auto_in_d_bits_sink),
    .auto_in_d_bits_denied     (_out_xbar_auto_in_d_bits_denied),
    .auto_in_d_bits_data       (_out_xbar_auto_in_d_bits_data),
    .auto_in_d_bits_corrupt    (_out_xbar_auto_in_d_bits_corrupt),
    .auto_out_6_a_valid        (_out_xbar_auto_out_6_a_valid),
    .auto_out_6_a_bits_size    (_out_xbar_auto_out_6_a_bits_size),
    .auto_out_6_a_bits_address (_out_xbar_auto_out_6_a_bits_address),
    .auto_out_6_d_ready        (_out_xbar_auto_out_6_d_ready),
    .auto_out_5_a_valid        (_out_xbar_auto_out_5_a_valid),
    .auto_out_5_a_bits_size    (_out_xbar_auto_out_5_a_bits_size),
    .auto_out_5_a_bits_address (_out_xbar_auto_out_5_a_bits_address),
    .auto_out_5_d_ready        (_out_xbar_auto_out_5_d_ready),
    .auto_out_4_a_valid        (_out_xbar_auto_out_4_a_valid),
    .auto_out_4_a_bits_size    (_out_xbar_auto_out_4_a_bits_size),
    .auto_out_4_a_bits_address (_out_xbar_auto_out_4_a_bits_address),
    .auto_out_4_d_ready        (_out_xbar_auto_out_4_d_ready),
    .auto_out_3_a_valid        (_out_xbar_auto_out_3_a_valid),
    .auto_out_3_a_bits_size    (_out_xbar_auto_out_3_a_bits_size),
    .auto_out_3_a_bits_address (_out_xbar_auto_out_3_a_bits_address),
    .auto_out_3_d_ready        (_out_xbar_auto_out_3_d_ready),
    .auto_out_2_a_valid
      (auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_valid),
    .auto_out_2_a_bits_size
      (auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_size),
    .auto_out_2_d_ready
      (auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_d_ready),
    .auto_out_1_a_valid        (_out_xbar_auto_out_1_a_valid),
    .auto_out_1_a_bits_size    (_out_xbar_auto_out_1_a_bits_size),
    .auto_out_1_a_bits_address (_out_xbar_auto_out_1_a_bits_address),
    .auto_out_1_d_ready        (_out_xbar_auto_out_1_d_ready),
    .auto_out_0_a_valid        (_out_xbar_auto_out_0_a_valid),
    .auto_out_0_a_bits_address (_out_xbar_auto_out_0_a_bits_address),
    .auto_out_0_d_ready        (_out_xbar_auto_out_0_d_ready)
  );
  TLBuffer_7 buffer (	// Buffer.scala:68:28
    .clock
      (auto_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_clock),
    .reset
      (auto_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_reset),
    .auto_in_a_valid         (_atomics_auto_out_a_valid),	// AtomicAutomata.scala:283:29
    .auto_in_a_bits_opcode   (_atomics_auto_out_a_bits_opcode),	// AtomicAutomata.scala:283:29
    .auto_in_a_bits_param    (_atomics_auto_out_a_bits_param),	// AtomicAutomata.scala:283:29
    .auto_in_a_bits_size     (_atomics_auto_out_a_bits_size),	// AtomicAutomata.scala:283:29
    .auto_in_a_bits_source   (_atomics_auto_out_a_bits_source),	// AtomicAutomata.scala:283:29
    .auto_in_a_bits_address  (_atomics_auto_out_a_bits_address),	// AtomicAutomata.scala:283:29
    .auto_in_a_bits_mask     (_atomics_auto_out_a_bits_mask),	// AtomicAutomata.scala:283:29
    .auto_in_a_bits_data     (_atomics_auto_out_a_bits_data),	// AtomicAutomata.scala:283:29
    .auto_in_a_bits_corrupt  (_atomics_auto_out_a_bits_corrupt),	// AtomicAutomata.scala:283:29
    .auto_in_d_ready         (_atomics_auto_out_d_ready),	// AtomicAutomata.scala:283:29
    .auto_out_a_ready        (_out_xbar_auto_in_a_ready),	// PeripheryBus.scala:50:30
    .auto_out_d_valid        (_out_xbar_auto_in_d_valid),	// PeripheryBus.scala:50:30
    .auto_out_d_bits_opcode  (_out_xbar_auto_in_d_bits_opcode),	// PeripheryBus.scala:50:30
    .auto_out_d_bits_param   (_out_xbar_auto_in_d_bits_param),	// PeripheryBus.scala:50:30
    .auto_out_d_bits_size    (_out_xbar_auto_in_d_bits_size),	// PeripheryBus.scala:50:30
    .auto_out_d_bits_source  (_out_xbar_auto_in_d_bits_source),	// PeripheryBus.scala:50:30
    .auto_out_d_bits_sink    (_out_xbar_auto_in_d_bits_sink),	// PeripheryBus.scala:50:30
    .auto_out_d_bits_denied  (_out_xbar_auto_in_d_bits_denied),	// PeripheryBus.scala:50:30
    .auto_out_d_bits_data    (_out_xbar_auto_in_d_bits_data),	// PeripheryBus.scala:50:30
    .auto_out_d_bits_corrupt (_out_xbar_auto_in_d_bits_corrupt),	// PeripheryBus.scala:50:30
    .auto_in_a_ready         (_buffer_auto_in_a_ready),
    .auto_in_d_valid         (_buffer_auto_in_d_valid),
    .auto_in_d_bits_opcode   (_buffer_auto_in_d_bits_opcode),
    .auto_in_d_bits_param    (_buffer_auto_in_d_bits_param),
    .auto_in_d_bits_size     (_buffer_auto_in_d_bits_size),
    .auto_in_d_bits_source   (_buffer_auto_in_d_bits_source),
    .auto_in_d_bits_sink     (_buffer_auto_in_d_bits_sink),
    .auto_in_d_bits_denied   (_buffer_auto_in_d_bits_denied),
    .auto_in_d_bits_data     (_buffer_auto_in_d_bits_data),
    .auto_in_d_bits_corrupt  (_buffer_auto_in_d_bits_corrupt),
    .auto_out_a_valid        (_buffer_auto_out_a_valid),
    .auto_out_a_bits_opcode  (_buffer_auto_out_a_bits_opcode),
    .auto_out_a_bits_param   (_buffer_auto_out_a_bits_param),
    .auto_out_a_bits_size    (_buffer_auto_out_a_bits_size),
    .auto_out_a_bits_source  (_buffer_auto_out_a_bits_source),
    .auto_out_a_bits_address (_buffer_auto_out_a_bits_address),
    .auto_out_a_bits_mask    (_buffer_auto_out_a_bits_mask),
    .auto_out_a_bits_data    (_buffer_auto_out_a_bits_data),
    .auto_out_a_bits_corrupt (_buffer_auto_out_a_bits_corrupt),
    .auto_out_d_ready        (_buffer_auto_out_d_ready)
  );
  TLAtomicAutomata_1 atomics (	// AtomicAutomata.scala:283:29
    .clock
      (auto_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_clock),
    .reset
      (auto_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_reset),
    .auto_in_a_valid         (_in_xbar_auto_out_a_valid),	// PeripheryBus.scala:49:29
    .auto_in_a_bits_opcode   (_in_xbar_auto_out_a_bits_opcode),	// PeripheryBus.scala:49:29
    .auto_in_a_bits_param    (_in_xbar_auto_out_a_bits_param),	// PeripheryBus.scala:49:29
    .auto_in_a_bits_size     (_in_xbar_auto_out_a_bits_size),	// PeripheryBus.scala:49:29
    .auto_in_a_bits_source   (_in_xbar_auto_out_a_bits_source),	// PeripheryBus.scala:49:29
    .auto_in_a_bits_address  (_in_xbar_auto_out_a_bits_address),	// PeripheryBus.scala:49:29
    .auto_in_a_bits_mask     (_in_xbar_auto_out_a_bits_mask),	// PeripheryBus.scala:49:29
    .auto_in_a_bits_data     (_in_xbar_auto_out_a_bits_data),	// PeripheryBus.scala:49:29
    .auto_in_a_bits_corrupt  (_in_xbar_auto_out_a_bits_corrupt),	// PeripheryBus.scala:49:29
    .auto_in_d_ready         (_in_xbar_auto_out_d_ready),	// PeripheryBus.scala:49:29
    .auto_out_a_ready        (_buffer_auto_in_a_ready),	// Buffer.scala:68:28
    .auto_out_d_valid        (_buffer_auto_in_d_valid),	// Buffer.scala:68:28
    .auto_out_d_bits_opcode  (_buffer_auto_in_d_bits_opcode),	// Buffer.scala:68:28
    .auto_out_d_bits_param   (_buffer_auto_in_d_bits_param),	// Buffer.scala:68:28
    .auto_out_d_bits_size    (_buffer_auto_in_d_bits_size),	// Buffer.scala:68:28
    .auto_out_d_bits_source  (_buffer_auto_in_d_bits_source),	// Buffer.scala:68:28
    .auto_out_d_bits_sink    (_buffer_auto_in_d_bits_sink),	// Buffer.scala:68:28
    .auto_out_d_bits_denied  (_buffer_auto_in_d_bits_denied),	// Buffer.scala:68:28
    .auto_out_d_bits_data    (_buffer_auto_in_d_bits_data),	// Buffer.scala:68:28
    .auto_out_d_bits_corrupt (_buffer_auto_in_d_bits_corrupt),	// Buffer.scala:68:28
    .auto_in_a_ready         (_atomics_auto_in_a_ready),
    .auto_in_d_valid         (_atomics_auto_in_d_valid),
    .auto_in_d_bits_opcode   (_atomics_auto_in_d_bits_opcode),
    .auto_in_d_bits_denied   (_atomics_auto_in_d_bits_denied),
    .auto_in_d_bits_data     (auto_bus_xing_in_d_bits_data),
    .auto_in_d_bits_corrupt  (_atomics_auto_in_d_bits_corrupt),
    .auto_out_a_valid        (_atomics_auto_out_a_valid),
    .auto_out_a_bits_opcode  (_atomics_auto_out_a_bits_opcode),
    .auto_out_a_bits_param   (_atomics_auto_out_a_bits_param),
    .auto_out_a_bits_size    (_atomics_auto_out_a_bits_size),
    .auto_out_a_bits_source  (_atomics_auto_out_a_bits_source),
    .auto_out_a_bits_address (_atomics_auto_out_a_bits_address),
    .auto_out_a_bits_mask    (_atomics_auto_out_a_bits_mask),
    .auto_out_a_bits_data    (_atomics_auto_out_a_bits_data),
    .auto_out_a_bits_corrupt (_atomics_auto_out_a_bits_corrupt),
    .auto_out_d_ready        (_atomics_auto_out_d_ready)
  );
  ErrorDeviceWrapper wrapped_error_device (	// LazyModule.scala:432:27
    .clock
      (auto_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_clock),
    .reset
      (auto_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_reset),
    .auto_buffer_in_a_valid        (_out_xbar_auto_out_0_a_valid),	// PeripheryBus.scala:50:30
    .auto_buffer_in_a_bits_opcode  (_buffer_auto_out_a_bits_opcode),	// Buffer.scala:68:28
    .auto_buffer_in_a_bits_param   (_buffer_auto_out_a_bits_param),	// Buffer.scala:68:28
    .auto_buffer_in_a_bits_size    (_buffer_auto_out_a_bits_size),	// Buffer.scala:68:28
    .auto_buffer_in_a_bits_source  (_buffer_auto_out_a_bits_source),	// Buffer.scala:68:28
    .auto_buffer_in_a_bits_address (_out_xbar_auto_out_0_a_bits_address),	// PeripheryBus.scala:50:30
    .auto_buffer_in_a_bits_mask    (_buffer_auto_out_a_bits_mask),	// Buffer.scala:68:28
    .auto_buffer_in_a_bits_data    (_buffer_auto_out_a_bits_data),	// Buffer.scala:68:28
    .auto_buffer_in_a_bits_corrupt (_buffer_auto_out_a_bits_corrupt),	// Buffer.scala:68:28
    .auto_buffer_in_d_ready        (_out_xbar_auto_out_0_d_ready),	// PeripheryBus.scala:50:30
    .auto_buffer_in_a_ready        (_wrapped_error_device_auto_buffer_in_a_ready),
    .auto_buffer_in_d_valid        (_wrapped_error_device_auto_buffer_in_d_valid),
    .auto_buffer_in_d_bits_opcode  (_wrapped_error_device_auto_buffer_in_d_bits_opcode),
    .auto_buffer_in_d_bits_param   (_wrapped_error_device_auto_buffer_in_d_bits_param),
    .auto_buffer_in_d_bits_size    (_wrapped_error_device_auto_buffer_in_d_bits_size),
    .auto_buffer_in_d_bits_source  (_wrapped_error_device_auto_buffer_in_d_bits_source),
    .auto_buffer_in_d_bits_sink    (_wrapped_error_device_auto_buffer_in_d_bits_sink),
    .auto_buffer_in_d_bits_denied  (_wrapped_error_device_auto_buffer_in_d_bits_denied),
    .auto_buffer_in_d_bits_data    (_wrapped_error_device_auto_buffer_in_d_bits_data),
    .auto_buffer_in_d_bits_corrupt (_wrapped_error_device_auto_buffer_in_d_bits_corrupt)
  );
  TLInterconnectCoupler_13 coupler_to_l2_ctrl (	// LazyModule.scala:432:27
    .clock
      (auto_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_clock),
    .reset
      (auto_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_reset),
    .auto_buffer_out_a_ready        (auto_coupler_to_l2_ctrl_buffer_out_a_ready),
    .auto_buffer_out_d_valid        (auto_coupler_to_l2_ctrl_buffer_out_d_valid),
    .auto_buffer_out_d_bits_opcode  (auto_coupler_to_l2_ctrl_buffer_out_d_bits_opcode),
    .auto_buffer_out_d_bits_size    (auto_coupler_to_l2_ctrl_buffer_out_d_bits_size),
    .auto_buffer_out_d_bits_source  (auto_coupler_to_l2_ctrl_buffer_out_d_bits_source),
    .auto_buffer_out_d_bits_data    (auto_coupler_to_l2_ctrl_buffer_out_d_bits_data),
    .auto_tl_in_a_valid             (_out_xbar_auto_out_1_a_valid),	// PeripheryBus.scala:50:30
    .auto_tl_in_a_bits_opcode       (_buffer_auto_out_a_bits_opcode),	// Buffer.scala:68:28
    .auto_tl_in_a_bits_param        (_buffer_auto_out_a_bits_param),	// Buffer.scala:68:28
    .auto_tl_in_a_bits_size         (_out_xbar_auto_out_1_a_bits_size),	// PeripheryBus.scala:50:30
    .auto_tl_in_a_bits_source       (_buffer_auto_out_a_bits_source),	// Buffer.scala:68:28
    .auto_tl_in_a_bits_address      (_out_xbar_auto_out_1_a_bits_address),	// PeripheryBus.scala:50:30
    .auto_tl_in_a_bits_mask         (_buffer_auto_out_a_bits_mask),	// Buffer.scala:68:28
    .auto_tl_in_a_bits_data         (_buffer_auto_out_a_bits_data),	// Buffer.scala:68:28
    .auto_tl_in_a_bits_corrupt      (_buffer_auto_out_a_bits_corrupt),	// Buffer.scala:68:28
    .auto_tl_in_d_ready             (_out_xbar_auto_out_1_d_ready),	// PeripheryBus.scala:50:30
    .auto_buffer_out_a_valid        (auto_coupler_to_l2_ctrl_buffer_out_a_valid),
    .auto_buffer_out_a_bits_opcode  (auto_coupler_to_l2_ctrl_buffer_out_a_bits_opcode),
    .auto_buffer_out_a_bits_param   (auto_coupler_to_l2_ctrl_buffer_out_a_bits_param),
    .auto_buffer_out_a_bits_size    (auto_coupler_to_l2_ctrl_buffer_out_a_bits_size),
    .auto_buffer_out_a_bits_source  (auto_coupler_to_l2_ctrl_buffer_out_a_bits_source),
    .auto_buffer_out_a_bits_address (auto_coupler_to_l2_ctrl_buffer_out_a_bits_address),
    .auto_buffer_out_a_bits_mask    (auto_coupler_to_l2_ctrl_buffer_out_a_bits_mask),
    .auto_buffer_out_a_bits_data    (auto_coupler_to_l2_ctrl_buffer_out_a_bits_data),
    .auto_buffer_out_a_bits_corrupt (auto_coupler_to_l2_ctrl_buffer_out_a_bits_corrupt),
    .auto_buffer_out_d_ready        (auto_coupler_to_l2_ctrl_buffer_out_d_ready),
    .auto_tl_in_a_ready             (_coupler_to_l2_ctrl_auto_tl_in_a_ready),
    .auto_tl_in_d_valid             (_coupler_to_l2_ctrl_auto_tl_in_d_valid),
    .auto_tl_in_d_bits_opcode       (_coupler_to_l2_ctrl_auto_tl_in_d_bits_opcode),
    .auto_tl_in_d_bits_param        (_coupler_to_l2_ctrl_auto_tl_in_d_bits_param),
    .auto_tl_in_d_bits_size         (_coupler_to_l2_ctrl_auto_tl_in_d_bits_size),
    .auto_tl_in_d_bits_source       (_coupler_to_l2_ctrl_auto_tl_in_d_bits_source),
    .auto_tl_in_d_bits_sink         (_coupler_to_l2_ctrl_auto_tl_in_d_bits_sink),
    .auto_tl_in_d_bits_denied       (_coupler_to_l2_ctrl_auto_tl_in_d_bits_denied),
    .auto_tl_in_d_bits_data         (_coupler_to_l2_ctrl_auto_tl_in_d_bits_data),
    .auto_tl_in_d_bits_corrupt      (_coupler_to_l2_ctrl_auto_tl_in_d_bits_corrupt)
  );
  TLInterconnectCoupler_15 coupler_to_plic (	// LazyModule.scala:432:27
    .clock
      (auto_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_clock),
    .reset
      (auto_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_reset),
    .auto_fragmenter_out_a_ready        (auto_coupler_to_plic_fragmenter_out_a_ready),
    .auto_fragmenter_out_d_valid        (auto_coupler_to_plic_fragmenter_out_d_valid),
    .auto_fragmenter_out_d_bits_opcode
      (auto_coupler_to_plic_fragmenter_out_d_bits_opcode),
    .auto_fragmenter_out_d_bits_size    (auto_coupler_to_plic_fragmenter_out_d_bits_size),
    .auto_fragmenter_out_d_bits_source
      (auto_coupler_to_plic_fragmenter_out_d_bits_source),
    .auto_tl_in_a_valid                 (_out_xbar_auto_out_3_a_valid),	// PeripheryBus.scala:50:30
    .auto_tl_in_a_bits_opcode           (_buffer_auto_out_a_bits_opcode),	// Buffer.scala:68:28
    .auto_tl_in_a_bits_param            (_buffer_auto_out_a_bits_param),	// Buffer.scala:68:28
    .auto_tl_in_a_bits_size             (_out_xbar_auto_out_3_a_bits_size),	// PeripheryBus.scala:50:30
    .auto_tl_in_a_bits_source           (_buffer_auto_out_a_bits_source),	// Buffer.scala:68:28
    .auto_tl_in_a_bits_address          (_out_xbar_auto_out_3_a_bits_address),	// PeripheryBus.scala:50:30
    .auto_tl_in_a_bits_mask             (_buffer_auto_out_a_bits_mask),	// Buffer.scala:68:28
    .auto_tl_in_a_bits_corrupt          (_buffer_auto_out_a_bits_corrupt),	// Buffer.scala:68:28
    .auto_tl_in_d_ready                 (_out_xbar_auto_out_3_d_ready),	// PeripheryBus.scala:50:30
    .auto_fragmenter_out_a_valid        (auto_coupler_to_plic_fragmenter_out_a_valid),
    .auto_fragmenter_out_a_bits_opcode
      (auto_coupler_to_plic_fragmenter_out_a_bits_opcode),
    .auto_fragmenter_out_a_bits_param
      (auto_coupler_to_plic_fragmenter_out_a_bits_param),
    .auto_fragmenter_out_a_bits_size    (auto_coupler_to_plic_fragmenter_out_a_bits_size),
    .auto_fragmenter_out_a_bits_source
      (auto_coupler_to_plic_fragmenter_out_a_bits_source),
    .auto_fragmenter_out_a_bits_address
      (auto_coupler_to_plic_fragmenter_out_a_bits_address),
    .auto_fragmenter_out_a_bits_mask    (auto_coupler_to_plic_fragmenter_out_a_bits_mask),
    .auto_fragmenter_out_a_bits_corrupt
      (auto_coupler_to_plic_fragmenter_out_a_bits_corrupt),
    .auto_fragmenter_out_d_ready        (auto_coupler_to_plic_fragmenter_out_d_ready),
    .auto_tl_in_a_ready                 (_coupler_to_plic_auto_tl_in_a_ready),
    .auto_tl_in_d_valid                 (_coupler_to_plic_auto_tl_in_d_valid),
    .auto_tl_in_d_bits_size             (_coupler_to_plic_auto_tl_in_d_bits_size),
    .auto_tl_in_d_bits_source           (_coupler_to_plic_auto_tl_in_d_bits_source)
  );
  TLInterconnectCoupler_16 coupler_to_clint (	// LazyModule.scala:432:27
    .clock
      (auto_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_clock),
    .reset
      (auto_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_reset),
    .auto_fragmenter_out_a_ready        (auto_coupler_to_clint_fragmenter_out_a_ready),
    .auto_fragmenter_out_d_valid        (auto_coupler_to_clint_fragmenter_out_d_valid),
    .auto_fragmenter_out_d_bits_opcode
      (auto_coupler_to_clint_fragmenter_out_d_bits_opcode),
    .auto_fragmenter_out_d_bits_size
      (auto_coupler_to_clint_fragmenter_out_d_bits_size),
    .auto_fragmenter_out_d_bits_source
      (auto_coupler_to_clint_fragmenter_out_d_bits_source),
    .auto_tl_in_a_valid                 (_out_xbar_auto_out_4_a_valid),	// PeripheryBus.scala:50:30
    .auto_tl_in_a_bits_opcode           (_buffer_auto_out_a_bits_opcode),	// Buffer.scala:68:28
    .auto_tl_in_a_bits_param            (_buffer_auto_out_a_bits_param),	// Buffer.scala:68:28
    .auto_tl_in_a_bits_size             (_out_xbar_auto_out_4_a_bits_size),	// PeripheryBus.scala:50:30
    .auto_tl_in_a_bits_source           (_buffer_auto_out_a_bits_source),	// Buffer.scala:68:28
    .auto_tl_in_a_bits_address          (_out_xbar_auto_out_4_a_bits_address),	// PeripheryBus.scala:50:30
    .auto_tl_in_a_bits_mask             (_buffer_auto_out_a_bits_mask),	// Buffer.scala:68:28
    .auto_tl_in_a_bits_corrupt          (_buffer_auto_out_a_bits_corrupt),	// Buffer.scala:68:28
    .auto_tl_in_d_ready                 (_out_xbar_auto_out_4_d_ready),	// PeripheryBus.scala:50:30
    .auto_fragmenter_out_a_valid        (auto_coupler_to_clint_fragmenter_out_a_valid),
    .auto_fragmenter_out_a_bits_opcode
      (auto_coupler_to_clint_fragmenter_out_a_bits_opcode),
    .auto_fragmenter_out_a_bits_param
      (auto_coupler_to_clint_fragmenter_out_a_bits_param),
    .auto_fragmenter_out_a_bits_size
      (auto_coupler_to_clint_fragmenter_out_a_bits_size),
    .auto_fragmenter_out_a_bits_source
      (auto_coupler_to_clint_fragmenter_out_a_bits_source),
    .auto_fragmenter_out_a_bits_address
      (auto_coupler_to_clint_fragmenter_out_a_bits_address),
    .auto_fragmenter_out_a_bits_mask
      (auto_coupler_to_clint_fragmenter_out_a_bits_mask),
    .auto_fragmenter_out_a_bits_corrupt
      (auto_coupler_to_clint_fragmenter_out_a_bits_corrupt),
    .auto_fragmenter_out_d_ready        (auto_coupler_to_clint_fragmenter_out_d_ready),
    .auto_tl_in_a_ready                 (_coupler_to_clint_auto_tl_in_a_ready),
    .auto_tl_in_d_valid                 (_coupler_to_clint_auto_tl_in_d_valid),
    .auto_tl_in_d_bits_size             (_coupler_to_clint_auto_tl_in_d_bits_size),
    .auto_tl_in_d_bits_source           (_coupler_to_clint_auto_tl_in_d_bits_source)
  );
  TLInterconnectCoupler_17 coupler_to_debug (	// LazyModule.scala:432:27
    .clock
      (auto_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_clock),
    .reset
      (auto_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_reset),
    .auto_fragmenter_out_a_ready        (auto_coupler_to_debug_fragmenter_out_a_ready),
    .auto_fragmenter_out_d_valid        (auto_coupler_to_debug_fragmenter_out_d_valid),
    .auto_fragmenter_out_d_bits_opcode
      (auto_coupler_to_debug_fragmenter_out_d_bits_opcode),
    .auto_fragmenter_out_d_bits_size
      (auto_coupler_to_debug_fragmenter_out_d_bits_size),
    .auto_fragmenter_out_d_bits_source
      (auto_coupler_to_debug_fragmenter_out_d_bits_source),
    .auto_tl_in_a_valid                 (_out_xbar_auto_out_5_a_valid),	// PeripheryBus.scala:50:30
    .auto_tl_in_a_bits_opcode           (_buffer_auto_out_a_bits_opcode),	// Buffer.scala:68:28
    .auto_tl_in_a_bits_param            (_buffer_auto_out_a_bits_param),	// Buffer.scala:68:28
    .auto_tl_in_a_bits_size             (_out_xbar_auto_out_5_a_bits_size),	// PeripheryBus.scala:50:30
    .auto_tl_in_a_bits_source           (_buffer_auto_out_a_bits_source),	// Buffer.scala:68:28
    .auto_tl_in_a_bits_address          (_out_xbar_auto_out_5_a_bits_address),	// PeripheryBus.scala:50:30
    .auto_tl_in_a_bits_mask             (_buffer_auto_out_a_bits_mask),	// Buffer.scala:68:28
    .auto_tl_in_a_bits_corrupt          (_buffer_auto_out_a_bits_corrupt),	// Buffer.scala:68:28
    .auto_tl_in_d_ready                 (_out_xbar_auto_out_5_d_ready),	// PeripheryBus.scala:50:30
    .auto_fragmenter_out_a_valid        (auto_coupler_to_debug_fragmenter_out_a_valid),
    .auto_fragmenter_out_a_bits_opcode
      (auto_coupler_to_debug_fragmenter_out_a_bits_opcode),
    .auto_fragmenter_out_a_bits_param
      (auto_coupler_to_debug_fragmenter_out_a_bits_param),
    .auto_fragmenter_out_a_bits_size
      (auto_coupler_to_debug_fragmenter_out_a_bits_size),
    .auto_fragmenter_out_a_bits_source
      (auto_coupler_to_debug_fragmenter_out_a_bits_source),
    .auto_fragmenter_out_a_bits_address
      (auto_coupler_to_debug_fragmenter_out_a_bits_address),
    .auto_fragmenter_out_a_bits_mask
      (auto_coupler_to_debug_fragmenter_out_a_bits_mask),
    .auto_fragmenter_out_a_bits_corrupt
      (auto_coupler_to_debug_fragmenter_out_a_bits_corrupt),
    .auto_fragmenter_out_d_ready        (auto_coupler_to_debug_fragmenter_out_d_ready),
    .auto_tl_in_a_ready                 (_coupler_to_debug_auto_tl_in_a_ready),
    .auto_tl_in_d_valid                 (_coupler_to_debug_auto_tl_in_d_valid),
    .auto_tl_in_d_bits_size             (_coupler_to_debug_auto_tl_in_d_bits_size),
    .auto_tl_in_d_bits_source           (_coupler_to_debug_auto_tl_in_d_bits_source)
  );
  TLInterconnectCoupler_24 coupler_to_bootrom (	// LazyModule.scala:432:27
    .clock
      (auto_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_clock),
    .reset
      (auto_subsystem_cbus_clock_groups_in_member_subsystem_cbus_0_reset),
    .auto_fragmenter_out_a_ready        (auto_coupler_to_bootrom_fragmenter_out_a_ready),
    .auto_fragmenter_out_d_valid        (auto_coupler_to_bootrom_fragmenter_out_d_valid),
    .auto_fragmenter_out_d_bits_size
      (auto_coupler_to_bootrom_fragmenter_out_d_bits_size),
    .auto_fragmenter_out_d_bits_source
      (auto_coupler_to_bootrom_fragmenter_out_d_bits_source),
    .auto_tl_in_a_valid                 (_out_xbar_auto_out_6_a_valid),	// PeripheryBus.scala:50:30
    .auto_tl_in_a_bits_opcode           (_buffer_auto_out_a_bits_opcode),	// Buffer.scala:68:28
    .auto_tl_in_a_bits_param            (_buffer_auto_out_a_bits_param),	// Buffer.scala:68:28
    .auto_tl_in_a_bits_size             (_out_xbar_auto_out_6_a_bits_size),	// PeripheryBus.scala:50:30
    .auto_tl_in_a_bits_source           (_buffer_auto_out_a_bits_source),	// Buffer.scala:68:28
    .auto_tl_in_a_bits_address          (_out_xbar_auto_out_6_a_bits_address),	// PeripheryBus.scala:50:30
    .auto_tl_in_a_bits_mask             (_buffer_auto_out_a_bits_mask),	// Buffer.scala:68:28
    .auto_tl_in_a_bits_corrupt          (_buffer_auto_out_a_bits_corrupt),	// Buffer.scala:68:28
    .auto_tl_in_d_ready                 (_out_xbar_auto_out_6_d_ready),	// PeripheryBus.scala:50:30
    .auto_fragmenter_out_a_valid        (auto_coupler_to_bootrom_fragmenter_out_a_valid),
    .auto_fragmenter_out_a_bits_opcode
      (auto_coupler_to_bootrom_fragmenter_out_a_bits_opcode),
    .auto_fragmenter_out_a_bits_param
      (auto_coupler_to_bootrom_fragmenter_out_a_bits_param),
    .auto_fragmenter_out_a_bits_size
      (auto_coupler_to_bootrom_fragmenter_out_a_bits_size),
    .auto_fragmenter_out_a_bits_source
      (auto_coupler_to_bootrom_fragmenter_out_a_bits_source),
    .auto_fragmenter_out_a_bits_address
      (auto_coupler_to_bootrom_fragmenter_out_a_bits_address),
    .auto_fragmenter_out_a_bits_mask
      (auto_coupler_to_bootrom_fragmenter_out_a_bits_mask),
    .auto_fragmenter_out_a_bits_corrupt
      (auto_coupler_to_bootrom_fragmenter_out_a_bits_corrupt),
    .auto_tl_in_a_ready                 (_coupler_to_bootrom_auto_tl_in_a_ready),
    .auto_tl_in_d_bits_size             (_coupler_to_bootrom_auto_tl_in_d_bits_size),
    .auto_tl_in_d_bits_source           (_coupler_to_bootrom_auto_tl_in_d_bits_source)
  );
  assign auto_coupler_to_bootrom_fragmenter_out_d_ready = _out_xbar_auto_out_6_d_ready;	// PeripheryBus.scala:50:30
  assign auto_coupler_to_debug_fragmenter_out_a_bits_data = _buffer_auto_out_a_bits_data;	// Buffer.scala:68:28
  assign auto_coupler_to_clint_fragmenter_out_a_bits_data = _buffer_auto_out_a_bits_data;	// Buffer.scala:68:28
  assign auto_coupler_to_plic_fragmenter_out_a_bits_data = _buffer_auto_out_a_bits_data;	// Buffer.scala:68:28
  assign auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_opcode =
    _buffer_auto_out_a_bits_opcode;	// Buffer.scala:68:28
  assign auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_param =
    _buffer_auto_out_a_bits_param;	// Buffer.scala:68:28
  assign auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_source =
    _buffer_auto_out_a_bits_source;	// Buffer.scala:68:28
  assign auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_address =
    _buffer_auto_out_a_bits_address;	// Buffer.scala:68:28
  assign auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_mask =
    _buffer_auto_out_a_bits_mask;	// Buffer.scala:68:28
  assign auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_data =
    _buffer_auto_out_a_bits_data;	// Buffer.scala:68:28
  assign auto_coupler_to_bus_named_subsystem_pbus_bus_xing_out_a_bits_corrupt =
    _buffer_auto_out_a_bits_corrupt;	// Buffer.scala:68:28
  assign auto_bus_xing_in_d_bits_opcode = _atomics_auto_in_d_bits_opcode;	// AtomicAutomata.scala:283:29
  assign auto_bus_xing_in_d_bits_param = _buffer_auto_in_d_bits_param;	// Buffer.scala:68:28
  assign auto_bus_xing_in_d_bits_size = _buffer_auto_in_d_bits_size;	// Buffer.scala:68:28
  assign auto_bus_xing_in_d_bits_sink = _buffer_auto_in_d_bits_sink;	// Buffer.scala:68:28
  assign auto_bus_xing_in_d_bits_denied = _atomics_auto_in_d_bits_denied;	// AtomicAutomata.scala:283:29
  assign auto_bus_xing_in_d_bits_corrupt = _atomics_auto_in_d_bits_corrupt;	// AtomicAutomata.scala:283:29
endmodule

