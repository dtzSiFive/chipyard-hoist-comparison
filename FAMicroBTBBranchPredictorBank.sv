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

module FAMicroBTBBranchPredictorBank(
  input          clock,
                 reset,
                 io_f0_valid,
  input  [39:0]  io_f0_pc,
  input          io_update_valid,
                 io_update_bits_is_mispredict_update,
                 io_update_bits_is_repair_update,
  input  [3:0]   io_update_bits_btb_mispredicts,
  input  [39:0]  io_update_bits_pc,
  input  [3:0]   io_update_bits_br_mask,
  input          io_update_bits_cfi_idx_valid,
  input  [1:0]   io_update_bits_cfi_idx_bits,
  input          io_update_bits_cfi_taken,
                 io_update_bits_cfi_is_jal,
  input  [39:0]  io_update_bits_target,
  input  [119:0] io_update_bits_meta,
  output         io_resp_f1_0_taken,
                 io_resp_f1_0_is_br,
                 io_resp_f1_0_is_jal,
                 io_resp_f1_0_predicted_pc_valid,
  output [39:0]  io_resp_f1_0_predicted_pc_bits,
  output         io_resp_f1_1_taken,
                 io_resp_f1_1_is_br,
                 io_resp_f1_1_is_jal,
                 io_resp_f1_1_predicted_pc_valid,
  output [39:0]  io_resp_f1_1_predicted_pc_bits,
  output         io_resp_f1_2_taken,
                 io_resp_f1_2_is_br,
                 io_resp_f1_2_is_jal,
                 io_resp_f1_2_predicted_pc_valid,
  output [39:0]  io_resp_f1_2_predicted_pc_bits,
  output         io_resp_f1_3_taken,
                 io_resp_f1_3_is_br,
                 io_resp_f1_3_is_jal,
                 io_resp_f1_3_predicted_pc_valid,
  output [39:0]  io_resp_f1_3_predicted_pc_bits,
  output         io_resp_f2_0_is_br,
                 io_resp_f2_0_is_jal,
                 io_resp_f2_0_predicted_pc_valid,
  output [39:0]  io_resp_f2_0_predicted_pc_bits,
  output         io_resp_f2_1_is_br,
                 io_resp_f2_1_is_jal,
                 io_resp_f2_1_predicted_pc_valid,
  output [39:0]  io_resp_f2_1_predicted_pc_bits,
  output         io_resp_f2_2_is_br,
                 io_resp_f2_2_is_jal,
                 io_resp_f2_2_predicted_pc_valid,
  output [39:0]  io_resp_f2_2_predicted_pc_bits,
  output         io_resp_f2_3_is_br,
                 io_resp_f2_3_is_jal,
                 io_resp_f2_3_predicted_pc_valid,
  output [39:0]  io_resp_f2_3_predicted_pc_bits,
  output         io_resp_f3_0_is_br,
                 io_resp_f3_0_is_jal,
                 io_resp_f3_0_predicted_pc_valid,
  output [39:0]  io_resp_f3_0_predicted_pc_bits,
  output         io_resp_f3_1_is_br,
                 io_resp_f3_1_is_jal,
                 io_resp_f3_1_predicted_pc_valid,
  output [39:0]  io_resp_f3_1_predicted_pc_bits,
  output         io_resp_f3_2_is_br,
                 io_resp_f3_2_is_jal,
                 io_resp_f3_2_predicted_pc_valid,
  output [39:0]  io_resp_f3_2_predicted_pc_bits,
  output         io_resp_f3_3_is_br,
                 io_resp_f3_3_is_jal,
                 io_resp_f3_3_predicted_pc_valid,
  output [39:0]  io_resp_f3_3_predicted_pc_bits,
  output [119:0] io_f3_meta
);

  reg  [35:0]       s1_idx;	// predictor.scala:163:29
  reg               s1_valid;	// predictor.scala:168:25
  reg  [39:0]       s1_pc;	// predictor.scala:178:22
  reg               s1_update_valid;	// predictor.scala:184:30
  reg               s1_update_bits_is_mispredict_update;	// predictor.scala:184:30
  reg               s1_update_bits_is_repair_update;	// predictor.scala:184:30
  reg  [3:0]        s1_update_bits_btb_mispredicts;	// predictor.scala:184:30
  reg  [39:0]       s1_update_bits_pc;	// predictor.scala:184:30
  reg  [3:0]        s1_update_bits_br_mask;	// predictor.scala:184:30
  reg               s1_update_bits_cfi_idx_valid;	// predictor.scala:184:30
  reg  [1:0]        s1_update_bits_cfi_idx_bits;	// predictor.scala:184:30
  reg               s1_update_bits_cfi_taken;	// predictor.scala:184:30
  reg               s1_update_bits_cfi_is_jal;	// predictor.scala:184:30
  reg  [39:0]       s1_update_bits_target;	// predictor.scala:184:30
  reg  [119:0]      s1_update_bits_meta;	// predictor.scala:184:30
  reg  [35:0]       s1_update_idx;	// predictor.scala:185:30
  reg               meta_0_0_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_0_0_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_0_0_ctr;	// faubtb.scala:57:25
  reg               meta_0_1_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_0_1_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_0_1_ctr;	// faubtb.scala:57:25
  reg               meta_0_2_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_0_2_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_0_2_ctr;	// faubtb.scala:57:25
  reg               meta_0_3_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_0_3_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_0_3_ctr;	// faubtb.scala:57:25
  reg               meta_1_0_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_1_0_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_1_0_ctr;	// faubtb.scala:57:25
  reg               meta_1_1_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_1_1_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_1_1_ctr;	// faubtb.scala:57:25
  reg               meta_1_2_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_1_2_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_1_2_ctr;	// faubtb.scala:57:25
  reg               meta_1_3_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_1_3_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_1_3_ctr;	// faubtb.scala:57:25
  reg               meta_2_0_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_2_0_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_2_0_ctr;	// faubtb.scala:57:25
  reg               meta_2_1_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_2_1_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_2_1_ctr;	// faubtb.scala:57:25
  reg               meta_2_2_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_2_2_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_2_2_ctr;	// faubtb.scala:57:25
  reg               meta_2_3_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_2_3_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_2_3_ctr;	// faubtb.scala:57:25
  reg               meta_3_0_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_3_0_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_3_0_ctr;	// faubtb.scala:57:25
  reg               meta_3_1_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_3_1_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_3_1_ctr;	// faubtb.scala:57:25
  reg               meta_3_2_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_3_2_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_3_2_ctr;	// faubtb.scala:57:25
  reg               meta_3_3_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_3_3_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_3_3_ctr;	// faubtb.scala:57:25
  reg               meta_4_0_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_4_0_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_4_0_ctr;	// faubtb.scala:57:25
  reg               meta_4_1_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_4_1_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_4_1_ctr;	// faubtb.scala:57:25
  reg               meta_4_2_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_4_2_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_4_2_ctr;	// faubtb.scala:57:25
  reg               meta_4_3_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_4_3_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_4_3_ctr;	// faubtb.scala:57:25
  reg               meta_5_0_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_5_0_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_5_0_ctr;	// faubtb.scala:57:25
  reg               meta_5_1_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_5_1_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_5_1_ctr;	// faubtb.scala:57:25
  reg               meta_5_2_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_5_2_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_5_2_ctr;	// faubtb.scala:57:25
  reg               meta_5_3_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_5_3_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_5_3_ctr;	// faubtb.scala:57:25
  reg               meta_6_0_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_6_0_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_6_0_ctr;	// faubtb.scala:57:25
  reg               meta_6_1_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_6_1_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_6_1_ctr;	// faubtb.scala:57:25
  reg               meta_6_2_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_6_2_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_6_2_ctr;	// faubtb.scala:57:25
  reg               meta_6_3_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_6_3_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_6_3_ctr;	// faubtb.scala:57:25
  reg               meta_7_0_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_7_0_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_7_0_ctr;	// faubtb.scala:57:25
  reg               meta_7_1_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_7_1_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_7_1_ctr;	// faubtb.scala:57:25
  reg               meta_7_2_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_7_2_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_7_2_ctr;	// faubtb.scala:57:25
  reg               meta_7_3_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_7_3_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_7_3_ctr;	// faubtb.scala:57:25
  reg               meta_8_0_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_8_0_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_8_0_ctr;	// faubtb.scala:57:25
  reg               meta_8_1_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_8_1_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_8_1_ctr;	// faubtb.scala:57:25
  reg               meta_8_2_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_8_2_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_8_2_ctr;	// faubtb.scala:57:25
  reg               meta_8_3_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_8_3_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_8_3_ctr;	// faubtb.scala:57:25
  reg               meta_9_0_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_9_0_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_9_0_ctr;	// faubtb.scala:57:25
  reg               meta_9_1_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_9_1_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_9_1_ctr;	// faubtb.scala:57:25
  reg               meta_9_2_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_9_2_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_9_2_ctr;	// faubtb.scala:57:25
  reg               meta_9_3_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_9_3_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_9_3_ctr;	// faubtb.scala:57:25
  reg               meta_10_0_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_10_0_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_10_0_ctr;	// faubtb.scala:57:25
  reg               meta_10_1_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_10_1_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_10_1_ctr;	// faubtb.scala:57:25
  reg               meta_10_2_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_10_2_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_10_2_ctr;	// faubtb.scala:57:25
  reg               meta_10_3_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_10_3_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_10_3_ctr;	// faubtb.scala:57:25
  reg               meta_11_0_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_11_0_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_11_0_ctr;	// faubtb.scala:57:25
  reg               meta_11_1_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_11_1_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_11_1_ctr;	// faubtb.scala:57:25
  reg               meta_11_2_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_11_2_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_11_2_ctr;	// faubtb.scala:57:25
  reg               meta_11_3_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_11_3_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_11_3_ctr;	// faubtb.scala:57:25
  reg               meta_12_0_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_12_0_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_12_0_ctr;	// faubtb.scala:57:25
  reg               meta_12_1_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_12_1_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_12_1_ctr;	// faubtb.scala:57:25
  reg               meta_12_2_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_12_2_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_12_2_ctr;	// faubtb.scala:57:25
  reg               meta_12_3_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_12_3_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_12_3_ctr;	// faubtb.scala:57:25
  reg               meta_13_0_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_13_0_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_13_0_ctr;	// faubtb.scala:57:25
  reg               meta_13_1_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_13_1_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_13_1_ctr;	// faubtb.scala:57:25
  reg               meta_13_2_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_13_2_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_13_2_ctr;	// faubtb.scala:57:25
  reg               meta_13_3_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_13_3_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_13_3_ctr;	// faubtb.scala:57:25
  reg               meta_14_0_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_14_0_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_14_0_ctr;	// faubtb.scala:57:25
  reg               meta_14_1_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_14_1_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_14_1_ctr;	// faubtb.scala:57:25
  reg               meta_14_2_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_14_2_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_14_2_ctr;	// faubtb.scala:57:25
  reg               meta_14_3_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_14_3_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_14_3_ctr;	// faubtb.scala:57:25
  reg               meta_15_0_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_15_0_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_15_0_ctr;	// faubtb.scala:57:25
  reg               meta_15_1_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_15_1_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_15_1_ctr;	// faubtb.scala:57:25
  reg               meta_15_2_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_15_2_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_15_2_ctr;	// faubtb.scala:57:25
  reg               meta_15_3_is_br;	// faubtb.scala:57:25
  reg  [35:0]       meta_15_3_tag;	// faubtb.scala:57:25
  reg  [1:0]        meta_15_3_ctr;	// faubtb.scala:57:25
  reg  [12:0]       btb_0_0_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_0_1_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_0_2_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_0_3_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_1_0_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_1_1_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_1_2_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_1_3_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_2_0_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_2_1_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_2_2_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_2_3_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_3_0_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_3_1_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_3_2_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_3_3_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_4_0_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_4_1_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_4_2_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_4_3_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_5_0_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_5_1_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_5_2_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_5_3_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_6_0_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_6_1_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_6_2_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_6_3_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_7_0_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_7_1_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_7_2_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_7_3_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_8_0_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_8_1_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_8_2_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_8_3_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_9_0_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_9_1_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_9_2_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_9_3_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_10_0_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_10_1_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_10_2_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_10_3_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_11_0_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_11_1_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_11_2_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_11_3_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_12_0_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_12_1_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_12_2_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_12_3_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_13_0_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_13_1_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_13_2_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_13_3_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_14_0_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_14_1_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_14_2_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_14_3_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_15_0_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_15_1_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_15_2_offset;	// faubtb.scala:58:21
  reg  [12:0]       btb_15_3_offset;	// faubtb.scala:58:21
  wire              s1_hit_ohs_0_0 = meta_0_0_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_0_1 = meta_1_0_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_0_2 = meta_2_0_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_0_3 = meta_3_0_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_0_4 = meta_4_0_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_0_5 = meta_5_0_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_0_6 = meta_6_0_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_0_7 = meta_7_0_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_0_8 = meta_8_0_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_0_9 = meta_9_0_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_0_10 = meta_10_0_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_0_11 = meta_11_0_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_0_12 = meta_12_0_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_0_13 = meta_13_0_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_0_14 = meta_14_0_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_1_0 = meta_0_1_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_1_1 = meta_1_1_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_1_2 = meta_2_1_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_1_3 = meta_3_1_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_1_4 = meta_4_1_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_1_5 = meta_5_1_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_1_6 = meta_6_1_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_1_7 = meta_7_1_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_1_8 = meta_8_1_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_1_9 = meta_9_1_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_1_10 = meta_10_1_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_1_11 = meta_11_1_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_1_12 = meta_12_1_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_1_13 = meta_13_1_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_1_14 = meta_14_1_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_2_0 = meta_0_2_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_2_1 = meta_1_2_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_2_2 = meta_2_2_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_2_3 = meta_3_2_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_2_4 = meta_4_2_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_2_5 = meta_5_2_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_2_6 = meta_6_2_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_2_7 = meta_7_2_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_2_8 = meta_8_2_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_2_9 = meta_9_2_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_2_10 = meta_10_2_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_2_11 = meta_11_2_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_2_12 = meta_12_2_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_2_13 = meta_13_2_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_2_14 = meta_14_2_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_3_0 = meta_0_3_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_3_1 = meta_1_3_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_3_2 = meta_2_3_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_3_3 = meta_3_3_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_3_4 = meta_4_3_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_3_5 = meta_5_3_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_3_6 = meta_6_3_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_3_7 = meta_7_3_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_3_8 = meta_8_3_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_3_9 = meta_9_3_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_3_10 = meta_10_3_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_3_11 = meta_11_3_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_3_12 = meta_12_3_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_3_13 = meta_13_3_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_hit_ohs_3_14 = meta_14_3_tag == s1_idx;	// faubtb.scala:57:25, :72:22, predictor.scala:163:29
  wire              s1_meta_hits_0 =
    s1_hit_ohs_0_0 | s1_hit_ohs_0_1 | s1_hit_ohs_0_2 | s1_hit_ohs_0_3 | s1_hit_ohs_0_4
    | s1_hit_ohs_0_5 | s1_hit_ohs_0_6 | s1_hit_ohs_0_7 | s1_hit_ohs_0_8 | s1_hit_ohs_0_9
    | s1_hit_ohs_0_10 | s1_hit_ohs_0_11 | s1_hit_ohs_0_12 | s1_hit_ohs_0_13
    | s1_hit_ohs_0_14 | meta_15_0_tag == s1_idx;	// faubtb.scala:57:25, :72:22, :75:55, predictor.scala:163:29
  wire              s1_meta_hits_1 =
    s1_hit_ohs_1_0 | s1_hit_ohs_1_1 | s1_hit_ohs_1_2 | s1_hit_ohs_1_3 | s1_hit_ohs_1_4
    | s1_hit_ohs_1_5 | s1_hit_ohs_1_6 | s1_hit_ohs_1_7 | s1_hit_ohs_1_8 | s1_hit_ohs_1_9
    | s1_hit_ohs_1_10 | s1_hit_ohs_1_11 | s1_hit_ohs_1_12 | s1_hit_ohs_1_13
    | s1_hit_ohs_1_14 | meta_15_1_tag == s1_idx;	// faubtb.scala:57:25, :72:22, :75:55, predictor.scala:163:29
  wire              s1_meta_hits_2 =
    s1_hit_ohs_2_0 | s1_hit_ohs_2_1 | s1_hit_ohs_2_2 | s1_hit_ohs_2_3 | s1_hit_ohs_2_4
    | s1_hit_ohs_2_5 | s1_hit_ohs_2_6 | s1_hit_ohs_2_7 | s1_hit_ohs_2_8 | s1_hit_ohs_2_9
    | s1_hit_ohs_2_10 | s1_hit_ohs_2_11 | s1_hit_ohs_2_12 | s1_hit_ohs_2_13
    | s1_hit_ohs_2_14 | meta_15_2_tag == s1_idx;	// faubtb.scala:57:25, :72:22, :75:55, predictor.scala:163:29
  wire              s1_meta_hits_3 =
    s1_hit_ohs_3_0 | s1_hit_ohs_3_1 | s1_hit_ohs_3_2 | s1_hit_ohs_3_3 | s1_hit_ohs_3_4
    | s1_hit_ohs_3_5 | s1_hit_ohs_3_6 | s1_hit_ohs_3_7 | s1_hit_ohs_3_8 | s1_hit_ohs_3_9
    | s1_hit_ohs_3_10 | s1_hit_ohs_3_11 | s1_hit_ohs_3_12 | s1_hit_ohs_3_13
    | s1_hit_ohs_3_14 | meta_15_3_tag == s1_idx;	// faubtb.scala:57:25, :72:22, :75:55, predictor.scala:163:29
  wire [3:0]        s1_hit_ways_0 =
    s1_hit_ohs_0_0
      ? 4'h0
      : s1_hit_ohs_0_1
          ? 4'h1
          : s1_hit_ohs_0_2
              ? 4'h2
              : s1_hit_ohs_0_3
                  ? 4'h3
                  : s1_hit_ohs_0_4
                      ? 4'h4
                      : s1_hit_ohs_0_5
                          ? 4'h5
                          : s1_hit_ohs_0_6
                              ? 4'h6
                              : s1_hit_ohs_0_7
                                  ? 4'h7
                                  : s1_hit_ohs_0_8
                                      ? 4'h8
                                      : s1_hit_ohs_0_9
                                          ? 4'h9
                                          : s1_hit_ohs_0_10
                                              ? 4'hA
                                              : s1_hit_ohs_0_11
                                                  ? 4'hB
                                                  : s1_hit_ohs_0_12
                                                      ? 4'hC
                                                      : s1_hit_ohs_0_13
                                                          ? 4'hD
                                                          : {3'h7, ~s1_hit_ohs_0_14};	// Bitwise.scala:72:12, Mux.scala:47:69, faubtb.scala:72:22, :81:39, :131:56
  wire [3:0]        s1_hit_ways_1 =
    s1_hit_ohs_1_0
      ? 4'h0
      : s1_hit_ohs_1_1
          ? 4'h1
          : s1_hit_ohs_1_2
              ? 4'h2
              : s1_hit_ohs_1_3
                  ? 4'h3
                  : s1_hit_ohs_1_4
                      ? 4'h4
                      : s1_hit_ohs_1_5
                          ? 4'h5
                          : s1_hit_ohs_1_6
                              ? 4'h6
                              : s1_hit_ohs_1_7
                                  ? 4'h7
                                  : s1_hit_ohs_1_8
                                      ? 4'h8
                                      : s1_hit_ohs_1_9
                                          ? 4'h9
                                          : s1_hit_ohs_1_10
                                              ? 4'hA
                                              : s1_hit_ohs_1_11
                                                  ? 4'hB
                                                  : s1_hit_ohs_1_12
                                                      ? 4'hC
                                                      : s1_hit_ohs_1_13
                                                          ? 4'hD
                                                          : {3'h7, ~s1_hit_ohs_1_14};	// Bitwise.scala:72:12, Mux.scala:47:69, faubtb.scala:72:22, :81:39, :131:56
  wire [3:0]        s1_hit_ways_2 =
    s1_hit_ohs_2_0
      ? 4'h0
      : s1_hit_ohs_2_1
          ? 4'h1
          : s1_hit_ohs_2_2
              ? 4'h2
              : s1_hit_ohs_2_3
                  ? 4'h3
                  : s1_hit_ohs_2_4
                      ? 4'h4
                      : s1_hit_ohs_2_5
                          ? 4'h5
                          : s1_hit_ohs_2_6
                              ? 4'h6
                              : s1_hit_ohs_2_7
                                  ? 4'h7
                                  : s1_hit_ohs_2_8
                                      ? 4'h8
                                      : s1_hit_ohs_2_9
                                          ? 4'h9
                                          : s1_hit_ohs_2_10
                                              ? 4'hA
                                              : s1_hit_ohs_2_11
                                                  ? 4'hB
                                                  : s1_hit_ohs_2_12
                                                      ? 4'hC
                                                      : s1_hit_ohs_2_13
                                                          ? 4'hD
                                                          : {3'h7, ~s1_hit_ohs_2_14};	// Bitwise.scala:72:12, Mux.scala:47:69, faubtb.scala:72:22, :81:39, :131:56
  wire [3:0]        s1_hit_ways_3 =
    s1_hit_ohs_3_0
      ? 4'h0
      : s1_hit_ohs_3_1
          ? 4'h1
          : s1_hit_ohs_3_2
              ? 4'h2
              : s1_hit_ohs_3_3
                  ? 4'h3
                  : s1_hit_ohs_3_4
                      ? 4'h4
                      : s1_hit_ohs_3_5
                          ? 4'h5
                          : s1_hit_ohs_3_6
                              ? 4'h6
                              : s1_hit_ohs_3_7
                                  ? 4'h7
                                  : s1_hit_ohs_3_8
                                      ? 4'h8
                                      : s1_hit_ohs_3_9
                                          ? 4'h9
                                          : s1_hit_ohs_3_10
                                              ? 4'hA
                                              : s1_hit_ohs_3_11
                                                  ? 4'hB
                                                  : s1_hit_ohs_3_12
                                                      ? 4'hC
                                                      : s1_hit_ohs_3_13
                                                          ? 4'hD
                                                          : {3'h7, ~s1_hit_ohs_3_14};	// Bitwise.scala:72:12, Mux.scala:47:69, faubtb.scala:72:22, :81:39, :131:56
  wire              s1_resp_0_valid = s1_valid & s1_meta_hits_0;	// faubtb.scala:75:55, :80:34, predictor.scala:168:25
  wire [15:0][12:0] _GEN =
    {{btb_15_0_offset},
     {btb_14_0_offset},
     {btb_13_0_offset},
     {btb_12_0_offset},
     {btb_11_0_offset},
     {btb_10_0_offset},
     {btb_9_0_offset},
     {btb_8_0_offset},
     {btb_7_0_offset},
     {btb_6_0_offset},
     {btb_5_0_offset},
     {btb_4_0_offset},
     {btb_3_0_offset},
     {btb_2_0_offset},
     {btb_1_0_offset},
     {btb_0_0_offset}};	// faubtb.scala:58:21, :81:52
  wire [39:0]       _s1_resp_0_bits_T_4 =
    s1_pc + {{27{_GEN[s1_hit_ways_0][12]}}, _GEN[s1_hit_ways_0]};	// Mux.scala:47:69, faubtb.scala:81:52, predictor.scala:178:22
  wire [15:0]       _GEN_0 =
    {{meta_15_0_is_br},
     {meta_14_0_is_br},
     {meta_13_0_is_br},
     {meta_12_0_is_br},
     {meta_11_0_is_br},
     {meta_10_0_is_br},
     {meta_9_0_is_br},
     {meta_8_0_is_br},
     {meta_7_0_is_br},
     {meta_6_0_is_br},
     {meta_5_0_is_br},
     {meta_4_0_is_br},
     {meta_3_0_is_br},
     {meta_2_0_is_br},
     {meta_1_0_is_br},
     {meta_0_0_is_br}};	// faubtb.scala:57:25, :82:42
  wire [15:0][1:0]  _GEN_1 =
    {{meta_15_0_ctr},
     {meta_14_0_ctr},
     {meta_13_0_ctr},
     {meta_12_0_ctr},
     {meta_11_0_ctr},
     {meta_10_0_ctr},
     {meta_9_0_ctr},
     {meta_8_0_ctr},
     {meta_7_0_ctr},
     {meta_6_0_ctr},
     {meta_5_0_ctr},
     {meta_4_0_ctr},
     {meta_3_0_ctr},
     {meta_2_0_ctr},
     {meta_1_0_ctr},
     {meta_0_0_ctr}};	// faubtb.scala:57:25, :82:42
  wire              s1_is_br_0 = s1_resp_0_valid & _GEN_0[s1_hit_ways_0];	// Mux.scala:47:69, faubtb.scala:80:34, :82:42
  wire              s1_is_jal_0 = s1_resp_0_valid & ~_GEN_0[s1_hit_ways_0];	// Mux.scala:47:69, faubtb.scala:80:34, :82:42, :83:{42,45}
  wire              s1_resp_1_valid = s1_valid & s1_meta_hits_1;	// faubtb.scala:75:55, :80:34, predictor.scala:168:25
  wire [15:0][12:0] _GEN_2 =
    {{btb_15_1_offset},
     {btb_14_1_offset},
     {btb_13_1_offset},
     {btb_12_1_offset},
     {btb_11_1_offset},
     {btb_10_1_offset},
     {btb_9_1_offset},
     {btb_8_1_offset},
     {btb_7_1_offset},
     {btb_6_1_offset},
     {btb_5_1_offset},
     {btb_4_1_offset},
     {btb_3_1_offset},
     {btb_2_1_offset},
     {btb_1_1_offset},
     {btb_0_1_offset}};	// faubtb.scala:58:21, :81:52
  wire [39:0]       _s1_resp_1_bits_T_4 =
    s1_pc + {{27{_GEN_2[s1_hit_ways_1][12]}}, _GEN_2[s1_hit_ways_1]} + 40'h2;	// Mux.scala:47:69, faubtb.scala:81:{39,52}, predictor.scala:178:22
  wire [15:0]       _GEN_3 =
    {{meta_15_1_is_br},
     {meta_14_1_is_br},
     {meta_13_1_is_br},
     {meta_12_1_is_br},
     {meta_11_1_is_br},
     {meta_10_1_is_br},
     {meta_9_1_is_br},
     {meta_8_1_is_br},
     {meta_7_1_is_br},
     {meta_6_1_is_br},
     {meta_5_1_is_br},
     {meta_4_1_is_br},
     {meta_3_1_is_br},
     {meta_2_1_is_br},
     {meta_1_1_is_br},
     {meta_0_1_is_br}};	// faubtb.scala:57:25, :82:42
  wire [15:0][1:0]  _GEN_4 =
    {{meta_15_1_ctr},
     {meta_14_1_ctr},
     {meta_13_1_ctr},
     {meta_12_1_ctr},
     {meta_11_1_ctr},
     {meta_10_1_ctr},
     {meta_9_1_ctr},
     {meta_8_1_ctr},
     {meta_7_1_ctr},
     {meta_6_1_ctr},
     {meta_5_1_ctr},
     {meta_4_1_ctr},
     {meta_3_1_ctr},
     {meta_2_1_ctr},
     {meta_1_1_ctr},
     {meta_0_1_ctr}};	// faubtb.scala:57:25, :82:42
  wire              s1_is_br_1 = s1_resp_1_valid & _GEN_3[s1_hit_ways_1];	// Mux.scala:47:69, faubtb.scala:80:34, :82:42
  wire              s1_is_jal_1 = s1_resp_1_valid & ~_GEN_3[s1_hit_ways_1];	// Mux.scala:47:69, faubtb.scala:80:34, :82:42, :83:{42,45}
  wire              s1_resp_2_valid = s1_valid & s1_meta_hits_2;	// faubtb.scala:75:55, :80:34, predictor.scala:168:25
  wire [15:0][12:0] _GEN_5 =
    {{btb_15_2_offset},
     {btb_14_2_offset},
     {btb_13_2_offset},
     {btb_12_2_offset},
     {btb_11_2_offset},
     {btb_10_2_offset},
     {btb_9_2_offset},
     {btb_8_2_offset},
     {btb_7_2_offset},
     {btb_6_2_offset},
     {btb_5_2_offset},
     {btb_4_2_offset},
     {btb_3_2_offset},
     {btb_2_2_offset},
     {btb_1_2_offset},
     {btb_0_2_offset}};	// faubtb.scala:58:21, :81:52
  wire [39:0]       _s1_resp_2_bits_T_4 =
    s1_pc + {{27{_GEN_5[s1_hit_ways_2][12]}}, _GEN_5[s1_hit_ways_2]} + 40'h4;	// Mux.scala:47:69, faubtb.scala:81:{39,52}, predictor.scala:178:22
  wire [15:0]       _GEN_6 =
    {{meta_15_2_is_br},
     {meta_14_2_is_br},
     {meta_13_2_is_br},
     {meta_12_2_is_br},
     {meta_11_2_is_br},
     {meta_10_2_is_br},
     {meta_9_2_is_br},
     {meta_8_2_is_br},
     {meta_7_2_is_br},
     {meta_6_2_is_br},
     {meta_5_2_is_br},
     {meta_4_2_is_br},
     {meta_3_2_is_br},
     {meta_2_2_is_br},
     {meta_1_2_is_br},
     {meta_0_2_is_br}};	// faubtb.scala:57:25, :82:42
  wire [15:0][1:0]  _GEN_7 =
    {{meta_15_2_ctr},
     {meta_14_2_ctr},
     {meta_13_2_ctr},
     {meta_12_2_ctr},
     {meta_11_2_ctr},
     {meta_10_2_ctr},
     {meta_9_2_ctr},
     {meta_8_2_ctr},
     {meta_7_2_ctr},
     {meta_6_2_ctr},
     {meta_5_2_ctr},
     {meta_4_2_ctr},
     {meta_3_2_ctr},
     {meta_2_2_ctr},
     {meta_1_2_ctr},
     {meta_0_2_ctr}};	// faubtb.scala:57:25, :82:42
  wire              s1_is_br_2 = s1_resp_2_valid & _GEN_6[s1_hit_ways_2];	// Mux.scala:47:69, faubtb.scala:80:34, :82:42
  wire              s1_is_jal_2 = s1_resp_2_valid & ~_GEN_6[s1_hit_ways_2];	// Mux.scala:47:69, faubtb.scala:80:34, :82:42, :83:{42,45}
  wire              s1_resp_3_valid = s1_valid & s1_meta_hits_3;	// faubtb.scala:75:55, :80:34, predictor.scala:168:25
  wire [15:0][12:0] _GEN_8 =
    {{btb_15_3_offset},
     {btb_14_3_offset},
     {btb_13_3_offset},
     {btb_12_3_offset},
     {btb_11_3_offset},
     {btb_10_3_offset},
     {btb_9_3_offset},
     {btb_8_3_offset},
     {btb_7_3_offset},
     {btb_6_3_offset},
     {btb_5_3_offset},
     {btb_4_3_offset},
     {btb_3_3_offset},
     {btb_2_3_offset},
     {btb_1_3_offset},
     {btb_0_3_offset}};	// faubtb.scala:58:21, :81:52
  wire [39:0]       _s1_resp_3_bits_T_4 =
    s1_pc + {{27{_GEN_8[s1_hit_ways_3][12]}}, _GEN_8[s1_hit_ways_3]} + 40'h6;	// Mux.scala:47:69, faubtb.scala:81:{39,52}, predictor.scala:178:22
  wire [15:0]       _GEN_9 =
    {{meta_15_3_is_br},
     {meta_14_3_is_br},
     {meta_13_3_is_br},
     {meta_12_3_is_br},
     {meta_11_3_is_br},
     {meta_10_3_is_br},
     {meta_9_3_is_br},
     {meta_8_3_is_br},
     {meta_7_3_is_br},
     {meta_6_3_is_br},
     {meta_5_3_is_br},
     {meta_4_3_is_br},
     {meta_3_3_is_br},
     {meta_2_3_is_br},
     {meta_1_3_is_br},
     {meta_0_3_is_br}};	// faubtb.scala:57:25, :82:42
  wire [15:0][1:0]  _GEN_10 =
    {{meta_15_3_ctr},
     {meta_14_3_ctr},
     {meta_13_3_ctr},
     {meta_12_3_ctr},
     {meta_11_3_ctr},
     {meta_10_3_ctr},
     {meta_9_3_ctr},
     {meta_8_3_ctr},
     {meta_7_3_ctr},
     {meta_6_3_ctr},
     {meta_5_3_ctr},
     {meta_4_3_ctr},
     {meta_3_3_ctr},
     {meta_2_3_ctr},
     {meta_1_3_ctr},
     {meta_0_3_ctr}};	// faubtb.scala:57:25, :82:42
  wire              s1_is_br_3 = s1_resp_3_valid & _GEN_9[s1_hit_ways_3];	// Mux.scala:47:69, faubtb.scala:80:34, :82:42
  wire              s1_is_jal_3 = s1_resp_3_valid & ~_GEN_9[s1_hit_ways_3];	// Mux.scala:47:69, faubtb.scala:80:34, :82:42, :83:{42,45}
  reg               io_resp_f2_0_REG_is_br;	// faubtb.scala:107:29
  reg               io_resp_f2_0_REG_is_jal;	// faubtb.scala:107:29
  reg               io_resp_f2_0_REG_predicted_pc_valid;	// faubtb.scala:107:29
  reg  [39:0]       io_resp_f2_0_REG_predicted_pc_bits;	// faubtb.scala:107:29
  reg               io_resp_f3_0_REG_is_br;	// faubtb.scala:108:29
  reg               io_resp_f3_0_REG_is_jal;	// faubtb.scala:108:29
  reg               io_resp_f3_0_REG_predicted_pc_valid;	// faubtb.scala:108:29
  reg  [39:0]       io_resp_f3_0_REG_predicted_pc_bits;	// faubtb.scala:108:29
  reg               io_resp_f2_1_REG_is_br;	// faubtb.scala:107:29
  reg               io_resp_f2_1_REG_is_jal;	// faubtb.scala:107:29
  reg               io_resp_f2_1_REG_predicted_pc_valid;	// faubtb.scala:107:29
  reg  [39:0]       io_resp_f2_1_REG_predicted_pc_bits;	// faubtb.scala:107:29
  reg               io_resp_f3_1_REG_is_br;	// faubtb.scala:108:29
  reg               io_resp_f3_1_REG_is_jal;	// faubtb.scala:108:29
  reg               io_resp_f3_1_REG_predicted_pc_valid;	// faubtb.scala:108:29
  reg  [39:0]       io_resp_f3_1_REG_predicted_pc_bits;	// faubtb.scala:108:29
  reg               io_resp_f2_2_REG_is_br;	// faubtb.scala:107:29
  reg               io_resp_f2_2_REG_is_jal;	// faubtb.scala:107:29
  reg               io_resp_f2_2_REG_predicted_pc_valid;	// faubtb.scala:107:29
  reg  [39:0]       io_resp_f2_2_REG_predicted_pc_bits;	// faubtb.scala:107:29
  reg               io_resp_f3_2_REG_is_br;	// faubtb.scala:108:29
  reg               io_resp_f3_2_REG_is_jal;	// faubtb.scala:108:29
  reg               io_resp_f3_2_REG_predicted_pc_valid;	// faubtb.scala:108:29
  reg  [39:0]       io_resp_f3_2_REG_predicted_pc_bits;	// faubtb.scala:108:29
  reg               io_resp_f2_3_REG_is_br;	// faubtb.scala:107:29
  reg               io_resp_f2_3_REG_is_jal;	// faubtb.scala:107:29
  reg               io_resp_f2_3_REG_predicted_pc_valid;	// faubtb.scala:107:29
  reg  [39:0]       io_resp_f2_3_REG_predicted_pc_bits;	// faubtb.scala:107:29
  reg               io_resp_f3_3_REG_is_br;	// faubtb.scala:108:29
  reg               io_resp_f3_3_REG_is_jal;	// faubtb.scala:108:29
  reg               io_resp_f3_3_REG_predicted_pc_valid;	// faubtb.scala:108:29
  reg  [39:0]       io_resp_f3_3_REG_predicted_pc_bits;	// faubtb.scala:108:29
  reg  [7:0]        io_f3_meta_REG;	// faubtb.scala:110:32
  reg  [7:0]        io_f3_meta_REG_1;	// faubtb.scala:110:24
  always @(posedge clock) begin
    automatic logic [14:0] _s1_meta_write_way_T_9 =
      {s1_hit_ohs_0_14,
       s1_hit_ohs_0_13,
       s1_hit_ohs_0_12,
       s1_hit_ohs_0_11,
       s1_hit_ohs_0_10,
       s1_hit_ohs_0_9,
       s1_hit_ohs_0_8,
       s1_hit_ohs_0_7,
       s1_hit_ohs_0_6,
       s1_hit_ohs_0_5,
       s1_hit_ohs_0_4,
       s1_hit_ohs_0_3,
       s1_hit_ohs_0_2,
       s1_hit_ohs_0_1,
       s1_hit_ohs_0_0}
      | {s1_hit_ohs_1_14,
         s1_hit_ohs_1_13,
         s1_hit_ohs_1_12,
         s1_hit_ohs_1_11,
         s1_hit_ohs_1_10,
         s1_hit_ohs_1_9,
         s1_hit_ohs_1_8,
         s1_hit_ohs_1_7,
         s1_hit_ohs_1_6,
         s1_hit_ohs_1_5,
         s1_hit_ohs_1_4,
         s1_hit_ohs_1_3,
         s1_hit_ohs_1_2,
         s1_hit_ohs_1_1,
         s1_hit_ohs_1_0}
      | {s1_hit_ohs_2_14,
         s1_hit_ohs_2_13,
         s1_hit_ohs_2_12,
         s1_hit_ohs_2_11,
         s1_hit_ohs_2_10,
         s1_hit_ohs_2_9,
         s1_hit_ohs_2_8,
         s1_hit_ohs_2_7,
         s1_hit_ohs_2_6,
         s1_hit_ohs_2_5,
         s1_hit_ohs_2_4,
         s1_hit_ohs_2_3,
         s1_hit_ohs_2_2,
         s1_hit_ohs_2_1,
         s1_hit_ohs_2_0}
      | {s1_hit_ohs_3_14,
         s1_hit_ohs_3_13,
         s1_hit_ohs_3_12,
         s1_hit_ohs_3_11,
         s1_hit_ohs_3_10,
         s1_hit_ohs_3_9,
         s1_hit_ohs_3_8,
         s1_hit_ohs_3_7,
         s1_hit_ohs_3_6,
         s1_hit_ohs_3_5,
         s1_hit_ohs_3_4,
         s1_hit_ohs_3_3,
         s1_hit_ohs_3_2,
         s1_hit_ohs_3_1,
         s1_hit_ohs_3_0};	// faubtb.scala:72:22, :98:{38,54}
    automatic logic [12:0] _new_offset_value_T_5;	// faubtb.scala:118:56
    automatic logic        _GEN_11;	// predictor.scala:96:69
    automatic logic        _GEN_12;	// faubtb.scala:130:85
    automatic logic        _GEN_13;	// faubtb.scala:131:56
    automatic logic        _GEN_14;	// faubtb.scala:131:56
    automatic logic        _GEN_15;	// faubtb.scala:131:56
    automatic logic        _GEN_16;	// faubtb.scala:131:56
    automatic logic        _GEN_17;	// faubtb.scala:131:56
    automatic logic        _GEN_18;	// faubtb.scala:131:56
    automatic logic        _GEN_19;	// faubtb.scala:131:56
    automatic logic        _GEN_20;	// faubtb.scala:131:56
    automatic logic        _GEN_21;	// faubtb.scala:131:56
    automatic logic        _GEN_22;	// faubtb.scala:131:56
    automatic logic        _GEN_23;	// faubtb.scala:131:56
    automatic logic        _GEN_24;	// faubtb.scala:131:56
    automatic logic        _GEN_25;	// faubtb.scala:131:56
    automatic logic        _GEN_26;	// faubtb.scala:131:56
    automatic logic        _GEN_27;	// faubtb.scala:131:56
    automatic logic        _GEN_28;	// faubtb.scala:131:56
    automatic logic        _GEN_29;	// faubtb.scala:131:56
    _new_offset_value_T_5 =
      s1_update_bits_target[12:0]
      - (s1_update_bits_pc[12:0] + {10'h0, s1_update_bits_cfi_idx_bits, 1'h0});	// faubtb.scala:118:56, :119:24, predictor.scala:160:14, :184:30
    _GEN_11 =
      s1_update_bits_is_mispredict_update | s1_update_bits_is_repair_update
      | (|s1_update_bits_btb_mispredicts);	// predictor.scala:94:50, :96:69, :184:30
    _GEN_12 =
      s1_update_valid & s1_update_bits_cfi_taken & s1_update_bits_cfi_idx_valid
      & ~_GEN_11;	// faubtb.scala:130:85, predictor.scala:96:{26,69}, :184:30
    _GEN_13 = s1_update_bits_meta[3:0] == 4'h0;	// Bitwise.scala:72:12, faubtb.scala:113:55, :131:56, predictor.scala:184:30
    _GEN_14 = s1_update_bits_cfi_idx_bits == 2'h1;	// faubtb.scala:131:56, predictor.scala:184:30
    _GEN_15 = s1_update_bits_cfi_idx_bits == 2'h2;	// Mux.scala:47:69, faubtb.scala:131:56, predictor.scala:184:30
    _GEN_16 = s1_update_bits_meta[3:0] == 4'h1;	// faubtb.scala:113:55, :131:56, predictor.scala:184:30
    _GEN_17 = s1_update_bits_meta[3:0] == 4'h2;	// faubtb.scala:113:55, :131:56, predictor.scala:184:30
    _GEN_18 = s1_update_bits_meta[3:0] == 4'h3;	// faubtb.scala:113:55, :131:56, predictor.scala:184:30
    _GEN_19 = s1_update_bits_meta[3:0] == 4'h4;	// faubtb.scala:81:39, :113:55, :131:56, predictor.scala:184:30
    _GEN_20 = s1_update_bits_meta[3:0] == 4'h5;	// faubtb.scala:113:55, :131:56, predictor.scala:184:30
    _GEN_21 = s1_update_bits_meta[3:0] == 4'h6;	// faubtb.scala:81:39, :113:55, :131:56, predictor.scala:184:30
    _GEN_22 = s1_update_bits_meta[3:0] == 4'h7;	// faubtb.scala:113:55, :131:56, predictor.scala:184:30
    _GEN_23 = s1_update_bits_meta[3:0] == 4'h8;	// Mux.scala:47:69, faubtb.scala:113:55, :131:56, predictor.scala:184:30
    _GEN_24 = s1_update_bits_meta[3:0] == 4'h9;	// Mux.scala:47:69, faubtb.scala:113:55, :131:56, predictor.scala:184:30
    _GEN_25 = s1_update_bits_meta[3:0] == 4'hA;	// Mux.scala:47:69, faubtb.scala:113:55, :131:56, predictor.scala:184:30
    _GEN_26 = s1_update_bits_meta[3:0] == 4'hB;	// Mux.scala:47:69, faubtb.scala:113:55, :131:56, predictor.scala:184:30
    _GEN_27 = s1_update_bits_meta[3:0] == 4'hC;	// Mux.scala:47:69, faubtb.scala:113:55, :131:56, predictor.scala:184:30
    _GEN_28 = s1_update_bits_meta[3:0] == 4'hD;	// Mux.scala:47:69, faubtb.scala:113:55, :131:56, predictor.scala:184:30
    _GEN_29 = s1_update_bits_meta[3:0] == 4'hE;	// Mux.scala:47:69, faubtb.scala:113:55, :131:56, predictor.scala:184:30
    s1_idx <= io_f0_pc[39:4];	// frontend.scala:163:35, predictor.scala:163:29
    s1_valid <= io_f0_valid;	// predictor.scala:168:25
    s1_pc <= io_f0_pc;	// predictor.scala:178:22
    s1_update_valid <= io_update_valid;	// predictor.scala:184:30
    s1_update_bits_is_mispredict_update <= io_update_bits_is_mispredict_update;	// predictor.scala:184:30
    s1_update_bits_is_repair_update <= io_update_bits_is_repair_update;	// predictor.scala:184:30
    s1_update_bits_btb_mispredicts <= io_update_bits_btb_mispredicts;	// predictor.scala:184:30
    s1_update_bits_pc <= io_update_bits_pc;	// predictor.scala:184:30
    s1_update_bits_br_mask <= io_update_bits_br_mask;	// predictor.scala:184:30
    s1_update_bits_cfi_idx_valid <= io_update_bits_cfi_idx_valid;	// predictor.scala:184:30
    s1_update_bits_cfi_idx_bits <= io_update_bits_cfi_idx_bits;	// predictor.scala:184:30
    s1_update_bits_cfi_taken <= io_update_bits_cfi_taken;	// predictor.scala:184:30
    s1_update_bits_cfi_is_jal <= io_update_bits_cfi_is_jal;	// predictor.scala:184:30
    s1_update_bits_target <= io_update_bits_target;	// predictor.scala:184:30
    s1_update_bits_meta <= io_update_bits_meta;	// predictor.scala:184:30
    s1_update_idx <= io_update_bits_pc[39:4];	// frontend.scala:163:35, predictor.scala:185:30
    if (_GEN_12 & _GEN_13 & ~(|s1_update_bits_cfi_idx_bits))	// faubtb.scala:58:21, :130:{85,121}, :131:56, predictor.scala:184:30
      btb_0_0_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_13 & _GEN_14)	// faubtb.scala:58:21, :130:{85,121}, :131:56
      btb_0_1_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_13 & _GEN_15)	// faubtb.scala:58:21, :130:{85,121}, :131:56
      btb_0_2_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_13 & (&s1_update_bits_cfi_idx_bits))	// faubtb.scala:58:21, :130:{85,121}, :131:56, predictor.scala:184:30
      btb_0_3_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_16 & ~(|s1_update_bits_cfi_idx_bits))	// faubtb.scala:58:21, :130:{85,121}, :131:56, predictor.scala:184:30
      btb_1_0_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_16 & _GEN_14)	// faubtb.scala:58:21, :130:{85,121}, :131:56
      btb_1_1_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_16 & _GEN_15)	// faubtb.scala:58:21, :130:{85,121}, :131:56
      btb_1_2_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_16 & (&s1_update_bits_cfi_idx_bits))	// faubtb.scala:58:21, :130:{85,121}, :131:56, predictor.scala:184:30
      btb_1_3_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_17 & ~(|s1_update_bits_cfi_idx_bits))	// faubtb.scala:58:21, :130:{85,121}, :131:56, predictor.scala:184:30
      btb_2_0_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_17 & _GEN_14)	// faubtb.scala:58:21, :130:{85,121}, :131:56
      btb_2_1_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_17 & _GEN_15)	// faubtb.scala:58:21, :130:{85,121}, :131:56
      btb_2_2_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_17 & (&s1_update_bits_cfi_idx_bits))	// faubtb.scala:58:21, :130:{85,121}, :131:56, predictor.scala:184:30
      btb_2_3_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_18 & ~(|s1_update_bits_cfi_idx_bits))	// faubtb.scala:58:21, :130:{85,121}, :131:56, predictor.scala:184:30
      btb_3_0_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_18 & _GEN_14)	// faubtb.scala:58:21, :130:{85,121}, :131:56
      btb_3_1_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_18 & _GEN_15)	// faubtb.scala:58:21, :130:{85,121}, :131:56
      btb_3_2_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_18 & (&s1_update_bits_cfi_idx_bits))	// faubtb.scala:58:21, :130:{85,121}, :131:56, predictor.scala:184:30
      btb_3_3_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_19 & ~(|s1_update_bits_cfi_idx_bits))	// faubtb.scala:58:21, :130:{85,121}, :131:56, predictor.scala:184:30
      btb_4_0_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_19 & _GEN_14)	// faubtb.scala:58:21, :130:{85,121}, :131:56
      btb_4_1_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_19 & _GEN_15)	// faubtb.scala:58:21, :130:{85,121}, :131:56
      btb_4_2_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_19 & (&s1_update_bits_cfi_idx_bits))	// faubtb.scala:58:21, :130:{85,121}, :131:56, predictor.scala:184:30
      btb_4_3_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_20 & ~(|s1_update_bits_cfi_idx_bits))	// faubtb.scala:58:21, :130:{85,121}, :131:56, predictor.scala:184:30
      btb_5_0_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_20 & _GEN_14)	// faubtb.scala:58:21, :130:{85,121}, :131:56
      btb_5_1_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_20 & _GEN_15)	// faubtb.scala:58:21, :130:{85,121}, :131:56
      btb_5_2_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_20 & (&s1_update_bits_cfi_idx_bits))	// faubtb.scala:58:21, :130:{85,121}, :131:56, predictor.scala:184:30
      btb_5_3_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_21 & ~(|s1_update_bits_cfi_idx_bits))	// faubtb.scala:58:21, :130:{85,121}, :131:56, predictor.scala:184:30
      btb_6_0_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_21 & _GEN_14)	// faubtb.scala:58:21, :130:{85,121}, :131:56
      btb_6_1_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_21 & _GEN_15)	// faubtb.scala:58:21, :130:{85,121}, :131:56
      btb_6_2_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_21 & (&s1_update_bits_cfi_idx_bits))	// faubtb.scala:58:21, :130:{85,121}, :131:56, predictor.scala:184:30
      btb_6_3_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_22 & ~(|s1_update_bits_cfi_idx_bits))	// faubtb.scala:58:21, :130:{85,121}, :131:56, predictor.scala:184:30
      btb_7_0_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_22 & _GEN_14)	// faubtb.scala:58:21, :130:{85,121}, :131:56
      btb_7_1_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_22 & _GEN_15)	// faubtb.scala:58:21, :130:{85,121}, :131:56
      btb_7_2_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_22 & (&s1_update_bits_cfi_idx_bits))	// faubtb.scala:58:21, :130:{85,121}, :131:56, predictor.scala:184:30
      btb_7_3_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_23 & ~(|s1_update_bits_cfi_idx_bits))	// faubtb.scala:58:21, :130:{85,121}, :131:56, predictor.scala:184:30
      btb_8_0_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_23 & _GEN_14)	// faubtb.scala:58:21, :130:{85,121}, :131:56
      btb_8_1_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_23 & _GEN_15)	// faubtb.scala:58:21, :130:{85,121}, :131:56
      btb_8_2_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_23 & (&s1_update_bits_cfi_idx_bits))	// faubtb.scala:58:21, :130:{85,121}, :131:56, predictor.scala:184:30
      btb_8_3_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_24 & ~(|s1_update_bits_cfi_idx_bits))	// faubtb.scala:58:21, :130:{85,121}, :131:56, predictor.scala:184:30
      btb_9_0_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_24 & _GEN_14)	// faubtb.scala:58:21, :130:{85,121}, :131:56
      btb_9_1_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_24 & _GEN_15)	// faubtb.scala:58:21, :130:{85,121}, :131:56
      btb_9_2_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_24 & (&s1_update_bits_cfi_idx_bits))	// faubtb.scala:58:21, :130:{85,121}, :131:56, predictor.scala:184:30
      btb_9_3_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_25 & ~(|s1_update_bits_cfi_idx_bits))	// faubtb.scala:58:21, :130:{85,121}, :131:56, predictor.scala:184:30
      btb_10_0_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_25 & _GEN_14)	// faubtb.scala:58:21, :130:{85,121}, :131:56
      btb_10_1_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_25 & _GEN_15)	// faubtb.scala:58:21, :130:{85,121}, :131:56
      btb_10_2_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_25 & (&s1_update_bits_cfi_idx_bits))	// faubtb.scala:58:21, :130:{85,121}, :131:56, predictor.scala:184:30
      btb_10_3_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_26 & ~(|s1_update_bits_cfi_idx_bits))	// faubtb.scala:58:21, :130:{85,121}, :131:56, predictor.scala:184:30
      btb_11_0_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_26 & _GEN_14)	// faubtb.scala:58:21, :130:{85,121}, :131:56
      btb_11_1_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_26 & _GEN_15)	// faubtb.scala:58:21, :130:{85,121}, :131:56
      btb_11_2_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_26 & (&s1_update_bits_cfi_idx_bits))	// faubtb.scala:58:21, :130:{85,121}, :131:56, predictor.scala:184:30
      btb_11_3_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_27 & ~(|s1_update_bits_cfi_idx_bits))	// faubtb.scala:58:21, :130:{85,121}, :131:56, predictor.scala:184:30
      btb_12_0_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_27 & _GEN_14)	// faubtb.scala:58:21, :130:{85,121}, :131:56
      btb_12_1_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_27 & _GEN_15)	// faubtb.scala:58:21, :130:{85,121}, :131:56
      btb_12_2_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_27 & (&s1_update_bits_cfi_idx_bits))	// faubtb.scala:58:21, :130:{85,121}, :131:56, predictor.scala:184:30
      btb_12_3_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_28 & ~(|s1_update_bits_cfi_idx_bits))	// faubtb.scala:58:21, :130:{85,121}, :131:56, predictor.scala:184:30
      btb_13_0_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_28 & _GEN_14)	// faubtb.scala:58:21, :130:{85,121}, :131:56
      btb_13_1_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_28 & _GEN_15)	// faubtb.scala:58:21, :130:{85,121}, :131:56
      btb_13_2_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_28 & (&s1_update_bits_cfi_idx_bits))	// faubtb.scala:58:21, :130:{85,121}, :131:56, predictor.scala:184:30
      btb_13_3_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_29 & ~(|s1_update_bits_cfi_idx_bits))	// faubtb.scala:58:21, :130:{85,121}, :131:56, predictor.scala:184:30
      btb_14_0_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_29 & _GEN_14)	// faubtb.scala:58:21, :130:{85,121}, :131:56
      btb_14_1_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_29 & _GEN_15)	// faubtb.scala:58:21, :130:{85,121}, :131:56
      btb_14_2_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & _GEN_29 & (&s1_update_bits_cfi_idx_bits))	// faubtb.scala:58:21, :130:{85,121}, :131:56, predictor.scala:184:30
      btb_14_3_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & (&(s1_update_bits_meta[3:0])) & ~(|s1_update_bits_cfi_idx_bits))	// faubtb.scala:58:21, :113:55, :130:{85,121}, :131:56, predictor.scala:184:30
      btb_15_0_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & (&(s1_update_bits_meta[3:0])) & _GEN_14)	// faubtb.scala:58:21, :113:55, :130:{85,121}, :131:56, predictor.scala:184:30
      btb_15_1_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & (&(s1_update_bits_meta[3:0])) & _GEN_15)	// faubtb.scala:58:21, :113:55, :130:{85,121}, :131:56, predictor.scala:184:30
      btb_15_2_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    if (_GEN_12 & (&(s1_update_bits_meta[3:0])) & (&s1_update_bits_cfi_idx_bits))	// faubtb.scala:58:21, :113:55, :130:{85,121}, :131:56, predictor.scala:184:30
      btb_15_3_offset <= _new_offset_value_T_5;	// faubtb.scala:58:21, :118:56
    io_resp_f2_0_REG_is_br <= s1_is_br_0;	// faubtb.scala:82:42, :107:29
    io_resp_f2_0_REG_is_jal <= s1_is_jal_0;	// faubtb.scala:83:42, :107:29
    io_resp_f2_0_REG_predicted_pc_valid <= s1_resp_0_valid;	// faubtb.scala:80:34, :107:29
    io_resp_f2_0_REG_predicted_pc_bits <= _s1_resp_0_bits_T_4;	// faubtb.scala:81:52, :107:29
    io_resp_f3_0_REG_is_br <= io_resp_f2_0_REG_is_br;	// faubtb.scala:107:29, :108:29
    io_resp_f3_0_REG_is_jal <= io_resp_f2_0_REG_is_jal;	// faubtb.scala:107:29, :108:29
    io_resp_f3_0_REG_predicted_pc_valid <= io_resp_f2_0_REG_predicted_pc_valid;	// faubtb.scala:107:29, :108:29
    io_resp_f3_0_REG_predicted_pc_bits <= io_resp_f2_0_REG_predicted_pc_bits;	// faubtb.scala:107:29, :108:29
    io_resp_f2_1_REG_is_br <= s1_is_br_1;	// faubtb.scala:82:42, :107:29
    io_resp_f2_1_REG_is_jal <= s1_is_jal_1;	// faubtb.scala:83:42, :107:29
    io_resp_f2_1_REG_predicted_pc_valid <= s1_resp_1_valid;	// faubtb.scala:80:34, :107:29
    io_resp_f2_1_REG_predicted_pc_bits <= _s1_resp_1_bits_T_4;	// faubtb.scala:81:52, :107:29
    io_resp_f3_1_REG_is_br <= io_resp_f2_1_REG_is_br;	// faubtb.scala:107:29, :108:29
    io_resp_f3_1_REG_is_jal <= io_resp_f2_1_REG_is_jal;	// faubtb.scala:107:29, :108:29
    io_resp_f3_1_REG_predicted_pc_valid <= io_resp_f2_1_REG_predicted_pc_valid;	// faubtb.scala:107:29, :108:29
    io_resp_f3_1_REG_predicted_pc_bits <= io_resp_f2_1_REG_predicted_pc_bits;	// faubtb.scala:107:29, :108:29
    io_resp_f2_2_REG_is_br <= s1_is_br_2;	// faubtb.scala:82:42, :107:29
    io_resp_f2_2_REG_is_jal <= s1_is_jal_2;	// faubtb.scala:83:42, :107:29
    io_resp_f2_2_REG_predicted_pc_valid <= s1_resp_2_valid;	// faubtb.scala:80:34, :107:29
    io_resp_f2_2_REG_predicted_pc_bits <= _s1_resp_2_bits_T_4;	// faubtb.scala:81:52, :107:29
    io_resp_f3_2_REG_is_br <= io_resp_f2_2_REG_is_br;	// faubtb.scala:107:29, :108:29
    io_resp_f3_2_REG_is_jal <= io_resp_f2_2_REG_is_jal;	// faubtb.scala:107:29, :108:29
    io_resp_f3_2_REG_predicted_pc_valid <= io_resp_f2_2_REG_predicted_pc_valid;	// faubtb.scala:107:29, :108:29
    io_resp_f3_2_REG_predicted_pc_bits <= io_resp_f2_2_REG_predicted_pc_bits;	// faubtb.scala:107:29, :108:29
    io_resp_f2_3_REG_is_br <= s1_is_br_3;	// faubtb.scala:82:42, :107:29
    io_resp_f2_3_REG_is_jal <= s1_is_jal_3;	// faubtb.scala:83:42, :107:29
    io_resp_f2_3_REG_predicted_pc_valid <= s1_resp_3_valid;	// faubtb.scala:80:34, :107:29
    io_resp_f2_3_REG_predicted_pc_bits <= _s1_resp_3_bits_T_4;	// faubtb.scala:81:52, :107:29
    io_resp_f3_3_REG_is_br <= io_resp_f2_3_REG_is_br;	// faubtb.scala:107:29, :108:29
    io_resp_f3_3_REG_is_jal <= io_resp_f2_3_REG_is_jal;	// faubtb.scala:107:29, :108:29
    io_resp_f3_3_REG_predicted_pc_valid <= io_resp_f2_3_REG_predicted_pc_valid;	// faubtb.scala:107:29, :108:29
    io_resp_f3_3_REG_predicted_pc_bits <= io_resp_f2_3_REG_predicted_pc_bits;	// faubtb.scala:107:29, :108:29
    io_f3_meta_REG <=
      {s1_meta_hits_3,
       s1_meta_hits_2,
       s1_meta_hits_1,
       s1_meta_hits_0,
       s1_meta_hits_0 | s1_meta_hits_1 | s1_meta_hits_2 | s1_meta_hits_3
         ? (_s1_meta_write_way_T_9[0]
              ? 4'h0
              : _s1_meta_write_way_T_9[1]
                  ? 4'h1
                  : _s1_meta_write_way_T_9[2]
                      ? 4'h2
                      : _s1_meta_write_way_T_9[3]
                          ? 4'h3
                          : _s1_meta_write_way_T_9[4]
                              ? 4'h4
                              : _s1_meta_write_way_T_9[5]
                                  ? 4'h5
                                  : _s1_meta_write_way_T_9[6]
                                      ? 4'h6
                                      : _s1_meta_write_way_T_9[7]
                                          ? 4'h7
                                          : _s1_meta_write_way_T_9[8]
                                              ? 4'h8
                                              : _s1_meta_write_way_T_9[9]
                                                  ? 4'h9
                                                  : _s1_meta_write_way_T_9[10]
                                                      ? 4'hA
                                                      : _s1_meta_write_way_T_9[11]
                                                          ? 4'hB
                                                          : _s1_meta_write_way_T_9[12]
                                                              ? 4'hC
                                                              : _s1_meta_write_way_T_9[13]
                                                                  ? 4'hD
                                                                  : {3'h7,
                                                                     ~(_s1_meta_write_way_T_9[14])})
         : s1_idx[3:0] ^ s1_idx[7:4] ^ s1_idx[11:8] ^ s1_idx[15:12] ^ s1_idx[19:16]
           ^ s1_idx[23:20] ^ s1_idx[27:24] ^ s1_idx[31:28] ^ s1_idx[35:32]
           ^ meta_0_0_tag[3:0] ^ meta_0_0_tag[7:4] ^ meta_0_0_tag[11:8]
           ^ meta_0_0_tag[15:12] ^ meta_0_0_tag[19:16] ^ meta_0_0_tag[23:20]
           ^ meta_0_0_tag[27:24] ^ meta_0_0_tag[31:28] ^ meta_0_0_tag[35:32]
           ^ meta_0_1_tag[3:0] ^ meta_0_1_tag[7:4] ^ meta_0_1_tag[11:8]
           ^ meta_0_1_tag[15:12] ^ meta_0_1_tag[19:16] ^ meta_0_1_tag[23:20]
           ^ meta_0_1_tag[27:24] ^ meta_0_1_tag[31:28] ^ meta_0_1_tag[35:32]
           ^ meta_0_2_tag[3:0] ^ meta_0_2_tag[7:4] ^ meta_0_2_tag[11:8]
           ^ meta_0_2_tag[15:12] ^ meta_0_2_tag[19:16] ^ meta_0_2_tag[23:20]
           ^ meta_0_2_tag[27:24] ^ meta_0_2_tag[31:28] ^ meta_0_2_tag[35:32]
           ^ meta_0_3_tag[3:0] ^ meta_0_3_tag[7:4] ^ meta_0_3_tag[11:8]
           ^ meta_0_3_tag[15:12] ^ meta_0_3_tag[19:16] ^ meta_0_3_tag[23:20]
           ^ meta_0_3_tag[27:24] ^ meta_0_3_tag[31:28] ^ meta_0_3_tag[35:32]
           ^ meta_1_0_tag[3:0] ^ meta_1_0_tag[7:4] ^ meta_1_0_tag[11:8]
           ^ meta_1_0_tag[15:12] ^ meta_1_0_tag[19:16] ^ meta_1_0_tag[23:20]
           ^ meta_1_0_tag[27:24] ^ meta_1_0_tag[31:28] ^ meta_1_0_tag[35:32]
           ^ meta_1_1_tag[3:0] ^ meta_1_1_tag[7:4] ^ meta_1_1_tag[11:8]
           ^ meta_1_1_tag[15:12] ^ meta_1_1_tag[19:16] ^ meta_1_1_tag[23:20]
           ^ meta_1_1_tag[27:24] ^ meta_1_1_tag[31:28] ^ meta_1_1_tag[35:32]
           ^ meta_1_2_tag[3:0] ^ meta_1_2_tag[7:4] ^ meta_1_2_tag[11:8]
           ^ meta_1_2_tag[15:12] ^ meta_1_2_tag[19:16] ^ meta_1_2_tag[23:20]
           ^ meta_1_2_tag[27:24] ^ meta_1_2_tag[31:28] ^ meta_1_2_tag[35:32]
           ^ meta_1_3_tag[3:0] ^ meta_1_3_tag[7:4] ^ meta_1_3_tag[11:8]
           ^ meta_1_3_tag[15:12] ^ meta_1_3_tag[19:16] ^ meta_1_3_tag[23:20]
           ^ meta_1_3_tag[27:24] ^ meta_1_3_tag[31:28] ^ meta_1_3_tag[35:32]
           ^ meta_2_0_tag[3:0] ^ meta_2_0_tag[7:4] ^ meta_2_0_tag[11:8]
           ^ meta_2_0_tag[15:12] ^ meta_2_0_tag[19:16] ^ meta_2_0_tag[23:20]
           ^ meta_2_0_tag[27:24] ^ meta_2_0_tag[31:28] ^ meta_2_0_tag[35:32]
           ^ meta_2_1_tag[3:0] ^ meta_2_1_tag[7:4] ^ meta_2_1_tag[11:8]
           ^ meta_2_1_tag[15:12] ^ meta_2_1_tag[19:16] ^ meta_2_1_tag[23:20]
           ^ meta_2_1_tag[27:24] ^ meta_2_1_tag[31:28] ^ meta_2_1_tag[35:32]
           ^ meta_2_2_tag[3:0] ^ meta_2_2_tag[7:4] ^ meta_2_2_tag[11:8]
           ^ meta_2_2_tag[15:12] ^ meta_2_2_tag[19:16] ^ meta_2_2_tag[23:20]
           ^ meta_2_2_tag[27:24] ^ meta_2_2_tag[31:28] ^ meta_2_2_tag[35:32]
           ^ meta_2_3_tag[3:0] ^ meta_2_3_tag[7:4] ^ meta_2_3_tag[11:8]
           ^ meta_2_3_tag[15:12] ^ meta_2_3_tag[19:16] ^ meta_2_3_tag[23:20]
           ^ meta_2_3_tag[27:24] ^ meta_2_3_tag[31:28] ^ meta_2_3_tag[35:32]
           ^ meta_3_0_tag[3:0] ^ meta_3_0_tag[7:4] ^ meta_3_0_tag[11:8]
           ^ meta_3_0_tag[15:12] ^ meta_3_0_tag[19:16] ^ meta_3_0_tag[23:20]
           ^ meta_3_0_tag[27:24] ^ meta_3_0_tag[31:28] ^ meta_3_0_tag[35:32]
           ^ meta_3_1_tag[3:0] ^ meta_3_1_tag[7:4] ^ meta_3_1_tag[11:8]
           ^ meta_3_1_tag[15:12] ^ meta_3_1_tag[19:16] ^ meta_3_1_tag[23:20]
           ^ meta_3_1_tag[27:24] ^ meta_3_1_tag[31:28] ^ meta_3_1_tag[35:32]
           ^ meta_3_2_tag[3:0] ^ meta_3_2_tag[7:4] ^ meta_3_2_tag[11:8]
           ^ meta_3_2_tag[15:12] ^ meta_3_2_tag[19:16] ^ meta_3_2_tag[23:20]
           ^ meta_3_2_tag[27:24] ^ meta_3_2_tag[31:28] ^ meta_3_2_tag[35:32]
           ^ meta_3_3_tag[3:0] ^ meta_3_3_tag[7:4] ^ meta_3_3_tag[11:8]
           ^ meta_3_3_tag[15:12] ^ meta_3_3_tag[19:16] ^ meta_3_3_tag[23:20]
           ^ meta_3_3_tag[27:24] ^ meta_3_3_tag[31:28] ^ meta_3_3_tag[35:32]
           ^ meta_4_0_tag[3:0] ^ meta_4_0_tag[7:4] ^ meta_4_0_tag[11:8]
           ^ meta_4_0_tag[15:12] ^ meta_4_0_tag[19:16] ^ meta_4_0_tag[23:20]
           ^ meta_4_0_tag[27:24] ^ meta_4_0_tag[31:28] ^ meta_4_0_tag[35:32]
           ^ meta_4_1_tag[3:0] ^ meta_4_1_tag[7:4] ^ meta_4_1_tag[11:8]
           ^ meta_4_1_tag[15:12] ^ meta_4_1_tag[19:16] ^ meta_4_1_tag[23:20]
           ^ meta_4_1_tag[27:24] ^ meta_4_1_tag[31:28] ^ meta_4_1_tag[35:32]
           ^ meta_4_2_tag[3:0] ^ meta_4_2_tag[7:4] ^ meta_4_2_tag[11:8]
           ^ meta_4_2_tag[15:12] ^ meta_4_2_tag[19:16] ^ meta_4_2_tag[23:20]
           ^ meta_4_2_tag[27:24] ^ meta_4_2_tag[31:28] ^ meta_4_2_tag[35:32]
           ^ meta_4_3_tag[3:0] ^ meta_4_3_tag[7:4] ^ meta_4_3_tag[11:8]
           ^ meta_4_3_tag[15:12] ^ meta_4_3_tag[19:16] ^ meta_4_3_tag[23:20]
           ^ meta_4_3_tag[27:24] ^ meta_4_3_tag[31:28] ^ meta_4_3_tag[35:32]
           ^ meta_5_0_tag[3:0] ^ meta_5_0_tag[7:4] ^ meta_5_0_tag[11:8]
           ^ meta_5_0_tag[15:12] ^ meta_5_0_tag[19:16] ^ meta_5_0_tag[23:20]
           ^ meta_5_0_tag[27:24] ^ meta_5_0_tag[31:28] ^ meta_5_0_tag[35:32]
           ^ meta_5_1_tag[3:0] ^ meta_5_1_tag[7:4] ^ meta_5_1_tag[11:8]
           ^ meta_5_1_tag[15:12] ^ meta_5_1_tag[19:16] ^ meta_5_1_tag[23:20]
           ^ meta_5_1_tag[27:24] ^ meta_5_1_tag[31:28] ^ meta_5_1_tag[35:32]
           ^ meta_5_2_tag[3:0] ^ meta_5_2_tag[7:4] ^ meta_5_2_tag[11:8]
           ^ meta_5_2_tag[15:12] ^ meta_5_2_tag[19:16] ^ meta_5_2_tag[23:20]
           ^ meta_5_2_tag[27:24] ^ meta_5_2_tag[31:28] ^ meta_5_2_tag[35:32]
           ^ meta_5_3_tag[3:0] ^ meta_5_3_tag[7:4] ^ meta_5_3_tag[11:8]
           ^ meta_5_3_tag[15:12] ^ meta_5_3_tag[19:16] ^ meta_5_3_tag[23:20]
           ^ meta_5_3_tag[27:24] ^ meta_5_3_tag[31:28] ^ meta_5_3_tag[35:32]
           ^ meta_6_0_tag[3:0] ^ meta_6_0_tag[7:4] ^ meta_6_0_tag[11:8]
           ^ meta_6_0_tag[15:12] ^ meta_6_0_tag[19:16] ^ meta_6_0_tag[23:20]
           ^ meta_6_0_tag[27:24] ^ meta_6_0_tag[31:28] ^ meta_6_0_tag[35:32]
           ^ meta_6_1_tag[3:0] ^ meta_6_1_tag[7:4] ^ meta_6_1_tag[11:8]
           ^ meta_6_1_tag[15:12] ^ meta_6_1_tag[19:16] ^ meta_6_1_tag[23:20]
           ^ meta_6_1_tag[27:24] ^ meta_6_1_tag[31:28] ^ meta_6_1_tag[35:32]
           ^ meta_6_2_tag[3:0] ^ meta_6_2_tag[7:4] ^ meta_6_2_tag[11:8]
           ^ meta_6_2_tag[15:12] ^ meta_6_2_tag[19:16] ^ meta_6_2_tag[23:20]
           ^ meta_6_2_tag[27:24] ^ meta_6_2_tag[31:28] ^ meta_6_2_tag[35:32]
           ^ meta_6_3_tag[3:0] ^ meta_6_3_tag[7:4] ^ meta_6_3_tag[11:8]
           ^ meta_6_3_tag[15:12] ^ meta_6_3_tag[19:16] ^ meta_6_3_tag[23:20]
           ^ meta_6_3_tag[27:24] ^ meta_6_3_tag[31:28] ^ meta_6_3_tag[35:32]
           ^ meta_7_0_tag[3:0] ^ meta_7_0_tag[7:4] ^ meta_7_0_tag[11:8]
           ^ meta_7_0_tag[15:12] ^ meta_7_0_tag[19:16] ^ meta_7_0_tag[23:20]
           ^ meta_7_0_tag[27:24] ^ meta_7_0_tag[31:28] ^ meta_7_0_tag[35:32]
           ^ meta_7_1_tag[3:0] ^ meta_7_1_tag[7:4] ^ meta_7_1_tag[11:8]
           ^ meta_7_1_tag[15:12] ^ meta_7_1_tag[19:16] ^ meta_7_1_tag[23:20]
           ^ meta_7_1_tag[27:24] ^ meta_7_1_tag[31:28] ^ meta_7_1_tag[35:32]
           ^ meta_7_2_tag[3:0] ^ meta_7_2_tag[7:4] ^ meta_7_2_tag[11:8]
           ^ meta_7_2_tag[15:12] ^ meta_7_2_tag[19:16] ^ meta_7_2_tag[23:20]
           ^ meta_7_2_tag[27:24] ^ meta_7_2_tag[31:28] ^ meta_7_2_tag[35:32]
           ^ meta_7_3_tag[3:0] ^ meta_7_3_tag[7:4] ^ meta_7_3_tag[11:8]
           ^ meta_7_3_tag[15:12] ^ meta_7_3_tag[19:16] ^ meta_7_3_tag[23:20]
           ^ meta_7_3_tag[27:24] ^ meta_7_3_tag[31:28] ^ meta_7_3_tag[35:32]
           ^ meta_8_0_tag[3:0] ^ meta_8_0_tag[7:4] ^ meta_8_0_tag[11:8]
           ^ meta_8_0_tag[15:12] ^ meta_8_0_tag[19:16] ^ meta_8_0_tag[23:20]
           ^ meta_8_0_tag[27:24] ^ meta_8_0_tag[31:28] ^ meta_8_0_tag[35:32]
           ^ meta_8_1_tag[3:0] ^ meta_8_1_tag[7:4] ^ meta_8_1_tag[11:8]
           ^ meta_8_1_tag[15:12] ^ meta_8_1_tag[19:16] ^ meta_8_1_tag[23:20]
           ^ meta_8_1_tag[27:24] ^ meta_8_1_tag[31:28] ^ meta_8_1_tag[35:32]
           ^ meta_8_2_tag[3:0] ^ meta_8_2_tag[7:4] ^ meta_8_2_tag[11:8]
           ^ meta_8_2_tag[15:12] ^ meta_8_2_tag[19:16] ^ meta_8_2_tag[23:20]
           ^ meta_8_2_tag[27:24] ^ meta_8_2_tag[31:28] ^ meta_8_2_tag[35:32]
           ^ meta_8_3_tag[3:0] ^ meta_8_3_tag[7:4] ^ meta_8_3_tag[11:8]
           ^ meta_8_3_tag[15:12] ^ meta_8_3_tag[19:16] ^ meta_8_3_tag[23:20]
           ^ meta_8_3_tag[27:24] ^ meta_8_3_tag[31:28] ^ meta_8_3_tag[35:32]
           ^ meta_9_0_tag[3:0] ^ meta_9_0_tag[7:4] ^ meta_9_0_tag[11:8]
           ^ meta_9_0_tag[15:12] ^ meta_9_0_tag[19:16] ^ meta_9_0_tag[23:20]
           ^ meta_9_0_tag[27:24] ^ meta_9_0_tag[31:28] ^ meta_9_0_tag[35:32]
           ^ meta_9_1_tag[3:0] ^ meta_9_1_tag[7:4] ^ meta_9_1_tag[11:8]
           ^ meta_9_1_tag[15:12] ^ meta_9_1_tag[19:16] ^ meta_9_1_tag[23:20]
           ^ meta_9_1_tag[27:24] ^ meta_9_1_tag[31:28] ^ meta_9_1_tag[35:32]
           ^ meta_9_2_tag[3:0] ^ meta_9_2_tag[7:4] ^ meta_9_2_tag[11:8]
           ^ meta_9_2_tag[15:12] ^ meta_9_2_tag[19:16] ^ meta_9_2_tag[23:20]
           ^ meta_9_2_tag[27:24] ^ meta_9_2_tag[31:28] ^ meta_9_2_tag[35:32]
           ^ meta_9_3_tag[3:0] ^ meta_9_3_tag[7:4] ^ meta_9_3_tag[11:8]
           ^ meta_9_3_tag[15:12] ^ meta_9_3_tag[19:16] ^ meta_9_3_tag[23:20]
           ^ meta_9_3_tag[27:24] ^ meta_9_3_tag[31:28] ^ meta_9_3_tag[35:32]
           ^ meta_10_0_tag[3:0] ^ meta_10_0_tag[7:4] ^ meta_10_0_tag[11:8]
           ^ meta_10_0_tag[15:12] ^ meta_10_0_tag[19:16] ^ meta_10_0_tag[23:20]
           ^ meta_10_0_tag[27:24] ^ meta_10_0_tag[31:28] ^ meta_10_0_tag[35:32]
           ^ meta_10_1_tag[3:0] ^ meta_10_1_tag[7:4] ^ meta_10_1_tag[11:8]
           ^ meta_10_1_tag[15:12] ^ meta_10_1_tag[19:16] ^ meta_10_1_tag[23:20]
           ^ meta_10_1_tag[27:24] ^ meta_10_1_tag[31:28] ^ meta_10_1_tag[35:32]
           ^ meta_10_2_tag[3:0] ^ meta_10_2_tag[7:4] ^ meta_10_2_tag[11:8]
           ^ meta_10_2_tag[15:12] ^ meta_10_2_tag[19:16] ^ meta_10_2_tag[23:20]
           ^ meta_10_2_tag[27:24] ^ meta_10_2_tag[31:28] ^ meta_10_2_tag[35:32]
           ^ meta_10_3_tag[3:0] ^ meta_10_3_tag[7:4] ^ meta_10_3_tag[11:8]
           ^ meta_10_3_tag[15:12] ^ meta_10_3_tag[19:16] ^ meta_10_3_tag[23:20]
           ^ meta_10_3_tag[27:24] ^ meta_10_3_tag[31:28] ^ meta_10_3_tag[35:32]
           ^ meta_11_0_tag[3:0] ^ meta_11_0_tag[7:4] ^ meta_11_0_tag[11:8]
           ^ meta_11_0_tag[15:12] ^ meta_11_0_tag[19:16] ^ meta_11_0_tag[23:20]
           ^ meta_11_0_tag[27:24] ^ meta_11_0_tag[31:28] ^ meta_11_0_tag[35:32]
           ^ meta_11_1_tag[3:0] ^ meta_11_1_tag[7:4] ^ meta_11_1_tag[11:8]
           ^ meta_11_1_tag[15:12] ^ meta_11_1_tag[19:16] ^ meta_11_1_tag[23:20]
           ^ meta_11_1_tag[27:24] ^ meta_11_1_tag[31:28] ^ meta_11_1_tag[35:32]
           ^ meta_11_2_tag[3:0] ^ meta_11_2_tag[7:4] ^ meta_11_2_tag[11:8]
           ^ meta_11_2_tag[15:12] ^ meta_11_2_tag[19:16] ^ meta_11_2_tag[23:20]
           ^ meta_11_2_tag[27:24] ^ meta_11_2_tag[31:28] ^ meta_11_2_tag[35:32]
           ^ meta_11_3_tag[3:0] ^ meta_11_3_tag[7:4] ^ meta_11_3_tag[11:8]
           ^ meta_11_3_tag[15:12] ^ meta_11_3_tag[19:16] ^ meta_11_3_tag[23:20]
           ^ meta_11_3_tag[27:24] ^ meta_11_3_tag[31:28] ^ meta_11_3_tag[35:32]
           ^ meta_12_0_tag[3:0] ^ meta_12_0_tag[7:4] ^ meta_12_0_tag[11:8]
           ^ meta_12_0_tag[15:12] ^ meta_12_0_tag[19:16] ^ meta_12_0_tag[23:20]
           ^ meta_12_0_tag[27:24] ^ meta_12_0_tag[31:28] ^ meta_12_0_tag[35:32]
           ^ meta_12_1_tag[3:0] ^ meta_12_1_tag[7:4] ^ meta_12_1_tag[11:8]
           ^ meta_12_1_tag[15:12] ^ meta_12_1_tag[19:16] ^ meta_12_1_tag[23:20]
           ^ meta_12_1_tag[27:24] ^ meta_12_1_tag[31:28] ^ meta_12_1_tag[35:32]
           ^ meta_12_2_tag[3:0] ^ meta_12_2_tag[7:4] ^ meta_12_2_tag[11:8]
           ^ meta_12_2_tag[15:12] ^ meta_12_2_tag[19:16] ^ meta_12_2_tag[23:20]
           ^ meta_12_2_tag[27:24] ^ meta_12_2_tag[31:28] ^ meta_12_2_tag[35:32]
           ^ meta_12_3_tag[3:0] ^ meta_12_3_tag[7:4] ^ meta_12_3_tag[11:8]
           ^ meta_12_3_tag[15:12] ^ meta_12_3_tag[19:16] ^ meta_12_3_tag[23:20]
           ^ meta_12_3_tag[27:24] ^ meta_12_3_tag[31:28] ^ meta_12_3_tag[35:32]
           ^ meta_13_0_tag[3:0] ^ meta_13_0_tag[7:4] ^ meta_13_0_tag[11:8]
           ^ meta_13_0_tag[15:12] ^ meta_13_0_tag[19:16] ^ meta_13_0_tag[23:20]
           ^ meta_13_0_tag[27:24] ^ meta_13_0_tag[31:28] ^ meta_13_0_tag[35:32]
           ^ meta_13_1_tag[3:0] ^ meta_13_1_tag[7:4] ^ meta_13_1_tag[11:8]
           ^ meta_13_1_tag[15:12] ^ meta_13_1_tag[19:16] ^ meta_13_1_tag[23:20]
           ^ meta_13_1_tag[27:24] ^ meta_13_1_tag[31:28] ^ meta_13_1_tag[35:32]
           ^ meta_13_2_tag[3:0] ^ meta_13_2_tag[7:4] ^ meta_13_2_tag[11:8]
           ^ meta_13_2_tag[15:12] ^ meta_13_2_tag[19:16] ^ meta_13_2_tag[23:20]
           ^ meta_13_2_tag[27:24] ^ meta_13_2_tag[31:28] ^ meta_13_2_tag[35:32]
           ^ meta_13_3_tag[3:0] ^ meta_13_3_tag[7:4] ^ meta_13_3_tag[11:8]
           ^ meta_13_3_tag[15:12] ^ meta_13_3_tag[19:16] ^ meta_13_3_tag[23:20]
           ^ meta_13_3_tag[27:24] ^ meta_13_3_tag[31:28] ^ meta_13_3_tag[35:32]
           ^ meta_14_0_tag[3:0] ^ meta_14_0_tag[7:4] ^ meta_14_0_tag[11:8]
           ^ meta_14_0_tag[15:12] ^ meta_14_0_tag[19:16] ^ meta_14_0_tag[23:20]
           ^ meta_14_0_tag[27:24] ^ meta_14_0_tag[31:28] ^ meta_14_0_tag[35:32]
           ^ meta_14_1_tag[3:0] ^ meta_14_1_tag[7:4] ^ meta_14_1_tag[11:8]
           ^ meta_14_1_tag[15:12] ^ meta_14_1_tag[19:16] ^ meta_14_1_tag[23:20]
           ^ meta_14_1_tag[27:24] ^ meta_14_1_tag[31:28] ^ meta_14_1_tag[35:32]
           ^ meta_14_2_tag[3:0] ^ meta_14_2_tag[7:4] ^ meta_14_2_tag[11:8]
           ^ meta_14_2_tag[15:12] ^ meta_14_2_tag[19:16] ^ meta_14_2_tag[23:20]
           ^ meta_14_2_tag[27:24] ^ meta_14_2_tag[31:28] ^ meta_14_2_tag[35:32]
           ^ meta_14_3_tag[3:0] ^ meta_14_3_tag[7:4] ^ meta_14_3_tag[11:8]
           ^ meta_14_3_tag[15:12] ^ meta_14_3_tag[19:16] ^ meta_14_3_tag[23:20]
           ^ meta_14_3_tag[27:24] ^ meta_14_3_tag[31:28] ^ meta_14_3_tag[35:32]
           ^ meta_15_0_tag[3:0] ^ meta_15_0_tag[7:4] ^ meta_15_0_tag[11:8]
           ^ meta_15_0_tag[15:12] ^ meta_15_0_tag[19:16] ^ meta_15_0_tag[23:20]
           ^ meta_15_0_tag[27:24] ^ meta_15_0_tag[31:28] ^ meta_15_0_tag[35:32]
           ^ meta_15_1_tag[3:0] ^ meta_15_1_tag[7:4] ^ meta_15_1_tag[11:8]
           ^ meta_15_1_tag[15:12] ^ meta_15_1_tag[19:16] ^ meta_15_1_tag[23:20]
           ^ meta_15_1_tag[27:24] ^ meta_15_1_tag[31:28] ^ meta_15_1_tag[35:32]
           ^ meta_15_2_tag[3:0] ^ meta_15_2_tag[7:4] ^ meta_15_2_tag[11:8]
           ^ meta_15_2_tag[15:12] ^ meta_15_2_tag[19:16] ^ meta_15_2_tag[23:20]
           ^ meta_15_2_tag[27:24] ^ meta_15_2_tag[31:28] ^ meta_15_2_tag[35:32]
           ^ meta_15_3_tag[3:0] ^ meta_15_3_tag[7:4] ^ meta_15_3_tag[11:8]
           ^ meta_15_3_tag[15:12] ^ meta_15_3_tag[19:16] ^ meta_15_3_tag[23:20]
           ^ meta_15_3_tag[27:24] ^ meta_15_3_tag[31:28] ^ meta_15_3_tag[35:32]};	// Bitwise.scala:72:12, Mux.scala:47:69, OneHot.scala:47:40, faubtb.scala:57:25, :75:55, :81:39, :93:14, :95:20, :97:{27,44}, :98:54, :110:{32,41}, :131:56, predictor.scala:163:29
    io_f3_meta_REG_1 <= io_f3_meta_REG;	// faubtb.scala:110:{24,32}
    if (reset) begin
      meta_0_0_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_0_0_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_0_0_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_0_1_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_0_1_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_0_1_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_0_2_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_0_2_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_0_2_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_0_3_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_0_3_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_0_3_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_1_0_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_1_0_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_1_0_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_1_1_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_1_1_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_1_1_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_1_2_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_1_2_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_1_2_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_1_3_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_1_3_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_1_3_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_2_0_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_2_0_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_2_0_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_2_1_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_2_1_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_2_1_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_2_2_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_2_2_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_2_2_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_2_3_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_2_3_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_2_3_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_3_0_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_3_0_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_3_0_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_3_1_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_3_1_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_3_1_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_3_2_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_3_2_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_3_2_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_3_3_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_3_3_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_3_3_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_4_0_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_4_0_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_4_0_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_4_1_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_4_1_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_4_1_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_4_2_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_4_2_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_4_2_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_4_3_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_4_3_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_4_3_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_5_0_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_5_0_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_5_0_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_5_1_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_5_1_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_5_1_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_5_2_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_5_2_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_5_2_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_5_3_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_5_3_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_5_3_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_6_0_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_6_0_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_6_0_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_6_1_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_6_1_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_6_1_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_6_2_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_6_2_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_6_2_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_6_3_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_6_3_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_6_3_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_7_0_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_7_0_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_7_0_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_7_1_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_7_1_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_7_1_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_7_2_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_7_2_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_7_2_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_7_3_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_7_3_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_7_3_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_8_0_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_8_0_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_8_0_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_8_1_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_8_1_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_8_1_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_8_2_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_8_2_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_8_2_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_8_3_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_8_3_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_8_3_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_9_0_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_9_0_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_9_0_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_9_1_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_9_1_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_9_1_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_9_2_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_9_2_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_9_2_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_9_3_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_9_3_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_9_3_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_10_0_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_10_0_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_10_0_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_10_1_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_10_1_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_10_1_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_10_2_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_10_2_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_10_2_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_10_3_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_10_3_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_10_3_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_11_0_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_11_0_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_11_0_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_11_1_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_11_1_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_11_1_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_11_2_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_11_2_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_11_2_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_11_3_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_11_3_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_11_3_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_12_0_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_12_0_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_12_0_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_12_1_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_12_1_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_12_1_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_12_2_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_12_2_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_12_2_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_12_3_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_12_3_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_12_3_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_13_0_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_13_0_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_13_0_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_13_1_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_13_1_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_13_1_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_13_2_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_13_2_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_13_2_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_13_3_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_13_3_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_13_3_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_14_0_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_14_0_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_14_0_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_14_1_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_14_1_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_14_1_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_14_2_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_14_2_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_14_2_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_14_3_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_14_3_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_14_3_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_15_0_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_15_0_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_15_0_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_15_1_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_15_1_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_15_1_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_15_2_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_15_2_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_15_2_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
      meta_15_3_is_br <= 1'h0;	// faubtb.scala:57:25, predictor.scala:160:14
      meta_15_3_tag <= 36'h0;	// faubtb.scala:57:{25,40}
      meta_15_3_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
    end
    else begin
      automatic logic       _GEN_30;	// faubtb.scala:136:27
      automatic logic       _GEN_31;	// faubtb.scala:136:62
      automatic logic       was_taken;	// faubtb.scala:139:82
      automatic logic [1:0] _GEN_32;	// faubtb.scala:142:42
      automatic logic [1:0] _meta_0_ctr_T_1;	// faubtb.scala:145:12
      automatic logic       _meta_0_ctr_T_2;	// faubtb.scala:31:28
      automatic logic       _meta_0_ctr_T_4;	// faubtb.scala:32:30
      automatic logic [1:0] _meta_0_ctr_T_5;	// faubtb.scala:33:20
      automatic logic [1:0] _meta_0_ctr_T_7;	// faubtb.scala:33:29
      automatic logic       _was_taken_T_3;	// faubtb.scala:138:28
      automatic logic       _GEN_33;	// faubtb.scala:136:62
      automatic logic       was_taken_1;	// faubtb.scala:139:82
      automatic logic [1:0] _GEN_34;	// faubtb.scala:142:42
      automatic logic [1:0] _meta_1_ctr_T_1;	// faubtb.scala:145:12
      automatic logic       _meta_1_ctr_T_2;	// faubtb.scala:31:28
      automatic logic       _meta_1_ctr_T_4;	// faubtb.scala:32:30
      automatic logic [1:0] _meta_1_ctr_T_5;	// faubtb.scala:33:20
      automatic logic [1:0] _meta_1_ctr_T_7;	// faubtb.scala:33:29
      automatic logic       _was_taken_T_6;	// faubtb.scala:138:28
      automatic logic       _GEN_35;	// faubtb.scala:136:62
      automatic logic       was_taken_2;	// faubtb.scala:139:82
      automatic logic [1:0] _GEN_36;	// faubtb.scala:142:42
      automatic logic [1:0] _meta_2_ctr_T_1;	// faubtb.scala:145:12
      automatic logic       _meta_2_ctr_T_2;	// faubtb.scala:31:28
      automatic logic       _meta_2_ctr_T_4;	// faubtb.scala:32:30
      automatic logic [1:0] _meta_2_ctr_T_5;	// faubtb.scala:33:20
      automatic logic [1:0] _meta_2_ctr_T_7;	// faubtb.scala:33:29
      automatic logic       _GEN_37;	// faubtb.scala:136:62
      automatic logic       was_taken_3;	// faubtb.scala:139:82
      automatic logic [1:0] _GEN_38;	// faubtb.scala:142:42
      automatic logic [1:0] _meta_3_ctr_T_1;	// faubtb.scala:145:12
      automatic logic       _meta_3_ctr_T_2;	// faubtb.scala:31:28
      automatic logic       _meta_3_ctr_T_4;	// faubtb.scala:32:30
      automatic logic [1:0] _meta_3_ctr_T_5;	// faubtb.scala:33:20
      automatic logic [1:0] _meta_3_ctr_T_7;	// faubtb.scala:33:29
      _GEN_30 = s1_update_valid & ~_GEN_11;	// faubtb.scala:136:27, predictor.scala:96:{26,69}, :184:30
      _GEN_31 =
        _GEN_30
        & (s1_update_bits_br_mask[0] | ~(|s1_update_bits_cfi_idx_bits)
           & s1_update_bits_cfi_taken & s1_update_bits_cfi_idx_valid);	// faubtb.scala:131:56, :136:{27,62}, :137:{30,34}, :138:{28,64}, predictor.scala:184:30
      was_taken =
        ~(|s1_update_bits_cfi_idx_bits) & s1_update_bits_cfi_idx_valid
        & (s1_update_bits_cfi_taken | s1_update_bits_cfi_is_jal);	// faubtb.scala:131:56, :138:28, :139:82, :140:35, predictor.scala:184:30
      _GEN_32 = _GEN_1[s1_update_bits_meta[3:0]];	// faubtb.scala:82:42, :113:55, :142:42, predictor.scala:184:30
      _meta_0_ctr_T_1 = {2{was_taken}};	// faubtb.scala:139:82, :145:12
      _meta_0_ctr_T_2 = (&_GEN_32) & was_taken;	// faubtb.scala:29:32, :31:28, :139:82, :142:42
      _meta_0_ctr_T_4 = _GEN_32 == 2'h0 & ~was_taken;	// faubtb.scala:30:32, :32:{30,33}, :57:40, :139:82, :142:42
      _meta_0_ctr_T_5 = _GEN_32 + 2'h1;	// faubtb.scala:33:20, :131:56, :142:42
      _meta_0_ctr_T_7 = _GEN_32 - 2'h1;	// faubtb.scala:33:29, :142:42
      _was_taken_T_3 = s1_update_bits_cfi_idx_bits == 2'h1;	// faubtb.scala:131:56, :138:28, predictor.scala:184:30
      _GEN_33 =
        _GEN_30
        & (s1_update_bits_br_mask[1] | _was_taken_T_3 & s1_update_bits_cfi_taken
           & s1_update_bits_cfi_idx_valid);	// faubtb.scala:136:{27,62}, :137:{30,34}, :138:{28,64}, predictor.scala:184:30
      was_taken_1 =
        _was_taken_T_3 & s1_update_bits_cfi_idx_valid
        & (s1_update_bits_cfi_taken | s1_update_bits_cfi_is_jal);	// faubtb.scala:138:28, :139:82, :140:35, predictor.scala:184:30
      _GEN_34 = _GEN_4[s1_update_bits_meta[3:0]];	// faubtb.scala:82:42, :113:55, :142:42, predictor.scala:184:30
      _meta_1_ctr_T_1 = {2{was_taken_1}};	// faubtb.scala:139:82, :145:12
      _meta_1_ctr_T_2 = (&_GEN_34) & was_taken_1;	// faubtb.scala:29:32, :31:28, :139:82, :142:42
      _meta_1_ctr_T_4 = _GEN_34 == 2'h0 & ~was_taken_1;	// faubtb.scala:30:32, :32:{30,33}, :57:40, :139:82, :142:42
      _meta_1_ctr_T_5 = _GEN_34 + 2'h1;	// faubtb.scala:33:20, :131:56, :142:42
      _meta_1_ctr_T_7 = _GEN_34 - 2'h1;	// faubtb.scala:33:29, :142:42
      _was_taken_T_6 = s1_update_bits_cfi_idx_bits == 2'h2;	// Mux.scala:47:69, faubtb.scala:138:28, predictor.scala:184:30
      _GEN_35 =
        _GEN_30
        & (s1_update_bits_br_mask[2] | _was_taken_T_6 & s1_update_bits_cfi_taken
           & s1_update_bits_cfi_idx_valid);	// faubtb.scala:136:{27,62}, :137:{30,34}, :138:{28,64}, predictor.scala:184:30
      was_taken_2 =
        _was_taken_T_6 & s1_update_bits_cfi_idx_valid
        & (s1_update_bits_cfi_taken | s1_update_bits_cfi_is_jal);	// faubtb.scala:138:28, :139:82, :140:35, predictor.scala:184:30
      _GEN_36 = _GEN_7[s1_update_bits_meta[3:0]];	// faubtb.scala:82:42, :113:55, :142:42, predictor.scala:184:30
      _meta_2_ctr_T_1 = {2{was_taken_2}};	// faubtb.scala:139:82, :145:12
      _meta_2_ctr_T_2 = (&_GEN_36) & was_taken_2;	// faubtb.scala:29:32, :31:28, :139:82, :142:42
      _meta_2_ctr_T_4 = _GEN_36 == 2'h0 & ~was_taken_2;	// faubtb.scala:30:32, :32:{30,33}, :57:40, :139:82, :142:42
      _meta_2_ctr_T_5 = _GEN_36 + 2'h1;	// faubtb.scala:33:20, :131:56, :142:42
      _meta_2_ctr_T_7 = _GEN_36 - 2'h1;	// faubtb.scala:33:29, :142:42
      _GEN_37 =
        _GEN_30
        & (s1_update_bits_br_mask[3] | (&s1_update_bits_cfi_idx_bits)
           & s1_update_bits_cfi_taken & s1_update_bits_cfi_idx_valid);	// faubtb.scala:136:{27,62}, :137:{30,34}, :138:{28,64}, predictor.scala:184:30
      was_taken_3 =
        (&s1_update_bits_cfi_idx_bits) & s1_update_bits_cfi_idx_valid
        & (s1_update_bits_cfi_taken | s1_update_bits_cfi_is_jal);	// faubtb.scala:138:28, :139:82, :140:35, predictor.scala:184:30
      _GEN_38 = _GEN_10[s1_update_bits_meta[3:0]];	// faubtb.scala:82:42, :113:55, :142:42, predictor.scala:184:30
      _meta_3_ctr_T_1 = {2{was_taken_3}};	// faubtb.scala:139:82, :145:12
      _meta_3_ctr_T_2 = (&_GEN_38) & was_taken_3;	// faubtb.scala:29:32, :31:28, :139:82, :142:42
      _meta_3_ctr_T_4 = _GEN_38 == 2'h0 & ~was_taken_3;	// faubtb.scala:30:32, :32:{30,33}, :57:40, :139:82, :142:42
      _meta_3_ctr_T_5 = _GEN_38 + 2'h1;	// faubtb.scala:33:20, :131:56, :142:42
      _meta_3_ctr_T_7 = _GEN_38 - 2'h1;	// faubtb.scala:33:29, :142:42
      if (_GEN_31 & _GEN_13) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_0_0_is_br <= s1_update_bits_br_mask[0];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_0_0_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[4]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_0_ctr_T_2)	// faubtb.scala:31:28
            meta_0_0_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_0_ctr_T_4)	// faubtb.scala:32:30
            meta_0_0_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken)	// faubtb.scala:139:82
            meta_0_0_ctr <= _meta_0_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_0_0_ctr <= _meta_0_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_0_0_ctr <= _meta_0_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_33 & _GEN_13) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_0_1_is_br <= s1_update_bits_br_mask[1];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_0_1_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[5]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_1_ctr_T_2)	// faubtb.scala:31:28
            meta_0_1_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_1_ctr_T_4)	// faubtb.scala:32:30
            meta_0_1_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_1)	// faubtb.scala:139:82
            meta_0_1_ctr <= _meta_1_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_0_1_ctr <= _meta_1_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_0_1_ctr <= _meta_1_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_35 & _GEN_13) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_0_2_is_br <= s1_update_bits_br_mask[2];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_0_2_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[6]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_2_ctr_T_2)	// faubtb.scala:31:28
            meta_0_2_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_2_ctr_T_4)	// faubtb.scala:32:30
            meta_0_2_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_2)	// faubtb.scala:139:82
            meta_0_2_ctr <= _meta_2_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_0_2_ctr <= _meta_2_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_0_2_ctr <= _meta_2_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_37 & _GEN_13) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_0_3_is_br <= s1_update_bits_br_mask[3];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_0_3_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[7]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_3_ctr_T_2)	// faubtb.scala:31:28
            meta_0_3_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_3_ctr_T_4)	// faubtb.scala:32:30
            meta_0_3_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_3)	// faubtb.scala:139:82
            meta_0_3_ctr <= _meta_3_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_0_3_ctr <= _meta_3_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_0_3_ctr <= _meta_3_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_31 & _GEN_16) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_1_0_is_br <= s1_update_bits_br_mask[0];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_1_0_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[4]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_0_ctr_T_2)	// faubtb.scala:31:28
            meta_1_0_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_0_ctr_T_4)	// faubtb.scala:32:30
            meta_1_0_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken)	// faubtb.scala:139:82
            meta_1_0_ctr <= _meta_0_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_1_0_ctr <= _meta_0_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_1_0_ctr <= _meta_0_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_33 & _GEN_16) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_1_1_is_br <= s1_update_bits_br_mask[1];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_1_1_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[5]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_1_ctr_T_2)	// faubtb.scala:31:28
            meta_1_1_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_1_ctr_T_4)	// faubtb.scala:32:30
            meta_1_1_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_1)	// faubtb.scala:139:82
            meta_1_1_ctr <= _meta_1_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_1_1_ctr <= _meta_1_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_1_1_ctr <= _meta_1_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_35 & _GEN_16) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_1_2_is_br <= s1_update_bits_br_mask[2];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_1_2_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[6]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_2_ctr_T_2)	// faubtb.scala:31:28
            meta_1_2_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_2_ctr_T_4)	// faubtb.scala:32:30
            meta_1_2_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_2)	// faubtb.scala:139:82
            meta_1_2_ctr <= _meta_2_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_1_2_ctr <= _meta_2_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_1_2_ctr <= _meta_2_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_37 & _GEN_16) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_1_3_is_br <= s1_update_bits_br_mask[3];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_1_3_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[7]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_3_ctr_T_2)	// faubtb.scala:31:28
            meta_1_3_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_3_ctr_T_4)	// faubtb.scala:32:30
            meta_1_3_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_3)	// faubtb.scala:139:82
            meta_1_3_ctr <= _meta_3_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_1_3_ctr <= _meta_3_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_1_3_ctr <= _meta_3_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_31 & _GEN_17) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_2_0_is_br <= s1_update_bits_br_mask[0];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_2_0_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[4]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_0_ctr_T_2)	// faubtb.scala:31:28
            meta_2_0_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_0_ctr_T_4)	// faubtb.scala:32:30
            meta_2_0_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken)	// faubtb.scala:139:82
            meta_2_0_ctr <= _meta_0_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_2_0_ctr <= _meta_0_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_2_0_ctr <= _meta_0_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_33 & _GEN_17) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_2_1_is_br <= s1_update_bits_br_mask[1];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_2_1_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[5]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_1_ctr_T_2)	// faubtb.scala:31:28
            meta_2_1_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_1_ctr_T_4)	// faubtb.scala:32:30
            meta_2_1_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_1)	// faubtb.scala:139:82
            meta_2_1_ctr <= _meta_1_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_2_1_ctr <= _meta_1_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_2_1_ctr <= _meta_1_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_35 & _GEN_17) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_2_2_is_br <= s1_update_bits_br_mask[2];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_2_2_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[6]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_2_ctr_T_2)	// faubtb.scala:31:28
            meta_2_2_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_2_ctr_T_4)	// faubtb.scala:32:30
            meta_2_2_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_2)	// faubtb.scala:139:82
            meta_2_2_ctr <= _meta_2_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_2_2_ctr <= _meta_2_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_2_2_ctr <= _meta_2_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_37 & _GEN_17) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_2_3_is_br <= s1_update_bits_br_mask[3];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_2_3_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[7]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_3_ctr_T_2)	// faubtb.scala:31:28
            meta_2_3_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_3_ctr_T_4)	// faubtb.scala:32:30
            meta_2_3_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_3)	// faubtb.scala:139:82
            meta_2_3_ctr <= _meta_3_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_2_3_ctr <= _meta_3_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_2_3_ctr <= _meta_3_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_31 & _GEN_18) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_3_0_is_br <= s1_update_bits_br_mask[0];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_3_0_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[4]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_0_ctr_T_2)	// faubtb.scala:31:28
            meta_3_0_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_0_ctr_T_4)	// faubtb.scala:32:30
            meta_3_0_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken)	// faubtb.scala:139:82
            meta_3_0_ctr <= _meta_0_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_3_0_ctr <= _meta_0_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_3_0_ctr <= _meta_0_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_33 & _GEN_18) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_3_1_is_br <= s1_update_bits_br_mask[1];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_3_1_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[5]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_1_ctr_T_2)	// faubtb.scala:31:28
            meta_3_1_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_1_ctr_T_4)	// faubtb.scala:32:30
            meta_3_1_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_1)	// faubtb.scala:139:82
            meta_3_1_ctr <= _meta_1_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_3_1_ctr <= _meta_1_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_3_1_ctr <= _meta_1_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_35 & _GEN_18) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_3_2_is_br <= s1_update_bits_br_mask[2];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_3_2_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[6]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_2_ctr_T_2)	// faubtb.scala:31:28
            meta_3_2_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_2_ctr_T_4)	// faubtb.scala:32:30
            meta_3_2_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_2)	// faubtb.scala:139:82
            meta_3_2_ctr <= _meta_2_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_3_2_ctr <= _meta_2_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_3_2_ctr <= _meta_2_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_37 & _GEN_18) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_3_3_is_br <= s1_update_bits_br_mask[3];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_3_3_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[7]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_3_ctr_T_2)	// faubtb.scala:31:28
            meta_3_3_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_3_ctr_T_4)	// faubtb.scala:32:30
            meta_3_3_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_3)	// faubtb.scala:139:82
            meta_3_3_ctr <= _meta_3_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_3_3_ctr <= _meta_3_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_3_3_ctr <= _meta_3_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_31 & _GEN_19) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_4_0_is_br <= s1_update_bits_br_mask[0];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_4_0_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[4]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_0_ctr_T_2)	// faubtb.scala:31:28
            meta_4_0_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_0_ctr_T_4)	// faubtb.scala:32:30
            meta_4_0_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken)	// faubtb.scala:139:82
            meta_4_0_ctr <= _meta_0_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_4_0_ctr <= _meta_0_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_4_0_ctr <= _meta_0_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_33 & _GEN_19) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_4_1_is_br <= s1_update_bits_br_mask[1];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_4_1_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[5]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_1_ctr_T_2)	// faubtb.scala:31:28
            meta_4_1_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_1_ctr_T_4)	// faubtb.scala:32:30
            meta_4_1_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_1)	// faubtb.scala:139:82
            meta_4_1_ctr <= _meta_1_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_4_1_ctr <= _meta_1_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_4_1_ctr <= _meta_1_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_35 & _GEN_19) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_4_2_is_br <= s1_update_bits_br_mask[2];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_4_2_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[6]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_2_ctr_T_2)	// faubtb.scala:31:28
            meta_4_2_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_2_ctr_T_4)	// faubtb.scala:32:30
            meta_4_2_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_2)	// faubtb.scala:139:82
            meta_4_2_ctr <= _meta_2_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_4_2_ctr <= _meta_2_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_4_2_ctr <= _meta_2_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_37 & _GEN_19) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_4_3_is_br <= s1_update_bits_br_mask[3];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_4_3_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[7]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_3_ctr_T_2)	// faubtb.scala:31:28
            meta_4_3_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_3_ctr_T_4)	// faubtb.scala:32:30
            meta_4_3_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_3)	// faubtb.scala:139:82
            meta_4_3_ctr <= _meta_3_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_4_3_ctr <= _meta_3_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_4_3_ctr <= _meta_3_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_31 & _GEN_20) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_5_0_is_br <= s1_update_bits_br_mask[0];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_5_0_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[4]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_0_ctr_T_2)	// faubtb.scala:31:28
            meta_5_0_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_0_ctr_T_4)	// faubtb.scala:32:30
            meta_5_0_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken)	// faubtb.scala:139:82
            meta_5_0_ctr <= _meta_0_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_5_0_ctr <= _meta_0_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_5_0_ctr <= _meta_0_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_33 & _GEN_20) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_5_1_is_br <= s1_update_bits_br_mask[1];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_5_1_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[5]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_1_ctr_T_2)	// faubtb.scala:31:28
            meta_5_1_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_1_ctr_T_4)	// faubtb.scala:32:30
            meta_5_1_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_1)	// faubtb.scala:139:82
            meta_5_1_ctr <= _meta_1_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_5_1_ctr <= _meta_1_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_5_1_ctr <= _meta_1_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_35 & _GEN_20) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_5_2_is_br <= s1_update_bits_br_mask[2];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_5_2_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[6]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_2_ctr_T_2)	// faubtb.scala:31:28
            meta_5_2_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_2_ctr_T_4)	// faubtb.scala:32:30
            meta_5_2_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_2)	// faubtb.scala:139:82
            meta_5_2_ctr <= _meta_2_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_5_2_ctr <= _meta_2_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_5_2_ctr <= _meta_2_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_37 & _GEN_20) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_5_3_is_br <= s1_update_bits_br_mask[3];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_5_3_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[7]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_3_ctr_T_2)	// faubtb.scala:31:28
            meta_5_3_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_3_ctr_T_4)	// faubtb.scala:32:30
            meta_5_3_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_3)	// faubtb.scala:139:82
            meta_5_3_ctr <= _meta_3_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_5_3_ctr <= _meta_3_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_5_3_ctr <= _meta_3_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_31 & _GEN_21) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_6_0_is_br <= s1_update_bits_br_mask[0];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_6_0_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[4]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_0_ctr_T_2)	// faubtb.scala:31:28
            meta_6_0_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_0_ctr_T_4)	// faubtb.scala:32:30
            meta_6_0_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken)	// faubtb.scala:139:82
            meta_6_0_ctr <= _meta_0_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_6_0_ctr <= _meta_0_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_6_0_ctr <= _meta_0_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_33 & _GEN_21) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_6_1_is_br <= s1_update_bits_br_mask[1];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_6_1_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[5]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_1_ctr_T_2)	// faubtb.scala:31:28
            meta_6_1_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_1_ctr_T_4)	// faubtb.scala:32:30
            meta_6_1_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_1)	// faubtb.scala:139:82
            meta_6_1_ctr <= _meta_1_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_6_1_ctr <= _meta_1_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_6_1_ctr <= _meta_1_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_35 & _GEN_21) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_6_2_is_br <= s1_update_bits_br_mask[2];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_6_2_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[6]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_2_ctr_T_2)	// faubtb.scala:31:28
            meta_6_2_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_2_ctr_T_4)	// faubtb.scala:32:30
            meta_6_2_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_2)	// faubtb.scala:139:82
            meta_6_2_ctr <= _meta_2_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_6_2_ctr <= _meta_2_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_6_2_ctr <= _meta_2_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_37 & _GEN_21) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_6_3_is_br <= s1_update_bits_br_mask[3];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_6_3_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[7]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_3_ctr_T_2)	// faubtb.scala:31:28
            meta_6_3_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_3_ctr_T_4)	// faubtb.scala:32:30
            meta_6_3_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_3)	// faubtb.scala:139:82
            meta_6_3_ctr <= _meta_3_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_6_3_ctr <= _meta_3_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_6_3_ctr <= _meta_3_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_31 & _GEN_22) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_7_0_is_br <= s1_update_bits_br_mask[0];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_7_0_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[4]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_0_ctr_T_2)	// faubtb.scala:31:28
            meta_7_0_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_0_ctr_T_4)	// faubtb.scala:32:30
            meta_7_0_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken)	// faubtb.scala:139:82
            meta_7_0_ctr <= _meta_0_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_7_0_ctr <= _meta_0_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_7_0_ctr <= _meta_0_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_33 & _GEN_22) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_7_1_is_br <= s1_update_bits_br_mask[1];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_7_1_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[5]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_1_ctr_T_2)	// faubtb.scala:31:28
            meta_7_1_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_1_ctr_T_4)	// faubtb.scala:32:30
            meta_7_1_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_1)	// faubtb.scala:139:82
            meta_7_1_ctr <= _meta_1_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_7_1_ctr <= _meta_1_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_7_1_ctr <= _meta_1_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_35 & _GEN_22) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_7_2_is_br <= s1_update_bits_br_mask[2];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_7_2_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[6]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_2_ctr_T_2)	// faubtb.scala:31:28
            meta_7_2_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_2_ctr_T_4)	// faubtb.scala:32:30
            meta_7_2_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_2)	// faubtb.scala:139:82
            meta_7_2_ctr <= _meta_2_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_7_2_ctr <= _meta_2_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_7_2_ctr <= _meta_2_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_37 & _GEN_22) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_7_3_is_br <= s1_update_bits_br_mask[3];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_7_3_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[7]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_3_ctr_T_2)	// faubtb.scala:31:28
            meta_7_3_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_3_ctr_T_4)	// faubtb.scala:32:30
            meta_7_3_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_3)	// faubtb.scala:139:82
            meta_7_3_ctr <= _meta_3_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_7_3_ctr <= _meta_3_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_7_3_ctr <= _meta_3_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_31 & _GEN_23) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_8_0_is_br <= s1_update_bits_br_mask[0];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_8_0_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[4]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_0_ctr_T_2)	// faubtb.scala:31:28
            meta_8_0_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_0_ctr_T_4)	// faubtb.scala:32:30
            meta_8_0_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken)	// faubtb.scala:139:82
            meta_8_0_ctr <= _meta_0_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_8_0_ctr <= _meta_0_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_8_0_ctr <= _meta_0_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_33 & _GEN_23) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_8_1_is_br <= s1_update_bits_br_mask[1];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_8_1_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[5]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_1_ctr_T_2)	// faubtb.scala:31:28
            meta_8_1_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_1_ctr_T_4)	// faubtb.scala:32:30
            meta_8_1_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_1)	// faubtb.scala:139:82
            meta_8_1_ctr <= _meta_1_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_8_1_ctr <= _meta_1_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_8_1_ctr <= _meta_1_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_35 & _GEN_23) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_8_2_is_br <= s1_update_bits_br_mask[2];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_8_2_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[6]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_2_ctr_T_2)	// faubtb.scala:31:28
            meta_8_2_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_2_ctr_T_4)	// faubtb.scala:32:30
            meta_8_2_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_2)	// faubtb.scala:139:82
            meta_8_2_ctr <= _meta_2_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_8_2_ctr <= _meta_2_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_8_2_ctr <= _meta_2_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_37 & _GEN_23) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_8_3_is_br <= s1_update_bits_br_mask[3];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_8_3_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[7]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_3_ctr_T_2)	// faubtb.scala:31:28
            meta_8_3_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_3_ctr_T_4)	// faubtb.scala:32:30
            meta_8_3_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_3)	// faubtb.scala:139:82
            meta_8_3_ctr <= _meta_3_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_8_3_ctr <= _meta_3_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_8_3_ctr <= _meta_3_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_31 & _GEN_24) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_9_0_is_br <= s1_update_bits_br_mask[0];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_9_0_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[4]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_0_ctr_T_2)	// faubtb.scala:31:28
            meta_9_0_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_0_ctr_T_4)	// faubtb.scala:32:30
            meta_9_0_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken)	// faubtb.scala:139:82
            meta_9_0_ctr <= _meta_0_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_9_0_ctr <= _meta_0_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_9_0_ctr <= _meta_0_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_33 & _GEN_24) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_9_1_is_br <= s1_update_bits_br_mask[1];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_9_1_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[5]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_1_ctr_T_2)	// faubtb.scala:31:28
            meta_9_1_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_1_ctr_T_4)	// faubtb.scala:32:30
            meta_9_1_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_1)	// faubtb.scala:139:82
            meta_9_1_ctr <= _meta_1_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_9_1_ctr <= _meta_1_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_9_1_ctr <= _meta_1_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_35 & _GEN_24) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_9_2_is_br <= s1_update_bits_br_mask[2];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_9_2_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[6]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_2_ctr_T_2)	// faubtb.scala:31:28
            meta_9_2_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_2_ctr_T_4)	// faubtb.scala:32:30
            meta_9_2_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_2)	// faubtb.scala:139:82
            meta_9_2_ctr <= _meta_2_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_9_2_ctr <= _meta_2_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_9_2_ctr <= _meta_2_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_37 & _GEN_24) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_9_3_is_br <= s1_update_bits_br_mask[3];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_9_3_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[7]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_3_ctr_T_2)	// faubtb.scala:31:28
            meta_9_3_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_3_ctr_T_4)	// faubtb.scala:32:30
            meta_9_3_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_3)	// faubtb.scala:139:82
            meta_9_3_ctr <= _meta_3_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_9_3_ctr <= _meta_3_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_9_3_ctr <= _meta_3_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_31 & _GEN_25) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_10_0_is_br <= s1_update_bits_br_mask[0];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_10_0_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[4]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_0_ctr_T_2)	// faubtb.scala:31:28
            meta_10_0_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_0_ctr_T_4)	// faubtb.scala:32:30
            meta_10_0_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken)	// faubtb.scala:139:82
            meta_10_0_ctr <= _meta_0_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_10_0_ctr <= _meta_0_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_10_0_ctr <= _meta_0_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_33 & _GEN_25) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_10_1_is_br <= s1_update_bits_br_mask[1];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_10_1_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[5]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_1_ctr_T_2)	// faubtb.scala:31:28
            meta_10_1_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_1_ctr_T_4)	// faubtb.scala:32:30
            meta_10_1_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_1)	// faubtb.scala:139:82
            meta_10_1_ctr <= _meta_1_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_10_1_ctr <= _meta_1_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_10_1_ctr <= _meta_1_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_35 & _GEN_25) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_10_2_is_br <= s1_update_bits_br_mask[2];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_10_2_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[6]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_2_ctr_T_2)	// faubtb.scala:31:28
            meta_10_2_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_2_ctr_T_4)	// faubtb.scala:32:30
            meta_10_2_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_2)	// faubtb.scala:139:82
            meta_10_2_ctr <= _meta_2_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_10_2_ctr <= _meta_2_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_10_2_ctr <= _meta_2_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_37 & _GEN_25) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_10_3_is_br <= s1_update_bits_br_mask[3];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_10_3_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[7]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_3_ctr_T_2)	// faubtb.scala:31:28
            meta_10_3_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_3_ctr_T_4)	// faubtb.scala:32:30
            meta_10_3_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_3)	// faubtb.scala:139:82
            meta_10_3_ctr <= _meta_3_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_10_3_ctr <= _meta_3_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_10_3_ctr <= _meta_3_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_31 & _GEN_26) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_11_0_is_br <= s1_update_bits_br_mask[0];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_11_0_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[4]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_0_ctr_T_2)	// faubtb.scala:31:28
            meta_11_0_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_0_ctr_T_4)	// faubtb.scala:32:30
            meta_11_0_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken)	// faubtb.scala:139:82
            meta_11_0_ctr <= _meta_0_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_11_0_ctr <= _meta_0_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_11_0_ctr <= _meta_0_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_33 & _GEN_26) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_11_1_is_br <= s1_update_bits_br_mask[1];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_11_1_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[5]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_1_ctr_T_2)	// faubtb.scala:31:28
            meta_11_1_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_1_ctr_T_4)	// faubtb.scala:32:30
            meta_11_1_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_1)	// faubtb.scala:139:82
            meta_11_1_ctr <= _meta_1_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_11_1_ctr <= _meta_1_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_11_1_ctr <= _meta_1_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_35 & _GEN_26) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_11_2_is_br <= s1_update_bits_br_mask[2];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_11_2_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[6]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_2_ctr_T_2)	// faubtb.scala:31:28
            meta_11_2_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_2_ctr_T_4)	// faubtb.scala:32:30
            meta_11_2_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_2)	// faubtb.scala:139:82
            meta_11_2_ctr <= _meta_2_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_11_2_ctr <= _meta_2_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_11_2_ctr <= _meta_2_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_37 & _GEN_26) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_11_3_is_br <= s1_update_bits_br_mask[3];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_11_3_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[7]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_3_ctr_T_2)	// faubtb.scala:31:28
            meta_11_3_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_3_ctr_T_4)	// faubtb.scala:32:30
            meta_11_3_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_3)	// faubtb.scala:139:82
            meta_11_3_ctr <= _meta_3_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_11_3_ctr <= _meta_3_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_11_3_ctr <= _meta_3_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_31 & _GEN_27) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_12_0_is_br <= s1_update_bits_br_mask[0];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_12_0_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[4]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_0_ctr_T_2)	// faubtb.scala:31:28
            meta_12_0_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_0_ctr_T_4)	// faubtb.scala:32:30
            meta_12_0_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken)	// faubtb.scala:139:82
            meta_12_0_ctr <= _meta_0_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_12_0_ctr <= _meta_0_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_12_0_ctr <= _meta_0_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_33 & _GEN_27) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_12_1_is_br <= s1_update_bits_br_mask[1];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_12_1_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[5]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_1_ctr_T_2)	// faubtb.scala:31:28
            meta_12_1_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_1_ctr_T_4)	// faubtb.scala:32:30
            meta_12_1_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_1)	// faubtb.scala:139:82
            meta_12_1_ctr <= _meta_1_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_12_1_ctr <= _meta_1_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_12_1_ctr <= _meta_1_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_35 & _GEN_27) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_12_2_is_br <= s1_update_bits_br_mask[2];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_12_2_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[6]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_2_ctr_T_2)	// faubtb.scala:31:28
            meta_12_2_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_2_ctr_T_4)	// faubtb.scala:32:30
            meta_12_2_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_2)	// faubtb.scala:139:82
            meta_12_2_ctr <= _meta_2_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_12_2_ctr <= _meta_2_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_12_2_ctr <= _meta_2_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_37 & _GEN_27) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_12_3_is_br <= s1_update_bits_br_mask[3];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_12_3_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[7]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_3_ctr_T_2)	// faubtb.scala:31:28
            meta_12_3_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_3_ctr_T_4)	// faubtb.scala:32:30
            meta_12_3_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_3)	// faubtb.scala:139:82
            meta_12_3_ctr <= _meta_3_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_12_3_ctr <= _meta_3_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_12_3_ctr <= _meta_3_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_31 & _GEN_28) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_13_0_is_br <= s1_update_bits_br_mask[0];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_13_0_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[4]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_0_ctr_T_2)	// faubtb.scala:31:28
            meta_13_0_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_0_ctr_T_4)	// faubtb.scala:32:30
            meta_13_0_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken)	// faubtb.scala:139:82
            meta_13_0_ctr <= _meta_0_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_13_0_ctr <= _meta_0_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_13_0_ctr <= _meta_0_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_33 & _GEN_28) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_13_1_is_br <= s1_update_bits_br_mask[1];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_13_1_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[5]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_1_ctr_T_2)	// faubtb.scala:31:28
            meta_13_1_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_1_ctr_T_4)	// faubtb.scala:32:30
            meta_13_1_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_1)	// faubtb.scala:139:82
            meta_13_1_ctr <= _meta_1_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_13_1_ctr <= _meta_1_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_13_1_ctr <= _meta_1_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_35 & _GEN_28) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_13_2_is_br <= s1_update_bits_br_mask[2];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_13_2_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[6]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_2_ctr_T_2)	// faubtb.scala:31:28
            meta_13_2_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_2_ctr_T_4)	// faubtb.scala:32:30
            meta_13_2_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_2)	// faubtb.scala:139:82
            meta_13_2_ctr <= _meta_2_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_13_2_ctr <= _meta_2_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_13_2_ctr <= _meta_2_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_37 & _GEN_28) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_13_3_is_br <= s1_update_bits_br_mask[3];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_13_3_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[7]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_3_ctr_T_2)	// faubtb.scala:31:28
            meta_13_3_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_3_ctr_T_4)	// faubtb.scala:32:30
            meta_13_3_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_3)	// faubtb.scala:139:82
            meta_13_3_ctr <= _meta_3_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_13_3_ctr <= _meta_3_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_13_3_ctr <= _meta_3_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_31 & _GEN_29) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_14_0_is_br <= s1_update_bits_br_mask[0];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_14_0_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[4]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_0_ctr_T_2)	// faubtb.scala:31:28
            meta_14_0_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_0_ctr_T_4)	// faubtb.scala:32:30
            meta_14_0_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken)	// faubtb.scala:139:82
            meta_14_0_ctr <= _meta_0_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_14_0_ctr <= _meta_0_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_14_0_ctr <= _meta_0_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_33 & _GEN_29) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_14_1_is_br <= s1_update_bits_br_mask[1];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_14_1_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[5]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_1_ctr_T_2)	// faubtb.scala:31:28
            meta_14_1_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_1_ctr_T_4)	// faubtb.scala:32:30
            meta_14_1_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_1)	// faubtb.scala:139:82
            meta_14_1_ctr <= _meta_1_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_14_1_ctr <= _meta_1_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_14_1_ctr <= _meta_1_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_35 & _GEN_29) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_14_2_is_br <= s1_update_bits_br_mask[2];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_14_2_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[6]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_2_ctr_T_2)	// faubtb.scala:31:28
            meta_14_2_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_2_ctr_T_4)	// faubtb.scala:32:30
            meta_14_2_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_2)	// faubtb.scala:139:82
            meta_14_2_ctr <= _meta_2_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_14_2_ctr <= _meta_2_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_14_2_ctr <= _meta_2_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_37 & _GEN_29) begin	// faubtb.scala:57:25, :131:56, :136:62, :138:99, :142:42
        meta_14_3_is_br <= s1_update_bits_br_mask[3];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_14_3_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[7]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_3_ctr_T_2)	// faubtb.scala:31:28
            meta_14_3_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_3_ctr_T_4)	// faubtb.scala:32:30
            meta_14_3_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_3)	// faubtb.scala:139:82
            meta_14_3_ctr <= _meta_3_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_14_3_ctr <= _meta_3_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_14_3_ctr <= _meta_3_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_31 & (&(s1_update_bits_meta[3:0]))) begin	// faubtb.scala:57:25, :113:55, :131:56, :136:62, :138:99, :142:42, predictor.scala:184:30
        meta_15_0_is_br <= s1_update_bits_br_mask[0];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_15_0_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[4]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_0_ctr_T_2)	// faubtb.scala:31:28
            meta_15_0_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_0_ctr_T_4)	// faubtb.scala:32:30
            meta_15_0_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken)	// faubtb.scala:139:82
            meta_15_0_ctr <= _meta_0_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_15_0_ctr <= _meta_0_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_15_0_ctr <= _meta_0_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_33 & (&(s1_update_bits_meta[3:0]))) begin	// faubtb.scala:57:25, :113:55, :131:56, :136:62, :138:99, :142:42, predictor.scala:184:30
        meta_15_1_is_br <= s1_update_bits_br_mask[1];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_15_1_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[5]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_1_ctr_T_2)	// faubtb.scala:31:28
            meta_15_1_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_1_ctr_T_4)	// faubtb.scala:32:30
            meta_15_1_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_1)	// faubtb.scala:139:82
            meta_15_1_ctr <= _meta_1_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_15_1_ctr <= _meta_1_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_15_1_ctr <= _meta_1_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_35 & (&(s1_update_bits_meta[3:0]))) begin	// faubtb.scala:57:25, :113:55, :131:56, :136:62, :138:99, :142:42, predictor.scala:184:30
        meta_15_2_is_br <= s1_update_bits_br_mask[2];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_15_2_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[6]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_2_ctr_T_2)	// faubtb.scala:31:28
            meta_15_2_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_2_ctr_T_4)	// faubtb.scala:32:30
            meta_15_2_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_2)	// faubtb.scala:139:82
            meta_15_2_ctr <= _meta_2_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_15_2_ctr <= _meta_2_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_15_2_ctr <= _meta_2_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
      if (_GEN_37 & (&(s1_update_bits_meta[3:0]))) begin	// faubtb.scala:57:25, :113:55, :131:56, :136:62, :138:99, :142:42, predictor.scala:184:30
        meta_15_3_is_br <= s1_update_bits_br_mask[3];	// faubtb.scala:57:25, :137:30, predictor.scala:184:30
        meta_15_3_tag <= s1_update_idx;	// faubtb.scala:57:25, predictor.scala:185:30
        if (s1_update_bits_meta[7]) begin	// faubtb.scala:113:55, predictor.scala:184:30
          if (_meta_3_ctr_T_2)	// faubtb.scala:31:28
            meta_15_3_ctr <= 2'h3;	// Mux.scala:47:69, faubtb.scala:57:25
          else if (_meta_3_ctr_T_4)	// faubtb.scala:32:30
            meta_15_3_ctr <= 2'h0;	// faubtb.scala:57:{25,40}
          else if (was_taken_3)	// faubtb.scala:139:82
            meta_15_3_ctr <= _meta_3_ctr_T_5;	// faubtb.scala:33:20, :57:25
          else	// faubtb.scala:139:82
            meta_15_3_ctr <= _meta_3_ctr_T_7;	// faubtb.scala:33:29, :57:25
        end
        else	// faubtb.scala:113:55
          meta_15_3_ctr <= _meta_3_ctr_T_1;	// faubtb.scala:57:25, :145:12
      end
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:130];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [7:0] i = 8'h0; i < 8'h83; i += 8'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        s1_idx = {_RANDOM[8'h0], _RANDOM[8'h1][3:0]};	// predictor.scala:163:29
        s1_valid = _RANDOM[8'h3][12];	// predictor.scala:168:25
        s1_pc = {_RANDOM[8'h3][31:27], _RANDOM[8'h4], _RANDOM[8'h5][2:0]};	// predictor.scala:168:25, :178:22
        s1_update_valid = _RANDOM[8'h5][3];	// predictor.scala:178:22, :184:30
        s1_update_bits_is_mispredict_update = _RANDOM[8'h5][4];	// predictor.scala:178:22, :184:30
        s1_update_bits_is_repair_update = _RANDOM[8'h5][5];	// predictor.scala:178:22, :184:30
        s1_update_bits_btb_mispredicts = _RANDOM[8'h5][9:6];	// predictor.scala:178:22, :184:30
        s1_update_bits_pc = {_RANDOM[8'h5][31:10], _RANDOM[8'h6][17:0]};	// predictor.scala:178:22, :184:30
        s1_update_bits_br_mask = _RANDOM[8'h6][21:18];	// predictor.scala:184:30
        s1_update_bits_cfi_idx_valid = _RANDOM[8'h6][22];	// predictor.scala:184:30
        s1_update_bits_cfi_idx_bits = _RANDOM[8'h6][24:23];	// predictor.scala:184:30
        s1_update_bits_cfi_taken = _RANDOM[8'h6][25];	// predictor.scala:184:30
        s1_update_bits_cfi_is_jal = _RANDOM[8'h6][28];	// predictor.scala:184:30
        s1_update_bits_target = {_RANDOM[8'h8][31], _RANDOM[8'h9], _RANDOM[8'hA][6:0]};	// predictor.scala:184:30
        s1_update_bits_meta =
          {_RANDOM[8'hA][31:7], _RANDOM[8'hB], _RANDOM[8'hC], _RANDOM[8'hD][30:0]};	// predictor.scala:184:30
        s1_update_idx = {_RANDOM[8'hD][31], _RANDOM[8'hE], _RANDOM[8'hF][2:0]};	// predictor.scala:184:30, :185:30
        meta_0_0_is_br = _RANDOM[8'hF][4];	// faubtb.scala:57:25, predictor.scala:185:30
        meta_0_0_tag = {_RANDOM[8'hF][31:5], _RANDOM[8'h10][8:0]};	// faubtb.scala:57:25, predictor.scala:185:30
        meta_0_0_ctr = _RANDOM[8'h10][10:9];	// faubtb.scala:57:25
        meta_0_1_is_br = _RANDOM[8'h10][11];	// faubtb.scala:57:25
        meta_0_1_tag = {_RANDOM[8'h10][31:12], _RANDOM[8'h11][15:0]};	// faubtb.scala:57:25
        meta_0_1_ctr = _RANDOM[8'h11][17:16];	// faubtb.scala:57:25
        meta_0_2_is_br = _RANDOM[8'h11][18];	// faubtb.scala:57:25
        meta_0_2_tag = {_RANDOM[8'h11][31:19], _RANDOM[8'h12][22:0]};	// faubtb.scala:57:25
        meta_0_2_ctr = _RANDOM[8'h12][24:23];	// faubtb.scala:57:25
        meta_0_3_is_br = _RANDOM[8'h12][25];	// faubtb.scala:57:25
        meta_0_3_tag = {_RANDOM[8'h12][31:26], _RANDOM[8'h13][29:0]};	// faubtb.scala:57:25
        meta_0_3_ctr = _RANDOM[8'h13][31:30];	// faubtb.scala:57:25
        meta_1_0_is_br = _RANDOM[8'h14][0];	// faubtb.scala:57:25
        meta_1_0_tag = {_RANDOM[8'h14][31:1], _RANDOM[8'h15][4:0]};	// faubtb.scala:57:25
        meta_1_0_ctr = _RANDOM[8'h15][6:5];	// faubtb.scala:57:25
        meta_1_1_is_br = _RANDOM[8'h15][7];	// faubtb.scala:57:25
        meta_1_1_tag = {_RANDOM[8'h15][31:8], _RANDOM[8'h16][11:0]};	// faubtb.scala:57:25
        meta_1_1_ctr = _RANDOM[8'h16][13:12];	// faubtb.scala:57:25
        meta_1_2_is_br = _RANDOM[8'h16][14];	// faubtb.scala:57:25
        meta_1_2_tag = {_RANDOM[8'h16][31:15], _RANDOM[8'h17][18:0]};	// faubtb.scala:57:25
        meta_1_2_ctr = _RANDOM[8'h17][20:19];	// faubtb.scala:57:25
        meta_1_3_is_br = _RANDOM[8'h17][21];	// faubtb.scala:57:25
        meta_1_3_tag = {_RANDOM[8'h17][31:22], _RANDOM[8'h18][25:0]};	// faubtb.scala:57:25
        meta_1_3_ctr = _RANDOM[8'h18][27:26];	// faubtb.scala:57:25
        meta_2_0_is_br = _RANDOM[8'h18][28];	// faubtb.scala:57:25
        meta_2_0_tag = {_RANDOM[8'h18][31:29], _RANDOM[8'h19], _RANDOM[8'h1A][0]};	// faubtb.scala:57:25
        meta_2_0_ctr = _RANDOM[8'h1A][2:1];	// faubtb.scala:57:25
        meta_2_1_is_br = _RANDOM[8'h1A][3];	// faubtb.scala:57:25
        meta_2_1_tag = {_RANDOM[8'h1A][31:4], _RANDOM[8'h1B][7:0]};	// faubtb.scala:57:25
        meta_2_1_ctr = _RANDOM[8'h1B][9:8];	// faubtb.scala:57:25
        meta_2_2_is_br = _RANDOM[8'h1B][10];	// faubtb.scala:57:25
        meta_2_2_tag = {_RANDOM[8'h1B][31:11], _RANDOM[8'h1C][14:0]};	// faubtb.scala:57:25
        meta_2_2_ctr = _RANDOM[8'h1C][16:15];	// faubtb.scala:57:25
        meta_2_3_is_br = _RANDOM[8'h1C][17];	// faubtb.scala:57:25
        meta_2_3_tag = {_RANDOM[8'h1C][31:18], _RANDOM[8'h1D][21:0]};	// faubtb.scala:57:25
        meta_2_3_ctr = _RANDOM[8'h1D][23:22];	// faubtb.scala:57:25
        meta_3_0_is_br = _RANDOM[8'h1D][24];	// faubtb.scala:57:25
        meta_3_0_tag = {_RANDOM[8'h1D][31:25], _RANDOM[8'h1E][28:0]};	// faubtb.scala:57:25
        meta_3_0_ctr = _RANDOM[8'h1E][30:29];	// faubtb.scala:57:25
        meta_3_1_is_br = _RANDOM[8'h1E][31];	// faubtb.scala:57:25
        meta_3_1_tag = {_RANDOM[8'h1F], _RANDOM[8'h20][3:0]};	// faubtb.scala:57:25
        meta_3_1_ctr = _RANDOM[8'h20][5:4];	// faubtb.scala:57:25
        meta_3_2_is_br = _RANDOM[8'h20][6];	// faubtb.scala:57:25
        meta_3_2_tag = {_RANDOM[8'h20][31:7], _RANDOM[8'h21][10:0]};	// faubtb.scala:57:25
        meta_3_2_ctr = _RANDOM[8'h21][12:11];	// faubtb.scala:57:25
        meta_3_3_is_br = _RANDOM[8'h21][13];	// faubtb.scala:57:25
        meta_3_3_tag = {_RANDOM[8'h21][31:14], _RANDOM[8'h22][17:0]};	// faubtb.scala:57:25
        meta_3_3_ctr = _RANDOM[8'h22][19:18];	// faubtb.scala:57:25
        meta_4_0_is_br = _RANDOM[8'h22][20];	// faubtb.scala:57:25
        meta_4_0_tag = {_RANDOM[8'h22][31:21], _RANDOM[8'h23][24:0]};	// faubtb.scala:57:25
        meta_4_0_ctr = _RANDOM[8'h23][26:25];	// faubtb.scala:57:25
        meta_4_1_is_br = _RANDOM[8'h23][27];	// faubtb.scala:57:25
        meta_4_1_tag = {_RANDOM[8'h23][31:28], _RANDOM[8'h24]};	// faubtb.scala:57:25
        meta_4_1_ctr = _RANDOM[8'h25][1:0];	// faubtb.scala:57:25
        meta_4_2_is_br = _RANDOM[8'h25][2];	// faubtb.scala:57:25
        meta_4_2_tag = {_RANDOM[8'h25][31:3], _RANDOM[8'h26][6:0]};	// faubtb.scala:57:25
        meta_4_2_ctr = _RANDOM[8'h26][8:7];	// faubtb.scala:57:25
        meta_4_3_is_br = _RANDOM[8'h26][9];	// faubtb.scala:57:25
        meta_4_3_tag = {_RANDOM[8'h26][31:10], _RANDOM[8'h27][13:0]};	// faubtb.scala:57:25
        meta_4_3_ctr = _RANDOM[8'h27][15:14];	// faubtb.scala:57:25
        meta_5_0_is_br = _RANDOM[8'h27][16];	// faubtb.scala:57:25
        meta_5_0_tag = {_RANDOM[8'h27][31:17], _RANDOM[8'h28][20:0]};	// faubtb.scala:57:25
        meta_5_0_ctr = _RANDOM[8'h28][22:21];	// faubtb.scala:57:25
        meta_5_1_is_br = _RANDOM[8'h28][23];	// faubtb.scala:57:25
        meta_5_1_tag = {_RANDOM[8'h28][31:24], _RANDOM[8'h29][27:0]};	// faubtb.scala:57:25
        meta_5_1_ctr = _RANDOM[8'h29][29:28];	// faubtb.scala:57:25
        meta_5_2_is_br = _RANDOM[8'h29][30];	// faubtb.scala:57:25
        meta_5_2_tag = {_RANDOM[8'h29][31], _RANDOM[8'h2A], _RANDOM[8'h2B][2:0]};	// faubtb.scala:57:25
        meta_5_2_ctr = _RANDOM[8'h2B][4:3];	// faubtb.scala:57:25
        meta_5_3_is_br = _RANDOM[8'h2B][5];	// faubtb.scala:57:25
        meta_5_3_tag = {_RANDOM[8'h2B][31:6], _RANDOM[8'h2C][9:0]};	// faubtb.scala:57:25
        meta_5_3_ctr = _RANDOM[8'h2C][11:10];	// faubtb.scala:57:25
        meta_6_0_is_br = _RANDOM[8'h2C][12];	// faubtb.scala:57:25
        meta_6_0_tag = {_RANDOM[8'h2C][31:13], _RANDOM[8'h2D][16:0]};	// faubtb.scala:57:25
        meta_6_0_ctr = _RANDOM[8'h2D][18:17];	// faubtb.scala:57:25
        meta_6_1_is_br = _RANDOM[8'h2D][19];	// faubtb.scala:57:25
        meta_6_1_tag = {_RANDOM[8'h2D][31:20], _RANDOM[8'h2E][23:0]};	// faubtb.scala:57:25
        meta_6_1_ctr = _RANDOM[8'h2E][25:24];	// faubtb.scala:57:25
        meta_6_2_is_br = _RANDOM[8'h2E][26];	// faubtb.scala:57:25
        meta_6_2_tag = {_RANDOM[8'h2E][31:27], _RANDOM[8'h2F][30:0]};	// faubtb.scala:57:25
        meta_6_2_ctr = {_RANDOM[8'h2F][31], _RANDOM[8'h30][0]};	// faubtb.scala:57:25
        meta_6_3_is_br = _RANDOM[8'h30][1];	// faubtb.scala:57:25
        meta_6_3_tag = {_RANDOM[8'h30][31:2], _RANDOM[8'h31][5:0]};	// faubtb.scala:57:25
        meta_6_3_ctr = _RANDOM[8'h31][7:6];	// faubtb.scala:57:25
        meta_7_0_is_br = _RANDOM[8'h31][8];	// faubtb.scala:57:25
        meta_7_0_tag = {_RANDOM[8'h31][31:9], _RANDOM[8'h32][12:0]};	// faubtb.scala:57:25
        meta_7_0_ctr = _RANDOM[8'h32][14:13];	// faubtb.scala:57:25
        meta_7_1_is_br = _RANDOM[8'h32][15];	// faubtb.scala:57:25
        meta_7_1_tag = {_RANDOM[8'h32][31:16], _RANDOM[8'h33][19:0]};	// faubtb.scala:57:25
        meta_7_1_ctr = _RANDOM[8'h33][21:20];	// faubtb.scala:57:25
        meta_7_2_is_br = _RANDOM[8'h33][22];	// faubtb.scala:57:25
        meta_7_2_tag = {_RANDOM[8'h33][31:23], _RANDOM[8'h34][26:0]};	// faubtb.scala:57:25
        meta_7_2_ctr = _RANDOM[8'h34][28:27];	// faubtb.scala:57:25
        meta_7_3_is_br = _RANDOM[8'h34][29];	// faubtb.scala:57:25
        meta_7_3_tag = {_RANDOM[8'h34][31:30], _RANDOM[8'h35], _RANDOM[8'h36][1:0]};	// faubtb.scala:57:25
        meta_7_3_ctr = _RANDOM[8'h36][3:2];	// faubtb.scala:57:25
        meta_8_0_is_br = _RANDOM[8'h36][4];	// faubtb.scala:57:25
        meta_8_0_tag = {_RANDOM[8'h36][31:5], _RANDOM[8'h37][8:0]};	// faubtb.scala:57:25
        meta_8_0_ctr = _RANDOM[8'h37][10:9];	// faubtb.scala:57:25
        meta_8_1_is_br = _RANDOM[8'h37][11];	// faubtb.scala:57:25
        meta_8_1_tag = {_RANDOM[8'h37][31:12], _RANDOM[8'h38][15:0]};	// faubtb.scala:57:25
        meta_8_1_ctr = _RANDOM[8'h38][17:16];	// faubtb.scala:57:25
        meta_8_2_is_br = _RANDOM[8'h38][18];	// faubtb.scala:57:25
        meta_8_2_tag = {_RANDOM[8'h38][31:19], _RANDOM[8'h39][22:0]};	// faubtb.scala:57:25
        meta_8_2_ctr = _RANDOM[8'h39][24:23];	// faubtb.scala:57:25
        meta_8_3_is_br = _RANDOM[8'h39][25];	// faubtb.scala:57:25
        meta_8_3_tag = {_RANDOM[8'h39][31:26], _RANDOM[8'h3A][29:0]};	// faubtb.scala:57:25
        meta_8_3_ctr = _RANDOM[8'h3A][31:30];	// faubtb.scala:57:25
        meta_9_0_is_br = _RANDOM[8'h3B][0];	// faubtb.scala:57:25
        meta_9_0_tag = {_RANDOM[8'h3B][31:1], _RANDOM[8'h3C][4:0]};	// faubtb.scala:57:25
        meta_9_0_ctr = _RANDOM[8'h3C][6:5];	// faubtb.scala:57:25
        meta_9_1_is_br = _RANDOM[8'h3C][7];	// faubtb.scala:57:25
        meta_9_1_tag = {_RANDOM[8'h3C][31:8], _RANDOM[8'h3D][11:0]};	// faubtb.scala:57:25
        meta_9_1_ctr = _RANDOM[8'h3D][13:12];	// faubtb.scala:57:25
        meta_9_2_is_br = _RANDOM[8'h3D][14];	// faubtb.scala:57:25
        meta_9_2_tag = {_RANDOM[8'h3D][31:15], _RANDOM[8'h3E][18:0]};	// faubtb.scala:57:25
        meta_9_2_ctr = _RANDOM[8'h3E][20:19];	// faubtb.scala:57:25
        meta_9_3_is_br = _RANDOM[8'h3E][21];	// faubtb.scala:57:25
        meta_9_3_tag = {_RANDOM[8'h3E][31:22], _RANDOM[8'h3F][25:0]};	// faubtb.scala:57:25
        meta_9_3_ctr = _RANDOM[8'h3F][27:26];	// faubtb.scala:57:25
        meta_10_0_is_br = _RANDOM[8'h3F][28];	// faubtb.scala:57:25
        meta_10_0_tag = {_RANDOM[8'h3F][31:29], _RANDOM[8'h40], _RANDOM[8'h41][0]};	// faubtb.scala:57:25
        meta_10_0_ctr = _RANDOM[8'h41][2:1];	// faubtb.scala:57:25
        meta_10_1_is_br = _RANDOM[8'h41][3];	// faubtb.scala:57:25
        meta_10_1_tag = {_RANDOM[8'h41][31:4], _RANDOM[8'h42][7:0]};	// faubtb.scala:57:25
        meta_10_1_ctr = _RANDOM[8'h42][9:8];	// faubtb.scala:57:25
        meta_10_2_is_br = _RANDOM[8'h42][10];	// faubtb.scala:57:25
        meta_10_2_tag = {_RANDOM[8'h42][31:11], _RANDOM[8'h43][14:0]};	// faubtb.scala:57:25
        meta_10_2_ctr = _RANDOM[8'h43][16:15];	// faubtb.scala:57:25
        meta_10_3_is_br = _RANDOM[8'h43][17];	// faubtb.scala:57:25
        meta_10_3_tag = {_RANDOM[8'h43][31:18], _RANDOM[8'h44][21:0]};	// faubtb.scala:57:25
        meta_10_3_ctr = _RANDOM[8'h44][23:22];	// faubtb.scala:57:25
        meta_11_0_is_br = _RANDOM[8'h44][24];	// faubtb.scala:57:25
        meta_11_0_tag = {_RANDOM[8'h44][31:25], _RANDOM[8'h45][28:0]};	// faubtb.scala:57:25
        meta_11_0_ctr = _RANDOM[8'h45][30:29];	// faubtb.scala:57:25
        meta_11_1_is_br = _RANDOM[8'h45][31];	// faubtb.scala:57:25
        meta_11_1_tag = {_RANDOM[8'h46], _RANDOM[8'h47][3:0]};	// faubtb.scala:57:25
        meta_11_1_ctr = _RANDOM[8'h47][5:4];	// faubtb.scala:57:25
        meta_11_2_is_br = _RANDOM[8'h47][6];	// faubtb.scala:57:25
        meta_11_2_tag = {_RANDOM[8'h47][31:7], _RANDOM[8'h48][10:0]};	// faubtb.scala:57:25
        meta_11_2_ctr = _RANDOM[8'h48][12:11];	// faubtb.scala:57:25
        meta_11_3_is_br = _RANDOM[8'h48][13];	// faubtb.scala:57:25
        meta_11_3_tag = {_RANDOM[8'h48][31:14], _RANDOM[8'h49][17:0]};	// faubtb.scala:57:25
        meta_11_3_ctr = _RANDOM[8'h49][19:18];	// faubtb.scala:57:25
        meta_12_0_is_br = _RANDOM[8'h49][20];	// faubtb.scala:57:25
        meta_12_0_tag = {_RANDOM[8'h49][31:21], _RANDOM[8'h4A][24:0]};	// faubtb.scala:57:25
        meta_12_0_ctr = _RANDOM[8'h4A][26:25];	// faubtb.scala:57:25
        meta_12_1_is_br = _RANDOM[8'h4A][27];	// faubtb.scala:57:25
        meta_12_1_tag = {_RANDOM[8'h4A][31:28], _RANDOM[8'h4B]};	// faubtb.scala:57:25
        meta_12_1_ctr = _RANDOM[8'h4C][1:0];	// faubtb.scala:57:25
        meta_12_2_is_br = _RANDOM[8'h4C][2];	// faubtb.scala:57:25
        meta_12_2_tag = {_RANDOM[8'h4C][31:3], _RANDOM[8'h4D][6:0]};	// faubtb.scala:57:25
        meta_12_2_ctr = _RANDOM[8'h4D][8:7];	// faubtb.scala:57:25
        meta_12_3_is_br = _RANDOM[8'h4D][9];	// faubtb.scala:57:25
        meta_12_3_tag = {_RANDOM[8'h4D][31:10], _RANDOM[8'h4E][13:0]};	// faubtb.scala:57:25
        meta_12_3_ctr = _RANDOM[8'h4E][15:14];	// faubtb.scala:57:25
        meta_13_0_is_br = _RANDOM[8'h4E][16];	// faubtb.scala:57:25
        meta_13_0_tag = {_RANDOM[8'h4E][31:17], _RANDOM[8'h4F][20:0]};	// faubtb.scala:57:25
        meta_13_0_ctr = _RANDOM[8'h4F][22:21];	// faubtb.scala:57:25
        meta_13_1_is_br = _RANDOM[8'h4F][23];	// faubtb.scala:57:25
        meta_13_1_tag = {_RANDOM[8'h4F][31:24], _RANDOM[8'h50][27:0]};	// faubtb.scala:57:25
        meta_13_1_ctr = _RANDOM[8'h50][29:28];	// faubtb.scala:57:25
        meta_13_2_is_br = _RANDOM[8'h50][30];	// faubtb.scala:57:25
        meta_13_2_tag = {_RANDOM[8'h50][31], _RANDOM[8'h51], _RANDOM[8'h52][2:0]};	// faubtb.scala:57:25
        meta_13_2_ctr = _RANDOM[8'h52][4:3];	// faubtb.scala:57:25
        meta_13_3_is_br = _RANDOM[8'h52][5];	// faubtb.scala:57:25
        meta_13_3_tag = {_RANDOM[8'h52][31:6], _RANDOM[8'h53][9:0]};	// faubtb.scala:57:25
        meta_13_3_ctr = _RANDOM[8'h53][11:10];	// faubtb.scala:57:25
        meta_14_0_is_br = _RANDOM[8'h53][12];	// faubtb.scala:57:25
        meta_14_0_tag = {_RANDOM[8'h53][31:13], _RANDOM[8'h54][16:0]};	// faubtb.scala:57:25
        meta_14_0_ctr = _RANDOM[8'h54][18:17];	// faubtb.scala:57:25
        meta_14_1_is_br = _RANDOM[8'h54][19];	// faubtb.scala:57:25
        meta_14_1_tag = {_RANDOM[8'h54][31:20], _RANDOM[8'h55][23:0]};	// faubtb.scala:57:25
        meta_14_1_ctr = _RANDOM[8'h55][25:24];	// faubtb.scala:57:25
        meta_14_2_is_br = _RANDOM[8'h55][26];	// faubtb.scala:57:25
        meta_14_2_tag = {_RANDOM[8'h55][31:27], _RANDOM[8'h56][30:0]};	// faubtb.scala:57:25
        meta_14_2_ctr = {_RANDOM[8'h56][31], _RANDOM[8'h57][0]};	// faubtb.scala:57:25
        meta_14_3_is_br = _RANDOM[8'h57][1];	// faubtb.scala:57:25
        meta_14_3_tag = {_RANDOM[8'h57][31:2], _RANDOM[8'h58][5:0]};	// faubtb.scala:57:25
        meta_14_3_ctr = _RANDOM[8'h58][7:6];	// faubtb.scala:57:25
        meta_15_0_is_br = _RANDOM[8'h58][8];	// faubtb.scala:57:25
        meta_15_0_tag = {_RANDOM[8'h58][31:9], _RANDOM[8'h59][12:0]};	// faubtb.scala:57:25
        meta_15_0_ctr = _RANDOM[8'h59][14:13];	// faubtb.scala:57:25
        meta_15_1_is_br = _RANDOM[8'h59][15];	// faubtb.scala:57:25
        meta_15_1_tag = {_RANDOM[8'h59][31:16], _RANDOM[8'h5A][19:0]};	// faubtb.scala:57:25
        meta_15_1_ctr = _RANDOM[8'h5A][21:20];	// faubtb.scala:57:25
        meta_15_2_is_br = _RANDOM[8'h5A][22];	// faubtb.scala:57:25
        meta_15_2_tag = {_RANDOM[8'h5A][31:23], _RANDOM[8'h5B][26:0]};	// faubtb.scala:57:25
        meta_15_2_ctr = _RANDOM[8'h5B][28:27];	// faubtb.scala:57:25
        meta_15_3_is_br = _RANDOM[8'h5B][29];	// faubtb.scala:57:25
        meta_15_3_tag = {_RANDOM[8'h5B][31:30], _RANDOM[8'h5C], _RANDOM[8'h5D][1:0]};	// faubtb.scala:57:25
        meta_15_3_ctr = _RANDOM[8'h5D][3:2];	// faubtb.scala:57:25
        btb_0_0_offset = _RANDOM[8'h5D][16:4];	// faubtb.scala:57:25, :58:21
        btb_0_1_offset = _RANDOM[8'h5D][29:17];	// faubtb.scala:57:25, :58:21
        btb_0_2_offset = {_RANDOM[8'h5D][31:30], _RANDOM[8'h5E][10:0]};	// faubtb.scala:57:25, :58:21
        btb_0_3_offset = _RANDOM[8'h5E][23:11];	// faubtb.scala:58:21
        btb_1_0_offset = {_RANDOM[8'h5E][31:24], _RANDOM[8'h5F][4:0]};	// faubtb.scala:58:21
        btb_1_1_offset = _RANDOM[8'h5F][17:5];	// faubtb.scala:58:21
        btb_1_2_offset = _RANDOM[8'h5F][30:18];	// faubtb.scala:58:21
        btb_1_3_offset = {_RANDOM[8'h5F][31], _RANDOM[8'h60][11:0]};	// faubtb.scala:58:21
        btb_2_0_offset = _RANDOM[8'h60][24:12];	// faubtb.scala:58:21
        btb_2_1_offset = {_RANDOM[8'h60][31:25], _RANDOM[8'h61][5:0]};	// faubtb.scala:58:21
        btb_2_2_offset = _RANDOM[8'h61][18:6];	// faubtb.scala:58:21
        btb_2_3_offset = _RANDOM[8'h61][31:19];	// faubtb.scala:58:21
        btb_3_0_offset = _RANDOM[8'h62][12:0];	// faubtb.scala:58:21
        btb_3_1_offset = _RANDOM[8'h62][25:13];	// faubtb.scala:58:21
        btb_3_2_offset = {_RANDOM[8'h62][31:26], _RANDOM[8'h63][6:0]};	// faubtb.scala:58:21
        btb_3_3_offset = _RANDOM[8'h63][19:7];	// faubtb.scala:58:21
        btb_4_0_offset = {_RANDOM[8'h63][31:20], _RANDOM[8'h64][0]};	// faubtb.scala:58:21
        btb_4_1_offset = _RANDOM[8'h64][13:1];	// faubtb.scala:58:21
        btb_4_2_offset = _RANDOM[8'h64][26:14];	// faubtb.scala:58:21
        btb_4_3_offset = {_RANDOM[8'h64][31:27], _RANDOM[8'h65][7:0]};	// faubtb.scala:58:21
        btb_5_0_offset = _RANDOM[8'h65][20:8];	// faubtb.scala:58:21
        btb_5_1_offset = {_RANDOM[8'h65][31:21], _RANDOM[8'h66][1:0]};	// faubtb.scala:58:21
        btb_5_2_offset = _RANDOM[8'h66][14:2];	// faubtb.scala:58:21
        btb_5_3_offset = _RANDOM[8'h66][27:15];	// faubtb.scala:58:21
        btb_6_0_offset = {_RANDOM[8'h66][31:28], _RANDOM[8'h67][8:0]};	// faubtb.scala:58:21
        btb_6_1_offset = _RANDOM[8'h67][21:9];	// faubtb.scala:58:21
        btb_6_2_offset = {_RANDOM[8'h67][31:22], _RANDOM[8'h68][2:0]};	// faubtb.scala:58:21
        btb_6_3_offset = _RANDOM[8'h68][15:3];	// faubtb.scala:58:21
        btb_7_0_offset = _RANDOM[8'h68][28:16];	// faubtb.scala:58:21
        btb_7_1_offset = {_RANDOM[8'h68][31:29], _RANDOM[8'h69][9:0]};	// faubtb.scala:58:21
        btb_7_2_offset = _RANDOM[8'h69][22:10];	// faubtb.scala:58:21
        btb_7_3_offset = {_RANDOM[8'h69][31:23], _RANDOM[8'h6A][3:0]};	// faubtb.scala:58:21
        btb_8_0_offset = _RANDOM[8'h6A][16:4];	// faubtb.scala:58:21
        btb_8_1_offset = _RANDOM[8'h6A][29:17];	// faubtb.scala:58:21
        btb_8_2_offset = {_RANDOM[8'h6A][31:30], _RANDOM[8'h6B][10:0]};	// faubtb.scala:58:21
        btb_8_3_offset = _RANDOM[8'h6B][23:11];	// faubtb.scala:58:21
        btb_9_0_offset = {_RANDOM[8'h6B][31:24], _RANDOM[8'h6C][4:0]};	// faubtb.scala:58:21
        btb_9_1_offset = _RANDOM[8'h6C][17:5];	// faubtb.scala:58:21
        btb_9_2_offset = _RANDOM[8'h6C][30:18];	// faubtb.scala:58:21
        btb_9_3_offset = {_RANDOM[8'h6C][31], _RANDOM[8'h6D][11:0]};	// faubtb.scala:58:21
        btb_10_0_offset = _RANDOM[8'h6D][24:12];	// faubtb.scala:58:21
        btb_10_1_offset = {_RANDOM[8'h6D][31:25], _RANDOM[8'h6E][5:0]};	// faubtb.scala:58:21
        btb_10_2_offset = _RANDOM[8'h6E][18:6];	// faubtb.scala:58:21
        btb_10_3_offset = _RANDOM[8'h6E][31:19];	// faubtb.scala:58:21
        btb_11_0_offset = _RANDOM[8'h6F][12:0];	// faubtb.scala:58:21
        btb_11_1_offset = _RANDOM[8'h6F][25:13];	// faubtb.scala:58:21
        btb_11_2_offset = {_RANDOM[8'h6F][31:26], _RANDOM[8'h70][6:0]};	// faubtb.scala:58:21
        btb_11_3_offset = _RANDOM[8'h70][19:7];	// faubtb.scala:58:21
        btb_12_0_offset = {_RANDOM[8'h70][31:20], _RANDOM[8'h71][0]};	// faubtb.scala:58:21
        btb_12_1_offset = _RANDOM[8'h71][13:1];	// faubtb.scala:58:21
        btb_12_2_offset = _RANDOM[8'h71][26:14];	// faubtb.scala:58:21
        btb_12_3_offset = {_RANDOM[8'h71][31:27], _RANDOM[8'h72][7:0]};	// faubtb.scala:58:21
        btb_13_0_offset = _RANDOM[8'h72][20:8];	// faubtb.scala:58:21
        btb_13_1_offset = {_RANDOM[8'h72][31:21], _RANDOM[8'h73][1:0]};	// faubtb.scala:58:21
        btb_13_2_offset = _RANDOM[8'h73][14:2];	// faubtb.scala:58:21
        btb_13_3_offset = _RANDOM[8'h73][27:15];	// faubtb.scala:58:21
        btb_14_0_offset = {_RANDOM[8'h73][31:28], _RANDOM[8'h74][8:0]};	// faubtb.scala:58:21
        btb_14_1_offset = _RANDOM[8'h74][21:9];	// faubtb.scala:58:21
        btb_14_2_offset = {_RANDOM[8'h74][31:22], _RANDOM[8'h75][2:0]};	// faubtb.scala:58:21
        btb_14_3_offset = _RANDOM[8'h75][15:3];	// faubtb.scala:58:21
        btb_15_0_offset = _RANDOM[8'h75][28:16];	// faubtb.scala:58:21
        btb_15_1_offset = {_RANDOM[8'h75][31:29], _RANDOM[8'h76][9:0]};	// faubtb.scala:58:21
        btb_15_2_offset = _RANDOM[8'h76][22:10];	// faubtb.scala:58:21
        btb_15_3_offset = {_RANDOM[8'h76][31:23], _RANDOM[8'h77][3:0]};	// faubtb.scala:58:21
        io_resp_f2_0_REG_is_br = _RANDOM[8'h77][5];	// faubtb.scala:58:21, :107:29
        io_resp_f2_0_REG_is_jal = _RANDOM[8'h77][6];	// faubtb.scala:58:21, :107:29
        io_resp_f2_0_REG_predicted_pc_valid = _RANDOM[8'h77][7];	// faubtb.scala:58:21, :107:29
        io_resp_f2_0_REG_predicted_pc_bits = {_RANDOM[8'h77][31:8], _RANDOM[8'h78][15:0]};	// faubtb.scala:58:21, :107:29
        io_resp_f3_0_REG_is_br = _RANDOM[8'h78][17];	// faubtb.scala:107:29, :108:29
        io_resp_f3_0_REG_is_jal = _RANDOM[8'h78][18];	// faubtb.scala:107:29, :108:29
        io_resp_f3_0_REG_predicted_pc_valid = _RANDOM[8'h78][19];	// faubtb.scala:107:29, :108:29
        io_resp_f3_0_REG_predicted_pc_bits =
          {_RANDOM[8'h78][31:20], _RANDOM[8'h79][27:0]};	// faubtb.scala:107:29, :108:29
        io_resp_f2_1_REG_is_br = _RANDOM[8'h79][29];	// faubtb.scala:107:29, :108:29
        io_resp_f2_1_REG_is_jal = _RANDOM[8'h79][30];	// faubtb.scala:107:29, :108:29
        io_resp_f2_1_REG_predicted_pc_valid = _RANDOM[8'h79][31];	// faubtb.scala:107:29, :108:29
        io_resp_f2_1_REG_predicted_pc_bits = {_RANDOM[8'h7A], _RANDOM[8'h7B][7:0]};	// faubtb.scala:107:29
        io_resp_f3_1_REG_is_br = _RANDOM[8'h7B][9];	// faubtb.scala:107:29, :108:29
        io_resp_f3_1_REG_is_jal = _RANDOM[8'h7B][10];	// faubtb.scala:107:29, :108:29
        io_resp_f3_1_REG_predicted_pc_valid = _RANDOM[8'h7B][11];	// faubtb.scala:107:29, :108:29
        io_resp_f3_1_REG_predicted_pc_bits =
          {_RANDOM[8'h7B][31:12], _RANDOM[8'h7C][19:0]};	// faubtb.scala:107:29, :108:29
        io_resp_f2_2_REG_is_br = _RANDOM[8'h7C][21];	// faubtb.scala:107:29, :108:29
        io_resp_f2_2_REG_is_jal = _RANDOM[8'h7C][22];	// faubtb.scala:107:29, :108:29
        io_resp_f2_2_REG_predicted_pc_valid = _RANDOM[8'h7C][23];	// faubtb.scala:107:29, :108:29
        io_resp_f2_2_REG_predicted_pc_bits = {_RANDOM[8'h7C][31:24], _RANDOM[8'h7D]};	// faubtb.scala:107:29, :108:29
        io_resp_f3_2_REG_is_br = _RANDOM[8'h7E][1];	// faubtb.scala:108:29
        io_resp_f3_2_REG_is_jal = _RANDOM[8'h7E][2];	// faubtb.scala:108:29
        io_resp_f3_2_REG_predicted_pc_valid = _RANDOM[8'h7E][3];	// faubtb.scala:108:29
        io_resp_f3_2_REG_predicted_pc_bits = {_RANDOM[8'h7E][31:4], _RANDOM[8'h7F][11:0]};	// faubtb.scala:108:29
        io_resp_f2_3_REG_is_br = _RANDOM[8'h7F][13];	// faubtb.scala:107:29, :108:29
        io_resp_f2_3_REG_is_jal = _RANDOM[8'h7F][14];	// faubtb.scala:107:29, :108:29
        io_resp_f2_3_REG_predicted_pc_valid = _RANDOM[8'h7F][15];	// faubtb.scala:107:29, :108:29
        io_resp_f2_3_REG_predicted_pc_bits =
          {_RANDOM[8'h7F][31:16], _RANDOM[8'h80][23:0]};	// faubtb.scala:107:29, :108:29
        io_resp_f3_3_REG_is_br = _RANDOM[8'h80][25];	// faubtb.scala:107:29, :108:29
        io_resp_f3_3_REG_is_jal = _RANDOM[8'h80][26];	// faubtb.scala:107:29, :108:29
        io_resp_f3_3_REG_predicted_pc_valid = _RANDOM[8'h80][27];	// faubtb.scala:107:29, :108:29
        io_resp_f3_3_REG_predicted_pc_bits =
          {_RANDOM[8'h80][31:28], _RANDOM[8'h81], _RANDOM[8'h82][3:0]};	// faubtb.scala:107:29, :108:29
        io_f3_meta_REG = _RANDOM[8'h82][11:4];	// faubtb.scala:108:29, :110:32
        io_f3_meta_REG_1 = _RANDOM[8'h82][19:12];	// faubtb.scala:108:29, :110:24
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_resp_f1_0_taken = ~_GEN_0[s1_hit_ways_0] | _GEN_1[s1_hit_ways_0][1];	// Mux.scala:47:69, faubtb.scala:82:42, :83:45, :84:{43,60}
  assign io_resp_f1_0_is_br = s1_is_br_0;	// faubtb.scala:82:42
  assign io_resp_f1_0_is_jal = s1_is_jal_0;	// faubtb.scala:83:42
  assign io_resp_f1_0_predicted_pc_valid = s1_resp_0_valid;	// faubtb.scala:80:34
  assign io_resp_f1_0_predicted_pc_bits = _s1_resp_0_bits_T_4;	// faubtb.scala:81:52
  assign io_resp_f1_1_taken = ~_GEN_3[s1_hit_ways_1] | _GEN_4[s1_hit_ways_1][1];	// Mux.scala:47:69, faubtb.scala:82:42, :83:45, :84:{43,60}
  assign io_resp_f1_1_is_br = s1_is_br_1;	// faubtb.scala:82:42
  assign io_resp_f1_1_is_jal = s1_is_jal_1;	// faubtb.scala:83:42
  assign io_resp_f1_1_predicted_pc_valid = s1_resp_1_valid;	// faubtb.scala:80:34
  assign io_resp_f1_1_predicted_pc_bits = _s1_resp_1_bits_T_4;	// faubtb.scala:81:52
  assign io_resp_f1_2_taken = ~_GEN_6[s1_hit_ways_2] | _GEN_7[s1_hit_ways_2][1];	// Mux.scala:47:69, faubtb.scala:82:42, :83:45, :84:{43,60}
  assign io_resp_f1_2_is_br = s1_is_br_2;	// faubtb.scala:82:42
  assign io_resp_f1_2_is_jal = s1_is_jal_2;	// faubtb.scala:83:42
  assign io_resp_f1_2_predicted_pc_valid = s1_resp_2_valid;	// faubtb.scala:80:34
  assign io_resp_f1_2_predicted_pc_bits = _s1_resp_2_bits_T_4;	// faubtb.scala:81:52
  assign io_resp_f1_3_taken = ~_GEN_9[s1_hit_ways_3] | _GEN_10[s1_hit_ways_3][1];	// Mux.scala:47:69, faubtb.scala:82:42, :83:45, :84:{43,60}
  assign io_resp_f1_3_is_br = s1_is_br_3;	// faubtb.scala:82:42
  assign io_resp_f1_3_is_jal = s1_is_jal_3;	// faubtb.scala:83:42
  assign io_resp_f1_3_predicted_pc_valid = s1_resp_3_valid;	// faubtb.scala:80:34
  assign io_resp_f1_3_predicted_pc_bits = _s1_resp_3_bits_T_4;	// faubtb.scala:81:52
  assign io_resp_f2_0_is_br = io_resp_f2_0_REG_is_br;	// faubtb.scala:107:29
  assign io_resp_f2_0_is_jal = io_resp_f2_0_REG_is_jal;	// faubtb.scala:107:29
  assign io_resp_f2_0_predicted_pc_valid = io_resp_f2_0_REG_predicted_pc_valid;	// faubtb.scala:107:29
  assign io_resp_f2_0_predicted_pc_bits = io_resp_f2_0_REG_predicted_pc_bits;	// faubtb.scala:107:29
  assign io_resp_f2_1_is_br = io_resp_f2_1_REG_is_br;	// faubtb.scala:107:29
  assign io_resp_f2_1_is_jal = io_resp_f2_1_REG_is_jal;	// faubtb.scala:107:29
  assign io_resp_f2_1_predicted_pc_valid = io_resp_f2_1_REG_predicted_pc_valid;	// faubtb.scala:107:29
  assign io_resp_f2_1_predicted_pc_bits = io_resp_f2_1_REG_predicted_pc_bits;	// faubtb.scala:107:29
  assign io_resp_f2_2_is_br = io_resp_f2_2_REG_is_br;	// faubtb.scala:107:29
  assign io_resp_f2_2_is_jal = io_resp_f2_2_REG_is_jal;	// faubtb.scala:107:29
  assign io_resp_f2_2_predicted_pc_valid = io_resp_f2_2_REG_predicted_pc_valid;	// faubtb.scala:107:29
  assign io_resp_f2_2_predicted_pc_bits = io_resp_f2_2_REG_predicted_pc_bits;	// faubtb.scala:107:29
  assign io_resp_f2_3_is_br = io_resp_f2_3_REG_is_br;	// faubtb.scala:107:29
  assign io_resp_f2_3_is_jal = io_resp_f2_3_REG_is_jal;	// faubtb.scala:107:29
  assign io_resp_f2_3_predicted_pc_valid = io_resp_f2_3_REG_predicted_pc_valid;	// faubtb.scala:107:29
  assign io_resp_f2_3_predicted_pc_bits = io_resp_f2_3_REG_predicted_pc_bits;	// faubtb.scala:107:29
  assign io_resp_f3_0_is_br = io_resp_f3_0_REG_is_br;	// faubtb.scala:108:29
  assign io_resp_f3_0_is_jal = io_resp_f3_0_REG_is_jal;	// faubtb.scala:108:29
  assign io_resp_f3_0_predicted_pc_valid = io_resp_f3_0_REG_predicted_pc_valid;	// faubtb.scala:108:29
  assign io_resp_f3_0_predicted_pc_bits = io_resp_f3_0_REG_predicted_pc_bits;	// faubtb.scala:108:29
  assign io_resp_f3_1_is_br = io_resp_f3_1_REG_is_br;	// faubtb.scala:108:29
  assign io_resp_f3_1_is_jal = io_resp_f3_1_REG_is_jal;	// faubtb.scala:108:29
  assign io_resp_f3_1_predicted_pc_valid = io_resp_f3_1_REG_predicted_pc_valid;	// faubtb.scala:108:29
  assign io_resp_f3_1_predicted_pc_bits = io_resp_f3_1_REG_predicted_pc_bits;	// faubtb.scala:108:29
  assign io_resp_f3_2_is_br = io_resp_f3_2_REG_is_br;	// faubtb.scala:108:29
  assign io_resp_f3_2_is_jal = io_resp_f3_2_REG_is_jal;	// faubtb.scala:108:29
  assign io_resp_f3_2_predicted_pc_valid = io_resp_f3_2_REG_predicted_pc_valid;	// faubtb.scala:108:29
  assign io_resp_f3_2_predicted_pc_bits = io_resp_f3_2_REG_predicted_pc_bits;	// faubtb.scala:108:29
  assign io_resp_f3_3_is_br = io_resp_f3_3_REG_is_br;	// faubtb.scala:108:29
  assign io_resp_f3_3_is_jal = io_resp_f3_3_REG_is_jal;	// faubtb.scala:108:29
  assign io_resp_f3_3_predicted_pc_valid = io_resp_f3_3_REG_predicted_pc_valid;	// faubtb.scala:108:29
  assign io_resp_f3_3_predicted_pc_bits = io_resp_f3_3_REG_predicted_pc_bits;	// faubtb.scala:108:29
  assign io_f3_meta = {112'h0, io_f3_meta_REG_1};	// faubtb.scala:110:{14,24}
endmodule

