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

module FrontBus(
  input         auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_a_valid,
  input  [2:0]  auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_a_bits_opcode,
                auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_a_bits_param,
  input  [3:0]  auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_a_bits_size,
  input         auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_a_bits_source,
  input  [31:0] auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_a_bits_address,
  input  [7:0]  auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_a_bits_mask,
  input  [63:0] auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_a_bits_data,
  input         auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_a_bits_corrupt,
                auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_ready,
                auto_subsystem_fbus_clock_groups_in_member_subsystem_fbus_0_clock,
                auto_subsystem_fbus_clock_groups_in_member_subsystem_fbus_0_reset,
                auto_bus_xing_out_a_ready,
                auto_bus_xing_out_d_valid,
  input  [2:0]  auto_bus_xing_out_d_bits_opcode,
  input  [1:0]  auto_bus_xing_out_d_bits_param,
  input  [3:0]  auto_bus_xing_out_d_bits_size,
  input  [2:0]  auto_bus_xing_out_d_bits_sink,
  input         auto_bus_xing_out_d_bits_denied,
  input  [63:0] auto_bus_xing_out_d_bits_data,
  input         auto_bus_xing_out_d_bits_corrupt,
  output        auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_a_ready,
                auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_valid,
  output [2:0]  auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_opcode,
  output [1:0]  auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_param,
  output [3:0]  auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_size,
  output        auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_source,
  output [2:0]  auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_sink,
  output        auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_denied,
  output [63:0] auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_data,
  output        auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_corrupt,
                auto_fixedClockNode_out_clock,
                auto_fixedClockNode_out_reset,
                auto_bus_xing_out_a_valid,
  output [2:0]  auto_bus_xing_out_a_bits_opcode,
                auto_bus_xing_out_a_bits_param,
  output [3:0]  auto_bus_xing_out_a_bits_size,
  output        auto_bus_xing_out_a_bits_source,
  output [31:0] auto_bus_xing_out_a_bits_address,
  output [7:0]  auto_bus_xing_out_a_bits_mask,
  output [63:0] auto_bus_xing_out_a_bits_data,
  output        auto_bus_xing_out_a_bits_corrupt,
                auto_bus_xing_out_d_ready
);

  wire        _coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_valid;	// LazyModule.scala:432:27
  wire [2:0]  _coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_opcode;	// LazyModule.scala:432:27
  wire [2:0]  _coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_param;	// LazyModule.scala:432:27
  wire [3:0]  _coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_size;	// LazyModule.scala:432:27
  wire        _coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_source;	// LazyModule.scala:432:27
  wire [31:0] _coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_address;	// LazyModule.scala:432:27
  wire [7:0]  _coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_mask;	// LazyModule.scala:432:27
  wire [63:0] _coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_data;	// LazyModule.scala:432:27
  wire        _coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_corrupt;	// LazyModule.scala:432:27
  wire        _coupler_from_port_named_serial_tl_ctrl_auto_tl_out_d_ready;	// LazyModule.scala:432:27
  wire        _buffer_auto_in_a_ready;	// Buffer.scala:68:28
  wire        _buffer_auto_in_d_valid;	// Buffer.scala:68:28
  wire [2:0]  _buffer_auto_in_d_bits_opcode;	// Buffer.scala:68:28
  wire [1:0]  _buffer_auto_in_d_bits_param;	// Buffer.scala:68:28
  wire [3:0]  _buffer_auto_in_d_bits_size;	// Buffer.scala:68:28
  wire [2:0]  _buffer_auto_in_d_bits_sink;	// Buffer.scala:68:28
  wire        _buffer_auto_in_d_bits_denied;	// Buffer.scala:68:28
  wire [63:0] _buffer_auto_in_d_bits_data;	// Buffer.scala:68:28
  wire        _buffer_auto_in_d_bits_corrupt;	// Buffer.scala:68:28
  wire        _subsystem_fbus_xbar_auto_in_a_ready;	// BusWrapper.scala:357:32
  wire        _subsystem_fbus_xbar_auto_in_d_valid;	// BusWrapper.scala:357:32
  wire [2:0]  _subsystem_fbus_xbar_auto_in_d_bits_opcode;	// BusWrapper.scala:357:32
  wire [1:0]  _subsystem_fbus_xbar_auto_in_d_bits_param;	// BusWrapper.scala:357:32
  wire [3:0]  _subsystem_fbus_xbar_auto_in_d_bits_size;	// BusWrapper.scala:357:32
  wire [2:0]  _subsystem_fbus_xbar_auto_in_d_bits_sink;	// BusWrapper.scala:357:32
  wire        _subsystem_fbus_xbar_auto_in_d_bits_denied;	// BusWrapper.scala:357:32
  wire [63:0] _subsystem_fbus_xbar_auto_in_d_bits_data;	// BusWrapper.scala:357:32
  wire        _subsystem_fbus_xbar_auto_in_d_bits_corrupt;	// BusWrapper.scala:357:32
  wire        _subsystem_fbus_xbar_auto_out_a_valid;	// BusWrapper.scala:357:32
  wire [2:0]  _subsystem_fbus_xbar_auto_out_a_bits_opcode;	// BusWrapper.scala:357:32
  wire [2:0]  _subsystem_fbus_xbar_auto_out_a_bits_param;	// BusWrapper.scala:357:32
  wire [3:0]  _subsystem_fbus_xbar_auto_out_a_bits_size;	// BusWrapper.scala:357:32
  wire        _subsystem_fbus_xbar_auto_out_a_bits_source;	// BusWrapper.scala:357:32
  wire [31:0] _subsystem_fbus_xbar_auto_out_a_bits_address;	// BusWrapper.scala:357:32
  wire [7:0]  _subsystem_fbus_xbar_auto_out_a_bits_mask;	// BusWrapper.scala:357:32
  wire [63:0] _subsystem_fbus_xbar_auto_out_a_bits_data;	// BusWrapper.scala:357:32
  wire        _subsystem_fbus_xbar_auto_out_a_bits_corrupt;	// BusWrapper.scala:357:32
  wire        _subsystem_fbus_xbar_auto_out_d_ready;	// BusWrapper.scala:357:32
  wire        _fixedClockNode_auto_out_0_clock;	// ClockGroup.scala:106:107
  wire        _fixedClockNode_auto_out_0_reset;	// ClockGroup.scala:106:107
  wire        _clockGroup_auto_out_clock;	// BusWrapper.scala:41:38
  wire        _clockGroup_auto_out_reset;	// BusWrapper.scala:41:38
  wire        _subsystem_fbus_clock_groups_auto_out_member_subsystem_fbus_0_clock;	// BusWrapper.scala:40:48
  wire        _subsystem_fbus_clock_groups_auto_out_member_subsystem_fbus_0_reset;	// BusWrapper.scala:40:48
  ClockGroupAggregator_2 subsystem_fbus_clock_groups (	// BusWrapper.scala:40:48
    .auto_in_member_subsystem_fbus_0_clock
      (auto_subsystem_fbus_clock_groups_in_member_subsystem_fbus_0_clock),
    .auto_in_member_subsystem_fbus_0_reset
      (auto_subsystem_fbus_clock_groups_in_member_subsystem_fbus_0_reset),
    .auto_out_member_subsystem_fbus_0_clock
      (_subsystem_fbus_clock_groups_auto_out_member_subsystem_fbus_0_clock),
    .auto_out_member_subsystem_fbus_0_reset
      (_subsystem_fbus_clock_groups_auto_out_member_subsystem_fbus_0_reset)
  );
  ClockGroup_2 clockGroup (	// BusWrapper.scala:41:38
    .auto_in_member_subsystem_fbus_0_clock
      (_subsystem_fbus_clock_groups_auto_out_member_subsystem_fbus_0_clock),	// BusWrapper.scala:40:48
    .auto_in_member_subsystem_fbus_0_reset
      (_subsystem_fbus_clock_groups_auto_out_member_subsystem_fbus_0_reset),	// BusWrapper.scala:40:48
    .auto_out_clock                        (_clockGroup_auto_out_clock),
    .auto_out_reset                        (_clockGroup_auto_out_reset)
  );
  FixedClockBroadcast_2 fixedClockNode (	// ClockGroup.scala:106:107
    .auto_in_clock    (_clockGroup_auto_out_clock),	// BusWrapper.scala:41:38
    .auto_in_reset    (_clockGroup_auto_out_reset),	// BusWrapper.scala:41:38
    .auto_out_1_clock (auto_fixedClockNode_out_clock),
    .auto_out_1_reset (auto_fixedClockNode_out_reset),
    .auto_out_0_clock (_fixedClockNode_auto_out_0_clock),
    .auto_out_0_reset (_fixedClockNode_auto_out_0_reset)
  );
  TLXbar_3 subsystem_fbus_xbar (	// BusWrapper.scala:357:32
    .auto_in_a_valid
      (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_valid),	// LazyModule.scala:432:27
    .auto_in_a_bits_opcode
      (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_opcode),	// LazyModule.scala:432:27
    .auto_in_a_bits_param
      (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_param),	// LazyModule.scala:432:27
    .auto_in_a_bits_size
      (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_size),	// LazyModule.scala:432:27
    .auto_in_a_bits_source
      (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_source),	// LazyModule.scala:432:27
    .auto_in_a_bits_address
      (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_address),	// LazyModule.scala:432:27
    .auto_in_a_bits_mask
      (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_mask),	// LazyModule.scala:432:27
    .auto_in_a_bits_data
      (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_data),	// LazyModule.scala:432:27
    .auto_in_a_bits_corrupt
      (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_corrupt),	// LazyModule.scala:432:27
    .auto_in_d_ready
      (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_d_ready),	// LazyModule.scala:432:27
    .auto_out_a_ready        (_buffer_auto_in_a_ready),	// Buffer.scala:68:28
    .auto_out_d_valid        (_buffer_auto_in_d_valid),	// Buffer.scala:68:28
    .auto_out_d_bits_opcode  (_buffer_auto_in_d_bits_opcode),	// Buffer.scala:68:28
    .auto_out_d_bits_param   (_buffer_auto_in_d_bits_param),	// Buffer.scala:68:28
    .auto_out_d_bits_size    (_buffer_auto_in_d_bits_size),	// Buffer.scala:68:28
    .auto_out_d_bits_sink    (_buffer_auto_in_d_bits_sink),	// Buffer.scala:68:28
    .auto_out_d_bits_denied  (_buffer_auto_in_d_bits_denied),	// Buffer.scala:68:28
    .auto_out_d_bits_data    (_buffer_auto_in_d_bits_data),	// Buffer.scala:68:28
    .auto_out_d_bits_corrupt (_buffer_auto_in_d_bits_corrupt),	// Buffer.scala:68:28
    .auto_in_a_ready         (_subsystem_fbus_xbar_auto_in_a_ready),
    .auto_in_d_valid         (_subsystem_fbus_xbar_auto_in_d_valid),
    .auto_in_d_bits_opcode   (_subsystem_fbus_xbar_auto_in_d_bits_opcode),
    .auto_in_d_bits_param    (_subsystem_fbus_xbar_auto_in_d_bits_param),
    .auto_in_d_bits_size     (_subsystem_fbus_xbar_auto_in_d_bits_size),
    .auto_in_d_bits_sink     (_subsystem_fbus_xbar_auto_in_d_bits_sink),
    .auto_in_d_bits_denied   (_subsystem_fbus_xbar_auto_in_d_bits_denied),
    .auto_in_d_bits_data     (_subsystem_fbus_xbar_auto_in_d_bits_data),
    .auto_in_d_bits_corrupt  (_subsystem_fbus_xbar_auto_in_d_bits_corrupt),
    .auto_out_a_valid        (_subsystem_fbus_xbar_auto_out_a_valid),
    .auto_out_a_bits_opcode  (_subsystem_fbus_xbar_auto_out_a_bits_opcode),
    .auto_out_a_bits_param   (_subsystem_fbus_xbar_auto_out_a_bits_param),
    .auto_out_a_bits_size    (_subsystem_fbus_xbar_auto_out_a_bits_size),
    .auto_out_a_bits_source  (_subsystem_fbus_xbar_auto_out_a_bits_source),
    .auto_out_a_bits_address (_subsystem_fbus_xbar_auto_out_a_bits_address),
    .auto_out_a_bits_mask    (_subsystem_fbus_xbar_auto_out_a_bits_mask),
    .auto_out_a_bits_data    (_subsystem_fbus_xbar_auto_out_a_bits_data),
    .auto_out_a_bits_corrupt (_subsystem_fbus_xbar_auto_out_a_bits_corrupt),
    .auto_out_d_ready        (_subsystem_fbus_xbar_auto_out_d_ready)
  );
  TLBuffer_5 buffer (	// Buffer.scala:68:28
    .clock                   (_fixedClockNode_auto_out_0_clock),	// ClockGroup.scala:106:107
    .reset                   (_fixedClockNode_auto_out_0_reset),	// ClockGroup.scala:106:107
    .auto_in_a_valid         (_subsystem_fbus_xbar_auto_out_a_valid),	// BusWrapper.scala:357:32
    .auto_in_a_bits_opcode   (_subsystem_fbus_xbar_auto_out_a_bits_opcode),	// BusWrapper.scala:357:32
    .auto_in_a_bits_param    (_subsystem_fbus_xbar_auto_out_a_bits_param),	// BusWrapper.scala:357:32
    .auto_in_a_bits_size     (_subsystem_fbus_xbar_auto_out_a_bits_size),	// BusWrapper.scala:357:32
    .auto_in_a_bits_source   (_subsystem_fbus_xbar_auto_out_a_bits_source),	// BusWrapper.scala:357:32
    .auto_in_a_bits_address  (_subsystem_fbus_xbar_auto_out_a_bits_address),	// BusWrapper.scala:357:32
    .auto_in_a_bits_mask     (_subsystem_fbus_xbar_auto_out_a_bits_mask),	// BusWrapper.scala:357:32
    .auto_in_a_bits_data     (_subsystem_fbus_xbar_auto_out_a_bits_data),	// BusWrapper.scala:357:32
    .auto_in_a_bits_corrupt  (_subsystem_fbus_xbar_auto_out_a_bits_corrupt),	// BusWrapper.scala:357:32
    .auto_in_d_ready         (_subsystem_fbus_xbar_auto_out_d_ready),	// BusWrapper.scala:357:32
    .auto_out_a_ready        (auto_bus_xing_out_a_ready),
    .auto_out_d_valid        (auto_bus_xing_out_d_valid),
    .auto_out_d_bits_opcode  (auto_bus_xing_out_d_bits_opcode),
    .auto_out_d_bits_param   (auto_bus_xing_out_d_bits_param),
    .auto_out_d_bits_size    (auto_bus_xing_out_d_bits_size),
    .auto_out_d_bits_sink    (auto_bus_xing_out_d_bits_sink),
    .auto_out_d_bits_denied  (auto_bus_xing_out_d_bits_denied),
    .auto_out_d_bits_data    (auto_bus_xing_out_d_bits_data),
    .auto_out_d_bits_corrupt (auto_bus_xing_out_d_bits_corrupt),
    .auto_in_a_ready         (_buffer_auto_in_a_ready),
    .auto_in_d_valid         (_buffer_auto_in_d_valid),
    .auto_in_d_bits_opcode   (_buffer_auto_in_d_bits_opcode),
    .auto_in_d_bits_param    (_buffer_auto_in_d_bits_param),
    .auto_in_d_bits_size     (_buffer_auto_in_d_bits_size),
    .auto_in_d_bits_sink     (_buffer_auto_in_d_bits_sink),
    .auto_in_d_bits_denied   (_buffer_auto_in_d_bits_denied),
    .auto_in_d_bits_data     (_buffer_auto_in_d_bits_data),
    .auto_in_d_bits_corrupt  (_buffer_auto_in_d_bits_corrupt),
    .auto_out_a_valid        (auto_bus_xing_out_a_valid),
    .auto_out_a_bits_opcode  (auto_bus_xing_out_a_bits_opcode),
    .auto_out_a_bits_param   (auto_bus_xing_out_a_bits_param),
    .auto_out_a_bits_size    (auto_bus_xing_out_a_bits_size),
    .auto_out_a_bits_source  (auto_bus_xing_out_a_bits_source),
    .auto_out_a_bits_address (auto_bus_xing_out_a_bits_address),
    .auto_out_a_bits_mask    (auto_bus_xing_out_a_bits_mask),
    .auto_out_a_bits_data    (auto_bus_xing_out_a_bits_data),
    .auto_out_a_bits_corrupt (auto_bus_xing_out_a_bits_corrupt),
    .auto_out_d_ready        (auto_bus_xing_out_d_ready)
  );
  TLInterconnectCoupler_12 coupler_from_port_named_serial_tl_ctrl (	// LazyModule.scala:432:27
    .clock                         (_fixedClockNode_auto_out_0_clock),	// ClockGroup.scala:106:107
    .reset                         (_fixedClockNode_auto_out_0_reset),	// ClockGroup.scala:106:107
    .auto_buffer_in_a_valid
      (auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_a_valid),
    .auto_buffer_in_a_bits_opcode
      (auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_a_bits_opcode),
    .auto_buffer_in_a_bits_param
      (auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_a_bits_param),
    .auto_buffer_in_a_bits_size
      (auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_a_bits_size),
    .auto_buffer_in_a_bits_source
      (auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_a_bits_source),
    .auto_buffer_in_a_bits_address
      (auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_a_bits_address),
    .auto_buffer_in_a_bits_mask
      (auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_a_bits_mask),
    .auto_buffer_in_a_bits_data
      (auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_a_bits_data),
    .auto_buffer_in_a_bits_corrupt
      (auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_a_bits_corrupt),
    .auto_buffer_in_d_ready
      (auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_ready),
    .auto_tl_out_a_ready           (_subsystem_fbus_xbar_auto_in_a_ready),	// BusWrapper.scala:357:32
    .auto_tl_out_d_valid           (_subsystem_fbus_xbar_auto_in_d_valid),	// BusWrapper.scala:357:32
    .auto_tl_out_d_bits_opcode     (_subsystem_fbus_xbar_auto_in_d_bits_opcode),	// BusWrapper.scala:357:32
    .auto_tl_out_d_bits_param      (_subsystem_fbus_xbar_auto_in_d_bits_param),	// BusWrapper.scala:357:32
    .auto_tl_out_d_bits_size       (_subsystem_fbus_xbar_auto_in_d_bits_size),	// BusWrapper.scala:357:32
    .auto_tl_out_d_bits_sink       (_subsystem_fbus_xbar_auto_in_d_bits_sink),	// BusWrapper.scala:357:32
    .auto_tl_out_d_bits_denied     (_subsystem_fbus_xbar_auto_in_d_bits_denied),	// BusWrapper.scala:357:32
    .auto_tl_out_d_bits_data       (_subsystem_fbus_xbar_auto_in_d_bits_data),	// BusWrapper.scala:357:32
    .auto_tl_out_d_bits_corrupt    (_subsystem_fbus_xbar_auto_in_d_bits_corrupt),	// BusWrapper.scala:357:32
    .auto_buffer_in_a_ready
      (auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_a_ready),
    .auto_buffer_in_d_valid
      (auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_valid),
    .auto_buffer_in_d_bits_opcode
      (auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_opcode),
    .auto_buffer_in_d_bits_param
      (auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_param),
    .auto_buffer_in_d_bits_size
      (auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_size),
    .auto_buffer_in_d_bits_source
      (auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_source),
    .auto_buffer_in_d_bits_sink
      (auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_sink),
    .auto_buffer_in_d_bits_denied
      (auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_denied),
    .auto_buffer_in_d_bits_data
      (auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_data),
    .auto_buffer_in_d_bits_corrupt
      (auto_coupler_from_port_named_serial_tl_ctrl_buffer_in_d_bits_corrupt),
    .auto_tl_out_a_valid
      (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_valid),
    .auto_tl_out_a_bits_opcode
      (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_opcode),
    .auto_tl_out_a_bits_param
      (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_param),
    .auto_tl_out_a_bits_size
      (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_size),
    .auto_tl_out_a_bits_source
      (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_source),
    .auto_tl_out_a_bits_address
      (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_address),
    .auto_tl_out_a_bits_mask
      (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_mask),
    .auto_tl_out_a_bits_data
      (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_data),
    .auto_tl_out_a_bits_corrupt
      (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_a_bits_corrupt),
    .auto_tl_out_d_ready
      (_coupler_from_port_named_serial_tl_ctrl_auto_tl_out_d_ready)
  );
endmodule

