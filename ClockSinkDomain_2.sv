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

module ClockSinkDomain_2(
  input         auto_serdesser_client_out_a_ready,
                auto_serdesser_client_out_d_valid,
  input  [2:0]  auto_serdesser_client_out_d_bits_opcode,
  input  [1:0]  auto_serdesser_client_out_d_bits_param,
  input  [3:0]  auto_serdesser_client_out_d_bits_size,
  input         auto_serdesser_client_out_d_bits_source,
  input  [2:0]  auto_serdesser_client_out_d_bits_sink,
  input         auto_serdesser_client_out_d_bits_denied,
  input  [63:0] auto_serdesser_client_out_d_bits_data,
  input         auto_serdesser_client_out_d_bits_corrupt,
                auto_tlserial_manager_crossing_in_a_valid,
  input  [2:0]  auto_tlserial_manager_crossing_in_a_bits_opcode,
                auto_tlserial_manager_crossing_in_a_bits_param,
                auto_tlserial_manager_crossing_in_a_bits_size,
  input  [3:0]  auto_tlserial_manager_crossing_in_a_bits_source,
  input  [28:0] auto_tlserial_manager_crossing_in_a_bits_address,
  input  [7:0]  auto_tlserial_manager_crossing_in_a_bits_mask,
  input  [63:0] auto_tlserial_manager_crossing_in_a_bits_data,
  input         auto_tlserial_manager_crossing_in_a_bits_corrupt,
                auto_tlserial_manager_crossing_in_d_ready,
                auto_clock_in_clock,
                auto_clock_in_reset,
                serial_tl_in_valid,
  input  [3:0]  serial_tl_in_bits,
  input         serial_tl_out_ready,
  output        auto_serdesser_client_out_a_valid,
  output [2:0]  auto_serdesser_client_out_a_bits_opcode,
                auto_serdesser_client_out_a_bits_param,
  output [3:0]  auto_serdesser_client_out_a_bits_size,
  output        auto_serdesser_client_out_a_bits_source,
  output [31:0] auto_serdesser_client_out_a_bits_address,
  output [7:0]  auto_serdesser_client_out_a_bits_mask,
  output [63:0] auto_serdesser_client_out_a_bits_data,
  output        auto_serdesser_client_out_a_bits_corrupt,
                auto_serdesser_client_out_d_ready,
                auto_tlserial_manager_crossing_in_a_ready,
                auto_tlserial_manager_crossing_in_d_valid,
  output [2:0]  auto_tlserial_manager_crossing_in_d_bits_opcode,
  output [1:0]  auto_tlserial_manager_crossing_in_d_bits_param,
  output [2:0]  auto_tlserial_manager_crossing_in_d_bits_size,
  output [3:0]  auto_tlserial_manager_crossing_in_d_bits_source,
  output        auto_tlserial_manager_crossing_in_d_bits_sink,
                auto_tlserial_manager_crossing_in_d_bits_denied,
  output [63:0] auto_tlserial_manager_crossing_in_d_bits_data,
  output        auto_tlserial_manager_crossing_in_d_bits_corrupt,
                serial_tl_in_ready,
                serial_tl_out_valid,
  output [3:0]  serial_tl_out_bits,
  output        clock
);

  wire        _buffer_auto_out_a_valid;	// Buffer.scala:68:28
  wire [2:0]  _buffer_auto_out_a_bits_opcode;	// Buffer.scala:68:28
  wire [2:0]  _buffer_auto_out_a_bits_param;	// Buffer.scala:68:28
  wire [2:0]  _buffer_auto_out_a_bits_size;	// Buffer.scala:68:28
  wire [3:0]  _buffer_auto_out_a_bits_source;	// Buffer.scala:68:28
  wire [28:0] _buffer_auto_out_a_bits_address;	// Buffer.scala:68:28
  wire [7:0]  _buffer_auto_out_a_bits_mask;	// Buffer.scala:68:28
  wire [63:0] _buffer_auto_out_a_bits_data;	// Buffer.scala:68:28
  wire        _buffer_auto_out_a_bits_corrupt;	// Buffer.scala:68:28
  wire        _buffer_auto_out_d_ready;	// Buffer.scala:68:28
  wire        _serdesser_auto_manager_in_a_ready;	// SerialAdapter.scala:376:40
  wire        _serdesser_auto_manager_in_d_valid;	// SerialAdapter.scala:376:40
  wire [2:0]  _serdesser_auto_manager_in_d_bits_opcode;	// SerialAdapter.scala:376:40
  wire [1:0]  _serdesser_auto_manager_in_d_bits_param;	// SerialAdapter.scala:376:40
  wire [2:0]  _serdesser_auto_manager_in_d_bits_size;	// SerialAdapter.scala:376:40
  wire [3:0]  _serdesser_auto_manager_in_d_bits_source;	// SerialAdapter.scala:376:40
  wire        _serdesser_auto_manager_in_d_bits_sink;	// SerialAdapter.scala:376:40
  wire        _serdesser_auto_manager_in_d_bits_denied;	// SerialAdapter.scala:376:40
  wire [63:0] _serdesser_auto_manager_in_d_bits_data;	// SerialAdapter.scala:376:40
  wire        _serdesser_auto_manager_in_d_bits_corrupt;	// SerialAdapter.scala:376:40
  TLSerdesser serdesser (	// SerialAdapter.scala:376:40
    .clock                          (auto_clock_in_clock),
    .reset                          (auto_clock_in_reset),
    .auto_manager_in_a_valid        (_buffer_auto_out_a_valid),	// Buffer.scala:68:28
    .auto_manager_in_a_bits_opcode  (_buffer_auto_out_a_bits_opcode),	// Buffer.scala:68:28
    .auto_manager_in_a_bits_param   (_buffer_auto_out_a_bits_param),	// Buffer.scala:68:28
    .auto_manager_in_a_bits_size    (_buffer_auto_out_a_bits_size),	// Buffer.scala:68:28
    .auto_manager_in_a_bits_source  (_buffer_auto_out_a_bits_source),	// Buffer.scala:68:28
    .auto_manager_in_a_bits_address (_buffer_auto_out_a_bits_address),	// Buffer.scala:68:28
    .auto_manager_in_a_bits_mask    (_buffer_auto_out_a_bits_mask),	// Buffer.scala:68:28
    .auto_manager_in_a_bits_data    (_buffer_auto_out_a_bits_data),	// Buffer.scala:68:28
    .auto_manager_in_a_bits_corrupt (_buffer_auto_out_a_bits_corrupt),	// Buffer.scala:68:28
    .auto_manager_in_d_ready        (_buffer_auto_out_d_ready),	// Buffer.scala:68:28
    .auto_client_out_a_ready        (auto_serdesser_client_out_a_ready),
    .auto_client_out_d_valid        (auto_serdesser_client_out_d_valid),
    .auto_client_out_d_bits_opcode  (auto_serdesser_client_out_d_bits_opcode),
    .auto_client_out_d_bits_param   (auto_serdesser_client_out_d_bits_param),
    .auto_client_out_d_bits_size    (auto_serdesser_client_out_d_bits_size),
    .auto_client_out_d_bits_source  (auto_serdesser_client_out_d_bits_source),
    .auto_client_out_d_bits_sink    (auto_serdesser_client_out_d_bits_sink),
    .auto_client_out_d_bits_denied  (auto_serdesser_client_out_d_bits_denied),
    .auto_client_out_d_bits_data    (auto_serdesser_client_out_d_bits_data),
    .auto_client_out_d_bits_corrupt (auto_serdesser_client_out_d_bits_corrupt),
    .io_ser_in_valid                (serial_tl_in_valid),
    .io_ser_in_bits                 (serial_tl_in_bits),
    .io_ser_out_ready               (serial_tl_out_ready),
    .auto_manager_in_a_ready        (_serdesser_auto_manager_in_a_ready),
    .auto_manager_in_d_valid        (_serdesser_auto_manager_in_d_valid),
    .auto_manager_in_d_bits_opcode  (_serdesser_auto_manager_in_d_bits_opcode),
    .auto_manager_in_d_bits_param   (_serdesser_auto_manager_in_d_bits_param),
    .auto_manager_in_d_bits_size    (_serdesser_auto_manager_in_d_bits_size),
    .auto_manager_in_d_bits_source  (_serdesser_auto_manager_in_d_bits_source),
    .auto_manager_in_d_bits_sink    (_serdesser_auto_manager_in_d_bits_sink),
    .auto_manager_in_d_bits_denied  (_serdesser_auto_manager_in_d_bits_denied),
    .auto_manager_in_d_bits_data    (_serdesser_auto_manager_in_d_bits_data),
    .auto_manager_in_d_bits_corrupt (_serdesser_auto_manager_in_d_bits_corrupt),
    .auto_client_out_a_valid        (auto_serdesser_client_out_a_valid),
    .auto_client_out_a_bits_opcode  (auto_serdesser_client_out_a_bits_opcode),
    .auto_client_out_a_bits_param   (auto_serdesser_client_out_a_bits_param),
    .auto_client_out_a_bits_size    (auto_serdesser_client_out_a_bits_size),
    .auto_client_out_a_bits_source  (auto_serdesser_client_out_a_bits_source),
    .auto_client_out_a_bits_address (auto_serdesser_client_out_a_bits_address),
    .auto_client_out_a_bits_mask    (auto_serdesser_client_out_a_bits_mask),
    .auto_client_out_a_bits_data    (auto_serdesser_client_out_a_bits_data),
    .auto_client_out_a_bits_corrupt (auto_serdesser_client_out_a_bits_corrupt),
    .auto_client_out_d_ready        (auto_serdesser_client_out_d_ready),
    .io_ser_in_ready                (serial_tl_in_ready),
    .io_ser_out_valid               (serial_tl_out_valid),
    .io_ser_out_bits                (serial_tl_out_bits)
  );
  TLBuffer_39 buffer (	// Buffer.scala:68:28
    .clock                   (auto_clock_in_clock),
    .reset                   (auto_clock_in_reset),
    .auto_in_a_valid         (auto_tlserial_manager_crossing_in_a_valid),
    .auto_in_a_bits_opcode   (auto_tlserial_manager_crossing_in_a_bits_opcode),
    .auto_in_a_bits_param    (auto_tlserial_manager_crossing_in_a_bits_param),
    .auto_in_a_bits_size     (auto_tlserial_manager_crossing_in_a_bits_size),
    .auto_in_a_bits_source   (auto_tlserial_manager_crossing_in_a_bits_source),
    .auto_in_a_bits_address  (auto_tlserial_manager_crossing_in_a_bits_address),
    .auto_in_a_bits_mask     (auto_tlserial_manager_crossing_in_a_bits_mask),
    .auto_in_a_bits_data     (auto_tlserial_manager_crossing_in_a_bits_data),
    .auto_in_a_bits_corrupt  (auto_tlserial_manager_crossing_in_a_bits_corrupt),
    .auto_in_d_ready         (auto_tlserial_manager_crossing_in_d_ready),
    .auto_out_a_ready        (_serdesser_auto_manager_in_a_ready),	// SerialAdapter.scala:376:40
    .auto_out_d_valid        (_serdesser_auto_manager_in_d_valid),	// SerialAdapter.scala:376:40
    .auto_out_d_bits_opcode  (_serdesser_auto_manager_in_d_bits_opcode),	// SerialAdapter.scala:376:40
    .auto_out_d_bits_param   (_serdesser_auto_manager_in_d_bits_param),	// SerialAdapter.scala:376:40
    .auto_out_d_bits_size    (_serdesser_auto_manager_in_d_bits_size),	// SerialAdapter.scala:376:40
    .auto_out_d_bits_source  (_serdesser_auto_manager_in_d_bits_source),	// SerialAdapter.scala:376:40
    .auto_out_d_bits_sink    (_serdesser_auto_manager_in_d_bits_sink),	// SerialAdapter.scala:376:40
    .auto_out_d_bits_denied  (_serdesser_auto_manager_in_d_bits_denied),	// SerialAdapter.scala:376:40
    .auto_out_d_bits_data    (_serdesser_auto_manager_in_d_bits_data),	// SerialAdapter.scala:376:40
    .auto_out_d_bits_corrupt (_serdesser_auto_manager_in_d_bits_corrupt),	// SerialAdapter.scala:376:40
    .auto_in_a_ready         (auto_tlserial_manager_crossing_in_a_ready),
    .auto_in_d_valid         (auto_tlserial_manager_crossing_in_d_valid),
    .auto_in_d_bits_opcode   (auto_tlserial_manager_crossing_in_d_bits_opcode),
    .auto_in_d_bits_param    (auto_tlserial_manager_crossing_in_d_bits_param),
    .auto_in_d_bits_size     (auto_tlserial_manager_crossing_in_d_bits_size),
    .auto_in_d_bits_source   (auto_tlserial_manager_crossing_in_d_bits_source),
    .auto_in_d_bits_sink     (auto_tlserial_manager_crossing_in_d_bits_sink),
    .auto_in_d_bits_denied   (auto_tlserial_manager_crossing_in_d_bits_denied),
    .auto_in_d_bits_data     (auto_tlserial_manager_crossing_in_d_bits_data),
    .auto_in_d_bits_corrupt  (auto_tlserial_manager_crossing_in_d_bits_corrupt),
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
  assign clock = auto_clock_in_clock;
endmodule

