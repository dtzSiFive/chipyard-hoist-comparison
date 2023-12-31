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

module BoomFrontend_2(
  input         clock,
                reset,
                auto_icache_master_out_a_ready,
                auto_icache_master_out_d_valid,
  input  [2:0]  auto_icache_master_out_d_bits_opcode,
  input  [3:0]  auto_icache_master_out_d_bits_size,
  input  [63:0] auto_icache_master_out_d_bits_data,
  input         io_cpu_fetchpacket_ready,
  input  [4:0]  io_cpu_get_pc_0_ftq_idx,
                io_cpu_get_pc_1_ftq_idx,
  input         io_cpu_sfence_valid,
                io_cpu_sfence_bits_rs1,
                io_cpu_sfence_bits_rs2,
  input  [38:0] io_cpu_sfence_bits_addr,
  input  [4:0]  io_cpu_brupdate_b2_uop_ftq_idx,
  input  [5:0]  io_cpu_brupdate_b2_uop_pc_lob,
  input         io_cpu_brupdate_b2_mispredict,
                io_cpu_brupdate_b2_taken,
                io_cpu_redirect_flush,
                io_cpu_redirect_val,
  input  [39:0] io_cpu_redirect_pc,
  input  [4:0]  io_cpu_redirect_ftq_idx,
  input  [63:0] io_cpu_redirect_ghist_old_history,
  input         io_cpu_redirect_ghist_current_saw_branch_not_taken,
                io_cpu_redirect_ghist_new_saw_branch_not_taken,
                io_cpu_redirect_ghist_new_saw_branch_taken,
  input  [4:0]  io_cpu_redirect_ghist_ras_idx,
  input         io_cpu_commit_valid,
  input  [31:0] io_cpu_commit_bits,
  input         io_cpu_flush_icache,
                io_ptw_req_ready,
                io_ptw_resp_valid,
                io_ptw_resp_bits_ae,
  input  [53:0] io_ptw_resp_bits_pte_ppn,
  input         io_ptw_resp_bits_pte_d,
                io_ptw_resp_bits_pte_a,
                io_ptw_resp_bits_pte_g,
                io_ptw_resp_bits_pte_u,
                io_ptw_resp_bits_pte_x,
                io_ptw_resp_bits_pte_w,
                io_ptw_resp_bits_pte_r,
                io_ptw_resp_bits_pte_v,
  input  [1:0]  io_ptw_resp_bits_level,
  input         io_ptw_resp_bits_homogeneous,
  input  [3:0]  io_ptw_ptbr_mode,
  input         io_ptw_status_debug,
  input  [1:0]  io_ptw_status_prv,
  input         io_ptw_pmp_0_cfg_l,
  input  [1:0]  io_ptw_pmp_0_cfg_a,
  input         io_ptw_pmp_0_cfg_x,
                io_ptw_pmp_0_cfg_w,
                io_ptw_pmp_0_cfg_r,
  input  [29:0] io_ptw_pmp_0_addr,
  input  [31:0] io_ptw_pmp_0_mask,
  input         io_ptw_pmp_1_cfg_l,
  input  [1:0]  io_ptw_pmp_1_cfg_a,
  input         io_ptw_pmp_1_cfg_x,
                io_ptw_pmp_1_cfg_w,
                io_ptw_pmp_1_cfg_r,
  input  [29:0] io_ptw_pmp_1_addr,
  input  [31:0] io_ptw_pmp_1_mask,
  input         io_ptw_pmp_2_cfg_l,
  input  [1:0]  io_ptw_pmp_2_cfg_a,
  input         io_ptw_pmp_2_cfg_x,
                io_ptw_pmp_2_cfg_w,
                io_ptw_pmp_2_cfg_r,
  input  [29:0] io_ptw_pmp_2_addr,
  input  [31:0] io_ptw_pmp_2_mask,
  input         io_ptw_pmp_3_cfg_l,
  input  [1:0]  io_ptw_pmp_3_cfg_a,
  input         io_ptw_pmp_3_cfg_x,
                io_ptw_pmp_3_cfg_w,
                io_ptw_pmp_3_cfg_r,
  input  [29:0] io_ptw_pmp_3_addr,
  input  [31:0] io_ptw_pmp_3_mask,
  input         io_ptw_pmp_4_cfg_l,
  input  [1:0]  io_ptw_pmp_4_cfg_a,
  input         io_ptw_pmp_4_cfg_x,
                io_ptw_pmp_4_cfg_w,
                io_ptw_pmp_4_cfg_r,
  input  [29:0] io_ptw_pmp_4_addr,
  input  [31:0] io_ptw_pmp_4_mask,
  input         io_ptw_pmp_5_cfg_l,
  input  [1:0]  io_ptw_pmp_5_cfg_a,
  input         io_ptw_pmp_5_cfg_x,
                io_ptw_pmp_5_cfg_w,
                io_ptw_pmp_5_cfg_r,
  input  [29:0] io_ptw_pmp_5_addr,
  input  [31:0] io_ptw_pmp_5_mask,
  input         io_ptw_pmp_6_cfg_l,
  input  [1:0]  io_ptw_pmp_6_cfg_a,
  input         io_ptw_pmp_6_cfg_x,
                io_ptw_pmp_6_cfg_w,
                io_ptw_pmp_6_cfg_r,
  input  [29:0] io_ptw_pmp_6_addr,
  input  [31:0] io_ptw_pmp_6_mask,
  input         io_ptw_pmp_7_cfg_l,
  input  [1:0]  io_ptw_pmp_7_cfg_a,
  input         io_ptw_pmp_7_cfg_x,
                io_ptw_pmp_7_cfg_w,
                io_ptw_pmp_7_cfg_r,
  input  [29:0] io_ptw_pmp_7_addr,
  input  [31:0] io_ptw_pmp_7_mask,
  output        auto_icache_master_out_a_valid,
  output [31:0] auto_icache_master_out_a_bits_address,
  output        io_cpu_fetchpacket_valid,
                io_cpu_fetchpacket_bits_uops_0_valid,
  output [31:0] io_cpu_fetchpacket_bits_uops_0_bits_inst,
                io_cpu_fetchpacket_bits_uops_0_bits_debug_inst,
  output        io_cpu_fetchpacket_bits_uops_0_bits_is_rvc,
  output [39:0] io_cpu_fetchpacket_bits_uops_0_bits_debug_pc,
  output [3:0]  io_cpu_fetchpacket_bits_uops_0_bits_ctrl_br_type,
  output [1:0]  io_cpu_fetchpacket_bits_uops_0_bits_ctrl_op1_sel,
  output [2:0]  io_cpu_fetchpacket_bits_uops_0_bits_ctrl_op2_sel,
                io_cpu_fetchpacket_bits_uops_0_bits_ctrl_imm_sel,
  output [3:0]  io_cpu_fetchpacket_bits_uops_0_bits_ctrl_op_fcn,
  output        io_cpu_fetchpacket_bits_uops_0_bits_ctrl_fcn_dw,
  output [2:0]  io_cpu_fetchpacket_bits_uops_0_bits_ctrl_csr_cmd,
  output        io_cpu_fetchpacket_bits_uops_0_bits_ctrl_is_load,
                io_cpu_fetchpacket_bits_uops_0_bits_ctrl_is_sta,
                io_cpu_fetchpacket_bits_uops_0_bits_ctrl_is_std,
  output [1:0]  io_cpu_fetchpacket_bits_uops_0_bits_iw_state,
  output        io_cpu_fetchpacket_bits_uops_0_bits_iw_p1_poisoned,
                io_cpu_fetchpacket_bits_uops_0_bits_iw_p2_poisoned,
                io_cpu_fetchpacket_bits_uops_0_bits_is_sfb,
  output [4:0]  io_cpu_fetchpacket_bits_uops_0_bits_ftq_idx,
  output        io_cpu_fetchpacket_bits_uops_0_bits_edge_inst,
  output [5:0]  io_cpu_fetchpacket_bits_uops_0_bits_pc_lob,
  output        io_cpu_fetchpacket_bits_uops_0_bits_taken,
  output [11:0] io_cpu_fetchpacket_bits_uops_0_bits_csr_addr,
  output [1:0]  io_cpu_fetchpacket_bits_uops_0_bits_rxq_idx,
  output        io_cpu_fetchpacket_bits_uops_0_bits_xcpt_pf_if,
                io_cpu_fetchpacket_bits_uops_0_bits_xcpt_ae_if,
                io_cpu_fetchpacket_bits_uops_0_bits_xcpt_ma_if,
                io_cpu_fetchpacket_bits_uops_0_bits_bp_debug_if,
                io_cpu_fetchpacket_bits_uops_0_bits_bp_xcpt_if,
  output [1:0]  io_cpu_fetchpacket_bits_uops_0_bits_debug_fsrc,
                io_cpu_fetchpacket_bits_uops_0_bits_debug_tsrc,
  output        io_cpu_fetchpacket_bits_uops_1_valid,
  output [31:0] io_cpu_fetchpacket_bits_uops_1_bits_inst,
                io_cpu_fetchpacket_bits_uops_1_bits_debug_inst,
  output        io_cpu_fetchpacket_bits_uops_1_bits_is_rvc,
  output [39:0] io_cpu_fetchpacket_bits_uops_1_bits_debug_pc,
  output [3:0]  io_cpu_fetchpacket_bits_uops_1_bits_ctrl_br_type,
  output [1:0]  io_cpu_fetchpacket_bits_uops_1_bits_ctrl_op1_sel,
  output [2:0]  io_cpu_fetchpacket_bits_uops_1_bits_ctrl_op2_sel,
                io_cpu_fetchpacket_bits_uops_1_bits_ctrl_imm_sel,
  output [3:0]  io_cpu_fetchpacket_bits_uops_1_bits_ctrl_op_fcn,
  output        io_cpu_fetchpacket_bits_uops_1_bits_ctrl_fcn_dw,
  output [2:0]  io_cpu_fetchpacket_bits_uops_1_bits_ctrl_csr_cmd,
  output        io_cpu_fetchpacket_bits_uops_1_bits_ctrl_is_load,
                io_cpu_fetchpacket_bits_uops_1_bits_ctrl_is_sta,
                io_cpu_fetchpacket_bits_uops_1_bits_ctrl_is_std,
  output [1:0]  io_cpu_fetchpacket_bits_uops_1_bits_iw_state,
  output        io_cpu_fetchpacket_bits_uops_1_bits_iw_p1_poisoned,
                io_cpu_fetchpacket_bits_uops_1_bits_iw_p2_poisoned,
                io_cpu_fetchpacket_bits_uops_1_bits_is_sfb,
  output [4:0]  io_cpu_fetchpacket_bits_uops_1_bits_ftq_idx,
  output        io_cpu_fetchpacket_bits_uops_1_bits_edge_inst,
  output [5:0]  io_cpu_fetchpacket_bits_uops_1_bits_pc_lob,
  output        io_cpu_fetchpacket_bits_uops_1_bits_taken,
  output [11:0] io_cpu_fetchpacket_bits_uops_1_bits_csr_addr,
  output [1:0]  io_cpu_fetchpacket_bits_uops_1_bits_rxq_idx,
  output        io_cpu_fetchpacket_bits_uops_1_bits_xcpt_pf_if,
                io_cpu_fetchpacket_bits_uops_1_bits_xcpt_ae_if,
                io_cpu_fetchpacket_bits_uops_1_bits_xcpt_ma_if,
                io_cpu_fetchpacket_bits_uops_1_bits_bp_debug_if,
                io_cpu_fetchpacket_bits_uops_1_bits_bp_xcpt_if,
  output [1:0]  io_cpu_fetchpacket_bits_uops_1_bits_debug_fsrc,
                io_cpu_fetchpacket_bits_uops_1_bits_debug_tsrc,
  output        io_cpu_get_pc_0_entry_cfi_idx_valid,
  output [1:0]  io_cpu_get_pc_0_entry_cfi_idx_bits,
  output [4:0]  io_cpu_get_pc_0_entry_ras_idx,
  output        io_cpu_get_pc_0_entry_start_bank,
  output [39:0] io_cpu_get_pc_0_pc,
                io_cpu_get_pc_0_com_pc,
  output        io_cpu_get_pc_0_next_val,
  output [39:0] io_cpu_get_pc_0_next_pc,
  output [1:0]  io_cpu_get_pc_1_entry_cfi_idx_bits,
  output [3:0]  io_cpu_get_pc_1_entry_br_mask,
  output        io_cpu_get_pc_1_entry_cfi_is_call,
                io_cpu_get_pc_1_entry_cfi_is_ret,
                io_cpu_get_pc_1_entry_start_bank,
  output [63:0] io_cpu_get_pc_1_ghist_old_history,
  output        io_cpu_get_pc_1_ghist_current_saw_branch_not_taken,
                io_cpu_get_pc_1_ghist_new_saw_branch_not_taken,
                io_cpu_get_pc_1_ghist_new_saw_branch_taken,
  output [4:0]  io_cpu_get_pc_1_ghist_ras_idx,
  output [39:0] io_cpu_get_pc_1_pc,
  output        io_cpu_perf_acquire,
                io_cpu_perf_tlbMiss,
                io_ptw_req_valid,
  output [26:0] io_ptw_req_bits_bits_addr
);

  wire [39:0]      s0_vpc;	// frontend.scala:953:30, :961:18, :965:38
  wire             f1_clear;	// frontend.scala:814:38, :953:30, :958:17, :965:38, :970:17
  wire             f2_clear;	// frontend.scala:814:38, :953:30, :957:17, :965:38, :969:17
  wire             f4_clear;	// frontend.scala:953:30, :954:17, :965:38
  wire             _f4_io_enq_valid_T_1;	// frontend.scala:908:38
  wire [4:0]       _GEN;	// frontend.scala:533:24, :814:38, :821:79, :822:28
  wire [1:0]       f3_fetch_bundle_cfi_idx_bits;	// Mux.scala:47:69
  wire             f3_br_mask_3;	// frontend.scala:736:37
  wire             f3_mask_3;	// frontend.scala:690:71
  wire [31:0]      inst_2;	// Cat.scala:30:58
  wire             f3_br_mask_2;	// frontend.scala:736:37
  wire             f3_mask_2;	// frontend.scala:690:71
  wire [31:0]      inst_1;	// frontend.scala:681:29
  wire             f3_br_mask_1;	// frontend.scala:736:37
  wire             f3_mask_1;	// frontend.scala:690:71
  wire [31:0]      inst;	// frontend.scala:674:29
  wire             f3_br_mask_0;	// frontend.scala:736:37
  wire             f3_mask_0;	// frontend.scala:690:39
  wire             _bpd_update_arbiter_io_in_1_ready;	// frontend.scala:925:34
  wire             _bpd_update_arbiter_io_out_valid;	// frontend.scala:925:34
  wire             _bpd_update_arbiter_io_out_bits_is_mispredict_update;	// frontend.scala:925:34
  wire             _bpd_update_arbiter_io_out_bits_is_repair_update;	// frontend.scala:925:34
  wire [3:0]       _bpd_update_arbiter_io_out_bits_btb_mispredicts;	// frontend.scala:925:34
  wire [39:0]      _bpd_update_arbiter_io_out_bits_pc;	// frontend.scala:925:34
  wire [3:0]       _bpd_update_arbiter_io_out_bits_br_mask;	// frontend.scala:925:34
  wire             _bpd_update_arbiter_io_out_bits_cfi_idx_valid;	// frontend.scala:925:34
  wire [1:0]       _bpd_update_arbiter_io_out_bits_cfi_idx_bits;	// frontend.scala:925:34
  wire             _bpd_update_arbiter_io_out_bits_cfi_taken;	// frontend.scala:925:34
  wire             _bpd_update_arbiter_io_out_bits_cfi_mispredicted;	// frontend.scala:925:34
  wire             _bpd_update_arbiter_io_out_bits_cfi_is_br;	// frontend.scala:925:34
  wire             _bpd_update_arbiter_io_out_bits_cfi_is_jal;	// frontend.scala:925:34
  wire [63:0]      _bpd_update_arbiter_io_out_bits_ghist_old_history;	// frontend.scala:925:34
  wire [39:0]      _bpd_update_arbiter_io_out_bits_target;	// frontend.scala:925:34
  wire [119:0]     _bpd_update_arbiter_io_out_bits_meta_0;	// frontend.scala:925:34
  wire             _ftq_io_enq_ready;	// frontend.scala:862:19
  wire [4:0]       _ftq_io_enq_idx;	// frontend.scala:862:19
  wire             _ftq_io_bpdupdate_valid;	// frontend.scala:862:19
  wire             _ftq_io_bpdupdate_bits_is_mispredict_update;	// frontend.scala:862:19
  wire             _ftq_io_bpdupdate_bits_is_repair_update;	// frontend.scala:862:19
  wire [39:0]      _ftq_io_bpdupdate_bits_pc;	// frontend.scala:862:19
  wire [3:0]       _ftq_io_bpdupdate_bits_br_mask;	// frontend.scala:862:19
  wire             _ftq_io_bpdupdate_bits_cfi_idx_valid;	// frontend.scala:862:19
  wire [1:0]       _ftq_io_bpdupdate_bits_cfi_idx_bits;	// frontend.scala:862:19
  wire             _ftq_io_bpdupdate_bits_cfi_taken;	// frontend.scala:862:19
  wire             _ftq_io_bpdupdate_bits_cfi_mispredicted;	// frontend.scala:862:19
  wire             _ftq_io_bpdupdate_bits_cfi_is_br;	// frontend.scala:862:19
  wire             _ftq_io_bpdupdate_bits_cfi_is_jal;	// frontend.scala:862:19
  wire [63:0]      _ftq_io_bpdupdate_bits_ghist_old_history;	// frontend.scala:862:19
  wire [39:0]      _ftq_io_bpdupdate_bits_target;	// frontend.scala:862:19
  wire [119:0]     _ftq_io_bpdupdate_bits_meta_0;	// frontend.scala:862:19
  wire             _ftq_io_ras_update;	// frontend.scala:862:19
  wire [4:0]       _ftq_io_ras_update_idx;	// frontend.scala:862:19
  wire [39:0]      _ftq_io_ras_update_pc;	// frontend.scala:862:19
  wire             _fb_io_enq_ready;	// frontend.scala:861:19
  wire             _f4_io_enq_ready;	// frontend.scala:859:11
  wire             _f4_io_deq_valid;	// frontend.scala:859:11
  wire [39:0]      _f4_io_deq_bits_pc;	// frontend.scala:859:11
  wire             _f4_io_deq_bits_edge_inst_0;	// frontend.scala:859:11
  wire [31:0]      _f4_io_deq_bits_insts_0;	// frontend.scala:859:11
  wire [31:0]      _f4_io_deq_bits_insts_1;	// frontend.scala:859:11
  wire [31:0]      _f4_io_deq_bits_insts_2;	// frontend.scala:859:11
  wire [31:0]      _f4_io_deq_bits_insts_3;	// frontend.scala:859:11
  wire [31:0]      _f4_io_deq_bits_exp_insts_0;	// frontend.scala:859:11
  wire [31:0]      _f4_io_deq_bits_exp_insts_1;	// frontend.scala:859:11
  wire [31:0]      _f4_io_deq_bits_exp_insts_2;	// frontend.scala:859:11
  wire [31:0]      _f4_io_deq_bits_exp_insts_3;	// frontend.scala:859:11
  wire             _f4_io_deq_bits_sfbs_0;	// frontend.scala:859:11
  wire             _f4_io_deq_bits_sfbs_1;	// frontend.scala:859:11
  wire             _f4_io_deq_bits_sfbs_2;	// frontend.scala:859:11
  wire             _f4_io_deq_bits_sfbs_3;	// frontend.scala:859:11
  wire             _f4_io_deq_bits_shadowed_mask_0;	// frontend.scala:859:11
  wire             _f4_io_deq_bits_shadowed_mask_1;	// frontend.scala:859:11
  wire             _f4_io_deq_bits_shadowed_mask_2;	// frontend.scala:859:11
  wire             _f4_io_deq_bits_shadowed_mask_3;	// frontend.scala:859:11
  wire             _f4_io_deq_bits_cfi_idx_valid;	// frontend.scala:859:11
  wire [1:0]       _f4_io_deq_bits_cfi_idx_bits;	// frontend.scala:859:11
  wire [2:0]       _f4_io_deq_bits_cfi_type;	// frontend.scala:859:11
  wire             _f4_io_deq_bits_cfi_is_call;	// frontend.scala:859:11
  wire             _f4_io_deq_bits_cfi_is_ret;	// frontend.scala:859:11
  wire [39:0]      _f4_io_deq_bits_ras_top;	// frontend.scala:859:11
  wire [3:0]       _f4_io_deq_bits_mask;	// frontend.scala:859:11
  wire [3:0]       _f4_io_deq_bits_br_mask;	// frontend.scala:859:11
  wire [63:0]      _f4_io_deq_bits_ghist_old_history;	// frontend.scala:859:11
  wire             _f4_io_deq_bits_ghist_current_saw_branch_not_taken;	// frontend.scala:859:11
  wire             _f4_io_deq_bits_ghist_new_saw_branch_not_taken;	// frontend.scala:859:11
  wire             _f4_io_deq_bits_ghist_new_saw_branch_taken;	// frontend.scala:859:11
  wire [4:0]       _f4_io_deq_bits_ghist_ras_idx;	// frontend.scala:859:11
  wire             _f4_io_deq_bits_xcpt_pf_if;	// frontend.scala:859:11
  wire             _f4_io_deq_bits_xcpt_ae_if;	// frontend.scala:859:11
  wire             _f4_io_deq_bits_bp_debug_if_oh_0;	// frontend.scala:859:11
  wire             _f4_io_deq_bits_bp_debug_if_oh_1;	// frontend.scala:859:11
  wire             _f4_io_deq_bits_bp_debug_if_oh_2;	// frontend.scala:859:11
  wire             _f4_io_deq_bits_bp_debug_if_oh_3;	// frontend.scala:859:11
  wire             _f4_io_deq_bits_bp_xcpt_if_oh_0;	// frontend.scala:859:11
  wire             _f4_io_deq_bits_bp_xcpt_if_oh_1;	// frontend.scala:859:11
  wire             _f4_io_deq_bits_bp_xcpt_if_oh_2;	// frontend.scala:859:11
  wire             _f4_io_deq_bits_bp_xcpt_if_oh_3;	// frontend.scala:859:11
  wire [119:0]     _f4_io_deq_bits_bpd_meta_0;	// frontend.scala:859:11
  wire [1:0]       _f4_io_deq_bits_fsrc;	// frontend.scala:859:11
  wire             _f4_btb_corrections_io_deq_valid;	// frontend.scala:842:34
  wire             _f4_btb_corrections_io_deq_bits_is_mispredict_update;	// frontend.scala:842:34
  wire             _f4_btb_corrections_io_deq_bits_is_repair_update;	// frontend.scala:842:34
  wire [3:0]       _f4_btb_corrections_io_deq_bits_btb_mispredicts;	// frontend.scala:842:34
  wire [39:0]      _f4_btb_corrections_io_deq_bits_pc;	// frontend.scala:842:34
  wire [3:0]       _f4_btb_corrections_io_deq_bits_br_mask;	// frontend.scala:842:34
  wire             _f4_btb_corrections_io_deq_bits_cfi_idx_valid;	// frontend.scala:842:34
  wire [1:0]       _f4_btb_corrections_io_deq_bits_cfi_idx_bits;	// frontend.scala:842:34
  wire             _f4_btb_corrections_io_deq_bits_cfi_taken;	// frontend.scala:842:34
  wire             _f4_btb_corrections_io_deq_bits_cfi_mispredicted;	// frontend.scala:842:34
  wire             _f4_btb_corrections_io_deq_bits_cfi_is_br;	// frontend.scala:842:34
  wire             _f4_btb_corrections_io_deq_bits_cfi_is_jal;	// frontend.scala:842:34
  wire [63:0]      _f4_btb_corrections_io_deq_bits_ghist_old_history;	// frontend.scala:842:34
  wire [39:0]      _f4_btb_corrections_io_deq_bits_target;	// frontend.scala:842:34
  wire [119:0]     _f4_btb_corrections_io_deq_bits_meta_0;	// frontend.scala:842:34
  wire             _bpd_decoder_2_io_out_is_ret;	// frontend.scala:663:33
  wire             _bpd_decoder_2_io_out_is_call;	// frontend.scala:663:33
  wire [39:0]      _bpd_decoder_2_io_out_target;	// frontend.scala:663:33
  wire [2:0]       _bpd_decoder_2_io_out_cfi_type;	// frontend.scala:663:33
  wire             _bpd_decoder_2_io_out_sfb_offset_valid;	// frontend.scala:663:33
  wire [5:0]       _bpd_decoder_2_io_out_sfb_offset_bits;	// frontend.scala:663:33
  wire             _bpd_decoder_2_io_out_shadowable;	// frontend.scala:663:33
  wire [31:0]      _exp_inst_rvc_exp_2_io_out_bits;	// consts.scala:330:25
  wire             _exp_inst_rvc_exp_2_io_rvc;	// consts.scala:330:25
  wire             _bpd_decoder_1_io_out_is_ret;	// frontend.scala:663:33
  wire             _bpd_decoder_1_io_out_is_call;	// frontend.scala:663:33
  wire [39:0]      _bpd_decoder_1_io_out_target;	// frontend.scala:663:33
  wire [2:0]       _bpd_decoder_1_io_out_cfi_type;	// frontend.scala:663:33
  wire             _bpd_decoder_1_io_out_sfb_offset_valid;	// frontend.scala:663:33
  wire [5:0]       _bpd_decoder_1_io_out_sfb_offset_bits;	// frontend.scala:663:33
  wire             _bpd_decoder_1_io_out_shadowable;	// frontend.scala:663:33
  wire [31:0]      _exp_inst_rvc_exp_1_io_out_bits;	// consts.scala:330:25
  wire             _exp_inst_rvc_exp_1_io_rvc;	// consts.scala:330:25
  wire             _bpd_decoder_io_out_is_ret;	// frontend.scala:663:33
  wire             _bpd_decoder_io_out_is_call;	// frontend.scala:663:33
  wire [39:0]      _bpd_decoder_io_out_target;	// frontend.scala:663:33
  wire [2:0]       _bpd_decoder_io_out_cfi_type;	// frontend.scala:663:33
  wire             _bpd_decoder_io_out_sfb_offset_valid;	// frontend.scala:663:33
  wire [5:0]       _bpd_decoder_io_out_sfb_offset_bits;	// frontend.scala:663:33
  wire             _bpd_decoder_io_out_shadowable;	// frontend.scala:663:33
  wire [31:0]      _exp_inst_rvc_exp_io_out_bits;	// consts.scala:330:25
  wire             _exp_inst_rvc_exp_io_rvc;	// consts.scala:330:25
  wire             _bpd_decoder1_io_out_is_ret;	// frontend.scala:625:34
  wire             _bpd_decoder1_io_out_is_call;	// frontend.scala:625:34
  wire [39:0]      _bpd_decoder1_io_out_target;	// frontend.scala:625:34
  wire [2:0]       _bpd_decoder1_io_out_cfi_type;	// frontend.scala:625:34
  wire             _bpd_decoder1_io_out_sfb_offset_valid;	// frontend.scala:625:34
  wire [5:0]       _bpd_decoder1_io_out_sfb_offset_bits;	// frontend.scala:625:34
  wire             _bpd_decoder1_io_out_shadowable;	// frontend.scala:625:34
  wire             _bpd_decoder0_io_out_is_ret;	// frontend.scala:622:34
  wire             _bpd_decoder0_io_out_is_call;	// frontend.scala:622:34
  wire [39:0]      _bpd_decoder0_io_out_target;	// frontend.scala:622:34
  wire [2:0]       _bpd_decoder0_io_out_cfi_type;	// frontend.scala:622:34
  wire             _bpd_decoder0_io_out_sfb_offset_valid;	// frontend.scala:622:34
  wire [5:0]       _bpd_decoder0_io_out_sfb_offset_bits;	// frontend.scala:622:34
  wire             _bpd_decoder0_io_out_shadowable;	// frontend.scala:622:34
  wire [31:0]      _exp_inst1_rvc_exp_io_out_bits;	// consts.scala:330:25
  wire             _exp_inst1_rvc_exp_io_rvc;	// consts.scala:330:25
  wire [31:0]      _exp_inst0_rvc_exp_io_out_bits;	// consts.scala:330:25
  wire             _exp_inst0_rvc_exp_io_rvc;	// consts.scala:330:25
  wire             _f3_bpd_resp_io_enq_ready;	// frontend.scala:521:11
  wire [39:0]      _f3_bpd_resp_io_deq_bits_pc;	// frontend.scala:521:11
  wire             _f3_bpd_resp_io_deq_bits_preds_0_taken;	// frontend.scala:521:11
  wire             _f3_bpd_resp_io_deq_bits_preds_0_predicted_pc_valid;	// frontend.scala:521:11
  wire [39:0]      _f3_bpd_resp_io_deq_bits_preds_0_predicted_pc_bits;	// frontend.scala:521:11
  wire             _f3_bpd_resp_io_deq_bits_preds_1_taken;	// frontend.scala:521:11
  wire             _f3_bpd_resp_io_deq_bits_preds_1_predicted_pc_valid;	// frontend.scala:521:11
  wire [39:0]      _f3_bpd_resp_io_deq_bits_preds_1_predicted_pc_bits;	// frontend.scala:521:11
  wire             _f3_bpd_resp_io_deq_bits_preds_2_taken;	// frontend.scala:521:11
  wire             _f3_bpd_resp_io_deq_bits_preds_2_predicted_pc_valid;	// frontend.scala:521:11
  wire [39:0]      _f3_bpd_resp_io_deq_bits_preds_2_predicted_pc_bits;	// frontend.scala:521:11
  wire             _f3_bpd_resp_io_deq_bits_preds_3_taken;	// frontend.scala:521:11
  wire             _f3_bpd_resp_io_deq_bits_preds_3_predicted_pc_valid;	// frontend.scala:521:11
  wire [39:0]      _f3_bpd_resp_io_deq_bits_preds_3_predicted_pc_bits;	// frontend.scala:521:11
  wire [119:0]     _f3_bpd_resp_io_deq_bits_meta_0;	// frontend.scala:521:11
  wire             _f3_bpd_resp_io_deq_bits_lhist_0;	// frontend.scala:521:11
  wire             _f3_io_enq_ready;	// frontend.scala:516:11
  wire             _f3_io_deq_valid;	// frontend.scala:516:11
  wire [39:0]      _f3_io_deq_bits_pc;	// frontend.scala:516:11
  wire [63:0]      _f3_io_deq_bits_data;	// frontend.scala:516:11
  wire [3:0]       _f3_io_deq_bits_mask;	// frontend.scala:516:11
  wire             _f3_io_deq_bits_xcpt_pf_inst;	// frontend.scala:516:11
  wire             _f3_io_deq_bits_xcpt_ae_inst;	// frontend.scala:516:11
  wire [63:0]      _f3_io_deq_bits_ghist_old_history;	// frontend.scala:516:11
  wire             _f3_io_deq_bits_ghist_current_saw_branch_not_taken;	// frontend.scala:516:11
  wire             _f3_io_deq_bits_ghist_new_saw_branch_not_taken;	// frontend.scala:516:11
  wire             _f3_io_deq_bits_ghist_new_saw_branch_taken;	// frontend.scala:516:11
  wire [4:0]       _f3_io_deq_bits_ghist_ras_idx;	// frontend.scala:516:11
  wire [1:0]       _f3_io_deq_bits_fsrc;	// frontend.scala:516:11
  wire [1:0]       _f3_io_deq_bits_tsrc;	// frontend.scala:516:11
  wire             _tlb_io_resp_miss;	// frontend.scala:339:19
  wire [31:0]      _tlb_io_resp_paddr;	// frontend.scala:339:19
  wire             _tlb_io_resp_pf_inst;	// frontend.scala:339:19
  wire             _tlb_io_resp_ae_inst;	// frontend.scala:339:19
  wire             _tlb_io_ptw_req_valid;	// frontend.scala:339:19
  wire [39:0]      _ras_io_read_addr;	// frontend.scala:335:19
  wire             _bpd_io_resp_f1_preds_0_taken;	// frontend.scala:333:19
  wire             _bpd_io_resp_f1_preds_0_is_br;	// frontend.scala:333:19
  wire             _bpd_io_resp_f1_preds_0_is_jal;	// frontend.scala:333:19
  wire             _bpd_io_resp_f1_preds_0_predicted_pc_valid;	// frontend.scala:333:19
  wire [39:0]      _bpd_io_resp_f1_preds_0_predicted_pc_bits;	// frontend.scala:333:19
  wire             _bpd_io_resp_f1_preds_1_taken;	// frontend.scala:333:19
  wire             _bpd_io_resp_f1_preds_1_is_br;	// frontend.scala:333:19
  wire             _bpd_io_resp_f1_preds_1_is_jal;	// frontend.scala:333:19
  wire             _bpd_io_resp_f1_preds_1_predicted_pc_valid;	// frontend.scala:333:19
  wire [39:0]      _bpd_io_resp_f1_preds_1_predicted_pc_bits;	// frontend.scala:333:19
  wire             _bpd_io_resp_f1_preds_2_taken;	// frontend.scala:333:19
  wire             _bpd_io_resp_f1_preds_2_is_br;	// frontend.scala:333:19
  wire             _bpd_io_resp_f1_preds_2_is_jal;	// frontend.scala:333:19
  wire             _bpd_io_resp_f1_preds_2_predicted_pc_valid;	// frontend.scala:333:19
  wire [39:0]      _bpd_io_resp_f1_preds_2_predicted_pc_bits;	// frontend.scala:333:19
  wire             _bpd_io_resp_f1_preds_3_taken;	// frontend.scala:333:19
  wire             _bpd_io_resp_f1_preds_3_is_br;	// frontend.scala:333:19
  wire             _bpd_io_resp_f1_preds_3_is_jal;	// frontend.scala:333:19
  wire             _bpd_io_resp_f1_preds_3_predicted_pc_valid;	// frontend.scala:333:19
  wire [39:0]      _bpd_io_resp_f1_preds_3_predicted_pc_bits;	// frontend.scala:333:19
  wire             _bpd_io_resp_f2_preds_0_taken;	// frontend.scala:333:19
  wire             _bpd_io_resp_f2_preds_0_is_br;	// frontend.scala:333:19
  wire             _bpd_io_resp_f2_preds_0_is_jal;	// frontend.scala:333:19
  wire             _bpd_io_resp_f2_preds_0_predicted_pc_valid;	// frontend.scala:333:19
  wire [39:0]      _bpd_io_resp_f2_preds_0_predicted_pc_bits;	// frontend.scala:333:19
  wire             _bpd_io_resp_f2_preds_1_taken;	// frontend.scala:333:19
  wire             _bpd_io_resp_f2_preds_1_is_br;	// frontend.scala:333:19
  wire             _bpd_io_resp_f2_preds_1_is_jal;	// frontend.scala:333:19
  wire             _bpd_io_resp_f2_preds_1_predicted_pc_valid;	// frontend.scala:333:19
  wire [39:0]      _bpd_io_resp_f2_preds_1_predicted_pc_bits;	// frontend.scala:333:19
  wire             _bpd_io_resp_f2_preds_2_taken;	// frontend.scala:333:19
  wire             _bpd_io_resp_f2_preds_2_is_br;	// frontend.scala:333:19
  wire             _bpd_io_resp_f2_preds_2_is_jal;	// frontend.scala:333:19
  wire             _bpd_io_resp_f2_preds_2_predicted_pc_valid;	// frontend.scala:333:19
  wire [39:0]      _bpd_io_resp_f2_preds_2_predicted_pc_bits;	// frontend.scala:333:19
  wire             _bpd_io_resp_f2_preds_3_taken;	// frontend.scala:333:19
  wire             _bpd_io_resp_f2_preds_3_is_br;	// frontend.scala:333:19
  wire             _bpd_io_resp_f2_preds_3_is_jal;	// frontend.scala:333:19
  wire             _bpd_io_resp_f2_preds_3_predicted_pc_valid;	// frontend.scala:333:19
  wire [39:0]      _bpd_io_resp_f2_preds_3_predicted_pc_bits;	// frontend.scala:333:19
  wire [39:0]      _bpd_io_resp_f3_pc;	// frontend.scala:333:19
  wire             _bpd_io_resp_f3_preds_0_taken;	// frontend.scala:333:19
  wire             _bpd_io_resp_f3_preds_0_is_br;	// frontend.scala:333:19
  wire             _bpd_io_resp_f3_preds_0_is_jal;	// frontend.scala:333:19
  wire             _bpd_io_resp_f3_preds_0_predicted_pc_valid;	// frontend.scala:333:19
  wire [39:0]      _bpd_io_resp_f3_preds_0_predicted_pc_bits;	// frontend.scala:333:19
  wire             _bpd_io_resp_f3_preds_1_taken;	// frontend.scala:333:19
  wire             _bpd_io_resp_f3_preds_1_is_br;	// frontend.scala:333:19
  wire             _bpd_io_resp_f3_preds_1_is_jal;	// frontend.scala:333:19
  wire             _bpd_io_resp_f3_preds_1_predicted_pc_valid;	// frontend.scala:333:19
  wire [39:0]      _bpd_io_resp_f3_preds_1_predicted_pc_bits;	// frontend.scala:333:19
  wire             _bpd_io_resp_f3_preds_2_taken;	// frontend.scala:333:19
  wire             _bpd_io_resp_f3_preds_2_is_br;	// frontend.scala:333:19
  wire             _bpd_io_resp_f3_preds_2_is_jal;	// frontend.scala:333:19
  wire             _bpd_io_resp_f3_preds_2_predicted_pc_valid;	// frontend.scala:333:19
  wire [39:0]      _bpd_io_resp_f3_preds_2_predicted_pc_bits;	// frontend.scala:333:19
  wire             _bpd_io_resp_f3_preds_3_taken;	// frontend.scala:333:19
  wire             _bpd_io_resp_f3_preds_3_is_br;	// frontend.scala:333:19
  wire             _bpd_io_resp_f3_preds_3_is_jal;	// frontend.scala:333:19
  wire             _bpd_io_resp_f3_preds_3_predicted_pc_valid;	// frontend.scala:333:19
  wire [39:0]      _bpd_io_resp_f3_preds_3_predicted_pc_bits;	// frontend.scala:333:19
  wire [119:0]     _bpd_io_resp_f3_meta_0;	// frontend.scala:333:19
  wire             _icache_io_resp_valid;	// frontend.scala:300:26
  wire [63:0]      _icache_io_resp_bits_data;	// frontend.scala:300:26
  reg              REG;	// frontend.scala:363:16
  wire             _GEN_0 = REG & ~reset;	// frontend.scala:363:{16,31,34}
  reg  [39:0]      s1_vpc;	// frontend.scala:381:29
  reg              s1_valid;	// frontend.scala:382:29
  reg  [63:0]      s1_ghist_old_history;	// frontend.scala:383:29
  reg              s1_ghist_current_saw_branch_not_taken;	// frontend.scala:383:29
  reg              s1_ghist_new_saw_branch_not_taken;	// frontend.scala:383:29
  reg              s1_ghist_new_saw_branch_taken;	// frontend.scala:383:29
  reg  [4:0]       s1_ghist_ras_idx;	// frontend.scala:383:29
  reg              s1_is_replay;	// frontend.scala:384:29
  reg              s1_is_sfence;	// frontend.scala:385:29
  reg  [1:0]       s1_tsrc;	// frontend.scala:387:29
  reg              tlb_io_sfence_REG_valid;	// frontend.scala:393:35
  reg              tlb_io_sfence_REG_bits_rs1;	// frontend.scala:393:35
  reg              tlb_io_sfence_REG_bits_rs2;	// frontend.scala:393:35
  reg  [38:0]      tlb_io_sfence_REG_bits_addr;	// frontend.scala:393:35
  wire             s1_tlb_miss = ~s1_is_replay & _tlb_io_resp_miss;	// frontend.scala:339:19, :384:29, :388:41, :396:35
  reg              s1_tlb_resp_REG_pf_inst;	// frontend.scala:397:46
  reg              s1_tlb_resp_REG_ae_inst;	// frontend.scala:397:46
  reg  [31:0]      s1_ppc_REG;	// frontend.scala:398:42
  wire [6:0]       f1_mask = 7'hF << s1_vpc[2:1];	// frontend.scala:178:31, :381:29, package.scala:154:13
  wire             f1_redirects_0 =
    s1_valid & f1_mask[0] & _bpd_io_resp_f1_preds_0_predicted_pc_valid
    & (_bpd_io_resp_f1_preds_0_is_jal | _bpd_io_resp_f1_preds_0_is_br
       & _bpd_io_resp_f1_preds_0_taken);	// frontend.scala:178:31, :333:19, :382:29, :406:{24,71}, :407:34, :408:35
  wire             f1_redirects_1 =
    s1_valid & f1_mask[1] & _bpd_io_resp_f1_preds_1_predicted_pc_valid
    & (_bpd_io_resp_f1_preds_1_is_jal | _bpd_io_resp_f1_preds_1_is_br
       & _bpd_io_resp_f1_preds_1_taken);	// frontend.scala:178:31, :333:19, :382:29, :406:{24,71}, :407:34, :408:35
  wire             f1_redirects_2 =
    s1_valid & f1_mask[2] & _bpd_io_resp_f1_preds_2_predicted_pc_valid
    & (_bpd_io_resp_f1_preds_2_is_jal | _bpd_io_resp_f1_preds_2_is_br
       & _bpd_io_resp_f1_preds_2_taken);	// frontend.scala:178:31, :333:19, :382:29, :406:{24,71}, :407:34, :408:35
  wire [1:0]       f1_redirect_idx =
    f1_redirects_0 ? 2'h0 : f1_redirects_1 ? 2'h1 : {1'h1, ~f1_redirects_2};	// Mux.scala:47:69, frontend.scala:300:26, :339:19, :406:71, :503:20, :925:34, :928:9
  wire             f1_do_redirect =
    f1_redirects_0 | f1_redirects_1 | f1_redirects_2 | s1_valid & f1_mask[3]
    & _bpd_io_resp_f1_preds_3_predicted_pc_valid
    & (_bpd_io_resp_f1_preds_3_is_jal | _bpd_io_resp_f1_preds_3_is_br
       & _bpd_io_resp_f1_preds_3_taken);	// frontend.scala:178:31, :333:19, :382:29, :406:{24,71}, :407:34, :408:35, :411:45
  wire [3:0][39:0] _GEN_1 =
    {{_bpd_io_resp_f1_preds_3_predicted_pc_bits},
     {_bpd_io_resp_f1_preds_2_predicted_pc_bits},
     {_bpd_io_resp_f1_preds_1_predicted_pc_bits},
     {_bpd_io_resp_f1_preds_0_predicted_pc_bits}};	// frontend.scala:333:19, package.scala:32:{76,86}
  wire [39:0]      _f1_predicted_target_T_9 = {s1_vpc[39:3], 3'h0} + 40'h8;	// frontend.scala:168:23, :178:31, :381:29
  wire [3:0]       _GEN_2 =
    {{_bpd_io_resp_f1_preds_3_taken},
     {_bpd_io_resp_f1_preds_2_taken},
     {_bpd_io_resp_f1_preds_1_taken},
     {_bpd_io_resp_f1_preds_0_taken}};	// frontend.scala:333:19, :419:46
  wire [3:0]       _GEN_3 =
    {{_bpd_io_resp_f1_preds_3_is_br},
     {_bpd_io_resp_f1_preds_2_is_br},
     {_bpd_io_resp_f1_preds_1_is_br},
     {_bpd_io_resp_f1_preds_0_is_br}};	// frontend.scala:333:19, :419:46
  wire [3:0]       f1_predicted_ghist_cfi_idx_oh = 4'h1 << f1_redirect_idx;	// Mux.scala:47:69, OneHot.scala:58:35
  wire [2:0]       _GEN_4 =
    f1_predicted_ghist_cfi_idx_oh[2:0] | f1_predicted_ghist_cfi_idx_oh[3:1];	// OneHot.scala:58:35, frontend.scala:364:16, util.scala:373:{29,45}
  wire [1:0]       _GEN_5 = _GEN_4[1:0] | f1_predicted_ghist_cfi_idx_oh[3:2];	// Mux.scala:47:69, OneHot.scala:58:35, frontend.scala:364:16, util.scala:373:{29,45}
  wire             _f1_predicted_ghist_new_history_old_history_T =
    _GEN_3[f1_redirect_idx] & _GEN_2[f1_redirect_idx] & f1_do_redirect;	// Mux.scala:47:69, frontend.scala:91:84, :411:45, :419:46
  wire [63:0]      _f1_predicted_ghist_new_history_old_history_T_6 =
    _f1_predicted_ghist_new_history_old_history_T & f1_do_redirect
      ? {s1_ghist_old_history[62:0], 1'h1}
      : (|(f1_mask[3:0]
           & {_bpd_io_resp_f1_preds_3_is_br & _bpd_io_resp_f1_preds_3_predicted_pc_valid,
              _bpd_io_resp_f1_preds_2_is_br & _bpd_io_resp_f1_preds_2_predicted_pc_valid,
              _bpd_io_resp_f1_preds_1_is_br & _bpd_io_resp_f1_preds_1_predicted_pc_valid,
              _bpd_io_resp_f1_preds_0_is_br & _bpd_io_resp_f1_preds_0_predicted_pc_valid}
           & (f1_do_redirect
                ? {&f1_redirect_idx, _GEN_4[2], _GEN_5[1], _GEN_5[0] | (&f1_redirect_idx)}
                  & ~(_f1_predicted_ghist_new_history_old_history_T
                        ? f1_predicted_ghist_cfi_idx_oh
                        : 4'h0)
                : 4'hF))) | s1_ghist_current_saw_branch_not_taken
          ? {s1_ghist_old_history[62:0], 1'h0}
          : s1_ghist_old_history;	// Cat.scala:30:58, Mux.scala:47:69, OneHot.scala:58:35, frontend.scala:90:{39,44}, :91:{67,69,73,84}, :98:{53,61}, :99:{37,61,91,96}, :100:37, :178:31, :300:26, :333:19, :339:19, :364:16, :367:16, :383:29, :411:45, :418:{40,72}, :521:11, :569:29, :606:23, :842:34, :859:11, :861:19, :862:19, :925:34, :928:9, util.scala:373:{29,45}
  wire             _GEN_6 = s1_valid & ~s1_tlb_miss;	// frontend.scala:382:29, :396:35, :427:{18,21}
  reg              s2_valid;	// frontend.scala:440:25
  reg  [39:0]      s2_vpc;	// frontend.scala:441:25
  reg  [63:0]      s2_ghist_old_history;	// frontend.scala:442:21
  reg              s2_ghist_current_saw_branch_not_taken;	// frontend.scala:442:21
  reg              s2_ghist_new_saw_branch_not_taken;	// frontend.scala:442:21
  reg              s2_ghist_new_saw_branch_taken;	// frontend.scala:442:21
  reg  [4:0]       s2_ghist_ras_idx;	// frontend.scala:442:21
  reg  [31:0]      s2_ppc;	// frontend.scala:444:24
  reg  [1:0]       s2_tsrc;	// frontend.scala:445:24
  reg              s2_tlb_resp_pf_inst;	// frontend.scala:448:28
  reg              s2_tlb_resp_ae_inst;	// frontend.scala:448:28
  reg              s2_tlb_miss;	// frontend.scala:449:28
  reg              s2_is_replay_REG;	// frontend.scala:450:29
  wire             s2_is_replay = s2_is_replay_REG & s2_valid;	// frontend.scala:440:25, :450:{29,44}
  wire             _f3_io_enq_valid_T_2 = s2_tlb_resp_ae_inst | s2_tlb_resp_pf_inst;	// frontend.scala:448:28, :451:50
  wire             s2_xcpt = s2_valid & _f3_io_enq_valid_T_2 & ~s2_is_replay;	// frontend.scala:440:25, :450:44, :451:{50,74,77}
  wire [6:0]       _GEN_7 = {5'h0, s2_vpc[2:1]};	// frontend.scala:178:31, :350:45, :441:25, package.scala:154:13
  wire [6:0]       f2_mask = 7'hF << _GEN_7;	// frontend.scala:178:31
  wire             f2_redirects_0 =
    s2_valid & f2_mask[0] & _bpd_io_resp_f2_preds_0_predicted_pc_valid
    & (_bpd_io_resp_f2_preds_0_is_jal | _bpd_io_resp_f2_preds_0_is_br
       & _bpd_io_resp_f2_preds_0_taken);	// frontend.scala:178:31, :333:19, :440:25, :459:{24,71}, :460:34, :461:35
  wire             f2_redirects_1 =
    s2_valid & f2_mask[1] & _bpd_io_resp_f2_preds_1_predicted_pc_valid
    & (_bpd_io_resp_f2_preds_1_is_jal | _bpd_io_resp_f2_preds_1_is_br
       & _bpd_io_resp_f2_preds_1_taken);	// frontend.scala:178:31, :333:19, :440:25, :459:{24,71}, :460:34, :461:35
  wire             f2_redirects_2 =
    s2_valid & f2_mask[2] & _bpd_io_resp_f2_preds_2_predicted_pc_valid
    & (_bpd_io_resp_f2_preds_2_is_jal | _bpd_io_resp_f2_preds_2_is_br
       & _bpd_io_resp_f2_preds_2_taken);	// frontend.scala:178:31, :333:19, :440:25, :459:{24,71}, :460:34, :461:35
  wire [1:0]       f2_redirect_idx =
    f2_redirects_0 ? 2'h0 : f2_redirects_1 ? 2'h1 : {1'h1, ~f2_redirects_2};	// Mux.scala:47:69, frontend.scala:300:26, :339:19, :459:71, :503:20, :925:34, :928:9
  wire             f2_do_redirect =
    f2_redirects_0 | f2_redirects_1 | f2_redirects_2 | s2_valid & f2_mask[3]
    & _bpd_io_resp_f2_preds_3_predicted_pc_valid
    & (_bpd_io_resp_f2_preds_3_is_jal | _bpd_io_resp_f2_preds_3_is_br
       & _bpd_io_resp_f2_preds_3_taken);	// frontend.scala:178:31, :333:19, :440:25, :459:{24,71}, :460:34, :461:35, :465:45
  wire [3:0][39:0] _GEN_8 =
    {{_bpd_io_resp_f2_preds_3_predicted_pc_bits},
     {_bpd_io_resp_f2_preds_2_predicted_pc_bits},
     {_bpd_io_resp_f2_preds_1_predicted_pc_bits},
     {_bpd_io_resp_f2_preds_0_predicted_pc_bits}};	// frontend.scala:333:19, package.scala:32:{76,86}
  wire [39:0]      _f2_predicted_target_T_9 = {s2_vpc[39:3], 3'h0} + 40'h8;	// frontend.scala:168:23, :178:31, :441:25
  wire [39:0]      f2_predicted_target =
    f2_do_redirect ? _GEN_8[f2_redirect_idx] : _f2_predicted_target_T_9;	// Mux.scala:47:69, frontend.scala:168:23, :465:45, :466:32, package.scala:32:{76,86}
  wire [3:0]       _GEN_9 =
    {{_bpd_io_resp_f2_preds_3_taken},
     {_bpd_io_resp_f2_preds_2_taken},
     {_bpd_io_resp_f2_preds_1_taken},
     {_bpd_io_resp_f2_preds_0_taken}};	// frontend.scala:333:19, :471:46
  wire [3:0]       _GEN_10 =
    {{_bpd_io_resp_f2_preds_3_is_br},
     {_bpd_io_resp_f2_preds_2_is_br},
     {_bpd_io_resp_f2_preds_1_is_br},
     {_bpd_io_resp_f2_preds_0_is_br}};	// frontend.scala:333:19, :471:46
  wire [3:0]       f2_predicted_ghist_cfi_idx_oh = 4'h1 << f2_redirect_idx;	// Mux.scala:47:69, OneHot.scala:58:35
  wire [2:0]       _GEN_11 =
    f2_predicted_ghist_cfi_idx_oh[2:0] | f2_predicted_ghist_cfi_idx_oh[3:1];	// OneHot.scala:58:35, frontend.scala:364:16, util.scala:373:{29,45}
  wire [1:0]       _GEN_12 = _GEN_11[1:0] | f2_predicted_ghist_cfi_idx_oh[3:2];	// Mux.scala:47:69, OneHot.scala:58:35, frontend.scala:364:16, util.scala:373:{29,45}
  wire             _f2_predicted_ghist_new_history_old_history_T =
    _GEN_10[f2_redirect_idx] & _GEN_9[f2_redirect_idx] & f2_do_redirect;	// Mux.scala:47:69, frontend.scala:91:84, :465:45, :471:46
  wire [63:0]      _f2_predicted_ghist_new_history_old_history_T_6 =
    _f2_predicted_ghist_new_history_old_history_T & f2_do_redirect
      ? {s2_ghist_old_history[62:0], 1'h1}
      : (|(f2_mask[3:0]
           & {_bpd_io_resp_f2_preds_3_is_br & _bpd_io_resp_f2_preds_3_predicted_pc_valid,
              _bpd_io_resp_f2_preds_2_is_br & _bpd_io_resp_f2_preds_2_predicted_pc_valid,
              _bpd_io_resp_f2_preds_1_is_br & _bpd_io_resp_f2_preds_1_predicted_pc_valid,
              _bpd_io_resp_f2_preds_0_is_br & _bpd_io_resp_f2_preds_0_predicted_pc_valid}
           & (f2_do_redirect
                ? {&f2_redirect_idx,
                   _GEN_11[2],
                   _GEN_12[1],
                   _GEN_12[0] | (&f2_redirect_idx)}
                  & ~(_f2_predicted_ghist_new_history_old_history_T
                        ? f2_predicted_ghist_cfi_idx_oh
                        : 4'h0)
                : 4'hF))) | s2_ghist_current_saw_branch_not_taken
          ? {s2_ghist_old_history[62:0], 1'h0}
          : s2_ghist_old_history;	// Cat.scala:30:58, Mux.scala:47:69, OneHot.scala:58:35, frontend.scala:90:{39,44}, :91:{67,69,73,84}, :98:{53,61}, :99:{37,61,91,96}, :100:37, :178:31, :300:26, :333:19, :339:19, :364:16, :367:16, :442:21, :465:45, :470:{40,72}, :521:11, :569:29, :606:23, :842:34, :859:11, :861:19, :862:19, :925:34, :928:9, util.scala:373:{29,45}
  wire             _f2_correct_f1_ghist_T_4 =
    s1_ghist_old_history == _f2_predicted_ghist_new_history_old_history_T_6
    & ~s1_ghist_new_saw_branch_not_taken & ~s1_ghist_new_saw_branch_taken;	// frontend.scala:76:19, :77:{32,68}, :78:28, :99:37, :383:29
  wire             _s0_is_replay_T = s2_valid & _icache_io_resp_valid;	// frontend.scala:300:26, :440:25, :482:19
  wire             _GEN_13 =
    s2_valid & ~_icache_io_resp_valid | _s0_is_replay_T & ~_f3_io_enq_ready;	// frontend.scala:300:26, :440:25, :481:{19,22,45}, :482:{19,43,46}, :516:11
  wire             _GEN_14 = s2_valid & _f3_io_enq_ready;	// frontend.scala:440:25, :491:25, :516:11
  wire             _GEN_15 =
    s1_valid & (s1_vpc != f2_predicted_target | ~_f2_correct_f1_ghist_T_4) | ~s1_valid;	// frontend.scala:77:68, :81:41, :381:29, :382:29, :466:32, :496:{21,32,56,81,84}
  wire             _GEN_16 = _GEN_14 & _GEN_15;	// frontend.scala:491:{25,38}, :496:{81,95}
  wire             _GEN_17 = _GEN_14 & _GEN_15;	// frontend.scala:427:35, :491:{25,38}, :496:{81,95}, :499:20
  wire             _GEN_18 = reset | f4_clear;	// frontend.scala:515:35, :953:30, :954:17, :965:38
  wire             _f3_io_enq_valid_T_6 =
    s2_valid & ~f2_clear & (_icache_io_resp_valid | _f3_io_enq_valid_T_2 & ~s2_tlb_miss);	// frontend.scala:300:26, :440:25, :449:28, :451:50, :528:{37,47}, :529:{27,76,79}, :814:38, :953:30, :957:17, :965:38, :969:17
  wire [6:0]       _f3_io_enq_bits_mask_T = 7'hF << _GEN_7;	// frontend.scala:178:31
  reg  [4:0]       ras_read_idx;	// frontend.scala:540:29
  wire             _GEN_19 = _f3_io_enq_ready & _f3_io_enq_valid_T_6;	// Decoupled.scala:40:37, frontend.scala:516:11, :528:47
  reg              f3_bpd_resp_io_enq_valid_REG;	// frontend.scala:549:57
  wire             _f3_bpd_resp_io_enq_valid_T =
    _f3_io_deq_valid & f3_bpd_resp_io_enq_valid_REG;	// frontend.scala:516:11, :549:{47,57}
  wire [3:0]       f3_fetch_bundle_br_mask =
    {f3_br_mask_3, f3_br_mask_2, f3_br_mask_1, f3_br_mask_0};	// frontend.scala:577:41, :736:37
  reg  [15:0]      f3_prev_half;	// frontend.scala:587:28
  reg              f3_prev_is_half;	// frontend.scala:589:32
  wire [31:0]      inst0 = {_f3_io_deq_bits_data[15:0], f3_prev_half};	// Cat.scala:30:58, frontend.scala:516:11, :587:28, :615:34
  wire [31:0]      exp_inst0 =
    _exp_inst0_rvc_exp_io_rvc ? _exp_inst0_rvc_exp_io_out_bits : inst0;	// Cat.scala:30:58, consts.scala:330:25, :332:8
  wire [31:0]      exp_inst1 =
    _exp_inst1_rvc_exp_io_rvc
      ? _exp_inst1_rvc_exp_io_out_bits
      : _f3_io_deq_bits_data[31:0];	// consts.scala:330:25, :332:8, frontend.scala:516:11, :616:30
  wire [39:0]      _GEN_20 = {_f3_io_deq_bits_pc[39:3], 3'h0};	// frontend.scala:178:31, :516:11, :619:69
  wire [31:0]      bank_insts_0 = f3_prev_is_half ? inst0 : _f3_io_deq_bits_data[31:0];	// Cat.scala:30:58, frontend.scala:516:11, :589:32, :616:30, :629:34, :630:40, :651:40
  wire [2:0]       brsigs_cfi_type =
    f3_prev_is_half ? _bpd_decoder0_io_out_cfi_type : _bpd_decoder1_io_out_cfi_type;	// frontend.scala:589:32, :622:34, :625:34, :629:34, :634:40, :655:40
  wire [39:0]      brsigs_target =
    f3_prev_is_half ? _bpd_decoder0_io_out_target : _bpd_decoder1_io_out_target;	// frontend.scala:589:32, :622:34, :625:34, :629:34, :634:40, :655:40
  assign f3_mask_0 = _f3_io_deq_valid & _f3_io_deq_bits_mask[0];	// frontend.scala:516:11, :689:58, :690:39
  wire             _f3_redirects_0_T_1 = brsigs_cfi_type == 3'h3;	// frontend.scala:629:34, :634:40, :655:40, :691:43
  wire             _f3_redirects_0_T = brsigs_cfi_type == 3'h2;	// frontend.scala:629:34, :634:40, :655:40, :696:49
  wire             f3_btb_mispredicts_0 =
    _f3_redirects_0_T & _f3_bpd_resp_io_deq_bits_preds_0_predicted_pc_valid
    & _f3_bpd_resp_io_deq_bits_preds_0_predicted_pc_bits != brsigs_target;	// frontend.scala:521:11, :629:34, :634:40, :655:40, :696:49, :697:61, :698:61
  wire [6:0]       _offset_from_aligned_pc_T_4 =
    {1'h0,
     f3_prev_is_half
       ? _bpd_decoder0_io_out_sfb_offset_bits
       : _bpd_decoder1_io_out_sfb_offset_bits} - {5'h0, f3_prev_is_half, 1'h0};	// frontend.scala:300:26, :333:19, :339:19, :350:45, :521:11, :569:29, :589:32, :606:23, :622:34, :625:34, :629:34, :634:40, :655:40, :709:32, :842:34, :859:11, :861:19, :862:19, :925:34
  wire [15:0]      _upper_mask_T_1 = 16'h1 << _offset_from_aligned_pc_T_4[4:1];	// OneHot.scala:58:35, frontend.scala:709:32, :715:52
  wire             _GEN_21 = _offset_from_aligned_pc_T_4[4:1] == 4'h0;	// frontend.scala:709:32, :715:52, util.scala:384:37
  wire [5:0]       _GEN_22 = _upper_mask_T_1[6:1] | _upper_mask_T_1[5:0];	// OneHot.scala:58:35, util.scala:384:{37,54}
  wire [4:0]       _GEN_23 = _GEN_22[5:1] | _upper_mask_T_1[4:0];	// OneHot.scala:58:35, util.scala:384:{37,54}
  wire [3:0]       _GEN_24 = _GEN_23[4:1] | _upper_mask_T_1[3:0];	// OneHot.scala:58:35, util.scala:384:{37,54}
  wire [2:0]       _GEN_25 = _GEN_24[3:1] | _upper_mask_T_1[2:0];	// OneHot.scala:58:35, util.scala:384:{37,54}
  wire [1:0]       _GEN_26 = _GEN_25[2:1] | _upper_mask_T_1[1:0];	// OneHot.scala:58:35, util.scala:384:{37,54}
  wire             _s0_valid_T_11 =
    _f3_io_deq_bits_xcpt_pf_inst | _f3_io_deq_bits_xcpt_ae_inst;	// frontend.scala:516:11, :723:75
  wire             _f3_br_mask_0_T = brsigs_cfi_type == 3'h1;	// frontend.scala:629:34, :634:40, :655:40, :733:26
  wire             f3_redirects_0 =
    f3_mask_0
    & (_f3_redirects_0_T | _f3_redirects_0_T_1 | _f3_br_mask_0_T
       & _f3_bpd_resp_io_deq_bits_preds_0_taken);	// frontend.scala:521:11, :690:39, :691:43, :696:49, :731:40, :732:69, :733:{26,37}
  assign f3_br_mask_0 = f3_mask_0 & _f3_br_mask_0_T;	// frontend.scala:690:39, :733:26, :736:37
  wire [31:0]      f3_fetch_bundle_exp_insts_1 =
    _exp_inst_rvc_exp_io_rvc ? _exp_inst_rvc_exp_io_out_bits : inst;	// consts.scala:330:25, :332:8, frontend.scala:674:29
  assign inst = _f3_io_deq_bits_data[47:16];	// frontend.scala:516:11, :674:29
  wire             valid_1 =
    f3_prev_is_half
    | ~(_f3_io_deq_valid & _f3_io_deq_bits_mask[0] & (&(bank_insts_0[1:0])));	// frontend.scala:516:11, :589:32, :592:{32,38}, :629:34, :630:40, :651:40, :675:{38,41,56}, :689:58
  assign f3_mask_1 =
    _f3_io_deq_valid & _f3_io_deq_bits_mask[1] & valid_1 & ~f3_redirects_0;	// frontend.scala:516:11, :675:38, :689:{58,74}, :690:71, :731:40
  wire             _f3_redirects_1_T_1 = _bpd_decoder_io_out_cfi_type == 3'h3;	// frontend.scala:663:33, :691:43
  wire             _f3_redirects_1_T = _bpd_decoder_io_out_cfi_type == 3'h2;	// frontend.scala:663:33, :696:49
  wire             f3_btb_mispredicts_1 =
    _f3_redirects_1_T & valid_1 & _f3_bpd_resp_io_deq_bits_preds_1_predicted_pc_valid
    & _f3_bpd_resp_io_deq_bits_preds_1_predicted_pc_bits != _bpd_decoder_io_out_target;	// frontend.scala:521:11, :663:33, :675:38, :696:49, :697:61, :698:61
  wire [6:0]       _offset_from_aligned_pc_T_5 =
    {1'h0, _bpd_decoder_io_out_sfb_offset_bits} + 7'h2;	// frontend.scala:300:26, :333:19, :339:19, :521:11, :569:29, :606:23, :663:33, :708:50, :842:34, :859:11, :861:19, :862:19, :925:34
  wire [15:0]      _upper_mask_T_5 = 16'h1 << _offset_from_aligned_pc_T_5[4:1];	// OneHot.scala:58:35, frontend.scala:708:50, :715:52
  wire             _GEN_27 = _offset_from_aligned_pc_T_5[4:1] == 4'h0;	// frontend.scala:708:50, :715:52, util.scala:384:37
  wire [5:0]       _GEN_28 = _upper_mask_T_5[6:1] | _upper_mask_T_5[5:0];	// OneHot.scala:58:35, util.scala:384:{37,54}
  wire [4:0]       _GEN_29 = _GEN_28[5:1] | _upper_mask_T_5[4:0];	// OneHot.scala:58:35, util.scala:384:{37,54}
  wire [3:0]       _GEN_30 = _GEN_29[4:1] | _upper_mask_T_5[3:0];	// OneHot.scala:58:35, util.scala:384:{37,54}
  wire [2:0]       _GEN_31 = _GEN_30[3:1] | _upper_mask_T_5[2:0];	// OneHot.scala:58:35, util.scala:384:{37,54}
  wire [1:0]       _GEN_32 = _GEN_31[2:1] | _upper_mask_T_5[1:0];	// OneHot.scala:58:35, util.scala:384:{37,54}
  wire             _f3_br_mask_1_T = _bpd_decoder_io_out_cfi_type == 3'h1;	// frontend.scala:663:33, :733:26
  wire             f3_redirects_1 =
    f3_mask_1
    & (_f3_redirects_1_T | _f3_redirects_1_T_1 | _f3_br_mask_1_T
       & _f3_bpd_resp_io_deq_bits_preds_1_taken);	// frontend.scala:521:11, :690:71, :691:43, :696:49, :731:40, :732:69, :733:{26,37}
  assign f3_br_mask_1 = f3_mask_1 & _f3_br_mask_1_T;	// frontend.scala:690:71, :733:26, :736:37
  wire             _GEN_33 = f3_redirects_0 | f3_redirects_1;	// frontend.scala:731:40, :744:39
  wire [31:0]      f3_fetch_bundle_exp_insts_2 =
    _exp_inst_rvc_exp_1_io_rvc ? _exp_inst_rvc_exp_1_io_out_bits : inst_1;	// consts.scala:330:25, :332:8, frontend.scala:681:29
  assign inst_1 = _f3_io_deq_bits_data[63:32];	// frontend.scala:516:11, :681:29
  wire             _valid_T_9 =
    _f3_io_deq_valid & _f3_io_deq_bits_mask[1] & valid_1 & ~f3_redirects_0
    & (&(_f3_io_deq_bits_data[17:16]));	// frontend.scala:516:11, :592:{32,38}, :675:38, :682:37, :689:{58,74}, :731:40
  wire             bank_mask_2 =
    _f3_io_deq_valid & _f3_io_deq_bits_mask[2] & ~_valid_T_9 & ~_GEN_33;	// frontend.scala:516:11, :682:{20,37}, :689:{58,71,74}, :744:39
  assign f3_mask_2 = _f3_io_deq_valid & _f3_io_deq_bits_mask[2] & ~_valid_T_9 & ~_GEN_33;	// frontend.scala:516:11, :682:{20,37}, :689:{58,74}, :690:71, :744:39
  wire             _f3_redirects_2_T_1 = _bpd_decoder_1_io_out_cfi_type == 3'h3;	// frontend.scala:663:33, :691:43
  wire             _f3_redirects_2_T = _bpd_decoder_1_io_out_cfi_type == 3'h2;	// frontend.scala:663:33, :696:49
  wire             f3_btb_mispredicts_2 =
    _f3_redirects_2_T & ~_valid_T_9 & _f3_bpd_resp_io_deq_bits_preds_2_predicted_pc_valid
    & _f3_bpd_resp_io_deq_bits_preds_2_predicted_pc_bits != _bpd_decoder_1_io_out_target;	// frontend.scala:521:11, :663:33, :682:{20,37}, :696:49, :697:61, :698:61
  wire [6:0]       _offset_from_aligned_pc_T_10 =
    {1'h0, _bpd_decoder_1_io_out_sfb_offset_bits} + 7'h4;	// frontend.scala:300:26, :333:19, :339:19, :521:11, :569:29, :606:23, :663:33, :708:50, :842:34, :859:11, :861:19, :862:19, :925:34
  wire [15:0]      _upper_mask_T_9 = 16'h1 << _offset_from_aligned_pc_T_10[4:1];	// OneHot.scala:58:35, frontend.scala:708:50, :715:52
  wire             _GEN_34 = _offset_from_aligned_pc_T_10[4:1] == 4'h0;	// frontend.scala:708:50, :715:52, util.scala:384:37
  wire [5:0]       _GEN_35 = _upper_mask_T_9[6:1] | _upper_mask_T_9[5:0];	// OneHot.scala:58:35, util.scala:384:{37,54}
  wire [4:0]       _GEN_36 = _GEN_35[5:1] | _upper_mask_T_9[4:0];	// OneHot.scala:58:35, util.scala:384:{37,54}
  wire [3:0]       _GEN_37 = _GEN_36[4:1] | _upper_mask_T_9[3:0];	// OneHot.scala:58:35, util.scala:384:{37,54}
  wire [2:0]       _GEN_38 = _GEN_37[3:1] | _upper_mask_T_9[2:0];	// OneHot.scala:58:35, util.scala:384:{37,54}
  wire [1:0]       _GEN_39 = _GEN_38[2:1] | _upper_mask_T_9[1:0];	// OneHot.scala:58:35, util.scala:384:{37,54}
  wire             _f3_br_mask_2_T = _bpd_decoder_1_io_out_cfi_type == 3'h1;	// frontend.scala:663:33, :733:26
  wire             f3_redirects_2 =
    f3_mask_2
    & (_f3_redirects_2_T | _f3_redirects_2_T_1 | _f3_br_mask_2_T
       & _f3_bpd_resp_io_deq_bits_preds_2_taken);	// frontend.scala:521:11, :690:71, :691:43, :696:49, :731:40, :732:69, :733:{26,37}
  assign f3_br_mask_2 = f3_mask_2 & _f3_br_mask_2_T;	// frontend.scala:690:71, :733:26, :736:37
  wire [31:0]      f3_fetch_bundle_exp_insts_3 =
    _exp_inst_rvc_exp_2_io_rvc ? _exp_inst_rvc_exp_2_io_out_bits : inst_2;	// Cat.scala:30:58, consts.scala:330:25, :332:8
  assign inst_2 = {16'h0, _f3_io_deq_bits_data[63:48]};	// Cat.scala:30:58, frontend.scala:516:11, :677:44
  wire             _valid_T_18 =
    bank_mask_2 & (&(_f3_io_deq_bits_data[33:32])) | (&(_f3_io_deq_bits_data[49:48]));	// frontend.scala:516:11, :592:{32,38}, :678:{38,66}, :689:71
  assign f3_mask_3 =
    _f3_io_deq_valid & _f3_io_deq_bits_mask[3] & ~_valid_T_18
    & ~(_GEN_33 | f3_redirects_2);	// frontend.scala:516:11, :678:{20,66}, :689:{58,74}, :690:71, :731:40, :744:39
  wire             _f3_redirects_3_T_1 = _bpd_decoder_2_io_out_cfi_type == 3'h3;	// frontend.scala:663:33, :691:43
  wire             _f3_redirects_3_T = _bpd_decoder_2_io_out_cfi_type == 3'h2;	// frontend.scala:663:33, :696:49
  wire             f3_btb_mispredicts_3 =
    _f3_redirects_3_T & ~_valid_T_18 & _f3_bpd_resp_io_deq_bits_preds_3_predicted_pc_valid
    & _f3_bpd_resp_io_deq_bits_preds_3_predicted_pc_bits != _bpd_decoder_2_io_out_target;	// frontend.scala:521:11, :663:33, :678:{20,66}, :696:49, :697:61, :698:61
  wire [6:0]       _offset_from_aligned_pc_T_15 =
    {1'h0, _bpd_decoder_2_io_out_sfb_offset_bits} + 7'h6;	// frontend.scala:300:26, :333:19, :339:19, :521:11, :569:29, :606:23, :663:33, :708:50, :842:34, :859:11, :861:19, :862:19, :925:34
  wire [15:0]      _upper_mask_T_13 = 16'h1 << _offset_from_aligned_pc_T_15[4:1];	// OneHot.scala:58:35, frontend.scala:708:50, :715:52
  wire             _GEN_40 = _offset_from_aligned_pc_T_15[4:1] == 4'h0;	// frontend.scala:708:50, :715:52, util.scala:384:37
  wire [5:0]       _GEN_41 = _upper_mask_T_13[6:1] | _upper_mask_T_13[5:0];	// OneHot.scala:58:35, util.scala:384:{37,54}
  wire [4:0]       _GEN_42 = _GEN_41[5:1] | _upper_mask_T_13[4:0];	// OneHot.scala:58:35, util.scala:384:{37,54}
  wire [3:0]       _GEN_43 = _GEN_42[4:1] | _upper_mask_T_13[3:0];	// OneHot.scala:58:35, util.scala:384:{37,54}
  wire [2:0]       _GEN_44 = _GEN_43[3:1] | _upper_mask_T_13[2:0];	// OneHot.scala:58:35, util.scala:384:{37,54}
  wire [1:0]       _GEN_45 = _GEN_44[2:1] | _upper_mask_T_13[1:0];	// OneHot.scala:58:35, util.scala:384:{37,54}
  wire             _f3_br_mask_3_T = _bpd_decoder_2_io_out_cfi_type == 3'h1;	// frontend.scala:663:33, :733:26
  wire             f3_redirects_3 =
    f3_mask_3
    & (_f3_redirects_3_T | _f3_redirects_3_T_1 | _f3_br_mask_3_T
       & _f3_bpd_resp_io_deq_bits_preds_3_taken);	// frontend.scala:521:11, :690:71, :691:43, :696:49, :731:40, :732:69, :733:{26,37}
  assign f3_br_mask_3 = f3_mask_3 & _f3_br_mask_3_T;	// frontend.scala:690:71, :733:26, :736:37
  wire             f3_fetch_bundle_end_half_valid =
    ~(bank_mask_2 & (&(_f3_io_deq_bits_data[33:32]))) & (&(_f3_io_deq_bits_data[49:48]));	// frontend.scala:516:11, :592:{32,38}, :689:71, :746:40, :748:{8,33,69}
  wire [3:0][2:0]  _GEN_46 =
    {{_bpd_decoder_2_io_out_cfi_type},
     {_bpd_decoder_1_io_out_cfi_type},
     {_bpd_decoder_io_out_cfi_type},
     {brsigs_cfi_type}};	// frontend.scala:629:34, :634:40, :655:40, :663:33, :755:33
  wire [3:0]       _GEN_47 =
    {{_bpd_decoder_2_io_out_is_call},
     {_bpd_decoder_1_io_out_is_call},
     {_bpd_decoder_io_out_is_call},
     {f3_prev_is_half ? _bpd_decoder0_io_out_is_call : _bpd_decoder1_io_out_is_call}};	// frontend.scala:589:32, :622:34, :625:34, :629:34, :634:40, :655:40, :663:33, :756:33
  wire             f3_fetch_bundle_cfi_is_call = _GEN_47[f3_fetch_bundle_cfi_idx_bits];	// Mux.scala:47:69, frontend.scala:756:33
  wire [3:0]       _GEN_48 =
    {{_bpd_decoder_2_io_out_is_ret},
     {_bpd_decoder_1_io_out_is_ret},
     {_bpd_decoder_io_out_is_ret},
     {f3_prev_is_half ? _bpd_decoder0_io_out_is_ret : _bpd_decoder1_io_out_is_ret}};	// frontend.scala:589:32, :622:34, :625:34, :629:34, :634:40, :655:40, :663:33, :757:33
  wire             f3_fetch_bundle_cfi_is_ret = _GEN_48[f3_fetch_bundle_cfi_idx_bits];	// Mux.scala:47:69, frontend.scala:757:33
  wire [3:0]       _GEN_49 =
    {{&(_f3_io_deq_bits_data[49:48])},
     {&(_f3_io_deq_bits_data[33:32])},
     {&(_f3_io_deq_bits_data[17:16])},
     {(&(bank_insts_0[1:0])) & ~f3_prev_is_half}};	// frontend.scala:516:11, :589:32, :592:{32,38}, :629:34, :630:40, :651:40, :703:{23,26}, :758:33
  wire             f3_fetch_bundle_cfi_npc_plus4 = _GEN_49[f3_fetch_bundle_cfi_idx_bits];	// Mux.scala:47:69, frontend.scala:758:33
  wire             _f4_btb_corrections_io_enq_valid_T =
    _f4_io_enq_ready & _f3_io_deq_valid;	// Decoupled.scala:40:37, frontend.scala:516:11, :859:11
  `ifndef SYNTHESIS	// frontend.scala:770:11
    always @(posedge clock) begin	// frontend.scala:770:11
      if (_f4_btb_corrections_io_enq_valid_T
          & ~(_f3_bpd_resp_io_deq_bits_pc == _f3_io_deq_bits_pc | reset)) begin	// Decoupled.scala:40:37, frontend.scala:516:11, :521:11, :770:{11,39}
        if (`ASSERT_VERBOSE_COND_)	// frontend.scala:770:11
          $error("Assertion failed\n    at frontend.scala:770 assert(f3_bpd_resp.io.deq.bits.pc === f3_fetch_bundle.pc)\n");	// frontend.scala:770:11
        if (`STOP_COND_)	// frontend.scala:770:11
          $fatal;	// frontend.scala:770:11
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  wire             _f3_predicted_target_T = f3_redirects_0 | f3_redirects_1;	// frontend.scala:731:40, :777:57
  wire             f3_fetch_bundle_cfi_idx_valid =
    _f3_predicted_target_T | f3_redirects_2 | f3_redirects_3;	// frontend.scala:731:40, :777:57
  wire [1:0]       _f3_predicted_target_T_5 = {1'h1, ~f3_redirects_2};	// Mux.scala:47:69, frontend.scala:300:26, :339:19, :731:40, :925:34, :928:9
  assign f3_fetch_bundle_cfi_idx_bits =
    f3_redirects_0 ? 2'h0 : f3_redirects_1 ? 2'h1 : _f3_predicted_target_T_5;	// Mux.scala:47:69, frontend.scala:503:20, :731:40
  wire             _f3_predicted_target_T_2 =
    _f3_predicted_target_T | f3_redirects_2 | f3_redirects_3;	// frontend.scala:731:40, :777:57, :784:54
  wire [3:0][39:0] _GEN_50 =
    {{_f3_redirects_3_T_1
        ? _f3_bpd_resp_io_deq_bits_preds_3_predicted_pc_bits
        : _bpd_decoder_2_io_out_target},
     {_f3_redirects_2_T_1
        ? _f3_bpd_resp_io_deq_bits_preds_2_predicted_pc_bits
        : _bpd_decoder_1_io_out_target},
     {_f3_redirects_1_T_1
        ? _f3_bpd_resp_io_deq_bits_preds_1_predicted_pc_bits
        : _bpd_decoder_io_out_target},
     {_f3_redirects_0_T_1
        ? _f3_bpd_resp_io_deq_bits_preds_0_predicted_pc_bits
        : brsigs_target}};	// frontend.scala:521:11, :629:34, :634:40, :655:40, :663:33, :691:{26,43}, :785:8
  wire [39:0]      _GEN_51 =
    _GEN_50[f3_redirects_0 ? 2'h0 : f3_redirects_1 ? 2'h1 : _f3_predicted_target_T_5];	// Mux.scala:47:69, frontend.scala:503:20, :731:40, :785:8
  wire [39:0]      _f3_predicted_target_T_12 = _GEN_20 + 40'h8;	// frontend.scala:168:23, :619:69
  wire [39:0]      f3_fetch_bundle_next_pc =
    _f3_predicted_target_T_2
      ? (f3_fetch_bundle_cfi_is_ret ? _ras_io_read_addr : _GEN_51)
      : _f3_predicted_target_T_12;	// frontend.scala:168:23, :335:19, :757:33, :784:{32,54}, :785:8
  wire [3:0]       _GEN_52 = {2'h0, f3_fetch_bundle_cfi_idx_bits};	// Mux.scala:47:69, frontend.scala:796:28
  wire [3:0]       _f3_predicted_ghist_T = f3_fetch_bundle_br_mask >> _GEN_52;	// frontend.scala:577:41, :796:28
  wire [3:0]       f3_predicted_ghist_cfi_idx_oh = 4'h1 << _GEN_52;	// OneHot.scala:58:35, frontend.scala:796:28
  wire [2:0]       _GEN_53 =
    f3_predicted_ghist_cfi_idx_oh[2:0] | f3_predicted_ghist_cfi_idx_oh[3:1];	// OneHot.scala:58:35, frontend.scala:364:16, util.scala:373:{29,45}
  wire [1:0]       _GEN_54 = _GEN_53[1:0] | f3_predicted_ghist_cfi_idx_oh[3:2];	// Mux.scala:47:69, OneHot.scala:58:35, frontend.scala:364:16, util.scala:373:{29,45}
  wire             _f3_predicted_ghist_new_history_old_history_T =
    _f3_predicted_ghist_T[0] & f3_fetch_bundle_cfi_idx_valid;	// frontend.scala:91:84, :777:57, :796:28
  wire [63:0]      _f3_predicted_ghist_new_history_old_history_T_6 =
    _f3_predicted_ghist_new_history_old_history_T & f3_fetch_bundle_cfi_idx_valid
      ? {_f3_io_deq_bits_ghist_old_history[62:0], 1'h1}
      : (|(f3_fetch_bundle_br_mask
           & (f3_fetch_bundle_cfi_idx_valid
                ? {&f3_fetch_bundle_cfi_idx_bits,
                   _GEN_53[2],
                   _GEN_54[1],
                   _GEN_54[0] | (&f3_fetch_bundle_cfi_idx_bits)}
                  & ~(_f3_predicted_ghist_new_history_old_history_T
                        ? f3_predicted_ghist_cfi_idx_oh
                        : 4'h0)
                : 4'hF))) | _f3_io_deq_bits_ghist_current_saw_branch_not_taken
          ? {_f3_io_deq_bits_ghist_old_history[62:0], 1'h0}
          : _f3_io_deq_bits_ghist_old_history;	// Mux.scala:47:69, OneHot.scala:58:35, frontend.scala:90:{39,44}, :91:{67,69,73,84}, :98:{53,61}, :99:{37,61,91,96}, :100:37, :300:26, :333:19, :339:19, :364:16, :367:16, :516:11, :521:11, :569:29, :577:41, :606:23, :777:57, :842:34, :859:11, :861:19, :862:19, :925:34, :928:9, util.scala:373:{29,45}
  wire             _f3_predicted_ghist_new_history_ras_idx_T =
    f3_fetch_bundle_cfi_idx_valid & f3_fetch_bundle_cfi_is_call;	// frontend.scala:124:42, :756:33, :777:57
  wire [4:0]       _ras_io_write_idx_T = _f3_io_deq_bits_ghist_ras_idx + 5'h1;	// frontend.scala:516:11, util.scala:203:14
  wire             _f3_predicted_ghist_new_history_ras_idx_T_4 =
    f3_fetch_bundle_cfi_idx_valid & f3_fetch_bundle_cfi_is_ret;	// frontend.scala:125:42, :757:33, :777:57
  wire [4:0]       _f3_predicted_ghist_new_history_ras_idx_T_5 =
    _f3_io_deq_bits_ghist_ras_idx - 5'h1;	// frontend.scala:516:11, util.scala:220:14
  wire             _f3_correct_f1_ghist_T_4 =
    s1_ghist_old_history == _f3_predicted_ghist_new_history_old_history_T_6
    & ~s1_ghist_new_saw_branch_not_taken & ~s1_ghist_new_saw_branch_taken;	// frontend.scala:76:19, :77:{32,68}, :78:28, :99:37, :383:29
  wire             _f3_correct_f2_ghist_T_4 =
    s2_ghist_old_history == _f3_predicted_ghist_new_history_old_history_T_6
    & ~s2_ghist_new_saw_branch_not_taken & ~s2_ghist_new_saw_branch_taken;	// frontend.scala:76:19, :77:{32,68}, :78:28, :99:37, :442:21
  wire             _GEN_55 = _f3_io_deq_valid & _f4_io_enq_ready;	// frontend.scala:516:11, :814:25, :859:11
  wire             _GEN_56 =
    s2_valid & s2_vpc == f3_fetch_bundle_next_pc & _f3_correct_f2_ghist_T_4;	// frontend.scala:77:68, :440:25, :441:25, :784:32, :821:{30,54}
  wire             _GEN_57 = _GEN_55 & _GEN_56;	// frontend.scala:533:24, :814:{25,38}, :821:{54,79}, :822:28
  assign _GEN =
    _GEN_57
      ? (_f3_predicted_ghist_new_history_ras_idx_T
           ? _ras_io_write_idx_T
           : _f3_predicted_ghist_new_history_ras_idx_T_4
               ? _f3_predicted_ghist_new_history_ras_idx_T_5
               : _f3_io_deq_bits_ghist_ras_idx)
      : s2_ghist_ras_idx;	// frontend.scala:124:{31,42}, :125:{31,42}, :442:21, :516:11, :533:24, :814:38, :821:79, :822:28, util.scala:203:14, :220:14
  wire             _GEN_58 = ~s2_valid & s1_valid;	// frontend.scala:382:29, :440:25, :823:{18,28}
  wire             _GEN_59 =
    _GEN_58 & s1_vpc == f3_fetch_bundle_next_pc & _f3_correct_f1_ghist_T_4;	// frontend.scala:77:68, :381:29, :784:32, :823:{28,50,74}
  wire             _GEN_60 =
    s2_valid & (s2_vpc != f3_fetch_bundle_next_pc | ~_f3_correct_f2_ghist_T_4) | _GEN_58
    & (s1_vpc != f3_fetch_bundle_next_pc | ~_f3_correct_f1_ghist_T_4) | ~s2_valid
    & ~s1_valid;	// frontend.scala:77:68, :81:41, :381:29, :382:29, :440:25, :441:25, :496:84, :784:32, :823:{18,28}, :825:{29,41,65}, :826:{35,46,70,95}, :827:22
  wire             _GEN_61 = _GEN_56 | _GEN_59;	// frontend.scala:821:{54,79}, :823:{74,99}, :827:37
  wire             _GEN_62 = ~_GEN_55 | _GEN_61 | ~_GEN_60;	// frontend.scala:482:58, :814:{25,38}, :821:79, :823:99, :826:95, :827:37
  wire             f4_delay =
    (_f4_io_deq_bits_sfbs_0 | _f4_io_deq_bits_sfbs_1 | _f4_io_deq_bits_sfbs_2
     | _f4_io_deq_bits_sfbs_3) & ~_f4_io_deq_bits_cfi_idx_valid & ~_f4_io_enq_valid_T_1
    & ~_f4_io_deq_bits_xcpt_pf_if & ~_f4_io_deq_bits_xcpt_ae_if;	// frontend.scala:859:11, :895:33, :896:5, :897:5, :898:{5,32}, :899:5, :908:38
  assign _f4_io_enq_valid_T_1 = _f3_io_deq_valid & ~f4_clear;	// frontend.scala:516:11, :908:{38,41}, :953:30, :954:17, :965:38
  wire [39:0]      _GEN_63 = {1'h0, io_cpu_sfence_bits_addr};	// frontend.scala:300:26, :333:19, :339:19, :521:11, :569:29, :606:23, :842:34, :859:11, :861:19, :862:19, :925:34, :961:18
  assign f4_clear = io_cpu_sfence_valid | io_cpu_redirect_flush;	// frontend.scala:953:30, :954:17, :965:38
  wire             _GEN_64 = io_cpu_sfence_valid | io_cpu_redirect_flush;	// frontend.scala:814:38, :953:30, :957:17, :965:38, :969:17
  assign f2_clear = _GEN_64 | _GEN_55 & ~_GEN_61 & _GEN_60;	// frontend.scala:814:{25,38}, :821:79, :823:99, :826:95, :827:37, :953:30, :957:17, :965:38, :969:17
  assign f1_clear =
    _GEN_64 | (~_GEN_55 | _GEN_61 ? _GEN_13 | _GEN_16 : _GEN_60 | _GEN_13 | _GEN_16);	// frontend.scala:481:45, :482:58, :490:14, :491:38, :496:95, :814:{25,38}, :821:79, :823:99, :826:95, :827:37, :829:16, :953:30, :957:17, :958:17, :965:38, :969:17, :970:17
  wire             _GEN_65 = io_cpu_sfence_valid | ~io_cpu_redirect_flush;	// frontend.scala:814:38, :953:30, :965:38, :972:21
  wire             s0_valid =
    ~io_cpu_sfence_valid
    & (io_cpu_redirect_flush
         ? io_cpu_redirect_val
         : _GEN_62
             ? (_GEN_13
                  ? ~s2_tlb_resp_ae_inst & ~s2_tlb_resp_pf_inst | s2_is_replay
                    | s2_tlb_miss
                  : _GEN_17
                      ? ~(_f3_io_enq_valid_T_2 & ~s2_is_replay)
                      : _GEN_6
                          ? ~((s1_is_replay
                                 ? s1_tlb_resp_REG_ae_inst
                                 : _tlb_io_resp_ae_inst)
                              | (s1_is_replay
                                   ? s1_tlb_resp_REG_pf_inst
                                   : _tlb_io_resp_pf_inst))
                          : _GEN_0)
             : ~_s0_valid_T_11);	// frontend.scala:339:19, :363:{31,49}, :384:29, :397:{24,46}, :427:{18,35}, :429:{18,21,43}, :448:28, :449:28, :450:44, :451:{50,77}, :481:45, :482:58, :483:{14,18,39,42,80}, :491:38, :496:95, :499:{20,23,70}, :723:75, :814:38, :821:79, :831:23, :953:30, :960:18, :965:38, :974:18
  assign s0_vpc =
    io_cpu_sfence_valid
      ? _GEN_63
      : io_cpu_redirect_flush
          ? io_cpu_redirect_pc
          : _GEN_62
              ? (_GEN_13
                   ? s2_vpc
                   : _GEN_17
                       ? f2_predicted_target
                       : _GEN_6
                           ? (f1_do_redirect
                                ? _GEN_1[f1_redirect_idx]
                                : _f1_predicted_target_T_9)
                           : _GEN_0 ? 40'h10040 : 40'h0)
              : f3_fetch_bundle_next_pc;	// Mux.scala:47:69, frontend.scala:168:23, :363:{31,49}, :365:16, :411:45, :413:32, :427:{18,35}, :431:18, :441:25, :466:32, :481:45, :482:58, :484:14, :491:38, :496:95, :499:20, :500:20, :784:32, :814:38, :821:79, :953:30, :961:18, :965:38, :975:18, package.scala:32:{76,86}
  always @(posedge clock) begin
    automatic logic _GEN_66;	// frontend.scala:443:12, :482:58, :491:38
    automatic logic _GEN_67 = ~_GEN_55 | _GEN_56 | ~_GEN_59;	// frontend.scala:482:58, :814:{25,38}, :821:{54,79}, :823:{74,99}
    _GEN_66 =
      _GEN_13
      | ~(_GEN_14 & s1_valid & s1_vpc == f2_predicted_target & _f2_correct_f1_ghist_T_4);	// frontend.scala:77:68, :381:29, :382:29, :443:12, :466:32, :481:45, :482:58, :491:{25,38}, :492:{30,79}, :494:16
    REG <= reset;	// frontend.scala:363:16
    if (io_cpu_sfence_valid)
      s1_vpc <= _GEN_63;	// frontend.scala:381:29, :961:18
    else if (io_cpu_redirect_flush)
      s1_vpc <= io_cpu_redirect_pc;	// frontend.scala:381:29
    else if (_GEN_62) begin	// frontend.scala:482:58, :814:38, :821:79
      if (_GEN_13)	// frontend.scala:481:45
        s1_vpc <= s2_vpc;	// frontend.scala:381:29, :441:25
      else if (_GEN_17) begin	// frontend.scala:427:35, :491:38, :496:95, :499:20
        if (f2_do_redirect)	// frontend.scala:465:45
          s1_vpc <= _GEN_8[f2_redirect_idx];	// Mux.scala:47:69, frontend.scala:381:29, package.scala:32:{76,86}
        else	// frontend.scala:465:45
          s1_vpc <= _f2_predicted_target_T_9;	// frontend.scala:168:23, :381:29
      end
      else if (_GEN_6) begin	// frontend.scala:427:18
        if (f1_do_redirect)	// frontend.scala:411:45
          s1_vpc <= _GEN_1[f1_redirect_idx];	// Mux.scala:47:69, frontend.scala:381:29, package.scala:32:{76,86}
        else	// frontend.scala:411:45
          s1_vpc <= _f1_predicted_target_T_9;	// frontend.scala:168:23, :381:29
      end
      else if (_GEN_0)	// frontend.scala:363:31
        s1_vpc <= 40'h10040;	// frontend.scala:365:16, :381:29
      else	// frontend.scala:363:31
        s1_vpc <= 40'h0;	// frontend.scala:381:29
    end
    else if (_f3_predicted_target_T_2) begin	// frontend.scala:784:54
      if (f3_fetch_bundle_cfi_is_ret)	// frontend.scala:757:33
        s1_vpc <= _ras_io_read_addr;	// frontend.scala:335:19, :381:29
      else	// frontend.scala:757:33
        s1_vpc <= _GEN_51;	// frontend.scala:381:29, :785:8
    end
    else	// frontend.scala:784:54
      s1_vpc <= _f3_predicted_target_T_12;	// frontend.scala:168:23, :381:29
    if (_GEN_65) begin	// frontend.scala:814:38, :953:30, :965:38
      if (_GEN_62) begin	// frontend.scala:482:58, :814:38, :821:79
        if (_GEN_13)	// frontend.scala:481:45
          s1_ghist_old_history <= s2_ghist_old_history;	// frontend.scala:383:29, :442:21
        else if (_GEN_17)	// frontend.scala:427:35, :491:38, :496:95, :499:20
          s1_ghist_old_history <= _f2_predicted_ghist_new_history_old_history_T_6;	// frontend.scala:99:37, :383:29
        else if (_GEN_6)	// frontend.scala:427:18
          s1_ghist_old_history <= _f1_predicted_ghist_new_history_old_history_T_6;	// frontend.scala:99:37, :383:29
        else	// frontend.scala:427:18
          s1_ghist_old_history <= 64'h0;	// frontend.scala:350:45, :383:29
      end
      else	// frontend.scala:482:58, :814:38, :821:79
        s1_ghist_old_history <= _f3_predicted_ghist_new_history_old_history_T_6;	// frontend.scala:99:37, :383:29
      s1_ghist_current_saw_branch_not_taken <=
        _GEN_62 & _GEN_13 & s2_ghist_current_saw_branch_not_taken;	// frontend.scala:383:29, :442:21, :481:45, :482:58, :814:38, :821:79
      s1_ghist_new_saw_branch_not_taken <=
        _GEN_62 & _GEN_13 & s2_ghist_new_saw_branch_not_taken;	// frontend.scala:383:29, :442:21, :481:45, :482:58, :814:38, :821:79
      s1_ghist_new_saw_branch_taken <= _GEN_62 & _GEN_13 & s2_ghist_new_saw_branch_taken;	// frontend.scala:383:29, :442:21, :481:45, :482:58, :814:38, :821:79
      if (_GEN_62) begin	// frontend.scala:482:58, :814:38, :821:79
        if (_GEN_13 | _GEN_17)	// frontend.scala:427:35, :481:45, :482:58, :488:14, :491:38, :496:95, :499:20
          s1_ghist_ras_idx <= s2_ghist_ras_idx;	// frontend.scala:383:29, :442:21
        else if (~_GEN_6)	// frontend.scala:427:18
          s1_ghist_ras_idx <= 5'h0;	// frontend.scala:350:45, :383:29
      end
      else if (_f3_predicted_ghist_new_history_ras_idx_T)	// frontend.scala:124:42
        s1_ghist_ras_idx <= _ras_io_write_idx_T;	// frontend.scala:383:29, util.scala:203:14
      else if (_f3_predicted_ghist_new_history_ras_idx_T_4)	// frontend.scala:125:42
        s1_ghist_ras_idx <= _f3_predicted_ghist_new_history_ras_idx_T_5;	// frontend.scala:383:29, util.scala:220:14
      else	// frontend.scala:125:42
        s1_ghist_ras_idx <= _f3_io_deq_bits_ghist_ras_idx;	// frontend.scala:383:29, :516:11
    end
    else begin	// frontend.scala:814:38, :953:30, :965:38
      s1_ghist_old_history <= io_cpu_redirect_ghist_old_history;	// frontend.scala:383:29
      s1_ghist_current_saw_branch_not_taken <=
        io_cpu_redirect_ghist_current_saw_branch_not_taken;	// frontend.scala:383:29
      s1_ghist_new_saw_branch_not_taken <= io_cpu_redirect_ghist_new_saw_branch_not_taken;	// frontend.scala:383:29
      s1_ghist_new_saw_branch_taken <= io_cpu_redirect_ghist_new_saw_branch_taken;	// frontend.scala:383:29
      s1_ghist_ras_idx <= io_cpu_redirect_ghist_ras_idx;	// frontend.scala:383:29
    end
    s1_is_replay <= ~_GEN_64 & _GEN_62 & _GEN_13 & _s0_is_replay_T;	// frontend.scala:384:29, :481:45, :482:{19,58}, :814:38, :821:79, :953:30, :957:17, :962:18, :965:38, :969:17, :978:18
    s1_is_sfence <= io_cpu_sfence_valid;	// frontend.scala:385:29
    if (_GEN_65) begin	// frontend.scala:814:38, :953:30, :965:38
      if (_GEN_62) begin	// frontend.scala:482:58, :814:38, :821:79
        if (_GEN_13)	// frontend.scala:481:45
          s1_tsrc <= s2_tsrc;	// frontend.scala:387:29, :445:24
        else if (_GEN_17)	// frontend.scala:427:35, :491:38, :496:95, :499:20
          s1_tsrc <= 2'h1;	// frontend.scala:387:29, :503:20
        else if (_GEN_6)	// frontend.scala:427:18
          s1_tsrc <= 2'h0;	// frontend.scala:387:29
        else	// frontend.scala:427:18
          s1_tsrc <= {2{_GEN_0}};	// frontend.scala:363:{31,49}, :367:16, :387:29
      end
      else	// frontend.scala:482:58, :814:38, :821:79
        s1_tsrc <= 2'h2;	// Mux.scala:47:69, frontend.scala:387:29
    end
    else	// frontend.scala:814:38, :953:30, :965:38
      s1_tsrc <= 2'h3;	// frontend.scala:367:16, :387:29
    tlb_io_sfence_REG_valid <= io_cpu_sfence_valid;	// frontend.scala:393:35
    tlb_io_sfence_REG_bits_rs1 <= io_cpu_sfence_bits_rs1;	// frontend.scala:393:35
    tlb_io_sfence_REG_bits_rs2 <= io_cpu_sfence_bits_rs2;	// frontend.scala:393:35
    tlb_io_sfence_REG_bits_addr <= io_cpu_sfence_bits_addr;	// frontend.scala:393:35
    s1_tlb_resp_REG_pf_inst <= s2_tlb_resp_pf_inst;	// frontend.scala:397:46, :448:28
    s1_tlb_resp_REG_ae_inst <= s2_tlb_resp_ae_inst;	// frontend.scala:397:46, :448:28
    s1_ppc_REG <= s2_ppc;	// frontend.scala:398:42, :444:24
    s2_vpc <= s1_vpc;	// frontend.scala:381:29, :441:25
    if (_GEN_67) begin	// frontend.scala:482:58, :814:38, :821:79
      if (_GEN_66)	// frontend.scala:443:12, :482:58, :491:38
        s2_ghist_old_history <= s1_ghist_old_history;	// frontend.scala:383:29, :442:21
      else	// frontend.scala:443:12, :482:58, :491:38
        s2_ghist_old_history <= _f2_predicted_ghist_new_history_old_history_T_6;	// frontend.scala:99:37, :442:21
    end
    else	// frontend.scala:482:58, :814:38, :821:79
      s2_ghist_old_history <= _f3_predicted_ghist_new_history_old_history_T_6;	// frontend.scala:99:37, :442:21
    s2_ghist_current_saw_branch_not_taken <=
      _GEN_67 & _GEN_66 & s1_ghist_current_saw_branch_not_taken;	// frontend.scala:383:29, :442:21, :443:12, :482:58, :491:38, :814:38, :821:79
    s2_ghist_new_saw_branch_not_taken <=
      _GEN_67 & _GEN_66 & s1_ghist_new_saw_branch_not_taken;	// frontend.scala:383:29, :442:21, :443:12, :482:58, :491:38, :814:38, :821:79
    s2_ghist_new_saw_branch_taken <= _GEN_67 & _GEN_66 & s1_ghist_new_saw_branch_taken;	// frontend.scala:383:29, :442:21, :443:12, :482:58, :491:38, :814:38, :821:79
    if (_GEN_67) begin	// frontend.scala:482:58, :814:38, :821:79
      if (_GEN_66)	// frontend.scala:443:12, :482:58, :491:38
        s2_ghist_ras_idx <= s1_ghist_ras_idx;	// frontend.scala:383:29, :442:21
    end
    else if (_f3_predicted_ghist_new_history_ras_idx_T)	// frontend.scala:124:42
      s2_ghist_ras_idx <= _ras_io_write_idx_T;	// frontend.scala:442:21, util.scala:203:14
    else if (_f3_predicted_ghist_new_history_ras_idx_T_4)	// frontend.scala:125:42
      s2_ghist_ras_idx <= _f3_predicted_ghist_new_history_ras_idx_T_5;	// frontend.scala:442:21, util.scala:220:14
    else	// frontend.scala:125:42
      s2_ghist_ras_idx <= _f3_io_deq_bits_ghist_ras_idx;	// frontend.scala:442:21, :516:11
    if (s1_is_replay) begin	// frontend.scala:384:29
      s2_ppc <= s1_ppc_REG;	// frontend.scala:398:42, :444:24
      s2_tlb_resp_pf_inst <= s1_tlb_resp_REG_pf_inst;	// frontend.scala:397:46, :448:28
      s2_tlb_resp_ae_inst <= s1_tlb_resp_REG_ae_inst;	// frontend.scala:397:46, :448:28
    end
    else begin	// frontend.scala:384:29
      s2_ppc <= _tlb_io_resp_paddr;	// frontend.scala:339:19, :444:24
      s2_tlb_resp_pf_inst <= _tlb_io_resp_pf_inst;	// frontend.scala:339:19, :448:28
      s2_tlb_resp_ae_inst <= _tlb_io_resp_ae_inst;	// frontend.scala:339:19, :448:28
    end
    s2_tsrc <= s1_tsrc;	// frontend.scala:387:29, :445:24
    s2_tlb_miss <= s1_tlb_miss;	// frontend.scala:396:35, :449:28
    s2_is_replay_REG <= s1_is_replay;	// frontend.scala:384:29, :450:29
    f3_bpd_resp_io_enq_valid_REG <= _f3_io_enq_ready;	// frontend.scala:516:11, :549:57
    if (_f4_btb_corrections_io_enq_valid_T)	// Decoupled.scala:40:37
      f3_prev_half <= _f3_io_deq_bits_data[63:48];	// frontend.scala:516:11, :587:28, :677:44
    if (reset) begin
      s1_valid <= 1'h0;	// frontend.scala:300:26, :333:19, :339:19, :382:29, :521:11, :569:29, :606:23, :842:34, :859:11, :861:19, :862:19, :925:34
      s2_valid <= 1'h0;	// frontend.scala:300:26, :333:19, :339:19, :440:25, :521:11, :569:29, :606:23, :842:34, :859:11, :861:19, :862:19, :925:34
      ras_read_idx <= 5'h0;	// frontend.scala:350:45, :540:29
      f3_prev_is_half <= 1'h0;	// frontend.scala:300:26, :333:19, :339:19, :521:11, :569:29, :589:32, :606:23, :842:34, :859:11, :861:19, :862:19, :925:34
    end
    else begin
      automatic logic _GEN_68;	// frontend.scala:589:32, :767:27, :768:21
      _GEN_68 =
        _f4_btb_corrections_io_enq_valid_T
          ? f3_fetch_bundle_end_half_valid
          : f3_prev_is_half;	// Decoupled.scala:40:37, frontend.scala:589:32, :748:69, :767:27, :768:21
      s1_valid <= s0_valid;	// frontend.scala:382:29, :953:30, :960:18, :965:38
      s2_valid <= s1_valid & ~f1_clear;	// frontend.scala:382:29, :388:58, :440:{25,35}, :814:38, :953:30, :958:17, :965:38, :970:17
      if (_GEN_19) begin	// Decoupled.scala:40:37
        if (_GEN_57) begin	// frontend.scala:533:24, :814:38, :821:79, :822:28
          if (_f3_predicted_ghist_new_history_ras_idx_T)	// frontend.scala:124:42
            ras_read_idx <= _ras_io_write_idx_T;	// frontend.scala:540:29, util.scala:203:14
          else if (_f3_predicted_ghist_new_history_ras_idx_T_4)	// frontend.scala:125:42
            ras_read_idx <= _f3_predicted_ghist_new_history_ras_idx_T_5;	// frontend.scala:540:29, util.scala:220:14
          else	// frontend.scala:125:42
            ras_read_idx <= _f3_io_deq_bits_ghist_ras_idx;	// frontend.scala:516:11, :540:29
        end
        else	// frontend.scala:533:24, :814:38, :821:79, :822:28
          ras_read_idx <= s2_ghist_ras_idx;	// frontend.scala:442:21, :540:29
      end
      f3_prev_is_half <=
        _GEN_65
        & (_GEN_55
             ? ~(_f3_predicted_target_T | f3_redirects_2 | f3_redirects_3 | f4_clear)
               & _GEN_68
             : ~f4_clear & _GEN_68);	// frontend.scala:589:32, :731:40, :767:27, :768:21, :773:19, :774:21, :777:57, :814:{25,38}, :818:38, :819:23, :953:30, :954:17, :965:38
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:14];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [3:0] i = 4'h0; i < 4'hF; i += 4'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        REG = _RANDOM[4'h0][0];	// frontend.scala:363:16
        s1_vpc = {_RANDOM[4'h0][31:1], _RANDOM[4'h1][8:0]};	// frontend.scala:363:16, :381:29
        s1_valid = _RANDOM[4'h1][9];	// frontend.scala:381:29, :382:29
        s1_ghist_old_history = {_RANDOM[4'h1][31:10], _RANDOM[4'h2], _RANDOM[4'h3][9:0]};	// frontend.scala:381:29, :383:29
        s1_ghist_current_saw_branch_not_taken = _RANDOM[4'h3][10];	// frontend.scala:383:29
        s1_ghist_new_saw_branch_not_taken = _RANDOM[4'h3][11];	// frontend.scala:383:29
        s1_ghist_new_saw_branch_taken = _RANDOM[4'h3][12];	// frontend.scala:383:29
        s1_ghist_ras_idx = _RANDOM[4'h3][17:13];	// frontend.scala:383:29
        s1_is_replay = _RANDOM[4'h3][18];	// frontend.scala:383:29, :384:29
        s1_is_sfence = _RANDOM[4'h3][19];	// frontend.scala:383:29, :385:29
        s1_tsrc = _RANDOM[4'h3][21:20];	// frontend.scala:383:29, :387:29
        tlb_io_sfence_REG_valid = _RANDOM[4'h3][22];	// frontend.scala:383:29, :393:35
        tlb_io_sfence_REG_bits_rs1 = _RANDOM[4'h3][23];	// frontend.scala:383:29, :393:35
        tlb_io_sfence_REG_bits_rs2 = _RANDOM[4'h3][24];	// frontend.scala:383:29, :393:35
        tlb_io_sfence_REG_bits_addr = {_RANDOM[4'h3][31:25], _RANDOM[4'h4]};	// frontend.scala:383:29, :393:35
        s1_tlb_resp_REG_pf_inst = _RANDOM[4'h6][4];	// frontend.scala:397:46
        s1_tlb_resp_REG_ae_inst = _RANDOM[4'h6][7];	// frontend.scala:397:46
        s1_ppc_REG = {_RANDOM[4'h6][31:14], _RANDOM[4'h7][13:0]};	// frontend.scala:397:46, :398:42
        s2_valid = _RANDOM[4'h7][14];	// frontend.scala:398:42, :440:25
        s2_vpc = {_RANDOM[4'h7][31:15], _RANDOM[4'h8][22:0]};	// frontend.scala:398:42, :441:25
        s2_ghist_old_history = {_RANDOM[4'h8][31:23], _RANDOM[4'h9], _RANDOM[4'hA][22:0]};	// frontend.scala:441:25, :442:21
        s2_ghist_current_saw_branch_not_taken = _RANDOM[4'hA][23];	// frontend.scala:442:21
        s2_ghist_new_saw_branch_not_taken = _RANDOM[4'hA][24];	// frontend.scala:442:21
        s2_ghist_new_saw_branch_taken = _RANDOM[4'hA][25];	// frontend.scala:442:21
        s2_ghist_ras_idx = _RANDOM[4'hA][30:26];	// frontend.scala:442:21
        s2_ppc = {_RANDOM[4'hA][31], _RANDOM[4'hB][30:0]};	// frontend.scala:442:21, :444:24
        s2_tsrc = {_RANDOM[4'hB][31], _RANDOM[4'hC][0]};	// frontend.scala:444:24, :445:24
        s2_tlb_resp_pf_inst = _RANDOM[4'hD][4];	// frontend.scala:448:28
        s2_tlb_resp_ae_inst = _RANDOM[4'hD][7];	// frontend.scala:448:28
        s2_tlb_miss = _RANDOM[4'hD][14];	// frontend.scala:448:28, :449:28
        s2_is_replay_REG = _RANDOM[4'hD][15];	// frontend.scala:448:28, :450:29
        ras_read_idx = _RANDOM[4'hD][20:16];	// frontend.scala:448:28, :540:29
        f3_bpd_resp_io_enq_valid_REG = _RANDOM[4'hD][21];	// frontend.scala:448:28, :549:57
        f3_prev_half = {_RANDOM[4'hD][31:22], _RANDOM[4'hE][5:0]};	// frontend.scala:448:28, :587:28
        f3_prev_is_half = _RANDOM[4'hE][6];	// frontend.scala:587:28, :589:32
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  ICache_5 icache (	// frontend.scala:300:26
    .clock                          (clock),
    .reset                          (reset),
    .auto_master_out_a_ready        (auto_icache_master_out_a_ready),
    .auto_master_out_d_valid        (auto_icache_master_out_d_valid),
    .auto_master_out_d_bits_opcode  (auto_icache_master_out_d_bits_opcode),
    .auto_master_out_d_bits_size    (auto_icache_master_out_d_bits_size),
    .auto_master_out_d_bits_data    (auto_icache_master_out_d_bits_data),
    .io_req_valid                   (s0_valid),	// frontend.scala:953:30, :960:18, :965:38
    .io_req_bits_addr               (s0_vpc[38:0]),	// frontend.scala:371:27, :953:30, :961:18, :965:38
    .io_s1_paddr                    (s1_is_replay ? s1_ppc_REG : _tlb_io_resp_paddr),	// frontend.scala:339:19, :384:29, :398:{20,42}
    .io_s1_kill                     (_tlb_io_resp_miss | f1_clear),	// frontend.scala:339:19, :402:42, :814:38, :953:30, :958:17, :965:38, :970:17
    .io_s2_kill                     (s2_xcpt),	// frontend.scala:451:74
    .io_invalidate                  (io_cpu_flush_icache),
    .auto_master_out_a_valid        (auto_icache_master_out_a_valid),
    .auto_master_out_a_bits_address (auto_icache_master_out_a_bits_address),
    .io_resp_valid                  (_icache_io_resp_valid),
    .io_resp_bits_data              (_icache_io_resp_bits_data),
    .io_perf_acquire                (io_cpu_perf_acquire)
  );
  BranchPredictor_2 bpd (	// frontend.scala:333:19
    .clock                                 (clock),
    .reset                                 (reset),
    .io_f0_req_valid                       (s0_valid),	// frontend.scala:953:30, :960:18, :965:38
    .io_f0_req_bits_pc                     (s0_vpc),	// frontend.scala:953:30, :961:18, :965:38
    .io_f0_req_bits_ghist_old_history
      (_GEN_65
         ? (_GEN_62
              ? (_GEN_13
                   ? s2_ghist_old_history
                   : _GEN_17
                       ? _f2_predicted_ghist_new_history_old_history_T_6
                       : _GEN_6 ? _f1_predicted_ghist_new_history_old_history_T_6 : 64'h0)
              : _f3_predicted_ghist_new_history_old_history_T_6)
         : io_cpu_redirect_ghist_old_history),	// frontend.scala:99:37, :350:45, :363:49, :427:{18,35}, :432:18, :442:21, :481:45, :482:58, :488:14, :491:38, :496:95, :499:20, :502:20, :814:38, :821:79, :953:30, :965:38
    .io_f3_fire
      (_f3_bpd_resp_io_enq_ready & _f3_bpd_resp_io_enq_valid_T),	// Decoupled.scala:40:37, frontend.scala:521:11, :549:47
    .io_update_valid                       (_bpd_update_arbiter_io_out_valid),	// frontend.scala:925:34
    .io_update_bits_is_mispredict_update
      (_bpd_update_arbiter_io_out_bits_is_mispredict_update),	// frontend.scala:925:34
    .io_update_bits_is_repair_update
      (_bpd_update_arbiter_io_out_bits_is_repair_update),	// frontend.scala:925:34
    .io_update_bits_btb_mispredicts
      (_bpd_update_arbiter_io_out_bits_btb_mispredicts),	// frontend.scala:925:34
    .io_update_bits_pc                     (_bpd_update_arbiter_io_out_bits_pc),	// frontend.scala:925:34
    .io_update_bits_br_mask                (_bpd_update_arbiter_io_out_bits_br_mask),	// frontend.scala:925:34
    .io_update_bits_cfi_idx_valid
      (_bpd_update_arbiter_io_out_bits_cfi_idx_valid),	// frontend.scala:925:34
    .io_update_bits_cfi_idx_bits           (_bpd_update_arbiter_io_out_bits_cfi_idx_bits),	// frontend.scala:925:34
    .io_update_bits_cfi_taken              (_bpd_update_arbiter_io_out_bits_cfi_taken),	// frontend.scala:925:34
    .io_update_bits_cfi_mispredicted
      (_bpd_update_arbiter_io_out_bits_cfi_mispredicted),	// frontend.scala:925:34
    .io_update_bits_cfi_is_br              (_bpd_update_arbiter_io_out_bits_cfi_is_br),	// frontend.scala:925:34
    .io_update_bits_cfi_is_jal             (_bpd_update_arbiter_io_out_bits_cfi_is_jal),	// frontend.scala:925:34
    .io_update_bits_ghist_old_history
      (_bpd_update_arbiter_io_out_bits_ghist_old_history),	// frontend.scala:925:34
    .io_update_bits_target                 (_bpd_update_arbiter_io_out_bits_target),	// frontend.scala:925:34
    .io_update_bits_meta_0                 (_bpd_update_arbiter_io_out_bits_meta_0),	// frontend.scala:925:34
    .io_resp_f1_preds_0_taken              (_bpd_io_resp_f1_preds_0_taken),
    .io_resp_f1_preds_0_is_br              (_bpd_io_resp_f1_preds_0_is_br),
    .io_resp_f1_preds_0_is_jal             (_bpd_io_resp_f1_preds_0_is_jal),
    .io_resp_f1_preds_0_predicted_pc_valid (_bpd_io_resp_f1_preds_0_predicted_pc_valid),
    .io_resp_f1_preds_0_predicted_pc_bits  (_bpd_io_resp_f1_preds_0_predicted_pc_bits),
    .io_resp_f1_preds_1_taken              (_bpd_io_resp_f1_preds_1_taken),
    .io_resp_f1_preds_1_is_br              (_bpd_io_resp_f1_preds_1_is_br),
    .io_resp_f1_preds_1_is_jal             (_bpd_io_resp_f1_preds_1_is_jal),
    .io_resp_f1_preds_1_predicted_pc_valid (_bpd_io_resp_f1_preds_1_predicted_pc_valid),
    .io_resp_f1_preds_1_predicted_pc_bits  (_bpd_io_resp_f1_preds_1_predicted_pc_bits),
    .io_resp_f1_preds_2_taken              (_bpd_io_resp_f1_preds_2_taken),
    .io_resp_f1_preds_2_is_br              (_bpd_io_resp_f1_preds_2_is_br),
    .io_resp_f1_preds_2_is_jal             (_bpd_io_resp_f1_preds_2_is_jal),
    .io_resp_f1_preds_2_predicted_pc_valid (_bpd_io_resp_f1_preds_2_predicted_pc_valid),
    .io_resp_f1_preds_2_predicted_pc_bits  (_bpd_io_resp_f1_preds_2_predicted_pc_bits),
    .io_resp_f1_preds_3_taken              (_bpd_io_resp_f1_preds_3_taken),
    .io_resp_f1_preds_3_is_br              (_bpd_io_resp_f1_preds_3_is_br),
    .io_resp_f1_preds_3_is_jal             (_bpd_io_resp_f1_preds_3_is_jal),
    .io_resp_f1_preds_3_predicted_pc_valid (_bpd_io_resp_f1_preds_3_predicted_pc_valid),
    .io_resp_f1_preds_3_predicted_pc_bits  (_bpd_io_resp_f1_preds_3_predicted_pc_bits),
    .io_resp_f2_preds_0_taken              (_bpd_io_resp_f2_preds_0_taken),
    .io_resp_f2_preds_0_is_br              (_bpd_io_resp_f2_preds_0_is_br),
    .io_resp_f2_preds_0_is_jal             (_bpd_io_resp_f2_preds_0_is_jal),
    .io_resp_f2_preds_0_predicted_pc_valid (_bpd_io_resp_f2_preds_0_predicted_pc_valid),
    .io_resp_f2_preds_0_predicted_pc_bits  (_bpd_io_resp_f2_preds_0_predicted_pc_bits),
    .io_resp_f2_preds_1_taken              (_bpd_io_resp_f2_preds_1_taken),
    .io_resp_f2_preds_1_is_br              (_bpd_io_resp_f2_preds_1_is_br),
    .io_resp_f2_preds_1_is_jal             (_bpd_io_resp_f2_preds_1_is_jal),
    .io_resp_f2_preds_1_predicted_pc_valid (_bpd_io_resp_f2_preds_1_predicted_pc_valid),
    .io_resp_f2_preds_1_predicted_pc_bits  (_bpd_io_resp_f2_preds_1_predicted_pc_bits),
    .io_resp_f2_preds_2_taken              (_bpd_io_resp_f2_preds_2_taken),
    .io_resp_f2_preds_2_is_br              (_bpd_io_resp_f2_preds_2_is_br),
    .io_resp_f2_preds_2_is_jal             (_bpd_io_resp_f2_preds_2_is_jal),
    .io_resp_f2_preds_2_predicted_pc_valid (_bpd_io_resp_f2_preds_2_predicted_pc_valid),
    .io_resp_f2_preds_2_predicted_pc_bits  (_bpd_io_resp_f2_preds_2_predicted_pc_bits),
    .io_resp_f2_preds_3_taken              (_bpd_io_resp_f2_preds_3_taken),
    .io_resp_f2_preds_3_is_br              (_bpd_io_resp_f2_preds_3_is_br),
    .io_resp_f2_preds_3_is_jal             (_bpd_io_resp_f2_preds_3_is_jal),
    .io_resp_f2_preds_3_predicted_pc_valid (_bpd_io_resp_f2_preds_3_predicted_pc_valid),
    .io_resp_f2_preds_3_predicted_pc_bits  (_bpd_io_resp_f2_preds_3_predicted_pc_bits),
    .io_resp_f3_pc                         (_bpd_io_resp_f3_pc),
    .io_resp_f3_preds_0_taken              (_bpd_io_resp_f3_preds_0_taken),
    .io_resp_f3_preds_0_is_br              (_bpd_io_resp_f3_preds_0_is_br),
    .io_resp_f3_preds_0_is_jal             (_bpd_io_resp_f3_preds_0_is_jal),
    .io_resp_f3_preds_0_predicted_pc_valid (_bpd_io_resp_f3_preds_0_predicted_pc_valid),
    .io_resp_f3_preds_0_predicted_pc_bits  (_bpd_io_resp_f3_preds_0_predicted_pc_bits),
    .io_resp_f3_preds_1_taken              (_bpd_io_resp_f3_preds_1_taken),
    .io_resp_f3_preds_1_is_br              (_bpd_io_resp_f3_preds_1_is_br),
    .io_resp_f3_preds_1_is_jal             (_bpd_io_resp_f3_preds_1_is_jal),
    .io_resp_f3_preds_1_predicted_pc_valid (_bpd_io_resp_f3_preds_1_predicted_pc_valid),
    .io_resp_f3_preds_1_predicted_pc_bits  (_bpd_io_resp_f3_preds_1_predicted_pc_bits),
    .io_resp_f3_preds_2_taken              (_bpd_io_resp_f3_preds_2_taken),
    .io_resp_f3_preds_2_is_br              (_bpd_io_resp_f3_preds_2_is_br),
    .io_resp_f3_preds_2_is_jal             (_bpd_io_resp_f3_preds_2_is_jal),
    .io_resp_f3_preds_2_predicted_pc_valid (_bpd_io_resp_f3_preds_2_predicted_pc_valid),
    .io_resp_f3_preds_2_predicted_pc_bits  (_bpd_io_resp_f3_preds_2_predicted_pc_bits),
    .io_resp_f3_preds_3_taken              (_bpd_io_resp_f3_preds_3_taken),
    .io_resp_f3_preds_3_is_br              (_bpd_io_resp_f3_preds_3_is_br),
    .io_resp_f3_preds_3_is_jal             (_bpd_io_resp_f3_preds_3_is_jal),
    .io_resp_f3_preds_3_predicted_pc_valid (_bpd_io_resp_f3_preds_3_predicted_pc_valid),
    .io_resp_f3_preds_3_predicted_pc_bits  (_bpd_io_resp_f3_preds_3_predicted_pc_bits),
    .io_resp_f3_meta_0                     (_bpd_io_resp_f3_meta_0)
  );
  BoomRAS ras (	// frontend.scala:335:19
    .clock          (clock),
    .io_read_idx    (_GEN_19 ? _GEN : ras_read_idx),	// Decoupled.scala:40:37, frontend.scala:533:24, :540:29, :542:27, :543:18, :814:38, :821:79, :822:28
    .io_write_valid
      (_ftq_io_ras_update | _GEN_55 & f3_fetch_bundle_cfi_is_call
       & f3_fetch_bundle_cfi_idx_valid),	// frontend.scala:756:33, :777:57, :805:22, :814:{25,38}, :815:73, :862:19, :933:52, :934:24
    .io_write_idx   (_ftq_io_ras_update ? _ftq_io_ras_update_idx : _ras_io_write_idx_T),	// frontend.scala:808:22, :862:19, :933:52, :935:24, util.scala:203:14
    .io_write_addr
      (_ftq_io_ras_update
         ? _ftq_io_ras_update_pc
         : _GEN_20 + {37'h0, f3_fetch_bundle_cfi_idx_bits, 1'h0}
           + {37'h0, f3_fetch_bundle_cfi_npc_plus4 ? 3'h4 : 3'h2}),	// Mux.scala:47:69, frontend.scala:300:26, :333:19, :339:19, :521:11, :569:29, :606:23, :619:69, :696:49, :715:86, :758:33, :806:{22,39,77,82}, :842:34, :859:11, :861:19, :862:19, :925:34, :933:52, :936:24
    .io_read_addr   (_ras_io_read_addr)
  );
  TLB_8 tlb (	// frontend.scala:339:19
    .clock                        (clock),
    .reset                        (reset),
    .io_req_valid                 (s1_valid & ~s1_is_replay & ~f1_clear | s1_is_sfence),	// frontend.scala:382:29, :384:29, :385:29, :388:{41,55,58,69}, :814:38, :953:30, :958:17, :965:38, :970:17
    .io_req_bits_vaddr            (s1_vpc),	// frontend.scala:381:29
    .io_sfence_valid              (tlb_io_sfence_REG_valid),	// frontend.scala:393:35
    .io_sfence_bits_rs1           (tlb_io_sfence_REG_bits_rs1),	// frontend.scala:393:35
    .io_sfence_bits_rs2           (tlb_io_sfence_REG_bits_rs2),	// frontend.scala:393:35
    .io_sfence_bits_addr          (tlb_io_sfence_REG_bits_addr),	// frontend.scala:393:35
    .io_ptw_req_ready             (io_ptw_req_ready),
    .io_ptw_resp_valid            (io_ptw_resp_valid),
    .io_ptw_resp_bits_ae          (io_ptw_resp_bits_ae),
    .io_ptw_resp_bits_pte_ppn     (io_ptw_resp_bits_pte_ppn),
    .io_ptw_resp_bits_pte_d       (io_ptw_resp_bits_pte_d),
    .io_ptw_resp_bits_pte_a       (io_ptw_resp_bits_pte_a),
    .io_ptw_resp_bits_pte_g       (io_ptw_resp_bits_pte_g),
    .io_ptw_resp_bits_pte_u       (io_ptw_resp_bits_pte_u),
    .io_ptw_resp_bits_pte_x       (io_ptw_resp_bits_pte_x),
    .io_ptw_resp_bits_pte_w       (io_ptw_resp_bits_pte_w),
    .io_ptw_resp_bits_pte_r       (io_ptw_resp_bits_pte_r),
    .io_ptw_resp_bits_pte_v       (io_ptw_resp_bits_pte_v),
    .io_ptw_resp_bits_level       (io_ptw_resp_bits_level),
    .io_ptw_resp_bits_homogeneous (io_ptw_resp_bits_homogeneous),
    .io_ptw_ptbr_mode             (io_ptw_ptbr_mode),
    .io_ptw_status_debug          (io_ptw_status_debug),
    .io_ptw_status_prv            (io_ptw_status_prv),
    .io_ptw_pmp_0_cfg_l           (io_ptw_pmp_0_cfg_l),
    .io_ptw_pmp_0_cfg_a           (io_ptw_pmp_0_cfg_a),
    .io_ptw_pmp_0_cfg_x           (io_ptw_pmp_0_cfg_x),
    .io_ptw_pmp_0_cfg_w           (io_ptw_pmp_0_cfg_w),
    .io_ptw_pmp_0_cfg_r           (io_ptw_pmp_0_cfg_r),
    .io_ptw_pmp_0_addr            (io_ptw_pmp_0_addr),
    .io_ptw_pmp_0_mask            (io_ptw_pmp_0_mask),
    .io_ptw_pmp_1_cfg_l           (io_ptw_pmp_1_cfg_l),
    .io_ptw_pmp_1_cfg_a           (io_ptw_pmp_1_cfg_a),
    .io_ptw_pmp_1_cfg_x           (io_ptw_pmp_1_cfg_x),
    .io_ptw_pmp_1_cfg_w           (io_ptw_pmp_1_cfg_w),
    .io_ptw_pmp_1_cfg_r           (io_ptw_pmp_1_cfg_r),
    .io_ptw_pmp_1_addr            (io_ptw_pmp_1_addr),
    .io_ptw_pmp_1_mask            (io_ptw_pmp_1_mask),
    .io_ptw_pmp_2_cfg_l           (io_ptw_pmp_2_cfg_l),
    .io_ptw_pmp_2_cfg_a           (io_ptw_pmp_2_cfg_a),
    .io_ptw_pmp_2_cfg_x           (io_ptw_pmp_2_cfg_x),
    .io_ptw_pmp_2_cfg_w           (io_ptw_pmp_2_cfg_w),
    .io_ptw_pmp_2_cfg_r           (io_ptw_pmp_2_cfg_r),
    .io_ptw_pmp_2_addr            (io_ptw_pmp_2_addr),
    .io_ptw_pmp_2_mask            (io_ptw_pmp_2_mask),
    .io_ptw_pmp_3_cfg_l           (io_ptw_pmp_3_cfg_l),
    .io_ptw_pmp_3_cfg_a           (io_ptw_pmp_3_cfg_a),
    .io_ptw_pmp_3_cfg_x           (io_ptw_pmp_3_cfg_x),
    .io_ptw_pmp_3_cfg_w           (io_ptw_pmp_3_cfg_w),
    .io_ptw_pmp_3_cfg_r           (io_ptw_pmp_3_cfg_r),
    .io_ptw_pmp_3_addr            (io_ptw_pmp_3_addr),
    .io_ptw_pmp_3_mask            (io_ptw_pmp_3_mask),
    .io_ptw_pmp_4_cfg_l           (io_ptw_pmp_4_cfg_l),
    .io_ptw_pmp_4_cfg_a           (io_ptw_pmp_4_cfg_a),
    .io_ptw_pmp_4_cfg_x           (io_ptw_pmp_4_cfg_x),
    .io_ptw_pmp_4_cfg_w           (io_ptw_pmp_4_cfg_w),
    .io_ptw_pmp_4_cfg_r           (io_ptw_pmp_4_cfg_r),
    .io_ptw_pmp_4_addr            (io_ptw_pmp_4_addr),
    .io_ptw_pmp_4_mask            (io_ptw_pmp_4_mask),
    .io_ptw_pmp_5_cfg_l           (io_ptw_pmp_5_cfg_l),
    .io_ptw_pmp_5_cfg_a           (io_ptw_pmp_5_cfg_a),
    .io_ptw_pmp_5_cfg_x           (io_ptw_pmp_5_cfg_x),
    .io_ptw_pmp_5_cfg_w           (io_ptw_pmp_5_cfg_w),
    .io_ptw_pmp_5_cfg_r           (io_ptw_pmp_5_cfg_r),
    .io_ptw_pmp_5_addr            (io_ptw_pmp_5_addr),
    .io_ptw_pmp_5_mask            (io_ptw_pmp_5_mask),
    .io_ptw_pmp_6_cfg_l           (io_ptw_pmp_6_cfg_l),
    .io_ptw_pmp_6_cfg_a           (io_ptw_pmp_6_cfg_a),
    .io_ptw_pmp_6_cfg_x           (io_ptw_pmp_6_cfg_x),
    .io_ptw_pmp_6_cfg_w           (io_ptw_pmp_6_cfg_w),
    .io_ptw_pmp_6_cfg_r           (io_ptw_pmp_6_cfg_r),
    .io_ptw_pmp_6_addr            (io_ptw_pmp_6_addr),
    .io_ptw_pmp_6_mask            (io_ptw_pmp_6_mask),
    .io_ptw_pmp_7_cfg_l           (io_ptw_pmp_7_cfg_l),
    .io_ptw_pmp_7_cfg_a           (io_ptw_pmp_7_cfg_a),
    .io_ptw_pmp_7_cfg_x           (io_ptw_pmp_7_cfg_x),
    .io_ptw_pmp_7_cfg_w           (io_ptw_pmp_7_cfg_w),
    .io_ptw_pmp_7_cfg_r           (io_ptw_pmp_7_cfg_r),
    .io_ptw_pmp_7_addr            (io_ptw_pmp_7_addr),
    .io_ptw_pmp_7_mask            (io_ptw_pmp_7_mask),
    .io_resp_miss                 (_tlb_io_resp_miss),
    .io_resp_paddr                (_tlb_io_resp_paddr),
    .io_resp_pf_inst              (_tlb_io_resp_pf_inst),
    .io_resp_ae_inst              (_tlb_io_resp_ae_inst),
    .io_ptw_req_valid             (_tlb_io_ptw_req_valid),
    .io_ptw_req_bits_bits_addr    (io_ptw_req_bits_bits_addr)
  );
  Queue_65 f3 (	// frontend.scala:516:11
    .clock                                          (clock),
    .reset                                          (_GEN_18),	// frontend.scala:515:35
    .io_enq_valid                                   (_f3_io_enq_valid_T_6),	// frontend.scala:528:47
    .io_enq_bits_pc                                 (s2_vpc),	// frontend.scala:441:25
    .io_enq_bits_data
      (s2_xcpt ? 64'h0 : _icache_io_resp_bits_data),	// frontend.scala:300:26, :350:45, :451:74, :532:30
    .io_enq_bits_mask                               (_f3_io_enq_bits_mask_T[3:0]),	// frontend.scala:178:31, :534:23
    .io_enq_bits_xcpt_pf_inst                       (s2_tlb_resp_pf_inst),	// frontend.scala:448:28
    .io_enq_bits_xcpt_ae_inst                       (s2_tlb_resp_ae_inst),	// frontend.scala:448:28
    .io_enq_bits_ghist_old_history
      (_GEN_57 ? _f3_predicted_ghist_new_history_old_history_T_6 : s2_ghist_old_history),	// frontend.scala:99:37, :442:21, :533:24, :814:38, :821:79, :822:28
    .io_enq_bits_ghist_current_saw_branch_not_taken
      (~_GEN_57 & s2_ghist_current_saw_branch_not_taken),	// frontend.scala:442:21, :533:24, :814:38, :821:79, :822:28
    .io_enq_bits_ghist_new_saw_branch_not_taken
      (~_GEN_57 & s2_ghist_new_saw_branch_not_taken),	// frontend.scala:442:21, :533:24, :814:38, :821:79, :822:28
    .io_enq_bits_ghist_new_saw_branch_taken
      (~_GEN_57 & s2_ghist_new_saw_branch_taken),	// frontend.scala:442:21, :533:24, :814:38, :821:79, :822:28
    .io_enq_bits_ghist_ras_idx                      (_GEN),	// frontend.scala:533:24, :814:38, :821:79, :822:28
    .io_enq_bits_fsrc                               (_GEN_13 ? 2'h0 : {1'h0, _GEN_17}),	// frontend.scala:300:26, :333:19, :339:19, :427:35, :481:45, :482:58, :491:38, :496:95, :499:20, :503:20, :521:11, :569:29, :606:23, :842:34, :859:11, :861:19, :862:19, :925:34
    .io_enq_bits_tsrc                               (s2_tsrc),	// frontend.scala:445:24
    .io_deq_ready                                   (_f4_io_enq_ready),	// frontend.scala:859:11
    .io_enq_ready                                   (_f3_io_enq_ready),
    .io_deq_valid                                   (_f3_io_deq_valid),
    .io_deq_bits_pc                                 (_f3_io_deq_bits_pc),
    .io_deq_bits_data                               (_f3_io_deq_bits_data),
    .io_deq_bits_mask                               (_f3_io_deq_bits_mask),
    .io_deq_bits_xcpt_pf_inst                       (_f3_io_deq_bits_xcpt_pf_inst),
    .io_deq_bits_xcpt_ae_inst                       (_f3_io_deq_bits_xcpt_ae_inst),
    .io_deq_bits_ghist_old_history                  (_f3_io_deq_bits_ghist_old_history),
    .io_deq_bits_ghist_current_saw_branch_not_taken
      (_f3_io_deq_bits_ghist_current_saw_branch_not_taken),
    .io_deq_bits_ghist_new_saw_branch_not_taken
      (_f3_io_deq_bits_ghist_new_saw_branch_not_taken),
    .io_deq_bits_ghist_new_saw_branch_taken
      (_f3_io_deq_bits_ghist_new_saw_branch_taken),
    .io_deq_bits_ghist_ras_idx                      (_f3_io_deq_bits_ghist_ras_idx),
    .io_deq_bits_fsrc                               (_f3_io_deq_bits_fsrc),
    .io_deq_bits_tsrc                               (_f3_io_deq_bits_tsrc)
  );
  Queue_66 f3_bpd_resp (	// frontend.scala:521:11
    .clock                                  (clock),
    .reset                                  (_GEN_18),	// frontend.scala:515:35
    .io_enq_valid                           (_f3_bpd_resp_io_enq_valid_T),	// frontend.scala:549:47
    .io_enq_bits_pc                         (_bpd_io_resp_f3_pc),	// frontend.scala:333:19
    .io_enq_bits_preds_0_taken              (_bpd_io_resp_f3_preds_0_taken),	// frontend.scala:333:19
    .io_enq_bits_preds_0_is_br              (_bpd_io_resp_f3_preds_0_is_br),	// frontend.scala:333:19
    .io_enq_bits_preds_0_is_jal             (_bpd_io_resp_f3_preds_0_is_jal),	// frontend.scala:333:19
    .io_enq_bits_preds_0_predicted_pc_valid (_bpd_io_resp_f3_preds_0_predicted_pc_valid),	// frontend.scala:333:19
    .io_enq_bits_preds_0_predicted_pc_bits  (_bpd_io_resp_f3_preds_0_predicted_pc_bits),	// frontend.scala:333:19
    .io_enq_bits_preds_1_taken              (_bpd_io_resp_f3_preds_1_taken),	// frontend.scala:333:19
    .io_enq_bits_preds_1_is_br              (_bpd_io_resp_f3_preds_1_is_br),	// frontend.scala:333:19
    .io_enq_bits_preds_1_is_jal             (_bpd_io_resp_f3_preds_1_is_jal),	// frontend.scala:333:19
    .io_enq_bits_preds_1_predicted_pc_valid (_bpd_io_resp_f3_preds_1_predicted_pc_valid),	// frontend.scala:333:19
    .io_enq_bits_preds_1_predicted_pc_bits  (_bpd_io_resp_f3_preds_1_predicted_pc_bits),	// frontend.scala:333:19
    .io_enq_bits_preds_2_taken              (_bpd_io_resp_f3_preds_2_taken),	// frontend.scala:333:19
    .io_enq_bits_preds_2_is_br              (_bpd_io_resp_f3_preds_2_is_br),	// frontend.scala:333:19
    .io_enq_bits_preds_2_is_jal             (_bpd_io_resp_f3_preds_2_is_jal),	// frontend.scala:333:19
    .io_enq_bits_preds_2_predicted_pc_valid (_bpd_io_resp_f3_preds_2_predicted_pc_valid),	// frontend.scala:333:19
    .io_enq_bits_preds_2_predicted_pc_bits  (_bpd_io_resp_f3_preds_2_predicted_pc_bits),	// frontend.scala:333:19
    .io_enq_bits_preds_3_taken              (_bpd_io_resp_f3_preds_3_taken),	// frontend.scala:333:19
    .io_enq_bits_preds_3_is_br              (_bpd_io_resp_f3_preds_3_is_br),	// frontend.scala:333:19
    .io_enq_bits_preds_3_is_jal             (_bpd_io_resp_f3_preds_3_is_jal),	// frontend.scala:333:19
    .io_enq_bits_preds_3_predicted_pc_valid (_bpd_io_resp_f3_preds_3_predicted_pc_valid),	// frontend.scala:333:19
    .io_enq_bits_preds_3_predicted_pc_bits  (_bpd_io_resp_f3_preds_3_predicted_pc_bits),	// frontend.scala:333:19
    .io_enq_bits_meta_0                     (_bpd_io_resp_f3_meta_0),	// frontend.scala:333:19
    .io_deq_ready                           (_f4_io_enq_ready),	// frontend.scala:859:11
    .io_enq_ready                           (_f3_bpd_resp_io_enq_ready),
    .io_deq_bits_pc                         (_f3_bpd_resp_io_deq_bits_pc),
    .io_deq_bits_preds_0_taken              (_f3_bpd_resp_io_deq_bits_preds_0_taken),
    .io_deq_bits_preds_0_predicted_pc_valid
      (_f3_bpd_resp_io_deq_bits_preds_0_predicted_pc_valid),
    .io_deq_bits_preds_0_predicted_pc_bits
      (_f3_bpd_resp_io_deq_bits_preds_0_predicted_pc_bits),
    .io_deq_bits_preds_1_taken              (_f3_bpd_resp_io_deq_bits_preds_1_taken),
    .io_deq_bits_preds_1_predicted_pc_valid
      (_f3_bpd_resp_io_deq_bits_preds_1_predicted_pc_valid),
    .io_deq_bits_preds_1_predicted_pc_bits
      (_f3_bpd_resp_io_deq_bits_preds_1_predicted_pc_bits),
    .io_deq_bits_preds_2_taken              (_f3_bpd_resp_io_deq_bits_preds_2_taken),
    .io_deq_bits_preds_2_predicted_pc_valid
      (_f3_bpd_resp_io_deq_bits_preds_2_predicted_pc_valid),
    .io_deq_bits_preds_2_predicted_pc_bits
      (_f3_bpd_resp_io_deq_bits_preds_2_predicted_pc_bits),
    .io_deq_bits_preds_3_taken              (_f3_bpd_resp_io_deq_bits_preds_3_taken),
    .io_deq_bits_preds_3_predicted_pc_valid
      (_f3_bpd_resp_io_deq_bits_preds_3_predicted_pc_valid),
    .io_deq_bits_preds_3_predicted_pc_bits
      (_f3_bpd_resp_io_deq_bits_preds_3_predicted_pc_bits),
    .io_deq_bits_meta_0                     (_f3_bpd_resp_io_deq_bits_meta_0),
    .io_deq_bits_lhist_0                    (_f3_bpd_resp_io_deq_bits_lhist_0)
  );
  RVCExpander_3 exp_inst0_rvc_exp (	// consts.scala:330:25
    .io_in       (inst0),	// Cat.scala:30:58
    .io_out_bits (_exp_inst0_rvc_exp_io_out_bits),
    .io_rvc      (_exp_inst0_rvc_exp_io_rvc)
  );
  RVCExpander_3 exp_inst1_rvc_exp (	// consts.scala:330:25
    .io_in       (_f3_io_deq_bits_data[31:0]),	// frontend.scala:516:11, :616:30
    .io_out_bits (_exp_inst1_rvc_exp_io_out_bits),
    .io_rvc      (_exp_inst1_rvc_exp_io_rvc)
  );
  BranchDecode bpd_decoder0 (	// frontend.scala:622:34
    .io_inst                 (exp_inst0),	// consts.scala:332:8
    .io_pc                   (_GEN_20 - 40'h2),	// frontend.scala:619:69
    .io_out_is_ret           (_bpd_decoder0_io_out_is_ret),
    .io_out_is_call          (_bpd_decoder0_io_out_is_call),
    .io_out_target           (_bpd_decoder0_io_out_target),
    .io_out_cfi_type         (_bpd_decoder0_io_out_cfi_type),
    .io_out_sfb_offset_valid (_bpd_decoder0_io_out_sfb_offset_valid),
    .io_out_sfb_offset_bits  (_bpd_decoder0_io_out_sfb_offset_bits),
    .io_out_shadowable       (_bpd_decoder0_io_out_shadowable)
  );
  BranchDecode bpd_decoder1 (	// frontend.scala:625:34
    .io_inst                 (exp_inst1),	// consts.scala:332:8
    .io_pc                   ({_f3_io_deq_bits_pc[39:3], 3'h0}),	// frontend.scala:161:39, :178:31, :516:11
    .io_out_is_ret           (_bpd_decoder1_io_out_is_ret),
    .io_out_is_call          (_bpd_decoder1_io_out_is_call),
    .io_out_target           (_bpd_decoder1_io_out_target),
    .io_out_cfi_type         (_bpd_decoder1_io_out_cfi_type),
    .io_out_sfb_offset_valid (_bpd_decoder1_io_out_sfb_offset_valid),
    .io_out_sfb_offset_bits  (_bpd_decoder1_io_out_sfb_offset_bits),
    .io_out_shadowable       (_bpd_decoder1_io_out_shadowable)
  );
  RVCExpander_3 exp_inst_rvc_exp (	// consts.scala:330:25
    .io_in       (inst),	// frontend.scala:674:29
    .io_out_bits (_exp_inst_rvc_exp_io_out_bits),
    .io_rvc      (_exp_inst_rvc_exp_io_rvc)
  );
  BranchDecode bpd_decoder (	// frontend.scala:663:33
    .io_inst                 (f3_fetch_bundle_exp_insts_1),	// consts.scala:332:8
    .io_pc                   (_GEN_20 + 40'h2),	// frontend.scala:619:69, :662:32
    .io_out_is_ret           (_bpd_decoder_io_out_is_ret),
    .io_out_is_call          (_bpd_decoder_io_out_is_call),
    .io_out_target           (_bpd_decoder_io_out_target),
    .io_out_cfi_type         (_bpd_decoder_io_out_cfi_type),
    .io_out_sfb_offset_valid (_bpd_decoder_io_out_sfb_offset_valid),
    .io_out_sfb_offset_bits  (_bpd_decoder_io_out_sfb_offset_bits),
    .io_out_shadowable       (_bpd_decoder_io_out_shadowable)
  );
  RVCExpander_3 exp_inst_rvc_exp_1 (	// consts.scala:330:25
    .io_in       (inst_1),	// frontend.scala:681:29
    .io_out_bits (_exp_inst_rvc_exp_1_io_out_bits),
    .io_rvc      (_exp_inst_rvc_exp_1_io_rvc)
  );
  BranchDecode bpd_decoder_1 (	// frontend.scala:663:33
    .io_inst                 (f3_fetch_bundle_exp_insts_2),	// consts.scala:332:8
    .io_pc                   (_GEN_20 + 40'h4),	// frontend.scala:619:69, :662:32
    .io_out_is_ret           (_bpd_decoder_1_io_out_is_ret),
    .io_out_is_call          (_bpd_decoder_1_io_out_is_call),
    .io_out_target           (_bpd_decoder_1_io_out_target),
    .io_out_cfi_type         (_bpd_decoder_1_io_out_cfi_type),
    .io_out_sfb_offset_valid (_bpd_decoder_1_io_out_sfb_offset_valid),
    .io_out_sfb_offset_bits  (_bpd_decoder_1_io_out_sfb_offset_bits),
    .io_out_shadowable       (_bpd_decoder_1_io_out_shadowable)
  );
  RVCExpander_3 exp_inst_rvc_exp_2 (	// consts.scala:330:25
    .io_in       (inst_2),	// Cat.scala:30:58
    .io_out_bits (_exp_inst_rvc_exp_2_io_out_bits),
    .io_rvc      (_exp_inst_rvc_exp_2_io_rvc)
  );
  BranchDecode bpd_decoder_2 (	// frontend.scala:663:33
    .io_inst                 (f3_fetch_bundle_exp_insts_3),	// consts.scala:332:8
    .io_pc                   (_GEN_20 + 40'h6),	// frontend.scala:619:69, :662:32
    .io_out_is_ret           (_bpd_decoder_2_io_out_is_ret),
    .io_out_is_call          (_bpd_decoder_2_io_out_is_call),
    .io_out_target           (_bpd_decoder_2_io_out_target),
    .io_out_cfi_type         (_bpd_decoder_2_io_out_cfi_type),
    .io_out_sfb_offset_valid (_bpd_decoder_2_io_out_sfb_offset_valid),
    .io_out_sfb_offset_bits  (_bpd_decoder_2_io_out_sfb_offset_bits),
    .io_out_shadowable       (_bpd_decoder_2_io_out_shadowable)
  );
  Queue_67 f4_btb_corrections (	// frontend.scala:842:34
    .clock                                          (clock),
    .reset                                          (reset),
    .io_enq_valid
      (_f4_btb_corrections_io_enq_valid_T
       & (f3_btb_mispredicts_0 | f3_btb_mispredicts_1 | f3_btb_mispredicts_2
          | f3_btb_mispredicts_3)),	// Decoupled.scala:40:37, frontend.scala:697:61, :843:{55,85}
    .io_enq_bits_btb_mispredicts
      ({f3_btb_mispredicts_3,
        f3_btb_mispredicts_2,
        f3_btb_mispredicts_1,
        f3_btb_mispredicts_0}),	// frontend.scala:697:61, :847:77
    .io_enq_bits_pc                                 (_f3_io_deq_bits_pc),	// frontend.scala:516:11
    .io_enq_bits_ghist_old_history                  (_f3_io_deq_bits_ghist_old_history),	// frontend.scala:516:11
    .io_enq_bits_ghist_current_saw_branch_not_taken
      (_f3_io_deq_bits_ghist_current_saw_branch_not_taken),	// frontend.scala:516:11
    .io_enq_bits_ghist_new_saw_branch_not_taken
      (_f3_io_deq_bits_ghist_new_saw_branch_not_taken),	// frontend.scala:516:11
    .io_enq_bits_ghist_new_saw_branch_taken
      (_f3_io_deq_bits_ghist_new_saw_branch_taken),	// frontend.scala:516:11
    .io_enq_bits_ghist_ras_idx                      (_f3_io_deq_bits_ghist_ras_idx),	// frontend.scala:516:11
    .io_enq_bits_lhist_0                            (_f3_bpd_resp_io_deq_bits_lhist_0),	// frontend.scala:521:11
    .io_enq_bits_meta_0                             (_f3_bpd_resp_io_deq_bits_meta_0),	// frontend.scala:521:11
    .io_deq_ready                                   (_bpd_update_arbiter_io_in_1_ready),	// frontend.scala:925:34
    .io_deq_valid                                   (_f4_btb_corrections_io_deq_valid),
    .io_deq_bits_is_mispredict_update
      (_f4_btb_corrections_io_deq_bits_is_mispredict_update),
    .io_deq_bits_is_repair_update
      (_f4_btb_corrections_io_deq_bits_is_repair_update),
    .io_deq_bits_btb_mispredicts
      (_f4_btb_corrections_io_deq_bits_btb_mispredicts),
    .io_deq_bits_pc                                 (_f4_btb_corrections_io_deq_bits_pc),
    .io_deq_bits_br_mask
      (_f4_btb_corrections_io_deq_bits_br_mask),
    .io_deq_bits_cfi_idx_valid
      (_f4_btb_corrections_io_deq_bits_cfi_idx_valid),
    .io_deq_bits_cfi_idx_bits
      (_f4_btb_corrections_io_deq_bits_cfi_idx_bits),
    .io_deq_bits_cfi_taken
      (_f4_btb_corrections_io_deq_bits_cfi_taken),
    .io_deq_bits_cfi_mispredicted
      (_f4_btb_corrections_io_deq_bits_cfi_mispredicted),
    .io_deq_bits_cfi_is_br
      (_f4_btb_corrections_io_deq_bits_cfi_is_br),
    .io_deq_bits_cfi_is_jal
      (_f4_btb_corrections_io_deq_bits_cfi_is_jal),
    .io_deq_bits_ghist_old_history
      (_f4_btb_corrections_io_deq_bits_ghist_old_history),
    .io_deq_bits_target
      (_f4_btb_corrections_io_deq_bits_target),
    .io_deq_bits_meta_0
      (_f4_btb_corrections_io_deq_bits_meta_0)
  );
  Queue_68 f4 (	// frontend.scala:859:11
    .clock                                          (clock),
    .reset                                          (_GEN_18),	// frontend.scala:515:35
    .io_enq_valid                                   (_f4_io_enq_valid_T_1),	// frontend.scala:908:38
    .io_enq_bits_pc                                 (_f3_io_deq_bits_pc),	// frontend.scala:516:11
    .io_enq_bits_next_pc                            (f3_fetch_bundle_next_pc),	// frontend.scala:784:32
    .io_enq_bits_edge_inst_0                        (f3_prev_is_half),	// frontend.scala:589:32
    .io_enq_bits_insts_0                            (bank_insts_0),	// frontend.scala:629:34, :630:40, :651:40
    .io_enq_bits_insts_1                            (inst),	// frontend.scala:674:29
    .io_enq_bits_insts_2                            (inst_1),	// frontend.scala:681:29
    .io_enq_bits_insts_3                            (inst_2),	// Cat.scala:30:58
    .io_enq_bits_exp_insts_0
      (f3_prev_is_half ? exp_inst0 : exp_inst1),	// consts.scala:332:8, frontend.scala:589:32, :629:34, :632:40, :653:40
    .io_enq_bits_exp_insts_1                        (f3_fetch_bundle_exp_insts_1),	// consts.scala:332:8
    .io_enq_bits_exp_insts_2                        (f3_fetch_bundle_exp_insts_2),	// consts.scala:332:8
    .io_enq_bits_exp_insts_3                        (f3_fetch_bundle_exp_insts_3),	// consts.scala:332:8
    .io_enq_bits_sfbs_0
      (f3_mask_0
       & (f3_prev_is_half
            ? _bpd_decoder0_io_out_sfb_offset_valid
            : _bpd_decoder1_io_out_sfb_offset_valid)
       & _offset_from_aligned_pc_T_4 < 7'h11),	// frontend.scala:589:32, :622:34, :625:34, :629:34, :634:40, :655:40, :690:39, :709:32, :719:33, :720:33
    .io_enq_bits_sfbs_1
      (f3_mask_1 & _bpd_decoder_io_out_sfb_offset_valid
       & _offset_from_aligned_pc_T_5 < 7'h11),	// frontend.scala:663:33, :690:71, :708:50, :719:33, :720:33
    .io_enq_bits_sfbs_2
      (f3_mask_2 & _bpd_decoder_1_io_out_sfb_offset_valid
       & _offset_from_aligned_pc_T_10 < 7'h11),	// frontend.scala:663:33, :690:71, :708:50, :719:33, :720:33
    .io_enq_bits_sfbs_3
      (f3_mask_3 & _bpd_decoder_2_io_out_sfb_offset_valid
       & _offset_from_aligned_pc_T_15 < 7'h11),	// frontend.scala:663:33, :690:71, :708:50, :719:33, :720:33
    .io_enq_bits_sfb_masks_0
      (~(_upper_mask_T_1[7:0]
         | {_GEN_26[1] | _GEN_21,
            _GEN_26[0],
            _GEN_25[0],
            _GEN_24[0],
            _GEN_23[0],
            _GEN_22[0],
            _GEN_21,
            1'h0}) & 8'hFE),	// OneHot.scala:58:35, frontend.scala:300:26, :333:19, :339:19, :521:11, :569:29, :606:23, :715:18, :722:{45,68,70}, :842:34, :859:11, :861:19, :862:19, :925:34, util.scala:384:{37,54}
    .io_enq_bits_sfb_masks_1
      (~(_upper_mask_T_5[7:0]
         | {_GEN_32[1] | _GEN_27,
            _GEN_32[0],
            _GEN_31[0],
            _GEN_30[0],
            _GEN_29[0],
            _GEN_28[0],
            _GEN_27,
            1'h0}) & 8'hFC),	// OneHot.scala:58:35, frontend.scala:300:26, :333:19, :339:19, :521:11, :569:29, :606:23, :715:18, :722:{45,68,70}, :842:34, :859:11, :861:19, :862:19, :925:34, util.scala:384:{37,54}
    .io_enq_bits_sfb_masks_2
      (~(_upper_mask_T_9[7:0]
         | {_GEN_39[1] | _GEN_34,
            _GEN_39[0],
            _GEN_38[0],
            _GEN_37[0],
            _GEN_36[0],
            _GEN_35[0],
            _GEN_34,
            1'h0}) & 8'hF8),	// OneHot.scala:58:35, frontend.scala:300:26, :333:19, :339:19, :521:11, :569:29, :606:23, :715:18, :722:{45,68,70}, :842:34, :859:11, :861:19, :862:19, :925:34, util.scala:384:{37,54}
    .io_enq_bits_sfb_masks_3
      (~(_upper_mask_T_13[7:0]
         | {_GEN_45[1] | _GEN_40,
            _GEN_45[0],
            _GEN_44[0],
            _GEN_43[0],
            _GEN_42[0],
            _GEN_41[0],
            _GEN_40,
            1'h0}) & 8'hF0),	// OneHot.scala:58:35, frontend.scala:300:26, :333:19, :339:19, :521:11, :569:29, :606:23, :715:18, :722:{45,68,70}, :842:34, :859:11, :861:19, :862:19, :925:34, util.scala:384:{37,54}
    .io_enq_bits_sfb_dests_0                        (_offset_from_aligned_pc_T_4[3:0]),	// frontend.scala:709:32, :726:42
    .io_enq_bits_sfb_dests_1                        (_offset_from_aligned_pc_T_5[3:0]),	// frontend.scala:708:50, :726:42
    .io_enq_bits_sfb_dests_2                        (_offset_from_aligned_pc_T_10[3:0]),	// frontend.scala:708:50, :726:42
    .io_enq_bits_sfb_dests_3                        (_offset_from_aligned_pc_T_15[3:0]),	// frontend.scala:708:50, :726:42
    .io_enq_bits_shadowable_mask_0
      (~_s0_valid_T_11
       & ((f3_prev_is_half
             ? _bpd_decoder0_io_out_shadowable
             : _bpd_decoder1_io_out_shadowable) | ~f3_mask_0)),	// frontend.scala:589:32, :622:34, :625:34, :629:34, :634:40, :655:40, :690:39, :723:{46,75}, :724:62, :725:{65,68}
    .io_enq_bits_shadowable_mask_1
      (~_s0_valid_T_11 & (_bpd_decoder_io_out_shadowable | ~f3_mask_1)),	// frontend.scala:663:33, :690:71, :723:{46,75}, :724:62, :725:{65,68}
    .io_enq_bits_shadowable_mask_2
      (~_s0_valid_T_11 & (_bpd_decoder_1_io_out_shadowable | ~f3_mask_2)),	// frontend.scala:663:33, :690:71, :723:{46,75}, :724:62, :725:{65,68}
    .io_enq_bits_shadowable_mask_3
      (~_s0_valid_T_11 & (_bpd_decoder_2_io_out_shadowable | ~f3_mask_3)),	// frontend.scala:663:33, :690:71, :723:{46,75}, :724:62, :725:{65,68}
    .io_enq_bits_cfi_idx_valid                      (f3_fetch_bundle_cfi_idx_valid),	// frontend.scala:777:57
    .io_enq_bits_cfi_idx_bits                       (f3_fetch_bundle_cfi_idx_bits),	// Mux.scala:47:69
    .io_enq_bits_cfi_type
      (_GEN_46[f3_fetch_bundle_cfi_idx_bits]),	// Mux.scala:47:69, frontend.scala:755:33
    .io_enq_bits_cfi_is_call                        (f3_fetch_bundle_cfi_is_call),	// frontend.scala:756:33
    .io_enq_bits_cfi_is_ret                         (f3_fetch_bundle_cfi_is_ret),	// frontend.scala:757:33
    .io_enq_bits_cfi_npc_plus4                      (f3_fetch_bundle_cfi_npc_plus4),	// frontend.scala:758:33
    .io_enq_bits_ras_top                            (_ras_io_read_addr),	// frontend.scala:335:19
    .io_enq_bits_mask
      ({f3_mask_3, f3_mask_2, f3_mask_1, f3_mask_0}),	// frontend.scala:576:35, :690:{39,71}
    .io_enq_bits_br_mask                            (f3_fetch_bundle_br_mask),	// frontend.scala:577:41
    .io_enq_bits_ghist_old_history                  (_f3_io_deq_bits_ghist_old_history),	// frontend.scala:516:11
    .io_enq_bits_ghist_current_saw_branch_not_taken
      (_f3_io_deq_bits_ghist_current_saw_branch_not_taken),	// frontend.scala:516:11
    .io_enq_bits_ghist_new_saw_branch_not_taken
      (_f3_io_deq_bits_ghist_new_saw_branch_not_taken),	// frontend.scala:516:11
    .io_enq_bits_ghist_new_saw_branch_taken
      (_f3_io_deq_bits_ghist_new_saw_branch_taken),	// frontend.scala:516:11
    .io_enq_bits_ghist_ras_idx                      (_f3_io_deq_bits_ghist_ras_idx),	// frontend.scala:516:11
    .io_enq_bits_lhist_0                            (_f3_bpd_resp_io_deq_bits_lhist_0),	// frontend.scala:521:11
    .io_enq_bits_xcpt_pf_if                         (_f3_io_deq_bits_xcpt_pf_inst),	// frontend.scala:516:11
    .io_enq_bits_xcpt_ae_if                         (_f3_io_deq_bits_xcpt_ae_inst),	// frontend.scala:516:11
    .io_enq_bits_end_half_valid                     (f3_fetch_bundle_end_half_valid),	// frontend.scala:748:69
    .io_enq_bits_end_half_bits                      (_f3_io_deq_bits_data[63:48]),	// frontend.scala:516:11, :677:44
    .io_enq_bits_bpd_meta_0                         (_f3_bpd_resp_io_deq_bits_meta_0),	// frontend.scala:521:11
    .io_enq_bits_fsrc
      (_GEN_62 ? _f3_io_deq_bits_fsrc : 2'h2),	// Mux.scala:47:69, frontend.scala:482:58, :516:11, :582:24, :814:38, :821:79
    .io_enq_bits_tsrc                               (_f3_io_deq_bits_tsrc),	// frontend.scala:516:11
    .io_deq_ready
      (_fb_io_enq_ready & _ftq_io_enq_ready & ~f4_delay),	// frontend.scala:861:19, :862:19, :898:32, :910:{58,61}
    .io_enq_ready                                   (_f4_io_enq_ready),
    .io_deq_valid                                   (_f4_io_deq_valid),
    .io_deq_bits_pc                                 (_f4_io_deq_bits_pc),
    .io_deq_bits_edge_inst_0                        (_f4_io_deq_bits_edge_inst_0),
    .io_deq_bits_insts_0                            (_f4_io_deq_bits_insts_0),
    .io_deq_bits_insts_1                            (_f4_io_deq_bits_insts_1),
    .io_deq_bits_insts_2                            (_f4_io_deq_bits_insts_2),
    .io_deq_bits_insts_3                            (_f4_io_deq_bits_insts_3),
    .io_deq_bits_exp_insts_0                        (_f4_io_deq_bits_exp_insts_0),
    .io_deq_bits_exp_insts_1                        (_f4_io_deq_bits_exp_insts_1),
    .io_deq_bits_exp_insts_2                        (_f4_io_deq_bits_exp_insts_2),
    .io_deq_bits_exp_insts_3                        (_f4_io_deq_bits_exp_insts_3),
    .io_deq_bits_sfbs_0                             (_f4_io_deq_bits_sfbs_0),
    .io_deq_bits_sfbs_1                             (_f4_io_deq_bits_sfbs_1),
    .io_deq_bits_sfbs_2                             (_f4_io_deq_bits_sfbs_2),
    .io_deq_bits_sfbs_3                             (_f4_io_deq_bits_sfbs_3),
    .io_deq_bits_shadowed_mask_0                    (_f4_io_deq_bits_shadowed_mask_0),
    .io_deq_bits_shadowed_mask_1                    (_f4_io_deq_bits_shadowed_mask_1),
    .io_deq_bits_shadowed_mask_2                    (_f4_io_deq_bits_shadowed_mask_2),
    .io_deq_bits_shadowed_mask_3                    (_f4_io_deq_bits_shadowed_mask_3),
    .io_deq_bits_cfi_idx_valid                      (_f4_io_deq_bits_cfi_idx_valid),
    .io_deq_bits_cfi_idx_bits                       (_f4_io_deq_bits_cfi_idx_bits),
    .io_deq_bits_cfi_type                           (_f4_io_deq_bits_cfi_type),
    .io_deq_bits_cfi_is_call                        (_f4_io_deq_bits_cfi_is_call),
    .io_deq_bits_cfi_is_ret                         (_f4_io_deq_bits_cfi_is_ret),
    .io_deq_bits_ras_top                            (_f4_io_deq_bits_ras_top),
    .io_deq_bits_mask                               (_f4_io_deq_bits_mask),
    .io_deq_bits_br_mask                            (_f4_io_deq_bits_br_mask),
    .io_deq_bits_ghist_old_history                  (_f4_io_deq_bits_ghist_old_history),
    .io_deq_bits_ghist_current_saw_branch_not_taken
      (_f4_io_deq_bits_ghist_current_saw_branch_not_taken),
    .io_deq_bits_ghist_new_saw_branch_not_taken
      (_f4_io_deq_bits_ghist_new_saw_branch_not_taken),
    .io_deq_bits_ghist_new_saw_branch_taken
      (_f4_io_deq_bits_ghist_new_saw_branch_taken),
    .io_deq_bits_ghist_ras_idx                      (_f4_io_deq_bits_ghist_ras_idx),
    .io_deq_bits_xcpt_pf_if                         (_f4_io_deq_bits_xcpt_pf_if),
    .io_deq_bits_xcpt_ae_if                         (_f4_io_deq_bits_xcpt_ae_if),
    .io_deq_bits_bp_debug_if_oh_0                   (_f4_io_deq_bits_bp_debug_if_oh_0),
    .io_deq_bits_bp_debug_if_oh_1                   (_f4_io_deq_bits_bp_debug_if_oh_1),
    .io_deq_bits_bp_debug_if_oh_2                   (_f4_io_deq_bits_bp_debug_if_oh_2),
    .io_deq_bits_bp_debug_if_oh_3                   (_f4_io_deq_bits_bp_debug_if_oh_3),
    .io_deq_bits_bp_xcpt_if_oh_0                    (_f4_io_deq_bits_bp_xcpt_if_oh_0),
    .io_deq_bits_bp_xcpt_if_oh_1                    (_f4_io_deq_bits_bp_xcpt_if_oh_1),
    .io_deq_bits_bp_xcpt_if_oh_2                    (_f4_io_deq_bits_bp_xcpt_if_oh_2),
    .io_deq_bits_bp_xcpt_if_oh_3                    (_f4_io_deq_bits_bp_xcpt_if_oh_3),
    .io_deq_bits_bpd_meta_0                         (_f4_io_deq_bits_bpd_meta_0),
    .io_deq_bits_fsrc                               (_f4_io_deq_bits_fsrc)
  );
  FetchBuffer_2 fb (	// frontend.scala:861:19
    .clock                                  (clock),
    .reset                                  (reset),
    .io_enq_valid
      (_f4_io_deq_valid & _ftq_io_enq_ready & ~f4_delay),	// frontend.scala:859:11, :862:19, :898:32, :910:61, :912:58
    .io_enq_bits_pc                         (_f4_io_deq_bits_pc),	// frontend.scala:859:11
    .io_enq_bits_edge_inst_0                (_f4_io_deq_bits_edge_inst_0),	// frontend.scala:859:11
    .io_enq_bits_insts_0                    (_f4_io_deq_bits_insts_0),	// frontend.scala:859:11
    .io_enq_bits_insts_1                    (_f4_io_deq_bits_insts_1),	// frontend.scala:859:11
    .io_enq_bits_insts_2                    (_f4_io_deq_bits_insts_2),	// frontend.scala:859:11
    .io_enq_bits_insts_3                    (_f4_io_deq_bits_insts_3),	// frontend.scala:859:11
    .io_enq_bits_exp_insts_0                (_f4_io_deq_bits_exp_insts_0),	// frontend.scala:859:11
    .io_enq_bits_exp_insts_1                (_f4_io_deq_bits_exp_insts_1),	// frontend.scala:859:11
    .io_enq_bits_exp_insts_2                (_f4_io_deq_bits_exp_insts_2),	// frontend.scala:859:11
    .io_enq_bits_exp_insts_3                (_f4_io_deq_bits_exp_insts_3),	// frontend.scala:859:11
    .io_enq_bits_shadowed_mask_0            (_f4_io_deq_bits_shadowed_mask_0),	// frontend.scala:859:11
    .io_enq_bits_shadowed_mask_1            (_f4_io_deq_bits_shadowed_mask_1),	// frontend.scala:859:11
    .io_enq_bits_shadowed_mask_2            (_f4_io_deq_bits_shadowed_mask_2),	// frontend.scala:859:11
    .io_enq_bits_shadowed_mask_3            (_f4_io_deq_bits_shadowed_mask_3),	// frontend.scala:859:11
    .io_enq_bits_cfi_idx_valid              (_f4_io_deq_bits_cfi_idx_valid),	// frontend.scala:859:11
    .io_enq_bits_cfi_idx_bits               (_f4_io_deq_bits_cfi_idx_bits),	// frontend.scala:859:11
    .io_enq_bits_ftq_idx                    (_ftq_io_enq_idx),	// frontend.scala:862:19
    .io_enq_bits_mask                       (_f4_io_deq_bits_mask),	// frontend.scala:859:11
    .io_enq_bits_xcpt_pf_if                 (_f4_io_deq_bits_xcpt_pf_if),	// frontend.scala:859:11
    .io_enq_bits_xcpt_ae_if                 (_f4_io_deq_bits_xcpt_ae_if),	// frontend.scala:859:11
    .io_enq_bits_bp_debug_if_oh_0           (_f4_io_deq_bits_bp_debug_if_oh_0),	// frontend.scala:859:11
    .io_enq_bits_bp_debug_if_oh_1           (_f4_io_deq_bits_bp_debug_if_oh_1),	// frontend.scala:859:11
    .io_enq_bits_bp_debug_if_oh_2           (_f4_io_deq_bits_bp_debug_if_oh_2),	// frontend.scala:859:11
    .io_enq_bits_bp_debug_if_oh_3           (_f4_io_deq_bits_bp_debug_if_oh_3),	// frontend.scala:859:11
    .io_enq_bits_bp_xcpt_if_oh_0            (_f4_io_deq_bits_bp_xcpt_if_oh_0),	// frontend.scala:859:11
    .io_enq_bits_bp_xcpt_if_oh_1            (_f4_io_deq_bits_bp_xcpt_if_oh_1),	// frontend.scala:859:11
    .io_enq_bits_bp_xcpt_if_oh_2            (_f4_io_deq_bits_bp_xcpt_if_oh_2),	// frontend.scala:859:11
    .io_enq_bits_bp_xcpt_if_oh_3            (_f4_io_deq_bits_bp_xcpt_if_oh_3),	// frontend.scala:859:11
    .io_enq_bits_fsrc                       (_f4_io_deq_bits_fsrc),	// frontend.scala:859:11
    .io_deq_ready                           (io_cpu_fetchpacket_ready),
    .io_clear                               (f4_clear),	// frontend.scala:953:30, :954:17, :965:38
    .io_enq_ready                           (_fb_io_enq_ready),
    .io_deq_valid                           (io_cpu_fetchpacket_valid),
    .io_deq_bits_uops_0_valid               (io_cpu_fetchpacket_bits_uops_0_valid),
    .io_deq_bits_uops_0_bits_inst           (io_cpu_fetchpacket_bits_uops_0_bits_inst),
    .io_deq_bits_uops_0_bits_debug_inst
      (io_cpu_fetchpacket_bits_uops_0_bits_debug_inst),
    .io_deq_bits_uops_0_bits_is_rvc         (io_cpu_fetchpacket_bits_uops_0_bits_is_rvc),
    .io_deq_bits_uops_0_bits_debug_pc
      (io_cpu_fetchpacket_bits_uops_0_bits_debug_pc),
    .io_deq_bits_uops_0_bits_ctrl_br_type
      (io_cpu_fetchpacket_bits_uops_0_bits_ctrl_br_type),
    .io_deq_bits_uops_0_bits_ctrl_op1_sel
      (io_cpu_fetchpacket_bits_uops_0_bits_ctrl_op1_sel),
    .io_deq_bits_uops_0_bits_ctrl_op2_sel
      (io_cpu_fetchpacket_bits_uops_0_bits_ctrl_op2_sel),
    .io_deq_bits_uops_0_bits_ctrl_imm_sel
      (io_cpu_fetchpacket_bits_uops_0_bits_ctrl_imm_sel),
    .io_deq_bits_uops_0_bits_ctrl_op_fcn
      (io_cpu_fetchpacket_bits_uops_0_bits_ctrl_op_fcn),
    .io_deq_bits_uops_0_bits_ctrl_fcn_dw
      (io_cpu_fetchpacket_bits_uops_0_bits_ctrl_fcn_dw),
    .io_deq_bits_uops_0_bits_ctrl_csr_cmd
      (io_cpu_fetchpacket_bits_uops_0_bits_ctrl_csr_cmd),
    .io_deq_bits_uops_0_bits_ctrl_is_load
      (io_cpu_fetchpacket_bits_uops_0_bits_ctrl_is_load),
    .io_deq_bits_uops_0_bits_ctrl_is_sta
      (io_cpu_fetchpacket_bits_uops_0_bits_ctrl_is_sta),
    .io_deq_bits_uops_0_bits_ctrl_is_std
      (io_cpu_fetchpacket_bits_uops_0_bits_ctrl_is_std),
    .io_deq_bits_uops_0_bits_iw_state
      (io_cpu_fetchpacket_bits_uops_0_bits_iw_state),
    .io_deq_bits_uops_0_bits_iw_p1_poisoned
      (io_cpu_fetchpacket_bits_uops_0_bits_iw_p1_poisoned),
    .io_deq_bits_uops_0_bits_iw_p2_poisoned
      (io_cpu_fetchpacket_bits_uops_0_bits_iw_p2_poisoned),
    .io_deq_bits_uops_0_bits_is_sfb         (io_cpu_fetchpacket_bits_uops_0_bits_is_sfb),
    .io_deq_bits_uops_0_bits_ftq_idx        (io_cpu_fetchpacket_bits_uops_0_bits_ftq_idx),
    .io_deq_bits_uops_0_bits_edge_inst
      (io_cpu_fetchpacket_bits_uops_0_bits_edge_inst),
    .io_deq_bits_uops_0_bits_pc_lob         (io_cpu_fetchpacket_bits_uops_0_bits_pc_lob),
    .io_deq_bits_uops_0_bits_taken          (io_cpu_fetchpacket_bits_uops_0_bits_taken),
    .io_deq_bits_uops_0_bits_csr_addr
      (io_cpu_fetchpacket_bits_uops_0_bits_csr_addr),
    .io_deq_bits_uops_0_bits_rxq_idx        (io_cpu_fetchpacket_bits_uops_0_bits_rxq_idx),
    .io_deq_bits_uops_0_bits_xcpt_pf_if
      (io_cpu_fetchpacket_bits_uops_0_bits_xcpt_pf_if),
    .io_deq_bits_uops_0_bits_xcpt_ae_if
      (io_cpu_fetchpacket_bits_uops_0_bits_xcpt_ae_if),
    .io_deq_bits_uops_0_bits_xcpt_ma_if
      (io_cpu_fetchpacket_bits_uops_0_bits_xcpt_ma_if),
    .io_deq_bits_uops_0_bits_bp_debug_if
      (io_cpu_fetchpacket_bits_uops_0_bits_bp_debug_if),
    .io_deq_bits_uops_0_bits_bp_xcpt_if
      (io_cpu_fetchpacket_bits_uops_0_bits_bp_xcpt_if),
    .io_deq_bits_uops_0_bits_debug_fsrc
      (io_cpu_fetchpacket_bits_uops_0_bits_debug_fsrc),
    .io_deq_bits_uops_0_bits_debug_tsrc
      (io_cpu_fetchpacket_bits_uops_0_bits_debug_tsrc),
    .io_deq_bits_uops_1_valid               (io_cpu_fetchpacket_bits_uops_1_valid),
    .io_deq_bits_uops_1_bits_inst           (io_cpu_fetchpacket_bits_uops_1_bits_inst),
    .io_deq_bits_uops_1_bits_debug_inst
      (io_cpu_fetchpacket_bits_uops_1_bits_debug_inst),
    .io_deq_bits_uops_1_bits_is_rvc         (io_cpu_fetchpacket_bits_uops_1_bits_is_rvc),
    .io_deq_bits_uops_1_bits_debug_pc
      (io_cpu_fetchpacket_bits_uops_1_bits_debug_pc),
    .io_deq_bits_uops_1_bits_ctrl_br_type
      (io_cpu_fetchpacket_bits_uops_1_bits_ctrl_br_type),
    .io_deq_bits_uops_1_bits_ctrl_op1_sel
      (io_cpu_fetchpacket_bits_uops_1_bits_ctrl_op1_sel),
    .io_deq_bits_uops_1_bits_ctrl_op2_sel
      (io_cpu_fetchpacket_bits_uops_1_bits_ctrl_op2_sel),
    .io_deq_bits_uops_1_bits_ctrl_imm_sel
      (io_cpu_fetchpacket_bits_uops_1_bits_ctrl_imm_sel),
    .io_deq_bits_uops_1_bits_ctrl_op_fcn
      (io_cpu_fetchpacket_bits_uops_1_bits_ctrl_op_fcn),
    .io_deq_bits_uops_1_bits_ctrl_fcn_dw
      (io_cpu_fetchpacket_bits_uops_1_bits_ctrl_fcn_dw),
    .io_deq_bits_uops_1_bits_ctrl_csr_cmd
      (io_cpu_fetchpacket_bits_uops_1_bits_ctrl_csr_cmd),
    .io_deq_bits_uops_1_bits_ctrl_is_load
      (io_cpu_fetchpacket_bits_uops_1_bits_ctrl_is_load),
    .io_deq_bits_uops_1_bits_ctrl_is_sta
      (io_cpu_fetchpacket_bits_uops_1_bits_ctrl_is_sta),
    .io_deq_bits_uops_1_bits_ctrl_is_std
      (io_cpu_fetchpacket_bits_uops_1_bits_ctrl_is_std),
    .io_deq_bits_uops_1_bits_iw_state
      (io_cpu_fetchpacket_bits_uops_1_bits_iw_state),
    .io_deq_bits_uops_1_bits_iw_p1_poisoned
      (io_cpu_fetchpacket_bits_uops_1_bits_iw_p1_poisoned),
    .io_deq_bits_uops_1_bits_iw_p2_poisoned
      (io_cpu_fetchpacket_bits_uops_1_bits_iw_p2_poisoned),
    .io_deq_bits_uops_1_bits_is_sfb         (io_cpu_fetchpacket_bits_uops_1_bits_is_sfb),
    .io_deq_bits_uops_1_bits_ftq_idx        (io_cpu_fetchpacket_bits_uops_1_bits_ftq_idx),
    .io_deq_bits_uops_1_bits_edge_inst
      (io_cpu_fetchpacket_bits_uops_1_bits_edge_inst),
    .io_deq_bits_uops_1_bits_pc_lob         (io_cpu_fetchpacket_bits_uops_1_bits_pc_lob),
    .io_deq_bits_uops_1_bits_taken          (io_cpu_fetchpacket_bits_uops_1_bits_taken),
    .io_deq_bits_uops_1_bits_csr_addr
      (io_cpu_fetchpacket_bits_uops_1_bits_csr_addr),
    .io_deq_bits_uops_1_bits_rxq_idx        (io_cpu_fetchpacket_bits_uops_1_bits_rxq_idx),
    .io_deq_bits_uops_1_bits_xcpt_pf_if
      (io_cpu_fetchpacket_bits_uops_1_bits_xcpt_pf_if),
    .io_deq_bits_uops_1_bits_xcpt_ae_if
      (io_cpu_fetchpacket_bits_uops_1_bits_xcpt_ae_if),
    .io_deq_bits_uops_1_bits_xcpt_ma_if
      (io_cpu_fetchpacket_bits_uops_1_bits_xcpt_ma_if),
    .io_deq_bits_uops_1_bits_bp_debug_if
      (io_cpu_fetchpacket_bits_uops_1_bits_bp_debug_if),
    .io_deq_bits_uops_1_bits_bp_xcpt_if
      (io_cpu_fetchpacket_bits_uops_1_bits_bp_xcpt_if),
    .io_deq_bits_uops_1_bits_debug_fsrc
      (io_cpu_fetchpacket_bits_uops_1_bits_debug_fsrc),
    .io_deq_bits_uops_1_bits_debug_tsrc
      (io_cpu_fetchpacket_bits_uops_1_bits_debug_tsrc)
  );
  FetchTargetQueue_2 ftq (	// frontend.scala:862:19
    .clock                                              (clock),
    .reset                                              (reset),
    .io_enq_valid
      (_f4_io_deq_valid & _fb_io_enq_ready & ~f4_delay),	// frontend.scala:859:11, :861:19, :898:32, :910:61, :922:67
    .io_enq_bits_pc                                     (_f4_io_deq_bits_pc),	// frontend.scala:859:11
    .io_enq_bits_cfi_idx_valid                          (_f4_io_deq_bits_cfi_idx_valid),	// frontend.scala:859:11
    .io_enq_bits_cfi_idx_bits                           (_f4_io_deq_bits_cfi_idx_bits),	// frontend.scala:859:11
    .io_enq_bits_cfi_type                               (_f4_io_deq_bits_cfi_type),	// frontend.scala:859:11
    .io_enq_bits_cfi_is_call                            (_f4_io_deq_bits_cfi_is_call),	// frontend.scala:859:11
    .io_enq_bits_cfi_is_ret                             (_f4_io_deq_bits_cfi_is_ret),	// frontend.scala:859:11
    .io_enq_bits_ras_top                                (_f4_io_deq_bits_ras_top),	// frontend.scala:859:11
    .io_enq_bits_mask                                   (_f4_io_deq_bits_mask),	// frontend.scala:859:11
    .io_enq_bits_br_mask                                (_f4_io_deq_bits_br_mask),	// frontend.scala:859:11
    .io_enq_bits_ghist_old_history
      (_f4_io_deq_bits_ghist_old_history),	// frontend.scala:859:11
    .io_enq_bits_ghist_current_saw_branch_not_taken
      (_f4_io_deq_bits_ghist_current_saw_branch_not_taken),	// frontend.scala:859:11
    .io_enq_bits_ghist_new_saw_branch_not_taken
      (_f4_io_deq_bits_ghist_new_saw_branch_not_taken),	// frontend.scala:859:11
    .io_enq_bits_ghist_new_saw_branch_taken
      (_f4_io_deq_bits_ghist_new_saw_branch_taken),	// frontend.scala:859:11
    .io_enq_bits_ghist_ras_idx                          (_f4_io_deq_bits_ghist_ras_idx),	// frontend.scala:859:11
    .io_enq_bits_bpd_meta_0                             (_f4_io_deq_bits_bpd_meta_0),	// frontend.scala:859:11
    .io_deq_valid                                       (io_cpu_commit_valid),
    .io_deq_bits                                        (io_cpu_commit_bits[4:0]),	// frontend.scala:946:14
    .io_get_ftq_pc_0_ftq_idx                            (io_cpu_get_pc_0_ftq_idx),
    .io_get_ftq_pc_1_ftq_idx                            (io_cpu_get_pc_1_ftq_idx),
    .io_redirect_valid                                  (io_cpu_redirect_val),
    .io_redirect_bits                                   (io_cpu_redirect_ftq_idx),
    .io_brupdate_b2_uop_ftq_idx                         (io_cpu_brupdate_b2_uop_ftq_idx),
    .io_brupdate_b2_uop_pc_lob                          (io_cpu_brupdate_b2_uop_pc_lob),
    .io_brupdate_b2_mispredict                          (io_cpu_brupdate_b2_mispredict),
    .io_brupdate_b2_taken                               (io_cpu_brupdate_b2_taken),
    .io_enq_ready                                       (_ftq_io_enq_ready),
    .io_enq_idx                                         (_ftq_io_enq_idx),
    .io_get_ftq_pc_0_entry_cfi_idx_valid
      (io_cpu_get_pc_0_entry_cfi_idx_valid),
    .io_get_ftq_pc_0_entry_cfi_idx_bits
      (io_cpu_get_pc_0_entry_cfi_idx_bits),
    .io_get_ftq_pc_0_entry_ras_idx                      (io_cpu_get_pc_0_entry_ras_idx),
    .io_get_ftq_pc_0_entry_start_bank
      (io_cpu_get_pc_0_entry_start_bank),
    .io_get_ftq_pc_0_pc                                 (io_cpu_get_pc_0_pc),
    .io_get_ftq_pc_0_com_pc                             (io_cpu_get_pc_0_com_pc),
    .io_get_ftq_pc_0_next_val                           (io_cpu_get_pc_0_next_val),
    .io_get_ftq_pc_0_next_pc                            (io_cpu_get_pc_0_next_pc),
    .io_get_ftq_pc_1_entry_cfi_idx_bits
      (io_cpu_get_pc_1_entry_cfi_idx_bits),
    .io_get_ftq_pc_1_entry_br_mask                      (io_cpu_get_pc_1_entry_br_mask),
    .io_get_ftq_pc_1_entry_cfi_is_call
      (io_cpu_get_pc_1_entry_cfi_is_call),
    .io_get_ftq_pc_1_entry_cfi_is_ret
      (io_cpu_get_pc_1_entry_cfi_is_ret),
    .io_get_ftq_pc_1_entry_start_bank
      (io_cpu_get_pc_1_entry_start_bank),
    .io_get_ftq_pc_1_ghist_old_history
      (io_cpu_get_pc_1_ghist_old_history),
    .io_get_ftq_pc_1_ghist_current_saw_branch_not_taken
      (io_cpu_get_pc_1_ghist_current_saw_branch_not_taken),
    .io_get_ftq_pc_1_ghist_new_saw_branch_not_taken
      (io_cpu_get_pc_1_ghist_new_saw_branch_not_taken),
    .io_get_ftq_pc_1_ghist_new_saw_branch_taken
      (io_cpu_get_pc_1_ghist_new_saw_branch_taken),
    .io_get_ftq_pc_1_ghist_ras_idx                      (io_cpu_get_pc_1_ghist_ras_idx),
    .io_get_ftq_pc_1_pc                                 (io_cpu_get_pc_1_pc),
    .io_bpdupdate_valid                                 (_ftq_io_bpdupdate_valid),
    .io_bpdupdate_bits_is_mispredict_update
      (_ftq_io_bpdupdate_bits_is_mispredict_update),
    .io_bpdupdate_bits_is_repair_update
      (_ftq_io_bpdupdate_bits_is_repair_update),
    .io_bpdupdate_bits_pc                               (_ftq_io_bpdupdate_bits_pc),
    .io_bpdupdate_bits_br_mask                          (_ftq_io_bpdupdate_bits_br_mask),
    .io_bpdupdate_bits_cfi_idx_valid
      (_ftq_io_bpdupdate_bits_cfi_idx_valid),
    .io_bpdupdate_bits_cfi_idx_bits
      (_ftq_io_bpdupdate_bits_cfi_idx_bits),
    .io_bpdupdate_bits_cfi_taken
      (_ftq_io_bpdupdate_bits_cfi_taken),
    .io_bpdupdate_bits_cfi_mispredicted
      (_ftq_io_bpdupdate_bits_cfi_mispredicted),
    .io_bpdupdate_bits_cfi_is_br
      (_ftq_io_bpdupdate_bits_cfi_is_br),
    .io_bpdupdate_bits_cfi_is_jal
      (_ftq_io_bpdupdate_bits_cfi_is_jal),
    .io_bpdupdate_bits_ghist_old_history
      (_ftq_io_bpdupdate_bits_ghist_old_history),
    .io_bpdupdate_bits_target                           (_ftq_io_bpdupdate_bits_target),
    .io_bpdupdate_bits_meta_0                           (_ftq_io_bpdupdate_bits_meta_0),
    .io_ras_update                                      (_ftq_io_ras_update),
    .io_ras_update_idx                                  (_ftq_io_ras_update_idx),
    .io_ras_update_pc                                   (_ftq_io_ras_update_pc)
  );
  Arbiter_60 bpd_update_arbiter (	// frontend.scala:925:34
    .io_in_0_valid                     (_ftq_io_bpdupdate_valid),	// frontend.scala:862:19
    .io_in_0_bits_is_mispredict_update (_ftq_io_bpdupdate_bits_is_mispredict_update),	// frontend.scala:862:19
    .io_in_0_bits_is_repair_update     (_ftq_io_bpdupdate_bits_is_repair_update),	// frontend.scala:862:19
    .io_in_0_bits_pc                   (_ftq_io_bpdupdate_bits_pc),	// frontend.scala:862:19
    .io_in_0_bits_br_mask              (_ftq_io_bpdupdate_bits_br_mask),	// frontend.scala:862:19
    .io_in_0_bits_cfi_idx_valid        (_ftq_io_bpdupdate_bits_cfi_idx_valid),	// frontend.scala:862:19
    .io_in_0_bits_cfi_idx_bits         (_ftq_io_bpdupdate_bits_cfi_idx_bits),	// frontend.scala:862:19
    .io_in_0_bits_cfi_taken            (_ftq_io_bpdupdate_bits_cfi_taken),	// frontend.scala:862:19
    .io_in_0_bits_cfi_mispredicted     (_ftq_io_bpdupdate_bits_cfi_mispredicted),	// frontend.scala:862:19
    .io_in_0_bits_cfi_is_br            (_ftq_io_bpdupdate_bits_cfi_is_br),	// frontend.scala:862:19
    .io_in_0_bits_cfi_is_jal           (_ftq_io_bpdupdate_bits_cfi_is_jal),	// frontend.scala:862:19
    .io_in_0_bits_ghist_old_history    (_ftq_io_bpdupdate_bits_ghist_old_history),	// frontend.scala:862:19
    .io_in_0_bits_target               (_ftq_io_bpdupdate_bits_target),	// frontend.scala:862:19
    .io_in_0_bits_meta_0               (_ftq_io_bpdupdate_bits_meta_0),	// frontend.scala:862:19
    .io_in_1_valid                     (_f4_btb_corrections_io_deq_valid),	// frontend.scala:842:34
    .io_in_1_bits_is_mispredict_update
      (_f4_btb_corrections_io_deq_bits_is_mispredict_update),	// frontend.scala:842:34
    .io_in_1_bits_is_repair_update     (_f4_btb_corrections_io_deq_bits_is_repair_update),	// frontend.scala:842:34
    .io_in_1_bits_btb_mispredicts      (_f4_btb_corrections_io_deq_bits_btb_mispredicts),	// frontend.scala:842:34
    .io_in_1_bits_pc                   (_f4_btb_corrections_io_deq_bits_pc),	// frontend.scala:842:34
    .io_in_1_bits_br_mask              (_f4_btb_corrections_io_deq_bits_br_mask),	// frontend.scala:842:34
    .io_in_1_bits_cfi_idx_valid        (_f4_btb_corrections_io_deq_bits_cfi_idx_valid),	// frontend.scala:842:34
    .io_in_1_bits_cfi_idx_bits         (_f4_btb_corrections_io_deq_bits_cfi_idx_bits),	// frontend.scala:842:34
    .io_in_1_bits_cfi_taken            (_f4_btb_corrections_io_deq_bits_cfi_taken),	// frontend.scala:842:34
    .io_in_1_bits_cfi_mispredicted     (_f4_btb_corrections_io_deq_bits_cfi_mispredicted),	// frontend.scala:842:34
    .io_in_1_bits_cfi_is_br            (_f4_btb_corrections_io_deq_bits_cfi_is_br),	// frontend.scala:842:34
    .io_in_1_bits_cfi_is_jal           (_f4_btb_corrections_io_deq_bits_cfi_is_jal),	// frontend.scala:842:34
    .io_in_1_bits_ghist_old_history
      (_f4_btb_corrections_io_deq_bits_ghist_old_history),	// frontend.scala:842:34
    .io_in_1_bits_target               (_f4_btb_corrections_io_deq_bits_target),	// frontend.scala:842:34
    .io_in_1_bits_meta_0               (_f4_btb_corrections_io_deq_bits_meta_0),	// frontend.scala:842:34
    .io_in_1_ready                     (_bpd_update_arbiter_io_in_1_ready),
    .io_out_valid                      (_bpd_update_arbiter_io_out_valid),
    .io_out_bits_is_mispredict_update
      (_bpd_update_arbiter_io_out_bits_is_mispredict_update),
    .io_out_bits_is_repair_update      (_bpd_update_arbiter_io_out_bits_is_repair_update),
    .io_out_bits_btb_mispredicts       (_bpd_update_arbiter_io_out_bits_btb_mispredicts),
    .io_out_bits_pc                    (_bpd_update_arbiter_io_out_bits_pc),
    .io_out_bits_br_mask               (_bpd_update_arbiter_io_out_bits_br_mask),
    .io_out_bits_cfi_idx_valid         (_bpd_update_arbiter_io_out_bits_cfi_idx_valid),
    .io_out_bits_cfi_idx_bits          (_bpd_update_arbiter_io_out_bits_cfi_idx_bits),
    .io_out_bits_cfi_taken             (_bpd_update_arbiter_io_out_bits_cfi_taken),
    .io_out_bits_cfi_mispredicted      (_bpd_update_arbiter_io_out_bits_cfi_mispredicted),
    .io_out_bits_cfi_is_br             (_bpd_update_arbiter_io_out_bits_cfi_is_br),
    .io_out_bits_cfi_is_jal            (_bpd_update_arbiter_io_out_bits_cfi_is_jal),
    .io_out_bits_ghist_old_history
      (_bpd_update_arbiter_io_out_bits_ghist_old_history),
    .io_out_bits_target                (_bpd_update_arbiter_io_out_bits_target),
    .io_out_bits_meta_0                (_bpd_update_arbiter_io_out_bits_meta_0)
  );
  assign io_cpu_perf_tlbMiss = io_ptw_req_ready & _tlb_io_ptw_req_valid;	// Decoupled.scala:40:37, frontend.scala:339:19
  assign io_ptw_req_valid = _tlb_io_ptw_req_valid;	// frontend.scala:339:19
endmodule

