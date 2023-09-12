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

module FetchTargetQueue_2(
  input          clock,
                 reset,
                 io_enq_valid,
  input  [39:0]  io_enq_bits_pc,
  input          io_enq_bits_cfi_idx_valid,
  input  [1:0]   io_enq_bits_cfi_idx_bits,
  input  [2:0]   io_enq_bits_cfi_type,
  input          io_enq_bits_cfi_is_call,
                 io_enq_bits_cfi_is_ret,
  input  [39:0]  io_enq_bits_ras_top,
  input  [3:0]   io_enq_bits_mask,
                 io_enq_bits_br_mask,
  input  [63:0]  io_enq_bits_ghist_old_history,
  input          io_enq_bits_ghist_current_saw_branch_not_taken,
                 io_enq_bits_ghist_new_saw_branch_not_taken,
                 io_enq_bits_ghist_new_saw_branch_taken,
  input  [4:0]   io_enq_bits_ghist_ras_idx,
  input  [119:0] io_enq_bits_bpd_meta_0,
  input          io_deq_valid,
  input  [4:0]   io_deq_bits,
                 io_get_ftq_pc_0_ftq_idx,
                 io_get_ftq_pc_1_ftq_idx,
  input          io_redirect_valid,
  input  [4:0]   io_redirect_bits,
                 io_brupdate_b2_uop_ftq_idx,
  input  [5:0]   io_brupdate_b2_uop_pc_lob,
  input          io_brupdate_b2_mispredict,
                 io_brupdate_b2_taken,
  output         io_enq_ready,
  output [4:0]   io_enq_idx,
  output         io_get_ftq_pc_0_entry_cfi_idx_valid,
  output [1:0]   io_get_ftq_pc_0_entry_cfi_idx_bits,
  output [4:0]   io_get_ftq_pc_0_entry_ras_idx,
  output         io_get_ftq_pc_0_entry_start_bank,
  output [39:0]  io_get_ftq_pc_0_pc,
                 io_get_ftq_pc_0_com_pc,
  output         io_get_ftq_pc_0_next_val,
  output [39:0]  io_get_ftq_pc_0_next_pc,
  output [1:0]   io_get_ftq_pc_1_entry_cfi_idx_bits,
  output [3:0]   io_get_ftq_pc_1_entry_br_mask,
  output         io_get_ftq_pc_1_entry_cfi_is_call,
                 io_get_ftq_pc_1_entry_cfi_is_ret,
                 io_get_ftq_pc_1_entry_start_bank,
  output [63:0]  io_get_ftq_pc_1_ghist_old_history,
  output         io_get_ftq_pc_1_ghist_current_saw_branch_not_taken,
                 io_get_ftq_pc_1_ghist_new_saw_branch_not_taken,
                 io_get_ftq_pc_1_ghist_new_saw_branch_taken,
  output [4:0]   io_get_ftq_pc_1_ghist_ras_idx,
  output [39:0]  io_get_ftq_pc_1_pc,
  output         io_bpdupdate_valid,
                 io_bpdupdate_bits_is_mispredict_update,
                 io_bpdupdate_bits_is_repair_update,
  output [39:0]  io_bpdupdate_bits_pc,
  output [3:0]   io_bpdupdate_bits_br_mask,
  output         io_bpdupdate_bits_cfi_idx_valid,
  output [1:0]   io_bpdupdate_bits_cfi_idx_bits,
  output         io_bpdupdate_bits_cfi_taken,
                 io_bpdupdate_bits_cfi_mispredicted,
                 io_bpdupdate_bits_cfi_is_br,
                 io_bpdupdate_bits_cfi_is_jal,
  output [63:0]  io_bpdupdate_bits_ghist_old_history,
  output [39:0]  io_bpdupdate_bits_target,
  output [119:0] io_bpdupdate_bits_meta_0,
  output         io_ras_update,
  output [4:0]   io_ras_update_idx,
  output [39:0]  io_ras_update_pc
);

  reg         io_enq_ready_REG;	// fetch-target-queue.scala:308:26
  wire [4:0]  ghist_1_MPORT_1_data_ras_idx;	// fetch-target-queue.scala:178:24
  wire        ghist_1_MPORT_1_data_new_saw_branch_taken;	// fetch-target-queue.scala:178:24
  wire        ghist_1_MPORT_1_data_new_saw_branch_not_taken;	// fetch-target-queue.scala:178:24
  wire [63:0] ghist_1_MPORT_1_data_old_history;	// fetch-target-queue.scala:178:24
  wire [71:0] _ghist_1_ext_R0_data;	// fetch-target-queue.scala:144:43
  wire [71:0] _ghist_0_ext_R0_data;	// fetch-target-queue.scala:144:43
  reg  [4:0]  bpd_ptr;	// fetch-target-queue.scala:133:27
  reg  [4:0]  deq_ptr;	// fetch-target-queue.scala:134:27
  reg  [4:0]  enq_ptr;	// fetch-target-queue.scala:135:27
  reg  [39:0] pcs_0;	// fetch-target-queue.scala:141:21
  reg  [39:0] pcs_1;	// fetch-target-queue.scala:141:21
  reg  [39:0] pcs_2;	// fetch-target-queue.scala:141:21
  reg  [39:0] pcs_3;	// fetch-target-queue.scala:141:21
  reg  [39:0] pcs_4;	// fetch-target-queue.scala:141:21
  reg  [39:0] pcs_5;	// fetch-target-queue.scala:141:21
  reg  [39:0] pcs_6;	// fetch-target-queue.scala:141:21
  reg  [39:0] pcs_7;	// fetch-target-queue.scala:141:21
  reg  [39:0] pcs_8;	// fetch-target-queue.scala:141:21
  reg  [39:0] pcs_9;	// fetch-target-queue.scala:141:21
  reg  [39:0] pcs_10;	// fetch-target-queue.scala:141:21
  reg  [39:0] pcs_11;	// fetch-target-queue.scala:141:21
  reg  [39:0] pcs_12;	// fetch-target-queue.scala:141:21
  reg  [39:0] pcs_13;	// fetch-target-queue.scala:141:21
  reg  [39:0] pcs_14;	// fetch-target-queue.scala:141:21
  reg  [39:0] pcs_15;	// fetch-target-queue.scala:141:21
  reg  [39:0] pcs_16;	// fetch-target-queue.scala:141:21
  reg  [39:0] pcs_17;	// fetch-target-queue.scala:141:21
  reg  [39:0] pcs_18;	// fetch-target-queue.scala:141:21
  reg  [39:0] pcs_19;	// fetch-target-queue.scala:141:21
  reg  [39:0] pcs_20;	// fetch-target-queue.scala:141:21
  reg  [39:0] pcs_21;	// fetch-target-queue.scala:141:21
  reg  [39:0] pcs_22;	// fetch-target-queue.scala:141:21
  reg  [39:0] pcs_23;	// fetch-target-queue.scala:141:21
  reg  [39:0] pcs_24;	// fetch-target-queue.scala:141:21
  reg  [39:0] pcs_25;	// fetch-target-queue.scala:141:21
  reg  [39:0] pcs_26;	// fetch-target-queue.scala:141:21
  reg  [39:0] pcs_27;	// fetch-target-queue.scala:141:21
  reg  [39:0] pcs_28;	// fetch-target-queue.scala:141:21
  reg  [39:0] pcs_29;	// fetch-target-queue.scala:141:21
  reg  [39:0] pcs_30;	// fetch-target-queue.scala:141:21
  reg  [39:0] pcs_31;	// fetch-target-queue.scala:141:21
  reg         ram_0_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [1:0]  ram_0_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg         ram_0_cfi_taken;	// fetch-target-queue.scala:143:21
  reg         ram_0_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]  ram_0_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [3:0]  ram_0_br_mask;	// fetch-target-queue.scala:143:21
  reg         ram_0_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg         ram_0_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0] ram_0_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]  ram_0_ras_idx;	// fetch-target-queue.scala:143:21
  reg         ram_0_start_bank;	// fetch-target-queue.scala:143:21
  reg         ram_1_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [1:0]  ram_1_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg         ram_1_cfi_taken;	// fetch-target-queue.scala:143:21
  reg         ram_1_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]  ram_1_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [3:0]  ram_1_br_mask;	// fetch-target-queue.scala:143:21
  reg         ram_1_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg         ram_1_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0] ram_1_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]  ram_1_ras_idx;	// fetch-target-queue.scala:143:21
  reg         ram_1_start_bank;	// fetch-target-queue.scala:143:21
  reg         ram_2_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [1:0]  ram_2_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg         ram_2_cfi_taken;	// fetch-target-queue.scala:143:21
  reg         ram_2_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]  ram_2_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [3:0]  ram_2_br_mask;	// fetch-target-queue.scala:143:21
  reg         ram_2_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg         ram_2_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0] ram_2_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]  ram_2_ras_idx;	// fetch-target-queue.scala:143:21
  reg         ram_2_start_bank;	// fetch-target-queue.scala:143:21
  reg         ram_3_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [1:0]  ram_3_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg         ram_3_cfi_taken;	// fetch-target-queue.scala:143:21
  reg         ram_3_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]  ram_3_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [3:0]  ram_3_br_mask;	// fetch-target-queue.scala:143:21
  reg         ram_3_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg         ram_3_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0] ram_3_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]  ram_3_ras_idx;	// fetch-target-queue.scala:143:21
  reg         ram_3_start_bank;	// fetch-target-queue.scala:143:21
  reg         ram_4_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [1:0]  ram_4_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg         ram_4_cfi_taken;	// fetch-target-queue.scala:143:21
  reg         ram_4_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]  ram_4_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [3:0]  ram_4_br_mask;	// fetch-target-queue.scala:143:21
  reg         ram_4_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg         ram_4_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0] ram_4_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]  ram_4_ras_idx;	// fetch-target-queue.scala:143:21
  reg         ram_4_start_bank;	// fetch-target-queue.scala:143:21
  reg         ram_5_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [1:0]  ram_5_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg         ram_5_cfi_taken;	// fetch-target-queue.scala:143:21
  reg         ram_5_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]  ram_5_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [3:0]  ram_5_br_mask;	// fetch-target-queue.scala:143:21
  reg         ram_5_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg         ram_5_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0] ram_5_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]  ram_5_ras_idx;	// fetch-target-queue.scala:143:21
  reg         ram_5_start_bank;	// fetch-target-queue.scala:143:21
  reg         ram_6_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [1:0]  ram_6_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg         ram_6_cfi_taken;	// fetch-target-queue.scala:143:21
  reg         ram_6_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]  ram_6_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [3:0]  ram_6_br_mask;	// fetch-target-queue.scala:143:21
  reg         ram_6_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg         ram_6_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0] ram_6_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]  ram_6_ras_idx;	// fetch-target-queue.scala:143:21
  reg         ram_6_start_bank;	// fetch-target-queue.scala:143:21
  reg         ram_7_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [1:0]  ram_7_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg         ram_7_cfi_taken;	// fetch-target-queue.scala:143:21
  reg         ram_7_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]  ram_7_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [3:0]  ram_7_br_mask;	// fetch-target-queue.scala:143:21
  reg         ram_7_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg         ram_7_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0] ram_7_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]  ram_7_ras_idx;	// fetch-target-queue.scala:143:21
  reg         ram_7_start_bank;	// fetch-target-queue.scala:143:21
  reg         ram_8_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [1:0]  ram_8_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg         ram_8_cfi_taken;	// fetch-target-queue.scala:143:21
  reg         ram_8_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]  ram_8_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [3:0]  ram_8_br_mask;	// fetch-target-queue.scala:143:21
  reg         ram_8_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg         ram_8_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0] ram_8_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]  ram_8_ras_idx;	// fetch-target-queue.scala:143:21
  reg         ram_8_start_bank;	// fetch-target-queue.scala:143:21
  reg         ram_9_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [1:0]  ram_9_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg         ram_9_cfi_taken;	// fetch-target-queue.scala:143:21
  reg         ram_9_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]  ram_9_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [3:0]  ram_9_br_mask;	// fetch-target-queue.scala:143:21
  reg         ram_9_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg         ram_9_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0] ram_9_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]  ram_9_ras_idx;	// fetch-target-queue.scala:143:21
  reg         ram_9_start_bank;	// fetch-target-queue.scala:143:21
  reg         ram_10_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [1:0]  ram_10_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg         ram_10_cfi_taken;	// fetch-target-queue.scala:143:21
  reg         ram_10_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]  ram_10_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [3:0]  ram_10_br_mask;	// fetch-target-queue.scala:143:21
  reg         ram_10_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg         ram_10_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0] ram_10_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]  ram_10_ras_idx;	// fetch-target-queue.scala:143:21
  reg         ram_10_start_bank;	// fetch-target-queue.scala:143:21
  reg         ram_11_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [1:0]  ram_11_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg         ram_11_cfi_taken;	// fetch-target-queue.scala:143:21
  reg         ram_11_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]  ram_11_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [3:0]  ram_11_br_mask;	// fetch-target-queue.scala:143:21
  reg         ram_11_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg         ram_11_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0] ram_11_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]  ram_11_ras_idx;	// fetch-target-queue.scala:143:21
  reg         ram_11_start_bank;	// fetch-target-queue.scala:143:21
  reg         ram_12_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [1:0]  ram_12_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg         ram_12_cfi_taken;	// fetch-target-queue.scala:143:21
  reg         ram_12_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]  ram_12_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [3:0]  ram_12_br_mask;	// fetch-target-queue.scala:143:21
  reg         ram_12_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg         ram_12_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0] ram_12_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]  ram_12_ras_idx;	// fetch-target-queue.scala:143:21
  reg         ram_12_start_bank;	// fetch-target-queue.scala:143:21
  reg         ram_13_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [1:0]  ram_13_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg         ram_13_cfi_taken;	// fetch-target-queue.scala:143:21
  reg         ram_13_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]  ram_13_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [3:0]  ram_13_br_mask;	// fetch-target-queue.scala:143:21
  reg         ram_13_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg         ram_13_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0] ram_13_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]  ram_13_ras_idx;	// fetch-target-queue.scala:143:21
  reg         ram_13_start_bank;	// fetch-target-queue.scala:143:21
  reg         ram_14_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [1:0]  ram_14_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg         ram_14_cfi_taken;	// fetch-target-queue.scala:143:21
  reg         ram_14_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]  ram_14_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [3:0]  ram_14_br_mask;	// fetch-target-queue.scala:143:21
  reg         ram_14_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg         ram_14_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0] ram_14_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]  ram_14_ras_idx;	// fetch-target-queue.scala:143:21
  reg         ram_14_start_bank;	// fetch-target-queue.scala:143:21
  reg         ram_15_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [1:0]  ram_15_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg         ram_15_cfi_taken;	// fetch-target-queue.scala:143:21
  reg         ram_15_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]  ram_15_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [3:0]  ram_15_br_mask;	// fetch-target-queue.scala:143:21
  reg         ram_15_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg         ram_15_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0] ram_15_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]  ram_15_ras_idx;	// fetch-target-queue.scala:143:21
  reg         ram_15_start_bank;	// fetch-target-queue.scala:143:21
  reg         ram_16_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [1:0]  ram_16_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg         ram_16_cfi_taken;	// fetch-target-queue.scala:143:21
  reg         ram_16_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]  ram_16_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [3:0]  ram_16_br_mask;	// fetch-target-queue.scala:143:21
  reg         ram_16_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg         ram_16_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0] ram_16_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]  ram_16_ras_idx;	// fetch-target-queue.scala:143:21
  reg         ram_16_start_bank;	// fetch-target-queue.scala:143:21
  reg         ram_17_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [1:0]  ram_17_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg         ram_17_cfi_taken;	// fetch-target-queue.scala:143:21
  reg         ram_17_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]  ram_17_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [3:0]  ram_17_br_mask;	// fetch-target-queue.scala:143:21
  reg         ram_17_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg         ram_17_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0] ram_17_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]  ram_17_ras_idx;	// fetch-target-queue.scala:143:21
  reg         ram_17_start_bank;	// fetch-target-queue.scala:143:21
  reg         ram_18_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [1:0]  ram_18_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg         ram_18_cfi_taken;	// fetch-target-queue.scala:143:21
  reg         ram_18_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]  ram_18_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [3:0]  ram_18_br_mask;	// fetch-target-queue.scala:143:21
  reg         ram_18_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg         ram_18_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0] ram_18_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]  ram_18_ras_idx;	// fetch-target-queue.scala:143:21
  reg         ram_18_start_bank;	// fetch-target-queue.scala:143:21
  reg         ram_19_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [1:0]  ram_19_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg         ram_19_cfi_taken;	// fetch-target-queue.scala:143:21
  reg         ram_19_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]  ram_19_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [3:0]  ram_19_br_mask;	// fetch-target-queue.scala:143:21
  reg         ram_19_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg         ram_19_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0] ram_19_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]  ram_19_ras_idx;	// fetch-target-queue.scala:143:21
  reg         ram_19_start_bank;	// fetch-target-queue.scala:143:21
  reg         ram_20_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [1:0]  ram_20_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg         ram_20_cfi_taken;	// fetch-target-queue.scala:143:21
  reg         ram_20_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]  ram_20_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [3:0]  ram_20_br_mask;	// fetch-target-queue.scala:143:21
  reg         ram_20_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg         ram_20_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0] ram_20_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]  ram_20_ras_idx;	// fetch-target-queue.scala:143:21
  reg         ram_20_start_bank;	// fetch-target-queue.scala:143:21
  reg         ram_21_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [1:0]  ram_21_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg         ram_21_cfi_taken;	// fetch-target-queue.scala:143:21
  reg         ram_21_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]  ram_21_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [3:0]  ram_21_br_mask;	// fetch-target-queue.scala:143:21
  reg         ram_21_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg         ram_21_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0] ram_21_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]  ram_21_ras_idx;	// fetch-target-queue.scala:143:21
  reg         ram_21_start_bank;	// fetch-target-queue.scala:143:21
  reg         ram_22_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [1:0]  ram_22_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg         ram_22_cfi_taken;	// fetch-target-queue.scala:143:21
  reg         ram_22_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]  ram_22_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [3:0]  ram_22_br_mask;	// fetch-target-queue.scala:143:21
  reg         ram_22_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg         ram_22_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0] ram_22_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]  ram_22_ras_idx;	// fetch-target-queue.scala:143:21
  reg         ram_22_start_bank;	// fetch-target-queue.scala:143:21
  reg         ram_23_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [1:0]  ram_23_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg         ram_23_cfi_taken;	// fetch-target-queue.scala:143:21
  reg         ram_23_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]  ram_23_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [3:0]  ram_23_br_mask;	// fetch-target-queue.scala:143:21
  reg         ram_23_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg         ram_23_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0] ram_23_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]  ram_23_ras_idx;	// fetch-target-queue.scala:143:21
  reg         ram_23_start_bank;	// fetch-target-queue.scala:143:21
  reg         ram_24_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [1:0]  ram_24_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg         ram_24_cfi_taken;	// fetch-target-queue.scala:143:21
  reg         ram_24_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]  ram_24_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [3:0]  ram_24_br_mask;	// fetch-target-queue.scala:143:21
  reg         ram_24_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg         ram_24_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0] ram_24_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]  ram_24_ras_idx;	// fetch-target-queue.scala:143:21
  reg         ram_24_start_bank;	// fetch-target-queue.scala:143:21
  reg         ram_25_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [1:0]  ram_25_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg         ram_25_cfi_taken;	// fetch-target-queue.scala:143:21
  reg         ram_25_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]  ram_25_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [3:0]  ram_25_br_mask;	// fetch-target-queue.scala:143:21
  reg         ram_25_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg         ram_25_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0] ram_25_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]  ram_25_ras_idx;	// fetch-target-queue.scala:143:21
  reg         ram_25_start_bank;	// fetch-target-queue.scala:143:21
  reg         ram_26_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [1:0]  ram_26_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg         ram_26_cfi_taken;	// fetch-target-queue.scala:143:21
  reg         ram_26_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]  ram_26_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [3:0]  ram_26_br_mask;	// fetch-target-queue.scala:143:21
  reg         ram_26_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg         ram_26_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0] ram_26_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]  ram_26_ras_idx;	// fetch-target-queue.scala:143:21
  reg         ram_26_start_bank;	// fetch-target-queue.scala:143:21
  reg         ram_27_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [1:0]  ram_27_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg         ram_27_cfi_taken;	// fetch-target-queue.scala:143:21
  reg         ram_27_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]  ram_27_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [3:0]  ram_27_br_mask;	// fetch-target-queue.scala:143:21
  reg         ram_27_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg         ram_27_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0] ram_27_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]  ram_27_ras_idx;	// fetch-target-queue.scala:143:21
  reg         ram_27_start_bank;	// fetch-target-queue.scala:143:21
  reg         ram_28_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [1:0]  ram_28_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg         ram_28_cfi_taken;	// fetch-target-queue.scala:143:21
  reg         ram_28_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]  ram_28_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [3:0]  ram_28_br_mask;	// fetch-target-queue.scala:143:21
  reg         ram_28_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg         ram_28_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0] ram_28_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]  ram_28_ras_idx;	// fetch-target-queue.scala:143:21
  reg         ram_28_start_bank;	// fetch-target-queue.scala:143:21
  reg         ram_29_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [1:0]  ram_29_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg         ram_29_cfi_taken;	// fetch-target-queue.scala:143:21
  reg         ram_29_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]  ram_29_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [3:0]  ram_29_br_mask;	// fetch-target-queue.scala:143:21
  reg         ram_29_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg         ram_29_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0] ram_29_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]  ram_29_ras_idx;	// fetch-target-queue.scala:143:21
  reg         ram_29_start_bank;	// fetch-target-queue.scala:143:21
  reg         ram_30_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [1:0]  ram_30_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg         ram_30_cfi_taken;	// fetch-target-queue.scala:143:21
  reg         ram_30_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]  ram_30_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [3:0]  ram_30_br_mask;	// fetch-target-queue.scala:143:21
  reg         ram_30_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg         ram_30_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0] ram_30_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]  ram_30_ras_idx;	// fetch-target-queue.scala:143:21
  reg         ram_30_start_bank;	// fetch-target-queue.scala:143:21
  reg         ram_31_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [1:0]  ram_31_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg         ram_31_cfi_taken;	// fetch-target-queue.scala:143:21
  reg         ram_31_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]  ram_31_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [3:0]  ram_31_br_mask;	// fetch-target-queue.scala:143:21
  reg         ram_31_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg         ram_31_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0] ram_31_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]  ram_31_ras_idx;	// fetch-target-queue.scala:143:21
  reg         ram_31_start_bank;	// fetch-target-queue.scala:143:21
  wire [71:0] _GEN =
    {ghist_1_MPORT_1_data_ras_idx,
     ghist_1_MPORT_1_data_new_saw_branch_taken,
     ghist_1_MPORT_1_data_new_saw_branch_not_taken,
     io_enq_bits_ghist_current_saw_branch_not_taken,
     ghist_1_MPORT_1_data_old_history};	// fetch-target-queue.scala:144:43, :178:24
  wire        ghist_1_MPORT_1_en = io_enq_ready_REG & io_enq_valid;	// Decoupled.scala:40:37, fetch-target-queue.scala:308:26
  reg  [63:0] prev_ghist_old_history;	// fetch-target-queue.scala:155:27
  reg         prev_ghist_current_saw_branch_not_taken;	// fetch-target-queue.scala:155:27
  reg  [4:0]  prev_ghist_ras_idx;	// fetch-target-queue.scala:155:27
  reg         prev_entry_cfi_idx_valid;	// fetch-target-queue.scala:156:27
  reg  [1:0]  prev_entry_cfi_idx_bits;	// fetch-target-queue.scala:156:27
  reg         prev_entry_cfi_taken;	// fetch-target-queue.scala:156:27
  reg  [3:0]  prev_entry_br_mask;	// fetch-target-queue.scala:156:27
  reg         prev_entry_cfi_is_call;	// fetch-target-queue.scala:156:27
  reg         prev_entry_cfi_is_ret;	// fetch-target-queue.scala:156:27
  wire [3:0]  _GEN_0 = {2'h0, prev_entry_cfi_idx_bits};	// fetch-target-queue.scala:156:{27,42}, :183:27
  wire [3:0]  _new_ghist_T = prev_entry_br_mask >> _GEN_0;	// fetch-target-queue.scala:156:27, :183:27
  wire [3:0]  new_ghist_cfi_idx_oh = 4'h1 << _GEN_0;	// OneHot.scala:58:35, fetch-target-queue.scala:183:27
  wire [2:0]  _GEN_1 = new_ghist_cfi_idx_oh[2:0] | new_ghist_cfi_idx_oh[3:1];	// OneHot.scala:58:35, util.scala:203:14, :373:{29,45}
  wire [1:0]  _GEN_2 = _GEN_1[1:0] | new_ghist_cfi_idx_oh[3:2];	// OneHot.scala:58:35, util.scala:203:14, :373:{29,45}
  wire        _new_ghist_new_history_old_history_T =
    _new_ghist_T[0] & prev_entry_cfi_taken;	// fetch-target-queue.scala:156:27, :183:27, frontend.scala:91:84
  wire [63:0] _new_ghist_new_history_old_history_T_6 =
    _new_ghist_new_history_old_history_T & prev_entry_cfi_idx_valid
      ? {prev_ghist_old_history[62:0], 1'h1}
      : (|(prev_entry_br_mask
           & (prev_entry_cfi_idx_valid
                ? {&prev_entry_cfi_idx_bits,
                   _GEN_1[2],
                   _GEN_2[1],
                   _GEN_2[0] | (&prev_entry_cfi_idx_bits)}
                  & ~(_new_ghist_new_history_old_history_T ? new_ghist_cfi_idx_oh : 4'h0)
                : 4'hF))) | prev_ghist_current_saw_branch_not_taken
          ? {prev_ghist_old_history[62:0], 1'h0}
          : prev_ghist_old_history;	// OneHot.scala:58:35, fetch-target-queue.scala:141:21, :155:27, :156:{27,42}, frontend.scala:90:{39,44}, :91:{67,69,73,84}, :92:45, :98:{53,61}, :99:{37,61,91,96}, :100:37, util.scala:203:14, :373:{29,45}
  wire        _new_ghist_new_history_ras_idx_T =
    prev_entry_cfi_idx_valid & prev_entry_cfi_is_call;	// fetch-target-queue.scala:156:27, frontend.scala:124:42
  wire [4:0]  _new_ghist_new_history_ras_idx_T_1 = prev_ghist_ras_idx + 5'h1;	// fetch-target-queue.scala:135:27, :155:27, util.scala:203:14
  wire        _new_ghist_new_history_ras_idx_T_4 =
    prev_entry_cfi_idx_valid & prev_entry_cfi_is_ret;	// fetch-target-queue.scala:156:27, frontend.scala:125:42
  wire [4:0]  _new_ghist_new_history_ras_idx_T_5 = prev_ghist_ras_idx - 5'h1;	// fetch-target-queue.scala:155:27, util.scala:220:14
  assign ghist_1_MPORT_1_data_old_history =
    io_enq_bits_ghist_current_saw_branch_not_taken
      ? io_enq_bits_ghist_old_history
      : _new_ghist_new_history_old_history_T_6;	// fetch-target-queue.scala:178:24, frontend.scala:99:37
  assign ghist_1_MPORT_1_data_new_saw_branch_not_taken =
    io_enq_bits_ghist_current_saw_branch_not_taken
    & io_enq_bits_ghist_new_saw_branch_not_taken;	// fetch-target-queue.scala:178:24
  assign ghist_1_MPORT_1_data_new_saw_branch_taken =
    io_enq_bits_ghist_current_saw_branch_not_taken
    & io_enq_bits_ghist_new_saw_branch_taken;	// fetch-target-queue.scala:178:24
  assign ghist_1_MPORT_1_data_ras_idx =
    io_enq_bits_ghist_current_saw_branch_not_taken
      ? io_enq_bits_ghist_ras_idx
      : _new_ghist_new_history_ras_idx_T
          ? _new_ghist_new_history_ras_idx_T_1
          : _new_ghist_new_history_ras_idx_T_4
              ? _new_ghist_new_history_ras_idx_T_5
              : prev_ghist_ras_idx;	// fetch-target-queue.scala:155:27, :178:24, frontend.scala:124:{31,42}, :125:{31,42}, util.scala:203:14, :220:14
  reg         first_empty;	// fetch-target-queue.scala:214:28
  reg         io_ras_update_REG;	// fetch-target-queue.scala:222:31
  reg  [39:0] io_ras_update_pc_REG;	// fetch-target-queue.scala:223:31
  reg  [4:0]  io_ras_update_idx_REG;	// fetch-target-queue.scala:224:31
  reg         bpd_update_mispredict;	// fetch-target-queue.scala:226:38
  reg         bpd_update_repair;	// fetch-target-queue.scala:227:34
  reg  [4:0]  bpd_repair_idx;	// fetch-target-queue.scala:228:27
  reg  [4:0]  bpd_end_idx;	// fetch-target-queue.scala:229:24
  reg  [39:0] bpd_repair_pc;	// fetch-target-queue.scala:230:26
  wire [4:0]  _bpd_meta_T_1 =
    io_redirect_valid
      ? io_redirect_bits
      : bpd_update_repair | bpd_update_mispredict ? bpd_repair_idx : bpd_ptr;	// fetch-target-queue.scala:133:27, :226:38, :227:34, :228:27, :232:20, :233:{8,27}
  reg         bpd_entry_cfi_idx_valid;	// fetch-target-queue.scala:234:26
  reg  [1:0]  bpd_entry_cfi_idx_bits;	// fetch-target-queue.scala:234:26
  reg         bpd_entry_cfi_taken;	// fetch-target-queue.scala:234:26
  reg         bpd_entry_cfi_mispredicted;	// fetch-target-queue.scala:234:26
  reg  [2:0]  bpd_entry_cfi_type;	// fetch-target-queue.scala:234:26
  reg  [3:0]  bpd_entry_br_mask;	// fetch-target-queue.scala:234:26
  reg  [39:0] bpd_pc;	// fetch-target-queue.scala:242:26
  reg  [39:0] bpd_target;	// fetch-target-queue.scala:243:27
  reg         REG;	// fetch-target-queue.scala:248:23
  reg  [4:0]  bpd_repair_idx_REG;	// fetch-target-queue.scala:250:37
  reg  [4:0]  bpd_end_idx_REG;	// fetch-target-queue.scala:251:37
  reg         REG_1;	// fetch-target-queue.scala:256:44
  reg         do_commit_update_REG;	// fetch-target-queue.scala:274:61
  reg         REG_2;	// fetch-target-queue.scala:278:16
  reg         io_bpdupdate_valid_REG;	// fetch-target-queue.scala:284:37
  reg         io_bpdupdate_bits_is_mispredict_update_REG;	// fetch-target-queue.scala:285:54
  reg         io_bpdupdate_bits_is_repair_update_REG;	// fetch-target-queue.scala:286:54
  wire [3:0]  _GEN_3 = {2'h0, bpd_entry_cfi_idx_bits};	// OneHot.scala:58:35, fetch-target-queue.scala:156:42, :234:26
  wire [3:0]  _io_bpdupdate_bits_br_mask_T_1 = 4'h1 << _GEN_3;	// OneHot.scala:58:35
  wire [2:0]  _GEN_4 =
    _io_bpdupdate_bits_br_mask_T_1[2:0] | _io_bpdupdate_bits_br_mask_T_1[3:1];	// OneHot.scala:58:35, util.scala:203:14, :373:{29,45}
  wire [1:0]  _GEN_5 = _GEN_4[1:0] | _io_bpdupdate_bits_br_mask_T_1[3:2];	// OneHot.scala:58:35, util.scala:203:14, :373:{29,45}
  wire [3:0]  _io_bpdupdate_bits_cfi_is_br_T = bpd_entry_br_mask >> _GEN_3;	// OneHot.scala:58:35, fetch-target-queue.scala:234:26, :295:54
  reg         REG_3;	// fetch-target-queue.scala:332:23
  reg         prev_entry_REG_cfi_idx_valid;	// fetch-target-queue.scala:333:26
  reg  [1:0]  prev_entry_REG_cfi_idx_bits;	// fetch-target-queue.scala:333:26
  reg         prev_entry_REG_cfi_taken;	// fetch-target-queue.scala:333:26
  reg  [3:0]  prev_entry_REG_br_mask;	// fetch-target-queue.scala:333:26
  reg         prev_entry_REG_cfi_is_call;	// fetch-target-queue.scala:333:26
  reg         prev_entry_REG_cfi_is_ret;	// fetch-target-queue.scala:333:26
  reg  [4:0]  REG_4;	// fetch-target-queue.scala:337:16
  reg         ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:337:46
  reg  [1:0]  ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:337:46
  reg         ram_REG_cfi_taken;	// fetch-target-queue.scala:337:46
  reg         ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:337:46
  reg  [2:0]  ram_REG_cfi_type;	// fetch-target-queue.scala:337:46
  reg  [3:0]  ram_REG_br_mask;	// fetch-target-queue.scala:337:46
  reg         ram_REG_cfi_is_call;	// fetch-target-queue.scala:337:46
  reg         ram_REG_cfi_is_ret;	// fetch-target-queue.scala:337:46
  reg  [39:0] ram_REG_ras_top;	// fetch-target-queue.scala:337:46
  reg  [4:0]  ram_REG_ras_idx;	// fetch-target-queue.scala:337:46
  reg         ram_REG_start_bank;	// fetch-target-queue.scala:337:46
  reg         io_get_ftq_pc_0_entry_REG_cfi_idx_valid;	// fetch-target-queue.scala:351:42
  reg  [1:0]  io_get_ftq_pc_0_entry_REG_cfi_idx_bits;	// fetch-target-queue.scala:351:42
  reg  [4:0]  io_get_ftq_pc_0_entry_REG_ras_idx;	// fetch-target-queue.scala:351:42
  reg         io_get_ftq_pc_0_entry_REG_start_bank;	// fetch-target-queue.scala:351:42
  reg  [39:0] io_get_ftq_pc_0_pc_REG;	// fetch-target-queue.scala:356:42
  reg  [39:0] io_get_ftq_pc_0_next_pc_REG;	// fetch-target-queue.scala:357:42
  reg         io_get_ftq_pc_0_next_val_REG;	// fetch-target-queue.scala:358:42
  reg  [39:0] io_get_ftq_pc_0_com_pc_REG;	// fetch-target-queue.scala:359:42
  reg  [1:0]  io_get_ftq_pc_1_entry_REG_cfi_idx_bits;	// fetch-target-queue.scala:351:42
  reg  [3:0]  io_get_ftq_pc_1_entry_REG_br_mask;	// fetch-target-queue.scala:351:42
  reg         io_get_ftq_pc_1_entry_REG_cfi_is_call;	// fetch-target-queue.scala:351:42
  reg         io_get_ftq_pc_1_entry_REG_cfi_is_ret;	// fetch-target-queue.scala:351:42
  reg         io_get_ftq_pc_1_entry_REG_start_bank;	// fetch-target-queue.scala:351:42
  reg  [39:0] io_get_ftq_pc_1_pc_REG;	// fetch-target-queue.scala:356:42
  always @(posedge clock) begin
    automatic logic [4:0]        _enq_ptr_T;	// util.scala:203:14
    automatic logic              _GEN_6;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_7;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_8;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_9;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_10;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_11;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_12;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_13;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_14;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_15;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_16;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_17;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_18;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_19;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_20;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_21;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_22;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_23;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_24;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_25;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_26;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_27;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_28;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_29;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_30;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_31;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_32;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_33;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_34;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_35;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_36;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_37;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic [3:0]        new_entry_br_mask;	// fetch-target-queue.scala:175:52
    automatic logic [31:0]       _GEN_38;	// fetch-target-queue.scala:234:26
    automatic logic [31:0][1:0]  _GEN_39;	// fetch-target-queue.scala:234:26
    automatic logic [31:0]       _GEN_40;	// fetch-target-queue.scala:234:26
    automatic logic [31:0]       _GEN_41;	// fetch-target-queue.scala:234:26
    automatic logic [31:0][2:0]  _GEN_42;	// fetch-target-queue.scala:234:26
    automatic logic [31:0][3:0]  _GEN_43;	// fetch-target-queue.scala:234:26
    automatic logic [31:0][39:0] _GEN_44;	// fetch-target-queue.scala:242:26
    automatic logic              _GEN_45;	// fetch-target-queue.scala:256:34
    automatic logic [4:0]        _bpd_repair_idx_T_6;	// util.scala:203:14
    automatic logic [4:0]        _bpd_ptr_T;	// util.scala:203:14
    automatic logic              do_commit_update;	// fetch-target-queue.scala:274:50
    automatic logic [31:0]       _GEN_46;
    automatic logic [31:0]       _GEN_47;
    automatic logic [31:0][39:0] _GEN_48;
    automatic logic [31:0][4:0]  _GEN_49;
    automatic logic [31:0]       _GEN_50;
    automatic logic              _GEN_51 = io_redirect_valid & io_brupdate_b2_mispredict;	// fetch-target-queue.scala:314:28, :317:38, :320:43
    automatic logic              redirect_new_entry_cfi_idx_valid;	// fetch-target-queue.scala:314:28, :317:38, :320:43
    automatic logic              _GEN_52;	// fetch-target-queue.scala:314:28, :317:38, :324:43
    automatic logic              redirect_new_entry_cfi_is_call;	// fetch-target-queue.scala:314:28, :317:38, :324:43
    automatic logic              redirect_new_entry_cfi_is_ret;	// fetch-target-queue.scala:314:28, :317:38, :325:43
    automatic logic [4:0]        _next_idx_T;	// util.scala:203:14
    automatic logic              next_is_enq;	// fetch-target-queue.scala:347:46
    _enq_ptr_T = enq_ptr + 5'h1;	// fetch-target-queue.scala:135:27, util.scala:203:14
    _GEN_6 = ghist_1_MPORT_1_en & enq_ptr == 5'h0;	// Decoupled.scala:40:37, fetch-target-queue.scala:133:27, :135:27, :141:21, :158:17, :160:28
    _GEN_7 = ghist_1_MPORT_1_en & enq_ptr == 5'h1;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_8 = ghist_1_MPORT_1_en & enq_ptr == 5'h2;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_9 = ghist_1_MPORT_1_en & enq_ptr == 5'h3;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_10 = ghist_1_MPORT_1_en & enq_ptr == 5'h4;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_11 = ghist_1_MPORT_1_en & enq_ptr == 5'h5;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_12 = ghist_1_MPORT_1_en & enq_ptr == 5'h6;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_13 = ghist_1_MPORT_1_en & enq_ptr == 5'h7;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_14 = ghist_1_MPORT_1_en & enq_ptr == 5'h8;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_15 = ghist_1_MPORT_1_en & enq_ptr == 5'h9;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_16 = ghist_1_MPORT_1_en & enq_ptr == 5'hA;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_17 = ghist_1_MPORT_1_en & enq_ptr == 5'hB;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_18 = ghist_1_MPORT_1_en & enq_ptr == 5'hC;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_19 = ghist_1_MPORT_1_en & enq_ptr == 5'hD;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_20 = ghist_1_MPORT_1_en & enq_ptr == 5'hE;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_21 = ghist_1_MPORT_1_en & enq_ptr == 5'hF;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_22 = ghist_1_MPORT_1_en & enq_ptr == 5'h10;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_23 = ghist_1_MPORT_1_en & enq_ptr == 5'h11;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_24 = ghist_1_MPORT_1_en & enq_ptr == 5'h12;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_25 = ghist_1_MPORT_1_en & enq_ptr == 5'h13;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_26 = ghist_1_MPORT_1_en & enq_ptr == 5'h14;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_27 = ghist_1_MPORT_1_en & enq_ptr == 5'h15;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_28 = ghist_1_MPORT_1_en & enq_ptr == 5'h16;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_29 = ghist_1_MPORT_1_en & enq_ptr == 5'h17;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_30 = ghist_1_MPORT_1_en & enq_ptr == 5'h18;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_31 = ghist_1_MPORT_1_en & enq_ptr == 5'h19;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_32 = ghist_1_MPORT_1_en & enq_ptr == 5'h1A;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_33 = ghist_1_MPORT_1_en & enq_ptr == 5'h1B;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_34 = ghist_1_MPORT_1_en & enq_ptr == 5'h1C;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_35 = ghist_1_MPORT_1_en & enq_ptr == 5'h1D;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_36 = ghist_1_MPORT_1_en & enq_ptr == 5'h1E;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_37 = ghist_1_MPORT_1_en & (&enq_ptr);	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    new_entry_br_mask = io_enq_bits_br_mask & io_enq_bits_mask;	// fetch-target-queue.scala:175:52
    _GEN_38 =
      {{ram_31_cfi_idx_valid},
       {ram_30_cfi_idx_valid},
       {ram_29_cfi_idx_valid},
       {ram_28_cfi_idx_valid},
       {ram_27_cfi_idx_valid},
       {ram_26_cfi_idx_valid},
       {ram_25_cfi_idx_valid},
       {ram_24_cfi_idx_valid},
       {ram_23_cfi_idx_valid},
       {ram_22_cfi_idx_valid},
       {ram_21_cfi_idx_valid},
       {ram_20_cfi_idx_valid},
       {ram_19_cfi_idx_valid},
       {ram_18_cfi_idx_valid},
       {ram_17_cfi_idx_valid},
       {ram_16_cfi_idx_valid},
       {ram_15_cfi_idx_valid},
       {ram_14_cfi_idx_valid},
       {ram_13_cfi_idx_valid},
       {ram_12_cfi_idx_valid},
       {ram_11_cfi_idx_valid},
       {ram_10_cfi_idx_valid},
       {ram_9_cfi_idx_valid},
       {ram_8_cfi_idx_valid},
       {ram_7_cfi_idx_valid},
       {ram_6_cfi_idx_valid},
       {ram_5_cfi_idx_valid},
       {ram_4_cfi_idx_valid},
       {ram_3_cfi_idx_valid},
       {ram_2_cfi_idx_valid},
       {ram_1_cfi_idx_valid},
       {ram_0_cfi_idx_valid}};	// fetch-target-queue.scala:143:21, :234:26
    _GEN_39 =
      {{ram_31_cfi_idx_bits},
       {ram_30_cfi_idx_bits},
       {ram_29_cfi_idx_bits},
       {ram_28_cfi_idx_bits},
       {ram_27_cfi_idx_bits},
       {ram_26_cfi_idx_bits},
       {ram_25_cfi_idx_bits},
       {ram_24_cfi_idx_bits},
       {ram_23_cfi_idx_bits},
       {ram_22_cfi_idx_bits},
       {ram_21_cfi_idx_bits},
       {ram_20_cfi_idx_bits},
       {ram_19_cfi_idx_bits},
       {ram_18_cfi_idx_bits},
       {ram_17_cfi_idx_bits},
       {ram_16_cfi_idx_bits},
       {ram_15_cfi_idx_bits},
       {ram_14_cfi_idx_bits},
       {ram_13_cfi_idx_bits},
       {ram_12_cfi_idx_bits},
       {ram_11_cfi_idx_bits},
       {ram_10_cfi_idx_bits},
       {ram_9_cfi_idx_bits},
       {ram_8_cfi_idx_bits},
       {ram_7_cfi_idx_bits},
       {ram_6_cfi_idx_bits},
       {ram_5_cfi_idx_bits},
       {ram_4_cfi_idx_bits},
       {ram_3_cfi_idx_bits},
       {ram_2_cfi_idx_bits},
       {ram_1_cfi_idx_bits},
       {ram_0_cfi_idx_bits}};	// fetch-target-queue.scala:143:21, :234:26
    _GEN_40 =
      {{ram_31_cfi_taken},
       {ram_30_cfi_taken},
       {ram_29_cfi_taken},
       {ram_28_cfi_taken},
       {ram_27_cfi_taken},
       {ram_26_cfi_taken},
       {ram_25_cfi_taken},
       {ram_24_cfi_taken},
       {ram_23_cfi_taken},
       {ram_22_cfi_taken},
       {ram_21_cfi_taken},
       {ram_20_cfi_taken},
       {ram_19_cfi_taken},
       {ram_18_cfi_taken},
       {ram_17_cfi_taken},
       {ram_16_cfi_taken},
       {ram_15_cfi_taken},
       {ram_14_cfi_taken},
       {ram_13_cfi_taken},
       {ram_12_cfi_taken},
       {ram_11_cfi_taken},
       {ram_10_cfi_taken},
       {ram_9_cfi_taken},
       {ram_8_cfi_taken},
       {ram_7_cfi_taken},
       {ram_6_cfi_taken},
       {ram_5_cfi_taken},
       {ram_4_cfi_taken},
       {ram_3_cfi_taken},
       {ram_2_cfi_taken},
       {ram_1_cfi_taken},
       {ram_0_cfi_taken}};	// fetch-target-queue.scala:143:21, :234:26
    _GEN_41 =
      {{ram_31_cfi_mispredicted},
       {ram_30_cfi_mispredicted},
       {ram_29_cfi_mispredicted},
       {ram_28_cfi_mispredicted},
       {ram_27_cfi_mispredicted},
       {ram_26_cfi_mispredicted},
       {ram_25_cfi_mispredicted},
       {ram_24_cfi_mispredicted},
       {ram_23_cfi_mispredicted},
       {ram_22_cfi_mispredicted},
       {ram_21_cfi_mispredicted},
       {ram_20_cfi_mispredicted},
       {ram_19_cfi_mispredicted},
       {ram_18_cfi_mispredicted},
       {ram_17_cfi_mispredicted},
       {ram_16_cfi_mispredicted},
       {ram_15_cfi_mispredicted},
       {ram_14_cfi_mispredicted},
       {ram_13_cfi_mispredicted},
       {ram_12_cfi_mispredicted},
       {ram_11_cfi_mispredicted},
       {ram_10_cfi_mispredicted},
       {ram_9_cfi_mispredicted},
       {ram_8_cfi_mispredicted},
       {ram_7_cfi_mispredicted},
       {ram_6_cfi_mispredicted},
       {ram_5_cfi_mispredicted},
       {ram_4_cfi_mispredicted},
       {ram_3_cfi_mispredicted},
       {ram_2_cfi_mispredicted},
       {ram_1_cfi_mispredicted},
       {ram_0_cfi_mispredicted}};	// fetch-target-queue.scala:143:21, :234:26
    _GEN_42 =
      {{ram_31_cfi_type},
       {ram_30_cfi_type},
       {ram_29_cfi_type},
       {ram_28_cfi_type},
       {ram_27_cfi_type},
       {ram_26_cfi_type},
       {ram_25_cfi_type},
       {ram_24_cfi_type},
       {ram_23_cfi_type},
       {ram_22_cfi_type},
       {ram_21_cfi_type},
       {ram_20_cfi_type},
       {ram_19_cfi_type},
       {ram_18_cfi_type},
       {ram_17_cfi_type},
       {ram_16_cfi_type},
       {ram_15_cfi_type},
       {ram_14_cfi_type},
       {ram_13_cfi_type},
       {ram_12_cfi_type},
       {ram_11_cfi_type},
       {ram_10_cfi_type},
       {ram_9_cfi_type},
       {ram_8_cfi_type},
       {ram_7_cfi_type},
       {ram_6_cfi_type},
       {ram_5_cfi_type},
       {ram_4_cfi_type},
       {ram_3_cfi_type},
       {ram_2_cfi_type},
       {ram_1_cfi_type},
       {ram_0_cfi_type}};	// fetch-target-queue.scala:143:21, :234:26
    _GEN_43 =
      {{ram_31_br_mask},
       {ram_30_br_mask},
       {ram_29_br_mask},
       {ram_28_br_mask},
       {ram_27_br_mask},
       {ram_26_br_mask},
       {ram_25_br_mask},
       {ram_24_br_mask},
       {ram_23_br_mask},
       {ram_22_br_mask},
       {ram_21_br_mask},
       {ram_20_br_mask},
       {ram_19_br_mask},
       {ram_18_br_mask},
       {ram_17_br_mask},
       {ram_16_br_mask},
       {ram_15_br_mask},
       {ram_14_br_mask},
       {ram_13_br_mask},
       {ram_12_br_mask},
       {ram_11_br_mask},
       {ram_10_br_mask},
       {ram_9_br_mask},
       {ram_8_br_mask},
       {ram_7_br_mask},
       {ram_6_br_mask},
       {ram_5_br_mask},
       {ram_4_br_mask},
       {ram_3_br_mask},
       {ram_2_br_mask},
       {ram_1_br_mask},
       {ram_0_br_mask}};	// fetch-target-queue.scala:143:21, :234:26
    _GEN_44 =
      {{pcs_31},
       {pcs_30},
       {pcs_29},
       {pcs_28},
       {pcs_27},
       {pcs_26},
       {pcs_25},
       {pcs_24},
       {pcs_23},
       {pcs_22},
       {pcs_21},
       {pcs_20},
       {pcs_19},
       {pcs_18},
       {pcs_17},
       {pcs_16},
       {pcs_15},
       {pcs_14},
       {pcs_13},
       {pcs_12},
       {pcs_11},
       {pcs_10},
       {pcs_9},
       {pcs_8},
       {pcs_7},
       {pcs_6},
       {pcs_5},
       {pcs_4},
       {pcs_3},
       {pcs_2},
       {pcs_1},
       {pcs_0}};	// fetch-target-queue.scala:141:21, :242:26
    _GEN_45 = bpd_update_repair & REG_1;	// fetch-target-queue.scala:227:34, :256:{34,44}
    _bpd_repair_idx_T_6 = bpd_repair_idx + 5'h1;	// fetch-target-queue.scala:135:27, :228:27, util.scala:203:14
    _bpd_ptr_T = bpd_ptr + 5'h1;	// fetch-target-queue.scala:133:27, :135:27, util.scala:203:14
    do_commit_update =
      ~bpd_update_mispredict & ~bpd_update_repair & bpd_ptr != deq_ptr
      & enq_ptr != _bpd_ptr_T & ~io_brupdate_b2_mispredict & ~io_redirect_valid
      & ~do_commit_update_REG;	// fetch-target-queue.scala:133:27, :134:27, :135:27, :226:38, :227:34, :269:31, :270:31, :271:40, :272:40, :273:31, :274:{31,50,53,61}, util.scala:203:14
    _GEN_46 =
      {{ram_31_cfi_is_call},
       {ram_30_cfi_is_call},
       {ram_29_cfi_is_call},
       {ram_28_cfi_is_call},
       {ram_27_cfi_is_call},
       {ram_26_cfi_is_call},
       {ram_25_cfi_is_call},
       {ram_24_cfi_is_call},
       {ram_23_cfi_is_call},
       {ram_22_cfi_is_call},
       {ram_21_cfi_is_call},
       {ram_20_cfi_is_call},
       {ram_19_cfi_is_call},
       {ram_18_cfi_is_call},
       {ram_17_cfi_is_call},
       {ram_16_cfi_is_call},
       {ram_15_cfi_is_call},
       {ram_14_cfi_is_call},
       {ram_13_cfi_is_call},
       {ram_12_cfi_is_call},
       {ram_11_cfi_is_call},
       {ram_10_cfi_is_call},
       {ram_9_cfi_is_call},
       {ram_8_cfi_is_call},
       {ram_7_cfi_is_call},
       {ram_6_cfi_is_call},
       {ram_5_cfi_is_call},
       {ram_4_cfi_is_call},
       {ram_3_cfi_is_call},
       {ram_2_cfi_is_call},
       {ram_1_cfi_is_call},
       {ram_0_cfi_is_call}};	// fetch-target-queue.scala:143:21
    _GEN_47 =
      {{ram_31_cfi_is_ret},
       {ram_30_cfi_is_ret},
       {ram_29_cfi_is_ret},
       {ram_28_cfi_is_ret},
       {ram_27_cfi_is_ret},
       {ram_26_cfi_is_ret},
       {ram_25_cfi_is_ret},
       {ram_24_cfi_is_ret},
       {ram_23_cfi_is_ret},
       {ram_22_cfi_is_ret},
       {ram_21_cfi_is_ret},
       {ram_20_cfi_is_ret},
       {ram_19_cfi_is_ret},
       {ram_18_cfi_is_ret},
       {ram_17_cfi_is_ret},
       {ram_16_cfi_is_ret},
       {ram_15_cfi_is_ret},
       {ram_14_cfi_is_ret},
       {ram_13_cfi_is_ret},
       {ram_12_cfi_is_ret},
       {ram_11_cfi_is_ret},
       {ram_10_cfi_is_ret},
       {ram_9_cfi_is_ret},
       {ram_8_cfi_is_ret},
       {ram_7_cfi_is_ret},
       {ram_6_cfi_is_ret},
       {ram_5_cfi_is_ret},
       {ram_4_cfi_is_ret},
       {ram_3_cfi_is_ret},
       {ram_2_cfi_is_ret},
       {ram_1_cfi_is_ret},
       {ram_0_cfi_is_ret}};	// fetch-target-queue.scala:143:21
    _GEN_48 =
      {{ram_31_ras_top},
       {ram_30_ras_top},
       {ram_29_ras_top},
       {ram_28_ras_top},
       {ram_27_ras_top},
       {ram_26_ras_top},
       {ram_25_ras_top},
       {ram_24_ras_top},
       {ram_23_ras_top},
       {ram_22_ras_top},
       {ram_21_ras_top},
       {ram_20_ras_top},
       {ram_19_ras_top},
       {ram_18_ras_top},
       {ram_17_ras_top},
       {ram_16_ras_top},
       {ram_15_ras_top},
       {ram_14_ras_top},
       {ram_13_ras_top},
       {ram_12_ras_top},
       {ram_11_ras_top},
       {ram_10_ras_top},
       {ram_9_ras_top},
       {ram_8_ras_top},
       {ram_7_ras_top},
       {ram_6_ras_top},
       {ram_5_ras_top},
       {ram_4_ras_top},
       {ram_3_ras_top},
       {ram_2_ras_top},
       {ram_1_ras_top},
       {ram_0_ras_top}};	// fetch-target-queue.scala:143:21
    _GEN_49 =
      {{ram_31_ras_idx},
       {ram_30_ras_idx},
       {ram_29_ras_idx},
       {ram_28_ras_idx},
       {ram_27_ras_idx},
       {ram_26_ras_idx},
       {ram_25_ras_idx},
       {ram_24_ras_idx},
       {ram_23_ras_idx},
       {ram_22_ras_idx},
       {ram_21_ras_idx},
       {ram_20_ras_idx},
       {ram_19_ras_idx},
       {ram_18_ras_idx},
       {ram_17_ras_idx},
       {ram_16_ras_idx},
       {ram_15_ras_idx},
       {ram_14_ras_idx},
       {ram_13_ras_idx},
       {ram_12_ras_idx},
       {ram_11_ras_idx},
       {ram_10_ras_idx},
       {ram_9_ras_idx},
       {ram_8_ras_idx},
       {ram_7_ras_idx},
       {ram_6_ras_idx},
       {ram_5_ras_idx},
       {ram_4_ras_idx},
       {ram_3_ras_idx},
       {ram_2_ras_idx},
       {ram_1_ras_idx},
       {ram_0_ras_idx}};	// fetch-target-queue.scala:143:21
    _GEN_50 =
      {{ram_31_start_bank},
       {ram_30_start_bank},
       {ram_29_start_bank},
       {ram_28_start_bank},
       {ram_27_start_bank},
       {ram_26_start_bank},
       {ram_25_start_bank},
       {ram_24_start_bank},
       {ram_23_start_bank},
       {ram_22_start_bank},
       {ram_21_start_bank},
       {ram_20_start_bank},
       {ram_19_start_bank},
       {ram_18_start_bank},
       {ram_17_start_bank},
       {ram_16_start_bank},
       {ram_15_start_bank},
       {ram_14_start_bank},
       {ram_13_start_bank},
       {ram_12_start_bank},
       {ram_11_start_bank},
       {ram_10_start_bank},
       {ram_9_start_bank},
       {ram_8_start_bank},
       {ram_7_start_bank},
       {ram_6_start_bank},
       {ram_5_start_bank},
       {ram_4_start_bank},
       {ram_3_start_bank},
       {ram_2_start_bank},
       {ram_1_start_bank},
       {ram_0_start_bank}};	// fetch-target-queue.scala:143:21
    redirect_new_entry_cfi_idx_valid = _GEN_51 | _GEN_38[io_redirect_bits];	// fetch-target-queue.scala:234:26, :314:28, :317:38, :320:43
    _GEN_52 = ~_GEN_51 | _GEN_39[io_redirect_bits] == io_brupdate_b2_uop_pc_lob[2:1];	// fetch-target-queue.scala:234:26, :314:28, :317:38, :318:50, :320:43, :324:{43,104}
    redirect_new_entry_cfi_is_call = _GEN_52 & _GEN_46[io_redirect_bits];	// fetch-target-queue.scala:314:28, :317:38, :324:43
    redirect_new_entry_cfi_is_ret = _GEN_52 & _GEN_47[io_redirect_bits];	// fetch-target-queue.scala:314:28, :317:38, :324:43, :325:43
    _next_idx_T = io_get_ftq_pc_0_ftq_idx + 5'h1;	// fetch-target-queue.scala:135:27, util.scala:203:14
    next_is_enq = _next_idx_T == enq_ptr & ghist_1_MPORT_1_en;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :347:{33,46}, util.scala:203:14
    if (reset) begin
      bpd_ptr <= 5'h0;	// fetch-target-queue.scala:133:27
      deq_ptr <= 5'h0;	// fetch-target-queue.scala:133:27, :134:27
      enq_ptr <= 5'h1;	// fetch-target-queue.scala:135:27
      prev_ghist_old_history <= 64'h0;	// fetch-target-queue.scala:155:{27,42}
      prev_ghist_current_saw_branch_not_taken <= 1'h0;	// fetch-target-queue.scala:141:21, :155:27
      prev_ghist_ras_idx <= 5'h0;	// fetch-target-queue.scala:133:27, :155:27
      prev_entry_cfi_idx_valid <= 1'h0;	// fetch-target-queue.scala:141:21, :156:27
      prev_entry_cfi_idx_bits <= 2'h0;	// fetch-target-queue.scala:156:{27,42}
      prev_entry_cfi_taken <= 1'h0;	// fetch-target-queue.scala:141:21, :156:27
      prev_entry_br_mask <= 4'h0;	// fetch-target-queue.scala:156:{27,42}
      prev_entry_cfi_is_call <= 1'h0;	// fetch-target-queue.scala:141:21, :156:27
      prev_entry_cfi_is_ret <= 1'h0;	// fetch-target-queue.scala:141:21, :156:27
      first_empty <= 1'h1;	// fetch-target-queue.scala:214:28
      bpd_update_mispredict <= 1'h0;	// fetch-target-queue.scala:141:21, :226:38
      bpd_update_repair <= 1'h0;	// fetch-target-queue.scala:141:21, :227:34
    end
    else begin
      if (do_commit_update)	// fetch-target-queue.scala:274:50
        bpd_ptr <= _bpd_ptr_T;	// fetch-target-queue.scala:133:27, util.scala:203:14
      if (io_deq_valid)
        deq_ptr <= io_deq_bits;	// fetch-target-queue.scala:134:27
      if (io_redirect_valid)
        enq_ptr <= io_redirect_bits + 5'h1;	// fetch-target-queue.scala:135:27, util.scala:203:14
      else if (ghist_1_MPORT_1_en)	// Decoupled.scala:40:37
        enq_ptr <= _enq_ptr_T;	// fetch-target-queue.scala:135:27, util.scala:203:14
      if (io_redirect_valid | ~REG_3) begin	// fetch-target-queue.scala:158:17, :314:28, :332:{23,44}
        if (ghist_1_MPORT_1_en) begin	// Decoupled.scala:40:37
          if (io_enq_bits_ghist_current_saw_branch_not_taken)
            prev_ghist_old_history <= io_enq_bits_ghist_old_history;	// fetch-target-queue.scala:155:27
          else
            prev_ghist_old_history <= _new_ghist_new_history_old_history_T_6;	// fetch-target-queue.scala:155:27, frontend.scala:99:37
          prev_ghist_current_saw_branch_not_taken <=
            io_enq_bits_ghist_current_saw_branch_not_taken;	// fetch-target-queue.scala:155:27
          if (io_enq_bits_ghist_current_saw_branch_not_taken)
            prev_ghist_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:155:27
          else if (_new_ghist_new_history_ras_idx_T)	// frontend.scala:124:42
            prev_ghist_ras_idx <= _new_ghist_new_history_ras_idx_T_1;	// fetch-target-queue.scala:155:27, util.scala:203:14
          else if (_new_ghist_new_history_ras_idx_T_4)	// frontend.scala:125:42
            prev_ghist_ras_idx <= _new_ghist_new_history_ras_idx_T_5;	// fetch-target-queue.scala:155:27, util.scala:220:14
          prev_entry_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:156:27
          prev_entry_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:156:27
          prev_entry_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:156:27
          prev_entry_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:156:27, :175:52
          prev_entry_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:156:27
          prev_entry_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:156:27
        end
      end
      else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
        prev_ghist_old_history <= _ghist_0_ext_R0_data[63:0];	// fetch-target-queue.scala:144:43, :155:27
        prev_ghist_current_saw_branch_not_taken <= _ghist_0_ext_R0_data[64];	// fetch-target-queue.scala:144:43, :155:27
        prev_ghist_ras_idx <= _ghist_0_ext_R0_data[71:67];	// fetch-target-queue.scala:144:43, :155:27
        prev_entry_cfi_idx_valid <= prev_entry_REG_cfi_idx_valid;	// fetch-target-queue.scala:156:27, :333:26
        prev_entry_cfi_idx_bits <= prev_entry_REG_cfi_idx_bits;	// fetch-target-queue.scala:156:27, :333:26
        prev_entry_cfi_taken <= prev_entry_REG_cfi_taken;	// fetch-target-queue.scala:156:27, :333:26
        prev_entry_br_mask <= prev_entry_REG_br_mask;	// fetch-target-queue.scala:156:27, :333:26
        prev_entry_cfi_is_call <= prev_entry_REG_cfi_is_call;	// fetch-target-queue.scala:156:27, :333:26
        prev_entry_cfi_is_ret <= prev_entry_REG_cfi_is_ret;	// fetch-target-queue.scala:156:27, :333:26
      end
      first_empty <= ~REG_2 & first_empty;	// fetch-target-queue.scala:214:28, :278:{16,80}, :301:17
      bpd_update_mispredict <= ~io_redirect_valid & REG;	// fetch-target-queue.scala:226:38, :245:28, :246:27, :248:{23,52}
      bpd_update_repair <=
        ~io_redirect_valid
        & (REG
             ? bpd_update_repair
             : bpd_update_mispredict
               | (_GEN_45
                  | ~(bpd_update_repair
                      & (_bpd_repair_idx_T_6 == bpd_end_idx | bpd_pc == bpd_repair_pc)))
               & bpd_update_repair);	// fetch-target-queue.scala:226:38, :227:34, :229:24, :230:26, :242:26, :245:28, :246:27, :247:27, :248:{23,52}, :252:39, :254:27, :256:{34,69}, :259:35, :261:{48,64}, :262:{14,34}, :263:25, util.scala:203:14
    end
    if (_GEN_6)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_0 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_7)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_1 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_8)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_2 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_9)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_3 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_10)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_4 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_11)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_5 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_12)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_6 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_13)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_7 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_14)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_8 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_15)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_9 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_16)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_10 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_17)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_11 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_18)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_12 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_19)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_13 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_20)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_14 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_21)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_15 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_22)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_16 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_23)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_17 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_24)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_18 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_25)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_19 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_26)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_20 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_27)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_21 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_28)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_22 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_29)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_23 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_30)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_24 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_31)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_25 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_32)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_26 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_33)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_27 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_34)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_28 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_35)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_29 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_36)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_30 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_37)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_31 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (io_redirect_valid | ~(REG_3 & REG_4 == 5'h0)) begin	// fetch-target-queue.scala:133:27, :158:17, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_6) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_0_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_0_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_0_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_0_cfi_mispredicted <= ~_GEN_6 & ram_0_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_6) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_0_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_0_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_0_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_0_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_0_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_0_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
      end
      ram_0_start_bank <= ~_GEN_6 & ram_0_start_bank;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_0_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_0_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_0_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_0_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_0_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_0_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_0_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_0_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_0_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_0_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_0_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 5'h1)) begin	// fetch-target-queue.scala:135:27, :158:17, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_7) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_1_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_1_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_1_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_1_cfi_mispredicted <= ~_GEN_7 & ram_1_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_7) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_1_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_1_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_1_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_1_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_1_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_1_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
      end
      ram_1_start_bank <= ~_GEN_7 & ram_1_start_bank;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_1_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_1_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_1_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_1_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_1_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_1_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_1_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_1_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_1_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_1_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_1_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 5'h2)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_8) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_2_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_2_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_2_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_2_cfi_mispredicted <= ~_GEN_8 & ram_2_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_8) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_2_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_2_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_2_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_2_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_2_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_2_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
      end
      ram_2_start_bank <= ~_GEN_8 & ram_2_start_bank;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_2_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_2_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_2_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_2_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_2_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_2_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_2_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_2_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_2_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_2_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_2_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 5'h3)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_9) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_3_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_3_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_3_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_3_cfi_mispredicted <= ~_GEN_9 & ram_3_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_9) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_3_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_3_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_3_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_3_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_3_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_3_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
      end
      ram_3_start_bank <= ~_GEN_9 & ram_3_start_bank;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_3_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_3_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_3_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_3_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_3_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_3_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_3_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_3_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_3_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_3_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_3_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 5'h4)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_10) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_4_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_4_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_4_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_4_cfi_mispredicted <= ~_GEN_10 & ram_4_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_10) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_4_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_4_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_4_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_4_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_4_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_4_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
      end
      ram_4_start_bank <= ~_GEN_10 & ram_4_start_bank;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_4_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_4_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_4_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_4_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_4_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_4_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_4_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_4_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_4_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_4_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_4_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 5'h5)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_11) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_5_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_5_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_5_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_5_cfi_mispredicted <= ~_GEN_11 & ram_5_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_11) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_5_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_5_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_5_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_5_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_5_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_5_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
      end
      ram_5_start_bank <= ~_GEN_11 & ram_5_start_bank;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_5_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_5_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_5_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_5_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_5_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_5_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_5_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_5_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_5_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_5_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_5_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 5'h6)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_12) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_6_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_6_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_6_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_6_cfi_mispredicted <= ~_GEN_12 & ram_6_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_12) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_6_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_6_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_6_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_6_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_6_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_6_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
      end
      ram_6_start_bank <= ~_GEN_12 & ram_6_start_bank;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_6_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_6_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_6_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_6_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_6_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_6_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_6_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_6_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_6_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_6_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_6_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 5'h7)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_13) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_7_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_7_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_7_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_7_cfi_mispredicted <= ~_GEN_13 & ram_7_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_13) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_7_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_7_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_7_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_7_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_7_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_7_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
      end
      ram_7_start_bank <= ~_GEN_13 & ram_7_start_bank;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_7_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_7_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_7_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_7_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_7_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_7_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_7_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_7_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_7_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_7_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_7_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 5'h8)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_14) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_8_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_8_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_8_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_8_cfi_mispredicted <= ~_GEN_14 & ram_8_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_14) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_8_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_8_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_8_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_8_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_8_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_8_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
      end
      ram_8_start_bank <= ~_GEN_14 & ram_8_start_bank;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_8_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_8_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_8_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_8_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_8_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_8_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_8_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_8_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_8_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_8_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_8_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 5'h9)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_15) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_9_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_9_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_9_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_9_cfi_mispredicted <= ~_GEN_15 & ram_9_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_15) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_9_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_9_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_9_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_9_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_9_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_9_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
      end
      ram_9_start_bank <= ~_GEN_15 & ram_9_start_bank;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_9_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_9_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_9_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_9_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_9_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_9_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_9_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_9_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_9_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_9_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_9_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 5'hA)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_16) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_10_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_10_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_10_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_10_cfi_mispredicted <= ~_GEN_16 & ram_10_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_16) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_10_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_10_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_10_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_10_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_10_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_10_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
      end
      ram_10_start_bank <= ~_GEN_16 & ram_10_start_bank;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_10_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_10_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_10_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_10_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_10_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_10_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_10_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_10_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_10_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_10_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_10_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 5'hB)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_17) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_11_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_11_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_11_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_11_cfi_mispredicted <= ~_GEN_17 & ram_11_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_17) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_11_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_11_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_11_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_11_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_11_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_11_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
      end
      ram_11_start_bank <= ~_GEN_17 & ram_11_start_bank;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_11_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_11_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_11_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_11_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_11_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_11_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_11_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_11_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_11_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_11_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_11_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 5'hC)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_18) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_12_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_12_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_12_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_12_cfi_mispredicted <= ~_GEN_18 & ram_12_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_18) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_12_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_12_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_12_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_12_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_12_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_12_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
      end
      ram_12_start_bank <= ~_GEN_18 & ram_12_start_bank;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_12_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_12_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_12_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_12_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_12_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_12_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_12_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_12_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_12_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_12_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_12_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 5'hD)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_19) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_13_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_13_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_13_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_13_cfi_mispredicted <= ~_GEN_19 & ram_13_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_19) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_13_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_13_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_13_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_13_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_13_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_13_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
      end
      ram_13_start_bank <= ~_GEN_19 & ram_13_start_bank;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_13_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_13_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_13_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_13_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_13_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_13_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_13_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_13_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_13_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_13_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_13_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 5'hE)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_20) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_14_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_14_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_14_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_14_cfi_mispredicted <= ~_GEN_20 & ram_14_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_20) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_14_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_14_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_14_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_14_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_14_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_14_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
      end
      ram_14_start_bank <= ~_GEN_20 & ram_14_start_bank;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_14_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_14_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_14_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_14_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_14_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_14_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_14_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_14_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_14_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_14_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_14_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 5'hF)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_21) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_15_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_15_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_15_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_15_cfi_mispredicted <= ~_GEN_21 & ram_15_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_21) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_15_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_15_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_15_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_15_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_15_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_15_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
      end
      ram_15_start_bank <= ~_GEN_21 & ram_15_start_bank;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_15_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_15_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_15_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_15_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_15_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_15_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_15_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_15_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_15_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_15_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_15_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 5'h10)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_22) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_16_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_16_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_16_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_16_cfi_mispredicted <= ~_GEN_22 & ram_16_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_22) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_16_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_16_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_16_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_16_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_16_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_16_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
      end
      ram_16_start_bank <= ~_GEN_22 & ram_16_start_bank;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_16_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_16_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_16_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_16_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_16_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_16_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_16_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_16_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_16_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_16_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_16_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 5'h11)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_23) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_17_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_17_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_17_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_17_cfi_mispredicted <= ~_GEN_23 & ram_17_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_23) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_17_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_17_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_17_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_17_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_17_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_17_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
      end
      ram_17_start_bank <= ~_GEN_23 & ram_17_start_bank;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_17_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_17_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_17_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_17_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_17_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_17_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_17_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_17_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_17_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_17_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_17_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 5'h12)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_24) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_18_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_18_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_18_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_18_cfi_mispredicted <= ~_GEN_24 & ram_18_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_24) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_18_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_18_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_18_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_18_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_18_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_18_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
      end
      ram_18_start_bank <= ~_GEN_24 & ram_18_start_bank;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_18_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_18_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_18_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_18_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_18_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_18_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_18_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_18_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_18_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_18_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_18_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 5'h13)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_25) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_19_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_19_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_19_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_19_cfi_mispredicted <= ~_GEN_25 & ram_19_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_25) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_19_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_19_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_19_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_19_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_19_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_19_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
      end
      ram_19_start_bank <= ~_GEN_25 & ram_19_start_bank;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_19_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_19_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_19_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_19_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_19_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_19_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_19_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_19_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_19_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_19_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_19_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 5'h14)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_26) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_20_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_20_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_20_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_20_cfi_mispredicted <= ~_GEN_26 & ram_20_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_26) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_20_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_20_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_20_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_20_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_20_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_20_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
      end
      ram_20_start_bank <= ~_GEN_26 & ram_20_start_bank;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_20_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_20_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_20_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_20_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_20_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_20_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_20_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_20_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_20_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_20_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_20_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 5'h15)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_27) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_21_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_21_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_21_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_21_cfi_mispredicted <= ~_GEN_27 & ram_21_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_27) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_21_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_21_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_21_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_21_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_21_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_21_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
      end
      ram_21_start_bank <= ~_GEN_27 & ram_21_start_bank;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_21_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_21_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_21_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_21_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_21_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_21_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_21_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_21_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_21_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_21_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_21_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 5'h16)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_28) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_22_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_22_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_22_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_22_cfi_mispredicted <= ~_GEN_28 & ram_22_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_28) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_22_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_22_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_22_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_22_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_22_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_22_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
      end
      ram_22_start_bank <= ~_GEN_28 & ram_22_start_bank;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_22_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_22_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_22_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_22_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_22_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_22_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_22_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_22_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_22_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_22_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_22_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 5'h17)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_29) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_23_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_23_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_23_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_23_cfi_mispredicted <= ~_GEN_29 & ram_23_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_29) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_23_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_23_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_23_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_23_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_23_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_23_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
      end
      ram_23_start_bank <= ~_GEN_29 & ram_23_start_bank;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_23_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_23_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_23_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_23_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_23_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_23_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_23_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_23_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_23_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_23_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_23_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 5'h18)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_30) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_24_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_24_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_24_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_24_cfi_mispredicted <= ~_GEN_30 & ram_24_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_30) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_24_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_24_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_24_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_24_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_24_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_24_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
      end
      ram_24_start_bank <= ~_GEN_30 & ram_24_start_bank;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_24_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_24_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_24_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_24_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_24_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_24_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_24_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_24_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_24_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_24_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_24_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 5'h19)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_31) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_25_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_25_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_25_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_25_cfi_mispredicted <= ~_GEN_31 & ram_25_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_31) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_25_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_25_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_25_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_25_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_25_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_25_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
      end
      ram_25_start_bank <= ~_GEN_31 & ram_25_start_bank;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_25_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_25_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_25_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_25_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_25_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_25_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_25_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_25_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_25_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_25_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_25_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 5'h1A)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_32) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_26_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_26_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_26_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_26_cfi_mispredicted <= ~_GEN_32 & ram_26_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_32) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_26_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_26_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_26_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_26_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_26_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_26_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
      end
      ram_26_start_bank <= ~_GEN_32 & ram_26_start_bank;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_26_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_26_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_26_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_26_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_26_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_26_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_26_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_26_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_26_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_26_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_26_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 5'h1B)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_33) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_27_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_27_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_27_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_27_cfi_mispredicted <= ~_GEN_33 & ram_27_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_33) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_27_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_27_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_27_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_27_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_27_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_27_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
      end
      ram_27_start_bank <= ~_GEN_33 & ram_27_start_bank;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_27_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_27_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_27_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_27_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_27_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_27_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_27_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_27_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_27_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_27_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_27_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 5'h1C)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_34) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_28_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_28_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_28_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_28_cfi_mispredicted <= ~_GEN_34 & ram_28_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_34) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_28_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_28_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_28_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_28_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_28_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_28_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
      end
      ram_28_start_bank <= ~_GEN_34 & ram_28_start_bank;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_28_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_28_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_28_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_28_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_28_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_28_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_28_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_28_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_28_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_28_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_28_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 5'h1D)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_35) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_29_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_29_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_29_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_29_cfi_mispredicted <= ~_GEN_35 & ram_29_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_35) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_29_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_29_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_29_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_29_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_29_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_29_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
      end
      ram_29_start_bank <= ~_GEN_35 & ram_29_start_bank;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_29_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_29_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_29_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_29_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_29_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_29_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_29_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_29_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_29_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_29_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_29_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 5'h1E)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_36) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_30_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_30_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_30_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_30_cfi_mispredicted <= ~_GEN_36 & ram_30_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_36) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_30_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_30_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_30_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_30_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_30_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_30_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
      end
      ram_30_start_bank <= ~_GEN_36 & ram_30_start_bank;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_30_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_30_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_30_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_30_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_30_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_30_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_30_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_30_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_30_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_30_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_30_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    if (io_redirect_valid | ~(REG_3 & (&REG_4))) begin	// fetch-target-queue.scala:158:17, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_37) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_31_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_31_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_31_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_31_cfi_mispredicted <= ~_GEN_37 & ram_31_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_37) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_31_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_31_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_31_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_31_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_31_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_31_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
      end
      ram_31_start_bank <= ~_GEN_37 & ram_31_start_bank;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_31_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_31_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_31_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_31_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_31_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_31_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_31_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_31_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_31_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_31_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_31_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    io_ras_update_REG <= io_redirect_valid;	// fetch-target-queue.scala:222:31
    if (io_redirect_valid) begin
      io_ras_update_pc_REG <= _GEN_48[io_redirect_bits];	// fetch-target-queue.scala:223:31
      io_ras_update_idx_REG <= _GEN_49[io_redirect_bits];	// fetch-target-queue.scala:224:31
    end
    else begin
      io_ras_update_pc_REG <= 40'h0;	// fetch-target-queue.scala:156:42, :223:31
      io_ras_update_idx_REG <= 5'h0;	// fetch-target-queue.scala:133:27, :224:31
      if (REG)	// fetch-target-queue.scala:248:23
        bpd_repair_idx <= bpd_repair_idx_REG;	// fetch-target-queue.scala:228:27, :250:37
      else if (bpd_update_mispredict)	// fetch-target-queue.scala:226:38
        bpd_repair_idx <= bpd_repair_idx + 5'h1;	// fetch-target-queue.scala:135:27, :228:27, util.scala:203:14
      else if (_GEN_45)	// fetch-target-queue.scala:256:34
        bpd_repair_idx <= bpd_repair_idx + 5'h1;	// fetch-target-queue.scala:135:27, :228:27, util.scala:203:14
      else if (bpd_update_repair)	// fetch-target-queue.scala:227:34
        bpd_repair_idx <= _bpd_repair_idx_T_6;	// fetch-target-queue.scala:228:27, util.scala:203:14
    end
    if (io_redirect_valid | ~REG) begin	// fetch-target-queue.scala:229:24, :245:28, :248:{23,52}
    end
    else	// fetch-target-queue.scala:229:24, :245:28, :248:52
      bpd_end_idx <= bpd_end_idx_REG;	// fetch-target-queue.scala:229:24, :251:37
    if (io_redirect_valid | REG | bpd_update_mispredict | ~_GEN_45) begin	// fetch-target-queue.scala:226:38, :230:26, :245:28, :248:{23,52}, :252:39, :256:{34,69}
    end
    else	// fetch-target-queue.scala:230:26, :245:28, :248:52, :252:39, :256:69
      bpd_repair_pc <= bpd_pc;	// fetch-target-queue.scala:230:26, :242:26
    bpd_entry_cfi_idx_valid <= _GEN_38[_bpd_meta_T_1];	// fetch-target-queue.scala:232:20, :234:26
    bpd_entry_cfi_idx_bits <= _GEN_39[_bpd_meta_T_1];	// fetch-target-queue.scala:232:20, :234:26
    bpd_entry_cfi_taken <= _GEN_40[_bpd_meta_T_1];	// fetch-target-queue.scala:232:20, :234:26
    bpd_entry_cfi_mispredicted <= _GEN_41[_bpd_meta_T_1];	// fetch-target-queue.scala:232:20, :234:26
    bpd_entry_cfi_type <= _GEN_42[_bpd_meta_T_1];	// fetch-target-queue.scala:232:20, :234:26
    bpd_entry_br_mask <= _GEN_43[_bpd_meta_T_1];	// fetch-target-queue.scala:232:20, :234:26
    bpd_pc <= _GEN_44[_bpd_meta_T_1];	// fetch-target-queue.scala:232:20, :242:26
    bpd_target <= _GEN_44[_bpd_meta_T_1 + 5'h1];	// fetch-target-queue.scala:135:27, :232:20, :242:26, :243:27, util.scala:203:14
    REG <= io_brupdate_b2_mispredict;	// fetch-target-queue.scala:248:23
    bpd_repair_idx_REG <= io_brupdate_b2_uop_ftq_idx;	// fetch-target-queue.scala:250:37
    bpd_end_idx_REG <= enq_ptr;	// fetch-target-queue.scala:135:27, :251:37
    REG_1 <= bpd_update_mispredict;	// fetch-target-queue.scala:226:38, :256:44
    do_commit_update_REG <= io_redirect_valid;	// fetch-target-queue.scala:274:61
    REG_2 <= do_commit_update | bpd_update_repair | bpd_update_mispredict;	// fetch-target-queue.scala:226:38, :227:34, :274:50, :278:{16,54}
    io_bpdupdate_valid_REG <= bpd_update_repair;	// fetch-target-queue.scala:227:34, :284:37
    io_bpdupdate_bits_is_mispredict_update_REG <= bpd_update_mispredict;	// fetch-target-queue.scala:226:38, :285:54
    io_bpdupdate_bits_is_repair_update_REG <= bpd_update_repair;	// fetch-target-queue.scala:227:34, :286:54
    io_enq_ready_REG <=
      ~(enq_ptr + 5'h2 == bpd_ptr | _enq_ptr_T == bpd_ptr) | do_commit_update;	// fetch-target-queue.scala:133:27, :135:27, :137:{68,81}, :138:46, :160:28, :274:50, :308:{26,27,33}, util.scala:203:14
    REG_3 <= io_redirect_valid;	// fetch-target-queue.scala:332:23
    prev_entry_REG_cfi_idx_valid <= redirect_new_entry_cfi_idx_valid;	// fetch-target-queue.scala:314:28, :317:38, :320:43, :333:26
    if (_GEN_51) begin	// fetch-target-queue.scala:314:28, :317:38, :320:43
      prev_entry_REG_cfi_idx_bits <= io_brupdate_b2_uop_pc_lob[2:1];	// fetch-target-queue.scala:318:50, :333:26
      prev_entry_REG_cfi_taken <= io_brupdate_b2_taken;	// fetch-target-queue.scala:333:26
      ram_REG_cfi_idx_bits <= io_brupdate_b2_uop_pc_lob[2:1];	// fetch-target-queue.scala:318:50, :337:46
      ram_REG_cfi_taken <= io_brupdate_b2_taken;	// fetch-target-queue.scala:337:46
    end
    else begin	// fetch-target-queue.scala:314:28, :317:38, :320:43
      prev_entry_REG_cfi_idx_bits <= _GEN_39[io_redirect_bits];	// fetch-target-queue.scala:234:26, :333:26
      prev_entry_REG_cfi_taken <= _GEN_40[io_redirect_bits];	// fetch-target-queue.scala:234:26, :333:26
      ram_REG_cfi_idx_bits <= _GEN_39[io_redirect_bits];	// fetch-target-queue.scala:234:26, :337:46
      ram_REG_cfi_taken <= _GEN_40[io_redirect_bits];	// fetch-target-queue.scala:234:26, :337:46
    end
    prev_entry_REG_br_mask <= _GEN_43[io_redirect_bits];	// fetch-target-queue.scala:234:26, :333:26
    prev_entry_REG_cfi_is_call <= redirect_new_entry_cfi_is_call;	// fetch-target-queue.scala:314:28, :317:38, :324:43, :333:26
    prev_entry_REG_cfi_is_ret <= redirect_new_entry_cfi_is_ret;	// fetch-target-queue.scala:314:28, :317:38, :325:43, :333:26
    REG_4 <= io_redirect_bits;	// fetch-target-queue.scala:337:16
    ram_REG_cfi_idx_valid <= redirect_new_entry_cfi_idx_valid;	// fetch-target-queue.scala:314:28, :317:38, :320:43, :337:46
    ram_REG_cfi_mispredicted <= _GEN_51 | _GEN_41[io_redirect_bits];	// fetch-target-queue.scala:234:26, :314:28, :317:38, :320:43, :322:43, :337:46
    ram_REG_cfi_type <= _GEN_42[io_redirect_bits];	// fetch-target-queue.scala:234:26, :337:46
    ram_REG_br_mask <= _GEN_43[io_redirect_bits];	// fetch-target-queue.scala:234:26, :337:46
    ram_REG_cfi_is_call <= redirect_new_entry_cfi_is_call;	// fetch-target-queue.scala:314:28, :317:38, :324:43, :337:46
    ram_REG_cfi_is_ret <= redirect_new_entry_cfi_is_ret;	// fetch-target-queue.scala:314:28, :317:38, :325:43, :337:46
    ram_REG_ras_top <= _GEN_48[io_redirect_bits];	// fetch-target-queue.scala:337:46
    ram_REG_ras_idx <= _GEN_49[io_redirect_bits];	// fetch-target-queue.scala:337:46
    ram_REG_start_bank <= _GEN_50[io_redirect_bits];	// fetch-target-queue.scala:337:46
    io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= _GEN_38[io_get_ftq_pc_0_ftq_idx];	// fetch-target-queue.scala:234:26, :351:42
    io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= _GEN_39[io_get_ftq_pc_0_ftq_idx];	// fetch-target-queue.scala:234:26, :351:42
    io_get_ftq_pc_0_entry_REG_ras_idx <= _GEN_49[io_get_ftq_pc_0_ftq_idx];	// fetch-target-queue.scala:351:42
    io_get_ftq_pc_0_entry_REG_start_bank <= _GEN_50[io_get_ftq_pc_0_ftq_idx];	// fetch-target-queue.scala:351:42
    io_get_ftq_pc_0_pc_REG <= _GEN_44[io_get_ftq_pc_0_ftq_idx];	// fetch-target-queue.scala:242:26, :356:42
    if (next_is_enq)	// fetch-target-queue.scala:347:46
      io_get_ftq_pc_0_next_pc_REG <= io_enq_bits_pc;	// fetch-target-queue.scala:357:42
    else	// fetch-target-queue.scala:347:46
      io_get_ftq_pc_0_next_pc_REG <= _GEN_44[_next_idx_T];	// fetch-target-queue.scala:242:26, :348:22, :357:42, util.scala:203:14
    io_get_ftq_pc_0_next_val_REG <= _next_idx_T != enq_ptr | next_is_enq;	// fetch-target-queue.scala:135:27, :347:46, :358:{42,52,64}, util.scala:203:14
    io_get_ftq_pc_0_com_pc_REG <= _GEN_44[io_deq_valid ? io_deq_bits : deq_ptr];	// fetch-target-queue.scala:134:27, :242:26, :359:{42,50}
    io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= _GEN_39[io_get_ftq_pc_1_ftq_idx];	// fetch-target-queue.scala:234:26, :351:42
    io_get_ftq_pc_1_entry_REG_br_mask <= _GEN_43[io_get_ftq_pc_1_ftq_idx];	// fetch-target-queue.scala:234:26, :351:42
    io_get_ftq_pc_1_entry_REG_cfi_is_call <= _GEN_46[io_get_ftq_pc_1_ftq_idx];	// fetch-target-queue.scala:351:42
    io_get_ftq_pc_1_entry_REG_cfi_is_ret <= _GEN_47[io_get_ftq_pc_1_ftq_idx];	// fetch-target-queue.scala:351:42
    io_get_ftq_pc_1_entry_REG_start_bank <= _GEN_50[io_get_ftq_pc_1_ftq_idx];	// fetch-target-queue.scala:351:42
    io_get_ftq_pc_1_pc_REG <= _GEN_44[io_get_ftq_pc_1_ftq_idx];	// fetch-target-queue.scala:242:26, :356:42
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:127];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [7:0] i = 8'h0; i < 8'h80; i += 8'h1) begin
          _RANDOM[i[6:0]] = `RANDOM;
        end
        bpd_ptr = _RANDOM[7'h0][4:0];	// fetch-target-queue.scala:133:27
        deq_ptr = _RANDOM[7'h0][9:5];	// fetch-target-queue.scala:133:27, :134:27
        enq_ptr = _RANDOM[7'h0][14:10];	// fetch-target-queue.scala:133:27, :135:27
        pcs_0 = {_RANDOM[7'h0][31:15], _RANDOM[7'h1][22:0]};	// fetch-target-queue.scala:133:27, :141:21
        pcs_1 = {_RANDOM[7'h1][31:23], _RANDOM[7'h2][30:0]};	// fetch-target-queue.scala:141:21
        pcs_2 = {_RANDOM[7'h2][31], _RANDOM[7'h3], _RANDOM[7'h4][6:0]};	// fetch-target-queue.scala:141:21
        pcs_3 = {_RANDOM[7'h4][31:7], _RANDOM[7'h5][14:0]};	// fetch-target-queue.scala:141:21
        pcs_4 = {_RANDOM[7'h5][31:15], _RANDOM[7'h6][22:0]};	// fetch-target-queue.scala:141:21
        pcs_5 = {_RANDOM[7'h6][31:23], _RANDOM[7'h7][30:0]};	// fetch-target-queue.scala:141:21
        pcs_6 = {_RANDOM[7'h7][31], _RANDOM[7'h8], _RANDOM[7'h9][6:0]};	// fetch-target-queue.scala:141:21
        pcs_7 = {_RANDOM[7'h9][31:7], _RANDOM[7'hA][14:0]};	// fetch-target-queue.scala:141:21
        pcs_8 = {_RANDOM[7'hA][31:15], _RANDOM[7'hB][22:0]};	// fetch-target-queue.scala:141:21
        pcs_9 = {_RANDOM[7'hB][31:23], _RANDOM[7'hC][30:0]};	// fetch-target-queue.scala:141:21
        pcs_10 = {_RANDOM[7'hC][31], _RANDOM[7'hD], _RANDOM[7'hE][6:0]};	// fetch-target-queue.scala:141:21
        pcs_11 = {_RANDOM[7'hE][31:7], _RANDOM[7'hF][14:0]};	// fetch-target-queue.scala:141:21
        pcs_12 = {_RANDOM[7'hF][31:15], _RANDOM[7'h10][22:0]};	// fetch-target-queue.scala:141:21
        pcs_13 = {_RANDOM[7'h10][31:23], _RANDOM[7'h11][30:0]};	// fetch-target-queue.scala:141:21
        pcs_14 = {_RANDOM[7'h11][31], _RANDOM[7'h12], _RANDOM[7'h13][6:0]};	// fetch-target-queue.scala:141:21
        pcs_15 = {_RANDOM[7'h13][31:7], _RANDOM[7'h14][14:0]};	// fetch-target-queue.scala:141:21
        pcs_16 = {_RANDOM[7'h14][31:15], _RANDOM[7'h15][22:0]};	// fetch-target-queue.scala:141:21
        pcs_17 = {_RANDOM[7'h15][31:23], _RANDOM[7'h16][30:0]};	// fetch-target-queue.scala:141:21
        pcs_18 = {_RANDOM[7'h16][31], _RANDOM[7'h17], _RANDOM[7'h18][6:0]};	// fetch-target-queue.scala:141:21
        pcs_19 = {_RANDOM[7'h18][31:7], _RANDOM[7'h19][14:0]};	// fetch-target-queue.scala:141:21
        pcs_20 = {_RANDOM[7'h19][31:15], _RANDOM[7'h1A][22:0]};	// fetch-target-queue.scala:141:21
        pcs_21 = {_RANDOM[7'h1A][31:23], _RANDOM[7'h1B][30:0]};	// fetch-target-queue.scala:141:21
        pcs_22 = {_RANDOM[7'h1B][31], _RANDOM[7'h1C], _RANDOM[7'h1D][6:0]};	// fetch-target-queue.scala:141:21
        pcs_23 = {_RANDOM[7'h1D][31:7], _RANDOM[7'h1E][14:0]};	// fetch-target-queue.scala:141:21
        pcs_24 = {_RANDOM[7'h1E][31:15], _RANDOM[7'h1F][22:0]};	// fetch-target-queue.scala:141:21
        pcs_25 = {_RANDOM[7'h1F][31:23], _RANDOM[7'h20][30:0]};	// fetch-target-queue.scala:141:21
        pcs_26 = {_RANDOM[7'h20][31], _RANDOM[7'h21], _RANDOM[7'h22][6:0]};	// fetch-target-queue.scala:141:21
        pcs_27 = {_RANDOM[7'h22][31:7], _RANDOM[7'h23][14:0]};	// fetch-target-queue.scala:141:21
        pcs_28 = {_RANDOM[7'h23][31:15], _RANDOM[7'h24][22:0]};	// fetch-target-queue.scala:141:21
        pcs_29 = {_RANDOM[7'h24][31:23], _RANDOM[7'h25][30:0]};	// fetch-target-queue.scala:141:21
        pcs_30 = {_RANDOM[7'h25][31], _RANDOM[7'h26], _RANDOM[7'h27][6:0]};	// fetch-target-queue.scala:141:21
        pcs_31 = {_RANDOM[7'h27][31:7], _RANDOM[7'h28][14:0]};	// fetch-target-queue.scala:141:21
        ram_0_cfi_idx_valid = _RANDOM[7'h28][15];	// fetch-target-queue.scala:141:21, :143:21
        ram_0_cfi_idx_bits = _RANDOM[7'h28][17:16];	// fetch-target-queue.scala:141:21, :143:21
        ram_0_cfi_taken = _RANDOM[7'h28][18];	// fetch-target-queue.scala:141:21, :143:21
        ram_0_cfi_mispredicted = _RANDOM[7'h28][19];	// fetch-target-queue.scala:141:21, :143:21
        ram_0_cfi_type = _RANDOM[7'h28][22:20];	// fetch-target-queue.scala:141:21, :143:21
        ram_0_br_mask = _RANDOM[7'h28][26:23];	// fetch-target-queue.scala:141:21, :143:21
        ram_0_cfi_is_call = _RANDOM[7'h28][27];	// fetch-target-queue.scala:141:21, :143:21
        ram_0_cfi_is_ret = _RANDOM[7'h28][28];	// fetch-target-queue.scala:141:21, :143:21
        ram_0_ras_top = {_RANDOM[7'h28][31:30], _RANDOM[7'h29], _RANDOM[7'h2A][5:0]};	// fetch-target-queue.scala:141:21, :143:21
        ram_0_ras_idx = _RANDOM[7'h2A][10:6];	// fetch-target-queue.scala:143:21
        ram_0_start_bank = _RANDOM[7'h2A][11];	// fetch-target-queue.scala:143:21
        ram_1_cfi_idx_valid = _RANDOM[7'h2A][12];	// fetch-target-queue.scala:143:21
        ram_1_cfi_idx_bits = _RANDOM[7'h2A][14:13];	// fetch-target-queue.scala:143:21
        ram_1_cfi_taken = _RANDOM[7'h2A][15];	// fetch-target-queue.scala:143:21
        ram_1_cfi_mispredicted = _RANDOM[7'h2A][16];	// fetch-target-queue.scala:143:21
        ram_1_cfi_type = _RANDOM[7'h2A][19:17];	// fetch-target-queue.scala:143:21
        ram_1_br_mask = _RANDOM[7'h2A][23:20];	// fetch-target-queue.scala:143:21
        ram_1_cfi_is_call = _RANDOM[7'h2A][24];	// fetch-target-queue.scala:143:21
        ram_1_cfi_is_ret = _RANDOM[7'h2A][25];	// fetch-target-queue.scala:143:21
        ram_1_ras_top = {_RANDOM[7'h2A][31:27], _RANDOM[7'h2B], _RANDOM[7'h2C][2:0]};	// fetch-target-queue.scala:143:21
        ram_1_ras_idx = _RANDOM[7'h2C][7:3];	// fetch-target-queue.scala:143:21
        ram_1_start_bank = _RANDOM[7'h2C][8];	// fetch-target-queue.scala:143:21
        ram_2_cfi_idx_valid = _RANDOM[7'h2C][9];	// fetch-target-queue.scala:143:21
        ram_2_cfi_idx_bits = _RANDOM[7'h2C][11:10];	// fetch-target-queue.scala:143:21
        ram_2_cfi_taken = _RANDOM[7'h2C][12];	// fetch-target-queue.scala:143:21
        ram_2_cfi_mispredicted = _RANDOM[7'h2C][13];	// fetch-target-queue.scala:143:21
        ram_2_cfi_type = _RANDOM[7'h2C][16:14];	// fetch-target-queue.scala:143:21
        ram_2_br_mask = _RANDOM[7'h2C][20:17];	// fetch-target-queue.scala:143:21
        ram_2_cfi_is_call = _RANDOM[7'h2C][21];	// fetch-target-queue.scala:143:21
        ram_2_cfi_is_ret = _RANDOM[7'h2C][22];	// fetch-target-queue.scala:143:21
        ram_2_ras_top = {_RANDOM[7'h2C][31:24], _RANDOM[7'h2D]};	// fetch-target-queue.scala:143:21
        ram_2_ras_idx = _RANDOM[7'h2E][4:0];	// fetch-target-queue.scala:143:21
        ram_2_start_bank = _RANDOM[7'h2E][5];	// fetch-target-queue.scala:143:21
        ram_3_cfi_idx_valid = _RANDOM[7'h2E][6];	// fetch-target-queue.scala:143:21
        ram_3_cfi_idx_bits = _RANDOM[7'h2E][8:7];	// fetch-target-queue.scala:143:21
        ram_3_cfi_taken = _RANDOM[7'h2E][9];	// fetch-target-queue.scala:143:21
        ram_3_cfi_mispredicted = _RANDOM[7'h2E][10];	// fetch-target-queue.scala:143:21
        ram_3_cfi_type = _RANDOM[7'h2E][13:11];	// fetch-target-queue.scala:143:21
        ram_3_br_mask = _RANDOM[7'h2E][17:14];	// fetch-target-queue.scala:143:21
        ram_3_cfi_is_call = _RANDOM[7'h2E][18];	// fetch-target-queue.scala:143:21
        ram_3_cfi_is_ret = _RANDOM[7'h2E][19];	// fetch-target-queue.scala:143:21
        ram_3_ras_top = {_RANDOM[7'h2E][31:21], _RANDOM[7'h2F][28:0]};	// fetch-target-queue.scala:143:21
        ram_3_ras_idx = {_RANDOM[7'h2F][31:29], _RANDOM[7'h30][1:0]};	// fetch-target-queue.scala:143:21
        ram_3_start_bank = _RANDOM[7'h30][2];	// fetch-target-queue.scala:143:21
        ram_4_cfi_idx_valid = _RANDOM[7'h30][3];	// fetch-target-queue.scala:143:21
        ram_4_cfi_idx_bits = _RANDOM[7'h30][5:4];	// fetch-target-queue.scala:143:21
        ram_4_cfi_taken = _RANDOM[7'h30][6];	// fetch-target-queue.scala:143:21
        ram_4_cfi_mispredicted = _RANDOM[7'h30][7];	// fetch-target-queue.scala:143:21
        ram_4_cfi_type = _RANDOM[7'h30][10:8];	// fetch-target-queue.scala:143:21
        ram_4_br_mask = _RANDOM[7'h30][14:11];	// fetch-target-queue.scala:143:21
        ram_4_cfi_is_call = _RANDOM[7'h30][15];	// fetch-target-queue.scala:143:21
        ram_4_cfi_is_ret = _RANDOM[7'h30][16];	// fetch-target-queue.scala:143:21
        ram_4_ras_top = {_RANDOM[7'h30][31:18], _RANDOM[7'h31][25:0]};	// fetch-target-queue.scala:143:21
        ram_4_ras_idx = _RANDOM[7'h31][30:26];	// fetch-target-queue.scala:143:21
        ram_4_start_bank = _RANDOM[7'h31][31];	// fetch-target-queue.scala:143:21
        ram_5_cfi_idx_valid = _RANDOM[7'h32][0];	// fetch-target-queue.scala:143:21
        ram_5_cfi_idx_bits = _RANDOM[7'h32][2:1];	// fetch-target-queue.scala:143:21
        ram_5_cfi_taken = _RANDOM[7'h32][3];	// fetch-target-queue.scala:143:21
        ram_5_cfi_mispredicted = _RANDOM[7'h32][4];	// fetch-target-queue.scala:143:21
        ram_5_cfi_type = _RANDOM[7'h32][7:5];	// fetch-target-queue.scala:143:21
        ram_5_br_mask = _RANDOM[7'h32][11:8];	// fetch-target-queue.scala:143:21
        ram_5_cfi_is_call = _RANDOM[7'h32][12];	// fetch-target-queue.scala:143:21
        ram_5_cfi_is_ret = _RANDOM[7'h32][13];	// fetch-target-queue.scala:143:21
        ram_5_ras_top = {_RANDOM[7'h32][31:15], _RANDOM[7'h33][22:0]};	// fetch-target-queue.scala:143:21
        ram_5_ras_idx = _RANDOM[7'h33][27:23];	// fetch-target-queue.scala:143:21
        ram_5_start_bank = _RANDOM[7'h33][28];	// fetch-target-queue.scala:143:21
        ram_6_cfi_idx_valid = _RANDOM[7'h33][29];	// fetch-target-queue.scala:143:21
        ram_6_cfi_idx_bits = _RANDOM[7'h33][31:30];	// fetch-target-queue.scala:143:21
        ram_6_cfi_taken = _RANDOM[7'h34][0];	// fetch-target-queue.scala:143:21
        ram_6_cfi_mispredicted = _RANDOM[7'h34][1];	// fetch-target-queue.scala:143:21
        ram_6_cfi_type = _RANDOM[7'h34][4:2];	// fetch-target-queue.scala:143:21
        ram_6_br_mask = _RANDOM[7'h34][8:5];	// fetch-target-queue.scala:143:21
        ram_6_cfi_is_call = _RANDOM[7'h34][9];	// fetch-target-queue.scala:143:21
        ram_6_cfi_is_ret = _RANDOM[7'h34][10];	// fetch-target-queue.scala:143:21
        ram_6_ras_top = {_RANDOM[7'h34][31:12], _RANDOM[7'h35][19:0]};	// fetch-target-queue.scala:143:21
        ram_6_ras_idx = _RANDOM[7'h35][24:20];	// fetch-target-queue.scala:143:21
        ram_6_start_bank = _RANDOM[7'h35][25];	// fetch-target-queue.scala:143:21
        ram_7_cfi_idx_valid = _RANDOM[7'h35][26];	// fetch-target-queue.scala:143:21
        ram_7_cfi_idx_bits = _RANDOM[7'h35][28:27];	// fetch-target-queue.scala:143:21
        ram_7_cfi_taken = _RANDOM[7'h35][29];	// fetch-target-queue.scala:143:21
        ram_7_cfi_mispredicted = _RANDOM[7'h35][30];	// fetch-target-queue.scala:143:21
        ram_7_cfi_type = {_RANDOM[7'h35][31], _RANDOM[7'h36][1:0]};	// fetch-target-queue.scala:143:21
        ram_7_br_mask = _RANDOM[7'h36][5:2];	// fetch-target-queue.scala:143:21
        ram_7_cfi_is_call = _RANDOM[7'h36][6];	// fetch-target-queue.scala:143:21
        ram_7_cfi_is_ret = _RANDOM[7'h36][7];	// fetch-target-queue.scala:143:21
        ram_7_ras_top = {_RANDOM[7'h36][31:9], _RANDOM[7'h37][16:0]};	// fetch-target-queue.scala:143:21
        ram_7_ras_idx = _RANDOM[7'h37][21:17];	// fetch-target-queue.scala:143:21
        ram_7_start_bank = _RANDOM[7'h37][22];	// fetch-target-queue.scala:143:21
        ram_8_cfi_idx_valid = _RANDOM[7'h37][23];	// fetch-target-queue.scala:143:21
        ram_8_cfi_idx_bits = _RANDOM[7'h37][25:24];	// fetch-target-queue.scala:143:21
        ram_8_cfi_taken = _RANDOM[7'h37][26];	// fetch-target-queue.scala:143:21
        ram_8_cfi_mispredicted = _RANDOM[7'h37][27];	// fetch-target-queue.scala:143:21
        ram_8_cfi_type = _RANDOM[7'h37][30:28];	// fetch-target-queue.scala:143:21
        ram_8_br_mask = {_RANDOM[7'h37][31], _RANDOM[7'h38][2:0]};	// fetch-target-queue.scala:143:21
        ram_8_cfi_is_call = _RANDOM[7'h38][3];	// fetch-target-queue.scala:143:21
        ram_8_cfi_is_ret = _RANDOM[7'h38][4];	// fetch-target-queue.scala:143:21
        ram_8_ras_top = {_RANDOM[7'h38][31:6], _RANDOM[7'h39][13:0]};	// fetch-target-queue.scala:143:21
        ram_8_ras_idx = _RANDOM[7'h39][18:14];	// fetch-target-queue.scala:143:21
        ram_8_start_bank = _RANDOM[7'h39][19];	// fetch-target-queue.scala:143:21
        ram_9_cfi_idx_valid = _RANDOM[7'h39][20];	// fetch-target-queue.scala:143:21
        ram_9_cfi_idx_bits = _RANDOM[7'h39][22:21];	// fetch-target-queue.scala:143:21
        ram_9_cfi_taken = _RANDOM[7'h39][23];	// fetch-target-queue.scala:143:21
        ram_9_cfi_mispredicted = _RANDOM[7'h39][24];	// fetch-target-queue.scala:143:21
        ram_9_cfi_type = _RANDOM[7'h39][27:25];	// fetch-target-queue.scala:143:21
        ram_9_br_mask = _RANDOM[7'h39][31:28];	// fetch-target-queue.scala:143:21
        ram_9_cfi_is_call = _RANDOM[7'h3A][0];	// fetch-target-queue.scala:143:21
        ram_9_cfi_is_ret = _RANDOM[7'h3A][1];	// fetch-target-queue.scala:143:21
        ram_9_ras_top = {_RANDOM[7'h3A][31:3], _RANDOM[7'h3B][10:0]};	// fetch-target-queue.scala:143:21
        ram_9_ras_idx = _RANDOM[7'h3B][15:11];	// fetch-target-queue.scala:143:21
        ram_9_start_bank = _RANDOM[7'h3B][16];	// fetch-target-queue.scala:143:21
        ram_10_cfi_idx_valid = _RANDOM[7'h3B][17];	// fetch-target-queue.scala:143:21
        ram_10_cfi_idx_bits = _RANDOM[7'h3B][19:18];	// fetch-target-queue.scala:143:21
        ram_10_cfi_taken = _RANDOM[7'h3B][20];	// fetch-target-queue.scala:143:21
        ram_10_cfi_mispredicted = _RANDOM[7'h3B][21];	// fetch-target-queue.scala:143:21
        ram_10_cfi_type = _RANDOM[7'h3B][24:22];	// fetch-target-queue.scala:143:21
        ram_10_br_mask = _RANDOM[7'h3B][28:25];	// fetch-target-queue.scala:143:21
        ram_10_cfi_is_call = _RANDOM[7'h3B][29];	// fetch-target-queue.scala:143:21
        ram_10_cfi_is_ret = _RANDOM[7'h3B][30];	// fetch-target-queue.scala:143:21
        ram_10_ras_top = {_RANDOM[7'h3C], _RANDOM[7'h3D][7:0]};	// fetch-target-queue.scala:143:21
        ram_10_ras_idx = _RANDOM[7'h3D][12:8];	// fetch-target-queue.scala:143:21
        ram_10_start_bank = _RANDOM[7'h3D][13];	// fetch-target-queue.scala:143:21
        ram_11_cfi_idx_valid = _RANDOM[7'h3D][14];	// fetch-target-queue.scala:143:21
        ram_11_cfi_idx_bits = _RANDOM[7'h3D][16:15];	// fetch-target-queue.scala:143:21
        ram_11_cfi_taken = _RANDOM[7'h3D][17];	// fetch-target-queue.scala:143:21
        ram_11_cfi_mispredicted = _RANDOM[7'h3D][18];	// fetch-target-queue.scala:143:21
        ram_11_cfi_type = _RANDOM[7'h3D][21:19];	// fetch-target-queue.scala:143:21
        ram_11_br_mask = _RANDOM[7'h3D][25:22];	// fetch-target-queue.scala:143:21
        ram_11_cfi_is_call = _RANDOM[7'h3D][26];	// fetch-target-queue.scala:143:21
        ram_11_cfi_is_ret = _RANDOM[7'h3D][27];	// fetch-target-queue.scala:143:21
        ram_11_ras_top = {_RANDOM[7'h3D][31:29], _RANDOM[7'h3E], _RANDOM[7'h3F][4:0]};	// fetch-target-queue.scala:143:21
        ram_11_ras_idx = _RANDOM[7'h3F][9:5];	// fetch-target-queue.scala:143:21
        ram_11_start_bank = _RANDOM[7'h3F][10];	// fetch-target-queue.scala:143:21
        ram_12_cfi_idx_valid = _RANDOM[7'h3F][11];	// fetch-target-queue.scala:143:21
        ram_12_cfi_idx_bits = _RANDOM[7'h3F][13:12];	// fetch-target-queue.scala:143:21
        ram_12_cfi_taken = _RANDOM[7'h3F][14];	// fetch-target-queue.scala:143:21
        ram_12_cfi_mispredicted = _RANDOM[7'h3F][15];	// fetch-target-queue.scala:143:21
        ram_12_cfi_type = _RANDOM[7'h3F][18:16];	// fetch-target-queue.scala:143:21
        ram_12_br_mask = _RANDOM[7'h3F][22:19];	// fetch-target-queue.scala:143:21
        ram_12_cfi_is_call = _RANDOM[7'h3F][23];	// fetch-target-queue.scala:143:21
        ram_12_cfi_is_ret = _RANDOM[7'h3F][24];	// fetch-target-queue.scala:143:21
        ram_12_ras_top = {_RANDOM[7'h3F][31:26], _RANDOM[7'h40], _RANDOM[7'h41][1:0]};	// fetch-target-queue.scala:143:21
        ram_12_ras_idx = _RANDOM[7'h41][6:2];	// fetch-target-queue.scala:143:21
        ram_12_start_bank = _RANDOM[7'h41][7];	// fetch-target-queue.scala:143:21
        ram_13_cfi_idx_valid = _RANDOM[7'h41][8];	// fetch-target-queue.scala:143:21
        ram_13_cfi_idx_bits = _RANDOM[7'h41][10:9];	// fetch-target-queue.scala:143:21
        ram_13_cfi_taken = _RANDOM[7'h41][11];	// fetch-target-queue.scala:143:21
        ram_13_cfi_mispredicted = _RANDOM[7'h41][12];	// fetch-target-queue.scala:143:21
        ram_13_cfi_type = _RANDOM[7'h41][15:13];	// fetch-target-queue.scala:143:21
        ram_13_br_mask = _RANDOM[7'h41][19:16];	// fetch-target-queue.scala:143:21
        ram_13_cfi_is_call = _RANDOM[7'h41][20];	// fetch-target-queue.scala:143:21
        ram_13_cfi_is_ret = _RANDOM[7'h41][21];	// fetch-target-queue.scala:143:21
        ram_13_ras_top = {_RANDOM[7'h41][31:23], _RANDOM[7'h42][30:0]};	// fetch-target-queue.scala:143:21
        ram_13_ras_idx = {_RANDOM[7'h42][31], _RANDOM[7'h43][3:0]};	// fetch-target-queue.scala:143:21
        ram_13_start_bank = _RANDOM[7'h43][4];	// fetch-target-queue.scala:143:21
        ram_14_cfi_idx_valid = _RANDOM[7'h43][5];	// fetch-target-queue.scala:143:21
        ram_14_cfi_idx_bits = _RANDOM[7'h43][7:6];	// fetch-target-queue.scala:143:21
        ram_14_cfi_taken = _RANDOM[7'h43][8];	// fetch-target-queue.scala:143:21
        ram_14_cfi_mispredicted = _RANDOM[7'h43][9];	// fetch-target-queue.scala:143:21
        ram_14_cfi_type = _RANDOM[7'h43][12:10];	// fetch-target-queue.scala:143:21
        ram_14_br_mask = _RANDOM[7'h43][16:13];	// fetch-target-queue.scala:143:21
        ram_14_cfi_is_call = _RANDOM[7'h43][17];	// fetch-target-queue.scala:143:21
        ram_14_cfi_is_ret = _RANDOM[7'h43][18];	// fetch-target-queue.scala:143:21
        ram_14_ras_top = {_RANDOM[7'h43][31:20], _RANDOM[7'h44][27:0]};	// fetch-target-queue.scala:143:21
        ram_14_ras_idx = {_RANDOM[7'h44][31:28], _RANDOM[7'h45][0]};	// fetch-target-queue.scala:143:21
        ram_14_start_bank = _RANDOM[7'h45][1];	// fetch-target-queue.scala:143:21
        ram_15_cfi_idx_valid = _RANDOM[7'h45][2];	// fetch-target-queue.scala:143:21
        ram_15_cfi_idx_bits = _RANDOM[7'h45][4:3];	// fetch-target-queue.scala:143:21
        ram_15_cfi_taken = _RANDOM[7'h45][5];	// fetch-target-queue.scala:143:21
        ram_15_cfi_mispredicted = _RANDOM[7'h45][6];	// fetch-target-queue.scala:143:21
        ram_15_cfi_type = _RANDOM[7'h45][9:7];	// fetch-target-queue.scala:143:21
        ram_15_br_mask = _RANDOM[7'h45][13:10];	// fetch-target-queue.scala:143:21
        ram_15_cfi_is_call = _RANDOM[7'h45][14];	// fetch-target-queue.scala:143:21
        ram_15_cfi_is_ret = _RANDOM[7'h45][15];	// fetch-target-queue.scala:143:21
        ram_15_ras_top = {_RANDOM[7'h45][31:17], _RANDOM[7'h46][24:0]};	// fetch-target-queue.scala:143:21
        ram_15_ras_idx = _RANDOM[7'h46][29:25];	// fetch-target-queue.scala:143:21
        ram_15_start_bank = _RANDOM[7'h46][30];	// fetch-target-queue.scala:143:21
        ram_16_cfi_idx_valid = _RANDOM[7'h46][31];	// fetch-target-queue.scala:143:21
        ram_16_cfi_idx_bits = _RANDOM[7'h47][1:0];	// fetch-target-queue.scala:143:21
        ram_16_cfi_taken = _RANDOM[7'h47][2];	// fetch-target-queue.scala:143:21
        ram_16_cfi_mispredicted = _RANDOM[7'h47][3];	// fetch-target-queue.scala:143:21
        ram_16_cfi_type = _RANDOM[7'h47][6:4];	// fetch-target-queue.scala:143:21
        ram_16_br_mask = _RANDOM[7'h47][10:7];	// fetch-target-queue.scala:143:21
        ram_16_cfi_is_call = _RANDOM[7'h47][11];	// fetch-target-queue.scala:143:21
        ram_16_cfi_is_ret = _RANDOM[7'h47][12];	// fetch-target-queue.scala:143:21
        ram_16_ras_top = {_RANDOM[7'h47][31:14], _RANDOM[7'h48][21:0]};	// fetch-target-queue.scala:143:21
        ram_16_ras_idx = _RANDOM[7'h48][26:22];	// fetch-target-queue.scala:143:21
        ram_16_start_bank = _RANDOM[7'h48][27];	// fetch-target-queue.scala:143:21
        ram_17_cfi_idx_valid = _RANDOM[7'h48][28];	// fetch-target-queue.scala:143:21
        ram_17_cfi_idx_bits = _RANDOM[7'h48][30:29];	// fetch-target-queue.scala:143:21
        ram_17_cfi_taken = _RANDOM[7'h48][31];	// fetch-target-queue.scala:143:21
        ram_17_cfi_mispredicted = _RANDOM[7'h49][0];	// fetch-target-queue.scala:143:21
        ram_17_cfi_type = _RANDOM[7'h49][3:1];	// fetch-target-queue.scala:143:21
        ram_17_br_mask = _RANDOM[7'h49][7:4];	// fetch-target-queue.scala:143:21
        ram_17_cfi_is_call = _RANDOM[7'h49][8];	// fetch-target-queue.scala:143:21
        ram_17_cfi_is_ret = _RANDOM[7'h49][9];	// fetch-target-queue.scala:143:21
        ram_17_ras_top = {_RANDOM[7'h49][31:11], _RANDOM[7'h4A][18:0]};	// fetch-target-queue.scala:143:21
        ram_17_ras_idx = _RANDOM[7'h4A][23:19];	// fetch-target-queue.scala:143:21
        ram_17_start_bank = _RANDOM[7'h4A][24];	// fetch-target-queue.scala:143:21
        ram_18_cfi_idx_valid = _RANDOM[7'h4A][25];	// fetch-target-queue.scala:143:21
        ram_18_cfi_idx_bits = _RANDOM[7'h4A][27:26];	// fetch-target-queue.scala:143:21
        ram_18_cfi_taken = _RANDOM[7'h4A][28];	// fetch-target-queue.scala:143:21
        ram_18_cfi_mispredicted = _RANDOM[7'h4A][29];	// fetch-target-queue.scala:143:21
        ram_18_cfi_type = {_RANDOM[7'h4A][31:30], _RANDOM[7'h4B][0]};	// fetch-target-queue.scala:143:21
        ram_18_br_mask = _RANDOM[7'h4B][4:1];	// fetch-target-queue.scala:143:21
        ram_18_cfi_is_call = _RANDOM[7'h4B][5];	// fetch-target-queue.scala:143:21
        ram_18_cfi_is_ret = _RANDOM[7'h4B][6];	// fetch-target-queue.scala:143:21
        ram_18_ras_top = {_RANDOM[7'h4B][31:8], _RANDOM[7'h4C][15:0]};	// fetch-target-queue.scala:143:21
        ram_18_ras_idx = _RANDOM[7'h4C][20:16];	// fetch-target-queue.scala:143:21
        ram_18_start_bank = _RANDOM[7'h4C][21];	// fetch-target-queue.scala:143:21
        ram_19_cfi_idx_valid = _RANDOM[7'h4C][22];	// fetch-target-queue.scala:143:21
        ram_19_cfi_idx_bits = _RANDOM[7'h4C][24:23];	// fetch-target-queue.scala:143:21
        ram_19_cfi_taken = _RANDOM[7'h4C][25];	// fetch-target-queue.scala:143:21
        ram_19_cfi_mispredicted = _RANDOM[7'h4C][26];	// fetch-target-queue.scala:143:21
        ram_19_cfi_type = _RANDOM[7'h4C][29:27];	// fetch-target-queue.scala:143:21
        ram_19_br_mask = {_RANDOM[7'h4C][31:30], _RANDOM[7'h4D][1:0]};	// fetch-target-queue.scala:143:21
        ram_19_cfi_is_call = _RANDOM[7'h4D][2];	// fetch-target-queue.scala:143:21
        ram_19_cfi_is_ret = _RANDOM[7'h4D][3];	// fetch-target-queue.scala:143:21
        ram_19_ras_top = {_RANDOM[7'h4D][31:5], _RANDOM[7'h4E][12:0]};	// fetch-target-queue.scala:143:21
        ram_19_ras_idx = _RANDOM[7'h4E][17:13];	// fetch-target-queue.scala:143:21
        ram_19_start_bank = _RANDOM[7'h4E][18];	// fetch-target-queue.scala:143:21
        ram_20_cfi_idx_valid = _RANDOM[7'h4E][19];	// fetch-target-queue.scala:143:21
        ram_20_cfi_idx_bits = _RANDOM[7'h4E][21:20];	// fetch-target-queue.scala:143:21
        ram_20_cfi_taken = _RANDOM[7'h4E][22];	// fetch-target-queue.scala:143:21
        ram_20_cfi_mispredicted = _RANDOM[7'h4E][23];	// fetch-target-queue.scala:143:21
        ram_20_cfi_type = _RANDOM[7'h4E][26:24];	// fetch-target-queue.scala:143:21
        ram_20_br_mask = _RANDOM[7'h4E][30:27];	// fetch-target-queue.scala:143:21
        ram_20_cfi_is_call = _RANDOM[7'h4E][31];	// fetch-target-queue.scala:143:21
        ram_20_cfi_is_ret = _RANDOM[7'h4F][0];	// fetch-target-queue.scala:143:21
        ram_20_ras_top = {_RANDOM[7'h4F][31:2], _RANDOM[7'h50][9:0]};	// fetch-target-queue.scala:143:21
        ram_20_ras_idx = _RANDOM[7'h50][14:10];	// fetch-target-queue.scala:143:21
        ram_20_start_bank = _RANDOM[7'h50][15];	// fetch-target-queue.scala:143:21
        ram_21_cfi_idx_valid = _RANDOM[7'h50][16];	// fetch-target-queue.scala:143:21
        ram_21_cfi_idx_bits = _RANDOM[7'h50][18:17];	// fetch-target-queue.scala:143:21
        ram_21_cfi_taken = _RANDOM[7'h50][19];	// fetch-target-queue.scala:143:21
        ram_21_cfi_mispredicted = _RANDOM[7'h50][20];	// fetch-target-queue.scala:143:21
        ram_21_cfi_type = _RANDOM[7'h50][23:21];	// fetch-target-queue.scala:143:21
        ram_21_br_mask = _RANDOM[7'h50][27:24];	// fetch-target-queue.scala:143:21
        ram_21_cfi_is_call = _RANDOM[7'h50][28];	// fetch-target-queue.scala:143:21
        ram_21_cfi_is_ret = _RANDOM[7'h50][29];	// fetch-target-queue.scala:143:21
        ram_21_ras_top = {_RANDOM[7'h50][31], _RANDOM[7'h51], _RANDOM[7'h52][6:0]};	// fetch-target-queue.scala:143:21
        ram_21_ras_idx = _RANDOM[7'h52][11:7];	// fetch-target-queue.scala:143:21
        ram_21_start_bank = _RANDOM[7'h52][12];	// fetch-target-queue.scala:143:21
        ram_22_cfi_idx_valid = _RANDOM[7'h52][13];	// fetch-target-queue.scala:143:21
        ram_22_cfi_idx_bits = _RANDOM[7'h52][15:14];	// fetch-target-queue.scala:143:21
        ram_22_cfi_taken = _RANDOM[7'h52][16];	// fetch-target-queue.scala:143:21
        ram_22_cfi_mispredicted = _RANDOM[7'h52][17];	// fetch-target-queue.scala:143:21
        ram_22_cfi_type = _RANDOM[7'h52][20:18];	// fetch-target-queue.scala:143:21
        ram_22_br_mask = _RANDOM[7'h52][24:21];	// fetch-target-queue.scala:143:21
        ram_22_cfi_is_call = _RANDOM[7'h52][25];	// fetch-target-queue.scala:143:21
        ram_22_cfi_is_ret = _RANDOM[7'h52][26];	// fetch-target-queue.scala:143:21
        ram_22_ras_top = {_RANDOM[7'h52][31:28], _RANDOM[7'h53], _RANDOM[7'h54][3:0]};	// fetch-target-queue.scala:143:21
        ram_22_ras_idx = _RANDOM[7'h54][8:4];	// fetch-target-queue.scala:143:21
        ram_22_start_bank = _RANDOM[7'h54][9];	// fetch-target-queue.scala:143:21
        ram_23_cfi_idx_valid = _RANDOM[7'h54][10];	// fetch-target-queue.scala:143:21
        ram_23_cfi_idx_bits = _RANDOM[7'h54][12:11];	// fetch-target-queue.scala:143:21
        ram_23_cfi_taken = _RANDOM[7'h54][13];	// fetch-target-queue.scala:143:21
        ram_23_cfi_mispredicted = _RANDOM[7'h54][14];	// fetch-target-queue.scala:143:21
        ram_23_cfi_type = _RANDOM[7'h54][17:15];	// fetch-target-queue.scala:143:21
        ram_23_br_mask = _RANDOM[7'h54][21:18];	// fetch-target-queue.scala:143:21
        ram_23_cfi_is_call = _RANDOM[7'h54][22];	// fetch-target-queue.scala:143:21
        ram_23_cfi_is_ret = _RANDOM[7'h54][23];	// fetch-target-queue.scala:143:21
        ram_23_ras_top = {_RANDOM[7'h54][31:25], _RANDOM[7'h55], _RANDOM[7'h56][0]};	// fetch-target-queue.scala:143:21
        ram_23_ras_idx = _RANDOM[7'h56][5:1];	// fetch-target-queue.scala:143:21
        ram_23_start_bank = _RANDOM[7'h56][6];	// fetch-target-queue.scala:143:21
        ram_24_cfi_idx_valid = _RANDOM[7'h56][7];	// fetch-target-queue.scala:143:21
        ram_24_cfi_idx_bits = _RANDOM[7'h56][9:8];	// fetch-target-queue.scala:143:21
        ram_24_cfi_taken = _RANDOM[7'h56][10];	// fetch-target-queue.scala:143:21
        ram_24_cfi_mispredicted = _RANDOM[7'h56][11];	// fetch-target-queue.scala:143:21
        ram_24_cfi_type = _RANDOM[7'h56][14:12];	// fetch-target-queue.scala:143:21
        ram_24_br_mask = _RANDOM[7'h56][18:15];	// fetch-target-queue.scala:143:21
        ram_24_cfi_is_call = _RANDOM[7'h56][19];	// fetch-target-queue.scala:143:21
        ram_24_cfi_is_ret = _RANDOM[7'h56][20];	// fetch-target-queue.scala:143:21
        ram_24_ras_top = {_RANDOM[7'h56][31:22], _RANDOM[7'h57][29:0]};	// fetch-target-queue.scala:143:21
        ram_24_ras_idx = {_RANDOM[7'h57][31:30], _RANDOM[7'h58][2:0]};	// fetch-target-queue.scala:143:21
        ram_24_start_bank = _RANDOM[7'h58][3];	// fetch-target-queue.scala:143:21
        ram_25_cfi_idx_valid = _RANDOM[7'h58][4];	// fetch-target-queue.scala:143:21
        ram_25_cfi_idx_bits = _RANDOM[7'h58][6:5];	// fetch-target-queue.scala:143:21
        ram_25_cfi_taken = _RANDOM[7'h58][7];	// fetch-target-queue.scala:143:21
        ram_25_cfi_mispredicted = _RANDOM[7'h58][8];	// fetch-target-queue.scala:143:21
        ram_25_cfi_type = _RANDOM[7'h58][11:9];	// fetch-target-queue.scala:143:21
        ram_25_br_mask = _RANDOM[7'h58][15:12];	// fetch-target-queue.scala:143:21
        ram_25_cfi_is_call = _RANDOM[7'h58][16];	// fetch-target-queue.scala:143:21
        ram_25_cfi_is_ret = _RANDOM[7'h58][17];	// fetch-target-queue.scala:143:21
        ram_25_ras_top = {_RANDOM[7'h58][31:19], _RANDOM[7'h59][26:0]};	// fetch-target-queue.scala:143:21
        ram_25_ras_idx = _RANDOM[7'h59][31:27];	// fetch-target-queue.scala:143:21
        ram_25_start_bank = _RANDOM[7'h5A][0];	// fetch-target-queue.scala:143:21
        ram_26_cfi_idx_valid = _RANDOM[7'h5A][1];	// fetch-target-queue.scala:143:21
        ram_26_cfi_idx_bits = _RANDOM[7'h5A][3:2];	// fetch-target-queue.scala:143:21
        ram_26_cfi_taken = _RANDOM[7'h5A][4];	// fetch-target-queue.scala:143:21
        ram_26_cfi_mispredicted = _RANDOM[7'h5A][5];	// fetch-target-queue.scala:143:21
        ram_26_cfi_type = _RANDOM[7'h5A][8:6];	// fetch-target-queue.scala:143:21
        ram_26_br_mask = _RANDOM[7'h5A][12:9];	// fetch-target-queue.scala:143:21
        ram_26_cfi_is_call = _RANDOM[7'h5A][13];	// fetch-target-queue.scala:143:21
        ram_26_cfi_is_ret = _RANDOM[7'h5A][14];	// fetch-target-queue.scala:143:21
        ram_26_ras_top = {_RANDOM[7'h5A][31:16], _RANDOM[7'h5B][23:0]};	// fetch-target-queue.scala:143:21
        ram_26_ras_idx = _RANDOM[7'h5B][28:24];	// fetch-target-queue.scala:143:21
        ram_26_start_bank = _RANDOM[7'h5B][29];	// fetch-target-queue.scala:143:21
        ram_27_cfi_idx_valid = _RANDOM[7'h5B][30];	// fetch-target-queue.scala:143:21
        ram_27_cfi_idx_bits = {_RANDOM[7'h5B][31], _RANDOM[7'h5C][0]};	// fetch-target-queue.scala:143:21
        ram_27_cfi_taken = _RANDOM[7'h5C][1];	// fetch-target-queue.scala:143:21
        ram_27_cfi_mispredicted = _RANDOM[7'h5C][2];	// fetch-target-queue.scala:143:21
        ram_27_cfi_type = _RANDOM[7'h5C][5:3];	// fetch-target-queue.scala:143:21
        ram_27_br_mask = _RANDOM[7'h5C][9:6];	// fetch-target-queue.scala:143:21
        ram_27_cfi_is_call = _RANDOM[7'h5C][10];	// fetch-target-queue.scala:143:21
        ram_27_cfi_is_ret = _RANDOM[7'h5C][11];	// fetch-target-queue.scala:143:21
        ram_27_ras_top = {_RANDOM[7'h5C][31:13], _RANDOM[7'h5D][20:0]};	// fetch-target-queue.scala:143:21
        ram_27_ras_idx = _RANDOM[7'h5D][25:21];	// fetch-target-queue.scala:143:21
        ram_27_start_bank = _RANDOM[7'h5D][26];	// fetch-target-queue.scala:143:21
        ram_28_cfi_idx_valid = _RANDOM[7'h5D][27];	// fetch-target-queue.scala:143:21
        ram_28_cfi_idx_bits = _RANDOM[7'h5D][29:28];	// fetch-target-queue.scala:143:21
        ram_28_cfi_taken = _RANDOM[7'h5D][30];	// fetch-target-queue.scala:143:21
        ram_28_cfi_mispredicted = _RANDOM[7'h5D][31];	// fetch-target-queue.scala:143:21
        ram_28_cfi_type = _RANDOM[7'h5E][2:0];	// fetch-target-queue.scala:143:21
        ram_28_br_mask = _RANDOM[7'h5E][6:3];	// fetch-target-queue.scala:143:21
        ram_28_cfi_is_call = _RANDOM[7'h5E][7];	// fetch-target-queue.scala:143:21
        ram_28_cfi_is_ret = _RANDOM[7'h5E][8];	// fetch-target-queue.scala:143:21
        ram_28_ras_top = {_RANDOM[7'h5E][31:10], _RANDOM[7'h5F][17:0]};	// fetch-target-queue.scala:143:21
        ram_28_ras_idx = _RANDOM[7'h5F][22:18];	// fetch-target-queue.scala:143:21
        ram_28_start_bank = _RANDOM[7'h5F][23];	// fetch-target-queue.scala:143:21
        ram_29_cfi_idx_valid = _RANDOM[7'h5F][24];	// fetch-target-queue.scala:143:21
        ram_29_cfi_idx_bits = _RANDOM[7'h5F][26:25];	// fetch-target-queue.scala:143:21
        ram_29_cfi_taken = _RANDOM[7'h5F][27];	// fetch-target-queue.scala:143:21
        ram_29_cfi_mispredicted = _RANDOM[7'h5F][28];	// fetch-target-queue.scala:143:21
        ram_29_cfi_type = _RANDOM[7'h5F][31:29];	// fetch-target-queue.scala:143:21
        ram_29_br_mask = _RANDOM[7'h60][3:0];	// fetch-target-queue.scala:143:21
        ram_29_cfi_is_call = _RANDOM[7'h60][4];	// fetch-target-queue.scala:143:21
        ram_29_cfi_is_ret = _RANDOM[7'h60][5];	// fetch-target-queue.scala:143:21
        ram_29_ras_top = {_RANDOM[7'h60][31:7], _RANDOM[7'h61][14:0]};	// fetch-target-queue.scala:143:21
        ram_29_ras_idx = _RANDOM[7'h61][19:15];	// fetch-target-queue.scala:143:21
        ram_29_start_bank = _RANDOM[7'h61][20];	// fetch-target-queue.scala:143:21
        ram_30_cfi_idx_valid = _RANDOM[7'h61][21];	// fetch-target-queue.scala:143:21
        ram_30_cfi_idx_bits = _RANDOM[7'h61][23:22];	// fetch-target-queue.scala:143:21
        ram_30_cfi_taken = _RANDOM[7'h61][24];	// fetch-target-queue.scala:143:21
        ram_30_cfi_mispredicted = _RANDOM[7'h61][25];	// fetch-target-queue.scala:143:21
        ram_30_cfi_type = _RANDOM[7'h61][28:26];	// fetch-target-queue.scala:143:21
        ram_30_br_mask = {_RANDOM[7'h61][31:29], _RANDOM[7'h62][0]};	// fetch-target-queue.scala:143:21
        ram_30_cfi_is_call = _RANDOM[7'h62][1];	// fetch-target-queue.scala:143:21
        ram_30_cfi_is_ret = _RANDOM[7'h62][2];	// fetch-target-queue.scala:143:21
        ram_30_ras_top = {_RANDOM[7'h62][31:4], _RANDOM[7'h63][11:0]};	// fetch-target-queue.scala:143:21
        ram_30_ras_idx = _RANDOM[7'h63][16:12];	// fetch-target-queue.scala:143:21
        ram_30_start_bank = _RANDOM[7'h63][17];	// fetch-target-queue.scala:143:21
        ram_31_cfi_idx_valid = _RANDOM[7'h63][18];	// fetch-target-queue.scala:143:21
        ram_31_cfi_idx_bits = _RANDOM[7'h63][20:19];	// fetch-target-queue.scala:143:21
        ram_31_cfi_taken = _RANDOM[7'h63][21];	// fetch-target-queue.scala:143:21
        ram_31_cfi_mispredicted = _RANDOM[7'h63][22];	// fetch-target-queue.scala:143:21
        ram_31_cfi_type = _RANDOM[7'h63][25:23];	// fetch-target-queue.scala:143:21
        ram_31_br_mask = _RANDOM[7'h63][29:26];	// fetch-target-queue.scala:143:21
        ram_31_cfi_is_call = _RANDOM[7'h63][30];	// fetch-target-queue.scala:143:21
        ram_31_cfi_is_ret = _RANDOM[7'h63][31];	// fetch-target-queue.scala:143:21
        ram_31_ras_top = {_RANDOM[7'h64][31:1], _RANDOM[7'h65][8:0]};	// fetch-target-queue.scala:143:21
        ram_31_ras_idx = _RANDOM[7'h65][13:9];	// fetch-target-queue.scala:143:21
        ram_31_start_bank = _RANDOM[7'h65][14];	// fetch-target-queue.scala:143:21
        prev_ghist_old_history =
          {_RANDOM[7'h65][31:15], _RANDOM[7'h66], _RANDOM[7'h67][14:0]};	// fetch-target-queue.scala:143:21, :155:27
        prev_ghist_current_saw_branch_not_taken = _RANDOM[7'h67][15];	// fetch-target-queue.scala:155:27
        prev_ghist_ras_idx = _RANDOM[7'h67][22:18];	// fetch-target-queue.scala:155:27
        prev_entry_cfi_idx_valid = _RANDOM[7'h67][23];	// fetch-target-queue.scala:155:27, :156:27
        prev_entry_cfi_idx_bits = _RANDOM[7'h67][25:24];	// fetch-target-queue.scala:155:27, :156:27
        prev_entry_cfi_taken = _RANDOM[7'h67][26];	// fetch-target-queue.scala:155:27, :156:27
        prev_entry_br_mask = {_RANDOM[7'h67][31], _RANDOM[7'h68][2:0]};	// fetch-target-queue.scala:155:27, :156:27
        prev_entry_cfi_is_call = _RANDOM[7'h68][3];	// fetch-target-queue.scala:156:27
        prev_entry_cfi_is_ret = _RANDOM[7'h68][4];	// fetch-target-queue.scala:156:27
        first_empty = _RANDOM[7'h6A][28];	// fetch-target-queue.scala:214:28
        io_ras_update_REG = _RANDOM[7'h6A][29];	// fetch-target-queue.scala:214:28, :222:31
        io_ras_update_pc_REG =
          {_RANDOM[7'h6A][31:30], _RANDOM[7'h6B], _RANDOM[7'h6C][5:0]};	// fetch-target-queue.scala:214:28, :223:31
        io_ras_update_idx_REG = _RANDOM[7'h6C][10:6];	// fetch-target-queue.scala:223:31, :224:31
        bpd_update_mispredict = _RANDOM[7'h6C][11];	// fetch-target-queue.scala:223:31, :226:38
        bpd_update_repair = _RANDOM[7'h6C][12];	// fetch-target-queue.scala:223:31, :227:34
        bpd_repair_idx = _RANDOM[7'h6C][17:13];	// fetch-target-queue.scala:223:31, :228:27
        bpd_end_idx = _RANDOM[7'h6C][22:18];	// fetch-target-queue.scala:223:31, :229:24
        bpd_repair_pc = {_RANDOM[7'h6C][31:23], _RANDOM[7'h6D][30:0]};	// fetch-target-queue.scala:223:31, :230:26
        bpd_entry_cfi_idx_valid = _RANDOM[7'h6D][31];	// fetch-target-queue.scala:230:26, :234:26
        bpd_entry_cfi_idx_bits = _RANDOM[7'h6E][1:0];	// fetch-target-queue.scala:234:26
        bpd_entry_cfi_taken = _RANDOM[7'h6E][2];	// fetch-target-queue.scala:234:26
        bpd_entry_cfi_mispredicted = _RANDOM[7'h6E][3];	// fetch-target-queue.scala:234:26
        bpd_entry_cfi_type = _RANDOM[7'h6E][6:4];	// fetch-target-queue.scala:234:26
        bpd_entry_br_mask = _RANDOM[7'h6E][10:7];	// fetch-target-queue.scala:234:26
        bpd_pc = {_RANDOM[7'h6F][31:28], _RANDOM[7'h70], _RANDOM[7'h71][3:0]};	// fetch-target-queue.scala:242:26
        bpd_target = {_RANDOM[7'h71][31:4], _RANDOM[7'h72][11:0]};	// fetch-target-queue.scala:242:26, :243:27
        REG = _RANDOM[7'h72][12];	// fetch-target-queue.scala:243:27, :248:23
        bpd_repair_idx_REG = _RANDOM[7'h72][17:13];	// fetch-target-queue.scala:243:27, :250:37
        bpd_end_idx_REG = _RANDOM[7'h72][22:18];	// fetch-target-queue.scala:243:27, :251:37
        REG_1 = _RANDOM[7'h72][23];	// fetch-target-queue.scala:243:27, :256:44
        do_commit_update_REG = _RANDOM[7'h72][24];	// fetch-target-queue.scala:243:27, :274:61
        REG_2 = _RANDOM[7'h72][25];	// fetch-target-queue.scala:243:27, :278:16
        io_bpdupdate_valid_REG = _RANDOM[7'h72][26];	// fetch-target-queue.scala:243:27, :284:37
        io_bpdupdate_bits_is_mispredict_update_REG = _RANDOM[7'h72][27];	// fetch-target-queue.scala:243:27, :285:54
        io_bpdupdate_bits_is_repair_update_REG = _RANDOM[7'h72][28];	// fetch-target-queue.scala:243:27, :286:54
        io_enq_ready_REG = _RANDOM[7'h72][29];	// fetch-target-queue.scala:243:27, :308:26
        REG_3 = _RANDOM[7'h72][30];	// fetch-target-queue.scala:243:27, :332:23
        prev_entry_REG_cfi_idx_valid = _RANDOM[7'h72][31];	// fetch-target-queue.scala:243:27, :333:26
        prev_entry_REG_cfi_idx_bits = _RANDOM[7'h73][1:0];	// fetch-target-queue.scala:333:26
        prev_entry_REG_cfi_taken = _RANDOM[7'h73][2];	// fetch-target-queue.scala:333:26
        prev_entry_REG_br_mask = _RANDOM[7'h73][10:7];	// fetch-target-queue.scala:333:26
        prev_entry_REG_cfi_is_call = _RANDOM[7'h73][11];	// fetch-target-queue.scala:333:26
        prev_entry_REG_cfi_is_ret = _RANDOM[7'h73][12];	// fetch-target-queue.scala:333:26
        REG_4 = {_RANDOM[7'h74][31:28], _RANDOM[7'h75][0]};	// fetch-target-queue.scala:337:16
        ram_REG_cfi_idx_valid = _RANDOM[7'h75][1];	// fetch-target-queue.scala:337:{16,46}
        ram_REG_cfi_idx_bits = _RANDOM[7'h75][3:2];	// fetch-target-queue.scala:337:{16,46}
        ram_REG_cfi_taken = _RANDOM[7'h75][4];	// fetch-target-queue.scala:337:{16,46}
        ram_REG_cfi_mispredicted = _RANDOM[7'h75][5];	// fetch-target-queue.scala:337:{16,46}
        ram_REG_cfi_type = _RANDOM[7'h75][8:6];	// fetch-target-queue.scala:337:{16,46}
        ram_REG_br_mask = _RANDOM[7'h75][12:9];	// fetch-target-queue.scala:337:{16,46}
        ram_REG_cfi_is_call = _RANDOM[7'h75][13];	// fetch-target-queue.scala:337:{16,46}
        ram_REG_cfi_is_ret = _RANDOM[7'h75][14];	// fetch-target-queue.scala:337:{16,46}
        ram_REG_ras_top = {_RANDOM[7'h75][31:16], _RANDOM[7'h76][23:0]};	// fetch-target-queue.scala:337:{16,46}
        ram_REG_ras_idx = _RANDOM[7'h76][28:24];	// fetch-target-queue.scala:337:46
        ram_REG_start_bank = _RANDOM[7'h76][29];	// fetch-target-queue.scala:337:46
        io_get_ftq_pc_0_entry_REG_cfi_idx_valid = _RANDOM[7'h76][30];	// fetch-target-queue.scala:337:46, :351:42
        io_get_ftq_pc_0_entry_REG_cfi_idx_bits = {_RANDOM[7'h76][31], _RANDOM[7'h77][0]};	// fetch-target-queue.scala:337:46, :351:42
        io_get_ftq_pc_0_entry_REG_ras_idx = _RANDOM[7'h78][25:21];	// fetch-target-queue.scala:351:42
        io_get_ftq_pc_0_entry_REG_start_bank = _RANDOM[7'h78][26];	// fetch-target-queue.scala:351:42
        io_get_ftq_pc_0_pc_REG =
          {_RANDOM[7'h78][31:27], _RANDOM[7'h79], _RANDOM[7'h7A][2:0]};	// fetch-target-queue.scala:351:42, :356:42
        io_get_ftq_pc_0_next_pc_REG = {_RANDOM[7'h7A][31:3], _RANDOM[7'h7B][10:0]};	// fetch-target-queue.scala:356:42, :357:42
        io_get_ftq_pc_0_next_val_REG = _RANDOM[7'h7B][11];	// fetch-target-queue.scala:357:42, :358:42
        io_get_ftq_pc_0_com_pc_REG = {_RANDOM[7'h7B][31:12], _RANDOM[7'h7C][19:0]};	// fetch-target-queue.scala:357:42, :359:42
        io_get_ftq_pc_1_entry_REG_cfi_idx_bits = _RANDOM[7'h7C][22:21];	// fetch-target-queue.scala:351:42, :359:42
        io_get_ftq_pc_1_entry_REG_br_mask = _RANDOM[7'h7C][31:28];	// fetch-target-queue.scala:351:42, :359:42
        io_get_ftq_pc_1_entry_REG_cfi_is_call = _RANDOM[7'h7D][0];	// fetch-target-queue.scala:351:42
        io_get_ftq_pc_1_entry_REG_cfi_is_ret = _RANDOM[7'h7D][1];	// fetch-target-queue.scala:351:42
        io_get_ftq_pc_1_entry_REG_start_bank = _RANDOM[7'h7E][16];	// fetch-target-queue.scala:351:42
        io_get_ftq_pc_1_pc_REG = {_RANDOM[7'h7E][31:17], _RANDOM[7'h7F][24:0]};	// fetch-target-queue.scala:351:42, :356:42
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  meta_0_32x120 meta_0_ext (	// fetch-target-queue.scala:142:29
    .R0_addr (_bpd_meta_T_1),	// fetch-target-queue.scala:232:20
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr),	// fetch-target-queue.scala:135:27
    .W0_en   (ghist_1_MPORT_1_en),	// Decoupled.scala:40:37
    .W0_clk  (clock),
    .W0_data (io_enq_bits_bpd_meta_0),
    .R0_data (io_bpdupdate_bits_meta_0)
  );
  ghist_32x72 ghist_0_ext (	// fetch-target-queue.scala:144:43
    .R0_addr (_bpd_meta_T_1),	// fetch-target-queue.scala:232:20
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr),	// fetch-target-queue.scala:135:27
    .W0_en   (ghist_1_MPORT_1_en),	// Decoupled.scala:40:37
    .W0_clk  (clock),
    .W0_data (_GEN),	// fetch-target-queue.scala:144:43
    .R0_data (_ghist_0_ext_R0_data)
  );
  ghist_32x72 ghist_1_ext (	// fetch-target-queue.scala:144:43
    .R0_addr (io_get_ftq_pc_1_ftq_idx),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr),	// fetch-target-queue.scala:135:27
    .W0_en   (ghist_1_MPORT_1_en),	// Decoupled.scala:40:37
    .W0_clk  (clock),
    .W0_data (_GEN),	// fetch-target-queue.scala:144:43
    .R0_data (_ghist_1_ext_R0_data)
  );
  assign io_enq_ready = io_enq_ready_REG;	// fetch-target-queue.scala:308:26
  assign io_enq_idx = enq_ptr;	// fetch-target-queue.scala:135:27
  assign io_get_ftq_pc_0_entry_cfi_idx_valid = io_get_ftq_pc_0_entry_REG_cfi_idx_valid;	// fetch-target-queue.scala:351:42
  assign io_get_ftq_pc_0_entry_cfi_idx_bits = io_get_ftq_pc_0_entry_REG_cfi_idx_bits;	// fetch-target-queue.scala:351:42
  assign io_get_ftq_pc_0_entry_ras_idx = io_get_ftq_pc_0_entry_REG_ras_idx;	// fetch-target-queue.scala:351:42
  assign io_get_ftq_pc_0_entry_start_bank = io_get_ftq_pc_0_entry_REG_start_bank;	// fetch-target-queue.scala:351:42
  assign io_get_ftq_pc_0_pc = io_get_ftq_pc_0_pc_REG;	// fetch-target-queue.scala:356:42
  assign io_get_ftq_pc_0_com_pc = io_get_ftq_pc_0_com_pc_REG;	// fetch-target-queue.scala:359:42
  assign io_get_ftq_pc_0_next_val = io_get_ftq_pc_0_next_val_REG;	// fetch-target-queue.scala:358:42
  assign io_get_ftq_pc_0_next_pc = io_get_ftq_pc_0_next_pc_REG;	// fetch-target-queue.scala:357:42
  assign io_get_ftq_pc_1_entry_cfi_idx_bits = io_get_ftq_pc_1_entry_REG_cfi_idx_bits;	// fetch-target-queue.scala:351:42
  assign io_get_ftq_pc_1_entry_br_mask = io_get_ftq_pc_1_entry_REG_br_mask;	// fetch-target-queue.scala:351:42
  assign io_get_ftq_pc_1_entry_cfi_is_call = io_get_ftq_pc_1_entry_REG_cfi_is_call;	// fetch-target-queue.scala:351:42
  assign io_get_ftq_pc_1_entry_cfi_is_ret = io_get_ftq_pc_1_entry_REG_cfi_is_ret;	// fetch-target-queue.scala:351:42
  assign io_get_ftq_pc_1_entry_start_bank = io_get_ftq_pc_1_entry_REG_start_bank;	// fetch-target-queue.scala:351:42
  assign io_get_ftq_pc_1_ghist_old_history = _ghist_1_ext_R0_data[63:0];	// fetch-target-queue.scala:144:43
  assign io_get_ftq_pc_1_ghist_current_saw_branch_not_taken = _ghist_1_ext_R0_data[64];	// fetch-target-queue.scala:144:43
  assign io_get_ftq_pc_1_ghist_new_saw_branch_not_taken = _ghist_1_ext_R0_data[65];	// fetch-target-queue.scala:144:43
  assign io_get_ftq_pc_1_ghist_new_saw_branch_taken = _ghist_1_ext_R0_data[66];	// fetch-target-queue.scala:144:43
  assign io_get_ftq_pc_1_ghist_ras_idx = _ghist_1_ext_R0_data[71:67];	// fetch-target-queue.scala:144:43
  assign io_get_ftq_pc_1_pc = io_get_ftq_pc_1_pc_REG;	// fetch-target-queue.scala:356:42
  assign io_bpdupdate_valid =
    REG_2 & ~first_empty & (bpd_entry_cfi_idx_valid | (|bpd_entry_br_mask))
    & ~(io_bpdupdate_valid_REG & bpd_pc == bpd_repair_pc);	// fetch-target-queue.scala:206:22, :214:28, :230:26, :234:26, :242:26, :278:{16,80}, :280:31, :282:{24,28}, :283:{53,74}, :284:{28,37,56}
  assign io_bpdupdate_bits_is_mispredict_update =
    io_bpdupdate_bits_is_mispredict_update_REG;	// fetch-target-queue.scala:285:54
  assign io_bpdupdate_bits_is_repair_update = io_bpdupdate_bits_is_repair_update_REG;	// fetch-target-queue.scala:286:54
  assign io_bpdupdate_bits_pc = bpd_pc;	// fetch-target-queue.scala:242:26
  assign io_bpdupdate_bits_br_mask =
    ({4{~bpd_entry_cfi_idx_valid}}
     | {&bpd_entry_cfi_idx_bits,
        _GEN_4[2],
        _GEN_5[1],
        _GEN_5[0] | (&bpd_entry_cfi_idx_bits)}) & bpd_entry_br_mask;	// fetch-target-queue.scala:234:26, :289:37, util.scala:203:14, :373:{29,45}
  assign io_bpdupdate_bits_cfi_idx_valid = bpd_entry_cfi_idx_valid;	// fetch-target-queue.scala:234:26
  assign io_bpdupdate_bits_cfi_idx_bits = bpd_entry_cfi_idx_bits;	// fetch-target-queue.scala:234:26
  assign io_bpdupdate_bits_cfi_taken = bpd_entry_cfi_taken;	// fetch-target-queue.scala:234:26
  assign io_bpdupdate_bits_cfi_mispredicted = bpd_entry_cfi_mispredicted;	// fetch-target-queue.scala:234:26
  assign io_bpdupdate_bits_cfi_is_br = _io_bpdupdate_bits_cfi_is_br_T[0];	// fetch-target-queue.scala:295:54
  assign io_bpdupdate_bits_cfi_is_jal =
    bpd_entry_cfi_type == 3'h2 | bpd_entry_cfi_type == 3'h3;	// fetch-target-queue.scala:234:26, :296:{56,68,90}
  assign io_bpdupdate_bits_ghist_old_history = _ghist_0_ext_R0_data[63:0];	// fetch-target-queue.scala:144:43
  assign io_bpdupdate_bits_target = bpd_target;	// fetch-target-queue.scala:243:27
  assign io_ras_update = io_ras_update_REG;	// fetch-target-queue.scala:222:31
  assign io_ras_update_idx = io_ras_update_idx_REG;	// fetch-target-queue.scala:224:31
  assign io_ras_update_pc = io_ras_update_pc_REG;	// fetch-target-queue.scala:223:31
endmodule

