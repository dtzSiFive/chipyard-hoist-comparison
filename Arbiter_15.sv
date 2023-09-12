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

module Arbiter_15(
  input         io_in_0_valid,
  input  [7:0]  io_in_0_bits_req_0_way_en,
  input  [11:0] io_in_0_bits_req_0_addr,
  input         io_in_1_valid,
  input  [7:0]  io_in_1_bits_req_0_way_en,
  input  [11:0] io_in_1_bits_req_0_addr,
  input         io_in_2_valid,
  input  [11:0] io_in_2_bits_req_0_addr,
                io_in_2_bits_req_1_addr,
  input         io_in_2_bits_valid_0,
                io_in_2_bits_valid_1,
  output        io_in_1_ready,
                io_in_2_ready,
                io_out_valid,
  output [7:0]  io_out_bits_req_0_way_en,
  output [11:0] io_out_bits_req_0_addr,
  output [7:0]  io_out_bits_req_1_way_en,
  output [11:0] io_out_bits_req_1_addr,
  output        io_out_bits_valid_0,
                io_out_bits_valid_1
);

  wire _GEN = io_in_0_valid | io_in_1_valid;	// Arbiter.scala:124:15, :126:27, :128:19
  wire _io_out_valid_T = io_in_0_valid | io_in_1_valid;	// Arbiter.scala:31:68
  assign io_in_1_ready = ~io_in_0_valid;	// Arbiter.scala:31:78
  assign io_in_2_ready = ~_io_out_valid_T;	// Arbiter.scala:31:{68,78}
  assign io_out_valid = _io_out_valid_T | io_in_2_valid;	// Arbiter.scala:31:68, :135:31
  assign io_out_bits_req_0_way_en =
    io_in_0_valid
      ? io_in_0_bits_req_0_way_en
      : io_in_1_valid ? io_in_1_bits_req_0_way_en : 8'hFF;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_req_0_addr =
    io_in_0_valid
      ? io_in_0_bits_req_0_addr
      : io_in_1_valid ? io_in_1_bits_req_0_addr : io_in_2_bits_req_0_addr;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_req_1_way_en = _GEN ? 8'h0 : 8'hFF;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_req_1_addr = _GEN ? 12'h0 : io_in_2_bits_req_1_addr;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_valid_0 = _GEN | io_in_2_bits_valid_0;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_valid_1 = ~_GEN & io_in_2_bits_valid_1;	// Arbiter.scala:124:15, :126:27, :128:19
endmodule

