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

module Queue_50(
  input          clock,
                 reset,
                 io_enq_valid,
  input  [39:0]  io_enq_bits_pc,
                 io_enq_bits_next_pc,
  input          io_enq_bits_edge_inst_0,
                 io_enq_bits_edge_inst_1,
  input  [31:0]  io_enq_bits_insts_0,
                 io_enq_bits_insts_1,
                 io_enq_bits_insts_2,
                 io_enq_bits_insts_3,
                 io_enq_bits_insts_4,
                 io_enq_bits_insts_5,
                 io_enq_bits_insts_6,
                 io_enq_bits_insts_7,
                 io_enq_bits_exp_insts_0,
                 io_enq_bits_exp_insts_1,
                 io_enq_bits_exp_insts_2,
                 io_enq_bits_exp_insts_3,
                 io_enq_bits_exp_insts_4,
                 io_enq_bits_exp_insts_5,
                 io_enq_bits_exp_insts_6,
                 io_enq_bits_exp_insts_7,
  input          io_enq_bits_sfbs_0,
                 io_enq_bits_sfbs_1,
                 io_enq_bits_sfbs_2,
                 io_enq_bits_sfbs_3,
                 io_enq_bits_sfbs_4,
                 io_enq_bits_sfbs_5,
                 io_enq_bits_sfbs_6,
                 io_enq_bits_sfbs_7,
  input  [15:0]  io_enq_bits_sfb_masks_0,
                 io_enq_bits_sfb_masks_1,
                 io_enq_bits_sfb_masks_2,
                 io_enq_bits_sfb_masks_3,
                 io_enq_bits_sfb_masks_4,
                 io_enq_bits_sfb_masks_5,
                 io_enq_bits_sfb_masks_6,
                 io_enq_bits_sfb_masks_7,
  input  [4:0]   io_enq_bits_sfb_dests_0,
                 io_enq_bits_sfb_dests_1,
                 io_enq_bits_sfb_dests_2,
                 io_enq_bits_sfb_dests_3,
                 io_enq_bits_sfb_dests_4,
                 io_enq_bits_sfb_dests_5,
                 io_enq_bits_sfb_dests_6,
                 io_enq_bits_sfb_dests_7,
  input          io_enq_bits_shadowable_mask_0,
                 io_enq_bits_shadowable_mask_1,
                 io_enq_bits_shadowable_mask_2,
                 io_enq_bits_shadowable_mask_3,
                 io_enq_bits_shadowable_mask_4,
                 io_enq_bits_shadowable_mask_5,
                 io_enq_bits_shadowable_mask_6,
                 io_enq_bits_shadowable_mask_7,
                 io_enq_bits_cfi_idx_valid,
  input  [2:0]   io_enq_bits_cfi_idx_bits,
                 io_enq_bits_cfi_type,
  input          io_enq_bits_cfi_is_call,
                 io_enq_bits_cfi_is_ret,
                 io_enq_bits_cfi_npc_plus4,
  input  [39:0]  io_enq_bits_ras_top,
  input  [7:0]   io_enq_bits_mask,
                 io_enq_bits_br_mask,
  input  [63:0]  io_enq_bits_ghist_old_history,
  input          io_enq_bits_ghist_current_saw_branch_not_taken,
                 io_enq_bits_ghist_new_saw_branch_not_taken,
                 io_enq_bits_ghist_new_saw_branch_taken,
  input  [4:0]   io_enq_bits_ghist_ras_idx,
  input          io_enq_bits_lhist_0,
                 io_enq_bits_lhist_1,
                 io_enq_bits_xcpt_pf_if,
                 io_enq_bits_xcpt_ae_if,
                 io_enq_bits_end_half_valid,
  input  [15:0]  io_enq_bits_end_half_bits,
  input  [119:0] io_enq_bits_bpd_meta_0,
                 io_enq_bits_bpd_meta_1,
  input  [1:0]   io_enq_bits_fsrc,
                 io_enq_bits_tsrc,
  input          io_deq_ready,
  output         io_enq_ready,
                 io_deq_valid,
  output [39:0]  io_deq_bits_pc,
  output         io_deq_bits_edge_inst_0,
                 io_deq_bits_edge_inst_1,
  output [31:0]  io_deq_bits_insts_0,
                 io_deq_bits_insts_1,
                 io_deq_bits_insts_2,
                 io_deq_bits_insts_3,
                 io_deq_bits_insts_4,
                 io_deq_bits_insts_5,
                 io_deq_bits_insts_6,
                 io_deq_bits_insts_7,
                 io_deq_bits_exp_insts_0,
                 io_deq_bits_exp_insts_1,
                 io_deq_bits_exp_insts_2,
                 io_deq_bits_exp_insts_3,
                 io_deq_bits_exp_insts_4,
                 io_deq_bits_exp_insts_5,
                 io_deq_bits_exp_insts_6,
                 io_deq_bits_exp_insts_7,
  output         io_deq_bits_sfbs_0,
                 io_deq_bits_sfbs_1,
                 io_deq_bits_sfbs_2,
                 io_deq_bits_sfbs_3,
                 io_deq_bits_sfbs_4,
                 io_deq_bits_sfbs_5,
                 io_deq_bits_sfbs_6,
                 io_deq_bits_sfbs_7,
                 io_deq_bits_shadowed_mask_0,
                 io_deq_bits_shadowed_mask_1,
                 io_deq_bits_shadowed_mask_2,
                 io_deq_bits_shadowed_mask_3,
                 io_deq_bits_shadowed_mask_4,
                 io_deq_bits_shadowed_mask_5,
                 io_deq_bits_shadowed_mask_6,
                 io_deq_bits_shadowed_mask_7,
                 io_deq_bits_cfi_idx_valid,
  output [2:0]   io_deq_bits_cfi_idx_bits,
                 io_deq_bits_cfi_type,
  output         io_deq_bits_cfi_is_call,
                 io_deq_bits_cfi_is_ret,
  output [39:0]  io_deq_bits_ras_top,
  output [7:0]   io_deq_bits_mask,
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
                 io_deq_bits_bp_debug_if_oh_4,
                 io_deq_bits_bp_debug_if_oh_5,
                 io_deq_bits_bp_debug_if_oh_6,
                 io_deq_bits_bp_debug_if_oh_7,
                 io_deq_bits_bp_xcpt_if_oh_0,
                 io_deq_bits_bp_xcpt_if_oh_1,
                 io_deq_bits_bp_xcpt_if_oh_2,
                 io_deq_bits_bp_xcpt_if_oh_3,
                 io_deq_bits_bp_xcpt_if_oh_4,
                 io_deq_bits_bp_xcpt_if_oh_5,
                 io_deq_bits_bp_xcpt_if_oh_6,
                 io_deq_bits_bp_xcpt_if_oh_7,
  output [119:0] io_deq_bits_bpd_meta_0,
                 io_deq_bits_bpd_meta_1,
  output [1:0]   io_deq_bits_fsrc
);

  reg  [1210:0] ram;	// Decoupled.scala:218:16
  reg           full;	// Decoupled.scala:221:27
  wire          _io_enq_ready_output = io_deq_ready | ~full;	// Decoupled.scala:221:27, :241:{16,19}, :254:{25,40}
  always @(posedge clock) begin
    automatic logic do_enq;	// Decoupled.scala:40:37
    do_enq = _io_enq_ready_output & io_enq_valid;	// Decoupled.scala:40:37, :241:16, :254:{25,40}
    if (do_enq)	// Decoupled.scala:40:37
      ram <=
        {io_enq_bits_tsrc,
         io_enq_bits_fsrc,
         io_enq_bits_bpd_meta_1,
         io_enq_bits_bpd_meta_0,
         io_enq_bits_end_half_bits,
         io_enq_bits_end_half_valid,
         16'h0,
         io_enq_bits_xcpt_ae_if,
         io_enq_bits_xcpt_pf_if,
         io_enq_bits_lhist_1,
         io_enq_bits_lhist_0,
         io_enq_bits_ghist_ras_idx,
         io_enq_bits_ghist_new_saw_branch_taken,
         io_enq_bits_ghist_new_saw_branch_not_taken,
         io_enq_bits_ghist_current_saw_branch_not_taken,
         io_enq_bits_ghist_old_history,
         io_enq_bits_br_mask,
         io_enq_bits_mask,
         6'h0,
         io_enq_bits_ras_top,
         io_enq_bits_cfi_npc_plus4,
         io_enq_bits_cfi_is_ret,
         io_enq_bits_cfi_is_call,
         io_enq_bits_cfi_type,
         io_enq_bits_cfi_idx_bits,
         io_enq_bits_cfi_idx_valid,
         8'h0,
         io_enq_bits_shadowable_mask_7,
         io_enq_bits_shadowable_mask_6,
         io_enq_bits_shadowable_mask_5,
         io_enq_bits_shadowable_mask_4,
         io_enq_bits_shadowable_mask_3,
         io_enq_bits_shadowable_mask_2,
         io_enq_bits_shadowable_mask_1,
         io_enq_bits_shadowable_mask_0,
         io_enq_bits_sfb_dests_7,
         io_enq_bits_sfb_dests_6,
         io_enq_bits_sfb_dests_5,
         io_enq_bits_sfb_dests_4,
         io_enq_bits_sfb_dests_3,
         io_enq_bits_sfb_dests_2,
         io_enq_bits_sfb_dests_1,
         io_enq_bits_sfb_dests_0,
         io_enq_bits_sfb_masks_7,
         io_enq_bits_sfb_masks_6,
         io_enq_bits_sfb_masks_5,
         io_enq_bits_sfb_masks_4,
         io_enq_bits_sfb_masks_3,
         io_enq_bits_sfb_masks_2,
         io_enq_bits_sfb_masks_1,
         io_enq_bits_sfb_masks_0,
         io_enq_bits_sfbs_7,
         io_enq_bits_sfbs_6,
         io_enq_bits_sfbs_5,
         io_enq_bits_sfbs_4,
         io_enq_bits_sfbs_3,
         io_enq_bits_sfbs_2,
         io_enq_bits_sfbs_1,
         io_enq_bits_sfbs_0,
         io_enq_bits_exp_insts_7,
         io_enq_bits_exp_insts_6,
         io_enq_bits_exp_insts_5,
         io_enq_bits_exp_insts_4,
         io_enq_bits_exp_insts_3,
         io_enq_bits_exp_insts_2,
         io_enq_bits_exp_insts_1,
         io_enq_bits_exp_insts_0,
         io_enq_bits_insts_7,
         io_enq_bits_insts_6,
         io_enq_bits_insts_5,
         io_enq_bits_insts_4,
         io_enq_bits_insts_3,
         io_enq_bits_insts_2,
         io_enq_bits_insts_1,
         io_enq_bits_insts_0,
         io_enq_bits_edge_inst_1,
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
      automatic logic [31:0] _RANDOM[0:37];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [5:0] i = 6'h0; i < 6'h26; i += 6'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        ram =
          {_RANDOM[6'h0][31:1],
           _RANDOM[6'h1],
           _RANDOM[6'h2],
           _RANDOM[6'h3],
           _RANDOM[6'h4],
           _RANDOM[6'h5],
           _RANDOM[6'h6],
           _RANDOM[6'h7],
           _RANDOM[6'h8],
           _RANDOM[6'h9],
           _RANDOM[6'hA],
           _RANDOM[6'hB],
           _RANDOM[6'hC],
           _RANDOM[6'hD],
           _RANDOM[6'hE],
           _RANDOM[6'hF],
           _RANDOM[6'h10],
           _RANDOM[6'h11],
           _RANDOM[6'h12],
           _RANDOM[6'h13],
           _RANDOM[6'h14],
           _RANDOM[6'h15],
           _RANDOM[6'h16],
           _RANDOM[6'h17],
           _RANDOM[6'h18],
           _RANDOM[6'h19],
           _RANDOM[6'h1A],
           _RANDOM[6'h1B],
           _RANDOM[6'h1C],
           _RANDOM[6'h1D],
           _RANDOM[6'h1E],
           _RANDOM[6'h1F],
           _RANDOM[6'h20],
           _RANDOM[6'h21],
           _RANDOM[6'h22],
           _RANDOM[6'h23],
           _RANDOM[6'h24],
           _RANDOM[6'h25][27:0]};	// Decoupled.scala:218:16
        full = _RANDOM[6'h0][0];	// Decoupled.scala:218:16, :221:27
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
  assign io_deq_bits_edge_inst_1 = ram[81];	// Decoupled.scala:218:16
  assign io_deq_bits_insts_0 = ram[113:82];	// Decoupled.scala:218:16
  assign io_deq_bits_insts_1 = ram[145:114];	// Decoupled.scala:218:16
  assign io_deq_bits_insts_2 = ram[177:146];	// Decoupled.scala:218:16
  assign io_deq_bits_insts_3 = ram[209:178];	// Decoupled.scala:218:16
  assign io_deq_bits_insts_4 = ram[241:210];	// Decoupled.scala:218:16
  assign io_deq_bits_insts_5 = ram[273:242];	// Decoupled.scala:218:16
  assign io_deq_bits_insts_6 = ram[305:274];	// Decoupled.scala:218:16
  assign io_deq_bits_insts_7 = ram[337:306];	// Decoupled.scala:218:16
  assign io_deq_bits_exp_insts_0 = ram[369:338];	// Decoupled.scala:218:16
  assign io_deq_bits_exp_insts_1 = ram[401:370];	// Decoupled.scala:218:16
  assign io_deq_bits_exp_insts_2 = ram[433:402];	// Decoupled.scala:218:16
  assign io_deq_bits_exp_insts_3 = ram[465:434];	// Decoupled.scala:218:16
  assign io_deq_bits_exp_insts_4 = ram[497:466];	// Decoupled.scala:218:16
  assign io_deq_bits_exp_insts_5 = ram[529:498];	// Decoupled.scala:218:16
  assign io_deq_bits_exp_insts_6 = ram[561:530];	// Decoupled.scala:218:16
  assign io_deq_bits_exp_insts_7 = ram[593:562];	// Decoupled.scala:218:16
  assign io_deq_bits_sfbs_0 = ram[594];	// Decoupled.scala:218:16
  assign io_deq_bits_sfbs_1 = ram[595];	// Decoupled.scala:218:16
  assign io_deq_bits_sfbs_2 = ram[596];	// Decoupled.scala:218:16
  assign io_deq_bits_sfbs_3 = ram[597];	// Decoupled.scala:218:16
  assign io_deq_bits_sfbs_4 = ram[598];	// Decoupled.scala:218:16
  assign io_deq_bits_sfbs_5 = ram[599];	// Decoupled.scala:218:16
  assign io_deq_bits_sfbs_6 = ram[600];	// Decoupled.scala:218:16
  assign io_deq_bits_sfbs_7 = ram[601];	// Decoupled.scala:218:16
  assign io_deq_bits_shadowed_mask_0 = ram[778];	// Decoupled.scala:218:16
  assign io_deq_bits_shadowed_mask_1 = ram[779];	// Decoupled.scala:218:16
  assign io_deq_bits_shadowed_mask_2 = ram[780];	// Decoupled.scala:218:16
  assign io_deq_bits_shadowed_mask_3 = ram[781];	// Decoupled.scala:218:16
  assign io_deq_bits_shadowed_mask_4 = ram[782];	// Decoupled.scala:218:16
  assign io_deq_bits_shadowed_mask_5 = ram[783];	// Decoupled.scala:218:16
  assign io_deq_bits_shadowed_mask_6 = ram[784];	// Decoupled.scala:218:16
  assign io_deq_bits_shadowed_mask_7 = ram[785];	// Decoupled.scala:218:16
  assign io_deq_bits_cfi_idx_valid = ram[786];	// Decoupled.scala:218:16
  assign io_deq_bits_cfi_idx_bits = ram[789:787];	// Decoupled.scala:218:16
  assign io_deq_bits_cfi_type = ram[792:790];	// Decoupled.scala:218:16
  assign io_deq_bits_cfi_is_call = ram[793];	// Decoupled.scala:218:16
  assign io_deq_bits_cfi_is_ret = ram[794];	// Decoupled.scala:218:16
  assign io_deq_bits_ras_top = ram[835:796];	// Decoupled.scala:218:16
  assign io_deq_bits_mask = ram[849:842];	// Decoupled.scala:218:16
  assign io_deq_bits_br_mask = ram[857:850];	// Decoupled.scala:218:16
  assign io_deq_bits_ghist_old_history = ram[921:858];	// Decoupled.scala:218:16
  assign io_deq_bits_ghist_current_saw_branch_not_taken = ram[922];	// Decoupled.scala:218:16
  assign io_deq_bits_ghist_new_saw_branch_not_taken = ram[923];	// Decoupled.scala:218:16
  assign io_deq_bits_ghist_new_saw_branch_taken = ram[924];	// Decoupled.scala:218:16
  assign io_deq_bits_ghist_ras_idx = ram[929:925];	// Decoupled.scala:218:16
  assign io_deq_bits_xcpt_pf_if = ram[932];	// Decoupled.scala:218:16
  assign io_deq_bits_xcpt_ae_if = ram[933];	// Decoupled.scala:218:16
  assign io_deq_bits_bp_debug_if_oh_0 = ram[934];	// Decoupled.scala:218:16
  assign io_deq_bits_bp_debug_if_oh_1 = ram[935];	// Decoupled.scala:218:16
  assign io_deq_bits_bp_debug_if_oh_2 = ram[936];	// Decoupled.scala:218:16
  assign io_deq_bits_bp_debug_if_oh_3 = ram[937];	// Decoupled.scala:218:16
  assign io_deq_bits_bp_debug_if_oh_4 = ram[938];	// Decoupled.scala:218:16
  assign io_deq_bits_bp_debug_if_oh_5 = ram[939];	// Decoupled.scala:218:16
  assign io_deq_bits_bp_debug_if_oh_6 = ram[940];	// Decoupled.scala:218:16
  assign io_deq_bits_bp_debug_if_oh_7 = ram[941];	// Decoupled.scala:218:16
  assign io_deq_bits_bp_xcpt_if_oh_0 = ram[942];	// Decoupled.scala:218:16
  assign io_deq_bits_bp_xcpt_if_oh_1 = ram[943];	// Decoupled.scala:218:16
  assign io_deq_bits_bp_xcpt_if_oh_2 = ram[944];	// Decoupled.scala:218:16
  assign io_deq_bits_bp_xcpt_if_oh_3 = ram[945];	// Decoupled.scala:218:16
  assign io_deq_bits_bp_xcpt_if_oh_4 = ram[946];	// Decoupled.scala:218:16
  assign io_deq_bits_bp_xcpt_if_oh_5 = ram[947];	// Decoupled.scala:218:16
  assign io_deq_bits_bp_xcpt_if_oh_6 = ram[948];	// Decoupled.scala:218:16
  assign io_deq_bits_bp_xcpt_if_oh_7 = ram[949];	// Decoupled.scala:218:16
  assign io_deq_bits_bpd_meta_0 = ram[1086:967];	// Decoupled.scala:218:16
  assign io_deq_bits_bpd_meta_1 = ram[1206:1087];	// Decoupled.scala:218:16
  assign io_deq_bits_fsrc = ram[1208:1207];	// Decoupled.scala:218:16
endmodule

