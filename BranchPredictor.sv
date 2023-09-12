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

module BranchPredictor(
  input          clock,
                 reset,
                 io_f0_req_valid,
  input  [39:0]  io_f0_req_bits_pc,
  input  [63:0]  io_f0_req_bits_ghist_old_history,
  input          io_f0_req_bits_ghist_new_saw_branch_not_taken,
                 io_f0_req_bits_ghist_new_saw_branch_taken,
                 io_f3_fire,
                 io_update_valid,
                 io_update_bits_is_mispredict_update,
                 io_update_bits_is_repair_update,
  input  [7:0]   io_update_bits_btb_mispredicts,
  input  [39:0]  io_update_bits_pc,
  input  [7:0]   io_update_bits_br_mask,
  input          io_update_bits_cfi_idx_valid,
  input  [2:0]   io_update_bits_cfi_idx_bits,
  input          io_update_bits_cfi_taken,
                 io_update_bits_cfi_mispredicted,
                 io_update_bits_cfi_is_br,
                 io_update_bits_cfi_is_jal,
  input  [63:0]  io_update_bits_ghist_old_history,
  input          io_update_bits_ghist_new_saw_branch_not_taken,
                 io_update_bits_ghist_new_saw_branch_taken,
  input  [39:0]  io_update_bits_target,
  input  [119:0] io_update_bits_meta_0,
                 io_update_bits_meta_1,
  output         io_resp_f1_preds_0_taken,
                 io_resp_f1_preds_0_is_br,
                 io_resp_f1_preds_0_is_jal,
                 io_resp_f1_preds_0_predicted_pc_valid,
  output [39:0]  io_resp_f1_preds_0_predicted_pc_bits,
  output         io_resp_f1_preds_1_taken,
                 io_resp_f1_preds_1_is_br,
                 io_resp_f1_preds_1_is_jal,
                 io_resp_f1_preds_1_predicted_pc_valid,
  output [39:0]  io_resp_f1_preds_1_predicted_pc_bits,
  output         io_resp_f1_preds_2_taken,
                 io_resp_f1_preds_2_is_br,
                 io_resp_f1_preds_2_is_jal,
                 io_resp_f1_preds_2_predicted_pc_valid,
  output [39:0]  io_resp_f1_preds_2_predicted_pc_bits,
  output         io_resp_f1_preds_3_taken,
                 io_resp_f1_preds_3_is_br,
                 io_resp_f1_preds_3_is_jal,
                 io_resp_f1_preds_3_predicted_pc_valid,
  output [39:0]  io_resp_f1_preds_3_predicted_pc_bits,
  output         io_resp_f1_preds_4_taken,
                 io_resp_f1_preds_4_is_br,
                 io_resp_f1_preds_4_is_jal,
                 io_resp_f1_preds_4_predicted_pc_valid,
  output [39:0]  io_resp_f1_preds_4_predicted_pc_bits,
  output         io_resp_f1_preds_5_taken,
                 io_resp_f1_preds_5_is_br,
                 io_resp_f1_preds_5_is_jal,
                 io_resp_f1_preds_5_predicted_pc_valid,
  output [39:0]  io_resp_f1_preds_5_predicted_pc_bits,
  output         io_resp_f1_preds_6_taken,
                 io_resp_f1_preds_6_is_br,
                 io_resp_f1_preds_6_is_jal,
                 io_resp_f1_preds_6_predicted_pc_valid,
  output [39:0]  io_resp_f1_preds_6_predicted_pc_bits,
  output         io_resp_f1_preds_7_taken,
                 io_resp_f1_preds_7_is_br,
                 io_resp_f1_preds_7_is_jal,
                 io_resp_f1_preds_7_predicted_pc_valid,
  output [39:0]  io_resp_f1_preds_7_predicted_pc_bits,
  output         io_resp_f2_preds_0_taken,
                 io_resp_f2_preds_0_is_br,
                 io_resp_f2_preds_0_is_jal,
                 io_resp_f2_preds_0_predicted_pc_valid,
  output [39:0]  io_resp_f2_preds_0_predicted_pc_bits,
  output         io_resp_f2_preds_1_taken,
                 io_resp_f2_preds_1_is_br,
                 io_resp_f2_preds_1_is_jal,
                 io_resp_f2_preds_1_predicted_pc_valid,
  output [39:0]  io_resp_f2_preds_1_predicted_pc_bits,
  output         io_resp_f2_preds_2_taken,
                 io_resp_f2_preds_2_is_br,
                 io_resp_f2_preds_2_is_jal,
                 io_resp_f2_preds_2_predicted_pc_valid,
  output [39:0]  io_resp_f2_preds_2_predicted_pc_bits,
  output         io_resp_f2_preds_3_taken,
                 io_resp_f2_preds_3_is_br,
                 io_resp_f2_preds_3_is_jal,
                 io_resp_f2_preds_3_predicted_pc_valid,
  output [39:0]  io_resp_f2_preds_3_predicted_pc_bits,
  output         io_resp_f2_preds_4_taken,
                 io_resp_f2_preds_4_is_br,
                 io_resp_f2_preds_4_is_jal,
                 io_resp_f2_preds_4_predicted_pc_valid,
  output [39:0]  io_resp_f2_preds_4_predicted_pc_bits,
  output         io_resp_f2_preds_5_taken,
                 io_resp_f2_preds_5_is_br,
                 io_resp_f2_preds_5_is_jal,
                 io_resp_f2_preds_5_predicted_pc_valid,
  output [39:0]  io_resp_f2_preds_5_predicted_pc_bits,
  output         io_resp_f2_preds_6_taken,
                 io_resp_f2_preds_6_is_br,
                 io_resp_f2_preds_6_is_jal,
                 io_resp_f2_preds_6_predicted_pc_valid,
  output [39:0]  io_resp_f2_preds_6_predicted_pc_bits,
  output         io_resp_f2_preds_7_taken,
                 io_resp_f2_preds_7_is_br,
                 io_resp_f2_preds_7_is_jal,
                 io_resp_f2_preds_7_predicted_pc_valid,
  output [39:0]  io_resp_f2_preds_7_predicted_pc_bits,
                 io_resp_f3_pc,
  output         io_resp_f3_preds_0_taken,
                 io_resp_f3_preds_0_is_br,
                 io_resp_f3_preds_0_is_jal,
                 io_resp_f3_preds_0_predicted_pc_valid,
  output [39:0]  io_resp_f3_preds_0_predicted_pc_bits,
  output         io_resp_f3_preds_1_taken,
                 io_resp_f3_preds_1_is_br,
                 io_resp_f3_preds_1_is_jal,
                 io_resp_f3_preds_1_predicted_pc_valid,
  output [39:0]  io_resp_f3_preds_1_predicted_pc_bits,
  output         io_resp_f3_preds_2_taken,
                 io_resp_f3_preds_2_is_br,
                 io_resp_f3_preds_2_is_jal,
                 io_resp_f3_preds_2_predicted_pc_valid,
  output [39:0]  io_resp_f3_preds_2_predicted_pc_bits,
  output         io_resp_f3_preds_3_taken,
                 io_resp_f3_preds_3_is_br,
                 io_resp_f3_preds_3_is_jal,
                 io_resp_f3_preds_3_predicted_pc_valid,
  output [39:0]  io_resp_f3_preds_3_predicted_pc_bits,
  output         io_resp_f3_preds_4_taken,
                 io_resp_f3_preds_4_is_br,
                 io_resp_f3_preds_4_is_jal,
                 io_resp_f3_preds_4_predicted_pc_valid,
  output [39:0]  io_resp_f3_preds_4_predicted_pc_bits,
  output         io_resp_f3_preds_5_taken,
                 io_resp_f3_preds_5_is_br,
                 io_resp_f3_preds_5_is_jal,
                 io_resp_f3_preds_5_predicted_pc_valid,
  output [39:0]  io_resp_f3_preds_5_predicted_pc_bits,
  output         io_resp_f3_preds_6_taken,
                 io_resp_f3_preds_6_is_br,
                 io_resp_f3_preds_6_is_jal,
                 io_resp_f3_preds_6_predicted_pc_valid,
  output [39:0]  io_resp_f3_preds_6_predicted_pc_bits,
  output         io_resp_f3_preds_7_taken,
                 io_resp_f3_preds_7_is_br,
                 io_resp_f3_preds_7_is_jal,
                 io_resp_f3_preds_7_predicted_pc_valid,
  output [39:0]  io_resp_f3_preds_7_predicted_pc_bits,
  output [119:0] io_resp_f3_meta_0,
                 io_resp_f3_meta_1
);

  reg  [39:0] io_resp_f3_pc_REG;	// predictor.scala:364:27
  reg  [39:0] io_resp_f2_pc_REG;	// predictor.scala:363:27
  reg  [39:0] io_resp_f1_pc_REG;	// predictor.scala:362:27
  wire        _banked_predictors_1_io_resp_f1_0_taken;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f1_0_is_br;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f1_0_is_jal;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f1_0_predicted_pc_valid;	// predictor.scala:218:19
  wire [39:0] _banked_predictors_1_io_resp_f1_0_predicted_pc_bits;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f1_1_taken;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f1_1_is_br;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f1_1_is_jal;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f1_1_predicted_pc_valid;	// predictor.scala:218:19
  wire [39:0] _banked_predictors_1_io_resp_f1_1_predicted_pc_bits;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f1_2_taken;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f1_2_is_br;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f1_2_is_jal;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f1_2_predicted_pc_valid;	// predictor.scala:218:19
  wire [39:0] _banked_predictors_1_io_resp_f1_2_predicted_pc_bits;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f1_3_taken;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f1_3_is_br;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f1_3_is_jal;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f1_3_predicted_pc_valid;	// predictor.scala:218:19
  wire [39:0] _banked_predictors_1_io_resp_f1_3_predicted_pc_bits;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f2_0_taken;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f2_0_is_br;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f2_0_is_jal;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f2_0_predicted_pc_valid;	// predictor.scala:218:19
  wire [39:0] _banked_predictors_1_io_resp_f2_0_predicted_pc_bits;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f2_1_taken;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f2_1_is_br;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f2_1_is_jal;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f2_1_predicted_pc_valid;	// predictor.scala:218:19
  wire [39:0] _banked_predictors_1_io_resp_f2_1_predicted_pc_bits;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f2_2_taken;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f2_2_is_br;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f2_2_is_jal;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f2_2_predicted_pc_valid;	// predictor.scala:218:19
  wire [39:0] _banked_predictors_1_io_resp_f2_2_predicted_pc_bits;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f2_3_taken;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f2_3_is_br;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f2_3_is_jal;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f2_3_predicted_pc_valid;	// predictor.scala:218:19
  wire [39:0] _banked_predictors_1_io_resp_f2_3_predicted_pc_bits;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f3_0_taken;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f3_0_is_br;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f3_0_is_jal;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f3_0_predicted_pc_valid;	// predictor.scala:218:19
  wire [39:0] _banked_predictors_1_io_resp_f3_0_predicted_pc_bits;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f3_1_taken;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f3_1_is_br;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f3_1_is_jal;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f3_1_predicted_pc_valid;	// predictor.scala:218:19
  wire [39:0] _banked_predictors_1_io_resp_f3_1_predicted_pc_bits;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f3_2_taken;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f3_2_is_br;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f3_2_is_jal;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f3_2_predicted_pc_valid;	// predictor.scala:218:19
  wire [39:0] _banked_predictors_1_io_resp_f3_2_predicted_pc_bits;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f3_3_taken;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f3_3_is_br;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f3_3_is_jal;	// predictor.scala:218:19
  wire        _banked_predictors_1_io_resp_f3_3_predicted_pc_valid;	// predictor.scala:218:19
  wire [39:0] _banked_predictors_1_io_resp_f3_3_predicted_pc_bits;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f1_0_taken;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f1_0_is_br;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f1_0_is_jal;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f1_0_predicted_pc_valid;	// predictor.scala:218:19
  wire [39:0] _banked_predictors_0_io_resp_f1_0_predicted_pc_bits;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f1_1_taken;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f1_1_is_br;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f1_1_is_jal;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f1_1_predicted_pc_valid;	// predictor.scala:218:19
  wire [39:0] _banked_predictors_0_io_resp_f1_1_predicted_pc_bits;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f1_2_taken;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f1_2_is_br;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f1_2_is_jal;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f1_2_predicted_pc_valid;	// predictor.scala:218:19
  wire [39:0] _banked_predictors_0_io_resp_f1_2_predicted_pc_bits;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f1_3_taken;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f1_3_is_br;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f1_3_is_jal;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f1_3_predicted_pc_valid;	// predictor.scala:218:19
  wire [39:0] _banked_predictors_0_io_resp_f1_3_predicted_pc_bits;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f2_0_taken;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f2_0_is_br;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f2_0_is_jal;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f2_0_predicted_pc_valid;	// predictor.scala:218:19
  wire [39:0] _banked_predictors_0_io_resp_f2_0_predicted_pc_bits;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f2_1_taken;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f2_1_is_br;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f2_1_is_jal;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f2_1_predicted_pc_valid;	// predictor.scala:218:19
  wire [39:0] _banked_predictors_0_io_resp_f2_1_predicted_pc_bits;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f2_2_taken;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f2_2_is_br;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f2_2_is_jal;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f2_2_predicted_pc_valid;	// predictor.scala:218:19
  wire [39:0] _banked_predictors_0_io_resp_f2_2_predicted_pc_bits;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f2_3_taken;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f2_3_is_br;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f2_3_is_jal;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f2_3_predicted_pc_valid;	// predictor.scala:218:19
  wire [39:0] _banked_predictors_0_io_resp_f2_3_predicted_pc_bits;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f3_0_taken;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f3_0_is_br;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f3_0_is_jal;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f3_0_predicted_pc_valid;	// predictor.scala:218:19
  wire [39:0] _banked_predictors_0_io_resp_f3_0_predicted_pc_bits;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f3_1_taken;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f3_1_is_br;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f3_1_is_jal;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f3_1_predicted_pc_valid;	// predictor.scala:218:19
  wire [39:0] _banked_predictors_0_io_resp_f3_1_predicted_pc_bits;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f3_2_taken;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f3_2_is_br;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f3_2_is_jal;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f3_2_predicted_pc_valid;	// predictor.scala:218:19
  wire [39:0] _banked_predictors_0_io_resp_f3_2_predicted_pc_bits;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f3_3_taken;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f3_3_is_br;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f3_3_is_jal;	// predictor.scala:218:19
  wire        _banked_predictors_0_io_resp_f3_3_predicted_pc_valid;	// predictor.scala:218:19
  wire [39:0] _banked_predictors_0_io_resp_f3_3_predicted_pc_bits;	// predictor.scala:218:19
  wire [10:0] _banked_predictors_0_io_f0_mask_T = 11'hFF << io_f0_req_bits_pc[2:1];	// frontend.scala:182:31, package.scala:154:13
  wire [39:0] _GEN = {io_f0_req_bits_pc[39:3], 3'h0};	// frontend.scala:165:46, :182:31
  wire        _GEN_0 =
    (~(io_f0_req_bits_pc[3]) | io_f0_req_bits_pc[5:3] != 3'h7) & io_f0_req_valid;	// frontend.scala:151:47, :153:{28,66}, :161:39, predictor.scala:252:44, :259:40, :273:40
  wire [10:0] _banked_predictors_1_io_f0_mask_T_1 = 11'hFF << io_f0_req_bits_pc[2:1];	// frontend.scala:182:31, package.scala:154:13
  reg         REG;	// predictor.scala:281:18
  reg  [63:0] banked_predictors_0_io_f1_ghist_REG;	// predictor.scala:282:51
  reg  [64:0] banked_predictors_1_io_f1_ghist_REG;	// predictor.scala:283:51
  reg  [64:0] banked_predictors_0_io_f1_ghist_REG_1;	// predictor.scala:285:51
  reg  [63:0] banked_predictors_1_io_f1_ghist_REG_1;	// predictor.scala:286:51
  reg         b0_fire_REG;	// predictor.scala:308:56
  reg         b0_fire_REG_1;	// predictor.scala:308:48
  reg         b0_fire_REG_2;	// predictor.scala:308:40
  reg         b1_fire_REG;	// predictor.scala:309:56
  reg         b1_fire_REG_1;	// predictor.scala:309:48
  reg         b1_fire_REG_2;	// predictor.scala:309:40
  wire [39:0] _GEN_1 = {io_update_bits_pc[39:3], 3'h0};	// frontend.scala:165:46, :182:31
  wire [63:0] _GEN_2 = {io_update_bits_ghist_old_history[62:0], 1'h0};	// frontend.scala:68:75, :165:46
  wire [63:0] _GEN_3 = {io_update_bits_ghist_old_history[62:0], 1'h1};	// frontend.scala:68:{75,80}, :153:21
  `ifndef SYNTHESIS	// predictor.scala:468:13
    always @(posedge clock) begin	// predictor.scala:468:13
      automatic logic [7:0] _GEN_4 =
        io_update_bits_br_mask >> io_update_bits_cfi_idx_bits;	// predictor.scala:468:36
      if (io_update_valid & io_update_bits_cfi_is_br & io_update_bits_cfi_idx_valid
          & ~(_GEN_4[0] | reset)) begin	// predictor.scala:468:{13,36}
        if (`ASSERT_VERBOSE_COND_)	// predictor.scala:468:13
          $error("Assertion failed\n    at predictor.scala:468 assert(io.update.bits.br_mask(io.update.bits.cfi_idx.bits))\n");	// predictor.scala:468:13
        if (`STOP_COND_)	// predictor.scala:468:13
          $fatal;	// predictor.scala:468:13
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    REG <= ~(io_f0_req_bits_pc[3]);	// frontend.scala:151:47, predictor.scala:252:35, :281:18
    banked_predictors_0_io_f1_ghist_REG <= io_f0_req_bits_ghist_old_history;	// predictor.scala:282:51
    if (io_f0_req_bits_ghist_new_saw_branch_taken) begin
      banked_predictors_1_io_f1_ghist_REG <= {io_f0_req_bits_ghist_old_history, 1'h1};	// frontend.scala:68:80, :153:21, predictor.scala:283:51
      banked_predictors_0_io_f1_ghist_REG_1 <= {io_f0_req_bits_ghist_old_history, 1'h1};	// frontend.scala:68:80, :153:21, predictor.scala:285:51
    end
    else if (io_f0_req_bits_ghist_new_saw_branch_not_taken) begin
      banked_predictors_1_io_f1_ghist_REG <= {io_f0_req_bits_ghist_old_history, 1'h0};	// frontend.scala:68:75, :165:46, predictor.scala:283:51
      banked_predictors_0_io_f1_ghist_REG_1 <= {io_f0_req_bits_ghist_old_history, 1'h0};	// frontend.scala:68:75, :165:46, predictor.scala:285:51
    end
    else begin
      automatic logic [64:0] _GEN_5 = {1'h0, io_f0_req_bits_ghist_old_history};	// frontend.scala:69:12, :165:46
      banked_predictors_1_io_f1_ghist_REG <= _GEN_5;	// frontend.scala:69:12, predictor.scala:283:51
      banked_predictors_0_io_f1_ghist_REG_1 <= _GEN_5;	// frontend.scala:69:12, predictor.scala:285:51
    end
    banked_predictors_1_io_f1_ghist_REG_1 <= io_f0_req_bits_ghist_old_history;	// predictor.scala:286:51
    b0_fire_REG <= _GEN_0;	// predictor.scala:252:44, :259:40, :273:40, :308:56
    b0_fire_REG_1 <= b0_fire_REG;	// predictor.scala:308:{48,56}
    b0_fire_REG_2 <= b0_fire_REG_1;	// predictor.scala:308:{40,48}
    b1_fire_REG <= io_f0_req_valid;	// predictor.scala:309:56
    b1_fire_REG_1 <= b1_fire_REG;	// predictor.scala:309:{48,56}
    b1_fire_REG_2 <= b1_fire_REG_1;	// predictor.scala:309:{40,48}
    io_resp_f1_pc_REG <= io_f0_req_bits_pc;	// predictor.scala:362:27
    io_resp_f2_pc_REG <= io_resp_f1_pc_REG;	// predictor.scala:362:27, :363:27
    io_resp_f3_pc_REG <= io_resp_f2_pc_REG;	// predictor.scala:363:27, :364:27
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:12];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [3:0] i = 4'h0; i < 4'hD; i += 4'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        REG = _RANDOM[4'h0][0];	// predictor.scala:281:18
        banked_predictors_0_io_f1_ghist_REG =
          {_RANDOM[4'h0][31:1], _RANDOM[4'h1], _RANDOM[4'h2][0]};	// predictor.scala:281:18, :282:51
        banked_predictors_1_io_f1_ghist_REG =
          {_RANDOM[4'h2][31:1], _RANDOM[4'h3], _RANDOM[4'h4][1:0]};	// predictor.scala:282:51, :283:51
        banked_predictors_0_io_f1_ghist_REG_1 =
          {_RANDOM[4'h4][31:2], _RANDOM[4'h5], _RANDOM[4'h6][2:0]};	// predictor.scala:283:51, :285:51
        banked_predictors_1_io_f1_ghist_REG_1 =
          {_RANDOM[4'h6][31:3], _RANDOM[4'h7], _RANDOM[4'h8][2:0]};	// predictor.scala:285:51, :286:51
        b0_fire_REG = _RANDOM[4'h8][3];	// predictor.scala:286:51, :308:56
        b0_fire_REG_1 = _RANDOM[4'h8][4];	// predictor.scala:286:51, :308:48
        b0_fire_REG_2 = _RANDOM[4'h8][5];	// predictor.scala:286:51, :308:40
        b1_fire_REG = _RANDOM[4'h8][6];	// predictor.scala:286:51, :309:56
        b1_fire_REG_1 = _RANDOM[4'h8][7];	// predictor.scala:286:51, :309:48
        b1_fire_REG_2 = _RANDOM[4'h8][8];	// predictor.scala:286:51, :309:40
        io_resp_f1_pc_REG = {_RANDOM[4'h8][31:9], _RANDOM[4'h9][16:0]};	// predictor.scala:286:51, :362:27
        io_resp_f2_pc_REG = {_RANDOM[4'h9][31:17], _RANDOM[4'hA][24:0]};	// predictor.scala:362:27, :363:27
        io_resp_f3_pc_REG = {_RANDOM[4'hA][31:25], _RANDOM[4'hB], _RANDOM[4'hC][0]};	// predictor.scala:363:27, :364:27
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  ComposedBranchPredictorBank banked_predictors_0 (	// predictor.scala:218:19
    .clock                               (clock),
    .reset                               (reset),
    .io_f0_valid                         (_GEN_0),	// predictor.scala:252:44, :259:40, :273:40
    .io_f0_pc
      (io_f0_req_bits_pc[3] ? _GEN + 40'h8 : {io_f0_req_bits_pc[39:3], 3'h0}),	// frontend.scala:151:47, :161:39, :165:46, :182:31, predictor.scala:252:44, :260:40, :274:40
    .io_f0_mask
      (io_f0_req_bits_pc[3] ? 4'hF : _banked_predictors_0_io_f0_mask_T[3:0]),	// Bitwise.scala:72:12, frontend.scala:151:47, :182:{31,40}, predictor.scala:252:44, :261:40, :275:40
    .io_f1_ghist
      (REG
         ? banked_predictors_0_io_f1_ghist_REG
         : banked_predictors_0_io_f1_ghist_REG_1[63:0]),	// predictor.scala:281:{18,53}, :282:{41,51}, :285:{41,51}
    .io_f3_fire                          (io_f3_fire & b0_fire_REG_2),	// predictor.scala:308:{30,40}
    .io_update_valid
      ((~(io_update_bits_pc[3]) | io_update_bits_pc[5:3] != 3'h7
        & (~io_update_bits_cfi_idx_valid | io_update_bits_cfi_idx_bits[2]))
       & io_update_valid),	// frontend.scala:151:47, :153:{28,66}, :161:39, predictor.scala:408:44, :418:44, :436:87, :437:{10,40,71}, :446:44
    .io_update_bits_is_mispredict_update (io_update_bits_is_mispredict_update),
    .io_update_bits_is_repair_update     (io_update_bits_is_repair_update),
    .io_update_bits_btb_mispredicts
      (io_update_bits_pc[3]
         ? io_update_bits_btb_mispredicts[7:4]
         : io_update_bits_btb_mispredicts[3:0]),	// frontend.scala:151:47, predictor.scala:408:44, :427:60, :455:{60,94}
    .io_update_bits_pc
      (io_update_bits_pc[3] ? _GEN_1 + 40'h8 : {io_update_bits_pc[39:3], 3'h0}),	// frontend.scala:151:47, :161:39, :165:46, :182:31, predictor.scala:408:44, :421:46, :449:46
    .io_update_bits_br_mask
      (io_update_bits_pc[3] ? io_update_bits_br_mask[7:4] : io_update_bits_br_mask[3:0]),	// frontend.scala:151:47, predictor.scala:408:44, :424:51, :452:{51,77}
    .io_update_bits_cfi_idx_valid
      (io_update_bits_pc[3]
         ? io_update_bits_cfi_idx_valid & io_update_bits_cfi_idx_bits[2]
         : io_update_bits_cfi_idx_valid & ~(io_update_bits_cfi_idx_bits[2])),	// frontend.scala:151:47, predictor.scala:408:44, :430:{57,89,120}, :437:71, :458:{57,89}
    .io_update_bits_cfi_idx_bits         (io_update_bits_cfi_idx_bits[1:0]),	// predictor.scala:380:58
    .io_update_bits_cfi_taken            (io_update_bits_cfi_taken),
    .io_update_bits_cfi_mispredicted     (io_update_bits_cfi_mispredicted),
    .io_update_bits_cfi_is_br            (io_update_bits_cfi_is_br),
    .io_update_bits_cfi_is_jal           (io_update_bits_cfi_is_jal),
    .io_update_bits_ghist
      (io_update_bits_pc[3]
         ? (io_update_bits_ghist_new_saw_branch_taken
              ? _GEN_3
              : io_update_bits_ghist_new_saw_branch_not_taken
                  ? _GEN_2
                  : io_update_bits_ghist_old_history)
         : io_update_bits_ghist_old_history),	// frontend.scala:68:{12,75,80}, :69:12, :151:47, predictor.scala:408:44, :433:49, :461:49
    .io_update_bits_target               (io_update_bits_target),
    .io_update_bits_meta                 (io_update_bits_meta_0),
    .io_resp_f1_0_taken                  (_banked_predictors_0_io_resp_f1_0_taken),
    .io_resp_f1_0_is_br                  (_banked_predictors_0_io_resp_f1_0_is_br),
    .io_resp_f1_0_is_jal                 (_banked_predictors_0_io_resp_f1_0_is_jal),
    .io_resp_f1_0_predicted_pc_valid
      (_banked_predictors_0_io_resp_f1_0_predicted_pc_valid),
    .io_resp_f1_0_predicted_pc_bits
      (_banked_predictors_0_io_resp_f1_0_predicted_pc_bits),
    .io_resp_f1_1_taken                  (_banked_predictors_0_io_resp_f1_1_taken),
    .io_resp_f1_1_is_br                  (_banked_predictors_0_io_resp_f1_1_is_br),
    .io_resp_f1_1_is_jal                 (_banked_predictors_0_io_resp_f1_1_is_jal),
    .io_resp_f1_1_predicted_pc_valid
      (_banked_predictors_0_io_resp_f1_1_predicted_pc_valid),
    .io_resp_f1_1_predicted_pc_bits
      (_banked_predictors_0_io_resp_f1_1_predicted_pc_bits),
    .io_resp_f1_2_taken                  (_banked_predictors_0_io_resp_f1_2_taken),
    .io_resp_f1_2_is_br                  (_banked_predictors_0_io_resp_f1_2_is_br),
    .io_resp_f1_2_is_jal                 (_banked_predictors_0_io_resp_f1_2_is_jal),
    .io_resp_f1_2_predicted_pc_valid
      (_banked_predictors_0_io_resp_f1_2_predicted_pc_valid),
    .io_resp_f1_2_predicted_pc_bits
      (_banked_predictors_0_io_resp_f1_2_predicted_pc_bits),
    .io_resp_f1_3_taken                  (_banked_predictors_0_io_resp_f1_3_taken),
    .io_resp_f1_3_is_br                  (_banked_predictors_0_io_resp_f1_3_is_br),
    .io_resp_f1_3_is_jal                 (_banked_predictors_0_io_resp_f1_3_is_jal),
    .io_resp_f1_3_predicted_pc_valid
      (_banked_predictors_0_io_resp_f1_3_predicted_pc_valid),
    .io_resp_f1_3_predicted_pc_bits
      (_banked_predictors_0_io_resp_f1_3_predicted_pc_bits),
    .io_resp_f2_0_taken                  (_banked_predictors_0_io_resp_f2_0_taken),
    .io_resp_f2_0_is_br                  (_banked_predictors_0_io_resp_f2_0_is_br),
    .io_resp_f2_0_is_jal                 (_banked_predictors_0_io_resp_f2_0_is_jal),
    .io_resp_f2_0_predicted_pc_valid
      (_banked_predictors_0_io_resp_f2_0_predicted_pc_valid),
    .io_resp_f2_0_predicted_pc_bits
      (_banked_predictors_0_io_resp_f2_0_predicted_pc_bits),
    .io_resp_f2_1_taken                  (_banked_predictors_0_io_resp_f2_1_taken),
    .io_resp_f2_1_is_br                  (_banked_predictors_0_io_resp_f2_1_is_br),
    .io_resp_f2_1_is_jal                 (_banked_predictors_0_io_resp_f2_1_is_jal),
    .io_resp_f2_1_predicted_pc_valid
      (_banked_predictors_0_io_resp_f2_1_predicted_pc_valid),
    .io_resp_f2_1_predicted_pc_bits
      (_banked_predictors_0_io_resp_f2_1_predicted_pc_bits),
    .io_resp_f2_2_taken                  (_banked_predictors_0_io_resp_f2_2_taken),
    .io_resp_f2_2_is_br                  (_banked_predictors_0_io_resp_f2_2_is_br),
    .io_resp_f2_2_is_jal                 (_banked_predictors_0_io_resp_f2_2_is_jal),
    .io_resp_f2_2_predicted_pc_valid
      (_banked_predictors_0_io_resp_f2_2_predicted_pc_valid),
    .io_resp_f2_2_predicted_pc_bits
      (_banked_predictors_0_io_resp_f2_2_predicted_pc_bits),
    .io_resp_f2_3_taken                  (_banked_predictors_0_io_resp_f2_3_taken),
    .io_resp_f2_3_is_br                  (_banked_predictors_0_io_resp_f2_3_is_br),
    .io_resp_f2_3_is_jal                 (_banked_predictors_0_io_resp_f2_3_is_jal),
    .io_resp_f2_3_predicted_pc_valid
      (_banked_predictors_0_io_resp_f2_3_predicted_pc_valid),
    .io_resp_f2_3_predicted_pc_bits
      (_banked_predictors_0_io_resp_f2_3_predicted_pc_bits),
    .io_resp_f3_0_taken                  (_banked_predictors_0_io_resp_f3_0_taken),
    .io_resp_f3_0_is_br                  (_banked_predictors_0_io_resp_f3_0_is_br),
    .io_resp_f3_0_is_jal                 (_banked_predictors_0_io_resp_f3_0_is_jal),
    .io_resp_f3_0_predicted_pc_valid
      (_banked_predictors_0_io_resp_f3_0_predicted_pc_valid),
    .io_resp_f3_0_predicted_pc_bits
      (_banked_predictors_0_io_resp_f3_0_predicted_pc_bits),
    .io_resp_f3_1_taken                  (_banked_predictors_0_io_resp_f3_1_taken),
    .io_resp_f3_1_is_br                  (_banked_predictors_0_io_resp_f3_1_is_br),
    .io_resp_f3_1_is_jal                 (_banked_predictors_0_io_resp_f3_1_is_jal),
    .io_resp_f3_1_predicted_pc_valid
      (_banked_predictors_0_io_resp_f3_1_predicted_pc_valid),
    .io_resp_f3_1_predicted_pc_bits
      (_banked_predictors_0_io_resp_f3_1_predicted_pc_bits),
    .io_resp_f3_2_taken                  (_banked_predictors_0_io_resp_f3_2_taken),
    .io_resp_f3_2_is_br                  (_banked_predictors_0_io_resp_f3_2_is_br),
    .io_resp_f3_2_is_jal                 (_banked_predictors_0_io_resp_f3_2_is_jal),
    .io_resp_f3_2_predicted_pc_valid
      (_banked_predictors_0_io_resp_f3_2_predicted_pc_valid),
    .io_resp_f3_2_predicted_pc_bits
      (_banked_predictors_0_io_resp_f3_2_predicted_pc_bits),
    .io_resp_f3_3_taken                  (_banked_predictors_0_io_resp_f3_3_taken),
    .io_resp_f3_3_is_br                  (_banked_predictors_0_io_resp_f3_3_is_br),
    .io_resp_f3_3_is_jal                 (_banked_predictors_0_io_resp_f3_3_is_jal),
    .io_resp_f3_3_predicted_pc_valid
      (_banked_predictors_0_io_resp_f3_3_predicted_pc_valid),
    .io_resp_f3_3_predicted_pc_bits
      (_banked_predictors_0_io_resp_f3_3_predicted_pc_bits),
    .io_f3_meta                          (io_resp_f3_meta_0)
  );
  ComposedBranchPredictorBank banked_predictors_1 (	// predictor.scala:218:19
    .clock                               (clock),
    .reset                               (reset),
    .io_f0_valid                         (io_f0_req_valid),
    .io_f0_pc
      (io_f0_req_bits_pc[3] ? {io_f0_req_bits_pc[39:3], 3'h0} : _GEN + 40'h8),	// frontend.scala:151:47, :161:39, :165:46, :182:31, predictor.scala:252:44, :264:40, :278:40
    .io_f0_mask
      (io_f0_req_bits_pc[3] ? _banked_predictors_1_io_f0_mask_T_1[3:0] : 4'hF),	// Bitwise.scala:72:12, frontend.scala:151:47, :182:{31,40}, predictor.scala:252:44, :265:40, :279:40
    .io_f1_ghist
      (REG
         ? banked_predictors_1_io_f1_ghist_REG[63:0]
         : banked_predictors_1_io_f1_ghist_REG_1),	// predictor.scala:281:{18,53}, :283:{41,51}, :286:{41,51}
    .io_f3_fire                          (io_f3_fire & b1_fire_REG_2),	// predictor.scala:309:{30,40}
    .io_update_valid
      ((io_update_bits_pc[3] | ~io_update_bits_cfi_idx_valid
        | io_update_bits_cfi_idx_bits[2]) & io_update_valid),	// frontend.scala:151:47, predictor.scala:408:44, :410:{10,71}, :419:44, :445:44
    .io_update_bits_is_mispredict_update (io_update_bits_is_mispredict_update),
    .io_update_bits_is_repair_update     (io_update_bits_is_repair_update),
    .io_update_bits_btb_mispredicts
      (io_update_bits_pc[3]
         ? io_update_bits_btb_mispredicts[3:0]
         : io_update_bits_btb_mispredicts[7:4]),	// frontend.scala:151:47, predictor.scala:408:44, :427:60, :428:{60,94}, :454:60
    .io_update_bits_pc
      (io_update_bits_pc[3] ? {io_update_bits_pc[39:3], 3'h0} : _GEN_1 + 40'h8),	// frontend.scala:151:47, :161:39, :165:46, :182:31, predictor.scala:408:44, :422:46, :448:46
    .io_update_bits_br_mask
      (io_update_bits_pc[3] ? io_update_bits_br_mask[3:0] : io_update_bits_br_mask[7:4]),	// frontend.scala:151:47, predictor.scala:408:44, :424:51, :425:{51,77}, :451:51
    .io_update_bits_cfi_idx_valid
      (io_update_bits_pc[3]
         ? io_update_bits_cfi_idx_valid & ~(io_update_bits_cfi_idx_bits[2])
         : io_update_bits_cfi_idx_valid & io_update_bits_cfi_idx_bits[2]),	// frontend.scala:151:47, predictor.scala:408:44, :410:71, :430:120, :431:{57,89}, :457:{57,89,120}
    .io_update_bits_cfi_idx_bits         (io_update_bits_cfi_idx_bits[1:0]),	// predictor.scala:380:58
    .io_update_bits_cfi_taken            (io_update_bits_cfi_taken),
    .io_update_bits_cfi_mispredicted     (io_update_bits_cfi_mispredicted),
    .io_update_bits_cfi_is_br            (io_update_bits_cfi_is_br),
    .io_update_bits_cfi_is_jal           (io_update_bits_cfi_is_jal),
    .io_update_bits_ghist
      (io_update_bits_pc[3]
         ? io_update_bits_ghist_old_history
         : io_update_bits_ghist_new_saw_branch_taken
             ? _GEN_3
             : io_update_bits_ghist_new_saw_branch_not_taken
                 ? _GEN_2
                 : io_update_bits_ghist_old_history),	// frontend.scala:68:{12,75,80}, :69:12, :151:47, predictor.scala:408:44, :434:49, :460:49
    .io_update_bits_target               (io_update_bits_target),
    .io_update_bits_meta                 (io_update_bits_meta_1),
    .io_resp_f1_0_taken                  (_banked_predictors_1_io_resp_f1_0_taken),
    .io_resp_f1_0_is_br                  (_banked_predictors_1_io_resp_f1_0_is_br),
    .io_resp_f1_0_is_jal                 (_banked_predictors_1_io_resp_f1_0_is_jal),
    .io_resp_f1_0_predicted_pc_valid
      (_banked_predictors_1_io_resp_f1_0_predicted_pc_valid),
    .io_resp_f1_0_predicted_pc_bits
      (_banked_predictors_1_io_resp_f1_0_predicted_pc_bits),
    .io_resp_f1_1_taken                  (_banked_predictors_1_io_resp_f1_1_taken),
    .io_resp_f1_1_is_br                  (_banked_predictors_1_io_resp_f1_1_is_br),
    .io_resp_f1_1_is_jal                 (_banked_predictors_1_io_resp_f1_1_is_jal),
    .io_resp_f1_1_predicted_pc_valid
      (_banked_predictors_1_io_resp_f1_1_predicted_pc_valid),
    .io_resp_f1_1_predicted_pc_bits
      (_banked_predictors_1_io_resp_f1_1_predicted_pc_bits),
    .io_resp_f1_2_taken                  (_banked_predictors_1_io_resp_f1_2_taken),
    .io_resp_f1_2_is_br                  (_banked_predictors_1_io_resp_f1_2_is_br),
    .io_resp_f1_2_is_jal                 (_banked_predictors_1_io_resp_f1_2_is_jal),
    .io_resp_f1_2_predicted_pc_valid
      (_banked_predictors_1_io_resp_f1_2_predicted_pc_valid),
    .io_resp_f1_2_predicted_pc_bits
      (_banked_predictors_1_io_resp_f1_2_predicted_pc_bits),
    .io_resp_f1_3_taken                  (_banked_predictors_1_io_resp_f1_3_taken),
    .io_resp_f1_3_is_br                  (_banked_predictors_1_io_resp_f1_3_is_br),
    .io_resp_f1_3_is_jal                 (_banked_predictors_1_io_resp_f1_3_is_jal),
    .io_resp_f1_3_predicted_pc_valid
      (_banked_predictors_1_io_resp_f1_3_predicted_pc_valid),
    .io_resp_f1_3_predicted_pc_bits
      (_banked_predictors_1_io_resp_f1_3_predicted_pc_bits),
    .io_resp_f2_0_taken                  (_banked_predictors_1_io_resp_f2_0_taken),
    .io_resp_f2_0_is_br                  (_banked_predictors_1_io_resp_f2_0_is_br),
    .io_resp_f2_0_is_jal                 (_banked_predictors_1_io_resp_f2_0_is_jal),
    .io_resp_f2_0_predicted_pc_valid
      (_banked_predictors_1_io_resp_f2_0_predicted_pc_valid),
    .io_resp_f2_0_predicted_pc_bits
      (_banked_predictors_1_io_resp_f2_0_predicted_pc_bits),
    .io_resp_f2_1_taken                  (_banked_predictors_1_io_resp_f2_1_taken),
    .io_resp_f2_1_is_br                  (_banked_predictors_1_io_resp_f2_1_is_br),
    .io_resp_f2_1_is_jal                 (_banked_predictors_1_io_resp_f2_1_is_jal),
    .io_resp_f2_1_predicted_pc_valid
      (_banked_predictors_1_io_resp_f2_1_predicted_pc_valid),
    .io_resp_f2_1_predicted_pc_bits
      (_banked_predictors_1_io_resp_f2_1_predicted_pc_bits),
    .io_resp_f2_2_taken                  (_banked_predictors_1_io_resp_f2_2_taken),
    .io_resp_f2_2_is_br                  (_banked_predictors_1_io_resp_f2_2_is_br),
    .io_resp_f2_2_is_jal                 (_banked_predictors_1_io_resp_f2_2_is_jal),
    .io_resp_f2_2_predicted_pc_valid
      (_banked_predictors_1_io_resp_f2_2_predicted_pc_valid),
    .io_resp_f2_2_predicted_pc_bits
      (_banked_predictors_1_io_resp_f2_2_predicted_pc_bits),
    .io_resp_f2_3_taken                  (_banked_predictors_1_io_resp_f2_3_taken),
    .io_resp_f2_3_is_br                  (_banked_predictors_1_io_resp_f2_3_is_br),
    .io_resp_f2_3_is_jal                 (_banked_predictors_1_io_resp_f2_3_is_jal),
    .io_resp_f2_3_predicted_pc_valid
      (_banked_predictors_1_io_resp_f2_3_predicted_pc_valid),
    .io_resp_f2_3_predicted_pc_bits
      (_banked_predictors_1_io_resp_f2_3_predicted_pc_bits),
    .io_resp_f3_0_taken                  (_banked_predictors_1_io_resp_f3_0_taken),
    .io_resp_f3_0_is_br                  (_banked_predictors_1_io_resp_f3_0_is_br),
    .io_resp_f3_0_is_jal                 (_banked_predictors_1_io_resp_f3_0_is_jal),
    .io_resp_f3_0_predicted_pc_valid
      (_banked_predictors_1_io_resp_f3_0_predicted_pc_valid),
    .io_resp_f3_0_predicted_pc_bits
      (_banked_predictors_1_io_resp_f3_0_predicted_pc_bits),
    .io_resp_f3_1_taken                  (_banked_predictors_1_io_resp_f3_1_taken),
    .io_resp_f3_1_is_br                  (_banked_predictors_1_io_resp_f3_1_is_br),
    .io_resp_f3_1_is_jal                 (_banked_predictors_1_io_resp_f3_1_is_jal),
    .io_resp_f3_1_predicted_pc_valid
      (_banked_predictors_1_io_resp_f3_1_predicted_pc_valid),
    .io_resp_f3_1_predicted_pc_bits
      (_banked_predictors_1_io_resp_f3_1_predicted_pc_bits),
    .io_resp_f3_2_taken                  (_banked_predictors_1_io_resp_f3_2_taken),
    .io_resp_f3_2_is_br                  (_banked_predictors_1_io_resp_f3_2_is_br),
    .io_resp_f3_2_is_jal                 (_banked_predictors_1_io_resp_f3_2_is_jal),
    .io_resp_f3_2_predicted_pc_valid
      (_banked_predictors_1_io_resp_f3_2_predicted_pc_valid),
    .io_resp_f3_2_predicted_pc_bits
      (_banked_predictors_1_io_resp_f3_2_predicted_pc_bits),
    .io_resp_f3_3_taken                  (_banked_predictors_1_io_resp_f3_3_taken),
    .io_resp_f3_3_is_br                  (_banked_predictors_1_io_resp_f3_3_is_br),
    .io_resp_f3_3_is_jal                 (_banked_predictors_1_io_resp_f3_3_is_jal),
    .io_resp_f3_3_predicted_pc_valid
      (_banked_predictors_1_io_resp_f3_3_predicted_pc_valid),
    .io_resp_f3_3_predicted_pc_bits
      (_banked_predictors_1_io_resp_f3_3_predicted_pc_bits),
    .io_f3_meta                          (io_resp_f3_meta_1)
  );
  assign io_resp_f1_preds_0_taken =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_1_io_resp_f1_0_taken
      : _banked_predictors_0_io_resp_f1_0_taken;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :327:39, :332:39, :362:27
  assign io_resp_f1_preds_0_is_br =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_1_io_resp_f1_0_is_br
      : _banked_predictors_0_io_resp_f1_0_is_br;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :327:39, :332:39, :362:27
  assign io_resp_f1_preds_0_is_jal =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_1_io_resp_f1_0_is_jal
      : _banked_predictors_0_io_resp_f1_0_is_jal;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :327:39, :332:39, :362:27
  assign io_resp_f1_preds_0_predicted_pc_valid =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_1_io_resp_f1_0_predicted_pc_valid
      : _banked_predictors_0_io_resp_f1_0_predicted_pc_valid;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :327:39, :332:39, :362:27
  assign io_resp_f1_preds_0_predicted_pc_bits =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_1_io_resp_f1_0_predicted_pc_bits
      : _banked_predictors_0_io_resp_f1_0_predicted_pc_bits;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :327:39, :332:39, :362:27
  assign io_resp_f1_preds_1_taken =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_1_io_resp_f1_1_taken
      : _banked_predictors_0_io_resp_f1_1_taken;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :327:39, :332:39, :362:27
  assign io_resp_f1_preds_1_is_br =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_1_io_resp_f1_1_is_br
      : _banked_predictors_0_io_resp_f1_1_is_br;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :327:39, :332:39, :362:27
  assign io_resp_f1_preds_1_is_jal =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_1_io_resp_f1_1_is_jal
      : _banked_predictors_0_io_resp_f1_1_is_jal;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :327:39, :332:39, :362:27
  assign io_resp_f1_preds_1_predicted_pc_valid =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_1_io_resp_f1_1_predicted_pc_valid
      : _banked_predictors_0_io_resp_f1_1_predicted_pc_valid;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :327:39, :332:39, :362:27
  assign io_resp_f1_preds_1_predicted_pc_bits =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_1_io_resp_f1_1_predicted_pc_bits
      : _banked_predictors_0_io_resp_f1_1_predicted_pc_bits;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :327:39, :332:39, :362:27
  assign io_resp_f1_preds_2_taken =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_1_io_resp_f1_2_taken
      : _banked_predictors_0_io_resp_f1_2_taken;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :327:39, :332:39, :362:27
  assign io_resp_f1_preds_2_is_br =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_1_io_resp_f1_2_is_br
      : _banked_predictors_0_io_resp_f1_2_is_br;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :327:39, :332:39, :362:27
  assign io_resp_f1_preds_2_is_jal =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_1_io_resp_f1_2_is_jal
      : _banked_predictors_0_io_resp_f1_2_is_jal;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :327:39, :332:39, :362:27
  assign io_resp_f1_preds_2_predicted_pc_valid =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_1_io_resp_f1_2_predicted_pc_valid
      : _banked_predictors_0_io_resp_f1_2_predicted_pc_valid;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :327:39, :332:39, :362:27
  assign io_resp_f1_preds_2_predicted_pc_bits =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_1_io_resp_f1_2_predicted_pc_bits
      : _banked_predictors_0_io_resp_f1_2_predicted_pc_bits;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :327:39, :332:39, :362:27
  assign io_resp_f1_preds_3_taken =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_1_io_resp_f1_3_taken
      : _banked_predictors_0_io_resp_f1_3_taken;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :327:39, :332:39, :362:27
  assign io_resp_f1_preds_3_is_br =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_1_io_resp_f1_3_is_br
      : _banked_predictors_0_io_resp_f1_3_is_br;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :327:39, :332:39, :362:27
  assign io_resp_f1_preds_3_is_jal =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_1_io_resp_f1_3_is_jal
      : _banked_predictors_0_io_resp_f1_3_is_jal;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :327:39, :332:39, :362:27
  assign io_resp_f1_preds_3_predicted_pc_valid =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_1_io_resp_f1_3_predicted_pc_valid
      : _banked_predictors_0_io_resp_f1_3_predicted_pc_valid;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :327:39, :332:39, :362:27
  assign io_resp_f1_preds_3_predicted_pc_bits =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_1_io_resp_f1_3_predicted_pc_bits
      : _banked_predictors_0_io_resp_f1_3_predicted_pc_bits;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :327:39, :332:39, :362:27
  assign io_resp_f1_preds_4_taken =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_0_io_resp_f1_0_taken
      : _banked_predictors_1_io_resp_f1_0_taken;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :328:39, :333:39, :362:27
  assign io_resp_f1_preds_4_is_br =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_0_io_resp_f1_0_is_br
      : _banked_predictors_1_io_resp_f1_0_is_br;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :328:39, :333:39, :362:27
  assign io_resp_f1_preds_4_is_jal =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_0_io_resp_f1_0_is_jal
      : _banked_predictors_1_io_resp_f1_0_is_jal;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :328:39, :333:39, :362:27
  assign io_resp_f1_preds_4_predicted_pc_valid =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_0_io_resp_f1_0_predicted_pc_valid
      : _banked_predictors_1_io_resp_f1_0_predicted_pc_valid;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :328:39, :333:39, :362:27
  assign io_resp_f1_preds_4_predicted_pc_bits =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_0_io_resp_f1_0_predicted_pc_bits
      : _banked_predictors_1_io_resp_f1_0_predicted_pc_bits;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :328:39, :333:39, :362:27
  assign io_resp_f1_preds_5_taken =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_0_io_resp_f1_1_taken
      : _banked_predictors_1_io_resp_f1_1_taken;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :328:39, :333:39, :362:27
  assign io_resp_f1_preds_5_is_br =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_0_io_resp_f1_1_is_br
      : _banked_predictors_1_io_resp_f1_1_is_br;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :328:39, :333:39, :362:27
  assign io_resp_f1_preds_5_is_jal =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_0_io_resp_f1_1_is_jal
      : _banked_predictors_1_io_resp_f1_1_is_jal;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :328:39, :333:39, :362:27
  assign io_resp_f1_preds_5_predicted_pc_valid =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_0_io_resp_f1_1_predicted_pc_valid
      : _banked_predictors_1_io_resp_f1_1_predicted_pc_valid;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :328:39, :333:39, :362:27
  assign io_resp_f1_preds_5_predicted_pc_bits =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_0_io_resp_f1_1_predicted_pc_bits
      : _banked_predictors_1_io_resp_f1_1_predicted_pc_bits;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :328:39, :333:39, :362:27
  assign io_resp_f1_preds_6_taken =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_0_io_resp_f1_2_taken
      : _banked_predictors_1_io_resp_f1_2_taken;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :328:39, :333:39, :362:27
  assign io_resp_f1_preds_6_is_br =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_0_io_resp_f1_2_is_br
      : _banked_predictors_1_io_resp_f1_2_is_br;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :328:39, :333:39, :362:27
  assign io_resp_f1_preds_6_is_jal =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_0_io_resp_f1_2_is_jal
      : _banked_predictors_1_io_resp_f1_2_is_jal;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :328:39, :333:39, :362:27
  assign io_resp_f1_preds_6_predicted_pc_valid =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_0_io_resp_f1_2_predicted_pc_valid
      : _banked_predictors_1_io_resp_f1_2_predicted_pc_valid;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :328:39, :333:39, :362:27
  assign io_resp_f1_preds_6_predicted_pc_bits =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_0_io_resp_f1_2_predicted_pc_bits
      : _banked_predictors_1_io_resp_f1_2_predicted_pc_bits;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :328:39, :333:39, :362:27
  assign io_resp_f1_preds_7_taken =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_0_io_resp_f1_3_taken
      : _banked_predictors_1_io_resp_f1_3_taken;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :328:39, :333:39, :362:27
  assign io_resp_f1_preds_7_is_br =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_0_io_resp_f1_3_is_br
      : _banked_predictors_1_io_resp_f1_3_is_br;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :328:39, :333:39, :362:27
  assign io_resp_f1_preds_7_is_jal =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_0_io_resp_f1_3_is_jal
      : _banked_predictors_1_io_resp_f1_3_is_jal;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :328:39, :333:39, :362:27
  assign io_resp_f1_preds_7_predicted_pc_valid =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_0_io_resp_f1_3_predicted_pc_valid
      : _banked_predictors_1_io_resp_f1_3_predicted_pc_valid;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :328:39, :333:39, :362:27
  assign io_resp_f1_preds_7_predicted_pc_bits =
    io_resp_f1_pc_REG[3]
      ? _banked_predictors_0_io_resp_f1_3_predicted_pc_bits
      : _banked_predictors_1_io_resp_f1_3_predicted_pc_bits;	// frontend.scala:151:47, predictor.scala:218:19, :325:40, :328:39, :333:39, :362:27
  assign io_resp_f2_preds_0_taken =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_1_io_resp_f2_0_taken
      : _banked_predictors_0_io_resp_f2_0_taken;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :339:39, :344:39, :363:27
  assign io_resp_f2_preds_0_is_br =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_1_io_resp_f2_0_is_br
      : _banked_predictors_0_io_resp_f2_0_is_br;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :339:39, :344:39, :363:27
  assign io_resp_f2_preds_0_is_jal =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_1_io_resp_f2_0_is_jal
      : _banked_predictors_0_io_resp_f2_0_is_jal;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :339:39, :344:39, :363:27
  assign io_resp_f2_preds_0_predicted_pc_valid =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_1_io_resp_f2_0_predicted_pc_valid
      : _banked_predictors_0_io_resp_f2_0_predicted_pc_valid;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :339:39, :344:39, :363:27
  assign io_resp_f2_preds_0_predicted_pc_bits =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_1_io_resp_f2_0_predicted_pc_bits
      : _banked_predictors_0_io_resp_f2_0_predicted_pc_bits;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :339:39, :344:39, :363:27
  assign io_resp_f2_preds_1_taken =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_1_io_resp_f2_1_taken
      : _banked_predictors_0_io_resp_f2_1_taken;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :339:39, :344:39, :363:27
  assign io_resp_f2_preds_1_is_br =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_1_io_resp_f2_1_is_br
      : _banked_predictors_0_io_resp_f2_1_is_br;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :339:39, :344:39, :363:27
  assign io_resp_f2_preds_1_is_jal =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_1_io_resp_f2_1_is_jal
      : _banked_predictors_0_io_resp_f2_1_is_jal;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :339:39, :344:39, :363:27
  assign io_resp_f2_preds_1_predicted_pc_valid =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_1_io_resp_f2_1_predicted_pc_valid
      : _banked_predictors_0_io_resp_f2_1_predicted_pc_valid;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :339:39, :344:39, :363:27
  assign io_resp_f2_preds_1_predicted_pc_bits =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_1_io_resp_f2_1_predicted_pc_bits
      : _banked_predictors_0_io_resp_f2_1_predicted_pc_bits;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :339:39, :344:39, :363:27
  assign io_resp_f2_preds_2_taken =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_1_io_resp_f2_2_taken
      : _banked_predictors_0_io_resp_f2_2_taken;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :339:39, :344:39, :363:27
  assign io_resp_f2_preds_2_is_br =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_1_io_resp_f2_2_is_br
      : _banked_predictors_0_io_resp_f2_2_is_br;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :339:39, :344:39, :363:27
  assign io_resp_f2_preds_2_is_jal =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_1_io_resp_f2_2_is_jal
      : _banked_predictors_0_io_resp_f2_2_is_jal;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :339:39, :344:39, :363:27
  assign io_resp_f2_preds_2_predicted_pc_valid =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_1_io_resp_f2_2_predicted_pc_valid
      : _banked_predictors_0_io_resp_f2_2_predicted_pc_valid;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :339:39, :344:39, :363:27
  assign io_resp_f2_preds_2_predicted_pc_bits =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_1_io_resp_f2_2_predicted_pc_bits
      : _banked_predictors_0_io_resp_f2_2_predicted_pc_bits;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :339:39, :344:39, :363:27
  assign io_resp_f2_preds_3_taken =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_1_io_resp_f2_3_taken
      : _banked_predictors_0_io_resp_f2_3_taken;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :339:39, :344:39, :363:27
  assign io_resp_f2_preds_3_is_br =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_1_io_resp_f2_3_is_br
      : _banked_predictors_0_io_resp_f2_3_is_br;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :339:39, :344:39, :363:27
  assign io_resp_f2_preds_3_is_jal =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_1_io_resp_f2_3_is_jal
      : _banked_predictors_0_io_resp_f2_3_is_jal;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :339:39, :344:39, :363:27
  assign io_resp_f2_preds_3_predicted_pc_valid =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_1_io_resp_f2_3_predicted_pc_valid
      : _banked_predictors_0_io_resp_f2_3_predicted_pc_valid;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :339:39, :344:39, :363:27
  assign io_resp_f2_preds_3_predicted_pc_bits =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_1_io_resp_f2_3_predicted_pc_bits
      : _banked_predictors_0_io_resp_f2_3_predicted_pc_bits;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :339:39, :344:39, :363:27
  assign io_resp_f2_preds_4_taken =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_0_io_resp_f2_0_taken
      : _banked_predictors_1_io_resp_f2_0_taken;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :340:39, :345:39, :363:27
  assign io_resp_f2_preds_4_is_br =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_0_io_resp_f2_0_is_br
      : _banked_predictors_1_io_resp_f2_0_is_br;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :340:39, :345:39, :363:27
  assign io_resp_f2_preds_4_is_jal =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_0_io_resp_f2_0_is_jal
      : _banked_predictors_1_io_resp_f2_0_is_jal;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :340:39, :345:39, :363:27
  assign io_resp_f2_preds_4_predicted_pc_valid =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_0_io_resp_f2_0_predicted_pc_valid
      : _banked_predictors_1_io_resp_f2_0_predicted_pc_valid;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :340:39, :345:39, :363:27
  assign io_resp_f2_preds_4_predicted_pc_bits =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_0_io_resp_f2_0_predicted_pc_bits
      : _banked_predictors_1_io_resp_f2_0_predicted_pc_bits;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :340:39, :345:39, :363:27
  assign io_resp_f2_preds_5_taken =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_0_io_resp_f2_1_taken
      : _banked_predictors_1_io_resp_f2_1_taken;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :340:39, :345:39, :363:27
  assign io_resp_f2_preds_5_is_br =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_0_io_resp_f2_1_is_br
      : _banked_predictors_1_io_resp_f2_1_is_br;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :340:39, :345:39, :363:27
  assign io_resp_f2_preds_5_is_jal =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_0_io_resp_f2_1_is_jal
      : _banked_predictors_1_io_resp_f2_1_is_jal;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :340:39, :345:39, :363:27
  assign io_resp_f2_preds_5_predicted_pc_valid =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_0_io_resp_f2_1_predicted_pc_valid
      : _banked_predictors_1_io_resp_f2_1_predicted_pc_valid;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :340:39, :345:39, :363:27
  assign io_resp_f2_preds_5_predicted_pc_bits =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_0_io_resp_f2_1_predicted_pc_bits
      : _banked_predictors_1_io_resp_f2_1_predicted_pc_bits;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :340:39, :345:39, :363:27
  assign io_resp_f2_preds_6_taken =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_0_io_resp_f2_2_taken
      : _banked_predictors_1_io_resp_f2_2_taken;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :340:39, :345:39, :363:27
  assign io_resp_f2_preds_6_is_br =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_0_io_resp_f2_2_is_br
      : _banked_predictors_1_io_resp_f2_2_is_br;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :340:39, :345:39, :363:27
  assign io_resp_f2_preds_6_is_jal =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_0_io_resp_f2_2_is_jal
      : _banked_predictors_1_io_resp_f2_2_is_jal;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :340:39, :345:39, :363:27
  assign io_resp_f2_preds_6_predicted_pc_valid =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_0_io_resp_f2_2_predicted_pc_valid
      : _banked_predictors_1_io_resp_f2_2_predicted_pc_valid;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :340:39, :345:39, :363:27
  assign io_resp_f2_preds_6_predicted_pc_bits =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_0_io_resp_f2_2_predicted_pc_bits
      : _banked_predictors_1_io_resp_f2_2_predicted_pc_bits;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :340:39, :345:39, :363:27
  assign io_resp_f2_preds_7_taken =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_0_io_resp_f2_3_taken
      : _banked_predictors_1_io_resp_f2_3_taken;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :340:39, :345:39, :363:27
  assign io_resp_f2_preds_7_is_br =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_0_io_resp_f2_3_is_br
      : _banked_predictors_1_io_resp_f2_3_is_br;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :340:39, :345:39, :363:27
  assign io_resp_f2_preds_7_is_jal =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_0_io_resp_f2_3_is_jal
      : _banked_predictors_1_io_resp_f2_3_is_jal;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :340:39, :345:39, :363:27
  assign io_resp_f2_preds_7_predicted_pc_valid =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_0_io_resp_f2_3_predicted_pc_valid
      : _banked_predictors_1_io_resp_f2_3_predicted_pc_valid;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :340:39, :345:39, :363:27
  assign io_resp_f2_preds_7_predicted_pc_bits =
    io_resp_f2_pc_REG[3]
      ? _banked_predictors_0_io_resp_f2_3_predicted_pc_bits
      : _banked_predictors_1_io_resp_f2_3_predicted_pc_bits;	// frontend.scala:151:47, predictor.scala:218:19, :337:40, :340:39, :345:39, :363:27
  assign io_resp_f3_pc = io_resp_f3_pc_REG;	// predictor.scala:364:27
  assign io_resp_f3_preds_0_taken =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_1_io_resp_f3_0_taken
      : _banked_predictors_0_io_resp_f3_0_taken;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :351:39, :356:39, :364:27
  assign io_resp_f3_preds_0_is_br =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_1_io_resp_f3_0_is_br
      : _banked_predictors_0_io_resp_f3_0_is_br;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :351:39, :356:39, :364:27
  assign io_resp_f3_preds_0_is_jal =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_1_io_resp_f3_0_is_jal
      : _banked_predictors_0_io_resp_f3_0_is_jal;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :351:39, :356:39, :364:27
  assign io_resp_f3_preds_0_predicted_pc_valid =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_1_io_resp_f3_0_predicted_pc_valid
      : _banked_predictors_0_io_resp_f3_0_predicted_pc_valid;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :351:39, :356:39, :364:27
  assign io_resp_f3_preds_0_predicted_pc_bits =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_1_io_resp_f3_0_predicted_pc_bits
      : _banked_predictors_0_io_resp_f3_0_predicted_pc_bits;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :351:39, :356:39, :364:27
  assign io_resp_f3_preds_1_taken =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_1_io_resp_f3_1_taken
      : _banked_predictors_0_io_resp_f3_1_taken;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :351:39, :356:39, :364:27
  assign io_resp_f3_preds_1_is_br =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_1_io_resp_f3_1_is_br
      : _banked_predictors_0_io_resp_f3_1_is_br;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :351:39, :356:39, :364:27
  assign io_resp_f3_preds_1_is_jal =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_1_io_resp_f3_1_is_jal
      : _banked_predictors_0_io_resp_f3_1_is_jal;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :351:39, :356:39, :364:27
  assign io_resp_f3_preds_1_predicted_pc_valid =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_1_io_resp_f3_1_predicted_pc_valid
      : _banked_predictors_0_io_resp_f3_1_predicted_pc_valid;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :351:39, :356:39, :364:27
  assign io_resp_f3_preds_1_predicted_pc_bits =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_1_io_resp_f3_1_predicted_pc_bits
      : _banked_predictors_0_io_resp_f3_1_predicted_pc_bits;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :351:39, :356:39, :364:27
  assign io_resp_f3_preds_2_taken =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_1_io_resp_f3_2_taken
      : _banked_predictors_0_io_resp_f3_2_taken;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :351:39, :356:39, :364:27
  assign io_resp_f3_preds_2_is_br =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_1_io_resp_f3_2_is_br
      : _banked_predictors_0_io_resp_f3_2_is_br;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :351:39, :356:39, :364:27
  assign io_resp_f3_preds_2_is_jal =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_1_io_resp_f3_2_is_jal
      : _banked_predictors_0_io_resp_f3_2_is_jal;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :351:39, :356:39, :364:27
  assign io_resp_f3_preds_2_predicted_pc_valid =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_1_io_resp_f3_2_predicted_pc_valid
      : _banked_predictors_0_io_resp_f3_2_predicted_pc_valid;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :351:39, :356:39, :364:27
  assign io_resp_f3_preds_2_predicted_pc_bits =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_1_io_resp_f3_2_predicted_pc_bits
      : _banked_predictors_0_io_resp_f3_2_predicted_pc_bits;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :351:39, :356:39, :364:27
  assign io_resp_f3_preds_3_taken =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_1_io_resp_f3_3_taken
      : _banked_predictors_0_io_resp_f3_3_taken;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :351:39, :356:39, :364:27
  assign io_resp_f3_preds_3_is_br =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_1_io_resp_f3_3_is_br
      : _banked_predictors_0_io_resp_f3_3_is_br;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :351:39, :356:39, :364:27
  assign io_resp_f3_preds_3_is_jal =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_1_io_resp_f3_3_is_jal
      : _banked_predictors_0_io_resp_f3_3_is_jal;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :351:39, :356:39, :364:27
  assign io_resp_f3_preds_3_predicted_pc_valid =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_1_io_resp_f3_3_predicted_pc_valid
      : _banked_predictors_0_io_resp_f3_3_predicted_pc_valid;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :351:39, :356:39, :364:27
  assign io_resp_f3_preds_3_predicted_pc_bits =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_1_io_resp_f3_3_predicted_pc_bits
      : _banked_predictors_0_io_resp_f3_3_predicted_pc_bits;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :351:39, :356:39, :364:27
  assign io_resp_f3_preds_4_taken =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_0_io_resp_f3_0_taken
      : _banked_predictors_1_io_resp_f3_0_taken;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :352:39, :357:39, :364:27
  assign io_resp_f3_preds_4_is_br =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_0_io_resp_f3_0_is_br
      : _banked_predictors_1_io_resp_f3_0_is_br;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :352:39, :357:39, :364:27
  assign io_resp_f3_preds_4_is_jal =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_0_io_resp_f3_0_is_jal
      : _banked_predictors_1_io_resp_f3_0_is_jal;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :352:39, :357:39, :364:27
  assign io_resp_f3_preds_4_predicted_pc_valid =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_0_io_resp_f3_0_predicted_pc_valid
      : _banked_predictors_1_io_resp_f3_0_predicted_pc_valid;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :352:39, :357:39, :364:27
  assign io_resp_f3_preds_4_predicted_pc_bits =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_0_io_resp_f3_0_predicted_pc_bits
      : _banked_predictors_1_io_resp_f3_0_predicted_pc_bits;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :352:39, :357:39, :364:27
  assign io_resp_f3_preds_5_taken =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_0_io_resp_f3_1_taken
      : _banked_predictors_1_io_resp_f3_1_taken;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :352:39, :357:39, :364:27
  assign io_resp_f3_preds_5_is_br =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_0_io_resp_f3_1_is_br
      : _banked_predictors_1_io_resp_f3_1_is_br;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :352:39, :357:39, :364:27
  assign io_resp_f3_preds_5_is_jal =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_0_io_resp_f3_1_is_jal
      : _banked_predictors_1_io_resp_f3_1_is_jal;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :352:39, :357:39, :364:27
  assign io_resp_f3_preds_5_predicted_pc_valid =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_0_io_resp_f3_1_predicted_pc_valid
      : _banked_predictors_1_io_resp_f3_1_predicted_pc_valid;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :352:39, :357:39, :364:27
  assign io_resp_f3_preds_5_predicted_pc_bits =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_0_io_resp_f3_1_predicted_pc_bits
      : _banked_predictors_1_io_resp_f3_1_predicted_pc_bits;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :352:39, :357:39, :364:27
  assign io_resp_f3_preds_6_taken =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_0_io_resp_f3_2_taken
      : _banked_predictors_1_io_resp_f3_2_taken;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :352:39, :357:39, :364:27
  assign io_resp_f3_preds_6_is_br =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_0_io_resp_f3_2_is_br
      : _banked_predictors_1_io_resp_f3_2_is_br;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :352:39, :357:39, :364:27
  assign io_resp_f3_preds_6_is_jal =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_0_io_resp_f3_2_is_jal
      : _banked_predictors_1_io_resp_f3_2_is_jal;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :352:39, :357:39, :364:27
  assign io_resp_f3_preds_6_predicted_pc_valid =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_0_io_resp_f3_2_predicted_pc_valid
      : _banked_predictors_1_io_resp_f3_2_predicted_pc_valid;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :352:39, :357:39, :364:27
  assign io_resp_f3_preds_6_predicted_pc_bits =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_0_io_resp_f3_2_predicted_pc_bits
      : _banked_predictors_1_io_resp_f3_2_predicted_pc_bits;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :352:39, :357:39, :364:27
  assign io_resp_f3_preds_7_taken =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_0_io_resp_f3_3_taken
      : _banked_predictors_1_io_resp_f3_3_taken;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :352:39, :357:39, :364:27
  assign io_resp_f3_preds_7_is_br =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_0_io_resp_f3_3_is_br
      : _banked_predictors_1_io_resp_f3_3_is_br;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :352:39, :357:39, :364:27
  assign io_resp_f3_preds_7_is_jal =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_0_io_resp_f3_3_is_jal
      : _banked_predictors_1_io_resp_f3_3_is_jal;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :352:39, :357:39, :364:27
  assign io_resp_f3_preds_7_predicted_pc_valid =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_0_io_resp_f3_3_predicted_pc_valid
      : _banked_predictors_1_io_resp_f3_3_predicted_pc_valid;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :352:39, :357:39, :364:27
  assign io_resp_f3_preds_7_predicted_pc_bits =
    io_resp_f3_pc_REG[3]
      ? _banked_predictors_0_io_resp_f3_3_predicted_pc_bits
      : _banked_predictors_1_io_resp_f3_3_predicted_pc_bits;	// frontend.scala:151:47, predictor.scala:218:19, :349:40, :352:39, :357:39, :364:27
endmodule

