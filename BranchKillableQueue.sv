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

module BranchKillableQueue(
  input         clock,
                reset,
                io_enq_valid,
  input  [6:0]  io_enq_bits_uop_uopc,
  input  [31:0] io_enq_bits_uop_inst,
                io_enq_bits_uop_debug_inst,
  input         io_enq_bits_uop_is_rvc,
  input  [39:0] io_enq_bits_uop_debug_pc,
  input  [2:0]  io_enq_bits_uop_iq_type,
  input  [9:0]  io_enq_bits_uop_fu_code,
  input  [3:0]  io_enq_bits_uop_ctrl_br_type,
  input  [1:0]  io_enq_bits_uop_ctrl_op1_sel,
  input  [2:0]  io_enq_bits_uop_ctrl_op2_sel,
                io_enq_bits_uop_ctrl_imm_sel,
  input  [3:0]  io_enq_bits_uop_ctrl_op_fcn,
  input         io_enq_bits_uop_ctrl_fcn_dw,
  input  [2:0]  io_enq_bits_uop_ctrl_csr_cmd,
  input         io_enq_bits_uop_ctrl_is_load,
                io_enq_bits_uop_ctrl_is_sta,
                io_enq_bits_uop_ctrl_is_std,
  input  [1:0]  io_enq_bits_uop_iw_state,
  input         io_enq_bits_uop_iw_p1_poisoned,
                io_enq_bits_uop_iw_p2_poisoned,
                io_enq_bits_uop_is_br,
                io_enq_bits_uop_is_jalr,
                io_enq_bits_uop_is_jal,
                io_enq_bits_uop_is_sfb,
  input  [19:0] io_enq_bits_uop_br_mask,
  input  [4:0]  io_enq_bits_uop_br_tag,
  input  [5:0]  io_enq_bits_uop_ftq_idx,
  input         io_enq_bits_uop_edge_inst,
  input  [5:0]  io_enq_bits_uop_pc_lob,
  input         io_enq_bits_uop_taken,
  input  [19:0] io_enq_bits_uop_imm_packed,
  input  [11:0] io_enq_bits_uop_csr_addr,
  input  [6:0]  io_enq_bits_uop_rob_idx,
  input  [4:0]  io_enq_bits_uop_ldq_idx,
                io_enq_bits_uop_stq_idx,
  input  [1:0]  io_enq_bits_uop_rxq_idx,
  input  [6:0]  io_enq_bits_uop_pdst,
                io_enq_bits_uop_prs1,
                io_enq_bits_uop_prs2,
                io_enq_bits_uop_prs3,
  input  [5:0]  io_enq_bits_uop_ppred,
  input         io_enq_bits_uop_prs1_busy,
                io_enq_bits_uop_prs2_busy,
                io_enq_bits_uop_prs3_busy,
                io_enq_bits_uop_ppred_busy,
  input  [6:0]  io_enq_bits_uop_stale_pdst,
  input         io_enq_bits_uop_exception,
  input  [63:0] io_enq_bits_uop_exc_cause,
  input         io_enq_bits_uop_bypassable,
  input  [4:0]  io_enq_bits_uop_mem_cmd,
  input  [1:0]  io_enq_bits_uop_mem_size,
  input         io_enq_bits_uop_mem_signed,
                io_enq_bits_uop_is_fence,
                io_enq_bits_uop_is_fencei,
                io_enq_bits_uop_is_amo,
                io_enq_bits_uop_uses_ldq,
                io_enq_bits_uop_uses_stq,
                io_enq_bits_uop_is_sys_pc2epc,
                io_enq_bits_uop_is_unique,
                io_enq_bits_uop_flush_on_commit,
                io_enq_bits_uop_ldst_is_rs1,
  input  [5:0]  io_enq_bits_uop_ldst,
                io_enq_bits_uop_lrs1,
                io_enq_bits_uop_lrs2,
                io_enq_bits_uop_lrs3,
  input         io_enq_bits_uop_ldst_val,
  input  [1:0]  io_enq_bits_uop_dst_rtype,
                io_enq_bits_uop_lrs1_rtype,
                io_enq_bits_uop_lrs2_rtype,
  input         io_enq_bits_uop_frs3_en,
                io_enq_bits_uop_fp_val,
                io_enq_bits_uop_fp_single,
                io_enq_bits_uop_xcpt_pf_if,
                io_enq_bits_uop_xcpt_ae_if,
                io_enq_bits_uop_xcpt_ma_if,
                io_enq_bits_uop_bp_debug_if,
                io_enq_bits_uop_bp_xcpt_if,
  input  [1:0]  io_enq_bits_uop_debug_fsrc,
                io_enq_bits_uop_debug_tsrc,
  input  [39:0] io_enq_bits_addr,
  input  [63:0] io_enq_bits_data,
  input         io_enq_bits_is_hella,
                io_enq_bits_tag_match,
  input  [1:0]  io_enq_bits_old_meta_coh_state,
  input  [19:0] io_enq_bits_old_meta_tag,
  input  [7:0]  io_enq_bits_way_en,
  input  [4:0]  io_enq_bits_sdq_id,
  input         io_deq_ready,
  input  [19:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  input         io_flush,
  output        io_enq_ready,
                io_deq_valid,
  output [6:0]  io_deq_bits_uop_uopc,
  output [31:0] io_deq_bits_uop_inst,
                io_deq_bits_uop_debug_inst,
  output        io_deq_bits_uop_is_rvc,
  output [39:0] io_deq_bits_uop_debug_pc,
  output [2:0]  io_deq_bits_uop_iq_type,
  output [9:0]  io_deq_bits_uop_fu_code,
  output [3:0]  io_deq_bits_uop_ctrl_br_type,
  output [1:0]  io_deq_bits_uop_ctrl_op1_sel,
  output [2:0]  io_deq_bits_uop_ctrl_op2_sel,
                io_deq_bits_uop_ctrl_imm_sel,
  output [3:0]  io_deq_bits_uop_ctrl_op_fcn,
  output        io_deq_bits_uop_ctrl_fcn_dw,
  output [2:0]  io_deq_bits_uop_ctrl_csr_cmd,
  output        io_deq_bits_uop_ctrl_is_load,
                io_deq_bits_uop_ctrl_is_sta,
                io_deq_bits_uop_ctrl_is_std,
  output [1:0]  io_deq_bits_uop_iw_state,
  output        io_deq_bits_uop_iw_p1_poisoned,
                io_deq_bits_uop_iw_p2_poisoned,
                io_deq_bits_uop_is_br,
                io_deq_bits_uop_is_jalr,
                io_deq_bits_uop_is_jal,
                io_deq_bits_uop_is_sfb,
  output [19:0] io_deq_bits_uop_br_mask,
  output [4:0]  io_deq_bits_uop_br_tag,
  output [5:0]  io_deq_bits_uop_ftq_idx,
  output        io_deq_bits_uop_edge_inst,
  output [5:0]  io_deq_bits_uop_pc_lob,
  output        io_deq_bits_uop_taken,
  output [19:0] io_deq_bits_uop_imm_packed,
  output [11:0] io_deq_bits_uop_csr_addr,
  output [6:0]  io_deq_bits_uop_rob_idx,
  output [4:0]  io_deq_bits_uop_ldq_idx,
                io_deq_bits_uop_stq_idx,
  output [1:0]  io_deq_bits_uop_rxq_idx,
  output [6:0]  io_deq_bits_uop_pdst,
                io_deq_bits_uop_prs1,
                io_deq_bits_uop_prs2,
                io_deq_bits_uop_prs3,
  output [5:0]  io_deq_bits_uop_ppred,
  output        io_deq_bits_uop_prs1_busy,
                io_deq_bits_uop_prs2_busy,
                io_deq_bits_uop_prs3_busy,
                io_deq_bits_uop_ppred_busy,
  output [6:0]  io_deq_bits_uop_stale_pdst,
  output        io_deq_bits_uop_exception,
  output [63:0] io_deq_bits_uop_exc_cause,
  output        io_deq_bits_uop_bypassable,
  output [4:0]  io_deq_bits_uop_mem_cmd,
  output [1:0]  io_deq_bits_uop_mem_size,
  output        io_deq_bits_uop_mem_signed,
                io_deq_bits_uop_is_fence,
                io_deq_bits_uop_is_fencei,
                io_deq_bits_uop_is_amo,
                io_deq_bits_uop_uses_ldq,
                io_deq_bits_uop_uses_stq,
                io_deq_bits_uop_is_sys_pc2epc,
                io_deq_bits_uop_is_unique,
                io_deq_bits_uop_flush_on_commit,
                io_deq_bits_uop_ldst_is_rs1,
  output [5:0]  io_deq_bits_uop_ldst,
                io_deq_bits_uop_lrs1,
                io_deq_bits_uop_lrs2,
                io_deq_bits_uop_lrs3,
  output        io_deq_bits_uop_ldst_val,
  output [1:0]  io_deq_bits_uop_dst_rtype,
                io_deq_bits_uop_lrs1_rtype,
                io_deq_bits_uop_lrs2_rtype,
  output        io_deq_bits_uop_frs3_en,
                io_deq_bits_uop_fp_val,
                io_deq_bits_uop_fp_single,
                io_deq_bits_uop_xcpt_pf_if,
                io_deq_bits_uop_xcpt_ae_if,
                io_deq_bits_uop_xcpt_ma_if,
                io_deq_bits_uop_bp_debug_if,
                io_deq_bits_uop_bp_xcpt_if,
  output [1:0]  io_deq_bits_uop_debug_fsrc,
                io_deq_bits_uop_debug_tsrc,
  output [39:0] io_deq_bits_addr,
  output        io_deq_bits_is_hella,
  output [4:0]  io_deq_bits_sdq_id,
  output        io_empty
);

  wire [45:0]       _ram_ext_R0_data;	// util.scala:464:20
  reg               valids_0;	// util.scala:465:24
  reg               valids_1;	// util.scala:465:24
  reg               valids_2;	// util.scala:465:24
  reg               valids_3;	// util.scala:465:24
  reg               valids_4;	// util.scala:465:24
  reg               valids_5;	// util.scala:465:24
  reg               valids_6;	// util.scala:465:24
  reg               valids_7;	// util.scala:465:24
  reg               valids_8;	// util.scala:465:24
  reg               valids_9;	// util.scala:465:24
  reg               valids_10;	// util.scala:465:24
  reg               valids_11;	// util.scala:465:24
  reg               valids_12;	// util.scala:465:24
  reg               valids_13;	// util.scala:465:24
  reg               valids_14;	// util.scala:465:24
  reg               valids_15;	// util.scala:465:24
  reg  [6:0]        uops_0_uopc;	// util.scala:466:20
  reg  [31:0]       uops_0_inst;	// util.scala:466:20
  reg  [31:0]       uops_0_debug_inst;	// util.scala:466:20
  reg               uops_0_is_rvc;	// util.scala:466:20
  reg  [39:0]       uops_0_debug_pc;	// util.scala:466:20
  reg  [2:0]        uops_0_iq_type;	// util.scala:466:20
  reg  [9:0]        uops_0_fu_code;	// util.scala:466:20
  reg  [3:0]        uops_0_ctrl_br_type;	// util.scala:466:20
  reg  [1:0]        uops_0_ctrl_op1_sel;	// util.scala:466:20
  reg  [2:0]        uops_0_ctrl_op2_sel;	// util.scala:466:20
  reg  [2:0]        uops_0_ctrl_imm_sel;	// util.scala:466:20
  reg  [3:0]        uops_0_ctrl_op_fcn;	// util.scala:466:20
  reg               uops_0_ctrl_fcn_dw;	// util.scala:466:20
  reg  [2:0]        uops_0_ctrl_csr_cmd;	// util.scala:466:20
  reg               uops_0_ctrl_is_load;	// util.scala:466:20
  reg               uops_0_ctrl_is_sta;	// util.scala:466:20
  reg               uops_0_ctrl_is_std;	// util.scala:466:20
  reg  [1:0]        uops_0_iw_state;	// util.scala:466:20
  reg               uops_0_iw_p1_poisoned;	// util.scala:466:20
  reg               uops_0_iw_p2_poisoned;	// util.scala:466:20
  reg               uops_0_is_br;	// util.scala:466:20
  reg               uops_0_is_jalr;	// util.scala:466:20
  reg               uops_0_is_jal;	// util.scala:466:20
  reg               uops_0_is_sfb;	// util.scala:466:20
  reg  [19:0]       uops_0_br_mask;	// util.scala:466:20
  reg  [4:0]        uops_0_br_tag;	// util.scala:466:20
  reg  [5:0]        uops_0_ftq_idx;	// util.scala:466:20
  reg               uops_0_edge_inst;	// util.scala:466:20
  reg  [5:0]        uops_0_pc_lob;	// util.scala:466:20
  reg               uops_0_taken;	// util.scala:466:20
  reg  [19:0]       uops_0_imm_packed;	// util.scala:466:20
  reg  [11:0]       uops_0_csr_addr;	// util.scala:466:20
  reg  [6:0]        uops_0_rob_idx;	// util.scala:466:20
  reg  [4:0]        uops_0_ldq_idx;	// util.scala:466:20
  reg  [4:0]        uops_0_stq_idx;	// util.scala:466:20
  reg  [1:0]        uops_0_rxq_idx;	// util.scala:466:20
  reg  [6:0]        uops_0_pdst;	// util.scala:466:20
  reg  [6:0]        uops_0_prs1;	// util.scala:466:20
  reg  [6:0]        uops_0_prs2;	// util.scala:466:20
  reg  [6:0]        uops_0_prs3;	// util.scala:466:20
  reg  [5:0]        uops_0_ppred;	// util.scala:466:20
  reg               uops_0_prs1_busy;	// util.scala:466:20
  reg               uops_0_prs2_busy;	// util.scala:466:20
  reg               uops_0_prs3_busy;	// util.scala:466:20
  reg               uops_0_ppred_busy;	// util.scala:466:20
  reg  [6:0]        uops_0_stale_pdst;	// util.scala:466:20
  reg               uops_0_exception;	// util.scala:466:20
  reg  [63:0]       uops_0_exc_cause;	// util.scala:466:20
  reg               uops_0_bypassable;	// util.scala:466:20
  reg  [4:0]        uops_0_mem_cmd;	// util.scala:466:20
  reg  [1:0]        uops_0_mem_size;	// util.scala:466:20
  reg               uops_0_mem_signed;	// util.scala:466:20
  reg               uops_0_is_fence;	// util.scala:466:20
  reg               uops_0_is_fencei;	// util.scala:466:20
  reg               uops_0_is_amo;	// util.scala:466:20
  reg               uops_0_uses_ldq;	// util.scala:466:20
  reg               uops_0_uses_stq;	// util.scala:466:20
  reg               uops_0_is_sys_pc2epc;	// util.scala:466:20
  reg               uops_0_is_unique;	// util.scala:466:20
  reg               uops_0_flush_on_commit;	// util.scala:466:20
  reg               uops_0_ldst_is_rs1;	// util.scala:466:20
  reg  [5:0]        uops_0_ldst;	// util.scala:466:20
  reg  [5:0]        uops_0_lrs1;	// util.scala:466:20
  reg  [5:0]        uops_0_lrs2;	// util.scala:466:20
  reg  [5:0]        uops_0_lrs3;	// util.scala:466:20
  reg               uops_0_ldst_val;	// util.scala:466:20
  reg  [1:0]        uops_0_dst_rtype;	// util.scala:466:20
  reg  [1:0]        uops_0_lrs1_rtype;	// util.scala:466:20
  reg  [1:0]        uops_0_lrs2_rtype;	// util.scala:466:20
  reg               uops_0_frs3_en;	// util.scala:466:20
  reg               uops_0_fp_val;	// util.scala:466:20
  reg               uops_0_fp_single;	// util.scala:466:20
  reg               uops_0_xcpt_pf_if;	// util.scala:466:20
  reg               uops_0_xcpt_ae_if;	// util.scala:466:20
  reg               uops_0_xcpt_ma_if;	// util.scala:466:20
  reg               uops_0_bp_debug_if;	// util.scala:466:20
  reg               uops_0_bp_xcpt_if;	// util.scala:466:20
  reg  [1:0]        uops_0_debug_fsrc;	// util.scala:466:20
  reg  [1:0]        uops_0_debug_tsrc;	// util.scala:466:20
  reg  [6:0]        uops_1_uopc;	// util.scala:466:20
  reg  [31:0]       uops_1_inst;	// util.scala:466:20
  reg  [31:0]       uops_1_debug_inst;	// util.scala:466:20
  reg               uops_1_is_rvc;	// util.scala:466:20
  reg  [39:0]       uops_1_debug_pc;	// util.scala:466:20
  reg  [2:0]        uops_1_iq_type;	// util.scala:466:20
  reg  [9:0]        uops_1_fu_code;	// util.scala:466:20
  reg  [3:0]        uops_1_ctrl_br_type;	// util.scala:466:20
  reg  [1:0]        uops_1_ctrl_op1_sel;	// util.scala:466:20
  reg  [2:0]        uops_1_ctrl_op2_sel;	// util.scala:466:20
  reg  [2:0]        uops_1_ctrl_imm_sel;	// util.scala:466:20
  reg  [3:0]        uops_1_ctrl_op_fcn;	// util.scala:466:20
  reg               uops_1_ctrl_fcn_dw;	// util.scala:466:20
  reg  [2:0]        uops_1_ctrl_csr_cmd;	// util.scala:466:20
  reg               uops_1_ctrl_is_load;	// util.scala:466:20
  reg               uops_1_ctrl_is_sta;	// util.scala:466:20
  reg               uops_1_ctrl_is_std;	// util.scala:466:20
  reg  [1:0]        uops_1_iw_state;	// util.scala:466:20
  reg               uops_1_iw_p1_poisoned;	// util.scala:466:20
  reg               uops_1_iw_p2_poisoned;	// util.scala:466:20
  reg               uops_1_is_br;	// util.scala:466:20
  reg               uops_1_is_jalr;	// util.scala:466:20
  reg               uops_1_is_jal;	// util.scala:466:20
  reg               uops_1_is_sfb;	// util.scala:466:20
  reg  [19:0]       uops_1_br_mask;	// util.scala:466:20
  reg  [4:0]        uops_1_br_tag;	// util.scala:466:20
  reg  [5:0]        uops_1_ftq_idx;	// util.scala:466:20
  reg               uops_1_edge_inst;	// util.scala:466:20
  reg  [5:0]        uops_1_pc_lob;	// util.scala:466:20
  reg               uops_1_taken;	// util.scala:466:20
  reg  [19:0]       uops_1_imm_packed;	// util.scala:466:20
  reg  [11:0]       uops_1_csr_addr;	// util.scala:466:20
  reg  [6:0]        uops_1_rob_idx;	// util.scala:466:20
  reg  [4:0]        uops_1_ldq_idx;	// util.scala:466:20
  reg  [4:0]        uops_1_stq_idx;	// util.scala:466:20
  reg  [1:0]        uops_1_rxq_idx;	// util.scala:466:20
  reg  [6:0]        uops_1_pdst;	// util.scala:466:20
  reg  [6:0]        uops_1_prs1;	// util.scala:466:20
  reg  [6:0]        uops_1_prs2;	// util.scala:466:20
  reg  [6:0]        uops_1_prs3;	// util.scala:466:20
  reg  [5:0]        uops_1_ppred;	// util.scala:466:20
  reg               uops_1_prs1_busy;	// util.scala:466:20
  reg               uops_1_prs2_busy;	// util.scala:466:20
  reg               uops_1_prs3_busy;	// util.scala:466:20
  reg               uops_1_ppred_busy;	// util.scala:466:20
  reg  [6:0]        uops_1_stale_pdst;	// util.scala:466:20
  reg               uops_1_exception;	// util.scala:466:20
  reg  [63:0]       uops_1_exc_cause;	// util.scala:466:20
  reg               uops_1_bypassable;	// util.scala:466:20
  reg  [4:0]        uops_1_mem_cmd;	// util.scala:466:20
  reg  [1:0]        uops_1_mem_size;	// util.scala:466:20
  reg               uops_1_mem_signed;	// util.scala:466:20
  reg               uops_1_is_fence;	// util.scala:466:20
  reg               uops_1_is_fencei;	// util.scala:466:20
  reg               uops_1_is_amo;	// util.scala:466:20
  reg               uops_1_uses_ldq;	// util.scala:466:20
  reg               uops_1_uses_stq;	// util.scala:466:20
  reg               uops_1_is_sys_pc2epc;	// util.scala:466:20
  reg               uops_1_is_unique;	// util.scala:466:20
  reg               uops_1_flush_on_commit;	// util.scala:466:20
  reg               uops_1_ldst_is_rs1;	// util.scala:466:20
  reg  [5:0]        uops_1_ldst;	// util.scala:466:20
  reg  [5:0]        uops_1_lrs1;	// util.scala:466:20
  reg  [5:0]        uops_1_lrs2;	// util.scala:466:20
  reg  [5:0]        uops_1_lrs3;	// util.scala:466:20
  reg               uops_1_ldst_val;	// util.scala:466:20
  reg  [1:0]        uops_1_dst_rtype;	// util.scala:466:20
  reg  [1:0]        uops_1_lrs1_rtype;	// util.scala:466:20
  reg  [1:0]        uops_1_lrs2_rtype;	// util.scala:466:20
  reg               uops_1_frs3_en;	// util.scala:466:20
  reg               uops_1_fp_val;	// util.scala:466:20
  reg               uops_1_fp_single;	// util.scala:466:20
  reg               uops_1_xcpt_pf_if;	// util.scala:466:20
  reg               uops_1_xcpt_ae_if;	// util.scala:466:20
  reg               uops_1_xcpt_ma_if;	// util.scala:466:20
  reg               uops_1_bp_debug_if;	// util.scala:466:20
  reg               uops_1_bp_xcpt_if;	// util.scala:466:20
  reg  [1:0]        uops_1_debug_fsrc;	// util.scala:466:20
  reg  [1:0]        uops_1_debug_tsrc;	// util.scala:466:20
  reg  [6:0]        uops_2_uopc;	// util.scala:466:20
  reg  [31:0]       uops_2_inst;	// util.scala:466:20
  reg  [31:0]       uops_2_debug_inst;	// util.scala:466:20
  reg               uops_2_is_rvc;	// util.scala:466:20
  reg  [39:0]       uops_2_debug_pc;	// util.scala:466:20
  reg  [2:0]        uops_2_iq_type;	// util.scala:466:20
  reg  [9:0]        uops_2_fu_code;	// util.scala:466:20
  reg  [3:0]        uops_2_ctrl_br_type;	// util.scala:466:20
  reg  [1:0]        uops_2_ctrl_op1_sel;	// util.scala:466:20
  reg  [2:0]        uops_2_ctrl_op2_sel;	// util.scala:466:20
  reg  [2:0]        uops_2_ctrl_imm_sel;	// util.scala:466:20
  reg  [3:0]        uops_2_ctrl_op_fcn;	// util.scala:466:20
  reg               uops_2_ctrl_fcn_dw;	// util.scala:466:20
  reg  [2:0]        uops_2_ctrl_csr_cmd;	// util.scala:466:20
  reg               uops_2_ctrl_is_load;	// util.scala:466:20
  reg               uops_2_ctrl_is_sta;	// util.scala:466:20
  reg               uops_2_ctrl_is_std;	// util.scala:466:20
  reg  [1:0]        uops_2_iw_state;	// util.scala:466:20
  reg               uops_2_iw_p1_poisoned;	// util.scala:466:20
  reg               uops_2_iw_p2_poisoned;	// util.scala:466:20
  reg               uops_2_is_br;	// util.scala:466:20
  reg               uops_2_is_jalr;	// util.scala:466:20
  reg               uops_2_is_jal;	// util.scala:466:20
  reg               uops_2_is_sfb;	// util.scala:466:20
  reg  [19:0]       uops_2_br_mask;	// util.scala:466:20
  reg  [4:0]        uops_2_br_tag;	// util.scala:466:20
  reg  [5:0]        uops_2_ftq_idx;	// util.scala:466:20
  reg               uops_2_edge_inst;	// util.scala:466:20
  reg  [5:0]        uops_2_pc_lob;	// util.scala:466:20
  reg               uops_2_taken;	// util.scala:466:20
  reg  [19:0]       uops_2_imm_packed;	// util.scala:466:20
  reg  [11:0]       uops_2_csr_addr;	// util.scala:466:20
  reg  [6:0]        uops_2_rob_idx;	// util.scala:466:20
  reg  [4:0]        uops_2_ldq_idx;	// util.scala:466:20
  reg  [4:0]        uops_2_stq_idx;	// util.scala:466:20
  reg  [1:0]        uops_2_rxq_idx;	// util.scala:466:20
  reg  [6:0]        uops_2_pdst;	// util.scala:466:20
  reg  [6:0]        uops_2_prs1;	// util.scala:466:20
  reg  [6:0]        uops_2_prs2;	// util.scala:466:20
  reg  [6:0]        uops_2_prs3;	// util.scala:466:20
  reg  [5:0]        uops_2_ppred;	// util.scala:466:20
  reg               uops_2_prs1_busy;	// util.scala:466:20
  reg               uops_2_prs2_busy;	// util.scala:466:20
  reg               uops_2_prs3_busy;	// util.scala:466:20
  reg               uops_2_ppred_busy;	// util.scala:466:20
  reg  [6:0]        uops_2_stale_pdst;	// util.scala:466:20
  reg               uops_2_exception;	// util.scala:466:20
  reg  [63:0]       uops_2_exc_cause;	// util.scala:466:20
  reg               uops_2_bypassable;	// util.scala:466:20
  reg  [4:0]        uops_2_mem_cmd;	// util.scala:466:20
  reg  [1:0]        uops_2_mem_size;	// util.scala:466:20
  reg               uops_2_mem_signed;	// util.scala:466:20
  reg               uops_2_is_fence;	// util.scala:466:20
  reg               uops_2_is_fencei;	// util.scala:466:20
  reg               uops_2_is_amo;	// util.scala:466:20
  reg               uops_2_uses_ldq;	// util.scala:466:20
  reg               uops_2_uses_stq;	// util.scala:466:20
  reg               uops_2_is_sys_pc2epc;	// util.scala:466:20
  reg               uops_2_is_unique;	// util.scala:466:20
  reg               uops_2_flush_on_commit;	// util.scala:466:20
  reg               uops_2_ldst_is_rs1;	// util.scala:466:20
  reg  [5:0]        uops_2_ldst;	// util.scala:466:20
  reg  [5:0]        uops_2_lrs1;	// util.scala:466:20
  reg  [5:0]        uops_2_lrs2;	// util.scala:466:20
  reg  [5:0]        uops_2_lrs3;	// util.scala:466:20
  reg               uops_2_ldst_val;	// util.scala:466:20
  reg  [1:0]        uops_2_dst_rtype;	// util.scala:466:20
  reg  [1:0]        uops_2_lrs1_rtype;	// util.scala:466:20
  reg  [1:0]        uops_2_lrs2_rtype;	// util.scala:466:20
  reg               uops_2_frs3_en;	// util.scala:466:20
  reg               uops_2_fp_val;	// util.scala:466:20
  reg               uops_2_fp_single;	// util.scala:466:20
  reg               uops_2_xcpt_pf_if;	// util.scala:466:20
  reg               uops_2_xcpt_ae_if;	// util.scala:466:20
  reg               uops_2_xcpt_ma_if;	// util.scala:466:20
  reg               uops_2_bp_debug_if;	// util.scala:466:20
  reg               uops_2_bp_xcpt_if;	// util.scala:466:20
  reg  [1:0]        uops_2_debug_fsrc;	// util.scala:466:20
  reg  [1:0]        uops_2_debug_tsrc;	// util.scala:466:20
  reg  [6:0]        uops_3_uopc;	// util.scala:466:20
  reg  [31:0]       uops_3_inst;	// util.scala:466:20
  reg  [31:0]       uops_3_debug_inst;	// util.scala:466:20
  reg               uops_3_is_rvc;	// util.scala:466:20
  reg  [39:0]       uops_3_debug_pc;	// util.scala:466:20
  reg  [2:0]        uops_3_iq_type;	// util.scala:466:20
  reg  [9:0]        uops_3_fu_code;	// util.scala:466:20
  reg  [3:0]        uops_3_ctrl_br_type;	// util.scala:466:20
  reg  [1:0]        uops_3_ctrl_op1_sel;	// util.scala:466:20
  reg  [2:0]        uops_3_ctrl_op2_sel;	// util.scala:466:20
  reg  [2:0]        uops_3_ctrl_imm_sel;	// util.scala:466:20
  reg  [3:0]        uops_3_ctrl_op_fcn;	// util.scala:466:20
  reg               uops_3_ctrl_fcn_dw;	// util.scala:466:20
  reg  [2:0]        uops_3_ctrl_csr_cmd;	// util.scala:466:20
  reg               uops_3_ctrl_is_load;	// util.scala:466:20
  reg               uops_3_ctrl_is_sta;	// util.scala:466:20
  reg               uops_3_ctrl_is_std;	// util.scala:466:20
  reg  [1:0]        uops_3_iw_state;	// util.scala:466:20
  reg               uops_3_iw_p1_poisoned;	// util.scala:466:20
  reg               uops_3_iw_p2_poisoned;	// util.scala:466:20
  reg               uops_3_is_br;	// util.scala:466:20
  reg               uops_3_is_jalr;	// util.scala:466:20
  reg               uops_3_is_jal;	// util.scala:466:20
  reg               uops_3_is_sfb;	// util.scala:466:20
  reg  [19:0]       uops_3_br_mask;	// util.scala:466:20
  reg  [4:0]        uops_3_br_tag;	// util.scala:466:20
  reg  [5:0]        uops_3_ftq_idx;	// util.scala:466:20
  reg               uops_3_edge_inst;	// util.scala:466:20
  reg  [5:0]        uops_3_pc_lob;	// util.scala:466:20
  reg               uops_3_taken;	// util.scala:466:20
  reg  [19:0]       uops_3_imm_packed;	// util.scala:466:20
  reg  [11:0]       uops_3_csr_addr;	// util.scala:466:20
  reg  [6:0]        uops_3_rob_idx;	// util.scala:466:20
  reg  [4:0]        uops_3_ldq_idx;	// util.scala:466:20
  reg  [4:0]        uops_3_stq_idx;	// util.scala:466:20
  reg  [1:0]        uops_3_rxq_idx;	// util.scala:466:20
  reg  [6:0]        uops_3_pdst;	// util.scala:466:20
  reg  [6:0]        uops_3_prs1;	// util.scala:466:20
  reg  [6:0]        uops_3_prs2;	// util.scala:466:20
  reg  [6:0]        uops_3_prs3;	// util.scala:466:20
  reg  [5:0]        uops_3_ppred;	// util.scala:466:20
  reg               uops_3_prs1_busy;	// util.scala:466:20
  reg               uops_3_prs2_busy;	// util.scala:466:20
  reg               uops_3_prs3_busy;	// util.scala:466:20
  reg               uops_3_ppred_busy;	// util.scala:466:20
  reg  [6:0]        uops_3_stale_pdst;	// util.scala:466:20
  reg               uops_3_exception;	// util.scala:466:20
  reg  [63:0]       uops_3_exc_cause;	// util.scala:466:20
  reg               uops_3_bypassable;	// util.scala:466:20
  reg  [4:0]        uops_3_mem_cmd;	// util.scala:466:20
  reg  [1:0]        uops_3_mem_size;	// util.scala:466:20
  reg               uops_3_mem_signed;	// util.scala:466:20
  reg               uops_3_is_fence;	// util.scala:466:20
  reg               uops_3_is_fencei;	// util.scala:466:20
  reg               uops_3_is_amo;	// util.scala:466:20
  reg               uops_3_uses_ldq;	// util.scala:466:20
  reg               uops_3_uses_stq;	// util.scala:466:20
  reg               uops_3_is_sys_pc2epc;	// util.scala:466:20
  reg               uops_3_is_unique;	// util.scala:466:20
  reg               uops_3_flush_on_commit;	// util.scala:466:20
  reg               uops_3_ldst_is_rs1;	// util.scala:466:20
  reg  [5:0]        uops_3_ldst;	// util.scala:466:20
  reg  [5:0]        uops_3_lrs1;	// util.scala:466:20
  reg  [5:0]        uops_3_lrs2;	// util.scala:466:20
  reg  [5:0]        uops_3_lrs3;	// util.scala:466:20
  reg               uops_3_ldst_val;	// util.scala:466:20
  reg  [1:0]        uops_3_dst_rtype;	// util.scala:466:20
  reg  [1:0]        uops_3_lrs1_rtype;	// util.scala:466:20
  reg  [1:0]        uops_3_lrs2_rtype;	// util.scala:466:20
  reg               uops_3_frs3_en;	// util.scala:466:20
  reg               uops_3_fp_val;	// util.scala:466:20
  reg               uops_3_fp_single;	// util.scala:466:20
  reg               uops_3_xcpt_pf_if;	// util.scala:466:20
  reg               uops_3_xcpt_ae_if;	// util.scala:466:20
  reg               uops_3_xcpt_ma_if;	// util.scala:466:20
  reg               uops_3_bp_debug_if;	// util.scala:466:20
  reg               uops_3_bp_xcpt_if;	// util.scala:466:20
  reg  [1:0]        uops_3_debug_fsrc;	// util.scala:466:20
  reg  [1:0]        uops_3_debug_tsrc;	// util.scala:466:20
  reg  [6:0]        uops_4_uopc;	// util.scala:466:20
  reg  [31:0]       uops_4_inst;	// util.scala:466:20
  reg  [31:0]       uops_4_debug_inst;	// util.scala:466:20
  reg               uops_4_is_rvc;	// util.scala:466:20
  reg  [39:0]       uops_4_debug_pc;	// util.scala:466:20
  reg  [2:0]        uops_4_iq_type;	// util.scala:466:20
  reg  [9:0]        uops_4_fu_code;	// util.scala:466:20
  reg  [3:0]        uops_4_ctrl_br_type;	// util.scala:466:20
  reg  [1:0]        uops_4_ctrl_op1_sel;	// util.scala:466:20
  reg  [2:0]        uops_4_ctrl_op2_sel;	// util.scala:466:20
  reg  [2:0]        uops_4_ctrl_imm_sel;	// util.scala:466:20
  reg  [3:0]        uops_4_ctrl_op_fcn;	// util.scala:466:20
  reg               uops_4_ctrl_fcn_dw;	// util.scala:466:20
  reg  [2:0]        uops_4_ctrl_csr_cmd;	// util.scala:466:20
  reg               uops_4_ctrl_is_load;	// util.scala:466:20
  reg               uops_4_ctrl_is_sta;	// util.scala:466:20
  reg               uops_4_ctrl_is_std;	// util.scala:466:20
  reg  [1:0]        uops_4_iw_state;	// util.scala:466:20
  reg               uops_4_iw_p1_poisoned;	// util.scala:466:20
  reg               uops_4_iw_p2_poisoned;	// util.scala:466:20
  reg               uops_4_is_br;	// util.scala:466:20
  reg               uops_4_is_jalr;	// util.scala:466:20
  reg               uops_4_is_jal;	// util.scala:466:20
  reg               uops_4_is_sfb;	// util.scala:466:20
  reg  [19:0]       uops_4_br_mask;	// util.scala:466:20
  reg  [4:0]        uops_4_br_tag;	// util.scala:466:20
  reg  [5:0]        uops_4_ftq_idx;	// util.scala:466:20
  reg               uops_4_edge_inst;	// util.scala:466:20
  reg  [5:0]        uops_4_pc_lob;	// util.scala:466:20
  reg               uops_4_taken;	// util.scala:466:20
  reg  [19:0]       uops_4_imm_packed;	// util.scala:466:20
  reg  [11:0]       uops_4_csr_addr;	// util.scala:466:20
  reg  [6:0]        uops_4_rob_idx;	// util.scala:466:20
  reg  [4:0]        uops_4_ldq_idx;	// util.scala:466:20
  reg  [4:0]        uops_4_stq_idx;	// util.scala:466:20
  reg  [1:0]        uops_4_rxq_idx;	// util.scala:466:20
  reg  [6:0]        uops_4_pdst;	// util.scala:466:20
  reg  [6:0]        uops_4_prs1;	// util.scala:466:20
  reg  [6:0]        uops_4_prs2;	// util.scala:466:20
  reg  [6:0]        uops_4_prs3;	// util.scala:466:20
  reg  [5:0]        uops_4_ppred;	// util.scala:466:20
  reg               uops_4_prs1_busy;	// util.scala:466:20
  reg               uops_4_prs2_busy;	// util.scala:466:20
  reg               uops_4_prs3_busy;	// util.scala:466:20
  reg               uops_4_ppred_busy;	// util.scala:466:20
  reg  [6:0]        uops_4_stale_pdst;	// util.scala:466:20
  reg               uops_4_exception;	// util.scala:466:20
  reg  [63:0]       uops_4_exc_cause;	// util.scala:466:20
  reg               uops_4_bypassable;	// util.scala:466:20
  reg  [4:0]        uops_4_mem_cmd;	// util.scala:466:20
  reg  [1:0]        uops_4_mem_size;	// util.scala:466:20
  reg               uops_4_mem_signed;	// util.scala:466:20
  reg               uops_4_is_fence;	// util.scala:466:20
  reg               uops_4_is_fencei;	// util.scala:466:20
  reg               uops_4_is_amo;	// util.scala:466:20
  reg               uops_4_uses_ldq;	// util.scala:466:20
  reg               uops_4_uses_stq;	// util.scala:466:20
  reg               uops_4_is_sys_pc2epc;	// util.scala:466:20
  reg               uops_4_is_unique;	// util.scala:466:20
  reg               uops_4_flush_on_commit;	// util.scala:466:20
  reg               uops_4_ldst_is_rs1;	// util.scala:466:20
  reg  [5:0]        uops_4_ldst;	// util.scala:466:20
  reg  [5:0]        uops_4_lrs1;	// util.scala:466:20
  reg  [5:0]        uops_4_lrs2;	// util.scala:466:20
  reg  [5:0]        uops_4_lrs3;	// util.scala:466:20
  reg               uops_4_ldst_val;	// util.scala:466:20
  reg  [1:0]        uops_4_dst_rtype;	// util.scala:466:20
  reg  [1:0]        uops_4_lrs1_rtype;	// util.scala:466:20
  reg  [1:0]        uops_4_lrs2_rtype;	// util.scala:466:20
  reg               uops_4_frs3_en;	// util.scala:466:20
  reg               uops_4_fp_val;	// util.scala:466:20
  reg               uops_4_fp_single;	// util.scala:466:20
  reg               uops_4_xcpt_pf_if;	// util.scala:466:20
  reg               uops_4_xcpt_ae_if;	// util.scala:466:20
  reg               uops_4_xcpt_ma_if;	// util.scala:466:20
  reg               uops_4_bp_debug_if;	// util.scala:466:20
  reg               uops_4_bp_xcpt_if;	// util.scala:466:20
  reg  [1:0]        uops_4_debug_fsrc;	// util.scala:466:20
  reg  [1:0]        uops_4_debug_tsrc;	// util.scala:466:20
  reg  [6:0]        uops_5_uopc;	// util.scala:466:20
  reg  [31:0]       uops_5_inst;	// util.scala:466:20
  reg  [31:0]       uops_5_debug_inst;	// util.scala:466:20
  reg               uops_5_is_rvc;	// util.scala:466:20
  reg  [39:0]       uops_5_debug_pc;	// util.scala:466:20
  reg  [2:0]        uops_5_iq_type;	// util.scala:466:20
  reg  [9:0]        uops_5_fu_code;	// util.scala:466:20
  reg  [3:0]        uops_5_ctrl_br_type;	// util.scala:466:20
  reg  [1:0]        uops_5_ctrl_op1_sel;	// util.scala:466:20
  reg  [2:0]        uops_5_ctrl_op2_sel;	// util.scala:466:20
  reg  [2:0]        uops_5_ctrl_imm_sel;	// util.scala:466:20
  reg  [3:0]        uops_5_ctrl_op_fcn;	// util.scala:466:20
  reg               uops_5_ctrl_fcn_dw;	// util.scala:466:20
  reg  [2:0]        uops_5_ctrl_csr_cmd;	// util.scala:466:20
  reg               uops_5_ctrl_is_load;	// util.scala:466:20
  reg               uops_5_ctrl_is_sta;	// util.scala:466:20
  reg               uops_5_ctrl_is_std;	// util.scala:466:20
  reg  [1:0]        uops_5_iw_state;	// util.scala:466:20
  reg               uops_5_iw_p1_poisoned;	// util.scala:466:20
  reg               uops_5_iw_p2_poisoned;	// util.scala:466:20
  reg               uops_5_is_br;	// util.scala:466:20
  reg               uops_5_is_jalr;	// util.scala:466:20
  reg               uops_5_is_jal;	// util.scala:466:20
  reg               uops_5_is_sfb;	// util.scala:466:20
  reg  [19:0]       uops_5_br_mask;	// util.scala:466:20
  reg  [4:0]        uops_5_br_tag;	// util.scala:466:20
  reg  [5:0]        uops_5_ftq_idx;	// util.scala:466:20
  reg               uops_5_edge_inst;	// util.scala:466:20
  reg  [5:0]        uops_5_pc_lob;	// util.scala:466:20
  reg               uops_5_taken;	// util.scala:466:20
  reg  [19:0]       uops_5_imm_packed;	// util.scala:466:20
  reg  [11:0]       uops_5_csr_addr;	// util.scala:466:20
  reg  [6:0]        uops_5_rob_idx;	// util.scala:466:20
  reg  [4:0]        uops_5_ldq_idx;	// util.scala:466:20
  reg  [4:0]        uops_5_stq_idx;	// util.scala:466:20
  reg  [1:0]        uops_5_rxq_idx;	// util.scala:466:20
  reg  [6:0]        uops_5_pdst;	// util.scala:466:20
  reg  [6:0]        uops_5_prs1;	// util.scala:466:20
  reg  [6:0]        uops_5_prs2;	// util.scala:466:20
  reg  [6:0]        uops_5_prs3;	// util.scala:466:20
  reg  [5:0]        uops_5_ppred;	// util.scala:466:20
  reg               uops_5_prs1_busy;	// util.scala:466:20
  reg               uops_5_prs2_busy;	// util.scala:466:20
  reg               uops_5_prs3_busy;	// util.scala:466:20
  reg               uops_5_ppred_busy;	// util.scala:466:20
  reg  [6:0]        uops_5_stale_pdst;	// util.scala:466:20
  reg               uops_5_exception;	// util.scala:466:20
  reg  [63:0]       uops_5_exc_cause;	// util.scala:466:20
  reg               uops_5_bypassable;	// util.scala:466:20
  reg  [4:0]        uops_5_mem_cmd;	// util.scala:466:20
  reg  [1:0]        uops_5_mem_size;	// util.scala:466:20
  reg               uops_5_mem_signed;	// util.scala:466:20
  reg               uops_5_is_fence;	// util.scala:466:20
  reg               uops_5_is_fencei;	// util.scala:466:20
  reg               uops_5_is_amo;	// util.scala:466:20
  reg               uops_5_uses_ldq;	// util.scala:466:20
  reg               uops_5_uses_stq;	// util.scala:466:20
  reg               uops_5_is_sys_pc2epc;	// util.scala:466:20
  reg               uops_5_is_unique;	// util.scala:466:20
  reg               uops_5_flush_on_commit;	// util.scala:466:20
  reg               uops_5_ldst_is_rs1;	// util.scala:466:20
  reg  [5:0]        uops_5_ldst;	// util.scala:466:20
  reg  [5:0]        uops_5_lrs1;	// util.scala:466:20
  reg  [5:0]        uops_5_lrs2;	// util.scala:466:20
  reg  [5:0]        uops_5_lrs3;	// util.scala:466:20
  reg               uops_5_ldst_val;	// util.scala:466:20
  reg  [1:0]        uops_5_dst_rtype;	// util.scala:466:20
  reg  [1:0]        uops_5_lrs1_rtype;	// util.scala:466:20
  reg  [1:0]        uops_5_lrs2_rtype;	// util.scala:466:20
  reg               uops_5_frs3_en;	// util.scala:466:20
  reg               uops_5_fp_val;	// util.scala:466:20
  reg               uops_5_fp_single;	// util.scala:466:20
  reg               uops_5_xcpt_pf_if;	// util.scala:466:20
  reg               uops_5_xcpt_ae_if;	// util.scala:466:20
  reg               uops_5_xcpt_ma_if;	// util.scala:466:20
  reg               uops_5_bp_debug_if;	// util.scala:466:20
  reg               uops_5_bp_xcpt_if;	// util.scala:466:20
  reg  [1:0]        uops_5_debug_fsrc;	// util.scala:466:20
  reg  [1:0]        uops_5_debug_tsrc;	// util.scala:466:20
  reg  [6:0]        uops_6_uopc;	// util.scala:466:20
  reg  [31:0]       uops_6_inst;	// util.scala:466:20
  reg  [31:0]       uops_6_debug_inst;	// util.scala:466:20
  reg               uops_6_is_rvc;	// util.scala:466:20
  reg  [39:0]       uops_6_debug_pc;	// util.scala:466:20
  reg  [2:0]        uops_6_iq_type;	// util.scala:466:20
  reg  [9:0]        uops_6_fu_code;	// util.scala:466:20
  reg  [3:0]        uops_6_ctrl_br_type;	// util.scala:466:20
  reg  [1:0]        uops_6_ctrl_op1_sel;	// util.scala:466:20
  reg  [2:0]        uops_6_ctrl_op2_sel;	// util.scala:466:20
  reg  [2:0]        uops_6_ctrl_imm_sel;	// util.scala:466:20
  reg  [3:0]        uops_6_ctrl_op_fcn;	// util.scala:466:20
  reg               uops_6_ctrl_fcn_dw;	// util.scala:466:20
  reg  [2:0]        uops_6_ctrl_csr_cmd;	// util.scala:466:20
  reg               uops_6_ctrl_is_load;	// util.scala:466:20
  reg               uops_6_ctrl_is_sta;	// util.scala:466:20
  reg               uops_6_ctrl_is_std;	// util.scala:466:20
  reg  [1:0]        uops_6_iw_state;	// util.scala:466:20
  reg               uops_6_iw_p1_poisoned;	// util.scala:466:20
  reg               uops_6_iw_p2_poisoned;	// util.scala:466:20
  reg               uops_6_is_br;	// util.scala:466:20
  reg               uops_6_is_jalr;	// util.scala:466:20
  reg               uops_6_is_jal;	// util.scala:466:20
  reg               uops_6_is_sfb;	// util.scala:466:20
  reg  [19:0]       uops_6_br_mask;	// util.scala:466:20
  reg  [4:0]        uops_6_br_tag;	// util.scala:466:20
  reg  [5:0]        uops_6_ftq_idx;	// util.scala:466:20
  reg               uops_6_edge_inst;	// util.scala:466:20
  reg  [5:0]        uops_6_pc_lob;	// util.scala:466:20
  reg               uops_6_taken;	// util.scala:466:20
  reg  [19:0]       uops_6_imm_packed;	// util.scala:466:20
  reg  [11:0]       uops_6_csr_addr;	// util.scala:466:20
  reg  [6:0]        uops_6_rob_idx;	// util.scala:466:20
  reg  [4:0]        uops_6_ldq_idx;	// util.scala:466:20
  reg  [4:0]        uops_6_stq_idx;	// util.scala:466:20
  reg  [1:0]        uops_6_rxq_idx;	// util.scala:466:20
  reg  [6:0]        uops_6_pdst;	// util.scala:466:20
  reg  [6:0]        uops_6_prs1;	// util.scala:466:20
  reg  [6:0]        uops_6_prs2;	// util.scala:466:20
  reg  [6:0]        uops_6_prs3;	// util.scala:466:20
  reg  [5:0]        uops_6_ppred;	// util.scala:466:20
  reg               uops_6_prs1_busy;	// util.scala:466:20
  reg               uops_6_prs2_busy;	// util.scala:466:20
  reg               uops_6_prs3_busy;	// util.scala:466:20
  reg               uops_6_ppred_busy;	// util.scala:466:20
  reg  [6:0]        uops_6_stale_pdst;	// util.scala:466:20
  reg               uops_6_exception;	// util.scala:466:20
  reg  [63:0]       uops_6_exc_cause;	// util.scala:466:20
  reg               uops_6_bypassable;	// util.scala:466:20
  reg  [4:0]        uops_6_mem_cmd;	// util.scala:466:20
  reg  [1:0]        uops_6_mem_size;	// util.scala:466:20
  reg               uops_6_mem_signed;	// util.scala:466:20
  reg               uops_6_is_fence;	// util.scala:466:20
  reg               uops_6_is_fencei;	// util.scala:466:20
  reg               uops_6_is_amo;	// util.scala:466:20
  reg               uops_6_uses_ldq;	// util.scala:466:20
  reg               uops_6_uses_stq;	// util.scala:466:20
  reg               uops_6_is_sys_pc2epc;	// util.scala:466:20
  reg               uops_6_is_unique;	// util.scala:466:20
  reg               uops_6_flush_on_commit;	// util.scala:466:20
  reg               uops_6_ldst_is_rs1;	// util.scala:466:20
  reg  [5:0]        uops_6_ldst;	// util.scala:466:20
  reg  [5:0]        uops_6_lrs1;	// util.scala:466:20
  reg  [5:0]        uops_6_lrs2;	// util.scala:466:20
  reg  [5:0]        uops_6_lrs3;	// util.scala:466:20
  reg               uops_6_ldst_val;	// util.scala:466:20
  reg  [1:0]        uops_6_dst_rtype;	// util.scala:466:20
  reg  [1:0]        uops_6_lrs1_rtype;	// util.scala:466:20
  reg  [1:0]        uops_6_lrs2_rtype;	// util.scala:466:20
  reg               uops_6_frs3_en;	// util.scala:466:20
  reg               uops_6_fp_val;	// util.scala:466:20
  reg               uops_6_fp_single;	// util.scala:466:20
  reg               uops_6_xcpt_pf_if;	// util.scala:466:20
  reg               uops_6_xcpt_ae_if;	// util.scala:466:20
  reg               uops_6_xcpt_ma_if;	// util.scala:466:20
  reg               uops_6_bp_debug_if;	// util.scala:466:20
  reg               uops_6_bp_xcpt_if;	// util.scala:466:20
  reg  [1:0]        uops_6_debug_fsrc;	// util.scala:466:20
  reg  [1:0]        uops_6_debug_tsrc;	// util.scala:466:20
  reg  [6:0]        uops_7_uopc;	// util.scala:466:20
  reg  [31:0]       uops_7_inst;	// util.scala:466:20
  reg  [31:0]       uops_7_debug_inst;	// util.scala:466:20
  reg               uops_7_is_rvc;	// util.scala:466:20
  reg  [39:0]       uops_7_debug_pc;	// util.scala:466:20
  reg  [2:0]        uops_7_iq_type;	// util.scala:466:20
  reg  [9:0]        uops_7_fu_code;	// util.scala:466:20
  reg  [3:0]        uops_7_ctrl_br_type;	// util.scala:466:20
  reg  [1:0]        uops_7_ctrl_op1_sel;	// util.scala:466:20
  reg  [2:0]        uops_7_ctrl_op2_sel;	// util.scala:466:20
  reg  [2:0]        uops_7_ctrl_imm_sel;	// util.scala:466:20
  reg  [3:0]        uops_7_ctrl_op_fcn;	// util.scala:466:20
  reg               uops_7_ctrl_fcn_dw;	// util.scala:466:20
  reg  [2:0]        uops_7_ctrl_csr_cmd;	// util.scala:466:20
  reg               uops_7_ctrl_is_load;	// util.scala:466:20
  reg               uops_7_ctrl_is_sta;	// util.scala:466:20
  reg               uops_7_ctrl_is_std;	// util.scala:466:20
  reg  [1:0]        uops_7_iw_state;	// util.scala:466:20
  reg               uops_7_iw_p1_poisoned;	// util.scala:466:20
  reg               uops_7_iw_p2_poisoned;	// util.scala:466:20
  reg               uops_7_is_br;	// util.scala:466:20
  reg               uops_7_is_jalr;	// util.scala:466:20
  reg               uops_7_is_jal;	// util.scala:466:20
  reg               uops_7_is_sfb;	// util.scala:466:20
  reg  [19:0]       uops_7_br_mask;	// util.scala:466:20
  reg  [4:0]        uops_7_br_tag;	// util.scala:466:20
  reg  [5:0]        uops_7_ftq_idx;	// util.scala:466:20
  reg               uops_7_edge_inst;	// util.scala:466:20
  reg  [5:0]        uops_7_pc_lob;	// util.scala:466:20
  reg               uops_7_taken;	// util.scala:466:20
  reg  [19:0]       uops_7_imm_packed;	// util.scala:466:20
  reg  [11:0]       uops_7_csr_addr;	// util.scala:466:20
  reg  [6:0]        uops_7_rob_idx;	// util.scala:466:20
  reg  [4:0]        uops_7_ldq_idx;	// util.scala:466:20
  reg  [4:0]        uops_7_stq_idx;	// util.scala:466:20
  reg  [1:0]        uops_7_rxq_idx;	// util.scala:466:20
  reg  [6:0]        uops_7_pdst;	// util.scala:466:20
  reg  [6:0]        uops_7_prs1;	// util.scala:466:20
  reg  [6:0]        uops_7_prs2;	// util.scala:466:20
  reg  [6:0]        uops_7_prs3;	// util.scala:466:20
  reg  [5:0]        uops_7_ppred;	// util.scala:466:20
  reg               uops_7_prs1_busy;	// util.scala:466:20
  reg               uops_7_prs2_busy;	// util.scala:466:20
  reg               uops_7_prs3_busy;	// util.scala:466:20
  reg               uops_7_ppred_busy;	// util.scala:466:20
  reg  [6:0]        uops_7_stale_pdst;	// util.scala:466:20
  reg               uops_7_exception;	// util.scala:466:20
  reg  [63:0]       uops_7_exc_cause;	// util.scala:466:20
  reg               uops_7_bypassable;	// util.scala:466:20
  reg  [4:0]        uops_7_mem_cmd;	// util.scala:466:20
  reg  [1:0]        uops_7_mem_size;	// util.scala:466:20
  reg               uops_7_mem_signed;	// util.scala:466:20
  reg               uops_7_is_fence;	// util.scala:466:20
  reg               uops_7_is_fencei;	// util.scala:466:20
  reg               uops_7_is_amo;	// util.scala:466:20
  reg               uops_7_uses_ldq;	// util.scala:466:20
  reg               uops_7_uses_stq;	// util.scala:466:20
  reg               uops_7_is_sys_pc2epc;	// util.scala:466:20
  reg               uops_7_is_unique;	// util.scala:466:20
  reg               uops_7_flush_on_commit;	// util.scala:466:20
  reg               uops_7_ldst_is_rs1;	// util.scala:466:20
  reg  [5:0]        uops_7_ldst;	// util.scala:466:20
  reg  [5:0]        uops_7_lrs1;	// util.scala:466:20
  reg  [5:0]        uops_7_lrs2;	// util.scala:466:20
  reg  [5:0]        uops_7_lrs3;	// util.scala:466:20
  reg               uops_7_ldst_val;	// util.scala:466:20
  reg  [1:0]        uops_7_dst_rtype;	// util.scala:466:20
  reg  [1:0]        uops_7_lrs1_rtype;	// util.scala:466:20
  reg  [1:0]        uops_7_lrs2_rtype;	// util.scala:466:20
  reg               uops_7_frs3_en;	// util.scala:466:20
  reg               uops_7_fp_val;	// util.scala:466:20
  reg               uops_7_fp_single;	// util.scala:466:20
  reg               uops_7_xcpt_pf_if;	// util.scala:466:20
  reg               uops_7_xcpt_ae_if;	// util.scala:466:20
  reg               uops_7_xcpt_ma_if;	// util.scala:466:20
  reg               uops_7_bp_debug_if;	// util.scala:466:20
  reg               uops_7_bp_xcpt_if;	// util.scala:466:20
  reg  [1:0]        uops_7_debug_fsrc;	// util.scala:466:20
  reg  [1:0]        uops_7_debug_tsrc;	// util.scala:466:20
  reg  [6:0]        uops_8_uopc;	// util.scala:466:20
  reg  [31:0]       uops_8_inst;	// util.scala:466:20
  reg  [31:0]       uops_8_debug_inst;	// util.scala:466:20
  reg               uops_8_is_rvc;	// util.scala:466:20
  reg  [39:0]       uops_8_debug_pc;	// util.scala:466:20
  reg  [2:0]        uops_8_iq_type;	// util.scala:466:20
  reg  [9:0]        uops_8_fu_code;	// util.scala:466:20
  reg  [3:0]        uops_8_ctrl_br_type;	// util.scala:466:20
  reg  [1:0]        uops_8_ctrl_op1_sel;	// util.scala:466:20
  reg  [2:0]        uops_8_ctrl_op2_sel;	// util.scala:466:20
  reg  [2:0]        uops_8_ctrl_imm_sel;	// util.scala:466:20
  reg  [3:0]        uops_8_ctrl_op_fcn;	// util.scala:466:20
  reg               uops_8_ctrl_fcn_dw;	// util.scala:466:20
  reg  [2:0]        uops_8_ctrl_csr_cmd;	// util.scala:466:20
  reg               uops_8_ctrl_is_load;	// util.scala:466:20
  reg               uops_8_ctrl_is_sta;	// util.scala:466:20
  reg               uops_8_ctrl_is_std;	// util.scala:466:20
  reg  [1:0]        uops_8_iw_state;	// util.scala:466:20
  reg               uops_8_iw_p1_poisoned;	// util.scala:466:20
  reg               uops_8_iw_p2_poisoned;	// util.scala:466:20
  reg               uops_8_is_br;	// util.scala:466:20
  reg               uops_8_is_jalr;	// util.scala:466:20
  reg               uops_8_is_jal;	// util.scala:466:20
  reg               uops_8_is_sfb;	// util.scala:466:20
  reg  [19:0]       uops_8_br_mask;	// util.scala:466:20
  reg  [4:0]        uops_8_br_tag;	// util.scala:466:20
  reg  [5:0]        uops_8_ftq_idx;	// util.scala:466:20
  reg               uops_8_edge_inst;	// util.scala:466:20
  reg  [5:0]        uops_8_pc_lob;	// util.scala:466:20
  reg               uops_8_taken;	// util.scala:466:20
  reg  [19:0]       uops_8_imm_packed;	// util.scala:466:20
  reg  [11:0]       uops_8_csr_addr;	// util.scala:466:20
  reg  [6:0]        uops_8_rob_idx;	// util.scala:466:20
  reg  [4:0]        uops_8_ldq_idx;	// util.scala:466:20
  reg  [4:0]        uops_8_stq_idx;	// util.scala:466:20
  reg  [1:0]        uops_8_rxq_idx;	// util.scala:466:20
  reg  [6:0]        uops_8_pdst;	// util.scala:466:20
  reg  [6:0]        uops_8_prs1;	// util.scala:466:20
  reg  [6:0]        uops_8_prs2;	// util.scala:466:20
  reg  [6:0]        uops_8_prs3;	// util.scala:466:20
  reg  [5:0]        uops_8_ppred;	// util.scala:466:20
  reg               uops_8_prs1_busy;	// util.scala:466:20
  reg               uops_8_prs2_busy;	// util.scala:466:20
  reg               uops_8_prs3_busy;	// util.scala:466:20
  reg               uops_8_ppred_busy;	// util.scala:466:20
  reg  [6:0]        uops_8_stale_pdst;	// util.scala:466:20
  reg               uops_8_exception;	// util.scala:466:20
  reg  [63:0]       uops_8_exc_cause;	// util.scala:466:20
  reg               uops_8_bypassable;	// util.scala:466:20
  reg  [4:0]        uops_8_mem_cmd;	// util.scala:466:20
  reg  [1:0]        uops_8_mem_size;	// util.scala:466:20
  reg               uops_8_mem_signed;	// util.scala:466:20
  reg               uops_8_is_fence;	// util.scala:466:20
  reg               uops_8_is_fencei;	// util.scala:466:20
  reg               uops_8_is_amo;	// util.scala:466:20
  reg               uops_8_uses_ldq;	// util.scala:466:20
  reg               uops_8_uses_stq;	// util.scala:466:20
  reg               uops_8_is_sys_pc2epc;	// util.scala:466:20
  reg               uops_8_is_unique;	// util.scala:466:20
  reg               uops_8_flush_on_commit;	// util.scala:466:20
  reg               uops_8_ldst_is_rs1;	// util.scala:466:20
  reg  [5:0]        uops_8_ldst;	// util.scala:466:20
  reg  [5:0]        uops_8_lrs1;	// util.scala:466:20
  reg  [5:0]        uops_8_lrs2;	// util.scala:466:20
  reg  [5:0]        uops_8_lrs3;	// util.scala:466:20
  reg               uops_8_ldst_val;	// util.scala:466:20
  reg  [1:0]        uops_8_dst_rtype;	// util.scala:466:20
  reg  [1:0]        uops_8_lrs1_rtype;	// util.scala:466:20
  reg  [1:0]        uops_8_lrs2_rtype;	// util.scala:466:20
  reg               uops_8_frs3_en;	// util.scala:466:20
  reg               uops_8_fp_val;	// util.scala:466:20
  reg               uops_8_fp_single;	// util.scala:466:20
  reg               uops_8_xcpt_pf_if;	// util.scala:466:20
  reg               uops_8_xcpt_ae_if;	// util.scala:466:20
  reg               uops_8_xcpt_ma_if;	// util.scala:466:20
  reg               uops_8_bp_debug_if;	// util.scala:466:20
  reg               uops_8_bp_xcpt_if;	// util.scala:466:20
  reg  [1:0]        uops_8_debug_fsrc;	// util.scala:466:20
  reg  [1:0]        uops_8_debug_tsrc;	// util.scala:466:20
  reg  [6:0]        uops_9_uopc;	// util.scala:466:20
  reg  [31:0]       uops_9_inst;	// util.scala:466:20
  reg  [31:0]       uops_9_debug_inst;	// util.scala:466:20
  reg               uops_9_is_rvc;	// util.scala:466:20
  reg  [39:0]       uops_9_debug_pc;	// util.scala:466:20
  reg  [2:0]        uops_9_iq_type;	// util.scala:466:20
  reg  [9:0]        uops_9_fu_code;	// util.scala:466:20
  reg  [3:0]        uops_9_ctrl_br_type;	// util.scala:466:20
  reg  [1:0]        uops_9_ctrl_op1_sel;	// util.scala:466:20
  reg  [2:0]        uops_9_ctrl_op2_sel;	// util.scala:466:20
  reg  [2:0]        uops_9_ctrl_imm_sel;	// util.scala:466:20
  reg  [3:0]        uops_9_ctrl_op_fcn;	// util.scala:466:20
  reg               uops_9_ctrl_fcn_dw;	// util.scala:466:20
  reg  [2:0]        uops_9_ctrl_csr_cmd;	// util.scala:466:20
  reg               uops_9_ctrl_is_load;	// util.scala:466:20
  reg               uops_9_ctrl_is_sta;	// util.scala:466:20
  reg               uops_9_ctrl_is_std;	// util.scala:466:20
  reg  [1:0]        uops_9_iw_state;	// util.scala:466:20
  reg               uops_9_iw_p1_poisoned;	// util.scala:466:20
  reg               uops_9_iw_p2_poisoned;	// util.scala:466:20
  reg               uops_9_is_br;	// util.scala:466:20
  reg               uops_9_is_jalr;	// util.scala:466:20
  reg               uops_9_is_jal;	// util.scala:466:20
  reg               uops_9_is_sfb;	// util.scala:466:20
  reg  [19:0]       uops_9_br_mask;	// util.scala:466:20
  reg  [4:0]        uops_9_br_tag;	// util.scala:466:20
  reg  [5:0]        uops_9_ftq_idx;	// util.scala:466:20
  reg               uops_9_edge_inst;	// util.scala:466:20
  reg  [5:0]        uops_9_pc_lob;	// util.scala:466:20
  reg               uops_9_taken;	// util.scala:466:20
  reg  [19:0]       uops_9_imm_packed;	// util.scala:466:20
  reg  [11:0]       uops_9_csr_addr;	// util.scala:466:20
  reg  [6:0]        uops_9_rob_idx;	// util.scala:466:20
  reg  [4:0]        uops_9_ldq_idx;	// util.scala:466:20
  reg  [4:0]        uops_9_stq_idx;	// util.scala:466:20
  reg  [1:0]        uops_9_rxq_idx;	// util.scala:466:20
  reg  [6:0]        uops_9_pdst;	// util.scala:466:20
  reg  [6:0]        uops_9_prs1;	// util.scala:466:20
  reg  [6:0]        uops_9_prs2;	// util.scala:466:20
  reg  [6:0]        uops_9_prs3;	// util.scala:466:20
  reg  [5:0]        uops_9_ppred;	// util.scala:466:20
  reg               uops_9_prs1_busy;	// util.scala:466:20
  reg               uops_9_prs2_busy;	// util.scala:466:20
  reg               uops_9_prs3_busy;	// util.scala:466:20
  reg               uops_9_ppred_busy;	// util.scala:466:20
  reg  [6:0]        uops_9_stale_pdst;	// util.scala:466:20
  reg               uops_9_exception;	// util.scala:466:20
  reg  [63:0]       uops_9_exc_cause;	// util.scala:466:20
  reg               uops_9_bypassable;	// util.scala:466:20
  reg  [4:0]        uops_9_mem_cmd;	// util.scala:466:20
  reg  [1:0]        uops_9_mem_size;	// util.scala:466:20
  reg               uops_9_mem_signed;	// util.scala:466:20
  reg               uops_9_is_fence;	// util.scala:466:20
  reg               uops_9_is_fencei;	// util.scala:466:20
  reg               uops_9_is_amo;	// util.scala:466:20
  reg               uops_9_uses_ldq;	// util.scala:466:20
  reg               uops_9_uses_stq;	// util.scala:466:20
  reg               uops_9_is_sys_pc2epc;	// util.scala:466:20
  reg               uops_9_is_unique;	// util.scala:466:20
  reg               uops_9_flush_on_commit;	// util.scala:466:20
  reg               uops_9_ldst_is_rs1;	// util.scala:466:20
  reg  [5:0]        uops_9_ldst;	// util.scala:466:20
  reg  [5:0]        uops_9_lrs1;	// util.scala:466:20
  reg  [5:0]        uops_9_lrs2;	// util.scala:466:20
  reg  [5:0]        uops_9_lrs3;	// util.scala:466:20
  reg               uops_9_ldst_val;	// util.scala:466:20
  reg  [1:0]        uops_9_dst_rtype;	// util.scala:466:20
  reg  [1:0]        uops_9_lrs1_rtype;	// util.scala:466:20
  reg  [1:0]        uops_9_lrs2_rtype;	// util.scala:466:20
  reg               uops_9_frs3_en;	// util.scala:466:20
  reg               uops_9_fp_val;	// util.scala:466:20
  reg               uops_9_fp_single;	// util.scala:466:20
  reg               uops_9_xcpt_pf_if;	// util.scala:466:20
  reg               uops_9_xcpt_ae_if;	// util.scala:466:20
  reg               uops_9_xcpt_ma_if;	// util.scala:466:20
  reg               uops_9_bp_debug_if;	// util.scala:466:20
  reg               uops_9_bp_xcpt_if;	// util.scala:466:20
  reg  [1:0]        uops_9_debug_fsrc;	// util.scala:466:20
  reg  [1:0]        uops_9_debug_tsrc;	// util.scala:466:20
  reg  [6:0]        uops_10_uopc;	// util.scala:466:20
  reg  [31:0]       uops_10_inst;	// util.scala:466:20
  reg  [31:0]       uops_10_debug_inst;	// util.scala:466:20
  reg               uops_10_is_rvc;	// util.scala:466:20
  reg  [39:0]       uops_10_debug_pc;	// util.scala:466:20
  reg  [2:0]        uops_10_iq_type;	// util.scala:466:20
  reg  [9:0]        uops_10_fu_code;	// util.scala:466:20
  reg  [3:0]        uops_10_ctrl_br_type;	// util.scala:466:20
  reg  [1:0]        uops_10_ctrl_op1_sel;	// util.scala:466:20
  reg  [2:0]        uops_10_ctrl_op2_sel;	// util.scala:466:20
  reg  [2:0]        uops_10_ctrl_imm_sel;	// util.scala:466:20
  reg  [3:0]        uops_10_ctrl_op_fcn;	// util.scala:466:20
  reg               uops_10_ctrl_fcn_dw;	// util.scala:466:20
  reg  [2:0]        uops_10_ctrl_csr_cmd;	// util.scala:466:20
  reg               uops_10_ctrl_is_load;	// util.scala:466:20
  reg               uops_10_ctrl_is_sta;	// util.scala:466:20
  reg               uops_10_ctrl_is_std;	// util.scala:466:20
  reg  [1:0]        uops_10_iw_state;	// util.scala:466:20
  reg               uops_10_iw_p1_poisoned;	// util.scala:466:20
  reg               uops_10_iw_p2_poisoned;	// util.scala:466:20
  reg               uops_10_is_br;	// util.scala:466:20
  reg               uops_10_is_jalr;	// util.scala:466:20
  reg               uops_10_is_jal;	// util.scala:466:20
  reg               uops_10_is_sfb;	// util.scala:466:20
  reg  [19:0]       uops_10_br_mask;	// util.scala:466:20
  reg  [4:0]        uops_10_br_tag;	// util.scala:466:20
  reg  [5:0]        uops_10_ftq_idx;	// util.scala:466:20
  reg               uops_10_edge_inst;	// util.scala:466:20
  reg  [5:0]        uops_10_pc_lob;	// util.scala:466:20
  reg               uops_10_taken;	// util.scala:466:20
  reg  [19:0]       uops_10_imm_packed;	// util.scala:466:20
  reg  [11:0]       uops_10_csr_addr;	// util.scala:466:20
  reg  [6:0]        uops_10_rob_idx;	// util.scala:466:20
  reg  [4:0]        uops_10_ldq_idx;	// util.scala:466:20
  reg  [4:0]        uops_10_stq_idx;	// util.scala:466:20
  reg  [1:0]        uops_10_rxq_idx;	// util.scala:466:20
  reg  [6:0]        uops_10_pdst;	// util.scala:466:20
  reg  [6:0]        uops_10_prs1;	// util.scala:466:20
  reg  [6:0]        uops_10_prs2;	// util.scala:466:20
  reg  [6:0]        uops_10_prs3;	// util.scala:466:20
  reg  [5:0]        uops_10_ppred;	// util.scala:466:20
  reg               uops_10_prs1_busy;	// util.scala:466:20
  reg               uops_10_prs2_busy;	// util.scala:466:20
  reg               uops_10_prs3_busy;	// util.scala:466:20
  reg               uops_10_ppred_busy;	// util.scala:466:20
  reg  [6:0]        uops_10_stale_pdst;	// util.scala:466:20
  reg               uops_10_exception;	// util.scala:466:20
  reg  [63:0]       uops_10_exc_cause;	// util.scala:466:20
  reg               uops_10_bypassable;	// util.scala:466:20
  reg  [4:0]        uops_10_mem_cmd;	// util.scala:466:20
  reg  [1:0]        uops_10_mem_size;	// util.scala:466:20
  reg               uops_10_mem_signed;	// util.scala:466:20
  reg               uops_10_is_fence;	// util.scala:466:20
  reg               uops_10_is_fencei;	// util.scala:466:20
  reg               uops_10_is_amo;	// util.scala:466:20
  reg               uops_10_uses_ldq;	// util.scala:466:20
  reg               uops_10_uses_stq;	// util.scala:466:20
  reg               uops_10_is_sys_pc2epc;	// util.scala:466:20
  reg               uops_10_is_unique;	// util.scala:466:20
  reg               uops_10_flush_on_commit;	// util.scala:466:20
  reg               uops_10_ldst_is_rs1;	// util.scala:466:20
  reg  [5:0]        uops_10_ldst;	// util.scala:466:20
  reg  [5:0]        uops_10_lrs1;	// util.scala:466:20
  reg  [5:0]        uops_10_lrs2;	// util.scala:466:20
  reg  [5:0]        uops_10_lrs3;	// util.scala:466:20
  reg               uops_10_ldst_val;	// util.scala:466:20
  reg  [1:0]        uops_10_dst_rtype;	// util.scala:466:20
  reg  [1:0]        uops_10_lrs1_rtype;	// util.scala:466:20
  reg  [1:0]        uops_10_lrs2_rtype;	// util.scala:466:20
  reg               uops_10_frs3_en;	// util.scala:466:20
  reg               uops_10_fp_val;	// util.scala:466:20
  reg               uops_10_fp_single;	// util.scala:466:20
  reg               uops_10_xcpt_pf_if;	// util.scala:466:20
  reg               uops_10_xcpt_ae_if;	// util.scala:466:20
  reg               uops_10_xcpt_ma_if;	// util.scala:466:20
  reg               uops_10_bp_debug_if;	// util.scala:466:20
  reg               uops_10_bp_xcpt_if;	// util.scala:466:20
  reg  [1:0]        uops_10_debug_fsrc;	// util.scala:466:20
  reg  [1:0]        uops_10_debug_tsrc;	// util.scala:466:20
  reg  [6:0]        uops_11_uopc;	// util.scala:466:20
  reg  [31:0]       uops_11_inst;	// util.scala:466:20
  reg  [31:0]       uops_11_debug_inst;	// util.scala:466:20
  reg               uops_11_is_rvc;	// util.scala:466:20
  reg  [39:0]       uops_11_debug_pc;	// util.scala:466:20
  reg  [2:0]        uops_11_iq_type;	// util.scala:466:20
  reg  [9:0]        uops_11_fu_code;	// util.scala:466:20
  reg  [3:0]        uops_11_ctrl_br_type;	// util.scala:466:20
  reg  [1:0]        uops_11_ctrl_op1_sel;	// util.scala:466:20
  reg  [2:0]        uops_11_ctrl_op2_sel;	// util.scala:466:20
  reg  [2:0]        uops_11_ctrl_imm_sel;	// util.scala:466:20
  reg  [3:0]        uops_11_ctrl_op_fcn;	// util.scala:466:20
  reg               uops_11_ctrl_fcn_dw;	// util.scala:466:20
  reg  [2:0]        uops_11_ctrl_csr_cmd;	// util.scala:466:20
  reg               uops_11_ctrl_is_load;	// util.scala:466:20
  reg               uops_11_ctrl_is_sta;	// util.scala:466:20
  reg               uops_11_ctrl_is_std;	// util.scala:466:20
  reg  [1:0]        uops_11_iw_state;	// util.scala:466:20
  reg               uops_11_iw_p1_poisoned;	// util.scala:466:20
  reg               uops_11_iw_p2_poisoned;	// util.scala:466:20
  reg               uops_11_is_br;	// util.scala:466:20
  reg               uops_11_is_jalr;	// util.scala:466:20
  reg               uops_11_is_jal;	// util.scala:466:20
  reg               uops_11_is_sfb;	// util.scala:466:20
  reg  [19:0]       uops_11_br_mask;	// util.scala:466:20
  reg  [4:0]        uops_11_br_tag;	// util.scala:466:20
  reg  [5:0]        uops_11_ftq_idx;	// util.scala:466:20
  reg               uops_11_edge_inst;	// util.scala:466:20
  reg  [5:0]        uops_11_pc_lob;	// util.scala:466:20
  reg               uops_11_taken;	// util.scala:466:20
  reg  [19:0]       uops_11_imm_packed;	// util.scala:466:20
  reg  [11:0]       uops_11_csr_addr;	// util.scala:466:20
  reg  [6:0]        uops_11_rob_idx;	// util.scala:466:20
  reg  [4:0]        uops_11_ldq_idx;	// util.scala:466:20
  reg  [4:0]        uops_11_stq_idx;	// util.scala:466:20
  reg  [1:0]        uops_11_rxq_idx;	// util.scala:466:20
  reg  [6:0]        uops_11_pdst;	// util.scala:466:20
  reg  [6:0]        uops_11_prs1;	// util.scala:466:20
  reg  [6:0]        uops_11_prs2;	// util.scala:466:20
  reg  [6:0]        uops_11_prs3;	// util.scala:466:20
  reg  [5:0]        uops_11_ppred;	// util.scala:466:20
  reg               uops_11_prs1_busy;	// util.scala:466:20
  reg               uops_11_prs2_busy;	// util.scala:466:20
  reg               uops_11_prs3_busy;	// util.scala:466:20
  reg               uops_11_ppred_busy;	// util.scala:466:20
  reg  [6:0]        uops_11_stale_pdst;	// util.scala:466:20
  reg               uops_11_exception;	// util.scala:466:20
  reg  [63:0]       uops_11_exc_cause;	// util.scala:466:20
  reg               uops_11_bypassable;	// util.scala:466:20
  reg  [4:0]        uops_11_mem_cmd;	// util.scala:466:20
  reg  [1:0]        uops_11_mem_size;	// util.scala:466:20
  reg               uops_11_mem_signed;	// util.scala:466:20
  reg               uops_11_is_fence;	// util.scala:466:20
  reg               uops_11_is_fencei;	// util.scala:466:20
  reg               uops_11_is_amo;	// util.scala:466:20
  reg               uops_11_uses_ldq;	// util.scala:466:20
  reg               uops_11_uses_stq;	// util.scala:466:20
  reg               uops_11_is_sys_pc2epc;	// util.scala:466:20
  reg               uops_11_is_unique;	// util.scala:466:20
  reg               uops_11_flush_on_commit;	// util.scala:466:20
  reg               uops_11_ldst_is_rs1;	// util.scala:466:20
  reg  [5:0]        uops_11_ldst;	// util.scala:466:20
  reg  [5:0]        uops_11_lrs1;	// util.scala:466:20
  reg  [5:0]        uops_11_lrs2;	// util.scala:466:20
  reg  [5:0]        uops_11_lrs3;	// util.scala:466:20
  reg               uops_11_ldst_val;	// util.scala:466:20
  reg  [1:0]        uops_11_dst_rtype;	// util.scala:466:20
  reg  [1:0]        uops_11_lrs1_rtype;	// util.scala:466:20
  reg  [1:0]        uops_11_lrs2_rtype;	// util.scala:466:20
  reg               uops_11_frs3_en;	// util.scala:466:20
  reg               uops_11_fp_val;	// util.scala:466:20
  reg               uops_11_fp_single;	// util.scala:466:20
  reg               uops_11_xcpt_pf_if;	// util.scala:466:20
  reg               uops_11_xcpt_ae_if;	// util.scala:466:20
  reg               uops_11_xcpt_ma_if;	// util.scala:466:20
  reg               uops_11_bp_debug_if;	// util.scala:466:20
  reg               uops_11_bp_xcpt_if;	// util.scala:466:20
  reg  [1:0]        uops_11_debug_fsrc;	// util.scala:466:20
  reg  [1:0]        uops_11_debug_tsrc;	// util.scala:466:20
  reg  [6:0]        uops_12_uopc;	// util.scala:466:20
  reg  [31:0]       uops_12_inst;	// util.scala:466:20
  reg  [31:0]       uops_12_debug_inst;	// util.scala:466:20
  reg               uops_12_is_rvc;	// util.scala:466:20
  reg  [39:0]       uops_12_debug_pc;	// util.scala:466:20
  reg  [2:0]        uops_12_iq_type;	// util.scala:466:20
  reg  [9:0]        uops_12_fu_code;	// util.scala:466:20
  reg  [3:0]        uops_12_ctrl_br_type;	// util.scala:466:20
  reg  [1:0]        uops_12_ctrl_op1_sel;	// util.scala:466:20
  reg  [2:0]        uops_12_ctrl_op2_sel;	// util.scala:466:20
  reg  [2:0]        uops_12_ctrl_imm_sel;	// util.scala:466:20
  reg  [3:0]        uops_12_ctrl_op_fcn;	// util.scala:466:20
  reg               uops_12_ctrl_fcn_dw;	// util.scala:466:20
  reg  [2:0]        uops_12_ctrl_csr_cmd;	// util.scala:466:20
  reg               uops_12_ctrl_is_load;	// util.scala:466:20
  reg               uops_12_ctrl_is_sta;	// util.scala:466:20
  reg               uops_12_ctrl_is_std;	// util.scala:466:20
  reg  [1:0]        uops_12_iw_state;	// util.scala:466:20
  reg               uops_12_iw_p1_poisoned;	// util.scala:466:20
  reg               uops_12_iw_p2_poisoned;	// util.scala:466:20
  reg               uops_12_is_br;	// util.scala:466:20
  reg               uops_12_is_jalr;	// util.scala:466:20
  reg               uops_12_is_jal;	// util.scala:466:20
  reg               uops_12_is_sfb;	// util.scala:466:20
  reg  [19:0]       uops_12_br_mask;	// util.scala:466:20
  reg  [4:0]        uops_12_br_tag;	// util.scala:466:20
  reg  [5:0]        uops_12_ftq_idx;	// util.scala:466:20
  reg               uops_12_edge_inst;	// util.scala:466:20
  reg  [5:0]        uops_12_pc_lob;	// util.scala:466:20
  reg               uops_12_taken;	// util.scala:466:20
  reg  [19:0]       uops_12_imm_packed;	// util.scala:466:20
  reg  [11:0]       uops_12_csr_addr;	// util.scala:466:20
  reg  [6:0]        uops_12_rob_idx;	// util.scala:466:20
  reg  [4:0]        uops_12_ldq_idx;	// util.scala:466:20
  reg  [4:0]        uops_12_stq_idx;	// util.scala:466:20
  reg  [1:0]        uops_12_rxq_idx;	// util.scala:466:20
  reg  [6:0]        uops_12_pdst;	// util.scala:466:20
  reg  [6:0]        uops_12_prs1;	// util.scala:466:20
  reg  [6:0]        uops_12_prs2;	// util.scala:466:20
  reg  [6:0]        uops_12_prs3;	// util.scala:466:20
  reg  [5:0]        uops_12_ppred;	// util.scala:466:20
  reg               uops_12_prs1_busy;	// util.scala:466:20
  reg               uops_12_prs2_busy;	// util.scala:466:20
  reg               uops_12_prs3_busy;	// util.scala:466:20
  reg               uops_12_ppred_busy;	// util.scala:466:20
  reg  [6:0]        uops_12_stale_pdst;	// util.scala:466:20
  reg               uops_12_exception;	// util.scala:466:20
  reg  [63:0]       uops_12_exc_cause;	// util.scala:466:20
  reg               uops_12_bypassable;	// util.scala:466:20
  reg  [4:0]        uops_12_mem_cmd;	// util.scala:466:20
  reg  [1:0]        uops_12_mem_size;	// util.scala:466:20
  reg               uops_12_mem_signed;	// util.scala:466:20
  reg               uops_12_is_fence;	// util.scala:466:20
  reg               uops_12_is_fencei;	// util.scala:466:20
  reg               uops_12_is_amo;	// util.scala:466:20
  reg               uops_12_uses_ldq;	// util.scala:466:20
  reg               uops_12_uses_stq;	// util.scala:466:20
  reg               uops_12_is_sys_pc2epc;	// util.scala:466:20
  reg               uops_12_is_unique;	// util.scala:466:20
  reg               uops_12_flush_on_commit;	// util.scala:466:20
  reg               uops_12_ldst_is_rs1;	// util.scala:466:20
  reg  [5:0]        uops_12_ldst;	// util.scala:466:20
  reg  [5:0]        uops_12_lrs1;	// util.scala:466:20
  reg  [5:0]        uops_12_lrs2;	// util.scala:466:20
  reg  [5:0]        uops_12_lrs3;	// util.scala:466:20
  reg               uops_12_ldst_val;	// util.scala:466:20
  reg  [1:0]        uops_12_dst_rtype;	// util.scala:466:20
  reg  [1:0]        uops_12_lrs1_rtype;	// util.scala:466:20
  reg  [1:0]        uops_12_lrs2_rtype;	// util.scala:466:20
  reg               uops_12_frs3_en;	// util.scala:466:20
  reg               uops_12_fp_val;	// util.scala:466:20
  reg               uops_12_fp_single;	// util.scala:466:20
  reg               uops_12_xcpt_pf_if;	// util.scala:466:20
  reg               uops_12_xcpt_ae_if;	// util.scala:466:20
  reg               uops_12_xcpt_ma_if;	// util.scala:466:20
  reg               uops_12_bp_debug_if;	// util.scala:466:20
  reg               uops_12_bp_xcpt_if;	// util.scala:466:20
  reg  [1:0]        uops_12_debug_fsrc;	// util.scala:466:20
  reg  [1:0]        uops_12_debug_tsrc;	// util.scala:466:20
  reg  [6:0]        uops_13_uopc;	// util.scala:466:20
  reg  [31:0]       uops_13_inst;	// util.scala:466:20
  reg  [31:0]       uops_13_debug_inst;	// util.scala:466:20
  reg               uops_13_is_rvc;	// util.scala:466:20
  reg  [39:0]       uops_13_debug_pc;	// util.scala:466:20
  reg  [2:0]        uops_13_iq_type;	// util.scala:466:20
  reg  [9:0]        uops_13_fu_code;	// util.scala:466:20
  reg  [3:0]        uops_13_ctrl_br_type;	// util.scala:466:20
  reg  [1:0]        uops_13_ctrl_op1_sel;	// util.scala:466:20
  reg  [2:0]        uops_13_ctrl_op2_sel;	// util.scala:466:20
  reg  [2:0]        uops_13_ctrl_imm_sel;	// util.scala:466:20
  reg  [3:0]        uops_13_ctrl_op_fcn;	// util.scala:466:20
  reg               uops_13_ctrl_fcn_dw;	// util.scala:466:20
  reg  [2:0]        uops_13_ctrl_csr_cmd;	// util.scala:466:20
  reg               uops_13_ctrl_is_load;	// util.scala:466:20
  reg               uops_13_ctrl_is_sta;	// util.scala:466:20
  reg               uops_13_ctrl_is_std;	// util.scala:466:20
  reg  [1:0]        uops_13_iw_state;	// util.scala:466:20
  reg               uops_13_iw_p1_poisoned;	// util.scala:466:20
  reg               uops_13_iw_p2_poisoned;	// util.scala:466:20
  reg               uops_13_is_br;	// util.scala:466:20
  reg               uops_13_is_jalr;	// util.scala:466:20
  reg               uops_13_is_jal;	// util.scala:466:20
  reg               uops_13_is_sfb;	// util.scala:466:20
  reg  [19:0]       uops_13_br_mask;	// util.scala:466:20
  reg  [4:0]        uops_13_br_tag;	// util.scala:466:20
  reg  [5:0]        uops_13_ftq_idx;	// util.scala:466:20
  reg               uops_13_edge_inst;	// util.scala:466:20
  reg  [5:0]        uops_13_pc_lob;	// util.scala:466:20
  reg               uops_13_taken;	// util.scala:466:20
  reg  [19:0]       uops_13_imm_packed;	// util.scala:466:20
  reg  [11:0]       uops_13_csr_addr;	// util.scala:466:20
  reg  [6:0]        uops_13_rob_idx;	// util.scala:466:20
  reg  [4:0]        uops_13_ldq_idx;	// util.scala:466:20
  reg  [4:0]        uops_13_stq_idx;	// util.scala:466:20
  reg  [1:0]        uops_13_rxq_idx;	// util.scala:466:20
  reg  [6:0]        uops_13_pdst;	// util.scala:466:20
  reg  [6:0]        uops_13_prs1;	// util.scala:466:20
  reg  [6:0]        uops_13_prs2;	// util.scala:466:20
  reg  [6:0]        uops_13_prs3;	// util.scala:466:20
  reg  [5:0]        uops_13_ppred;	// util.scala:466:20
  reg               uops_13_prs1_busy;	// util.scala:466:20
  reg               uops_13_prs2_busy;	// util.scala:466:20
  reg               uops_13_prs3_busy;	// util.scala:466:20
  reg               uops_13_ppred_busy;	// util.scala:466:20
  reg  [6:0]        uops_13_stale_pdst;	// util.scala:466:20
  reg               uops_13_exception;	// util.scala:466:20
  reg  [63:0]       uops_13_exc_cause;	// util.scala:466:20
  reg               uops_13_bypassable;	// util.scala:466:20
  reg  [4:0]        uops_13_mem_cmd;	// util.scala:466:20
  reg  [1:0]        uops_13_mem_size;	// util.scala:466:20
  reg               uops_13_mem_signed;	// util.scala:466:20
  reg               uops_13_is_fence;	// util.scala:466:20
  reg               uops_13_is_fencei;	// util.scala:466:20
  reg               uops_13_is_amo;	// util.scala:466:20
  reg               uops_13_uses_ldq;	// util.scala:466:20
  reg               uops_13_uses_stq;	// util.scala:466:20
  reg               uops_13_is_sys_pc2epc;	// util.scala:466:20
  reg               uops_13_is_unique;	// util.scala:466:20
  reg               uops_13_flush_on_commit;	// util.scala:466:20
  reg               uops_13_ldst_is_rs1;	// util.scala:466:20
  reg  [5:0]        uops_13_ldst;	// util.scala:466:20
  reg  [5:0]        uops_13_lrs1;	// util.scala:466:20
  reg  [5:0]        uops_13_lrs2;	// util.scala:466:20
  reg  [5:0]        uops_13_lrs3;	// util.scala:466:20
  reg               uops_13_ldst_val;	// util.scala:466:20
  reg  [1:0]        uops_13_dst_rtype;	// util.scala:466:20
  reg  [1:0]        uops_13_lrs1_rtype;	// util.scala:466:20
  reg  [1:0]        uops_13_lrs2_rtype;	// util.scala:466:20
  reg               uops_13_frs3_en;	// util.scala:466:20
  reg               uops_13_fp_val;	// util.scala:466:20
  reg               uops_13_fp_single;	// util.scala:466:20
  reg               uops_13_xcpt_pf_if;	// util.scala:466:20
  reg               uops_13_xcpt_ae_if;	// util.scala:466:20
  reg               uops_13_xcpt_ma_if;	// util.scala:466:20
  reg               uops_13_bp_debug_if;	// util.scala:466:20
  reg               uops_13_bp_xcpt_if;	// util.scala:466:20
  reg  [1:0]        uops_13_debug_fsrc;	// util.scala:466:20
  reg  [1:0]        uops_13_debug_tsrc;	// util.scala:466:20
  reg  [6:0]        uops_14_uopc;	// util.scala:466:20
  reg  [31:0]       uops_14_inst;	// util.scala:466:20
  reg  [31:0]       uops_14_debug_inst;	// util.scala:466:20
  reg               uops_14_is_rvc;	// util.scala:466:20
  reg  [39:0]       uops_14_debug_pc;	// util.scala:466:20
  reg  [2:0]        uops_14_iq_type;	// util.scala:466:20
  reg  [9:0]        uops_14_fu_code;	// util.scala:466:20
  reg  [3:0]        uops_14_ctrl_br_type;	// util.scala:466:20
  reg  [1:0]        uops_14_ctrl_op1_sel;	// util.scala:466:20
  reg  [2:0]        uops_14_ctrl_op2_sel;	// util.scala:466:20
  reg  [2:0]        uops_14_ctrl_imm_sel;	// util.scala:466:20
  reg  [3:0]        uops_14_ctrl_op_fcn;	// util.scala:466:20
  reg               uops_14_ctrl_fcn_dw;	// util.scala:466:20
  reg  [2:0]        uops_14_ctrl_csr_cmd;	// util.scala:466:20
  reg               uops_14_ctrl_is_load;	// util.scala:466:20
  reg               uops_14_ctrl_is_sta;	// util.scala:466:20
  reg               uops_14_ctrl_is_std;	// util.scala:466:20
  reg  [1:0]        uops_14_iw_state;	// util.scala:466:20
  reg               uops_14_iw_p1_poisoned;	// util.scala:466:20
  reg               uops_14_iw_p2_poisoned;	// util.scala:466:20
  reg               uops_14_is_br;	// util.scala:466:20
  reg               uops_14_is_jalr;	// util.scala:466:20
  reg               uops_14_is_jal;	// util.scala:466:20
  reg               uops_14_is_sfb;	// util.scala:466:20
  reg  [19:0]       uops_14_br_mask;	// util.scala:466:20
  reg  [4:0]        uops_14_br_tag;	// util.scala:466:20
  reg  [5:0]        uops_14_ftq_idx;	// util.scala:466:20
  reg               uops_14_edge_inst;	// util.scala:466:20
  reg  [5:0]        uops_14_pc_lob;	// util.scala:466:20
  reg               uops_14_taken;	// util.scala:466:20
  reg  [19:0]       uops_14_imm_packed;	// util.scala:466:20
  reg  [11:0]       uops_14_csr_addr;	// util.scala:466:20
  reg  [6:0]        uops_14_rob_idx;	// util.scala:466:20
  reg  [4:0]        uops_14_ldq_idx;	// util.scala:466:20
  reg  [4:0]        uops_14_stq_idx;	// util.scala:466:20
  reg  [1:0]        uops_14_rxq_idx;	// util.scala:466:20
  reg  [6:0]        uops_14_pdst;	// util.scala:466:20
  reg  [6:0]        uops_14_prs1;	// util.scala:466:20
  reg  [6:0]        uops_14_prs2;	// util.scala:466:20
  reg  [6:0]        uops_14_prs3;	// util.scala:466:20
  reg  [5:0]        uops_14_ppred;	// util.scala:466:20
  reg               uops_14_prs1_busy;	// util.scala:466:20
  reg               uops_14_prs2_busy;	// util.scala:466:20
  reg               uops_14_prs3_busy;	// util.scala:466:20
  reg               uops_14_ppred_busy;	// util.scala:466:20
  reg  [6:0]        uops_14_stale_pdst;	// util.scala:466:20
  reg               uops_14_exception;	// util.scala:466:20
  reg  [63:0]       uops_14_exc_cause;	// util.scala:466:20
  reg               uops_14_bypassable;	// util.scala:466:20
  reg  [4:0]        uops_14_mem_cmd;	// util.scala:466:20
  reg  [1:0]        uops_14_mem_size;	// util.scala:466:20
  reg               uops_14_mem_signed;	// util.scala:466:20
  reg               uops_14_is_fence;	// util.scala:466:20
  reg               uops_14_is_fencei;	// util.scala:466:20
  reg               uops_14_is_amo;	// util.scala:466:20
  reg               uops_14_uses_ldq;	// util.scala:466:20
  reg               uops_14_uses_stq;	// util.scala:466:20
  reg               uops_14_is_sys_pc2epc;	// util.scala:466:20
  reg               uops_14_is_unique;	// util.scala:466:20
  reg               uops_14_flush_on_commit;	// util.scala:466:20
  reg               uops_14_ldst_is_rs1;	// util.scala:466:20
  reg  [5:0]        uops_14_ldst;	// util.scala:466:20
  reg  [5:0]        uops_14_lrs1;	// util.scala:466:20
  reg  [5:0]        uops_14_lrs2;	// util.scala:466:20
  reg  [5:0]        uops_14_lrs3;	// util.scala:466:20
  reg               uops_14_ldst_val;	// util.scala:466:20
  reg  [1:0]        uops_14_dst_rtype;	// util.scala:466:20
  reg  [1:0]        uops_14_lrs1_rtype;	// util.scala:466:20
  reg  [1:0]        uops_14_lrs2_rtype;	// util.scala:466:20
  reg               uops_14_frs3_en;	// util.scala:466:20
  reg               uops_14_fp_val;	// util.scala:466:20
  reg               uops_14_fp_single;	// util.scala:466:20
  reg               uops_14_xcpt_pf_if;	// util.scala:466:20
  reg               uops_14_xcpt_ae_if;	// util.scala:466:20
  reg               uops_14_xcpt_ma_if;	// util.scala:466:20
  reg               uops_14_bp_debug_if;	// util.scala:466:20
  reg               uops_14_bp_xcpt_if;	// util.scala:466:20
  reg  [1:0]        uops_14_debug_fsrc;	// util.scala:466:20
  reg  [1:0]        uops_14_debug_tsrc;	// util.scala:466:20
  reg  [6:0]        uops_15_uopc;	// util.scala:466:20
  reg  [31:0]       uops_15_inst;	// util.scala:466:20
  reg  [31:0]       uops_15_debug_inst;	// util.scala:466:20
  reg               uops_15_is_rvc;	// util.scala:466:20
  reg  [39:0]       uops_15_debug_pc;	// util.scala:466:20
  reg  [2:0]        uops_15_iq_type;	// util.scala:466:20
  reg  [9:0]        uops_15_fu_code;	// util.scala:466:20
  reg  [3:0]        uops_15_ctrl_br_type;	// util.scala:466:20
  reg  [1:0]        uops_15_ctrl_op1_sel;	// util.scala:466:20
  reg  [2:0]        uops_15_ctrl_op2_sel;	// util.scala:466:20
  reg  [2:0]        uops_15_ctrl_imm_sel;	// util.scala:466:20
  reg  [3:0]        uops_15_ctrl_op_fcn;	// util.scala:466:20
  reg               uops_15_ctrl_fcn_dw;	// util.scala:466:20
  reg  [2:0]        uops_15_ctrl_csr_cmd;	// util.scala:466:20
  reg               uops_15_ctrl_is_load;	// util.scala:466:20
  reg               uops_15_ctrl_is_sta;	// util.scala:466:20
  reg               uops_15_ctrl_is_std;	// util.scala:466:20
  reg  [1:0]        uops_15_iw_state;	// util.scala:466:20
  reg               uops_15_iw_p1_poisoned;	// util.scala:466:20
  reg               uops_15_iw_p2_poisoned;	// util.scala:466:20
  reg               uops_15_is_br;	// util.scala:466:20
  reg               uops_15_is_jalr;	// util.scala:466:20
  reg               uops_15_is_jal;	// util.scala:466:20
  reg               uops_15_is_sfb;	// util.scala:466:20
  reg  [19:0]       uops_15_br_mask;	// util.scala:466:20
  reg  [4:0]        uops_15_br_tag;	// util.scala:466:20
  reg  [5:0]        uops_15_ftq_idx;	// util.scala:466:20
  reg               uops_15_edge_inst;	// util.scala:466:20
  reg  [5:0]        uops_15_pc_lob;	// util.scala:466:20
  reg               uops_15_taken;	// util.scala:466:20
  reg  [19:0]       uops_15_imm_packed;	// util.scala:466:20
  reg  [11:0]       uops_15_csr_addr;	// util.scala:466:20
  reg  [6:0]        uops_15_rob_idx;	// util.scala:466:20
  reg  [4:0]        uops_15_ldq_idx;	// util.scala:466:20
  reg  [4:0]        uops_15_stq_idx;	// util.scala:466:20
  reg  [1:0]        uops_15_rxq_idx;	// util.scala:466:20
  reg  [6:0]        uops_15_pdst;	// util.scala:466:20
  reg  [6:0]        uops_15_prs1;	// util.scala:466:20
  reg  [6:0]        uops_15_prs2;	// util.scala:466:20
  reg  [6:0]        uops_15_prs3;	// util.scala:466:20
  reg  [5:0]        uops_15_ppred;	// util.scala:466:20
  reg               uops_15_prs1_busy;	// util.scala:466:20
  reg               uops_15_prs2_busy;	// util.scala:466:20
  reg               uops_15_prs3_busy;	// util.scala:466:20
  reg               uops_15_ppred_busy;	// util.scala:466:20
  reg  [6:0]        uops_15_stale_pdst;	// util.scala:466:20
  reg               uops_15_exception;	// util.scala:466:20
  reg  [63:0]       uops_15_exc_cause;	// util.scala:466:20
  reg               uops_15_bypassable;	// util.scala:466:20
  reg  [4:0]        uops_15_mem_cmd;	// util.scala:466:20
  reg  [1:0]        uops_15_mem_size;	// util.scala:466:20
  reg               uops_15_mem_signed;	// util.scala:466:20
  reg               uops_15_is_fence;	// util.scala:466:20
  reg               uops_15_is_fencei;	// util.scala:466:20
  reg               uops_15_is_amo;	// util.scala:466:20
  reg               uops_15_uses_ldq;	// util.scala:466:20
  reg               uops_15_uses_stq;	// util.scala:466:20
  reg               uops_15_is_sys_pc2epc;	// util.scala:466:20
  reg               uops_15_is_unique;	// util.scala:466:20
  reg               uops_15_flush_on_commit;	// util.scala:466:20
  reg               uops_15_ldst_is_rs1;	// util.scala:466:20
  reg  [5:0]        uops_15_ldst;	// util.scala:466:20
  reg  [5:0]        uops_15_lrs1;	// util.scala:466:20
  reg  [5:0]        uops_15_lrs2;	// util.scala:466:20
  reg  [5:0]        uops_15_lrs3;	// util.scala:466:20
  reg               uops_15_ldst_val;	// util.scala:466:20
  reg  [1:0]        uops_15_dst_rtype;	// util.scala:466:20
  reg  [1:0]        uops_15_lrs1_rtype;	// util.scala:466:20
  reg  [1:0]        uops_15_lrs2_rtype;	// util.scala:466:20
  reg               uops_15_frs3_en;	// util.scala:466:20
  reg               uops_15_fp_val;	// util.scala:466:20
  reg               uops_15_fp_single;	// util.scala:466:20
  reg               uops_15_xcpt_pf_if;	// util.scala:466:20
  reg               uops_15_xcpt_ae_if;	// util.scala:466:20
  reg               uops_15_xcpt_ma_if;	// util.scala:466:20
  reg               uops_15_bp_debug_if;	// util.scala:466:20
  reg               uops_15_bp_xcpt_if;	// util.scala:466:20
  reg  [1:0]        uops_15_debug_fsrc;	// util.scala:466:20
  reg  [1:0]        uops_15_debug_tsrc;	// util.scala:466:20
  reg  [3:0]        value;	// Counter.scala:60:40
  reg  [3:0]        value_1;	// Counter.scala:60:40
  reg               maybe_full;	// util.scala:470:27
  wire              ptr_match = value == value_1;	// Counter.scala:60:40, util.scala:472:33
  wire              _io_empty_output = ptr_match & ~maybe_full;	// util.scala:470:27, :472:33, :473:{25,28}
  wire              full = ptr_match & maybe_full;	// util.scala:470:27, :472:33, :474:24
  wire              do_enq = ~full & io_enq_valid;	// Decoupled.scala:40:37, util.scala:474:24, :504:19
  wire [15:0]       _GEN =
    {{valids_15},
     {valids_14},
     {valids_13},
     {valids_12},
     {valids_11},
     {valids_10},
     {valids_9},
     {valids_8},
     {valids_7},
     {valids_6},
     {valids_5},
     {valids_4},
     {valids_3},
     {valids_2},
     {valids_1},
     {valids_0}};	// util.scala:465:24, :476:42
  wire              _GEN_0 = _GEN[value_1];	// Counter.scala:60:40, util.scala:476:42
  wire [15:0][6:0]  _GEN_1 =
    {{uops_15_uopc},
     {uops_14_uopc},
     {uops_13_uopc},
     {uops_12_uopc},
     {uops_11_uopc},
     {uops_10_uopc},
     {uops_9_uopc},
     {uops_8_uopc},
     {uops_7_uopc},
     {uops_6_uopc},
     {uops_5_uopc},
     {uops_4_uopc},
     {uops_3_uopc},
     {uops_2_uopc},
     {uops_1_uopc},
     {uops_0_uopc}};	// util.scala:466:20, :508:19
  wire [15:0][31:0] _GEN_2 =
    {{uops_15_inst},
     {uops_14_inst},
     {uops_13_inst},
     {uops_12_inst},
     {uops_11_inst},
     {uops_10_inst},
     {uops_9_inst},
     {uops_8_inst},
     {uops_7_inst},
     {uops_6_inst},
     {uops_5_inst},
     {uops_4_inst},
     {uops_3_inst},
     {uops_2_inst},
     {uops_1_inst},
     {uops_0_inst}};	// util.scala:466:20, :508:19
  wire [15:0][31:0] _GEN_3 =
    {{uops_15_debug_inst},
     {uops_14_debug_inst},
     {uops_13_debug_inst},
     {uops_12_debug_inst},
     {uops_11_debug_inst},
     {uops_10_debug_inst},
     {uops_9_debug_inst},
     {uops_8_debug_inst},
     {uops_7_debug_inst},
     {uops_6_debug_inst},
     {uops_5_debug_inst},
     {uops_4_debug_inst},
     {uops_3_debug_inst},
     {uops_2_debug_inst},
     {uops_1_debug_inst},
     {uops_0_debug_inst}};	// util.scala:466:20, :508:19
  wire [15:0]       _GEN_4 =
    {{uops_15_is_rvc},
     {uops_14_is_rvc},
     {uops_13_is_rvc},
     {uops_12_is_rvc},
     {uops_11_is_rvc},
     {uops_10_is_rvc},
     {uops_9_is_rvc},
     {uops_8_is_rvc},
     {uops_7_is_rvc},
     {uops_6_is_rvc},
     {uops_5_is_rvc},
     {uops_4_is_rvc},
     {uops_3_is_rvc},
     {uops_2_is_rvc},
     {uops_1_is_rvc},
     {uops_0_is_rvc}};	// util.scala:466:20, :508:19
  wire [15:0][39:0] _GEN_5 =
    {{uops_15_debug_pc},
     {uops_14_debug_pc},
     {uops_13_debug_pc},
     {uops_12_debug_pc},
     {uops_11_debug_pc},
     {uops_10_debug_pc},
     {uops_9_debug_pc},
     {uops_8_debug_pc},
     {uops_7_debug_pc},
     {uops_6_debug_pc},
     {uops_5_debug_pc},
     {uops_4_debug_pc},
     {uops_3_debug_pc},
     {uops_2_debug_pc},
     {uops_1_debug_pc},
     {uops_0_debug_pc}};	// util.scala:466:20, :508:19
  wire [15:0][2:0]  _GEN_6 =
    {{uops_15_iq_type},
     {uops_14_iq_type},
     {uops_13_iq_type},
     {uops_12_iq_type},
     {uops_11_iq_type},
     {uops_10_iq_type},
     {uops_9_iq_type},
     {uops_8_iq_type},
     {uops_7_iq_type},
     {uops_6_iq_type},
     {uops_5_iq_type},
     {uops_4_iq_type},
     {uops_3_iq_type},
     {uops_2_iq_type},
     {uops_1_iq_type},
     {uops_0_iq_type}};	// util.scala:466:20, :508:19
  wire [15:0][9:0]  _GEN_7 =
    {{uops_15_fu_code},
     {uops_14_fu_code},
     {uops_13_fu_code},
     {uops_12_fu_code},
     {uops_11_fu_code},
     {uops_10_fu_code},
     {uops_9_fu_code},
     {uops_8_fu_code},
     {uops_7_fu_code},
     {uops_6_fu_code},
     {uops_5_fu_code},
     {uops_4_fu_code},
     {uops_3_fu_code},
     {uops_2_fu_code},
     {uops_1_fu_code},
     {uops_0_fu_code}};	// util.scala:466:20, :508:19
  wire [15:0][3:0]  _GEN_8 =
    {{uops_15_ctrl_br_type},
     {uops_14_ctrl_br_type},
     {uops_13_ctrl_br_type},
     {uops_12_ctrl_br_type},
     {uops_11_ctrl_br_type},
     {uops_10_ctrl_br_type},
     {uops_9_ctrl_br_type},
     {uops_8_ctrl_br_type},
     {uops_7_ctrl_br_type},
     {uops_6_ctrl_br_type},
     {uops_5_ctrl_br_type},
     {uops_4_ctrl_br_type},
     {uops_3_ctrl_br_type},
     {uops_2_ctrl_br_type},
     {uops_1_ctrl_br_type},
     {uops_0_ctrl_br_type}};	// util.scala:466:20, :508:19
  wire [15:0][1:0]  _GEN_9 =
    {{uops_15_ctrl_op1_sel},
     {uops_14_ctrl_op1_sel},
     {uops_13_ctrl_op1_sel},
     {uops_12_ctrl_op1_sel},
     {uops_11_ctrl_op1_sel},
     {uops_10_ctrl_op1_sel},
     {uops_9_ctrl_op1_sel},
     {uops_8_ctrl_op1_sel},
     {uops_7_ctrl_op1_sel},
     {uops_6_ctrl_op1_sel},
     {uops_5_ctrl_op1_sel},
     {uops_4_ctrl_op1_sel},
     {uops_3_ctrl_op1_sel},
     {uops_2_ctrl_op1_sel},
     {uops_1_ctrl_op1_sel},
     {uops_0_ctrl_op1_sel}};	// util.scala:466:20, :508:19
  wire [15:0][2:0]  _GEN_10 =
    {{uops_15_ctrl_op2_sel},
     {uops_14_ctrl_op2_sel},
     {uops_13_ctrl_op2_sel},
     {uops_12_ctrl_op2_sel},
     {uops_11_ctrl_op2_sel},
     {uops_10_ctrl_op2_sel},
     {uops_9_ctrl_op2_sel},
     {uops_8_ctrl_op2_sel},
     {uops_7_ctrl_op2_sel},
     {uops_6_ctrl_op2_sel},
     {uops_5_ctrl_op2_sel},
     {uops_4_ctrl_op2_sel},
     {uops_3_ctrl_op2_sel},
     {uops_2_ctrl_op2_sel},
     {uops_1_ctrl_op2_sel},
     {uops_0_ctrl_op2_sel}};	// util.scala:466:20, :508:19
  wire [15:0][2:0]  _GEN_11 =
    {{uops_15_ctrl_imm_sel},
     {uops_14_ctrl_imm_sel},
     {uops_13_ctrl_imm_sel},
     {uops_12_ctrl_imm_sel},
     {uops_11_ctrl_imm_sel},
     {uops_10_ctrl_imm_sel},
     {uops_9_ctrl_imm_sel},
     {uops_8_ctrl_imm_sel},
     {uops_7_ctrl_imm_sel},
     {uops_6_ctrl_imm_sel},
     {uops_5_ctrl_imm_sel},
     {uops_4_ctrl_imm_sel},
     {uops_3_ctrl_imm_sel},
     {uops_2_ctrl_imm_sel},
     {uops_1_ctrl_imm_sel},
     {uops_0_ctrl_imm_sel}};	// util.scala:466:20, :508:19
  wire [15:0][3:0]  _GEN_12 =
    {{uops_15_ctrl_op_fcn},
     {uops_14_ctrl_op_fcn},
     {uops_13_ctrl_op_fcn},
     {uops_12_ctrl_op_fcn},
     {uops_11_ctrl_op_fcn},
     {uops_10_ctrl_op_fcn},
     {uops_9_ctrl_op_fcn},
     {uops_8_ctrl_op_fcn},
     {uops_7_ctrl_op_fcn},
     {uops_6_ctrl_op_fcn},
     {uops_5_ctrl_op_fcn},
     {uops_4_ctrl_op_fcn},
     {uops_3_ctrl_op_fcn},
     {uops_2_ctrl_op_fcn},
     {uops_1_ctrl_op_fcn},
     {uops_0_ctrl_op_fcn}};	// util.scala:466:20, :508:19
  wire [15:0]       _GEN_13 =
    {{uops_15_ctrl_fcn_dw},
     {uops_14_ctrl_fcn_dw},
     {uops_13_ctrl_fcn_dw},
     {uops_12_ctrl_fcn_dw},
     {uops_11_ctrl_fcn_dw},
     {uops_10_ctrl_fcn_dw},
     {uops_9_ctrl_fcn_dw},
     {uops_8_ctrl_fcn_dw},
     {uops_7_ctrl_fcn_dw},
     {uops_6_ctrl_fcn_dw},
     {uops_5_ctrl_fcn_dw},
     {uops_4_ctrl_fcn_dw},
     {uops_3_ctrl_fcn_dw},
     {uops_2_ctrl_fcn_dw},
     {uops_1_ctrl_fcn_dw},
     {uops_0_ctrl_fcn_dw}};	// util.scala:466:20, :508:19
  wire [15:0][2:0]  _GEN_14 =
    {{uops_15_ctrl_csr_cmd},
     {uops_14_ctrl_csr_cmd},
     {uops_13_ctrl_csr_cmd},
     {uops_12_ctrl_csr_cmd},
     {uops_11_ctrl_csr_cmd},
     {uops_10_ctrl_csr_cmd},
     {uops_9_ctrl_csr_cmd},
     {uops_8_ctrl_csr_cmd},
     {uops_7_ctrl_csr_cmd},
     {uops_6_ctrl_csr_cmd},
     {uops_5_ctrl_csr_cmd},
     {uops_4_ctrl_csr_cmd},
     {uops_3_ctrl_csr_cmd},
     {uops_2_ctrl_csr_cmd},
     {uops_1_ctrl_csr_cmd},
     {uops_0_ctrl_csr_cmd}};	// util.scala:466:20, :508:19
  wire [15:0]       _GEN_15 =
    {{uops_15_ctrl_is_load},
     {uops_14_ctrl_is_load},
     {uops_13_ctrl_is_load},
     {uops_12_ctrl_is_load},
     {uops_11_ctrl_is_load},
     {uops_10_ctrl_is_load},
     {uops_9_ctrl_is_load},
     {uops_8_ctrl_is_load},
     {uops_7_ctrl_is_load},
     {uops_6_ctrl_is_load},
     {uops_5_ctrl_is_load},
     {uops_4_ctrl_is_load},
     {uops_3_ctrl_is_load},
     {uops_2_ctrl_is_load},
     {uops_1_ctrl_is_load},
     {uops_0_ctrl_is_load}};	// util.scala:466:20, :508:19
  wire [15:0]       _GEN_16 =
    {{uops_15_ctrl_is_sta},
     {uops_14_ctrl_is_sta},
     {uops_13_ctrl_is_sta},
     {uops_12_ctrl_is_sta},
     {uops_11_ctrl_is_sta},
     {uops_10_ctrl_is_sta},
     {uops_9_ctrl_is_sta},
     {uops_8_ctrl_is_sta},
     {uops_7_ctrl_is_sta},
     {uops_6_ctrl_is_sta},
     {uops_5_ctrl_is_sta},
     {uops_4_ctrl_is_sta},
     {uops_3_ctrl_is_sta},
     {uops_2_ctrl_is_sta},
     {uops_1_ctrl_is_sta},
     {uops_0_ctrl_is_sta}};	// util.scala:466:20, :508:19
  wire [15:0]       _GEN_17 =
    {{uops_15_ctrl_is_std},
     {uops_14_ctrl_is_std},
     {uops_13_ctrl_is_std},
     {uops_12_ctrl_is_std},
     {uops_11_ctrl_is_std},
     {uops_10_ctrl_is_std},
     {uops_9_ctrl_is_std},
     {uops_8_ctrl_is_std},
     {uops_7_ctrl_is_std},
     {uops_6_ctrl_is_std},
     {uops_5_ctrl_is_std},
     {uops_4_ctrl_is_std},
     {uops_3_ctrl_is_std},
     {uops_2_ctrl_is_std},
     {uops_1_ctrl_is_std},
     {uops_0_ctrl_is_std}};	// util.scala:466:20, :508:19
  wire [15:0][1:0]  _GEN_18 =
    {{uops_15_iw_state},
     {uops_14_iw_state},
     {uops_13_iw_state},
     {uops_12_iw_state},
     {uops_11_iw_state},
     {uops_10_iw_state},
     {uops_9_iw_state},
     {uops_8_iw_state},
     {uops_7_iw_state},
     {uops_6_iw_state},
     {uops_5_iw_state},
     {uops_4_iw_state},
     {uops_3_iw_state},
     {uops_2_iw_state},
     {uops_1_iw_state},
     {uops_0_iw_state}};	// util.scala:466:20, :508:19
  wire [15:0]       _GEN_19 =
    {{uops_15_iw_p1_poisoned},
     {uops_14_iw_p1_poisoned},
     {uops_13_iw_p1_poisoned},
     {uops_12_iw_p1_poisoned},
     {uops_11_iw_p1_poisoned},
     {uops_10_iw_p1_poisoned},
     {uops_9_iw_p1_poisoned},
     {uops_8_iw_p1_poisoned},
     {uops_7_iw_p1_poisoned},
     {uops_6_iw_p1_poisoned},
     {uops_5_iw_p1_poisoned},
     {uops_4_iw_p1_poisoned},
     {uops_3_iw_p1_poisoned},
     {uops_2_iw_p1_poisoned},
     {uops_1_iw_p1_poisoned},
     {uops_0_iw_p1_poisoned}};	// util.scala:466:20, :508:19
  wire [15:0]       _GEN_20 =
    {{uops_15_iw_p2_poisoned},
     {uops_14_iw_p2_poisoned},
     {uops_13_iw_p2_poisoned},
     {uops_12_iw_p2_poisoned},
     {uops_11_iw_p2_poisoned},
     {uops_10_iw_p2_poisoned},
     {uops_9_iw_p2_poisoned},
     {uops_8_iw_p2_poisoned},
     {uops_7_iw_p2_poisoned},
     {uops_6_iw_p2_poisoned},
     {uops_5_iw_p2_poisoned},
     {uops_4_iw_p2_poisoned},
     {uops_3_iw_p2_poisoned},
     {uops_2_iw_p2_poisoned},
     {uops_1_iw_p2_poisoned},
     {uops_0_iw_p2_poisoned}};	// util.scala:466:20, :508:19
  wire [15:0]       _GEN_21 =
    {{uops_15_is_br},
     {uops_14_is_br},
     {uops_13_is_br},
     {uops_12_is_br},
     {uops_11_is_br},
     {uops_10_is_br},
     {uops_9_is_br},
     {uops_8_is_br},
     {uops_7_is_br},
     {uops_6_is_br},
     {uops_5_is_br},
     {uops_4_is_br},
     {uops_3_is_br},
     {uops_2_is_br},
     {uops_1_is_br},
     {uops_0_is_br}};	// util.scala:466:20, :508:19
  wire [15:0]       _GEN_22 =
    {{uops_15_is_jalr},
     {uops_14_is_jalr},
     {uops_13_is_jalr},
     {uops_12_is_jalr},
     {uops_11_is_jalr},
     {uops_10_is_jalr},
     {uops_9_is_jalr},
     {uops_8_is_jalr},
     {uops_7_is_jalr},
     {uops_6_is_jalr},
     {uops_5_is_jalr},
     {uops_4_is_jalr},
     {uops_3_is_jalr},
     {uops_2_is_jalr},
     {uops_1_is_jalr},
     {uops_0_is_jalr}};	// util.scala:466:20, :508:19
  wire [15:0]       _GEN_23 =
    {{uops_15_is_jal},
     {uops_14_is_jal},
     {uops_13_is_jal},
     {uops_12_is_jal},
     {uops_11_is_jal},
     {uops_10_is_jal},
     {uops_9_is_jal},
     {uops_8_is_jal},
     {uops_7_is_jal},
     {uops_6_is_jal},
     {uops_5_is_jal},
     {uops_4_is_jal},
     {uops_3_is_jal},
     {uops_2_is_jal},
     {uops_1_is_jal},
     {uops_0_is_jal}};	// util.scala:466:20, :508:19
  wire [15:0]       _GEN_24 =
    {{uops_15_is_sfb},
     {uops_14_is_sfb},
     {uops_13_is_sfb},
     {uops_12_is_sfb},
     {uops_11_is_sfb},
     {uops_10_is_sfb},
     {uops_9_is_sfb},
     {uops_8_is_sfb},
     {uops_7_is_sfb},
     {uops_6_is_sfb},
     {uops_5_is_sfb},
     {uops_4_is_sfb},
     {uops_3_is_sfb},
     {uops_2_is_sfb},
     {uops_1_is_sfb},
     {uops_0_is_sfb}};	// util.scala:466:20, :508:19
  wire [15:0][19:0] _GEN_25 =
    {{uops_15_br_mask},
     {uops_14_br_mask},
     {uops_13_br_mask},
     {uops_12_br_mask},
     {uops_11_br_mask},
     {uops_10_br_mask},
     {uops_9_br_mask},
     {uops_8_br_mask},
     {uops_7_br_mask},
     {uops_6_br_mask},
     {uops_5_br_mask},
     {uops_4_br_mask},
     {uops_3_br_mask},
     {uops_2_br_mask},
     {uops_1_br_mask},
     {uops_0_br_mask}};	// util.scala:466:20, :508:19
  wire [19:0]       out_uop_br_mask = _GEN_25[value_1];	// Counter.scala:60:40, util.scala:508:19
  wire [15:0][4:0]  _GEN_26 =
    {{uops_15_br_tag},
     {uops_14_br_tag},
     {uops_13_br_tag},
     {uops_12_br_tag},
     {uops_11_br_tag},
     {uops_10_br_tag},
     {uops_9_br_tag},
     {uops_8_br_tag},
     {uops_7_br_tag},
     {uops_6_br_tag},
     {uops_5_br_tag},
     {uops_4_br_tag},
     {uops_3_br_tag},
     {uops_2_br_tag},
     {uops_1_br_tag},
     {uops_0_br_tag}};	// util.scala:466:20, :508:19
  wire [15:0][5:0]  _GEN_27 =
    {{uops_15_ftq_idx},
     {uops_14_ftq_idx},
     {uops_13_ftq_idx},
     {uops_12_ftq_idx},
     {uops_11_ftq_idx},
     {uops_10_ftq_idx},
     {uops_9_ftq_idx},
     {uops_8_ftq_idx},
     {uops_7_ftq_idx},
     {uops_6_ftq_idx},
     {uops_5_ftq_idx},
     {uops_4_ftq_idx},
     {uops_3_ftq_idx},
     {uops_2_ftq_idx},
     {uops_1_ftq_idx},
     {uops_0_ftq_idx}};	// util.scala:466:20, :508:19
  wire [15:0]       _GEN_28 =
    {{uops_15_edge_inst},
     {uops_14_edge_inst},
     {uops_13_edge_inst},
     {uops_12_edge_inst},
     {uops_11_edge_inst},
     {uops_10_edge_inst},
     {uops_9_edge_inst},
     {uops_8_edge_inst},
     {uops_7_edge_inst},
     {uops_6_edge_inst},
     {uops_5_edge_inst},
     {uops_4_edge_inst},
     {uops_3_edge_inst},
     {uops_2_edge_inst},
     {uops_1_edge_inst},
     {uops_0_edge_inst}};	// util.scala:466:20, :508:19
  wire [15:0][5:0]  _GEN_29 =
    {{uops_15_pc_lob},
     {uops_14_pc_lob},
     {uops_13_pc_lob},
     {uops_12_pc_lob},
     {uops_11_pc_lob},
     {uops_10_pc_lob},
     {uops_9_pc_lob},
     {uops_8_pc_lob},
     {uops_7_pc_lob},
     {uops_6_pc_lob},
     {uops_5_pc_lob},
     {uops_4_pc_lob},
     {uops_3_pc_lob},
     {uops_2_pc_lob},
     {uops_1_pc_lob},
     {uops_0_pc_lob}};	// util.scala:466:20, :508:19
  wire [15:0]       _GEN_30 =
    {{uops_15_taken},
     {uops_14_taken},
     {uops_13_taken},
     {uops_12_taken},
     {uops_11_taken},
     {uops_10_taken},
     {uops_9_taken},
     {uops_8_taken},
     {uops_7_taken},
     {uops_6_taken},
     {uops_5_taken},
     {uops_4_taken},
     {uops_3_taken},
     {uops_2_taken},
     {uops_1_taken},
     {uops_0_taken}};	// util.scala:466:20, :508:19
  wire [15:0][19:0] _GEN_31 =
    {{uops_15_imm_packed},
     {uops_14_imm_packed},
     {uops_13_imm_packed},
     {uops_12_imm_packed},
     {uops_11_imm_packed},
     {uops_10_imm_packed},
     {uops_9_imm_packed},
     {uops_8_imm_packed},
     {uops_7_imm_packed},
     {uops_6_imm_packed},
     {uops_5_imm_packed},
     {uops_4_imm_packed},
     {uops_3_imm_packed},
     {uops_2_imm_packed},
     {uops_1_imm_packed},
     {uops_0_imm_packed}};	// util.scala:466:20, :508:19
  wire [15:0][11:0] _GEN_32 =
    {{uops_15_csr_addr},
     {uops_14_csr_addr},
     {uops_13_csr_addr},
     {uops_12_csr_addr},
     {uops_11_csr_addr},
     {uops_10_csr_addr},
     {uops_9_csr_addr},
     {uops_8_csr_addr},
     {uops_7_csr_addr},
     {uops_6_csr_addr},
     {uops_5_csr_addr},
     {uops_4_csr_addr},
     {uops_3_csr_addr},
     {uops_2_csr_addr},
     {uops_1_csr_addr},
     {uops_0_csr_addr}};	// util.scala:466:20, :508:19
  wire [15:0][6:0]  _GEN_33 =
    {{uops_15_rob_idx},
     {uops_14_rob_idx},
     {uops_13_rob_idx},
     {uops_12_rob_idx},
     {uops_11_rob_idx},
     {uops_10_rob_idx},
     {uops_9_rob_idx},
     {uops_8_rob_idx},
     {uops_7_rob_idx},
     {uops_6_rob_idx},
     {uops_5_rob_idx},
     {uops_4_rob_idx},
     {uops_3_rob_idx},
     {uops_2_rob_idx},
     {uops_1_rob_idx},
     {uops_0_rob_idx}};	// util.scala:466:20, :508:19
  wire [15:0][4:0]  _GEN_34 =
    {{uops_15_ldq_idx},
     {uops_14_ldq_idx},
     {uops_13_ldq_idx},
     {uops_12_ldq_idx},
     {uops_11_ldq_idx},
     {uops_10_ldq_idx},
     {uops_9_ldq_idx},
     {uops_8_ldq_idx},
     {uops_7_ldq_idx},
     {uops_6_ldq_idx},
     {uops_5_ldq_idx},
     {uops_4_ldq_idx},
     {uops_3_ldq_idx},
     {uops_2_ldq_idx},
     {uops_1_ldq_idx},
     {uops_0_ldq_idx}};	// util.scala:466:20, :508:19
  wire [15:0][4:0]  _GEN_35 =
    {{uops_15_stq_idx},
     {uops_14_stq_idx},
     {uops_13_stq_idx},
     {uops_12_stq_idx},
     {uops_11_stq_idx},
     {uops_10_stq_idx},
     {uops_9_stq_idx},
     {uops_8_stq_idx},
     {uops_7_stq_idx},
     {uops_6_stq_idx},
     {uops_5_stq_idx},
     {uops_4_stq_idx},
     {uops_3_stq_idx},
     {uops_2_stq_idx},
     {uops_1_stq_idx},
     {uops_0_stq_idx}};	// util.scala:466:20, :508:19
  wire [15:0][1:0]  _GEN_36 =
    {{uops_15_rxq_idx},
     {uops_14_rxq_idx},
     {uops_13_rxq_idx},
     {uops_12_rxq_idx},
     {uops_11_rxq_idx},
     {uops_10_rxq_idx},
     {uops_9_rxq_idx},
     {uops_8_rxq_idx},
     {uops_7_rxq_idx},
     {uops_6_rxq_idx},
     {uops_5_rxq_idx},
     {uops_4_rxq_idx},
     {uops_3_rxq_idx},
     {uops_2_rxq_idx},
     {uops_1_rxq_idx},
     {uops_0_rxq_idx}};	// util.scala:466:20, :508:19
  wire [15:0][6:0]  _GEN_37 =
    {{uops_15_pdst},
     {uops_14_pdst},
     {uops_13_pdst},
     {uops_12_pdst},
     {uops_11_pdst},
     {uops_10_pdst},
     {uops_9_pdst},
     {uops_8_pdst},
     {uops_7_pdst},
     {uops_6_pdst},
     {uops_5_pdst},
     {uops_4_pdst},
     {uops_3_pdst},
     {uops_2_pdst},
     {uops_1_pdst},
     {uops_0_pdst}};	// util.scala:466:20, :508:19
  wire [15:0][6:0]  _GEN_38 =
    {{uops_15_prs1},
     {uops_14_prs1},
     {uops_13_prs1},
     {uops_12_prs1},
     {uops_11_prs1},
     {uops_10_prs1},
     {uops_9_prs1},
     {uops_8_prs1},
     {uops_7_prs1},
     {uops_6_prs1},
     {uops_5_prs1},
     {uops_4_prs1},
     {uops_3_prs1},
     {uops_2_prs1},
     {uops_1_prs1},
     {uops_0_prs1}};	// util.scala:466:20, :508:19
  wire [15:0][6:0]  _GEN_39 =
    {{uops_15_prs2},
     {uops_14_prs2},
     {uops_13_prs2},
     {uops_12_prs2},
     {uops_11_prs2},
     {uops_10_prs2},
     {uops_9_prs2},
     {uops_8_prs2},
     {uops_7_prs2},
     {uops_6_prs2},
     {uops_5_prs2},
     {uops_4_prs2},
     {uops_3_prs2},
     {uops_2_prs2},
     {uops_1_prs2},
     {uops_0_prs2}};	// util.scala:466:20, :508:19
  wire [15:0][6:0]  _GEN_40 =
    {{uops_15_prs3},
     {uops_14_prs3},
     {uops_13_prs3},
     {uops_12_prs3},
     {uops_11_prs3},
     {uops_10_prs3},
     {uops_9_prs3},
     {uops_8_prs3},
     {uops_7_prs3},
     {uops_6_prs3},
     {uops_5_prs3},
     {uops_4_prs3},
     {uops_3_prs3},
     {uops_2_prs3},
     {uops_1_prs3},
     {uops_0_prs3}};	// util.scala:466:20, :508:19
  wire [15:0][5:0]  _GEN_41 =
    {{uops_15_ppred},
     {uops_14_ppred},
     {uops_13_ppred},
     {uops_12_ppred},
     {uops_11_ppred},
     {uops_10_ppred},
     {uops_9_ppred},
     {uops_8_ppred},
     {uops_7_ppred},
     {uops_6_ppred},
     {uops_5_ppred},
     {uops_4_ppred},
     {uops_3_ppred},
     {uops_2_ppred},
     {uops_1_ppred},
     {uops_0_ppred}};	// util.scala:466:20, :508:19
  wire [15:0]       _GEN_42 =
    {{uops_15_prs1_busy},
     {uops_14_prs1_busy},
     {uops_13_prs1_busy},
     {uops_12_prs1_busy},
     {uops_11_prs1_busy},
     {uops_10_prs1_busy},
     {uops_9_prs1_busy},
     {uops_8_prs1_busy},
     {uops_7_prs1_busy},
     {uops_6_prs1_busy},
     {uops_5_prs1_busy},
     {uops_4_prs1_busy},
     {uops_3_prs1_busy},
     {uops_2_prs1_busy},
     {uops_1_prs1_busy},
     {uops_0_prs1_busy}};	// util.scala:466:20, :508:19
  wire [15:0]       _GEN_43 =
    {{uops_15_prs2_busy},
     {uops_14_prs2_busy},
     {uops_13_prs2_busy},
     {uops_12_prs2_busy},
     {uops_11_prs2_busy},
     {uops_10_prs2_busy},
     {uops_9_prs2_busy},
     {uops_8_prs2_busy},
     {uops_7_prs2_busy},
     {uops_6_prs2_busy},
     {uops_5_prs2_busy},
     {uops_4_prs2_busy},
     {uops_3_prs2_busy},
     {uops_2_prs2_busy},
     {uops_1_prs2_busy},
     {uops_0_prs2_busy}};	// util.scala:466:20, :508:19
  wire [15:0]       _GEN_44 =
    {{uops_15_prs3_busy},
     {uops_14_prs3_busy},
     {uops_13_prs3_busy},
     {uops_12_prs3_busy},
     {uops_11_prs3_busy},
     {uops_10_prs3_busy},
     {uops_9_prs3_busy},
     {uops_8_prs3_busy},
     {uops_7_prs3_busy},
     {uops_6_prs3_busy},
     {uops_5_prs3_busy},
     {uops_4_prs3_busy},
     {uops_3_prs3_busy},
     {uops_2_prs3_busy},
     {uops_1_prs3_busy},
     {uops_0_prs3_busy}};	// util.scala:466:20, :508:19
  wire [15:0]       _GEN_45 =
    {{uops_15_ppred_busy},
     {uops_14_ppred_busy},
     {uops_13_ppred_busy},
     {uops_12_ppred_busy},
     {uops_11_ppred_busy},
     {uops_10_ppred_busy},
     {uops_9_ppred_busy},
     {uops_8_ppred_busy},
     {uops_7_ppred_busy},
     {uops_6_ppred_busy},
     {uops_5_ppred_busy},
     {uops_4_ppred_busy},
     {uops_3_ppred_busy},
     {uops_2_ppred_busy},
     {uops_1_ppred_busy},
     {uops_0_ppred_busy}};	// util.scala:466:20, :508:19
  wire [15:0][6:0]  _GEN_46 =
    {{uops_15_stale_pdst},
     {uops_14_stale_pdst},
     {uops_13_stale_pdst},
     {uops_12_stale_pdst},
     {uops_11_stale_pdst},
     {uops_10_stale_pdst},
     {uops_9_stale_pdst},
     {uops_8_stale_pdst},
     {uops_7_stale_pdst},
     {uops_6_stale_pdst},
     {uops_5_stale_pdst},
     {uops_4_stale_pdst},
     {uops_3_stale_pdst},
     {uops_2_stale_pdst},
     {uops_1_stale_pdst},
     {uops_0_stale_pdst}};	// util.scala:466:20, :508:19
  wire [15:0]       _GEN_47 =
    {{uops_15_exception},
     {uops_14_exception},
     {uops_13_exception},
     {uops_12_exception},
     {uops_11_exception},
     {uops_10_exception},
     {uops_9_exception},
     {uops_8_exception},
     {uops_7_exception},
     {uops_6_exception},
     {uops_5_exception},
     {uops_4_exception},
     {uops_3_exception},
     {uops_2_exception},
     {uops_1_exception},
     {uops_0_exception}};	// util.scala:466:20, :508:19
  wire [15:0][63:0] _GEN_48 =
    {{uops_15_exc_cause},
     {uops_14_exc_cause},
     {uops_13_exc_cause},
     {uops_12_exc_cause},
     {uops_11_exc_cause},
     {uops_10_exc_cause},
     {uops_9_exc_cause},
     {uops_8_exc_cause},
     {uops_7_exc_cause},
     {uops_6_exc_cause},
     {uops_5_exc_cause},
     {uops_4_exc_cause},
     {uops_3_exc_cause},
     {uops_2_exc_cause},
     {uops_1_exc_cause},
     {uops_0_exc_cause}};	// util.scala:466:20, :508:19
  wire [15:0]       _GEN_49 =
    {{uops_15_bypassable},
     {uops_14_bypassable},
     {uops_13_bypassable},
     {uops_12_bypassable},
     {uops_11_bypassable},
     {uops_10_bypassable},
     {uops_9_bypassable},
     {uops_8_bypassable},
     {uops_7_bypassable},
     {uops_6_bypassable},
     {uops_5_bypassable},
     {uops_4_bypassable},
     {uops_3_bypassable},
     {uops_2_bypassable},
     {uops_1_bypassable},
     {uops_0_bypassable}};	// util.scala:466:20, :508:19
  wire [15:0][4:0]  _GEN_50 =
    {{uops_15_mem_cmd},
     {uops_14_mem_cmd},
     {uops_13_mem_cmd},
     {uops_12_mem_cmd},
     {uops_11_mem_cmd},
     {uops_10_mem_cmd},
     {uops_9_mem_cmd},
     {uops_8_mem_cmd},
     {uops_7_mem_cmd},
     {uops_6_mem_cmd},
     {uops_5_mem_cmd},
     {uops_4_mem_cmd},
     {uops_3_mem_cmd},
     {uops_2_mem_cmd},
     {uops_1_mem_cmd},
     {uops_0_mem_cmd}};	// util.scala:466:20, :508:19
  wire [15:0][1:0]  _GEN_51 =
    {{uops_15_mem_size},
     {uops_14_mem_size},
     {uops_13_mem_size},
     {uops_12_mem_size},
     {uops_11_mem_size},
     {uops_10_mem_size},
     {uops_9_mem_size},
     {uops_8_mem_size},
     {uops_7_mem_size},
     {uops_6_mem_size},
     {uops_5_mem_size},
     {uops_4_mem_size},
     {uops_3_mem_size},
     {uops_2_mem_size},
     {uops_1_mem_size},
     {uops_0_mem_size}};	// util.scala:466:20, :508:19
  wire [15:0]       _GEN_52 =
    {{uops_15_mem_signed},
     {uops_14_mem_signed},
     {uops_13_mem_signed},
     {uops_12_mem_signed},
     {uops_11_mem_signed},
     {uops_10_mem_signed},
     {uops_9_mem_signed},
     {uops_8_mem_signed},
     {uops_7_mem_signed},
     {uops_6_mem_signed},
     {uops_5_mem_signed},
     {uops_4_mem_signed},
     {uops_3_mem_signed},
     {uops_2_mem_signed},
     {uops_1_mem_signed},
     {uops_0_mem_signed}};	// util.scala:466:20, :508:19
  wire [15:0]       _GEN_53 =
    {{uops_15_is_fence},
     {uops_14_is_fence},
     {uops_13_is_fence},
     {uops_12_is_fence},
     {uops_11_is_fence},
     {uops_10_is_fence},
     {uops_9_is_fence},
     {uops_8_is_fence},
     {uops_7_is_fence},
     {uops_6_is_fence},
     {uops_5_is_fence},
     {uops_4_is_fence},
     {uops_3_is_fence},
     {uops_2_is_fence},
     {uops_1_is_fence},
     {uops_0_is_fence}};	// util.scala:466:20, :508:19
  wire [15:0]       _GEN_54 =
    {{uops_15_is_fencei},
     {uops_14_is_fencei},
     {uops_13_is_fencei},
     {uops_12_is_fencei},
     {uops_11_is_fencei},
     {uops_10_is_fencei},
     {uops_9_is_fencei},
     {uops_8_is_fencei},
     {uops_7_is_fencei},
     {uops_6_is_fencei},
     {uops_5_is_fencei},
     {uops_4_is_fencei},
     {uops_3_is_fencei},
     {uops_2_is_fencei},
     {uops_1_is_fencei},
     {uops_0_is_fencei}};	// util.scala:466:20, :508:19
  wire [15:0]       _GEN_55 =
    {{uops_15_is_amo},
     {uops_14_is_amo},
     {uops_13_is_amo},
     {uops_12_is_amo},
     {uops_11_is_amo},
     {uops_10_is_amo},
     {uops_9_is_amo},
     {uops_8_is_amo},
     {uops_7_is_amo},
     {uops_6_is_amo},
     {uops_5_is_amo},
     {uops_4_is_amo},
     {uops_3_is_amo},
     {uops_2_is_amo},
     {uops_1_is_amo},
     {uops_0_is_amo}};	// util.scala:466:20, :508:19
  wire [15:0]       _GEN_56 =
    {{uops_15_uses_ldq},
     {uops_14_uses_ldq},
     {uops_13_uses_ldq},
     {uops_12_uses_ldq},
     {uops_11_uses_ldq},
     {uops_10_uses_ldq},
     {uops_9_uses_ldq},
     {uops_8_uses_ldq},
     {uops_7_uses_ldq},
     {uops_6_uses_ldq},
     {uops_5_uses_ldq},
     {uops_4_uses_ldq},
     {uops_3_uses_ldq},
     {uops_2_uses_ldq},
     {uops_1_uses_ldq},
     {uops_0_uses_ldq}};	// util.scala:466:20, :508:19
  wire              out_uop_uses_ldq = _GEN_56[value_1];	// Counter.scala:60:40, util.scala:508:19
  wire [15:0]       _GEN_57 =
    {{uops_15_uses_stq},
     {uops_14_uses_stq},
     {uops_13_uses_stq},
     {uops_12_uses_stq},
     {uops_11_uses_stq},
     {uops_10_uses_stq},
     {uops_9_uses_stq},
     {uops_8_uses_stq},
     {uops_7_uses_stq},
     {uops_6_uses_stq},
     {uops_5_uses_stq},
     {uops_4_uses_stq},
     {uops_3_uses_stq},
     {uops_2_uses_stq},
     {uops_1_uses_stq},
     {uops_0_uses_stq}};	// util.scala:466:20, :508:19
  wire [15:0]       _GEN_58 =
    {{uops_15_is_sys_pc2epc},
     {uops_14_is_sys_pc2epc},
     {uops_13_is_sys_pc2epc},
     {uops_12_is_sys_pc2epc},
     {uops_11_is_sys_pc2epc},
     {uops_10_is_sys_pc2epc},
     {uops_9_is_sys_pc2epc},
     {uops_8_is_sys_pc2epc},
     {uops_7_is_sys_pc2epc},
     {uops_6_is_sys_pc2epc},
     {uops_5_is_sys_pc2epc},
     {uops_4_is_sys_pc2epc},
     {uops_3_is_sys_pc2epc},
     {uops_2_is_sys_pc2epc},
     {uops_1_is_sys_pc2epc},
     {uops_0_is_sys_pc2epc}};	// util.scala:466:20, :508:19
  wire [15:0]       _GEN_59 =
    {{uops_15_is_unique},
     {uops_14_is_unique},
     {uops_13_is_unique},
     {uops_12_is_unique},
     {uops_11_is_unique},
     {uops_10_is_unique},
     {uops_9_is_unique},
     {uops_8_is_unique},
     {uops_7_is_unique},
     {uops_6_is_unique},
     {uops_5_is_unique},
     {uops_4_is_unique},
     {uops_3_is_unique},
     {uops_2_is_unique},
     {uops_1_is_unique},
     {uops_0_is_unique}};	// util.scala:466:20, :508:19
  wire [15:0]       _GEN_60 =
    {{uops_15_flush_on_commit},
     {uops_14_flush_on_commit},
     {uops_13_flush_on_commit},
     {uops_12_flush_on_commit},
     {uops_11_flush_on_commit},
     {uops_10_flush_on_commit},
     {uops_9_flush_on_commit},
     {uops_8_flush_on_commit},
     {uops_7_flush_on_commit},
     {uops_6_flush_on_commit},
     {uops_5_flush_on_commit},
     {uops_4_flush_on_commit},
     {uops_3_flush_on_commit},
     {uops_2_flush_on_commit},
     {uops_1_flush_on_commit},
     {uops_0_flush_on_commit}};	// util.scala:466:20, :508:19
  wire [15:0]       _GEN_61 =
    {{uops_15_ldst_is_rs1},
     {uops_14_ldst_is_rs1},
     {uops_13_ldst_is_rs1},
     {uops_12_ldst_is_rs1},
     {uops_11_ldst_is_rs1},
     {uops_10_ldst_is_rs1},
     {uops_9_ldst_is_rs1},
     {uops_8_ldst_is_rs1},
     {uops_7_ldst_is_rs1},
     {uops_6_ldst_is_rs1},
     {uops_5_ldst_is_rs1},
     {uops_4_ldst_is_rs1},
     {uops_3_ldst_is_rs1},
     {uops_2_ldst_is_rs1},
     {uops_1_ldst_is_rs1},
     {uops_0_ldst_is_rs1}};	// util.scala:466:20, :508:19
  wire [15:0][5:0]  _GEN_62 =
    {{uops_15_ldst},
     {uops_14_ldst},
     {uops_13_ldst},
     {uops_12_ldst},
     {uops_11_ldst},
     {uops_10_ldst},
     {uops_9_ldst},
     {uops_8_ldst},
     {uops_7_ldst},
     {uops_6_ldst},
     {uops_5_ldst},
     {uops_4_ldst},
     {uops_3_ldst},
     {uops_2_ldst},
     {uops_1_ldst},
     {uops_0_ldst}};	// util.scala:466:20, :508:19
  wire [15:0][5:0]  _GEN_63 =
    {{uops_15_lrs1},
     {uops_14_lrs1},
     {uops_13_lrs1},
     {uops_12_lrs1},
     {uops_11_lrs1},
     {uops_10_lrs1},
     {uops_9_lrs1},
     {uops_8_lrs1},
     {uops_7_lrs1},
     {uops_6_lrs1},
     {uops_5_lrs1},
     {uops_4_lrs1},
     {uops_3_lrs1},
     {uops_2_lrs1},
     {uops_1_lrs1},
     {uops_0_lrs1}};	// util.scala:466:20, :508:19
  wire [15:0][5:0]  _GEN_64 =
    {{uops_15_lrs2},
     {uops_14_lrs2},
     {uops_13_lrs2},
     {uops_12_lrs2},
     {uops_11_lrs2},
     {uops_10_lrs2},
     {uops_9_lrs2},
     {uops_8_lrs2},
     {uops_7_lrs2},
     {uops_6_lrs2},
     {uops_5_lrs2},
     {uops_4_lrs2},
     {uops_3_lrs2},
     {uops_2_lrs2},
     {uops_1_lrs2},
     {uops_0_lrs2}};	// util.scala:466:20, :508:19
  wire [15:0][5:0]  _GEN_65 =
    {{uops_15_lrs3},
     {uops_14_lrs3},
     {uops_13_lrs3},
     {uops_12_lrs3},
     {uops_11_lrs3},
     {uops_10_lrs3},
     {uops_9_lrs3},
     {uops_8_lrs3},
     {uops_7_lrs3},
     {uops_6_lrs3},
     {uops_5_lrs3},
     {uops_4_lrs3},
     {uops_3_lrs3},
     {uops_2_lrs3},
     {uops_1_lrs3},
     {uops_0_lrs3}};	// util.scala:466:20, :508:19
  wire [15:0]       _GEN_66 =
    {{uops_15_ldst_val},
     {uops_14_ldst_val},
     {uops_13_ldst_val},
     {uops_12_ldst_val},
     {uops_11_ldst_val},
     {uops_10_ldst_val},
     {uops_9_ldst_val},
     {uops_8_ldst_val},
     {uops_7_ldst_val},
     {uops_6_ldst_val},
     {uops_5_ldst_val},
     {uops_4_ldst_val},
     {uops_3_ldst_val},
     {uops_2_ldst_val},
     {uops_1_ldst_val},
     {uops_0_ldst_val}};	// util.scala:466:20, :508:19
  wire [15:0][1:0]  _GEN_67 =
    {{uops_15_dst_rtype},
     {uops_14_dst_rtype},
     {uops_13_dst_rtype},
     {uops_12_dst_rtype},
     {uops_11_dst_rtype},
     {uops_10_dst_rtype},
     {uops_9_dst_rtype},
     {uops_8_dst_rtype},
     {uops_7_dst_rtype},
     {uops_6_dst_rtype},
     {uops_5_dst_rtype},
     {uops_4_dst_rtype},
     {uops_3_dst_rtype},
     {uops_2_dst_rtype},
     {uops_1_dst_rtype},
     {uops_0_dst_rtype}};	// util.scala:466:20, :508:19
  wire [15:0][1:0]  _GEN_68 =
    {{uops_15_lrs1_rtype},
     {uops_14_lrs1_rtype},
     {uops_13_lrs1_rtype},
     {uops_12_lrs1_rtype},
     {uops_11_lrs1_rtype},
     {uops_10_lrs1_rtype},
     {uops_9_lrs1_rtype},
     {uops_8_lrs1_rtype},
     {uops_7_lrs1_rtype},
     {uops_6_lrs1_rtype},
     {uops_5_lrs1_rtype},
     {uops_4_lrs1_rtype},
     {uops_3_lrs1_rtype},
     {uops_2_lrs1_rtype},
     {uops_1_lrs1_rtype},
     {uops_0_lrs1_rtype}};	// util.scala:466:20, :508:19
  wire [15:0][1:0]  _GEN_69 =
    {{uops_15_lrs2_rtype},
     {uops_14_lrs2_rtype},
     {uops_13_lrs2_rtype},
     {uops_12_lrs2_rtype},
     {uops_11_lrs2_rtype},
     {uops_10_lrs2_rtype},
     {uops_9_lrs2_rtype},
     {uops_8_lrs2_rtype},
     {uops_7_lrs2_rtype},
     {uops_6_lrs2_rtype},
     {uops_5_lrs2_rtype},
     {uops_4_lrs2_rtype},
     {uops_3_lrs2_rtype},
     {uops_2_lrs2_rtype},
     {uops_1_lrs2_rtype},
     {uops_0_lrs2_rtype}};	// util.scala:466:20, :508:19
  wire [15:0]       _GEN_70 =
    {{uops_15_frs3_en},
     {uops_14_frs3_en},
     {uops_13_frs3_en},
     {uops_12_frs3_en},
     {uops_11_frs3_en},
     {uops_10_frs3_en},
     {uops_9_frs3_en},
     {uops_8_frs3_en},
     {uops_7_frs3_en},
     {uops_6_frs3_en},
     {uops_5_frs3_en},
     {uops_4_frs3_en},
     {uops_3_frs3_en},
     {uops_2_frs3_en},
     {uops_1_frs3_en},
     {uops_0_frs3_en}};	// util.scala:466:20, :508:19
  wire [15:0]       _GEN_71 =
    {{uops_15_fp_val},
     {uops_14_fp_val},
     {uops_13_fp_val},
     {uops_12_fp_val},
     {uops_11_fp_val},
     {uops_10_fp_val},
     {uops_9_fp_val},
     {uops_8_fp_val},
     {uops_7_fp_val},
     {uops_6_fp_val},
     {uops_5_fp_val},
     {uops_4_fp_val},
     {uops_3_fp_val},
     {uops_2_fp_val},
     {uops_1_fp_val},
     {uops_0_fp_val}};	// util.scala:466:20, :508:19
  wire [15:0]       _GEN_72 =
    {{uops_15_fp_single},
     {uops_14_fp_single},
     {uops_13_fp_single},
     {uops_12_fp_single},
     {uops_11_fp_single},
     {uops_10_fp_single},
     {uops_9_fp_single},
     {uops_8_fp_single},
     {uops_7_fp_single},
     {uops_6_fp_single},
     {uops_5_fp_single},
     {uops_4_fp_single},
     {uops_3_fp_single},
     {uops_2_fp_single},
     {uops_1_fp_single},
     {uops_0_fp_single}};	// util.scala:466:20, :508:19
  wire [15:0]       _GEN_73 =
    {{uops_15_xcpt_pf_if},
     {uops_14_xcpt_pf_if},
     {uops_13_xcpt_pf_if},
     {uops_12_xcpt_pf_if},
     {uops_11_xcpt_pf_if},
     {uops_10_xcpt_pf_if},
     {uops_9_xcpt_pf_if},
     {uops_8_xcpt_pf_if},
     {uops_7_xcpt_pf_if},
     {uops_6_xcpt_pf_if},
     {uops_5_xcpt_pf_if},
     {uops_4_xcpt_pf_if},
     {uops_3_xcpt_pf_if},
     {uops_2_xcpt_pf_if},
     {uops_1_xcpt_pf_if},
     {uops_0_xcpt_pf_if}};	// util.scala:466:20, :508:19
  wire [15:0]       _GEN_74 =
    {{uops_15_xcpt_ae_if},
     {uops_14_xcpt_ae_if},
     {uops_13_xcpt_ae_if},
     {uops_12_xcpt_ae_if},
     {uops_11_xcpt_ae_if},
     {uops_10_xcpt_ae_if},
     {uops_9_xcpt_ae_if},
     {uops_8_xcpt_ae_if},
     {uops_7_xcpt_ae_if},
     {uops_6_xcpt_ae_if},
     {uops_5_xcpt_ae_if},
     {uops_4_xcpt_ae_if},
     {uops_3_xcpt_ae_if},
     {uops_2_xcpt_ae_if},
     {uops_1_xcpt_ae_if},
     {uops_0_xcpt_ae_if}};	// util.scala:466:20, :508:19
  wire [15:0]       _GEN_75 =
    {{uops_15_xcpt_ma_if},
     {uops_14_xcpt_ma_if},
     {uops_13_xcpt_ma_if},
     {uops_12_xcpt_ma_if},
     {uops_11_xcpt_ma_if},
     {uops_10_xcpt_ma_if},
     {uops_9_xcpt_ma_if},
     {uops_8_xcpt_ma_if},
     {uops_7_xcpt_ma_if},
     {uops_6_xcpt_ma_if},
     {uops_5_xcpt_ma_if},
     {uops_4_xcpt_ma_if},
     {uops_3_xcpt_ma_if},
     {uops_2_xcpt_ma_if},
     {uops_1_xcpt_ma_if},
     {uops_0_xcpt_ma_if}};	// util.scala:466:20, :508:19
  wire [15:0]       _GEN_76 =
    {{uops_15_bp_debug_if},
     {uops_14_bp_debug_if},
     {uops_13_bp_debug_if},
     {uops_12_bp_debug_if},
     {uops_11_bp_debug_if},
     {uops_10_bp_debug_if},
     {uops_9_bp_debug_if},
     {uops_8_bp_debug_if},
     {uops_7_bp_debug_if},
     {uops_6_bp_debug_if},
     {uops_5_bp_debug_if},
     {uops_4_bp_debug_if},
     {uops_3_bp_debug_if},
     {uops_2_bp_debug_if},
     {uops_1_bp_debug_if},
     {uops_0_bp_debug_if}};	// util.scala:466:20, :508:19
  wire [15:0]       _GEN_77 =
    {{uops_15_bp_xcpt_if},
     {uops_14_bp_xcpt_if},
     {uops_13_bp_xcpt_if},
     {uops_12_bp_xcpt_if},
     {uops_11_bp_xcpt_if},
     {uops_10_bp_xcpt_if},
     {uops_9_bp_xcpt_if},
     {uops_8_bp_xcpt_if},
     {uops_7_bp_xcpt_if},
     {uops_6_bp_xcpt_if},
     {uops_5_bp_xcpt_if},
     {uops_4_bp_xcpt_if},
     {uops_3_bp_xcpt_if},
     {uops_2_bp_xcpt_if},
     {uops_1_bp_xcpt_if},
     {uops_0_bp_xcpt_if}};	// util.scala:466:20, :508:19
  wire [15:0][1:0]  _GEN_78 =
    {{uops_15_debug_fsrc},
     {uops_14_debug_fsrc},
     {uops_13_debug_fsrc},
     {uops_12_debug_fsrc},
     {uops_11_debug_fsrc},
     {uops_10_debug_fsrc},
     {uops_9_debug_fsrc},
     {uops_8_debug_fsrc},
     {uops_7_debug_fsrc},
     {uops_6_debug_fsrc},
     {uops_5_debug_fsrc},
     {uops_4_debug_fsrc},
     {uops_3_debug_fsrc},
     {uops_2_debug_fsrc},
     {uops_1_debug_fsrc},
     {uops_0_debug_fsrc}};	// util.scala:466:20, :508:19
  wire [15:0][1:0]  _GEN_79 =
    {{uops_15_debug_tsrc},
     {uops_14_debug_tsrc},
     {uops_13_debug_tsrc},
     {uops_12_debug_tsrc},
     {uops_11_debug_tsrc},
     {uops_10_debug_tsrc},
     {uops_9_debug_tsrc},
     {uops_8_debug_tsrc},
     {uops_7_debug_tsrc},
     {uops_6_debug_tsrc},
     {uops_5_debug_tsrc},
     {uops_4_debug_tsrc},
     {uops_3_debug_tsrc},
     {uops_2_debug_tsrc},
     {uops_1_debug_tsrc},
     {uops_0_debug_tsrc}};	// util.scala:466:20, :508:19
  always @(posedge clock) begin
    automatic logic        _GEN_80;	// util.scala:489:33
    automatic logic        _GEN_81;	// util.scala:481:16, :487:17, :489:33
    automatic logic        _GEN_82;	// util.scala:489:33
    automatic logic        _GEN_83;	// util.scala:481:16, :487:17, :489:33
    automatic logic        _GEN_84;	// util.scala:489:33
    automatic logic        _GEN_85;	// util.scala:481:16, :487:17, :489:33
    automatic logic        _GEN_86;	// util.scala:489:33
    automatic logic        _GEN_87;	// util.scala:481:16, :487:17, :489:33
    automatic logic        _GEN_88;	// util.scala:489:33
    automatic logic        _GEN_89;	// util.scala:481:16, :487:17, :489:33
    automatic logic        _GEN_90;	// util.scala:489:33
    automatic logic        _GEN_91;	// util.scala:481:16, :487:17, :489:33
    automatic logic        _GEN_92;	// util.scala:489:33
    automatic logic        _GEN_93;	// util.scala:481:16, :487:17, :489:33
    automatic logic        _GEN_94;	// util.scala:489:33
    automatic logic        _GEN_95;	// util.scala:481:16, :487:17, :489:33
    automatic logic        _GEN_96;	// util.scala:489:33
    automatic logic        _GEN_97;	// util.scala:481:16, :487:17, :489:33
    automatic logic        _GEN_98;	// util.scala:489:33
    automatic logic        _GEN_99;	// util.scala:481:16, :487:17, :489:33
    automatic logic        _GEN_100;	// util.scala:489:33
    automatic logic        _GEN_101;	// util.scala:481:16, :487:17, :489:33
    automatic logic        _GEN_102;	// util.scala:489:33
    automatic logic        _GEN_103;	// util.scala:481:16, :487:17, :489:33
    automatic logic        _GEN_104;	// util.scala:489:33
    automatic logic        _GEN_105;	// util.scala:481:16, :487:17, :489:33
    automatic logic        _GEN_106;	// util.scala:489:33
    automatic logic        _GEN_107;	// util.scala:481:16, :487:17, :489:33
    automatic logic        _GEN_108;	// util.scala:489:33
    automatic logic        _GEN_109;	// util.scala:481:16, :487:17, :489:33
    automatic logic        _GEN_110;	// util.scala:481:16, :487:17, :489:33
    automatic logic [19:0] _uops_br_mask_T_1;	// util.scala:85:25
    _GEN_80 = value == 4'h0;	// Counter.scala:60:40, util.scala:489:33
    _GEN_81 = do_enq & _GEN_80;	// Decoupled.scala:40:37, util.scala:481:16, :487:17, :489:33
    _GEN_82 = value == 4'h1;	// Counter.scala:60:40, util.scala:489:33
    _GEN_83 = do_enq & _GEN_82;	// Decoupled.scala:40:37, util.scala:481:16, :487:17, :489:33
    _GEN_84 = value == 4'h2;	// Counter.scala:60:40, util.scala:489:33
    _GEN_85 = do_enq & _GEN_84;	// Decoupled.scala:40:37, util.scala:481:16, :487:17, :489:33
    _GEN_86 = value == 4'h3;	// Counter.scala:60:40, util.scala:489:33
    _GEN_87 = do_enq & _GEN_86;	// Decoupled.scala:40:37, util.scala:481:16, :487:17, :489:33
    _GEN_88 = value == 4'h4;	// Counter.scala:60:40, util.scala:489:33
    _GEN_89 = do_enq & _GEN_88;	// Decoupled.scala:40:37, util.scala:481:16, :487:17, :489:33
    _GEN_90 = value == 4'h5;	// Counter.scala:60:40, util.scala:489:33
    _GEN_91 = do_enq & _GEN_90;	// Decoupled.scala:40:37, util.scala:481:16, :487:17, :489:33
    _GEN_92 = value == 4'h6;	// Counter.scala:60:40, util.scala:489:33
    _GEN_93 = do_enq & _GEN_92;	// Decoupled.scala:40:37, util.scala:481:16, :487:17, :489:33
    _GEN_94 = value == 4'h7;	// Counter.scala:60:40, util.scala:489:33
    _GEN_95 = do_enq & _GEN_94;	// Decoupled.scala:40:37, util.scala:481:16, :487:17, :489:33
    _GEN_96 = value == 4'h8;	// Counter.scala:60:40, util.scala:489:33
    _GEN_97 = do_enq & _GEN_96;	// Decoupled.scala:40:37, util.scala:481:16, :487:17, :489:33
    _GEN_98 = value == 4'h9;	// Counter.scala:60:40, util.scala:489:33
    _GEN_99 = do_enq & _GEN_98;	// Decoupled.scala:40:37, util.scala:481:16, :487:17, :489:33
    _GEN_100 = value == 4'hA;	// Counter.scala:60:40, util.scala:489:33
    _GEN_101 = do_enq & _GEN_100;	// Decoupled.scala:40:37, util.scala:481:16, :487:17, :489:33
    _GEN_102 = value == 4'hB;	// Counter.scala:60:40, util.scala:489:33
    _GEN_103 = do_enq & _GEN_102;	// Decoupled.scala:40:37, util.scala:481:16, :487:17, :489:33
    _GEN_104 = value == 4'hC;	// Counter.scala:60:40, util.scala:489:33
    _GEN_105 = do_enq & _GEN_104;	// Decoupled.scala:40:37, util.scala:481:16, :487:17, :489:33
    _GEN_106 = value == 4'hD;	// Counter.scala:60:40, util.scala:489:33
    _GEN_107 = do_enq & _GEN_106;	// Decoupled.scala:40:37, util.scala:481:16, :487:17, :489:33
    _GEN_108 = value == 4'hE;	// Counter.scala:60:40, util.scala:489:33
    _GEN_109 = do_enq & _GEN_108;	// Decoupled.scala:40:37, util.scala:481:16, :487:17, :489:33
    _GEN_110 = do_enq & (&value);	// Counter.scala:60:40, Decoupled.scala:40:37, util.scala:481:16, :487:17, :489:33
    _uops_br_mask_T_1 = io_enq_bits_uop_br_mask & ~io_brupdate_b1_resolve_mask;	// util.scala:85:{25,27}
    if (reset) begin
      valids_0 <= 1'h0;	// util.scala:464:20, :465:24
      valids_1 <= 1'h0;	// util.scala:464:20, :465:24
      valids_2 <= 1'h0;	// util.scala:464:20, :465:24
      valids_3 <= 1'h0;	// util.scala:464:20, :465:24
      valids_4 <= 1'h0;	// util.scala:464:20, :465:24
      valids_5 <= 1'h0;	// util.scala:464:20, :465:24
      valids_6 <= 1'h0;	// util.scala:464:20, :465:24
      valids_7 <= 1'h0;	// util.scala:464:20, :465:24
      valids_8 <= 1'h0;	// util.scala:464:20, :465:24
      valids_9 <= 1'h0;	// util.scala:464:20, :465:24
      valids_10 <= 1'h0;	// util.scala:464:20, :465:24
      valids_11 <= 1'h0;	// util.scala:464:20, :465:24
      valids_12 <= 1'h0;	// util.scala:464:20, :465:24
      valids_13 <= 1'h0;	// util.scala:464:20, :465:24
      valids_14 <= 1'h0;	// util.scala:464:20, :465:24
      valids_15 <= 1'h0;	// util.scala:464:20, :465:24
      value <= 4'h0;	// Counter.scala:60:40
      value_1 <= 4'h0;	// Counter.scala:60:40
      maybe_full <= 1'h0;	// util.scala:464:20, :470:27
    end
    else begin
      automatic logic do_deq = (io_deq_ready | ~_GEN_0) & ~_io_empty_output;	// util.scala:473:25, :476:{39,42,66,69}
      valids_0 <=
        ~(do_deq & value_1 == 4'h0)
        & (_GEN_81 | valids_0 & (io_brupdate_b1_mispredict_mask & uops_0_br_mask) == 20'h0
           & ~(io_flush & uops_0_uses_ldq));	// Counter.scala:60:40, util.scala:118:{51,59}, :465:24, :466:20, :476:66, :481:{16,69,72,83}, :487:17, :489:33, :495:17, :496:27
      valids_1 <=
        ~(do_deq & value_1 == 4'h1)
        & (_GEN_83 | valids_1 & (io_brupdate_b1_mispredict_mask & uops_1_br_mask) == 20'h0
           & ~(io_flush & uops_1_uses_ldq));	// Counter.scala:60:40, util.scala:118:{51,59}, :465:24, :466:20, :476:66, :481:{16,69,72,83}, :487:17, :489:33, :495:17, :496:27
      valids_2 <=
        ~(do_deq & value_1 == 4'h2)
        & (_GEN_85 | valids_2 & (io_brupdate_b1_mispredict_mask & uops_2_br_mask) == 20'h0
           & ~(io_flush & uops_2_uses_ldq));	// Counter.scala:60:40, util.scala:118:{51,59}, :465:24, :466:20, :476:66, :481:{16,69,72,83}, :487:17, :489:33, :495:17, :496:27
      valids_3 <=
        ~(do_deq & value_1 == 4'h3)
        & (_GEN_87 | valids_3 & (io_brupdate_b1_mispredict_mask & uops_3_br_mask) == 20'h0
           & ~(io_flush & uops_3_uses_ldq));	// Counter.scala:60:40, util.scala:118:{51,59}, :465:24, :466:20, :476:66, :481:{16,69,72,83}, :487:17, :489:33, :495:17, :496:27
      valids_4 <=
        ~(do_deq & value_1 == 4'h4)
        & (_GEN_89 | valids_4 & (io_brupdate_b1_mispredict_mask & uops_4_br_mask) == 20'h0
           & ~(io_flush & uops_4_uses_ldq));	// Counter.scala:60:40, util.scala:118:{51,59}, :465:24, :466:20, :476:66, :481:{16,69,72,83}, :487:17, :489:33, :495:17, :496:27
      valids_5 <=
        ~(do_deq & value_1 == 4'h5)
        & (_GEN_91 | valids_5 & (io_brupdate_b1_mispredict_mask & uops_5_br_mask) == 20'h0
           & ~(io_flush & uops_5_uses_ldq));	// Counter.scala:60:40, util.scala:118:{51,59}, :465:24, :466:20, :476:66, :481:{16,69,72,83}, :487:17, :489:33, :495:17, :496:27
      valids_6 <=
        ~(do_deq & value_1 == 4'h6)
        & (_GEN_93 | valids_6 & (io_brupdate_b1_mispredict_mask & uops_6_br_mask) == 20'h0
           & ~(io_flush & uops_6_uses_ldq));	// Counter.scala:60:40, util.scala:118:{51,59}, :465:24, :466:20, :476:66, :481:{16,69,72,83}, :487:17, :489:33, :495:17, :496:27
      valids_7 <=
        ~(do_deq & value_1 == 4'h7)
        & (_GEN_95 | valids_7 & (io_brupdate_b1_mispredict_mask & uops_7_br_mask) == 20'h0
           & ~(io_flush & uops_7_uses_ldq));	// Counter.scala:60:40, util.scala:118:{51,59}, :465:24, :466:20, :476:66, :481:{16,69,72,83}, :487:17, :489:33, :495:17, :496:27
      valids_8 <=
        ~(do_deq & value_1 == 4'h8)
        & (_GEN_97 | valids_8 & (io_brupdate_b1_mispredict_mask & uops_8_br_mask) == 20'h0
           & ~(io_flush & uops_8_uses_ldq));	// Counter.scala:60:40, util.scala:118:{51,59}, :465:24, :466:20, :476:66, :481:{16,69,72,83}, :487:17, :489:33, :495:17, :496:27
      valids_9 <=
        ~(do_deq & value_1 == 4'h9)
        & (_GEN_99 | valids_9 & (io_brupdate_b1_mispredict_mask & uops_9_br_mask) == 20'h0
           & ~(io_flush & uops_9_uses_ldq));	// Counter.scala:60:40, util.scala:118:{51,59}, :465:24, :466:20, :476:66, :481:{16,69,72,83}, :487:17, :489:33, :495:17, :496:27
      valids_10 <=
        ~(do_deq & value_1 == 4'hA)
        & (_GEN_101 | valids_10
           & (io_brupdate_b1_mispredict_mask & uops_10_br_mask) == 20'h0
           & ~(io_flush & uops_10_uses_ldq));	// Counter.scala:60:40, util.scala:118:{51,59}, :465:24, :466:20, :476:66, :481:{16,69,72,83}, :487:17, :489:33, :495:17, :496:27
      valids_11 <=
        ~(do_deq & value_1 == 4'hB)
        & (_GEN_103 | valids_11
           & (io_brupdate_b1_mispredict_mask & uops_11_br_mask) == 20'h0
           & ~(io_flush & uops_11_uses_ldq));	// Counter.scala:60:40, util.scala:118:{51,59}, :465:24, :466:20, :476:66, :481:{16,69,72,83}, :487:17, :489:33, :495:17, :496:27
      valids_12 <=
        ~(do_deq & value_1 == 4'hC)
        & (_GEN_105 | valids_12
           & (io_brupdate_b1_mispredict_mask & uops_12_br_mask) == 20'h0
           & ~(io_flush & uops_12_uses_ldq));	// Counter.scala:60:40, util.scala:118:{51,59}, :465:24, :466:20, :476:66, :481:{16,69,72,83}, :487:17, :489:33, :495:17, :496:27
      valids_13 <=
        ~(do_deq & value_1 == 4'hD)
        & (_GEN_107 | valids_13
           & (io_brupdate_b1_mispredict_mask & uops_13_br_mask) == 20'h0
           & ~(io_flush & uops_13_uses_ldq));	// Counter.scala:60:40, util.scala:118:{51,59}, :465:24, :466:20, :476:66, :481:{16,69,72,83}, :487:17, :489:33, :495:17, :496:27
      valids_14 <=
        ~(do_deq & value_1 == 4'hE)
        & (_GEN_109 | valids_14
           & (io_brupdate_b1_mispredict_mask & uops_14_br_mask) == 20'h0
           & ~(io_flush & uops_14_uses_ldq));	// Counter.scala:60:40, util.scala:118:{51,59}, :465:24, :466:20, :476:66, :481:{16,69,72,83}, :487:17, :489:33, :495:17, :496:27
      valids_15 <=
        ~(do_deq & (&value_1))
        & (_GEN_110 | valids_15
           & (io_brupdate_b1_mispredict_mask & uops_15_br_mask) == 20'h0
           & ~(io_flush & uops_15_uses_ldq));	// Counter.scala:60:40, util.scala:118:{51,59}, :465:24, :466:20, :476:66, :481:{16,69,72,83}, :487:17, :489:33, :495:17, :496:27
      if (do_enq)	// Decoupled.scala:40:37
        value <= value + 4'h1;	// Counter.scala:60:40, :76:24, util.scala:489:33
      if (do_deq)	// util.scala:476:66
        value_1 <= value_1 + 4'h1;	// Counter.scala:60:40, :76:24, util.scala:489:33
      if (do_enq != do_deq)	// Decoupled.scala:40:37, util.scala:476:66, :500:16
        maybe_full <= do_enq;	// Decoupled.scala:40:37, util.scala:470:27
    end
    if (_GEN_81) begin	// util.scala:481:16, :487:17, :489:33
      uops_0_uopc <= io_enq_bits_uop_uopc;	// util.scala:466:20
      uops_0_inst <= io_enq_bits_uop_inst;	// util.scala:466:20
      uops_0_debug_inst <= io_enq_bits_uop_debug_inst;	// util.scala:466:20
      uops_0_is_rvc <= io_enq_bits_uop_is_rvc;	// util.scala:466:20
      uops_0_debug_pc <= io_enq_bits_uop_debug_pc;	// util.scala:466:20
      uops_0_iq_type <= io_enq_bits_uop_iq_type;	// util.scala:466:20
      uops_0_fu_code <= io_enq_bits_uop_fu_code;	// util.scala:466:20
      uops_0_ctrl_br_type <= io_enq_bits_uop_ctrl_br_type;	// util.scala:466:20
      uops_0_ctrl_op1_sel <= io_enq_bits_uop_ctrl_op1_sel;	// util.scala:466:20
      uops_0_ctrl_op2_sel <= io_enq_bits_uop_ctrl_op2_sel;	// util.scala:466:20
      uops_0_ctrl_imm_sel <= io_enq_bits_uop_ctrl_imm_sel;	// util.scala:466:20
      uops_0_ctrl_op_fcn <= io_enq_bits_uop_ctrl_op_fcn;	// util.scala:466:20
      uops_0_ctrl_fcn_dw <= io_enq_bits_uop_ctrl_fcn_dw;	// util.scala:466:20
      uops_0_ctrl_csr_cmd <= io_enq_bits_uop_ctrl_csr_cmd;	// util.scala:466:20
      uops_0_ctrl_is_load <= io_enq_bits_uop_ctrl_is_load;	// util.scala:466:20
      uops_0_ctrl_is_sta <= io_enq_bits_uop_ctrl_is_sta;	// util.scala:466:20
      uops_0_ctrl_is_std <= io_enq_bits_uop_ctrl_is_std;	// util.scala:466:20
      uops_0_iw_state <= io_enq_bits_uop_iw_state;	// util.scala:466:20
      uops_0_iw_p1_poisoned <= io_enq_bits_uop_iw_p1_poisoned;	// util.scala:466:20
      uops_0_iw_p2_poisoned <= io_enq_bits_uop_iw_p2_poisoned;	// util.scala:466:20
      uops_0_is_br <= io_enq_bits_uop_is_br;	// util.scala:466:20
      uops_0_is_jalr <= io_enq_bits_uop_is_jalr;	// util.scala:466:20
      uops_0_is_jal <= io_enq_bits_uop_is_jal;	// util.scala:466:20
      uops_0_is_sfb <= io_enq_bits_uop_is_sfb;	// util.scala:466:20
      uops_0_br_tag <= io_enq_bits_uop_br_tag;	// util.scala:466:20
      uops_0_ftq_idx <= io_enq_bits_uop_ftq_idx;	// util.scala:466:20
      uops_0_edge_inst <= io_enq_bits_uop_edge_inst;	// util.scala:466:20
      uops_0_pc_lob <= io_enq_bits_uop_pc_lob;	// util.scala:466:20
      uops_0_taken <= io_enq_bits_uop_taken;	// util.scala:466:20
      uops_0_imm_packed <= io_enq_bits_uop_imm_packed;	// util.scala:466:20
      uops_0_csr_addr <= io_enq_bits_uop_csr_addr;	// util.scala:466:20
      uops_0_rob_idx <= io_enq_bits_uop_rob_idx;	// util.scala:466:20
      uops_0_ldq_idx <= io_enq_bits_uop_ldq_idx;	// util.scala:466:20
      uops_0_stq_idx <= io_enq_bits_uop_stq_idx;	// util.scala:466:20
      uops_0_rxq_idx <= io_enq_bits_uop_rxq_idx;	// util.scala:466:20
      uops_0_pdst <= io_enq_bits_uop_pdst;	// util.scala:466:20
      uops_0_prs1 <= io_enq_bits_uop_prs1;	// util.scala:466:20
      uops_0_prs2 <= io_enq_bits_uop_prs2;	// util.scala:466:20
      uops_0_prs3 <= io_enq_bits_uop_prs3;	// util.scala:466:20
      uops_0_ppred <= io_enq_bits_uop_ppred;	// util.scala:466:20
      uops_0_prs1_busy <= io_enq_bits_uop_prs1_busy;	// util.scala:466:20
      uops_0_prs2_busy <= io_enq_bits_uop_prs2_busy;	// util.scala:466:20
      uops_0_prs3_busy <= io_enq_bits_uop_prs3_busy;	// util.scala:466:20
      uops_0_ppred_busy <= io_enq_bits_uop_ppred_busy;	// util.scala:466:20
      uops_0_stale_pdst <= io_enq_bits_uop_stale_pdst;	// util.scala:466:20
      uops_0_exception <= io_enq_bits_uop_exception;	// util.scala:466:20
      uops_0_exc_cause <= io_enq_bits_uop_exc_cause;	// util.scala:466:20
      uops_0_bypassable <= io_enq_bits_uop_bypassable;	// util.scala:466:20
      uops_0_mem_cmd <= io_enq_bits_uop_mem_cmd;	// util.scala:466:20
      uops_0_mem_size <= io_enq_bits_uop_mem_size;	// util.scala:466:20
      uops_0_mem_signed <= io_enq_bits_uop_mem_signed;	// util.scala:466:20
      uops_0_is_fence <= io_enq_bits_uop_is_fence;	// util.scala:466:20
      uops_0_is_fencei <= io_enq_bits_uop_is_fencei;	// util.scala:466:20
      uops_0_is_amo <= io_enq_bits_uop_is_amo;	// util.scala:466:20
      uops_0_uses_ldq <= io_enq_bits_uop_uses_ldq;	// util.scala:466:20
      uops_0_uses_stq <= io_enq_bits_uop_uses_stq;	// util.scala:466:20
      uops_0_is_sys_pc2epc <= io_enq_bits_uop_is_sys_pc2epc;	// util.scala:466:20
      uops_0_is_unique <= io_enq_bits_uop_is_unique;	// util.scala:466:20
      uops_0_flush_on_commit <= io_enq_bits_uop_flush_on_commit;	// util.scala:466:20
      uops_0_ldst_is_rs1 <= io_enq_bits_uop_ldst_is_rs1;	// util.scala:466:20
      uops_0_ldst <= io_enq_bits_uop_ldst;	// util.scala:466:20
      uops_0_lrs1 <= io_enq_bits_uop_lrs1;	// util.scala:466:20
      uops_0_lrs2 <= io_enq_bits_uop_lrs2;	// util.scala:466:20
      uops_0_lrs3 <= io_enq_bits_uop_lrs3;	// util.scala:466:20
      uops_0_ldst_val <= io_enq_bits_uop_ldst_val;	// util.scala:466:20
      uops_0_dst_rtype <= io_enq_bits_uop_dst_rtype;	// util.scala:466:20
      uops_0_lrs1_rtype <= io_enq_bits_uop_lrs1_rtype;	// util.scala:466:20
      uops_0_lrs2_rtype <= io_enq_bits_uop_lrs2_rtype;	// util.scala:466:20
      uops_0_frs3_en <= io_enq_bits_uop_frs3_en;	// util.scala:466:20
      uops_0_fp_val <= io_enq_bits_uop_fp_val;	// util.scala:466:20
      uops_0_fp_single <= io_enq_bits_uop_fp_single;	// util.scala:466:20
      uops_0_xcpt_pf_if <= io_enq_bits_uop_xcpt_pf_if;	// util.scala:466:20
      uops_0_xcpt_ae_if <= io_enq_bits_uop_xcpt_ae_if;	// util.scala:466:20
      uops_0_xcpt_ma_if <= io_enq_bits_uop_xcpt_ma_if;	// util.scala:466:20
      uops_0_bp_debug_if <= io_enq_bits_uop_bp_debug_if;	// util.scala:466:20
      uops_0_bp_xcpt_if <= io_enq_bits_uop_bp_xcpt_if;	// util.scala:466:20
      uops_0_debug_fsrc <= io_enq_bits_uop_debug_fsrc;	// util.scala:466:20
      uops_0_debug_tsrc <= io_enq_bits_uop_debug_tsrc;	// util.scala:466:20
    end
    if (do_enq & _GEN_80)	// Decoupled.scala:40:37, util.scala:482:22, :487:17, :489:33, :491:33
      uops_0_br_mask <= _uops_br_mask_T_1;	// util.scala:85:25, :466:20
    else	// util.scala:482:22, :487:17, :491:33
      uops_0_br_mask <= ({20{~valids_0}} | ~io_brupdate_b1_resolve_mask) & uops_0_br_mask;	// util.scala:89:23, :465:24, :466:20, :482:22, :483:23
    if (_GEN_83) begin	// util.scala:481:16, :487:17, :489:33
      uops_1_uopc <= io_enq_bits_uop_uopc;	// util.scala:466:20
      uops_1_inst <= io_enq_bits_uop_inst;	// util.scala:466:20
      uops_1_debug_inst <= io_enq_bits_uop_debug_inst;	// util.scala:466:20
      uops_1_is_rvc <= io_enq_bits_uop_is_rvc;	// util.scala:466:20
      uops_1_debug_pc <= io_enq_bits_uop_debug_pc;	// util.scala:466:20
      uops_1_iq_type <= io_enq_bits_uop_iq_type;	// util.scala:466:20
      uops_1_fu_code <= io_enq_bits_uop_fu_code;	// util.scala:466:20
      uops_1_ctrl_br_type <= io_enq_bits_uop_ctrl_br_type;	// util.scala:466:20
      uops_1_ctrl_op1_sel <= io_enq_bits_uop_ctrl_op1_sel;	// util.scala:466:20
      uops_1_ctrl_op2_sel <= io_enq_bits_uop_ctrl_op2_sel;	// util.scala:466:20
      uops_1_ctrl_imm_sel <= io_enq_bits_uop_ctrl_imm_sel;	// util.scala:466:20
      uops_1_ctrl_op_fcn <= io_enq_bits_uop_ctrl_op_fcn;	// util.scala:466:20
      uops_1_ctrl_fcn_dw <= io_enq_bits_uop_ctrl_fcn_dw;	// util.scala:466:20
      uops_1_ctrl_csr_cmd <= io_enq_bits_uop_ctrl_csr_cmd;	// util.scala:466:20
      uops_1_ctrl_is_load <= io_enq_bits_uop_ctrl_is_load;	// util.scala:466:20
      uops_1_ctrl_is_sta <= io_enq_bits_uop_ctrl_is_sta;	// util.scala:466:20
      uops_1_ctrl_is_std <= io_enq_bits_uop_ctrl_is_std;	// util.scala:466:20
      uops_1_iw_state <= io_enq_bits_uop_iw_state;	// util.scala:466:20
      uops_1_iw_p1_poisoned <= io_enq_bits_uop_iw_p1_poisoned;	// util.scala:466:20
      uops_1_iw_p2_poisoned <= io_enq_bits_uop_iw_p2_poisoned;	// util.scala:466:20
      uops_1_is_br <= io_enq_bits_uop_is_br;	// util.scala:466:20
      uops_1_is_jalr <= io_enq_bits_uop_is_jalr;	// util.scala:466:20
      uops_1_is_jal <= io_enq_bits_uop_is_jal;	// util.scala:466:20
      uops_1_is_sfb <= io_enq_bits_uop_is_sfb;	// util.scala:466:20
      uops_1_br_tag <= io_enq_bits_uop_br_tag;	// util.scala:466:20
      uops_1_ftq_idx <= io_enq_bits_uop_ftq_idx;	// util.scala:466:20
      uops_1_edge_inst <= io_enq_bits_uop_edge_inst;	// util.scala:466:20
      uops_1_pc_lob <= io_enq_bits_uop_pc_lob;	// util.scala:466:20
      uops_1_taken <= io_enq_bits_uop_taken;	// util.scala:466:20
      uops_1_imm_packed <= io_enq_bits_uop_imm_packed;	// util.scala:466:20
      uops_1_csr_addr <= io_enq_bits_uop_csr_addr;	// util.scala:466:20
      uops_1_rob_idx <= io_enq_bits_uop_rob_idx;	// util.scala:466:20
      uops_1_ldq_idx <= io_enq_bits_uop_ldq_idx;	// util.scala:466:20
      uops_1_stq_idx <= io_enq_bits_uop_stq_idx;	// util.scala:466:20
      uops_1_rxq_idx <= io_enq_bits_uop_rxq_idx;	// util.scala:466:20
      uops_1_pdst <= io_enq_bits_uop_pdst;	// util.scala:466:20
      uops_1_prs1 <= io_enq_bits_uop_prs1;	// util.scala:466:20
      uops_1_prs2 <= io_enq_bits_uop_prs2;	// util.scala:466:20
      uops_1_prs3 <= io_enq_bits_uop_prs3;	// util.scala:466:20
      uops_1_ppred <= io_enq_bits_uop_ppred;	// util.scala:466:20
      uops_1_prs1_busy <= io_enq_bits_uop_prs1_busy;	// util.scala:466:20
      uops_1_prs2_busy <= io_enq_bits_uop_prs2_busy;	// util.scala:466:20
      uops_1_prs3_busy <= io_enq_bits_uop_prs3_busy;	// util.scala:466:20
      uops_1_ppred_busy <= io_enq_bits_uop_ppred_busy;	// util.scala:466:20
      uops_1_stale_pdst <= io_enq_bits_uop_stale_pdst;	// util.scala:466:20
      uops_1_exception <= io_enq_bits_uop_exception;	// util.scala:466:20
      uops_1_exc_cause <= io_enq_bits_uop_exc_cause;	// util.scala:466:20
      uops_1_bypassable <= io_enq_bits_uop_bypassable;	// util.scala:466:20
      uops_1_mem_cmd <= io_enq_bits_uop_mem_cmd;	// util.scala:466:20
      uops_1_mem_size <= io_enq_bits_uop_mem_size;	// util.scala:466:20
      uops_1_mem_signed <= io_enq_bits_uop_mem_signed;	// util.scala:466:20
      uops_1_is_fence <= io_enq_bits_uop_is_fence;	// util.scala:466:20
      uops_1_is_fencei <= io_enq_bits_uop_is_fencei;	// util.scala:466:20
      uops_1_is_amo <= io_enq_bits_uop_is_amo;	// util.scala:466:20
      uops_1_uses_ldq <= io_enq_bits_uop_uses_ldq;	// util.scala:466:20
      uops_1_uses_stq <= io_enq_bits_uop_uses_stq;	// util.scala:466:20
      uops_1_is_sys_pc2epc <= io_enq_bits_uop_is_sys_pc2epc;	// util.scala:466:20
      uops_1_is_unique <= io_enq_bits_uop_is_unique;	// util.scala:466:20
      uops_1_flush_on_commit <= io_enq_bits_uop_flush_on_commit;	// util.scala:466:20
      uops_1_ldst_is_rs1 <= io_enq_bits_uop_ldst_is_rs1;	// util.scala:466:20
      uops_1_ldst <= io_enq_bits_uop_ldst;	// util.scala:466:20
      uops_1_lrs1 <= io_enq_bits_uop_lrs1;	// util.scala:466:20
      uops_1_lrs2 <= io_enq_bits_uop_lrs2;	// util.scala:466:20
      uops_1_lrs3 <= io_enq_bits_uop_lrs3;	// util.scala:466:20
      uops_1_ldst_val <= io_enq_bits_uop_ldst_val;	// util.scala:466:20
      uops_1_dst_rtype <= io_enq_bits_uop_dst_rtype;	// util.scala:466:20
      uops_1_lrs1_rtype <= io_enq_bits_uop_lrs1_rtype;	// util.scala:466:20
      uops_1_lrs2_rtype <= io_enq_bits_uop_lrs2_rtype;	// util.scala:466:20
      uops_1_frs3_en <= io_enq_bits_uop_frs3_en;	// util.scala:466:20
      uops_1_fp_val <= io_enq_bits_uop_fp_val;	// util.scala:466:20
      uops_1_fp_single <= io_enq_bits_uop_fp_single;	// util.scala:466:20
      uops_1_xcpt_pf_if <= io_enq_bits_uop_xcpt_pf_if;	// util.scala:466:20
      uops_1_xcpt_ae_if <= io_enq_bits_uop_xcpt_ae_if;	// util.scala:466:20
      uops_1_xcpt_ma_if <= io_enq_bits_uop_xcpt_ma_if;	// util.scala:466:20
      uops_1_bp_debug_if <= io_enq_bits_uop_bp_debug_if;	// util.scala:466:20
      uops_1_bp_xcpt_if <= io_enq_bits_uop_bp_xcpt_if;	// util.scala:466:20
      uops_1_debug_fsrc <= io_enq_bits_uop_debug_fsrc;	// util.scala:466:20
      uops_1_debug_tsrc <= io_enq_bits_uop_debug_tsrc;	// util.scala:466:20
    end
    if (do_enq & _GEN_82)	// Decoupled.scala:40:37, util.scala:482:22, :487:17, :489:33, :491:33
      uops_1_br_mask <= _uops_br_mask_T_1;	// util.scala:85:25, :466:20
    else	// util.scala:482:22, :487:17, :491:33
      uops_1_br_mask <= ({20{~valids_1}} | ~io_brupdate_b1_resolve_mask) & uops_1_br_mask;	// util.scala:89:23, :465:24, :466:20, :482:22, :483:23
    if (_GEN_85) begin	// util.scala:481:16, :487:17, :489:33
      uops_2_uopc <= io_enq_bits_uop_uopc;	// util.scala:466:20
      uops_2_inst <= io_enq_bits_uop_inst;	// util.scala:466:20
      uops_2_debug_inst <= io_enq_bits_uop_debug_inst;	// util.scala:466:20
      uops_2_is_rvc <= io_enq_bits_uop_is_rvc;	// util.scala:466:20
      uops_2_debug_pc <= io_enq_bits_uop_debug_pc;	// util.scala:466:20
      uops_2_iq_type <= io_enq_bits_uop_iq_type;	// util.scala:466:20
      uops_2_fu_code <= io_enq_bits_uop_fu_code;	// util.scala:466:20
      uops_2_ctrl_br_type <= io_enq_bits_uop_ctrl_br_type;	// util.scala:466:20
      uops_2_ctrl_op1_sel <= io_enq_bits_uop_ctrl_op1_sel;	// util.scala:466:20
      uops_2_ctrl_op2_sel <= io_enq_bits_uop_ctrl_op2_sel;	// util.scala:466:20
      uops_2_ctrl_imm_sel <= io_enq_bits_uop_ctrl_imm_sel;	// util.scala:466:20
      uops_2_ctrl_op_fcn <= io_enq_bits_uop_ctrl_op_fcn;	// util.scala:466:20
      uops_2_ctrl_fcn_dw <= io_enq_bits_uop_ctrl_fcn_dw;	// util.scala:466:20
      uops_2_ctrl_csr_cmd <= io_enq_bits_uop_ctrl_csr_cmd;	// util.scala:466:20
      uops_2_ctrl_is_load <= io_enq_bits_uop_ctrl_is_load;	// util.scala:466:20
      uops_2_ctrl_is_sta <= io_enq_bits_uop_ctrl_is_sta;	// util.scala:466:20
      uops_2_ctrl_is_std <= io_enq_bits_uop_ctrl_is_std;	// util.scala:466:20
      uops_2_iw_state <= io_enq_bits_uop_iw_state;	// util.scala:466:20
      uops_2_iw_p1_poisoned <= io_enq_bits_uop_iw_p1_poisoned;	// util.scala:466:20
      uops_2_iw_p2_poisoned <= io_enq_bits_uop_iw_p2_poisoned;	// util.scala:466:20
      uops_2_is_br <= io_enq_bits_uop_is_br;	// util.scala:466:20
      uops_2_is_jalr <= io_enq_bits_uop_is_jalr;	// util.scala:466:20
      uops_2_is_jal <= io_enq_bits_uop_is_jal;	// util.scala:466:20
      uops_2_is_sfb <= io_enq_bits_uop_is_sfb;	// util.scala:466:20
      uops_2_br_tag <= io_enq_bits_uop_br_tag;	// util.scala:466:20
      uops_2_ftq_idx <= io_enq_bits_uop_ftq_idx;	// util.scala:466:20
      uops_2_edge_inst <= io_enq_bits_uop_edge_inst;	// util.scala:466:20
      uops_2_pc_lob <= io_enq_bits_uop_pc_lob;	// util.scala:466:20
      uops_2_taken <= io_enq_bits_uop_taken;	// util.scala:466:20
      uops_2_imm_packed <= io_enq_bits_uop_imm_packed;	// util.scala:466:20
      uops_2_csr_addr <= io_enq_bits_uop_csr_addr;	// util.scala:466:20
      uops_2_rob_idx <= io_enq_bits_uop_rob_idx;	// util.scala:466:20
      uops_2_ldq_idx <= io_enq_bits_uop_ldq_idx;	// util.scala:466:20
      uops_2_stq_idx <= io_enq_bits_uop_stq_idx;	// util.scala:466:20
      uops_2_rxq_idx <= io_enq_bits_uop_rxq_idx;	// util.scala:466:20
      uops_2_pdst <= io_enq_bits_uop_pdst;	// util.scala:466:20
      uops_2_prs1 <= io_enq_bits_uop_prs1;	// util.scala:466:20
      uops_2_prs2 <= io_enq_bits_uop_prs2;	// util.scala:466:20
      uops_2_prs3 <= io_enq_bits_uop_prs3;	// util.scala:466:20
      uops_2_ppred <= io_enq_bits_uop_ppred;	// util.scala:466:20
      uops_2_prs1_busy <= io_enq_bits_uop_prs1_busy;	// util.scala:466:20
      uops_2_prs2_busy <= io_enq_bits_uop_prs2_busy;	// util.scala:466:20
      uops_2_prs3_busy <= io_enq_bits_uop_prs3_busy;	// util.scala:466:20
      uops_2_ppred_busy <= io_enq_bits_uop_ppred_busy;	// util.scala:466:20
      uops_2_stale_pdst <= io_enq_bits_uop_stale_pdst;	// util.scala:466:20
      uops_2_exception <= io_enq_bits_uop_exception;	// util.scala:466:20
      uops_2_exc_cause <= io_enq_bits_uop_exc_cause;	// util.scala:466:20
      uops_2_bypassable <= io_enq_bits_uop_bypassable;	// util.scala:466:20
      uops_2_mem_cmd <= io_enq_bits_uop_mem_cmd;	// util.scala:466:20
      uops_2_mem_size <= io_enq_bits_uop_mem_size;	// util.scala:466:20
      uops_2_mem_signed <= io_enq_bits_uop_mem_signed;	// util.scala:466:20
      uops_2_is_fence <= io_enq_bits_uop_is_fence;	// util.scala:466:20
      uops_2_is_fencei <= io_enq_bits_uop_is_fencei;	// util.scala:466:20
      uops_2_is_amo <= io_enq_bits_uop_is_amo;	// util.scala:466:20
      uops_2_uses_ldq <= io_enq_bits_uop_uses_ldq;	// util.scala:466:20
      uops_2_uses_stq <= io_enq_bits_uop_uses_stq;	// util.scala:466:20
      uops_2_is_sys_pc2epc <= io_enq_bits_uop_is_sys_pc2epc;	// util.scala:466:20
      uops_2_is_unique <= io_enq_bits_uop_is_unique;	// util.scala:466:20
      uops_2_flush_on_commit <= io_enq_bits_uop_flush_on_commit;	// util.scala:466:20
      uops_2_ldst_is_rs1 <= io_enq_bits_uop_ldst_is_rs1;	// util.scala:466:20
      uops_2_ldst <= io_enq_bits_uop_ldst;	// util.scala:466:20
      uops_2_lrs1 <= io_enq_bits_uop_lrs1;	// util.scala:466:20
      uops_2_lrs2 <= io_enq_bits_uop_lrs2;	// util.scala:466:20
      uops_2_lrs3 <= io_enq_bits_uop_lrs3;	// util.scala:466:20
      uops_2_ldst_val <= io_enq_bits_uop_ldst_val;	// util.scala:466:20
      uops_2_dst_rtype <= io_enq_bits_uop_dst_rtype;	// util.scala:466:20
      uops_2_lrs1_rtype <= io_enq_bits_uop_lrs1_rtype;	// util.scala:466:20
      uops_2_lrs2_rtype <= io_enq_bits_uop_lrs2_rtype;	// util.scala:466:20
      uops_2_frs3_en <= io_enq_bits_uop_frs3_en;	// util.scala:466:20
      uops_2_fp_val <= io_enq_bits_uop_fp_val;	// util.scala:466:20
      uops_2_fp_single <= io_enq_bits_uop_fp_single;	// util.scala:466:20
      uops_2_xcpt_pf_if <= io_enq_bits_uop_xcpt_pf_if;	// util.scala:466:20
      uops_2_xcpt_ae_if <= io_enq_bits_uop_xcpt_ae_if;	// util.scala:466:20
      uops_2_xcpt_ma_if <= io_enq_bits_uop_xcpt_ma_if;	// util.scala:466:20
      uops_2_bp_debug_if <= io_enq_bits_uop_bp_debug_if;	// util.scala:466:20
      uops_2_bp_xcpt_if <= io_enq_bits_uop_bp_xcpt_if;	// util.scala:466:20
      uops_2_debug_fsrc <= io_enq_bits_uop_debug_fsrc;	// util.scala:466:20
      uops_2_debug_tsrc <= io_enq_bits_uop_debug_tsrc;	// util.scala:466:20
    end
    if (do_enq & _GEN_84)	// Decoupled.scala:40:37, util.scala:482:22, :487:17, :489:33, :491:33
      uops_2_br_mask <= _uops_br_mask_T_1;	// util.scala:85:25, :466:20
    else	// util.scala:482:22, :487:17, :491:33
      uops_2_br_mask <= ({20{~valids_2}} | ~io_brupdate_b1_resolve_mask) & uops_2_br_mask;	// util.scala:89:23, :465:24, :466:20, :482:22, :483:23
    if (_GEN_87) begin	// util.scala:481:16, :487:17, :489:33
      uops_3_uopc <= io_enq_bits_uop_uopc;	// util.scala:466:20
      uops_3_inst <= io_enq_bits_uop_inst;	// util.scala:466:20
      uops_3_debug_inst <= io_enq_bits_uop_debug_inst;	// util.scala:466:20
      uops_3_is_rvc <= io_enq_bits_uop_is_rvc;	// util.scala:466:20
      uops_3_debug_pc <= io_enq_bits_uop_debug_pc;	// util.scala:466:20
      uops_3_iq_type <= io_enq_bits_uop_iq_type;	// util.scala:466:20
      uops_3_fu_code <= io_enq_bits_uop_fu_code;	// util.scala:466:20
      uops_3_ctrl_br_type <= io_enq_bits_uop_ctrl_br_type;	// util.scala:466:20
      uops_3_ctrl_op1_sel <= io_enq_bits_uop_ctrl_op1_sel;	// util.scala:466:20
      uops_3_ctrl_op2_sel <= io_enq_bits_uop_ctrl_op2_sel;	// util.scala:466:20
      uops_3_ctrl_imm_sel <= io_enq_bits_uop_ctrl_imm_sel;	// util.scala:466:20
      uops_3_ctrl_op_fcn <= io_enq_bits_uop_ctrl_op_fcn;	// util.scala:466:20
      uops_3_ctrl_fcn_dw <= io_enq_bits_uop_ctrl_fcn_dw;	// util.scala:466:20
      uops_3_ctrl_csr_cmd <= io_enq_bits_uop_ctrl_csr_cmd;	// util.scala:466:20
      uops_3_ctrl_is_load <= io_enq_bits_uop_ctrl_is_load;	// util.scala:466:20
      uops_3_ctrl_is_sta <= io_enq_bits_uop_ctrl_is_sta;	// util.scala:466:20
      uops_3_ctrl_is_std <= io_enq_bits_uop_ctrl_is_std;	// util.scala:466:20
      uops_3_iw_state <= io_enq_bits_uop_iw_state;	// util.scala:466:20
      uops_3_iw_p1_poisoned <= io_enq_bits_uop_iw_p1_poisoned;	// util.scala:466:20
      uops_3_iw_p2_poisoned <= io_enq_bits_uop_iw_p2_poisoned;	// util.scala:466:20
      uops_3_is_br <= io_enq_bits_uop_is_br;	// util.scala:466:20
      uops_3_is_jalr <= io_enq_bits_uop_is_jalr;	// util.scala:466:20
      uops_3_is_jal <= io_enq_bits_uop_is_jal;	// util.scala:466:20
      uops_3_is_sfb <= io_enq_bits_uop_is_sfb;	// util.scala:466:20
      uops_3_br_tag <= io_enq_bits_uop_br_tag;	// util.scala:466:20
      uops_3_ftq_idx <= io_enq_bits_uop_ftq_idx;	// util.scala:466:20
      uops_3_edge_inst <= io_enq_bits_uop_edge_inst;	// util.scala:466:20
      uops_3_pc_lob <= io_enq_bits_uop_pc_lob;	// util.scala:466:20
      uops_3_taken <= io_enq_bits_uop_taken;	// util.scala:466:20
      uops_3_imm_packed <= io_enq_bits_uop_imm_packed;	// util.scala:466:20
      uops_3_csr_addr <= io_enq_bits_uop_csr_addr;	// util.scala:466:20
      uops_3_rob_idx <= io_enq_bits_uop_rob_idx;	// util.scala:466:20
      uops_3_ldq_idx <= io_enq_bits_uop_ldq_idx;	// util.scala:466:20
      uops_3_stq_idx <= io_enq_bits_uop_stq_idx;	// util.scala:466:20
      uops_3_rxq_idx <= io_enq_bits_uop_rxq_idx;	// util.scala:466:20
      uops_3_pdst <= io_enq_bits_uop_pdst;	// util.scala:466:20
      uops_3_prs1 <= io_enq_bits_uop_prs1;	// util.scala:466:20
      uops_3_prs2 <= io_enq_bits_uop_prs2;	// util.scala:466:20
      uops_3_prs3 <= io_enq_bits_uop_prs3;	// util.scala:466:20
      uops_3_ppred <= io_enq_bits_uop_ppred;	// util.scala:466:20
      uops_3_prs1_busy <= io_enq_bits_uop_prs1_busy;	// util.scala:466:20
      uops_3_prs2_busy <= io_enq_bits_uop_prs2_busy;	// util.scala:466:20
      uops_3_prs3_busy <= io_enq_bits_uop_prs3_busy;	// util.scala:466:20
      uops_3_ppred_busy <= io_enq_bits_uop_ppred_busy;	// util.scala:466:20
      uops_3_stale_pdst <= io_enq_bits_uop_stale_pdst;	// util.scala:466:20
      uops_3_exception <= io_enq_bits_uop_exception;	// util.scala:466:20
      uops_3_exc_cause <= io_enq_bits_uop_exc_cause;	// util.scala:466:20
      uops_3_bypassable <= io_enq_bits_uop_bypassable;	// util.scala:466:20
      uops_3_mem_cmd <= io_enq_bits_uop_mem_cmd;	// util.scala:466:20
      uops_3_mem_size <= io_enq_bits_uop_mem_size;	// util.scala:466:20
      uops_3_mem_signed <= io_enq_bits_uop_mem_signed;	// util.scala:466:20
      uops_3_is_fence <= io_enq_bits_uop_is_fence;	// util.scala:466:20
      uops_3_is_fencei <= io_enq_bits_uop_is_fencei;	// util.scala:466:20
      uops_3_is_amo <= io_enq_bits_uop_is_amo;	// util.scala:466:20
      uops_3_uses_ldq <= io_enq_bits_uop_uses_ldq;	// util.scala:466:20
      uops_3_uses_stq <= io_enq_bits_uop_uses_stq;	// util.scala:466:20
      uops_3_is_sys_pc2epc <= io_enq_bits_uop_is_sys_pc2epc;	// util.scala:466:20
      uops_3_is_unique <= io_enq_bits_uop_is_unique;	// util.scala:466:20
      uops_3_flush_on_commit <= io_enq_bits_uop_flush_on_commit;	// util.scala:466:20
      uops_3_ldst_is_rs1 <= io_enq_bits_uop_ldst_is_rs1;	// util.scala:466:20
      uops_3_ldst <= io_enq_bits_uop_ldst;	// util.scala:466:20
      uops_3_lrs1 <= io_enq_bits_uop_lrs1;	// util.scala:466:20
      uops_3_lrs2 <= io_enq_bits_uop_lrs2;	// util.scala:466:20
      uops_3_lrs3 <= io_enq_bits_uop_lrs3;	// util.scala:466:20
      uops_3_ldst_val <= io_enq_bits_uop_ldst_val;	// util.scala:466:20
      uops_3_dst_rtype <= io_enq_bits_uop_dst_rtype;	// util.scala:466:20
      uops_3_lrs1_rtype <= io_enq_bits_uop_lrs1_rtype;	// util.scala:466:20
      uops_3_lrs2_rtype <= io_enq_bits_uop_lrs2_rtype;	// util.scala:466:20
      uops_3_frs3_en <= io_enq_bits_uop_frs3_en;	// util.scala:466:20
      uops_3_fp_val <= io_enq_bits_uop_fp_val;	// util.scala:466:20
      uops_3_fp_single <= io_enq_bits_uop_fp_single;	// util.scala:466:20
      uops_3_xcpt_pf_if <= io_enq_bits_uop_xcpt_pf_if;	// util.scala:466:20
      uops_3_xcpt_ae_if <= io_enq_bits_uop_xcpt_ae_if;	// util.scala:466:20
      uops_3_xcpt_ma_if <= io_enq_bits_uop_xcpt_ma_if;	// util.scala:466:20
      uops_3_bp_debug_if <= io_enq_bits_uop_bp_debug_if;	// util.scala:466:20
      uops_3_bp_xcpt_if <= io_enq_bits_uop_bp_xcpt_if;	// util.scala:466:20
      uops_3_debug_fsrc <= io_enq_bits_uop_debug_fsrc;	// util.scala:466:20
      uops_3_debug_tsrc <= io_enq_bits_uop_debug_tsrc;	// util.scala:466:20
    end
    if (do_enq & _GEN_86)	// Decoupled.scala:40:37, util.scala:482:22, :487:17, :489:33, :491:33
      uops_3_br_mask <= _uops_br_mask_T_1;	// util.scala:85:25, :466:20
    else	// util.scala:482:22, :487:17, :491:33
      uops_3_br_mask <= ({20{~valids_3}} | ~io_brupdate_b1_resolve_mask) & uops_3_br_mask;	// util.scala:89:23, :465:24, :466:20, :482:22, :483:23
    if (_GEN_89) begin	// util.scala:481:16, :487:17, :489:33
      uops_4_uopc <= io_enq_bits_uop_uopc;	// util.scala:466:20
      uops_4_inst <= io_enq_bits_uop_inst;	// util.scala:466:20
      uops_4_debug_inst <= io_enq_bits_uop_debug_inst;	// util.scala:466:20
      uops_4_is_rvc <= io_enq_bits_uop_is_rvc;	// util.scala:466:20
      uops_4_debug_pc <= io_enq_bits_uop_debug_pc;	// util.scala:466:20
      uops_4_iq_type <= io_enq_bits_uop_iq_type;	// util.scala:466:20
      uops_4_fu_code <= io_enq_bits_uop_fu_code;	// util.scala:466:20
      uops_4_ctrl_br_type <= io_enq_bits_uop_ctrl_br_type;	// util.scala:466:20
      uops_4_ctrl_op1_sel <= io_enq_bits_uop_ctrl_op1_sel;	// util.scala:466:20
      uops_4_ctrl_op2_sel <= io_enq_bits_uop_ctrl_op2_sel;	// util.scala:466:20
      uops_4_ctrl_imm_sel <= io_enq_bits_uop_ctrl_imm_sel;	// util.scala:466:20
      uops_4_ctrl_op_fcn <= io_enq_bits_uop_ctrl_op_fcn;	// util.scala:466:20
      uops_4_ctrl_fcn_dw <= io_enq_bits_uop_ctrl_fcn_dw;	// util.scala:466:20
      uops_4_ctrl_csr_cmd <= io_enq_bits_uop_ctrl_csr_cmd;	// util.scala:466:20
      uops_4_ctrl_is_load <= io_enq_bits_uop_ctrl_is_load;	// util.scala:466:20
      uops_4_ctrl_is_sta <= io_enq_bits_uop_ctrl_is_sta;	// util.scala:466:20
      uops_4_ctrl_is_std <= io_enq_bits_uop_ctrl_is_std;	// util.scala:466:20
      uops_4_iw_state <= io_enq_bits_uop_iw_state;	// util.scala:466:20
      uops_4_iw_p1_poisoned <= io_enq_bits_uop_iw_p1_poisoned;	// util.scala:466:20
      uops_4_iw_p2_poisoned <= io_enq_bits_uop_iw_p2_poisoned;	// util.scala:466:20
      uops_4_is_br <= io_enq_bits_uop_is_br;	// util.scala:466:20
      uops_4_is_jalr <= io_enq_bits_uop_is_jalr;	// util.scala:466:20
      uops_4_is_jal <= io_enq_bits_uop_is_jal;	// util.scala:466:20
      uops_4_is_sfb <= io_enq_bits_uop_is_sfb;	// util.scala:466:20
      uops_4_br_tag <= io_enq_bits_uop_br_tag;	// util.scala:466:20
      uops_4_ftq_idx <= io_enq_bits_uop_ftq_idx;	// util.scala:466:20
      uops_4_edge_inst <= io_enq_bits_uop_edge_inst;	// util.scala:466:20
      uops_4_pc_lob <= io_enq_bits_uop_pc_lob;	// util.scala:466:20
      uops_4_taken <= io_enq_bits_uop_taken;	// util.scala:466:20
      uops_4_imm_packed <= io_enq_bits_uop_imm_packed;	// util.scala:466:20
      uops_4_csr_addr <= io_enq_bits_uop_csr_addr;	// util.scala:466:20
      uops_4_rob_idx <= io_enq_bits_uop_rob_idx;	// util.scala:466:20
      uops_4_ldq_idx <= io_enq_bits_uop_ldq_idx;	// util.scala:466:20
      uops_4_stq_idx <= io_enq_bits_uop_stq_idx;	// util.scala:466:20
      uops_4_rxq_idx <= io_enq_bits_uop_rxq_idx;	// util.scala:466:20
      uops_4_pdst <= io_enq_bits_uop_pdst;	// util.scala:466:20
      uops_4_prs1 <= io_enq_bits_uop_prs1;	// util.scala:466:20
      uops_4_prs2 <= io_enq_bits_uop_prs2;	// util.scala:466:20
      uops_4_prs3 <= io_enq_bits_uop_prs3;	// util.scala:466:20
      uops_4_ppred <= io_enq_bits_uop_ppred;	// util.scala:466:20
      uops_4_prs1_busy <= io_enq_bits_uop_prs1_busy;	// util.scala:466:20
      uops_4_prs2_busy <= io_enq_bits_uop_prs2_busy;	// util.scala:466:20
      uops_4_prs3_busy <= io_enq_bits_uop_prs3_busy;	// util.scala:466:20
      uops_4_ppred_busy <= io_enq_bits_uop_ppred_busy;	// util.scala:466:20
      uops_4_stale_pdst <= io_enq_bits_uop_stale_pdst;	// util.scala:466:20
      uops_4_exception <= io_enq_bits_uop_exception;	// util.scala:466:20
      uops_4_exc_cause <= io_enq_bits_uop_exc_cause;	// util.scala:466:20
      uops_4_bypassable <= io_enq_bits_uop_bypassable;	// util.scala:466:20
      uops_4_mem_cmd <= io_enq_bits_uop_mem_cmd;	// util.scala:466:20
      uops_4_mem_size <= io_enq_bits_uop_mem_size;	// util.scala:466:20
      uops_4_mem_signed <= io_enq_bits_uop_mem_signed;	// util.scala:466:20
      uops_4_is_fence <= io_enq_bits_uop_is_fence;	// util.scala:466:20
      uops_4_is_fencei <= io_enq_bits_uop_is_fencei;	// util.scala:466:20
      uops_4_is_amo <= io_enq_bits_uop_is_amo;	// util.scala:466:20
      uops_4_uses_ldq <= io_enq_bits_uop_uses_ldq;	// util.scala:466:20
      uops_4_uses_stq <= io_enq_bits_uop_uses_stq;	// util.scala:466:20
      uops_4_is_sys_pc2epc <= io_enq_bits_uop_is_sys_pc2epc;	// util.scala:466:20
      uops_4_is_unique <= io_enq_bits_uop_is_unique;	// util.scala:466:20
      uops_4_flush_on_commit <= io_enq_bits_uop_flush_on_commit;	// util.scala:466:20
      uops_4_ldst_is_rs1 <= io_enq_bits_uop_ldst_is_rs1;	// util.scala:466:20
      uops_4_ldst <= io_enq_bits_uop_ldst;	// util.scala:466:20
      uops_4_lrs1 <= io_enq_bits_uop_lrs1;	// util.scala:466:20
      uops_4_lrs2 <= io_enq_bits_uop_lrs2;	// util.scala:466:20
      uops_4_lrs3 <= io_enq_bits_uop_lrs3;	// util.scala:466:20
      uops_4_ldst_val <= io_enq_bits_uop_ldst_val;	// util.scala:466:20
      uops_4_dst_rtype <= io_enq_bits_uop_dst_rtype;	// util.scala:466:20
      uops_4_lrs1_rtype <= io_enq_bits_uop_lrs1_rtype;	// util.scala:466:20
      uops_4_lrs2_rtype <= io_enq_bits_uop_lrs2_rtype;	// util.scala:466:20
      uops_4_frs3_en <= io_enq_bits_uop_frs3_en;	// util.scala:466:20
      uops_4_fp_val <= io_enq_bits_uop_fp_val;	// util.scala:466:20
      uops_4_fp_single <= io_enq_bits_uop_fp_single;	// util.scala:466:20
      uops_4_xcpt_pf_if <= io_enq_bits_uop_xcpt_pf_if;	// util.scala:466:20
      uops_4_xcpt_ae_if <= io_enq_bits_uop_xcpt_ae_if;	// util.scala:466:20
      uops_4_xcpt_ma_if <= io_enq_bits_uop_xcpt_ma_if;	// util.scala:466:20
      uops_4_bp_debug_if <= io_enq_bits_uop_bp_debug_if;	// util.scala:466:20
      uops_4_bp_xcpt_if <= io_enq_bits_uop_bp_xcpt_if;	// util.scala:466:20
      uops_4_debug_fsrc <= io_enq_bits_uop_debug_fsrc;	// util.scala:466:20
      uops_4_debug_tsrc <= io_enq_bits_uop_debug_tsrc;	// util.scala:466:20
    end
    if (do_enq & _GEN_88)	// Decoupled.scala:40:37, util.scala:482:22, :487:17, :489:33, :491:33
      uops_4_br_mask <= _uops_br_mask_T_1;	// util.scala:85:25, :466:20
    else	// util.scala:482:22, :487:17, :491:33
      uops_4_br_mask <= ({20{~valids_4}} | ~io_brupdate_b1_resolve_mask) & uops_4_br_mask;	// util.scala:89:23, :465:24, :466:20, :482:22, :483:23
    if (_GEN_91) begin	// util.scala:481:16, :487:17, :489:33
      uops_5_uopc <= io_enq_bits_uop_uopc;	// util.scala:466:20
      uops_5_inst <= io_enq_bits_uop_inst;	// util.scala:466:20
      uops_5_debug_inst <= io_enq_bits_uop_debug_inst;	// util.scala:466:20
      uops_5_is_rvc <= io_enq_bits_uop_is_rvc;	// util.scala:466:20
      uops_5_debug_pc <= io_enq_bits_uop_debug_pc;	// util.scala:466:20
      uops_5_iq_type <= io_enq_bits_uop_iq_type;	// util.scala:466:20
      uops_5_fu_code <= io_enq_bits_uop_fu_code;	// util.scala:466:20
      uops_5_ctrl_br_type <= io_enq_bits_uop_ctrl_br_type;	// util.scala:466:20
      uops_5_ctrl_op1_sel <= io_enq_bits_uop_ctrl_op1_sel;	// util.scala:466:20
      uops_5_ctrl_op2_sel <= io_enq_bits_uop_ctrl_op2_sel;	// util.scala:466:20
      uops_5_ctrl_imm_sel <= io_enq_bits_uop_ctrl_imm_sel;	// util.scala:466:20
      uops_5_ctrl_op_fcn <= io_enq_bits_uop_ctrl_op_fcn;	// util.scala:466:20
      uops_5_ctrl_fcn_dw <= io_enq_bits_uop_ctrl_fcn_dw;	// util.scala:466:20
      uops_5_ctrl_csr_cmd <= io_enq_bits_uop_ctrl_csr_cmd;	// util.scala:466:20
      uops_5_ctrl_is_load <= io_enq_bits_uop_ctrl_is_load;	// util.scala:466:20
      uops_5_ctrl_is_sta <= io_enq_bits_uop_ctrl_is_sta;	// util.scala:466:20
      uops_5_ctrl_is_std <= io_enq_bits_uop_ctrl_is_std;	// util.scala:466:20
      uops_5_iw_state <= io_enq_bits_uop_iw_state;	// util.scala:466:20
      uops_5_iw_p1_poisoned <= io_enq_bits_uop_iw_p1_poisoned;	// util.scala:466:20
      uops_5_iw_p2_poisoned <= io_enq_bits_uop_iw_p2_poisoned;	// util.scala:466:20
      uops_5_is_br <= io_enq_bits_uop_is_br;	// util.scala:466:20
      uops_5_is_jalr <= io_enq_bits_uop_is_jalr;	// util.scala:466:20
      uops_5_is_jal <= io_enq_bits_uop_is_jal;	// util.scala:466:20
      uops_5_is_sfb <= io_enq_bits_uop_is_sfb;	// util.scala:466:20
      uops_5_br_tag <= io_enq_bits_uop_br_tag;	// util.scala:466:20
      uops_5_ftq_idx <= io_enq_bits_uop_ftq_idx;	// util.scala:466:20
      uops_5_edge_inst <= io_enq_bits_uop_edge_inst;	// util.scala:466:20
      uops_5_pc_lob <= io_enq_bits_uop_pc_lob;	// util.scala:466:20
      uops_5_taken <= io_enq_bits_uop_taken;	// util.scala:466:20
      uops_5_imm_packed <= io_enq_bits_uop_imm_packed;	// util.scala:466:20
      uops_5_csr_addr <= io_enq_bits_uop_csr_addr;	// util.scala:466:20
      uops_5_rob_idx <= io_enq_bits_uop_rob_idx;	// util.scala:466:20
      uops_5_ldq_idx <= io_enq_bits_uop_ldq_idx;	// util.scala:466:20
      uops_5_stq_idx <= io_enq_bits_uop_stq_idx;	// util.scala:466:20
      uops_5_rxq_idx <= io_enq_bits_uop_rxq_idx;	// util.scala:466:20
      uops_5_pdst <= io_enq_bits_uop_pdst;	// util.scala:466:20
      uops_5_prs1 <= io_enq_bits_uop_prs1;	// util.scala:466:20
      uops_5_prs2 <= io_enq_bits_uop_prs2;	// util.scala:466:20
      uops_5_prs3 <= io_enq_bits_uop_prs3;	// util.scala:466:20
      uops_5_ppred <= io_enq_bits_uop_ppred;	// util.scala:466:20
      uops_5_prs1_busy <= io_enq_bits_uop_prs1_busy;	// util.scala:466:20
      uops_5_prs2_busy <= io_enq_bits_uop_prs2_busy;	// util.scala:466:20
      uops_5_prs3_busy <= io_enq_bits_uop_prs3_busy;	// util.scala:466:20
      uops_5_ppred_busy <= io_enq_bits_uop_ppred_busy;	// util.scala:466:20
      uops_5_stale_pdst <= io_enq_bits_uop_stale_pdst;	// util.scala:466:20
      uops_5_exception <= io_enq_bits_uop_exception;	// util.scala:466:20
      uops_5_exc_cause <= io_enq_bits_uop_exc_cause;	// util.scala:466:20
      uops_5_bypassable <= io_enq_bits_uop_bypassable;	// util.scala:466:20
      uops_5_mem_cmd <= io_enq_bits_uop_mem_cmd;	// util.scala:466:20
      uops_5_mem_size <= io_enq_bits_uop_mem_size;	// util.scala:466:20
      uops_5_mem_signed <= io_enq_bits_uop_mem_signed;	// util.scala:466:20
      uops_5_is_fence <= io_enq_bits_uop_is_fence;	// util.scala:466:20
      uops_5_is_fencei <= io_enq_bits_uop_is_fencei;	// util.scala:466:20
      uops_5_is_amo <= io_enq_bits_uop_is_amo;	// util.scala:466:20
      uops_5_uses_ldq <= io_enq_bits_uop_uses_ldq;	// util.scala:466:20
      uops_5_uses_stq <= io_enq_bits_uop_uses_stq;	// util.scala:466:20
      uops_5_is_sys_pc2epc <= io_enq_bits_uop_is_sys_pc2epc;	// util.scala:466:20
      uops_5_is_unique <= io_enq_bits_uop_is_unique;	// util.scala:466:20
      uops_5_flush_on_commit <= io_enq_bits_uop_flush_on_commit;	// util.scala:466:20
      uops_5_ldst_is_rs1 <= io_enq_bits_uop_ldst_is_rs1;	// util.scala:466:20
      uops_5_ldst <= io_enq_bits_uop_ldst;	// util.scala:466:20
      uops_5_lrs1 <= io_enq_bits_uop_lrs1;	// util.scala:466:20
      uops_5_lrs2 <= io_enq_bits_uop_lrs2;	// util.scala:466:20
      uops_5_lrs3 <= io_enq_bits_uop_lrs3;	// util.scala:466:20
      uops_5_ldst_val <= io_enq_bits_uop_ldst_val;	// util.scala:466:20
      uops_5_dst_rtype <= io_enq_bits_uop_dst_rtype;	// util.scala:466:20
      uops_5_lrs1_rtype <= io_enq_bits_uop_lrs1_rtype;	// util.scala:466:20
      uops_5_lrs2_rtype <= io_enq_bits_uop_lrs2_rtype;	// util.scala:466:20
      uops_5_frs3_en <= io_enq_bits_uop_frs3_en;	// util.scala:466:20
      uops_5_fp_val <= io_enq_bits_uop_fp_val;	// util.scala:466:20
      uops_5_fp_single <= io_enq_bits_uop_fp_single;	// util.scala:466:20
      uops_5_xcpt_pf_if <= io_enq_bits_uop_xcpt_pf_if;	// util.scala:466:20
      uops_5_xcpt_ae_if <= io_enq_bits_uop_xcpt_ae_if;	// util.scala:466:20
      uops_5_xcpt_ma_if <= io_enq_bits_uop_xcpt_ma_if;	// util.scala:466:20
      uops_5_bp_debug_if <= io_enq_bits_uop_bp_debug_if;	// util.scala:466:20
      uops_5_bp_xcpt_if <= io_enq_bits_uop_bp_xcpt_if;	// util.scala:466:20
      uops_5_debug_fsrc <= io_enq_bits_uop_debug_fsrc;	// util.scala:466:20
      uops_5_debug_tsrc <= io_enq_bits_uop_debug_tsrc;	// util.scala:466:20
    end
    if (do_enq & _GEN_90)	// Decoupled.scala:40:37, util.scala:482:22, :487:17, :489:33, :491:33
      uops_5_br_mask <= _uops_br_mask_T_1;	// util.scala:85:25, :466:20
    else	// util.scala:482:22, :487:17, :491:33
      uops_5_br_mask <= ({20{~valids_5}} | ~io_brupdate_b1_resolve_mask) & uops_5_br_mask;	// util.scala:89:23, :465:24, :466:20, :482:22, :483:23
    if (_GEN_93) begin	// util.scala:481:16, :487:17, :489:33
      uops_6_uopc <= io_enq_bits_uop_uopc;	// util.scala:466:20
      uops_6_inst <= io_enq_bits_uop_inst;	// util.scala:466:20
      uops_6_debug_inst <= io_enq_bits_uop_debug_inst;	// util.scala:466:20
      uops_6_is_rvc <= io_enq_bits_uop_is_rvc;	// util.scala:466:20
      uops_6_debug_pc <= io_enq_bits_uop_debug_pc;	// util.scala:466:20
      uops_6_iq_type <= io_enq_bits_uop_iq_type;	// util.scala:466:20
      uops_6_fu_code <= io_enq_bits_uop_fu_code;	// util.scala:466:20
      uops_6_ctrl_br_type <= io_enq_bits_uop_ctrl_br_type;	// util.scala:466:20
      uops_6_ctrl_op1_sel <= io_enq_bits_uop_ctrl_op1_sel;	// util.scala:466:20
      uops_6_ctrl_op2_sel <= io_enq_bits_uop_ctrl_op2_sel;	// util.scala:466:20
      uops_6_ctrl_imm_sel <= io_enq_bits_uop_ctrl_imm_sel;	// util.scala:466:20
      uops_6_ctrl_op_fcn <= io_enq_bits_uop_ctrl_op_fcn;	// util.scala:466:20
      uops_6_ctrl_fcn_dw <= io_enq_bits_uop_ctrl_fcn_dw;	// util.scala:466:20
      uops_6_ctrl_csr_cmd <= io_enq_bits_uop_ctrl_csr_cmd;	// util.scala:466:20
      uops_6_ctrl_is_load <= io_enq_bits_uop_ctrl_is_load;	// util.scala:466:20
      uops_6_ctrl_is_sta <= io_enq_bits_uop_ctrl_is_sta;	// util.scala:466:20
      uops_6_ctrl_is_std <= io_enq_bits_uop_ctrl_is_std;	// util.scala:466:20
      uops_6_iw_state <= io_enq_bits_uop_iw_state;	// util.scala:466:20
      uops_6_iw_p1_poisoned <= io_enq_bits_uop_iw_p1_poisoned;	// util.scala:466:20
      uops_6_iw_p2_poisoned <= io_enq_bits_uop_iw_p2_poisoned;	// util.scala:466:20
      uops_6_is_br <= io_enq_bits_uop_is_br;	// util.scala:466:20
      uops_6_is_jalr <= io_enq_bits_uop_is_jalr;	// util.scala:466:20
      uops_6_is_jal <= io_enq_bits_uop_is_jal;	// util.scala:466:20
      uops_6_is_sfb <= io_enq_bits_uop_is_sfb;	// util.scala:466:20
      uops_6_br_tag <= io_enq_bits_uop_br_tag;	// util.scala:466:20
      uops_6_ftq_idx <= io_enq_bits_uop_ftq_idx;	// util.scala:466:20
      uops_6_edge_inst <= io_enq_bits_uop_edge_inst;	// util.scala:466:20
      uops_6_pc_lob <= io_enq_bits_uop_pc_lob;	// util.scala:466:20
      uops_6_taken <= io_enq_bits_uop_taken;	// util.scala:466:20
      uops_6_imm_packed <= io_enq_bits_uop_imm_packed;	// util.scala:466:20
      uops_6_csr_addr <= io_enq_bits_uop_csr_addr;	// util.scala:466:20
      uops_6_rob_idx <= io_enq_bits_uop_rob_idx;	// util.scala:466:20
      uops_6_ldq_idx <= io_enq_bits_uop_ldq_idx;	// util.scala:466:20
      uops_6_stq_idx <= io_enq_bits_uop_stq_idx;	// util.scala:466:20
      uops_6_rxq_idx <= io_enq_bits_uop_rxq_idx;	// util.scala:466:20
      uops_6_pdst <= io_enq_bits_uop_pdst;	// util.scala:466:20
      uops_6_prs1 <= io_enq_bits_uop_prs1;	// util.scala:466:20
      uops_6_prs2 <= io_enq_bits_uop_prs2;	// util.scala:466:20
      uops_6_prs3 <= io_enq_bits_uop_prs3;	// util.scala:466:20
      uops_6_ppred <= io_enq_bits_uop_ppred;	// util.scala:466:20
      uops_6_prs1_busy <= io_enq_bits_uop_prs1_busy;	// util.scala:466:20
      uops_6_prs2_busy <= io_enq_bits_uop_prs2_busy;	// util.scala:466:20
      uops_6_prs3_busy <= io_enq_bits_uop_prs3_busy;	// util.scala:466:20
      uops_6_ppred_busy <= io_enq_bits_uop_ppred_busy;	// util.scala:466:20
      uops_6_stale_pdst <= io_enq_bits_uop_stale_pdst;	// util.scala:466:20
      uops_6_exception <= io_enq_bits_uop_exception;	// util.scala:466:20
      uops_6_exc_cause <= io_enq_bits_uop_exc_cause;	// util.scala:466:20
      uops_6_bypassable <= io_enq_bits_uop_bypassable;	// util.scala:466:20
      uops_6_mem_cmd <= io_enq_bits_uop_mem_cmd;	// util.scala:466:20
      uops_6_mem_size <= io_enq_bits_uop_mem_size;	// util.scala:466:20
      uops_6_mem_signed <= io_enq_bits_uop_mem_signed;	// util.scala:466:20
      uops_6_is_fence <= io_enq_bits_uop_is_fence;	// util.scala:466:20
      uops_6_is_fencei <= io_enq_bits_uop_is_fencei;	// util.scala:466:20
      uops_6_is_amo <= io_enq_bits_uop_is_amo;	// util.scala:466:20
      uops_6_uses_ldq <= io_enq_bits_uop_uses_ldq;	// util.scala:466:20
      uops_6_uses_stq <= io_enq_bits_uop_uses_stq;	// util.scala:466:20
      uops_6_is_sys_pc2epc <= io_enq_bits_uop_is_sys_pc2epc;	// util.scala:466:20
      uops_6_is_unique <= io_enq_bits_uop_is_unique;	// util.scala:466:20
      uops_6_flush_on_commit <= io_enq_bits_uop_flush_on_commit;	// util.scala:466:20
      uops_6_ldst_is_rs1 <= io_enq_bits_uop_ldst_is_rs1;	// util.scala:466:20
      uops_6_ldst <= io_enq_bits_uop_ldst;	// util.scala:466:20
      uops_6_lrs1 <= io_enq_bits_uop_lrs1;	// util.scala:466:20
      uops_6_lrs2 <= io_enq_bits_uop_lrs2;	// util.scala:466:20
      uops_6_lrs3 <= io_enq_bits_uop_lrs3;	// util.scala:466:20
      uops_6_ldst_val <= io_enq_bits_uop_ldst_val;	// util.scala:466:20
      uops_6_dst_rtype <= io_enq_bits_uop_dst_rtype;	// util.scala:466:20
      uops_6_lrs1_rtype <= io_enq_bits_uop_lrs1_rtype;	// util.scala:466:20
      uops_6_lrs2_rtype <= io_enq_bits_uop_lrs2_rtype;	// util.scala:466:20
      uops_6_frs3_en <= io_enq_bits_uop_frs3_en;	// util.scala:466:20
      uops_6_fp_val <= io_enq_bits_uop_fp_val;	// util.scala:466:20
      uops_6_fp_single <= io_enq_bits_uop_fp_single;	// util.scala:466:20
      uops_6_xcpt_pf_if <= io_enq_bits_uop_xcpt_pf_if;	// util.scala:466:20
      uops_6_xcpt_ae_if <= io_enq_bits_uop_xcpt_ae_if;	// util.scala:466:20
      uops_6_xcpt_ma_if <= io_enq_bits_uop_xcpt_ma_if;	// util.scala:466:20
      uops_6_bp_debug_if <= io_enq_bits_uop_bp_debug_if;	// util.scala:466:20
      uops_6_bp_xcpt_if <= io_enq_bits_uop_bp_xcpt_if;	// util.scala:466:20
      uops_6_debug_fsrc <= io_enq_bits_uop_debug_fsrc;	// util.scala:466:20
      uops_6_debug_tsrc <= io_enq_bits_uop_debug_tsrc;	// util.scala:466:20
    end
    if (do_enq & _GEN_92)	// Decoupled.scala:40:37, util.scala:482:22, :487:17, :489:33, :491:33
      uops_6_br_mask <= _uops_br_mask_T_1;	// util.scala:85:25, :466:20
    else	// util.scala:482:22, :487:17, :491:33
      uops_6_br_mask <= ({20{~valids_6}} | ~io_brupdate_b1_resolve_mask) & uops_6_br_mask;	// util.scala:89:23, :465:24, :466:20, :482:22, :483:23
    if (_GEN_95) begin	// util.scala:481:16, :487:17, :489:33
      uops_7_uopc <= io_enq_bits_uop_uopc;	// util.scala:466:20
      uops_7_inst <= io_enq_bits_uop_inst;	// util.scala:466:20
      uops_7_debug_inst <= io_enq_bits_uop_debug_inst;	// util.scala:466:20
      uops_7_is_rvc <= io_enq_bits_uop_is_rvc;	// util.scala:466:20
      uops_7_debug_pc <= io_enq_bits_uop_debug_pc;	// util.scala:466:20
      uops_7_iq_type <= io_enq_bits_uop_iq_type;	// util.scala:466:20
      uops_7_fu_code <= io_enq_bits_uop_fu_code;	// util.scala:466:20
      uops_7_ctrl_br_type <= io_enq_bits_uop_ctrl_br_type;	// util.scala:466:20
      uops_7_ctrl_op1_sel <= io_enq_bits_uop_ctrl_op1_sel;	// util.scala:466:20
      uops_7_ctrl_op2_sel <= io_enq_bits_uop_ctrl_op2_sel;	// util.scala:466:20
      uops_7_ctrl_imm_sel <= io_enq_bits_uop_ctrl_imm_sel;	// util.scala:466:20
      uops_7_ctrl_op_fcn <= io_enq_bits_uop_ctrl_op_fcn;	// util.scala:466:20
      uops_7_ctrl_fcn_dw <= io_enq_bits_uop_ctrl_fcn_dw;	// util.scala:466:20
      uops_7_ctrl_csr_cmd <= io_enq_bits_uop_ctrl_csr_cmd;	// util.scala:466:20
      uops_7_ctrl_is_load <= io_enq_bits_uop_ctrl_is_load;	// util.scala:466:20
      uops_7_ctrl_is_sta <= io_enq_bits_uop_ctrl_is_sta;	// util.scala:466:20
      uops_7_ctrl_is_std <= io_enq_bits_uop_ctrl_is_std;	// util.scala:466:20
      uops_7_iw_state <= io_enq_bits_uop_iw_state;	// util.scala:466:20
      uops_7_iw_p1_poisoned <= io_enq_bits_uop_iw_p1_poisoned;	// util.scala:466:20
      uops_7_iw_p2_poisoned <= io_enq_bits_uop_iw_p2_poisoned;	// util.scala:466:20
      uops_7_is_br <= io_enq_bits_uop_is_br;	// util.scala:466:20
      uops_7_is_jalr <= io_enq_bits_uop_is_jalr;	// util.scala:466:20
      uops_7_is_jal <= io_enq_bits_uop_is_jal;	// util.scala:466:20
      uops_7_is_sfb <= io_enq_bits_uop_is_sfb;	// util.scala:466:20
      uops_7_br_tag <= io_enq_bits_uop_br_tag;	// util.scala:466:20
      uops_7_ftq_idx <= io_enq_bits_uop_ftq_idx;	// util.scala:466:20
      uops_7_edge_inst <= io_enq_bits_uop_edge_inst;	// util.scala:466:20
      uops_7_pc_lob <= io_enq_bits_uop_pc_lob;	// util.scala:466:20
      uops_7_taken <= io_enq_bits_uop_taken;	// util.scala:466:20
      uops_7_imm_packed <= io_enq_bits_uop_imm_packed;	// util.scala:466:20
      uops_7_csr_addr <= io_enq_bits_uop_csr_addr;	// util.scala:466:20
      uops_7_rob_idx <= io_enq_bits_uop_rob_idx;	// util.scala:466:20
      uops_7_ldq_idx <= io_enq_bits_uop_ldq_idx;	// util.scala:466:20
      uops_7_stq_idx <= io_enq_bits_uop_stq_idx;	// util.scala:466:20
      uops_7_rxq_idx <= io_enq_bits_uop_rxq_idx;	// util.scala:466:20
      uops_7_pdst <= io_enq_bits_uop_pdst;	// util.scala:466:20
      uops_7_prs1 <= io_enq_bits_uop_prs1;	// util.scala:466:20
      uops_7_prs2 <= io_enq_bits_uop_prs2;	// util.scala:466:20
      uops_7_prs3 <= io_enq_bits_uop_prs3;	// util.scala:466:20
      uops_7_ppred <= io_enq_bits_uop_ppred;	// util.scala:466:20
      uops_7_prs1_busy <= io_enq_bits_uop_prs1_busy;	// util.scala:466:20
      uops_7_prs2_busy <= io_enq_bits_uop_prs2_busy;	// util.scala:466:20
      uops_7_prs3_busy <= io_enq_bits_uop_prs3_busy;	// util.scala:466:20
      uops_7_ppred_busy <= io_enq_bits_uop_ppred_busy;	// util.scala:466:20
      uops_7_stale_pdst <= io_enq_bits_uop_stale_pdst;	// util.scala:466:20
      uops_7_exception <= io_enq_bits_uop_exception;	// util.scala:466:20
      uops_7_exc_cause <= io_enq_bits_uop_exc_cause;	// util.scala:466:20
      uops_7_bypassable <= io_enq_bits_uop_bypassable;	// util.scala:466:20
      uops_7_mem_cmd <= io_enq_bits_uop_mem_cmd;	// util.scala:466:20
      uops_7_mem_size <= io_enq_bits_uop_mem_size;	// util.scala:466:20
      uops_7_mem_signed <= io_enq_bits_uop_mem_signed;	// util.scala:466:20
      uops_7_is_fence <= io_enq_bits_uop_is_fence;	// util.scala:466:20
      uops_7_is_fencei <= io_enq_bits_uop_is_fencei;	// util.scala:466:20
      uops_7_is_amo <= io_enq_bits_uop_is_amo;	// util.scala:466:20
      uops_7_uses_ldq <= io_enq_bits_uop_uses_ldq;	// util.scala:466:20
      uops_7_uses_stq <= io_enq_bits_uop_uses_stq;	// util.scala:466:20
      uops_7_is_sys_pc2epc <= io_enq_bits_uop_is_sys_pc2epc;	// util.scala:466:20
      uops_7_is_unique <= io_enq_bits_uop_is_unique;	// util.scala:466:20
      uops_7_flush_on_commit <= io_enq_bits_uop_flush_on_commit;	// util.scala:466:20
      uops_7_ldst_is_rs1 <= io_enq_bits_uop_ldst_is_rs1;	// util.scala:466:20
      uops_7_ldst <= io_enq_bits_uop_ldst;	// util.scala:466:20
      uops_7_lrs1 <= io_enq_bits_uop_lrs1;	// util.scala:466:20
      uops_7_lrs2 <= io_enq_bits_uop_lrs2;	// util.scala:466:20
      uops_7_lrs3 <= io_enq_bits_uop_lrs3;	// util.scala:466:20
      uops_7_ldst_val <= io_enq_bits_uop_ldst_val;	// util.scala:466:20
      uops_7_dst_rtype <= io_enq_bits_uop_dst_rtype;	// util.scala:466:20
      uops_7_lrs1_rtype <= io_enq_bits_uop_lrs1_rtype;	// util.scala:466:20
      uops_7_lrs2_rtype <= io_enq_bits_uop_lrs2_rtype;	// util.scala:466:20
      uops_7_frs3_en <= io_enq_bits_uop_frs3_en;	// util.scala:466:20
      uops_7_fp_val <= io_enq_bits_uop_fp_val;	// util.scala:466:20
      uops_7_fp_single <= io_enq_bits_uop_fp_single;	// util.scala:466:20
      uops_7_xcpt_pf_if <= io_enq_bits_uop_xcpt_pf_if;	// util.scala:466:20
      uops_7_xcpt_ae_if <= io_enq_bits_uop_xcpt_ae_if;	// util.scala:466:20
      uops_7_xcpt_ma_if <= io_enq_bits_uop_xcpt_ma_if;	// util.scala:466:20
      uops_7_bp_debug_if <= io_enq_bits_uop_bp_debug_if;	// util.scala:466:20
      uops_7_bp_xcpt_if <= io_enq_bits_uop_bp_xcpt_if;	// util.scala:466:20
      uops_7_debug_fsrc <= io_enq_bits_uop_debug_fsrc;	// util.scala:466:20
      uops_7_debug_tsrc <= io_enq_bits_uop_debug_tsrc;	// util.scala:466:20
    end
    if (do_enq & _GEN_94)	// Decoupled.scala:40:37, util.scala:482:22, :487:17, :489:33, :491:33
      uops_7_br_mask <= _uops_br_mask_T_1;	// util.scala:85:25, :466:20
    else	// util.scala:482:22, :487:17, :491:33
      uops_7_br_mask <= ({20{~valids_7}} | ~io_brupdate_b1_resolve_mask) & uops_7_br_mask;	// util.scala:89:23, :465:24, :466:20, :482:22, :483:23
    if (_GEN_97) begin	// util.scala:481:16, :487:17, :489:33
      uops_8_uopc <= io_enq_bits_uop_uopc;	// util.scala:466:20
      uops_8_inst <= io_enq_bits_uop_inst;	// util.scala:466:20
      uops_8_debug_inst <= io_enq_bits_uop_debug_inst;	// util.scala:466:20
      uops_8_is_rvc <= io_enq_bits_uop_is_rvc;	// util.scala:466:20
      uops_8_debug_pc <= io_enq_bits_uop_debug_pc;	// util.scala:466:20
      uops_8_iq_type <= io_enq_bits_uop_iq_type;	// util.scala:466:20
      uops_8_fu_code <= io_enq_bits_uop_fu_code;	// util.scala:466:20
      uops_8_ctrl_br_type <= io_enq_bits_uop_ctrl_br_type;	// util.scala:466:20
      uops_8_ctrl_op1_sel <= io_enq_bits_uop_ctrl_op1_sel;	// util.scala:466:20
      uops_8_ctrl_op2_sel <= io_enq_bits_uop_ctrl_op2_sel;	// util.scala:466:20
      uops_8_ctrl_imm_sel <= io_enq_bits_uop_ctrl_imm_sel;	// util.scala:466:20
      uops_8_ctrl_op_fcn <= io_enq_bits_uop_ctrl_op_fcn;	// util.scala:466:20
      uops_8_ctrl_fcn_dw <= io_enq_bits_uop_ctrl_fcn_dw;	// util.scala:466:20
      uops_8_ctrl_csr_cmd <= io_enq_bits_uop_ctrl_csr_cmd;	// util.scala:466:20
      uops_8_ctrl_is_load <= io_enq_bits_uop_ctrl_is_load;	// util.scala:466:20
      uops_8_ctrl_is_sta <= io_enq_bits_uop_ctrl_is_sta;	// util.scala:466:20
      uops_8_ctrl_is_std <= io_enq_bits_uop_ctrl_is_std;	// util.scala:466:20
      uops_8_iw_state <= io_enq_bits_uop_iw_state;	// util.scala:466:20
      uops_8_iw_p1_poisoned <= io_enq_bits_uop_iw_p1_poisoned;	// util.scala:466:20
      uops_8_iw_p2_poisoned <= io_enq_bits_uop_iw_p2_poisoned;	// util.scala:466:20
      uops_8_is_br <= io_enq_bits_uop_is_br;	// util.scala:466:20
      uops_8_is_jalr <= io_enq_bits_uop_is_jalr;	// util.scala:466:20
      uops_8_is_jal <= io_enq_bits_uop_is_jal;	// util.scala:466:20
      uops_8_is_sfb <= io_enq_bits_uop_is_sfb;	// util.scala:466:20
      uops_8_br_tag <= io_enq_bits_uop_br_tag;	// util.scala:466:20
      uops_8_ftq_idx <= io_enq_bits_uop_ftq_idx;	// util.scala:466:20
      uops_8_edge_inst <= io_enq_bits_uop_edge_inst;	// util.scala:466:20
      uops_8_pc_lob <= io_enq_bits_uop_pc_lob;	// util.scala:466:20
      uops_8_taken <= io_enq_bits_uop_taken;	// util.scala:466:20
      uops_8_imm_packed <= io_enq_bits_uop_imm_packed;	// util.scala:466:20
      uops_8_csr_addr <= io_enq_bits_uop_csr_addr;	// util.scala:466:20
      uops_8_rob_idx <= io_enq_bits_uop_rob_idx;	// util.scala:466:20
      uops_8_ldq_idx <= io_enq_bits_uop_ldq_idx;	// util.scala:466:20
      uops_8_stq_idx <= io_enq_bits_uop_stq_idx;	// util.scala:466:20
      uops_8_rxq_idx <= io_enq_bits_uop_rxq_idx;	// util.scala:466:20
      uops_8_pdst <= io_enq_bits_uop_pdst;	// util.scala:466:20
      uops_8_prs1 <= io_enq_bits_uop_prs1;	// util.scala:466:20
      uops_8_prs2 <= io_enq_bits_uop_prs2;	// util.scala:466:20
      uops_8_prs3 <= io_enq_bits_uop_prs3;	// util.scala:466:20
      uops_8_ppred <= io_enq_bits_uop_ppred;	// util.scala:466:20
      uops_8_prs1_busy <= io_enq_bits_uop_prs1_busy;	// util.scala:466:20
      uops_8_prs2_busy <= io_enq_bits_uop_prs2_busy;	// util.scala:466:20
      uops_8_prs3_busy <= io_enq_bits_uop_prs3_busy;	// util.scala:466:20
      uops_8_ppred_busy <= io_enq_bits_uop_ppred_busy;	// util.scala:466:20
      uops_8_stale_pdst <= io_enq_bits_uop_stale_pdst;	// util.scala:466:20
      uops_8_exception <= io_enq_bits_uop_exception;	// util.scala:466:20
      uops_8_exc_cause <= io_enq_bits_uop_exc_cause;	// util.scala:466:20
      uops_8_bypassable <= io_enq_bits_uop_bypassable;	// util.scala:466:20
      uops_8_mem_cmd <= io_enq_bits_uop_mem_cmd;	// util.scala:466:20
      uops_8_mem_size <= io_enq_bits_uop_mem_size;	// util.scala:466:20
      uops_8_mem_signed <= io_enq_bits_uop_mem_signed;	// util.scala:466:20
      uops_8_is_fence <= io_enq_bits_uop_is_fence;	// util.scala:466:20
      uops_8_is_fencei <= io_enq_bits_uop_is_fencei;	// util.scala:466:20
      uops_8_is_amo <= io_enq_bits_uop_is_amo;	// util.scala:466:20
      uops_8_uses_ldq <= io_enq_bits_uop_uses_ldq;	// util.scala:466:20
      uops_8_uses_stq <= io_enq_bits_uop_uses_stq;	// util.scala:466:20
      uops_8_is_sys_pc2epc <= io_enq_bits_uop_is_sys_pc2epc;	// util.scala:466:20
      uops_8_is_unique <= io_enq_bits_uop_is_unique;	// util.scala:466:20
      uops_8_flush_on_commit <= io_enq_bits_uop_flush_on_commit;	// util.scala:466:20
      uops_8_ldst_is_rs1 <= io_enq_bits_uop_ldst_is_rs1;	// util.scala:466:20
      uops_8_ldst <= io_enq_bits_uop_ldst;	// util.scala:466:20
      uops_8_lrs1 <= io_enq_bits_uop_lrs1;	// util.scala:466:20
      uops_8_lrs2 <= io_enq_bits_uop_lrs2;	// util.scala:466:20
      uops_8_lrs3 <= io_enq_bits_uop_lrs3;	// util.scala:466:20
      uops_8_ldst_val <= io_enq_bits_uop_ldst_val;	// util.scala:466:20
      uops_8_dst_rtype <= io_enq_bits_uop_dst_rtype;	// util.scala:466:20
      uops_8_lrs1_rtype <= io_enq_bits_uop_lrs1_rtype;	// util.scala:466:20
      uops_8_lrs2_rtype <= io_enq_bits_uop_lrs2_rtype;	// util.scala:466:20
      uops_8_frs3_en <= io_enq_bits_uop_frs3_en;	// util.scala:466:20
      uops_8_fp_val <= io_enq_bits_uop_fp_val;	// util.scala:466:20
      uops_8_fp_single <= io_enq_bits_uop_fp_single;	// util.scala:466:20
      uops_8_xcpt_pf_if <= io_enq_bits_uop_xcpt_pf_if;	// util.scala:466:20
      uops_8_xcpt_ae_if <= io_enq_bits_uop_xcpt_ae_if;	// util.scala:466:20
      uops_8_xcpt_ma_if <= io_enq_bits_uop_xcpt_ma_if;	// util.scala:466:20
      uops_8_bp_debug_if <= io_enq_bits_uop_bp_debug_if;	// util.scala:466:20
      uops_8_bp_xcpt_if <= io_enq_bits_uop_bp_xcpt_if;	// util.scala:466:20
      uops_8_debug_fsrc <= io_enq_bits_uop_debug_fsrc;	// util.scala:466:20
      uops_8_debug_tsrc <= io_enq_bits_uop_debug_tsrc;	// util.scala:466:20
    end
    if (do_enq & _GEN_96)	// Decoupled.scala:40:37, util.scala:482:22, :487:17, :489:33, :491:33
      uops_8_br_mask <= _uops_br_mask_T_1;	// util.scala:85:25, :466:20
    else	// util.scala:482:22, :487:17, :491:33
      uops_8_br_mask <= ({20{~valids_8}} | ~io_brupdate_b1_resolve_mask) & uops_8_br_mask;	// util.scala:89:23, :465:24, :466:20, :482:22, :483:23
    if (_GEN_99) begin	// util.scala:481:16, :487:17, :489:33
      uops_9_uopc <= io_enq_bits_uop_uopc;	// util.scala:466:20
      uops_9_inst <= io_enq_bits_uop_inst;	// util.scala:466:20
      uops_9_debug_inst <= io_enq_bits_uop_debug_inst;	// util.scala:466:20
      uops_9_is_rvc <= io_enq_bits_uop_is_rvc;	// util.scala:466:20
      uops_9_debug_pc <= io_enq_bits_uop_debug_pc;	// util.scala:466:20
      uops_9_iq_type <= io_enq_bits_uop_iq_type;	// util.scala:466:20
      uops_9_fu_code <= io_enq_bits_uop_fu_code;	// util.scala:466:20
      uops_9_ctrl_br_type <= io_enq_bits_uop_ctrl_br_type;	// util.scala:466:20
      uops_9_ctrl_op1_sel <= io_enq_bits_uop_ctrl_op1_sel;	// util.scala:466:20
      uops_9_ctrl_op2_sel <= io_enq_bits_uop_ctrl_op2_sel;	// util.scala:466:20
      uops_9_ctrl_imm_sel <= io_enq_bits_uop_ctrl_imm_sel;	// util.scala:466:20
      uops_9_ctrl_op_fcn <= io_enq_bits_uop_ctrl_op_fcn;	// util.scala:466:20
      uops_9_ctrl_fcn_dw <= io_enq_bits_uop_ctrl_fcn_dw;	// util.scala:466:20
      uops_9_ctrl_csr_cmd <= io_enq_bits_uop_ctrl_csr_cmd;	// util.scala:466:20
      uops_9_ctrl_is_load <= io_enq_bits_uop_ctrl_is_load;	// util.scala:466:20
      uops_9_ctrl_is_sta <= io_enq_bits_uop_ctrl_is_sta;	// util.scala:466:20
      uops_9_ctrl_is_std <= io_enq_bits_uop_ctrl_is_std;	// util.scala:466:20
      uops_9_iw_state <= io_enq_bits_uop_iw_state;	// util.scala:466:20
      uops_9_iw_p1_poisoned <= io_enq_bits_uop_iw_p1_poisoned;	// util.scala:466:20
      uops_9_iw_p2_poisoned <= io_enq_bits_uop_iw_p2_poisoned;	// util.scala:466:20
      uops_9_is_br <= io_enq_bits_uop_is_br;	// util.scala:466:20
      uops_9_is_jalr <= io_enq_bits_uop_is_jalr;	// util.scala:466:20
      uops_9_is_jal <= io_enq_bits_uop_is_jal;	// util.scala:466:20
      uops_9_is_sfb <= io_enq_bits_uop_is_sfb;	// util.scala:466:20
      uops_9_br_tag <= io_enq_bits_uop_br_tag;	// util.scala:466:20
      uops_9_ftq_idx <= io_enq_bits_uop_ftq_idx;	// util.scala:466:20
      uops_9_edge_inst <= io_enq_bits_uop_edge_inst;	// util.scala:466:20
      uops_9_pc_lob <= io_enq_bits_uop_pc_lob;	// util.scala:466:20
      uops_9_taken <= io_enq_bits_uop_taken;	// util.scala:466:20
      uops_9_imm_packed <= io_enq_bits_uop_imm_packed;	// util.scala:466:20
      uops_9_csr_addr <= io_enq_bits_uop_csr_addr;	// util.scala:466:20
      uops_9_rob_idx <= io_enq_bits_uop_rob_idx;	// util.scala:466:20
      uops_9_ldq_idx <= io_enq_bits_uop_ldq_idx;	// util.scala:466:20
      uops_9_stq_idx <= io_enq_bits_uop_stq_idx;	// util.scala:466:20
      uops_9_rxq_idx <= io_enq_bits_uop_rxq_idx;	// util.scala:466:20
      uops_9_pdst <= io_enq_bits_uop_pdst;	// util.scala:466:20
      uops_9_prs1 <= io_enq_bits_uop_prs1;	// util.scala:466:20
      uops_9_prs2 <= io_enq_bits_uop_prs2;	// util.scala:466:20
      uops_9_prs3 <= io_enq_bits_uop_prs3;	// util.scala:466:20
      uops_9_ppred <= io_enq_bits_uop_ppred;	// util.scala:466:20
      uops_9_prs1_busy <= io_enq_bits_uop_prs1_busy;	// util.scala:466:20
      uops_9_prs2_busy <= io_enq_bits_uop_prs2_busy;	// util.scala:466:20
      uops_9_prs3_busy <= io_enq_bits_uop_prs3_busy;	// util.scala:466:20
      uops_9_ppred_busy <= io_enq_bits_uop_ppred_busy;	// util.scala:466:20
      uops_9_stale_pdst <= io_enq_bits_uop_stale_pdst;	// util.scala:466:20
      uops_9_exception <= io_enq_bits_uop_exception;	// util.scala:466:20
      uops_9_exc_cause <= io_enq_bits_uop_exc_cause;	// util.scala:466:20
      uops_9_bypassable <= io_enq_bits_uop_bypassable;	// util.scala:466:20
      uops_9_mem_cmd <= io_enq_bits_uop_mem_cmd;	// util.scala:466:20
      uops_9_mem_size <= io_enq_bits_uop_mem_size;	// util.scala:466:20
      uops_9_mem_signed <= io_enq_bits_uop_mem_signed;	// util.scala:466:20
      uops_9_is_fence <= io_enq_bits_uop_is_fence;	// util.scala:466:20
      uops_9_is_fencei <= io_enq_bits_uop_is_fencei;	// util.scala:466:20
      uops_9_is_amo <= io_enq_bits_uop_is_amo;	// util.scala:466:20
      uops_9_uses_ldq <= io_enq_bits_uop_uses_ldq;	// util.scala:466:20
      uops_9_uses_stq <= io_enq_bits_uop_uses_stq;	// util.scala:466:20
      uops_9_is_sys_pc2epc <= io_enq_bits_uop_is_sys_pc2epc;	// util.scala:466:20
      uops_9_is_unique <= io_enq_bits_uop_is_unique;	// util.scala:466:20
      uops_9_flush_on_commit <= io_enq_bits_uop_flush_on_commit;	// util.scala:466:20
      uops_9_ldst_is_rs1 <= io_enq_bits_uop_ldst_is_rs1;	// util.scala:466:20
      uops_9_ldst <= io_enq_bits_uop_ldst;	// util.scala:466:20
      uops_9_lrs1 <= io_enq_bits_uop_lrs1;	// util.scala:466:20
      uops_9_lrs2 <= io_enq_bits_uop_lrs2;	// util.scala:466:20
      uops_9_lrs3 <= io_enq_bits_uop_lrs3;	// util.scala:466:20
      uops_9_ldst_val <= io_enq_bits_uop_ldst_val;	// util.scala:466:20
      uops_9_dst_rtype <= io_enq_bits_uop_dst_rtype;	// util.scala:466:20
      uops_9_lrs1_rtype <= io_enq_bits_uop_lrs1_rtype;	// util.scala:466:20
      uops_9_lrs2_rtype <= io_enq_bits_uop_lrs2_rtype;	// util.scala:466:20
      uops_9_frs3_en <= io_enq_bits_uop_frs3_en;	// util.scala:466:20
      uops_9_fp_val <= io_enq_bits_uop_fp_val;	// util.scala:466:20
      uops_9_fp_single <= io_enq_bits_uop_fp_single;	// util.scala:466:20
      uops_9_xcpt_pf_if <= io_enq_bits_uop_xcpt_pf_if;	// util.scala:466:20
      uops_9_xcpt_ae_if <= io_enq_bits_uop_xcpt_ae_if;	// util.scala:466:20
      uops_9_xcpt_ma_if <= io_enq_bits_uop_xcpt_ma_if;	// util.scala:466:20
      uops_9_bp_debug_if <= io_enq_bits_uop_bp_debug_if;	// util.scala:466:20
      uops_9_bp_xcpt_if <= io_enq_bits_uop_bp_xcpt_if;	// util.scala:466:20
      uops_9_debug_fsrc <= io_enq_bits_uop_debug_fsrc;	// util.scala:466:20
      uops_9_debug_tsrc <= io_enq_bits_uop_debug_tsrc;	// util.scala:466:20
    end
    if (do_enq & _GEN_98)	// Decoupled.scala:40:37, util.scala:482:22, :487:17, :489:33, :491:33
      uops_9_br_mask <= _uops_br_mask_T_1;	// util.scala:85:25, :466:20
    else	// util.scala:482:22, :487:17, :491:33
      uops_9_br_mask <= ({20{~valids_9}} | ~io_brupdate_b1_resolve_mask) & uops_9_br_mask;	// util.scala:89:23, :465:24, :466:20, :482:22, :483:23
    if (_GEN_101) begin	// util.scala:481:16, :487:17, :489:33
      uops_10_uopc <= io_enq_bits_uop_uopc;	// util.scala:466:20
      uops_10_inst <= io_enq_bits_uop_inst;	// util.scala:466:20
      uops_10_debug_inst <= io_enq_bits_uop_debug_inst;	// util.scala:466:20
      uops_10_is_rvc <= io_enq_bits_uop_is_rvc;	// util.scala:466:20
      uops_10_debug_pc <= io_enq_bits_uop_debug_pc;	// util.scala:466:20
      uops_10_iq_type <= io_enq_bits_uop_iq_type;	// util.scala:466:20
      uops_10_fu_code <= io_enq_bits_uop_fu_code;	// util.scala:466:20
      uops_10_ctrl_br_type <= io_enq_bits_uop_ctrl_br_type;	// util.scala:466:20
      uops_10_ctrl_op1_sel <= io_enq_bits_uop_ctrl_op1_sel;	// util.scala:466:20
      uops_10_ctrl_op2_sel <= io_enq_bits_uop_ctrl_op2_sel;	// util.scala:466:20
      uops_10_ctrl_imm_sel <= io_enq_bits_uop_ctrl_imm_sel;	// util.scala:466:20
      uops_10_ctrl_op_fcn <= io_enq_bits_uop_ctrl_op_fcn;	// util.scala:466:20
      uops_10_ctrl_fcn_dw <= io_enq_bits_uop_ctrl_fcn_dw;	// util.scala:466:20
      uops_10_ctrl_csr_cmd <= io_enq_bits_uop_ctrl_csr_cmd;	// util.scala:466:20
      uops_10_ctrl_is_load <= io_enq_bits_uop_ctrl_is_load;	// util.scala:466:20
      uops_10_ctrl_is_sta <= io_enq_bits_uop_ctrl_is_sta;	// util.scala:466:20
      uops_10_ctrl_is_std <= io_enq_bits_uop_ctrl_is_std;	// util.scala:466:20
      uops_10_iw_state <= io_enq_bits_uop_iw_state;	// util.scala:466:20
      uops_10_iw_p1_poisoned <= io_enq_bits_uop_iw_p1_poisoned;	// util.scala:466:20
      uops_10_iw_p2_poisoned <= io_enq_bits_uop_iw_p2_poisoned;	// util.scala:466:20
      uops_10_is_br <= io_enq_bits_uop_is_br;	// util.scala:466:20
      uops_10_is_jalr <= io_enq_bits_uop_is_jalr;	// util.scala:466:20
      uops_10_is_jal <= io_enq_bits_uop_is_jal;	// util.scala:466:20
      uops_10_is_sfb <= io_enq_bits_uop_is_sfb;	// util.scala:466:20
      uops_10_br_tag <= io_enq_bits_uop_br_tag;	// util.scala:466:20
      uops_10_ftq_idx <= io_enq_bits_uop_ftq_idx;	// util.scala:466:20
      uops_10_edge_inst <= io_enq_bits_uop_edge_inst;	// util.scala:466:20
      uops_10_pc_lob <= io_enq_bits_uop_pc_lob;	// util.scala:466:20
      uops_10_taken <= io_enq_bits_uop_taken;	// util.scala:466:20
      uops_10_imm_packed <= io_enq_bits_uop_imm_packed;	// util.scala:466:20
      uops_10_csr_addr <= io_enq_bits_uop_csr_addr;	// util.scala:466:20
      uops_10_rob_idx <= io_enq_bits_uop_rob_idx;	// util.scala:466:20
      uops_10_ldq_idx <= io_enq_bits_uop_ldq_idx;	// util.scala:466:20
      uops_10_stq_idx <= io_enq_bits_uop_stq_idx;	// util.scala:466:20
      uops_10_rxq_idx <= io_enq_bits_uop_rxq_idx;	// util.scala:466:20
      uops_10_pdst <= io_enq_bits_uop_pdst;	// util.scala:466:20
      uops_10_prs1 <= io_enq_bits_uop_prs1;	// util.scala:466:20
      uops_10_prs2 <= io_enq_bits_uop_prs2;	// util.scala:466:20
      uops_10_prs3 <= io_enq_bits_uop_prs3;	// util.scala:466:20
      uops_10_ppred <= io_enq_bits_uop_ppred;	// util.scala:466:20
      uops_10_prs1_busy <= io_enq_bits_uop_prs1_busy;	// util.scala:466:20
      uops_10_prs2_busy <= io_enq_bits_uop_prs2_busy;	// util.scala:466:20
      uops_10_prs3_busy <= io_enq_bits_uop_prs3_busy;	// util.scala:466:20
      uops_10_ppred_busy <= io_enq_bits_uop_ppred_busy;	// util.scala:466:20
      uops_10_stale_pdst <= io_enq_bits_uop_stale_pdst;	// util.scala:466:20
      uops_10_exception <= io_enq_bits_uop_exception;	// util.scala:466:20
      uops_10_exc_cause <= io_enq_bits_uop_exc_cause;	// util.scala:466:20
      uops_10_bypassable <= io_enq_bits_uop_bypassable;	// util.scala:466:20
      uops_10_mem_cmd <= io_enq_bits_uop_mem_cmd;	// util.scala:466:20
      uops_10_mem_size <= io_enq_bits_uop_mem_size;	// util.scala:466:20
      uops_10_mem_signed <= io_enq_bits_uop_mem_signed;	// util.scala:466:20
      uops_10_is_fence <= io_enq_bits_uop_is_fence;	// util.scala:466:20
      uops_10_is_fencei <= io_enq_bits_uop_is_fencei;	// util.scala:466:20
      uops_10_is_amo <= io_enq_bits_uop_is_amo;	// util.scala:466:20
      uops_10_uses_ldq <= io_enq_bits_uop_uses_ldq;	// util.scala:466:20
      uops_10_uses_stq <= io_enq_bits_uop_uses_stq;	// util.scala:466:20
      uops_10_is_sys_pc2epc <= io_enq_bits_uop_is_sys_pc2epc;	// util.scala:466:20
      uops_10_is_unique <= io_enq_bits_uop_is_unique;	// util.scala:466:20
      uops_10_flush_on_commit <= io_enq_bits_uop_flush_on_commit;	// util.scala:466:20
      uops_10_ldst_is_rs1 <= io_enq_bits_uop_ldst_is_rs1;	// util.scala:466:20
      uops_10_ldst <= io_enq_bits_uop_ldst;	// util.scala:466:20
      uops_10_lrs1 <= io_enq_bits_uop_lrs1;	// util.scala:466:20
      uops_10_lrs2 <= io_enq_bits_uop_lrs2;	// util.scala:466:20
      uops_10_lrs3 <= io_enq_bits_uop_lrs3;	// util.scala:466:20
      uops_10_ldst_val <= io_enq_bits_uop_ldst_val;	// util.scala:466:20
      uops_10_dst_rtype <= io_enq_bits_uop_dst_rtype;	// util.scala:466:20
      uops_10_lrs1_rtype <= io_enq_bits_uop_lrs1_rtype;	// util.scala:466:20
      uops_10_lrs2_rtype <= io_enq_bits_uop_lrs2_rtype;	// util.scala:466:20
      uops_10_frs3_en <= io_enq_bits_uop_frs3_en;	// util.scala:466:20
      uops_10_fp_val <= io_enq_bits_uop_fp_val;	// util.scala:466:20
      uops_10_fp_single <= io_enq_bits_uop_fp_single;	// util.scala:466:20
      uops_10_xcpt_pf_if <= io_enq_bits_uop_xcpt_pf_if;	// util.scala:466:20
      uops_10_xcpt_ae_if <= io_enq_bits_uop_xcpt_ae_if;	// util.scala:466:20
      uops_10_xcpt_ma_if <= io_enq_bits_uop_xcpt_ma_if;	// util.scala:466:20
      uops_10_bp_debug_if <= io_enq_bits_uop_bp_debug_if;	// util.scala:466:20
      uops_10_bp_xcpt_if <= io_enq_bits_uop_bp_xcpt_if;	// util.scala:466:20
      uops_10_debug_fsrc <= io_enq_bits_uop_debug_fsrc;	// util.scala:466:20
      uops_10_debug_tsrc <= io_enq_bits_uop_debug_tsrc;	// util.scala:466:20
    end
    if (do_enq & _GEN_100)	// Decoupled.scala:40:37, util.scala:482:22, :487:17, :489:33, :491:33
      uops_10_br_mask <= _uops_br_mask_T_1;	// util.scala:85:25, :466:20
    else	// util.scala:482:22, :487:17, :491:33
      uops_10_br_mask <=
        ({20{~valids_10}} | ~io_brupdate_b1_resolve_mask) & uops_10_br_mask;	// util.scala:89:23, :465:24, :466:20, :482:22, :483:23
    if (_GEN_103) begin	// util.scala:481:16, :487:17, :489:33
      uops_11_uopc <= io_enq_bits_uop_uopc;	// util.scala:466:20
      uops_11_inst <= io_enq_bits_uop_inst;	// util.scala:466:20
      uops_11_debug_inst <= io_enq_bits_uop_debug_inst;	// util.scala:466:20
      uops_11_is_rvc <= io_enq_bits_uop_is_rvc;	// util.scala:466:20
      uops_11_debug_pc <= io_enq_bits_uop_debug_pc;	// util.scala:466:20
      uops_11_iq_type <= io_enq_bits_uop_iq_type;	// util.scala:466:20
      uops_11_fu_code <= io_enq_bits_uop_fu_code;	// util.scala:466:20
      uops_11_ctrl_br_type <= io_enq_bits_uop_ctrl_br_type;	// util.scala:466:20
      uops_11_ctrl_op1_sel <= io_enq_bits_uop_ctrl_op1_sel;	// util.scala:466:20
      uops_11_ctrl_op2_sel <= io_enq_bits_uop_ctrl_op2_sel;	// util.scala:466:20
      uops_11_ctrl_imm_sel <= io_enq_bits_uop_ctrl_imm_sel;	// util.scala:466:20
      uops_11_ctrl_op_fcn <= io_enq_bits_uop_ctrl_op_fcn;	// util.scala:466:20
      uops_11_ctrl_fcn_dw <= io_enq_bits_uop_ctrl_fcn_dw;	// util.scala:466:20
      uops_11_ctrl_csr_cmd <= io_enq_bits_uop_ctrl_csr_cmd;	// util.scala:466:20
      uops_11_ctrl_is_load <= io_enq_bits_uop_ctrl_is_load;	// util.scala:466:20
      uops_11_ctrl_is_sta <= io_enq_bits_uop_ctrl_is_sta;	// util.scala:466:20
      uops_11_ctrl_is_std <= io_enq_bits_uop_ctrl_is_std;	// util.scala:466:20
      uops_11_iw_state <= io_enq_bits_uop_iw_state;	// util.scala:466:20
      uops_11_iw_p1_poisoned <= io_enq_bits_uop_iw_p1_poisoned;	// util.scala:466:20
      uops_11_iw_p2_poisoned <= io_enq_bits_uop_iw_p2_poisoned;	// util.scala:466:20
      uops_11_is_br <= io_enq_bits_uop_is_br;	// util.scala:466:20
      uops_11_is_jalr <= io_enq_bits_uop_is_jalr;	// util.scala:466:20
      uops_11_is_jal <= io_enq_bits_uop_is_jal;	// util.scala:466:20
      uops_11_is_sfb <= io_enq_bits_uop_is_sfb;	// util.scala:466:20
      uops_11_br_tag <= io_enq_bits_uop_br_tag;	// util.scala:466:20
      uops_11_ftq_idx <= io_enq_bits_uop_ftq_idx;	// util.scala:466:20
      uops_11_edge_inst <= io_enq_bits_uop_edge_inst;	// util.scala:466:20
      uops_11_pc_lob <= io_enq_bits_uop_pc_lob;	// util.scala:466:20
      uops_11_taken <= io_enq_bits_uop_taken;	// util.scala:466:20
      uops_11_imm_packed <= io_enq_bits_uop_imm_packed;	// util.scala:466:20
      uops_11_csr_addr <= io_enq_bits_uop_csr_addr;	// util.scala:466:20
      uops_11_rob_idx <= io_enq_bits_uop_rob_idx;	// util.scala:466:20
      uops_11_ldq_idx <= io_enq_bits_uop_ldq_idx;	// util.scala:466:20
      uops_11_stq_idx <= io_enq_bits_uop_stq_idx;	// util.scala:466:20
      uops_11_rxq_idx <= io_enq_bits_uop_rxq_idx;	// util.scala:466:20
      uops_11_pdst <= io_enq_bits_uop_pdst;	// util.scala:466:20
      uops_11_prs1 <= io_enq_bits_uop_prs1;	// util.scala:466:20
      uops_11_prs2 <= io_enq_bits_uop_prs2;	// util.scala:466:20
      uops_11_prs3 <= io_enq_bits_uop_prs3;	// util.scala:466:20
      uops_11_ppred <= io_enq_bits_uop_ppred;	// util.scala:466:20
      uops_11_prs1_busy <= io_enq_bits_uop_prs1_busy;	// util.scala:466:20
      uops_11_prs2_busy <= io_enq_bits_uop_prs2_busy;	// util.scala:466:20
      uops_11_prs3_busy <= io_enq_bits_uop_prs3_busy;	// util.scala:466:20
      uops_11_ppred_busy <= io_enq_bits_uop_ppred_busy;	// util.scala:466:20
      uops_11_stale_pdst <= io_enq_bits_uop_stale_pdst;	// util.scala:466:20
      uops_11_exception <= io_enq_bits_uop_exception;	// util.scala:466:20
      uops_11_exc_cause <= io_enq_bits_uop_exc_cause;	// util.scala:466:20
      uops_11_bypassable <= io_enq_bits_uop_bypassable;	// util.scala:466:20
      uops_11_mem_cmd <= io_enq_bits_uop_mem_cmd;	// util.scala:466:20
      uops_11_mem_size <= io_enq_bits_uop_mem_size;	// util.scala:466:20
      uops_11_mem_signed <= io_enq_bits_uop_mem_signed;	// util.scala:466:20
      uops_11_is_fence <= io_enq_bits_uop_is_fence;	// util.scala:466:20
      uops_11_is_fencei <= io_enq_bits_uop_is_fencei;	// util.scala:466:20
      uops_11_is_amo <= io_enq_bits_uop_is_amo;	// util.scala:466:20
      uops_11_uses_ldq <= io_enq_bits_uop_uses_ldq;	// util.scala:466:20
      uops_11_uses_stq <= io_enq_bits_uop_uses_stq;	// util.scala:466:20
      uops_11_is_sys_pc2epc <= io_enq_bits_uop_is_sys_pc2epc;	// util.scala:466:20
      uops_11_is_unique <= io_enq_bits_uop_is_unique;	// util.scala:466:20
      uops_11_flush_on_commit <= io_enq_bits_uop_flush_on_commit;	// util.scala:466:20
      uops_11_ldst_is_rs1 <= io_enq_bits_uop_ldst_is_rs1;	// util.scala:466:20
      uops_11_ldst <= io_enq_bits_uop_ldst;	// util.scala:466:20
      uops_11_lrs1 <= io_enq_bits_uop_lrs1;	// util.scala:466:20
      uops_11_lrs2 <= io_enq_bits_uop_lrs2;	// util.scala:466:20
      uops_11_lrs3 <= io_enq_bits_uop_lrs3;	// util.scala:466:20
      uops_11_ldst_val <= io_enq_bits_uop_ldst_val;	// util.scala:466:20
      uops_11_dst_rtype <= io_enq_bits_uop_dst_rtype;	// util.scala:466:20
      uops_11_lrs1_rtype <= io_enq_bits_uop_lrs1_rtype;	// util.scala:466:20
      uops_11_lrs2_rtype <= io_enq_bits_uop_lrs2_rtype;	// util.scala:466:20
      uops_11_frs3_en <= io_enq_bits_uop_frs3_en;	// util.scala:466:20
      uops_11_fp_val <= io_enq_bits_uop_fp_val;	// util.scala:466:20
      uops_11_fp_single <= io_enq_bits_uop_fp_single;	// util.scala:466:20
      uops_11_xcpt_pf_if <= io_enq_bits_uop_xcpt_pf_if;	// util.scala:466:20
      uops_11_xcpt_ae_if <= io_enq_bits_uop_xcpt_ae_if;	// util.scala:466:20
      uops_11_xcpt_ma_if <= io_enq_bits_uop_xcpt_ma_if;	// util.scala:466:20
      uops_11_bp_debug_if <= io_enq_bits_uop_bp_debug_if;	// util.scala:466:20
      uops_11_bp_xcpt_if <= io_enq_bits_uop_bp_xcpt_if;	// util.scala:466:20
      uops_11_debug_fsrc <= io_enq_bits_uop_debug_fsrc;	// util.scala:466:20
      uops_11_debug_tsrc <= io_enq_bits_uop_debug_tsrc;	// util.scala:466:20
    end
    if (do_enq & _GEN_102)	// Decoupled.scala:40:37, util.scala:482:22, :487:17, :489:33, :491:33
      uops_11_br_mask <= _uops_br_mask_T_1;	// util.scala:85:25, :466:20
    else	// util.scala:482:22, :487:17, :491:33
      uops_11_br_mask <=
        ({20{~valids_11}} | ~io_brupdate_b1_resolve_mask) & uops_11_br_mask;	// util.scala:89:23, :465:24, :466:20, :482:22, :483:23
    if (_GEN_105) begin	// util.scala:481:16, :487:17, :489:33
      uops_12_uopc <= io_enq_bits_uop_uopc;	// util.scala:466:20
      uops_12_inst <= io_enq_bits_uop_inst;	// util.scala:466:20
      uops_12_debug_inst <= io_enq_bits_uop_debug_inst;	// util.scala:466:20
      uops_12_is_rvc <= io_enq_bits_uop_is_rvc;	// util.scala:466:20
      uops_12_debug_pc <= io_enq_bits_uop_debug_pc;	// util.scala:466:20
      uops_12_iq_type <= io_enq_bits_uop_iq_type;	// util.scala:466:20
      uops_12_fu_code <= io_enq_bits_uop_fu_code;	// util.scala:466:20
      uops_12_ctrl_br_type <= io_enq_bits_uop_ctrl_br_type;	// util.scala:466:20
      uops_12_ctrl_op1_sel <= io_enq_bits_uop_ctrl_op1_sel;	// util.scala:466:20
      uops_12_ctrl_op2_sel <= io_enq_bits_uop_ctrl_op2_sel;	// util.scala:466:20
      uops_12_ctrl_imm_sel <= io_enq_bits_uop_ctrl_imm_sel;	// util.scala:466:20
      uops_12_ctrl_op_fcn <= io_enq_bits_uop_ctrl_op_fcn;	// util.scala:466:20
      uops_12_ctrl_fcn_dw <= io_enq_bits_uop_ctrl_fcn_dw;	// util.scala:466:20
      uops_12_ctrl_csr_cmd <= io_enq_bits_uop_ctrl_csr_cmd;	// util.scala:466:20
      uops_12_ctrl_is_load <= io_enq_bits_uop_ctrl_is_load;	// util.scala:466:20
      uops_12_ctrl_is_sta <= io_enq_bits_uop_ctrl_is_sta;	// util.scala:466:20
      uops_12_ctrl_is_std <= io_enq_bits_uop_ctrl_is_std;	// util.scala:466:20
      uops_12_iw_state <= io_enq_bits_uop_iw_state;	// util.scala:466:20
      uops_12_iw_p1_poisoned <= io_enq_bits_uop_iw_p1_poisoned;	// util.scala:466:20
      uops_12_iw_p2_poisoned <= io_enq_bits_uop_iw_p2_poisoned;	// util.scala:466:20
      uops_12_is_br <= io_enq_bits_uop_is_br;	// util.scala:466:20
      uops_12_is_jalr <= io_enq_bits_uop_is_jalr;	// util.scala:466:20
      uops_12_is_jal <= io_enq_bits_uop_is_jal;	// util.scala:466:20
      uops_12_is_sfb <= io_enq_bits_uop_is_sfb;	// util.scala:466:20
      uops_12_br_tag <= io_enq_bits_uop_br_tag;	// util.scala:466:20
      uops_12_ftq_idx <= io_enq_bits_uop_ftq_idx;	// util.scala:466:20
      uops_12_edge_inst <= io_enq_bits_uop_edge_inst;	// util.scala:466:20
      uops_12_pc_lob <= io_enq_bits_uop_pc_lob;	// util.scala:466:20
      uops_12_taken <= io_enq_bits_uop_taken;	// util.scala:466:20
      uops_12_imm_packed <= io_enq_bits_uop_imm_packed;	// util.scala:466:20
      uops_12_csr_addr <= io_enq_bits_uop_csr_addr;	// util.scala:466:20
      uops_12_rob_idx <= io_enq_bits_uop_rob_idx;	// util.scala:466:20
      uops_12_ldq_idx <= io_enq_bits_uop_ldq_idx;	// util.scala:466:20
      uops_12_stq_idx <= io_enq_bits_uop_stq_idx;	// util.scala:466:20
      uops_12_rxq_idx <= io_enq_bits_uop_rxq_idx;	// util.scala:466:20
      uops_12_pdst <= io_enq_bits_uop_pdst;	// util.scala:466:20
      uops_12_prs1 <= io_enq_bits_uop_prs1;	// util.scala:466:20
      uops_12_prs2 <= io_enq_bits_uop_prs2;	// util.scala:466:20
      uops_12_prs3 <= io_enq_bits_uop_prs3;	// util.scala:466:20
      uops_12_ppred <= io_enq_bits_uop_ppred;	// util.scala:466:20
      uops_12_prs1_busy <= io_enq_bits_uop_prs1_busy;	// util.scala:466:20
      uops_12_prs2_busy <= io_enq_bits_uop_prs2_busy;	// util.scala:466:20
      uops_12_prs3_busy <= io_enq_bits_uop_prs3_busy;	// util.scala:466:20
      uops_12_ppred_busy <= io_enq_bits_uop_ppred_busy;	// util.scala:466:20
      uops_12_stale_pdst <= io_enq_bits_uop_stale_pdst;	// util.scala:466:20
      uops_12_exception <= io_enq_bits_uop_exception;	// util.scala:466:20
      uops_12_exc_cause <= io_enq_bits_uop_exc_cause;	// util.scala:466:20
      uops_12_bypassable <= io_enq_bits_uop_bypassable;	// util.scala:466:20
      uops_12_mem_cmd <= io_enq_bits_uop_mem_cmd;	// util.scala:466:20
      uops_12_mem_size <= io_enq_bits_uop_mem_size;	// util.scala:466:20
      uops_12_mem_signed <= io_enq_bits_uop_mem_signed;	// util.scala:466:20
      uops_12_is_fence <= io_enq_bits_uop_is_fence;	// util.scala:466:20
      uops_12_is_fencei <= io_enq_bits_uop_is_fencei;	// util.scala:466:20
      uops_12_is_amo <= io_enq_bits_uop_is_amo;	// util.scala:466:20
      uops_12_uses_ldq <= io_enq_bits_uop_uses_ldq;	// util.scala:466:20
      uops_12_uses_stq <= io_enq_bits_uop_uses_stq;	// util.scala:466:20
      uops_12_is_sys_pc2epc <= io_enq_bits_uop_is_sys_pc2epc;	// util.scala:466:20
      uops_12_is_unique <= io_enq_bits_uop_is_unique;	// util.scala:466:20
      uops_12_flush_on_commit <= io_enq_bits_uop_flush_on_commit;	// util.scala:466:20
      uops_12_ldst_is_rs1 <= io_enq_bits_uop_ldst_is_rs1;	// util.scala:466:20
      uops_12_ldst <= io_enq_bits_uop_ldst;	// util.scala:466:20
      uops_12_lrs1 <= io_enq_bits_uop_lrs1;	// util.scala:466:20
      uops_12_lrs2 <= io_enq_bits_uop_lrs2;	// util.scala:466:20
      uops_12_lrs3 <= io_enq_bits_uop_lrs3;	// util.scala:466:20
      uops_12_ldst_val <= io_enq_bits_uop_ldst_val;	// util.scala:466:20
      uops_12_dst_rtype <= io_enq_bits_uop_dst_rtype;	// util.scala:466:20
      uops_12_lrs1_rtype <= io_enq_bits_uop_lrs1_rtype;	// util.scala:466:20
      uops_12_lrs2_rtype <= io_enq_bits_uop_lrs2_rtype;	// util.scala:466:20
      uops_12_frs3_en <= io_enq_bits_uop_frs3_en;	// util.scala:466:20
      uops_12_fp_val <= io_enq_bits_uop_fp_val;	// util.scala:466:20
      uops_12_fp_single <= io_enq_bits_uop_fp_single;	// util.scala:466:20
      uops_12_xcpt_pf_if <= io_enq_bits_uop_xcpt_pf_if;	// util.scala:466:20
      uops_12_xcpt_ae_if <= io_enq_bits_uop_xcpt_ae_if;	// util.scala:466:20
      uops_12_xcpt_ma_if <= io_enq_bits_uop_xcpt_ma_if;	// util.scala:466:20
      uops_12_bp_debug_if <= io_enq_bits_uop_bp_debug_if;	// util.scala:466:20
      uops_12_bp_xcpt_if <= io_enq_bits_uop_bp_xcpt_if;	// util.scala:466:20
      uops_12_debug_fsrc <= io_enq_bits_uop_debug_fsrc;	// util.scala:466:20
      uops_12_debug_tsrc <= io_enq_bits_uop_debug_tsrc;	// util.scala:466:20
    end
    if (do_enq & _GEN_104)	// Decoupled.scala:40:37, util.scala:482:22, :487:17, :489:33, :491:33
      uops_12_br_mask <= _uops_br_mask_T_1;	// util.scala:85:25, :466:20
    else	// util.scala:482:22, :487:17, :491:33
      uops_12_br_mask <=
        ({20{~valids_12}} | ~io_brupdate_b1_resolve_mask) & uops_12_br_mask;	// util.scala:89:23, :465:24, :466:20, :482:22, :483:23
    if (_GEN_107) begin	// util.scala:481:16, :487:17, :489:33
      uops_13_uopc <= io_enq_bits_uop_uopc;	// util.scala:466:20
      uops_13_inst <= io_enq_bits_uop_inst;	// util.scala:466:20
      uops_13_debug_inst <= io_enq_bits_uop_debug_inst;	// util.scala:466:20
      uops_13_is_rvc <= io_enq_bits_uop_is_rvc;	// util.scala:466:20
      uops_13_debug_pc <= io_enq_bits_uop_debug_pc;	// util.scala:466:20
      uops_13_iq_type <= io_enq_bits_uop_iq_type;	// util.scala:466:20
      uops_13_fu_code <= io_enq_bits_uop_fu_code;	// util.scala:466:20
      uops_13_ctrl_br_type <= io_enq_bits_uop_ctrl_br_type;	// util.scala:466:20
      uops_13_ctrl_op1_sel <= io_enq_bits_uop_ctrl_op1_sel;	// util.scala:466:20
      uops_13_ctrl_op2_sel <= io_enq_bits_uop_ctrl_op2_sel;	// util.scala:466:20
      uops_13_ctrl_imm_sel <= io_enq_bits_uop_ctrl_imm_sel;	// util.scala:466:20
      uops_13_ctrl_op_fcn <= io_enq_bits_uop_ctrl_op_fcn;	// util.scala:466:20
      uops_13_ctrl_fcn_dw <= io_enq_bits_uop_ctrl_fcn_dw;	// util.scala:466:20
      uops_13_ctrl_csr_cmd <= io_enq_bits_uop_ctrl_csr_cmd;	// util.scala:466:20
      uops_13_ctrl_is_load <= io_enq_bits_uop_ctrl_is_load;	// util.scala:466:20
      uops_13_ctrl_is_sta <= io_enq_bits_uop_ctrl_is_sta;	// util.scala:466:20
      uops_13_ctrl_is_std <= io_enq_bits_uop_ctrl_is_std;	// util.scala:466:20
      uops_13_iw_state <= io_enq_bits_uop_iw_state;	// util.scala:466:20
      uops_13_iw_p1_poisoned <= io_enq_bits_uop_iw_p1_poisoned;	// util.scala:466:20
      uops_13_iw_p2_poisoned <= io_enq_bits_uop_iw_p2_poisoned;	// util.scala:466:20
      uops_13_is_br <= io_enq_bits_uop_is_br;	// util.scala:466:20
      uops_13_is_jalr <= io_enq_bits_uop_is_jalr;	// util.scala:466:20
      uops_13_is_jal <= io_enq_bits_uop_is_jal;	// util.scala:466:20
      uops_13_is_sfb <= io_enq_bits_uop_is_sfb;	// util.scala:466:20
      uops_13_br_tag <= io_enq_bits_uop_br_tag;	// util.scala:466:20
      uops_13_ftq_idx <= io_enq_bits_uop_ftq_idx;	// util.scala:466:20
      uops_13_edge_inst <= io_enq_bits_uop_edge_inst;	// util.scala:466:20
      uops_13_pc_lob <= io_enq_bits_uop_pc_lob;	// util.scala:466:20
      uops_13_taken <= io_enq_bits_uop_taken;	// util.scala:466:20
      uops_13_imm_packed <= io_enq_bits_uop_imm_packed;	// util.scala:466:20
      uops_13_csr_addr <= io_enq_bits_uop_csr_addr;	// util.scala:466:20
      uops_13_rob_idx <= io_enq_bits_uop_rob_idx;	// util.scala:466:20
      uops_13_ldq_idx <= io_enq_bits_uop_ldq_idx;	// util.scala:466:20
      uops_13_stq_idx <= io_enq_bits_uop_stq_idx;	// util.scala:466:20
      uops_13_rxq_idx <= io_enq_bits_uop_rxq_idx;	// util.scala:466:20
      uops_13_pdst <= io_enq_bits_uop_pdst;	// util.scala:466:20
      uops_13_prs1 <= io_enq_bits_uop_prs1;	// util.scala:466:20
      uops_13_prs2 <= io_enq_bits_uop_prs2;	// util.scala:466:20
      uops_13_prs3 <= io_enq_bits_uop_prs3;	// util.scala:466:20
      uops_13_ppred <= io_enq_bits_uop_ppred;	// util.scala:466:20
      uops_13_prs1_busy <= io_enq_bits_uop_prs1_busy;	// util.scala:466:20
      uops_13_prs2_busy <= io_enq_bits_uop_prs2_busy;	// util.scala:466:20
      uops_13_prs3_busy <= io_enq_bits_uop_prs3_busy;	// util.scala:466:20
      uops_13_ppred_busy <= io_enq_bits_uop_ppred_busy;	// util.scala:466:20
      uops_13_stale_pdst <= io_enq_bits_uop_stale_pdst;	// util.scala:466:20
      uops_13_exception <= io_enq_bits_uop_exception;	// util.scala:466:20
      uops_13_exc_cause <= io_enq_bits_uop_exc_cause;	// util.scala:466:20
      uops_13_bypassable <= io_enq_bits_uop_bypassable;	// util.scala:466:20
      uops_13_mem_cmd <= io_enq_bits_uop_mem_cmd;	// util.scala:466:20
      uops_13_mem_size <= io_enq_bits_uop_mem_size;	// util.scala:466:20
      uops_13_mem_signed <= io_enq_bits_uop_mem_signed;	// util.scala:466:20
      uops_13_is_fence <= io_enq_bits_uop_is_fence;	// util.scala:466:20
      uops_13_is_fencei <= io_enq_bits_uop_is_fencei;	// util.scala:466:20
      uops_13_is_amo <= io_enq_bits_uop_is_amo;	// util.scala:466:20
      uops_13_uses_ldq <= io_enq_bits_uop_uses_ldq;	// util.scala:466:20
      uops_13_uses_stq <= io_enq_bits_uop_uses_stq;	// util.scala:466:20
      uops_13_is_sys_pc2epc <= io_enq_bits_uop_is_sys_pc2epc;	// util.scala:466:20
      uops_13_is_unique <= io_enq_bits_uop_is_unique;	// util.scala:466:20
      uops_13_flush_on_commit <= io_enq_bits_uop_flush_on_commit;	// util.scala:466:20
      uops_13_ldst_is_rs1 <= io_enq_bits_uop_ldst_is_rs1;	// util.scala:466:20
      uops_13_ldst <= io_enq_bits_uop_ldst;	// util.scala:466:20
      uops_13_lrs1 <= io_enq_bits_uop_lrs1;	// util.scala:466:20
      uops_13_lrs2 <= io_enq_bits_uop_lrs2;	// util.scala:466:20
      uops_13_lrs3 <= io_enq_bits_uop_lrs3;	// util.scala:466:20
      uops_13_ldst_val <= io_enq_bits_uop_ldst_val;	// util.scala:466:20
      uops_13_dst_rtype <= io_enq_bits_uop_dst_rtype;	// util.scala:466:20
      uops_13_lrs1_rtype <= io_enq_bits_uop_lrs1_rtype;	// util.scala:466:20
      uops_13_lrs2_rtype <= io_enq_bits_uop_lrs2_rtype;	// util.scala:466:20
      uops_13_frs3_en <= io_enq_bits_uop_frs3_en;	// util.scala:466:20
      uops_13_fp_val <= io_enq_bits_uop_fp_val;	// util.scala:466:20
      uops_13_fp_single <= io_enq_bits_uop_fp_single;	// util.scala:466:20
      uops_13_xcpt_pf_if <= io_enq_bits_uop_xcpt_pf_if;	// util.scala:466:20
      uops_13_xcpt_ae_if <= io_enq_bits_uop_xcpt_ae_if;	// util.scala:466:20
      uops_13_xcpt_ma_if <= io_enq_bits_uop_xcpt_ma_if;	// util.scala:466:20
      uops_13_bp_debug_if <= io_enq_bits_uop_bp_debug_if;	// util.scala:466:20
      uops_13_bp_xcpt_if <= io_enq_bits_uop_bp_xcpt_if;	// util.scala:466:20
      uops_13_debug_fsrc <= io_enq_bits_uop_debug_fsrc;	// util.scala:466:20
      uops_13_debug_tsrc <= io_enq_bits_uop_debug_tsrc;	// util.scala:466:20
    end
    if (do_enq & _GEN_106)	// Decoupled.scala:40:37, util.scala:482:22, :487:17, :489:33, :491:33
      uops_13_br_mask <= _uops_br_mask_T_1;	// util.scala:85:25, :466:20
    else	// util.scala:482:22, :487:17, :491:33
      uops_13_br_mask <=
        ({20{~valids_13}} | ~io_brupdate_b1_resolve_mask) & uops_13_br_mask;	// util.scala:89:23, :465:24, :466:20, :482:22, :483:23
    if (_GEN_109) begin	// util.scala:481:16, :487:17, :489:33
      uops_14_uopc <= io_enq_bits_uop_uopc;	// util.scala:466:20
      uops_14_inst <= io_enq_bits_uop_inst;	// util.scala:466:20
      uops_14_debug_inst <= io_enq_bits_uop_debug_inst;	// util.scala:466:20
      uops_14_is_rvc <= io_enq_bits_uop_is_rvc;	// util.scala:466:20
      uops_14_debug_pc <= io_enq_bits_uop_debug_pc;	// util.scala:466:20
      uops_14_iq_type <= io_enq_bits_uop_iq_type;	// util.scala:466:20
      uops_14_fu_code <= io_enq_bits_uop_fu_code;	// util.scala:466:20
      uops_14_ctrl_br_type <= io_enq_bits_uop_ctrl_br_type;	// util.scala:466:20
      uops_14_ctrl_op1_sel <= io_enq_bits_uop_ctrl_op1_sel;	// util.scala:466:20
      uops_14_ctrl_op2_sel <= io_enq_bits_uop_ctrl_op2_sel;	// util.scala:466:20
      uops_14_ctrl_imm_sel <= io_enq_bits_uop_ctrl_imm_sel;	// util.scala:466:20
      uops_14_ctrl_op_fcn <= io_enq_bits_uop_ctrl_op_fcn;	// util.scala:466:20
      uops_14_ctrl_fcn_dw <= io_enq_bits_uop_ctrl_fcn_dw;	// util.scala:466:20
      uops_14_ctrl_csr_cmd <= io_enq_bits_uop_ctrl_csr_cmd;	// util.scala:466:20
      uops_14_ctrl_is_load <= io_enq_bits_uop_ctrl_is_load;	// util.scala:466:20
      uops_14_ctrl_is_sta <= io_enq_bits_uop_ctrl_is_sta;	// util.scala:466:20
      uops_14_ctrl_is_std <= io_enq_bits_uop_ctrl_is_std;	// util.scala:466:20
      uops_14_iw_state <= io_enq_bits_uop_iw_state;	// util.scala:466:20
      uops_14_iw_p1_poisoned <= io_enq_bits_uop_iw_p1_poisoned;	// util.scala:466:20
      uops_14_iw_p2_poisoned <= io_enq_bits_uop_iw_p2_poisoned;	// util.scala:466:20
      uops_14_is_br <= io_enq_bits_uop_is_br;	// util.scala:466:20
      uops_14_is_jalr <= io_enq_bits_uop_is_jalr;	// util.scala:466:20
      uops_14_is_jal <= io_enq_bits_uop_is_jal;	// util.scala:466:20
      uops_14_is_sfb <= io_enq_bits_uop_is_sfb;	// util.scala:466:20
      uops_14_br_tag <= io_enq_bits_uop_br_tag;	// util.scala:466:20
      uops_14_ftq_idx <= io_enq_bits_uop_ftq_idx;	// util.scala:466:20
      uops_14_edge_inst <= io_enq_bits_uop_edge_inst;	// util.scala:466:20
      uops_14_pc_lob <= io_enq_bits_uop_pc_lob;	// util.scala:466:20
      uops_14_taken <= io_enq_bits_uop_taken;	// util.scala:466:20
      uops_14_imm_packed <= io_enq_bits_uop_imm_packed;	// util.scala:466:20
      uops_14_csr_addr <= io_enq_bits_uop_csr_addr;	// util.scala:466:20
      uops_14_rob_idx <= io_enq_bits_uop_rob_idx;	// util.scala:466:20
      uops_14_ldq_idx <= io_enq_bits_uop_ldq_idx;	// util.scala:466:20
      uops_14_stq_idx <= io_enq_bits_uop_stq_idx;	// util.scala:466:20
      uops_14_rxq_idx <= io_enq_bits_uop_rxq_idx;	// util.scala:466:20
      uops_14_pdst <= io_enq_bits_uop_pdst;	// util.scala:466:20
      uops_14_prs1 <= io_enq_bits_uop_prs1;	// util.scala:466:20
      uops_14_prs2 <= io_enq_bits_uop_prs2;	// util.scala:466:20
      uops_14_prs3 <= io_enq_bits_uop_prs3;	// util.scala:466:20
      uops_14_ppred <= io_enq_bits_uop_ppred;	// util.scala:466:20
      uops_14_prs1_busy <= io_enq_bits_uop_prs1_busy;	// util.scala:466:20
      uops_14_prs2_busy <= io_enq_bits_uop_prs2_busy;	// util.scala:466:20
      uops_14_prs3_busy <= io_enq_bits_uop_prs3_busy;	// util.scala:466:20
      uops_14_ppred_busy <= io_enq_bits_uop_ppred_busy;	// util.scala:466:20
      uops_14_stale_pdst <= io_enq_bits_uop_stale_pdst;	// util.scala:466:20
      uops_14_exception <= io_enq_bits_uop_exception;	// util.scala:466:20
      uops_14_exc_cause <= io_enq_bits_uop_exc_cause;	// util.scala:466:20
      uops_14_bypassable <= io_enq_bits_uop_bypassable;	// util.scala:466:20
      uops_14_mem_cmd <= io_enq_bits_uop_mem_cmd;	// util.scala:466:20
      uops_14_mem_size <= io_enq_bits_uop_mem_size;	// util.scala:466:20
      uops_14_mem_signed <= io_enq_bits_uop_mem_signed;	// util.scala:466:20
      uops_14_is_fence <= io_enq_bits_uop_is_fence;	// util.scala:466:20
      uops_14_is_fencei <= io_enq_bits_uop_is_fencei;	// util.scala:466:20
      uops_14_is_amo <= io_enq_bits_uop_is_amo;	// util.scala:466:20
      uops_14_uses_ldq <= io_enq_bits_uop_uses_ldq;	// util.scala:466:20
      uops_14_uses_stq <= io_enq_bits_uop_uses_stq;	// util.scala:466:20
      uops_14_is_sys_pc2epc <= io_enq_bits_uop_is_sys_pc2epc;	// util.scala:466:20
      uops_14_is_unique <= io_enq_bits_uop_is_unique;	// util.scala:466:20
      uops_14_flush_on_commit <= io_enq_bits_uop_flush_on_commit;	// util.scala:466:20
      uops_14_ldst_is_rs1 <= io_enq_bits_uop_ldst_is_rs1;	// util.scala:466:20
      uops_14_ldst <= io_enq_bits_uop_ldst;	// util.scala:466:20
      uops_14_lrs1 <= io_enq_bits_uop_lrs1;	// util.scala:466:20
      uops_14_lrs2 <= io_enq_bits_uop_lrs2;	// util.scala:466:20
      uops_14_lrs3 <= io_enq_bits_uop_lrs3;	// util.scala:466:20
      uops_14_ldst_val <= io_enq_bits_uop_ldst_val;	// util.scala:466:20
      uops_14_dst_rtype <= io_enq_bits_uop_dst_rtype;	// util.scala:466:20
      uops_14_lrs1_rtype <= io_enq_bits_uop_lrs1_rtype;	// util.scala:466:20
      uops_14_lrs2_rtype <= io_enq_bits_uop_lrs2_rtype;	// util.scala:466:20
      uops_14_frs3_en <= io_enq_bits_uop_frs3_en;	// util.scala:466:20
      uops_14_fp_val <= io_enq_bits_uop_fp_val;	// util.scala:466:20
      uops_14_fp_single <= io_enq_bits_uop_fp_single;	// util.scala:466:20
      uops_14_xcpt_pf_if <= io_enq_bits_uop_xcpt_pf_if;	// util.scala:466:20
      uops_14_xcpt_ae_if <= io_enq_bits_uop_xcpt_ae_if;	// util.scala:466:20
      uops_14_xcpt_ma_if <= io_enq_bits_uop_xcpt_ma_if;	// util.scala:466:20
      uops_14_bp_debug_if <= io_enq_bits_uop_bp_debug_if;	// util.scala:466:20
      uops_14_bp_xcpt_if <= io_enq_bits_uop_bp_xcpt_if;	// util.scala:466:20
      uops_14_debug_fsrc <= io_enq_bits_uop_debug_fsrc;	// util.scala:466:20
      uops_14_debug_tsrc <= io_enq_bits_uop_debug_tsrc;	// util.scala:466:20
    end
    if (do_enq & _GEN_108)	// Decoupled.scala:40:37, util.scala:482:22, :487:17, :489:33, :491:33
      uops_14_br_mask <= _uops_br_mask_T_1;	// util.scala:85:25, :466:20
    else	// util.scala:482:22, :487:17, :491:33
      uops_14_br_mask <=
        ({20{~valids_14}} | ~io_brupdate_b1_resolve_mask) & uops_14_br_mask;	// util.scala:89:23, :465:24, :466:20, :482:22, :483:23
    if (_GEN_110) begin	// util.scala:481:16, :487:17, :489:33
      uops_15_uopc <= io_enq_bits_uop_uopc;	// util.scala:466:20
      uops_15_inst <= io_enq_bits_uop_inst;	// util.scala:466:20
      uops_15_debug_inst <= io_enq_bits_uop_debug_inst;	// util.scala:466:20
      uops_15_is_rvc <= io_enq_bits_uop_is_rvc;	// util.scala:466:20
      uops_15_debug_pc <= io_enq_bits_uop_debug_pc;	// util.scala:466:20
      uops_15_iq_type <= io_enq_bits_uop_iq_type;	// util.scala:466:20
      uops_15_fu_code <= io_enq_bits_uop_fu_code;	// util.scala:466:20
      uops_15_ctrl_br_type <= io_enq_bits_uop_ctrl_br_type;	// util.scala:466:20
      uops_15_ctrl_op1_sel <= io_enq_bits_uop_ctrl_op1_sel;	// util.scala:466:20
      uops_15_ctrl_op2_sel <= io_enq_bits_uop_ctrl_op2_sel;	// util.scala:466:20
      uops_15_ctrl_imm_sel <= io_enq_bits_uop_ctrl_imm_sel;	// util.scala:466:20
      uops_15_ctrl_op_fcn <= io_enq_bits_uop_ctrl_op_fcn;	// util.scala:466:20
      uops_15_ctrl_fcn_dw <= io_enq_bits_uop_ctrl_fcn_dw;	// util.scala:466:20
      uops_15_ctrl_csr_cmd <= io_enq_bits_uop_ctrl_csr_cmd;	// util.scala:466:20
      uops_15_ctrl_is_load <= io_enq_bits_uop_ctrl_is_load;	// util.scala:466:20
      uops_15_ctrl_is_sta <= io_enq_bits_uop_ctrl_is_sta;	// util.scala:466:20
      uops_15_ctrl_is_std <= io_enq_bits_uop_ctrl_is_std;	// util.scala:466:20
      uops_15_iw_state <= io_enq_bits_uop_iw_state;	// util.scala:466:20
      uops_15_iw_p1_poisoned <= io_enq_bits_uop_iw_p1_poisoned;	// util.scala:466:20
      uops_15_iw_p2_poisoned <= io_enq_bits_uop_iw_p2_poisoned;	// util.scala:466:20
      uops_15_is_br <= io_enq_bits_uop_is_br;	// util.scala:466:20
      uops_15_is_jalr <= io_enq_bits_uop_is_jalr;	// util.scala:466:20
      uops_15_is_jal <= io_enq_bits_uop_is_jal;	// util.scala:466:20
      uops_15_is_sfb <= io_enq_bits_uop_is_sfb;	// util.scala:466:20
      uops_15_br_tag <= io_enq_bits_uop_br_tag;	// util.scala:466:20
      uops_15_ftq_idx <= io_enq_bits_uop_ftq_idx;	// util.scala:466:20
      uops_15_edge_inst <= io_enq_bits_uop_edge_inst;	// util.scala:466:20
      uops_15_pc_lob <= io_enq_bits_uop_pc_lob;	// util.scala:466:20
      uops_15_taken <= io_enq_bits_uop_taken;	// util.scala:466:20
      uops_15_imm_packed <= io_enq_bits_uop_imm_packed;	// util.scala:466:20
      uops_15_csr_addr <= io_enq_bits_uop_csr_addr;	// util.scala:466:20
      uops_15_rob_idx <= io_enq_bits_uop_rob_idx;	// util.scala:466:20
      uops_15_ldq_idx <= io_enq_bits_uop_ldq_idx;	// util.scala:466:20
      uops_15_stq_idx <= io_enq_bits_uop_stq_idx;	// util.scala:466:20
      uops_15_rxq_idx <= io_enq_bits_uop_rxq_idx;	// util.scala:466:20
      uops_15_pdst <= io_enq_bits_uop_pdst;	// util.scala:466:20
      uops_15_prs1 <= io_enq_bits_uop_prs1;	// util.scala:466:20
      uops_15_prs2 <= io_enq_bits_uop_prs2;	// util.scala:466:20
      uops_15_prs3 <= io_enq_bits_uop_prs3;	// util.scala:466:20
      uops_15_ppred <= io_enq_bits_uop_ppred;	// util.scala:466:20
      uops_15_prs1_busy <= io_enq_bits_uop_prs1_busy;	// util.scala:466:20
      uops_15_prs2_busy <= io_enq_bits_uop_prs2_busy;	// util.scala:466:20
      uops_15_prs3_busy <= io_enq_bits_uop_prs3_busy;	// util.scala:466:20
      uops_15_ppred_busy <= io_enq_bits_uop_ppred_busy;	// util.scala:466:20
      uops_15_stale_pdst <= io_enq_bits_uop_stale_pdst;	// util.scala:466:20
      uops_15_exception <= io_enq_bits_uop_exception;	// util.scala:466:20
      uops_15_exc_cause <= io_enq_bits_uop_exc_cause;	// util.scala:466:20
      uops_15_bypassable <= io_enq_bits_uop_bypassable;	// util.scala:466:20
      uops_15_mem_cmd <= io_enq_bits_uop_mem_cmd;	// util.scala:466:20
      uops_15_mem_size <= io_enq_bits_uop_mem_size;	// util.scala:466:20
      uops_15_mem_signed <= io_enq_bits_uop_mem_signed;	// util.scala:466:20
      uops_15_is_fence <= io_enq_bits_uop_is_fence;	// util.scala:466:20
      uops_15_is_fencei <= io_enq_bits_uop_is_fencei;	// util.scala:466:20
      uops_15_is_amo <= io_enq_bits_uop_is_amo;	// util.scala:466:20
      uops_15_uses_ldq <= io_enq_bits_uop_uses_ldq;	// util.scala:466:20
      uops_15_uses_stq <= io_enq_bits_uop_uses_stq;	// util.scala:466:20
      uops_15_is_sys_pc2epc <= io_enq_bits_uop_is_sys_pc2epc;	// util.scala:466:20
      uops_15_is_unique <= io_enq_bits_uop_is_unique;	// util.scala:466:20
      uops_15_flush_on_commit <= io_enq_bits_uop_flush_on_commit;	// util.scala:466:20
      uops_15_ldst_is_rs1 <= io_enq_bits_uop_ldst_is_rs1;	// util.scala:466:20
      uops_15_ldst <= io_enq_bits_uop_ldst;	// util.scala:466:20
      uops_15_lrs1 <= io_enq_bits_uop_lrs1;	// util.scala:466:20
      uops_15_lrs2 <= io_enq_bits_uop_lrs2;	// util.scala:466:20
      uops_15_lrs3 <= io_enq_bits_uop_lrs3;	// util.scala:466:20
      uops_15_ldst_val <= io_enq_bits_uop_ldst_val;	// util.scala:466:20
      uops_15_dst_rtype <= io_enq_bits_uop_dst_rtype;	// util.scala:466:20
      uops_15_lrs1_rtype <= io_enq_bits_uop_lrs1_rtype;	// util.scala:466:20
      uops_15_lrs2_rtype <= io_enq_bits_uop_lrs2_rtype;	// util.scala:466:20
      uops_15_frs3_en <= io_enq_bits_uop_frs3_en;	// util.scala:466:20
      uops_15_fp_val <= io_enq_bits_uop_fp_val;	// util.scala:466:20
      uops_15_fp_single <= io_enq_bits_uop_fp_single;	// util.scala:466:20
      uops_15_xcpt_pf_if <= io_enq_bits_uop_xcpt_pf_if;	// util.scala:466:20
      uops_15_xcpt_ae_if <= io_enq_bits_uop_xcpt_ae_if;	// util.scala:466:20
      uops_15_xcpt_ma_if <= io_enq_bits_uop_xcpt_ma_if;	// util.scala:466:20
      uops_15_bp_debug_if <= io_enq_bits_uop_bp_debug_if;	// util.scala:466:20
      uops_15_bp_xcpt_if <= io_enq_bits_uop_bp_xcpt_if;	// util.scala:466:20
      uops_15_debug_fsrc <= io_enq_bits_uop_debug_fsrc;	// util.scala:466:20
      uops_15_debug_tsrc <= io_enq_bits_uop_debug_tsrc;	// util.scala:466:20
    end
    if (do_enq & (&value))	// Counter.scala:60:40, Decoupled.scala:40:37, util.scala:482:22, :487:17, :489:33, :491:33
      uops_15_br_mask <= _uops_br_mask_T_1;	// util.scala:85:25, :466:20
    else	// util.scala:482:22, :487:17, :491:33
      uops_15_br_mask <=
        ({20{~valids_15}} | ~io_brupdate_b1_resolve_mask) & uops_15_br_mask;	// util.scala:89:23, :465:24, :466:20, :482:22, :483:23
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:209];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [7:0] i = 8'h0; i < 8'hD2; i += 8'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        valids_0 = _RANDOM[8'h0][0];	// util.scala:465:24
        valids_1 = _RANDOM[8'h0][1];	// util.scala:465:24
        valids_2 = _RANDOM[8'h0][2];	// util.scala:465:24
        valids_3 = _RANDOM[8'h0][3];	// util.scala:465:24
        valids_4 = _RANDOM[8'h0][4];	// util.scala:465:24
        valids_5 = _RANDOM[8'h0][5];	// util.scala:465:24
        valids_6 = _RANDOM[8'h0][6];	// util.scala:465:24
        valids_7 = _RANDOM[8'h0][7];	// util.scala:465:24
        valids_8 = _RANDOM[8'h0][8];	// util.scala:465:24
        valids_9 = _RANDOM[8'h0][9];	// util.scala:465:24
        valids_10 = _RANDOM[8'h0][10];	// util.scala:465:24
        valids_11 = _RANDOM[8'h0][11];	// util.scala:465:24
        valids_12 = _RANDOM[8'h0][12];	// util.scala:465:24
        valids_13 = _RANDOM[8'h0][13];	// util.scala:465:24
        valids_14 = _RANDOM[8'h0][14];	// util.scala:465:24
        valids_15 = _RANDOM[8'h0][15];	// util.scala:465:24
        uops_0_uopc = _RANDOM[8'h0][22:16];	// util.scala:465:24, :466:20
        uops_0_inst = {_RANDOM[8'h0][31:23], _RANDOM[8'h1][22:0]};	// util.scala:465:24, :466:20
        uops_0_debug_inst = {_RANDOM[8'h1][31:23], _RANDOM[8'h2][22:0]};	// util.scala:466:20
        uops_0_is_rvc = _RANDOM[8'h2][23];	// util.scala:466:20
        uops_0_debug_pc = {_RANDOM[8'h2][31:24], _RANDOM[8'h3]};	// util.scala:466:20
        uops_0_iq_type = _RANDOM[8'h4][2:0];	// util.scala:466:20
        uops_0_fu_code = _RANDOM[8'h4][12:3];	// util.scala:466:20
        uops_0_ctrl_br_type = _RANDOM[8'h4][16:13];	// util.scala:466:20
        uops_0_ctrl_op1_sel = _RANDOM[8'h4][18:17];	// util.scala:466:20
        uops_0_ctrl_op2_sel = _RANDOM[8'h4][21:19];	// util.scala:466:20
        uops_0_ctrl_imm_sel = _RANDOM[8'h4][24:22];	// util.scala:466:20
        uops_0_ctrl_op_fcn = _RANDOM[8'h4][28:25];	// util.scala:466:20
        uops_0_ctrl_fcn_dw = _RANDOM[8'h4][29];	// util.scala:466:20
        uops_0_ctrl_csr_cmd = {_RANDOM[8'h4][31:30], _RANDOM[8'h5][0]};	// util.scala:466:20
        uops_0_ctrl_is_load = _RANDOM[8'h5][1];	// util.scala:466:20
        uops_0_ctrl_is_sta = _RANDOM[8'h5][2];	// util.scala:466:20
        uops_0_ctrl_is_std = _RANDOM[8'h5][3];	// util.scala:466:20
        uops_0_iw_state = _RANDOM[8'h5][5:4];	// util.scala:466:20
        uops_0_iw_p1_poisoned = _RANDOM[8'h5][6];	// util.scala:466:20
        uops_0_iw_p2_poisoned = _RANDOM[8'h5][7];	// util.scala:466:20
        uops_0_is_br = _RANDOM[8'h5][8];	// util.scala:466:20
        uops_0_is_jalr = _RANDOM[8'h5][9];	// util.scala:466:20
        uops_0_is_jal = _RANDOM[8'h5][10];	// util.scala:466:20
        uops_0_is_sfb = _RANDOM[8'h5][11];	// util.scala:466:20
        uops_0_br_mask = _RANDOM[8'h5][31:12];	// util.scala:466:20
        uops_0_br_tag = _RANDOM[8'h6][4:0];	// util.scala:466:20
        uops_0_ftq_idx = _RANDOM[8'h6][10:5];	// util.scala:466:20
        uops_0_edge_inst = _RANDOM[8'h6][11];	// util.scala:466:20
        uops_0_pc_lob = _RANDOM[8'h6][17:12];	// util.scala:466:20
        uops_0_taken = _RANDOM[8'h6][18];	// util.scala:466:20
        uops_0_imm_packed = {_RANDOM[8'h6][31:19], _RANDOM[8'h7][6:0]};	// util.scala:466:20
        uops_0_csr_addr = _RANDOM[8'h7][18:7];	// util.scala:466:20
        uops_0_rob_idx = _RANDOM[8'h7][25:19];	// util.scala:466:20
        uops_0_ldq_idx = _RANDOM[8'h7][30:26];	// util.scala:466:20
        uops_0_stq_idx = {_RANDOM[8'h7][31], _RANDOM[8'h8][3:0]};	// util.scala:466:20
        uops_0_rxq_idx = _RANDOM[8'h8][5:4];	// util.scala:466:20
        uops_0_pdst = _RANDOM[8'h8][12:6];	// util.scala:466:20
        uops_0_prs1 = _RANDOM[8'h8][19:13];	// util.scala:466:20
        uops_0_prs2 = _RANDOM[8'h8][26:20];	// util.scala:466:20
        uops_0_prs3 = {_RANDOM[8'h8][31:27], _RANDOM[8'h9][1:0]};	// util.scala:466:20
        uops_0_ppred = _RANDOM[8'h9][7:2];	// util.scala:466:20
        uops_0_prs1_busy = _RANDOM[8'h9][8];	// util.scala:466:20
        uops_0_prs2_busy = _RANDOM[8'h9][9];	// util.scala:466:20
        uops_0_prs3_busy = _RANDOM[8'h9][10];	// util.scala:466:20
        uops_0_ppred_busy = _RANDOM[8'h9][11];	// util.scala:466:20
        uops_0_stale_pdst = _RANDOM[8'h9][18:12];	// util.scala:466:20
        uops_0_exception = _RANDOM[8'h9][19];	// util.scala:466:20
        uops_0_exc_cause = {_RANDOM[8'h9][31:20], _RANDOM[8'hA], _RANDOM[8'hB][19:0]};	// util.scala:466:20
        uops_0_bypassable = _RANDOM[8'hB][20];	// util.scala:466:20
        uops_0_mem_cmd = _RANDOM[8'hB][25:21];	// util.scala:466:20
        uops_0_mem_size = _RANDOM[8'hB][27:26];	// util.scala:466:20
        uops_0_mem_signed = _RANDOM[8'hB][28];	// util.scala:466:20
        uops_0_is_fence = _RANDOM[8'hB][29];	// util.scala:466:20
        uops_0_is_fencei = _RANDOM[8'hB][30];	// util.scala:466:20
        uops_0_is_amo = _RANDOM[8'hB][31];	// util.scala:466:20
        uops_0_uses_ldq = _RANDOM[8'hC][0];	// util.scala:466:20
        uops_0_uses_stq = _RANDOM[8'hC][1];	// util.scala:466:20
        uops_0_is_sys_pc2epc = _RANDOM[8'hC][2];	// util.scala:466:20
        uops_0_is_unique = _RANDOM[8'hC][3];	// util.scala:466:20
        uops_0_flush_on_commit = _RANDOM[8'hC][4];	// util.scala:466:20
        uops_0_ldst_is_rs1 = _RANDOM[8'hC][5];	// util.scala:466:20
        uops_0_ldst = _RANDOM[8'hC][11:6];	// util.scala:466:20
        uops_0_lrs1 = _RANDOM[8'hC][17:12];	// util.scala:466:20
        uops_0_lrs2 = _RANDOM[8'hC][23:18];	// util.scala:466:20
        uops_0_lrs3 = _RANDOM[8'hC][29:24];	// util.scala:466:20
        uops_0_ldst_val = _RANDOM[8'hC][30];	// util.scala:466:20
        uops_0_dst_rtype = {_RANDOM[8'hC][31], _RANDOM[8'hD][0]};	// util.scala:466:20
        uops_0_lrs1_rtype = _RANDOM[8'hD][2:1];	// util.scala:466:20
        uops_0_lrs2_rtype = _RANDOM[8'hD][4:3];	// util.scala:466:20
        uops_0_frs3_en = _RANDOM[8'hD][5];	// util.scala:466:20
        uops_0_fp_val = _RANDOM[8'hD][6];	// util.scala:466:20
        uops_0_fp_single = _RANDOM[8'hD][7];	// util.scala:466:20
        uops_0_xcpt_pf_if = _RANDOM[8'hD][8];	// util.scala:466:20
        uops_0_xcpt_ae_if = _RANDOM[8'hD][9];	// util.scala:466:20
        uops_0_xcpt_ma_if = _RANDOM[8'hD][10];	// util.scala:466:20
        uops_0_bp_debug_if = _RANDOM[8'hD][11];	// util.scala:466:20
        uops_0_bp_xcpt_if = _RANDOM[8'hD][12];	// util.scala:466:20
        uops_0_debug_fsrc = _RANDOM[8'hD][14:13];	// util.scala:466:20
        uops_0_debug_tsrc = _RANDOM[8'hD][16:15];	// util.scala:466:20
        uops_1_uopc = _RANDOM[8'hD][23:17];	// util.scala:466:20
        uops_1_inst = {_RANDOM[8'hD][31:24], _RANDOM[8'hE][23:0]};	// util.scala:466:20
        uops_1_debug_inst = {_RANDOM[8'hE][31:24], _RANDOM[8'hF][23:0]};	// util.scala:466:20
        uops_1_is_rvc = _RANDOM[8'hF][24];	// util.scala:466:20
        uops_1_debug_pc = {_RANDOM[8'hF][31:25], _RANDOM[8'h10], _RANDOM[8'h11][0]};	// util.scala:466:20
        uops_1_iq_type = _RANDOM[8'h11][3:1];	// util.scala:466:20
        uops_1_fu_code = _RANDOM[8'h11][13:4];	// util.scala:466:20
        uops_1_ctrl_br_type = _RANDOM[8'h11][17:14];	// util.scala:466:20
        uops_1_ctrl_op1_sel = _RANDOM[8'h11][19:18];	// util.scala:466:20
        uops_1_ctrl_op2_sel = _RANDOM[8'h11][22:20];	// util.scala:466:20
        uops_1_ctrl_imm_sel = _RANDOM[8'h11][25:23];	// util.scala:466:20
        uops_1_ctrl_op_fcn = _RANDOM[8'h11][29:26];	// util.scala:466:20
        uops_1_ctrl_fcn_dw = _RANDOM[8'h11][30];	// util.scala:466:20
        uops_1_ctrl_csr_cmd = {_RANDOM[8'h11][31], _RANDOM[8'h12][1:0]};	// util.scala:466:20
        uops_1_ctrl_is_load = _RANDOM[8'h12][2];	// util.scala:466:20
        uops_1_ctrl_is_sta = _RANDOM[8'h12][3];	// util.scala:466:20
        uops_1_ctrl_is_std = _RANDOM[8'h12][4];	// util.scala:466:20
        uops_1_iw_state = _RANDOM[8'h12][6:5];	// util.scala:466:20
        uops_1_iw_p1_poisoned = _RANDOM[8'h12][7];	// util.scala:466:20
        uops_1_iw_p2_poisoned = _RANDOM[8'h12][8];	// util.scala:466:20
        uops_1_is_br = _RANDOM[8'h12][9];	// util.scala:466:20
        uops_1_is_jalr = _RANDOM[8'h12][10];	// util.scala:466:20
        uops_1_is_jal = _RANDOM[8'h12][11];	// util.scala:466:20
        uops_1_is_sfb = _RANDOM[8'h12][12];	// util.scala:466:20
        uops_1_br_mask = {_RANDOM[8'h12][31:13], _RANDOM[8'h13][0]};	// util.scala:466:20
        uops_1_br_tag = _RANDOM[8'h13][5:1];	// util.scala:466:20
        uops_1_ftq_idx = _RANDOM[8'h13][11:6];	// util.scala:466:20
        uops_1_edge_inst = _RANDOM[8'h13][12];	// util.scala:466:20
        uops_1_pc_lob = _RANDOM[8'h13][18:13];	// util.scala:466:20
        uops_1_taken = _RANDOM[8'h13][19];	// util.scala:466:20
        uops_1_imm_packed = {_RANDOM[8'h13][31:20], _RANDOM[8'h14][7:0]};	// util.scala:466:20
        uops_1_csr_addr = _RANDOM[8'h14][19:8];	// util.scala:466:20
        uops_1_rob_idx = _RANDOM[8'h14][26:20];	// util.scala:466:20
        uops_1_ldq_idx = _RANDOM[8'h14][31:27];	// util.scala:466:20
        uops_1_stq_idx = _RANDOM[8'h15][4:0];	// util.scala:466:20
        uops_1_rxq_idx = _RANDOM[8'h15][6:5];	// util.scala:466:20
        uops_1_pdst = _RANDOM[8'h15][13:7];	// util.scala:466:20
        uops_1_prs1 = _RANDOM[8'h15][20:14];	// util.scala:466:20
        uops_1_prs2 = _RANDOM[8'h15][27:21];	// util.scala:466:20
        uops_1_prs3 = {_RANDOM[8'h15][31:28], _RANDOM[8'h16][2:0]};	// util.scala:466:20
        uops_1_ppred = _RANDOM[8'h16][8:3];	// util.scala:466:20
        uops_1_prs1_busy = _RANDOM[8'h16][9];	// util.scala:466:20
        uops_1_prs2_busy = _RANDOM[8'h16][10];	// util.scala:466:20
        uops_1_prs3_busy = _RANDOM[8'h16][11];	// util.scala:466:20
        uops_1_ppred_busy = _RANDOM[8'h16][12];	// util.scala:466:20
        uops_1_stale_pdst = _RANDOM[8'h16][19:13];	// util.scala:466:20
        uops_1_exception = _RANDOM[8'h16][20];	// util.scala:466:20
        uops_1_exc_cause = {_RANDOM[8'h16][31:21], _RANDOM[8'h17], _RANDOM[8'h18][20:0]};	// util.scala:466:20
        uops_1_bypassable = _RANDOM[8'h18][21];	// util.scala:466:20
        uops_1_mem_cmd = _RANDOM[8'h18][26:22];	// util.scala:466:20
        uops_1_mem_size = _RANDOM[8'h18][28:27];	// util.scala:466:20
        uops_1_mem_signed = _RANDOM[8'h18][29];	// util.scala:466:20
        uops_1_is_fence = _RANDOM[8'h18][30];	// util.scala:466:20
        uops_1_is_fencei = _RANDOM[8'h18][31];	// util.scala:466:20
        uops_1_is_amo = _RANDOM[8'h19][0];	// util.scala:466:20
        uops_1_uses_ldq = _RANDOM[8'h19][1];	// util.scala:466:20
        uops_1_uses_stq = _RANDOM[8'h19][2];	// util.scala:466:20
        uops_1_is_sys_pc2epc = _RANDOM[8'h19][3];	// util.scala:466:20
        uops_1_is_unique = _RANDOM[8'h19][4];	// util.scala:466:20
        uops_1_flush_on_commit = _RANDOM[8'h19][5];	// util.scala:466:20
        uops_1_ldst_is_rs1 = _RANDOM[8'h19][6];	// util.scala:466:20
        uops_1_ldst = _RANDOM[8'h19][12:7];	// util.scala:466:20
        uops_1_lrs1 = _RANDOM[8'h19][18:13];	// util.scala:466:20
        uops_1_lrs2 = _RANDOM[8'h19][24:19];	// util.scala:466:20
        uops_1_lrs3 = _RANDOM[8'h19][30:25];	// util.scala:466:20
        uops_1_ldst_val = _RANDOM[8'h19][31];	// util.scala:466:20
        uops_1_dst_rtype = _RANDOM[8'h1A][1:0];	// util.scala:466:20
        uops_1_lrs1_rtype = _RANDOM[8'h1A][3:2];	// util.scala:466:20
        uops_1_lrs2_rtype = _RANDOM[8'h1A][5:4];	// util.scala:466:20
        uops_1_frs3_en = _RANDOM[8'h1A][6];	// util.scala:466:20
        uops_1_fp_val = _RANDOM[8'h1A][7];	// util.scala:466:20
        uops_1_fp_single = _RANDOM[8'h1A][8];	// util.scala:466:20
        uops_1_xcpt_pf_if = _RANDOM[8'h1A][9];	// util.scala:466:20
        uops_1_xcpt_ae_if = _RANDOM[8'h1A][10];	// util.scala:466:20
        uops_1_xcpt_ma_if = _RANDOM[8'h1A][11];	// util.scala:466:20
        uops_1_bp_debug_if = _RANDOM[8'h1A][12];	// util.scala:466:20
        uops_1_bp_xcpt_if = _RANDOM[8'h1A][13];	// util.scala:466:20
        uops_1_debug_fsrc = _RANDOM[8'h1A][15:14];	// util.scala:466:20
        uops_1_debug_tsrc = _RANDOM[8'h1A][17:16];	// util.scala:466:20
        uops_2_uopc = _RANDOM[8'h1A][24:18];	// util.scala:466:20
        uops_2_inst = {_RANDOM[8'h1A][31:25], _RANDOM[8'h1B][24:0]};	// util.scala:466:20
        uops_2_debug_inst = {_RANDOM[8'h1B][31:25], _RANDOM[8'h1C][24:0]};	// util.scala:466:20
        uops_2_is_rvc = _RANDOM[8'h1C][25];	// util.scala:466:20
        uops_2_debug_pc = {_RANDOM[8'h1C][31:26], _RANDOM[8'h1D], _RANDOM[8'h1E][1:0]};	// util.scala:466:20
        uops_2_iq_type = _RANDOM[8'h1E][4:2];	// util.scala:466:20
        uops_2_fu_code = _RANDOM[8'h1E][14:5];	// util.scala:466:20
        uops_2_ctrl_br_type = _RANDOM[8'h1E][18:15];	// util.scala:466:20
        uops_2_ctrl_op1_sel = _RANDOM[8'h1E][20:19];	// util.scala:466:20
        uops_2_ctrl_op2_sel = _RANDOM[8'h1E][23:21];	// util.scala:466:20
        uops_2_ctrl_imm_sel = _RANDOM[8'h1E][26:24];	// util.scala:466:20
        uops_2_ctrl_op_fcn = _RANDOM[8'h1E][30:27];	// util.scala:466:20
        uops_2_ctrl_fcn_dw = _RANDOM[8'h1E][31];	// util.scala:466:20
        uops_2_ctrl_csr_cmd = _RANDOM[8'h1F][2:0];	// util.scala:466:20
        uops_2_ctrl_is_load = _RANDOM[8'h1F][3];	// util.scala:466:20
        uops_2_ctrl_is_sta = _RANDOM[8'h1F][4];	// util.scala:466:20
        uops_2_ctrl_is_std = _RANDOM[8'h1F][5];	// util.scala:466:20
        uops_2_iw_state = _RANDOM[8'h1F][7:6];	// util.scala:466:20
        uops_2_iw_p1_poisoned = _RANDOM[8'h1F][8];	// util.scala:466:20
        uops_2_iw_p2_poisoned = _RANDOM[8'h1F][9];	// util.scala:466:20
        uops_2_is_br = _RANDOM[8'h1F][10];	// util.scala:466:20
        uops_2_is_jalr = _RANDOM[8'h1F][11];	// util.scala:466:20
        uops_2_is_jal = _RANDOM[8'h1F][12];	// util.scala:466:20
        uops_2_is_sfb = _RANDOM[8'h1F][13];	// util.scala:466:20
        uops_2_br_mask = {_RANDOM[8'h1F][31:14], _RANDOM[8'h20][1:0]};	// util.scala:466:20
        uops_2_br_tag = _RANDOM[8'h20][6:2];	// util.scala:466:20
        uops_2_ftq_idx = _RANDOM[8'h20][12:7];	// util.scala:466:20
        uops_2_edge_inst = _RANDOM[8'h20][13];	// util.scala:466:20
        uops_2_pc_lob = _RANDOM[8'h20][19:14];	// util.scala:466:20
        uops_2_taken = _RANDOM[8'h20][20];	// util.scala:466:20
        uops_2_imm_packed = {_RANDOM[8'h20][31:21], _RANDOM[8'h21][8:0]};	// util.scala:466:20
        uops_2_csr_addr = _RANDOM[8'h21][20:9];	// util.scala:466:20
        uops_2_rob_idx = _RANDOM[8'h21][27:21];	// util.scala:466:20
        uops_2_ldq_idx = {_RANDOM[8'h21][31:28], _RANDOM[8'h22][0]};	// util.scala:466:20
        uops_2_stq_idx = _RANDOM[8'h22][5:1];	// util.scala:466:20
        uops_2_rxq_idx = _RANDOM[8'h22][7:6];	// util.scala:466:20
        uops_2_pdst = _RANDOM[8'h22][14:8];	// util.scala:466:20
        uops_2_prs1 = _RANDOM[8'h22][21:15];	// util.scala:466:20
        uops_2_prs2 = _RANDOM[8'h22][28:22];	// util.scala:466:20
        uops_2_prs3 = {_RANDOM[8'h22][31:29], _RANDOM[8'h23][3:0]};	// util.scala:466:20
        uops_2_ppred = _RANDOM[8'h23][9:4];	// util.scala:466:20
        uops_2_prs1_busy = _RANDOM[8'h23][10];	// util.scala:466:20
        uops_2_prs2_busy = _RANDOM[8'h23][11];	// util.scala:466:20
        uops_2_prs3_busy = _RANDOM[8'h23][12];	// util.scala:466:20
        uops_2_ppred_busy = _RANDOM[8'h23][13];	// util.scala:466:20
        uops_2_stale_pdst = _RANDOM[8'h23][20:14];	// util.scala:466:20
        uops_2_exception = _RANDOM[8'h23][21];	// util.scala:466:20
        uops_2_exc_cause = {_RANDOM[8'h23][31:22], _RANDOM[8'h24], _RANDOM[8'h25][21:0]};	// util.scala:466:20
        uops_2_bypassable = _RANDOM[8'h25][22];	// util.scala:466:20
        uops_2_mem_cmd = _RANDOM[8'h25][27:23];	// util.scala:466:20
        uops_2_mem_size = _RANDOM[8'h25][29:28];	// util.scala:466:20
        uops_2_mem_signed = _RANDOM[8'h25][30];	// util.scala:466:20
        uops_2_is_fence = _RANDOM[8'h25][31];	// util.scala:466:20
        uops_2_is_fencei = _RANDOM[8'h26][0];	// util.scala:466:20
        uops_2_is_amo = _RANDOM[8'h26][1];	// util.scala:466:20
        uops_2_uses_ldq = _RANDOM[8'h26][2];	// util.scala:466:20
        uops_2_uses_stq = _RANDOM[8'h26][3];	// util.scala:466:20
        uops_2_is_sys_pc2epc = _RANDOM[8'h26][4];	// util.scala:466:20
        uops_2_is_unique = _RANDOM[8'h26][5];	// util.scala:466:20
        uops_2_flush_on_commit = _RANDOM[8'h26][6];	// util.scala:466:20
        uops_2_ldst_is_rs1 = _RANDOM[8'h26][7];	// util.scala:466:20
        uops_2_ldst = _RANDOM[8'h26][13:8];	// util.scala:466:20
        uops_2_lrs1 = _RANDOM[8'h26][19:14];	// util.scala:466:20
        uops_2_lrs2 = _RANDOM[8'h26][25:20];	// util.scala:466:20
        uops_2_lrs3 = _RANDOM[8'h26][31:26];	// util.scala:466:20
        uops_2_ldst_val = _RANDOM[8'h27][0];	// util.scala:466:20
        uops_2_dst_rtype = _RANDOM[8'h27][2:1];	// util.scala:466:20
        uops_2_lrs1_rtype = _RANDOM[8'h27][4:3];	// util.scala:466:20
        uops_2_lrs2_rtype = _RANDOM[8'h27][6:5];	// util.scala:466:20
        uops_2_frs3_en = _RANDOM[8'h27][7];	// util.scala:466:20
        uops_2_fp_val = _RANDOM[8'h27][8];	// util.scala:466:20
        uops_2_fp_single = _RANDOM[8'h27][9];	// util.scala:466:20
        uops_2_xcpt_pf_if = _RANDOM[8'h27][10];	// util.scala:466:20
        uops_2_xcpt_ae_if = _RANDOM[8'h27][11];	// util.scala:466:20
        uops_2_xcpt_ma_if = _RANDOM[8'h27][12];	// util.scala:466:20
        uops_2_bp_debug_if = _RANDOM[8'h27][13];	// util.scala:466:20
        uops_2_bp_xcpt_if = _RANDOM[8'h27][14];	// util.scala:466:20
        uops_2_debug_fsrc = _RANDOM[8'h27][16:15];	// util.scala:466:20
        uops_2_debug_tsrc = _RANDOM[8'h27][18:17];	// util.scala:466:20
        uops_3_uopc = _RANDOM[8'h27][25:19];	// util.scala:466:20
        uops_3_inst = {_RANDOM[8'h27][31:26], _RANDOM[8'h28][25:0]};	// util.scala:466:20
        uops_3_debug_inst = {_RANDOM[8'h28][31:26], _RANDOM[8'h29][25:0]};	// util.scala:466:20
        uops_3_is_rvc = _RANDOM[8'h29][26];	// util.scala:466:20
        uops_3_debug_pc = {_RANDOM[8'h29][31:27], _RANDOM[8'h2A], _RANDOM[8'h2B][2:0]};	// util.scala:466:20
        uops_3_iq_type = _RANDOM[8'h2B][5:3];	// util.scala:466:20
        uops_3_fu_code = _RANDOM[8'h2B][15:6];	// util.scala:466:20
        uops_3_ctrl_br_type = _RANDOM[8'h2B][19:16];	// util.scala:466:20
        uops_3_ctrl_op1_sel = _RANDOM[8'h2B][21:20];	// util.scala:466:20
        uops_3_ctrl_op2_sel = _RANDOM[8'h2B][24:22];	// util.scala:466:20
        uops_3_ctrl_imm_sel = _RANDOM[8'h2B][27:25];	// util.scala:466:20
        uops_3_ctrl_op_fcn = _RANDOM[8'h2B][31:28];	// util.scala:466:20
        uops_3_ctrl_fcn_dw = _RANDOM[8'h2C][0];	// util.scala:466:20
        uops_3_ctrl_csr_cmd = _RANDOM[8'h2C][3:1];	// util.scala:466:20
        uops_3_ctrl_is_load = _RANDOM[8'h2C][4];	// util.scala:466:20
        uops_3_ctrl_is_sta = _RANDOM[8'h2C][5];	// util.scala:466:20
        uops_3_ctrl_is_std = _RANDOM[8'h2C][6];	// util.scala:466:20
        uops_3_iw_state = _RANDOM[8'h2C][8:7];	// util.scala:466:20
        uops_3_iw_p1_poisoned = _RANDOM[8'h2C][9];	// util.scala:466:20
        uops_3_iw_p2_poisoned = _RANDOM[8'h2C][10];	// util.scala:466:20
        uops_3_is_br = _RANDOM[8'h2C][11];	// util.scala:466:20
        uops_3_is_jalr = _RANDOM[8'h2C][12];	// util.scala:466:20
        uops_3_is_jal = _RANDOM[8'h2C][13];	// util.scala:466:20
        uops_3_is_sfb = _RANDOM[8'h2C][14];	// util.scala:466:20
        uops_3_br_mask = {_RANDOM[8'h2C][31:15], _RANDOM[8'h2D][2:0]};	// util.scala:466:20
        uops_3_br_tag = _RANDOM[8'h2D][7:3];	// util.scala:466:20
        uops_3_ftq_idx = _RANDOM[8'h2D][13:8];	// util.scala:466:20
        uops_3_edge_inst = _RANDOM[8'h2D][14];	// util.scala:466:20
        uops_3_pc_lob = _RANDOM[8'h2D][20:15];	// util.scala:466:20
        uops_3_taken = _RANDOM[8'h2D][21];	// util.scala:466:20
        uops_3_imm_packed = {_RANDOM[8'h2D][31:22], _RANDOM[8'h2E][9:0]};	// util.scala:466:20
        uops_3_csr_addr = _RANDOM[8'h2E][21:10];	// util.scala:466:20
        uops_3_rob_idx = _RANDOM[8'h2E][28:22];	// util.scala:466:20
        uops_3_ldq_idx = {_RANDOM[8'h2E][31:29], _RANDOM[8'h2F][1:0]};	// util.scala:466:20
        uops_3_stq_idx = _RANDOM[8'h2F][6:2];	// util.scala:466:20
        uops_3_rxq_idx = _RANDOM[8'h2F][8:7];	// util.scala:466:20
        uops_3_pdst = _RANDOM[8'h2F][15:9];	// util.scala:466:20
        uops_3_prs1 = _RANDOM[8'h2F][22:16];	// util.scala:466:20
        uops_3_prs2 = _RANDOM[8'h2F][29:23];	// util.scala:466:20
        uops_3_prs3 = {_RANDOM[8'h2F][31:30], _RANDOM[8'h30][4:0]};	// util.scala:466:20
        uops_3_ppred = _RANDOM[8'h30][10:5];	// util.scala:466:20
        uops_3_prs1_busy = _RANDOM[8'h30][11];	// util.scala:466:20
        uops_3_prs2_busy = _RANDOM[8'h30][12];	// util.scala:466:20
        uops_3_prs3_busy = _RANDOM[8'h30][13];	// util.scala:466:20
        uops_3_ppred_busy = _RANDOM[8'h30][14];	// util.scala:466:20
        uops_3_stale_pdst = _RANDOM[8'h30][21:15];	// util.scala:466:20
        uops_3_exception = _RANDOM[8'h30][22];	// util.scala:466:20
        uops_3_exc_cause = {_RANDOM[8'h30][31:23], _RANDOM[8'h31], _RANDOM[8'h32][22:0]};	// util.scala:466:20
        uops_3_bypassable = _RANDOM[8'h32][23];	// util.scala:466:20
        uops_3_mem_cmd = _RANDOM[8'h32][28:24];	// util.scala:466:20
        uops_3_mem_size = _RANDOM[8'h32][30:29];	// util.scala:466:20
        uops_3_mem_signed = _RANDOM[8'h32][31];	// util.scala:466:20
        uops_3_is_fence = _RANDOM[8'h33][0];	// util.scala:466:20
        uops_3_is_fencei = _RANDOM[8'h33][1];	// util.scala:466:20
        uops_3_is_amo = _RANDOM[8'h33][2];	// util.scala:466:20
        uops_3_uses_ldq = _RANDOM[8'h33][3];	// util.scala:466:20
        uops_3_uses_stq = _RANDOM[8'h33][4];	// util.scala:466:20
        uops_3_is_sys_pc2epc = _RANDOM[8'h33][5];	// util.scala:466:20
        uops_3_is_unique = _RANDOM[8'h33][6];	// util.scala:466:20
        uops_3_flush_on_commit = _RANDOM[8'h33][7];	// util.scala:466:20
        uops_3_ldst_is_rs1 = _RANDOM[8'h33][8];	// util.scala:466:20
        uops_3_ldst = _RANDOM[8'h33][14:9];	// util.scala:466:20
        uops_3_lrs1 = _RANDOM[8'h33][20:15];	// util.scala:466:20
        uops_3_lrs2 = _RANDOM[8'h33][26:21];	// util.scala:466:20
        uops_3_lrs3 = {_RANDOM[8'h33][31:27], _RANDOM[8'h34][0]};	// util.scala:466:20
        uops_3_ldst_val = _RANDOM[8'h34][1];	// util.scala:466:20
        uops_3_dst_rtype = _RANDOM[8'h34][3:2];	// util.scala:466:20
        uops_3_lrs1_rtype = _RANDOM[8'h34][5:4];	// util.scala:466:20
        uops_3_lrs2_rtype = _RANDOM[8'h34][7:6];	// util.scala:466:20
        uops_3_frs3_en = _RANDOM[8'h34][8];	// util.scala:466:20
        uops_3_fp_val = _RANDOM[8'h34][9];	// util.scala:466:20
        uops_3_fp_single = _RANDOM[8'h34][10];	// util.scala:466:20
        uops_3_xcpt_pf_if = _RANDOM[8'h34][11];	// util.scala:466:20
        uops_3_xcpt_ae_if = _RANDOM[8'h34][12];	// util.scala:466:20
        uops_3_xcpt_ma_if = _RANDOM[8'h34][13];	// util.scala:466:20
        uops_3_bp_debug_if = _RANDOM[8'h34][14];	// util.scala:466:20
        uops_3_bp_xcpt_if = _RANDOM[8'h34][15];	// util.scala:466:20
        uops_3_debug_fsrc = _RANDOM[8'h34][17:16];	// util.scala:466:20
        uops_3_debug_tsrc = _RANDOM[8'h34][19:18];	// util.scala:466:20
        uops_4_uopc = _RANDOM[8'h34][26:20];	// util.scala:466:20
        uops_4_inst = {_RANDOM[8'h34][31:27], _RANDOM[8'h35][26:0]};	// util.scala:466:20
        uops_4_debug_inst = {_RANDOM[8'h35][31:27], _RANDOM[8'h36][26:0]};	// util.scala:466:20
        uops_4_is_rvc = _RANDOM[8'h36][27];	// util.scala:466:20
        uops_4_debug_pc = {_RANDOM[8'h36][31:28], _RANDOM[8'h37], _RANDOM[8'h38][3:0]};	// util.scala:466:20
        uops_4_iq_type = _RANDOM[8'h38][6:4];	// util.scala:466:20
        uops_4_fu_code = _RANDOM[8'h38][16:7];	// util.scala:466:20
        uops_4_ctrl_br_type = _RANDOM[8'h38][20:17];	// util.scala:466:20
        uops_4_ctrl_op1_sel = _RANDOM[8'h38][22:21];	// util.scala:466:20
        uops_4_ctrl_op2_sel = _RANDOM[8'h38][25:23];	// util.scala:466:20
        uops_4_ctrl_imm_sel = _RANDOM[8'h38][28:26];	// util.scala:466:20
        uops_4_ctrl_op_fcn = {_RANDOM[8'h38][31:29], _RANDOM[8'h39][0]};	// util.scala:466:20
        uops_4_ctrl_fcn_dw = _RANDOM[8'h39][1];	// util.scala:466:20
        uops_4_ctrl_csr_cmd = _RANDOM[8'h39][4:2];	// util.scala:466:20
        uops_4_ctrl_is_load = _RANDOM[8'h39][5];	// util.scala:466:20
        uops_4_ctrl_is_sta = _RANDOM[8'h39][6];	// util.scala:466:20
        uops_4_ctrl_is_std = _RANDOM[8'h39][7];	// util.scala:466:20
        uops_4_iw_state = _RANDOM[8'h39][9:8];	// util.scala:466:20
        uops_4_iw_p1_poisoned = _RANDOM[8'h39][10];	// util.scala:466:20
        uops_4_iw_p2_poisoned = _RANDOM[8'h39][11];	// util.scala:466:20
        uops_4_is_br = _RANDOM[8'h39][12];	// util.scala:466:20
        uops_4_is_jalr = _RANDOM[8'h39][13];	// util.scala:466:20
        uops_4_is_jal = _RANDOM[8'h39][14];	// util.scala:466:20
        uops_4_is_sfb = _RANDOM[8'h39][15];	// util.scala:466:20
        uops_4_br_mask = {_RANDOM[8'h39][31:16], _RANDOM[8'h3A][3:0]};	// util.scala:466:20
        uops_4_br_tag = _RANDOM[8'h3A][8:4];	// util.scala:466:20
        uops_4_ftq_idx = _RANDOM[8'h3A][14:9];	// util.scala:466:20
        uops_4_edge_inst = _RANDOM[8'h3A][15];	// util.scala:466:20
        uops_4_pc_lob = _RANDOM[8'h3A][21:16];	// util.scala:466:20
        uops_4_taken = _RANDOM[8'h3A][22];	// util.scala:466:20
        uops_4_imm_packed = {_RANDOM[8'h3A][31:23], _RANDOM[8'h3B][10:0]};	// util.scala:466:20
        uops_4_csr_addr = _RANDOM[8'h3B][22:11];	// util.scala:466:20
        uops_4_rob_idx = _RANDOM[8'h3B][29:23];	// util.scala:466:20
        uops_4_ldq_idx = {_RANDOM[8'h3B][31:30], _RANDOM[8'h3C][2:0]};	// util.scala:466:20
        uops_4_stq_idx = _RANDOM[8'h3C][7:3];	// util.scala:466:20
        uops_4_rxq_idx = _RANDOM[8'h3C][9:8];	// util.scala:466:20
        uops_4_pdst = _RANDOM[8'h3C][16:10];	// util.scala:466:20
        uops_4_prs1 = _RANDOM[8'h3C][23:17];	// util.scala:466:20
        uops_4_prs2 = _RANDOM[8'h3C][30:24];	// util.scala:466:20
        uops_4_prs3 = {_RANDOM[8'h3C][31], _RANDOM[8'h3D][5:0]};	// util.scala:466:20
        uops_4_ppred = _RANDOM[8'h3D][11:6];	// util.scala:466:20
        uops_4_prs1_busy = _RANDOM[8'h3D][12];	// util.scala:466:20
        uops_4_prs2_busy = _RANDOM[8'h3D][13];	// util.scala:466:20
        uops_4_prs3_busy = _RANDOM[8'h3D][14];	// util.scala:466:20
        uops_4_ppred_busy = _RANDOM[8'h3D][15];	// util.scala:466:20
        uops_4_stale_pdst = _RANDOM[8'h3D][22:16];	// util.scala:466:20
        uops_4_exception = _RANDOM[8'h3D][23];	// util.scala:466:20
        uops_4_exc_cause = {_RANDOM[8'h3D][31:24], _RANDOM[8'h3E], _RANDOM[8'h3F][23:0]};	// util.scala:466:20
        uops_4_bypassable = _RANDOM[8'h3F][24];	// util.scala:466:20
        uops_4_mem_cmd = _RANDOM[8'h3F][29:25];	// util.scala:466:20
        uops_4_mem_size = _RANDOM[8'h3F][31:30];	// util.scala:466:20
        uops_4_mem_signed = _RANDOM[8'h40][0];	// util.scala:466:20
        uops_4_is_fence = _RANDOM[8'h40][1];	// util.scala:466:20
        uops_4_is_fencei = _RANDOM[8'h40][2];	// util.scala:466:20
        uops_4_is_amo = _RANDOM[8'h40][3];	// util.scala:466:20
        uops_4_uses_ldq = _RANDOM[8'h40][4];	// util.scala:466:20
        uops_4_uses_stq = _RANDOM[8'h40][5];	// util.scala:466:20
        uops_4_is_sys_pc2epc = _RANDOM[8'h40][6];	// util.scala:466:20
        uops_4_is_unique = _RANDOM[8'h40][7];	// util.scala:466:20
        uops_4_flush_on_commit = _RANDOM[8'h40][8];	// util.scala:466:20
        uops_4_ldst_is_rs1 = _RANDOM[8'h40][9];	// util.scala:466:20
        uops_4_ldst = _RANDOM[8'h40][15:10];	// util.scala:466:20
        uops_4_lrs1 = _RANDOM[8'h40][21:16];	// util.scala:466:20
        uops_4_lrs2 = _RANDOM[8'h40][27:22];	// util.scala:466:20
        uops_4_lrs3 = {_RANDOM[8'h40][31:28], _RANDOM[8'h41][1:0]};	// util.scala:466:20
        uops_4_ldst_val = _RANDOM[8'h41][2];	// util.scala:466:20
        uops_4_dst_rtype = _RANDOM[8'h41][4:3];	// util.scala:466:20
        uops_4_lrs1_rtype = _RANDOM[8'h41][6:5];	// util.scala:466:20
        uops_4_lrs2_rtype = _RANDOM[8'h41][8:7];	// util.scala:466:20
        uops_4_frs3_en = _RANDOM[8'h41][9];	// util.scala:466:20
        uops_4_fp_val = _RANDOM[8'h41][10];	// util.scala:466:20
        uops_4_fp_single = _RANDOM[8'h41][11];	// util.scala:466:20
        uops_4_xcpt_pf_if = _RANDOM[8'h41][12];	// util.scala:466:20
        uops_4_xcpt_ae_if = _RANDOM[8'h41][13];	// util.scala:466:20
        uops_4_xcpt_ma_if = _RANDOM[8'h41][14];	// util.scala:466:20
        uops_4_bp_debug_if = _RANDOM[8'h41][15];	// util.scala:466:20
        uops_4_bp_xcpt_if = _RANDOM[8'h41][16];	// util.scala:466:20
        uops_4_debug_fsrc = _RANDOM[8'h41][18:17];	// util.scala:466:20
        uops_4_debug_tsrc = _RANDOM[8'h41][20:19];	// util.scala:466:20
        uops_5_uopc = _RANDOM[8'h41][27:21];	// util.scala:466:20
        uops_5_inst = {_RANDOM[8'h41][31:28], _RANDOM[8'h42][27:0]};	// util.scala:466:20
        uops_5_debug_inst = {_RANDOM[8'h42][31:28], _RANDOM[8'h43][27:0]};	// util.scala:466:20
        uops_5_is_rvc = _RANDOM[8'h43][28];	// util.scala:466:20
        uops_5_debug_pc = {_RANDOM[8'h43][31:29], _RANDOM[8'h44], _RANDOM[8'h45][4:0]};	// util.scala:466:20
        uops_5_iq_type = _RANDOM[8'h45][7:5];	// util.scala:466:20
        uops_5_fu_code = _RANDOM[8'h45][17:8];	// util.scala:466:20
        uops_5_ctrl_br_type = _RANDOM[8'h45][21:18];	// util.scala:466:20
        uops_5_ctrl_op1_sel = _RANDOM[8'h45][23:22];	// util.scala:466:20
        uops_5_ctrl_op2_sel = _RANDOM[8'h45][26:24];	// util.scala:466:20
        uops_5_ctrl_imm_sel = _RANDOM[8'h45][29:27];	// util.scala:466:20
        uops_5_ctrl_op_fcn = {_RANDOM[8'h45][31:30], _RANDOM[8'h46][1:0]};	// util.scala:466:20
        uops_5_ctrl_fcn_dw = _RANDOM[8'h46][2];	// util.scala:466:20
        uops_5_ctrl_csr_cmd = _RANDOM[8'h46][5:3];	// util.scala:466:20
        uops_5_ctrl_is_load = _RANDOM[8'h46][6];	// util.scala:466:20
        uops_5_ctrl_is_sta = _RANDOM[8'h46][7];	// util.scala:466:20
        uops_5_ctrl_is_std = _RANDOM[8'h46][8];	// util.scala:466:20
        uops_5_iw_state = _RANDOM[8'h46][10:9];	// util.scala:466:20
        uops_5_iw_p1_poisoned = _RANDOM[8'h46][11];	// util.scala:466:20
        uops_5_iw_p2_poisoned = _RANDOM[8'h46][12];	// util.scala:466:20
        uops_5_is_br = _RANDOM[8'h46][13];	// util.scala:466:20
        uops_5_is_jalr = _RANDOM[8'h46][14];	// util.scala:466:20
        uops_5_is_jal = _RANDOM[8'h46][15];	// util.scala:466:20
        uops_5_is_sfb = _RANDOM[8'h46][16];	// util.scala:466:20
        uops_5_br_mask = {_RANDOM[8'h46][31:17], _RANDOM[8'h47][4:0]};	// util.scala:466:20
        uops_5_br_tag = _RANDOM[8'h47][9:5];	// util.scala:466:20
        uops_5_ftq_idx = _RANDOM[8'h47][15:10];	// util.scala:466:20
        uops_5_edge_inst = _RANDOM[8'h47][16];	// util.scala:466:20
        uops_5_pc_lob = _RANDOM[8'h47][22:17];	// util.scala:466:20
        uops_5_taken = _RANDOM[8'h47][23];	// util.scala:466:20
        uops_5_imm_packed = {_RANDOM[8'h47][31:24], _RANDOM[8'h48][11:0]};	// util.scala:466:20
        uops_5_csr_addr = _RANDOM[8'h48][23:12];	// util.scala:466:20
        uops_5_rob_idx = _RANDOM[8'h48][30:24];	// util.scala:466:20
        uops_5_ldq_idx = {_RANDOM[8'h48][31], _RANDOM[8'h49][3:0]};	// util.scala:466:20
        uops_5_stq_idx = _RANDOM[8'h49][8:4];	// util.scala:466:20
        uops_5_rxq_idx = _RANDOM[8'h49][10:9];	// util.scala:466:20
        uops_5_pdst = _RANDOM[8'h49][17:11];	// util.scala:466:20
        uops_5_prs1 = _RANDOM[8'h49][24:18];	// util.scala:466:20
        uops_5_prs2 = _RANDOM[8'h49][31:25];	// util.scala:466:20
        uops_5_prs3 = _RANDOM[8'h4A][6:0];	// util.scala:466:20
        uops_5_ppred = _RANDOM[8'h4A][12:7];	// util.scala:466:20
        uops_5_prs1_busy = _RANDOM[8'h4A][13];	// util.scala:466:20
        uops_5_prs2_busy = _RANDOM[8'h4A][14];	// util.scala:466:20
        uops_5_prs3_busy = _RANDOM[8'h4A][15];	// util.scala:466:20
        uops_5_ppred_busy = _RANDOM[8'h4A][16];	// util.scala:466:20
        uops_5_stale_pdst = _RANDOM[8'h4A][23:17];	// util.scala:466:20
        uops_5_exception = _RANDOM[8'h4A][24];	// util.scala:466:20
        uops_5_exc_cause = {_RANDOM[8'h4A][31:25], _RANDOM[8'h4B], _RANDOM[8'h4C][24:0]};	// util.scala:466:20
        uops_5_bypassable = _RANDOM[8'h4C][25];	// util.scala:466:20
        uops_5_mem_cmd = _RANDOM[8'h4C][30:26];	// util.scala:466:20
        uops_5_mem_size = {_RANDOM[8'h4C][31], _RANDOM[8'h4D][0]};	// util.scala:466:20
        uops_5_mem_signed = _RANDOM[8'h4D][1];	// util.scala:466:20
        uops_5_is_fence = _RANDOM[8'h4D][2];	// util.scala:466:20
        uops_5_is_fencei = _RANDOM[8'h4D][3];	// util.scala:466:20
        uops_5_is_amo = _RANDOM[8'h4D][4];	// util.scala:466:20
        uops_5_uses_ldq = _RANDOM[8'h4D][5];	// util.scala:466:20
        uops_5_uses_stq = _RANDOM[8'h4D][6];	// util.scala:466:20
        uops_5_is_sys_pc2epc = _RANDOM[8'h4D][7];	// util.scala:466:20
        uops_5_is_unique = _RANDOM[8'h4D][8];	// util.scala:466:20
        uops_5_flush_on_commit = _RANDOM[8'h4D][9];	// util.scala:466:20
        uops_5_ldst_is_rs1 = _RANDOM[8'h4D][10];	// util.scala:466:20
        uops_5_ldst = _RANDOM[8'h4D][16:11];	// util.scala:466:20
        uops_5_lrs1 = _RANDOM[8'h4D][22:17];	// util.scala:466:20
        uops_5_lrs2 = _RANDOM[8'h4D][28:23];	// util.scala:466:20
        uops_5_lrs3 = {_RANDOM[8'h4D][31:29], _RANDOM[8'h4E][2:0]};	// util.scala:466:20
        uops_5_ldst_val = _RANDOM[8'h4E][3];	// util.scala:466:20
        uops_5_dst_rtype = _RANDOM[8'h4E][5:4];	// util.scala:466:20
        uops_5_lrs1_rtype = _RANDOM[8'h4E][7:6];	// util.scala:466:20
        uops_5_lrs2_rtype = _RANDOM[8'h4E][9:8];	// util.scala:466:20
        uops_5_frs3_en = _RANDOM[8'h4E][10];	// util.scala:466:20
        uops_5_fp_val = _RANDOM[8'h4E][11];	// util.scala:466:20
        uops_5_fp_single = _RANDOM[8'h4E][12];	// util.scala:466:20
        uops_5_xcpt_pf_if = _RANDOM[8'h4E][13];	// util.scala:466:20
        uops_5_xcpt_ae_if = _RANDOM[8'h4E][14];	// util.scala:466:20
        uops_5_xcpt_ma_if = _RANDOM[8'h4E][15];	// util.scala:466:20
        uops_5_bp_debug_if = _RANDOM[8'h4E][16];	// util.scala:466:20
        uops_5_bp_xcpt_if = _RANDOM[8'h4E][17];	// util.scala:466:20
        uops_5_debug_fsrc = _RANDOM[8'h4E][19:18];	// util.scala:466:20
        uops_5_debug_tsrc = _RANDOM[8'h4E][21:20];	// util.scala:466:20
        uops_6_uopc = _RANDOM[8'h4E][28:22];	// util.scala:466:20
        uops_6_inst = {_RANDOM[8'h4E][31:29], _RANDOM[8'h4F][28:0]};	// util.scala:466:20
        uops_6_debug_inst = {_RANDOM[8'h4F][31:29], _RANDOM[8'h50][28:0]};	// util.scala:466:20
        uops_6_is_rvc = _RANDOM[8'h50][29];	// util.scala:466:20
        uops_6_debug_pc = {_RANDOM[8'h50][31:30], _RANDOM[8'h51], _RANDOM[8'h52][5:0]};	// util.scala:466:20
        uops_6_iq_type = _RANDOM[8'h52][8:6];	// util.scala:466:20
        uops_6_fu_code = _RANDOM[8'h52][18:9];	// util.scala:466:20
        uops_6_ctrl_br_type = _RANDOM[8'h52][22:19];	// util.scala:466:20
        uops_6_ctrl_op1_sel = _RANDOM[8'h52][24:23];	// util.scala:466:20
        uops_6_ctrl_op2_sel = _RANDOM[8'h52][27:25];	// util.scala:466:20
        uops_6_ctrl_imm_sel = _RANDOM[8'h52][30:28];	// util.scala:466:20
        uops_6_ctrl_op_fcn = {_RANDOM[8'h52][31], _RANDOM[8'h53][2:0]};	// util.scala:466:20
        uops_6_ctrl_fcn_dw = _RANDOM[8'h53][3];	// util.scala:466:20
        uops_6_ctrl_csr_cmd = _RANDOM[8'h53][6:4];	// util.scala:466:20
        uops_6_ctrl_is_load = _RANDOM[8'h53][7];	// util.scala:466:20
        uops_6_ctrl_is_sta = _RANDOM[8'h53][8];	// util.scala:466:20
        uops_6_ctrl_is_std = _RANDOM[8'h53][9];	// util.scala:466:20
        uops_6_iw_state = _RANDOM[8'h53][11:10];	// util.scala:466:20
        uops_6_iw_p1_poisoned = _RANDOM[8'h53][12];	// util.scala:466:20
        uops_6_iw_p2_poisoned = _RANDOM[8'h53][13];	// util.scala:466:20
        uops_6_is_br = _RANDOM[8'h53][14];	// util.scala:466:20
        uops_6_is_jalr = _RANDOM[8'h53][15];	// util.scala:466:20
        uops_6_is_jal = _RANDOM[8'h53][16];	// util.scala:466:20
        uops_6_is_sfb = _RANDOM[8'h53][17];	// util.scala:466:20
        uops_6_br_mask = {_RANDOM[8'h53][31:18], _RANDOM[8'h54][5:0]};	// util.scala:466:20
        uops_6_br_tag = _RANDOM[8'h54][10:6];	// util.scala:466:20
        uops_6_ftq_idx = _RANDOM[8'h54][16:11];	// util.scala:466:20
        uops_6_edge_inst = _RANDOM[8'h54][17];	// util.scala:466:20
        uops_6_pc_lob = _RANDOM[8'h54][23:18];	// util.scala:466:20
        uops_6_taken = _RANDOM[8'h54][24];	// util.scala:466:20
        uops_6_imm_packed = {_RANDOM[8'h54][31:25], _RANDOM[8'h55][12:0]};	// util.scala:466:20
        uops_6_csr_addr = _RANDOM[8'h55][24:13];	// util.scala:466:20
        uops_6_rob_idx = _RANDOM[8'h55][31:25];	// util.scala:466:20
        uops_6_ldq_idx = _RANDOM[8'h56][4:0];	// util.scala:466:20
        uops_6_stq_idx = _RANDOM[8'h56][9:5];	// util.scala:466:20
        uops_6_rxq_idx = _RANDOM[8'h56][11:10];	// util.scala:466:20
        uops_6_pdst = _RANDOM[8'h56][18:12];	// util.scala:466:20
        uops_6_prs1 = _RANDOM[8'h56][25:19];	// util.scala:466:20
        uops_6_prs2 = {_RANDOM[8'h56][31:26], _RANDOM[8'h57][0]};	// util.scala:466:20
        uops_6_prs3 = _RANDOM[8'h57][7:1];	// util.scala:466:20
        uops_6_ppred = _RANDOM[8'h57][13:8];	// util.scala:466:20
        uops_6_prs1_busy = _RANDOM[8'h57][14];	// util.scala:466:20
        uops_6_prs2_busy = _RANDOM[8'h57][15];	// util.scala:466:20
        uops_6_prs3_busy = _RANDOM[8'h57][16];	// util.scala:466:20
        uops_6_ppred_busy = _RANDOM[8'h57][17];	// util.scala:466:20
        uops_6_stale_pdst = _RANDOM[8'h57][24:18];	// util.scala:466:20
        uops_6_exception = _RANDOM[8'h57][25];	// util.scala:466:20
        uops_6_exc_cause = {_RANDOM[8'h57][31:26], _RANDOM[8'h58], _RANDOM[8'h59][25:0]};	// util.scala:466:20
        uops_6_bypassable = _RANDOM[8'h59][26];	// util.scala:466:20
        uops_6_mem_cmd = _RANDOM[8'h59][31:27];	// util.scala:466:20
        uops_6_mem_size = _RANDOM[8'h5A][1:0];	// util.scala:466:20
        uops_6_mem_signed = _RANDOM[8'h5A][2];	// util.scala:466:20
        uops_6_is_fence = _RANDOM[8'h5A][3];	// util.scala:466:20
        uops_6_is_fencei = _RANDOM[8'h5A][4];	// util.scala:466:20
        uops_6_is_amo = _RANDOM[8'h5A][5];	// util.scala:466:20
        uops_6_uses_ldq = _RANDOM[8'h5A][6];	// util.scala:466:20
        uops_6_uses_stq = _RANDOM[8'h5A][7];	// util.scala:466:20
        uops_6_is_sys_pc2epc = _RANDOM[8'h5A][8];	// util.scala:466:20
        uops_6_is_unique = _RANDOM[8'h5A][9];	// util.scala:466:20
        uops_6_flush_on_commit = _RANDOM[8'h5A][10];	// util.scala:466:20
        uops_6_ldst_is_rs1 = _RANDOM[8'h5A][11];	// util.scala:466:20
        uops_6_ldst = _RANDOM[8'h5A][17:12];	// util.scala:466:20
        uops_6_lrs1 = _RANDOM[8'h5A][23:18];	// util.scala:466:20
        uops_6_lrs2 = _RANDOM[8'h5A][29:24];	// util.scala:466:20
        uops_6_lrs3 = {_RANDOM[8'h5A][31:30], _RANDOM[8'h5B][3:0]};	// util.scala:466:20
        uops_6_ldst_val = _RANDOM[8'h5B][4];	// util.scala:466:20
        uops_6_dst_rtype = _RANDOM[8'h5B][6:5];	// util.scala:466:20
        uops_6_lrs1_rtype = _RANDOM[8'h5B][8:7];	// util.scala:466:20
        uops_6_lrs2_rtype = _RANDOM[8'h5B][10:9];	// util.scala:466:20
        uops_6_frs3_en = _RANDOM[8'h5B][11];	// util.scala:466:20
        uops_6_fp_val = _RANDOM[8'h5B][12];	// util.scala:466:20
        uops_6_fp_single = _RANDOM[8'h5B][13];	// util.scala:466:20
        uops_6_xcpt_pf_if = _RANDOM[8'h5B][14];	// util.scala:466:20
        uops_6_xcpt_ae_if = _RANDOM[8'h5B][15];	// util.scala:466:20
        uops_6_xcpt_ma_if = _RANDOM[8'h5B][16];	// util.scala:466:20
        uops_6_bp_debug_if = _RANDOM[8'h5B][17];	// util.scala:466:20
        uops_6_bp_xcpt_if = _RANDOM[8'h5B][18];	// util.scala:466:20
        uops_6_debug_fsrc = _RANDOM[8'h5B][20:19];	// util.scala:466:20
        uops_6_debug_tsrc = _RANDOM[8'h5B][22:21];	// util.scala:466:20
        uops_7_uopc = _RANDOM[8'h5B][29:23];	// util.scala:466:20
        uops_7_inst = {_RANDOM[8'h5B][31:30], _RANDOM[8'h5C][29:0]};	// util.scala:466:20
        uops_7_debug_inst = {_RANDOM[8'h5C][31:30], _RANDOM[8'h5D][29:0]};	// util.scala:466:20
        uops_7_is_rvc = _RANDOM[8'h5D][30];	// util.scala:466:20
        uops_7_debug_pc = {_RANDOM[8'h5D][31], _RANDOM[8'h5E], _RANDOM[8'h5F][6:0]};	// util.scala:466:20
        uops_7_iq_type = _RANDOM[8'h5F][9:7];	// util.scala:466:20
        uops_7_fu_code = _RANDOM[8'h5F][19:10];	// util.scala:466:20
        uops_7_ctrl_br_type = _RANDOM[8'h5F][23:20];	// util.scala:466:20
        uops_7_ctrl_op1_sel = _RANDOM[8'h5F][25:24];	// util.scala:466:20
        uops_7_ctrl_op2_sel = _RANDOM[8'h5F][28:26];	// util.scala:466:20
        uops_7_ctrl_imm_sel = _RANDOM[8'h5F][31:29];	// util.scala:466:20
        uops_7_ctrl_op_fcn = _RANDOM[8'h60][3:0];	// util.scala:466:20
        uops_7_ctrl_fcn_dw = _RANDOM[8'h60][4];	// util.scala:466:20
        uops_7_ctrl_csr_cmd = _RANDOM[8'h60][7:5];	// util.scala:466:20
        uops_7_ctrl_is_load = _RANDOM[8'h60][8];	// util.scala:466:20
        uops_7_ctrl_is_sta = _RANDOM[8'h60][9];	// util.scala:466:20
        uops_7_ctrl_is_std = _RANDOM[8'h60][10];	// util.scala:466:20
        uops_7_iw_state = _RANDOM[8'h60][12:11];	// util.scala:466:20
        uops_7_iw_p1_poisoned = _RANDOM[8'h60][13];	// util.scala:466:20
        uops_7_iw_p2_poisoned = _RANDOM[8'h60][14];	// util.scala:466:20
        uops_7_is_br = _RANDOM[8'h60][15];	// util.scala:466:20
        uops_7_is_jalr = _RANDOM[8'h60][16];	// util.scala:466:20
        uops_7_is_jal = _RANDOM[8'h60][17];	// util.scala:466:20
        uops_7_is_sfb = _RANDOM[8'h60][18];	// util.scala:466:20
        uops_7_br_mask = {_RANDOM[8'h60][31:19], _RANDOM[8'h61][6:0]};	// util.scala:466:20
        uops_7_br_tag = _RANDOM[8'h61][11:7];	// util.scala:466:20
        uops_7_ftq_idx = _RANDOM[8'h61][17:12];	// util.scala:466:20
        uops_7_edge_inst = _RANDOM[8'h61][18];	// util.scala:466:20
        uops_7_pc_lob = _RANDOM[8'h61][24:19];	// util.scala:466:20
        uops_7_taken = _RANDOM[8'h61][25];	// util.scala:466:20
        uops_7_imm_packed = {_RANDOM[8'h61][31:26], _RANDOM[8'h62][13:0]};	// util.scala:466:20
        uops_7_csr_addr = _RANDOM[8'h62][25:14];	// util.scala:466:20
        uops_7_rob_idx = {_RANDOM[8'h62][31:26], _RANDOM[8'h63][0]};	// util.scala:466:20
        uops_7_ldq_idx = _RANDOM[8'h63][5:1];	// util.scala:466:20
        uops_7_stq_idx = _RANDOM[8'h63][10:6];	// util.scala:466:20
        uops_7_rxq_idx = _RANDOM[8'h63][12:11];	// util.scala:466:20
        uops_7_pdst = _RANDOM[8'h63][19:13];	// util.scala:466:20
        uops_7_prs1 = _RANDOM[8'h63][26:20];	// util.scala:466:20
        uops_7_prs2 = {_RANDOM[8'h63][31:27], _RANDOM[8'h64][1:0]};	// util.scala:466:20
        uops_7_prs3 = _RANDOM[8'h64][8:2];	// util.scala:466:20
        uops_7_ppred = _RANDOM[8'h64][14:9];	// util.scala:466:20
        uops_7_prs1_busy = _RANDOM[8'h64][15];	// util.scala:466:20
        uops_7_prs2_busy = _RANDOM[8'h64][16];	// util.scala:466:20
        uops_7_prs3_busy = _RANDOM[8'h64][17];	// util.scala:466:20
        uops_7_ppred_busy = _RANDOM[8'h64][18];	// util.scala:466:20
        uops_7_stale_pdst = _RANDOM[8'h64][25:19];	// util.scala:466:20
        uops_7_exception = _RANDOM[8'h64][26];	// util.scala:466:20
        uops_7_exc_cause = {_RANDOM[8'h64][31:27], _RANDOM[8'h65], _RANDOM[8'h66][26:0]};	// util.scala:466:20
        uops_7_bypassable = _RANDOM[8'h66][27];	// util.scala:466:20
        uops_7_mem_cmd = {_RANDOM[8'h66][31:28], _RANDOM[8'h67][0]};	// util.scala:466:20
        uops_7_mem_size = _RANDOM[8'h67][2:1];	// util.scala:466:20
        uops_7_mem_signed = _RANDOM[8'h67][3];	// util.scala:466:20
        uops_7_is_fence = _RANDOM[8'h67][4];	// util.scala:466:20
        uops_7_is_fencei = _RANDOM[8'h67][5];	// util.scala:466:20
        uops_7_is_amo = _RANDOM[8'h67][6];	// util.scala:466:20
        uops_7_uses_ldq = _RANDOM[8'h67][7];	// util.scala:466:20
        uops_7_uses_stq = _RANDOM[8'h67][8];	// util.scala:466:20
        uops_7_is_sys_pc2epc = _RANDOM[8'h67][9];	// util.scala:466:20
        uops_7_is_unique = _RANDOM[8'h67][10];	// util.scala:466:20
        uops_7_flush_on_commit = _RANDOM[8'h67][11];	// util.scala:466:20
        uops_7_ldst_is_rs1 = _RANDOM[8'h67][12];	// util.scala:466:20
        uops_7_ldst = _RANDOM[8'h67][18:13];	// util.scala:466:20
        uops_7_lrs1 = _RANDOM[8'h67][24:19];	// util.scala:466:20
        uops_7_lrs2 = _RANDOM[8'h67][30:25];	// util.scala:466:20
        uops_7_lrs3 = {_RANDOM[8'h67][31], _RANDOM[8'h68][4:0]};	// util.scala:466:20
        uops_7_ldst_val = _RANDOM[8'h68][5];	// util.scala:466:20
        uops_7_dst_rtype = _RANDOM[8'h68][7:6];	// util.scala:466:20
        uops_7_lrs1_rtype = _RANDOM[8'h68][9:8];	// util.scala:466:20
        uops_7_lrs2_rtype = _RANDOM[8'h68][11:10];	// util.scala:466:20
        uops_7_frs3_en = _RANDOM[8'h68][12];	// util.scala:466:20
        uops_7_fp_val = _RANDOM[8'h68][13];	// util.scala:466:20
        uops_7_fp_single = _RANDOM[8'h68][14];	// util.scala:466:20
        uops_7_xcpt_pf_if = _RANDOM[8'h68][15];	// util.scala:466:20
        uops_7_xcpt_ae_if = _RANDOM[8'h68][16];	// util.scala:466:20
        uops_7_xcpt_ma_if = _RANDOM[8'h68][17];	// util.scala:466:20
        uops_7_bp_debug_if = _RANDOM[8'h68][18];	// util.scala:466:20
        uops_7_bp_xcpt_if = _RANDOM[8'h68][19];	// util.scala:466:20
        uops_7_debug_fsrc = _RANDOM[8'h68][21:20];	// util.scala:466:20
        uops_7_debug_tsrc = _RANDOM[8'h68][23:22];	// util.scala:466:20
        uops_8_uopc = _RANDOM[8'h68][30:24];	// util.scala:466:20
        uops_8_inst = {_RANDOM[8'h68][31], _RANDOM[8'h69][30:0]};	// util.scala:466:20
        uops_8_debug_inst = {_RANDOM[8'h69][31], _RANDOM[8'h6A][30:0]};	// util.scala:466:20
        uops_8_is_rvc = _RANDOM[8'h6A][31];	// util.scala:466:20
        uops_8_debug_pc = {_RANDOM[8'h6B], _RANDOM[8'h6C][7:0]};	// util.scala:466:20
        uops_8_iq_type = _RANDOM[8'h6C][10:8];	// util.scala:466:20
        uops_8_fu_code = _RANDOM[8'h6C][20:11];	// util.scala:466:20
        uops_8_ctrl_br_type = _RANDOM[8'h6C][24:21];	// util.scala:466:20
        uops_8_ctrl_op1_sel = _RANDOM[8'h6C][26:25];	// util.scala:466:20
        uops_8_ctrl_op2_sel = _RANDOM[8'h6C][29:27];	// util.scala:466:20
        uops_8_ctrl_imm_sel = {_RANDOM[8'h6C][31:30], _RANDOM[8'h6D][0]};	// util.scala:466:20
        uops_8_ctrl_op_fcn = _RANDOM[8'h6D][4:1];	// util.scala:466:20
        uops_8_ctrl_fcn_dw = _RANDOM[8'h6D][5];	// util.scala:466:20
        uops_8_ctrl_csr_cmd = _RANDOM[8'h6D][8:6];	// util.scala:466:20
        uops_8_ctrl_is_load = _RANDOM[8'h6D][9];	// util.scala:466:20
        uops_8_ctrl_is_sta = _RANDOM[8'h6D][10];	// util.scala:466:20
        uops_8_ctrl_is_std = _RANDOM[8'h6D][11];	// util.scala:466:20
        uops_8_iw_state = _RANDOM[8'h6D][13:12];	// util.scala:466:20
        uops_8_iw_p1_poisoned = _RANDOM[8'h6D][14];	// util.scala:466:20
        uops_8_iw_p2_poisoned = _RANDOM[8'h6D][15];	// util.scala:466:20
        uops_8_is_br = _RANDOM[8'h6D][16];	// util.scala:466:20
        uops_8_is_jalr = _RANDOM[8'h6D][17];	// util.scala:466:20
        uops_8_is_jal = _RANDOM[8'h6D][18];	// util.scala:466:20
        uops_8_is_sfb = _RANDOM[8'h6D][19];	// util.scala:466:20
        uops_8_br_mask = {_RANDOM[8'h6D][31:20], _RANDOM[8'h6E][7:0]};	// util.scala:466:20
        uops_8_br_tag = _RANDOM[8'h6E][12:8];	// util.scala:466:20
        uops_8_ftq_idx = _RANDOM[8'h6E][18:13];	// util.scala:466:20
        uops_8_edge_inst = _RANDOM[8'h6E][19];	// util.scala:466:20
        uops_8_pc_lob = _RANDOM[8'h6E][25:20];	// util.scala:466:20
        uops_8_taken = _RANDOM[8'h6E][26];	// util.scala:466:20
        uops_8_imm_packed = {_RANDOM[8'h6E][31:27], _RANDOM[8'h6F][14:0]};	// util.scala:466:20
        uops_8_csr_addr = _RANDOM[8'h6F][26:15];	// util.scala:466:20
        uops_8_rob_idx = {_RANDOM[8'h6F][31:27], _RANDOM[8'h70][1:0]};	// util.scala:466:20
        uops_8_ldq_idx = _RANDOM[8'h70][6:2];	// util.scala:466:20
        uops_8_stq_idx = _RANDOM[8'h70][11:7];	// util.scala:466:20
        uops_8_rxq_idx = _RANDOM[8'h70][13:12];	// util.scala:466:20
        uops_8_pdst = _RANDOM[8'h70][20:14];	// util.scala:466:20
        uops_8_prs1 = _RANDOM[8'h70][27:21];	// util.scala:466:20
        uops_8_prs2 = {_RANDOM[8'h70][31:28], _RANDOM[8'h71][2:0]};	// util.scala:466:20
        uops_8_prs3 = _RANDOM[8'h71][9:3];	// util.scala:466:20
        uops_8_ppred = _RANDOM[8'h71][15:10];	// util.scala:466:20
        uops_8_prs1_busy = _RANDOM[8'h71][16];	// util.scala:466:20
        uops_8_prs2_busy = _RANDOM[8'h71][17];	// util.scala:466:20
        uops_8_prs3_busy = _RANDOM[8'h71][18];	// util.scala:466:20
        uops_8_ppred_busy = _RANDOM[8'h71][19];	// util.scala:466:20
        uops_8_stale_pdst = _RANDOM[8'h71][26:20];	// util.scala:466:20
        uops_8_exception = _RANDOM[8'h71][27];	// util.scala:466:20
        uops_8_exc_cause = {_RANDOM[8'h71][31:28], _RANDOM[8'h72], _RANDOM[8'h73][27:0]};	// util.scala:466:20
        uops_8_bypassable = _RANDOM[8'h73][28];	// util.scala:466:20
        uops_8_mem_cmd = {_RANDOM[8'h73][31:29], _RANDOM[8'h74][1:0]};	// util.scala:466:20
        uops_8_mem_size = _RANDOM[8'h74][3:2];	// util.scala:466:20
        uops_8_mem_signed = _RANDOM[8'h74][4];	// util.scala:466:20
        uops_8_is_fence = _RANDOM[8'h74][5];	// util.scala:466:20
        uops_8_is_fencei = _RANDOM[8'h74][6];	// util.scala:466:20
        uops_8_is_amo = _RANDOM[8'h74][7];	// util.scala:466:20
        uops_8_uses_ldq = _RANDOM[8'h74][8];	// util.scala:466:20
        uops_8_uses_stq = _RANDOM[8'h74][9];	// util.scala:466:20
        uops_8_is_sys_pc2epc = _RANDOM[8'h74][10];	// util.scala:466:20
        uops_8_is_unique = _RANDOM[8'h74][11];	// util.scala:466:20
        uops_8_flush_on_commit = _RANDOM[8'h74][12];	// util.scala:466:20
        uops_8_ldst_is_rs1 = _RANDOM[8'h74][13];	// util.scala:466:20
        uops_8_ldst = _RANDOM[8'h74][19:14];	// util.scala:466:20
        uops_8_lrs1 = _RANDOM[8'h74][25:20];	// util.scala:466:20
        uops_8_lrs2 = _RANDOM[8'h74][31:26];	// util.scala:466:20
        uops_8_lrs3 = _RANDOM[8'h75][5:0];	// util.scala:466:20
        uops_8_ldst_val = _RANDOM[8'h75][6];	// util.scala:466:20
        uops_8_dst_rtype = _RANDOM[8'h75][8:7];	// util.scala:466:20
        uops_8_lrs1_rtype = _RANDOM[8'h75][10:9];	// util.scala:466:20
        uops_8_lrs2_rtype = _RANDOM[8'h75][12:11];	// util.scala:466:20
        uops_8_frs3_en = _RANDOM[8'h75][13];	// util.scala:466:20
        uops_8_fp_val = _RANDOM[8'h75][14];	// util.scala:466:20
        uops_8_fp_single = _RANDOM[8'h75][15];	// util.scala:466:20
        uops_8_xcpt_pf_if = _RANDOM[8'h75][16];	// util.scala:466:20
        uops_8_xcpt_ae_if = _RANDOM[8'h75][17];	// util.scala:466:20
        uops_8_xcpt_ma_if = _RANDOM[8'h75][18];	// util.scala:466:20
        uops_8_bp_debug_if = _RANDOM[8'h75][19];	// util.scala:466:20
        uops_8_bp_xcpt_if = _RANDOM[8'h75][20];	// util.scala:466:20
        uops_8_debug_fsrc = _RANDOM[8'h75][22:21];	// util.scala:466:20
        uops_8_debug_tsrc = _RANDOM[8'h75][24:23];	// util.scala:466:20
        uops_9_uopc = _RANDOM[8'h75][31:25];	// util.scala:466:20
        uops_9_inst = _RANDOM[8'h76];	// util.scala:466:20
        uops_9_debug_inst = _RANDOM[8'h77];	// util.scala:466:20
        uops_9_is_rvc = _RANDOM[8'h78][0];	// util.scala:466:20
        uops_9_debug_pc = {_RANDOM[8'h78][31:1], _RANDOM[8'h79][8:0]};	// util.scala:466:20
        uops_9_iq_type = _RANDOM[8'h79][11:9];	// util.scala:466:20
        uops_9_fu_code = _RANDOM[8'h79][21:12];	// util.scala:466:20
        uops_9_ctrl_br_type = _RANDOM[8'h79][25:22];	// util.scala:466:20
        uops_9_ctrl_op1_sel = _RANDOM[8'h79][27:26];	// util.scala:466:20
        uops_9_ctrl_op2_sel = _RANDOM[8'h79][30:28];	// util.scala:466:20
        uops_9_ctrl_imm_sel = {_RANDOM[8'h79][31], _RANDOM[8'h7A][1:0]};	// util.scala:466:20
        uops_9_ctrl_op_fcn = _RANDOM[8'h7A][5:2];	// util.scala:466:20
        uops_9_ctrl_fcn_dw = _RANDOM[8'h7A][6];	// util.scala:466:20
        uops_9_ctrl_csr_cmd = _RANDOM[8'h7A][9:7];	// util.scala:466:20
        uops_9_ctrl_is_load = _RANDOM[8'h7A][10];	// util.scala:466:20
        uops_9_ctrl_is_sta = _RANDOM[8'h7A][11];	// util.scala:466:20
        uops_9_ctrl_is_std = _RANDOM[8'h7A][12];	// util.scala:466:20
        uops_9_iw_state = _RANDOM[8'h7A][14:13];	// util.scala:466:20
        uops_9_iw_p1_poisoned = _RANDOM[8'h7A][15];	// util.scala:466:20
        uops_9_iw_p2_poisoned = _RANDOM[8'h7A][16];	// util.scala:466:20
        uops_9_is_br = _RANDOM[8'h7A][17];	// util.scala:466:20
        uops_9_is_jalr = _RANDOM[8'h7A][18];	// util.scala:466:20
        uops_9_is_jal = _RANDOM[8'h7A][19];	// util.scala:466:20
        uops_9_is_sfb = _RANDOM[8'h7A][20];	// util.scala:466:20
        uops_9_br_mask = {_RANDOM[8'h7A][31:21], _RANDOM[8'h7B][8:0]};	// util.scala:466:20
        uops_9_br_tag = _RANDOM[8'h7B][13:9];	// util.scala:466:20
        uops_9_ftq_idx = _RANDOM[8'h7B][19:14];	// util.scala:466:20
        uops_9_edge_inst = _RANDOM[8'h7B][20];	// util.scala:466:20
        uops_9_pc_lob = _RANDOM[8'h7B][26:21];	// util.scala:466:20
        uops_9_taken = _RANDOM[8'h7B][27];	// util.scala:466:20
        uops_9_imm_packed = {_RANDOM[8'h7B][31:28], _RANDOM[8'h7C][15:0]};	// util.scala:466:20
        uops_9_csr_addr = _RANDOM[8'h7C][27:16];	// util.scala:466:20
        uops_9_rob_idx = {_RANDOM[8'h7C][31:28], _RANDOM[8'h7D][2:0]};	// util.scala:466:20
        uops_9_ldq_idx = _RANDOM[8'h7D][7:3];	// util.scala:466:20
        uops_9_stq_idx = _RANDOM[8'h7D][12:8];	// util.scala:466:20
        uops_9_rxq_idx = _RANDOM[8'h7D][14:13];	// util.scala:466:20
        uops_9_pdst = _RANDOM[8'h7D][21:15];	// util.scala:466:20
        uops_9_prs1 = _RANDOM[8'h7D][28:22];	// util.scala:466:20
        uops_9_prs2 = {_RANDOM[8'h7D][31:29], _RANDOM[8'h7E][3:0]};	// util.scala:466:20
        uops_9_prs3 = _RANDOM[8'h7E][10:4];	// util.scala:466:20
        uops_9_ppred = _RANDOM[8'h7E][16:11];	// util.scala:466:20
        uops_9_prs1_busy = _RANDOM[8'h7E][17];	// util.scala:466:20
        uops_9_prs2_busy = _RANDOM[8'h7E][18];	// util.scala:466:20
        uops_9_prs3_busy = _RANDOM[8'h7E][19];	// util.scala:466:20
        uops_9_ppred_busy = _RANDOM[8'h7E][20];	// util.scala:466:20
        uops_9_stale_pdst = _RANDOM[8'h7E][27:21];	// util.scala:466:20
        uops_9_exception = _RANDOM[8'h7E][28];	// util.scala:466:20
        uops_9_exc_cause = {_RANDOM[8'h7E][31:29], _RANDOM[8'h7F], _RANDOM[8'h80][28:0]};	// util.scala:466:20
        uops_9_bypassable = _RANDOM[8'h80][29];	// util.scala:466:20
        uops_9_mem_cmd = {_RANDOM[8'h80][31:30], _RANDOM[8'h81][2:0]};	// util.scala:466:20
        uops_9_mem_size = _RANDOM[8'h81][4:3];	// util.scala:466:20
        uops_9_mem_signed = _RANDOM[8'h81][5];	// util.scala:466:20
        uops_9_is_fence = _RANDOM[8'h81][6];	// util.scala:466:20
        uops_9_is_fencei = _RANDOM[8'h81][7];	// util.scala:466:20
        uops_9_is_amo = _RANDOM[8'h81][8];	// util.scala:466:20
        uops_9_uses_ldq = _RANDOM[8'h81][9];	// util.scala:466:20
        uops_9_uses_stq = _RANDOM[8'h81][10];	// util.scala:466:20
        uops_9_is_sys_pc2epc = _RANDOM[8'h81][11];	// util.scala:466:20
        uops_9_is_unique = _RANDOM[8'h81][12];	// util.scala:466:20
        uops_9_flush_on_commit = _RANDOM[8'h81][13];	// util.scala:466:20
        uops_9_ldst_is_rs1 = _RANDOM[8'h81][14];	// util.scala:466:20
        uops_9_ldst = _RANDOM[8'h81][20:15];	// util.scala:466:20
        uops_9_lrs1 = _RANDOM[8'h81][26:21];	// util.scala:466:20
        uops_9_lrs2 = {_RANDOM[8'h81][31:27], _RANDOM[8'h82][0]};	// util.scala:466:20
        uops_9_lrs3 = _RANDOM[8'h82][6:1];	// util.scala:466:20
        uops_9_ldst_val = _RANDOM[8'h82][7];	// util.scala:466:20
        uops_9_dst_rtype = _RANDOM[8'h82][9:8];	// util.scala:466:20
        uops_9_lrs1_rtype = _RANDOM[8'h82][11:10];	// util.scala:466:20
        uops_9_lrs2_rtype = _RANDOM[8'h82][13:12];	// util.scala:466:20
        uops_9_frs3_en = _RANDOM[8'h82][14];	// util.scala:466:20
        uops_9_fp_val = _RANDOM[8'h82][15];	// util.scala:466:20
        uops_9_fp_single = _RANDOM[8'h82][16];	// util.scala:466:20
        uops_9_xcpt_pf_if = _RANDOM[8'h82][17];	// util.scala:466:20
        uops_9_xcpt_ae_if = _RANDOM[8'h82][18];	// util.scala:466:20
        uops_9_xcpt_ma_if = _RANDOM[8'h82][19];	// util.scala:466:20
        uops_9_bp_debug_if = _RANDOM[8'h82][20];	// util.scala:466:20
        uops_9_bp_xcpt_if = _RANDOM[8'h82][21];	// util.scala:466:20
        uops_9_debug_fsrc = _RANDOM[8'h82][23:22];	// util.scala:466:20
        uops_9_debug_tsrc = _RANDOM[8'h82][25:24];	// util.scala:466:20
        uops_10_uopc = {_RANDOM[8'h82][31:26], _RANDOM[8'h83][0]};	// util.scala:466:20
        uops_10_inst = {_RANDOM[8'h83][31:1], _RANDOM[8'h84][0]};	// util.scala:466:20
        uops_10_debug_inst = {_RANDOM[8'h84][31:1], _RANDOM[8'h85][0]};	// util.scala:466:20
        uops_10_is_rvc = _RANDOM[8'h85][1];	// util.scala:466:20
        uops_10_debug_pc = {_RANDOM[8'h85][31:2], _RANDOM[8'h86][9:0]};	// util.scala:466:20
        uops_10_iq_type = _RANDOM[8'h86][12:10];	// util.scala:466:20
        uops_10_fu_code = _RANDOM[8'h86][22:13];	// util.scala:466:20
        uops_10_ctrl_br_type = _RANDOM[8'h86][26:23];	// util.scala:466:20
        uops_10_ctrl_op1_sel = _RANDOM[8'h86][28:27];	// util.scala:466:20
        uops_10_ctrl_op2_sel = _RANDOM[8'h86][31:29];	// util.scala:466:20
        uops_10_ctrl_imm_sel = _RANDOM[8'h87][2:0];	// util.scala:466:20
        uops_10_ctrl_op_fcn = _RANDOM[8'h87][6:3];	// util.scala:466:20
        uops_10_ctrl_fcn_dw = _RANDOM[8'h87][7];	// util.scala:466:20
        uops_10_ctrl_csr_cmd = _RANDOM[8'h87][10:8];	// util.scala:466:20
        uops_10_ctrl_is_load = _RANDOM[8'h87][11];	// util.scala:466:20
        uops_10_ctrl_is_sta = _RANDOM[8'h87][12];	// util.scala:466:20
        uops_10_ctrl_is_std = _RANDOM[8'h87][13];	// util.scala:466:20
        uops_10_iw_state = _RANDOM[8'h87][15:14];	// util.scala:466:20
        uops_10_iw_p1_poisoned = _RANDOM[8'h87][16];	// util.scala:466:20
        uops_10_iw_p2_poisoned = _RANDOM[8'h87][17];	// util.scala:466:20
        uops_10_is_br = _RANDOM[8'h87][18];	// util.scala:466:20
        uops_10_is_jalr = _RANDOM[8'h87][19];	// util.scala:466:20
        uops_10_is_jal = _RANDOM[8'h87][20];	// util.scala:466:20
        uops_10_is_sfb = _RANDOM[8'h87][21];	// util.scala:466:20
        uops_10_br_mask = {_RANDOM[8'h87][31:22], _RANDOM[8'h88][9:0]};	// util.scala:466:20
        uops_10_br_tag = _RANDOM[8'h88][14:10];	// util.scala:466:20
        uops_10_ftq_idx = _RANDOM[8'h88][20:15];	// util.scala:466:20
        uops_10_edge_inst = _RANDOM[8'h88][21];	// util.scala:466:20
        uops_10_pc_lob = _RANDOM[8'h88][27:22];	// util.scala:466:20
        uops_10_taken = _RANDOM[8'h88][28];	// util.scala:466:20
        uops_10_imm_packed = {_RANDOM[8'h88][31:29], _RANDOM[8'h89][16:0]};	// util.scala:466:20
        uops_10_csr_addr = _RANDOM[8'h89][28:17];	// util.scala:466:20
        uops_10_rob_idx = {_RANDOM[8'h89][31:29], _RANDOM[8'h8A][3:0]};	// util.scala:466:20
        uops_10_ldq_idx = _RANDOM[8'h8A][8:4];	// util.scala:466:20
        uops_10_stq_idx = _RANDOM[8'h8A][13:9];	// util.scala:466:20
        uops_10_rxq_idx = _RANDOM[8'h8A][15:14];	// util.scala:466:20
        uops_10_pdst = _RANDOM[8'h8A][22:16];	// util.scala:466:20
        uops_10_prs1 = _RANDOM[8'h8A][29:23];	// util.scala:466:20
        uops_10_prs2 = {_RANDOM[8'h8A][31:30], _RANDOM[8'h8B][4:0]};	// util.scala:466:20
        uops_10_prs3 = _RANDOM[8'h8B][11:5];	// util.scala:466:20
        uops_10_ppred = _RANDOM[8'h8B][17:12];	// util.scala:466:20
        uops_10_prs1_busy = _RANDOM[8'h8B][18];	// util.scala:466:20
        uops_10_prs2_busy = _RANDOM[8'h8B][19];	// util.scala:466:20
        uops_10_prs3_busy = _RANDOM[8'h8B][20];	// util.scala:466:20
        uops_10_ppred_busy = _RANDOM[8'h8B][21];	// util.scala:466:20
        uops_10_stale_pdst = _RANDOM[8'h8B][28:22];	// util.scala:466:20
        uops_10_exception = _RANDOM[8'h8B][29];	// util.scala:466:20
        uops_10_exc_cause = {_RANDOM[8'h8B][31:30], _RANDOM[8'h8C], _RANDOM[8'h8D][29:0]};	// util.scala:466:20
        uops_10_bypassable = _RANDOM[8'h8D][30];	// util.scala:466:20
        uops_10_mem_cmd = {_RANDOM[8'h8D][31], _RANDOM[8'h8E][3:0]};	// util.scala:466:20
        uops_10_mem_size = _RANDOM[8'h8E][5:4];	// util.scala:466:20
        uops_10_mem_signed = _RANDOM[8'h8E][6];	// util.scala:466:20
        uops_10_is_fence = _RANDOM[8'h8E][7];	// util.scala:466:20
        uops_10_is_fencei = _RANDOM[8'h8E][8];	// util.scala:466:20
        uops_10_is_amo = _RANDOM[8'h8E][9];	// util.scala:466:20
        uops_10_uses_ldq = _RANDOM[8'h8E][10];	// util.scala:466:20
        uops_10_uses_stq = _RANDOM[8'h8E][11];	// util.scala:466:20
        uops_10_is_sys_pc2epc = _RANDOM[8'h8E][12];	// util.scala:466:20
        uops_10_is_unique = _RANDOM[8'h8E][13];	// util.scala:466:20
        uops_10_flush_on_commit = _RANDOM[8'h8E][14];	// util.scala:466:20
        uops_10_ldst_is_rs1 = _RANDOM[8'h8E][15];	// util.scala:466:20
        uops_10_ldst = _RANDOM[8'h8E][21:16];	// util.scala:466:20
        uops_10_lrs1 = _RANDOM[8'h8E][27:22];	// util.scala:466:20
        uops_10_lrs2 = {_RANDOM[8'h8E][31:28], _RANDOM[8'h8F][1:0]};	// util.scala:466:20
        uops_10_lrs3 = _RANDOM[8'h8F][7:2];	// util.scala:466:20
        uops_10_ldst_val = _RANDOM[8'h8F][8];	// util.scala:466:20
        uops_10_dst_rtype = _RANDOM[8'h8F][10:9];	// util.scala:466:20
        uops_10_lrs1_rtype = _RANDOM[8'h8F][12:11];	// util.scala:466:20
        uops_10_lrs2_rtype = _RANDOM[8'h8F][14:13];	// util.scala:466:20
        uops_10_frs3_en = _RANDOM[8'h8F][15];	// util.scala:466:20
        uops_10_fp_val = _RANDOM[8'h8F][16];	// util.scala:466:20
        uops_10_fp_single = _RANDOM[8'h8F][17];	// util.scala:466:20
        uops_10_xcpt_pf_if = _RANDOM[8'h8F][18];	// util.scala:466:20
        uops_10_xcpt_ae_if = _RANDOM[8'h8F][19];	// util.scala:466:20
        uops_10_xcpt_ma_if = _RANDOM[8'h8F][20];	// util.scala:466:20
        uops_10_bp_debug_if = _RANDOM[8'h8F][21];	// util.scala:466:20
        uops_10_bp_xcpt_if = _RANDOM[8'h8F][22];	// util.scala:466:20
        uops_10_debug_fsrc = _RANDOM[8'h8F][24:23];	// util.scala:466:20
        uops_10_debug_tsrc = _RANDOM[8'h8F][26:25];	// util.scala:466:20
        uops_11_uopc = {_RANDOM[8'h8F][31:27], _RANDOM[8'h90][1:0]};	// util.scala:466:20
        uops_11_inst = {_RANDOM[8'h90][31:2], _RANDOM[8'h91][1:0]};	// util.scala:466:20
        uops_11_debug_inst = {_RANDOM[8'h91][31:2], _RANDOM[8'h92][1:0]};	// util.scala:466:20
        uops_11_is_rvc = _RANDOM[8'h92][2];	// util.scala:466:20
        uops_11_debug_pc = {_RANDOM[8'h92][31:3], _RANDOM[8'h93][10:0]};	// util.scala:466:20
        uops_11_iq_type = _RANDOM[8'h93][13:11];	// util.scala:466:20
        uops_11_fu_code = _RANDOM[8'h93][23:14];	// util.scala:466:20
        uops_11_ctrl_br_type = _RANDOM[8'h93][27:24];	// util.scala:466:20
        uops_11_ctrl_op1_sel = _RANDOM[8'h93][29:28];	// util.scala:466:20
        uops_11_ctrl_op2_sel = {_RANDOM[8'h93][31:30], _RANDOM[8'h94][0]};	// util.scala:466:20
        uops_11_ctrl_imm_sel = _RANDOM[8'h94][3:1];	// util.scala:466:20
        uops_11_ctrl_op_fcn = _RANDOM[8'h94][7:4];	// util.scala:466:20
        uops_11_ctrl_fcn_dw = _RANDOM[8'h94][8];	// util.scala:466:20
        uops_11_ctrl_csr_cmd = _RANDOM[8'h94][11:9];	// util.scala:466:20
        uops_11_ctrl_is_load = _RANDOM[8'h94][12];	// util.scala:466:20
        uops_11_ctrl_is_sta = _RANDOM[8'h94][13];	// util.scala:466:20
        uops_11_ctrl_is_std = _RANDOM[8'h94][14];	// util.scala:466:20
        uops_11_iw_state = _RANDOM[8'h94][16:15];	// util.scala:466:20
        uops_11_iw_p1_poisoned = _RANDOM[8'h94][17];	// util.scala:466:20
        uops_11_iw_p2_poisoned = _RANDOM[8'h94][18];	// util.scala:466:20
        uops_11_is_br = _RANDOM[8'h94][19];	// util.scala:466:20
        uops_11_is_jalr = _RANDOM[8'h94][20];	// util.scala:466:20
        uops_11_is_jal = _RANDOM[8'h94][21];	// util.scala:466:20
        uops_11_is_sfb = _RANDOM[8'h94][22];	// util.scala:466:20
        uops_11_br_mask = {_RANDOM[8'h94][31:23], _RANDOM[8'h95][10:0]};	// util.scala:466:20
        uops_11_br_tag = _RANDOM[8'h95][15:11];	// util.scala:466:20
        uops_11_ftq_idx = _RANDOM[8'h95][21:16];	// util.scala:466:20
        uops_11_edge_inst = _RANDOM[8'h95][22];	// util.scala:466:20
        uops_11_pc_lob = _RANDOM[8'h95][28:23];	// util.scala:466:20
        uops_11_taken = _RANDOM[8'h95][29];	// util.scala:466:20
        uops_11_imm_packed = {_RANDOM[8'h95][31:30], _RANDOM[8'h96][17:0]};	// util.scala:466:20
        uops_11_csr_addr = _RANDOM[8'h96][29:18];	// util.scala:466:20
        uops_11_rob_idx = {_RANDOM[8'h96][31:30], _RANDOM[8'h97][4:0]};	// util.scala:466:20
        uops_11_ldq_idx = _RANDOM[8'h97][9:5];	// util.scala:466:20
        uops_11_stq_idx = _RANDOM[8'h97][14:10];	// util.scala:466:20
        uops_11_rxq_idx = _RANDOM[8'h97][16:15];	// util.scala:466:20
        uops_11_pdst = _RANDOM[8'h97][23:17];	// util.scala:466:20
        uops_11_prs1 = _RANDOM[8'h97][30:24];	// util.scala:466:20
        uops_11_prs2 = {_RANDOM[8'h97][31], _RANDOM[8'h98][5:0]};	// util.scala:466:20
        uops_11_prs3 = _RANDOM[8'h98][12:6];	// util.scala:466:20
        uops_11_ppred = _RANDOM[8'h98][18:13];	// util.scala:466:20
        uops_11_prs1_busy = _RANDOM[8'h98][19];	// util.scala:466:20
        uops_11_prs2_busy = _RANDOM[8'h98][20];	// util.scala:466:20
        uops_11_prs3_busy = _RANDOM[8'h98][21];	// util.scala:466:20
        uops_11_ppred_busy = _RANDOM[8'h98][22];	// util.scala:466:20
        uops_11_stale_pdst = _RANDOM[8'h98][29:23];	// util.scala:466:20
        uops_11_exception = _RANDOM[8'h98][30];	// util.scala:466:20
        uops_11_exc_cause = {_RANDOM[8'h98][31], _RANDOM[8'h99], _RANDOM[8'h9A][30:0]};	// util.scala:466:20
        uops_11_bypassable = _RANDOM[8'h9A][31];	// util.scala:466:20
        uops_11_mem_cmd = _RANDOM[8'h9B][4:0];	// util.scala:466:20
        uops_11_mem_size = _RANDOM[8'h9B][6:5];	// util.scala:466:20
        uops_11_mem_signed = _RANDOM[8'h9B][7];	// util.scala:466:20
        uops_11_is_fence = _RANDOM[8'h9B][8];	// util.scala:466:20
        uops_11_is_fencei = _RANDOM[8'h9B][9];	// util.scala:466:20
        uops_11_is_amo = _RANDOM[8'h9B][10];	// util.scala:466:20
        uops_11_uses_ldq = _RANDOM[8'h9B][11];	// util.scala:466:20
        uops_11_uses_stq = _RANDOM[8'h9B][12];	// util.scala:466:20
        uops_11_is_sys_pc2epc = _RANDOM[8'h9B][13];	// util.scala:466:20
        uops_11_is_unique = _RANDOM[8'h9B][14];	// util.scala:466:20
        uops_11_flush_on_commit = _RANDOM[8'h9B][15];	// util.scala:466:20
        uops_11_ldst_is_rs1 = _RANDOM[8'h9B][16];	// util.scala:466:20
        uops_11_ldst = _RANDOM[8'h9B][22:17];	// util.scala:466:20
        uops_11_lrs1 = _RANDOM[8'h9B][28:23];	// util.scala:466:20
        uops_11_lrs2 = {_RANDOM[8'h9B][31:29], _RANDOM[8'h9C][2:0]};	// util.scala:466:20
        uops_11_lrs3 = _RANDOM[8'h9C][8:3];	// util.scala:466:20
        uops_11_ldst_val = _RANDOM[8'h9C][9];	// util.scala:466:20
        uops_11_dst_rtype = _RANDOM[8'h9C][11:10];	// util.scala:466:20
        uops_11_lrs1_rtype = _RANDOM[8'h9C][13:12];	// util.scala:466:20
        uops_11_lrs2_rtype = _RANDOM[8'h9C][15:14];	// util.scala:466:20
        uops_11_frs3_en = _RANDOM[8'h9C][16];	// util.scala:466:20
        uops_11_fp_val = _RANDOM[8'h9C][17];	// util.scala:466:20
        uops_11_fp_single = _RANDOM[8'h9C][18];	// util.scala:466:20
        uops_11_xcpt_pf_if = _RANDOM[8'h9C][19];	// util.scala:466:20
        uops_11_xcpt_ae_if = _RANDOM[8'h9C][20];	// util.scala:466:20
        uops_11_xcpt_ma_if = _RANDOM[8'h9C][21];	// util.scala:466:20
        uops_11_bp_debug_if = _RANDOM[8'h9C][22];	// util.scala:466:20
        uops_11_bp_xcpt_if = _RANDOM[8'h9C][23];	// util.scala:466:20
        uops_11_debug_fsrc = _RANDOM[8'h9C][25:24];	// util.scala:466:20
        uops_11_debug_tsrc = _RANDOM[8'h9C][27:26];	// util.scala:466:20
        uops_12_uopc = {_RANDOM[8'h9C][31:28], _RANDOM[8'h9D][2:0]};	// util.scala:466:20
        uops_12_inst = {_RANDOM[8'h9D][31:3], _RANDOM[8'h9E][2:0]};	// util.scala:466:20
        uops_12_debug_inst = {_RANDOM[8'h9E][31:3], _RANDOM[8'h9F][2:0]};	// util.scala:466:20
        uops_12_is_rvc = _RANDOM[8'h9F][3];	// util.scala:466:20
        uops_12_debug_pc = {_RANDOM[8'h9F][31:4], _RANDOM[8'hA0][11:0]};	// util.scala:466:20
        uops_12_iq_type = _RANDOM[8'hA0][14:12];	// util.scala:466:20
        uops_12_fu_code = _RANDOM[8'hA0][24:15];	// util.scala:466:20
        uops_12_ctrl_br_type = _RANDOM[8'hA0][28:25];	// util.scala:466:20
        uops_12_ctrl_op1_sel = _RANDOM[8'hA0][30:29];	// util.scala:466:20
        uops_12_ctrl_op2_sel = {_RANDOM[8'hA0][31], _RANDOM[8'hA1][1:0]};	// util.scala:466:20
        uops_12_ctrl_imm_sel = _RANDOM[8'hA1][4:2];	// util.scala:466:20
        uops_12_ctrl_op_fcn = _RANDOM[8'hA1][8:5];	// util.scala:466:20
        uops_12_ctrl_fcn_dw = _RANDOM[8'hA1][9];	// util.scala:466:20
        uops_12_ctrl_csr_cmd = _RANDOM[8'hA1][12:10];	// util.scala:466:20
        uops_12_ctrl_is_load = _RANDOM[8'hA1][13];	// util.scala:466:20
        uops_12_ctrl_is_sta = _RANDOM[8'hA1][14];	// util.scala:466:20
        uops_12_ctrl_is_std = _RANDOM[8'hA1][15];	// util.scala:466:20
        uops_12_iw_state = _RANDOM[8'hA1][17:16];	// util.scala:466:20
        uops_12_iw_p1_poisoned = _RANDOM[8'hA1][18];	// util.scala:466:20
        uops_12_iw_p2_poisoned = _RANDOM[8'hA1][19];	// util.scala:466:20
        uops_12_is_br = _RANDOM[8'hA1][20];	// util.scala:466:20
        uops_12_is_jalr = _RANDOM[8'hA1][21];	// util.scala:466:20
        uops_12_is_jal = _RANDOM[8'hA1][22];	// util.scala:466:20
        uops_12_is_sfb = _RANDOM[8'hA1][23];	// util.scala:466:20
        uops_12_br_mask = {_RANDOM[8'hA1][31:24], _RANDOM[8'hA2][11:0]};	// util.scala:466:20
        uops_12_br_tag = _RANDOM[8'hA2][16:12];	// util.scala:466:20
        uops_12_ftq_idx = _RANDOM[8'hA2][22:17];	// util.scala:466:20
        uops_12_edge_inst = _RANDOM[8'hA2][23];	// util.scala:466:20
        uops_12_pc_lob = _RANDOM[8'hA2][29:24];	// util.scala:466:20
        uops_12_taken = _RANDOM[8'hA2][30];	// util.scala:466:20
        uops_12_imm_packed = {_RANDOM[8'hA2][31], _RANDOM[8'hA3][18:0]};	// util.scala:466:20
        uops_12_csr_addr = _RANDOM[8'hA3][30:19];	// util.scala:466:20
        uops_12_rob_idx = {_RANDOM[8'hA3][31], _RANDOM[8'hA4][5:0]};	// util.scala:466:20
        uops_12_ldq_idx = _RANDOM[8'hA4][10:6];	// util.scala:466:20
        uops_12_stq_idx = _RANDOM[8'hA4][15:11];	// util.scala:466:20
        uops_12_rxq_idx = _RANDOM[8'hA4][17:16];	// util.scala:466:20
        uops_12_pdst = _RANDOM[8'hA4][24:18];	// util.scala:466:20
        uops_12_prs1 = _RANDOM[8'hA4][31:25];	// util.scala:466:20
        uops_12_prs2 = _RANDOM[8'hA5][6:0];	// util.scala:466:20
        uops_12_prs3 = _RANDOM[8'hA5][13:7];	// util.scala:466:20
        uops_12_ppred = _RANDOM[8'hA5][19:14];	// util.scala:466:20
        uops_12_prs1_busy = _RANDOM[8'hA5][20];	// util.scala:466:20
        uops_12_prs2_busy = _RANDOM[8'hA5][21];	// util.scala:466:20
        uops_12_prs3_busy = _RANDOM[8'hA5][22];	// util.scala:466:20
        uops_12_ppred_busy = _RANDOM[8'hA5][23];	// util.scala:466:20
        uops_12_stale_pdst = _RANDOM[8'hA5][30:24];	// util.scala:466:20
        uops_12_exception = _RANDOM[8'hA5][31];	// util.scala:466:20
        uops_12_exc_cause = {_RANDOM[8'hA6], _RANDOM[8'hA7]};	// util.scala:466:20
        uops_12_bypassable = _RANDOM[8'hA8][0];	// util.scala:466:20
        uops_12_mem_cmd = _RANDOM[8'hA8][5:1];	// util.scala:466:20
        uops_12_mem_size = _RANDOM[8'hA8][7:6];	// util.scala:466:20
        uops_12_mem_signed = _RANDOM[8'hA8][8];	// util.scala:466:20
        uops_12_is_fence = _RANDOM[8'hA8][9];	// util.scala:466:20
        uops_12_is_fencei = _RANDOM[8'hA8][10];	// util.scala:466:20
        uops_12_is_amo = _RANDOM[8'hA8][11];	// util.scala:466:20
        uops_12_uses_ldq = _RANDOM[8'hA8][12];	// util.scala:466:20
        uops_12_uses_stq = _RANDOM[8'hA8][13];	// util.scala:466:20
        uops_12_is_sys_pc2epc = _RANDOM[8'hA8][14];	// util.scala:466:20
        uops_12_is_unique = _RANDOM[8'hA8][15];	// util.scala:466:20
        uops_12_flush_on_commit = _RANDOM[8'hA8][16];	// util.scala:466:20
        uops_12_ldst_is_rs1 = _RANDOM[8'hA8][17];	// util.scala:466:20
        uops_12_ldst = _RANDOM[8'hA8][23:18];	// util.scala:466:20
        uops_12_lrs1 = _RANDOM[8'hA8][29:24];	// util.scala:466:20
        uops_12_lrs2 = {_RANDOM[8'hA8][31:30], _RANDOM[8'hA9][3:0]};	// util.scala:466:20
        uops_12_lrs3 = _RANDOM[8'hA9][9:4];	// util.scala:466:20
        uops_12_ldst_val = _RANDOM[8'hA9][10];	// util.scala:466:20
        uops_12_dst_rtype = _RANDOM[8'hA9][12:11];	// util.scala:466:20
        uops_12_lrs1_rtype = _RANDOM[8'hA9][14:13];	// util.scala:466:20
        uops_12_lrs2_rtype = _RANDOM[8'hA9][16:15];	// util.scala:466:20
        uops_12_frs3_en = _RANDOM[8'hA9][17];	// util.scala:466:20
        uops_12_fp_val = _RANDOM[8'hA9][18];	// util.scala:466:20
        uops_12_fp_single = _RANDOM[8'hA9][19];	// util.scala:466:20
        uops_12_xcpt_pf_if = _RANDOM[8'hA9][20];	// util.scala:466:20
        uops_12_xcpt_ae_if = _RANDOM[8'hA9][21];	// util.scala:466:20
        uops_12_xcpt_ma_if = _RANDOM[8'hA9][22];	// util.scala:466:20
        uops_12_bp_debug_if = _RANDOM[8'hA9][23];	// util.scala:466:20
        uops_12_bp_xcpt_if = _RANDOM[8'hA9][24];	// util.scala:466:20
        uops_12_debug_fsrc = _RANDOM[8'hA9][26:25];	// util.scala:466:20
        uops_12_debug_tsrc = _RANDOM[8'hA9][28:27];	// util.scala:466:20
        uops_13_uopc = {_RANDOM[8'hA9][31:29], _RANDOM[8'hAA][3:0]};	// util.scala:466:20
        uops_13_inst = {_RANDOM[8'hAA][31:4], _RANDOM[8'hAB][3:0]};	// util.scala:466:20
        uops_13_debug_inst = {_RANDOM[8'hAB][31:4], _RANDOM[8'hAC][3:0]};	// util.scala:466:20
        uops_13_is_rvc = _RANDOM[8'hAC][4];	// util.scala:466:20
        uops_13_debug_pc = {_RANDOM[8'hAC][31:5], _RANDOM[8'hAD][12:0]};	// util.scala:466:20
        uops_13_iq_type = _RANDOM[8'hAD][15:13];	// util.scala:466:20
        uops_13_fu_code = _RANDOM[8'hAD][25:16];	// util.scala:466:20
        uops_13_ctrl_br_type = _RANDOM[8'hAD][29:26];	// util.scala:466:20
        uops_13_ctrl_op1_sel = _RANDOM[8'hAD][31:30];	// util.scala:466:20
        uops_13_ctrl_op2_sel = _RANDOM[8'hAE][2:0];	// util.scala:466:20
        uops_13_ctrl_imm_sel = _RANDOM[8'hAE][5:3];	// util.scala:466:20
        uops_13_ctrl_op_fcn = _RANDOM[8'hAE][9:6];	// util.scala:466:20
        uops_13_ctrl_fcn_dw = _RANDOM[8'hAE][10];	// util.scala:466:20
        uops_13_ctrl_csr_cmd = _RANDOM[8'hAE][13:11];	// util.scala:466:20
        uops_13_ctrl_is_load = _RANDOM[8'hAE][14];	// util.scala:466:20
        uops_13_ctrl_is_sta = _RANDOM[8'hAE][15];	// util.scala:466:20
        uops_13_ctrl_is_std = _RANDOM[8'hAE][16];	// util.scala:466:20
        uops_13_iw_state = _RANDOM[8'hAE][18:17];	// util.scala:466:20
        uops_13_iw_p1_poisoned = _RANDOM[8'hAE][19];	// util.scala:466:20
        uops_13_iw_p2_poisoned = _RANDOM[8'hAE][20];	// util.scala:466:20
        uops_13_is_br = _RANDOM[8'hAE][21];	// util.scala:466:20
        uops_13_is_jalr = _RANDOM[8'hAE][22];	// util.scala:466:20
        uops_13_is_jal = _RANDOM[8'hAE][23];	// util.scala:466:20
        uops_13_is_sfb = _RANDOM[8'hAE][24];	// util.scala:466:20
        uops_13_br_mask = {_RANDOM[8'hAE][31:25], _RANDOM[8'hAF][12:0]};	// util.scala:466:20
        uops_13_br_tag = _RANDOM[8'hAF][17:13];	// util.scala:466:20
        uops_13_ftq_idx = _RANDOM[8'hAF][23:18];	// util.scala:466:20
        uops_13_edge_inst = _RANDOM[8'hAF][24];	// util.scala:466:20
        uops_13_pc_lob = _RANDOM[8'hAF][30:25];	// util.scala:466:20
        uops_13_taken = _RANDOM[8'hAF][31];	// util.scala:466:20
        uops_13_imm_packed = _RANDOM[8'hB0][19:0];	// util.scala:466:20
        uops_13_csr_addr = _RANDOM[8'hB0][31:20];	// util.scala:466:20
        uops_13_rob_idx = _RANDOM[8'hB1][6:0];	// util.scala:466:20
        uops_13_ldq_idx = _RANDOM[8'hB1][11:7];	// util.scala:466:20
        uops_13_stq_idx = _RANDOM[8'hB1][16:12];	// util.scala:466:20
        uops_13_rxq_idx = _RANDOM[8'hB1][18:17];	// util.scala:466:20
        uops_13_pdst = _RANDOM[8'hB1][25:19];	// util.scala:466:20
        uops_13_prs1 = {_RANDOM[8'hB1][31:26], _RANDOM[8'hB2][0]};	// util.scala:466:20
        uops_13_prs2 = _RANDOM[8'hB2][7:1];	// util.scala:466:20
        uops_13_prs3 = _RANDOM[8'hB2][14:8];	// util.scala:466:20
        uops_13_ppred = _RANDOM[8'hB2][20:15];	// util.scala:466:20
        uops_13_prs1_busy = _RANDOM[8'hB2][21];	// util.scala:466:20
        uops_13_prs2_busy = _RANDOM[8'hB2][22];	// util.scala:466:20
        uops_13_prs3_busy = _RANDOM[8'hB2][23];	// util.scala:466:20
        uops_13_ppred_busy = _RANDOM[8'hB2][24];	// util.scala:466:20
        uops_13_stale_pdst = _RANDOM[8'hB2][31:25];	// util.scala:466:20
        uops_13_exception = _RANDOM[8'hB3][0];	// util.scala:466:20
        uops_13_exc_cause = {_RANDOM[8'hB3][31:1], _RANDOM[8'hB4], _RANDOM[8'hB5][0]};	// util.scala:466:20
        uops_13_bypassable = _RANDOM[8'hB5][1];	// util.scala:466:20
        uops_13_mem_cmd = _RANDOM[8'hB5][6:2];	// util.scala:466:20
        uops_13_mem_size = _RANDOM[8'hB5][8:7];	// util.scala:466:20
        uops_13_mem_signed = _RANDOM[8'hB5][9];	// util.scala:466:20
        uops_13_is_fence = _RANDOM[8'hB5][10];	// util.scala:466:20
        uops_13_is_fencei = _RANDOM[8'hB5][11];	// util.scala:466:20
        uops_13_is_amo = _RANDOM[8'hB5][12];	// util.scala:466:20
        uops_13_uses_ldq = _RANDOM[8'hB5][13];	// util.scala:466:20
        uops_13_uses_stq = _RANDOM[8'hB5][14];	// util.scala:466:20
        uops_13_is_sys_pc2epc = _RANDOM[8'hB5][15];	// util.scala:466:20
        uops_13_is_unique = _RANDOM[8'hB5][16];	// util.scala:466:20
        uops_13_flush_on_commit = _RANDOM[8'hB5][17];	// util.scala:466:20
        uops_13_ldst_is_rs1 = _RANDOM[8'hB5][18];	// util.scala:466:20
        uops_13_ldst = _RANDOM[8'hB5][24:19];	// util.scala:466:20
        uops_13_lrs1 = _RANDOM[8'hB5][30:25];	// util.scala:466:20
        uops_13_lrs2 = {_RANDOM[8'hB5][31], _RANDOM[8'hB6][4:0]};	// util.scala:466:20
        uops_13_lrs3 = _RANDOM[8'hB6][10:5];	// util.scala:466:20
        uops_13_ldst_val = _RANDOM[8'hB6][11];	// util.scala:466:20
        uops_13_dst_rtype = _RANDOM[8'hB6][13:12];	// util.scala:466:20
        uops_13_lrs1_rtype = _RANDOM[8'hB6][15:14];	// util.scala:466:20
        uops_13_lrs2_rtype = _RANDOM[8'hB6][17:16];	// util.scala:466:20
        uops_13_frs3_en = _RANDOM[8'hB6][18];	// util.scala:466:20
        uops_13_fp_val = _RANDOM[8'hB6][19];	// util.scala:466:20
        uops_13_fp_single = _RANDOM[8'hB6][20];	// util.scala:466:20
        uops_13_xcpt_pf_if = _RANDOM[8'hB6][21];	// util.scala:466:20
        uops_13_xcpt_ae_if = _RANDOM[8'hB6][22];	// util.scala:466:20
        uops_13_xcpt_ma_if = _RANDOM[8'hB6][23];	// util.scala:466:20
        uops_13_bp_debug_if = _RANDOM[8'hB6][24];	// util.scala:466:20
        uops_13_bp_xcpt_if = _RANDOM[8'hB6][25];	// util.scala:466:20
        uops_13_debug_fsrc = _RANDOM[8'hB6][27:26];	// util.scala:466:20
        uops_13_debug_tsrc = _RANDOM[8'hB6][29:28];	// util.scala:466:20
        uops_14_uopc = {_RANDOM[8'hB6][31:30], _RANDOM[8'hB7][4:0]};	// util.scala:466:20
        uops_14_inst = {_RANDOM[8'hB7][31:5], _RANDOM[8'hB8][4:0]};	// util.scala:466:20
        uops_14_debug_inst = {_RANDOM[8'hB8][31:5], _RANDOM[8'hB9][4:0]};	// util.scala:466:20
        uops_14_is_rvc = _RANDOM[8'hB9][5];	// util.scala:466:20
        uops_14_debug_pc = {_RANDOM[8'hB9][31:6], _RANDOM[8'hBA][13:0]};	// util.scala:466:20
        uops_14_iq_type = _RANDOM[8'hBA][16:14];	// util.scala:466:20
        uops_14_fu_code = _RANDOM[8'hBA][26:17];	// util.scala:466:20
        uops_14_ctrl_br_type = _RANDOM[8'hBA][30:27];	// util.scala:466:20
        uops_14_ctrl_op1_sel = {_RANDOM[8'hBA][31], _RANDOM[8'hBB][0]};	// util.scala:466:20
        uops_14_ctrl_op2_sel = _RANDOM[8'hBB][3:1];	// util.scala:466:20
        uops_14_ctrl_imm_sel = _RANDOM[8'hBB][6:4];	// util.scala:466:20
        uops_14_ctrl_op_fcn = _RANDOM[8'hBB][10:7];	// util.scala:466:20
        uops_14_ctrl_fcn_dw = _RANDOM[8'hBB][11];	// util.scala:466:20
        uops_14_ctrl_csr_cmd = _RANDOM[8'hBB][14:12];	// util.scala:466:20
        uops_14_ctrl_is_load = _RANDOM[8'hBB][15];	// util.scala:466:20
        uops_14_ctrl_is_sta = _RANDOM[8'hBB][16];	// util.scala:466:20
        uops_14_ctrl_is_std = _RANDOM[8'hBB][17];	// util.scala:466:20
        uops_14_iw_state = _RANDOM[8'hBB][19:18];	// util.scala:466:20
        uops_14_iw_p1_poisoned = _RANDOM[8'hBB][20];	// util.scala:466:20
        uops_14_iw_p2_poisoned = _RANDOM[8'hBB][21];	// util.scala:466:20
        uops_14_is_br = _RANDOM[8'hBB][22];	// util.scala:466:20
        uops_14_is_jalr = _RANDOM[8'hBB][23];	// util.scala:466:20
        uops_14_is_jal = _RANDOM[8'hBB][24];	// util.scala:466:20
        uops_14_is_sfb = _RANDOM[8'hBB][25];	// util.scala:466:20
        uops_14_br_mask = {_RANDOM[8'hBB][31:26], _RANDOM[8'hBC][13:0]};	// util.scala:466:20
        uops_14_br_tag = _RANDOM[8'hBC][18:14];	// util.scala:466:20
        uops_14_ftq_idx = _RANDOM[8'hBC][24:19];	// util.scala:466:20
        uops_14_edge_inst = _RANDOM[8'hBC][25];	// util.scala:466:20
        uops_14_pc_lob = _RANDOM[8'hBC][31:26];	// util.scala:466:20
        uops_14_taken = _RANDOM[8'hBD][0];	// util.scala:466:20
        uops_14_imm_packed = _RANDOM[8'hBD][20:1];	// util.scala:466:20
        uops_14_csr_addr = {_RANDOM[8'hBD][31:21], _RANDOM[8'hBE][0]};	// util.scala:466:20
        uops_14_rob_idx = _RANDOM[8'hBE][7:1];	// util.scala:466:20
        uops_14_ldq_idx = _RANDOM[8'hBE][12:8];	// util.scala:466:20
        uops_14_stq_idx = _RANDOM[8'hBE][17:13];	// util.scala:466:20
        uops_14_rxq_idx = _RANDOM[8'hBE][19:18];	// util.scala:466:20
        uops_14_pdst = _RANDOM[8'hBE][26:20];	// util.scala:466:20
        uops_14_prs1 = {_RANDOM[8'hBE][31:27], _RANDOM[8'hBF][1:0]};	// util.scala:466:20
        uops_14_prs2 = _RANDOM[8'hBF][8:2];	// util.scala:466:20
        uops_14_prs3 = _RANDOM[8'hBF][15:9];	// util.scala:466:20
        uops_14_ppred = _RANDOM[8'hBF][21:16];	// util.scala:466:20
        uops_14_prs1_busy = _RANDOM[8'hBF][22];	// util.scala:466:20
        uops_14_prs2_busy = _RANDOM[8'hBF][23];	// util.scala:466:20
        uops_14_prs3_busy = _RANDOM[8'hBF][24];	// util.scala:466:20
        uops_14_ppred_busy = _RANDOM[8'hBF][25];	// util.scala:466:20
        uops_14_stale_pdst = {_RANDOM[8'hBF][31:26], _RANDOM[8'hC0][0]};	// util.scala:466:20
        uops_14_exception = _RANDOM[8'hC0][1];	// util.scala:466:20
        uops_14_exc_cause = {_RANDOM[8'hC0][31:2], _RANDOM[8'hC1], _RANDOM[8'hC2][1:0]};	// util.scala:466:20
        uops_14_bypassable = _RANDOM[8'hC2][2];	// util.scala:466:20
        uops_14_mem_cmd = _RANDOM[8'hC2][7:3];	// util.scala:466:20
        uops_14_mem_size = _RANDOM[8'hC2][9:8];	// util.scala:466:20
        uops_14_mem_signed = _RANDOM[8'hC2][10];	// util.scala:466:20
        uops_14_is_fence = _RANDOM[8'hC2][11];	// util.scala:466:20
        uops_14_is_fencei = _RANDOM[8'hC2][12];	// util.scala:466:20
        uops_14_is_amo = _RANDOM[8'hC2][13];	// util.scala:466:20
        uops_14_uses_ldq = _RANDOM[8'hC2][14];	// util.scala:466:20
        uops_14_uses_stq = _RANDOM[8'hC2][15];	// util.scala:466:20
        uops_14_is_sys_pc2epc = _RANDOM[8'hC2][16];	// util.scala:466:20
        uops_14_is_unique = _RANDOM[8'hC2][17];	// util.scala:466:20
        uops_14_flush_on_commit = _RANDOM[8'hC2][18];	// util.scala:466:20
        uops_14_ldst_is_rs1 = _RANDOM[8'hC2][19];	// util.scala:466:20
        uops_14_ldst = _RANDOM[8'hC2][25:20];	// util.scala:466:20
        uops_14_lrs1 = _RANDOM[8'hC2][31:26];	// util.scala:466:20
        uops_14_lrs2 = _RANDOM[8'hC3][5:0];	// util.scala:466:20
        uops_14_lrs3 = _RANDOM[8'hC3][11:6];	// util.scala:466:20
        uops_14_ldst_val = _RANDOM[8'hC3][12];	// util.scala:466:20
        uops_14_dst_rtype = _RANDOM[8'hC3][14:13];	// util.scala:466:20
        uops_14_lrs1_rtype = _RANDOM[8'hC3][16:15];	// util.scala:466:20
        uops_14_lrs2_rtype = _RANDOM[8'hC3][18:17];	// util.scala:466:20
        uops_14_frs3_en = _RANDOM[8'hC3][19];	// util.scala:466:20
        uops_14_fp_val = _RANDOM[8'hC3][20];	// util.scala:466:20
        uops_14_fp_single = _RANDOM[8'hC3][21];	// util.scala:466:20
        uops_14_xcpt_pf_if = _RANDOM[8'hC3][22];	// util.scala:466:20
        uops_14_xcpt_ae_if = _RANDOM[8'hC3][23];	// util.scala:466:20
        uops_14_xcpt_ma_if = _RANDOM[8'hC3][24];	// util.scala:466:20
        uops_14_bp_debug_if = _RANDOM[8'hC3][25];	// util.scala:466:20
        uops_14_bp_xcpt_if = _RANDOM[8'hC3][26];	// util.scala:466:20
        uops_14_debug_fsrc = _RANDOM[8'hC3][28:27];	// util.scala:466:20
        uops_14_debug_tsrc = _RANDOM[8'hC3][30:29];	// util.scala:466:20
        uops_15_uopc = {_RANDOM[8'hC3][31], _RANDOM[8'hC4][5:0]};	// util.scala:466:20
        uops_15_inst = {_RANDOM[8'hC4][31:6], _RANDOM[8'hC5][5:0]};	// util.scala:466:20
        uops_15_debug_inst = {_RANDOM[8'hC5][31:6], _RANDOM[8'hC6][5:0]};	// util.scala:466:20
        uops_15_is_rvc = _RANDOM[8'hC6][6];	// util.scala:466:20
        uops_15_debug_pc = {_RANDOM[8'hC6][31:7], _RANDOM[8'hC7][14:0]};	// util.scala:466:20
        uops_15_iq_type = _RANDOM[8'hC7][17:15];	// util.scala:466:20
        uops_15_fu_code = _RANDOM[8'hC7][27:18];	// util.scala:466:20
        uops_15_ctrl_br_type = _RANDOM[8'hC7][31:28];	// util.scala:466:20
        uops_15_ctrl_op1_sel = _RANDOM[8'hC8][1:0];	// util.scala:466:20
        uops_15_ctrl_op2_sel = _RANDOM[8'hC8][4:2];	// util.scala:466:20
        uops_15_ctrl_imm_sel = _RANDOM[8'hC8][7:5];	// util.scala:466:20
        uops_15_ctrl_op_fcn = _RANDOM[8'hC8][11:8];	// util.scala:466:20
        uops_15_ctrl_fcn_dw = _RANDOM[8'hC8][12];	// util.scala:466:20
        uops_15_ctrl_csr_cmd = _RANDOM[8'hC8][15:13];	// util.scala:466:20
        uops_15_ctrl_is_load = _RANDOM[8'hC8][16];	// util.scala:466:20
        uops_15_ctrl_is_sta = _RANDOM[8'hC8][17];	// util.scala:466:20
        uops_15_ctrl_is_std = _RANDOM[8'hC8][18];	// util.scala:466:20
        uops_15_iw_state = _RANDOM[8'hC8][20:19];	// util.scala:466:20
        uops_15_iw_p1_poisoned = _RANDOM[8'hC8][21];	// util.scala:466:20
        uops_15_iw_p2_poisoned = _RANDOM[8'hC8][22];	// util.scala:466:20
        uops_15_is_br = _RANDOM[8'hC8][23];	// util.scala:466:20
        uops_15_is_jalr = _RANDOM[8'hC8][24];	// util.scala:466:20
        uops_15_is_jal = _RANDOM[8'hC8][25];	// util.scala:466:20
        uops_15_is_sfb = _RANDOM[8'hC8][26];	// util.scala:466:20
        uops_15_br_mask = {_RANDOM[8'hC8][31:27], _RANDOM[8'hC9][14:0]};	// util.scala:466:20
        uops_15_br_tag = _RANDOM[8'hC9][19:15];	// util.scala:466:20
        uops_15_ftq_idx = _RANDOM[8'hC9][25:20];	// util.scala:466:20
        uops_15_edge_inst = _RANDOM[8'hC9][26];	// util.scala:466:20
        uops_15_pc_lob = {_RANDOM[8'hC9][31:27], _RANDOM[8'hCA][0]};	// util.scala:466:20
        uops_15_taken = _RANDOM[8'hCA][1];	// util.scala:466:20
        uops_15_imm_packed = _RANDOM[8'hCA][21:2];	// util.scala:466:20
        uops_15_csr_addr = {_RANDOM[8'hCA][31:22], _RANDOM[8'hCB][1:0]};	// util.scala:466:20
        uops_15_rob_idx = _RANDOM[8'hCB][8:2];	// util.scala:466:20
        uops_15_ldq_idx = _RANDOM[8'hCB][13:9];	// util.scala:466:20
        uops_15_stq_idx = _RANDOM[8'hCB][18:14];	// util.scala:466:20
        uops_15_rxq_idx = _RANDOM[8'hCB][20:19];	// util.scala:466:20
        uops_15_pdst = _RANDOM[8'hCB][27:21];	// util.scala:466:20
        uops_15_prs1 = {_RANDOM[8'hCB][31:28], _RANDOM[8'hCC][2:0]};	// util.scala:466:20
        uops_15_prs2 = _RANDOM[8'hCC][9:3];	// util.scala:466:20
        uops_15_prs3 = _RANDOM[8'hCC][16:10];	// util.scala:466:20
        uops_15_ppred = _RANDOM[8'hCC][22:17];	// util.scala:466:20
        uops_15_prs1_busy = _RANDOM[8'hCC][23];	// util.scala:466:20
        uops_15_prs2_busy = _RANDOM[8'hCC][24];	// util.scala:466:20
        uops_15_prs3_busy = _RANDOM[8'hCC][25];	// util.scala:466:20
        uops_15_ppred_busy = _RANDOM[8'hCC][26];	// util.scala:466:20
        uops_15_stale_pdst = {_RANDOM[8'hCC][31:27], _RANDOM[8'hCD][1:0]};	// util.scala:466:20
        uops_15_exception = _RANDOM[8'hCD][2];	// util.scala:466:20
        uops_15_exc_cause = {_RANDOM[8'hCD][31:3], _RANDOM[8'hCE], _RANDOM[8'hCF][2:0]};	// util.scala:466:20
        uops_15_bypassable = _RANDOM[8'hCF][3];	// util.scala:466:20
        uops_15_mem_cmd = _RANDOM[8'hCF][8:4];	// util.scala:466:20
        uops_15_mem_size = _RANDOM[8'hCF][10:9];	// util.scala:466:20
        uops_15_mem_signed = _RANDOM[8'hCF][11];	// util.scala:466:20
        uops_15_is_fence = _RANDOM[8'hCF][12];	// util.scala:466:20
        uops_15_is_fencei = _RANDOM[8'hCF][13];	// util.scala:466:20
        uops_15_is_amo = _RANDOM[8'hCF][14];	// util.scala:466:20
        uops_15_uses_ldq = _RANDOM[8'hCF][15];	// util.scala:466:20
        uops_15_uses_stq = _RANDOM[8'hCF][16];	// util.scala:466:20
        uops_15_is_sys_pc2epc = _RANDOM[8'hCF][17];	// util.scala:466:20
        uops_15_is_unique = _RANDOM[8'hCF][18];	// util.scala:466:20
        uops_15_flush_on_commit = _RANDOM[8'hCF][19];	// util.scala:466:20
        uops_15_ldst_is_rs1 = _RANDOM[8'hCF][20];	// util.scala:466:20
        uops_15_ldst = _RANDOM[8'hCF][26:21];	// util.scala:466:20
        uops_15_lrs1 = {_RANDOM[8'hCF][31:27], _RANDOM[8'hD0][0]};	// util.scala:466:20
        uops_15_lrs2 = _RANDOM[8'hD0][6:1];	// util.scala:466:20
        uops_15_lrs3 = _RANDOM[8'hD0][12:7];	// util.scala:466:20
        uops_15_ldst_val = _RANDOM[8'hD0][13];	// util.scala:466:20
        uops_15_dst_rtype = _RANDOM[8'hD0][15:14];	// util.scala:466:20
        uops_15_lrs1_rtype = _RANDOM[8'hD0][17:16];	// util.scala:466:20
        uops_15_lrs2_rtype = _RANDOM[8'hD0][19:18];	// util.scala:466:20
        uops_15_frs3_en = _RANDOM[8'hD0][20];	// util.scala:466:20
        uops_15_fp_val = _RANDOM[8'hD0][21];	// util.scala:466:20
        uops_15_fp_single = _RANDOM[8'hD0][22];	// util.scala:466:20
        uops_15_xcpt_pf_if = _RANDOM[8'hD0][23];	// util.scala:466:20
        uops_15_xcpt_ae_if = _RANDOM[8'hD0][24];	// util.scala:466:20
        uops_15_xcpt_ma_if = _RANDOM[8'hD0][25];	// util.scala:466:20
        uops_15_bp_debug_if = _RANDOM[8'hD0][26];	// util.scala:466:20
        uops_15_bp_xcpt_if = _RANDOM[8'hD0][27];	// util.scala:466:20
        uops_15_debug_fsrc = _RANDOM[8'hD0][29:28];	// util.scala:466:20
        uops_15_debug_tsrc = _RANDOM[8'hD0][31:30];	// util.scala:466:20
        value = _RANDOM[8'hD1][3:0];	// Counter.scala:60:40
        value_1 = _RANDOM[8'hD1][7:4];	// Counter.scala:60:40
        maybe_full = _RANDOM[8'hD1][8];	// Counter.scala:60:40, util.scala:470:27
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  ram_16x46 ram_ext (	// util.scala:464:20
    .R0_addr (value_1),	// Counter.scala:60:40
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (value),	// Counter.scala:60:40
    .W0_en   (do_enq),	// Decoupled.scala:40:37
    .W0_clk  (clock),
    .W0_data ({io_enq_bits_sdq_id, io_enq_bits_is_hella, io_enq_bits_addr}),	// util.scala:464:20
    .R0_data (_ram_ext_R0_data)
  );
  assign io_enq_ready = ~full;	// util.scala:474:24, :504:19
  assign io_deq_valid =
    ~_io_empty_output & _GEN_0
    & (io_brupdate_b1_mispredict_mask & out_uop_br_mask) == 20'h0
    & ~(io_flush & out_uop_uses_ldq);	// util.scala:118:{51,59}, :473:25, :476:{42,69}, :508:19, :509:{108,111,122}
  assign io_deq_bits_uop_uopc = _GEN_1[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_inst = _GEN_2[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_debug_inst = _GEN_3[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_is_rvc = _GEN_4[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_debug_pc = _GEN_5[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_iq_type = _GEN_6[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_fu_code = _GEN_7[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_ctrl_br_type = _GEN_8[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_ctrl_op1_sel = _GEN_9[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_ctrl_op2_sel = _GEN_10[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_ctrl_imm_sel = _GEN_11[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_ctrl_op_fcn = _GEN_12[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_ctrl_fcn_dw = _GEN_13[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_ctrl_csr_cmd = _GEN_14[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_ctrl_is_load = _GEN_15[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_ctrl_is_sta = _GEN_16[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_ctrl_is_std = _GEN_17[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_iw_state = _GEN_18[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_iw_p1_poisoned = _GEN_19[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_iw_p2_poisoned = _GEN_20[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_is_br = _GEN_21[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_is_jalr = _GEN_22[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_is_jal = _GEN_23[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_is_sfb = _GEN_24[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_br_mask = out_uop_br_mask & ~io_brupdate_b1_resolve_mask;	// util.scala:85:{25,27}, :508:19
  assign io_deq_bits_uop_br_tag = _GEN_26[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_ftq_idx = _GEN_27[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_edge_inst = _GEN_28[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_pc_lob = _GEN_29[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_taken = _GEN_30[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_imm_packed = _GEN_31[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_csr_addr = _GEN_32[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_rob_idx = _GEN_33[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_ldq_idx = _GEN_34[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_stq_idx = _GEN_35[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_rxq_idx = _GEN_36[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_pdst = _GEN_37[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_prs1 = _GEN_38[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_prs2 = _GEN_39[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_prs3 = _GEN_40[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_ppred = _GEN_41[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_prs1_busy = _GEN_42[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_prs2_busy = _GEN_43[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_prs3_busy = _GEN_44[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_ppred_busy = _GEN_45[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_stale_pdst = _GEN_46[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_exception = _GEN_47[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_exc_cause = _GEN_48[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_bypassable = _GEN_49[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_mem_cmd = _GEN_50[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_mem_size = _GEN_51[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_mem_signed = _GEN_52[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_is_fence = _GEN_53[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_is_fencei = _GEN_54[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_is_amo = _GEN_55[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_uses_ldq = out_uop_uses_ldq;	// util.scala:508:19
  assign io_deq_bits_uop_uses_stq = _GEN_57[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_is_sys_pc2epc = _GEN_58[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_is_unique = _GEN_59[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_flush_on_commit = _GEN_60[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_ldst_is_rs1 = _GEN_61[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_ldst = _GEN_62[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_lrs1 = _GEN_63[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_lrs2 = _GEN_64[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_lrs3 = _GEN_65[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_ldst_val = _GEN_66[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_dst_rtype = _GEN_67[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_lrs1_rtype = _GEN_68[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_lrs2_rtype = _GEN_69[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_frs3_en = _GEN_70[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_fp_val = _GEN_71[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_fp_single = _GEN_72[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_xcpt_pf_if = _GEN_73[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_xcpt_ae_if = _GEN_74[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_xcpt_ma_if = _GEN_75[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_bp_debug_if = _GEN_76[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_bp_xcpt_if = _GEN_77[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_debug_fsrc = _GEN_78[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_uop_debug_tsrc = _GEN_79[value_1];	// Counter.scala:60:40, util.scala:508:19
  assign io_deq_bits_addr = _ram_ext_R0_data[39:0];	// util.scala:464:20
  assign io_deq_bits_is_hella = _ram_ext_R0_data[40];	// util.scala:464:20
  assign io_deq_bits_sdq_id = _ram_ext_R0_data[45:41];	// util.scala:464:20
  assign io_empty = _io_empty_output;	// util.scala:473:25
endmodule

