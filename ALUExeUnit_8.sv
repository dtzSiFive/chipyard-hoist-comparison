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

module ALUExeUnit_8(
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
  input  [15:0] io_req_bits_uop_br_mask,
  input  [3:0]  io_req_bits_uop_br_tag,
  input  [4:0]  io_req_bits_uop_ftq_idx,
  input         io_req_bits_uop_edge_inst,
  input  [5:0]  io_req_bits_uop_pc_lob,
  input         io_req_bits_uop_taken,
  input  [19:0] io_req_bits_uop_imm_packed,
  input  [11:0] io_req_bits_uop_csr_addr,
  input  [6:0]  io_req_bits_uop_rob_idx,
  input  [4:0]  io_req_bits_uop_ldq_idx,
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
  input         io_req_bits_kill,
                io_ll_fresp_ready,
  input  [15:0] io_brupdate_b1_resolve_mask,
                io_brupdate_b1_mispredict_mask,
  input  [2:0]  io_fcsr_rm,
  output [9:0]  io_fu_types,
  output        io_iresp_valid,
  output [2:0]  io_iresp_bits_uop_ctrl_csr_cmd,
  output [11:0] io_iresp_bits_uop_csr_addr,
  output [6:0]  io_iresp_bits_uop_rob_idx,
                io_iresp_bits_uop_pdst,
  output        io_iresp_bits_uop_bypassable,
                io_iresp_bits_uop_is_amo,
                io_iresp_bits_uop_uses_stq,
  output [1:0]  io_iresp_bits_uop_dst_rtype,
  output [64:0] io_iresp_bits_data,
  output        io_ll_fresp_valid,
  output [6:0]  io_ll_fresp_bits_uop_uopc,
  output [15:0] io_ll_fresp_bits_uop_br_mask,
  output [6:0]  io_ll_fresp_bits_uop_rob_idx,
  output [4:0]  io_ll_fresp_bits_uop_stq_idx,
  output [6:0]  io_ll_fresp_bits_uop_pdst,
  output        io_ll_fresp_bits_uop_is_amo,
                io_ll_fresp_bits_uop_uses_stq,
  output [1:0]  io_ll_fresp_bits_uop_dst_rtype,
  output        io_ll_fresp_bits_uop_fp_val,
  output [64:0] io_ll_fresp_bits_data,
  output        io_ll_fresp_bits_predicated,
                io_ll_fresp_bits_fflags_valid,
  output [6:0]  io_ll_fresp_bits_fflags_bits_uop_rob_idx,
  output [4:0]  io_ll_fresp_bits_fflags_bits_flags,
  output        io_bypass_0_valid,
  output [64:0] io_bypass_0_bits_data,
  output        io_brinfo_valid,
                io_brinfo_mispredict,
                io_brinfo_taken,
  output [2:0]  io_brinfo_cfi_type,
  output [1:0]  io_brinfo_pc_sel,
  output [20:0] io_brinfo_target_offset
);

  wire        _queue_io_enq_ready;	// execution-unit.scala:338:23
  wire        _queue_io_empty;	// execution-unit.scala:338:23
  wire        _ifpu_io_resp_valid;	// execution-unit.scala:330:18
  wire [6:0]  _ifpu_io_resp_bits_uop_uopc;	// execution-unit.scala:330:18
  wire [31:0] _ifpu_io_resp_bits_uop_inst;	// execution-unit.scala:330:18
  wire [31:0] _ifpu_io_resp_bits_uop_debug_inst;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_uop_is_rvc;	// execution-unit.scala:330:18
  wire [39:0] _ifpu_io_resp_bits_uop_debug_pc;	// execution-unit.scala:330:18
  wire [2:0]  _ifpu_io_resp_bits_uop_iq_type;	// execution-unit.scala:330:18
  wire [9:0]  _ifpu_io_resp_bits_uop_fu_code;	// execution-unit.scala:330:18
  wire [3:0]  _ifpu_io_resp_bits_uop_ctrl_br_type;	// execution-unit.scala:330:18
  wire [1:0]  _ifpu_io_resp_bits_uop_ctrl_op1_sel;	// execution-unit.scala:330:18
  wire [2:0]  _ifpu_io_resp_bits_uop_ctrl_op2_sel;	// execution-unit.scala:330:18
  wire [2:0]  _ifpu_io_resp_bits_uop_ctrl_imm_sel;	// execution-unit.scala:330:18
  wire [3:0]  _ifpu_io_resp_bits_uop_ctrl_op_fcn;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_uop_ctrl_fcn_dw;	// execution-unit.scala:330:18
  wire [2:0]  _ifpu_io_resp_bits_uop_ctrl_csr_cmd;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_uop_ctrl_is_load;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_uop_ctrl_is_sta;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_uop_ctrl_is_std;	// execution-unit.scala:330:18
  wire [1:0]  _ifpu_io_resp_bits_uop_iw_state;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_uop_iw_p1_poisoned;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_uop_iw_p2_poisoned;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_uop_is_br;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_uop_is_jalr;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_uop_is_jal;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_uop_is_sfb;	// execution-unit.scala:330:18
  wire [15:0] _ifpu_io_resp_bits_uop_br_mask;	// execution-unit.scala:330:18
  wire [3:0]  _ifpu_io_resp_bits_uop_br_tag;	// execution-unit.scala:330:18
  wire [4:0]  _ifpu_io_resp_bits_uop_ftq_idx;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_uop_edge_inst;	// execution-unit.scala:330:18
  wire [5:0]  _ifpu_io_resp_bits_uop_pc_lob;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_uop_taken;	// execution-unit.scala:330:18
  wire [19:0] _ifpu_io_resp_bits_uop_imm_packed;	// execution-unit.scala:330:18
  wire [11:0] _ifpu_io_resp_bits_uop_csr_addr;	// execution-unit.scala:330:18
  wire [6:0]  _ifpu_io_resp_bits_uop_rob_idx;	// execution-unit.scala:330:18
  wire [4:0]  _ifpu_io_resp_bits_uop_ldq_idx;	// execution-unit.scala:330:18
  wire [4:0]  _ifpu_io_resp_bits_uop_stq_idx;	// execution-unit.scala:330:18
  wire [1:0]  _ifpu_io_resp_bits_uop_rxq_idx;	// execution-unit.scala:330:18
  wire [6:0]  _ifpu_io_resp_bits_uop_pdst;	// execution-unit.scala:330:18
  wire [6:0]  _ifpu_io_resp_bits_uop_prs1;	// execution-unit.scala:330:18
  wire [6:0]  _ifpu_io_resp_bits_uop_prs2;	// execution-unit.scala:330:18
  wire [6:0]  _ifpu_io_resp_bits_uop_prs3;	// execution-unit.scala:330:18
  wire [4:0]  _ifpu_io_resp_bits_uop_ppred;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_uop_prs1_busy;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_uop_prs2_busy;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_uop_prs3_busy;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_uop_ppred_busy;	// execution-unit.scala:330:18
  wire [6:0]  _ifpu_io_resp_bits_uop_stale_pdst;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_uop_exception;	// execution-unit.scala:330:18
  wire [63:0] _ifpu_io_resp_bits_uop_exc_cause;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_uop_bypassable;	// execution-unit.scala:330:18
  wire [4:0]  _ifpu_io_resp_bits_uop_mem_cmd;	// execution-unit.scala:330:18
  wire [1:0]  _ifpu_io_resp_bits_uop_mem_size;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_uop_mem_signed;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_uop_is_fence;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_uop_is_fencei;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_uop_is_amo;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_uop_uses_ldq;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_uop_uses_stq;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_uop_is_sys_pc2epc;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_uop_is_unique;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_uop_flush_on_commit;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_uop_ldst_is_rs1;	// execution-unit.scala:330:18
  wire [5:0]  _ifpu_io_resp_bits_uop_ldst;	// execution-unit.scala:330:18
  wire [5:0]  _ifpu_io_resp_bits_uop_lrs1;	// execution-unit.scala:330:18
  wire [5:0]  _ifpu_io_resp_bits_uop_lrs2;	// execution-unit.scala:330:18
  wire [5:0]  _ifpu_io_resp_bits_uop_lrs3;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_uop_ldst_val;	// execution-unit.scala:330:18
  wire [1:0]  _ifpu_io_resp_bits_uop_dst_rtype;	// execution-unit.scala:330:18
  wire [1:0]  _ifpu_io_resp_bits_uop_lrs1_rtype;	// execution-unit.scala:330:18
  wire [1:0]  _ifpu_io_resp_bits_uop_lrs2_rtype;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_uop_frs3_en;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_uop_fp_val;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_uop_fp_single;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_uop_xcpt_pf_if;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_uop_xcpt_ae_if;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_uop_xcpt_ma_if;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_uop_bp_debug_if;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_uop_bp_xcpt_if;	// execution-unit.scala:330:18
  wire [1:0]  _ifpu_io_resp_bits_uop_debug_fsrc;	// execution-unit.scala:330:18
  wire [1:0]  _ifpu_io_resp_bits_uop_debug_tsrc;	// execution-unit.scala:330:18
  wire [64:0] _ifpu_io_resp_bits_data;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_valid;	// execution-unit.scala:330:18
  wire [6:0]  _ifpu_io_resp_bits_fflags_bits_uop_uopc;	// execution-unit.scala:330:18
  wire [31:0] _ifpu_io_resp_bits_fflags_bits_uop_inst;	// execution-unit.scala:330:18
  wire [31:0] _ifpu_io_resp_bits_fflags_bits_uop_debug_inst;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_bits_uop_is_rvc;	// execution-unit.scala:330:18
  wire [39:0] _ifpu_io_resp_bits_fflags_bits_uop_debug_pc;	// execution-unit.scala:330:18
  wire [2:0]  _ifpu_io_resp_bits_fflags_bits_uop_iq_type;	// execution-unit.scala:330:18
  wire [9:0]  _ifpu_io_resp_bits_fflags_bits_uop_fu_code;	// execution-unit.scala:330:18
  wire [3:0]  _ifpu_io_resp_bits_fflags_bits_uop_ctrl_br_type;	// execution-unit.scala:330:18
  wire [1:0]  _ifpu_io_resp_bits_fflags_bits_uop_ctrl_op1_sel;	// execution-unit.scala:330:18
  wire [2:0]  _ifpu_io_resp_bits_fflags_bits_uop_ctrl_op2_sel;	// execution-unit.scala:330:18
  wire [2:0]  _ifpu_io_resp_bits_fflags_bits_uop_ctrl_imm_sel;	// execution-unit.scala:330:18
  wire [3:0]  _ifpu_io_resp_bits_fflags_bits_uop_ctrl_op_fcn;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_bits_uop_ctrl_fcn_dw;	// execution-unit.scala:330:18
  wire [2:0]  _ifpu_io_resp_bits_fflags_bits_uop_ctrl_csr_cmd;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_bits_uop_ctrl_is_load;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_bits_uop_ctrl_is_sta;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_bits_uop_ctrl_is_std;	// execution-unit.scala:330:18
  wire [1:0]  _ifpu_io_resp_bits_fflags_bits_uop_iw_state;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_bits_uop_iw_p1_poisoned;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_bits_uop_iw_p2_poisoned;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_bits_uop_is_br;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_bits_uop_is_jalr;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_bits_uop_is_jal;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_bits_uop_is_sfb;	// execution-unit.scala:330:18
  wire [15:0] _ifpu_io_resp_bits_fflags_bits_uop_br_mask;	// execution-unit.scala:330:18
  wire [3:0]  _ifpu_io_resp_bits_fflags_bits_uop_br_tag;	// execution-unit.scala:330:18
  wire [4:0]  _ifpu_io_resp_bits_fflags_bits_uop_ftq_idx;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_bits_uop_edge_inst;	// execution-unit.scala:330:18
  wire [5:0]  _ifpu_io_resp_bits_fflags_bits_uop_pc_lob;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_bits_uop_taken;	// execution-unit.scala:330:18
  wire [19:0] _ifpu_io_resp_bits_fflags_bits_uop_imm_packed;	// execution-unit.scala:330:18
  wire [11:0] _ifpu_io_resp_bits_fflags_bits_uop_csr_addr;	// execution-unit.scala:330:18
  wire [6:0]  _ifpu_io_resp_bits_fflags_bits_uop_rob_idx;	// execution-unit.scala:330:18
  wire [4:0]  _ifpu_io_resp_bits_fflags_bits_uop_ldq_idx;	// execution-unit.scala:330:18
  wire [4:0]  _ifpu_io_resp_bits_fflags_bits_uop_stq_idx;	// execution-unit.scala:330:18
  wire [1:0]  _ifpu_io_resp_bits_fflags_bits_uop_rxq_idx;	// execution-unit.scala:330:18
  wire [6:0]  _ifpu_io_resp_bits_fflags_bits_uop_pdst;	// execution-unit.scala:330:18
  wire [6:0]  _ifpu_io_resp_bits_fflags_bits_uop_prs1;	// execution-unit.scala:330:18
  wire [6:0]  _ifpu_io_resp_bits_fflags_bits_uop_prs2;	// execution-unit.scala:330:18
  wire [6:0]  _ifpu_io_resp_bits_fflags_bits_uop_prs3;	// execution-unit.scala:330:18
  wire [4:0]  _ifpu_io_resp_bits_fflags_bits_uop_ppred;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_bits_uop_prs1_busy;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_bits_uop_prs2_busy;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_bits_uop_prs3_busy;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_bits_uop_ppred_busy;	// execution-unit.scala:330:18
  wire [6:0]  _ifpu_io_resp_bits_fflags_bits_uop_stale_pdst;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_bits_uop_exception;	// execution-unit.scala:330:18
  wire [63:0] _ifpu_io_resp_bits_fflags_bits_uop_exc_cause;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_bits_uop_bypassable;	// execution-unit.scala:330:18
  wire [4:0]  _ifpu_io_resp_bits_fflags_bits_uop_mem_cmd;	// execution-unit.scala:330:18
  wire [1:0]  _ifpu_io_resp_bits_fflags_bits_uop_mem_size;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_bits_uop_mem_signed;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_bits_uop_is_fence;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_bits_uop_is_fencei;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_bits_uop_is_amo;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_bits_uop_uses_ldq;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_bits_uop_uses_stq;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_bits_uop_is_sys_pc2epc;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_bits_uop_is_unique;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_bits_uop_flush_on_commit;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_bits_uop_ldst_is_rs1;	// execution-unit.scala:330:18
  wire [5:0]  _ifpu_io_resp_bits_fflags_bits_uop_ldst;	// execution-unit.scala:330:18
  wire [5:0]  _ifpu_io_resp_bits_fflags_bits_uop_lrs1;	// execution-unit.scala:330:18
  wire [5:0]  _ifpu_io_resp_bits_fflags_bits_uop_lrs2;	// execution-unit.scala:330:18
  wire [5:0]  _ifpu_io_resp_bits_fflags_bits_uop_lrs3;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_bits_uop_ldst_val;	// execution-unit.scala:330:18
  wire [1:0]  _ifpu_io_resp_bits_fflags_bits_uop_dst_rtype;	// execution-unit.scala:330:18
  wire [1:0]  _ifpu_io_resp_bits_fflags_bits_uop_lrs1_rtype;	// execution-unit.scala:330:18
  wire [1:0]  _ifpu_io_resp_bits_fflags_bits_uop_lrs2_rtype;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_bits_uop_frs3_en;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_bits_uop_fp_val;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_bits_uop_fp_single;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_bits_uop_xcpt_pf_if;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_bits_uop_xcpt_ae_if;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_bits_uop_xcpt_ma_if;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_bits_uop_bp_debug_if;	// execution-unit.scala:330:18
  wire        _ifpu_io_resp_bits_fflags_bits_uop_bp_xcpt_if;	// execution-unit.scala:330:18
  wire [1:0]  _ifpu_io_resp_bits_fflags_bits_uop_debug_fsrc;	// execution-unit.scala:330:18
  wire [1:0]  _ifpu_io_resp_bits_fflags_bits_uop_debug_tsrc;	// execution-unit.scala:330:18
  wire [4:0]  _ifpu_io_resp_bits_fflags_bits_flags;	// execution-unit.scala:330:18
  wire [19:0] _alu_io_resp_bits_uop_imm_packed;	// execution-unit.scala:262:17
  wire [63:0] _alu_io_resp_bits_data;	// execution-unit.scala:262:17
  wire [63:0] _alu_io_bypass_0_bits_data;	// execution-unit.scala:262:17
  wire        _GEN =
    io_req_valid
    & (io_req_bits_uop_fu_code == 10'h1 | io_req_bits_uop_fu_code == 10'h2
       | io_req_bits_uop_fu_code == 10'h20 & io_req_bits_uop_uopc != 7'h6C);	// execution-unit.scala:251:21, :254:21, :255:21, :266:20, :267:32, :268:{32,43}, :269:{32,43,67}
  `ifndef SYNTHESIS	// execution-unit.scala:350:12
    always @(posedge clock) begin	// execution-unit.scala:350:12
      if (~(_queue_io_enq_ready | reset)) begin	// execution-unit.scala:338:23, :350:12
        if (`ASSERT_VERBOSE_COND_)	// execution-unit.scala:350:12
          $error("Assertion failed\n    at execution-unit.scala:350 assert (queue.io.enq.ready)\n");	// execution-unit.scala:350:12
        if (`STOP_COND_)	// execution-unit.scala:350:12
          $fatal;	// execution-unit.scala:350:12
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  ALUUnit_5 alu (	// execution-unit.scala:262:17
    .clock                          (clock),
    .reset                          (reset),
    .io_req_valid                   (_GEN),	// execution-unit.scala:266:20
    .io_req_bits_uop_uopc           (io_req_bits_uop_uopc),
    .io_req_bits_uop_is_rvc         (io_req_bits_uop_is_rvc),
    .io_req_bits_uop_ctrl_br_type   (io_req_bits_uop_ctrl_br_type),
    .io_req_bits_uop_ctrl_op1_sel   (io_req_bits_uop_ctrl_op1_sel),
    .io_req_bits_uop_ctrl_op2_sel   (io_req_bits_uop_ctrl_op2_sel),
    .io_req_bits_uop_ctrl_imm_sel   (io_req_bits_uop_ctrl_imm_sel),
    .io_req_bits_uop_ctrl_op_fcn    (io_req_bits_uop_ctrl_op_fcn),
    .io_req_bits_uop_ctrl_fcn_dw    (io_req_bits_uop_ctrl_fcn_dw),
    .io_req_bits_uop_ctrl_csr_cmd   (io_req_bits_uop_ctrl_csr_cmd),
    .io_req_bits_uop_is_br          (io_req_bits_uop_is_br),
    .io_req_bits_uop_is_jalr        (io_req_bits_uop_is_jalr),
    .io_req_bits_uop_is_jal         (io_req_bits_uop_is_jal),
    .io_req_bits_uop_is_sfb         (io_req_bits_uop_is_sfb),
    .io_req_bits_uop_br_mask        (io_req_bits_uop_br_mask),
    .io_req_bits_uop_taken          (io_req_bits_uop_taken),
    .io_req_bits_uop_imm_packed     (io_req_bits_uop_imm_packed),
    .io_req_bits_uop_rob_idx        (io_req_bits_uop_rob_idx),
    .io_req_bits_uop_pdst           (io_req_bits_uop_pdst),
    .io_req_bits_uop_prs1           (io_req_bits_uop_prs1),
    .io_req_bits_uop_bypassable     (io_req_bits_uop_bypassable),
    .io_req_bits_uop_is_amo         (io_req_bits_uop_is_amo),
    .io_req_bits_uop_uses_stq       (io_req_bits_uop_uses_stq),
    .io_req_bits_uop_dst_rtype      (io_req_bits_uop_dst_rtype),
    .io_req_bits_rs1_data           (io_req_bits_rs1_data[63:0]),	// execution-unit.scala:274:30
    .io_req_bits_rs2_data           (io_req_bits_rs2_data[63:0]),	// execution-unit.scala:275:30
    .io_req_bits_kill               (io_req_bits_kill),
    .io_brupdate_b1_resolve_mask    (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask (io_brupdate_b1_mispredict_mask),
    .io_resp_valid                  (io_iresp_valid),
    .io_resp_bits_uop_ctrl_csr_cmd  (io_iresp_bits_uop_ctrl_csr_cmd),
    .io_resp_bits_uop_imm_packed    (_alu_io_resp_bits_uop_imm_packed),
    .io_resp_bits_uop_rob_idx       (io_iresp_bits_uop_rob_idx),
    .io_resp_bits_uop_pdst          (io_iresp_bits_uop_pdst),
    .io_resp_bits_uop_bypassable    (io_iresp_bits_uop_bypassable),
    .io_resp_bits_uop_is_amo        (io_iresp_bits_uop_is_amo),
    .io_resp_bits_uop_uses_stq      (io_iresp_bits_uop_uses_stq),
    .io_resp_bits_uop_dst_rtype     (io_iresp_bits_uop_dst_rtype),
    .io_resp_bits_data              (_alu_io_resp_bits_data),
    .io_bypass_0_bits_data          (_alu_io_bypass_0_bits_data),
    .io_brinfo_valid                (io_brinfo_valid),
    .io_brinfo_mispredict           (io_brinfo_mispredict),
    .io_brinfo_taken                (io_brinfo_taken),
    .io_brinfo_cfi_type             (io_brinfo_cfi_type),
    .io_brinfo_pc_sel               (io_brinfo_pc_sel),
    .io_brinfo_target_offset        (io_brinfo_target_offset)
  );
  IntToFPUnit_1 ifpu (	// execution-unit.scala:330:18
    .clock                                        (clock),
    .reset                                        (reset),
    .io_req_valid
      (io_req_valid & io_req_bits_uop_fu_code[8]),	// execution-unit.scala:332:40, micro-op.scala:154:40
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
    .io_req_bits_kill                             (io_req_bits_kill),
    .io_brupdate_b1_resolve_mask                  (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask               (io_brupdate_b1_mispredict_mask),
    .io_fcsr_rm                                   (io_fcsr_rm),
    .io_resp_valid                                (_ifpu_io_resp_valid),
    .io_resp_bits_uop_uopc                        (_ifpu_io_resp_bits_uop_uopc),
    .io_resp_bits_uop_inst                        (_ifpu_io_resp_bits_uop_inst),
    .io_resp_bits_uop_debug_inst                  (_ifpu_io_resp_bits_uop_debug_inst),
    .io_resp_bits_uop_is_rvc                      (_ifpu_io_resp_bits_uop_is_rvc),
    .io_resp_bits_uop_debug_pc                    (_ifpu_io_resp_bits_uop_debug_pc),
    .io_resp_bits_uop_iq_type                     (_ifpu_io_resp_bits_uop_iq_type),
    .io_resp_bits_uop_fu_code                     (_ifpu_io_resp_bits_uop_fu_code),
    .io_resp_bits_uop_ctrl_br_type                (_ifpu_io_resp_bits_uop_ctrl_br_type),
    .io_resp_bits_uop_ctrl_op1_sel                (_ifpu_io_resp_bits_uop_ctrl_op1_sel),
    .io_resp_bits_uop_ctrl_op2_sel                (_ifpu_io_resp_bits_uop_ctrl_op2_sel),
    .io_resp_bits_uop_ctrl_imm_sel                (_ifpu_io_resp_bits_uop_ctrl_imm_sel),
    .io_resp_bits_uop_ctrl_op_fcn                 (_ifpu_io_resp_bits_uop_ctrl_op_fcn),
    .io_resp_bits_uop_ctrl_fcn_dw                 (_ifpu_io_resp_bits_uop_ctrl_fcn_dw),
    .io_resp_bits_uop_ctrl_csr_cmd                (_ifpu_io_resp_bits_uop_ctrl_csr_cmd),
    .io_resp_bits_uop_ctrl_is_load                (_ifpu_io_resp_bits_uop_ctrl_is_load),
    .io_resp_bits_uop_ctrl_is_sta                 (_ifpu_io_resp_bits_uop_ctrl_is_sta),
    .io_resp_bits_uop_ctrl_is_std                 (_ifpu_io_resp_bits_uop_ctrl_is_std),
    .io_resp_bits_uop_iw_state                    (_ifpu_io_resp_bits_uop_iw_state),
    .io_resp_bits_uop_iw_p1_poisoned              (_ifpu_io_resp_bits_uop_iw_p1_poisoned),
    .io_resp_bits_uop_iw_p2_poisoned              (_ifpu_io_resp_bits_uop_iw_p2_poisoned),
    .io_resp_bits_uop_is_br                       (_ifpu_io_resp_bits_uop_is_br),
    .io_resp_bits_uop_is_jalr                     (_ifpu_io_resp_bits_uop_is_jalr),
    .io_resp_bits_uop_is_jal                      (_ifpu_io_resp_bits_uop_is_jal),
    .io_resp_bits_uop_is_sfb                      (_ifpu_io_resp_bits_uop_is_sfb),
    .io_resp_bits_uop_br_mask                     (_ifpu_io_resp_bits_uop_br_mask),
    .io_resp_bits_uop_br_tag                      (_ifpu_io_resp_bits_uop_br_tag),
    .io_resp_bits_uop_ftq_idx                     (_ifpu_io_resp_bits_uop_ftq_idx),
    .io_resp_bits_uop_edge_inst                   (_ifpu_io_resp_bits_uop_edge_inst),
    .io_resp_bits_uop_pc_lob                      (_ifpu_io_resp_bits_uop_pc_lob),
    .io_resp_bits_uop_taken                       (_ifpu_io_resp_bits_uop_taken),
    .io_resp_bits_uop_imm_packed                  (_ifpu_io_resp_bits_uop_imm_packed),
    .io_resp_bits_uop_csr_addr                    (_ifpu_io_resp_bits_uop_csr_addr),
    .io_resp_bits_uop_rob_idx                     (_ifpu_io_resp_bits_uop_rob_idx),
    .io_resp_bits_uop_ldq_idx                     (_ifpu_io_resp_bits_uop_ldq_idx),
    .io_resp_bits_uop_stq_idx                     (_ifpu_io_resp_bits_uop_stq_idx),
    .io_resp_bits_uop_rxq_idx                     (_ifpu_io_resp_bits_uop_rxq_idx),
    .io_resp_bits_uop_pdst                        (_ifpu_io_resp_bits_uop_pdst),
    .io_resp_bits_uop_prs1                        (_ifpu_io_resp_bits_uop_prs1),
    .io_resp_bits_uop_prs2                        (_ifpu_io_resp_bits_uop_prs2),
    .io_resp_bits_uop_prs3                        (_ifpu_io_resp_bits_uop_prs3),
    .io_resp_bits_uop_ppred                       (_ifpu_io_resp_bits_uop_ppred),
    .io_resp_bits_uop_prs1_busy                   (_ifpu_io_resp_bits_uop_prs1_busy),
    .io_resp_bits_uop_prs2_busy                   (_ifpu_io_resp_bits_uop_prs2_busy),
    .io_resp_bits_uop_prs3_busy                   (_ifpu_io_resp_bits_uop_prs3_busy),
    .io_resp_bits_uop_ppred_busy                  (_ifpu_io_resp_bits_uop_ppred_busy),
    .io_resp_bits_uop_stale_pdst                  (_ifpu_io_resp_bits_uop_stale_pdst),
    .io_resp_bits_uop_exception                   (_ifpu_io_resp_bits_uop_exception),
    .io_resp_bits_uop_exc_cause                   (_ifpu_io_resp_bits_uop_exc_cause),
    .io_resp_bits_uop_bypassable                  (_ifpu_io_resp_bits_uop_bypassable),
    .io_resp_bits_uop_mem_cmd                     (_ifpu_io_resp_bits_uop_mem_cmd),
    .io_resp_bits_uop_mem_size                    (_ifpu_io_resp_bits_uop_mem_size),
    .io_resp_bits_uop_mem_signed                  (_ifpu_io_resp_bits_uop_mem_signed),
    .io_resp_bits_uop_is_fence                    (_ifpu_io_resp_bits_uop_is_fence),
    .io_resp_bits_uop_is_fencei                   (_ifpu_io_resp_bits_uop_is_fencei),
    .io_resp_bits_uop_is_amo                      (_ifpu_io_resp_bits_uop_is_amo),
    .io_resp_bits_uop_uses_ldq                    (_ifpu_io_resp_bits_uop_uses_ldq),
    .io_resp_bits_uop_uses_stq                    (_ifpu_io_resp_bits_uop_uses_stq),
    .io_resp_bits_uop_is_sys_pc2epc               (_ifpu_io_resp_bits_uop_is_sys_pc2epc),
    .io_resp_bits_uop_is_unique                   (_ifpu_io_resp_bits_uop_is_unique),
    .io_resp_bits_uop_flush_on_commit
      (_ifpu_io_resp_bits_uop_flush_on_commit),
    .io_resp_bits_uop_ldst_is_rs1                 (_ifpu_io_resp_bits_uop_ldst_is_rs1),
    .io_resp_bits_uop_ldst                        (_ifpu_io_resp_bits_uop_ldst),
    .io_resp_bits_uop_lrs1                        (_ifpu_io_resp_bits_uop_lrs1),
    .io_resp_bits_uop_lrs2                        (_ifpu_io_resp_bits_uop_lrs2),
    .io_resp_bits_uop_lrs3                        (_ifpu_io_resp_bits_uop_lrs3),
    .io_resp_bits_uop_ldst_val                    (_ifpu_io_resp_bits_uop_ldst_val),
    .io_resp_bits_uop_dst_rtype                   (_ifpu_io_resp_bits_uop_dst_rtype),
    .io_resp_bits_uop_lrs1_rtype                  (_ifpu_io_resp_bits_uop_lrs1_rtype),
    .io_resp_bits_uop_lrs2_rtype                  (_ifpu_io_resp_bits_uop_lrs2_rtype),
    .io_resp_bits_uop_frs3_en                     (_ifpu_io_resp_bits_uop_frs3_en),
    .io_resp_bits_uop_fp_val                      (_ifpu_io_resp_bits_uop_fp_val),
    .io_resp_bits_uop_fp_single                   (_ifpu_io_resp_bits_uop_fp_single),
    .io_resp_bits_uop_xcpt_pf_if                  (_ifpu_io_resp_bits_uop_xcpt_pf_if),
    .io_resp_bits_uop_xcpt_ae_if                  (_ifpu_io_resp_bits_uop_xcpt_ae_if),
    .io_resp_bits_uop_xcpt_ma_if                  (_ifpu_io_resp_bits_uop_xcpt_ma_if),
    .io_resp_bits_uop_bp_debug_if                 (_ifpu_io_resp_bits_uop_bp_debug_if),
    .io_resp_bits_uop_bp_xcpt_if                  (_ifpu_io_resp_bits_uop_bp_xcpt_if),
    .io_resp_bits_uop_debug_fsrc                  (_ifpu_io_resp_bits_uop_debug_fsrc),
    .io_resp_bits_uop_debug_tsrc                  (_ifpu_io_resp_bits_uop_debug_tsrc),
    .io_resp_bits_data                            (_ifpu_io_resp_bits_data),
    .io_resp_bits_fflags_valid                    (_ifpu_io_resp_bits_fflags_valid),
    .io_resp_bits_fflags_bits_uop_uopc
      (_ifpu_io_resp_bits_fflags_bits_uop_uopc),
    .io_resp_bits_fflags_bits_uop_inst
      (_ifpu_io_resp_bits_fflags_bits_uop_inst),
    .io_resp_bits_fflags_bits_uop_debug_inst
      (_ifpu_io_resp_bits_fflags_bits_uop_debug_inst),
    .io_resp_bits_fflags_bits_uop_is_rvc
      (_ifpu_io_resp_bits_fflags_bits_uop_is_rvc),
    .io_resp_bits_fflags_bits_uop_debug_pc
      (_ifpu_io_resp_bits_fflags_bits_uop_debug_pc),
    .io_resp_bits_fflags_bits_uop_iq_type
      (_ifpu_io_resp_bits_fflags_bits_uop_iq_type),
    .io_resp_bits_fflags_bits_uop_fu_code
      (_ifpu_io_resp_bits_fflags_bits_uop_fu_code),
    .io_resp_bits_fflags_bits_uop_ctrl_br_type
      (_ifpu_io_resp_bits_fflags_bits_uop_ctrl_br_type),
    .io_resp_bits_fflags_bits_uop_ctrl_op1_sel
      (_ifpu_io_resp_bits_fflags_bits_uop_ctrl_op1_sel),
    .io_resp_bits_fflags_bits_uop_ctrl_op2_sel
      (_ifpu_io_resp_bits_fflags_bits_uop_ctrl_op2_sel),
    .io_resp_bits_fflags_bits_uop_ctrl_imm_sel
      (_ifpu_io_resp_bits_fflags_bits_uop_ctrl_imm_sel),
    .io_resp_bits_fflags_bits_uop_ctrl_op_fcn
      (_ifpu_io_resp_bits_fflags_bits_uop_ctrl_op_fcn),
    .io_resp_bits_fflags_bits_uop_ctrl_fcn_dw
      (_ifpu_io_resp_bits_fflags_bits_uop_ctrl_fcn_dw),
    .io_resp_bits_fflags_bits_uop_ctrl_csr_cmd
      (_ifpu_io_resp_bits_fflags_bits_uop_ctrl_csr_cmd),
    .io_resp_bits_fflags_bits_uop_ctrl_is_load
      (_ifpu_io_resp_bits_fflags_bits_uop_ctrl_is_load),
    .io_resp_bits_fflags_bits_uop_ctrl_is_sta
      (_ifpu_io_resp_bits_fflags_bits_uop_ctrl_is_sta),
    .io_resp_bits_fflags_bits_uop_ctrl_is_std
      (_ifpu_io_resp_bits_fflags_bits_uop_ctrl_is_std),
    .io_resp_bits_fflags_bits_uop_iw_state
      (_ifpu_io_resp_bits_fflags_bits_uop_iw_state),
    .io_resp_bits_fflags_bits_uop_iw_p1_poisoned
      (_ifpu_io_resp_bits_fflags_bits_uop_iw_p1_poisoned),
    .io_resp_bits_fflags_bits_uop_iw_p2_poisoned
      (_ifpu_io_resp_bits_fflags_bits_uop_iw_p2_poisoned),
    .io_resp_bits_fflags_bits_uop_is_br
      (_ifpu_io_resp_bits_fflags_bits_uop_is_br),
    .io_resp_bits_fflags_bits_uop_is_jalr
      (_ifpu_io_resp_bits_fflags_bits_uop_is_jalr),
    .io_resp_bits_fflags_bits_uop_is_jal
      (_ifpu_io_resp_bits_fflags_bits_uop_is_jal),
    .io_resp_bits_fflags_bits_uop_is_sfb
      (_ifpu_io_resp_bits_fflags_bits_uop_is_sfb),
    .io_resp_bits_fflags_bits_uop_br_mask
      (_ifpu_io_resp_bits_fflags_bits_uop_br_mask),
    .io_resp_bits_fflags_bits_uop_br_tag
      (_ifpu_io_resp_bits_fflags_bits_uop_br_tag),
    .io_resp_bits_fflags_bits_uop_ftq_idx
      (_ifpu_io_resp_bits_fflags_bits_uop_ftq_idx),
    .io_resp_bits_fflags_bits_uop_edge_inst
      (_ifpu_io_resp_bits_fflags_bits_uop_edge_inst),
    .io_resp_bits_fflags_bits_uop_pc_lob
      (_ifpu_io_resp_bits_fflags_bits_uop_pc_lob),
    .io_resp_bits_fflags_bits_uop_taken
      (_ifpu_io_resp_bits_fflags_bits_uop_taken),
    .io_resp_bits_fflags_bits_uop_imm_packed
      (_ifpu_io_resp_bits_fflags_bits_uop_imm_packed),
    .io_resp_bits_fflags_bits_uop_csr_addr
      (_ifpu_io_resp_bits_fflags_bits_uop_csr_addr),
    .io_resp_bits_fflags_bits_uop_rob_idx
      (_ifpu_io_resp_bits_fflags_bits_uop_rob_idx),
    .io_resp_bits_fflags_bits_uop_ldq_idx
      (_ifpu_io_resp_bits_fflags_bits_uop_ldq_idx),
    .io_resp_bits_fflags_bits_uop_stq_idx
      (_ifpu_io_resp_bits_fflags_bits_uop_stq_idx),
    .io_resp_bits_fflags_bits_uop_rxq_idx
      (_ifpu_io_resp_bits_fflags_bits_uop_rxq_idx),
    .io_resp_bits_fflags_bits_uop_pdst
      (_ifpu_io_resp_bits_fflags_bits_uop_pdst),
    .io_resp_bits_fflags_bits_uop_prs1
      (_ifpu_io_resp_bits_fflags_bits_uop_prs1),
    .io_resp_bits_fflags_bits_uop_prs2
      (_ifpu_io_resp_bits_fflags_bits_uop_prs2),
    .io_resp_bits_fflags_bits_uop_prs3
      (_ifpu_io_resp_bits_fflags_bits_uop_prs3),
    .io_resp_bits_fflags_bits_uop_ppred
      (_ifpu_io_resp_bits_fflags_bits_uop_ppred),
    .io_resp_bits_fflags_bits_uop_prs1_busy
      (_ifpu_io_resp_bits_fflags_bits_uop_prs1_busy),
    .io_resp_bits_fflags_bits_uop_prs2_busy
      (_ifpu_io_resp_bits_fflags_bits_uop_prs2_busy),
    .io_resp_bits_fflags_bits_uop_prs3_busy
      (_ifpu_io_resp_bits_fflags_bits_uop_prs3_busy),
    .io_resp_bits_fflags_bits_uop_ppred_busy
      (_ifpu_io_resp_bits_fflags_bits_uop_ppred_busy),
    .io_resp_bits_fflags_bits_uop_stale_pdst
      (_ifpu_io_resp_bits_fflags_bits_uop_stale_pdst),
    .io_resp_bits_fflags_bits_uop_exception
      (_ifpu_io_resp_bits_fflags_bits_uop_exception),
    .io_resp_bits_fflags_bits_uop_exc_cause
      (_ifpu_io_resp_bits_fflags_bits_uop_exc_cause),
    .io_resp_bits_fflags_bits_uop_bypassable
      (_ifpu_io_resp_bits_fflags_bits_uop_bypassable),
    .io_resp_bits_fflags_bits_uop_mem_cmd
      (_ifpu_io_resp_bits_fflags_bits_uop_mem_cmd),
    .io_resp_bits_fflags_bits_uop_mem_size
      (_ifpu_io_resp_bits_fflags_bits_uop_mem_size),
    .io_resp_bits_fflags_bits_uop_mem_signed
      (_ifpu_io_resp_bits_fflags_bits_uop_mem_signed),
    .io_resp_bits_fflags_bits_uop_is_fence
      (_ifpu_io_resp_bits_fflags_bits_uop_is_fence),
    .io_resp_bits_fflags_bits_uop_is_fencei
      (_ifpu_io_resp_bits_fflags_bits_uop_is_fencei),
    .io_resp_bits_fflags_bits_uop_is_amo
      (_ifpu_io_resp_bits_fflags_bits_uop_is_amo),
    .io_resp_bits_fflags_bits_uop_uses_ldq
      (_ifpu_io_resp_bits_fflags_bits_uop_uses_ldq),
    .io_resp_bits_fflags_bits_uop_uses_stq
      (_ifpu_io_resp_bits_fflags_bits_uop_uses_stq),
    .io_resp_bits_fflags_bits_uop_is_sys_pc2epc
      (_ifpu_io_resp_bits_fflags_bits_uop_is_sys_pc2epc),
    .io_resp_bits_fflags_bits_uop_is_unique
      (_ifpu_io_resp_bits_fflags_bits_uop_is_unique),
    .io_resp_bits_fflags_bits_uop_flush_on_commit
      (_ifpu_io_resp_bits_fflags_bits_uop_flush_on_commit),
    .io_resp_bits_fflags_bits_uop_ldst_is_rs1
      (_ifpu_io_resp_bits_fflags_bits_uop_ldst_is_rs1),
    .io_resp_bits_fflags_bits_uop_ldst
      (_ifpu_io_resp_bits_fflags_bits_uop_ldst),
    .io_resp_bits_fflags_bits_uop_lrs1
      (_ifpu_io_resp_bits_fflags_bits_uop_lrs1),
    .io_resp_bits_fflags_bits_uop_lrs2
      (_ifpu_io_resp_bits_fflags_bits_uop_lrs2),
    .io_resp_bits_fflags_bits_uop_lrs3
      (_ifpu_io_resp_bits_fflags_bits_uop_lrs3),
    .io_resp_bits_fflags_bits_uop_ldst_val
      (_ifpu_io_resp_bits_fflags_bits_uop_ldst_val),
    .io_resp_bits_fflags_bits_uop_dst_rtype
      (_ifpu_io_resp_bits_fflags_bits_uop_dst_rtype),
    .io_resp_bits_fflags_bits_uop_lrs1_rtype
      (_ifpu_io_resp_bits_fflags_bits_uop_lrs1_rtype),
    .io_resp_bits_fflags_bits_uop_lrs2_rtype
      (_ifpu_io_resp_bits_fflags_bits_uop_lrs2_rtype),
    .io_resp_bits_fflags_bits_uop_frs3_en
      (_ifpu_io_resp_bits_fflags_bits_uop_frs3_en),
    .io_resp_bits_fflags_bits_uop_fp_val
      (_ifpu_io_resp_bits_fflags_bits_uop_fp_val),
    .io_resp_bits_fflags_bits_uop_fp_single
      (_ifpu_io_resp_bits_fflags_bits_uop_fp_single),
    .io_resp_bits_fflags_bits_uop_xcpt_pf_if
      (_ifpu_io_resp_bits_fflags_bits_uop_xcpt_pf_if),
    .io_resp_bits_fflags_bits_uop_xcpt_ae_if
      (_ifpu_io_resp_bits_fflags_bits_uop_xcpt_ae_if),
    .io_resp_bits_fflags_bits_uop_xcpt_ma_if
      (_ifpu_io_resp_bits_fflags_bits_uop_xcpt_ma_if),
    .io_resp_bits_fflags_bits_uop_bp_debug_if
      (_ifpu_io_resp_bits_fflags_bits_uop_bp_debug_if),
    .io_resp_bits_fflags_bits_uop_bp_xcpt_if
      (_ifpu_io_resp_bits_fflags_bits_uop_bp_xcpt_if),
    .io_resp_bits_fflags_bits_uop_debug_fsrc
      (_ifpu_io_resp_bits_fflags_bits_uop_debug_fsrc),
    .io_resp_bits_fflags_bits_uop_debug_tsrc
      (_ifpu_io_resp_bits_fflags_bits_uop_debug_tsrc),
    .io_resp_bits_fflags_bits_flags               (_ifpu_io_resp_bits_fflags_bits_flags)
  );
  BranchKillableQueue_17 queue (	// execution-unit.scala:338:23
    .clock                                       (clock),
    .reset                                       (reset),
    .io_enq_valid                                (_ifpu_io_resp_valid),	// execution-unit.scala:330:18
    .io_enq_bits_uop_uopc                        (_ifpu_io_resp_bits_uop_uopc),	// execution-unit.scala:330:18
    .io_enq_bits_uop_inst                        (_ifpu_io_resp_bits_uop_inst),	// execution-unit.scala:330:18
    .io_enq_bits_uop_debug_inst                  (_ifpu_io_resp_bits_uop_debug_inst),	// execution-unit.scala:330:18
    .io_enq_bits_uop_is_rvc                      (_ifpu_io_resp_bits_uop_is_rvc),	// execution-unit.scala:330:18
    .io_enq_bits_uop_debug_pc                    (_ifpu_io_resp_bits_uop_debug_pc),	// execution-unit.scala:330:18
    .io_enq_bits_uop_iq_type                     (_ifpu_io_resp_bits_uop_iq_type),	// execution-unit.scala:330:18
    .io_enq_bits_uop_fu_code                     (_ifpu_io_resp_bits_uop_fu_code),	// execution-unit.scala:330:18
    .io_enq_bits_uop_ctrl_br_type                (_ifpu_io_resp_bits_uop_ctrl_br_type),	// execution-unit.scala:330:18
    .io_enq_bits_uop_ctrl_op1_sel                (_ifpu_io_resp_bits_uop_ctrl_op1_sel),	// execution-unit.scala:330:18
    .io_enq_bits_uop_ctrl_op2_sel                (_ifpu_io_resp_bits_uop_ctrl_op2_sel),	// execution-unit.scala:330:18
    .io_enq_bits_uop_ctrl_imm_sel                (_ifpu_io_resp_bits_uop_ctrl_imm_sel),	// execution-unit.scala:330:18
    .io_enq_bits_uop_ctrl_op_fcn                 (_ifpu_io_resp_bits_uop_ctrl_op_fcn),	// execution-unit.scala:330:18
    .io_enq_bits_uop_ctrl_fcn_dw                 (_ifpu_io_resp_bits_uop_ctrl_fcn_dw),	// execution-unit.scala:330:18
    .io_enq_bits_uop_ctrl_csr_cmd                (_ifpu_io_resp_bits_uop_ctrl_csr_cmd),	// execution-unit.scala:330:18
    .io_enq_bits_uop_ctrl_is_load                (_ifpu_io_resp_bits_uop_ctrl_is_load),	// execution-unit.scala:330:18
    .io_enq_bits_uop_ctrl_is_sta                 (_ifpu_io_resp_bits_uop_ctrl_is_sta),	// execution-unit.scala:330:18
    .io_enq_bits_uop_ctrl_is_std                 (_ifpu_io_resp_bits_uop_ctrl_is_std),	// execution-unit.scala:330:18
    .io_enq_bits_uop_iw_state                    (_ifpu_io_resp_bits_uop_iw_state),	// execution-unit.scala:330:18
    .io_enq_bits_uop_iw_p1_poisoned              (_ifpu_io_resp_bits_uop_iw_p1_poisoned),	// execution-unit.scala:330:18
    .io_enq_bits_uop_iw_p2_poisoned              (_ifpu_io_resp_bits_uop_iw_p2_poisoned),	// execution-unit.scala:330:18
    .io_enq_bits_uop_is_br                       (_ifpu_io_resp_bits_uop_is_br),	// execution-unit.scala:330:18
    .io_enq_bits_uop_is_jalr                     (_ifpu_io_resp_bits_uop_is_jalr),	// execution-unit.scala:330:18
    .io_enq_bits_uop_is_jal                      (_ifpu_io_resp_bits_uop_is_jal),	// execution-unit.scala:330:18
    .io_enq_bits_uop_is_sfb                      (_ifpu_io_resp_bits_uop_is_sfb),	// execution-unit.scala:330:18
    .io_enq_bits_uop_br_mask                     (_ifpu_io_resp_bits_uop_br_mask),	// execution-unit.scala:330:18
    .io_enq_bits_uop_br_tag                      (_ifpu_io_resp_bits_uop_br_tag),	// execution-unit.scala:330:18
    .io_enq_bits_uop_ftq_idx                     (_ifpu_io_resp_bits_uop_ftq_idx),	// execution-unit.scala:330:18
    .io_enq_bits_uop_edge_inst                   (_ifpu_io_resp_bits_uop_edge_inst),	// execution-unit.scala:330:18
    .io_enq_bits_uop_pc_lob                      (_ifpu_io_resp_bits_uop_pc_lob),	// execution-unit.scala:330:18
    .io_enq_bits_uop_taken                       (_ifpu_io_resp_bits_uop_taken),	// execution-unit.scala:330:18
    .io_enq_bits_uop_imm_packed                  (_ifpu_io_resp_bits_uop_imm_packed),	// execution-unit.scala:330:18
    .io_enq_bits_uop_csr_addr                    (_ifpu_io_resp_bits_uop_csr_addr),	// execution-unit.scala:330:18
    .io_enq_bits_uop_rob_idx                     (_ifpu_io_resp_bits_uop_rob_idx),	// execution-unit.scala:330:18
    .io_enq_bits_uop_ldq_idx                     (_ifpu_io_resp_bits_uop_ldq_idx),	// execution-unit.scala:330:18
    .io_enq_bits_uop_stq_idx                     (_ifpu_io_resp_bits_uop_stq_idx),	// execution-unit.scala:330:18
    .io_enq_bits_uop_rxq_idx                     (_ifpu_io_resp_bits_uop_rxq_idx),	// execution-unit.scala:330:18
    .io_enq_bits_uop_pdst                        (_ifpu_io_resp_bits_uop_pdst),	// execution-unit.scala:330:18
    .io_enq_bits_uop_prs1                        (_ifpu_io_resp_bits_uop_prs1),	// execution-unit.scala:330:18
    .io_enq_bits_uop_prs2                        (_ifpu_io_resp_bits_uop_prs2),	// execution-unit.scala:330:18
    .io_enq_bits_uop_prs3                        (_ifpu_io_resp_bits_uop_prs3),	// execution-unit.scala:330:18
    .io_enq_bits_uop_ppred                       (_ifpu_io_resp_bits_uop_ppred),	// execution-unit.scala:330:18
    .io_enq_bits_uop_prs1_busy                   (_ifpu_io_resp_bits_uop_prs1_busy),	// execution-unit.scala:330:18
    .io_enq_bits_uop_prs2_busy                   (_ifpu_io_resp_bits_uop_prs2_busy),	// execution-unit.scala:330:18
    .io_enq_bits_uop_prs3_busy                   (_ifpu_io_resp_bits_uop_prs3_busy),	// execution-unit.scala:330:18
    .io_enq_bits_uop_ppred_busy                  (_ifpu_io_resp_bits_uop_ppred_busy),	// execution-unit.scala:330:18
    .io_enq_bits_uop_stale_pdst                  (_ifpu_io_resp_bits_uop_stale_pdst),	// execution-unit.scala:330:18
    .io_enq_bits_uop_exception                   (_ifpu_io_resp_bits_uop_exception),	// execution-unit.scala:330:18
    .io_enq_bits_uop_exc_cause                   (_ifpu_io_resp_bits_uop_exc_cause),	// execution-unit.scala:330:18
    .io_enq_bits_uop_bypassable                  (_ifpu_io_resp_bits_uop_bypassable),	// execution-unit.scala:330:18
    .io_enq_bits_uop_mem_cmd                     (_ifpu_io_resp_bits_uop_mem_cmd),	// execution-unit.scala:330:18
    .io_enq_bits_uop_mem_size                    (_ifpu_io_resp_bits_uop_mem_size),	// execution-unit.scala:330:18
    .io_enq_bits_uop_mem_signed                  (_ifpu_io_resp_bits_uop_mem_signed),	// execution-unit.scala:330:18
    .io_enq_bits_uop_is_fence                    (_ifpu_io_resp_bits_uop_is_fence),	// execution-unit.scala:330:18
    .io_enq_bits_uop_is_fencei                   (_ifpu_io_resp_bits_uop_is_fencei),	// execution-unit.scala:330:18
    .io_enq_bits_uop_is_amo                      (_ifpu_io_resp_bits_uop_is_amo),	// execution-unit.scala:330:18
    .io_enq_bits_uop_uses_ldq                    (_ifpu_io_resp_bits_uop_uses_ldq),	// execution-unit.scala:330:18
    .io_enq_bits_uop_uses_stq                    (_ifpu_io_resp_bits_uop_uses_stq),	// execution-unit.scala:330:18
    .io_enq_bits_uop_is_sys_pc2epc               (_ifpu_io_resp_bits_uop_is_sys_pc2epc),	// execution-unit.scala:330:18
    .io_enq_bits_uop_is_unique                   (_ifpu_io_resp_bits_uop_is_unique),	// execution-unit.scala:330:18
    .io_enq_bits_uop_flush_on_commit             (_ifpu_io_resp_bits_uop_flush_on_commit),	// execution-unit.scala:330:18
    .io_enq_bits_uop_ldst_is_rs1                 (_ifpu_io_resp_bits_uop_ldst_is_rs1),	// execution-unit.scala:330:18
    .io_enq_bits_uop_ldst                        (_ifpu_io_resp_bits_uop_ldst),	// execution-unit.scala:330:18
    .io_enq_bits_uop_lrs1                        (_ifpu_io_resp_bits_uop_lrs1),	// execution-unit.scala:330:18
    .io_enq_bits_uop_lrs2                        (_ifpu_io_resp_bits_uop_lrs2),	// execution-unit.scala:330:18
    .io_enq_bits_uop_lrs3                        (_ifpu_io_resp_bits_uop_lrs3),	// execution-unit.scala:330:18
    .io_enq_bits_uop_ldst_val                    (_ifpu_io_resp_bits_uop_ldst_val),	// execution-unit.scala:330:18
    .io_enq_bits_uop_dst_rtype                   (_ifpu_io_resp_bits_uop_dst_rtype),	// execution-unit.scala:330:18
    .io_enq_bits_uop_lrs1_rtype                  (_ifpu_io_resp_bits_uop_lrs1_rtype),	// execution-unit.scala:330:18
    .io_enq_bits_uop_lrs2_rtype                  (_ifpu_io_resp_bits_uop_lrs2_rtype),	// execution-unit.scala:330:18
    .io_enq_bits_uop_frs3_en                     (_ifpu_io_resp_bits_uop_frs3_en),	// execution-unit.scala:330:18
    .io_enq_bits_uop_fp_val                      (_ifpu_io_resp_bits_uop_fp_val),	// execution-unit.scala:330:18
    .io_enq_bits_uop_fp_single                   (_ifpu_io_resp_bits_uop_fp_single),	// execution-unit.scala:330:18
    .io_enq_bits_uop_xcpt_pf_if                  (_ifpu_io_resp_bits_uop_xcpt_pf_if),	// execution-unit.scala:330:18
    .io_enq_bits_uop_xcpt_ae_if                  (_ifpu_io_resp_bits_uop_xcpt_ae_if),	// execution-unit.scala:330:18
    .io_enq_bits_uop_xcpt_ma_if                  (_ifpu_io_resp_bits_uop_xcpt_ma_if),	// execution-unit.scala:330:18
    .io_enq_bits_uop_bp_debug_if                 (_ifpu_io_resp_bits_uop_bp_debug_if),	// execution-unit.scala:330:18
    .io_enq_bits_uop_bp_xcpt_if                  (_ifpu_io_resp_bits_uop_bp_xcpt_if),	// execution-unit.scala:330:18
    .io_enq_bits_uop_debug_fsrc                  (_ifpu_io_resp_bits_uop_debug_fsrc),	// execution-unit.scala:330:18
    .io_enq_bits_uop_debug_tsrc                  (_ifpu_io_resp_bits_uop_debug_tsrc),	// execution-unit.scala:330:18
    .io_enq_bits_data                            (_ifpu_io_resp_bits_data),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_valid                    (_ifpu_io_resp_bits_fflags_valid),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_uopc
      (_ifpu_io_resp_bits_fflags_bits_uop_uopc),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_inst
      (_ifpu_io_resp_bits_fflags_bits_uop_inst),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_debug_inst
      (_ifpu_io_resp_bits_fflags_bits_uop_debug_inst),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_is_rvc
      (_ifpu_io_resp_bits_fflags_bits_uop_is_rvc),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_debug_pc
      (_ifpu_io_resp_bits_fflags_bits_uop_debug_pc),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_iq_type
      (_ifpu_io_resp_bits_fflags_bits_uop_iq_type),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_fu_code
      (_ifpu_io_resp_bits_fflags_bits_uop_fu_code),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_ctrl_br_type
      (_ifpu_io_resp_bits_fflags_bits_uop_ctrl_br_type),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_ctrl_op1_sel
      (_ifpu_io_resp_bits_fflags_bits_uop_ctrl_op1_sel),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_ctrl_op2_sel
      (_ifpu_io_resp_bits_fflags_bits_uop_ctrl_op2_sel),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_ctrl_imm_sel
      (_ifpu_io_resp_bits_fflags_bits_uop_ctrl_imm_sel),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_ctrl_op_fcn
      (_ifpu_io_resp_bits_fflags_bits_uop_ctrl_op_fcn),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_ctrl_fcn_dw
      (_ifpu_io_resp_bits_fflags_bits_uop_ctrl_fcn_dw),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_ctrl_csr_cmd
      (_ifpu_io_resp_bits_fflags_bits_uop_ctrl_csr_cmd),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_ctrl_is_load
      (_ifpu_io_resp_bits_fflags_bits_uop_ctrl_is_load),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_ctrl_is_sta
      (_ifpu_io_resp_bits_fflags_bits_uop_ctrl_is_sta),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_ctrl_is_std
      (_ifpu_io_resp_bits_fflags_bits_uop_ctrl_is_std),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_iw_state
      (_ifpu_io_resp_bits_fflags_bits_uop_iw_state),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_iw_p1_poisoned
      (_ifpu_io_resp_bits_fflags_bits_uop_iw_p1_poisoned),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_iw_p2_poisoned
      (_ifpu_io_resp_bits_fflags_bits_uop_iw_p2_poisoned),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_is_br
      (_ifpu_io_resp_bits_fflags_bits_uop_is_br),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_is_jalr
      (_ifpu_io_resp_bits_fflags_bits_uop_is_jalr),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_is_jal
      (_ifpu_io_resp_bits_fflags_bits_uop_is_jal),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_is_sfb
      (_ifpu_io_resp_bits_fflags_bits_uop_is_sfb),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_br_mask
      (_ifpu_io_resp_bits_fflags_bits_uop_br_mask),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_br_tag
      (_ifpu_io_resp_bits_fflags_bits_uop_br_tag),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_ftq_idx
      (_ifpu_io_resp_bits_fflags_bits_uop_ftq_idx),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_edge_inst
      (_ifpu_io_resp_bits_fflags_bits_uop_edge_inst),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_pc_lob
      (_ifpu_io_resp_bits_fflags_bits_uop_pc_lob),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_taken
      (_ifpu_io_resp_bits_fflags_bits_uop_taken),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_imm_packed
      (_ifpu_io_resp_bits_fflags_bits_uop_imm_packed),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_csr_addr
      (_ifpu_io_resp_bits_fflags_bits_uop_csr_addr),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_rob_idx
      (_ifpu_io_resp_bits_fflags_bits_uop_rob_idx),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_ldq_idx
      (_ifpu_io_resp_bits_fflags_bits_uop_ldq_idx),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_stq_idx
      (_ifpu_io_resp_bits_fflags_bits_uop_stq_idx),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_rxq_idx
      (_ifpu_io_resp_bits_fflags_bits_uop_rxq_idx),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_pdst
      (_ifpu_io_resp_bits_fflags_bits_uop_pdst),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_prs1
      (_ifpu_io_resp_bits_fflags_bits_uop_prs1),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_prs2
      (_ifpu_io_resp_bits_fflags_bits_uop_prs2),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_prs3
      (_ifpu_io_resp_bits_fflags_bits_uop_prs3),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_ppred
      (_ifpu_io_resp_bits_fflags_bits_uop_ppred),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_prs1_busy
      (_ifpu_io_resp_bits_fflags_bits_uop_prs1_busy),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_prs2_busy
      (_ifpu_io_resp_bits_fflags_bits_uop_prs2_busy),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_prs3_busy
      (_ifpu_io_resp_bits_fflags_bits_uop_prs3_busy),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_ppred_busy
      (_ifpu_io_resp_bits_fflags_bits_uop_ppred_busy),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_stale_pdst
      (_ifpu_io_resp_bits_fflags_bits_uop_stale_pdst),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_exception
      (_ifpu_io_resp_bits_fflags_bits_uop_exception),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_exc_cause
      (_ifpu_io_resp_bits_fflags_bits_uop_exc_cause),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_bypassable
      (_ifpu_io_resp_bits_fflags_bits_uop_bypassable),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_mem_cmd
      (_ifpu_io_resp_bits_fflags_bits_uop_mem_cmd),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_mem_size
      (_ifpu_io_resp_bits_fflags_bits_uop_mem_size),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_mem_signed
      (_ifpu_io_resp_bits_fflags_bits_uop_mem_signed),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_is_fence
      (_ifpu_io_resp_bits_fflags_bits_uop_is_fence),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_is_fencei
      (_ifpu_io_resp_bits_fflags_bits_uop_is_fencei),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_is_amo
      (_ifpu_io_resp_bits_fflags_bits_uop_is_amo),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_uses_ldq
      (_ifpu_io_resp_bits_fflags_bits_uop_uses_ldq),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_uses_stq
      (_ifpu_io_resp_bits_fflags_bits_uop_uses_stq),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_is_sys_pc2epc
      (_ifpu_io_resp_bits_fflags_bits_uop_is_sys_pc2epc),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_is_unique
      (_ifpu_io_resp_bits_fflags_bits_uop_is_unique),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_flush_on_commit
      (_ifpu_io_resp_bits_fflags_bits_uop_flush_on_commit),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_ldst_is_rs1
      (_ifpu_io_resp_bits_fflags_bits_uop_ldst_is_rs1),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_ldst
      (_ifpu_io_resp_bits_fflags_bits_uop_ldst),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_lrs1
      (_ifpu_io_resp_bits_fflags_bits_uop_lrs1),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_lrs2
      (_ifpu_io_resp_bits_fflags_bits_uop_lrs2),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_lrs3
      (_ifpu_io_resp_bits_fflags_bits_uop_lrs3),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_ldst_val
      (_ifpu_io_resp_bits_fflags_bits_uop_ldst_val),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_dst_rtype
      (_ifpu_io_resp_bits_fflags_bits_uop_dst_rtype),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_lrs1_rtype
      (_ifpu_io_resp_bits_fflags_bits_uop_lrs1_rtype),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_lrs2_rtype
      (_ifpu_io_resp_bits_fflags_bits_uop_lrs2_rtype),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_frs3_en
      (_ifpu_io_resp_bits_fflags_bits_uop_frs3_en),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_fp_val
      (_ifpu_io_resp_bits_fflags_bits_uop_fp_val),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_fp_single
      (_ifpu_io_resp_bits_fflags_bits_uop_fp_single),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_xcpt_pf_if
      (_ifpu_io_resp_bits_fflags_bits_uop_xcpt_pf_if),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_xcpt_ae_if
      (_ifpu_io_resp_bits_fflags_bits_uop_xcpt_ae_if),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_xcpt_ma_if
      (_ifpu_io_resp_bits_fflags_bits_uop_xcpt_ma_if),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_bp_debug_if
      (_ifpu_io_resp_bits_fflags_bits_uop_bp_debug_if),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_bp_xcpt_if
      (_ifpu_io_resp_bits_fflags_bits_uop_bp_xcpt_if),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_debug_fsrc
      (_ifpu_io_resp_bits_fflags_bits_uop_debug_fsrc),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_uop_debug_tsrc
      (_ifpu_io_resp_bits_fflags_bits_uop_debug_tsrc),	// execution-unit.scala:330:18
    .io_enq_bits_fflags_bits_flags               (_ifpu_io_resp_bits_fflags_bits_flags),	// execution-unit.scala:330:18
    .io_deq_ready                                (io_ll_fresp_ready),
    .io_brupdate_b1_resolve_mask                 (io_brupdate_b1_resolve_mask),
    .io_brupdate_b1_mispredict_mask              (io_brupdate_b1_mispredict_mask),
    .io_flush                                    (io_req_bits_kill),
    .io_enq_ready                                (_queue_io_enq_ready),
    .io_deq_valid                                (io_ll_fresp_valid),
    .io_deq_bits_uop_uopc                        (io_ll_fresp_bits_uop_uopc),
    .io_deq_bits_uop_br_mask                     (io_ll_fresp_bits_uop_br_mask),
    .io_deq_bits_uop_rob_idx                     (io_ll_fresp_bits_uop_rob_idx),
    .io_deq_bits_uop_stq_idx                     (io_ll_fresp_bits_uop_stq_idx),
    .io_deq_bits_uop_pdst                        (io_ll_fresp_bits_uop_pdst),
    .io_deq_bits_uop_is_amo                      (io_ll_fresp_bits_uop_is_amo),
    .io_deq_bits_uop_uses_stq                    (io_ll_fresp_bits_uop_uses_stq),
    .io_deq_bits_uop_dst_rtype                   (io_ll_fresp_bits_uop_dst_rtype),
    .io_deq_bits_uop_fp_val                      (io_ll_fresp_bits_uop_fp_val),
    .io_deq_bits_data                            (io_ll_fresp_bits_data),
    .io_deq_bits_predicated                      (io_ll_fresp_bits_predicated),
    .io_deq_bits_fflags_valid                    (io_ll_fresp_bits_fflags_valid),
    .io_deq_bits_fflags_bits_uop_rob_idx
      (io_ll_fresp_bits_fflags_bits_uop_rob_idx),
    .io_deq_bits_fflags_bits_flags               (io_ll_fresp_bits_fflags_bits_flags),
    .io_empty                                    (_queue_io_empty)
  );
  assign io_fu_types = {1'h0, _queue_io_empty, 8'h21};	// execution-unit.scala:255:49, :256:21, :284:15, :338:23
  assign io_iresp_bits_uop_csr_addr = _alu_io_resp_bits_uop_imm_packed[19:8];	// execution-unit.scala:262:17, :411:34
  assign io_iresp_bits_data = {1'h0, _alu_io_resp_bits_data};	// execution-unit.scala:262:17, :284:15, :403:24
  assign io_bypass_0_valid = _GEN;	// execution-unit.scala:266:20
  assign io_bypass_0_bits_data = {1'h0, _alu_io_bypass_0_bits_data};	// execution-unit.scala:262:17, :284:15
endmodule

