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

module FetchBuffer(
  input         clock,
                reset,
                io_enq_valid,
  input  [39:0] io_enq_bits_pc,
  input         io_enq_bits_edge_inst_0,
                io_enq_bits_edge_inst_1,
  input  [31:0] io_enq_bits_insts_0,
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
  input         io_enq_bits_shadowed_mask_0,
                io_enq_bits_shadowed_mask_1,
                io_enq_bits_shadowed_mask_2,
                io_enq_bits_shadowed_mask_3,
                io_enq_bits_shadowed_mask_4,
                io_enq_bits_shadowed_mask_5,
                io_enq_bits_shadowed_mask_6,
                io_enq_bits_shadowed_mask_7,
                io_enq_bits_cfi_idx_valid,
  input  [2:0]  io_enq_bits_cfi_idx_bits,
  input  [5:0]  io_enq_bits_ftq_idx,
  input  [7:0]  io_enq_bits_mask,
  input         io_enq_bits_xcpt_pf_if,
                io_enq_bits_xcpt_ae_if,
                io_enq_bits_bp_debug_if_oh_0,
                io_enq_bits_bp_debug_if_oh_1,
                io_enq_bits_bp_debug_if_oh_2,
                io_enq_bits_bp_debug_if_oh_3,
                io_enq_bits_bp_debug_if_oh_4,
                io_enq_bits_bp_debug_if_oh_5,
                io_enq_bits_bp_debug_if_oh_6,
                io_enq_bits_bp_debug_if_oh_7,
                io_enq_bits_bp_xcpt_if_oh_0,
                io_enq_bits_bp_xcpt_if_oh_1,
                io_enq_bits_bp_xcpt_if_oh_2,
                io_enq_bits_bp_xcpt_if_oh_3,
                io_enq_bits_bp_xcpt_if_oh_4,
                io_enq_bits_bp_xcpt_if_oh_5,
                io_enq_bits_bp_xcpt_if_oh_6,
                io_enq_bits_bp_xcpt_if_oh_7,
  input  [1:0]  io_enq_bits_fsrc,
  input         io_deq_ready,
                io_clear,
  output        io_enq_ready,
                io_deq_valid,
                io_deq_bits_uops_0_valid,
  output [31:0] io_deq_bits_uops_0_bits_inst,
                io_deq_bits_uops_0_bits_debug_inst,
  output        io_deq_bits_uops_0_bits_is_rvc,
  output [39:0] io_deq_bits_uops_0_bits_debug_pc,
  output [3:0]  io_deq_bits_uops_0_bits_ctrl_br_type,
  output [1:0]  io_deq_bits_uops_0_bits_ctrl_op1_sel,
  output [2:0]  io_deq_bits_uops_0_bits_ctrl_op2_sel,
                io_deq_bits_uops_0_bits_ctrl_imm_sel,
  output [3:0]  io_deq_bits_uops_0_bits_ctrl_op_fcn,
  output        io_deq_bits_uops_0_bits_ctrl_fcn_dw,
  output [2:0]  io_deq_bits_uops_0_bits_ctrl_csr_cmd,
  output        io_deq_bits_uops_0_bits_ctrl_is_load,
                io_deq_bits_uops_0_bits_ctrl_is_sta,
                io_deq_bits_uops_0_bits_ctrl_is_std,
  output [1:0]  io_deq_bits_uops_0_bits_iw_state,
  output        io_deq_bits_uops_0_bits_iw_p1_poisoned,
                io_deq_bits_uops_0_bits_iw_p2_poisoned,
                io_deq_bits_uops_0_bits_is_sfb,
  output [5:0]  io_deq_bits_uops_0_bits_ftq_idx,
  output        io_deq_bits_uops_0_bits_edge_inst,
  output [5:0]  io_deq_bits_uops_0_bits_pc_lob,
  output        io_deq_bits_uops_0_bits_taken,
  output [11:0] io_deq_bits_uops_0_bits_csr_addr,
  output [1:0]  io_deq_bits_uops_0_bits_rxq_idx,
  output        io_deq_bits_uops_0_bits_xcpt_pf_if,
                io_deq_bits_uops_0_bits_xcpt_ae_if,
                io_deq_bits_uops_0_bits_xcpt_ma_if,
                io_deq_bits_uops_0_bits_bp_debug_if,
                io_deq_bits_uops_0_bits_bp_xcpt_if,
  output [1:0]  io_deq_bits_uops_0_bits_debug_fsrc,
                io_deq_bits_uops_0_bits_debug_tsrc,
  output        io_deq_bits_uops_1_valid,
  output [31:0] io_deq_bits_uops_1_bits_inst,
                io_deq_bits_uops_1_bits_debug_inst,
  output        io_deq_bits_uops_1_bits_is_rvc,
  output [39:0] io_deq_bits_uops_1_bits_debug_pc,
  output [3:0]  io_deq_bits_uops_1_bits_ctrl_br_type,
  output [1:0]  io_deq_bits_uops_1_bits_ctrl_op1_sel,
  output [2:0]  io_deq_bits_uops_1_bits_ctrl_op2_sel,
                io_deq_bits_uops_1_bits_ctrl_imm_sel,
  output [3:0]  io_deq_bits_uops_1_bits_ctrl_op_fcn,
  output        io_deq_bits_uops_1_bits_ctrl_fcn_dw,
  output [2:0]  io_deq_bits_uops_1_bits_ctrl_csr_cmd,
  output        io_deq_bits_uops_1_bits_ctrl_is_load,
                io_deq_bits_uops_1_bits_ctrl_is_sta,
                io_deq_bits_uops_1_bits_ctrl_is_std,
  output [1:0]  io_deq_bits_uops_1_bits_iw_state,
  output        io_deq_bits_uops_1_bits_iw_p1_poisoned,
                io_deq_bits_uops_1_bits_iw_p2_poisoned,
                io_deq_bits_uops_1_bits_is_sfb,
  output [5:0]  io_deq_bits_uops_1_bits_ftq_idx,
  output        io_deq_bits_uops_1_bits_edge_inst,
  output [5:0]  io_deq_bits_uops_1_bits_pc_lob,
  output        io_deq_bits_uops_1_bits_taken,
  output [11:0] io_deq_bits_uops_1_bits_csr_addr,
  output [1:0]  io_deq_bits_uops_1_bits_rxq_idx,
  output        io_deq_bits_uops_1_bits_xcpt_pf_if,
                io_deq_bits_uops_1_bits_xcpt_ae_if,
                io_deq_bits_uops_1_bits_xcpt_ma_if,
                io_deq_bits_uops_1_bits_bp_debug_if,
                io_deq_bits_uops_1_bits_bp_xcpt_if,
  output [1:0]  io_deq_bits_uops_1_bits_debug_fsrc,
                io_deq_bits_uops_1_bits_debug_tsrc,
  output        io_deq_bits_uops_2_valid,
  output [31:0] io_deq_bits_uops_2_bits_inst,
                io_deq_bits_uops_2_bits_debug_inst,
  output        io_deq_bits_uops_2_bits_is_rvc,
  output [39:0] io_deq_bits_uops_2_bits_debug_pc,
  output [3:0]  io_deq_bits_uops_2_bits_ctrl_br_type,
  output [1:0]  io_deq_bits_uops_2_bits_ctrl_op1_sel,
  output [2:0]  io_deq_bits_uops_2_bits_ctrl_op2_sel,
                io_deq_bits_uops_2_bits_ctrl_imm_sel,
  output [3:0]  io_deq_bits_uops_2_bits_ctrl_op_fcn,
  output        io_deq_bits_uops_2_bits_ctrl_fcn_dw,
  output [2:0]  io_deq_bits_uops_2_bits_ctrl_csr_cmd,
  output        io_deq_bits_uops_2_bits_ctrl_is_load,
                io_deq_bits_uops_2_bits_ctrl_is_sta,
                io_deq_bits_uops_2_bits_ctrl_is_std,
  output [1:0]  io_deq_bits_uops_2_bits_iw_state,
  output        io_deq_bits_uops_2_bits_iw_p1_poisoned,
                io_deq_bits_uops_2_bits_iw_p2_poisoned,
                io_deq_bits_uops_2_bits_is_sfb,
  output [5:0]  io_deq_bits_uops_2_bits_ftq_idx,
  output        io_deq_bits_uops_2_bits_edge_inst,
  output [5:0]  io_deq_bits_uops_2_bits_pc_lob,
  output        io_deq_bits_uops_2_bits_taken,
  output [11:0] io_deq_bits_uops_2_bits_csr_addr,
  output [1:0]  io_deq_bits_uops_2_bits_rxq_idx,
  output        io_deq_bits_uops_2_bits_xcpt_pf_if,
                io_deq_bits_uops_2_bits_xcpt_ae_if,
                io_deq_bits_uops_2_bits_xcpt_ma_if,
                io_deq_bits_uops_2_bits_bp_debug_if,
                io_deq_bits_uops_2_bits_bp_xcpt_if,
  output [1:0]  io_deq_bits_uops_2_bits_debug_fsrc,
                io_deq_bits_uops_2_bits_debug_tsrc,
  output        io_deq_bits_uops_3_valid,
  output [31:0] io_deq_bits_uops_3_bits_inst,
                io_deq_bits_uops_3_bits_debug_inst,
  output        io_deq_bits_uops_3_bits_is_rvc,
  output [39:0] io_deq_bits_uops_3_bits_debug_pc,
  output [3:0]  io_deq_bits_uops_3_bits_ctrl_br_type,
  output [1:0]  io_deq_bits_uops_3_bits_ctrl_op1_sel,
  output [2:0]  io_deq_bits_uops_3_bits_ctrl_op2_sel,
                io_deq_bits_uops_3_bits_ctrl_imm_sel,
  output [3:0]  io_deq_bits_uops_3_bits_ctrl_op_fcn,
  output        io_deq_bits_uops_3_bits_ctrl_fcn_dw,
  output [2:0]  io_deq_bits_uops_3_bits_ctrl_csr_cmd,
  output        io_deq_bits_uops_3_bits_ctrl_is_load,
                io_deq_bits_uops_3_bits_ctrl_is_sta,
                io_deq_bits_uops_3_bits_ctrl_is_std,
  output [1:0]  io_deq_bits_uops_3_bits_iw_state,
  output        io_deq_bits_uops_3_bits_iw_p1_poisoned,
                io_deq_bits_uops_3_bits_iw_p2_poisoned,
                io_deq_bits_uops_3_bits_is_sfb,
  output [5:0]  io_deq_bits_uops_3_bits_ftq_idx,
  output        io_deq_bits_uops_3_bits_edge_inst,
  output [5:0]  io_deq_bits_uops_3_bits_pc_lob,
  output        io_deq_bits_uops_3_bits_taken,
  output [11:0] io_deq_bits_uops_3_bits_csr_addr,
  output [1:0]  io_deq_bits_uops_3_bits_rxq_idx,
  output        io_deq_bits_uops_3_bits_xcpt_pf_if,
                io_deq_bits_uops_3_bits_xcpt_ae_if,
                io_deq_bits_uops_3_bits_xcpt_ma_if,
                io_deq_bits_uops_3_bits_bp_debug_if,
                io_deq_bits_uops_3_bits_bp_xcpt_if,
  output [1:0]  io_deq_bits_uops_3_bits_debug_fsrc,
                io_deq_bits_uops_3_bits_debug_tsrc
);

  reg  [31:0] fb_uop_ram_0_inst;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_0_debug_inst;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_0_is_rvc;	// fetch-buffer.scala:57:16
  reg  [39:0] fb_uop_ram_0_debug_pc;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_0_ctrl_br_type;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_0_ctrl_op1_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_0_ctrl_op2_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_0_ctrl_imm_sel;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_0_ctrl_op_fcn;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_0_ctrl_fcn_dw;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_0_ctrl_csr_cmd;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_0_ctrl_is_load;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_0_ctrl_is_sta;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_0_ctrl_is_std;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_0_iw_state;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_0_iw_p1_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_0_iw_p2_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_0_is_sfb;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_0_ftq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_0_edge_inst;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_0_pc_lob;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_0_taken;	// fetch-buffer.scala:57:16
  reg  [11:0] fb_uop_ram_0_csr_addr;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_0_rxq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_0_xcpt_pf_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_0_xcpt_ae_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_0_xcpt_ma_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_0_bp_debug_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_0_bp_xcpt_if;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_0_debug_fsrc;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_0_debug_tsrc;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_1_inst;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_1_debug_inst;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_1_is_rvc;	// fetch-buffer.scala:57:16
  reg  [39:0] fb_uop_ram_1_debug_pc;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_1_ctrl_br_type;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_1_ctrl_op1_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_1_ctrl_op2_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_1_ctrl_imm_sel;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_1_ctrl_op_fcn;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_1_ctrl_fcn_dw;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_1_ctrl_csr_cmd;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_1_ctrl_is_load;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_1_ctrl_is_sta;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_1_ctrl_is_std;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_1_iw_state;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_1_iw_p1_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_1_iw_p2_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_1_is_sfb;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_1_ftq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_1_edge_inst;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_1_pc_lob;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_1_taken;	// fetch-buffer.scala:57:16
  reg  [11:0] fb_uop_ram_1_csr_addr;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_1_rxq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_1_xcpt_pf_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_1_xcpt_ae_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_1_xcpt_ma_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_1_bp_debug_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_1_bp_xcpt_if;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_1_debug_fsrc;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_1_debug_tsrc;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_2_inst;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_2_debug_inst;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_2_is_rvc;	// fetch-buffer.scala:57:16
  reg  [39:0] fb_uop_ram_2_debug_pc;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_2_ctrl_br_type;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_2_ctrl_op1_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_2_ctrl_op2_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_2_ctrl_imm_sel;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_2_ctrl_op_fcn;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_2_ctrl_fcn_dw;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_2_ctrl_csr_cmd;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_2_ctrl_is_load;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_2_ctrl_is_sta;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_2_ctrl_is_std;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_2_iw_state;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_2_iw_p1_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_2_iw_p2_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_2_is_sfb;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_2_ftq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_2_edge_inst;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_2_pc_lob;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_2_taken;	// fetch-buffer.scala:57:16
  reg  [11:0] fb_uop_ram_2_csr_addr;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_2_rxq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_2_xcpt_pf_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_2_xcpt_ae_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_2_xcpt_ma_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_2_bp_debug_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_2_bp_xcpt_if;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_2_debug_fsrc;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_2_debug_tsrc;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_3_inst;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_3_debug_inst;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_3_is_rvc;	// fetch-buffer.scala:57:16
  reg  [39:0] fb_uop_ram_3_debug_pc;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_3_ctrl_br_type;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_3_ctrl_op1_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_3_ctrl_op2_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_3_ctrl_imm_sel;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_3_ctrl_op_fcn;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_3_ctrl_fcn_dw;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_3_ctrl_csr_cmd;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_3_ctrl_is_load;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_3_ctrl_is_sta;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_3_ctrl_is_std;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_3_iw_state;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_3_iw_p1_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_3_iw_p2_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_3_is_sfb;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_3_ftq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_3_edge_inst;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_3_pc_lob;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_3_taken;	// fetch-buffer.scala:57:16
  reg  [11:0] fb_uop_ram_3_csr_addr;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_3_rxq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_3_xcpt_pf_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_3_xcpt_ae_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_3_xcpt_ma_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_3_bp_debug_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_3_bp_xcpt_if;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_3_debug_fsrc;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_3_debug_tsrc;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_4_inst;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_4_debug_inst;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_4_is_rvc;	// fetch-buffer.scala:57:16
  reg  [39:0] fb_uop_ram_4_debug_pc;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_4_ctrl_br_type;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_4_ctrl_op1_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_4_ctrl_op2_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_4_ctrl_imm_sel;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_4_ctrl_op_fcn;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_4_ctrl_fcn_dw;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_4_ctrl_csr_cmd;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_4_ctrl_is_load;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_4_ctrl_is_sta;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_4_ctrl_is_std;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_4_iw_state;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_4_iw_p1_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_4_iw_p2_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_4_is_sfb;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_4_ftq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_4_edge_inst;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_4_pc_lob;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_4_taken;	// fetch-buffer.scala:57:16
  reg  [11:0] fb_uop_ram_4_csr_addr;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_4_rxq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_4_xcpt_pf_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_4_xcpt_ae_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_4_xcpt_ma_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_4_bp_debug_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_4_bp_xcpt_if;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_4_debug_fsrc;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_4_debug_tsrc;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_5_inst;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_5_debug_inst;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_5_is_rvc;	// fetch-buffer.scala:57:16
  reg  [39:0] fb_uop_ram_5_debug_pc;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_5_ctrl_br_type;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_5_ctrl_op1_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_5_ctrl_op2_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_5_ctrl_imm_sel;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_5_ctrl_op_fcn;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_5_ctrl_fcn_dw;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_5_ctrl_csr_cmd;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_5_ctrl_is_load;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_5_ctrl_is_sta;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_5_ctrl_is_std;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_5_iw_state;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_5_iw_p1_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_5_iw_p2_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_5_is_sfb;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_5_ftq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_5_edge_inst;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_5_pc_lob;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_5_taken;	// fetch-buffer.scala:57:16
  reg  [11:0] fb_uop_ram_5_csr_addr;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_5_rxq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_5_xcpt_pf_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_5_xcpt_ae_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_5_xcpt_ma_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_5_bp_debug_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_5_bp_xcpt_if;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_5_debug_fsrc;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_5_debug_tsrc;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_6_inst;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_6_debug_inst;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_6_is_rvc;	// fetch-buffer.scala:57:16
  reg  [39:0] fb_uop_ram_6_debug_pc;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_6_ctrl_br_type;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_6_ctrl_op1_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_6_ctrl_op2_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_6_ctrl_imm_sel;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_6_ctrl_op_fcn;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_6_ctrl_fcn_dw;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_6_ctrl_csr_cmd;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_6_ctrl_is_load;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_6_ctrl_is_sta;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_6_ctrl_is_std;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_6_iw_state;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_6_iw_p1_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_6_iw_p2_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_6_is_sfb;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_6_ftq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_6_edge_inst;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_6_pc_lob;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_6_taken;	// fetch-buffer.scala:57:16
  reg  [11:0] fb_uop_ram_6_csr_addr;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_6_rxq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_6_xcpt_pf_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_6_xcpt_ae_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_6_xcpt_ma_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_6_bp_debug_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_6_bp_xcpt_if;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_6_debug_fsrc;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_6_debug_tsrc;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_7_inst;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_7_debug_inst;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_7_is_rvc;	// fetch-buffer.scala:57:16
  reg  [39:0] fb_uop_ram_7_debug_pc;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_7_ctrl_br_type;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_7_ctrl_op1_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_7_ctrl_op2_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_7_ctrl_imm_sel;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_7_ctrl_op_fcn;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_7_ctrl_fcn_dw;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_7_ctrl_csr_cmd;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_7_ctrl_is_load;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_7_ctrl_is_sta;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_7_ctrl_is_std;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_7_iw_state;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_7_iw_p1_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_7_iw_p2_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_7_is_sfb;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_7_ftq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_7_edge_inst;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_7_pc_lob;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_7_taken;	// fetch-buffer.scala:57:16
  reg  [11:0] fb_uop_ram_7_csr_addr;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_7_rxq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_7_xcpt_pf_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_7_xcpt_ae_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_7_xcpt_ma_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_7_bp_debug_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_7_bp_xcpt_if;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_7_debug_fsrc;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_7_debug_tsrc;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_8_inst;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_8_debug_inst;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_8_is_rvc;	// fetch-buffer.scala:57:16
  reg  [39:0] fb_uop_ram_8_debug_pc;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_8_ctrl_br_type;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_8_ctrl_op1_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_8_ctrl_op2_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_8_ctrl_imm_sel;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_8_ctrl_op_fcn;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_8_ctrl_fcn_dw;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_8_ctrl_csr_cmd;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_8_ctrl_is_load;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_8_ctrl_is_sta;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_8_ctrl_is_std;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_8_iw_state;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_8_iw_p1_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_8_iw_p2_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_8_is_sfb;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_8_ftq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_8_edge_inst;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_8_pc_lob;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_8_taken;	// fetch-buffer.scala:57:16
  reg  [11:0] fb_uop_ram_8_csr_addr;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_8_rxq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_8_xcpt_pf_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_8_xcpt_ae_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_8_xcpt_ma_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_8_bp_debug_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_8_bp_xcpt_if;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_8_debug_fsrc;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_8_debug_tsrc;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_9_inst;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_9_debug_inst;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_9_is_rvc;	// fetch-buffer.scala:57:16
  reg  [39:0] fb_uop_ram_9_debug_pc;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_9_ctrl_br_type;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_9_ctrl_op1_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_9_ctrl_op2_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_9_ctrl_imm_sel;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_9_ctrl_op_fcn;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_9_ctrl_fcn_dw;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_9_ctrl_csr_cmd;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_9_ctrl_is_load;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_9_ctrl_is_sta;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_9_ctrl_is_std;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_9_iw_state;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_9_iw_p1_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_9_iw_p2_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_9_is_sfb;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_9_ftq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_9_edge_inst;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_9_pc_lob;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_9_taken;	// fetch-buffer.scala:57:16
  reg  [11:0] fb_uop_ram_9_csr_addr;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_9_rxq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_9_xcpt_pf_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_9_xcpt_ae_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_9_xcpt_ma_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_9_bp_debug_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_9_bp_xcpt_if;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_9_debug_fsrc;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_9_debug_tsrc;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_10_inst;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_10_debug_inst;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_10_is_rvc;	// fetch-buffer.scala:57:16
  reg  [39:0] fb_uop_ram_10_debug_pc;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_10_ctrl_br_type;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_10_ctrl_op1_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_10_ctrl_op2_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_10_ctrl_imm_sel;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_10_ctrl_op_fcn;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_10_ctrl_fcn_dw;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_10_ctrl_csr_cmd;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_10_ctrl_is_load;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_10_ctrl_is_sta;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_10_ctrl_is_std;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_10_iw_state;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_10_iw_p1_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_10_iw_p2_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_10_is_sfb;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_10_ftq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_10_edge_inst;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_10_pc_lob;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_10_taken;	// fetch-buffer.scala:57:16
  reg  [11:0] fb_uop_ram_10_csr_addr;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_10_rxq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_10_xcpt_pf_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_10_xcpt_ae_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_10_xcpt_ma_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_10_bp_debug_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_10_bp_xcpt_if;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_10_debug_fsrc;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_10_debug_tsrc;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_11_inst;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_11_debug_inst;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_11_is_rvc;	// fetch-buffer.scala:57:16
  reg  [39:0] fb_uop_ram_11_debug_pc;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_11_ctrl_br_type;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_11_ctrl_op1_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_11_ctrl_op2_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_11_ctrl_imm_sel;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_11_ctrl_op_fcn;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_11_ctrl_fcn_dw;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_11_ctrl_csr_cmd;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_11_ctrl_is_load;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_11_ctrl_is_sta;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_11_ctrl_is_std;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_11_iw_state;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_11_iw_p1_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_11_iw_p2_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_11_is_sfb;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_11_ftq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_11_edge_inst;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_11_pc_lob;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_11_taken;	// fetch-buffer.scala:57:16
  reg  [11:0] fb_uop_ram_11_csr_addr;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_11_rxq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_11_xcpt_pf_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_11_xcpt_ae_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_11_xcpt_ma_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_11_bp_debug_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_11_bp_xcpt_if;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_11_debug_fsrc;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_11_debug_tsrc;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_12_inst;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_12_debug_inst;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_12_is_rvc;	// fetch-buffer.scala:57:16
  reg  [39:0] fb_uop_ram_12_debug_pc;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_12_ctrl_br_type;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_12_ctrl_op1_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_12_ctrl_op2_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_12_ctrl_imm_sel;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_12_ctrl_op_fcn;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_12_ctrl_fcn_dw;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_12_ctrl_csr_cmd;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_12_ctrl_is_load;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_12_ctrl_is_sta;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_12_ctrl_is_std;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_12_iw_state;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_12_iw_p1_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_12_iw_p2_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_12_is_sfb;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_12_ftq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_12_edge_inst;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_12_pc_lob;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_12_taken;	// fetch-buffer.scala:57:16
  reg  [11:0] fb_uop_ram_12_csr_addr;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_12_rxq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_12_xcpt_pf_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_12_xcpt_ae_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_12_xcpt_ma_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_12_bp_debug_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_12_bp_xcpt_if;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_12_debug_fsrc;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_12_debug_tsrc;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_13_inst;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_13_debug_inst;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_13_is_rvc;	// fetch-buffer.scala:57:16
  reg  [39:0] fb_uop_ram_13_debug_pc;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_13_ctrl_br_type;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_13_ctrl_op1_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_13_ctrl_op2_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_13_ctrl_imm_sel;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_13_ctrl_op_fcn;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_13_ctrl_fcn_dw;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_13_ctrl_csr_cmd;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_13_ctrl_is_load;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_13_ctrl_is_sta;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_13_ctrl_is_std;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_13_iw_state;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_13_iw_p1_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_13_iw_p2_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_13_is_sfb;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_13_ftq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_13_edge_inst;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_13_pc_lob;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_13_taken;	// fetch-buffer.scala:57:16
  reg  [11:0] fb_uop_ram_13_csr_addr;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_13_rxq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_13_xcpt_pf_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_13_xcpt_ae_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_13_xcpt_ma_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_13_bp_debug_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_13_bp_xcpt_if;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_13_debug_fsrc;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_13_debug_tsrc;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_14_inst;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_14_debug_inst;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_14_is_rvc;	// fetch-buffer.scala:57:16
  reg  [39:0] fb_uop_ram_14_debug_pc;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_14_ctrl_br_type;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_14_ctrl_op1_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_14_ctrl_op2_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_14_ctrl_imm_sel;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_14_ctrl_op_fcn;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_14_ctrl_fcn_dw;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_14_ctrl_csr_cmd;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_14_ctrl_is_load;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_14_ctrl_is_sta;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_14_ctrl_is_std;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_14_iw_state;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_14_iw_p1_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_14_iw_p2_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_14_is_sfb;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_14_ftq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_14_edge_inst;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_14_pc_lob;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_14_taken;	// fetch-buffer.scala:57:16
  reg  [11:0] fb_uop_ram_14_csr_addr;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_14_rxq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_14_xcpt_pf_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_14_xcpt_ae_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_14_xcpt_ma_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_14_bp_debug_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_14_bp_xcpt_if;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_14_debug_fsrc;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_14_debug_tsrc;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_15_inst;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_15_debug_inst;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_15_is_rvc;	// fetch-buffer.scala:57:16
  reg  [39:0] fb_uop_ram_15_debug_pc;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_15_ctrl_br_type;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_15_ctrl_op1_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_15_ctrl_op2_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_15_ctrl_imm_sel;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_15_ctrl_op_fcn;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_15_ctrl_fcn_dw;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_15_ctrl_csr_cmd;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_15_ctrl_is_load;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_15_ctrl_is_sta;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_15_ctrl_is_std;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_15_iw_state;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_15_iw_p1_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_15_iw_p2_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_15_is_sfb;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_15_ftq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_15_edge_inst;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_15_pc_lob;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_15_taken;	// fetch-buffer.scala:57:16
  reg  [11:0] fb_uop_ram_15_csr_addr;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_15_rxq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_15_xcpt_pf_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_15_xcpt_ae_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_15_xcpt_ma_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_15_bp_debug_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_15_bp_xcpt_if;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_15_debug_fsrc;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_15_debug_tsrc;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_16_inst;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_16_debug_inst;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_16_is_rvc;	// fetch-buffer.scala:57:16
  reg  [39:0] fb_uop_ram_16_debug_pc;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_16_ctrl_br_type;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_16_ctrl_op1_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_16_ctrl_op2_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_16_ctrl_imm_sel;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_16_ctrl_op_fcn;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_16_ctrl_fcn_dw;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_16_ctrl_csr_cmd;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_16_ctrl_is_load;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_16_ctrl_is_sta;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_16_ctrl_is_std;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_16_iw_state;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_16_iw_p1_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_16_iw_p2_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_16_is_sfb;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_16_ftq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_16_edge_inst;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_16_pc_lob;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_16_taken;	// fetch-buffer.scala:57:16
  reg  [11:0] fb_uop_ram_16_csr_addr;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_16_rxq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_16_xcpt_pf_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_16_xcpt_ae_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_16_xcpt_ma_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_16_bp_debug_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_16_bp_xcpt_if;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_16_debug_fsrc;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_16_debug_tsrc;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_17_inst;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_17_debug_inst;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_17_is_rvc;	// fetch-buffer.scala:57:16
  reg  [39:0] fb_uop_ram_17_debug_pc;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_17_ctrl_br_type;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_17_ctrl_op1_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_17_ctrl_op2_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_17_ctrl_imm_sel;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_17_ctrl_op_fcn;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_17_ctrl_fcn_dw;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_17_ctrl_csr_cmd;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_17_ctrl_is_load;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_17_ctrl_is_sta;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_17_ctrl_is_std;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_17_iw_state;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_17_iw_p1_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_17_iw_p2_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_17_is_sfb;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_17_ftq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_17_edge_inst;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_17_pc_lob;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_17_taken;	// fetch-buffer.scala:57:16
  reg  [11:0] fb_uop_ram_17_csr_addr;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_17_rxq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_17_xcpt_pf_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_17_xcpt_ae_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_17_xcpt_ma_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_17_bp_debug_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_17_bp_xcpt_if;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_17_debug_fsrc;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_17_debug_tsrc;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_18_inst;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_18_debug_inst;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_18_is_rvc;	// fetch-buffer.scala:57:16
  reg  [39:0] fb_uop_ram_18_debug_pc;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_18_ctrl_br_type;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_18_ctrl_op1_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_18_ctrl_op2_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_18_ctrl_imm_sel;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_18_ctrl_op_fcn;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_18_ctrl_fcn_dw;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_18_ctrl_csr_cmd;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_18_ctrl_is_load;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_18_ctrl_is_sta;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_18_ctrl_is_std;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_18_iw_state;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_18_iw_p1_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_18_iw_p2_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_18_is_sfb;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_18_ftq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_18_edge_inst;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_18_pc_lob;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_18_taken;	// fetch-buffer.scala:57:16
  reg  [11:0] fb_uop_ram_18_csr_addr;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_18_rxq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_18_xcpt_pf_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_18_xcpt_ae_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_18_xcpt_ma_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_18_bp_debug_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_18_bp_xcpt_if;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_18_debug_fsrc;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_18_debug_tsrc;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_19_inst;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_19_debug_inst;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_19_is_rvc;	// fetch-buffer.scala:57:16
  reg  [39:0] fb_uop_ram_19_debug_pc;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_19_ctrl_br_type;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_19_ctrl_op1_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_19_ctrl_op2_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_19_ctrl_imm_sel;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_19_ctrl_op_fcn;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_19_ctrl_fcn_dw;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_19_ctrl_csr_cmd;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_19_ctrl_is_load;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_19_ctrl_is_sta;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_19_ctrl_is_std;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_19_iw_state;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_19_iw_p1_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_19_iw_p2_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_19_is_sfb;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_19_ftq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_19_edge_inst;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_19_pc_lob;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_19_taken;	// fetch-buffer.scala:57:16
  reg  [11:0] fb_uop_ram_19_csr_addr;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_19_rxq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_19_xcpt_pf_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_19_xcpt_ae_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_19_xcpt_ma_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_19_bp_debug_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_19_bp_xcpt_if;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_19_debug_fsrc;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_19_debug_tsrc;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_20_inst;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_20_debug_inst;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_20_is_rvc;	// fetch-buffer.scala:57:16
  reg  [39:0] fb_uop_ram_20_debug_pc;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_20_ctrl_br_type;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_20_ctrl_op1_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_20_ctrl_op2_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_20_ctrl_imm_sel;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_20_ctrl_op_fcn;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_20_ctrl_fcn_dw;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_20_ctrl_csr_cmd;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_20_ctrl_is_load;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_20_ctrl_is_sta;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_20_ctrl_is_std;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_20_iw_state;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_20_iw_p1_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_20_iw_p2_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_20_is_sfb;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_20_ftq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_20_edge_inst;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_20_pc_lob;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_20_taken;	// fetch-buffer.scala:57:16
  reg  [11:0] fb_uop_ram_20_csr_addr;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_20_rxq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_20_xcpt_pf_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_20_xcpt_ae_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_20_xcpt_ma_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_20_bp_debug_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_20_bp_xcpt_if;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_20_debug_fsrc;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_20_debug_tsrc;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_21_inst;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_21_debug_inst;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_21_is_rvc;	// fetch-buffer.scala:57:16
  reg  [39:0] fb_uop_ram_21_debug_pc;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_21_ctrl_br_type;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_21_ctrl_op1_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_21_ctrl_op2_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_21_ctrl_imm_sel;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_21_ctrl_op_fcn;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_21_ctrl_fcn_dw;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_21_ctrl_csr_cmd;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_21_ctrl_is_load;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_21_ctrl_is_sta;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_21_ctrl_is_std;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_21_iw_state;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_21_iw_p1_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_21_iw_p2_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_21_is_sfb;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_21_ftq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_21_edge_inst;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_21_pc_lob;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_21_taken;	// fetch-buffer.scala:57:16
  reg  [11:0] fb_uop_ram_21_csr_addr;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_21_rxq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_21_xcpt_pf_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_21_xcpt_ae_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_21_xcpt_ma_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_21_bp_debug_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_21_bp_xcpt_if;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_21_debug_fsrc;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_21_debug_tsrc;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_22_inst;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_22_debug_inst;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_22_is_rvc;	// fetch-buffer.scala:57:16
  reg  [39:0] fb_uop_ram_22_debug_pc;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_22_ctrl_br_type;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_22_ctrl_op1_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_22_ctrl_op2_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_22_ctrl_imm_sel;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_22_ctrl_op_fcn;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_22_ctrl_fcn_dw;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_22_ctrl_csr_cmd;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_22_ctrl_is_load;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_22_ctrl_is_sta;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_22_ctrl_is_std;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_22_iw_state;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_22_iw_p1_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_22_iw_p2_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_22_is_sfb;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_22_ftq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_22_edge_inst;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_22_pc_lob;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_22_taken;	// fetch-buffer.scala:57:16
  reg  [11:0] fb_uop_ram_22_csr_addr;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_22_rxq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_22_xcpt_pf_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_22_xcpt_ae_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_22_xcpt_ma_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_22_bp_debug_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_22_bp_xcpt_if;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_22_debug_fsrc;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_22_debug_tsrc;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_23_inst;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_23_debug_inst;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_23_is_rvc;	// fetch-buffer.scala:57:16
  reg  [39:0] fb_uop_ram_23_debug_pc;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_23_ctrl_br_type;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_23_ctrl_op1_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_23_ctrl_op2_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_23_ctrl_imm_sel;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_23_ctrl_op_fcn;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_23_ctrl_fcn_dw;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_23_ctrl_csr_cmd;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_23_ctrl_is_load;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_23_ctrl_is_sta;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_23_ctrl_is_std;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_23_iw_state;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_23_iw_p1_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_23_iw_p2_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_23_is_sfb;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_23_ftq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_23_edge_inst;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_23_pc_lob;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_23_taken;	// fetch-buffer.scala:57:16
  reg  [11:0] fb_uop_ram_23_csr_addr;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_23_rxq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_23_xcpt_pf_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_23_xcpt_ae_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_23_xcpt_ma_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_23_bp_debug_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_23_bp_xcpt_if;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_23_debug_fsrc;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_23_debug_tsrc;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_24_inst;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_24_debug_inst;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_24_is_rvc;	// fetch-buffer.scala:57:16
  reg  [39:0] fb_uop_ram_24_debug_pc;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_24_ctrl_br_type;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_24_ctrl_op1_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_24_ctrl_op2_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_24_ctrl_imm_sel;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_24_ctrl_op_fcn;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_24_ctrl_fcn_dw;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_24_ctrl_csr_cmd;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_24_ctrl_is_load;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_24_ctrl_is_sta;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_24_ctrl_is_std;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_24_iw_state;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_24_iw_p1_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_24_iw_p2_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_24_is_sfb;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_24_ftq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_24_edge_inst;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_24_pc_lob;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_24_taken;	// fetch-buffer.scala:57:16
  reg  [11:0] fb_uop_ram_24_csr_addr;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_24_rxq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_24_xcpt_pf_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_24_xcpt_ae_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_24_xcpt_ma_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_24_bp_debug_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_24_bp_xcpt_if;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_24_debug_fsrc;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_24_debug_tsrc;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_25_inst;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_25_debug_inst;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_25_is_rvc;	// fetch-buffer.scala:57:16
  reg  [39:0] fb_uop_ram_25_debug_pc;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_25_ctrl_br_type;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_25_ctrl_op1_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_25_ctrl_op2_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_25_ctrl_imm_sel;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_25_ctrl_op_fcn;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_25_ctrl_fcn_dw;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_25_ctrl_csr_cmd;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_25_ctrl_is_load;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_25_ctrl_is_sta;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_25_ctrl_is_std;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_25_iw_state;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_25_iw_p1_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_25_iw_p2_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_25_is_sfb;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_25_ftq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_25_edge_inst;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_25_pc_lob;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_25_taken;	// fetch-buffer.scala:57:16
  reg  [11:0] fb_uop_ram_25_csr_addr;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_25_rxq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_25_xcpt_pf_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_25_xcpt_ae_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_25_xcpt_ma_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_25_bp_debug_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_25_bp_xcpt_if;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_25_debug_fsrc;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_25_debug_tsrc;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_26_inst;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_26_debug_inst;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_26_is_rvc;	// fetch-buffer.scala:57:16
  reg  [39:0] fb_uop_ram_26_debug_pc;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_26_ctrl_br_type;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_26_ctrl_op1_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_26_ctrl_op2_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_26_ctrl_imm_sel;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_26_ctrl_op_fcn;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_26_ctrl_fcn_dw;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_26_ctrl_csr_cmd;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_26_ctrl_is_load;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_26_ctrl_is_sta;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_26_ctrl_is_std;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_26_iw_state;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_26_iw_p1_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_26_iw_p2_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_26_is_sfb;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_26_ftq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_26_edge_inst;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_26_pc_lob;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_26_taken;	// fetch-buffer.scala:57:16
  reg  [11:0] fb_uop_ram_26_csr_addr;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_26_rxq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_26_xcpt_pf_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_26_xcpt_ae_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_26_xcpt_ma_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_26_bp_debug_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_26_bp_xcpt_if;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_26_debug_fsrc;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_26_debug_tsrc;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_27_inst;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_27_debug_inst;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_27_is_rvc;	// fetch-buffer.scala:57:16
  reg  [39:0] fb_uop_ram_27_debug_pc;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_27_ctrl_br_type;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_27_ctrl_op1_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_27_ctrl_op2_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_27_ctrl_imm_sel;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_27_ctrl_op_fcn;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_27_ctrl_fcn_dw;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_27_ctrl_csr_cmd;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_27_ctrl_is_load;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_27_ctrl_is_sta;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_27_ctrl_is_std;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_27_iw_state;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_27_iw_p1_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_27_iw_p2_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_27_is_sfb;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_27_ftq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_27_edge_inst;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_27_pc_lob;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_27_taken;	// fetch-buffer.scala:57:16
  reg  [11:0] fb_uop_ram_27_csr_addr;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_27_rxq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_27_xcpt_pf_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_27_xcpt_ae_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_27_xcpt_ma_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_27_bp_debug_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_27_bp_xcpt_if;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_27_debug_fsrc;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_27_debug_tsrc;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_28_inst;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_28_debug_inst;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_28_is_rvc;	// fetch-buffer.scala:57:16
  reg  [39:0] fb_uop_ram_28_debug_pc;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_28_ctrl_br_type;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_28_ctrl_op1_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_28_ctrl_op2_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_28_ctrl_imm_sel;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_28_ctrl_op_fcn;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_28_ctrl_fcn_dw;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_28_ctrl_csr_cmd;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_28_ctrl_is_load;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_28_ctrl_is_sta;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_28_ctrl_is_std;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_28_iw_state;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_28_iw_p1_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_28_iw_p2_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_28_is_sfb;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_28_ftq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_28_edge_inst;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_28_pc_lob;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_28_taken;	// fetch-buffer.scala:57:16
  reg  [11:0] fb_uop_ram_28_csr_addr;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_28_rxq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_28_xcpt_pf_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_28_xcpt_ae_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_28_xcpt_ma_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_28_bp_debug_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_28_bp_xcpt_if;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_28_debug_fsrc;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_28_debug_tsrc;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_29_inst;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_29_debug_inst;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_29_is_rvc;	// fetch-buffer.scala:57:16
  reg  [39:0] fb_uop_ram_29_debug_pc;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_29_ctrl_br_type;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_29_ctrl_op1_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_29_ctrl_op2_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_29_ctrl_imm_sel;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_29_ctrl_op_fcn;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_29_ctrl_fcn_dw;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_29_ctrl_csr_cmd;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_29_ctrl_is_load;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_29_ctrl_is_sta;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_29_ctrl_is_std;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_29_iw_state;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_29_iw_p1_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_29_iw_p2_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_29_is_sfb;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_29_ftq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_29_edge_inst;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_29_pc_lob;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_29_taken;	// fetch-buffer.scala:57:16
  reg  [11:0] fb_uop_ram_29_csr_addr;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_29_rxq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_29_xcpt_pf_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_29_xcpt_ae_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_29_xcpt_ma_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_29_bp_debug_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_29_bp_xcpt_if;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_29_debug_fsrc;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_29_debug_tsrc;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_30_inst;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_30_debug_inst;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_30_is_rvc;	// fetch-buffer.scala:57:16
  reg  [39:0] fb_uop_ram_30_debug_pc;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_30_ctrl_br_type;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_30_ctrl_op1_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_30_ctrl_op2_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_30_ctrl_imm_sel;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_30_ctrl_op_fcn;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_30_ctrl_fcn_dw;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_30_ctrl_csr_cmd;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_30_ctrl_is_load;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_30_ctrl_is_sta;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_30_ctrl_is_std;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_30_iw_state;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_30_iw_p1_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_30_iw_p2_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_30_is_sfb;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_30_ftq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_30_edge_inst;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_30_pc_lob;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_30_taken;	// fetch-buffer.scala:57:16
  reg  [11:0] fb_uop_ram_30_csr_addr;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_30_rxq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_30_xcpt_pf_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_30_xcpt_ae_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_30_xcpt_ma_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_30_bp_debug_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_30_bp_xcpt_if;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_30_debug_fsrc;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_30_debug_tsrc;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_31_inst;	// fetch-buffer.scala:57:16
  reg  [31:0] fb_uop_ram_31_debug_inst;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_31_is_rvc;	// fetch-buffer.scala:57:16
  reg  [39:0] fb_uop_ram_31_debug_pc;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_31_ctrl_br_type;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_31_ctrl_op1_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_31_ctrl_op2_sel;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_31_ctrl_imm_sel;	// fetch-buffer.scala:57:16
  reg  [3:0]  fb_uop_ram_31_ctrl_op_fcn;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_31_ctrl_fcn_dw;	// fetch-buffer.scala:57:16
  reg  [2:0]  fb_uop_ram_31_ctrl_csr_cmd;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_31_ctrl_is_load;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_31_ctrl_is_sta;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_31_ctrl_is_std;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_31_iw_state;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_31_iw_p1_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_31_iw_p2_poisoned;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_31_is_sfb;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_31_ftq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_31_edge_inst;	// fetch-buffer.scala:57:16
  reg  [5:0]  fb_uop_ram_31_pc_lob;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_31_taken;	// fetch-buffer.scala:57:16
  reg  [11:0] fb_uop_ram_31_csr_addr;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_31_rxq_idx;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_31_xcpt_pf_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_31_xcpt_ae_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_31_xcpt_ma_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_31_bp_debug_if;	// fetch-buffer.scala:57:16
  reg         fb_uop_ram_31_bp_xcpt_if;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_31_debug_fsrc;	// fetch-buffer.scala:57:16
  reg  [1:0]  fb_uop_ram_31_debug_tsrc;	// fetch-buffer.scala:57:16
  reg  [7:0]  head;	// fetch-buffer.scala:61:21
  reg  [31:0] tail;	// fetch-buffer.scala:62:21
  reg         maybe_full;	// fetch-buffer.scala:64:27
  wire        _do_enq_T_1 =
    (|({tail[28], tail[24], tail[20], tail[16], tail[12], tail[8], tail[4], tail[0]}
       & head)) & maybe_full
    | (|(head
         & {tail[27], tail[23], tail[19], tail[15], tail[11], tail[7], tail[3], tail[31]}
         | head
         & {tail[26], tail[22], tail[18], tail[14], tail[10], tail[6], tail[2], tail[30]}
         | head
         & {tail[25], tail[21], tail[17], tail[13], tail[9], tail[5], tail[1], tail[29]}
         | head
         & {tail[24], tail[20], tail[16], tail[12], tail[8], tail[4], tail[0], tail[28]}
         | head
         & {tail[23], tail[19], tail[15], tail[11], tail[7], tail[3], tail[31], tail[27]}
         | head
         & {tail[22], tail[18], tail[14], tail[10], tail[6], tail[2], tail[30], tail[26]}
         | head
         & {tail[21],
            tail[17],
            tail[13],
            tail[9],
            tail[5],
            tail[1],
            tail[29],
            tail[25]}));	// fetch-buffer.scala:61:21, :62:21, :64:27, :75:24, :78:82, :79:{63,88,104,108}, :80:31, :81:{29,36,44}, :82:{26,40}
  wire [3:0]  slot_will_hit_tail =
    {{3{head[0]}}, head[0] & ~maybe_full} & tail[3:0]
    | {{3{head[1]}}, head[1] & ~maybe_full} & tail[7:4]
    | {{3{head[2]}}, head[2] & ~maybe_full} & tail[11:8]
    | {{3{head[3]}}, head[3] & ~maybe_full} & tail[15:12]
    | {{3{head[4]}}, head[4] & ~maybe_full} & tail[19:16]
    | {{3{head[5]}}, head[5] & ~maybe_full} & tail[23:20]
    | {{3{head[6]}}, head[6] & ~maybe_full} & tail[27:24]
    | {{3{head[7]}}, head[7] & ~maybe_full} & tail[31:28];	// fetch-buffer.scala:61:21, :62:21, :64:27, :155:{31,45,49,90,97}, :156:{70,112}
  wire [1:0]  _GEN = slot_will_hit_tail[2:1] | slot_will_hit_tail[1:0];	// fetch-buffer.scala:156:112, util.scala:384:{37,54}
  wire [3:0]  _deq_valids_T_10 =
    slot_will_hit_tail
    | {_GEN[1] | slot_will_hit_tail[0], _GEN[0], slot_will_hit_tail[0], 1'h0};	// fetch-buffer.scala:156:112, util.scala:384:{37,54}
  wire [3:0]  _deq_valids_T_11 = ~_deq_valids_T_10;	// fetch-buffer.scala:161:21, util.scala:384:54
  always @(posedge clock) begin
    automatic logic [39:0] pc;	// frontend.scala:161:39
    automatic logic        in_mask_0;	// fetch-buffer.scala:98:49
    automatic logic [39:0] _GEN_0 = {io_enq_bits_pc[39:3], 3'h0};	// fetch-buffer.scala:97:33, :107:81
    automatic logic [39:0] _in_uops_0_debug_pc_T_5;	// fetch-buffer.scala:107:81
    automatic logic [5:0]  in_uops_0_pc_lob;	// fetch-buffer.scala:101:33, :106:41, :108:32
    automatic logic        in_uops_0_is_rvc;	// fetch-buffer.scala:115:62
    automatic logic        in_uops_0_taken;	// fetch-buffer.scala:116:69
    automatic logic [39:0] _pc_T_7;	// fetch-buffer.scala:95:43
    automatic logic        in_mask_1;	// fetch-buffer.scala:98:49
    automatic logic        in_uops_1_is_rvc;	// fetch-buffer.scala:115:62
    automatic logic        in_uops_1_taken;	// fetch-buffer.scala:116:69
    automatic logic [39:0] _pc_T_11;	// fetch-buffer.scala:95:43
    automatic logic        in_mask_2;	// fetch-buffer.scala:98:49
    automatic logic        in_uops_2_is_rvc;	// fetch-buffer.scala:115:62
    automatic logic        in_uops_2_taken;	// fetch-buffer.scala:116:69
    automatic logic [39:0] _pc_T_15;	// fetch-buffer.scala:95:43
    automatic logic        in_mask_3;	// fetch-buffer.scala:98:49
    automatic logic        in_uops_3_is_rvc;	// fetch-buffer.scala:115:62
    automatic logic        in_uops_3_taken;	// fetch-buffer.scala:116:69
    automatic logic [39:0] _pc_T_19;	// fetch-buffer.scala:95:43
    automatic logic        in_mask_4;	// fetch-buffer.scala:98:49
    automatic logic [39:0] _in_uops_4_debug_pc_T_5;	// fetch-buffer.scala:107:81
    automatic logic [5:0]  _in_uops_4_pc_lob_T_3;	// fetch-buffer.scala:108:61
    automatic logic        in_uops_4_is_rvc;	// fetch-buffer.scala:115:62
    automatic logic        in_uops_4_taken;	// fetch-buffer.scala:116:69
    automatic logic [39:0] _pc_T_23;	// fetch-buffer.scala:95:43
    automatic logic        in_mask_5;	// fetch-buffer.scala:98:49
    automatic logic        in_uops_5_is_rvc;	// fetch-buffer.scala:115:62
    automatic logic        in_uops_5_taken;	// fetch-buffer.scala:116:69
    automatic logic [39:0] _pc_T_27;	// fetch-buffer.scala:95:43
    automatic logic        in_mask_6;	// fetch-buffer.scala:98:49
    automatic logic        in_uops_6_is_rvc;	// fetch-buffer.scala:115:62
    automatic logic        in_uops_6_taken;	// fetch-buffer.scala:116:69
    automatic logic [39:0] _pc_T_31;	// fetch-buffer.scala:95:43
    automatic logic        in_mask_7;	// fetch-buffer.scala:98:49
    automatic logic        in_uops_7_is_rvc;	// fetch-buffer.scala:115:62
    automatic logic        in_uops_7_taken;	// fetch-buffer.scala:116:69
    automatic logic [31:0] _GEN_1;	// Cat.scala:30:58
    automatic logic [31:0] enq_idxs_1;	// fetch-buffer.scala:138:18
    automatic logic [31:0] _GEN_2;	// Cat.scala:30:58
    automatic logic [31:0] enq_idxs_2;	// fetch-buffer.scala:138:18
    automatic logic [31:0] _GEN_3;	// Cat.scala:30:58
    automatic logic [31:0] enq_idxs_3;	// fetch-buffer.scala:138:18
    automatic logic [31:0] _GEN_4;	// Cat.scala:30:58
    automatic logic [31:0] enq_idxs_4;	// fetch-buffer.scala:138:18
    automatic logic [31:0] _GEN_5;	// Cat.scala:30:58
    automatic logic [31:0] enq_idxs_5;	// fetch-buffer.scala:138:18
    automatic logic [31:0] _GEN_6;	// Cat.scala:30:58
    automatic logic [31:0] enq_idxs_6;	// fetch-buffer.scala:138:18
    automatic logic [31:0] _GEN_7;	// Cat.scala:30:58
    automatic logic [31:0] enq_idxs_7;	// fetch-buffer.scala:138:18
    automatic logic        _GEN_8;	// fetch-buffer.scala:144:20
    automatic logic        _GEN_9;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_10;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_11;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_12;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_13;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_14;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_15;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_16;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_17;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_18;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_19;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_20;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_21;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_22;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_23;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_24;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_25;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_26;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_27;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_28;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_29;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_30;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_31;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_32;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_33;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_34;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_35;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_36;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_37;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_38;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_39;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_40;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_41;	// fetch-buffer.scala:144:20
    automatic logic        _GEN_42;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_43;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_44;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_45;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_46;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_47;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_48;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_49;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_50;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_51;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_52;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_53;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_54;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_55;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_56;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_57;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_58;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_59;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_60;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_61;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_62;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_63;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_64;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_65;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_66;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_67;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_68;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_69;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_70;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_71;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_72;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_73;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_74;	// fetch-buffer.scala:144:20
    automatic logic        _GEN_75;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_76;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_77;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_78;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_79;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_80;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_81;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_82;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_83;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_84;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_85;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_86;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_87;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_88;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_89;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_90;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_91;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_92;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_93;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_94;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_95;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_96;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_97;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_98;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_99;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_100;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_101;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_102;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_103;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_104;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_105;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_106;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_107;	// fetch-buffer.scala:144:20
    automatic logic        _GEN_108;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_109;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_110;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_111;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_112;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_113;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_114;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_115;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_116;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_117;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_118;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_119;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_120;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_121;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_122;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_123;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_124;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_125;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_126;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_127;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_128;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_129;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_130;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_131;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_132;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_133;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_134;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_135;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_136;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_137;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_138;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_139;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_140;	// fetch-buffer.scala:144:20
    automatic logic        _GEN_141;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_142;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_143;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_144;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_145;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_146;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_147;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_148;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_149;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_150;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_151;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_152;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_153;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_154;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_155;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_156;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_157;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_158;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_159;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_160;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_161;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_162;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_163;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_164;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_165;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_166;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_167;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_168;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_169;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_170;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_171;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_172;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_173;	// fetch-buffer.scala:144:20
    automatic logic        _GEN_174;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_175;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_176;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_177;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_178;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_179;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_180;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_181;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_182;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_183;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_184;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_185;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_186;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_187;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_188;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_189;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_190;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_191;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_192;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_193;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_194;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_195;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_196;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_197;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_198;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_199;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_200;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_201;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_202;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_203;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_204;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_205;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_206;	// fetch-buffer.scala:144:20
    automatic logic        _GEN_207;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_208;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_209;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_210;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_211;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_212;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_213;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_214;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_215;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_216;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_217;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_218;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_219;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_220;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_221;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_222;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_223;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_224;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_225;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_226;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_227;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_228;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_229;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_230;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_231;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_232;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_233;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_234;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_235;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_236;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_237;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_238;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_239;	// fetch-buffer.scala:144:20
    automatic logic        _GEN_240;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_241;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_242;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_243;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_244;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_245;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_246;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_247;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_248;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_249;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_250;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_251;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_252;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_253;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_254;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_255;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_256;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_257;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_258;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_259;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_260;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_261;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_262;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_263;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_264;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_265;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_266;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_267;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_268;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_269;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_270;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_271;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_272;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_273;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_274;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_275;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_276;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_277;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_278;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_279;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_280;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_281;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_282;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_283;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_284;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_285;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_286;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_287;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_288;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_289;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_290;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_291;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_292;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_293;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_294;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_295;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_296;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_297;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_298;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_299;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_300;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_301;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_302;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_303;	// fetch-buffer.scala:57:16, :144:53, :145:16
    pc = {io_enq_bits_pc[39:3], 3'h0};	// fetch-buffer.scala:97:33, frontend.scala:161:39
    in_mask_0 = io_enq_valid & io_enq_bits_mask[0];	// fetch-buffer.scala:98:{49,68}
    _in_uops_0_debug_pc_T_5 = _GEN_0 - 40'h2;	// fetch-buffer.scala:107:81
    in_uops_0_pc_lob = {io_enq_bits_pc[5:3], 3'h0};	// fetch-buffer.scala:97:33, :101:33, :106:41, :108:32
    in_uops_0_is_rvc = io_enq_bits_insts_0[1:0] != 2'h3;	// fetch-buffer.scala:115:{56,62}
    in_uops_0_taken = io_enq_bits_cfi_idx_bits == 3'h0 & io_enq_bits_cfi_idx_valid;	// fetch-buffer.scala:97:33, :116:{61,69}
    _pc_T_7 = _GEN_0 + 40'h2;	// fetch-buffer.scala:95:43, :107:81
    in_mask_1 = io_enq_valid & io_enq_bits_mask[1];	// fetch-buffer.scala:98:{49,68}
    in_uops_1_is_rvc = io_enq_bits_insts_1[1:0] != 2'h3;	// fetch-buffer.scala:115:{56,62}
    in_uops_1_taken = io_enq_bits_cfi_idx_bits == 3'h1 & io_enq_bits_cfi_idx_valid;	// fetch-buffer.scala:116:{61,69}
    _pc_T_11 = _GEN_0 + 40'h4;	// fetch-buffer.scala:95:43, :107:81
    in_mask_2 = io_enq_valid & io_enq_bits_mask[2];	// fetch-buffer.scala:98:{49,68}
    in_uops_2_is_rvc = io_enq_bits_insts_2[1:0] != 2'h3;	// fetch-buffer.scala:115:{56,62}
    in_uops_2_taken = io_enq_bits_cfi_idx_bits == 3'h2 & io_enq_bits_cfi_idx_valid;	// fetch-buffer.scala:116:{61,69}
    _pc_T_15 = _GEN_0 + 40'h6;	// fetch-buffer.scala:95:43, :107:81
    in_mask_3 = io_enq_valid & io_enq_bits_mask[3];	// fetch-buffer.scala:98:{49,68}
    in_uops_3_is_rvc = io_enq_bits_insts_3[1:0] != 2'h3;	// fetch-buffer.scala:115:{56,62}
    in_uops_3_taken = io_enq_bits_cfi_idx_bits == 3'h3 & io_enq_bits_cfi_idx_valid;	// fetch-buffer.scala:116:{61,69}
    _pc_T_19 = _GEN_0 + 40'h8;	// fetch-buffer.scala:95:43, :107:81
    in_mask_4 = io_enq_valid & io_enq_bits_mask[4];	// fetch-buffer.scala:98:{49,68}
    _in_uops_4_debug_pc_T_5 = _GEN_0 + 40'h6;	// fetch-buffer.scala:95:43, :107:81
    _in_uops_4_pc_lob_T_3 = {io_enq_bits_pc[5:3], 3'h0} + 6'h8;	// fetch-buffer.scala:95:43, :97:33, :101:33, :108:61
    in_uops_4_is_rvc = io_enq_bits_insts_4[1:0] != 2'h3;	// fetch-buffer.scala:115:{56,62}
    in_uops_4_taken = io_enq_bits_cfi_idx_bits == 3'h4 & io_enq_bits_cfi_idx_valid;	// fetch-buffer.scala:95:43, :116:{61,69}
    _pc_T_23 = _GEN_0 + 40'hA;	// fetch-buffer.scala:95:43, :107:81
    in_mask_5 = io_enq_valid & io_enq_bits_mask[5];	// fetch-buffer.scala:98:{49,68}
    in_uops_5_is_rvc = io_enq_bits_insts_5[1:0] != 2'h3;	// fetch-buffer.scala:115:{56,62}
    in_uops_5_taken = io_enq_bits_cfi_idx_bits == 3'h5 & io_enq_bits_cfi_idx_valid;	// fetch-buffer.scala:116:{61,69}
    _pc_T_27 = _GEN_0 + 40'hC;	// fetch-buffer.scala:95:43, :107:81
    in_mask_6 = io_enq_valid & io_enq_bits_mask[6];	// fetch-buffer.scala:98:{49,68}
    in_uops_6_is_rvc = io_enq_bits_insts_6[1:0] != 2'h3;	// fetch-buffer.scala:115:{56,62}
    in_uops_6_taken = io_enq_bits_cfi_idx_bits == 3'h6 & io_enq_bits_cfi_idx_valid;	// fetch-buffer.scala:95:43, :116:{61,69}
    _pc_T_31 = _GEN_0 + 40'hE;	// fetch-buffer.scala:95:43, :107:81
    in_mask_7 = io_enq_valid & io_enq_bits_mask[7];	// fetch-buffer.scala:98:{49,68}
    in_uops_7_is_rvc = io_enq_bits_insts_7[1:0] != 2'h3;	// fetch-buffer.scala:115:{56,62}
    in_uops_7_taken = (&io_enq_bits_cfi_idx_bits) & io_enq_bits_cfi_idx_valid;	// fetch-buffer.scala:116:{61,69}
    _GEN_1 = {tail[30:0], tail[31]};	// Cat.scala:30:58, fetch-buffer.scala:62:21, :75:{11,24}
    enq_idxs_1 = in_mask_0 ? _GEN_1 : tail;	// Cat.scala:30:58, fetch-buffer.scala:62:21, :98:49, :138:18
    _GEN_2 = {enq_idxs_1[30:0], enq_idxs_1[31]};	// Cat.scala:30:58, fetch-buffer.scala:132:{12,24}, :138:18
    enq_idxs_2 = in_mask_1 ? _GEN_2 : enq_idxs_1;	// Cat.scala:30:58, fetch-buffer.scala:98:49, :138:18
    _GEN_3 = {enq_idxs_2[30:0], enq_idxs_2[31]};	// Cat.scala:30:58, fetch-buffer.scala:132:{12,24}, :138:18
    enq_idxs_3 = in_mask_2 ? _GEN_3 : enq_idxs_2;	// Cat.scala:30:58, fetch-buffer.scala:98:49, :138:18
    _GEN_4 = {enq_idxs_3[30:0], enq_idxs_3[31]};	// Cat.scala:30:58, fetch-buffer.scala:132:{12,24}, :138:18
    enq_idxs_4 = in_mask_3 ? _GEN_4 : enq_idxs_3;	// Cat.scala:30:58, fetch-buffer.scala:98:49, :138:18
    _GEN_5 = {enq_idxs_4[30:0], enq_idxs_4[31]};	// Cat.scala:30:58, fetch-buffer.scala:132:{12,24}, :138:18
    enq_idxs_5 = in_mask_4 ? _GEN_5 : enq_idxs_4;	// Cat.scala:30:58, fetch-buffer.scala:98:49, :138:18
    _GEN_6 = {enq_idxs_5[30:0], enq_idxs_5[31]};	// Cat.scala:30:58, fetch-buffer.scala:132:{12,24}, :138:18
    enq_idxs_6 = in_mask_5 ? _GEN_6 : enq_idxs_5;	// Cat.scala:30:58, fetch-buffer.scala:98:49, :138:18
    _GEN_7 = {enq_idxs_6[30:0], enq_idxs_6[31]};	// Cat.scala:30:58, fetch-buffer.scala:132:{12,24}, :138:18
    enq_idxs_7 = in_mask_6 ? _GEN_7 : enq_idxs_6;	// Cat.scala:30:58, fetch-buffer.scala:98:49, :138:18
    _GEN_8 = ~_do_enq_T_1 & in_mask_0;	// fetch-buffer.scala:82:{16,40}, :98:49, :144:20
    _GEN_9 = _GEN_8 & tail[0];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_10 = _GEN_8 & tail[1];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_11 = _GEN_8 & tail[2];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_12 = _GEN_8 & tail[3];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_13 = _GEN_8 & tail[4];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_14 = _GEN_8 & tail[5];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_15 = _GEN_8 & tail[6];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_16 = _GEN_8 & tail[7];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_17 = _GEN_8 & tail[8];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_18 = _GEN_8 & tail[9];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_19 = _GEN_8 & tail[10];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_20 = _GEN_8 & tail[11];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_21 = _GEN_8 & tail[12];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_22 = _GEN_8 & tail[13];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_23 = _GEN_8 & tail[14];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_24 = _GEN_8 & tail[15];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_25 = _GEN_8 & tail[16];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_26 = _GEN_8 & tail[17];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_27 = _GEN_8 & tail[18];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_28 = _GEN_8 & tail[19];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_29 = _GEN_8 & tail[20];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_30 = _GEN_8 & tail[21];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_31 = _GEN_8 & tail[22];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_32 = _GEN_8 & tail[23];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_33 = _GEN_8 & tail[24];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_34 = _GEN_8 & tail[25];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_35 = _GEN_8 & tail[26];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_36 = _GEN_8 & tail[27];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_37 = _GEN_8 & tail[28];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_38 = _GEN_8 & tail[29];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_39 = _GEN_8 & tail[30];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_40 = _GEN_8 & tail[31];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_41 = ~_do_enq_T_1 & in_mask_1;	// fetch-buffer.scala:82:{16,40}, :98:49, :144:20
    _GEN_42 = _GEN_41 & enq_idxs_1[0];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_43 = _GEN_41 & enq_idxs_1[1];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_44 = _GEN_41 & enq_idxs_1[2];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_45 = _GEN_41 & enq_idxs_1[3];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_46 = _GEN_41 & enq_idxs_1[4];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_47 = _GEN_41 & enq_idxs_1[5];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_48 = _GEN_41 & enq_idxs_1[6];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_49 = _GEN_41 & enq_idxs_1[7];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_50 = _GEN_41 & enq_idxs_1[8];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_51 = _GEN_41 & enq_idxs_1[9];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_52 = _GEN_41 & enq_idxs_1[10];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_53 = _GEN_41 & enq_idxs_1[11];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_54 = _GEN_41 & enq_idxs_1[12];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_55 = _GEN_41 & enq_idxs_1[13];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_56 = _GEN_41 & enq_idxs_1[14];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_57 = _GEN_41 & enq_idxs_1[15];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_58 = _GEN_41 & enq_idxs_1[16];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_59 = _GEN_41 & enq_idxs_1[17];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_60 = _GEN_41 & enq_idxs_1[18];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_61 = _GEN_41 & enq_idxs_1[19];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_62 = _GEN_41 & enq_idxs_1[20];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_63 = _GEN_41 & enq_idxs_1[21];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_64 = _GEN_41 & enq_idxs_1[22];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_65 = _GEN_41 & enq_idxs_1[23];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_66 = _GEN_41 & enq_idxs_1[24];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_67 = _GEN_41 & enq_idxs_1[25];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_68 = _GEN_41 & enq_idxs_1[26];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_69 = _GEN_41 & enq_idxs_1[27];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_70 = _GEN_41 & enq_idxs_1[28];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_71 = _GEN_41 & enq_idxs_1[29];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_72 = _GEN_41 & enq_idxs_1[30];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_73 = _GEN_41 & enq_idxs_1[31];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_74 = ~_do_enq_T_1 & in_mask_2;	// fetch-buffer.scala:82:{16,40}, :98:49, :144:20
    _GEN_75 = _GEN_74 & enq_idxs_2[0];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_76 = _GEN_74 & enq_idxs_2[1];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_77 = _GEN_74 & enq_idxs_2[2];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_78 = _GEN_74 & enq_idxs_2[3];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_79 = _GEN_74 & enq_idxs_2[4];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_80 = _GEN_74 & enq_idxs_2[5];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_81 = _GEN_74 & enq_idxs_2[6];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_82 = _GEN_74 & enq_idxs_2[7];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_83 = _GEN_74 & enq_idxs_2[8];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_84 = _GEN_74 & enq_idxs_2[9];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_85 = _GEN_74 & enq_idxs_2[10];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_86 = _GEN_74 & enq_idxs_2[11];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_87 = _GEN_74 & enq_idxs_2[12];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_88 = _GEN_74 & enq_idxs_2[13];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_89 = _GEN_74 & enq_idxs_2[14];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_90 = _GEN_74 & enq_idxs_2[15];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_91 = _GEN_74 & enq_idxs_2[16];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_92 = _GEN_74 & enq_idxs_2[17];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_93 = _GEN_74 & enq_idxs_2[18];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_94 = _GEN_74 & enq_idxs_2[19];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_95 = _GEN_74 & enq_idxs_2[20];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_96 = _GEN_74 & enq_idxs_2[21];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_97 = _GEN_74 & enq_idxs_2[22];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_98 = _GEN_74 & enq_idxs_2[23];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_99 = _GEN_74 & enq_idxs_2[24];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_100 = _GEN_74 & enq_idxs_2[25];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_101 = _GEN_74 & enq_idxs_2[26];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_102 = _GEN_74 & enq_idxs_2[27];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_103 = _GEN_74 & enq_idxs_2[28];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_104 = _GEN_74 & enq_idxs_2[29];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_105 = _GEN_74 & enq_idxs_2[30];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_106 = _GEN_74 & enq_idxs_2[31];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_107 = ~_do_enq_T_1 & in_mask_3;	// fetch-buffer.scala:82:{16,40}, :98:49, :144:20
    _GEN_108 = _GEN_107 & enq_idxs_3[0];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_109 = _GEN_107 & enq_idxs_3[1];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_110 = _GEN_107 & enq_idxs_3[2];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_111 = _GEN_107 & enq_idxs_3[3];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_112 = _GEN_107 & enq_idxs_3[4];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_113 = _GEN_107 & enq_idxs_3[5];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_114 = _GEN_107 & enq_idxs_3[6];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_115 = _GEN_107 & enq_idxs_3[7];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_116 = _GEN_107 & enq_idxs_3[8];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_117 = _GEN_107 & enq_idxs_3[9];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_118 = _GEN_107 & enq_idxs_3[10];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_119 = _GEN_107 & enq_idxs_3[11];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_120 = _GEN_107 & enq_idxs_3[12];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_121 = _GEN_107 & enq_idxs_3[13];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_122 = _GEN_107 & enq_idxs_3[14];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_123 = _GEN_107 & enq_idxs_3[15];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_124 = _GEN_107 & enq_idxs_3[16];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_125 = _GEN_107 & enq_idxs_3[17];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_126 = _GEN_107 & enq_idxs_3[18];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_127 = _GEN_107 & enq_idxs_3[19];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_128 = _GEN_107 & enq_idxs_3[20];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_129 = _GEN_107 & enq_idxs_3[21];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_130 = _GEN_107 & enq_idxs_3[22];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_131 = _GEN_107 & enq_idxs_3[23];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_132 = _GEN_107 & enq_idxs_3[24];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_133 = _GEN_107 & enq_idxs_3[25];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_134 = _GEN_107 & enq_idxs_3[26];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_135 = _GEN_107 & enq_idxs_3[27];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_136 = _GEN_107 & enq_idxs_3[28];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_137 = _GEN_107 & enq_idxs_3[29];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_138 = _GEN_107 & enq_idxs_3[30];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_139 = _GEN_107 & enq_idxs_3[31];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_140 = ~_do_enq_T_1 & in_mask_4;	// fetch-buffer.scala:82:{16,40}, :98:49, :144:20
    _GEN_141 = _GEN_140 & enq_idxs_4[0];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_142 = _GEN_140 & enq_idxs_4[1];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_143 = _GEN_140 & enq_idxs_4[2];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_144 = _GEN_140 & enq_idxs_4[3];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_145 = _GEN_140 & enq_idxs_4[4];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_146 = _GEN_140 & enq_idxs_4[5];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_147 = _GEN_140 & enq_idxs_4[6];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_148 = _GEN_140 & enq_idxs_4[7];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_149 = _GEN_140 & enq_idxs_4[8];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_150 = _GEN_140 & enq_idxs_4[9];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_151 = _GEN_140 & enq_idxs_4[10];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_152 = _GEN_140 & enq_idxs_4[11];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_153 = _GEN_140 & enq_idxs_4[12];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_154 = _GEN_140 & enq_idxs_4[13];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_155 = _GEN_140 & enq_idxs_4[14];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_156 = _GEN_140 & enq_idxs_4[15];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_157 = _GEN_140 & enq_idxs_4[16];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_158 = _GEN_140 & enq_idxs_4[17];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_159 = _GEN_140 & enq_idxs_4[18];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_160 = _GEN_140 & enq_idxs_4[19];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_161 = _GEN_140 & enq_idxs_4[20];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_162 = _GEN_140 & enq_idxs_4[21];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_163 = _GEN_140 & enq_idxs_4[22];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_164 = _GEN_140 & enq_idxs_4[23];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_165 = _GEN_140 & enq_idxs_4[24];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_166 = _GEN_140 & enq_idxs_4[25];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_167 = _GEN_140 & enq_idxs_4[26];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_168 = _GEN_140 & enq_idxs_4[27];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_169 = _GEN_140 & enq_idxs_4[28];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_170 = _GEN_140 & enq_idxs_4[29];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_171 = _GEN_140 & enq_idxs_4[30];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_172 = _GEN_140 & enq_idxs_4[31];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_173 = ~_do_enq_T_1 & in_mask_5;	// fetch-buffer.scala:82:{16,40}, :98:49, :144:20
    _GEN_174 = _GEN_173 & enq_idxs_5[0];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_175 = _GEN_173 & enq_idxs_5[1];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_176 = _GEN_173 & enq_idxs_5[2];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_177 = _GEN_173 & enq_idxs_5[3];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_178 = _GEN_173 & enq_idxs_5[4];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_179 = _GEN_173 & enq_idxs_5[5];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_180 = _GEN_173 & enq_idxs_5[6];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_181 = _GEN_173 & enq_idxs_5[7];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_182 = _GEN_173 & enq_idxs_5[8];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_183 = _GEN_173 & enq_idxs_5[9];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_184 = _GEN_173 & enq_idxs_5[10];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_185 = _GEN_173 & enq_idxs_5[11];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_186 = _GEN_173 & enq_idxs_5[12];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_187 = _GEN_173 & enq_idxs_5[13];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_188 = _GEN_173 & enq_idxs_5[14];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_189 = _GEN_173 & enq_idxs_5[15];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_190 = _GEN_173 & enq_idxs_5[16];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_191 = _GEN_173 & enq_idxs_5[17];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_192 = _GEN_173 & enq_idxs_5[18];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_193 = _GEN_173 & enq_idxs_5[19];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_194 = _GEN_173 & enq_idxs_5[20];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_195 = _GEN_173 & enq_idxs_5[21];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_196 = _GEN_173 & enq_idxs_5[22];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_197 = _GEN_173 & enq_idxs_5[23];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_198 = _GEN_173 & enq_idxs_5[24];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_199 = _GEN_173 & enq_idxs_5[25];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_200 = _GEN_173 & enq_idxs_5[26];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_201 = _GEN_173 & enq_idxs_5[27];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_202 = _GEN_173 & enq_idxs_5[28];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_203 = _GEN_173 & enq_idxs_5[29];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_204 = _GEN_173 & enq_idxs_5[30];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_205 = _GEN_173 & enq_idxs_5[31];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_206 = ~_do_enq_T_1 & in_mask_6;	// fetch-buffer.scala:82:{16,40}, :98:49, :144:20
    _GEN_207 = _GEN_206 & enq_idxs_6[0];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_208 = _GEN_206 & enq_idxs_6[1];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_209 = _GEN_206 & enq_idxs_6[2];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_210 = _GEN_206 & enq_idxs_6[3];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_211 = _GEN_206 & enq_idxs_6[4];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_212 = _GEN_206 & enq_idxs_6[5];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_213 = _GEN_206 & enq_idxs_6[6];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_214 = _GEN_206 & enq_idxs_6[7];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_215 = _GEN_206 & enq_idxs_6[8];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_216 = _GEN_206 & enq_idxs_6[9];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_217 = _GEN_206 & enq_idxs_6[10];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_218 = _GEN_206 & enq_idxs_6[11];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_219 = _GEN_206 & enq_idxs_6[12];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_220 = _GEN_206 & enq_idxs_6[13];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_221 = _GEN_206 & enq_idxs_6[14];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_222 = _GEN_206 & enq_idxs_6[15];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_223 = _GEN_206 & enq_idxs_6[16];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_224 = _GEN_206 & enq_idxs_6[17];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_225 = _GEN_206 & enq_idxs_6[18];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_226 = _GEN_206 & enq_idxs_6[19];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_227 = _GEN_206 & enq_idxs_6[20];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_228 = _GEN_206 & enq_idxs_6[21];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_229 = _GEN_206 & enq_idxs_6[22];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_230 = _GEN_206 & enq_idxs_6[23];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_231 = _GEN_206 & enq_idxs_6[24];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_232 = _GEN_206 & enq_idxs_6[25];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_233 = _GEN_206 & enq_idxs_6[26];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_234 = _GEN_206 & enq_idxs_6[27];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_235 = _GEN_206 & enq_idxs_6[28];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_236 = _GEN_206 & enq_idxs_6[29];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_237 = _GEN_206 & enq_idxs_6[30];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_238 = _GEN_206 & enq_idxs_6[31];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_239 = ~_do_enq_T_1 & in_mask_7;	// fetch-buffer.scala:82:{16,40}, :98:49, :144:20
    _GEN_240 = _GEN_239 & enq_idxs_7[0];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_241 =
      _GEN_240 | _GEN_207 | _GEN_174 | _GEN_141 | _GEN_108 | _GEN_75 | _GEN_42 | _GEN_9;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_242 = _GEN_239 & enq_idxs_7[1];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_243 =
      _GEN_242 | _GEN_208 | _GEN_175 | _GEN_142 | _GEN_109 | _GEN_76 | _GEN_43 | _GEN_10;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_244 = _GEN_239 & enq_idxs_7[2];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_245 =
      _GEN_244 | _GEN_209 | _GEN_176 | _GEN_143 | _GEN_110 | _GEN_77 | _GEN_44 | _GEN_11;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_246 = _GEN_239 & enq_idxs_7[3];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_247 =
      _GEN_246 | _GEN_210 | _GEN_177 | _GEN_144 | _GEN_111 | _GEN_78 | _GEN_45 | _GEN_12;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_248 = _GEN_239 & enq_idxs_7[4];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_249 =
      _GEN_248 | _GEN_211 | _GEN_178 | _GEN_145 | _GEN_112 | _GEN_79 | _GEN_46 | _GEN_13;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_250 = _GEN_239 & enq_idxs_7[5];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_251 =
      _GEN_250 | _GEN_212 | _GEN_179 | _GEN_146 | _GEN_113 | _GEN_80 | _GEN_47 | _GEN_14;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_252 = _GEN_239 & enq_idxs_7[6];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_253 =
      _GEN_252 | _GEN_213 | _GEN_180 | _GEN_147 | _GEN_114 | _GEN_81 | _GEN_48 | _GEN_15;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_254 = _GEN_239 & enq_idxs_7[7];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_255 =
      _GEN_254 | _GEN_214 | _GEN_181 | _GEN_148 | _GEN_115 | _GEN_82 | _GEN_49 | _GEN_16;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_256 = _GEN_239 & enq_idxs_7[8];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_257 =
      _GEN_256 | _GEN_215 | _GEN_182 | _GEN_149 | _GEN_116 | _GEN_83 | _GEN_50 | _GEN_17;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_258 = _GEN_239 & enq_idxs_7[9];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_259 =
      _GEN_258 | _GEN_216 | _GEN_183 | _GEN_150 | _GEN_117 | _GEN_84 | _GEN_51 | _GEN_18;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_260 = _GEN_239 & enq_idxs_7[10];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_261 =
      _GEN_260 | _GEN_217 | _GEN_184 | _GEN_151 | _GEN_118 | _GEN_85 | _GEN_52 | _GEN_19;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_262 = _GEN_239 & enq_idxs_7[11];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_263 =
      _GEN_262 | _GEN_218 | _GEN_185 | _GEN_152 | _GEN_119 | _GEN_86 | _GEN_53 | _GEN_20;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_264 = _GEN_239 & enq_idxs_7[12];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_265 =
      _GEN_264 | _GEN_219 | _GEN_186 | _GEN_153 | _GEN_120 | _GEN_87 | _GEN_54 | _GEN_21;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_266 = _GEN_239 & enq_idxs_7[13];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_267 =
      _GEN_266 | _GEN_220 | _GEN_187 | _GEN_154 | _GEN_121 | _GEN_88 | _GEN_55 | _GEN_22;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_268 = _GEN_239 & enq_idxs_7[14];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_269 =
      _GEN_268 | _GEN_221 | _GEN_188 | _GEN_155 | _GEN_122 | _GEN_89 | _GEN_56 | _GEN_23;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_270 = _GEN_239 & enq_idxs_7[15];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_271 =
      _GEN_270 | _GEN_222 | _GEN_189 | _GEN_156 | _GEN_123 | _GEN_90 | _GEN_57 | _GEN_24;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_272 = _GEN_239 & enq_idxs_7[16];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_273 =
      _GEN_272 | _GEN_223 | _GEN_190 | _GEN_157 | _GEN_124 | _GEN_91 | _GEN_58 | _GEN_25;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_274 = _GEN_239 & enq_idxs_7[17];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_275 =
      _GEN_274 | _GEN_224 | _GEN_191 | _GEN_158 | _GEN_125 | _GEN_92 | _GEN_59 | _GEN_26;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_276 = _GEN_239 & enq_idxs_7[18];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_277 =
      _GEN_276 | _GEN_225 | _GEN_192 | _GEN_159 | _GEN_126 | _GEN_93 | _GEN_60 | _GEN_27;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_278 = _GEN_239 & enq_idxs_7[19];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_279 =
      _GEN_278 | _GEN_226 | _GEN_193 | _GEN_160 | _GEN_127 | _GEN_94 | _GEN_61 | _GEN_28;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_280 = _GEN_239 & enq_idxs_7[20];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_281 =
      _GEN_280 | _GEN_227 | _GEN_194 | _GEN_161 | _GEN_128 | _GEN_95 | _GEN_62 | _GEN_29;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_282 = _GEN_239 & enq_idxs_7[21];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_283 =
      _GEN_282 | _GEN_228 | _GEN_195 | _GEN_162 | _GEN_129 | _GEN_96 | _GEN_63 | _GEN_30;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_284 = _GEN_239 & enq_idxs_7[22];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_285 =
      _GEN_284 | _GEN_229 | _GEN_196 | _GEN_163 | _GEN_130 | _GEN_97 | _GEN_64 | _GEN_31;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_286 = _GEN_239 & enq_idxs_7[23];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_287 =
      _GEN_286 | _GEN_230 | _GEN_197 | _GEN_164 | _GEN_131 | _GEN_98 | _GEN_65 | _GEN_32;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_288 = _GEN_239 & enq_idxs_7[24];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_289 =
      _GEN_288 | _GEN_231 | _GEN_198 | _GEN_165 | _GEN_132 | _GEN_99 | _GEN_66 | _GEN_33;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_290 = _GEN_239 & enq_idxs_7[25];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_291 =
      _GEN_290 | _GEN_232 | _GEN_199 | _GEN_166 | _GEN_133 | _GEN_100 | _GEN_67 | _GEN_34;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_292 = _GEN_239 & enq_idxs_7[26];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_293 =
      _GEN_292 | _GEN_233 | _GEN_200 | _GEN_167 | _GEN_134 | _GEN_101 | _GEN_68 | _GEN_35;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_294 = _GEN_239 & enq_idxs_7[27];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_295 =
      _GEN_294 | _GEN_234 | _GEN_201 | _GEN_168 | _GEN_135 | _GEN_102 | _GEN_69 | _GEN_36;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_296 = _GEN_239 & enq_idxs_7[28];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_297 =
      _GEN_296 | _GEN_235 | _GEN_202 | _GEN_169 | _GEN_136 | _GEN_103 | _GEN_70 | _GEN_37;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_298 = _GEN_239 & enq_idxs_7[29];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_299 =
      _GEN_298 | _GEN_236 | _GEN_203 | _GEN_170 | _GEN_137 | _GEN_104 | _GEN_71 | _GEN_38;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_300 = _GEN_239 & enq_idxs_7[30];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_301 =
      _GEN_300 | _GEN_237 | _GEN_204 | _GEN_171 | _GEN_138 | _GEN_105 | _GEN_72 | _GEN_39;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_302 = _GEN_239 & enq_idxs_7[31];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_303 =
      _GEN_302 | _GEN_238 | _GEN_205 | _GEN_172 | _GEN_139 | _GEN_106 | _GEN_73 | _GEN_40;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    if (_GEN_240) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_0_inst <= io_enq_bits_exp_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_0_debug_inst <= io_enq_bits_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_0_is_rvc <= in_uops_7_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_0_debug_pc <= _pc_T_31;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_0_is_sfb <= io_enq_bits_shadowed_mask_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_0_pc_lob <= _pc_T_31[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_0_taken <= in_uops_7_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_207) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_0_inst <= io_enq_bits_exp_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_0_debug_inst <= io_enq_bits_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_0_is_rvc <= in_uops_6_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_0_debug_pc <= _pc_T_27;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_0_is_sfb <= io_enq_bits_shadowed_mask_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_0_pc_lob <= _pc_T_27[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_0_taken <= in_uops_6_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_174) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_0_inst <= io_enq_bits_exp_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_0_debug_inst <= io_enq_bits_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_0_is_rvc <= in_uops_5_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_0_debug_pc <= _pc_T_23;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_0_is_sfb <= io_enq_bits_shadowed_mask_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_0_pc_lob <= _pc_T_23[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_0_taken <= in_uops_5_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_141) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_0_inst <= io_enq_bits_exp_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_0_debug_inst <= io_enq_bits_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_0_is_rvc <= in_uops_4_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_1) begin
        fb_uop_ram_0_debug_pc <= _in_uops_4_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
        fb_uop_ram_0_pc_lob <= _in_uops_4_pc_lob_T_3;	// fetch-buffer.scala:57:16, :108:61
      end
      else begin
        fb_uop_ram_0_debug_pc <= _pc_T_19;	// fetch-buffer.scala:57:16, :95:43
        fb_uop_ram_0_pc_lob <= _pc_T_19[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      end
      fb_uop_ram_0_is_sfb <= io_enq_bits_shadowed_mask_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_0_taken <= in_uops_4_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_108) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_0_inst <= io_enq_bits_exp_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_0_debug_inst <= io_enq_bits_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_0_is_rvc <= in_uops_3_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_0_debug_pc <= _pc_T_15;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_0_is_sfb <= io_enq_bits_shadowed_mask_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_0_pc_lob <= _pc_T_15[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_0_taken <= in_uops_3_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_75) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_0_inst <= io_enq_bits_exp_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_0_debug_inst <= io_enq_bits_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_0_is_rvc <= in_uops_2_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_0_debug_pc <= _pc_T_11;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_0_is_sfb <= io_enq_bits_shadowed_mask_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_0_pc_lob <= _pc_T_11[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_0_taken <= in_uops_2_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_42) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_0_inst <= io_enq_bits_exp_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_0_debug_inst <= io_enq_bits_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_0_is_rvc <= in_uops_1_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_0_debug_pc <= _pc_T_7;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_0_is_sfb <= io_enq_bits_shadowed_mask_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_0_pc_lob <= _pc_T_7[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_0_taken <= in_uops_1_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_9) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_0_inst <= io_enq_bits_exp_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_0_debug_inst <= io_enq_bits_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_0_is_rvc <= in_uops_0_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_0)
        fb_uop_ram_0_debug_pc <= _in_uops_0_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
      else
        fb_uop_ram_0_debug_pc <= pc;	// fetch-buffer.scala:57:16, frontend.scala:161:39
      fb_uop_ram_0_is_sfb <= io_enq_bits_shadowed_mask_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_0_pc_lob <= in_uops_0_pc_lob;	// fetch-buffer.scala:57:16, :101:33, :106:41, :108:32
      fb_uop_ram_0_taken <= in_uops_0_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_0_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_0_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;	// fetch-buffer.scala:57:16
    end
    if (_GEN_241) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
      fb_uop_ram_0_ctrl_br_type <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_0_ctrl_op1_sel <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_0_ctrl_op2_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_0_ctrl_imm_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_0_ctrl_op_fcn <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_0_ctrl_csr_cmd <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_0_iw_state <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_0_ftq_idx <= io_enq_bits_ftq_idx;	// fetch-buffer.scala:57:16
      fb_uop_ram_0_csr_addr <= 12'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_0_rxq_idx <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_0_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_0_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_0_debug_fsrc <= io_enq_bits_fsrc;	// fetch-buffer.scala:57:16
      fb_uop_ram_0_debug_tsrc <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
    end
    fb_uop_ram_0_ctrl_fcn_dw <= ~_GEN_241 & fb_uop_ram_0_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_0_ctrl_is_load <= ~_GEN_241 & fb_uop_ram_0_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_0_ctrl_is_sta <= ~_GEN_241 & fb_uop_ram_0_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_0_ctrl_is_std <= ~_GEN_241 & fb_uop_ram_0_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_0_iw_p1_poisoned <= ~_GEN_241 & fb_uop_ram_0_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_0_iw_p2_poisoned <= ~_GEN_241 & fb_uop_ram_0_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_0_edge_inst <=
      ~(_GEN_240 | _GEN_207 | _GEN_174)
      & (_GEN_141
           ? io_enq_bits_edge_inst_1
           : ~(_GEN_108 | _GEN_75 | _GEN_42)
             & (_GEN_9 ? io_enq_bits_edge_inst_0 : fb_uop_ram_0_edge_inst));	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_0_xcpt_ma_if <= ~_GEN_241 & fb_uop_ram_0_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_242) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_1_inst <= io_enq_bits_exp_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_1_debug_inst <= io_enq_bits_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_1_is_rvc <= in_uops_7_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_1_debug_pc <= _pc_T_31;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_1_is_sfb <= io_enq_bits_shadowed_mask_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_1_pc_lob <= _pc_T_31[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_1_taken <= in_uops_7_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_208) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_1_inst <= io_enq_bits_exp_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_1_debug_inst <= io_enq_bits_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_1_is_rvc <= in_uops_6_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_1_debug_pc <= _pc_T_27;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_1_is_sfb <= io_enq_bits_shadowed_mask_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_1_pc_lob <= _pc_T_27[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_1_taken <= in_uops_6_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_175) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_1_inst <= io_enq_bits_exp_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_1_debug_inst <= io_enq_bits_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_1_is_rvc <= in_uops_5_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_1_debug_pc <= _pc_T_23;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_1_is_sfb <= io_enq_bits_shadowed_mask_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_1_pc_lob <= _pc_T_23[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_1_taken <= in_uops_5_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_142) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_1_inst <= io_enq_bits_exp_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_1_debug_inst <= io_enq_bits_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_1_is_rvc <= in_uops_4_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_1) begin
        fb_uop_ram_1_debug_pc <= _in_uops_4_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
        fb_uop_ram_1_pc_lob <= _in_uops_4_pc_lob_T_3;	// fetch-buffer.scala:57:16, :108:61
      end
      else begin
        fb_uop_ram_1_debug_pc <= _pc_T_19;	// fetch-buffer.scala:57:16, :95:43
        fb_uop_ram_1_pc_lob <= _pc_T_19[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      end
      fb_uop_ram_1_is_sfb <= io_enq_bits_shadowed_mask_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_1_taken <= in_uops_4_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_109) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_1_inst <= io_enq_bits_exp_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_1_debug_inst <= io_enq_bits_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_1_is_rvc <= in_uops_3_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_1_debug_pc <= _pc_T_15;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_1_is_sfb <= io_enq_bits_shadowed_mask_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_1_pc_lob <= _pc_T_15[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_1_taken <= in_uops_3_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_76) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_1_inst <= io_enq_bits_exp_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_1_debug_inst <= io_enq_bits_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_1_is_rvc <= in_uops_2_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_1_debug_pc <= _pc_T_11;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_1_is_sfb <= io_enq_bits_shadowed_mask_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_1_pc_lob <= _pc_T_11[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_1_taken <= in_uops_2_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_43) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_1_inst <= io_enq_bits_exp_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_1_debug_inst <= io_enq_bits_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_1_is_rvc <= in_uops_1_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_1_debug_pc <= _pc_T_7;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_1_is_sfb <= io_enq_bits_shadowed_mask_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_1_pc_lob <= _pc_T_7[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_1_taken <= in_uops_1_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_10) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_1_inst <= io_enq_bits_exp_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_1_debug_inst <= io_enq_bits_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_1_is_rvc <= in_uops_0_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_0)
        fb_uop_ram_1_debug_pc <= _in_uops_0_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
      else
        fb_uop_ram_1_debug_pc <= pc;	// fetch-buffer.scala:57:16, frontend.scala:161:39
      fb_uop_ram_1_is_sfb <= io_enq_bits_shadowed_mask_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_1_pc_lob <= in_uops_0_pc_lob;	// fetch-buffer.scala:57:16, :101:33, :106:41, :108:32
      fb_uop_ram_1_taken <= in_uops_0_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_1_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_1_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;	// fetch-buffer.scala:57:16
    end
    if (_GEN_243) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
      fb_uop_ram_1_ctrl_br_type <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_1_ctrl_op1_sel <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_1_ctrl_op2_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_1_ctrl_imm_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_1_ctrl_op_fcn <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_1_ctrl_csr_cmd <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_1_iw_state <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_1_ftq_idx <= io_enq_bits_ftq_idx;	// fetch-buffer.scala:57:16
      fb_uop_ram_1_csr_addr <= 12'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_1_rxq_idx <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_1_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_1_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_1_debug_fsrc <= io_enq_bits_fsrc;	// fetch-buffer.scala:57:16
      fb_uop_ram_1_debug_tsrc <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
    end
    fb_uop_ram_1_ctrl_fcn_dw <= ~_GEN_243 & fb_uop_ram_1_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_1_ctrl_is_load <= ~_GEN_243 & fb_uop_ram_1_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_1_ctrl_is_sta <= ~_GEN_243 & fb_uop_ram_1_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_1_ctrl_is_std <= ~_GEN_243 & fb_uop_ram_1_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_1_iw_p1_poisoned <= ~_GEN_243 & fb_uop_ram_1_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_1_iw_p2_poisoned <= ~_GEN_243 & fb_uop_ram_1_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_1_edge_inst <=
      ~(_GEN_242 | _GEN_208 | _GEN_175)
      & (_GEN_142
           ? io_enq_bits_edge_inst_1
           : ~(_GEN_109 | _GEN_76 | _GEN_43)
             & (_GEN_10 ? io_enq_bits_edge_inst_0 : fb_uop_ram_1_edge_inst));	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_1_xcpt_ma_if <= ~_GEN_243 & fb_uop_ram_1_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_244) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_2_inst <= io_enq_bits_exp_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_2_debug_inst <= io_enq_bits_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_2_is_rvc <= in_uops_7_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_2_debug_pc <= _pc_T_31;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_2_is_sfb <= io_enq_bits_shadowed_mask_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_2_pc_lob <= _pc_T_31[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_2_taken <= in_uops_7_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_209) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_2_inst <= io_enq_bits_exp_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_2_debug_inst <= io_enq_bits_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_2_is_rvc <= in_uops_6_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_2_debug_pc <= _pc_T_27;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_2_is_sfb <= io_enq_bits_shadowed_mask_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_2_pc_lob <= _pc_T_27[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_2_taken <= in_uops_6_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_176) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_2_inst <= io_enq_bits_exp_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_2_debug_inst <= io_enq_bits_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_2_is_rvc <= in_uops_5_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_2_debug_pc <= _pc_T_23;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_2_is_sfb <= io_enq_bits_shadowed_mask_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_2_pc_lob <= _pc_T_23[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_2_taken <= in_uops_5_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_143) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_2_inst <= io_enq_bits_exp_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_2_debug_inst <= io_enq_bits_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_2_is_rvc <= in_uops_4_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_1) begin
        fb_uop_ram_2_debug_pc <= _in_uops_4_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
        fb_uop_ram_2_pc_lob <= _in_uops_4_pc_lob_T_3;	// fetch-buffer.scala:57:16, :108:61
      end
      else begin
        fb_uop_ram_2_debug_pc <= _pc_T_19;	// fetch-buffer.scala:57:16, :95:43
        fb_uop_ram_2_pc_lob <= _pc_T_19[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      end
      fb_uop_ram_2_is_sfb <= io_enq_bits_shadowed_mask_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_2_taken <= in_uops_4_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_110) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_2_inst <= io_enq_bits_exp_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_2_debug_inst <= io_enq_bits_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_2_is_rvc <= in_uops_3_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_2_debug_pc <= _pc_T_15;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_2_is_sfb <= io_enq_bits_shadowed_mask_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_2_pc_lob <= _pc_T_15[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_2_taken <= in_uops_3_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_77) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_2_inst <= io_enq_bits_exp_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_2_debug_inst <= io_enq_bits_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_2_is_rvc <= in_uops_2_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_2_debug_pc <= _pc_T_11;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_2_is_sfb <= io_enq_bits_shadowed_mask_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_2_pc_lob <= _pc_T_11[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_2_taken <= in_uops_2_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_44) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_2_inst <= io_enq_bits_exp_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_2_debug_inst <= io_enq_bits_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_2_is_rvc <= in_uops_1_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_2_debug_pc <= _pc_T_7;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_2_is_sfb <= io_enq_bits_shadowed_mask_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_2_pc_lob <= _pc_T_7[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_2_taken <= in_uops_1_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_11) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_2_inst <= io_enq_bits_exp_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_2_debug_inst <= io_enq_bits_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_2_is_rvc <= in_uops_0_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_0)
        fb_uop_ram_2_debug_pc <= _in_uops_0_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
      else
        fb_uop_ram_2_debug_pc <= pc;	// fetch-buffer.scala:57:16, frontend.scala:161:39
      fb_uop_ram_2_is_sfb <= io_enq_bits_shadowed_mask_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_2_pc_lob <= in_uops_0_pc_lob;	// fetch-buffer.scala:57:16, :101:33, :106:41, :108:32
      fb_uop_ram_2_taken <= in_uops_0_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_2_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_2_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;	// fetch-buffer.scala:57:16
    end
    if (_GEN_245) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
      fb_uop_ram_2_ctrl_br_type <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_2_ctrl_op1_sel <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_2_ctrl_op2_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_2_ctrl_imm_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_2_ctrl_op_fcn <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_2_ctrl_csr_cmd <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_2_iw_state <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_2_ftq_idx <= io_enq_bits_ftq_idx;	// fetch-buffer.scala:57:16
      fb_uop_ram_2_csr_addr <= 12'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_2_rxq_idx <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_2_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_2_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_2_debug_fsrc <= io_enq_bits_fsrc;	// fetch-buffer.scala:57:16
      fb_uop_ram_2_debug_tsrc <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
    end
    fb_uop_ram_2_ctrl_fcn_dw <= ~_GEN_245 & fb_uop_ram_2_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_2_ctrl_is_load <= ~_GEN_245 & fb_uop_ram_2_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_2_ctrl_is_sta <= ~_GEN_245 & fb_uop_ram_2_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_2_ctrl_is_std <= ~_GEN_245 & fb_uop_ram_2_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_2_iw_p1_poisoned <= ~_GEN_245 & fb_uop_ram_2_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_2_iw_p2_poisoned <= ~_GEN_245 & fb_uop_ram_2_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_2_edge_inst <=
      ~(_GEN_244 | _GEN_209 | _GEN_176)
      & (_GEN_143
           ? io_enq_bits_edge_inst_1
           : ~(_GEN_110 | _GEN_77 | _GEN_44)
             & (_GEN_11 ? io_enq_bits_edge_inst_0 : fb_uop_ram_2_edge_inst));	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_2_xcpt_ma_if <= ~_GEN_245 & fb_uop_ram_2_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_246) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_3_inst <= io_enq_bits_exp_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_3_debug_inst <= io_enq_bits_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_3_is_rvc <= in_uops_7_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_3_debug_pc <= _pc_T_31;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_3_is_sfb <= io_enq_bits_shadowed_mask_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_3_pc_lob <= _pc_T_31[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_3_taken <= in_uops_7_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_210) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_3_inst <= io_enq_bits_exp_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_3_debug_inst <= io_enq_bits_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_3_is_rvc <= in_uops_6_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_3_debug_pc <= _pc_T_27;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_3_is_sfb <= io_enq_bits_shadowed_mask_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_3_pc_lob <= _pc_T_27[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_3_taken <= in_uops_6_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_177) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_3_inst <= io_enq_bits_exp_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_3_debug_inst <= io_enq_bits_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_3_is_rvc <= in_uops_5_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_3_debug_pc <= _pc_T_23;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_3_is_sfb <= io_enq_bits_shadowed_mask_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_3_pc_lob <= _pc_T_23[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_3_taken <= in_uops_5_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_144) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_3_inst <= io_enq_bits_exp_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_3_debug_inst <= io_enq_bits_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_3_is_rvc <= in_uops_4_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_1) begin
        fb_uop_ram_3_debug_pc <= _in_uops_4_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
        fb_uop_ram_3_pc_lob <= _in_uops_4_pc_lob_T_3;	// fetch-buffer.scala:57:16, :108:61
      end
      else begin
        fb_uop_ram_3_debug_pc <= _pc_T_19;	// fetch-buffer.scala:57:16, :95:43
        fb_uop_ram_3_pc_lob <= _pc_T_19[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      end
      fb_uop_ram_3_is_sfb <= io_enq_bits_shadowed_mask_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_3_taken <= in_uops_4_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_111) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_3_inst <= io_enq_bits_exp_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_3_debug_inst <= io_enq_bits_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_3_is_rvc <= in_uops_3_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_3_debug_pc <= _pc_T_15;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_3_is_sfb <= io_enq_bits_shadowed_mask_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_3_pc_lob <= _pc_T_15[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_3_taken <= in_uops_3_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_78) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_3_inst <= io_enq_bits_exp_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_3_debug_inst <= io_enq_bits_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_3_is_rvc <= in_uops_2_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_3_debug_pc <= _pc_T_11;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_3_is_sfb <= io_enq_bits_shadowed_mask_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_3_pc_lob <= _pc_T_11[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_3_taken <= in_uops_2_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_45) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_3_inst <= io_enq_bits_exp_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_3_debug_inst <= io_enq_bits_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_3_is_rvc <= in_uops_1_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_3_debug_pc <= _pc_T_7;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_3_is_sfb <= io_enq_bits_shadowed_mask_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_3_pc_lob <= _pc_T_7[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_3_taken <= in_uops_1_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_12) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_3_inst <= io_enq_bits_exp_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_3_debug_inst <= io_enq_bits_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_3_is_rvc <= in_uops_0_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_0)
        fb_uop_ram_3_debug_pc <= _in_uops_0_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
      else
        fb_uop_ram_3_debug_pc <= pc;	// fetch-buffer.scala:57:16, frontend.scala:161:39
      fb_uop_ram_3_is_sfb <= io_enq_bits_shadowed_mask_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_3_pc_lob <= in_uops_0_pc_lob;	// fetch-buffer.scala:57:16, :101:33, :106:41, :108:32
      fb_uop_ram_3_taken <= in_uops_0_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_3_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_3_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;	// fetch-buffer.scala:57:16
    end
    if (_GEN_247) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
      fb_uop_ram_3_ctrl_br_type <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_3_ctrl_op1_sel <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_3_ctrl_op2_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_3_ctrl_imm_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_3_ctrl_op_fcn <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_3_ctrl_csr_cmd <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_3_iw_state <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_3_ftq_idx <= io_enq_bits_ftq_idx;	// fetch-buffer.scala:57:16
      fb_uop_ram_3_csr_addr <= 12'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_3_rxq_idx <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_3_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_3_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_3_debug_fsrc <= io_enq_bits_fsrc;	// fetch-buffer.scala:57:16
      fb_uop_ram_3_debug_tsrc <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
    end
    fb_uop_ram_3_ctrl_fcn_dw <= ~_GEN_247 & fb_uop_ram_3_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_3_ctrl_is_load <= ~_GEN_247 & fb_uop_ram_3_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_3_ctrl_is_sta <= ~_GEN_247 & fb_uop_ram_3_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_3_ctrl_is_std <= ~_GEN_247 & fb_uop_ram_3_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_3_iw_p1_poisoned <= ~_GEN_247 & fb_uop_ram_3_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_3_iw_p2_poisoned <= ~_GEN_247 & fb_uop_ram_3_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_3_edge_inst <=
      ~(_GEN_246 | _GEN_210 | _GEN_177)
      & (_GEN_144
           ? io_enq_bits_edge_inst_1
           : ~(_GEN_111 | _GEN_78 | _GEN_45)
             & (_GEN_12 ? io_enq_bits_edge_inst_0 : fb_uop_ram_3_edge_inst));	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_3_xcpt_ma_if <= ~_GEN_247 & fb_uop_ram_3_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_248) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_4_inst <= io_enq_bits_exp_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_4_debug_inst <= io_enq_bits_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_4_is_rvc <= in_uops_7_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_4_debug_pc <= _pc_T_31;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_4_is_sfb <= io_enq_bits_shadowed_mask_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_4_pc_lob <= _pc_T_31[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_4_taken <= in_uops_7_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_4_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_4_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_211) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_4_inst <= io_enq_bits_exp_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_4_debug_inst <= io_enq_bits_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_4_is_rvc <= in_uops_6_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_4_debug_pc <= _pc_T_27;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_4_is_sfb <= io_enq_bits_shadowed_mask_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_4_pc_lob <= _pc_T_27[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_4_taken <= in_uops_6_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_4_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_4_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_178) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_4_inst <= io_enq_bits_exp_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_4_debug_inst <= io_enq_bits_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_4_is_rvc <= in_uops_5_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_4_debug_pc <= _pc_T_23;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_4_is_sfb <= io_enq_bits_shadowed_mask_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_4_pc_lob <= _pc_T_23[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_4_taken <= in_uops_5_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_4_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_4_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_145) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_4_inst <= io_enq_bits_exp_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_4_debug_inst <= io_enq_bits_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_4_is_rvc <= in_uops_4_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_1) begin
        fb_uop_ram_4_debug_pc <= _in_uops_4_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
        fb_uop_ram_4_pc_lob <= _in_uops_4_pc_lob_T_3;	// fetch-buffer.scala:57:16, :108:61
      end
      else begin
        fb_uop_ram_4_debug_pc <= _pc_T_19;	// fetch-buffer.scala:57:16, :95:43
        fb_uop_ram_4_pc_lob <= _pc_T_19[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      end
      fb_uop_ram_4_is_sfb <= io_enq_bits_shadowed_mask_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_4_taken <= in_uops_4_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_4_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_4_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_112) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_4_inst <= io_enq_bits_exp_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_4_debug_inst <= io_enq_bits_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_4_is_rvc <= in_uops_3_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_4_debug_pc <= _pc_T_15;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_4_is_sfb <= io_enq_bits_shadowed_mask_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_4_pc_lob <= _pc_T_15[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_4_taken <= in_uops_3_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_4_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_4_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_79) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_4_inst <= io_enq_bits_exp_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_4_debug_inst <= io_enq_bits_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_4_is_rvc <= in_uops_2_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_4_debug_pc <= _pc_T_11;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_4_is_sfb <= io_enq_bits_shadowed_mask_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_4_pc_lob <= _pc_T_11[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_4_taken <= in_uops_2_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_4_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_4_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_46) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_4_inst <= io_enq_bits_exp_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_4_debug_inst <= io_enq_bits_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_4_is_rvc <= in_uops_1_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_4_debug_pc <= _pc_T_7;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_4_is_sfb <= io_enq_bits_shadowed_mask_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_4_pc_lob <= _pc_T_7[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_4_taken <= in_uops_1_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_4_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_4_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_13) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_4_inst <= io_enq_bits_exp_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_4_debug_inst <= io_enq_bits_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_4_is_rvc <= in_uops_0_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_0)
        fb_uop_ram_4_debug_pc <= _in_uops_0_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
      else
        fb_uop_ram_4_debug_pc <= pc;	// fetch-buffer.scala:57:16, frontend.scala:161:39
      fb_uop_ram_4_is_sfb <= io_enq_bits_shadowed_mask_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_4_pc_lob <= in_uops_0_pc_lob;	// fetch-buffer.scala:57:16, :101:33, :106:41, :108:32
      fb_uop_ram_4_taken <= in_uops_0_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_4_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_4_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;	// fetch-buffer.scala:57:16
    end
    if (_GEN_249) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
      fb_uop_ram_4_ctrl_br_type <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_4_ctrl_op1_sel <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_4_ctrl_op2_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_4_ctrl_imm_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_4_ctrl_op_fcn <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_4_ctrl_csr_cmd <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_4_iw_state <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_4_ftq_idx <= io_enq_bits_ftq_idx;	// fetch-buffer.scala:57:16
      fb_uop_ram_4_csr_addr <= 12'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_4_rxq_idx <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_4_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_4_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_4_debug_fsrc <= io_enq_bits_fsrc;	// fetch-buffer.scala:57:16
      fb_uop_ram_4_debug_tsrc <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
    end
    fb_uop_ram_4_ctrl_fcn_dw <= ~_GEN_249 & fb_uop_ram_4_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_4_ctrl_is_load <= ~_GEN_249 & fb_uop_ram_4_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_4_ctrl_is_sta <= ~_GEN_249 & fb_uop_ram_4_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_4_ctrl_is_std <= ~_GEN_249 & fb_uop_ram_4_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_4_iw_p1_poisoned <= ~_GEN_249 & fb_uop_ram_4_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_4_iw_p2_poisoned <= ~_GEN_249 & fb_uop_ram_4_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_4_edge_inst <=
      ~(_GEN_248 | _GEN_211 | _GEN_178)
      & (_GEN_145
           ? io_enq_bits_edge_inst_1
           : ~(_GEN_112 | _GEN_79 | _GEN_46)
             & (_GEN_13 ? io_enq_bits_edge_inst_0 : fb_uop_ram_4_edge_inst));	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_4_xcpt_ma_if <= ~_GEN_249 & fb_uop_ram_4_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_250) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_5_inst <= io_enq_bits_exp_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_5_debug_inst <= io_enq_bits_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_5_is_rvc <= in_uops_7_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_5_debug_pc <= _pc_T_31;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_5_is_sfb <= io_enq_bits_shadowed_mask_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_5_pc_lob <= _pc_T_31[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_5_taken <= in_uops_7_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_5_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_5_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_212) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_5_inst <= io_enq_bits_exp_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_5_debug_inst <= io_enq_bits_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_5_is_rvc <= in_uops_6_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_5_debug_pc <= _pc_T_27;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_5_is_sfb <= io_enq_bits_shadowed_mask_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_5_pc_lob <= _pc_T_27[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_5_taken <= in_uops_6_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_5_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_5_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_179) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_5_inst <= io_enq_bits_exp_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_5_debug_inst <= io_enq_bits_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_5_is_rvc <= in_uops_5_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_5_debug_pc <= _pc_T_23;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_5_is_sfb <= io_enq_bits_shadowed_mask_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_5_pc_lob <= _pc_T_23[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_5_taken <= in_uops_5_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_5_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_5_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_146) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_5_inst <= io_enq_bits_exp_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_5_debug_inst <= io_enq_bits_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_5_is_rvc <= in_uops_4_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_1) begin
        fb_uop_ram_5_debug_pc <= _in_uops_4_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
        fb_uop_ram_5_pc_lob <= _in_uops_4_pc_lob_T_3;	// fetch-buffer.scala:57:16, :108:61
      end
      else begin
        fb_uop_ram_5_debug_pc <= _pc_T_19;	// fetch-buffer.scala:57:16, :95:43
        fb_uop_ram_5_pc_lob <= _pc_T_19[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      end
      fb_uop_ram_5_is_sfb <= io_enq_bits_shadowed_mask_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_5_taken <= in_uops_4_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_5_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_5_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_113) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_5_inst <= io_enq_bits_exp_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_5_debug_inst <= io_enq_bits_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_5_is_rvc <= in_uops_3_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_5_debug_pc <= _pc_T_15;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_5_is_sfb <= io_enq_bits_shadowed_mask_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_5_pc_lob <= _pc_T_15[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_5_taken <= in_uops_3_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_5_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_5_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_80) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_5_inst <= io_enq_bits_exp_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_5_debug_inst <= io_enq_bits_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_5_is_rvc <= in_uops_2_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_5_debug_pc <= _pc_T_11;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_5_is_sfb <= io_enq_bits_shadowed_mask_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_5_pc_lob <= _pc_T_11[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_5_taken <= in_uops_2_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_5_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_5_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_47) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_5_inst <= io_enq_bits_exp_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_5_debug_inst <= io_enq_bits_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_5_is_rvc <= in_uops_1_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_5_debug_pc <= _pc_T_7;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_5_is_sfb <= io_enq_bits_shadowed_mask_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_5_pc_lob <= _pc_T_7[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_5_taken <= in_uops_1_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_5_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_5_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_14) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_5_inst <= io_enq_bits_exp_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_5_debug_inst <= io_enq_bits_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_5_is_rvc <= in_uops_0_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_0)
        fb_uop_ram_5_debug_pc <= _in_uops_0_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
      else
        fb_uop_ram_5_debug_pc <= pc;	// fetch-buffer.scala:57:16, frontend.scala:161:39
      fb_uop_ram_5_is_sfb <= io_enq_bits_shadowed_mask_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_5_pc_lob <= in_uops_0_pc_lob;	// fetch-buffer.scala:57:16, :101:33, :106:41, :108:32
      fb_uop_ram_5_taken <= in_uops_0_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_5_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_5_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;	// fetch-buffer.scala:57:16
    end
    if (_GEN_251) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
      fb_uop_ram_5_ctrl_br_type <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_5_ctrl_op1_sel <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_5_ctrl_op2_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_5_ctrl_imm_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_5_ctrl_op_fcn <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_5_ctrl_csr_cmd <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_5_iw_state <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_5_ftq_idx <= io_enq_bits_ftq_idx;	// fetch-buffer.scala:57:16
      fb_uop_ram_5_csr_addr <= 12'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_5_rxq_idx <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_5_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_5_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_5_debug_fsrc <= io_enq_bits_fsrc;	// fetch-buffer.scala:57:16
      fb_uop_ram_5_debug_tsrc <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
    end
    fb_uop_ram_5_ctrl_fcn_dw <= ~_GEN_251 & fb_uop_ram_5_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_5_ctrl_is_load <= ~_GEN_251 & fb_uop_ram_5_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_5_ctrl_is_sta <= ~_GEN_251 & fb_uop_ram_5_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_5_ctrl_is_std <= ~_GEN_251 & fb_uop_ram_5_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_5_iw_p1_poisoned <= ~_GEN_251 & fb_uop_ram_5_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_5_iw_p2_poisoned <= ~_GEN_251 & fb_uop_ram_5_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_5_edge_inst <=
      ~(_GEN_250 | _GEN_212 | _GEN_179)
      & (_GEN_146
           ? io_enq_bits_edge_inst_1
           : ~(_GEN_113 | _GEN_80 | _GEN_47)
             & (_GEN_14 ? io_enq_bits_edge_inst_0 : fb_uop_ram_5_edge_inst));	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_5_xcpt_ma_if <= ~_GEN_251 & fb_uop_ram_5_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_252) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_6_inst <= io_enq_bits_exp_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_6_debug_inst <= io_enq_bits_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_6_is_rvc <= in_uops_7_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_6_debug_pc <= _pc_T_31;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_6_is_sfb <= io_enq_bits_shadowed_mask_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_6_pc_lob <= _pc_T_31[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_6_taken <= in_uops_7_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_6_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_6_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_213) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_6_inst <= io_enq_bits_exp_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_6_debug_inst <= io_enq_bits_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_6_is_rvc <= in_uops_6_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_6_debug_pc <= _pc_T_27;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_6_is_sfb <= io_enq_bits_shadowed_mask_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_6_pc_lob <= _pc_T_27[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_6_taken <= in_uops_6_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_6_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_6_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_180) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_6_inst <= io_enq_bits_exp_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_6_debug_inst <= io_enq_bits_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_6_is_rvc <= in_uops_5_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_6_debug_pc <= _pc_T_23;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_6_is_sfb <= io_enq_bits_shadowed_mask_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_6_pc_lob <= _pc_T_23[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_6_taken <= in_uops_5_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_6_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_6_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_147) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_6_inst <= io_enq_bits_exp_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_6_debug_inst <= io_enq_bits_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_6_is_rvc <= in_uops_4_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_1) begin
        fb_uop_ram_6_debug_pc <= _in_uops_4_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
        fb_uop_ram_6_pc_lob <= _in_uops_4_pc_lob_T_3;	// fetch-buffer.scala:57:16, :108:61
      end
      else begin
        fb_uop_ram_6_debug_pc <= _pc_T_19;	// fetch-buffer.scala:57:16, :95:43
        fb_uop_ram_6_pc_lob <= _pc_T_19[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      end
      fb_uop_ram_6_is_sfb <= io_enq_bits_shadowed_mask_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_6_taken <= in_uops_4_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_6_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_6_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_114) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_6_inst <= io_enq_bits_exp_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_6_debug_inst <= io_enq_bits_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_6_is_rvc <= in_uops_3_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_6_debug_pc <= _pc_T_15;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_6_is_sfb <= io_enq_bits_shadowed_mask_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_6_pc_lob <= _pc_T_15[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_6_taken <= in_uops_3_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_6_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_6_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_81) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_6_inst <= io_enq_bits_exp_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_6_debug_inst <= io_enq_bits_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_6_is_rvc <= in_uops_2_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_6_debug_pc <= _pc_T_11;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_6_is_sfb <= io_enq_bits_shadowed_mask_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_6_pc_lob <= _pc_T_11[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_6_taken <= in_uops_2_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_6_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_6_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_48) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_6_inst <= io_enq_bits_exp_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_6_debug_inst <= io_enq_bits_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_6_is_rvc <= in_uops_1_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_6_debug_pc <= _pc_T_7;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_6_is_sfb <= io_enq_bits_shadowed_mask_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_6_pc_lob <= _pc_T_7[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_6_taken <= in_uops_1_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_6_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_6_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_15) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_6_inst <= io_enq_bits_exp_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_6_debug_inst <= io_enq_bits_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_6_is_rvc <= in_uops_0_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_0)
        fb_uop_ram_6_debug_pc <= _in_uops_0_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
      else
        fb_uop_ram_6_debug_pc <= pc;	// fetch-buffer.scala:57:16, frontend.scala:161:39
      fb_uop_ram_6_is_sfb <= io_enq_bits_shadowed_mask_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_6_pc_lob <= in_uops_0_pc_lob;	// fetch-buffer.scala:57:16, :101:33, :106:41, :108:32
      fb_uop_ram_6_taken <= in_uops_0_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_6_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_6_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;	// fetch-buffer.scala:57:16
    end
    if (_GEN_253) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
      fb_uop_ram_6_ctrl_br_type <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_6_ctrl_op1_sel <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_6_ctrl_op2_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_6_ctrl_imm_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_6_ctrl_op_fcn <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_6_ctrl_csr_cmd <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_6_iw_state <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_6_ftq_idx <= io_enq_bits_ftq_idx;	// fetch-buffer.scala:57:16
      fb_uop_ram_6_csr_addr <= 12'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_6_rxq_idx <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_6_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_6_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_6_debug_fsrc <= io_enq_bits_fsrc;	// fetch-buffer.scala:57:16
      fb_uop_ram_6_debug_tsrc <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
    end
    fb_uop_ram_6_ctrl_fcn_dw <= ~_GEN_253 & fb_uop_ram_6_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_6_ctrl_is_load <= ~_GEN_253 & fb_uop_ram_6_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_6_ctrl_is_sta <= ~_GEN_253 & fb_uop_ram_6_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_6_ctrl_is_std <= ~_GEN_253 & fb_uop_ram_6_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_6_iw_p1_poisoned <= ~_GEN_253 & fb_uop_ram_6_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_6_iw_p2_poisoned <= ~_GEN_253 & fb_uop_ram_6_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_6_edge_inst <=
      ~(_GEN_252 | _GEN_213 | _GEN_180)
      & (_GEN_147
           ? io_enq_bits_edge_inst_1
           : ~(_GEN_114 | _GEN_81 | _GEN_48)
             & (_GEN_15 ? io_enq_bits_edge_inst_0 : fb_uop_ram_6_edge_inst));	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_6_xcpt_ma_if <= ~_GEN_253 & fb_uop_ram_6_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_254) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_7_inst <= io_enq_bits_exp_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_7_debug_inst <= io_enq_bits_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_7_is_rvc <= in_uops_7_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_7_debug_pc <= _pc_T_31;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_7_is_sfb <= io_enq_bits_shadowed_mask_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_7_pc_lob <= _pc_T_31[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_7_taken <= in_uops_7_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_7_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_7_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_214) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_7_inst <= io_enq_bits_exp_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_7_debug_inst <= io_enq_bits_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_7_is_rvc <= in_uops_6_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_7_debug_pc <= _pc_T_27;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_7_is_sfb <= io_enq_bits_shadowed_mask_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_7_pc_lob <= _pc_T_27[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_7_taken <= in_uops_6_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_7_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_7_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_181) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_7_inst <= io_enq_bits_exp_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_7_debug_inst <= io_enq_bits_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_7_is_rvc <= in_uops_5_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_7_debug_pc <= _pc_T_23;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_7_is_sfb <= io_enq_bits_shadowed_mask_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_7_pc_lob <= _pc_T_23[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_7_taken <= in_uops_5_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_7_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_7_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_148) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_7_inst <= io_enq_bits_exp_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_7_debug_inst <= io_enq_bits_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_7_is_rvc <= in_uops_4_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_1) begin
        fb_uop_ram_7_debug_pc <= _in_uops_4_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
        fb_uop_ram_7_pc_lob <= _in_uops_4_pc_lob_T_3;	// fetch-buffer.scala:57:16, :108:61
      end
      else begin
        fb_uop_ram_7_debug_pc <= _pc_T_19;	// fetch-buffer.scala:57:16, :95:43
        fb_uop_ram_7_pc_lob <= _pc_T_19[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      end
      fb_uop_ram_7_is_sfb <= io_enq_bits_shadowed_mask_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_7_taken <= in_uops_4_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_7_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_7_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_115) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_7_inst <= io_enq_bits_exp_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_7_debug_inst <= io_enq_bits_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_7_is_rvc <= in_uops_3_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_7_debug_pc <= _pc_T_15;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_7_is_sfb <= io_enq_bits_shadowed_mask_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_7_pc_lob <= _pc_T_15[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_7_taken <= in_uops_3_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_7_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_7_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_82) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_7_inst <= io_enq_bits_exp_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_7_debug_inst <= io_enq_bits_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_7_is_rvc <= in_uops_2_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_7_debug_pc <= _pc_T_11;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_7_is_sfb <= io_enq_bits_shadowed_mask_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_7_pc_lob <= _pc_T_11[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_7_taken <= in_uops_2_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_7_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_7_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_49) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_7_inst <= io_enq_bits_exp_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_7_debug_inst <= io_enq_bits_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_7_is_rvc <= in_uops_1_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_7_debug_pc <= _pc_T_7;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_7_is_sfb <= io_enq_bits_shadowed_mask_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_7_pc_lob <= _pc_T_7[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_7_taken <= in_uops_1_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_7_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_7_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_16) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_7_inst <= io_enq_bits_exp_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_7_debug_inst <= io_enq_bits_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_7_is_rvc <= in_uops_0_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_0)
        fb_uop_ram_7_debug_pc <= _in_uops_0_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
      else
        fb_uop_ram_7_debug_pc <= pc;	// fetch-buffer.scala:57:16, frontend.scala:161:39
      fb_uop_ram_7_is_sfb <= io_enq_bits_shadowed_mask_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_7_pc_lob <= in_uops_0_pc_lob;	// fetch-buffer.scala:57:16, :101:33, :106:41, :108:32
      fb_uop_ram_7_taken <= in_uops_0_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_7_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_7_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;	// fetch-buffer.scala:57:16
    end
    if (_GEN_255) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
      fb_uop_ram_7_ctrl_br_type <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_7_ctrl_op1_sel <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_7_ctrl_op2_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_7_ctrl_imm_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_7_ctrl_op_fcn <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_7_ctrl_csr_cmd <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_7_iw_state <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_7_ftq_idx <= io_enq_bits_ftq_idx;	// fetch-buffer.scala:57:16
      fb_uop_ram_7_csr_addr <= 12'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_7_rxq_idx <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_7_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_7_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_7_debug_fsrc <= io_enq_bits_fsrc;	// fetch-buffer.scala:57:16
      fb_uop_ram_7_debug_tsrc <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
    end
    fb_uop_ram_7_ctrl_fcn_dw <= ~_GEN_255 & fb_uop_ram_7_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_7_ctrl_is_load <= ~_GEN_255 & fb_uop_ram_7_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_7_ctrl_is_sta <= ~_GEN_255 & fb_uop_ram_7_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_7_ctrl_is_std <= ~_GEN_255 & fb_uop_ram_7_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_7_iw_p1_poisoned <= ~_GEN_255 & fb_uop_ram_7_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_7_iw_p2_poisoned <= ~_GEN_255 & fb_uop_ram_7_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_7_edge_inst <=
      ~(_GEN_254 | _GEN_214 | _GEN_181)
      & (_GEN_148
           ? io_enq_bits_edge_inst_1
           : ~(_GEN_115 | _GEN_82 | _GEN_49)
             & (_GEN_16 ? io_enq_bits_edge_inst_0 : fb_uop_ram_7_edge_inst));	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_7_xcpt_ma_if <= ~_GEN_255 & fb_uop_ram_7_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_256) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_8_inst <= io_enq_bits_exp_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_8_debug_inst <= io_enq_bits_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_8_is_rvc <= in_uops_7_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_8_debug_pc <= _pc_T_31;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_8_is_sfb <= io_enq_bits_shadowed_mask_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_8_pc_lob <= _pc_T_31[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_8_taken <= in_uops_7_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_8_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_8_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_215) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_8_inst <= io_enq_bits_exp_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_8_debug_inst <= io_enq_bits_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_8_is_rvc <= in_uops_6_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_8_debug_pc <= _pc_T_27;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_8_is_sfb <= io_enq_bits_shadowed_mask_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_8_pc_lob <= _pc_T_27[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_8_taken <= in_uops_6_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_8_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_8_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_182) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_8_inst <= io_enq_bits_exp_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_8_debug_inst <= io_enq_bits_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_8_is_rvc <= in_uops_5_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_8_debug_pc <= _pc_T_23;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_8_is_sfb <= io_enq_bits_shadowed_mask_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_8_pc_lob <= _pc_T_23[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_8_taken <= in_uops_5_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_8_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_8_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_149) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_8_inst <= io_enq_bits_exp_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_8_debug_inst <= io_enq_bits_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_8_is_rvc <= in_uops_4_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_1) begin
        fb_uop_ram_8_debug_pc <= _in_uops_4_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
        fb_uop_ram_8_pc_lob <= _in_uops_4_pc_lob_T_3;	// fetch-buffer.scala:57:16, :108:61
      end
      else begin
        fb_uop_ram_8_debug_pc <= _pc_T_19;	// fetch-buffer.scala:57:16, :95:43
        fb_uop_ram_8_pc_lob <= _pc_T_19[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      end
      fb_uop_ram_8_is_sfb <= io_enq_bits_shadowed_mask_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_8_taken <= in_uops_4_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_8_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_8_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_116) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_8_inst <= io_enq_bits_exp_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_8_debug_inst <= io_enq_bits_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_8_is_rvc <= in_uops_3_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_8_debug_pc <= _pc_T_15;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_8_is_sfb <= io_enq_bits_shadowed_mask_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_8_pc_lob <= _pc_T_15[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_8_taken <= in_uops_3_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_8_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_8_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_83) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_8_inst <= io_enq_bits_exp_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_8_debug_inst <= io_enq_bits_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_8_is_rvc <= in_uops_2_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_8_debug_pc <= _pc_T_11;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_8_is_sfb <= io_enq_bits_shadowed_mask_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_8_pc_lob <= _pc_T_11[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_8_taken <= in_uops_2_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_8_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_8_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_50) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_8_inst <= io_enq_bits_exp_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_8_debug_inst <= io_enq_bits_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_8_is_rvc <= in_uops_1_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_8_debug_pc <= _pc_T_7;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_8_is_sfb <= io_enq_bits_shadowed_mask_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_8_pc_lob <= _pc_T_7[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_8_taken <= in_uops_1_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_8_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_8_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_17) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_8_inst <= io_enq_bits_exp_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_8_debug_inst <= io_enq_bits_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_8_is_rvc <= in_uops_0_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_0)
        fb_uop_ram_8_debug_pc <= _in_uops_0_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
      else
        fb_uop_ram_8_debug_pc <= pc;	// fetch-buffer.scala:57:16, frontend.scala:161:39
      fb_uop_ram_8_is_sfb <= io_enq_bits_shadowed_mask_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_8_pc_lob <= in_uops_0_pc_lob;	// fetch-buffer.scala:57:16, :101:33, :106:41, :108:32
      fb_uop_ram_8_taken <= in_uops_0_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_8_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_8_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;	// fetch-buffer.scala:57:16
    end
    if (_GEN_257) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
      fb_uop_ram_8_ctrl_br_type <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_8_ctrl_op1_sel <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_8_ctrl_op2_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_8_ctrl_imm_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_8_ctrl_op_fcn <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_8_ctrl_csr_cmd <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_8_iw_state <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_8_ftq_idx <= io_enq_bits_ftq_idx;	// fetch-buffer.scala:57:16
      fb_uop_ram_8_csr_addr <= 12'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_8_rxq_idx <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_8_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_8_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_8_debug_fsrc <= io_enq_bits_fsrc;	// fetch-buffer.scala:57:16
      fb_uop_ram_8_debug_tsrc <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
    end
    fb_uop_ram_8_ctrl_fcn_dw <= ~_GEN_257 & fb_uop_ram_8_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_8_ctrl_is_load <= ~_GEN_257 & fb_uop_ram_8_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_8_ctrl_is_sta <= ~_GEN_257 & fb_uop_ram_8_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_8_ctrl_is_std <= ~_GEN_257 & fb_uop_ram_8_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_8_iw_p1_poisoned <= ~_GEN_257 & fb_uop_ram_8_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_8_iw_p2_poisoned <= ~_GEN_257 & fb_uop_ram_8_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_8_edge_inst <=
      ~(_GEN_256 | _GEN_215 | _GEN_182)
      & (_GEN_149
           ? io_enq_bits_edge_inst_1
           : ~(_GEN_116 | _GEN_83 | _GEN_50)
             & (_GEN_17 ? io_enq_bits_edge_inst_0 : fb_uop_ram_8_edge_inst));	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_8_xcpt_ma_if <= ~_GEN_257 & fb_uop_ram_8_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_258) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_9_inst <= io_enq_bits_exp_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_9_debug_inst <= io_enq_bits_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_9_is_rvc <= in_uops_7_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_9_debug_pc <= _pc_T_31;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_9_is_sfb <= io_enq_bits_shadowed_mask_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_9_pc_lob <= _pc_T_31[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_9_taken <= in_uops_7_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_9_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_9_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_216) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_9_inst <= io_enq_bits_exp_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_9_debug_inst <= io_enq_bits_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_9_is_rvc <= in_uops_6_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_9_debug_pc <= _pc_T_27;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_9_is_sfb <= io_enq_bits_shadowed_mask_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_9_pc_lob <= _pc_T_27[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_9_taken <= in_uops_6_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_9_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_9_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_183) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_9_inst <= io_enq_bits_exp_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_9_debug_inst <= io_enq_bits_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_9_is_rvc <= in_uops_5_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_9_debug_pc <= _pc_T_23;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_9_is_sfb <= io_enq_bits_shadowed_mask_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_9_pc_lob <= _pc_T_23[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_9_taken <= in_uops_5_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_9_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_9_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_150) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_9_inst <= io_enq_bits_exp_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_9_debug_inst <= io_enq_bits_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_9_is_rvc <= in_uops_4_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_1) begin
        fb_uop_ram_9_debug_pc <= _in_uops_4_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
        fb_uop_ram_9_pc_lob <= _in_uops_4_pc_lob_T_3;	// fetch-buffer.scala:57:16, :108:61
      end
      else begin
        fb_uop_ram_9_debug_pc <= _pc_T_19;	// fetch-buffer.scala:57:16, :95:43
        fb_uop_ram_9_pc_lob <= _pc_T_19[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      end
      fb_uop_ram_9_is_sfb <= io_enq_bits_shadowed_mask_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_9_taken <= in_uops_4_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_9_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_9_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_117) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_9_inst <= io_enq_bits_exp_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_9_debug_inst <= io_enq_bits_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_9_is_rvc <= in_uops_3_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_9_debug_pc <= _pc_T_15;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_9_is_sfb <= io_enq_bits_shadowed_mask_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_9_pc_lob <= _pc_T_15[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_9_taken <= in_uops_3_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_9_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_9_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_84) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_9_inst <= io_enq_bits_exp_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_9_debug_inst <= io_enq_bits_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_9_is_rvc <= in_uops_2_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_9_debug_pc <= _pc_T_11;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_9_is_sfb <= io_enq_bits_shadowed_mask_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_9_pc_lob <= _pc_T_11[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_9_taken <= in_uops_2_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_9_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_9_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_51) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_9_inst <= io_enq_bits_exp_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_9_debug_inst <= io_enq_bits_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_9_is_rvc <= in_uops_1_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_9_debug_pc <= _pc_T_7;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_9_is_sfb <= io_enq_bits_shadowed_mask_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_9_pc_lob <= _pc_T_7[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_9_taken <= in_uops_1_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_9_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_9_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_18) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_9_inst <= io_enq_bits_exp_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_9_debug_inst <= io_enq_bits_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_9_is_rvc <= in_uops_0_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_0)
        fb_uop_ram_9_debug_pc <= _in_uops_0_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
      else
        fb_uop_ram_9_debug_pc <= pc;	// fetch-buffer.scala:57:16, frontend.scala:161:39
      fb_uop_ram_9_is_sfb <= io_enq_bits_shadowed_mask_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_9_pc_lob <= in_uops_0_pc_lob;	// fetch-buffer.scala:57:16, :101:33, :106:41, :108:32
      fb_uop_ram_9_taken <= in_uops_0_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_9_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_9_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;	// fetch-buffer.scala:57:16
    end
    if (_GEN_259) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
      fb_uop_ram_9_ctrl_br_type <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_9_ctrl_op1_sel <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_9_ctrl_op2_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_9_ctrl_imm_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_9_ctrl_op_fcn <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_9_ctrl_csr_cmd <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_9_iw_state <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_9_ftq_idx <= io_enq_bits_ftq_idx;	// fetch-buffer.scala:57:16
      fb_uop_ram_9_csr_addr <= 12'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_9_rxq_idx <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_9_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_9_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_9_debug_fsrc <= io_enq_bits_fsrc;	// fetch-buffer.scala:57:16
      fb_uop_ram_9_debug_tsrc <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
    end
    fb_uop_ram_9_ctrl_fcn_dw <= ~_GEN_259 & fb_uop_ram_9_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_9_ctrl_is_load <= ~_GEN_259 & fb_uop_ram_9_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_9_ctrl_is_sta <= ~_GEN_259 & fb_uop_ram_9_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_9_ctrl_is_std <= ~_GEN_259 & fb_uop_ram_9_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_9_iw_p1_poisoned <= ~_GEN_259 & fb_uop_ram_9_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_9_iw_p2_poisoned <= ~_GEN_259 & fb_uop_ram_9_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_9_edge_inst <=
      ~(_GEN_258 | _GEN_216 | _GEN_183)
      & (_GEN_150
           ? io_enq_bits_edge_inst_1
           : ~(_GEN_117 | _GEN_84 | _GEN_51)
             & (_GEN_18 ? io_enq_bits_edge_inst_0 : fb_uop_ram_9_edge_inst));	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_9_xcpt_ma_if <= ~_GEN_259 & fb_uop_ram_9_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_260) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_10_inst <= io_enq_bits_exp_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_10_debug_inst <= io_enq_bits_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_10_is_rvc <= in_uops_7_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_10_debug_pc <= _pc_T_31;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_10_is_sfb <= io_enq_bits_shadowed_mask_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_10_pc_lob <= _pc_T_31[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_10_taken <= in_uops_7_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_10_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_10_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_217) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_10_inst <= io_enq_bits_exp_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_10_debug_inst <= io_enq_bits_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_10_is_rvc <= in_uops_6_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_10_debug_pc <= _pc_T_27;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_10_is_sfb <= io_enq_bits_shadowed_mask_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_10_pc_lob <= _pc_T_27[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_10_taken <= in_uops_6_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_10_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_10_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_184) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_10_inst <= io_enq_bits_exp_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_10_debug_inst <= io_enq_bits_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_10_is_rvc <= in_uops_5_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_10_debug_pc <= _pc_T_23;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_10_is_sfb <= io_enq_bits_shadowed_mask_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_10_pc_lob <= _pc_T_23[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_10_taken <= in_uops_5_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_10_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_10_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_151) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_10_inst <= io_enq_bits_exp_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_10_debug_inst <= io_enq_bits_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_10_is_rvc <= in_uops_4_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_1) begin
        fb_uop_ram_10_debug_pc <= _in_uops_4_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
        fb_uop_ram_10_pc_lob <= _in_uops_4_pc_lob_T_3;	// fetch-buffer.scala:57:16, :108:61
      end
      else begin
        fb_uop_ram_10_debug_pc <= _pc_T_19;	// fetch-buffer.scala:57:16, :95:43
        fb_uop_ram_10_pc_lob <= _pc_T_19[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      end
      fb_uop_ram_10_is_sfb <= io_enq_bits_shadowed_mask_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_10_taken <= in_uops_4_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_10_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_10_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_118) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_10_inst <= io_enq_bits_exp_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_10_debug_inst <= io_enq_bits_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_10_is_rvc <= in_uops_3_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_10_debug_pc <= _pc_T_15;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_10_is_sfb <= io_enq_bits_shadowed_mask_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_10_pc_lob <= _pc_T_15[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_10_taken <= in_uops_3_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_10_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_10_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_85) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_10_inst <= io_enq_bits_exp_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_10_debug_inst <= io_enq_bits_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_10_is_rvc <= in_uops_2_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_10_debug_pc <= _pc_T_11;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_10_is_sfb <= io_enq_bits_shadowed_mask_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_10_pc_lob <= _pc_T_11[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_10_taken <= in_uops_2_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_10_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_10_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_52) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_10_inst <= io_enq_bits_exp_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_10_debug_inst <= io_enq_bits_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_10_is_rvc <= in_uops_1_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_10_debug_pc <= _pc_T_7;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_10_is_sfb <= io_enq_bits_shadowed_mask_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_10_pc_lob <= _pc_T_7[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_10_taken <= in_uops_1_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_10_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_10_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_19) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_10_inst <= io_enq_bits_exp_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_10_debug_inst <= io_enq_bits_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_10_is_rvc <= in_uops_0_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_0)
        fb_uop_ram_10_debug_pc <= _in_uops_0_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
      else
        fb_uop_ram_10_debug_pc <= pc;	// fetch-buffer.scala:57:16, frontend.scala:161:39
      fb_uop_ram_10_is_sfb <= io_enq_bits_shadowed_mask_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_10_pc_lob <= in_uops_0_pc_lob;	// fetch-buffer.scala:57:16, :101:33, :106:41, :108:32
      fb_uop_ram_10_taken <= in_uops_0_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_10_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_10_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;	// fetch-buffer.scala:57:16
    end
    if (_GEN_261) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
      fb_uop_ram_10_ctrl_br_type <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_10_ctrl_op1_sel <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_10_ctrl_op2_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_10_ctrl_imm_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_10_ctrl_op_fcn <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_10_ctrl_csr_cmd <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_10_iw_state <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_10_ftq_idx <= io_enq_bits_ftq_idx;	// fetch-buffer.scala:57:16
      fb_uop_ram_10_csr_addr <= 12'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_10_rxq_idx <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_10_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_10_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_10_debug_fsrc <= io_enq_bits_fsrc;	// fetch-buffer.scala:57:16
      fb_uop_ram_10_debug_tsrc <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
    end
    fb_uop_ram_10_ctrl_fcn_dw <= ~_GEN_261 & fb_uop_ram_10_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_10_ctrl_is_load <= ~_GEN_261 & fb_uop_ram_10_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_10_ctrl_is_sta <= ~_GEN_261 & fb_uop_ram_10_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_10_ctrl_is_std <= ~_GEN_261 & fb_uop_ram_10_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_10_iw_p1_poisoned <= ~_GEN_261 & fb_uop_ram_10_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_10_iw_p2_poisoned <= ~_GEN_261 & fb_uop_ram_10_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_10_edge_inst <=
      ~(_GEN_260 | _GEN_217 | _GEN_184)
      & (_GEN_151
           ? io_enq_bits_edge_inst_1
           : ~(_GEN_118 | _GEN_85 | _GEN_52)
             & (_GEN_19 ? io_enq_bits_edge_inst_0 : fb_uop_ram_10_edge_inst));	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_10_xcpt_ma_if <= ~_GEN_261 & fb_uop_ram_10_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_262) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_11_inst <= io_enq_bits_exp_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_11_debug_inst <= io_enq_bits_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_11_is_rvc <= in_uops_7_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_11_debug_pc <= _pc_T_31;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_11_is_sfb <= io_enq_bits_shadowed_mask_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_11_pc_lob <= _pc_T_31[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_11_taken <= in_uops_7_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_11_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_11_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_218) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_11_inst <= io_enq_bits_exp_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_11_debug_inst <= io_enq_bits_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_11_is_rvc <= in_uops_6_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_11_debug_pc <= _pc_T_27;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_11_is_sfb <= io_enq_bits_shadowed_mask_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_11_pc_lob <= _pc_T_27[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_11_taken <= in_uops_6_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_11_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_11_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_185) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_11_inst <= io_enq_bits_exp_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_11_debug_inst <= io_enq_bits_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_11_is_rvc <= in_uops_5_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_11_debug_pc <= _pc_T_23;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_11_is_sfb <= io_enq_bits_shadowed_mask_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_11_pc_lob <= _pc_T_23[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_11_taken <= in_uops_5_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_11_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_11_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_152) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_11_inst <= io_enq_bits_exp_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_11_debug_inst <= io_enq_bits_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_11_is_rvc <= in_uops_4_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_1) begin
        fb_uop_ram_11_debug_pc <= _in_uops_4_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
        fb_uop_ram_11_pc_lob <= _in_uops_4_pc_lob_T_3;	// fetch-buffer.scala:57:16, :108:61
      end
      else begin
        fb_uop_ram_11_debug_pc <= _pc_T_19;	// fetch-buffer.scala:57:16, :95:43
        fb_uop_ram_11_pc_lob <= _pc_T_19[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      end
      fb_uop_ram_11_is_sfb <= io_enq_bits_shadowed_mask_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_11_taken <= in_uops_4_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_11_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_11_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_119) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_11_inst <= io_enq_bits_exp_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_11_debug_inst <= io_enq_bits_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_11_is_rvc <= in_uops_3_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_11_debug_pc <= _pc_T_15;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_11_is_sfb <= io_enq_bits_shadowed_mask_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_11_pc_lob <= _pc_T_15[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_11_taken <= in_uops_3_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_11_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_11_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_86) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_11_inst <= io_enq_bits_exp_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_11_debug_inst <= io_enq_bits_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_11_is_rvc <= in_uops_2_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_11_debug_pc <= _pc_T_11;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_11_is_sfb <= io_enq_bits_shadowed_mask_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_11_pc_lob <= _pc_T_11[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_11_taken <= in_uops_2_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_11_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_11_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_53) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_11_inst <= io_enq_bits_exp_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_11_debug_inst <= io_enq_bits_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_11_is_rvc <= in_uops_1_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_11_debug_pc <= _pc_T_7;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_11_is_sfb <= io_enq_bits_shadowed_mask_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_11_pc_lob <= _pc_T_7[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_11_taken <= in_uops_1_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_11_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_11_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_20) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_11_inst <= io_enq_bits_exp_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_11_debug_inst <= io_enq_bits_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_11_is_rvc <= in_uops_0_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_0)
        fb_uop_ram_11_debug_pc <= _in_uops_0_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
      else
        fb_uop_ram_11_debug_pc <= pc;	// fetch-buffer.scala:57:16, frontend.scala:161:39
      fb_uop_ram_11_is_sfb <= io_enq_bits_shadowed_mask_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_11_pc_lob <= in_uops_0_pc_lob;	// fetch-buffer.scala:57:16, :101:33, :106:41, :108:32
      fb_uop_ram_11_taken <= in_uops_0_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_11_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_11_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;	// fetch-buffer.scala:57:16
    end
    if (_GEN_263) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
      fb_uop_ram_11_ctrl_br_type <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_11_ctrl_op1_sel <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_11_ctrl_op2_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_11_ctrl_imm_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_11_ctrl_op_fcn <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_11_ctrl_csr_cmd <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_11_iw_state <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_11_ftq_idx <= io_enq_bits_ftq_idx;	// fetch-buffer.scala:57:16
      fb_uop_ram_11_csr_addr <= 12'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_11_rxq_idx <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_11_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_11_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_11_debug_fsrc <= io_enq_bits_fsrc;	// fetch-buffer.scala:57:16
      fb_uop_ram_11_debug_tsrc <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
    end
    fb_uop_ram_11_ctrl_fcn_dw <= ~_GEN_263 & fb_uop_ram_11_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_11_ctrl_is_load <= ~_GEN_263 & fb_uop_ram_11_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_11_ctrl_is_sta <= ~_GEN_263 & fb_uop_ram_11_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_11_ctrl_is_std <= ~_GEN_263 & fb_uop_ram_11_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_11_iw_p1_poisoned <= ~_GEN_263 & fb_uop_ram_11_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_11_iw_p2_poisoned <= ~_GEN_263 & fb_uop_ram_11_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_11_edge_inst <=
      ~(_GEN_262 | _GEN_218 | _GEN_185)
      & (_GEN_152
           ? io_enq_bits_edge_inst_1
           : ~(_GEN_119 | _GEN_86 | _GEN_53)
             & (_GEN_20 ? io_enq_bits_edge_inst_0 : fb_uop_ram_11_edge_inst));	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_11_xcpt_ma_if <= ~_GEN_263 & fb_uop_ram_11_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_264) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_12_inst <= io_enq_bits_exp_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_12_debug_inst <= io_enq_bits_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_12_is_rvc <= in_uops_7_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_12_debug_pc <= _pc_T_31;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_12_is_sfb <= io_enq_bits_shadowed_mask_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_12_pc_lob <= _pc_T_31[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_12_taken <= in_uops_7_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_12_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_12_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_219) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_12_inst <= io_enq_bits_exp_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_12_debug_inst <= io_enq_bits_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_12_is_rvc <= in_uops_6_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_12_debug_pc <= _pc_T_27;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_12_is_sfb <= io_enq_bits_shadowed_mask_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_12_pc_lob <= _pc_T_27[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_12_taken <= in_uops_6_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_12_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_12_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_186) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_12_inst <= io_enq_bits_exp_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_12_debug_inst <= io_enq_bits_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_12_is_rvc <= in_uops_5_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_12_debug_pc <= _pc_T_23;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_12_is_sfb <= io_enq_bits_shadowed_mask_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_12_pc_lob <= _pc_T_23[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_12_taken <= in_uops_5_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_12_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_12_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_153) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_12_inst <= io_enq_bits_exp_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_12_debug_inst <= io_enq_bits_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_12_is_rvc <= in_uops_4_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_1) begin
        fb_uop_ram_12_debug_pc <= _in_uops_4_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
        fb_uop_ram_12_pc_lob <= _in_uops_4_pc_lob_T_3;	// fetch-buffer.scala:57:16, :108:61
      end
      else begin
        fb_uop_ram_12_debug_pc <= _pc_T_19;	// fetch-buffer.scala:57:16, :95:43
        fb_uop_ram_12_pc_lob <= _pc_T_19[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      end
      fb_uop_ram_12_is_sfb <= io_enq_bits_shadowed_mask_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_12_taken <= in_uops_4_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_12_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_12_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_120) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_12_inst <= io_enq_bits_exp_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_12_debug_inst <= io_enq_bits_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_12_is_rvc <= in_uops_3_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_12_debug_pc <= _pc_T_15;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_12_is_sfb <= io_enq_bits_shadowed_mask_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_12_pc_lob <= _pc_T_15[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_12_taken <= in_uops_3_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_12_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_12_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_87) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_12_inst <= io_enq_bits_exp_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_12_debug_inst <= io_enq_bits_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_12_is_rvc <= in_uops_2_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_12_debug_pc <= _pc_T_11;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_12_is_sfb <= io_enq_bits_shadowed_mask_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_12_pc_lob <= _pc_T_11[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_12_taken <= in_uops_2_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_12_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_12_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_54) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_12_inst <= io_enq_bits_exp_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_12_debug_inst <= io_enq_bits_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_12_is_rvc <= in_uops_1_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_12_debug_pc <= _pc_T_7;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_12_is_sfb <= io_enq_bits_shadowed_mask_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_12_pc_lob <= _pc_T_7[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_12_taken <= in_uops_1_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_12_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_12_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_21) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_12_inst <= io_enq_bits_exp_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_12_debug_inst <= io_enq_bits_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_12_is_rvc <= in_uops_0_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_0)
        fb_uop_ram_12_debug_pc <= _in_uops_0_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
      else
        fb_uop_ram_12_debug_pc <= pc;	// fetch-buffer.scala:57:16, frontend.scala:161:39
      fb_uop_ram_12_is_sfb <= io_enq_bits_shadowed_mask_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_12_pc_lob <= in_uops_0_pc_lob;	// fetch-buffer.scala:57:16, :101:33, :106:41, :108:32
      fb_uop_ram_12_taken <= in_uops_0_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_12_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_12_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;	// fetch-buffer.scala:57:16
    end
    if (_GEN_265) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
      fb_uop_ram_12_ctrl_br_type <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_12_ctrl_op1_sel <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_12_ctrl_op2_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_12_ctrl_imm_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_12_ctrl_op_fcn <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_12_ctrl_csr_cmd <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_12_iw_state <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_12_ftq_idx <= io_enq_bits_ftq_idx;	// fetch-buffer.scala:57:16
      fb_uop_ram_12_csr_addr <= 12'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_12_rxq_idx <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_12_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_12_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_12_debug_fsrc <= io_enq_bits_fsrc;	// fetch-buffer.scala:57:16
      fb_uop_ram_12_debug_tsrc <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
    end
    fb_uop_ram_12_ctrl_fcn_dw <= ~_GEN_265 & fb_uop_ram_12_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_12_ctrl_is_load <= ~_GEN_265 & fb_uop_ram_12_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_12_ctrl_is_sta <= ~_GEN_265 & fb_uop_ram_12_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_12_ctrl_is_std <= ~_GEN_265 & fb_uop_ram_12_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_12_iw_p1_poisoned <= ~_GEN_265 & fb_uop_ram_12_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_12_iw_p2_poisoned <= ~_GEN_265 & fb_uop_ram_12_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_12_edge_inst <=
      ~(_GEN_264 | _GEN_219 | _GEN_186)
      & (_GEN_153
           ? io_enq_bits_edge_inst_1
           : ~(_GEN_120 | _GEN_87 | _GEN_54)
             & (_GEN_21 ? io_enq_bits_edge_inst_0 : fb_uop_ram_12_edge_inst));	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_12_xcpt_ma_if <= ~_GEN_265 & fb_uop_ram_12_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_266) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_13_inst <= io_enq_bits_exp_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_13_debug_inst <= io_enq_bits_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_13_is_rvc <= in_uops_7_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_13_debug_pc <= _pc_T_31;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_13_is_sfb <= io_enq_bits_shadowed_mask_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_13_pc_lob <= _pc_T_31[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_13_taken <= in_uops_7_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_13_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_13_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_220) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_13_inst <= io_enq_bits_exp_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_13_debug_inst <= io_enq_bits_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_13_is_rvc <= in_uops_6_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_13_debug_pc <= _pc_T_27;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_13_is_sfb <= io_enq_bits_shadowed_mask_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_13_pc_lob <= _pc_T_27[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_13_taken <= in_uops_6_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_13_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_13_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_187) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_13_inst <= io_enq_bits_exp_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_13_debug_inst <= io_enq_bits_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_13_is_rvc <= in_uops_5_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_13_debug_pc <= _pc_T_23;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_13_is_sfb <= io_enq_bits_shadowed_mask_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_13_pc_lob <= _pc_T_23[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_13_taken <= in_uops_5_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_13_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_13_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_154) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_13_inst <= io_enq_bits_exp_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_13_debug_inst <= io_enq_bits_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_13_is_rvc <= in_uops_4_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_1) begin
        fb_uop_ram_13_debug_pc <= _in_uops_4_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
        fb_uop_ram_13_pc_lob <= _in_uops_4_pc_lob_T_3;	// fetch-buffer.scala:57:16, :108:61
      end
      else begin
        fb_uop_ram_13_debug_pc <= _pc_T_19;	// fetch-buffer.scala:57:16, :95:43
        fb_uop_ram_13_pc_lob <= _pc_T_19[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      end
      fb_uop_ram_13_is_sfb <= io_enq_bits_shadowed_mask_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_13_taken <= in_uops_4_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_13_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_13_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_121) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_13_inst <= io_enq_bits_exp_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_13_debug_inst <= io_enq_bits_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_13_is_rvc <= in_uops_3_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_13_debug_pc <= _pc_T_15;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_13_is_sfb <= io_enq_bits_shadowed_mask_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_13_pc_lob <= _pc_T_15[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_13_taken <= in_uops_3_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_13_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_13_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_88) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_13_inst <= io_enq_bits_exp_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_13_debug_inst <= io_enq_bits_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_13_is_rvc <= in_uops_2_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_13_debug_pc <= _pc_T_11;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_13_is_sfb <= io_enq_bits_shadowed_mask_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_13_pc_lob <= _pc_T_11[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_13_taken <= in_uops_2_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_13_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_13_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_55) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_13_inst <= io_enq_bits_exp_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_13_debug_inst <= io_enq_bits_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_13_is_rvc <= in_uops_1_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_13_debug_pc <= _pc_T_7;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_13_is_sfb <= io_enq_bits_shadowed_mask_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_13_pc_lob <= _pc_T_7[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_13_taken <= in_uops_1_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_13_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_13_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_22) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_13_inst <= io_enq_bits_exp_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_13_debug_inst <= io_enq_bits_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_13_is_rvc <= in_uops_0_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_0)
        fb_uop_ram_13_debug_pc <= _in_uops_0_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
      else
        fb_uop_ram_13_debug_pc <= pc;	// fetch-buffer.scala:57:16, frontend.scala:161:39
      fb_uop_ram_13_is_sfb <= io_enq_bits_shadowed_mask_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_13_pc_lob <= in_uops_0_pc_lob;	// fetch-buffer.scala:57:16, :101:33, :106:41, :108:32
      fb_uop_ram_13_taken <= in_uops_0_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_13_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_13_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;	// fetch-buffer.scala:57:16
    end
    if (_GEN_267) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
      fb_uop_ram_13_ctrl_br_type <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_13_ctrl_op1_sel <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_13_ctrl_op2_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_13_ctrl_imm_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_13_ctrl_op_fcn <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_13_ctrl_csr_cmd <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_13_iw_state <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_13_ftq_idx <= io_enq_bits_ftq_idx;	// fetch-buffer.scala:57:16
      fb_uop_ram_13_csr_addr <= 12'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_13_rxq_idx <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_13_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_13_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_13_debug_fsrc <= io_enq_bits_fsrc;	// fetch-buffer.scala:57:16
      fb_uop_ram_13_debug_tsrc <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
    end
    fb_uop_ram_13_ctrl_fcn_dw <= ~_GEN_267 & fb_uop_ram_13_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_13_ctrl_is_load <= ~_GEN_267 & fb_uop_ram_13_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_13_ctrl_is_sta <= ~_GEN_267 & fb_uop_ram_13_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_13_ctrl_is_std <= ~_GEN_267 & fb_uop_ram_13_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_13_iw_p1_poisoned <= ~_GEN_267 & fb_uop_ram_13_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_13_iw_p2_poisoned <= ~_GEN_267 & fb_uop_ram_13_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_13_edge_inst <=
      ~(_GEN_266 | _GEN_220 | _GEN_187)
      & (_GEN_154
           ? io_enq_bits_edge_inst_1
           : ~(_GEN_121 | _GEN_88 | _GEN_55)
             & (_GEN_22 ? io_enq_bits_edge_inst_0 : fb_uop_ram_13_edge_inst));	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_13_xcpt_ma_if <= ~_GEN_267 & fb_uop_ram_13_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_268) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_14_inst <= io_enq_bits_exp_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_14_debug_inst <= io_enq_bits_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_14_is_rvc <= in_uops_7_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_14_debug_pc <= _pc_T_31;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_14_is_sfb <= io_enq_bits_shadowed_mask_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_14_pc_lob <= _pc_T_31[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_14_taken <= in_uops_7_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_14_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_14_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_221) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_14_inst <= io_enq_bits_exp_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_14_debug_inst <= io_enq_bits_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_14_is_rvc <= in_uops_6_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_14_debug_pc <= _pc_T_27;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_14_is_sfb <= io_enq_bits_shadowed_mask_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_14_pc_lob <= _pc_T_27[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_14_taken <= in_uops_6_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_14_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_14_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_188) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_14_inst <= io_enq_bits_exp_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_14_debug_inst <= io_enq_bits_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_14_is_rvc <= in_uops_5_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_14_debug_pc <= _pc_T_23;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_14_is_sfb <= io_enq_bits_shadowed_mask_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_14_pc_lob <= _pc_T_23[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_14_taken <= in_uops_5_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_14_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_14_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_155) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_14_inst <= io_enq_bits_exp_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_14_debug_inst <= io_enq_bits_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_14_is_rvc <= in_uops_4_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_1) begin
        fb_uop_ram_14_debug_pc <= _in_uops_4_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
        fb_uop_ram_14_pc_lob <= _in_uops_4_pc_lob_T_3;	// fetch-buffer.scala:57:16, :108:61
      end
      else begin
        fb_uop_ram_14_debug_pc <= _pc_T_19;	// fetch-buffer.scala:57:16, :95:43
        fb_uop_ram_14_pc_lob <= _pc_T_19[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      end
      fb_uop_ram_14_is_sfb <= io_enq_bits_shadowed_mask_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_14_taken <= in_uops_4_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_14_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_14_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_122) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_14_inst <= io_enq_bits_exp_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_14_debug_inst <= io_enq_bits_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_14_is_rvc <= in_uops_3_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_14_debug_pc <= _pc_T_15;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_14_is_sfb <= io_enq_bits_shadowed_mask_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_14_pc_lob <= _pc_T_15[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_14_taken <= in_uops_3_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_14_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_14_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_89) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_14_inst <= io_enq_bits_exp_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_14_debug_inst <= io_enq_bits_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_14_is_rvc <= in_uops_2_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_14_debug_pc <= _pc_T_11;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_14_is_sfb <= io_enq_bits_shadowed_mask_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_14_pc_lob <= _pc_T_11[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_14_taken <= in_uops_2_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_14_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_14_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_56) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_14_inst <= io_enq_bits_exp_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_14_debug_inst <= io_enq_bits_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_14_is_rvc <= in_uops_1_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_14_debug_pc <= _pc_T_7;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_14_is_sfb <= io_enq_bits_shadowed_mask_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_14_pc_lob <= _pc_T_7[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_14_taken <= in_uops_1_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_14_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_14_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_23) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_14_inst <= io_enq_bits_exp_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_14_debug_inst <= io_enq_bits_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_14_is_rvc <= in_uops_0_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_0)
        fb_uop_ram_14_debug_pc <= _in_uops_0_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
      else
        fb_uop_ram_14_debug_pc <= pc;	// fetch-buffer.scala:57:16, frontend.scala:161:39
      fb_uop_ram_14_is_sfb <= io_enq_bits_shadowed_mask_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_14_pc_lob <= in_uops_0_pc_lob;	// fetch-buffer.scala:57:16, :101:33, :106:41, :108:32
      fb_uop_ram_14_taken <= in_uops_0_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_14_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_14_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;	// fetch-buffer.scala:57:16
    end
    if (_GEN_269) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
      fb_uop_ram_14_ctrl_br_type <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_14_ctrl_op1_sel <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_14_ctrl_op2_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_14_ctrl_imm_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_14_ctrl_op_fcn <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_14_ctrl_csr_cmd <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_14_iw_state <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_14_ftq_idx <= io_enq_bits_ftq_idx;	// fetch-buffer.scala:57:16
      fb_uop_ram_14_csr_addr <= 12'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_14_rxq_idx <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_14_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_14_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_14_debug_fsrc <= io_enq_bits_fsrc;	// fetch-buffer.scala:57:16
      fb_uop_ram_14_debug_tsrc <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
    end
    fb_uop_ram_14_ctrl_fcn_dw <= ~_GEN_269 & fb_uop_ram_14_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_14_ctrl_is_load <= ~_GEN_269 & fb_uop_ram_14_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_14_ctrl_is_sta <= ~_GEN_269 & fb_uop_ram_14_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_14_ctrl_is_std <= ~_GEN_269 & fb_uop_ram_14_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_14_iw_p1_poisoned <= ~_GEN_269 & fb_uop_ram_14_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_14_iw_p2_poisoned <= ~_GEN_269 & fb_uop_ram_14_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_14_edge_inst <=
      ~(_GEN_268 | _GEN_221 | _GEN_188)
      & (_GEN_155
           ? io_enq_bits_edge_inst_1
           : ~(_GEN_122 | _GEN_89 | _GEN_56)
             & (_GEN_23 ? io_enq_bits_edge_inst_0 : fb_uop_ram_14_edge_inst));	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_14_xcpt_ma_if <= ~_GEN_269 & fb_uop_ram_14_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_270) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_15_inst <= io_enq_bits_exp_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_15_debug_inst <= io_enq_bits_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_15_is_rvc <= in_uops_7_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_15_debug_pc <= _pc_T_31;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_15_is_sfb <= io_enq_bits_shadowed_mask_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_15_pc_lob <= _pc_T_31[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_15_taken <= in_uops_7_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_15_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_15_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_222) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_15_inst <= io_enq_bits_exp_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_15_debug_inst <= io_enq_bits_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_15_is_rvc <= in_uops_6_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_15_debug_pc <= _pc_T_27;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_15_is_sfb <= io_enq_bits_shadowed_mask_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_15_pc_lob <= _pc_T_27[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_15_taken <= in_uops_6_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_15_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_15_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_189) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_15_inst <= io_enq_bits_exp_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_15_debug_inst <= io_enq_bits_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_15_is_rvc <= in_uops_5_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_15_debug_pc <= _pc_T_23;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_15_is_sfb <= io_enq_bits_shadowed_mask_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_15_pc_lob <= _pc_T_23[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_15_taken <= in_uops_5_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_15_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_15_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_156) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_15_inst <= io_enq_bits_exp_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_15_debug_inst <= io_enq_bits_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_15_is_rvc <= in_uops_4_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_1) begin
        fb_uop_ram_15_debug_pc <= _in_uops_4_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
        fb_uop_ram_15_pc_lob <= _in_uops_4_pc_lob_T_3;	// fetch-buffer.scala:57:16, :108:61
      end
      else begin
        fb_uop_ram_15_debug_pc <= _pc_T_19;	// fetch-buffer.scala:57:16, :95:43
        fb_uop_ram_15_pc_lob <= _pc_T_19[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      end
      fb_uop_ram_15_is_sfb <= io_enq_bits_shadowed_mask_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_15_taken <= in_uops_4_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_15_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_15_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_123) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_15_inst <= io_enq_bits_exp_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_15_debug_inst <= io_enq_bits_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_15_is_rvc <= in_uops_3_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_15_debug_pc <= _pc_T_15;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_15_is_sfb <= io_enq_bits_shadowed_mask_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_15_pc_lob <= _pc_T_15[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_15_taken <= in_uops_3_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_15_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_15_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_90) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_15_inst <= io_enq_bits_exp_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_15_debug_inst <= io_enq_bits_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_15_is_rvc <= in_uops_2_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_15_debug_pc <= _pc_T_11;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_15_is_sfb <= io_enq_bits_shadowed_mask_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_15_pc_lob <= _pc_T_11[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_15_taken <= in_uops_2_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_15_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_15_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_57) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_15_inst <= io_enq_bits_exp_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_15_debug_inst <= io_enq_bits_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_15_is_rvc <= in_uops_1_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_15_debug_pc <= _pc_T_7;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_15_is_sfb <= io_enq_bits_shadowed_mask_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_15_pc_lob <= _pc_T_7[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_15_taken <= in_uops_1_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_15_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_15_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_24) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_15_inst <= io_enq_bits_exp_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_15_debug_inst <= io_enq_bits_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_15_is_rvc <= in_uops_0_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_0)
        fb_uop_ram_15_debug_pc <= _in_uops_0_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
      else
        fb_uop_ram_15_debug_pc <= pc;	// fetch-buffer.scala:57:16, frontend.scala:161:39
      fb_uop_ram_15_is_sfb <= io_enq_bits_shadowed_mask_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_15_pc_lob <= in_uops_0_pc_lob;	// fetch-buffer.scala:57:16, :101:33, :106:41, :108:32
      fb_uop_ram_15_taken <= in_uops_0_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_15_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_15_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;	// fetch-buffer.scala:57:16
    end
    if (_GEN_271) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
      fb_uop_ram_15_ctrl_br_type <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_15_ctrl_op1_sel <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_15_ctrl_op2_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_15_ctrl_imm_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_15_ctrl_op_fcn <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_15_ctrl_csr_cmd <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_15_iw_state <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_15_ftq_idx <= io_enq_bits_ftq_idx;	// fetch-buffer.scala:57:16
      fb_uop_ram_15_csr_addr <= 12'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_15_rxq_idx <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_15_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_15_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_15_debug_fsrc <= io_enq_bits_fsrc;	// fetch-buffer.scala:57:16
      fb_uop_ram_15_debug_tsrc <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
    end
    fb_uop_ram_15_ctrl_fcn_dw <= ~_GEN_271 & fb_uop_ram_15_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_15_ctrl_is_load <= ~_GEN_271 & fb_uop_ram_15_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_15_ctrl_is_sta <= ~_GEN_271 & fb_uop_ram_15_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_15_ctrl_is_std <= ~_GEN_271 & fb_uop_ram_15_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_15_iw_p1_poisoned <= ~_GEN_271 & fb_uop_ram_15_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_15_iw_p2_poisoned <= ~_GEN_271 & fb_uop_ram_15_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_15_edge_inst <=
      ~(_GEN_270 | _GEN_222 | _GEN_189)
      & (_GEN_156
           ? io_enq_bits_edge_inst_1
           : ~(_GEN_123 | _GEN_90 | _GEN_57)
             & (_GEN_24 ? io_enq_bits_edge_inst_0 : fb_uop_ram_15_edge_inst));	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_15_xcpt_ma_if <= ~_GEN_271 & fb_uop_ram_15_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_272) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_16_inst <= io_enq_bits_exp_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_16_debug_inst <= io_enq_bits_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_16_is_rvc <= in_uops_7_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_16_debug_pc <= _pc_T_31;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_16_is_sfb <= io_enq_bits_shadowed_mask_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_16_pc_lob <= _pc_T_31[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_16_taken <= in_uops_7_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_16_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_16_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_223) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_16_inst <= io_enq_bits_exp_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_16_debug_inst <= io_enq_bits_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_16_is_rvc <= in_uops_6_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_16_debug_pc <= _pc_T_27;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_16_is_sfb <= io_enq_bits_shadowed_mask_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_16_pc_lob <= _pc_T_27[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_16_taken <= in_uops_6_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_16_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_16_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_190) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_16_inst <= io_enq_bits_exp_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_16_debug_inst <= io_enq_bits_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_16_is_rvc <= in_uops_5_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_16_debug_pc <= _pc_T_23;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_16_is_sfb <= io_enq_bits_shadowed_mask_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_16_pc_lob <= _pc_T_23[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_16_taken <= in_uops_5_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_16_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_16_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_157) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_16_inst <= io_enq_bits_exp_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_16_debug_inst <= io_enq_bits_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_16_is_rvc <= in_uops_4_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_1) begin
        fb_uop_ram_16_debug_pc <= _in_uops_4_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
        fb_uop_ram_16_pc_lob <= _in_uops_4_pc_lob_T_3;	// fetch-buffer.scala:57:16, :108:61
      end
      else begin
        fb_uop_ram_16_debug_pc <= _pc_T_19;	// fetch-buffer.scala:57:16, :95:43
        fb_uop_ram_16_pc_lob <= _pc_T_19[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      end
      fb_uop_ram_16_is_sfb <= io_enq_bits_shadowed_mask_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_16_taken <= in_uops_4_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_16_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_16_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_124) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_16_inst <= io_enq_bits_exp_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_16_debug_inst <= io_enq_bits_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_16_is_rvc <= in_uops_3_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_16_debug_pc <= _pc_T_15;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_16_is_sfb <= io_enq_bits_shadowed_mask_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_16_pc_lob <= _pc_T_15[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_16_taken <= in_uops_3_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_16_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_16_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_91) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_16_inst <= io_enq_bits_exp_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_16_debug_inst <= io_enq_bits_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_16_is_rvc <= in_uops_2_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_16_debug_pc <= _pc_T_11;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_16_is_sfb <= io_enq_bits_shadowed_mask_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_16_pc_lob <= _pc_T_11[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_16_taken <= in_uops_2_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_16_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_16_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_58) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_16_inst <= io_enq_bits_exp_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_16_debug_inst <= io_enq_bits_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_16_is_rvc <= in_uops_1_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_16_debug_pc <= _pc_T_7;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_16_is_sfb <= io_enq_bits_shadowed_mask_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_16_pc_lob <= _pc_T_7[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_16_taken <= in_uops_1_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_16_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_16_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_25) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_16_inst <= io_enq_bits_exp_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_16_debug_inst <= io_enq_bits_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_16_is_rvc <= in_uops_0_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_0)
        fb_uop_ram_16_debug_pc <= _in_uops_0_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
      else
        fb_uop_ram_16_debug_pc <= pc;	// fetch-buffer.scala:57:16, frontend.scala:161:39
      fb_uop_ram_16_is_sfb <= io_enq_bits_shadowed_mask_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_16_pc_lob <= in_uops_0_pc_lob;	// fetch-buffer.scala:57:16, :101:33, :106:41, :108:32
      fb_uop_ram_16_taken <= in_uops_0_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_16_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_16_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;	// fetch-buffer.scala:57:16
    end
    if (_GEN_273) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
      fb_uop_ram_16_ctrl_br_type <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_16_ctrl_op1_sel <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_16_ctrl_op2_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_16_ctrl_imm_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_16_ctrl_op_fcn <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_16_ctrl_csr_cmd <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_16_iw_state <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_16_ftq_idx <= io_enq_bits_ftq_idx;	// fetch-buffer.scala:57:16
      fb_uop_ram_16_csr_addr <= 12'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_16_rxq_idx <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_16_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_16_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_16_debug_fsrc <= io_enq_bits_fsrc;	// fetch-buffer.scala:57:16
      fb_uop_ram_16_debug_tsrc <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
    end
    fb_uop_ram_16_ctrl_fcn_dw <= ~_GEN_273 & fb_uop_ram_16_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_16_ctrl_is_load <= ~_GEN_273 & fb_uop_ram_16_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_16_ctrl_is_sta <= ~_GEN_273 & fb_uop_ram_16_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_16_ctrl_is_std <= ~_GEN_273 & fb_uop_ram_16_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_16_iw_p1_poisoned <= ~_GEN_273 & fb_uop_ram_16_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_16_iw_p2_poisoned <= ~_GEN_273 & fb_uop_ram_16_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_16_edge_inst <=
      ~(_GEN_272 | _GEN_223 | _GEN_190)
      & (_GEN_157
           ? io_enq_bits_edge_inst_1
           : ~(_GEN_124 | _GEN_91 | _GEN_58)
             & (_GEN_25 ? io_enq_bits_edge_inst_0 : fb_uop_ram_16_edge_inst));	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_16_xcpt_ma_if <= ~_GEN_273 & fb_uop_ram_16_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_274) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_17_inst <= io_enq_bits_exp_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_17_debug_inst <= io_enq_bits_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_17_is_rvc <= in_uops_7_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_17_debug_pc <= _pc_T_31;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_17_is_sfb <= io_enq_bits_shadowed_mask_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_17_pc_lob <= _pc_T_31[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_17_taken <= in_uops_7_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_17_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_17_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_224) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_17_inst <= io_enq_bits_exp_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_17_debug_inst <= io_enq_bits_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_17_is_rvc <= in_uops_6_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_17_debug_pc <= _pc_T_27;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_17_is_sfb <= io_enq_bits_shadowed_mask_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_17_pc_lob <= _pc_T_27[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_17_taken <= in_uops_6_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_17_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_17_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_191) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_17_inst <= io_enq_bits_exp_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_17_debug_inst <= io_enq_bits_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_17_is_rvc <= in_uops_5_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_17_debug_pc <= _pc_T_23;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_17_is_sfb <= io_enq_bits_shadowed_mask_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_17_pc_lob <= _pc_T_23[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_17_taken <= in_uops_5_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_17_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_17_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_158) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_17_inst <= io_enq_bits_exp_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_17_debug_inst <= io_enq_bits_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_17_is_rvc <= in_uops_4_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_1) begin
        fb_uop_ram_17_debug_pc <= _in_uops_4_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
        fb_uop_ram_17_pc_lob <= _in_uops_4_pc_lob_T_3;	// fetch-buffer.scala:57:16, :108:61
      end
      else begin
        fb_uop_ram_17_debug_pc <= _pc_T_19;	// fetch-buffer.scala:57:16, :95:43
        fb_uop_ram_17_pc_lob <= _pc_T_19[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      end
      fb_uop_ram_17_is_sfb <= io_enq_bits_shadowed_mask_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_17_taken <= in_uops_4_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_17_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_17_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_125) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_17_inst <= io_enq_bits_exp_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_17_debug_inst <= io_enq_bits_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_17_is_rvc <= in_uops_3_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_17_debug_pc <= _pc_T_15;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_17_is_sfb <= io_enq_bits_shadowed_mask_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_17_pc_lob <= _pc_T_15[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_17_taken <= in_uops_3_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_17_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_17_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_92) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_17_inst <= io_enq_bits_exp_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_17_debug_inst <= io_enq_bits_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_17_is_rvc <= in_uops_2_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_17_debug_pc <= _pc_T_11;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_17_is_sfb <= io_enq_bits_shadowed_mask_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_17_pc_lob <= _pc_T_11[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_17_taken <= in_uops_2_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_17_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_17_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_59) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_17_inst <= io_enq_bits_exp_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_17_debug_inst <= io_enq_bits_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_17_is_rvc <= in_uops_1_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_17_debug_pc <= _pc_T_7;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_17_is_sfb <= io_enq_bits_shadowed_mask_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_17_pc_lob <= _pc_T_7[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_17_taken <= in_uops_1_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_17_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_17_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_26) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_17_inst <= io_enq_bits_exp_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_17_debug_inst <= io_enq_bits_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_17_is_rvc <= in_uops_0_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_0)
        fb_uop_ram_17_debug_pc <= _in_uops_0_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
      else
        fb_uop_ram_17_debug_pc <= pc;	// fetch-buffer.scala:57:16, frontend.scala:161:39
      fb_uop_ram_17_is_sfb <= io_enq_bits_shadowed_mask_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_17_pc_lob <= in_uops_0_pc_lob;	// fetch-buffer.scala:57:16, :101:33, :106:41, :108:32
      fb_uop_ram_17_taken <= in_uops_0_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_17_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_17_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;	// fetch-buffer.scala:57:16
    end
    if (_GEN_275) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
      fb_uop_ram_17_ctrl_br_type <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_17_ctrl_op1_sel <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_17_ctrl_op2_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_17_ctrl_imm_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_17_ctrl_op_fcn <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_17_ctrl_csr_cmd <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_17_iw_state <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_17_ftq_idx <= io_enq_bits_ftq_idx;	// fetch-buffer.scala:57:16
      fb_uop_ram_17_csr_addr <= 12'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_17_rxq_idx <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_17_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_17_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_17_debug_fsrc <= io_enq_bits_fsrc;	// fetch-buffer.scala:57:16
      fb_uop_ram_17_debug_tsrc <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
    end
    fb_uop_ram_17_ctrl_fcn_dw <= ~_GEN_275 & fb_uop_ram_17_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_17_ctrl_is_load <= ~_GEN_275 & fb_uop_ram_17_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_17_ctrl_is_sta <= ~_GEN_275 & fb_uop_ram_17_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_17_ctrl_is_std <= ~_GEN_275 & fb_uop_ram_17_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_17_iw_p1_poisoned <= ~_GEN_275 & fb_uop_ram_17_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_17_iw_p2_poisoned <= ~_GEN_275 & fb_uop_ram_17_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_17_edge_inst <=
      ~(_GEN_274 | _GEN_224 | _GEN_191)
      & (_GEN_158
           ? io_enq_bits_edge_inst_1
           : ~(_GEN_125 | _GEN_92 | _GEN_59)
             & (_GEN_26 ? io_enq_bits_edge_inst_0 : fb_uop_ram_17_edge_inst));	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_17_xcpt_ma_if <= ~_GEN_275 & fb_uop_ram_17_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_276) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_18_inst <= io_enq_bits_exp_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_18_debug_inst <= io_enq_bits_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_18_is_rvc <= in_uops_7_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_18_debug_pc <= _pc_T_31;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_18_is_sfb <= io_enq_bits_shadowed_mask_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_18_pc_lob <= _pc_T_31[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_18_taken <= in_uops_7_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_18_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_18_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_225) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_18_inst <= io_enq_bits_exp_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_18_debug_inst <= io_enq_bits_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_18_is_rvc <= in_uops_6_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_18_debug_pc <= _pc_T_27;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_18_is_sfb <= io_enq_bits_shadowed_mask_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_18_pc_lob <= _pc_T_27[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_18_taken <= in_uops_6_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_18_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_18_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_192) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_18_inst <= io_enq_bits_exp_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_18_debug_inst <= io_enq_bits_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_18_is_rvc <= in_uops_5_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_18_debug_pc <= _pc_T_23;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_18_is_sfb <= io_enq_bits_shadowed_mask_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_18_pc_lob <= _pc_T_23[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_18_taken <= in_uops_5_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_18_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_18_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_159) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_18_inst <= io_enq_bits_exp_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_18_debug_inst <= io_enq_bits_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_18_is_rvc <= in_uops_4_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_1) begin
        fb_uop_ram_18_debug_pc <= _in_uops_4_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
        fb_uop_ram_18_pc_lob <= _in_uops_4_pc_lob_T_3;	// fetch-buffer.scala:57:16, :108:61
      end
      else begin
        fb_uop_ram_18_debug_pc <= _pc_T_19;	// fetch-buffer.scala:57:16, :95:43
        fb_uop_ram_18_pc_lob <= _pc_T_19[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      end
      fb_uop_ram_18_is_sfb <= io_enq_bits_shadowed_mask_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_18_taken <= in_uops_4_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_18_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_18_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_126) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_18_inst <= io_enq_bits_exp_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_18_debug_inst <= io_enq_bits_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_18_is_rvc <= in_uops_3_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_18_debug_pc <= _pc_T_15;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_18_is_sfb <= io_enq_bits_shadowed_mask_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_18_pc_lob <= _pc_T_15[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_18_taken <= in_uops_3_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_18_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_18_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_93) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_18_inst <= io_enq_bits_exp_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_18_debug_inst <= io_enq_bits_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_18_is_rvc <= in_uops_2_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_18_debug_pc <= _pc_T_11;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_18_is_sfb <= io_enq_bits_shadowed_mask_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_18_pc_lob <= _pc_T_11[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_18_taken <= in_uops_2_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_18_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_18_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_60) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_18_inst <= io_enq_bits_exp_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_18_debug_inst <= io_enq_bits_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_18_is_rvc <= in_uops_1_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_18_debug_pc <= _pc_T_7;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_18_is_sfb <= io_enq_bits_shadowed_mask_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_18_pc_lob <= _pc_T_7[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_18_taken <= in_uops_1_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_18_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_18_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_27) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_18_inst <= io_enq_bits_exp_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_18_debug_inst <= io_enq_bits_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_18_is_rvc <= in_uops_0_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_0)
        fb_uop_ram_18_debug_pc <= _in_uops_0_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
      else
        fb_uop_ram_18_debug_pc <= pc;	// fetch-buffer.scala:57:16, frontend.scala:161:39
      fb_uop_ram_18_is_sfb <= io_enq_bits_shadowed_mask_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_18_pc_lob <= in_uops_0_pc_lob;	// fetch-buffer.scala:57:16, :101:33, :106:41, :108:32
      fb_uop_ram_18_taken <= in_uops_0_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_18_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_18_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;	// fetch-buffer.scala:57:16
    end
    if (_GEN_277) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
      fb_uop_ram_18_ctrl_br_type <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_18_ctrl_op1_sel <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_18_ctrl_op2_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_18_ctrl_imm_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_18_ctrl_op_fcn <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_18_ctrl_csr_cmd <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_18_iw_state <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_18_ftq_idx <= io_enq_bits_ftq_idx;	// fetch-buffer.scala:57:16
      fb_uop_ram_18_csr_addr <= 12'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_18_rxq_idx <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_18_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_18_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_18_debug_fsrc <= io_enq_bits_fsrc;	// fetch-buffer.scala:57:16
      fb_uop_ram_18_debug_tsrc <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
    end
    fb_uop_ram_18_ctrl_fcn_dw <= ~_GEN_277 & fb_uop_ram_18_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_18_ctrl_is_load <= ~_GEN_277 & fb_uop_ram_18_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_18_ctrl_is_sta <= ~_GEN_277 & fb_uop_ram_18_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_18_ctrl_is_std <= ~_GEN_277 & fb_uop_ram_18_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_18_iw_p1_poisoned <= ~_GEN_277 & fb_uop_ram_18_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_18_iw_p2_poisoned <= ~_GEN_277 & fb_uop_ram_18_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_18_edge_inst <=
      ~(_GEN_276 | _GEN_225 | _GEN_192)
      & (_GEN_159
           ? io_enq_bits_edge_inst_1
           : ~(_GEN_126 | _GEN_93 | _GEN_60)
             & (_GEN_27 ? io_enq_bits_edge_inst_0 : fb_uop_ram_18_edge_inst));	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_18_xcpt_ma_if <= ~_GEN_277 & fb_uop_ram_18_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_278) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_19_inst <= io_enq_bits_exp_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_19_debug_inst <= io_enq_bits_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_19_is_rvc <= in_uops_7_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_19_debug_pc <= _pc_T_31;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_19_is_sfb <= io_enq_bits_shadowed_mask_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_19_pc_lob <= _pc_T_31[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_19_taken <= in_uops_7_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_19_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_19_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_226) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_19_inst <= io_enq_bits_exp_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_19_debug_inst <= io_enq_bits_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_19_is_rvc <= in_uops_6_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_19_debug_pc <= _pc_T_27;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_19_is_sfb <= io_enq_bits_shadowed_mask_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_19_pc_lob <= _pc_T_27[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_19_taken <= in_uops_6_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_19_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_19_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_193) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_19_inst <= io_enq_bits_exp_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_19_debug_inst <= io_enq_bits_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_19_is_rvc <= in_uops_5_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_19_debug_pc <= _pc_T_23;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_19_is_sfb <= io_enq_bits_shadowed_mask_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_19_pc_lob <= _pc_T_23[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_19_taken <= in_uops_5_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_19_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_19_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_160) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_19_inst <= io_enq_bits_exp_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_19_debug_inst <= io_enq_bits_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_19_is_rvc <= in_uops_4_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_1) begin
        fb_uop_ram_19_debug_pc <= _in_uops_4_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
        fb_uop_ram_19_pc_lob <= _in_uops_4_pc_lob_T_3;	// fetch-buffer.scala:57:16, :108:61
      end
      else begin
        fb_uop_ram_19_debug_pc <= _pc_T_19;	// fetch-buffer.scala:57:16, :95:43
        fb_uop_ram_19_pc_lob <= _pc_T_19[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      end
      fb_uop_ram_19_is_sfb <= io_enq_bits_shadowed_mask_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_19_taken <= in_uops_4_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_19_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_19_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_127) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_19_inst <= io_enq_bits_exp_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_19_debug_inst <= io_enq_bits_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_19_is_rvc <= in_uops_3_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_19_debug_pc <= _pc_T_15;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_19_is_sfb <= io_enq_bits_shadowed_mask_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_19_pc_lob <= _pc_T_15[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_19_taken <= in_uops_3_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_19_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_19_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_94) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_19_inst <= io_enq_bits_exp_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_19_debug_inst <= io_enq_bits_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_19_is_rvc <= in_uops_2_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_19_debug_pc <= _pc_T_11;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_19_is_sfb <= io_enq_bits_shadowed_mask_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_19_pc_lob <= _pc_T_11[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_19_taken <= in_uops_2_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_19_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_19_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_61) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_19_inst <= io_enq_bits_exp_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_19_debug_inst <= io_enq_bits_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_19_is_rvc <= in_uops_1_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_19_debug_pc <= _pc_T_7;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_19_is_sfb <= io_enq_bits_shadowed_mask_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_19_pc_lob <= _pc_T_7[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_19_taken <= in_uops_1_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_19_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_19_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_28) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_19_inst <= io_enq_bits_exp_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_19_debug_inst <= io_enq_bits_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_19_is_rvc <= in_uops_0_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_0)
        fb_uop_ram_19_debug_pc <= _in_uops_0_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
      else
        fb_uop_ram_19_debug_pc <= pc;	// fetch-buffer.scala:57:16, frontend.scala:161:39
      fb_uop_ram_19_is_sfb <= io_enq_bits_shadowed_mask_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_19_pc_lob <= in_uops_0_pc_lob;	// fetch-buffer.scala:57:16, :101:33, :106:41, :108:32
      fb_uop_ram_19_taken <= in_uops_0_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_19_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_19_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;	// fetch-buffer.scala:57:16
    end
    if (_GEN_279) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
      fb_uop_ram_19_ctrl_br_type <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_19_ctrl_op1_sel <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_19_ctrl_op2_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_19_ctrl_imm_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_19_ctrl_op_fcn <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_19_ctrl_csr_cmd <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_19_iw_state <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_19_ftq_idx <= io_enq_bits_ftq_idx;	// fetch-buffer.scala:57:16
      fb_uop_ram_19_csr_addr <= 12'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_19_rxq_idx <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_19_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_19_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_19_debug_fsrc <= io_enq_bits_fsrc;	// fetch-buffer.scala:57:16
      fb_uop_ram_19_debug_tsrc <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
    end
    fb_uop_ram_19_ctrl_fcn_dw <= ~_GEN_279 & fb_uop_ram_19_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_19_ctrl_is_load <= ~_GEN_279 & fb_uop_ram_19_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_19_ctrl_is_sta <= ~_GEN_279 & fb_uop_ram_19_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_19_ctrl_is_std <= ~_GEN_279 & fb_uop_ram_19_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_19_iw_p1_poisoned <= ~_GEN_279 & fb_uop_ram_19_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_19_iw_p2_poisoned <= ~_GEN_279 & fb_uop_ram_19_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_19_edge_inst <=
      ~(_GEN_278 | _GEN_226 | _GEN_193)
      & (_GEN_160
           ? io_enq_bits_edge_inst_1
           : ~(_GEN_127 | _GEN_94 | _GEN_61)
             & (_GEN_28 ? io_enq_bits_edge_inst_0 : fb_uop_ram_19_edge_inst));	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_19_xcpt_ma_if <= ~_GEN_279 & fb_uop_ram_19_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_280) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_20_inst <= io_enq_bits_exp_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_20_debug_inst <= io_enq_bits_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_20_is_rvc <= in_uops_7_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_20_debug_pc <= _pc_T_31;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_20_is_sfb <= io_enq_bits_shadowed_mask_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_20_pc_lob <= _pc_T_31[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_20_taken <= in_uops_7_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_20_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_20_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_227) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_20_inst <= io_enq_bits_exp_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_20_debug_inst <= io_enq_bits_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_20_is_rvc <= in_uops_6_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_20_debug_pc <= _pc_T_27;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_20_is_sfb <= io_enq_bits_shadowed_mask_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_20_pc_lob <= _pc_T_27[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_20_taken <= in_uops_6_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_20_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_20_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_194) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_20_inst <= io_enq_bits_exp_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_20_debug_inst <= io_enq_bits_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_20_is_rvc <= in_uops_5_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_20_debug_pc <= _pc_T_23;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_20_is_sfb <= io_enq_bits_shadowed_mask_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_20_pc_lob <= _pc_T_23[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_20_taken <= in_uops_5_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_20_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_20_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_161) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_20_inst <= io_enq_bits_exp_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_20_debug_inst <= io_enq_bits_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_20_is_rvc <= in_uops_4_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_1) begin
        fb_uop_ram_20_debug_pc <= _in_uops_4_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
        fb_uop_ram_20_pc_lob <= _in_uops_4_pc_lob_T_3;	// fetch-buffer.scala:57:16, :108:61
      end
      else begin
        fb_uop_ram_20_debug_pc <= _pc_T_19;	// fetch-buffer.scala:57:16, :95:43
        fb_uop_ram_20_pc_lob <= _pc_T_19[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      end
      fb_uop_ram_20_is_sfb <= io_enq_bits_shadowed_mask_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_20_taken <= in_uops_4_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_20_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_20_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_128) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_20_inst <= io_enq_bits_exp_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_20_debug_inst <= io_enq_bits_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_20_is_rvc <= in_uops_3_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_20_debug_pc <= _pc_T_15;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_20_is_sfb <= io_enq_bits_shadowed_mask_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_20_pc_lob <= _pc_T_15[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_20_taken <= in_uops_3_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_20_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_20_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_95) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_20_inst <= io_enq_bits_exp_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_20_debug_inst <= io_enq_bits_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_20_is_rvc <= in_uops_2_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_20_debug_pc <= _pc_T_11;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_20_is_sfb <= io_enq_bits_shadowed_mask_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_20_pc_lob <= _pc_T_11[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_20_taken <= in_uops_2_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_20_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_20_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_62) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_20_inst <= io_enq_bits_exp_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_20_debug_inst <= io_enq_bits_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_20_is_rvc <= in_uops_1_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_20_debug_pc <= _pc_T_7;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_20_is_sfb <= io_enq_bits_shadowed_mask_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_20_pc_lob <= _pc_T_7[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_20_taken <= in_uops_1_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_20_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_20_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_29) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_20_inst <= io_enq_bits_exp_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_20_debug_inst <= io_enq_bits_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_20_is_rvc <= in_uops_0_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_0)
        fb_uop_ram_20_debug_pc <= _in_uops_0_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
      else
        fb_uop_ram_20_debug_pc <= pc;	// fetch-buffer.scala:57:16, frontend.scala:161:39
      fb_uop_ram_20_is_sfb <= io_enq_bits_shadowed_mask_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_20_pc_lob <= in_uops_0_pc_lob;	// fetch-buffer.scala:57:16, :101:33, :106:41, :108:32
      fb_uop_ram_20_taken <= in_uops_0_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_20_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_20_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;	// fetch-buffer.scala:57:16
    end
    if (_GEN_281) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
      fb_uop_ram_20_ctrl_br_type <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_20_ctrl_op1_sel <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_20_ctrl_op2_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_20_ctrl_imm_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_20_ctrl_op_fcn <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_20_ctrl_csr_cmd <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_20_iw_state <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_20_ftq_idx <= io_enq_bits_ftq_idx;	// fetch-buffer.scala:57:16
      fb_uop_ram_20_csr_addr <= 12'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_20_rxq_idx <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_20_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_20_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_20_debug_fsrc <= io_enq_bits_fsrc;	// fetch-buffer.scala:57:16
      fb_uop_ram_20_debug_tsrc <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
    end
    fb_uop_ram_20_ctrl_fcn_dw <= ~_GEN_281 & fb_uop_ram_20_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_20_ctrl_is_load <= ~_GEN_281 & fb_uop_ram_20_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_20_ctrl_is_sta <= ~_GEN_281 & fb_uop_ram_20_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_20_ctrl_is_std <= ~_GEN_281 & fb_uop_ram_20_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_20_iw_p1_poisoned <= ~_GEN_281 & fb_uop_ram_20_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_20_iw_p2_poisoned <= ~_GEN_281 & fb_uop_ram_20_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_20_edge_inst <=
      ~(_GEN_280 | _GEN_227 | _GEN_194)
      & (_GEN_161
           ? io_enq_bits_edge_inst_1
           : ~(_GEN_128 | _GEN_95 | _GEN_62)
             & (_GEN_29 ? io_enq_bits_edge_inst_0 : fb_uop_ram_20_edge_inst));	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_20_xcpt_ma_if <= ~_GEN_281 & fb_uop_ram_20_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_282) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_21_inst <= io_enq_bits_exp_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_21_debug_inst <= io_enq_bits_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_21_is_rvc <= in_uops_7_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_21_debug_pc <= _pc_T_31;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_21_is_sfb <= io_enq_bits_shadowed_mask_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_21_pc_lob <= _pc_T_31[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_21_taken <= in_uops_7_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_21_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_21_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_228) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_21_inst <= io_enq_bits_exp_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_21_debug_inst <= io_enq_bits_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_21_is_rvc <= in_uops_6_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_21_debug_pc <= _pc_T_27;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_21_is_sfb <= io_enq_bits_shadowed_mask_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_21_pc_lob <= _pc_T_27[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_21_taken <= in_uops_6_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_21_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_21_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_195) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_21_inst <= io_enq_bits_exp_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_21_debug_inst <= io_enq_bits_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_21_is_rvc <= in_uops_5_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_21_debug_pc <= _pc_T_23;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_21_is_sfb <= io_enq_bits_shadowed_mask_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_21_pc_lob <= _pc_T_23[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_21_taken <= in_uops_5_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_21_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_21_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_162) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_21_inst <= io_enq_bits_exp_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_21_debug_inst <= io_enq_bits_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_21_is_rvc <= in_uops_4_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_1) begin
        fb_uop_ram_21_debug_pc <= _in_uops_4_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
        fb_uop_ram_21_pc_lob <= _in_uops_4_pc_lob_T_3;	// fetch-buffer.scala:57:16, :108:61
      end
      else begin
        fb_uop_ram_21_debug_pc <= _pc_T_19;	// fetch-buffer.scala:57:16, :95:43
        fb_uop_ram_21_pc_lob <= _pc_T_19[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      end
      fb_uop_ram_21_is_sfb <= io_enq_bits_shadowed_mask_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_21_taken <= in_uops_4_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_21_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_21_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_129) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_21_inst <= io_enq_bits_exp_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_21_debug_inst <= io_enq_bits_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_21_is_rvc <= in_uops_3_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_21_debug_pc <= _pc_T_15;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_21_is_sfb <= io_enq_bits_shadowed_mask_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_21_pc_lob <= _pc_T_15[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_21_taken <= in_uops_3_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_21_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_21_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_96) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_21_inst <= io_enq_bits_exp_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_21_debug_inst <= io_enq_bits_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_21_is_rvc <= in_uops_2_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_21_debug_pc <= _pc_T_11;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_21_is_sfb <= io_enq_bits_shadowed_mask_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_21_pc_lob <= _pc_T_11[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_21_taken <= in_uops_2_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_21_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_21_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_63) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_21_inst <= io_enq_bits_exp_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_21_debug_inst <= io_enq_bits_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_21_is_rvc <= in_uops_1_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_21_debug_pc <= _pc_T_7;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_21_is_sfb <= io_enq_bits_shadowed_mask_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_21_pc_lob <= _pc_T_7[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_21_taken <= in_uops_1_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_21_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_21_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_30) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_21_inst <= io_enq_bits_exp_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_21_debug_inst <= io_enq_bits_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_21_is_rvc <= in_uops_0_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_0)
        fb_uop_ram_21_debug_pc <= _in_uops_0_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
      else
        fb_uop_ram_21_debug_pc <= pc;	// fetch-buffer.scala:57:16, frontend.scala:161:39
      fb_uop_ram_21_is_sfb <= io_enq_bits_shadowed_mask_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_21_pc_lob <= in_uops_0_pc_lob;	// fetch-buffer.scala:57:16, :101:33, :106:41, :108:32
      fb_uop_ram_21_taken <= in_uops_0_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_21_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_21_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;	// fetch-buffer.scala:57:16
    end
    if (_GEN_283) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
      fb_uop_ram_21_ctrl_br_type <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_21_ctrl_op1_sel <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_21_ctrl_op2_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_21_ctrl_imm_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_21_ctrl_op_fcn <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_21_ctrl_csr_cmd <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_21_iw_state <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_21_ftq_idx <= io_enq_bits_ftq_idx;	// fetch-buffer.scala:57:16
      fb_uop_ram_21_csr_addr <= 12'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_21_rxq_idx <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_21_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_21_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_21_debug_fsrc <= io_enq_bits_fsrc;	// fetch-buffer.scala:57:16
      fb_uop_ram_21_debug_tsrc <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
    end
    fb_uop_ram_21_ctrl_fcn_dw <= ~_GEN_283 & fb_uop_ram_21_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_21_ctrl_is_load <= ~_GEN_283 & fb_uop_ram_21_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_21_ctrl_is_sta <= ~_GEN_283 & fb_uop_ram_21_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_21_ctrl_is_std <= ~_GEN_283 & fb_uop_ram_21_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_21_iw_p1_poisoned <= ~_GEN_283 & fb_uop_ram_21_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_21_iw_p2_poisoned <= ~_GEN_283 & fb_uop_ram_21_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_21_edge_inst <=
      ~(_GEN_282 | _GEN_228 | _GEN_195)
      & (_GEN_162
           ? io_enq_bits_edge_inst_1
           : ~(_GEN_129 | _GEN_96 | _GEN_63)
             & (_GEN_30 ? io_enq_bits_edge_inst_0 : fb_uop_ram_21_edge_inst));	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_21_xcpt_ma_if <= ~_GEN_283 & fb_uop_ram_21_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_284) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_22_inst <= io_enq_bits_exp_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_22_debug_inst <= io_enq_bits_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_22_is_rvc <= in_uops_7_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_22_debug_pc <= _pc_T_31;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_22_is_sfb <= io_enq_bits_shadowed_mask_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_22_pc_lob <= _pc_T_31[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_22_taken <= in_uops_7_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_22_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_22_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_229) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_22_inst <= io_enq_bits_exp_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_22_debug_inst <= io_enq_bits_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_22_is_rvc <= in_uops_6_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_22_debug_pc <= _pc_T_27;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_22_is_sfb <= io_enq_bits_shadowed_mask_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_22_pc_lob <= _pc_T_27[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_22_taken <= in_uops_6_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_22_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_22_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_196) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_22_inst <= io_enq_bits_exp_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_22_debug_inst <= io_enq_bits_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_22_is_rvc <= in_uops_5_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_22_debug_pc <= _pc_T_23;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_22_is_sfb <= io_enq_bits_shadowed_mask_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_22_pc_lob <= _pc_T_23[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_22_taken <= in_uops_5_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_22_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_22_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_163) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_22_inst <= io_enq_bits_exp_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_22_debug_inst <= io_enq_bits_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_22_is_rvc <= in_uops_4_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_1) begin
        fb_uop_ram_22_debug_pc <= _in_uops_4_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
        fb_uop_ram_22_pc_lob <= _in_uops_4_pc_lob_T_3;	// fetch-buffer.scala:57:16, :108:61
      end
      else begin
        fb_uop_ram_22_debug_pc <= _pc_T_19;	// fetch-buffer.scala:57:16, :95:43
        fb_uop_ram_22_pc_lob <= _pc_T_19[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      end
      fb_uop_ram_22_is_sfb <= io_enq_bits_shadowed_mask_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_22_taken <= in_uops_4_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_22_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_22_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_130) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_22_inst <= io_enq_bits_exp_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_22_debug_inst <= io_enq_bits_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_22_is_rvc <= in_uops_3_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_22_debug_pc <= _pc_T_15;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_22_is_sfb <= io_enq_bits_shadowed_mask_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_22_pc_lob <= _pc_T_15[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_22_taken <= in_uops_3_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_22_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_22_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_97) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_22_inst <= io_enq_bits_exp_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_22_debug_inst <= io_enq_bits_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_22_is_rvc <= in_uops_2_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_22_debug_pc <= _pc_T_11;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_22_is_sfb <= io_enq_bits_shadowed_mask_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_22_pc_lob <= _pc_T_11[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_22_taken <= in_uops_2_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_22_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_22_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_64) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_22_inst <= io_enq_bits_exp_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_22_debug_inst <= io_enq_bits_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_22_is_rvc <= in_uops_1_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_22_debug_pc <= _pc_T_7;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_22_is_sfb <= io_enq_bits_shadowed_mask_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_22_pc_lob <= _pc_T_7[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_22_taken <= in_uops_1_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_22_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_22_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_31) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_22_inst <= io_enq_bits_exp_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_22_debug_inst <= io_enq_bits_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_22_is_rvc <= in_uops_0_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_0)
        fb_uop_ram_22_debug_pc <= _in_uops_0_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
      else
        fb_uop_ram_22_debug_pc <= pc;	// fetch-buffer.scala:57:16, frontend.scala:161:39
      fb_uop_ram_22_is_sfb <= io_enq_bits_shadowed_mask_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_22_pc_lob <= in_uops_0_pc_lob;	// fetch-buffer.scala:57:16, :101:33, :106:41, :108:32
      fb_uop_ram_22_taken <= in_uops_0_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_22_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_22_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;	// fetch-buffer.scala:57:16
    end
    if (_GEN_285) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
      fb_uop_ram_22_ctrl_br_type <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_22_ctrl_op1_sel <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_22_ctrl_op2_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_22_ctrl_imm_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_22_ctrl_op_fcn <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_22_ctrl_csr_cmd <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_22_iw_state <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_22_ftq_idx <= io_enq_bits_ftq_idx;	// fetch-buffer.scala:57:16
      fb_uop_ram_22_csr_addr <= 12'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_22_rxq_idx <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_22_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_22_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_22_debug_fsrc <= io_enq_bits_fsrc;	// fetch-buffer.scala:57:16
      fb_uop_ram_22_debug_tsrc <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
    end
    fb_uop_ram_22_ctrl_fcn_dw <= ~_GEN_285 & fb_uop_ram_22_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_22_ctrl_is_load <= ~_GEN_285 & fb_uop_ram_22_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_22_ctrl_is_sta <= ~_GEN_285 & fb_uop_ram_22_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_22_ctrl_is_std <= ~_GEN_285 & fb_uop_ram_22_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_22_iw_p1_poisoned <= ~_GEN_285 & fb_uop_ram_22_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_22_iw_p2_poisoned <= ~_GEN_285 & fb_uop_ram_22_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_22_edge_inst <=
      ~(_GEN_284 | _GEN_229 | _GEN_196)
      & (_GEN_163
           ? io_enq_bits_edge_inst_1
           : ~(_GEN_130 | _GEN_97 | _GEN_64)
             & (_GEN_31 ? io_enq_bits_edge_inst_0 : fb_uop_ram_22_edge_inst));	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_22_xcpt_ma_if <= ~_GEN_285 & fb_uop_ram_22_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_286) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_23_inst <= io_enq_bits_exp_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_23_debug_inst <= io_enq_bits_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_23_is_rvc <= in_uops_7_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_23_debug_pc <= _pc_T_31;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_23_is_sfb <= io_enq_bits_shadowed_mask_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_23_pc_lob <= _pc_T_31[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_23_taken <= in_uops_7_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_23_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_23_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_230) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_23_inst <= io_enq_bits_exp_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_23_debug_inst <= io_enq_bits_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_23_is_rvc <= in_uops_6_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_23_debug_pc <= _pc_T_27;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_23_is_sfb <= io_enq_bits_shadowed_mask_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_23_pc_lob <= _pc_T_27[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_23_taken <= in_uops_6_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_23_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_23_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_197) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_23_inst <= io_enq_bits_exp_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_23_debug_inst <= io_enq_bits_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_23_is_rvc <= in_uops_5_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_23_debug_pc <= _pc_T_23;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_23_is_sfb <= io_enq_bits_shadowed_mask_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_23_pc_lob <= _pc_T_23[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_23_taken <= in_uops_5_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_23_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_23_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_164) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_23_inst <= io_enq_bits_exp_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_23_debug_inst <= io_enq_bits_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_23_is_rvc <= in_uops_4_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_1) begin
        fb_uop_ram_23_debug_pc <= _in_uops_4_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
        fb_uop_ram_23_pc_lob <= _in_uops_4_pc_lob_T_3;	// fetch-buffer.scala:57:16, :108:61
      end
      else begin
        fb_uop_ram_23_debug_pc <= _pc_T_19;	// fetch-buffer.scala:57:16, :95:43
        fb_uop_ram_23_pc_lob <= _pc_T_19[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      end
      fb_uop_ram_23_is_sfb <= io_enq_bits_shadowed_mask_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_23_taken <= in_uops_4_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_23_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_23_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_131) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_23_inst <= io_enq_bits_exp_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_23_debug_inst <= io_enq_bits_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_23_is_rvc <= in_uops_3_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_23_debug_pc <= _pc_T_15;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_23_is_sfb <= io_enq_bits_shadowed_mask_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_23_pc_lob <= _pc_T_15[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_23_taken <= in_uops_3_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_23_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_23_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_98) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_23_inst <= io_enq_bits_exp_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_23_debug_inst <= io_enq_bits_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_23_is_rvc <= in_uops_2_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_23_debug_pc <= _pc_T_11;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_23_is_sfb <= io_enq_bits_shadowed_mask_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_23_pc_lob <= _pc_T_11[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_23_taken <= in_uops_2_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_23_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_23_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_65) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_23_inst <= io_enq_bits_exp_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_23_debug_inst <= io_enq_bits_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_23_is_rvc <= in_uops_1_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_23_debug_pc <= _pc_T_7;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_23_is_sfb <= io_enq_bits_shadowed_mask_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_23_pc_lob <= _pc_T_7[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_23_taken <= in_uops_1_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_23_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_23_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_32) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_23_inst <= io_enq_bits_exp_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_23_debug_inst <= io_enq_bits_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_23_is_rvc <= in_uops_0_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_0)
        fb_uop_ram_23_debug_pc <= _in_uops_0_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
      else
        fb_uop_ram_23_debug_pc <= pc;	// fetch-buffer.scala:57:16, frontend.scala:161:39
      fb_uop_ram_23_is_sfb <= io_enq_bits_shadowed_mask_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_23_pc_lob <= in_uops_0_pc_lob;	// fetch-buffer.scala:57:16, :101:33, :106:41, :108:32
      fb_uop_ram_23_taken <= in_uops_0_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_23_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_23_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;	// fetch-buffer.scala:57:16
    end
    if (_GEN_287) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
      fb_uop_ram_23_ctrl_br_type <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_23_ctrl_op1_sel <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_23_ctrl_op2_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_23_ctrl_imm_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_23_ctrl_op_fcn <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_23_ctrl_csr_cmd <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_23_iw_state <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_23_ftq_idx <= io_enq_bits_ftq_idx;	// fetch-buffer.scala:57:16
      fb_uop_ram_23_csr_addr <= 12'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_23_rxq_idx <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_23_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_23_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_23_debug_fsrc <= io_enq_bits_fsrc;	// fetch-buffer.scala:57:16
      fb_uop_ram_23_debug_tsrc <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
    end
    fb_uop_ram_23_ctrl_fcn_dw <= ~_GEN_287 & fb_uop_ram_23_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_23_ctrl_is_load <= ~_GEN_287 & fb_uop_ram_23_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_23_ctrl_is_sta <= ~_GEN_287 & fb_uop_ram_23_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_23_ctrl_is_std <= ~_GEN_287 & fb_uop_ram_23_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_23_iw_p1_poisoned <= ~_GEN_287 & fb_uop_ram_23_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_23_iw_p2_poisoned <= ~_GEN_287 & fb_uop_ram_23_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_23_edge_inst <=
      ~(_GEN_286 | _GEN_230 | _GEN_197)
      & (_GEN_164
           ? io_enq_bits_edge_inst_1
           : ~(_GEN_131 | _GEN_98 | _GEN_65)
             & (_GEN_32 ? io_enq_bits_edge_inst_0 : fb_uop_ram_23_edge_inst));	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_23_xcpt_ma_if <= ~_GEN_287 & fb_uop_ram_23_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_288) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_24_inst <= io_enq_bits_exp_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_24_debug_inst <= io_enq_bits_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_24_is_rvc <= in_uops_7_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_24_debug_pc <= _pc_T_31;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_24_is_sfb <= io_enq_bits_shadowed_mask_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_24_pc_lob <= _pc_T_31[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_24_taken <= in_uops_7_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_24_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_24_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_231) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_24_inst <= io_enq_bits_exp_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_24_debug_inst <= io_enq_bits_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_24_is_rvc <= in_uops_6_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_24_debug_pc <= _pc_T_27;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_24_is_sfb <= io_enq_bits_shadowed_mask_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_24_pc_lob <= _pc_T_27[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_24_taken <= in_uops_6_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_24_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_24_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_198) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_24_inst <= io_enq_bits_exp_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_24_debug_inst <= io_enq_bits_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_24_is_rvc <= in_uops_5_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_24_debug_pc <= _pc_T_23;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_24_is_sfb <= io_enq_bits_shadowed_mask_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_24_pc_lob <= _pc_T_23[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_24_taken <= in_uops_5_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_24_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_24_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_165) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_24_inst <= io_enq_bits_exp_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_24_debug_inst <= io_enq_bits_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_24_is_rvc <= in_uops_4_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_1) begin
        fb_uop_ram_24_debug_pc <= _in_uops_4_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
        fb_uop_ram_24_pc_lob <= _in_uops_4_pc_lob_T_3;	// fetch-buffer.scala:57:16, :108:61
      end
      else begin
        fb_uop_ram_24_debug_pc <= _pc_T_19;	// fetch-buffer.scala:57:16, :95:43
        fb_uop_ram_24_pc_lob <= _pc_T_19[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      end
      fb_uop_ram_24_is_sfb <= io_enq_bits_shadowed_mask_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_24_taken <= in_uops_4_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_24_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_24_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_132) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_24_inst <= io_enq_bits_exp_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_24_debug_inst <= io_enq_bits_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_24_is_rvc <= in_uops_3_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_24_debug_pc <= _pc_T_15;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_24_is_sfb <= io_enq_bits_shadowed_mask_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_24_pc_lob <= _pc_T_15[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_24_taken <= in_uops_3_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_24_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_24_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_99) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_24_inst <= io_enq_bits_exp_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_24_debug_inst <= io_enq_bits_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_24_is_rvc <= in_uops_2_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_24_debug_pc <= _pc_T_11;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_24_is_sfb <= io_enq_bits_shadowed_mask_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_24_pc_lob <= _pc_T_11[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_24_taken <= in_uops_2_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_24_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_24_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_66) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_24_inst <= io_enq_bits_exp_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_24_debug_inst <= io_enq_bits_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_24_is_rvc <= in_uops_1_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_24_debug_pc <= _pc_T_7;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_24_is_sfb <= io_enq_bits_shadowed_mask_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_24_pc_lob <= _pc_T_7[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_24_taken <= in_uops_1_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_24_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_24_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_33) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_24_inst <= io_enq_bits_exp_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_24_debug_inst <= io_enq_bits_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_24_is_rvc <= in_uops_0_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_0)
        fb_uop_ram_24_debug_pc <= _in_uops_0_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
      else
        fb_uop_ram_24_debug_pc <= pc;	// fetch-buffer.scala:57:16, frontend.scala:161:39
      fb_uop_ram_24_is_sfb <= io_enq_bits_shadowed_mask_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_24_pc_lob <= in_uops_0_pc_lob;	// fetch-buffer.scala:57:16, :101:33, :106:41, :108:32
      fb_uop_ram_24_taken <= in_uops_0_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_24_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_24_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;	// fetch-buffer.scala:57:16
    end
    if (_GEN_289) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
      fb_uop_ram_24_ctrl_br_type <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_24_ctrl_op1_sel <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_24_ctrl_op2_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_24_ctrl_imm_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_24_ctrl_op_fcn <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_24_ctrl_csr_cmd <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_24_iw_state <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_24_ftq_idx <= io_enq_bits_ftq_idx;	// fetch-buffer.scala:57:16
      fb_uop_ram_24_csr_addr <= 12'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_24_rxq_idx <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_24_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_24_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_24_debug_fsrc <= io_enq_bits_fsrc;	// fetch-buffer.scala:57:16
      fb_uop_ram_24_debug_tsrc <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
    end
    fb_uop_ram_24_ctrl_fcn_dw <= ~_GEN_289 & fb_uop_ram_24_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_24_ctrl_is_load <= ~_GEN_289 & fb_uop_ram_24_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_24_ctrl_is_sta <= ~_GEN_289 & fb_uop_ram_24_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_24_ctrl_is_std <= ~_GEN_289 & fb_uop_ram_24_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_24_iw_p1_poisoned <= ~_GEN_289 & fb_uop_ram_24_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_24_iw_p2_poisoned <= ~_GEN_289 & fb_uop_ram_24_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_24_edge_inst <=
      ~(_GEN_288 | _GEN_231 | _GEN_198)
      & (_GEN_165
           ? io_enq_bits_edge_inst_1
           : ~(_GEN_132 | _GEN_99 | _GEN_66)
             & (_GEN_33 ? io_enq_bits_edge_inst_0 : fb_uop_ram_24_edge_inst));	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_24_xcpt_ma_if <= ~_GEN_289 & fb_uop_ram_24_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_290) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_25_inst <= io_enq_bits_exp_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_25_debug_inst <= io_enq_bits_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_25_is_rvc <= in_uops_7_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_25_debug_pc <= _pc_T_31;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_25_is_sfb <= io_enq_bits_shadowed_mask_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_25_pc_lob <= _pc_T_31[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_25_taken <= in_uops_7_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_25_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_25_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_232) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_25_inst <= io_enq_bits_exp_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_25_debug_inst <= io_enq_bits_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_25_is_rvc <= in_uops_6_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_25_debug_pc <= _pc_T_27;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_25_is_sfb <= io_enq_bits_shadowed_mask_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_25_pc_lob <= _pc_T_27[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_25_taken <= in_uops_6_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_25_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_25_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_199) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_25_inst <= io_enq_bits_exp_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_25_debug_inst <= io_enq_bits_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_25_is_rvc <= in_uops_5_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_25_debug_pc <= _pc_T_23;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_25_is_sfb <= io_enq_bits_shadowed_mask_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_25_pc_lob <= _pc_T_23[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_25_taken <= in_uops_5_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_25_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_25_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_166) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_25_inst <= io_enq_bits_exp_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_25_debug_inst <= io_enq_bits_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_25_is_rvc <= in_uops_4_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_1) begin
        fb_uop_ram_25_debug_pc <= _in_uops_4_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
        fb_uop_ram_25_pc_lob <= _in_uops_4_pc_lob_T_3;	// fetch-buffer.scala:57:16, :108:61
      end
      else begin
        fb_uop_ram_25_debug_pc <= _pc_T_19;	// fetch-buffer.scala:57:16, :95:43
        fb_uop_ram_25_pc_lob <= _pc_T_19[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      end
      fb_uop_ram_25_is_sfb <= io_enq_bits_shadowed_mask_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_25_taken <= in_uops_4_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_25_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_25_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_133) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_25_inst <= io_enq_bits_exp_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_25_debug_inst <= io_enq_bits_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_25_is_rvc <= in_uops_3_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_25_debug_pc <= _pc_T_15;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_25_is_sfb <= io_enq_bits_shadowed_mask_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_25_pc_lob <= _pc_T_15[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_25_taken <= in_uops_3_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_25_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_25_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_100) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_25_inst <= io_enq_bits_exp_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_25_debug_inst <= io_enq_bits_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_25_is_rvc <= in_uops_2_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_25_debug_pc <= _pc_T_11;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_25_is_sfb <= io_enq_bits_shadowed_mask_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_25_pc_lob <= _pc_T_11[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_25_taken <= in_uops_2_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_25_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_25_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_67) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_25_inst <= io_enq_bits_exp_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_25_debug_inst <= io_enq_bits_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_25_is_rvc <= in_uops_1_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_25_debug_pc <= _pc_T_7;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_25_is_sfb <= io_enq_bits_shadowed_mask_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_25_pc_lob <= _pc_T_7[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_25_taken <= in_uops_1_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_25_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_25_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_34) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_25_inst <= io_enq_bits_exp_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_25_debug_inst <= io_enq_bits_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_25_is_rvc <= in_uops_0_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_0)
        fb_uop_ram_25_debug_pc <= _in_uops_0_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
      else
        fb_uop_ram_25_debug_pc <= pc;	// fetch-buffer.scala:57:16, frontend.scala:161:39
      fb_uop_ram_25_is_sfb <= io_enq_bits_shadowed_mask_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_25_pc_lob <= in_uops_0_pc_lob;	// fetch-buffer.scala:57:16, :101:33, :106:41, :108:32
      fb_uop_ram_25_taken <= in_uops_0_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_25_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_25_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;	// fetch-buffer.scala:57:16
    end
    if (_GEN_291) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
      fb_uop_ram_25_ctrl_br_type <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_25_ctrl_op1_sel <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_25_ctrl_op2_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_25_ctrl_imm_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_25_ctrl_op_fcn <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_25_ctrl_csr_cmd <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_25_iw_state <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_25_ftq_idx <= io_enq_bits_ftq_idx;	// fetch-buffer.scala:57:16
      fb_uop_ram_25_csr_addr <= 12'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_25_rxq_idx <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_25_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_25_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_25_debug_fsrc <= io_enq_bits_fsrc;	// fetch-buffer.scala:57:16
      fb_uop_ram_25_debug_tsrc <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
    end
    fb_uop_ram_25_ctrl_fcn_dw <= ~_GEN_291 & fb_uop_ram_25_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_25_ctrl_is_load <= ~_GEN_291 & fb_uop_ram_25_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_25_ctrl_is_sta <= ~_GEN_291 & fb_uop_ram_25_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_25_ctrl_is_std <= ~_GEN_291 & fb_uop_ram_25_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_25_iw_p1_poisoned <= ~_GEN_291 & fb_uop_ram_25_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_25_iw_p2_poisoned <= ~_GEN_291 & fb_uop_ram_25_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_25_edge_inst <=
      ~(_GEN_290 | _GEN_232 | _GEN_199)
      & (_GEN_166
           ? io_enq_bits_edge_inst_1
           : ~(_GEN_133 | _GEN_100 | _GEN_67)
             & (_GEN_34 ? io_enq_bits_edge_inst_0 : fb_uop_ram_25_edge_inst));	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_25_xcpt_ma_if <= ~_GEN_291 & fb_uop_ram_25_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_292) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_26_inst <= io_enq_bits_exp_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_26_debug_inst <= io_enq_bits_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_26_is_rvc <= in_uops_7_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_26_debug_pc <= _pc_T_31;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_26_is_sfb <= io_enq_bits_shadowed_mask_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_26_pc_lob <= _pc_T_31[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_26_taken <= in_uops_7_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_26_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_26_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_233) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_26_inst <= io_enq_bits_exp_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_26_debug_inst <= io_enq_bits_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_26_is_rvc <= in_uops_6_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_26_debug_pc <= _pc_T_27;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_26_is_sfb <= io_enq_bits_shadowed_mask_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_26_pc_lob <= _pc_T_27[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_26_taken <= in_uops_6_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_26_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_26_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_200) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_26_inst <= io_enq_bits_exp_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_26_debug_inst <= io_enq_bits_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_26_is_rvc <= in_uops_5_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_26_debug_pc <= _pc_T_23;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_26_is_sfb <= io_enq_bits_shadowed_mask_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_26_pc_lob <= _pc_T_23[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_26_taken <= in_uops_5_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_26_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_26_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_167) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_26_inst <= io_enq_bits_exp_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_26_debug_inst <= io_enq_bits_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_26_is_rvc <= in_uops_4_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_1) begin
        fb_uop_ram_26_debug_pc <= _in_uops_4_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
        fb_uop_ram_26_pc_lob <= _in_uops_4_pc_lob_T_3;	// fetch-buffer.scala:57:16, :108:61
      end
      else begin
        fb_uop_ram_26_debug_pc <= _pc_T_19;	// fetch-buffer.scala:57:16, :95:43
        fb_uop_ram_26_pc_lob <= _pc_T_19[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      end
      fb_uop_ram_26_is_sfb <= io_enq_bits_shadowed_mask_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_26_taken <= in_uops_4_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_26_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_26_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_134) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_26_inst <= io_enq_bits_exp_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_26_debug_inst <= io_enq_bits_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_26_is_rvc <= in_uops_3_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_26_debug_pc <= _pc_T_15;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_26_is_sfb <= io_enq_bits_shadowed_mask_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_26_pc_lob <= _pc_T_15[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_26_taken <= in_uops_3_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_26_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_26_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_101) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_26_inst <= io_enq_bits_exp_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_26_debug_inst <= io_enq_bits_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_26_is_rvc <= in_uops_2_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_26_debug_pc <= _pc_T_11;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_26_is_sfb <= io_enq_bits_shadowed_mask_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_26_pc_lob <= _pc_T_11[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_26_taken <= in_uops_2_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_26_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_26_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_68) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_26_inst <= io_enq_bits_exp_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_26_debug_inst <= io_enq_bits_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_26_is_rvc <= in_uops_1_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_26_debug_pc <= _pc_T_7;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_26_is_sfb <= io_enq_bits_shadowed_mask_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_26_pc_lob <= _pc_T_7[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_26_taken <= in_uops_1_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_26_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_26_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_35) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_26_inst <= io_enq_bits_exp_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_26_debug_inst <= io_enq_bits_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_26_is_rvc <= in_uops_0_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_0)
        fb_uop_ram_26_debug_pc <= _in_uops_0_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
      else
        fb_uop_ram_26_debug_pc <= pc;	// fetch-buffer.scala:57:16, frontend.scala:161:39
      fb_uop_ram_26_is_sfb <= io_enq_bits_shadowed_mask_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_26_pc_lob <= in_uops_0_pc_lob;	// fetch-buffer.scala:57:16, :101:33, :106:41, :108:32
      fb_uop_ram_26_taken <= in_uops_0_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_26_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_26_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;	// fetch-buffer.scala:57:16
    end
    if (_GEN_293) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
      fb_uop_ram_26_ctrl_br_type <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_26_ctrl_op1_sel <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_26_ctrl_op2_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_26_ctrl_imm_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_26_ctrl_op_fcn <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_26_ctrl_csr_cmd <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_26_iw_state <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_26_ftq_idx <= io_enq_bits_ftq_idx;	// fetch-buffer.scala:57:16
      fb_uop_ram_26_csr_addr <= 12'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_26_rxq_idx <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_26_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_26_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_26_debug_fsrc <= io_enq_bits_fsrc;	// fetch-buffer.scala:57:16
      fb_uop_ram_26_debug_tsrc <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
    end
    fb_uop_ram_26_ctrl_fcn_dw <= ~_GEN_293 & fb_uop_ram_26_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_26_ctrl_is_load <= ~_GEN_293 & fb_uop_ram_26_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_26_ctrl_is_sta <= ~_GEN_293 & fb_uop_ram_26_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_26_ctrl_is_std <= ~_GEN_293 & fb_uop_ram_26_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_26_iw_p1_poisoned <= ~_GEN_293 & fb_uop_ram_26_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_26_iw_p2_poisoned <= ~_GEN_293 & fb_uop_ram_26_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_26_edge_inst <=
      ~(_GEN_292 | _GEN_233 | _GEN_200)
      & (_GEN_167
           ? io_enq_bits_edge_inst_1
           : ~(_GEN_134 | _GEN_101 | _GEN_68)
             & (_GEN_35 ? io_enq_bits_edge_inst_0 : fb_uop_ram_26_edge_inst));	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_26_xcpt_ma_if <= ~_GEN_293 & fb_uop_ram_26_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_294) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_27_inst <= io_enq_bits_exp_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_27_debug_inst <= io_enq_bits_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_27_is_rvc <= in_uops_7_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_27_debug_pc <= _pc_T_31;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_27_is_sfb <= io_enq_bits_shadowed_mask_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_27_pc_lob <= _pc_T_31[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_27_taken <= in_uops_7_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_27_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_27_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_234) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_27_inst <= io_enq_bits_exp_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_27_debug_inst <= io_enq_bits_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_27_is_rvc <= in_uops_6_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_27_debug_pc <= _pc_T_27;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_27_is_sfb <= io_enq_bits_shadowed_mask_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_27_pc_lob <= _pc_T_27[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_27_taken <= in_uops_6_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_27_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_27_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_201) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_27_inst <= io_enq_bits_exp_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_27_debug_inst <= io_enq_bits_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_27_is_rvc <= in_uops_5_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_27_debug_pc <= _pc_T_23;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_27_is_sfb <= io_enq_bits_shadowed_mask_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_27_pc_lob <= _pc_T_23[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_27_taken <= in_uops_5_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_27_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_27_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_168) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_27_inst <= io_enq_bits_exp_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_27_debug_inst <= io_enq_bits_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_27_is_rvc <= in_uops_4_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_1) begin
        fb_uop_ram_27_debug_pc <= _in_uops_4_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
        fb_uop_ram_27_pc_lob <= _in_uops_4_pc_lob_T_3;	// fetch-buffer.scala:57:16, :108:61
      end
      else begin
        fb_uop_ram_27_debug_pc <= _pc_T_19;	// fetch-buffer.scala:57:16, :95:43
        fb_uop_ram_27_pc_lob <= _pc_T_19[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      end
      fb_uop_ram_27_is_sfb <= io_enq_bits_shadowed_mask_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_27_taken <= in_uops_4_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_27_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_27_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_135) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_27_inst <= io_enq_bits_exp_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_27_debug_inst <= io_enq_bits_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_27_is_rvc <= in_uops_3_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_27_debug_pc <= _pc_T_15;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_27_is_sfb <= io_enq_bits_shadowed_mask_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_27_pc_lob <= _pc_T_15[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_27_taken <= in_uops_3_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_27_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_27_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_102) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_27_inst <= io_enq_bits_exp_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_27_debug_inst <= io_enq_bits_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_27_is_rvc <= in_uops_2_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_27_debug_pc <= _pc_T_11;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_27_is_sfb <= io_enq_bits_shadowed_mask_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_27_pc_lob <= _pc_T_11[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_27_taken <= in_uops_2_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_27_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_27_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_69) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_27_inst <= io_enq_bits_exp_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_27_debug_inst <= io_enq_bits_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_27_is_rvc <= in_uops_1_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_27_debug_pc <= _pc_T_7;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_27_is_sfb <= io_enq_bits_shadowed_mask_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_27_pc_lob <= _pc_T_7[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_27_taken <= in_uops_1_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_27_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_27_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_36) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_27_inst <= io_enq_bits_exp_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_27_debug_inst <= io_enq_bits_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_27_is_rvc <= in_uops_0_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_0)
        fb_uop_ram_27_debug_pc <= _in_uops_0_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
      else
        fb_uop_ram_27_debug_pc <= pc;	// fetch-buffer.scala:57:16, frontend.scala:161:39
      fb_uop_ram_27_is_sfb <= io_enq_bits_shadowed_mask_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_27_pc_lob <= in_uops_0_pc_lob;	// fetch-buffer.scala:57:16, :101:33, :106:41, :108:32
      fb_uop_ram_27_taken <= in_uops_0_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_27_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_27_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;	// fetch-buffer.scala:57:16
    end
    if (_GEN_295) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
      fb_uop_ram_27_ctrl_br_type <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_27_ctrl_op1_sel <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_27_ctrl_op2_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_27_ctrl_imm_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_27_ctrl_op_fcn <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_27_ctrl_csr_cmd <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_27_iw_state <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_27_ftq_idx <= io_enq_bits_ftq_idx;	// fetch-buffer.scala:57:16
      fb_uop_ram_27_csr_addr <= 12'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_27_rxq_idx <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_27_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_27_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_27_debug_fsrc <= io_enq_bits_fsrc;	// fetch-buffer.scala:57:16
      fb_uop_ram_27_debug_tsrc <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
    end
    fb_uop_ram_27_ctrl_fcn_dw <= ~_GEN_295 & fb_uop_ram_27_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_27_ctrl_is_load <= ~_GEN_295 & fb_uop_ram_27_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_27_ctrl_is_sta <= ~_GEN_295 & fb_uop_ram_27_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_27_ctrl_is_std <= ~_GEN_295 & fb_uop_ram_27_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_27_iw_p1_poisoned <= ~_GEN_295 & fb_uop_ram_27_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_27_iw_p2_poisoned <= ~_GEN_295 & fb_uop_ram_27_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_27_edge_inst <=
      ~(_GEN_294 | _GEN_234 | _GEN_201)
      & (_GEN_168
           ? io_enq_bits_edge_inst_1
           : ~(_GEN_135 | _GEN_102 | _GEN_69)
             & (_GEN_36 ? io_enq_bits_edge_inst_0 : fb_uop_ram_27_edge_inst));	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_27_xcpt_ma_if <= ~_GEN_295 & fb_uop_ram_27_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_296) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_28_inst <= io_enq_bits_exp_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_28_debug_inst <= io_enq_bits_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_28_is_rvc <= in_uops_7_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_28_debug_pc <= _pc_T_31;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_28_is_sfb <= io_enq_bits_shadowed_mask_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_28_pc_lob <= _pc_T_31[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_28_taken <= in_uops_7_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_28_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_28_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_235) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_28_inst <= io_enq_bits_exp_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_28_debug_inst <= io_enq_bits_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_28_is_rvc <= in_uops_6_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_28_debug_pc <= _pc_T_27;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_28_is_sfb <= io_enq_bits_shadowed_mask_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_28_pc_lob <= _pc_T_27[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_28_taken <= in_uops_6_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_28_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_28_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_202) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_28_inst <= io_enq_bits_exp_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_28_debug_inst <= io_enq_bits_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_28_is_rvc <= in_uops_5_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_28_debug_pc <= _pc_T_23;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_28_is_sfb <= io_enq_bits_shadowed_mask_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_28_pc_lob <= _pc_T_23[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_28_taken <= in_uops_5_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_28_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_28_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_169) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_28_inst <= io_enq_bits_exp_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_28_debug_inst <= io_enq_bits_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_28_is_rvc <= in_uops_4_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_1) begin
        fb_uop_ram_28_debug_pc <= _in_uops_4_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
        fb_uop_ram_28_pc_lob <= _in_uops_4_pc_lob_T_3;	// fetch-buffer.scala:57:16, :108:61
      end
      else begin
        fb_uop_ram_28_debug_pc <= _pc_T_19;	// fetch-buffer.scala:57:16, :95:43
        fb_uop_ram_28_pc_lob <= _pc_T_19[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      end
      fb_uop_ram_28_is_sfb <= io_enq_bits_shadowed_mask_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_28_taken <= in_uops_4_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_28_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_28_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_136) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_28_inst <= io_enq_bits_exp_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_28_debug_inst <= io_enq_bits_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_28_is_rvc <= in_uops_3_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_28_debug_pc <= _pc_T_15;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_28_is_sfb <= io_enq_bits_shadowed_mask_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_28_pc_lob <= _pc_T_15[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_28_taken <= in_uops_3_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_28_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_28_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_103) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_28_inst <= io_enq_bits_exp_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_28_debug_inst <= io_enq_bits_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_28_is_rvc <= in_uops_2_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_28_debug_pc <= _pc_T_11;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_28_is_sfb <= io_enq_bits_shadowed_mask_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_28_pc_lob <= _pc_T_11[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_28_taken <= in_uops_2_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_28_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_28_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_70) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_28_inst <= io_enq_bits_exp_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_28_debug_inst <= io_enq_bits_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_28_is_rvc <= in_uops_1_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_28_debug_pc <= _pc_T_7;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_28_is_sfb <= io_enq_bits_shadowed_mask_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_28_pc_lob <= _pc_T_7[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_28_taken <= in_uops_1_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_28_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_28_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_37) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_28_inst <= io_enq_bits_exp_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_28_debug_inst <= io_enq_bits_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_28_is_rvc <= in_uops_0_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_0)
        fb_uop_ram_28_debug_pc <= _in_uops_0_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
      else
        fb_uop_ram_28_debug_pc <= pc;	// fetch-buffer.scala:57:16, frontend.scala:161:39
      fb_uop_ram_28_is_sfb <= io_enq_bits_shadowed_mask_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_28_pc_lob <= in_uops_0_pc_lob;	// fetch-buffer.scala:57:16, :101:33, :106:41, :108:32
      fb_uop_ram_28_taken <= in_uops_0_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_28_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_28_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;	// fetch-buffer.scala:57:16
    end
    if (_GEN_297) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
      fb_uop_ram_28_ctrl_br_type <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_28_ctrl_op1_sel <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_28_ctrl_op2_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_28_ctrl_imm_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_28_ctrl_op_fcn <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_28_ctrl_csr_cmd <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_28_iw_state <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_28_ftq_idx <= io_enq_bits_ftq_idx;	// fetch-buffer.scala:57:16
      fb_uop_ram_28_csr_addr <= 12'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_28_rxq_idx <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_28_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_28_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_28_debug_fsrc <= io_enq_bits_fsrc;	// fetch-buffer.scala:57:16
      fb_uop_ram_28_debug_tsrc <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
    end
    fb_uop_ram_28_ctrl_fcn_dw <= ~_GEN_297 & fb_uop_ram_28_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_28_ctrl_is_load <= ~_GEN_297 & fb_uop_ram_28_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_28_ctrl_is_sta <= ~_GEN_297 & fb_uop_ram_28_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_28_ctrl_is_std <= ~_GEN_297 & fb_uop_ram_28_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_28_iw_p1_poisoned <= ~_GEN_297 & fb_uop_ram_28_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_28_iw_p2_poisoned <= ~_GEN_297 & fb_uop_ram_28_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_28_edge_inst <=
      ~(_GEN_296 | _GEN_235 | _GEN_202)
      & (_GEN_169
           ? io_enq_bits_edge_inst_1
           : ~(_GEN_136 | _GEN_103 | _GEN_70)
             & (_GEN_37 ? io_enq_bits_edge_inst_0 : fb_uop_ram_28_edge_inst));	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_28_xcpt_ma_if <= ~_GEN_297 & fb_uop_ram_28_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_298) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_29_inst <= io_enq_bits_exp_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_29_debug_inst <= io_enq_bits_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_29_is_rvc <= in_uops_7_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_29_debug_pc <= _pc_T_31;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_29_is_sfb <= io_enq_bits_shadowed_mask_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_29_pc_lob <= _pc_T_31[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_29_taken <= in_uops_7_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_29_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_29_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_236) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_29_inst <= io_enq_bits_exp_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_29_debug_inst <= io_enq_bits_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_29_is_rvc <= in_uops_6_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_29_debug_pc <= _pc_T_27;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_29_is_sfb <= io_enq_bits_shadowed_mask_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_29_pc_lob <= _pc_T_27[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_29_taken <= in_uops_6_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_29_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_29_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_203) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_29_inst <= io_enq_bits_exp_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_29_debug_inst <= io_enq_bits_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_29_is_rvc <= in_uops_5_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_29_debug_pc <= _pc_T_23;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_29_is_sfb <= io_enq_bits_shadowed_mask_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_29_pc_lob <= _pc_T_23[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_29_taken <= in_uops_5_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_29_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_29_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_170) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_29_inst <= io_enq_bits_exp_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_29_debug_inst <= io_enq_bits_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_29_is_rvc <= in_uops_4_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_1) begin
        fb_uop_ram_29_debug_pc <= _in_uops_4_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
        fb_uop_ram_29_pc_lob <= _in_uops_4_pc_lob_T_3;	// fetch-buffer.scala:57:16, :108:61
      end
      else begin
        fb_uop_ram_29_debug_pc <= _pc_T_19;	// fetch-buffer.scala:57:16, :95:43
        fb_uop_ram_29_pc_lob <= _pc_T_19[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      end
      fb_uop_ram_29_is_sfb <= io_enq_bits_shadowed_mask_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_29_taken <= in_uops_4_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_29_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_29_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_137) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_29_inst <= io_enq_bits_exp_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_29_debug_inst <= io_enq_bits_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_29_is_rvc <= in_uops_3_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_29_debug_pc <= _pc_T_15;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_29_is_sfb <= io_enq_bits_shadowed_mask_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_29_pc_lob <= _pc_T_15[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_29_taken <= in_uops_3_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_29_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_29_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_104) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_29_inst <= io_enq_bits_exp_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_29_debug_inst <= io_enq_bits_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_29_is_rvc <= in_uops_2_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_29_debug_pc <= _pc_T_11;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_29_is_sfb <= io_enq_bits_shadowed_mask_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_29_pc_lob <= _pc_T_11[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_29_taken <= in_uops_2_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_29_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_29_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_71) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_29_inst <= io_enq_bits_exp_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_29_debug_inst <= io_enq_bits_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_29_is_rvc <= in_uops_1_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_29_debug_pc <= _pc_T_7;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_29_is_sfb <= io_enq_bits_shadowed_mask_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_29_pc_lob <= _pc_T_7[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_29_taken <= in_uops_1_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_29_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_29_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_38) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_29_inst <= io_enq_bits_exp_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_29_debug_inst <= io_enq_bits_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_29_is_rvc <= in_uops_0_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_0)
        fb_uop_ram_29_debug_pc <= _in_uops_0_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
      else
        fb_uop_ram_29_debug_pc <= pc;	// fetch-buffer.scala:57:16, frontend.scala:161:39
      fb_uop_ram_29_is_sfb <= io_enq_bits_shadowed_mask_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_29_pc_lob <= in_uops_0_pc_lob;	// fetch-buffer.scala:57:16, :101:33, :106:41, :108:32
      fb_uop_ram_29_taken <= in_uops_0_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_29_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_29_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;	// fetch-buffer.scala:57:16
    end
    if (_GEN_299) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
      fb_uop_ram_29_ctrl_br_type <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_29_ctrl_op1_sel <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_29_ctrl_op2_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_29_ctrl_imm_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_29_ctrl_op_fcn <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_29_ctrl_csr_cmd <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_29_iw_state <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_29_ftq_idx <= io_enq_bits_ftq_idx;	// fetch-buffer.scala:57:16
      fb_uop_ram_29_csr_addr <= 12'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_29_rxq_idx <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_29_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_29_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_29_debug_fsrc <= io_enq_bits_fsrc;	// fetch-buffer.scala:57:16
      fb_uop_ram_29_debug_tsrc <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
    end
    fb_uop_ram_29_ctrl_fcn_dw <= ~_GEN_299 & fb_uop_ram_29_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_29_ctrl_is_load <= ~_GEN_299 & fb_uop_ram_29_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_29_ctrl_is_sta <= ~_GEN_299 & fb_uop_ram_29_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_29_ctrl_is_std <= ~_GEN_299 & fb_uop_ram_29_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_29_iw_p1_poisoned <= ~_GEN_299 & fb_uop_ram_29_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_29_iw_p2_poisoned <= ~_GEN_299 & fb_uop_ram_29_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_29_edge_inst <=
      ~(_GEN_298 | _GEN_236 | _GEN_203)
      & (_GEN_170
           ? io_enq_bits_edge_inst_1
           : ~(_GEN_137 | _GEN_104 | _GEN_71)
             & (_GEN_38 ? io_enq_bits_edge_inst_0 : fb_uop_ram_29_edge_inst));	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_29_xcpt_ma_if <= ~_GEN_299 & fb_uop_ram_29_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_300) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_30_inst <= io_enq_bits_exp_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_30_debug_inst <= io_enq_bits_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_30_is_rvc <= in_uops_7_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_30_debug_pc <= _pc_T_31;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_30_is_sfb <= io_enq_bits_shadowed_mask_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_30_pc_lob <= _pc_T_31[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_30_taken <= in_uops_7_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_30_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_30_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_237) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_30_inst <= io_enq_bits_exp_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_30_debug_inst <= io_enq_bits_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_30_is_rvc <= in_uops_6_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_30_debug_pc <= _pc_T_27;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_30_is_sfb <= io_enq_bits_shadowed_mask_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_30_pc_lob <= _pc_T_27[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_30_taken <= in_uops_6_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_30_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_30_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_204) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_30_inst <= io_enq_bits_exp_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_30_debug_inst <= io_enq_bits_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_30_is_rvc <= in_uops_5_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_30_debug_pc <= _pc_T_23;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_30_is_sfb <= io_enq_bits_shadowed_mask_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_30_pc_lob <= _pc_T_23[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_30_taken <= in_uops_5_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_30_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_30_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_171) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_30_inst <= io_enq_bits_exp_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_30_debug_inst <= io_enq_bits_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_30_is_rvc <= in_uops_4_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_1) begin
        fb_uop_ram_30_debug_pc <= _in_uops_4_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
        fb_uop_ram_30_pc_lob <= _in_uops_4_pc_lob_T_3;	// fetch-buffer.scala:57:16, :108:61
      end
      else begin
        fb_uop_ram_30_debug_pc <= _pc_T_19;	// fetch-buffer.scala:57:16, :95:43
        fb_uop_ram_30_pc_lob <= _pc_T_19[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      end
      fb_uop_ram_30_is_sfb <= io_enq_bits_shadowed_mask_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_30_taken <= in_uops_4_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_30_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_30_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_138) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_30_inst <= io_enq_bits_exp_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_30_debug_inst <= io_enq_bits_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_30_is_rvc <= in_uops_3_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_30_debug_pc <= _pc_T_15;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_30_is_sfb <= io_enq_bits_shadowed_mask_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_30_pc_lob <= _pc_T_15[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_30_taken <= in_uops_3_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_30_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_30_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_105) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_30_inst <= io_enq_bits_exp_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_30_debug_inst <= io_enq_bits_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_30_is_rvc <= in_uops_2_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_30_debug_pc <= _pc_T_11;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_30_is_sfb <= io_enq_bits_shadowed_mask_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_30_pc_lob <= _pc_T_11[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_30_taken <= in_uops_2_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_30_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_30_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_72) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_30_inst <= io_enq_bits_exp_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_30_debug_inst <= io_enq_bits_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_30_is_rvc <= in_uops_1_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_30_debug_pc <= _pc_T_7;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_30_is_sfb <= io_enq_bits_shadowed_mask_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_30_pc_lob <= _pc_T_7[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_30_taken <= in_uops_1_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_30_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_30_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_39) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_30_inst <= io_enq_bits_exp_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_30_debug_inst <= io_enq_bits_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_30_is_rvc <= in_uops_0_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_0)
        fb_uop_ram_30_debug_pc <= _in_uops_0_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
      else
        fb_uop_ram_30_debug_pc <= pc;	// fetch-buffer.scala:57:16, frontend.scala:161:39
      fb_uop_ram_30_is_sfb <= io_enq_bits_shadowed_mask_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_30_pc_lob <= in_uops_0_pc_lob;	// fetch-buffer.scala:57:16, :101:33, :106:41, :108:32
      fb_uop_ram_30_taken <= in_uops_0_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_30_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_30_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;	// fetch-buffer.scala:57:16
    end
    if (_GEN_301) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
      fb_uop_ram_30_ctrl_br_type <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_30_ctrl_op1_sel <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_30_ctrl_op2_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_30_ctrl_imm_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_30_ctrl_op_fcn <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_30_ctrl_csr_cmd <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_30_iw_state <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_30_ftq_idx <= io_enq_bits_ftq_idx;	// fetch-buffer.scala:57:16
      fb_uop_ram_30_csr_addr <= 12'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_30_rxq_idx <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_30_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_30_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_30_debug_fsrc <= io_enq_bits_fsrc;	// fetch-buffer.scala:57:16
      fb_uop_ram_30_debug_tsrc <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
    end
    fb_uop_ram_30_ctrl_fcn_dw <= ~_GEN_301 & fb_uop_ram_30_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_30_ctrl_is_load <= ~_GEN_301 & fb_uop_ram_30_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_30_ctrl_is_sta <= ~_GEN_301 & fb_uop_ram_30_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_30_ctrl_is_std <= ~_GEN_301 & fb_uop_ram_30_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_30_iw_p1_poisoned <= ~_GEN_301 & fb_uop_ram_30_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_30_iw_p2_poisoned <= ~_GEN_301 & fb_uop_ram_30_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_30_edge_inst <=
      ~(_GEN_300 | _GEN_237 | _GEN_204)
      & (_GEN_171
           ? io_enq_bits_edge_inst_1
           : ~(_GEN_138 | _GEN_105 | _GEN_72)
             & (_GEN_39 ? io_enq_bits_edge_inst_0 : fb_uop_ram_30_edge_inst));	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_30_xcpt_ma_if <= ~_GEN_301 & fb_uop_ram_30_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_302) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_31_inst <= io_enq_bits_exp_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_31_debug_inst <= io_enq_bits_insts_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_31_is_rvc <= in_uops_7_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_31_debug_pc <= _pc_T_31;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_31_is_sfb <= io_enq_bits_shadowed_mask_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_31_pc_lob <= _pc_T_31[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_31_taken <= in_uops_7_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_31_bp_debug_if <= io_enq_bits_bp_debug_if_oh_7;	// fetch-buffer.scala:57:16
      fb_uop_ram_31_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_7;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_238) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_31_inst <= io_enq_bits_exp_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_31_debug_inst <= io_enq_bits_insts_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_31_is_rvc <= in_uops_6_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_31_debug_pc <= _pc_T_27;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_31_is_sfb <= io_enq_bits_shadowed_mask_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_31_pc_lob <= _pc_T_27[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_31_taken <= in_uops_6_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_31_bp_debug_if <= io_enq_bits_bp_debug_if_oh_6;	// fetch-buffer.scala:57:16
      fb_uop_ram_31_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_6;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_205) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_31_inst <= io_enq_bits_exp_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_31_debug_inst <= io_enq_bits_insts_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_31_is_rvc <= in_uops_5_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_31_debug_pc <= _pc_T_23;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_31_is_sfb <= io_enq_bits_shadowed_mask_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_31_pc_lob <= _pc_T_23[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_31_taken <= in_uops_5_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_31_bp_debug_if <= io_enq_bits_bp_debug_if_oh_5;	// fetch-buffer.scala:57:16
      fb_uop_ram_31_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_5;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_172) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_31_inst <= io_enq_bits_exp_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_31_debug_inst <= io_enq_bits_insts_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_31_is_rvc <= in_uops_4_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_1) begin
        fb_uop_ram_31_debug_pc <= _in_uops_4_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
        fb_uop_ram_31_pc_lob <= _in_uops_4_pc_lob_T_3;	// fetch-buffer.scala:57:16, :108:61
      end
      else begin
        fb_uop_ram_31_debug_pc <= _pc_T_19;	// fetch-buffer.scala:57:16, :95:43
        fb_uop_ram_31_pc_lob <= _pc_T_19[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      end
      fb_uop_ram_31_is_sfb <= io_enq_bits_shadowed_mask_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_31_taken <= in_uops_4_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_31_bp_debug_if <= io_enq_bits_bp_debug_if_oh_4;	// fetch-buffer.scala:57:16
      fb_uop_ram_31_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_4;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_139) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_31_inst <= io_enq_bits_exp_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_31_debug_inst <= io_enq_bits_insts_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_31_is_rvc <= in_uops_3_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_31_debug_pc <= _pc_T_15;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_31_is_sfb <= io_enq_bits_shadowed_mask_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_31_pc_lob <= _pc_T_15[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_31_taken <= in_uops_3_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_31_bp_debug_if <= io_enq_bits_bp_debug_if_oh_3;	// fetch-buffer.scala:57:16
      fb_uop_ram_31_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_3;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_106) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_31_inst <= io_enq_bits_exp_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_31_debug_inst <= io_enq_bits_insts_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_31_is_rvc <= in_uops_2_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_31_debug_pc <= _pc_T_11;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_31_is_sfb <= io_enq_bits_shadowed_mask_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_31_pc_lob <= _pc_T_11[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_31_taken <= in_uops_2_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_31_bp_debug_if <= io_enq_bits_bp_debug_if_oh_2;	// fetch-buffer.scala:57:16
      fb_uop_ram_31_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_2;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_73) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_31_inst <= io_enq_bits_exp_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_31_debug_inst <= io_enq_bits_insts_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_31_is_rvc <= in_uops_1_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      fb_uop_ram_31_debug_pc <= _pc_T_7;	// fetch-buffer.scala:57:16, :95:43
      fb_uop_ram_31_is_sfb <= io_enq_bits_shadowed_mask_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_31_pc_lob <= _pc_T_7[5:0];	// fetch-buffer.scala:57:16, :95:43, :101:33
      fb_uop_ram_31_taken <= in_uops_1_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_31_bp_debug_if <= io_enq_bits_bp_debug_if_oh_1;	// fetch-buffer.scala:57:16
      fb_uop_ram_31_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_1;	// fetch-buffer.scala:57:16
    end
    else if (_GEN_40) begin	// fetch-buffer.scala:144:34
      fb_uop_ram_31_inst <= io_enq_bits_exp_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_31_debug_inst <= io_enq_bits_insts_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_31_is_rvc <= in_uops_0_is_rvc;	// fetch-buffer.scala:57:16, :115:62
      if (io_enq_bits_edge_inst_0)
        fb_uop_ram_31_debug_pc <= _in_uops_0_debug_pc_T_5;	// fetch-buffer.scala:57:16, :107:81
      else
        fb_uop_ram_31_debug_pc <= pc;	// fetch-buffer.scala:57:16, frontend.scala:161:39
      fb_uop_ram_31_is_sfb <= io_enq_bits_shadowed_mask_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_31_pc_lob <= in_uops_0_pc_lob;	// fetch-buffer.scala:57:16, :101:33, :106:41, :108:32
      fb_uop_ram_31_taken <= in_uops_0_taken;	// fetch-buffer.scala:57:16, :116:69
      fb_uop_ram_31_bp_debug_if <= io_enq_bits_bp_debug_if_oh_0;	// fetch-buffer.scala:57:16
      fb_uop_ram_31_bp_xcpt_if <= io_enq_bits_bp_xcpt_if_oh_0;	// fetch-buffer.scala:57:16
    end
    if (_GEN_303) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
      fb_uop_ram_31_ctrl_br_type <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_31_ctrl_op1_sel <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_31_ctrl_op2_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_31_ctrl_imm_sel <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_31_ctrl_op_fcn <= 4'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_31_ctrl_csr_cmd <= 3'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_31_iw_state <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_31_ftq_idx <= io_enq_bits_ftq_idx;	// fetch-buffer.scala:57:16
      fb_uop_ram_31_csr_addr <= 12'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_31_rxq_idx <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
      fb_uop_ram_31_xcpt_pf_if <= io_enq_bits_xcpt_pf_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_31_xcpt_ae_if <= io_enq_bits_xcpt_ae_if;	// fetch-buffer.scala:57:16
      fb_uop_ram_31_debug_fsrc <= io_enq_bits_fsrc;	// fetch-buffer.scala:57:16
      fb_uop_ram_31_debug_tsrc <= 2'h0;	// fetch-buffer.scala:57:16, :97:33
    end
    fb_uop_ram_31_ctrl_fcn_dw <= ~_GEN_303 & fb_uop_ram_31_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_31_ctrl_is_load <= ~_GEN_303 & fb_uop_ram_31_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_31_ctrl_is_sta <= ~_GEN_303 & fb_uop_ram_31_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_31_ctrl_is_std <= ~_GEN_303 & fb_uop_ram_31_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_31_iw_p1_poisoned <= ~_GEN_303 & fb_uop_ram_31_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_31_iw_p2_poisoned <= ~_GEN_303 & fb_uop_ram_31_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_31_edge_inst <=
      ~(_GEN_302 | _GEN_238 | _GEN_205)
      & (_GEN_172
           ? io_enq_bits_edge_inst_1
           : ~(_GEN_139 | _GEN_106 | _GEN_73)
             & (_GEN_40 ? io_enq_bits_edge_inst_0 : fb_uop_ram_31_edge_inst));	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_31_xcpt_ma_if <= ~_GEN_303 & fb_uop_ram_31_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (reset) begin
      head <= 8'h1;	// fetch-buffer.scala:61:21
      tail <= 32'h1;	// fetch-buffer.scala:62:21
      maybe_full <= 1'h0;	// fetch-buffer.scala:64:27
    end
    else begin
      automatic logic do_deq;	// fetch-buffer.scala:159:29
      do_deq = io_deq_ready & slot_will_hit_tail == 4'h0;	// fetch-buffer.scala:97:33, :156:112, :157:42, :159:29
      if (io_clear) begin
        head <= 8'h1;	// fetch-buffer.scala:61:21
        tail <= 32'h1;	// fetch-buffer.scala:62:21
      end
      else begin
        if (do_deq)	// fetch-buffer.scala:159:29
          head <= {head[6:0], head[7]};	// Cat.scala:30:58, fetch-buffer.scala:61:21, :132:12, :155:31
        if (~_do_enq_T_1) begin	// fetch-buffer.scala:82:40
          if (in_mask_7)	// fetch-buffer.scala:98:49
            tail <= {enq_idxs_7[30:0], enq_idxs_7[31]};	// Cat.scala:30:58, fetch-buffer.scala:62:21, :132:{12,24}, :138:18
          else if (in_mask_6)	// fetch-buffer.scala:98:49
            tail <= _GEN_7;	// Cat.scala:30:58, fetch-buffer.scala:62:21
          else if (in_mask_5)	// fetch-buffer.scala:98:49
            tail <= _GEN_6;	// Cat.scala:30:58, fetch-buffer.scala:62:21
          else if (in_mask_4)	// fetch-buffer.scala:98:49
            tail <= _GEN_5;	// Cat.scala:30:58, fetch-buffer.scala:62:21
          else if (in_mask_3)	// fetch-buffer.scala:98:49
            tail <= _GEN_4;	// Cat.scala:30:58, fetch-buffer.scala:62:21
          else if (in_mask_2)	// fetch-buffer.scala:98:49
            tail <= _GEN_3;	// Cat.scala:30:58, fetch-buffer.scala:62:21
          else if (in_mask_1)	// fetch-buffer.scala:98:49
            tail <= _GEN_2;	// Cat.scala:30:58, fetch-buffer.scala:62:21
          else if (in_mask_0)	// fetch-buffer.scala:98:49
            tail <= _GEN_1;	// Cat.scala:30:58, fetch-buffer.scala:62:21
        end
      end
      maybe_full <=
        ~(io_clear | do_deq)
        & (~_do_enq_T_1
           & (in_mask_0 | in_mask_1 | in_mask_2 | in_mask_3 | in_mask_4 | in_mask_5
              | in_mask_6 | in_mask_7) | maybe_full);	// fetch-buffer.scala:64:27, :82:{16,40}, :98:49, :159:29, :176:17, :178:{27,33}, :179:18, :183:17, :185:16, :188:19, :191:16
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:418];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [8:0] i = 9'h0; i < 9'h1A3; i += 9'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        fb_uop_ram_0_inst = {_RANDOM[9'h0][31:7], _RANDOM[9'h1][6:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_0_debug_inst = {_RANDOM[9'h1][31:7], _RANDOM[9'h2][6:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_0_is_rvc = _RANDOM[9'h2][7];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_debug_pc = {_RANDOM[9'h2][31:8], _RANDOM[9'h3][15:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_0_ctrl_br_type = {_RANDOM[9'h3][31:29], _RANDOM[9'h4][0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_0_ctrl_op1_sel = _RANDOM[9'h4][2:1];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_ctrl_op2_sel = _RANDOM[9'h4][5:3];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_ctrl_imm_sel = _RANDOM[9'h4][8:6];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_ctrl_op_fcn = _RANDOM[9'h4][12:9];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_ctrl_fcn_dw = _RANDOM[9'h4][13];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_ctrl_csr_cmd = _RANDOM[9'h4][16:14];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_ctrl_is_load = _RANDOM[9'h4][17];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_ctrl_is_sta = _RANDOM[9'h4][18];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_ctrl_is_std = _RANDOM[9'h4][19];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_iw_state = _RANDOM[9'h4][21:20];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_iw_p1_poisoned = _RANDOM[9'h4][22];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_iw_p2_poisoned = _RANDOM[9'h4][23];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_is_sfb = _RANDOM[9'h4][27];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_ftq_idx = _RANDOM[9'h5][26:21];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_edge_inst = _RANDOM[9'h5][27];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_pc_lob = {_RANDOM[9'h5][31:28], _RANDOM[9'h6][1:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_0_taken = _RANDOM[9'h6][2];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_csr_addr = {_RANDOM[9'h6][31:23], _RANDOM[9'h7][2:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_0_rxq_idx = _RANDOM[9'h7][21:20];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_xcpt_pf_if = _RANDOM[9'hC][24];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_xcpt_ae_if = _RANDOM[9'hC][25];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_xcpt_ma_if = _RANDOM[9'hC][26];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_bp_debug_if = _RANDOM[9'hC][27];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_bp_xcpt_if = _RANDOM[9'hC][28];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_debug_fsrc = _RANDOM[9'hC][30:29];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_debug_tsrc = {_RANDOM[9'hC][31], _RANDOM[9'hD][0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_1_inst = {_RANDOM[9'hD][31:8], _RANDOM[9'hE][7:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_1_debug_inst = {_RANDOM[9'hE][31:8], _RANDOM[9'hF][7:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_1_is_rvc = _RANDOM[9'hF][8];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_debug_pc = {_RANDOM[9'hF][31:9], _RANDOM[9'h10][16:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_1_ctrl_br_type = {_RANDOM[9'h10][31:30], _RANDOM[9'h11][1:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_1_ctrl_op1_sel = _RANDOM[9'h11][3:2];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_ctrl_op2_sel = _RANDOM[9'h11][6:4];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_ctrl_imm_sel = _RANDOM[9'h11][9:7];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_ctrl_op_fcn = _RANDOM[9'h11][13:10];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_ctrl_fcn_dw = _RANDOM[9'h11][14];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_ctrl_csr_cmd = _RANDOM[9'h11][17:15];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_ctrl_is_load = _RANDOM[9'h11][18];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_ctrl_is_sta = _RANDOM[9'h11][19];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_ctrl_is_std = _RANDOM[9'h11][20];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_iw_state = _RANDOM[9'h11][22:21];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_iw_p1_poisoned = _RANDOM[9'h11][23];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_iw_p2_poisoned = _RANDOM[9'h11][24];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_is_sfb = _RANDOM[9'h11][28];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_ftq_idx = _RANDOM[9'h12][27:22];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_edge_inst = _RANDOM[9'h12][28];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_pc_lob = {_RANDOM[9'h12][31:29], _RANDOM[9'h13][2:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_1_taken = _RANDOM[9'h13][3];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_csr_addr = {_RANDOM[9'h13][31:24], _RANDOM[9'h14][3:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_1_rxq_idx = _RANDOM[9'h14][22:21];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_xcpt_pf_if = _RANDOM[9'h19][25];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_xcpt_ae_if = _RANDOM[9'h19][26];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_xcpt_ma_if = _RANDOM[9'h19][27];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_bp_debug_if = _RANDOM[9'h19][28];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_bp_xcpt_if = _RANDOM[9'h19][29];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_debug_fsrc = _RANDOM[9'h19][31:30];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_debug_tsrc = _RANDOM[9'h1A][1:0];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_inst = {_RANDOM[9'h1A][31:9], _RANDOM[9'h1B][8:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_2_debug_inst = {_RANDOM[9'h1B][31:9], _RANDOM[9'h1C][8:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_2_is_rvc = _RANDOM[9'h1C][9];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_debug_pc = {_RANDOM[9'h1C][31:10], _RANDOM[9'h1D][17:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_2_ctrl_br_type = {_RANDOM[9'h1D][31], _RANDOM[9'h1E][2:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_2_ctrl_op1_sel = _RANDOM[9'h1E][4:3];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_ctrl_op2_sel = _RANDOM[9'h1E][7:5];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_ctrl_imm_sel = _RANDOM[9'h1E][10:8];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_ctrl_op_fcn = _RANDOM[9'h1E][14:11];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_ctrl_fcn_dw = _RANDOM[9'h1E][15];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_ctrl_csr_cmd = _RANDOM[9'h1E][18:16];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_ctrl_is_load = _RANDOM[9'h1E][19];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_ctrl_is_sta = _RANDOM[9'h1E][20];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_ctrl_is_std = _RANDOM[9'h1E][21];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_iw_state = _RANDOM[9'h1E][23:22];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_iw_p1_poisoned = _RANDOM[9'h1E][24];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_iw_p2_poisoned = _RANDOM[9'h1E][25];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_is_sfb = _RANDOM[9'h1E][29];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_ftq_idx = _RANDOM[9'h1F][28:23];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_edge_inst = _RANDOM[9'h1F][29];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_pc_lob = {_RANDOM[9'h1F][31:30], _RANDOM[9'h20][3:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_2_taken = _RANDOM[9'h20][4];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_csr_addr = {_RANDOM[9'h20][31:25], _RANDOM[9'h21][4:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_2_rxq_idx = _RANDOM[9'h21][23:22];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_xcpt_pf_if = _RANDOM[9'h26][26];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_xcpt_ae_if = _RANDOM[9'h26][27];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_xcpt_ma_if = _RANDOM[9'h26][28];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_bp_debug_if = _RANDOM[9'h26][29];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_bp_xcpt_if = _RANDOM[9'h26][30];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_debug_fsrc = {_RANDOM[9'h26][31], _RANDOM[9'h27][0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_2_debug_tsrc = _RANDOM[9'h27][2:1];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_inst = {_RANDOM[9'h27][31:10], _RANDOM[9'h28][9:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_3_debug_inst = {_RANDOM[9'h28][31:10], _RANDOM[9'h29][9:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_3_is_rvc = _RANDOM[9'h29][10];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_debug_pc = {_RANDOM[9'h29][31:11], _RANDOM[9'h2A][18:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_3_ctrl_br_type = _RANDOM[9'h2B][3:0];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_ctrl_op1_sel = _RANDOM[9'h2B][5:4];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_ctrl_op2_sel = _RANDOM[9'h2B][8:6];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_ctrl_imm_sel = _RANDOM[9'h2B][11:9];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_ctrl_op_fcn = _RANDOM[9'h2B][15:12];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_ctrl_fcn_dw = _RANDOM[9'h2B][16];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_ctrl_csr_cmd = _RANDOM[9'h2B][19:17];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_ctrl_is_load = _RANDOM[9'h2B][20];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_ctrl_is_sta = _RANDOM[9'h2B][21];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_ctrl_is_std = _RANDOM[9'h2B][22];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_iw_state = _RANDOM[9'h2B][24:23];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_iw_p1_poisoned = _RANDOM[9'h2B][25];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_iw_p2_poisoned = _RANDOM[9'h2B][26];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_is_sfb = _RANDOM[9'h2B][30];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_ftq_idx = _RANDOM[9'h2C][29:24];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_edge_inst = _RANDOM[9'h2C][30];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_pc_lob = {_RANDOM[9'h2C][31], _RANDOM[9'h2D][4:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_3_taken = _RANDOM[9'h2D][5];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_csr_addr = {_RANDOM[9'h2D][31:26], _RANDOM[9'h2E][5:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_3_rxq_idx = _RANDOM[9'h2E][24:23];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_xcpt_pf_if = _RANDOM[9'h33][27];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_xcpt_ae_if = _RANDOM[9'h33][28];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_xcpt_ma_if = _RANDOM[9'h33][29];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_bp_debug_if = _RANDOM[9'h33][30];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_bp_xcpt_if = _RANDOM[9'h33][31];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_debug_fsrc = _RANDOM[9'h34][1:0];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_debug_tsrc = _RANDOM[9'h34][3:2];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_inst = {_RANDOM[9'h34][31:11], _RANDOM[9'h35][10:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_4_debug_inst = {_RANDOM[9'h35][31:11], _RANDOM[9'h36][10:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_4_is_rvc = _RANDOM[9'h36][11];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_debug_pc = {_RANDOM[9'h36][31:12], _RANDOM[9'h37][19:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_4_ctrl_br_type = _RANDOM[9'h38][4:1];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_ctrl_op1_sel = _RANDOM[9'h38][6:5];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_ctrl_op2_sel = _RANDOM[9'h38][9:7];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_ctrl_imm_sel = _RANDOM[9'h38][12:10];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_ctrl_op_fcn = _RANDOM[9'h38][16:13];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_ctrl_fcn_dw = _RANDOM[9'h38][17];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_ctrl_csr_cmd = _RANDOM[9'h38][20:18];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_ctrl_is_load = _RANDOM[9'h38][21];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_ctrl_is_sta = _RANDOM[9'h38][22];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_ctrl_is_std = _RANDOM[9'h38][23];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_iw_state = _RANDOM[9'h38][25:24];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_iw_p1_poisoned = _RANDOM[9'h38][26];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_iw_p2_poisoned = _RANDOM[9'h38][27];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_is_sfb = _RANDOM[9'h38][31];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_ftq_idx = _RANDOM[9'h39][30:25];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_edge_inst = _RANDOM[9'h39][31];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_pc_lob = _RANDOM[9'h3A][5:0];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_taken = _RANDOM[9'h3A][6];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_csr_addr = {_RANDOM[9'h3A][31:27], _RANDOM[9'h3B][6:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_4_rxq_idx = _RANDOM[9'h3B][25:24];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_xcpt_pf_if = _RANDOM[9'h40][28];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_xcpt_ae_if = _RANDOM[9'h40][29];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_xcpt_ma_if = _RANDOM[9'h40][30];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_bp_debug_if = _RANDOM[9'h40][31];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_bp_xcpt_if = _RANDOM[9'h41][0];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_debug_fsrc = _RANDOM[9'h41][2:1];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_debug_tsrc = _RANDOM[9'h41][4:3];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_inst = {_RANDOM[9'h41][31:12], _RANDOM[9'h42][11:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_5_debug_inst = {_RANDOM[9'h42][31:12], _RANDOM[9'h43][11:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_5_is_rvc = _RANDOM[9'h43][12];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_debug_pc = {_RANDOM[9'h43][31:13], _RANDOM[9'h44][20:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_5_ctrl_br_type = _RANDOM[9'h45][5:2];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_ctrl_op1_sel = _RANDOM[9'h45][7:6];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_ctrl_op2_sel = _RANDOM[9'h45][10:8];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_ctrl_imm_sel = _RANDOM[9'h45][13:11];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_ctrl_op_fcn = _RANDOM[9'h45][17:14];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_ctrl_fcn_dw = _RANDOM[9'h45][18];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_ctrl_csr_cmd = _RANDOM[9'h45][21:19];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_ctrl_is_load = _RANDOM[9'h45][22];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_ctrl_is_sta = _RANDOM[9'h45][23];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_ctrl_is_std = _RANDOM[9'h45][24];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_iw_state = _RANDOM[9'h45][26:25];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_iw_p1_poisoned = _RANDOM[9'h45][27];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_iw_p2_poisoned = _RANDOM[9'h45][28];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_is_sfb = _RANDOM[9'h46][0];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_ftq_idx = _RANDOM[9'h46][31:26];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_edge_inst = _RANDOM[9'h47][0];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_pc_lob = _RANDOM[9'h47][6:1];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_taken = _RANDOM[9'h47][7];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_csr_addr = {_RANDOM[9'h47][31:28], _RANDOM[9'h48][7:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_5_rxq_idx = _RANDOM[9'h48][26:25];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_xcpt_pf_if = _RANDOM[9'h4D][29];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_xcpt_ae_if = _RANDOM[9'h4D][30];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_xcpt_ma_if = _RANDOM[9'h4D][31];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_bp_debug_if = _RANDOM[9'h4E][0];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_bp_xcpt_if = _RANDOM[9'h4E][1];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_debug_fsrc = _RANDOM[9'h4E][3:2];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_debug_tsrc = _RANDOM[9'h4E][5:4];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_inst = {_RANDOM[9'h4E][31:13], _RANDOM[9'h4F][12:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_6_debug_inst = {_RANDOM[9'h4F][31:13], _RANDOM[9'h50][12:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_6_is_rvc = _RANDOM[9'h50][13];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_debug_pc = {_RANDOM[9'h50][31:14], _RANDOM[9'h51][21:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_6_ctrl_br_type = _RANDOM[9'h52][6:3];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_ctrl_op1_sel = _RANDOM[9'h52][8:7];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_ctrl_op2_sel = _RANDOM[9'h52][11:9];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_ctrl_imm_sel = _RANDOM[9'h52][14:12];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_ctrl_op_fcn = _RANDOM[9'h52][18:15];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_ctrl_fcn_dw = _RANDOM[9'h52][19];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_ctrl_csr_cmd = _RANDOM[9'h52][22:20];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_ctrl_is_load = _RANDOM[9'h52][23];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_ctrl_is_sta = _RANDOM[9'h52][24];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_ctrl_is_std = _RANDOM[9'h52][25];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_iw_state = _RANDOM[9'h52][27:26];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_iw_p1_poisoned = _RANDOM[9'h52][28];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_iw_p2_poisoned = _RANDOM[9'h52][29];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_is_sfb = _RANDOM[9'h53][1];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_ftq_idx = {_RANDOM[9'h53][31:27], _RANDOM[9'h54][0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_6_edge_inst = _RANDOM[9'h54][1];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_pc_lob = _RANDOM[9'h54][7:2];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_taken = _RANDOM[9'h54][8];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_csr_addr = {_RANDOM[9'h54][31:29], _RANDOM[9'h55][8:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_6_rxq_idx = _RANDOM[9'h55][27:26];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_xcpt_pf_if = _RANDOM[9'h5A][30];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_xcpt_ae_if = _RANDOM[9'h5A][31];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_xcpt_ma_if = _RANDOM[9'h5B][0];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_bp_debug_if = _RANDOM[9'h5B][1];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_bp_xcpt_if = _RANDOM[9'h5B][2];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_debug_fsrc = _RANDOM[9'h5B][4:3];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_debug_tsrc = _RANDOM[9'h5B][6:5];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_inst = {_RANDOM[9'h5B][31:14], _RANDOM[9'h5C][13:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_7_debug_inst = {_RANDOM[9'h5C][31:14], _RANDOM[9'h5D][13:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_7_is_rvc = _RANDOM[9'h5D][14];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_debug_pc = {_RANDOM[9'h5D][31:15], _RANDOM[9'h5E][22:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_7_ctrl_br_type = _RANDOM[9'h5F][7:4];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_ctrl_op1_sel = _RANDOM[9'h5F][9:8];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_ctrl_op2_sel = _RANDOM[9'h5F][12:10];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_ctrl_imm_sel = _RANDOM[9'h5F][15:13];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_ctrl_op_fcn = _RANDOM[9'h5F][19:16];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_ctrl_fcn_dw = _RANDOM[9'h5F][20];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_ctrl_csr_cmd = _RANDOM[9'h5F][23:21];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_ctrl_is_load = _RANDOM[9'h5F][24];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_ctrl_is_sta = _RANDOM[9'h5F][25];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_ctrl_is_std = _RANDOM[9'h5F][26];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_iw_state = _RANDOM[9'h5F][28:27];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_iw_p1_poisoned = _RANDOM[9'h5F][29];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_iw_p2_poisoned = _RANDOM[9'h5F][30];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_is_sfb = _RANDOM[9'h60][2];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_ftq_idx = {_RANDOM[9'h60][31:28], _RANDOM[9'h61][1:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_7_edge_inst = _RANDOM[9'h61][2];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_pc_lob = _RANDOM[9'h61][8:3];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_taken = _RANDOM[9'h61][9];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_csr_addr = {_RANDOM[9'h61][31:30], _RANDOM[9'h62][9:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_7_rxq_idx = _RANDOM[9'h62][28:27];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_xcpt_pf_if = _RANDOM[9'h67][31];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_xcpt_ae_if = _RANDOM[9'h68][0];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_xcpt_ma_if = _RANDOM[9'h68][1];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_bp_debug_if = _RANDOM[9'h68][2];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_bp_xcpt_if = _RANDOM[9'h68][3];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_debug_fsrc = _RANDOM[9'h68][5:4];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_debug_tsrc = _RANDOM[9'h68][7:6];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_inst = {_RANDOM[9'h68][31:15], _RANDOM[9'h69][14:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_8_debug_inst = {_RANDOM[9'h69][31:15], _RANDOM[9'h6A][14:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_8_is_rvc = _RANDOM[9'h6A][15];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_debug_pc = {_RANDOM[9'h6A][31:16], _RANDOM[9'h6B][23:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_8_ctrl_br_type = _RANDOM[9'h6C][8:5];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_ctrl_op1_sel = _RANDOM[9'h6C][10:9];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_ctrl_op2_sel = _RANDOM[9'h6C][13:11];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_ctrl_imm_sel = _RANDOM[9'h6C][16:14];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_ctrl_op_fcn = _RANDOM[9'h6C][20:17];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_ctrl_fcn_dw = _RANDOM[9'h6C][21];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_ctrl_csr_cmd = _RANDOM[9'h6C][24:22];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_ctrl_is_load = _RANDOM[9'h6C][25];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_ctrl_is_sta = _RANDOM[9'h6C][26];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_ctrl_is_std = _RANDOM[9'h6C][27];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_iw_state = _RANDOM[9'h6C][29:28];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_iw_p1_poisoned = _RANDOM[9'h6C][30];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_iw_p2_poisoned = _RANDOM[9'h6C][31];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_is_sfb = _RANDOM[9'h6D][3];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_ftq_idx = {_RANDOM[9'h6D][31:29], _RANDOM[9'h6E][2:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_8_edge_inst = _RANDOM[9'h6E][3];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_pc_lob = _RANDOM[9'h6E][9:4];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_taken = _RANDOM[9'h6E][10];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_csr_addr = {_RANDOM[9'h6E][31], _RANDOM[9'h6F][10:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_8_rxq_idx = _RANDOM[9'h6F][29:28];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_xcpt_pf_if = _RANDOM[9'h75][0];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_xcpt_ae_if = _RANDOM[9'h75][1];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_xcpt_ma_if = _RANDOM[9'h75][2];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_bp_debug_if = _RANDOM[9'h75][3];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_bp_xcpt_if = _RANDOM[9'h75][4];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_debug_fsrc = _RANDOM[9'h75][6:5];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_debug_tsrc = _RANDOM[9'h75][8:7];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_inst = {_RANDOM[9'h75][31:16], _RANDOM[9'h76][15:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_9_debug_inst = {_RANDOM[9'h76][31:16], _RANDOM[9'h77][15:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_9_is_rvc = _RANDOM[9'h77][16];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_debug_pc = {_RANDOM[9'h77][31:17], _RANDOM[9'h78][24:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_9_ctrl_br_type = _RANDOM[9'h79][9:6];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_ctrl_op1_sel = _RANDOM[9'h79][11:10];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_ctrl_op2_sel = _RANDOM[9'h79][14:12];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_ctrl_imm_sel = _RANDOM[9'h79][17:15];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_ctrl_op_fcn = _RANDOM[9'h79][21:18];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_ctrl_fcn_dw = _RANDOM[9'h79][22];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_ctrl_csr_cmd = _RANDOM[9'h79][25:23];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_ctrl_is_load = _RANDOM[9'h79][26];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_ctrl_is_sta = _RANDOM[9'h79][27];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_ctrl_is_std = _RANDOM[9'h79][28];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_iw_state = _RANDOM[9'h79][30:29];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_iw_p1_poisoned = _RANDOM[9'h79][31];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_iw_p2_poisoned = _RANDOM[9'h7A][0];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_is_sfb = _RANDOM[9'h7A][4];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_ftq_idx = {_RANDOM[9'h7A][31:30], _RANDOM[9'h7B][3:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_9_edge_inst = _RANDOM[9'h7B][4];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_pc_lob = _RANDOM[9'h7B][10:5];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_taken = _RANDOM[9'h7B][11];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_csr_addr = _RANDOM[9'h7C][11:0];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_rxq_idx = _RANDOM[9'h7C][30:29];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_xcpt_pf_if = _RANDOM[9'h82][1];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_xcpt_ae_if = _RANDOM[9'h82][2];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_xcpt_ma_if = _RANDOM[9'h82][3];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_bp_debug_if = _RANDOM[9'h82][4];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_bp_xcpt_if = _RANDOM[9'h82][5];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_debug_fsrc = _RANDOM[9'h82][7:6];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_debug_tsrc = _RANDOM[9'h82][9:8];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_inst = {_RANDOM[9'h82][31:17], _RANDOM[9'h83][16:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_10_debug_inst = {_RANDOM[9'h83][31:17], _RANDOM[9'h84][16:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_10_is_rvc = _RANDOM[9'h84][17];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_debug_pc = {_RANDOM[9'h84][31:18], _RANDOM[9'h85][25:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_10_ctrl_br_type = _RANDOM[9'h86][10:7];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_ctrl_op1_sel = _RANDOM[9'h86][12:11];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_ctrl_op2_sel = _RANDOM[9'h86][15:13];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_ctrl_imm_sel = _RANDOM[9'h86][18:16];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_ctrl_op_fcn = _RANDOM[9'h86][22:19];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_ctrl_fcn_dw = _RANDOM[9'h86][23];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_ctrl_csr_cmd = _RANDOM[9'h86][26:24];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_ctrl_is_load = _RANDOM[9'h86][27];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_ctrl_is_sta = _RANDOM[9'h86][28];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_ctrl_is_std = _RANDOM[9'h86][29];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_iw_state = _RANDOM[9'h86][31:30];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_iw_p1_poisoned = _RANDOM[9'h87][0];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_iw_p2_poisoned = _RANDOM[9'h87][1];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_is_sfb = _RANDOM[9'h87][5];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_ftq_idx = {_RANDOM[9'h87][31], _RANDOM[9'h88][4:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_10_edge_inst = _RANDOM[9'h88][5];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_pc_lob = _RANDOM[9'h88][11:6];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_taken = _RANDOM[9'h88][12];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_csr_addr = _RANDOM[9'h89][12:1];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_rxq_idx = _RANDOM[9'h89][31:30];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_xcpt_pf_if = _RANDOM[9'h8F][2];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_xcpt_ae_if = _RANDOM[9'h8F][3];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_xcpt_ma_if = _RANDOM[9'h8F][4];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_bp_debug_if = _RANDOM[9'h8F][5];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_bp_xcpt_if = _RANDOM[9'h8F][6];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_debug_fsrc = _RANDOM[9'h8F][8:7];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_debug_tsrc = _RANDOM[9'h8F][10:9];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_inst = {_RANDOM[9'h8F][31:18], _RANDOM[9'h90][17:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_11_debug_inst = {_RANDOM[9'h90][31:18], _RANDOM[9'h91][17:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_11_is_rvc = _RANDOM[9'h91][18];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_debug_pc = {_RANDOM[9'h91][31:19], _RANDOM[9'h92][26:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_11_ctrl_br_type = _RANDOM[9'h93][11:8];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_ctrl_op1_sel = _RANDOM[9'h93][13:12];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_ctrl_op2_sel = _RANDOM[9'h93][16:14];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_ctrl_imm_sel = _RANDOM[9'h93][19:17];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_ctrl_op_fcn = _RANDOM[9'h93][23:20];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_ctrl_fcn_dw = _RANDOM[9'h93][24];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_ctrl_csr_cmd = _RANDOM[9'h93][27:25];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_ctrl_is_load = _RANDOM[9'h93][28];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_ctrl_is_sta = _RANDOM[9'h93][29];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_ctrl_is_std = _RANDOM[9'h93][30];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_iw_state = {_RANDOM[9'h93][31], _RANDOM[9'h94][0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_11_iw_p1_poisoned = _RANDOM[9'h94][1];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_iw_p2_poisoned = _RANDOM[9'h94][2];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_is_sfb = _RANDOM[9'h94][6];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_ftq_idx = _RANDOM[9'h95][5:0];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_edge_inst = _RANDOM[9'h95][6];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_pc_lob = _RANDOM[9'h95][12:7];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_taken = _RANDOM[9'h95][13];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_csr_addr = _RANDOM[9'h96][13:2];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_rxq_idx = {_RANDOM[9'h96][31], _RANDOM[9'h97][0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_11_xcpt_pf_if = _RANDOM[9'h9C][3];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_xcpt_ae_if = _RANDOM[9'h9C][4];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_xcpt_ma_if = _RANDOM[9'h9C][5];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_bp_debug_if = _RANDOM[9'h9C][6];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_bp_xcpt_if = _RANDOM[9'h9C][7];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_debug_fsrc = _RANDOM[9'h9C][9:8];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_debug_tsrc = _RANDOM[9'h9C][11:10];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_inst = {_RANDOM[9'h9C][31:19], _RANDOM[9'h9D][18:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_12_debug_inst = {_RANDOM[9'h9D][31:19], _RANDOM[9'h9E][18:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_12_is_rvc = _RANDOM[9'h9E][19];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_debug_pc = {_RANDOM[9'h9E][31:20], _RANDOM[9'h9F][27:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_12_ctrl_br_type = _RANDOM[9'hA0][12:9];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_ctrl_op1_sel = _RANDOM[9'hA0][14:13];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_ctrl_op2_sel = _RANDOM[9'hA0][17:15];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_ctrl_imm_sel = _RANDOM[9'hA0][20:18];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_ctrl_op_fcn = _RANDOM[9'hA0][24:21];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_ctrl_fcn_dw = _RANDOM[9'hA0][25];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_ctrl_csr_cmd = _RANDOM[9'hA0][28:26];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_ctrl_is_load = _RANDOM[9'hA0][29];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_ctrl_is_sta = _RANDOM[9'hA0][30];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_ctrl_is_std = _RANDOM[9'hA0][31];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_iw_state = _RANDOM[9'hA1][1:0];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_iw_p1_poisoned = _RANDOM[9'hA1][2];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_iw_p2_poisoned = _RANDOM[9'hA1][3];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_is_sfb = _RANDOM[9'hA1][7];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_ftq_idx = _RANDOM[9'hA2][6:1];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_edge_inst = _RANDOM[9'hA2][7];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_pc_lob = _RANDOM[9'hA2][13:8];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_taken = _RANDOM[9'hA2][14];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_csr_addr = _RANDOM[9'hA3][14:3];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_rxq_idx = _RANDOM[9'hA4][1:0];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_xcpt_pf_if = _RANDOM[9'hA9][4];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_xcpt_ae_if = _RANDOM[9'hA9][5];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_xcpt_ma_if = _RANDOM[9'hA9][6];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_bp_debug_if = _RANDOM[9'hA9][7];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_bp_xcpt_if = _RANDOM[9'hA9][8];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_debug_fsrc = _RANDOM[9'hA9][10:9];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_debug_tsrc = _RANDOM[9'hA9][12:11];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_inst = {_RANDOM[9'hA9][31:20], _RANDOM[9'hAA][19:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_13_debug_inst = {_RANDOM[9'hAA][31:20], _RANDOM[9'hAB][19:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_13_is_rvc = _RANDOM[9'hAB][20];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_debug_pc = {_RANDOM[9'hAB][31:21], _RANDOM[9'hAC][28:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_13_ctrl_br_type = _RANDOM[9'hAD][13:10];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_ctrl_op1_sel = _RANDOM[9'hAD][15:14];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_ctrl_op2_sel = _RANDOM[9'hAD][18:16];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_ctrl_imm_sel = _RANDOM[9'hAD][21:19];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_ctrl_op_fcn = _RANDOM[9'hAD][25:22];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_ctrl_fcn_dw = _RANDOM[9'hAD][26];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_ctrl_csr_cmd = _RANDOM[9'hAD][29:27];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_ctrl_is_load = _RANDOM[9'hAD][30];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_ctrl_is_sta = _RANDOM[9'hAD][31];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_ctrl_is_std = _RANDOM[9'hAE][0];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_iw_state = _RANDOM[9'hAE][2:1];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_iw_p1_poisoned = _RANDOM[9'hAE][3];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_iw_p2_poisoned = _RANDOM[9'hAE][4];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_is_sfb = _RANDOM[9'hAE][8];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_ftq_idx = _RANDOM[9'hAF][7:2];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_edge_inst = _RANDOM[9'hAF][8];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_pc_lob = _RANDOM[9'hAF][14:9];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_taken = _RANDOM[9'hAF][15];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_csr_addr = _RANDOM[9'hB0][15:4];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_rxq_idx = _RANDOM[9'hB1][2:1];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_xcpt_pf_if = _RANDOM[9'hB6][5];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_xcpt_ae_if = _RANDOM[9'hB6][6];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_xcpt_ma_if = _RANDOM[9'hB6][7];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_bp_debug_if = _RANDOM[9'hB6][8];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_bp_xcpt_if = _RANDOM[9'hB6][9];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_debug_fsrc = _RANDOM[9'hB6][11:10];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_debug_tsrc = _RANDOM[9'hB6][13:12];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_inst = {_RANDOM[9'hB6][31:21], _RANDOM[9'hB7][20:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_14_debug_inst = {_RANDOM[9'hB7][31:21], _RANDOM[9'hB8][20:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_14_is_rvc = _RANDOM[9'hB8][21];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_debug_pc = {_RANDOM[9'hB8][31:22], _RANDOM[9'hB9][29:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_14_ctrl_br_type = _RANDOM[9'hBA][14:11];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_ctrl_op1_sel = _RANDOM[9'hBA][16:15];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_ctrl_op2_sel = _RANDOM[9'hBA][19:17];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_ctrl_imm_sel = _RANDOM[9'hBA][22:20];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_ctrl_op_fcn = _RANDOM[9'hBA][26:23];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_ctrl_fcn_dw = _RANDOM[9'hBA][27];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_ctrl_csr_cmd = _RANDOM[9'hBA][30:28];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_ctrl_is_load = _RANDOM[9'hBA][31];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_ctrl_is_sta = _RANDOM[9'hBB][0];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_ctrl_is_std = _RANDOM[9'hBB][1];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_iw_state = _RANDOM[9'hBB][3:2];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_iw_p1_poisoned = _RANDOM[9'hBB][4];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_iw_p2_poisoned = _RANDOM[9'hBB][5];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_is_sfb = _RANDOM[9'hBB][9];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_ftq_idx = _RANDOM[9'hBC][8:3];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_edge_inst = _RANDOM[9'hBC][9];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_pc_lob = _RANDOM[9'hBC][15:10];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_taken = _RANDOM[9'hBC][16];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_csr_addr = _RANDOM[9'hBD][16:5];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_rxq_idx = _RANDOM[9'hBE][3:2];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_xcpt_pf_if = _RANDOM[9'hC3][6];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_xcpt_ae_if = _RANDOM[9'hC3][7];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_xcpt_ma_if = _RANDOM[9'hC3][8];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_bp_debug_if = _RANDOM[9'hC3][9];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_bp_xcpt_if = _RANDOM[9'hC3][10];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_debug_fsrc = _RANDOM[9'hC3][12:11];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_debug_tsrc = _RANDOM[9'hC3][14:13];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_inst = {_RANDOM[9'hC3][31:22], _RANDOM[9'hC4][21:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_15_debug_inst = {_RANDOM[9'hC4][31:22], _RANDOM[9'hC5][21:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_15_is_rvc = _RANDOM[9'hC5][22];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_debug_pc = {_RANDOM[9'hC5][31:23], _RANDOM[9'hC6][30:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_15_ctrl_br_type = _RANDOM[9'hC7][15:12];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_ctrl_op1_sel = _RANDOM[9'hC7][17:16];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_ctrl_op2_sel = _RANDOM[9'hC7][20:18];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_ctrl_imm_sel = _RANDOM[9'hC7][23:21];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_ctrl_op_fcn = _RANDOM[9'hC7][27:24];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_ctrl_fcn_dw = _RANDOM[9'hC7][28];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_ctrl_csr_cmd = _RANDOM[9'hC7][31:29];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_ctrl_is_load = _RANDOM[9'hC8][0];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_ctrl_is_sta = _RANDOM[9'hC8][1];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_ctrl_is_std = _RANDOM[9'hC8][2];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_iw_state = _RANDOM[9'hC8][4:3];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_iw_p1_poisoned = _RANDOM[9'hC8][5];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_iw_p2_poisoned = _RANDOM[9'hC8][6];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_is_sfb = _RANDOM[9'hC8][10];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_ftq_idx = _RANDOM[9'hC9][9:4];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_edge_inst = _RANDOM[9'hC9][10];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_pc_lob = _RANDOM[9'hC9][16:11];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_taken = _RANDOM[9'hC9][17];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_csr_addr = _RANDOM[9'hCA][17:6];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_rxq_idx = _RANDOM[9'hCB][4:3];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_xcpt_pf_if = _RANDOM[9'hD0][7];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_xcpt_ae_if = _RANDOM[9'hD0][8];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_xcpt_ma_if = _RANDOM[9'hD0][9];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_bp_debug_if = _RANDOM[9'hD0][10];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_bp_xcpt_if = _RANDOM[9'hD0][11];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_debug_fsrc = _RANDOM[9'hD0][13:12];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_debug_tsrc = _RANDOM[9'hD0][15:14];	// fetch-buffer.scala:57:16
        fb_uop_ram_16_inst = {_RANDOM[9'hD0][31:23], _RANDOM[9'hD1][22:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_16_debug_inst = {_RANDOM[9'hD1][31:23], _RANDOM[9'hD2][22:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_16_is_rvc = _RANDOM[9'hD2][23];	// fetch-buffer.scala:57:16
        fb_uop_ram_16_debug_pc = {_RANDOM[9'hD2][31:24], _RANDOM[9'hD3]};	// fetch-buffer.scala:57:16
        fb_uop_ram_16_ctrl_br_type = _RANDOM[9'hD4][16:13];	// fetch-buffer.scala:57:16
        fb_uop_ram_16_ctrl_op1_sel = _RANDOM[9'hD4][18:17];	// fetch-buffer.scala:57:16
        fb_uop_ram_16_ctrl_op2_sel = _RANDOM[9'hD4][21:19];	// fetch-buffer.scala:57:16
        fb_uop_ram_16_ctrl_imm_sel = _RANDOM[9'hD4][24:22];	// fetch-buffer.scala:57:16
        fb_uop_ram_16_ctrl_op_fcn = _RANDOM[9'hD4][28:25];	// fetch-buffer.scala:57:16
        fb_uop_ram_16_ctrl_fcn_dw = _RANDOM[9'hD4][29];	// fetch-buffer.scala:57:16
        fb_uop_ram_16_ctrl_csr_cmd = {_RANDOM[9'hD4][31:30], _RANDOM[9'hD5][0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_16_ctrl_is_load = _RANDOM[9'hD5][1];	// fetch-buffer.scala:57:16
        fb_uop_ram_16_ctrl_is_sta = _RANDOM[9'hD5][2];	// fetch-buffer.scala:57:16
        fb_uop_ram_16_ctrl_is_std = _RANDOM[9'hD5][3];	// fetch-buffer.scala:57:16
        fb_uop_ram_16_iw_state = _RANDOM[9'hD5][5:4];	// fetch-buffer.scala:57:16
        fb_uop_ram_16_iw_p1_poisoned = _RANDOM[9'hD5][6];	// fetch-buffer.scala:57:16
        fb_uop_ram_16_iw_p2_poisoned = _RANDOM[9'hD5][7];	// fetch-buffer.scala:57:16
        fb_uop_ram_16_is_sfb = _RANDOM[9'hD5][11];	// fetch-buffer.scala:57:16
        fb_uop_ram_16_ftq_idx = _RANDOM[9'hD6][10:5];	// fetch-buffer.scala:57:16
        fb_uop_ram_16_edge_inst = _RANDOM[9'hD6][11];	// fetch-buffer.scala:57:16
        fb_uop_ram_16_pc_lob = _RANDOM[9'hD6][17:12];	// fetch-buffer.scala:57:16
        fb_uop_ram_16_taken = _RANDOM[9'hD6][18];	// fetch-buffer.scala:57:16
        fb_uop_ram_16_csr_addr = _RANDOM[9'hD7][18:7];	// fetch-buffer.scala:57:16
        fb_uop_ram_16_rxq_idx = _RANDOM[9'hD8][5:4];	// fetch-buffer.scala:57:16
        fb_uop_ram_16_xcpt_pf_if = _RANDOM[9'hDD][8];	// fetch-buffer.scala:57:16
        fb_uop_ram_16_xcpt_ae_if = _RANDOM[9'hDD][9];	// fetch-buffer.scala:57:16
        fb_uop_ram_16_xcpt_ma_if = _RANDOM[9'hDD][10];	// fetch-buffer.scala:57:16
        fb_uop_ram_16_bp_debug_if = _RANDOM[9'hDD][11];	// fetch-buffer.scala:57:16
        fb_uop_ram_16_bp_xcpt_if = _RANDOM[9'hDD][12];	// fetch-buffer.scala:57:16
        fb_uop_ram_16_debug_fsrc = _RANDOM[9'hDD][14:13];	// fetch-buffer.scala:57:16
        fb_uop_ram_16_debug_tsrc = _RANDOM[9'hDD][16:15];	// fetch-buffer.scala:57:16
        fb_uop_ram_17_inst = {_RANDOM[9'hDD][31:24], _RANDOM[9'hDE][23:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_17_debug_inst = {_RANDOM[9'hDE][31:24], _RANDOM[9'hDF][23:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_17_is_rvc = _RANDOM[9'hDF][24];	// fetch-buffer.scala:57:16
        fb_uop_ram_17_debug_pc =
          {_RANDOM[9'hDF][31:25], _RANDOM[9'hE0], _RANDOM[9'hE1][0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_17_ctrl_br_type = _RANDOM[9'hE1][17:14];	// fetch-buffer.scala:57:16
        fb_uop_ram_17_ctrl_op1_sel = _RANDOM[9'hE1][19:18];	// fetch-buffer.scala:57:16
        fb_uop_ram_17_ctrl_op2_sel = _RANDOM[9'hE1][22:20];	// fetch-buffer.scala:57:16
        fb_uop_ram_17_ctrl_imm_sel = _RANDOM[9'hE1][25:23];	// fetch-buffer.scala:57:16
        fb_uop_ram_17_ctrl_op_fcn = _RANDOM[9'hE1][29:26];	// fetch-buffer.scala:57:16
        fb_uop_ram_17_ctrl_fcn_dw = _RANDOM[9'hE1][30];	// fetch-buffer.scala:57:16
        fb_uop_ram_17_ctrl_csr_cmd = {_RANDOM[9'hE1][31], _RANDOM[9'hE2][1:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_17_ctrl_is_load = _RANDOM[9'hE2][2];	// fetch-buffer.scala:57:16
        fb_uop_ram_17_ctrl_is_sta = _RANDOM[9'hE2][3];	// fetch-buffer.scala:57:16
        fb_uop_ram_17_ctrl_is_std = _RANDOM[9'hE2][4];	// fetch-buffer.scala:57:16
        fb_uop_ram_17_iw_state = _RANDOM[9'hE2][6:5];	// fetch-buffer.scala:57:16
        fb_uop_ram_17_iw_p1_poisoned = _RANDOM[9'hE2][7];	// fetch-buffer.scala:57:16
        fb_uop_ram_17_iw_p2_poisoned = _RANDOM[9'hE2][8];	// fetch-buffer.scala:57:16
        fb_uop_ram_17_is_sfb = _RANDOM[9'hE2][12];	// fetch-buffer.scala:57:16
        fb_uop_ram_17_ftq_idx = _RANDOM[9'hE3][11:6];	// fetch-buffer.scala:57:16
        fb_uop_ram_17_edge_inst = _RANDOM[9'hE3][12];	// fetch-buffer.scala:57:16
        fb_uop_ram_17_pc_lob = _RANDOM[9'hE3][18:13];	// fetch-buffer.scala:57:16
        fb_uop_ram_17_taken = _RANDOM[9'hE3][19];	// fetch-buffer.scala:57:16
        fb_uop_ram_17_csr_addr = _RANDOM[9'hE4][19:8];	// fetch-buffer.scala:57:16
        fb_uop_ram_17_rxq_idx = _RANDOM[9'hE5][6:5];	// fetch-buffer.scala:57:16
        fb_uop_ram_17_xcpt_pf_if = _RANDOM[9'hEA][9];	// fetch-buffer.scala:57:16
        fb_uop_ram_17_xcpt_ae_if = _RANDOM[9'hEA][10];	// fetch-buffer.scala:57:16
        fb_uop_ram_17_xcpt_ma_if = _RANDOM[9'hEA][11];	// fetch-buffer.scala:57:16
        fb_uop_ram_17_bp_debug_if = _RANDOM[9'hEA][12];	// fetch-buffer.scala:57:16
        fb_uop_ram_17_bp_xcpt_if = _RANDOM[9'hEA][13];	// fetch-buffer.scala:57:16
        fb_uop_ram_17_debug_fsrc = _RANDOM[9'hEA][15:14];	// fetch-buffer.scala:57:16
        fb_uop_ram_17_debug_tsrc = _RANDOM[9'hEA][17:16];	// fetch-buffer.scala:57:16
        fb_uop_ram_18_inst = {_RANDOM[9'hEA][31:25], _RANDOM[9'hEB][24:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_18_debug_inst = {_RANDOM[9'hEB][31:25], _RANDOM[9'hEC][24:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_18_is_rvc = _RANDOM[9'hEC][25];	// fetch-buffer.scala:57:16
        fb_uop_ram_18_debug_pc =
          {_RANDOM[9'hEC][31:26], _RANDOM[9'hED], _RANDOM[9'hEE][1:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_18_ctrl_br_type = _RANDOM[9'hEE][18:15];	// fetch-buffer.scala:57:16
        fb_uop_ram_18_ctrl_op1_sel = _RANDOM[9'hEE][20:19];	// fetch-buffer.scala:57:16
        fb_uop_ram_18_ctrl_op2_sel = _RANDOM[9'hEE][23:21];	// fetch-buffer.scala:57:16
        fb_uop_ram_18_ctrl_imm_sel = _RANDOM[9'hEE][26:24];	// fetch-buffer.scala:57:16
        fb_uop_ram_18_ctrl_op_fcn = _RANDOM[9'hEE][30:27];	// fetch-buffer.scala:57:16
        fb_uop_ram_18_ctrl_fcn_dw = _RANDOM[9'hEE][31];	// fetch-buffer.scala:57:16
        fb_uop_ram_18_ctrl_csr_cmd = _RANDOM[9'hEF][2:0];	// fetch-buffer.scala:57:16
        fb_uop_ram_18_ctrl_is_load = _RANDOM[9'hEF][3];	// fetch-buffer.scala:57:16
        fb_uop_ram_18_ctrl_is_sta = _RANDOM[9'hEF][4];	// fetch-buffer.scala:57:16
        fb_uop_ram_18_ctrl_is_std = _RANDOM[9'hEF][5];	// fetch-buffer.scala:57:16
        fb_uop_ram_18_iw_state = _RANDOM[9'hEF][7:6];	// fetch-buffer.scala:57:16
        fb_uop_ram_18_iw_p1_poisoned = _RANDOM[9'hEF][8];	// fetch-buffer.scala:57:16
        fb_uop_ram_18_iw_p2_poisoned = _RANDOM[9'hEF][9];	// fetch-buffer.scala:57:16
        fb_uop_ram_18_is_sfb = _RANDOM[9'hEF][13];	// fetch-buffer.scala:57:16
        fb_uop_ram_18_ftq_idx = _RANDOM[9'hF0][12:7];	// fetch-buffer.scala:57:16
        fb_uop_ram_18_edge_inst = _RANDOM[9'hF0][13];	// fetch-buffer.scala:57:16
        fb_uop_ram_18_pc_lob = _RANDOM[9'hF0][19:14];	// fetch-buffer.scala:57:16
        fb_uop_ram_18_taken = _RANDOM[9'hF0][20];	// fetch-buffer.scala:57:16
        fb_uop_ram_18_csr_addr = _RANDOM[9'hF1][20:9];	// fetch-buffer.scala:57:16
        fb_uop_ram_18_rxq_idx = _RANDOM[9'hF2][7:6];	// fetch-buffer.scala:57:16
        fb_uop_ram_18_xcpt_pf_if = _RANDOM[9'hF7][10];	// fetch-buffer.scala:57:16
        fb_uop_ram_18_xcpt_ae_if = _RANDOM[9'hF7][11];	// fetch-buffer.scala:57:16
        fb_uop_ram_18_xcpt_ma_if = _RANDOM[9'hF7][12];	// fetch-buffer.scala:57:16
        fb_uop_ram_18_bp_debug_if = _RANDOM[9'hF7][13];	// fetch-buffer.scala:57:16
        fb_uop_ram_18_bp_xcpt_if = _RANDOM[9'hF7][14];	// fetch-buffer.scala:57:16
        fb_uop_ram_18_debug_fsrc = _RANDOM[9'hF7][16:15];	// fetch-buffer.scala:57:16
        fb_uop_ram_18_debug_tsrc = _RANDOM[9'hF7][18:17];	// fetch-buffer.scala:57:16
        fb_uop_ram_19_inst = {_RANDOM[9'hF7][31:26], _RANDOM[9'hF8][25:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_19_debug_inst = {_RANDOM[9'hF8][31:26], _RANDOM[9'hF9][25:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_19_is_rvc = _RANDOM[9'hF9][26];	// fetch-buffer.scala:57:16
        fb_uop_ram_19_debug_pc =
          {_RANDOM[9'hF9][31:27], _RANDOM[9'hFA], _RANDOM[9'hFB][2:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_19_ctrl_br_type = _RANDOM[9'hFB][19:16];	// fetch-buffer.scala:57:16
        fb_uop_ram_19_ctrl_op1_sel = _RANDOM[9'hFB][21:20];	// fetch-buffer.scala:57:16
        fb_uop_ram_19_ctrl_op2_sel = _RANDOM[9'hFB][24:22];	// fetch-buffer.scala:57:16
        fb_uop_ram_19_ctrl_imm_sel = _RANDOM[9'hFB][27:25];	// fetch-buffer.scala:57:16
        fb_uop_ram_19_ctrl_op_fcn = _RANDOM[9'hFB][31:28];	// fetch-buffer.scala:57:16
        fb_uop_ram_19_ctrl_fcn_dw = _RANDOM[9'hFC][0];	// fetch-buffer.scala:57:16
        fb_uop_ram_19_ctrl_csr_cmd = _RANDOM[9'hFC][3:1];	// fetch-buffer.scala:57:16
        fb_uop_ram_19_ctrl_is_load = _RANDOM[9'hFC][4];	// fetch-buffer.scala:57:16
        fb_uop_ram_19_ctrl_is_sta = _RANDOM[9'hFC][5];	// fetch-buffer.scala:57:16
        fb_uop_ram_19_ctrl_is_std = _RANDOM[9'hFC][6];	// fetch-buffer.scala:57:16
        fb_uop_ram_19_iw_state = _RANDOM[9'hFC][8:7];	// fetch-buffer.scala:57:16
        fb_uop_ram_19_iw_p1_poisoned = _RANDOM[9'hFC][9];	// fetch-buffer.scala:57:16
        fb_uop_ram_19_iw_p2_poisoned = _RANDOM[9'hFC][10];	// fetch-buffer.scala:57:16
        fb_uop_ram_19_is_sfb = _RANDOM[9'hFC][14];	// fetch-buffer.scala:57:16
        fb_uop_ram_19_ftq_idx = _RANDOM[9'hFD][13:8];	// fetch-buffer.scala:57:16
        fb_uop_ram_19_edge_inst = _RANDOM[9'hFD][14];	// fetch-buffer.scala:57:16
        fb_uop_ram_19_pc_lob = _RANDOM[9'hFD][20:15];	// fetch-buffer.scala:57:16
        fb_uop_ram_19_taken = _RANDOM[9'hFD][21];	// fetch-buffer.scala:57:16
        fb_uop_ram_19_csr_addr = _RANDOM[9'hFE][21:10];	// fetch-buffer.scala:57:16
        fb_uop_ram_19_rxq_idx = _RANDOM[9'hFF][8:7];	// fetch-buffer.scala:57:16
        fb_uop_ram_19_xcpt_pf_if = _RANDOM[9'h104][11];	// fetch-buffer.scala:57:16
        fb_uop_ram_19_xcpt_ae_if = _RANDOM[9'h104][12];	// fetch-buffer.scala:57:16
        fb_uop_ram_19_xcpt_ma_if = _RANDOM[9'h104][13];	// fetch-buffer.scala:57:16
        fb_uop_ram_19_bp_debug_if = _RANDOM[9'h104][14];	// fetch-buffer.scala:57:16
        fb_uop_ram_19_bp_xcpt_if = _RANDOM[9'h104][15];	// fetch-buffer.scala:57:16
        fb_uop_ram_19_debug_fsrc = _RANDOM[9'h104][17:16];	// fetch-buffer.scala:57:16
        fb_uop_ram_19_debug_tsrc = _RANDOM[9'h104][19:18];	// fetch-buffer.scala:57:16
        fb_uop_ram_20_inst = {_RANDOM[9'h104][31:27], _RANDOM[9'h105][26:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_20_debug_inst = {_RANDOM[9'h105][31:27], _RANDOM[9'h106][26:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_20_is_rvc = _RANDOM[9'h106][27];	// fetch-buffer.scala:57:16
        fb_uop_ram_20_debug_pc =
          {_RANDOM[9'h106][31:28], _RANDOM[9'h107], _RANDOM[9'h108][3:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_20_ctrl_br_type = _RANDOM[9'h108][20:17];	// fetch-buffer.scala:57:16
        fb_uop_ram_20_ctrl_op1_sel = _RANDOM[9'h108][22:21];	// fetch-buffer.scala:57:16
        fb_uop_ram_20_ctrl_op2_sel = _RANDOM[9'h108][25:23];	// fetch-buffer.scala:57:16
        fb_uop_ram_20_ctrl_imm_sel = _RANDOM[9'h108][28:26];	// fetch-buffer.scala:57:16
        fb_uop_ram_20_ctrl_op_fcn = {_RANDOM[9'h108][31:29], _RANDOM[9'h109][0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_20_ctrl_fcn_dw = _RANDOM[9'h109][1];	// fetch-buffer.scala:57:16
        fb_uop_ram_20_ctrl_csr_cmd = _RANDOM[9'h109][4:2];	// fetch-buffer.scala:57:16
        fb_uop_ram_20_ctrl_is_load = _RANDOM[9'h109][5];	// fetch-buffer.scala:57:16
        fb_uop_ram_20_ctrl_is_sta = _RANDOM[9'h109][6];	// fetch-buffer.scala:57:16
        fb_uop_ram_20_ctrl_is_std = _RANDOM[9'h109][7];	// fetch-buffer.scala:57:16
        fb_uop_ram_20_iw_state = _RANDOM[9'h109][9:8];	// fetch-buffer.scala:57:16
        fb_uop_ram_20_iw_p1_poisoned = _RANDOM[9'h109][10];	// fetch-buffer.scala:57:16
        fb_uop_ram_20_iw_p2_poisoned = _RANDOM[9'h109][11];	// fetch-buffer.scala:57:16
        fb_uop_ram_20_is_sfb = _RANDOM[9'h109][15];	// fetch-buffer.scala:57:16
        fb_uop_ram_20_ftq_idx = _RANDOM[9'h10A][14:9];	// fetch-buffer.scala:57:16
        fb_uop_ram_20_edge_inst = _RANDOM[9'h10A][15];	// fetch-buffer.scala:57:16
        fb_uop_ram_20_pc_lob = _RANDOM[9'h10A][21:16];	// fetch-buffer.scala:57:16
        fb_uop_ram_20_taken = _RANDOM[9'h10A][22];	// fetch-buffer.scala:57:16
        fb_uop_ram_20_csr_addr = _RANDOM[9'h10B][22:11];	// fetch-buffer.scala:57:16
        fb_uop_ram_20_rxq_idx = _RANDOM[9'h10C][9:8];	// fetch-buffer.scala:57:16
        fb_uop_ram_20_xcpt_pf_if = _RANDOM[9'h111][12];	// fetch-buffer.scala:57:16
        fb_uop_ram_20_xcpt_ae_if = _RANDOM[9'h111][13];	// fetch-buffer.scala:57:16
        fb_uop_ram_20_xcpt_ma_if = _RANDOM[9'h111][14];	// fetch-buffer.scala:57:16
        fb_uop_ram_20_bp_debug_if = _RANDOM[9'h111][15];	// fetch-buffer.scala:57:16
        fb_uop_ram_20_bp_xcpt_if = _RANDOM[9'h111][16];	// fetch-buffer.scala:57:16
        fb_uop_ram_20_debug_fsrc = _RANDOM[9'h111][18:17];	// fetch-buffer.scala:57:16
        fb_uop_ram_20_debug_tsrc = _RANDOM[9'h111][20:19];	// fetch-buffer.scala:57:16
        fb_uop_ram_21_inst = {_RANDOM[9'h111][31:28], _RANDOM[9'h112][27:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_21_debug_inst = {_RANDOM[9'h112][31:28], _RANDOM[9'h113][27:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_21_is_rvc = _RANDOM[9'h113][28];	// fetch-buffer.scala:57:16
        fb_uop_ram_21_debug_pc =
          {_RANDOM[9'h113][31:29], _RANDOM[9'h114], _RANDOM[9'h115][4:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_21_ctrl_br_type = _RANDOM[9'h115][21:18];	// fetch-buffer.scala:57:16
        fb_uop_ram_21_ctrl_op1_sel = _RANDOM[9'h115][23:22];	// fetch-buffer.scala:57:16
        fb_uop_ram_21_ctrl_op2_sel = _RANDOM[9'h115][26:24];	// fetch-buffer.scala:57:16
        fb_uop_ram_21_ctrl_imm_sel = _RANDOM[9'h115][29:27];	// fetch-buffer.scala:57:16
        fb_uop_ram_21_ctrl_op_fcn = {_RANDOM[9'h115][31:30], _RANDOM[9'h116][1:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_21_ctrl_fcn_dw = _RANDOM[9'h116][2];	// fetch-buffer.scala:57:16
        fb_uop_ram_21_ctrl_csr_cmd = _RANDOM[9'h116][5:3];	// fetch-buffer.scala:57:16
        fb_uop_ram_21_ctrl_is_load = _RANDOM[9'h116][6];	// fetch-buffer.scala:57:16
        fb_uop_ram_21_ctrl_is_sta = _RANDOM[9'h116][7];	// fetch-buffer.scala:57:16
        fb_uop_ram_21_ctrl_is_std = _RANDOM[9'h116][8];	// fetch-buffer.scala:57:16
        fb_uop_ram_21_iw_state = _RANDOM[9'h116][10:9];	// fetch-buffer.scala:57:16
        fb_uop_ram_21_iw_p1_poisoned = _RANDOM[9'h116][11];	// fetch-buffer.scala:57:16
        fb_uop_ram_21_iw_p2_poisoned = _RANDOM[9'h116][12];	// fetch-buffer.scala:57:16
        fb_uop_ram_21_is_sfb = _RANDOM[9'h116][16];	// fetch-buffer.scala:57:16
        fb_uop_ram_21_ftq_idx = _RANDOM[9'h117][15:10];	// fetch-buffer.scala:57:16
        fb_uop_ram_21_edge_inst = _RANDOM[9'h117][16];	// fetch-buffer.scala:57:16
        fb_uop_ram_21_pc_lob = _RANDOM[9'h117][22:17];	// fetch-buffer.scala:57:16
        fb_uop_ram_21_taken = _RANDOM[9'h117][23];	// fetch-buffer.scala:57:16
        fb_uop_ram_21_csr_addr = _RANDOM[9'h118][23:12];	// fetch-buffer.scala:57:16
        fb_uop_ram_21_rxq_idx = _RANDOM[9'h119][10:9];	// fetch-buffer.scala:57:16
        fb_uop_ram_21_xcpt_pf_if = _RANDOM[9'h11E][13];	// fetch-buffer.scala:57:16
        fb_uop_ram_21_xcpt_ae_if = _RANDOM[9'h11E][14];	// fetch-buffer.scala:57:16
        fb_uop_ram_21_xcpt_ma_if = _RANDOM[9'h11E][15];	// fetch-buffer.scala:57:16
        fb_uop_ram_21_bp_debug_if = _RANDOM[9'h11E][16];	// fetch-buffer.scala:57:16
        fb_uop_ram_21_bp_xcpt_if = _RANDOM[9'h11E][17];	// fetch-buffer.scala:57:16
        fb_uop_ram_21_debug_fsrc = _RANDOM[9'h11E][19:18];	// fetch-buffer.scala:57:16
        fb_uop_ram_21_debug_tsrc = _RANDOM[9'h11E][21:20];	// fetch-buffer.scala:57:16
        fb_uop_ram_22_inst = {_RANDOM[9'h11E][31:29], _RANDOM[9'h11F][28:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_22_debug_inst = {_RANDOM[9'h11F][31:29], _RANDOM[9'h120][28:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_22_is_rvc = _RANDOM[9'h120][29];	// fetch-buffer.scala:57:16
        fb_uop_ram_22_debug_pc =
          {_RANDOM[9'h120][31:30], _RANDOM[9'h121], _RANDOM[9'h122][5:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_22_ctrl_br_type = _RANDOM[9'h122][22:19];	// fetch-buffer.scala:57:16
        fb_uop_ram_22_ctrl_op1_sel = _RANDOM[9'h122][24:23];	// fetch-buffer.scala:57:16
        fb_uop_ram_22_ctrl_op2_sel = _RANDOM[9'h122][27:25];	// fetch-buffer.scala:57:16
        fb_uop_ram_22_ctrl_imm_sel = _RANDOM[9'h122][30:28];	// fetch-buffer.scala:57:16
        fb_uop_ram_22_ctrl_op_fcn = {_RANDOM[9'h122][31], _RANDOM[9'h123][2:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_22_ctrl_fcn_dw = _RANDOM[9'h123][3];	// fetch-buffer.scala:57:16
        fb_uop_ram_22_ctrl_csr_cmd = _RANDOM[9'h123][6:4];	// fetch-buffer.scala:57:16
        fb_uop_ram_22_ctrl_is_load = _RANDOM[9'h123][7];	// fetch-buffer.scala:57:16
        fb_uop_ram_22_ctrl_is_sta = _RANDOM[9'h123][8];	// fetch-buffer.scala:57:16
        fb_uop_ram_22_ctrl_is_std = _RANDOM[9'h123][9];	// fetch-buffer.scala:57:16
        fb_uop_ram_22_iw_state = _RANDOM[9'h123][11:10];	// fetch-buffer.scala:57:16
        fb_uop_ram_22_iw_p1_poisoned = _RANDOM[9'h123][12];	// fetch-buffer.scala:57:16
        fb_uop_ram_22_iw_p2_poisoned = _RANDOM[9'h123][13];	// fetch-buffer.scala:57:16
        fb_uop_ram_22_is_sfb = _RANDOM[9'h123][17];	// fetch-buffer.scala:57:16
        fb_uop_ram_22_ftq_idx = _RANDOM[9'h124][16:11];	// fetch-buffer.scala:57:16
        fb_uop_ram_22_edge_inst = _RANDOM[9'h124][17];	// fetch-buffer.scala:57:16
        fb_uop_ram_22_pc_lob = _RANDOM[9'h124][23:18];	// fetch-buffer.scala:57:16
        fb_uop_ram_22_taken = _RANDOM[9'h124][24];	// fetch-buffer.scala:57:16
        fb_uop_ram_22_csr_addr = _RANDOM[9'h125][24:13];	// fetch-buffer.scala:57:16
        fb_uop_ram_22_rxq_idx = _RANDOM[9'h126][11:10];	// fetch-buffer.scala:57:16
        fb_uop_ram_22_xcpt_pf_if = _RANDOM[9'h12B][14];	// fetch-buffer.scala:57:16
        fb_uop_ram_22_xcpt_ae_if = _RANDOM[9'h12B][15];	// fetch-buffer.scala:57:16
        fb_uop_ram_22_xcpt_ma_if = _RANDOM[9'h12B][16];	// fetch-buffer.scala:57:16
        fb_uop_ram_22_bp_debug_if = _RANDOM[9'h12B][17];	// fetch-buffer.scala:57:16
        fb_uop_ram_22_bp_xcpt_if = _RANDOM[9'h12B][18];	// fetch-buffer.scala:57:16
        fb_uop_ram_22_debug_fsrc = _RANDOM[9'h12B][20:19];	// fetch-buffer.scala:57:16
        fb_uop_ram_22_debug_tsrc = _RANDOM[9'h12B][22:21];	// fetch-buffer.scala:57:16
        fb_uop_ram_23_inst = {_RANDOM[9'h12B][31:30], _RANDOM[9'h12C][29:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_23_debug_inst = {_RANDOM[9'h12C][31:30], _RANDOM[9'h12D][29:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_23_is_rvc = _RANDOM[9'h12D][30];	// fetch-buffer.scala:57:16
        fb_uop_ram_23_debug_pc =
          {_RANDOM[9'h12D][31], _RANDOM[9'h12E], _RANDOM[9'h12F][6:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_23_ctrl_br_type = _RANDOM[9'h12F][23:20];	// fetch-buffer.scala:57:16
        fb_uop_ram_23_ctrl_op1_sel = _RANDOM[9'h12F][25:24];	// fetch-buffer.scala:57:16
        fb_uop_ram_23_ctrl_op2_sel = _RANDOM[9'h12F][28:26];	// fetch-buffer.scala:57:16
        fb_uop_ram_23_ctrl_imm_sel = _RANDOM[9'h12F][31:29];	// fetch-buffer.scala:57:16
        fb_uop_ram_23_ctrl_op_fcn = _RANDOM[9'h130][3:0];	// fetch-buffer.scala:57:16
        fb_uop_ram_23_ctrl_fcn_dw = _RANDOM[9'h130][4];	// fetch-buffer.scala:57:16
        fb_uop_ram_23_ctrl_csr_cmd = _RANDOM[9'h130][7:5];	// fetch-buffer.scala:57:16
        fb_uop_ram_23_ctrl_is_load = _RANDOM[9'h130][8];	// fetch-buffer.scala:57:16
        fb_uop_ram_23_ctrl_is_sta = _RANDOM[9'h130][9];	// fetch-buffer.scala:57:16
        fb_uop_ram_23_ctrl_is_std = _RANDOM[9'h130][10];	// fetch-buffer.scala:57:16
        fb_uop_ram_23_iw_state = _RANDOM[9'h130][12:11];	// fetch-buffer.scala:57:16
        fb_uop_ram_23_iw_p1_poisoned = _RANDOM[9'h130][13];	// fetch-buffer.scala:57:16
        fb_uop_ram_23_iw_p2_poisoned = _RANDOM[9'h130][14];	// fetch-buffer.scala:57:16
        fb_uop_ram_23_is_sfb = _RANDOM[9'h130][18];	// fetch-buffer.scala:57:16
        fb_uop_ram_23_ftq_idx = _RANDOM[9'h131][17:12];	// fetch-buffer.scala:57:16
        fb_uop_ram_23_edge_inst = _RANDOM[9'h131][18];	// fetch-buffer.scala:57:16
        fb_uop_ram_23_pc_lob = _RANDOM[9'h131][24:19];	// fetch-buffer.scala:57:16
        fb_uop_ram_23_taken = _RANDOM[9'h131][25];	// fetch-buffer.scala:57:16
        fb_uop_ram_23_csr_addr = _RANDOM[9'h132][25:14];	// fetch-buffer.scala:57:16
        fb_uop_ram_23_rxq_idx = _RANDOM[9'h133][12:11];	// fetch-buffer.scala:57:16
        fb_uop_ram_23_xcpt_pf_if = _RANDOM[9'h138][15];	// fetch-buffer.scala:57:16
        fb_uop_ram_23_xcpt_ae_if = _RANDOM[9'h138][16];	// fetch-buffer.scala:57:16
        fb_uop_ram_23_xcpt_ma_if = _RANDOM[9'h138][17];	// fetch-buffer.scala:57:16
        fb_uop_ram_23_bp_debug_if = _RANDOM[9'h138][18];	// fetch-buffer.scala:57:16
        fb_uop_ram_23_bp_xcpt_if = _RANDOM[9'h138][19];	// fetch-buffer.scala:57:16
        fb_uop_ram_23_debug_fsrc = _RANDOM[9'h138][21:20];	// fetch-buffer.scala:57:16
        fb_uop_ram_23_debug_tsrc = _RANDOM[9'h138][23:22];	// fetch-buffer.scala:57:16
        fb_uop_ram_24_inst = {_RANDOM[9'h138][31], _RANDOM[9'h139][30:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_24_debug_inst = {_RANDOM[9'h139][31], _RANDOM[9'h13A][30:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_24_is_rvc = _RANDOM[9'h13A][31];	// fetch-buffer.scala:57:16
        fb_uop_ram_24_debug_pc = {_RANDOM[9'h13B], _RANDOM[9'h13C][7:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_24_ctrl_br_type = _RANDOM[9'h13C][24:21];	// fetch-buffer.scala:57:16
        fb_uop_ram_24_ctrl_op1_sel = _RANDOM[9'h13C][26:25];	// fetch-buffer.scala:57:16
        fb_uop_ram_24_ctrl_op2_sel = _RANDOM[9'h13C][29:27];	// fetch-buffer.scala:57:16
        fb_uop_ram_24_ctrl_imm_sel = {_RANDOM[9'h13C][31:30], _RANDOM[9'h13D][0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_24_ctrl_op_fcn = _RANDOM[9'h13D][4:1];	// fetch-buffer.scala:57:16
        fb_uop_ram_24_ctrl_fcn_dw = _RANDOM[9'h13D][5];	// fetch-buffer.scala:57:16
        fb_uop_ram_24_ctrl_csr_cmd = _RANDOM[9'h13D][8:6];	// fetch-buffer.scala:57:16
        fb_uop_ram_24_ctrl_is_load = _RANDOM[9'h13D][9];	// fetch-buffer.scala:57:16
        fb_uop_ram_24_ctrl_is_sta = _RANDOM[9'h13D][10];	// fetch-buffer.scala:57:16
        fb_uop_ram_24_ctrl_is_std = _RANDOM[9'h13D][11];	// fetch-buffer.scala:57:16
        fb_uop_ram_24_iw_state = _RANDOM[9'h13D][13:12];	// fetch-buffer.scala:57:16
        fb_uop_ram_24_iw_p1_poisoned = _RANDOM[9'h13D][14];	// fetch-buffer.scala:57:16
        fb_uop_ram_24_iw_p2_poisoned = _RANDOM[9'h13D][15];	// fetch-buffer.scala:57:16
        fb_uop_ram_24_is_sfb = _RANDOM[9'h13D][19];	// fetch-buffer.scala:57:16
        fb_uop_ram_24_ftq_idx = _RANDOM[9'h13E][18:13];	// fetch-buffer.scala:57:16
        fb_uop_ram_24_edge_inst = _RANDOM[9'h13E][19];	// fetch-buffer.scala:57:16
        fb_uop_ram_24_pc_lob = _RANDOM[9'h13E][25:20];	// fetch-buffer.scala:57:16
        fb_uop_ram_24_taken = _RANDOM[9'h13E][26];	// fetch-buffer.scala:57:16
        fb_uop_ram_24_csr_addr = _RANDOM[9'h13F][26:15];	// fetch-buffer.scala:57:16
        fb_uop_ram_24_rxq_idx = _RANDOM[9'h140][13:12];	// fetch-buffer.scala:57:16
        fb_uop_ram_24_xcpt_pf_if = _RANDOM[9'h145][16];	// fetch-buffer.scala:57:16
        fb_uop_ram_24_xcpt_ae_if = _RANDOM[9'h145][17];	// fetch-buffer.scala:57:16
        fb_uop_ram_24_xcpt_ma_if = _RANDOM[9'h145][18];	// fetch-buffer.scala:57:16
        fb_uop_ram_24_bp_debug_if = _RANDOM[9'h145][19];	// fetch-buffer.scala:57:16
        fb_uop_ram_24_bp_xcpt_if = _RANDOM[9'h145][20];	// fetch-buffer.scala:57:16
        fb_uop_ram_24_debug_fsrc = _RANDOM[9'h145][22:21];	// fetch-buffer.scala:57:16
        fb_uop_ram_24_debug_tsrc = _RANDOM[9'h145][24:23];	// fetch-buffer.scala:57:16
        fb_uop_ram_25_inst = _RANDOM[9'h146];	// fetch-buffer.scala:57:16
        fb_uop_ram_25_debug_inst = _RANDOM[9'h147];	// fetch-buffer.scala:57:16
        fb_uop_ram_25_is_rvc = _RANDOM[9'h148][0];	// fetch-buffer.scala:57:16
        fb_uop_ram_25_debug_pc = {_RANDOM[9'h148][31:1], _RANDOM[9'h149][8:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_25_ctrl_br_type = _RANDOM[9'h149][25:22];	// fetch-buffer.scala:57:16
        fb_uop_ram_25_ctrl_op1_sel = _RANDOM[9'h149][27:26];	// fetch-buffer.scala:57:16
        fb_uop_ram_25_ctrl_op2_sel = _RANDOM[9'h149][30:28];	// fetch-buffer.scala:57:16
        fb_uop_ram_25_ctrl_imm_sel = {_RANDOM[9'h149][31], _RANDOM[9'h14A][1:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_25_ctrl_op_fcn = _RANDOM[9'h14A][5:2];	// fetch-buffer.scala:57:16
        fb_uop_ram_25_ctrl_fcn_dw = _RANDOM[9'h14A][6];	// fetch-buffer.scala:57:16
        fb_uop_ram_25_ctrl_csr_cmd = _RANDOM[9'h14A][9:7];	// fetch-buffer.scala:57:16
        fb_uop_ram_25_ctrl_is_load = _RANDOM[9'h14A][10];	// fetch-buffer.scala:57:16
        fb_uop_ram_25_ctrl_is_sta = _RANDOM[9'h14A][11];	// fetch-buffer.scala:57:16
        fb_uop_ram_25_ctrl_is_std = _RANDOM[9'h14A][12];	// fetch-buffer.scala:57:16
        fb_uop_ram_25_iw_state = _RANDOM[9'h14A][14:13];	// fetch-buffer.scala:57:16
        fb_uop_ram_25_iw_p1_poisoned = _RANDOM[9'h14A][15];	// fetch-buffer.scala:57:16
        fb_uop_ram_25_iw_p2_poisoned = _RANDOM[9'h14A][16];	// fetch-buffer.scala:57:16
        fb_uop_ram_25_is_sfb = _RANDOM[9'h14A][20];	// fetch-buffer.scala:57:16
        fb_uop_ram_25_ftq_idx = _RANDOM[9'h14B][19:14];	// fetch-buffer.scala:57:16
        fb_uop_ram_25_edge_inst = _RANDOM[9'h14B][20];	// fetch-buffer.scala:57:16
        fb_uop_ram_25_pc_lob = _RANDOM[9'h14B][26:21];	// fetch-buffer.scala:57:16
        fb_uop_ram_25_taken = _RANDOM[9'h14B][27];	// fetch-buffer.scala:57:16
        fb_uop_ram_25_csr_addr = _RANDOM[9'h14C][27:16];	// fetch-buffer.scala:57:16
        fb_uop_ram_25_rxq_idx = _RANDOM[9'h14D][14:13];	// fetch-buffer.scala:57:16
        fb_uop_ram_25_xcpt_pf_if = _RANDOM[9'h152][17];	// fetch-buffer.scala:57:16
        fb_uop_ram_25_xcpt_ae_if = _RANDOM[9'h152][18];	// fetch-buffer.scala:57:16
        fb_uop_ram_25_xcpt_ma_if = _RANDOM[9'h152][19];	// fetch-buffer.scala:57:16
        fb_uop_ram_25_bp_debug_if = _RANDOM[9'h152][20];	// fetch-buffer.scala:57:16
        fb_uop_ram_25_bp_xcpt_if = _RANDOM[9'h152][21];	// fetch-buffer.scala:57:16
        fb_uop_ram_25_debug_fsrc = _RANDOM[9'h152][23:22];	// fetch-buffer.scala:57:16
        fb_uop_ram_25_debug_tsrc = _RANDOM[9'h152][25:24];	// fetch-buffer.scala:57:16
        fb_uop_ram_26_inst = {_RANDOM[9'h153][31:1], _RANDOM[9'h154][0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_26_debug_inst = {_RANDOM[9'h154][31:1], _RANDOM[9'h155][0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_26_is_rvc = _RANDOM[9'h155][1];	// fetch-buffer.scala:57:16
        fb_uop_ram_26_debug_pc = {_RANDOM[9'h155][31:2], _RANDOM[9'h156][9:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_26_ctrl_br_type = _RANDOM[9'h156][26:23];	// fetch-buffer.scala:57:16
        fb_uop_ram_26_ctrl_op1_sel = _RANDOM[9'h156][28:27];	// fetch-buffer.scala:57:16
        fb_uop_ram_26_ctrl_op2_sel = _RANDOM[9'h156][31:29];	// fetch-buffer.scala:57:16
        fb_uop_ram_26_ctrl_imm_sel = _RANDOM[9'h157][2:0];	// fetch-buffer.scala:57:16
        fb_uop_ram_26_ctrl_op_fcn = _RANDOM[9'h157][6:3];	// fetch-buffer.scala:57:16
        fb_uop_ram_26_ctrl_fcn_dw = _RANDOM[9'h157][7];	// fetch-buffer.scala:57:16
        fb_uop_ram_26_ctrl_csr_cmd = _RANDOM[9'h157][10:8];	// fetch-buffer.scala:57:16
        fb_uop_ram_26_ctrl_is_load = _RANDOM[9'h157][11];	// fetch-buffer.scala:57:16
        fb_uop_ram_26_ctrl_is_sta = _RANDOM[9'h157][12];	// fetch-buffer.scala:57:16
        fb_uop_ram_26_ctrl_is_std = _RANDOM[9'h157][13];	// fetch-buffer.scala:57:16
        fb_uop_ram_26_iw_state = _RANDOM[9'h157][15:14];	// fetch-buffer.scala:57:16
        fb_uop_ram_26_iw_p1_poisoned = _RANDOM[9'h157][16];	// fetch-buffer.scala:57:16
        fb_uop_ram_26_iw_p2_poisoned = _RANDOM[9'h157][17];	// fetch-buffer.scala:57:16
        fb_uop_ram_26_is_sfb = _RANDOM[9'h157][21];	// fetch-buffer.scala:57:16
        fb_uop_ram_26_ftq_idx = _RANDOM[9'h158][20:15];	// fetch-buffer.scala:57:16
        fb_uop_ram_26_edge_inst = _RANDOM[9'h158][21];	// fetch-buffer.scala:57:16
        fb_uop_ram_26_pc_lob = _RANDOM[9'h158][27:22];	// fetch-buffer.scala:57:16
        fb_uop_ram_26_taken = _RANDOM[9'h158][28];	// fetch-buffer.scala:57:16
        fb_uop_ram_26_csr_addr = _RANDOM[9'h159][28:17];	// fetch-buffer.scala:57:16
        fb_uop_ram_26_rxq_idx = _RANDOM[9'h15A][15:14];	// fetch-buffer.scala:57:16
        fb_uop_ram_26_xcpt_pf_if = _RANDOM[9'h15F][18];	// fetch-buffer.scala:57:16
        fb_uop_ram_26_xcpt_ae_if = _RANDOM[9'h15F][19];	// fetch-buffer.scala:57:16
        fb_uop_ram_26_xcpt_ma_if = _RANDOM[9'h15F][20];	// fetch-buffer.scala:57:16
        fb_uop_ram_26_bp_debug_if = _RANDOM[9'h15F][21];	// fetch-buffer.scala:57:16
        fb_uop_ram_26_bp_xcpt_if = _RANDOM[9'h15F][22];	// fetch-buffer.scala:57:16
        fb_uop_ram_26_debug_fsrc = _RANDOM[9'h15F][24:23];	// fetch-buffer.scala:57:16
        fb_uop_ram_26_debug_tsrc = _RANDOM[9'h15F][26:25];	// fetch-buffer.scala:57:16
        fb_uop_ram_27_inst = {_RANDOM[9'h160][31:2], _RANDOM[9'h161][1:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_27_debug_inst = {_RANDOM[9'h161][31:2], _RANDOM[9'h162][1:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_27_is_rvc = _RANDOM[9'h162][2];	// fetch-buffer.scala:57:16
        fb_uop_ram_27_debug_pc = {_RANDOM[9'h162][31:3], _RANDOM[9'h163][10:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_27_ctrl_br_type = _RANDOM[9'h163][27:24];	// fetch-buffer.scala:57:16
        fb_uop_ram_27_ctrl_op1_sel = _RANDOM[9'h163][29:28];	// fetch-buffer.scala:57:16
        fb_uop_ram_27_ctrl_op2_sel = {_RANDOM[9'h163][31:30], _RANDOM[9'h164][0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_27_ctrl_imm_sel = _RANDOM[9'h164][3:1];	// fetch-buffer.scala:57:16
        fb_uop_ram_27_ctrl_op_fcn = _RANDOM[9'h164][7:4];	// fetch-buffer.scala:57:16
        fb_uop_ram_27_ctrl_fcn_dw = _RANDOM[9'h164][8];	// fetch-buffer.scala:57:16
        fb_uop_ram_27_ctrl_csr_cmd = _RANDOM[9'h164][11:9];	// fetch-buffer.scala:57:16
        fb_uop_ram_27_ctrl_is_load = _RANDOM[9'h164][12];	// fetch-buffer.scala:57:16
        fb_uop_ram_27_ctrl_is_sta = _RANDOM[9'h164][13];	// fetch-buffer.scala:57:16
        fb_uop_ram_27_ctrl_is_std = _RANDOM[9'h164][14];	// fetch-buffer.scala:57:16
        fb_uop_ram_27_iw_state = _RANDOM[9'h164][16:15];	// fetch-buffer.scala:57:16
        fb_uop_ram_27_iw_p1_poisoned = _RANDOM[9'h164][17];	// fetch-buffer.scala:57:16
        fb_uop_ram_27_iw_p2_poisoned = _RANDOM[9'h164][18];	// fetch-buffer.scala:57:16
        fb_uop_ram_27_is_sfb = _RANDOM[9'h164][22];	// fetch-buffer.scala:57:16
        fb_uop_ram_27_ftq_idx = _RANDOM[9'h165][21:16];	// fetch-buffer.scala:57:16
        fb_uop_ram_27_edge_inst = _RANDOM[9'h165][22];	// fetch-buffer.scala:57:16
        fb_uop_ram_27_pc_lob = _RANDOM[9'h165][28:23];	// fetch-buffer.scala:57:16
        fb_uop_ram_27_taken = _RANDOM[9'h165][29];	// fetch-buffer.scala:57:16
        fb_uop_ram_27_csr_addr = _RANDOM[9'h166][29:18];	// fetch-buffer.scala:57:16
        fb_uop_ram_27_rxq_idx = _RANDOM[9'h167][16:15];	// fetch-buffer.scala:57:16
        fb_uop_ram_27_xcpt_pf_if = _RANDOM[9'h16C][19];	// fetch-buffer.scala:57:16
        fb_uop_ram_27_xcpt_ae_if = _RANDOM[9'h16C][20];	// fetch-buffer.scala:57:16
        fb_uop_ram_27_xcpt_ma_if = _RANDOM[9'h16C][21];	// fetch-buffer.scala:57:16
        fb_uop_ram_27_bp_debug_if = _RANDOM[9'h16C][22];	// fetch-buffer.scala:57:16
        fb_uop_ram_27_bp_xcpt_if = _RANDOM[9'h16C][23];	// fetch-buffer.scala:57:16
        fb_uop_ram_27_debug_fsrc = _RANDOM[9'h16C][25:24];	// fetch-buffer.scala:57:16
        fb_uop_ram_27_debug_tsrc = _RANDOM[9'h16C][27:26];	// fetch-buffer.scala:57:16
        fb_uop_ram_28_inst = {_RANDOM[9'h16D][31:3], _RANDOM[9'h16E][2:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_28_debug_inst = {_RANDOM[9'h16E][31:3], _RANDOM[9'h16F][2:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_28_is_rvc = _RANDOM[9'h16F][3];	// fetch-buffer.scala:57:16
        fb_uop_ram_28_debug_pc = {_RANDOM[9'h16F][31:4], _RANDOM[9'h170][11:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_28_ctrl_br_type = _RANDOM[9'h170][28:25];	// fetch-buffer.scala:57:16
        fb_uop_ram_28_ctrl_op1_sel = _RANDOM[9'h170][30:29];	// fetch-buffer.scala:57:16
        fb_uop_ram_28_ctrl_op2_sel = {_RANDOM[9'h170][31], _RANDOM[9'h171][1:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_28_ctrl_imm_sel = _RANDOM[9'h171][4:2];	// fetch-buffer.scala:57:16
        fb_uop_ram_28_ctrl_op_fcn = _RANDOM[9'h171][8:5];	// fetch-buffer.scala:57:16
        fb_uop_ram_28_ctrl_fcn_dw = _RANDOM[9'h171][9];	// fetch-buffer.scala:57:16
        fb_uop_ram_28_ctrl_csr_cmd = _RANDOM[9'h171][12:10];	// fetch-buffer.scala:57:16
        fb_uop_ram_28_ctrl_is_load = _RANDOM[9'h171][13];	// fetch-buffer.scala:57:16
        fb_uop_ram_28_ctrl_is_sta = _RANDOM[9'h171][14];	// fetch-buffer.scala:57:16
        fb_uop_ram_28_ctrl_is_std = _RANDOM[9'h171][15];	// fetch-buffer.scala:57:16
        fb_uop_ram_28_iw_state = _RANDOM[9'h171][17:16];	// fetch-buffer.scala:57:16
        fb_uop_ram_28_iw_p1_poisoned = _RANDOM[9'h171][18];	// fetch-buffer.scala:57:16
        fb_uop_ram_28_iw_p2_poisoned = _RANDOM[9'h171][19];	// fetch-buffer.scala:57:16
        fb_uop_ram_28_is_sfb = _RANDOM[9'h171][23];	// fetch-buffer.scala:57:16
        fb_uop_ram_28_ftq_idx = _RANDOM[9'h172][22:17];	// fetch-buffer.scala:57:16
        fb_uop_ram_28_edge_inst = _RANDOM[9'h172][23];	// fetch-buffer.scala:57:16
        fb_uop_ram_28_pc_lob = _RANDOM[9'h172][29:24];	// fetch-buffer.scala:57:16
        fb_uop_ram_28_taken = _RANDOM[9'h172][30];	// fetch-buffer.scala:57:16
        fb_uop_ram_28_csr_addr = _RANDOM[9'h173][30:19];	// fetch-buffer.scala:57:16
        fb_uop_ram_28_rxq_idx = _RANDOM[9'h174][17:16];	// fetch-buffer.scala:57:16
        fb_uop_ram_28_xcpt_pf_if = _RANDOM[9'h179][20];	// fetch-buffer.scala:57:16
        fb_uop_ram_28_xcpt_ae_if = _RANDOM[9'h179][21];	// fetch-buffer.scala:57:16
        fb_uop_ram_28_xcpt_ma_if = _RANDOM[9'h179][22];	// fetch-buffer.scala:57:16
        fb_uop_ram_28_bp_debug_if = _RANDOM[9'h179][23];	// fetch-buffer.scala:57:16
        fb_uop_ram_28_bp_xcpt_if = _RANDOM[9'h179][24];	// fetch-buffer.scala:57:16
        fb_uop_ram_28_debug_fsrc = _RANDOM[9'h179][26:25];	// fetch-buffer.scala:57:16
        fb_uop_ram_28_debug_tsrc = _RANDOM[9'h179][28:27];	// fetch-buffer.scala:57:16
        fb_uop_ram_29_inst = {_RANDOM[9'h17A][31:4], _RANDOM[9'h17B][3:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_29_debug_inst = {_RANDOM[9'h17B][31:4], _RANDOM[9'h17C][3:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_29_is_rvc = _RANDOM[9'h17C][4];	// fetch-buffer.scala:57:16
        fb_uop_ram_29_debug_pc = {_RANDOM[9'h17C][31:5], _RANDOM[9'h17D][12:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_29_ctrl_br_type = _RANDOM[9'h17D][29:26];	// fetch-buffer.scala:57:16
        fb_uop_ram_29_ctrl_op1_sel = _RANDOM[9'h17D][31:30];	// fetch-buffer.scala:57:16
        fb_uop_ram_29_ctrl_op2_sel = _RANDOM[9'h17E][2:0];	// fetch-buffer.scala:57:16
        fb_uop_ram_29_ctrl_imm_sel = _RANDOM[9'h17E][5:3];	// fetch-buffer.scala:57:16
        fb_uop_ram_29_ctrl_op_fcn = _RANDOM[9'h17E][9:6];	// fetch-buffer.scala:57:16
        fb_uop_ram_29_ctrl_fcn_dw = _RANDOM[9'h17E][10];	// fetch-buffer.scala:57:16
        fb_uop_ram_29_ctrl_csr_cmd = _RANDOM[9'h17E][13:11];	// fetch-buffer.scala:57:16
        fb_uop_ram_29_ctrl_is_load = _RANDOM[9'h17E][14];	// fetch-buffer.scala:57:16
        fb_uop_ram_29_ctrl_is_sta = _RANDOM[9'h17E][15];	// fetch-buffer.scala:57:16
        fb_uop_ram_29_ctrl_is_std = _RANDOM[9'h17E][16];	// fetch-buffer.scala:57:16
        fb_uop_ram_29_iw_state = _RANDOM[9'h17E][18:17];	// fetch-buffer.scala:57:16
        fb_uop_ram_29_iw_p1_poisoned = _RANDOM[9'h17E][19];	// fetch-buffer.scala:57:16
        fb_uop_ram_29_iw_p2_poisoned = _RANDOM[9'h17E][20];	// fetch-buffer.scala:57:16
        fb_uop_ram_29_is_sfb = _RANDOM[9'h17E][24];	// fetch-buffer.scala:57:16
        fb_uop_ram_29_ftq_idx = _RANDOM[9'h17F][23:18];	// fetch-buffer.scala:57:16
        fb_uop_ram_29_edge_inst = _RANDOM[9'h17F][24];	// fetch-buffer.scala:57:16
        fb_uop_ram_29_pc_lob = _RANDOM[9'h17F][30:25];	// fetch-buffer.scala:57:16
        fb_uop_ram_29_taken = _RANDOM[9'h17F][31];	// fetch-buffer.scala:57:16
        fb_uop_ram_29_csr_addr = _RANDOM[9'h180][31:20];	// fetch-buffer.scala:57:16
        fb_uop_ram_29_rxq_idx = _RANDOM[9'h181][18:17];	// fetch-buffer.scala:57:16
        fb_uop_ram_29_xcpt_pf_if = _RANDOM[9'h186][21];	// fetch-buffer.scala:57:16
        fb_uop_ram_29_xcpt_ae_if = _RANDOM[9'h186][22];	// fetch-buffer.scala:57:16
        fb_uop_ram_29_xcpt_ma_if = _RANDOM[9'h186][23];	// fetch-buffer.scala:57:16
        fb_uop_ram_29_bp_debug_if = _RANDOM[9'h186][24];	// fetch-buffer.scala:57:16
        fb_uop_ram_29_bp_xcpt_if = _RANDOM[9'h186][25];	// fetch-buffer.scala:57:16
        fb_uop_ram_29_debug_fsrc = _RANDOM[9'h186][27:26];	// fetch-buffer.scala:57:16
        fb_uop_ram_29_debug_tsrc = _RANDOM[9'h186][29:28];	// fetch-buffer.scala:57:16
        fb_uop_ram_30_inst = {_RANDOM[9'h187][31:5], _RANDOM[9'h188][4:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_30_debug_inst = {_RANDOM[9'h188][31:5], _RANDOM[9'h189][4:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_30_is_rvc = _RANDOM[9'h189][5];	// fetch-buffer.scala:57:16
        fb_uop_ram_30_debug_pc = {_RANDOM[9'h189][31:6], _RANDOM[9'h18A][13:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_30_ctrl_br_type = _RANDOM[9'h18A][30:27];	// fetch-buffer.scala:57:16
        fb_uop_ram_30_ctrl_op1_sel = {_RANDOM[9'h18A][31], _RANDOM[9'h18B][0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_30_ctrl_op2_sel = _RANDOM[9'h18B][3:1];	// fetch-buffer.scala:57:16
        fb_uop_ram_30_ctrl_imm_sel = _RANDOM[9'h18B][6:4];	// fetch-buffer.scala:57:16
        fb_uop_ram_30_ctrl_op_fcn = _RANDOM[9'h18B][10:7];	// fetch-buffer.scala:57:16
        fb_uop_ram_30_ctrl_fcn_dw = _RANDOM[9'h18B][11];	// fetch-buffer.scala:57:16
        fb_uop_ram_30_ctrl_csr_cmd = _RANDOM[9'h18B][14:12];	// fetch-buffer.scala:57:16
        fb_uop_ram_30_ctrl_is_load = _RANDOM[9'h18B][15];	// fetch-buffer.scala:57:16
        fb_uop_ram_30_ctrl_is_sta = _RANDOM[9'h18B][16];	// fetch-buffer.scala:57:16
        fb_uop_ram_30_ctrl_is_std = _RANDOM[9'h18B][17];	// fetch-buffer.scala:57:16
        fb_uop_ram_30_iw_state = _RANDOM[9'h18B][19:18];	// fetch-buffer.scala:57:16
        fb_uop_ram_30_iw_p1_poisoned = _RANDOM[9'h18B][20];	// fetch-buffer.scala:57:16
        fb_uop_ram_30_iw_p2_poisoned = _RANDOM[9'h18B][21];	// fetch-buffer.scala:57:16
        fb_uop_ram_30_is_sfb = _RANDOM[9'h18B][25];	// fetch-buffer.scala:57:16
        fb_uop_ram_30_ftq_idx = _RANDOM[9'h18C][24:19];	// fetch-buffer.scala:57:16
        fb_uop_ram_30_edge_inst = _RANDOM[9'h18C][25];	// fetch-buffer.scala:57:16
        fb_uop_ram_30_pc_lob = _RANDOM[9'h18C][31:26];	// fetch-buffer.scala:57:16
        fb_uop_ram_30_taken = _RANDOM[9'h18D][0];	// fetch-buffer.scala:57:16
        fb_uop_ram_30_csr_addr = {_RANDOM[9'h18D][31:21], _RANDOM[9'h18E][0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_30_rxq_idx = _RANDOM[9'h18E][19:18];	// fetch-buffer.scala:57:16
        fb_uop_ram_30_xcpt_pf_if = _RANDOM[9'h193][22];	// fetch-buffer.scala:57:16
        fb_uop_ram_30_xcpt_ae_if = _RANDOM[9'h193][23];	// fetch-buffer.scala:57:16
        fb_uop_ram_30_xcpt_ma_if = _RANDOM[9'h193][24];	// fetch-buffer.scala:57:16
        fb_uop_ram_30_bp_debug_if = _RANDOM[9'h193][25];	// fetch-buffer.scala:57:16
        fb_uop_ram_30_bp_xcpt_if = _RANDOM[9'h193][26];	// fetch-buffer.scala:57:16
        fb_uop_ram_30_debug_fsrc = _RANDOM[9'h193][28:27];	// fetch-buffer.scala:57:16
        fb_uop_ram_30_debug_tsrc = _RANDOM[9'h193][30:29];	// fetch-buffer.scala:57:16
        fb_uop_ram_31_inst = {_RANDOM[9'h194][31:6], _RANDOM[9'h195][5:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_31_debug_inst = {_RANDOM[9'h195][31:6], _RANDOM[9'h196][5:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_31_is_rvc = _RANDOM[9'h196][6];	// fetch-buffer.scala:57:16
        fb_uop_ram_31_debug_pc = {_RANDOM[9'h196][31:7], _RANDOM[9'h197][14:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_31_ctrl_br_type = _RANDOM[9'h197][31:28];	// fetch-buffer.scala:57:16
        fb_uop_ram_31_ctrl_op1_sel = _RANDOM[9'h198][1:0];	// fetch-buffer.scala:57:16
        fb_uop_ram_31_ctrl_op2_sel = _RANDOM[9'h198][4:2];	// fetch-buffer.scala:57:16
        fb_uop_ram_31_ctrl_imm_sel = _RANDOM[9'h198][7:5];	// fetch-buffer.scala:57:16
        fb_uop_ram_31_ctrl_op_fcn = _RANDOM[9'h198][11:8];	// fetch-buffer.scala:57:16
        fb_uop_ram_31_ctrl_fcn_dw = _RANDOM[9'h198][12];	// fetch-buffer.scala:57:16
        fb_uop_ram_31_ctrl_csr_cmd = _RANDOM[9'h198][15:13];	// fetch-buffer.scala:57:16
        fb_uop_ram_31_ctrl_is_load = _RANDOM[9'h198][16];	// fetch-buffer.scala:57:16
        fb_uop_ram_31_ctrl_is_sta = _RANDOM[9'h198][17];	// fetch-buffer.scala:57:16
        fb_uop_ram_31_ctrl_is_std = _RANDOM[9'h198][18];	// fetch-buffer.scala:57:16
        fb_uop_ram_31_iw_state = _RANDOM[9'h198][20:19];	// fetch-buffer.scala:57:16
        fb_uop_ram_31_iw_p1_poisoned = _RANDOM[9'h198][21];	// fetch-buffer.scala:57:16
        fb_uop_ram_31_iw_p2_poisoned = _RANDOM[9'h198][22];	// fetch-buffer.scala:57:16
        fb_uop_ram_31_is_sfb = _RANDOM[9'h198][26];	// fetch-buffer.scala:57:16
        fb_uop_ram_31_ftq_idx = _RANDOM[9'h199][25:20];	// fetch-buffer.scala:57:16
        fb_uop_ram_31_edge_inst = _RANDOM[9'h199][26];	// fetch-buffer.scala:57:16
        fb_uop_ram_31_pc_lob = {_RANDOM[9'h199][31:27], _RANDOM[9'h19A][0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_31_taken = _RANDOM[9'h19A][1];	// fetch-buffer.scala:57:16
        fb_uop_ram_31_csr_addr = {_RANDOM[9'h19A][31:22], _RANDOM[9'h19B][1:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_31_rxq_idx = _RANDOM[9'h19B][20:19];	// fetch-buffer.scala:57:16
        fb_uop_ram_31_xcpt_pf_if = _RANDOM[9'h1A0][23];	// fetch-buffer.scala:57:16
        fb_uop_ram_31_xcpt_ae_if = _RANDOM[9'h1A0][24];	// fetch-buffer.scala:57:16
        fb_uop_ram_31_xcpt_ma_if = _RANDOM[9'h1A0][25];	// fetch-buffer.scala:57:16
        fb_uop_ram_31_bp_debug_if = _RANDOM[9'h1A0][26];	// fetch-buffer.scala:57:16
        fb_uop_ram_31_bp_xcpt_if = _RANDOM[9'h1A0][27];	// fetch-buffer.scala:57:16
        fb_uop_ram_31_debug_fsrc = _RANDOM[9'h1A0][29:28];	// fetch-buffer.scala:57:16
        fb_uop_ram_31_debug_tsrc = _RANDOM[9'h1A0][31:30];	// fetch-buffer.scala:57:16
        head = _RANDOM[9'h1A1][7:0];	// fetch-buffer.scala:61:21
        tail = {_RANDOM[9'h1A1][31:8], _RANDOM[9'h1A2][7:0]};	// fetch-buffer.scala:61:21, :62:21
        maybe_full = _RANDOM[9'h1A2][8];	// fetch-buffer.scala:62:21, :64:27
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_enq_ready = ~_do_enq_T_1;	// fetch-buffer.scala:82:{16,40}
  assign io_deq_valid = _deq_valids_T_10 != 4'hF;	// fetch-buffer.scala:161:21, :170:38, util.scala:384:54
  assign io_deq_bits_uops_0_valid = ~reset & _deq_valids_T_11[0];	// fetch-buffer.scala:161:{21,53}, :168:72, :195:23, :196:41
  assign io_deq_bits_uops_0_bits_inst =
    (head[0] ? fb_uop_ram_0_inst : 32'h0) | (head[1] ? fb_uop_ram_4_inst : 32'h0)
    | (head[2] ? fb_uop_ram_8_inst : 32'h0) | (head[3] ? fb_uop_ram_12_inst : 32'h0)
    | (head[4] ? fb_uop_ram_16_inst : 32'h0) | (head[5] ? fb_uop_ram_20_inst : 32'h0)
    | (head[6] ? fb_uop_ram_24_inst : 32'h0) | (head[7] ? fb_uop_ram_28_inst : 32'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_0_bits_debug_inst =
    (head[0] ? fb_uop_ram_0_debug_inst : 32'h0)
    | (head[1] ? fb_uop_ram_4_debug_inst : 32'h0)
    | (head[2] ? fb_uop_ram_8_debug_inst : 32'h0)
    | (head[3] ? fb_uop_ram_12_debug_inst : 32'h0)
    | (head[4] ? fb_uop_ram_16_debug_inst : 32'h0)
    | (head[5] ? fb_uop_ram_20_debug_inst : 32'h0)
    | (head[6] ? fb_uop_ram_24_debug_inst : 32'h0)
    | (head[7] ? fb_uop_ram_28_debug_inst : 32'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_0_bits_is_rvc =
    head[0] & fb_uop_ram_0_is_rvc | head[1] & fb_uop_ram_4_is_rvc | head[2]
    & fb_uop_ram_8_is_rvc | head[3] & fb_uop_ram_12_is_rvc | head[4]
    & fb_uop_ram_16_is_rvc | head[5] & fb_uop_ram_20_is_rvc | head[6]
    & fb_uop_ram_24_is_rvc | head[7] & fb_uop_ram_28_is_rvc;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_0_bits_debug_pc =
    (head[0] ? fb_uop_ram_0_debug_pc : 40'h0) | (head[1] ? fb_uop_ram_4_debug_pc : 40'h0)
    | (head[2] ? fb_uop_ram_8_debug_pc : 40'h0)
    | (head[3] ? fb_uop_ram_12_debug_pc : 40'h0)
    | (head[4] ? fb_uop_ram_16_debug_pc : 40'h0)
    | (head[5] ? fb_uop_ram_20_debug_pc : 40'h0)
    | (head[6] ? fb_uop_ram_24_debug_pc : 40'h0)
    | (head[7] ? fb_uop_ram_28_debug_pc : 40'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_0_bits_ctrl_br_type =
    (head[0] ? fb_uop_ram_0_ctrl_br_type : 4'h0)
    | (head[1] ? fb_uop_ram_4_ctrl_br_type : 4'h0)
    | (head[2] ? fb_uop_ram_8_ctrl_br_type : 4'h0)
    | (head[3] ? fb_uop_ram_12_ctrl_br_type : 4'h0)
    | (head[4] ? fb_uop_ram_16_ctrl_br_type : 4'h0)
    | (head[5] ? fb_uop_ram_20_ctrl_br_type : 4'h0)
    | (head[6] ? fb_uop_ram_24_ctrl_br_type : 4'h0)
    | (head[7] ? fb_uop_ram_28_ctrl_br_type : 4'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_0_bits_ctrl_op1_sel =
    (head[0] ? fb_uop_ram_0_ctrl_op1_sel : 2'h0)
    | (head[1] ? fb_uop_ram_4_ctrl_op1_sel : 2'h0)
    | (head[2] ? fb_uop_ram_8_ctrl_op1_sel : 2'h0)
    | (head[3] ? fb_uop_ram_12_ctrl_op1_sel : 2'h0)
    | (head[4] ? fb_uop_ram_16_ctrl_op1_sel : 2'h0)
    | (head[5] ? fb_uop_ram_20_ctrl_op1_sel : 2'h0)
    | (head[6] ? fb_uop_ram_24_ctrl_op1_sel : 2'h0)
    | (head[7] ? fb_uop_ram_28_ctrl_op1_sel : 2'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_0_bits_ctrl_op2_sel =
    (head[0] ? fb_uop_ram_0_ctrl_op2_sel : 3'h0)
    | (head[1] ? fb_uop_ram_4_ctrl_op2_sel : 3'h0)
    | (head[2] ? fb_uop_ram_8_ctrl_op2_sel : 3'h0)
    | (head[3] ? fb_uop_ram_12_ctrl_op2_sel : 3'h0)
    | (head[4] ? fb_uop_ram_16_ctrl_op2_sel : 3'h0)
    | (head[5] ? fb_uop_ram_20_ctrl_op2_sel : 3'h0)
    | (head[6] ? fb_uop_ram_24_ctrl_op2_sel : 3'h0)
    | (head[7] ? fb_uop_ram_28_ctrl_op2_sel : 3'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_0_bits_ctrl_imm_sel =
    (head[0] ? fb_uop_ram_0_ctrl_imm_sel : 3'h0)
    | (head[1] ? fb_uop_ram_4_ctrl_imm_sel : 3'h0)
    | (head[2] ? fb_uop_ram_8_ctrl_imm_sel : 3'h0)
    | (head[3] ? fb_uop_ram_12_ctrl_imm_sel : 3'h0)
    | (head[4] ? fb_uop_ram_16_ctrl_imm_sel : 3'h0)
    | (head[5] ? fb_uop_ram_20_ctrl_imm_sel : 3'h0)
    | (head[6] ? fb_uop_ram_24_ctrl_imm_sel : 3'h0)
    | (head[7] ? fb_uop_ram_28_ctrl_imm_sel : 3'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_0_bits_ctrl_op_fcn =
    (head[0] ? fb_uop_ram_0_ctrl_op_fcn : 4'h0)
    | (head[1] ? fb_uop_ram_4_ctrl_op_fcn : 4'h0)
    | (head[2] ? fb_uop_ram_8_ctrl_op_fcn : 4'h0)
    | (head[3] ? fb_uop_ram_12_ctrl_op_fcn : 4'h0)
    | (head[4] ? fb_uop_ram_16_ctrl_op_fcn : 4'h0)
    | (head[5] ? fb_uop_ram_20_ctrl_op_fcn : 4'h0)
    | (head[6] ? fb_uop_ram_24_ctrl_op_fcn : 4'h0)
    | (head[7] ? fb_uop_ram_28_ctrl_op_fcn : 4'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_0_bits_ctrl_fcn_dw =
    head[0] & fb_uop_ram_0_ctrl_fcn_dw | head[1] & fb_uop_ram_4_ctrl_fcn_dw | head[2]
    & fb_uop_ram_8_ctrl_fcn_dw | head[3] & fb_uop_ram_12_ctrl_fcn_dw | head[4]
    & fb_uop_ram_16_ctrl_fcn_dw | head[5] & fb_uop_ram_20_ctrl_fcn_dw | head[6]
    & fb_uop_ram_24_ctrl_fcn_dw | head[7] & fb_uop_ram_28_ctrl_fcn_dw;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_0_bits_ctrl_csr_cmd =
    (head[0] ? fb_uop_ram_0_ctrl_csr_cmd : 3'h0)
    | (head[1] ? fb_uop_ram_4_ctrl_csr_cmd : 3'h0)
    | (head[2] ? fb_uop_ram_8_ctrl_csr_cmd : 3'h0)
    | (head[3] ? fb_uop_ram_12_ctrl_csr_cmd : 3'h0)
    | (head[4] ? fb_uop_ram_16_ctrl_csr_cmd : 3'h0)
    | (head[5] ? fb_uop_ram_20_ctrl_csr_cmd : 3'h0)
    | (head[6] ? fb_uop_ram_24_ctrl_csr_cmd : 3'h0)
    | (head[7] ? fb_uop_ram_28_ctrl_csr_cmd : 3'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_0_bits_ctrl_is_load =
    head[0] & fb_uop_ram_0_ctrl_is_load | head[1] & fb_uop_ram_4_ctrl_is_load | head[2]
    & fb_uop_ram_8_ctrl_is_load | head[3] & fb_uop_ram_12_ctrl_is_load | head[4]
    & fb_uop_ram_16_ctrl_is_load | head[5] & fb_uop_ram_20_ctrl_is_load | head[6]
    & fb_uop_ram_24_ctrl_is_load | head[7] & fb_uop_ram_28_ctrl_is_load;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_0_bits_ctrl_is_sta =
    head[0] & fb_uop_ram_0_ctrl_is_sta | head[1] & fb_uop_ram_4_ctrl_is_sta | head[2]
    & fb_uop_ram_8_ctrl_is_sta | head[3] & fb_uop_ram_12_ctrl_is_sta | head[4]
    & fb_uop_ram_16_ctrl_is_sta | head[5] & fb_uop_ram_20_ctrl_is_sta | head[6]
    & fb_uop_ram_24_ctrl_is_sta | head[7] & fb_uop_ram_28_ctrl_is_sta;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_0_bits_ctrl_is_std =
    head[0] & fb_uop_ram_0_ctrl_is_std | head[1] & fb_uop_ram_4_ctrl_is_std | head[2]
    & fb_uop_ram_8_ctrl_is_std | head[3] & fb_uop_ram_12_ctrl_is_std | head[4]
    & fb_uop_ram_16_ctrl_is_std | head[5] & fb_uop_ram_20_ctrl_is_std | head[6]
    & fb_uop_ram_24_ctrl_is_std | head[7] & fb_uop_ram_28_ctrl_is_std;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_0_bits_iw_state =
    (head[0] ? fb_uop_ram_0_iw_state : 2'h0) | (head[1] ? fb_uop_ram_4_iw_state : 2'h0)
    | (head[2] ? fb_uop_ram_8_iw_state : 2'h0) | (head[3] ? fb_uop_ram_12_iw_state : 2'h0)
    | (head[4] ? fb_uop_ram_16_iw_state : 2'h0)
    | (head[5] ? fb_uop_ram_20_iw_state : 2'h0)
    | (head[6] ? fb_uop_ram_24_iw_state : 2'h0)
    | (head[7] ? fb_uop_ram_28_iw_state : 2'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_0_bits_iw_p1_poisoned =
    head[0] & fb_uop_ram_0_iw_p1_poisoned | head[1] & fb_uop_ram_4_iw_p1_poisoned
    | head[2] & fb_uop_ram_8_iw_p1_poisoned | head[3] & fb_uop_ram_12_iw_p1_poisoned
    | head[4] & fb_uop_ram_16_iw_p1_poisoned | head[5] & fb_uop_ram_20_iw_p1_poisoned
    | head[6] & fb_uop_ram_24_iw_p1_poisoned | head[7] & fb_uop_ram_28_iw_p1_poisoned;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_0_bits_iw_p2_poisoned =
    head[0] & fb_uop_ram_0_iw_p2_poisoned | head[1] & fb_uop_ram_4_iw_p2_poisoned
    | head[2] & fb_uop_ram_8_iw_p2_poisoned | head[3] & fb_uop_ram_12_iw_p2_poisoned
    | head[4] & fb_uop_ram_16_iw_p2_poisoned | head[5] & fb_uop_ram_20_iw_p2_poisoned
    | head[6] & fb_uop_ram_24_iw_p2_poisoned | head[7] & fb_uop_ram_28_iw_p2_poisoned;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_0_bits_is_sfb =
    head[0] & fb_uop_ram_0_is_sfb | head[1] & fb_uop_ram_4_is_sfb | head[2]
    & fb_uop_ram_8_is_sfb | head[3] & fb_uop_ram_12_is_sfb | head[4]
    & fb_uop_ram_16_is_sfb | head[5] & fb_uop_ram_20_is_sfb | head[6]
    & fb_uop_ram_24_is_sfb | head[7] & fb_uop_ram_28_is_sfb;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_0_bits_ftq_idx =
    (head[0] ? fb_uop_ram_0_ftq_idx : 6'h0) | (head[1] ? fb_uop_ram_4_ftq_idx : 6'h0)
    | (head[2] ? fb_uop_ram_8_ftq_idx : 6'h0) | (head[3] ? fb_uop_ram_12_ftq_idx : 6'h0)
    | (head[4] ? fb_uop_ram_16_ftq_idx : 6'h0) | (head[5] ? fb_uop_ram_20_ftq_idx : 6'h0)
    | (head[6] ? fb_uop_ram_24_ftq_idx : 6'h0) | (head[7] ? fb_uop_ram_28_ftq_idx : 6'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_0_bits_edge_inst =
    head[0] & fb_uop_ram_0_edge_inst | head[1] & fb_uop_ram_4_edge_inst | head[2]
    & fb_uop_ram_8_edge_inst | head[3] & fb_uop_ram_12_edge_inst | head[4]
    & fb_uop_ram_16_edge_inst | head[5] & fb_uop_ram_20_edge_inst | head[6]
    & fb_uop_ram_24_edge_inst | head[7] & fb_uop_ram_28_edge_inst;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_0_bits_pc_lob =
    (head[0] ? fb_uop_ram_0_pc_lob : 6'h0) | (head[1] ? fb_uop_ram_4_pc_lob : 6'h0)
    | (head[2] ? fb_uop_ram_8_pc_lob : 6'h0) | (head[3] ? fb_uop_ram_12_pc_lob : 6'h0)
    | (head[4] ? fb_uop_ram_16_pc_lob : 6'h0) | (head[5] ? fb_uop_ram_20_pc_lob : 6'h0)
    | (head[6] ? fb_uop_ram_24_pc_lob : 6'h0) | (head[7] ? fb_uop_ram_28_pc_lob : 6'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_0_bits_taken =
    head[0] & fb_uop_ram_0_taken | head[1] & fb_uop_ram_4_taken | head[2]
    & fb_uop_ram_8_taken | head[3] & fb_uop_ram_12_taken | head[4] & fb_uop_ram_16_taken
    | head[5] & fb_uop_ram_20_taken | head[6] & fb_uop_ram_24_taken | head[7]
    & fb_uop_ram_28_taken;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_0_bits_csr_addr =
    (head[0] ? fb_uop_ram_0_csr_addr : 12'h0) | (head[1] ? fb_uop_ram_4_csr_addr : 12'h0)
    | (head[2] ? fb_uop_ram_8_csr_addr : 12'h0)
    | (head[3] ? fb_uop_ram_12_csr_addr : 12'h0)
    | (head[4] ? fb_uop_ram_16_csr_addr : 12'h0)
    | (head[5] ? fb_uop_ram_20_csr_addr : 12'h0)
    | (head[6] ? fb_uop_ram_24_csr_addr : 12'h0)
    | (head[7] ? fb_uop_ram_28_csr_addr : 12'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_0_bits_rxq_idx =
    (head[0] ? fb_uop_ram_0_rxq_idx : 2'h0) | (head[1] ? fb_uop_ram_4_rxq_idx : 2'h0)
    | (head[2] ? fb_uop_ram_8_rxq_idx : 2'h0) | (head[3] ? fb_uop_ram_12_rxq_idx : 2'h0)
    | (head[4] ? fb_uop_ram_16_rxq_idx : 2'h0) | (head[5] ? fb_uop_ram_20_rxq_idx : 2'h0)
    | (head[6] ? fb_uop_ram_24_rxq_idx : 2'h0) | (head[7] ? fb_uop_ram_28_rxq_idx : 2'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_0_bits_xcpt_pf_if =
    head[0] & fb_uop_ram_0_xcpt_pf_if | head[1] & fb_uop_ram_4_xcpt_pf_if | head[2]
    & fb_uop_ram_8_xcpt_pf_if | head[3] & fb_uop_ram_12_xcpt_pf_if | head[4]
    & fb_uop_ram_16_xcpt_pf_if | head[5] & fb_uop_ram_20_xcpt_pf_if | head[6]
    & fb_uop_ram_24_xcpt_pf_if | head[7] & fb_uop_ram_28_xcpt_pf_if;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_0_bits_xcpt_ae_if =
    head[0] & fb_uop_ram_0_xcpt_ae_if | head[1] & fb_uop_ram_4_xcpt_ae_if | head[2]
    & fb_uop_ram_8_xcpt_ae_if | head[3] & fb_uop_ram_12_xcpt_ae_if | head[4]
    & fb_uop_ram_16_xcpt_ae_if | head[5] & fb_uop_ram_20_xcpt_ae_if | head[6]
    & fb_uop_ram_24_xcpt_ae_if | head[7] & fb_uop_ram_28_xcpt_ae_if;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_0_bits_xcpt_ma_if =
    head[0] & fb_uop_ram_0_xcpt_ma_if | head[1] & fb_uop_ram_4_xcpt_ma_if | head[2]
    & fb_uop_ram_8_xcpt_ma_if | head[3] & fb_uop_ram_12_xcpt_ma_if | head[4]
    & fb_uop_ram_16_xcpt_ma_if | head[5] & fb_uop_ram_20_xcpt_ma_if | head[6]
    & fb_uop_ram_24_xcpt_ma_if | head[7] & fb_uop_ram_28_xcpt_ma_if;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_0_bits_bp_debug_if =
    head[0] & fb_uop_ram_0_bp_debug_if | head[1] & fb_uop_ram_4_bp_debug_if | head[2]
    & fb_uop_ram_8_bp_debug_if | head[3] & fb_uop_ram_12_bp_debug_if | head[4]
    & fb_uop_ram_16_bp_debug_if | head[5] & fb_uop_ram_20_bp_debug_if | head[6]
    & fb_uop_ram_24_bp_debug_if | head[7] & fb_uop_ram_28_bp_debug_if;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_0_bits_bp_xcpt_if =
    head[0] & fb_uop_ram_0_bp_xcpt_if | head[1] & fb_uop_ram_4_bp_xcpt_if | head[2]
    & fb_uop_ram_8_bp_xcpt_if | head[3] & fb_uop_ram_12_bp_xcpt_if | head[4]
    & fb_uop_ram_16_bp_xcpt_if | head[5] & fb_uop_ram_20_bp_xcpt_if | head[6]
    & fb_uop_ram_24_bp_xcpt_if | head[7] & fb_uop_ram_28_bp_xcpt_if;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_0_bits_debug_fsrc =
    (head[0] ? fb_uop_ram_0_debug_fsrc : 2'h0)
    | (head[1] ? fb_uop_ram_4_debug_fsrc : 2'h0)
    | (head[2] ? fb_uop_ram_8_debug_fsrc : 2'h0)
    | (head[3] ? fb_uop_ram_12_debug_fsrc : 2'h0)
    | (head[4] ? fb_uop_ram_16_debug_fsrc : 2'h0)
    | (head[5] ? fb_uop_ram_20_debug_fsrc : 2'h0)
    | (head[6] ? fb_uop_ram_24_debug_fsrc : 2'h0)
    | (head[7] ? fb_uop_ram_28_debug_fsrc : 2'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_0_bits_debug_tsrc =
    (head[0] ? fb_uop_ram_0_debug_tsrc : 2'h0)
    | (head[1] ? fb_uop_ram_4_debug_tsrc : 2'h0)
    | (head[2] ? fb_uop_ram_8_debug_tsrc : 2'h0)
    | (head[3] ? fb_uop_ram_12_debug_tsrc : 2'h0)
    | (head[4] ? fb_uop_ram_16_debug_tsrc : 2'h0)
    | (head[5] ? fb_uop_ram_20_debug_tsrc : 2'h0)
    | (head[6] ? fb_uop_ram_24_debug_tsrc : 2'h0)
    | (head[7] ? fb_uop_ram_28_debug_tsrc : 2'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_1_valid = ~reset & _deq_valids_T_11[1];	// fetch-buffer.scala:161:{21,53}, :168:72, :195:23, :196:41
  assign io_deq_bits_uops_1_bits_inst =
    (head[0] ? fb_uop_ram_1_inst : 32'h0) | (head[1] ? fb_uop_ram_5_inst : 32'h0)
    | (head[2] ? fb_uop_ram_9_inst : 32'h0) | (head[3] ? fb_uop_ram_13_inst : 32'h0)
    | (head[4] ? fb_uop_ram_17_inst : 32'h0) | (head[5] ? fb_uop_ram_21_inst : 32'h0)
    | (head[6] ? fb_uop_ram_25_inst : 32'h0) | (head[7] ? fb_uop_ram_29_inst : 32'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_1_bits_debug_inst =
    (head[0] ? fb_uop_ram_1_debug_inst : 32'h0)
    | (head[1] ? fb_uop_ram_5_debug_inst : 32'h0)
    | (head[2] ? fb_uop_ram_9_debug_inst : 32'h0)
    | (head[3] ? fb_uop_ram_13_debug_inst : 32'h0)
    | (head[4] ? fb_uop_ram_17_debug_inst : 32'h0)
    | (head[5] ? fb_uop_ram_21_debug_inst : 32'h0)
    | (head[6] ? fb_uop_ram_25_debug_inst : 32'h0)
    | (head[7] ? fb_uop_ram_29_debug_inst : 32'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_1_bits_is_rvc =
    head[0] & fb_uop_ram_1_is_rvc | head[1] & fb_uop_ram_5_is_rvc | head[2]
    & fb_uop_ram_9_is_rvc | head[3] & fb_uop_ram_13_is_rvc | head[4]
    & fb_uop_ram_17_is_rvc | head[5] & fb_uop_ram_21_is_rvc | head[6]
    & fb_uop_ram_25_is_rvc | head[7] & fb_uop_ram_29_is_rvc;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_1_bits_debug_pc =
    (head[0] ? fb_uop_ram_1_debug_pc : 40'h0) | (head[1] ? fb_uop_ram_5_debug_pc : 40'h0)
    | (head[2] ? fb_uop_ram_9_debug_pc : 40'h0)
    | (head[3] ? fb_uop_ram_13_debug_pc : 40'h0)
    | (head[4] ? fb_uop_ram_17_debug_pc : 40'h0)
    | (head[5] ? fb_uop_ram_21_debug_pc : 40'h0)
    | (head[6] ? fb_uop_ram_25_debug_pc : 40'h0)
    | (head[7] ? fb_uop_ram_29_debug_pc : 40'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_1_bits_ctrl_br_type =
    (head[0] ? fb_uop_ram_1_ctrl_br_type : 4'h0)
    | (head[1] ? fb_uop_ram_5_ctrl_br_type : 4'h0)
    | (head[2] ? fb_uop_ram_9_ctrl_br_type : 4'h0)
    | (head[3] ? fb_uop_ram_13_ctrl_br_type : 4'h0)
    | (head[4] ? fb_uop_ram_17_ctrl_br_type : 4'h0)
    | (head[5] ? fb_uop_ram_21_ctrl_br_type : 4'h0)
    | (head[6] ? fb_uop_ram_25_ctrl_br_type : 4'h0)
    | (head[7] ? fb_uop_ram_29_ctrl_br_type : 4'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_1_bits_ctrl_op1_sel =
    (head[0] ? fb_uop_ram_1_ctrl_op1_sel : 2'h0)
    | (head[1] ? fb_uop_ram_5_ctrl_op1_sel : 2'h0)
    | (head[2] ? fb_uop_ram_9_ctrl_op1_sel : 2'h0)
    | (head[3] ? fb_uop_ram_13_ctrl_op1_sel : 2'h0)
    | (head[4] ? fb_uop_ram_17_ctrl_op1_sel : 2'h0)
    | (head[5] ? fb_uop_ram_21_ctrl_op1_sel : 2'h0)
    | (head[6] ? fb_uop_ram_25_ctrl_op1_sel : 2'h0)
    | (head[7] ? fb_uop_ram_29_ctrl_op1_sel : 2'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_1_bits_ctrl_op2_sel =
    (head[0] ? fb_uop_ram_1_ctrl_op2_sel : 3'h0)
    | (head[1] ? fb_uop_ram_5_ctrl_op2_sel : 3'h0)
    | (head[2] ? fb_uop_ram_9_ctrl_op2_sel : 3'h0)
    | (head[3] ? fb_uop_ram_13_ctrl_op2_sel : 3'h0)
    | (head[4] ? fb_uop_ram_17_ctrl_op2_sel : 3'h0)
    | (head[5] ? fb_uop_ram_21_ctrl_op2_sel : 3'h0)
    | (head[6] ? fb_uop_ram_25_ctrl_op2_sel : 3'h0)
    | (head[7] ? fb_uop_ram_29_ctrl_op2_sel : 3'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_1_bits_ctrl_imm_sel =
    (head[0] ? fb_uop_ram_1_ctrl_imm_sel : 3'h0)
    | (head[1] ? fb_uop_ram_5_ctrl_imm_sel : 3'h0)
    | (head[2] ? fb_uop_ram_9_ctrl_imm_sel : 3'h0)
    | (head[3] ? fb_uop_ram_13_ctrl_imm_sel : 3'h0)
    | (head[4] ? fb_uop_ram_17_ctrl_imm_sel : 3'h0)
    | (head[5] ? fb_uop_ram_21_ctrl_imm_sel : 3'h0)
    | (head[6] ? fb_uop_ram_25_ctrl_imm_sel : 3'h0)
    | (head[7] ? fb_uop_ram_29_ctrl_imm_sel : 3'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_1_bits_ctrl_op_fcn =
    (head[0] ? fb_uop_ram_1_ctrl_op_fcn : 4'h0)
    | (head[1] ? fb_uop_ram_5_ctrl_op_fcn : 4'h0)
    | (head[2] ? fb_uop_ram_9_ctrl_op_fcn : 4'h0)
    | (head[3] ? fb_uop_ram_13_ctrl_op_fcn : 4'h0)
    | (head[4] ? fb_uop_ram_17_ctrl_op_fcn : 4'h0)
    | (head[5] ? fb_uop_ram_21_ctrl_op_fcn : 4'h0)
    | (head[6] ? fb_uop_ram_25_ctrl_op_fcn : 4'h0)
    | (head[7] ? fb_uop_ram_29_ctrl_op_fcn : 4'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_1_bits_ctrl_fcn_dw =
    head[0] & fb_uop_ram_1_ctrl_fcn_dw | head[1] & fb_uop_ram_5_ctrl_fcn_dw | head[2]
    & fb_uop_ram_9_ctrl_fcn_dw | head[3] & fb_uop_ram_13_ctrl_fcn_dw | head[4]
    & fb_uop_ram_17_ctrl_fcn_dw | head[5] & fb_uop_ram_21_ctrl_fcn_dw | head[6]
    & fb_uop_ram_25_ctrl_fcn_dw | head[7] & fb_uop_ram_29_ctrl_fcn_dw;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_1_bits_ctrl_csr_cmd =
    (head[0] ? fb_uop_ram_1_ctrl_csr_cmd : 3'h0)
    | (head[1] ? fb_uop_ram_5_ctrl_csr_cmd : 3'h0)
    | (head[2] ? fb_uop_ram_9_ctrl_csr_cmd : 3'h0)
    | (head[3] ? fb_uop_ram_13_ctrl_csr_cmd : 3'h0)
    | (head[4] ? fb_uop_ram_17_ctrl_csr_cmd : 3'h0)
    | (head[5] ? fb_uop_ram_21_ctrl_csr_cmd : 3'h0)
    | (head[6] ? fb_uop_ram_25_ctrl_csr_cmd : 3'h0)
    | (head[7] ? fb_uop_ram_29_ctrl_csr_cmd : 3'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_1_bits_ctrl_is_load =
    head[0] & fb_uop_ram_1_ctrl_is_load | head[1] & fb_uop_ram_5_ctrl_is_load | head[2]
    & fb_uop_ram_9_ctrl_is_load | head[3] & fb_uop_ram_13_ctrl_is_load | head[4]
    & fb_uop_ram_17_ctrl_is_load | head[5] & fb_uop_ram_21_ctrl_is_load | head[6]
    & fb_uop_ram_25_ctrl_is_load | head[7] & fb_uop_ram_29_ctrl_is_load;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_1_bits_ctrl_is_sta =
    head[0] & fb_uop_ram_1_ctrl_is_sta | head[1] & fb_uop_ram_5_ctrl_is_sta | head[2]
    & fb_uop_ram_9_ctrl_is_sta | head[3] & fb_uop_ram_13_ctrl_is_sta | head[4]
    & fb_uop_ram_17_ctrl_is_sta | head[5] & fb_uop_ram_21_ctrl_is_sta | head[6]
    & fb_uop_ram_25_ctrl_is_sta | head[7] & fb_uop_ram_29_ctrl_is_sta;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_1_bits_ctrl_is_std =
    head[0] & fb_uop_ram_1_ctrl_is_std | head[1] & fb_uop_ram_5_ctrl_is_std | head[2]
    & fb_uop_ram_9_ctrl_is_std | head[3] & fb_uop_ram_13_ctrl_is_std | head[4]
    & fb_uop_ram_17_ctrl_is_std | head[5] & fb_uop_ram_21_ctrl_is_std | head[6]
    & fb_uop_ram_25_ctrl_is_std | head[7] & fb_uop_ram_29_ctrl_is_std;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_1_bits_iw_state =
    (head[0] ? fb_uop_ram_1_iw_state : 2'h0) | (head[1] ? fb_uop_ram_5_iw_state : 2'h0)
    | (head[2] ? fb_uop_ram_9_iw_state : 2'h0) | (head[3] ? fb_uop_ram_13_iw_state : 2'h0)
    | (head[4] ? fb_uop_ram_17_iw_state : 2'h0)
    | (head[5] ? fb_uop_ram_21_iw_state : 2'h0)
    | (head[6] ? fb_uop_ram_25_iw_state : 2'h0)
    | (head[7] ? fb_uop_ram_29_iw_state : 2'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_1_bits_iw_p1_poisoned =
    head[0] & fb_uop_ram_1_iw_p1_poisoned | head[1] & fb_uop_ram_5_iw_p1_poisoned
    | head[2] & fb_uop_ram_9_iw_p1_poisoned | head[3] & fb_uop_ram_13_iw_p1_poisoned
    | head[4] & fb_uop_ram_17_iw_p1_poisoned | head[5] & fb_uop_ram_21_iw_p1_poisoned
    | head[6] & fb_uop_ram_25_iw_p1_poisoned | head[7] & fb_uop_ram_29_iw_p1_poisoned;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_1_bits_iw_p2_poisoned =
    head[0] & fb_uop_ram_1_iw_p2_poisoned | head[1] & fb_uop_ram_5_iw_p2_poisoned
    | head[2] & fb_uop_ram_9_iw_p2_poisoned | head[3] & fb_uop_ram_13_iw_p2_poisoned
    | head[4] & fb_uop_ram_17_iw_p2_poisoned | head[5] & fb_uop_ram_21_iw_p2_poisoned
    | head[6] & fb_uop_ram_25_iw_p2_poisoned | head[7] & fb_uop_ram_29_iw_p2_poisoned;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_1_bits_is_sfb =
    head[0] & fb_uop_ram_1_is_sfb | head[1] & fb_uop_ram_5_is_sfb | head[2]
    & fb_uop_ram_9_is_sfb | head[3] & fb_uop_ram_13_is_sfb | head[4]
    & fb_uop_ram_17_is_sfb | head[5] & fb_uop_ram_21_is_sfb | head[6]
    & fb_uop_ram_25_is_sfb | head[7] & fb_uop_ram_29_is_sfb;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_1_bits_ftq_idx =
    (head[0] ? fb_uop_ram_1_ftq_idx : 6'h0) | (head[1] ? fb_uop_ram_5_ftq_idx : 6'h0)
    | (head[2] ? fb_uop_ram_9_ftq_idx : 6'h0) | (head[3] ? fb_uop_ram_13_ftq_idx : 6'h0)
    | (head[4] ? fb_uop_ram_17_ftq_idx : 6'h0) | (head[5] ? fb_uop_ram_21_ftq_idx : 6'h0)
    | (head[6] ? fb_uop_ram_25_ftq_idx : 6'h0) | (head[7] ? fb_uop_ram_29_ftq_idx : 6'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_1_bits_edge_inst =
    head[0] & fb_uop_ram_1_edge_inst | head[1] & fb_uop_ram_5_edge_inst | head[2]
    & fb_uop_ram_9_edge_inst | head[3] & fb_uop_ram_13_edge_inst | head[4]
    & fb_uop_ram_17_edge_inst | head[5] & fb_uop_ram_21_edge_inst | head[6]
    & fb_uop_ram_25_edge_inst | head[7] & fb_uop_ram_29_edge_inst;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_1_bits_pc_lob =
    (head[0] ? fb_uop_ram_1_pc_lob : 6'h0) | (head[1] ? fb_uop_ram_5_pc_lob : 6'h0)
    | (head[2] ? fb_uop_ram_9_pc_lob : 6'h0) | (head[3] ? fb_uop_ram_13_pc_lob : 6'h0)
    | (head[4] ? fb_uop_ram_17_pc_lob : 6'h0) | (head[5] ? fb_uop_ram_21_pc_lob : 6'h0)
    | (head[6] ? fb_uop_ram_25_pc_lob : 6'h0) | (head[7] ? fb_uop_ram_29_pc_lob : 6'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_1_bits_taken =
    head[0] & fb_uop_ram_1_taken | head[1] & fb_uop_ram_5_taken | head[2]
    & fb_uop_ram_9_taken | head[3] & fb_uop_ram_13_taken | head[4] & fb_uop_ram_17_taken
    | head[5] & fb_uop_ram_21_taken | head[6] & fb_uop_ram_25_taken | head[7]
    & fb_uop_ram_29_taken;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_1_bits_csr_addr =
    (head[0] ? fb_uop_ram_1_csr_addr : 12'h0) | (head[1] ? fb_uop_ram_5_csr_addr : 12'h0)
    | (head[2] ? fb_uop_ram_9_csr_addr : 12'h0)
    | (head[3] ? fb_uop_ram_13_csr_addr : 12'h0)
    | (head[4] ? fb_uop_ram_17_csr_addr : 12'h0)
    | (head[5] ? fb_uop_ram_21_csr_addr : 12'h0)
    | (head[6] ? fb_uop_ram_25_csr_addr : 12'h0)
    | (head[7] ? fb_uop_ram_29_csr_addr : 12'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_1_bits_rxq_idx =
    (head[0] ? fb_uop_ram_1_rxq_idx : 2'h0) | (head[1] ? fb_uop_ram_5_rxq_idx : 2'h0)
    | (head[2] ? fb_uop_ram_9_rxq_idx : 2'h0) | (head[3] ? fb_uop_ram_13_rxq_idx : 2'h0)
    | (head[4] ? fb_uop_ram_17_rxq_idx : 2'h0) | (head[5] ? fb_uop_ram_21_rxq_idx : 2'h0)
    | (head[6] ? fb_uop_ram_25_rxq_idx : 2'h0) | (head[7] ? fb_uop_ram_29_rxq_idx : 2'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_1_bits_xcpt_pf_if =
    head[0] & fb_uop_ram_1_xcpt_pf_if | head[1] & fb_uop_ram_5_xcpt_pf_if | head[2]
    & fb_uop_ram_9_xcpt_pf_if | head[3] & fb_uop_ram_13_xcpt_pf_if | head[4]
    & fb_uop_ram_17_xcpt_pf_if | head[5] & fb_uop_ram_21_xcpt_pf_if | head[6]
    & fb_uop_ram_25_xcpt_pf_if | head[7] & fb_uop_ram_29_xcpt_pf_if;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_1_bits_xcpt_ae_if =
    head[0] & fb_uop_ram_1_xcpt_ae_if | head[1] & fb_uop_ram_5_xcpt_ae_if | head[2]
    & fb_uop_ram_9_xcpt_ae_if | head[3] & fb_uop_ram_13_xcpt_ae_if | head[4]
    & fb_uop_ram_17_xcpt_ae_if | head[5] & fb_uop_ram_21_xcpt_ae_if | head[6]
    & fb_uop_ram_25_xcpt_ae_if | head[7] & fb_uop_ram_29_xcpt_ae_if;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_1_bits_xcpt_ma_if =
    head[0] & fb_uop_ram_1_xcpt_ma_if | head[1] & fb_uop_ram_5_xcpt_ma_if | head[2]
    & fb_uop_ram_9_xcpt_ma_if | head[3] & fb_uop_ram_13_xcpt_ma_if | head[4]
    & fb_uop_ram_17_xcpt_ma_if | head[5] & fb_uop_ram_21_xcpt_ma_if | head[6]
    & fb_uop_ram_25_xcpt_ma_if | head[7] & fb_uop_ram_29_xcpt_ma_if;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_1_bits_bp_debug_if =
    head[0] & fb_uop_ram_1_bp_debug_if | head[1] & fb_uop_ram_5_bp_debug_if | head[2]
    & fb_uop_ram_9_bp_debug_if | head[3] & fb_uop_ram_13_bp_debug_if | head[4]
    & fb_uop_ram_17_bp_debug_if | head[5] & fb_uop_ram_21_bp_debug_if | head[6]
    & fb_uop_ram_25_bp_debug_if | head[7] & fb_uop_ram_29_bp_debug_if;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_1_bits_bp_xcpt_if =
    head[0] & fb_uop_ram_1_bp_xcpt_if | head[1] & fb_uop_ram_5_bp_xcpt_if | head[2]
    & fb_uop_ram_9_bp_xcpt_if | head[3] & fb_uop_ram_13_bp_xcpt_if | head[4]
    & fb_uop_ram_17_bp_xcpt_if | head[5] & fb_uop_ram_21_bp_xcpt_if | head[6]
    & fb_uop_ram_25_bp_xcpt_if | head[7] & fb_uop_ram_29_bp_xcpt_if;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_1_bits_debug_fsrc =
    (head[0] ? fb_uop_ram_1_debug_fsrc : 2'h0)
    | (head[1] ? fb_uop_ram_5_debug_fsrc : 2'h0)
    | (head[2] ? fb_uop_ram_9_debug_fsrc : 2'h0)
    | (head[3] ? fb_uop_ram_13_debug_fsrc : 2'h0)
    | (head[4] ? fb_uop_ram_17_debug_fsrc : 2'h0)
    | (head[5] ? fb_uop_ram_21_debug_fsrc : 2'h0)
    | (head[6] ? fb_uop_ram_25_debug_fsrc : 2'h0)
    | (head[7] ? fb_uop_ram_29_debug_fsrc : 2'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_1_bits_debug_tsrc =
    (head[0] ? fb_uop_ram_1_debug_tsrc : 2'h0)
    | (head[1] ? fb_uop_ram_5_debug_tsrc : 2'h0)
    | (head[2] ? fb_uop_ram_9_debug_tsrc : 2'h0)
    | (head[3] ? fb_uop_ram_13_debug_tsrc : 2'h0)
    | (head[4] ? fb_uop_ram_17_debug_tsrc : 2'h0)
    | (head[5] ? fb_uop_ram_21_debug_tsrc : 2'h0)
    | (head[6] ? fb_uop_ram_25_debug_tsrc : 2'h0)
    | (head[7] ? fb_uop_ram_29_debug_tsrc : 2'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_2_valid = ~reset & _deq_valids_T_11[2];	// fetch-buffer.scala:161:{21,53}, :168:72, :195:23, :196:41
  assign io_deq_bits_uops_2_bits_inst =
    (head[0] ? fb_uop_ram_2_inst : 32'h0) | (head[1] ? fb_uop_ram_6_inst : 32'h0)
    | (head[2] ? fb_uop_ram_10_inst : 32'h0) | (head[3] ? fb_uop_ram_14_inst : 32'h0)
    | (head[4] ? fb_uop_ram_18_inst : 32'h0) | (head[5] ? fb_uop_ram_22_inst : 32'h0)
    | (head[6] ? fb_uop_ram_26_inst : 32'h0) | (head[7] ? fb_uop_ram_30_inst : 32'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_2_bits_debug_inst =
    (head[0] ? fb_uop_ram_2_debug_inst : 32'h0)
    | (head[1] ? fb_uop_ram_6_debug_inst : 32'h0)
    | (head[2] ? fb_uop_ram_10_debug_inst : 32'h0)
    | (head[3] ? fb_uop_ram_14_debug_inst : 32'h0)
    | (head[4] ? fb_uop_ram_18_debug_inst : 32'h0)
    | (head[5] ? fb_uop_ram_22_debug_inst : 32'h0)
    | (head[6] ? fb_uop_ram_26_debug_inst : 32'h0)
    | (head[7] ? fb_uop_ram_30_debug_inst : 32'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_2_bits_is_rvc =
    head[0] & fb_uop_ram_2_is_rvc | head[1] & fb_uop_ram_6_is_rvc | head[2]
    & fb_uop_ram_10_is_rvc | head[3] & fb_uop_ram_14_is_rvc | head[4]
    & fb_uop_ram_18_is_rvc | head[5] & fb_uop_ram_22_is_rvc | head[6]
    & fb_uop_ram_26_is_rvc | head[7] & fb_uop_ram_30_is_rvc;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_2_bits_debug_pc =
    (head[0] ? fb_uop_ram_2_debug_pc : 40'h0) | (head[1] ? fb_uop_ram_6_debug_pc : 40'h0)
    | (head[2] ? fb_uop_ram_10_debug_pc : 40'h0)
    | (head[3] ? fb_uop_ram_14_debug_pc : 40'h0)
    | (head[4] ? fb_uop_ram_18_debug_pc : 40'h0)
    | (head[5] ? fb_uop_ram_22_debug_pc : 40'h0)
    | (head[6] ? fb_uop_ram_26_debug_pc : 40'h0)
    | (head[7] ? fb_uop_ram_30_debug_pc : 40'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_2_bits_ctrl_br_type =
    (head[0] ? fb_uop_ram_2_ctrl_br_type : 4'h0)
    | (head[1] ? fb_uop_ram_6_ctrl_br_type : 4'h0)
    | (head[2] ? fb_uop_ram_10_ctrl_br_type : 4'h0)
    | (head[3] ? fb_uop_ram_14_ctrl_br_type : 4'h0)
    | (head[4] ? fb_uop_ram_18_ctrl_br_type : 4'h0)
    | (head[5] ? fb_uop_ram_22_ctrl_br_type : 4'h0)
    | (head[6] ? fb_uop_ram_26_ctrl_br_type : 4'h0)
    | (head[7] ? fb_uop_ram_30_ctrl_br_type : 4'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_2_bits_ctrl_op1_sel =
    (head[0] ? fb_uop_ram_2_ctrl_op1_sel : 2'h0)
    | (head[1] ? fb_uop_ram_6_ctrl_op1_sel : 2'h0)
    | (head[2] ? fb_uop_ram_10_ctrl_op1_sel : 2'h0)
    | (head[3] ? fb_uop_ram_14_ctrl_op1_sel : 2'h0)
    | (head[4] ? fb_uop_ram_18_ctrl_op1_sel : 2'h0)
    | (head[5] ? fb_uop_ram_22_ctrl_op1_sel : 2'h0)
    | (head[6] ? fb_uop_ram_26_ctrl_op1_sel : 2'h0)
    | (head[7] ? fb_uop_ram_30_ctrl_op1_sel : 2'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_2_bits_ctrl_op2_sel =
    (head[0] ? fb_uop_ram_2_ctrl_op2_sel : 3'h0)
    | (head[1] ? fb_uop_ram_6_ctrl_op2_sel : 3'h0)
    | (head[2] ? fb_uop_ram_10_ctrl_op2_sel : 3'h0)
    | (head[3] ? fb_uop_ram_14_ctrl_op2_sel : 3'h0)
    | (head[4] ? fb_uop_ram_18_ctrl_op2_sel : 3'h0)
    | (head[5] ? fb_uop_ram_22_ctrl_op2_sel : 3'h0)
    | (head[6] ? fb_uop_ram_26_ctrl_op2_sel : 3'h0)
    | (head[7] ? fb_uop_ram_30_ctrl_op2_sel : 3'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_2_bits_ctrl_imm_sel =
    (head[0] ? fb_uop_ram_2_ctrl_imm_sel : 3'h0)
    | (head[1] ? fb_uop_ram_6_ctrl_imm_sel : 3'h0)
    | (head[2] ? fb_uop_ram_10_ctrl_imm_sel : 3'h0)
    | (head[3] ? fb_uop_ram_14_ctrl_imm_sel : 3'h0)
    | (head[4] ? fb_uop_ram_18_ctrl_imm_sel : 3'h0)
    | (head[5] ? fb_uop_ram_22_ctrl_imm_sel : 3'h0)
    | (head[6] ? fb_uop_ram_26_ctrl_imm_sel : 3'h0)
    | (head[7] ? fb_uop_ram_30_ctrl_imm_sel : 3'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_2_bits_ctrl_op_fcn =
    (head[0] ? fb_uop_ram_2_ctrl_op_fcn : 4'h0)
    | (head[1] ? fb_uop_ram_6_ctrl_op_fcn : 4'h0)
    | (head[2] ? fb_uop_ram_10_ctrl_op_fcn : 4'h0)
    | (head[3] ? fb_uop_ram_14_ctrl_op_fcn : 4'h0)
    | (head[4] ? fb_uop_ram_18_ctrl_op_fcn : 4'h0)
    | (head[5] ? fb_uop_ram_22_ctrl_op_fcn : 4'h0)
    | (head[6] ? fb_uop_ram_26_ctrl_op_fcn : 4'h0)
    | (head[7] ? fb_uop_ram_30_ctrl_op_fcn : 4'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_2_bits_ctrl_fcn_dw =
    head[0] & fb_uop_ram_2_ctrl_fcn_dw | head[1] & fb_uop_ram_6_ctrl_fcn_dw | head[2]
    & fb_uop_ram_10_ctrl_fcn_dw | head[3] & fb_uop_ram_14_ctrl_fcn_dw | head[4]
    & fb_uop_ram_18_ctrl_fcn_dw | head[5] & fb_uop_ram_22_ctrl_fcn_dw | head[6]
    & fb_uop_ram_26_ctrl_fcn_dw | head[7] & fb_uop_ram_30_ctrl_fcn_dw;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_2_bits_ctrl_csr_cmd =
    (head[0] ? fb_uop_ram_2_ctrl_csr_cmd : 3'h0)
    | (head[1] ? fb_uop_ram_6_ctrl_csr_cmd : 3'h0)
    | (head[2] ? fb_uop_ram_10_ctrl_csr_cmd : 3'h0)
    | (head[3] ? fb_uop_ram_14_ctrl_csr_cmd : 3'h0)
    | (head[4] ? fb_uop_ram_18_ctrl_csr_cmd : 3'h0)
    | (head[5] ? fb_uop_ram_22_ctrl_csr_cmd : 3'h0)
    | (head[6] ? fb_uop_ram_26_ctrl_csr_cmd : 3'h0)
    | (head[7] ? fb_uop_ram_30_ctrl_csr_cmd : 3'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_2_bits_ctrl_is_load =
    head[0] & fb_uop_ram_2_ctrl_is_load | head[1] & fb_uop_ram_6_ctrl_is_load | head[2]
    & fb_uop_ram_10_ctrl_is_load | head[3] & fb_uop_ram_14_ctrl_is_load | head[4]
    & fb_uop_ram_18_ctrl_is_load | head[5] & fb_uop_ram_22_ctrl_is_load | head[6]
    & fb_uop_ram_26_ctrl_is_load | head[7] & fb_uop_ram_30_ctrl_is_load;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_2_bits_ctrl_is_sta =
    head[0] & fb_uop_ram_2_ctrl_is_sta | head[1] & fb_uop_ram_6_ctrl_is_sta | head[2]
    & fb_uop_ram_10_ctrl_is_sta | head[3] & fb_uop_ram_14_ctrl_is_sta | head[4]
    & fb_uop_ram_18_ctrl_is_sta | head[5] & fb_uop_ram_22_ctrl_is_sta | head[6]
    & fb_uop_ram_26_ctrl_is_sta | head[7] & fb_uop_ram_30_ctrl_is_sta;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_2_bits_ctrl_is_std =
    head[0] & fb_uop_ram_2_ctrl_is_std | head[1] & fb_uop_ram_6_ctrl_is_std | head[2]
    & fb_uop_ram_10_ctrl_is_std | head[3] & fb_uop_ram_14_ctrl_is_std | head[4]
    & fb_uop_ram_18_ctrl_is_std | head[5] & fb_uop_ram_22_ctrl_is_std | head[6]
    & fb_uop_ram_26_ctrl_is_std | head[7] & fb_uop_ram_30_ctrl_is_std;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_2_bits_iw_state =
    (head[0] ? fb_uop_ram_2_iw_state : 2'h0) | (head[1] ? fb_uop_ram_6_iw_state : 2'h0)
    | (head[2] ? fb_uop_ram_10_iw_state : 2'h0)
    | (head[3] ? fb_uop_ram_14_iw_state : 2'h0)
    | (head[4] ? fb_uop_ram_18_iw_state : 2'h0)
    | (head[5] ? fb_uop_ram_22_iw_state : 2'h0)
    | (head[6] ? fb_uop_ram_26_iw_state : 2'h0)
    | (head[7] ? fb_uop_ram_30_iw_state : 2'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_2_bits_iw_p1_poisoned =
    head[0] & fb_uop_ram_2_iw_p1_poisoned | head[1] & fb_uop_ram_6_iw_p1_poisoned
    | head[2] & fb_uop_ram_10_iw_p1_poisoned | head[3] & fb_uop_ram_14_iw_p1_poisoned
    | head[4] & fb_uop_ram_18_iw_p1_poisoned | head[5] & fb_uop_ram_22_iw_p1_poisoned
    | head[6] & fb_uop_ram_26_iw_p1_poisoned | head[7] & fb_uop_ram_30_iw_p1_poisoned;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_2_bits_iw_p2_poisoned =
    head[0] & fb_uop_ram_2_iw_p2_poisoned | head[1] & fb_uop_ram_6_iw_p2_poisoned
    | head[2] & fb_uop_ram_10_iw_p2_poisoned | head[3] & fb_uop_ram_14_iw_p2_poisoned
    | head[4] & fb_uop_ram_18_iw_p2_poisoned | head[5] & fb_uop_ram_22_iw_p2_poisoned
    | head[6] & fb_uop_ram_26_iw_p2_poisoned | head[7] & fb_uop_ram_30_iw_p2_poisoned;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_2_bits_is_sfb =
    head[0] & fb_uop_ram_2_is_sfb | head[1] & fb_uop_ram_6_is_sfb | head[2]
    & fb_uop_ram_10_is_sfb | head[3] & fb_uop_ram_14_is_sfb | head[4]
    & fb_uop_ram_18_is_sfb | head[5] & fb_uop_ram_22_is_sfb | head[6]
    & fb_uop_ram_26_is_sfb | head[7] & fb_uop_ram_30_is_sfb;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_2_bits_ftq_idx =
    (head[0] ? fb_uop_ram_2_ftq_idx : 6'h0) | (head[1] ? fb_uop_ram_6_ftq_idx : 6'h0)
    | (head[2] ? fb_uop_ram_10_ftq_idx : 6'h0) | (head[3] ? fb_uop_ram_14_ftq_idx : 6'h0)
    | (head[4] ? fb_uop_ram_18_ftq_idx : 6'h0) | (head[5] ? fb_uop_ram_22_ftq_idx : 6'h0)
    | (head[6] ? fb_uop_ram_26_ftq_idx : 6'h0) | (head[7] ? fb_uop_ram_30_ftq_idx : 6'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_2_bits_edge_inst =
    head[0] & fb_uop_ram_2_edge_inst | head[1] & fb_uop_ram_6_edge_inst | head[2]
    & fb_uop_ram_10_edge_inst | head[3] & fb_uop_ram_14_edge_inst | head[4]
    & fb_uop_ram_18_edge_inst | head[5] & fb_uop_ram_22_edge_inst | head[6]
    & fb_uop_ram_26_edge_inst | head[7] & fb_uop_ram_30_edge_inst;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_2_bits_pc_lob =
    (head[0] ? fb_uop_ram_2_pc_lob : 6'h0) | (head[1] ? fb_uop_ram_6_pc_lob : 6'h0)
    | (head[2] ? fb_uop_ram_10_pc_lob : 6'h0) | (head[3] ? fb_uop_ram_14_pc_lob : 6'h0)
    | (head[4] ? fb_uop_ram_18_pc_lob : 6'h0) | (head[5] ? fb_uop_ram_22_pc_lob : 6'h0)
    | (head[6] ? fb_uop_ram_26_pc_lob : 6'h0) | (head[7] ? fb_uop_ram_30_pc_lob : 6'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_2_bits_taken =
    head[0] & fb_uop_ram_2_taken | head[1] & fb_uop_ram_6_taken | head[2]
    & fb_uop_ram_10_taken | head[3] & fb_uop_ram_14_taken | head[4] & fb_uop_ram_18_taken
    | head[5] & fb_uop_ram_22_taken | head[6] & fb_uop_ram_26_taken | head[7]
    & fb_uop_ram_30_taken;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_2_bits_csr_addr =
    (head[0] ? fb_uop_ram_2_csr_addr : 12'h0) | (head[1] ? fb_uop_ram_6_csr_addr : 12'h0)
    | (head[2] ? fb_uop_ram_10_csr_addr : 12'h0)
    | (head[3] ? fb_uop_ram_14_csr_addr : 12'h0)
    | (head[4] ? fb_uop_ram_18_csr_addr : 12'h0)
    | (head[5] ? fb_uop_ram_22_csr_addr : 12'h0)
    | (head[6] ? fb_uop_ram_26_csr_addr : 12'h0)
    | (head[7] ? fb_uop_ram_30_csr_addr : 12'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_2_bits_rxq_idx =
    (head[0] ? fb_uop_ram_2_rxq_idx : 2'h0) | (head[1] ? fb_uop_ram_6_rxq_idx : 2'h0)
    | (head[2] ? fb_uop_ram_10_rxq_idx : 2'h0) | (head[3] ? fb_uop_ram_14_rxq_idx : 2'h0)
    | (head[4] ? fb_uop_ram_18_rxq_idx : 2'h0) | (head[5] ? fb_uop_ram_22_rxq_idx : 2'h0)
    | (head[6] ? fb_uop_ram_26_rxq_idx : 2'h0) | (head[7] ? fb_uop_ram_30_rxq_idx : 2'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_2_bits_xcpt_pf_if =
    head[0] & fb_uop_ram_2_xcpt_pf_if | head[1] & fb_uop_ram_6_xcpt_pf_if | head[2]
    & fb_uop_ram_10_xcpt_pf_if | head[3] & fb_uop_ram_14_xcpt_pf_if | head[4]
    & fb_uop_ram_18_xcpt_pf_if | head[5] & fb_uop_ram_22_xcpt_pf_if | head[6]
    & fb_uop_ram_26_xcpt_pf_if | head[7] & fb_uop_ram_30_xcpt_pf_if;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_2_bits_xcpt_ae_if =
    head[0] & fb_uop_ram_2_xcpt_ae_if | head[1] & fb_uop_ram_6_xcpt_ae_if | head[2]
    & fb_uop_ram_10_xcpt_ae_if | head[3] & fb_uop_ram_14_xcpt_ae_if | head[4]
    & fb_uop_ram_18_xcpt_ae_if | head[5] & fb_uop_ram_22_xcpt_ae_if | head[6]
    & fb_uop_ram_26_xcpt_ae_if | head[7] & fb_uop_ram_30_xcpt_ae_if;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_2_bits_xcpt_ma_if =
    head[0] & fb_uop_ram_2_xcpt_ma_if | head[1] & fb_uop_ram_6_xcpt_ma_if | head[2]
    & fb_uop_ram_10_xcpt_ma_if | head[3] & fb_uop_ram_14_xcpt_ma_if | head[4]
    & fb_uop_ram_18_xcpt_ma_if | head[5] & fb_uop_ram_22_xcpt_ma_if | head[6]
    & fb_uop_ram_26_xcpt_ma_if | head[7] & fb_uop_ram_30_xcpt_ma_if;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_2_bits_bp_debug_if =
    head[0] & fb_uop_ram_2_bp_debug_if | head[1] & fb_uop_ram_6_bp_debug_if | head[2]
    & fb_uop_ram_10_bp_debug_if | head[3] & fb_uop_ram_14_bp_debug_if | head[4]
    & fb_uop_ram_18_bp_debug_if | head[5] & fb_uop_ram_22_bp_debug_if | head[6]
    & fb_uop_ram_26_bp_debug_if | head[7] & fb_uop_ram_30_bp_debug_if;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_2_bits_bp_xcpt_if =
    head[0] & fb_uop_ram_2_bp_xcpt_if | head[1] & fb_uop_ram_6_bp_xcpt_if | head[2]
    & fb_uop_ram_10_bp_xcpt_if | head[3] & fb_uop_ram_14_bp_xcpt_if | head[4]
    & fb_uop_ram_18_bp_xcpt_if | head[5] & fb_uop_ram_22_bp_xcpt_if | head[6]
    & fb_uop_ram_26_bp_xcpt_if | head[7] & fb_uop_ram_30_bp_xcpt_if;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_2_bits_debug_fsrc =
    (head[0] ? fb_uop_ram_2_debug_fsrc : 2'h0)
    | (head[1] ? fb_uop_ram_6_debug_fsrc : 2'h0)
    | (head[2] ? fb_uop_ram_10_debug_fsrc : 2'h0)
    | (head[3] ? fb_uop_ram_14_debug_fsrc : 2'h0)
    | (head[4] ? fb_uop_ram_18_debug_fsrc : 2'h0)
    | (head[5] ? fb_uop_ram_22_debug_fsrc : 2'h0)
    | (head[6] ? fb_uop_ram_26_debug_fsrc : 2'h0)
    | (head[7] ? fb_uop_ram_30_debug_fsrc : 2'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_2_bits_debug_tsrc =
    (head[0] ? fb_uop_ram_2_debug_tsrc : 2'h0)
    | (head[1] ? fb_uop_ram_6_debug_tsrc : 2'h0)
    | (head[2] ? fb_uop_ram_10_debug_tsrc : 2'h0)
    | (head[3] ? fb_uop_ram_14_debug_tsrc : 2'h0)
    | (head[4] ? fb_uop_ram_18_debug_tsrc : 2'h0)
    | (head[5] ? fb_uop_ram_22_debug_tsrc : 2'h0)
    | (head[6] ? fb_uop_ram_26_debug_tsrc : 2'h0)
    | (head[7] ? fb_uop_ram_30_debug_tsrc : 2'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_3_valid = ~reset & _deq_valids_T_11[3];	// fetch-buffer.scala:161:{21,53}, :168:72, :195:23, :196:41
  assign io_deq_bits_uops_3_bits_inst =
    (head[0] ? fb_uop_ram_3_inst : 32'h0) | (head[1] ? fb_uop_ram_7_inst : 32'h0)
    | (head[2] ? fb_uop_ram_11_inst : 32'h0) | (head[3] ? fb_uop_ram_15_inst : 32'h0)
    | (head[4] ? fb_uop_ram_19_inst : 32'h0) | (head[5] ? fb_uop_ram_23_inst : 32'h0)
    | (head[6] ? fb_uop_ram_27_inst : 32'h0) | (head[7] ? fb_uop_ram_31_inst : 32'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_3_bits_debug_inst =
    (head[0] ? fb_uop_ram_3_debug_inst : 32'h0)
    | (head[1] ? fb_uop_ram_7_debug_inst : 32'h0)
    | (head[2] ? fb_uop_ram_11_debug_inst : 32'h0)
    | (head[3] ? fb_uop_ram_15_debug_inst : 32'h0)
    | (head[4] ? fb_uop_ram_19_debug_inst : 32'h0)
    | (head[5] ? fb_uop_ram_23_debug_inst : 32'h0)
    | (head[6] ? fb_uop_ram_27_debug_inst : 32'h0)
    | (head[7] ? fb_uop_ram_31_debug_inst : 32'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_3_bits_is_rvc =
    head[0] & fb_uop_ram_3_is_rvc | head[1] & fb_uop_ram_7_is_rvc | head[2]
    & fb_uop_ram_11_is_rvc | head[3] & fb_uop_ram_15_is_rvc | head[4]
    & fb_uop_ram_19_is_rvc | head[5] & fb_uop_ram_23_is_rvc | head[6]
    & fb_uop_ram_27_is_rvc | head[7] & fb_uop_ram_31_is_rvc;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_3_bits_debug_pc =
    (head[0] ? fb_uop_ram_3_debug_pc : 40'h0) | (head[1] ? fb_uop_ram_7_debug_pc : 40'h0)
    | (head[2] ? fb_uop_ram_11_debug_pc : 40'h0)
    | (head[3] ? fb_uop_ram_15_debug_pc : 40'h0)
    | (head[4] ? fb_uop_ram_19_debug_pc : 40'h0)
    | (head[5] ? fb_uop_ram_23_debug_pc : 40'h0)
    | (head[6] ? fb_uop_ram_27_debug_pc : 40'h0)
    | (head[7] ? fb_uop_ram_31_debug_pc : 40'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_3_bits_ctrl_br_type =
    (head[0] ? fb_uop_ram_3_ctrl_br_type : 4'h0)
    | (head[1] ? fb_uop_ram_7_ctrl_br_type : 4'h0)
    | (head[2] ? fb_uop_ram_11_ctrl_br_type : 4'h0)
    | (head[3] ? fb_uop_ram_15_ctrl_br_type : 4'h0)
    | (head[4] ? fb_uop_ram_19_ctrl_br_type : 4'h0)
    | (head[5] ? fb_uop_ram_23_ctrl_br_type : 4'h0)
    | (head[6] ? fb_uop_ram_27_ctrl_br_type : 4'h0)
    | (head[7] ? fb_uop_ram_31_ctrl_br_type : 4'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_3_bits_ctrl_op1_sel =
    (head[0] ? fb_uop_ram_3_ctrl_op1_sel : 2'h0)
    | (head[1] ? fb_uop_ram_7_ctrl_op1_sel : 2'h0)
    | (head[2] ? fb_uop_ram_11_ctrl_op1_sel : 2'h0)
    | (head[3] ? fb_uop_ram_15_ctrl_op1_sel : 2'h0)
    | (head[4] ? fb_uop_ram_19_ctrl_op1_sel : 2'h0)
    | (head[5] ? fb_uop_ram_23_ctrl_op1_sel : 2'h0)
    | (head[6] ? fb_uop_ram_27_ctrl_op1_sel : 2'h0)
    | (head[7] ? fb_uop_ram_31_ctrl_op1_sel : 2'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_3_bits_ctrl_op2_sel =
    (head[0] ? fb_uop_ram_3_ctrl_op2_sel : 3'h0)
    | (head[1] ? fb_uop_ram_7_ctrl_op2_sel : 3'h0)
    | (head[2] ? fb_uop_ram_11_ctrl_op2_sel : 3'h0)
    | (head[3] ? fb_uop_ram_15_ctrl_op2_sel : 3'h0)
    | (head[4] ? fb_uop_ram_19_ctrl_op2_sel : 3'h0)
    | (head[5] ? fb_uop_ram_23_ctrl_op2_sel : 3'h0)
    | (head[6] ? fb_uop_ram_27_ctrl_op2_sel : 3'h0)
    | (head[7] ? fb_uop_ram_31_ctrl_op2_sel : 3'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_3_bits_ctrl_imm_sel =
    (head[0] ? fb_uop_ram_3_ctrl_imm_sel : 3'h0)
    | (head[1] ? fb_uop_ram_7_ctrl_imm_sel : 3'h0)
    | (head[2] ? fb_uop_ram_11_ctrl_imm_sel : 3'h0)
    | (head[3] ? fb_uop_ram_15_ctrl_imm_sel : 3'h0)
    | (head[4] ? fb_uop_ram_19_ctrl_imm_sel : 3'h0)
    | (head[5] ? fb_uop_ram_23_ctrl_imm_sel : 3'h0)
    | (head[6] ? fb_uop_ram_27_ctrl_imm_sel : 3'h0)
    | (head[7] ? fb_uop_ram_31_ctrl_imm_sel : 3'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_3_bits_ctrl_op_fcn =
    (head[0] ? fb_uop_ram_3_ctrl_op_fcn : 4'h0)
    | (head[1] ? fb_uop_ram_7_ctrl_op_fcn : 4'h0)
    | (head[2] ? fb_uop_ram_11_ctrl_op_fcn : 4'h0)
    | (head[3] ? fb_uop_ram_15_ctrl_op_fcn : 4'h0)
    | (head[4] ? fb_uop_ram_19_ctrl_op_fcn : 4'h0)
    | (head[5] ? fb_uop_ram_23_ctrl_op_fcn : 4'h0)
    | (head[6] ? fb_uop_ram_27_ctrl_op_fcn : 4'h0)
    | (head[7] ? fb_uop_ram_31_ctrl_op_fcn : 4'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_3_bits_ctrl_fcn_dw =
    head[0] & fb_uop_ram_3_ctrl_fcn_dw | head[1] & fb_uop_ram_7_ctrl_fcn_dw | head[2]
    & fb_uop_ram_11_ctrl_fcn_dw | head[3] & fb_uop_ram_15_ctrl_fcn_dw | head[4]
    & fb_uop_ram_19_ctrl_fcn_dw | head[5] & fb_uop_ram_23_ctrl_fcn_dw | head[6]
    & fb_uop_ram_27_ctrl_fcn_dw | head[7] & fb_uop_ram_31_ctrl_fcn_dw;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_3_bits_ctrl_csr_cmd =
    (head[0] ? fb_uop_ram_3_ctrl_csr_cmd : 3'h0)
    | (head[1] ? fb_uop_ram_7_ctrl_csr_cmd : 3'h0)
    | (head[2] ? fb_uop_ram_11_ctrl_csr_cmd : 3'h0)
    | (head[3] ? fb_uop_ram_15_ctrl_csr_cmd : 3'h0)
    | (head[4] ? fb_uop_ram_19_ctrl_csr_cmd : 3'h0)
    | (head[5] ? fb_uop_ram_23_ctrl_csr_cmd : 3'h0)
    | (head[6] ? fb_uop_ram_27_ctrl_csr_cmd : 3'h0)
    | (head[7] ? fb_uop_ram_31_ctrl_csr_cmd : 3'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_3_bits_ctrl_is_load =
    head[0] & fb_uop_ram_3_ctrl_is_load | head[1] & fb_uop_ram_7_ctrl_is_load | head[2]
    & fb_uop_ram_11_ctrl_is_load | head[3] & fb_uop_ram_15_ctrl_is_load | head[4]
    & fb_uop_ram_19_ctrl_is_load | head[5] & fb_uop_ram_23_ctrl_is_load | head[6]
    & fb_uop_ram_27_ctrl_is_load | head[7] & fb_uop_ram_31_ctrl_is_load;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_3_bits_ctrl_is_sta =
    head[0] & fb_uop_ram_3_ctrl_is_sta | head[1] & fb_uop_ram_7_ctrl_is_sta | head[2]
    & fb_uop_ram_11_ctrl_is_sta | head[3] & fb_uop_ram_15_ctrl_is_sta | head[4]
    & fb_uop_ram_19_ctrl_is_sta | head[5] & fb_uop_ram_23_ctrl_is_sta | head[6]
    & fb_uop_ram_27_ctrl_is_sta | head[7] & fb_uop_ram_31_ctrl_is_sta;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_3_bits_ctrl_is_std =
    head[0] & fb_uop_ram_3_ctrl_is_std | head[1] & fb_uop_ram_7_ctrl_is_std | head[2]
    & fb_uop_ram_11_ctrl_is_std | head[3] & fb_uop_ram_15_ctrl_is_std | head[4]
    & fb_uop_ram_19_ctrl_is_std | head[5] & fb_uop_ram_23_ctrl_is_std | head[6]
    & fb_uop_ram_27_ctrl_is_std | head[7] & fb_uop_ram_31_ctrl_is_std;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_3_bits_iw_state =
    (head[0] ? fb_uop_ram_3_iw_state : 2'h0) | (head[1] ? fb_uop_ram_7_iw_state : 2'h0)
    | (head[2] ? fb_uop_ram_11_iw_state : 2'h0)
    | (head[3] ? fb_uop_ram_15_iw_state : 2'h0)
    | (head[4] ? fb_uop_ram_19_iw_state : 2'h0)
    | (head[5] ? fb_uop_ram_23_iw_state : 2'h0)
    | (head[6] ? fb_uop_ram_27_iw_state : 2'h0)
    | (head[7] ? fb_uop_ram_31_iw_state : 2'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_3_bits_iw_p1_poisoned =
    head[0] & fb_uop_ram_3_iw_p1_poisoned | head[1] & fb_uop_ram_7_iw_p1_poisoned
    | head[2] & fb_uop_ram_11_iw_p1_poisoned | head[3] & fb_uop_ram_15_iw_p1_poisoned
    | head[4] & fb_uop_ram_19_iw_p1_poisoned | head[5] & fb_uop_ram_23_iw_p1_poisoned
    | head[6] & fb_uop_ram_27_iw_p1_poisoned | head[7] & fb_uop_ram_31_iw_p1_poisoned;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_3_bits_iw_p2_poisoned =
    head[0] & fb_uop_ram_3_iw_p2_poisoned | head[1] & fb_uop_ram_7_iw_p2_poisoned
    | head[2] & fb_uop_ram_11_iw_p2_poisoned | head[3] & fb_uop_ram_15_iw_p2_poisoned
    | head[4] & fb_uop_ram_19_iw_p2_poisoned | head[5] & fb_uop_ram_23_iw_p2_poisoned
    | head[6] & fb_uop_ram_27_iw_p2_poisoned | head[7] & fb_uop_ram_31_iw_p2_poisoned;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_3_bits_is_sfb =
    head[0] & fb_uop_ram_3_is_sfb | head[1] & fb_uop_ram_7_is_sfb | head[2]
    & fb_uop_ram_11_is_sfb | head[3] & fb_uop_ram_15_is_sfb | head[4]
    & fb_uop_ram_19_is_sfb | head[5] & fb_uop_ram_23_is_sfb | head[6]
    & fb_uop_ram_27_is_sfb | head[7] & fb_uop_ram_31_is_sfb;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_3_bits_ftq_idx =
    (head[0] ? fb_uop_ram_3_ftq_idx : 6'h0) | (head[1] ? fb_uop_ram_7_ftq_idx : 6'h0)
    | (head[2] ? fb_uop_ram_11_ftq_idx : 6'h0) | (head[3] ? fb_uop_ram_15_ftq_idx : 6'h0)
    | (head[4] ? fb_uop_ram_19_ftq_idx : 6'h0) | (head[5] ? fb_uop_ram_23_ftq_idx : 6'h0)
    | (head[6] ? fb_uop_ram_27_ftq_idx : 6'h0) | (head[7] ? fb_uop_ram_31_ftq_idx : 6'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_3_bits_edge_inst =
    head[0] & fb_uop_ram_3_edge_inst | head[1] & fb_uop_ram_7_edge_inst | head[2]
    & fb_uop_ram_11_edge_inst | head[3] & fb_uop_ram_15_edge_inst | head[4]
    & fb_uop_ram_19_edge_inst | head[5] & fb_uop_ram_23_edge_inst | head[6]
    & fb_uop_ram_27_edge_inst | head[7] & fb_uop_ram_31_edge_inst;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_3_bits_pc_lob =
    (head[0] ? fb_uop_ram_3_pc_lob : 6'h0) | (head[1] ? fb_uop_ram_7_pc_lob : 6'h0)
    | (head[2] ? fb_uop_ram_11_pc_lob : 6'h0) | (head[3] ? fb_uop_ram_15_pc_lob : 6'h0)
    | (head[4] ? fb_uop_ram_19_pc_lob : 6'h0) | (head[5] ? fb_uop_ram_23_pc_lob : 6'h0)
    | (head[6] ? fb_uop_ram_27_pc_lob : 6'h0) | (head[7] ? fb_uop_ram_31_pc_lob : 6'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_3_bits_taken =
    head[0] & fb_uop_ram_3_taken | head[1] & fb_uop_ram_7_taken | head[2]
    & fb_uop_ram_11_taken | head[3] & fb_uop_ram_15_taken | head[4] & fb_uop_ram_19_taken
    | head[5] & fb_uop_ram_23_taken | head[6] & fb_uop_ram_27_taken | head[7]
    & fb_uop_ram_31_taken;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_3_bits_csr_addr =
    (head[0] ? fb_uop_ram_3_csr_addr : 12'h0) | (head[1] ? fb_uop_ram_7_csr_addr : 12'h0)
    | (head[2] ? fb_uop_ram_11_csr_addr : 12'h0)
    | (head[3] ? fb_uop_ram_15_csr_addr : 12'h0)
    | (head[4] ? fb_uop_ram_19_csr_addr : 12'h0)
    | (head[5] ? fb_uop_ram_23_csr_addr : 12'h0)
    | (head[6] ? fb_uop_ram_27_csr_addr : 12'h0)
    | (head[7] ? fb_uop_ram_31_csr_addr : 12'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_3_bits_rxq_idx =
    (head[0] ? fb_uop_ram_3_rxq_idx : 2'h0) | (head[1] ? fb_uop_ram_7_rxq_idx : 2'h0)
    | (head[2] ? fb_uop_ram_11_rxq_idx : 2'h0) | (head[3] ? fb_uop_ram_15_rxq_idx : 2'h0)
    | (head[4] ? fb_uop_ram_19_rxq_idx : 2'h0) | (head[5] ? fb_uop_ram_23_rxq_idx : 2'h0)
    | (head[6] ? fb_uop_ram_27_rxq_idx : 2'h0) | (head[7] ? fb_uop_ram_31_rxq_idx : 2'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_3_bits_xcpt_pf_if =
    head[0] & fb_uop_ram_3_xcpt_pf_if | head[1] & fb_uop_ram_7_xcpt_pf_if | head[2]
    & fb_uop_ram_11_xcpt_pf_if | head[3] & fb_uop_ram_15_xcpt_pf_if | head[4]
    & fb_uop_ram_19_xcpt_pf_if | head[5] & fb_uop_ram_23_xcpt_pf_if | head[6]
    & fb_uop_ram_27_xcpt_pf_if | head[7] & fb_uop_ram_31_xcpt_pf_if;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_3_bits_xcpt_ae_if =
    head[0] & fb_uop_ram_3_xcpt_ae_if | head[1] & fb_uop_ram_7_xcpt_ae_if | head[2]
    & fb_uop_ram_11_xcpt_ae_if | head[3] & fb_uop_ram_15_xcpt_ae_if | head[4]
    & fb_uop_ram_19_xcpt_ae_if | head[5] & fb_uop_ram_23_xcpt_ae_if | head[6]
    & fb_uop_ram_27_xcpt_ae_if | head[7] & fb_uop_ram_31_xcpt_ae_if;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_3_bits_xcpt_ma_if =
    head[0] & fb_uop_ram_3_xcpt_ma_if | head[1] & fb_uop_ram_7_xcpt_ma_if | head[2]
    & fb_uop_ram_11_xcpt_ma_if | head[3] & fb_uop_ram_15_xcpt_ma_if | head[4]
    & fb_uop_ram_19_xcpt_ma_if | head[5] & fb_uop_ram_23_xcpt_ma_if | head[6]
    & fb_uop_ram_27_xcpt_ma_if | head[7] & fb_uop_ram_31_xcpt_ma_if;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_3_bits_bp_debug_if =
    head[0] & fb_uop_ram_3_bp_debug_if | head[1] & fb_uop_ram_7_bp_debug_if | head[2]
    & fb_uop_ram_11_bp_debug_if | head[3] & fb_uop_ram_15_bp_debug_if | head[4]
    & fb_uop_ram_19_bp_debug_if | head[5] & fb_uop_ram_23_bp_debug_if | head[6]
    & fb_uop_ram_27_bp_debug_if | head[7] & fb_uop_ram_31_bp_debug_if;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_3_bits_bp_xcpt_if =
    head[0] & fb_uop_ram_3_bp_xcpt_if | head[1] & fb_uop_ram_7_bp_xcpt_if | head[2]
    & fb_uop_ram_11_bp_xcpt_if | head[3] & fb_uop_ram_15_bp_xcpt_if | head[4]
    & fb_uop_ram_19_bp_xcpt_if | head[5] & fb_uop_ram_23_bp_xcpt_if | head[6]
    & fb_uop_ram_27_bp_xcpt_if | head[7] & fb_uop_ram_31_bp_xcpt_if;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_3_bits_debug_fsrc =
    (head[0] ? fb_uop_ram_3_debug_fsrc : 2'h0)
    | (head[1] ? fb_uop_ram_7_debug_fsrc : 2'h0)
    | (head[2] ? fb_uop_ram_11_debug_fsrc : 2'h0)
    | (head[3] ? fb_uop_ram_15_debug_fsrc : 2'h0)
    | (head[4] ? fb_uop_ram_19_debug_fsrc : 2'h0)
    | (head[5] ? fb_uop_ram_23_debug_fsrc : 2'h0)
    | (head[6] ? fb_uop_ram_27_debug_fsrc : 2'h0)
    | (head[7] ? fb_uop_ram_31_debug_fsrc : 2'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_3_bits_debug_tsrc =
    (head[0] ? fb_uop_ram_3_debug_tsrc : 2'h0)
    | (head[1] ? fb_uop_ram_7_debug_tsrc : 2'h0)
    | (head[2] ? fb_uop_ram_11_debug_tsrc : 2'h0)
    | (head[3] ? fb_uop_ram_15_debug_tsrc : 2'h0)
    | (head[4] ? fb_uop_ram_19_debug_tsrc : 2'h0)
    | (head[5] ? fb_uop_ram_23_debug_tsrc : 2'h0)
    | (head[6] ? fb_uop_ram_27_debug_tsrc : 2'h0)
    | (head[7] ? fb_uop_ram_31_debug_tsrc : 2'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
endmodule

