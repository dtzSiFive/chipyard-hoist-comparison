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

module FetchTargetQueue(
  input          clock,
                 reset,
                 io_enq_valid,
  input  [39:0]  io_enq_bits_pc,
  input          io_enq_bits_cfi_idx_valid,
  input  [2:0]   io_enq_bits_cfi_idx_bits,
                 io_enq_bits_cfi_type,
  input          io_enq_bits_cfi_is_call,
                 io_enq_bits_cfi_is_ret,
  input  [39:0]  io_enq_bits_ras_top,
  input  [7:0]   io_enq_bits_mask,
                 io_enq_bits_br_mask,
  input  [63:0]  io_enq_bits_ghist_old_history,
  input          io_enq_bits_ghist_current_saw_branch_not_taken,
                 io_enq_bits_ghist_new_saw_branch_not_taken,
                 io_enq_bits_ghist_new_saw_branch_taken,
  input  [4:0]   io_enq_bits_ghist_ras_idx,
  input  [119:0] io_enq_bits_bpd_meta_0,
                 io_enq_bits_bpd_meta_1,
  input          io_deq_valid,
  input  [5:0]   io_deq_bits,
                 io_get_ftq_pc_0_ftq_idx,
                 io_get_ftq_pc_1_ftq_idx,
  input          io_redirect_valid,
  input  [5:0]   io_redirect_bits,
                 io_brupdate_b2_uop_ftq_idx,
                 io_brupdate_b2_uop_pc_lob,
  input          io_brupdate_b2_mispredict,
                 io_brupdate_b2_taken,
  output         io_enq_ready,
  output [5:0]   io_enq_idx,
  output         io_get_ftq_pc_0_entry_cfi_idx_valid,
  output [2:0]   io_get_ftq_pc_0_entry_cfi_idx_bits,
  output [4:0]   io_get_ftq_pc_0_entry_ras_idx,
  output         io_get_ftq_pc_0_entry_start_bank,
  output [39:0]  io_get_ftq_pc_0_pc,
                 io_get_ftq_pc_0_com_pc,
  output         io_get_ftq_pc_0_next_val,
  output [39:0]  io_get_ftq_pc_0_next_pc,
  output [2:0]   io_get_ftq_pc_1_entry_cfi_idx_bits,
  output [7:0]   io_get_ftq_pc_1_entry_br_mask,
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
  output [7:0]   io_bpdupdate_bits_br_mask,
  output         io_bpdupdate_bits_cfi_idx_valid,
  output [2:0]   io_bpdupdate_bits_cfi_idx_bits,
  output         io_bpdupdate_bits_cfi_taken,
                 io_bpdupdate_bits_cfi_mispredicted,
                 io_bpdupdate_bits_cfi_is_br,
                 io_bpdupdate_bits_cfi_is_jal,
  output [63:0]  io_bpdupdate_bits_ghist_old_history,
  output         io_bpdupdate_bits_ghist_new_saw_branch_not_taken,
                 io_bpdupdate_bits_ghist_new_saw_branch_taken,
  output [39:0]  io_bpdupdate_bits_target,
  output [119:0] io_bpdupdate_bits_meta_0,
                 io_bpdupdate_bits_meta_1,
  output         io_ras_update,
  output [4:0]   io_ras_update_idx,
  output [39:0]  io_ras_update_pc
);

  reg          io_enq_ready_REG;	// fetch-target-queue.scala:308:26
  wire [4:0]   ghist_1_MPORT_1_data_ras_idx;	// fetch-target-queue.scala:178:24
  wire         ghist_1_MPORT_1_data_new_saw_branch_taken;	// fetch-target-queue.scala:178:24
  wire         ghist_1_MPORT_1_data_new_saw_branch_not_taken;	// fetch-target-queue.scala:178:24
  wire [63:0]  ghist_1_MPORT_1_data_old_history;	// fetch-target-queue.scala:178:24
  wire [71:0]  _ghist_1_ext_R0_data;	// fetch-target-queue.scala:144:43
  wire [71:0]  _ghist_0_ext_R0_data;	// fetch-target-queue.scala:144:43
  wire [239:0] _meta_ext_R0_data;	// fetch-target-queue.scala:142:29
  reg  [5:0]   bpd_ptr;	// fetch-target-queue.scala:133:27
  reg  [5:0]   deq_ptr;	// fetch-target-queue.scala:134:27
  reg  [5:0]   enq_ptr;	// fetch-target-queue.scala:135:27
  reg  [39:0]  pcs_0;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_1;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_2;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_3;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_4;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_5;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_6;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_7;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_8;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_9;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_10;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_11;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_12;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_13;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_14;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_15;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_16;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_17;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_18;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_19;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_20;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_21;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_22;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_23;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_24;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_25;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_26;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_27;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_28;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_29;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_30;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_31;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_32;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_33;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_34;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_35;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_36;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_37;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_38;	// fetch-target-queue.scala:141:21
  reg  [39:0]  pcs_39;	// fetch-target-queue.scala:141:21
  reg          ram_0_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_0_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_0_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_0_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_0_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_0_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_0_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_0_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_0_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_0_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_0_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_1_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_1_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_1_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_1_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_1_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_1_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_1_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_1_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_1_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_1_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_1_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_2_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_2_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_2_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_2_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_2_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_2_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_2_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_2_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_2_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_2_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_2_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_3_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_3_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_3_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_3_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_3_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_3_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_3_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_3_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_3_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_3_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_3_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_4_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_4_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_4_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_4_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_4_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_4_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_4_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_4_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_4_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_4_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_4_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_5_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_5_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_5_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_5_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_5_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_5_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_5_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_5_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_5_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_5_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_5_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_6_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_6_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_6_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_6_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_6_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_6_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_6_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_6_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_6_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_6_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_6_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_7_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_7_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_7_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_7_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_7_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_7_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_7_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_7_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_7_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_7_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_7_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_8_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_8_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_8_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_8_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_8_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_8_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_8_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_8_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_8_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_8_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_8_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_9_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_9_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_9_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_9_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_9_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_9_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_9_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_9_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_9_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_9_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_9_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_10_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_10_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_10_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_10_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_10_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_10_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_10_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_10_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_10_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_10_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_10_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_11_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_11_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_11_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_11_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_11_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_11_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_11_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_11_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_11_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_11_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_11_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_12_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_12_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_12_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_12_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_12_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_12_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_12_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_12_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_12_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_12_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_12_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_13_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_13_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_13_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_13_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_13_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_13_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_13_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_13_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_13_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_13_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_13_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_14_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_14_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_14_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_14_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_14_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_14_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_14_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_14_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_14_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_14_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_14_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_15_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_15_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_15_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_15_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_15_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_15_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_15_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_15_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_15_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_15_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_15_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_16_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_16_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_16_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_16_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_16_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_16_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_16_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_16_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_16_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_16_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_16_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_17_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_17_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_17_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_17_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_17_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_17_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_17_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_17_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_17_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_17_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_17_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_18_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_18_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_18_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_18_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_18_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_18_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_18_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_18_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_18_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_18_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_18_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_19_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_19_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_19_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_19_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_19_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_19_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_19_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_19_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_19_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_19_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_19_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_20_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_20_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_20_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_20_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_20_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_20_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_20_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_20_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_20_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_20_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_20_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_21_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_21_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_21_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_21_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_21_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_21_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_21_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_21_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_21_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_21_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_21_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_22_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_22_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_22_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_22_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_22_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_22_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_22_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_22_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_22_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_22_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_22_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_23_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_23_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_23_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_23_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_23_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_23_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_23_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_23_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_23_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_23_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_23_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_24_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_24_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_24_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_24_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_24_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_24_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_24_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_24_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_24_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_24_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_24_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_25_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_25_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_25_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_25_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_25_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_25_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_25_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_25_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_25_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_25_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_25_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_26_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_26_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_26_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_26_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_26_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_26_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_26_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_26_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_26_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_26_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_26_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_27_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_27_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_27_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_27_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_27_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_27_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_27_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_27_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_27_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_27_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_27_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_28_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_28_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_28_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_28_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_28_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_28_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_28_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_28_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_28_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_28_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_28_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_29_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_29_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_29_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_29_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_29_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_29_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_29_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_29_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_29_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_29_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_29_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_30_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_30_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_30_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_30_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_30_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_30_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_30_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_30_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_30_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_30_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_30_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_31_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_31_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_31_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_31_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_31_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_31_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_31_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_31_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_31_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_31_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_31_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_32_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_32_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_32_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_32_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_32_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_32_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_32_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_32_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_32_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_32_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_32_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_33_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_33_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_33_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_33_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_33_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_33_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_33_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_33_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_33_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_33_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_33_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_34_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_34_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_34_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_34_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_34_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_34_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_34_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_34_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_34_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_34_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_34_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_35_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_35_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_35_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_35_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_35_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_35_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_35_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_35_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_35_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_35_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_35_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_36_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_36_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_36_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_36_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_36_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_36_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_36_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_36_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_36_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_36_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_36_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_37_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_37_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_37_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_37_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_37_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_37_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_37_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_37_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_37_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_37_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_37_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_38_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_38_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_38_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_38_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_38_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_38_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_38_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_38_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_38_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_38_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_38_start_bank;	// fetch-target-queue.scala:143:21
  reg          ram_39_cfi_idx_valid;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_39_cfi_idx_bits;	// fetch-target-queue.scala:143:21
  reg          ram_39_cfi_taken;	// fetch-target-queue.scala:143:21
  reg          ram_39_cfi_mispredicted;	// fetch-target-queue.scala:143:21
  reg  [2:0]   ram_39_cfi_type;	// fetch-target-queue.scala:143:21
  reg  [7:0]   ram_39_br_mask;	// fetch-target-queue.scala:143:21
  reg          ram_39_cfi_is_call;	// fetch-target-queue.scala:143:21
  reg          ram_39_cfi_is_ret;	// fetch-target-queue.scala:143:21
  reg  [39:0]  ram_39_ras_top;	// fetch-target-queue.scala:143:21
  reg  [4:0]   ram_39_ras_idx;	// fetch-target-queue.scala:143:21
  reg          ram_39_start_bank;	// fetch-target-queue.scala:143:21
  wire [71:0]  _GEN =
    {ghist_1_MPORT_1_data_ras_idx,
     ghist_1_MPORT_1_data_new_saw_branch_taken,
     ghist_1_MPORT_1_data_new_saw_branch_not_taken,
     io_enq_bits_ghist_current_saw_branch_not_taken,
     ghist_1_MPORT_1_data_old_history};	// fetch-target-queue.scala:144:43, :178:24
  wire         ghist_1_MPORT_1_en = io_enq_ready_REG & io_enq_valid;	// Decoupled.scala:40:37, fetch-target-queue.scala:308:26
  reg  [63:0]  prev_ghist_old_history;	// fetch-target-queue.scala:155:27
  reg          prev_ghist_current_saw_branch_not_taken;	// fetch-target-queue.scala:155:27
  reg          prev_ghist_new_saw_branch_not_taken;	// fetch-target-queue.scala:155:27
  reg          prev_ghist_new_saw_branch_taken;	// fetch-target-queue.scala:155:27
  reg  [4:0]   prev_ghist_ras_idx;	// fetch-target-queue.scala:155:27
  reg          prev_entry_cfi_idx_valid;	// fetch-target-queue.scala:156:27
  reg  [2:0]   prev_entry_cfi_idx_bits;	// fetch-target-queue.scala:156:27
  reg          prev_entry_cfi_taken;	// fetch-target-queue.scala:156:27
  reg  [7:0]   prev_entry_br_mask;	// fetch-target-queue.scala:156:27
  reg          prev_entry_cfi_is_call;	// fetch-target-queue.scala:156:27
  reg          prev_entry_cfi_is_ret;	// fetch-target-queue.scala:156:27
  reg  [39:0]  prev_pc;	// fetch-target-queue.scala:157:27
  wire [7:0]   _GEN_0 = {5'h0, prev_entry_cfi_idx_bits};	// fetch-target-queue.scala:155:42, :156:27, :183:27
  wire [7:0]   _new_ghist_T = prev_entry_br_mask >> _GEN_0;	// fetch-target-queue.scala:156:27, :183:27
  wire [7:0]   new_ghist_cfi_idx_oh = 8'h1 << _GEN_0;	// OneHot.scala:58:35, fetch-target-queue.scala:183:27
  wire [6:0]   _GEN_1 = new_ghist_cfi_idx_oh[6:0] | new_ghist_cfi_idx_oh[7:1];	// OneHot.scala:58:35, util.scala:206:28, :373:{29,45}
  wire [5:0]   _GEN_2 = _GEN_1[5:0] | new_ghist_cfi_idx_oh[7:2];	// OneHot.scala:58:35, util.scala:206:28, :373:{29,45}
  wire [4:0]   _GEN_3 = _GEN_2[4:0] | new_ghist_cfi_idx_oh[7:3];	// OneHot.scala:58:35, util.scala:373:{29,45}
  wire [3:0]   _GEN_4 = _GEN_3[3:0] | new_ghist_cfi_idx_oh[7:4];	// OneHot.scala:58:35, util.scala:373:{29,45}
  wire [2:0]   _GEN_5 = _GEN_4[2:0] | new_ghist_cfi_idx_oh[7:5];	// OneHot.scala:58:35, util.scala:373:{29,45}
  wire [1:0]   _GEN_6 = _GEN_5[1:0] | new_ghist_cfi_idx_oh[7:6];	// OneHot.scala:58:35, util.scala:373:{29,45}
  wire [7:0]   _new_ghist_not_taken_branches_T_20 =
    prev_entry_cfi_idx_valid
      ? {&prev_entry_cfi_idx_bits,
         _GEN_1[6],
         _GEN_2[5],
         _GEN_3[4],
         _GEN_4[3],
         _GEN_5[2],
         _GEN_6[1],
         _GEN_6[0] | (&prev_entry_cfi_idx_bits)}
        & ~(_new_ghist_T[0] & prev_entry_cfi_taken ? new_ghist_cfi_idx_oh : 8'h0)
      : 8'hFF;	// OneHot.scala:58:35, fetch-target-queue.scala:156:27, :183:27, frontend.scala:90:44, :91:{67,69,73,84}, :92:45, util.scala:206:28, :373:{29,45}
  wire         _new_ghist_new_history_new_saw_branch_taken_T_1 =
    prev_entry_cfi_idx_valid & prev_entry_cfi_taken;	// fetch-target-queue.scala:156:27, frontend.scala:105:37
  wire         new_ghist_cfi_in_bank_0 =
    _new_ghist_new_history_new_saw_branch_taken_T_1 & ~(prev_entry_cfi_idx_bits[2]);	// fetch-target-queue.scala:156:27, frontend.scala:105:{37,50,67}
  wire         new_ghist_ignore_second_bank = new_ghist_cfi_in_bank_0 | (&(prev_pc[5:3]));	// fetch-target-queue.scala:157:27, frontend.scala:105:50, :106:46, :153:{28,66}
  wire         new_ghist_first_bank_saw_not_taken =
    (|(prev_entry_br_mask[3:0] & _new_ghist_not_taken_branches_T_20[3:0]))
    | prev_ghist_current_saw_branch_not_taken;	// fetch-target-queue.scala:155:27, :156:27, frontend.scala:90:{39,44}, :108:{56,72,80}
  wire [63:0]  _GEN_7 = {prev_ghist_old_history[62:0], 1'h0};	// fetch-target-queue.scala:155:27, frontend.scala:68:75, util.scala:206:10
  wire [63:0]  _GEN_8 = {prev_ghist_old_history[62:0], 1'h1};	// fetch-target-queue.scala:155:27, frontend.scala:68:{75,80}
  wire [63:0]  _new_ghist_new_history_old_history_T_4 =
    prev_ghist_new_saw_branch_taken
      ? _GEN_8
      : prev_ghist_new_saw_branch_not_taken ? _GEN_7 : prev_ghist_old_history;	// fetch-target-queue.scala:155:27, frontend.scala:68:{12,75,80}, :69:12
  wire         _new_ghist_new_history_new_saw_branch_taken_T =
    _new_ghist_T[0] & new_ghist_cfi_in_bank_0;	// fetch-target-queue.scala:183:27, frontend.scala:105:50, :113:59
  wire [62:0]  _GEN_9 = {prev_ghist_old_history[61:0], 1'h0};	// fetch-target-queue.scala:155:27, frontend.scala:68:75, util.scala:206:10
  wire [62:0]  _GEN_10 = {prev_ghist_old_history[61:0], 1'h1};	// fetch-target-queue.scala:155:27, frontend.scala:68:{75,80}
  wire [63:0]  _new_ghist_new_history_old_history_T_25 =
    _new_ghist_T[0] & new_ghist_cfi_in_bank_0
      ? {prev_ghist_new_saw_branch_taken
           ? _GEN_10
           : prev_ghist_new_saw_branch_not_taken ? _GEN_9 : prev_ghist_old_history[62:0],
         1'h1}
      : new_ghist_first_bank_saw_not_taken
          ? {prev_ghist_new_saw_branch_taken
               ? _GEN_10
               : prev_ghist_new_saw_branch_not_taken
                   ? _GEN_9
                   : prev_ghist_old_history[62:0],
             1'h0}
          : prev_ghist_new_saw_branch_taken
              ? _GEN_8
              : prev_ghist_new_saw_branch_not_taken ? _GEN_7 : prev_ghist_old_history;	// fetch-target-queue.scala:155:27, :183:27, frontend.scala:68:{12,75,80}, :69:12, :105:50, :108:80, :115:{39,50,115}, :116:{39,110}, util.scala:206:10
  wire [3:0]   _new_ghist_new_history_new_saw_branch_not_taken_T =
    prev_entry_br_mask[7:4] & _new_ghist_not_taken_branches_T_20[7:4];	// fetch-target-queue.scala:156:27, frontend.scala:90:{39,44}, :119:67
  wire         _new_ghist_new_history_new_saw_branch_taken_T_4 =
    _new_ghist_new_history_new_saw_branch_taken_T_1 & _new_ghist_T[0]
    & ~new_ghist_cfi_in_bank_0;	// fetch-target-queue.scala:183:27, frontend.scala:105:{37,50}, :120:{85,88}
  wire         _new_ghist_new_history_ras_idx_T =
    prev_entry_cfi_idx_valid & prev_entry_cfi_is_call;	// fetch-target-queue.scala:156:27, frontend.scala:124:42
  wire [4:0]   _new_ghist_new_history_ras_idx_T_1 = prev_ghist_ras_idx + 5'h1;	// fetch-target-queue.scala:135:27, :155:27, util.scala:203:14
  wire         _new_ghist_new_history_ras_idx_T_4 =
    prev_entry_cfi_idx_valid & prev_entry_cfi_is_ret;	// fetch-target-queue.scala:156:27, frontend.scala:125:42
  wire [4:0]   _new_ghist_new_history_ras_idx_T_5 = prev_ghist_ras_idx - 5'h1;	// fetch-target-queue.scala:155:27, util.scala:220:14
  assign ghist_1_MPORT_1_data_old_history =
    io_enq_bits_ghist_current_saw_branch_not_taken
      ? io_enq_bits_ghist_old_history
      : new_ghist_ignore_second_bank
          ? _new_ghist_new_history_old_history_T_4
          : _new_ghist_new_history_old_history_T_25;	// fetch-target-queue.scala:178:24, frontend.scala:68:12, :106:46, :110:33, :111:33, :115:{33,39}
  assign ghist_1_MPORT_1_data_new_saw_branch_not_taken =
    io_enq_bits_ghist_current_saw_branch_not_taken
      ? io_enq_bits_ghist_new_saw_branch_not_taken
      : new_ghist_ignore_second_bank
          ? new_ghist_first_bank_saw_not_taken
          : (|_new_ghist_new_history_new_saw_branch_not_taken_T);	// fetch-target-queue.scala:178:24, frontend.scala:90:39, :106:46, :108:80, :110:33, :112:46, :119:{46,67,92}
  assign ghist_1_MPORT_1_data_new_saw_branch_taken =
    io_enq_bits_ghist_current_saw_branch_not_taken
      ? io_enq_bits_ghist_new_saw_branch_taken
      : new_ghist_ignore_second_bank
          ? _new_ghist_new_history_new_saw_branch_taken_T
          : _new_ghist_new_history_new_saw_branch_taken_T_4;	// fetch-target-queue.scala:178:24, frontend.scala:106:46, :110:33, :113:{46,59}, :120:{46,85}
  assign ghist_1_MPORT_1_data_ras_idx =
    io_enq_bits_ghist_current_saw_branch_not_taken
      ? io_enq_bits_ghist_ras_idx
      : _new_ghist_new_history_ras_idx_T
          ? _new_ghist_new_history_ras_idx_T_1
          : _new_ghist_new_history_ras_idx_T_4
              ? _new_ghist_new_history_ras_idx_T_5
              : prev_ghist_ras_idx;	// fetch-target-queue.scala:155:27, :178:24, frontend.scala:124:{31,42}, :125:{31,42}, util.scala:203:14, :220:14
  reg          first_empty;	// fetch-target-queue.scala:214:28
  reg          io_ras_update_REG;	// fetch-target-queue.scala:222:31
  reg  [39:0]  io_ras_update_pc_REG;	// fetch-target-queue.scala:223:31
  reg  [4:0]   io_ras_update_idx_REG;	// fetch-target-queue.scala:224:31
  reg          bpd_update_mispredict;	// fetch-target-queue.scala:226:38
  reg          bpd_update_repair;	// fetch-target-queue.scala:227:34
  reg  [5:0]   bpd_repair_idx;	// fetch-target-queue.scala:228:27
  reg  [5:0]   bpd_end_idx;	// fetch-target-queue.scala:229:24
  reg  [39:0]  bpd_repair_pc;	// fetch-target-queue.scala:230:26
  wire [5:0]   _bpd_meta_T_1 =
    io_redirect_valid
      ? io_redirect_bits
      : bpd_update_repair | bpd_update_mispredict ? bpd_repair_idx : bpd_ptr;	// fetch-target-queue.scala:133:27, :226:38, :227:34, :228:27, :232:20, :233:{8,27}
  reg          bpd_entry_cfi_idx_valid;	// fetch-target-queue.scala:234:26
  reg  [2:0]   bpd_entry_cfi_idx_bits;	// fetch-target-queue.scala:234:26
  reg          bpd_entry_cfi_taken;	// fetch-target-queue.scala:234:26
  reg          bpd_entry_cfi_mispredicted;	// fetch-target-queue.scala:234:26
  reg  [2:0]   bpd_entry_cfi_type;	// fetch-target-queue.scala:234:26
  reg  [7:0]   bpd_entry_br_mask;	// fetch-target-queue.scala:234:26
  reg  [39:0]  bpd_pc;	// fetch-target-queue.scala:242:26
  reg  [39:0]  bpd_target;	// fetch-target-queue.scala:243:27
  reg          REG;	// fetch-target-queue.scala:248:23
  reg  [5:0]   bpd_repair_idx_REG;	// fetch-target-queue.scala:250:37
  reg  [5:0]   bpd_end_idx_REG;	// fetch-target-queue.scala:251:37
  reg          REG_1;	// fetch-target-queue.scala:256:44
  reg          do_commit_update_REG;	// fetch-target-queue.scala:274:61
  reg          REG_2;	// fetch-target-queue.scala:278:16
  reg          io_bpdupdate_valid_REG;	// fetch-target-queue.scala:284:37
  reg          io_bpdupdate_bits_is_mispredict_update_REG;	// fetch-target-queue.scala:285:54
  reg          io_bpdupdate_bits_is_repair_update_REG;	// fetch-target-queue.scala:286:54
  wire [7:0]   _GEN_11 = {5'h0, bpd_entry_cfi_idx_bits};	// OneHot.scala:58:35, fetch-target-queue.scala:155:42, :234:26
  wire [7:0]   _io_bpdupdate_bits_br_mask_T_1 = 8'h1 << _GEN_11;	// OneHot.scala:58:35
  wire [6:0]   _GEN_12 =
    _io_bpdupdate_bits_br_mask_T_1[6:0] | _io_bpdupdate_bits_br_mask_T_1[7:1];	// OneHot.scala:58:35, util.scala:206:28, :373:{29,45}
  wire [5:0]   _GEN_13 = _GEN_12[5:0] | _io_bpdupdate_bits_br_mask_T_1[7:2];	// OneHot.scala:58:35, util.scala:206:28, :373:{29,45}
  wire [4:0]   _GEN_14 = _GEN_13[4:0] | _io_bpdupdate_bits_br_mask_T_1[7:3];	// OneHot.scala:58:35, util.scala:373:{29,45}
  wire [3:0]   _GEN_15 = _GEN_14[3:0] | _io_bpdupdate_bits_br_mask_T_1[7:4];	// OneHot.scala:58:35, util.scala:373:{29,45}
  wire [2:0]   _GEN_16 = _GEN_15[2:0] | _io_bpdupdate_bits_br_mask_T_1[7:5];	// OneHot.scala:58:35, util.scala:373:{29,45}
  wire [1:0]   _GEN_17 = _GEN_16[1:0] | _io_bpdupdate_bits_br_mask_T_1[7:6];	// OneHot.scala:58:35, util.scala:373:{29,45}
  wire [7:0]   _io_bpdupdate_bits_cfi_is_br_T = bpd_entry_br_mask >> _GEN_11;	// OneHot.scala:58:35, fetch-target-queue.scala:234:26, :295:54
  reg          REG_3;	// fetch-target-queue.scala:332:23
  reg          prev_entry_REG_cfi_idx_valid;	// fetch-target-queue.scala:333:26
  reg  [2:0]   prev_entry_REG_cfi_idx_bits;	// fetch-target-queue.scala:333:26
  reg          prev_entry_REG_cfi_taken;	// fetch-target-queue.scala:333:26
  reg  [7:0]   prev_entry_REG_br_mask;	// fetch-target-queue.scala:333:26
  reg          prev_entry_REG_cfi_is_call;	// fetch-target-queue.scala:333:26
  reg          prev_entry_REG_cfi_is_ret;	// fetch-target-queue.scala:333:26
  reg  [5:0]   REG_4;	// fetch-target-queue.scala:337:16
  reg          ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:337:46
  reg  [2:0]   ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:337:46
  reg          ram_REG_cfi_taken;	// fetch-target-queue.scala:337:46
  reg          ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:337:46
  reg  [2:0]   ram_REG_cfi_type;	// fetch-target-queue.scala:337:46
  reg  [7:0]   ram_REG_br_mask;	// fetch-target-queue.scala:337:46
  reg          ram_REG_cfi_is_call;	// fetch-target-queue.scala:337:46
  reg          ram_REG_cfi_is_ret;	// fetch-target-queue.scala:337:46
  reg  [39:0]  ram_REG_ras_top;	// fetch-target-queue.scala:337:46
  reg  [4:0]   ram_REG_ras_idx;	// fetch-target-queue.scala:337:46
  reg          ram_REG_start_bank;	// fetch-target-queue.scala:337:46
  reg          io_get_ftq_pc_0_entry_REG_cfi_idx_valid;	// fetch-target-queue.scala:351:42
  reg  [2:0]   io_get_ftq_pc_0_entry_REG_cfi_idx_bits;	// fetch-target-queue.scala:351:42
  reg  [4:0]   io_get_ftq_pc_0_entry_REG_ras_idx;	// fetch-target-queue.scala:351:42
  reg          io_get_ftq_pc_0_entry_REG_start_bank;	// fetch-target-queue.scala:351:42
  reg  [39:0]  io_get_ftq_pc_0_pc_REG;	// fetch-target-queue.scala:356:42
  reg  [39:0]  io_get_ftq_pc_0_next_pc_REG;	// fetch-target-queue.scala:357:42
  reg          io_get_ftq_pc_0_next_val_REG;	// fetch-target-queue.scala:358:42
  reg  [39:0]  io_get_ftq_pc_0_com_pc_REG;	// fetch-target-queue.scala:359:42
  reg  [2:0]   io_get_ftq_pc_1_entry_REG_cfi_idx_bits;	// fetch-target-queue.scala:351:42
  reg  [7:0]   io_get_ftq_pc_1_entry_REG_br_mask;	// fetch-target-queue.scala:351:42
  reg          io_get_ftq_pc_1_entry_REG_cfi_is_call;	// fetch-target-queue.scala:351:42
  reg          io_get_ftq_pc_1_entry_REG_cfi_is_ret;	// fetch-target-queue.scala:351:42
  reg          io_get_ftq_pc_1_entry_REG_start_bank;	// fetch-target-queue.scala:351:42
  reg  [39:0]  io_get_ftq_pc_1_pc_REG;	// fetch-target-queue.scala:356:42
  always @(posedge clock) begin
    automatic logic              full_wrap;	// util.scala:205:25
    automatic logic [5:0]        _enq_ptr_T;	// util.scala:206:28
    automatic logic [5:0]        _full_T_2;	// util.scala:206:10
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
    automatic logic              _GEN_38;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_39;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_40;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_41;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_42;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_43;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_44;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_45;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_46;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_47;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_48;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_49;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_50;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_51;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_52;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_53;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_54;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_55;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_56;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic              _GEN_57;	// fetch-target-queue.scala:141:21, :158:17, :160:28
    automatic logic [7:0]        new_entry_br_mask;	// fetch-target-queue.scala:175:52
    automatic logic [63:0]       _GEN_58;	// fetch-target-queue.scala:234:26
    automatic logic [63:0][2:0]  _GEN_59;	// fetch-target-queue.scala:234:26
    automatic logic [63:0]       _GEN_60;	// fetch-target-queue.scala:234:26
    automatic logic [63:0]       _GEN_61;	// fetch-target-queue.scala:234:26
    automatic logic [63:0][2:0]  _GEN_62;	// fetch-target-queue.scala:234:26
    automatic logic [63:0][7:0]  _GEN_63;	// fetch-target-queue.scala:234:26
    automatic logic [63:0][39:0] _GEN_64;	// fetch-target-queue.scala:242:26
    automatic logic              _GEN_65;	// fetch-target-queue.scala:256:34
    automatic logic              wrap;	// util.scala:205:25
    automatic logic [5:0]        _bpd_repair_idx_T_6;	// util.scala:206:28
    automatic logic              bpd_ptr_wrap;	// util.scala:205:25
    automatic logic [5:0]        _bpd_ptr_T;	// util.scala:206:28
    automatic logic              do_commit_update;	// fetch-target-queue.scala:274:50
    automatic logic [63:0]       _GEN_66;
    automatic logic [63:0]       _GEN_67;
    automatic logic [63:0][39:0] _GEN_68;
    automatic logic [63:0][4:0]  _GEN_69;
    automatic logic [63:0]       _GEN_70;
    automatic logic [2:0]        new_cfi_idx;	// fetch-target-queue.scala:318:50
    automatic logic              _GEN_71 = io_redirect_valid & io_brupdate_b2_mispredict;	// fetch-target-queue.scala:314:28, :317:38, :320:43
    automatic logic              redirect_new_entry_cfi_idx_valid;	// fetch-target-queue.scala:314:28, :317:38, :320:43
    automatic logic              _GEN_72;	// fetch-target-queue.scala:314:28, :317:38, :324:43
    automatic logic              redirect_new_entry_cfi_is_call;	// fetch-target-queue.scala:314:28, :317:38, :324:43
    automatic logic              redirect_new_entry_cfi_is_ret;	// fetch-target-queue.scala:314:28, :317:38, :325:43
    automatic logic [5:0]        next_idx;	// util.scala:206:10
    automatic logic              next_is_enq;	// fetch-target-queue.scala:347:46
    full_wrap = enq_ptr == 6'h27;	// fetch-target-queue.scala:135:27, util.scala:205:25
    _enq_ptr_T = enq_ptr + 6'h1;	// fetch-target-queue.scala:135:27, util.scala:206:28
    _full_T_2 = full_wrap ? 6'h0 : _enq_ptr_T;	// fetch-target-queue.scala:133:27, util.scala:205:25, :206:{10,28}
    _GEN_18 = ghist_1_MPORT_1_en & enq_ptr == 6'h0;	// Decoupled.scala:40:37, fetch-target-queue.scala:133:27, :135:27, :141:21, :158:17, :160:28
    _GEN_19 = ghist_1_MPORT_1_en & enq_ptr == 6'h1;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_20 = ghist_1_MPORT_1_en & enq_ptr == 6'h2;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_21 = ghist_1_MPORT_1_en & enq_ptr == 6'h3;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_22 = ghist_1_MPORT_1_en & enq_ptr == 6'h4;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_23 = ghist_1_MPORT_1_en & enq_ptr == 6'h5;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_24 = ghist_1_MPORT_1_en & enq_ptr == 6'h6;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_25 = ghist_1_MPORT_1_en & enq_ptr == 6'h7;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_26 = ghist_1_MPORT_1_en & enq_ptr == 6'h8;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_27 = ghist_1_MPORT_1_en & enq_ptr == 6'h9;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_28 = ghist_1_MPORT_1_en & enq_ptr == 6'hA;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_29 = ghist_1_MPORT_1_en & enq_ptr == 6'hB;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_30 = ghist_1_MPORT_1_en & enq_ptr == 6'hC;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_31 = ghist_1_MPORT_1_en & enq_ptr == 6'hD;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_32 = ghist_1_MPORT_1_en & enq_ptr == 6'hE;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_33 = ghist_1_MPORT_1_en & enq_ptr == 6'hF;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_34 = ghist_1_MPORT_1_en & enq_ptr == 6'h10;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_35 = ghist_1_MPORT_1_en & enq_ptr == 6'h11;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_36 = ghist_1_MPORT_1_en & enq_ptr == 6'h12;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_37 = ghist_1_MPORT_1_en & enq_ptr == 6'h13;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_38 = ghist_1_MPORT_1_en & enq_ptr == 6'h14;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_39 = ghist_1_MPORT_1_en & enq_ptr == 6'h15;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_40 = ghist_1_MPORT_1_en & enq_ptr == 6'h16;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_41 = ghist_1_MPORT_1_en & enq_ptr == 6'h17;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_42 = ghist_1_MPORT_1_en & enq_ptr == 6'h18;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_43 = ghist_1_MPORT_1_en & enq_ptr == 6'h19;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_44 = ghist_1_MPORT_1_en & enq_ptr == 6'h1A;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_45 = ghist_1_MPORT_1_en & enq_ptr == 6'h1B;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_46 = ghist_1_MPORT_1_en & enq_ptr == 6'h1C;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_47 = ghist_1_MPORT_1_en & enq_ptr == 6'h1D;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_48 = ghist_1_MPORT_1_en & enq_ptr == 6'h1E;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_49 = ghist_1_MPORT_1_en & enq_ptr == 6'h1F;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_50 = ghist_1_MPORT_1_en & enq_ptr == 6'h20;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_51 = ghist_1_MPORT_1_en & enq_ptr == 6'h21;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_52 = ghist_1_MPORT_1_en & enq_ptr == 6'h22;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_53 = ghist_1_MPORT_1_en & enq_ptr == 6'h23;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_54 = ghist_1_MPORT_1_en & enq_ptr == 6'h24;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_55 = ghist_1_MPORT_1_en & enq_ptr == 6'h25;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_56 = ghist_1_MPORT_1_en & enq_ptr == 6'h26;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28
    _GEN_57 = ghist_1_MPORT_1_en & enq_ptr == 6'h27;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :141:21, :158:17, :160:28, util.scala:205:25
    new_entry_br_mask = io_enq_bits_br_mask & io_enq_bits_mask;	// fetch-target-queue.scala:175:52
    _GEN_58 =
      {{ram_0_cfi_idx_valid},
       {ram_0_cfi_idx_valid},
       {ram_0_cfi_idx_valid},
       {ram_0_cfi_idx_valid},
       {ram_0_cfi_idx_valid},
       {ram_0_cfi_idx_valid},
       {ram_0_cfi_idx_valid},
       {ram_0_cfi_idx_valid},
       {ram_0_cfi_idx_valid},
       {ram_0_cfi_idx_valid},
       {ram_0_cfi_idx_valid},
       {ram_0_cfi_idx_valid},
       {ram_0_cfi_idx_valid},
       {ram_0_cfi_idx_valid},
       {ram_0_cfi_idx_valid},
       {ram_0_cfi_idx_valid},
       {ram_0_cfi_idx_valid},
       {ram_0_cfi_idx_valid},
       {ram_0_cfi_idx_valid},
       {ram_0_cfi_idx_valid},
       {ram_0_cfi_idx_valid},
       {ram_0_cfi_idx_valid},
       {ram_0_cfi_idx_valid},
       {ram_0_cfi_idx_valid},
       {ram_39_cfi_idx_valid},
       {ram_38_cfi_idx_valid},
       {ram_37_cfi_idx_valid},
       {ram_36_cfi_idx_valid},
       {ram_35_cfi_idx_valid},
       {ram_34_cfi_idx_valid},
       {ram_33_cfi_idx_valid},
       {ram_32_cfi_idx_valid},
       {ram_31_cfi_idx_valid},
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
    _GEN_59 =
      {{ram_0_cfi_idx_bits},
       {ram_0_cfi_idx_bits},
       {ram_0_cfi_idx_bits},
       {ram_0_cfi_idx_bits},
       {ram_0_cfi_idx_bits},
       {ram_0_cfi_idx_bits},
       {ram_0_cfi_idx_bits},
       {ram_0_cfi_idx_bits},
       {ram_0_cfi_idx_bits},
       {ram_0_cfi_idx_bits},
       {ram_0_cfi_idx_bits},
       {ram_0_cfi_idx_bits},
       {ram_0_cfi_idx_bits},
       {ram_0_cfi_idx_bits},
       {ram_0_cfi_idx_bits},
       {ram_0_cfi_idx_bits},
       {ram_0_cfi_idx_bits},
       {ram_0_cfi_idx_bits},
       {ram_0_cfi_idx_bits},
       {ram_0_cfi_idx_bits},
       {ram_0_cfi_idx_bits},
       {ram_0_cfi_idx_bits},
       {ram_0_cfi_idx_bits},
       {ram_0_cfi_idx_bits},
       {ram_39_cfi_idx_bits},
       {ram_38_cfi_idx_bits},
       {ram_37_cfi_idx_bits},
       {ram_36_cfi_idx_bits},
       {ram_35_cfi_idx_bits},
       {ram_34_cfi_idx_bits},
       {ram_33_cfi_idx_bits},
       {ram_32_cfi_idx_bits},
       {ram_31_cfi_idx_bits},
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
    _GEN_60 =
      {{ram_0_cfi_taken},
       {ram_0_cfi_taken},
       {ram_0_cfi_taken},
       {ram_0_cfi_taken},
       {ram_0_cfi_taken},
       {ram_0_cfi_taken},
       {ram_0_cfi_taken},
       {ram_0_cfi_taken},
       {ram_0_cfi_taken},
       {ram_0_cfi_taken},
       {ram_0_cfi_taken},
       {ram_0_cfi_taken},
       {ram_0_cfi_taken},
       {ram_0_cfi_taken},
       {ram_0_cfi_taken},
       {ram_0_cfi_taken},
       {ram_0_cfi_taken},
       {ram_0_cfi_taken},
       {ram_0_cfi_taken},
       {ram_0_cfi_taken},
       {ram_0_cfi_taken},
       {ram_0_cfi_taken},
       {ram_0_cfi_taken},
       {ram_0_cfi_taken},
       {ram_39_cfi_taken},
       {ram_38_cfi_taken},
       {ram_37_cfi_taken},
       {ram_36_cfi_taken},
       {ram_35_cfi_taken},
       {ram_34_cfi_taken},
       {ram_33_cfi_taken},
       {ram_32_cfi_taken},
       {ram_31_cfi_taken},
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
    _GEN_61 =
      {{ram_0_cfi_mispredicted},
       {ram_0_cfi_mispredicted},
       {ram_0_cfi_mispredicted},
       {ram_0_cfi_mispredicted},
       {ram_0_cfi_mispredicted},
       {ram_0_cfi_mispredicted},
       {ram_0_cfi_mispredicted},
       {ram_0_cfi_mispredicted},
       {ram_0_cfi_mispredicted},
       {ram_0_cfi_mispredicted},
       {ram_0_cfi_mispredicted},
       {ram_0_cfi_mispredicted},
       {ram_0_cfi_mispredicted},
       {ram_0_cfi_mispredicted},
       {ram_0_cfi_mispredicted},
       {ram_0_cfi_mispredicted},
       {ram_0_cfi_mispredicted},
       {ram_0_cfi_mispredicted},
       {ram_0_cfi_mispredicted},
       {ram_0_cfi_mispredicted},
       {ram_0_cfi_mispredicted},
       {ram_0_cfi_mispredicted},
       {ram_0_cfi_mispredicted},
       {ram_0_cfi_mispredicted},
       {ram_39_cfi_mispredicted},
       {ram_38_cfi_mispredicted},
       {ram_37_cfi_mispredicted},
       {ram_36_cfi_mispredicted},
       {ram_35_cfi_mispredicted},
       {ram_34_cfi_mispredicted},
       {ram_33_cfi_mispredicted},
       {ram_32_cfi_mispredicted},
       {ram_31_cfi_mispredicted},
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
    _GEN_62 =
      {{ram_0_cfi_type},
       {ram_0_cfi_type},
       {ram_0_cfi_type},
       {ram_0_cfi_type},
       {ram_0_cfi_type},
       {ram_0_cfi_type},
       {ram_0_cfi_type},
       {ram_0_cfi_type},
       {ram_0_cfi_type},
       {ram_0_cfi_type},
       {ram_0_cfi_type},
       {ram_0_cfi_type},
       {ram_0_cfi_type},
       {ram_0_cfi_type},
       {ram_0_cfi_type},
       {ram_0_cfi_type},
       {ram_0_cfi_type},
       {ram_0_cfi_type},
       {ram_0_cfi_type},
       {ram_0_cfi_type},
       {ram_0_cfi_type},
       {ram_0_cfi_type},
       {ram_0_cfi_type},
       {ram_0_cfi_type},
       {ram_39_cfi_type},
       {ram_38_cfi_type},
       {ram_37_cfi_type},
       {ram_36_cfi_type},
       {ram_35_cfi_type},
       {ram_34_cfi_type},
       {ram_33_cfi_type},
       {ram_32_cfi_type},
       {ram_31_cfi_type},
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
    _GEN_63 =
      {{ram_0_br_mask},
       {ram_0_br_mask},
       {ram_0_br_mask},
       {ram_0_br_mask},
       {ram_0_br_mask},
       {ram_0_br_mask},
       {ram_0_br_mask},
       {ram_0_br_mask},
       {ram_0_br_mask},
       {ram_0_br_mask},
       {ram_0_br_mask},
       {ram_0_br_mask},
       {ram_0_br_mask},
       {ram_0_br_mask},
       {ram_0_br_mask},
       {ram_0_br_mask},
       {ram_0_br_mask},
       {ram_0_br_mask},
       {ram_0_br_mask},
       {ram_0_br_mask},
       {ram_0_br_mask},
       {ram_0_br_mask},
       {ram_0_br_mask},
       {ram_0_br_mask},
       {ram_39_br_mask},
       {ram_38_br_mask},
       {ram_37_br_mask},
       {ram_36_br_mask},
       {ram_35_br_mask},
       {ram_34_br_mask},
       {ram_33_br_mask},
       {ram_32_br_mask},
       {ram_31_br_mask},
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
    _GEN_64 =
      {{pcs_0},
       {pcs_0},
       {pcs_0},
       {pcs_0},
       {pcs_0},
       {pcs_0},
       {pcs_0},
       {pcs_0},
       {pcs_0},
       {pcs_0},
       {pcs_0},
       {pcs_0},
       {pcs_0},
       {pcs_0},
       {pcs_0},
       {pcs_0},
       {pcs_0},
       {pcs_0},
       {pcs_0},
       {pcs_0},
       {pcs_0},
       {pcs_0},
       {pcs_0},
       {pcs_0},
       {pcs_39},
       {pcs_38},
       {pcs_37},
       {pcs_36},
       {pcs_35},
       {pcs_34},
       {pcs_33},
       {pcs_32},
       {pcs_31},
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
    _GEN_65 = bpd_update_repair & REG_1;	// fetch-target-queue.scala:227:34, :256:{34,44}
    wrap = bpd_repair_idx == 6'h27;	// fetch-target-queue.scala:228:27, util.scala:205:25
    _bpd_repair_idx_T_6 = bpd_repair_idx + 6'h1;	// fetch-target-queue.scala:135:27, :228:27, util.scala:206:28
    bpd_ptr_wrap = bpd_ptr == 6'h27;	// fetch-target-queue.scala:133:27, util.scala:205:25
    _bpd_ptr_T = bpd_ptr + 6'h1;	// fetch-target-queue.scala:133:27, :135:27, util.scala:206:28
    do_commit_update =
      ~bpd_update_mispredict & ~bpd_update_repair & bpd_ptr != deq_ptr
      & enq_ptr != (bpd_ptr_wrap ? 6'h0 : _bpd_ptr_T) & ~io_brupdate_b2_mispredict
      & ~io_redirect_valid & ~do_commit_update_REG;	// fetch-target-queue.scala:133:27, :134:27, :135:27, :226:38, :227:34, :269:31, :270:31, :271:40, :272:40, :273:31, :274:{31,50,53,61}, util.scala:205:25, :206:{10,28}
    _GEN_66 =
      {{ram_0_cfi_is_call},
       {ram_0_cfi_is_call},
       {ram_0_cfi_is_call},
       {ram_0_cfi_is_call},
       {ram_0_cfi_is_call},
       {ram_0_cfi_is_call},
       {ram_0_cfi_is_call},
       {ram_0_cfi_is_call},
       {ram_0_cfi_is_call},
       {ram_0_cfi_is_call},
       {ram_0_cfi_is_call},
       {ram_0_cfi_is_call},
       {ram_0_cfi_is_call},
       {ram_0_cfi_is_call},
       {ram_0_cfi_is_call},
       {ram_0_cfi_is_call},
       {ram_0_cfi_is_call},
       {ram_0_cfi_is_call},
       {ram_0_cfi_is_call},
       {ram_0_cfi_is_call},
       {ram_0_cfi_is_call},
       {ram_0_cfi_is_call},
       {ram_0_cfi_is_call},
       {ram_0_cfi_is_call},
       {ram_39_cfi_is_call},
       {ram_38_cfi_is_call},
       {ram_37_cfi_is_call},
       {ram_36_cfi_is_call},
       {ram_35_cfi_is_call},
       {ram_34_cfi_is_call},
       {ram_33_cfi_is_call},
       {ram_32_cfi_is_call},
       {ram_31_cfi_is_call},
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
    _GEN_67 =
      {{ram_0_cfi_is_ret},
       {ram_0_cfi_is_ret},
       {ram_0_cfi_is_ret},
       {ram_0_cfi_is_ret},
       {ram_0_cfi_is_ret},
       {ram_0_cfi_is_ret},
       {ram_0_cfi_is_ret},
       {ram_0_cfi_is_ret},
       {ram_0_cfi_is_ret},
       {ram_0_cfi_is_ret},
       {ram_0_cfi_is_ret},
       {ram_0_cfi_is_ret},
       {ram_0_cfi_is_ret},
       {ram_0_cfi_is_ret},
       {ram_0_cfi_is_ret},
       {ram_0_cfi_is_ret},
       {ram_0_cfi_is_ret},
       {ram_0_cfi_is_ret},
       {ram_0_cfi_is_ret},
       {ram_0_cfi_is_ret},
       {ram_0_cfi_is_ret},
       {ram_0_cfi_is_ret},
       {ram_0_cfi_is_ret},
       {ram_0_cfi_is_ret},
       {ram_39_cfi_is_ret},
       {ram_38_cfi_is_ret},
       {ram_37_cfi_is_ret},
       {ram_36_cfi_is_ret},
       {ram_35_cfi_is_ret},
       {ram_34_cfi_is_ret},
       {ram_33_cfi_is_ret},
       {ram_32_cfi_is_ret},
       {ram_31_cfi_is_ret},
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
    _GEN_68 =
      {{ram_0_ras_top},
       {ram_0_ras_top},
       {ram_0_ras_top},
       {ram_0_ras_top},
       {ram_0_ras_top},
       {ram_0_ras_top},
       {ram_0_ras_top},
       {ram_0_ras_top},
       {ram_0_ras_top},
       {ram_0_ras_top},
       {ram_0_ras_top},
       {ram_0_ras_top},
       {ram_0_ras_top},
       {ram_0_ras_top},
       {ram_0_ras_top},
       {ram_0_ras_top},
       {ram_0_ras_top},
       {ram_0_ras_top},
       {ram_0_ras_top},
       {ram_0_ras_top},
       {ram_0_ras_top},
       {ram_0_ras_top},
       {ram_0_ras_top},
       {ram_0_ras_top},
       {ram_39_ras_top},
       {ram_38_ras_top},
       {ram_37_ras_top},
       {ram_36_ras_top},
       {ram_35_ras_top},
       {ram_34_ras_top},
       {ram_33_ras_top},
       {ram_32_ras_top},
       {ram_31_ras_top},
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
    _GEN_69 =
      {{ram_0_ras_idx},
       {ram_0_ras_idx},
       {ram_0_ras_idx},
       {ram_0_ras_idx},
       {ram_0_ras_idx},
       {ram_0_ras_idx},
       {ram_0_ras_idx},
       {ram_0_ras_idx},
       {ram_0_ras_idx},
       {ram_0_ras_idx},
       {ram_0_ras_idx},
       {ram_0_ras_idx},
       {ram_0_ras_idx},
       {ram_0_ras_idx},
       {ram_0_ras_idx},
       {ram_0_ras_idx},
       {ram_0_ras_idx},
       {ram_0_ras_idx},
       {ram_0_ras_idx},
       {ram_0_ras_idx},
       {ram_0_ras_idx},
       {ram_0_ras_idx},
       {ram_0_ras_idx},
       {ram_0_ras_idx},
       {ram_39_ras_idx},
       {ram_38_ras_idx},
       {ram_37_ras_idx},
       {ram_36_ras_idx},
       {ram_35_ras_idx},
       {ram_34_ras_idx},
       {ram_33_ras_idx},
       {ram_32_ras_idx},
       {ram_31_ras_idx},
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
    _GEN_70 =
      {{ram_0_start_bank},
       {ram_0_start_bank},
       {ram_0_start_bank},
       {ram_0_start_bank},
       {ram_0_start_bank},
       {ram_0_start_bank},
       {ram_0_start_bank},
       {ram_0_start_bank},
       {ram_0_start_bank},
       {ram_0_start_bank},
       {ram_0_start_bank},
       {ram_0_start_bank},
       {ram_0_start_bank},
       {ram_0_start_bank},
       {ram_0_start_bank},
       {ram_0_start_bank},
       {ram_0_start_bank},
       {ram_0_start_bank},
       {ram_0_start_bank},
       {ram_0_start_bank},
       {ram_0_start_bank},
       {ram_0_start_bank},
       {ram_0_start_bank},
       {ram_0_start_bank},
       {ram_39_start_bank},
       {ram_38_start_bank},
       {ram_37_start_bank},
       {ram_36_start_bank},
       {ram_35_start_bank},
       {ram_34_start_bank},
       {ram_33_start_bank},
       {ram_32_start_bank},
       {ram_31_start_bank},
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
    new_cfi_idx = io_brupdate_b2_uop_pc_lob[3:1] ^ {_GEN_70[io_redirect_bits], 2'h0};	// fetch-target-queue.scala:318:50, :319:10
    redirect_new_entry_cfi_idx_valid = _GEN_71 | _GEN_58[io_redirect_bits];	// fetch-target-queue.scala:234:26, :314:28, :317:38, :320:43
    _GEN_72 = ~_GEN_71 | _GEN_59[io_redirect_bits] == new_cfi_idx;	// fetch-target-queue.scala:234:26, :314:28, :317:38, :318:50, :320:43, :324:{43,104}
    redirect_new_entry_cfi_is_call = _GEN_72 & _GEN_66[io_redirect_bits];	// fetch-target-queue.scala:314:28, :317:38, :324:43
    redirect_new_entry_cfi_is_ret = _GEN_72 & _GEN_67[io_redirect_bits];	// fetch-target-queue.scala:314:28, :317:38, :324:43, :325:43
    next_idx = io_get_ftq_pc_0_ftq_idx == 6'h27 ? 6'h0 : io_get_ftq_pc_0_ftq_idx + 6'h1;	// fetch-target-queue.scala:133:27, :135:27, util.scala:205:25, :206:{10,28}
    next_is_enq = next_idx == enq_ptr & ghist_1_MPORT_1_en;	// Decoupled.scala:40:37, fetch-target-queue.scala:135:27, :347:{33,46}, util.scala:206:10
    if (reset) begin
      bpd_ptr <= 6'h0;	// fetch-target-queue.scala:133:27
      deq_ptr <= 6'h0;	// fetch-target-queue.scala:133:27, :134:27
      enq_ptr <= 6'h1;	// fetch-target-queue.scala:135:27
      prev_ghist_old_history <= 64'h0;	// fetch-target-queue.scala:155:{27,42}
      prev_ghist_current_saw_branch_not_taken <= 1'h0;	// fetch-target-queue.scala:155:27, util.scala:206:10
      prev_ghist_new_saw_branch_not_taken <= 1'h0;	// fetch-target-queue.scala:155:27, util.scala:206:10
      prev_ghist_new_saw_branch_taken <= 1'h0;	// fetch-target-queue.scala:155:27, util.scala:206:10
      prev_ghist_ras_idx <= 5'h0;	// fetch-target-queue.scala:155:{27,42}
      prev_entry_cfi_idx_valid <= 1'h0;	// fetch-target-queue.scala:156:27, util.scala:206:10
      prev_entry_cfi_idx_bits <= 3'h0;	// fetch-target-queue.scala:156:{27,42}
      prev_entry_cfi_taken <= 1'h0;	// fetch-target-queue.scala:156:27, util.scala:206:10
      prev_entry_br_mask <= 8'h0;	// fetch-target-queue.scala:156:27
      prev_entry_cfi_is_call <= 1'h0;	// fetch-target-queue.scala:156:27, util.scala:206:10
      prev_entry_cfi_is_ret <= 1'h0;	// fetch-target-queue.scala:156:27, util.scala:206:10
      prev_pc <= 40'h0;	// fetch-target-queue.scala:156:42, :157:27
      first_empty <= 1'h1;	// fetch-target-queue.scala:214:28
      bpd_update_mispredict <= 1'h0;	// fetch-target-queue.scala:226:38, util.scala:206:10
      bpd_update_repair <= 1'h0;	// fetch-target-queue.scala:227:34, util.scala:206:10
    end
    else begin
      if (do_commit_update) begin	// fetch-target-queue.scala:274:50
        if (bpd_ptr_wrap)	// util.scala:205:25
          bpd_ptr <= 6'h0;	// fetch-target-queue.scala:133:27
        else	// util.scala:205:25
          bpd_ptr <= _bpd_ptr_T;	// fetch-target-queue.scala:133:27, util.scala:206:28
      end
      if (io_deq_valid)
        deq_ptr <= io_deq_bits;	// fetch-target-queue.scala:134:27
      if (io_redirect_valid) begin
        if (io_redirect_bits == 6'h27)	// util.scala:205:25
          enq_ptr <= 6'h0;	// fetch-target-queue.scala:133:27, :135:27
        else	// util.scala:205:25
          enq_ptr <= io_redirect_bits + 6'h1;	// fetch-target-queue.scala:135:27, util.scala:206:28
      end
      else if (ghist_1_MPORT_1_en) begin	// Decoupled.scala:40:37
        if (full_wrap)	// util.scala:205:25
          enq_ptr <= 6'h0;	// fetch-target-queue.scala:133:27, :135:27
        else	// util.scala:205:25
          enq_ptr <= _enq_ptr_T;	// fetch-target-queue.scala:135:27, util.scala:206:28
      end
      if (io_redirect_valid | ~REG_3) begin	// fetch-target-queue.scala:158:17, :314:28, :332:{23,44}
        if (ghist_1_MPORT_1_en) begin	// Decoupled.scala:40:37
          if (io_enq_bits_ghist_current_saw_branch_not_taken)
            prev_ghist_old_history <= io_enq_bits_ghist_old_history;	// fetch-target-queue.scala:155:27
          else if (new_ghist_ignore_second_bank)	// frontend.scala:106:46
            prev_ghist_old_history <= _new_ghist_new_history_old_history_T_4;	// fetch-target-queue.scala:155:27, frontend.scala:68:12
          else	// frontend.scala:106:46
            prev_ghist_old_history <= _new_ghist_new_history_old_history_T_25;	// fetch-target-queue.scala:155:27, frontend.scala:115:39
          prev_ghist_current_saw_branch_not_taken <=
            io_enq_bits_ghist_current_saw_branch_not_taken;	// fetch-target-queue.scala:155:27
          if (io_enq_bits_ghist_current_saw_branch_not_taken) begin
            prev_ghist_new_saw_branch_not_taken <=
              io_enq_bits_ghist_new_saw_branch_not_taken;	// fetch-target-queue.scala:155:27
            prev_ghist_new_saw_branch_taken <= io_enq_bits_ghist_new_saw_branch_taken;	// fetch-target-queue.scala:155:27
            prev_ghist_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:155:27
          end
          else begin
            if (new_ghist_ignore_second_bank) begin	// frontend.scala:106:46
              prev_ghist_new_saw_branch_not_taken <= new_ghist_first_bank_saw_not_taken;	// fetch-target-queue.scala:155:27, frontend.scala:108:80
              prev_ghist_new_saw_branch_taken <=
                _new_ghist_new_history_new_saw_branch_taken_T;	// fetch-target-queue.scala:155:27, frontend.scala:113:59
            end
            else begin	// frontend.scala:106:46
              prev_ghist_new_saw_branch_not_taken <=
                |_new_ghist_new_history_new_saw_branch_not_taken_T;	// fetch-target-queue.scala:155:27, frontend.scala:90:39, :119:{67,92}
              prev_ghist_new_saw_branch_taken <=
                _new_ghist_new_history_new_saw_branch_taken_T_4;	// fetch-target-queue.scala:155:27, frontend.scala:120:85
            end
            if (_new_ghist_new_history_ras_idx_T)	// frontend.scala:124:42
              prev_ghist_ras_idx <= _new_ghist_new_history_ras_idx_T_1;	// fetch-target-queue.scala:155:27, util.scala:203:14
            else if (_new_ghist_new_history_ras_idx_T_4)	// frontend.scala:125:42
              prev_ghist_ras_idx <= _new_ghist_new_history_ras_idx_T_5;	// fetch-target-queue.scala:155:27, util.scala:220:14
          end
          prev_entry_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:156:27
          prev_entry_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:156:27
          prev_entry_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:156:27
          prev_entry_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:156:27, :175:52
          prev_entry_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:156:27
          prev_entry_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:156:27
          prev_pc <= io_enq_bits_pc;	// fetch-target-queue.scala:157:27
        end
      end
      else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
        prev_ghist_old_history <= _ghist_0_ext_R0_data[63:0];	// fetch-target-queue.scala:144:43, :155:27
        prev_ghist_current_saw_branch_not_taken <= _ghist_0_ext_R0_data[64];	// fetch-target-queue.scala:144:43, :155:27
        prev_ghist_new_saw_branch_not_taken <= _ghist_0_ext_R0_data[65];	// fetch-target-queue.scala:144:43, :155:27
        prev_ghist_new_saw_branch_taken <= _ghist_0_ext_R0_data[66];	// fetch-target-queue.scala:144:43, :155:27
        prev_ghist_ras_idx <= _ghist_0_ext_R0_data[71:67];	// fetch-target-queue.scala:144:43, :155:27
        prev_entry_cfi_idx_valid <= prev_entry_REG_cfi_idx_valid;	// fetch-target-queue.scala:156:27, :333:26
        prev_entry_cfi_idx_bits <= prev_entry_REG_cfi_idx_bits;	// fetch-target-queue.scala:156:27, :333:26
        prev_entry_cfi_taken <= prev_entry_REG_cfi_taken;	// fetch-target-queue.scala:156:27, :333:26
        prev_entry_br_mask <= prev_entry_REG_br_mask;	// fetch-target-queue.scala:156:27, :333:26
        prev_entry_cfi_is_call <= prev_entry_REG_cfi_is_call;	// fetch-target-queue.scala:156:27, :333:26
        prev_entry_cfi_is_ret <= prev_entry_REG_cfi_is_ret;	// fetch-target-queue.scala:156:27, :333:26
        prev_pc <= bpd_pc;	// fetch-target-queue.scala:157:27, :242:26
      end
      first_empty <= ~REG_2 & first_empty;	// fetch-target-queue.scala:214:28, :278:{16,80}, :301:17
      bpd_update_mispredict <= ~io_redirect_valid & REG;	// fetch-target-queue.scala:226:38, :245:28, :246:27, :248:{23,52}
      bpd_update_repair <=
        ~io_redirect_valid
        & (REG
             ? bpd_update_repair
             : bpd_update_mispredict
               | (_GEN_65
                  | ~(bpd_update_repair
                      & ((wrap ? 6'h0 : _bpd_repair_idx_T_6) == bpd_end_idx
                         | bpd_pc == bpd_repair_pc))) & bpd_update_repair);	// fetch-target-queue.scala:133:27, :226:38, :227:34, :229:24, :230:26, :242:26, :245:28, :246:27, :247:27, :248:{23,52}, :252:39, :254:27, :256:{34,69}, :259:35, :261:{48,64}, :262:{14,34}, :263:25, util.scala:205:25, :206:{10,28}
    end
    if (_GEN_18)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_0 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_19)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_1 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_20)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_2 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_21)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_3 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_22)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_4 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_23)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_5 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_24)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_6 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_25)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_7 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_26)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_8 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_27)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_9 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_28)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_10 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_29)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_11 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_30)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_12 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_31)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_13 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_32)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_14 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_33)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_15 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_34)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_16 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_35)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_17 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_36)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_18 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_37)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_19 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_38)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_20 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_39)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_21 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_40)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_22 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_41)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_23 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_42)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_24 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_43)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_25 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_44)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_26 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_45)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_27 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_46)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_28 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_47)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_29 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_48)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_30 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_49)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_31 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_50)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_32 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_51)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_33 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_52)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_34 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_53)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_35 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_54)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_36 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_55)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_37 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_56)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_38 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (_GEN_57)	// fetch-target-queue.scala:141:21, :158:17, :160:28
      pcs_39 <= io_enq_bits_pc;	// fetch-target-queue.scala:141:21
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h0)) begin	// fetch-target-queue.scala:133:27, :158:17, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_18) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_0_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_0_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_0_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_0_cfi_mispredicted <= ~_GEN_18 & ram_0_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_18) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_0_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_0_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_0_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_0_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_0_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_0_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_0_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
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
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h1)) begin	// fetch-target-queue.scala:135:27, :158:17, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_19) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_1_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_1_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_1_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_1_cfi_mispredicted <= ~_GEN_19 & ram_1_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_19) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_1_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_1_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_1_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_1_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_1_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_1_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_1_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
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
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h2)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_20) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_2_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_2_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_2_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_2_cfi_mispredicted <= ~_GEN_20 & ram_2_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_20) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_2_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_2_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_2_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_2_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_2_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_2_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_2_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
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
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h3)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_21) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_3_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_3_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_3_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_3_cfi_mispredicted <= ~_GEN_21 & ram_3_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_21) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_3_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_3_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_3_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_3_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_3_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_3_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_3_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
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
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h4)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_22) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_4_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_4_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_4_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_4_cfi_mispredicted <= ~_GEN_22 & ram_4_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_22) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_4_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_4_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_4_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_4_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_4_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_4_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_4_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
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
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h5)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_23) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_5_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_5_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_5_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_5_cfi_mispredicted <= ~_GEN_23 & ram_5_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_23) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_5_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_5_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_5_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_5_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_5_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_5_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_5_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
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
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h6)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_24) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_6_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_6_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_6_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_6_cfi_mispredicted <= ~_GEN_24 & ram_6_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_24) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_6_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_6_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_6_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_6_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_6_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_6_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_6_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
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
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h7)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_25) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_7_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_7_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_7_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_7_cfi_mispredicted <= ~_GEN_25 & ram_7_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_25) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_7_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_7_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_7_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_7_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_7_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_7_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_7_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
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
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h8)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_26) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_8_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_8_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_8_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_8_cfi_mispredicted <= ~_GEN_26 & ram_8_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_26) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_8_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_8_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_8_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_8_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_8_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_8_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_8_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
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
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h9)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_27) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_9_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_9_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_9_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_9_cfi_mispredicted <= ~_GEN_27 & ram_9_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_27) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_9_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_9_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_9_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_9_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_9_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_9_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_9_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
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
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'hA)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_28) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_10_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_10_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_10_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_10_cfi_mispredicted <= ~_GEN_28 & ram_10_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_28) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_10_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_10_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_10_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_10_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_10_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_10_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_10_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
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
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'hB)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_29) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_11_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_11_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_11_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_11_cfi_mispredicted <= ~_GEN_29 & ram_11_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_29) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_11_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_11_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_11_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_11_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_11_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_11_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_11_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
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
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'hC)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_30) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_12_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_12_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_12_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_12_cfi_mispredicted <= ~_GEN_30 & ram_12_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_30) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_12_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_12_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_12_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_12_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_12_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_12_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_12_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
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
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'hD)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_31) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_13_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_13_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_13_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_13_cfi_mispredicted <= ~_GEN_31 & ram_13_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_31) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_13_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_13_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_13_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_13_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_13_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_13_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_13_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
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
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'hE)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_32) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_14_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_14_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_14_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_14_cfi_mispredicted <= ~_GEN_32 & ram_14_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_32) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_14_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_14_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_14_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_14_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_14_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_14_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_14_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
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
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'hF)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_33) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_15_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_15_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_15_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_15_cfi_mispredicted <= ~_GEN_33 & ram_15_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_33) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_15_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_15_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_15_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_15_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_15_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_15_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_15_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
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
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h10)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_34) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_16_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_16_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_16_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_16_cfi_mispredicted <= ~_GEN_34 & ram_16_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_34) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_16_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_16_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_16_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_16_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_16_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_16_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_16_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
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
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h11)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_35) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_17_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_17_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_17_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_17_cfi_mispredicted <= ~_GEN_35 & ram_17_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_35) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_17_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_17_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_17_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_17_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_17_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_17_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_17_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
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
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h12)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_36) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_18_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_18_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_18_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_18_cfi_mispredicted <= ~_GEN_36 & ram_18_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_36) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_18_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_18_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_18_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_18_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_18_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_18_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_18_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
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
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h13)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_37) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_19_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_19_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_19_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_19_cfi_mispredicted <= ~_GEN_37 & ram_19_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_37) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_19_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_19_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_19_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_19_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_19_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_19_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_19_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
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
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h14)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_38) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_20_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_20_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_20_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_20_cfi_mispredicted <= ~_GEN_38 & ram_20_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_38) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_20_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_20_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_20_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_20_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_20_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_20_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_20_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
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
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h15)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_39) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_21_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_21_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_21_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_21_cfi_mispredicted <= ~_GEN_39 & ram_21_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_39) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_21_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_21_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_21_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_21_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_21_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_21_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_21_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
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
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h16)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_40) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_22_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_22_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_22_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_22_cfi_mispredicted <= ~_GEN_40 & ram_22_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_40) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_22_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_22_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_22_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_22_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_22_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_22_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_22_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
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
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h17)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_41) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_23_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_23_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_23_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_23_cfi_mispredicted <= ~_GEN_41 & ram_23_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_41) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_23_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_23_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_23_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_23_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_23_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_23_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_23_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
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
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h18)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_42) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_24_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_24_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_24_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_24_cfi_mispredicted <= ~_GEN_42 & ram_24_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_42) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_24_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_24_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_24_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_24_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_24_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_24_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_24_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
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
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h19)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_43) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_25_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_25_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_25_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_25_cfi_mispredicted <= ~_GEN_43 & ram_25_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_43) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_25_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_25_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_25_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_25_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_25_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_25_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_25_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
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
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h1A)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_44) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_26_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_26_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_26_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_26_cfi_mispredicted <= ~_GEN_44 & ram_26_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_44) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_26_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_26_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_26_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_26_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_26_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_26_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_26_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
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
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h1B)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_45) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_27_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_27_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_27_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_27_cfi_mispredicted <= ~_GEN_45 & ram_27_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_45) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_27_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_27_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_27_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_27_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_27_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_27_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_27_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
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
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h1C)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_46) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_28_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_28_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_28_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_28_cfi_mispredicted <= ~_GEN_46 & ram_28_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_46) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_28_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_28_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_28_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_28_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_28_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_28_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_28_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
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
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h1D)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_47) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_29_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_29_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_29_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_29_cfi_mispredicted <= ~_GEN_47 & ram_29_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_47) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_29_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_29_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_29_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_29_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_29_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_29_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_29_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
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
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h1E)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_48) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_30_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_30_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_30_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_30_cfi_mispredicted <= ~_GEN_48 & ram_30_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_48) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_30_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_30_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_30_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_30_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_30_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_30_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_30_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
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
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h1F)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_49) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_31_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_31_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_31_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_31_cfi_mispredicted <= ~_GEN_49 & ram_31_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_49) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_31_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_31_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_31_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_31_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_31_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_31_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_31_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
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
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h20)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_50) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_32_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_32_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_32_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_32_cfi_mispredicted <= ~_GEN_50 & ram_32_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_50) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_32_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_32_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_32_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_32_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_32_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_32_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_32_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_32_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_32_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_32_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_32_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_32_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_32_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_32_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_32_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_32_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_32_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_32_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h21)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_51) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_33_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_33_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_33_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_33_cfi_mispredicted <= ~_GEN_51 & ram_33_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_51) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_33_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_33_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_33_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_33_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_33_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_33_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_33_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_33_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_33_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_33_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_33_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_33_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_33_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_33_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_33_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_33_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_33_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_33_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h22)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_52) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_34_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_34_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_34_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_34_cfi_mispredicted <= ~_GEN_52 & ram_34_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_52) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_34_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_34_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_34_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_34_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_34_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_34_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_34_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_34_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_34_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_34_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_34_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_34_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_34_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_34_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_34_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_34_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_34_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_34_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h23)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_53) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_35_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_35_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_35_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_35_cfi_mispredicted <= ~_GEN_53 & ram_35_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_53) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_35_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_35_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_35_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_35_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_35_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_35_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_35_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_35_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_35_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_35_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_35_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_35_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_35_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_35_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_35_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_35_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_35_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_35_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h24)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_54) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_36_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_36_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_36_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_36_cfi_mispredicted <= ~_GEN_54 & ram_36_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_54) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_36_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_36_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_36_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_36_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_36_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_36_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_36_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_36_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_36_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_36_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_36_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_36_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_36_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_36_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_36_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_36_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_36_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_36_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h25)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_55) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_37_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_37_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_37_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_37_cfi_mispredicted <= ~_GEN_55 & ram_37_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_55) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_37_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_37_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_37_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_37_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_37_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_37_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_37_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_37_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_37_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_37_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_37_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_37_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_37_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_37_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_37_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_37_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_37_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_37_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h26)) begin	// fetch-target-queue.scala:158:17, :160:28, :314:28, :332:{23,44}, :337:{16,36}
      if (_GEN_56) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_38_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_38_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_38_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_38_cfi_mispredicted <= ~_GEN_56 & ram_38_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_56) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_38_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_38_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_38_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_38_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_38_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_38_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_38_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_38_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_38_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_38_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_38_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_38_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_38_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_38_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_38_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_38_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_38_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_38_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    if (io_redirect_valid | ~(REG_3 & REG_4 == 6'h27)) begin	// fetch-target-queue.scala:158:17, :314:28, :332:{23,44}, :337:{16,36}, util.scala:205:25
      if (_GEN_57) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_39_cfi_idx_valid <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
        ram_39_cfi_idx_bits <= io_enq_bits_cfi_idx_bits;	// fetch-target-queue.scala:143:21
        ram_39_cfi_taken <= io_enq_bits_cfi_idx_valid;	// fetch-target-queue.scala:143:21
      end
      ram_39_cfi_mispredicted <= ~_GEN_57 & ram_39_cfi_mispredicted;	// fetch-target-queue.scala:141:21, :143:21, :158:17, :160:28, :195:18
      if (_GEN_57) begin	// fetch-target-queue.scala:141:21, :158:17, :160:28
        ram_39_cfi_type <= io_enq_bits_cfi_type;	// fetch-target-queue.scala:143:21
        ram_39_br_mask <= new_entry_br_mask;	// fetch-target-queue.scala:143:21, :175:52
        ram_39_cfi_is_call <= io_enq_bits_cfi_is_call;	// fetch-target-queue.scala:143:21
        ram_39_cfi_is_ret <= io_enq_bits_cfi_is_ret;	// fetch-target-queue.scala:143:21
        ram_39_ras_top <= io_enq_bits_ras_top;	// fetch-target-queue.scala:143:21
        ram_39_ras_idx <= io_enq_bits_ghist_ras_idx;	// fetch-target-queue.scala:143:21
        ram_39_start_bank <= io_enq_bits_pc[3];	// fetch-target-queue.scala:143:21, frontend.scala:151:47
      end
    end
    else begin	// fetch-target-queue.scala:158:17, :314:28, :332:44
      ram_39_cfi_idx_valid <= ram_REG_cfi_idx_valid;	// fetch-target-queue.scala:143:21, :337:46
      ram_39_cfi_idx_bits <= ram_REG_cfi_idx_bits;	// fetch-target-queue.scala:143:21, :337:46
      ram_39_cfi_taken <= ram_REG_cfi_taken;	// fetch-target-queue.scala:143:21, :337:46
      ram_39_cfi_mispredicted <= ram_REG_cfi_mispredicted;	// fetch-target-queue.scala:143:21, :337:46
      ram_39_cfi_type <= ram_REG_cfi_type;	// fetch-target-queue.scala:143:21, :337:46
      ram_39_br_mask <= ram_REG_br_mask;	// fetch-target-queue.scala:143:21, :337:46
      ram_39_cfi_is_call <= ram_REG_cfi_is_call;	// fetch-target-queue.scala:143:21, :337:46
      ram_39_cfi_is_ret <= ram_REG_cfi_is_ret;	// fetch-target-queue.scala:143:21, :337:46
      ram_39_ras_top <= ram_REG_ras_top;	// fetch-target-queue.scala:143:21, :337:46
      ram_39_ras_idx <= ram_REG_ras_idx;	// fetch-target-queue.scala:143:21, :337:46
      ram_39_start_bank <= ram_REG_start_bank;	// fetch-target-queue.scala:143:21, :337:46
    end
    io_ras_update_REG <= io_redirect_valid;	// fetch-target-queue.scala:222:31
    if (io_redirect_valid) begin
      io_ras_update_pc_REG <= _GEN_68[io_redirect_bits];	// fetch-target-queue.scala:223:31
      io_ras_update_idx_REG <= _GEN_69[io_redirect_bits];	// fetch-target-queue.scala:224:31
    end
    else begin
      io_ras_update_pc_REG <= 40'h0;	// fetch-target-queue.scala:156:42, :223:31
      io_ras_update_idx_REG <= 5'h0;	// fetch-target-queue.scala:155:42, :224:31
      if (REG)	// fetch-target-queue.scala:248:23
        bpd_repair_idx <= bpd_repair_idx_REG;	// fetch-target-queue.scala:228:27, :250:37
      else if (bpd_update_mispredict) begin	// fetch-target-queue.scala:226:38
        if (bpd_repair_idx == 6'h27)	// fetch-target-queue.scala:228:27, util.scala:205:25
          bpd_repair_idx <= 6'h0;	// fetch-target-queue.scala:133:27, :228:27
        else	// util.scala:205:25
          bpd_repair_idx <= bpd_repair_idx + 6'h1;	// fetch-target-queue.scala:135:27, :228:27, util.scala:206:28
      end
      else if (_GEN_65) begin	// fetch-target-queue.scala:256:34
        if (bpd_repair_idx == 6'h27)	// fetch-target-queue.scala:228:27, util.scala:205:25
          bpd_repair_idx <= 6'h0;	// fetch-target-queue.scala:133:27, :228:27
        else	// util.scala:205:25
          bpd_repair_idx <= bpd_repair_idx + 6'h1;	// fetch-target-queue.scala:135:27, :228:27, util.scala:206:28
      end
      else if (bpd_update_repair) begin	// fetch-target-queue.scala:227:34
        if (wrap)	// util.scala:205:25
          bpd_repair_idx <= 6'h0;	// fetch-target-queue.scala:133:27, :228:27
        else	// util.scala:205:25
          bpd_repair_idx <= _bpd_repair_idx_T_6;	// fetch-target-queue.scala:228:27, util.scala:206:28
      end
    end
    if (io_redirect_valid | ~REG) begin	// fetch-target-queue.scala:229:24, :245:28, :248:{23,52}
    end
    else	// fetch-target-queue.scala:229:24, :245:28, :248:52
      bpd_end_idx <= bpd_end_idx_REG;	// fetch-target-queue.scala:229:24, :251:37
    if (io_redirect_valid | REG | bpd_update_mispredict | ~_GEN_65) begin	// fetch-target-queue.scala:226:38, :230:26, :245:28, :248:{23,52}, :252:39, :256:{34,69}
    end
    else	// fetch-target-queue.scala:230:26, :245:28, :248:52, :252:39, :256:69
      bpd_repair_pc <= bpd_pc;	// fetch-target-queue.scala:230:26, :242:26
    bpd_entry_cfi_idx_valid <= _GEN_58[_bpd_meta_T_1];	// fetch-target-queue.scala:232:20, :234:26
    bpd_entry_cfi_idx_bits <= _GEN_59[_bpd_meta_T_1];	// fetch-target-queue.scala:232:20, :234:26
    bpd_entry_cfi_taken <= _GEN_60[_bpd_meta_T_1];	// fetch-target-queue.scala:232:20, :234:26
    bpd_entry_cfi_mispredicted <= _GEN_61[_bpd_meta_T_1];	// fetch-target-queue.scala:232:20, :234:26
    bpd_entry_cfi_type <= _GEN_62[_bpd_meta_T_1];	// fetch-target-queue.scala:232:20, :234:26
    bpd_entry_br_mask <= _GEN_63[_bpd_meta_T_1];	// fetch-target-queue.scala:232:20, :234:26
    bpd_pc <= _GEN_64[_bpd_meta_T_1];	// fetch-target-queue.scala:232:20, :242:26
    bpd_target <= _GEN_64[_bpd_meta_T_1 == 6'h27 ? 6'h0 : _bpd_meta_T_1 + 6'h1];	// fetch-target-queue.scala:133:27, :135:27, :232:20, :242:26, :243:27, util.scala:205:25, :206:{10,28}
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
      ~((_full_T_2 == 6'h27 ? 6'h0 : _full_T_2 + 6'h1) == bpd_ptr
        | (full_wrap ? 6'h0 : _enq_ptr_T) == bpd_ptr) | do_commit_update;	// fetch-target-queue.scala:133:27, :135:27, :137:{68,81}, :138:46, :274:50, :308:{26,27,33}, util.scala:205:25, :206:{10,28}
    REG_3 <= io_redirect_valid;	// fetch-target-queue.scala:332:23
    prev_entry_REG_cfi_idx_valid <= redirect_new_entry_cfi_idx_valid;	// fetch-target-queue.scala:314:28, :317:38, :320:43, :333:26
    if (_GEN_71) begin	// fetch-target-queue.scala:314:28, :317:38, :320:43
      prev_entry_REG_cfi_idx_bits <= new_cfi_idx;	// fetch-target-queue.scala:318:50, :333:26
      prev_entry_REG_cfi_taken <= io_brupdate_b2_taken;	// fetch-target-queue.scala:333:26
      ram_REG_cfi_idx_bits <= new_cfi_idx;	// fetch-target-queue.scala:318:50, :337:46
      ram_REG_cfi_taken <= io_brupdate_b2_taken;	// fetch-target-queue.scala:337:46
    end
    else begin	// fetch-target-queue.scala:314:28, :317:38, :320:43
      prev_entry_REG_cfi_idx_bits <= _GEN_59[io_redirect_bits];	// fetch-target-queue.scala:234:26, :333:26
      prev_entry_REG_cfi_taken <= _GEN_60[io_redirect_bits];	// fetch-target-queue.scala:234:26, :333:26
      ram_REG_cfi_idx_bits <= _GEN_59[io_redirect_bits];	// fetch-target-queue.scala:234:26, :337:46
      ram_REG_cfi_taken <= _GEN_60[io_redirect_bits];	// fetch-target-queue.scala:234:26, :337:46
    end
    prev_entry_REG_br_mask <= _GEN_63[io_redirect_bits];	// fetch-target-queue.scala:234:26, :333:26
    prev_entry_REG_cfi_is_call <= redirect_new_entry_cfi_is_call;	// fetch-target-queue.scala:314:28, :317:38, :324:43, :333:26
    prev_entry_REG_cfi_is_ret <= redirect_new_entry_cfi_is_ret;	// fetch-target-queue.scala:314:28, :317:38, :325:43, :333:26
    REG_4 <= io_redirect_bits;	// fetch-target-queue.scala:337:16
    ram_REG_cfi_idx_valid <= redirect_new_entry_cfi_idx_valid;	// fetch-target-queue.scala:314:28, :317:38, :320:43, :337:46
    ram_REG_cfi_mispredicted <= _GEN_71 | _GEN_61[io_redirect_bits];	// fetch-target-queue.scala:234:26, :314:28, :317:38, :320:43, :322:43, :337:46
    ram_REG_cfi_type <= _GEN_62[io_redirect_bits];	// fetch-target-queue.scala:234:26, :337:46
    ram_REG_br_mask <= _GEN_63[io_redirect_bits];	// fetch-target-queue.scala:234:26, :337:46
    ram_REG_cfi_is_call <= redirect_new_entry_cfi_is_call;	// fetch-target-queue.scala:314:28, :317:38, :324:43, :337:46
    ram_REG_cfi_is_ret <= redirect_new_entry_cfi_is_ret;	// fetch-target-queue.scala:314:28, :317:38, :325:43, :337:46
    ram_REG_ras_top <= _GEN_68[io_redirect_bits];	// fetch-target-queue.scala:337:46
    ram_REG_ras_idx <= _GEN_69[io_redirect_bits];	// fetch-target-queue.scala:337:46
    ram_REG_start_bank <= _GEN_70[io_redirect_bits];	// fetch-target-queue.scala:337:46
    io_get_ftq_pc_0_entry_REG_cfi_idx_valid <= _GEN_58[io_get_ftq_pc_0_ftq_idx];	// fetch-target-queue.scala:234:26, :351:42
    io_get_ftq_pc_0_entry_REG_cfi_idx_bits <= _GEN_59[io_get_ftq_pc_0_ftq_idx];	// fetch-target-queue.scala:234:26, :351:42
    io_get_ftq_pc_0_entry_REG_ras_idx <= _GEN_69[io_get_ftq_pc_0_ftq_idx];	// fetch-target-queue.scala:351:42
    io_get_ftq_pc_0_entry_REG_start_bank <= _GEN_70[io_get_ftq_pc_0_ftq_idx];	// fetch-target-queue.scala:351:42
    io_get_ftq_pc_0_pc_REG <= _GEN_64[io_get_ftq_pc_0_ftq_idx];	// fetch-target-queue.scala:242:26, :356:42
    if (next_is_enq)	// fetch-target-queue.scala:347:46
      io_get_ftq_pc_0_next_pc_REG <= io_enq_bits_pc;	// fetch-target-queue.scala:357:42
    else	// fetch-target-queue.scala:347:46
      io_get_ftq_pc_0_next_pc_REG <= _GEN_64[next_idx];	// fetch-target-queue.scala:242:26, :348:22, :357:42, util.scala:206:10
    io_get_ftq_pc_0_next_val_REG <= next_idx != enq_ptr | next_is_enq;	// fetch-target-queue.scala:135:27, :347:46, :358:{42,52,64}, util.scala:206:10
    io_get_ftq_pc_0_com_pc_REG <= _GEN_64[io_deq_valid ? io_deq_bits : deq_ptr];	// fetch-target-queue.scala:134:27, :242:26, :359:{42,50}
    io_get_ftq_pc_1_entry_REG_cfi_idx_bits <= _GEN_59[io_get_ftq_pc_1_ftq_idx];	// fetch-target-queue.scala:234:26, :351:42
    io_get_ftq_pc_1_entry_REG_br_mask <= _GEN_63[io_get_ftq_pc_1_ftq_idx];	// fetch-target-queue.scala:234:26, :351:42
    io_get_ftq_pc_1_entry_REG_cfi_is_call <= _GEN_66[io_get_ftq_pc_1_ftq_idx];	// fetch-target-queue.scala:351:42
    io_get_ftq_pc_1_entry_REG_cfi_is_ret <= _GEN_67[io_get_ftq_pc_1_ftq_idx];	// fetch-target-queue.scala:351:42
    io_get_ftq_pc_1_entry_REG_start_bank <= _GEN_70[io_get_ftq_pc_1_ftq_idx];	// fetch-target-queue.scala:351:42
    io_get_ftq_pc_1_pc_REG <= _GEN_64[io_get_ftq_pc_1_ftq_idx];	// fetch-target-queue.scala:242:26, :356:42
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:160];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [7:0] i = 8'h0; i < 8'hA1; i += 8'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        bpd_ptr = _RANDOM[8'h0][5:0];	// fetch-target-queue.scala:133:27
        deq_ptr = _RANDOM[8'h0][11:6];	// fetch-target-queue.scala:133:27, :134:27
        enq_ptr = _RANDOM[8'h0][17:12];	// fetch-target-queue.scala:133:27, :135:27
        pcs_0 = {_RANDOM[8'h0][31:18], _RANDOM[8'h1][25:0]};	// fetch-target-queue.scala:133:27, :141:21
        pcs_1 = {_RANDOM[8'h1][31:26], _RANDOM[8'h2], _RANDOM[8'h3][1:0]};	// fetch-target-queue.scala:141:21
        pcs_2 = {_RANDOM[8'h3][31:2], _RANDOM[8'h4][9:0]};	// fetch-target-queue.scala:141:21
        pcs_3 = {_RANDOM[8'h4][31:10], _RANDOM[8'h5][17:0]};	// fetch-target-queue.scala:141:21
        pcs_4 = {_RANDOM[8'h5][31:18], _RANDOM[8'h6][25:0]};	// fetch-target-queue.scala:141:21
        pcs_5 = {_RANDOM[8'h6][31:26], _RANDOM[8'h7], _RANDOM[8'h8][1:0]};	// fetch-target-queue.scala:141:21
        pcs_6 = {_RANDOM[8'h8][31:2], _RANDOM[8'h9][9:0]};	// fetch-target-queue.scala:141:21
        pcs_7 = {_RANDOM[8'h9][31:10], _RANDOM[8'hA][17:0]};	// fetch-target-queue.scala:141:21
        pcs_8 = {_RANDOM[8'hA][31:18], _RANDOM[8'hB][25:0]};	// fetch-target-queue.scala:141:21
        pcs_9 = {_RANDOM[8'hB][31:26], _RANDOM[8'hC], _RANDOM[8'hD][1:0]};	// fetch-target-queue.scala:141:21
        pcs_10 = {_RANDOM[8'hD][31:2], _RANDOM[8'hE][9:0]};	// fetch-target-queue.scala:141:21
        pcs_11 = {_RANDOM[8'hE][31:10], _RANDOM[8'hF][17:0]};	// fetch-target-queue.scala:141:21
        pcs_12 = {_RANDOM[8'hF][31:18], _RANDOM[8'h10][25:0]};	// fetch-target-queue.scala:141:21
        pcs_13 = {_RANDOM[8'h10][31:26], _RANDOM[8'h11], _RANDOM[8'h12][1:0]};	// fetch-target-queue.scala:141:21
        pcs_14 = {_RANDOM[8'h12][31:2], _RANDOM[8'h13][9:0]};	// fetch-target-queue.scala:141:21
        pcs_15 = {_RANDOM[8'h13][31:10], _RANDOM[8'h14][17:0]};	// fetch-target-queue.scala:141:21
        pcs_16 = {_RANDOM[8'h14][31:18], _RANDOM[8'h15][25:0]};	// fetch-target-queue.scala:141:21
        pcs_17 = {_RANDOM[8'h15][31:26], _RANDOM[8'h16], _RANDOM[8'h17][1:0]};	// fetch-target-queue.scala:141:21
        pcs_18 = {_RANDOM[8'h17][31:2], _RANDOM[8'h18][9:0]};	// fetch-target-queue.scala:141:21
        pcs_19 = {_RANDOM[8'h18][31:10], _RANDOM[8'h19][17:0]};	// fetch-target-queue.scala:141:21
        pcs_20 = {_RANDOM[8'h19][31:18], _RANDOM[8'h1A][25:0]};	// fetch-target-queue.scala:141:21
        pcs_21 = {_RANDOM[8'h1A][31:26], _RANDOM[8'h1B], _RANDOM[8'h1C][1:0]};	// fetch-target-queue.scala:141:21
        pcs_22 = {_RANDOM[8'h1C][31:2], _RANDOM[8'h1D][9:0]};	// fetch-target-queue.scala:141:21
        pcs_23 = {_RANDOM[8'h1D][31:10], _RANDOM[8'h1E][17:0]};	// fetch-target-queue.scala:141:21
        pcs_24 = {_RANDOM[8'h1E][31:18], _RANDOM[8'h1F][25:0]};	// fetch-target-queue.scala:141:21
        pcs_25 = {_RANDOM[8'h1F][31:26], _RANDOM[8'h20], _RANDOM[8'h21][1:0]};	// fetch-target-queue.scala:141:21
        pcs_26 = {_RANDOM[8'h21][31:2], _RANDOM[8'h22][9:0]};	// fetch-target-queue.scala:141:21
        pcs_27 = {_RANDOM[8'h22][31:10], _RANDOM[8'h23][17:0]};	// fetch-target-queue.scala:141:21
        pcs_28 = {_RANDOM[8'h23][31:18], _RANDOM[8'h24][25:0]};	// fetch-target-queue.scala:141:21
        pcs_29 = {_RANDOM[8'h24][31:26], _RANDOM[8'h25], _RANDOM[8'h26][1:0]};	// fetch-target-queue.scala:141:21
        pcs_30 = {_RANDOM[8'h26][31:2], _RANDOM[8'h27][9:0]};	// fetch-target-queue.scala:141:21
        pcs_31 = {_RANDOM[8'h27][31:10], _RANDOM[8'h28][17:0]};	// fetch-target-queue.scala:141:21
        pcs_32 = {_RANDOM[8'h28][31:18], _RANDOM[8'h29][25:0]};	// fetch-target-queue.scala:141:21
        pcs_33 = {_RANDOM[8'h29][31:26], _RANDOM[8'h2A], _RANDOM[8'h2B][1:0]};	// fetch-target-queue.scala:141:21
        pcs_34 = {_RANDOM[8'h2B][31:2], _RANDOM[8'h2C][9:0]};	// fetch-target-queue.scala:141:21
        pcs_35 = {_RANDOM[8'h2C][31:10], _RANDOM[8'h2D][17:0]};	// fetch-target-queue.scala:141:21
        pcs_36 = {_RANDOM[8'h2D][31:18], _RANDOM[8'h2E][25:0]};	// fetch-target-queue.scala:141:21
        pcs_37 = {_RANDOM[8'h2E][31:26], _RANDOM[8'h2F], _RANDOM[8'h30][1:0]};	// fetch-target-queue.scala:141:21
        pcs_38 = {_RANDOM[8'h30][31:2], _RANDOM[8'h31][9:0]};	// fetch-target-queue.scala:141:21
        pcs_39 = {_RANDOM[8'h31][31:10], _RANDOM[8'h32][17:0]};	// fetch-target-queue.scala:141:21
        ram_0_cfi_idx_valid = _RANDOM[8'h32][18];	// fetch-target-queue.scala:141:21, :143:21
        ram_0_cfi_idx_bits = _RANDOM[8'h32][21:19];	// fetch-target-queue.scala:141:21, :143:21
        ram_0_cfi_taken = _RANDOM[8'h32][22];	// fetch-target-queue.scala:141:21, :143:21
        ram_0_cfi_mispredicted = _RANDOM[8'h32][23];	// fetch-target-queue.scala:141:21, :143:21
        ram_0_cfi_type = _RANDOM[8'h32][26:24];	// fetch-target-queue.scala:141:21, :143:21
        ram_0_br_mask = {_RANDOM[8'h32][31:27], _RANDOM[8'h33][2:0]};	// fetch-target-queue.scala:141:21, :143:21
        ram_0_cfi_is_call = _RANDOM[8'h33][3];	// fetch-target-queue.scala:143:21
        ram_0_cfi_is_ret = _RANDOM[8'h33][4];	// fetch-target-queue.scala:143:21
        ram_0_ras_top = {_RANDOM[8'h33][31:6], _RANDOM[8'h34][13:0]};	// fetch-target-queue.scala:143:21
        ram_0_ras_idx = _RANDOM[8'h34][18:14];	// fetch-target-queue.scala:143:21
        ram_0_start_bank = _RANDOM[8'h34][19];	// fetch-target-queue.scala:143:21
        ram_1_cfi_idx_valid = _RANDOM[8'h34][20];	// fetch-target-queue.scala:143:21
        ram_1_cfi_idx_bits = _RANDOM[8'h34][23:21];	// fetch-target-queue.scala:143:21
        ram_1_cfi_taken = _RANDOM[8'h34][24];	// fetch-target-queue.scala:143:21
        ram_1_cfi_mispredicted = _RANDOM[8'h34][25];	// fetch-target-queue.scala:143:21
        ram_1_cfi_type = _RANDOM[8'h34][28:26];	// fetch-target-queue.scala:143:21
        ram_1_br_mask = {_RANDOM[8'h34][31:29], _RANDOM[8'h35][4:0]};	// fetch-target-queue.scala:143:21
        ram_1_cfi_is_call = _RANDOM[8'h35][5];	// fetch-target-queue.scala:143:21
        ram_1_cfi_is_ret = _RANDOM[8'h35][6];	// fetch-target-queue.scala:143:21
        ram_1_ras_top = {_RANDOM[8'h35][31:8], _RANDOM[8'h36][15:0]};	// fetch-target-queue.scala:143:21
        ram_1_ras_idx = _RANDOM[8'h36][20:16];	// fetch-target-queue.scala:143:21
        ram_1_start_bank = _RANDOM[8'h36][21];	// fetch-target-queue.scala:143:21
        ram_2_cfi_idx_valid = _RANDOM[8'h36][22];	// fetch-target-queue.scala:143:21
        ram_2_cfi_idx_bits = _RANDOM[8'h36][25:23];	// fetch-target-queue.scala:143:21
        ram_2_cfi_taken = _RANDOM[8'h36][26];	// fetch-target-queue.scala:143:21
        ram_2_cfi_mispredicted = _RANDOM[8'h36][27];	// fetch-target-queue.scala:143:21
        ram_2_cfi_type = _RANDOM[8'h36][30:28];	// fetch-target-queue.scala:143:21
        ram_2_br_mask = {_RANDOM[8'h36][31], _RANDOM[8'h37][6:0]};	// fetch-target-queue.scala:143:21
        ram_2_cfi_is_call = _RANDOM[8'h37][7];	// fetch-target-queue.scala:143:21
        ram_2_cfi_is_ret = _RANDOM[8'h37][8];	// fetch-target-queue.scala:143:21
        ram_2_ras_top = {_RANDOM[8'h37][31:10], _RANDOM[8'h38][17:0]};	// fetch-target-queue.scala:143:21
        ram_2_ras_idx = _RANDOM[8'h38][22:18];	// fetch-target-queue.scala:143:21
        ram_2_start_bank = _RANDOM[8'h38][23];	// fetch-target-queue.scala:143:21
        ram_3_cfi_idx_valid = _RANDOM[8'h38][24];	// fetch-target-queue.scala:143:21
        ram_3_cfi_idx_bits = _RANDOM[8'h38][27:25];	// fetch-target-queue.scala:143:21
        ram_3_cfi_taken = _RANDOM[8'h38][28];	// fetch-target-queue.scala:143:21
        ram_3_cfi_mispredicted = _RANDOM[8'h38][29];	// fetch-target-queue.scala:143:21
        ram_3_cfi_type = {_RANDOM[8'h38][31:30], _RANDOM[8'h39][0]};	// fetch-target-queue.scala:143:21
        ram_3_br_mask = _RANDOM[8'h39][8:1];	// fetch-target-queue.scala:143:21
        ram_3_cfi_is_call = _RANDOM[8'h39][9];	// fetch-target-queue.scala:143:21
        ram_3_cfi_is_ret = _RANDOM[8'h39][10];	// fetch-target-queue.scala:143:21
        ram_3_ras_top = {_RANDOM[8'h39][31:12], _RANDOM[8'h3A][19:0]};	// fetch-target-queue.scala:143:21
        ram_3_ras_idx = _RANDOM[8'h3A][24:20];	// fetch-target-queue.scala:143:21
        ram_3_start_bank = _RANDOM[8'h3A][25];	// fetch-target-queue.scala:143:21
        ram_4_cfi_idx_valid = _RANDOM[8'h3A][26];	// fetch-target-queue.scala:143:21
        ram_4_cfi_idx_bits = _RANDOM[8'h3A][29:27];	// fetch-target-queue.scala:143:21
        ram_4_cfi_taken = _RANDOM[8'h3A][30];	// fetch-target-queue.scala:143:21
        ram_4_cfi_mispredicted = _RANDOM[8'h3A][31];	// fetch-target-queue.scala:143:21
        ram_4_cfi_type = _RANDOM[8'h3B][2:0];	// fetch-target-queue.scala:143:21
        ram_4_br_mask = _RANDOM[8'h3B][10:3];	// fetch-target-queue.scala:143:21
        ram_4_cfi_is_call = _RANDOM[8'h3B][11];	// fetch-target-queue.scala:143:21
        ram_4_cfi_is_ret = _RANDOM[8'h3B][12];	// fetch-target-queue.scala:143:21
        ram_4_ras_top = {_RANDOM[8'h3B][31:14], _RANDOM[8'h3C][21:0]};	// fetch-target-queue.scala:143:21
        ram_4_ras_idx = _RANDOM[8'h3C][26:22];	// fetch-target-queue.scala:143:21
        ram_4_start_bank = _RANDOM[8'h3C][27];	// fetch-target-queue.scala:143:21
        ram_5_cfi_idx_valid = _RANDOM[8'h3C][28];	// fetch-target-queue.scala:143:21
        ram_5_cfi_idx_bits = _RANDOM[8'h3C][31:29];	// fetch-target-queue.scala:143:21
        ram_5_cfi_taken = _RANDOM[8'h3D][0];	// fetch-target-queue.scala:143:21
        ram_5_cfi_mispredicted = _RANDOM[8'h3D][1];	// fetch-target-queue.scala:143:21
        ram_5_cfi_type = _RANDOM[8'h3D][4:2];	// fetch-target-queue.scala:143:21
        ram_5_br_mask = _RANDOM[8'h3D][12:5];	// fetch-target-queue.scala:143:21
        ram_5_cfi_is_call = _RANDOM[8'h3D][13];	// fetch-target-queue.scala:143:21
        ram_5_cfi_is_ret = _RANDOM[8'h3D][14];	// fetch-target-queue.scala:143:21
        ram_5_ras_top = {_RANDOM[8'h3D][31:16], _RANDOM[8'h3E][23:0]};	// fetch-target-queue.scala:143:21
        ram_5_ras_idx = _RANDOM[8'h3E][28:24];	// fetch-target-queue.scala:143:21
        ram_5_start_bank = _RANDOM[8'h3E][29];	// fetch-target-queue.scala:143:21
        ram_6_cfi_idx_valid = _RANDOM[8'h3E][30];	// fetch-target-queue.scala:143:21
        ram_6_cfi_idx_bits = {_RANDOM[8'h3E][31], _RANDOM[8'h3F][1:0]};	// fetch-target-queue.scala:143:21
        ram_6_cfi_taken = _RANDOM[8'h3F][2];	// fetch-target-queue.scala:143:21
        ram_6_cfi_mispredicted = _RANDOM[8'h3F][3];	// fetch-target-queue.scala:143:21
        ram_6_cfi_type = _RANDOM[8'h3F][6:4];	// fetch-target-queue.scala:143:21
        ram_6_br_mask = _RANDOM[8'h3F][14:7];	// fetch-target-queue.scala:143:21
        ram_6_cfi_is_call = _RANDOM[8'h3F][15];	// fetch-target-queue.scala:143:21
        ram_6_cfi_is_ret = _RANDOM[8'h3F][16];	// fetch-target-queue.scala:143:21
        ram_6_ras_top = {_RANDOM[8'h3F][31:18], _RANDOM[8'h40][25:0]};	// fetch-target-queue.scala:143:21
        ram_6_ras_idx = _RANDOM[8'h40][30:26];	// fetch-target-queue.scala:143:21
        ram_6_start_bank = _RANDOM[8'h40][31];	// fetch-target-queue.scala:143:21
        ram_7_cfi_idx_valid = _RANDOM[8'h41][0];	// fetch-target-queue.scala:143:21
        ram_7_cfi_idx_bits = _RANDOM[8'h41][3:1];	// fetch-target-queue.scala:143:21
        ram_7_cfi_taken = _RANDOM[8'h41][4];	// fetch-target-queue.scala:143:21
        ram_7_cfi_mispredicted = _RANDOM[8'h41][5];	// fetch-target-queue.scala:143:21
        ram_7_cfi_type = _RANDOM[8'h41][8:6];	// fetch-target-queue.scala:143:21
        ram_7_br_mask = _RANDOM[8'h41][16:9];	// fetch-target-queue.scala:143:21
        ram_7_cfi_is_call = _RANDOM[8'h41][17];	// fetch-target-queue.scala:143:21
        ram_7_cfi_is_ret = _RANDOM[8'h41][18];	// fetch-target-queue.scala:143:21
        ram_7_ras_top = {_RANDOM[8'h41][31:20], _RANDOM[8'h42][27:0]};	// fetch-target-queue.scala:143:21
        ram_7_ras_idx = {_RANDOM[8'h42][31:28], _RANDOM[8'h43][0]};	// fetch-target-queue.scala:143:21
        ram_7_start_bank = _RANDOM[8'h43][1];	// fetch-target-queue.scala:143:21
        ram_8_cfi_idx_valid = _RANDOM[8'h43][2];	// fetch-target-queue.scala:143:21
        ram_8_cfi_idx_bits = _RANDOM[8'h43][5:3];	// fetch-target-queue.scala:143:21
        ram_8_cfi_taken = _RANDOM[8'h43][6];	// fetch-target-queue.scala:143:21
        ram_8_cfi_mispredicted = _RANDOM[8'h43][7];	// fetch-target-queue.scala:143:21
        ram_8_cfi_type = _RANDOM[8'h43][10:8];	// fetch-target-queue.scala:143:21
        ram_8_br_mask = _RANDOM[8'h43][18:11];	// fetch-target-queue.scala:143:21
        ram_8_cfi_is_call = _RANDOM[8'h43][19];	// fetch-target-queue.scala:143:21
        ram_8_cfi_is_ret = _RANDOM[8'h43][20];	// fetch-target-queue.scala:143:21
        ram_8_ras_top = {_RANDOM[8'h43][31:22], _RANDOM[8'h44][29:0]};	// fetch-target-queue.scala:143:21
        ram_8_ras_idx = {_RANDOM[8'h44][31:30], _RANDOM[8'h45][2:0]};	// fetch-target-queue.scala:143:21
        ram_8_start_bank = _RANDOM[8'h45][3];	// fetch-target-queue.scala:143:21
        ram_9_cfi_idx_valid = _RANDOM[8'h45][4];	// fetch-target-queue.scala:143:21
        ram_9_cfi_idx_bits = _RANDOM[8'h45][7:5];	// fetch-target-queue.scala:143:21
        ram_9_cfi_taken = _RANDOM[8'h45][8];	// fetch-target-queue.scala:143:21
        ram_9_cfi_mispredicted = _RANDOM[8'h45][9];	// fetch-target-queue.scala:143:21
        ram_9_cfi_type = _RANDOM[8'h45][12:10];	// fetch-target-queue.scala:143:21
        ram_9_br_mask = _RANDOM[8'h45][20:13];	// fetch-target-queue.scala:143:21
        ram_9_cfi_is_call = _RANDOM[8'h45][21];	// fetch-target-queue.scala:143:21
        ram_9_cfi_is_ret = _RANDOM[8'h45][22];	// fetch-target-queue.scala:143:21
        ram_9_ras_top = {_RANDOM[8'h45][31:24], _RANDOM[8'h46]};	// fetch-target-queue.scala:143:21
        ram_9_ras_idx = _RANDOM[8'h47][4:0];	// fetch-target-queue.scala:143:21
        ram_9_start_bank = _RANDOM[8'h47][5];	// fetch-target-queue.scala:143:21
        ram_10_cfi_idx_valid = _RANDOM[8'h47][6];	// fetch-target-queue.scala:143:21
        ram_10_cfi_idx_bits = _RANDOM[8'h47][9:7];	// fetch-target-queue.scala:143:21
        ram_10_cfi_taken = _RANDOM[8'h47][10];	// fetch-target-queue.scala:143:21
        ram_10_cfi_mispredicted = _RANDOM[8'h47][11];	// fetch-target-queue.scala:143:21
        ram_10_cfi_type = _RANDOM[8'h47][14:12];	// fetch-target-queue.scala:143:21
        ram_10_br_mask = _RANDOM[8'h47][22:15];	// fetch-target-queue.scala:143:21
        ram_10_cfi_is_call = _RANDOM[8'h47][23];	// fetch-target-queue.scala:143:21
        ram_10_cfi_is_ret = _RANDOM[8'h47][24];	// fetch-target-queue.scala:143:21
        ram_10_ras_top = {_RANDOM[8'h47][31:26], _RANDOM[8'h48], _RANDOM[8'h49][1:0]};	// fetch-target-queue.scala:143:21
        ram_10_ras_idx = _RANDOM[8'h49][6:2];	// fetch-target-queue.scala:143:21
        ram_10_start_bank = _RANDOM[8'h49][7];	// fetch-target-queue.scala:143:21
        ram_11_cfi_idx_valid = _RANDOM[8'h49][8];	// fetch-target-queue.scala:143:21
        ram_11_cfi_idx_bits = _RANDOM[8'h49][11:9];	// fetch-target-queue.scala:143:21
        ram_11_cfi_taken = _RANDOM[8'h49][12];	// fetch-target-queue.scala:143:21
        ram_11_cfi_mispredicted = _RANDOM[8'h49][13];	// fetch-target-queue.scala:143:21
        ram_11_cfi_type = _RANDOM[8'h49][16:14];	// fetch-target-queue.scala:143:21
        ram_11_br_mask = _RANDOM[8'h49][24:17];	// fetch-target-queue.scala:143:21
        ram_11_cfi_is_call = _RANDOM[8'h49][25];	// fetch-target-queue.scala:143:21
        ram_11_cfi_is_ret = _RANDOM[8'h49][26];	// fetch-target-queue.scala:143:21
        ram_11_ras_top = {_RANDOM[8'h49][31:28], _RANDOM[8'h4A], _RANDOM[8'h4B][3:0]};	// fetch-target-queue.scala:143:21
        ram_11_ras_idx = _RANDOM[8'h4B][8:4];	// fetch-target-queue.scala:143:21
        ram_11_start_bank = _RANDOM[8'h4B][9];	// fetch-target-queue.scala:143:21
        ram_12_cfi_idx_valid = _RANDOM[8'h4B][10];	// fetch-target-queue.scala:143:21
        ram_12_cfi_idx_bits = _RANDOM[8'h4B][13:11];	// fetch-target-queue.scala:143:21
        ram_12_cfi_taken = _RANDOM[8'h4B][14];	// fetch-target-queue.scala:143:21
        ram_12_cfi_mispredicted = _RANDOM[8'h4B][15];	// fetch-target-queue.scala:143:21
        ram_12_cfi_type = _RANDOM[8'h4B][18:16];	// fetch-target-queue.scala:143:21
        ram_12_br_mask = _RANDOM[8'h4B][26:19];	// fetch-target-queue.scala:143:21
        ram_12_cfi_is_call = _RANDOM[8'h4B][27];	// fetch-target-queue.scala:143:21
        ram_12_cfi_is_ret = _RANDOM[8'h4B][28];	// fetch-target-queue.scala:143:21
        ram_12_ras_top = {_RANDOM[8'h4B][31:30], _RANDOM[8'h4C], _RANDOM[8'h4D][5:0]};	// fetch-target-queue.scala:143:21
        ram_12_ras_idx = _RANDOM[8'h4D][10:6];	// fetch-target-queue.scala:143:21
        ram_12_start_bank = _RANDOM[8'h4D][11];	// fetch-target-queue.scala:143:21
        ram_13_cfi_idx_valid = _RANDOM[8'h4D][12];	// fetch-target-queue.scala:143:21
        ram_13_cfi_idx_bits = _RANDOM[8'h4D][15:13];	// fetch-target-queue.scala:143:21
        ram_13_cfi_taken = _RANDOM[8'h4D][16];	// fetch-target-queue.scala:143:21
        ram_13_cfi_mispredicted = _RANDOM[8'h4D][17];	// fetch-target-queue.scala:143:21
        ram_13_cfi_type = _RANDOM[8'h4D][20:18];	// fetch-target-queue.scala:143:21
        ram_13_br_mask = _RANDOM[8'h4D][28:21];	// fetch-target-queue.scala:143:21
        ram_13_cfi_is_call = _RANDOM[8'h4D][29];	// fetch-target-queue.scala:143:21
        ram_13_cfi_is_ret = _RANDOM[8'h4D][30];	// fetch-target-queue.scala:143:21
        ram_13_ras_top = {_RANDOM[8'h4E], _RANDOM[8'h4F][7:0]};	// fetch-target-queue.scala:143:21
        ram_13_ras_idx = _RANDOM[8'h4F][12:8];	// fetch-target-queue.scala:143:21
        ram_13_start_bank = _RANDOM[8'h4F][13];	// fetch-target-queue.scala:143:21
        ram_14_cfi_idx_valid = _RANDOM[8'h4F][14];	// fetch-target-queue.scala:143:21
        ram_14_cfi_idx_bits = _RANDOM[8'h4F][17:15];	// fetch-target-queue.scala:143:21
        ram_14_cfi_taken = _RANDOM[8'h4F][18];	// fetch-target-queue.scala:143:21
        ram_14_cfi_mispredicted = _RANDOM[8'h4F][19];	// fetch-target-queue.scala:143:21
        ram_14_cfi_type = _RANDOM[8'h4F][22:20];	// fetch-target-queue.scala:143:21
        ram_14_br_mask = _RANDOM[8'h4F][30:23];	// fetch-target-queue.scala:143:21
        ram_14_cfi_is_call = _RANDOM[8'h4F][31];	// fetch-target-queue.scala:143:21
        ram_14_cfi_is_ret = _RANDOM[8'h50][0];	// fetch-target-queue.scala:143:21
        ram_14_ras_top = {_RANDOM[8'h50][31:2], _RANDOM[8'h51][9:0]};	// fetch-target-queue.scala:143:21
        ram_14_ras_idx = _RANDOM[8'h51][14:10];	// fetch-target-queue.scala:143:21
        ram_14_start_bank = _RANDOM[8'h51][15];	// fetch-target-queue.scala:143:21
        ram_15_cfi_idx_valid = _RANDOM[8'h51][16];	// fetch-target-queue.scala:143:21
        ram_15_cfi_idx_bits = _RANDOM[8'h51][19:17];	// fetch-target-queue.scala:143:21
        ram_15_cfi_taken = _RANDOM[8'h51][20];	// fetch-target-queue.scala:143:21
        ram_15_cfi_mispredicted = _RANDOM[8'h51][21];	// fetch-target-queue.scala:143:21
        ram_15_cfi_type = _RANDOM[8'h51][24:22];	// fetch-target-queue.scala:143:21
        ram_15_br_mask = {_RANDOM[8'h51][31:25], _RANDOM[8'h52][0]};	// fetch-target-queue.scala:143:21
        ram_15_cfi_is_call = _RANDOM[8'h52][1];	// fetch-target-queue.scala:143:21
        ram_15_cfi_is_ret = _RANDOM[8'h52][2];	// fetch-target-queue.scala:143:21
        ram_15_ras_top = {_RANDOM[8'h52][31:4], _RANDOM[8'h53][11:0]};	// fetch-target-queue.scala:143:21
        ram_15_ras_idx = _RANDOM[8'h53][16:12];	// fetch-target-queue.scala:143:21
        ram_15_start_bank = _RANDOM[8'h53][17];	// fetch-target-queue.scala:143:21
        ram_16_cfi_idx_valid = _RANDOM[8'h53][18];	// fetch-target-queue.scala:143:21
        ram_16_cfi_idx_bits = _RANDOM[8'h53][21:19];	// fetch-target-queue.scala:143:21
        ram_16_cfi_taken = _RANDOM[8'h53][22];	// fetch-target-queue.scala:143:21
        ram_16_cfi_mispredicted = _RANDOM[8'h53][23];	// fetch-target-queue.scala:143:21
        ram_16_cfi_type = _RANDOM[8'h53][26:24];	// fetch-target-queue.scala:143:21
        ram_16_br_mask = {_RANDOM[8'h53][31:27], _RANDOM[8'h54][2:0]};	// fetch-target-queue.scala:143:21
        ram_16_cfi_is_call = _RANDOM[8'h54][3];	// fetch-target-queue.scala:143:21
        ram_16_cfi_is_ret = _RANDOM[8'h54][4];	// fetch-target-queue.scala:143:21
        ram_16_ras_top = {_RANDOM[8'h54][31:6], _RANDOM[8'h55][13:0]};	// fetch-target-queue.scala:143:21
        ram_16_ras_idx = _RANDOM[8'h55][18:14];	// fetch-target-queue.scala:143:21
        ram_16_start_bank = _RANDOM[8'h55][19];	// fetch-target-queue.scala:143:21
        ram_17_cfi_idx_valid = _RANDOM[8'h55][20];	// fetch-target-queue.scala:143:21
        ram_17_cfi_idx_bits = _RANDOM[8'h55][23:21];	// fetch-target-queue.scala:143:21
        ram_17_cfi_taken = _RANDOM[8'h55][24];	// fetch-target-queue.scala:143:21
        ram_17_cfi_mispredicted = _RANDOM[8'h55][25];	// fetch-target-queue.scala:143:21
        ram_17_cfi_type = _RANDOM[8'h55][28:26];	// fetch-target-queue.scala:143:21
        ram_17_br_mask = {_RANDOM[8'h55][31:29], _RANDOM[8'h56][4:0]};	// fetch-target-queue.scala:143:21
        ram_17_cfi_is_call = _RANDOM[8'h56][5];	// fetch-target-queue.scala:143:21
        ram_17_cfi_is_ret = _RANDOM[8'h56][6];	// fetch-target-queue.scala:143:21
        ram_17_ras_top = {_RANDOM[8'h56][31:8], _RANDOM[8'h57][15:0]};	// fetch-target-queue.scala:143:21
        ram_17_ras_idx = _RANDOM[8'h57][20:16];	// fetch-target-queue.scala:143:21
        ram_17_start_bank = _RANDOM[8'h57][21];	// fetch-target-queue.scala:143:21
        ram_18_cfi_idx_valid = _RANDOM[8'h57][22];	// fetch-target-queue.scala:143:21
        ram_18_cfi_idx_bits = _RANDOM[8'h57][25:23];	// fetch-target-queue.scala:143:21
        ram_18_cfi_taken = _RANDOM[8'h57][26];	// fetch-target-queue.scala:143:21
        ram_18_cfi_mispredicted = _RANDOM[8'h57][27];	// fetch-target-queue.scala:143:21
        ram_18_cfi_type = _RANDOM[8'h57][30:28];	// fetch-target-queue.scala:143:21
        ram_18_br_mask = {_RANDOM[8'h57][31], _RANDOM[8'h58][6:0]};	// fetch-target-queue.scala:143:21
        ram_18_cfi_is_call = _RANDOM[8'h58][7];	// fetch-target-queue.scala:143:21
        ram_18_cfi_is_ret = _RANDOM[8'h58][8];	// fetch-target-queue.scala:143:21
        ram_18_ras_top = {_RANDOM[8'h58][31:10], _RANDOM[8'h59][17:0]};	// fetch-target-queue.scala:143:21
        ram_18_ras_idx = _RANDOM[8'h59][22:18];	// fetch-target-queue.scala:143:21
        ram_18_start_bank = _RANDOM[8'h59][23];	// fetch-target-queue.scala:143:21
        ram_19_cfi_idx_valid = _RANDOM[8'h59][24];	// fetch-target-queue.scala:143:21
        ram_19_cfi_idx_bits = _RANDOM[8'h59][27:25];	// fetch-target-queue.scala:143:21
        ram_19_cfi_taken = _RANDOM[8'h59][28];	// fetch-target-queue.scala:143:21
        ram_19_cfi_mispredicted = _RANDOM[8'h59][29];	// fetch-target-queue.scala:143:21
        ram_19_cfi_type = {_RANDOM[8'h59][31:30], _RANDOM[8'h5A][0]};	// fetch-target-queue.scala:143:21
        ram_19_br_mask = _RANDOM[8'h5A][8:1];	// fetch-target-queue.scala:143:21
        ram_19_cfi_is_call = _RANDOM[8'h5A][9];	// fetch-target-queue.scala:143:21
        ram_19_cfi_is_ret = _RANDOM[8'h5A][10];	// fetch-target-queue.scala:143:21
        ram_19_ras_top = {_RANDOM[8'h5A][31:12], _RANDOM[8'h5B][19:0]};	// fetch-target-queue.scala:143:21
        ram_19_ras_idx = _RANDOM[8'h5B][24:20];	// fetch-target-queue.scala:143:21
        ram_19_start_bank = _RANDOM[8'h5B][25];	// fetch-target-queue.scala:143:21
        ram_20_cfi_idx_valid = _RANDOM[8'h5B][26];	// fetch-target-queue.scala:143:21
        ram_20_cfi_idx_bits = _RANDOM[8'h5B][29:27];	// fetch-target-queue.scala:143:21
        ram_20_cfi_taken = _RANDOM[8'h5B][30];	// fetch-target-queue.scala:143:21
        ram_20_cfi_mispredicted = _RANDOM[8'h5B][31];	// fetch-target-queue.scala:143:21
        ram_20_cfi_type = _RANDOM[8'h5C][2:0];	// fetch-target-queue.scala:143:21
        ram_20_br_mask = _RANDOM[8'h5C][10:3];	// fetch-target-queue.scala:143:21
        ram_20_cfi_is_call = _RANDOM[8'h5C][11];	// fetch-target-queue.scala:143:21
        ram_20_cfi_is_ret = _RANDOM[8'h5C][12];	// fetch-target-queue.scala:143:21
        ram_20_ras_top = {_RANDOM[8'h5C][31:14], _RANDOM[8'h5D][21:0]};	// fetch-target-queue.scala:143:21
        ram_20_ras_idx = _RANDOM[8'h5D][26:22];	// fetch-target-queue.scala:143:21
        ram_20_start_bank = _RANDOM[8'h5D][27];	// fetch-target-queue.scala:143:21
        ram_21_cfi_idx_valid = _RANDOM[8'h5D][28];	// fetch-target-queue.scala:143:21
        ram_21_cfi_idx_bits = _RANDOM[8'h5D][31:29];	// fetch-target-queue.scala:143:21
        ram_21_cfi_taken = _RANDOM[8'h5E][0];	// fetch-target-queue.scala:143:21
        ram_21_cfi_mispredicted = _RANDOM[8'h5E][1];	// fetch-target-queue.scala:143:21
        ram_21_cfi_type = _RANDOM[8'h5E][4:2];	// fetch-target-queue.scala:143:21
        ram_21_br_mask = _RANDOM[8'h5E][12:5];	// fetch-target-queue.scala:143:21
        ram_21_cfi_is_call = _RANDOM[8'h5E][13];	// fetch-target-queue.scala:143:21
        ram_21_cfi_is_ret = _RANDOM[8'h5E][14];	// fetch-target-queue.scala:143:21
        ram_21_ras_top = {_RANDOM[8'h5E][31:16], _RANDOM[8'h5F][23:0]};	// fetch-target-queue.scala:143:21
        ram_21_ras_idx = _RANDOM[8'h5F][28:24];	// fetch-target-queue.scala:143:21
        ram_21_start_bank = _RANDOM[8'h5F][29];	// fetch-target-queue.scala:143:21
        ram_22_cfi_idx_valid = _RANDOM[8'h5F][30];	// fetch-target-queue.scala:143:21
        ram_22_cfi_idx_bits = {_RANDOM[8'h5F][31], _RANDOM[8'h60][1:0]};	// fetch-target-queue.scala:143:21
        ram_22_cfi_taken = _RANDOM[8'h60][2];	// fetch-target-queue.scala:143:21
        ram_22_cfi_mispredicted = _RANDOM[8'h60][3];	// fetch-target-queue.scala:143:21
        ram_22_cfi_type = _RANDOM[8'h60][6:4];	// fetch-target-queue.scala:143:21
        ram_22_br_mask = _RANDOM[8'h60][14:7];	// fetch-target-queue.scala:143:21
        ram_22_cfi_is_call = _RANDOM[8'h60][15];	// fetch-target-queue.scala:143:21
        ram_22_cfi_is_ret = _RANDOM[8'h60][16];	// fetch-target-queue.scala:143:21
        ram_22_ras_top = {_RANDOM[8'h60][31:18], _RANDOM[8'h61][25:0]};	// fetch-target-queue.scala:143:21
        ram_22_ras_idx = _RANDOM[8'h61][30:26];	// fetch-target-queue.scala:143:21
        ram_22_start_bank = _RANDOM[8'h61][31];	// fetch-target-queue.scala:143:21
        ram_23_cfi_idx_valid = _RANDOM[8'h62][0];	// fetch-target-queue.scala:143:21
        ram_23_cfi_idx_bits = _RANDOM[8'h62][3:1];	// fetch-target-queue.scala:143:21
        ram_23_cfi_taken = _RANDOM[8'h62][4];	// fetch-target-queue.scala:143:21
        ram_23_cfi_mispredicted = _RANDOM[8'h62][5];	// fetch-target-queue.scala:143:21
        ram_23_cfi_type = _RANDOM[8'h62][8:6];	// fetch-target-queue.scala:143:21
        ram_23_br_mask = _RANDOM[8'h62][16:9];	// fetch-target-queue.scala:143:21
        ram_23_cfi_is_call = _RANDOM[8'h62][17];	// fetch-target-queue.scala:143:21
        ram_23_cfi_is_ret = _RANDOM[8'h62][18];	// fetch-target-queue.scala:143:21
        ram_23_ras_top = {_RANDOM[8'h62][31:20], _RANDOM[8'h63][27:0]};	// fetch-target-queue.scala:143:21
        ram_23_ras_idx = {_RANDOM[8'h63][31:28], _RANDOM[8'h64][0]};	// fetch-target-queue.scala:143:21
        ram_23_start_bank = _RANDOM[8'h64][1];	// fetch-target-queue.scala:143:21
        ram_24_cfi_idx_valid = _RANDOM[8'h64][2];	// fetch-target-queue.scala:143:21
        ram_24_cfi_idx_bits = _RANDOM[8'h64][5:3];	// fetch-target-queue.scala:143:21
        ram_24_cfi_taken = _RANDOM[8'h64][6];	// fetch-target-queue.scala:143:21
        ram_24_cfi_mispredicted = _RANDOM[8'h64][7];	// fetch-target-queue.scala:143:21
        ram_24_cfi_type = _RANDOM[8'h64][10:8];	// fetch-target-queue.scala:143:21
        ram_24_br_mask = _RANDOM[8'h64][18:11];	// fetch-target-queue.scala:143:21
        ram_24_cfi_is_call = _RANDOM[8'h64][19];	// fetch-target-queue.scala:143:21
        ram_24_cfi_is_ret = _RANDOM[8'h64][20];	// fetch-target-queue.scala:143:21
        ram_24_ras_top = {_RANDOM[8'h64][31:22], _RANDOM[8'h65][29:0]};	// fetch-target-queue.scala:143:21
        ram_24_ras_idx = {_RANDOM[8'h65][31:30], _RANDOM[8'h66][2:0]};	// fetch-target-queue.scala:143:21
        ram_24_start_bank = _RANDOM[8'h66][3];	// fetch-target-queue.scala:143:21
        ram_25_cfi_idx_valid = _RANDOM[8'h66][4];	// fetch-target-queue.scala:143:21
        ram_25_cfi_idx_bits = _RANDOM[8'h66][7:5];	// fetch-target-queue.scala:143:21
        ram_25_cfi_taken = _RANDOM[8'h66][8];	// fetch-target-queue.scala:143:21
        ram_25_cfi_mispredicted = _RANDOM[8'h66][9];	// fetch-target-queue.scala:143:21
        ram_25_cfi_type = _RANDOM[8'h66][12:10];	// fetch-target-queue.scala:143:21
        ram_25_br_mask = _RANDOM[8'h66][20:13];	// fetch-target-queue.scala:143:21
        ram_25_cfi_is_call = _RANDOM[8'h66][21];	// fetch-target-queue.scala:143:21
        ram_25_cfi_is_ret = _RANDOM[8'h66][22];	// fetch-target-queue.scala:143:21
        ram_25_ras_top = {_RANDOM[8'h66][31:24], _RANDOM[8'h67]};	// fetch-target-queue.scala:143:21
        ram_25_ras_idx = _RANDOM[8'h68][4:0];	// fetch-target-queue.scala:143:21
        ram_25_start_bank = _RANDOM[8'h68][5];	// fetch-target-queue.scala:143:21
        ram_26_cfi_idx_valid = _RANDOM[8'h68][6];	// fetch-target-queue.scala:143:21
        ram_26_cfi_idx_bits = _RANDOM[8'h68][9:7];	// fetch-target-queue.scala:143:21
        ram_26_cfi_taken = _RANDOM[8'h68][10];	// fetch-target-queue.scala:143:21
        ram_26_cfi_mispredicted = _RANDOM[8'h68][11];	// fetch-target-queue.scala:143:21
        ram_26_cfi_type = _RANDOM[8'h68][14:12];	// fetch-target-queue.scala:143:21
        ram_26_br_mask = _RANDOM[8'h68][22:15];	// fetch-target-queue.scala:143:21
        ram_26_cfi_is_call = _RANDOM[8'h68][23];	// fetch-target-queue.scala:143:21
        ram_26_cfi_is_ret = _RANDOM[8'h68][24];	// fetch-target-queue.scala:143:21
        ram_26_ras_top = {_RANDOM[8'h68][31:26], _RANDOM[8'h69], _RANDOM[8'h6A][1:0]};	// fetch-target-queue.scala:143:21
        ram_26_ras_idx = _RANDOM[8'h6A][6:2];	// fetch-target-queue.scala:143:21
        ram_26_start_bank = _RANDOM[8'h6A][7];	// fetch-target-queue.scala:143:21
        ram_27_cfi_idx_valid = _RANDOM[8'h6A][8];	// fetch-target-queue.scala:143:21
        ram_27_cfi_idx_bits = _RANDOM[8'h6A][11:9];	// fetch-target-queue.scala:143:21
        ram_27_cfi_taken = _RANDOM[8'h6A][12];	// fetch-target-queue.scala:143:21
        ram_27_cfi_mispredicted = _RANDOM[8'h6A][13];	// fetch-target-queue.scala:143:21
        ram_27_cfi_type = _RANDOM[8'h6A][16:14];	// fetch-target-queue.scala:143:21
        ram_27_br_mask = _RANDOM[8'h6A][24:17];	// fetch-target-queue.scala:143:21
        ram_27_cfi_is_call = _RANDOM[8'h6A][25];	// fetch-target-queue.scala:143:21
        ram_27_cfi_is_ret = _RANDOM[8'h6A][26];	// fetch-target-queue.scala:143:21
        ram_27_ras_top = {_RANDOM[8'h6A][31:28], _RANDOM[8'h6B], _RANDOM[8'h6C][3:0]};	// fetch-target-queue.scala:143:21
        ram_27_ras_idx = _RANDOM[8'h6C][8:4];	// fetch-target-queue.scala:143:21
        ram_27_start_bank = _RANDOM[8'h6C][9];	// fetch-target-queue.scala:143:21
        ram_28_cfi_idx_valid = _RANDOM[8'h6C][10];	// fetch-target-queue.scala:143:21
        ram_28_cfi_idx_bits = _RANDOM[8'h6C][13:11];	// fetch-target-queue.scala:143:21
        ram_28_cfi_taken = _RANDOM[8'h6C][14];	// fetch-target-queue.scala:143:21
        ram_28_cfi_mispredicted = _RANDOM[8'h6C][15];	// fetch-target-queue.scala:143:21
        ram_28_cfi_type = _RANDOM[8'h6C][18:16];	// fetch-target-queue.scala:143:21
        ram_28_br_mask = _RANDOM[8'h6C][26:19];	// fetch-target-queue.scala:143:21
        ram_28_cfi_is_call = _RANDOM[8'h6C][27];	// fetch-target-queue.scala:143:21
        ram_28_cfi_is_ret = _RANDOM[8'h6C][28];	// fetch-target-queue.scala:143:21
        ram_28_ras_top = {_RANDOM[8'h6C][31:30], _RANDOM[8'h6D], _RANDOM[8'h6E][5:0]};	// fetch-target-queue.scala:143:21
        ram_28_ras_idx = _RANDOM[8'h6E][10:6];	// fetch-target-queue.scala:143:21
        ram_28_start_bank = _RANDOM[8'h6E][11];	// fetch-target-queue.scala:143:21
        ram_29_cfi_idx_valid = _RANDOM[8'h6E][12];	// fetch-target-queue.scala:143:21
        ram_29_cfi_idx_bits = _RANDOM[8'h6E][15:13];	// fetch-target-queue.scala:143:21
        ram_29_cfi_taken = _RANDOM[8'h6E][16];	// fetch-target-queue.scala:143:21
        ram_29_cfi_mispredicted = _RANDOM[8'h6E][17];	// fetch-target-queue.scala:143:21
        ram_29_cfi_type = _RANDOM[8'h6E][20:18];	// fetch-target-queue.scala:143:21
        ram_29_br_mask = _RANDOM[8'h6E][28:21];	// fetch-target-queue.scala:143:21
        ram_29_cfi_is_call = _RANDOM[8'h6E][29];	// fetch-target-queue.scala:143:21
        ram_29_cfi_is_ret = _RANDOM[8'h6E][30];	// fetch-target-queue.scala:143:21
        ram_29_ras_top = {_RANDOM[8'h6F], _RANDOM[8'h70][7:0]};	// fetch-target-queue.scala:143:21
        ram_29_ras_idx = _RANDOM[8'h70][12:8];	// fetch-target-queue.scala:143:21
        ram_29_start_bank = _RANDOM[8'h70][13];	// fetch-target-queue.scala:143:21
        ram_30_cfi_idx_valid = _RANDOM[8'h70][14];	// fetch-target-queue.scala:143:21
        ram_30_cfi_idx_bits = _RANDOM[8'h70][17:15];	// fetch-target-queue.scala:143:21
        ram_30_cfi_taken = _RANDOM[8'h70][18];	// fetch-target-queue.scala:143:21
        ram_30_cfi_mispredicted = _RANDOM[8'h70][19];	// fetch-target-queue.scala:143:21
        ram_30_cfi_type = _RANDOM[8'h70][22:20];	// fetch-target-queue.scala:143:21
        ram_30_br_mask = _RANDOM[8'h70][30:23];	// fetch-target-queue.scala:143:21
        ram_30_cfi_is_call = _RANDOM[8'h70][31];	// fetch-target-queue.scala:143:21
        ram_30_cfi_is_ret = _RANDOM[8'h71][0];	// fetch-target-queue.scala:143:21
        ram_30_ras_top = {_RANDOM[8'h71][31:2], _RANDOM[8'h72][9:0]};	// fetch-target-queue.scala:143:21
        ram_30_ras_idx = _RANDOM[8'h72][14:10];	// fetch-target-queue.scala:143:21
        ram_30_start_bank = _RANDOM[8'h72][15];	// fetch-target-queue.scala:143:21
        ram_31_cfi_idx_valid = _RANDOM[8'h72][16];	// fetch-target-queue.scala:143:21
        ram_31_cfi_idx_bits = _RANDOM[8'h72][19:17];	// fetch-target-queue.scala:143:21
        ram_31_cfi_taken = _RANDOM[8'h72][20];	// fetch-target-queue.scala:143:21
        ram_31_cfi_mispredicted = _RANDOM[8'h72][21];	// fetch-target-queue.scala:143:21
        ram_31_cfi_type = _RANDOM[8'h72][24:22];	// fetch-target-queue.scala:143:21
        ram_31_br_mask = {_RANDOM[8'h72][31:25], _RANDOM[8'h73][0]};	// fetch-target-queue.scala:143:21
        ram_31_cfi_is_call = _RANDOM[8'h73][1];	// fetch-target-queue.scala:143:21
        ram_31_cfi_is_ret = _RANDOM[8'h73][2];	// fetch-target-queue.scala:143:21
        ram_31_ras_top = {_RANDOM[8'h73][31:4], _RANDOM[8'h74][11:0]};	// fetch-target-queue.scala:143:21
        ram_31_ras_idx = _RANDOM[8'h74][16:12];	// fetch-target-queue.scala:143:21
        ram_31_start_bank = _RANDOM[8'h74][17];	// fetch-target-queue.scala:143:21
        ram_32_cfi_idx_valid = _RANDOM[8'h74][18];	// fetch-target-queue.scala:143:21
        ram_32_cfi_idx_bits = _RANDOM[8'h74][21:19];	// fetch-target-queue.scala:143:21
        ram_32_cfi_taken = _RANDOM[8'h74][22];	// fetch-target-queue.scala:143:21
        ram_32_cfi_mispredicted = _RANDOM[8'h74][23];	// fetch-target-queue.scala:143:21
        ram_32_cfi_type = _RANDOM[8'h74][26:24];	// fetch-target-queue.scala:143:21
        ram_32_br_mask = {_RANDOM[8'h74][31:27], _RANDOM[8'h75][2:0]};	// fetch-target-queue.scala:143:21
        ram_32_cfi_is_call = _RANDOM[8'h75][3];	// fetch-target-queue.scala:143:21
        ram_32_cfi_is_ret = _RANDOM[8'h75][4];	// fetch-target-queue.scala:143:21
        ram_32_ras_top = {_RANDOM[8'h75][31:6], _RANDOM[8'h76][13:0]};	// fetch-target-queue.scala:143:21
        ram_32_ras_idx = _RANDOM[8'h76][18:14];	// fetch-target-queue.scala:143:21
        ram_32_start_bank = _RANDOM[8'h76][19];	// fetch-target-queue.scala:143:21
        ram_33_cfi_idx_valid = _RANDOM[8'h76][20];	// fetch-target-queue.scala:143:21
        ram_33_cfi_idx_bits = _RANDOM[8'h76][23:21];	// fetch-target-queue.scala:143:21
        ram_33_cfi_taken = _RANDOM[8'h76][24];	// fetch-target-queue.scala:143:21
        ram_33_cfi_mispredicted = _RANDOM[8'h76][25];	// fetch-target-queue.scala:143:21
        ram_33_cfi_type = _RANDOM[8'h76][28:26];	// fetch-target-queue.scala:143:21
        ram_33_br_mask = {_RANDOM[8'h76][31:29], _RANDOM[8'h77][4:0]};	// fetch-target-queue.scala:143:21
        ram_33_cfi_is_call = _RANDOM[8'h77][5];	// fetch-target-queue.scala:143:21
        ram_33_cfi_is_ret = _RANDOM[8'h77][6];	// fetch-target-queue.scala:143:21
        ram_33_ras_top = {_RANDOM[8'h77][31:8], _RANDOM[8'h78][15:0]};	// fetch-target-queue.scala:143:21
        ram_33_ras_idx = _RANDOM[8'h78][20:16];	// fetch-target-queue.scala:143:21
        ram_33_start_bank = _RANDOM[8'h78][21];	// fetch-target-queue.scala:143:21
        ram_34_cfi_idx_valid = _RANDOM[8'h78][22];	// fetch-target-queue.scala:143:21
        ram_34_cfi_idx_bits = _RANDOM[8'h78][25:23];	// fetch-target-queue.scala:143:21
        ram_34_cfi_taken = _RANDOM[8'h78][26];	// fetch-target-queue.scala:143:21
        ram_34_cfi_mispredicted = _RANDOM[8'h78][27];	// fetch-target-queue.scala:143:21
        ram_34_cfi_type = _RANDOM[8'h78][30:28];	// fetch-target-queue.scala:143:21
        ram_34_br_mask = {_RANDOM[8'h78][31], _RANDOM[8'h79][6:0]};	// fetch-target-queue.scala:143:21
        ram_34_cfi_is_call = _RANDOM[8'h79][7];	// fetch-target-queue.scala:143:21
        ram_34_cfi_is_ret = _RANDOM[8'h79][8];	// fetch-target-queue.scala:143:21
        ram_34_ras_top = {_RANDOM[8'h79][31:10], _RANDOM[8'h7A][17:0]};	// fetch-target-queue.scala:143:21
        ram_34_ras_idx = _RANDOM[8'h7A][22:18];	// fetch-target-queue.scala:143:21
        ram_34_start_bank = _RANDOM[8'h7A][23];	// fetch-target-queue.scala:143:21
        ram_35_cfi_idx_valid = _RANDOM[8'h7A][24];	// fetch-target-queue.scala:143:21
        ram_35_cfi_idx_bits = _RANDOM[8'h7A][27:25];	// fetch-target-queue.scala:143:21
        ram_35_cfi_taken = _RANDOM[8'h7A][28];	// fetch-target-queue.scala:143:21
        ram_35_cfi_mispredicted = _RANDOM[8'h7A][29];	// fetch-target-queue.scala:143:21
        ram_35_cfi_type = {_RANDOM[8'h7A][31:30], _RANDOM[8'h7B][0]};	// fetch-target-queue.scala:143:21
        ram_35_br_mask = _RANDOM[8'h7B][8:1];	// fetch-target-queue.scala:143:21
        ram_35_cfi_is_call = _RANDOM[8'h7B][9];	// fetch-target-queue.scala:143:21
        ram_35_cfi_is_ret = _RANDOM[8'h7B][10];	// fetch-target-queue.scala:143:21
        ram_35_ras_top = {_RANDOM[8'h7B][31:12], _RANDOM[8'h7C][19:0]};	// fetch-target-queue.scala:143:21
        ram_35_ras_idx = _RANDOM[8'h7C][24:20];	// fetch-target-queue.scala:143:21
        ram_35_start_bank = _RANDOM[8'h7C][25];	// fetch-target-queue.scala:143:21
        ram_36_cfi_idx_valid = _RANDOM[8'h7C][26];	// fetch-target-queue.scala:143:21
        ram_36_cfi_idx_bits = _RANDOM[8'h7C][29:27];	// fetch-target-queue.scala:143:21
        ram_36_cfi_taken = _RANDOM[8'h7C][30];	// fetch-target-queue.scala:143:21
        ram_36_cfi_mispredicted = _RANDOM[8'h7C][31];	// fetch-target-queue.scala:143:21
        ram_36_cfi_type = _RANDOM[8'h7D][2:0];	// fetch-target-queue.scala:143:21
        ram_36_br_mask = _RANDOM[8'h7D][10:3];	// fetch-target-queue.scala:143:21
        ram_36_cfi_is_call = _RANDOM[8'h7D][11];	// fetch-target-queue.scala:143:21
        ram_36_cfi_is_ret = _RANDOM[8'h7D][12];	// fetch-target-queue.scala:143:21
        ram_36_ras_top = {_RANDOM[8'h7D][31:14], _RANDOM[8'h7E][21:0]};	// fetch-target-queue.scala:143:21
        ram_36_ras_idx = _RANDOM[8'h7E][26:22];	// fetch-target-queue.scala:143:21
        ram_36_start_bank = _RANDOM[8'h7E][27];	// fetch-target-queue.scala:143:21
        ram_37_cfi_idx_valid = _RANDOM[8'h7E][28];	// fetch-target-queue.scala:143:21
        ram_37_cfi_idx_bits = _RANDOM[8'h7E][31:29];	// fetch-target-queue.scala:143:21
        ram_37_cfi_taken = _RANDOM[8'h7F][0];	// fetch-target-queue.scala:143:21
        ram_37_cfi_mispredicted = _RANDOM[8'h7F][1];	// fetch-target-queue.scala:143:21
        ram_37_cfi_type = _RANDOM[8'h7F][4:2];	// fetch-target-queue.scala:143:21
        ram_37_br_mask = _RANDOM[8'h7F][12:5];	// fetch-target-queue.scala:143:21
        ram_37_cfi_is_call = _RANDOM[8'h7F][13];	// fetch-target-queue.scala:143:21
        ram_37_cfi_is_ret = _RANDOM[8'h7F][14];	// fetch-target-queue.scala:143:21
        ram_37_ras_top = {_RANDOM[8'h7F][31:16], _RANDOM[8'h80][23:0]};	// fetch-target-queue.scala:143:21
        ram_37_ras_idx = _RANDOM[8'h80][28:24];	// fetch-target-queue.scala:143:21
        ram_37_start_bank = _RANDOM[8'h80][29];	// fetch-target-queue.scala:143:21
        ram_38_cfi_idx_valid = _RANDOM[8'h80][30];	// fetch-target-queue.scala:143:21
        ram_38_cfi_idx_bits = {_RANDOM[8'h80][31], _RANDOM[8'h81][1:0]};	// fetch-target-queue.scala:143:21
        ram_38_cfi_taken = _RANDOM[8'h81][2];	// fetch-target-queue.scala:143:21
        ram_38_cfi_mispredicted = _RANDOM[8'h81][3];	// fetch-target-queue.scala:143:21
        ram_38_cfi_type = _RANDOM[8'h81][6:4];	// fetch-target-queue.scala:143:21
        ram_38_br_mask = _RANDOM[8'h81][14:7];	// fetch-target-queue.scala:143:21
        ram_38_cfi_is_call = _RANDOM[8'h81][15];	// fetch-target-queue.scala:143:21
        ram_38_cfi_is_ret = _RANDOM[8'h81][16];	// fetch-target-queue.scala:143:21
        ram_38_ras_top = {_RANDOM[8'h81][31:18], _RANDOM[8'h82][25:0]};	// fetch-target-queue.scala:143:21
        ram_38_ras_idx = _RANDOM[8'h82][30:26];	// fetch-target-queue.scala:143:21
        ram_38_start_bank = _RANDOM[8'h82][31];	// fetch-target-queue.scala:143:21
        ram_39_cfi_idx_valid = _RANDOM[8'h83][0];	// fetch-target-queue.scala:143:21
        ram_39_cfi_idx_bits = _RANDOM[8'h83][3:1];	// fetch-target-queue.scala:143:21
        ram_39_cfi_taken = _RANDOM[8'h83][4];	// fetch-target-queue.scala:143:21
        ram_39_cfi_mispredicted = _RANDOM[8'h83][5];	// fetch-target-queue.scala:143:21
        ram_39_cfi_type = _RANDOM[8'h83][8:6];	// fetch-target-queue.scala:143:21
        ram_39_br_mask = _RANDOM[8'h83][16:9];	// fetch-target-queue.scala:143:21
        ram_39_cfi_is_call = _RANDOM[8'h83][17];	// fetch-target-queue.scala:143:21
        ram_39_cfi_is_ret = _RANDOM[8'h83][18];	// fetch-target-queue.scala:143:21
        ram_39_ras_top = {_RANDOM[8'h83][31:20], _RANDOM[8'h84][27:0]};	// fetch-target-queue.scala:143:21
        ram_39_ras_idx = {_RANDOM[8'h84][31:28], _RANDOM[8'h85][0]};	// fetch-target-queue.scala:143:21
        ram_39_start_bank = _RANDOM[8'h85][1];	// fetch-target-queue.scala:143:21
        prev_ghist_old_history =
          {_RANDOM[8'h85][31:2], _RANDOM[8'h86], _RANDOM[8'h87][1:0]};	// fetch-target-queue.scala:143:21, :155:27
        prev_ghist_current_saw_branch_not_taken = _RANDOM[8'h87][2];	// fetch-target-queue.scala:155:27
        prev_ghist_new_saw_branch_not_taken = _RANDOM[8'h87][3];	// fetch-target-queue.scala:155:27
        prev_ghist_new_saw_branch_taken = _RANDOM[8'h87][4];	// fetch-target-queue.scala:155:27
        prev_ghist_ras_idx = _RANDOM[8'h87][9:5];	// fetch-target-queue.scala:155:27
        prev_entry_cfi_idx_valid = _RANDOM[8'h87][10];	// fetch-target-queue.scala:155:27, :156:27
        prev_entry_cfi_idx_bits = _RANDOM[8'h87][13:11];	// fetch-target-queue.scala:155:27, :156:27
        prev_entry_cfi_taken = _RANDOM[8'h87][14];	// fetch-target-queue.scala:155:27, :156:27
        prev_entry_br_mask = _RANDOM[8'h87][26:19];	// fetch-target-queue.scala:155:27, :156:27
        prev_entry_cfi_is_call = _RANDOM[8'h87][27];	// fetch-target-queue.scala:155:27, :156:27
        prev_entry_cfi_is_ret = _RANDOM[8'h87][28];	// fetch-target-queue.scala:155:27, :156:27
        prev_pc = {_RANDOM[8'h89][31:12], _RANDOM[8'h8A][19:0]};	// fetch-target-queue.scala:157:27
        first_empty = _RANDOM[8'h8A][20];	// fetch-target-queue.scala:157:27, :214:28
        io_ras_update_REG = _RANDOM[8'h8A][21];	// fetch-target-queue.scala:157:27, :222:31
        io_ras_update_pc_REG = {_RANDOM[8'h8A][31:22], _RANDOM[8'h8B][29:0]};	// fetch-target-queue.scala:157:27, :223:31
        io_ras_update_idx_REG = {_RANDOM[8'h8B][31:30], _RANDOM[8'h8C][2:0]};	// fetch-target-queue.scala:223:31, :224:31
        bpd_update_mispredict = _RANDOM[8'h8C][3];	// fetch-target-queue.scala:224:31, :226:38
        bpd_update_repair = _RANDOM[8'h8C][4];	// fetch-target-queue.scala:224:31, :227:34
        bpd_repair_idx = _RANDOM[8'h8C][10:5];	// fetch-target-queue.scala:224:31, :228:27
        bpd_end_idx = _RANDOM[8'h8C][16:11];	// fetch-target-queue.scala:224:31, :229:24
        bpd_repair_pc = {_RANDOM[8'h8C][31:17], _RANDOM[8'h8D][24:0]};	// fetch-target-queue.scala:224:31, :230:26
        bpd_entry_cfi_idx_valid = _RANDOM[8'h8D][25];	// fetch-target-queue.scala:230:26, :234:26
        bpd_entry_cfi_idx_bits = _RANDOM[8'h8D][28:26];	// fetch-target-queue.scala:230:26, :234:26
        bpd_entry_cfi_taken = _RANDOM[8'h8D][29];	// fetch-target-queue.scala:230:26, :234:26
        bpd_entry_cfi_mispredicted = _RANDOM[8'h8D][30];	// fetch-target-queue.scala:230:26, :234:26
        bpd_entry_cfi_type = {_RANDOM[8'h8D][31], _RANDOM[8'h8E][1:0]};	// fetch-target-queue.scala:230:26, :234:26
        bpd_entry_br_mask = _RANDOM[8'h8E][9:2];	// fetch-target-queue.scala:234:26
        bpd_pc = {_RANDOM[8'h8F][31:27], _RANDOM[8'h90], _RANDOM[8'h91][2:0]};	// fetch-target-queue.scala:242:26
        bpd_target = {_RANDOM[8'h91][31:3], _RANDOM[8'h92][10:0]};	// fetch-target-queue.scala:242:26, :243:27
        REG = _RANDOM[8'h92][11];	// fetch-target-queue.scala:243:27, :248:23
        bpd_repair_idx_REG = _RANDOM[8'h92][17:12];	// fetch-target-queue.scala:243:27, :250:37
        bpd_end_idx_REG = _RANDOM[8'h92][23:18];	// fetch-target-queue.scala:243:27, :251:37
        REG_1 = _RANDOM[8'h92][24];	// fetch-target-queue.scala:243:27, :256:44
        do_commit_update_REG = _RANDOM[8'h92][25];	// fetch-target-queue.scala:243:27, :274:61
        REG_2 = _RANDOM[8'h92][26];	// fetch-target-queue.scala:243:27, :278:16
        io_bpdupdate_valid_REG = _RANDOM[8'h92][27];	// fetch-target-queue.scala:243:27, :284:37
        io_bpdupdate_bits_is_mispredict_update_REG = _RANDOM[8'h92][28];	// fetch-target-queue.scala:243:27, :285:54
        io_bpdupdate_bits_is_repair_update_REG = _RANDOM[8'h92][29];	// fetch-target-queue.scala:243:27, :286:54
        io_enq_ready_REG = _RANDOM[8'h92][30];	// fetch-target-queue.scala:243:27, :308:26
        REG_3 = _RANDOM[8'h92][31];	// fetch-target-queue.scala:243:27, :332:23
        prev_entry_REG_cfi_idx_valid = _RANDOM[8'h93][0];	// fetch-target-queue.scala:333:26
        prev_entry_REG_cfi_idx_bits = _RANDOM[8'h93][3:1];	// fetch-target-queue.scala:333:26
        prev_entry_REG_cfi_taken = _RANDOM[8'h93][4];	// fetch-target-queue.scala:333:26
        prev_entry_REG_br_mask = _RANDOM[8'h93][16:9];	// fetch-target-queue.scala:333:26
        prev_entry_REG_cfi_is_call = _RANDOM[8'h93][17];	// fetch-target-queue.scala:333:26
        prev_entry_REG_cfi_is_ret = _RANDOM[8'h93][18];	// fetch-target-queue.scala:333:26
        REG_4 = _RANDOM[8'h95][7:2];	// fetch-target-queue.scala:337:16
        ram_REG_cfi_idx_valid = _RANDOM[8'h95][8];	// fetch-target-queue.scala:337:{16,46}
        ram_REG_cfi_idx_bits = _RANDOM[8'h95][11:9];	// fetch-target-queue.scala:337:{16,46}
        ram_REG_cfi_taken = _RANDOM[8'h95][12];	// fetch-target-queue.scala:337:{16,46}
        ram_REG_cfi_mispredicted = _RANDOM[8'h95][13];	// fetch-target-queue.scala:337:{16,46}
        ram_REG_cfi_type = _RANDOM[8'h95][16:14];	// fetch-target-queue.scala:337:{16,46}
        ram_REG_br_mask = _RANDOM[8'h95][24:17];	// fetch-target-queue.scala:337:{16,46}
        ram_REG_cfi_is_call = _RANDOM[8'h95][25];	// fetch-target-queue.scala:337:{16,46}
        ram_REG_cfi_is_ret = _RANDOM[8'h95][26];	// fetch-target-queue.scala:337:{16,46}
        ram_REG_ras_top = {_RANDOM[8'h95][31:28], _RANDOM[8'h96], _RANDOM[8'h97][3:0]};	// fetch-target-queue.scala:337:{16,46}
        ram_REG_ras_idx = _RANDOM[8'h97][8:4];	// fetch-target-queue.scala:337:46
        ram_REG_start_bank = _RANDOM[8'h97][9];	// fetch-target-queue.scala:337:46
        io_get_ftq_pc_0_entry_REG_cfi_idx_valid = _RANDOM[8'h97][10];	// fetch-target-queue.scala:337:46, :351:42
        io_get_ftq_pc_0_entry_REG_cfi_idx_bits = _RANDOM[8'h97][13:11];	// fetch-target-queue.scala:337:46, :351:42
        io_get_ftq_pc_0_entry_REG_ras_idx = _RANDOM[8'h99][10:6];	// fetch-target-queue.scala:351:42
        io_get_ftq_pc_0_entry_REG_start_bank = _RANDOM[8'h99][11];	// fetch-target-queue.scala:351:42
        io_get_ftq_pc_0_pc_REG = {_RANDOM[8'h99][31:12], _RANDOM[8'h9A][19:0]};	// fetch-target-queue.scala:351:42, :356:42
        io_get_ftq_pc_0_next_pc_REG = {_RANDOM[8'h9A][31:20], _RANDOM[8'h9B][27:0]};	// fetch-target-queue.scala:356:42, :357:42
        io_get_ftq_pc_0_next_val_REG = _RANDOM[8'h9B][28];	// fetch-target-queue.scala:357:42, :358:42
        io_get_ftq_pc_0_com_pc_REG =
          {_RANDOM[8'h9B][31:29], _RANDOM[8'h9C], _RANDOM[8'h9D][4:0]};	// fetch-target-queue.scala:357:42, :359:42
        io_get_ftq_pc_1_entry_REG_cfi_idx_bits = _RANDOM[8'h9D][8:6];	// fetch-target-queue.scala:351:42, :359:42
        io_get_ftq_pc_1_entry_REG_br_mask = _RANDOM[8'h9D][21:14];	// fetch-target-queue.scala:351:42, :359:42
        io_get_ftq_pc_1_entry_REG_cfi_is_call = _RANDOM[8'h9D][22];	// fetch-target-queue.scala:351:42, :359:42
        io_get_ftq_pc_1_entry_REG_cfi_is_ret = _RANDOM[8'h9D][23];	// fetch-target-queue.scala:351:42, :359:42
        io_get_ftq_pc_1_entry_REG_start_bank = _RANDOM[8'h9F][6];	// fetch-target-queue.scala:351:42
        io_get_ftq_pc_1_pc_REG = {_RANDOM[8'h9F][31:7], _RANDOM[8'hA0][14:0]};	// fetch-target-queue.scala:351:42, :356:42
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  meta_40x240 meta_ext (	// fetch-target-queue.scala:142:29
    .R0_addr (_bpd_meta_T_1),	// fetch-target-queue.scala:232:20
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr),	// fetch-target-queue.scala:135:27
    .W0_en   (ghist_1_MPORT_1_en),	// Decoupled.scala:40:37
    .W0_clk  (clock),
    .W0_data ({io_enq_bits_bpd_meta_1, io_enq_bits_bpd_meta_0}),	// fetch-target-queue.scala:142:29
    .R0_data (_meta_ext_R0_data)
  );
  ghist_40x72 ghist_0_ext (	// fetch-target-queue.scala:144:43
    .R0_addr (_bpd_meta_T_1),	// fetch-target-queue.scala:232:20
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (enq_ptr),	// fetch-target-queue.scala:135:27
    .W0_en   (ghist_1_MPORT_1_en),	// Decoupled.scala:40:37
    .W0_clk  (clock),
    .W0_data (_GEN),	// fetch-target-queue.scala:144:43
    .R0_data (_ghist_0_ext_R0_data)
  );
  ghist_40x72 ghist_1_ext (	// fetch-target-queue.scala:144:43
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
    ({8{~bpd_entry_cfi_idx_valid}}
     | {&bpd_entry_cfi_idx_bits,
        _GEN_12[6],
        _GEN_13[5],
        _GEN_14[4],
        _GEN_15[3],
        _GEN_16[2],
        _GEN_17[1],
        _GEN_17[0] | (&bpd_entry_cfi_idx_bits)}) & bpd_entry_br_mask;	// fetch-target-queue.scala:234:26, :289:37, util.scala:206:28, :373:{29,45}
  assign io_bpdupdate_bits_cfi_idx_valid = bpd_entry_cfi_idx_valid;	// fetch-target-queue.scala:234:26
  assign io_bpdupdate_bits_cfi_idx_bits = bpd_entry_cfi_idx_bits;	// fetch-target-queue.scala:234:26
  assign io_bpdupdate_bits_cfi_taken = bpd_entry_cfi_taken;	// fetch-target-queue.scala:234:26
  assign io_bpdupdate_bits_cfi_mispredicted = bpd_entry_cfi_mispredicted;	// fetch-target-queue.scala:234:26
  assign io_bpdupdate_bits_cfi_is_br = _io_bpdupdate_bits_cfi_is_br_T[0];	// fetch-target-queue.scala:295:54
  assign io_bpdupdate_bits_cfi_is_jal =
    bpd_entry_cfi_type == 3'h2 | bpd_entry_cfi_type == 3'h3;	// fetch-target-queue.scala:234:26, :296:{56,68,90}
  assign io_bpdupdate_bits_ghist_old_history = _ghist_0_ext_R0_data[63:0];	// fetch-target-queue.scala:144:43
  assign io_bpdupdate_bits_ghist_new_saw_branch_not_taken = _ghist_0_ext_R0_data[65];	// fetch-target-queue.scala:144:43
  assign io_bpdupdate_bits_ghist_new_saw_branch_taken = _ghist_0_ext_R0_data[66];	// fetch-target-queue.scala:144:43
  assign io_bpdupdate_bits_target = bpd_target;	// fetch-target-queue.scala:243:27
  assign io_bpdupdate_bits_meta_0 = _meta_ext_R0_data[119:0];	// fetch-target-queue.scala:142:29
  assign io_bpdupdate_bits_meta_1 = _meta_ext_R0_data[239:120];	// fetch-target-queue.scala:142:29
  assign io_ras_update = io_ras_update_REG;	// fetch-target-queue.scala:222:31
  assign io_ras_update_idx = io_ras_update_idx_REG;	// fetch-target-queue.scala:224:31
  assign io_ras_update_pc = io_ras_update_pc_REG;	// fetch-target-queue.scala:223:31
endmodule

