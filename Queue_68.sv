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

module Queue_68(
  input          clock,
                 reset,
                 io_enq_valid,
  input  [39:0]  io_enq_bits_pc,
                 io_enq_bits_next_pc,
  input          io_enq_bits_edge_inst_0,
  input  [31:0]  io_enq_bits_insts_0,
                 io_enq_bits_insts_1,
                 io_enq_bits_insts_2,
                 io_enq_bits_insts_3,
                 io_enq_bits_exp_insts_0,
                 io_enq_bits_exp_insts_1,
                 io_enq_bits_exp_insts_2,
                 io_enq_bits_exp_insts_3,
  input          io_enq_bits_sfbs_0,
                 io_enq_bits_sfbs_1,
                 io_enq_bits_sfbs_2,
                 io_enq_bits_sfbs_3,
  input  [7:0]   io_enq_bits_sfb_masks_0,
                 io_enq_bits_sfb_masks_1,
                 io_enq_bits_sfb_masks_2,
                 io_enq_bits_sfb_masks_3,
  input  [3:0]   io_enq_bits_sfb_dests_0,
                 io_enq_bits_sfb_dests_1,
                 io_enq_bits_sfb_dests_2,
                 io_enq_bits_sfb_dests_3,
  input          io_enq_bits_shadowable_mask_0,
                 io_enq_bits_shadowable_mask_1,
                 io_enq_bits_shadowable_mask_2,
                 io_enq_bits_shadowable_mask_3,
                 io_enq_bits_cfi_idx_valid,
  input  [1:0]   io_enq_bits_cfi_idx_bits,
  input  [2:0]   io_enq_bits_cfi_type,
  input          io_enq_bits_cfi_is_call,
                 io_enq_bits_cfi_is_ret,
                 io_enq_bits_cfi_npc_plus4,
  input  [39:0]  io_enq_bits_ras_top,
  input  [3:0]   io_enq_bits_mask,
                 io_enq_bits_br_mask,
  input  [63:0]  io_enq_bits_ghist_old_history,
  input          io_enq_bits_ghist_current_saw_branch_not_taken,
                 io_enq_bits_ghist_new_saw_branch_not_taken,
                 io_enq_bits_ghist_new_saw_branch_taken,
  input  [4:0]   io_enq_bits_ghist_ras_idx,
  input          io_enq_bits_lhist_0,
                 io_enq_bits_xcpt_pf_if,
                 io_enq_bits_xcpt_ae_if,
                 io_enq_bits_end_half_valid,
  input  [15:0]  io_enq_bits_end_half_bits,
  input  [119:0] io_enq_bits_bpd_meta_0,
  input  [1:0]   io_enq_bits_fsrc,
                 io_enq_bits_tsrc,
  input          io_deq_ready,
  output         io_enq_ready,
                 io_deq_valid,
  output [39:0]  io_deq_bits_pc,
  output         io_deq_bits_edge_inst_0,
  output [31:0]  io_deq_bits_insts_0,
                 io_deq_bits_insts_1,
                 io_deq_bits_insts_2,
                 io_deq_bits_insts_3,
                 io_deq_bits_exp_insts_0,
                 io_deq_bits_exp_insts_1,
                 io_deq_bits_exp_insts_2,
                 io_deq_bits_exp_insts_3,
  output         io_deq_bits_sfbs_0,
                 io_deq_bits_sfbs_1,
                 io_deq_bits_sfbs_2,
                 io_deq_bits_sfbs_3,
                 io_deq_bits_shadowed_mask_0,
                 io_deq_bits_shadowed_mask_1,
                 io_deq_bits_shadowed_mask_2,
                 io_deq_bits_shadowed_mask_3,
                 io_deq_bits_cfi_idx_valid,
  output [1:0]   io_deq_bits_cfi_idx_bits,
  output [2:0]   io_deq_bits_cfi_type,
  output         io_deq_bits_cfi_is_call,
                 io_deq_bits_cfi_is_ret,
  output [39:0]  io_deq_bits_ras_top,
  output [3:0]   io_deq_bits_mask,
                 io_deq_bits_br_mask,
  output [63:0]  io_deq_bits_ghist_old_history,
  output         io_deq_bits_ghist_current_saw_branch_not_taken,
                 io_deq_bits_ghist_new_saw_branch_not_taken,
                 io_deq_bits_ghist_new_saw_branch_taken,
  output [4:0]   io_deq_bits_ghist_ras_idx,
  output         io_deq_bits_xcpt_pf_if,
                 io_deq_bits_xcpt_ae_if,
                 io_deq_bits_bp_debug_if_oh_0,
                 io_deq_bits_bp_debug_if_oh_1,
                 io_deq_bits_bp_debug_if_oh_2,
                 io_deq_bits_bp_debug_if_oh_3,
                 io_deq_bits_bp_xcpt_if_oh_0,
                 io_deq_bits_bp_xcpt_if_oh_1,
                 io_deq_bits_bp_xcpt_if_oh_2,
                 io_deq_bits_bp_xcpt_if_oh_3,
  output [119:0] io_deq_bits_bpd_meta_0,
  output [1:0]   io_deq_bits_fsrc
);

  reg  [682:0] ram;	// Decoupled.scala:218:16
  reg          full;	// Decoupled.scala:221:27
  wire         _io_enq_ready_output = io_deq_ready | ~full;	// Decoupled.scala:221:27, :241:{16,19}, :254:{25,40}
  always @(posedge clock) begin
    automatic logic do_enq;	// Decoupled.scala:40:37
    do_enq = _io_enq_ready_output & io_enq_valid;	// Decoupled.scala:40:37, :241:16, :254:{25,40}
    if (do_enq)	// Decoupled.scala:40:37
      ram <=
        {io_enq_bits_tsrc,
         io_enq_bits_fsrc,
         io_enq_bits_bpd_meta_0,
         io_enq_bits_end_half_bits,
         io_enq_bits_end_half_valid,
         8'h0,
         io_enq_bits_xcpt_ae_if,
         io_enq_bits_xcpt_pf_if,
         io_enq_bits_lhist_0,
         io_enq_bits_ghist_ras_idx,
         io_enq_bits_ghist_new_saw_branch_taken,
         io_enq_bits_ghist_new_saw_branch_not_taken,
         io_enq_bits_ghist_current_saw_branch_not_taken,
         io_enq_bits_ghist_old_history,
         io_enq_bits_br_mask,
         io_enq_bits_mask,
         5'h0,
         io_enq_bits_ras_top,
         io_enq_bits_cfi_npc_plus4,
         io_enq_bits_cfi_is_ret,
         io_enq_bits_cfi_is_call,
         io_enq_bits_cfi_type,
         io_enq_bits_cfi_idx_bits,
         io_enq_bits_cfi_idx_valid,
         4'h0,
         io_enq_bits_shadowable_mask_3,
         io_enq_bits_shadowable_mask_2,
         io_enq_bits_shadowable_mask_1,
         io_enq_bits_shadowable_mask_0,
         io_enq_bits_sfb_dests_3,
         io_enq_bits_sfb_dests_2,
         io_enq_bits_sfb_dests_1,
         io_enq_bits_sfb_dests_0,
         io_enq_bits_sfb_masks_3,
         io_enq_bits_sfb_masks_2,
         io_enq_bits_sfb_masks_1,
         io_enq_bits_sfb_masks_0,
         io_enq_bits_sfbs_3,
         io_enq_bits_sfbs_2,
         io_enq_bits_sfbs_1,
         io_enq_bits_sfbs_0,
         io_enq_bits_exp_insts_3,
         io_enq_bits_exp_insts_2,
         io_enq_bits_exp_insts_1,
         io_enq_bits_exp_insts_0,
         io_enq_bits_insts_3,
         io_enq_bits_insts_2,
         io_enq_bits_insts_1,
         io_enq_bits_insts_0,
         io_enq_bits_edge_inst_0,
         io_enq_bits_next_pc,
         io_enq_bits_pc};	// Decoupled.scala:218:16
    if (reset)
      full <= 1'h0;	// Decoupled.scala:218:16, :221:27
    else if (do_enq != (io_deq_ready & full))	// Decoupled.scala:40:37, :221:27, :236:16
      full <= do_enq;	// Decoupled.scala:40:37, :221:27
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:21];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [4:0] i = 5'h0; i < 5'h16; i += 5'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        ram =
          {_RANDOM[5'h0][31:1],
           _RANDOM[5'h1],
           _RANDOM[5'h2],
           _RANDOM[5'h3],
           _RANDOM[5'h4],
           _RANDOM[5'h5],
           _RANDOM[5'h6],
           _RANDOM[5'h7],
           _RANDOM[5'h8],
           _RANDOM[5'h9],
           _RANDOM[5'hA],
           _RANDOM[5'hB],
           _RANDOM[5'hC],
           _RANDOM[5'hD],
           _RANDOM[5'hE],
           _RANDOM[5'hF],
           _RANDOM[5'h10],
           _RANDOM[5'h11],
           _RANDOM[5'h12],
           _RANDOM[5'h13],
           _RANDOM[5'h14],
           _RANDOM[5'h15][11:0]};	// Decoupled.scala:218:16
        full = _RANDOM[5'h0][0];	// Decoupled.scala:218:16, :221:27
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_enq_ready = _io_enq_ready_output;	// Decoupled.scala:241:16, :254:{25,40}
  assign io_deq_valid = full;	// Decoupled.scala:221:27
  assign io_deq_bits_pc = ram[39:0];	// Decoupled.scala:218:16
  assign io_deq_bits_edge_inst_0 = ram[80];	// Decoupled.scala:218:16
  assign io_deq_bits_insts_0 = ram[112:81];	// Decoupled.scala:218:16
  assign io_deq_bits_insts_1 = ram[144:113];	// Decoupled.scala:218:16
  assign io_deq_bits_insts_2 = ram[176:145];	// Decoupled.scala:218:16
  assign io_deq_bits_insts_3 = ram[208:177];	// Decoupled.scala:218:16
  assign io_deq_bits_exp_insts_0 = ram[240:209];	// Decoupled.scala:218:16
  assign io_deq_bits_exp_insts_1 = ram[272:241];	// Decoupled.scala:218:16
  assign io_deq_bits_exp_insts_2 = ram[304:273];	// Decoupled.scala:218:16
  assign io_deq_bits_exp_insts_3 = ram[336:305];	// Decoupled.scala:218:16
  assign io_deq_bits_sfbs_0 = ram[337];	// Decoupled.scala:218:16
  assign io_deq_bits_sfbs_1 = ram[338];	// Decoupled.scala:218:16
  assign io_deq_bits_sfbs_2 = ram[339];	// Decoupled.scala:218:16
  assign io_deq_bits_sfbs_3 = ram[340];	// Decoupled.scala:218:16
  assign io_deq_bits_shadowed_mask_0 = ram[393];	// Decoupled.scala:218:16
  assign io_deq_bits_shadowed_mask_1 = ram[394];	// Decoupled.scala:218:16
  assign io_deq_bits_shadowed_mask_2 = ram[395];	// Decoupled.scala:218:16
  assign io_deq_bits_shadowed_mask_3 = ram[396];	// Decoupled.scala:218:16
  assign io_deq_bits_cfi_idx_valid = ram[397];	// Decoupled.scala:218:16
  assign io_deq_bits_cfi_idx_bits = ram[399:398];	// Decoupled.scala:218:16
  assign io_deq_bits_cfi_type = ram[402:400];	// Decoupled.scala:218:16
  assign io_deq_bits_cfi_is_call = ram[403];	// Decoupled.scala:218:16
  assign io_deq_bits_cfi_is_ret = ram[404];	// Decoupled.scala:218:16
  assign io_deq_bits_ras_top = ram[445:406];	// Decoupled.scala:218:16
  assign io_deq_bits_mask = ram[454:451];	// Decoupled.scala:218:16
  assign io_deq_bits_br_mask = ram[458:455];	// Decoupled.scala:218:16
  assign io_deq_bits_ghist_old_history = ram[522:459];	// Decoupled.scala:218:16
  assign io_deq_bits_ghist_current_saw_branch_not_taken = ram[523];	// Decoupled.scala:218:16
  assign io_deq_bits_ghist_new_saw_branch_not_taken = ram[524];	// Decoupled.scala:218:16
  assign io_deq_bits_ghist_new_saw_branch_taken = ram[525];	// Decoupled.scala:218:16
  assign io_deq_bits_ghist_ras_idx = ram[530:526];	// Decoupled.scala:218:16
  assign io_deq_bits_xcpt_pf_if = ram[532];	// Decoupled.scala:218:16
  assign io_deq_bits_xcpt_ae_if = ram[533];	// Decoupled.scala:218:16
  assign io_deq_bits_bp_debug_if_oh_0 = ram[534];	// Decoupled.scala:218:16
  assign io_deq_bits_bp_debug_if_oh_1 = ram[535];	// Decoupled.scala:218:16
  assign io_deq_bits_bp_debug_if_oh_2 = ram[536];	// Decoupled.scala:218:16
  assign io_deq_bits_bp_debug_if_oh_3 = ram[537];	// Decoupled.scala:218:16
  assign io_deq_bits_bp_xcpt_if_oh_0 = ram[538];	// Decoupled.scala:218:16
  assign io_deq_bits_bp_xcpt_if_oh_1 = ram[539];	// Decoupled.scala:218:16
  assign io_deq_bits_bp_xcpt_if_oh_2 = ram[540];	// Decoupled.scala:218:16
  assign io_deq_bits_bp_xcpt_if_oh_3 = ram[541];	// Decoupled.scala:218:16
  assign io_deq_bits_bpd_meta_0 = ram[678:559];	// Decoupled.scala:218:16
  assign io_deq_bits_fsrc = ram[680:679];	// Decoupled.scala:218:16
endmodule

