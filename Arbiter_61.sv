// Generated by CIRCT firtool-1.54.0-30-g7bb1650e3
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

module Arbiter_61(
  input         io_in_0_valid,
  input  [6:0]  io_in_0_bits_uop_uopc,
  input  [11:0] io_in_0_bits_uop_br_mask,
  input  [5:0]  io_in_0_bits_uop_rob_idx,
  input  [3:0]  io_in_0_bits_uop_stq_idx,
  input  [6:0]  io_in_0_bits_uop_pdst,
  input         io_in_0_bits_uop_is_amo,
                io_in_0_bits_uop_uses_stq,
  input  [1:0]  io_in_0_bits_uop_dst_rtype,
  input         io_in_0_bits_uop_fp_val,
  input  [64:0] io_in_0_bits_data,
  input         io_in_0_bits_predicated,
                io_in_0_bits_fflags_valid,
  input  [5:0]  io_in_0_bits_fflags_bits_uop_rob_idx,
  input  [4:0]  io_in_0_bits_fflags_bits_flags,
  input         io_in_1_valid,
  input  [6:0]  io_in_1_bits_uop_uopc,
  input  [11:0] io_in_1_bits_uop_br_mask,
  input  [5:0]  io_in_1_bits_uop_rob_idx,
  input  [3:0]  io_in_1_bits_uop_stq_idx,
  input  [6:0]  io_in_1_bits_uop_pdst,
  input         io_in_1_bits_uop_is_amo,
                io_in_1_bits_uop_uses_stq,
  input  [1:0]  io_in_1_bits_uop_dst_rtype,
  input         io_in_1_bits_uop_fp_val,
  input  [64:0] io_in_1_bits_data,
  input         io_in_1_bits_predicated,
                io_in_1_bits_fflags_valid,
  input  [5:0]  io_in_1_bits_fflags_bits_uop_rob_idx,
  input  [4:0]  io_in_1_bits_fflags_bits_flags,
  input         io_out_ready,
  output        io_in_0_ready,
                io_in_1_ready,
                io_out_valid,
  output [6:0]  io_out_bits_uop_uopc,
  output [11:0] io_out_bits_uop_br_mask,
  output [5:0]  io_out_bits_uop_rob_idx,
  output [3:0]  io_out_bits_uop_stq_idx,
  output [6:0]  io_out_bits_uop_pdst,
  output        io_out_bits_uop_is_amo,
                io_out_bits_uop_uses_stq,
  output [1:0]  io_out_bits_uop_dst_rtype,
  output        io_out_bits_uop_fp_val,
  output [64:0] io_out_bits_data,
  output        io_out_bits_predicated,
                io_out_bits_fflags_valid,
  output [5:0]  io_out_bits_fflags_bits_uop_rob_idx,
  output [4:0]  io_out_bits_fflags_bits_flags
);

  assign io_in_0_ready = io_out_ready;
  assign io_in_1_ready = ~io_in_0_valid & io_out_ready;	// Arbiter.scala:31:78, :134:19
  assign io_out_valid = io_in_0_valid | io_in_1_valid;	// Arbiter.scala:135:31
  assign io_out_bits_uop_uopc =
    io_in_0_valid ? io_in_0_bits_uop_uopc : io_in_1_bits_uop_uopc;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_br_mask =
    io_in_0_valid ? io_in_0_bits_uop_br_mask : io_in_1_bits_uop_br_mask;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_rob_idx =
    io_in_0_valid ? io_in_0_bits_uop_rob_idx : io_in_1_bits_uop_rob_idx;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_stq_idx =
    io_in_0_valid ? io_in_0_bits_uop_stq_idx : io_in_1_bits_uop_stq_idx;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_pdst =
    io_in_0_valid ? io_in_0_bits_uop_pdst : io_in_1_bits_uop_pdst;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_is_amo =
    io_in_0_valid ? io_in_0_bits_uop_is_amo : io_in_1_bits_uop_is_amo;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_uses_stq =
    io_in_0_valid ? io_in_0_bits_uop_uses_stq : io_in_1_bits_uop_uses_stq;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_dst_rtype =
    io_in_0_valid ? io_in_0_bits_uop_dst_rtype : io_in_1_bits_uop_dst_rtype;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_uop_fp_val =
    io_in_0_valid ? io_in_0_bits_uop_fp_val : io_in_1_bits_uop_fp_val;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_data = io_in_0_valid ? io_in_0_bits_data : io_in_1_bits_data;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_predicated =
    io_in_0_valid ? io_in_0_bits_predicated : io_in_1_bits_predicated;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_fflags_valid =
    io_in_0_valid ? io_in_0_bits_fflags_valid : io_in_1_bits_fflags_valid;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_fflags_bits_uop_rob_idx =
    io_in_0_valid
      ? io_in_0_bits_fflags_bits_uop_rob_idx
      : io_in_1_bits_fflags_bits_uop_rob_idx;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_fflags_bits_flags =
    io_in_0_valid ? io_in_0_bits_fflags_bits_flags : io_in_1_bits_fflags_bits_flags;	// Arbiter.scala:124:15, :126:27, :128:19
endmodule

