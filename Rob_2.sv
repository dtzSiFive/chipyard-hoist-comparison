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

module Rob_2(
  input         clock,
                reset,
                io_enq_valids_0,
                io_enq_valids_1,
  input  [6:0]  io_enq_uops_0_uopc,
  input         io_enq_uops_0_is_rvc,
                io_enq_uops_0_is_br,
                io_enq_uops_0_is_jalr,
  input  [11:0] io_enq_uops_0_br_mask,
  input  [4:0]  io_enq_uops_0_ftq_idx,
  input         io_enq_uops_0_edge_inst,
  input  [5:0]  io_enq_uops_0_pc_lob,
                io_enq_uops_0_rob_idx,
  input  [6:0]  io_enq_uops_0_pdst,
                io_enq_uops_0_stale_pdst,
  input         io_enq_uops_0_exception,
  input  [63:0] io_enq_uops_0_exc_cause,
  input         io_enq_uops_0_is_fence,
                io_enq_uops_0_is_fencei,
                io_enq_uops_0_uses_ldq,
                io_enq_uops_0_uses_stq,
                io_enq_uops_0_is_sys_pc2epc,
                io_enq_uops_0_is_unique,
                io_enq_uops_0_flush_on_commit,
  input  [5:0]  io_enq_uops_0_ldst,
  input         io_enq_uops_0_ldst_val,
  input  [1:0]  io_enq_uops_0_dst_rtype,
  input         io_enq_uops_0_fp_val,
  input  [6:0]  io_enq_uops_1_uopc,
  input         io_enq_uops_1_is_rvc,
                io_enq_uops_1_is_br,
                io_enq_uops_1_is_jalr,
  input  [11:0] io_enq_uops_1_br_mask,
  input  [4:0]  io_enq_uops_1_ftq_idx,
  input         io_enq_uops_1_edge_inst,
  input  [5:0]  io_enq_uops_1_pc_lob,
                io_enq_uops_1_rob_idx,
  input  [6:0]  io_enq_uops_1_pdst,
                io_enq_uops_1_stale_pdst,
  input         io_enq_uops_1_exception,
  input  [63:0] io_enq_uops_1_exc_cause,
  input         io_enq_uops_1_is_fence,
                io_enq_uops_1_is_fencei,
                io_enq_uops_1_uses_ldq,
                io_enq_uops_1_uses_stq,
                io_enq_uops_1_is_sys_pc2epc,
                io_enq_uops_1_is_unique,
                io_enq_uops_1_flush_on_commit,
  input  [5:0]  io_enq_uops_1_ldst,
  input         io_enq_uops_1_ldst_val,
  input  [1:0]  io_enq_uops_1_dst_rtype,
  input         io_enq_uops_1_fp_val,
                io_enq_partial_stall,
  input  [39:0] io_xcpt_fetch_pc,
  input  [11:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  input  [5:0]  io_brupdate_b2_uop_rob_idx,
  input         io_brupdate_b2_mispredict,
                io_wb_resps_0_valid,
  input  [5:0]  io_wb_resps_0_bits_uop_rob_idx,
  input  [6:0]  io_wb_resps_0_bits_uop_pdst,
  input         io_wb_resps_0_bits_predicated,
                io_wb_resps_1_valid,
  input  [5:0]  io_wb_resps_1_bits_uop_rob_idx,
  input  [6:0]  io_wb_resps_1_bits_uop_pdst,
  input         io_wb_resps_2_valid,
  input  [5:0]  io_wb_resps_2_bits_uop_rob_idx,
  input  [6:0]  io_wb_resps_2_bits_uop_pdst,
  input         io_wb_resps_3_valid,
  input  [5:0]  io_wb_resps_3_bits_uop_rob_idx,
  input  [6:0]  io_wb_resps_3_bits_uop_pdst,
  input         io_wb_resps_3_bits_predicated,
                io_wb_resps_4_valid,
  input  [5:0]  io_wb_resps_4_bits_uop_rob_idx,
  input  [6:0]  io_wb_resps_4_bits_uop_pdst,
  input         io_lsu_clr_bsy_0_valid,
  input  [5:0]  io_lsu_clr_bsy_0_bits,
  input         io_lsu_clr_bsy_1_valid,
  input  [5:0]  io_lsu_clr_bsy_1_bits,
  input         io_fflags_0_valid,
  input  [5:0]  io_fflags_0_bits_uop_rob_idx,
  input  [4:0]  io_fflags_0_bits_flags,
  input         io_fflags_1_valid,
  input  [5:0]  io_fflags_1_bits_uop_rob_idx,
  input  [4:0]  io_fflags_1_bits_flags,
  input         io_lxcpt_valid,
  input  [11:0] io_lxcpt_bits_uop_br_mask,
  input  [5:0]  io_lxcpt_bits_uop_rob_idx,
  input  [4:0]  io_lxcpt_bits_cause,
  input  [39:0] io_lxcpt_bits_badvaddr,
  input         io_csr_stall,
  output [5:0]  io_rob_tail_idx,
                io_rob_head_idx,
  output        io_commit_valids_0,
                io_commit_valids_1,
                io_commit_arch_valids_0,
                io_commit_arch_valids_1,
  output [4:0]  io_commit_uops_0_ftq_idx,
  output [6:0]  io_commit_uops_0_pdst,
                io_commit_uops_0_stale_pdst,
  output        io_commit_uops_0_is_fencei,
                io_commit_uops_0_uses_ldq,
                io_commit_uops_0_uses_stq,
  output [5:0]  io_commit_uops_0_ldst,
  output        io_commit_uops_0_ldst_val,
  output [1:0]  io_commit_uops_0_dst_rtype,
  output [4:0]  io_commit_uops_1_ftq_idx,
  output [6:0]  io_commit_uops_1_pdst,
                io_commit_uops_1_stale_pdst,
  output        io_commit_uops_1_is_fencei,
                io_commit_uops_1_uses_ldq,
                io_commit_uops_1_uses_stq,
  output [5:0]  io_commit_uops_1_ldst,
  output        io_commit_uops_1_ldst_val,
  output [1:0]  io_commit_uops_1_dst_rtype,
  output        io_commit_fflags_valid,
  output [4:0]  io_commit_fflags_bits,
  output        io_commit_rbk_valids_0,
                io_commit_rbk_valids_1,
                io_commit_rollback,
                io_com_load_is_at_rob_head,
                io_com_xcpt_valid,
  output [4:0]  io_com_xcpt_bits_ftq_idx,
  output        io_com_xcpt_bits_edge_inst,
  output [5:0]  io_com_xcpt_bits_pc_lob,
  output [63:0] io_com_xcpt_bits_cause,
                io_com_xcpt_bits_badvaddr,
  output        io_flush_valid,
  output [4:0]  io_flush_bits_ftq_idx,
  output        io_flush_bits_edge_inst,
                io_flush_bits_is_rvc,
  output [5:0]  io_flush_bits_pc_lob,
  output [2:0]  io_flush_bits_flush_typ,
  output        io_empty,
                io_ready,
                io_flush_frontend
);

  wire             empty;	// rob.scala:788:41
  wire             full;	// rob.scala:787:39
  wire             will_commit_1;	// rob.scala:547:70
  wire             will_commit_0;	// rob.scala:547:70
  wire [4:0]       _rob_fflags_1_ext_R0_data;	// rob.scala:313:28
  wire [4:0]       _rob_fflags_ext_R0_data;	// rob.scala:313:28
  reg  [1:0]       rob_state;	// rob.scala:221:26
  reg  [4:0]       rob_head;	// rob.scala:224:29
  reg              rob_head_lsb;	// rob.scala:225:29
  wire [5:0]       rob_head_idx = {rob_head, rob_head_lsb};	// Cat.scala:30:58, rob.scala:224:29, :225:29
  reg  [4:0]       rob_tail;	// rob.scala:228:29
  reg              rob_tail_lsb;	// rob.scala:229:29
  wire [5:0]       rob_tail_idx = {rob_tail, rob_tail_lsb};	// Cat.scala:30:58, rob.scala:228:29, :229:29
  reg  [4:0]       rob_pnr;	// rob.scala:232:29
  reg              rob_pnr_lsb;	// rob.scala:233:29
  wire             _io_commit_rollback_T_1 = rob_state == 2'h2;	// rob.scala:221:26, :236:31
  wire [4:0]       com_idx = _io_commit_rollback_T_1 ? rob_tail : rob_head;	// rob.scala:224:29, :228:29, :236:{20,31}
  reg              maybe_full;	// rob.scala:239:29
  reg              r_xcpt_val;	// rob.scala:258:33
  reg  [11:0]      r_xcpt_uop_br_mask;	// rob.scala:259:29
  reg  [5:0]       r_xcpt_uop_rob_idx;	// rob.scala:259:29
  reg  [63:0]      r_xcpt_uop_exc_cause;	// rob.scala:259:29
  reg  [39:0]      r_xcpt_badvaddr;	// rob.scala:260:29
  reg              rob_val_0;	// rob.scala:307:32
  reg              rob_val_1;	// rob.scala:307:32
  reg              rob_val_2;	// rob.scala:307:32
  reg              rob_val_3;	// rob.scala:307:32
  reg              rob_val_4;	// rob.scala:307:32
  reg              rob_val_5;	// rob.scala:307:32
  reg              rob_val_6;	// rob.scala:307:32
  reg              rob_val_7;	// rob.scala:307:32
  reg              rob_val_8;	// rob.scala:307:32
  reg              rob_val_9;	// rob.scala:307:32
  reg              rob_val_10;	// rob.scala:307:32
  reg              rob_val_11;	// rob.scala:307:32
  reg              rob_val_12;	// rob.scala:307:32
  reg              rob_val_13;	// rob.scala:307:32
  reg              rob_val_14;	// rob.scala:307:32
  reg              rob_val_15;	// rob.scala:307:32
  reg              rob_val_16;	// rob.scala:307:32
  reg              rob_val_17;	// rob.scala:307:32
  reg              rob_val_18;	// rob.scala:307:32
  reg              rob_val_19;	// rob.scala:307:32
  reg              rob_val_20;	// rob.scala:307:32
  reg              rob_val_21;	// rob.scala:307:32
  reg              rob_val_22;	// rob.scala:307:32
  reg              rob_val_23;	// rob.scala:307:32
  reg              rob_val_24;	// rob.scala:307:32
  reg              rob_val_25;	// rob.scala:307:32
  reg              rob_val_26;	// rob.scala:307:32
  reg              rob_val_27;	// rob.scala:307:32
  reg              rob_val_28;	// rob.scala:307:32
  reg              rob_val_29;	// rob.scala:307:32
  reg              rob_val_30;	// rob.scala:307:32
  reg              rob_val_31;	// rob.scala:307:32
  reg              rob_bsy_0;	// rob.scala:308:28
  reg              rob_bsy_1;	// rob.scala:308:28
  reg              rob_bsy_2;	// rob.scala:308:28
  reg              rob_bsy_3;	// rob.scala:308:28
  reg              rob_bsy_4;	// rob.scala:308:28
  reg              rob_bsy_5;	// rob.scala:308:28
  reg              rob_bsy_6;	// rob.scala:308:28
  reg              rob_bsy_7;	// rob.scala:308:28
  reg              rob_bsy_8;	// rob.scala:308:28
  reg              rob_bsy_9;	// rob.scala:308:28
  reg              rob_bsy_10;	// rob.scala:308:28
  reg              rob_bsy_11;	// rob.scala:308:28
  reg              rob_bsy_12;	// rob.scala:308:28
  reg              rob_bsy_13;	// rob.scala:308:28
  reg              rob_bsy_14;	// rob.scala:308:28
  reg              rob_bsy_15;	// rob.scala:308:28
  reg              rob_bsy_16;	// rob.scala:308:28
  reg              rob_bsy_17;	// rob.scala:308:28
  reg              rob_bsy_18;	// rob.scala:308:28
  reg              rob_bsy_19;	// rob.scala:308:28
  reg              rob_bsy_20;	// rob.scala:308:28
  reg              rob_bsy_21;	// rob.scala:308:28
  reg              rob_bsy_22;	// rob.scala:308:28
  reg              rob_bsy_23;	// rob.scala:308:28
  reg              rob_bsy_24;	// rob.scala:308:28
  reg              rob_bsy_25;	// rob.scala:308:28
  reg              rob_bsy_26;	// rob.scala:308:28
  reg              rob_bsy_27;	// rob.scala:308:28
  reg              rob_bsy_28;	// rob.scala:308:28
  reg              rob_bsy_29;	// rob.scala:308:28
  reg              rob_bsy_30;	// rob.scala:308:28
  reg              rob_bsy_31;	// rob.scala:308:28
  reg              rob_unsafe_0;	// rob.scala:309:28
  reg              rob_unsafe_1;	// rob.scala:309:28
  reg              rob_unsafe_2;	// rob.scala:309:28
  reg              rob_unsafe_3;	// rob.scala:309:28
  reg              rob_unsafe_4;	// rob.scala:309:28
  reg              rob_unsafe_5;	// rob.scala:309:28
  reg              rob_unsafe_6;	// rob.scala:309:28
  reg              rob_unsafe_7;	// rob.scala:309:28
  reg              rob_unsafe_8;	// rob.scala:309:28
  reg              rob_unsafe_9;	// rob.scala:309:28
  reg              rob_unsafe_10;	// rob.scala:309:28
  reg              rob_unsafe_11;	// rob.scala:309:28
  reg              rob_unsafe_12;	// rob.scala:309:28
  reg              rob_unsafe_13;	// rob.scala:309:28
  reg              rob_unsafe_14;	// rob.scala:309:28
  reg              rob_unsafe_15;	// rob.scala:309:28
  reg              rob_unsafe_16;	// rob.scala:309:28
  reg              rob_unsafe_17;	// rob.scala:309:28
  reg              rob_unsafe_18;	// rob.scala:309:28
  reg              rob_unsafe_19;	// rob.scala:309:28
  reg              rob_unsafe_20;	// rob.scala:309:28
  reg              rob_unsafe_21;	// rob.scala:309:28
  reg              rob_unsafe_22;	// rob.scala:309:28
  reg              rob_unsafe_23;	// rob.scala:309:28
  reg              rob_unsafe_24;	// rob.scala:309:28
  reg              rob_unsafe_25;	// rob.scala:309:28
  reg              rob_unsafe_26;	// rob.scala:309:28
  reg              rob_unsafe_27;	// rob.scala:309:28
  reg              rob_unsafe_28;	// rob.scala:309:28
  reg              rob_unsafe_29;	// rob.scala:309:28
  reg              rob_unsafe_30;	// rob.scala:309:28
  reg              rob_unsafe_31;	// rob.scala:309:28
  reg  [6:0]       rob_uop_0_uopc;	// rob.scala:310:28
  reg              rob_uop_0_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_0_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_0_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_0_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_0_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_0_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_0_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_0_is_fencei;	// rob.scala:310:28
  reg              rob_uop_0_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_0_uses_stq;	// rob.scala:310:28
  reg              rob_uop_0_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_0_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_0_ldst;	// rob.scala:310:28
  reg              rob_uop_0_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_0_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_0_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_uopc;	// rob.scala:310:28
  reg              rob_uop_1_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_1_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_1_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_1_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_1_is_fencei;	// rob.scala:310:28
  reg              rob_uop_1_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_1_uses_stq;	// rob.scala:310:28
  reg              rob_uop_1_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_1_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_ldst;	// rob.scala:310:28
  reg              rob_uop_1_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_1_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_1_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_2_uopc;	// rob.scala:310:28
  reg              rob_uop_2_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_2_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_2_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_2_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_2_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_2_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_2_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_2_is_fencei;	// rob.scala:310:28
  reg              rob_uop_2_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_2_uses_stq;	// rob.scala:310:28
  reg              rob_uop_2_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_2_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_2_ldst;	// rob.scala:310:28
  reg              rob_uop_2_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_2_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_2_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_3_uopc;	// rob.scala:310:28
  reg              rob_uop_3_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_3_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_3_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_3_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_3_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_3_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_3_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_3_is_fencei;	// rob.scala:310:28
  reg              rob_uop_3_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_3_uses_stq;	// rob.scala:310:28
  reg              rob_uop_3_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_3_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_3_ldst;	// rob.scala:310:28
  reg              rob_uop_3_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_3_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_3_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_4_uopc;	// rob.scala:310:28
  reg              rob_uop_4_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_4_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_4_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_4_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_4_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_4_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_4_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_4_is_fencei;	// rob.scala:310:28
  reg              rob_uop_4_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_4_uses_stq;	// rob.scala:310:28
  reg              rob_uop_4_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_4_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_4_ldst;	// rob.scala:310:28
  reg              rob_uop_4_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_4_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_4_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_5_uopc;	// rob.scala:310:28
  reg              rob_uop_5_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_5_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_5_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_5_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_5_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_5_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_5_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_5_is_fencei;	// rob.scala:310:28
  reg              rob_uop_5_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_5_uses_stq;	// rob.scala:310:28
  reg              rob_uop_5_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_5_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_5_ldst;	// rob.scala:310:28
  reg              rob_uop_5_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_5_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_5_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_6_uopc;	// rob.scala:310:28
  reg              rob_uop_6_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_6_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_6_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_6_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_6_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_6_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_6_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_6_is_fencei;	// rob.scala:310:28
  reg              rob_uop_6_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_6_uses_stq;	// rob.scala:310:28
  reg              rob_uop_6_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_6_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_6_ldst;	// rob.scala:310:28
  reg              rob_uop_6_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_6_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_6_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_7_uopc;	// rob.scala:310:28
  reg              rob_uop_7_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_7_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_7_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_7_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_7_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_7_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_7_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_7_is_fencei;	// rob.scala:310:28
  reg              rob_uop_7_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_7_uses_stq;	// rob.scala:310:28
  reg              rob_uop_7_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_7_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_7_ldst;	// rob.scala:310:28
  reg              rob_uop_7_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_7_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_7_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_8_uopc;	// rob.scala:310:28
  reg              rob_uop_8_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_8_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_8_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_8_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_8_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_8_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_8_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_8_is_fencei;	// rob.scala:310:28
  reg              rob_uop_8_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_8_uses_stq;	// rob.scala:310:28
  reg              rob_uop_8_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_8_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_8_ldst;	// rob.scala:310:28
  reg              rob_uop_8_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_8_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_8_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_9_uopc;	// rob.scala:310:28
  reg              rob_uop_9_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_9_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_9_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_9_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_9_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_9_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_9_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_9_is_fencei;	// rob.scala:310:28
  reg              rob_uop_9_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_9_uses_stq;	// rob.scala:310:28
  reg              rob_uop_9_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_9_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_9_ldst;	// rob.scala:310:28
  reg              rob_uop_9_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_9_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_9_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_10_uopc;	// rob.scala:310:28
  reg              rob_uop_10_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_10_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_10_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_10_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_10_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_10_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_10_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_10_is_fencei;	// rob.scala:310:28
  reg              rob_uop_10_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_10_uses_stq;	// rob.scala:310:28
  reg              rob_uop_10_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_10_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_10_ldst;	// rob.scala:310:28
  reg              rob_uop_10_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_10_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_10_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_11_uopc;	// rob.scala:310:28
  reg              rob_uop_11_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_11_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_11_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_11_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_11_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_11_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_11_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_11_is_fencei;	// rob.scala:310:28
  reg              rob_uop_11_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_11_uses_stq;	// rob.scala:310:28
  reg              rob_uop_11_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_11_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_11_ldst;	// rob.scala:310:28
  reg              rob_uop_11_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_11_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_11_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_12_uopc;	// rob.scala:310:28
  reg              rob_uop_12_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_12_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_12_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_12_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_12_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_12_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_12_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_12_is_fencei;	// rob.scala:310:28
  reg              rob_uop_12_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_12_uses_stq;	// rob.scala:310:28
  reg              rob_uop_12_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_12_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_12_ldst;	// rob.scala:310:28
  reg              rob_uop_12_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_12_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_12_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_13_uopc;	// rob.scala:310:28
  reg              rob_uop_13_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_13_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_13_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_13_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_13_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_13_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_13_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_13_is_fencei;	// rob.scala:310:28
  reg              rob_uop_13_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_13_uses_stq;	// rob.scala:310:28
  reg              rob_uop_13_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_13_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_13_ldst;	// rob.scala:310:28
  reg              rob_uop_13_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_13_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_13_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_14_uopc;	// rob.scala:310:28
  reg              rob_uop_14_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_14_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_14_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_14_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_14_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_14_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_14_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_14_is_fencei;	// rob.scala:310:28
  reg              rob_uop_14_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_14_uses_stq;	// rob.scala:310:28
  reg              rob_uop_14_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_14_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_14_ldst;	// rob.scala:310:28
  reg              rob_uop_14_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_14_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_14_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_15_uopc;	// rob.scala:310:28
  reg              rob_uop_15_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_15_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_15_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_15_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_15_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_15_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_15_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_15_is_fencei;	// rob.scala:310:28
  reg              rob_uop_15_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_15_uses_stq;	// rob.scala:310:28
  reg              rob_uop_15_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_15_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_15_ldst;	// rob.scala:310:28
  reg              rob_uop_15_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_15_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_15_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_16_uopc;	// rob.scala:310:28
  reg              rob_uop_16_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_16_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_16_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_16_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_16_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_16_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_16_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_16_is_fencei;	// rob.scala:310:28
  reg              rob_uop_16_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_16_uses_stq;	// rob.scala:310:28
  reg              rob_uop_16_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_16_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_16_ldst;	// rob.scala:310:28
  reg              rob_uop_16_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_16_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_16_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_17_uopc;	// rob.scala:310:28
  reg              rob_uop_17_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_17_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_17_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_17_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_17_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_17_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_17_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_17_is_fencei;	// rob.scala:310:28
  reg              rob_uop_17_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_17_uses_stq;	// rob.scala:310:28
  reg              rob_uop_17_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_17_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_17_ldst;	// rob.scala:310:28
  reg              rob_uop_17_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_17_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_17_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_18_uopc;	// rob.scala:310:28
  reg              rob_uop_18_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_18_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_18_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_18_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_18_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_18_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_18_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_18_is_fencei;	// rob.scala:310:28
  reg              rob_uop_18_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_18_uses_stq;	// rob.scala:310:28
  reg              rob_uop_18_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_18_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_18_ldst;	// rob.scala:310:28
  reg              rob_uop_18_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_18_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_18_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_19_uopc;	// rob.scala:310:28
  reg              rob_uop_19_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_19_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_19_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_19_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_19_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_19_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_19_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_19_is_fencei;	// rob.scala:310:28
  reg              rob_uop_19_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_19_uses_stq;	// rob.scala:310:28
  reg              rob_uop_19_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_19_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_19_ldst;	// rob.scala:310:28
  reg              rob_uop_19_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_19_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_19_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_20_uopc;	// rob.scala:310:28
  reg              rob_uop_20_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_20_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_20_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_20_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_20_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_20_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_20_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_20_is_fencei;	// rob.scala:310:28
  reg              rob_uop_20_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_20_uses_stq;	// rob.scala:310:28
  reg              rob_uop_20_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_20_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_20_ldst;	// rob.scala:310:28
  reg              rob_uop_20_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_20_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_20_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_21_uopc;	// rob.scala:310:28
  reg              rob_uop_21_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_21_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_21_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_21_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_21_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_21_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_21_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_21_is_fencei;	// rob.scala:310:28
  reg              rob_uop_21_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_21_uses_stq;	// rob.scala:310:28
  reg              rob_uop_21_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_21_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_21_ldst;	// rob.scala:310:28
  reg              rob_uop_21_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_21_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_21_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_22_uopc;	// rob.scala:310:28
  reg              rob_uop_22_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_22_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_22_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_22_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_22_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_22_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_22_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_22_is_fencei;	// rob.scala:310:28
  reg              rob_uop_22_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_22_uses_stq;	// rob.scala:310:28
  reg              rob_uop_22_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_22_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_22_ldst;	// rob.scala:310:28
  reg              rob_uop_22_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_22_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_22_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_23_uopc;	// rob.scala:310:28
  reg              rob_uop_23_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_23_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_23_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_23_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_23_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_23_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_23_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_23_is_fencei;	// rob.scala:310:28
  reg              rob_uop_23_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_23_uses_stq;	// rob.scala:310:28
  reg              rob_uop_23_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_23_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_23_ldst;	// rob.scala:310:28
  reg              rob_uop_23_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_23_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_23_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_24_uopc;	// rob.scala:310:28
  reg              rob_uop_24_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_24_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_24_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_24_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_24_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_24_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_24_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_24_is_fencei;	// rob.scala:310:28
  reg              rob_uop_24_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_24_uses_stq;	// rob.scala:310:28
  reg              rob_uop_24_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_24_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_24_ldst;	// rob.scala:310:28
  reg              rob_uop_24_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_24_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_24_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_25_uopc;	// rob.scala:310:28
  reg              rob_uop_25_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_25_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_25_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_25_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_25_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_25_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_25_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_25_is_fencei;	// rob.scala:310:28
  reg              rob_uop_25_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_25_uses_stq;	// rob.scala:310:28
  reg              rob_uop_25_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_25_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_25_ldst;	// rob.scala:310:28
  reg              rob_uop_25_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_25_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_25_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_26_uopc;	// rob.scala:310:28
  reg              rob_uop_26_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_26_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_26_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_26_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_26_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_26_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_26_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_26_is_fencei;	// rob.scala:310:28
  reg              rob_uop_26_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_26_uses_stq;	// rob.scala:310:28
  reg              rob_uop_26_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_26_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_26_ldst;	// rob.scala:310:28
  reg              rob_uop_26_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_26_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_26_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_27_uopc;	// rob.scala:310:28
  reg              rob_uop_27_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_27_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_27_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_27_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_27_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_27_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_27_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_27_is_fencei;	// rob.scala:310:28
  reg              rob_uop_27_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_27_uses_stq;	// rob.scala:310:28
  reg              rob_uop_27_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_27_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_27_ldst;	// rob.scala:310:28
  reg              rob_uop_27_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_27_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_27_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_28_uopc;	// rob.scala:310:28
  reg              rob_uop_28_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_28_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_28_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_28_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_28_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_28_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_28_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_28_is_fencei;	// rob.scala:310:28
  reg              rob_uop_28_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_28_uses_stq;	// rob.scala:310:28
  reg              rob_uop_28_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_28_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_28_ldst;	// rob.scala:310:28
  reg              rob_uop_28_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_28_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_28_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_29_uopc;	// rob.scala:310:28
  reg              rob_uop_29_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_29_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_29_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_29_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_29_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_29_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_29_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_29_is_fencei;	// rob.scala:310:28
  reg              rob_uop_29_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_29_uses_stq;	// rob.scala:310:28
  reg              rob_uop_29_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_29_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_29_ldst;	// rob.scala:310:28
  reg              rob_uop_29_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_29_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_29_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_30_uopc;	// rob.scala:310:28
  reg              rob_uop_30_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_30_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_30_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_30_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_30_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_30_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_30_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_30_is_fencei;	// rob.scala:310:28
  reg              rob_uop_30_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_30_uses_stq;	// rob.scala:310:28
  reg              rob_uop_30_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_30_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_30_ldst;	// rob.scala:310:28
  reg              rob_uop_30_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_30_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_30_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_31_uopc;	// rob.scala:310:28
  reg              rob_uop_31_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_31_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_31_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_31_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_31_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_31_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_31_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_31_is_fencei;	// rob.scala:310:28
  reg              rob_uop_31_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_31_uses_stq;	// rob.scala:310:28
  reg              rob_uop_31_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_31_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_31_ldst;	// rob.scala:310:28
  reg              rob_uop_31_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_31_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_31_fp_val;	// rob.scala:310:28
  reg              rob_exception_0;	// rob.scala:311:28
  reg              rob_exception_1;	// rob.scala:311:28
  reg              rob_exception_2;	// rob.scala:311:28
  reg              rob_exception_3;	// rob.scala:311:28
  reg              rob_exception_4;	// rob.scala:311:28
  reg              rob_exception_5;	// rob.scala:311:28
  reg              rob_exception_6;	// rob.scala:311:28
  reg              rob_exception_7;	// rob.scala:311:28
  reg              rob_exception_8;	// rob.scala:311:28
  reg              rob_exception_9;	// rob.scala:311:28
  reg              rob_exception_10;	// rob.scala:311:28
  reg              rob_exception_11;	// rob.scala:311:28
  reg              rob_exception_12;	// rob.scala:311:28
  reg              rob_exception_13;	// rob.scala:311:28
  reg              rob_exception_14;	// rob.scala:311:28
  reg              rob_exception_15;	// rob.scala:311:28
  reg              rob_exception_16;	// rob.scala:311:28
  reg              rob_exception_17;	// rob.scala:311:28
  reg              rob_exception_18;	// rob.scala:311:28
  reg              rob_exception_19;	// rob.scala:311:28
  reg              rob_exception_20;	// rob.scala:311:28
  reg              rob_exception_21;	// rob.scala:311:28
  reg              rob_exception_22;	// rob.scala:311:28
  reg              rob_exception_23;	// rob.scala:311:28
  reg              rob_exception_24;	// rob.scala:311:28
  reg              rob_exception_25;	// rob.scala:311:28
  reg              rob_exception_26;	// rob.scala:311:28
  reg              rob_exception_27;	// rob.scala:311:28
  reg              rob_exception_28;	// rob.scala:311:28
  reg              rob_exception_29;	// rob.scala:311:28
  reg              rob_exception_30;	// rob.scala:311:28
  reg              rob_exception_31;	// rob.scala:311:28
  reg              rob_predicated_0;	// rob.scala:312:29
  reg              rob_predicated_1;	// rob.scala:312:29
  reg              rob_predicated_2;	// rob.scala:312:29
  reg              rob_predicated_3;	// rob.scala:312:29
  reg              rob_predicated_4;	// rob.scala:312:29
  reg              rob_predicated_5;	// rob.scala:312:29
  reg              rob_predicated_6;	// rob.scala:312:29
  reg              rob_predicated_7;	// rob.scala:312:29
  reg              rob_predicated_8;	// rob.scala:312:29
  reg              rob_predicated_9;	// rob.scala:312:29
  reg              rob_predicated_10;	// rob.scala:312:29
  reg              rob_predicated_11;	// rob.scala:312:29
  reg              rob_predicated_12;	// rob.scala:312:29
  reg              rob_predicated_13;	// rob.scala:312:29
  reg              rob_predicated_14;	// rob.scala:312:29
  reg              rob_predicated_15;	// rob.scala:312:29
  reg              rob_predicated_16;	// rob.scala:312:29
  reg              rob_predicated_17;	// rob.scala:312:29
  reg              rob_predicated_18;	// rob.scala:312:29
  reg              rob_predicated_19;	// rob.scala:312:29
  reg              rob_predicated_20;	// rob.scala:312:29
  reg              rob_predicated_21;	// rob.scala:312:29
  reg              rob_predicated_22;	// rob.scala:312:29
  reg              rob_predicated_23;	// rob.scala:312:29
  reg              rob_predicated_24;	// rob.scala:312:29
  reg              rob_predicated_25;	// rob.scala:312:29
  reg              rob_predicated_26;	// rob.scala:312:29
  reg              rob_predicated_27;	// rob.scala:312:29
  reg              rob_predicated_28;	// rob.scala:312:29
  reg              rob_predicated_29;	// rob.scala:312:29
  reg              rob_predicated_30;	// rob.scala:312:29
  reg              rob_predicated_31;	// rob.scala:312:29
  wire [31:0]      _GEN =
    {{rob_val_31},
     {rob_val_30},
     {rob_val_29},
     {rob_val_28},
     {rob_val_27},
     {rob_val_26},
     {rob_val_25},
     {rob_val_24},
     {rob_val_23},
     {rob_val_22},
     {rob_val_21},
     {rob_val_20},
     {rob_val_19},
     {rob_val_18},
     {rob_val_17},
     {rob_val_16},
     {rob_val_15},
     {rob_val_14},
     {rob_val_13},
     {rob_val_12},
     {rob_val_11},
     {rob_val_10},
     {rob_val_9},
     {rob_val_8},
     {rob_val_7},
     {rob_val_6},
     {rob_val_5},
     {rob_val_4},
     {rob_val_3},
     {rob_val_2},
     {rob_val_1},
     {rob_val_0}};	// rob.scala:307:32, :324:31
  wire             rob_tail_vals_0 = _GEN[rob_tail];	// rob.scala:228:29, :324:31
  wire             _GEN_0 = io_wb_resps_0_valid & ~(io_wb_resps_0_bits_uop_rob_idx[0]);	// rob.scala:272:36, :304:53, :346:27
  wire             _GEN_1 = io_wb_resps_1_valid & ~(io_wb_resps_1_bits_uop_rob_idx[0]);	// rob.scala:272:36, :304:53, :346:27
  wire             _GEN_2 = io_wb_resps_2_valid & ~(io_wb_resps_2_bits_uop_rob_idx[0]);	// rob.scala:272:36, :304:53, :346:27
  wire             _GEN_3 = io_wb_resps_3_valid & ~(io_wb_resps_3_bits_uop_rob_idx[0]);	// rob.scala:272:36, :304:53, :346:27
  wire             _GEN_4 = io_wb_resps_4_valid & ~(io_wb_resps_4_bits_uop_rob_idx[0]);	// rob.scala:272:36, :304:53, :346:27
  wire             _GEN_5 = io_lsu_clr_bsy_0_valid & ~(io_lsu_clr_bsy_0_bits[0]);	// rob.scala:272:36, :304:53, :361:31
  wire [31:0]      _GEN_6 =
    {{rob_bsy_31},
     {rob_bsy_30},
     {rob_bsy_29},
     {rob_bsy_28},
     {rob_bsy_27},
     {rob_bsy_26},
     {rob_bsy_25},
     {rob_bsy_24},
     {rob_bsy_23},
     {rob_bsy_22},
     {rob_bsy_21},
     {rob_bsy_20},
     {rob_bsy_19},
     {rob_bsy_18},
     {rob_bsy_17},
     {rob_bsy_16},
     {rob_bsy_15},
     {rob_bsy_14},
     {rob_bsy_13},
     {rob_bsy_12},
     {rob_bsy_11},
     {rob_bsy_10},
     {rob_bsy_9},
     {rob_bsy_8},
     {rob_bsy_7},
     {rob_bsy_6},
     {rob_bsy_5},
     {rob_bsy_4},
     {rob_bsy_3},
     {rob_bsy_2},
     {rob_bsy_1},
     {rob_bsy_0}};	// rob.scala:308:28, :366:31
  wire             _GEN_7 = io_lsu_clr_bsy_1_valid & ~(io_lsu_clr_bsy_1_bits[0]);	// rob.scala:272:36, :304:53, :361:31
  wire             _GEN_8 = io_lxcpt_valid & ~(io_lxcpt_bits_uop_rob_idx[0]);	// rob.scala:272:36, :304:53, :390:26
  wire [31:0]      _GEN_9 =
    {{rob_unsafe_31},
     {rob_unsafe_30},
     {rob_unsafe_29},
     {rob_unsafe_28},
     {rob_unsafe_27},
     {rob_unsafe_26},
     {rob_unsafe_25},
     {rob_unsafe_24},
     {rob_unsafe_23},
     {rob_unsafe_22},
     {rob_unsafe_21},
     {rob_unsafe_20},
     {rob_unsafe_19},
     {rob_unsafe_18},
     {rob_unsafe_17},
     {rob_unsafe_16},
     {rob_unsafe_15},
     {rob_unsafe_14},
     {rob_unsafe_13},
     {rob_unsafe_12},
     {rob_unsafe_11},
     {rob_unsafe_10},
     {rob_unsafe_9},
     {rob_unsafe_8},
     {rob_unsafe_7},
     {rob_unsafe_6},
     {rob_unsafe_5},
     {rob_unsafe_4},
     {rob_unsafe_3},
     {rob_unsafe_2},
     {rob_unsafe_1},
     {rob_unsafe_0}};	// rob.scala:309:28, :394:15
  wire             rob_head_vals_0 = _GEN[rob_head];	// rob.scala:224:29, :324:31, :398:49
  wire [31:0]      _GEN_10 =
    {{rob_exception_31},
     {rob_exception_30},
     {rob_exception_29},
     {rob_exception_28},
     {rob_exception_27},
     {rob_exception_26},
     {rob_exception_25},
     {rob_exception_24},
     {rob_exception_23},
     {rob_exception_22},
     {rob_exception_21},
     {rob_exception_20},
     {rob_exception_19},
     {rob_exception_18},
     {rob_exception_17},
     {rob_exception_16},
     {rob_exception_15},
     {rob_exception_14},
     {rob_exception_13},
     {rob_exception_12},
     {rob_exception_11},
     {rob_exception_10},
     {rob_exception_9},
     {rob_exception_8},
     {rob_exception_7},
     {rob_exception_6},
     {rob_exception_5},
     {rob_exception_4},
     {rob_exception_3},
     {rob_exception_2},
     {rob_exception_1},
     {rob_exception_0}};	// rob.scala:311:28, :398:49
  wire             can_throw_exception_0 = rob_head_vals_0 & _GEN_10[rob_head];	// rob.scala:224:29, :398:49
  wire             can_commit_0 = rob_head_vals_0 & ~_GEN_6[rob_head] & ~io_csr_stall;	// rob.scala:224:29, :366:31, :398:49, :404:{43,64,67}
  wire [31:0]      _GEN_11 =
    {{rob_predicated_31},
     {rob_predicated_30},
     {rob_predicated_29},
     {rob_predicated_28},
     {rob_predicated_27},
     {rob_predicated_26},
     {rob_predicated_25},
     {rob_predicated_24},
     {rob_predicated_23},
     {rob_predicated_22},
     {rob_predicated_21},
     {rob_predicated_20},
     {rob_predicated_19},
     {rob_predicated_18},
     {rob_predicated_17},
     {rob_predicated_16},
     {rob_predicated_15},
     {rob_predicated_14},
     {rob_predicated_13},
     {rob_predicated_12},
     {rob_predicated_11},
     {rob_predicated_10},
     {rob_predicated_9},
     {rob_predicated_8},
     {rob_predicated_7},
     {rob_predicated_6},
     {rob_predicated_5},
     {rob_predicated_4},
     {rob_predicated_3},
     {rob_predicated_2},
     {rob_predicated_1},
     {rob_predicated_0}};	// rob.scala:312:29, :410:51
  wire [31:0][6:0] _GEN_12 =
    {{rob_uop_31_uopc},
     {rob_uop_30_uopc},
     {rob_uop_29_uopc},
     {rob_uop_28_uopc},
     {rob_uop_27_uopc},
     {rob_uop_26_uopc},
     {rob_uop_25_uopc},
     {rob_uop_24_uopc},
     {rob_uop_23_uopc},
     {rob_uop_22_uopc},
     {rob_uop_21_uopc},
     {rob_uop_20_uopc},
     {rob_uop_19_uopc},
     {rob_uop_18_uopc},
     {rob_uop_17_uopc},
     {rob_uop_16_uopc},
     {rob_uop_15_uopc},
     {rob_uop_14_uopc},
     {rob_uop_13_uopc},
     {rob_uop_12_uopc},
     {rob_uop_11_uopc},
     {rob_uop_10_uopc},
     {rob_uop_9_uopc},
     {rob_uop_8_uopc},
     {rob_uop_7_uopc},
     {rob_uop_6_uopc},
     {rob_uop_5_uopc},
     {rob_uop_4_uopc},
     {rob_uop_3_uopc},
     {rob_uop_2_uopc},
     {rob_uop_1_uopc},
     {rob_uop_0_uopc}};	// rob.scala:310:28, :411:25
  wire [31:0]      _GEN_13 =
    {{rob_uop_31_is_rvc},
     {rob_uop_30_is_rvc},
     {rob_uop_29_is_rvc},
     {rob_uop_28_is_rvc},
     {rob_uop_27_is_rvc},
     {rob_uop_26_is_rvc},
     {rob_uop_25_is_rvc},
     {rob_uop_24_is_rvc},
     {rob_uop_23_is_rvc},
     {rob_uop_22_is_rvc},
     {rob_uop_21_is_rvc},
     {rob_uop_20_is_rvc},
     {rob_uop_19_is_rvc},
     {rob_uop_18_is_rvc},
     {rob_uop_17_is_rvc},
     {rob_uop_16_is_rvc},
     {rob_uop_15_is_rvc},
     {rob_uop_14_is_rvc},
     {rob_uop_13_is_rvc},
     {rob_uop_12_is_rvc},
     {rob_uop_11_is_rvc},
     {rob_uop_10_is_rvc},
     {rob_uop_9_is_rvc},
     {rob_uop_8_is_rvc},
     {rob_uop_7_is_rvc},
     {rob_uop_6_is_rvc},
     {rob_uop_5_is_rvc},
     {rob_uop_4_is_rvc},
     {rob_uop_3_is_rvc},
     {rob_uop_2_is_rvc},
     {rob_uop_1_is_rvc},
     {rob_uop_0_is_rvc}};	// rob.scala:310:28, :411:25
  wire [31:0][4:0] _GEN_14 =
    {{rob_uop_31_ftq_idx},
     {rob_uop_30_ftq_idx},
     {rob_uop_29_ftq_idx},
     {rob_uop_28_ftq_idx},
     {rob_uop_27_ftq_idx},
     {rob_uop_26_ftq_idx},
     {rob_uop_25_ftq_idx},
     {rob_uop_24_ftq_idx},
     {rob_uop_23_ftq_idx},
     {rob_uop_22_ftq_idx},
     {rob_uop_21_ftq_idx},
     {rob_uop_20_ftq_idx},
     {rob_uop_19_ftq_idx},
     {rob_uop_18_ftq_idx},
     {rob_uop_17_ftq_idx},
     {rob_uop_16_ftq_idx},
     {rob_uop_15_ftq_idx},
     {rob_uop_14_ftq_idx},
     {rob_uop_13_ftq_idx},
     {rob_uop_12_ftq_idx},
     {rob_uop_11_ftq_idx},
     {rob_uop_10_ftq_idx},
     {rob_uop_9_ftq_idx},
     {rob_uop_8_ftq_idx},
     {rob_uop_7_ftq_idx},
     {rob_uop_6_ftq_idx},
     {rob_uop_5_ftq_idx},
     {rob_uop_4_ftq_idx},
     {rob_uop_3_ftq_idx},
     {rob_uop_2_ftq_idx},
     {rob_uop_1_ftq_idx},
     {rob_uop_0_ftq_idx}};	// rob.scala:310:28, :411:25
  wire [31:0]      _GEN_15 =
    {{rob_uop_31_edge_inst},
     {rob_uop_30_edge_inst},
     {rob_uop_29_edge_inst},
     {rob_uop_28_edge_inst},
     {rob_uop_27_edge_inst},
     {rob_uop_26_edge_inst},
     {rob_uop_25_edge_inst},
     {rob_uop_24_edge_inst},
     {rob_uop_23_edge_inst},
     {rob_uop_22_edge_inst},
     {rob_uop_21_edge_inst},
     {rob_uop_20_edge_inst},
     {rob_uop_19_edge_inst},
     {rob_uop_18_edge_inst},
     {rob_uop_17_edge_inst},
     {rob_uop_16_edge_inst},
     {rob_uop_15_edge_inst},
     {rob_uop_14_edge_inst},
     {rob_uop_13_edge_inst},
     {rob_uop_12_edge_inst},
     {rob_uop_11_edge_inst},
     {rob_uop_10_edge_inst},
     {rob_uop_9_edge_inst},
     {rob_uop_8_edge_inst},
     {rob_uop_7_edge_inst},
     {rob_uop_6_edge_inst},
     {rob_uop_5_edge_inst},
     {rob_uop_4_edge_inst},
     {rob_uop_3_edge_inst},
     {rob_uop_2_edge_inst},
     {rob_uop_1_edge_inst},
     {rob_uop_0_edge_inst}};	// rob.scala:310:28, :411:25
  wire [31:0][5:0] _GEN_16 =
    {{rob_uop_31_pc_lob},
     {rob_uop_30_pc_lob},
     {rob_uop_29_pc_lob},
     {rob_uop_28_pc_lob},
     {rob_uop_27_pc_lob},
     {rob_uop_26_pc_lob},
     {rob_uop_25_pc_lob},
     {rob_uop_24_pc_lob},
     {rob_uop_23_pc_lob},
     {rob_uop_22_pc_lob},
     {rob_uop_21_pc_lob},
     {rob_uop_20_pc_lob},
     {rob_uop_19_pc_lob},
     {rob_uop_18_pc_lob},
     {rob_uop_17_pc_lob},
     {rob_uop_16_pc_lob},
     {rob_uop_15_pc_lob},
     {rob_uop_14_pc_lob},
     {rob_uop_13_pc_lob},
     {rob_uop_12_pc_lob},
     {rob_uop_11_pc_lob},
     {rob_uop_10_pc_lob},
     {rob_uop_9_pc_lob},
     {rob_uop_8_pc_lob},
     {rob_uop_7_pc_lob},
     {rob_uop_6_pc_lob},
     {rob_uop_5_pc_lob},
     {rob_uop_4_pc_lob},
     {rob_uop_3_pc_lob},
     {rob_uop_2_pc_lob},
     {rob_uop_1_pc_lob},
     {rob_uop_0_pc_lob}};	// rob.scala:310:28, :411:25
  wire [31:0][6:0] _GEN_17 =
    {{rob_uop_31_pdst},
     {rob_uop_30_pdst},
     {rob_uop_29_pdst},
     {rob_uop_28_pdst},
     {rob_uop_27_pdst},
     {rob_uop_26_pdst},
     {rob_uop_25_pdst},
     {rob_uop_24_pdst},
     {rob_uop_23_pdst},
     {rob_uop_22_pdst},
     {rob_uop_21_pdst},
     {rob_uop_20_pdst},
     {rob_uop_19_pdst},
     {rob_uop_18_pdst},
     {rob_uop_17_pdst},
     {rob_uop_16_pdst},
     {rob_uop_15_pdst},
     {rob_uop_14_pdst},
     {rob_uop_13_pdst},
     {rob_uop_12_pdst},
     {rob_uop_11_pdst},
     {rob_uop_10_pdst},
     {rob_uop_9_pdst},
     {rob_uop_8_pdst},
     {rob_uop_7_pdst},
     {rob_uop_6_pdst},
     {rob_uop_5_pdst},
     {rob_uop_4_pdst},
     {rob_uop_3_pdst},
     {rob_uop_2_pdst},
     {rob_uop_1_pdst},
     {rob_uop_0_pdst}};	// rob.scala:310:28, :411:25
  wire [31:0][6:0] _GEN_18 =
    {{rob_uop_31_stale_pdst},
     {rob_uop_30_stale_pdst},
     {rob_uop_29_stale_pdst},
     {rob_uop_28_stale_pdst},
     {rob_uop_27_stale_pdst},
     {rob_uop_26_stale_pdst},
     {rob_uop_25_stale_pdst},
     {rob_uop_24_stale_pdst},
     {rob_uop_23_stale_pdst},
     {rob_uop_22_stale_pdst},
     {rob_uop_21_stale_pdst},
     {rob_uop_20_stale_pdst},
     {rob_uop_19_stale_pdst},
     {rob_uop_18_stale_pdst},
     {rob_uop_17_stale_pdst},
     {rob_uop_16_stale_pdst},
     {rob_uop_15_stale_pdst},
     {rob_uop_14_stale_pdst},
     {rob_uop_13_stale_pdst},
     {rob_uop_12_stale_pdst},
     {rob_uop_11_stale_pdst},
     {rob_uop_10_stale_pdst},
     {rob_uop_9_stale_pdst},
     {rob_uop_8_stale_pdst},
     {rob_uop_7_stale_pdst},
     {rob_uop_6_stale_pdst},
     {rob_uop_5_stale_pdst},
     {rob_uop_4_stale_pdst},
     {rob_uop_3_stale_pdst},
     {rob_uop_2_stale_pdst},
     {rob_uop_1_stale_pdst},
     {rob_uop_0_stale_pdst}};	// rob.scala:310:28, :411:25
  wire [31:0]      _GEN_19 =
    {{rob_uop_31_is_fencei},
     {rob_uop_30_is_fencei},
     {rob_uop_29_is_fencei},
     {rob_uop_28_is_fencei},
     {rob_uop_27_is_fencei},
     {rob_uop_26_is_fencei},
     {rob_uop_25_is_fencei},
     {rob_uop_24_is_fencei},
     {rob_uop_23_is_fencei},
     {rob_uop_22_is_fencei},
     {rob_uop_21_is_fencei},
     {rob_uop_20_is_fencei},
     {rob_uop_19_is_fencei},
     {rob_uop_18_is_fencei},
     {rob_uop_17_is_fencei},
     {rob_uop_16_is_fencei},
     {rob_uop_15_is_fencei},
     {rob_uop_14_is_fencei},
     {rob_uop_13_is_fencei},
     {rob_uop_12_is_fencei},
     {rob_uop_11_is_fencei},
     {rob_uop_10_is_fencei},
     {rob_uop_9_is_fencei},
     {rob_uop_8_is_fencei},
     {rob_uop_7_is_fencei},
     {rob_uop_6_is_fencei},
     {rob_uop_5_is_fencei},
     {rob_uop_4_is_fencei},
     {rob_uop_3_is_fencei},
     {rob_uop_2_is_fencei},
     {rob_uop_1_is_fencei},
     {rob_uop_0_is_fencei}};	// rob.scala:310:28, :411:25
  wire [31:0]      _GEN_20 =
    {{rob_uop_31_uses_ldq},
     {rob_uop_30_uses_ldq},
     {rob_uop_29_uses_ldq},
     {rob_uop_28_uses_ldq},
     {rob_uop_27_uses_ldq},
     {rob_uop_26_uses_ldq},
     {rob_uop_25_uses_ldq},
     {rob_uop_24_uses_ldq},
     {rob_uop_23_uses_ldq},
     {rob_uop_22_uses_ldq},
     {rob_uop_21_uses_ldq},
     {rob_uop_20_uses_ldq},
     {rob_uop_19_uses_ldq},
     {rob_uop_18_uses_ldq},
     {rob_uop_17_uses_ldq},
     {rob_uop_16_uses_ldq},
     {rob_uop_15_uses_ldq},
     {rob_uop_14_uses_ldq},
     {rob_uop_13_uses_ldq},
     {rob_uop_12_uses_ldq},
     {rob_uop_11_uses_ldq},
     {rob_uop_10_uses_ldq},
     {rob_uop_9_uses_ldq},
     {rob_uop_8_uses_ldq},
     {rob_uop_7_uses_ldq},
     {rob_uop_6_uses_ldq},
     {rob_uop_5_uses_ldq},
     {rob_uop_4_uses_ldq},
     {rob_uop_3_uses_ldq},
     {rob_uop_2_uses_ldq},
     {rob_uop_1_uses_ldq},
     {rob_uop_0_uses_ldq}};	// rob.scala:310:28, :411:25
  wire [31:0]      _GEN_21 =
    {{rob_uop_31_uses_stq},
     {rob_uop_30_uses_stq},
     {rob_uop_29_uses_stq},
     {rob_uop_28_uses_stq},
     {rob_uop_27_uses_stq},
     {rob_uop_26_uses_stq},
     {rob_uop_25_uses_stq},
     {rob_uop_24_uses_stq},
     {rob_uop_23_uses_stq},
     {rob_uop_22_uses_stq},
     {rob_uop_21_uses_stq},
     {rob_uop_20_uses_stq},
     {rob_uop_19_uses_stq},
     {rob_uop_18_uses_stq},
     {rob_uop_17_uses_stq},
     {rob_uop_16_uses_stq},
     {rob_uop_15_uses_stq},
     {rob_uop_14_uses_stq},
     {rob_uop_13_uses_stq},
     {rob_uop_12_uses_stq},
     {rob_uop_11_uses_stq},
     {rob_uop_10_uses_stq},
     {rob_uop_9_uses_stq},
     {rob_uop_8_uses_stq},
     {rob_uop_7_uses_stq},
     {rob_uop_6_uses_stq},
     {rob_uop_5_uses_stq},
     {rob_uop_4_uses_stq},
     {rob_uop_3_uses_stq},
     {rob_uop_2_uses_stq},
     {rob_uop_1_uses_stq},
     {rob_uop_0_uses_stq}};	// rob.scala:310:28, :411:25
  wire [31:0]      _GEN_22 =
    {{rob_uop_31_is_sys_pc2epc},
     {rob_uop_30_is_sys_pc2epc},
     {rob_uop_29_is_sys_pc2epc},
     {rob_uop_28_is_sys_pc2epc},
     {rob_uop_27_is_sys_pc2epc},
     {rob_uop_26_is_sys_pc2epc},
     {rob_uop_25_is_sys_pc2epc},
     {rob_uop_24_is_sys_pc2epc},
     {rob_uop_23_is_sys_pc2epc},
     {rob_uop_22_is_sys_pc2epc},
     {rob_uop_21_is_sys_pc2epc},
     {rob_uop_20_is_sys_pc2epc},
     {rob_uop_19_is_sys_pc2epc},
     {rob_uop_18_is_sys_pc2epc},
     {rob_uop_17_is_sys_pc2epc},
     {rob_uop_16_is_sys_pc2epc},
     {rob_uop_15_is_sys_pc2epc},
     {rob_uop_14_is_sys_pc2epc},
     {rob_uop_13_is_sys_pc2epc},
     {rob_uop_12_is_sys_pc2epc},
     {rob_uop_11_is_sys_pc2epc},
     {rob_uop_10_is_sys_pc2epc},
     {rob_uop_9_is_sys_pc2epc},
     {rob_uop_8_is_sys_pc2epc},
     {rob_uop_7_is_sys_pc2epc},
     {rob_uop_6_is_sys_pc2epc},
     {rob_uop_5_is_sys_pc2epc},
     {rob_uop_4_is_sys_pc2epc},
     {rob_uop_3_is_sys_pc2epc},
     {rob_uop_2_is_sys_pc2epc},
     {rob_uop_1_is_sys_pc2epc},
     {rob_uop_0_is_sys_pc2epc}};	// rob.scala:310:28, :411:25
  wire [31:0]      _GEN_23 =
    {{rob_uop_31_flush_on_commit},
     {rob_uop_30_flush_on_commit},
     {rob_uop_29_flush_on_commit},
     {rob_uop_28_flush_on_commit},
     {rob_uop_27_flush_on_commit},
     {rob_uop_26_flush_on_commit},
     {rob_uop_25_flush_on_commit},
     {rob_uop_24_flush_on_commit},
     {rob_uop_23_flush_on_commit},
     {rob_uop_22_flush_on_commit},
     {rob_uop_21_flush_on_commit},
     {rob_uop_20_flush_on_commit},
     {rob_uop_19_flush_on_commit},
     {rob_uop_18_flush_on_commit},
     {rob_uop_17_flush_on_commit},
     {rob_uop_16_flush_on_commit},
     {rob_uop_15_flush_on_commit},
     {rob_uop_14_flush_on_commit},
     {rob_uop_13_flush_on_commit},
     {rob_uop_12_flush_on_commit},
     {rob_uop_11_flush_on_commit},
     {rob_uop_10_flush_on_commit},
     {rob_uop_9_flush_on_commit},
     {rob_uop_8_flush_on_commit},
     {rob_uop_7_flush_on_commit},
     {rob_uop_6_flush_on_commit},
     {rob_uop_5_flush_on_commit},
     {rob_uop_4_flush_on_commit},
     {rob_uop_3_flush_on_commit},
     {rob_uop_2_flush_on_commit},
     {rob_uop_1_flush_on_commit},
     {rob_uop_0_flush_on_commit}};	// rob.scala:310:28, :411:25
  wire [31:0][5:0] _GEN_24 =
    {{rob_uop_31_ldst},
     {rob_uop_30_ldst},
     {rob_uop_29_ldst},
     {rob_uop_28_ldst},
     {rob_uop_27_ldst},
     {rob_uop_26_ldst},
     {rob_uop_25_ldst},
     {rob_uop_24_ldst},
     {rob_uop_23_ldst},
     {rob_uop_22_ldst},
     {rob_uop_21_ldst},
     {rob_uop_20_ldst},
     {rob_uop_19_ldst},
     {rob_uop_18_ldst},
     {rob_uop_17_ldst},
     {rob_uop_16_ldst},
     {rob_uop_15_ldst},
     {rob_uop_14_ldst},
     {rob_uop_13_ldst},
     {rob_uop_12_ldst},
     {rob_uop_11_ldst},
     {rob_uop_10_ldst},
     {rob_uop_9_ldst},
     {rob_uop_8_ldst},
     {rob_uop_7_ldst},
     {rob_uop_6_ldst},
     {rob_uop_5_ldst},
     {rob_uop_4_ldst},
     {rob_uop_3_ldst},
     {rob_uop_2_ldst},
     {rob_uop_1_ldst},
     {rob_uop_0_ldst}};	// rob.scala:310:28, :411:25
  wire [31:0]      _GEN_25 =
    {{rob_uop_31_ldst_val},
     {rob_uop_30_ldst_val},
     {rob_uop_29_ldst_val},
     {rob_uop_28_ldst_val},
     {rob_uop_27_ldst_val},
     {rob_uop_26_ldst_val},
     {rob_uop_25_ldst_val},
     {rob_uop_24_ldst_val},
     {rob_uop_23_ldst_val},
     {rob_uop_22_ldst_val},
     {rob_uop_21_ldst_val},
     {rob_uop_20_ldst_val},
     {rob_uop_19_ldst_val},
     {rob_uop_18_ldst_val},
     {rob_uop_17_ldst_val},
     {rob_uop_16_ldst_val},
     {rob_uop_15_ldst_val},
     {rob_uop_14_ldst_val},
     {rob_uop_13_ldst_val},
     {rob_uop_12_ldst_val},
     {rob_uop_11_ldst_val},
     {rob_uop_10_ldst_val},
     {rob_uop_9_ldst_val},
     {rob_uop_8_ldst_val},
     {rob_uop_7_ldst_val},
     {rob_uop_6_ldst_val},
     {rob_uop_5_ldst_val},
     {rob_uop_4_ldst_val},
     {rob_uop_3_ldst_val},
     {rob_uop_2_ldst_val},
     {rob_uop_1_ldst_val},
     {rob_uop_0_ldst_val}};	// rob.scala:310:28, :411:25
  wire [31:0][1:0] _GEN_26 =
    {{rob_uop_31_dst_rtype},
     {rob_uop_30_dst_rtype},
     {rob_uop_29_dst_rtype},
     {rob_uop_28_dst_rtype},
     {rob_uop_27_dst_rtype},
     {rob_uop_26_dst_rtype},
     {rob_uop_25_dst_rtype},
     {rob_uop_24_dst_rtype},
     {rob_uop_23_dst_rtype},
     {rob_uop_22_dst_rtype},
     {rob_uop_21_dst_rtype},
     {rob_uop_20_dst_rtype},
     {rob_uop_19_dst_rtype},
     {rob_uop_18_dst_rtype},
     {rob_uop_17_dst_rtype},
     {rob_uop_16_dst_rtype},
     {rob_uop_15_dst_rtype},
     {rob_uop_14_dst_rtype},
     {rob_uop_13_dst_rtype},
     {rob_uop_12_dst_rtype},
     {rob_uop_11_dst_rtype},
     {rob_uop_10_dst_rtype},
     {rob_uop_9_dst_rtype},
     {rob_uop_8_dst_rtype},
     {rob_uop_7_dst_rtype},
     {rob_uop_6_dst_rtype},
     {rob_uop_5_dst_rtype},
     {rob_uop_4_dst_rtype},
     {rob_uop_3_dst_rtype},
     {rob_uop_2_dst_rtype},
     {rob_uop_1_dst_rtype},
     {rob_uop_0_dst_rtype}};	// rob.scala:310:28, :411:25
  wire [31:0]      _GEN_27 =
    {{rob_uop_31_fp_val},
     {rob_uop_30_fp_val},
     {rob_uop_29_fp_val},
     {rob_uop_28_fp_val},
     {rob_uop_27_fp_val},
     {rob_uop_26_fp_val},
     {rob_uop_25_fp_val},
     {rob_uop_24_fp_val},
     {rob_uop_23_fp_val},
     {rob_uop_22_fp_val},
     {rob_uop_21_fp_val},
     {rob_uop_20_fp_val},
     {rob_uop_19_fp_val},
     {rob_uop_18_fp_val},
     {rob_uop_17_fp_val},
     {rob_uop_16_fp_val},
     {rob_uop_15_fp_val},
     {rob_uop_14_fp_val},
     {rob_uop_13_fp_val},
     {rob_uop_12_fp_val},
     {rob_uop_11_fp_val},
     {rob_uop_10_fp_val},
     {rob_uop_9_fp_val},
     {rob_uop_8_fp_val},
     {rob_uop_7_fp_val},
     {rob_uop_6_fp_val},
     {rob_uop_5_fp_val},
     {rob_uop_4_fp_val},
     {rob_uop_3_fp_val},
     {rob_uop_2_fp_val},
     {rob_uop_1_fp_val},
     {rob_uop_0_fp_val}};	// rob.scala:310:28, :411:25
  wire             rbk_row = _io_commit_rollback_T_1 & ~full;	// rob.scala:236:31, :425:{44,47}, :787:39
  wire             _io_commit_rbk_valids_0_output = rbk_row & _GEN[com_idx];	// rob.scala:236:20, :324:31, :425:44, :427:40
  reg              rob_val_1_0;	// rob.scala:307:32
  reg              rob_val_1_1;	// rob.scala:307:32
  reg              rob_val_1_2;	// rob.scala:307:32
  reg              rob_val_1_3;	// rob.scala:307:32
  reg              rob_val_1_4;	// rob.scala:307:32
  reg              rob_val_1_5;	// rob.scala:307:32
  reg              rob_val_1_6;	// rob.scala:307:32
  reg              rob_val_1_7;	// rob.scala:307:32
  reg              rob_val_1_8;	// rob.scala:307:32
  reg              rob_val_1_9;	// rob.scala:307:32
  reg              rob_val_1_10;	// rob.scala:307:32
  reg              rob_val_1_11;	// rob.scala:307:32
  reg              rob_val_1_12;	// rob.scala:307:32
  reg              rob_val_1_13;	// rob.scala:307:32
  reg              rob_val_1_14;	// rob.scala:307:32
  reg              rob_val_1_15;	// rob.scala:307:32
  reg              rob_val_1_16;	// rob.scala:307:32
  reg              rob_val_1_17;	// rob.scala:307:32
  reg              rob_val_1_18;	// rob.scala:307:32
  reg              rob_val_1_19;	// rob.scala:307:32
  reg              rob_val_1_20;	// rob.scala:307:32
  reg              rob_val_1_21;	// rob.scala:307:32
  reg              rob_val_1_22;	// rob.scala:307:32
  reg              rob_val_1_23;	// rob.scala:307:32
  reg              rob_val_1_24;	// rob.scala:307:32
  reg              rob_val_1_25;	// rob.scala:307:32
  reg              rob_val_1_26;	// rob.scala:307:32
  reg              rob_val_1_27;	// rob.scala:307:32
  reg              rob_val_1_28;	// rob.scala:307:32
  reg              rob_val_1_29;	// rob.scala:307:32
  reg              rob_val_1_30;	// rob.scala:307:32
  reg              rob_val_1_31;	// rob.scala:307:32
  reg              rob_bsy_1_0;	// rob.scala:308:28
  reg              rob_bsy_1_1;	// rob.scala:308:28
  reg              rob_bsy_1_2;	// rob.scala:308:28
  reg              rob_bsy_1_3;	// rob.scala:308:28
  reg              rob_bsy_1_4;	// rob.scala:308:28
  reg              rob_bsy_1_5;	// rob.scala:308:28
  reg              rob_bsy_1_6;	// rob.scala:308:28
  reg              rob_bsy_1_7;	// rob.scala:308:28
  reg              rob_bsy_1_8;	// rob.scala:308:28
  reg              rob_bsy_1_9;	// rob.scala:308:28
  reg              rob_bsy_1_10;	// rob.scala:308:28
  reg              rob_bsy_1_11;	// rob.scala:308:28
  reg              rob_bsy_1_12;	// rob.scala:308:28
  reg              rob_bsy_1_13;	// rob.scala:308:28
  reg              rob_bsy_1_14;	// rob.scala:308:28
  reg              rob_bsy_1_15;	// rob.scala:308:28
  reg              rob_bsy_1_16;	// rob.scala:308:28
  reg              rob_bsy_1_17;	// rob.scala:308:28
  reg              rob_bsy_1_18;	// rob.scala:308:28
  reg              rob_bsy_1_19;	// rob.scala:308:28
  reg              rob_bsy_1_20;	// rob.scala:308:28
  reg              rob_bsy_1_21;	// rob.scala:308:28
  reg              rob_bsy_1_22;	// rob.scala:308:28
  reg              rob_bsy_1_23;	// rob.scala:308:28
  reg              rob_bsy_1_24;	// rob.scala:308:28
  reg              rob_bsy_1_25;	// rob.scala:308:28
  reg              rob_bsy_1_26;	// rob.scala:308:28
  reg              rob_bsy_1_27;	// rob.scala:308:28
  reg              rob_bsy_1_28;	// rob.scala:308:28
  reg              rob_bsy_1_29;	// rob.scala:308:28
  reg              rob_bsy_1_30;	// rob.scala:308:28
  reg              rob_bsy_1_31;	// rob.scala:308:28
  reg              rob_unsafe_1_0;	// rob.scala:309:28
  reg              rob_unsafe_1_1;	// rob.scala:309:28
  reg              rob_unsafe_1_2;	// rob.scala:309:28
  reg              rob_unsafe_1_3;	// rob.scala:309:28
  reg              rob_unsafe_1_4;	// rob.scala:309:28
  reg              rob_unsafe_1_5;	// rob.scala:309:28
  reg              rob_unsafe_1_6;	// rob.scala:309:28
  reg              rob_unsafe_1_7;	// rob.scala:309:28
  reg              rob_unsafe_1_8;	// rob.scala:309:28
  reg              rob_unsafe_1_9;	// rob.scala:309:28
  reg              rob_unsafe_1_10;	// rob.scala:309:28
  reg              rob_unsafe_1_11;	// rob.scala:309:28
  reg              rob_unsafe_1_12;	// rob.scala:309:28
  reg              rob_unsafe_1_13;	// rob.scala:309:28
  reg              rob_unsafe_1_14;	// rob.scala:309:28
  reg              rob_unsafe_1_15;	// rob.scala:309:28
  reg              rob_unsafe_1_16;	// rob.scala:309:28
  reg              rob_unsafe_1_17;	// rob.scala:309:28
  reg              rob_unsafe_1_18;	// rob.scala:309:28
  reg              rob_unsafe_1_19;	// rob.scala:309:28
  reg              rob_unsafe_1_20;	// rob.scala:309:28
  reg              rob_unsafe_1_21;	// rob.scala:309:28
  reg              rob_unsafe_1_22;	// rob.scala:309:28
  reg              rob_unsafe_1_23;	// rob.scala:309:28
  reg              rob_unsafe_1_24;	// rob.scala:309:28
  reg              rob_unsafe_1_25;	// rob.scala:309:28
  reg              rob_unsafe_1_26;	// rob.scala:309:28
  reg              rob_unsafe_1_27;	// rob.scala:309:28
  reg              rob_unsafe_1_28;	// rob.scala:309:28
  reg              rob_unsafe_1_29;	// rob.scala:309:28
  reg              rob_unsafe_1_30;	// rob.scala:309:28
  reg              rob_unsafe_1_31;	// rob.scala:309:28
  reg  [6:0]       rob_uop_1_0_uopc;	// rob.scala:310:28
  reg              rob_uop_1_0_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_1_0_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_1_0_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_1_0_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_0_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_0_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_0_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_1_0_is_fencei;	// rob.scala:310:28
  reg              rob_uop_1_0_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_1_0_uses_stq;	// rob.scala:310:28
  reg              rob_uop_1_0_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_1_0_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_0_ldst;	// rob.scala:310:28
  reg              rob_uop_1_0_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_1_0_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_1_0_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_1_uopc;	// rob.scala:310:28
  reg              rob_uop_1_1_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_1_1_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_1_1_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_1_1_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_1_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_1_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_1_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_1_1_is_fencei;	// rob.scala:310:28
  reg              rob_uop_1_1_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_1_1_uses_stq;	// rob.scala:310:28
  reg              rob_uop_1_1_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_1_1_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_1_ldst;	// rob.scala:310:28
  reg              rob_uop_1_1_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_1_1_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_1_1_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_2_uopc;	// rob.scala:310:28
  reg              rob_uop_1_2_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_1_2_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_1_2_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_1_2_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_2_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_2_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_2_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_1_2_is_fencei;	// rob.scala:310:28
  reg              rob_uop_1_2_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_1_2_uses_stq;	// rob.scala:310:28
  reg              rob_uop_1_2_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_1_2_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_2_ldst;	// rob.scala:310:28
  reg              rob_uop_1_2_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_1_2_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_1_2_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_3_uopc;	// rob.scala:310:28
  reg              rob_uop_1_3_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_1_3_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_1_3_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_1_3_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_3_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_3_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_3_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_1_3_is_fencei;	// rob.scala:310:28
  reg              rob_uop_1_3_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_1_3_uses_stq;	// rob.scala:310:28
  reg              rob_uop_1_3_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_1_3_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_3_ldst;	// rob.scala:310:28
  reg              rob_uop_1_3_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_1_3_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_1_3_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_4_uopc;	// rob.scala:310:28
  reg              rob_uop_1_4_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_1_4_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_1_4_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_1_4_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_4_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_4_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_4_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_1_4_is_fencei;	// rob.scala:310:28
  reg              rob_uop_1_4_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_1_4_uses_stq;	// rob.scala:310:28
  reg              rob_uop_1_4_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_1_4_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_4_ldst;	// rob.scala:310:28
  reg              rob_uop_1_4_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_1_4_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_1_4_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_5_uopc;	// rob.scala:310:28
  reg              rob_uop_1_5_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_1_5_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_1_5_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_1_5_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_5_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_5_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_5_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_1_5_is_fencei;	// rob.scala:310:28
  reg              rob_uop_1_5_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_1_5_uses_stq;	// rob.scala:310:28
  reg              rob_uop_1_5_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_1_5_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_5_ldst;	// rob.scala:310:28
  reg              rob_uop_1_5_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_1_5_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_1_5_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_6_uopc;	// rob.scala:310:28
  reg              rob_uop_1_6_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_1_6_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_1_6_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_1_6_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_6_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_6_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_6_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_1_6_is_fencei;	// rob.scala:310:28
  reg              rob_uop_1_6_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_1_6_uses_stq;	// rob.scala:310:28
  reg              rob_uop_1_6_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_1_6_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_6_ldst;	// rob.scala:310:28
  reg              rob_uop_1_6_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_1_6_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_1_6_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_7_uopc;	// rob.scala:310:28
  reg              rob_uop_1_7_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_1_7_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_1_7_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_1_7_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_7_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_7_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_7_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_1_7_is_fencei;	// rob.scala:310:28
  reg              rob_uop_1_7_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_1_7_uses_stq;	// rob.scala:310:28
  reg              rob_uop_1_7_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_1_7_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_7_ldst;	// rob.scala:310:28
  reg              rob_uop_1_7_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_1_7_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_1_7_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_8_uopc;	// rob.scala:310:28
  reg              rob_uop_1_8_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_1_8_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_1_8_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_1_8_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_8_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_8_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_8_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_1_8_is_fencei;	// rob.scala:310:28
  reg              rob_uop_1_8_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_1_8_uses_stq;	// rob.scala:310:28
  reg              rob_uop_1_8_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_1_8_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_8_ldst;	// rob.scala:310:28
  reg              rob_uop_1_8_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_1_8_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_1_8_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_9_uopc;	// rob.scala:310:28
  reg              rob_uop_1_9_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_1_9_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_1_9_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_1_9_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_9_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_9_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_9_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_1_9_is_fencei;	// rob.scala:310:28
  reg              rob_uop_1_9_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_1_9_uses_stq;	// rob.scala:310:28
  reg              rob_uop_1_9_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_1_9_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_9_ldst;	// rob.scala:310:28
  reg              rob_uop_1_9_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_1_9_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_1_9_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_10_uopc;	// rob.scala:310:28
  reg              rob_uop_1_10_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_1_10_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_1_10_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_1_10_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_10_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_10_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_10_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_1_10_is_fencei;	// rob.scala:310:28
  reg              rob_uop_1_10_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_1_10_uses_stq;	// rob.scala:310:28
  reg              rob_uop_1_10_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_1_10_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_10_ldst;	// rob.scala:310:28
  reg              rob_uop_1_10_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_1_10_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_1_10_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_11_uopc;	// rob.scala:310:28
  reg              rob_uop_1_11_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_1_11_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_1_11_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_1_11_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_11_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_11_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_11_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_1_11_is_fencei;	// rob.scala:310:28
  reg              rob_uop_1_11_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_1_11_uses_stq;	// rob.scala:310:28
  reg              rob_uop_1_11_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_1_11_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_11_ldst;	// rob.scala:310:28
  reg              rob_uop_1_11_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_1_11_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_1_11_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_12_uopc;	// rob.scala:310:28
  reg              rob_uop_1_12_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_1_12_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_1_12_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_1_12_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_12_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_12_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_12_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_1_12_is_fencei;	// rob.scala:310:28
  reg              rob_uop_1_12_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_1_12_uses_stq;	// rob.scala:310:28
  reg              rob_uop_1_12_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_1_12_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_12_ldst;	// rob.scala:310:28
  reg              rob_uop_1_12_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_1_12_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_1_12_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_13_uopc;	// rob.scala:310:28
  reg              rob_uop_1_13_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_1_13_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_1_13_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_1_13_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_13_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_13_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_13_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_1_13_is_fencei;	// rob.scala:310:28
  reg              rob_uop_1_13_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_1_13_uses_stq;	// rob.scala:310:28
  reg              rob_uop_1_13_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_1_13_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_13_ldst;	// rob.scala:310:28
  reg              rob_uop_1_13_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_1_13_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_1_13_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_14_uopc;	// rob.scala:310:28
  reg              rob_uop_1_14_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_1_14_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_1_14_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_1_14_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_14_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_14_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_14_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_1_14_is_fencei;	// rob.scala:310:28
  reg              rob_uop_1_14_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_1_14_uses_stq;	// rob.scala:310:28
  reg              rob_uop_1_14_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_1_14_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_14_ldst;	// rob.scala:310:28
  reg              rob_uop_1_14_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_1_14_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_1_14_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_15_uopc;	// rob.scala:310:28
  reg              rob_uop_1_15_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_1_15_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_1_15_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_1_15_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_15_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_15_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_15_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_1_15_is_fencei;	// rob.scala:310:28
  reg              rob_uop_1_15_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_1_15_uses_stq;	// rob.scala:310:28
  reg              rob_uop_1_15_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_1_15_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_15_ldst;	// rob.scala:310:28
  reg              rob_uop_1_15_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_1_15_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_1_15_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_16_uopc;	// rob.scala:310:28
  reg              rob_uop_1_16_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_1_16_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_1_16_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_1_16_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_16_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_16_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_16_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_1_16_is_fencei;	// rob.scala:310:28
  reg              rob_uop_1_16_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_1_16_uses_stq;	// rob.scala:310:28
  reg              rob_uop_1_16_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_1_16_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_16_ldst;	// rob.scala:310:28
  reg              rob_uop_1_16_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_1_16_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_1_16_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_17_uopc;	// rob.scala:310:28
  reg              rob_uop_1_17_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_1_17_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_1_17_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_1_17_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_17_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_17_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_17_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_1_17_is_fencei;	// rob.scala:310:28
  reg              rob_uop_1_17_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_1_17_uses_stq;	// rob.scala:310:28
  reg              rob_uop_1_17_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_1_17_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_17_ldst;	// rob.scala:310:28
  reg              rob_uop_1_17_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_1_17_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_1_17_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_18_uopc;	// rob.scala:310:28
  reg              rob_uop_1_18_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_1_18_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_1_18_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_1_18_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_18_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_18_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_18_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_1_18_is_fencei;	// rob.scala:310:28
  reg              rob_uop_1_18_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_1_18_uses_stq;	// rob.scala:310:28
  reg              rob_uop_1_18_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_1_18_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_18_ldst;	// rob.scala:310:28
  reg              rob_uop_1_18_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_1_18_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_1_18_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_19_uopc;	// rob.scala:310:28
  reg              rob_uop_1_19_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_1_19_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_1_19_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_1_19_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_19_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_19_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_19_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_1_19_is_fencei;	// rob.scala:310:28
  reg              rob_uop_1_19_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_1_19_uses_stq;	// rob.scala:310:28
  reg              rob_uop_1_19_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_1_19_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_19_ldst;	// rob.scala:310:28
  reg              rob_uop_1_19_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_1_19_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_1_19_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_20_uopc;	// rob.scala:310:28
  reg              rob_uop_1_20_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_1_20_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_1_20_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_1_20_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_20_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_20_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_20_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_1_20_is_fencei;	// rob.scala:310:28
  reg              rob_uop_1_20_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_1_20_uses_stq;	// rob.scala:310:28
  reg              rob_uop_1_20_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_1_20_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_20_ldst;	// rob.scala:310:28
  reg              rob_uop_1_20_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_1_20_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_1_20_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_21_uopc;	// rob.scala:310:28
  reg              rob_uop_1_21_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_1_21_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_1_21_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_1_21_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_21_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_21_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_21_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_1_21_is_fencei;	// rob.scala:310:28
  reg              rob_uop_1_21_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_1_21_uses_stq;	// rob.scala:310:28
  reg              rob_uop_1_21_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_1_21_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_21_ldst;	// rob.scala:310:28
  reg              rob_uop_1_21_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_1_21_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_1_21_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_22_uopc;	// rob.scala:310:28
  reg              rob_uop_1_22_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_1_22_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_1_22_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_1_22_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_22_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_22_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_22_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_1_22_is_fencei;	// rob.scala:310:28
  reg              rob_uop_1_22_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_1_22_uses_stq;	// rob.scala:310:28
  reg              rob_uop_1_22_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_1_22_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_22_ldst;	// rob.scala:310:28
  reg              rob_uop_1_22_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_1_22_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_1_22_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_23_uopc;	// rob.scala:310:28
  reg              rob_uop_1_23_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_1_23_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_1_23_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_1_23_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_23_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_23_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_23_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_1_23_is_fencei;	// rob.scala:310:28
  reg              rob_uop_1_23_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_1_23_uses_stq;	// rob.scala:310:28
  reg              rob_uop_1_23_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_1_23_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_23_ldst;	// rob.scala:310:28
  reg              rob_uop_1_23_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_1_23_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_1_23_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_24_uopc;	// rob.scala:310:28
  reg              rob_uop_1_24_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_1_24_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_1_24_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_1_24_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_24_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_24_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_24_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_1_24_is_fencei;	// rob.scala:310:28
  reg              rob_uop_1_24_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_1_24_uses_stq;	// rob.scala:310:28
  reg              rob_uop_1_24_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_1_24_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_24_ldst;	// rob.scala:310:28
  reg              rob_uop_1_24_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_1_24_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_1_24_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_25_uopc;	// rob.scala:310:28
  reg              rob_uop_1_25_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_1_25_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_1_25_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_1_25_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_25_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_25_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_25_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_1_25_is_fencei;	// rob.scala:310:28
  reg              rob_uop_1_25_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_1_25_uses_stq;	// rob.scala:310:28
  reg              rob_uop_1_25_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_1_25_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_25_ldst;	// rob.scala:310:28
  reg              rob_uop_1_25_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_1_25_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_1_25_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_26_uopc;	// rob.scala:310:28
  reg              rob_uop_1_26_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_1_26_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_1_26_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_1_26_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_26_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_26_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_26_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_1_26_is_fencei;	// rob.scala:310:28
  reg              rob_uop_1_26_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_1_26_uses_stq;	// rob.scala:310:28
  reg              rob_uop_1_26_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_1_26_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_26_ldst;	// rob.scala:310:28
  reg              rob_uop_1_26_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_1_26_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_1_26_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_27_uopc;	// rob.scala:310:28
  reg              rob_uop_1_27_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_1_27_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_1_27_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_1_27_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_27_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_27_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_27_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_1_27_is_fencei;	// rob.scala:310:28
  reg              rob_uop_1_27_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_1_27_uses_stq;	// rob.scala:310:28
  reg              rob_uop_1_27_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_1_27_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_27_ldst;	// rob.scala:310:28
  reg              rob_uop_1_27_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_1_27_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_1_27_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_28_uopc;	// rob.scala:310:28
  reg              rob_uop_1_28_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_1_28_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_1_28_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_1_28_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_28_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_28_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_28_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_1_28_is_fencei;	// rob.scala:310:28
  reg              rob_uop_1_28_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_1_28_uses_stq;	// rob.scala:310:28
  reg              rob_uop_1_28_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_1_28_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_28_ldst;	// rob.scala:310:28
  reg              rob_uop_1_28_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_1_28_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_1_28_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_29_uopc;	// rob.scala:310:28
  reg              rob_uop_1_29_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_1_29_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_1_29_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_1_29_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_29_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_29_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_29_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_1_29_is_fencei;	// rob.scala:310:28
  reg              rob_uop_1_29_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_1_29_uses_stq;	// rob.scala:310:28
  reg              rob_uop_1_29_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_1_29_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_29_ldst;	// rob.scala:310:28
  reg              rob_uop_1_29_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_1_29_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_1_29_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_30_uopc;	// rob.scala:310:28
  reg              rob_uop_1_30_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_1_30_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_1_30_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_1_30_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_30_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_30_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_30_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_1_30_is_fencei;	// rob.scala:310:28
  reg              rob_uop_1_30_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_1_30_uses_stq;	// rob.scala:310:28
  reg              rob_uop_1_30_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_1_30_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_30_ldst;	// rob.scala:310:28
  reg              rob_uop_1_30_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_1_30_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_1_30_fp_val;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_31_uopc;	// rob.scala:310:28
  reg              rob_uop_1_31_is_rvc;	// rob.scala:310:28
  reg  [11:0]      rob_uop_1_31_br_mask;	// rob.scala:310:28
  reg  [4:0]       rob_uop_1_31_ftq_idx;	// rob.scala:310:28
  reg              rob_uop_1_31_edge_inst;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_31_pc_lob;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_31_pdst;	// rob.scala:310:28
  reg  [6:0]       rob_uop_1_31_stale_pdst;	// rob.scala:310:28
  reg              rob_uop_1_31_is_fencei;	// rob.scala:310:28
  reg              rob_uop_1_31_uses_ldq;	// rob.scala:310:28
  reg              rob_uop_1_31_uses_stq;	// rob.scala:310:28
  reg              rob_uop_1_31_is_sys_pc2epc;	// rob.scala:310:28
  reg              rob_uop_1_31_flush_on_commit;	// rob.scala:310:28
  reg  [5:0]       rob_uop_1_31_ldst;	// rob.scala:310:28
  reg              rob_uop_1_31_ldst_val;	// rob.scala:310:28
  reg  [1:0]       rob_uop_1_31_dst_rtype;	// rob.scala:310:28
  reg              rob_uop_1_31_fp_val;	// rob.scala:310:28
  reg              rob_exception_1_0;	// rob.scala:311:28
  reg              rob_exception_1_1;	// rob.scala:311:28
  reg              rob_exception_1_2;	// rob.scala:311:28
  reg              rob_exception_1_3;	// rob.scala:311:28
  reg              rob_exception_1_4;	// rob.scala:311:28
  reg              rob_exception_1_5;	// rob.scala:311:28
  reg              rob_exception_1_6;	// rob.scala:311:28
  reg              rob_exception_1_7;	// rob.scala:311:28
  reg              rob_exception_1_8;	// rob.scala:311:28
  reg              rob_exception_1_9;	// rob.scala:311:28
  reg              rob_exception_1_10;	// rob.scala:311:28
  reg              rob_exception_1_11;	// rob.scala:311:28
  reg              rob_exception_1_12;	// rob.scala:311:28
  reg              rob_exception_1_13;	// rob.scala:311:28
  reg              rob_exception_1_14;	// rob.scala:311:28
  reg              rob_exception_1_15;	// rob.scala:311:28
  reg              rob_exception_1_16;	// rob.scala:311:28
  reg              rob_exception_1_17;	// rob.scala:311:28
  reg              rob_exception_1_18;	// rob.scala:311:28
  reg              rob_exception_1_19;	// rob.scala:311:28
  reg              rob_exception_1_20;	// rob.scala:311:28
  reg              rob_exception_1_21;	// rob.scala:311:28
  reg              rob_exception_1_22;	// rob.scala:311:28
  reg              rob_exception_1_23;	// rob.scala:311:28
  reg              rob_exception_1_24;	// rob.scala:311:28
  reg              rob_exception_1_25;	// rob.scala:311:28
  reg              rob_exception_1_26;	// rob.scala:311:28
  reg              rob_exception_1_27;	// rob.scala:311:28
  reg              rob_exception_1_28;	// rob.scala:311:28
  reg              rob_exception_1_29;	// rob.scala:311:28
  reg              rob_exception_1_30;	// rob.scala:311:28
  reg              rob_exception_1_31;	// rob.scala:311:28
  reg              rob_predicated_1_0;	// rob.scala:312:29
  reg              rob_predicated_1_1;	// rob.scala:312:29
  reg              rob_predicated_1_2;	// rob.scala:312:29
  reg              rob_predicated_1_3;	// rob.scala:312:29
  reg              rob_predicated_1_4;	// rob.scala:312:29
  reg              rob_predicated_1_5;	// rob.scala:312:29
  reg              rob_predicated_1_6;	// rob.scala:312:29
  reg              rob_predicated_1_7;	// rob.scala:312:29
  reg              rob_predicated_1_8;	// rob.scala:312:29
  reg              rob_predicated_1_9;	// rob.scala:312:29
  reg              rob_predicated_1_10;	// rob.scala:312:29
  reg              rob_predicated_1_11;	// rob.scala:312:29
  reg              rob_predicated_1_12;	// rob.scala:312:29
  reg              rob_predicated_1_13;	// rob.scala:312:29
  reg              rob_predicated_1_14;	// rob.scala:312:29
  reg              rob_predicated_1_15;	// rob.scala:312:29
  reg              rob_predicated_1_16;	// rob.scala:312:29
  reg              rob_predicated_1_17;	// rob.scala:312:29
  reg              rob_predicated_1_18;	// rob.scala:312:29
  reg              rob_predicated_1_19;	// rob.scala:312:29
  reg              rob_predicated_1_20;	// rob.scala:312:29
  reg              rob_predicated_1_21;	// rob.scala:312:29
  reg              rob_predicated_1_22;	// rob.scala:312:29
  reg              rob_predicated_1_23;	// rob.scala:312:29
  reg              rob_predicated_1_24;	// rob.scala:312:29
  reg              rob_predicated_1_25;	// rob.scala:312:29
  reg              rob_predicated_1_26;	// rob.scala:312:29
  reg              rob_predicated_1_27;	// rob.scala:312:29
  reg              rob_predicated_1_28;	// rob.scala:312:29
  reg              rob_predicated_1_29;	// rob.scala:312:29
  reg              rob_predicated_1_30;	// rob.scala:312:29
  reg              rob_predicated_1_31;	// rob.scala:312:29
  wire [31:0]      _GEN_28 =
    {{rob_val_1_31},
     {rob_val_1_30},
     {rob_val_1_29},
     {rob_val_1_28},
     {rob_val_1_27},
     {rob_val_1_26},
     {rob_val_1_25},
     {rob_val_1_24},
     {rob_val_1_23},
     {rob_val_1_22},
     {rob_val_1_21},
     {rob_val_1_20},
     {rob_val_1_19},
     {rob_val_1_18},
     {rob_val_1_17},
     {rob_val_1_16},
     {rob_val_1_15},
     {rob_val_1_14},
     {rob_val_1_13},
     {rob_val_1_12},
     {rob_val_1_11},
     {rob_val_1_10},
     {rob_val_1_9},
     {rob_val_1_8},
     {rob_val_1_7},
     {rob_val_1_6},
     {rob_val_1_5},
     {rob_val_1_4},
     {rob_val_1_3},
     {rob_val_1_2},
     {rob_val_1_1},
     {rob_val_1_0}};	// rob.scala:307:32, :324:31
  wire             rob_tail_vals_1 = _GEN_28[rob_tail];	// rob.scala:228:29, :324:31
  wire             _GEN_29 = io_wb_resps_0_valid & io_wb_resps_0_bits_uop_rob_idx[0];	// rob.scala:272:36, :346:27
  wire             _GEN_30 = io_wb_resps_1_valid & io_wb_resps_1_bits_uop_rob_idx[0];	// rob.scala:272:36, :346:27
  wire             _GEN_31 = io_wb_resps_2_valid & io_wb_resps_2_bits_uop_rob_idx[0];	// rob.scala:272:36, :346:27
  wire             _GEN_32 = io_wb_resps_3_valid & io_wb_resps_3_bits_uop_rob_idx[0];	// rob.scala:272:36, :346:27
  wire             _GEN_33 = io_wb_resps_4_valid & io_wb_resps_4_bits_uop_rob_idx[0];	// rob.scala:272:36, :346:27
  wire             _GEN_34 = io_lsu_clr_bsy_0_valid & io_lsu_clr_bsy_0_bits[0];	// rob.scala:272:36, :361:31
  wire [31:0]      _GEN_35 =
    {{rob_bsy_1_31},
     {rob_bsy_1_30},
     {rob_bsy_1_29},
     {rob_bsy_1_28},
     {rob_bsy_1_27},
     {rob_bsy_1_26},
     {rob_bsy_1_25},
     {rob_bsy_1_24},
     {rob_bsy_1_23},
     {rob_bsy_1_22},
     {rob_bsy_1_21},
     {rob_bsy_1_20},
     {rob_bsy_1_19},
     {rob_bsy_1_18},
     {rob_bsy_1_17},
     {rob_bsy_1_16},
     {rob_bsy_1_15},
     {rob_bsy_1_14},
     {rob_bsy_1_13},
     {rob_bsy_1_12},
     {rob_bsy_1_11},
     {rob_bsy_1_10},
     {rob_bsy_1_9},
     {rob_bsy_1_8},
     {rob_bsy_1_7},
     {rob_bsy_1_6},
     {rob_bsy_1_5},
     {rob_bsy_1_4},
     {rob_bsy_1_3},
     {rob_bsy_1_2},
     {rob_bsy_1_1},
     {rob_bsy_1_0}};	// rob.scala:308:28, :366:31
  wire             _GEN_36 = io_lsu_clr_bsy_1_valid & io_lsu_clr_bsy_1_bits[0];	// rob.scala:272:36, :361:31
  wire             _GEN_37 = io_lxcpt_valid & io_lxcpt_bits_uop_rob_idx[0];	// rob.scala:272:36, :390:26
  wire [31:0]      _GEN_38 =
    {{rob_unsafe_1_31},
     {rob_unsafe_1_30},
     {rob_unsafe_1_29},
     {rob_unsafe_1_28},
     {rob_unsafe_1_27},
     {rob_unsafe_1_26},
     {rob_unsafe_1_25},
     {rob_unsafe_1_24},
     {rob_unsafe_1_23},
     {rob_unsafe_1_22},
     {rob_unsafe_1_21},
     {rob_unsafe_1_20},
     {rob_unsafe_1_19},
     {rob_unsafe_1_18},
     {rob_unsafe_1_17},
     {rob_unsafe_1_16},
     {rob_unsafe_1_15},
     {rob_unsafe_1_14},
     {rob_unsafe_1_13},
     {rob_unsafe_1_12},
     {rob_unsafe_1_11},
     {rob_unsafe_1_10},
     {rob_unsafe_1_9},
     {rob_unsafe_1_8},
     {rob_unsafe_1_7},
     {rob_unsafe_1_6},
     {rob_unsafe_1_5},
     {rob_unsafe_1_4},
     {rob_unsafe_1_3},
     {rob_unsafe_1_2},
     {rob_unsafe_1_1},
     {rob_unsafe_1_0}};	// rob.scala:309:28, :394:15
  wire             rob_head_vals_1 = _GEN_28[rob_head];	// rob.scala:224:29, :324:31, :398:49
  wire [31:0]      _GEN_39 =
    {{rob_exception_1_31},
     {rob_exception_1_30},
     {rob_exception_1_29},
     {rob_exception_1_28},
     {rob_exception_1_27},
     {rob_exception_1_26},
     {rob_exception_1_25},
     {rob_exception_1_24},
     {rob_exception_1_23},
     {rob_exception_1_22},
     {rob_exception_1_21},
     {rob_exception_1_20},
     {rob_exception_1_19},
     {rob_exception_1_18},
     {rob_exception_1_17},
     {rob_exception_1_16},
     {rob_exception_1_15},
     {rob_exception_1_14},
     {rob_exception_1_13},
     {rob_exception_1_12},
     {rob_exception_1_11},
     {rob_exception_1_10},
     {rob_exception_1_9},
     {rob_exception_1_8},
     {rob_exception_1_7},
     {rob_exception_1_6},
     {rob_exception_1_5},
     {rob_exception_1_4},
     {rob_exception_1_3},
     {rob_exception_1_2},
     {rob_exception_1_1},
     {rob_exception_1_0}};	// rob.scala:311:28, :398:49
  wire             can_throw_exception_1 = rob_head_vals_1 & _GEN_39[rob_head];	// rob.scala:224:29, :398:49
  wire [31:0]      _GEN_40 =
    {{rob_predicated_1_31},
     {rob_predicated_1_30},
     {rob_predicated_1_29},
     {rob_predicated_1_28},
     {rob_predicated_1_27},
     {rob_predicated_1_26},
     {rob_predicated_1_25},
     {rob_predicated_1_24},
     {rob_predicated_1_23},
     {rob_predicated_1_22},
     {rob_predicated_1_21},
     {rob_predicated_1_20},
     {rob_predicated_1_19},
     {rob_predicated_1_18},
     {rob_predicated_1_17},
     {rob_predicated_1_16},
     {rob_predicated_1_15},
     {rob_predicated_1_14},
     {rob_predicated_1_13},
     {rob_predicated_1_12},
     {rob_predicated_1_11},
     {rob_predicated_1_10},
     {rob_predicated_1_9},
     {rob_predicated_1_8},
     {rob_predicated_1_7},
     {rob_predicated_1_6},
     {rob_predicated_1_5},
     {rob_predicated_1_4},
     {rob_predicated_1_3},
     {rob_predicated_1_2},
     {rob_predicated_1_1},
     {rob_predicated_1_0}};	// rob.scala:312:29, :410:51
  wire [31:0][6:0] _GEN_41 =
    {{rob_uop_1_31_uopc},
     {rob_uop_1_30_uopc},
     {rob_uop_1_29_uopc},
     {rob_uop_1_28_uopc},
     {rob_uop_1_27_uopc},
     {rob_uop_1_26_uopc},
     {rob_uop_1_25_uopc},
     {rob_uop_1_24_uopc},
     {rob_uop_1_23_uopc},
     {rob_uop_1_22_uopc},
     {rob_uop_1_21_uopc},
     {rob_uop_1_20_uopc},
     {rob_uop_1_19_uopc},
     {rob_uop_1_18_uopc},
     {rob_uop_1_17_uopc},
     {rob_uop_1_16_uopc},
     {rob_uop_1_15_uopc},
     {rob_uop_1_14_uopc},
     {rob_uop_1_13_uopc},
     {rob_uop_1_12_uopc},
     {rob_uop_1_11_uopc},
     {rob_uop_1_10_uopc},
     {rob_uop_1_9_uopc},
     {rob_uop_1_8_uopc},
     {rob_uop_1_7_uopc},
     {rob_uop_1_6_uopc},
     {rob_uop_1_5_uopc},
     {rob_uop_1_4_uopc},
     {rob_uop_1_3_uopc},
     {rob_uop_1_2_uopc},
     {rob_uop_1_1_uopc},
     {rob_uop_1_0_uopc}};	// rob.scala:310:28, :411:25
  wire [31:0]      _GEN_42 =
    {{rob_uop_1_31_is_rvc},
     {rob_uop_1_30_is_rvc},
     {rob_uop_1_29_is_rvc},
     {rob_uop_1_28_is_rvc},
     {rob_uop_1_27_is_rvc},
     {rob_uop_1_26_is_rvc},
     {rob_uop_1_25_is_rvc},
     {rob_uop_1_24_is_rvc},
     {rob_uop_1_23_is_rvc},
     {rob_uop_1_22_is_rvc},
     {rob_uop_1_21_is_rvc},
     {rob_uop_1_20_is_rvc},
     {rob_uop_1_19_is_rvc},
     {rob_uop_1_18_is_rvc},
     {rob_uop_1_17_is_rvc},
     {rob_uop_1_16_is_rvc},
     {rob_uop_1_15_is_rvc},
     {rob_uop_1_14_is_rvc},
     {rob_uop_1_13_is_rvc},
     {rob_uop_1_12_is_rvc},
     {rob_uop_1_11_is_rvc},
     {rob_uop_1_10_is_rvc},
     {rob_uop_1_9_is_rvc},
     {rob_uop_1_8_is_rvc},
     {rob_uop_1_7_is_rvc},
     {rob_uop_1_6_is_rvc},
     {rob_uop_1_5_is_rvc},
     {rob_uop_1_4_is_rvc},
     {rob_uop_1_3_is_rvc},
     {rob_uop_1_2_is_rvc},
     {rob_uop_1_1_is_rvc},
     {rob_uop_1_0_is_rvc}};	// rob.scala:310:28, :411:25
  wire [31:0][4:0] _GEN_43 =
    {{rob_uop_1_31_ftq_idx},
     {rob_uop_1_30_ftq_idx},
     {rob_uop_1_29_ftq_idx},
     {rob_uop_1_28_ftq_idx},
     {rob_uop_1_27_ftq_idx},
     {rob_uop_1_26_ftq_idx},
     {rob_uop_1_25_ftq_idx},
     {rob_uop_1_24_ftq_idx},
     {rob_uop_1_23_ftq_idx},
     {rob_uop_1_22_ftq_idx},
     {rob_uop_1_21_ftq_idx},
     {rob_uop_1_20_ftq_idx},
     {rob_uop_1_19_ftq_idx},
     {rob_uop_1_18_ftq_idx},
     {rob_uop_1_17_ftq_idx},
     {rob_uop_1_16_ftq_idx},
     {rob_uop_1_15_ftq_idx},
     {rob_uop_1_14_ftq_idx},
     {rob_uop_1_13_ftq_idx},
     {rob_uop_1_12_ftq_idx},
     {rob_uop_1_11_ftq_idx},
     {rob_uop_1_10_ftq_idx},
     {rob_uop_1_9_ftq_idx},
     {rob_uop_1_8_ftq_idx},
     {rob_uop_1_7_ftq_idx},
     {rob_uop_1_6_ftq_idx},
     {rob_uop_1_5_ftq_idx},
     {rob_uop_1_4_ftq_idx},
     {rob_uop_1_3_ftq_idx},
     {rob_uop_1_2_ftq_idx},
     {rob_uop_1_1_ftq_idx},
     {rob_uop_1_0_ftq_idx}};	// rob.scala:310:28, :411:25
  wire [31:0]      _GEN_44 =
    {{rob_uop_1_31_edge_inst},
     {rob_uop_1_30_edge_inst},
     {rob_uop_1_29_edge_inst},
     {rob_uop_1_28_edge_inst},
     {rob_uop_1_27_edge_inst},
     {rob_uop_1_26_edge_inst},
     {rob_uop_1_25_edge_inst},
     {rob_uop_1_24_edge_inst},
     {rob_uop_1_23_edge_inst},
     {rob_uop_1_22_edge_inst},
     {rob_uop_1_21_edge_inst},
     {rob_uop_1_20_edge_inst},
     {rob_uop_1_19_edge_inst},
     {rob_uop_1_18_edge_inst},
     {rob_uop_1_17_edge_inst},
     {rob_uop_1_16_edge_inst},
     {rob_uop_1_15_edge_inst},
     {rob_uop_1_14_edge_inst},
     {rob_uop_1_13_edge_inst},
     {rob_uop_1_12_edge_inst},
     {rob_uop_1_11_edge_inst},
     {rob_uop_1_10_edge_inst},
     {rob_uop_1_9_edge_inst},
     {rob_uop_1_8_edge_inst},
     {rob_uop_1_7_edge_inst},
     {rob_uop_1_6_edge_inst},
     {rob_uop_1_5_edge_inst},
     {rob_uop_1_4_edge_inst},
     {rob_uop_1_3_edge_inst},
     {rob_uop_1_2_edge_inst},
     {rob_uop_1_1_edge_inst},
     {rob_uop_1_0_edge_inst}};	// rob.scala:310:28, :411:25
  wire [31:0][5:0] _GEN_45 =
    {{rob_uop_1_31_pc_lob},
     {rob_uop_1_30_pc_lob},
     {rob_uop_1_29_pc_lob},
     {rob_uop_1_28_pc_lob},
     {rob_uop_1_27_pc_lob},
     {rob_uop_1_26_pc_lob},
     {rob_uop_1_25_pc_lob},
     {rob_uop_1_24_pc_lob},
     {rob_uop_1_23_pc_lob},
     {rob_uop_1_22_pc_lob},
     {rob_uop_1_21_pc_lob},
     {rob_uop_1_20_pc_lob},
     {rob_uop_1_19_pc_lob},
     {rob_uop_1_18_pc_lob},
     {rob_uop_1_17_pc_lob},
     {rob_uop_1_16_pc_lob},
     {rob_uop_1_15_pc_lob},
     {rob_uop_1_14_pc_lob},
     {rob_uop_1_13_pc_lob},
     {rob_uop_1_12_pc_lob},
     {rob_uop_1_11_pc_lob},
     {rob_uop_1_10_pc_lob},
     {rob_uop_1_9_pc_lob},
     {rob_uop_1_8_pc_lob},
     {rob_uop_1_7_pc_lob},
     {rob_uop_1_6_pc_lob},
     {rob_uop_1_5_pc_lob},
     {rob_uop_1_4_pc_lob},
     {rob_uop_1_3_pc_lob},
     {rob_uop_1_2_pc_lob},
     {rob_uop_1_1_pc_lob},
     {rob_uop_1_0_pc_lob}};	// rob.scala:310:28, :411:25
  wire [31:0][6:0] _GEN_46 =
    {{rob_uop_1_31_pdst},
     {rob_uop_1_30_pdst},
     {rob_uop_1_29_pdst},
     {rob_uop_1_28_pdst},
     {rob_uop_1_27_pdst},
     {rob_uop_1_26_pdst},
     {rob_uop_1_25_pdst},
     {rob_uop_1_24_pdst},
     {rob_uop_1_23_pdst},
     {rob_uop_1_22_pdst},
     {rob_uop_1_21_pdst},
     {rob_uop_1_20_pdst},
     {rob_uop_1_19_pdst},
     {rob_uop_1_18_pdst},
     {rob_uop_1_17_pdst},
     {rob_uop_1_16_pdst},
     {rob_uop_1_15_pdst},
     {rob_uop_1_14_pdst},
     {rob_uop_1_13_pdst},
     {rob_uop_1_12_pdst},
     {rob_uop_1_11_pdst},
     {rob_uop_1_10_pdst},
     {rob_uop_1_9_pdst},
     {rob_uop_1_8_pdst},
     {rob_uop_1_7_pdst},
     {rob_uop_1_6_pdst},
     {rob_uop_1_5_pdst},
     {rob_uop_1_4_pdst},
     {rob_uop_1_3_pdst},
     {rob_uop_1_2_pdst},
     {rob_uop_1_1_pdst},
     {rob_uop_1_0_pdst}};	// rob.scala:310:28, :411:25
  wire [31:0][6:0] _GEN_47 =
    {{rob_uop_1_31_stale_pdst},
     {rob_uop_1_30_stale_pdst},
     {rob_uop_1_29_stale_pdst},
     {rob_uop_1_28_stale_pdst},
     {rob_uop_1_27_stale_pdst},
     {rob_uop_1_26_stale_pdst},
     {rob_uop_1_25_stale_pdst},
     {rob_uop_1_24_stale_pdst},
     {rob_uop_1_23_stale_pdst},
     {rob_uop_1_22_stale_pdst},
     {rob_uop_1_21_stale_pdst},
     {rob_uop_1_20_stale_pdst},
     {rob_uop_1_19_stale_pdst},
     {rob_uop_1_18_stale_pdst},
     {rob_uop_1_17_stale_pdst},
     {rob_uop_1_16_stale_pdst},
     {rob_uop_1_15_stale_pdst},
     {rob_uop_1_14_stale_pdst},
     {rob_uop_1_13_stale_pdst},
     {rob_uop_1_12_stale_pdst},
     {rob_uop_1_11_stale_pdst},
     {rob_uop_1_10_stale_pdst},
     {rob_uop_1_9_stale_pdst},
     {rob_uop_1_8_stale_pdst},
     {rob_uop_1_7_stale_pdst},
     {rob_uop_1_6_stale_pdst},
     {rob_uop_1_5_stale_pdst},
     {rob_uop_1_4_stale_pdst},
     {rob_uop_1_3_stale_pdst},
     {rob_uop_1_2_stale_pdst},
     {rob_uop_1_1_stale_pdst},
     {rob_uop_1_0_stale_pdst}};	// rob.scala:310:28, :411:25
  wire [31:0]      _GEN_48 =
    {{rob_uop_1_31_is_fencei},
     {rob_uop_1_30_is_fencei},
     {rob_uop_1_29_is_fencei},
     {rob_uop_1_28_is_fencei},
     {rob_uop_1_27_is_fencei},
     {rob_uop_1_26_is_fencei},
     {rob_uop_1_25_is_fencei},
     {rob_uop_1_24_is_fencei},
     {rob_uop_1_23_is_fencei},
     {rob_uop_1_22_is_fencei},
     {rob_uop_1_21_is_fencei},
     {rob_uop_1_20_is_fencei},
     {rob_uop_1_19_is_fencei},
     {rob_uop_1_18_is_fencei},
     {rob_uop_1_17_is_fencei},
     {rob_uop_1_16_is_fencei},
     {rob_uop_1_15_is_fencei},
     {rob_uop_1_14_is_fencei},
     {rob_uop_1_13_is_fencei},
     {rob_uop_1_12_is_fencei},
     {rob_uop_1_11_is_fencei},
     {rob_uop_1_10_is_fencei},
     {rob_uop_1_9_is_fencei},
     {rob_uop_1_8_is_fencei},
     {rob_uop_1_7_is_fencei},
     {rob_uop_1_6_is_fencei},
     {rob_uop_1_5_is_fencei},
     {rob_uop_1_4_is_fencei},
     {rob_uop_1_3_is_fencei},
     {rob_uop_1_2_is_fencei},
     {rob_uop_1_1_is_fencei},
     {rob_uop_1_0_is_fencei}};	// rob.scala:310:28, :411:25
  wire [31:0]      _GEN_49 =
    {{rob_uop_1_31_uses_ldq},
     {rob_uop_1_30_uses_ldq},
     {rob_uop_1_29_uses_ldq},
     {rob_uop_1_28_uses_ldq},
     {rob_uop_1_27_uses_ldq},
     {rob_uop_1_26_uses_ldq},
     {rob_uop_1_25_uses_ldq},
     {rob_uop_1_24_uses_ldq},
     {rob_uop_1_23_uses_ldq},
     {rob_uop_1_22_uses_ldq},
     {rob_uop_1_21_uses_ldq},
     {rob_uop_1_20_uses_ldq},
     {rob_uop_1_19_uses_ldq},
     {rob_uop_1_18_uses_ldq},
     {rob_uop_1_17_uses_ldq},
     {rob_uop_1_16_uses_ldq},
     {rob_uop_1_15_uses_ldq},
     {rob_uop_1_14_uses_ldq},
     {rob_uop_1_13_uses_ldq},
     {rob_uop_1_12_uses_ldq},
     {rob_uop_1_11_uses_ldq},
     {rob_uop_1_10_uses_ldq},
     {rob_uop_1_9_uses_ldq},
     {rob_uop_1_8_uses_ldq},
     {rob_uop_1_7_uses_ldq},
     {rob_uop_1_6_uses_ldq},
     {rob_uop_1_5_uses_ldq},
     {rob_uop_1_4_uses_ldq},
     {rob_uop_1_3_uses_ldq},
     {rob_uop_1_2_uses_ldq},
     {rob_uop_1_1_uses_ldq},
     {rob_uop_1_0_uses_ldq}};	// rob.scala:310:28, :411:25
  wire [31:0]      _GEN_50 =
    {{rob_uop_1_31_uses_stq},
     {rob_uop_1_30_uses_stq},
     {rob_uop_1_29_uses_stq},
     {rob_uop_1_28_uses_stq},
     {rob_uop_1_27_uses_stq},
     {rob_uop_1_26_uses_stq},
     {rob_uop_1_25_uses_stq},
     {rob_uop_1_24_uses_stq},
     {rob_uop_1_23_uses_stq},
     {rob_uop_1_22_uses_stq},
     {rob_uop_1_21_uses_stq},
     {rob_uop_1_20_uses_stq},
     {rob_uop_1_19_uses_stq},
     {rob_uop_1_18_uses_stq},
     {rob_uop_1_17_uses_stq},
     {rob_uop_1_16_uses_stq},
     {rob_uop_1_15_uses_stq},
     {rob_uop_1_14_uses_stq},
     {rob_uop_1_13_uses_stq},
     {rob_uop_1_12_uses_stq},
     {rob_uop_1_11_uses_stq},
     {rob_uop_1_10_uses_stq},
     {rob_uop_1_9_uses_stq},
     {rob_uop_1_8_uses_stq},
     {rob_uop_1_7_uses_stq},
     {rob_uop_1_6_uses_stq},
     {rob_uop_1_5_uses_stq},
     {rob_uop_1_4_uses_stq},
     {rob_uop_1_3_uses_stq},
     {rob_uop_1_2_uses_stq},
     {rob_uop_1_1_uses_stq},
     {rob_uop_1_0_uses_stq}};	// rob.scala:310:28, :411:25
  wire [31:0]      _GEN_51 =
    {{rob_uop_1_31_is_sys_pc2epc},
     {rob_uop_1_30_is_sys_pc2epc},
     {rob_uop_1_29_is_sys_pc2epc},
     {rob_uop_1_28_is_sys_pc2epc},
     {rob_uop_1_27_is_sys_pc2epc},
     {rob_uop_1_26_is_sys_pc2epc},
     {rob_uop_1_25_is_sys_pc2epc},
     {rob_uop_1_24_is_sys_pc2epc},
     {rob_uop_1_23_is_sys_pc2epc},
     {rob_uop_1_22_is_sys_pc2epc},
     {rob_uop_1_21_is_sys_pc2epc},
     {rob_uop_1_20_is_sys_pc2epc},
     {rob_uop_1_19_is_sys_pc2epc},
     {rob_uop_1_18_is_sys_pc2epc},
     {rob_uop_1_17_is_sys_pc2epc},
     {rob_uop_1_16_is_sys_pc2epc},
     {rob_uop_1_15_is_sys_pc2epc},
     {rob_uop_1_14_is_sys_pc2epc},
     {rob_uop_1_13_is_sys_pc2epc},
     {rob_uop_1_12_is_sys_pc2epc},
     {rob_uop_1_11_is_sys_pc2epc},
     {rob_uop_1_10_is_sys_pc2epc},
     {rob_uop_1_9_is_sys_pc2epc},
     {rob_uop_1_8_is_sys_pc2epc},
     {rob_uop_1_7_is_sys_pc2epc},
     {rob_uop_1_6_is_sys_pc2epc},
     {rob_uop_1_5_is_sys_pc2epc},
     {rob_uop_1_4_is_sys_pc2epc},
     {rob_uop_1_3_is_sys_pc2epc},
     {rob_uop_1_2_is_sys_pc2epc},
     {rob_uop_1_1_is_sys_pc2epc},
     {rob_uop_1_0_is_sys_pc2epc}};	// rob.scala:310:28, :411:25
  wire [31:0]      _GEN_52 =
    {{rob_uop_1_31_flush_on_commit},
     {rob_uop_1_30_flush_on_commit},
     {rob_uop_1_29_flush_on_commit},
     {rob_uop_1_28_flush_on_commit},
     {rob_uop_1_27_flush_on_commit},
     {rob_uop_1_26_flush_on_commit},
     {rob_uop_1_25_flush_on_commit},
     {rob_uop_1_24_flush_on_commit},
     {rob_uop_1_23_flush_on_commit},
     {rob_uop_1_22_flush_on_commit},
     {rob_uop_1_21_flush_on_commit},
     {rob_uop_1_20_flush_on_commit},
     {rob_uop_1_19_flush_on_commit},
     {rob_uop_1_18_flush_on_commit},
     {rob_uop_1_17_flush_on_commit},
     {rob_uop_1_16_flush_on_commit},
     {rob_uop_1_15_flush_on_commit},
     {rob_uop_1_14_flush_on_commit},
     {rob_uop_1_13_flush_on_commit},
     {rob_uop_1_12_flush_on_commit},
     {rob_uop_1_11_flush_on_commit},
     {rob_uop_1_10_flush_on_commit},
     {rob_uop_1_9_flush_on_commit},
     {rob_uop_1_8_flush_on_commit},
     {rob_uop_1_7_flush_on_commit},
     {rob_uop_1_6_flush_on_commit},
     {rob_uop_1_5_flush_on_commit},
     {rob_uop_1_4_flush_on_commit},
     {rob_uop_1_3_flush_on_commit},
     {rob_uop_1_2_flush_on_commit},
     {rob_uop_1_1_flush_on_commit},
     {rob_uop_1_0_flush_on_commit}};	// rob.scala:310:28, :411:25
  wire [31:0][5:0] _GEN_53 =
    {{rob_uop_1_31_ldst},
     {rob_uop_1_30_ldst},
     {rob_uop_1_29_ldst},
     {rob_uop_1_28_ldst},
     {rob_uop_1_27_ldst},
     {rob_uop_1_26_ldst},
     {rob_uop_1_25_ldst},
     {rob_uop_1_24_ldst},
     {rob_uop_1_23_ldst},
     {rob_uop_1_22_ldst},
     {rob_uop_1_21_ldst},
     {rob_uop_1_20_ldst},
     {rob_uop_1_19_ldst},
     {rob_uop_1_18_ldst},
     {rob_uop_1_17_ldst},
     {rob_uop_1_16_ldst},
     {rob_uop_1_15_ldst},
     {rob_uop_1_14_ldst},
     {rob_uop_1_13_ldst},
     {rob_uop_1_12_ldst},
     {rob_uop_1_11_ldst},
     {rob_uop_1_10_ldst},
     {rob_uop_1_9_ldst},
     {rob_uop_1_8_ldst},
     {rob_uop_1_7_ldst},
     {rob_uop_1_6_ldst},
     {rob_uop_1_5_ldst},
     {rob_uop_1_4_ldst},
     {rob_uop_1_3_ldst},
     {rob_uop_1_2_ldst},
     {rob_uop_1_1_ldst},
     {rob_uop_1_0_ldst}};	// rob.scala:310:28, :411:25
  wire [31:0]      _GEN_54 =
    {{rob_uop_1_31_ldst_val},
     {rob_uop_1_30_ldst_val},
     {rob_uop_1_29_ldst_val},
     {rob_uop_1_28_ldst_val},
     {rob_uop_1_27_ldst_val},
     {rob_uop_1_26_ldst_val},
     {rob_uop_1_25_ldst_val},
     {rob_uop_1_24_ldst_val},
     {rob_uop_1_23_ldst_val},
     {rob_uop_1_22_ldst_val},
     {rob_uop_1_21_ldst_val},
     {rob_uop_1_20_ldst_val},
     {rob_uop_1_19_ldst_val},
     {rob_uop_1_18_ldst_val},
     {rob_uop_1_17_ldst_val},
     {rob_uop_1_16_ldst_val},
     {rob_uop_1_15_ldst_val},
     {rob_uop_1_14_ldst_val},
     {rob_uop_1_13_ldst_val},
     {rob_uop_1_12_ldst_val},
     {rob_uop_1_11_ldst_val},
     {rob_uop_1_10_ldst_val},
     {rob_uop_1_9_ldst_val},
     {rob_uop_1_8_ldst_val},
     {rob_uop_1_7_ldst_val},
     {rob_uop_1_6_ldst_val},
     {rob_uop_1_5_ldst_val},
     {rob_uop_1_4_ldst_val},
     {rob_uop_1_3_ldst_val},
     {rob_uop_1_2_ldst_val},
     {rob_uop_1_1_ldst_val},
     {rob_uop_1_0_ldst_val}};	// rob.scala:310:28, :411:25
  wire [31:0][1:0] _GEN_55 =
    {{rob_uop_1_31_dst_rtype},
     {rob_uop_1_30_dst_rtype},
     {rob_uop_1_29_dst_rtype},
     {rob_uop_1_28_dst_rtype},
     {rob_uop_1_27_dst_rtype},
     {rob_uop_1_26_dst_rtype},
     {rob_uop_1_25_dst_rtype},
     {rob_uop_1_24_dst_rtype},
     {rob_uop_1_23_dst_rtype},
     {rob_uop_1_22_dst_rtype},
     {rob_uop_1_21_dst_rtype},
     {rob_uop_1_20_dst_rtype},
     {rob_uop_1_19_dst_rtype},
     {rob_uop_1_18_dst_rtype},
     {rob_uop_1_17_dst_rtype},
     {rob_uop_1_16_dst_rtype},
     {rob_uop_1_15_dst_rtype},
     {rob_uop_1_14_dst_rtype},
     {rob_uop_1_13_dst_rtype},
     {rob_uop_1_12_dst_rtype},
     {rob_uop_1_11_dst_rtype},
     {rob_uop_1_10_dst_rtype},
     {rob_uop_1_9_dst_rtype},
     {rob_uop_1_8_dst_rtype},
     {rob_uop_1_7_dst_rtype},
     {rob_uop_1_6_dst_rtype},
     {rob_uop_1_5_dst_rtype},
     {rob_uop_1_4_dst_rtype},
     {rob_uop_1_3_dst_rtype},
     {rob_uop_1_2_dst_rtype},
     {rob_uop_1_1_dst_rtype},
     {rob_uop_1_0_dst_rtype}};	// rob.scala:310:28, :411:25
  wire [31:0]      _GEN_56 =
    {{rob_uop_1_31_fp_val},
     {rob_uop_1_30_fp_val},
     {rob_uop_1_29_fp_val},
     {rob_uop_1_28_fp_val},
     {rob_uop_1_27_fp_val},
     {rob_uop_1_26_fp_val},
     {rob_uop_1_25_fp_val},
     {rob_uop_1_24_fp_val},
     {rob_uop_1_23_fp_val},
     {rob_uop_1_22_fp_val},
     {rob_uop_1_21_fp_val},
     {rob_uop_1_20_fp_val},
     {rob_uop_1_19_fp_val},
     {rob_uop_1_18_fp_val},
     {rob_uop_1_17_fp_val},
     {rob_uop_1_16_fp_val},
     {rob_uop_1_15_fp_val},
     {rob_uop_1_14_fp_val},
     {rob_uop_1_13_fp_val},
     {rob_uop_1_12_fp_val},
     {rob_uop_1_11_fp_val},
     {rob_uop_1_10_fp_val},
     {rob_uop_1_9_fp_val},
     {rob_uop_1_8_fp_val},
     {rob_uop_1_7_fp_val},
     {rob_uop_1_6_fp_val},
     {rob_uop_1_5_fp_val},
     {rob_uop_1_4_fp_val},
     {rob_uop_1_3_fp_val},
     {rob_uop_1_2_fp_val},
     {rob_uop_1_1_fp_val},
     {rob_uop_1_0_fp_val}};	// rob.scala:310:28, :411:25
  wire             rbk_row_1 = _io_commit_rollback_T_1 & ~full;	// rob.scala:236:31, :425:{44,47}, :787:39
  wire             _io_commit_rbk_valids_1_output = rbk_row_1 & _GEN_28[com_idx];	// rob.scala:236:20, :324:31, :425:44, :427:40
  reg              block_commit_REG;	// rob.scala:540:94
  reg              block_commit_REG_1;	// rob.scala:540:131
  reg              block_commit_REG_2;	// rob.scala:540:123
  wire             block_commit =
    rob_state != 2'h1 & rob_state != 2'h3 | block_commit_REG | block_commit_REG_2;	// rob.scala:221:26, :419:36, :540:{33,47,61,94,113,123}
  assign will_commit_0 = can_commit_0 & ~can_throw_exception_0 & ~block_commit;	// rob.scala:398:49, :404:64, :540:113, :545:55, :547:{46,70}
  wire             _GEN_57 =
    rob_head_vals_0 & (~can_commit_0 | can_throw_exception_0) | block_commit;	// rob.scala:398:49, :404:64, :540:113, :548:46, :549:{29,44,72}
  wire             exception_thrown =
    can_throw_exception_1 & ~_GEN_57 & ~will_commit_0 | can_throw_exception_0
    & ~block_commit;	// rob.scala:398:49, :540:113, :545:{52,55,69,72,85}, :547:70, :549:72
  assign will_commit_1 =
    rob_head_vals_1 & ~_GEN_35[rob_head] & ~io_csr_stall & ~can_throw_exception_1
    & ~_GEN_57;	// rob.scala:224:29, :366:31, :398:49, :404:{43,67}, :545:55, :547:{46,70}, :549:72
  wire             _io_flush_bits_flush_typ_T = r_xcpt_uop_exc_cause != 64'h10;	// rob.scala:259:29, :556:50
  wire [4:0]       com_xcpt_uop_ftq_idx =
    rob_head_vals_0 ? _GEN_14[com_idx] : _GEN_43[com_idx];	// Mux.scala:47:69, rob.scala:236:20, :398:49, :411:25
  wire             com_xcpt_uop_edge_inst =
    rob_head_vals_0 ? _GEN_15[com_idx] : _GEN_44[com_idx];	// Mux.scala:47:69, rob.scala:236:20, :398:49, :411:25
  wire [5:0]       com_xcpt_uop_pc_lob =
    rob_head_vals_0 ? _GEN_16[com_idx] : _GEN_45[com_idx];	// Mux.scala:47:69, rob.scala:236:20, :398:49, :411:25
  wire             flush_commit_mask_0 = will_commit_0 & _GEN_23[com_idx];	// rob.scala:236:20, :411:25, :547:70, :571:75
  wire             flush_commit_mask_1 = will_commit_1 & _GEN_52[com_idx];	// rob.scala:236:20, :411:25, :547:70, :571:75
  wire             flush_commit = flush_commit_mask_0 | flush_commit_mask_1;	// rob.scala:571:75, :572:48
  wire             _io_flush_valid_output = exception_thrown | flush_commit;	// rob.scala:545:85, :572:48, :573:36
  wire             _fflags_val_0_T = will_commit_0 & _GEN_27[com_idx];	// rob.scala:236:20, :411:25, :547:70, :601:27
  wire             fflags_val_0 = _fflags_val_0_T & ~_GEN_21[com_idx];	// rob.scala:236:20, :411:25, :601:27, :602:32, :603:7
  wire             _fflags_val_1_T = will_commit_1 & _GEN_56[com_idx];	// rob.scala:236:20, :411:25, :547:70, :601:27
  wire             fflags_val_1 = _fflags_val_1_T & ~_GEN_50[com_idx];	// rob.scala:236:20, :411:25, :601:27, :602:32, :603:7
  reg              r_partial_row;	// rob.scala:677:30
  wire [1:0]       _io_com_load_is_at_rob_head_T = {rob_head_vals_1, rob_head_vals_0};	// rob.scala:398:49, :685:42
  wire             _empty_T = rob_head == rob_tail;	// rob.scala:224:29, :228:29, :686:33
  wire             finished_committing_row =
    (|{will_commit_1, will_commit_0})
    & ({will_commit_1, will_commit_0} ^ _io_com_load_is_at_rob_head_T) == 2'h0
    & ~(r_partial_row & _empty_T & ~maybe_full);	// rob.scala:221:26, :239:29, :547:70, :677:30, :684:{23,30}, :685:{19,26,42,50,59}, :686:{5,33,46,49}
  reg              pnr_maybe_at_tail;	// rob.scala:714:36
  wire             _io_ready_T = rob_state == 2'h1;	// rob.scala:221:26, :540:33, :716:33
  `ifndef SYNTHESIS	// rob.scala:333:14
    always @(posedge clock) begin	// rob.scala:333:14
      automatic logic [5:0] rob_pnr_idx;	// Cat.scala:30:58
      automatic logic       _GEN_58 = io_lxcpt_bits_cause != 5'h10;	// rob.scala:324:31, :392:33
      automatic logic       _GEN_59 =
        ~((will_commit_0 | will_commit_1)
          & (_io_commit_rbk_valids_0_output | _io_commit_rbk_valids_1_output)) | reset;	// rob.scala:427:40, :430:{12,13,40,45,77}, :547:70
      automatic logic       _GEN_60;	// util.scala:363:52
      automatic logic [1:0] _GEN_61 =
        {1'h0, flush_commit_mask_0} + {1'h0, flush_commit_mask_1};	// Bitwise.scala:47:55, rob.scala:370:23, :571:75, :646:23
      rob_pnr_idx = {rob_pnr, rob_pnr_lsb};	// Cat.scala:30:58, rob.scala:232:29, :233:29
      _GEN_60 = rob_pnr_idx < rob_head_idx;	// Cat.scala:30:58, util.scala:363:52
      if (io_enq_valids_0 & ~(~rob_tail_vals_0 | reset)) begin	// rob.scala:324:31, :333:{14,33}
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:333:14
          $error("Assertion failed: [rob] overwriting a valid entry.\n    at rob.scala:333 assert (rob_val(rob_tail) === false.B, \"[rob] overwriting a valid entry.\")\n");	// rob.scala:333:14
        if (`STOP_COND_)	// rob.scala:333:14
          $fatal;	// rob.scala:333:14
      end
      if (io_enq_valids_0 & ~(io_enq_uops_0_rob_idx[5:1] == rob_tail | reset)) begin	// rob.scala:228:29, :334:{14,39,63}
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:334:14
          $error("Assertion failed\n    at rob.scala:334 assert ((io.enq_uops(w).rob_idx >> log2Ceil(coreWidth)) === rob_tail)\n");	// rob.scala:334:14
        if (`STOP_COND_)	// rob.scala:334:14
          $fatal;	// rob.scala:334:14
      end
      if (_GEN_5 & ~(_GEN[io_lsu_clr_bsy_0_bits[5:1]] | reset)) begin	// rob.scala:268:25, :324:31, :361:31, :365:{16,31}
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:365:16
          $error("Assertion failed: [rob] store writing back to invalid entry.\n    at rob.scala:365 assert (rob_val(cidx) === true.B, \"[rob] store writing back to invalid entry.\")\n");	// rob.scala:365:16
        if (`STOP_COND_)	// rob.scala:365:16
          $fatal;	// rob.scala:365:16
      end
      if (_GEN_5 & ~(_GEN_6[io_lsu_clr_bsy_0_bits[5:1]] | reset)) begin	// rob.scala:268:25, :361:31, :366:{16,31}
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:366:16
          $error("Assertion failed: [rob] store writing back to a not-busy entry.\n    at rob.scala:366 assert (rob_bsy(cidx) === true.B, \"[rob] store writing back to a not-busy entry.\")\n");	// rob.scala:366:16
        if (`STOP_COND_)	// rob.scala:366:16
          $fatal;	// rob.scala:366:16
      end
      if (_GEN_7 & ~(_GEN[io_lsu_clr_bsy_1_bits[5:1]] | reset)) begin	// rob.scala:268:25, :324:31, :361:31, :365:{16,31}
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:365:16
          $error("Assertion failed: [rob] store writing back to invalid entry.\n    at rob.scala:365 assert (rob_val(cidx) === true.B, \"[rob] store writing back to invalid entry.\")\n");	// rob.scala:365:16
        if (`STOP_COND_)	// rob.scala:365:16
          $fatal;	// rob.scala:365:16
      end
      if (_GEN_7 & ~(_GEN_6[io_lsu_clr_bsy_1_bits[5:1]] | reset)) begin	// rob.scala:268:25, :361:31, :366:{16,31}
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:366:16
          $error("Assertion failed: [rob] store writing back to a not-busy entry.\n    at rob.scala:366 assert (rob_bsy(cidx) === true.B, \"[rob] store writing back to a not-busy entry.\")\n");	// rob.scala:366:16
        if (`STOP_COND_)	// rob.scala:366:16
          $fatal;	// rob.scala:366:16
      end
      if (_GEN_8 & _GEN_58 & ~(_GEN_9[io_lxcpt_bits_uop_rob_idx[5:1]] | reset)) begin	// rob.scala:268:25, :390:26, :392:33, :394:15
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:394:15
          $error("Assertion failed: An instruction marked as safe is causing an exception\n    at rob.scala:394 assert(rob_unsafe(GetRowIdx(io.lxcpt.bits.uop.rob_idx)),\n");	// rob.scala:394:15
        if (`STOP_COND_)	// rob.scala:394:15
          $fatal;	// rob.scala:394:15
      end
      if (~_GEN_59) begin	// rob.scala:430:12
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:430:12
          $error("Assertion failed: com_valids and rbk_valids are mutually exclusive\n    at rob.scala:430 assert (!(io.commit.valids.reduce(_||_) && io.commit.rbk_valids.reduce(_||_)),\n");	// rob.scala:430:12
        if (`STOP_COND_)	// rob.scala:430:12
          $fatal;	// rob.scala:430:12
      end
      if (~(~(_GEN_0 & ~_GEN[io_wb_resps_0_bits_uop_rob_idx[5:1]]) | reset)) begin	// rob.scala:268:25, :324:31, :346:27, :514:{14,15,72}, :515:16
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:514:14
          $error("Assertion failed: [rob] writeback (0) occurred to an invalid ROB entry.\n    at rob.scala:514 assert (!(io.wb_resps(i).valid && MatchBank(GetBankIdx(rob_idx)) &&\n");	// rob.scala:514:14
        if (`STOP_COND_)	// rob.scala:514:14
          $fatal;	// rob.scala:514:14
      end
      if (~(~(_GEN_0 & ~_GEN_6[io_wb_resps_0_bits_uop_rob_idx[5:1]]) | reset)) begin	// rob.scala:268:25, :346:27, :366:31, :517:{14,15,72}, :518:16
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:517:14
          $error("Assertion failed: [rob] writeback (0) occurred to a not-busy ROB entry.\n    at rob.scala:517 assert (!(io.wb_resps(i).valid && MatchBank(GetBankIdx(rob_idx)) &&\n");	// rob.scala:517:14
        if (`STOP_COND_)	// rob.scala:517:14
          $fatal;	// rob.scala:517:14
      end
      if (~(~(_GEN_0 & _GEN_25[io_wb_resps_0_bits_uop_rob_idx[5:1]]
              & _GEN_17[io_wb_resps_0_bits_uop_rob_idx[5:1]] != io_wb_resps_0_bits_uop_pdst)
            | reset)) begin	// rob.scala:268:25, :346:27, :411:25, :520:{14,15,72}, :521:{34,51}
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:520:14
          $error("Assertion failed: [rob] writeback (0) occurred to the wrong pdst.\n    at rob.scala:520 assert (!(io.wb_resps(i).valid && MatchBank(GetBankIdx(rob_idx)) &&\n");	// rob.scala:520:14
        if (`STOP_COND_)	// rob.scala:520:14
          $fatal;	// rob.scala:520:14
      end
      if (~(~(_GEN_1 & ~_GEN[io_wb_resps_1_bits_uop_rob_idx[5:1]]) | reset)) begin	// rob.scala:268:25, :324:31, :346:27, :514:{14,15,72}, :515:16
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:514:14
          $error("Assertion failed: [rob] writeback (1) occurred to an invalid ROB entry.\n    at rob.scala:514 assert (!(io.wb_resps(i).valid && MatchBank(GetBankIdx(rob_idx)) &&\n");	// rob.scala:514:14
        if (`STOP_COND_)	// rob.scala:514:14
          $fatal;	// rob.scala:514:14
      end
      if (~(~(_GEN_1 & ~_GEN_6[io_wb_resps_1_bits_uop_rob_idx[5:1]]) | reset)) begin	// rob.scala:268:25, :346:27, :366:31, :517:{14,15,72}, :518:16
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:517:14
          $error("Assertion failed: [rob] writeback (1) occurred to a not-busy ROB entry.\n    at rob.scala:517 assert (!(io.wb_resps(i).valid && MatchBank(GetBankIdx(rob_idx)) &&\n");	// rob.scala:517:14
        if (`STOP_COND_)	// rob.scala:517:14
          $fatal;	// rob.scala:517:14
      end
      if (~(~(_GEN_1 & _GEN_25[io_wb_resps_1_bits_uop_rob_idx[5:1]]
              & _GEN_17[io_wb_resps_1_bits_uop_rob_idx[5:1]] != io_wb_resps_1_bits_uop_pdst)
            | reset)) begin	// rob.scala:268:25, :346:27, :411:25, :520:{14,15,72}, :521:{34,51}
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:520:14
          $error("Assertion failed: [rob] writeback (1) occurred to the wrong pdst.\n    at rob.scala:520 assert (!(io.wb_resps(i).valid && MatchBank(GetBankIdx(rob_idx)) &&\n");	// rob.scala:520:14
        if (`STOP_COND_)	// rob.scala:520:14
          $fatal;	// rob.scala:520:14
      end
      if (~(~(_GEN_2 & ~_GEN[io_wb_resps_2_bits_uop_rob_idx[5:1]]) | reset)) begin	// rob.scala:268:25, :324:31, :346:27, :514:{14,15,72}, :515:16
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:514:14
          $error("Assertion failed: [rob] writeback (2) occurred to an invalid ROB entry.\n    at rob.scala:514 assert (!(io.wb_resps(i).valid && MatchBank(GetBankIdx(rob_idx)) &&\n");	// rob.scala:514:14
        if (`STOP_COND_)	// rob.scala:514:14
          $fatal;	// rob.scala:514:14
      end
      if (~(~(_GEN_2 & ~_GEN_6[io_wb_resps_2_bits_uop_rob_idx[5:1]]) | reset)) begin	// rob.scala:268:25, :346:27, :366:31, :517:{14,15,72}, :518:16
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:517:14
          $error("Assertion failed: [rob] writeback (2) occurred to a not-busy ROB entry.\n    at rob.scala:517 assert (!(io.wb_resps(i).valid && MatchBank(GetBankIdx(rob_idx)) &&\n");	// rob.scala:517:14
        if (`STOP_COND_)	// rob.scala:517:14
          $fatal;	// rob.scala:517:14
      end
      if (~(~(_GEN_2 & _GEN_25[io_wb_resps_2_bits_uop_rob_idx[5:1]]
              & _GEN_17[io_wb_resps_2_bits_uop_rob_idx[5:1]] != io_wb_resps_2_bits_uop_pdst)
            | reset)) begin	// rob.scala:268:25, :346:27, :411:25, :520:{14,15,72}, :521:{34,51}
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:520:14
          $error("Assertion failed: [rob] writeback (2) occurred to the wrong pdst.\n    at rob.scala:520 assert (!(io.wb_resps(i).valid && MatchBank(GetBankIdx(rob_idx)) &&\n");	// rob.scala:520:14
        if (`STOP_COND_)	// rob.scala:520:14
          $fatal;	// rob.scala:520:14
      end
      if (~(~(_GEN_3 & ~_GEN[io_wb_resps_3_bits_uop_rob_idx[5:1]]) | reset)) begin	// rob.scala:268:25, :324:31, :346:27, :514:{14,15,72}, :515:16
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:514:14
          $error("Assertion failed: [rob] writeback (3) occurred to an invalid ROB entry.\n    at rob.scala:514 assert (!(io.wb_resps(i).valid && MatchBank(GetBankIdx(rob_idx)) &&\n");	// rob.scala:514:14
        if (`STOP_COND_)	// rob.scala:514:14
          $fatal;	// rob.scala:514:14
      end
      if (~(~(_GEN_3 & ~_GEN_6[io_wb_resps_3_bits_uop_rob_idx[5:1]]) | reset)) begin	// rob.scala:268:25, :346:27, :366:31, :517:{14,15,72}, :518:16
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:517:14
          $error("Assertion failed: [rob] writeback (3) occurred to a not-busy ROB entry.\n    at rob.scala:517 assert (!(io.wb_resps(i).valid && MatchBank(GetBankIdx(rob_idx)) &&\n");	// rob.scala:517:14
        if (`STOP_COND_)	// rob.scala:517:14
          $fatal;	// rob.scala:517:14
      end
      if (~(~(_GEN_3 & _GEN_25[io_wb_resps_3_bits_uop_rob_idx[5:1]]
              & _GEN_17[io_wb_resps_3_bits_uop_rob_idx[5:1]] != io_wb_resps_3_bits_uop_pdst)
            | reset)) begin	// rob.scala:268:25, :346:27, :411:25, :520:{14,15,72}, :521:{34,51}
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:520:14
          $error("Assertion failed: [rob] writeback (3) occurred to the wrong pdst.\n    at rob.scala:520 assert (!(io.wb_resps(i).valid && MatchBank(GetBankIdx(rob_idx)) &&\n");	// rob.scala:520:14
        if (`STOP_COND_)	// rob.scala:520:14
          $fatal;	// rob.scala:520:14
      end
      if (~(~(_GEN_4 & ~_GEN[io_wb_resps_4_bits_uop_rob_idx[5:1]]) | reset)) begin	// rob.scala:268:25, :324:31, :346:27, :514:{14,15,72}, :515:16
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:514:14
          $error("Assertion failed: [rob] writeback (4) occurred to an invalid ROB entry.\n    at rob.scala:514 assert (!(io.wb_resps(i).valid && MatchBank(GetBankIdx(rob_idx)) &&\n");	// rob.scala:514:14
        if (`STOP_COND_)	// rob.scala:514:14
          $fatal;	// rob.scala:514:14
      end
      if (~(~(_GEN_4 & ~_GEN_6[io_wb_resps_4_bits_uop_rob_idx[5:1]]) | reset)) begin	// rob.scala:268:25, :346:27, :366:31, :517:{14,15,72}, :518:16
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:517:14
          $error("Assertion failed: [rob] writeback (4) occurred to a not-busy ROB entry.\n    at rob.scala:517 assert (!(io.wb_resps(i).valid && MatchBank(GetBankIdx(rob_idx)) &&\n");	// rob.scala:517:14
        if (`STOP_COND_)	// rob.scala:517:14
          $fatal;	// rob.scala:517:14
      end
      if (~(~(_GEN_4 & _GEN_25[io_wb_resps_4_bits_uop_rob_idx[5:1]]
              & _GEN_17[io_wb_resps_4_bits_uop_rob_idx[5:1]] != io_wb_resps_4_bits_uop_pdst)
            | reset)) begin	// rob.scala:268:25, :346:27, :411:25, :520:{14,15,72}, :521:{34,51}
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:520:14
          $error("Assertion failed: [rob] writeback (4) occurred to the wrong pdst.\n    at rob.scala:520 assert (!(io.wb_resps(i).valid && MatchBank(GetBankIdx(rob_idx)) &&\n");	// rob.scala:520:14
        if (`STOP_COND_)	// rob.scala:520:14
          $fatal;	// rob.scala:520:14
      end
      if (io_enq_valids_1 & ~(~rob_tail_vals_1 | reset)) begin	// rob.scala:324:31, :333:{14,33}
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:333:14
          $error("Assertion failed: [rob] overwriting a valid entry.\n    at rob.scala:333 assert (rob_val(rob_tail) === false.B, \"[rob] overwriting a valid entry.\")\n");	// rob.scala:333:14
        if (`STOP_COND_)	// rob.scala:333:14
          $fatal;	// rob.scala:333:14
      end
      if (io_enq_valids_1 & ~(io_enq_uops_1_rob_idx[5:1] == rob_tail | reset)) begin	// rob.scala:228:29, :334:{14,39,63}
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:334:14
          $error("Assertion failed\n    at rob.scala:334 assert ((io.enq_uops(w).rob_idx >> log2Ceil(coreWidth)) === rob_tail)\n");	// rob.scala:334:14
        if (`STOP_COND_)	// rob.scala:334:14
          $fatal;	// rob.scala:334:14
      end
      if (_GEN_34 & ~(_GEN_28[io_lsu_clr_bsy_0_bits[5:1]] | reset)) begin	// rob.scala:268:25, :324:31, :361:31, :365:{16,31}
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:365:16
          $error("Assertion failed: [rob] store writing back to invalid entry.\n    at rob.scala:365 assert (rob_val(cidx) === true.B, \"[rob] store writing back to invalid entry.\")\n");	// rob.scala:365:16
        if (`STOP_COND_)	// rob.scala:365:16
          $fatal;	// rob.scala:365:16
      end
      if (_GEN_34 & ~(_GEN_35[io_lsu_clr_bsy_0_bits[5:1]] | reset)) begin	// rob.scala:268:25, :361:31, :366:{16,31}
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:366:16
          $error("Assertion failed: [rob] store writing back to a not-busy entry.\n    at rob.scala:366 assert (rob_bsy(cidx) === true.B, \"[rob] store writing back to a not-busy entry.\")\n");	// rob.scala:366:16
        if (`STOP_COND_)	// rob.scala:366:16
          $fatal;	// rob.scala:366:16
      end
      if (_GEN_36 & ~(_GEN_28[io_lsu_clr_bsy_1_bits[5:1]] | reset)) begin	// rob.scala:268:25, :324:31, :361:31, :365:{16,31}
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:365:16
          $error("Assertion failed: [rob] store writing back to invalid entry.\n    at rob.scala:365 assert (rob_val(cidx) === true.B, \"[rob] store writing back to invalid entry.\")\n");	// rob.scala:365:16
        if (`STOP_COND_)	// rob.scala:365:16
          $fatal;	// rob.scala:365:16
      end
      if (_GEN_36 & ~(_GEN_35[io_lsu_clr_bsy_1_bits[5:1]] | reset)) begin	// rob.scala:268:25, :361:31, :366:{16,31}
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:366:16
          $error("Assertion failed: [rob] store writing back to a not-busy entry.\n    at rob.scala:366 assert (rob_bsy(cidx) === true.B, \"[rob] store writing back to a not-busy entry.\")\n");	// rob.scala:366:16
        if (`STOP_COND_)	// rob.scala:366:16
          $fatal;	// rob.scala:366:16
      end
      if (_GEN_37 & _GEN_58 & ~(_GEN_38[io_lxcpt_bits_uop_rob_idx[5:1]] | reset)) begin	// rob.scala:268:25, :390:26, :392:33, :394:15
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:394:15
          $error("Assertion failed: An instruction marked as safe is causing an exception\n    at rob.scala:394 assert(rob_unsafe(GetRowIdx(io.lxcpt.bits.uop.rob_idx)),\n");	// rob.scala:394:15
        if (`STOP_COND_)	// rob.scala:394:15
          $fatal;	// rob.scala:394:15
      end
      if (~_GEN_59) begin	// rob.scala:430:12
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:430:12
          $error("Assertion failed: com_valids and rbk_valids are mutually exclusive\n    at rob.scala:430 assert (!(io.commit.valids.reduce(_||_) && io.commit.rbk_valids.reduce(_||_)),\n");	// rob.scala:430:12
        if (`STOP_COND_)	// rob.scala:430:12
          $fatal;	// rob.scala:430:12
      end
      if (~(~(_GEN_29 & ~_GEN_28[io_wb_resps_0_bits_uop_rob_idx[5:1]]) | reset)) begin	// rob.scala:268:25, :324:31, :346:27, :514:{14,15,72}, :515:16
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:514:14
          $error("Assertion failed: [rob] writeback (0) occurred to an invalid ROB entry.\n    at rob.scala:514 assert (!(io.wb_resps(i).valid && MatchBank(GetBankIdx(rob_idx)) &&\n");	// rob.scala:514:14
        if (`STOP_COND_)	// rob.scala:514:14
          $fatal;	// rob.scala:514:14
      end
      if (~(~(_GEN_29 & ~_GEN_35[io_wb_resps_0_bits_uop_rob_idx[5:1]]) | reset)) begin	// rob.scala:268:25, :346:27, :366:31, :517:{14,15,72}, :518:16
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:517:14
          $error("Assertion failed: [rob] writeback (0) occurred to a not-busy ROB entry.\n    at rob.scala:517 assert (!(io.wb_resps(i).valid && MatchBank(GetBankIdx(rob_idx)) &&\n");	// rob.scala:517:14
        if (`STOP_COND_)	// rob.scala:517:14
          $fatal;	// rob.scala:517:14
      end
      if (~(~(_GEN_29 & _GEN_54[io_wb_resps_0_bits_uop_rob_idx[5:1]]
              & _GEN_46[io_wb_resps_0_bits_uop_rob_idx[5:1]] != io_wb_resps_0_bits_uop_pdst)
            | reset)) begin	// rob.scala:268:25, :346:27, :411:25, :520:{14,15,72}, :521:{34,51}
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:520:14
          $error("Assertion failed: [rob] writeback (0) occurred to the wrong pdst.\n    at rob.scala:520 assert (!(io.wb_resps(i).valid && MatchBank(GetBankIdx(rob_idx)) &&\n");	// rob.scala:520:14
        if (`STOP_COND_)	// rob.scala:520:14
          $fatal;	// rob.scala:520:14
      end
      if (~(~(_GEN_30 & ~_GEN_28[io_wb_resps_1_bits_uop_rob_idx[5:1]]) | reset)) begin	// rob.scala:268:25, :324:31, :346:27, :514:{14,15,72}, :515:16
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:514:14
          $error("Assertion failed: [rob] writeback (1) occurred to an invalid ROB entry.\n    at rob.scala:514 assert (!(io.wb_resps(i).valid && MatchBank(GetBankIdx(rob_idx)) &&\n");	// rob.scala:514:14
        if (`STOP_COND_)	// rob.scala:514:14
          $fatal;	// rob.scala:514:14
      end
      if (~(~(_GEN_30 & ~_GEN_35[io_wb_resps_1_bits_uop_rob_idx[5:1]]) | reset)) begin	// rob.scala:268:25, :346:27, :366:31, :517:{14,15,72}, :518:16
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:517:14
          $error("Assertion failed: [rob] writeback (1) occurred to a not-busy ROB entry.\n    at rob.scala:517 assert (!(io.wb_resps(i).valid && MatchBank(GetBankIdx(rob_idx)) &&\n");	// rob.scala:517:14
        if (`STOP_COND_)	// rob.scala:517:14
          $fatal;	// rob.scala:517:14
      end
      if (~(~(_GEN_30 & _GEN_54[io_wb_resps_1_bits_uop_rob_idx[5:1]]
              & _GEN_46[io_wb_resps_1_bits_uop_rob_idx[5:1]] != io_wb_resps_1_bits_uop_pdst)
            | reset)) begin	// rob.scala:268:25, :346:27, :411:25, :520:{14,15,72}, :521:{34,51}
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:520:14
          $error("Assertion failed: [rob] writeback (1) occurred to the wrong pdst.\n    at rob.scala:520 assert (!(io.wb_resps(i).valid && MatchBank(GetBankIdx(rob_idx)) &&\n");	// rob.scala:520:14
        if (`STOP_COND_)	// rob.scala:520:14
          $fatal;	// rob.scala:520:14
      end
      if (~(~(_GEN_31 & ~_GEN_28[io_wb_resps_2_bits_uop_rob_idx[5:1]]) | reset)) begin	// rob.scala:268:25, :324:31, :346:27, :514:{14,15,72}, :515:16
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:514:14
          $error("Assertion failed: [rob] writeback (2) occurred to an invalid ROB entry.\n    at rob.scala:514 assert (!(io.wb_resps(i).valid && MatchBank(GetBankIdx(rob_idx)) &&\n");	// rob.scala:514:14
        if (`STOP_COND_)	// rob.scala:514:14
          $fatal;	// rob.scala:514:14
      end
      if (~(~(_GEN_31 & ~_GEN_35[io_wb_resps_2_bits_uop_rob_idx[5:1]]) | reset)) begin	// rob.scala:268:25, :346:27, :366:31, :517:{14,15,72}, :518:16
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:517:14
          $error("Assertion failed: [rob] writeback (2) occurred to a not-busy ROB entry.\n    at rob.scala:517 assert (!(io.wb_resps(i).valid && MatchBank(GetBankIdx(rob_idx)) &&\n");	// rob.scala:517:14
        if (`STOP_COND_)	// rob.scala:517:14
          $fatal;	// rob.scala:517:14
      end
      if (~(~(_GEN_31 & _GEN_54[io_wb_resps_2_bits_uop_rob_idx[5:1]]
              & _GEN_46[io_wb_resps_2_bits_uop_rob_idx[5:1]] != io_wb_resps_2_bits_uop_pdst)
            | reset)) begin	// rob.scala:268:25, :346:27, :411:25, :520:{14,15,72}, :521:{34,51}
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:520:14
          $error("Assertion failed: [rob] writeback (2) occurred to the wrong pdst.\n    at rob.scala:520 assert (!(io.wb_resps(i).valid && MatchBank(GetBankIdx(rob_idx)) &&\n");	// rob.scala:520:14
        if (`STOP_COND_)	// rob.scala:520:14
          $fatal;	// rob.scala:520:14
      end
      if (~(~(_GEN_32 & ~_GEN_28[io_wb_resps_3_bits_uop_rob_idx[5:1]]) | reset)) begin	// rob.scala:268:25, :324:31, :346:27, :514:{14,15,72}, :515:16
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:514:14
          $error("Assertion failed: [rob] writeback (3) occurred to an invalid ROB entry.\n    at rob.scala:514 assert (!(io.wb_resps(i).valid && MatchBank(GetBankIdx(rob_idx)) &&\n");	// rob.scala:514:14
        if (`STOP_COND_)	// rob.scala:514:14
          $fatal;	// rob.scala:514:14
      end
      if (~(~(_GEN_32 & ~_GEN_35[io_wb_resps_3_bits_uop_rob_idx[5:1]]) | reset)) begin	// rob.scala:268:25, :346:27, :366:31, :517:{14,15,72}, :518:16
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:517:14
          $error("Assertion failed: [rob] writeback (3) occurred to a not-busy ROB entry.\n    at rob.scala:517 assert (!(io.wb_resps(i).valid && MatchBank(GetBankIdx(rob_idx)) &&\n");	// rob.scala:517:14
        if (`STOP_COND_)	// rob.scala:517:14
          $fatal;	// rob.scala:517:14
      end
      if (~(~(_GEN_32 & _GEN_54[io_wb_resps_3_bits_uop_rob_idx[5:1]]
              & _GEN_46[io_wb_resps_3_bits_uop_rob_idx[5:1]] != io_wb_resps_3_bits_uop_pdst)
            | reset)) begin	// rob.scala:268:25, :346:27, :411:25, :520:{14,15,72}, :521:{34,51}
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:520:14
          $error("Assertion failed: [rob] writeback (3) occurred to the wrong pdst.\n    at rob.scala:520 assert (!(io.wb_resps(i).valid && MatchBank(GetBankIdx(rob_idx)) &&\n");	// rob.scala:520:14
        if (`STOP_COND_)	// rob.scala:520:14
          $fatal;	// rob.scala:520:14
      end
      if (~(~(_GEN_33 & ~_GEN_28[io_wb_resps_4_bits_uop_rob_idx[5:1]]) | reset)) begin	// rob.scala:268:25, :324:31, :346:27, :514:{14,15,72}, :515:16
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:514:14
          $error("Assertion failed: [rob] writeback (4) occurred to an invalid ROB entry.\n    at rob.scala:514 assert (!(io.wb_resps(i).valid && MatchBank(GetBankIdx(rob_idx)) &&\n");	// rob.scala:514:14
        if (`STOP_COND_)	// rob.scala:514:14
          $fatal;	// rob.scala:514:14
      end
      if (~(~(_GEN_33 & ~_GEN_35[io_wb_resps_4_bits_uop_rob_idx[5:1]]) | reset)) begin	// rob.scala:268:25, :346:27, :366:31, :517:{14,15,72}, :518:16
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:517:14
          $error("Assertion failed: [rob] writeback (4) occurred to a not-busy ROB entry.\n    at rob.scala:517 assert (!(io.wb_resps(i).valid && MatchBank(GetBankIdx(rob_idx)) &&\n");	// rob.scala:517:14
        if (`STOP_COND_)	// rob.scala:517:14
          $fatal;	// rob.scala:517:14
      end
      if (~(~(_GEN_33 & _GEN_54[io_wb_resps_4_bits_uop_rob_idx[5:1]]
              & _GEN_46[io_wb_resps_4_bits_uop_rob_idx[5:1]] != io_wb_resps_4_bits_uop_pdst)
            | reset)) begin	// rob.scala:268:25, :346:27, :411:25, :520:{14,15,72}, :521:{34,51}
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:520:14
          $error("Assertion failed: [rob] writeback (4) occurred to the wrong pdst.\n    at rob.scala:520 assert (!(io.wb_resps(i).valid && MatchBank(GetBankIdx(rob_idx)) &&\n");	// rob.scala:520:14
        if (`STOP_COND_)	// rob.scala:520:14
          $fatal;	// rob.scala:520:14
      end
      if (~(~(_GEN_61[1]) | reset)) begin	// Bitwise.scala:47:55, rob.scala:575:{9,10,40}
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:575:9
          $error("Assertion failed: [rob] Can't commit multiple flush_on_commit instructions on one cycle\n    at rob.scala:575 assert(!(PopCount(flush_commit_mask) > 1.U),\n");	// rob.scala:575:9
        if (`STOP_COND_)	// rob.scala:575:9
          $fatal;	// rob.scala:575:9
      end
      if (~(~(will_commit_0 & ~_GEN_27[com_idx] & (|_rob_fflags_ext_R0_data))
            | reset)) begin	// rob.scala:236:20, :313:28, :411:25, :547:70, :607:{12,13}, :608:{14,40}, :609:33
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:607:12
          $error("Assertion failed: Committed non-FP instruction has non-zero fflag bits.\n    at rob.scala:607 assert (!(io.commit.valids(w) &&\n");	// rob.scala:607:12
        if (`STOP_COND_)	// rob.scala:607:12
          $fatal;	// rob.scala:607:12
      end
      if (~(~(_fflags_val_0_T & (_GEN_20[com_idx] | _GEN_21[com_idx])
              & (|_rob_fflags_ext_R0_data)) | reset)) begin	// rob.scala:236:20, :313:28, :411:25, :601:27, :609:33, :611:{12,13}, :613:{42,73}
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:611:12
          $error("Assertion failed: Committed FP load or store has non-zero fflag bits.\n    at rob.scala:611 assert (!(io.commit.valids(w) &&\n");	// rob.scala:611:12
        if (`STOP_COND_)	// rob.scala:611:12
          $fatal;	// rob.scala:611:12
      end
      if (~(~(will_commit_1 & ~_GEN_56[com_idx] & (|_rob_fflags_1_ext_R0_data))
            | reset)) begin	// rob.scala:236:20, :313:28, :411:25, :547:70, :607:{12,13}, :608:{14,40}, :609:33
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:607:12
          $error("Assertion failed: Committed non-FP instruction has non-zero fflag bits.\n    at rob.scala:607 assert (!(io.commit.valids(w) &&\n");	// rob.scala:607:12
        if (`STOP_COND_)	// rob.scala:607:12
          $fatal;	// rob.scala:607:12
      end
      if (~(~(_fflags_val_1_T & (_GEN_49[com_idx] | _GEN_50[com_idx])
              & (|_rob_fflags_1_ext_R0_data)) | reset)) begin	// rob.scala:236:20, :313:28, :411:25, :601:27, :609:33, :611:{12,13}, :613:{42,73}
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:611:12
          $error("Assertion failed: Committed FP load or store has non-zero fflag bits.\n    at rob.scala:611 assert (!(io.commit.valids(w) &&\n");	// rob.scala:611:12
        if (`STOP_COND_)	// rob.scala:611:12
          $fatal;	// rob.scala:611:12
      end
      if (~(~(exception_thrown & ~r_xcpt_val) | reset)) begin	// rob.scala:258:33, :545:85, :658:{10,11,30,33}
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:658:10
          $error("Assertion failed: ROB trying to throw an exception, but it doesn't have a valid xcpt_cause\n    at rob.scala:658 assert (!(exception_thrown && !r_xcpt_val),\n");	// rob.scala:658:10
        if (`STOP_COND_)	// rob.scala:658:10
          $fatal;	// rob.scala:658:10
      end
      if (~(~(empty & r_xcpt_val) | reset)) begin	// rob.scala:258:33, :661:{10,11,19}, :788:41
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:661:10
          $error("Assertion failed: ROB is empty, but believes it has an outstanding exception.\n    at rob.scala:661 assert (!(empty && r_xcpt_val),\n");	// rob.scala:661:10
        if (`STOP_COND_)	// rob.scala:661:10
          $fatal;	// rob.scala:661:10
      end
      if (~(~(exception_thrown & r_xcpt_uop_rob_idx[5:1] != rob_head) | reset)) begin	// rob.scala:224:29, :259:29, :268:25, :545:85, :664:{10,11,34,68}
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:664:10
          $error("Assertion failed: ROB is throwing an exception, but the stored exception information's rob_idx does not match the rob_head\n    at rob.scala:664 assert (!(will_throw_exception && (GetRowIdx(r_xcpt_uop.rob_idx) =/= rob_head)),\n");	// rob.scala:664:10
        if (`STOP_COND_)	// rob.scala:664:10
          $fatal;	// rob.scala:664:10
      end
      if (~(_GEN_60 ^ rob_head_idx < rob_tail_idx ^ rob_pnr_idx >= rob_tail_idx
            | rob_pnr_idx == rob_tail_idx | reset)) begin	// Cat.scala:30:58, rob.scala:740:{9,10,75}, util.scala:363:{52,64,78}
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:740:9
          $error("Assertion failed\n    at rob.scala:740 assert(!IsOlder(rob_pnr_idx, rob_head_idx, rob_tail_idx) || rob_pnr_idx === rob_tail_idx)\n");	// rob.scala:740:9
        if (`STOP_COND_)	// rob.scala:740:9
          $fatal;	// rob.scala:740:9
      end
      if (~(rob_tail_idx < rob_head_idx ^ _GEN_60 ^ rob_tail_idx >= rob_pnr_idx | full
            | reset)) begin	// Cat.scala:30:58, rob.scala:743:{9,10}, :787:39, util.scala:363:{52,64}
        if (`ASSERT_VERBOSE_COND_)	// rob.scala:743:9
          $error("Assertion failed\n    at rob.scala:743 assert(!IsOlder(rob_tail_idx, rob_pnr_idx, rob_head_idx) || full)\n");	// rob.scala:743:9
        if (`STOP_COND_)	// rob.scala:743:9
          $fatal;	// rob.scala:743:9
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  wire             _GEN_62 =
    _io_commit_rollback_T_1 & (rob_tail != rob_head | maybe_full);	// rob.scala:224:29, :228:29, :236:31, :239:29, :750:{34,47,60}
  wire             rob_deq = _GEN_62 | finished_committing_row;	// rob.scala:685:59, :688:34, :750:{34,76}, :754:13
  assign full = rob_tail == rob_head & maybe_full;	// rob.scala:224:29, :228:29, :239:29, :787:{26,39}
  assign empty = _empty_T & _io_com_load_is_at_rob_head_T == 2'h0;	// rob.scala:221:26, :685:42, :686:33, :788:{41,66}
  reg              REG;	// rob.scala:808:30
  reg              REG_1;	// rob.scala:808:22
  reg              REG_2;	// rob.scala:824:22
  reg              io_com_load_is_at_rob_head_REG;	// rob.scala:865:40
  always @(posedge clock) begin
    automatic logic        _GEN_63;	// rob.scala:324:31
    automatic logic        _GEN_64;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_65;	// rob.scala:324:31
    automatic logic        _GEN_66;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_67;	// rob.scala:324:31
    automatic logic        _GEN_68;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_69;	// rob.scala:324:31
    automatic logic        _GEN_70;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_71;	// rob.scala:324:31
    automatic logic        _GEN_72;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_73;	// rob.scala:324:31
    automatic logic        _GEN_74;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_75;	// rob.scala:324:31
    automatic logic        _GEN_76;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_77;	// rob.scala:324:31
    automatic logic        _GEN_78;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_79;	// rob.scala:324:31
    automatic logic        _GEN_80;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_81;	// rob.scala:324:31
    automatic logic        _GEN_82;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_83;	// rob.scala:324:31
    automatic logic        _GEN_84;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_85;	// rob.scala:324:31
    automatic logic        _GEN_86;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_87;	// rob.scala:324:31
    automatic logic        _GEN_88;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_89;	// rob.scala:324:31
    automatic logic        _GEN_90;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_91;	// rob.scala:324:31
    automatic logic        _GEN_92;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_93;	// rob.scala:324:31
    automatic logic        _GEN_94;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_95;	// rob.scala:324:31
    automatic logic        _GEN_96;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_97;	// rob.scala:324:31
    automatic logic        _GEN_98;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_99;	// rob.scala:324:31
    automatic logic        _GEN_100;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_101;	// rob.scala:324:31
    automatic logic        _GEN_102;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_103;	// rob.scala:324:31
    automatic logic        _GEN_104;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_105;	// rob.scala:324:31
    automatic logic        _GEN_106;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_107;	// rob.scala:324:31
    automatic logic        _GEN_108;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_109;	// rob.scala:324:31
    automatic logic        _GEN_110;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_111;	// rob.scala:324:31
    automatic logic        _GEN_112;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_113;	// rob.scala:324:31
    automatic logic        _GEN_114;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_115;	// rob.scala:324:31
    automatic logic        _GEN_116;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_117;	// rob.scala:324:31
    automatic logic        _GEN_118;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_119;	// rob.scala:324:31
    automatic logic        _GEN_120;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_121;	// rob.scala:324:31
    automatic logic        _GEN_122;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_123;	// rob.scala:324:31
    automatic logic        _GEN_124;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_125;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _rob_bsy_T = io_enq_uops_0_is_fence | io_enq_uops_0_is_fencei;	// rob.scala:325:60
    automatic logic        _GEN_126;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_127;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_128;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_129;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_130;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_131;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_132;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_133;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_134;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_135;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_136;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_137;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_138;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_139;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_140;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_141;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_142;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_143;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_144;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_145;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_146;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_147;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_148;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_149;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_150;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_151;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_152;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_153;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_154;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_155;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_156;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_157;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _rob_unsafe_T_4 =
      io_enq_uops_0_uses_ldq | io_enq_uops_0_uses_stq & ~io_enq_uops_0_is_fence
      | io_enq_uops_0_is_br | io_enq_uops_0_is_jalr;	// micro-op.scala:152:{48,51,71}
    automatic logic        _GEN_158;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_159;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_160;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_161;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_162;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_163;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_164;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_165;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_166;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_167;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_168;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_169;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_170;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_171;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_172;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_173;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_174;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_175;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_176;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_177;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_178;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_179;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_180;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_181;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_182;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_183;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_184;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_185;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_186;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_187;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_188;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_189;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_190 = io_wb_resps_0_bits_uop_rob_idx[5:1] == 5'h0;	// rob.scala:224:29, :268:25, :347:31
    automatic logic        _GEN_191 = _GEN_0 & _GEN_190;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_192 = io_wb_resps_0_bits_uop_rob_idx[5:1] == 5'h1;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_193 = _GEN_0 & _GEN_192;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_194 = io_wb_resps_0_bits_uop_rob_idx[5:1] == 5'h2;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_195 = _GEN_0 & _GEN_194;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_196 = io_wb_resps_0_bits_uop_rob_idx[5:1] == 5'h3;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_197 = _GEN_0 & _GEN_196;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_198 = io_wb_resps_0_bits_uop_rob_idx[5:1] == 5'h4;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_199 = _GEN_0 & _GEN_198;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_200 = io_wb_resps_0_bits_uop_rob_idx[5:1] == 5'h5;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_201 = _GEN_0 & _GEN_200;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_202 = io_wb_resps_0_bits_uop_rob_idx[5:1] == 5'h6;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_203 = _GEN_0 & _GEN_202;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_204 = io_wb_resps_0_bits_uop_rob_idx[5:1] == 5'h7;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_205 = _GEN_0 & _GEN_204;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_206 = io_wb_resps_0_bits_uop_rob_idx[5:1] == 5'h8;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_207 = _GEN_0 & _GEN_206;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_208 = io_wb_resps_0_bits_uop_rob_idx[5:1] == 5'h9;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_209 = _GEN_0 & _GEN_208;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_210 = io_wb_resps_0_bits_uop_rob_idx[5:1] == 5'hA;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_211 = _GEN_0 & _GEN_210;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_212 = io_wb_resps_0_bits_uop_rob_idx[5:1] == 5'hB;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_213 = _GEN_0 & _GEN_212;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_214 = io_wb_resps_0_bits_uop_rob_idx[5:1] == 5'hC;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_215 = _GEN_0 & _GEN_214;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_216 = io_wb_resps_0_bits_uop_rob_idx[5:1] == 5'hD;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_217 = _GEN_0 & _GEN_216;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_218 = io_wb_resps_0_bits_uop_rob_idx[5:1] == 5'hE;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_219 = _GEN_0 & _GEN_218;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_220 = io_wb_resps_0_bits_uop_rob_idx[5:1] == 5'hF;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_221 = _GEN_0 & _GEN_220;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_222 = io_wb_resps_0_bits_uop_rob_idx[5:1] == 5'h10;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_223 = _GEN_0 & _GEN_222;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_224 = io_wb_resps_0_bits_uop_rob_idx[5:1] == 5'h11;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_225 = _GEN_0 & _GEN_224;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_226 = io_wb_resps_0_bits_uop_rob_idx[5:1] == 5'h12;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_227 = _GEN_0 & _GEN_226;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_228 = io_wb_resps_0_bits_uop_rob_idx[5:1] == 5'h13;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_229 = _GEN_0 & _GEN_228;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_230 = io_wb_resps_0_bits_uop_rob_idx[5:1] == 5'h14;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_231 = _GEN_0 & _GEN_230;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_232 = io_wb_resps_0_bits_uop_rob_idx[5:1] == 5'h15;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_233 = _GEN_0 & _GEN_232;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_234 = io_wb_resps_0_bits_uop_rob_idx[5:1] == 5'h16;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_235 = _GEN_0 & _GEN_234;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_236 = io_wb_resps_0_bits_uop_rob_idx[5:1] == 5'h17;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_237 = _GEN_0 & _GEN_236;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_238 = io_wb_resps_0_bits_uop_rob_idx[5:1] == 5'h18;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_239 = _GEN_0 & _GEN_238;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_240 = io_wb_resps_0_bits_uop_rob_idx[5:1] == 5'h19;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_241 = _GEN_0 & _GEN_240;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_242 = io_wb_resps_0_bits_uop_rob_idx[5:1] == 5'h1A;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_243 = _GEN_0 & _GEN_242;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_244 = io_wb_resps_0_bits_uop_rob_idx[5:1] == 5'h1B;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_245 = _GEN_0 & _GEN_244;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_246 = io_wb_resps_0_bits_uop_rob_idx[5:1] == 5'h1C;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_247 = _GEN_0 & _GEN_246;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_248 = io_wb_resps_0_bits_uop_rob_idx[5:1] == 5'h1D;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_249 = _GEN_0 & _GEN_248;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_250 = io_wb_resps_0_bits_uop_rob_idx[5:1] == 5'h1E;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_251 = _GEN_0 & _GEN_250;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_252 = _GEN_0 & (&(io_wb_resps_0_bits_uop_rob_idx[5:1]));	// rob.scala:268:25, :323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_253 = io_wb_resps_1_bits_uop_rob_idx[5:1] == 5'h0;	// rob.scala:224:29, :268:25, :347:31
    automatic logic        _GEN_254 = _GEN_253 | _GEN_191;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_255;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_256 = io_wb_resps_1_bits_uop_rob_idx[5:1] == 5'h1;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_257 = _GEN_256 | _GEN_193;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_258;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_259 = io_wb_resps_1_bits_uop_rob_idx[5:1] == 5'h2;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_260 = _GEN_259 | _GEN_195;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_261;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_262 = io_wb_resps_1_bits_uop_rob_idx[5:1] == 5'h3;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_263 = _GEN_262 | _GEN_197;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_264;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_265 = io_wb_resps_1_bits_uop_rob_idx[5:1] == 5'h4;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_266 = _GEN_265 | _GEN_199;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_267;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_268 = io_wb_resps_1_bits_uop_rob_idx[5:1] == 5'h5;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_269 = _GEN_268 | _GEN_201;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_270;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_271 = io_wb_resps_1_bits_uop_rob_idx[5:1] == 5'h6;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_272 = _GEN_271 | _GEN_203;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_273;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_274 = io_wb_resps_1_bits_uop_rob_idx[5:1] == 5'h7;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_275 = _GEN_274 | _GEN_205;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_276;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_277 = io_wb_resps_1_bits_uop_rob_idx[5:1] == 5'h8;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_278 = _GEN_277 | _GEN_207;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_279;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_280 = io_wb_resps_1_bits_uop_rob_idx[5:1] == 5'h9;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_281 = _GEN_280 | _GEN_209;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_282;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_283 = io_wb_resps_1_bits_uop_rob_idx[5:1] == 5'hA;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_284 = _GEN_283 | _GEN_211;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_285;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_286 = io_wb_resps_1_bits_uop_rob_idx[5:1] == 5'hB;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_287 = _GEN_286 | _GEN_213;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_288;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_289 = io_wb_resps_1_bits_uop_rob_idx[5:1] == 5'hC;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_290 = _GEN_289 | _GEN_215;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_291;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_292 = io_wb_resps_1_bits_uop_rob_idx[5:1] == 5'hD;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_293 = _GEN_292 | _GEN_217;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_294;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_295 = io_wb_resps_1_bits_uop_rob_idx[5:1] == 5'hE;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_296 = _GEN_295 | _GEN_219;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_297;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_298 = io_wb_resps_1_bits_uop_rob_idx[5:1] == 5'hF;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_299 = _GEN_298 | _GEN_221;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_300;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_301 = io_wb_resps_1_bits_uop_rob_idx[5:1] == 5'h10;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_302 = _GEN_301 | _GEN_223;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_303;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_304 = io_wb_resps_1_bits_uop_rob_idx[5:1] == 5'h11;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_305 = _GEN_304 | _GEN_225;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_306;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_307 = io_wb_resps_1_bits_uop_rob_idx[5:1] == 5'h12;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_308 = _GEN_307 | _GEN_227;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_309;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_310 = io_wb_resps_1_bits_uop_rob_idx[5:1] == 5'h13;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_311 = _GEN_310 | _GEN_229;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_312;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_313 = io_wb_resps_1_bits_uop_rob_idx[5:1] == 5'h14;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_314 = _GEN_313 | _GEN_231;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_315;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_316 = io_wb_resps_1_bits_uop_rob_idx[5:1] == 5'h15;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_317 = _GEN_316 | _GEN_233;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_318;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_319 = io_wb_resps_1_bits_uop_rob_idx[5:1] == 5'h16;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_320 = _GEN_319 | _GEN_235;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_321;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_322 = io_wb_resps_1_bits_uop_rob_idx[5:1] == 5'h17;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_323 = _GEN_322 | _GEN_237;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_324;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_325 = io_wb_resps_1_bits_uop_rob_idx[5:1] == 5'h18;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_326 = _GEN_325 | _GEN_239;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_327;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_328 = io_wb_resps_1_bits_uop_rob_idx[5:1] == 5'h19;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_329 = _GEN_328 | _GEN_241;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_330;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_331 = io_wb_resps_1_bits_uop_rob_idx[5:1] == 5'h1A;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_332 = _GEN_331 | _GEN_243;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_333;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_334 = io_wb_resps_1_bits_uop_rob_idx[5:1] == 5'h1B;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_335 = _GEN_334 | _GEN_245;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_336;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_337 = io_wb_resps_1_bits_uop_rob_idx[5:1] == 5'h1C;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_338 = _GEN_337 | _GEN_247;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_339;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_340 = io_wb_resps_1_bits_uop_rob_idx[5:1] == 5'h1D;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_341 = _GEN_340 | _GEN_249;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_342;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_343 = io_wb_resps_1_bits_uop_rob_idx[5:1] == 5'h1E;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_344 = _GEN_343 | _GEN_251;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_345;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_346 = (&(io_wb_resps_1_bits_uop_rob_idx[5:1])) | _GEN_252;	// rob.scala:268:25, :323:29, :346:69, :347:31
    automatic logic        _GEN_347;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_348;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_349;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_350;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_351;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_352;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_353;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_354;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_355;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_356;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_357;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_358;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_359;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_360;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_361;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_362;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_363;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_364;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_365;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_366;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_367;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_368;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_369;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_370;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_371;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_372;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_373;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_374;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_375;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_376;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_377;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_378;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_379;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_380 = io_wb_resps_2_bits_uop_rob_idx[5:1] == 5'h0;	// rob.scala:224:29, :268:25, :347:31
    automatic logic        _GEN_381 = _GEN_2 & _GEN_380;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_382 = io_wb_resps_2_bits_uop_rob_idx[5:1] == 5'h1;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_383 = _GEN_2 & _GEN_382;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_384 = io_wb_resps_2_bits_uop_rob_idx[5:1] == 5'h2;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_385 = _GEN_2 & _GEN_384;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_386 = io_wb_resps_2_bits_uop_rob_idx[5:1] == 5'h3;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_387 = _GEN_2 & _GEN_386;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_388 = io_wb_resps_2_bits_uop_rob_idx[5:1] == 5'h4;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_389 = _GEN_2 & _GEN_388;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_390 = io_wb_resps_2_bits_uop_rob_idx[5:1] == 5'h5;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_391 = _GEN_2 & _GEN_390;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_392 = io_wb_resps_2_bits_uop_rob_idx[5:1] == 5'h6;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_393 = _GEN_2 & _GEN_392;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_394 = io_wb_resps_2_bits_uop_rob_idx[5:1] == 5'h7;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_395 = _GEN_2 & _GEN_394;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_396 = io_wb_resps_2_bits_uop_rob_idx[5:1] == 5'h8;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_397 = _GEN_2 & _GEN_396;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_398 = io_wb_resps_2_bits_uop_rob_idx[5:1] == 5'h9;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_399 = _GEN_2 & _GEN_398;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_400 = io_wb_resps_2_bits_uop_rob_idx[5:1] == 5'hA;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_401 = _GEN_2 & _GEN_400;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_402 = io_wb_resps_2_bits_uop_rob_idx[5:1] == 5'hB;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_403 = _GEN_2 & _GEN_402;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_404 = io_wb_resps_2_bits_uop_rob_idx[5:1] == 5'hC;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_405 = _GEN_2 & _GEN_404;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_406 = io_wb_resps_2_bits_uop_rob_idx[5:1] == 5'hD;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_407 = _GEN_2 & _GEN_406;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_408 = io_wb_resps_2_bits_uop_rob_idx[5:1] == 5'hE;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_409 = _GEN_2 & _GEN_408;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_410 = io_wb_resps_2_bits_uop_rob_idx[5:1] == 5'hF;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_411 = _GEN_2 & _GEN_410;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_412 = io_wb_resps_2_bits_uop_rob_idx[5:1] == 5'h10;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_413 = _GEN_2 & _GEN_412;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_414 = io_wb_resps_2_bits_uop_rob_idx[5:1] == 5'h11;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_415 = _GEN_2 & _GEN_414;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_416 = io_wb_resps_2_bits_uop_rob_idx[5:1] == 5'h12;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_417 = _GEN_2 & _GEN_416;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_418 = io_wb_resps_2_bits_uop_rob_idx[5:1] == 5'h13;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_419 = _GEN_2 & _GEN_418;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_420 = io_wb_resps_2_bits_uop_rob_idx[5:1] == 5'h14;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_421 = _GEN_2 & _GEN_420;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_422 = io_wb_resps_2_bits_uop_rob_idx[5:1] == 5'h15;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_423 = _GEN_2 & _GEN_422;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_424 = io_wb_resps_2_bits_uop_rob_idx[5:1] == 5'h16;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_425 = _GEN_2 & _GEN_424;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_426 = io_wb_resps_2_bits_uop_rob_idx[5:1] == 5'h17;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_427 = _GEN_2 & _GEN_426;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_428 = io_wb_resps_2_bits_uop_rob_idx[5:1] == 5'h18;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_429 = _GEN_2 & _GEN_428;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_430 = io_wb_resps_2_bits_uop_rob_idx[5:1] == 5'h19;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_431 = _GEN_2 & _GEN_430;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_432 = io_wb_resps_2_bits_uop_rob_idx[5:1] == 5'h1A;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_433 = _GEN_2 & _GEN_432;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_434 = io_wb_resps_2_bits_uop_rob_idx[5:1] == 5'h1B;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_435 = _GEN_2 & _GEN_434;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_436 = io_wb_resps_2_bits_uop_rob_idx[5:1] == 5'h1C;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_437 = _GEN_2 & _GEN_436;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_438 = io_wb_resps_2_bits_uop_rob_idx[5:1] == 5'h1D;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_439 = _GEN_2 & _GEN_438;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_440 = io_wb_resps_2_bits_uop_rob_idx[5:1] == 5'h1E;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_441 = _GEN_2 & _GEN_440;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_442 = _GEN_2 & (&(io_wb_resps_2_bits_uop_rob_idx[5:1]));	// rob.scala:268:25, :346:{27,69}, :347:31
    automatic logic        _GEN_443 = io_wb_resps_3_bits_uop_rob_idx[5:1] == 5'h0;	// rob.scala:224:29, :268:25, :347:31
    automatic logic        _GEN_444 = _GEN_443 | _GEN_381;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_445;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_446 = io_wb_resps_3_bits_uop_rob_idx[5:1] == 5'h1;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_447 = _GEN_446 | _GEN_383;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_448;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_449 = io_wb_resps_3_bits_uop_rob_idx[5:1] == 5'h2;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_450 = _GEN_449 | _GEN_385;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_451;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_452 = io_wb_resps_3_bits_uop_rob_idx[5:1] == 5'h3;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_453 = _GEN_452 | _GEN_387;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_454;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_455 = io_wb_resps_3_bits_uop_rob_idx[5:1] == 5'h4;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_456 = _GEN_455 | _GEN_389;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_457;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_458 = io_wb_resps_3_bits_uop_rob_idx[5:1] == 5'h5;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_459 = _GEN_458 | _GEN_391;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_460;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_461 = io_wb_resps_3_bits_uop_rob_idx[5:1] == 5'h6;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_462 = _GEN_461 | _GEN_393;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_463;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_464 = io_wb_resps_3_bits_uop_rob_idx[5:1] == 5'h7;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_465 = _GEN_464 | _GEN_395;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_466;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_467 = io_wb_resps_3_bits_uop_rob_idx[5:1] == 5'h8;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_468 = _GEN_467 | _GEN_397;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_469;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_470 = io_wb_resps_3_bits_uop_rob_idx[5:1] == 5'h9;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_471 = _GEN_470 | _GEN_399;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_472;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_473 = io_wb_resps_3_bits_uop_rob_idx[5:1] == 5'hA;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_474 = _GEN_473 | _GEN_401;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_475;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_476 = io_wb_resps_3_bits_uop_rob_idx[5:1] == 5'hB;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_477 = _GEN_476 | _GEN_403;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_478;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_479 = io_wb_resps_3_bits_uop_rob_idx[5:1] == 5'hC;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_480 = _GEN_479 | _GEN_405;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_481;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_482 = io_wb_resps_3_bits_uop_rob_idx[5:1] == 5'hD;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_483 = _GEN_482 | _GEN_407;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_484;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_485 = io_wb_resps_3_bits_uop_rob_idx[5:1] == 5'hE;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_486 = _GEN_485 | _GEN_409;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_487;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_488 = io_wb_resps_3_bits_uop_rob_idx[5:1] == 5'hF;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_489 = _GEN_488 | _GEN_411;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_490;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_491 = io_wb_resps_3_bits_uop_rob_idx[5:1] == 5'h10;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_492 = _GEN_491 | _GEN_413;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_493;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_494 = io_wb_resps_3_bits_uop_rob_idx[5:1] == 5'h11;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_495 = _GEN_494 | _GEN_415;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_496;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_497 = io_wb_resps_3_bits_uop_rob_idx[5:1] == 5'h12;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_498 = _GEN_497 | _GEN_417;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_499;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_500 = io_wb_resps_3_bits_uop_rob_idx[5:1] == 5'h13;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_501 = _GEN_500 | _GEN_419;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_502;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_503 = io_wb_resps_3_bits_uop_rob_idx[5:1] == 5'h14;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_504 = _GEN_503 | _GEN_421;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_505;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_506 = io_wb_resps_3_bits_uop_rob_idx[5:1] == 5'h15;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_507 = _GEN_506 | _GEN_423;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_508;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_509 = io_wb_resps_3_bits_uop_rob_idx[5:1] == 5'h16;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_510 = _GEN_509 | _GEN_425;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_511;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_512 = io_wb_resps_3_bits_uop_rob_idx[5:1] == 5'h17;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_513 = _GEN_512 | _GEN_427;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_514;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_515 = io_wb_resps_3_bits_uop_rob_idx[5:1] == 5'h18;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_516 = _GEN_515 | _GEN_429;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_517;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_518 = io_wb_resps_3_bits_uop_rob_idx[5:1] == 5'h19;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_519 = _GEN_518 | _GEN_431;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_520;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_521 = io_wb_resps_3_bits_uop_rob_idx[5:1] == 5'h1A;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_522 = _GEN_521 | _GEN_433;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_523;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_524 = io_wb_resps_3_bits_uop_rob_idx[5:1] == 5'h1B;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_525 = _GEN_524 | _GEN_435;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_526;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_527 = io_wb_resps_3_bits_uop_rob_idx[5:1] == 5'h1C;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_528 = _GEN_527 | _GEN_437;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_529;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_530 = io_wb_resps_3_bits_uop_rob_idx[5:1] == 5'h1D;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_531 = _GEN_530 | _GEN_439;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_532;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_533 = io_wb_resps_3_bits_uop_rob_idx[5:1] == 5'h1E;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_534 = _GEN_533 | _GEN_441;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_535;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_536 = (&(io_wb_resps_3_bits_uop_rob_idx[5:1])) | _GEN_442;	// rob.scala:268:25, :346:69, :347:31
    automatic logic        _GEN_537;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_538;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_539;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_540;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_541;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_542;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_543;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_544;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_545;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_546;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_547;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_548;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_549;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_550;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_551;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_552;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_553;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_554;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_555;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_556;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_557;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_558;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_559;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_560;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_561;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_562;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_563;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_564;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_565;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_566;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_567;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_568;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_569;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_570 = io_wb_resps_4_bits_uop_rob_idx[5:1] == 5'h0;	// rob.scala:224:29, :268:25, :347:31
    automatic logic        _GEN_571 = _GEN_4 & _GEN_570;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_572 = io_wb_resps_4_bits_uop_rob_idx[5:1] == 5'h1;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_573 = _GEN_4 & _GEN_572;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_574 = io_wb_resps_4_bits_uop_rob_idx[5:1] == 5'h2;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_575 = _GEN_4 & _GEN_574;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_576 = io_wb_resps_4_bits_uop_rob_idx[5:1] == 5'h3;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_577 = _GEN_4 & _GEN_576;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_578 = io_wb_resps_4_bits_uop_rob_idx[5:1] == 5'h4;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_579 = _GEN_4 & _GEN_578;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_580 = io_wb_resps_4_bits_uop_rob_idx[5:1] == 5'h5;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_581 = _GEN_4 & _GEN_580;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_582 = io_wb_resps_4_bits_uop_rob_idx[5:1] == 5'h6;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_583 = _GEN_4 & _GEN_582;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_584 = io_wb_resps_4_bits_uop_rob_idx[5:1] == 5'h7;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_585 = _GEN_4 & _GEN_584;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_586 = io_wb_resps_4_bits_uop_rob_idx[5:1] == 5'h8;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_587 = _GEN_4 & _GEN_586;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_588 = io_wb_resps_4_bits_uop_rob_idx[5:1] == 5'h9;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_589 = _GEN_4 & _GEN_588;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_590 = io_wb_resps_4_bits_uop_rob_idx[5:1] == 5'hA;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_591 = _GEN_4 & _GEN_590;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_592 = io_wb_resps_4_bits_uop_rob_idx[5:1] == 5'hB;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_593 = _GEN_4 & _GEN_592;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_594 = io_wb_resps_4_bits_uop_rob_idx[5:1] == 5'hC;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_595 = _GEN_4 & _GEN_594;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_596 = io_wb_resps_4_bits_uop_rob_idx[5:1] == 5'hD;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_597 = _GEN_4 & _GEN_596;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_598 = io_wb_resps_4_bits_uop_rob_idx[5:1] == 5'hE;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_599 = _GEN_4 & _GEN_598;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_600 = io_wb_resps_4_bits_uop_rob_idx[5:1] == 5'hF;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_601 = _GEN_4 & _GEN_600;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_602 = io_wb_resps_4_bits_uop_rob_idx[5:1] == 5'h10;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_603 = _GEN_4 & _GEN_602;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_604 = io_wb_resps_4_bits_uop_rob_idx[5:1] == 5'h11;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_605 = _GEN_4 & _GEN_604;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_606 = io_wb_resps_4_bits_uop_rob_idx[5:1] == 5'h12;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_607 = _GEN_4 & _GEN_606;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_608 = io_wb_resps_4_bits_uop_rob_idx[5:1] == 5'h13;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_609 = _GEN_4 & _GEN_608;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_610 = io_wb_resps_4_bits_uop_rob_idx[5:1] == 5'h14;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_611 = _GEN_4 & _GEN_610;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_612 = io_wb_resps_4_bits_uop_rob_idx[5:1] == 5'h15;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_613 = _GEN_4 & _GEN_612;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_614 = io_wb_resps_4_bits_uop_rob_idx[5:1] == 5'h16;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_615 = _GEN_4 & _GEN_614;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_616 = io_wb_resps_4_bits_uop_rob_idx[5:1] == 5'h17;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_617 = _GEN_4 & _GEN_616;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_618 = io_wb_resps_4_bits_uop_rob_idx[5:1] == 5'h18;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_619 = _GEN_4 & _GEN_618;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_620 = io_wb_resps_4_bits_uop_rob_idx[5:1] == 5'h19;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_621 = _GEN_4 & _GEN_620;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_622 = io_wb_resps_4_bits_uop_rob_idx[5:1] == 5'h1A;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_623 = _GEN_4 & _GEN_622;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_624 = io_wb_resps_4_bits_uop_rob_idx[5:1] == 5'h1B;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_625 = _GEN_4 & _GEN_624;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_626 = io_wb_resps_4_bits_uop_rob_idx[5:1] == 5'h1C;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_627 = _GEN_4 & _GEN_626;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_628 = io_wb_resps_4_bits_uop_rob_idx[5:1] == 5'h1D;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_629 = _GEN_4 & _GEN_628;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_630 = io_wb_resps_4_bits_uop_rob_idx[5:1] == 5'h1E;	// rob.scala:268:25, :324:31, :347:31
    automatic logic        _GEN_631 = _GEN_4 & _GEN_630;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_632 = _GEN_4 & (&(io_wb_resps_4_bits_uop_rob_idx[5:1]));	// rob.scala:268:25, :346:{27,69}, :347:31
    automatic logic        _GEN_633 = io_lsu_clr_bsy_0_bits[5:1] == 5'h0;	// rob.scala:224:29, :268:25, :363:26
    automatic logic        _GEN_634 = _GEN_633 | _GEN_571;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_635 = io_lsu_clr_bsy_0_bits[5:1] == 5'h1;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_636 = _GEN_635 | _GEN_573;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_637 = io_lsu_clr_bsy_0_bits[5:1] == 5'h2;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_638 = _GEN_637 | _GEN_575;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_639 = io_lsu_clr_bsy_0_bits[5:1] == 5'h3;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_640 = _GEN_639 | _GEN_577;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_641 = io_lsu_clr_bsy_0_bits[5:1] == 5'h4;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_642 = _GEN_641 | _GEN_579;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_643 = io_lsu_clr_bsy_0_bits[5:1] == 5'h5;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_644 = _GEN_643 | _GEN_581;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_645 = io_lsu_clr_bsy_0_bits[5:1] == 5'h6;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_646 = _GEN_645 | _GEN_583;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_647 = io_lsu_clr_bsy_0_bits[5:1] == 5'h7;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_648 = _GEN_647 | _GEN_585;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_649 = io_lsu_clr_bsy_0_bits[5:1] == 5'h8;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_650 = _GEN_649 | _GEN_587;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_651 = io_lsu_clr_bsy_0_bits[5:1] == 5'h9;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_652 = _GEN_651 | _GEN_589;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_653 = io_lsu_clr_bsy_0_bits[5:1] == 5'hA;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_654 = _GEN_653 | _GEN_591;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_655 = io_lsu_clr_bsy_0_bits[5:1] == 5'hB;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_656 = _GEN_655 | _GEN_593;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_657 = io_lsu_clr_bsy_0_bits[5:1] == 5'hC;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_658 = _GEN_657 | _GEN_595;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_659 = io_lsu_clr_bsy_0_bits[5:1] == 5'hD;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_660 = _GEN_659 | _GEN_597;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_661 = io_lsu_clr_bsy_0_bits[5:1] == 5'hE;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_662 = _GEN_661 | _GEN_599;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_663 = io_lsu_clr_bsy_0_bits[5:1] == 5'hF;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_664 = _GEN_663 | _GEN_601;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_665 = io_lsu_clr_bsy_0_bits[5:1] == 5'h10;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_666 = _GEN_665 | _GEN_603;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_667 = io_lsu_clr_bsy_0_bits[5:1] == 5'h11;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_668 = _GEN_667 | _GEN_605;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_669 = io_lsu_clr_bsy_0_bits[5:1] == 5'h12;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_670 = _GEN_669 | _GEN_607;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_671 = io_lsu_clr_bsy_0_bits[5:1] == 5'h13;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_672 = _GEN_671 | _GEN_609;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_673 = io_lsu_clr_bsy_0_bits[5:1] == 5'h14;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_674 = _GEN_673 | _GEN_611;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_675 = io_lsu_clr_bsy_0_bits[5:1] == 5'h15;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_676 = _GEN_675 | _GEN_613;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_677 = io_lsu_clr_bsy_0_bits[5:1] == 5'h16;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_678 = _GEN_677 | _GEN_615;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_679 = io_lsu_clr_bsy_0_bits[5:1] == 5'h17;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_680 = _GEN_679 | _GEN_617;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_681 = io_lsu_clr_bsy_0_bits[5:1] == 5'h18;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_682 = _GEN_681 | _GEN_619;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_683 = io_lsu_clr_bsy_0_bits[5:1] == 5'h19;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_684 = _GEN_683 | _GEN_621;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_685 = io_lsu_clr_bsy_0_bits[5:1] == 5'h1A;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_686 = _GEN_685 | _GEN_623;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_687 = io_lsu_clr_bsy_0_bits[5:1] == 5'h1B;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_688 = _GEN_687 | _GEN_625;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_689 = io_lsu_clr_bsy_0_bits[5:1] == 5'h1C;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_690 = _GEN_689 | _GEN_627;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_691 = io_lsu_clr_bsy_0_bits[5:1] == 5'h1D;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_692 = _GEN_691 | _GEN_629;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_693 = io_lsu_clr_bsy_0_bits[5:1] == 5'h1E;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_694 = _GEN_693 | _GEN_631;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_695 = (&(io_lsu_clr_bsy_0_bits[5:1])) | _GEN_632;	// rob.scala:268:25, :346:69, :347:31, :363:26
    automatic logic        _GEN_696 = io_lsu_clr_bsy_1_bits[5:1] == 5'h0;	// rob.scala:224:29, :268:25, :363:26
    automatic logic        _GEN_697 = _GEN_7 & _GEN_696;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_698 = io_lsu_clr_bsy_1_bits[5:1] == 5'h1;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_699 = _GEN_7 & _GEN_698;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_700 = io_lsu_clr_bsy_1_bits[5:1] == 5'h2;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_701 = _GEN_7 & _GEN_700;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_702 = io_lsu_clr_bsy_1_bits[5:1] == 5'h3;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_703 = _GEN_7 & _GEN_702;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_704 = io_lsu_clr_bsy_1_bits[5:1] == 5'h4;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_705 = _GEN_7 & _GEN_704;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_706 = io_lsu_clr_bsy_1_bits[5:1] == 5'h5;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_707 = _GEN_7 & _GEN_706;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_708 = io_lsu_clr_bsy_1_bits[5:1] == 5'h6;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_709 = _GEN_7 & _GEN_708;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_710 = io_lsu_clr_bsy_1_bits[5:1] == 5'h7;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_711 = _GEN_7 & _GEN_710;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_712 = io_lsu_clr_bsy_1_bits[5:1] == 5'h8;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_713 = _GEN_7 & _GEN_712;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_714 = io_lsu_clr_bsy_1_bits[5:1] == 5'h9;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_715 = _GEN_7 & _GEN_714;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_716 = io_lsu_clr_bsy_1_bits[5:1] == 5'hA;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_717 = _GEN_7 & _GEN_716;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_718 = io_lsu_clr_bsy_1_bits[5:1] == 5'hB;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_719 = _GEN_7 & _GEN_718;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_720 = io_lsu_clr_bsy_1_bits[5:1] == 5'hC;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_721 = _GEN_7 & _GEN_720;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_722 = io_lsu_clr_bsy_1_bits[5:1] == 5'hD;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_723 = _GEN_7 & _GEN_722;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_724 = io_lsu_clr_bsy_1_bits[5:1] == 5'hE;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_725 = _GEN_7 & _GEN_724;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_726 = io_lsu_clr_bsy_1_bits[5:1] == 5'hF;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_727 = _GEN_7 & _GEN_726;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_728 = io_lsu_clr_bsy_1_bits[5:1] == 5'h10;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_729 = _GEN_7 & _GEN_728;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_730 = io_lsu_clr_bsy_1_bits[5:1] == 5'h11;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_731 = _GEN_7 & _GEN_730;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_732 = io_lsu_clr_bsy_1_bits[5:1] == 5'h12;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_733 = _GEN_7 & _GEN_732;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_734 = io_lsu_clr_bsy_1_bits[5:1] == 5'h13;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_735 = _GEN_7 & _GEN_734;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_736 = io_lsu_clr_bsy_1_bits[5:1] == 5'h14;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_737 = _GEN_7 & _GEN_736;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_738 = io_lsu_clr_bsy_1_bits[5:1] == 5'h15;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_739 = _GEN_7 & _GEN_738;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_740 = io_lsu_clr_bsy_1_bits[5:1] == 5'h16;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_741 = _GEN_7 & _GEN_740;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_742 = io_lsu_clr_bsy_1_bits[5:1] == 5'h17;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_743 = _GEN_7 & _GEN_742;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_744 = io_lsu_clr_bsy_1_bits[5:1] == 5'h18;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_745 = _GEN_7 & _GEN_744;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_746 = io_lsu_clr_bsy_1_bits[5:1] == 5'h19;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_747 = _GEN_7 & _GEN_746;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_748 = io_lsu_clr_bsy_1_bits[5:1] == 5'h1A;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_749 = _GEN_7 & _GEN_748;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_750 = io_lsu_clr_bsy_1_bits[5:1] == 5'h1B;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_751 = _GEN_7 & _GEN_750;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_752 = io_lsu_clr_bsy_1_bits[5:1] == 5'h1C;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_753 = _GEN_7 & _GEN_752;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_754 = io_lsu_clr_bsy_1_bits[5:1] == 5'h1D;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_755 = _GEN_7 & _GEN_754;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_756 = io_lsu_clr_bsy_1_bits[5:1] == 5'h1E;	// rob.scala:268:25, :324:31, :363:26
    automatic logic        _GEN_757 = _GEN_7 & _GEN_756;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_758 = _GEN_7 & (&(io_lsu_clr_bsy_1_bits[5:1]));	// rob.scala:268:25, :361:{31,75}, :363:26
    automatic logic        _GEN_759 = io_lxcpt_bits_uop_rob_idx[5:1] == 5'h0;	// rob.scala:224:29, :268:25, :391:59
    automatic logic        _GEN_760 = io_lxcpt_bits_uop_rob_idx[5:1] == 5'h1;	// rob.scala:268:25, :324:31, :391:59
    automatic logic        _GEN_761 = io_lxcpt_bits_uop_rob_idx[5:1] == 5'h2;	// rob.scala:268:25, :324:31, :391:59
    automatic logic        _GEN_762 = io_lxcpt_bits_uop_rob_idx[5:1] == 5'h3;	// rob.scala:268:25, :324:31, :391:59
    automatic logic        _GEN_763 = io_lxcpt_bits_uop_rob_idx[5:1] == 5'h4;	// rob.scala:268:25, :324:31, :391:59
    automatic logic        _GEN_764 = io_lxcpt_bits_uop_rob_idx[5:1] == 5'h5;	// rob.scala:268:25, :324:31, :391:59
    automatic logic        _GEN_765 = io_lxcpt_bits_uop_rob_idx[5:1] == 5'h6;	// rob.scala:268:25, :324:31, :391:59
    automatic logic        _GEN_766 = io_lxcpt_bits_uop_rob_idx[5:1] == 5'h7;	// rob.scala:268:25, :324:31, :391:59
    automatic logic        _GEN_767 = io_lxcpt_bits_uop_rob_idx[5:1] == 5'h8;	// rob.scala:268:25, :324:31, :391:59
    automatic logic        _GEN_768 = io_lxcpt_bits_uop_rob_idx[5:1] == 5'h9;	// rob.scala:268:25, :324:31, :391:59
    automatic logic        _GEN_769 = io_lxcpt_bits_uop_rob_idx[5:1] == 5'hA;	// rob.scala:268:25, :324:31, :391:59
    automatic logic        _GEN_770 = io_lxcpt_bits_uop_rob_idx[5:1] == 5'hB;	// rob.scala:268:25, :324:31, :391:59
    automatic logic        _GEN_771 = io_lxcpt_bits_uop_rob_idx[5:1] == 5'hC;	// rob.scala:268:25, :324:31, :391:59
    automatic logic        _GEN_772 = io_lxcpt_bits_uop_rob_idx[5:1] == 5'hD;	// rob.scala:268:25, :324:31, :391:59
    automatic logic        _GEN_773 = io_lxcpt_bits_uop_rob_idx[5:1] == 5'hE;	// rob.scala:268:25, :324:31, :391:59
    automatic logic        _GEN_774 = io_lxcpt_bits_uop_rob_idx[5:1] == 5'hF;	// rob.scala:268:25, :324:31, :391:59
    automatic logic        _GEN_775 = io_lxcpt_bits_uop_rob_idx[5:1] == 5'h10;	// rob.scala:268:25, :324:31, :391:59
    automatic logic        _GEN_776 = io_lxcpt_bits_uop_rob_idx[5:1] == 5'h11;	// rob.scala:268:25, :324:31, :391:59
    automatic logic        _GEN_777 = io_lxcpt_bits_uop_rob_idx[5:1] == 5'h12;	// rob.scala:268:25, :324:31, :391:59
    automatic logic        _GEN_778 = io_lxcpt_bits_uop_rob_idx[5:1] == 5'h13;	// rob.scala:268:25, :324:31, :391:59
    automatic logic        _GEN_779 = io_lxcpt_bits_uop_rob_idx[5:1] == 5'h14;	// rob.scala:268:25, :324:31, :391:59
    automatic logic        _GEN_780 = io_lxcpt_bits_uop_rob_idx[5:1] == 5'h15;	// rob.scala:268:25, :324:31, :391:59
    automatic logic        _GEN_781 = io_lxcpt_bits_uop_rob_idx[5:1] == 5'h16;	// rob.scala:268:25, :324:31, :391:59
    automatic logic        _GEN_782 = io_lxcpt_bits_uop_rob_idx[5:1] == 5'h17;	// rob.scala:268:25, :324:31, :391:59
    automatic logic        _GEN_783 = io_lxcpt_bits_uop_rob_idx[5:1] == 5'h18;	// rob.scala:268:25, :324:31, :391:59
    automatic logic        _GEN_784 = io_lxcpt_bits_uop_rob_idx[5:1] == 5'h19;	// rob.scala:268:25, :324:31, :391:59
    automatic logic        _GEN_785 = io_lxcpt_bits_uop_rob_idx[5:1] == 5'h1A;	// rob.scala:268:25, :324:31, :391:59
    automatic logic        _GEN_786 = io_lxcpt_bits_uop_rob_idx[5:1] == 5'h1B;	// rob.scala:268:25, :324:31, :391:59
    automatic logic        _GEN_787 = io_lxcpt_bits_uop_rob_idx[5:1] == 5'h1C;	// rob.scala:268:25, :324:31, :391:59
    automatic logic        _GEN_788 = io_lxcpt_bits_uop_rob_idx[5:1] == 5'h1D;	// rob.scala:268:25, :324:31, :391:59
    automatic logic        _GEN_789 = io_lxcpt_bits_uop_rob_idx[5:1] == 5'h1E;	// rob.scala:268:25, :324:31, :391:59
    automatic logic        _GEN_790 = com_idx == 5'h0;	// rob.scala:224:29, :236:20, :434:30
    automatic logic        _GEN_791;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_792 = com_idx == 5'h1;	// rob.scala:236:20, :324:31, :434:30
    automatic logic        _GEN_793;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_794 = com_idx == 5'h2;	// rob.scala:236:20, :324:31, :434:30
    automatic logic        _GEN_795;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_796 = com_idx == 5'h3;	// rob.scala:236:20, :324:31, :434:30
    automatic logic        _GEN_797;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_798 = com_idx == 5'h4;	// rob.scala:236:20, :324:31, :434:30
    automatic logic        _GEN_799;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_800 = com_idx == 5'h5;	// rob.scala:236:20, :324:31, :434:30
    automatic logic        _GEN_801;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_802 = com_idx == 5'h6;	// rob.scala:236:20, :324:31, :434:30
    automatic logic        _GEN_803;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_804 = com_idx == 5'h7;	// rob.scala:236:20, :324:31, :434:30
    automatic logic        _GEN_805;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_806 = com_idx == 5'h8;	// rob.scala:236:20, :324:31, :434:30
    automatic logic        _GEN_807;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_808 = com_idx == 5'h9;	// rob.scala:236:20, :324:31, :434:30
    automatic logic        _GEN_809;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_810 = com_idx == 5'hA;	// rob.scala:236:20, :324:31, :434:30
    automatic logic        _GEN_811;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_812 = com_idx == 5'hB;	// rob.scala:236:20, :324:31, :434:30
    automatic logic        _GEN_813;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_814 = com_idx == 5'hC;	// rob.scala:236:20, :324:31, :434:30
    automatic logic        _GEN_815;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_816 = com_idx == 5'hD;	// rob.scala:236:20, :324:31, :434:30
    automatic logic        _GEN_817;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_818 = com_idx == 5'hE;	// rob.scala:236:20, :324:31, :434:30
    automatic logic        _GEN_819;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_820 = com_idx == 5'hF;	// rob.scala:236:20, :324:31, :434:30
    automatic logic        _GEN_821;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_822 = com_idx == 5'h10;	// rob.scala:236:20, :324:31, :434:30
    automatic logic        _GEN_823;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_824 = com_idx == 5'h11;	// rob.scala:236:20, :324:31, :434:30
    automatic logic        _GEN_825;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_826 = com_idx == 5'h12;	// rob.scala:236:20, :324:31, :434:30
    automatic logic        _GEN_827;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_828 = com_idx == 5'h13;	// rob.scala:236:20, :324:31, :434:30
    automatic logic        _GEN_829;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_830 = com_idx == 5'h14;	// rob.scala:236:20, :324:31, :434:30
    automatic logic        _GEN_831;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_832 = com_idx == 5'h15;	// rob.scala:236:20, :324:31, :434:30
    automatic logic        _GEN_833;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_834 = com_idx == 5'h16;	// rob.scala:236:20, :324:31, :434:30
    automatic logic        _GEN_835;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_836 = com_idx == 5'h17;	// rob.scala:236:20, :324:31, :434:30
    automatic logic        _GEN_837;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_838 = com_idx == 5'h18;	// rob.scala:236:20, :324:31, :434:30
    automatic logic        _GEN_839;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_840 = com_idx == 5'h19;	// rob.scala:236:20, :324:31, :434:30
    automatic logic        _GEN_841;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_842 = com_idx == 5'h1A;	// rob.scala:236:20, :324:31, :434:30
    automatic logic        _GEN_843;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_844 = com_idx == 5'h1B;	// rob.scala:236:20, :324:31, :434:30
    automatic logic        _GEN_845;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_846 = com_idx == 5'h1C;	// rob.scala:236:20, :324:31, :434:30
    automatic logic        _GEN_847;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_848 = com_idx == 5'h1D;	// rob.scala:236:20, :324:31, :434:30
    automatic logic        _GEN_849;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_850 = com_idx == 5'h1E;	// rob.scala:236:20, :324:31, :434:30
    automatic logic        _GEN_851;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_852;	// rob.scala:323:29, :433:20, :434:30
    automatic logic [11:0] _GEN_853;	// util.scala:118:51
    automatic logic [11:0] _GEN_854;	// util.scala:118:51
    automatic logic [11:0] _GEN_855;	// util.scala:118:51
    automatic logic [11:0] _GEN_856;	// util.scala:118:51
    automatic logic [11:0] _GEN_857;	// util.scala:118:51
    automatic logic [11:0] _GEN_858;	// util.scala:118:51
    automatic logic [11:0] _GEN_859;	// util.scala:118:51
    automatic logic [11:0] _GEN_860;	// util.scala:118:51
    automatic logic [11:0] _GEN_861;	// util.scala:118:51
    automatic logic [11:0] _GEN_862;	// util.scala:118:51
    automatic logic [11:0] _GEN_863;	// util.scala:118:51
    automatic logic [11:0] _GEN_864;	// util.scala:118:51
    automatic logic [11:0] _GEN_865;	// util.scala:118:51
    automatic logic [11:0] _GEN_866;	// util.scala:118:51
    automatic logic [11:0] _GEN_867;	// util.scala:118:51
    automatic logic [11:0] _GEN_868;	// util.scala:118:51
    automatic logic [11:0] _GEN_869;	// util.scala:118:51
    automatic logic [11:0] _GEN_870;	// util.scala:118:51
    automatic logic [11:0] _GEN_871;	// util.scala:118:51
    automatic logic [11:0] _GEN_872;	// util.scala:118:51
    automatic logic [11:0] _GEN_873;	// util.scala:118:51
    automatic logic [11:0] _GEN_874;	// util.scala:118:51
    automatic logic [11:0] _GEN_875;	// util.scala:118:51
    automatic logic [11:0] _GEN_876;	// util.scala:118:51
    automatic logic [11:0] _GEN_877;	// util.scala:118:51
    automatic logic [11:0] _GEN_878;	// util.scala:118:51
    automatic logic [11:0] _GEN_879;	// util.scala:118:51
    automatic logic [11:0] _GEN_880;	// util.scala:118:51
    automatic logic [11:0] _GEN_881;	// util.scala:118:51
    automatic logic [11:0] _GEN_882;	// util.scala:118:51
    automatic logic [11:0] _GEN_883;	// util.scala:118:51
    automatic logic [11:0] _GEN_884;	// util.scala:118:51
    automatic logic        _GEN_885;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_886;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_887;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_888;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_889;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_890;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_891;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_892;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_893;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_894;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_895;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_896;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_897;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_898;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_899;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_900;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_901;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_902;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_903;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_904;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_905;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_906;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_907;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_908;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_909;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_910;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_911;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_912;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_913;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_914;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_915;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _GEN_916;	// rob.scala:307:32, :323:29, :324:31
    automatic logic        _rob_bsy_T_2 =
      io_enq_uops_1_is_fence | io_enq_uops_1_is_fencei;	// rob.scala:325:60
    automatic logic        _GEN_917;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_918;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_919;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_920;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_921;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_922;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_923;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_924;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_925;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_926;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_927;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_928;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_929;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_930;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_931;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_932;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_933;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_934;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_935;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_936;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_937;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_938;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_939;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_940;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_941;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_942;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_943;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_944;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_945;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_946;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_947;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _GEN_948;	// rob.scala:308:28, :323:29, :325:31
    automatic logic        _rob_unsafe_T_9 =
      io_enq_uops_1_uses_ldq | io_enq_uops_1_uses_stq & ~io_enq_uops_1_is_fence
      | io_enq_uops_1_is_br | io_enq_uops_1_is_jalr;	// micro-op.scala:152:{48,51,71}
    automatic logic        _GEN_949;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_950;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_951;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_952;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_953;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_954;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_955;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_956;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_957;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_958;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_959;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_960;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_961;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_962;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_963;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_964;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_965;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_966;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_967;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_968;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_969;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_970;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_971;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_972;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_973;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_974;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_975;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_976;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_977;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_978;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_979;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_980;	// rob.scala:309:28, :323:29, :327:31
    automatic logic        _GEN_981 = _GEN_29 & _GEN_190;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_982 = _GEN_29 & _GEN_192;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_983 = _GEN_29 & _GEN_194;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_984 = _GEN_29 & _GEN_196;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_985 = _GEN_29 & _GEN_198;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_986 = _GEN_29 & _GEN_200;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_987 = _GEN_29 & _GEN_202;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_988 = _GEN_29 & _GEN_204;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_989 = _GEN_29 & _GEN_206;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_990 = _GEN_29 & _GEN_208;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_991 = _GEN_29 & _GEN_210;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_992 = _GEN_29 & _GEN_212;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_993 = _GEN_29 & _GEN_214;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_994 = _GEN_29 & _GEN_216;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_995 = _GEN_29 & _GEN_218;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_996 = _GEN_29 & _GEN_220;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_997 = _GEN_29 & _GEN_222;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_998 = _GEN_29 & _GEN_224;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_999 = _GEN_29 & _GEN_226;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_1000 = _GEN_29 & _GEN_228;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_1001 = _GEN_29 & _GEN_230;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_1002 = _GEN_29 & _GEN_232;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_1003 = _GEN_29 & _GEN_234;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_1004 = _GEN_29 & _GEN_236;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_1005 = _GEN_29 & _GEN_238;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_1006 = _GEN_29 & _GEN_240;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_1007 = _GEN_29 & _GEN_242;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_1008 = _GEN_29 & _GEN_244;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_1009 = _GEN_29 & _GEN_246;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_1010 = _GEN_29 & _GEN_248;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_1011 = _GEN_29 & _GEN_250;	// rob.scala:323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_1012 = _GEN_29 & (&(io_wb_resps_0_bits_uop_rob_idx[5:1]));	// rob.scala:268:25, :323:29, :346:{27,69}, :347:31
    automatic logic        _GEN_1013 = _GEN_253 | _GEN_981;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_1014;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1015 = _GEN_256 | _GEN_982;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_1016;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1017 = _GEN_259 | _GEN_983;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_1018;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1019 = _GEN_262 | _GEN_984;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_1020;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1021 = _GEN_265 | _GEN_985;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_1022;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1023 = _GEN_268 | _GEN_986;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_1024;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1025 = _GEN_271 | _GEN_987;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_1026;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1027 = _GEN_274 | _GEN_988;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_1028;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1029 = _GEN_277 | _GEN_989;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_1030;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1031 = _GEN_280 | _GEN_990;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_1032;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1033 = _GEN_283 | _GEN_991;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_1034;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1035 = _GEN_286 | _GEN_992;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_1036;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1037 = _GEN_289 | _GEN_993;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_1038;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1039 = _GEN_292 | _GEN_994;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_1040;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1041 = _GEN_295 | _GEN_995;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_1042;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1043 = _GEN_298 | _GEN_996;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_1044;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1045 = _GEN_301 | _GEN_997;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_1046;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1047 = _GEN_304 | _GEN_998;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_1048;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1049 = _GEN_307 | _GEN_999;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_1050;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1051 = _GEN_310 | _GEN_1000;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_1052;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1053 = _GEN_313 | _GEN_1001;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_1054;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1055 = _GEN_316 | _GEN_1002;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_1056;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1057 = _GEN_319 | _GEN_1003;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_1058;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1059 = _GEN_322 | _GEN_1004;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_1060;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1061 = _GEN_325 | _GEN_1005;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_1062;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1063 = _GEN_328 | _GEN_1006;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_1064;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1065 = _GEN_331 | _GEN_1007;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_1066;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1067 = _GEN_334 | _GEN_1008;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_1068;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1069 = _GEN_337 | _GEN_1009;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_1070;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1071 = _GEN_340 | _GEN_1010;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_1072;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1073 = _GEN_343 | _GEN_1011;	// rob.scala:323:29, :346:69, :347:31
    automatic logic        _GEN_1074;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1075 =
      (&(io_wb_resps_1_bits_uop_rob_idx[5:1])) | _GEN_1012;	// rob.scala:268:25, :323:29, :346:69, :347:31
    automatic logic        _GEN_1076;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1077;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1078;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1079;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1080;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1081;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1082;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1083;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1084;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1085;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1086;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1087;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1088;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1089;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1090;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1091;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1092;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1093;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1094;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1095;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1096;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1097;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1098;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1099;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1100;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1101;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1102;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1103;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1104;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1105;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1106;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1107;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1108;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1109 = _GEN_31 & _GEN_380;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1110 = _GEN_31 & _GEN_382;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1111 = _GEN_31 & _GEN_384;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1112 = _GEN_31 & _GEN_386;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1113 = _GEN_31 & _GEN_388;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1114 = _GEN_31 & _GEN_390;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1115 = _GEN_31 & _GEN_392;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1116 = _GEN_31 & _GEN_394;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1117 = _GEN_31 & _GEN_396;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1118 = _GEN_31 & _GEN_398;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1119 = _GEN_31 & _GEN_400;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1120 = _GEN_31 & _GEN_402;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1121 = _GEN_31 & _GEN_404;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1122 = _GEN_31 & _GEN_406;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1123 = _GEN_31 & _GEN_408;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1124 = _GEN_31 & _GEN_410;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1125 = _GEN_31 & _GEN_412;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1126 = _GEN_31 & _GEN_414;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1127 = _GEN_31 & _GEN_416;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1128 = _GEN_31 & _GEN_418;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1129 = _GEN_31 & _GEN_420;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1130 = _GEN_31 & _GEN_422;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1131 = _GEN_31 & _GEN_424;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1132 = _GEN_31 & _GEN_426;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1133 = _GEN_31 & _GEN_428;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1134 = _GEN_31 & _GEN_430;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1135 = _GEN_31 & _GEN_432;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1136 = _GEN_31 & _GEN_434;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1137 = _GEN_31 & _GEN_436;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1138 = _GEN_31 & _GEN_438;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1139 = _GEN_31 & _GEN_440;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1140 = _GEN_31 & (&(io_wb_resps_2_bits_uop_rob_idx[5:1]));	// rob.scala:268:25, :346:{27,69}, :347:31
    automatic logic        _GEN_1141 = _GEN_443 | _GEN_1109;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1142;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1143 = _GEN_446 | _GEN_1110;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1144;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1145 = _GEN_449 | _GEN_1111;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1146;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1147 = _GEN_452 | _GEN_1112;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1148;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1149 = _GEN_455 | _GEN_1113;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1150;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1151 = _GEN_458 | _GEN_1114;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1152;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1153 = _GEN_461 | _GEN_1115;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1154;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1155 = _GEN_464 | _GEN_1116;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1156;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1157 = _GEN_467 | _GEN_1117;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1158;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1159 = _GEN_470 | _GEN_1118;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1160;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1161 = _GEN_473 | _GEN_1119;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1162;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1163 = _GEN_476 | _GEN_1120;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1164;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1165 = _GEN_479 | _GEN_1121;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1166;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1167 = _GEN_482 | _GEN_1122;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1168;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1169 = _GEN_485 | _GEN_1123;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1170;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1171 = _GEN_488 | _GEN_1124;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1172;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1173 = _GEN_491 | _GEN_1125;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1174;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1175 = _GEN_494 | _GEN_1126;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1176;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1177 = _GEN_497 | _GEN_1127;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1178;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1179 = _GEN_500 | _GEN_1128;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1180;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1181 = _GEN_503 | _GEN_1129;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1182;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1183 = _GEN_506 | _GEN_1130;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1184;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1185 = _GEN_509 | _GEN_1131;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1186;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1187 = _GEN_512 | _GEN_1132;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1188;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1189 = _GEN_515 | _GEN_1133;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1190;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1191 = _GEN_518 | _GEN_1134;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1192;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1193 = _GEN_521 | _GEN_1135;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1194;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1195 = _GEN_524 | _GEN_1136;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1196;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1197 = _GEN_527 | _GEN_1137;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1198;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1199 = _GEN_530 | _GEN_1138;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1200;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1201 = _GEN_533 | _GEN_1139;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1202;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1203 =
      (&(io_wb_resps_3_bits_uop_rob_idx[5:1])) | _GEN_1140;	// rob.scala:268:25, :346:69, :347:31
    automatic logic        _GEN_1204;	// rob.scala:346:69, :347:31
    automatic logic        _GEN_1205;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1206;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1207;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1208;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1209;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1210;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1211;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1212;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1213;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1214;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1215;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1216;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1217;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1218;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1219;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1220;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1221;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1222;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1223;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1224;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1225;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1226;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1227;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1228;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1229;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1230;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1231;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1232;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1233;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1234;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1235;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1236;	// rob.scala:346:69, :348:31
    automatic logic        _GEN_1237 = _GEN_33 & _GEN_570;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1238 = _GEN_33 & _GEN_572;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1239 = _GEN_33 & _GEN_574;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1240 = _GEN_33 & _GEN_576;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1241 = _GEN_33 & _GEN_578;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1242 = _GEN_33 & _GEN_580;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1243 = _GEN_33 & _GEN_582;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1244 = _GEN_33 & _GEN_584;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1245 = _GEN_33 & _GEN_586;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1246 = _GEN_33 & _GEN_588;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1247 = _GEN_33 & _GEN_590;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1248 = _GEN_33 & _GEN_592;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1249 = _GEN_33 & _GEN_594;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1250 = _GEN_33 & _GEN_596;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1251 = _GEN_33 & _GEN_598;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1252 = _GEN_33 & _GEN_600;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1253 = _GEN_33 & _GEN_602;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1254 = _GEN_33 & _GEN_604;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1255 = _GEN_33 & _GEN_606;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1256 = _GEN_33 & _GEN_608;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1257 = _GEN_33 & _GEN_610;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1258 = _GEN_33 & _GEN_612;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1259 = _GEN_33 & _GEN_614;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1260 = _GEN_33 & _GEN_616;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1261 = _GEN_33 & _GEN_618;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1262 = _GEN_33 & _GEN_620;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1263 = _GEN_33 & _GEN_622;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1264 = _GEN_33 & _GEN_624;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1265 = _GEN_33 & _GEN_626;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1266 = _GEN_33 & _GEN_628;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1267 = _GEN_33 & _GEN_630;	// rob.scala:346:{27,69}, :347:31
    automatic logic        _GEN_1268 = _GEN_33 & (&(io_wb_resps_4_bits_uop_rob_idx[5:1]));	// rob.scala:268:25, :346:{27,69}, :347:31
    automatic logic        _GEN_1269 = _GEN_633 | _GEN_1237;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_1270 = _GEN_635 | _GEN_1238;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_1271 = _GEN_637 | _GEN_1239;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_1272 = _GEN_639 | _GEN_1240;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_1273 = _GEN_641 | _GEN_1241;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_1274 = _GEN_643 | _GEN_1242;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_1275 = _GEN_645 | _GEN_1243;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_1276 = _GEN_647 | _GEN_1244;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_1277 = _GEN_649 | _GEN_1245;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_1278 = _GEN_651 | _GEN_1246;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_1279 = _GEN_653 | _GEN_1247;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_1280 = _GEN_655 | _GEN_1248;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_1281 = _GEN_657 | _GEN_1249;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_1282 = _GEN_659 | _GEN_1250;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_1283 = _GEN_661 | _GEN_1251;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_1284 = _GEN_663 | _GEN_1252;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_1285 = _GEN_665 | _GEN_1253;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_1286 = _GEN_667 | _GEN_1254;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_1287 = _GEN_669 | _GEN_1255;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_1288 = _GEN_671 | _GEN_1256;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_1289 = _GEN_673 | _GEN_1257;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_1290 = _GEN_675 | _GEN_1258;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_1291 = _GEN_677 | _GEN_1259;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_1292 = _GEN_679 | _GEN_1260;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_1293 = _GEN_681 | _GEN_1261;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_1294 = _GEN_683 | _GEN_1262;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_1295 = _GEN_685 | _GEN_1263;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_1296 = _GEN_687 | _GEN_1264;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_1297 = _GEN_689 | _GEN_1265;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_1298 = _GEN_691 | _GEN_1266;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_1299 = _GEN_693 | _GEN_1267;	// rob.scala:346:69, :347:31, :363:26
    automatic logic        _GEN_1300 = (&(io_lsu_clr_bsy_0_bits[5:1])) | _GEN_1268;	// rob.scala:268:25, :346:69, :347:31, :363:26
    automatic logic        _GEN_1301 = _GEN_36 & _GEN_696;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_1302 = _GEN_36 & _GEN_698;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_1303 = _GEN_36 & _GEN_700;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_1304 = _GEN_36 & _GEN_702;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_1305 = _GEN_36 & _GEN_704;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_1306 = _GEN_36 & _GEN_706;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_1307 = _GEN_36 & _GEN_708;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_1308 = _GEN_36 & _GEN_710;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_1309 = _GEN_36 & _GEN_712;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_1310 = _GEN_36 & _GEN_714;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_1311 = _GEN_36 & _GEN_716;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_1312 = _GEN_36 & _GEN_718;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_1313 = _GEN_36 & _GEN_720;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_1314 = _GEN_36 & _GEN_722;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_1315 = _GEN_36 & _GEN_724;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_1316 = _GEN_36 & _GEN_726;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_1317 = _GEN_36 & _GEN_728;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_1318 = _GEN_36 & _GEN_730;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_1319 = _GEN_36 & _GEN_732;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_1320 = _GEN_36 & _GEN_734;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_1321 = _GEN_36 & _GEN_736;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_1322 = _GEN_36 & _GEN_738;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_1323 = _GEN_36 & _GEN_740;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_1324 = _GEN_36 & _GEN_742;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_1325 = _GEN_36 & _GEN_744;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_1326 = _GEN_36 & _GEN_746;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_1327 = _GEN_36 & _GEN_748;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_1328 = _GEN_36 & _GEN_750;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_1329 = _GEN_36 & _GEN_752;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_1330 = _GEN_36 & _GEN_754;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_1331 = _GEN_36 & _GEN_756;	// rob.scala:361:{31,75}, :363:26
    automatic logic        _GEN_1332 = _GEN_36 & (&(io_lsu_clr_bsy_1_bits[5:1]));	// rob.scala:268:25, :361:{31,75}, :363:26
    automatic logic        _GEN_1333;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_1334;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_1335;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_1336;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_1337;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_1338;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_1339;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_1340;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_1341;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_1342;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_1343;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_1344;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_1345;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_1346;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_1347;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_1348;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_1349;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_1350;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_1351;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_1352;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_1353;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_1354;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_1355;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_1356;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_1357;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_1358;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_1359;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_1360;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_1361;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_1362;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_1363;	// rob.scala:323:29, :433:20, :434:30
    automatic logic        _GEN_1364;	// rob.scala:323:29, :433:20, :434:30
    automatic logic [11:0] _GEN_1365;	// util.scala:118:51
    automatic logic [11:0] _GEN_1366;	// util.scala:118:51
    automatic logic [11:0] _GEN_1367;	// util.scala:118:51
    automatic logic [11:0] _GEN_1368;	// util.scala:118:51
    automatic logic [11:0] _GEN_1369;	// util.scala:118:51
    automatic logic [11:0] _GEN_1370;	// util.scala:118:51
    automatic logic [11:0] _GEN_1371;	// util.scala:118:51
    automatic logic [11:0] _GEN_1372;	// util.scala:118:51
    automatic logic [11:0] _GEN_1373;	// util.scala:118:51
    automatic logic [11:0] _GEN_1374;	// util.scala:118:51
    automatic logic [11:0] _GEN_1375;	// util.scala:118:51
    automatic logic [11:0] _GEN_1376;	// util.scala:118:51
    automatic logic [11:0] _GEN_1377;	// util.scala:118:51
    automatic logic [11:0] _GEN_1378;	// util.scala:118:51
    automatic logic [11:0] _GEN_1379;	// util.scala:118:51
    automatic logic [11:0] _GEN_1380;	// util.scala:118:51
    automatic logic [11:0] _GEN_1381;	// util.scala:118:51
    automatic logic [11:0] _GEN_1382;	// util.scala:118:51
    automatic logic [11:0] _GEN_1383;	// util.scala:118:51
    automatic logic [11:0] _GEN_1384;	// util.scala:118:51
    automatic logic [11:0] _GEN_1385;	// util.scala:118:51
    automatic logic [11:0] _GEN_1386;	// util.scala:118:51
    automatic logic [11:0] _GEN_1387;	// util.scala:118:51
    automatic logic [11:0] _GEN_1388;	// util.scala:118:51
    automatic logic [11:0] _GEN_1389;	// util.scala:118:51
    automatic logic [11:0] _GEN_1390;	// util.scala:118:51
    automatic logic [11:0] _GEN_1391;	// util.scala:118:51
    automatic logic [11:0] _GEN_1392;	// util.scala:118:51
    automatic logic [11:0] _GEN_1393;	// util.scala:118:51
    automatic logic [11:0] _GEN_1394;	// util.scala:118:51
    automatic logic [11:0] _GEN_1395;	// util.scala:118:51
    automatic logic [11:0] _GEN_1396;	// util.scala:118:51
    automatic logic        enq_xcpts_0;	// rob.scala:628:38
    automatic logic        _GEN_1397;	// rob.scala:631:47
    automatic logic        _GEN_1398;	// rob.scala:635:25
    automatic logic        _GEN_1399;	// rob.scala:641:30
    automatic logic [11:0] next_xcpt_uop_br_mask;	// rob.scala:625:17, :631:76, :632:27
    _GEN_63 = rob_tail == 5'h0;	// rob.scala:224:29, :228:29, :324:31
    _GEN_64 = io_enq_valids_0 & _GEN_63;	// rob.scala:307:32, :323:29, :324:31
    _GEN_65 = rob_tail == 5'h1;	// rob.scala:228:29, :324:31
    _GEN_66 = io_enq_valids_0 & _GEN_65;	// rob.scala:307:32, :323:29, :324:31
    _GEN_67 = rob_tail == 5'h2;	// rob.scala:228:29, :324:31
    _GEN_68 = io_enq_valids_0 & _GEN_67;	// rob.scala:307:32, :323:29, :324:31
    _GEN_69 = rob_tail == 5'h3;	// rob.scala:228:29, :324:31
    _GEN_70 = io_enq_valids_0 & _GEN_69;	// rob.scala:307:32, :323:29, :324:31
    _GEN_71 = rob_tail == 5'h4;	// rob.scala:228:29, :324:31
    _GEN_72 = io_enq_valids_0 & _GEN_71;	// rob.scala:307:32, :323:29, :324:31
    _GEN_73 = rob_tail == 5'h5;	// rob.scala:228:29, :324:31
    _GEN_74 = io_enq_valids_0 & _GEN_73;	// rob.scala:307:32, :323:29, :324:31
    _GEN_75 = rob_tail == 5'h6;	// rob.scala:228:29, :324:31
    _GEN_76 = io_enq_valids_0 & _GEN_75;	// rob.scala:307:32, :323:29, :324:31
    _GEN_77 = rob_tail == 5'h7;	// rob.scala:228:29, :324:31
    _GEN_78 = io_enq_valids_0 & _GEN_77;	// rob.scala:307:32, :323:29, :324:31
    _GEN_79 = rob_tail == 5'h8;	// rob.scala:228:29, :324:31
    _GEN_80 = io_enq_valids_0 & _GEN_79;	// rob.scala:307:32, :323:29, :324:31
    _GEN_81 = rob_tail == 5'h9;	// rob.scala:228:29, :324:31
    _GEN_82 = io_enq_valids_0 & _GEN_81;	// rob.scala:307:32, :323:29, :324:31
    _GEN_83 = rob_tail == 5'hA;	// rob.scala:228:29, :324:31
    _GEN_84 = io_enq_valids_0 & _GEN_83;	// rob.scala:307:32, :323:29, :324:31
    _GEN_85 = rob_tail == 5'hB;	// rob.scala:228:29, :324:31
    _GEN_86 = io_enq_valids_0 & _GEN_85;	// rob.scala:307:32, :323:29, :324:31
    _GEN_87 = rob_tail == 5'hC;	// rob.scala:228:29, :324:31
    _GEN_88 = io_enq_valids_0 & _GEN_87;	// rob.scala:307:32, :323:29, :324:31
    _GEN_89 = rob_tail == 5'hD;	// rob.scala:228:29, :324:31
    _GEN_90 = io_enq_valids_0 & _GEN_89;	// rob.scala:307:32, :323:29, :324:31
    _GEN_91 = rob_tail == 5'hE;	// rob.scala:228:29, :324:31
    _GEN_92 = io_enq_valids_0 & _GEN_91;	// rob.scala:307:32, :323:29, :324:31
    _GEN_93 = rob_tail == 5'hF;	// rob.scala:228:29, :324:31
    _GEN_94 = io_enq_valids_0 & _GEN_93;	// rob.scala:307:32, :323:29, :324:31
    _GEN_95 = rob_tail == 5'h10;	// rob.scala:228:29, :324:31
    _GEN_96 = io_enq_valids_0 & _GEN_95;	// rob.scala:307:32, :323:29, :324:31
    _GEN_97 = rob_tail == 5'h11;	// rob.scala:228:29, :324:31
    _GEN_98 = io_enq_valids_0 & _GEN_97;	// rob.scala:307:32, :323:29, :324:31
    _GEN_99 = rob_tail == 5'h12;	// rob.scala:228:29, :324:31
    _GEN_100 = io_enq_valids_0 & _GEN_99;	// rob.scala:307:32, :323:29, :324:31
    _GEN_101 = rob_tail == 5'h13;	// rob.scala:228:29, :324:31
    _GEN_102 = io_enq_valids_0 & _GEN_101;	// rob.scala:307:32, :323:29, :324:31
    _GEN_103 = rob_tail == 5'h14;	// rob.scala:228:29, :324:31
    _GEN_104 = io_enq_valids_0 & _GEN_103;	// rob.scala:307:32, :323:29, :324:31
    _GEN_105 = rob_tail == 5'h15;	// rob.scala:228:29, :324:31
    _GEN_106 = io_enq_valids_0 & _GEN_105;	// rob.scala:307:32, :323:29, :324:31
    _GEN_107 = rob_tail == 5'h16;	// rob.scala:228:29, :324:31
    _GEN_108 = io_enq_valids_0 & _GEN_107;	// rob.scala:307:32, :323:29, :324:31
    _GEN_109 = rob_tail == 5'h17;	// rob.scala:228:29, :324:31
    _GEN_110 = io_enq_valids_0 & _GEN_109;	// rob.scala:307:32, :323:29, :324:31
    _GEN_111 = rob_tail == 5'h18;	// rob.scala:228:29, :324:31
    _GEN_112 = io_enq_valids_0 & _GEN_111;	// rob.scala:307:32, :323:29, :324:31
    _GEN_113 = rob_tail == 5'h19;	// rob.scala:228:29, :324:31
    _GEN_114 = io_enq_valids_0 & _GEN_113;	// rob.scala:307:32, :323:29, :324:31
    _GEN_115 = rob_tail == 5'h1A;	// rob.scala:228:29, :324:31
    _GEN_116 = io_enq_valids_0 & _GEN_115;	// rob.scala:307:32, :323:29, :324:31
    _GEN_117 = rob_tail == 5'h1B;	// rob.scala:228:29, :324:31
    _GEN_118 = io_enq_valids_0 & _GEN_117;	// rob.scala:307:32, :323:29, :324:31
    _GEN_119 = rob_tail == 5'h1C;	// rob.scala:228:29, :324:31
    _GEN_120 = io_enq_valids_0 & _GEN_119;	// rob.scala:307:32, :323:29, :324:31
    _GEN_121 = rob_tail == 5'h1D;	// rob.scala:228:29, :324:31
    _GEN_122 = io_enq_valids_0 & _GEN_121;	// rob.scala:307:32, :323:29, :324:31
    _GEN_123 = rob_tail == 5'h1E;	// rob.scala:228:29, :324:31
    _GEN_124 = io_enq_valids_0 & _GEN_123;	// rob.scala:307:32, :323:29, :324:31
    _GEN_125 = io_enq_valids_0 & (&rob_tail);	// rob.scala:228:29, :307:32, :323:29, :324:31
    _GEN_126 = _GEN_64 ? ~_rob_bsy_T : rob_bsy_0;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_127 = _GEN_66 ? ~_rob_bsy_T : rob_bsy_1;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_128 = _GEN_68 ? ~_rob_bsy_T : rob_bsy_2;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_129 = _GEN_70 ? ~_rob_bsy_T : rob_bsy_3;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_130 = _GEN_72 ? ~_rob_bsy_T : rob_bsy_4;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_131 = _GEN_74 ? ~_rob_bsy_T : rob_bsy_5;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_132 = _GEN_76 ? ~_rob_bsy_T : rob_bsy_6;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_133 = _GEN_78 ? ~_rob_bsy_T : rob_bsy_7;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_134 = _GEN_80 ? ~_rob_bsy_T : rob_bsy_8;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_135 = _GEN_82 ? ~_rob_bsy_T : rob_bsy_9;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_136 = _GEN_84 ? ~_rob_bsy_T : rob_bsy_10;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_137 = _GEN_86 ? ~_rob_bsy_T : rob_bsy_11;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_138 = _GEN_88 ? ~_rob_bsy_T : rob_bsy_12;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_139 = _GEN_90 ? ~_rob_bsy_T : rob_bsy_13;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_140 = _GEN_92 ? ~_rob_bsy_T : rob_bsy_14;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_141 = _GEN_94 ? ~_rob_bsy_T : rob_bsy_15;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_142 = _GEN_96 ? ~_rob_bsy_T : rob_bsy_16;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_143 = _GEN_98 ? ~_rob_bsy_T : rob_bsy_17;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_144 = _GEN_100 ? ~_rob_bsy_T : rob_bsy_18;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_145 = _GEN_102 ? ~_rob_bsy_T : rob_bsy_19;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_146 = _GEN_104 ? ~_rob_bsy_T : rob_bsy_20;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_147 = _GEN_106 ? ~_rob_bsy_T : rob_bsy_21;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_148 = _GEN_108 ? ~_rob_bsy_T : rob_bsy_22;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_149 = _GEN_110 ? ~_rob_bsy_T : rob_bsy_23;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_150 = _GEN_112 ? ~_rob_bsy_T : rob_bsy_24;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_151 = _GEN_114 ? ~_rob_bsy_T : rob_bsy_25;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_152 = _GEN_116 ? ~_rob_bsy_T : rob_bsy_26;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_153 = _GEN_118 ? ~_rob_bsy_T : rob_bsy_27;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_154 = _GEN_120 ? ~_rob_bsy_T : rob_bsy_28;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_155 = _GEN_122 ? ~_rob_bsy_T : rob_bsy_29;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_156 = _GEN_124 ? ~_rob_bsy_T : rob_bsy_30;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_157 = _GEN_125 ? ~_rob_bsy_T : rob_bsy_31;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_158 = _GEN_64 ? _rob_unsafe_T_4 : rob_unsafe_0;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_159 = _GEN_66 ? _rob_unsafe_T_4 : rob_unsafe_1;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_160 = _GEN_68 ? _rob_unsafe_T_4 : rob_unsafe_2;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_161 = _GEN_70 ? _rob_unsafe_T_4 : rob_unsafe_3;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_162 = _GEN_72 ? _rob_unsafe_T_4 : rob_unsafe_4;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_163 = _GEN_74 ? _rob_unsafe_T_4 : rob_unsafe_5;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_164 = _GEN_76 ? _rob_unsafe_T_4 : rob_unsafe_6;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_165 = _GEN_78 ? _rob_unsafe_T_4 : rob_unsafe_7;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_166 = _GEN_80 ? _rob_unsafe_T_4 : rob_unsafe_8;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_167 = _GEN_82 ? _rob_unsafe_T_4 : rob_unsafe_9;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_168 = _GEN_84 ? _rob_unsafe_T_4 : rob_unsafe_10;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_169 = _GEN_86 ? _rob_unsafe_T_4 : rob_unsafe_11;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_170 = _GEN_88 ? _rob_unsafe_T_4 : rob_unsafe_12;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_171 = _GEN_90 ? _rob_unsafe_T_4 : rob_unsafe_13;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_172 = _GEN_92 ? _rob_unsafe_T_4 : rob_unsafe_14;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_173 = _GEN_94 ? _rob_unsafe_T_4 : rob_unsafe_15;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_174 = _GEN_96 ? _rob_unsafe_T_4 : rob_unsafe_16;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_175 = _GEN_98 ? _rob_unsafe_T_4 : rob_unsafe_17;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_176 = _GEN_100 ? _rob_unsafe_T_4 : rob_unsafe_18;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_177 = _GEN_102 ? _rob_unsafe_T_4 : rob_unsafe_19;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_178 = _GEN_104 ? _rob_unsafe_T_4 : rob_unsafe_20;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_179 = _GEN_106 ? _rob_unsafe_T_4 : rob_unsafe_21;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_180 = _GEN_108 ? _rob_unsafe_T_4 : rob_unsafe_22;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_181 = _GEN_110 ? _rob_unsafe_T_4 : rob_unsafe_23;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_182 = _GEN_112 ? _rob_unsafe_T_4 : rob_unsafe_24;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_183 = _GEN_114 ? _rob_unsafe_T_4 : rob_unsafe_25;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_184 = _GEN_116 ? _rob_unsafe_T_4 : rob_unsafe_26;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_185 = _GEN_118 ? _rob_unsafe_T_4 : rob_unsafe_27;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_186 = _GEN_120 ? _rob_unsafe_T_4 : rob_unsafe_28;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_187 = _GEN_122 ? _rob_unsafe_T_4 : rob_unsafe_29;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_188 = _GEN_124 ? _rob_unsafe_T_4 : rob_unsafe_30;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_189 = _GEN_125 ? _rob_unsafe_T_4 : rob_unsafe_31;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_255 = _GEN_1 ? ~_GEN_254 & _GEN_126 : ~_GEN_191 & _GEN_126;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_258 = _GEN_1 ? ~_GEN_257 & _GEN_127 : ~_GEN_193 & _GEN_127;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_261 = _GEN_1 ? ~_GEN_260 & _GEN_128 : ~_GEN_195 & _GEN_128;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_264 = _GEN_1 ? ~_GEN_263 & _GEN_129 : ~_GEN_197 & _GEN_129;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_267 = _GEN_1 ? ~_GEN_266 & _GEN_130 : ~_GEN_199 & _GEN_130;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_270 = _GEN_1 ? ~_GEN_269 & _GEN_131 : ~_GEN_201 & _GEN_131;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_273 = _GEN_1 ? ~_GEN_272 & _GEN_132 : ~_GEN_203 & _GEN_132;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_276 = _GEN_1 ? ~_GEN_275 & _GEN_133 : ~_GEN_205 & _GEN_133;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_279 = _GEN_1 ? ~_GEN_278 & _GEN_134 : ~_GEN_207 & _GEN_134;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_282 = _GEN_1 ? ~_GEN_281 & _GEN_135 : ~_GEN_209 & _GEN_135;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_285 = _GEN_1 ? ~_GEN_284 & _GEN_136 : ~_GEN_211 & _GEN_136;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_288 = _GEN_1 ? ~_GEN_287 & _GEN_137 : ~_GEN_213 & _GEN_137;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_291 = _GEN_1 ? ~_GEN_290 & _GEN_138 : ~_GEN_215 & _GEN_138;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_294 = _GEN_1 ? ~_GEN_293 & _GEN_139 : ~_GEN_217 & _GEN_139;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_297 = _GEN_1 ? ~_GEN_296 & _GEN_140 : ~_GEN_219 & _GEN_140;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_300 = _GEN_1 ? ~_GEN_299 & _GEN_141 : ~_GEN_221 & _GEN_141;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_303 = _GEN_1 ? ~_GEN_302 & _GEN_142 : ~_GEN_223 & _GEN_142;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_306 = _GEN_1 ? ~_GEN_305 & _GEN_143 : ~_GEN_225 & _GEN_143;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_309 = _GEN_1 ? ~_GEN_308 & _GEN_144 : ~_GEN_227 & _GEN_144;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_312 = _GEN_1 ? ~_GEN_311 & _GEN_145 : ~_GEN_229 & _GEN_145;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_315 = _GEN_1 ? ~_GEN_314 & _GEN_146 : ~_GEN_231 & _GEN_146;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_318 = _GEN_1 ? ~_GEN_317 & _GEN_147 : ~_GEN_233 & _GEN_147;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_321 = _GEN_1 ? ~_GEN_320 & _GEN_148 : ~_GEN_235 & _GEN_148;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_324 = _GEN_1 ? ~_GEN_323 & _GEN_149 : ~_GEN_237 & _GEN_149;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_327 = _GEN_1 ? ~_GEN_326 & _GEN_150 : ~_GEN_239 & _GEN_150;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_330 = _GEN_1 ? ~_GEN_329 & _GEN_151 : ~_GEN_241 & _GEN_151;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_333 = _GEN_1 ? ~_GEN_332 & _GEN_152 : ~_GEN_243 & _GEN_152;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_336 = _GEN_1 ? ~_GEN_335 & _GEN_153 : ~_GEN_245 & _GEN_153;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_339 = _GEN_1 ? ~_GEN_338 & _GEN_154 : ~_GEN_247 & _GEN_154;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_342 = _GEN_1 ? ~_GEN_341 & _GEN_155 : ~_GEN_249 & _GEN_155;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_345 = _GEN_1 ? ~_GEN_344 & _GEN_156 : ~_GEN_251 & _GEN_156;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_347 = _GEN_1 ? ~_GEN_346 & _GEN_157 : ~_GEN_252 & _GEN_157;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_348 = _GEN_1 ? ~_GEN_254 & _GEN_158 : ~_GEN_191 & _GEN_158;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_349 = _GEN_1 ? ~_GEN_257 & _GEN_159 : ~_GEN_193 & _GEN_159;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_350 = _GEN_1 ? ~_GEN_260 & _GEN_160 : ~_GEN_195 & _GEN_160;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_351 = _GEN_1 ? ~_GEN_263 & _GEN_161 : ~_GEN_197 & _GEN_161;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_352 = _GEN_1 ? ~_GEN_266 & _GEN_162 : ~_GEN_199 & _GEN_162;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_353 = _GEN_1 ? ~_GEN_269 & _GEN_163 : ~_GEN_201 & _GEN_163;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_354 = _GEN_1 ? ~_GEN_272 & _GEN_164 : ~_GEN_203 & _GEN_164;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_355 = _GEN_1 ? ~_GEN_275 & _GEN_165 : ~_GEN_205 & _GEN_165;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_356 = _GEN_1 ? ~_GEN_278 & _GEN_166 : ~_GEN_207 & _GEN_166;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_357 = _GEN_1 ? ~_GEN_281 & _GEN_167 : ~_GEN_209 & _GEN_167;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_358 = _GEN_1 ? ~_GEN_284 & _GEN_168 : ~_GEN_211 & _GEN_168;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_359 = _GEN_1 ? ~_GEN_287 & _GEN_169 : ~_GEN_213 & _GEN_169;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_360 = _GEN_1 ? ~_GEN_290 & _GEN_170 : ~_GEN_215 & _GEN_170;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_361 = _GEN_1 ? ~_GEN_293 & _GEN_171 : ~_GEN_217 & _GEN_171;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_362 = _GEN_1 ? ~_GEN_296 & _GEN_172 : ~_GEN_219 & _GEN_172;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_363 = _GEN_1 ? ~_GEN_299 & _GEN_173 : ~_GEN_221 & _GEN_173;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_364 = _GEN_1 ? ~_GEN_302 & _GEN_174 : ~_GEN_223 & _GEN_174;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_365 = _GEN_1 ? ~_GEN_305 & _GEN_175 : ~_GEN_225 & _GEN_175;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_366 = _GEN_1 ? ~_GEN_308 & _GEN_176 : ~_GEN_227 & _GEN_176;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_367 = _GEN_1 ? ~_GEN_311 & _GEN_177 : ~_GEN_229 & _GEN_177;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_368 = _GEN_1 ? ~_GEN_314 & _GEN_178 : ~_GEN_231 & _GEN_178;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_369 = _GEN_1 ? ~_GEN_317 & _GEN_179 : ~_GEN_233 & _GEN_179;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_370 = _GEN_1 ? ~_GEN_320 & _GEN_180 : ~_GEN_235 & _GEN_180;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_371 = _GEN_1 ? ~_GEN_323 & _GEN_181 : ~_GEN_237 & _GEN_181;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_372 = _GEN_1 ? ~_GEN_326 & _GEN_182 : ~_GEN_239 & _GEN_182;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_373 = _GEN_1 ? ~_GEN_329 & _GEN_183 : ~_GEN_241 & _GEN_183;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_374 = _GEN_1 ? ~_GEN_332 & _GEN_184 : ~_GEN_243 & _GEN_184;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_375 = _GEN_1 ? ~_GEN_335 & _GEN_185 : ~_GEN_245 & _GEN_185;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_376 = _GEN_1 ? ~_GEN_338 & _GEN_186 : ~_GEN_247 & _GEN_186;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_377 = _GEN_1 ? ~_GEN_341 & _GEN_187 : ~_GEN_249 & _GEN_187;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_378 = _GEN_1 ? ~_GEN_344 & _GEN_188 : ~_GEN_251 & _GEN_188;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_379 = _GEN_1 ? ~_GEN_346 & _GEN_189 : ~_GEN_252 & _GEN_189;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_445 = _GEN_3 ? ~_GEN_444 & _GEN_255 : ~_GEN_381 & _GEN_255;	// rob.scala:346:{27,69}, :347:31
    _GEN_448 = _GEN_3 ? ~_GEN_447 & _GEN_258 : ~_GEN_383 & _GEN_258;	// rob.scala:346:{27,69}, :347:31
    _GEN_451 = _GEN_3 ? ~_GEN_450 & _GEN_261 : ~_GEN_385 & _GEN_261;	// rob.scala:346:{27,69}, :347:31
    _GEN_454 = _GEN_3 ? ~_GEN_453 & _GEN_264 : ~_GEN_387 & _GEN_264;	// rob.scala:346:{27,69}, :347:31
    _GEN_457 = _GEN_3 ? ~_GEN_456 & _GEN_267 : ~_GEN_389 & _GEN_267;	// rob.scala:346:{27,69}, :347:31
    _GEN_460 = _GEN_3 ? ~_GEN_459 & _GEN_270 : ~_GEN_391 & _GEN_270;	// rob.scala:346:{27,69}, :347:31
    _GEN_463 = _GEN_3 ? ~_GEN_462 & _GEN_273 : ~_GEN_393 & _GEN_273;	// rob.scala:346:{27,69}, :347:31
    _GEN_466 = _GEN_3 ? ~_GEN_465 & _GEN_276 : ~_GEN_395 & _GEN_276;	// rob.scala:346:{27,69}, :347:31
    _GEN_469 = _GEN_3 ? ~_GEN_468 & _GEN_279 : ~_GEN_397 & _GEN_279;	// rob.scala:346:{27,69}, :347:31
    _GEN_472 = _GEN_3 ? ~_GEN_471 & _GEN_282 : ~_GEN_399 & _GEN_282;	// rob.scala:346:{27,69}, :347:31
    _GEN_475 = _GEN_3 ? ~_GEN_474 & _GEN_285 : ~_GEN_401 & _GEN_285;	// rob.scala:346:{27,69}, :347:31
    _GEN_478 = _GEN_3 ? ~_GEN_477 & _GEN_288 : ~_GEN_403 & _GEN_288;	// rob.scala:346:{27,69}, :347:31
    _GEN_481 = _GEN_3 ? ~_GEN_480 & _GEN_291 : ~_GEN_405 & _GEN_291;	// rob.scala:346:{27,69}, :347:31
    _GEN_484 = _GEN_3 ? ~_GEN_483 & _GEN_294 : ~_GEN_407 & _GEN_294;	// rob.scala:346:{27,69}, :347:31
    _GEN_487 = _GEN_3 ? ~_GEN_486 & _GEN_297 : ~_GEN_409 & _GEN_297;	// rob.scala:346:{27,69}, :347:31
    _GEN_490 = _GEN_3 ? ~_GEN_489 & _GEN_300 : ~_GEN_411 & _GEN_300;	// rob.scala:346:{27,69}, :347:31
    _GEN_493 = _GEN_3 ? ~_GEN_492 & _GEN_303 : ~_GEN_413 & _GEN_303;	// rob.scala:346:{27,69}, :347:31
    _GEN_496 = _GEN_3 ? ~_GEN_495 & _GEN_306 : ~_GEN_415 & _GEN_306;	// rob.scala:346:{27,69}, :347:31
    _GEN_499 = _GEN_3 ? ~_GEN_498 & _GEN_309 : ~_GEN_417 & _GEN_309;	// rob.scala:346:{27,69}, :347:31
    _GEN_502 = _GEN_3 ? ~_GEN_501 & _GEN_312 : ~_GEN_419 & _GEN_312;	// rob.scala:346:{27,69}, :347:31
    _GEN_505 = _GEN_3 ? ~_GEN_504 & _GEN_315 : ~_GEN_421 & _GEN_315;	// rob.scala:346:{27,69}, :347:31
    _GEN_508 = _GEN_3 ? ~_GEN_507 & _GEN_318 : ~_GEN_423 & _GEN_318;	// rob.scala:346:{27,69}, :347:31
    _GEN_511 = _GEN_3 ? ~_GEN_510 & _GEN_321 : ~_GEN_425 & _GEN_321;	// rob.scala:346:{27,69}, :347:31
    _GEN_514 = _GEN_3 ? ~_GEN_513 & _GEN_324 : ~_GEN_427 & _GEN_324;	// rob.scala:346:{27,69}, :347:31
    _GEN_517 = _GEN_3 ? ~_GEN_516 & _GEN_327 : ~_GEN_429 & _GEN_327;	// rob.scala:346:{27,69}, :347:31
    _GEN_520 = _GEN_3 ? ~_GEN_519 & _GEN_330 : ~_GEN_431 & _GEN_330;	// rob.scala:346:{27,69}, :347:31
    _GEN_523 = _GEN_3 ? ~_GEN_522 & _GEN_333 : ~_GEN_433 & _GEN_333;	// rob.scala:346:{27,69}, :347:31
    _GEN_526 = _GEN_3 ? ~_GEN_525 & _GEN_336 : ~_GEN_435 & _GEN_336;	// rob.scala:346:{27,69}, :347:31
    _GEN_529 = _GEN_3 ? ~_GEN_528 & _GEN_339 : ~_GEN_437 & _GEN_339;	// rob.scala:346:{27,69}, :347:31
    _GEN_532 = _GEN_3 ? ~_GEN_531 & _GEN_342 : ~_GEN_439 & _GEN_342;	// rob.scala:346:{27,69}, :347:31
    _GEN_535 = _GEN_3 ? ~_GEN_534 & _GEN_345 : ~_GEN_441 & _GEN_345;	// rob.scala:346:{27,69}, :347:31
    _GEN_537 = _GEN_3 ? ~_GEN_536 & _GEN_347 : ~_GEN_442 & _GEN_347;	// rob.scala:346:{27,69}, :347:31
    _GEN_538 = _GEN_3 ? ~_GEN_444 & _GEN_348 : ~_GEN_381 & _GEN_348;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_539 = _GEN_3 ? ~_GEN_447 & _GEN_349 : ~_GEN_383 & _GEN_349;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_540 = _GEN_3 ? ~_GEN_450 & _GEN_350 : ~_GEN_385 & _GEN_350;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_541 = _GEN_3 ? ~_GEN_453 & _GEN_351 : ~_GEN_387 & _GEN_351;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_542 = _GEN_3 ? ~_GEN_456 & _GEN_352 : ~_GEN_389 & _GEN_352;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_543 = _GEN_3 ? ~_GEN_459 & _GEN_353 : ~_GEN_391 & _GEN_353;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_544 = _GEN_3 ? ~_GEN_462 & _GEN_354 : ~_GEN_393 & _GEN_354;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_545 = _GEN_3 ? ~_GEN_465 & _GEN_355 : ~_GEN_395 & _GEN_355;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_546 = _GEN_3 ? ~_GEN_468 & _GEN_356 : ~_GEN_397 & _GEN_356;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_547 = _GEN_3 ? ~_GEN_471 & _GEN_357 : ~_GEN_399 & _GEN_357;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_548 = _GEN_3 ? ~_GEN_474 & _GEN_358 : ~_GEN_401 & _GEN_358;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_549 = _GEN_3 ? ~_GEN_477 & _GEN_359 : ~_GEN_403 & _GEN_359;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_550 = _GEN_3 ? ~_GEN_480 & _GEN_360 : ~_GEN_405 & _GEN_360;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_551 = _GEN_3 ? ~_GEN_483 & _GEN_361 : ~_GEN_407 & _GEN_361;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_552 = _GEN_3 ? ~_GEN_486 & _GEN_362 : ~_GEN_409 & _GEN_362;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_553 = _GEN_3 ? ~_GEN_489 & _GEN_363 : ~_GEN_411 & _GEN_363;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_554 = _GEN_3 ? ~_GEN_492 & _GEN_364 : ~_GEN_413 & _GEN_364;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_555 = _GEN_3 ? ~_GEN_495 & _GEN_365 : ~_GEN_415 & _GEN_365;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_556 = _GEN_3 ? ~_GEN_498 & _GEN_366 : ~_GEN_417 & _GEN_366;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_557 = _GEN_3 ? ~_GEN_501 & _GEN_367 : ~_GEN_419 & _GEN_367;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_558 = _GEN_3 ? ~_GEN_504 & _GEN_368 : ~_GEN_421 & _GEN_368;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_559 = _GEN_3 ? ~_GEN_507 & _GEN_369 : ~_GEN_423 & _GEN_369;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_560 = _GEN_3 ? ~_GEN_510 & _GEN_370 : ~_GEN_425 & _GEN_370;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_561 = _GEN_3 ? ~_GEN_513 & _GEN_371 : ~_GEN_427 & _GEN_371;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_562 = _GEN_3 ? ~_GEN_516 & _GEN_372 : ~_GEN_429 & _GEN_372;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_563 = _GEN_3 ? ~_GEN_519 & _GEN_373 : ~_GEN_431 & _GEN_373;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_564 = _GEN_3 ? ~_GEN_522 & _GEN_374 : ~_GEN_433 & _GEN_374;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_565 = _GEN_3 ? ~_GEN_525 & _GEN_375 : ~_GEN_435 & _GEN_375;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_566 = _GEN_3 ? ~_GEN_528 & _GEN_376 : ~_GEN_437 & _GEN_376;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_567 = _GEN_3 ? ~_GEN_531 & _GEN_377 : ~_GEN_439 & _GEN_377;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_568 = _GEN_3 ? ~_GEN_534 & _GEN_378 : ~_GEN_441 & _GEN_378;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_569 = _GEN_3 ? ~_GEN_536 & _GEN_379 : ~_GEN_442 & _GEN_379;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_791 = rbk_row & _GEN_790;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_793 = rbk_row & _GEN_792;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_795 = rbk_row & _GEN_794;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_797 = rbk_row & _GEN_796;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_799 = rbk_row & _GEN_798;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_801 = rbk_row & _GEN_800;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_803 = rbk_row & _GEN_802;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_805 = rbk_row & _GEN_804;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_807 = rbk_row & _GEN_806;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_809 = rbk_row & _GEN_808;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_811 = rbk_row & _GEN_810;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_813 = rbk_row & _GEN_812;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_815 = rbk_row & _GEN_814;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_817 = rbk_row & _GEN_816;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_819 = rbk_row & _GEN_818;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_821 = rbk_row & _GEN_820;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_823 = rbk_row & _GEN_822;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_825 = rbk_row & _GEN_824;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_827 = rbk_row & _GEN_826;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_829 = rbk_row & _GEN_828;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_831 = rbk_row & _GEN_830;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_833 = rbk_row & _GEN_832;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_835 = rbk_row & _GEN_834;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_837 = rbk_row & _GEN_836;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_839 = rbk_row & _GEN_838;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_841 = rbk_row & _GEN_840;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_843 = rbk_row & _GEN_842;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_845 = rbk_row & _GEN_844;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_847 = rbk_row & _GEN_846;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_849 = rbk_row & _GEN_848;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_851 = rbk_row & _GEN_850;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_852 = rbk_row & (&com_idx);	// rob.scala:236:20, :323:29, :425:44, :433:20, :434:30
    _GEN_853 = io_brupdate_b1_mispredict_mask & rob_uop_0_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_854 = io_brupdate_b1_mispredict_mask & rob_uop_1_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_855 = io_brupdate_b1_mispredict_mask & rob_uop_2_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_856 = io_brupdate_b1_mispredict_mask & rob_uop_3_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_857 = io_brupdate_b1_mispredict_mask & rob_uop_4_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_858 = io_brupdate_b1_mispredict_mask & rob_uop_5_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_859 = io_brupdate_b1_mispredict_mask & rob_uop_6_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_860 = io_brupdate_b1_mispredict_mask & rob_uop_7_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_861 = io_brupdate_b1_mispredict_mask & rob_uop_8_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_862 = io_brupdate_b1_mispredict_mask & rob_uop_9_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_863 = io_brupdate_b1_mispredict_mask & rob_uop_10_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_864 = io_brupdate_b1_mispredict_mask & rob_uop_11_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_865 = io_brupdate_b1_mispredict_mask & rob_uop_12_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_866 = io_brupdate_b1_mispredict_mask & rob_uop_13_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_867 = io_brupdate_b1_mispredict_mask & rob_uop_14_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_868 = io_brupdate_b1_mispredict_mask & rob_uop_15_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_869 = io_brupdate_b1_mispredict_mask & rob_uop_16_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_870 = io_brupdate_b1_mispredict_mask & rob_uop_17_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_871 = io_brupdate_b1_mispredict_mask & rob_uop_18_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_872 = io_brupdate_b1_mispredict_mask & rob_uop_19_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_873 = io_brupdate_b1_mispredict_mask & rob_uop_20_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_874 = io_brupdate_b1_mispredict_mask & rob_uop_21_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_875 = io_brupdate_b1_mispredict_mask & rob_uop_22_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_876 = io_brupdate_b1_mispredict_mask & rob_uop_23_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_877 = io_brupdate_b1_mispredict_mask & rob_uop_24_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_878 = io_brupdate_b1_mispredict_mask & rob_uop_25_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_879 = io_brupdate_b1_mispredict_mask & rob_uop_26_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_880 = io_brupdate_b1_mispredict_mask & rob_uop_27_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_881 = io_brupdate_b1_mispredict_mask & rob_uop_28_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_882 = io_brupdate_b1_mispredict_mask & rob_uop_29_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_883 = io_brupdate_b1_mispredict_mask & rob_uop_30_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_884 = io_brupdate_b1_mispredict_mask & rob_uop_31_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_885 = io_enq_valids_1 & _GEN_63;	// rob.scala:307:32, :323:29, :324:31
    _GEN_886 = io_enq_valids_1 & _GEN_65;	// rob.scala:307:32, :323:29, :324:31
    _GEN_887 = io_enq_valids_1 & _GEN_67;	// rob.scala:307:32, :323:29, :324:31
    _GEN_888 = io_enq_valids_1 & _GEN_69;	// rob.scala:307:32, :323:29, :324:31
    _GEN_889 = io_enq_valids_1 & _GEN_71;	// rob.scala:307:32, :323:29, :324:31
    _GEN_890 = io_enq_valids_1 & _GEN_73;	// rob.scala:307:32, :323:29, :324:31
    _GEN_891 = io_enq_valids_1 & _GEN_75;	// rob.scala:307:32, :323:29, :324:31
    _GEN_892 = io_enq_valids_1 & _GEN_77;	// rob.scala:307:32, :323:29, :324:31
    _GEN_893 = io_enq_valids_1 & _GEN_79;	// rob.scala:307:32, :323:29, :324:31
    _GEN_894 = io_enq_valids_1 & _GEN_81;	// rob.scala:307:32, :323:29, :324:31
    _GEN_895 = io_enq_valids_1 & _GEN_83;	// rob.scala:307:32, :323:29, :324:31
    _GEN_896 = io_enq_valids_1 & _GEN_85;	// rob.scala:307:32, :323:29, :324:31
    _GEN_897 = io_enq_valids_1 & _GEN_87;	// rob.scala:307:32, :323:29, :324:31
    _GEN_898 = io_enq_valids_1 & _GEN_89;	// rob.scala:307:32, :323:29, :324:31
    _GEN_899 = io_enq_valids_1 & _GEN_91;	// rob.scala:307:32, :323:29, :324:31
    _GEN_900 = io_enq_valids_1 & _GEN_93;	// rob.scala:307:32, :323:29, :324:31
    _GEN_901 = io_enq_valids_1 & _GEN_95;	// rob.scala:307:32, :323:29, :324:31
    _GEN_902 = io_enq_valids_1 & _GEN_97;	// rob.scala:307:32, :323:29, :324:31
    _GEN_903 = io_enq_valids_1 & _GEN_99;	// rob.scala:307:32, :323:29, :324:31
    _GEN_904 = io_enq_valids_1 & _GEN_101;	// rob.scala:307:32, :323:29, :324:31
    _GEN_905 = io_enq_valids_1 & _GEN_103;	// rob.scala:307:32, :323:29, :324:31
    _GEN_906 = io_enq_valids_1 & _GEN_105;	// rob.scala:307:32, :323:29, :324:31
    _GEN_907 = io_enq_valids_1 & _GEN_107;	// rob.scala:307:32, :323:29, :324:31
    _GEN_908 = io_enq_valids_1 & _GEN_109;	// rob.scala:307:32, :323:29, :324:31
    _GEN_909 = io_enq_valids_1 & _GEN_111;	// rob.scala:307:32, :323:29, :324:31
    _GEN_910 = io_enq_valids_1 & _GEN_113;	// rob.scala:307:32, :323:29, :324:31
    _GEN_911 = io_enq_valids_1 & _GEN_115;	// rob.scala:307:32, :323:29, :324:31
    _GEN_912 = io_enq_valids_1 & _GEN_117;	// rob.scala:307:32, :323:29, :324:31
    _GEN_913 = io_enq_valids_1 & _GEN_119;	// rob.scala:307:32, :323:29, :324:31
    _GEN_914 = io_enq_valids_1 & _GEN_121;	// rob.scala:307:32, :323:29, :324:31
    _GEN_915 = io_enq_valids_1 & _GEN_123;	// rob.scala:307:32, :323:29, :324:31
    _GEN_916 = io_enq_valids_1 & (&rob_tail);	// rob.scala:228:29, :307:32, :323:29, :324:31
    _GEN_917 = _GEN_885 ? ~_rob_bsy_T_2 : rob_bsy_1_0;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_918 = _GEN_886 ? ~_rob_bsy_T_2 : rob_bsy_1_1;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_919 = _GEN_887 ? ~_rob_bsy_T_2 : rob_bsy_1_2;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_920 = _GEN_888 ? ~_rob_bsy_T_2 : rob_bsy_1_3;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_921 = _GEN_889 ? ~_rob_bsy_T_2 : rob_bsy_1_4;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_922 = _GEN_890 ? ~_rob_bsy_T_2 : rob_bsy_1_5;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_923 = _GEN_891 ? ~_rob_bsy_T_2 : rob_bsy_1_6;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_924 = _GEN_892 ? ~_rob_bsy_T_2 : rob_bsy_1_7;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_925 = _GEN_893 ? ~_rob_bsy_T_2 : rob_bsy_1_8;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_926 = _GEN_894 ? ~_rob_bsy_T_2 : rob_bsy_1_9;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_927 = _GEN_895 ? ~_rob_bsy_T_2 : rob_bsy_1_10;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_928 = _GEN_896 ? ~_rob_bsy_T_2 : rob_bsy_1_11;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_929 = _GEN_897 ? ~_rob_bsy_T_2 : rob_bsy_1_12;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_930 = _GEN_898 ? ~_rob_bsy_T_2 : rob_bsy_1_13;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_931 = _GEN_899 ? ~_rob_bsy_T_2 : rob_bsy_1_14;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_932 = _GEN_900 ? ~_rob_bsy_T_2 : rob_bsy_1_15;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_933 = _GEN_901 ? ~_rob_bsy_T_2 : rob_bsy_1_16;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_934 = _GEN_902 ? ~_rob_bsy_T_2 : rob_bsy_1_17;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_935 = _GEN_903 ? ~_rob_bsy_T_2 : rob_bsy_1_18;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_936 = _GEN_904 ? ~_rob_bsy_T_2 : rob_bsy_1_19;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_937 = _GEN_905 ? ~_rob_bsy_T_2 : rob_bsy_1_20;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_938 = _GEN_906 ? ~_rob_bsy_T_2 : rob_bsy_1_21;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_939 = _GEN_907 ? ~_rob_bsy_T_2 : rob_bsy_1_22;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_940 = _GEN_908 ? ~_rob_bsy_T_2 : rob_bsy_1_23;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_941 = _GEN_909 ? ~_rob_bsy_T_2 : rob_bsy_1_24;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_942 = _GEN_910 ? ~_rob_bsy_T_2 : rob_bsy_1_25;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_943 = _GEN_911 ? ~_rob_bsy_T_2 : rob_bsy_1_26;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_944 = _GEN_912 ? ~_rob_bsy_T_2 : rob_bsy_1_27;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_945 = _GEN_913 ? ~_rob_bsy_T_2 : rob_bsy_1_28;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_946 = _GEN_914 ? ~_rob_bsy_T_2 : rob_bsy_1_29;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_947 = _GEN_915 ? ~_rob_bsy_T_2 : rob_bsy_1_30;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_948 = _GEN_916 ? ~_rob_bsy_T_2 : rob_bsy_1_31;	// rob.scala:307:32, :308:28, :323:29, :324:31, :325:{31,34,60}
    _GEN_949 = _GEN_885 ? _rob_unsafe_T_9 : rob_unsafe_1_0;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_950 = _GEN_886 ? _rob_unsafe_T_9 : rob_unsafe_1_1;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_951 = _GEN_887 ? _rob_unsafe_T_9 : rob_unsafe_1_2;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_952 = _GEN_888 ? _rob_unsafe_T_9 : rob_unsafe_1_3;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_953 = _GEN_889 ? _rob_unsafe_T_9 : rob_unsafe_1_4;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_954 = _GEN_890 ? _rob_unsafe_T_9 : rob_unsafe_1_5;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_955 = _GEN_891 ? _rob_unsafe_T_9 : rob_unsafe_1_6;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_956 = _GEN_892 ? _rob_unsafe_T_9 : rob_unsafe_1_7;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_957 = _GEN_893 ? _rob_unsafe_T_9 : rob_unsafe_1_8;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_958 = _GEN_894 ? _rob_unsafe_T_9 : rob_unsafe_1_9;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_959 = _GEN_895 ? _rob_unsafe_T_9 : rob_unsafe_1_10;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_960 = _GEN_896 ? _rob_unsafe_T_9 : rob_unsafe_1_11;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_961 = _GEN_897 ? _rob_unsafe_T_9 : rob_unsafe_1_12;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_962 = _GEN_898 ? _rob_unsafe_T_9 : rob_unsafe_1_13;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_963 = _GEN_899 ? _rob_unsafe_T_9 : rob_unsafe_1_14;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_964 = _GEN_900 ? _rob_unsafe_T_9 : rob_unsafe_1_15;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_965 = _GEN_901 ? _rob_unsafe_T_9 : rob_unsafe_1_16;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_966 = _GEN_902 ? _rob_unsafe_T_9 : rob_unsafe_1_17;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_967 = _GEN_903 ? _rob_unsafe_T_9 : rob_unsafe_1_18;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_968 = _GEN_904 ? _rob_unsafe_T_9 : rob_unsafe_1_19;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_969 = _GEN_905 ? _rob_unsafe_T_9 : rob_unsafe_1_20;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_970 = _GEN_906 ? _rob_unsafe_T_9 : rob_unsafe_1_21;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_971 = _GEN_907 ? _rob_unsafe_T_9 : rob_unsafe_1_22;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_972 = _GEN_908 ? _rob_unsafe_T_9 : rob_unsafe_1_23;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_973 = _GEN_909 ? _rob_unsafe_T_9 : rob_unsafe_1_24;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_974 = _GEN_910 ? _rob_unsafe_T_9 : rob_unsafe_1_25;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_975 = _GEN_911 ? _rob_unsafe_T_9 : rob_unsafe_1_26;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_976 = _GEN_912 ? _rob_unsafe_T_9 : rob_unsafe_1_27;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_977 = _GEN_913 ? _rob_unsafe_T_9 : rob_unsafe_1_28;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_978 = _GEN_914 ? _rob_unsafe_T_9 : rob_unsafe_1_29;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_979 = _GEN_915 ? _rob_unsafe_T_9 : rob_unsafe_1_30;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_980 = _GEN_916 ? _rob_unsafe_T_9 : rob_unsafe_1_31;	// micro-op.scala:152:71, rob.scala:307:32, :309:28, :323:29, :324:31, :327:31
    _GEN_1014 = _GEN_30 ? ~_GEN_1013 & _GEN_917 : ~_GEN_981 & _GEN_917;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_1016 = _GEN_30 ? ~_GEN_1015 & _GEN_918 : ~_GEN_982 & _GEN_918;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_1018 = _GEN_30 ? ~_GEN_1017 & _GEN_919 : ~_GEN_983 & _GEN_919;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_1020 = _GEN_30 ? ~_GEN_1019 & _GEN_920 : ~_GEN_984 & _GEN_920;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_1022 = _GEN_30 ? ~_GEN_1021 & _GEN_921 : ~_GEN_985 & _GEN_921;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_1024 = _GEN_30 ? ~_GEN_1023 & _GEN_922 : ~_GEN_986 & _GEN_922;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_1026 = _GEN_30 ? ~_GEN_1025 & _GEN_923 : ~_GEN_987 & _GEN_923;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_1028 = _GEN_30 ? ~_GEN_1027 & _GEN_924 : ~_GEN_988 & _GEN_924;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_1030 = _GEN_30 ? ~_GEN_1029 & _GEN_925 : ~_GEN_989 & _GEN_925;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_1032 = _GEN_30 ? ~_GEN_1031 & _GEN_926 : ~_GEN_990 & _GEN_926;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_1034 = _GEN_30 ? ~_GEN_1033 & _GEN_927 : ~_GEN_991 & _GEN_927;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_1036 = _GEN_30 ? ~_GEN_1035 & _GEN_928 : ~_GEN_992 & _GEN_928;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_1038 = _GEN_30 ? ~_GEN_1037 & _GEN_929 : ~_GEN_993 & _GEN_929;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_1040 = _GEN_30 ? ~_GEN_1039 & _GEN_930 : ~_GEN_994 & _GEN_930;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_1042 = _GEN_30 ? ~_GEN_1041 & _GEN_931 : ~_GEN_995 & _GEN_931;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_1044 = _GEN_30 ? ~_GEN_1043 & _GEN_932 : ~_GEN_996 & _GEN_932;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_1046 = _GEN_30 ? ~_GEN_1045 & _GEN_933 : ~_GEN_997 & _GEN_933;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_1048 = _GEN_30 ? ~_GEN_1047 & _GEN_934 : ~_GEN_998 & _GEN_934;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_1050 = _GEN_30 ? ~_GEN_1049 & _GEN_935 : ~_GEN_999 & _GEN_935;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_1052 = _GEN_30 ? ~_GEN_1051 & _GEN_936 : ~_GEN_1000 & _GEN_936;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_1054 = _GEN_30 ? ~_GEN_1053 & _GEN_937 : ~_GEN_1001 & _GEN_937;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_1056 = _GEN_30 ? ~_GEN_1055 & _GEN_938 : ~_GEN_1002 & _GEN_938;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_1058 = _GEN_30 ? ~_GEN_1057 & _GEN_939 : ~_GEN_1003 & _GEN_939;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_1060 = _GEN_30 ? ~_GEN_1059 & _GEN_940 : ~_GEN_1004 & _GEN_940;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_1062 = _GEN_30 ? ~_GEN_1061 & _GEN_941 : ~_GEN_1005 & _GEN_941;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_1064 = _GEN_30 ? ~_GEN_1063 & _GEN_942 : ~_GEN_1006 & _GEN_942;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_1066 = _GEN_30 ? ~_GEN_1065 & _GEN_943 : ~_GEN_1007 & _GEN_943;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_1068 = _GEN_30 ? ~_GEN_1067 & _GEN_944 : ~_GEN_1008 & _GEN_944;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_1070 = _GEN_30 ? ~_GEN_1069 & _GEN_945 : ~_GEN_1009 & _GEN_945;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_1072 = _GEN_30 ? ~_GEN_1071 & _GEN_946 : ~_GEN_1010 & _GEN_946;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_1074 = _GEN_30 ? ~_GEN_1073 & _GEN_947 : ~_GEN_1011 & _GEN_947;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_1076 = _GEN_30 ? ~_GEN_1075 & _GEN_948 : ~_GEN_1012 & _GEN_948;	// rob.scala:308:28, :323:29, :325:31, :346:{27,69}, :347:31
    _GEN_1077 = _GEN_30 ? ~_GEN_1013 & _GEN_949 : ~_GEN_981 & _GEN_949;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_1078 = _GEN_30 ? ~_GEN_1015 & _GEN_950 : ~_GEN_982 & _GEN_950;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_1079 = _GEN_30 ? ~_GEN_1017 & _GEN_951 : ~_GEN_983 & _GEN_951;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_1080 = _GEN_30 ? ~_GEN_1019 & _GEN_952 : ~_GEN_984 & _GEN_952;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_1081 = _GEN_30 ? ~_GEN_1021 & _GEN_953 : ~_GEN_985 & _GEN_953;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_1082 = _GEN_30 ? ~_GEN_1023 & _GEN_954 : ~_GEN_986 & _GEN_954;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_1083 = _GEN_30 ? ~_GEN_1025 & _GEN_955 : ~_GEN_987 & _GEN_955;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_1084 = _GEN_30 ? ~_GEN_1027 & _GEN_956 : ~_GEN_988 & _GEN_956;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_1085 = _GEN_30 ? ~_GEN_1029 & _GEN_957 : ~_GEN_989 & _GEN_957;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_1086 = _GEN_30 ? ~_GEN_1031 & _GEN_958 : ~_GEN_990 & _GEN_958;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_1087 = _GEN_30 ? ~_GEN_1033 & _GEN_959 : ~_GEN_991 & _GEN_959;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_1088 = _GEN_30 ? ~_GEN_1035 & _GEN_960 : ~_GEN_992 & _GEN_960;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_1089 = _GEN_30 ? ~_GEN_1037 & _GEN_961 : ~_GEN_993 & _GEN_961;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_1090 = _GEN_30 ? ~_GEN_1039 & _GEN_962 : ~_GEN_994 & _GEN_962;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_1091 = _GEN_30 ? ~_GEN_1041 & _GEN_963 : ~_GEN_995 & _GEN_963;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_1092 = _GEN_30 ? ~_GEN_1043 & _GEN_964 : ~_GEN_996 & _GEN_964;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_1093 = _GEN_30 ? ~_GEN_1045 & _GEN_965 : ~_GEN_997 & _GEN_965;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_1094 = _GEN_30 ? ~_GEN_1047 & _GEN_966 : ~_GEN_998 & _GEN_966;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_1095 = _GEN_30 ? ~_GEN_1049 & _GEN_967 : ~_GEN_999 & _GEN_967;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_1096 = _GEN_30 ? ~_GEN_1051 & _GEN_968 : ~_GEN_1000 & _GEN_968;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_1097 = _GEN_30 ? ~_GEN_1053 & _GEN_969 : ~_GEN_1001 & _GEN_969;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_1098 = _GEN_30 ? ~_GEN_1055 & _GEN_970 : ~_GEN_1002 & _GEN_970;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_1099 = _GEN_30 ? ~_GEN_1057 & _GEN_971 : ~_GEN_1003 & _GEN_971;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_1100 = _GEN_30 ? ~_GEN_1059 & _GEN_972 : ~_GEN_1004 & _GEN_972;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_1101 = _GEN_30 ? ~_GEN_1061 & _GEN_973 : ~_GEN_1005 & _GEN_973;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_1102 = _GEN_30 ? ~_GEN_1063 & _GEN_974 : ~_GEN_1006 & _GEN_974;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_1103 = _GEN_30 ? ~_GEN_1065 & _GEN_975 : ~_GEN_1007 & _GEN_975;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_1104 = _GEN_30 ? ~_GEN_1067 & _GEN_976 : ~_GEN_1008 & _GEN_976;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_1105 = _GEN_30 ? ~_GEN_1069 & _GEN_977 : ~_GEN_1009 & _GEN_977;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_1106 = _GEN_30 ? ~_GEN_1071 & _GEN_978 : ~_GEN_1010 & _GEN_978;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_1107 = _GEN_30 ? ~_GEN_1073 & _GEN_979 : ~_GEN_1011 & _GEN_979;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_1108 = _GEN_30 ? ~_GEN_1075 & _GEN_980 : ~_GEN_1012 & _GEN_980;	// rob.scala:309:28, :323:29, :327:31, :346:{27,69}, :347:31, :348:31
    _GEN_1142 = _GEN_32 ? ~_GEN_1141 & _GEN_1014 : ~_GEN_1109 & _GEN_1014;	// rob.scala:346:{27,69}, :347:31
    _GEN_1144 = _GEN_32 ? ~_GEN_1143 & _GEN_1016 : ~_GEN_1110 & _GEN_1016;	// rob.scala:346:{27,69}, :347:31
    _GEN_1146 = _GEN_32 ? ~_GEN_1145 & _GEN_1018 : ~_GEN_1111 & _GEN_1018;	// rob.scala:346:{27,69}, :347:31
    _GEN_1148 = _GEN_32 ? ~_GEN_1147 & _GEN_1020 : ~_GEN_1112 & _GEN_1020;	// rob.scala:346:{27,69}, :347:31
    _GEN_1150 = _GEN_32 ? ~_GEN_1149 & _GEN_1022 : ~_GEN_1113 & _GEN_1022;	// rob.scala:346:{27,69}, :347:31
    _GEN_1152 = _GEN_32 ? ~_GEN_1151 & _GEN_1024 : ~_GEN_1114 & _GEN_1024;	// rob.scala:346:{27,69}, :347:31
    _GEN_1154 = _GEN_32 ? ~_GEN_1153 & _GEN_1026 : ~_GEN_1115 & _GEN_1026;	// rob.scala:346:{27,69}, :347:31
    _GEN_1156 = _GEN_32 ? ~_GEN_1155 & _GEN_1028 : ~_GEN_1116 & _GEN_1028;	// rob.scala:346:{27,69}, :347:31
    _GEN_1158 = _GEN_32 ? ~_GEN_1157 & _GEN_1030 : ~_GEN_1117 & _GEN_1030;	// rob.scala:346:{27,69}, :347:31
    _GEN_1160 = _GEN_32 ? ~_GEN_1159 & _GEN_1032 : ~_GEN_1118 & _GEN_1032;	// rob.scala:346:{27,69}, :347:31
    _GEN_1162 = _GEN_32 ? ~_GEN_1161 & _GEN_1034 : ~_GEN_1119 & _GEN_1034;	// rob.scala:346:{27,69}, :347:31
    _GEN_1164 = _GEN_32 ? ~_GEN_1163 & _GEN_1036 : ~_GEN_1120 & _GEN_1036;	// rob.scala:346:{27,69}, :347:31
    _GEN_1166 = _GEN_32 ? ~_GEN_1165 & _GEN_1038 : ~_GEN_1121 & _GEN_1038;	// rob.scala:346:{27,69}, :347:31
    _GEN_1168 = _GEN_32 ? ~_GEN_1167 & _GEN_1040 : ~_GEN_1122 & _GEN_1040;	// rob.scala:346:{27,69}, :347:31
    _GEN_1170 = _GEN_32 ? ~_GEN_1169 & _GEN_1042 : ~_GEN_1123 & _GEN_1042;	// rob.scala:346:{27,69}, :347:31
    _GEN_1172 = _GEN_32 ? ~_GEN_1171 & _GEN_1044 : ~_GEN_1124 & _GEN_1044;	// rob.scala:346:{27,69}, :347:31
    _GEN_1174 = _GEN_32 ? ~_GEN_1173 & _GEN_1046 : ~_GEN_1125 & _GEN_1046;	// rob.scala:346:{27,69}, :347:31
    _GEN_1176 = _GEN_32 ? ~_GEN_1175 & _GEN_1048 : ~_GEN_1126 & _GEN_1048;	// rob.scala:346:{27,69}, :347:31
    _GEN_1178 = _GEN_32 ? ~_GEN_1177 & _GEN_1050 : ~_GEN_1127 & _GEN_1050;	// rob.scala:346:{27,69}, :347:31
    _GEN_1180 = _GEN_32 ? ~_GEN_1179 & _GEN_1052 : ~_GEN_1128 & _GEN_1052;	// rob.scala:346:{27,69}, :347:31
    _GEN_1182 = _GEN_32 ? ~_GEN_1181 & _GEN_1054 : ~_GEN_1129 & _GEN_1054;	// rob.scala:346:{27,69}, :347:31
    _GEN_1184 = _GEN_32 ? ~_GEN_1183 & _GEN_1056 : ~_GEN_1130 & _GEN_1056;	// rob.scala:346:{27,69}, :347:31
    _GEN_1186 = _GEN_32 ? ~_GEN_1185 & _GEN_1058 : ~_GEN_1131 & _GEN_1058;	// rob.scala:346:{27,69}, :347:31
    _GEN_1188 = _GEN_32 ? ~_GEN_1187 & _GEN_1060 : ~_GEN_1132 & _GEN_1060;	// rob.scala:346:{27,69}, :347:31
    _GEN_1190 = _GEN_32 ? ~_GEN_1189 & _GEN_1062 : ~_GEN_1133 & _GEN_1062;	// rob.scala:346:{27,69}, :347:31
    _GEN_1192 = _GEN_32 ? ~_GEN_1191 & _GEN_1064 : ~_GEN_1134 & _GEN_1064;	// rob.scala:346:{27,69}, :347:31
    _GEN_1194 = _GEN_32 ? ~_GEN_1193 & _GEN_1066 : ~_GEN_1135 & _GEN_1066;	// rob.scala:346:{27,69}, :347:31
    _GEN_1196 = _GEN_32 ? ~_GEN_1195 & _GEN_1068 : ~_GEN_1136 & _GEN_1068;	// rob.scala:346:{27,69}, :347:31
    _GEN_1198 = _GEN_32 ? ~_GEN_1197 & _GEN_1070 : ~_GEN_1137 & _GEN_1070;	// rob.scala:346:{27,69}, :347:31
    _GEN_1200 = _GEN_32 ? ~_GEN_1199 & _GEN_1072 : ~_GEN_1138 & _GEN_1072;	// rob.scala:346:{27,69}, :347:31
    _GEN_1202 = _GEN_32 ? ~_GEN_1201 & _GEN_1074 : ~_GEN_1139 & _GEN_1074;	// rob.scala:346:{27,69}, :347:31
    _GEN_1204 = _GEN_32 ? ~_GEN_1203 & _GEN_1076 : ~_GEN_1140 & _GEN_1076;	// rob.scala:346:{27,69}, :347:31
    _GEN_1205 = _GEN_32 ? ~_GEN_1141 & _GEN_1077 : ~_GEN_1109 & _GEN_1077;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_1206 = _GEN_32 ? ~_GEN_1143 & _GEN_1078 : ~_GEN_1110 & _GEN_1078;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_1207 = _GEN_32 ? ~_GEN_1145 & _GEN_1079 : ~_GEN_1111 & _GEN_1079;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_1208 = _GEN_32 ? ~_GEN_1147 & _GEN_1080 : ~_GEN_1112 & _GEN_1080;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_1209 = _GEN_32 ? ~_GEN_1149 & _GEN_1081 : ~_GEN_1113 & _GEN_1081;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_1210 = _GEN_32 ? ~_GEN_1151 & _GEN_1082 : ~_GEN_1114 & _GEN_1082;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_1211 = _GEN_32 ? ~_GEN_1153 & _GEN_1083 : ~_GEN_1115 & _GEN_1083;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_1212 = _GEN_32 ? ~_GEN_1155 & _GEN_1084 : ~_GEN_1116 & _GEN_1084;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_1213 = _GEN_32 ? ~_GEN_1157 & _GEN_1085 : ~_GEN_1117 & _GEN_1085;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_1214 = _GEN_32 ? ~_GEN_1159 & _GEN_1086 : ~_GEN_1118 & _GEN_1086;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_1215 = _GEN_32 ? ~_GEN_1161 & _GEN_1087 : ~_GEN_1119 & _GEN_1087;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_1216 = _GEN_32 ? ~_GEN_1163 & _GEN_1088 : ~_GEN_1120 & _GEN_1088;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_1217 = _GEN_32 ? ~_GEN_1165 & _GEN_1089 : ~_GEN_1121 & _GEN_1089;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_1218 = _GEN_32 ? ~_GEN_1167 & _GEN_1090 : ~_GEN_1122 & _GEN_1090;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_1219 = _GEN_32 ? ~_GEN_1169 & _GEN_1091 : ~_GEN_1123 & _GEN_1091;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_1220 = _GEN_32 ? ~_GEN_1171 & _GEN_1092 : ~_GEN_1124 & _GEN_1092;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_1221 = _GEN_32 ? ~_GEN_1173 & _GEN_1093 : ~_GEN_1125 & _GEN_1093;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_1222 = _GEN_32 ? ~_GEN_1175 & _GEN_1094 : ~_GEN_1126 & _GEN_1094;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_1223 = _GEN_32 ? ~_GEN_1177 & _GEN_1095 : ~_GEN_1127 & _GEN_1095;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_1224 = _GEN_32 ? ~_GEN_1179 & _GEN_1096 : ~_GEN_1128 & _GEN_1096;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_1225 = _GEN_32 ? ~_GEN_1181 & _GEN_1097 : ~_GEN_1129 & _GEN_1097;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_1226 = _GEN_32 ? ~_GEN_1183 & _GEN_1098 : ~_GEN_1130 & _GEN_1098;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_1227 = _GEN_32 ? ~_GEN_1185 & _GEN_1099 : ~_GEN_1131 & _GEN_1099;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_1228 = _GEN_32 ? ~_GEN_1187 & _GEN_1100 : ~_GEN_1132 & _GEN_1100;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_1229 = _GEN_32 ? ~_GEN_1189 & _GEN_1101 : ~_GEN_1133 & _GEN_1101;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_1230 = _GEN_32 ? ~_GEN_1191 & _GEN_1102 : ~_GEN_1134 & _GEN_1102;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_1231 = _GEN_32 ? ~_GEN_1193 & _GEN_1103 : ~_GEN_1135 & _GEN_1103;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_1232 = _GEN_32 ? ~_GEN_1195 & _GEN_1104 : ~_GEN_1136 & _GEN_1104;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_1233 = _GEN_32 ? ~_GEN_1197 & _GEN_1105 : ~_GEN_1137 & _GEN_1105;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_1234 = _GEN_32 ? ~_GEN_1199 & _GEN_1106 : ~_GEN_1138 & _GEN_1106;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_1235 = _GEN_32 ? ~_GEN_1201 & _GEN_1107 : ~_GEN_1139 & _GEN_1107;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_1236 = _GEN_32 ? ~_GEN_1203 & _GEN_1108 : ~_GEN_1140 & _GEN_1108;	// rob.scala:346:{27,69}, :347:31, :348:31
    _GEN_1333 = rbk_row_1 & _GEN_790;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_1334 = rbk_row_1 & _GEN_792;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_1335 = rbk_row_1 & _GEN_794;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_1336 = rbk_row_1 & _GEN_796;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_1337 = rbk_row_1 & _GEN_798;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_1338 = rbk_row_1 & _GEN_800;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_1339 = rbk_row_1 & _GEN_802;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_1340 = rbk_row_1 & _GEN_804;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_1341 = rbk_row_1 & _GEN_806;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_1342 = rbk_row_1 & _GEN_808;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_1343 = rbk_row_1 & _GEN_810;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_1344 = rbk_row_1 & _GEN_812;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_1345 = rbk_row_1 & _GEN_814;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_1346 = rbk_row_1 & _GEN_816;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_1347 = rbk_row_1 & _GEN_818;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_1348 = rbk_row_1 & _GEN_820;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_1349 = rbk_row_1 & _GEN_822;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_1350 = rbk_row_1 & _GEN_824;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_1351 = rbk_row_1 & _GEN_826;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_1352 = rbk_row_1 & _GEN_828;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_1353 = rbk_row_1 & _GEN_830;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_1354 = rbk_row_1 & _GEN_832;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_1355 = rbk_row_1 & _GEN_834;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_1356 = rbk_row_1 & _GEN_836;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_1357 = rbk_row_1 & _GEN_838;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_1358 = rbk_row_1 & _GEN_840;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_1359 = rbk_row_1 & _GEN_842;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_1360 = rbk_row_1 & _GEN_844;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_1361 = rbk_row_1 & _GEN_846;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_1362 = rbk_row_1 & _GEN_848;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_1363 = rbk_row_1 & _GEN_850;	// rob.scala:323:29, :425:44, :433:20, :434:30
    _GEN_1364 = rbk_row_1 & (&com_idx);	// rob.scala:236:20, :323:29, :425:44, :433:20, :434:30
    _GEN_1365 = io_brupdate_b1_mispredict_mask & rob_uop_1_0_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_1366 = io_brupdate_b1_mispredict_mask & rob_uop_1_1_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_1367 = io_brupdate_b1_mispredict_mask & rob_uop_1_2_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_1368 = io_brupdate_b1_mispredict_mask & rob_uop_1_3_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_1369 = io_brupdate_b1_mispredict_mask & rob_uop_1_4_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_1370 = io_brupdate_b1_mispredict_mask & rob_uop_1_5_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_1371 = io_brupdate_b1_mispredict_mask & rob_uop_1_6_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_1372 = io_brupdate_b1_mispredict_mask & rob_uop_1_7_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_1373 = io_brupdate_b1_mispredict_mask & rob_uop_1_8_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_1374 = io_brupdate_b1_mispredict_mask & rob_uop_1_9_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_1375 = io_brupdate_b1_mispredict_mask & rob_uop_1_10_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_1376 = io_brupdate_b1_mispredict_mask & rob_uop_1_11_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_1377 = io_brupdate_b1_mispredict_mask & rob_uop_1_12_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_1378 = io_brupdate_b1_mispredict_mask & rob_uop_1_13_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_1379 = io_brupdate_b1_mispredict_mask & rob_uop_1_14_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_1380 = io_brupdate_b1_mispredict_mask & rob_uop_1_15_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_1381 = io_brupdate_b1_mispredict_mask & rob_uop_1_16_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_1382 = io_brupdate_b1_mispredict_mask & rob_uop_1_17_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_1383 = io_brupdate_b1_mispredict_mask & rob_uop_1_18_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_1384 = io_brupdate_b1_mispredict_mask & rob_uop_1_19_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_1385 = io_brupdate_b1_mispredict_mask & rob_uop_1_20_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_1386 = io_brupdate_b1_mispredict_mask & rob_uop_1_21_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_1387 = io_brupdate_b1_mispredict_mask & rob_uop_1_22_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_1388 = io_brupdate_b1_mispredict_mask & rob_uop_1_23_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_1389 = io_brupdate_b1_mispredict_mask & rob_uop_1_24_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_1390 = io_brupdate_b1_mispredict_mask & rob_uop_1_25_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_1391 = io_brupdate_b1_mispredict_mask & rob_uop_1_26_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_1392 = io_brupdate_b1_mispredict_mask & rob_uop_1_27_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_1393 = io_brupdate_b1_mispredict_mask & rob_uop_1_28_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_1394 = io_brupdate_b1_mispredict_mask & rob_uop_1_29_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_1395 = io_brupdate_b1_mispredict_mask & rob_uop_1_30_br_mask;	// rob.scala:310:28, util.scala:118:51
    _GEN_1396 = io_brupdate_b1_mispredict_mask & rob_uop_1_31_br_mask;	// rob.scala:310:28, util.scala:118:51
    enq_xcpts_0 = io_enq_valids_0 & io_enq_uops_0_exception;	// rob.scala:628:38
    _GEN_1397 = ~(_io_flush_valid_output | exception_thrown) & rob_state != 2'h2;	// rob.scala:221:26, :236:31, :545:85, :573:36, :631:{9,26,47,60}
    _GEN_1398 =
      ~r_xcpt_val | io_lxcpt_bits_uop_rob_idx < r_xcpt_uop_rob_idx
      ^ io_lxcpt_bits_uop_rob_idx < rob_head_idx ^ r_xcpt_uop_rob_idx < rob_head_idx;	// Cat.scala:30:58, rob.scala:258:33, :259:29, :635:{13,25}, util.scala:363:{52,64,72,78}
    _GEN_1399 = ~r_xcpt_val & (enq_xcpts_0 | io_enq_valids_1 & io_enq_uops_1_exception);	// rob.scala:258:33, :628:38, :635:13, :641:{30,51}
    next_xcpt_uop_br_mask =
      _GEN_1397
        ? (io_lxcpt_valid
             ? (_GEN_1398 ? io_lxcpt_bits_uop_br_mask : r_xcpt_uop_br_mask)
             : _GEN_1399
                 ? (enq_xcpts_0 ? io_enq_uops_0_br_mask : io_enq_uops_1_br_mask)
                 : r_xcpt_uop_br_mask)
        : r_xcpt_uop_br_mask;	// rob.scala:259:29, :625:17, :628:38, :631:{47,76}, :632:27, :635:{25,93}, :637:33, :641:{30,56}, :646:23
    if (reset) begin
      rob_state <= 2'h0;	// rob.scala:221:26
      rob_head <= 5'h0;	// rob.scala:224:29
      rob_head_lsb <= 1'h0;	// rob.scala:225:29, :370:23, :646:23
      rob_tail <= 5'h0;	// rob.scala:224:29, :228:29
      rob_tail_lsb <= 1'h0;	// rob.scala:229:29, :370:23, :646:23
      rob_pnr <= 5'h0;	// rob.scala:224:29, :232:29
      rob_pnr_lsb <= 1'h0;	// rob.scala:233:29, :370:23, :646:23
      maybe_full <= 1'h0;	// rob.scala:239:29, :370:23, :646:23
      r_xcpt_val <= 1'h0;	// rob.scala:258:33, :370:23, :646:23
      rob_val_0 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_1 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_2 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_3 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_4 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_5 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_6 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_7 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_8 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_9 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_10 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_11 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_12 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_13 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_14 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_15 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_16 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_17 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_18 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_19 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_20 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_21 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_22 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_23 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_24 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_25 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_26 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_27 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_28 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_29 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_30 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_31 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_1_0 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_1_1 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_1_2 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_1_3 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_1_4 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_1_5 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_1_6 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_1_7 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_1_8 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_1_9 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_1_10 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_1_11 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_1_12 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_1_13 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_1_14 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_1_15 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_1_16 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_1_17 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_1_18 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_1_19 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_1_20 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_1_21 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_1_22 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_1_23 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_1_24 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_1_25 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_1_26 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_1_27 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_1_28 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_1_29 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_1_30 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      rob_val_1_31 <= 1'h0;	// rob.scala:307:32, :370:23, :646:23
      r_partial_row <= 1'h0;	// rob.scala:370:23, :646:23, :677:30
      pnr_maybe_at_tail <= 1'h0;	// rob.scala:370:23, :646:23, :714:36
    end
    else begin
      automatic logic            _GEN_1400;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1401;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1402;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1403;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1404;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1405;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1406;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1407;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1408;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1409;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1410;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1411;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1412;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1413;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1414;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1415;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1416;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1417;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1418;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1419;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1420;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1421;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1422;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1423;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1424;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1425;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1426;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1427;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1428;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1429;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1430;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1431;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1432;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1433;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1434;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1435;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1436;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1437;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1438;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1439;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1440;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1441;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1442;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1443;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1444;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1445;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1446;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1447;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1448;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1449;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1450;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1451;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1452;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1453;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1454;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1455;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1456;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1457;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1458;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1459;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1460;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1461;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1462;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1463;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1464;	// rob.scala:476:25
      automatic logic            _GEN_1465;	// rob.scala:476:25
      automatic logic            _GEN_1466;	// rob.scala:476:25
      automatic logic            _GEN_1467;	// rob.scala:476:25
      automatic logic            _GEN_1468;	// rob.scala:476:25
      automatic logic            _GEN_1469;	// rob.scala:476:25
      automatic logic            _GEN_1470;	// rob.scala:476:25
      automatic logic            _GEN_1471;	// rob.scala:476:25
      automatic logic            _GEN_1472;	// rob.scala:476:25
      automatic logic            _GEN_1473;	// rob.scala:476:25
      automatic logic            _GEN_1474;	// rob.scala:476:25
      automatic logic            _GEN_1475;	// rob.scala:476:25
      automatic logic            _GEN_1476;	// rob.scala:476:25
      automatic logic            _GEN_1477;	// rob.scala:476:25
      automatic logic            _GEN_1478;	// rob.scala:476:25
      automatic logic            _GEN_1479;	// rob.scala:476:25
      automatic logic            _GEN_1480;	// rob.scala:476:25
      automatic logic            _GEN_1481;	// rob.scala:476:25
      automatic logic            _GEN_1482;	// rob.scala:476:25
      automatic logic            _GEN_1483;	// rob.scala:476:25
      automatic logic            _GEN_1484;	// rob.scala:476:25
      automatic logic            _GEN_1485;	// rob.scala:476:25
      automatic logic            _GEN_1486;	// rob.scala:476:25
      automatic logic            _GEN_1487;	// rob.scala:476:25
      automatic logic            _GEN_1488;	// rob.scala:476:25
      automatic logic            _GEN_1489;	// rob.scala:476:25
      automatic logic            _GEN_1490;	// rob.scala:476:25
      automatic logic            _GEN_1491;	// rob.scala:476:25
      automatic logic            _GEN_1492;	// rob.scala:476:25
      automatic logic            _GEN_1493;	// rob.scala:476:25
      automatic logic            _GEN_1494;	// rob.scala:476:25
      automatic logic            rob_pnr_unsafe_0;	// rob.scala:493:43
      automatic logic            _GEN_1495;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1496;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1497;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1498;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1499;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1500;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1501;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1502;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1503;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1504;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1505;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1506;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1507;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1508;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1509;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1510;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1511;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1512;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1513;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1514;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1515;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1516;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1517;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1518;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1519;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1520;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1521;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1522;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1523;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1524;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1525;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1526;	// rob.scala:307:32, :323:29, :324:31
      automatic logic            _GEN_1527;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1528;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1529;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1530;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1531;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1532;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1533;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1534;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1535;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1536;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1537;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1538;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1539;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1540;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1541;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1542;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1543;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1544;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1545;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1546;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1547;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1548;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1549;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1550;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1551;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1552;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1553;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1554;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1555;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1556;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1557;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1558;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20
      automatic logic            _GEN_1559 = io_enq_valids_0 | io_enq_valids_1;	// rob.scala:679:31
      automatic logic            _do_inc_row_T_2;	// rob.scala:717:64
      automatic logic            do_inc_row;	// rob.scala:717:52
      automatic logic [1:0]      _lo_T_23 = {io_enq_valids_1, io_enq_valids_0};	// rob.scala:718:34
      automatic logic            _GEN_1560;	// rob.scala:755:68
      automatic logic            _GEN_1561;	// rob.scala:761:45
      automatic logic [1:0]      _GEN_1562;	// rob.scala:221:26, :819:22, :820:21
      automatic logic [3:0][1:0] _GEN_1563;	// Conditional.scala:37:30, :39:67, :40:58, rob.scala:221:26, :540:61, :804:19, :808:51, :819:22, :824:42
      _GEN_1400 = _GEN_64 | rob_val_0;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1401 = _GEN_66 | rob_val_1;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1402 = _GEN_68 | rob_val_2;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1403 = _GEN_70 | rob_val_3;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1404 = _GEN_72 | rob_val_4;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1405 = _GEN_74 | rob_val_5;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1406 = _GEN_76 | rob_val_6;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1407 = _GEN_78 | rob_val_7;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1408 = _GEN_80 | rob_val_8;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1409 = _GEN_82 | rob_val_9;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1410 = _GEN_84 | rob_val_10;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1411 = _GEN_86 | rob_val_11;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1412 = _GEN_88 | rob_val_12;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1413 = _GEN_90 | rob_val_13;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1414 = _GEN_92 | rob_val_14;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1415 = _GEN_94 | rob_val_15;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1416 = _GEN_96 | rob_val_16;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1417 = _GEN_98 | rob_val_17;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1418 = _GEN_100 | rob_val_18;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1419 = _GEN_102 | rob_val_19;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1420 = _GEN_104 | rob_val_20;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1421 = _GEN_106 | rob_val_21;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1422 = _GEN_108 | rob_val_22;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1423 = _GEN_110 | rob_val_23;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1424 = _GEN_112 | rob_val_24;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1425 = _GEN_114 | rob_val_25;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1426 = _GEN_116 | rob_val_26;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1427 = _GEN_118 | rob_val_27;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1428 = _GEN_120 | rob_val_28;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1429 = _GEN_122 | rob_val_29;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1430 = _GEN_124 | rob_val_30;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1431 = _GEN_125 | rob_val_31;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1432 = (|_GEN_853) | _GEN_791;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1433 = (|_GEN_854) | _GEN_793;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1434 = (|_GEN_855) | _GEN_795;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1435 = (|_GEN_856) | _GEN_797;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1436 = (|_GEN_857) | _GEN_799;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1437 = (|_GEN_858) | _GEN_801;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1438 = (|_GEN_859) | _GEN_803;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1439 = (|_GEN_860) | _GEN_805;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1440 = (|_GEN_861) | _GEN_807;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1441 = (|_GEN_862) | _GEN_809;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1442 = (|_GEN_863) | _GEN_811;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1443 = (|_GEN_864) | _GEN_813;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1444 = (|_GEN_865) | _GEN_815;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1445 = (|_GEN_866) | _GEN_817;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1446 = (|_GEN_867) | _GEN_819;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1447 = (|_GEN_868) | _GEN_821;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1448 = (|_GEN_869) | _GEN_823;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1449 = (|_GEN_870) | _GEN_825;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1450 = (|_GEN_871) | _GEN_827;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1451 = (|_GEN_872) | _GEN_829;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1452 = (|_GEN_873) | _GEN_831;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1453 = (|_GEN_874) | _GEN_833;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1454 = (|_GEN_875) | _GEN_835;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1455 = (|_GEN_876) | _GEN_837;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1456 = (|_GEN_877) | _GEN_839;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1457 = (|_GEN_878) | _GEN_841;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1458 = (|_GEN_879) | _GEN_843;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1459 = (|_GEN_880) | _GEN_845;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1460 = (|_GEN_881) | _GEN_847;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1461 = (|_GEN_882) | _GEN_849;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1462 = (|_GEN_883) | _GEN_851;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1463 = (|_GEN_884) | _GEN_852;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1464 = rob_head == 5'h0;	// rob.scala:224:29, :476:25
      _GEN_1465 = rob_head == 5'h1;	// rob.scala:224:29, :324:31, :476:25
      _GEN_1466 = rob_head == 5'h2;	// rob.scala:224:29, :324:31, :476:25
      _GEN_1467 = rob_head == 5'h3;	// rob.scala:224:29, :324:31, :476:25
      _GEN_1468 = rob_head == 5'h4;	// rob.scala:224:29, :324:31, :476:25
      _GEN_1469 = rob_head == 5'h5;	// rob.scala:224:29, :324:31, :476:25
      _GEN_1470 = rob_head == 5'h6;	// rob.scala:224:29, :324:31, :476:25
      _GEN_1471 = rob_head == 5'h7;	// rob.scala:224:29, :324:31, :476:25
      _GEN_1472 = rob_head == 5'h8;	// rob.scala:224:29, :324:31, :476:25
      _GEN_1473 = rob_head == 5'h9;	// rob.scala:224:29, :324:31, :476:25
      _GEN_1474 = rob_head == 5'hA;	// rob.scala:224:29, :324:31, :476:25
      _GEN_1475 = rob_head == 5'hB;	// rob.scala:224:29, :324:31, :476:25
      _GEN_1476 = rob_head == 5'hC;	// rob.scala:224:29, :324:31, :476:25
      _GEN_1477 = rob_head == 5'hD;	// rob.scala:224:29, :324:31, :476:25
      _GEN_1478 = rob_head == 5'hE;	// rob.scala:224:29, :324:31, :476:25
      _GEN_1479 = rob_head == 5'hF;	// rob.scala:224:29, :324:31, :476:25
      _GEN_1480 = rob_head == 5'h10;	// rob.scala:224:29, :324:31, :476:25
      _GEN_1481 = rob_head == 5'h11;	// rob.scala:224:29, :324:31, :476:25
      _GEN_1482 = rob_head == 5'h12;	// rob.scala:224:29, :324:31, :476:25
      _GEN_1483 = rob_head == 5'h13;	// rob.scala:224:29, :324:31, :476:25
      _GEN_1484 = rob_head == 5'h14;	// rob.scala:224:29, :324:31, :476:25
      _GEN_1485 = rob_head == 5'h15;	// rob.scala:224:29, :324:31, :476:25
      _GEN_1486 = rob_head == 5'h16;	// rob.scala:224:29, :324:31, :476:25
      _GEN_1487 = rob_head == 5'h17;	// rob.scala:224:29, :324:31, :476:25
      _GEN_1488 = rob_head == 5'h18;	// rob.scala:224:29, :324:31, :476:25
      _GEN_1489 = rob_head == 5'h19;	// rob.scala:224:29, :324:31, :476:25
      _GEN_1490 = rob_head == 5'h1A;	// rob.scala:224:29, :324:31, :476:25
      _GEN_1491 = rob_head == 5'h1B;	// rob.scala:224:29, :324:31, :476:25
      _GEN_1492 = rob_head == 5'h1C;	// rob.scala:224:29, :324:31, :476:25
      _GEN_1493 = rob_head == 5'h1D;	// rob.scala:224:29, :324:31, :476:25
      _GEN_1494 = rob_head == 5'h1E;	// rob.scala:224:29, :324:31, :476:25
      rob_pnr_unsafe_0 = _GEN[rob_pnr] & (_GEN_9[rob_pnr] | _GEN_10[rob_pnr]);	// rob.scala:232:29, :324:31, :394:15, :398:49, :493:{43,67}
      _GEN_1495 = _GEN_885 | rob_val_1_0;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1496 = _GEN_886 | rob_val_1_1;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1497 = _GEN_887 | rob_val_1_2;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1498 = _GEN_888 | rob_val_1_3;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1499 = _GEN_889 | rob_val_1_4;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1500 = _GEN_890 | rob_val_1_5;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1501 = _GEN_891 | rob_val_1_6;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1502 = _GEN_892 | rob_val_1_7;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1503 = _GEN_893 | rob_val_1_8;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1504 = _GEN_894 | rob_val_1_9;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1505 = _GEN_895 | rob_val_1_10;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1506 = _GEN_896 | rob_val_1_11;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1507 = _GEN_897 | rob_val_1_12;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1508 = _GEN_898 | rob_val_1_13;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1509 = _GEN_899 | rob_val_1_14;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1510 = _GEN_900 | rob_val_1_15;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1511 = _GEN_901 | rob_val_1_16;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1512 = _GEN_902 | rob_val_1_17;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1513 = _GEN_903 | rob_val_1_18;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1514 = _GEN_904 | rob_val_1_19;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1515 = _GEN_905 | rob_val_1_20;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1516 = _GEN_906 | rob_val_1_21;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1517 = _GEN_907 | rob_val_1_22;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1518 = _GEN_908 | rob_val_1_23;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1519 = _GEN_909 | rob_val_1_24;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1520 = _GEN_910 | rob_val_1_25;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1521 = _GEN_911 | rob_val_1_26;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1522 = _GEN_912 | rob_val_1_27;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1523 = _GEN_913 | rob_val_1_28;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1524 = _GEN_914 | rob_val_1_29;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1525 = _GEN_915 | rob_val_1_30;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1526 = _GEN_916 | rob_val_1_31;	// rob.scala:307:32, :323:29, :324:31
      _GEN_1527 = (|_GEN_1365) | _GEN_1333;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1528 = (|_GEN_1366) | _GEN_1334;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1529 = (|_GEN_1367) | _GEN_1335;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1530 = (|_GEN_1368) | _GEN_1336;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1531 = (|_GEN_1369) | _GEN_1337;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1532 = (|_GEN_1370) | _GEN_1338;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1533 = (|_GEN_1371) | _GEN_1339;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1534 = (|_GEN_1372) | _GEN_1340;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1535 = (|_GEN_1373) | _GEN_1341;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1536 = (|_GEN_1374) | _GEN_1342;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1537 = (|_GEN_1375) | _GEN_1343;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1538 = (|_GEN_1376) | _GEN_1344;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1539 = (|_GEN_1377) | _GEN_1345;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1540 = (|_GEN_1378) | _GEN_1346;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1541 = (|_GEN_1379) | _GEN_1347;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1542 = (|_GEN_1380) | _GEN_1348;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1543 = (|_GEN_1381) | _GEN_1349;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1544 = (|_GEN_1382) | _GEN_1350;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1545 = (|_GEN_1383) | _GEN_1351;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1546 = (|_GEN_1384) | _GEN_1352;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1547 = (|_GEN_1385) | _GEN_1353;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1548 = (|_GEN_1386) | _GEN_1354;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1549 = (|_GEN_1387) | _GEN_1355;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1550 = (|_GEN_1388) | _GEN_1356;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1551 = (|_GEN_1389) | _GEN_1357;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1552 = (|_GEN_1390) | _GEN_1358;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1553 = (|_GEN_1391) | _GEN_1359;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1554 = (|_GEN_1392) | _GEN_1360;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1555 = (|_GEN_1393) | _GEN_1361;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1556 = (|_GEN_1394) | _GEN_1362;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1557 = (|_GEN_1395) | _GEN_1363;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _GEN_1558 = (|_GEN_1396) | _GEN_1364;	// rob.scala:323:29, :433:20, :434:30, :455:7, :456:20, util.scala:118:{51,59}
      _do_inc_row_T_2 = rob_pnr != rob_tail;	// rob.scala:228:29, :232:29, :717:64
      do_inc_row =
        ~(rob_pnr_unsafe_0 | _GEN_28[rob_pnr] & (_GEN_38[rob_pnr] | _GEN_39[rob_pnr]))
        & (_do_inc_row_T_2 | full & ~pnr_maybe_at_tail);	// rob.scala:232:29, :324:31, :394:15, :398:49, :493:{43,67}, :714:36, :717:{23,47,52,64,77,86,89}, :787:39
      _GEN_1560 = _io_commit_rollback_T_1 & rob_tail == rob_head & ~maybe_full;	// rob.scala:224:29, :228:29, :236:31, :239:29, :686:49, :755:{54,68}
      _GEN_1561 = (|_lo_T_23) & ~io_enq_partial_stall;	// rob.scala:718:{34,41}, :761:{45,48}
      _GEN_1562 = empty ? 2'h1 : rob_state;	// rob.scala:221:26, :540:33, :788:41, :819:22, :820:21
      _GEN_1563 =
        {{REG_2 ? 2'h2 : _GEN_1562},
         {_GEN_1562},
         {REG_1
            ? 2'h2
            : io_enq_valids_1 & io_enq_uops_1_is_unique | io_enq_valids_0
              & io_enq_uops_0_is_unique
                ? 2'h3
                : rob_state},
         {2'h1}};	// Conditional.scala:37:30, :39:67, :40:58, rob.scala:221:26, :236:31, :419:36, :540:{33,61}, :804:19, :808:{22,51}, :809:21, :812:{36,65}, :813:25, :819:22, :820:21, :824:{22,42}, :825:21, :826:29
      rob_state <= _GEN_1563[rob_state];	// Conditional.scala:37:30, :39:67, :40:58, rob.scala:221:26, :540:61, :804:19, :808:51, :819:22, :824:42
      if (finished_committing_row)	// rob.scala:685:59
        rob_head <= rob_head + 5'h1;	// rob.scala:224:29, :324:31, util.scala:203:14
      rob_head_lsb <= ~finished_committing_row & ~rob_head_vals_0 & rob_head_vals_1;	// Mux.scala:47:69, rob.scala:225:29, :398:49, :685:59, :688:34, :690:18, :693:18
      if (_GEN_62)	// rob.scala:750:34
        rob_tail <= rob_tail - 5'h1;	// rob.scala:228:29, util.scala:220:14
      else if (~_GEN_1560) begin	// rob.scala:755:68
        if (io_brupdate_b2_mispredict)
          rob_tail <= io_brupdate_b2_uop_rob_idx[5:1] + 5'h1;	// rob.scala:228:29, :268:25, :324:31, util.scala:203:14
        else if (_GEN_1561)	// rob.scala:761:45
          rob_tail <= rob_tail + 5'h1;	// rob.scala:228:29, :324:31, util.scala:203:14
      end
      rob_tail_lsb <=
        _GEN_62
        | (_GEN_1560
             ? rob_head_lsb
             : ~(io_brupdate_b2_mispredict | _GEN_1561)
               & ((|_lo_T_23) & io_enq_partial_stall ? _GEN_1559 : rob_tail_lsb));	// rob.scala:225:29, :229:29, :679:31, :718:{34,41}, :750:{34,76}, :753:18, :755:{68,84}, :757:18, :758:43, :760:18, :761:{45,71}, :763:18, :765:{45,70}, :766:18
      if (empty & (|_lo_T_23)) begin	// rob.scala:718:{17,34,41}, :788:41
        rob_pnr <= rob_head;	// rob.scala:224:29, :232:29
        rob_pnr_lsb <= ~io_enq_valids_0;	// Mux.scala:47:69, rob.scala:225:29, :233:29
      end
      else begin	// rob.scala:718:17
        automatic logic safe_to_inc;	// rob.scala:716:46
        automatic logic _GEN_1564;	// rob.scala:725:30
        safe_to_inc = _io_ready_T | (&rob_state);	// rob.scala:221:26, :716:{33,46,59}
        _GEN_1564 = safe_to_inc & do_inc_row;	// rob.scala:716:46, :717:52, :725:30
        if (_GEN_1564)	// rob.scala:725:30
          rob_pnr <= rob_pnr + 5'h1;	// rob.scala:232:29, :324:31, util.scala:203:14
        rob_pnr_lsb <=
          ~_GEN_1564
          & (safe_to_inc & (_do_inc_row_T_2 | full & ~pnr_maybe_at_tail)
               ? ~rob_pnr_unsafe_0
               : safe_to_inc & ~full & ~empty
                   ? ~(rob_pnr_unsafe_0 | ~(rob_tail_vals_0 | rob_tail_vals_1))
                   : ~(full & pnr_maybe_at_tail) & rob_pnr_lsb);	// Mux.scala:47:69, rob.scala:225:29, :233:29, :324:31, :425:47, :493:43, :714:36, :716:46, :717:{64,89}, :725:{30,45}, :727:19, :728:{30,55,64,89}, :729:19, :730:{39,42,50}, :731:{19,60,62}, :732:{23,45}, :733:19, :787:39, :788:41, util.scala:373:{29,45}
      end
      maybe_full <=
        ~rob_deq
        & (~(_GEN_62 | _GEN_1560 | io_brupdate_b2_mispredict) & _GEN_1561 | maybe_full)
        | (|io_brupdate_b1_mispredict_mask);	// rob.scala:239:29, :688:34, :736:26, :750:{34,76}, :754:13, :755:{68,84}, :758:43, :761:{45,71}, :786:{26,38,53,87}
      r_xcpt_val <=
        ~(_io_flush_valid_output
          | (|(io_brupdate_b1_mispredict_mask & next_xcpt_uop_br_mask)))
        & (_GEN_1397
             ? (io_lxcpt_valid ? _GEN_1398 | r_xcpt_val : _GEN_1399 | r_xcpt_val)
             : r_xcpt_val);	// rob.scala:258:33, :573:36, :625:17, :631:{47,76}, :632:27, :635:{25,93}, :636:33, :641:{30,56}, :645:23, :654:{24,73}, :655:16, util.scala:118:{51,59}
      if (will_commit_0) begin	// rob.scala:547:70
        rob_val_0 <= ~(_GEN_1464 | _GEN_1432) & _GEN_1400;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_1 <= ~(_GEN_1465 | _GEN_1433) & _GEN_1401;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_2 <= ~(_GEN_1466 | _GEN_1434) & _GEN_1402;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_3 <= ~(_GEN_1467 | _GEN_1435) & _GEN_1403;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_4 <= ~(_GEN_1468 | _GEN_1436) & _GEN_1404;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_5 <= ~(_GEN_1469 | _GEN_1437) & _GEN_1405;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_6 <= ~(_GEN_1470 | _GEN_1438) & _GEN_1406;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_7 <= ~(_GEN_1471 | _GEN_1439) & _GEN_1407;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_8 <= ~(_GEN_1472 | _GEN_1440) & _GEN_1408;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_9 <= ~(_GEN_1473 | _GEN_1441) & _GEN_1409;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_10 <= ~(_GEN_1474 | _GEN_1442) & _GEN_1410;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_11 <= ~(_GEN_1475 | _GEN_1443) & _GEN_1411;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_12 <= ~(_GEN_1476 | _GEN_1444) & _GEN_1412;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_13 <= ~(_GEN_1477 | _GEN_1445) & _GEN_1413;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_14 <= ~(_GEN_1478 | _GEN_1446) & _GEN_1414;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_15 <= ~(_GEN_1479 | _GEN_1447) & _GEN_1415;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_16 <= ~(_GEN_1480 | _GEN_1448) & _GEN_1416;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_17 <= ~(_GEN_1481 | _GEN_1449) & _GEN_1417;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_18 <= ~(_GEN_1482 | _GEN_1450) & _GEN_1418;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_19 <= ~(_GEN_1483 | _GEN_1451) & _GEN_1419;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_20 <= ~(_GEN_1484 | _GEN_1452) & _GEN_1420;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_21 <= ~(_GEN_1485 | _GEN_1453) & _GEN_1421;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_22 <= ~(_GEN_1486 | _GEN_1454) & _GEN_1422;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_23 <= ~(_GEN_1487 | _GEN_1455) & _GEN_1423;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_24 <= ~(_GEN_1488 | _GEN_1456) & _GEN_1424;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_25 <= ~(_GEN_1489 | _GEN_1457) & _GEN_1425;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_26 <= ~(_GEN_1490 | _GEN_1458) & _GEN_1426;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_27 <= ~(_GEN_1491 | _GEN_1459) & _GEN_1427;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_28 <= ~(_GEN_1492 | _GEN_1460) & _GEN_1428;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_29 <= ~(_GEN_1493 | _GEN_1461) & _GEN_1429;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_30 <= ~(_GEN_1494 | _GEN_1462) & _GEN_1430;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_31 <= ~((&rob_head) | _GEN_1463) & _GEN_1431;	// rob.scala:224:29, :307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
      end
      else begin	// rob.scala:547:70
        rob_val_0 <= ~_GEN_1432 & _GEN_1400;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_1 <= ~_GEN_1433 & _GEN_1401;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_2 <= ~_GEN_1434 & _GEN_1402;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_3 <= ~_GEN_1435 & _GEN_1403;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_4 <= ~_GEN_1436 & _GEN_1404;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_5 <= ~_GEN_1437 & _GEN_1405;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_6 <= ~_GEN_1438 & _GEN_1406;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_7 <= ~_GEN_1439 & _GEN_1407;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_8 <= ~_GEN_1440 & _GEN_1408;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_9 <= ~_GEN_1441 & _GEN_1409;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_10 <= ~_GEN_1442 & _GEN_1410;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_11 <= ~_GEN_1443 & _GEN_1411;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_12 <= ~_GEN_1444 & _GEN_1412;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_13 <= ~_GEN_1445 & _GEN_1413;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_14 <= ~_GEN_1446 & _GEN_1414;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_15 <= ~_GEN_1447 & _GEN_1415;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_16 <= ~_GEN_1448 & _GEN_1416;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_17 <= ~_GEN_1449 & _GEN_1417;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_18 <= ~_GEN_1450 & _GEN_1418;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_19 <= ~_GEN_1451 & _GEN_1419;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_20 <= ~_GEN_1452 & _GEN_1420;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_21 <= ~_GEN_1453 & _GEN_1421;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_22 <= ~_GEN_1454 & _GEN_1422;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_23 <= ~_GEN_1455 & _GEN_1423;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_24 <= ~_GEN_1456 & _GEN_1424;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_25 <= ~_GEN_1457 & _GEN_1425;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_26 <= ~_GEN_1458 & _GEN_1426;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_27 <= ~_GEN_1459 & _GEN_1427;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_28 <= ~_GEN_1460 & _GEN_1428;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_29 <= ~_GEN_1461 & _GEN_1429;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_30 <= ~_GEN_1462 & _GEN_1430;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_31 <= ~_GEN_1463 & _GEN_1431;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
      end
      if (will_commit_1) begin	// rob.scala:547:70
        rob_val_1_0 <= ~(_GEN_1464 | _GEN_1527) & _GEN_1495;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_1_1 <= ~(_GEN_1465 | _GEN_1528) & _GEN_1496;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_1_2 <= ~(_GEN_1466 | _GEN_1529) & _GEN_1497;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_1_3 <= ~(_GEN_1467 | _GEN_1530) & _GEN_1498;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_1_4 <= ~(_GEN_1468 | _GEN_1531) & _GEN_1499;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_1_5 <= ~(_GEN_1469 | _GEN_1532) & _GEN_1500;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_1_6 <= ~(_GEN_1470 | _GEN_1533) & _GEN_1501;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_1_7 <= ~(_GEN_1471 | _GEN_1534) & _GEN_1502;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_1_8 <= ~(_GEN_1472 | _GEN_1535) & _GEN_1503;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_1_9 <= ~(_GEN_1473 | _GEN_1536) & _GEN_1504;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_1_10 <= ~(_GEN_1474 | _GEN_1537) & _GEN_1505;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_1_11 <= ~(_GEN_1475 | _GEN_1538) & _GEN_1506;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_1_12 <= ~(_GEN_1476 | _GEN_1539) & _GEN_1507;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_1_13 <= ~(_GEN_1477 | _GEN_1540) & _GEN_1508;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_1_14 <= ~(_GEN_1478 | _GEN_1541) & _GEN_1509;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_1_15 <= ~(_GEN_1479 | _GEN_1542) & _GEN_1510;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_1_16 <= ~(_GEN_1480 | _GEN_1543) & _GEN_1511;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_1_17 <= ~(_GEN_1481 | _GEN_1544) & _GEN_1512;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_1_18 <= ~(_GEN_1482 | _GEN_1545) & _GEN_1513;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_1_19 <= ~(_GEN_1483 | _GEN_1546) & _GEN_1514;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_1_20 <= ~(_GEN_1484 | _GEN_1547) & _GEN_1515;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_1_21 <= ~(_GEN_1485 | _GEN_1548) & _GEN_1516;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_1_22 <= ~(_GEN_1486 | _GEN_1549) & _GEN_1517;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_1_23 <= ~(_GEN_1487 | _GEN_1550) & _GEN_1518;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_1_24 <= ~(_GEN_1488 | _GEN_1551) & _GEN_1519;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_1_25 <= ~(_GEN_1489 | _GEN_1552) & _GEN_1520;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_1_26 <= ~(_GEN_1490 | _GEN_1553) & _GEN_1521;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_1_27 <= ~(_GEN_1491 | _GEN_1554) & _GEN_1522;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_1_28 <= ~(_GEN_1492 | _GEN_1555) & _GEN_1523;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_1_29 <= ~(_GEN_1493 | _GEN_1556) & _GEN_1524;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_1_30 <= ~(_GEN_1494 | _GEN_1557) & _GEN_1525;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
        rob_val_1_31 <= ~((&rob_head) | _GEN_1558) & _GEN_1526;	// rob.scala:224:29, :307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20, :476:25
      end
      else begin	// rob.scala:547:70
        rob_val_1_0 <= ~_GEN_1527 & _GEN_1495;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_1_1 <= ~_GEN_1528 & _GEN_1496;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_1_2 <= ~_GEN_1529 & _GEN_1497;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_1_3 <= ~_GEN_1530 & _GEN_1498;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_1_4 <= ~_GEN_1531 & _GEN_1499;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_1_5 <= ~_GEN_1532 & _GEN_1500;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_1_6 <= ~_GEN_1533 & _GEN_1501;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_1_7 <= ~_GEN_1534 & _GEN_1502;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_1_8 <= ~_GEN_1535 & _GEN_1503;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_1_9 <= ~_GEN_1536 & _GEN_1504;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_1_10 <= ~_GEN_1537 & _GEN_1505;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_1_11 <= ~_GEN_1538 & _GEN_1506;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_1_12 <= ~_GEN_1539 & _GEN_1507;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_1_13 <= ~_GEN_1540 & _GEN_1508;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_1_14 <= ~_GEN_1541 & _GEN_1509;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_1_15 <= ~_GEN_1542 & _GEN_1510;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_1_16 <= ~_GEN_1543 & _GEN_1511;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_1_17 <= ~_GEN_1544 & _GEN_1512;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_1_18 <= ~_GEN_1545 & _GEN_1513;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_1_19 <= ~_GEN_1546 & _GEN_1514;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_1_20 <= ~_GEN_1547 & _GEN_1515;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_1_21 <= ~_GEN_1548 & _GEN_1516;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_1_22 <= ~_GEN_1549 & _GEN_1517;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_1_23 <= ~_GEN_1550 & _GEN_1518;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_1_24 <= ~_GEN_1551 & _GEN_1519;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_1_25 <= ~_GEN_1552 & _GEN_1520;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_1_26 <= ~_GEN_1553 & _GEN_1521;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_1_27 <= ~_GEN_1554 & _GEN_1522;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_1_28 <= ~_GEN_1555 & _GEN_1523;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_1_29 <= ~_GEN_1556 & _GEN_1524;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_1_30 <= ~_GEN_1557 & _GEN_1525;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
        rob_val_1_31 <= ~_GEN_1558 & _GEN_1526;	// rob.scala:307:32, :323:29, :324:31, :433:20, :434:30, :455:7, :456:20
      end
      if (_GEN_1559)	// rob.scala:679:31
        r_partial_row <= io_enq_partial_stall;	// rob.scala:677:30
      pnr_maybe_at_tail <= ~rob_deq & (do_inc_row | pnr_maybe_at_tail);	// rob.scala:688:34, :714:36, :717:52, :736:{26,35,50}, :750:76, :754:13
    end
    r_xcpt_uop_br_mask <= next_xcpt_uop_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:259:29, :625:17, :631:76, :632:27, util.scala:85:{25,27}
    if (_GEN_1397) begin	// rob.scala:631:47
      if (io_lxcpt_valid) begin
        if (_GEN_1398) begin	// rob.scala:635:25
          r_xcpt_uop_rob_idx <= io_lxcpt_bits_uop_rob_idx;	// rob.scala:259:29
          r_xcpt_uop_exc_cause <= {59'h0, io_lxcpt_bits_cause};	// rob.scala:259:29, :556:50, :638:33
          r_xcpt_badvaddr <= io_lxcpt_bits_badvaddr;	// rob.scala:260:29
        end
      end
      else if (_GEN_1399) begin	// rob.scala:641:30
        if (enq_xcpts_0) begin	// rob.scala:628:38
          r_xcpt_uop_rob_idx <= io_enq_uops_0_rob_idx;	// rob.scala:259:29
          r_xcpt_uop_exc_cause <= io_enq_uops_0_exc_cause;	// rob.scala:259:29
        end
        else begin	// rob.scala:628:38
          r_xcpt_uop_rob_idx <= io_enq_uops_1_rob_idx;	// rob.scala:259:29
          r_xcpt_uop_exc_cause <= io_enq_uops_1_exc_cause;	// rob.scala:259:29
        end
        r_xcpt_badvaddr <=
          {io_xcpt_fetch_pc[39:6],
           enq_xcpts_0 ? io_enq_uops_0_pc_lob : io_enq_uops_1_pc_lob};	// rob.scala:260:29, :628:38, :646:23, :647:76
      end
    end
    rob_bsy_0 <= ~_GEN_697 & (_GEN_5 ? ~_GEN_634 & _GEN_445 : ~_GEN_571 & _GEN_445);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_1 <= ~_GEN_699 & (_GEN_5 ? ~_GEN_636 & _GEN_448 : ~_GEN_573 & _GEN_448);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_2 <= ~_GEN_701 & (_GEN_5 ? ~_GEN_638 & _GEN_451 : ~_GEN_575 & _GEN_451);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_3 <= ~_GEN_703 & (_GEN_5 ? ~_GEN_640 & _GEN_454 : ~_GEN_577 & _GEN_454);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_4 <= ~_GEN_705 & (_GEN_5 ? ~_GEN_642 & _GEN_457 : ~_GEN_579 & _GEN_457);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_5 <= ~_GEN_707 & (_GEN_5 ? ~_GEN_644 & _GEN_460 : ~_GEN_581 & _GEN_460);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_6 <= ~_GEN_709 & (_GEN_5 ? ~_GEN_646 & _GEN_463 : ~_GEN_583 & _GEN_463);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_7 <= ~_GEN_711 & (_GEN_5 ? ~_GEN_648 & _GEN_466 : ~_GEN_585 & _GEN_466);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_8 <= ~_GEN_713 & (_GEN_5 ? ~_GEN_650 & _GEN_469 : ~_GEN_587 & _GEN_469);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_9 <= ~_GEN_715 & (_GEN_5 ? ~_GEN_652 & _GEN_472 : ~_GEN_589 & _GEN_472);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_10 <= ~_GEN_717 & (_GEN_5 ? ~_GEN_654 & _GEN_475 : ~_GEN_591 & _GEN_475);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_11 <= ~_GEN_719 & (_GEN_5 ? ~_GEN_656 & _GEN_478 : ~_GEN_593 & _GEN_478);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_12 <= ~_GEN_721 & (_GEN_5 ? ~_GEN_658 & _GEN_481 : ~_GEN_595 & _GEN_481);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_13 <= ~_GEN_723 & (_GEN_5 ? ~_GEN_660 & _GEN_484 : ~_GEN_597 & _GEN_484);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_14 <= ~_GEN_725 & (_GEN_5 ? ~_GEN_662 & _GEN_487 : ~_GEN_599 & _GEN_487);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_15 <= ~_GEN_727 & (_GEN_5 ? ~_GEN_664 & _GEN_490 : ~_GEN_601 & _GEN_490);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_16 <= ~_GEN_729 & (_GEN_5 ? ~_GEN_666 & _GEN_493 : ~_GEN_603 & _GEN_493);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_17 <= ~_GEN_731 & (_GEN_5 ? ~_GEN_668 & _GEN_496 : ~_GEN_605 & _GEN_496);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_18 <= ~_GEN_733 & (_GEN_5 ? ~_GEN_670 & _GEN_499 : ~_GEN_607 & _GEN_499);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_19 <= ~_GEN_735 & (_GEN_5 ? ~_GEN_672 & _GEN_502 : ~_GEN_609 & _GEN_502);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_20 <= ~_GEN_737 & (_GEN_5 ? ~_GEN_674 & _GEN_505 : ~_GEN_611 & _GEN_505);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_21 <= ~_GEN_739 & (_GEN_5 ? ~_GEN_676 & _GEN_508 : ~_GEN_613 & _GEN_508);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_22 <= ~_GEN_741 & (_GEN_5 ? ~_GEN_678 & _GEN_511 : ~_GEN_615 & _GEN_511);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_23 <= ~_GEN_743 & (_GEN_5 ? ~_GEN_680 & _GEN_514 : ~_GEN_617 & _GEN_514);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_24 <= ~_GEN_745 & (_GEN_5 ? ~_GEN_682 & _GEN_517 : ~_GEN_619 & _GEN_517);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_25 <= ~_GEN_747 & (_GEN_5 ? ~_GEN_684 & _GEN_520 : ~_GEN_621 & _GEN_520);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_26 <= ~_GEN_749 & (_GEN_5 ? ~_GEN_686 & _GEN_523 : ~_GEN_623 & _GEN_523);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_27 <= ~_GEN_751 & (_GEN_5 ? ~_GEN_688 & _GEN_526 : ~_GEN_625 & _GEN_526);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_28 <= ~_GEN_753 & (_GEN_5 ? ~_GEN_690 & _GEN_529 : ~_GEN_627 & _GEN_529);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_29 <= ~_GEN_755 & (_GEN_5 ? ~_GEN_692 & _GEN_532 : ~_GEN_629 & _GEN_532);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_30 <= ~_GEN_757 & (_GEN_5 ? ~_GEN_694 & _GEN_535 : ~_GEN_631 & _GEN_535);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_31 <= ~_GEN_758 & (_GEN_5 ? ~_GEN_695 & _GEN_537 : ~_GEN_632 & _GEN_537);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_unsafe_0 <= ~_GEN_697 & (_GEN_5 ? ~_GEN_634 & _GEN_538 : ~_GEN_571 & _GEN_538);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_1 <= ~_GEN_699 & (_GEN_5 ? ~_GEN_636 & _GEN_539 : ~_GEN_573 & _GEN_539);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_2 <= ~_GEN_701 & (_GEN_5 ? ~_GEN_638 & _GEN_540 : ~_GEN_575 & _GEN_540);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_3 <= ~_GEN_703 & (_GEN_5 ? ~_GEN_640 & _GEN_541 : ~_GEN_577 & _GEN_541);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_4 <= ~_GEN_705 & (_GEN_5 ? ~_GEN_642 & _GEN_542 : ~_GEN_579 & _GEN_542);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_5 <= ~_GEN_707 & (_GEN_5 ? ~_GEN_644 & _GEN_543 : ~_GEN_581 & _GEN_543);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_6 <= ~_GEN_709 & (_GEN_5 ? ~_GEN_646 & _GEN_544 : ~_GEN_583 & _GEN_544);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_7 <= ~_GEN_711 & (_GEN_5 ? ~_GEN_648 & _GEN_545 : ~_GEN_585 & _GEN_545);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_8 <= ~_GEN_713 & (_GEN_5 ? ~_GEN_650 & _GEN_546 : ~_GEN_587 & _GEN_546);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_9 <= ~_GEN_715 & (_GEN_5 ? ~_GEN_652 & _GEN_547 : ~_GEN_589 & _GEN_547);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_10 <= ~_GEN_717 & (_GEN_5 ? ~_GEN_654 & _GEN_548 : ~_GEN_591 & _GEN_548);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_11 <= ~_GEN_719 & (_GEN_5 ? ~_GEN_656 & _GEN_549 : ~_GEN_593 & _GEN_549);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_12 <= ~_GEN_721 & (_GEN_5 ? ~_GEN_658 & _GEN_550 : ~_GEN_595 & _GEN_550);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_13 <= ~_GEN_723 & (_GEN_5 ? ~_GEN_660 & _GEN_551 : ~_GEN_597 & _GEN_551);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_14 <= ~_GEN_725 & (_GEN_5 ? ~_GEN_662 & _GEN_552 : ~_GEN_599 & _GEN_552);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_15 <= ~_GEN_727 & (_GEN_5 ? ~_GEN_664 & _GEN_553 : ~_GEN_601 & _GEN_553);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_16 <= ~_GEN_729 & (_GEN_5 ? ~_GEN_666 & _GEN_554 : ~_GEN_603 & _GEN_554);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_17 <= ~_GEN_731 & (_GEN_5 ? ~_GEN_668 & _GEN_555 : ~_GEN_605 & _GEN_555);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_18 <= ~_GEN_733 & (_GEN_5 ? ~_GEN_670 & _GEN_556 : ~_GEN_607 & _GEN_556);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_19 <= ~_GEN_735 & (_GEN_5 ? ~_GEN_672 & _GEN_557 : ~_GEN_609 & _GEN_557);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_20 <= ~_GEN_737 & (_GEN_5 ? ~_GEN_674 & _GEN_558 : ~_GEN_611 & _GEN_558);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_21 <= ~_GEN_739 & (_GEN_5 ? ~_GEN_676 & _GEN_559 : ~_GEN_613 & _GEN_559);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_22 <= ~_GEN_741 & (_GEN_5 ? ~_GEN_678 & _GEN_560 : ~_GEN_615 & _GEN_560);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_23 <= ~_GEN_743 & (_GEN_5 ? ~_GEN_680 & _GEN_561 : ~_GEN_617 & _GEN_561);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_24 <= ~_GEN_745 & (_GEN_5 ? ~_GEN_682 & _GEN_562 : ~_GEN_619 & _GEN_562);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_25 <= ~_GEN_747 & (_GEN_5 ? ~_GEN_684 & _GEN_563 : ~_GEN_621 & _GEN_563);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_26 <= ~_GEN_749 & (_GEN_5 ? ~_GEN_686 & _GEN_564 : ~_GEN_623 & _GEN_564);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_27 <= ~_GEN_751 & (_GEN_5 ? ~_GEN_688 & _GEN_565 : ~_GEN_625 & _GEN_565);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_28 <= ~_GEN_753 & (_GEN_5 ? ~_GEN_690 & _GEN_566 : ~_GEN_627 & _GEN_566);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_29 <= ~_GEN_755 & (_GEN_5 ? ~_GEN_692 & _GEN_567 : ~_GEN_629 & _GEN_567);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_30 <= ~_GEN_757 & (_GEN_5 ? ~_GEN_694 & _GEN_568 : ~_GEN_631 & _GEN_568);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_31 <= ~_GEN_758 & (_GEN_5 ? ~_GEN_695 & _GEN_569 : ~_GEN_632 & _GEN_569);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    if (_GEN_64) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_0_uopc <= io_enq_uops_0_uopc;	// rob.scala:310:28
      rob_uop_0_is_rvc <= io_enq_uops_0_is_rvc;	// rob.scala:310:28
      rob_uop_0_ftq_idx <= io_enq_uops_0_ftq_idx;	// rob.scala:310:28
      rob_uop_0_edge_inst <= io_enq_uops_0_edge_inst;	// rob.scala:310:28
      rob_uop_0_pc_lob <= io_enq_uops_0_pc_lob;	// rob.scala:310:28
      rob_uop_0_pdst <= io_enq_uops_0_pdst;	// rob.scala:310:28
      rob_uop_0_stale_pdst <= io_enq_uops_0_stale_pdst;	// rob.scala:310:28
      rob_uop_0_is_fencei <= io_enq_uops_0_is_fencei;	// rob.scala:310:28
      rob_uop_0_uses_ldq <= io_enq_uops_0_uses_ldq;	// rob.scala:310:28
      rob_uop_0_uses_stq <= io_enq_uops_0_uses_stq;	// rob.scala:310:28
      rob_uop_0_is_sys_pc2epc <= io_enq_uops_0_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_0_flush_on_commit <= io_enq_uops_0_flush_on_commit;	// rob.scala:310:28
      rob_uop_0_ldst <= io_enq_uops_0_ldst;	// rob.scala:310:28
      rob_uop_0_ldst_val <= io_enq_uops_0_ldst_val;	// rob.scala:310:28
      rob_uop_0_dst_rtype <= io_enq_uops_0_dst_rtype;	// rob.scala:310:28
      rob_uop_0_fp_val <= io_enq_uops_0_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_853) | ~rob_val_0) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_64)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_0_br_mask <= io_enq_uops_0_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_0_br_mask <= rob_uop_0_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_66) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_1_uopc <= io_enq_uops_0_uopc;	// rob.scala:310:28
      rob_uop_1_is_rvc <= io_enq_uops_0_is_rvc;	// rob.scala:310:28
      rob_uop_1_ftq_idx <= io_enq_uops_0_ftq_idx;	// rob.scala:310:28
      rob_uop_1_edge_inst <= io_enq_uops_0_edge_inst;	// rob.scala:310:28
      rob_uop_1_pc_lob <= io_enq_uops_0_pc_lob;	// rob.scala:310:28
      rob_uop_1_pdst <= io_enq_uops_0_pdst;	// rob.scala:310:28
      rob_uop_1_stale_pdst <= io_enq_uops_0_stale_pdst;	// rob.scala:310:28
      rob_uop_1_is_fencei <= io_enq_uops_0_is_fencei;	// rob.scala:310:28
      rob_uop_1_uses_ldq <= io_enq_uops_0_uses_ldq;	// rob.scala:310:28
      rob_uop_1_uses_stq <= io_enq_uops_0_uses_stq;	// rob.scala:310:28
      rob_uop_1_is_sys_pc2epc <= io_enq_uops_0_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_1_flush_on_commit <= io_enq_uops_0_flush_on_commit;	// rob.scala:310:28
      rob_uop_1_ldst <= io_enq_uops_0_ldst;	// rob.scala:310:28
      rob_uop_1_ldst_val <= io_enq_uops_0_ldst_val;	// rob.scala:310:28
      rob_uop_1_dst_rtype <= io_enq_uops_0_dst_rtype;	// rob.scala:310:28
      rob_uop_1_fp_val <= io_enq_uops_0_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_854) | ~rob_val_1) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_66)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_1_br_mask <= io_enq_uops_0_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_1_br_mask <= rob_uop_1_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_68) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_2_uopc <= io_enq_uops_0_uopc;	// rob.scala:310:28
      rob_uop_2_is_rvc <= io_enq_uops_0_is_rvc;	// rob.scala:310:28
      rob_uop_2_ftq_idx <= io_enq_uops_0_ftq_idx;	// rob.scala:310:28
      rob_uop_2_edge_inst <= io_enq_uops_0_edge_inst;	// rob.scala:310:28
      rob_uop_2_pc_lob <= io_enq_uops_0_pc_lob;	// rob.scala:310:28
      rob_uop_2_pdst <= io_enq_uops_0_pdst;	// rob.scala:310:28
      rob_uop_2_stale_pdst <= io_enq_uops_0_stale_pdst;	// rob.scala:310:28
      rob_uop_2_is_fencei <= io_enq_uops_0_is_fencei;	// rob.scala:310:28
      rob_uop_2_uses_ldq <= io_enq_uops_0_uses_ldq;	// rob.scala:310:28
      rob_uop_2_uses_stq <= io_enq_uops_0_uses_stq;	// rob.scala:310:28
      rob_uop_2_is_sys_pc2epc <= io_enq_uops_0_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_2_flush_on_commit <= io_enq_uops_0_flush_on_commit;	// rob.scala:310:28
      rob_uop_2_ldst <= io_enq_uops_0_ldst;	// rob.scala:310:28
      rob_uop_2_ldst_val <= io_enq_uops_0_ldst_val;	// rob.scala:310:28
      rob_uop_2_dst_rtype <= io_enq_uops_0_dst_rtype;	// rob.scala:310:28
      rob_uop_2_fp_val <= io_enq_uops_0_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_855) | ~rob_val_2) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_68)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_2_br_mask <= io_enq_uops_0_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_2_br_mask <= rob_uop_2_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_70) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_3_uopc <= io_enq_uops_0_uopc;	// rob.scala:310:28
      rob_uop_3_is_rvc <= io_enq_uops_0_is_rvc;	// rob.scala:310:28
      rob_uop_3_ftq_idx <= io_enq_uops_0_ftq_idx;	// rob.scala:310:28
      rob_uop_3_edge_inst <= io_enq_uops_0_edge_inst;	// rob.scala:310:28
      rob_uop_3_pc_lob <= io_enq_uops_0_pc_lob;	// rob.scala:310:28
      rob_uop_3_pdst <= io_enq_uops_0_pdst;	// rob.scala:310:28
      rob_uop_3_stale_pdst <= io_enq_uops_0_stale_pdst;	// rob.scala:310:28
      rob_uop_3_is_fencei <= io_enq_uops_0_is_fencei;	// rob.scala:310:28
      rob_uop_3_uses_ldq <= io_enq_uops_0_uses_ldq;	// rob.scala:310:28
      rob_uop_3_uses_stq <= io_enq_uops_0_uses_stq;	// rob.scala:310:28
      rob_uop_3_is_sys_pc2epc <= io_enq_uops_0_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_3_flush_on_commit <= io_enq_uops_0_flush_on_commit;	// rob.scala:310:28
      rob_uop_3_ldst <= io_enq_uops_0_ldst;	// rob.scala:310:28
      rob_uop_3_ldst_val <= io_enq_uops_0_ldst_val;	// rob.scala:310:28
      rob_uop_3_dst_rtype <= io_enq_uops_0_dst_rtype;	// rob.scala:310:28
      rob_uop_3_fp_val <= io_enq_uops_0_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_856) | ~rob_val_3) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_70)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_3_br_mask <= io_enq_uops_0_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_3_br_mask <= rob_uop_3_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_72) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_4_uopc <= io_enq_uops_0_uopc;	// rob.scala:310:28
      rob_uop_4_is_rvc <= io_enq_uops_0_is_rvc;	// rob.scala:310:28
      rob_uop_4_ftq_idx <= io_enq_uops_0_ftq_idx;	// rob.scala:310:28
      rob_uop_4_edge_inst <= io_enq_uops_0_edge_inst;	// rob.scala:310:28
      rob_uop_4_pc_lob <= io_enq_uops_0_pc_lob;	// rob.scala:310:28
      rob_uop_4_pdst <= io_enq_uops_0_pdst;	// rob.scala:310:28
      rob_uop_4_stale_pdst <= io_enq_uops_0_stale_pdst;	// rob.scala:310:28
      rob_uop_4_is_fencei <= io_enq_uops_0_is_fencei;	// rob.scala:310:28
      rob_uop_4_uses_ldq <= io_enq_uops_0_uses_ldq;	// rob.scala:310:28
      rob_uop_4_uses_stq <= io_enq_uops_0_uses_stq;	// rob.scala:310:28
      rob_uop_4_is_sys_pc2epc <= io_enq_uops_0_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_4_flush_on_commit <= io_enq_uops_0_flush_on_commit;	// rob.scala:310:28
      rob_uop_4_ldst <= io_enq_uops_0_ldst;	// rob.scala:310:28
      rob_uop_4_ldst_val <= io_enq_uops_0_ldst_val;	// rob.scala:310:28
      rob_uop_4_dst_rtype <= io_enq_uops_0_dst_rtype;	// rob.scala:310:28
      rob_uop_4_fp_val <= io_enq_uops_0_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_857) | ~rob_val_4) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_72)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_4_br_mask <= io_enq_uops_0_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_4_br_mask <= rob_uop_4_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_74) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_5_uopc <= io_enq_uops_0_uopc;	// rob.scala:310:28
      rob_uop_5_is_rvc <= io_enq_uops_0_is_rvc;	// rob.scala:310:28
      rob_uop_5_ftq_idx <= io_enq_uops_0_ftq_idx;	// rob.scala:310:28
      rob_uop_5_edge_inst <= io_enq_uops_0_edge_inst;	// rob.scala:310:28
      rob_uop_5_pc_lob <= io_enq_uops_0_pc_lob;	// rob.scala:310:28
      rob_uop_5_pdst <= io_enq_uops_0_pdst;	// rob.scala:310:28
      rob_uop_5_stale_pdst <= io_enq_uops_0_stale_pdst;	// rob.scala:310:28
      rob_uop_5_is_fencei <= io_enq_uops_0_is_fencei;	// rob.scala:310:28
      rob_uop_5_uses_ldq <= io_enq_uops_0_uses_ldq;	// rob.scala:310:28
      rob_uop_5_uses_stq <= io_enq_uops_0_uses_stq;	// rob.scala:310:28
      rob_uop_5_is_sys_pc2epc <= io_enq_uops_0_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_5_flush_on_commit <= io_enq_uops_0_flush_on_commit;	// rob.scala:310:28
      rob_uop_5_ldst <= io_enq_uops_0_ldst;	// rob.scala:310:28
      rob_uop_5_ldst_val <= io_enq_uops_0_ldst_val;	// rob.scala:310:28
      rob_uop_5_dst_rtype <= io_enq_uops_0_dst_rtype;	// rob.scala:310:28
      rob_uop_5_fp_val <= io_enq_uops_0_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_858) | ~rob_val_5) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_74)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_5_br_mask <= io_enq_uops_0_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_5_br_mask <= rob_uop_5_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_76) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_6_uopc <= io_enq_uops_0_uopc;	// rob.scala:310:28
      rob_uop_6_is_rvc <= io_enq_uops_0_is_rvc;	// rob.scala:310:28
      rob_uop_6_ftq_idx <= io_enq_uops_0_ftq_idx;	// rob.scala:310:28
      rob_uop_6_edge_inst <= io_enq_uops_0_edge_inst;	// rob.scala:310:28
      rob_uop_6_pc_lob <= io_enq_uops_0_pc_lob;	// rob.scala:310:28
      rob_uop_6_pdst <= io_enq_uops_0_pdst;	// rob.scala:310:28
      rob_uop_6_stale_pdst <= io_enq_uops_0_stale_pdst;	// rob.scala:310:28
      rob_uop_6_is_fencei <= io_enq_uops_0_is_fencei;	// rob.scala:310:28
      rob_uop_6_uses_ldq <= io_enq_uops_0_uses_ldq;	// rob.scala:310:28
      rob_uop_6_uses_stq <= io_enq_uops_0_uses_stq;	// rob.scala:310:28
      rob_uop_6_is_sys_pc2epc <= io_enq_uops_0_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_6_flush_on_commit <= io_enq_uops_0_flush_on_commit;	// rob.scala:310:28
      rob_uop_6_ldst <= io_enq_uops_0_ldst;	// rob.scala:310:28
      rob_uop_6_ldst_val <= io_enq_uops_0_ldst_val;	// rob.scala:310:28
      rob_uop_6_dst_rtype <= io_enq_uops_0_dst_rtype;	// rob.scala:310:28
      rob_uop_6_fp_val <= io_enq_uops_0_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_859) | ~rob_val_6) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_76)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_6_br_mask <= io_enq_uops_0_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_6_br_mask <= rob_uop_6_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_78) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_7_uopc <= io_enq_uops_0_uopc;	// rob.scala:310:28
      rob_uop_7_is_rvc <= io_enq_uops_0_is_rvc;	// rob.scala:310:28
      rob_uop_7_ftq_idx <= io_enq_uops_0_ftq_idx;	// rob.scala:310:28
      rob_uop_7_edge_inst <= io_enq_uops_0_edge_inst;	// rob.scala:310:28
      rob_uop_7_pc_lob <= io_enq_uops_0_pc_lob;	// rob.scala:310:28
      rob_uop_7_pdst <= io_enq_uops_0_pdst;	// rob.scala:310:28
      rob_uop_7_stale_pdst <= io_enq_uops_0_stale_pdst;	// rob.scala:310:28
      rob_uop_7_is_fencei <= io_enq_uops_0_is_fencei;	// rob.scala:310:28
      rob_uop_7_uses_ldq <= io_enq_uops_0_uses_ldq;	// rob.scala:310:28
      rob_uop_7_uses_stq <= io_enq_uops_0_uses_stq;	// rob.scala:310:28
      rob_uop_7_is_sys_pc2epc <= io_enq_uops_0_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_7_flush_on_commit <= io_enq_uops_0_flush_on_commit;	// rob.scala:310:28
      rob_uop_7_ldst <= io_enq_uops_0_ldst;	// rob.scala:310:28
      rob_uop_7_ldst_val <= io_enq_uops_0_ldst_val;	// rob.scala:310:28
      rob_uop_7_dst_rtype <= io_enq_uops_0_dst_rtype;	// rob.scala:310:28
      rob_uop_7_fp_val <= io_enq_uops_0_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_860) | ~rob_val_7) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_78)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_7_br_mask <= io_enq_uops_0_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_7_br_mask <= rob_uop_7_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_80) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_8_uopc <= io_enq_uops_0_uopc;	// rob.scala:310:28
      rob_uop_8_is_rvc <= io_enq_uops_0_is_rvc;	// rob.scala:310:28
      rob_uop_8_ftq_idx <= io_enq_uops_0_ftq_idx;	// rob.scala:310:28
      rob_uop_8_edge_inst <= io_enq_uops_0_edge_inst;	// rob.scala:310:28
      rob_uop_8_pc_lob <= io_enq_uops_0_pc_lob;	// rob.scala:310:28
      rob_uop_8_pdst <= io_enq_uops_0_pdst;	// rob.scala:310:28
      rob_uop_8_stale_pdst <= io_enq_uops_0_stale_pdst;	// rob.scala:310:28
      rob_uop_8_is_fencei <= io_enq_uops_0_is_fencei;	// rob.scala:310:28
      rob_uop_8_uses_ldq <= io_enq_uops_0_uses_ldq;	// rob.scala:310:28
      rob_uop_8_uses_stq <= io_enq_uops_0_uses_stq;	// rob.scala:310:28
      rob_uop_8_is_sys_pc2epc <= io_enq_uops_0_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_8_flush_on_commit <= io_enq_uops_0_flush_on_commit;	// rob.scala:310:28
      rob_uop_8_ldst <= io_enq_uops_0_ldst;	// rob.scala:310:28
      rob_uop_8_ldst_val <= io_enq_uops_0_ldst_val;	// rob.scala:310:28
      rob_uop_8_dst_rtype <= io_enq_uops_0_dst_rtype;	// rob.scala:310:28
      rob_uop_8_fp_val <= io_enq_uops_0_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_861) | ~rob_val_8) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_80)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_8_br_mask <= io_enq_uops_0_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_8_br_mask <= rob_uop_8_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_82) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_9_uopc <= io_enq_uops_0_uopc;	// rob.scala:310:28
      rob_uop_9_is_rvc <= io_enq_uops_0_is_rvc;	// rob.scala:310:28
      rob_uop_9_ftq_idx <= io_enq_uops_0_ftq_idx;	// rob.scala:310:28
      rob_uop_9_edge_inst <= io_enq_uops_0_edge_inst;	// rob.scala:310:28
      rob_uop_9_pc_lob <= io_enq_uops_0_pc_lob;	// rob.scala:310:28
      rob_uop_9_pdst <= io_enq_uops_0_pdst;	// rob.scala:310:28
      rob_uop_9_stale_pdst <= io_enq_uops_0_stale_pdst;	// rob.scala:310:28
      rob_uop_9_is_fencei <= io_enq_uops_0_is_fencei;	// rob.scala:310:28
      rob_uop_9_uses_ldq <= io_enq_uops_0_uses_ldq;	// rob.scala:310:28
      rob_uop_9_uses_stq <= io_enq_uops_0_uses_stq;	// rob.scala:310:28
      rob_uop_9_is_sys_pc2epc <= io_enq_uops_0_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_9_flush_on_commit <= io_enq_uops_0_flush_on_commit;	// rob.scala:310:28
      rob_uop_9_ldst <= io_enq_uops_0_ldst;	// rob.scala:310:28
      rob_uop_9_ldst_val <= io_enq_uops_0_ldst_val;	// rob.scala:310:28
      rob_uop_9_dst_rtype <= io_enq_uops_0_dst_rtype;	// rob.scala:310:28
      rob_uop_9_fp_val <= io_enq_uops_0_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_862) | ~rob_val_9) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_82)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_9_br_mask <= io_enq_uops_0_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_9_br_mask <= rob_uop_9_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_84) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_10_uopc <= io_enq_uops_0_uopc;	// rob.scala:310:28
      rob_uop_10_is_rvc <= io_enq_uops_0_is_rvc;	// rob.scala:310:28
      rob_uop_10_ftq_idx <= io_enq_uops_0_ftq_idx;	// rob.scala:310:28
      rob_uop_10_edge_inst <= io_enq_uops_0_edge_inst;	// rob.scala:310:28
      rob_uop_10_pc_lob <= io_enq_uops_0_pc_lob;	// rob.scala:310:28
      rob_uop_10_pdst <= io_enq_uops_0_pdst;	// rob.scala:310:28
      rob_uop_10_stale_pdst <= io_enq_uops_0_stale_pdst;	// rob.scala:310:28
      rob_uop_10_is_fencei <= io_enq_uops_0_is_fencei;	// rob.scala:310:28
      rob_uop_10_uses_ldq <= io_enq_uops_0_uses_ldq;	// rob.scala:310:28
      rob_uop_10_uses_stq <= io_enq_uops_0_uses_stq;	// rob.scala:310:28
      rob_uop_10_is_sys_pc2epc <= io_enq_uops_0_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_10_flush_on_commit <= io_enq_uops_0_flush_on_commit;	// rob.scala:310:28
      rob_uop_10_ldst <= io_enq_uops_0_ldst;	// rob.scala:310:28
      rob_uop_10_ldst_val <= io_enq_uops_0_ldst_val;	// rob.scala:310:28
      rob_uop_10_dst_rtype <= io_enq_uops_0_dst_rtype;	// rob.scala:310:28
      rob_uop_10_fp_val <= io_enq_uops_0_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_863) | ~rob_val_10) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_84)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_10_br_mask <= io_enq_uops_0_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_10_br_mask <= rob_uop_10_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_86) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_11_uopc <= io_enq_uops_0_uopc;	// rob.scala:310:28
      rob_uop_11_is_rvc <= io_enq_uops_0_is_rvc;	// rob.scala:310:28
      rob_uop_11_ftq_idx <= io_enq_uops_0_ftq_idx;	// rob.scala:310:28
      rob_uop_11_edge_inst <= io_enq_uops_0_edge_inst;	// rob.scala:310:28
      rob_uop_11_pc_lob <= io_enq_uops_0_pc_lob;	// rob.scala:310:28
      rob_uop_11_pdst <= io_enq_uops_0_pdst;	// rob.scala:310:28
      rob_uop_11_stale_pdst <= io_enq_uops_0_stale_pdst;	// rob.scala:310:28
      rob_uop_11_is_fencei <= io_enq_uops_0_is_fencei;	// rob.scala:310:28
      rob_uop_11_uses_ldq <= io_enq_uops_0_uses_ldq;	// rob.scala:310:28
      rob_uop_11_uses_stq <= io_enq_uops_0_uses_stq;	// rob.scala:310:28
      rob_uop_11_is_sys_pc2epc <= io_enq_uops_0_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_11_flush_on_commit <= io_enq_uops_0_flush_on_commit;	// rob.scala:310:28
      rob_uop_11_ldst <= io_enq_uops_0_ldst;	// rob.scala:310:28
      rob_uop_11_ldst_val <= io_enq_uops_0_ldst_val;	// rob.scala:310:28
      rob_uop_11_dst_rtype <= io_enq_uops_0_dst_rtype;	// rob.scala:310:28
      rob_uop_11_fp_val <= io_enq_uops_0_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_864) | ~rob_val_11) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_86)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_11_br_mask <= io_enq_uops_0_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_11_br_mask <= rob_uop_11_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_88) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_12_uopc <= io_enq_uops_0_uopc;	// rob.scala:310:28
      rob_uop_12_is_rvc <= io_enq_uops_0_is_rvc;	// rob.scala:310:28
      rob_uop_12_ftq_idx <= io_enq_uops_0_ftq_idx;	// rob.scala:310:28
      rob_uop_12_edge_inst <= io_enq_uops_0_edge_inst;	// rob.scala:310:28
      rob_uop_12_pc_lob <= io_enq_uops_0_pc_lob;	// rob.scala:310:28
      rob_uop_12_pdst <= io_enq_uops_0_pdst;	// rob.scala:310:28
      rob_uop_12_stale_pdst <= io_enq_uops_0_stale_pdst;	// rob.scala:310:28
      rob_uop_12_is_fencei <= io_enq_uops_0_is_fencei;	// rob.scala:310:28
      rob_uop_12_uses_ldq <= io_enq_uops_0_uses_ldq;	// rob.scala:310:28
      rob_uop_12_uses_stq <= io_enq_uops_0_uses_stq;	// rob.scala:310:28
      rob_uop_12_is_sys_pc2epc <= io_enq_uops_0_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_12_flush_on_commit <= io_enq_uops_0_flush_on_commit;	// rob.scala:310:28
      rob_uop_12_ldst <= io_enq_uops_0_ldst;	// rob.scala:310:28
      rob_uop_12_ldst_val <= io_enq_uops_0_ldst_val;	// rob.scala:310:28
      rob_uop_12_dst_rtype <= io_enq_uops_0_dst_rtype;	// rob.scala:310:28
      rob_uop_12_fp_val <= io_enq_uops_0_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_865) | ~rob_val_12) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_88)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_12_br_mask <= io_enq_uops_0_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_12_br_mask <= rob_uop_12_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_90) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_13_uopc <= io_enq_uops_0_uopc;	// rob.scala:310:28
      rob_uop_13_is_rvc <= io_enq_uops_0_is_rvc;	// rob.scala:310:28
      rob_uop_13_ftq_idx <= io_enq_uops_0_ftq_idx;	// rob.scala:310:28
      rob_uop_13_edge_inst <= io_enq_uops_0_edge_inst;	// rob.scala:310:28
      rob_uop_13_pc_lob <= io_enq_uops_0_pc_lob;	// rob.scala:310:28
      rob_uop_13_pdst <= io_enq_uops_0_pdst;	// rob.scala:310:28
      rob_uop_13_stale_pdst <= io_enq_uops_0_stale_pdst;	// rob.scala:310:28
      rob_uop_13_is_fencei <= io_enq_uops_0_is_fencei;	// rob.scala:310:28
      rob_uop_13_uses_ldq <= io_enq_uops_0_uses_ldq;	// rob.scala:310:28
      rob_uop_13_uses_stq <= io_enq_uops_0_uses_stq;	// rob.scala:310:28
      rob_uop_13_is_sys_pc2epc <= io_enq_uops_0_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_13_flush_on_commit <= io_enq_uops_0_flush_on_commit;	// rob.scala:310:28
      rob_uop_13_ldst <= io_enq_uops_0_ldst;	// rob.scala:310:28
      rob_uop_13_ldst_val <= io_enq_uops_0_ldst_val;	// rob.scala:310:28
      rob_uop_13_dst_rtype <= io_enq_uops_0_dst_rtype;	// rob.scala:310:28
      rob_uop_13_fp_val <= io_enq_uops_0_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_866) | ~rob_val_13) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_90)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_13_br_mask <= io_enq_uops_0_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_13_br_mask <= rob_uop_13_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_92) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_14_uopc <= io_enq_uops_0_uopc;	// rob.scala:310:28
      rob_uop_14_is_rvc <= io_enq_uops_0_is_rvc;	// rob.scala:310:28
      rob_uop_14_ftq_idx <= io_enq_uops_0_ftq_idx;	// rob.scala:310:28
      rob_uop_14_edge_inst <= io_enq_uops_0_edge_inst;	// rob.scala:310:28
      rob_uop_14_pc_lob <= io_enq_uops_0_pc_lob;	// rob.scala:310:28
      rob_uop_14_pdst <= io_enq_uops_0_pdst;	// rob.scala:310:28
      rob_uop_14_stale_pdst <= io_enq_uops_0_stale_pdst;	// rob.scala:310:28
      rob_uop_14_is_fencei <= io_enq_uops_0_is_fencei;	// rob.scala:310:28
      rob_uop_14_uses_ldq <= io_enq_uops_0_uses_ldq;	// rob.scala:310:28
      rob_uop_14_uses_stq <= io_enq_uops_0_uses_stq;	// rob.scala:310:28
      rob_uop_14_is_sys_pc2epc <= io_enq_uops_0_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_14_flush_on_commit <= io_enq_uops_0_flush_on_commit;	// rob.scala:310:28
      rob_uop_14_ldst <= io_enq_uops_0_ldst;	// rob.scala:310:28
      rob_uop_14_ldst_val <= io_enq_uops_0_ldst_val;	// rob.scala:310:28
      rob_uop_14_dst_rtype <= io_enq_uops_0_dst_rtype;	// rob.scala:310:28
      rob_uop_14_fp_val <= io_enq_uops_0_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_867) | ~rob_val_14) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_92)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_14_br_mask <= io_enq_uops_0_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_14_br_mask <= rob_uop_14_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_94) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_15_uopc <= io_enq_uops_0_uopc;	// rob.scala:310:28
      rob_uop_15_is_rvc <= io_enq_uops_0_is_rvc;	// rob.scala:310:28
      rob_uop_15_ftq_idx <= io_enq_uops_0_ftq_idx;	// rob.scala:310:28
      rob_uop_15_edge_inst <= io_enq_uops_0_edge_inst;	// rob.scala:310:28
      rob_uop_15_pc_lob <= io_enq_uops_0_pc_lob;	// rob.scala:310:28
      rob_uop_15_pdst <= io_enq_uops_0_pdst;	// rob.scala:310:28
      rob_uop_15_stale_pdst <= io_enq_uops_0_stale_pdst;	// rob.scala:310:28
      rob_uop_15_is_fencei <= io_enq_uops_0_is_fencei;	// rob.scala:310:28
      rob_uop_15_uses_ldq <= io_enq_uops_0_uses_ldq;	// rob.scala:310:28
      rob_uop_15_uses_stq <= io_enq_uops_0_uses_stq;	// rob.scala:310:28
      rob_uop_15_is_sys_pc2epc <= io_enq_uops_0_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_15_flush_on_commit <= io_enq_uops_0_flush_on_commit;	// rob.scala:310:28
      rob_uop_15_ldst <= io_enq_uops_0_ldst;	// rob.scala:310:28
      rob_uop_15_ldst_val <= io_enq_uops_0_ldst_val;	// rob.scala:310:28
      rob_uop_15_dst_rtype <= io_enq_uops_0_dst_rtype;	// rob.scala:310:28
      rob_uop_15_fp_val <= io_enq_uops_0_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_868) | ~rob_val_15) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_94)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_15_br_mask <= io_enq_uops_0_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_15_br_mask <= rob_uop_15_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_96) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_16_uopc <= io_enq_uops_0_uopc;	// rob.scala:310:28
      rob_uop_16_is_rvc <= io_enq_uops_0_is_rvc;	// rob.scala:310:28
      rob_uop_16_ftq_idx <= io_enq_uops_0_ftq_idx;	// rob.scala:310:28
      rob_uop_16_edge_inst <= io_enq_uops_0_edge_inst;	// rob.scala:310:28
      rob_uop_16_pc_lob <= io_enq_uops_0_pc_lob;	// rob.scala:310:28
      rob_uop_16_pdst <= io_enq_uops_0_pdst;	// rob.scala:310:28
      rob_uop_16_stale_pdst <= io_enq_uops_0_stale_pdst;	// rob.scala:310:28
      rob_uop_16_is_fencei <= io_enq_uops_0_is_fencei;	// rob.scala:310:28
      rob_uop_16_uses_ldq <= io_enq_uops_0_uses_ldq;	// rob.scala:310:28
      rob_uop_16_uses_stq <= io_enq_uops_0_uses_stq;	// rob.scala:310:28
      rob_uop_16_is_sys_pc2epc <= io_enq_uops_0_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_16_flush_on_commit <= io_enq_uops_0_flush_on_commit;	// rob.scala:310:28
      rob_uop_16_ldst <= io_enq_uops_0_ldst;	// rob.scala:310:28
      rob_uop_16_ldst_val <= io_enq_uops_0_ldst_val;	// rob.scala:310:28
      rob_uop_16_dst_rtype <= io_enq_uops_0_dst_rtype;	// rob.scala:310:28
      rob_uop_16_fp_val <= io_enq_uops_0_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_869) | ~rob_val_16) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_96)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_16_br_mask <= io_enq_uops_0_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_16_br_mask <= rob_uop_16_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_98) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_17_uopc <= io_enq_uops_0_uopc;	// rob.scala:310:28
      rob_uop_17_is_rvc <= io_enq_uops_0_is_rvc;	// rob.scala:310:28
      rob_uop_17_ftq_idx <= io_enq_uops_0_ftq_idx;	// rob.scala:310:28
      rob_uop_17_edge_inst <= io_enq_uops_0_edge_inst;	// rob.scala:310:28
      rob_uop_17_pc_lob <= io_enq_uops_0_pc_lob;	// rob.scala:310:28
      rob_uop_17_pdst <= io_enq_uops_0_pdst;	// rob.scala:310:28
      rob_uop_17_stale_pdst <= io_enq_uops_0_stale_pdst;	// rob.scala:310:28
      rob_uop_17_is_fencei <= io_enq_uops_0_is_fencei;	// rob.scala:310:28
      rob_uop_17_uses_ldq <= io_enq_uops_0_uses_ldq;	// rob.scala:310:28
      rob_uop_17_uses_stq <= io_enq_uops_0_uses_stq;	// rob.scala:310:28
      rob_uop_17_is_sys_pc2epc <= io_enq_uops_0_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_17_flush_on_commit <= io_enq_uops_0_flush_on_commit;	// rob.scala:310:28
      rob_uop_17_ldst <= io_enq_uops_0_ldst;	// rob.scala:310:28
      rob_uop_17_ldst_val <= io_enq_uops_0_ldst_val;	// rob.scala:310:28
      rob_uop_17_dst_rtype <= io_enq_uops_0_dst_rtype;	// rob.scala:310:28
      rob_uop_17_fp_val <= io_enq_uops_0_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_870) | ~rob_val_17) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_98)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_17_br_mask <= io_enq_uops_0_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_17_br_mask <= rob_uop_17_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_100) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_18_uopc <= io_enq_uops_0_uopc;	// rob.scala:310:28
      rob_uop_18_is_rvc <= io_enq_uops_0_is_rvc;	// rob.scala:310:28
      rob_uop_18_ftq_idx <= io_enq_uops_0_ftq_idx;	// rob.scala:310:28
      rob_uop_18_edge_inst <= io_enq_uops_0_edge_inst;	// rob.scala:310:28
      rob_uop_18_pc_lob <= io_enq_uops_0_pc_lob;	// rob.scala:310:28
      rob_uop_18_pdst <= io_enq_uops_0_pdst;	// rob.scala:310:28
      rob_uop_18_stale_pdst <= io_enq_uops_0_stale_pdst;	// rob.scala:310:28
      rob_uop_18_is_fencei <= io_enq_uops_0_is_fencei;	// rob.scala:310:28
      rob_uop_18_uses_ldq <= io_enq_uops_0_uses_ldq;	// rob.scala:310:28
      rob_uop_18_uses_stq <= io_enq_uops_0_uses_stq;	// rob.scala:310:28
      rob_uop_18_is_sys_pc2epc <= io_enq_uops_0_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_18_flush_on_commit <= io_enq_uops_0_flush_on_commit;	// rob.scala:310:28
      rob_uop_18_ldst <= io_enq_uops_0_ldst;	// rob.scala:310:28
      rob_uop_18_ldst_val <= io_enq_uops_0_ldst_val;	// rob.scala:310:28
      rob_uop_18_dst_rtype <= io_enq_uops_0_dst_rtype;	// rob.scala:310:28
      rob_uop_18_fp_val <= io_enq_uops_0_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_871) | ~rob_val_18) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_100)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_18_br_mask <= io_enq_uops_0_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_18_br_mask <= rob_uop_18_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_102) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_19_uopc <= io_enq_uops_0_uopc;	// rob.scala:310:28
      rob_uop_19_is_rvc <= io_enq_uops_0_is_rvc;	// rob.scala:310:28
      rob_uop_19_ftq_idx <= io_enq_uops_0_ftq_idx;	// rob.scala:310:28
      rob_uop_19_edge_inst <= io_enq_uops_0_edge_inst;	// rob.scala:310:28
      rob_uop_19_pc_lob <= io_enq_uops_0_pc_lob;	// rob.scala:310:28
      rob_uop_19_pdst <= io_enq_uops_0_pdst;	// rob.scala:310:28
      rob_uop_19_stale_pdst <= io_enq_uops_0_stale_pdst;	// rob.scala:310:28
      rob_uop_19_is_fencei <= io_enq_uops_0_is_fencei;	// rob.scala:310:28
      rob_uop_19_uses_ldq <= io_enq_uops_0_uses_ldq;	// rob.scala:310:28
      rob_uop_19_uses_stq <= io_enq_uops_0_uses_stq;	// rob.scala:310:28
      rob_uop_19_is_sys_pc2epc <= io_enq_uops_0_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_19_flush_on_commit <= io_enq_uops_0_flush_on_commit;	// rob.scala:310:28
      rob_uop_19_ldst <= io_enq_uops_0_ldst;	// rob.scala:310:28
      rob_uop_19_ldst_val <= io_enq_uops_0_ldst_val;	// rob.scala:310:28
      rob_uop_19_dst_rtype <= io_enq_uops_0_dst_rtype;	// rob.scala:310:28
      rob_uop_19_fp_val <= io_enq_uops_0_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_872) | ~rob_val_19) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_102)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_19_br_mask <= io_enq_uops_0_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_19_br_mask <= rob_uop_19_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_104) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_20_uopc <= io_enq_uops_0_uopc;	// rob.scala:310:28
      rob_uop_20_is_rvc <= io_enq_uops_0_is_rvc;	// rob.scala:310:28
      rob_uop_20_ftq_idx <= io_enq_uops_0_ftq_idx;	// rob.scala:310:28
      rob_uop_20_edge_inst <= io_enq_uops_0_edge_inst;	// rob.scala:310:28
      rob_uop_20_pc_lob <= io_enq_uops_0_pc_lob;	// rob.scala:310:28
      rob_uop_20_pdst <= io_enq_uops_0_pdst;	// rob.scala:310:28
      rob_uop_20_stale_pdst <= io_enq_uops_0_stale_pdst;	// rob.scala:310:28
      rob_uop_20_is_fencei <= io_enq_uops_0_is_fencei;	// rob.scala:310:28
      rob_uop_20_uses_ldq <= io_enq_uops_0_uses_ldq;	// rob.scala:310:28
      rob_uop_20_uses_stq <= io_enq_uops_0_uses_stq;	// rob.scala:310:28
      rob_uop_20_is_sys_pc2epc <= io_enq_uops_0_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_20_flush_on_commit <= io_enq_uops_0_flush_on_commit;	// rob.scala:310:28
      rob_uop_20_ldst <= io_enq_uops_0_ldst;	// rob.scala:310:28
      rob_uop_20_ldst_val <= io_enq_uops_0_ldst_val;	// rob.scala:310:28
      rob_uop_20_dst_rtype <= io_enq_uops_0_dst_rtype;	// rob.scala:310:28
      rob_uop_20_fp_val <= io_enq_uops_0_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_873) | ~rob_val_20) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_104)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_20_br_mask <= io_enq_uops_0_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_20_br_mask <= rob_uop_20_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_106) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_21_uopc <= io_enq_uops_0_uopc;	// rob.scala:310:28
      rob_uop_21_is_rvc <= io_enq_uops_0_is_rvc;	// rob.scala:310:28
      rob_uop_21_ftq_idx <= io_enq_uops_0_ftq_idx;	// rob.scala:310:28
      rob_uop_21_edge_inst <= io_enq_uops_0_edge_inst;	// rob.scala:310:28
      rob_uop_21_pc_lob <= io_enq_uops_0_pc_lob;	// rob.scala:310:28
      rob_uop_21_pdst <= io_enq_uops_0_pdst;	// rob.scala:310:28
      rob_uop_21_stale_pdst <= io_enq_uops_0_stale_pdst;	// rob.scala:310:28
      rob_uop_21_is_fencei <= io_enq_uops_0_is_fencei;	// rob.scala:310:28
      rob_uop_21_uses_ldq <= io_enq_uops_0_uses_ldq;	// rob.scala:310:28
      rob_uop_21_uses_stq <= io_enq_uops_0_uses_stq;	// rob.scala:310:28
      rob_uop_21_is_sys_pc2epc <= io_enq_uops_0_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_21_flush_on_commit <= io_enq_uops_0_flush_on_commit;	// rob.scala:310:28
      rob_uop_21_ldst <= io_enq_uops_0_ldst;	// rob.scala:310:28
      rob_uop_21_ldst_val <= io_enq_uops_0_ldst_val;	// rob.scala:310:28
      rob_uop_21_dst_rtype <= io_enq_uops_0_dst_rtype;	// rob.scala:310:28
      rob_uop_21_fp_val <= io_enq_uops_0_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_874) | ~rob_val_21) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_106)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_21_br_mask <= io_enq_uops_0_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_21_br_mask <= rob_uop_21_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_108) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_22_uopc <= io_enq_uops_0_uopc;	// rob.scala:310:28
      rob_uop_22_is_rvc <= io_enq_uops_0_is_rvc;	// rob.scala:310:28
      rob_uop_22_ftq_idx <= io_enq_uops_0_ftq_idx;	// rob.scala:310:28
      rob_uop_22_edge_inst <= io_enq_uops_0_edge_inst;	// rob.scala:310:28
      rob_uop_22_pc_lob <= io_enq_uops_0_pc_lob;	// rob.scala:310:28
      rob_uop_22_pdst <= io_enq_uops_0_pdst;	// rob.scala:310:28
      rob_uop_22_stale_pdst <= io_enq_uops_0_stale_pdst;	// rob.scala:310:28
      rob_uop_22_is_fencei <= io_enq_uops_0_is_fencei;	// rob.scala:310:28
      rob_uop_22_uses_ldq <= io_enq_uops_0_uses_ldq;	// rob.scala:310:28
      rob_uop_22_uses_stq <= io_enq_uops_0_uses_stq;	// rob.scala:310:28
      rob_uop_22_is_sys_pc2epc <= io_enq_uops_0_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_22_flush_on_commit <= io_enq_uops_0_flush_on_commit;	// rob.scala:310:28
      rob_uop_22_ldst <= io_enq_uops_0_ldst;	// rob.scala:310:28
      rob_uop_22_ldst_val <= io_enq_uops_0_ldst_val;	// rob.scala:310:28
      rob_uop_22_dst_rtype <= io_enq_uops_0_dst_rtype;	// rob.scala:310:28
      rob_uop_22_fp_val <= io_enq_uops_0_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_875) | ~rob_val_22) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_108)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_22_br_mask <= io_enq_uops_0_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_22_br_mask <= rob_uop_22_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_110) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_23_uopc <= io_enq_uops_0_uopc;	// rob.scala:310:28
      rob_uop_23_is_rvc <= io_enq_uops_0_is_rvc;	// rob.scala:310:28
      rob_uop_23_ftq_idx <= io_enq_uops_0_ftq_idx;	// rob.scala:310:28
      rob_uop_23_edge_inst <= io_enq_uops_0_edge_inst;	// rob.scala:310:28
      rob_uop_23_pc_lob <= io_enq_uops_0_pc_lob;	// rob.scala:310:28
      rob_uop_23_pdst <= io_enq_uops_0_pdst;	// rob.scala:310:28
      rob_uop_23_stale_pdst <= io_enq_uops_0_stale_pdst;	// rob.scala:310:28
      rob_uop_23_is_fencei <= io_enq_uops_0_is_fencei;	// rob.scala:310:28
      rob_uop_23_uses_ldq <= io_enq_uops_0_uses_ldq;	// rob.scala:310:28
      rob_uop_23_uses_stq <= io_enq_uops_0_uses_stq;	// rob.scala:310:28
      rob_uop_23_is_sys_pc2epc <= io_enq_uops_0_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_23_flush_on_commit <= io_enq_uops_0_flush_on_commit;	// rob.scala:310:28
      rob_uop_23_ldst <= io_enq_uops_0_ldst;	// rob.scala:310:28
      rob_uop_23_ldst_val <= io_enq_uops_0_ldst_val;	// rob.scala:310:28
      rob_uop_23_dst_rtype <= io_enq_uops_0_dst_rtype;	// rob.scala:310:28
      rob_uop_23_fp_val <= io_enq_uops_0_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_876) | ~rob_val_23) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_110)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_23_br_mask <= io_enq_uops_0_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_23_br_mask <= rob_uop_23_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_112) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_24_uopc <= io_enq_uops_0_uopc;	// rob.scala:310:28
      rob_uop_24_is_rvc <= io_enq_uops_0_is_rvc;	// rob.scala:310:28
      rob_uop_24_ftq_idx <= io_enq_uops_0_ftq_idx;	// rob.scala:310:28
      rob_uop_24_edge_inst <= io_enq_uops_0_edge_inst;	// rob.scala:310:28
      rob_uop_24_pc_lob <= io_enq_uops_0_pc_lob;	// rob.scala:310:28
      rob_uop_24_pdst <= io_enq_uops_0_pdst;	// rob.scala:310:28
      rob_uop_24_stale_pdst <= io_enq_uops_0_stale_pdst;	// rob.scala:310:28
      rob_uop_24_is_fencei <= io_enq_uops_0_is_fencei;	// rob.scala:310:28
      rob_uop_24_uses_ldq <= io_enq_uops_0_uses_ldq;	// rob.scala:310:28
      rob_uop_24_uses_stq <= io_enq_uops_0_uses_stq;	// rob.scala:310:28
      rob_uop_24_is_sys_pc2epc <= io_enq_uops_0_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_24_flush_on_commit <= io_enq_uops_0_flush_on_commit;	// rob.scala:310:28
      rob_uop_24_ldst <= io_enq_uops_0_ldst;	// rob.scala:310:28
      rob_uop_24_ldst_val <= io_enq_uops_0_ldst_val;	// rob.scala:310:28
      rob_uop_24_dst_rtype <= io_enq_uops_0_dst_rtype;	// rob.scala:310:28
      rob_uop_24_fp_val <= io_enq_uops_0_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_877) | ~rob_val_24) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_112)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_24_br_mask <= io_enq_uops_0_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_24_br_mask <= rob_uop_24_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_114) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_25_uopc <= io_enq_uops_0_uopc;	// rob.scala:310:28
      rob_uop_25_is_rvc <= io_enq_uops_0_is_rvc;	// rob.scala:310:28
      rob_uop_25_ftq_idx <= io_enq_uops_0_ftq_idx;	// rob.scala:310:28
      rob_uop_25_edge_inst <= io_enq_uops_0_edge_inst;	// rob.scala:310:28
      rob_uop_25_pc_lob <= io_enq_uops_0_pc_lob;	// rob.scala:310:28
      rob_uop_25_pdst <= io_enq_uops_0_pdst;	// rob.scala:310:28
      rob_uop_25_stale_pdst <= io_enq_uops_0_stale_pdst;	// rob.scala:310:28
      rob_uop_25_is_fencei <= io_enq_uops_0_is_fencei;	// rob.scala:310:28
      rob_uop_25_uses_ldq <= io_enq_uops_0_uses_ldq;	// rob.scala:310:28
      rob_uop_25_uses_stq <= io_enq_uops_0_uses_stq;	// rob.scala:310:28
      rob_uop_25_is_sys_pc2epc <= io_enq_uops_0_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_25_flush_on_commit <= io_enq_uops_0_flush_on_commit;	// rob.scala:310:28
      rob_uop_25_ldst <= io_enq_uops_0_ldst;	// rob.scala:310:28
      rob_uop_25_ldst_val <= io_enq_uops_0_ldst_val;	// rob.scala:310:28
      rob_uop_25_dst_rtype <= io_enq_uops_0_dst_rtype;	// rob.scala:310:28
      rob_uop_25_fp_val <= io_enq_uops_0_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_878) | ~rob_val_25) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_114)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_25_br_mask <= io_enq_uops_0_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_25_br_mask <= rob_uop_25_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_116) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_26_uopc <= io_enq_uops_0_uopc;	// rob.scala:310:28
      rob_uop_26_is_rvc <= io_enq_uops_0_is_rvc;	// rob.scala:310:28
      rob_uop_26_ftq_idx <= io_enq_uops_0_ftq_idx;	// rob.scala:310:28
      rob_uop_26_edge_inst <= io_enq_uops_0_edge_inst;	// rob.scala:310:28
      rob_uop_26_pc_lob <= io_enq_uops_0_pc_lob;	// rob.scala:310:28
      rob_uop_26_pdst <= io_enq_uops_0_pdst;	// rob.scala:310:28
      rob_uop_26_stale_pdst <= io_enq_uops_0_stale_pdst;	// rob.scala:310:28
      rob_uop_26_is_fencei <= io_enq_uops_0_is_fencei;	// rob.scala:310:28
      rob_uop_26_uses_ldq <= io_enq_uops_0_uses_ldq;	// rob.scala:310:28
      rob_uop_26_uses_stq <= io_enq_uops_0_uses_stq;	// rob.scala:310:28
      rob_uop_26_is_sys_pc2epc <= io_enq_uops_0_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_26_flush_on_commit <= io_enq_uops_0_flush_on_commit;	// rob.scala:310:28
      rob_uop_26_ldst <= io_enq_uops_0_ldst;	// rob.scala:310:28
      rob_uop_26_ldst_val <= io_enq_uops_0_ldst_val;	// rob.scala:310:28
      rob_uop_26_dst_rtype <= io_enq_uops_0_dst_rtype;	// rob.scala:310:28
      rob_uop_26_fp_val <= io_enq_uops_0_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_879) | ~rob_val_26) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_116)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_26_br_mask <= io_enq_uops_0_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_26_br_mask <= rob_uop_26_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_118) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_27_uopc <= io_enq_uops_0_uopc;	// rob.scala:310:28
      rob_uop_27_is_rvc <= io_enq_uops_0_is_rvc;	// rob.scala:310:28
      rob_uop_27_ftq_idx <= io_enq_uops_0_ftq_idx;	// rob.scala:310:28
      rob_uop_27_edge_inst <= io_enq_uops_0_edge_inst;	// rob.scala:310:28
      rob_uop_27_pc_lob <= io_enq_uops_0_pc_lob;	// rob.scala:310:28
      rob_uop_27_pdst <= io_enq_uops_0_pdst;	// rob.scala:310:28
      rob_uop_27_stale_pdst <= io_enq_uops_0_stale_pdst;	// rob.scala:310:28
      rob_uop_27_is_fencei <= io_enq_uops_0_is_fencei;	// rob.scala:310:28
      rob_uop_27_uses_ldq <= io_enq_uops_0_uses_ldq;	// rob.scala:310:28
      rob_uop_27_uses_stq <= io_enq_uops_0_uses_stq;	// rob.scala:310:28
      rob_uop_27_is_sys_pc2epc <= io_enq_uops_0_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_27_flush_on_commit <= io_enq_uops_0_flush_on_commit;	// rob.scala:310:28
      rob_uop_27_ldst <= io_enq_uops_0_ldst;	// rob.scala:310:28
      rob_uop_27_ldst_val <= io_enq_uops_0_ldst_val;	// rob.scala:310:28
      rob_uop_27_dst_rtype <= io_enq_uops_0_dst_rtype;	// rob.scala:310:28
      rob_uop_27_fp_val <= io_enq_uops_0_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_880) | ~rob_val_27) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_118)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_27_br_mask <= io_enq_uops_0_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_27_br_mask <= rob_uop_27_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_120) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_28_uopc <= io_enq_uops_0_uopc;	// rob.scala:310:28
      rob_uop_28_is_rvc <= io_enq_uops_0_is_rvc;	// rob.scala:310:28
      rob_uop_28_ftq_idx <= io_enq_uops_0_ftq_idx;	// rob.scala:310:28
      rob_uop_28_edge_inst <= io_enq_uops_0_edge_inst;	// rob.scala:310:28
      rob_uop_28_pc_lob <= io_enq_uops_0_pc_lob;	// rob.scala:310:28
      rob_uop_28_pdst <= io_enq_uops_0_pdst;	// rob.scala:310:28
      rob_uop_28_stale_pdst <= io_enq_uops_0_stale_pdst;	// rob.scala:310:28
      rob_uop_28_is_fencei <= io_enq_uops_0_is_fencei;	// rob.scala:310:28
      rob_uop_28_uses_ldq <= io_enq_uops_0_uses_ldq;	// rob.scala:310:28
      rob_uop_28_uses_stq <= io_enq_uops_0_uses_stq;	// rob.scala:310:28
      rob_uop_28_is_sys_pc2epc <= io_enq_uops_0_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_28_flush_on_commit <= io_enq_uops_0_flush_on_commit;	// rob.scala:310:28
      rob_uop_28_ldst <= io_enq_uops_0_ldst;	// rob.scala:310:28
      rob_uop_28_ldst_val <= io_enq_uops_0_ldst_val;	// rob.scala:310:28
      rob_uop_28_dst_rtype <= io_enq_uops_0_dst_rtype;	// rob.scala:310:28
      rob_uop_28_fp_val <= io_enq_uops_0_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_881) | ~rob_val_28) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_120)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_28_br_mask <= io_enq_uops_0_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_28_br_mask <= rob_uop_28_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_122) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_29_uopc <= io_enq_uops_0_uopc;	// rob.scala:310:28
      rob_uop_29_is_rvc <= io_enq_uops_0_is_rvc;	// rob.scala:310:28
      rob_uop_29_ftq_idx <= io_enq_uops_0_ftq_idx;	// rob.scala:310:28
      rob_uop_29_edge_inst <= io_enq_uops_0_edge_inst;	// rob.scala:310:28
      rob_uop_29_pc_lob <= io_enq_uops_0_pc_lob;	// rob.scala:310:28
      rob_uop_29_pdst <= io_enq_uops_0_pdst;	// rob.scala:310:28
      rob_uop_29_stale_pdst <= io_enq_uops_0_stale_pdst;	// rob.scala:310:28
      rob_uop_29_is_fencei <= io_enq_uops_0_is_fencei;	// rob.scala:310:28
      rob_uop_29_uses_ldq <= io_enq_uops_0_uses_ldq;	// rob.scala:310:28
      rob_uop_29_uses_stq <= io_enq_uops_0_uses_stq;	// rob.scala:310:28
      rob_uop_29_is_sys_pc2epc <= io_enq_uops_0_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_29_flush_on_commit <= io_enq_uops_0_flush_on_commit;	// rob.scala:310:28
      rob_uop_29_ldst <= io_enq_uops_0_ldst;	// rob.scala:310:28
      rob_uop_29_ldst_val <= io_enq_uops_0_ldst_val;	// rob.scala:310:28
      rob_uop_29_dst_rtype <= io_enq_uops_0_dst_rtype;	// rob.scala:310:28
      rob_uop_29_fp_val <= io_enq_uops_0_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_882) | ~rob_val_29) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_122)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_29_br_mask <= io_enq_uops_0_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_29_br_mask <= rob_uop_29_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_124) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_30_uopc <= io_enq_uops_0_uopc;	// rob.scala:310:28
      rob_uop_30_is_rvc <= io_enq_uops_0_is_rvc;	// rob.scala:310:28
      rob_uop_30_ftq_idx <= io_enq_uops_0_ftq_idx;	// rob.scala:310:28
      rob_uop_30_edge_inst <= io_enq_uops_0_edge_inst;	// rob.scala:310:28
      rob_uop_30_pc_lob <= io_enq_uops_0_pc_lob;	// rob.scala:310:28
      rob_uop_30_pdst <= io_enq_uops_0_pdst;	// rob.scala:310:28
      rob_uop_30_stale_pdst <= io_enq_uops_0_stale_pdst;	// rob.scala:310:28
      rob_uop_30_is_fencei <= io_enq_uops_0_is_fencei;	// rob.scala:310:28
      rob_uop_30_uses_ldq <= io_enq_uops_0_uses_ldq;	// rob.scala:310:28
      rob_uop_30_uses_stq <= io_enq_uops_0_uses_stq;	// rob.scala:310:28
      rob_uop_30_is_sys_pc2epc <= io_enq_uops_0_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_30_flush_on_commit <= io_enq_uops_0_flush_on_commit;	// rob.scala:310:28
      rob_uop_30_ldst <= io_enq_uops_0_ldst;	// rob.scala:310:28
      rob_uop_30_ldst_val <= io_enq_uops_0_ldst_val;	// rob.scala:310:28
      rob_uop_30_dst_rtype <= io_enq_uops_0_dst_rtype;	// rob.scala:310:28
      rob_uop_30_fp_val <= io_enq_uops_0_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_883) | ~rob_val_30) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_124)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_30_br_mask <= io_enq_uops_0_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_30_br_mask <= rob_uop_30_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_125) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_31_uopc <= io_enq_uops_0_uopc;	// rob.scala:310:28
      rob_uop_31_is_rvc <= io_enq_uops_0_is_rvc;	// rob.scala:310:28
      rob_uop_31_ftq_idx <= io_enq_uops_0_ftq_idx;	// rob.scala:310:28
      rob_uop_31_edge_inst <= io_enq_uops_0_edge_inst;	// rob.scala:310:28
      rob_uop_31_pc_lob <= io_enq_uops_0_pc_lob;	// rob.scala:310:28
      rob_uop_31_pdst <= io_enq_uops_0_pdst;	// rob.scala:310:28
      rob_uop_31_stale_pdst <= io_enq_uops_0_stale_pdst;	// rob.scala:310:28
      rob_uop_31_is_fencei <= io_enq_uops_0_is_fencei;	// rob.scala:310:28
      rob_uop_31_uses_ldq <= io_enq_uops_0_uses_ldq;	// rob.scala:310:28
      rob_uop_31_uses_stq <= io_enq_uops_0_uses_stq;	// rob.scala:310:28
      rob_uop_31_is_sys_pc2epc <= io_enq_uops_0_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_31_flush_on_commit <= io_enq_uops_0_flush_on_commit;	// rob.scala:310:28
      rob_uop_31_ldst <= io_enq_uops_0_ldst;	// rob.scala:310:28
      rob_uop_31_ldst_val <= io_enq_uops_0_ldst_val;	// rob.scala:310:28
      rob_uop_31_dst_rtype <= io_enq_uops_0_dst_rtype;	// rob.scala:310:28
      rob_uop_31_fp_val <= io_enq_uops_0_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_884) | ~rob_val_31) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_125)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_31_br_mask <= io_enq_uops_0_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_31_br_mask <= rob_uop_31_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    rob_exception_0 <=
      ~_GEN_791
      & (_GEN_8 & _GEN_759 | (_GEN_64 ? io_enq_uops_0_exception : rob_exception_0));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_1 <=
      ~_GEN_793
      & (_GEN_8 & _GEN_760 | (_GEN_66 ? io_enq_uops_0_exception : rob_exception_1));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_2 <=
      ~_GEN_795
      & (_GEN_8 & _GEN_761 | (_GEN_68 ? io_enq_uops_0_exception : rob_exception_2));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_3 <=
      ~_GEN_797
      & (_GEN_8 & _GEN_762 | (_GEN_70 ? io_enq_uops_0_exception : rob_exception_3));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_4 <=
      ~_GEN_799
      & (_GEN_8 & _GEN_763 | (_GEN_72 ? io_enq_uops_0_exception : rob_exception_4));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_5 <=
      ~_GEN_801
      & (_GEN_8 & _GEN_764 | (_GEN_74 ? io_enq_uops_0_exception : rob_exception_5));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_6 <=
      ~_GEN_803
      & (_GEN_8 & _GEN_765 | (_GEN_76 ? io_enq_uops_0_exception : rob_exception_6));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_7 <=
      ~_GEN_805
      & (_GEN_8 & _GEN_766 | (_GEN_78 ? io_enq_uops_0_exception : rob_exception_7));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_8 <=
      ~_GEN_807
      & (_GEN_8 & _GEN_767 | (_GEN_80 ? io_enq_uops_0_exception : rob_exception_8));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_9 <=
      ~_GEN_809
      & (_GEN_8 & _GEN_768 | (_GEN_82 ? io_enq_uops_0_exception : rob_exception_9));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_10 <=
      ~_GEN_811
      & (_GEN_8 & _GEN_769 | (_GEN_84 ? io_enq_uops_0_exception : rob_exception_10));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_11 <=
      ~_GEN_813
      & (_GEN_8 & _GEN_770 | (_GEN_86 ? io_enq_uops_0_exception : rob_exception_11));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_12 <=
      ~_GEN_815
      & (_GEN_8 & _GEN_771 | (_GEN_88 ? io_enq_uops_0_exception : rob_exception_12));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_13 <=
      ~_GEN_817
      & (_GEN_8 & _GEN_772 | (_GEN_90 ? io_enq_uops_0_exception : rob_exception_13));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_14 <=
      ~_GEN_819
      & (_GEN_8 & _GEN_773 | (_GEN_92 ? io_enq_uops_0_exception : rob_exception_14));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_15 <=
      ~_GEN_821
      & (_GEN_8 & _GEN_774 | (_GEN_94 ? io_enq_uops_0_exception : rob_exception_15));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_16 <=
      ~_GEN_823
      & (_GEN_8 & _GEN_775 | (_GEN_96 ? io_enq_uops_0_exception : rob_exception_16));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_17 <=
      ~_GEN_825
      & (_GEN_8 & _GEN_776 | (_GEN_98 ? io_enq_uops_0_exception : rob_exception_17));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_18 <=
      ~_GEN_827
      & (_GEN_8 & _GEN_777 | (_GEN_100 ? io_enq_uops_0_exception : rob_exception_18));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_19 <=
      ~_GEN_829
      & (_GEN_8 & _GEN_778 | (_GEN_102 ? io_enq_uops_0_exception : rob_exception_19));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_20 <=
      ~_GEN_831
      & (_GEN_8 & _GEN_779 | (_GEN_104 ? io_enq_uops_0_exception : rob_exception_20));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_21 <=
      ~_GEN_833
      & (_GEN_8 & _GEN_780 | (_GEN_106 ? io_enq_uops_0_exception : rob_exception_21));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_22 <=
      ~_GEN_835
      & (_GEN_8 & _GEN_781 | (_GEN_108 ? io_enq_uops_0_exception : rob_exception_22));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_23 <=
      ~_GEN_837
      & (_GEN_8 & _GEN_782 | (_GEN_110 ? io_enq_uops_0_exception : rob_exception_23));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_24 <=
      ~_GEN_839
      & (_GEN_8 & _GEN_783 | (_GEN_112 ? io_enq_uops_0_exception : rob_exception_24));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_25 <=
      ~_GEN_841
      & (_GEN_8 & _GEN_784 | (_GEN_114 ? io_enq_uops_0_exception : rob_exception_25));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_26 <=
      ~_GEN_843
      & (_GEN_8 & _GEN_785 | (_GEN_116 ? io_enq_uops_0_exception : rob_exception_26));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_27 <=
      ~_GEN_845
      & (_GEN_8 & _GEN_786 | (_GEN_118 ? io_enq_uops_0_exception : rob_exception_27));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_28 <=
      ~_GEN_847
      & (_GEN_8 & _GEN_787 | (_GEN_120 ? io_enq_uops_0_exception : rob_exception_28));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_29 <=
      ~_GEN_849
      & (_GEN_8 & _GEN_788 | (_GEN_122 ? io_enq_uops_0_exception : rob_exception_29));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_30 <=
      ~_GEN_851
      & (_GEN_8 & _GEN_789 | (_GEN_124 ? io_enq_uops_0_exception : rob_exception_30));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_31 <=
      ~_GEN_852
      & (_GEN_8 & (&(io_lxcpt_bits_uop_rob_idx[5:1]))
         | (_GEN_125 ? io_enq_uops_0_exception : rob_exception_31));	// rob.scala:268:25, :307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_predicated_0 <=
      ~_GEN_571
      & (_GEN_3 & _GEN_443
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_381 | _GEN_1 & _GEN_253)
             & (_GEN_191 ? io_wb_resps_0_bits_predicated : ~_GEN_64 & rob_predicated_0));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_1 <=
      ~_GEN_573
      & (_GEN_3 & _GEN_446
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_383 | _GEN_1 & _GEN_256)
             & (_GEN_193 ? io_wb_resps_0_bits_predicated : ~_GEN_66 & rob_predicated_1));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_2 <=
      ~_GEN_575
      & (_GEN_3 & _GEN_449
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_385 | _GEN_1 & _GEN_259)
             & (_GEN_195 ? io_wb_resps_0_bits_predicated : ~_GEN_68 & rob_predicated_2));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_3 <=
      ~_GEN_577
      & (_GEN_3 & _GEN_452
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_387 | _GEN_1 & _GEN_262)
             & (_GEN_197 ? io_wb_resps_0_bits_predicated : ~_GEN_70 & rob_predicated_3));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_4 <=
      ~_GEN_579
      & (_GEN_3 & _GEN_455
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_389 | _GEN_1 & _GEN_265)
             & (_GEN_199 ? io_wb_resps_0_bits_predicated : ~_GEN_72 & rob_predicated_4));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_5 <=
      ~_GEN_581
      & (_GEN_3 & _GEN_458
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_391 | _GEN_1 & _GEN_268)
             & (_GEN_201 ? io_wb_resps_0_bits_predicated : ~_GEN_74 & rob_predicated_5));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_6 <=
      ~_GEN_583
      & (_GEN_3 & _GEN_461
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_393 | _GEN_1 & _GEN_271)
             & (_GEN_203 ? io_wb_resps_0_bits_predicated : ~_GEN_76 & rob_predicated_6));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_7 <=
      ~_GEN_585
      & (_GEN_3 & _GEN_464
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_395 | _GEN_1 & _GEN_274)
             & (_GEN_205 ? io_wb_resps_0_bits_predicated : ~_GEN_78 & rob_predicated_7));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_8 <=
      ~_GEN_587
      & (_GEN_3 & _GEN_467
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_397 | _GEN_1 & _GEN_277)
             & (_GEN_207 ? io_wb_resps_0_bits_predicated : ~_GEN_80 & rob_predicated_8));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_9 <=
      ~_GEN_589
      & (_GEN_3 & _GEN_470
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_399 | _GEN_1 & _GEN_280)
             & (_GEN_209 ? io_wb_resps_0_bits_predicated : ~_GEN_82 & rob_predicated_9));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_10 <=
      ~_GEN_591
      & (_GEN_3 & _GEN_473
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_401 | _GEN_1 & _GEN_283)
             & (_GEN_211 ? io_wb_resps_0_bits_predicated : ~_GEN_84 & rob_predicated_10));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_11 <=
      ~_GEN_593
      & (_GEN_3 & _GEN_476
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_403 | _GEN_1 & _GEN_286)
             & (_GEN_213 ? io_wb_resps_0_bits_predicated : ~_GEN_86 & rob_predicated_11));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_12 <=
      ~_GEN_595
      & (_GEN_3 & _GEN_479
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_405 | _GEN_1 & _GEN_289)
             & (_GEN_215 ? io_wb_resps_0_bits_predicated : ~_GEN_88 & rob_predicated_12));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_13 <=
      ~_GEN_597
      & (_GEN_3 & _GEN_482
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_407 | _GEN_1 & _GEN_292)
             & (_GEN_217 ? io_wb_resps_0_bits_predicated : ~_GEN_90 & rob_predicated_13));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_14 <=
      ~_GEN_599
      & (_GEN_3 & _GEN_485
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_409 | _GEN_1 & _GEN_295)
             & (_GEN_219 ? io_wb_resps_0_bits_predicated : ~_GEN_92 & rob_predicated_14));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_15 <=
      ~_GEN_601
      & (_GEN_3 & _GEN_488
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_411 | _GEN_1 & _GEN_298)
             & (_GEN_221 ? io_wb_resps_0_bits_predicated : ~_GEN_94 & rob_predicated_15));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_16 <=
      ~_GEN_603
      & (_GEN_3 & _GEN_491
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_413 | _GEN_1 & _GEN_301)
             & (_GEN_223 ? io_wb_resps_0_bits_predicated : ~_GEN_96 & rob_predicated_16));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_17 <=
      ~_GEN_605
      & (_GEN_3 & _GEN_494
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_415 | _GEN_1 & _GEN_304)
             & (_GEN_225 ? io_wb_resps_0_bits_predicated : ~_GEN_98 & rob_predicated_17));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_18 <=
      ~_GEN_607
      & (_GEN_3 & _GEN_497
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_417 | _GEN_1 & _GEN_307)
             & (_GEN_227
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_100 & rob_predicated_18));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_19 <=
      ~_GEN_609
      & (_GEN_3 & _GEN_500
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_419 | _GEN_1 & _GEN_310)
             & (_GEN_229
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_102 & rob_predicated_19));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_20 <=
      ~_GEN_611
      & (_GEN_3 & _GEN_503
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_421 | _GEN_1 & _GEN_313)
             & (_GEN_231
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_104 & rob_predicated_20));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_21 <=
      ~_GEN_613
      & (_GEN_3 & _GEN_506
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_423 | _GEN_1 & _GEN_316)
             & (_GEN_233
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_106 & rob_predicated_21));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_22 <=
      ~_GEN_615
      & (_GEN_3 & _GEN_509
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_425 | _GEN_1 & _GEN_319)
             & (_GEN_235
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_108 & rob_predicated_22));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_23 <=
      ~_GEN_617
      & (_GEN_3 & _GEN_512
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_427 | _GEN_1 & _GEN_322)
             & (_GEN_237
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_110 & rob_predicated_23));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_24 <=
      ~_GEN_619
      & (_GEN_3 & _GEN_515
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_429 | _GEN_1 & _GEN_325)
             & (_GEN_239
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_112 & rob_predicated_24));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_25 <=
      ~_GEN_621
      & (_GEN_3 & _GEN_518
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_431 | _GEN_1 & _GEN_328)
             & (_GEN_241
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_114 & rob_predicated_25));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_26 <=
      ~_GEN_623
      & (_GEN_3 & _GEN_521
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_433 | _GEN_1 & _GEN_331)
             & (_GEN_243
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_116 & rob_predicated_26));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_27 <=
      ~_GEN_625
      & (_GEN_3 & _GEN_524
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_435 | _GEN_1 & _GEN_334)
             & (_GEN_245
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_118 & rob_predicated_27));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_28 <=
      ~_GEN_627
      & (_GEN_3 & _GEN_527
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_437 | _GEN_1 & _GEN_337)
             & (_GEN_247
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_120 & rob_predicated_28));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_29 <=
      ~_GEN_629
      & (_GEN_3 & _GEN_530
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_439 | _GEN_1 & _GEN_340)
             & (_GEN_249
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_122 & rob_predicated_29));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_30 <=
      ~_GEN_631
      & (_GEN_3 & _GEN_533
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_441 | _GEN_1 & _GEN_343)
             & (_GEN_251
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_124 & rob_predicated_30));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_31 <=
      ~_GEN_632
      & (_GEN_3 & (&(io_wb_resps_3_bits_uop_rob_idx[5:1]))
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_442 | _GEN_1 & (&(io_wb_resps_1_bits_uop_rob_idx[5:1])))
             & (_GEN_252
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_125 & rob_predicated_31));	// rob.scala:268:25, :307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_bsy_1_0 <=
      ~_GEN_1301 & (_GEN_34 ? ~_GEN_1269 & _GEN_1142 : ~_GEN_1237 & _GEN_1142);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_1_1 <=
      ~_GEN_1302 & (_GEN_34 ? ~_GEN_1270 & _GEN_1144 : ~_GEN_1238 & _GEN_1144);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_1_2 <=
      ~_GEN_1303 & (_GEN_34 ? ~_GEN_1271 & _GEN_1146 : ~_GEN_1239 & _GEN_1146);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_1_3 <=
      ~_GEN_1304 & (_GEN_34 ? ~_GEN_1272 & _GEN_1148 : ~_GEN_1240 & _GEN_1148);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_1_4 <=
      ~_GEN_1305 & (_GEN_34 ? ~_GEN_1273 & _GEN_1150 : ~_GEN_1241 & _GEN_1150);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_1_5 <=
      ~_GEN_1306 & (_GEN_34 ? ~_GEN_1274 & _GEN_1152 : ~_GEN_1242 & _GEN_1152);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_1_6 <=
      ~_GEN_1307 & (_GEN_34 ? ~_GEN_1275 & _GEN_1154 : ~_GEN_1243 & _GEN_1154);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_1_7 <=
      ~_GEN_1308 & (_GEN_34 ? ~_GEN_1276 & _GEN_1156 : ~_GEN_1244 & _GEN_1156);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_1_8 <=
      ~_GEN_1309 & (_GEN_34 ? ~_GEN_1277 & _GEN_1158 : ~_GEN_1245 & _GEN_1158);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_1_9 <=
      ~_GEN_1310 & (_GEN_34 ? ~_GEN_1278 & _GEN_1160 : ~_GEN_1246 & _GEN_1160);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_1_10 <=
      ~_GEN_1311 & (_GEN_34 ? ~_GEN_1279 & _GEN_1162 : ~_GEN_1247 & _GEN_1162);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_1_11 <=
      ~_GEN_1312 & (_GEN_34 ? ~_GEN_1280 & _GEN_1164 : ~_GEN_1248 & _GEN_1164);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_1_12 <=
      ~_GEN_1313 & (_GEN_34 ? ~_GEN_1281 & _GEN_1166 : ~_GEN_1249 & _GEN_1166);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_1_13 <=
      ~_GEN_1314 & (_GEN_34 ? ~_GEN_1282 & _GEN_1168 : ~_GEN_1250 & _GEN_1168);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_1_14 <=
      ~_GEN_1315 & (_GEN_34 ? ~_GEN_1283 & _GEN_1170 : ~_GEN_1251 & _GEN_1170);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_1_15 <=
      ~_GEN_1316 & (_GEN_34 ? ~_GEN_1284 & _GEN_1172 : ~_GEN_1252 & _GEN_1172);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_1_16 <=
      ~_GEN_1317 & (_GEN_34 ? ~_GEN_1285 & _GEN_1174 : ~_GEN_1253 & _GEN_1174);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_1_17 <=
      ~_GEN_1318 & (_GEN_34 ? ~_GEN_1286 & _GEN_1176 : ~_GEN_1254 & _GEN_1176);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_1_18 <=
      ~_GEN_1319 & (_GEN_34 ? ~_GEN_1287 & _GEN_1178 : ~_GEN_1255 & _GEN_1178);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_1_19 <=
      ~_GEN_1320 & (_GEN_34 ? ~_GEN_1288 & _GEN_1180 : ~_GEN_1256 & _GEN_1180);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_1_20 <=
      ~_GEN_1321 & (_GEN_34 ? ~_GEN_1289 & _GEN_1182 : ~_GEN_1257 & _GEN_1182);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_1_21 <=
      ~_GEN_1322 & (_GEN_34 ? ~_GEN_1290 & _GEN_1184 : ~_GEN_1258 & _GEN_1184);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_1_22 <=
      ~_GEN_1323 & (_GEN_34 ? ~_GEN_1291 & _GEN_1186 : ~_GEN_1259 & _GEN_1186);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_1_23 <=
      ~_GEN_1324 & (_GEN_34 ? ~_GEN_1292 & _GEN_1188 : ~_GEN_1260 & _GEN_1188);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_1_24 <=
      ~_GEN_1325 & (_GEN_34 ? ~_GEN_1293 & _GEN_1190 : ~_GEN_1261 & _GEN_1190);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_1_25 <=
      ~_GEN_1326 & (_GEN_34 ? ~_GEN_1294 & _GEN_1192 : ~_GEN_1262 & _GEN_1192);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_1_26 <=
      ~_GEN_1327 & (_GEN_34 ? ~_GEN_1295 & _GEN_1194 : ~_GEN_1263 & _GEN_1194);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_1_27 <=
      ~_GEN_1328 & (_GEN_34 ? ~_GEN_1296 & _GEN_1196 : ~_GEN_1264 & _GEN_1196);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_1_28 <=
      ~_GEN_1329 & (_GEN_34 ? ~_GEN_1297 & _GEN_1198 : ~_GEN_1265 & _GEN_1198);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_1_29 <=
      ~_GEN_1330 & (_GEN_34 ? ~_GEN_1298 & _GEN_1200 : ~_GEN_1266 & _GEN_1200);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_1_30 <=
      ~_GEN_1331 & (_GEN_34 ? ~_GEN_1299 & _GEN_1202 : ~_GEN_1267 & _GEN_1202);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_bsy_1_31 <=
      ~_GEN_1332 & (_GEN_34 ? ~_GEN_1300 & _GEN_1204 : ~_GEN_1268 & _GEN_1204);	// rob.scala:308:28, :346:69, :347:31, :361:{31,75}, :363:26
    rob_unsafe_1_0 <=
      ~_GEN_1301 & (_GEN_34 ? ~_GEN_1269 & _GEN_1205 : ~_GEN_1237 & _GEN_1205);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_1_1 <=
      ~_GEN_1302 & (_GEN_34 ? ~_GEN_1270 & _GEN_1206 : ~_GEN_1238 & _GEN_1206);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_1_2 <=
      ~_GEN_1303 & (_GEN_34 ? ~_GEN_1271 & _GEN_1207 : ~_GEN_1239 & _GEN_1207);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_1_3 <=
      ~_GEN_1304 & (_GEN_34 ? ~_GEN_1272 & _GEN_1208 : ~_GEN_1240 & _GEN_1208);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_1_4 <=
      ~_GEN_1305 & (_GEN_34 ? ~_GEN_1273 & _GEN_1209 : ~_GEN_1241 & _GEN_1209);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_1_5 <=
      ~_GEN_1306 & (_GEN_34 ? ~_GEN_1274 & _GEN_1210 : ~_GEN_1242 & _GEN_1210);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_1_6 <=
      ~_GEN_1307 & (_GEN_34 ? ~_GEN_1275 & _GEN_1211 : ~_GEN_1243 & _GEN_1211);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_1_7 <=
      ~_GEN_1308 & (_GEN_34 ? ~_GEN_1276 & _GEN_1212 : ~_GEN_1244 & _GEN_1212);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_1_8 <=
      ~_GEN_1309 & (_GEN_34 ? ~_GEN_1277 & _GEN_1213 : ~_GEN_1245 & _GEN_1213);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_1_9 <=
      ~_GEN_1310 & (_GEN_34 ? ~_GEN_1278 & _GEN_1214 : ~_GEN_1246 & _GEN_1214);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_1_10 <=
      ~_GEN_1311 & (_GEN_34 ? ~_GEN_1279 & _GEN_1215 : ~_GEN_1247 & _GEN_1215);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_1_11 <=
      ~_GEN_1312 & (_GEN_34 ? ~_GEN_1280 & _GEN_1216 : ~_GEN_1248 & _GEN_1216);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_1_12 <=
      ~_GEN_1313 & (_GEN_34 ? ~_GEN_1281 & _GEN_1217 : ~_GEN_1249 & _GEN_1217);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_1_13 <=
      ~_GEN_1314 & (_GEN_34 ? ~_GEN_1282 & _GEN_1218 : ~_GEN_1250 & _GEN_1218);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_1_14 <=
      ~_GEN_1315 & (_GEN_34 ? ~_GEN_1283 & _GEN_1219 : ~_GEN_1251 & _GEN_1219);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_1_15 <=
      ~_GEN_1316 & (_GEN_34 ? ~_GEN_1284 & _GEN_1220 : ~_GEN_1252 & _GEN_1220);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_1_16 <=
      ~_GEN_1317 & (_GEN_34 ? ~_GEN_1285 & _GEN_1221 : ~_GEN_1253 & _GEN_1221);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_1_17 <=
      ~_GEN_1318 & (_GEN_34 ? ~_GEN_1286 & _GEN_1222 : ~_GEN_1254 & _GEN_1222);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_1_18 <=
      ~_GEN_1319 & (_GEN_34 ? ~_GEN_1287 & _GEN_1223 : ~_GEN_1255 & _GEN_1223);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_1_19 <=
      ~_GEN_1320 & (_GEN_34 ? ~_GEN_1288 & _GEN_1224 : ~_GEN_1256 & _GEN_1224);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_1_20 <=
      ~_GEN_1321 & (_GEN_34 ? ~_GEN_1289 & _GEN_1225 : ~_GEN_1257 & _GEN_1225);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_1_21 <=
      ~_GEN_1322 & (_GEN_34 ? ~_GEN_1290 & _GEN_1226 : ~_GEN_1258 & _GEN_1226);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_1_22 <=
      ~_GEN_1323 & (_GEN_34 ? ~_GEN_1291 & _GEN_1227 : ~_GEN_1259 & _GEN_1227);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_1_23 <=
      ~_GEN_1324 & (_GEN_34 ? ~_GEN_1292 & _GEN_1228 : ~_GEN_1260 & _GEN_1228);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_1_24 <=
      ~_GEN_1325 & (_GEN_34 ? ~_GEN_1293 & _GEN_1229 : ~_GEN_1261 & _GEN_1229);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_1_25 <=
      ~_GEN_1326 & (_GEN_34 ? ~_GEN_1294 & _GEN_1230 : ~_GEN_1262 & _GEN_1230);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_1_26 <=
      ~_GEN_1327 & (_GEN_34 ? ~_GEN_1295 & _GEN_1231 : ~_GEN_1263 & _GEN_1231);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_1_27 <=
      ~_GEN_1328 & (_GEN_34 ? ~_GEN_1296 & _GEN_1232 : ~_GEN_1264 & _GEN_1232);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_1_28 <=
      ~_GEN_1329 & (_GEN_34 ? ~_GEN_1297 & _GEN_1233 : ~_GEN_1265 & _GEN_1233);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_1_29 <=
      ~_GEN_1330 & (_GEN_34 ? ~_GEN_1298 & _GEN_1234 : ~_GEN_1266 & _GEN_1234);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_1_30 <=
      ~_GEN_1331 & (_GEN_34 ? ~_GEN_1299 & _GEN_1235 : ~_GEN_1267 & _GEN_1235);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    rob_unsafe_1_31 <=
      ~_GEN_1332 & (_GEN_34 ? ~_GEN_1300 & _GEN_1236 : ~_GEN_1268 & _GEN_1236);	// rob.scala:309:28, :346:69, :347:31, :348:31, :361:{31,75}, :363:26, :364:26
    if (_GEN_885) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_1_0_uopc <= io_enq_uops_1_uopc;	// rob.scala:310:28
      rob_uop_1_0_is_rvc <= io_enq_uops_1_is_rvc;	// rob.scala:310:28
      rob_uop_1_0_ftq_idx <= io_enq_uops_1_ftq_idx;	// rob.scala:310:28
      rob_uop_1_0_edge_inst <= io_enq_uops_1_edge_inst;	// rob.scala:310:28
      rob_uop_1_0_pc_lob <= io_enq_uops_1_pc_lob;	// rob.scala:310:28
      rob_uop_1_0_pdst <= io_enq_uops_1_pdst;	// rob.scala:310:28
      rob_uop_1_0_stale_pdst <= io_enq_uops_1_stale_pdst;	// rob.scala:310:28
      rob_uop_1_0_is_fencei <= io_enq_uops_1_is_fencei;	// rob.scala:310:28
      rob_uop_1_0_uses_ldq <= io_enq_uops_1_uses_ldq;	// rob.scala:310:28
      rob_uop_1_0_uses_stq <= io_enq_uops_1_uses_stq;	// rob.scala:310:28
      rob_uop_1_0_is_sys_pc2epc <= io_enq_uops_1_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_1_0_flush_on_commit <= io_enq_uops_1_flush_on_commit;	// rob.scala:310:28
      rob_uop_1_0_ldst <= io_enq_uops_1_ldst;	// rob.scala:310:28
      rob_uop_1_0_ldst_val <= io_enq_uops_1_ldst_val;	// rob.scala:310:28
      rob_uop_1_0_dst_rtype <= io_enq_uops_1_dst_rtype;	// rob.scala:310:28
      rob_uop_1_0_fp_val <= io_enq_uops_1_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_1365) | ~rob_val_1_0) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_885)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_1_0_br_mask <= io_enq_uops_1_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_1_0_br_mask <= rob_uop_1_0_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_886) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_1_1_uopc <= io_enq_uops_1_uopc;	// rob.scala:310:28
      rob_uop_1_1_is_rvc <= io_enq_uops_1_is_rvc;	// rob.scala:310:28
      rob_uop_1_1_ftq_idx <= io_enq_uops_1_ftq_idx;	// rob.scala:310:28
      rob_uop_1_1_edge_inst <= io_enq_uops_1_edge_inst;	// rob.scala:310:28
      rob_uop_1_1_pc_lob <= io_enq_uops_1_pc_lob;	// rob.scala:310:28
      rob_uop_1_1_pdst <= io_enq_uops_1_pdst;	// rob.scala:310:28
      rob_uop_1_1_stale_pdst <= io_enq_uops_1_stale_pdst;	// rob.scala:310:28
      rob_uop_1_1_is_fencei <= io_enq_uops_1_is_fencei;	// rob.scala:310:28
      rob_uop_1_1_uses_ldq <= io_enq_uops_1_uses_ldq;	// rob.scala:310:28
      rob_uop_1_1_uses_stq <= io_enq_uops_1_uses_stq;	// rob.scala:310:28
      rob_uop_1_1_is_sys_pc2epc <= io_enq_uops_1_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_1_1_flush_on_commit <= io_enq_uops_1_flush_on_commit;	// rob.scala:310:28
      rob_uop_1_1_ldst <= io_enq_uops_1_ldst;	// rob.scala:310:28
      rob_uop_1_1_ldst_val <= io_enq_uops_1_ldst_val;	// rob.scala:310:28
      rob_uop_1_1_dst_rtype <= io_enq_uops_1_dst_rtype;	// rob.scala:310:28
      rob_uop_1_1_fp_val <= io_enq_uops_1_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_1366) | ~rob_val_1_1) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_886)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_1_1_br_mask <= io_enq_uops_1_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_1_1_br_mask <= rob_uop_1_1_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_887) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_1_2_uopc <= io_enq_uops_1_uopc;	// rob.scala:310:28
      rob_uop_1_2_is_rvc <= io_enq_uops_1_is_rvc;	// rob.scala:310:28
      rob_uop_1_2_ftq_idx <= io_enq_uops_1_ftq_idx;	// rob.scala:310:28
      rob_uop_1_2_edge_inst <= io_enq_uops_1_edge_inst;	// rob.scala:310:28
      rob_uop_1_2_pc_lob <= io_enq_uops_1_pc_lob;	// rob.scala:310:28
      rob_uop_1_2_pdst <= io_enq_uops_1_pdst;	// rob.scala:310:28
      rob_uop_1_2_stale_pdst <= io_enq_uops_1_stale_pdst;	// rob.scala:310:28
      rob_uop_1_2_is_fencei <= io_enq_uops_1_is_fencei;	// rob.scala:310:28
      rob_uop_1_2_uses_ldq <= io_enq_uops_1_uses_ldq;	// rob.scala:310:28
      rob_uop_1_2_uses_stq <= io_enq_uops_1_uses_stq;	// rob.scala:310:28
      rob_uop_1_2_is_sys_pc2epc <= io_enq_uops_1_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_1_2_flush_on_commit <= io_enq_uops_1_flush_on_commit;	// rob.scala:310:28
      rob_uop_1_2_ldst <= io_enq_uops_1_ldst;	// rob.scala:310:28
      rob_uop_1_2_ldst_val <= io_enq_uops_1_ldst_val;	// rob.scala:310:28
      rob_uop_1_2_dst_rtype <= io_enq_uops_1_dst_rtype;	// rob.scala:310:28
      rob_uop_1_2_fp_val <= io_enq_uops_1_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_1367) | ~rob_val_1_2) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_887)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_1_2_br_mask <= io_enq_uops_1_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_1_2_br_mask <= rob_uop_1_2_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_888) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_1_3_uopc <= io_enq_uops_1_uopc;	// rob.scala:310:28
      rob_uop_1_3_is_rvc <= io_enq_uops_1_is_rvc;	// rob.scala:310:28
      rob_uop_1_3_ftq_idx <= io_enq_uops_1_ftq_idx;	// rob.scala:310:28
      rob_uop_1_3_edge_inst <= io_enq_uops_1_edge_inst;	// rob.scala:310:28
      rob_uop_1_3_pc_lob <= io_enq_uops_1_pc_lob;	// rob.scala:310:28
      rob_uop_1_3_pdst <= io_enq_uops_1_pdst;	// rob.scala:310:28
      rob_uop_1_3_stale_pdst <= io_enq_uops_1_stale_pdst;	// rob.scala:310:28
      rob_uop_1_3_is_fencei <= io_enq_uops_1_is_fencei;	// rob.scala:310:28
      rob_uop_1_3_uses_ldq <= io_enq_uops_1_uses_ldq;	// rob.scala:310:28
      rob_uop_1_3_uses_stq <= io_enq_uops_1_uses_stq;	// rob.scala:310:28
      rob_uop_1_3_is_sys_pc2epc <= io_enq_uops_1_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_1_3_flush_on_commit <= io_enq_uops_1_flush_on_commit;	// rob.scala:310:28
      rob_uop_1_3_ldst <= io_enq_uops_1_ldst;	// rob.scala:310:28
      rob_uop_1_3_ldst_val <= io_enq_uops_1_ldst_val;	// rob.scala:310:28
      rob_uop_1_3_dst_rtype <= io_enq_uops_1_dst_rtype;	// rob.scala:310:28
      rob_uop_1_3_fp_val <= io_enq_uops_1_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_1368) | ~rob_val_1_3) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_888)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_1_3_br_mask <= io_enq_uops_1_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_1_3_br_mask <= rob_uop_1_3_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_889) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_1_4_uopc <= io_enq_uops_1_uopc;	// rob.scala:310:28
      rob_uop_1_4_is_rvc <= io_enq_uops_1_is_rvc;	// rob.scala:310:28
      rob_uop_1_4_ftq_idx <= io_enq_uops_1_ftq_idx;	// rob.scala:310:28
      rob_uop_1_4_edge_inst <= io_enq_uops_1_edge_inst;	// rob.scala:310:28
      rob_uop_1_4_pc_lob <= io_enq_uops_1_pc_lob;	// rob.scala:310:28
      rob_uop_1_4_pdst <= io_enq_uops_1_pdst;	// rob.scala:310:28
      rob_uop_1_4_stale_pdst <= io_enq_uops_1_stale_pdst;	// rob.scala:310:28
      rob_uop_1_4_is_fencei <= io_enq_uops_1_is_fencei;	// rob.scala:310:28
      rob_uop_1_4_uses_ldq <= io_enq_uops_1_uses_ldq;	// rob.scala:310:28
      rob_uop_1_4_uses_stq <= io_enq_uops_1_uses_stq;	// rob.scala:310:28
      rob_uop_1_4_is_sys_pc2epc <= io_enq_uops_1_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_1_4_flush_on_commit <= io_enq_uops_1_flush_on_commit;	// rob.scala:310:28
      rob_uop_1_4_ldst <= io_enq_uops_1_ldst;	// rob.scala:310:28
      rob_uop_1_4_ldst_val <= io_enq_uops_1_ldst_val;	// rob.scala:310:28
      rob_uop_1_4_dst_rtype <= io_enq_uops_1_dst_rtype;	// rob.scala:310:28
      rob_uop_1_4_fp_val <= io_enq_uops_1_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_1369) | ~rob_val_1_4) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_889)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_1_4_br_mask <= io_enq_uops_1_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_1_4_br_mask <= rob_uop_1_4_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_890) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_1_5_uopc <= io_enq_uops_1_uopc;	// rob.scala:310:28
      rob_uop_1_5_is_rvc <= io_enq_uops_1_is_rvc;	// rob.scala:310:28
      rob_uop_1_5_ftq_idx <= io_enq_uops_1_ftq_idx;	// rob.scala:310:28
      rob_uop_1_5_edge_inst <= io_enq_uops_1_edge_inst;	// rob.scala:310:28
      rob_uop_1_5_pc_lob <= io_enq_uops_1_pc_lob;	// rob.scala:310:28
      rob_uop_1_5_pdst <= io_enq_uops_1_pdst;	// rob.scala:310:28
      rob_uop_1_5_stale_pdst <= io_enq_uops_1_stale_pdst;	// rob.scala:310:28
      rob_uop_1_5_is_fencei <= io_enq_uops_1_is_fencei;	// rob.scala:310:28
      rob_uop_1_5_uses_ldq <= io_enq_uops_1_uses_ldq;	// rob.scala:310:28
      rob_uop_1_5_uses_stq <= io_enq_uops_1_uses_stq;	// rob.scala:310:28
      rob_uop_1_5_is_sys_pc2epc <= io_enq_uops_1_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_1_5_flush_on_commit <= io_enq_uops_1_flush_on_commit;	// rob.scala:310:28
      rob_uop_1_5_ldst <= io_enq_uops_1_ldst;	// rob.scala:310:28
      rob_uop_1_5_ldst_val <= io_enq_uops_1_ldst_val;	// rob.scala:310:28
      rob_uop_1_5_dst_rtype <= io_enq_uops_1_dst_rtype;	// rob.scala:310:28
      rob_uop_1_5_fp_val <= io_enq_uops_1_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_1370) | ~rob_val_1_5) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_890)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_1_5_br_mask <= io_enq_uops_1_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_1_5_br_mask <= rob_uop_1_5_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_891) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_1_6_uopc <= io_enq_uops_1_uopc;	// rob.scala:310:28
      rob_uop_1_6_is_rvc <= io_enq_uops_1_is_rvc;	// rob.scala:310:28
      rob_uop_1_6_ftq_idx <= io_enq_uops_1_ftq_idx;	// rob.scala:310:28
      rob_uop_1_6_edge_inst <= io_enq_uops_1_edge_inst;	// rob.scala:310:28
      rob_uop_1_6_pc_lob <= io_enq_uops_1_pc_lob;	// rob.scala:310:28
      rob_uop_1_6_pdst <= io_enq_uops_1_pdst;	// rob.scala:310:28
      rob_uop_1_6_stale_pdst <= io_enq_uops_1_stale_pdst;	// rob.scala:310:28
      rob_uop_1_6_is_fencei <= io_enq_uops_1_is_fencei;	// rob.scala:310:28
      rob_uop_1_6_uses_ldq <= io_enq_uops_1_uses_ldq;	// rob.scala:310:28
      rob_uop_1_6_uses_stq <= io_enq_uops_1_uses_stq;	// rob.scala:310:28
      rob_uop_1_6_is_sys_pc2epc <= io_enq_uops_1_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_1_6_flush_on_commit <= io_enq_uops_1_flush_on_commit;	// rob.scala:310:28
      rob_uop_1_6_ldst <= io_enq_uops_1_ldst;	// rob.scala:310:28
      rob_uop_1_6_ldst_val <= io_enq_uops_1_ldst_val;	// rob.scala:310:28
      rob_uop_1_6_dst_rtype <= io_enq_uops_1_dst_rtype;	// rob.scala:310:28
      rob_uop_1_6_fp_val <= io_enq_uops_1_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_1371) | ~rob_val_1_6) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_891)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_1_6_br_mask <= io_enq_uops_1_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_1_6_br_mask <= rob_uop_1_6_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_892) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_1_7_uopc <= io_enq_uops_1_uopc;	// rob.scala:310:28
      rob_uop_1_7_is_rvc <= io_enq_uops_1_is_rvc;	// rob.scala:310:28
      rob_uop_1_7_ftq_idx <= io_enq_uops_1_ftq_idx;	// rob.scala:310:28
      rob_uop_1_7_edge_inst <= io_enq_uops_1_edge_inst;	// rob.scala:310:28
      rob_uop_1_7_pc_lob <= io_enq_uops_1_pc_lob;	// rob.scala:310:28
      rob_uop_1_7_pdst <= io_enq_uops_1_pdst;	// rob.scala:310:28
      rob_uop_1_7_stale_pdst <= io_enq_uops_1_stale_pdst;	// rob.scala:310:28
      rob_uop_1_7_is_fencei <= io_enq_uops_1_is_fencei;	// rob.scala:310:28
      rob_uop_1_7_uses_ldq <= io_enq_uops_1_uses_ldq;	// rob.scala:310:28
      rob_uop_1_7_uses_stq <= io_enq_uops_1_uses_stq;	// rob.scala:310:28
      rob_uop_1_7_is_sys_pc2epc <= io_enq_uops_1_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_1_7_flush_on_commit <= io_enq_uops_1_flush_on_commit;	// rob.scala:310:28
      rob_uop_1_7_ldst <= io_enq_uops_1_ldst;	// rob.scala:310:28
      rob_uop_1_7_ldst_val <= io_enq_uops_1_ldst_val;	// rob.scala:310:28
      rob_uop_1_7_dst_rtype <= io_enq_uops_1_dst_rtype;	// rob.scala:310:28
      rob_uop_1_7_fp_val <= io_enq_uops_1_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_1372) | ~rob_val_1_7) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_892)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_1_7_br_mask <= io_enq_uops_1_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_1_7_br_mask <= rob_uop_1_7_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_893) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_1_8_uopc <= io_enq_uops_1_uopc;	// rob.scala:310:28
      rob_uop_1_8_is_rvc <= io_enq_uops_1_is_rvc;	// rob.scala:310:28
      rob_uop_1_8_ftq_idx <= io_enq_uops_1_ftq_idx;	// rob.scala:310:28
      rob_uop_1_8_edge_inst <= io_enq_uops_1_edge_inst;	// rob.scala:310:28
      rob_uop_1_8_pc_lob <= io_enq_uops_1_pc_lob;	// rob.scala:310:28
      rob_uop_1_8_pdst <= io_enq_uops_1_pdst;	// rob.scala:310:28
      rob_uop_1_8_stale_pdst <= io_enq_uops_1_stale_pdst;	// rob.scala:310:28
      rob_uop_1_8_is_fencei <= io_enq_uops_1_is_fencei;	// rob.scala:310:28
      rob_uop_1_8_uses_ldq <= io_enq_uops_1_uses_ldq;	// rob.scala:310:28
      rob_uop_1_8_uses_stq <= io_enq_uops_1_uses_stq;	// rob.scala:310:28
      rob_uop_1_8_is_sys_pc2epc <= io_enq_uops_1_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_1_8_flush_on_commit <= io_enq_uops_1_flush_on_commit;	// rob.scala:310:28
      rob_uop_1_8_ldst <= io_enq_uops_1_ldst;	// rob.scala:310:28
      rob_uop_1_8_ldst_val <= io_enq_uops_1_ldst_val;	// rob.scala:310:28
      rob_uop_1_8_dst_rtype <= io_enq_uops_1_dst_rtype;	// rob.scala:310:28
      rob_uop_1_8_fp_val <= io_enq_uops_1_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_1373) | ~rob_val_1_8) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_893)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_1_8_br_mask <= io_enq_uops_1_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_1_8_br_mask <= rob_uop_1_8_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_894) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_1_9_uopc <= io_enq_uops_1_uopc;	// rob.scala:310:28
      rob_uop_1_9_is_rvc <= io_enq_uops_1_is_rvc;	// rob.scala:310:28
      rob_uop_1_9_ftq_idx <= io_enq_uops_1_ftq_idx;	// rob.scala:310:28
      rob_uop_1_9_edge_inst <= io_enq_uops_1_edge_inst;	// rob.scala:310:28
      rob_uop_1_9_pc_lob <= io_enq_uops_1_pc_lob;	// rob.scala:310:28
      rob_uop_1_9_pdst <= io_enq_uops_1_pdst;	// rob.scala:310:28
      rob_uop_1_9_stale_pdst <= io_enq_uops_1_stale_pdst;	// rob.scala:310:28
      rob_uop_1_9_is_fencei <= io_enq_uops_1_is_fencei;	// rob.scala:310:28
      rob_uop_1_9_uses_ldq <= io_enq_uops_1_uses_ldq;	// rob.scala:310:28
      rob_uop_1_9_uses_stq <= io_enq_uops_1_uses_stq;	// rob.scala:310:28
      rob_uop_1_9_is_sys_pc2epc <= io_enq_uops_1_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_1_9_flush_on_commit <= io_enq_uops_1_flush_on_commit;	// rob.scala:310:28
      rob_uop_1_9_ldst <= io_enq_uops_1_ldst;	// rob.scala:310:28
      rob_uop_1_9_ldst_val <= io_enq_uops_1_ldst_val;	// rob.scala:310:28
      rob_uop_1_9_dst_rtype <= io_enq_uops_1_dst_rtype;	// rob.scala:310:28
      rob_uop_1_9_fp_val <= io_enq_uops_1_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_1374) | ~rob_val_1_9) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_894)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_1_9_br_mask <= io_enq_uops_1_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_1_9_br_mask <= rob_uop_1_9_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_895) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_1_10_uopc <= io_enq_uops_1_uopc;	// rob.scala:310:28
      rob_uop_1_10_is_rvc <= io_enq_uops_1_is_rvc;	// rob.scala:310:28
      rob_uop_1_10_ftq_idx <= io_enq_uops_1_ftq_idx;	// rob.scala:310:28
      rob_uop_1_10_edge_inst <= io_enq_uops_1_edge_inst;	// rob.scala:310:28
      rob_uop_1_10_pc_lob <= io_enq_uops_1_pc_lob;	// rob.scala:310:28
      rob_uop_1_10_pdst <= io_enq_uops_1_pdst;	// rob.scala:310:28
      rob_uop_1_10_stale_pdst <= io_enq_uops_1_stale_pdst;	// rob.scala:310:28
      rob_uop_1_10_is_fencei <= io_enq_uops_1_is_fencei;	// rob.scala:310:28
      rob_uop_1_10_uses_ldq <= io_enq_uops_1_uses_ldq;	// rob.scala:310:28
      rob_uop_1_10_uses_stq <= io_enq_uops_1_uses_stq;	// rob.scala:310:28
      rob_uop_1_10_is_sys_pc2epc <= io_enq_uops_1_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_1_10_flush_on_commit <= io_enq_uops_1_flush_on_commit;	// rob.scala:310:28
      rob_uop_1_10_ldst <= io_enq_uops_1_ldst;	// rob.scala:310:28
      rob_uop_1_10_ldst_val <= io_enq_uops_1_ldst_val;	// rob.scala:310:28
      rob_uop_1_10_dst_rtype <= io_enq_uops_1_dst_rtype;	// rob.scala:310:28
      rob_uop_1_10_fp_val <= io_enq_uops_1_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_1375) | ~rob_val_1_10) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_895)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_1_10_br_mask <= io_enq_uops_1_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_1_10_br_mask <= rob_uop_1_10_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_896) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_1_11_uopc <= io_enq_uops_1_uopc;	// rob.scala:310:28
      rob_uop_1_11_is_rvc <= io_enq_uops_1_is_rvc;	// rob.scala:310:28
      rob_uop_1_11_ftq_idx <= io_enq_uops_1_ftq_idx;	// rob.scala:310:28
      rob_uop_1_11_edge_inst <= io_enq_uops_1_edge_inst;	// rob.scala:310:28
      rob_uop_1_11_pc_lob <= io_enq_uops_1_pc_lob;	// rob.scala:310:28
      rob_uop_1_11_pdst <= io_enq_uops_1_pdst;	// rob.scala:310:28
      rob_uop_1_11_stale_pdst <= io_enq_uops_1_stale_pdst;	// rob.scala:310:28
      rob_uop_1_11_is_fencei <= io_enq_uops_1_is_fencei;	// rob.scala:310:28
      rob_uop_1_11_uses_ldq <= io_enq_uops_1_uses_ldq;	// rob.scala:310:28
      rob_uop_1_11_uses_stq <= io_enq_uops_1_uses_stq;	// rob.scala:310:28
      rob_uop_1_11_is_sys_pc2epc <= io_enq_uops_1_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_1_11_flush_on_commit <= io_enq_uops_1_flush_on_commit;	// rob.scala:310:28
      rob_uop_1_11_ldst <= io_enq_uops_1_ldst;	// rob.scala:310:28
      rob_uop_1_11_ldst_val <= io_enq_uops_1_ldst_val;	// rob.scala:310:28
      rob_uop_1_11_dst_rtype <= io_enq_uops_1_dst_rtype;	// rob.scala:310:28
      rob_uop_1_11_fp_val <= io_enq_uops_1_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_1376) | ~rob_val_1_11) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_896)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_1_11_br_mask <= io_enq_uops_1_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_1_11_br_mask <= rob_uop_1_11_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_897) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_1_12_uopc <= io_enq_uops_1_uopc;	// rob.scala:310:28
      rob_uop_1_12_is_rvc <= io_enq_uops_1_is_rvc;	// rob.scala:310:28
      rob_uop_1_12_ftq_idx <= io_enq_uops_1_ftq_idx;	// rob.scala:310:28
      rob_uop_1_12_edge_inst <= io_enq_uops_1_edge_inst;	// rob.scala:310:28
      rob_uop_1_12_pc_lob <= io_enq_uops_1_pc_lob;	// rob.scala:310:28
      rob_uop_1_12_pdst <= io_enq_uops_1_pdst;	// rob.scala:310:28
      rob_uop_1_12_stale_pdst <= io_enq_uops_1_stale_pdst;	// rob.scala:310:28
      rob_uop_1_12_is_fencei <= io_enq_uops_1_is_fencei;	// rob.scala:310:28
      rob_uop_1_12_uses_ldq <= io_enq_uops_1_uses_ldq;	// rob.scala:310:28
      rob_uop_1_12_uses_stq <= io_enq_uops_1_uses_stq;	// rob.scala:310:28
      rob_uop_1_12_is_sys_pc2epc <= io_enq_uops_1_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_1_12_flush_on_commit <= io_enq_uops_1_flush_on_commit;	// rob.scala:310:28
      rob_uop_1_12_ldst <= io_enq_uops_1_ldst;	// rob.scala:310:28
      rob_uop_1_12_ldst_val <= io_enq_uops_1_ldst_val;	// rob.scala:310:28
      rob_uop_1_12_dst_rtype <= io_enq_uops_1_dst_rtype;	// rob.scala:310:28
      rob_uop_1_12_fp_val <= io_enq_uops_1_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_1377) | ~rob_val_1_12) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_897)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_1_12_br_mask <= io_enq_uops_1_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_1_12_br_mask <= rob_uop_1_12_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_898) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_1_13_uopc <= io_enq_uops_1_uopc;	// rob.scala:310:28
      rob_uop_1_13_is_rvc <= io_enq_uops_1_is_rvc;	// rob.scala:310:28
      rob_uop_1_13_ftq_idx <= io_enq_uops_1_ftq_idx;	// rob.scala:310:28
      rob_uop_1_13_edge_inst <= io_enq_uops_1_edge_inst;	// rob.scala:310:28
      rob_uop_1_13_pc_lob <= io_enq_uops_1_pc_lob;	// rob.scala:310:28
      rob_uop_1_13_pdst <= io_enq_uops_1_pdst;	// rob.scala:310:28
      rob_uop_1_13_stale_pdst <= io_enq_uops_1_stale_pdst;	// rob.scala:310:28
      rob_uop_1_13_is_fencei <= io_enq_uops_1_is_fencei;	// rob.scala:310:28
      rob_uop_1_13_uses_ldq <= io_enq_uops_1_uses_ldq;	// rob.scala:310:28
      rob_uop_1_13_uses_stq <= io_enq_uops_1_uses_stq;	// rob.scala:310:28
      rob_uop_1_13_is_sys_pc2epc <= io_enq_uops_1_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_1_13_flush_on_commit <= io_enq_uops_1_flush_on_commit;	// rob.scala:310:28
      rob_uop_1_13_ldst <= io_enq_uops_1_ldst;	// rob.scala:310:28
      rob_uop_1_13_ldst_val <= io_enq_uops_1_ldst_val;	// rob.scala:310:28
      rob_uop_1_13_dst_rtype <= io_enq_uops_1_dst_rtype;	// rob.scala:310:28
      rob_uop_1_13_fp_val <= io_enq_uops_1_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_1378) | ~rob_val_1_13) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_898)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_1_13_br_mask <= io_enq_uops_1_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_1_13_br_mask <= rob_uop_1_13_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_899) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_1_14_uopc <= io_enq_uops_1_uopc;	// rob.scala:310:28
      rob_uop_1_14_is_rvc <= io_enq_uops_1_is_rvc;	// rob.scala:310:28
      rob_uop_1_14_ftq_idx <= io_enq_uops_1_ftq_idx;	// rob.scala:310:28
      rob_uop_1_14_edge_inst <= io_enq_uops_1_edge_inst;	// rob.scala:310:28
      rob_uop_1_14_pc_lob <= io_enq_uops_1_pc_lob;	// rob.scala:310:28
      rob_uop_1_14_pdst <= io_enq_uops_1_pdst;	// rob.scala:310:28
      rob_uop_1_14_stale_pdst <= io_enq_uops_1_stale_pdst;	// rob.scala:310:28
      rob_uop_1_14_is_fencei <= io_enq_uops_1_is_fencei;	// rob.scala:310:28
      rob_uop_1_14_uses_ldq <= io_enq_uops_1_uses_ldq;	// rob.scala:310:28
      rob_uop_1_14_uses_stq <= io_enq_uops_1_uses_stq;	// rob.scala:310:28
      rob_uop_1_14_is_sys_pc2epc <= io_enq_uops_1_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_1_14_flush_on_commit <= io_enq_uops_1_flush_on_commit;	// rob.scala:310:28
      rob_uop_1_14_ldst <= io_enq_uops_1_ldst;	// rob.scala:310:28
      rob_uop_1_14_ldst_val <= io_enq_uops_1_ldst_val;	// rob.scala:310:28
      rob_uop_1_14_dst_rtype <= io_enq_uops_1_dst_rtype;	// rob.scala:310:28
      rob_uop_1_14_fp_val <= io_enq_uops_1_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_1379) | ~rob_val_1_14) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_899)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_1_14_br_mask <= io_enq_uops_1_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_1_14_br_mask <= rob_uop_1_14_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_900) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_1_15_uopc <= io_enq_uops_1_uopc;	// rob.scala:310:28
      rob_uop_1_15_is_rvc <= io_enq_uops_1_is_rvc;	// rob.scala:310:28
      rob_uop_1_15_ftq_idx <= io_enq_uops_1_ftq_idx;	// rob.scala:310:28
      rob_uop_1_15_edge_inst <= io_enq_uops_1_edge_inst;	// rob.scala:310:28
      rob_uop_1_15_pc_lob <= io_enq_uops_1_pc_lob;	// rob.scala:310:28
      rob_uop_1_15_pdst <= io_enq_uops_1_pdst;	// rob.scala:310:28
      rob_uop_1_15_stale_pdst <= io_enq_uops_1_stale_pdst;	// rob.scala:310:28
      rob_uop_1_15_is_fencei <= io_enq_uops_1_is_fencei;	// rob.scala:310:28
      rob_uop_1_15_uses_ldq <= io_enq_uops_1_uses_ldq;	// rob.scala:310:28
      rob_uop_1_15_uses_stq <= io_enq_uops_1_uses_stq;	// rob.scala:310:28
      rob_uop_1_15_is_sys_pc2epc <= io_enq_uops_1_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_1_15_flush_on_commit <= io_enq_uops_1_flush_on_commit;	// rob.scala:310:28
      rob_uop_1_15_ldst <= io_enq_uops_1_ldst;	// rob.scala:310:28
      rob_uop_1_15_ldst_val <= io_enq_uops_1_ldst_val;	// rob.scala:310:28
      rob_uop_1_15_dst_rtype <= io_enq_uops_1_dst_rtype;	// rob.scala:310:28
      rob_uop_1_15_fp_val <= io_enq_uops_1_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_1380) | ~rob_val_1_15) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_900)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_1_15_br_mask <= io_enq_uops_1_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_1_15_br_mask <= rob_uop_1_15_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_901) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_1_16_uopc <= io_enq_uops_1_uopc;	// rob.scala:310:28
      rob_uop_1_16_is_rvc <= io_enq_uops_1_is_rvc;	// rob.scala:310:28
      rob_uop_1_16_ftq_idx <= io_enq_uops_1_ftq_idx;	// rob.scala:310:28
      rob_uop_1_16_edge_inst <= io_enq_uops_1_edge_inst;	// rob.scala:310:28
      rob_uop_1_16_pc_lob <= io_enq_uops_1_pc_lob;	// rob.scala:310:28
      rob_uop_1_16_pdst <= io_enq_uops_1_pdst;	// rob.scala:310:28
      rob_uop_1_16_stale_pdst <= io_enq_uops_1_stale_pdst;	// rob.scala:310:28
      rob_uop_1_16_is_fencei <= io_enq_uops_1_is_fencei;	// rob.scala:310:28
      rob_uop_1_16_uses_ldq <= io_enq_uops_1_uses_ldq;	// rob.scala:310:28
      rob_uop_1_16_uses_stq <= io_enq_uops_1_uses_stq;	// rob.scala:310:28
      rob_uop_1_16_is_sys_pc2epc <= io_enq_uops_1_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_1_16_flush_on_commit <= io_enq_uops_1_flush_on_commit;	// rob.scala:310:28
      rob_uop_1_16_ldst <= io_enq_uops_1_ldst;	// rob.scala:310:28
      rob_uop_1_16_ldst_val <= io_enq_uops_1_ldst_val;	// rob.scala:310:28
      rob_uop_1_16_dst_rtype <= io_enq_uops_1_dst_rtype;	// rob.scala:310:28
      rob_uop_1_16_fp_val <= io_enq_uops_1_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_1381) | ~rob_val_1_16) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_901)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_1_16_br_mask <= io_enq_uops_1_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_1_16_br_mask <= rob_uop_1_16_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_902) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_1_17_uopc <= io_enq_uops_1_uopc;	// rob.scala:310:28
      rob_uop_1_17_is_rvc <= io_enq_uops_1_is_rvc;	// rob.scala:310:28
      rob_uop_1_17_ftq_idx <= io_enq_uops_1_ftq_idx;	// rob.scala:310:28
      rob_uop_1_17_edge_inst <= io_enq_uops_1_edge_inst;	// rob.scala:310:28
      rob_uop_1_17_pc_lob <= io_enq_uops_1_pc_lob;	// rob.scala:310:28
      rob_uop_1_17_pdst <= io_enq_uops_1_pdst;	// rob.scala:310:28
      rob_uop_1_17_stale_pdst <= io_enq_uops_1_stale_pdst;	// rob.scala:310:28
      rob_uop_1_17_is_fencei <= io_enq_uops_1_is_fencei;	// rob.scala:310:28
      rob_uop_1_17_uses_ldq <= io_enq_uops_1_uses_ldq;	// rob.scala:310:28
      rob_uop_1_17_uses_stq <= io_enq_uops_1_uses_stq;	// rob.scala:310:28
      rob_uop_1_17_is_sys_pc2epc <= io_enq_uops_1_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_1_17_flush_on_commit <= io_enq_uops_1_flush_on_commit;	// rob.scala:310:28
      rob_uop_1_17_ldst <= io_enq_uops_1_ldst;	// rob.scala:310:28
      rob_uop_1_17_ldst_val <= io_enq_uops_1_ldst_val;	// rob.scala:310:28
      rob_uop_1_17_dst_rtype <= io_enq_uops_1_dst_rtype;	// rob.scala:310:28
      rob_uop_1_17_fp_val <= io_enq_uops_1_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_1382) | ~rob_val_1_17) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_902)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_1_17_br_mask <= io_enq_uops_1_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_1_17_br_mask <= rob_uop_1_17_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_903) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_1_18_uopc <= io_enq_uops_1_uopc;	// rob.scala:310:28
      rob_uop_1_18_is_rvc <= io_enq_uops_1_is_rvc;	// rob.scala:310:28
      rob_uop_1_18_ftq_idx <= io_enq_uops_1_ftq_idx;	// rob.scala:310:28
      rob_uop_1_18_edge_inst <= io_enq_uops_1_edge_inst;	// rob.scala:310:28
      rob_uop_1_18_pc_lob <= io_enq_uops_1_pc_lob;	// rob.scala:310:28
      rob_uop_1_18_pdst <= io_enq_uops_1_pdst;	// rob.scala:310:28
      rob_uop_1_18_stale_pdst <= io_enq_uops_1_stale_pdst;	// rob.scala:310:28
      rob_uop_1_18_is_fencei <= io_enq_uops_1_is_fencei;	// rob.scala:310:28
      rob_uop_1_18_uses_ldq <= io_enq_uops_1_uses_ldq;	// rob.scala:310:28
      rob_uop_1_18_uses_stq <= io_enq_uops_1_uses_stq;	// rob.scala:310:28
      rob_uop_1_18_is_sys_pc2epc <= io_enq_uops_1_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_1_18_flush_on_commit <= io_enq_uops_1_flush_on_commit;	// rob.scala:310:28
      rob_uop_1_18_ldst <= io_enq_uops_1_ldst;	// rob.scala:310:28
      rob_uop_1_18_ldst_val <= io_enq_uops_1_ldst_val;	// rob.scala:310:28
      rob_uop_1_18_dst_rtype <= io_enq_uops_1_dst_rtype;	// rob.scala:310:28
      rob_uop_1_18_fp_val <= io_enq_uops_1_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_1383) | ~rob_val_1_18) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_903)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_1_18_br_mask <= io_enq_uops_1_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_1_18_br_mask <= rob_uop_1_18_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_904) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_1_19_uopc <= io_enq_uops_1_uopc;	// rob.scala:310:28
      rob_uop_1_19_is_rvc <= io_enq_uops_1_is_rvc;	// rob.scala:310:28
      rob_uop_1_19_ftq_idx <= io_enq_uops_1_ftq_idx;	// rob.scala:310:28
      rob_uop_1_19_edge_inst <= io_enq_uops_1_edge_inst;	// rob.scala:310:28
      rob_uop_1_19_pc_lob <= io_enq_uops_1_pc_lob;	// rob.scala:310:28
      rob_uop_1_19_pdst <= io_enq_uops_1_pdst;	// rob.scala:310:28
      rob_uop_1_19_stale_pdst <= io_enq_uops_1_stale_pdst;	// rob.scala:310:28
      rob_uop_1_19_is_fencei <= io_enq_uops_1_is_fencei;	// rob.scala:310:28
      rob_uop_1_19_uses_ldq <= io_enq_uops_1_uses_ldq;	// rob.scala:310:28
      rob_uop_1_19_uses_stq <= io_enq_uops_1_uses_stq;	// rob.scala:310:28
      rob_uop_1_19_is_sys_pc2epc <= io_enq_uops_1_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_1_19_flush_on_commit <= io_enq_uops_1_flush_on_commit;	// rob.scala:310:28
      rob_uop_1_19_ldst <= io_enq_uops_1_ldst;	// rob.scala:310:28
      rob_uop_1_19_ldst_val <= io_enq_uops_1_ldst_val;	// rob.scala:310:28
      rob_uop_1_19_dst_rtype <= io_enq_uops_1_dst_rtype;	// rob.scala:310:28
      rob_uop_1_19_fp_val <= io_enq_uops_1_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_1384) | ~rob_val_1_19) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_904)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_1_19_br_mask <= io_enq_uops_1_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_1_19_br_mask <= rob_uop_1_19_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_905) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_1_20_uopc <= io_enq_uops_1_uopc;	// rob.scala:310:28
      rob_uop_1_20_is_rvc <= io_enq_uops_1_is_rvc;	// rob.scala:310:28
      rob_uop_1_20_ftq_idx <= io_enq_uops_1_ftq_idx;	// rob.scala:310:28
      rob_uop_1_20_edge_inst <= io_enq_uops_1_edge_inst;	// rob.scala:310:28
      rob_uop_1_20_pc_lob <= io_enq_uops_1_pc_lob;	// rob.scala:310:28
      rob_uop_1_20_pdst <= io_enq_uops_1_pdst;	// rob.scala:310:28
      rob_uop_1_20_stale_pdst <= io_enq_uops_1_stale_pdst;	// rob.scala:310:28
      rob_uop_1_20_is_fencei <= io_enq_uops_1_is_fencei;	// rob.scala:310:28
      rob_uop_1_20_uses_ldq <= io_enq_uops_1_uses_ldq;	// rob.scala:310:28
      rob_uop_1_20_uses_stq <= io_enq_uops_1_uses_stq;	// rob.scala:310:28
      rob_uop_1_20_is_sys_pc2epc <= io_enq_uops_1_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_1_20_flush_on_commit <= io_enq_uops_1_flush_on_commit;	// rob.scala:310:28
      rob_uop_1_20_ldst <= io_enq_uops_1_ldst;	// rob.scala:310:28
      rob_uop_1_20_ldst_val <= io_enq_uops_1_ldst_val;	// rob.scala:310:28
      rob_uop_1_20_dst_rtype <= io_enq_uops_1_dst_rtype;	// rob.scala:310:28
      rob_uop_1_20_fp_val <= io_enq_uops_1_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_1385) | ~rob_val_1_20) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_905)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_1_20_br_mask <= io_enq_uops_1_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_1_20_br_mask <= rob_uop_1_20_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_906) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_1_21_uopc <= io_enq_uops_1_uopc;	// rob.scala:310:28
      rob_uop_1_21_is_rvc <= io_enq_uops_1_is_rvc;	// rob.scala:310:28
      rob_uop_1_21_ftq_idx <= io_enq_uops_1_ftq_idx;	// rob.scala:310:28
      rob_uop_1_21_edge_inst <= io_enq_uops_1_edge_inst;	// rob.scala:310:28
      rob_uop_1_21_pc_lob <= io_enq_uops_1_pc_lob;	// rob.scala:310:28
      rob_uop_1_21_pdst <= io_enq_uops_1_pdst;	// rob.scala:310:28
      rob_uop_1_21_stale_pdst <= io_enq_uops_1_stale_pdst;	// rob.scala:310:28
      rob_uop_1_21_is_fencei <= io_enq_uops_1_is_fencei;	// rob.scala:310:28
      rob_uop_1_21_uses_ldq <= io_enq_uops_1_uses_ldq;	// rob.scala:310:28
      rob_uop_1_21_uses_stq <= io_enq_uops_1_uses_stq;	// rob.scala:310:28
      rob_uop_1_21_is_sys_pc2epc <= io_enq_uops_1_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_1_21_flush_on_commit <= io_enq_uops_1_flush_on_commit;	// rob.scala:310:28
      rob_uop_1_21_ldst <= io_enq_uops_1_ldst;	// rob.scala:310:28
      rob_uop_1_21_ldst_val <= io_enq_uops_1_ldst_val;	// rob.scala:310:28
      rob_uop_1_21_dst_rtype <= io_enq_uops_1_dst_rtype;	// rob.scala:310:28
      rob_uop_1_21_fp_val <= io_enq_uops_1_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_1386) | ~rob_val_1_21) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_906)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_1_21_br_mask <= io_enq_uops_1_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_1_21_br_mask <= rob_uop_1_21_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_907) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_1_22_uopc <= io_enq_uops_1_uopc;	// rob.scala:310:28
      rob_uop_1_22_is_rvc <= io_enq_uops_1_is_rvc;	// rob.scala:310:28
      rob_uop_1_22_ftq_idx <= io_enq_uops_1_ftq_idx;	// rob.scala:310:28
      rob_uop_1_22_edge_inst <= io_enq_uops_1_edge_inst;	// rob.scala:310:28
      rob_uop_1_22_pc_lob <= io_enq_uops_1_pc_lob;	// rob.scala:310:28
      rob_uop_1_22_pdst <= io_enq_uops_1_pdst;	// rob.scala:310:28
      rob_uop_1_22_stale_pdst <= io_enq_uops_1_stale_pdst;	// rob.scala:310:28
      rob_uop_1_22_is_fencei <= io_enq_uops_1_is_fencei;	// rob.scala:310:28
      rob_uop_1_22_uses_ldq <= io_enq_uops_1_uses_ldq;	// rob.scala:310:28
      rob_uop_1_22_uses_stq <= io_enq_uops_1_uses_stq;	// rob.scala:310:28
      rob_uop_1_22_is_sys_pc2epc <= io_enq_uops_1_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_1_22_flush_on_commit <= io_enq_uops_1_flush_on_commit;	// rob.scala:310:28
      rob_uop_1_22_ldst <= io_enq_uops_1_ldst;	// rob.scala:310:28
      rob_uop_1_22_ldst_val <= io_enq_uops_1_ldst_val;	// rob.scala:310:28
      rob_uop_1_22_dst_rtype <= io_enq_uops_1_dst_rtype;	// rob.scala:310:28
      rob_uop_1_22_fp_val <= io_enq_uops_1_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_1387) | ~rob_val_1_22) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_907)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_1_22_br_mask <= io_enq_uops_1_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_1_22_br_mask <= rob_uop_1_22_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_908) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_1_23_uopc <= io_enq_uops_1_uopc;	// rob.scala:310:28
      rob_uop_1_23_is_rvc <= io_enq_uops_1_is_rvc;	// rob.scala:310:28
      rob_uop_1_23_ftq_idx <= io_enq_uops_1_ftq_idx;	// rob.scala:310:28
      rob_uop_1_23_edge_inst <= io_enq_uops_1_edge_inst;	// rob.scala:310:28
      rob_uop_1_23_pc_lob <= io_enq_uops_1_pc_lob;	// rob.scala:310:28
      rob_uop_1_23_pdst <= io_enq_uops_1_pdst;	// rob.scala:310:28
      rob_uop_1_23_stale_pdst <= io_enq_uops_1_stale_pdst;	// rob.scala:310:28
      rob_uop_1_23_is_fencei <= io_enq_uops_1_is_fencei;	// rob.scala:310:28
      rob_uop_1_23_uses_ldq <= io_enq_uops_1_uses_ldq;	// rob.scala:310:28
      rob_uop_1_23_uses_stq <= io_enq_uops_1_uses_stq;	// rob.scala:310:28
      rob_uop_1_23_is_sys_pc2epc <= io_enq_uops_1_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_1_23_flush_on_commit <= io_enq_uops_1_flush_on_commit;	// rob.scala:310:28
      rob_uop_1_23_ldst <= io_enq_uops_1_ldst;	// rob.scala:310:28
      rob_uop_1_23_ldst_val <= io_enq_uops_1_ldst_val;	// rob.scala:310:28
      rob_uop_1_23_dst_rtype <= io_enq_uops_1_dst_rtype;	// rob.scala:310:28
      rob_uop_1_23_fp_val <= io_enq_uops_1_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_1388) | ~rob_val_1_23) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_908)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_1_23_br_mask <= io_enq_uops_1_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_1_23_br_mask <= rob_uop_1_23_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_909) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_1_24_uopc <= io_enq_uops_1_uopc;	// rob.scala:310:28
      rob_uop_1_24_is_rvc <= io_enq_uops_1_is_rvc;	// rob.scala:310:28
      rob_uop_1_24_ftq_idx <= io_enq_uops_1_ftq_idx;	// rob.scala:310:28
      rob_uop_1_24_edge_inst <= io_enq_uops_1_edge_inst;	// rob.scala:310:28
      rob_uop_1_24_pc_lob <= io_enq_uops_1_pc_lob;	// rob.scala:310:28
      rob_uop_1_24_pdst <= io_enq_uops_1_pdst;	// rob.scala:310:28
      rob_uop_1_24_stale_pdst <= io_enq_uops_1_stale_pdst;	// rob.scala:310:28
      rob_uop_1_24_is_fencei <= io_enq_uops_1_is_fencei;	// rob.scala:310:28
      rob_uop_1_24_uses_ldq <= io_enq_uops_1_uses_ldq;	// rob.scala:310:28
      rob_uop_1_24_uses_stq <= io_enq_uops_1_uses_stq;	// rob.scala:310:28
      rob_uop_1_24_is_sys_pc2epc <= io_enq_uops_1_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_1_24_flush_on_commit <= io_enq_uops_1_flush_on_commit;	// rob.scala:310:28
      rob_uop_1_24_ldst <= io_enq_uops_1_ldst;	// rob.scala:310:28
      rob_uop_1_24_ldst_val <= io_enq_uops_1_ldst_val;	// rob.scala:310:28
      rob_uop_1_24_dst_rtype <= io_enq_uops_1_dst_rtype;	// rob.scala:310:28
      rob_uop_1_24_fp_val <= io_enq_uops_1_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_1389) | ~rob_val_1_24) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_909)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_1_24_br_mask <= io_enq_uops_1_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_1_24_br_mask <= rob_uop_1_24_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_910) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_1_25_uopc <= io_enq_uops_1_uopc;	// rob.scala:310:28
      rob_uop_1_25_is_rvc <= io_enq_uops_1_is_rvc;	// rob.scala:310:28
      rob_uop_1_25_ftq_idx <= io_enq_uops_1_ftq_idx;	// rob.scala:310:28
      rob_uop_1_25_edge_inst <= io_enq_uops_1_edge_inst;	// rob.scala:310:28
      rob_uop_1_25_pc_lob <= io_enq_uops_1_pc_lob;	// rob.scala:310:28
      rob_uop_1_25_pdst <= io_enq_uops_1_pdst;	// rob.scala:310:28
      rob_uop_1_25_stale_pdst <= io_enq_uops_1_stale_pdst;	// rob.scala:310:28
      rob_uop_1_25_is_fencei <= io_enq_uops_1_is_fencei;	// rob.scala:310:28
      rob_uop_1_25_uses_ldq <= io_enq_uops_1_uses_ldq;	// rob.scala:310:28
      rob_uop_1_25_uses_stq <= io_enq_uops_1_uses_stq;	// rob.scala:310:28
      rob_uop_1_25_is_sys_pc2epc <= io_enq_uops_1_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_1_25_flush_on_commit <= io_enq_uops_1_flush_on_commit;	// rob.scala:310:28
      rob_uop_1_25_ldst <= io_enq_uops_1_ldst;	// rob.scala:310:28
      rob_uop_1_25_ldst_val <= io_enq_uops_1_ldst_val;	// rob.scala:310:28
      rob_uop_1_25_dst_rtype <= io_enq_uops_1_dst_rtype;	// rob.scala:310:28
      rob_uop_1_25_fp_val <= io_enq_uops_1_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_1390) | ~rob_val_1_25) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_910)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_1_25_br_mask <= io_enq_uops_1_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_1_25_br_mask <= rob_uop_1_25_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_911) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_1_26_uopc <= io_enq_uops_1_uopc;	// rob.scala:310:28
      rob_uop_1_26_is_rvc <= io_enq_uops_1_is_rvc;	// rob.scala:310:28
      rob_uop_1_26_ftq_idx <= io_enq_uops_1_ftq_idx;	// rob.scala:310:28
      rob_uop_1_26_edge_inst <= io_enq_uops_1_edge_inst;	// rob.scala:310:28
      rob_uop_1_26_pc_lob <= io_enq_uops_1_pc_lob;	// rob.scala:310:28
      rob_uop_1_26_pdst <= io_enq_uops_1_pdst;	// rob.scala:310:28
      rob_uop_1_26_stale_pdst <= io_enq_uops_1_stale_pdst;	// rob.scala:310:28
      rob_uop_1_26_is_fencei <= io_enq_uops_1_is_fencei;	// rob.scala:310:28
      rob_uop_1_26_uses_ldq <= io_enq_uops_1_uses_ldq;	// rob.scala:310:28
      rob_uop_1_26_uses_stq <= io_enq_uops_1_uses_stq;	// rob.scala:310:28
      rob_uop_1_26_is_sys_pc2epc <= io_enq_uops_1_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_1_26_flush_on_commit <= io_enq_uops_1_flush_on_commit;	// rob.scala:310:28
      rob_uop_1_26_ldst <= io_enq_uops_1_ldst;	// rob.scala:310:28
      rob_uop_1_26_ldst_val <= io_enq_uops_1_ldst_val;	// rob.scala:310:28
      rob_uop_1_26_dst_rtype <= io_enq_uops_1_dst_rtype;	// rob.scala:310:28
      rob_uop_1_26_fp_val <= io_enq_uops_1_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_1391) | ~rob_val_1_26) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_911)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_1_26_br_mask <= io_enq_uops_1_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_1_26_br_mask <= rob_uop_1_26_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_912) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_1_27_uopc <= io_enq_uops_1_uopc;	// rob.scala:310:28
      rob_uop_1_27_is_rvc <= io_enq_uops_1_is_rvc;	// rob.scala:310:28
      rob_uop_1_27_ftq_idx <= io_enq_uops_1_ftq_idx;	// rob.scala:310:28
      rob_uop_1_27_edge_inst <= io_enq_uops_1_edge_inst;	// rob.scala:310:28
      rob_uop_1_27_pc_lob <= io_enq_uops_1_pc_lob;	// rob.scala:310:28
      rob_uop_1_27_pdst <= io_enq_uops_1_pdst;	// rob.scala:310:28
      rob_uop_1_27_stale_pdst <= io_enq_uops_1_stale_pdst;	// rob.scala:310:28
      rob_uop_1_27_is_fencei <= io_enq_uops_1_is_fencei;	// rob.scala:310:28
      rob_uop_1_27_uses_ldq <= io_enq_uops_1_uses_ldq;	// rob.scala:310:28
      rob_uop_1_27_uses_stq <= io_enq_uops_1_uses_stq;	// rob.scala:310:28
      rob_uop_1_27_is_sys_pc2epc <= io_enq_uops_1_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_1_27_flush_on_commit <= io_enq_uops_1_flush_on_commit;	// rob.scala:310:28
      rob_uop_1_27_ldst <= io_enq_uops_1_ldst;	// rob.scala:310:28
      rob_uop_1_27_ldst_val <= io_enq_uops_1_ldst_val;	// rob.scala:310:28
      rob_uop_1_27_dst_rtype <= io_enq_uops_1_dst_rtype;	// rob.scala:310:28
      rob_uop_1_27_fp_val <= io_enq_uops_1_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_1392) | ~rob_val_1_27) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_912)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_1_27_br_mask <= io_enq_uops_1_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_1_27_br_mask <= rob_uop_1_27_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_913) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_1_28_uopc <= io_enq_uops_1_uopc;	// rob.scala:310:28
      rob_uop_1_28_is_rvc <= io_enq_uops_1_is_rvc;	// rob.scala:310:28
      rob_uop_1_28_ftq_idx <= io_enq_uops_1_ftq_idx;	// rob.scala:310:28
      rob_uop_1_28_edge_inst <= io_enq_uops_1_edge_inst;	// rob.scala:310:28
      rob_uop_1_28_pc_lob <= io_enq_uops_1_pc_lob;	// rob.scala:310:28
      rob_uop_1_28_pdst <= io_enq_uops_1_pdst;	// rob.scala:310:28
      rob_uop_1_28_stale_pdst <= io_enq_uops_1_stale_pdst;	// rob.scala:310:28
      rob_uop_1_28_is_fencei <= io_enq_uops_1_is_fencei;	// rob.scala:310:28
      rob_uop_1_28_uses_ldq <= io_enq_uops_1_uses_ldq;	// rob.scala:310:28
      rob_uop_1_28_uses_stq <= io_enq_uops_1_uses_stq;	// rob.scala:310:28
      rob_uop_1_28_is_sys_pc2epc <= io_enq_uops_1_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_1_28_flush_on_commit <= io_enq_uops_1_flush_on_commit;	// rob.scala:310:28
      rob_uop_1_28_ldst <= io_enq_uops_1_ldst;	// rob.scala:310:28
      rob_uop_1_28_ldst_val <= io_enq_uops_1_ldst_val;	// rob.scala:310:28
      rob_uop_1_28_dst_rtype <= io_enq_uops_1_dst_rtype;	// rob.scala:310:28
      rob_uop_1_28_fp_val <= io_enq_uops_1_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_1393) | ~rob_val_1_28) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_913)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_1_28_br_mask <= io_enq_uops_1_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_1_28_br_mask <= rob_uop_1_28_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_914) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_1_29_uopc <= io_enq_uops_1_uopc;	// rob.scala:310:28
      rob_uop_1_29_is_rvc <= io_enq_uops_1_is_rvc;	// rob.scala:310:28
      rob_uop_1_29_ftq_idx <= io_enq_uops_1_ftq_idx;	// rob.scala:310:28
      rob_uop_1_29_edge_inst <= io_enq_uops_1_edge_inst;	// rob.scala:310:28
      rob_uop_1_29_pc_lob <= io_enq_uops_1_pc_lob;	// rob.scala:310:28
      rob_uop_1_29_pdst <= io_enq_uops_1_pdst;	// rob.scala:310:28
      rob_uop_1_29_stale_pdst <= io_enq_uops_1_stale_pdst;	// rob.scala:310:28
      rob_uop_1_29_is_fencei <= io_enq_uops_1_is_fencei;	// rob.scala:310:28
      rob_uop_1_29_uses_ldq <= io_enq_uops_1_uses_ldq;	// rob.scala:310:28
      rob_uop_1_29_uses_stq <= io_enq_uops_1_uses_stq;	// rob.scala:310:28
      rob_uop_1_29_is_sys_pc2epc <= io_enq_uops_1_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_1_29_flush_on_commit <= io_enq_uops_1_flush_on_commit;	// rob.scala:310:28
      rob_uop_1_29_ldst <= io_enq_uops_1_ldst;	// rob.scala:310:28
      rob_uop_1_29_ldst_val <= io_enq_uops_1_ldst_val;	// rob.scala:310:28
      rob_uop_1_29_dst_rtype <= io_enq_uops_1_dst_rtype;	// rob.scala:310:28
      rob_uop_1_29_fp_val <= io_enq_uops_1_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_1394) | ~rob_val_1_29) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_914)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_1_29_br_mask <= io_enq_uops_1_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_1_29_br_mask <= rob_uop_1_29_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_915) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_1_30_uopc <= io_enq_uops_1_uopc;	// rob.scala:310:28
      rob_uop_1_30_is_rvc <= io_enq_uops_1_is_rvc;	// rob.scala:310:28
      rob_uop_1_30_ftq_idx <= io_enq_uops_1_ftq_idx;	// rob.scala:310:28
      rob_uop_1_30_edge_inst <= io_enq_uops_1_edge_inst;	// rob.scala:310:28
      rob_uop_1_30_pc_lob <= io_enq_uops_1_pc_lob;	// rob.scala:310:28
      rob_uop_1_30_pdst <= io_enq_uops_1_pdst;	// rob.scala:310:28
      rob_uop_1_30_stale_pdst <= io_enq_uops_1_stale_pdst;	// rob.scala:310:28
      rob_uop_1_30_is_fencei <= io_enq_uops_1_is_fencei;	// rob.scala:310:28
      rob_uop_1_30_uses_ldq <= io_enq_uops_1_uses_ldq;	// rob.scala:310:28
      rob_uop_1_30_uses_stq <= io_enq_uops_1_uses_stq;	// rob.scala:310:28
      rob_uop_1_30_is_sys_pc2epc <= io_enq_uops_1_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_1_30_flush_on_commit <= io_enq_uops_1_flush_on_commit;	// rob.scala:310:28
      rob_uop_1_30_ldst <= io_enq_uops_1_ldst;	// rob.scala:310:28
      rob_uop_1_30_ldst_val <= io_enq_uops_1_ldst_val;	// rob.scala:310:28
      rob_uop_1_30_dst_rtype <= io_enq_uops_1_dst_rtype;	// rob.scala:310:28
      rob_uop_1_30_fp_val <= io_enq_uops_1_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_1395) | ~rob_val_1_30) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_915)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_1_30_br_mask <= io_enq_uops_1_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_1_30_br_mask <= rob_uop_1_30_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    if (_GEN_916) begin	// rob.scala:307:32, :323:29, :324:31
      rob_uop_1_31_uopc <= io_enq_uops_1_uopc;	// rob.scala:310:28
      rob_uop_1_31_is_rvc <= io_enq_uops_1_is_rvc;	// rob.scala:310:28
      rob_uop_1_31_ftq_idx <= io_enq_uops_1_ftq_idx;	// rob.scala:310:28
      rob_uop_1_31_edge_inst <= io_enq_uops_1_edge_inst;	// rob.scala:310:28
      rob_uop_1_31_pc_lob <= io_enq_uops_1_pc_lob;	// rob.scala:310:28
      rob_uop_1_31_pdst <= io_enq_uops_1_pdst;	// rob.scala:310:28
      rob_uop_1_31_stale_pdst <= io_enq_uops_1_stale_pdst;	// rob.scala:310:28
      rob_uop_1_31_is_fencei <= io_enq_uops_1_is_fencei;	// rob.scala:310:28
      rob_uop_1_31_uses_ldq <= io_enq_uops_1_uses_ldq;	// rob.scala:310:28
      rob_uop_1_31_uses_stq <= io_enq_uops_1_uses_stq;	// rob.scala:310:28
      rob_uop_1_31_is_sys_pc2epc <= io_enq_uops_1_is_sys_pc2epc;	// rob.scala:310:28
      rob_uop_1_31_flush_on_commit <= io_enq_uops_1_flush_on_commit;	// rob.scala:310:28
      rob_uop_1_31_ldst <= io_enq_uops_1_ldst;	// rob.scala:310:28
      rob_uop_1_31_ldst_val <= io_enq_uops_1_ldst_val;	// rob.scala:310:28
      rob_uop_1_31_dst_rtype <= io_enq_uops_1_dst_rtype;	// rob.scala:310:28
      rob_uop_1_31_fp_val <= io_enq_uops_1_fp_val;	// rob.scala:310:28
    end
    if ((|_GEN_1396) | ~rob_val_1_31) begin	// rob.scala:307:32, :323:29, :455:7, :458:32, util.scala:118:{51,59}
      if (_GEN_916)	// rob.scala:307:32, :323:29, :324:31
        rob_uop_1_31_br_mask <= io_enq_uops_1_br_mask;	// rob.scala:310:28
    end
    else	// rob.scala:323:29, :455:7, :458:32
      rob_uop_1_31_br_mask <= rob_uop_1_31_br_mask & ~io_brupdate_b1_resolve_mask;	// rob.scala:310:28, util.scala:89:{21,23}
    rob_exception_1_0 <=
      ~_GEN_1333
      & (_GEN_37 & _GEN_759 | (_GEN_885 ? io_enq_uops_1_exception : rob_exception_1_0));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_1_1 <=
      ~_GEN_1334
      & (_GEN_37 & _GEN_760 | (_GEN_886 ? io_enq_uops_1_exception : rob_exception_1_1));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_1_2 <=
      ~_GEN_1335
      & (_GEN_37 & _GEN_761 | (_GEN_887 ? io_enq_uops_1_exception : rob_exception_1_2));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_1_3 <=
      ~_GEN_1336
      & (_GEN_37 & _GEN_762 | (_GEN_888 ? io_enq_uops_1_exception : rob_exception_1_3));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_1_4 <=
      ~_GEN_1337
      & (_GEN_37 & _GEN_763 | (_GEN_889 ? io_enq_uops_1_exception : rob_exception_1_4));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_1_5 <=
      ~_GEN_1338
      & (_GEN_37 & _GEN_764 | (_GEN_890 ? io_enq_uops_1_exception : rob_exception_1_5));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_1_6 <=
      ~_GEN_1339
      & (_GEN_37 & _GEN_765 | (_GEN_891 ? io_enq_uops_1_exception : rob_exception_1_6));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_1_7 <=
      ~_GEN_1340
      & (_GEN_37 & _GEN_766 | (_GEN_892 ? io_enq_uops_1_exception : rob_exception_1_7));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_1_8 <=
      ~_GEN_1341
      & (_GEN_37 & _GEN_767 | (_GEN_893 ? io_enq_uops_1_exception : rob_exception_1_8));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_1_9 <=
      ~_GEN_1342
      & (_GEN_37 & _GEN_768 | (_GEN_894 ? io_enq_uops_1_exception : rob_exception_1_9));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_1_10 <=
      ~_GEN_1343
      & (_GEN_37 & _GEN_769 | (_GEN_895 ? io_enq_uops_1_exception : rob_exception_1_10));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_1_11 <=
      ~_GEN_1344
      & (_GEN_37 & _GEN_770 | (_GEN_896 ? io_enq_uops_1_exception : rob_exception_1_11));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_1_12 <=
      ~_GEN_1345
      & (_GEN_37 & _GEN_771 | (_GEN_897 ? io_enq_uops_1_exception : rob_exception_1_12));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_1_13 <=
      ~_GEN_1346
      & (_GEN_37 & _GEN_772 | (_GEN_898 ? io_enq_uops_1_exception : rob_exception_1_13));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_1_14 <=
      ~_GEN_1347
      & (_GEN_37 & _GEN_773 | (_GEN_899 ? io_enq_uops_1_exception : rob_exception_1_14));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_1_15 <=
      ~_GEN_1348
      & (_GEN_37 & _GEN_774 | (_GEN_900 ? io_enq_uops_1_exception : rob_exception_1_15));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_1_16 <=
      ~_GEN_1349
      & (_GEN_37 & _GEN_775 | (_GEN_901 ? io_enq_uops_1_exception : rob_exception_1_16));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_1_17 <=
      ~_GEN_1350
      & (_GEN_37 & _GEN_776 | (_GEN_902 ? io_enq_uops_1_exception : rob_exception_1_17));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_1_18 <=
      ~_GEN_1351
      & (_GEN_37 & _GEN_777 | (_GEN_903 ? io_enq_uops_1_exception : rob_exception_1_18));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_1_19 <=
      ~_GEN_1352
      & (_GEN_37 & _GEN_778 | (_GEN_904 ? io_enq_uops_1_exception : rob_exception_1_19));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_1_20 <=
      ~_GEN_1353
      & (_GEN_37 & _GEN_779 | (_GEN_905 ? io_enq_uops_1_exception : rob_exception_1_20));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_1_21 <=
      ~_GEN_1354
      & (_GEN_37 & _GEN_780 | (_GEN_906 ? io_enq_uops_1_exception : rob_exception_1_21));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_1_22 <=
      ~_GEN_1355
      & (_GEN_37 & _GEN_781 | (_GEN_907 ? io_enq_uops_1_exception : rob_exception_1_22));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_1_23 <=
      ~_GEN_1356
      & (_GEN_37 & _GEN_782 | (_GEN_908 ? io_enq_uops_1_exception : rob_exception_1_23));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_1_24 <=
      ~_GEN_1357
      & (_GEN_37 & _GEN_783 | (_GEN_909 ? io_enq_uops_1_exception : rob_exception_1_24));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_1_25 <=
      ~_GEN_1358
      & (_GEN_37 & _GEN_784 | (_GEN_910 ? io_enq_uops_1_exception : rob_exception_1_25));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_1_26 <=
      ~_GEN_1359
      & (_GEN_37 & _GEN_785 | (_GEN_911 ? io_enq_uops_1_exception : rob_exception_1_26));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_1_27 <=
      ~_GEN_1360
      & (_GEN_37 & _GEN_786 | (_GEN_912 ? io_enq_uops_1_exception : rob_exception_1_27));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_1_28 <=
      ~_GEN_1361
      & (_GEN_37 & _GEN_787 | (_GEN_913 ? io_enq_uops_1_exception : rob_exception_1_28));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_1_29 <=
      ~_GEN_1362
      & (_GEN_37 & _GEN_788 | (_GEN_914 ? io_enq_uops_1_exception : rob_exception_1_29));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_1_30 <=
      ~_GEN_1363
      & (_GEN_37 & _GEN_789 | (_GEN_915 ? io_enq_uops_1_exception : rob_exception_1_30));	// rob.scala:307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_exception_1_31 <=
      ~_GEN_1364
      & (_GEN_37 & (&(io_lxcpt_bits_uop_rob_idx[5:1]))
         | (_GEN_916 ? io_enq_uops_1_exception : rob_exception_1_31));	// rob.scala:268:25, :307:32, :311:28, :323:29, :324:31, :329:31, :390:{26,79}, :391:59, :433:20, :434:30, :435:30
    rob_predicated_1_0 <=
      ~_GEN_1237
      & (_GEN_32 & _GEN_443
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_1109 | _GEN_30 & _GEN_253)
             & (_GEN_981
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_885 & rob_predicated_1_0));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_1_1 <=
      ~_GEN_1238
      & (_GEN_32 & _GEN_446
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_1110 | _GEN_30 & _GEN_256)
             & (_GEN_982
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_886 & rob_predicated_1_1));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_1_2 <=
      ~_GEN_1239
      & (_GEN_32 & _GEN_449
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_1111 | _GEN_30 & _GEN_259)
             & (_GEN_983
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_887 & rob_predicated_1_2));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_1_3 <=
      ~_GEN_1240
      & (_GEN_32 & _GEN_452
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_1112 | _GEN_30 & _GEN_262)
             & (_GEN_984
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_888 & rob_predicated_1_3));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_1_4 <=
      ~_GEN_1241
      & (_GEN_32 & _GEN_455
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_1113 | _GEN_30 & _GEN_265)
             & (_GEN_985
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_889 & rob_predicated_1_4));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_1_5 <=
      ~_GEN_1242
      & (_GEN_32 & _GEN_458
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_1114 | _GEN_30 & _GEN_268)
             & (_GEN_986
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_890 & rob_predicated_1_5));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_1_6 <=
      ~_GEN_1243
      & (_GEN_32 & _GEN_461
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_1115 | _GEN_30 & _GEN_271)
             & (_GEN_987
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_891 & rob_predicated_1_6));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_1_7 <=
      ~_GEN_1244
      & (_GEN_32 & _GEN_464
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_1116 | _GEN_30 & _GEN_274)
             & (_GEN_988
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_892 & rob_predicated_1_7));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_1_8 <=
      ~_GEN_1245
      & (_GEN_32 & _GEN_467
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_1117 | _GEN_30 & _GEN_277)
             & (_GEN_989
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_893 & rob_predicated_1_8));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_1_9 <=
      ~_GEN_1246
      & (_GEN_32 & _GEN_470
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_1118 | _GEN_30 & _GEN_280)
             & (_GEN_990
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_894 & rob_predicated_1_9));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_1_10 <=
      ~_GEN_1247
      & (_GEN_32 & _GEN_473
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_1119 | _GEN_30 & _GEN_283)
             & (_GEN_991
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_895 & rob_predicated_1_10));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_1_11 <=
      ~_GEN_1248
      & (_GEN_32 & _GEN_476
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_1120 | _GEN_30 & _GEN_286)
             & (_GEN_992
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_896 & rob_predicated_1_11));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_1_12 <=
      ~_GEN_1249
      & (_GEN_32 & _GEN_479
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_1121 | _GEN_30 & _GEN_289)
             & (_GEN_993
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_897 & rob_predicated_1_12));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_1_13 <=
      ~_GEN_1250
      & (_GEN_32 & _GEN_482
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_1122 | _GEN_30 & _GEN_292)
             & (_GEN_994
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_898 & rob_predicated_1_13));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_1_14 <=
      ~_GEN_1251
      & (_GEN_32 & _GEN_485
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_1123 | _GEN_30 & _GEN_295)
             & (_GEN_995
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_899 & rob_predicated_1_14));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_1_15 <=
      ~_GEN_1252
      & (_GEN_32 & _GEN_488
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_1124 | _GEN_30 & _GEN_298)
             & (_GEN_996
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_900 & rob_predicated_1_15));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_1_16 <=
      ~_GEN_1253
      & (_GEN_32 & _GEN_491
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_1125 | _GEN_30 & _GEN_301)
             & (_GEN_997
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_901 & rob_predicated_1_16));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_1_17 <=
      ~_GEN_1254
      & (_GEN_32 & _GEN_494
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_1126 | _GEN_30 & _GEN_304)
             & (_GEN_998
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_902 & rob_predicated_1_17));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_1_18 <=
      ~_GEN_1255
      & (_GEN_32 & _GEN_497
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_1127 | _GEN_30 & _GEN_307)
             & (_GEN_999
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_903 & rob_predicated_1_18));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_1_19 <=
      ~_GEN_1256
      & (_GEN_32 & _GEN_500
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_1128 | _GEN_30 & _GEN_310)
             & (_GEN_1000
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_904 & rob_predicated_1_19));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_1_20 <=
      ~_GEN_1257
      & (_GEN_32 & _GEN_503
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_1129 | _GEN_30 & _GEN_313)
             & (_GEN_1001
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_905 & rob_predicated_1_20));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_1_21 <=
      ~_GEN_1258
      & (_GEN_32 & _GEN_506
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_1130 | _GEN_30 & _GEN_316)
             & (_GEN_1002
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_906 & rob_predicated_1_21));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_1_22 <=
      ~_GEN_1259
      & (_GEN_32 & _GEN_509
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_1131 | _GEN_30 & _GEN_319)
             & (_GEN_1003
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_907 & rob_predicated_1_22));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_1_23 <=
      ~_GEN_1260
      & (_GEN_32 & _GEN_512
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_1132 | _GEN_30 & _GEN_322)
             & (_GEN_1004
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_908 & rob_predicated_1_23));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_1_24 <=
      ~_GEN_1261
      & (_GEN_32 & _GEN_515
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_1133 | _GEN_30 & _GEN_325)
             & (_GEN_1005
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_909 & rob_predicated_1_24));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_1_25 <=
      ~_GEN_1262
      & (_GEN_32 & _GEN_518
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_1134 | _GEN_30 & _GEN_328)
             & (_GEN_1006
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_910 & rob_predicated_1_25));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_1_26 <=
      ~_GEN_1263
      & (_GEN_32 & _GEN_521
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_1135 | _GEN_30 & _GEN_331)
             & (_GEN_1007
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_911 & rob_predicated_1_26));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_1_27 <=
      ~_GEN_1264
      & (_GEN_32 & _GEN_524
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_1136 | _GEN_30 & _GEN_334)
             & (_GEN_1008
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_912 & rob_predicated_1_27));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_1_28 <=
      ~_GEN_1265
      & (_GEN_32 & _GEN_527
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_1137 | _GEN_30 & _GEN_337)
             & (_GEN_1009
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_913 & rob_predicated_1_28));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_1_29 <=
      ~_GEN_1266
      & (_GEN_32 & _GEN_530
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_1138 | _GEN_30 & _GEN_340)
             & (_GEN_1010
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_914 & rob_predicated_1_29));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_1_30 <=
      ~_GEN_1267
      & (_GEN_32 & _GEN_533
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_1139 | _GEN_30 & _GEN_343)
             & (_GEN_1011
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_915 & rob_predicated_1_30));	// rob.scala:307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    rob_predicated_1_31 <=
      ~_GEN_1268
      & (_GEN_32 & (&(io_wb_resps_3_bits_uop_rob_idx[5:1]))
           ? io_wb_resps_3_bits_predicated
           : ~(_GEN_1140 | _GEN_30 & (&(io_wb_resps_1_bits_uop_rob_idx[5:1])))
             & (_GEN_1012
                  ? io_wb_resps_0_bits_predicated
                  : ~_GEN_916 & rob_predicated_1_31));	// rob.scala:268:25, :307:32, :312:29, :323:29, :324:31, :330:34, :346:{27,69}, :347:31, :349:34
    block_commit_REG <= exception_thrown;	// rob.scala:540:94, :545:85
    block_commit_REG_1 <= exception_thrown;	// rob.scala:540:131, :545:85
    block_commit_REG_2 <= block_commit_REG_1;	// rob.scala:540:{123,131}
    REG <= exception_thrown;	// rob.scala:545:85, :808:30
    REG_1 <= REG;	// rob.scala:808:{22,30}
    REG_2 <= exception_thrown;	// rob.scala:545:85, :824:22
    io_com_load_is_at_rob_head_REG <=
      (rob_head_vals_0 ? _GEN_20[rob_head] : _GEN_49[rob_head])
      & ~(will_commit_0 | will_commit_1);	// rob.scala:224:29, :301:84, :398:49, :411:25, :484:26, :547:70, :865:{40,98}, :866:41
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:830];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [9:0] i = 10'h0; i < 10'h33F; i += 10'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        rob_state = _RANDOM[10'h0][1:0];	// rob.scala:221:26
        rob_head = _RANDOM[10'h0][6:2];	// rob.scala:221:26, :224:29
        rob_head_lsb = _RANDOM[10'h0][7];	// rob.scala:221:26, :225:29
        rob_tail = _RANDOM[10'h0][12:8];	// rob.scala:221:26, :228:29
        rob_tail_lsb = _RANDOM[10'h0][13];	// rob.scala:221:26, :229:29
        rob_pnr = _RANDOM[10'h0][18:14];	// rob.scala:221:26, :232:29
        rob_pnr_lsb = _RANDOM[10'h0][19];	// rob.scala:221:26, :233:29
        maybe_full = _RANDOM[10'h0][20];	// rob.scala:221:26, :239:29
        r_xcpt_val = _RANDOM[10'h0][21];	// rob.scala:221:26, :258:33
        r_xcpt_uop_br_mask = _RANDOM[10'h5][29:18];	// rob.scala:259:29
        r_xcpt_uop_rob_idx = _RANDOM[10'h7][20:15];	// rob.scala:259:29
        r_xcpt_uop_exc_cause =
          {_RANDOM[10'h9][31:12], _RANDOM[10'hA], _RANDOM[10'hB][11:0]};	// rob.scala:259:29
        r_xcpt_badvaddr = {_RANDOM[10'hD][31:9], _RANDOM[10'hE][16:0]};	// rob.scala:260:29
        rob_val_0 = _RANDOM[10'hE][17];	// rob.scala:260:29, :307:32
        rob_val_1 = _RANDOM[10'hE][18];	// rob.scala:260:29, :307:32
        rob_val_2 = _RANDOM[10'hE][19];	// rob.scala:260:29, :307:32
        rob_val_3 = _RANDOM[10'hE][20];	// rob.scala:260:29, :307:32
        rob_val_4 = _RANDOM[10'hE][21];	// rob.scala:260:29, :307:32
        rob_val_5 = _RANDOM[10'hE][22];	// rob.scala:260:29, :307:32
        rob_val_6 = _RANDOM[10'hE][23];	// rob.scala:260:29, :307:32
        rob_val_7 = _RANDOM[10'hE][24];	// rob.scala:260:29, :307:32
        rob_val_8 = _RANDOM[10'hE][25];	// rob.scala:260:29, :307:32
        rob_val_9 = _RANDOM[10'hE][26];	// rob.scala:260:29, :307:32
        rob_val_10 = _RANDOM[10'hE][27];	// rob.scala:260:29, :307:32
        rob_val_11 = _RANDOM[10'hE][28];	// rob.scala:260:29, :307:32
        rob_val_12 = _RANDOM[10'hE][29];	// rob.scala:260:29, :307:32
        rob_val_13 = _RANDOM[10'hE][30];	// rob.scala:260:29, :307:32
        rob_val_14 = _RANDOM[10'hE][31];	// rob.scala:260:29, :307:32
        rob_val_15 = _RANDOM[10'hF][0];	// rob.scala:307:32
        rob_val_16 = _RANDOM[10'hF][1];	// rob.scala:307:32
        rob_val_17 = _RANDOM[10'hF][2];	// rob.scala:307:32
        rob_val_18 = _RANDOM[10'hF][3];	// rob.scala:307:32
        rob_val_19 = _RANDOM[10'hF][4];	// rob.scala:307:32
        rob_val_20 = _RANDOM[10'hF][5];	// rob.scala:307:32
        rob_val_21 = _RANDOM[10'hF][6];	// rob.scala:307:32
        rob_val_22 = _RANDOM[10'hF][7];	// rob.scala:307:32
        rob_val_23 = _RANDOM[10'hF][8];	// rob.scala:307:32
        rob_val_24 = _RANDOM[10'hF][9];	// rob.scala:307:32
        rob_val_25 = _RANDOM[10'hF][10];	// rob.scala:307:32
        rob_val_26 = _RANDOM[10'hF][11];	// rob.scala:307:32
        rob_val_27 = _RANDOM[10'hF][12];	// rob.scala:307:32
        rob_val_28 = _RANDOM[10'hF][13];	// rob.scala:307:32
        rob_val_29 = _RANDOM[10'hF][14];	// rob.scala:307:32
        rob_val_30 = _RANDOM[10'hF][15];	// rob.scala:307:32
        rob_val_31 = _RANDOM[10'hF][16];	// rob.scala:307:32
        rob_bsy_0 = _RANDOM[10'hF][17];	// rob.scala:307:32, :308:28
        rob_bsy_1 = _RANDOM[10'hF][18];	// rob.scala:307:32, :308:28
        rob_bsy_2 = _RANDOM[10'hF][19];	// rob.scala:307:32, :308:28
        rob_bsy_3 = _RANDOM[10'hF][20];	// rob.scala:307:32, :308:28
        rob_bsy_4 = _RANDOM[10'hF][21];	// rob.scala:307:32, :308:28
        rob_bsy_5 = _RANDOM[10'hF][22];	// rob.scala:307:32, :308:28
        rob_bsy_6 = _RANDOM[10'hF][23];	// rob.scala:307:32, :308:28
        rob_bsy_7 = _RANDOM[10'hF][24];	// rob.scala:307:32, :308:28
        rob_bsy_8 = _RANDOM[10'hF][25];	// rob.scala:307:32, :308:28
        rob_bsy_9 = _RANDOM[10'hF][26];	// rob.scala:307:32, :308:28
        rob_bsy_10 = _RANDOM[10'hF][27];	// rob.scala:307:32, :308:28
        rob_bsy_11 = _RANDOM[10'hF][28];	// rob.scala:307:32, :308:28
        rob_bsy_12 = _RANDOM[10'hF][29];	// rob.scala:307:32, :308:28
        rob_bsy_13 = _RANDOM[10'hF][30];	// rob.scala:307:32, :308:28
        rob_bsy_14 = _RANDOM[10'hF][31];	// rob.scala:307:32, :308:28
        rob_bsy_15 = _RANDOM[10'h10][0];	// rob.scala:308:28
        rob_bsy_16 = _RANDOM[10'h10][1];	// rob.scala:308:28
        rob_bsy_17 = _RANDOM[10'h10][2];	// rob.scala:308:28
        rob_bsy_18 = _RANDOM[10'h10][3];	// rob.scala:308:28
        rob_bsy_19 = _RANDOM[10'h10][4];	// rob.scala:308:28
        rob_bsy_20 = _RANDOM[10'h10][5];	// rob.scala:308:28
        rob_bsy_21 = _RANDOM[10'h10][6];	// rob.scala:308:28
        rob_bsy_22 = _RANDOM[10'h10][7];	// rob.scala:308:28
        rob_bsy_23 = _RANDOM[10'h10][8];	// rob.scala:308:28
        rob_bsy_24 = _RANDOM[10'h10][9];	// rob.scala:308:28
        rob_bsy_25 = _RANDOM[10'h10][10];	// rob.scala:308:28
        rob_bsy_26 = _RANDOM[10'h10][11];	// rob.scala:308:28
        rob_bsy_27 = _RANDOM[10'h10][12];	// rob.scala:308:28
        rob_bsy_28 = _RANDOM[10'h10][13];	// rob.scala:308:28
        rob_bsy_29 = _RANDOM[10'h10][14];	// rob.scala:308:28
        rob_bsy_30 = _RANDOM[10'h10][15];	// rob.scala:308:28
        rob_bsy_31 = _RANDOM[10'h10][16];	// rob.scala:308:28
        rob_unsafe_0 = _RANDOM[10'h10][17];	// rob.scala:308:28, :309:28
        rob_unsafe_1 = _RANDOM[10'h10][18];	// rob.scala:308:28, :309:28
        rob_unsafe_2 = _RANDOM[10'h10][19];	// rob.scala:308:28, :309:28
        rob_unsafe_3 = _RANDOM[10'h10][20];	// rob.scala:308:28, :309:28
        rob_unsafe_4 = _RANDOM[10'h10][21];	// rob.scala:308:28, :309:28
        rob_unsafe_5 = _RANDOM[10'h10][22];	// rob.scala:308:28, :309:28
        rob_unsafe_6 = _RANDOM[10'h10][23];	// rob.scala:308:28, :309:28
        rob_unsafe_7 = _RANDOM[10'h10][24];	// rob.scala:308:28, :309:28
        rob_unsafe_8 = _RANDOM[10'h10][25];	// rob.scala:308:28, :309:28
        rob_unsafe_9 = _RANDOM[10'h10][26];	// rob.scala:308:28, :309:28
        rob_unsafe_10 = _RANDOM[10'h10][27];	// rob.scala:308:28, :309:28
        rob_unsafe_11 = _RANDOM[10'h10][28];	// rob.scala:308:28, :309:28
        rob_unsafe_12 = _RANDOM[10'h10][29];	// rob.scala:308:28, :309:28
        rob_unsafe_13 = _RANDOM[10'h10][30];	// rob.scala:308:28, :309:28
        rob_unsafe_14 = _RANDOM[10'h10][31];	// rob.scala:308:28, :309:28
        rob_unsafe_15 = _RANDOM[10'h11][0];	// rob.scala:309:28
        rob_unsafe_16 = _RANDOM[10'h11][1];	// rob.scala:309:28
        rob_unsafe_17 = _RANDOM[10'h11][2];	// rob.scala:309:28
        rob_unsafe_18 = _RANDOM[10'h11][3];	// rob.scala:309:28
        rob_unsafe_19 = _RANDOM[10'h11][4];	// rob.scala:309:28
        rob_unsafe_20 = _RANDOM[10'h11][5];	// rob.scala:309:28
        rob_unsafe_21 = _RANDOM[10'h11][6];	// rob.scala:309:28
        rob_unsafe_22 = _RANDOM[10'h11][7];	// rob.scala:309:28
        rob_unsafe_23 = _RANDOM[10'h11][8];	// rob.scala:309:28
        rob_unsafe_24 = _RANDOM[10'h11][9];	// rob.scala:309:28
        rob_unsafe_25 = _RANDOM[10'h11][10];	// rob.scala:309:28
        rob_unsafe_26 = _RANDOM[10'h11][11];	// rob.scala:309:28
        rob_unsafe_27 = _RANDOM[10'h11][12];	// rob.scala:309:28
        rob_unsafe_28 = _RANDOM[10'h11][13];	// rob.scala:309:28
        rob_unsafe_29 = _RANDOM[10'h11][14];	// rob.scala:309:28
        rob_unsafe_30 = _RANDOM[10'h11][15];	// rob.scala:309:28
        rob_unsafe_31 = _RANDOM[10'h11][16];	// rob.scala:309:28
        rob_uop_0_uopc = _RANDOM[10'h11][23:17];	// rob.scala:309:28, :310:28
        rob_uop_0_is_rvc = _RANDOM[10'h13][24];	// rob.scala:310:28
        rob_uop_0_br_mask = _RANDOM[10'h16][24:13];	// rob.scala:310:28
        rob_uop_0_ftq_idx = {_RANDOM[10'h16][31:29], _RANDOM[10'h17][1:0]};	// rob.scala:310:28
        rob_uop_0_edge_inst = _RANDOM[10'h17][2];	// rob.scala:310:28
        rob_uop_0_pc_lob = _RANDOM[10'h17][8:3];	// rob.scala:310:28
        rob_uop_0_pdst = {_RANDOM[10'h18][31:26], _RANDOM[10'h19][0]};	// rob.scala:310:28
        rob_uop_0_stale_pdst = {_RANDOM[10'h19][31], _RANDOM[10'h1A][5:0]};	// rob.scala:310:28
        rob_uop_0_is_fencei = _RANDOM[10'h1C][17];	// rob.scala:310:28
        rob_uop_0_uses_ldq = _RANDOM[10'h1C][19];	// rob.scala:310:28
        rob_uop_0_uses_stq = _RANDOM[10'h1C][20];	// rob.scala:310:28
        rob_uop_0_is_sys_pc2epc = _RANDOM[10'h1C][21];	// rob.scala:310:28
        rob_uop_0_flush_on_commit = _RANDOM[10'h1C][23];	// rob.scala:310:28
        rob_uop_0_ldst = _RANDOM[10'h1C][30:25];	// rob.scala:310:28
        rob_uop_0_ldst_val = _RANDOM[10'h1D][17];	// rob.scala:310:28
        rob_uop_0_dst_rtype = _RANDOM[10'h1D][19:18];	// rob.scala:310:28
        rob_uop_0_fp_val = _RANDOM[10'h1D][25];	// rob.scala:310:28
        rob_uop_1_uopc = _RANDOM[10'h1E][10:4];	// rob.scala:310:28
        rob_uop_1_is_rvc = _RANDOM[10'h20][11];	// rob.scala:310:28
        rob_uop_1_br_mask = _RANDOM[10'h23][11:0];	// rob.scala:310:28
        rob_uop_1_ftq_idx = _RANDOM[10'h23][20:16];	// rob.scala:310:28
        rob_uop_1_edge_inst = _RANDOM[10'h23][21];	// rob.scala:310:28
        rob_uop_1_pc_lob = _RANDOM[10'h23][27:22];	// rob.scala:310:28
        rob_uop_1_pdst = _RANDOM[10'h25][19:13];	// rob.scala:310:28
        rob_uop_1_stale_pdst = _RANDOM[10'h26][24:18];	// rob.scala:310:28
        rob_uop_1_is_fencei = _RANDOM[10'h29][4];	// rob.scala:310:28
        rob_uop_1_uses_ldq = _RANDOM[10'h29][6];	// rob.scala:310:28
        rob_uop_1_uses_stq = _RANDOM[10'h29][7];	// rob.scala:310:28
        rob_uop_1_is_sys_pc2epc = _RANDOM[10'h29][8];	// rob.scala:310:28
        rob_uop_1_flush_on_commit = _RANDOM[10'h29][10];	// rob.scala:310:28
        rob_uop_1_ldst = _RANDOM[10'h29][17:12];	// rob.scala:310:28
        rob_uop_1_ldst_val = _RANDOM[10'h2A][4];	// rob.scala:310:28
        rob_uop_1_dst_rtype = _RANDOM[10'h2A][6:5];	// rob.scala:310:28
        rob_uop_1_fp_val = _RANDOM[10'h2A][12];	// rob.scala:310:28
        rob_uop_2_uopc = _RANDOM[10'h2A][29:23];	// rob.scala:310:28
        rob_uop_2_is_rvc = _RANDOM[10'h2C][30];	// rob.scala:310:28
        rob_uop_2_br_mask = _RANDOM[10'h2F][30:19];	// rob.scala:310:28
        rob_uop_2_ftq_idx = _RANDOM[10'h30][7:3];	// rob.scala:310:28
        rob_uop_2_edge_inst = _RANDOM[10'h30][8];	// rob.scala:310:28
        rob_uop_2_pc_lob = _RANDOM[10'h30][14:9];	// rob.scala:310:28
        rob_uop_2_pdst = _RANDOM[10'h32][6:0];	// rob.scala:310:28
        rob_uop_2_stale_pdst = _RANDOM[10'h33][11:5];	// rob.scala:310:28
        rob_uop_2_is_fencei = _RANDOM[10'h35][23];	// rob.scala:310:28
        rob_uop_2_uses_ldq = _RANDOM[10'h35][25];	// rob.scala:310:28
        rob_uop_2_uses_stq = _RANDOM[10'h35][26];	// rob.scala:310:28
        rob_uop_2_is_sys_pc2epc = _RANDOM[10'h35][27];	// rob.scala:310:28
        rob_uop_2_flush_on_commit = _RANDOM[10'h35][29];	// rob.scala:310:28
        rob_uop_2_ldst = {_RANDOM[10'h35][31], _RANDOM[10'h36][4:0]};	// rob.scala:310:28
        rob_uop_2_ldst_val = _RANDOM[10'h36][23];	// rob.scala:310:28
        rob_uop_2_dst_rtype = _RANDOM[10'h36][25:24];	// rob.scala:310:28
        rob_uop_2_fp_val = _RANDOM[10'h36][31];	// rob.scala:310:28
        rob_uop_3_uopc = _RANDOM[10'h37][16:10];	// rob.scala:310:28
        rob_uop_3_is_rvc = _RANDOM[10'h39][17];	// rob.scala:310:28
        rob_uop_3_br_mask = _RANDOM[10'h3C][17:6];	// rob.scala:310:28
        rob_uop_3_ftq_idx = _RANDOM[10'h3C][26:22];	// rob.scala:310:28
        rob_uop_3_edge_inst = _RANDOM[10'h3C][27];	// rob.scala:310:28
        rob_uop_3_pc_lob = {_RANDOM[10'h3C][31:28], _RANDOM[10'h3D][1:0]};	// rob.scala:310:28
        rob_uop_3_pdst = _RANDOM[10'h3E][25:19];	// rob.scala:310:28
        rob_uop_3_stale_pdst = _RANDOM[10'h3F][30:24];	// rob.scala:310:28
        rob_uop_3_is_fencei = _RANDOM[10'h42][10];	// rob.scala:310:28
        rob_uop_3_uses_ldq = _RANDOM[10'h42][12];	// rob.scala:310:28
        rob_uop_3_uses_stq = _RANDOM[10'h42][13];	// rob.scala:310:28
        rob_uop_3_is_sys_pc2epc = _RANDOM[10'h42][14];	// rob.scala:310:28
        rob_uop_3_flush_on_commit = _RANDOM[10'h42][16];	// rob.scala:310:28
        rob_uop_3_ldst = _RANDOM[10'h42][23:18];	// rob.scala:310:28
        rob_uop_3_ldst_val = _RANDOM[10'h43][10];	// rob.scala:310:28
        rob_uop_3_dst_rtype = _RANDOM[10'h43][12:11];	// rob.scala:310:28
        rob_uop_3_fp_val = _RANDOM[10'h43][18];	// rob.scala:310:28
        rob_uop_4_uopc = {_RANDOM[10'h43][31:29], _RANDOM[10'h44][3:0]};	// rob.scala:310:28
        rob_uop_4_is_rvc = _RANDOM[10'h46][4];	// rob.scala:310:28
        rob_uop_4_br_mask = {_RANDOM[10'h48][31:25], _RANDOM[10'h49][4:0]};	// rob.scala:310:28
        rob_uop_4_ftq_idx = _RANDOM[10'h49][13:9];	// rob.scala:310:28
        rob_uop_4_edge_inst = _RANDOM[10'h49][14];	// rob.scala:310:28
        rob_uop_4_pc_lob = _RANDOM[10'h49][20:15];	// rob.scala:310:28
        rob_uop_4_pdst = _RANDOM[10'h4B][12:6];	// rob.scala:310:28
        rob_uop_4_stale_pdst = _RANDOM[10'h4C][17:11];	// rob.scala:310:28
        rob_uop_4_is_fencei = _RANDOM[10'h4E][29];	// rob.scala:310:28
        rob_uop_4_uses_ldq = _RANDOM[10'h4E][31];	// rob.scala:310:28
        rob_uop_4_uses_stq = _RANDOM[10'h4F][0];	// rob.scala:310:28
        rob_uop_4_is_sys_pc2epc = _RANDOM[10'h4F][1];	// rob.scala:310:28
        rob_uop_4_flush_on_commit = _RANDOM[10'h4F][3];	// rob.scala:310:28
        rob_uop_4_ldst = _RANDOM[10'h4F][10:5];	// rob.scala:310:28
        rob_uop_4_ldst_val = _RANDOM[10'h4F][29];	// rob.scala:310:28
        rob_uop_4_dst_rtype = _RANDOM[10'h4F][31:30];	// rob.scala:310:28
        rob_uop_4_fp_val = _RANDOM[10'h50][5];	// rob.scala:310:28
        rob_uop_5_uopc = _RANDOM[10'h50][22:16];	// rob.scala:310:28
        rob_uop_5_is_rvc = _RANDOM[10'h52][23];	// rob.scala:310:28
        rob_uop_5_br_mask = _RANDOM[10'h55][23:12];	// rob.scala:310:28
        rob_uop_5_ftq_idx = {_RANDOM[10'h55][31:28], _RANDOM[10'h56][0]};	// rob.scala:310:28
        rob_uop_5_edge_inst = _RANDOM[10'h56][1];	// rob.scala:310:28
        rob_uop_5_pc_lob = _RANDOM[10'h56][7:2];	// rob.scala:310:28
        rob_uop_5_pdst = _RANDOM[10'h57][31:25];	// rob.scala:310:28
        rob_uop_5_stale_pdst = {_RANDOM[10'h58][31:30], _RANDOM[10'h59][4:0]};	// rob.scala:310:28
        rob_uop_5_is_fencei = _RANDOM[10'h5B][16];	// rob.scala:310:28
        rob_uop_5_uses_ldq = _RANDOM[10'h5B][18];	// rob.scala:310:28
        rob_uop_5_uses_stq = _RANDOM[10'h5B][19];	// rob.scala:310:28
        rob_uop_5_is_sys_pc2epc = _RANDOM[10'h5B][20];	// rob.scala:310:28
        rob_uop_5_flush_on_commit = _RANDOM[10'h5B][22];	// rob.scala:310:28
        rob_uop_5_ldst = _RANDOM[10'h5B][29:24];	// rob.scala:310:28
        rob_uop_5_ldst_val = _RANDOM[10'h5C][16];	// rob.scala:310:28
        rob_uop_5_dst_rtype = _RANDOM[10'h5C][18:17];	// rob.scala:310:28
        rob_uop_5_fp_val = _RANDOM[10'h5C][24];	// rob.scala:310:28
        rob_uop_6_uopc = _RANDOM[10'h5D][9:3];	// rob.scala:310:28
        rob_uop_6_is_rvc = _RANDOM[10'h5F][10];	// rob.scala:310:28
        rob_uop_6_br_mask = {_RANDOM[10'h61][31], _RANDOM[10'h62][10:0]};	// rob.scala:310:28
        rob_uop_6_ftq_idx = _RANDOM[10'h62][19:15];	// rob.scala:310:28
        rob_uop_6_edge_inst = _RANDOM[10'h62][20];	// rob.scala:310:28
        rob_uop_6_pc_lob = _RANDOM[10'h62][26:21];	// rob.scala:310:28
        rob_uop_6_pdst = _RANDOM[10'h64][18:12];	// rob.scala:310:28
        rob_uop_6_stale_pdst = _RANDOM[10'h65][23:17];	// rob.scala:310:28
        rob_uop_6_is_fencei = _RANDOM[10'h68][3];	// rob.scala:310:28
        rob_uop_6_uses_ldq = _RANDOM[10'h68][5];	// rob.scala:310:28
        rob_uop_6_uses_stq = _RANDOM[10'h68][6];	// rob.scala:310:28
        rob_uop_6_is_sys_pc2epc = _RANDOM[10'h68][7];	// rob.scala:310:28
        rob_uop_6_flush_on_commit = _RANDOM[10'h68][9];	// rob.scala:310:28
        rob_uop_6_ldst = _RANDOM[10'h68][16:11];	// rob.scala:310:28
        rob_uop_6_ldst_val = _RANDOM[10'h69][3];	// rob.scala:310:28
        rob_uop_6_dst_rtype = _RANDOM[10'h69][5:4];	// rob.scala:310:28
        rob_uop_6_fp_val = _RANDOM[10'h69][11];	// rob.scala:310:28
        rob_uop_7_uopc = _RANDOM[10'h69][28:22];	// rob.scala:310:28
        rob_uop_7_is_rvc = _RANDOM[10'h6B][29];	// rob.scala:310:28
        rob_uop_7_br_mask = _RANDOM[10'h6E][29:18];	// rob.scala:310:28
        rob_uop_7_ftq_idx = _RANDOM[10'h6F][6:2];	// rob.scala:310:28
        rob_uop_7_edge_inst = _RANDOM[10'h6F][7];	// rob.scala:310:28
        rob_uop_7_pc_lob = _RANDOM[10'h6F][13:8];	// rob.scala:310:28
        rob_uop_7_pdst = {_RANDOM[10'h70][31], _RANDOM[10'h71][5:0]};	// rob.scala:310:28
        rob_uop_7_stale_pdst = _RANDOM[10'h72][10:4];	// rob.scala:310:28
        rob_uop_7_is_fencei = _RANDOM[10'h74][22];	// rob.scala:310:28
        rob_uop_7_uses_ldq = _RANDOM[10'h74][24];	// rob.scala:310:28
        rob_uop_7_uses_stq = _RANDOM[10'h74][25];	// rob.scala:310:28
        rob_uop_7_is_sys_pc2epc = _RANDOM[10'h74][26];	// rob.scala:310:28
        rob_uop_7_flush_on_commit = _RANDOM[10'h74][28];	// rob.scala:310:28
        rob_uop_7_ldst = {_RANDOM[10'h74][31:30], _RANDOM[10'h75][3:0]};	// rob.scala:310:28
        rob_uop_7_ldst_val = _RANDOM[10'h75][22];	// rob.scala:310:28
        rob_uop_7_dst_rtype = _RANDOM[10'h75][24:23];	// rob.scala:310:28
        rob_uop_7_fp_val = _RANDOM[10'h75][30];	// rob.scala:310:28
        rob_uop_8_uopc = _RANDOM[10'h76][15:9];	// rob.scala:310:28
        rob_uop_8_is_rvc = _RANDOM[10'h78][16];	// rob.scala:310:28
        rob_uop_8_br_mask = _RANDOM[10'h7B][16:5];	// rob.scala:310:28
        rob_uop_8_ftq_idx = _RANDOM[10'h7B][25:21];	// rob.scala:310:28
        rob_uop_8_edge_inst = _RANDOM[10'h7B][26];	// rob.scala:310:28
        rob_uop_8_pc_lob = {_RANDOM[10'h7B][31:27], _RANDOM[10'h7C][0]};	// rob.scala:310:28
        rob_uop_8_pdst = _RANDOM[10'h7D][24:18];	// rob.scala:310:28
        rob_uop_8_stale_pdst = _RANDOM[10'h7E][29:23];	// rob.scala:310:28
        rob_uop_8_is_fencei = _RANDOM[10'h81][9];	// rob.scala:310:28
        rob_uop_8_uses_ldq = _RANDOM[10'h81][11];	// rob.scala:310:28
        rob_uop_8_uses_stq = _RANDOM[10'h81][12];	// rob.scala:310:28
        rob_uop_8_is_sys_pc2epc = _RANDOM[10'h81][13];	// rob.scala:310:28
        rob_uop_8_flush_on_commit = _RANDOM[10'h81][15];	// rob.scala:310:28
        rob_uop_8_ldst = _RANDOM[10'h81][22:17];	// rob.scala:310:28
        rob_uop_8_ldst_val = _RANDOM[10'h82][9];	// rob.scala:310:28
        rob_uop_8_dst_rtype = _RANDOM[10'h82][11:10];	// rob.scala:310:28
        rob_uop_8_fp_val = _RANDOM[10'h82][17];	// rob.scala:310:28
        rob_uop_9_uopc = {_RANDOM[10'h82][31:28], _RANDOM[10'h83][2:0]};	// rob.scala:310:28
        rob_uop_9_is_rvc = _RANDOM[10'h85][3];	// rob.scala:310:28
        rob_uop_9_br_mask = {_RANDOM[10'h87][31:24], _RANDOM[10'h88][3:0]};	// rob.scala:310:28
        rob_uop_9_ftq_idx = _RANDOM[10'h88][12:8];	// rob.scala:310:28
        rob_uop_9_edge_inst = _RANDOM[10'h88][13];	// rob.scala:310:28
        rob_uop_9_pc_lob = _RANDOM[10'h88][19:14];	// rob.scala:310:28
        rob_uop_9_pdst = _RANDOM[10'h8A][11:5];	// rob.scala:310:28
        rob_uop_9_stale_pdst = _RANDOM[10'h8B][16:10];	// rob.scala:310:28
        rob_uop_9_is_fencei = _RANDOM[10'h8D][28];	// rob.scala:310:28
        rob_uop_9_uses_ldq = _RANDOM[10'h8D][30];	// rob.scala:310:28
        rob_uop_9_uses_stq = _RANDOM[10'h8D][31];	// rob.scala:310:28
        rob_uop_9_is_sys_pc2epc = _RANDOM[10'h8E][0];	// rob.scala:310:28
        rob_uop_9_flush_on_commit = _RANDOM[10'h8E][2];	// rob.scala:310:28
        rob_uop_9_ldst = _RANDOM[10'h8E][9:4];	// rob.scala:310:28
        rob_uop_9_ldst_val = _RANDOM[10'h8E][28];	// rob.scala:310:28
        rob_uop_9_dst_rtype = _RANDOM[10'h8E][30:29];	// rob.scala:310:28
        rob_uop_9_fp_val = _RANDOM[10'h8F][4];	// rob.scala:310:28
        rob_uop_10_uopc = _RANDOM[10'h8F][21:15];	// rob.scala:310:28
        rob_uop_10_is_rvc = _RANDOM[10'h91][22];	// rob.scala:310:28
        rob_uop_10_br_mask = _RANDOM[10'h94][22:11];	// rob.scala:310:28
        rob_uop_10_ftq_idx = _RANDOM[10'h94][31:27];	// rob.scala:310:28
        rob_uop_10_edge_inst = _RANDOM[10'h95][0];	// rob.scala:310:28
        rob_uop_10_pc_lob = _RANDOM[10'h95][6:1];	// rob.scala:310:28
        rob_uop_10_pdst = _RANDOM[10'h96][30:24];	// rob.scala:310:28
        rob_uop_10_stale_pdst = {_RANDOM[10'h97][31:29], _RANDOM[10'h98][3:0]};	// rob.scala:310:28
        rob_uop_10_is_fencei = _RANDOM[10'h9A][15];	// rob.scala:310:28
        rob_uop_10_uses_ldq = _RANDOM[10'h9A][17];	// rob.scala:310:28
        rob_uop_10_uses_stq = _RANDOM[10'h9A][18];	// rob.scala:310:28
        rob_uop_10_is_sys_pc2epc = _RANDOM[10'h9A][19];	// rob.scala:310:28
        rob_uop_10_flush_on_commit = _RANDOM[10'h9A][21];	// rob.scala:310:28
        rob_uop_10_ldst = _RANDOM[10'h9A][28:23];	// rob.scala:310:28
        rob_uop_10_ldst_val = _RANDOM[10'h9B][15];	// rob.scala:310:28
        rob_uop_10_dst_rtype = _RANDOM[10'h9B][17:16];	// rob.scala:310:28
        rob_uop_10_fp_val = _RANDOM[10'h9B][23];	// rob.scala:310:28
        rob_uop_11_uopc = _RANDOM[10'h9C][8:2];	// rob.scala:310:28
        rob_uop_11_is_rvc = _RANDOM[10'h9E][9];	// rob.scala:310:28
        rob_uop_11_br_mask = {_RANDOM[10'hA0][31:30], _RANDOM[10'hA1][9:0]};	// rob.scala:310:28
        rob_uop_11_ftq_idx = _RANDOM[10'hA1][18:14];	// rob.scala:310:28
        rob_uop_11_edge_inst = _RANDOM[10'hA1][19];	// rob.scala:310:28
        rob_uop_11_pc_lob = _RANDOM[10'hA1][25:20];	// rob.scala:310:28
        rob_uop_11_pdst = _RANDOM[10'hA3][17:11];	// rob.scala:310:28
        rob_uop_11_stale_pdst = _RANDOM[10'hA4][22:16];	// rob.scala:310:28
        rob_uop_11_is_fencei = _RANDOM[10'hA7][2];	// rob.scala:310:28
        rob_uop_11_uses_ldq = _RANDOM[10'hA7][4];	// rob.scala:310:28
        rob_uop_11_uses_stq = _RANDOM[10'hA7][5];	// rob.scala:310:28
        rob_uop_11_is_sys_pc2epc = _RANDOM[10'hA7][6];	// rob.scala:310:28
        rob_uop_11_flush_on_commit = _RANDOM[10'hA7][8];	// rob.scala:310:28
        rob_uop_11_ldst = _RANDOM[10'hA7][15:10];	// rob.scala:310:28
        rob_uop_11_ldst_val = _RANDOM[10'hA8][2];	// rob.scala:310:28
        rob_uop_11_dst_rtype = _RANDOM[10'hA8][4:3];	// rob.scala:310:28
        rob_uop_11_fp_val = _RANDOM[10'hA8][10];	// rob.scala:310:28
        rob_uop_12_uopc = _RANDOM[10'hA8][27:21];	// rob.scala:310:28
        rob_uop_12_is_rvc = _RANDOM[10'hAA][28];	// rob.scala:310:28
        rob_uop_12_br_mask = _RANDOM[10'hAD][28:17];	// rob.scala:310:28
        rob_uop_12_ftq_idx = _RANDOM[10'hAE][5:1];	// rob.scala:310:28
        rob_uop_12_edge_inst = _RANDOM[10'hAE][6];	// rob.scala:310:28
        rob_uop_12_pc_lob = _RANDOM[10'hAE][12:7];	// rob.scala:310:28
        rob_uop_12_pdst = {_RANDOM[10'hAF][31:30], _RANDOM[10'hB0][4:0]};	// rob.scala:310:28
        rob_uop_12_stale_pdst = _RANDOM[10'hB1][9:3];	// rob.scala:310:28
        rob_uop_12_is_fencei = _RANDOM[10'hB3][21];	// rob.scala:310:28
        rob_uop_12_uses_ldq = _RANDOM[10'hB3][23];	// rob.scala:310:28
        rob_uop_12_uses_stq = _RANDOM[10'hB3][24];	// rob.scala:310:28
        rob_uop_12_is_sys_pc2epc = _RANDOM[10'hB3][25];	// rob.scala:310:28
        rob_uop_12_flush_on_commit = _RANDOM[10'hB3][27];	// rob.scala:310:28
        rob_uop_12_ldst = {_RANDOM[10'hB3][31:29], _RANDOM[10'hB4][2:0]};	// rob.scala:310:28
        rob_uop_12_ldst_val = _RANDOM[10'hB4][21];	// rob.scala:310:28
        rob_uop_12_dst_rtype = _RANDOM[10'hB4][23:22];	// rob.scala:310:28
        rob_uop_12_fp_val = _RANDOM[10'hB4][29];	// rob.scala:310:28
        rob_uop_13_uopc = _RANDOM[10'hB5][14:8];	// rob.scala:310:28
        rob_uop_13_is_rvc = _RANDOM[10'hB7][15];	// rob.scala:310:28
        rob_uop_13_br_mask = _RANDOM[10'hBA][15:4];	// rob.scala:310:28
        rob_uop_13_ftq_idx = _RANDOM[10'hBA][24:20];	// rob.scala:310:28
        rob_uop_13_edge_inst = _RANDOM[10'hBA][25];	// rob.scala:310:28
        rob_uop_13_pc_lob = _RANDOM[10'hBA][31:26];	// rob.scala:310:28
        rob_uop_13_pdst = _RANDOM[10'hBC][23:17];	// rob.scala:310:28
        rob_uop_13_stale_pdst = _RANDOM[10'hBD][28:22];	// rob.scala:310:28
        rob_uop_13_is_fencei = _RANDOM[10'hC0][8];	// rob.scala:310:28
        rob_uop_13_uses_ldq = _RANDOM[10'hC0][10];	// rob.scala:310:28
        rob_uop_13_uses_stq = _RANDOM[10'hC0][11];	// rob.scala:310:28
        rob_uop_13_is_sys_pc2epc = _RANDOM[10'hC0][12];	// rob.scala:310:28
        rob_uop_13_flush_on_commit = _RANDOM[10'hC0][14];	// rob.scala:310:28
        rob_uop_13_ldst = _RANDOM[10'hC0][21:16];	// rob.scala:310:28
        rob_uop_13_ldst_val = _RANDOM[10'hC1][8];	// rob.scala:310:28
        rob_uop_13_dst_rtype = _RANDOM[10'hC1][10:9];	// rob.scala:310:28
        rob_uop_13_fp_val = _RANDOM[10'hC1][16];	// rob.scala:310:28
        rob_uop_14_uopc = {_RANDOM[10'hC1][31:27], _RANDOM[10'hC2][1:0]};	// rob.scala:310:28
        rob_uop_14_is_rvc = _RANDOM[10'hC4][2];	// rob.scala:310:28
        rob_uop_14_br_mask = {_RANDOM[10'hC6][31:23], _RANDOM[10'hC7][2:0]};	// rob.scala:310:28
        rob_uop_14_ftq_idx = _RANDOM[10'hC7][11:7];	// rob.scala:310:28
        rob_uop_14_edge_inst = _RANDOM[10'hC7][12];	// rob.scala:310:28
        rob_uop_14_pc_lob = _RANDOM[10'hC7][18:13];	// rob.scala:310:28
        rob_uop_14_pdst = _RANDOM[10'hC9][10:4];	// rob.scala:310:28
        rob_uop_14_stale_pdst = _RANDOM[10'hCA][15:9];	// rob.scala:310:28
        rob_uop_14_is_fencei = _RANDOM[10'hCC][27];	// rob.scala:310:28
        rob_uop_14_uses_ldq = _RANDOM[10'hCC][29];	// rob.scala:310:28
        rob_uop_14_uses_stq = _RANDOM[10'hCC][30];	// rob.scala:310:28
        rob_uop_14_is_sys_pc2epc = _RANDOM[10'hCC][31];	// rob.scala:310:28
        rob_uop_14_flush_on_commit = _RANDOM[10'hCD][1];	// rob.scala:310:28
        rob_uop_14_ldst = _RANDOM[10'hCD][8:3];	// rob.scala:310:28
        rob_uop_14_ldst_val = _RANDOM[10'hCD][27];	// rob.scala:310:28
        rob_uop_14_dst_rtype = _RANDOM[10'hCD][29:28];	// rob.scala:310:28
        rob_uop_14_fp_val = _RANDOM[10'hCE][3];	// rob.scala:310:28
        rob_uop_15_uopc = _RANDOM[10'hCE][20:14];	// rob.scala:310:28
        rob_uop_15_is_rvc = _RANDOM[10'hD0][21];	// rob.scala:310:28
        rob_uop_15_br_mask = _RANDOM[10'hD3][21:10];	// rob.scala:310:28
        rob_uop_15_ftq_idx = _RANDOM[10'hD3][30:26];	// rob.scala:310:28
        rob_uop_15_edge_inst = _RANDOM[10'hD3][31];	// rob.scala:310:28
        rob_uop_15_pc_lob = _RANDOM[10'hD4][5:0];	// rob.scala:310:28
        rob_uop_15_pdst = _RANDOM[10'hD5][29:23];	// rob.scala:310:28
        rob_uop_15_stale_pdst = {_RANDOM[10'hD6][31:28], _RANDOM[10'hD7][2:0]};	// rob.scala:310:28
        rob_uop_15_is_fencei = _RANDOM[10'hD9][14];	// rob.scala:310:28
        rob_uop_15_uses_ldq = _RANDOM[10'hD9][16];	// rob.scala:310:28
        rob_uop_15_uses_stq = _RANDOM[10'hD9][17];	// rob.scala:310:28
        rob_uop_15_is_sys_pc2epc = _RANDOM[10'hD9][18];	// rob.scala:310:28
        rob_uop_15_flush_on_commit = _RANDOM[10'hD9][20];	// rob.scala:310:28
        rob_uop_15_ldst = _RANDOM[10'hD9][27:22];	// rob.scala:310:28
        rob_uop_15_ldst_val = _RANDOM[10'hDA][14];	// rob.scala:310:28
        rob_uop_15_dst_rtype = _RANDOM[10'hDA][16:15];	// rob.scala:310:28
        rob_uop_15_fp_val = _RANDOM[10'hDA][22];	// rob.scala:310:28
        rob_uop_16_uopc = _RANDOM[10'hDB][7:1];	// rob.scala:310:28
        rob_uop_16_is_rvc = _RANDOM[10'hDD][8];	// rob.scala:310:28
        rob_uop_16_br_mask = {_RANDOM[10'hDF][31:29], _RANDOM[10'hE0][8:0]};	// rob.scala:310:28
        rob_uop_16_ftq_idx = _RANDOM[10'hE0][17:13];	// rob.scala:310:28
        rob_uop_16_edge_inst = _RANDOM[10'hE0][18];	// rob.scala:310:28
        rob_uop_16_pc_lob = _RANDOM[10'hE0][24:19];	// rob.scala:310:28
        rob_uop_16_pdst = _RANDOM[10'hE2][16:10];	// rob.scala:310:28
        rob_uop_16_stale_pdst = _RANDOM[10'hE3][21:15];	// rob.scala:310:28
        rob_uop_16_is_fencei = _RANDOM[10'hE6][1];	// rob.scala:310:28
        rob_uop_16_uses_ldq = _RANDOM[10'hE6][3];	// rob.scala:310:28
        rob_uop_16_uses_stq = _RANDOM[10'hE6][4];	// rob.scala:310:28
        rob_uop_16_is_sys_pc2epc = _RANDOM[10'hE6][5];	// rob.scala:310:28
        rob_uop_16_flush_on_commit = _RANDOM[10'hE6][7];	// rob.scala:310:28
        rob_uop_16_ldst = _RANDOM[10'hE6][14:9];	// rob.scala:310:28
        rob_uop_16_ldst_val = _RANDOM[10'hE7][1];	// rob.scala:310:28
        rob_uop_16_dst_rtype = _RANDOM[10'hE7][3:2];	// rob.scala:310:28
        rob_uop_16_fp_val = _RANDOM[10'hE7][9];	// rob.scala:310:28
        rob_uop_17_uopc = _RANDOM[10'hE7][26:20];	// rob.scala:310:28
        rob_uop_17_is_rvc = _RANDOM[10'hE9][27];	// rob.scala:310:28
        rob_uop_17_br_mask = _RANDOM[10'hEC][27:16];	// rob.scala:310:28
        rob_uop_17_ftq_idx = _RANDOM[10'hED][4:0];	// rob.scala:310:28
        rob_uop_17_edge_inst = _RANDOM[10'hED][5];	// rob.scala:310:28
        rob_uop_17_pc_lob = _RANDOM[10'hED][11:6];	// rob.scala:310:28
        rob_uop_17_pdst = {_RANDOM[10'hEE][31:29], _RANDOM[10'hEF][3:0]};	// rob.scala:310:28
        rob_uop_17_stale_pdst = _RANDOM[10'hF0][8:2];	// rob.scala:310:28
        rob_uop_17_is_fencei = _RANDOM[10'hF2][20];	// rob.scala:310:28
        rob_uop_17_uses_ldq = _RANDOM[10'hF2][22];	// rob.scala:310:28
        rob_uop_17_uses_stq = _RANDOM[10'hF2][23];	// rob.scala:310:28
        rob_uop_17_is_sys_pc2epc = _RANDOM[10'hF2][24];	// rob.scala:310:28
        rob_uop_17_flush_on_commit = _RANDOM[10'hF2][26];	// rob.scala:310:28
        rob_uop_17_ldst = {_RANDOM[10'hF2][31:28], _RANDOM[10'hF3][1:0]};	// rob.scala:310:28
        rob_uop_17_ldst_val = _RANDOM[10'hF3][20];	// rob.scala:310:28
        rob_uop_17_dst_rtype = _RANDOM[10'hF3][22:21];	// rob.scala:310:28
        rob_uop_17_fp_val = _RANDOM[10'hF3][28];	// rob.scala:310:28
        rob_uop_18_uopc = _RANDOM[10'hF4][13:7];	// rob.scala:310:28
        rob_uop_18_is_rvc = _RANDOM[10'hF6][14];	// rob.scala:310:28
        rob_uop_18_br_mask = _RANDOM[10'hF9][14:3];	// rob.scala:310:28
        rob_uop_18_ftq_idx = _RANDOM[10'hF9][23:19];	// rob.scala:310:28
        rob_uop_18_edge_inst = _RANDOM[10'hF9][24];	// rob.scala:310:28
        rob_uop_18_pc_lob = _RANDOM[10'hF9][30:25];	// rob.scala:310:28
        rob_uop_18_pdst = _RANDOM[10'hFB][22:16];	// rob.scala:310:28
        rob_uop_18_stale_pdst = _RANDOM[10'hFC][27:21];	// rob.scala:310:28
        rob_uop_18_is_fencei = _RANDOM[10'hFF][7];	// rob.scala:310:28
        rob_uop_18_uses_ldq = _RANDOM[10'hFF][9];	// rob.scala:310:28
        rob_uop_18_uses_stq = _RANDOM[10'hFF][10];	// rob.scala:310:28
        rob_uop_18_is_sys_pc2epc = _RANDOM[10'hFF][11];	// rob.scala:310:28
        rob_uop_18_flush_on_commit = _RANDOM[10'hFF][13];	// rob.scala:310:28
        rob_uop_18_ldst = _RANDOM[10'hFF][20:15];	// rob.scala:310:28
        rob_uop_18_ldst_val = _RANDOM[10'h100][7];	// rob.scala:310:28
        rob_uop_18_dst_rtype = _RANDOM[10'h100][9:8];	// rob.scala:310:28
        rob_uop_18_fp_val = _RANDOM[10'h100][15];	// rob.scala:310:28
        rob_uop_19_uopc = {_RANDOM[10'h100][31:26], _RANDOM[10'h101][0]};	// rob.scala:310:28
        rob_uop_19_is_rvc = _RANDOM[10'h103][1];	// rob.scala:310:28
        rob_uop_19_br_mask = {_RANDOM[10'h105][31:22], _RANDOM[10'h106][1:0]};	// rob.scala:310:28
        rob_uop_19_ftq_idx = _RANDOM[10'h106][10:6];	// rob.scala:310:28
        rob_uop_19_edge_inst = _RANDOM[10'h106][11];	// rob.scala:310:28
        rob_uop_19_pc_lob = _RANDOM[10'h106][17:12];	// rob.scala:310:28
        rob_uop_19_pdst = _RANDOM[10'h108][9:3];	// rob.scala:310:28
        rob_uop_19_stale_pdst = _RANDOM[10'h109][14:8];	// rob.scala:310:28
        rob_uop_19_is_fencei = _RANDOM[10'h10B][26];	// rob.scala:310:28
        rob_uop_19_uses_ldq = _RANDOM[10'h10B][28];	// rob.scala:310:28
        rob_uop_19_uses_stq = _RANDOM[10'h10B][29];	// rob.scala:310:28
        rob_uop_19_is_sys_pc2epc = _RANDOM[10'h10B][30];	// rob.scala:310:28
        rob_uop_19_flush_on_commit = _RANDOM[10'h10C][0];	// rob.scala:310:28
        rob_uop_19_ldst = _RANDOM[10'h10C][7:2];	// rob.scala:310:28
        rob_uop_19_ldst_val = _RANDOM[10'h10C][26];	// rob.scala:310:28
        rob_uop_19_dst_rtype = _RANDOM[10'h10C][28:27];	// rob.scala:310:28
        rob_uop_19_fp_val = _RANDOM[10'h10D][2];	// rob.scala:310:28
        rob_uop_20_uopc = _RANDOM[10'h10D][19:13];	// rob.scala:310:28
        rob_uop_20_is_rvc = _RANDOM[10'h10F][20];	// rob.scala:310:28
        rob_uop_20_br_mask = _RANDOM[10'h112][20:9];	// rob.scala:310:28
        rob_uop_20_ftq_idx = _RANDOM[10'h112][29:25];	// rob.scala:310:28
        rob_uop_20_edge_inst = _RANDOM[10'h112][30];	// rob.scala:310:28
        rob_uop_20_pc_lob = {_RANDOM[10'h112][31], _RANDOM[10'h113][4:0]};	// rob.scala:310:28
        rob_uop_20_pdst = _RANDOM[10'h114][28:22];	// rob.scala:310:28
        rob_uop_20_stale_pdst = {_RANDOM[10'h115][31:27], _RANDOM[10'h116][1:0]};	// rob.scala:310:28
        rob_uop_20_is_fencei = _RANDOM[10'h118][13];	// rob.scala:310:28
        rob_uop_20_uses_ldq = _RANDOM[10'h118][15];	// rob.scala:310:28
        rob_uop_20_uses_stq = _RANDOM[10'h118][16];	// rob.scala:310:28
        rob_uop_20_is_sys_pc2epc = _RANDOM[10'h118][17];	// rob.scala:310:28
        rob_uop_20_flush_on_commit = _RANDOM[10'h118][19];	// rob.scala:310:28
        rob_uop_20_ldst = _RANDOM[10'h118][26:21];	// rob.scala:310:28
        rob_uop_20_ldst_val = _RANDOM[10'h119][13];	// rob.scala:310:28
        rob_uop_20_dst_rtype = _RANDOM[10'h119][15:14];	// rob.scala:310:28
        rob_uop_20_fp_val = _RANDOM[10'h119][21];	// rob.scala:310:28
        rob_uop_21_uopc = _RANDOM[10'h11A][6:0];	// rob.scala:310:28
        rob_uop_21_is_rvc = _RANDOM[10'h11C][7];	// rob.scala:310:28
        rob_uop_21_br_mask = {_RANDOM[10'h11E][31:28], _RANDOM[10'h11F][7:0]};	// rob.scala:310:28
        rob_uop_21_ftq_idx = _RANDOM[10'h11F][16:12];	// rob.scala:310:28
        rob_uop_21_edge_inst = _RANDOM[10'h11F][17];	// rob.scala:310:28
        rob_uop_21_pc_lob = _RANDOM[10'h11F][23:18];	// rob.scala:310:28
        rob_uop_21_pdst = _RANDOM[10'h121][15:9];	// rob.scala:310:28
        rob_uop_21_stale_pdst = _RANDOM[10'h122][20:14];	// rob.scala:310:28
        rob_uop_21_is_fencei = _RANDOM[10'h125][0];	// rob.scala:310:28
        rob_uop_21_uses_ldq = _RANDOM[10'h125][2];	// rob.scala:310:28
        rob_uop_21_uses_stq = _RANDOM[10'h125][3];	// rob.scala:310:28
        rob_uop_21_is_sys_pc2epc = _RANDOM[10'h125][4];	// rob.scala:310:28
        rob_uop_21_flush_on_commit = _RANDOM[10'h125][6];	// rob.scala:310:28
        rob_uop_21_ldst = _RANDOM[10'h125][13:8];	// rob.scala:310:28
        rob_uop_21_ldst_val = _RANDOM[10'h126][0];	// rob.scala:310:28
        rob_uop_21_dst_rtype = _RANDOM[10'h126][2:1];	// rob.scala:310:28
        rob_uop_21_fp_val = _RANDOM[10'h126][8];	// rob.scala:310:28
        rob_uop_22_uopc = _RANDOM[10'h126][25:19];	// rob.scala:310:28
        rob_uop_22_is_rvc = _RANDOM[10'h128][26];	// rob.scala:310:28
        rob_uop_22_br_mask = _RANDOM[10'h12B][26:15];	// rob.scala:310:28
        rob_uop_22_ftq_idx = {_RANDOM[10'h12B][31], _RANDOM[10'h12C][3:0]};	// rob.scala:310:28
        rob_uop_22_edge_inst = _RANDOM[10'h12C][4];	// rob.scala:310:28
        rob_uop_22_pc_lob = _RANDOM[10'h12C][10:5];	// rob.scala:310:28
        rob_uop_22_pdst = {_RANDOM[10'h12D][31:28], _RANDOM[10'h12E][2:0]};	// rob.scala:310:28
        rob_uop_22_stale_pdst = _RANDOM[10'h12F][7:1];	// rob.scala:310:28
        rob_uop_22_is_fencei = _RANDOM[10'h131][19];	// rob.scala:310:28
        rob_uop_22_uses_ldq = _RANDOM[10'h131][21];	// rob.scala:310:28
        rob_uop_22_uses_stq = _RANDOM[10'h131][22];	// rob.scala:310:28
        rob_uop_22_is_sys_pc2epc = _RANDOM[10'h131][23];	// rob.scala:310:28
        rob_uop_22_flush_on_commit = _RANDOM[10'h131][25];	// rob.scala:310:28
        rob_uop_22_ldst = {_RANDOM[10'h131][31:27], _RANDOM[10'h132][0]};	// rob.scala:310:28
        rob_uop_22_ldst_val = _RANDOM[10'h132][19];	// rob.scala:310:28
        rob_uop_22_dst_rtype = _RANDOM[10'h132][21:20];	// rob.scala:310:28
        rob_uop_22_fp_val = _RANDOM[10'h132][27];	// rob.scala:310:28
        rob_uop_23_uopc = _RANDOM[10'h133][12:6];	// rob.scala:310:28
        rob_uop_23_is_rvc = _RANDOM[10'h135][13];	// rob.scala:310:28
        rob_uop_23_br_mask = _RANDOM[10'h138][13:2];	// rob.scala:310:28
        rob_uop_23_ftq_idx = _RANDOM[10'h138][22:18];	// rob.scala:310:28
        rob_uop_23_edge_inst = _RANDOM[10'h138][23];	// rob.scala:310:28
        rob_uop_23_pc_lob = _RANDOM[10'h138][29:24];	// rob.scala:310:28
        rob_uop_23_pdst = _RANDOM[10'h13A][21:15];	// rob.scala:310:28
        rob_uop_23_stale_pdst = _RANDOM[10'h13B][26:20];	// rob.scala:310:28
        rob_uop_23_is_fencei = _RANDOM[10'h13E][6];	// rob.scala:310:28
        rob_uop_23_uses_ldq = _RANDOM[10'h13E][8];	// rob.scala:310:28
        rob_uop_23_uses_stq = _RANDOM[10'h13E][9];	// rob.scala:310:28
        rob_uop_23_is_sys_pc2epc = _RANDOM[10'h13E][10];	// rob.scala:310:28
        rob_uop_23_flush_on_commit = _RANDOM[10'h13E][12];	// rob.scala:310:28
        rob_uop_23_ldst = _RANDOM[10'h13E][19:14];	// rob.scala:310:28
        rob_uop_23_ldst_val = _RANDOM[10'h13F][6];	// rob.scala:310:28
        rob_uop_23_dst_rtype = _RANDOM[10'h13F][8:7];	// rob.scala:310:28
        rob_uop_23_fp_val = _RANDOM[10'h13F][14];	// rob.scala:310:28
        rob_uop_24_uopc = _RANDOM[10'h13F][31:25];	// rob.scala:310:28
        rob_uop_24_is_rvc = _RANDOM[10'h142][0];	// rob.scala:310:28
        rob_uop_24_br_mask = {_RANDOM[10'h144][31:21], _RANDOM[10'h145][0]};	// rob.scala:310:28
        rob_uop_24_ftq_idx = _RANDOM[10'h145][9:5];	// rob.scala:310:28
        rob_uop_24_edge_inst = _RANDOM[10'h145][10];	// rob.scala:310:28
        rob_uop_24_pc_lob = _RANDOM[10'h145][16:11];	// rob.scala:310:28
        rob_uop_24_pdst = _RANDOM[10'h147][8:2];	// rob.scala:310:28
        rob_uop_24_stale_pdst = _RANDOM[10'h148][13:7];	// rob.scala:310:28
        rob_uop_24_is_fencei = _RANDOM[10'h14A][25];	// rob.scala:310:28
        rob_uop_24_uses_ldq = _RANDOM[10'h14A][27];	// rob.scala:310:28
        rob_uop_24_uses_stq = _RANDOM[10'h14A][28];	// rob.scala:310:28
        rob_uop_24_is_sys_pc2epc = _RANDOM[10'h14A][29];	// rob.scala:310:28
        rob_uop_24_flush_on_commit = _RANDOM[10'h14A][31];	// rob.scala:310:28
        rob_uop_24_ldst = _RANDOM[10'h14B][6:1];	// rob.scala:310:28
        rob_uop_24_ldst_val = _RANDOM[10'h14B][25];	// rob.scala:310:28
        rob_uop_24_dst_rtype = _RANDOM[10'h14B][27:26];	// rob.scala:310:28
        rob_uop_24_fp_val = _RANDOM[10'h14C][1];	// rob.scala:310:28
        rob_uop_25_uopc = _RANDOM[10'h14C][18:12];	// rob.scala:310:28
        rob_uop_25_is_rvc = _RANDOM[10'h14E][19];	// rob.scala:310:28
        rob_uop_25_br_mask = _RANDOM[10'h151][19:8];	// rob.scala:310:28
        rob_uop_25_ftq_idx = _RANDOM[10'h151][28:24];	// rob.scala:310:28
        rob_uop_25_edge_inst = _RANDOM[10'h151][29];	// rob.scala:310:28
        rob_uop_25_pc_lob = {_RANDOM[10'h151][31:30], _RANDOM[10'h152][3:0]};	// rob.scala:310:28
        rob_uop_25_pdst = _RANDOM[10'h153][27:21];	// rob.scala:310:28
        rob_uop_25_stale_pdst = {_RANDOM[10'h154][31:26], _RANDOM[10'h155][0]};	// rob.scala:310:28
        rob_uop_25_is_fencei = _RANDOM[10'h157][12];	// rob.scala:310:28
        rob_uop_25_uses_ldq = _RANDOM[10'h157][14];	// rob.scala:310:28
        rob_uop_25_uses_stq = _RANDOM[10'h157][15];	// rob.scala:310:28
        rob_uop_25_is_sys_pc2epc = _RANDOM[10'h157][16];	// rob.scala:310:28
        rob_uop_25_flush_on_commit = _RANDOM[10'h157][18];	// rob.scala:310:28
        rob_uop_25_ldst = _RANDOM[10'h157][25:20];	// rob.scala:310:28
        rob_uop_25_ldst_val = _RANDOM[10'h158][12];	// rob.scala:310:28
        rob_uop_25_dst_rtype = _RANDOM[10'h158][14:13];	// rob.scala:310:28
        rob_uop_25_fp_val = _RANDOM[10'h158][20];	// rob.scala:310:28
        rob_uop_26_uopc = {_RANDOM[10'h158][31], _RANDOM[10'h159][5:0]};	// rob.scala:310:28
        rob_uop_26_is_rvc = _RANDOM[10'h15B][6];	// rob.scala:310:28
        rob_uop_26_br_mask = {_RANDOM[10'h15D][31:27], _RANDOM[10'h15E][6:0]};	// rob.scala:310:28
        rob_uop_26_ftq_idx = _RANDOM[10'h15E][15:11];	// rob.scala:310:28
        rob_uop_26_edge_inst = _RANDOM[10'h15E][16];	// rob.scala:310:28
        rob_uop_26_pc_lob = _RANDOM[10'h15E][22:17];	// rob.scala:310:28
        rob_uop_26_pdst = _RANDOM[10'h160][14:8];	// rob.scala:310:28
        rob_uop_26_stale_pdst = _RANDOM[10'h161][19:13];	// rob.scala:310:28
        rob_uop_26_is_fencei = _RANDOM[10'h163][31];	// rob.scala:310:28
        rob_uop_26_uses_ldq = _RANDOM[10'h164][1];	// rob.scala:310:28
        rob_uop_26_uses_stq = _RANDOM[10'h164][2];	// rob.scala:310:28
        rob_uop_26_is_sys_pc2epc = _RANDOM[10'h164][3];	// rob.scala:310:28
        rob_uop_26_flush_on_commit = _RANDOM[10'h164][5];	// rob.scala:310:28
        rob_uop_26_ldst = _RANDOM[10'h164][12:7];	// rob.scala:310:28
        rob_uop_26_ldst_val = _RANDOM[10'h164][31];	// rob.scala:310:28
        rob_uop_26_dst_rtype = _RANDOM[10'h165][1:0];	// rob.scala:310:28
        rob_uop_26_fp_val = _RANDOM[10'h165][7];	// rob.scala:310:28
        rob_uop_27_uopc = _RANDOM[10'h165][24:18];	// rob.scala:310:28
        rob_uop_27_is_rvc = _RANDOM[10'h167][25];	// rob.scala:310:28
        rob_uop_27_br_mask = _RANDOM[10'h16A][25:14];	// rob.scala:310:28
        rob_uop_27_ftq_idx = {_RANDOM[10'h16A][31:30], _RANDOM[10'h16B][2:0]};	// rob.scala:310:28
        rob_uop_27_edge_inst = _RANDOM[10'h16B][3];	// rob.scala:310:28
        rob_uop_27_pc_lob = _RANDOM[10'h16B][9:4];	// rob.scala:310:28
        rob_uop_27_pdst = {_RANDOM[10'h16C][31:27], _RANDOM[10'h16D][1:0]};	// rob.scala:310:28
        rob_uop_27_stale_pdst = _RANDOM[10'h16E][6:0];	// rob.scala:310:28
        rob_uop_27_is_fencei = _RANDOM[10'h170][18];	// rob.scala:310:28
        rob_uop_27_uses_ldq = _RANDOM[10'h170][20];	// rob.scala:310:28
        rob_uop_27_uses_stq = _RANDOM[10'h170][21];	// rob.scala:310:28
        rob_uop_27_is_sys_pc2epc = _RANDOM[10'h170][22];	// rob.scala:310:28
        rob_uop_27_flush_on_commit = _RANDOM[10'h170][24];	// rob.scala:310:28
        rob_uop_27_ldst = _RANDOM[10'h170][31:26];	// rob.scala:310:28
        rob_uop_27_ldst_val = _RANDOM[10'h171][18];	// rob.scala:310:28
        rob_uop_27_dst_rtype = _RANDOM[10'h171][20:19];	// rob.scala:310:28
        rob_uop_27_fp_val = _RANDOM[10'h171][26];	// rob.scala:310:28
        rob_uop_28_uopc = _RANDOM[10'h172][11:5];	// rob.scala:310:28
        rob_uop_28_is_rvc = _RANDOM[10'h174][12];	// rob.scala:310:28
        rob_uop_28_br_mask = _RANDOM[10'h177][12:1];	// rob.scala:310:28
        rob_uop_28_ftq_idx = _RANDOM[10'h177][21:17];	// rob.scala:310:28
        rob_uop_28_edge_inst = _RANDOM[10'h177][22];	// rob.scala:310:28
        rob_uop_28_pc_lob = _RANDOM[10'h177][28:23];	// rob.scala:310:28
        rob_uop_28_pdst = _RANDOM[10'h179][20:14];	// rob.scala:310:28
        rob_uop_28_stale_pdst = _RANDOM[10'h17A][25:19];	// rob.scala:310:28
        rob_uop_28_is_fencei = _RANDOM[10'h17D][5];	// rob.scala:310:28
        rob_uop_28_uses_ldq = _RANDOM[10'h17D][7];	// rob.scala:310:28
        rob_uop_28_uses_stq = _RANDOM[10'h17D][8];	// rob.scala:310:28
        rob_uop_28_is_sys_pc2epc = _RANDOM[10'h17D][9];	// rob.scala:310:28
        rob_uop_28_flush_on_commit = _RANDOM[10'h17D][11];	// rob.scala:310:28
        rob_uop_28_ldst = _RANDOM[10'h17D][18:13];	// rob.scala:310:28
        rob_uop_28_ldst_val = _RANDOM[10'h17E][5];	// rob.scala:310:28
        rob_uop_28_dst_rtype = _RANDOM[10'h17E][7:6];	// rob.scala:310:28
        rob_uop_28_fp_val = _RANDOM[10'h17E][13];	// rob.scala:310:28
        rob_uop_29_uopc = _RANDOM[10'h17E][30:24];	// rob.scala:310:28
        rob_uop_29_is_rvc = _RANDOM[10'h180][31];	// rob.scala:310:28
        rob_uop_29_br_mask = _RANDOM[10'h183][31:20];	// rob.scala:310:28
        rob_uop_29_ftq_idx = _RANDOM[10'h184][8:4];	// rob.scala:310:28
        rob_uop_29_edge_inst = _RANDOM[10'h184][9];	// rob.scala:310:28
        rob_uop_29_pc_lob = _RANDOM[10'h184][15:10];	// rob.scala:310:28
        rob_uop_29_pdst = _RANDOM[10'h186][7:1];	// rob.scala:310:28
        rob_uop_29_stale_pdst = _RANDOM[10'h187][12:6];	// rob.scala:310:28
        rob_uop_29_is_fencei = _RANDOM[10'h189][24];	// rob.scala:310:28
        rob_uop_29_uses_ldq = _RANDOM[10'h189][26];	// rob.scala:310:28
        rob_uop_29_uses_stq = _RANDOM[10'h189][27];	// rob.scala:310:28
        rob_uop_29_is_sys_pc2epc = _RANDOM[10'h189][28];	// rob.scala:310:28
        rob_uop_29_flush_on_commit = _RANDOM[10'h189][30];	// rob.scala:310:28
        rob_uop_29_ldst = _RANDOM[10'h18A][5:0];	// rob.scala:310:28
        rob_uop_29_ldst_val = _RANDOM[10'h18A][24];	// rob.scala:310:28
        rob_uop_29_dst_rtype = _RANDOM[10'h18A][26:25];	// rob.scala:310:28
        rob_uop_29_fp_val = _RANDOM[10'h18B][0];	// rob.scala:310:28
        rob_uop_30_uopc = _RANDOM[10'h18B][17:11];	// rob.scala:310:28
        rob_uop_30_is_rvc = _RANDOM[10'h18D][18];	// rob.scala:310:28
        rob_uop_30_br_mask = _RANDOM[10'h190][18:7];	// rob.scala:310:28
        rob_uop_30_ftq_idx = _RANDOM[10'h190][27:23];	// rob.scala:310:28
        rob_uop_30_edge_inst = _RANDOM[10'h190][28];	// rob.scala:310:28
        rob_uop_30_pc_lob = {_RANDOM[10'h190][31:29], _RANDOM[10'h191][2:0]};	// rob.scala:310:28
        rob_uop_30_pdst = _RANDOM[10'h192][26:20];	// rob.scala:310:28
        rob_uop_30_stale_pdst = _RANDOM[10'h193][31:25];	// rob.scala:310:28
        rob_uop_30_is_fencei = _RANDOM[10'h196][11];	// rob.scala:310:28
        rob_uop_30_uses_ldq = _RANDOM[10'h196][13];	// rob.scala:310:28
        rob_uop_30_uses_stq = _RANDOM[10'h196][14];	// rob.scala:310:28
        rob_uop_30_is_sys_pc2epc = _RANDOM[10'h196][15];	// rob.scala:310:28
        rob_uop_30_flush_on_commit = _RANDOM[10'h196][17];	// rob.scala:310:28
        rob_uop_30_ldst = _RANDOM[10'h196][24:19];	// rob.scala:310:28
        rob_uop_30_ldst_val = _RANDOM[10'h197][11];	// rob.scala:310:28
        rob_uop_30_dst_rtype = _RANDOM[10'h197][13:12];	// rob.scala:310:28
        rob_uop_30_fp_val = _RANDOM[10'h197][19];	// rob.scala:310:28
        rob_uop_31_uopc = {_RANDOM[10'h197][31:30], _RANDOM[10'h198][4:0]};	// rob.scala:310:28
        rob_uop_31_is_rvc = _RANDOM[10'h19A][5];	// rob.scala:310:28
        rob_uop_31_br_mask = {_RANDOM[10'h19C][31:26], _RANDOM[10'h19D][5:0]};	// rob.scala:310:28
        rob_uop_31_ftq_idx = _RANDOM[10'h19D][14:10];	// rob.scala:310:28
        rob_uop_31_edge_inst = _RANDOM[10'h19D][15];	// rob.scala:310:28
        rob_uop_31_pc_lob = _RANDOM[10'h19D][21:16];	// rob.scala:310:28
        rob_uop_31_pdst = _RANDOM[10'h19F][13:7];	// rob.scala:310:28
        rob_uop_31_stale_pdst = _RANDOM[10'h1A0][18:12];	// rob.scala:310:28
        rob_uop_31_is_fencei = _RANDOM[10'h1A2][30];	// rob.scala:310:28
        rob_uop_31_uses_ldq = _RANDOM[10'h1A3][0];	// rob.scala:310:28
        rob_uop_31_uses_stq = _RANDOM[10'h1A3][1];	// rob.scala:310:28
        rob_uop_31_is_sys_pc2epc = _RANDOM[10'h1A3][2];	// rob.scala:310:28
        rob_uop_31_flush_on_commit = _RANDOM[10'h1A3][4];	// rob.scala:310:28
        rob_uop_31_ldst = _RANDOM[10'h1A3][11:6];	// rob.scala:310:28
        rob_uop_31_ldst_val = _RANDOM[10'h1A3][30];	// rob.scala:310:28
        rob_uop_31_dst_rtype = {_RANDOM[10'h1A3][31], _RANDOM[10'h1A4][0]};	// rob.scala:310:28
        rob_uop_31_fp_val = _RANDOM[10'h1A4][6];	// rob.scala:310:28
        rob_exception_0 = _RANDOM[10'h1A4][17];	// rob.scala:310:28, :311:28
        rob_exception_1 = _RANDOM[10'h1A4][18];	// rob.scala:310:28, :311:28
        rob_exception_2 = _RANDOM[10'h1A4][19];	// rob.scala:310:28, :311:28
        rob_exception_3 = _RANDOM[10'h1A4][20];	// rob.scala:310:28, :311:28
        rob_exception_4 = _RANDOM[10'h1A4][21];	// rob.scala:310:28, :311:28
        rob_exception_5 = _RANDOM[10'h1A4][22];	// rob.scala:310:28, :311:28
        rob_exception_6 = _RANDOM[10'h1A4][23];	// rob.scala:310:28, :311:28
        rob_exception_7 = _RANDOM[10'h1A4][24];	// rob.scala:310:28, :311:28
        rob_exception_8 = _RANDOM[10'h1A4][25];	// rob.scala:310:28, :311:28
        rob_exception_9 = _RANDOM[10'h1A4][26];	// rob.scala:310:28, :311:28
        rob_exception_10 = _RANDOM[10'h1A4][27];	// rob.scala:310:28, :311:28
        rob_exception_11 = _RANDOM[10'h1A4][28];	// rob.scala:310:28, :311:28
        rob_exception_12 = _RANDOM[10'h1A4][29];	// rob.scala:310:28, :311:28
        rob_exception_13 = _RANDOM[10'h1A4][30];	// rob.scala:310:28, :311:28
        rob_exception_14 = _RANDOM[10'h1A4][31];	// rob.scala:310:28, :311:28
        rob_exception_15 = _RANDOM[10'h1A5][0];	// rob.scala:311:28
        rob_exception_16 = _RANDOM[10'h1A5][1];	// rob.scala:311:28
        rob_exception_17 = _RANDOM[10'h1A5][2];	// rob.scala:311:28
        rob_exception_18 = _RANDOM[10'h1A5][3];	// rob.scala:311:28
        rob_exception_19 = _RANDOM[10'h1A5][4];	// rob.scala:311:28
        rob_exception_20 = _RANDOM[10'h1A5][5];	// rob.scala:311:28
        rob_exception_21 = _RANDOM[10'h1A5][6];	// rob.scala:311:28
        rob_exception_22 = _RANDOM[10'h1A5][7];	// rob.scala:311:28
        rob_exception_23 = _RANDOM[10'h1A5][8];	// rob.scala:311:28
        rob_exception_24 = _RANDOM[10'h1A5][9];	// rob.scala:311:28
        rob_exception_25 = _RANDOM[10'h1A5][10];	// rob.scala:311:28
        rob_exception_26 = _RANDOM[10'h1A5][11];	// rob.scala:311:28
        rob_exception_27 = _RANDOM[10'h1A5][12];	// rob.scala:311:28
        rob_exception_28 = _RANDOM[10'h1A5][13];	// rob.scala:311:28
        rob_exception_29 = _RANDOM[10'h1A5][14];	// rob.scala:311:28
        rob_exception_30 = _RANDOM[10'h1A5][15];	// rob.scala:311:28
        rob_exception_31 = _RANDOM[10'h1A5][16];	// rob.scala:311:28
        rob_predicated_0 = _RANDOM[10'h1A5][17];	// rob.scala:311:28, :312:29
        rob_predicated_1 = _RANDOM[10'h1A5][18];	// rob.scala:311:28, :312:29
        rob_predicated_2 = _RANDOM[10'h1A5][19];	// rob.scala:311:28, :312:29
        rob_predicated_3 = _RANDOM[10'h1A5][20];	// rob.scala:311:28, :312:29
        rob_predicated_4 = _RANDOM[10'h1A5][21];	// rob.scala:311:28, :312:29
        rob_predicated_5 = _RANDOM[10'h1A5][22];	// rob.scala:311:28, :312:29
        rob_predicated_6 = _RANDOM[10'h1A5][23];	// rob.scala:311:28, :312:29
        rob_predicated_7 = _RANDOM[10'h1A5][24];	// rob.scala:311:28, :312:29
        rob_predicated_8 = _RANDOM[10'h1A5][25];	// rob.scala:311:28, :312:29
        rob_predicated_9 = _RANDOM[10'h1A5][26];	// rob.scala:311:28, :312:29
        rob_predicated_10 = _RANDOM[10'h1A5][27];	// rob.scala:311:28, :312:29
        rob_predicated_11 = _RANDOM[10'h1A5][28];	// rob.scala:311:28, :312:29
        rob_predicated_12 = _RANDOM[10'h1A5][29];	// rob.scala:311:28, :312:29
        rob_predicated_13 = _RANDOM[10'h1A5][30];	// rob.scala:311:28, :312:29
        rob_predicated_14 = _RANDOM[10'h1A5][31];	// rob.scala:311:28, :312:29
        rob_predicated_15 = _RANDOM[10'h1A6][0];	// rob.scala:312:29
        rob_predicated_16 = _RANDOM[10'h1A6][1];	// rob.scala:312:29
        rob_predicated_17 = _RANDOM[10'h1A6][2];	// rob.scala:312:29
        rob_predicated_18 = _RANDOM[10'h1A6][3];	// rob.scala:312:29
        rob_predicated_19 = _RANDOM[10'h1A6][4];	// rob.scala:312:29
        rob_predicated_20 = _RANDOM[10'h1A6][5];	// rob.scala:312:29
        rob_predicated_21 = _RANDOM[10'h1A6][6];	// rob.scala:312:29
        rob_predicated_22 = _RANDOM[10'h1A6][7];	// rob.scala:312:29
        rob_predicated_23 = _RANDOM[10'h1A6][8];	// rob.scala:312:29
        rob_predicated_24 = _RANDOM[10'h1A6][9];	// rob.scala:312:29
        rob_predicated_25 = _RANDOM[10'h1A6][10];	// rob.scala:312:29
        rob_predicated_26 = _RANDOM[10'h1A6][11];	// rob.scala:312:29
        rob_predicated_27 = _RANDOM[10'h1A6][12];	// rob.scala:312:29
        rob_predicated_28 = _RANDOM[10'h1A6][13];	// rob.scala:312:29
        rob_predicated_29 = _RANDOM[10'h1A6][14];	// rob.scala:312:29
        rob_predicated_30 = _RANDOM[10'h1A6][15];	// rob.scala:312:29
        rob_predicated_31 = _RANDOM[10'h1A6][16];	// rob.scala:312:29
        rob_val_1_0 = _RANDOM[10'h1A6][17];	// rob.scala:307:32, :312:29
        rob_val_1_1 = _RANDOM[10'h1A6][18];	// rob.scala:307:32, :312:29
        rob_val_1_2 = _RANDOM[10'h1A6][19];	// rob.scala:307:32, :312:29
        rob_val_1_3 = _RANDOM[10'h1A6][20];	// rob.scala:307:32, :312:29
        rob_val_1_4 = _RANDOM[10'h1A6][21];	// rob.scala:307:32, :312:29
        rob_val_1_5 = _RANDOM[10'h1A6][22];	// rob.scala:307:32, :312:29
        rob_val_1_6 = _RANDOM[10'h1A6][23];	// rob.scala:307:32, :312:29
        rob_val_1_7 = _RANDOM[10'h1A6][24];	// rob.scala:307:32, :312:29
        rob_val_1_8 = _RANDOM[10'h1A6][25];	// rob.scala:307:32, :312:29
        rob_val_1_9 = _RANDOM[10'h1A6][26];	// rob.scala:307:32, :312:29
        rob_val_1_10 = _RANDOM[10'h1A6][27];	// rob.scala:307:32, :312:29
        rob_val_1_11 = _RANDOM[10'h1A6][28];	// rob.scala:307:32, :312:29
        rob_val_1_12 = _RANDOM[10'h1A6][29];	// rob.scala:307:32, :312:29
        rob_val_1_13 = _RANDOM[10'h1A6][30];	// rob.scala:307:32, :312:29
        rob_val_1_14 = _RANDOM[10'h1A6][31];	// rob.scala:307:32, :312:29
        rob_val_1_15 = _RANDOM[10'h1A7][0];	// rob.scala:307:32
        rob_val_1_16 = _RANDOM[10'h1A7][1];	// rob.scala:307:32
        rob_val_1_17 = _RANDOM[10'h1A7][2];	// rob.scala:307:32
        rob_val_1_18 = _RANDOM[10'h1A7][3];	// rob.scala:307:32
        rob_val_1_19 = _RANDOM[10'h1A7][4];	// rob.scala:307:32
        rob_val_1_20 = _RANDOM[10'h1A7][5];	// rob.scala:307:32
        rob_val_1_21 = _RANDOM[10'h1A7][6];	// rob.scala:307:32
        rob_val_1_22 = _RANDOM[10'h1A7][7];	// rob.scala:307:32
        rob_val_1_23 = _RANDOM[10'h1A7][8];	// rob.scala:307:32
        rob_val_1_24 = _RANDOM[10'h1A7][9];	// rob.scala:307:32
        rob_val_1_25 = _RANDOM[10'h1A7][10];	// rob.scala:307:32
        rob_val_1_26 = _RANDOM[10'h1A7][11];	// rob.scala:307:32
        rob_val_1_27 = _RANDOM[10'h1A7][12];	// rob.scala:307:32
        rob_val_1_28 = _RANDOM[10'h1A7][13];	// rob.scala:307:32
        rob_val_1_29 = _RANDOM[10'h1A7][14];	// rob.scala:307:32
        rob_val_1_30 = _RANDOM[10'h1A7][15];	// rob.scala:307:32
        rob_val_1_31 = _RANDOM[10'h1A7][16];	// rob.scala:307:32
        rob_bsy_1_0 = _RANDOM[10'h1A7][17];	// rob.scala:307:32, :308:28
        rob_bsy_1_1 = _RANDOM[10'h1A7][18];	// rob.scala:307:32, :308:28
        rob_bsy_1_2 = _RANDOM[10'h1A7][19];	// rob.scala:307:32, :308:28
        rob_bsy_1_3 = _RANDOM[10'h1A7][20];	// rob.scala:307:32, :308:28
        rob_bsy_1_4 = _RANDOM[10'h1A7][21];	// rob.scala:307:32, :308:28
        rob_bsy_1_5 = _RANDOM[10'h1A7][22];	// rob.scala:307:32, :308:28
        rob_bsy_1_6 = _RANDOM[10'h1A7][23];	// rob.scala:307:32, :308:28
        rob_bsy_1_7 = _RANDOM[10'h1A7][24];	// rob.scala:307:32, :308:28
        rob_bsy_1_8 = _RANDOM[10'h1A7][25];	// rob.scala:307:32, :308:28
        rob_bsy_1_9 = _RANDOM[10'h1A7][26];	// rob.scala:307:32, :308:28
        rob_bsy_1_10 = _RANDOM[10'h1A7][27];	// rob.scala:307:32, :308:28
        rob_bsy_1_11 = _RANDOM[10'h1A7][28];	// rob.scala:307:32, :308:28
        rob_bsy_1_12 = _RANDOM[10'h1A7][29];	// rob.scala:307:32, :308:28
        rob_bsy_1_13 = _RANDOM[10'h1A7][30];	// rob.scala:307:32, :308:28
        rob_bsy_1_14 = _RANDOM[10'h1A7][31];	// rob.scala:307:32, :308:28
        rob_bsy_1_15 = _RANDOM[10'h1A8][0];	// rob.scala:308:28
        rob_bsy_1_16 = _RANDOM[10'h1A8][1];	// rob.scala:308:28
        rob_bsy_1_17 = _RANDOM[10'h1A8][2];	// rob.scala:308:28
        rob_bsy_1_18 = _RANDOM[10'h1A8][3];	// rob.scala:308:28
        rob_bsy_1_19 = _RANDOM[10'h1A8][4];	// rob.scala:308:28
        rob_bsy_1_20 = _RANDOM[10'h1A8][5];	// rob.scala:308:28
        rob_bsy_1_21 = _RANDOM[10'h1A8][6];	// rob.scala:308:28
        rob_bsy_1_22 = _RANDOM[10'h1A8][7];	// rob.scala:308:28
        rob_bsy_1_23 = _RANDOM[10'h1A8][8];	// rob.scala:308:28
        rob_bsy_1_24 = _RANDOM[10'h1A8][9];	// rob.scala:308:28
        rob_bsy_1_25 = _RANDOM[10'h1A8][10];	// rob.scala:308:28
        rob_bsy_1_26 = _RANDOM[10'h1A8][11];	// rob.scala:308:28
        rob_bsy_1_27 = _RANDOM[10'h1A8][12];	// rob.scala:308:28
        rob_bsy_1_28 = _RANDOM[10'h1A8][13];	// rob.scala:308:28
        rob_bsy_1_29 = _RANDOM[10'h1A8][14];	// rob.scala:308:28
        rob_bsy_1_30 = _RANDOM[10'h1A8][15];	// rob.scala:308:28
        rob_bsy_1_31 = _RANDOM[10'h1A8][16];	// rob.scala:308:28
        rob_unsafe_1_0 = _RANDOM[10'h1A8][17];	// rob.scala:308:28, :309:28
        rob_unsafe_1_1 = _RANDOM[10'h1A8][18];	// rob.scala:308:28, :309:28
        rob_unsafe_1_2 = _RANDOM[10'h1A8][19];	// rob.scala:308:28, :309:28
        rob_unsafe_1_3 = _RANDOM[10'h1A8][20];	// rob.scala:308:28, :309:28
        rob_unsafe_1_4 = _RANDOM[10'h1A8][21];	// rob.scala:308:28, :309:28
        rob_unsafe_1_5 = _RANDOM[10'h1A8][22];	// rob.scala:308:28, :309:28
        rob_unsafe_1_6 = _RANDOM[10'h1A8][23];	// rob.scala:308:28, :309:28
        rob_unsafe_1_7 = _RANDOM[10'h1A8][24];	// rob.scala:308:28, :309:28
        rob_unsafe_1_8 = _RANDOM[10'h1A8][25];	// rob.scala:308:28, :309:28
        rob_unsafe_1_9 = _RANDOM[10'h1A8][26];	// rob.scala:308:28, :309:28
        rob_unsafe_1_10 = _RANDOM[10'h1A8][27];	// rob.scala:308:28, :309:28
        rob_unsafe_1_11 = _RANDOM[10'h1A8][28];	// rob.scala:308:28, :309:28
        rob_unsafe_1_12 = _RANDOM[10'h1A8][29];	// rob.scala:308:28, :309:28
        rob_unsafe_1_13 = _RANDOM[10'h1A8][30];	// rob.scala:308:28, :309:28
        rob_unsafe_1_14 = _RANDOM[10'h1A8][31];	// rob.scala:308:28, :309:28
        rob_unsafe_1_15 = _RANDOM[10'h1A9][0];	// rob.scala:309:28
        rob_unsafe_1_16 = _RANDOM[10'h1A9][1];	// rob.scala:309:28
        rob_unsafe_1_17 = _RANDOM[10'h1A9][2];	// rob.scala:309:28
        rob_unsafe_1_18 = _RANDOM[10'h1A9][3];	// rob.scala:309:28
        rob_unsafe_1_19 = _RANDOM[10'h1A9][4];	// rob.scala:309:28
        rob_unsafe_1_20 = _RANDOM[10'h1A9][5];	// rob.scala:309:28
        rob_unsafe_1_21 = _RANDOM[10'h1A9][6];	// rob.scala:309:28
        rob_unsafe_1_22 = _RANDOM[10'h1A9][7];	// rob.scala:309:28
        rob_unsafe_1_23 = _RANDOM[10'h1A9][8];	// rob.scala:309:28
        rob_unsafe_1_24 = _RANDOM[10'h1A9][9];	// rob.scala:309:28
        rob_unsafe_1_25 = _RANDOM[10'h1A9][10];	// rob.scala:309:28
        rob_unsafe_1_26 = _RANDOM[10'h1A9][11];	// rob.scala:309:28
        rob_unsafe_1_27 = _RANDOM[10'h1A9][12];	// rob.scala:309:28
        rob_unsafe_1_28 = _RANDOM[10'h1A9][13];	// rob.scala:309:28
        rob_unsafe_1_29 = _RANDOM[10'h1A9][14];	// rob.scala:309:28
        rob_unsafe_1_30 = _RANDOM[10'h1A9][15];	// rob.scala:309:28
        rob_unsafe_1_31 = _RANDOM[10'h1A9][16];	// rob.scala:309:28
        rob_uop_1_0_uopc = _RANDOM[10'h1A9][23:17];	// rob.scala:309:28, :310:28
        rob_uop_1_0_is_rvc = _RANDOM[10'h1AB][24];	// rob.scala:310:28
        rob_uop_1_0_br_mask = _RANDOM[10'h1AE][24:13];	// rob.scala:310:28
        rob_uop_1_0_ftq_idx = {_RANDOM[10'h1AE][31:29], _RANDOM[10'h1AF][1:0]};	// rob.scala:310:28
        rob_uop_1_0_edge_inst = _RANDOM[10'h1AF][2];	// rob.scala:310:28
        rob_uop_1_0_pc_lob = _RANDOM[10'h1AF][8:3];	// rob.scala:310:28
        rob_uop_1_0_pdst = {_RANDOM[10'h1B0][31:26], _RANDOM[10'h1B1][0]};	// rob.scala:310:28
        rob_uop_1_0_stale_pdst = {_RANDOM[10'h1B1][31], _RANDOM[10'h1B2][5:0]};	// rob.scala:310:28
        rob_uop_1_0_is_fencei = _RANDOM[10'h1B4][17];	// rob.scala:310:28
        rob_uop_1_0_uses_ldq = _RANDOM[10'h1B4][19];	// rob.scala:310:28
        rob_uop_1_0_uses_stq = _RANDOM[10'h1B4][20];	// rob.scala:310:28
        rob_uop_1_0_is_sys_pc2epc = _RANDOM[10'h1B4][21];	// rob.scala:310:28
        rob_uop_1_0_flush_on_commit = _RANDOM[10'h1B4][23];	// rob.scala:310:28
        rob_uop_1_0_ldst = _RANDOM[10'h1B4][30:25];	// rob.scala:310:28
        rob_uop_1_0_ldst_val = _RANDOM[10'h1B5][17];	// rob.scala:310:28
        rob_uop_1_0_dst_rtype = _RANDOM[10'h1B5][19:18];	// rob.scala:310:28
        rob_uop_1_0_fp_val = _RANDOM[10'h1B5][25];	// rob.scala:310:28
        rob_uop_1_1_uopc = _RANDOM[10'h1B6][10:4];	// rob.scala:310:28
        rob_uop_1_1_is_rvc = _RANDOM[10'h1B8][11];	// rob.scala:310:28
        rob_uop_1_1_br_mask = _RANDOM[10'h1BB][11:0];	// rob.scala:310:28
        rob_uop_1_1_ftq_idx = _RANDOM[10'h1BB][20:16];	// rob.scala:310:28
        rob_uop_1_1_edge_inst = _RANDOM[10'h1BB][21];	// rob.scala:310:28
        rob_uop_1_1_pc_lob = _RANDOM[10'h1BB][27:22];	// rob.scala:310:28
        rob_uop_1_1_pdst = _RANDOM[10'h1BD][19:13];	// rob.scala:310:28
        rob_uop_1_1_stale_pdst = _RANDOM[10'h1BE][24:18];	// rob.scala:310:28
        rob_uop_1_1_is_fencei = _RANDOM[10'h1C1][4];	// rob.scala:310:28
        rob_uop_1_1_uses_ldq = _RANDOM[10'h1C1][6];	// rob.scala:310:28
        rob_uop_1_1_uses_stq = _RANDOM[10'h1C1][7];	// rob.scala:310:28
        rob_uop_1_1_is_sys_pc2epc = _RANDOM[10'h1C1][8];	// rob.scala:310:28
        rob_uop_1_1_flush_on_commit = _RANDOM[10'h1C1][10];	// rob.scala:310:28
        rob_uop_1_1_ldst = _RANDOM[10'h1C1][17:12];	// rob.scala:310:28
        rob_uop_1_1_ldst_val = _RANDOM[10'h1C2][4];	// rob.scala:310:28
        rob_uop_1_1_dst_rtype = _RANDOM[10'h1C2][6:5];	// rob.scala:310:28
        rob_uop_1_1_fp_val = _RANDOM[10'h1C2][12];	// rob.scala:310:28
        rob_uop_1_2_uopc = _RANDOM[10'h1C2][29:23];	// rob.scala:310:28
        rob_uop_1_2_is_rvc = _RANDOM[10'h1C4][30];	// rob.scala:310:28
        rob_uop_1_2_br_mask = _RANDOM[10'h1C7][30:19];	// rob.scala:310:28
        rob_uop_1_2_ftq_idx = _RANDOM[10'h1C8][7:3];	// rob.scala:310:28
        rob_uop_1_2_edge_inst = _RANDOM[10'h1C8][8];	// rob.scala:310:28
        rob_uop_1_2_pc_lob = _RANDOM[10'h1C8][14:9];	// rob.scala:310:28
        rob_uop_1_2_pdst = _RANDOM[10'h1CA][6:0];	// rob.scala:310:28
        rob_uop_1_2_stale_pdst = _RANDOM[10'h1CB][11:5];	// rob.scala:310:28
        rob_uop_1_2_is_fencei = _RANDOM[10'h1CD][23];	// rob.scala:310:28
        rob_uop_1_2_uses_ldq = _RANDOM[10'h1CD][25];	// rob.scala:310:28
        rob_uop_1_2_uses_stq = _RANDOM[10'h1CD][26];	// rob.scala:310:28
        rob_uop_1_2_is_sys_pc2epc = _RANDOM[10'h1CD][27];	// rob.scala:310:28
        rob_uop_1_2_flush_on_commit = _RANDOM[10'h1CD][29];	// rob.scala:310:28
        rob_uop_1_2_ldst = {_RANDOM[10'h1CD][31], _RANDOM[10'h1CE][4:0]};	// rob.scala:310:28
        rob_uop_1_2_ldst_val = _RANDOM[10'h1CE][23];	// rob.scala:310:28
        rob_uop_1_2_dst_rtype = _RANDOM[10'h1CE][25:24];	// rob.scala:310:28
        rob_uop_1_2_fp_val = _RANDOM[10'h1CE][31];	// rob.scala:310:28
        rob_uop_1_3_uopc = _RANDOM[10'h1CF][16:10];	// rob.scala:310:28
        rob_uop_1_3_is_rvc = _RANDOM[10'h1D1][17];	// rob.scala:310:28
        rob_uop_1_3_br_mask = _RANDOM[10'h1D4][17:6];	// rob.scala:310:28
        rob_uop_1_3_ftq_idx = _RANDOM[10'h1D4][26:22];	// rob.scala:310:28
        rob_uop_1_3_edge_inst = _RANDOM[10'h1D4][27];	// rob.scala:310:28
        rob_uop_1_3_pc_lob = {_RANDOM[10'h1D4][31:28], _RANDOM[10'h1D5][1:0]};	// rob.scala:310:28
        rob_uop_1_3_pdst = _RANDOM[10'h1D6][25:19];	// rob.scala:310:28
        rob_uop_1_3_stale_pdst = _RANDOM[10'h1D7][30:24];	// rob.scala:310:28
        rob_uop_1_3_is_fencei = _RANDOM[10'h1DA][10];	// rob.scala:310:28
        rob_uop_1_3_uses_ldq = _RANDOM[10'h1DA][12];	// rob.scala:310:28
        rob_uop_1_3_uses_stq = _RANDOM[10'h1DA][13];	// rob.scala:310:28
        rob_uop_1_3_is_sys_pc2epc = _RANDOM[10'h1DA][14];	// rob.scala:310:28
        rob_uop_1_3_flush_on_commit = _RANDOM[10'h1DA][16];	// rob.scala:310:28
        rob_uop_1_3_ldst = _RANDOM[10'h1DA][23:18];	// rob.scala:310:28
        rob_uop_1_3_ldst_val = _RANDOM[10'h1DB][10];	// rob.scala:310:28
        rob_uop_1_3_dst_rtype = _RANDOM[10'h1DB][12:11];	// rob.scala:310:28
        rob_uop_1_3_fp_val = _RANDOM[10'h1DB][18];	// rob.scala:310:28
        rob_uop_1_4_uopc = {_RANDOM[10'h1DB][31:29], _RANDOM[10'h1DC][3:0]};	// rob.scala:310:28
        rob_uop_1_4_is_rvc = _RANDOM[10'h1DE][4];	// rob.scala:310:28
        rob_uop_1_4_br_mask = {_RANDOM[10'h1E0][31:25], _RANDOM[10'h1E1][4:0]};	// rob.scala:310:28
        rob_uop_1_4_ftq_idx = _RANDOM[10'h1E1][13:9];	// rob.scala:310:28
        rob_uop_1_4_edge_inst = _RANDOM[10'h1E1][14];	// rob.scala:310:28
        rob_uop_1_4_pc_lob = _RANDOM[10'h1E1][20:15];	// rob.scala:310:28
        rob_uop_1_4_pdst = _RANDOM[10'h1E3][12:6];	// rob.scala:310:28
        rob_uop_1_4_stale_pdst = _RANDOM[10'h1E4][17:11];	// rob.scala:310:28
        rob_uop_1_4_is_fencei = _RANDOM[10'h1E6][29];	// rob.scala:310:28
        rob_uop_1_4_uses_ldq = _RANDOM[10'h1E6][31];	// rob.scala:310:28
        rob_uop_1_4_uses_stq = _RANDOM[10'h1E7][0];	// rob.scala:310:28
        rob_uop_1_4_is_sys_pc2epc = _RANDOM[10'h1E7][1];	// rob.scala:310:28
        rob_uop_1_4_flush_on_commit = _RANDOM[10'h1E7][3];	// rob.scala:310:28
        rob_uop_1_4_ldst = _RANDOM[10'h1E7][10:5];	// rob.scala:310:28
        rob_uop_1_4_ldst_val = _RANDOM[10'h1E7][29];	// rob.scala:310:28
        rob_uop_1_4_dst_rtype = _RANDOM[10'h1E7][31:30];	// rob.scala:310:28
        rob_uop_1_4_fp_val = _RANDOM[10'h1E8][5];	// rob.scala:310:28
        rob_uop_1_5_uopc = _RANDOM[10'h1E8][22:16];	// rob.scala:310:28
        rob_uop_1_5_is_rvc = _RANDOM[10'h1EA][23];	// rob.scala:310:28
        rob_uop_1_5_br_mask = _RANDOM[10'h1ED][23:12];	// rob.scala:310:28
        rob_uop_1_5_ftq_idx = {_RANDOM[10'h1ED][31:28], _RANDOM[10'h1EE][0]};	// rob.scala:310:28
        rob_uop_1_5_edge_inst = _RANDOM[10'h1EE][1];	// rob.scala:310:28
        rob_uop_1_5_pc_lob = _RANDOM[10'h1EE][7:2];	// rob.scala:310:28
        rob_uop_1_5_pdst = _RANDOM[10'h1EF][31:25];	// rob.scala:310:28
        rob_uop_1_5_stale_pdst = {_RANDOM[10'h1F0][31:30], _RANDOM[10'h1F1][4:0]};	// rob.scala:310:28
        rob_uop_1_5_is_fencei = _RANDOM[10'h1F3][16];	// rob.scala:310:28
        rob_uop_1_5_uses_ldq = _RANDOM[10'h1F3][18];	// rob.scala:310:28
        rob_uop_1_5_uses_stq = _RANDOM[10'h1F3][19];	// rob.scala:310:28
        rob_uop_1_5_is_sys_pc2epc = _RANDOM[10'h1F3][20];	// rob.scala:310:28
        rob_uop_1_5_flush_on_commit = _RANDOM[10'h1F3][22];	// rob.scala:310:28
        rob_uop_1_5_ldst = _RANDOM[10'h1F3][29:24];	// rob.scala:310:28
        rob_uop_1_5_ldst_val = _RANDOM[10'h1F4][16];	// rob.scala:310:28
        rob_uop_1_5_dst_rtype = _RANDOM[10'h1F4][18:17];	// rob.scala:310:28
        rob_uop_1_5_fp_val = _RANDOM[10'h1F4][24];	// rob.scala:310:28
        rob_uop_1_6_uopc = _RANDOM[10'h1F5][9:3];	// rob.scala:310:28
        rob_uop_1_6_is_rvc = _RANDOM[10'h1F7][10];	// rob.scala:310:28
        rob_uop_1_6_br_mask = {_RANDOM[10'h1F9][31], _RANDOM[10'h1FA][10:0]};	// rob.scala:310:28
        rob_uop_1_6_ftq_idx = _RANDOM[10'h1FA][19:15];	// rob.scala:310:28
        rob_uop_1_6_edge_inst = _RANDOM[10'h1FA][20];	// rob.scala:310:28
        rob_uop_1_6_pc_lob = _RANDOM[10'h1FA][26:21];	// rob.scala:310:28
        rob_uop_1_6_pdst = _RANDOM[10'h1FC][18:12];	// rob.scala:310:28
        rob_uop_1_6_stale_pdst = _RANDOM[10'h1FD][23:17];	// rob.scala:310:28
        rob_uop_1_6_is_fencei = _RANDOM[10'h200][3];	// rob.scala:310:28
        rob_uop_1_6_uses_ldq = _RANDOM[10'h200][5];	// rob.scala:310:28
        rob_uop_1_6_uses_stq = _RANDOM[10'h200][6];	// rob.scala:310:28
        rob_uop_1_6_is_sys_pc2epc = _RANDOM[10'h200][7];	// rob.scala:310:28
        rob_uop_1_6_flush_on_commit = _RANDOM[10'h200][9];	// rob.scala:310:28
        rob_uop_1_6_ldst = _RANDOM[10'h200][16:11];	// rob.scala:310:28
        rob_uop_1_6_ldst_val = _RANDOM[10'h201][3];	// rob.scala:310:28
        rob_uop_1_6_dst_rtype = _RANDOM[10'h201][5:4];	// rob.scala:310:28
        rob_uop_1_6_fp_val = _RANDOM[10'h201][11];	// rob.scala:310:28
        rob_uop_1_7_uopc = _RANDOM[10'h201][28:22];	// rob.scala:310:28
        rob_uop_1_7_is_rvc = _RANDOM[10'h203][29];	// rob.scala:310:28
        rob_uop_1_7_br_mask = _RANDOM[10'h206][29:18];	// rob.scala:310:28
        rob_uop_1_7_ftq_idx = _RANDOM[10'h207][6:2];	// rob.scala:310:28
        rob_uop_1_7_edge_inst = _RANDOM[10'h207][7];	// rob.scala:310:28
        rob_uop_1_7_pc_lob = _RANDOM[10'h207][13:8];	// rob.scala:310:28
        rob_uop_1_7_pdst = {_RANDOM[10'h208][31], _RANDOM[10'h209][5:0]};	// rob.scala:310:28
        rob_uop_1_7_stale_pdst = _RANDOM[10'h20A][10:4];	// rob.scala:310:28
        rob_uop_1_7_is_fencei = _RANDOM[10'h20C][22];	// rob.scala:310:28
        rob_uop_1_7_uses_ldq = _RANDOM[10'h20C][24];	// rob.scala:310:28
        rob_uop_1_7_uses_stq = _RANDOM[10'h20C][25];	// rob.scala:310:28
        rob_uop_1_7_is_sys_pc2epc = _RANDOM[10'h20C][26];	// rob.scala:310:28
        rob_uop_1_7_flush_on_commit = _RANDOM[10'h20C][28];	// rob.scala:310:28
        rob_uop_1_7_ldst = {_RANDOM[10'h20C][31:30], _RANDOM[10'h20D][3:0]};	// rob.scala:310:28
        rob_uop_1_7_ldst_val = _RANDOM[10'h20D][22];	// rob.scala:310:28
        rob_uop_1_7_dst_rtype = _RANDOM[10'h20D][24:23];	// rob.scala:310:28
        rob_uop_1_7_fp_val = _RANDOM[10'h20D][30];	// rob.scala:310:28
        rob_uop_1_8_uopc = _RANDOM[10'h20E][15:9];	// rob.scala:310:28
        rob_uop_1_8_is_rvc = _RANDOM[10'h210][16];	// rob.scala:310:28
        rob_uop_1_8_br_mask = _RANDOM[10'h213][16:5];	// rob.scala:310:28
        rob_uop_1_8_ftq_idx = _RANDOM[10'h213][25:21];	// rob.scala:310:28
        rob_uop_1_8_edge_inst = _RANDOM[10'h213][26];	// rob.scala:310:28
        rob_uop_1_8_pc_lob = {_RANDOM[10'h213][31:27], _RANDOM[10'h214][0]};	// rob.scala:310:28
        rob_uop_1_8_pdst = _RANDOM[10'h215][24:18];	// rob.scala:310:28
        rob_uop_1_8_stale_pdst = _RANDOM[10'h216][29:23];	// rob.scala:310:28
        rob_uop_1_8_is_fencei = _RANDOM[10'h219][9];	// rob.scala:310:28
        rob_uop_1_8_uses_ldq = _RANDOM[10'h219][11];	// rob.scala:310:28
        rob_uop_1_8_uses_stq = _RANDOM[10'h219][12];	// rob.scala:310:28
        rob_uop_1_8_is_sys_pc2epc = _RANDOM[10'h219][13];	// rob.scala:310:28
        rob_uop_1_8_flush_on_commit = _RANDOM[10'h219][15];	// rob.scala:310:28
        rob_uop_1_8_ldst = _RANDOM[10'h219][22:17];	// rob.scala:310:28
        rob_uop_1_8_ldst_val = _RANDOM[10'h21A][9];	// rob.scala:310:28
        rob_uop_1_8_dst_rtype = _RANDOM[10'h21A][11:10];	// rob.scala:310:28
        rob_uop_1_8_fp_val = _RANDOM[10'h21A][17];	// rob.scala:310:28
        rob_uop_1_9_uopc = {_RANDOM[10'h21A][31:28], _RANDOM[10'h21B][2:0]};	// rob.scala:310:28
        rob_uop_1_9_is_rvc = _RANDOM[10'h21D][3];	// rob.scala:310:28
        rob_uop_1_9_br_mask = {_RANDOM[10'h21F][31:24], _RANDOM[10'h220][3:0]};	// rob.scala:310:28
        rob_uop_1_9_ftq_idx = _RANDOM[10'h220][12:8];	// rob.scala:310:28
        rob_uop_1_9_edge_inst = _RANDOM[10'h220][13];	// rob.scala:310:28
        rob_uop_1_9_pc_lob = _RANDOM[10'h220][19:14];	// rob.scala:310:28
        rob_uop_1_9_pdst = _RANDOM[10'h222][11:5];	// rob.scala:310:28
        rob_uop_1_9_stale_pdst = _RANDOM[10'h223][16:10];	// rob.scala:310:28
        rob_uop_1_9_is_fencei = _RANDOM[10'h225][28];	// rob.scala:310:28
        rob_uop_1_9_uses_ldq = _RANDOM[10'h225][30];	// rob.scala:310:28
        rob_uop_1_9_uses_stq = _RANDOM[10'h225][31];	// rob.scala:310:28
        rob_uop_1_9_is_sys_pc2epc = _RANDOM[10'h226][0];	// rob.scala:310:28
        rob_uop_1_9_flush_on_commit = _RANDOM[10'h226][2];	// rob.scala:310:28
        rob_uop_1_9_ldst = _RANDOM[10'h226][9:4];	// rob.scala:310:28
        rob_uop_1_9_ldst_val = _RANDOM[10'h226][28];	// rob.scala:310:28
        rob_uop_1_9_dst_rtype = _RANDOM[10'h226][30:29];	// rob.scala:310:28
        rob_uop_1_9_fp_val = _RANDOM[10'h227][4];	// rob.scala:310:28
        rob_uop_1_10_uopc = _RANDOM[10'h227][21:15];	// rob.scala:310:28
        rob_uop_1_10_is_rvc = _RANDOM[10'h229][22];	// rob.scala:310:28
        rob_uop_1_10_br_mask = _RANDOM[10'h22C][22:11];	// rob.scala:310:28
        rob_uop_1_10_ftq_idx = _RANDOM[10'h22C][31:27];	// rob.scala:310:28
        rob_uop_1_10_edge_inst = _RANDOM[10'h22D][0];	// rob.scala:310:28
        rob_uop_1_10_pc_lob = _RANDOM[10'h22D][6:1];	// rob.scala:310:28
        rob_uop_1_10_pdst = _RANDOM[10'h22E][30:24];	// rob.scala:310:28
        rob_uop_1_10_stale_pdst = {_RANDOM[10'h22F][31:29], _RANDOM[10'h230][3:0]};	// rob.scala:310:28
        rob_uop_1_10_is_fencei = _RANDOM[10'h232][15];	// rob.scala:310:28
        rob_uop_1_10_uses_ldq = _RANDOM[10'h232][17];	// rob.scala:310:28
        rob_uop_1_10_uses_stq = _RANDOM[10'h232][18];	// rob.scala:310:28
        rob_uop_1_10_is_sys_pc2epc = _RANDOM[10'h232][19];	// rob.scala:310:28
        rob_uop_1_10_flush_on_commit = _RANDOM[10'h232][21];	// rob.scala:310:28
        rob_uop_1_10_ldst = _RANDOM[10'h232][28:23];	// rob.scala:310:28
        rob_uop_1_10_ldst_val = _RANDOM[10'h233][15];	// rob.scala:310:28
        rob_uop_1_10_dst_rtype = _RANDOM[10'h233][17:16];	// rob.scala:310:28
        rob_uop_1_10_fp_val = _RANDOM[10'h233][23];	// rob.scala:310:28
        rob_uop_1_11_uopc = _RANDOM[10'h234][8:2];	// rob.scala:310:28
        rob_uop_1_11_is_rvc = _RANDOM[10'h236][9];	// rob.scala:310:28
        rob_uop_1_11_br_mask = {_RANDOM[10'h238][31:30], _RANDOM[10'h239][9:0]};	// rob.scala:310:28
        rob_uop_1_11_ftq_idx = _RANDOM[10'h239][18:14];	// rob.scala:310:28
        rob_uop_1_11_edge_inst = _RANDOM[10'h239][19];	// rob.scala:310:28
        rob_uop_1_11_pc_lob = _RANDOM[10'h239][25:20];	// rob.scala:310:28
        rob_uop_1_11_pdst = _RANDOM[10'h23B][17:11];	// rob.scala:310:28
        rob_uop_1_11_stale_pdst = _RANDOM[10'h23C][22:16];	// rob.scala:310:28
        rob_uop_1_11_is_fencei = _RANDOM[10'h23F][2];	// rob.scala:310:28
        rob_uop_1_11_uses_ldq = _RANDOM[10'h23F][4];	// rob.scala:310:28
        rob_uop_1_11_uses_stq = _RANDOM[10'h23F][5];	// rob.scala:310:28
        rob_uop_1_11_is_sys_pc2epc = _RANDOM[10'h23F][6];	// rob.scala:310:28
        rob_uop_1_11_flush_on_commit = _RANDOM[10'h23F][8];	// rob.scala:310:28
        rob_uop_1_11_ldst = _RANDOM[10'h23F][15:10];	// rob.scala:310:28
        rob_uop_1_11_ldst_val = _RANDOM[10'h240][2];	// rob.scala:310:28
        rob_uop_1_11_dst_rtype = _RANDOM[10'h240][4:3];	// rob.scala:310:28
        rob_uop_1_11_fp_val = _RANDOM[10'h240][10];	// rob.scala:310:28
        rob_uop_1_12_uopc = _RANDOM[10'h240][27:21];	// rob.scala:310:28
        rob_uop_1_12_is_rvc = _RANDOM[10'h242][28];	// rob.scala:310:28
        rob_uop_1_12_br_mask = _RANDOM[10'h245][28:17];	// rob.scala:310:28
        rob_uop_1_12_ftq_idx = _RANDOM[10'h246][5:1];	// rob.scala:310:28
        rob_uop_1_12_edge_inst = _RANDOM[10'h246][6];	// rob.scala:310:28
        rob_uop_1_12_pc_lob = _RANDOM[10'h246][12:7];	// rob.scala:310:28
        rob_uop_1_12_pdst = {_RANDOM[10'h247][31:30], _RANDOM[10'h248][4:0]};	// rob.scala:310:28
        rob_uop_1_12_stale_pdst = _RANDOM[10'h249][9:3];	// rob.scala:310:28
        rob_uop_1_12_is_fencei = _RANDOM[10'h24B][21];	// rob.scala:310:28
        rob_uop_1_12_uses_ldq = _RANDOM[10'h24B][23];	// rob.scala:310:28
        rob_uop_1_12_uses_stq = _RANDOM[10'h24B][24];	// rob.scala:310:28
        rob_uop_1_12_is_sys_pc2epc = _RANDOM[10'h24B][25];	// rob.scala:310:28
        rob_uop_1_12_flush_on_commit = _RANDOM[10'h24B][27];	// rob.scala:310:28
        rob_uop_1_12_ldst = {_RANDOM[10'h24B][31:29], _RANDOM[10'h24C][2:0]};	// rob.scala:310:28
        rob_uop_1_12_ldst_val = _RANDOM[10'h24C][21];	// rob.scala:310:28
        rob_uop_1_12_dst_rtype = _RANDOM[10'h24C][23:22];	// rob.scala:310:28
        rob_uop_1_12_fp_val = _RANDOM[10'h24C][29];	// rob.scala:310:28
        rob_uop_1_13_uopc = _RANDOM[10'h24D][14:8];	// rob.scala:310:28
        rob_uop_1_13_is_rvc = _RANDOM[10'h24F][15];	// rob.scala:310:28
        rob_uop_1_13_br_mask = _RANDOM[10'h252][15:4];	// rob.scala:310:28
        rob_uop_1_13_ftq_idx = _RANDOM[10'h252][24:20];	// rob.scala:310:28
        rob_uop_1_13_edge_inst = _RANDOM[10'h252][25];	// rob.scala:310:28
        rob_uop_1_13_pc_lob = _RANDOM[10'h252][31:26];	// rob.scala:310:28
        rob_uop_1_13_pdst = _RANDOM[10'h254][23:17];	// rob.scala:310:28
        rob_uop_1_13_stale_pdst = _RANDOM[10'h255][28:22];	// rob.scala:310:28
        rob_uop_1_13_is_fencei = _RANDOM[10'h258][8];	// rob.scala:310:28
        rob_uop_1_13_uses_ldq = _RANDOM[10'h258][10];	// rob.scala:310:28
        rob_uop_1_13_uses_stq = _RANDOM[10'h258][11];	// rob.scala:310:28
        rob_uop_1_13_is_sys_pc2epc = _RANDOM[10'h258][12];	// rob.scala:310:28
        rob_uop_1_13_flush_on_commit = _RANDOM[10'h258][14];	// rob.scala:310:28
        rob_uop_1_13_ldst = _RANDOM[10'h258][21:16];	// rob.scala:310:28
        rob_uop_1_13_ldst_val = _RANDOM[10'h259][8];	// rob.scala:310:28
        rob_uop_1_13_dst_rtype = _RANDOM[10'h259][10:9];	// rob.scala:310:28
        rob_uop_1_13_fp_val = _RANDOM[10'h259][16];	// rob.scala:310:28
        rob_uop_1_14_uopc = {_RANDOM[10'h259][31:27], _RANDOM[10'h25A][1:0]};	// rob.scala:310:28
        rob_uop_1_14_is_rvc = _RANDOM[10'h25C][2];	// rob.scala:310:28
        rob_uop_1_14_br_mask = {_RANDOM[10'h25E][31:23], _RANDOM[10'h25F][2:0]};	// rob.scala:310:28
        rob_uop_1_14_ftq_idx = _RANDOM[10'h25F][11:7];	// rob.scala:310:28
        rob_uop_1_14_edge_inst = _RANDOM[10'h25F][12];	// rob.scala:310:28
        rob_uop_1_14_pc_lob = _RANDOM[10'h25F][18:13];	// rob.scala:310:28
        rob_uop_1_14_pdst = _RANDOM[10'h261][10:4];	// rob.scala:310:28
        rob_uop_1_14_stale_pdst = _RANDOM[10'h262][15:9];	// rob.scala:310:28
        rob_uop_1_14_is_fencei = _RANDOM[10'h264][27];	// rob.scala:310:28
        rob_uop_1_14_uses_ldq = _RANDOM[10'h264][29];	// rob.scala:310:28
        rob_uop_1_14_uses_stq = _RANDOM[10'h264][30];	// rob.scala:310:28
        rob_uop_1_14_is_sys_pc2epc = _RANDOM[10'h264][31];	// rob.scala:310:28
        rob_uop_1_14_flush_on_commit = _RANDOM[10'h265][1];	// rob.scala:310:28
        rob_uop_1_14_ldst = _RANDOM[10'h265][8:3];	// rob.scala:310:28
        rob_uop_1_14_ldst_val = _RANDOM[10'h265][27];	// rob.scala:310:28
        rob_uop_1_14_dst_rtype = _RANDOM[10'h265][29:28];	// rob.scala:310:28
        rob_uop_1_14_fp_val = _RANDOM[10'h266][3];	// rob.scala:310:28
        rob_uop_1_15_uopc = _RANDOM[10'h266][20:14];	// rob.scala:310:28
        rob_uop_1_15_is_rvc = _RANDOM[10'h268][21];	// rob.scala:310:28
        rob_uop_1_15_br_mask = _RANDOM[10'h26B][21:10];	// rob.scala:310:28
        rob_uop_1_15_ftq_idx = _RANDOM[10'h26B][30:26];	// rob.scala:310:28
        rob_uop_1_15_edge_inst = _RANDOM[10'h26B][31];	// rob.scala:310:28
        rob_uop_1_15_pc_lob = _RANDOM[10'h26C][5:0];	// rob.scala:310:28
        rob_uop_1_15_pdst = _RANDOM[10'h26D][29:23];	// rob.scala:310:28
        rob_uop_1_15_stale_pdst = {_RANDOM[10'h26E][31:28], _RANDOM[10'h26F][2:0]};	// rob.scala:310:28
        rob_uop_1_15_is_fencei = _RANDOM[10'h271][14];	// rob.scala:310:28
        rob_uop_1_15_uses_ldq = _RANDOM[10'h271][16];	// rob.scala:310:28
        rob_uop_1_15_uses_stq = _RANDOM[10'h271][17];	// rob.scala:310:28
        rob_uop_1_15_is_sys_pc2epc = _RANDOM[10'h271][18];	// rob.scala:310:28
        rob_uop_1_15_flush_on_commit = _RANDOM[10'h271][20];	// rob.scala:310:28
        rob_uop_1_15_ldst = _RANDOM[10'h271][27:22];	// rob.scala:310:28
        rob_uop_1_15_ldst_val = _RANDOM[10'h272][14];	// rob.scala:310:28
        rob_uop_1_15_dst_rtype = _RANDOM[10'h272][16:15];	// rob.scala:310:28
        rob_uop_1_15_fp_val = _RANDOM[10'h272][22];	// rob.scala:310:28
        rob_uop_1_16_uopc = _RANDOM[10'h273][7:1];	// rob.scala:310:28
        rob_uop_1_16_is_rvc = _RANDOM[10'h275][8];	// rob.scala:310:28
        rob_uop_1_16_br_mask = {_RANDOM[10'h277][31:29], _RANDOM[10'h278][8:0]};	// rob.scala:310:28
        rob_uop_1_16_ftq_idx = _RANDOM[10'h278][17:13];	// rob.scala:310:28
        rob_uop_1_16_edge_inst = _RANDOM[10'h278][18];	// rob.scala:310:28
        rob_uop_1_16_pc_lob = _RANDOM[10'h278][24:19];	// rob.scala:310:28
        rob_uop_1_16_pdst = _RANDOM[10'h27A][16:10];	// rob.scala:310:28
        rob_uop_1_16_stale_pdst = _RANDOM[10'h27B][21:15];	// rob.scala:310:28
        rob_uop_1_16_is_fencei = _RANDOM[10'h27E][1];	// rob.scala:310:28
        rob_uop_1_16_uses_ldq = _RANDOM[10'h27E][3];	// rob.scala:310:28
        rob_uop_1_16_uses_stq = _RANDOM[10'h27E][4];	// rob.scala:310:28
        rob_uop_1_16_is_sys_pc2epc = _RANDOM[10'h27E][5];	// rob.scala:310:28
        rob_uop_1_16_flush_on_commit = _RANDOM[10'h27E][7];	// rob.scala:310:28
        rob_uop_1_16_ldst = _RANDOM[10'h27E][14:9];	// rob.scala:310:28
        rob_uop_1_16_ldst_val = _RANDOM[10'h27F][1];	// rob.scala:310:28
        rob_uop_1_16_dst_rtype = _RANDOM[10'h27F][3:2];	// rob.scala:310:28
        rob_uop_1_16_fp_val = _RANDOM[10'h27F][9];	// rob.scala:310:28
        rob_uop_1_17_uopc = _RANDOM[10'h27F][26:20];	// rob.scala:310:28
        rob_uop_1_17_is_rvc = _RANDOM[10'h281][27];	// rob.scala:310:28
        rob_uop_1_17_br_mask = _RANDOM[10'h284][27:16];	// rob.scala:310:28
        rob_uop_1_17_ftq_idx = _RANDOM[10'h285][4:0];	// rob.scala:310:28
        rob_uop_1_17_edge_inst = _RANDOM[10'h285][5];	// rob.scala:310:28
        rob_uop_1_17_pc_lob = _RANDOM[10'h285][11:6];	// rob.scala:310:28
        rob_uop_1_17_pdst = {_RANDOM[10'h286][31:29], _RANDOM[10'h287][3:0]};	// rob.scala:310:28
        rob_uop_1_17_stale_pdst = _RANDOM[10'h288][8:2];	// rob.scala:310:28
        rob_uop_1_17_is_fencei = _RANDOM[10'h28A][20];	// rob.scala:310:28
        rob_uop_1_17_uses_ldq = _RANDOM[10'h28A][22];	// rob.scala:310:28
        rob_uop_1_17_uses_stq = _RANDOM[10'h28A][23];	// rob.scala:310:28
        rob_uop_1_17_is_sys_pc2epc = _RANDOM[10'h28A][24];	// rob.scala:310:28
        rob_uop_1_17_flush_on_commit = _RANDOM[10'h28A][26];	// rob.scala:310:28
        rob_uop_1_17_ldst = {_RANDOM[10'h28A][31:28], _RANDOM[10'h28B][1:0]};	// rob.scala:310:28
        rob_uop_1_17_ldst_val = _RANDOM[10'h28B][20];	// rob.scala:310:28
        rob_uop_1_17_dst_rtype = _RANDOM[10'h28B][22:21];	// rob.scala:310:28
        rob_uop_1_17_fp_val = _RANDOM[10'h28B][28];	// rob.scala:310:28
        rob_uop_1_18_uopc = _RANDOM[10'h28C][13:7];	// rob.scala:310:28
        rob_uop_1_18_is_rvc = _RANDOM[10'h28E][14];	// rob.scala:310:28
        rob_uop_1_18_br_mask = _RANDOM[10'h291][14:3];	// rob.scala:310:28
        rob_uop_1_18_ftq_idx = _RANDOM[10'h291][23:19];	// rob.scala:310:28
        rob_uop_1_18_edge_inst = _RANDOM[10'h291][24];	// rob.scala:310:28
        rob_uop_1_18_pc_lob = _RANDOM[10'h291][30:25];	// rob.scala:310:28
        rob_uop_1_18_pdst = _RANDOM[10'h293][22:16];	// rob.scala:310:28
        rob_uop_1_18_stale_pdst = _RANDOM[10'h294][27:21];	// rob.scala:310:28
        rob_uop_1_18_is_fencei = _RANDOM[10'h297][7];	// rob.scala:310:28
        rob_uop_1_18_uses_ldq = _RANDOM[10'h297][9];	// rob.scala:310:28
        rob_uop_1_18_uses_stq = _RANDOM[10'h297][10];	// rob.scala:310:28
        rob_uop_1_18_is_sys_pc2epc = _RANDOM[10'h297][11];	// rob.scala:310:28
        rob_uop_1_18_flush_on_commit = _RANDOM[10'h297][13];	// rob.scala:310:28
        rob_uop_1_18_ldst = _RANDOM[10'h297][20:15];	// rob.scala:310:28
        rob_uop_1_18_ldst_val = _RANDOM[10'h298][7];	// rob.scala:310:28
        rob_uop_1_18_dst_rtype = _RANDOM[10'h298][9:8];	// rob.scala:310:28
        rob_uop_1_18_fp_val = _RANDOM[10'h298][15];	// rob.scala:310:28
        rob_uop_1_19_uopc = {_RANDOM[10'h298][31:26], _RANDOM[10'h299][0]};	// rob.scala:310:28
        rob_uop_1_19_is_rvc = _RANDOM[10'h29B][1];	// rob.scala:310:28
        rob_uop_1_19_br_mask = {_RANDOM[10'h29D][31:22], _RANDOM[10'h29E][1:0]};	// rob.scala:310:28
        rob_uop_1_19_ftq_idx = _RANDOM[10'h29E][10:6];	// rob.scala:310:28
        rob_uop_1_19_edge_inst = _RANDOM[10'h29E][11];	// rob.scala:310:28
        rob_uop_1_19_pc_lob = _RANDOM[10'h29E][17:12];	// rob.scala:310:28
        rob_uop_1_19_pdst = _RANDOM[10'h2A0][9:3];	// rob.scala:310:28
        rob_uop_1_19_stale_pdst = _RANDOM[10'h2A1][14:8];	// rob.scala:310:28
        rob_uop_1_19_is_fencei = _RANDOM[10'h2A3][26];	// rob.scala:310:28
        rob_uop_1_19_uses_ldq = _RANDOM[10'h2A3][28];	// rob.scala:310:28
        rob_uop_1_19_uses_stq = _RANDOM[10'h2A3][29];	// rob.scala:310:28
        rob_uop_1_19_is_sys_pc2epc = _RANDOM[10'h2A3][30];	// rob.scala:310:28
        rob_uop_1_19_flush_on_commit = _RANDOM[10'h2A4][0];	// rob.scala:310:28
        rob_uop_1_19_ldst = _RANDOM[10'h2A4][7:2];	// rob.scala:310:28
        rob_uop_1_19_ldst_val = _RANDOM[10'h2A4][26];	// rob.scala:310:28
        rob_uop_1_19_dst_rtype = _RANDOM[10'h2A4][28:27];	// rob.scala:310:28
        rob_uop_1_19_fp_val = _RANDOM[10'h2A5][2];	// rob.scala:310:28
        rob_uop_1_20_uopc = _RANDOM[10'h2A5][19:13];	// rob.scala:310:28
        rob_uop_1_20_is_rvc = _RANDOM[10'h2A7][20];	// rob.scala:310:28
        rob_uop_1_20_br_mask = _RANDOM[10'h2AA][20:9];	// rob.scala:310:28
        rob_uop_1_20_ftq_idx = _RANDOM[10'h2AA][29:25];	// rob.scala:310:28
        rob_uop_1_20_edge_inst = _RANDOM[10'h2AA][30];	// rob.scala:310:28
        rob_uop_1_20_pc_lob = {_RANDOM[10'h2AA][31], _RANDOM[10'h2AB][4:0]};	// rob.scala:310:28
        rob_uop_1_20_pdst = _RANDOM[10'h2AC][28:22];	// rob.scala:310:28
        rob_uop_1_20_stale_pdst = {_RANDOM[10'h2AD][31:27], _RANDOM[10'h2AE][1:0]};	// rob.scala:310:28
        rob_uop_1_20_is_fencei = _RANDOM[10'h2B0][13];	// rob.scala:310:28
        rob_uop_1_20_uses_ldq = _RANDOM[10'h2B0][15];	// rob.scala:310:28
        rob_uop_1_20_uses_stq = _RANDOM[10'h2B0][16];	// rob.scala:310:28
        rob_uop_1_20_is_sys_pc2epc = _RANDOM[10'h2B0][17];	// rob.scala:310:28
        rob_uop_1_20_flush_on_commit = _RANDOM[10'h2B0][19];	// rob.scala:310:28
        rob_uop_1_20_ldst = _RANDOM[10'h2B0][26:21];	// rob.scala:310:28
        rob_uop_1_20_ldst_val = _RANDOM[10'h2B1][13];	// rob.scala:310:28
        rob_uop_1_20_dst_rtype = _RANDOM[10'h2B1][15:14];	// rob.scala:310:28
        rob_uop_1_20_fp_val = _RANDOM[10'h2B1][21];	// rob.scala:310:28
        rob_uop_1_21_uopc = _RANDOM[10'h2B2][6:0];	// rob.scala:310:28
        rob_uop_1_21_is_rvc = _RANDOM[10'h2B4][7];	// rob.scala:310:28
        rob_uop_1_21_br_mask = {_RANDOM[10'h2B6][31:28], _RANDOM[10'h2B7][7:0]};	// rob.scala:310:28
        rob_uop_1_21_ftq_idx = _RANDOM[10'h2B7][16:12];	// rob.scala:310:28
        rob_uop_1_21_edge_inst = _RANDOM[10'h2B7][17];	// rob.scala:310:28
        rob_uop_1_21_pc_lob = _RANDOM[10'h2B7][23:18];	// rob.scala:310:28
        rob_uop_1_21_pdst = _RANDOM[10'h2B9][15:9];	// rob.scala:310:28
        rob_uop_1_21_stale_pdst = _RANDOM[10'h2BA][20:14];	// rob.scala:310:28
        rob_uop_1_21_is_fencei = _RANDOM[10'h2BD][0];	// rob.scala:310:28
        rob_uop_1_21_uses_ldq = _RANDOM[10'h2BD][2];	// rob.scala:310:28
        rob_uop_1_21_uses_stq = _RANDOM[10'h2BD][3];	// rob.scala:310:28
        rob_uop_1_21_is_sys_pc2epc = _RANDOM[10'h2BD][4];	// rob.scala:310:28
        rob_uop_1_21_flush_on_commit = _RANDOM[10'h2BD][6];	// rob.scala:310:28
        rob_uop_1_21_ldst = _RANDOM[10'h2BD][13:8];	// rob.scala:310:28
        rob_uop_1_21_ldst_val = _RANDOM[10'h2BE][0];	// rob.scala:310:28
        rob_uop_1_21_dst_rtype = _RANDOM[10'h2BE][2:1];	// rob.scala:310:28
        rob_uop_1_21_fp_val = _RANDOM[10'h2BE][8];	// rob.scala:310:28
        rob_uop_1_22_uopc = _RANDOM[10'h2BE][25:19];	// rob.scala:310:28
        rob_uop_1_22_is_rvc = _RANDOM[10'h2C0][26];	// rob.scala:310:28
        rob_uop_1_22_br_mask = _RANDOM[10'h2C3][26:15];	// rob.scala:310:28
        rob_uop_1_22_ftq_idx = {_RANDOM[10'h2C3][31], _RANDOM[10'h2C4][3:0]};	// rob.scala:310:28
        rob_uop_1_22_edge_inst = _RANDOM[10'h2C4][4];	// rob.scala:310:28
        rob_uop_1_22_pc_lob = _RANDOM[10'h2C4][10:5];	// rob.scala:310:28
        rob_uop_1_22_pdst = {_RANDOM[10'h2C5][31:28], _RANDOM[10'h2C6][2:0]};	// rob.scala:310:28
        rob_uop_1_22_stale_pdst = _RANDOM[10'h2C7][7:1];	// rob.scala:310:28
        rob_uop_1_22_is_fencei = _RANDOM[10'h2C9][19];	// rob.scala:310:28
        rob_uop_1_22_uses_ldq = _RANDOM[10'h2C9][21];	// rob.scala:310:28
        rob_uop_1_22_uses_stq = _RANDOM[10'h2C9][22];	// rob.scala:310:28
        rob_uop_1_22_is_sys_pc2epc = _RANDOM[10'h2C9][23];	// rob.scala:310:28
        rob_uop_1_22_flush_on_commit = _RANDOM[10'h2C9][25];	// rob.scala:310:28
        rob_uop_1_22_ldst = {_RANDOM[10'h2C9][31:27], _RANDOM[10'h2CA][0]};	// rob.scala:310:28
        rob_uop_1_22_ldst_val = _RANDOM[10'h2CA][19];	// rob.scala:310:28
        rob_uop_1_22_dst_rtype = _RANDOM[10'h2CA][21:20];	// rob.scala:310:28
        rob_uop_1_22_fp_val = _RANDOM[10'h2CA][27];	// rob.scala:310:28
        rob_uop_1_23_uopc = _RANDOM[10'h2CB][12:6];	// rob.scala:310:28
        rob_uop_1_23_is_rvc = _RANDOM[10'h2CD][13];	// rob.scala:310:28
        rob_uop_1_23_br_mask = _RANDOM[10'h2D0][13:2];	// rob.scala:310:28
        rob_uop_1_23_ftq_idx = _RANDOM[10'h2D0][22:18];	// rob.scala:310:28
        rob_uop_1_23_edge_inst = _RANDOM[10'h2D0][23];	// rob.scala:310:28
        rob_uop_1_23_pc_lob = _RANDOM[10'h2D0][29:24];	// rob.scala:310:28
        rob_uop_1_23_pdst = _RANDOM[10'h2D2][21:15];	// rob.scala:310:28
        rob_uop_1_23_stale_pdst = _RANDOM[10'h2D3][26:20];	// rob.scala:310:28
        rob_uop_1_23_is_fencei = _RANDOM[10'h2D6][6];	// rob.scala:310:28
        rob_uop_1_23_uses_ldq = _RANDOM[10'h2D6][8];	// rob.scala:310:28
        rob_uop_1_23_uses_stq = _RANDOM[10'h2D6][9];	// rob.scala:310:28
        rob_uop_1_23_is_sys_pc2epc = _RANDOM[10'h2D6][10];	// rob.scala:310:28
        rob_uop_1_23_flush_on_commit = _RANDOM[10'h2D6][12];	// rob.scala:310:28
        rob_uop_1_23_ldst = _RANDOM[10'h2D6][19:14];	// rob.scala:310:28
        rob_uop_1_23_ldst_val = _RANDOM[10'h2D7][6];	// rob.scala:310:28
        rob_uop_1_23_dst_rtype = _RANDOM[10'h2D7][8:7];	// rob.scala:310:28
        rob_uop_1_23_fp_val = _RANDOM[10'h2D7][14];	// rob.scala:310:28
        rob_uop_1_24_uopc = _RANDOM[10'h2D7][31:25];	// rob.scala:310:28
        rob_uop_1_24_is_rvc = _RANDOM[10'h2DA][0];	// rob.scala:310:28
        rob_uop_1_24_br_mask = {_RANDOM[10'h2DC][31:21], _RANDOM[10'h2DD][0]};	// rob.scala:310:28
        rob_uop_1_24_ftq_idx = _RANDOM[10'h2DD][9:5];	// rob.scala:310:28
        rob_uop_1_24_edge_inst = _RANDOM[10'h2DD][10];	// rob.scala:310:28
        rob_uop_1_24_pc_lob = _RANDOM[10'h2DD][16:11];	// rob.scala:310:28
        rob_uop_1_24_pdst = _RANDOM[10'h2DF][8:2];	// rob.scala:310:28
        rob_uop_1_24_stale_pdst = _RANDOM[10'h2E0][13:7];	// rob.scala:310:28
        rob_uop_1_24_is_fencei = _RANDOM[10'h2E2][25];	// rob.scala:310:28
        rob_uop_1_24_uses_ldq = _RANDOM[10'h2E2][27];	// rob.scala:310:28
        rob_uop_1_24_uses_stq = _RANDOM[10'h2E2][28];	// rob.scala:310:28
        rob_uop_1_24_is_sys_pc2epc = _RANDOM[10'h2E2][29];	// rob.scala:310:28
        rob_uop_1_24_flush_on_commit = _RANDOM[10'h2E2][31];	// rob.scala:310:28
        rob_uop_1_24_ldst = _RANDOM[10'h2E3][6:1];	// rob.scala:310:28
        rob_uop_1_24_ldst_val = _RANDOM[10'h2E3][25];	// rob.scala:310:28
        rob_uop_1_24_dst_rtype = _RANDOM[10'h2E3][27:26];	// rob.scala:310:28
        rob_uop_1_24_fp_val = _RANDOM[10'h2E4][1];	// rob.scala:310:28
        rob_uop_1_25_uopc = _RANDOM[10'h2E4][18:12];	// rob.scala:310:28
        rob_uop_1_25_is_rvc = _RANDOM[10'h2E6][19];	// rob.scala:310:28
        rob_uop_1_25_br_mask = _RANDOM[10'h2E9][19:8];	// rob.scala:310:28
        rob_uop_1_25_ftq_idx = _RANDOM[10'h2E9][28:24];	// rob.scala:310:28
        rob_uop_1_25_edge_inst = _RANDOM[10'h2E9][29];	// rob.scala:310:28
        rob_uop_1_25_pc_lob = {_RANDOM[10'h2E9][31:30], _RANDOM[10'h2EA][3:0]};	// rob.scala:310:28
        rob_uop_1_25_pdst = _RANDOM[10'h2EB][27:21];	// rob.scala:310:28
        rob_uop_1_25_stale_pdst = {_RANDOM[10'h2EC][31:26], _RANDOM[10'h2ED][0]};	// rob.scala:310:28
        rob_uop_1_25_is_fencei = _RANDOM[10'h2EF][12];	// rob.scala:310:28
        rob_uop_1_25_uses_ldq = _RANDOM[10'h2EF][14];	// rob.scala:310:28
        rob_uop_1_25_uses_stq = _RANDOM[10'h2EF][15];	// rob.scala:310:28
        rob_uop_1_25_is_sys_pc2epc = _RANDOM[10'h2EF][16];	// rob.scala:310:28
        rob_uop_1_25_flush_on_commit = _RANDOM[10'h2EF][18];	// rob.scala:310:28
        rob_uop_1_25_ldst = _RANDOM[10'h2EF][25:20];	// rob.scala:310:28
        rob_uop_1_25_ldst_val = _RANDOM[10'h2F0][12];	// rob.scala:310:28
        rob_uop_1_25_dst_rtype = _RANDOM[10'h2F0][14:13];	// rob.scala:310:28
        rob_uop_1_25_fp_val = _RANDOM[10'h2F0][20];	// rob.scala:310:28
        rob_uop_1_26_uopc = {_RANDOM[10'h2F0][31], _RANDOM[10'h2F1][5:0]};	// rob.scala:310:28
        rob_uop_1_26_is_rvc = _RANDOM[10'h2F3][6];	// rob.scala:310:28
        rob_uop_1_26_br_mask = {_RANDOM[10'h2F5][31:27], _RANDOM[10'h2F6][6:0]};	// rob.scala:310:28
        rob_uop_1_26_ftq_idx = _RANDOM[10'h2F6][15:11];	// rob.scala:310:28
        rob_uop_1_26_edge_inst = _RANDOM[10'h2F6][16];	// rob.scala:310:28
        rob_uop_1_26_pc_lob = _RANDOM[10'h2F6][22:17];	// rob.scala:310:28
        rob_uop_1_26_pdst = _RANDOM[10'h2F8][14:8];	// rob.scala:310:28
        rob_uop_1_26_stale_pdst = _RANDOM[10'h2F9][19:13];	// rob.scala:310:28
        rob_uop_1_26_is_fencei = _RANDOM[10'h2FB][31];	// rob.scala:310:28
        rob_uop_1_26_uses_ldq = _RANDOM[10'h2FC][1];	// rob.scala:310:28
        rob_uop_1_26_uses_stq = _RANDOM[10'h2FC][2];	// rob.scala:310:28
        rob_uop_1_26_is_sys_pc2epc = _RANDOM[10'h2FC][3];	// rob.scala:310:28
        rob_uop_1_26_flush_on_commit = _RANDOM[10'h2FC][5];	// rob.scala:310:28
        rob_uop_1_26_ldst = _RANDOM[10'h2FC][12:7];	// rob.scala:310:28
        rob_uop_1_26_ldst_val = _RANDOM[10'h2FC][31];	// rob.scala:310:28
        rob_uop_1_26_dst_rtype = _RANDOM[10'h2FD][1:0];	// rob.scala:310:28
        rob_uop_1_26_fp_val = _RANDOM[10'h2FD][7];	// rob.scala:310:28
        rob_uop_1_27_uopc = _RANDOM[10'h2FD][24:18];	// rob.scala:310:28
        rob_uop_1_27_is_rvc = _RANDOM[10'h2FF][25];	// rob.scala:310:28
        rob_uop_1_27_br_mask = _RANDOM[10'h302][25:14];	// rob.scala:310:28
        rob_uop_1_27_ftq_idx = {_RANDOM[10'h302][31:30], _RANDOM[10'h303][2:0]};	// rob.scala:310:28
        rob_uop_1_27_edge_inst = _RANDOM[10'h303][3];	// rob.scala:310:28
        rob_uop_1_27_pc_lob = _RANDOM[10'h303][9:4];	// rob.scala:310:28
        rob_uop_1_27_pdst = {_RANDOM[10'h304][31:27], _RANDOM[10'h305][1:0]};	// rob.scala:310:28
        rob_uop_1_27_stale_pdst = _RANDOM[10'h306][6:0];	// rob.scala:310:28
        rob_uop_1_27_is_fencei = _RANDOM[10'h308][18];	// rob.scala:310:28
        rob_uop_1_27_uses_ldq = _RANDOM[10'h308][20];	// rob.scala:310:28
        rob_uop_1_27_uses_stq = _RANDOM[10'h308][21];	// rob.scala:310:28
        rob_uop_1_27_is_sys_pc2epc = _RANDOM[10'h308][22];	// rob.scala:310:28
        rob_uop_1_27_flush_on_commit = _RANDOM[10'h308][24];	// rob.scala:310:28
        rob_uop_1_27_ldst = _RANDOM[10'h308][31:26];	// rob.scala:310:28
        rob_uop_1_27_ldst_val = _RANDOM[10'h309][18];	// rob.scala:310:28
        rob_uop_1_27_dst_rtype = _RANDOM[10'h309][20:19];	// rob.scala:310:28
        rob_uop_1_27_fp_val = _RANDOM[10'h309][26];	// rob.scala:310:28
        rob_uop_1_28_uopc = _RANDOM[10'h30A][11:5];	// rob.scala:310:28
        rob_uop_1_28_is_rvc = _RANDOM[10'h30C][12];	// rob.scala:310:28
        rob_uop_1_28_br_mask = _RANDOM[10'h30F][12:1];	// rob.scala:310:28
        rob_uop_1_28_ftq_idx = _RANDOM[10'h30F][21:17];	// rob.scala:310:28
        rob_uop_1_28_edge_inst = _RANDOM[10'h30F][22];	// rob.scala:310:28
        rob_uop_1_28_pc_lob = _RANDOM[10'h30F][28:23];	// rob.scala:310:28
        rob_uop_1_28_pdst = _RANDOM[10'h311][20:14];	// rob.scala:310:28
        rob_uop_1_28_stale_pdst = _RANDOM[10'h312][25:19];	// rob.scala:310:28
        rob_uop_1_28_is_fencei = _RANDOM[10'h315][5];	// rob.scala:310:28
        rob_uop_1_28_uses_ldq = _RANDOM[10'h315][7];	// rob.scala:310:28
        rob_uop_1_28_uses_stq = _RANDOM[10'h315][8];	// rob.scala:310:28
        rob_uop_1_28_is_sys_pc2epc = _RANDOM[10'h315][9];	// rob.scala:310:28
        rob_uop_1_28_flush_on_commit = _RANDOM[10'h315][11];	// rob.scala:310:28
        rob_uop_1_28_ldst = _RANDOM[10'h315][18:13];	// rob.scala:310:28
        rob_uop_1_28_ldst_val = _RANDOM[10'h316][5];	// rob.scala:310:28
        rob_uop_1_28_dst_rtype = _RANDOM[10'h316][7:6];	// rob.scala:310:28
        rob_uop_1_28_fp_val = _RANDOM[10'h316][13];	// rob.scala:310:28
        rob_uop_1_29_uopc = _RANDOM[10'h316][30:24];	// rob.scala:310:28
        rob_uop_1_29_is_rvc = _RANDOM[10'h318][31];	// rob.scala:310:28
        rob_uop_1_29_br_mask = _RANDOM[10'h31B][31:20];	// rob.scala:310:28
        rob_uop_1_29_ftq_idx = _RANDOM[10'h31C][8:4];	// rob.scala:310:28
        rob_uop_1_29_edge_inst = _RANDOM[10'h31C][9];	// rob.scala:310:28
        rob_uop_1_29_pc_lob = _RANDOM[10'h31C][15:10];	// rob.scala:310:28
        rob_uop_1_29_pdst = _RANDOM[10'h31E][7:1];	// rob.scala:310:28
        rob_uop_1_29_stale_pdst = _RANDOM[10'h31F][12:6];	// rob.scala:310:28
        rob_uop_1_29_is_fencei = _RANDOM[10'h321][24];	// rob.scala:310:28
        rob_uop_1_29_uses_ldq = _RANDOM[10'h321][26];	// rob.scala:310:28
        rob_uop_1_29_uses_stq = _RANDOM[10'h321][27];	// rob.scala:310:28
        rob_uop_1_29_is_sys_pc2epc = _RANDOM[10'h321][28];	// rob.scala:310:28
        rob_uop_1_29_flush_on_commit = _RANDOM[10'h321][30];	// rob.scala:310:28
        rob_uop_1_29_ldst = _RANDOM[10'h322][5:0];	// rob.scala:310:28
        rob_uop_1_29_ldst_val = _RANDOM[10'h322][24];	// rob.scala:310:28
        rob_uop_1_29_dst_rtype = _RANDOM[10'h322][26:25];	// rob.scala:310:28
        rob_uop_1_29_fp_val = _RANDOM[10'h323][0];	// rob.scala:310:28
        rob_uop_1_30_uopc = _RANDOM[10'h323][17:11];	// rob.scala:310:28
        rob_uop_1_30_is_rvc = _RANDOM[10'h325][18];	// rob.scala:310:28
        rob_uop_1_30_br_mask = _RANDOM[10'h328][18:7];	// rob.scala:310:28
        rob_uop_1_30_ftq_idx = _RANDOM[10'h328][27:23];	// rob.scala:310:28
        rob_uop_1_30_edge_inst = _RANDOM[10'h328][28];	// rob.scala:310:28
        rob_uop_1_30_pc_lob = {_RANDOM[10'h328][31:29], _RANDOM[10'h329][2:0]};	// rob.scala:310:28
        rob_uop_1_30_pdst = _RANDOM[10'h32A][26:20];	// rob.scala:310:28
        rob_uop_1_30_stale_pdst = _RANDOM[10'h32B][31:25];	// rob.scala:310:28
        rob_uop_1_30_is_fencei = _RANDOM[10'h32E][11];	// rob.scala:310:28
        rob_uop_1_30_uses_ldq = _RANDOM[10'h32E][13];	// rob.scala:310:28
        rob_uop_1_30_uses_stq = _RANDOM[10'h32E][14];	// rob.scala:310:28
        rob_uop_1_30_is_sys_pc2epc = _RANDOM[10'h32E][15];	// rob.scala:310:28
        rob_uop_1_30_flush_on_commit = _RANDOM[10'h32E][17];	// rob.scala:310:28
        rob_uop_1_30_ldst = _RANDOM[10'h32E][24:19];	// rob.scala:310:28
        rob_uop_1_30_ldst_val = _RANDOM[10'h32F][11];	// rob.scala:310:28
        rob_uop_1_30_dst_rtype = _RANDOM[10'h32F][13:12];	// rob.scala:310:28
        rob_uop_1_30_fp_val = _RANDOM[10'h32F][19];	// rob.scala:310:28
        rob_uop_1_31_uopc = {_RANDOM[10'h32F][31:30], _RANDOM[10'h330][4:0]};	// rob.scala:310:28
        rob_uop_1_31_is_rvc = _RANDOM[10'h332][5];	// rob.scala:310:28
        rob_uop_1_31_br_mask = {_RANDOM[10'h334][31:26], _RANDOM[10'h335][5:0]};	// rob.scala:310:28
        rob_uop_1_31_ftq_idx = _RANDOM[10'h335][14:10];	// rob.scala:310:28
        rob_uop_1_31_edge_inst = _RANDOM[10'h335][15];	// rob.scala:310:28
        rob_uop_1_31_pc_lob = _RANDOM[10'h335][21:16];	// rob.scala:310:28
        rob_uop_1_31_pdst = _RANDOM[10'h337][13:7];	// rob.scala:310:28
        rob_uop_1_31_stale_pdst = _RANDOM[10'h338][18:12];	// rob.scala:310:28
        rob_uop_1_31_is_fencei = _RANDOM[10'h33A][30];	// rob.scala:310:28
        rob_uop_1_31_uses_ldq = _RANDOM[10'h33B][0];	// rob.scala:310:28
        rob_uop_1_31_uses_stq = _RANDOM[10'h33B][1];	// rob.scala:310:28
        rob_uop_1_31_is_sys_pc2epc = _RANDOM[10'h33B][2];	// rob.scala:310:28
        rob_uop_1_31_flush_on_commit = _RANDOM[10'h33B][4];	// rob.scala:310:28
        rob_uop_1_31_ldst = _RANDOM[10'h33B][11:6];	// rob.scala:310:28
        rob_uop_1_31_ldst_val = _RANDOM[10'h33B][30];	// rob.scala:310:28
        rob_uop_1_31_dst_rtype = {_RANDOM[10'h33B][31], _RANDOM[10'h33C][0]};	// rob.scala:310:28
        rob_uop_1_31_fp_val = _RANDOM[10'h33C][6];	// rob.scala:310:28
        rob_exception_1_0 = _RANDOM[10'h33C][17];	// rob.scala:310:28, :311:28
        rob_exception_1_1 = _RANDOM[10'h33C][18];	// rob.scala:310:28, :311:28
        rob_exception_1_2 = _RANDOM[10'h33C][19];	// rob.scala:310:28, :311:28
        rob_exception_1_3 = _RANDOM[10'h33C][20];	// rob.scala:310:28, :311:28
        rob_exception_1_4 = _RANDOM[10'h33C][21];	// rob.scala:310:28, :311:28
        rob_exception_1_5 = _RANDOM[10'h33C][22];	// rob.scala:310:28, :311:28
        rob_exception_1_6 = _RANDOM[10'h33C][23];	// rob.scala:310:28, :311:28
        rob_exception_1_7 = _RANDOM[10'h33C][24];	// rob.scala:310:28, :311:28
        rob_exception_1_8 = _RANDOM[10'h33C][25];	// rob.scala:310:28, :311:28
        rob_exception_1_9 = _RANDOM[10'h33C][26];	// rob.scala:310:28, :311:28
        rob_exception_1_10 = _RANDOM[10'h33C][27];	// rob.scala:310:28, :311:28
        rob_exception_1_11 = _RANDOM[10'h33C][28];	// rob.scala:310:28, :311:28
        rob_exception_1_12 = _RANDOM[10'h33C][29];	// rob.scala:310:28, :311:28
        rob_exception_1_13 = _RANDOM[10'h33C][30];	// rob.scala:310:28, :311:28
        rob_exception_1_14 = _RANDOM[10'h33C][31];	// rob.scala:310:28, :311:28
        rob_exception_1_15 = _RANDOM[10'h33D][0];	// rob.scala:311:28
        rob_exception_1_16 = _RANDOM[10'h33D][1];	// rob.scala:311:28
        rob_exception_1_17 = _RANDOM[10'h33D][2];	// rob.scala:311:28
        rob_exception_1_18 = _RANDOM[10'h33D][3];	// rob.scala:311:28
        rob_exception_1_19 = _RANDOM[10'h33D][4];	// rob.scala:311:28
        rob_exception_1_20 = _RANDOM[10'h33D][5];	// rob.scala:311:28
        rob_exception_1_21 = _RANDOM[10'h33D][6];	// rob.scala:311:28
        rob_exception_1_22 = _RANDOM[10'h33D][7];	// rob.scala:311:28
        rob_exception_1_23 = _RANDOM[10'h33D][8];	// rob.scala:311:28
        rob_exception_1_24 = _RANDOM[10'h33D][9];	// rob.scala:311:28
        rob_exception_1_25 = _RANDOM[10'h33D][10];	// rob.scala:311:28
        rob_exception_1_26 = _RANDOM[10'h33D][11];	// rob.scala:311:28
        rob_exception_1_27 = _RANDOM[10'h33D][12];	// rob.scala:311:28
        rob_exception_1_28 = _RANDOM[10'h33D][13];	// rob.scala:311:28
        rob_exception_1_29 = _RANDOM[10'h33D][14];	// rob.scala:311:28
        rob_exception_1_30 = _RANDOM[10'h33D][15];	// rob.scala:311:28
        rob_exception_1_31 = _RANDOM[10'h33D][16];	// rob.scala:311:28
        rob_predicated_1_0 = _RANDOM[10'h33D][17];	// rob.scala:311:28, :312:29
        rob_predicated_1_1 = _RANDOM[10'h33D][18];	// rob.scala:311:28, :312:29
        rob_predicated_1_2 = _RANDOM[10'h33D][19];	// rob.scala:311:28, :312:29
        rob_predicated_1_3 = _RANDOM[10'h33D][20];	// rob.scala:311:28, :312:29
        rob_predicated_1_4 = _RANDOM[10'h33D][21];	// rob.scala:311:28, :312:29
        rob_predicated_1_5 = _RANDOM[10'h33D][22];	// rob.scala:311:28, :312:29
        rob_predicated_1_6 = _RANDOM[10'h33D][23];	// rob.scala:311:28, :312:29
        rob_predicated_1_7 = _RANDOM[10'h33D][24];	// rob.scala:311:28, :312:29
        rob_predicated_1_8 = _RANDOM[10'h33D][25];	// rob.scala:311:28, :312:29
        rob_predicated_1_9 = _RANDOM[10'h33D][26];	// rob.scala:311:28, :312:29
        rob_predicated_1_10 = _RANDOM[10'h33D][27];	// rob.scala:311:28, :312:29
        rob_predicated_1_11 = _RANDOM[10'h33D][28];	// rob.scala:311:28, :312:29
        rob_predicated_1_12 = _RANDOM[10'h33D][29];	// rob.scala:311:28, :312:29
        rob_predicated_1_13 = _RANDOM[10'h33D][30];	// rob.scala:311:28, :312:29
        rob_predicated_1_14 = _RANDOM[10'h33D][31];	// rob.scala:311:28, :312:29
        rob_predicated_1_15 = _RANDOM[10'h33E][0];	// rob.scala:312:29
        rob_predicated_1_16 = _RANDOM[10'h33E][1];	// rob.scala:312:29
        rob_predicated_1_17 = _RANDOM[10'h33E][2];	// rob.scala:312:29
        rob_predicated_1_18 = _RANDOM[10'h33E][3];	// rob.scala:312:29
        rob_predicated_1_19 = _RANDOM[10'h33E][4];	// rob.scala:312:29
        rob_predicated_1_20 = _RANDOM[10'h33E][5];	// rob.scala:312:29
        rob_predicated_1_21 = _RANDOM[10'h33E][6];	// rob.scala:312:29
        rob_predicated_1_22 = _RANDOM[10'h33E][7];	// rob.scala:312:29
        rob_predicated_1_23 = _RANDOM[10'h33E][8];	// rob.scala:312:29
        rob_predicated_1_24 = _RANDOM[10'h33E][9];	// rob.scala:312:29
        rob_predicated_1_25 = _RANDOM[10'h33E][10];	// rob.scala:312:29
        rob_predicated_1_26 = _RANDOM[10'h33E][11];	// rob.scala:312:29
        rob_predicated_1_27 = _RANDOM[10'h33E][12];	// rob.scala:312:29
        rob_predicated_1_28 = _RANDOM[10'h33E][13];	// rob.scala:312:29
        rob_predicated_1_29 = _RANDOM[10'h33E][14];	// rob.scala:312:29
        rob_predicated_1_30 = _RANDOM[10'h33E][15];	// rob.scala:312:29
        rob_predicated_1_31 = _RANDOM[10'h33E][16];	// rob.scala:312:29
        block_commit_REG = _RANDOM[10'h33E][17];	// rob.scala:312:29, :540:94
        block_commit_REG_1 = _RANDOM[10'h33E][18];	// rob.scala:312:29, :540:131
        block_commit_REG_2 = _RANDOM[10'h33E][19];	// rob.scala:312:29, :540:123
        r_partial_row = _RANDOM[10'h33E][20];	// rob.scala:312:29, :677:30
        pnr_maybe_at_tail = _RANDOM[10'h33E][21];	// rob.scala:312:29, :714:36
        REG = _RANDOM[10'h33E][22];	// rob.scala:312:29, :808:30
        REG_1 = _RANDOM[10'h33E][23];	// rob.scala:312:29, :808:22
        REG_2 = _RANDOM[10'h33E][24];	// rob.scala:312:29, :824:22
        io_com_load_is_at_rob_head_REG = _RANDOM[10'h33E][25];	// rob.scala:312:29, :865:40
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  rob_fflags_32x5_0 rob_fflags_ext (	// rob.scala:313:28
    .R0_addr (rob_head),	// rob.scala:224:29
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (io_fflags_1_bits_uop_rob_idx[5:1]),	// rob.scala:268:25
    .W0_en   (io_fflags_1_valid & ~(io_fflags_1_bits_uop_rob_idx[0])),	// rob.scala:272:36, :304:53, :381:32
    .W0_clk  (clock),
    .W0_data (io_fflags_1_bits_flags),
    .W1_addr (io_fflags_0_bits_uop_rob_idx[5:1]),	// rob.scala:268:25
    .W1_en   (io_fflags_0_valid & ~(io_fflags_0_bits_uop_rob_idx[0])),	// rob.scala:272:36, :304:53, :381:32
    .W1_clk  (clock),
    .W1_data (io_fflags_0_bits_flags),
    .W2_addr (rob_tail),	// rob.scala:228:29
    .W2_en   (io_enq_valids_0),
    .W2_clk  (clock),
    .W2_data (5'h0),	// rob.scala:224:29
    .R0_data (_rob_fflags_ext_R0_data)
  );
  rob_fflags_32x5_0 rob_fflags_1_ext (	// rob.scala:313:28
    .R0_addr (rob_head),	// rob.scala:224:29
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .W0_addr (rob_tail),	// rob.scala:228:29
    .W0_en   (io_enq_valids_1),
    .W0_clk  (clock),
    .W0_data (5'h0),	// rob.scala:224:29
    .W1_addr (io_fflags_1_bits_uop_rob_idx[5:1]),	// rob.scala:268:25
    .W1_en   (io_fflags_1_valid & io_fflags_1_bits_uop_rob_idx[0]),	// rob.scala:272:36, :381:32
    .W1_clk  (clock),
    .W1_data (io_fflags_1_bits_flags),
    .W2_addr (io_fflags_0_bits_uop_rob_idx[5:1]),	// rob.scala:268:25
    .W2_en   (io_fflags_0_valid & io_fflags_0_bits_uop_rob_idx[0]),	// rob.scala:272:36, :381:32
    .W2_clk  (clock),
    .W2_data (io_fflags_0_bits_flags),
    .R0_data (_rob_fflags_1_ext_R0_data)
  );
  assign io_rob_tail_idx = rob_tail_idx;	// Cat.scala:30:58
  assign io_rob_head_idx = rob_head_idx;	// Cat.scala:30:58
  assign io_commit_valids_0 = will_commit_0;	// rob.scala:547:70
  assign io_commit_valids_1 = will_commit_1;	// rob.scala:547:70
  assign io_commit_arch_valids_0 = will_commit_0 & ~_GEN_11[com_idx];	// rob.scala:236:20, :410:{48,51}, :547:70
  assign io_commit_arch_valids_1 = will_commit_1 & ~_GEN_40[com_idx];	// rob.scala:236:20, :410:{48,51}, :547:70
  assign io_commit_uops_0_ftq_idx = _GEN_14[com_idx];	// rob.scala:236:20, :411:25
  assign io_commit_uops_0_pdst = _GEN_17[com_idx];	// rob.scala:236:20, :411:25
  assign io_commit_uops_0_stale_pdst = _GEN_18[com_idx];	// rob.scala:236:20, :411:25
  assign io_commit_uops_0_is_fencei = _GEN_19[com_idx];	// rob.scala:236:20, :411:25
  assign io_commit_uops_0_uses_ldq = _GEN_20[com_idx];	// rob.scala:236:20, :411:25
  assign io_commit_uops_0_uses_stq = _GEN_21[com_idx];	// rob.scala:236:20, :411:25
  assign io_commit_uops_0_ldst = _GEN_24[com_idx];	// rob.scala:236:20, :411:25
  assign io_commit_uops_0_ldst_val = _GEN_25[com_idx];	// rob.scala:236:20, :411:25
  assign io_commit_uops_0_dst_rtype = _GEN_26[com_idx];	// rob.scala:236:20, :411:25
  assign io_commit_uops_1_ftq_idx = _GEN_43[com_idx];	// rob.scala:236:20, :411:25
  assign io_commit_uops_1_pdst = _GEN_46[com_idx];	// rob.scala:236:20, :411:25
  assign io_commit_uops_1_stale_pdst = _GEN_47[com_idx];	// rob.scala:236:20, :411:25
  assign io_commit_uops_1_is_fencei = _GEN_48[com_idx];	// rob.scala:236:20, :411:25
  assign io_commit_uops_1_uses_ldq = _GEN_49[com_idx];	// rob.scala:236:20, :411:25
  assign io_commit_uops_1_uses_stq = _GEN_50[com_idx];	// rob.scala:236:20, :411:25
  assign io_commit_uops_1_ldst = _GEN_53[com_idx];	// rob.scala:236:20, :411:25
  assign io_commit_uops_1_ldst_val = _GEN_54[com_idx];	// rob.scala:236:20, :411:25
  assign io_commit_uops_1_dst_rtype = _GEN_55[com_idx];	// rob.scala:236:20, :411:25
  assign io_commit_fflags_valid = fflags_val_0 | fflags_val_1;	// rob.scala:602:32, :617:48
  assign io_commit_fflags_bits =
    (fflags_val_0 ? _rob_fflags_ext_R0_data : 5'h0)
    | (fflags_val_1 ? _rob_fflags_1_ext_R0_data : 5'h0);	// rob.scala:224:29, :313:28, :602:32, :605:21, :618:44
  assign io_commit_rbk_valids_0 = _io_commit_rbk_valids_0_output;	// rob.scala:427:40
  assign io_commit_rbk_valids_1 = _io_commit_rbk_valids_1_output;	// rob.scala:427:40
  assign io_commit_rollback = _io_commit_rollback_T_1;	// rob.scala:236:31
  assign io_com_load_is_at_rob_head = io_com_load_is_at_rob_head_REG;	// rob.scala:865:40
  assign io_com_xcpt_valid = exception_thrown & _io_flush_bits_flush_typ_T;	// rob.scala:545:85, :556:50, :557:41
  assign io_com_xcpt_bits_ftq_idx = com_xcpt_uop_ftq_idx;	// Mux.scala:47:69
  assign io_com_xcpt_bits_edge_inst = com_xcpt_uop_edge_inst;	// Mux.scala:47:69
  assign io_com_xcpt_bits_pc_lob = com_xcpt_uop_pc_lob;	// Mux.scala:47:69
  assign io_com_xcpt_bits_cause = r_xcpt_uop_exc_cause;	// rob.scala:259:29
  assign io_com_xcpt_bits_badvaddr = {{24{r_xcpt_badvaddr[39]}}, r_xcpt_badvaddr};	// Bitwise.scala:72:12, Cat.scala:30:58, rob.scala:260:29, util.scala:261:46
  assign io_flush_valid = _io_flush_valid_output;	// rob.scala:573:36
  assign io_flush_bits_ftq_idx =
    exception_thrown
      ? com_xcpt_uop_ftq_idx
      : (flush_commit_mask_0 ? _GEN_14[com_idx] : 5'h0)
        | (flush_commit_mask_1 ? _GEN_43[com_idx] : 5'h0);	// Mux.scala:27:72, :47:69, rob.scala:224:29, :236:20, :411:25, :545:85, :571:75, :578:22
  assign io_flush_bits_edge_inst =
    exception_thrown
      ? com_xcpt_uop_edge_inst
      : flush_commit_mask_0 & _GEN_15[com_idx] | flush_commit_mask_1 & _GEN_44[com_idx];	// Mux.scala:27:72, :47:69, rob.scala:236:20, :411:25, :545:85, :571:75, :578:22
  assign io_flush_bits_is_rvc =
    exception_thrown
      ? (rob_head_vals_0 ? _GEN_13[com_idx] : _GEN_42[com_idx])
      : flush_commit_mask_0 & _GEN_13[com_idx] | flush_commit_mask_1 & _GEN_42[com_idx];	// Mux.scala:27:72, :47:69, rob.scala:236:20, :398:49, :411:25, :545:85, :571:75, :578:22
  assign io_flush_bits_pc_lob =
    exception_thrown
      ? com_xcpt_uop_pc_lob
      : (flush_commit_mask_0 ? _GEN_16[com_idx] : 6'h0)
        | (flush_commit_mask_1 ? _GEN_45[com_idx] : 6'h0);	// Mux.scala:27:72, :47:69, rob.scala:236:20, :287:15, :411:25, :545:85, :571:75, :578:22
  assign io_flush_bits_flush_typ =
    _io_flush_valid_output
      ? (flush_commit
         & (exception_thrown
              ? (rob_head_vals_0 ? _GEN_12[com_idx] : _GEN_41[com_idx])
              : (flush_commit_mask_0 ? _GEN_12[com_idx] : 7'h0)
                | (flush_commit_mask_1 ? _GEN_41[com_idx] : 7'h0)) == 7'h6A
           ? 3'h3
           : exception_thrown & _io_flush_bits_flush_typ_T
               ? 3'h1
               : exception_thrown | (rob_head_vals_0 | rob_head_vals_1)
                 & (rob_head_vals_0 ? _GEN_22[com_idx] : _GEN_51[com_idx])
                   ? 3'h2
                   : 3'h4)
      : 3'h0;	// Mux.scala:27:72, :47:69, rob.scala:172:10, :173:10, :174:10, :175:10, :236:20, :287:15, :398:49, :411:25, :457:33, :545:85, :556:50, :562:{27,31}, :564:39, :571:75, :572:48, :573:36, :578:22, :587:66, :588:{62,80}
  assign io_empty = empty;	// rob.scala:788:41
  assign io_ready = _io_ready_T & ~full & ~r_xcpt_val;	// rob.scala:258:33, :425:47, :658:33, :716:33, :787:39, :794:56
  assign io_flush_frontend = r_xcpt_val;	// rob.scala:258:33
endmodule

