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

module TLBuffer_1(
  input         clock,
                reset,
                auto_in_a_valid,
  input  [2:0]  auto_in_a_bits_opcode,
                auto_in_a_bits_param,
                auto_in_a_bits_size,
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
  input  [2:0]  auto_out_d_bits_size,
  input  [7:0]  auto_out_d_bits_source,
  input         auto_out_d_bits_sink,
                auto_out_d_bits_denied,
  input  [63:0] auto_out_d_bits_data,
  input         auto_out_d_bits_corrupt,
  output        auto_in_a_ready,
                auto_in_d_valid,
  output [2:0]  auto_in_d_bits_opcode,
  output [1:0]  auto_in_d_bits_param,
  output [2:0]  auto_in_d_bits_size,
  output [7:0]  auto_in_d_bits_source,
  output        auto_in_d_bits_sink,
                auto_in_d_bits_denied,
  output [63:0] auto_in_d_bits_data,
  output        auto_in_d_bits_corrupt,
                auto_out_a_valid,
  output [2:0]  auto_out_a_bits_opcode,
                auto_out_a_bits_param,
                auto_out_a_bits_size,
  output [7:0]  auto_out_a_bits_source,
  output [30:0] auto_out_a_bits_address,
  output [7:0]  auto_out_a_bits_mask,
  output [63:0] auto_out_a_bits_data,
  output        auto_out_a_bits_corrupt,
                auto_out_d_ready
);

  wire       _bundleIn_0_d_q_io_deq_valid;	// Decoupled.scala:296:21
  wire [2:0] _bundleIn_0_d_q_io_deq_bits_opcode;	// Decoupled.scala:296:21
  wire [1:0] _bundleIn_0_d_q_io_deq_bits_param;	// Decoupled.scala:296:21
  wire [2:0] _bundleIn_0_d_q_io_deq_bits_size;	// Decoupled.scala:296:21
  wire [7:0] _bundleIn_0_d_q_io_deq_bits_source;	// Decoupled.scala:296:21
  wire       _bundleIn_0_d_q_io_deq_bits_sink;	// Decoupled.scala:296:21
  wire       _bundleIn_0_d_q_io_deq_bits_denied;	// Decoupled.scala:296:21
  wire       _bundleIn_0_d_q_io_deq_bits_corrupt;	// Decoupled.scala:296:21
  wire       _bundleOut_0_a_q_io_enq_ready;	// Decoupled.scala:296:21
  TLMonitor_18 monitor (	// Nodes.scala:24:25
    .clock                (clock),
    .reset                (reset),
    .io_in_a_ready        (_bundleOut_0_a_q_io_enq_ready),	// Decoupled.scala:296:21
    .io_in_a_valid        (auto_in_a_valid),
    .io_in_a_bits_opcode  (auto_in_a_bits_opcode),
    .io_in_a_bits_param   (auto_in_a_bits_param),
    .io_in_a_bits_size    (auto_in_a_bits_size),
    .io_in_a_bits_source  (auto_in_a_bits_source),
    .io_in_a_bits_address (auto_in_a_bits_address),
    .io_in_a_bits_mask    (auto_in_a_bits_mask),
    .io_in_a_bits_corrupt (auto_in_a_bits_corrupt),
    .io_in_d_ready        (auto_in_d_ready),
    .io_in_d_valid        (_bundleIn_0_d_q_io_deq_valid),	// Decoupled.scala:296:21
    .io_in_d_bits_opcode  (_bundleIn_0_d_q_io_deq_bits_opcode),	// Decoupled.scala:296:21
    .io_in_d_bits_param   (_bundleIn_0_d_q_io_deq_bits_param),	// Decoupled.scala:296:21
    .io_in_d_bits_size    (_bundleIn_0_d_q_io_deq_bits_size),	// Decoupled.scala:296:21
    .io_in_d_bits_source  (_bundleIn_0_d_q_io_deq_bits_source),	// Decoupled.scala:296:21
    .io_in_d_bits_sink    (_bundleIn_0_d_q_io_deq_bits_sink),	// Decoupled.scala:296:21
    .io_in_d_bits_denied  (_bundleIn_0_d_q_io_deq_bits_denied),	// Decoupled.scala:296:21
    .io_in_d_bits_corrupt (_bundleIn_0_d_q_io_deq_bits_corrupt)	// Decoupled.scala:296:21
  );
  Queue bundleOut_0_a_q (	// Decoupled.scala:296:21
    .clock               (clock),
    .reset               (reset),
    .io_enq_valid        (auto_in_a_valid),
    .io_enq_bits_opcode  (auto_in_a_bits_opcode),
    .io_enq_bits_param   (auto_in_a_bits_param),
    .io_enq_bits_size    (auto_in_a_bits_size),
    .io_enq_bits_source  (auto_in_a_bits_source),
    .io_enq_bits_address (auto_in_a_bits_address),
    .io_enq_bits_mask    (auto_in_a_bits_mask),
    .io_enq_bits_data    (auto_in_a_bits_data),
    .io_enq_bits_corrupt (auto_in_a_bits_corrupt),
    .io_deq_ready        (auto_out_a_ready),
    .io_enq_ready        (_bundleOut_0_a_q_io_enq_ready),
    .io_deq_valid        (auto_out_a_valid),
    .io_deq_bits_opcode  (auto_out_a_bits_opcode),
    .io_deq_bits_param   (auto_out_a_bits_param),
    .io_deq_bits_size    (auto_out_a_bits_size),
    .io_deq_bits_source  (auto_out_a_bits_source),
    .io_deq_bits_address (auto_out_a_bits_address),
    .io_deq_bits_mask    (auto_out_a_bits_mask),
    .io_deq_bits_data    (auto_out_a_bits_data),
    .io_deq_bits_corrupt (auto_out_a_bits_corrupt)
  );
  Queue_1 bundleIn_0_d_q (	// Decoupled.scala:296:21
    .clock               (clock),
    .reset               (reset),
    .io_enq_valid        (auto_out_d_valid),
    .io_enq_bits_opcode  (auto_out_d_bits_opcode),
    .io_enq_bits_param   (auto_out_d_bits_param),
    .io_enq_bits_size    (auto_out_d_bits_size),
    .io_enq_bits_source  (auto_out_d_bits_source),
    .io_enq_bits_sink    (auto_out_d_bits_sink),
    .io_enq_bits_denied  (auto_out_d_bits_denied),
    .io_enq_bits_data    (auto_out_d_bits_data),
    .io_enq_bits_corrupt (auto_out_d_bits_corrupt),
    .io_deq_ready        (auto_in_d_ready),
    .io_enq_ready        (auto_out_d_ready),
    .io_deq_valid        (_bundleIn_0_d_q_io_deq_valid),
    .io_deq_bits_opcode  (_bundleIn_0_d_q_io_deq_bits_opcode),
    .io_deq_bits_param   (_bundleIn_0_d_q_io_deq_bits_param),
    .io_deq_bits_size    (_bundleIn_0_d_q_io_deq_bits_size),
    .io_deq_bits_source  (_bundleIn_0_d_q_io_deq_bits_source),
    .io_deq_bits_sink    (_bundleIn_0_d_q_io_deq_bits_sink),
    .io_deq_bits_denied  (_bundleIn_0_d_q_io_deq_bits_denied),
    .io_deq_bits_data    (auto_in_d_bits_data),
    .io_deq_bits_corrupt (_bundleIn_0_d_q_io_deq_bits_corrupt)
  );
  assign auto_in_a_ready = _bundleOut_0_a_q_io_enq_ready;	// Decoupled.scala:296:21
  assign auto_in_d_valid = _bundleIn_0_d_q_io_deq_valid;	// Decoupled.scala:296:21
  assign auto_in_d_bits_opcode = _bundleIn_0_d_q_io_deq_bits_opcode;	// Decoupled.scala:296:21
  assign auto_in_d_bits_param = _bundleIn_0_d_q_io_deq_bits_param;	// Decoupled.scala:296:21
  assign auto_in_d_bits_size = _bundleIn_0_d_q_io_deq_bits_size;	// Decoupled.scala:296:21
  assign auto_in_d_bits_source = _bundleIn_0_d_q_io_deq_bits_source;	// Decoupled.scala:296:21
  assign auto_in_d_bits_sink = _bundleIn_0_d_q_io_deq_bits_sink;	// Decoupled.scala:296:21
  assign auto_in_d_bits_denied = _bundleIn_0_d_q_io_deq_bits_denied;	// Decoupled.scala:296:21
  assign auto_in_d_bits_corrupt = _bundleIn_0_d_q_io_deq_bits_corrupt;	// Decoupled.scala:296:21
endmodule

