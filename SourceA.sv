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

module SourceA(
  input         clock,
                reset,
                io_req_valid,
  input  [12:0] io_req_bits_tag,
  input  [9:0]  io_req_bits_set,
  input  [2:0]  io_req_bits_param,
                io_req_bits_source,
  input         io_req_bits_block,
                io_a_ready,
  output        io_req_ready,
                io_a_valid,
  output [2:0]  io_a_bits_opcode,
                io_a_bits_param,
                io_a_bits_size,
                io_a_bits_source,
  output [31:0] io_a_bits_address,
  output [7:0]  io_a_bits_mask,
  output [63:0] io_a_bits_data,
  output        io_a_bits_corrupt
);

  Queue_20 io_a_q (	// Decoupled.scala:296:21
    .clock               (clock),
    .reset               (reset),
    .io_enq_valid        (io_req_valid),
    .io_enq_bits_opcode  ({2'h3, ~io_req_bits_block}),	// SourceA.scala:49:24
    .io_enq_bits_param   (io_req_bits_param),
    .io_enq_bits_source  (io_req_bits_source),
    .io_enq_bits_address
      ({io_req_bits_tag[12], 3'h0, io_req_bits_tag[11:0], io_req_bits_set, 6'h0}),	// Cat.scala:30:58, Parameters.scala:218:15, :226:72
    .io_deq_ready        (io_a_ready),
    .io_enq_ready        (io_req_ready),
    .io_deq_valid        (io_a_valid),
    .io_deq_bits_opcode  (io_a_bits_opcode),
    .io_deq_bits_param   (io_a_bits_param),
    .io_deq_bits_size    (io_a_bits_size),
    .io_deq_bits_source  (io_a_bits_source),
    .io_deq_bits_address (io_a_bits_address),
    .io_deq_bits_mask    (io_a_bits_mask),
    .io_deq_bits_data    (io_a_bits_data),
    .io_deq_bits_corrupt (io_a_bits_corrupt)
  );
endmodule

