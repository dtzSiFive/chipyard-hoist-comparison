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

module FPUExeUnit_3(
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
  input  [64:0] io_req_bits_rs1_data,
                io_req_bits_rs2_data,
                io_req_bits_rs3_data,
  input         io_req_bits_kill,
                io_ll_iresp_ready,
  input  [11:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  input  [2:0]  io_fcsr_rm,
  output [9:0]  io_fu_types,
  output        io_fresp_valid,
  output [5:0]  io_fresp_bits_uop_rob_idx,
  output [6:0]  io_fresp_bits_uop_pdst,
  output        io_fresp_bits_uop_is_amo,
                io_fresp_bits_uop_uses_ldq,
                io_fresp_bits_uop_uses_stq,
  output [1:0]  io_fresp_bits_uop_dst_rtype,
  output        io_fresp_bits_uop_fp_val,
  output [64:0] io_fresp_bits_data,
  output        io_fresp_bits_fflags_valid,
  output [5:0]  io_fresp_bits_fflags_bits_uop_rob_idx,
  output [4:0]  io_fresp_bits_fflags_bits_flags,
  output        io_ll_iresp_valid,
  output [6:0]  io_ll_iresp_bits_uop_uopc,
  output [11:0] io_ll_iresp_bits_uop_br_mask,
  output [5:0]  io_ll_iresp_bits_uop_rob_idx,
  output [3:0]  io_ll_iresp_bits_uop_stq_idx,
  output [6:0]  io_ll_iresp_bits_uop_pdst,
  output        io_ll_iresp_bits_uop_is_amo,
                io_ll_iresp_bits_uop_uses_stq,
  output [1:0]  io_ll_iresp_bits_uop_dst_rtype,
  output [64:0] io_ll_iresp_bits_data,
  output        io_ll_iresp_bits_predicated
);

  wire        _fpiu_busy_T;	// execution-unit.scala:559:35
  wire        fdiv_busy;	// execution-unit.scala:507:41
  wire        _resp_arb_io_in_0_ready;	// execution-unit.scala:554:26
  wire        _resp_arb_io_in_1_ready;	// execution-unit.scala:554:26
  wire        _fp_sdq_io_enq_ready;	// execution-unit.scala:542:24
  wire        _fp_sdq_io_deq_valid;	// execution-unit.scala:542:24
  wire [6:0]  _fp_sdq_io_deq_bits_uop_uopc;	// execution-unit.scala:542:24
  wire [11:0] _fp_sdq_io_deq_bits_uop_br_mask;	// execution-unit.scala:542:24
  wire [5:0]  _fp_sdq_io_deq_bits_uop_rob_idx;	// execution-unit.scala:542:24
  wire [3:0]  _fp_sdq_io_deq_bits_uop_stq_idx;	// execution-unit.scala:542:24
  wire [6:0]  _fp_sdq_io_deq_bits_uop_pdst;	// execution-unit.scala:542:24
  wire        _fp_sdq_io_deq_bits_uop_is_amo;	// execution-unit.scala:542:24
  wire        _fp_sdq_io_deq_bits_uop_uses_stq;	// execution-unit.scala:542:24
  wire [1:0]  _fp_sdq_io_deq_bits_uop_dst_rtype;	// execution-unit.scala:542:24
  wire        _fp_sdq_io_deq_bits_uop_fp_val;	// execution-unit.scala:542:24
  wire [64:0] _fp_sdq_io_deq_bits_data;	// execution-unit.scala:542:24
  wire        _fp_sdq_io_deq_bits_predicated;	// execution-unit.scala:542:24
  wire        _fp_sdq_io_deq_bits_fflags_valid;	// execution-unit.scala:542:24
  wire [5:0]  _fp_sdq_io_deq_bits_fflags_bits_uop_rob_idx;	// execution-unit.scala:542:24
  wire [4:0]  _fp_sdq_io_deq_bits_fflags_bits_flags;	// execution-unit.scala:542:24
  wire        _fp_sdq_io_empty;	// execution-unit.scala:542:24
  wire        _queue_io_enq_ready;	// execution-unit.scala:528:23
  wire        _queue_io_deq_valid;	// execution-unit.scala:528:23
  wire [6:0]  _queue_io_deq_bits_uop_uopc;	// execution-unit.scala:528:23
  wire [11:0] _queue_io_deq_bits_uop_br_mask;	// execution-unit.scala:528:23
  wire [5:0]  _queue_io_deq_bits_uop_rob_idx;	// execution-unit.scala:528:23
  wire [3:0]  _queue_io_deq_bits_uop_stq_idx;	// execution-unit.scala:528:23
  wire [6:0]  _queue_io_deq_bits_uop_pdst;	// execution-unit.scala:528:23
  wire        _queue_io_deq_bits_uop_is_amo;	// execution-unit.scala:528:23
  wire        _queue_io_deq_bits_uop_uses_stq;	// execution-unit.scala:528:23
  wire [1:0]  _queue_io_deq_bits_uop_dst_rtype;	// execution-unit.scala:528:23
  wire        _queue_io_deq_bits_uop_fp_val;	// execution-unit.scala:528:23
  wire [64:0] _queue_io_deq_bits_data;	// execution-unit.scala:528:23
  wire        _queue_io_deq_bits_predicated;	// execution-unit.scala:528:23
  wire        _queue_io_deq_bits_fflags_valid;	// execution-unit.scala:528:23
  wire [5:0]  _queue_io_deq_bits_fflags_bits_uop_rob_idx;	// execution-unit.scala:528:23
  wire [4:0]  _queue_io_deq_bits_fflags_bits_flags;	// execution-unit.scala:528:23
  wire        _queue_io_empty;	// execution-unit.scala:528:23
  wire        _fdivsqrt_io_req_ready;	// execution-unit.scala:493:22
  wire        _fdivsqrt_io_resp_valid;	// execution-unit.scala:493:22
  wire [5:0]  _fdivsqrt_io_resp_bits_uop_rob_idx;	// execution-unit.scala:493:22
  wire [6:0]  _fdivsqrt_io_resp_bits_uop_pdst;	// execution-unit.scala:493:22
  wire        _fdivsqrt_io_resp_bits_uop_is_amo;	// execution-unit.scala:493:22
  wire        _fdivsqrt_io_resp_bits_uop_uses_ldq;	// execution-unit.scala:493:22
  wire        _fdivsqrt_io_resp_bits_uop_uses_stq;	// execution-unit.scala:493:22
  wire [1:0]  _fdivsqrt_io_resp_bits_uop_dst_rtype;	// execution-unit.scala:493:22
  wire        _fdivsqrt_io_resp_bits_uop_fp_val;	// execution-unit.scala:493:22
  wire [64:0] _fdivsqrt_io_resp_bits_data;	// execution-unit.scala:493:22
  wire        _fdivsqrt_io_resp_bits_fflags_valid;	// execution-unit.scala:493:22
  wire [5:0]  _fdivsqrt_io_resp_bits_fflags_bits_uop_rob_idx;	// execution-unit.scala:493:22
  wire [4:0]  _fdivsqrt_io_resp_bits_fflags_bits_flags;	// execution-unit.scala:493:22
  wire        _fpu_io_resp_valid;	// execution-unit.scala:468:17
  wire [6:0]  _fpu_io_resp_bits_uop_uopc;	// execution-unit.scala:468:17
  wire [31:0] _fpu_io_resp_bits_uop_inst;	// execution-unit.scala:468:17
  wire [31:0] _fpu_io_resp_bits_uop_debug_inst;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_uop_is_rvc;	// execution-unit.scala:468:17
  wire [39:0] _fpu_io_resp_bits_uop_debug_pc;	// execution-unit.scala:468:17
  wire [2:0]  _fpu_io_resp_bits_uop_iq_type;	// execution-unit.scala:468:17
  wire [9:0]  _fpu_io_resp_bits_uop_fu_code;	// execution-unit.scala:468:17
  wire [3:0]  _fpu_io_resp_bits_uop_ctrl_br_type;	// execution-unit.scala:468:17
  wire [1:0]  _fpu_io_resp_bits_uop_ctrl_op1_sel;	// execution-unit.scala:468:17
  wire [2:0]  _fpu_io_resp_bits_uop_ctrl_op2_sel;	// execution-unit.scala:468:17
  wire [2:0]  _fpu_io_resp_bits_uop_ctrl_imm_sel;	// execution-unit.scala:468:17
  wire [3:0]  _fpu_io_resp_bits_uop_ctrl_op_fcn;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_uop_ctrl_fcn_dw;	// execution-unit.scala:468:17
  wire [2:0]  _fpu_io_resp_bits_uop_ctrl_csr_cmd;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_uop_ctrl_is_load;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_uop_ctrl_is_sta;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_uop_ctrl_is_std;	// execution-unit.scala:468:17
  wire [1:0]  _fpu_io_resp_bits_uop_iw_state;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_uop_iw_p1_poisoned;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_uop_iw_p2_poisoned;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_uop_is_br;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_uop_is_jalr;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_uop_is_jal;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_uop_is_sfb;	// execution-unit.scala:468:17
  wire [11:0] _fpu_io_resp_bits_uop_br_mask;	// execution-unit.scala:468:17
  wire [3:0]  _fpu_io_resp_bits_uop_br_tag;	// execution-unit.scala:468:17
  wire [4:0]  _fpu_io_resp_bits_uop_ftq_idx;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_uop_edge_inst;	// execution-unit.scala:468:17
  wire [5:0]  _fpu_io_resp_bits_uop_pc_lob;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_uop_taken;	// execution-unit.scala:468:17
  wire [19:0] _fpu_io_resp_bits_uop_imm_packed;	// execution-unit.scala:468:17
  wire [11:0] _fpu_io_resp_bits_uop_csr_addr;	// execution-unit.scala:468:17
  wire [5:0]  _fpu_io_resp_bits_uop_rob_idx;	// execution-unit.scala:468:17
  wire [3:0]  _fpu_io_resp_bits_uop_ldq_idx;	// execution-unit.scala:468:17
  wire [3:0]  _fpu_io_resp_bits_uop_stq_idx;	// execution-unit.scala:468:17
  wire [1:0]  _fpu_io_resp_bits_uop_rxq_idx;	// execution-unit.scala:468:17
  wire [6:0]  _fpu_io_resp_bits_uop_pdst;	// execution-unit.scala:468:17
  wire [6:0]  _fpu_io_resp_bits_uop_prs1;	// execution-unit.scala:468:17
  wire [6:0]  _fpu_io_resp_bits_uop_prs2;	// execution-unit.scala:468:17
  wire [6:0]  _fpu_io_resp_bits_uop_prs3;	// execution-unit.scala:468:17
  wire [4:0]  _fpu_io_resp_bits_uop_ppred;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_uop_prs1_busy;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_uop_prs2_busy;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_uop_prs3_busy;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_uop_ppred_busy;	// execution-unit.scala:468:17
  wire [6:0]  _fpu_io_resp_bits_uop_stale_pdst;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_uop_exception;	// execution-unit.scala:468:17
  wire [63:0] _fpu_io_resp_bits_uop_exc_cause;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_uop_bypassable;	// execution-unit.scala:468:17
  wire [4:0]  _fpu_io_resp_bits_uop_mem_cmd;	// execution-unit.scala:468:17
  wire [1:0]  _fpu_io_resp_bits_uop_mem_size;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_uop_mem_signed;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_uop_is_fence;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_uop_is_fencei;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_uop_is_amo;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_uop_uses_ldq;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_uop_uses_stq;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_uop_is_sys_pc2epc;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_uop_is_unique;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_uop_flush_on_commit;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_uop_ldst_is_rs1;	// execution-unit.scala:468:17
  wire [5:0]  _fpu_io_resp_bits_uop_ldst;	// execution-unit.scala:468:17
  wire [5:0]  _fpu_io_resp_bits_uop_lrs1;	// execution-unit.scala:468:17
  wire [5:0]  _fpu_io_resp_bits_uop_lrs2;	// execution-unit.scala:468:17
  wire [5:0]  _fpu_io_resp_bits_uop_lrs3;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_uop_ldst_val;	// execution-unit.scala:468:17
  wire [1:0]  _fpu_io_resp_bits_uop_dst_rtype;	// execution-unit.scala:468:17
  wire [1:0]  _fpu_io_resp_bits_uop_lrs1_rtype;	// execution-unit.scala:468:17
  wire [1:0]  _fpu_io_resp_bits_uop_lrs2_rtype;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_uop_frs3_en;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_uop_fp_val;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_uop_fp_single;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_uop_xcpt_pf_if;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_uop_xcpt_ae_if;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_uop_xcpt_ma_if;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_uop_bp_debug_if;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_uop_bp_xcpt_if;	// execution-unit.scala:468:17
  wire [1:0]  _fpu_io_resp_bits_uop_debug_fsrc;	// execution-unit.scala:468:17
  wire [1:0]  _fpu_io_resp_bits_uop_debug_tsrc;	// execution-unit.scala:468:17
  wire [64:0] _fpu_io_resp_bits_data;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_valid;	// execution-unit.scala:468:17
  wire [6:0]  _fpu_io_resp_bits_fflags_bits_uop_uopc;	// execution-unit.scala:468:17
  wire [31:0] _fpu_io_resp_bits_fflags_bits_uop_inst;	// execution-unit.scala:468:17
  wire [31:0] _fpu_io_resp_bits_fflags_bits_uop_debug_inst;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_bits_uop_is_rvc;	// execution-unit.scala:468:17
  wire [39:0] _fpu_io_resp_bits_fflags_bits_uop_debug_pc;	// execution-unit.scala:468:17
  wire [2:0]  _fpu_io_resp_bits_fflags_bits_uop_iq_type;	// execution-unit.scala:468:17
  wire [9:0]  _fpu_io_resp_bits_fflags_bits_uop_fu_code;	// execution-unit.scala:468:17
  wire [3:0]  _fpu_io_resp_bits_fflags_bits_uop_ctrl_br_type;	// execution-unit.scala:468:17
  wire [1:0]  _fpu_io_resp_bits_fflags_bits_uop_ctrl_op1_sel;	// execution-unit.scala:468:17
  wire [2:0]  _fpu_io_resp_bits_fflags_bits_uop_ctrl_op2_sel;	// execution-unit.scala:468:17
  wire [2:0]  _fpu_io_resp_bits_fflags_bits_uop_ctrl_imm_sel;	// execution-unit.scala:468:17
  wire [3:0]  _fpu_io_resp_bits_fflags_bits_uop_ctrl_op_fcn;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_bits_uop_ctrl_fcn_dw;	// execution-unit.scala:468:17
  wire [2:0]  _fpu_io_resp_bits_fflags_bits_uop_ctrl_csr_cmd;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_bits_uop_ctrl_is_load;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_bits_uop_ctrl_is_sta;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_bits_uop_ctrl_is_std;	// execution-unit.scala:468:17
  wire [1:0]  _fpu_io_resp_bits_fflags_bits_uop_iw_state;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_bits_uop_iw_p1_poisoned;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_bits_uop_iw_p2_poisoned;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_bits_uop_is_br;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_bits_uop_is_jalr;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_bits_uop_is_jal;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_bits_uop_is_sfb;	// execution-unit.scala:468:17
  wire [11:0] _fpu_io_resp_bits_fflags_bits_uop_br_mask;	// execution-unit.scala:468:17
  wire [3:0]  _fpu_io_resp_bits_fflags_bits_uop_br_tag;	// execution-unit.scala:468:17
  wire [4:0]  _fpu_io_resp_bits_fflags_bits_uop_ftq_idx;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_bits_uop_edge_inst;	// execution-unit.scala:468:17
  wire [5:0]  _fpu_io_resp_bits_fflags_bits_uop_pc_lob;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_bits_uop_taken;	// execution-unit.scala:468:17
  wire [19:0] _fpu_io_resp_bits_fflags_bits_uop_imm_packed;	// execution-unit.scala:468:17
  wire [11:0] _fpu_io_resp_bits_fflags_bits_uop_csr_addr;	// execution-unit.scala:468:17
  wire [5:0]  _fpu_io_resp_bits_fflags_bits_uop_rob_idx;	// execution-unit.scala:468:17
  wire [3:0]  _fpu_io_resp_bits_fflags_bits_uop_ldq_idx;	// execution-unit.scala:468:17
  wire [3:0]  _fpu_io_resp_bits_fflags_bits_uop_stq_idx;	// execution-unit.scala:468:17
  wire [1:0]  _fpu_io_resp_bits_fflags_bits_uop_rxq_idx;	// execution-unit.scala:468:17
  wire [6:0]  _fpu_io_resp_bits_fflags_bits_uop_pdst;	// execution-unit.scala:468:17
  wire [6:0]  _fpu_io_resp_bits_fflags_bits_uop_prs1;	// execution-unit.scala:468:17
  wire [6:0]  _fpu_io_resp_bits_fflags_bits_uop_prs2;	// execution-unit.scala:468:17
  wire [6:0]  _fpu_io_resp_bits_fflags_bits_uop_prs3;	// execution-unit.scala:468:17
  wire [4:0]  _fpu_io_resp_bits_fflags_bits_uop_ppred;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_bits_uop_prs1_busy;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_bits_uop_prs2_busy;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_bits_uop_prs3_busy;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_bits_uop_ppred_busy;	// execution-unit.scala:468:17
  wire [6:0]  _fpu_io_resp_bits_fflags_bits_uop_stale_pdst;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_bits_uop_exception;	// execution-unit.scala:468:17
  wire [63:0] _fpu_io_resp_bits_fflags_bits_uop_exc_cause;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_bits_uop_bypassable;	// execution-unit.scala:468:17
  wire [4:0]  _fpu_io_resp_bits_fflags_bits_uop_mem_cmd;	// execution-unit.scala:468:17
  wire [1:0]  _fpu_io_resp_bits_fflags_bits_uop_mem_size;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_bits_uop_mem_signed;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_bits_uop_is_fence;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_bits_uop_is_fencei;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_bits_uop_is_amo;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_bits_uop_uses_ldq;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_bits_uop_uses_stq;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_bits_uop_is_sys_pc2epc;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_bits_uop_is_unique;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_bits_uop_flush_on_commit;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_bits_uop_ldst_is_rs1;	// execution-unit.scala:468:17
  wire [5:0]  _fpu_io_resp_bits_fflags_bits_uop_ldst;	// execution-unit.scala:468:17
  wire [5:0]  _fpu_io_resp_bits_fflags_bits_uop_lrs1;	// execution-unit.scala:468:17
  wire [5:0]  _fpu_io_resp_bits_fflags_bits_uop_lrs2;	// execution-unit.scala:468:17
  wire [5:0]  _fpu_io_resp_bits_fflags_bits_uop_lrs3;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_bits_uop_ldst_val;	// execution-unit.scala:468:17
  wire [1:0]  _fpu_io_resp_bits_fflags_bits_uop_dst_rtype;	// execution-unit.scala:468:17
  wire [1:0]  _fpu_io_resp_bits_fflags_bits_uop_lrs1_rtype;	// execution-unit.scala:468:17
  wire [1:0]  _fpu_io_resp_bits_fflags_bits_uop_lrs2_rtype;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_bits_uop_frs3_en;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_bits_uop_fp_val;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_bits_uop_fp_single;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_bits_uop_xcpt_pf_if;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_bits_uop_xcpt_ae_if;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_bits_uop_xcpt_ma_if;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_bits_uop_bp_debug_if;	// execution-unit.scala:468:17
  wire        _fpu_io_resp_bits_fflags_bits_uop_bp_xcpt_if;	// execution-unit.scala:468:17
  wire [1:0]  _fpu_io_resp_bits_fflags_bits_uop_debug_fsrc;	// execution-unit.scala:468:17
  wire [1:0]  _fpu_io_resp_bits_fflags_bits_uop_debug_tsrc;	// execution-unit.scala:468:17
  wire [4:0]  _fpu_io_resp_bits_fflags_bits_flags;	// execution-unit.scala:468:17
  assign fdiv_busy = ~_fdivsqrt_io_req_ready | io_req_valid & io_req_bits_uop_fu_code[7];	// execution-unit.scala:493:22, :507:{18,41,58}, micro-op.scala:154:40
  wire        _fp_sdq_io_enq_valid_T_5 =
    io_req_valid & io_req_bits_uop_uopc == 7'h2
    & (io_brupdate_b1_mispredict_mask & io_req_bits_uop_br_mask) == 12'h0;	// execution-unit.scala:532:60, :544:{70,81}, util.scala:118:{51,59}
  wire        fp_sdq_io_enq_bits_data_unrecoded_rawIn_isInf =
    (&(io_req_bits_rs2_data[63:62])) & ~(io_req_bits_rs2_data[61]);	// rawFloatFromRecFN.scala:50:21, :52:{29,54}, :55:41, :56:{33,36}
  wire        fp_sdq_io_enq_bits_data_unrecoded_isSubnormal =
    $signed({1'h0, io_req_bits_rs2_data[63:52]}) < 13'sh402;	// fNFromRecFN.scala:50:39, rawFloatFromRecFN.scala:50:21, :59:27
  wire [52:0] _fp_sdq_io_enq_bits_data_unrecoded_denormFract_T_1 =
    {1'h0, |(io_req_bits_rs2_data[63:61]), io_req_bits_rs2_data[51:1]} >> 6'h1
    - io_req_bits_rs2_data[57:52];	// fNFromRecFN.scala:51:{39,51}, :52:{38,42}, rawFloatFromRecFN.scala:50:21, :51:{29,54}
  wire [51:0] fp_sdq_io_enq_bits_data_unrecoded_lo =
    fp_sdq_io_enq_bits_data_unrecoded_isSubnormal
      ? _fp_sdq_io_enq_bits_data_unrecoded_denormFract_T_1[51:0]
      : fp_sdq_io_enq_bits_data_unrecoded_rawIn_isInf
          ? 52'h0
          : io_req_bits_rs2_data[51:0];	// fNFromRecFN.scala:50:39, :52:{42,60}, :61:16, :63:20, rawFloatFromRecFN.scala:56:33, :60:51
  wire [1:0]  _fp_sdq_io_enq_bits_data_prevUnrecoded_rawIn_isSpecial_T =
    {io_req_bits_rs2_data[52], io_req_bits_rs2_data[30]};	// FPU.scala:438:10, rawFloatFromRecFN.scala:50:21, :52:29
  wire        fp_sdq_io_enq_bits_data_prevUnrecoded_rawIn_isInf =
    (&_fp_sdq_io_enq_bits_data_prevUnrecoded_rawIn_isSpecial_T)
    & ~(io_req_bits_rs2_data[29]);	// rawFloatFromRecFN.scala:50:21, :52:{29,54}, :55:41, :56:{33,36}
  wire        fp_sdq_io_enq_bits_data_prevUnrecoded_isSubnormal =
    $signed({1'h0, io_req_bits_rs2_data[52], io_req_bits_rs2_data[30:23]}) < 10'sh82;	// FPU.scala:438:10, fNFromRecFN.scala:50:39, rawFloatFromRecFN.scala:50:21, :59:27
  wire [23:0] _fp_sdq_io_enq_bits_data_prevUnrecoded_denormFract_T_1 =
    {1'h0,
     |{io_req_bits_rs2_data[52], io_req_bits_rs2_data[30:29]},
     io_req_bits_rs2_data[22:1]} >> 5'h1 - io_req_bits_rs2_data[27:23];	// FPU.scala:438:10, fNFromRecFN.scala:51:{39,51}, :52:{38,42}, rawFloatFromRecFN.scala:50:21, :51:{29,54}
  `ifndef SYNTHESIS	// execution-unit.scala:540:12
    always @(posedge clock) begin	// execution-unit.scala:540:12
      if (~(_queue_io_enq_ready | reset)) begin	// execution-unit.scala:528:23, :540:12
        if (`ASSERT_VERBOSE_COND_)	// execution-unit.scala:540:12
          $error("Assertion failed\n    at execution-unit.scala:540 assert (queue.io.enq.ready) // If this backs up, we've miscalculated the size of the queue.\n");	// execution-unit.scala:540:12
        if (`STOP_COND_)	// execution-unit.scala:540:12
          $fatal;	// execution-unit.scala:540:12
      end
      if (~(~(_fp_sdq_io_enq_valid_T_5 & ~_fp_sdq_io_enq_ready) | reset)) begin	// execution-unit.scala:542:24, :544:81, :552:{11,12,34,37}
        if (`ASSERT_VERBOSE_COND_)	// execution-unit.scala:552:11
          $error("Assertion failed\n    at execution-unit.scala:552 assert(!(fp_sdq.io.enq.valid && !fp_sdq.io.enq.ready))\n");	// execution-unit.scala:552:11
        if (`STOP_COND_)	// execution-unit.scala:552:11
          $fatal;	// execution-unit.scala:552:11
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  assign _fpiu_busy_T = _queue_io_empty & _fp_sdq_io_empty;	// execution-unit.scala:528:23, :542:24, :559:35
  FPUUnit_3 fpu (	// execution-unit.scala:468:17
    .clock                                        (clock),
    .reset                                        (reset),
    .io_req_valid
      (io_req_valid & (io_req_bits_uop_fu_code[6] | io_req_bits_uop_fu_code[9])),	// execution-unit.scala:469:46, :470:69, micro-op.scala:154:40
    .io_req_bits_uop_uopc                         (io_req_bits_uop_uopc),
    .io_req_bits_uop_inst                         (io_req_bits_uop_inst),
    .io_req_bits_uop_debug_inst                   (io_req_bits_uop_debug_inst),
    .io_req_bits_uop_is_rvc                       (io_req_bits_uop_is_rvc),
    .io_req_bits_uop_debug_pc                     (io_req_bits_uop_debug_pc),
    .io_req_bits_uop_iq_type                      (io_req_bits_uop_iq_type),
    .io_req_bits_uop_fu_code                      (io_req_bits_uop_fu_code),
    .io_req_bits_uop_ctrl_br_type                 (io_req_bits_uop_ctrl_br_type),
    .io_req_bits_uop_ctrl_op1_sel                 (io_req_bits_uop_ctrl_op1_sel),
    .io_req_bits_uop_ctrl_op2_sel                 (io_req_bits_uop_ctrl_op2_sel),
    .io_req_bits_uop_ctrl_imm_sel                 (io_req_bits_uop_ctrl_imm_sel),
    .io_req_bits_uop_ctrl_op_fcn                  (io_req_bits_uop_ctrl_op_fcn),
    .io_req_bits_uop_ctrl_fcn_dw                  (io_req_bits_uop_ctrl_fcn_dw),
    .io_req_bits_uop_ctrl_csr_cmd                 (io_req_bits_uop_ctrl_csr_cmd),
    .io_req_bits_uop_ctrl_is_load                 (io_req_bits_uop_ctrl_is_load),
    .io_req_bits_uop_ctrl_is_sta                  (io_req_bits_uop_ctrl_is_sta),
    .io_req_bits_uop_ctrl_is_std                  (io_req_bits_uop_ctrl_is_std),
    .io_req_bits_uop_iw_state                     (io_req_bits_uop_iw_state),
    .io_req_bits_uop_iw_p1_poisoned               (io_req_bits_uop_iw_p1_poisoned),
    .io_req_bits_uop_iw_p2_poisoned               (io_req_bits_uop_iw_p2_poisoned),
    .io_req_bits_uop_is_br                        (io_req_bits_uop_is_br),
    .io_req_bits_uop_is_jalr                      (io_req_bits_uop_is_jalr),
    .io_req_bits_uop_is_jal                       (io_req_bits_uop_is_jal),
    .io_req_bits_uop_is_sfb                       (io_req_bits_uop_is_sfb),
    .io_req_bits_uop_br_mask                      (io_req_bits_uop_br_mask),
    .io_req_bits_uop_br_tag                       (io_req_bits_uop_br_tag),
    .io_req_bits_uop_ftq_idx                      (io_req_bits_uop_ftq_idx),
    .io_req_bits_uop_edge_inst                    (io_req_bits_uop_edge_inst),
    .io_req_bits_uop_pc_lob                       (io_req_bits_uop_pc_lob),
    .io_req_bits_uop_taken                        (io_req_bits_uop_taken),
    .io_req_bits_uop_imm_packed                   (io_req_bits_uop_imm_packed),
    .io_req_bits_uop_csr_addr                     (io_req_bits_uop_csr_addr),
    .io_req_bits_uop_rob_idx                      (io_req_bits_uop_rob_idx),
    .io_req_bits_uop_ldq_idx                      (io_req_bits_uop_ldq_idx),
    .io_req_bits_uop_stq_idx                      (io_req_bits_uop_stq_idx),
    .io_req_bits_uop_rxq_idx                      (io_req_bits_uop_rxq_idx),
    .io_req_bits_uop_pdst                         (io_req_bits_uop_pdst),
    .io_req_bits_uop_prs1                         (io_req_bits_uop_prs1),
    .io_req_bits_uop_prs2                         (io_req_bits_uop_prs2),
    .io_req_bits_uop_prs3                         (io_req_bits_uop_prs3),
    .io_req_bits_uop_ppred                        (io_req_bits_uop_ppred),
    .io_req_bits_uop_prs1_busy                    (io_req_bits_uop_prs1_busy),
    .io_req_bits_uop_prs2_busy                    (io_req_bits_uop_prs2_busy),
    .io_req_bits_uop_prs3_busy                    (io_req_bits_uop_prs3_busy),
    .io_req_bits_uop_ppred_busy                   (io_req_bits_uop_ppred_busy),
    .io_req_bits_uop_stale_pdst                   (io_req_bits_uop_stale_pdst),
    .io_req_bits_uop_exception                    (io_req_bits_uop_exception),
    .io_req_bits_uop_exc_cause                    (io_req_bits_uop_exc_cause),
    .io_req_bits_uop_bypassable                   (io_req_bits_uop_bypassable),
    .io_req_bits_uop_mem_cmd                      (io_req_bits_uop_mem_cmd),
    .io_req_bits_uop_mem_size                     (io_req_bits_uop_mem_size),
    .io_req_bits_uop_mem_signed                   (io_req_bits_uop_mem_signed),
    .io_req_bits_uop_is_fence                     (io_req_bits_uop_is_fence),
    .io_req_bits_uop_is_fencei                    (io_req_bits_uop_is_fencei),
    .io_req_bits_uop_is_amo                       (io_req_bits_uop_is_amo),
    .io_req_bits_uop_uses_ldq                     (io_req_bits_uop_uses_ldq),
    .io_req_bits_uop_uses_stq                     (io_req_bits_uop_uses_stq),
    .io_req_bits_uop_is_sys_pc2epc                (io_req_bits_uop_is_sys_pc2epc),
    .io_req_bits_uop_is_unique                    (io_req_bits_uop_is_unique),
    .io_req_bits_uop_flush_on_commit              (io_req_bits_uop_flush_on_commit),
    .io_req_bits_uop_ldst_is_rs1                  (io_req_bits_uop_ldst_is_rs1),
    .io_req_bits_uop_ldst                         (io_req_bits_uop_ldst),
    .io_req_bits_uop_lrs1                         (io_req_bits_uop_lrs1),
    .io_req_bits_uop_lrs2                         (io_req_bits_uop_lrs2),
    .io_req_bits_uop_lrs3                         (io_req_bits_uop_lrs3),
    .io_req_bits_uop_ldst_val                     (io_req_bits_uop_ldst_val),
    .io_req_bits_uop_dst_rtype                    (io_req_bits_uop_dst_rtype),
    .io_req_bits_uop_lrs1_rtype                   (io_req_bits_uop_lrs1_rtype),
    .io_req_bits_uop_lrs2_rtype                   (io_req_bits_uop_lrs2_rtype),
    .io_req_bits_uop_frs3_en                      (io_req_bits_uop_frs3_en),
    .io_req_bits_uop_fp_val                       (io_req_bits_uop_fp_val),
    .io_req_bits_uop_fp_single                    (io_req_bits_uop_fp_single),
    .io_req_bits_uop_xcpt_pf_if                   (io_req_bits_uop_xcpt_pf_if),
    .io_req_bits_uop_xcpt_ae_if                   (io_req_bits_uop_xcpt_ae_if),
    .io_req_bits_uop_xcpt_ma_if                   (io_req_bits_uop_xcpt_ma_if),
    .io_req_bits_uop_bp_debug_if                  (io_req_bits_uop_bp_debug_if),
    .io_req_bits_uop_bp_xcpt_if                   (io_req_bits_uop_bp_xcpt_if),
    .io_req_bits_uop_debug_fsrc                   (io_req_bits_uop_debug_fsrc),
    .io_req_bits_uop_debug_tsrc                   (io_req_bits_uop_debug_tsrc),
    .io_req_bits_rs1_data                         (io_req_bits_rs1_data),
    .io_req_bits_rs2_data                         (io_req_bits_rs2_data),
    .io_req_bits_rs3_data                         (io_req_bits_rs3_data),
    .io_req_bits_kill                             (io_req_bits_kill),
    .io_brupdate_b1_resolve_mask                  (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask               (io_brupdate_b1_mispredict_mask),
    .io_fcsr_rm                                   (io_fcsr_rm),
    .io_resp_valid                                (_fpu_io_resp_valid),
    .io_resp_bits_uop_uopc                        (_fpu_io_resp_bits_uop_uopc),
    .io_resp_bits_uop_inst                        (_fpu_io_resp_bits_uop_inst),
    .io_resp_bits_uop_debug_inst                  (_fpu_io_resp_bits_uop_debug_inst),
    .io_resp_bits_uop_is_rvc                      (_fpu_io_resp_bits_uop_is_rvc),
    .io_resp_bits_uop_debug_pc                    (_fpu_io_resp_bits_uop_debug_pc),
    .io_resp_bits_uop_iq_type                     (_fpu_io_resp_bits_uop_iq_type),
    .io_resp_bits_uop_fu_code                     (_fpu_io_resp_bits_uop_fu_code),
    .io_resp_bits_uop_ctrl_br_type                (_fpu_io_resp_bits_uop_ctrl_br_type),
    .io_resp_bits_uop_ctrl_op1_sel                (_fpu_io_resp_bits_uop_ctrl_op1_sel),
    .io_resp_bits_uop_ctrl_op2_sel                (_fpu_io_resp_bits_uop_ctrl_op2_sel),
    .io_resp_bits_uop_ctrl_imm_sel                (_fpu_io_resp_bits_uop_ctrl_imm_sel),
    .io_resp_bits_uop_ctrl_op_fcn                 (_fpu_io_resp_bits_uop_ctrl_op_fcn),
    .io_resp_bits_uop_ctrl_fcn_dw                 (_fpu_io_resp_bits_uop_ctrl_fcn_dw),
    .io_resp_bits_uop_ctrl_csr_cmd                (_fpu_io_resp_bits_uop_ctrl_csr_cmd),
    .io_resp_bits_uop_ctrl_is_load                (_fpu_io_resp_bits_uop_ctrl_is_load),
    .io_resp_bits_uop_ctrl_is_sta                 (_fpu_io_resp_bits_uop_ctrl_is_sta),
    .io_resp_bits_uop_ctrl_is_std                 (_fpu_io_resp_bits_uop_ctrl_is_std),
    .io_resp_bits_uop_iw_state                    (_fpu_io_resp_bits_uop_iw_state),
    .io_resp_bits_uop_iw_p1_poisoned              (_fpu_io_resp_bits_uop_iw_p1_poisoned),
    .io_resp_bits_uop_iw_p2_poisoned              (_fpu_io_resp_bits_uop_iw_p2_poisoned),
    .io_resp_bits_uop_is_br                       (_fpu_io_resp_bits_uop_is_br),
    .io_resp_bits_uop_is_jalr                     (_fpu_io_resp_bits_uop_is_jalr),
    .io_resp_bits_uop_is_jal                      (_fpu_io_resp_bits_uop_is_jal),
    .io_resp_bits_uop_is_sfb                      (_fpu_io_resp_bits_uop_is_sfb),
    .io_resp_bits_uop_br_mask                     (_fpu_io_resp_bits_uop_br_mask),
    .io_resp_bits_uop_br_tag                      (_fpu_io_resp_bits_uop_br_tag),
    .io_resp_bits_uop_ftq_idx                     (_fpu_io_resp_bits_uop_ftq_idx),
    .io_resp_bits_uop_edge_inst                   (_fpu_io_resp_bits_uop_edge_inst),
    .io_resp_bits_uop_pc_lob                      (_fpu_io_resp_bits_uop_pc_lob),
    .io_resp_bits_uop_taken                       (_fpu_io_resp_bits_uop_taken),
    .io_resp_bits_uop_imm_packed                  (_fpu_io_resp_bits_uop_imm_packed),
    .io_resp_bits_uop_csr_addr                    (_fpu_io_resp_bits_uop_csr_addr),
    .io_resp_bits_uop_rob_idx                     (_fpu_io_resp_bits_uop_rob_idx),
    .io_resp_bits_uop_ldq_idx                     (_fpu_io_resp_bits_uop_ldq_idx),
    .io_resp_bits_uop_stq_idx                     (_fpu_io_resp_bits_uop_stq_idx),
    .io_resp_bits_uop_rxq_idx                     (_fpu_io_resp_bits_uop_rxq_idx),
    .io_resp_bits_uop_pdst                        (_fpu_io_resp_bits_uop_pdst),
    .io_resp_bits_uop_prs1                        (_fpu_io_resp_bits_uop_prs1),
    .io_resp_bits_uop_prs2                        (_fpu_io_resp_bits_uop_prs2),
    .io_resp_bits_uop_prs3                        (_fpu_io_resp_bits_uop_prs3),
    .io_resp_bits_uop_ppred                       (_fpu_io_resp_bits_uop_ppred),
    .io_resp_bits_uop_prs1_busy                   (_fpu_io_resp_bits_uop_prs1_busy),
    .io_resp_bits_uop_prs2_busy                   (_fpu_io_resp_bits_uop_prs2_busy),
    .io_resp_bits_uop_prs3_busy                   (_fpu_io_resp_bits_uop_prs3_busy),
    .io_resp_bits_uop_ppred_busy                  (_fpu_io_resp_bits_uop_ppred_busy),
    .io_resp_bits_uop_stale_pdst                  (_fpu_io_resp_bits_uop_stale_pdst),
    .io_resp_bits_uop_exception                   (_fpu_io_resp_bits_uop_exception),
    .io_resp_bits_uop_exc_cause                   (_fpu_io_resp_bits_uop_exc_cause),
    .io_resp_bits_uop_bypassable                  (_fpu_io_resp_bits_uop_bypassable),
    .io_resp_bits_uop_mem_cmd                     (_fpu_io_resp_bits_uop_mem_cmd),
    .io_resp_bits_uop_mem_size                    (_fpu_io_resp_bits_uop_mem_size),
    .io_resp_bits_uop_mem_signed                  (_fpu_io_resp_bits_uop_mem_signed),
    .io_resp_bits_uop_is_fence                    (_fpu_io_resp_bits_uop_is_fence),
    .io_resp_bits_uop_is_fencei                   (_fpu_io_resp_bits_uop_is_fencei),
    .io_resp_bits_uop_is_amo                      (_fpu_io_resp_bits_uop_is_amo),
    .io_resp_bits_uop_uses_ldq                    (_fpu_io_resp_bits_uop_uses_ldq),
    .io_resp_bits_uop_uses_stq                    (_fpu_io_resp_bits_uop_uses_stq),
    .io_resp_bits_uop_is_sys_pc2epc               (_fpu_io_resp_bits_uop_is_sys_pc2epc),
    .io_resp_bits_uop_is_unique                   (_fpu_io_resp_bits_uop_is_unique),
    .io_resp_bits_uop_flush_on_commit             (_fpu_io_resp_bits_uop_flush_on_commit),
    .io_resp_bits_uop_ldst_is_rs1                 (_fpu_io_resp_bits_uop_ldst_is_rs1),
    .io_resp_bits_uop_ldst                        (_fpu_io_resp_bits_uop_ldst),
    .io_resp_bits_uop_lrs1                        (_fpu_io_resp_bits_uop_lrs1),
    .io_resp_bits_uop_lrs2                        (_fpu_io_resp_bits_uop_lrs2),
    .io_resp_bits_uop_lrs3                        (_fpu_io_resp_bits_uop_lrs3),
    .io_resp_bits_uop_ldst_val                    (_fpu_io_resp_bits_uop_ldst_val),
    .io_resp_bits_uop_dst_rtype                   (_fpu_io_resp_bits_uop_dst_rtype),
    .io_resp_bits_uop_lrs1_rtype                  (_fpu_io_resp_bits_uop_lrs1_rtype),
    .io_resp_bits_uop_lrs2_rtype                  (_fpu_io_resp_bits_uop_lrs2_rtype),
    .io_resp_bits_uop_frs3_en                     (_fpu_io_resp_bits_uop_frs3_en),
    .io_resp_bits_uop_fp_val                      (_fpu_io_resp_bits_uop_fp_val),
    .io_resp_bits_uop_fp_single                   (_fpu_io_resp_bits_uop_fp_single),
    .io_resp_bits_uop_xcpt_pf_if                  (_fpu_io_resp_bits_uop_xcpt_pf_if),
    .io_resp_bits_uop_xcpt_ae_if                  (_fpu_io_resp_bits_uop_xcpt_ae_if),
    .io_resp_bits_uop_xcpt_ma_if                  (_fpu_io_resp_bits_uop_xcpt_ma_if),
    .io_resp_bits_uop_bp_debug_if                 (_fpu_io_resp_bits_uop_bp_debug_if),
    .io_resp_bits_uop_bp_xcpt_if                  (_fpu_io_resp_bits_uop_bp_xcpt_if),
    .io_resp_bits_uop_debug_fsrc                  (_fpu_io_resp_bits_uop_debug_fsrc),
    .io_resp_bits_uop_debug_tsrc                  (_fpu_io_resp_bits_uop_debug_tsrc),
    .io_resp_bits_data                            (_fpu_io_resp_bits_data),
    .io_resp_bits_fflags_valid                    (_fpu_io_resp_bits_fflags_valid),
    .io_resp_bits_fflags_bits_uop_uopc
      (_fpu_io_resp_bits_fflags_bits_uop_uopc),
    .io_resp_bits_fflags_bits_uop_inst
      (_fpu_io_resp_bits_fflags_bits_uop_inst),
    .io_resp_bits_fflags_bits_uop_debug_inst
      (_fpu_io_resp_bits_fflags_bits_uop_debug_inst),
    .io_resp_bits_fflags_bits_uop_is_rvc
      (_fpu_io_resp_bits_fflags_bits_uop_is_rvc),
    .io_resp_bits_fflags_bits_uop_debug_pc
      (_fpu_io_resp_bits_fflags_bits_uop_debug_pc),
    .io_resp_bits_fflags_bits_uop_iq_type
      (_fpu_io_resp_bits_fflags_bits_uop_iq_type),
    .io_resp_bits_fflags_bits_uop_fu_code
      (_fpu_io_resp_bits_fflags_bits_uop_fu_code),
    .io_resp_bits_fflags_bits_uop_ctrl_br_type
      (_fpu_io_resp_bits_fflags_bits_uop_ctrl_br_type),
    .io_resp_bits_fflags_bits_uop_ctrl_op1_sel
      (_fpu_io_resp_bits_fflags_bits_uop_ctrl_op1_sel),
    .io_resp_bits_fflags_bits_uop_ctrl_op2_sel
      (_fpu_io_resp_bits_fflags_bits_uop_ctrl_op2_sel),
    .io_resp_bits_fflags_bits_uop_ctrl_imm_sel
      (_fpu_io_resp_bits_fflags_bits_uop_ctrl_imm_sel),
    .io_resp_bits_fflags_bits_uop_ctrl_op_fcn
      (_fpu_io_resp_bits_fflags_bits_uop_ctrl_op_fcn),
    .io_resp_bits_fflags_bits_uop_ctrl_fcn_dw
      (_fpu_io_resp_bits_fflags_bits_uop_ctrl_fcn_dw),
    .io_resp_bits_fflags_bits_uop_ctrl_csr_cmd
      (_fpu_io_resp_bits_fflags_bits_uop_ctrl_csr_cmd),
    .io_resp_bits_fflags_bits_uop_ctrl_is_load
      (_fpu_io_resp_bits_fflags_bits_uop_ctrl_is_load),
    .io_resp_bits_fflags_bits_uop_ctrl_is_sta
      (_fpu_io_resp_bits_fflags_bits_uop_ctrl_is_sta),
    .io_resp_bits_fflags_bits_uop_ctrl_is_std
      (_fpu_io_resp_bits_fflags_bits_uop_ctrl_is_std),
    .io_resp_bits_fflags_bits_uop_iw_state
      (_fpu_io_resp_bits_fflags_bits_uop_iw_state),
    .io_resp_bits_fflags_bits_uop_iw_p1_poisoned
      (_fpu_io_resp_bits_fflags_bits_uop_iw_p1_poisoned),
    .io_resp_bits_fflags_bits_uop_iw_p2_poisoned
      (_fpu_io_resp_bits_fflags_bits_uop_iw_p2_poisoned),
    .io_resp_bits_fflags_bits_uop_is_br
      (_fpu_io_resp_bits_fflags_bits_uop_is_br),
    .io_resp_bits_fflags_bits_uop_is_jalr
      (_fpu_io_resp_bits_fflags_bits_uop_is_jalr),
    .io_resp_bits_fflags_bits_uop_is_jal
      (_fpu_io_resp_bits_fflags_bits_uop_is_jal),
    .io_resp_bits_fflags_bits_uop_is_sfb
      (_fpu_io_resp_bits_fflags_bits_uop_is_sfb),
    .io_resp_bits_fflags_bits_uop_br_mask
      (_fpu_io_resp_bits_fflags_bits_uop_br_mask),
    .io_resp_bits_fflags_bits_uop_br_tag
      (_fpu_io_resp_bits_fflags_bits_uop_br_tag),
    .io_resp_bits_fflags_bits_uop_ftq_idx
      (_fpu_io_resp_bits_fflags_bits_uop_ftq_idx),
    .io_resp_bits_fflags_bits_uop_edge_inst
      (_fpu_io_resp_bits_fflags_bits_uop_edge_inst),
    .io_resp_bits_fflags_bits_uop_pc_lob
      (_fpu_io_resp_bits_fflags_bits_uop_pc_lob),
    .io_resp_bits_fflags_bits_uop_taken
      (_fpu_io_resp_bits_fflags_bits_uop_taken),
    .io_resp_bits_fflags_bits_uop_imm_packed
      (_fpu_io_resp_bits_fflags_bits_uop_imm_packed),
    .io_resp_bits_fflags_bits_uop_csr_addr
      (_fpu_io_resp_bits_fflags_bits_uop_csr_addr),
    .io_resp_bits_fflags_bits_uop_rob_idx
      (_fpu_io_resp_bits_fflags_bits_uop_rob_idx),
    .io_resp_bits_fflags_bits_uop_ldq_idx
      (_fpu_io_resp_bits_fflags_bits_uop_ldq_idx),
    .io_resp_bits_fflags_bits_uop_stq_idx
      (_fpu_io_resp_bits_fflags_bits_uop_stq_idx),
    .io_resp_bits_fflags_bits_uop_rxq_idx
      (_fpu_io_resp_bits_fflags_bits_uop_rxq_idx),
    .io_resp_bits_fflags_bits_uop_pdst
      (_fpu_io_resp_bits_fflags_bits_uop_pdst),
    .io_resp_bits_fflags_bits_uop_prs1
      (_fpu_io_resp_bits_fflags_bits_uop_prs1),
    .io_resp_bits_fflags_bits_uop_prs2
      (_fpu_io_resp_bits_fflags_bits_uop_prs2),
    .io_resp_bits_fflags_bits_uop_prs3
      (_fpu_io_resp_bits_fflags_bits_uop_prs3),
    .io_resp_bits_fflags_bits_uop_ppred
      (_fpu_io_resp_bits_fflags_bits_uop_ppred),
    .io_resp_bits_fflags_bits_uop_prs1_busy
      (_fpu_io_resp_bits_fflags_bits_uop_prs1_busy),
    .io_resp_bits_fflags_bits_uop_prs2_busy
      (_fpu_io_resp_bits_fflags_bits_uop_prs2_busy),
    .io_resp_bits_fflags_bits_uop_prs3_busy
      (_fpu_io_resp_bits_fflags_bits_uop_prs3_busy),
    .io_resp_bits_fflags_bits_uop_ppred_busy
      (_fpu_io_resp_bits_fflags_bits_uop_ppred_busy),
    .io_resp_bits_fflags_bits_uop_stale_pdst
      (_fpu_io_resp_bits_fflags_bits_uop_stale_pdst),
    .io_resp_bits_fflags_bits_uop_exception
      (_fpu_io_resp_bits_fflags_bits_uop_exception),
    .io_resp_bits_fflags_bits_uop_exc_cause
      (_fpu_io_resp_bits_fflags_bits_uop_exc_cause),
    .io_resp_bits_fflags_bits_uop_bypassable
      (_fpu_io_resp_bits_fflags_bits_uop_bypassable),
    .io_resp_bits_fflags_bits_uop_mem_cmd
      (_fpu_io_resp_bits_fflags_bits_uop_mem_cmd),
    .io_resp_bits_fflags_bits_uop_mem_size
      (_fpu_io_resp_bits_fflags_bits_uop_mem_size),
    .io_resp_bits_fflags_bits_uop_mem_signed
      (_fpu_io_resp_bits_fflags_bits_uop_mem_signed),
    .io_resp_bits_fflags_bits_uop_is_fence
      (_fpu_io_resp_bits_fflags_bits_uop_is_fence),
    .io_resp_bits_fflags_bits_uop_is_fencei
      (_fpu_io_resp_bits_fflags_bits_uop_is_fencei),
    .io_resp_bits_fflags_bits_uop_is_amo
      (_fpu_io_resp_bits_fflags_bits_uop_is_amo),
    .io_resp_bits_fflags_bits_uop_uses_ldq
      (_fpu_io_resp_bits_fflags_bits_uop_uses_ldq),
    .io_resp_bits_fflags_bits_uop_uses_stq
      (_fpu_io_resp_bits_fflags_bits_uop_uses_stq),
    .io_resp_bits_fflags_bits_uop_is_sys_pc2epc
      (_fpu_io_resp_bits_fflags_bits_uop_is_sys_pc2epc),
    .io_resp_bits_fflags_bits_uop_is_unique
      (_fpu_io_resp_bits_fflags_bits_uop_is_unique),
    .io_resp_bits_fflags_bits_uop_flush_on_commit
      (_fpu_io_resp_bits_fflags_bits_uop_flush_on_commit),
    .io_resp_bits_fflags_bits_uop_ldst_is_rs1
      (_fpu_io_resp_bits_fflags_bits_uop_ldst_is_rs1),
    .io_resp_bits_fflags_bits_uop_ldst
      (_fpu_io_resp_bits_fflags_bits_uop_ldst),
    .io_resp_bits_fflags_bits_uop_lrs1
      (_fpu_io_resp_bits_fflags_bits_uop_lrs1),
    .io_resp_bits_fflags_bits_uop_lrs2
      (_fpu_io_resp_bits_fflags_bits_uop_lrs2),
    .io_resp_bits_fflags_bits_uop_lrs3
      (_fpu_io_resp_bits_fflags_bits_uop_lrs3),
    .io_resp_bits_fflags_bits_uop_ldst_val
      (_fpu_io_resp_bits_fflags_bits_uop_ldst_val),
    .io_resp_bits_fflags_bits_uop_dst_rtype
      (_fpu_io_resp_bits_fflags_bits_uop_dst_rtype),
    .io_resp_bits_fflags_bits_uop_lrs1_rtype
      (_fpu_io_resp_bits_fflags_bits_uop_lrs1_rtype),
    .io_resp_bits_fflags_bits_uop_lrs2_rtype
      (_fpu_io_resp_bits_fflags_bits_uop_lrs2_rtype),
    .io_resp_bits_fflags_bits_uop_frs3_en
      (_fpu_io_resp_bits_fflags_bits_uop_frs3_en),
    .io_resp_bits_fflags_bits_uop_fp_val
      (_fpu_io_resp_bits_fflags_bits_uop_fp_val),
    .io_resp_bits_fflags_bits_uop_fp_single
      (_fpu_io_resp_bits_fflags_bits_uop_fp_single),
    .io_resp_bits_fflags_bits_uop_xcpt_pf_if
      (_fpu_io_resp_bits_fflags_bits_uop_xcpt_pf_if),
    .io_resp_bits_fflags_bits_uop_xcpt_ae_if
      (_fpu_io_resp_bits_fflags_bits_uop_xcpt_ae_if),
    .io_resp_bits_fflags_bits_uop_xcpt_ma_if
      (_fpu_io_resp_bits_fflags_bits_uop_xcpt_ma_if),
    .io_resp_bits_fflags_bits_uop_bp_debug_if
      (_fpu_io_resp_bits_fflags_bits_uop_bp_debug_if),
    .io_resp_bits_fflags_bits_uop_bp_xcpt_if
      (_fpu_io_resp_bits_fflags_bits_uop_bp_xcpt_if),
    .io_resp_bits_fflags_bits_uop_debug_fsrc
      (_fpu_io_resp_bits_fflags_bits_uop_debug_fsrc),
    .io_resp_bits_fflags_bits_uop_debug_tsrc
      (_fpu_io_resp_bits_fflags_bits_uop_debug_tsrc),
    .io_resp_bits_fflags_bits_flags               (_fpu_io_resp_bits_fflags_bits_flags)
  );
  FDivSqrtUnit_2 fdivsqrt (	// execution-unit.scala:493:22
    .clock                                (clock),
    .reset                                (reset),
    .io_req_valid                         (io_req_valid & io_req_bits_uop_fu_code[7]),	// execution-unit.scala:494:51, micro-op.scala:154:40
    .io_req_bits_uop_uopc                 (io_req_bits_uop_uopc),
    .io_req_bits_uop_br_mask              (io_req_bits_uop_br_mask),
    .io_req_bits_uop_rob_idx              (io_req_bits_uop_rob_idx),
    .io_req_bits_uop_pdst                 (io_req_bits_uop_pdst),
    .io_req_bits_uop_is_amo               (io_req_bits_uop_is_amo),
    .io_req_bits_uop_uses_ldq             (io_req_bits_uop_uses_ldq),
    .io_req_bits_uop_uses_stq             (io_req_bits_uop_uses_stq),
    .io_req_bits_uop_dst_rtype            (io_req_bits_uop_dst_rtype),
    .io_req_bits_uop_fp_val               (io_req_bits_uop_fp_val),
    .io_req_bits_rs1_data                 (io_req_bits_rs1_data),
    .io_req_bits_rs2_data                 (io_req_bits_rs2_data),
    .io_req_bits_kill                     (io_req_bits_kill),
    .io_resp_ready                        (~_fpu_io_resp_valid),	// execution-unit.scala:468:17, :505:31
    .io_brupdate_b1_resolve_mask          (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask       (io_brupdate_b1_mispredict_mask),
    .io_fcsr_rm                           (io_fcsr_rm),
    .io_req_ready                         (_fdivsqrt_io_req_ready),
    .io_resp_valid                        (_fdivsqrt_io_resp_valid),
    .io_resp_bits_uop_rob_idx             (_fdivsqrt_io_resp_bits_uop_rob_idx),
    .io_resp_bits_uop_pdst                (_fdivsqrt_io_resp_bits_uop_pdst),
    .io_resp_bits_uop_is_amo              (_fdivsqrt_io_resp_bits_uop_is_amo),
    .io_resp_bits_uop_uses_ldq            (_fdivsqrt_io_resp_bits_uop_uses_ldq),
    .io_resp_bits_uop_uses_stq            (_fdivsqrt_io_resp_bits_uop_uses_stq),
    .io_resp_bits_uop_dst_rtype           (_fdivsqrt_io_resp_bits_uop_dst_rtype),
    .io_resp_bits_uop_fp_val              (_fdivsqrt_io_resp_bits_uop_fp_val),
    .io_resp_bits_data                    (_fdivsqrt_io_resp_bits_data),
    .io_resp_bits_fflags_valid            (_fdivsqrt_io_resp_bits_fflags_valid),
    .io_resp_bits_fflags_bits_uop_rob_idx
      (_fdivsqrt_io_resp_bits_fflags_bits_uop_rob_idx),
    .io_resp_bits_fflags_bits_flags       (_fdivsqrt_io_resp_bits_fflags_bits_flags)
  );
  BranchKillableQueue_24 queue (	// execution-unit.scala:528:23
    .clock                                       (clock),
    .reset                                       (reset),
    .io_enq_valid
      (_fpu_io_resp_valid & _fpu_io_resp_bits_uop_fu_code[9]
       & _fpu_io_resp_bits_uop_uopc != 7'h2),	// execution-unit.scala:468:17, :531:74, :532:60, micro-op.scala:154:40
    .io_enq_bits_uop_uopc                        (_fpu_io_resp_bits_uop_uopc),	// execution-unit.scala:468:17
    .io_enq_bits_uop_inst                        (_fpu_io_resp_bits_uop_inst),	// execution-unit.scala:468:17
    .io_enq_bits_uop_debug_inst                  (_fpu_io_resp_bits_uop_debug_inst),	// execution-unit.scala:468:17
    .io_enq_bits_uop_is_rvc                      (_fpu_io_resp_bits_uop_is_rvc),	// execution-unit.scala:468:17
    .io_enq_bits_uop_debug_pc                    (_fpu_io_resp_bits_uop_debug_pc),	// execution-unit.scala:468:17
    .io_enq_bits_uop_iq_type                     (_fpu_io_resp_bits_uop_iq_type),	// execution-unit.scala:468:17
    .io_enq_bits_uop_fu_code                     (_fpu_io_resp_bits_uop_fu_code),	// execution-unit.scala:468:17
    .io_enq_bits_uop_ctrl_br_type                (_fpu_io_resp_bits_uop_ctrl_br_type),	// execution-unit.scala:468:17
    .io_enq_bits_uop_ctrl_op1_sel                (_fpu_io_resp_bits_uop_ctrl_op1_sel),	// execution-unit.scala:468:17
    .io_enq_bits_uop_ctrl_op2_sel                (_fpu_io_resp_bits_uop_ctrl_op2_sel),	// execution-unit.scala:468:17
    .io_enq_bits_uop_ctrl_imm_sel                (_fpu_io_resp_bits_uop_ctrl_imm_sel),	// execution-unit.scala:468:17
    .io_enq_bits_uop_ctrl_op_fcn                 (_fpu_io_resp_bits_uop_ctrl_op_fcn),	// execution-unit.scala:468:17
    .io_enq_bits_uop_ctrl_fcn_dw                 (_fpu_io_resp_bits_uop_ctrl_fcn_dw),	// execution-unit.scala:468:17
    .io_enq_bits_uop_ctrl_csr_cmd                (_fpu_io_resp_bits_uop_ctrl_csr_cmd),	// execution-unit.scala:468:17
    .io_enq_bits_uop_ctrl_is_load                (_fpu_io_resp_bits_uop_ctrl_is_load),	// execution-unit.scala:468:17
    .io_enq_bits_uop_ctrl_is_sta                 (_fpu_io_resp_bits_uop_ctrl_is_sta),	// execution-unit.scala:468:17
    .io_enq_bits_uop_ctrl_is_std                 (_fpu_io_resp_bits_uop_ctrl_is_std),	// execution-unit.scala:468:17
    .io_enq_bits_uop_iw_state                    (_fpu_io_resp_bits_uop_iw_state),	// execution-unit.scala:468:17
    .io_enq_bits_uop_iw_p1_poisoned              (_fpu_io_resp_bits_uop_iw_p1_poisoned),	// execution-unit.scala:468:17
    .io_enq_bits_uop_iw_p2_poisoned              (_fpu_io_resp_bits_uop_iw_p2_poisoned),	// execution-unit.scala:468:17
    .io_enq_bits_uop_is_br                       (_fpu_io_resp_bits_uop_is_br),	// execution-unit.scala:468:17
    .io_enq_bits_uop_is_jalr                     (_fpu_io_resp_bits_uop_is_jalr),	// execution-unit.scala:468:17
    .io_enq_bits_uop_is_jal                      (_fpu_io_resp_bits_uop_is_jal),	// execution-unit.scala:468:17
    .io_enq_bits_uop_is_sfb                      (_fpu_io_resp_bits_uop_is_sfb),	// execution-unit.scala:468:17
    .io_enq_bits_uop_br_mask                     (_fpu_io_resp_bits_uop_br_mask),	// execution-unit.scala:468:17
    .io_enq_bits_uop_br_tag                      (_fpu_io_resp_bits_uop_br_tag),	// execution-unit.scala:468:17
    .io_enq_bits_uop_ftq_idx                     (_fpu_io_resp_bits_uop_ftq_idx),	// execution-unit.scala:468:17
    .io_enq_bits_uop_edge_inst                   (_fpu_io_resp_bits_uop_edge_inst),	// execution-unit.scala:468:17
    .io_enq_bits_uop_pc_lob                      (_fpu_io_resp_bits_uop_pc_lob),	// execution-unit.scala:468:17
    .io_enq_bits_uop_taken                       (_fpu_io_resp_bits_uop_taken),	// execution-unit.scala:468:17
    .io_enq_bits_uop_imm_packed                  (_fpu_io_resp_bits_uop_imm_packed),	// execution-unit.scala:468:17
    .io_enq_bits_uop_csr_addr                    (_fpu_io_resp_bits_uop_csr_addr),	// execution-unit.scala:468:17
    .io_enq_bits_uop_rob_idx                     (_fpu_io_resp_bits_uop_rob_idx),	// execution-unit.scala:468:17
    .io_enq_bits_uop_ldq_idx                     (_fpu_io_resp_bits_uop_ldq_idx),	// execution-unit.scala:468:17
    .io_enq_bits_uop_stq_idx                     (_fpu_io_resp_bits_uop_stq_idx),	// execution-unit.scala:468:17
    .io_enq_bits_uop_rxq_idx                     (_fpu_io_resp_bits_uop_rxq_idx),	// execution-unit.scala:468:17
    .io_enq_bits_uop_pdst                        (_fpu_io_resp_bits_uop_pdst),	// execution-unit.scala:468:17
    .io_enq_bits_uop_prs1                        (_fpu_io_resp_bits_uop_prs1),	// execution-unit.scala:468:17
    .io_enq_bits_uop_prs2                        (_fpu_io_resp_bits_uop_prs2),	// execution-unit.scala:468:17
    .io_enq_bits_uop_prs3                        (_fpu_io_resp_bits_uop_prs3),	// execution-unit.scala:468:17
    .io_enq_bits_uop_ppred                       (_fpu_io_resp_bits_uop_ppred),	// execution-unit.scala:468:17
    .io_enq_bits_uop_prs1_busy                   (_fpu_io_resp_bits_uop_prs1_busy),	// execution-unit.scala:468:17
    .io_enq_bits_uop_prs2_busy                   (_fpu_io_resp_bits_uop_prs2_busy),	// execution-unit.scala:468:17
    .io_enq_bits_uop_prs3_busy                   (_fpu_io_resp_bits_uop_prs3_busy),	// execution-unit.scala:468:17
    .io_enq_bits_uop_ppred_busy                  (_fpu_io_resp_bits_uop_ppred_busy),	// execution-unit.scala:468:17
    .io_enq_bits_uop_stale_pdst                  (_fpu_io_resp_bits_uop_stale_pdst),	// execution-unit.scala:468:17
    .io_enq_bits_uop_exception                   (_fpu_io_resp_bits_uop_exception),	// execution-unit.scala:468:17
    .io_enq_bits_uop_exc_cause                   (_fpu_io_resp_bits_uop_exc_cause),	// execution-unit.scala:468:17
    .io_enq_bits_uop_bypassable                  (_fpu_io_resp_bits_uop_bypassable),	// execution-unit.scala:468:17
    .io_enq_bits_uop_mem_cmd                     (_fpu_io_resp_bits_uop_mem_cmd),	// execution-unit.scala:468:17
    .io_enq_bits_uop_mem_size                    (_fpu_io_resp_bits_uop_mem_size),	// execution-unit.scala:468:17
    .io_enq_bits_uop_mem_signed                  (_fpu_io_resp_bits_uop_mem_signed),	// execution-unit.scala:468:17
    .io_enq_bits_uop_is_fence                    (_fpu_io_resp_bits_uop_is_fence),	// execution-unit.scala:468:17
    .io_enq_bits_uop_is_fencei                   (_fpu_io_resp_bits_uop_is_fencei),	// execution-unit.scala:468:17
    .io_enq_bits_uop_is_amo                      (_fpu_io_resp_bits_uop_is_amo),	// execution-unit.scala:468:17
    .io_enq_bits_uop_uses_ldq                    (_fpu_io_resp_bits_uop_uses_ldq),	// execution-unit.scala:468:17
    .io_enq_bits_uop_uses_stq                    (_fpu_io_resp_bits_uop_uses_stq),	// execution-unit.scala:468:17
    .io_enq_bits_uop_is_sys_pc2epc               (_fpu_io_resp_bits_uop_is_sys_pc2epc),	// execution-unit.scala:468:17
    .io_enq_bits_uop_is_unique                   (_fpu_io_resp_bits_uop_is_unique),	// execution-unit.scala:468:17
    .io_enq_bits_uop_flush_on_commit             (_fpu_io_resp_bits_uop_flush_on_commit),	// execution-unit.scala:468:17
    .io_enq_bits_uop_ldst_is_rs1                 (_fpu_io_resp_bits_uop_ldst_is_rs1),	// execution-unit.scala:468:17
    .io_enq_bits_uop_ldst                        (_fpu_io_resp_bits_uop_ldst),	// execution-unit.scala:468:17
    .io_enq_bits_uop_lrs1                        (_fpu_io_resp_bits_uop_lrs1),	// execution-unit.scala:468:17
    .io_enq_bits_uop_lrs2                        (_fpu_io_resp_bits_uop_lrs2),	// execution-unit.scala:468:17
    .io_enq_bits_uop_lrs3                        (_fpu_io_resp_bits_uop_lrs3),	// execution-unit.scala:468:17
    .io_enq_bits_uop_ldst_val                    (_fpu_io_resp_bits_uop_ldst_val),	// execution-unit.scala:468:17
    .io_enq_bits_uop_dst_rtype                   (_fpu_io_resp_bits_uop_dst_rtype),	// execution-unit.scala:468:17
    .io_enq_bits_uop_lrs1_rtype                  (_fpu_io_resp_bits_uop_lrs1_rtype),	// execution-unit.scala:468:17
    .io_enq_bits_uop_lrs2_rtype                  (_fpu_io_resp_bits_uop_lrs2_rtype),	// execution-unit.scala:468:17
    .io_enq_bits_uop_frs3_en                     (_fpu_io_resp_bits_uop_frs3_en),	// execution-unit.scala:468:17
    .io_enq_bits_uop_fp_val                      (_fpu_io_resp_bits_uop_fp_val),	// execution-unit.scala:468:17
    .io_enq_bits_uop_fp_single                   (_fpu_io_resp_bits_uop_fp_single),	// execution-unit.scala:468:17
    .io_enq_bits_uop_xcpt_pf_if                  (_fpu_io_resp_bits_uop_xcpt_pf_if),	// execution-unit.scala:468:17
    .io_enq_bits_uop_xcpt_ae_if                  (_fpu_io_resp_bits_uop_xcpt_ae_if),	// execution-unit.scala:468:17
    .io_enq_bits_uop_xcpt_ma_if                  (_fpu_io_resp_bits_uop_xcpt_ma_if),	// execution-unit.scala:468:17
    .io_enq_bits_uop_bp_debug_if                 (_fpu_io_resp_bits_uop_bp_debug_if),	// execution-unit.scala:468:17
    .io_enq_bits_uop_bp_xcpt_if                  (_fpu_io_resp_bits_uop_bp_xcpt_if),	// execution-unit.scala:468:17
    .io_enq_bits_uop_debug_fsrc                  (_fpu_io_resp_bits_uop_debug_fsrc),	// execution-unit.scala:468:17
    .io_enq_bits_uop_debug_tsrc                  (_fpu_io_resp_bits_uop_debug_tsrc),	// execution-unit.scala:468:17
    .io_enq_bits_data                            (_fpu_io_resp_bits_data),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_valid                    (_fpu_io_resp_bits_fflags_valid),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_uopc            (_fpu_io_resp_bits_fflags_bits_uop_uopc),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_inst            (_fpu_io_resp_bits_fflags_bits_uop_inst),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_debug_inst
      (_fpu_io_resp_bits_fflags_bits_uop_debug_inst),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_is_rvc
      (_fpu_io_resp_bits_fflags_bits_uop_is_rvc),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_debug_pc
      (_fpu_io_resp_bits_fflags_bits_uop_debug_pc),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_iq_type
      (_fpu_io_resp_bits_fflags_bits_uop_iq_type),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_fu_code
      (_fpu_io_resp_bits_fflags_bits_uop_fu_code),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_ctrl_br_type
      (_fpu_io_resp_bits_fflags_bits_uop_ctrl_br_type),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_ctrl_op1_sel
      (_fpu_io_resp_bits_fflags_bits_uop_ctrl_op1_sel),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_ctrl_op2_sel
      (_fpu_io_resp_bits_fflags_bits_uop_ctrl_op2_sel),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_ctrl_imm_sel
      (_fpu_io_resp_bits_fflags_bits_uop_ctrl_imm_sel),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_ctrl_op_fcn
      (_fpu_io_resp_bits_fflags_bits_uop_ctrl_op_fcn),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_ctrl_fcn_dw
      (_fpu_io_resp_bits_fflags_bits_uop_ctrl_fcn_dw),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_ctrl_csr_cmd
      (_fpu_io_resp_bits_fflags_bits_uop_ctrl_csr_cmd),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_ctrl_is_load
      (_fpu_io_resp_bits_fflags_bits_uop_ctrl_is_load),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_ctrl_is_sta
      (_fpu_io_resp_bits_fflags_bits_uop_ctrl_is_sta),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_ctrl_is_std
      (_fpu_io_resp_bits_fflags_bits_uop_ctrl_is_std),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_iw_state
      (_fpu_io_resp_bits_fflags_bits_uop_iw_state),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_iw_p1_poisoned
      (_fpu_io_resp_bits_fflags_bits_uop_iw_p1_poisoned),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_iw_p2_poisoned
      (_fpu_io_resp_bits_fflags_bits_uop_iw_p2_poisoned),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_is_br
      (_fpu_io_resp_bits_fflags_bits_uop_is_br),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_is_jalr
      (_fpu_io_resp_bits_fflags_bits_uop_is_jalr),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_is_jal
      (_fpu_io_resp_bits_fflags_bits_uop_is_jal),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_is_sfb
      (_fpu_io_resp_bits_fflags_bits_uop_is_sfb),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_br_mask
      (_fpu_io_resp_bits_fflags_bits_uop_br_mask),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_br_tag
      (_fpu_io_resp_bits_fflags_bits_uop_br_tag),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_ftq_idx
      (_fpu_io_resp_bits_fflags_bits_uop_ftq_idx),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_edge_inst
      (_fpu_io_resp_bits_fflags_bits_uop_edge_inst),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_pc_lob
      (_fpu_io_resp_bits_fflags_bits_uop_pc_lob),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_taken
      (_fpu_io_resp_bits_fflags_bits_uop_taken),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_imm_packed
      (_fpu_io_resp_bits_fflags_bits_uop_imm_packed),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_csr_addr
      (_fpu_io_resp_bits_fflags_bits_uop_csr_addr),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_rob_idx
      (_fpu_io_resp_bits_fflags_bits_uop_rob_idx),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_ldq_idx
      (_fpu_io_resp_bits_fflags_bits_uop_ldq_idx),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_stq_idx
      (_fpu_io_resp_bits_fflags_bits_uop_stq_idx),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_rxq_idx
      (_fpu_io_resp_bits_fflags_bits_uop_rxq_idx),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_pdst            (_fpu_io_resp_bits_fflags_bits_uop_pdst),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_prs1            (_fpu_io_resp_bits_fflags_bits_uop_prs1),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_prs2            (_fpu_io_resp_bits_fflags_bits_uop_prs2),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_prs3            (_fpu_io_resp_bits_fflags_bits_uop_prs3),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_ppred
      (_fpu_io_resp_bits_fflags_bits_uop_ppred),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_prs1_busy
      (_fpu_io_resp_bits_fflags_bits_uop_prs1_busy),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_prs2_busy
      (_fpu_io_resp_bits_fflags_bits_uop_prs2_busy),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_prs3_busy
      (_fpu_io_resp_bits_fflags_bits_uop_prs3_busy),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_ppred_busy
      (_fpu_io_resp_bits_fflags_bits_uop_ppred_busy),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_stale_pdst
      (_fpu_io_resp_bits_fflags_bits_uop_stale_pdst),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_exception
      (_fpu_io_resp_bits_fflags_bits_uop_exception),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_exc_cause
      (_fpu_io_resp_bits_fflags_bits_uop_exc_cause),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_bypassable
      (_fpu_io_resp_bits_fflags_bits_uop_bypassable),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_mem_cmd
      (_fpu_io_resp_bits_fflags_bits_uop_mem_cmd),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_mem_size
      (_fpu_io_resp_bits_fflags_bits_uop_mem_size),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_mem_signed
      (_fpu_io_resp_bits_fflags_bits_uop_mem_signed),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_is_fence
      (_fpu_io_resp_bits_fflags_bits_uop_is_fence),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_is_fencei
      (_fpu_io_resp_bits_fflags_bits_uop_is_fencei),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_is_amo
      (_fpu_io_resp_bits_fflags_bits_uop_is_amo),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_uses_ldq
      (_fpu_io_resp_bits_fflags_bits_uop_uses_ldq),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_uses_stq
      (_fpu_io_resp_bits_fflags_bits_uop_uses_stq),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_is_sys_pc2epc
      (_fpu_io_resp_bits_fflags_bits_uop_is_sys_pc2epc),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_is_unique
      (_fpu_io_resp_bits_fflags_bits_uop_is_unique),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_flush_on_commit
      (_fpu_io_resp_bits_fflags_bits_uop_flush_on_commit),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_ldst_is_rs1
      (_fpu_io_resp_bits_fflags_bits_uop_ldst_is_rs1),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_ldst            (_fpu_io_resp_bits_fflags_bits_uop_ldst),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_lrs1            (_fpu_io_resp_bits_fflags_bits_uop_lrs1),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_lrs2            (_fpu_io_resp_bits_fflags_bits_uop_lrs2),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_lrs3            (_fpu_io_resp_bits_fflags_bits_uop_lrs3),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_ldst_val
      (_fpu_io_resp_bits_fflags_bits_uop_ldst_val),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_dst_rtype
      (_fpu_io_resp_bits_fflags_bits_uop_dst_rtype),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_lrs1_rtype
      (_fpu_io_resp_bits_fflags_bits_uop_lrs1_rtype),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_lrs2_rtype
      (_fpu_io_resp_bits_fflags_bits_uop_lrs2_rtype),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_frs3_en
      (_fpu_io_resp_bits_fflags_bits_uop_frs3_en),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_fp_val
      (_fpu_io_resp_bits_fflags_bits_uop_fp_val),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_fp_single
      (_fpu_io_resp_bits_fflags_bits_uop_fp_single),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_xcpt_pf_if
      (_fpu_io_resp_bits_fflags_bits_uop_xcpt_pf_if),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_xcpt_ae_if
      (_fpu_io_resp_bits_fflags_bits_uop_xcpt_ae_if),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_xcpt_ma_if
      (_fpu_io_resp_bits_fflags_bits_uop_xcpt_ma_if),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_bp_debug_if
      (_fpu_io_resp_bits_fflags_bits_uop_bp_debug_if),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_bp_xcpt_if
      (_fpu_io_resp_bits_fflags_bits_uop_bp_xcpt_if),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_debug_fsrc
      (_fpu_io_resp_bits_fflags_bits_uop_debug_fsrc),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_uop_debug_tsrc
      (_fpu_io_resp_bits_fflags_bits_uop_debug_tsrc),	// execution-unit.scala:468:17
    .io_enq_bits_fflags_bits_flags               (_fpu_io_resp_bits_fflags_bits_flags),	// execution-unit.scala:468:17
    .io_deq_ready                                (_resp_arb_io_in_0_ready),	// execution-unit.scala:554:26
    .io_brupdate_b1_resolve_mask                 (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask              (io_brupdate_b1_mispredict_mask),
    .io_flush                                    (io_req_bits_kill),
    .io_enq_ready                                (_queue_io_enq_ready),
    .io_deq_valid                                (_queue_io_deq_valid),
    .io_deq_bits_uop_uopc                        (_queue_io_deq_bits_uop_uopc),
    .io_deq_bits_uop_br_mask                     (_queue_io_deq_bits_uop_br_mask),
    .io_deq_bits_uop_rob_idx                     (_queue_io_deq_bits_uop_rob_idx),
    .io_deq_bits_uop_stq_idx                     (_queue_io_deq_bits_uop_stq_idx),
    .io_deq_bits_uop_pdst                        (_queue_io_deq_bits_uop_pdst),
    .io_deq_bits_uop_is_amo                      (_queue_io_deq_bits_uop_is_amo),
    .io_deq_bits_uop_uses_stq                    (_queue_io_deq_bits_uop_uses_stq),
    .io_deq_bits_uop_dst_rtype                   (_queue_io_deq_bits_uop_dst_rtype),
    .io_deq_bits_uop_fp_val                      (_queue_io_deq_bits_uop_fp_val),
    .io_deq_bits_data                            (_queue_io_deq_bits_data),
    .io_deq_bits_predicated                      (_queue_io_deq_bits_predicated),
    .io_deq_bits_fflags_valid                    (_queue_io_deq_bits_fflags_valid),
    .io_deq_bits_fflags_bits_uop_rob_idx
      (_queue_io_deq_bits_fflags_bits_uop_rob_idx),
    .io_deq_bits_fflags_bits_flags               (_queue_io_deq_bits_fflags_bits_flags),
    .io_empty                                    (_queue_io_empty)
  );
  BranchKillableQueue_25 fp_sdq (	// execution-unit.scala:542:24
    .clock                               (clock),
    .reset                               (reset),
    .io_enq_valid                        (_fp_sdq_io_enq_valid_T_5),	// execution-unit.scala:544:81
    .io_enq_bits_uop_uopc                (io_req_bits_uop_uopc),
    .io_enq_bits_uop_inst                (io_req_bits_uop_inst),
    .io_enq_bits_uop_debug_inst          (io_req_bits_uop_debug_inst),
    .io_enq_bits_uop_is_rvc              (io_req_bits_uop_is_rvc),
    .io_enq_bits_uop_debug_pc            (io_req_bits_uop_debug_pc),
    .io_enq_bits_uop_iq_type             (io_req_bits_uop_iq_type),
    .io_enq_bits_uop_fu_code             (io_req_bits_uop_fu_code),
    .io_enq_bits_uop_ctrl_br_type        (io_req_bits_uop_ctrl_br_type),
    .io_enq_bits_uop_ctrl_op1_sel        (io_req_bits_uop_ctrl_op1_sel),
    .io_enq_bits_uop_ctrl_op2_sel        (io_req_bits_uop_ctrl_op2_sel),
    .io_enq_bits_uop_ctrl_imm_sel        (io_req_bits_uop_ctrl_imm_sel),
    .io_enq_bits_uop_ctrl_op_fcn         (io_req_bits_uop_ctrl_op_fcn),
    .io_enq_bits_uop_ctrl_fcn_dw         (io_req_bits_uop_ctrl_fcn_dw),
    .io_enq_bits_uop_ctrl_csr_cmd        (io_req_bits_uop_ctrl_csr_cmd),
    .io_enq_bits_uop_ctrl_is_load        (io_req_bits_uop_ctrl_is_load),
    .io_enq_bits_uop_ctrl_is_sta         (io_req_bits_uop_ctrl_is_sta),
    .io_enq_bits_uop_ctrl_is_std         (io_req_bits_uop_ctrl_is_std),
    .io_enq_bits_uop_iw_state            (io_req_bits_uop_iw_state),
    .io_enq_bits_uop_iw_p1_poisoned      (io_req_bits_uop_iw_p1_poisoned),
    .io_enq_bits_uop_iw_p2_poisoned      (io_req_bits_uop_iw_p2_poisoned),
    .io_enq_bits_uop_is_br               (io_req_bits_uop_is_br),
    .io_enq_bits_uop_is_jalr             (io_req_bits_uop_is_jalr),
    .io_enq_bits_uop_is_jal              (io_req_bits_uop_is_jal),
    .io_enq_bits_uop_is_sfb              (io_req_bits_uop_is_sfb),
    .io_enq_bits_uop_br_mask             (io_req_bits_uop_br_mask),
    .io_enq_bits_uop_br_tag              (io_req_bits_uop_br_tag),
    .io_enq_bits_uop_ftq_idx             (io_req_bits_uop_ftq_idx),
    .io_enq_bits_uop_edge_inst           (io_req_bits_uop_edge_inst),
    .io_enq_bits_uop_pc_lob              (io_req_bits_uop_pc_lob),
    .io_enq_bits_uop_taken               (io_req_bits_uop_taken),
    .io_enq_bits_uop_imm_packed          (io_req_bits_uop_imm_packed),
    .io_enq_bits_uop_csr_addr            (io_req_bits_uop_csr_addr),
    .io_enq_bits_uop_rob_idx             (io_req_bits_uop_rob_idx),
    .io_enq_bits_uop_ldq_idx             (io_req_bits_uop_ldq_idx),
    .io_enq_bits_uop_stq_idx             (io_req_bits_uop_stq_idx),
    .io_enq_bits_uop_rxq_idx             (io_req_bits_uop_rxq_idx),
    .io_enq_bits_uop_pdst                (io_req_bits_uop_pdst),
    .io_enq_bits_uop_prs1                (io_req_bits_uop_prs1),
    .io_enq_bits_uop_prs2                (io_req_bits_uop_prs2),
    .io_enq_bits_uop_prs3                (io_req_bits_uop_prs3),
    .io_enq_bits_uop_ppred               (io_req_bits_uop_ppred),
    .io_enq_bits_uop_prs1_busy           (io_req_bits_uop_prs1_busy),
    .io_enq_bits_uop_prs2_busy           (io_req_bits_uop_prs2_busy),
    .io_enq_bits_uop_prs3_busy           (io_req_bits_uop_prs3_busy),
    .io_enq_bits_uop_ppred_busy          (io_req_bits_uop_ppred_busy),
    .io_enq_bits_uop_stale_pdst          (io_req_bits_uop_stale_pdst),
    .io_enq_bits_uop_exception           (io_req_bits_uop_exception),
    .io_enq_bits_uop_exc_cause           (io_req_bits_uop_exc_cause),
    .io_enq_bits_uop_bypassable          (io_req_bits_uop_bypassable),
    .io_enq_bits_uop_mem_cmd             (io_req_bits_uop_mem_cmd),
    .io_enq_bits_uop_mem_size            (io_req_bits_uop_mem_size),
    .io_enq_bits_uop_mem_signed          (io_req_bits_uop_mem_signed),
    .io_enq_bits_uop_is_fence            (io_req_bits_uop_is_fence),
    .io_enq_bits_uop_is_fencei           (io_req_bits_uop_is_fencei),
    .io_enq_bits_uop_is_amo              (io_req_bits_uop_is_amo),
    .io_enq_bits_uop_uses_ldq            (io_req_bits_uop_uses_ldq),
    .io_enq_bits_uop_uses_stq            (io_req_bits_uop_uses_stq),
    .io_enq_bits_uop_is_sys_pc2epc       (io_req_bits_uop_is_sys_pc2epc),
    .io_enq_bits_uop_is_unique           (io_req_bits_uop_is_unique),
    .io_enq_bits_uop_flush_on_commit     (io_req_bits_uop_flush_on_commit),
    .io_enq_bits_uop_ldst_is_rs1         (io_req_bits_uop_ldst_is_rs1),
    .io_enq_bits_uop_ldst                (io_req_bits_uop_ldst),
    .io_enq_bits_uop_lrs1                (io_req_bits_uop_lrs1),
    .io_enq_bits_uop_lrs2                (io_req_bits_uop_lrs2),
    .io_enq_bits_uop_lrs3                (io_req_bits_uop_lrs3),
    .io_enq_bits_uop_ldst_val            (io_req_bits_uop_ldst_val),
    .io_enq_bits_uop_dst_rtype           (io_req_bits_uop_dst_rtype),
    .io_enq_bits_uop_lrs1_rtype          (io_req_bits_uop_lrs1_rtype),
    .io_enq_bits_uop_lrs2_rtype          (io_req_bits_uop_lrs2_rtype),
    .io_enq_bits_uop_frs3_en             (io_req_bits_uop_frs3_en),
    .io_enq_bits_uop_fp_val              (io_req_bits_uop_fp_val),
    .io_enq_bits_uop_fp_single           (io_req_bits_uop_fp_single),
    .io_enq_bits_uop_xcpt_pf_if          (io_req_bits_uop_xcpt_pf_if),
    .io_enq_bits_uop_xcpt_ae_if          (io_req_bits_uop_xcpt_ae_if),
    .io_enq_bits_uop_xcpt_ma_if          (io_req_bits_uop_xcpt_ma_if),
    .io_enq_bits_uop_bp_debug_if         (io_req_bits_uop_bp_debug_if),
    .io_enq_bits_uop_bp_xcpt_if          (io_req_bits_uop_bp_xcpt_if),
    .io_enq_bits_uop_debug_fsrc          (io_req_bits_uop_debug_fsrc),
    .io_enq_bits_uop_debug_tsrc          (io_req_bits_uop_debug_tsrc),
    .io_enq_bits_data
      ({1'h0,
        io_req_bits_rs2_data[64],
        (fp_sdq_io_enq_bits_data_unrecoded_isSubnormal
           ? 11'h0
           : io_req_bits_rs2_data[62:52] + 11'h3FF)
          | {11{(&(io_req_bits_rs2_data[63:62])) & io_req_bits_rs2_data[61]
                  | fp_sdq_io_enq_bits_data_unrecoded_rawIn_isInf}},
        fp_sdq_io_enq_bits_data_unrecoded_lo[51:32],
        (&(io_req_bits_rs2_data[63:61]))
          ? {io_req_bits_rs2_data[31],
             (fp_sdq_io_enq_bits_data_prevUnrecoded_isSubnormal
                ? 8'h0
                : io_req_bits_rs2_data[30:23] + 8'h7F)
               | {8{(&_fp_sdq_io_enq_bits_data_prevUnrecoded_rawIn_isSpecial_T)
                      & io_req_bits_rs2_data[29]
                      | fp_sdq_io_enq_bits_data_prevUnrecoded_rawIn_isInf}},
             fp_sdq_io_enq_bits_data_prevUnrecoded_isSubnormal
               ? _fp_sdq_io_enq_bits_data_prevUnrecoded_denormFract_T_1[22:0]
               : fp_sdq_io_enq_bits_data_prevUnrecoded_rawIn_isInf
                   ? 23'h0
                   : io_req_bits_rs2_data[22:0]}
          : fp_sdq_io_enq_bits_data_unrecoded_lo[31:0]}),	// Bitwise.scala:72:12, Cat.scala:30:58, FPU.scala:243:{25,56}, :437:10, :441:{21,44,81}, execution-unit.scala:546:30, fNFromRecFN.scala:50:39, :52:{42,60}, :55:16, :57:{27,45}, :59:{15,44}, :61:16, :63:20, rawFloatFromRecFN.scala:50:21, :52:{29,54}, :55:{33,41}, :56:33, :58:25, :60:51
    .io_deq_ready                        (_resp_arb_io_in_1_ready),	// execution-unit.scala:554:26
    .io_brupdate_b1_resolve_mask         (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask      (io_brupdate_b1_mispredict_mask),
    .io_flush                            (io_req_bits_kill),
    .io_enq_ready                        (_fp_sdq_io_enq_ready),
    .io_deq_valid                        (_fp_sdq_io_deq_valid),
    .io_deq_bits_uop_uopc                (_fp_sdq_io_deq_bits_uop_uopc),
    .io_deq_bits_uop_br_mask             (_fp_sdq_io_deq_bits_uop_br_mask),
    .io_deq_bits_uop_rob_idx             (_fp_sdq_io_deq_bits_uop_rob_idx),
    .io_deq_bits_uop_stq_idx             (_fp_sdq_io_deq_bits_uop_stq_idx),
    .io_deq_bits_uop_pdst                (_fp_sdq_io_deq_bits_uop_pdst),
    .io_deq_bits_uop_is_amo              (_fp_sdq_io_deq_bits_uop_is_amo),
    .io_deq_bits_uop_uses_stq            (_fp_sdq_io_deq_bits_uop_uses_stq),
    .io_deq_bits_uop_dst_rtype           (_fp_sdq_io_deq_bits_uop_dst_rtype),
    .io_deq_bits_uop_fp_val              (_fp_sdq_io_deq_bits_uop_fp_val),
    .io_deq_bits_data                    (_fp_sdq_io_deq_bits_data),
    .io_deq_bits_predicated              (_fp_sdq_io_deq_bits_predicated),
    .io_deq_bits_fflags_valid            (_fp_sdq_io_deq_bits_fflags_valid),
    .io_deq_bits_fflags_bits_uop_rob_idx (_fp_sdq_io_deq_bits_fflags_bits_uop_rob_idx),
    .io_deq_bits_fflags_bits_flags       (_fp_sdq_io_deq_bits_fflags_bits_flags),
    .io_empty                            (_fp_sdq_io_empty)
  );
  Arbiter_61 resp_arb (	// execution-unit.scala:554:26
    .io_in_0_valid                        (_queue_io_deq_valid),	// execution-unit.scala:528:23
    .io_in_0_bits_uop_uopc                (_queue_io_deq_bits_uop_uopc),	// execution-unit.scala:528:23
    .io_in_0_bits_uop_br_mask             (_queue_io_deq_bits_uop_br_mask),	// execution-unit.scala:528:23
    .io_in_0_bits_uop_rob_idx             (_queue_io_deq_bits_uop_rob_idx),	// execution-unit.scala:528:23
    .io_in_0_bits_uop_stq_idx             (_queue_io_deq_bits_uop_stq_idx),	// execution-unit.scala:528:23
    .io_in_0_bits_uop_pdst                (_queue_io_deq_bits_uop_pdst),	// execution-unit.scala:528:23
    .io_in_0_bits_uop_is_amo              (_queue_io_deq_bits_uop_is_amo),	// execution-unit.scala:528:23
    .io_in_0_bits_uop_uses_stq            (_queue_io_deq_bits_uop_uses_stq),	// execution-unit.scala:528:23
    .io_in_0_bits_uop_dst_rtype           (_queue_io_deq_bits_uop_dst_rtype),	// execution-unit.scala:528:23
    .io_in_0_bits_uop_fp_val              (_queue_io_deq_bits_uop_fp_val),	// execution-unit.scala:528:23
    .io_in_0_bits_data                    (_queue_io_deq_bits_data),	// execution-unit.scala:528:23
    .io_in_0_bits_predicated              (_queue_io_deq_bits_predicated),	// execution-unit.scala:528:23
    .io_in_0_bits_fflags_valid            (_queue_io_deq_bits_fflags_valid),	// execution-unit.scala:528:23
    .io_in_0_bits_fflags_bits_uop_rob_idx (_queue_io_deq_bits_fflags_bits_uop_rob_idx),	// execution-unit.scala:528:23
    .io_in_0_bits_fflags_bits_flags       (_queue_io_deq_bits_fflags_bits_flags),	// execution-unit.scala:528:23
    .io_in_1_valid                        (_fp_sdq_io_deq_valid),	// execution-unit.scala:542:24
    .io_in_1_bits_uop_uopc                (_fp_sdq_io_deq_bits_uop_uopc),	// execution-unit.scala:542:24
    .io_in_1_bits_uop_br_mask             (_fp_sdq_io_deq_bits_uop_br_mask),	// execution-unit.scala:542:24
    .io_in_1_bits_uop_rob_idx             (_fp_sdq_io_deq_bits_uop_rob_idx),	// execution-unit.scala:542:24
    .io_in_1_bits_uop_stq_idx             (_fp_sdq_io_deq_bits_uop_stq_idx),	// execution-unit.scala:542:24
    .io_in_1_bits_uop_pdst                (_fp_sdq_io_deq_bits_uop_pdst),	// execution-unit.scala:542:24
    .io_in_1_bits_uop_is_amo              (_fp_sdq_io_deq_bits_uop_is_amo),	// execution-unit.scala:542:24
    .io_in_1_bits_uop_uses_stq            (_fp_sdq_io_deq_bits_uop_uses_stq),	// execution-unit.scala:542:24
    .io_in_1_bits_uop_dst_rtype           (_fp_sdq_io_deq_bits_uop_dst_rtype),	// execution-unit.scala:542:24
    .io_in_1_bits_uop_fp_val              (_fp_sdq_io_deq_bits_uop_fp_val),	// execution-unit.scala:542:24
    .io_in_1_bits_data                    (_fp_sdq_io_deq_bits_data),	// execution-unit.scala:542:24
    .io_in_1_bits_predicated              (_fp_sdq_io_deq_bits_predicated),	// execution-unit.scala:542:24
    .io_in_1_bits_fflags_valid            (_fp_sdq_io_deq_bits_fflags_valid),	// execution-unit.scala:542:24
    .io_in_1_bits_fflags_bits_uop_rob_idx (_fp_sdq_io_deq_bits_fflags_bits_uop_rob_idx),	// execution-unit.scala:542:24
    .io_in_1_bits_fflags_bits_flags       (_fp_sdq_io_deq_bits_fflags_bits_flags),	// execution-unit.scala:542:24
    .io_out_ready                         (io_ll_iresp_ready),
    .io_in_0_ready                        (_resp_arb_io_in_0_ready),
    .io_in_1_ready                        (_resp_arb_io_in_1_ready),
    .io_out_valid                         (io_ll_iresp_valid),
    .io_out_bits_uop_uopc                 (io_ll_iresp_bits_uop_uopc),
    .io_out_bits_uop_br_mask              (io_ll_iresp_bits_uop_br_mask),
    .io_out_bits_uop_rob_idx              (io_ll_iresp_bits_uop_rob_idx),
    .io_out_bits_uop_stq_idx              (io_ll_iresp_bits_uop_stq_idx),
    .io_out_bits_uop_pdst                 (io_ll_iresp_bits_uop_pdst),
    .io_out_bits_uop_is_amo               (io_ll_iresp_bits_uop_is_amo),
    .io_out_bits_uop_uses_stq             (io_ll_iresp_bits_uop_uses_stq),
    .io_out_bits_uop_dst_rtype            (io_ll_iresp_bits_uop_dst_rtype),
    .io_out_bits_uop_fp_val               (/* unused */),
    .io_out_bits_data                     (io_ll_iresp_bits_data),
    .io_out_bits_predicated               (io_ll_iresp_bits_predicated),
    .io_out_bits_fflags_valid             (/* unused */),
    .io_out_bits_fflags_bits_uop_rob_idx  (/* unused */),
    .io_out_bits_fflags_bits_flags        (/* unused */)
  );
  assign io_fu_types = {_fpiu_busy_T, 1'h0, ~fdiv_busy, 7'h40};	// execution-unit.scala:458:45, :459:{22,60}, :507:41, :559:35
  assign io_fresp_valid =
    (_fpu_io_resp_valid | _fdivsqrt_io_resp_valid)
    & ~(_fpu_io_resp_valid & _fpu_io_resp_bits_uop_fu_code[9]);	// execution-unit.scala:468:17, :493:22, :516:{65,69}, :517:{27,47}, micro-op.scala:154:40
  assign io_fresp_bits_uop_rob_idx =
    _fpu_io_resp_valid
      ? _fpu_io_resp_bits_uop_rob_idx
      : _fdivsqrt_io_resp_bits_uop_rob_idx;	// Mux.scala:47:69, execution-unit.scala:468:17, :493:22
  assign io_fresp_bits_uop_pdst =
    _fpu_io_resp_valid ? _fpu_io_resp_bits_uop_pdst : _fdivsqrt_io_resp_bits_uop_pdst;	// Mux.scala:47:69, execution-unit.scala:468:17, :493:22
  assign io_fresp_bits_uop_is_amo =
    _fpu_io_resp_valid ? _fpu_io_resp_bits_uop_is_amo : _fdivsqrt_io_resp_bits_uop_is_amo;	// Mux.scala:47:69, execution-unit.scala:468:17, :493:22
  assign io_fresp_bits_uop_uses_ldq =
    _fpu_io_resp_valid
      ? _fpu_io_resp_bits_uop_uses_ldq
      : _fdivsqrt_io_resp_bits_uop_uses_ldq;	// Mux.scala:47:69, execution-unit.scala:468:17, :493:22
  assign io_fresp_bits_uop_uses_stq =
    _fpu_io_resp_valid
      ? _fpu_io_resp_bits_uop_uses_stq
      : _fdivsqrt_io_resp_bits_uop_uses_stq;	// Mux.scala:47:69, execution-unit.scala:468:17, :493:22
  assign io_fresp_bits_uop_dst_rtype =
    _fpu_io_resp_valid
      ? _fpu_io_resp_bits_uop_dst_rtype
      : _fdivsqrt_io_resp_bits_uop_dst_rtype;	// Mux.scala:47:69, execution-unit.scala:468:17, :493:22
  assign io_fresp_bits_uop_fp_val =
    _fpu_io_resp_valid ? _fpu_io_resp_bits_uop_fp_val : _fdivsqrt_io_resp_bits_uop_fp_val;	// Mux.scala:47:69, execution-unit.scala:468:17, :493:22
  assign io_fresp_bits_data =
    _fpu_io_resp_valid ? _fpu_io_resp_bits_data : _fdivsqrt_io_resp_bits_data;	// Mux.scala:47:69, execution-unit.scala:468:17, :493:22
  assign io_fresp_bits_fflags_valid =
    _fpu_io_resp_valid
      ? _fpu_io_resp_bits_fflags_valid
      : _fdivsqrt_io_resp_bits_fflags_valid;	// execution-unit.scala:468:17, :493:22, :521:30
  assign io_fresp_bits_fflags_bits_uop_rob_idx =
    _fpu_io_resp_valid
      ? _fpu_io_resp_bits_fflags_bits_uop_rob_idx
      : _fdivsqrt_io_resp_bits_fflags_bits_uop_rob_idx;	// execution-unit.scala:468:17, :493:22, :521:30
  assign io_fresp_bits_fflags_bits_flags =
    _fpu_io_resp_valid
      ? _fpu_io_resp_bits_fflags_bits_flags
      : _fdivsqrt_io_resp_bits_fflags_bits_flags;	// execution-unit.scala:468:17, :493:22, :521:30
endmodule

