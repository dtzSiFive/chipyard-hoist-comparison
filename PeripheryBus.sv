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

module PeripheryBus(
  input         auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_ready,
                auto_coupler_to_slave_named_tileresetctrl_buffer_out_d_valid,
  input  [2:0]  auto_coupler_to_slave_named_tileresetctrl_buffer_out_d_bits_opcode,
  input  [1:0]  auto_coupler_to_slave_named_tileresetctrl_buffer_out_d_bits_size,
  input  [11:0] auto_coupler_to_slave_named_tileresetctrl_buffer_out_d_bits_source,
  input  [63:0] auto_coupler_to_slave_named_tileresetctrl_buffer_out_d_bits_data,
  input         auto_coupler_to_device_named_uart_0_control_xing_out_a_ready,
                auto_coupler_to_device_named_uart_0_control_xing_out_d_valid,
  input  [2:0]  auto_coupler_to_device_named_uart_0_control_xing_out_d_bits_opcode,
  input  [1:0]  auto_coupler_to_device_named_uart_0_control_xing_out_d_bits_size,
  input  [11:0] auto_coupler_to_device_named_uart_0_control_xing_out_d_bits_source,
  input  [63:0] auto_coupler_to_device_named_uart_0_control_xing_out_d_bits_data,
  input         auto_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_clock,
                auto_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_reset,
                auto_bus_xing_in_a_valid,
  input  [2:0]  auto_bus_xing_in_a_bits_opcode,
                auto_bus_xing_in_a_bits_param,
                auto_bus_xing_in_a_bits_size,
  input  [7:0]  auto_bus_xing_in_a_bits_source,
  input  [30:0] auto_bus_xing_in_a_bits_address,
  input  [7:0]  auto_bus_xing_in_a_bits_mask,
  input  [63:0] auto_bus_xing_in_a_bits_data,
  input         auto_bus_xing_in_a_bits_corrupt,
                auto_bus_xing_in_d_ready,
  output        auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_valid,
  output [2:0]  auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_opcode,
                auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_param,
  output [1:0]  auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_size,
  output [11:0] auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_source,
  output [20:0] auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_address,
  output [7:0]  auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_mask,
  output [63:0] auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_data,
  output        auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_corrupt,
                auto_coupler_to_slave_named_tileresetctrl_buffer_out_d_ready,
                auto_coupler_to_device_named_uart_0_control_xing_out_a_valid,
  output [2:0]  auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_opcode,
                auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_param,
  output [1:0]  auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_size,
  output [11:0] auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_source,
  output [30:0] auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_address,
  output [7:0]  auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_mask,
  output [63:0] auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_data,
  output        auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_corrupt,
                auto_coupler_to_device_named_uart_0_control_xing_out_d_ready,
                auto_bus_xing_in_a_ready,
                auto_bus_xing_in_d_valid,
  output [2:0]  auto_bus_xing_in_d_bits_opcode,
  output [1:0]  auto_bus_xing_in_d_bits_param,
  output [2:0]  auto_bus_xing_in_d_bits_size,
  output [7:0]  auto_bus_xing_in_d_bits_source,
  output        auto_bus_xing_in_d_bits_sink,
                auto_bus_xing_in_d_bits_denied,
  output [63:0] auto_bus_xing_in_d_bits_data,
  output        auto_bus_xing_in_d_bits_corrupt
);

  wire        out_woready_7;	// RegisterRouter.scala:79:24
  wire        _coupler_to_slave_named_tileresetctrl_auto_buffer_in_a_ready;	// LazyModule.scala:432:27
  wire        _coupler_to_slave_named_tileresetctrl_auto_buffer_in_d_valid;	// LazyModule.scala:432:27
  wire [2:0]  _coupler_to_slave_named_tileresetctrl_auto_buffer_in_d_bits_opcode;	// LazyModule.scala:432:27
  wire [1:0]  _coupler_to_slave_named_tileresetctrl_auto_buffer_in_d_bits_param;	// LazyModule.scala:432:27
  wire [2:0]  _coupler_to_slave_named_tileresetctrl_auto_buffer_in_d_bits_size;	// LazyModule.scala:432:27
  wire [7:0]  _coupler_to_slave_named_tileresetctrl_auto_buffer_in_d_bits_source;	// LazyModule.scala:432:27
  wire        _coupler_to_slave_named_tileresetctrl_auto_buffer_in_d_bits_sink;	// LazyModule.scala:432:27
  wire        _coupler_to_slave_named_tileresetctrl_auto_buffer_in_d_bits_denied;	// LazyModule.scala:432:27
  wire [63:0] _coupler_to_slave_named_tileresetctrl_auto_buffer_in_d_bits_data;	// LazyModule.scala:432:27
  wire        _coupler_to_slave_named_tileresetctrl_auto_buffer_in_d_bits_corrupt;	// LazyModule.scala:432:27
  wire        _coupler_to_device_named_uart_0_auto_tl_in_a_ready;	// LazyModule.scala:432:27
  wire        _coupler_to_device_named_uart_0_auto_tl_in_d_valid;	// LazyModule.scala:432:27
  wire [2:0]  _coupler_to_device_named_uart_0_auto_tl_in_d_bits_size;	// LazyModule.scala:432:27
  wire [7:0]  _coupler_to_device_named_uart_0_auto_tl_in_d_bits_source;	// LazyModule.scala:432:27
  wire        _coupler_to_slave_named_bootaddressreg_auto_buffer_in_a_ready;	// LazyModule.scala:432:27
  wire        _coupler_to_slave_named_bootaddressreg_auto_buffer_in_d_valid;	// LazyModule.scala:432:27
  wire [2:0]  _coupler_to_slave_named_bootaddressreg_auto_buffer_in_d_bits_size;	// LazyModule.scala:432:27
  wire [7:0]  _coupler_to_slave_named_bootaddressreg_auto_buffer_in_d_bits_source;	// LazyModule.scala:432:27
  wire        _coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_valid;	// LazyModule.scala:432:27
  wire [2:0]  _coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_bits_opcode;	// LazyModule.scala:432:27
  wire [2:0]  _coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_bits_param;	// LazyModule.scala:432:27
  wire [1:0]  _coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_bits_size;	// LazyModule.scala:432:27
  wire [11:0] _coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_bits_source;	// LazyModule.scala:432:27
  wire [14:0] _coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_bits_address;	// LazyModule.scala:432:27
  wire [7:0]  _coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_bits_mask;	// LazyModule.scala:432:27
  wire        _coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_bits_corrupt;	// LazyModule.scala:432:27
  wire        _coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_d_ready;	// LazyModule.scala:432:27
  wire        _buffer_1_auto_out_a_valid;	// Buffer.scala:68:28
  wire [2:0]  _buffer_1_auto_out_a_bits_opcode;	// Buffer.scala:68:28
  wire [2:0]  _buffer_1_auto_out_a_bits_param;	// Buffer.scala:68:28
  wire [2:0]  _buffer_1_auto_out_a_bits_size;	// Buffer.scala:68:28
  wire [7:0]  _buffer_1_auto_out_a_bits_source;	// Buffer.scala:68:28
  wire [30:0] _buffer_1_auto_out_a_bits_address;	// Buffer.scala:68:28
  wire [7:0]  _buffer_1_auto_out_a_bits_mask;	// Buffer.scala:68:28
  wire [63:0] _buffer_1_auto_out_a_bits_data;	// Buffer.scala:68:28
  wire        _buffer_1_auto_out_a_bits_corrupt;	// Buffer.scala:68:28
  wire        _buffer_1_auto_out_d_ready;	// Buffer.scala:68:28
  wire        _atomics_auto_in_a_ready;	// AtomicAutomata.scala:283:29
  wire        _atomics_auto_in_d_valid;	// AtomicAutomata.scala:283:29
  wire [2:0]  _atomics_auto_in_d_bits_opcode;	// AtomicAutomata.scala:283:29
  wire        _atomics_auto_in_d_bits_denied;	// AtomicAutomata.scala:283:29
  wire [63:0] _atomics_auto_in_d_bits_data;	// AtomicAutomata.scala:283:29
  wire        _atomics_auto_in_d_bits_corrupt;	// AtomicAutomata.scala:283:29
  wire        _atomics_auto_out_a_valid;	// AtomicAutomata.scala:283:29
  wire [2:0]  _atomics_auto_out_a_bits_opcode;	// AtomicAutomata.scala:283:29
  wire [2:0]  _atomics_auto_out_a_bits_param;	// AtomicAutomata.scala:283:29
  wire [2:0]  _atomics_auto_out_a_bits_size;	// AtomicAutomata.scala:283:29
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
  wire [2:0]  _buffer_auto_in_d_bits_size;	// Buffer.scala:68:28
  wire [7:0]  _buffer_auto_in_d_bits_source;	// Buffer.scala:68:28
  wire        _buffer_auto_in_d_bits_sink;	// Buffer.scala:68:28
  wire        _buffer_auto_in_d_bits_denied;	// Buffer.scala:68:28
  wire [63:0] _buffer_auto_in_d_bits_data;	// Buffer.scala:68:28
  wire        _buffer_auto_in_d_bits_corrupt;	// Buffer.scala:68:28
  wire        _buffer_auto_out_a_valid;	// Buffer.scala:68:28
  wire [2:0]  _buffer_auto_out_a_bits_opcode;	// Buffer.scala:68:28
  wire [2:0]  _buffer_auto_out_a_bits_param;	// Buffer.scala:68:28
  wire [2:0]  _buffer_auto_out_a_bits_size;	// Buffer.scala:68:28
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
  wire [2:0]  _out_xbar_auto_in_d_bits_size;	// PeripheryBus.scala:50:30
  wire [7:0]  _out_xbar_auto_in_d_bits_source;	// PeripheryBus.scala:50:30
  wire        _out_xbar_auto_in_d_bits_sink;	// PeripheryBus.scala:50:30
  wire        _out_xbar_auto_in_d_bits_denied;	// PeripheryBus.scala:50:30
  wire [63:0] _out_xbar_auto_in_d_bits_data;	// PeripheryBus.scala:50:30
  wire        _out_xbar_auto_in_d_bits_corrupt;	// PeripheryBus.scala:50:30
  wire        _out_xbar_auto_out_2_a_valid;	// PeripheryBus.scala:50:30
  wire [20:0] _out_xbar_auto_out_2_a_bits_address;	// PeripheryBus.scala:50:30
  wire        _out_xbar_auto_out_2_d_ready;	// PeripheryBus.scala:50:30
  wire        _out_xbar_auto_out_1_a_valid;	// PeripheryBus.scala:50:30
  wire        _out_xbar_auto_out_1_d_ready;	// PeripheryBus.scala:50:30
  wire        _out_xbar_auto_out_0_a_valid;	// PeripheryBus.scala:50:30
  wire [14:0] _out_xbar_auto_out_0_a_bits_address;	// PeripheryBus.scala:50:30
  wire        _out_xbar_auto_out_0_d_ready;	// PeripheryBus.scala:50:30
  reg  [63:0] pad;	// BootAddrReg.scala:34:32
  wire        out_front_bits_read =
    _coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_bits_opcode == 3'h4;	// LazyModule.scala:432:27, RegisterRouter.scala:68:36
  wire        _out_out_bits_data_T_1 =
    _coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_bits_address[11:3] == 9'h0;	// Edges.scala:191:34, LazyModule.scala:432:27, RegisterRouter.scala:69:19, :79:24
  wire        valids_0 =
    out_woready_7
    & _coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_bits_mask[0];	// Bitwise.scala:26:51, LazyModule.scala:432:27, RegisterRouter.scala:79:24
  wire        valids_1 =
    out_woready_7
    & _coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_bits_mask[1];	// Bitwise.scala:26:51, LazyModule.scala:432:27, RegisterRouter.scala:79:24
  wire        valids_2 =
    out_woready_7
    & _coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_bits_mask[2];	// Bitwise.scala:26:51, LazyModule.scala:432:27, RegisterRouter.scala:79:24
  wire        valids_3 =
    out_woready_7
    & _coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_bits_mask[3];	// Bitwise.scala:26:51, LazyModule.scala:432:27, RegisterRouter.scala:79:24
  wire        valids_4 =
    out_woready_7
    & _coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_bits_mask[4];	// Bitwise.scala:26:51, LazyModule.scala:432:27, RegisterRouter.scala:79:24
  wire        valids_5 =
    out_woready_7
    & _coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_bits_mask[5];	// Bitwise.scala:26:51, LazyModule.scala:432:27, RegisterRouter.scala:79:24
  wire        valids_6 =
    out_woready_7
    & _coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_bits_mask[6];	// Bitwise.scala:26:51, LazyModule.scala:432:27, RegisterRouter.scala:79:24
  wire        valids_7 =
    out_woready_7
    & _coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_bits_mask[7];	// Bitwise.scala:26:51, LazyModule.scala:432:27, RegisterRouter.scala:79:24
  assign out_woready_7 =
    _coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_valid
    & _coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_d_ready
    & ~out_front_bits_read & _out_out_bits_data_T_1;	// LazyModule.scala:432:27, RegisterRouter.scala:68:36, :79:24
  wire [2:0]  bundleIn_0_2_d_bits_opcode = {2'h0, out_front_bits_read};	// RegisterRouter.scala:68:36, :94:19
  always @(posedge auto_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_clock) begin
    if (auto_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_reset)
      pad <= 64'h80000000;	// BootAddrReg.scala:34:32
    else if (valids_0 | valids_1 | valids_2 | valids_3 | valids_4 | valids_5 | valids_6
             | valids_7)	// RegField.scala:154:27, RegisterRouter.scala:79:24
      pad <=
        {valids_7 ? _buffer_auto_out_a_bits_data[63:56] : pad[63:56],
         valids_6 ? _buffer_auto_out_a_bits_data[55:48] : pad[55:48],
         valids_5 ? _buffer_auto_out_a_bits_data[47:40] : pad[47:40],
         valids_4 ? _buffer_auto_out_a_bits_data[39:32] : pad[39:32],
         valids_3 ? _buffer_auto_out_a_bits_data[31:24] : pad[31:24],
         valids_2 ? _buffer_auto_out_a_bits_data[23:16] : pad[23:16],
         valids_1 ? _buffer_auto_out_a_bits_data[15:8] : pad[15:8],
         valids_0 ? _buffer_auto_out_a_bits_data[7:0] : pad[7:0]};	// BootAddrReg.scala:34:32, Buffer.scala:68:28, RegField.scala:151:53, :154:52, :158:{20,33}, RegisterRouter.scala:79:24
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:1];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [1:0] i = 2'h0; i < 2'h2; i += 2'h1) begin
          _RANDOM[i[0]] = `RANDOM;
        end
        pad = {_RANDOM[1'h0], _RANDOM[1'h1]};	// BootAddrReg.scala:34:32
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  TLFIFOFixer_1 fixer (	// PeripheryBus.scala:47:33
    .clock
      (auto_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_clock),
    .reset
      (auto_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_reset),
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
  TLXbar_2 out_xbar (	// PeripheryBus.scala:50:30
    .clock
      (auto_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_clock),
    .reset
      (auto_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_reset),
    .auto_in_a_valid           (_buffer_auto_out_a_valid),	// Buffer.scala:68:28
    .auto_in_a_bits_opcode     (_buffer_auto_out_a_bits_opcode),	// Buffer.scala:68:28
    .auto_in_a_bits_param      (_buffer_auto_out_a_bits_param),	// Buffer.scala:68:28
    .auto_in_a_bits_size       (_buffer_auto_out_a_bits_size),	// Buffer.scala:68:28
    .auto_in_a_bits_source     (_buffer_auto_out_a_bits_source),	// Buffer.scala:68:28
    .auto_in_a_bits_address    (_buffer_auto_out_a_bits_address),	// Buffer.scala:68:28
    .auto_in_a_bits_mask       (_buffer_auto_out_a_bits_mask),	// Buffer.scala:68:28
    .auto_in_a_bits_corrupt    (_buffer_auto_out_a_bits_corrupt),	// Buffer.scala:68:28
    .auto_in_d_ready           (_buffer_auto_out_d_ready),	// Buffer.scala:68:28
    .auto_out_2_a_ready
      (_coupler_to_slave_named_tileresetctrl_auto_buffer_in_a_ready),	// LazyModule.scala:432:27
    .auto_out_2_d_valid
      (_coupler_to_slave_named_tileresetctrl_auto_buffer_in_d_valid),	// LazyModule.scala:432:27
    .auto_out_2_d_bits_opcode
      (_coupler_to_slave_named_tileresetctrl_auto_buffer_in_d_bits_opcode),	// LazyModule.scala:432:27
    .auto_out_2_d_bits_param
      (_coupler_to_slave_named_tileresetctrl_auto_buffer_in_d_bits_param),	// LazyModule.scala:432:27
    .auto_out_2_d_bits_size
      (_coupler_to_slave_named_tileresetctrl_auto_buffer_in_d_bits_size),	// LazyModule.scala:432:27
    .auto_out_2_d_bits_source
      (_coupler_to_slave_named_tileresetctrl_auto_buffer_in_d_bits_source),	// LazyModule.scala:432:27
    .auto_out_2_d_bits_sink
      (_coupler_to_slave_named_tileresetctrl_auto_buffer_in_d_bits_sink),	// LazyModule.scala:432:27
    .auto_out_2_d_bits_denied
      (_coupler_to_slave_named_tileresetctrl_auto_buffer_in_d_bits_denied),	// LazyModule.scala:432:27
    .auto_out_2_d_bits_data
      (_coupler_to_slave_named_tileresetctrl_auto_buffer_in_d_bits_data),	// LazyModule.scala:432:27
    .auto_out_2_d_bits_corrupt
      (_coupler_to_slave_named_tileresetctrl_auto_buffer_in_d_bits_corrupt),	// LazyModule.scala:432:27
    .auto_out_1_a_ready        (_coupler_to_device_named_uart_0_auto_tl_in_a_ready),	// LazyModule.scala:432:27
    .auto_out_1_d_valid        (_coupler_to_device_named_uart_0_auto_tl_in_d_valid),	// LazyModule.scala:432:27
    .auto_out_1_d_bits_opcode
      (auto_coupler_to_device_named_uart_0_control_xing_out_d_bits_opcode),
    .auto_out_1_d_bits_size    (_coupler_to_device_named_uart_0_auto_tl_in_d_bits_size),	// LazyModule.scala:432:27
    .auto_out_1_d_bits_source  (_coupler_to_device_named_uart_0_auto_tl_in_d_bits_source),	// LazyModule.scala:432:27
    .auto_out_1_d_bits_data
      (auto_coupler_to_device_named_uart_0_control_xing_out_d_bits_data),
    .auto_out_0_a_ready
      (_coupler_to_slave_named_bootaddressreg_auto_buffer_in_a_ready),	// LazyModule.scala:432:27
    .auto_out_0_d_valid
      (_coupler_to_slave_named_bootaddressreg_auto_buffer_in_d_valid),	// LazyModule.scala:432:27
    .auto_out_0_d_bits_opcode  (bundleIn_0_2_d_bits_opcode),	// RegisterRouter.scala:94:19
    .auto_out_0_d_bits_size
      (_coupler_to_slave_named_bootaddressreg_auto_buffer_in_d_bits_size),	// LazyModule.scala:432:27
    .auto_out_0_d_bits_source
      (_coupler_to_slave_named_bootaddressreg_auto_buffer_in_d_bits_source),	// LazyModule.scala:432:27
    .auto_out_0_d_bits_data    (_out_out_bits_data_T_1 ? pad : 64'h0),	// BootAddrReg.scala:34:32, RegField.scala:150:19, RegisterRouter.scala:79:24
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
    .auto_out_2_a_valid        (_out_xbar_auto_out_2_a_valid),
    .auto_out_2_a_bits_address (_out_xbar_auto_out_2_a_bits_address),
    .auto_out_2_d_ready        (_out_xbar_auto_out_2_d_ready),
    .auto_out_1_a_valid        (_out_xbar_auto_out_1_a_valid),
    .auto_out_1_d_ready        (_out_xbar_auto_out_1_d_ready),
    .auto_out_0_a_valid        (_out_xbar_auto_out_0_a_valid),
    .auto_out_0_a_bits_address (_out_xbar_auto_out_0_a_bits_address),
    .auto_out_0_d_ready        (_out_xbar_auto_out_0_d_ready)
  );
  TLBuffer buffer (	// Buffer.scala:68:28
    .clock
      (auto_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_clock),
    .reset
      (auto_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_reset),
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
  TLAtomicAutomata atomics (	// AtomicAutomata.scala:283:29
    .clock
      (auto_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_clock),
    .reset
      (auto_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_reset),
    .auto_in_a_valid         (_buffer_1_auto_out_a_valid),	// Buffer.scala:68:28
    .auto_in_a_bits_opcode   (_buffer_1_auto_out_a_bits_opcode),	// Buffer.scala:68:28
    .auto_in_a_bits_param    (_buffer_1_auto_out_a_bits_param),	// Buffer.scala:68:28
    .auto_in_a_bits_size     (_buffer_1_auto_out_a_bits_size),	// Buffer.scala:68:28
    .auto_in_a_bits_source   (_buffer_1_auto_out_a_bits_source),	// Buffer.scala:68:28
    .auto_in_a_bits_address  (_buffer_1_auto_out_a_bits_address),	// Buffer.scala:68:28
    .auto_in_a_bits_mask     (_buffer_1_auto_out_a_bits_mask),	// Buffer.scala:68:28
    .auto_in_a_bits_data     (_buffer_1_auto_out_a_bits_data),	// Buffer.scala:68:28
    .auto_in_a_bits_corrupt  (_buffer_1_auto_out_a_bits_corrupt),	// Buffer.scala:68:28
    .auto_in_d_ready         (_buffer_1_auto_out_d_ready),	// Buffer.scala:68:28
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
    .auto_in_d_bits_data     (_atomics_auto_in_d_bits_data),
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
  TLBuffer_1 buffer_1 (	// Buffer.scala:68:28
    .clock
      (auto_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_clock),
    .reset
      (auto_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_reset),
    .auto_in_a_valid         (auto_bus_xing_in_a_valid),
    .auto_in_a_bits_opcode   (auto_bus_xing_in_a_bits_opcode),
    .auto_in_a_bits_param    (auto_bus_xing_in_a_bits_param),
    .auto_in_a_bits_size     (auto_bus_xing_in_a_bits_size),
    .auto_in_a_bits_source   (auto_bus_xing_in_a_bits_source),
    .auto_in_a_bits_address  (auto_bus_xing_in_a_bits_address),
    .auto_in_a_bits_mask     (auto_bus_xing_in_a_bits_mask),
    .auto_in_a_bits_data     (auto_bus_xing_in_a_bits_data),
    .auto_in_a_bits_corrupt  (auto_bus_xing_in_a_bits_corrupt),
    .auto_in_d_ready         (auto_bus_xing_in_d_ready),
    .auto_out_a_ready        (_atomics_auto_in_a_ready),	// AtomicAutomata.scala:283:29
    .auto_out_d_valid        (_atomics_auto_in_d_valid),	// AtomicAutomata.scala:283:29
    .auto_out_d_bits_opcode  (_atomics_auto_in_d_bits_opcode),	// AtomicAutomata.scala:283:29
    .auto_out_d_bits_param   (_buffer_auto_in_d_bits_param),	// Buffer.scala:68:28
    .auto_out_d_bits_size    (_buffer_auto_in_d_bits_size),	// Buffer.scala:68:28
    .auto_out_d_bits_source  (_buffer_auto_in_d_bits_source),	// Buffer.scala:68:28
    .auto_out_d_bits_sink    (_buffer_auto_in_d_bits_sink),	// Buffer.scala:68:28
    .auto_out_d_bits_denied  (_atomics_auto_in_d_bits_denied),	// AtomicAutomata.scala:283:29
    .auto_out_d_bits_data    (_atomics_auto_in_d_bits_data),	// AtomicAutomata.scala:283:29
    .auto_out_d_bits_corrupt (_atomics_auto_in_d_bits_corrupt),	// AtomicAutomata.scala:283:29
    .auto_in_a_ready         (auto_bus_xing_in_a_ready),
    .auto_in_d_valid         (auto_bus_xing_in_d_valid),
    .auto_in_d_bits_opcode   (auto_bus_xing_in_d_bits_opcode),
    .auto_in_d_bits_param    (auto_bus_xing_in_d_bits_param),
    .auto_in_d_bits_size     (auto_bus_xing_in_d_bits_size),
    .auto_in_d_bits_source   (auto_bus_xing_in_d_bits_source),
    .auto_in_d_bits_sink     (auto_bus_xing_in_d_bits_sink),
    .auto_in_d_bits_denied   (auto_bus_xing_in_d_bits_denied),
    .auto_in_d_bits_data     (auto_bus_xing_in_d_bits_data),
    .auto_in_d_bits_corrupt  (auto_bus_xing_in_d_bits_corrupt),
    .auto_out_a_valid        (_buffer_1_auto_out_a_valid),
    .auto_out_a_bits_opcode  (_buffer_1_auto_out_a_bits_opcode),
    .auto_out_a_bits_param   (_buffer_1_auto_out_a_bits_param),
    .auto_out_a_bits_size    (_buffer_1_auto_out_a_bits_size),
    .auto_out_a_bits_source  (_buffer_1_auto_out_a_bits_source),
    .auto_out_a_bits_address (_buffer_1_auto_out_a_bits_address),
    .auto_out_a_bits_mask    (_buffer_1_auto_out_a_bits_mask),
    .auto_out_a_bits_data    (_buffer_1_auto_out_a_bits_data),
    .auto_out_a_bits_corrupt (_buffer_1_auto_out_a_bits_corrupt),
    .auto_out_d_ready        (_buffer_1_auto_out_d_ready)
  );
  TLInterconnectCoupler_9 coupler_to_slave_named_bootaddressreg (	// LazyModule.scala:432:27
    .clock
      (auto_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_clock),
    .reset
      (auto_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_reset),
    .auto_buffer_in_a_valid             (_out_xbar_auto_out_0_a_valid),	// PeripheryBus.scala:50:30
    .auto_buffer_in_a_bits_opcode       (_buffer_auto_out_a_bits_opcode),	// Buffer.scala:68:28
    .auto_buffer_in_a_bits_param        (_buffer_auto_out_a_bits_param),	// Buffer.scala:68:28
    .auto_buffer_in_a_bits_size         (_buffer_auto_out_a_bits_size),	// Buffer.scala:68:28
    .auto_buffer_in_a_bits_source       (_buffer_auto_out_a_bits_source),	// Buffer.scala:68:28
    .auto_buffer_in_a_bits_address      (_out_xbar_auto_out_0_a_bits_address),	// PeripheryBus.scala:50:30
    .auto_buffer_in_a_bits_mask         (_buffer_auto_out_a_bits_mask),	// Buffer.scala:68:28
    .auto_buffer_in_a_bits_corrupt      (_buffer_auto_out_a_bits_corrupt),	// Buffer.scala:68:28
    .auto_buffer_in_d_ready             (_out_xbar_auto_out_0_d_ready),	// PeripheryBus.scala:50:30
    .auto_fragmenter_out_a_ready
      (_coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_d_ready),	// LazyModule.scala:432:27
    .auto_fragmenter_out_d_valid
      (_coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_valid),	// LazyModule.scala:432:27
    .auto_fragmenter_out_d_bits_opcode  (bundleIn_0_2_d_bits_opcode),	// RegisterRouter.scala:94:19
    .auto_fragmenter_out_d_bits_size
      (_coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_bits_size),	// LazyModule.scala:432:27
    .auto_fragmenter_out_d_bits_source
      (_coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_bits_source),	// LazyModule.scala:432:27
    .auto_buffer_in_a_ready
      (_coupler_to_slave_named_bootaddressreg_auto_buffer_in_a_ready),
    .auto_buffer_in_d_valid
      (_coupler_to_slave_named_bootaddressreg_auto_buffer_in_d_valid),
    .auto_buffer_in_d_bits_size
      (_coupler_to_slave_named_bootaddressreg_auto_buffer_in_d_bits_size),
    .auto_buffer_in_d_bits_source
      (_coupler_to_slave_named_bootaddressreg_auto_buffer_in_d_bits_source),
    .auto_fragmenter_out_a_valid
      (_coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_valid),
    .auto_fragmenter_out_a_bits_opcode
      (_coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_bits_opcode),
    .auto_fragmenter_out_a_bits_param
      (_coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_bits_param),
    .auto_fragmenter_out_a_bits_size
      (_coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_bits_size),
    .auto_fragmenter_out_a_bits_source
      (_coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_bits_source),
    .auto_fragmenter_out_a_bits_address
      (_coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_bits_address),
    .auto_fragmenter_out_a_bits_mask
      (_coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_bits_mask),
    .auto_fragmenter_out_a_bits_corrupt
      (_coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_bits_corrupt),
    .auto_fragmenter_out_d_ready
      (_coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_d_ready)
  );
  TLInterconnectCoupler_10 coupler_to_device_named_uart_0 (	// LazyModule.scala:432:27
    .clock
      (auto_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_clock),
    .reset
      (auto_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_reset),
    .auto_control_xing_out_a_ready
      (auto_coupler_to_device_named_uart_0_control_xing_out_a_ready),
    .auto_control_xing_out_d_valid
      (auto_coupler_to_device_named_uart_0_control_xing_out_d_valid),
    .auto_control_xing_out_d_bits_opcode
      (auto_coupler_to_device_named_uart_0_control_xing_out_d_bits_opcode),
    .auto_control_xing_out_d_bits_size
      (auto_coupler_to_device_named_uart_0_control_xing_out_d_bits_size),
    .auto_control_xing_out_d_bits_source
      (auto_coupler_to_device_named_uart_0_control_xing_out_d_bits_source),
    .auto_tl_in_a_valid                   (_out_xbar_auto_out_1_a_valid),	// PeripheryBus.scala:50:30
    .auto_tl_in_a_bits_opcode             (_buffer_auto_out_a_bits_opcode),	// Buffer.scala:68:28
    .auto_tl_in_a_bits_param              (_buffer_auto_out_a_bits_param),	// Buffer.scala:68:28
    .auto_tl_in_a_bits_size               (_buffer_auto_out_a_bits_size),	// Buffer.scala:68:28
    .auto_tl_in_a_bits_source             (_buffer_auto_out_a_bits_source),	// Buffer.scala:68:28
    .auto_tl_in_a_bits_address            (_buffer_auto_out_a_bits_address),	// Buffer.scala:68:28
    .auto_tl_in_a_bits_mask               (_buffer_auto_out_a_bits_mask),	// Buffer.scala:68:28
    .auto_tl_in_a_bits_corrupt            (_buffer_auto_out_a_bits_corrupt),	// Buffer.scala:68:28
    .auto_tl_in_d_ready                   (_out_xbar_auto_out_1_d_ready),	// PeripheryBus.scala:50:30
    .auto_control_xing_out_a_valid
      (auto_coupler_to_device_named_uart_0_control_xing_out_a_valid),
    .auto_control_xing_out_a_bits_opcode
      (auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_opcode),
    .auto_control_xing_out_a_bits_param
      (auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_param),
    .auto_control_xing_out_a_bits_size
      (auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_size),
    .auto_control_xing_out_a_bits_source
      (auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_source),
    .auto_control_xing_out_a_bits_address
      (auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_address),
    .auto_control_xing_out_a_bits_mask
      (auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_mask),
    .auto_control_xing_out_a_bits_corrupt
      (auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_corrupt),
    .auto_control_xing_out_d_ready
      (auto_coupler_to_device_named_uart_0_control_xing_out_d_ready),
    .auto_tl_in_a_ready
      (_coupler_to_device_named_uart_0_auto_tl_in_a_ready),
    .auto_tl_in_d_valid
      (_coupler_to_device_named_uart_0_auto_tl_in_d_valid),
    .auto_tl_in_d_bits_size
      (_coupler_to_device_named_uart_0_auto_tl_in_d_bits_size),
    .auto_tl_in_d_bits_source
      (_coupler_to_device_named_uart_0_auto_tl_in_d_bits_source)
  );
  TLInterconnectCoupler_11 coupler_to_slave_named_tileresetctrl (	// LazyModule.scala:432:27
    .clock
      (auto_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_clock),
    .reset
      (auto_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_reset),
    .auto_buffer_in_a_valid         (_out_xbar_auto_out_2_a_valid),	// PeripheryBus.scala:50:30
    .auto_buffer_in_a_bits_opcode   (_buffer_auto_out_a_bits_opcode),	// Buffer.scala:68:28
    .auto_buffer_in_a_bits_param    (_buffer_auto_out_a_bits_param),	// Buffer.scala:68:28
    .auto_buffer_in_a_bits_size     (_buffer_auto_out_a_bits_size),	// Buffer.scala:68:28
    .auto_buffer_in_a_bits_source   (_buffer_auto_out_a_bits_source),	// Buffer.scala:68:28
    .auto_buffer_in_a_bits_address  (_out_xbar_auto_out_2_a_bits_address),	// PeripheryBus.scala:50:30
    .auto_buffer_in_a_bits_mask     (_buffer_auto_out_a_bits_mask),	// Buffer.scala:68:28
    .auto_buffer_in_a_bits_data     (_buffer_auto_out_a_bits_data),	// Buffer.scala:68:28
    .auto_buffer_in_a_bits_corrupt  (_buffer_auto_out_a_bits_corrupt),	// Buffer.scala:68:28
    .auto_buffer_in_d_ready         (_out_xbar_auto_out_2_d_ready),	// PeripheryBus.scala:50:30
    .auto_buffer_out_a_ready
      (auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_ready),
    .auto_buffer_out_d_valid
      (auto_coupler_to_slave_named_tileresetctrl_buffer_out_d_valid),
    .auto_buffer_out_d_bits_opcode
      (auto_coupler_to_slave_named_tileresetctrl_buffer_out_d_bits_opcode),
    .auto_buffer_out_d_bits_size
      (auto_coupler_to_slave_named_tileresetctrl_buffer_out_d_bits_size),
    .auto_buffer_out_d_bits_source
      (auto_coupler_to_slave_named_tileresetctrl_buffer_out_d_bits_source),
    .auto_buffer_out_d_bits_data
      (auto_coupler_to_slave_named_tileresetctrl_buffer_out_d_bits_data),
    .auto_buffer_in_a_ready
      (_coupler_to_slave_named_tileresetctrl_auto_buffer_in_a_ready),
    .auto_buffer_in_d_valid
      (_coupler_to_slave_named_tileresetctrl_auto_buffer_in_d_valid),
    .auto_buffer_in_d_bits_opcode
      (_coupler_to_slave_named_tileresetctrl_auto_buffer_in_d_bits_opcode),
    .auto_buffer_in_d_bits_param
      (_coupler_to_slave_named_tileresetctrl_auto_buffer_in_d_bits_param),
    .auto_buffer_in_d_bits_size
      (_coupler_to_slave_named_tileresetctrl_auto_buffer_in_d_bits_size),
    .auto_buffer_in_d_bits_source
      (_coupler_to_slave_named_tileresetctrl_auto_buffer_in_d_bits_source),
    .auto_buffer_in_d_bits_sink
      (_coupler_to_slave_named_tileresetctrl_auto_buffer_in_d_bits_sink),
    .auto_buffer_in_d_bits_denied
      (_coupler_to_slave_named_tileresetctrl_auto_buffer_in_d_bits_denied),
    .auto_buffer_in_d_bits_data
      (_coupler_to_slave_named_tileresetctrl_auto_buffer_in_d_bits_data),
    .auto_buffer_in_d_bits_corrupt
      (_coupler_to_slave_named_tileresetctrl_auto_buffer_in_d_bits_corrupt),
    .auto_buffer_out_a_valid
      (auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_valid),
    .auto_buffer_out_a_bits_opcode
      (auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_opcode),
    .auto_buffer_out_a_bits_param
      (auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_param),
    .auto_buffer_out_a_bits_size
      (auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_size),
    .auto_buffer_out_a_bits_source
      (auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_source),
    .auto_buffer_out_a_bits_address
      (auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_address),
    .auto_buffer_out_a_bits_mask
      (auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_mask),
    .auto_buffer_out_a_bits_data
      (auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_data),
    .auto_buffer_out_a_bits_corrupt
      (auto_coupler_to_slave_named_tileresetctrl_buffer_out_a_bits_corrupt),
    .auto_buffer_out_d_ready
      (auto_coupler_to_slave_named_tileresetctrl_buffer_out_d_ready)
  );
  TLMonitor_23 monitor (	// Nodes.scala:24:25
    .clock
      (auto_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_clock),
    .reset
      (auto_subsystem_pbus_clock_groups_in_member_subsystem_pbus_0_reset),
    .io_in_a_ready
      (_coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_d_ready),	// LazyModule.scala:432:27
    .io_in_a_valid
      (_coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_valid),	// LazyModule.scala:432:27
    .io_in_a_bits_opcode
      (_coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_bits_opcode),	// LazyModule.scala:432:27
    .io_in_a_bits_param
      (_coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_bits_param),	// LazyModule.scala:432:27
    .io_in_a_bits_size
      (_coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_bits_size),	// LazyModule.scala:432:27
    .io_in_a_bits_source
      (_coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_bits_source),	// LazyModule.scala:432:27
    .io_in_a_bits_address
      (_coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_bits_address),	// LazyModule.scala:432:27
    .io_in_a_bits_mask
      (_coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_bits_mask),	// LazyModule.scala:432:27
    .io_in_a_bits_corrupt
      (_coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_bits_corrupt),	// LazyModule.scala:432:27
    .io_in_d_ready
      (_coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_d_ready),	// LazyModule.scala:432:27
    .io_in_d_valid
      (_coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_valid),	// LazyModule.scala:432:27
    .io_in_d_bits_opcode  (bundleIn_0_2_d_bits_opcode),	// RegisterRouter.scala:94:19
    .io_in_d_bits_size
      (_coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_bits_size),	// LazyModule.scala:432:27
    .io_in_d_bits_source
      (_coupler_to_slave_named_bootaddressreg_auto_fragmenter_out_a_bits_source)	// LazyModule.scala:432:27
  );
  assign auto_coupler_to_device_named_uart_0_control_xing_out_a_bits_data =
    _buffer_auto_out_a_bits_data;	// Buffer.scala:68:28
endmodule

