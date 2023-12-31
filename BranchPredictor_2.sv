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

module BranchPredictor_2(
  input          clock,
                 reset,
                 io_f0_req_valid,
  input  [39:0]  io_f0_req_bits_pc,
  input  [63:0]  io_f0_req_bits_ghist_old_history,
  input          io_f3_fire,
                 io_update_valid,
                 io_update_bits_is_mispredict_update,
                 io_update_bits_is_repair_update,
  input  [3:0]   io_update_bits_btb_mispredicts,
  input  [39:0]  io_update_bits_pc,
  input  [3:0]   io_update_bits_br_mask,
  input          io_update_bits_cfi_idx_valid,
  input  [1:0]   io_update_bits_cfi_idx_bits,
  input          io_update_bits_cfi_taken,
                 io_update_bits_cfi_mispredicted,
                 io_update_bits_cfi_is_br,
                 io_update_bits_cfi_is_jal,
  input  [63:0]  io_update_bits_ghist_old_history,
  input  [39:0]  io_update_bits_target,
  input  [119:0] io_update_bits_meta_0,
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
  output [119:0] io_resp_f3_meta_0
);

  wire [6:0]  _banked_predictors_0_io_f0_mask_T = 7'hF << io_f0_req_bits_pc[2:1];	// frontend.scala:178:31, package.scala:154:13
  reg  [63:0] banked_predictors_0_io_f1_ghist_REG;	// predictor.scala:239:48
  reg  [39:0] io_resp_f1_pc_REG;	// predictor.scala:362:27
  reg  [39:0] io_resp_f2_pc_REG;	// predictor.scala:363:27
  reg  [39:0] io_resp_f3_pc_REG;	// predictor.scala:364:27
  `ifndef SYNTHESIS	// predictor.scala:468:13
    always @(posedge clock) begin	// predictor.scala:468:13
      automatic logic [3:0] _GEN = io_update_bits_br_mask >> io_update_bits_cfi_idx_bits;	// predictor.scala:468:36
      if (io_update_valid & io_update_bits_cfi_is_br & io_update_bits_cfi_idx_valid
          & ~(_GEN[0] | reset)) begin	// predictor.scala:468:{13,36}
        if (`ASSERT_VERBOSE_COND_)	// predictor.scala:468:13
          $error("Assertion failed\n    at predictor.scala:468 assert(io.update.bits.br_mask(io.update.bits.cfi_idx.bits))\n");	// predictor.scala:468:13
        if (`STOP_COND_)	// predictor.scala:468:13
          $fatal;	// predictor.scala:468:13
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    banked_predictors_0_io_f1_ghist_REG <= io_f0_req_bits_ghist_old_history;	// predictor.scala:239:48
    io_resp_f1_pc_REG <= io_f0_req_bits_pc;	// predictor.scala:362:27
    io_resp_f2_pc_REG <= io_resp_f1_pc_REG;	// predictor.scala:362:27, :363:27
    io_resp_f3_pc_REG <= io_resp_f2_pc_REG;	// predictor.scala:363:27, :364:27
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:5];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [2:0] i = 3'h0; i < 3'h6; i += 3'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        banked_predictors_0_io_f1_ghist_REG = {_RANDOM[3'h0], _RANDOM[3'h1]};	// predictor.scala:239:48
        io_resp_f1_pc_REG = {_RANDOM[3'h2], _RANDOM[3'h3][7:0]};	// predictor.scala:362:27
        io_resp_f2_pc_REG = {_RANDOM[3'h3][31:8], _RANDOM[3'h4][15:0]};	// predictor.scala:362:27, :363:27
        io_resp_f3_pc_REG = {_RANDOM[3'h4][31:16], _RANDOM[3'h5][23:0]};	// predictor.scala:363:27, :364:27
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  ComposedBranchPredictorBank_4 banked_predictors_0 (	// predictor.scala:218:19
    .clock                               (clock),
    .reset                               (reset),
    .io_f0_valid                         (io_f0_req_valid),
    .io_f0_pc                            ({io_f0_req_bits_pc[39:3], 3'h0}),	// frontend.scala:161:39
    .io_f0_mask                          (_banked_predictors_0_io_f0_mask_T[3:0]),	// frontend.scala:178:31, predictor.scala:237:38
    .io_f1_ghist                         (banked_predictors_0_io_f1_ghist_REG),	// predictor.scala:239:48
    .io_f3_fire                          (io_f3_fire),
    .io_update_valid                     (io_update_valid),
    .io_update_bits_is_mispredict_update (io_update_bits_is_mispredict_update),
    .io_update_bits_is_repair_update     (io_update_bits_is_repair_update),
    .io_update_bits_btb_mispredicts      (io_update_bits_btb_mispredicts),
    .io_update_bits_pc                   ({io_update_bits_pc[39:3], 3'h0}),	// frontend.scala:161:39
    .io_update_bits_br_mask              (io_update_bits_br_mask),
    .io_update_bits_cfi_idx_valid        (io_update_bits_cfi_idx_valid),
    .io_update_bits_cfi_idx_bits         (io_update_bits_cfi_idx_bits),
    .io_update_bits_cfi_taken            (io_update_bits_cfi_taken),
    .io_update_bits_cfi_mispredicted     (io_update_bits_cfi_mispredicted),
    .io_update_bits_cfi_is_br            (io_update_bits_cfi_is_br),
    .io_update_bits_cfi_is_jal           (io_update_bits_cfi_is_jal),
    .io_update_bits_ghist                (io_update_bits_ghist_old_history),
    .io_update_bits_target               (io_update_bits_target),
    .io_update_bits_meta                 (io_update_bits_meta_0),
    .io_resp_f1_0_taken                  (io_resp_f1_preds_0_taken),
    .io_resp_f1_0_is_br                  (io_resp_f1_preds_0_is_br),
    .io_resp_f1_0_is_jal                 (io_resp_f1_preds_0_is_jal),
    .io_resp_f1_0_predicted_pc_valid     (io_resp_f1_preds_0_predicted_pc_valid),
    .io_resp_f1_0_predicted_pc_bits      (io_resp_f1_preds_0_predicted_pc_bits),
    .io_resp_f1_1_taken                  (io_resp_f1_preds_1_taken),
    .io_resp_f1_1_is_br                  (io_resp_f1_preds_1_is_br),
    .io_resp_f1_1_is_jal                 (io_resp_f1_preds_1_is_jal),
    .io_resp_f1_1_predicted_pc_valid     (io_resp_f1_preds_1_predicted_pc_valid),
    .io_resp_f1_1_predicted_pc_bits      (io_resp_f1_preds_1_predicted_pc_bits),
    .io_resp_f1_2_taken                  (io_resp_f1_preds_2_taken),
    .io_resp_f1_2_is_br                  (io_resp_f1_preds_2_is_br),
    .io_resp_f1_2_is_jal                 (io_resp_f1_preds_2_is_jal),
    .io_resp_f1_2_predicted_pc_valid     (io_resp_f1_preds_2_predicted_pc_valid),
    .io_resp_f1_2_predicted_pc_bits      (io_resp_f1_preds_2_predicted_pc_bits),
    .io_resp_f1_3_taken                  (io_resp_f1_preds_3_taken),
    .io_resp_f1_3_is_br                  (io_resp_f1_preds_3_is_br),
    .io_resp_f1_3_is_jal                 (io_resp_f1_preds_3_is_jal),
    .io_resp_f1_3_predicted_pc_valid     (io_resp_f1_preds_3_predicted_pc_valid),
    .io_resp_f1_3_predicted_pc_bits      (io_resp_f1_preds_3_predicted_pc_bits),
    .io_resp_f2_0_taken                  (io_resp_f2_preds_0_taken),
    .io_resp_f2_0_is_br                  (io_resp_f2_preds_0_is_br),
    .io_resp_f2_0_is_jal                 (io_resp_f2_preds_0_is_jal),
    .io_resp_f2_0_predicted_pc_valid     (io_resp_f2_preds_0_predicted_pc_valid),
    .io_resp_f2_0_predicted_pc_bits      (io_resp_f2_preds_0_predicted_pc_bits),
    .io_resp_f2_1_taken                  (io_resp_f2_preds_1_taken),
    .io_resp_f2_1_is_br                  (io_resp_f2_preds_1_is_br),
    .io_resp_f2_1_is_jal                 (io_resp_f2_preds_1_is_jal),
    .io_resp_f2_1_predicted_pc_valid     (io_resp_f2_preds_1_predicted_pc_valid),
    .io_resp_f2_1_predicted_pc_bits      (io_resp_f2_preds_1_predicted_pc_bits),
    .io_resp_f2_2_taken                  (io_resp_f2_preds_2_taken),
    .io_resp_f2_2_is_br                  (io_resp_f2_preds_2_is_br),
    .io_resp_f2_2_is_jal                 (io_resp_f2_preds_2_is_jal),
    .io_resp_f2_2_predicted_pc_valid     (io_resp_f2_preds_2_predicted_pc_valid),
    .io_resp_f2_2_predicted_pc_bits      (io_resp_f2_preds_2_predicted_pc_bits),
    .io_resp_f2_3_taken                  (io_resp_f2_preds_3_taken),
    .io_resp_f2_3_is_br                  (io_resp_f2_preds_3_is_br),
    .io_resp_f2_3_is_jal                 (io_resp_f2_preds_3_is_jal),
    .io_resp_f2_3_predicted_pc_valid     (io_resp_f2_preds_3_predicted_pc_valid),
    .io_resp_f2_3_predicted_pc_bits      (io_resp_f2_preds_3_predicted_pc_bits),
    .io_resp_f3_0_taken                  (io_resp_f3_preds_0_taken),
    .io_resp_f3_0_is_br                  (io_resp_f3_preds_0_is_br),
    .io_resp_f3_0_is_jal                 (io_resp_f3_preds_0_is_jal),
    .io_resp_f3_0_predicted_pc_valid     (io_resp_f3_preds_0_predicted_pc_valid),
    .io_resp_f3_0_predicted_pc_bits      (io_resp_f3_preds_0_predicted_pc_bits),
    .io_resp_f3_1_taken                  (io_resp_f3_preds_1_taken),
    .io_resp_f3_1_is_br                  (io_resp_f3_preds_1_is_br),
    .io_resp_f3_1_is_jal                 (io_resp_f3_preds_1_is_jal),
    .io_resp_f3_1_predicted_pc_valid     (io_resp_f3_preds_1_predicted_pc_valid),
    .io_resp_f3_1_predicted_pc_bits      (io_resp_f3_preds_1_predicted_pc_bits),
    .io_resp_f3_2_taken                  (io_resp_f3_preds_2_taken),
    .io_resp_f3_2_is_br                  (io_resp_f3_preds_2_is_br),
    .io_resp_f3_2_is_jal                 (io_resp_f3_preds_2_is_jal),
    .io_resp_f3_2_predicted_pc_valid     (io_resp_f3_preds_2_predicted_pc_valid),
    .io_resp_f3_2_predicted_pc_bits      (io_resp_f3_preds_2_predicted_pc_bits),
    .io_resp_f3_3_taken                  (io_resp_f3_preds_3_taken),
    .io_resp_f3_3_is_br                  (io_resp_f3_preds_3_is_br),
    .io_resp_f3_3_is_jal                 (io_resp_f3_preds_3_is_jal),
    .io_resp_f3_3_predicted_pc_valid     (io_resp_f3_preds_3_predicted_pc_valid),
    .io_resp_f3_3_predicted_pc_bits      (io_resp_f3_preds_3_predicted_pc_bits),
    .io_f3_meta                          (io_resp_f3_meta_0)
  );
  assign io_resp_f3_pc = io_resp_f3_pc_REG;	// predictor.scala:364:27
endmodule

