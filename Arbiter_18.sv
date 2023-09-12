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

module Arbiter_18(
  input          io_in_0_valid,
                 io_in_0_bits_is_mispredict_update,
                 io_in_0_bits_is_repair_update,
  input  [39:0]  io_in_0_bits_pc,
  input  [7:0]   io_in_0_bits_br_mask,
  input          io_in_0_bits_cfi_idx_valid,
  input  [2:0]   io_in_0_bits_cfi_idx_bits,
  input          io_in_0_bits_cfi_taken,
                 io_in_0_bits_cfi_mispredicted,
                 io_in_0_bits_cfi_is_br,
                 io_in_0_bits_cfi_is_jal,
  input  [63:0]  io_in_0_bits_ghist_old_history,
  input          io_in_0_bits_ghist_new_saw_branch_not_taken,
                 io_in_0_bits_ghist_new_saw_branch_taken,
  input  [39:0]  io_in_0_bits_target,
  input  [119:0] io_in_0_bits_meta_0,
                 io_in_0_bits_meta_1,
  input          io_in_1_valid,
                 io_in_1_bits_is_mispredict_update,
                 io_in_1_bits_is_repair_update,
  input  [7:0]   io_in_1_bits_btb_mispredicts,
  input  [39:0]  io_in_1_bits_pc,
  input  [7:0]   io_in_1_bits_br_mask,
  input          io_in_1_bits_cfi_idx_valid,
  input  [2:0]   io_in_1_bits_cfi_idx_bits,
  input          io_in_1_bits_cfi_taken,
                 io_in_1_bits_cfi_mispredicted,
                 io_in_1_bits_cfi_is_br,
                 io_in_1_bits_cfi_is_jal,
  input  [63:0]  io_in_1_bits_ghist_old_history,
  input          io_in_1_bits_ghist_new_saw_branch_not_taken,
                 io_in_1_bits_ghist_new_saw_branch_taken,
  input  [39:0]  io_in_1_bits_target,
  input  [119:0] io_in_1_bits_meta_0,
                 io_in_1_bits_meta_1,
  output         io_in_1_ready,
                 io_out_valid,
                 io_out_bits_is_mispredict_update,
                 io_out_bits_is_repair_update,
  output [7:0]   io_out_bits_btb_mispredicts,
  output [39:0]  io_out_bits_pc,
  output [7:0]   io_out_bits_br_mask,
  output         io_out_bits_cfi_idx_valid,
  output [2:0]   io_out_bits_cfi_idx_bits,
  output         io_out_bits_cfi_taken,
                 io_out_bits_cfi_mispredicted,
                 io_out_bits_cfi_is_br,
                 io_out_bits_cfi_is_jal,
  output [63:0]  io_out_bits_ghist_old_history,
  output         io_out_bits_ghist_new_saw_branch_not_taken,
                 io_out_bits_ghist_new_saw_branch_taken,
  output [39:0]  io_out_bits_target,
  output [119:0] io_out_bits_meta_0,
                 io_out_bits_meta_1
);

  assign io_in_1_ready = ~io_in_0_valid;	// Arbiter.scala:31:78
  assign io_out_valid = io_in_0_valid | io_in_1_valid;	// Arbiter.scala:135:31
  assign io_out_bits_is_mispredict_update =
    io_in_0_valid ? io_in_0_bits_is_mispredict_update : io_in_1_bits_is_mispredict_update;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_is_repair_update =
    io_in_0_valid ? io_in_0_bits_is_repair_update : io_in_1_bits_is_repair_update;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_btb_mispredicts =
    io_in_0_valid ? 8'h0 : io_in_1_bits_btb_mispredicts;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_pc = io_in_0_valid ? io_in_0_bits_pc : io_in_1_bits_pc;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_br_mask =
    io_in_0_valid ? io_in_0_bits_br_mask : io_in_1_bits_br_mask;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_cfi_idx_valid =
    io_in_0_valid ? io_in_0_bits_cfi_idx_valid : io_in_1_bits_cfi_idx_valid;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_cfi_idx_bits =
    io_in_0_valid ? io_in_0_bits_cfi_idx_bits : io_in_1_bits_cfi_idx_bits;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_cfi_taken =
    io_in_0_valid ? io_in_0_bits_cfi_taken : io_in_1_bits_cfi_taken;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_cfi_mispredicted =
    io_in_0_valid ? io_in_0_bits_cfi_mispredicted : io_in_1_bits_cfi_mispredicted;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_cfi_is_br =
    io_in_0_valid ? io_in_0_bits_cfi_is_br : io_in_1_bits_cfi_is_br;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_cfi_is_jal =
    io_in_0_valid ? io_in_0_bits_cfi_is_jal : io_in_1_bits_cfi_is_jal;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_ghist_old_history =
    io_in_0_valid ? io_in_0_bits_ghist_old_history : io_in_1_bits_ghist_old_history;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_ghist_new_saw_branch_not_taken =
    io_in_0_valid
      ? io_in_0_bits_ghist_new_saw_branch_not_taken
      : io_in_1_bits_ghist_new_saw_branch_not_taken;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_ghist_new_saw_branch_taken =
    io_in_0_valid
      ? io_in_0_bits_ghist_new_saw_branch_taken
      : io_in_1_bits_ghist_new_saw_branch_taken;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_target = io_in_0_valid ? io_in_0_bits_target : io_in_1_bits_target;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_meta_0 = io_in_0_valid ? io_in_0_bits_meta_0 : io_in_1_bits_meta_0;	// Arbiter.scala:124:15, :126:27, :128:19
  assign io_out_bits_meta_1 = io_in_0_valid ? io_in_0_bits_meta_1 : io_in_1_bits_meta_1;	// Arbiter.scala:124:15, :126:27, :128:19
endmodule

