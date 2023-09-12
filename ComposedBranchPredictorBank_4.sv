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

module ComposedBranchPredictorBank_4(
  input          clock,
                 reset,
                 io_f0_valid,
  input  [39:0]  io_f0_pc,
  input  [3:0]   io_f0_mask,
  input  [63:0]  io_f1_ghist,
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
  input  [63:0]  io_update_bits_ghist,
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
  output         io_resp_f2_0_taken,
                 io_resp_f2_0_is_br,
                 io_resp_f2_0_is_jal,
                 io_resp_f2_0_predicted_pc_valid,
  output [39:0]  io_resp_f2_0_predicted_pc_bits,
  output         io_resp_f2_1_taken,
                 io_resp_f2_1_is_br,
                 io_resp_f2_1_is_jal,
                 io_resp_f2_1_predicted_pc_valid,
  output [39:0]  io_resp_f2_1_predicted_pc_bits,
  output         io_resp_f2_2_taken,
                 io_resp_f2_2_is_br,
                 io_resp_f2_2_is_jal,
                 io_resp_f2_2_predicted_pc_valid,
  output [39:0]  io_resp_f2_2_predicted_pc_bits,
  output         io_resp_f2_3_taken,
                 io_resp_f2_3_is_br,
                 io_resp_f2_3_is_jal,
                 io_resp_f2_3_predicted_pc_valid,
  output [39:0]  io_resp_f2_3_predicted_pc_bits,
  output         io_resp_f3_0_taken,
                 io_resp_f3_0_is_br,
                 io_resp_f3_0_is_jal,
                 io_resp_f3_0_predicted_pc_valid,
  output [39:0]  io_resp_f3_0_predicted_pc_bits,
  output         io_resp_f3_1_taken,
                 io_resp_f3_1_is_br,
                 io_resp_f3_1_is_jal,
                 io_resp_f3_1_predicted_pc_valid,
  output [39:0]  io_resp_f3_1_predicted_pc_bits,
  output         io_resp_f3_2_taken,
                 io_resp_f3_2_is_br,
                 io_resp_f3_2_is_jal,
                 io_resp_f3_2_predicted_pc_valid,
  output [39:0]  io_resp_f3_2_predicted_pc_bits,
  output         io_resp_f3_3_taken,
                 io_resp_f3_3_is_br,
                 io_resp_f3_3_is_jal,
                 io_resp_f3_3_predicted_pc_valid,
  output [39:0]  io_resp_f3_3_predicted_pc_bits,
  output [119:0] io_f3_meta
);

  wire         _components_3_io_resp_f2_0_is_br;	// config-mixins.scala:436:26
  wire         _components_3_io_resp_f2_0_is_jal;	// config-mixins.scala:436:26
  wire         _components_3_io_resp_f2_0_predicted_pc_valid;	// config-mixins.scala:436:26
  wire [39:0]  _components_3_io_resp_f2_0_predicted_pc_bits;	// config-mixins.scala:436:26
  wire         _components_3_io_resp_f2_1_is_br;	// config-mixins.scala:436:26
  wire         _components_3_io_resp_f2_1_is_jal;	// config-mixins.scala:436:26
  wire         _components_3_io_resp_f2_1_predicted_pc_valid;	// config-mixins.scala:436:26
  wire [39:0]  _components_3_io_resp_f2_1_predicted_pc_bits;	// config-mixins.scala:436:26
  wire         _components_3_io_resp_f2_2_is_br;	// config-mixins.scala:436:26
  wire         _components_3_io_resp_f2_2_is_jal;	// config-mixins.scala:436:26
  wire         _components_3_io_resp_f2_2_predicted_pc_valid;	// config-mixins.scala:436:26
  wire [39:0]  _components_3_io_resp_f2_2_predicted_pc_bits;	// config-mixins.scala:436:26
  wire         _components_3_io_resp_f2_3_is_br;	// config-mixins.scala:436:26
  wire         _components_3_io_resp_f2_3_is_jal;	// config-mixins.scala:436:26
  wire         _components_3_io_resp_f2_3_predicted_pc_valid;	// config-mixins.scala:436:26
  wire [39:0]  _components_3_io_resp_f2_3_predicted_pc_bits;	// config-mixins.scala:436:26
  wire         _components_3_io_resp_f3_0_is_br;	// config-mixins.scala:436:26
  wire         _components_3_io_resp_f3_0_is_jal;	// config-mixins.scala:436:26
  wire         _components_3_io_resp_f3_0_predicted_pc_valid;	// config-mixins.scala:436:26
  wire [39:0]  _components_3_io_resp_f3_0_predicted_pc_bits;	// config-mixins.scala:436:26
  wire         _components_3_io_resp_f3_1_is_br;	// config-mixins.scala:436:26
  wire         _components_3_io_resp_f3_1_is_jal;	// config-mixins.scala:436:26
  wire         _components_3_io_resp_f3_1_predicted_pc_valid;	// config-mixins.scala:436:26
  wire [39:0]  _components_3_io_resp_f3_1_predicted_pc_bits;	// config-mixins.scala:436:26
  wire         _components_3_io_resp_f3_2_is_br;	// config-mixins.scala:436:26
  wire         _components_3_io_resp_f3_2_is_jal;	// config-mixins.scala:436:26
  wire         _components_3_io_resp_f3_2_predicted_pc_valid;	// config-mixins.scala:436:26
  wire [39:0]  _components_3_io_resp_f3_2_predicted_pc_bits;	// config-mixins.scala:436:26
  wire         _components_3_io_resp_f3_3_is_br;	// config-mixins.scala:436:26
  wire         _components_3_io_resp_f3_3_is_jal;	// config-mixins.scala:436:26
  wire         _components_3_io_resp_f3_3_predicted_pc_valid;	// config-mixins.scala:436:26
  wire [39:0]  _components_3_io_resp_f3_3_predicted_pc_bits;	// config-mixins.scala:436:26
  wire [119:0] _components_3_io_f3_meta;	// config-mixins.scala:436:26
  wire         _components_4_io_resp_f2_0_taken;	// config-mixins.scala:435:25
  wire         _components_4_io_resp_f2_1_taken;	// config-mixins.scala:435:25
  wire         _components_4_io_resp_f2_2_taken;	// config-mixins.scala:435:25
  wire         _components_4_io_resp_f2_3_taken;	// config-mixins.scala:435:25
  wire         _components_4_io_resp_f3_0_taken;	// config-mixins.scala:435:25
  wire         _components_4_io_resp_f3_1_taken;	// config-mixins.scala:435:25
  wire         _components_4_io_resp_f3_2_taken;	// config-mixins.scala:435:25
  wire         _components_4_io_resp_f3_3_taken;	// config-mixins.scala:435:25
  wire [119:0] _components_4_io_f3_meta;	// config-mixins.scala:435:25
  wire         _components_2_io_resp_f2_0_is_br;	// config-mixins.scala:434:25
  wire         _components_2_io_resp_f2_0_predicted_pc_valid;	// config-mixins.scala:434:25
  wire         _components_2_io_resp_f2_1_is_br;	// config-mixins.scala:434:25
  wire         _components_2_io_resp_f2_1_predicted_pc_valid;	// config-mixins.scala:434:25
  wire         _components_2_io_resp_f2_2_is_br;	// config-mixins.scala:434:25
  wire         _components_2_io_resp_f2_2_predicted_pc_valid;	// config-mixins.scala:434:25
  wire         _components_2_io_resp_f2_3_is_br;	// config-mixins.scala:434:25
  wire         _components_2_io_resp_f2_3_predicted_pc_valid;	// config-mixins.scala:434:25
  wire         _components_2_io_resp_f3_0_taken;	// config-mixins.scala:434:25
  wire         _components_2_io_resp_f3_1_taken;	// config-mixins.scala:434:25
  wire         _components_2_io_resp_f3_2_taken;	// config-mixins.scala:434:25
  wire         _components_2_io_resp_f3_3_taken;	// config-mixins.scala:434:25
  wire [119:0] _components_2_io_f3_meta;	// config-mixins.scala:434:25
  wire         _components_1_io_resp_f3_0_taken;	// config-mixins.scala:433:26
  wire         _components_1_io_resp_f3_1_taken;	// config-mixins.scala:433:26
  wire         _components_1_io_resp_f3_2_taken;	// config-mixins.scala:433:26
  wire         _components_1_io_resp_f3_3_taken;	// config-mixins.scala:433:26
  wire [119:0] _components_1_io_f3_meta;	// config-mixins.scala:433:26
  wire [119:0] _components_0_io_f3_meta;	// config-mixins.scala:432:26
  LoopBranchPredictorBank_4 components_0 (	// config-mixins.scala:432:26
    .clock                                (clock),
    .reset                                (reset),
    .io_f0_valid                          (io_f0_valid),
    .io_f0_pc                             (io_f0_pc),
    .io_f0_mask                           (io_f0_mask),
    .io_resp_in_0_f2_0_is_br              (_components_2_io_resp_f2_0_is_br),	// config-mixins.scala:434:25
    .io_resp_in_0_f2_0_predicted_pc_valid (_components_2_io_resp_f2_0_predicted_pc_valid),	// config-mixins.scala:434:25
    .io_resp_in_0_f2_1_is_br              (_components_2_io_resp_f2_1_is_br),	// config-mixins.scala:434:25
    .io_resp_in_0_f2_1_predicted_pc_valid (_components_2_io_resp_f2_1_predicted_pc_valid),	// config-mixins.scala:434:25
    .io_resp_in_0_f2_2_is_br              (_components_2_io_resp_f2_2_is_br),	// config-mixins.scala:434:25
    .io_resp_in_0_f2_2_predicted_pc_valid (_components_2_io_resp_f2_2_predicted_pc_valid),	// config-mixins.scala:434:25
    .io_resp_in_0_f2_3_is_br              (_components_2_io_resp_f2_3_is_br),	// config-mixins.scala:434:25
    .io_resp_in_0_f2_3_predicted_pc_valid (_components_2_io_resp_f2_3_predicted_pc_valid),	// config-mixins.scala:434:25
    .io_resp_in_0_f3_0_taken              (_components_1_io_resp_f3_0_taken),	// config-mixins.scala:433:26
    .io_resp_in_0_f3_1_taken              (_components_1_io_resp_f3_1_taken),	// config-mixins.scala:433:26
    .io_resp_in_0_f3_2_taken              (_components_1_io_resp_f3_2_taken),	// config-mixins.scala:433:26
    .io_resp_in_0_f3_3_taken              (_components_1_io_resp_f3_3_taken),	// config-mixins.scala:433:26
    .io_f3_fire                           (io_f3_fire),
    .io_update_valid                      (io_update_valid),
    .io_update_bits_is_mispredict_update  (io_update_bits_is_mispredict_update),
    .io_update_bits_is_repair_update      (io_update_bits_is_repair_update),
    .io_update_bits_pc                    (io_update_bits_pc),
    .io_update_bits_br_mask               (io_update_bits_br_mask),
    .io_update_bits_cfi_mispredicted      (io_update_bits_cfi_mispredicted),
    .io_update_bits_meta                  ({73'h0, io_update_bits_meta[119:73]}),	// composer.scala:42:27, :43:31
    .io_resp_f3_0_taken                   (io_resp_f3_0_taken),
    .io_resp_f3_1_taken                   (io_resp_f3_1_taken),
    .io_resp_f3_2_taken                   (io_resp_f3_2_taken),
    .io_resp_f3_3_taken                   (io_resp_f3_3_taken),
    .io_f3_meta                           (_components_0_io_f3_meta)
  );
  TageBranchPredictorBank_4 components_1 (	// config-mixins.scala:433:26
    .clock                               (clock),
    .reset                               (reset),
    .io_f0_valid                         (io_f0_valid),
    .io_f0_pc                            (io_f0_pc),
    .io_f1_ghist                         (io_f1_ghist),
    .io_resp_in_0_f3_0_taken             (_components_2_io_resp_f3_0_taken),	// config-mixins.scala:434:25
    .io_resp_in_0_f3_1_taken             (_components_2_io_resp_f3_1_taken),	// config-mixins.scala:434:25
    .io_resp_in_0_f3_2_taken             (_components_2_io_resp_f3_2_taken),	// config-mixins.scala:434:25
    .io_resp_in_0_f3_3_taken             (_components_2_io_resp_f3_3_taken),	// config-mixins.scala:434:25
    .io_update_valid                     (io_update_valid),
    .io_update_bits_is_mispredict_update (io_update_bits_is_mispredict_update),
    .io_update_bits_is_repair_update     (io_update_bits_is_repair_update),
    .io_update_bits_btb_mispredicts      (io_update_bits_btb_mispredicts),
    .io_update_bits_pc                   (io_update_bits_pc),
    .io_update_bits_br_mask              (io_update_bits_br_mask),
    .io_update_bits_cfi_idx_valid        (io_update_bits_cfi_idx_valid),
    .io_update_bits_cfi_idx_bits         (io_update_bits_cfi_idx_bits),
    .io_update_bits_cfi_taken            (io_update_bits_cfi_taken),
    .io_update_bits_cfi_mispredicted     (io_update_bits_cfi_mispredicted),
    .io_update_bits_ghist                (io_update_bits_ghist),
    .io_update_bits_meta                 ({17'h0, io_update_bits_meta[119:17]}),	// composer.scala:42:27, :43:31
    .io_resp_f3_0_taken                  (_components_1_io_resp_f3_0_taken),
    .io_resp_f3_1_taken                  (_components_1_io_resp_f3_1_taken),
    .io_resp_f3_2_taken                  (_components_1_io_resp_f3_2_taken),
    .io_resp_f3_3_taken                  (_components_1_io_resp_f3_3_taken),
    .io_f3_meta                          (_components_1_io_f3_meta)
  );
  BTBBranchPredictorBank_4 components_2 (	// config-mixins.scala:434:25
    .clock                                (clock),
    .reset                                (reset),
    .io_f0_valid                          (io_f0_valid),
    .io_f0_pc                             (io_f0_pc),
    .io_resp_in_0_f2_0_taken              (_components_4_io_resp_f2_0_taken),	// config-mixins.scala:435:25
    .io_resp_in_0_f2_0_is_br              (_components_3_io_resp_f2_0_is_br),	// config-mixins.scala:436:26
    .io_resp_in_0_f2_0_is_jal             (_components_3_io_resp_f2_0_is_jal),	// config-mixins.scala:436:26
    .io_resp_in_0_f2_0_predicted_pc_valid (_components_3_io_resp_f2_0_predicted_pc_valid),	// config-mixins.scala:436:26
    .io_resp_in_0_f2_0_predicted_pc_bits  (_components_3_io_resp_f2_0_predicted_pc_bits),	// config-mixins.scala:436:26
    .io_resp_in_0_f2_1_taken              (_components_4_io_resp_f2_1_taken),	// config-mixins.scala:435:25
    .io_resp_in_0_f2_1_is_br              (_components_3_io_resp_f2_1_is_br),	// config-mixins.scala:436:26
    .io_resp_in_0_f2_1_is_jal             (_components_3_io_resp_f2_1_is_jal),	// config-mixins.scala:436:26
    .io_resp_in_0_f2_1_predicted_pc_valid (_components_3_io_resp_f2_1_predicted_pc_valid),	// config-mixins.scala:436:26
    .io_resp_in_0_f2_1_predicted_pc_bits  (_components_3_io_resp_f2_1_predicted_pc_bits),	// config-mixins.scala:436:26
    .io_resp_in_0_f2_2_taken              (_components_4_io_resp_f2_2_taken),	// config-mixins.scala:435:25
    .io_resp_in_0_f2_2_is_br              (_components_3_io_resp_f2_2_is_br),	// config-mixins.scala:436:26
    .io_resp_in_0_f2_2_is_jal             (_components_3_io_resp_f2_2_is_jal),	// config-mixins.scala:436:26
    .io_resp_in_0_f2_2_predicted_pc_valid (_components_3_io_resp_f2_2_predicted_pc_valid),	// config-mixins.scala:436:26
    .io_resp_in_0_f2_2_predicted_pc_bits  (_components_3_io_resp_f2_2_predicted_pc_bits),	// config-mixins.scala:436:26
    .io_resp_in_0_f2_3_taken              (_components_4_io_resp_f2_3_taken),	// config-mixins.scala:435:25
    .io_resp_in_0_f2_3_is_br              (_components_3_io_resp_f2_3_is_br),	// config-mixins.scala:436:26
    .io_resp_in_0_f2_3_is_jal             (_components_3_io_resp_f2_3_is_jal),	// config-mixins.scala:436:26
    .io_resp_in_0_f2_3_predicted_pc_valid (_components_3_io_resp_f2_3_predicted_pc_valid),	// config-mixins.scala:436:26
    .io_resp_in_0_f2_3_predicted_pc_bits  (_components_3_io_resp_f2_3_predicted_pc_bits),	// config-mixins.scala:436:26
    .io_resp_in_0_f3_0_taken              (_components_4_io_resp_f3_0_taken),	// config-mixins.scala:435:25
    .io_resp_in_0_f3_0_is_br              (_components_3_io_resp_f3_0_is_br),	// config-mixins.scala:436:26
    .io_resp_in_0_f3_0_is_jal             (_components_3_io_resp_f3_0_is_jal),	// config-mixins.scala:436:26
    .io_resp_in_0_f3_0_predicted_pc_valid (_components_3_io_resp_f3_0_predicted_pc_valid),	// config-mixins.scala:436:26
    .io_resp_in_0_f3_0_predicted_pc_bits  (_components_3_io_resp_f3_0_predicted_pc_bits),	// config-mixins.scala:436:26
    .io_resp_in_0_f3_1_taken              (_components_4_io_resp_f3_1_taken),	// config-mixins.scala:435:25
    .io_resp_in_0_f3_1_is_br              (_components_3_io_resp_f3_1_is_br),	// config-mixins.scala:436:26
    .io_resp_in_0_f3_1_is_jal             (_components_3_io_resp_f3_1_is_jal),	// config-mixins.scala:436:26
    .io_resp_in_0_f3_1_predicted_pc_valid (_components_3_io_resp_f3_1_predicted_pc_valid),	// config-mixins.scala:436:26
    .io_resp_in_0_f3_1_predicted_pc_bits  (_components_3_io_resp_f3_1_predicted_pc_bits),	// config-mixins.scala:436:26
    .io_resp_in_0_f3_2_taken              (_components_4_io_resp_f3_2_taken),	// config-mixins.scala:435:25
    .io_resp_in_0_f3_2_is_br              (_components_3_io_resp_f3_2_is_br),	// config-mixins.scala:436:26
    .io_resp_in_0_f3_2_is_jal             (_components_3_io_resp_f3_2_is_jal),	// config-mixins.scala:436:26
    .io_resp_in_0_f3_2_predicted_pc_valid (_components_3_io_resp_f3_2_predicted_pc_valid),	// config-mixins.scala:436:26
    .io_resp_in_0_f3_2_predicted_pc_bits  (_components_3_io_resp_f3_2_predicted_pc_bits),	// config-mixins.scala:436:26
    .io_resp_in_0_f3_3_taken              (_components_4_io_resp_f3_3_taken),	// config-mixins.scala:435:25
    .io_resp_in_0_f3_3_is_br              (_components_3_io_resp_f3_3_is_br),	// config-mixins.scala:436:26
    .io_resp_in_0_f3_3_is_jal             (_components_3_io_resp_f3_3_is_jal),	// config-mixins.scala:436:26
    .io_resp_in_0_f3_3_predicted_pc_valid (_components_3_io_resp_f3_3_predicted_pc_valid),	// config-mixins.scala:436:26
    .io_resp_in_0_f3_3_predicted_pc_bits  (_components_3_io_resp_f3_3_predicted_pc_bits),	// config-mixins.scala:436:26
    .io_update_valid                      (io_update_valid),
    .io_update_bits_is_mispredict_update  (io_update_bits_is_mispredict_update),
    .io_update_bits_is_repair_update      (io_update_bits_is_repair_update),
    .io_update_bits_btb_mispredicts       (io_update_bits_btb_mispredicts),
    .io_update_bits_pc                    (io_update_bits_pc),
    .io_update_bits_br_mask               (io_update_bits_br_mask),
    .io_update_bits_cfi_idx_valid         (io_update_bits_cfi_idx_valid),
    .io_update_bits_cfi_idx_bits          (io_update_bits_cfi_idx_bits),
    .io_update_bits_cfi_taken             (io_update_bits_cfi_taken),
    .io_update_bits_target                (io_update_bits_target),
    .io_update_bits_meta                  ({16'h0, io_update_bits_meta[119:16]}),	// composer.scala:42:27, :43:31
    .io_resp_f2_0_taken                   (io_resp_f2_0_taken),
    .io_resp_f2_0_is_br                   (_components_2_io_resp_f2_0_is_br),
    .io_resp_f2_0_is_jal                  (io_resp_f2_0_is_jal),
    .io_resp_f2_0_predicted_pc_valid      (_components_2_io_resp_f2_0_predicted_pc_valid),
    .io_resp_f2_0_predicted_pc_bits       (io_resp_f2_0_predicted_pc_bits),
    .io_resp_f2_1_taken                   (io_resp_f2_1_taken),
    .io_resp_f2_1_is_br                   (_components_2_io_resp_f2_1_is_br),
    .io_resp_f2_1_is_jal                  (io_resp_f2_1_is_jal),
    .io_resp_f2_1_predicted_pc_valid      (_components_2_io_resp_f2_1_predicted_pc_valid),
    .io_resp_f2_1_predicted_pc_bits       (io_resp_f2_1_predicted_pc_bits),
    .io_resp_f2_2_taken                   (io_resp_f2_2_taken),
    .io_resp_f2_2_is_br                   (_components_2_io_resp_f2_2_is_br),
    .io_resp_f2_2_is_jal                  (io_resp_f2_2_is_jal),
    .io_resp_f2_2_predicted_pc_valid      (_components_2_io_resp_f2_2_predicted_pc_valid),
    .io_resp_f2_2_predicted_pc_bits       (io_resp_f2_2_predicted_pc_bits),
    .io_resp_f2_3_taken                   (io_resp_f2_3_taken),
    .io_resp_f2_3_is_br                   (_components_2_io_resp_f2_3_is_br),
    .io_resp_f2_3_is_jal                  (io_resp_f2_3_is_jal),
    .io_resp_f2_3_predicted_pc_valid      (_components_2_io_resp_f2_3_predicted_pc_valid),
    .io_resp_f2_3_predicted_pc_bits       (io_resp_f2_3_predicted_pc_bits),
    .io_resp_f3_0_taken                   (_components_2_io_resp_f3_0_taken),
    .io_resp_f3_0_is_br                   (io_resp_f3_0_is_br),
    .io_resp_f3_0_is_jal                  (io_resp_f3_0_is_jal),
    .io_resp_f3_0_predicted_pc_valid      (io_resp_f3_0_predicted_pc_valid),
    .io_resp_f3_0_predicted_pc_bits       (io_resp_f3_0_predicted_pc_bits),
    .io_resp_f3_1_taken                   (_components_2_io_resp_f3_1_taken),
    .io_resp_f3_1_is_br                   (io_resp_f3_1_is_br),
    .io_resp_f3_1_is_jal                  (io_resp_f3_1_is_jal),
    .io_resp_f3_1_predicted_pc_valid      (io_resp_f3_1_predicted_pc_valid),
    .io_resp_f3_1_predicted_pc_bits       (io_resp_f3_1_predicted_pc_bits),
    .io_resp_f3_2_taken                   (_components_2_io_resp_f3_2_taken),
    .io_resp_f3_2_is_br                   (io_resp_f3_2_is_br),
    .io_resp_f3_2_is_jal                  (io_resp_f3_2_is_jal),
    .io_resp_f3_2_predicted_pc_valid      (io_resp_f3_2_predicted_pc_valid),
    .io_resp_f3_2_predicted_pc_bits       (io_resp_f3_2_predicted_pc_bits),
    .io_resp_f3_3_taken                   (_components_2_io_resp_f3_3_taken),
    .io_resp_f3_3_is_br                   (io_resp_f3_3_is_br),
    .io_resp_f3_3_is_jal                  (io_resp_f3_3_is_jal),
    .io_resp_f3_3_predicted_pc_valid      (io_resp_f3_3_predicted_pc_valid),
    .io_resp_f3_3_predicted_pc_bits       (io_resp_f3_3_predicted_pc_bits),
    .io_f3_meta                           (_components_2_io_f3_meta)
  );
  BIMBranchPredictorBank_4 components_4 (	// config-mixins.scala:435:25
    .clock                               (clock),
    .reset                               (reset),
    .io_f0_valid                         (io_f0_valid),
    .io_f0_pc                            (io_f0_pc),
    .io_update_valid                     (io_update_valid),
    .io_update_bits_is_mispredict_update (io_update_bits_is_mispredict_update),
    .io_update_bits_is_repair_update     (io_update_bits_is_repair_update),
    .io_update_bits_btb_mispredicts      (io_update_bits_btb_mispredicts),
    .io_update_bits_pc                   (io_update_bits_pc),
    .io_update_bits_br_mask              (io_update_bits_br_mask),
    .io_update_bits_cfi_idx_valid        (io_update_bits_cfi_idx_valid),
    .io_update_bits_cfi_idx_bits         (io_update_bits_cfi_idx_bits),
    .io_update_bits_cfi_taken            (io_update_bits_cfi_taken),
    .io_update_bits_cfi_is_br            (io_update_bits_cfi_is_br),
    .io_update_bits_cfi_is_jal           (io_update_bits_cfi_is_jal),
    .io_update_bits_meta                 (io_update_bits_meta),
    .io_resp_f2_0_taken                  (_components_4_io_resp_f2_0_taken),
    .io_resp_f2_1_taken                  (_components_4_io_resp_f2_1_taken),
    .io_resp_f2_2_taken                  (_components_4_io_resp_f2_2_taken),
    .io_resp_f2_3_taken                  (_components_4_io_resp_f2_3_taken),
    .io_resp_f3_0_taken                  (_components_4_io_resp_f3_0_taken),
    .io_resp_f3_1_taken                  (_components_4_io_resp_f3_1_taken),
    .io_resp_f3_2_taken                  (_components_4_io_resp_f3_2_taken),
    .io_resp_f3_3_taken                  (_components_4_io_resp_f3_3_taken),
    .io_f3_meta                          (_components_4_io_f3_meta)
  );
  FAMicroBTBBranchPredictorBank_4 components_3 (	// config-mixins.scala:436:26
    .clock                               (clock),
    .reset                               (reset),
    .io_f0_valid                         (io_f0_valid),
    .io_f0_pc                            (io_f0_pc),
    .io_update_valid                     (io_update_valid),
    .io_update_bits_is_mispredict_update (io_update_bits_is_mispredict_update),
    .io_update_bits_is_repair_update     (io_update_bits_is_repair_update),
    .io_update_bits_btb_mispredicts      (io_update_bits_btb_mispredicts),
    .io_update_bits_pc                   (io_update_bits_pc),
    .io_update_bits_br_mask              (io_update_bits_br_mask),
    .io_update_bits_cfi_idx_valid        (io_update_bits_cfi_idx_valid),
    .io_update_bits_cfi_idx_bits         (io_update_bits_cfi_idx_bits),
    .io_update_bits_cfi_taken            (io_update_bits_cfi_taken),
    .io_update_bits_cfi_is_jal           (io_update_bits_cfi_is_jal),
    .io_update_bits_target               (io_update_bits_target),
    .io_update_bits_meta                 ({8'h0, io_update_bits_meta[119:8]}),	// composer.scala:31:22, :42:27, :43:31
    .io_resp_f1_0_taken                  (io_resp_f1_0_taken),
    .io_resp_f1_0_is_br                  (io_resp_f1_0_is_br),
    .io_resp_f1_0_is_jal                 (io_resp_f1_0_is_jal),
    .io_resp_f1_0_predicted_pc_valid     (io_resp_f1_0_predicted_pc_valid),
    .io_resp_f1_0_predicted_pc_bits      (io_resp_f1_0_predicted_pc_bits),
    .io_resp_f1_1_taken                  (io_resp_f1_1_taken),
    .io_resp_f1_1_is_br                  (io_resp_f1_1_is_br),
    .io_resp_f1_1_is_jal                 (io_resp_f1_1_is_jal),
    .io_resp_f1_1_predicted_pc_valid     (io_resp_f1_1_predicted_pc_valid),
    .io_resp_f1_1_predicted_pc_bits      (io_resp_f1_1_predicted_pc_bits),
    .io_resp_f1_2_taken                  (io_resp_f1_2_taken),
    .io_resp_f1_2_is_br                  (io_resp_f1_2_is_br),
    .io_resp_f1_2_is_jal                 (io_resp_f1_2_is_jal),
    .io_resp_f1_2_predicted_pc_valid     (io_resp_f1_2_predicted_pc_valid),
    .io_resp_f1_2_predicted_pc_bits      (io_resp_f1_2_predicted_pc_bits),
    .io_resp_f1_3_taken                  (io_resp_f1_3_taken),
    .io_resp_f1_3_is_br                  (io_resp_f1_3_is_br),
    .io_resp_f1_3_is_jal                 (io_resp_f1_3_is_jal),
    .io_resp_f1_3_predicted_pc_valid     (io_resp_f1_3_predicted_pc_valid),
    .io_resp_f1_3_predicted_pc_bits      (io_resp_f1_3_predicted_pc_bits),
    .io_resp_f2_0_is_br                  (_components_3_io_resp_f2_0_is_br),
    .io_resp_f2_0_is_jal                 (_components_3_io_resp_f2_0_is_jal),
    .io_resp_f2_0_predicted_pc_valid     (_components_3_io_resp_f2_0_predicted_pc_valid),
    .io_resp_f2_0_predicted_pc_bits      (_components_3_io_resp_f2_0_predicted_pc_bits),
    .io_resp_f2_1_is_br                  (_components_3_io_resp_f2_1_is_br),
    .io_resp_f2_1_is_jal                 (_components_3_io_resp_f2_1_is_jal),
    .io_resp_f2_1_predicted_pc_valid     (_components_3_io_resp_f2_1_predicted_pc_valid),
    .io_resp_f2_1_predicted_pc_bits      (_components_3_io_resp_f2_1_predicted_pc_bits),
    .io_resp_f2_2_is_br                  (_components_3_io_resp_f2_2_is_br),
    .io_resp_f2_2_is_jal                 (_components_3_io_resp_f2_2_is_jal),
    .io_resp_f2_2_predicted_pc_valid     (_components_3_io_resp_f2_2_predicted_pc_valid),
    .io_resp_f2_2_predicted_pc_bits      (_components_3_io_resp_f2_2_predicted_pc_bits),
    .io_resp_f2_3_is_br                  (_components_3_io_resp_f2_3_is_br),
    .io_resp_f2_3_is_jal                 (_components_3_io_resp_f2_3_is_jal),
    .io_resp_f2_3_predicted_pc_valid     (_components_3_io_resp_f2_3_predicted_pc_valid),
    .io_resp_f2_3_predicted_pc_bits      (_components_3_io_resp_f2_3_predicted_pc_bits),
    .io_resp_f3_0_is_br                  (_components_3_io_resp_f3_0_is_br),
    .io_resp_f3_0_is_jal                 (_components_3_io_resp_f3_0_is_jal),
    .io_resp_f3_0_predicted_pc_valid     (_components_3_io_resp_f3_0_predicted_pc_valid),
    .io_resp_f3_0_predicted_pc_bits      (_components_3_io_resp_f3_0_predicted_pc_bits),
    .io_resp_f3_1_is_br                  (_components_3_io_resp_f3_1_is_br),
    .io_resp_f3_1_is_jal                 (_components_3_io_resp_f3_1_is_jal),
    .io_resp_f3_1_predicted_pc_valid     (_components_3_io_resp_f3_1_predicted_pc_valid),
    .io_resp_f3_1_predicted_pc_bits      (_components_3_io_resp_f3_1_predicted_pc_bits),
    .io_resp_f3_2_is_br                  (_components_3_io_resp_f3_2_is_br),
    .io_resp_f3_2_is_jal                 (_components_3_io_resp_f3_2_is_jal),
    .io_resp_f3_2_predicted_pc_valid     (_components_3_io_resp_f3_2_predicted_pc_valid),
    .io_resp_f3_2_predicted_pc_bits      (_components_3_io_resp_f3_2_predicted_pc_bits),
    .io_resp_f3_3_is_br                  (_components_3_io_resp_f3_3_is_br),
    .io_resp_f3_3_is_jal                 (_components_3_io_resp_f3_3_is_jal),
    .io_resp_f3_3_predicted_pc_valid     (_components_3_io_resp_f3_3_predicted_pc_valid),
    .io_resp_f3_3_predicted_pc_bits      (_components_3_io_resp_f3_3_predicted_pc_bits),
    .io_f3_meta                          (_components_3_io_f3_meta)
  );
  assign io_resp_f2_0_is_br = _components_2_io_resp_f2_0_is_br;	// config-mixins.scala:434:25
  assign io_resp_f2_0_predicted_pc_valid = _components_2_io_resp_f2_0_predicted_pc_valid;	// config-mixins.scala:434:25
  assign io_resp_f2_1_is_br = _components_2_io_resp_f2_1_is_br;	// config-mixins.scala:434:25
  assign io_resp_f2_1_predicted_pc_valid = _components_2_io_resp_f2_1_predicted_pc_valid;	// config-mixins.scala:434:25
  assign io_resp_f2_2_is_br = _components_2_io_resp_f2_2_is_br;	// config-mixins.scala:434:25
  assign io_resp_f2_2_predicted_pc_valid = _components_2_io_resp_f2_2_predicted_pc_valid;	// config-mixins.scala:434:25
  assign io_resp_f2_3_is_br = _components_2_io_resp_f2_3_is_br;	// config-mixins.scala:434:25
  assign io_resp_f2_3_predicted_pc_valid = _components_2_io_resp_f2_3_predicted_pc_valid;	// config-mixins.scala:434:25
  assign io_f3_meta =
    {7'h0,
     _components_0_io_f3_meta[39:0],
     _components_1_io_f3_meta[55:0],
     _components_2_io_f3_meta[0],
     _components_3_io_f3_meta[7:0],
     _components_4_io_f3_meta[7:0]};	// composer.scala:31:49, :36:14, config-mixins.scala:432:26, :433:26, :434:25, :435:25, :436:26
endmodule

