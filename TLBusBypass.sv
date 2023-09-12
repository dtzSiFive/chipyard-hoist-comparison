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

module TLBusBypass(
  input         clock,
                reset,
                auto_node_out_out_a_ready,
                auto_node_out_out_d_valid,
  input  [2:0]  auto_node_out_out_d_bits_opcode,
  input  [1:0]  auto_node_out_out_d_bits_param,
                auto_node_out_out_d_bits_size,
  input         auto_node_out_out_d_bits_source,
                auto_node_out_out_d_bits_sink,
                auto_node_out_out_d_bits_denied,
  input  [31:0] auto_node_out_out_d_bits_data,
  input         auto_node_out_out_d_bits_corrupt,
                auto_node_in_in_a_valid,
  input  [2:0]  auto_node_in_in_a_bits_opcode,
  input  [8:0]  auto_node_in_in_a_bits_address,
  input  [31:0] auto_node_in_in_a_bits_data,
  input         auto_node_in_in_d_ready,
                io_bypass,
  output        auto_node_out_out_a_valid,
  output [2:0]  auto_node_out_out_a_bits_opcode,
  output [8:0]  auto_node_out_out_a_bits_address,
  output [31:0] auto_node_out_out_a_bits_data,
  output        auto_node_out_out_d_ready,
                auto_node_in_in_a_ready,
                auto_node_in_in_d_valid,
  output [2:0]  auto_node_in_in_d_bits_opcode,
  output [1:0]  auto_node_in_in_d_bits_param,
                auto_node_in_in_d_bits_size,
  output        auto_node_in_in_d_bits_sink,
                auto_node_in_in_d_bits_denied,
  output [31:0] auto_node_in_in_d_bits_data,
  output        auto_node_in_in_d_bits_corrupt
);

  wire         _error_auto_in_a_ready;	// BusBypass.scala:27:40
  wire         _error_auto_in_d_valid;	// BusBypass.scala:27:40
  wire [2:0]   _error_auto_in_d_bits_opcode;	// BusBypass.scala:27:40
  wire [1:0]   _error_auto_in_d_bits_size;	// BusBypass.scala:27:40
  wire         _error_auto_in_d_bits_denied;	// BusBypass.scala:27:40
  wire         _error_auto_in_d_bits_corrupt;	// BusBypass.scala:27:40
  wire         _bar_auto_out_0_a_valid;	// BusBypass.scala:17:33
  wire [2:0]   _bar_auto_out_0_a_bits_opcode;	// BusBypass.scala:17:33
  wire [127:0] _bar_auto_out_0_a_bits_address;	// BusBypass.scala:17:33
  wire         _bar_auto_out_0_d_ready;	// BusBypass.scala:17:33
  TLBusBypassBar bar (	// BusBypass.scala:17:33
    .clock                     (clock),
    .reset                     (reset),
    .auto_in_a_valid           (auto_node_in_in_a_valid),
    .auto_in_a_bits_opcode     (auto_node_in_in_a_bits_opcode),
    .auto_in_a_bits_address    (auto_node_in_in_a_bits_address),
    .auto_in_a_bits_data       (auto_node_in_in_a_bits_data),
    .auto_in_d_ready           (auto_node_in_in_d_ready),
    .auto_out_1_a_ready        (auto_node_out_out_a_ready),
    .auto_out_1_d_valid        (auto_node_out_out_d_valid),
    .auto_out_1_d_bits_opcode  (auto_node_out_out_d_bits_opcode),
    .auto_out_1_d_bits_param   (auto_node_out_out_d_bits_param),
    .auto_out_1_d_bits_size    (auto_node_out_out_d_bits_size),
    .auto_out_1_d_bits_source  (auto_node_out_out_d_bits_source),
    .auto_out_1_d_bits_sink    (auto_node_out_out_d_bits_sink),
    .auto_out_1_d_bits_denied  (auto_node_out_out_d_bits_denied),
    .auto_out_1_d_bits_data    (auto_node_out_out_d_bits_data),
    .auto_out_1_d_bits_corrupt (auto_node_out_out_d_bits_corrupt),
    .auto_out_0_a_ready        (_error_auto_in_a_ready),	// BusBypass.scala:27:40
    .auto_out_0_d_valid        (_error_auto_in_d_valid),	// BusBypass.scala:27:40
    .auto_out_0_d_bits_opcode  (_error_auto_in_d_bits_opcode),	// BusBypass.scala:27:40
    .auto_out_0_d_bits_size    (_error_auto_in_d_bits_size),	// BusBypass.scala:27:40
    .auto_out_0_d_bits_denied  (_error_auto_in_d_bits_denied),	// BusBypass.scala:27:40
    .auto_out_0_d_bits_corrupt (_error_auto_in_d_bits_corrupt),	// BusBypass.scala:27:40
    .io_bypass                 (io_bypass),
    .auto_in_a_ready           (auto_node_in_in_a_ready),
    .auto_in_d_valid           (auto_node_in_in_d_valid),
    .auto_in_d_bits_opcode     (auto_node_in_in_d_bits_opcode),
    .auto_in_d_bits_param      (auto_node_in_in_d_bits_param),
    .auto_in_d_bits_size       (auto_node_in_in_d_bits_size),
    .auto_in_d_bits_sink       (auto_node_in_in_d_bits_sink),
    .auto_in_d_bits_denied     (auto_node_in_in_d_bits_denied),
    .auto_in_d_bits_data       (auto_node_in_in_d_bits_data),
    .auto_in_d_bits_corrupt    (auto_node_in_in_d_bits_corrupt),
    .auto_out_1_a_valid        (auto_node_out_out_a_valid),
    .auto_out_1_a_bits_opcode  (auto_node_out_out_a_bits_opcode),
    .auto_out_1_a_bits_address (auto_node_out_out_a_bits_address),
    .auto_out_1_a_bits_data    (auto_node_out_out_a_bits_data),
    .auto_out_1_d_ready        (auto_node_out_out_d_ready),
    .auto_out_0_a_valid        (_bar_auto_out_0_a_valid),
    .auto_out_0_a_bits_opcode  (_bar_auto_out_0_a_bits_opcode),
    .auto_out_0_a_bits_address (_bar_auto_out_0_a_bits_address),
    .auto_out_0_d_ready        (_bar_auto_out_0_d_ready)
  );
  TLError_1 error (	// BusBypass.scala:27:40
    .clock                  (clock),
    .reset                  (reset),
    .auto_in_a_valid        (_bar_auto_out_0_a_valid),	// BusBypass.scala:17:33
    .auto_in_a_bits_opcode  (_bar_auto_out_0_a_bits_opcode),	// BusBypass.scala:17:33
    .auto_in_a_bits_address (_bar_auto_out_0_a_bits_address),	// BusBypass.scala:17:33
    .auto_in_d_ready        (_bar_auto_out_0_d_ready),	// BusBypass.scala:17:33
    .auto_in_a_ready        (_error_auto_in_a_ready),
    .auto_in_d_valid        (_error_auto_in_d_valid),
    .auto_in_d_bits_opcode  (_error_auto_in_d_bits_opcode),
    .auto_in_d_bits_size    (_error_auto_in_d_bits_size),
    .auto_in_d_bits_denied  (_error_auto_in_d_bits_denied),
    .auto_in_d_bits_corrupt (_error_auto_in_d_bits_corrupt)
  );
endmodule

