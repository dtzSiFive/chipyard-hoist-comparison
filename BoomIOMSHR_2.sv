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

module BoomIOMSHR_2(
  input         clock,
                reset,
                io_req_valid,
  input  [6:0]  io_req_bits_uop_uopc,
  input  [31:0] io_req_bits_uop_inst,
                io_req_bits_uop_debug_inst,
  input         io_req_bits_uop_is_rvc,
  input  [39:0] io_req_bits_uop_debug_pc,
  input  [2:0]  io_req_bits_uop_iq_type,
  input  [9:0]  io_req_bits_uop_fu_code,
  input  [3:0]  io_req_bits_uop_ctrl_br_type,
  input  [1:0]  io_req_bits_uop_ctrl_op1_sel,
  input  [2:0]  io_req_bits_uop_ctrl_op2_sel,
                io_req_bits_uop_ctrl_imm_sel,
  input  [3:0]  io_req_bits_uop_ctrl_op_fcn,
  input         io_req_bits_uop_ctrl_fcn_dw,
  input  [2:0]  io_req_bits_uop_ctrl_csr_cmd,
  input         io_req_bits_uop_ctrl_is_load,
                io_req_bits_uop_ctrl_is_sta,
                io_req_bits_uop_ctrl_is_std,
  input  [1:0]  io_req_bits_uop_iw_state,
  input         io_req_bits_uop_iw_p1_poisoned,
                io_req_bits_uop_iw_p2_poisoned,
                io_req_bits_uop_is_br,
                io_req_bits_uop_is_jalr,
                io_req_bits_uop_is_jal,
                io_req_bits_uop_is_sfb,
  input  [11:0] io_req_bits_uop_br_mask,
  input  [3:0]  io_req_bits_uop_br_tag,
  input  [4:0]  io_req_bits_uop_ftq_idx,
  input         io_req_bits_uop_edge_inst,
  input  [5:0]  io_req_bits_uop_pc_lob,
  input         io_req_bits_uop_taken,
  input  [19:0] io_req_bits_uop_imm_packed,
  input  [11:0] io_req_bits_uop_csr_addr,
  input  [5:0]  io_req_bits_uop_rob_idx,
  input  [3:0]  io_req_bits_uop_ldq_idx,
                io_req_bits_uop_stq_idx,
  input  [1:0]  io_req_bits_uop_rxq_idx,
  input  [6:0]  io_req_bits_uop_pdst,
                io_req_bits_uop_prs1,
                io_req_bits_uop_prs2,
                io_req_bits_uop_prs3,
  input  [4:0]  io_req_bits_uop_ppred,
  input         io_req_bits_uop_prs1_busy,
                io_req_bits_uop_prs2_busy,
                io_req_bits_uop_prs3_busy,
                io_req_bits_uop_ppred_busy,
  input  [6:0]  io_req_bits_uop_stale_pdst,
  input         io_req_bits_uop_exception,
  input  [63:0] io_req_bits_uop_exc_cause,
  input         io_req_bits_uop_bypassable,
  input  [4:0]  io_req_bits_uop_mem_cmd,
  input  [1:0]  io_req_bits_uop_mem_size,
  input         io_req_bits_uop_mem_signed,
                io_req_bits_uop_is_fence,
                io_req_bits_uop_is_fencei,
                io_req_bits_uop_is_amo,
                io_req_bits_uop_uses_ldq,
                io_req_bits_uop_uses_stq,
                io_req_bits_uop_is_sys_pc2epc,
                io_req_bits_uop_is_unique,
                io_req_bits_uop_flush_on_commit,
                io_req_bits_uop_ldst_is_rs1,
  input  [5:0]  io_req_bits_uop_ldst,
                io_req_bits_uop_lrs1,
                io_req_bits_uop_lrs2,
                io_req_bits_uop_lrs3,
  input         io_req_bits_uop_ldst_val,
  input  [1:0]  io_req_bits_uop_dst_rtype,
                io_req_bits_uop_lrs1_rtype,
                io_req_bits_uop_lrs2_rtype,
  input         io_req_bits_uop_frs3_en,
                io_req_bits_uop_fp_val,
                io_req_bits_uop_fp_single,
                io_req_bits_uop_xcpt_pf_if,
                io_req_bits_uop_xcpt_ae_if,
                io_req_bits_uop_xcpt_ma_if,
                io_req_bits_uop_bp_debug_if,
                io_req_bits_uop_bp_xcpt_if,
  input  [1:0]  io_req_bits_uop_debug_fsrc,
                io_req_bits_uop_debug_tsrc,
  input  [39:0] io_req_bits_addr,
  input  [63:0] io_req_bits_data,
  input         io_resp_ready,
                io_mem_access_ready,
                io_mem_ack_valid,
  input  [63:0] io_mem_ack_bits_data,
  output        io_req_ready,
                io_resp_valid,
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
  output        io_mem_access_valid,
  output [2:0]  io_mem_access_bits_opcode,
                io_mem_access_bits_param,
  output [3:0]  io_mem_access_bits_size,
  output [1:0]  io_mem_access_bits_source,
  output [31:0] io_mem_access_bits_address,
  output [7:0]  io_mem_access_bits_mask,
  output [63:0] io_mem_access_bits_data
);

  reg  [6:0]  req_uop_uopc;	// mshrs.scala:410:16
  reg  [31:0] req_uop_inst;	// mshrs.scala:410:16
  reg  [31:0] req_uop_debug_inst;	// mshrs.scala:410:16
  reg         req_uop_is_rvc;	// mshrs.scala:410:16
  reg  [39:0] req_uop_debug_pc;	// mshrs.scala:410:16
  reg  [2:0]  req_uop_iq_type;	// mshrs.scala:410:16
  reg  [9:0]  req_uop_fu_code;	// mshrs.scala:410:16
  reg  [3:0]  req_uop_ctrl_br_type;	// mshrs.scala:410:16
  reg  [1:0]  req_uop_ctrl_op1_sel;	// mshrs.scala:410:16
  reg  [2:0]  req_uop_ctrl_op2_sel;	// mshrs.scala:410:16
  reg  [2:0]  req_uop_ctrl_imm_sel;	// mshrs.scala:410:16
  reg  [3:0]  req_uop_ctrl_op_fcn;	// mshrs.scala:410:16
  reg         req_uop_ctrl_fcn_dw;	// mshrs.scala:410:16
  reg  [2:0]  req_uop_ctrl_csr_cmd;	// mshrs.scala:410:16
  reg         req_uop_ctrl_is_load;	// mshrs.scala:410:16
  reg         req_uop_ctrl_is_sta;	// mshrs.scala:410:16
  reg         req_uop_ctrl_is_std;	// mshrs.scala:410:16
  reg  [1:0]  req_uop_iw_state;	// mshrs.scala:410:16
  reg         req_uop_iw_p1_poisoned;	// mshrs.scala:410:16
  reg         req_uop_iw_p2_poisoned;	// mshrs.scala:410:16
  reg         req_uop_is_br;	// mshrs.scala:410:16
  reg         req_uop_is_jalr;	// mshrs.scala:410:16
  reg         req_uop_is_jal;	// mshrs.scala:410:16
  reg         req_uop_is_sfb;	// mshrs.scala:410:16
  reg  [11:0] req_uop_br_mask;	// mshrs.scala:410:16
  reg  [3:0]  req_uop_br_tag;	// mshrs.scala:410:16
  reg  [4:0]  req_uop_ftq_idx;	// mshrs.scala:410:16
  reg         req_uop_edge_inst;	// mshrs.scala:410:16
  reg  [5:0]  req_uop_pc_lob;	// mshrs.scala:410:16
  reg         req_uop_taken;	// mshrs.scala:410:16
  reg  [19:0] req_uop_imm_packed;	// mshrs.scala:410:16
  reg  [11:0] req_uop_csr_addr;	// mshrs.scala:410:16
  reg  [5:0]  req_uop_rob_idx;	// mshrs.scala:410:16
  reg  [3:0]  req_uop_ldq_idx;	// mshrs.scala:410:16
  reg  [3:0]  req_uop_stq_idx;	// mshrs.scala:410:16
  reg  [1:0]  req_uop_rxq_idx;	// mshrs.scala:410:16
  reg  [6:0]  req_uop_pdst;	// mshrs.scala:410:16
  reg  [6:0]  req_uop_prs1;	// mshrs.scala:410:16
  reg  [6:0]  req_uop_prs2;	// mshrs.scala:410:16
  reg  [6:0]  req_uop_prs3;	// mshrs.scala:410:16
  reg  [4:0]  req_uop_ppred;	// mshrs.scala:410:16
  reg         req_uop_prs1_busy;	// mshrs.scala:410:16
  reg         req_uop_prs2_busy;	// mshrs.scala:410:16
  reg         req_uop_prs3_busy;	// mshrs.scala:410:16
  reg         req_uop_ppred_busy;	// mshrs.scala:410:16
  reg  [6:0]  req_uop_stale_pdst;	// mshrs.scala:410:16
  reg         req_uop_exception;	// mshrs.scala:410:16
  reg  [63:0] req_uop_exc_cause;	// mshrs.scala:410:16
  reg         req_uop_bypassable;	// mshrs.scala:410:16
  reg  [4:0]  req_uop_mem_cmd;	// mshrs.scala:410:16
  reg  [1:0]  size;	// mshrs.scala:410:16
  reg         req_uop_mem_signed;	// mshrs.scala:410:16
  reg         req_uop_is_fence;	// mshrs.scala:410:16
  reg         req_uop_is_fencei;	// mshrs.scala:410:16
  reg         req_uop_is_amo;	// mshrs.scala:410:16
  reg         req_uop_uses_ldq;	// mshrs.scala:410:16
  reg         req_uop_uses_stq;	// mshrs.scala:410:16
  reg         req_uop_is_sys_pc2epc;	// mshrs.scala:410:16
  reg         req_uop_is_unique;	// mshrs.scala:410:16
  reg         req_uop_flush_on_commit;	// mshrs.scala:410:16
  reg         req_uop_ldst_is_rs1;	// mshrs.scala:410:16
  reg  [5:0]  req_uop_ldst;	// mshrs.scala:410:16
  reg  [5:0]  req_uop_lrs1;	// mshrs.scala:410:16
  reg  [5:0]  req_uop_lrs2;	// mshrs.scala:410:16
  reg  [5:0]  req_uop_lrs3;	// mshrs.scala:410:16
  reg         req_uop_ldst_val;	// mshrs.scala:410:16
  reg  [1:0]  req_uop_dst_rtype;	// mshrs.scala:410:16
  reg  [1:0]  req_uop_lrs1_rtype;	// mshrs.scala:410:16
  reg  [1:0]  req_uop_lrs2_rtype;	// mshrs.scala:410:16
  reg         req_uop_frs3_en;	// mshrs.scala:410:16
  reg         req_uop_fp_val;	// mshrs.scala:410:16
  reg         req_uop_fp_single;	// mshrs.scala:410:16
  reg         req_uop_xcpt_pf_if;	// mshrs.scala:410:16
  reg         req_uop_xcpt_ae_if;	// mshrs.scala:410:16
  reg         req_uop_xcpt_ma_if;	// mshrs.scala:410:16
  reg         req_uop_bp_debug_if;	// mshrs.scala:410:16
  reg         req_uop_bp_xcpt_if;	// mshrs.scala:410:16
  reg  [1:0]  req_uop_debug_fsrc;	// mshrs.scala:410:16
  reg  [1:0]  req_uop_debug_tsrc;	// mshrs.scala:410:16
  reg  [39:0] req_addr;	// mshrs.scala:410:16
  reg  [63:0] req_data;	// mshrs.scala:410:16
  reg  [63:0] grant_word;	// mshrs.scala:411:23
  reg  [1:0]  state;	// mshrs.scala:415:22
  wire        _io_req_ready_output = state == 2'h0;	// mshrs.scala:415:22, :416:25
  wire        get_a_mask_size = size == 2'h2;	// Edges.scala:499:15, Misc.scala:208:26, mshrs.scala:410:16
  wire        get_a_mask_acc = (&size) | get_a_mask_size & ~(req_addr[2]);	// Misc.scala:205:21, :208:26, :209:26, :210:20, :214:{29,38}, mshrs.scala:410:16
  wire        get_a_mask_acc_1 = (&size) | get_a_mask_size & req_addr[2];	// Misc.scala:205:21, :208:26, :209:26, :214:{29,38}, mshrs.scala:410:16
  wire        get_a_mask_size_1 = size == 2'h1;	// Misc.scala:208:26, mshrs.scala:410:16, :445:32
  wire        get_a_mask_eq_2 = ~(req_addr[2]) & ~(req_addr[1]);	// Misc.scala:209:26, :210:20, :213:27, mshrs.scala:410:16
  wire        get_a_mask_acc_2 = get_a_mask_acc | get_a_mask_size_1 & get_a_mask_eq_2;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        get_a_mask_eq_3 = ~(req_addr[2]) & req_addr[1];	// Misc.scala:209:26, :210:20, :213:27, mshrs.scala:410:16
  wire        get_a_mask_acc_3 = get_a_mask_acc | get_a_mask_size_1 & get_a_mask_eq_3;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        get_a_mask_eq_4 = req_addr[2] & ~(req_addr[1]);	// Misc.scala:209:26, :210:20, :213:27, mshrs.scala:410:16
  wire        get_a_mask_acc_4 = get_a_mask_acc_1 | get_a_mask_size_1 & get_a_mask_eq_4;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        get_a_mask_eq_5 = req_addr[2] & req_addr[1];	// Misc.scala:209:26, :213:27, mshrs.scala:410:16
  wire        get_a_mask_acc_5 = get_a_mask_acc_1 | get_a_mask_size_1 & get_a_mask_eq_5;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        put_a_mask_size = size == 2'h2;	// Edges.scala:499:15, Misc.scala:208:26, mshrs.scala:410:16
  wire        put_a_mask_acc = (&size) | put_a_mask_size & ~(req_addr[2]);	// Misc.scala:205:21, :208:26, :209:26, :210:20, :214:{29,38}, mshrs.scala:410:16
  wire        put_a_mask_acc_1 = (&size) | put_a_mask_size & req_addr[2];	// Misc.scala:205:21, :208:26, :209:26, :214:{29,38}, mshrs.scala:410:16
  wire        put_a_mask_size_1 = size == 2'h1;	// Misc.scala:208:26, mshrs.scala:410:16, :445:32
  wire        put_a_mask_eq_2 = ~(req_addr[2]) & ~(req_addr[1]);	// Misc.scala:209:26, :210:20, :213:27, mshrs.scala:410:16
  wire        put_a_mask_acc_2 = put_a_mask_acc | put_a_mask_size_1 & put_a_mask_eq_2;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        put_a_mask_eq_3 = ~(req_addr[2]) & req_addr[1];	// Misc.scala:209:26, :210:20, :213:27, mshrs.scala:410:16
  wire        put_a_mask_acc_3 = put_a_mask_acc | put_a_mask_size_1 & put_a_mask_eq_3;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        put_a_mask_eq_4 = req_addr[2] & ~(req_addr[1]);	// Misc.scala:209:26, :210:20, :213:27, mshrs.scala:410:16
  wire        put_a_mask_acc_4 = put_a_mask_acc_1 | put_a_mask_size_1 & put_a_mask_eq_4;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        put_a_mask_eq_5 = req_addr[2] & req_addr[1];	// Misc.scala:209:26, :213:27, mshrs.scala:410:16
  wire        put_a_mask_acc_5 = put_a_mask_acc_1 | put_a_mask_size_1 & put_a_mask_eq_5;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        atomics_a_mask_size = size == 2'h2;	// Edges.scala:499:15, Misc.scala:208:26, mshrs.scala:410:16
  wire        atomics_a_mask_acc = (&size) | atomics_a_mask_size & ~(req_addr[2]);	// Misc.scala:205:21, :208:26, :209:26, :210:20, :214:{29,38}, mshrs.scala:410:16
  wire        atomics_a_mask_acc_1 = (&size) | atomics_a_mask_size & req_addr[2];	// Misc.scala:205:21, :208:26, :209:26, :214:{29,38}, mshrs.scala:410:16
  wire        atomics_a_mask_size_1 = size == 2'h1;	// Misc.scala:208:26, mshrs.scala:410:16, :445:32
  wire        atomics_a_mask_eq_2 = ~(req_addr[2]) & ~(req_addr[1]);	// Misc.scala:209:26, :210:20, :213:27, mshrs.scala:410:16
  wire        atomics_a_mask_acc_2 =
    atomics_a_mask_acc | atomics_a_mask_size_1 & atomics_a_mask_eq_2;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        atomics_a_mask_eq_3 = ~(req_addr[2]) & req_addr[1];	// Misc.scala:209:26, :210:20, :213:27, mshrs.scala:410:16
  wire        atomics_a_mask_acc_3 =
    atomics_a_mask_acc | atomics_a_mask_size_1 & atomics_a_mask_eq_3;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        atomics_a_mask_eq_4 = req_addr[2] & ~(req_addr[1]);	// Misc.scala:209:26, :210:20, :213:27, mshrs.scala:410:16
  wire        atomics_a_mask_acc_4 =
    atomics_a_mask_acc_1 | atomics_a_mask_size_1 & atomics_a_mask_eq_4;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        atomics_a_mask_eq_5 = req_addr[2] & req_addr[1];	// Misc.scala:209:26, :213:27, mshrs.scala:410:16
  wire        atomics_a_mask_acc_5 =
    atomics_a_mask_acc_1 | atomics_a_mask_size_1 & atomics_a_mask_eq_5;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        atomics_a_mask_size_3 = size == 2'h2;	// Edges.scala:499:15, Misc.scala:208:26, mshrs.scala:410:16
  wire        atomics_a_mask_acc_6 = (&size) | atomics_a_mask_size_3 & ~(req_addr[2]);	// Misc.scala:205:21, :208:26, :209:26, :210:20, :214:{29,38}, mshrs.scala:410:16
  wire        atomics_a_mask_acc_7 = (&size) | atomics_a_mask_size_3 & req_addr[2];	// Misc.scala:205:21, :208:26, :209:26, :214:{29,38}, mshrs.scala:410:16
  wire        atomics_a_mask_size_4 = size == 2'h1;	// Misc.scala:208:26, mshrs.scala:410:16, :445:32
  wire        atomics_a_mask_eq_16 = ~(req_addr[2]) & ~(req_addr[1]);	// Misc.scala:209:26, :210:20, :213:27, mshrs.scala:410:16
  wire        atomics_a_mask_acc_8 =
    atomics_a_mask_acc_6 | atomics_a_mask_size_4 & atomics_a_mask_eq_16;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        atomics_a_mask_eq_17 = ~(req_addr[2]) & req_addr[1];	// Misc.scala:209:26, :210:20, :213:27, mshrs.scala:410:16
  wire        atomics_a_mask_acc_9 =
    atomics_a_mask_acc_6 | atomics_a_mask_size_4 & atomics_a_mask_eq_17;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        atomics_a_mask_eq_18 = req_addr[2] & ~(req_addr[1]);	// Misc.scala:209:26, :210:20, :213:27, mshrs.scala:410:16
  wire        atomics_a_mask_acc_10 =
    atomics_a_mask_acc_7 | atomics_a_mask_size_4 & atomics_a_mask_eq_18;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        atomics_a_mask_eq_19 = req_addr[2] & req_addr[1];	// Misc.scala:209:26, :213:27, mshrs.scala:410:16
  wire        atomics_a_mask_acc_11 =
    atomics_a_mask_acc_7 | atomics_a_mask_size_4 & atomics_a_mask_eq_19;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        atomics_a_mask_size_6 = size == 2'h2;	// Edges.scala:499:15, Misc.scala:208:26, mshrs.scala:410:16
  wire        atomics_a_mask_acc_12 = (&size) | atomics_a_mask_size_6 & ~(req_addr[2]);	// Misc.scala:205:21, :208:26, :209:26, :210:20, :214:{29,38}, mshrs.scala:410:16
  wire        atomics_a_mask_acc_13 = (&size) | atomics_a_mask_size_6 & req_addr[2];	// Misc.scala:205:21, :208:26, :209:26, :214:{29,38}, mshrs.scala:410:16
  wire        atomics_a_mask_size_7 = size == 2'h1;	// Misc.scala:208:26, mshrs.scala:410:16, :445:32
  wire        atomics_a_mask_eq_30 = ~(req_addr[2]) & ~(req_addr[1]);	// Misc.scala:209:26, :210:20, :213:27, mshrs.scala:410:16
  wire        atomics_a_mask_acc_14 =
    atomics_a_mask_acc_12 | atomics_a_mask_size_7 & atomics_a_mask_eq_30;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        atomics_a_mask_eq_31 = ~(req_addr[2]) & req_addr[1];	// Misc.scala:209:26, :210:20, :213:27, mshrs.scala:410:16
  wire        atomics_a_mask_acc_15 =
    atomics_a_mask_acc_12 | atomics_a_mask_size_7 & atomics_a_mask_eq_31;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        atomics_a_mask_eq_32 = req_addr[2] & ~(req_addr[1]);	// Misc.scala:209:26, :210:20, :213:27, mshrs.scala:410:16
  wire        atomics_a_mask_acc_16 =
    atomics_a_mask_acc_13 | atomics_a_mask_size_7 & atomics_a_mask_eq_32;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        atomics_a_mask_eq_33 = req_addr[2] & req_addr[1];	// Misc.scala:209:26, :213:27, mshrs.scala:410:16
  wire        atomics_a_mask_acc_17 =
    atomics_a_mask_acc_13 | atomics_a_mask_size_7 & atomics_a_mask_eq_33;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        atomics_a_mask_size_9 = size == 2'h2;	// Edges.scala:499:15, Misc.scala:208:26, mshrs.scala:410:16
  wire        atomics_a_mask_acc_18 = (&size) | atomics_a_mask_size_9 & ~(req_addr[2]);	// Misc.scala:205:21, :208:26, :209:26, :210:20, :214:{29,38}, mshrs.scala:410:16
  wire        atomics_a_mask_acc_19 = (&size) | atomics_a_mask_size_9 & req_addr[2];	// Misc.scala:205:21, :208:26, :209:26, :214:{29,38}, mshrs.scala:410:16
  wire        atomics_a_mask_size_10 = size == 2'h1;	// Misc.scala:208:26, mshrs.scala:410:16, :445:32
  wire        atomics_a_mask_eq_44 = ~(req_addr[2]) & ~(req_addr[1]);	// Misc.scala:209:26, :210:20, :213:27, mshrs.scala:410:16
  wire        atomics_a_mask_acc_20 =
    atomics_a_mask_acc_18 | atomics_a_mask_size_10 & atomics_a_mask_eq_44;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        atomics_a_mask_eq_45 = ~(req_addr[2]) & req_addr[1];	// Misc.scala:209:26, :210:20, :213:27, mshrs.scala:410:16
  wire        atomics_a_mask_acc_21 =
    atomics_a_mask_acc_18 | atomics_a_mask_size_10 & atomics_a_mask_eq_45;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        atomics_a_mask_eq_46 = req_addr[2] & ~(req_addr[1]);	// Misc.scala:209:26, :210:20, :213:27, mshrs.scala:410:16
  wire        atomics_a_mask_acc_22 =
    atomics_a_mask_acc_19 | atomics_a_mask_size_10 & atomics_a_mask_eq_46;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        atomics_a_mask_eq_47 = req_addr[2] & req_addr[1];	// Misc.scala:209:26, :213:27, mshrs.scala:410:16
  wire        atomics_a_mask_acc_23 =
    atomics_a_mask_acc_19 | atomics_a_mask_size_10 & atomics_a_mask_eq_47;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        atomics_a_mask_size_12 = size == 2'h2;	// Edges.scala:499:15, Misc.scala:208:26, mshrs.scala:410:16
  wire        atomics_a_mask_acc_24 = (&size) | atomics_a_mask_size_12 & ~(req_addr[2]);	// Misc.scala:205:21, :208:26, :209:26, :210:20, :214:{29,38}, mshrs.scala:410:16
  wire        atomics_a_mask_acc_25 = (&size) | atomics_a_mask_size_12 & req_addr[2];	// Misc.scala:205:21, :208:26, :209:26, :214:{29,38}, mshrs.scala:410:16
  wire        atomics_a_mask_size_13 = size == 2'h1;	// Misc.scala:208:26, mshrs.scala:410:16, :445:32
  wire        atomics_a_mask_eq_58 = ~(req_addr[2]) & ~(req_addr[1]);	// Misc.scala:209:26, :210:20, :213:27, mshrs.scala:410:16
  wire        atomics_a_mask_acc_26 =
    atomics_a_mask_acc_24 | atomics_a_mask_size_13 & atomics_a_mask_eq_58;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        atomics_a_mask_eq_59 = ~(req_addr[2]) & req_addr[1];	// Misc.scala:209:26, :210:20, :213:27, mshrs.scala:410:16
  wire        atomics_a_mask_acc_27 =
    atomics_a_mask_acc_24 | atomics_a_mask_size_13 & atomics_a_mask_eq_59;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        atomics_a_mask_eq_60 = req_addr[2] & ~(req_addr[1]);	// Misc.scala:209:26, :210:20, :213:27, mshrs.scala:410:16
  wire        atomics_a_mask_acc_28 =
    atomics_a_mask_acc_25 | atomics_a_mask_size_13 & atomics_a_mask_eq_60;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        atomics_a_mask_eq_61 = req_addr[2] & req_addr[1];	// Misc.scala:209:26, :213:27, mshrs.scala:410:16
  wire        atomics_a_mask_acc_29 =
    atomics_a_mask_acc_25 | atomics_a_mask_size_13 & atomics_a_mask_eq_61;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        atomics_a_mask_size_15 = size == 2'h2;	// Edges.scala:499:15, Misc.scala:208:26, mshrs.scala:410:16
  wire        atomics_a_mask_acc_30 = (&size) | atomics_a_mask_size_15 & ~(req_addr[2]);	// Misc.scala:205:21, :208:26, :209:26, :210:20, :214:{29,38}, mshrs.scala:410:16
  wire        atomics_a_mask_acc_31 = (&size) | atomics_a_mask_size_15 & req_addr[2];	// Misc.scala:205:21, :208:26, :209:26, :214:{29,38}, mshrs.scala:410:16
  wire        atomics_a_mask_size_16 = size == 2'h1;	// Misc.scala:208:26, mshrs.scala:410:16, :445:32
  wire        atomics_a_mask_eq_72 = ~(req_addr[2]) & ~(req_addr[1]);	// Misc.scala:209:26, :210:20, :213:27, mshrs.scala:410:16
  wire        atomics_a_mask_acc_32 =
    atomics_a_mask_acc_30 | atomics_a_mask_size_16 & atomics_a_mask_eq_72;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        atomics_a_mask_eq_73 = ~(req_addr[2]) & req_addr[1];	// Misc.scala:209:26, :210:20, :213:27, mshrs.scala:410:16
  wire        atomics_a_mask_acc_33 =
    atomics_a_mask_acc_30 | atomics_a_mask_size_16 & atomics_a_mask_eq_73;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        atomics_a_mask_eq_74 = req_addr[2] & ~(req_addr[1]);	// Misc.scala:209:26, :210:20, :213:27, mshrs.scala:410:16
  wire        atomics_a_mask_acc_34 =
    atomics_a_mask_acc_31 | atomics_a_mask_size_16 & atomics_a_mask_eq_74;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        atomics_a_mask_eq_75 = req_addr[2] & req_addr[1];	// Misc.scala:209:26, :213:27, mshrs.scala:410:16
  wire        atomics_a_mask_acc_35 =
    atomics_a_mask_acc_31 | atomics_a_mask_size_16 & atomics_a_mask_eq_75;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        atomics_a_mask_size_18 = size == 2'h2;	// Edges.scala:499:15, Misc.scala:208:26, mshrs.scala:410:16
  wire        atomics_a_mask_acc_36 = (&size) | atomics_a_mask_size_18 & ~(req_addr[2]);	// Misc.scala:205:21, :208:26, :209:26, :210:20, :214:{29,38}, mshrs.scala:410:16
  wire        atomics_a_mask_acc_37 = (&size) | atomics_a_mask_size_18 & req_addr[2];	// Misc.scala:205:21, :208:26, :209:26, :214:{29,38}, mshrs.scala:410:16
  wire        atomics_a_mask_size_19 = size == 2'h1;	// Misc.scala:208:26, mshrs.scala:410:16, :445:32
  wire        atomics_a_mask_eq_86 = ~(req_addr[2]) & ~(req_addr[1]);	// Misc.scala:209:26, :210:20, :213:27, mshrs.scala:410:16
  wire        atomics_a_mask_acc_38 =
    atomics_a_mask_acc_36 | atomics_a_mask_size_19 & atomics_a_mask_eq_86;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        atomics_a_mask_eq_87 = ~(req_addr[2]) & req_addr[1];	// Misc.scala:209:26, :210:20, :213:27, mshrs.scala:410:16
  wire        atomics_a_mask_acc_39 =
    atomics_a_mask_acc_36 | atomics_a_mask_size_19 & atomics_a_mask_eq_87;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        atomics_a_mask_eq_88 = req_addr[2] & ~(req_addr[1]);	// Misc.scala:209:26, :210:20, :213:27, mshrs.scala:410:16
  wire        atomics_a_mask_acc_40 =
    atomics_a_mask_acc_37 | atomics_a_mask_size_19 & atomics_a_mask_eq_88;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        atomics_a_mask_eq_89 = req_addr[2] & req_addr[1];	// Misc.scala:209:26, :213:27, mshrs.scala:410:16
  wire        atomics_a_mask_acc_41 =
    atomics_a_mask_acc_37 | atomics_a_mask_size_19 & atomics_a_mask_eq_89;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        atomics_a_mask_size_21 = size == 2'h2;	// Edges.scala:499:15, Misc.scala:208:26, mshrs.scala:410:16
  wire        atomics_a_mask_acc_42 = (&size) | atomics_a_mask_size_21 & ~(req_addr[2]);	// Misc.scala:205:21, :208:26, :209:26, :210:20, :214:{29,38}, mshrs.scala:410:16
  wire        atomics_a_mask_acc_43 = (&size) | atomics_a_mask_size_21 & req_addr[2];	// Misc.scala:205:21, :208:26, :209:26, :214:{29,38}, mshrs.scala:410:16
  wire        atomics_a_mask_size_22 = size == 2'h1;	// Misc.scala:208:26, mshrs.scala:410:16, :445:32
  wire        atomics_a_mask_eq_100 = ~(req_addr[2]) & ~(req_addr[1]);	// Misc.scala:209:26, :210:20, :213:27, mshrs.scala:410:16
  wire        atomics_a_mask_acc_44 =
    atomics_a_mask_acc_42 | atomics_a_mask_size_22 & atomics_a_mask_eq_100;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        atomics_a_mask_eq_101 = ~(req_addr[2]) & req_addr[1];	// Misc.scala:209:26, :210:20, :213:27, mshrs.scala:410:16
  wire        atomics_a_mask_acc_45 =
    atomics_a_mask_acc_42 | atomics_a_mask_size_22 & atomics_a_mask_eq_101;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        atomics_a_mask_eq_102 = req_addr[2] & ~(req_addr[1]);	// Misc.scala:209:26, :210:20, :213:27, mshrs.scala:410:16
  wire        atomics_a_mask_acc_46 =
    atomics_a_mask_acc_43 | atomics_a_mask_size_22 & atomics_a_mask_eq_102;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        atomics_a_mask_eq_103 = req_addr[2] & req_addr[1];	// Misc.scala:209:26, :213:27, mshrs.scala:410:16
  wire        atomics_a_mask_acc_47 =
    atomics_a_mask_acc_43 | atomics_a_mask_size_22 & atomics_a_mask_eq_103;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        atomics_a_mask_size_24 = size == 2'h2;	// Edges.scala:499:15, Misc.scala:208:26, mshrs.scala:410:16
  wire        atomics_a_mask_acc_48 = (&size) | atomics_a_mask_size_24 & ~(req_addr[2]);	// Misc.scala:205:21, :208:26, :209:26, :210:20, :214:{29,38}, mshrs.scala:410:16
  wire        atomics_a_mask_acc_49 = (&size) | atomics_a_mask_size_24 & req_addr[2];	// Misc.scala:205:21, :208:26, :209:26, :214:{29,38}, mshrs.scala:410:16
  wire        atomics_a_mask_size_25 = size == 2'h1;	// Misc.scala:208:26, mshrs.scala:410:16, :445:32
  wire        atomics_a_mask_eq_114 = ~(req_addr[2]) & ~(req_addr[1]);	// Misc.scala:209:26, :210:20, :213:27, mshrs.scala:410:16
  wire        atomics_a_mask_acc_50 =
    atomics_a_mask_acc_48 | atomics_a_mask_size_25 & atomics_a_mask_eq_114;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        atomics_a_mask_eq_115 = ~(req_addr[2]) & req_addr[1];	// Misc.scala:209:26, :210:20, :213:27, mshrs.scala:410:16
  wire        atomics_a_mask_acc_51 =
    atomics_a_mask_acc_48 | atomics_a_mask_size_25 & atomics_a_mask_eq_115;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        atomics_a_mask_eq_116 = req_addr[2] & ~(req_addr[1]);	// Misc.scala:209:26, :210:20, :213:27, mshrs.scala:410:16
  wire        atomics_a_mask_acc_52 =
    atomics_a_mask_acc_49 | atomics_a_mask_size_25 & atomics_a_mask_eq_116;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        atomics_a_mask_eq_117 = req_addr[2] & req_addr[1];	// Misc.scala:209:26, :213:27, mshrs.scala:410:16
  wire        atomics_a_mask_acc_53 =
    atomics_a_mask_acc_49 | atomics_a_mask_size_25 & atomics_a_mask_eq_117;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire        _atomics_T = req_uop_mem_cmd == 5'h4;	// Mux.scala:80:60, mshrs.scala:410:16
  wire        _atomics_T_2 = req_uop_mem_cmd == 5'h9;	// Mux.scala:80:60, mshrs.scala:410:16
  wire        _atomics_T_4 = req_uop_mem_cmd == 5'hA;	// Mux.scala:80:60, mshrs.scala:410:16
  wire        _atomics_T_6 = req_uop_mem_cmd == 5'hB;	// Mux.scala:80:60, mshrs.scala:410:16
  wire        _GEN = _atomics_T_6 | _atomics_T_4 | _atomics_T_2 | _atomics_T;	// Mux.scala:80:{57,60}
  wire        _atomics_T_8 = req_uop_mem_cmd == 5'h8;	// Mux.scala:80:60, mshrs.scala:410:16
  wire        _atomics_T_10 = req_uop_mem_cmd == 5'hC;	// Mux.scala:80:60, mshrs.scala:410:16
  wire        _atomics_T_12 = req_uop_mem_cmd == 5'hD;	// Mux.scala:80:60, mshrs.scala:410:16
  wire        _atomics_T_14 = req_uop_mem_cmd == 5'hE;	// Mux.scala:80:60, mshrs.scala:410:16
  wire        _atomics_T_16 = req_uop_mem_cmd == 5'hF;	// Mux.scala:80:60, mshrs.scala:410:16
  wire [7:0]  atomics_mask =
    _atomics_T_16
      ? {atomics_a_mask_acc_53 | atomics_a_mask_eq_117 & req_addr[0],
         atomics_a_mask_acc_53 | atomics_a_mask_eq_117 & ~(req_addr[0]),
         atomics_a_mask_acc_52 | atomics_a_mask_eq_116 & req_addr[0],
         atomics_a_mask_acc_52 | atomics_a_mask_eq_116 & ~(req_addr[0]),
         atomics_a_mask_acc_51 | atomics_a_mask_eq_115 & req_addr[0],
         atomics_a_mask_acc_51 | atomics_a_mask_eq_115 & ~(req_addr[0]),
         atomics_a_mask_acc_50 | atomics_a_mask_eq_114 & req_addr[0],
         atomics_a_mask_acc_50 | atomics_a_mask_eq_114 & ~(req_addr[0])}
      : _atomics_T_14
          ? {atomics_a_mask_acc_47 | atomics_a_mask_eq_103 & req_addr[0],
             atomics_a_mask_acc_47 | atomics_a_mask_eq_103 & ~(req_addr[0]),
             atomics_a_mask_acc_46 | atomics_a_mask_eq_102 & req_addr[0],
             atomics_a_mask_acc_46 | atomics_a_mask_eq_102 & ~(req_addr[0]),
             atomics_a_mask_acc_45 | atomics_a_mask_eq_101 & req_addr[0],
             atomics_a_mask_acc_45 | atomics_a_mask_eq_101 & ~(req_addr[0]),
             atomics_a_mask_acc_44 | atomics_a_mask_eq_100 & req_addr[0],
             atomics_a_mask_acc_44 | atomics_a_mask_eq_100 & ~(req_addr[0])}
          : _atomics_T_12
              ? {atomics_a_mask_acc_41 | atomics_a_mask_eq_89 & req_addr[0],
                 atomics_a_mask_acc_41 | atomics_a_mask_eq_89 & ~(req_addr[0]),
                 atomics_a_mask_acc_40 | atomics_a_mask_eq_88 & req_addr[0],
                 atomics_a_mask_acc_40 | atomics_a_mask_eq_88 & ~(req_addr[0]),
                 atomics_a_mask_acc_39 | atomics_a_mask_eq_87 & req_addr[0],
                 atomics_a_mask_acc_39 | atomics_a_mask_eq_87 & ~(req_addr[0]),
                 atomics_a_mask_acc_38 | atomics_a_mask_eq_86 & req_addr[0],
                 atomics_a_mask_acc_38 | atomics_a_mask_eq_86 & ~(req_addr[0])}
              : _atomics_T_10
                  ? {atomics_a_mask_acc_35 | atomics_a_mask_eq_75 & req_addr[0],
                     atomics_a_mask_acc_35 | atomics_a_mask_eq_75 & ~(req_addr[0]),
                     atomics_a_mask_acc_34 | atomics_a_mask_eq_74 & req_addr[0],
                     atomics_a_mask_acc_34 | atomics_a_mask_eq_74 & ~(req_addr[0]),
                     atomics_a_mask_acc_33 | atomics_a_mask_eq_73 & req_addr[0],
                     atomics_a_mask_acc_33 | atomics_a_mask_eq_73 & ~(req_addr[0]),
                     atomics_a_mask_acc_32 | atomics_a_mask_eq_72 & req_addr[0],
                     atomics_a_mask_acc_32 | atomics_a_mask_eq_72 & ~(req_addr[0])}
                  : _atomics_T_8
                      ? {atomics_a_mask_acc_29 | atomics_a_mask_eq_61 & req_addr[0],
                         atomics_a_mask_acc_29 | atomics_a_mask_eq_61 & ~(req_addr[0]),
                         atomics_a_mask_acc_28 | atomics_a_mask_eq_60 & req_addr[0],
                         atomics_a_mask_acc_28 | atomics_a_mask_eq_60 & ~(req_addr[0]),
                         atomics_a_mask_acc_27 | atomics_a_mask_eq_59 & req_addr[0],
                         atomics_a_mask_acc_27 | atomics_a_mask_eq_59 & ~(req_addr[0]),
                         atomics_a_mask_acc_26 | atomics_a_mask_eq_58 & req_addr[0],
                         atomics_a_mask_acc_26 | atomics_a_mask_eq_58 & ~(req_addr[0])}
                      : _atomics_T_6
                          ? {atomics_a_mask_acc_23 | atomics_a_mask_eq_47 & req_addr[0],
                             atomics_a_mask_acc_23 | atomics_a_mask_eq_47
                               & ~(req_addr[0]),
                             atomics_a_mask_acc_22 | atomics_a_mask_eq_46 & req_addr[0],
                             atomics_a_mask_acc_22 | atomics_a_mask_eq_46
                               & ~(req_addr[0]),
                             atomics_a_mask_acc_21 | atomics_a_mask_eq_45 & req_addr[0],
                             atomics_a_mask_acc_21 | atomics_a_mask_eq_45
                               & ~(req_addr[0]),
                             atomics_a_mask_acc_20 | atomics_a_mask_eq_44 & req_addr[0],
                             atomics_a_mask_acc_20 | atomics_a_mask_eq_44
                               & ~(req_addr[0])}
                          : _atomics_T_4
                              ? {atomics_a_mask_acc_17 | atomics_a_mask_eq_33
                                   & req_addr[0],
                                 atomics_a_mask_acc_17 | atomics_a_mask_eq_33
                                   & ~(req_addr[0]),
                                 atomics_a_mask_acc_16 | atomics_a_mask_eq_32
                                   & req_addr[0],
                                 atomics_a_mask_acc_16 | atomics_a_mask_eq_32
                                   & ~(req_addr[0]),
                                 atomics_a_mask_acc_15 | atomics_a_mask_eq_31
                                   & req_addr[0],
                                 atomics_a_mask_acc_15 | atomics_a_mask_eq_31
                                   & ~(req_addr[0]),
                                 atomics_a_mask_acc_14 | atomics_a_mask_eq_30
                                   & req_addr[0],
                                 atomics_a_mask_acc_14 | atomics_a_mask_eq_30
                                   & ~(req_addr[0])}
                              : _atomics_T_2
                                  ? {atomics_a_mask_acc_11 | atomics_a_mask_eq_19
                                       & req_addr[0],
                                     atomics_a_mask_acc_11 | atomics_a_mask_eq_19
                                       & ~(req_addr[0]),
                                     atomics_a_mask_acc_10 | atomics_a_mask_eq_18
                                       & req_addr[0],
                                     atomics_a_mask_acc_10 | atomics_a_mask_eq_18
                                       & ~(req_addr[0]),
                                     atomics_a_mask_acc_9 | atomics_a_mask_eq_17
                                       & req_addr[0],
                                     atomics_a_mask_acc_9 | atomics_a_mask_eq_17
                                       & ~(req_addr[0]),
                                     atomics_a_mask_acc_8 | atomics_a_mask_eq_16
                                       & req_addr[0],
                                     atomics_a_mask_acc_8 | atomics_a_mask_eq_16
                                       & ~(req_addr[0])}
                                  : _atomics_T
                                      ? {atomics_a_mask_acc_5 | atomics_a_mask_eq_5
                                           & req_addr[0],
                                         atomics_a_mask_acc_5 | atomics_a_mask_eq_5
                                           & ~(req_addr[0]),
                                         atomics_a_mask_acc_4 | atomics_a_mask_eq_4
                                           & req_addr[0],
                                         atomics_a_mask_acc_4 | atomics_a_mask_eq_4
                                           & ~(req_addr[0]),
                                         atomics_a_mask_acc_3 | atomics_a_mask_eq_3
                                           & req_addr[0],
                                         atomics_a_mask_acc_3 | atomics_a_mask_eq_3
                                           & ~(req_addr[0]),
                                         atomics_a_mask_acc_2 | atomics_a_mask_eq_2
                                           & req_addr[0],
                                         atomics_a_mask_acc_2 | atomics_a_mask_eq_2
                                           & ~(req_addr[0])}
                                      : 8'h0;	// Cat.scala:30:58, Misc.scala:209:26, :210:20, :213:27, :214:29, Mux.scala:80:{57,60}, mshrs.scala:410:16, :428:46
  `ifndef SYNTHESIS	// mshrs.scala:443:9
    always @(posedge clock) begin	// mshrs.scala:443:9
      if (~(_io_req_ready_output | req_uop_mem_cmd != 5'h7 | reset)) begin	// mshrs.scala:410:16, :416:25, :443:{9,46}
        if (`ASSERT_VERBOSE_COND_)	// mshrs.scala:443:9
          $error("Assertion failed\n    at mshrs.scala:443 assert(state === s_idle || req.uop.mem_cmd =/= M_XSC)\n");	// mshrs.scala:443:9
        if (`STOP_COND_)	// mshrs.scala:443:9
          $fatal;	// mshrs.scala:443:9
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  wire        _io_mem_access_valid_output = state == 2'h1;	// mshrs.scala:415:22, :445:32
  wire        _send_resp_T_5 = req_uop_mem_cmd == 5'h4;	// mshrs.scala:410:16, package.scala:15:47
  wire        _send_resp_T_6 = req_uop_mem_cmd == 5'h9;	// mshrs.scala:410:16, package.scala:15:47
  wire        _send_resp_T_7 = req_uop_mem_cmd == 5'hA;	// mshrs.scala:410:16, package.scala:15:47
  wire        _send_resp_T_8 = req_uop_mem_cmd == 5'hB;	// mshrs.scala:410:16, package.scala:15:47
  wire        _send_resp_T_12 = req_uop_mem_cmd == 5'h8;	// mshrs.scala:410:16, package.scala:15:47
  wire        _send_resp_T_13 = req_uop_mem_cmd == 5'hC;	// mshrs.scala:410:16, package.scala:15:47
  wire        _send_resp_T_14 = req_uop_mem_cmd == 5'hD;	// mshrs.scala:410:16, package.scala:15:47
  wire        _send_resp_T_15 = req_uop_mem_cmd == 5'hE;	// mshrs.scala:410:16, package.scala:15:47
  wire        _send_resp_T_16 = req_uop_mem_cmd == 5'hF;	// mshrs.scala:410:16, package.scala:15:47
  wire        _io_mem_access_bits_T_16 =
    _send_resp_T_5 | _send_resp_T_6 | _send_resp_T_7 | _send_resp_T_8 | _send_resp_T_12
    | _send_resp_T_13 | _send_resp_T_14 | _send_resp_T_15 | _send_resp_T_16;	// Consts.scala:79:44, package.scala:15:47
  wire        _send_resp_T = req_uop_mem_cmd == 5'h0;	// Consts.scala:81:31, mshrs.scala:410:16
  wire        _send_resp_T_1 = req_uop_mem_cmd == 5'h6;	// Consts.scala:81:48, mshrs.scala:410:16
  wire        _send_resp_T_3 = req_uop_mem_cmd == 5'h7;	// Consts.scala:81:65, mshrs.scala:410:16
  wire        _io_mem_access_bits_T_39 =
    _send_resp_T | _send_resp_T_1 | _send_resp_T_3 | _send_resp_T_5 | _send_resp_T_6
    | _send_resp_T_7 | _send_resp_T_8 | _send_resp_T_12 | _send_resp_T_13
    | _send_resp_T_14 | _send_resp_T_15 | _send_resp_T_16;	// Consts.scala:81:{31,48,65,75}, package.scala:15:47
  wire        _GEN_0 =
    ~_io_mem_access_bits_T_16 | _atomics_T_16 | _atomics_T_14 | _atomics_T_12
    | _atomics_T_10 | _atomics_T_8 | _atomics_T_6 | _atomics_T_4 | _atomics_T_2
    | _atomics_T;	// Consts.scala:79:44, Mux.scala:80:60, mshrs.scala:446:29
  wire        send_resp =
    _send_resp_T | _send_resp_T_1 | _send_resp_T_3 | _send_resp_T_5 | _send_resp_T_6
    | _send_resp_T_7 | _send_resp_T_8 | _send_resp_T_12 | _send_resp_T_13
    | _send_resp_T_14 | _send_resp_T_15 | _send_resp_T_16;	// Consts.scala:81:{31,48,65,75}, package.scala:15:47
  wire        _io_resp_valid_output = (&state) & send_resp;	// Consts.scala:81:75, mshrs.scala:415:22, :450:{31,43}
  wire [31:0] io_resp_bits_data_lo = req_addr[2] ? grant_word[63:32] : grant_word[31:0];	// AMOALU.scala:39:{24,37,55}, Misc.scala:209:26, mshrs.scala:410:16, :411:23
  wire [15:0] io_resp_bits_data_lo_1 =
    req_addr[1] ? io_resp_bits_data_lo[31:16] : io_resp_bits_data_lo[15:0];	// AMOALU.scala:39:{24,37,55}, Misc.scala:209:26, mshrs.scala:410:16
  wire [7:0]  io_resp_bits_data_lo_2 =
    req_addr[0] ? io_resp_bits_data_lo_1[15:8] : io_resp_bits_data_lo_1[7:0];	// AMOALU.scala:39:{24,37,55}, Misc.scala:209:26, mshrs.scala:410:16
  always @(posedge clock) begin
    automatic logic _GEN_1;	// Decoupled.scala:40:37
    automatic logic _GEN_2;	// mshrs.scala:461:29
    _GEN_1 = _io_req_ready_output & io_req_valid;	// Decoupled.scala:40:37, mshrs.scala:416:25
    _GEN_2 = state == 2'h2 & io_mem_ack_valid;	// Edges.scala:499:15, mshrs.scala:415:22, :461:{15,29}
    if (_GEN_1) begin	// Decoupled.scala:40:37
      req_uop_uopc <= io_req_bits_uop_uopc;	// mshrs.scala:410:16
      req_uop_inst <= io_req_bits_uop_inst;	// mshrs.scala:410:16
      req_uop_debug_inst <= io_req_bits_uop_debug_inst;	// mshrs.scala:410:16
      req_uop_is_rvc <= io_req_bits_uop_is_rvc;	// mshrs.scala:410:16
      req_uop_debug_pc <= io_req_bits_uop_debug_pc;	// mshrs.scala:410:16
      req_uop_iq_type <= io_req_bits_uop_iq_type;	// mshrs.scala:410:16
      req_uop_fu_code <= io_req_bits_uop_fu_code;	// mshrs.scala:410:16
      req_uop_ctrl_br_type <= io_req_bits_uop_ctrl_br_type;	// mshrs.scala:410:16
      req_uop_ctrl_op1_sel <= io_req_bits_uop_ctrl_op1_sel;	// mshrs.scala:410:16
      req_uop_ctrl_op2_sel <= io_req_bits_uop_ctrl_op2_sel;	// mshrs.scala:410:16
      req_uop_ctrl_imm_sel <= io_req_bits_uop_ctrl_imm_sel;	// mshrs.scala:410:16
      req_uop_ctrl_op_fcn <= io_req_bits_uop_ctrl_op_fcn;	// mshrs.scala:410:16
      req_uop_ctrl_fcn_dw <= io_req_bits_uop_ctrl_fcn_dw;	// mshrs.scala:410:16
      req_uop_ctrl_csr_cmd <= io_req_bits_uop_ctrl_csr_cmd;	// mshrs.scala:410:16
      req_uop_ctrl_is_load <= io_req_bits_uop_ctrl_is_load;	// mshrs.scala:410:16
      req_uop_ctrl_is_sta <= io_req_bits_uop_ctrl_is_sta;	// mshrs.scala:410:16
      req_uop_ctrl_is_std <= io_req_bits_uop_ctrl_is_std;	// mshrs.scala:410:16
      req_uop_iw_state <= io_req_bits_uop_iw_state;	// mshrs.scala:410:16
      req_uop_iw_p1_poisoned <= io_req_bits_uop_iw_p1_poisoned;	// mshrs.scala:410:16
      req_uop_iw_p2_poisoned <= io_req_bits_uop_iw_p2_poisoned;	// mshrs.scala:410:16
      req_uop_is_br <= io_req_bits_uop_is_br;	// mshrs.scala:410:16
      req_uop_is_jalr <= io_req_bits_uop_is_jalr;	// mshrs.scala:410:16
      req_uop_is_jal <= io_req_bits_uop_is_jal;	// mshrs.scala:410:16
      req_uop_is_sfb <= io_req_bits_uop_is_sfb;	// mshrs.scala:410:16
      req_uop_br_mask <= io_req_bits_uop_br_mask;	// mshrs.scala:410:16
      req_uop_br_tag <= io_req_bits_uop_br_tag;	// mshrs.scala:410:16
      req_uop_ftq_idx <= io_req_bits_uop_ftq_idx;	// mshrs.scala:410:16
      req_uop_edge_inst <= io_req_bits_uop_edge_inst;	// mshrs.scala:410:16
      req_uop_pc_lob <= io_req_bits_uop_pc_lob;	// mshrs.scala:410:16
      req_uop_taken <= io_req_bits_uop_taken;	// mshrs.scala:410:16
      req_uop_imm_packed <= io_req_bits_uop_imm_packed;	// mshrs.scala:410:16
      req_uop_csr_addr <= io_req_bits_uop_csr_addr;	// mshrs.scala:410:16
      req_uop_rob_idx <= io_req_bits_uop_rob_idx;	// mshrs.scala:410:16
      req_uop_ldq_idx <= io_req_bits_uop_ldq_idx;	// mshrs.scala:410:16
      req_uop_stq_idx <= io_req_bits_uop_stq_idx;	// mshrs.scala:410:16
      req_uop_rxq_idx <= io_req_bits_uop_rxq_idx;	// mshrs.scala:410:16
      req_uop_pdst <= io_req_bits_uop_pdst;	// mshrs.scala:410:16
      req_uop_prs1 <= io_req_bits_uop_prs1;	// mshrs.scala:410:16
      req_uop_prs2 <= io_req_bits_uop_prs2;	// mshrs.scala:410:16
      req_uop_prs3 <= io_req_bits_uop_prs3;	// mshrs.scala:410:16
      req_uop_ppred <= io_req_bits_uop_ppred;	// mshrs.scala:410:16
      req_uop_prs1_busy <= io_req_bits_uop_prs1_busy;	// mshrs.scala:410:16
      req_uop_prs2_busy <= io_req_bits_uop_prs2_busy;	// mshrs.scala:410:16
      req_uop_prs3_busy <= io_req_bits_uop_prs3_busy;	// mshrs.scala:410:16
      req_uop_ppred_busy <= io_req_bits_uop_ppred_busy;	// mshrs.scala:410:16
      req_uop_stale_pdst <= io_req_bits_uop_stale_pdst;	// mshrs.scala:410:16
      req_uop_exception <= io_req_bits_uop_exception;	// mshrs.scala:410:16
      req_uop_exc_cause <= io_req_bits_uop_exc_cause;	// mshrs.scala:410:16
      req_uop_bypassable <= io_req_bits_uop_bypassable;	// mshrs.scala:410:16
      req_uop_mem_cmd <= io_req_bits_uop_mem_cmd;	// mshrs.scala:410:16
      size <= io_req_bits_uop_mem_size;	// mshrs.scala:410:16
      req_uop_mem_signed <= io_req_bits_uop_mem_signed;	// mshrs.scala:410:16
      req_uop_is_fence <= io_req_bits_uop_is_fence;	// mshrs.scala:410:16
      req_uop_is_fencei <= io_req_bits_uop_is_fencei;	// mshrs.scala:410:16
      req_uop_is_amo <= io_req_bits_uop_is_amo;	// mshrs.scala:410:16
      req_uop_uses_ldq <= io_req_bits_uop_uses_ldq;	// mshrs.scala:410:16
      req_uop_uses_stq <= io_req_bits_uop_uses_stq;	// mshrs.scala:410:16
      req_uop_is_sys_pc2epc <= io_req_bits_uop_is_sys_pc2epc;	// mshrs.scala:410:16
      req_uop_is_unique <= io_req_bits_uop_is_unique;	// mshrs.scala:410:16
      req_uop_flush_on_commit <= io_req_bits_uop_flush_on_commit;	// mshrs.scala:410:16
      req_uop_ldst_is_rs1 <= io_req_bits_uop_ldst_is_rs1;	// mshrs.scala:410:16
      req_uop_ldst <= io_req_bits_uop_ldst;	// mshrs.scala:410:16
      req_uop_lrs1 <= io_req_bits_uop_lrs1;	// mshrs.scala:410:16
      req_uop_lrs2 <= io_req_bits_uop_lrs2;	// mshrs.scala:410:16
      req_uop_lrs3 <= io_req_bits_uop_lrs3;	// mshrs.scala:410:16
      req_uop_ldst_val <= io_req_bits_uop_ldst_val;	// mshrs.scala:410:16
      req_uop_dst_rtype <= io_req_bits_uop_dst_rtype;	// mshrs.scala:410:16
      req_uop_lrs1_rtype <= io_req_bits_uop_lrs1_rtype;	// mshrs.scala:410:16
      req_uop_lrs2_rtype <= io_req_bits_uop_lrs2_rtype;	// mshrs.scala:410:16
      req_uop_frs3_en <= io_req_bits_uop_frs3_en;	// mshrs.scala:410:16
      req_uop_fp_val <= io_req_bits_uop_fp_val;	// mshrs.scala:410:16
      req_uop_fp_single <= io_req_bits_uop_fp_single;	// mshrs.scala:410:16
      req_uop_xcpt_pf_if <= io_req_bits_uop_xcpt_pf_if;	// mshrs.scala:410:16
      req_uop_xcpt_ae_if <= io_req_bits_uop_xcpt_ae_if;	// mshrs.scala:410:16
      req_uop_xcpt_ma_if <= io_req_bits_uop_xcpt_ma_if;	// mshrs.scala:410:16
      req_uop_bp_debug_if <= io_req_bits_uop_bp_debug_if;	// mshrs.scala:410:16
      req_uop_bp_xcpt_if <= io_req_bits_uop_bp_xcpt_if;	// mshrs.scala:410:16
      req_uop_debug_fsrc <= io_req_bits_uop_debug_fsrc;	// mshrs.scala:410:16
      req_uop_debug_tsrc <= io_req_bits_uop_debug_tsrc;	// mshrs.scala:410:16
      req_addr <= io_req_bits_addr;	// mshrs.scala:410:16
      req_data <= io_req_bits_data;	// mshrs.scala:410:16
    end
    if (_GEN_2
        & (_send_resp_T | _send_resp_T_1 | _send_resp_T_3 | _send_resp_T_5
           | _send_resp_T_6 | _send_resp_T_7 | _send_resp_T_8 | _send_resp_T_12
           | _send_resp_T_13 | _send_resp_T_14 | _send_resp_T_15 | _send_resp_T_16))	// Consts.scala:81:{31,48,65,75}, mshrs.scala:411:23, :461:{29,50}, :463:36, :464:18, package.scala:15:47
      grant_word <= io_mem_ack_bits_data;	// mshrs.scala:411:23
    if (reset)
      state <= 2'h0;	// mshrs.scala:415:22
    else if ((&state) & (~send_resp | io_resp_ready & _io_resp_valid_output))	// Consts.scala:81:75, Decoupled.scala:40:37, mshrs.scala:415:22, :450:{31,43}, :461:50, :467:27, :468:{11,22,41}, :469:13
      state <= 2'h0;	// mshrs.scala:415:22
    else if (_GEN_2)	// mshrs.scala:461:29
      state <= 2'h3;	// Edges.scala:451:15, mshrs.scala:415:22
    else if (io_mem_access_ready & _io_mem_access_valid_output)	// Decoupled.scala:40:37, mshrs.scala:445:32
      state <= 2'h2;	// Edges.scala:499:15, mshrs.scala:415:22
    else if (_GEN_1)	// Decoupled.scala:40:37
      state <= 2'h1;	// mshrs.scala:415:22, :445:32
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
        req_uop_uopc = _RANDOM[5'h0][6:0];	// mshrs.scala:410:16
        req_uop_inst = {_RANDOM[5'h0][31:7], _RANDOM[5'h1][6:0]};	// mshrs.scala:410:16
        req_uop_debug_inst = {_RANDOM[5'h1][31:7], _RANDOM[5'h2][6:0]};	// mshrs.scala:410:16
        req_uop_is_rvc = _RANDOM[5'h2][7];	// mshrs.scala:410:16
        req_uop_debug_pc = {_RANDOM[5'h2][31:8], _RANDOM[5'h3][15:0]};	// mshrs.scala:410:16
        req_uop_iq_type = _RANDOM[5'h3][18:16];	// mshrs.scala:410:16
        req_uop_fu_code = _RANDOM[5'h3][28:19];	// mshrs.scala:410:16
        req_uop_ctrl_br_type = {_RANDOM[5'h3][31:29], _RANDOM[5'h4][0]};	// mshrs.scala:410:16
        req_uop_ctrl_op1_sel = _RANDOM[5'h4][2:1];	// mshrs.scala:410:16
        req_uop_ctrl_op2_sel = _RANDOM[5'h4][5:3];	// mshrs.scala:410:16
        req_uop_ctrl_imm_sel = _RANDOM[5'h4][8:6];	// mshrs.scala:410:16
        req_uop_ctrl_op_fcn = _RANDOM[5'h4][12:9];	// mshrs.scala:410:16
        req_uop_ctrl_fcn_dw = _RANDOM[5'h4][13];	// mshrs.scala:410:16
        req_uop_ctrl_csr_cmd = _RANDOM[5'h4][16:14];	// mshrs.scala:410:16
        req_uop_ctrl_is_load = _RANDOM[5'h4][17];	// mshrs.scala:410:16
        req_uop_ctrl_is_sta = _RANDOM[5'h4][18];	// mshrs.scala:410:16
        req_uop_ctrl_is_std = _RANDOM[5'h4][19];	// mshrs.scala:410:16
        req_uop_iw_state = _RANDOM[5'h4][21:20];	// mshrs.scala:410:16
        req_uop_iw_p1_poisoned = _RANDOM[5'h4][22];	// mshrs.scala:410:16
        req_uop_iw_p2_poisoned = _RANDOM[5'h4][23];	// mshrs.scala:410:16
        req_uop_is_br = _RANDOM[5'h4][24];	// mshrs.scala:410:16
        req_uop_is_jalr = _RANDOM[5'h4][25];	// mshrs.scala:410:16
        req_uop_is_jal = _RANDOM[5'h4][26];	// mshrs.scala:410:16
        req_uop_is_sfb = _RANDOM[5'h4][27];	// mshrs.scala:410:16
        req_uop_br_mask = {_RANDOM[5'h4][31:28], _RANDOM[5'h5][7:0]};	// mshrs.scala:410:16
        req_uop_br_tag = _RANDOM[5'h5][11:8];	// mshrs.scala:410:16
        req_uop_ftq_idx = _RANDOM[5'h5][16:12];	// mshrs.scala:410:16
        req_uop_edge_inst = _RANDOM[5'h5][17];	// mshrs.scala:410:16
        req_uop_pc_lob = _RANDOM[5'h5][23:18];	// mshrs.scala:410:16
        req_uop_taken = _RANDOM[5'h5][24];	// mshrs.scala:410:16
        req_uop_imm_packed = {_RANDOM[5'h5][31:25], _RANDOM[5'h6][12:0]};	// mshrs.scala:410:16
        req_uop_csr_addr = _RANDOM[5'h6][24:13];	// mshrs.scala:410:16
        req_uop_rob_idx = _RANDOM[5'h6][30:25];	// mshrs.scala:410:16
        req_uop_ldq_idx = {_RANDOM[5'h6][31], _RANDOM[5'h7][2:0]};	// mshrs.scala:410:16
        req_uop_stq_idx = _RANDOM[5'h7][6:3];	// mshrs.scala:410:16
        req_uop_rxq_idx = _RANDOM[5'h7][8:7];	// mshrs.scala:410:16
        req_uop_pdst = _RANDOM[5'h7][15:9];	// mshrs.scala:410:16
        req_uop_prs1 = _RANDOM[5'h7][22:16];	// mshrs.scala:410:16
        req_uop_prs2 = _RANDOM[5'h7][29:23];	// mshrs.scala:410:16
        req_uop_prs3 = {_RANDOM[5'h7][31:30], _RANDOM[5'h8][4:0]};	// mshrs.scala:410:16
        req_uop_ppred = _RANDOM[5'h8][9:5];	// mshrs.scala:410:16
        req_uop_prs1_busy = _RANDOM[5'h8][10];	// mshrs.scala:410:16
        req_uop_prs2_busy = _RANDOM[5'h8][11];	// mshrs.scala:410:16
        req_uop_prs3_busy = _RANDOM[5'h8][12];	// mshrs.scala:410:16
        req_uop_ppred_busy = _RANDOM[5'h8][13];	// mshrs.scala:410:16
        req_uop_stale_pdst = _RANDOM[5'h8][20:14];	// mshrs.scala:410:16
        req_uop_exception = _RANDOM[5'h8][21];	// mshrs.scala:410:16
        req_uop_exc_cause = {_RANDOM[5'h8][31:22], _RANDOM[5'h9], _RANDOM[5'hA][21:0]};	// mshrs.scala:410:16
        req_uop_bypassable = _RANDOM[5'hA][22];	// mshrs.scala:410:16
        req_uop_mem_cmd = _RANDOM[5'hA][27:23];	// mshrs.scala:410:16
        size = _RANDOM[5'hA][29:28];	// mshrs.scala:410:16
        req_uop_mem_signed = _RANDOM[5'hA][30];	// mshrs.scala:410:16
        req_uop_is_fence = _RANDOM[5'hA][31];	// mshrs.scala:410:16
        req_uop_is_fencei = _RANDOM[5'hB][0];	// mshrs.scala:410:16
        req_uop_is_amo = _RANDOM[5'hB][1];	// mshrs.scala:410:16
        req_uop_uses_ldq = _RANDOM[5'hB][2];	// mshrs.scala:410:16
        req_uop_uses_stq = _RANDOM[5'hB][3];	// mshrs.scala:410:16
        req_uop_is_sys_pc2epc = _RANDOM[5'hB][4];	// mshrs.scala:410:16
        req_uop_is_unique = _RANDOM[5'hB][5];	// mshrs.scala:410:16
        req_uop_flush_on_commit = _RANDOM[5'hB][6];	// mshrs.scala:410:16
        req_uop_ldst_is_rs1 = _RANDOM[5'hB][7];	// mshrs.scala:410:16
        req_uop_ldst = _RANDOM[5'hB][13:8];	// mshrs.scala:410:16
        req_uop_lrs1 = _RANDOM[5'hB][19:14];	// mshrs.scala:410:16
        req_uop_lrs2 = _RANDOM[5'hB][25:20];	// mshrs.scala:410:16
        req_uop_lrs3 = _RANDOM[5'hB][31:26];	// mshrs.scala:410:16
        req_uop_ldst_val = _RANDOM[5'hC][0];	// mshrs.scala:410:16
        req_uop_dst_rtype = _RANDOM[5'hC][2:1];	// mshrs.scala:410:16
        req_uop_lrs1_rtype = _RANDOM[5'hC][4:3];	// mshrs.scala:410:16
        req_uop_lrs2_rtype = _RANDOM[5'hC][6:5];	// mshrs.scala:410:16
        req_uop_frs3_en = _RANDOM[5'hC][7];	// mshrs.scala:410:16
        req_uop_fp_val = _RANDOM[5'hC][8];	// mshrs.scala:410:16
        req_uop_fp_single = _RANDOM[5'hC][9];	// mshrs.scala:410:16
        req_uop_xcpt_pf_if = _RANDOM[5'hC][10];	// mshrs.scala:410:16
        req_uop_xcpt_ae_if = _RANDOM[5'hC][11];	// mshrs.scala:410:16
        req_uop_xcpt_ma_if = _RANDOM[5'hC][12];	// mshrs.scala:410:16
        req_uop_bp_debug_if = _RANDOM[5'hC][13];	// mshrs.scala:410:16
        req_uop_bp_xcpt_if = _RANDOM[5'hC][14];	// mshrs.scala:410:16
        req_uop_debug_fsrc = _RANDOM[5'hC][16:15];	// mshrs.scala:410:16
        req_uop_debug_tsrc = _RANDOM[5'hC][18:17];	// mshrs.scala:410:16
        req_addr = {_RANDOM[5'hC][31:19], _RANDOM[5'hD][26:0]};	// mshrs.scala:410:16
        req_data = {_RANDOM[5'hD][31:27], _RANDOM[5'hE], _RANDOM[5'hF][26:0]};	// mshrs.scala:410:16
        grant_word = {_RANDOM[5'hF][31:28], _RANDOM[5'h10], _RANDOM[5'h11][27:0]};	// mshrs.scala:410:16, :411:23
        state = _RANDOM[5'h11][29:28];	// mshrs.scala:411:23, :415:22
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_req_ready = _io_req_ready_output;	// mshrs.scala:416:25
  assign io_resp_valid = _io_resp_valid_output;	// mshrs.scala:450:43
  assign io_resp_bits_uop_uopc = req_uop_uopc;	// mshrs.scala:410:16
  assign io_resp_bits_uop_inst = req_uop_inst;	// mshrs.scala:410:16
  assign io_resp_bits_uop_debug_inst = req_uop_debug_inst;	// mshrs.scala:410:16
  assign io_resp_bits_uop_is_rvc = req_uop_is_rvc;	// mshrs.scala:410:16
  assign io_resp_bits_uop_debug_pc = req_uop_debug_pc;	// mshrs.scala:410:16
  assign io_resp_bits_uop_iq_type = req_uop_iq_type;	// mshrs.scala:410:16
  assign io_resp_bits_uop_fu_code = req_uop_fu_code;	// mshrs.scala:410:16
  assign io_resp_bits_uop_ctrl_br_type = req_uop_ctrl_br_type;	// mshrs.scala:410:16
  assign io_resp_bits_uop_ctrl_op1_sel = req_uop_ctrl_op1_sel;	// mshrs.scala:410:16
  assign io_resp_bits_uop_ctrl_op2_sel = req_uop_ctrl_op2_sel;	// mshrs.scala:410:16
  assign io_resp_bits_uop_ctrl_imm_sel = req_uop_ctrl_imm_sel;	// mshrs.scala:410:16
  assign io_resp_bits_uop_ctrl_op_fcn = req_uop_ctrl_op_fcn;	// mshrs.scala:410:16
  assign io_resp_bits_uop_ctrl_fcn_dw = req_uop_ctrl_fcn_dw;	// mshrs.scala:410:16
  assign io_resp_bits_uop_ctrl_csr_cmd = req_uop_ctrl_csr_cmd;	// mshrs.scala:410:16
  assign io_resp_bits_uop_ctrl_is_load = req_uop_ctrl_is_load;	// mshrs.scala:410:16
  assign io_resp_bits_uop_ctrl_is_sta = req_uop_ctrl_is_sta;	// mshrs.scala:410:16
  assign io_resp_bits_uop_ctrl_is_std = req_uop_ctrl_is_std;	// mshrs.scala:410:16
  assign io_resp_bits_uop_iw_state = req_uop_iw_state;	// mshrs.scala:410:16
  assign io_resp_bits_uop_iw_p1_poisoned = req_uop_iw_p1_poisoned;	// mshrs.scala:410:16
  assign io_resp_bits_uop_iw_p2_poisoned = req_uop_iw_p2_poisoned;	// mshrs.scala:410:16
  assign io_resp_bits_uop_is_br = req_uop_is_br;	// mshrs.scala:410:16
  assign io_resp_bits_uop_is_jalr = req_uop_is_jalr;	// mshrs.scala:410:16
  assign io_resp_bits_uop_is_jal = req_uop_is_jal;	// mshrs.scala:410:16
  assign io_resp_bits_uop_is_sfb = req_uop_is_sfb;	// mshrs.scala:410:16
  assign io_resp_bits_uop_br_mask = req_uop_br_mask;	// mshrs.scala:410:16
  assign io_resp_bits_uop_br_tag = req_uop_br_tag;	// mshrs.scala:410:16
  assign io_resp_bits_uop_ftq_idx = req_uop_ftq_idx;	// mshrs.scala:410:16
  assign io_resp_bits_uop_edge_inst = req_uop_edge_inst;	// mshrs.scala:410:16
  assign io_resp_bits_uop_pc_lob = req_uop_pc_lob;	// mshrs.scala:410:16
  assign io_resp_bits_uop_taken = req_uop_taken;	// mshrs.scala:410:16
  assign io_resp_bits_uop_imm_packed = req_uop_imm_packed;	// mshrs.scala:410:16
  assign io_resp_bits_uop_csr_addr = req_uop_csr_addr;	// mshrs.scala:410:16
  assign io_resp_bits_uop_rob_idx = req_uop_rob_idx;	// mshrs.scala:410:16
  assign io_resp_bits_uop_ldq_idx = req_uop_ldq_idx;	// mshrs.scala:410:16
  assign io_resp_bits_uop_stq_idx = req_uop_stq_idx;	// mshrs.scala:410:16
  assign io_resp_bits_uop_rxq_idx = req_uop_rxq_idx;	// mshrs.scala:410:16
  assign io_resp_bits_uop_pdst = req_uop_pdst;	// mshrs.scala:410:16
  assign io_resp_bits_uop_prs1 = req_uop_prs1;	// mshrs.scala:410:16
  assign io_resp_bits_uop_prs2 = req_uop_prs2;	// mshrs.scala:410:16
  assign io_resp_bits_uop_prs3 = req_uop_prs3;	// mshrs.scala:410:16
  assign io_resp_bits_uop_ppred = req_uop_ppred;	// mshrs.scala:410:16
  assign io_resp_bits_uop_prs1_busy = req_uop_prs1_busy;	// mshrs.scala:410:16
  assign io_resp_bits_uop_prs2_busy = req_uop_prs2_busy;	// mshrs.scala:410:16
  assign io_resp_bits_uop_prs3_busy = req_uop_prs3_busy;	// mshrs.scala:410:16
  assign io_resp_bits_uop_ppred_busy = req_uop_ppred_busy;	// mshrs.scala:410:16
  assign io_resp_bits_uop_stale_pdst = req_uop_stale_pdst;	// mshrs.scala:410:16
  assign io_resp_bits_uop_exception = req_uop_exception;	// mshrs.scala:410:16
  assign io_resp_bits_uop_exc_cause = req_uop_exc_cause;	// mshrs.scala:410:16
  assign io_resp_bits_uop_bypassable = req_uop_bypassable;	// mshrs.scala:410:16
  assign io_resp_bits_uop_mem_cmd = req_uop_mem_cmd;	// mshrs.scala:410:16
  assign io_resp_bits_uop_mem_size = size;	// mshrs.scala:410:16
  assign io_resp_bits_uop_mem_signed = req_uop_mem_signed;	// mshrs.scala:410:16
  assign io_resp_bits_uop_is_fence = req_uop_is_fence;	// mshrs.scala:410:16
  assign io_resp_bits_uop_is_fencei = req_uop_is_fencei;	// mshrs.scala:410:16
  assign io_resp_bits_uop_is_amo = req_uop_is_amo;	// mshrs.scala:410:16
  assign io_resp_bits_uop_uses_ldq = req_uop_uses_ldq;	// mshrs.scala:410:16
  assign io_resp_bits_uop_uses_stq = req_uop_uses_stq;	// mshrs.scala:410:16
  assign io_resp_bits_uop_is_sys_pc2epc = req_uop_is_sys_pc2epc;	// mshrs.scala:410:16
  assign io_resp_bits_uop_is_unique = req_uop_is_unique;	// mshrs.scala:410:16
  assign io_resp_bits_uop_flush_on_commit = req_uop_flush_on_commit;	// mshrs.scala:410:16
  assign io_resp_bits_uop_ldst_is_rs1 = req_uop_ldst_is_rs1;	// mshrs.scala:410:16
  assign io_resp_bits_uop_ldst = req_uop_ldst;	// mshrs.scala:410:16
  assign io_resp_bits_uop_lrs1 = req_uop_lrs1;	// mshrs.scala:410:16
  assign io_resp_bits_uop_lrs2 = req_uop_lrs2;	// mshrs.scala:410:16
  assign io_resp_bits_uop_lrs3 = req_uop_lrs3;	// mshrs.scala:410:16
  assign io_resp_bits_uop_ldst_val = req_uop_ldst_val;	// mshrs.scala:410:16
  assign io_resp_bits_uop_dst_rtype = req_uop_dst_rtype;	// mshrs.scala:410:16
  assign io_resp_bits_uop_lrs1_rtype = req_uop_lrs1_rtype;	// mshrs.scala:410:16
  assign io_resp_bits_uop_lrs2_rtype = req_uop_lrs2_rtype;	// mshrs.scala:410:16
  assign io_resp_bits_uop_frs3_en = req_uop_frs3_en;	// mshrs.scala:410:16
  assign io_resp_bits_uop_fp_val = req_uop_fp_val;	// mshrs.scala:410:16
  assign io_resp_bits_uop_fp_single = req_uop_fp_single;	// mshrs.scala:410:16
  assign io_resp_bits_uop_xcpt_pf_if = req_uop_xcpt_pf_if;	// mshrs.scala:410:16
  assign io_resp_bits_uop_xcpt_ae_if = req_uop_xcpt_ae_if;	// mshrs.scala:410:16
  assign io_resp_bits_uop_xcpt_ma_if = req_uop_xcpt_ma_if;	// mshrs.scala:410:16
  assign io_resp_bits_uop_bp_debug_if = req_uop_bp_debug_if;	// mshrs.scala:410:16
  assign io_resp_bits_uop_bp_xcpt_if = req_uop_bp_xcpt_if;	// mshrs.scala:410:16
  assign io_resp_bits_uop_debug_fsrc = req_uop_debug_fsrc;	// mshrs.scala:410:16
  assign io_resp_bits_uop_debug_tsrc = req_uop_debug_tsrc;	// mshrs.scala:410:16
  assign io_resp_bits_data =
    {size == 2'h0
       ? {56{req_uop_mem_signed & io_resp_bits_data_lo_2[7]}}
       : {size == 2'h1
            ? {48{req_uop_mem_signed & io_resp_bits_data_lo_1[15]}}
            : {size == 2'h2
                 ? {32{req_uop_mem_signed & io_resp_bits_data_lo[31]}}
                 : grant_word[63:32],
               io_resp_bits_data_lo[31:16]},
          io_resp_bits_data_lo_1[15:8]},
     io_resp_bits_data_lo_2};	// AMOALU.scala:39:{24,37}, :42:{20,26,76,85,98}, Bitwise.scala:72:12, Cat.scala:30:58, Edges.scala:499:15, mshrs.scala:410:16, :411:23, :415:22, :445:32
  assign io_mem_access_valid = _io_mem_access_valid_output;	// mshrs.scala:445:32
  assign io_mem_access_bits_opcode =
    _io_mem_access_bits_T_16
      ? (_atomics_T_16 | _atomics_T_14 | _atomics_T_12 | _atomics_T_10 | _atomics_T_8
           ? 3'h2
           : _GEN ? 3'h3 : 3'h0)
      : {_io_mem_access_bits_T_39, 2'h0};	// Consts.scala:79:44, :81:75, Edges.scala:515:15, Misc.scala:201:34, Mux.scala:80:{57,60}, mshrs.scala:415:22, :446:{29,66}
  assign io_mem_access_bits_param =
    _io_mem_access_bits_T_16
      ? (_atomics_T_16
           ? 3'h3
           : _atomics_T_14
               ? 3'h2
               : _atomics_T_12
                   ? 3'h1
                   : _atomics_T_10
                       ? 3'h0
                       : _atomics_T_8
                           ? 3'h4
                           : _atomics_T_6
                               ? 3'h2
                               : _atomics_T_4
                                   ? 3'h1
                                   : _atomics_T_2 | ~_atomics_T ? 3'h0 : 3'h3)
      : 3'h0;	// Consts.scala:79:44, Edges.scala:448:15, :515:15, Misc.scala:201:34, Mux.scala:80:{57,60}, mshrs.scala:446:29
  assign io_mem_access_bits_size = _GEN_0 ? {2'h0, size} : 4'h0;	// Edges.scala:450:15, mshrs.scala:410:16, :415:22, :428:46, :446:29
  assign io_mem_access_bits_source =
    _io_mem_access_bits_T_16
      ? {2{_atomics_T_16 | _atomics_T_14 | _atomics_T_12 | _atomics_T_10 | _atomics_T_8
             | _GEN}}
      : 2'h3;	// Consts.scala:79:44, Edges.scala:451:15, Mux.scala:80:{57,60}, mshrs.scala:446:29
  assign io_mem_access_bits_address = _GEN_0 ? req_addr[31:0] : 32'h0;	// Edges.scala:452:15, mshrs.scala:410:16, :428:46, :446:29
  assign io_mem_access_bits_mask =
    _io_mem_access_bits_T_16
      ? atomics_mask
      : _io_mem_access_bits_T_39
          ? {get_a_mask_acc_5 | get_a_mask_eq_5 & req_addr[0],
             get_a_mask_acc_5 | get_a_mask_eq_5 & ~(req_addr[0]),
             get_a_mask_acc_4 | get_a_mask_eq_4 & req_addr[0],
             get_a_mask_acc_4 | get_a_mask_eq_4 & ~(req_addr[0]),
             get_a_mask_acc_3 | get_a_mask_eq_3 & req_addr[0],
             get_a_mask_acc_3 | get_a_mask_eq_3 & ~(req_addr[0]),
             get_a_mask_acc_2 | get_a_mask_eq_2 & req_addr[0],
             get_a_mask_acc_2 | get_a_mask_eq_2 & ~(req_addr[0])}
          : {put_a_mask_acc_5 | put_a_mask_eq_5 & req_addr[0],
             put_a_mask_acc_5 | put_a_mask_eq_5 & ~(req_addr[0]),
             put_a_mask_acc_4 | put_a_mask_eq_4 & req_addr[0],
             put_a_mask_acc_4 | put_a_mask_eq_4 & ~(req_addr[0]),
             put_a_mask_acc_3 | put_a_mask_eq_3 & req_addr[0],
             put_a_mask_acc_3 | put_a_mask_eq_3 & ~(req_addr[0]),
             put_a_mask_acc_2 | put_a_mask_eq_2 & req_addr[0],
             put_a_mask_acc_2 | put_a_mask_eq_2 & ~(req_addr[0])};	// Cat.scala:30:58, Consts.scala:79:44, :81:75, Misc.scala:209:26, :210:20, :213:27, :214:29, Mux.scala:80:57, mshrs.scala:410:16, :446:{29,66}
  assign io_mem_access_bits_data =
    _io_mem_access_bits_T_16
      ? (_atomics_T_16 | _atomics_T_14 | _atomics_T_12 | _atomics_T_10 | _atomics_T_8
         | _atomics_T_6 | _atomics_T_4 | _atomics_T_2 | _atomics_T
           ? req_data
           : 64'h0)
      : _io_mem_access_bits_T_39 ? 64'h0 : req_data;	// Consts.scala:79:44, :81:75, Mux.scala:80:{57,60}, mshrs.scala:410:16, :428:46, :446:{29,66}
endmodule

