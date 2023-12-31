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

module BoomMSHR_12(
  input         clock,
                reset,
                io_id,
                io_req_pri_val,
                io_req_sec_val,
                io_clear_prefetch,
  input  [11:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  input         io_exception,
  input  [6:0]  io_req_uop_uopc,
  input  [31:0] io_req_uop_inst,
                io_req_uop_debug_inst,
  input         io_req_uop_is_rvc,
  input  [39:0] io_req_uop_debug_pc,
  input  [2:0]  io_req_uop_iq_type,
  input  [9:0]  io_req_uop_fu_code,
  input  [3:0]  io_req_uop_ctrl_br_type,
  input  [1:0]  io_req_uop_ctrl_op1_sel,
  input  [2:0]  io_req_uop_ctrl_op2_sel,
                io_req_uop_ctrl_imm_sel,
  input  [3:0]  io_req_uop_ctrl_op_fcn,
  input         io_req_uop_ctrl_fcn_dw,
  input  [2:0]  io_req_uop_ctrl_csr_cmd,
  input         io_req_uop_ctrl_is_load,
                io_req_uop_ctrl_is_sta,
                io_req_uop_ctrl_is_std,
  input  [1:0]  io_req_uop_iw_state,
  input         io_req_uop_iw_p1_poisoned,
                io_req_uop_iw_p2_poisoned,
                io_req_uop_is_br,
                io_req_uop_is_jalr,
                io_req_uop_is_jal,
                io_req_uop_is_sfb,
  input  [11:0] io_req_uop_br_mask,
  input  [3:0]  io_req_uop_br_tag,
  input  [4:0]  io_req_uop_ftq_idx,
  input         io_req_uop_edge_inst,
  input  [5:0]  io_req_uop_pc_lob,
  input         io_req_uop_taken,
  input  [19:0] io_req_uop_imm_packed,
  input  [11:0] io_req_uop_csr_addr,
  input  [5:0]  io_req_uop_rob_idx,
  input  [3:0]  io_req_uop_ldq_idx,
                io_req_uop_stq_idx,
  input  [1:0]  io_req_uop_rxq_idx,
  input  [6:0]  io_req_uop_pdst,
                io_req_uop_prs1,
                io_req_uop_prs2,
                io_req_uop_prs3,
  input  [4:0]  io_req_uop_ppred,
  input         io_req_uop_prs1_busy,
                io_req_uop_prs2_busy,
                io_req_uop_prs3_busy,
                io_req_uop_ppred_busy,
  input  [6:0]  io_req_uop_stale_pdst,
  input         io_req_uop_exception,
  input  [63:0] io_req_uop_exc_cause,
  input         io_req_uop_bypassable,
  input  [4:0]  io_req_uop_mem_cmd,
  input  [1:0]  io_req_uop_mem_size,
  input         io_req_uop_mem_signed,
                io_req_uop_is_fence,
                io_req_uop_is_fencei,
                io_req_uop_is_amo,
                io_req_uop_uses_ldq,
                io_req_uop_uses_stq,
                io_req_uop_is_sys_pc2epc,
                io_req_uop_is_unique,
                io_req_uop_flush_on_commit,
                io_req_uop_ldst_is_rs1,
  input  [5:0]  io_req_uop_ldst,
                io_req_uop_lrs1,
                io_req_uop_lrs2,
                io_req_uop_lrs3,
  input         io_req_uop_ldst_val,
  input  [1:0]  io_req_uop_dst_rtype,
                io_req_uop_lrs1_rtype,
                io_req_uop_lrs2_rtype,
  input         io_req_uop_frs3_en,
                io_req_uop_fp_val,
                io_req_uop_fp_single,
                io_req_uop_xcpt_pf_if,
                io_req_uop_xcpt_ae_if,
                io_req_uop_xcpt_ma_if,
                io_req_uop_bp_debug_if,
                io_req_uop_bp_xcpt_if,
  input  [1:0]  io_req_uop_debug_fsrc,
                io_req_uop_debug_tsrc,
  input  [39:0] io_req_addr,
  input  [63:0] io_req_data,
  input         io_req_is_hella,
                io_req_tag_match,
  input  [1:0]  io_req_old_meta_coh_state,
  input  [19:0] io_req_old_meta_tag,
  input  [3:0]  io_req_way_en,
  input  [4:0]  io_req_sdq_id,
  input         io_req_is_probe,
                io_mem_acquire_ready,
                io_mem_grant_valid,
  input  [2:0]  io_mem_grant_bits_opcode,
  input  [1:0]  io_mem_grant_bits_param,
  input  [3:0]  io_mem_grant_bits_size,
  input  [2:0]  io_mem_grant_bits_sink,
  input         io_mem_finish_ready,
                io_prober_state_valid,
  input  [39:0] io_prober_state_bits,
  input         io_refill_ready,
                io_meta_write_ready,
                io_meta_read_ready,
                io_meta_resp_valid,
  input  [1:0]  io_meta_resp_bits_coh_state,
  input         io_wb_req_ready,
                io_lb_read_ready,
  input  [63:0] io_lb_resp,
  input         io_lb_write_ready,
                io_replay_ready,
                io_resp_ready,
                io_wb_resp,
  output        io_req_pri_rdy,
                io_req_sec_rdy,
                io_idx_valid,
  output [5:0]  io_idx_bits,
  output        io_way_valid,
  output [3:0]  io_way_bits,
  output        io_tag_valid,
  output [27:0] io_tag_bits,
  output        io_mem_acquire_valid,
  output [2:0]  io_mem_acquire_bits_param,
  output [1:0]  io_mem_acquire_bits_source,
  output [31:0] io_mem_acquire_bits_address,
  output        io_mem_grant_ready,
                io_mem_finish_valid,
  output [2:0]  io_mem_finish_bits_sink,
  output        io_refill_valid,
  output [3:0]  io_refill_bits_way_en,
  output [11:0] io_refill_bits_addr,
  output        io_meta_write_valid,
  output [5:0]  io_meta_write_bits_idx,
  output [3:0]  io_meta_write_bits_way_en,
  output [1:0]  io_meta_write_bits_data_coh_state,
  output [19:0] io_meta_write_bits_data_tag,
  output        io_meta_read_valid,
  output [5:0]  io_meta_read_bits_idx,
  output [3:0]  io_meta_read_bits_way_en,
  output [19:0] io_meta_read_bits_tag,
  output        io_wb_req_valid,
  output [19:0] io_wb_req_bits_tag,
  output [5:0]  io_wb_req_bits_idx,
  output [2:0]  io_wb_req_bits_param,
  output [3:0]  io_wb_req_bits_way_en,
  output        io_lb_read_valid,
  output [2:0]  io_lb_read_bits_offset,
  output        io_lb_write_valid,
  output [2:0]  io_lb_write_bits_offset,
  output        io_replay_valid,
  output [6:0]  io_replay_bits_uop_uopc,
  output [31:0] io_replay_bits_uop_inst,
                io_replay_bits_uop_debug_inst,
  output        io_replay_bits_uop_is_rvc,
  output [39:0] io_replay_bits_uop_debug_pc,
  output [2:0]  io_replay_bits_uop_iq_type,
  output [9:0]  io_replay_bits_uop_fu_code,
  output [3:0]  io_replay_bits_uop_ctrl_br_type,
  output [1:0]  io_replay_bits_uop_ctrl_op1_sel,
  output [2:0]  io_replay_bits_uop_ctrl_op2_sel,
                io_replay_bits_uop_ctrl_imm_sel,
  output [3:0]  io_replay_bits_uop_ctrl_op_fcn,
  output        io_replay_bits_uop_ctrl_fcn_dw,
  output [2:0]  io_replay_bits_uop_ctrl_csr_cmd,
  output        io_replay_bits_uop_ctrl_is_load,
                io_replay_bits_uop_ctrl_is_sta,
                io_replay_bits_uop_ctrl_is_std,
  output [1:0]  io_replay_bits_uop_iw_state,
  output        io_replay_bits_uop_iw_p1_poisoned,
                io_replay_bits_uop_iw_p2_poisoned,
                io_replay_bits_uop_is_br,
                io_replay_bits_uop_is_jalr,
                io_replay_bits_uop_is_jal,
                io_replay_bits_uop_is_sfb,
  output [11:0] io_replay_bits_uop_br_mask,
  output [3:0]  io_replay_bits_uop_br_tag,
  output [4:0]  io_replay_bits_uop_ftq_idx,
  output        io_replay_bits_uop_edge_inst,
  output [5:0]  io_replay_bits_uop_pc_lob,
  output        io_replay_bits_uop_taken,
  output [19:0] io_replay_bits_uop_imm_packed,
  output [11:0] io_replay_bits_uop_csr_addr,
  output [5:0]  io_replay_bits_uop_rob_idx,
  output [3:0]  io_replay_bits_uop_ldq_idx,
                io_replay_bits_uop_stq_idx,
  output [1:0]  io_replay_bits_uop_rxq_idx,
  output [6:0]  io_replay_bits_uop_pdst,
                io_replay_bits_uop_prs1,
                io_replay_bits_uop_prs2,
                io_replay_bits_uop_prs3,
  output [4:0]  io_replay_bits_uop_ppred,
  output        io_replay_bits_uop_prs1_busy,
                io_replay_bits_uop_prs2_busy,
                io_replay_bits_uop_prs3_busy,
                io_replay_bits_uop_ppred_busy,
  output [6:0]  io_replay_bits_uop_stale_pdst,
  output        io_replay_bits_uop_exception,
  output [63:0] io_replay_bits_uop_exc_cause,
  output        io_replay_bits_uop_bypassable,
  output [4:0]  io_replay_bits_uop_mem_cmd,
  output [1:0]  io_replay_bits_uop_mem_size,
  output        io_replay_bits_uop_mem_signed,
                io_replay_bits_uop_is_fence,
                io_replay_bits_uop_is_fencei,
                io_replay_bits_uop_is_amo,
                io_replay_bits_uop_uses_ldq,
                io_replay_bits_uop_uses_stq,
                io_replay_bits_uop_is_sys_pc2epc,
                io_replay_bits_uop_is_unique,
                io_replay_bits_uop_flush_on_commit,
                io_replay_bits_uop_ldst_is_rs1,
  output [5:0]  io_replay_bits_uop_ldst,
                io_replay_bits_uop_lrs1,
                io_replay_bits_uop_lrs2,
                io_replay_bits_uop_lrs3,
  output        io_replay_bits_uop_ldst_val,
  output [1:0]  io_replay_bits_uop_dst_rtype,
                io_replay_bits_uop_lrs1_rtype,
                io_replay_bits_uop_lrs2_rtype,
  output        io_replay_bits_uop_frs3_en,
                io_replay_bits_uop_fp_val,
                io_replay_bits_uop_fp_single,
                io_replay_bits_uop_xcpt_pf_if,
                io_replay_bits_uop_xcpt_ae_if,
                io_replay_bits_uop_xcpt_ma_if,
                io_replay_bits_uop_bp_debug_if,
                io_replay_bits_uop_bp_xcpt_if,
  output [1:0]  io_replay_bits_uop_debug_fsrc,
                io_replay_bits_uop_debug_tsrc,
  output [39:0] io_replay_bits_addr,
  output        io_replay_bits_is_hella,
  output [3:0]  io_replay_bits_way_en,
  output [4:0]  io_replay_bits_sdq_id,
  output        io_resp_valid,
  output [6:0]  io_resp_bits_uop_uopc,
  output [31:0] io_resp_bits_uop_inst,
                io_resp_bits_uop_debug_inst,
  output        io_resp_bits_uop_is_rvc,
  output [39:0] io_resp_bits_uop_debug_pc,
  output [2:0]  io_resp_bits_uop_iq_type,
  output [9:0]  io_resp_bits_uop_fu_code,
  output [3:0]  io_resp_bits_uop_ctrl_br_type,
  output [1:0]  io_resp_bits_uop_ctrl_op1_sel,
  output [2:0]  io_resp_bits_uop_ctrl_op2_sel,
                io_resp_bits_uop_ctrl_imm_sel,
  output [3:0]  io_resp_bits_uop_ctrl_op_fcn,
  output        io_resp_bits_uop_ctrl_fcn_dw,
  output [2:0]  io_resp_bits_uop_ctrl_csr_cmd,
  output        io_resp_bits_uop_ctrl_is_load,
                io_resp_bits_uop_ctrl_is_sta,
                io_resp_bits_uop_ctrl_is_std,
  output [1:0]  io_resp_bits_uop_iw_state,
  output        io_resp_bits_uop_iw_p1_poisoned,
                io_resp_bits_uop_iw_p2_poisoned,
                io_resp_bits_uop_is_br,
                io_resp_bits_uop_is_jalr,
                io_resp_bits_uop_is_jal,
                io_resp_bits_uop_is_sfb,
  output [11:0] io_resp_bits_uop_br_mask,
  output [3:0]  io_resp_bits_uop_br_tag,
  output [4:0]  io_resp_bits_uop_ftq_idx,
  output        io_resp_bits_uop_edge_inst,
  output [5:0]  io_resp_bits_uop_pc_lob,
  output        io_resp_bits_uop_taken,
  output [19:0] io_resp_bits_uop_imm_packed,
  output [11:0] io_resp_bits_uop_csr_addr,
  output [5:0]  io_resp_bits_uop_rob_idx,
  output [3:0]  io_resp_bits_uop_ldq_idx,
                io_resp_bits_uop_stq_idx,
  output [1:0]  io_resp_bits_uop_rxq_idx,
  output [6:0]  io_resp_bits_uop_pdst,
                io_resp_bits_uop_prs1,
                io_resp_bits_uop_prs2,
                io_resp_bits_uop_prs3,
  output [4:0]  io_resp_bits_uop_ppred,
  output        io_resp_bits_uop_prs1_busy,
                io_resp_bits_uop_prs2_busy,
                io_resp_bits_uop_prs3_busy,
                io_resp_bits_uop_ppred_busy,
  output [6:0]  io_resp_bits_uop_stale_pdst,
  output        io_resp_bits_uop_exception,
  output [63:0] io_resp_bits_uop_exc_cause,
  output        io_resp_bits_uop_bypassable,
  output [4:0]  io_resp_bits_uop_mem_cmd,
  output [1:0]  io_resp_bits_uop_mem_size,
  output        io_resp_bits_uop_mem_signed,
                io_resp_bits_uop_is_fence,
                io_resp_bits_uop_is_fencei,
                io_resp_bits_uop_is_amo,
                io_resp_bits_uop_uses_ldq,
                io_resp_bits_uop_uses_stq,
                io_resp_bits_uop_is_sys_pc2epc,
                io_resp_bits_uop_is_unique,
                io_resp_bits_uop_flush_on_commit,
                io_resp_bits_uop_ldst_is_rs1,
  output [5:0]  io_resp_bits_uop_ldst,
                io_resp_bits_uop_lrs1,
                io_resp_bits_uop_lrs2,
                io_resp_bits_uop_lrs3,
  output        io_resp_bits_uop_ldst_val,
  output [1:0]  io_resp_bits_uop_dst_rtype,
                io_resp_bits_uop_lrs1_rtype,
                io_resp_bits_uop_lrs2_rtype,
  output        io_resp_bits_uop_frs3_en,
                io_resp_bits_uop_fp_val,
                io_resp_bits_uop_fp_single,
                io_resp_bits_uop_xcpt_pf_if,
                io_resp_bits_uop_xcpt_ae_if,
                io_resp_bits_uop_xcpt_ma_if,
                io_resp_bits_uop_bp_debug_if,
                io_resp_bits_uop_bp_xcpt_if,
  output [1:0]  io_resp_bits_uop_debug_fsrc,
                io_resp_bits_uop_debug_tsrc,
  output [63:0] io_resp_bits_data,
  output        io_resp_bits_is_hella,
                io_probe_rdy
);

  wire             _io_req_pri_rdy_output;	// mshrs.scala:204:30, :205:20, :211:40
  wire             _io_lb_read_valid_output;	// mshrs.scala:170:26, :204:30, :211:40, :222:41, :245:45
  wire             _io_mem_grant_ready_output;	// mshrs.scala:223:44, :224:31, :230:31
  wire             _io_req_sec_rdy_output;	// mshrs.scala:158:37
  wire             _rpq_io_enq_ready;	// mshrs.scala:128:19
  wire             _rpq_io_deq_valid;	// mshrs.scala:128:19
  wire [6:0]       _rpq_io_deq_bits_uop_uopc;	// mshrs.scala:128:19
  wire [31:0]      _rpq_io_deq_bits_uop_inst;	// mshrs.scala:128:19
  wire [31:0]      _rpq_io_deq_bits_uop_debug_inst;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_uop_is_rvc;	// mshrs.scala:128:19
  wire [39:0]      _rpq_io_deq_bits_uop_debug_pc;	// mshrs.scala:128:19
  wire [2:0]       _rpq_io_deq_bits_uop_iq_type;	// mshrs.scala:128:19
  wire [9:0]       _rpq_io_deq_bits_uop_fu_code;	// mshrs.scala:128:19
  wire [3:0]       _rpq_io_deq_bits_uop_ctrl_br_type;	// mshrs.scala:128:19
  wire [1:0]       _rpq_io_deq_bits_uop_ctrl_op1_sel;	// mshrs.scala:128:19
  wire [2:0]       _rpq_io_deq_bits_uop_ctrl_op2_sel;	// mshrs.scala:128:19
  wire [2:0]       _rpq_io_deq_bits_uop_ctrl_imm_sel;	// mshrs.scala:128:19
  wire [3:0]       _rpq_io_deq_bits_uop_ctrl_op_fcn;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_uop_ctrl_fcn_dw;	// mshrs.scala:128:19
  wire [2:0]       _rpq_io_deq_bits_uop_ctrl_csr_cmd;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_uop_ctrl_is_load;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_uop_ctrl_is_sta;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_uop_ctrl_is_std;	// mshrs.scala:128:19
  wire [1:0]       _rpq_io_deq_bits_uop_iw_state;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_uop_iw_p1_poisoned;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_uop_iw_p2_poisoned;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_uop_is_br;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_uop_is_jalr;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_uop_is_jal;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_uop_is_sfb;	// mshrs.scala:128:19
  wire [11:0]      _rpq_io_deq_bits_uop_br_mask;	// mshrs.scala:128:19
  wire [3:0]       _rpq_io_deq_bits_uop_br_tag;	// mshrs.scala:128:19
  wire [4:0]       _rpq_io_deq_bits_uop_ftq_idx;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_uop_edge_inst;	// mshrs.scala:128:19
  wire [5:0]       _rpq_io_deq_bits_uop_pc_lob;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_uop_taken;	// mshrs.scala:128:19
  wire [19:0]      _rpq_io_deq_bits_uop_imm_packed;	// mshrs.scala:128:19
  wire [11:0]      _rpq_io_deq_bits_uop_csr_addr;	// mshrs.scala:128:19
  wire [5:0]       _rpq_io_deq_bits_uop_rob_idx;	// mshrs.scala:128:19
  wire [3:0]       _rpq_io_deq_bits_uop_ldq_idx;	// mshrs.scala:128:19
  wire [3:0]       _rpq_io_deq_bits_uop_stq_idx;	// mshrs.scala:128:19
  wire [1:0]       _rpq_io_deq_bits_uop_rxq_idx;	// mshrs.scala:128:19
  wire [6:0]       _rpq_io_deq_bits_uop_pdst;	// mshrs.scala:128:19
  wire [6:0]       _rpq_io_deq_bits_uop_prs1;	// mshrs.scala:128:19
  wire [6:0]       _rpq_io_deq_bits_uop_prs2;	// mshrs.scala:128:19
  wire [6:0]       _rpq_io_deq_bits_uop_prs3;	// mshrs.scala:128:19
  wire [4:0]       _rpq_io_deq_bits_uop_ppred;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_uop_prs1_busy;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_uop_prs2_busy;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_uop_prs3_busy;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_uop_ppred_busy;	// mshrs.scala:128:19
  wire [6:0]       _rpq_io_deq_bits_uop_stale_pdst;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_uop_exception;	// mshrs.scala:128:19
  wire [63:0]      _rpq_io_deq_bits_uop_exc_cause;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_uop_bypassable;	// mshrs.scala:128:19
  wire [4:0]       _rpq_io_deq_bits_uop_mem_cmd;	// mshrs.scala:128:19
  wire [1:0]       _rpq_io_deq_bits_uop_mem_size;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_uop_mem_signed;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_uop_is_fence;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_uop_is_fencei;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_uop_is_amo;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_uop_uses_ldq;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_uop_uses_stq;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_uop_is_sys_pc2epc;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_uop_is_unique;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_uop_flush_on_commit;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_uop_ldst_is_rs1;	// mshrs.scala:128:19
  wire [5:0]       _rpq_io_deq_bits_uop_ldst;	// mshrs.scala:128:19
  wire [5:0]       _rpq_io_deq_bits_uop_lrs1;	// mshrs.scala:128:19
  wire [5:0]       _rpq_io_deq_bits_uop_lrs2;	// mshrs.scala:128:19
  wire [5:0]       _rpq_io_deq_bits_uop_lrs3;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_uop_ldst_val;	// mshrs.scala:128:19
  wire [1:0]       _rpq_io_deq_bits_uop_dst_rtype;	// mshrs.scala:128:19
  wire [1:0]       _rpq_io_deq_bits_uop_lrs1_rtype;	// mshrs.scala:128:19
  wire [1:0]       _rpq_io_deq_bits_uop_lrs2_rtype;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_uop_frs3_en;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_uop_fp_val;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_uop_fp_single;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_uop_xcpt_pf_if;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_uop_xcpt_ae_if;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_uop_xcpt_ma_if;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_uop_bp_debug_if;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_uop_bp_xcpt_if;	// mshrs.scala:128:19
  wire [1:0]       _rpq_io_deq_bits_uop_debug_fsrc;	// mshrs.scala:128:19
  wire [1:0]       _rpq_io_deq_bits_uop_debug_tsrc;	// mshrs.scala:128:19
  wire [39:0]      _rpq_io_deq_bits_addr;	// mshrs.scala:128:19
  wire             _rpq_io_deq_bits_is_hella;	// mshrs.scala:128:19
  wire             _rpq_io_empty;	// mshrs.scala:128:19
  reg  [4:0]       state;	// mshrs.scala:107:22
  reg  [4:0]       req_uop_mem_cmd;	// mshrs.scala:109:20
  reg  [39:0]      req_addr;	// mshrs.scala:109:20
  reg  [1:0]       req_old_meta_coh_state;	// mshrs.scala:109:20
  reg  [19:0]      req_old_meta_tag;	// mshrs.scala:109:20
  reg  [3:0]       req_way_en;	// mshrs.scala:109:20
  reg              req_needs_wb;	// mshrs.scala:113:29
  reg  [1:0]       new_coh_state;	// mshrs.scala:115:24
  wire             _needs_second_acq_T_27 = req_uop_mem_cmd == 5'h1;	// Consts.scala:82:32, mshrs.scala:109:20
  wire             _needs_second_acq_T_28 = req_uop_mem_cmd == 5'h11;	// Consts.scala:82:49, mshrs.scala:109:20
  wire             _needs_second_acq_T_30 = req_uop_mem_cmd == 5'h7;	// Consts.scala:82:66, mshrs.scala:109:20
  wire             _needs_second_acq_T_32 = req_uop_mem_cmd == 5'h4;	// mshrs.scala:109:20, package.scala:15:47
  wire             _needs_second_acq_T_33 = req_uop_mem_cmd == 5'h9;	// mshrs.scala:109:20, package.scala:15:47
  wire             _needs_second_acq_T_34 = req_uop_mem_cmd == 5'hA;	// mshrs.scala:109:20, package.scala:15:47
  wire             _needs_second_acq_T_35 = req_uop_mem_cmd == 5'hB;	// mshrs.scala:109:20, package.scala:15:47
  wire             _needs_second_acq_T_39 = req_uop_mem_cmd == 5'h8;	// mshrs.scala:109:20, package.scala:15:47
  wire             _needs_second_acq_T_40 = req_uop_mem_cmd == 5'hC;	// mshrs.scala:109:20, package.scala:15:47
  wire             _needs_second_acq_T_41 = req_uop_mem_cmd == 5'hD;	// mshrs.scala:109:20, package.scala:15:47
  wire             _needs_second_acq_T_42 = req_uop_mem_cmd == 5'hE;	// mshrs.scala:109:20, package.scala:15:47
  wire             _needs_second_acq_T_43 = req_uop_mem_cmd == 5'hF;	// mshrs.scala:109:20, package.scala:15:47
  wire             _needs_second_acq_T_50 = req_uop_mem_cmd == 5'h3;	// Consts.scala:83:54, mshrs.scala:109:20
  wire             _needs_second_acq_T_52 = req_uop_mem_cmd == 5'h6;	// Consts.scala:83:71, mshrs.scala:109:20
  wire [3:0]       _grow_param_T =
    {_needs_second_acq_T_27 | _needs_second_acq_T_28 | _needs_second_acq_T_30
       | _needs_second_acq_T_32 | _needs_second_acq_T_33 | _needs_second_acq_T_34
       | _needs_second_acq_T_35 | _needs_second_acq_T_39 | _needs_second_acq_T_40
       | _needs_second_acq_T_41 | _needs_second_acq_T_42 | _needs_second_acq_T_43,
     _needs_second_acq_T_27 | _needs_second_acq_T_28 | _needs_second_acq_T_30
       | _needs_second_acq_T_32 | _needs_second_acq_T_33 | _needs_second_acq_T_34
       | _needs_second_acq_T_35 | _needs_second_acq_T_39 | _needs_second_acq_T_40
       | _needs_second_acq_T_41 | _needs_second_acq_T_42 | _needs_second_acq_T_43
       | _needs_second_acq_T_50 | _needs_second_acq_T_52,
     new_coh_state};	// Cat.scala:30:58, Consts.scala:82:{32,49,66,76}, :83:{54,64,71}, mshrs.scala:115:24, package.scala:15:47
  wire [1:0]       _grow_param_T_15 = {1'h0, _grow_param_T == 4'hC};	// Cat.scala:30:58, Misc.scala:34:36, :48:20, mshrs.scala:109:20, package.scala:15:47
  wire [15:0][1:0] _GEN =
    {{2'h3},
     {2'h3},
     {2'h2},
     {_grow_param_T_15},
     {_grow_param_T_15},
     {_grow_param_T_15},
     {_grow_param_T_15},
     {_grow_param_T_15},
     {2'h3},
     {2'h2},
     {2'h2},
     {2'h1},
     {2'h3},
     {2'h2},
     {2'h1},
     {2'h0}};	// Cat.scala:30:58, Metadata.scala:160:16, Misc.scala:34:36, :48:20, Mux.scala:80:57
  wire             _state_T_133 = io_req_uop_mem_cmd == 5'h1;	// Consts.scala:82:32
  wire             _state_T_134 = io_req_uop_mem_cmd == 5'h11;	// Consts.scala:82:49
  wire             _state_T_136 = io_req_uop_mem_cmd == 5'h7;	// Consts.scala:82:66
  wire             _state_T_138 = io_req_uop_mem_cmd == 5'h4;	// package.scala:15:47
  wire             _state_T_139 = io_req_uop_mem_cmd == 5'h9;	// package.scala:15:47
  wire             _state_T_140 = io_req_uop_mem_cmd == 5'hA;	// package.scala:15:47
  wire             _state_T_141 = io_req_uop_mem_cmd == 5'hB;	// package.scala:15:47
  wire             _state_T_145 = io_req_uop_mem_cmd == 5'h8;	// package.scala:15:47
  wire             _state_T_146 = io_req_uop_mem_cmd == 5'hC;	// package.scala:15:47
  wire             _state_T_147 = io_req_uop_mem_cmd == 5'hD;	// package.scala:15:47
  wire             _state_T_148 = io_req_uop_mem_cmd == 5'hE;	// package.scala:15:47
  wire             _state_T_149 = io_req_uop_mem_cmd == 5'hF;	// package.scala:15:47
  wire             _state_c_cat_T_93 = io_req_uop_mem_cmd == 5'h3;	// Consts.scala:83:54
  wire             _state_c_cat_T_95 = io_req_uop_mem_cmd == 5'h6;	// Consts.scala:83:71
  wire             _GEN_0 = _io_mem_grant_ready_output & io_mem_grant_valid;	// Decoupled.scala:40:37, mshrs.scala:223:44, :224:31, :230:31
  wire [26:0]      _beats1_decode_T_1 = 27'hFFF << io_mem_grant_bits_size;	// package.scala:234:77
  wire [8:0]       beats1 =
    io_mem_grant_bits_opcode[0] ? ~(_beats1_decode_T_1[11:3]) : 9'h0;	// Edges.scala:105:36, :220:14, :228:27, package.scala:234:{46,77,82}
  reg  [8:0]       counter;	// Edges.scala:228:27
  wire [8:0]       _counter1_T = counter - 9'h1;	// Edges.scala:228:27, :229:28
  wire             refill_done = (counter == 9'h1 | beats1 == 9'h0) & _GEN_0;	// Decoupled.scala:40:37, Edges.scala:220:14, :228:27, :231:{25,37,47}, :232:22
  wire             _sec_rdy_T_4 = state == 5'hD;	// mshrs.scala:107:22, package.scala:15:47
  wire             _sec_rdy_T_5 = state == 5'hE;	// mshrs.scala:107:22, package.scala:15:47
  wire             _sec_rdy_T_6 = state == 5'hF;	// mshrs.scala:107:22, package.scala:15:47
  wire             _rpq_io_enq_valid_T = io_req_pri_val & _io_req_pri_rdy_output;	// mshrs.scala:133:40, :204:30, :205:20, :211:40
  wire             _rpq_io_enq_valid_T_1 = io_req_sec_val & _io_req_sec_rdy_output;	// mshrs.scala:133:78, :158:37
  wire             _rpq_io_enq_valid_T_7 =
    (_rpq_io_enq_valid_T | _rpq_io_enq_valid_T_1)
    & ~(io_req_uop_mem_cmd == 5'h2 | _state_c_cat_T_93);	// Consts.scala:80:{35,45}, :83:54, mshrs.scala:133:{40,59,78,98,101}
  reg              grantack_valid;	// mshrs.scala:138:21
  reg  [2:0]       grantack_bits_sink;	// mshrs.scala:138:21
  reg  [2:0]       refill_ctr;	// mshrs.scala:139:24
  reg              commit_line;	// mshrs.scala:140:24
  reg              grant_had_data;	// mshrs.scala:141:27
  reg              finish_to_prefetch;	// mshrs.scala:142:31
  reg  [1:0]       meta_hazard;	// mshrs.scala:145:28
  wire             _io_probe_rdy_T_2 = state == 5'h1;	// mshrs.scala:107:22, package.scala:15:47
  wire             _io_probe_rdy_T_3 = state == 5'h2;	// mshrs.scala:107:22, package.scala:15:47
  wire             _io_probe_rdy_T_4 = state == 5'h3;	// mshrs.scala:107:22, package.scala:15:47
  wire             _io_probe_rdy_T_8 = state == 5'h4;	// mshrs.scala:107:22, :148:129
  wire             _io_way_valid_T_1 = state == 5'h11;	// mshrs.scala:107:22, package.scala:15:47
  assign _io_req_sec_rdy_output =
    ~((_state_T_133 | _state_T_134 | _state_T_136 | _state_T_138 | _state_T_139
       | _state_T_140 | _state_T_141 | _state_T_145 | _state_T_146 | _state_T_147
       | _state_T_148 | _state_T_149 | _state_c_cat_T_93 | _state_c_cat_T_95)
      & ~(_needs_second_acq_T_27 | _needs_second_acq_T_28 | _needs_second_acq_T_30
          | _needs_second_acq_T_32 | _needs_second_acq_T_33 | _needs_second_acq_T_34
          | _needs_second_acq_T_35 | _needs_second_acq_T_39 | _needs_second_acq_T_40
          | _needs_second_acq_T_41 | _needs_second_acq_T_42 | _needs_second_acq_T_43
          | _needs_second_acq_T_50 | _needs_second_acq_T_52)) & ~io_req_is_probe
    & ~(~(|state) | _sec_rdy_T_4 | _sec_rdy_T_5 | _sec_rdy_T_6) & _rpq_io_enq_ready;	// Consts.scala:82:{32,49,66}, :83:{54,64,71}, Metadata.scala:103:{54,57}, mshrs.scala:107:22, :125:{18,50}, :126:18, :128:19, :158:37, package.scala:15:47, :72:59
  wire [3:0]       _state_T_3 =
    {_state_T_133 | _state_T_134 | _state_T_136 | _state_T_138 | _state_T_139
       | _state_T_140 | _state_T_141 | _state_T_145 | _state_T_146 | _state_T_147
       | _state_T_148 | _state_T_149,
     _state_T_133 | _state_T_134 | _state_T_136 | _state_T_138 | _state_T_139
       | _state_T_140 | _state_T_141 | _state_T_145 | _state_T_146 | _state_T_147
       | _state_T_148 | _state_T_149 | _state_c_cat_T_93 | _state_c_cat_T_95,
     io_req_old_meta_coh_state};	// Cat.scala:30:58, Consts.scala:82:{32,49,66,76}, :83:{54,64,71}, package.scala:15:47
  wire             state_is_hit =
    _state_T_3 == 4'h3 | _state_T_3 == 4'h2 | _state_T_3 == 4'h1 | _state_T_3 == 4'h7
    | _state_T_3 == 4'h6 | (&_state_T_3) | _state_T_3 == 4'hE;	// Cat.scala:30:58, Misc.scala:34:9, :48:20, package.scala:15:47
  wire             _io_mem_acquire_valid_output = (|state) & _io_probe_rdy_T_2;	// mshrs.scala:107:22, :159:26, :204:30, :211:40, package.scala:15:47
  wire             _GEN_1 = ~(|state) | _io_probe_rdy_T_2;	// mshrs.scala:107:22, :169:26, :204:30, :211:40, :222:41, package.scala:15:47
  assign _io_mem_grant_ready_output = ~(io_mem_grant_bits_opcode[0]) | io_lb_write_ready;	// Edges.scala:105:36, mshrs.scala:223:44, :224:31, :230:31
  wire             _drain_load_T_26 = _rpq_io_deq_bits_uop_mem_cmd == 5'h7;	// Consts.scala:81:65, mshrs.scala:128:19
  wire             _drain_load_T_28 = _rpq_io_deq_bits_uop_mem_cmd == 5'h4;	// mshrs.scala:128:19, package.scala:15:47
  wire             _drain_load_T_29 = _rpq_io_deq_bits_uop_mem_cmd == 5'h9;	// mshrs.scala:128:19, package.scala:15:47
  wire             _drain_load_T_30 = _rpq_io_deq_bits_uop_mem_cmd == 5'hA;	// mshrs.scala:128:19, package.scala:15:47
  wire             _drain_load_T_31 = _rpq_io_deq_bits_uop_mem_cmd == 5'hB;	// mshrs.scala:128:19, package.scala:15:47
  wire             _drain_load_T_35 = _rpq_io_deq_bits_uop_mem_cmd == 5'h8;	// mshrs.scala:128:19, package.scala:15:47
  wire             _drain_load_T_36 = _rpq_io_deq_bits_uop_mem_cmd == 5'hC;	// mshrs.scala:128:19, package.scala:15:47
  wire             _drain_load_T_37 = _rpq_io_deq_bits_uop_mem_cmd == 5'hD;	// mshrs.scala:128:19, package.scala:15:47
  wire             _drain_load_T_38 = _rpq_io_deq_bits_uop_mem_cmd == 5'hE;	// mshrs.scala:128:19, package.scala:15:47
  wire             _drain_load_T_39 = _rpq_io_deq_bits_uop_mem_cmd == 5'hF;	// mshrs.scala:128:19, package.scala:15:47
  wire             drain_load =
    (_rpq_io_deq_bits_uop_mem_cmd == 5'h0 | _rpq_io_deq_bits_uop_mem_cmd == 5'h6
     | _drain_load_T_26 | _drain_load_T_28 | _drain_load_T_29 | _drain_load_T_30
     | _drain_load_T_31 | _drain_load_T_35 | _drain_load_T_36 | _drain_load_T_37
     | _drain_load_T_38 | _drain_load_T_39)
    & ~(_rpq_io_deq_bits_uop_mem_cmd == 5'h1 | _rpq_io_deq_bits_uop_mem_cmd == 5'h11
        | _drain_load_T_26 | _drain_load_T_28 | _drain_load_T_29 | _drain_load_T_30
        | _drain_load_T_31 | _drain_load_T_35 | _drain_load_T_36 | _drain_load_T_37
        | _drain_load_T_38 | _drain_load_T_39) & _rpq_io_deq_bits_uop_mem_cmd != 5'h6;	// Consts.scala:81:{31,48,65,75}, :82:{32,49,76}, mshrs.scala:128:19, :247:{22,60}, :248:51, package.scala:15:47
  wire             _GEN_2 = ~(|state) | _io_probe_rdy_T_2 | _io_probe_rdy_T_3;	// mshrs.scala:107:22, :163:26, :204:30, :211:40, :222:41, :245:45, package.scala:15:47
  wire [31:0]      io_resp_bits_data_lo =
    _rpq_io_deq_bits_addr[2] ? io_lb_resp[63:32] : io_lb_resp[31:0];	// AMOALU.scala:39:{24,29,37,55}, mshrs.scala:128:19
  wire [15:0]      io_resp_bits_data_lo_1 =
    _rpq_io_deq_bits_addr[1] ? io_resp_bits_data_lo[31:16] : io_resp_bits_data_lo[15:0];	// AMOALU.scala:39:{24,29,37,55}, mshrs.scala:128:19
  wire [7:0]       io_resp_bits_data_lo_2 =
    _rpq_io_deq_bits_addr[0] ? io_resp_bits_data_lo_1[15:8] : io_resp_bits_data_lo_1[7:0];	// AMOALU.scala:39:{24,29,37,55}, mshrs.scala:128:19
  wire             _io_meta_read_valid_output =
    ~(~(|state) | _io_probe_rdy_T_2 | _io_probe_rdy_T_3 | _io_probe_rdy_T_4)
    & _io_probe_rdy_T_8
    & (~io_prober_state_valid | ~grantack_valid
       | io_prober_state_bits[11:6] != req_addr[11:6]);	// mshrs.scala:107:22, :109:20, :110:25, :138:21, :148:129, :167:26, :204:30, :211:40, :222:41, :245:45, :283:39, :284:{27,53,69,93,120}, package.scala:15:47
  wire             _GEN_3 = state == 5'h5;	// mshrs.scala:107:22, :291:22
  wire             _GEN_4 = state == 5'h6;	// mshrs.scala:107:22, :293:22
  wire             _GEN_5 = state == 5'h7;	// mshrs.scala:107:22, :297:22
  wire             _GEN_6 = state == 5'h9;	// mshrs.scala:107:22, :307:22
  wire             _io_wb_req_valid_output =
    ~(~(|state) | _io_probe_rdy_T_2 | _io_probe_rdy_T_3 | _io_probe_rdy_T_4
      | _io_probe_rdy_T_8 | _GEN_3 | _GEN_4 | _GEN_5) & _GEN_6;	// mshrs.scala:107:22, :148:129, :162:26, :204:30, :211:40, :222:41, :245:45, :283:39, :291:{22,41}, :293:{22,41}, :297:{22,40}, :307:{22,36}, package.scala:15:47
  wire             _GEN_7 = state == 5'hA;	// mshrs.scala:107:22, :319:22
  wire             _GEN_8 = state == 5'hB;	// mshrs.scala:107:22, :323:22
  wire             _GEN_9 =
    _io_probe_rdy_T_8 | _GEN_3 | _GEN_4 | _GEN_5 | _GEN_6 | _GEN_7;	// mshrs.scala:148:129, :170:26, :283:39, :291:{22,41}, :293:{22,41}, :297:{22,40}, :307:{22,36}, :319:{22,37}, :323:41
  assign _io_lb_read_valid_output =
    ~_GEN_2 & (_io_probe_rdy_T_4 ? _rpq_io_deq_valid & drain_load : ~_GEN_9 & _GEN_8);	// mshrs.scala:128:19, :163:26, :170:26, :204:30, :211:40, :222:41, :245:45, :247:60, :260:{28,48}, :283:39, :291:41, :293:41, :297:40, :307:36, :319:37, :323:{22,41}, package.scala:15:47
  wire             _GEN_10 =
    _io_probe_rdy_T_2 | _io_probe_rdy_T_3 | _io_probe_rdy_T_4 | _GEN_9;	// mshrs.scala:160:26, :170:26, :211:40, :222:41, :245:45, :283:39, :291:41, :293:41, :297:40, :307:36, :319:37, :323:41, package.scala:15:47
  wire             _io_refill_valid_output =
    ~(~(|state) | _GEN_10) & _GEN_8 & io_lb_read_ready & _io_lb_read_valid_output;	// mshrs.scala:107:22, :160:26, :170:26, :204:30, :211:40, :222:41, :245:45, :283:39, :291:41, :293:41, :297:40, :307:36, :319:37, :323:{22,41}, package.scala:15:47
  wire             _GEN_11 = state == 5'hC;	// mshrs.scala:107:22, :339:22
  wire             _GEN_12 =
    _io_probe_rdy_T_8 | _GEN_3 | _GEN_4 | _GEN_5 | _GEN_6 | _GEN_7 | _GEN_8;	// mshrs.scala:148:129, :161:26, :283:39, :291:{22,41}, :293:{22,41}, :297:{22,40}, :307:{22,36}, :319:{22,37}, :323:{22,41}, :339:39
  wire             _GEN_13 = _io_probe_rdy_T_4 | _GEN_12;	// mshrs.scala:161:26, :245:45, :283:39, :291:41, :293:41, :297:40, :307:36, :319:37, :323:41, :339:39, package.scala:15:47
  wire             _io_replay_valid_output =
    ~(~(|state) | _io_probe_rdy_T_2 | _io_probe_rdy_T_3 | _GEN_13) & _GEN_11
    & _rpq_io_deq_valid;	// mshrs.scala:107:22, :128:19, :161:26, :204:30, :211:40, :222:41, :245:45, :283:39, :291:41, :293:41, :297:40, :307:36, :319:37, :323:41, :339:{22,39}, package.scala:15:47
  wire             _GEN_14 =
    ~_GEN_2
    & (_io_probe_rdy_T_4
         ? io_resp_ready & io_lb_read_ready & drain_load
         : ~_GEN_12 & _GEN_11 & io_replay_ready);	// mshrs.scala:135:20, :161:26, :163:26, :204:30, :211:40, :222:41, :245:45, :247:60, :259:{28,65}, :283:39, :291:41, :293:41, :297:40, :307:36, :319:37, :323:41, :339:{22,39}, package.scala:15:47
  wire             _c_cat_T_118 = _rpq_io_deq_bits_uop_mem_cmd == 5'h1;	// Consts.scala:82:32, mshrs.scala:128:19
  wire             _c_cat_T_119 = _rpq_io_deq_bits_uop_mem_cmd == 5'h11;	// Consts.scala:82:49, mshrs.scala:128:19
  wire             _c_cat_T_121 = _rpq_io_deq_bits_uop_mem_cmd == 5'h7;	// Consts.scala:82:66, mshrs.scala:128:19
  wire             _c_cat_T_123 = _rpq_io_deq_bits_uop_mem_cmd == 5'h4;	// mshrs.scala:128:19, package.scala:15:47
  wire             _c_cat_T_124 = _rpq_io_deq_bits_uop_mem_cmd == 5'h9;	// mshrs.scala:128:19, package.scala:15:47
  wire             _c_cat_T_125 = _rpq_io_deq_bits_uop_mem_cmd == 5'hA;	// mshrs.scala:128:19, package.scala:15:47
  wire             _c_cat_T_126 = _rpq_io_deq_bits_uop_mem_cmd == 5'hB;	// mshrs.scala:128:19, package.scala:15:47
  wire             _c_cat_T_130 = _rpq_io_deq_bits_uop_mem_cmd == 5'h8;	// mshrs.scala:128:19, package.scala:15:47
  wire             _c_cat_T_131 = _rpq_io_deq_bits_uop_mem_cmd == 5'hC;	// mshrs.scala:128:19, package.scala:15:47
  wire             _c_cat_T_132 = _rpq_io_deq_bits_uop_mem_cmd == 5'hD;	// mshrs.scala:128:19, package.scala:15:47
  wire             _c_cat_T_133 = _rpq_io_deq_bits_uop_mem_cmd == 5'hE;	// mshrs.scala:128:19, package.scala:15:47
  wire             _c_cat_T_134 = _rpq_io_deq_bits_uop_mem_cmd == 5'hF;	// mshrs.scala:128:19, package.scala:15:47
  wire             _GEN_15 =
    io_replay_ready & _io_replay_valid_output
    & (_c_cat_T_118 | _c_cat_T_119 | _c_cat_T_121 | _c_cat_T_123 | _c_cat_T_124
       | _c_cat_T_125 | _c_cat_T_126 | _c_cat_T_130 | _c_cat_T_131 | _c_cat_T_132
       | _c_cat_T_133 | _c_cat_T_134);	// Consts.scala:82:{32,49,66,76}, mshrs.scala:161:26, :204:30, :211:40, :222:41, :245:45, :283:39, :291:41, :293:41, :297:40, :307:36, :319:37, :323:41, :339:39, :343:28, package.scala:15:47
  wire [3:0]       _GEN_16 =
    {_c_cat_T_118 | _c_cat_T_119 | _c_cat_T_121 | _c_cat_T_123 | _c_cat_T_124
       | _c_cat_T_125 | _c_cat_T_126 | _c_cat_T_130 | _c_cat_T_131 | _c_cat_T_132
       | _c_cat_T_133 | _c_cat_T_134,
     _c_cat_T_118 | _c_cat_T_119 | _c_cat_T_121 | _c_cat_T_123 | _c_cat_T_124
       | _c_cat_T_125 | _c_cat_T_126 | _c_cat_T_130 | _c_cat_T_131 | _c_cat_T_132
       | _c_cat_T_133 | _c_cat_T_134 | _rpq_io_deq_bits_uop_mem_cmd == 5'h3
       | _rpq_io_deq_bits_uop_mem_cmd == 5'h6,
     new_coh_state};	// Cat.scala:30:58, Consts.scala:82:{32,49,66,76}, :83:{54,64,71}, mshrs.scala:115:24, :128:19, package.scala:15:47
  wire             _GEN_17 = _GEN_6 | _GEN_7 | _GEN_8 | _GEN_11;	// mshrs.scala:156:26, :307:{22,36}, :319:{22,37}, :323:{22,41}, :339:{22,39}, :352:44
  wire             _io_meta_write_valid_output =
    ~(~(|state) | _io_probe_rdy_T_2 | _io_probe_rdy_T_3 | _io_probe_rdy_T_4
      | _io_probe_rdy_T_8 | _GEN_3 | _GEN_4) & (_GEN_5 | ~_GEN_17 & _sec_rdy_T_4);	// mshrs.scala:107:22, :148:129, :156:26, :204:30, :211:40, :222:41, :245:45, :283:39, :291:{22,41}, :293:{22,41}, :297:{22,40}, :298:33, :307:36, :319:37, :323:41, :339:39, :352:44, package.scala:15:47
  wire             _GEN_18 =
    _io_probe_rdy_T_4 | _io_probe_rdy_T_8 | _GEN_3 | _GEN_4 | _GEN_5 | _GEN_6 | _GEN_7
    | _GEN_8 | _GEN_11 | _sec_rdy_T_4;	// mshrs.scala:148:129, :168:26, :245:45, :283:39, :291:{22,41}, :293:{22,41}, :297:{22,40}, :307:{22,36}, :319:{22,37}, :323:{22,41}, :339:{22,39}, :352:44, :362:42, package.scala:15:47
  wire             _io_mem_finish_valid_output =
    ~(~(|state) | _io_probe_rdy_T_2 | _io_probe_rdy_T_3 | _GEN_18) & _sec_rdy_T_5
    & grantack_valid;	// mshrs.scala:107:22, :138:21, :168:26, :204:30, :211:40, :222:41, :245:45, :283:39, :291:41, :293:41, :297:40, :307:36, :319:37, :323:41, :339:39, :352:44, :362:42, package.scala:15:47
  wire             _GEN_19 = _sec_rdy_T_4 | _sec_rdy_T_5 | _sec_rdy_T_6;	// mshrs.scala:157:26, :352:44, :362:42, :369:42, :371:38, package.scala:15:47
  wire             _GEN_20 = _GEN_11 | _GEN_19;	// mshrs.scala:157:26, :339:{22,39}, :352:44, :362:42, :369:42, :371:38
  wire             _GEN_21 =
    _io_probe_rdy_T_4 | _io_probe_rdy_T_8 | _GEN_3 | _GEN_4 | _GEN_5 | _GEN_6 | _GEN_7
    | _GEN_8 | _GEN_20;	// mshrs.scala:148:129, :157:26, :245:45, :283:39, :291:{22,41}, :293:{22,41}, :297:{22,40}, :307:{22,36}, :319:{22,37}, :323:{22,41}, :339:39, :352:44, :362:42, :369:42, :371:38, package.scala:15:47
  wire             _GEN_22 = _io_probe_rdy_T_2 | _io_probe_rdy_T_3 | _GEN_21;	// mshrs.scala:157:26, :211:40, :222:41, :245:45, :283:39, :291:41, :293:41, :297:40, :307:36, :319:37, :323:41, :339:39, :352:44, :362:42, :369:42, :371:38, package.scala:15:47
  assign _io_req_pri_rdy_output = ~(|state) | ~_GEN_22 & _io_way_valid_T_1;	// mshrs.scala:107:22, :157:26, :204:30, :205:20, :211:40, :222:41, :245:45, :283:39, :291:41, :293:41, :297:40, :307:36, :319:37, :323:41, :339:39, :352:44, :362:42, :369:42, :371:38, package.scala:15:47
  wire             _GEN_23 = io_req_sec_val & ~_io_req_sec_rdy_output | io_clear_prefetch;	// mshrs.scala:158:37, :373:{27,30,47}
  wire [3:0]       _state_T_85 =
    {_state_T_133 | _state_T_134 | _state_T_136 | _state_T_138 | _state_T_139
       | _state_T_140 | _state_T_141 | _state_T_145 | _state_T_146 | _state_T_147
       | _state_T_148 | _state_T_149,
     _state_T_133 | _state_T_134 | _state_T_136 | _state_T_138 | _state_T_139
       | _state_T_140 | _state_T_141 | _state_T_145 | _state_T_146 | _state_T_147
       | _state_T_148 | _state_T_149 | _state_c_cat_T_93 | _state_c_cat_T_95,
     io_req_old_meta_coh_state};	// Cat.scala:30:58, Consts.scala:82:{32,49,66,76}, :83:{54,64,71}, package.scala:15:47
  wire             state_is_hit_1 =
    _state_T_85 == 4'h3 | _state_T_85 == 4'h2 | _state_T_85 == 4'h1 | _state_T_85 == 4'h7
    | _state_T_85 == 4'h6 | (&_state_T_85) | _state_T_85 == 4'hE;	// Cat.scala:30:58, Misc.scala:34:9, :48:20, package.scala:15:47
  `ifndef SYNTHESIS	// mshrs.scala:131:9
    always @(posedge clock) begin	// mshrs.scala:131:9
      automatic logic _GEN_24;	// mshrs.scala:208:45
      automatic logic _GEN_25;	// mshrs.scala:211:40
      automatic logic _GEN_26;	// mshrs.scala:323:41
      automatic logic _GEN_27;	// mshrs.scala:384:52
      _GEN_24 = ~(|state) & _rpq_io_enq_valid_T;	// mshrs.scala:107:22, :133:40, :208:45, package.scala:15:47
      _GEN_25 = (|state) & ~_io_probe_rdy_T_2;	// mshrs.scala:107:22, :211:40, package.scala:15:47
      _GEN_26 =
        _GEN_25 & ~_io_probe_rdy_T_3 & ~_io_probe_rdy_T_4 & ~_io_probe_rdy_T_8 & ~_GEN_3
        & ~_GEN_4 & ~_GEN_5 & ~_GEN_6 & ~_GEN_7 & ~_GEN_8;	// mshrs.scala:148:129, :211:40, :222:41, :245:45, :283:39, :291:{22,41}, :293:{22,41}, :297:{22,40}, :307:{22,36}, :319:{22,37}, :323:{22,41}, package.scala:15:47
      _GEN_27 =
        _GEN_26 & ~_GEN_11 & ~_sec_rdy_T_4 & ~_sec_rdy_T_5 & ~_sec_rdy_T_6
        & _io_way_valid_T_1 & ~_GEN_23 & ~_rpq_io_enq_valid_T_1 & _rpq_io_enq_valid_T;	// mshrs.scala:133:{40,78}, :323:41, :339:{22,39}, :352:44, :362:42, :369:42, :373:{47,69}, :375:52, :384:52, package.scala:15:47
      if (~(~(~(|state) & ~_rpq_io_empty) | reset)) begin	// mshrs.scala:107:22, :128:19, :131:{9,10,32,35}, package.scala:15:47
        if (`ASSERT_VERBOSE_COND_)	// mshrs.scala:131:9
          $error("Assertion failed\n    at mshrs.scala:131 assert(!(state === s_invalid && !rpq.io.empty))\n");	// mshrs.scala:131:9
        if (`STOP_COND_)	// mshrs.scala:131:9
          $fatal;	// mshrs.scala:131:9
      end
      if (_GEN_24 & ~(_rpq_io_enq_ready | reset)) begin	// mshrs.scala:128:19, :183:11, :208:45
        if (`ASSERT_VERBOSE_COND_)	// mshrs.scala:183:11
          $error("Assertion failed\n    at mshrs.scala:183 assert(rpq.io.enq.ready)\n");	// mshrs.scala:183:11
        if (`STOP_COND_)	// mshrs.scala:183:11
          $fatal;	// mshrs.scala:183:11
      end
      if (_GEN_24 & io_req_tag_match & state_is_hit
          & ~(_state_T_133 | _state_T_134 | _state_T_136 | _state_T_138 | _state_T_139
              | _state_T_140 | _state_T_141 | _state_T_145 | _state_T_146 | _state_T_147
              | _state_T_148 | _state_T_149 | reset)) begin	// Consts.scala:82:{32,49,66}, Misc.scala:34:9, mshrs.scala:190:15, :208:45, package.scala:15:47
        if (`ASSERT_VERBOSE_COND_)	// mshrs.scala:190:15
          $error("Assertion failed\n    at mshrs.scala:190 assert(isWrite(io.req.uop.mem_cmd))\n");	// mshrs.scala:190:15
        if (`STOP_COND_)	// mshrs.scala:190:15
          $fatal;	// mshrs.scala:190:15
      end
      if (_GEN_25 & _io_probe_rdy_T_3 & refill_done
          & ~(~(~grant_had_data & req_needs_wb) | reset)) begin	// Edges.scala:232:22, mshrs.scala:113:29, :141:27, :211:40, :240:{13,14,16,32}, package.scala:15:47
        if (`ASSERT_VERBOSE_COND_)	// mshrs.scala:240:13
          $error("Assertion failed\n    at mshrs.scala:240 assert(!(!grant_had_data && req_needs_wb))\n");	// mshrs.scala:240:13
        if (`STOP_COND_)	// mshrs.scala:240:13
          $fatal;	// mshrs.scala:240:13
      end
      if (_GEN_26 & _GEN_11 & _GEN_15
          & ~(_GEN_16 == 4'h3 | _GEN_16 == 4'h2 | _GEN_16 == 4'h1 | _GEN_16 == 4'h7
              | _GEN_16 == 4'h6 | (&_GEN_16) | _GEN_16 == 4'hE | reset)) begin	// Cat.scala:30:58, Misc.scala:48:20, mshrs.scala:323:41, :339:22, :343:28, :346:13, package.scala:15:47
        if (`ASSERT_VERBOSE_COND_)	// mshrs.scala:346:13
          $error("Assertion failed: We still don't have permissions for this store\n    at mshrs.scala:346 assert(is_hit, \"We still don't have permissions for this store\")\n");	// mshrs.scala:346:13
        if (`STOP_COND_)	// mshrs.scala:346:13
          $fatal;	// mshrs.scala:346:13
      end
      if (_GEN_27 & ~(_rpq_io_enq_ready | reset)) begin	// mshrs.scala:128:19, :183:11, :384:52
        if (`ASSERT_VERBOSE_COND_)	// mshrs.scala:183:11
          $error("Assertion failed\n    at mshrs.scala:183 assert(rpq.io.enq.ready)\n");	// mshrs.scala:183:11
        if (`STOP_COND_)	// mshrs.scala:183:11
          $fatal;	// mshrs.scala:183:11
      end
      if (_GEN_27 & io_req_tag_match & state_is_hit_1
          & ~(_state_T_133 | _state_T_134 | _state_T_136 | _state_T_138 | _state_T_139
              | _state_T_140 | _state_T_141 | _state_T_145 | _state_T_146 | _state_T_147
              | _state_T_148 | _state_T_149 | reset)) begin	// Consts.scala:82:{32,49,66}, Misc.scala:34:9, mshrs.scala:190:15, :384:52, package.scala:15:47
        if (`ASSERT_VERBOSE_COND_)	// mshrs.scala:190:15
          $error("Assertion failed\n    at mshrs.scala:190 assert(isWrite(io.req.uop.mem_cmd))\n");	// mshrs.scala:190:15
        if (`STOP_COND_)	// mshrs.scala:190:15
          $fatal;	// mshrs.scala:190:15
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    automatic logic [1:0] dirties_cat;	// Cat.scala:30:58
    automatic logic       _GEN_28;	// Decoupled.scala:40:37
    automatic logic       _GEN_29;	// Metadata.scala:108:27, mshrs.scala:109:20, :172:43, :173:21
    automatic logic       _GEN_30;	// Decoupled.scala:40:37
    automatic logic       _GEN_31;	// mshrs.scala:271:31
    automatic logic       _GEN_32;	// Decoupled.scala:40:37
    automatic logic       _GEN_33;	// Decoupled.scala:40:37
    automatic logic       _GEN_34;	// mshrs.scala:365:32
    automatic logic       _GEN_35;	// mshrs.scala:141:27, :373:69, :375:52, :384:52
    automatic logic       _GEN_36;	// mshrs.scala:109:20, :211:40, :222:41, :245:45, :283:39, :291:41, :293:41, :297:40, :307:36, :319:37, :323:41, :339:39, :352:44, :362:42, :369:42, :371:38
    dirties_cat =
      {_state_T_133 | _state_T_134 | _state_T_136 | _state_T_138 | _state_T_139
         | _state_T_140 | _state_T_141 | _state_T_145 | _state_T_146 | _state_T_147
         | _state_T_148 | _state_T_149,
       _state_T_133 | _state_T_134 | _state_T_136 | _state_T_138 | _state_T_139
         | _state_T_140 | _state_T_141 | _state_T_145 | _state_T_146 | _state_T_147
         | _state_T_148 | _state_T_149 | _state_c_cat_T_93 | _state_c_cat_T_95};	// Cat.scala:30:58, Consts.scala:82:{32,49,66,76}, :83:{54,64,71}, package.scala:15:47
    _GEN_28 = io_meta_write_ready & _io_meta_write_valid_output;	// Decoupled.scala:40:37, mshrs.scala:156:26, :204:30, :211:40, :222:41, :245:45, :283:39, :291:41, :293:41, :297:40
    _GEN_29 = _rpq_io_enq_valid_T_1 & (&dirties_cat);	// Cat.scala:30:58, Metadata.scala:105:42, :108:27, mshrs.scala:109:20, :133:78, :172:43, :173:21
    _GEN_30 = _GEN_14 & _rpq_io_deq_valid;	// Decoupled.scala:40:37, mshrs.scala:128:19, :135:20, :204:30, :211:40, :222:41, :245:45
    _GEN_31 = _rpq_io_empty & ~commit_line;	// mshrs.scala:128:19, :140:24, :271:{31,34}
    _GEN_32 = _rpq_io_enq_ready & _rpq_io_enq_valid_T_7;	// Decoupled.scala:40:37, mshrs.scala:128:19, :133:98
    _GEN_33 = io_refill_ready & _io_refill_valid_output;	// Decoupled.scala:40:37, mshrs.scala:160:26, :204:30, :211:40, :222:41, :245:45, :283:39, :291:41, :293:41, :297:40, :307:36, :319:37, :323:41
    _GEN_34 = io_mem_finish_ready & _io_mem_finish_valid_output | ~grantack_valid;	// Decoupled.scala:40:37, mshrs.scala:138:21, :168:26, :204:30, :211:40, :222:41, :245:45, :283:39, :291:41, :293:41, :297:40, :307:36, :319:37, :323:41, :339:39, :352:44, :362:42, :365:{32,35}
    _GEN_35 = _GEN_23 | _rpq_io_enq_valid_T_1;	// mshrs.scala:133:78, :141:27, :373:{47,69}, :375:52, :384:52
    _GEN_36 = _GEN_22 | ~_io_way_valid_T_1 | _GEN_35 | ~_rpq_io_enq_valid_T;	// mshrs.scala:109:20, :133:40, :138:21, :141:27, :157:26, :181:20, :208:45, :211:40, :222:41, :245:45, :283:39, :291:41, :293:41, :297:40, :307:36, :319:37, :323:41, :339:39, :352:44, :362:42, :369:42, :371:38, :373:69, :375:52, :384:52, package.scala:15:47
    if (reset) begin
      state <= 5'h0;	// mshrs.scala:107:22
      req_needs_wb <= 1'h0;	// mshrs.scala:109:20, :113:29
      new_coh_state <= 2'h0;	// Metadata.scala:160:16, mshrs.scala:115:24
      counter <= 9'h0;	// Edges.scala:228:27
      meta_hazard <= 2'h0;	// Metadata.scala:160:16, mshrs.scala:145:28
    end
    else begin
      automatic logic [3:0]       _GEN_37;	// Cat.scala:30:58
      automatic logic [1:0]       _GEN_38;	// Misc.scala:34:36
      automatic logic [15:0][1:0] _GEN_39;	// Misc.scala:34:36, :48:20
      automatic logic [3:0]       _GEN_40;	// Cat.scala:30:58
      automatic logic [1:0]       _GEN_41;	// Misc.scala:34:36
      automatic logic [15:0][1:0] _GEN_42;	// Misc.scala:34:36, :48:20
      automatic logic             _GEN_43;	// mshrs.scala:115:24, :172:43, :174:25, :175:15
      _GEN_37 =
        {_needs_second_acq_T_27 | _needs_second_acq_T_28 | _needs_second_acq_T_30
           | _needs_second_acq_T_32 | _needs_second_acq_T_33 | _needs_second_acq_T_34
           | _needs_second_acq_T_35 | _needs_second_acq_T_39 | _needs_second_acq_T_40
           | _needs_second_acq_T_41 | _needs_second_acq_T_42 | _needs_second_acq_T_43,
         _needs_second_acq_T_27 | _needs_second_acq_T_28 | _needs_second_acq_T_30
           | _needs_second_acq_T_32 | _needs_second_acq_T_33 | _needs_second_acq_T_34
           | _needs_second_acq_T_35 | _needs_second_acq_T_39 | _needs_second_acq_T_40
           | _needs_second_acq_T_41 | _needs_second_acq_T_42 | _needs_second_acq_T_43
           | _needs_second_acq_T_50 | _needs_second_acq_T_52,
         new_coh_state};	// Cat.scala:30:58, Consts.scala:82:{32,49,66,76}, :83:{54,64,71}, mshrs.scala:115:24, package.scala:15:47
      _GEN_38 = {1'h0, _GEN_37 == 4'hC};	// Cat.scala:30:58, Misc.scala:34:36, :48:20, mshrs.scala:109:20, package.scala:15:47
      _GEN_39 =
        {{2'h3},
         {2'h3},
         {2'h2},
         {_GEN_38},
         {_GEN_38},
         {_GEN_38},
         {_GEN_38},
         {_GEN_38},
         {2'h3},
         {2'h2},
         {2'h2},
         {2'h1},
         {2'h3},
         {2'h2},
         {2'h1},
         {2'h0}};	// Cat.scala:30:58, Metadata.scala:160:16, Misc.scala:34:36, :48:20, Mux.scala:80:57
      _GEN_40 =
        {_state_T_133 | _state_T_134 | _state_T_136 | _state_T_138 | _state_T_139
           | _state_T_140 | _state_T_141 | _state_T_145 | _state_T_146 | _state_T_147
           | _state_T_148 | _state_T_149,
         _state_T_133 | _state_T_134 | _state_T_136 | _state_T_138 | _state_T_139
           | _state_T_140 | _state_T_141 | _state_T_145 | _state_T_146 | _state_T_147
           | _state_T_148 | _state_T_149 | _state_c_cat_T_93 | _state_c_cat_T_95,
         new_coh_state};	// Cat.scala:30:58, Consts.scala:82:{32,49,66,76}, :83:{54,64,71}, mshrs.scala:115:24, package.scala:15:47
      _GEN_41 = {1'h0, _GEN_40 == 4'hC};	// Cat.scala:30:58, Misc.scala:34:36, :48:20, mshrs.scala:109:20, package.scala:15:47
      _GEN_42 =
        {{2'h3},
         {2'h3},
         {2'h2},
         {_GEN_41},
         {_GEN_41},
         {_GEN_41},
         {_GEN_41},
         {_GEN_41},
         {2'h3},
         {2'h2},
         {2'h2},
         {2'h1},
         {2'h3},
         {2'h2},
         {2'h1},
         {2'h0}};	// Cat.scala:30:58, Metadata.scala:160:16, Misc.scala:34:36, :48:20, Mux.scala:80:57
      _GEN_43 =
        _rpq_io_enq_valid_T_1
        & (_GEN_37 == 4'h3 | _GEN_37 == 4'h2 | _GEN_37 == 4'h1 | _GEN_37 == 4'h7
           | _GEN_37 == 4'h6 | (&_GEN_37) | _GEN_37 == 4'hE)
        & (_GEN_40 == 4'h3 | _GEN_40 == 4'h2 | _GEN_40 == 4'h1 | _GEN_40 == 4'h7
           | _GEN_40 == 4'h6 | (&_GEN_40) | _GEN_40 == 4'hE);	// Cat.scala:30:58, Misc.scala:34:9, :48:20, mshrs.scala:115:24, :133:78, :172:43, :174:25, :175:15, package.scala:15:47
      if (|state) begin	// mshrs.scala:107:22, package.scala:15:47
        if (_io_probe_rdy_T_2) begin	// package.scala:15:47
          if (io_mem_acquire_ready & _io_mem_acquire_valid_output)	// Decoupled.scala:40:37, mshrs.scala:159:26, :204:30, :211:40
            state <= 5'h2;	// mshrs.scala:107:22
          if (_GEN_43) begin	// mshrs.scala:115:24, :172:43, :174:25, :175:15
            if (&dirties_cat)	// Cat.scala:30:58, Metadata.scala:105:42
              new_coh_state <= _GEN_42[_GEN_40];	// Cat.scala:30:58, Misc.scala:34:36, :48:20, mshrs.scala:115:24
            else	// Metadata.scala:105:42
              new_coh_state <= _GEN_39[_GEN_37];	// Cat.scala:30:58, Misc.scala:34:36, :48:20, mshrs.scala:115:24
          end
        end
        else if (_io_probe_rdy_T_3) begin	// package.scala:15:47
          if (refill_done) begin	// Edges.scala:232:22
            automatic logic [3:0] _coh_on_grant_T;	// Cat.scala:30:58
            _coh_on_grant_T =
              {_needs_second_acq_T_27 | _needs_second_acq_T_28 | _needs_second_acq_T_30
                 | _needs_second_acq_T_32 | _needs_second_acq_T_33
                 | _needs_second_acq_T_34 | _needs_second_acq_T_35
                 | _needs_second_acq_T_39 | _needs_second_acq_T_40
                 | _needs_second_acq_T_41 | _needs_second_acq_T_42
                 | _needs_second_acq_T_43,
               _needs_second_acq_T_27 | _needs_second_acq_T_28 | _needs_second_acq_T_30
                 | _needs_second_acq_T_32 | _needs_second_acq_T_33
                 | _needs_second_acq_T_34 | _needs_second_acq_T_35
                 | _needs_second_acq_T_39 | _needs_second_acq_T_40
                 | _needs_second_acq_T_41 | _needs_second_acq_T_42
                 | _needs_second_acq_T_43 | _needs_second_acq_T_50
                 | _needs_second_acq_T_52,
               io_mem_grant_bits_param};	// Cat.scala:30:58, Consts.scala:82:{32,49,66,76}, :83:{54,64,71}, package.scala:15:47
            if (grant_had_data)	// mshrs.scala:141:27
              state <= 5'h3;	// mshrs.scala:107:22
            else	// mshrs.scala:141:27
              state <= 5'hC;	// mshrs.scala:107:22
            if (_coh_on_grant_T == 4'hC)	// Cat.scala:30:58, Mux.scala:80:60, package.scala:15:47
              new_coh_state <= 2'h3;	// Cat.scala:30:58, mshrs.scala:115:24
            else if (_coh_on_grant_T == 4'h4 | _coh_on_grant_T == 4'h0)	// Cat.scala:30:58, Misc.scala:55:20, Mux.scala:80:{57,60}
              new_coh_state <= 2'h2;	// Mux.scala:80:57, mshrs.scala:115:24
            else	// Mux.scala:80:57
              new_coh_state <= {1'h0, _coh_on_grant_T == 4'h1};	// Cat.scala:30:58, Mux.scala:80:{57,60}, mshrs.scala:109:20, :115:24
          end
          else if (_GEN_43) begin	// mshrs.scala:115:24, :172:43, :174:25, :175:15
            if (&dirties_cat)	// Cat.scala:30:58, Metadata.scala:105:42
              new_coh_state <= _GEN_42[_GEN_40];	// Cat.scala:30:58, Misc.scala:34:36, :48:20, mshrs.scala:115:24
            else	// Metadata.scala:105:42
              new_coh_state <= _GEN_39[_GEN_37];	// Cat.scala:30:58, Misc.scala:34:36, :48:20, mshrs.scala:115:24
          end
        end
        else begin	// package.scala:15:47
          automatic logic [3:0] _GEN_44;	// Cat.scala:30:58
          automatic logic       is_hit_1;	// Misc.scala:34:9
          _GEN_44 =
            {_state_T_133 | _state_T_134 | _state_T_136 | _state_T_138 | _state_T_139
               | _state_T_140 | _state_T_141 | _state_T_145 | _state_T_146 | _state_T_147
               | _state_T_148 | _state_T_149,
             _state_T_133 | _state_T_134 | _state_T_136 | _state_T_138 | _state_T_139
               | _state_T_140 | _state_T_141 | _state_T_145 | _state_T_146 | _state_T_147
               | _state_T_148 | _state_T_149 | _state_c_cat_T_93 | _state_c_cat_T_95,
             new_coh_state};	// Cat.scala:30:58, Consts.scala:82:{32,49,66,76}, :83:{54,64,71}, mshrs.scala:115:24, package.scala:15:47
          is_hit_1 =
            _GEN_44 == 4'h3 | _GEN_44 == 4'h2 | _GEN_44 == 4'h1 | _GEN_44 == 4'h7
            | _GEN_44 == 4'h6 | (&_GEN_44) | _GEN_44 == 4'hE;	// Cat.scala:30:58, Misc.scala:34:9, :48:20, package.scala:15:47
          if (_io_probe_rdy_T_4) begin	// package.scala:15:47
            if (~_GEN_30) begin	// Decoupled.scala:40:37
              if (_GEN_31) begin	// mshrs.scala:271:31
                if (~_GEN_32)	// Decoupled.scala:40:37
                  state <= 5'hE;	// mshrs.scala:107:22
              end
              else if (_rpq_io_empty | _rpq_io_deq_valid & ~drain_load)	// mshrs.scala:128:19, :247:60, :277:{31,52,55}
                state <= 5'h4;	// mshrs.scala:107:22
            end
          end
          else if (_io_probe_rdy_T_8) begin	// mshrs.scala:148:129
            if (io_meta_read_ready & _io_meta_read_valid_output)	// Decoupled.scala:40:37, mshrs.scala:167:26, :204:30, :211:40, :222:41, :245:45, :283:39
              state <= 5'h5;	// mshrs.scala:107:22
          end
          else if (_GEN_3)	// mshrs.scala:291:22
            state <= 5'h6;	// mshrs.scala:107:22
          else if (_GEN_4) begin	// mshrs.scala:293:22
            if (io_meta_resp_valid) begin
              if (&io_meta_resp_bits_coh_state)	// Misc.scala:55:20
                state <= 5'h7;	// mshrs.scala:107:22
              else	// Misc.scala:55:20
                state <= 5'hB;	// mshrs.scala:107:22
            end
            else
              state <= 5'h4;	// mshrs.scala:107:22
          end
          else if (_GEN_5) begin	// mshrs.scala:297:22
            if (_GEN_28)	// Decoupled.scala:40:37
              state <= 5'h9;	// mshrs.scala:107:22
          end
          else if (_GEN_6) begin	// mshrs.scala:307:22
            if (io_wb_req_ready & _io_wb_req_valid_output)	// Decoupled.scala:40:37, mshrs.scala:162:26, :204:30, :211:40, :222:41, :245:45, :283:39, :291:41, :293:41, :297:40, :307:36
              state <= 5'hA;	// mshrs.scala:107:22
          end
          else if (_GEN_7) begin	// mshrs.scala:319:22
            if (io_wb_resp)
              state <= 5'hB;	// mshrs.scala:107:22
          end
          else if (_GEN_8) begin	// mshrs.scala:323:22
            if (_GEN_33 & (&refill_ctr))	// Decoupled.scala:40:37, mshrs.scala:107:22, :139:24, :333:29, :335:{24,52}, :336:15
              state <= 5'hC;	// mshrs.scala:107:22
          end
          else if (_GEN_11) begin	// mshrs.scala:339:22
            if (_rpq_io_empty & ~_rpq_io_enq_valid_T_7)	// mshrs.scala:128:19, :133:98, :349:{24,27}
              state <= 5'hD;	// mshrs.scala:107:22
          end
          else if (_sec_rdy_T_4) begin	// package.scala:15:47
            if (_GEN_28)	// Decoupled.scala:40:37
              state <= 5'hE;	// mshrs.scala:107:22
          end
          else if (_sec_rdy_T_5) begin	// package.scala:15:47
            if (_GEN_34)	// mshrs.scala:365:32
              state <= 5'hF;	// mshrs.scala:107:22
          end
          else if (_sec_rdy_T_6) begin	// package.scala:15:47
            if (finish_to_prefetch)	// mshrs.scala:142:31
              state <= 5'h11;	// mshrs.scala:107:22
            else	// mshrs.scala:142:31
              state <= 5'h0;	// mshrs.scala:107:22
          end
          else if (_io_way_valid_T_1) begin	// package.scala:15:47
            if (_GEN_23)	// mshrs.scala:373:47
              state <= 5'h0;	// mshrs.scala:107:22
            else if (_rpq_io_enq_valid_T_1) begin	// mshrs.scala:133:78
              if (is_hit_1)	// Misc.scala:34:9
                state <= 5'h4;	// mshrs.scala:107:22
              else	// Misc.scala:34:9
                state <= 5'h1;	// mshrs.scala:107:22
            end
            else if (_rpq_io_enq_valid_T) begin	// mshrs.scala:133:40
              if (io_req_tag_match & state_is_hit_1)	// Misc.scala:34:9, mshrs.scala:187:29, :189:21, :192:21, :195:21, :199:19
                state <= 5'hC;	// mshrs.scala:107:22
              else	// mshrs.scala:187:29, :189:21, :192:21, :195:21, :199:19
                state <= 5'h1;	// mshrs.scala:107:22
            end
          end
          if (_GEN_13) begin	// mshrs.scala:161:26, :245:45, :283:39, :291:41, :293:41, :297:40, :307:36, :319:37, :323:41, :339:39
            if (_GEN_43) begin	// mshrs.scala:115:24, :172:43, :174:25, :175:15
              if (&dirties_cat)	// Cat.scala:30:58, Metadata.scala:105:42
                new_coh_state <= _GEN_42[_GEN_40];	// Cat.scala:30:58, Misc.scala:34:36, :48:20, mshrs.scala:115:24
              else	// Metadata.scala:105:42
                new_coh_state <= _GEN_39[_GEN_37];	// Cat.scala:30:58, Misc.scala:34:36, :48:20, mshrs.scala:115:24
            end
          end
          else if (_GEN_11) begin	// mshrs.scala:339:22
            if (_GEN_15) begin	// mshrs.scala:343:28
              automatic logic [1:0]       _GEN_45 = {1'h0, _GEN_16 == 4'hC};	// Cat.scala:30:58, Misc.scala:34:36, :48:20, mshrs.scala:109:20, package.scala:15:47
              automatic logic [15:0][1:0] _GEN_46 =
                {{2'h3},
                 {2'h3},
                 {2'h2},
                 {_GEN_45},
                 {_GEN_45},
                 {_GEN_45},
                 {_GEN_45},
                 {_GEN_45},
                 {2'h3},
                 {2'h2},
                 {2'h2},
                 {2'h1},
                 {2'h3},
                 {2'h2},
                 {2'h1},
                 {2'h0}};	// Cat.scala:30:58, Metadata.scala:160:16, Misc.scala:34:36, :48:20, Mux.scala:80:57
              new_coh_state <= _GEN_46[_GEN_16];	// Cat.scala:30:58, Misc.scala:34:36, :48:20, mshrs.scala:115:24
            end
            else if (_GEN_43) begin	// mshrs.scala:115:24, :172:43, :174:25, :175:15
              if (&dirties_cat)	// Cat.scala:30:58, Metadata.scala:105:42
                new_coh_state <= _GEN_42[_GEN_40];	// Cat.scala:30:58, Misc.scala:34:36, :48:20, mshrs.scala:115:24
              else	// Metadata.scala:105:42
                new_coh_state <= _GEN_39[_GEN_37];	// Cat.scala:30:58, Misc.scala:34:36, :48:20, mshrs.scala:115:24
            end
          end
          else if (_GEN_19 | ~_io_way_valid_T_1 | _GEN_23) begin	// mshrs.scala:141:27, :157:26, :172:43, :352:44, :362:42, :369:42, :371:38, :373:{47,69}, package.scala:15:47
            if (_GEN_43) begin	// mshrs.scala:115:24, :172:43, :174:25, :175:15
              if (&dirties_cat)	// Cat.scala:30:58, Metadata.scala:105:42
                new_coh_state <= _GEN_42[_GEN_40];	// Cat.scala:30:58, Misc.scala:34:36, :48:20, mshrs.scala:115:24
              else	// Metadata.scala:105:42
                new_coh_state <= _GEN_39[_GEN_37];	// Cat.scala:30:58, Misc.scala:34:36, :48:20, mshrs.scala:115:24
            end
          end
          else if (_rpq_io_enq_valid_T_1) begin	// mshrs.scala:133:78
            if (is_hit_1) begin	// Misc.scala:34:9
              automatic logic [1:0]       _GEN_47;	// Misc.scala:34:36
              automatic logic [15:0][1:0] _GEN_48;	// Misc.scala:34:36, :48:20
              _GEN_47 = {1'h0, _GEN_44 == 4'hC};	// Cat.scala:30:58, Misc.scala:34:36, :48:20, mshrs.scala:109:20, package.scala:15:47
              _GEN_48 =
                {{2'h3},
                 {2'h3},
                 {2'h2},
                 {_GEN_47},
                 {_GEN_47},
                 {_GEN_47},
                 {_GEN_47},
                 {_GEN_47},
                 {2'h3},
                 {2'h2},
                 {2'h2},
                 {2'h1},
                 {2'h3},
                 {2'h2},
                 {2'h1},
                 {2'h0}};	// Cat.scala:30:58, Metadata.scala:160:16, Misc.scala:34:36, :48:20, Mux.scala:80:57
              new_coh_state <= _GEN_48[_GEN_44];	// Cat.scala:30:58, Misc.scala:34:36, :48:20, mshrs.scala:115:24
            end
            else	// Misc.scala:34:9
              new_coh_state <= 2'h0;	// Metadata.scala:160:16, mshrs.scala:115:24
          end
          else if (_rpq_io_enq_valid_T) begin	// mshrs.scala:133:40
            if (io_req_tag_match) begin
              if (state_is_hit_1) begin	// Misc.scala:34:9
                automatic logic [1:0]       _state_T_100 = {1'h0, _state_T_85 == 4'hC};	// Cat.scala:30:58, Misc.scala:34:36, :48:20, mshrs.scala:109:20, package.scala:15:47
                automatic logic [15:0][1:0] _GEN_49 =
                  {{2'h3},
                   {2'h3},
                   {2'h2},
                   {_state_T_100},
                   {_state_T_100},
                   {_state_T_100},
                   {_state_T_100},
                   {_state_T_100},
                   {2'h3},
                   {2'h2},
                   {2'h2},
                   {2'h1},
                   {2'h3},
                   {2'h2},
                   {2'h1},
                   {2'h0}};	// Cat.scala:30:58, Metadata.scala:160:16, Misc.scala:34:36, :48:20, Mux.scala:80:57
                new_coh_state <= _GEN_49[_state_T_85];	// Cat.scala:30:58, Misc.scala:34:36, :48:20, mshrs.scala:115:24
              end
              else	// Misc.scala:34:9
                new_coh_state <= io_req_old_meta_coh_state;	// mshrs.scala:115:24
            end
            else
              new_coh_state <= 2'h0;	// Metadata.scala:160:16, mshrs.scala:115:24
          end
          else if (_GEN_43) begin	// mshrs.scala:115:24, :172:43, :174:25, :175:15
            if (&dirties_cat)	// Cat.scala:30:58, Metadata.scala:105:42
              new_coh_state <= _GEN_42[_GEN_40];	// Cat.scala:30:58, Misc.scala:34:36, :48:20, mshrs.scala:115:24
            else	// Metadata.scala:105:42
              new_coh_state <= _GEN_39[_GEN_37];	// Cat.scala:30:58, Misc.scala:34:36, :48:20, mshrs.scala:115:24
          end
        end
        if (_GEN_36) begin	// mshrs.scala:109:20, :113:29, :211:40, :222:41, :245:45, :283:39, :291:41, :293:41, :297:40, :307:36, :319:37, :323:41, :339:39, :352:44, :362:42, :369:42, :371:38
        end
        else	// mshrs.scala:113:29, :211:40, :222:41, :245:45, :283:39, :291:41, :293:41, :297:40, :307:36, :319:37, :323:41, :339:39, :352:44, :362:42, :369:42, :371:38
          req_needs_wb <= &io_req_old_meta_coh_state;	// Misc.scala:55:20, mshrs.scala:113:29
      end
      else if (_rpq_io_enq_valid_T) begin	// mshrs.scala:133:40
        if (io_req_tag_match & state_is_hit)	// Misc.scala:34:9, mshrs.scala:187:29, :189:21, :192:21, :195:21, :199:19
          state <= 5'hC;	// mshrs.scala:107:22
        else	// mshrs.scala:187:29, :189:21, :192:21, :195:21, :199:19
          state <= 5'h1;	// mshrs.scala:107:22
        req_needs_wb <= &io_req_old_meta_coh_state;	// Misc.scala:55:20, mshrs.scala:113:29
        if (io_req_tag_match) begin
          if (state_is_hit) begin	// Misc.scala:34:9
            automatic logic [1:0]       _state_T_18 = {1'h0, _state_T_3 == 4'hC};	// Cat.scala:30:58, Misc.scala:34:36, :48:20, mshrs.scala:109:20, package.scala:15:47
            automatic logic [15:0][1:0] _GEN_50 =
              {{2'h3},
               {2'h3},
               {2'h2},
               {_state_T_18},
               {_state_T_18},
               {_state_T_18},
               {_state_T_18},
               {_state_T_18},
               {2'h3},
               {2'h2},
               {2'h2},
               {2'h1},
               {2'h3},
               {2'h2},
               {2'h1},
               {2'h0}};	// Cat.scala:30:58, Metadata.scala:160:16, Misc.scala:34:36, :48:20, Mux.scala:80:57
            new_coh_state <= _GEN_50[_state_T_3];	// Cat.scala:30:58, Misc.scala:34:36, :48:20, mshrs.scala:115:24
          end
          else	// Misc.scala:34:9
            new_coh_state <= io_req_old_meta_coh_state;	// mshrs.scala:115:24
        end
        else
          new_coh_state <= 2'h0;	// Metadata.scala:160:16, mshrs.scala:115:24
      end
      else if (_GEN_43) begin	// mshrs.scala:115:24, :172:43, :174:25, :175:15
        if (&dirties_cat)	// Cat.scala:30:58, Metadata.scala:105:42
          new_coh_state <= _GEN_42[_GEN_40];	// Cat.scala:30:58, Misc.scala:34:36, :48:20, mshrs.scala:115:24
        else	// Metadata.scala:105:42
          new_coh_state <= _GEN_39[_GEN_37];	// Cat.scala:30:58, Misc.scala:34:36, :48:20, mshrs.scala:115:24
      end
      if (_GEN_0) begin	// Decoupled.scala:40:37
        if (counter == 9'h0) begin	// Edges.scala:228:27, :230:25
          if (io_mem_grant_bits_opcode[0])	// Edges.scala:105:36
            counter <= ~(_beats1_decode_T_1[11:3]);	// Edges.scala:228:27, package.scala:234:{46,77,82}
          else	// Edges.scala:105:36
            counter <= 9'h0;	// Edges.scala:228:27
        end
        else	// Edges.scala:230:25
          counter <= _counter1_T;	// Edges.scala:228:27, :229:28
      end
      if (_GEN_28)	// Decoupled.scala:40:37
        meta_hazard <= 2'h1;	// Mux.scala:80:57, mshrs.scala:145:28
      else if (|meta_hazard)	// mshrs.scala:145:28, :146:21
        meta_hazard <= meta_hazard + 2'h1;	// Mux.scala:80:57, mshrs.scala:145:28, :146:59
    end
    if ((|state)
          ? ~_GEN_22 & _io_way_valid_T_1 & ~_GEN_35 & _rpq_io_enq_valid_T | _GEN_29
          : _rpq_io_enq_valid_T | _GEN_29)	// Metadata.scala:108:27, mshrs.scala:107:22, :109:20, :133:40, :141:27, :157:26, :172:43, :173:21, :184:9, :204:30, :208:45, :211:40, :222:41, :245:45, :283:39, :291:41, :293:41, :297:40, :307:36, :319:37, :323:41, :339:39, :352:44, :362:42, :369:42, :371:38, :373:69, :375:52, :384:52, package.scala:15:47
      req_uop_mem_cmd <= io_req_uop_mem_cmd;	// mshrs.scala:109:20
    if (|state) begin	// mshrs.scala:107:22, package.scala:15:47
      if (_GEN_36) begin	// mshrs.scala:109:20, :211:40, :222:41, :245:45, :283:39, :291:41, :293:41, :297:40, :307:36, :319:37, :323:41, :339:39, :352:44, :362:42, :369:42, :371:38
      end
      else begin	// mshrs.scala:109:20, :211:40, :222:41, :245:45, :283:39, :291:41, :293:41, :297:40, :307:36, :319:37, :323:41, :339:39, :352:44, :362:42, :369:42, :371:38
        req_addr <= io_req_addr;	// mshrs.scala:109:20
        req_old_meta_coh_state <= io_req_old_meta_coh_state;	// mshrs.scala:109:20
        req_old_meta_tag <= io_req_old_meta_tag;	// mshrs.scala:109:20
        req_way_en <= io_req_way_en;	// mshrs.scala:109:20
      end
      if (~_io_probe_rdy_T_2) begin	// package.scala:15:47
        if (_io_probe_rdy_T_3) begin	// package.scala:15:47
          if (refill_done)	// Edges.scala:232:22
            grantack_valid <=
              io_mem_grant_bits_opcode[2] & ~(io_mem_grant_bits_opcode[1]);	// Edges.scala:70:{36,40,43,52}, mshrs.scala:138:21
        end
        else if (~_GEN_18) begin	// mshrs.scala:168:26, :245:45, :283:39, :291:41, :293:41, :297:40, :307:36, :319:37, :323:41, :339:39, :352:44, :362:42
          if (_sec_rdy_T_5)	// package.scala:15:47
            grantack_valid <= ~_GEN_34 & grantack_valid;	// mshrs.scala:138:21, :365:{32,52}, :366:22
          else	// package.scala:15:47
            grantack_valid <=
              (_sec_rdy_T_6 | ~_io_way_valid_T_1 | _GEN_35 | ~_rpq_io_enq_valid_T)
              & grantack_valid;	// mshrs.scala:133:40, :138:21, :141:27, :181:20, :208:45, :369:42, :371:38, :373:69, :375:52, :384:52, package.scala:15:47
        end
      end
      if (~_GEN_10) begin	// mshrs.scala:160:26, :211:40, :222:41, :245:45, :283:39, :291:41, :293:41, :297:40, :307:36, :319:37, :323:41
        if (_GEN_8) begin	// mshrs.scala:323:22
          if (_GEN_33)	// Decoupled.scala:40:37
            refill_ctr <= refill_ctr + 3'h1;	// Misc.scala:37:36, mshrs.scala:139:24, :334:32
        end
        else if (_GEN_20 | ~_io_way_valid_T_1 | _GEN_35 | ~_rpq_io_enq_valid_T) begin	// mshrs.scala:133:40, :138:21, :139:24, :141:27, :157:26, :181:20, :208:45, :339:39, :352:44, :362:42, :369:42, :371:38, :373:69, :375:52, :384:52, package.scala:15:47
        end
        else	// mshrs.scala:139:24, :339:39, :352:44, :362:42, :369:42, :371:38
          refill_ctr <= 3'h0;	// Misc.scala:37:36, mshrs.scala:139:24
      end
    end
    else begin	// package.scala:15:47
      if (_rpq_io_enq_valid_T) begin	// mshrs.scala:133:40
        req_addr <= io_req_addr;	// mshrs.scala:109:20
        req_old_meta_coh_state <= io_req_old_meta_coh_state;	// mshrs.scala:109:20
        req_old_meta_tag <= io_req_old_meta_tag;	// mshrs.scala:109:20
        req_way_en <= io_req_way_en;	// mshrs.scala:109:20
        refill_ctr <= 3'h0;	// Misc.scala:37:36, mshrs.scala:139:24
      end
      grantack_valid <= ~_rpq_io_enq_valid_T & grantack_valid;	// mshrs.scala:133:40, :138:21, :181:20, :208:45
    end
    if (_GEN_1 | ~(_io_probe_rdy_T_3 & refill_done)) begin	// Edges.scala:232:22, mshrs.scala:138:21, :169:26, :204:30, :211:40, :222:41, :236:24, :238:21, package.scala:15:47
    end
    else	// mshrs.scala:138:21, :204:30, :211:40, :222:41
      grantack_bits_sink <= io_mem_grant_bits_sink;	// mshrs.scala:138:21
    if (~_GEN_1) begin	// mshrs.scala:169:26, :204:30, :211:40, :222:41
      if (_io_probe_rdy_T_3)	// package.scala:15:47
        commit_line <= ~refill_done & commit_line;	// Edges.scala:232:22, mshrs.scala:140:24, :236:24, :241:19
      else	// package.scala:15:47
        commit_line <= _io_probe_rdy_T_4 & _GEN_30 | commit_line;	// Decoupled.scala:40:37, mshrs.scala:140:24, :245:45, :268:30, :269:21, package.scala:15:47
    end
    grant_had_data <=
      (|state)
      & (_io_probe_rdy_T_2
           ? grant_had_data
           : _io_probe_rdy_T_3
               ? (_GEN_0 ? io_mem_grant_bits_opcode[0] : grant_had_data)
               : (_GEN_21 | ~_io_way_valid_T_1 | _GEN_35 | ~_rpq_io_enq_valid_T)
                 & grant_had_data);	// Decoupled.scala:40:37, Edges.scala:105:36, mshrs.scala:107:22, :133:40, :138:21, :141:27, :157:26, :181:20, :204:30, :206:20, :208:45, :211:40, :222:41, :233:32, :234:22, :245:45, :283:39, :291:41, :293:41, :297:40, :307:36, :319:37, :323:41, :339:39, :352:44, :362:42, :369:42, :371:38, :373:69, :375:52, :384:52, package.scala:15:47
    if (~_GEN_2) begin	// mshrs.scala:163:26, :204:30, :211:40, :222:41, :245:45
      if (_io_probe_rdy_T_4)	// package.scala:15:47
        finish_to_prefetch <= (_GEN_30 | ~(_GEN_31 & ~_GEN_32)) & finish_to_prefetch;	// Decoupled.scala:40:37, mshrs.scala:142:31, :268:30, :271:31, :272:5, :273:{13,33}, :275:28
      else	// package.scala:15:47
        finish_to_prefetch <=
          (_io_probe_rdy_T_8 | _GEN_3 | _GEN_4 | _GEN_5 | _GEN_17
           | ~(_sec_rdy_T_4 & _GEN_28)) & finish_to_prefetch;	// Decoupled.scala:40:37, mshrs.scala:142:31, :148:129, :156:26, :283:39, :291:{22,41}, :293:{22,41}, :297:{22,40}, :307:36, :319:37, :323:41, :339:39, :352:44, :358:33, :360:26, package.scala:15:47
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:17];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [4:0] i = 5'h0; i < 5'h12; i += 5'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        state = _RANDOM[5'h0][4:0];	// mshrs.scala:107:22
        req_uop_mem_cmd = {_RANDOM[5'hA][31:28], _RANDOM[5'hB][0]};	// mshrs.scala:109:20
        req_addr = {_RANDOM[5'hC][31:24], _RANDOM[5'hD]};	// mshrs.scala:109:20
        req_old_meta_coh_state = _RANDOM[5'h10][3:2];	// mshrs.scala:109:20
        req_old_meta_tag = _RANDOM[5'h10][23:4];	// mshrs.scala:109:20
        req_way_en = _RANDOM[5'h10][27:24];	// mshrs.scala:109:20
        req_needs_wb = _RANDOM[5'h11][1];	// mshrs.scala:113:29
        new_coh_state = _RANDOM[5'h11][3:2];	// mshrs.scala:113:29, :115:24
        counter = _RANDOM[5'h11][12:4];	// Edges.scala:228:27, mshrs.scala:113:29
        grantack_valid = _RANDOM[5'h11][13];	// mshrs.scala:113:29, :138:21
        grantack_bits_sink = _RANDOM[5'h11][16:14];	// mshrs.scala:113:29, :138:21
        refill_ctr = _RANDOM[5'h11][19:17];	// mshrs.scala:113:29, :139:24
        commit_line = _RANDOM[5'h11][20];	// mshrs.scala:113:29, :140:24
        grant_had_data = _RANDOM[5'h11][21];	// mshrs.scala:113:29, :141:27
        finish_to_prefetch = _RANDOM[5'h11][22];	// mshrs.scala:113:29, :142:31
        meta_hazard = _RANDOM[5'h11][24:23];	// mshrs.scala:113:29, :145:28
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  BranchKillableQueue_20 rpq (	// mshrs.scala:128:19
    .clock                           (clock),
    .reset                           (reset),
    .io_enq_valid                    (_rpq_io_enq_valid_T_7),	// mshrs.scala:133:98
    .io_enq_bits_uop_uopc            (io_req_uop_uopc),
    .io_enq_bits_uop_inst            (io_req_uop_inst),
    .io_enq_bits_uop_debug_inst      (io_req_uop_debug_inst),
    .io_enq_bits_uop_is_rvc          (io_req_uop_is_rvc),
    .io_enq_bits_uop_debug_pc        (io_req_uop_debug_pc),
    .io_enq_bits_uop_iq_type         (io_req_uop_iq_type),
    .io_enq_bits_uop_fu_code         (io_req_uop_fu_code),
    .io_enq_bits_uop_ctrl_br_type    (io_req_uop_ctrl_br_type),
    .io_enq_bits_uop_ctrl_op1_sel    (io_req_uop_ctrl_op1_sel),
    .io_enq_bits_uop_ctrl_op2_sel    (io_req_uop_ctrl_op2_sel),
    .io_enq_bits_uop_ctrl_imm_sel    (io_req_uop_ctrl_imm_sel),
    .io_enq_bits_uop_ctrl_op_fcn     (io_req_uop_ctrl_op_fcn),
    .io_enq_bits_uop_ctrl_fcn_dw     (io_req_uop_ctrl_fcn_dw),
    .io_enq_bits_uop_ctrl_csr_cmd    (io_req_uop_ctrl_csr_cmd),
    .io_enq_bits_uop_ctrl_is_load    (io_req_uop_ctrl_is_load),
    .io_enq_bits_uop_ctrl_is_sta     (io_req_uop_ctrl_is_sta),
    .io_enq_bits_uop_ctrl_is_std     (io_req_uop_ctrl_is_std),
    .io_enq_bits_uop_iw_state        (io_req_uop_iw_state),
    .io_enq_bits_uop_iw_p1_poisoned  (io_req_uop_iw_p1_poisoned),
    .io_enq_bits_uop_iw_p2_poisoned  (io_req_uop_iw_p2_poisoned),
    .io_enq_bits_uop_is_br           (io_req_uop_is_br),
    .io_enq_bits_uop_is_jalr         (io_req_uop_is_jalr),
    .io_enq_bits_uop_is_jal          (io_req_uop_is_jal),
    .io_enq_bits_uop_is_sfb          (io_req_uop_is_sfb),
    .io_enq_bits_uop_br_mask         (io_req_uop_br_mask),
    .io_enq_bits_uop_br_tag          (io_req_uop_br_tag),
    .io_enq_bits_uop_ftq_idx         (io_req_uop_ftq_idx),
    .io_enq_bits_uop_edge_inst       (io_req_uop_edge_inst),
    .io_enq_bits_uop_pc_lob          (io_req_uop_pc_lob),
    .io_enq_bits_uop_taken           (io_req_uop_taken),
    .io_enq_bits_uop_imm_packed      (io_req_uop_imm_packed),
    .io_enq_bits_uop_csr_addr        (io_req_uop_csr_addr),
    .io_enq_bits_uop_rob_idx         (io_req_uop_rob_idx),
    .io_enq_bits_uop_ldq_idx         (io_req_uop_ldq_idx),
    .io_enq_bits_uop_stq_idx         (io_req_uop_stq_idx),
    .io_enq_bits_uop_rxq_idx         (io_req_uop_rxq_idx),
    .io_enq_bits_uop_pdst            (io_req_uop_pdst),
    .io_enq_bits_uop_prs1            (io_req_uop_prs1),
    .io_enq_bits_uop_prs2            (io_req_uop_prs2),
    .io_enq_bits_uop_prs3            (io_req_uop_prs3),
    .io_enq_bits_uop_ppred           (io_req_uop_ppred),
    .io_enq_bits_uop_prs1_busy       (io_req_uop_prs1_busy),
    .io_enq_bits_uop_prs2_busy       (io_req_uop_prs2_busy),
    .io_enq_bits_uop_prs3_busy       (io_req_uop_prs3_busy),
    .io_enq_bits_uop_ppred_busy      (io_req_uop_ppred_busy),
    .io_enq_bits_uop_stale_pdst      (io_req_uop_stale_pdst),
    .io_enq_bits_uop_exception       (io_req_uop_exception),
    .io_enq_bits_uop_exc_cause       (io_req_uop_exc_cause),
    .io_enq_bits_uop_bypassable      (io_req_uop_bypassable),
    .io_enq_bits_uop_mem_cmd         (io_req_uop_mem_cmd),
    .io_enq_bits_uop_mem_size        (io_req_uop_mem_size),
    .io_enq_bits_uop_mem_signed      (io_req_uop_mem_signed),
    .io_enq_bits_uop_is_fence        (io_req_uop_is_fence),
    .io_enq_bits_uop_is_fencei       (io_req_uop_is_fencei),
    .io_enq_bits_uop_is_amo          (io_req_uop_is_amo),
    .io_enq_bits_uop_uses_ldq        (io_req_uop_uses_ldq),
    .io_enq_bits_uop_uses_stq        (io_req_uop_uses_stq),
    .io_enq_bits_uop_is_sys_pc2epc   (io_req_uop_is_sys_pc2epc),
    .io_enq_bits_uop_is_unique       (io_req_uop_is_unique),
    .io_enq_bits_uop_flush_on_commit (io_req_uop_flush_on_commit),
    .io_enq_bits_uop_ldst_is_rs1     (io_req_uop_ldst_is_rs1),
    .io_enq_bits_uop_ldst            (io_req_uop_ldst),
    .io_enq_bits_uop_lrs1            (io_req_uop_lrs1),
    .io_enq_bits_uop_lrs2            (io_req_uop_lrs2),
    .io_enq_bits_uop_lrs3            (io_req_uop_lrs3),
    .io_enq_bits_uop_ldst_val        (io_req_uop_ldst_val),
    .io_enq_bits_uop_dst_rtype       (io_req_uop_dst_rtype),
    .io_enq_bits_uop_lrs1_rtype      (io_req_uop_lrs1_rtype),
    .io_enq_bits_uop_lrs2_rtype      (io_req_uop_lrs2_rtype),
    .io_enq_bits_uop_frs3_en         (io_req_uop_frs3_en),
    .io_enq_bits_uop_fp_val          (io_req_uop_fp_val),
    .io_enq_bits_uop_fp_single       (io_req_uop_fp_single),
    .io_enq_bits_uop_xcpt_pf_if      (io_req_uop_xcpt_pf_if),
    .io_enq_bits_uop_xcpt_ae_if      (io_req_uop_xcpt_ae_if),
    .io_enq_bits_uop_xcpt_ma_if      (io_req_uop_xcpt_ma_if),
    .io_enq_bits_uop_bp_debug_if     (io_req_uop_bp_debug_if),
    .io_enq_bits_uop_bp_xcpt_if      (io_req_uop_bp_xcpt_if),
    .io_enq_bits_uop_debug_fsrc      (io_req_uop_debug_fsrc),
    .io_enq_bits_uop_debug_tsrc      (io_req_uop_debug_tsrc),
    .io_enq_bits_addr                (io_req_addr),
    .io_enq_bits_data                (io_req_data),
    .io_enq_bits_is_hella            (io_req_is_hella),
    .io_enq_bits_tag_match           (io_req_tag_match),
    .io_enq_bits_old_meta_coh_state  (io_req_old_meta_coh_state),
    .io_enq_bits_old_meta_tag        (io_req_old_meta_tag),
    .io_enq_bits_way_en              (io_req_way_en),
    .io_enq_bits_sdq_id              (io_req_sdq_id),
    .io_deq_ready                    (_GEN_14),	// mshrs.scala:135:20, :204:30, :211:40, :222:41, :245:45
    .io_brupdate_b1_resolve_mask     (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask  (io_brupdate_b1_mispredict_mask),
    .io_flush                        (io_exception),
    .io_enq_ready                    (_rpq_io_enq_ready),
    .io_deq_valid                    (_rpq_io_deq_valid),
    .io_deq_bits_uop_uopc            (_rpq_io_deq_bits_uop_uopc),
    .io_deq_bits_uop_inst            (_rpq_io_deq_bits_uop_inst),
    .io_deq_bits_uop_debug_inst      (_rpq_io_deq_bits_uop_debug_inst),
    .io_deq_bits_uop_is_rvc          (_rpq_io_deq_bits_uop_is_rvc),
    .io_deq_bits_uop_debug_pc        (_rpq_io_deq_bits_uop_debug_pc),
    .io_deq_bits_uop_iq_type         (_rpq_io_deq_bits_uop_iq_type),
    .io_deq_bits_uop_fu_code         (_rpq_io_deq_bits_uop_fu_code),
    .io_deq_bits_uop_ctrl_br_type    (_rpq_io_deq_bits_uop_ctrl_br_type),
    .io_deq_bits_uop_ctrl_op1_sel    (_rpq_io_deq_bits_uop_ctrl_op1_sel),
    .io_deq_bits_uop_ctrl_op2_sel    (_rpq_io_deq_bits_uop_ctrl_op2_sel),
    .io_deq_bits_uop_ctrl_imm_sel    (_rpq_io_deq_bits_uop_ctrl_imm_sel),
    .io_deq_bits_uop_ctrl_op_fcn     (_rpq_io_deq_bits_uop_ctrl_op_fcn),
    .io_deq_bits_uop_ctrl_fcn_dw     (_rpq_io_deq_bits_uop_ctrl_fcn_dw),
    .io_deq_bits_uop_ctrl_csr_cmd    (_rpq_io_deq_bits_uop_ctrl_csr_cmd),
    .io_deq_bits_uop_ctrl_is_load    (_rpq_io_deq_bits_uop_ctrl_is_load),
    .io_deq_bits_uop_ctrl_is_sta     (_rpq_io_deq_bits_uop_ctrl_is_sta),
    .io_deq_bits_uop_ctrl_is_std     (_rpq_io_deq_bits_uop_ctrl_is_std),
    .io_deq_bits_uop_iw_state        (_rpq_io_deq_bits_uop_iw_state),
    .io_deq_bits_uop_iw_p1_poisoned  (_rpq_io_deq_bits_uop_iw_p1_poisoned),
    .io_deq_bits_uop_iw_p2_poisoned  (_rpq_io_deq_bits_uop_iw_p2_poisoned),
    .io_deq_bits_uop_is_br           (_rpq_io_deq_bits_uop_is_br),
    .io_deq_bits_uop_is_jalr         (_rpq_io_deq_bits_uop_is_jalr),
    .io_deq_bits_uop_is_jal          (_rpq_io_deq_bits_uop_is_jal),
    .io_deq_bits_uop_is_sfb          (_rpq_io_deq_bits_uop_is_sfb),
    .io_deq_bits_uop_br_mask         (_rpq_io_deq_bits_uop_br_mask),
    .io_deq_bits_uop_br_tag          (_rpq_io_deq_bits_uop_br_tag),
    .io_deq_bits_uop_ftq_idx         (_rpq_io_deq_bits_uop_ftq_idx),
    .io_deq_bits_uop_edge_inst       (_rpq_io_deq_bits_uop_edge_inst),
    .io_deq_bits_uop_pc_lob          (_rpq_io_deq_bits_uop_pc_lob),
    .io_deq_bits_uop_taken           (_rpq_io_deq_bits_uop_taken),
    .io_deq_bits_uop_imm_packed      (_rpq_io_deq_bits_uop_imm_packed),
    .io_deq_bits_uop_csr_addr        (_rpq_io_deq_bits_uop_csr_addr),
    .io_deq_bits_uop_rob_idx         (_rpq_io_deq_bits_uop_rob_idx),
    .io_deq_bits_uop_ldq_idx         (_rpq_io_deq_bits_uop_ldq_idx),
    .io_deq_bits_uop_stq_idx         (_rpq_io_deq_bits_uop_stq_idx),
    .io_deq_bits_uop_rxq_idx         (_rpq_io_deq_bits_uop_rxq_idx),
    .io_deq_bits_uop_pdst            (_rpq_io_deq_bits_uop_pdst),
    .io_deq_bits_uop_prs1            (_rpq_io_deq_bits_uop_prs1),
    .io_deq_bits_uop_prs2            (_rpq_io_deq_bits_uop_prs2),
    .io_deq_bits_uop_prs3            (_rpq_io_deq_bits_uop_prs3),
    .io_deq_bits_uop_ppred           (_rpq_io_deq_bits_uop_ppred),
    .io_deq_bits_uop_prs1_busy       (_rpq_io_deq_bits_uop_prs1_busy),
    .io_deq_bits_uop_prs2_busy       (_rpq_io_deq_bits_uop_prs2_busy),
    .io_deq_bits_uop_prs3_busy       (_rpq_io_deq_bits_uop_prs3_busy),
    .io_deq_bits_uop_ppred_busy      (_rpq_io_deq_bits_uop_ppred_busy),
    .io_deq_bits_uop_stale_pdst      (_rpq_io_deq_bits_uop_stale_pdst),
    .io_deq_bits_uop_exception       (_rpq_io_deq_bits_uop_exception),
    .io_deq_bits_uop_exc_cause       (_rpq_io_deq_bits_uop_exc_cause),
    .io_deq_bits_uop_bypassable      (_rpq_io_deq_bits_uop_bypassable),
    .io_deq_bits_uop_mem_cmd         (_rpq_io_deq_bits_uop_mem_cmd),
    .io_deq_bits_uop_mem_size        (_rpq_io_deq_bits_uop_mem_size),
    .io_deq_bits_uop_mem_signed      (_rpq_io_deq_bits_uop_mem_signed),
    .io_deq_bits_uop_is_fence        (_rpq_io_deq_bits_uop_is_fence),
    .io_deq_bits_uop_is_fencei       (_rpq_io_deq_bits_uop_is_fencei),
    .io_deq_bits_uop_is_amo          (_rpq_io_deq_bits_uop_is_amo),
    .io_deq_bits_uop_uses_ldq        (_rpq_io_deq_bits_uop_uses_ldq),
    .io_deq_bits_uop_uses_stq        (_rpq_io_deq_bits_uop_uses_stq),
    .io_deq_bits_uop_is_sys_pc2epc   (_rpq_io_deq_bits_uop_is_sys_pc2epc),
    .io_deq_bits_uop_is_unique       (_rpq_io_deq_bits_uop_is_unique),
    .io_deq_bits_uop_flush_on_commit (_rpq_io_deq_bits_uop_flush_on_commit),
    .io_deq_bits_uop_ldst_is_rs1     (_rpq_io_deq_bits_uop_ldst_is_rs1),
    .io_deq_bits_uop_ldst            (_rpq_io_deq_bits_uop_ldst),
    .io_deq_bits_uop_lrs1            (_rpq_io_deq_bits_uop_lrs1),
    .io_deq_bits_uop_lrs2            (_rpq_io_deq_bits_uop_lrs2),
    .io_deq_bits_uop_lrs3            (_rpq_io_deq_bits_uop_lrs3),
    .io_deq_bits_uop_ldst_val        (_rpq_io_deq_bits_uop_ldst_val),
    .io_deq_bits_uop_dst_rtype       (_rpq_io_deq_bits_uop_dst_rtype),
    .io_deq_bits_uop_lrs1_rtype      (_rpq_io_deq_bits_uop_lrs1_rtype),
    .io_deq_bits_uop_lrs2_rtype      (_rpq_io_deq_bits_uop_lrs2_rtype),
    .io_deq_bits_uop_frs3_en         (_rpq_io_deq_bits_uop_frs3_en),
    .io_deq_bits_uop_fp_val          (_rpq_io_deq_bits_uop_fp_val),
    .io_deq_bits_uop_fp_single       (_rpq_io_deq_bits_uop_fp_single),
    .io_deq_bits_uop_xcpt_pf_if      (_rpq_io_deq_bits_uop_xcpt_pf_if),
    .io_deq_bits_uop_xcpt_ae_if      (_rpq_io_deq_bits_uop_xcpt_ae_if),
    .io_deq_bits_uop_xcpt_ma_if      (_rpq_io_deq_bits_uop_xcpt_ma_if),
    .io_deq_bits_uop_bp_debug_if     (_rpq_io_deq_bits_uop_bp_debug_if),
    .io_deq_bits_uop_bp_xcpt_if      (_rpq_io_deq_bits_uop_bp_xcpt_if),
    .io_deq_bits_uop_debug_fsrc      (_rpq_io_deq_bits_uop_debug_fsrc),
    .io_deq_bits_uop_debug_tsrc      (_rpq_io_deq_bits_uop_debug_tsrc),
    .io_deq_bits_addr                (_rpq_io_deq_bits_addr),
    .io_deq_bits_is_hella            (_rpq_io_deq_bits_is_hella),
    .io_deq_bits_sdq_id              (io_replay_bits_sdq_id),
    .io_empty                        (_rpq_io_empty)
  );
  assign io_req_pri_rdy = _io_req_pri_rdy_output;	// mshrs.scala:204:30, :205:20, :211:40
  assign io_req_sec_rdy = _io_req_sec_rdy_output;	// mshrs.scala:158:37
  assign io_idx_valid = |state;	// mshrs.scala:107:22, :149:25
  assign io_idx_bits = req_addr[11:6];	// mshrs.scala:109:20, :110:25
  assign io_way_valid = ~(~(|state) | _io_way_valid_T_1);	// mshrs.scala:107:22, :151:19, package.scala:15:47, :72:59
  assign io_way_bits = req_way_en;	// mshrs.scala:109:20
  assign io_tag_valid = |state;	// mshrs.scala:107:22, :149:25
  assign io_tag_bits = req_addr[39:12];	// mshrs.scala:109:20, :111:26
  assign io_mem_acquire_valid = _io_mem_acquire_valid_output;	// mshrs.scala:159:26, :204:30, :211:40
  assign io_mem_acquire_bits_param = {1'h0, _GEN[_grow_param_T]};	// Cat.scala:30:58, Edges.scala:347:15, Misc.scala:34:36, :48:20, mshrs.scala:109:20
  assign io_mem_acquire_bits_source = {1'h0, io_id};	// Edges.scala:349:15, mshrs.scala:109:20
  assign io_mem_acquire_bits_address = {req_addr[31:6], 6'h0};	// Edges.scala:350:15, mshrs.scala:109:20, :112:51
  assign io_mem_grant_ready = _io_mem_grant_ready_output;	// mshrs.scala:223:44, :224:31, :230:31
  assign io_mem_finish_valid = _io_mem_finish_valid_output;	// mshrs.scala:168:26, :204:30, :211:40, :222:41, :245:45, :283:39, :291:41, :293:41, :297:40, :307:36, :319:37, :323:41, :339:39, :352:44, :362:42
  assign io_mem_finish_bits_sink = grantack_bits_sink;	// mshrs.scala:138:21
  assign io_refill_valid = _io_refill_valid_output;	// mshrs.scala:160:26, :204:30, :211:40, :222:41, :245:45, :283:39, :291:41, :293:41, :297:40, :307:36, :319:37, :323:41
  assign io_refill_bits_way_en = req_way_en;	// mshrs.scala:109:20
  assign io_refill_bits_addr = {req_addr[11:6], refill_ctr, 3'h0};	// Misc.scala:37:36, mshrs.scala:109:20, :139:24, :329:27
  assign io_meta_write_valid = _io_meta_write_valid_output;	// mshrs.scala:156:26, :204:30, :211:40, :222:41, :245:45, :283:39, :291:41, :293:41, :297:40
  assign io_meta_write_bits_idx = req_addr[11:6];	// mshrs.scala:109:20, :110:25
  assign io_meta_write_bits_way_en = req_way_en;	// mshrs.scala:109:20
  assign io_meta_write_bits_data_coh_state = _GEN_5 ? 2'h0 : new_coh_state;	// Metadata.scala:160:16, mshrs.scala:115:24, :297:{22,40}, :300:33, :307:36
  assign io_meta_write_bits_data_tag = req_addr[31:12];	// mshrs.scala:109:20, :111:26, :286:27
  assign io_meta_read_valid = _io_meta_read_valid_output;	// mshrs.scala:167:26, :204:30, :211:40, :222:41, :245:45, :283:39
  assign io_meta_read_bits_idx = req_addr[11:6];	// mshrs.scala:109:20, :110:25
  assign io_meta_read_bits_way_en = req_way_en;	// mshrs.scala:109:20
  assign io_meta_read_bits_tag = req_addr[31:12];	// mshrs.scala:109:20, :111:26, :286:27
  assign io_wb_req_valid = _io_wb_req_valid_output;	// mshrs.scala:162:26, :204:30, :211:40, :222:41, :245:45, :283:39, :291:41, :293:41, :297:40, :307:36
  assign io_wb_req_bits_tag = req_old_meta_tag;	// mshrs.scala:109:20
  assign io_wb_req_bits_idx = req_addr[11:6];	// mshrs.scala:109:20, :110:25
  assign io_wb_req_bits_param =
    (&req_old_meta_coh_state) | req_old_meta_coh_state == 2'h2
      ? 3'h1
      : req_old_meta_coh_state == 2'h1
          ? 3'h2
          : req_old_meta_coh_state == 2'h0 ? 3'h5 : 3'h0;	// Metadata.scala:160:16, Misc.scala:37:36, :55:20, Mux.scala:80:57, mshrs.scala:109:20
  assign io_wb_req_bits_way_en = req_way_en;	// mshrs.scala:109:20
  assign io_lb_read_valid = _io_lb_read_valid_output;	// mshrs.scala:170:26, :204:30, :211:40, :222:41, :245:45
  assign io_lb_read_bits_offset =
    _io_probe_rdy_T_4 ? _rpq_io_deq_bits_addr[5:3] : refill_ctr;	// mshrs.scala:128:19, :139:24, :245:45, :262:{28,52}, :283:39, package.scala:15:47
  assign io_lb_write_valid =
    ~_GEN_1 & _io_probe_rdy_T_3 & io_mem_grant_bits_opcode[0] & io_mem_grant_valid;	// Edges.scala:105:36, mshrs.scala:169:26, :204:30, :211:40, :222:41, package.scala:15:47
  assign io_lb_write_bits_offset = beats1[2:0] & ~(_counter1_T[2:0]);	// Edges.scala:220:14, :229:28, :233:{25,27}
  assign io_replay_valid = _io_replay_valid_output;	// mshrs.scala:161:26, :204:30, :211:40, :222:41, :245:45, :283:39, :291:41, :293:41, :297:40, :307:36, :319:37, :323:41, :339:39
  assign io_replay_bits_uop_uopc = _rpq_io_deq_bits_uop_uopc;	// mshrs.scala:128:19
  assign io_replay_bits_uop_inst = _rpq_io_deq_bits_uop_inst;	// mshrs.scala:128:19
  assign io_replay_bits_uop_debug_inst = _rpq_io_deq_bits_uop_debug_inst;	// mshrs.scala:128:19
  assign io_replay_bits_uop_is_rvc = _rpq_io_deq_bits_uop_is_rvc;	// mshrs.scala:128:19
  assign io_replay_bits_uop_debug_pc = _rpq_io_deq_bits_uop_debug_pc;	// mshrs.scala:128:19
  assign io_replay_bits_uop_iq_type = _rpq_io_deq_bits_uop_iq_type;	// mshrs.scala:128:19
  assign io_replay_bits_uop_fu_code = _rpq_io_deq_bits_uop_fu_code;	// mshrs.scala:128:19
  assign io_replay_bits_uop_ctrl_br_type = _rpq_io_deq_bits_uop_ctrl_br_type;	// mshrs.scala:128:19
  assign io_replay_bits_uop_ctrl_op1_sel = _rpq_io_deq_bits_uop_ctrl_op1_sel;	// mshrs.scala:128:19
  assign io_replay_bits_uop_ctrl_op2_sel = _rpq_io_deq_bits_uop_ctrl_op2_sel;	// mshrs.scala:128:19
  assign io_replay_bits_uop_ctrl_imm_sel = _rpq_io_deq_bits_uop_ctrl_imm_sel;	// mshrs.scala:128:19
  assign io_replay_bits_uop_ctrl_op_fcn = _rpq_io_deq_bits_uop_ctrl_op_fcn;	// mshrs.scala:128:19
  assign io_replay_bits_uop_ctrl_fcn_dw = _rpq_io_deq_bits_uop_ctrl_fcn_dw;	// mshrs.scala:128:19
  assign io_replay_bits_uop_ctrl_csr_cmd = _rpq_io_deq_bits_uop_ctrl_csr_cmd;	// mshrs.scala:128:19
  assign io_replay_bits_uop_ctrl_is_load = _rpq_io_deq_bits_uop_ctrl_is_load;	// mshrs.scala:128:19
  assign io_replay_bits_uop_ctrl_is_sta = _rpq_io_deq_bits_uop_ctrl_is_sta;	// mshrs.scala:128:19
  assign io_replay_bits_uop_ctrl_is_std = _rpq_io_deq_bits_uop_ctrl_is_std;	// mshrs.scala:128:19
  assign io_replay_bits_uop_iw_state = _rpq_io_deq_bits_uop_iw_state;	// mshrs.scala:128:19
  assign io_replay_bits_uop_iw_p1_poisoned = _rpq_io_deq_bits_uop_iw_p1_poisoned;	// mshrs.scala:128:19
  assign io_replay_bits_uop_iw_p2_poisoned = _rpq_io_deq_bits_uop_iw_p2_poisoned;	// mshrs.scala:128:19
  assign io_replay_bits_uop_is_br = _rpq_io_deq_bits_uop_is_br;	// mshrs.scala:128:19
  assign io_replay_bits_uop_is_jalr = _rpq_io_deq_bits_uop_is_jalr;	// mshrs.scala:128:19
  assign io_replay_bits_uop_is_jal = _rpq_io_deq_bits_uop_is_jal;	// mshrs.scala:128:19
  assign io_replay_bits_uop_is_sfb = _rpq_io_deq_bits_uop_is_sfb;	// mshrs.scala:128:19
  assign io_replay_bits_uop_br_mask = _rpq_io_deq_bits_uop_br_mask;	// mshrs.scala:128:19
  assign io_replay_bits_uop_br_tag = _rpq_io_deq_bits_uop_br_tag;	// mshrs.scala:128:19
  assign io_replay_bits_uop_ftq_idx = _rpq_io_deq_bits_uop_ftq_idx;	// mshrs.scala:128:19
  assign io_replay_bits_uop_edge_inst = _rpq_io_deq_bits_uop_edge_inst;	// mshrs.scala:128:19
  assign io_replay_bits_uop_pc_lob = _rpq_io_deq_bits_uop_pc_lob;	// mshrs.scala:128:19
  assign io_replay_bits_uop_taken = _rpq_io_deq_bits_uop_taken;	// mshrs.scala:128:19
  assign io_replay_bits_uop_imm_packed = _rpq_io_deq_bits_uop_imm_packed;	// mshrs.scala:128:19
  assign io_replay_bits_uop_csr_addr = _rpq_io_deq_bits_uop_csr_addr;	// mshrs.scala:128:19
  assign io_replay_bits_uop_rob_idx = _rpq_io_deq_bits_uop_rob_idx;	// mshrs.scala:128:19
  assign io_replay_bits_uop_ldq_idx = _rpq_io_deq_bits_uop_ldq_idx;	// mshrs.scala:128:19
  assign io_replay_bits_uop_stq_idx = _rpq_io_deq_bits_uop_stq_idx;	// mshrs.scala:128:19
  assign io_replay_bits_uop_rxq_idx = _rpq_io_deq_bits_uop_rxq_idx;	// mshrs.scala:128:19
  assign io_replay_bits_uop_pdst = _rpq_io_deq_bits_uop_pdst;	// mshrs.scala:128:19
  assign io_replay_bits_uop_prs1 = _rpq_io_deq_bits_uop_prs1;	// mshrs.scala:128:19
  assign io_replay_bits_uop_prs2 = _rpq_io_deq_bits_uop_prs2;	// mshrs.scala:128:19
  assign io_replay_bits_uop_prs3 = _rpq_io_deq_bits_uop_prs3;	// mshrs.scala:128:19
  assign io_replay_bits_uop_ppred = _rpq_io_deq_bits_uop_ppred;	// mshrs.scala:128:19
  assign io_replay_bits_uop_prs1_busy = _rpq_io_deq_bits_uop_prs1_busy;	// mshrs.scala:128:19
  assign io_replay_bits_uop_prs2_busy = _rpq_io_deq_bits_uop_prs2_busy;	// mshrs.scala:128:19
  assign io_replay_bits_uop_prs3_busy = _rpq_io_deq_bits_uop_prs3_busy;	// mshrs.scala:128:19
  assign io_replay_bits_uop_ppred_busy = _rpq_io_deq_bits_uop_ppred_busy;	// mshrs.scala:128:19
  assign io_replay_bits_uop_stale_pdst = _rpq_io_deq_bits_uop_stale_pdst;	// mshrs.scala:128:19
  assign io_replay_bits_uop_exception = _rpq_io_deq_bits_uop_exception;	// mshrs.scala:128:19
  assign io_replay_bits_uop_exc_cause = _rpq_io_deq_bits_uop_exc_cause;	// mshrs.scala:128:19
  assign io_replay_bits_uop_bypassable = _rpq_io_deq_bits_uop_bypassable;	// mshrs.scala:128:19
  assign io_replay_bits_uop_mem_cmd = _rpq_io_deq_bits_uop_mem_cmd;	// mshrs.scala:128:19
  assign io_replay_bits_uop_mem_size = _rpq_io_deq_bits_uop_mem_size;	// mshrs.scala:128:19
  assign io_replay_bits_uop_mem_signed = _rpq_io_deq_bits_uop_mem_signed;	// mshrs.scala:128:19
  assign io_replay_bits_uop_is_fence = _rpq_io_deq_bits_uop_is_fence;	// mshrs.scala:128:19
  assign io_replay_bits_uop_is_fencei = _rpq_io_deq_bits_uop_is_fencei;	// mshrs.scala:128:19
  assign io_replay_bits_uop_is_amo = _rpq_io_deq_bits_uop_is_amo;	// mshrs.scala:128:19
  assign io_replay_bits_uop_uses_ldq = _rpq_io_deq_bits_uop_uses_ldq;	// mshrs.scala:128:19
  assign io_replay_bits_uop_uses_stq = _rpq_io_deq_bits_uop_uses_stq;	// mshrs.scala:128:19
  assign io_replay_bits_uop_is_sys_pc2epc = _rpq_io_deq_bits_uop_is_sys_pc2epc;	// mshrs.scala:128:19
  assign io_replay_bits_uop_is_unique = _rpq_io_deq_bits_uop_is_unique;	// mshrs.scala:128:19
  assign io_replay_bits_uop_flush_on_commit = _rpq_io_deq_bits_uop_flush_on_commit;	// mshrs.scala:128:19
  assign io_replay_bits_uop_ldst_is_rs1 = _rpq_io_deq_bits_uop_ldst_is_rs1;	// mshrs.scala:128:19
  assign io_replay_bits_uop_ldst = _rpq_io_deq_bits_uop_ldst;	// mshrs.scala:128:19
  assign io_replay_bits_uop_lrs1 = _rpq_io_deq_bits_uop_lrs1;	// mshrs.scala:128:19
  assign io_replay_bits_uop_lrs2 = _rpq_io_deq_bits_uop_lrs2;	// mshrs.scala:128:19
  assign io_replay_bits_uop_lrs3 = _rpq_io_deq_bits_uop_lrs3;	// mshrs.scala:128:19
  assign io_replay_bits_uop_ldst_val = _rpq_io_deq_bits_uop_ldst_val;	// mshrs.scala:128:19
  assign io_replay_bits_uop_dst_rtype = _rpq_io_deq_bits_uop_dst_rtype;	// mshrs.scala:128:19
  assign io_replay_bits_uop_lrs1_rtype = _rpq_io_deq_bits_uop_lrs1_rtype;	// mshrs.scala:128:19
  assign io_replay_bits_uop_lrs2_rtype = _rpq_io_deq_bits_uop_lrs2_rtype;	// mshrs.scala:128:19
  assign io_replay_bits_uop_frs3_en = _rpq_io_deq_bits_uop_frs3_en;	// mshrs.scala:128:19
  assign io_replay_bits_uop_fp_val = _rpq_io_deq_bits_uop_fp_val;	// mshrs.scala:128:19
  assign io_replay_bits_uop_fp_single = _rpq_io_deq_bits_uop_fp_single;	// mshrs.scala:128:19
  assign io_replay_bits_uop_xcpt_pf_if = _rpq_io_deq_bits_uop_xcpt_pf_if;	// mshrs.scala:128:19
  assign io_replay_bits_uop_xcpt_ae_if = _rpq_io_deq_bits_uop_xcpt_ae_if;	// mshrs.scala:128:19
  assign io_replay_bits_uop_xcpt_ma_if = _rpq_io_deq_bits_uop_xcpt_ma_if;	// mshrs.scala:128:19
  assign io_replay_bits_uop_bp_debug_if = _rpq_io_deq_bits_uop_bp_debug_if;	// mshrs.scala:128:19
  assign io_replay_bits_uop_bp_xcpt_if = _rpq_io_deq_bits_uop_bp_xcpt_if;	// mshrs.scala:128:19
  assign io_replay_bits_uop_debug_fsrc = _rpq_io_deq_bits_uop_debug_fsrc;	// mshrs.scala:128:19
  assign io_replay_bits_uop_debug_tsrc = _rpq_io_deq_bits_uop_debug_tsrc;	// mshrs.scala:128:19
  assign io_replay_bits_addr = {req_addr[39:6], _rpq_io_deq_bits_addr[5:0]};	// Cat.scala:30:58, mshrs.scala:109:20, :128:19, :342:70
  assign io_replay_bits_is_hella = _rpq_io_deq_bits_is_hella;	// mshrs.scala:128:19
  assign io_replay_bits_way_en = req_way_en;	// mshrs.scala:109:20
  assign io_resp_valid =
    ~_GEN_2 & _io_probe_rdy_T_4 & _rpq_io_deq_valid & io_lb_read_ready
    & _io_lb_read_valid_output & drain_load;	// mshrs.scala:128:19, :163:26, :170:26, :204:30, :211:40, :222:41, :245:45, :247:60, package.scala:15:47
  assign io_resp_bits_uop_uopc = _rpq_io_deq_bits_uop_uopc;	// mshrs.scala:128:19
  assign io_resp_bits_uop_inst = _rpq_io_deq_bits_uop_inst;	// mshrs.scala:128:19
  assign io_resp_bits_uop_debug_inst = _rpq_io_deq_bits_uop_debug_inst;	// mshrs.scala:128:19
  assign io_resp_bits_uop_is_rvc = _rpq_io_deq_bits_uop_is_rvc;	// mshrs.scala:128:19
  assign io_resp_bits_uop_debug_pc = _rpq_io_deq_bits_uop_debug_pc;	// mshrs.scala:128:19
  assign io_resp_bits_uop_iq_type = _rpq_io_deq_bits_uop_iq_type;	// mshrs.scala:128:19
  assign io_resp_bits_uop_fu_code = _rpq_io_deq_bits_uop_fu_code;	// mshrs.scala:128:19
  assign io_resp_bits_uop_ctrl_br_type = _rpq_io_deq_bits_uop_ctrl_br_type;	// mshrs.scala:128:19
  assign io_resp_bits_uop_ctrl_op1_sel = _rpq_io_deq_bits_uop_ctrl_op1_sel;	// mshrs.scala:128:19
  assign io_resp_bits_uop_ctrl_op2_sel = _rpq_io_deq_bits_uop_ctrl_op2_sel;	// mshrs.scala:128:19
  assign io_resp_bits_uop_ctrl_imm_sel = _rpq_io_deq_bits_uop_ctrl_imm_sel;	// mshrs.scala:128:19
  assign io_resp_bits_uop_ctrl_op_fcn = _rpq_io_deq_bits_uop_ctrl_op_fcn;	// mshrs.scala:128:19
  assign io_resp_bits_uop_ctrl_fcn_dw = _rpq_io_deq_bits_uop_ctrl_fcn_dw;	// mshrs.scala:128:19
  assign io_resp_bits_uop_ctrl_csr_cmd = _rpq_io_deq_bits_uop_ctrl_csr_cmd;	// mshrs.scala:128:19
  assign io_resp_bits_uop_ctrl_is_load = _rpq_io_deq_bits_uop_ctrl_is_load;	// mshrs.scala:128:19
  assign io_resp_bits_uop_ctrl_is_sta = _rpq_io_deq_bits_uop_ctrl_is_sta;	// mshrs.scala:128:19
  assign io_resp_bits_uop_ctrl_is_std = _rpq_io_deq_bits_uop_ctrl_is_std;	// mshrs.scala:128:19
  assign io_resp_bits_uop_iw_state = _rpq_io_deq_bits_uop_iw_state;	// mshrs.scala:128:19
  assign io_resp_bits_uop_iw_p1_poisoned = _rpq_io_deq_bits_uop_iw_p1_poisoned;	// mshrs.scala:128:19
  assign io_resp_bits_uop_iw_p2_poisoned = _rpq_io_deq_bits_uop_iw_p2_poisoned;	// mshrs.scala:128:19
  assign io_resp_bits_uop_is_br = _rpq_io_deq_bits_uop_is_br;	// mshrs.scala:128:19
  assign io_resp_bits_uop_is_jalr = _rpq_io_deq_bits_uop_is_jalr;	// mshrs.scala:128:19
  assign io_resp_bits_uop_is_jal = _rpq_io_deq_bits_uop_is_jal;	// mshrs.scala:128:19
  assign io_resp_bits_uop_is_sfb = _rpq_io_deq_bits_uop_is_sfb;	// mshrs.scala:128:19
  assign io_resp_bits_uop_br_mask = _rpq_io_deq_bits_uop_br_mask;	// mshrs.scala:128:19
  assign io_resp_bits_uop_br_tag = _rpq_io_deq_bits_uop_br_tag;	// mshrs.scala:128:19
  assign io_resp_bits_uop_ftq_idx = _rpq_io_deq_bits_uop_ftq_idx;	// mshrs.scala:128:19
  assign io_resp_bits_uop_edge_inst = _rpq_io_deq_bits_uop_edge_inst;	// mshrs.scala:128:19
  assign io_resp_bits_uop_pc_lob = _rpq_io_deq_bits_uop_pc_lob;	// mshrs.scala:128:19
  assign io_resp_bits_uop_taken = _rpq_io_deq_bits_uop_taken;	// mshrs.scala:128:19
  assign io_resp_bits_uop_imm_packed = _rpq_io_deq_bits_uop_imm_packed;	// mshrs.scala:128:19
  assign io_resp_bits_uop_csr_addr = _rpq_io_deq_bits_uop_csr_addr;	// mshrs.scala:128:19
  assign io_resp_bits_uop_rob_idx = _rpq_io_deq_bits_uop_rob_idx;	// mshrs.scala:128:19
  assign io_resp_bits_uop_ldq_idx = _rpq_io_deq_bits_uop_ldq_idx;	// mshrs.scala:128:19
  assign io_resp_bits_uop_stq_idx = _rpq_io_deq_bits_uop_stq_idx;	// mshrs.scala:128:19
  assign io_resp_bits_uop_rxq_idx = _rpq_io_deq_bits_uop_rxq_idx;	// mshrs.scala:128:19
  assign io_resp_bits_uop_pdst = _rpq_io_deq_bits_uop_pdst;	// mshrs.scala:128:19
  assign io_resp_bits_uop_prs1 = _rpq_io_deq_bits_uop_prs1;	// mshrs.scala:128:19
  assign io_resp_bits_uop_prs2 = _rpq_io_deq_bits_uop_prs2;	// mshrs.scala:128:19
  assign io_resp_bits_uop_prs3 = _rpq_io_deq_bits_uop_prs3;	// mshrs.scala:128:19
  assign io_resp_bits_uop_ppred = _rpq_io_deq_bits_uop_ppred;	// mshrs.scala:128:19
  assign io_resp_bits_uop_prs1_busy = _rpq_io_deq_bits_uop_prs1_busy;	// mshrs.scala:128:19
  assign io_resp_bits_uop_prs2_busy = _rpq_io_deq_bits_uop_prs2_busy;	// mshrs.scala:128:19
  assign io_resp_bits_uop_prs3_busy = _rpq_io_deq_bits_uop_prs3_busy;	// mshrs.scala:128:19
  assign io_resp_bits_uop_ppred_busy = _rpq_io_deq_bits_uop_ppred_busy;	// mshrs.scala:128:19
  assign io_resp_bits_uop_stale_pdst = _rpq_io_deq_bits_uop_stale_pdst;	// mshrs.scala:128:19
  assign io_resp_bits_uop_exception = _rpq_io_deq_bits_uop_exception;	// mshrs.scala:128:19
  assign io_resp_bits_uop_exc_cause = _rpq_io_deq_bits_uop_exc_cause;	// mshrs.scala:128:19
  assign io_resp_bits_uop_bypassable = _rpq_io_deq_bits_uop_bypassable;	// mshrs.scala:128:19
  assign io_resp_bits_uop_mem_cmd = _rpq_io_deq_bits_uop_mem_cmd;	// mshrs.scala:128:19
  assign io_resp_bits_uop_mem_size = _rpq_io_deq_bits_uop_mem_size;	// mshrs.scala:128:19
  assign io_resp_bits_uop_mem_signed = _rpq_io_deq_bits_uop_mem_signed;	// mshrs.scala:128:19
  assign io_resp_bits_uop_is_fence = _rpq_io_deq_bits_uop_is_fence;	// mshrs.scala:128:19
  assign io_resp_bits_uop_is_fencei = _rpq_io_deq_bits_uop_is_fencei;	// mshrs.scala:128:19
  assign io_resp_bits_uop_is_amo = _rpq_io_deq_bits_uop_is_amo;	// mshrs.scala:128:19
  assign io_resp_bits_uop_uses_ldq = _rpq_io_deq_bits_uop_uses_ldq;	// mshrs.scala:128:19
  assign io_resp_bits_uop_uses_stq = _rpq_io_deq_bits_uop_uses_stq;	// mshrs.scala:128:19
  assign io_resp_bits_uop_is_sys_pc2epc = _rpq_io_deq_bits_uop_is_sys_pc2epc;	// mshrs.scala:128:19
  assign io_resp_bits_uop_is_unique = _rpq_io_deq_bits_uop_is_unique;	// mshrs.scala:128:19
  assign io_resp_bits_uop_flush_on_commit = _rpq_io_deq_bits_uop_flush_on_commit;	// mshrs.scala:128:19
  assign io_resp_bits_uop_ldst_is_rs1 = _rpq_io_deq_bits_uop_ldst_is_rs1;	// mshrs.scala:128:19
  assign io_resp_bits_uop_ldst = _rpq_io_deq_bits_uop_ldst;	// mshrs.scala:128:19
  assign io_resp_bits_uop_lrs1 = _rpq_io_deq_bits_uop_lrs1;	// mshrs.scala:128:19
  assign io_resp_bits_uop_lrs2 = _rpq_io_deq_bits_uop_lrs2;	// mshrs.scala:128:19
  assign io_resp_bits_uop_lrs3 = _rpq_io_deq_bits_uop_lrs3;	// mshrs.scala:128:19
  assign io_resp_bits_uop_ldst_val = _rpq_io_deq_bits_uop_ldst_val;	// mshrs.scala:128:19
  assign io_resp_bits_uop_dst_rtype = _rpq_io_deq_bits_uop_dst_rtype;	// mshrs.scala:128:19
  assign io_resp_bits_uop_lrs1_rtype = _rpq_io_deq_bits_uop_lrs1_rtype;	// mshrs.scala:128:19
  assign io_resp_bits_uop_lrs2_rtype = _rpq_io_deq_bits_uop_lrs2_rtype;	// mshrs.scala:128:19
  assign io_resp_bits_uop_frs3_en = _rpq_io_deq_bits_uop_frs3_en;	// mshrs.scala:128:19
  assign io_resp_bits_uop_fp_val = _rpq_io_deq_bits_uop_fp_val;	// mshrs.scala:128:19
  assign io_resp_bits_uop_fp_single = _rpq_io_deq_bits_uop_fp_single;	// mshrs.scala:128:19
  assign io_resp_bits_uop_xcpt_pf_if = _rpq_io_deq_bits_uop_xcpt_pf_if;	// mshrs.scala:128:19
  assign io_resp_bits_uop_xcpt_ae_if = _rpq_io_deq_bits_uop_xcpt_ae_if;	// mshrs.scala:128:19
  assign io_resp_bits_uop_xcpt_ma_if = _rpq_io_deq_bits_uop_xcpt_ma_if;	// mshrs.scala:128:19
  assign io_resp_bits_uop_bp_debug_if = _rpq_io_deq_bits_uop_bp_debug_if;	// mshrs.scala:128:19
  assign io_resp_bits_uop_bp_xcpt_if = _rpq_io_deq_bits_uop_bp_xcpt_if;	// mshrs.scala:128:19
  assign io_resp_bits_uop_debug_fsrc = _rpq_io_deq_bits_uop_debug_fsrc;	// mshrs.scala:128:19
  assign io_resp_bits_uop_debug_tsrc = _rpq_io_deq_bits_uop_debug_tsrc;	// mshrs.scala:128:19
  assign io_resp_bits_data =
    {_rpq_io_deq_bits_uop_mem_size == 2'h0
       ? {56{_rpq_io_deq_bits_uop_mem_signed & io_resp_bits_data_lo_2[7]}}
       : {_rpq_io_deq_bits_uop_mem_size == 2'h1
            ? {48{_rpq_io_deq_bits_uop_mem_signed & io_resp_bits_data_lo_1[15]}}
            : {_rpq_io_deq_bits_uop_mem_size == 2'h2
                 ? {32{_rpq_io_deq_bits_uop_mem_signed & io_resp_bits_data_lo[31]}}
                 : io_lb_resp[63:32],
               io_resp_bits_data_lo[31:16]},
          io_resp_bits_data_lo_1[15:8]},
     io_resp_bits_data_lo_2};	// AMOALU.scala:39:{24,37}, :42:{20,26,76,85,98}, Bitwise.scala:72:12, Cat.scala:30:58, Metadata.scala:160:16, Mux.scala:80:57, mshrs.scala:128:19
  assign io_resp_bits_is_hella = _rpq_io_deq_bits_is_hella;	// mshrs.scala:128:19
  assign io_probe_rdy =
    ~(|meta_hazard)
    & (~(|state) | _io_probe_rdy_T_2 | _io_probe_rdy_T_3 | _io_probe_rdy_T_4
       | _io_probe_rdy_T_8 & grantack_valid);	// mshrs.scala:107:22, :138:21, :145:28, :146:21, :148:{34,42,119,129,145}, package.scala:15:47
endmodule

