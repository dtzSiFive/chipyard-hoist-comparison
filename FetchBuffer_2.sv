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

module FetchBuffer_2(
  input         clock,
                reset,
                io_enq_valid,
  input  [39:0] io_enq_bits_pc,
  input         io_enq_bits_edge_inst_0,
  input  [31:0] io_enq_bits_insts_0,
                io_enq_bits_insts_1,
                io_enq_bits_insts_2,
                io_enq_bits_insts_3,
                io_enq_bits_exp_insts_0,
                io_enq_bits_exp_insts_1,
                io_enq_bits_exp_insts_2,
                io_enq_bits_exp_insts_3,
  input         io_enq_bits_shadowed_mask_0,
                io_enq_bits_shadowed_mask_1,
                io_enq_bits_shadowed_mask_2,
                io_enq_bits_shadowed_mask_3,
                io_enq_bits_cfi_idx_valid,
  input  [1:0]  io_enq_bits_cfi_idx_bits,
  input  [4:0]  io_enq_bits_ftq_idx,
  input  [3:0]  io_enq_bits_mask,
  input         io_enq_bits_xcpt_pf_if,
                io_enq_bits_xcpt_ae_if,
                io_enq_bits_bp_debug_if_oh_0,
                io_enq_bits_bp_debug_if_oh_1,
                io_enq_bits_bp_debug_if_oh_2,
                io_enq_bits_bp_debug_if_oh_3,
                io_enq_bits_bp_xcpt_if_oh_0,
                io_enq_bits_bp_xcpt_if_oh_1,
                io_enq_bits_bp_xcpt_if_oh_2,
                io_enq_bits_bp_xcpt_if_oh_3,
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
  output [4:0]  io_deq_bits_uops_0_bits_ftq_idx,
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
  output [4:0]  io_deq_bits_uops_1_bits_ftq_idx,
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
                io_deq_bits_uops_1_bits_debug_tsrc
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
  reg  [4:0]  fb_uop_ram_0_ftq_idx;	// fetch-buffer.scala:57:16
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
  reg  [4:0]  fb_uop_ram_1_ftq_idx;	// fetch-buffer.scala:57:16
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
  reg  [4:0]  fb_uop_ram_2_ftq_idx;	// fetch-buffer.scala:57:16
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
  reg  [4:0]  fb_uop_ram_3_ftq_idx;	// fetch-buffer.scala:57:16
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
  reg  [4:0]  fb_uop_ram_4_ftq_idx;	// fetch-buffer.scala:57:16
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
  reg  [4:0]  fb_uop_ram_5_ftq_idx;	// fetch-buffer.scala:57:16
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
  reg  [4:0]  fb_uop_ram_6_ftq_idx;	// fetch-buffer.scala:57:16
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
  reg  [4:0]  fb_uop_ram_7_ftq_idx;	// fetch-buffer.scala:57:16
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
  reg  [4:0]  fb_uop_ram_8_ftq_idx;	// fetch-buffer.scala:57:16
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
  reg  [4:0]  fb_uop_ram_9_ftq_idx;	// fetch-buffer.scala:57:16
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
  reg  [4:0]  fb_uop_ram_10_ftq_idx;	// fetch-buffer.scala:57:16
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
  reg  [4:0]  fb_uop_ram_11_ftq_idx;	// fetch-buffer.scala:57:16
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
  reg  [4:0]  fb_uop_ram_12_ftq_idx;	// fetch-buffer.scala:57:16
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
  reg  [4:0]  fb_uop_ram_13_ftq_idx;	// fetch-buffer.scala:57:16
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
  reg  [4:0]  fb_uop_ram_14_ftq_idx;	// fetch-buffer.scala:57:16
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
  reg  [4:0]  fb_uop_ram_15_ftq_idx;	// fetch-buffer.scala:57:16
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
  reg  [7:0]  head;	// fetch-buffer.scala:61:21
  reg  [15:0] tail;	// fetch-buffer.scala:62:21
  reg         maybe_full;	// fetch-buffer.scala:64:27
  wire        _do_enq_T_1 =
    (|({tail[14], tail[12], tail[10], tail[8], tail[6], tail[4], tail[2], tail[0]}
       & head)) & maybe_full
    | (|(head
         & {tail[13], tail[11], tail[9], tail[7], tail[5], tail[3], tail[1], tail[15]}
         | head
         & {tail[12], tail[10], tail[8], tail[6], tail[4], tail[2], tail[0], tail[14]}
         | head
         & {tail[11], tail[9], tail[7], tail[5], tail[3], tail[1], tail[15], tail[13]}));	// fetch-buffer.scala:61:21, :62:21, :64:27, :75:24, :78:82, :79:{63,88,104,108}, :80:31, :81:{29,36,44}, :82:{26,40}
  wire [1:0]  slot_will_hit_tail =
    {head[0], head[0] & ~maybe_full} & tail[1:0] | {head[1], head[1] & ~maybe_full}
    & tail[3:2] | {head[2], head[2] & ~maybe_full} & tail[5:4]
    | {head[3], head[3] & ~maybe_full} & tail[7:6] | {head[4], head[4] & ~maybe_full}
    & tail[9:8] | {head[5], head[5] & ~maybe_full} & tail[11:10]
    | {head[6], head[6] & ~maybe_full} & tail[13:12] | {head[7], head[7] & ~maybe_full}
    & tail[15:14];	// fetch-buffer.scala:61:21, :62:21, :64:27, :155:{31,45,49,97}, :156:{70,112}
  wire [1:0]  _deq_valids_T_4 = slot_will_hit_tail | {slot_will_hit_tail[0], 1'h0};	// fetch-buffer.scala:156:112, util.scala:384:{37,54}
  wire [1:0]  _deq_valids_T_5 = ~_deq_valids_T_4;	// fetch-buffer.scala:161:21, util.scala:384:54
  always @(posedge clock) begin
    automatic logic [39:0] pc;	// frontend.scala:161:39
    automatic logic        in_mask_0;	// fetch-buffer.scala:98:49
    automatic logic [39:0] _GEN = {io_enq_bits_pc[39:3], 3'h0};	// fetch-buffer.scala:97:33, :107:81
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
    automatic logic [15:0] _GEN_0;	// Cat.scala:30:58
    automatic logic [15:0] enq_idxs_1;	// fetch-buffer.scala:138:18
    automatic logic [15:0] _GEN_1;	// Cat.scala:30:58
    automatic logic [15:0] enq_idxs_2;	// fetch-buffer.scala:138:18
    automatic logic [15:0] _GEN_2;	// Cat.scala:30:58
    automatic logic [15:0] enq_idxs_3;	// fetch-buffer.scala:138:18
    automatic logic        _GEN_3;	// fetch-buffer.scala:144:20
    automatic logic        _GEN_4;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_5;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_6;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_7;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_8;	// fetch-buffer.scala:144:34
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
    automatic logic        _GEN_20;	// fetch-buffer.scala:144:20
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
    automatic logic        _GEN_37;	// fetch-buffer.scala:144:20
    automatic logic        _GEN_38;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_39;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_40;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_41;	// fetch-buffer.scala:144:34
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
    automatic logic        _GEN_54;	// fetch-buffer.scala:144:20
    automatic logic        _GEN_55;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_56;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_57;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_58;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_59;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_60;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_61;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_62;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_63;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_64;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_65;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_66;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_67;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_68;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_69;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_70;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_71;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_72;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_73;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_74;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_75;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_76;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_77;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_78;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_79;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_80;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_81;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_82;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_83;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_84;	// fetch-buffer.scala:57:16, :144:53, :145:16
    automatic logic        _GEN_85;	// fetch-buffer.scala:144:34
    automatic logic        _GEN_86;	// fetch-buffer.scala:57:16, :144:53, :145:16
    pc = {io_enq_bits_pc[39:3], 3'h0};	// fetch-buffer.scala:97:33, frontend.scala:161:39
    in_mask_0 = io_enq_valid & io_enq_bits_mask[0];	// fetch-buffer.scala:98:{49,68}
    _in_uops_0_debug_pc_T_5 = _GEN - 40'h2;	// fetch-buffer.scala:107:81
    in_uops_0_pc_lob = {io_enq_bits_pc[5:3], 3'h0};	// fetch-buffer.scala:97:33, :101:33, :106:41, :108:32
    in_uops_0_is_rvc = io_enq_bits_insts_0[1:0] != 2'h3;	// fetch-buffer.scala:115:{56,62}
    in_uops_0_taken = io_enq_bits_cfi_idx_bits == 2'h0 & io_enq_bits_cfi_idx_valid;	// fetch-buffer.scala:97:33, :116:{61,69}
    _pc_T_7 = _GEN + 40'h2;	// fetch-buffer.scala:95:43, :107:81
    in_mask_1 = io_enq_valid & io_enq_bits_mask[1];	// fetch-buffer.scala:98:{49,68}
    in_uops_1_is_rvc = io_enq_bits_insts_1[1:0] != 2'h3;	// fetch-buffer.scala:115:{56,62}
    in_uops_1_taken = io_enq_bits_cfi_idx_bits == 2'h1 & io_enq_bits_cfi_idx_valid;	// fetch-buffer.scala:116:{61,69}
    _pc_T_11 = _GEN + 40'h4;	// fetch-buffer.scala:95:43, :107:81
    in_mask_2 = io_enq_valid & io_enq_bits_mask[2];	// fetch-buffer.scala:98:{49,68}
    in_uops_2_is_rvc = io_enq_bits_insts_2[1:0] != 2'h3;	// fetch-buffer.scala:115:{56,62}
    in_uops_2_taken = io_enq_bits_cfi_idx_bits == 2'h2 & io_enq_bits_cfi_idx_valid;	// fetch-buffer.scala:107:81, :116:{61,69}
    _pc_T_15 = _GEN + 40'h6;	// fetch-buffer.scala:95:43, :107:81
    in_mask_3 = io_enq_valid & io_enq_bits_mask[3];	// fetch-buffer.scala:98:{49,68}
    in_uops_3_is_rvc = io_enq_bits_insts_3[1:0] != 2'h3;	// fetch-buffer.scala:115:{56,62}
    in_uops_3_taken = (&io_enq_bits_cfi_idx_bits) & io_enq_bits_cfi_idx_valid;	// fetch-buffer.scala:116:{61,69}
    _GEN_0 = {tail[14:0], tail[15]};	// Cat.scala:30:58, fetch-buffer.scala:62:21, :75:{11,24}
    enq_idxs_1 = in_mask_0 ? _GEN_0 : tail;	// Cat.scala:30:58, fetch-buffer.scala:62:21, :98:49, :138:18
    _GEN_1 = {enq_idxs_1[14:0], enq_idxs_1[15]};	// Cat.scala:30:58, fetch-buffer.scala:132:{12,24}, :138:18
    enq_idxs_2 = in_mask_1 ? _GEN_1 : enq_idxs_1;	// Cat.scala:30:58, fetch-buffer.scala:98:49, :138:18
    _GEN_2 = {enq_idxs_2[14:0], enq_idxs_2[15]};	// Cat.scala:30:58, fetch-buffer.scala:132:{12,24}, :138:18
    enq_idxs_3 = in_mask_2 ? _GEN_2 : enq_idxs_2;	// Cat.scala:30:58, fetch-buffer.scala:98:49, :138:18
    _GEN_3 = ~_do_enq_T_1 & in_mask_0;	// fetch-buffer.scala:82:{16,40}, :98:49, :144:20
    _GEN_4 = _GEN_3 & tail[0];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_5 = _GEN_3 & tail[1];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_6 = _GEN_3 & tail[2];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_7 = _GEN_3 & tail[3];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_8 = _GEN_3 & tail[4];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_9 = _GEN_3 & tail[5];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_10 = _GEN_3 & tail[6];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_11 = _GEN_3 & tail[7];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_12 = _GEN_3 & tail[8];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_13 = _GEN_3 & tail[9];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_14 = _GEN_3 & tail[10];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_15 = _GEN_3 & tail[11];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_16 = _GEN_3 & tail[12];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_17 = _GEN_3 & tail[13];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_18 = _GEN_3 & tail[14];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_19 = _GEN_3 & tail[15];	// fetch-buffer.scala:62:21, :144:{20,34,48}
    _GEN_20 = ~_do_enq_T_1 & in_mask_1;	// fetch-buffer.scala:82:{16,40}, :98:49, :144:20
    _GEN_21 = _GEN_20 & enq_idxs_1[0];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_22 = _GEN_20 & enq_idxs_1[1];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_23 = _GEN_20 & enq_idxs_1[2];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_24 = _GEN_20 & enq_idxs_1[3];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_25 = _GEN_20 & enq_idxs_1[4];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_26 = _GEN_20 & enq_idxs_1[5];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_27 = _GEN_20 & enq_idxs_1[6];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_28 = _GEN_20 & enq_idxs_1[7];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_29 = _GEN_20 & enq_idxs_1[8];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_30 = _GEN_20 & enq_idxs_1[9];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_31 = _GEN_20 & enq_idxs_1[10];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_32 = _GEN_20 & enq_idxs_1[11];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_33 = _GEN_20 & enq_idxs_1[12];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_34 = _GEN_20 & enq_idxs_1[13];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_35 = _GEN_20 & enq_idxs_1[14];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_36 = _GEN_20 & enq_idxs_1[15];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_37 = ~_do_enq_T_1 & in_mask_2;	// fetch-buffer.scala:82:{16,40}, :98:49, :144:20
    _GEN_38 = _GEN_37 & enq_idxs_2[0];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_39 = _GEN_37 & enq_idxs_2[1];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_40 = _GEN_37 & enq_idxs_2[2];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_41 = _GEN_37 & enq_idxs_2[3];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_42 = _GEN_37 & enq_idxs_2[4];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_43 = _GEN_37 & enq_idxs_2[5];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_44 = _GEN_37 & enq_idxs_2[6];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_45 = _GEN_37 & enq_idxs_2[7];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_46 = _GEN_37 & enq_idxs_2[8];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_47 = _GEN_37 & enq_idxs_2[9];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_48 = _GEN_37 & enq_idxs_2[10];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_49 = _GEN_37 & enq_idxs_2[11];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_50 = _GEN_37 & enq_idxs_2[12];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_51 = _GEN_37 & enq_idxs_2[13];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_52 = _GEN_37 & enq_idxs_2[14];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_53 = _GEN_37 & enq_idxs_2[15];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_54 = ~_do_enq_T_1 & in_mask_3;	// fetch-buffer.scala:82:{16,40}, :98:49, :144:20
    _GEN_55 = _GEN_54 & enq_idxs_3[0];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_56 = _GEN_55 | _GEN_38 | _GEN_21 | _GEN_4;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_57 = _GEN_54 & enq_idxs_3[1];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_58 = _GEN_57 | _GEN_39 | _GEN_22 | _GEN_5;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_59 = _GEN_54 & enq_idxs_3[2];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_60 = _GEN_59 | _GEN_40 | _GEN_23 | _GEN_6;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_61 = _GEN_54 & enq_idxs_3[3];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_62 = _GEN_61 | _GEN_41 | _GEN_24 | _GEN_7;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_63 = _GEN_54 & enq_idxs_3[4];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_64 = _GEN_63 | _GEN_42 | _GEN_25 | _GEN_8;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_65 = _GEN_54 & enq_idxs_3[5];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_66 = _GEN_65 | _GEN_43 | _GEN_26 | _GEN_9;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_67 = _GEN_54 & enq_idxs_3[6];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_68 = _GEN_67 | _GEN_44 | _GEN_27 | _GEN_10;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_69 = _GEN_54 & enq_idxs_3[7];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_70 = _GEN_69 | _GEN_45 | _GEN_28 | _GEN_11;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_71 = _GEN_54 & enq_idxs_3[8];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_72 = _GEN_71 | _GEN_46 | _GEN_29 | _GEN_12;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_73 = _GEN_54 & enq_idxs_3[9];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_74 = _GEN_73 | _GEN_47 | _GEN_30 | _GEN_13;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_75 = _GEN_54 & enq_idxs_3[10];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_76 = _GEN_75 | _GEN_48 | _GEN_31 | _GEN_14;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_77 = _GEN_54 & enq_idxs_3[11];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_78 = _GEN_77 | _GEN_49 | _GEN_32 | _GEN_15;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_79 = _GEN_54 & enq_idxs_3[12];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_80 = _GEN_79 | _GEN_50 | _GEN_33 | _GEN_16;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_81 = _GEN_54 & enq_idxs_3[13];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_82 = _GEN_81 | _GEN_51 | _GEN_34 | _GEN_17;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_83 = _GEN_54 & enq_idxs_3[14];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_84 = _GEN_83 | _GEN_52 | _GEN_35 | _GEN_18;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    _GEN_85 = _GEN_54 & enq_idxs_3[15];	// fetch-buffer.scala:138:18, :144:{20,34,48}
    _GEN_86 = _GEN_85 | _GEN_53 | _GEN_36 | _GEN_19;	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    if (_GEN_55) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_38) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_21) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_4) begin	// fetch-buffer.scala:144:34
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
    if (_GEN_56) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
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
    fb_uop_ram_0_ctrl_fcn_dw <= ~_GEN_56 & fb_uop_ram_0_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_0_ctrl_is_load <= ~_GEN_56 & fb_uop_ram_0_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_0_ctrl_is_sta <= ~_GEN_56 & fb_uop_ram_0_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_0_ctrl_is_std <= ~_GEN_56 & fb_uop_ram_0_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_0_iw_p1_poisoned <= ~_GEN_56 & fb_uop_ram_0_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_0_iw_p2_poisoned <= ~_GEN_56 & fb_uop_ram_0_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_0_edge_inst <=
      ~(_GEN_55 | _GEN_38 | _GEN_21)
      & (_GEN_4 ? io_enq_bits_edge_inst_0 : fb_uop_ram_0_edge_inst);	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_0_xcpt_ma_if <= ~_GEN_56 & fb_uop_ram_0_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_57) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_39) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_22) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_5) begin	// fetch-buffer.scala:144:34
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
    if (_GEN_58) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
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
    fb_uop_ram_1_ctrl_fcn_dw <= ~_GEN_58 & fb_uop_ram_1_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_1_ctrl_is_load <= ~_GEN_58 & fb_uop_ram_1_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_1_ctrl_is_sta <= ~_GEN_58 & fb_uop_ram_1_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_1_ctrl_is_std <= ~_GEN_58 & fb_uop_ram_1_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_1_iw_p1_poisoned <= ~_GEN_58 & fb_uop_ram_1_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_1_iw_p2_poisoned <= ~_GEN_58 & fb_uop_ram_1_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_1_edge_inst <=
      ~(_GEN_57 | _GEN_39 | _GEN_22)
      & (_GEN_5 ? io_enq_bits_edge_inst_0 : fb_uop_ram_1_edge_inst);	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_1_xcpt_ma_if <= ~_GEN_58 & fb_uop_ram_1_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_59) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_40) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_23) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_6) begin	// fetch-buffer.scala:144:34
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
    if (_GEN_60) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
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
    fb_uop_ram_2_ctrl_fcn_dw <= ~_GEN_60 & fb_uop_ram_2_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_2_ctrl_is_load <= ~_GEN_60 & fb_uop_ram_2_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_2_ctrl_is_sta <= ~_GEN_60 & fb_uop_ram_2_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_2_ctrl_is_std <= ~_GEN_60 & fb_uop_ram_2_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_2_iw_p1_poisoned <= ~_GEN_60 & fb_uop_ram_2_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_2_iw_p2_poisoned <= ~_GEN_60 & fb_uop_ram_2_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_2_edge_inst <=
      ~(_GEN_59 | _GEN_40 | _GEN_23)
      & (_GEN_6 ? io_enq_bits_edge_inst_0 : fb_uop_ram_2_edge_inst);	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_2_xcpt_ma_if <= ~_GEN_60 & fb_uop_ram_2_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_61) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_41) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_24) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_7) begin	// fetch-buffer.scala:144:34
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
    if (_GEN_62) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
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
    fb_uop_ram_3_ctrl_fcn_dw <= ~_GEN_62 & fb_uop_ram_3_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_3_ctrl_is_load <= ~_GEN_62 & fb_uop_ram_3_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_3_ctrl_is_sta <= ~_GEN_62 & fb_uop_ram_3_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_3_ctrl_is_std <= ~_GEN_62 & fb_uop_ram_3_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_3_iw_p1_poisoned <= ~_GEN_62 & fb_uop_ram_3_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_3_iw_p2_poisoned <= ~_GEN_62 & fb_uop_ram_3_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_3_edge_inst <=
      ~(_GEN_61 | _GEN_41 | _GEN_24)
      & (_GEN_7 ? io_enq_bits_edge_inst_0 : fb_uop_ram_3_edge_inst);	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_3_xcpt_ma_if <= ~_GEN_62 & fb_uop_ram_3_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_63) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_42) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_25) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_8) begin	// fetch-buffer.scala:144:34
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
    if (_GEN_64) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
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
    fb_uop_ram_4_ctrl_fcn_dw <= ~_GEN_64 & fb_uop_ram_4_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_4_ctrl_is_load <= ~_GEN_64 & fb_uop_ram_4_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_4_ctrl_is_sta <= ~_GEN_64 & fb_uop_ram_4_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_4_ctrl_is_std <= ~_GEN_64 & fb_uop_ram_4_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_4_iw_p1_poisoned <= ~_GEN_64 & fb_uop_ram_4_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_4_iw_p2_poisoned <= ~_GEN_64 & fb_uop_ram_4_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_4_edge_inst <=
      ~(_GEN_63 | _GEN_42 | _GEN_25)
      & (_GEN_8 ? io_enq_bits_edge_inst_0 : fb_uop_ram_4_edge_inst);	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_4_xcpt_ma_if <= ~_GEN_64 & fb_uop_ram_4_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_65) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_43) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_26) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_9) begin	// fetch-buffer.scala:144:34
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
    if (_GEN_66) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
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
    fb_uop_ram_5_ctrl_fcn_dw <= ~_GEN_66 & fb_uop_ram_5_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_5_ctrl_is_load <= ~_GEN_66 & fb_uop_ram_5_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_5_ctrl_is_sta <= ~_GEN_66 & fb_uop_ram_5_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_5_ctrl_is_std <= ~_GEN_66 & fb_uop_ram_5_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_5_iw_p1_poisoned <= ~_GEN_66 & fb_uop_ram_5_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_5_iw_p2_poisoned <= ~_GEN_66 & fb_uop_ram_5_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_5_edge_inst <=
      ~(_GEN_65 | _GEN_43 | _GEN_26)
      & (_GEN_9 ? io_enq_bits_edge_inst_0 : fb_uop_ram_5_edge_inst);	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_5_xcpt_ma_if <= ~_GEN_66 & fb_uop_ram_5_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_67) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_44) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_27) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_10) begin	// fetch-buffer.scala:144:34
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
    if (_GEN_68) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
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
    fb_uop_ram_6_ctrl_fcn_dw <= ~_GEN_68 & fb_uop_ram_6_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_6_ctrl_is_load <= ~_GEN_68 & fb_uop_ram_6_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_6_ctrl_is_sta <= ~_GEN_68 & fb_uop_ram_6_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_6_ctrl_is_std <= ~_GEN_68 & fb_uop_ram_6_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_6_iw_p1_poisoned <= ~_GEN_68 & fb_uop_ram_6_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_6_iw_p2_poisoned <= ~_GEN_68 & fb_uop_ram_6_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_6_edge_inst <=
      ~(_GEN_67 | _GEN_44 | _GEN_27)
      & (_GEN_10 ? io_enq_bits_edge_inst_0 : fb_uop_ram_6_edge_inst);	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_6_xcpt_ma_if <= ~_GEN_68 & fb_uop_ram_6_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_69) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_45) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_28) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_11) begin	// fetch-buffer.scala:144:34
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
    if (_GEN_70) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
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
    fb_uop_ram_7_ctrl_fcn_dw <= ~_GEN_70 & fb_uop_ram_7_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_7_ctrl_is_load <= ~_GEN_70 & fb_uop_ram_7_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_7_ctrl_is_sta <= ~_GEN_70 & fb_uop_ram_7_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_7_ctrl_is_std <= ~_GEN_70 & fb_uop_ram_7_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_7_iw_p1_poisoned <= ~_GEN_70 & fb_uop_ram_7_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_7_iw_p2_poisoned <= ~_GEN_70 & fb_uop_ram_7_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_7_edge_inst <=
      ~(_GEN_69 | _GEN_45 | _GEN_28)
      & (_GEN_11 ? io_enq_bits_edge_inst_0 : fb_uop_ram_7_edge_inst);	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_7_xcpt_ma_if <= ~_GEN_70 & fb_uop_ram_7_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_71) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_46) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_29) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_12) begin	// fetch-buffer.scala:144:34
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
    if (_GEN_72) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
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
    fb_uop_ram_8_ctrl_fcn_dw <= ~_GEN_72 & fb_uop_ram_8_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_8_ctrl_is_load <= ~_GEN_72 & fb_uop_ram_8_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_8_ctrl_is_sta <= ~_GEN_72 & fb_uop_ram_8_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_8_ctrl_is_std <= ~_GEN_72 & fb_uop_ram_8_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_8_iw_p1_poisoned <= ~_GEN_72 & fb_uop_ram_8_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_8_iw_p2_poisoned <= ~_GEN_72 & fb_uop_ram_8_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_8_edge_inst <=
      ~(_GEN_71 | _GEN_46 | _GEN_29)
      & (_GEN_12 ? io_enq_bits_edge_inst_0 : fb_uop_ram_8_edge_inst);	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_8_xcpt_ma_if <= ~_GEN_72 & fb_uop_ram_8_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_73) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_47) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_30) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_13) begin	// fetch-buffer.scala:144:34
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
    if (_GEN_74) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
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
    fb_uop_ram_9_ctrl_fcn_dw <= ~_GEN_74 & fb_uop_ram_9_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_9_ctrl_is_load <= ~_GEN_74 & fb_uop_ram_9_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_9_ctrl_is_sta <= ~_GEN_74 & fb_uop_ram_9_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_9_ctrl_is_std <= ~_GEN_74 & fb_uop_ram_9_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_9_iw_p1_poisoned <= ~_GEN_74 & fb_uop_ram_9_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_9_iw_p2_poisoned <= ~_GEN_74 & fb_uop_ram_9_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_9_edge_inst <=
      ~(_GEN_73 | _GEN_47 | _GEN_30)
      & (_GEN_13 ? io_enq_bits_edge_inst_0 : fb_uop_ram_9_edge_inst);	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_9_xcpt_ma_if <= ~_GEN_74 & fb_uop_ram_9_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_75) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_48) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_31) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_14) begin	// fetch-buffer.scala:144:34
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
    if (_GEN_76) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
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
    fb_uop_ram_10_ctrl_fcn_dw <= ~_GEN_76 & fb_uop_ram_10_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_10_ctrl_is_load <= ~_GEN_76 & fb_uop_ram_10_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_10_ctrl_is_sta <= ~_GEN_76 & fb_uop_ram_10_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_10_ctrl_is_std <= ~_GEN_76 & fb_uop_ram_10_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_10_iw_p1_poisoned <= ~_GEN_76 & fb_uop_ram_10_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_10_iw_p2_poisoned <= ~_GEN_76 & fb_uop_ram_10_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_10_edge_inst <=
      ~(_GEN_75 | _GEN_48 | _GEN_31)
      & (_GEN_14 ? io_enq_bits_edge_inst_0 : fb_uop_ram_10_edge_inst);	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_10_xcpt_ma_if <= ~_GEN_76 & fb_uop_ram_10_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_77) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_49) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_32) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_15) begin	// fetch-buffer.scala:144:34
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
    if (_GEN_78) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
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
    fb_uop_ram_11_ctrl_fcn_dw <= ~_GEN_78 & fb_uop_ram_11_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_11_ctrl_is_load <= ~_GEN_78 & fb_uop_ram_11_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_11_ctrl_is_sta <= ~_GEN_78 & fb_uop_ram_11_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_11_ctrl_is_std <= ~_GEN_78 & fb_uop_ram_11_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_11_iw_p1_poisoned <= ~_GEN_78 & fb_uop_ram_11_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_11_iw_p2_poisoned <= ~_GEN_78 & fb_uop_ram_11_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_11_edge_inst <=
      ~(_GEN_77 | _GEN_49 | _GEN_32)
      & (_GEN_15 ? io_enq_bits_edge_inst_0 : fb_uop_ram_11_edge_inst);	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_11_xcpt_ma_if <= ~_GEN_78 & fb_uop_ram_11_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_79) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_50) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_33) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_16) begin	// fetch-buffer.scala:144:34
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
    if (_GEN_80) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
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
    fb_uop_ram_12_ctrl_fcn_dw <= ~_GEN_80 & fb_uop_ram_12_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_12_ctrl_is_load <= ~_GEN_80 & fb_uop_ram_12_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_12_ctrl_is_sta <= ~_GEN_80 & fb_uop_ram_12_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_12_ctrl_is_std <= ~_GEN_80 & fb_uop_ram_12_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_12_iw_p1_poisoned <= ~_GEN_80 & fb_uop_ram_12_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_12_iw_p2_poisoned <= ~_GEN_80 & fb_uop_ram_12_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_12_edge_inst <=
      ~(_GEN_79 | _GEN_50 | _GEN_33)
      & (_GEN_16 ? io_enq_bits_edge_inst_0 : fb_uop_ram_12_edge_inst);	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_12_xcpt_ma_if <= ~_GEN_80 & fb_uop_ram_12_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_81) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_51) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_34) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_17) begin	// fetch-buffer.scala:144:34
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
    if (_GEN_82) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
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
    fb_uop_ram_13_ctrl_fcn_dw <= ~_GEN_82 & fb_uop_ram_13_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_13_ctrl_is_load <= ~_GEN_82 & fb_uop_ram_13_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_13_ctrl_is_sta <= ~_GEN_82 & fb_uop_ram_13_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_13_ctrl_is_std <= ~_GEN_82 & fb_uop_ram_13_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_13_iw_p1_poisoned <= ~_GEN_82 & fb_uop_ram_13_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_13_iw_p2_poisoned <= ~_GEN_82 & fb_uop_ram_13_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_13_edge_inst <=
      ~(_GEN_81 | _GEN_51 | _GEN_34)
      & (_GEN_17 ? io_enq_bits_edge_inst_0 : fb_uop_ram_13_edge_inst);	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_13_xcpt_ma_if <= ~_GEN_82 & fb_uop_ram_13_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_83) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_52) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_35) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_18) begin	// fetch-buffer.scala:144:34
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
    if (_GEN_84) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
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
    fb_uop_ram_14_ctrl_fcn_dw <= ~_GEN_84 & fb_uop_ram_14_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_14_ctrl_is_load <= ~_GEN_84 & fb_uop_ram_14_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_14_ctrl_is_sta <= ~_GEN_84 & fb_uop_ram_14_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_14_ctrl_is_std <= ~_GEN_84 & fb_uop_ram_14_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_14_iw_p1_poisoned <= ~_GEN_84 & fb_uop_ram_14_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_14_iw_p2_poisoned <= ~_GEN_84 & fb_uop_ram_14_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_14_edge_inst <=
      ~(_GEN_83 | _GEN_52 | _GEN_35)
      & (_GEN_18 ? io_enq_bits_edge_inst_0 : fb_uop_ram_14_edge_inst);	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_14_xcpt_ma_if <= ~_GEN_84 & fb_uop_ram_14_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (_GEN_85) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_53) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_36) begin	// fetch-buffer.scala:144:34
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
    else if (_GEN_19) begin	// fetch-buffer.scala:144:34
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
    if (_GEN_86) begin	// fetch-buffer.scala:57:16, :144:53, :145:16
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
    fb_uop_ram_15_ctrl_fcn_dw <= ~_GEN_86 & fb_uop_ram_15_ctrl_fcn_dw;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_15_ctrl_is_load <= ~_GEN_86 & fb_uop_ram_15_ctrl_is_load;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_15_ctrl_is_sta <= ~_GEN_86 & fb_uop_ram_15_ctrl_is_sta;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_15_ctrl_is_std <= ~_GEN_86 & fb_uop_ram_15_ctrl_is_std;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_15_iw_p1_poisoned <= ~_GEN_86 & fb_uop_ram_15_iw_p1_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_15_iw_p2_poisoned <= ~_GEN_86 & fb_uop_ram_15_iw_p2_poisoned;	// fetch-buffer.scala:57:16, :144:53, :145:16
    fb_uop_ram_15_edge_inst <=
      ~(_GEN_85 | _GEN_53 | _GEN_36)
      & (_GEN_19 ? io_enq_bits_edge_inst_0 : fb_uop_ram_15_edge_inst);	// fetch-buffer.scala:57:16, :144:{34,53}, :145:16
    fb_uop_ram_15_xcpt_ma_if <= ~_GEN_86 & fb_uop_ram_15_xcpt_ma_if;	// fetch-buffer.scala:57:16, :144:53, :145:16
    if (reset) begin
      head <= 8'h1;	// fetch-buffer.scala:61:21
      tail <= 16'h1;	// fetch-buffer.scala:62:21
      maybe_full <= 1'h0;	// fetch-buffer.scala:64:27
    end
    else begin
      automatic logic do_deq;	// fetch-buffer.scala:159:29
      do_deq = io_deq_ready & slot_will_hit_tail == 2'h0;	// fetch-buffer.scala:97:33, :156:112, :157:42, :159:29
      if (io_clear) begin
        head <= 8'h1;	// fetch-buffer.scala:61:21
        tail <= 16'h1;	// fetch-buffer.scala:62:21
      end
      else begin
        if (do_deq)	// fetch-buffer.scala:159:29
          head <= {head[6:0], head[7]};	// Cat.scala:30:58, fetch-buffer.scala:61:21, :132:12, :155:31
        if (~_do_enq_T_1) begin	// fetch-buffer.scala:82:40
          if (in_mask_3)	// fetch-buffer.scala:98:49
            tail <= {enq_idxs_3[14:0], enq_idxs_3[15]};	// Cat.scala:30:58, fetch-buffer.scala:62:21, :132:{12,24}, :138:18
          else if (in_mask_2)	// fetch-buffer.scala:98:49
            tail <= _GEN_2;	// Cat.scala:30:58, fetch-buffer.scala:62:21
          else if (in_mask_1)	// fetch-buffer.scala:98:49
            tail <= _GEN_1;	// Cat.scala:30:58, fetch-buffer.scala:62:21
          else if (in_mask_0)	// fetch-buffer.scala:98:49
            tail <= _GEN_0;	// Cat.scala:30:58, fetch-buffer.scala:62:21
        end
      end
      maybe_full <=
        ~(io_clear | do_deq)
        & (~_do_enq_T_1 & (in_mask_0 | in_mask_1 | in_mask_2 | in_mask_3) | maybe_full);	// fetch-buffer.scala:64:27, :82:{16,40}, :98:49, :159:29, :176:17, :178:{27,33}, :179:18, :183:17, :185:16, :188:19, :191:16
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:202];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [7:0] i = 8'h0; i < 8'hCB; i += 8'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        fb_uop_ram_0_inst = {_RANDOM[8'h0][31:7], _RANDOM[8'h1][6:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_0_debug_inst = {_RANDOM[8'h1][31:7], _RANDOM[8'h2][6:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_0_is_rvc = _RANDOM[8'h2][7];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_debug_pc = {_RANDOM[8'h2][31:8], _RANDOM[8'h3][15:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_0_ctrl_br_type = {_RANDOM[8'h3][31:29], _RANDOM[8'h4][0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_0_ctrl_op1_sel = _RANDOM[8'h4][2:1];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_ctrl_op2_sel = _RANDOM[8'h4][5:3];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_ctrl_imm_sel = _RANDOM[8'h4][8:6];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_ctrl_op_fcn = _RANDOM[8'h4][12:9];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_ctrl_fcn_dw = _RANDOM[8'h4][13];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_ctrl_csr_cmd = _RANDOM[8'h4][16:14];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_ctrl_is_load = _RANDOM[8'h4][17];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_ctrl_is_sta = _RANDOM[8'h4][18];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_ctrl_is_std = _RANDOM[8'h4][19];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_iw_state = _RANDOM[8'h4][21:20];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_iw_p1_poisoned = _RANDOM[8'h4][22];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_iw_p2_poisoned = _RANDOM[8'h4][23];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_is_sfb = _RANDOM[8'h4][27];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_ftq_idx = _RANDOM[8'h5][16:12];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_edge_inst = _RANDOM[8'h5][17];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_pc_lob = _RANDOM[8'h5][23:18];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_taken = _RANDOM[8'h5][24];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_csr_addr = _RANDOM[8'h6][24:13];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_rxq_idx = _RANDOM[8'h7][8:7];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_xcpt_pf_if = _RANDOM[8'hC][10];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_xcpt_ae_if = _RANDOM[8'hC][11];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_xcpt_ma_if = _RANDOM[8'hC][12];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_bp_debug_if = _RANDOM[8'hC][13];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_bp_xcpt_if = _RANDOM[8'hC][14];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_debug_fsrc = _RANDOM[8'hC][16:15];	// fetch-buffer.scala:57:16
        fb_uop_ram_0_debug_tsrc = _RANDOM[8'hC][18:17];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_inst = {_RANDOM[8'hC][31:26], _RANDOM[8'hD][25:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_1_debug_inst = {_RANDOM[8'hD][31:26], _RANDOM[8'hE][25:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_1_is_rvc = _RANDOM[8'hE][26];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_debug_pc =
          {_RANDOM[8'hE][31:27], _RANDOM[8'hF], _RANDOM[8'h10][2:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_1_ctrl_br_type = _RANDOM[8'h10][19:16];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_ctrl_op1_sel = _RANDOM[8'h10][21:20];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_ctrl_op2_sel = _RANDOM[8'h10][24:22];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_ctrl_imm_sel = _RANDOM[8'h10][27:25];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_ctrl_op_fcn = _RANDOM[8'h10][31:28];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_ctrl_fcn_dw = _RANDOM[8'h11][0];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_ctrl_csr_cmd = _RANDOM[8'h11][3:1];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_ctrl_is_load = _RANDOM[8'h11][4];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_ctrl_is_sta = _RANDOM[8'h11][5];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_ctrl_is_std = _RANDOM[8'h11][6];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_iw_state = _RANDOM[8'h11][8:7];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_iw_p1_poisoned = _RANDOM[8'h11][9];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_iw_p2_poisoned = _RANDOM[8'h11][10];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_is_sfb = _RANDOM[8'h11][14];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_ftq_idx = {_RANDOM[8'h11][31], _RANDOM[8'h12][3:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_1_edge_inst = _RANDOM[8'h12][4];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_pc_lob = _RANDOM[8'h12][10:5];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_taken = _RANDOM[8'h12][11];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_csr_addr = _RANDOM[8'h13][11:0];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_rxq_idx = _RANDOM[8'h13][27:26];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_xcpt_pf_if = _RANDOM[8'h18][29];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_xcpt_ae_if = _RANDOM[8'h18][30];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_xcpt_ma_if = _RANDOM[8'h18][31];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_bp_debug_if = _RANDOM[8'h19][0];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_bp_xcpt_if = _RANDOM[8'h19][1];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_debug_fsrc = _RANDOM[8'h19][3:2];	// fetch-buffer.scala:57:16
        fb_uop_ram_1_debug_tsrc = _RANDOM[8'h19][5:4];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_inst = {_RANDOM[8'h19][31:13], _RANDOM[8'h1A][12:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_2_debug_inst = {_RANDOM[8'h1A][31:13], _RANDOM[8'h1B][12:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_2_is_rvc = _RANDOM[8'h1B][13];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_debug_pc = {_RANDOM[8'h1B][31:14], _RANDOM[8'h1C][21:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_2_ctrl_br_type = _RANDOM[8'h1D][6:3];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_ctrl_op1_sel = _RANDOM[8'h1D][8:7];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_ctrl_op2_sel = _RANDOM[8'h1D][11:9];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_ctrl_imm_sel = _RANDOM[8'h1D][14:12];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_ctrl_op_fcn = _RANDOM[8'h1D][18:15];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_ctrl_fcn_dw = _RANDOM[8'h1D][19];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_ctrl_csr_cmd = _RANDOM[8'h1D][22:20];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_ctrl_is_load = _RANDOM[8'h1D][23];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_ctrl_is_sta = _RANDOM[8'h1D][24];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_ctrl_is_std = _RANDOM[8'h1D][25];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_iw_state = _RANDOM[8'h1D][27:26];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_iw_p1_poisoned = _RANDOM[8'h1D][28];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_iw_p2_poisoned = _RANDOM[8'h1D][29];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_is_sfb = _RANDOM[8'h1E][1];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_ftq_idx = _RANDOM[8'h1E][22:18];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_edge_inst = _RANDOM[8'h1E][23];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_pc_lob = _RANDOM[8'h1E][29:24];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_taken = _RANDOM[8'h1E][30];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_csr_addr = _RANDOM[8'h1F][30:19];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_rxq_idx = _RANDOM[8'h20][14:13];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_xcpt_pf_if = _RANDOM[8'h25][16];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_xcpt_ae_if = _RANDOM[8'h25][17];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_xcpt_ma_if = _RANDOM[8'h25][18];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_bp_debug_if = _RANDOM[8'h25][19];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_bp_xcpt_if = _RANDOM[8'h25][20];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_debug_fsrc = _RANDOM[8'h25][22:21];	// fetch-buffer.scala:57:16
        fb_uop_ram_2_debug_tsrc = _RANDOM[8'h25][24:23];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_inst = _RANDOM[8'h26];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_debug_inst = _RANDOM[8'h27];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_is_rvc = _RANDOM[8'h28][0];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_debug_pc = {_RANDOM[8'h28][31:1], _RANDOM[8'h29][8:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_3_ctrl_br_type = _RANDOM[8'h29][25:22];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_ctrl_op1_sel = _RANDOM[8'h29][27:26];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_ctrl_op2_sel = _RANDOM[8'h29][30:28];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_ctrl_imm_sel = {_RANDOM[8'h29][31], _RANDOM[8'h2A][1:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_3_ctrl_op_fcn = _RANDOM[8'h2A][5:2];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_ctrl_fcn_dw = _RANDOM[8'h2A][6];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_ctrl_csr_cmd = _RANDOM[8'h2A][9:7];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_ctrl_is_load = _RANDOM[8'h2A][10];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_ctrl_is_sta = _RANDOM[8'h2A][11];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_ctrl_is_std = _RANDOM[8'h2A][12];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_iw_state = _RANDOM[8'h2A][14:13];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_iw_p1_poisoned = _RANDOM[8'h2A][15];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_iw_p2_poisoned = _RANDOM[8'h2A][16];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_is_sfb = _RANDOM[8'h2A][20];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_ftq_idx = _RANDOM[8'h2B][9:5];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_edge_inst = _RANDOM[8'h2B][10];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_pc_lob = _RANDOM[8'h2B][16:11];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_taken = _RANDOM[8'h2B][17];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_csr_addr = _RANDOM[8'h2C][17:6];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_rxq_idx = _RANDOM[8'h2D][1:0];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_xcpt_pf_if = _RANDOM[8'h32][3];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_xcpt_ae_if = _RANDOM[8'h32][4];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_xcpt_ma_if = _RANDOM[8'h32][5];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_bp_debug_if = _RANDOM[8'h32][6];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_bp_xcpt_if = _RANDOM[8'h32][7];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_debug_fsrc = _RANDOM[8'h32][9:8];	// fetch-buffer.scala:57:16
        fb_uop_ram_3_debug_tsrc = _RANDOM[8'h32][11:10];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_inst = {_RANDOM[8'h32][31:19], _RANDOM[8'h33][18:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_4_debug_inst = {_RANDOM[8'h33][31:19], _RANDOM[8'h34][18:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_4_is_rvc = _RANDOM[8'h34][19];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_debug_pc = {_RANDOM[8'h34][31:20], _RANDOM[8'h35][27:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_4_ctrl_br_type = _RANDOM[8'h36][12:9];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_ctrl_op1_sel = _RANDOM[8'h36][14:13];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_ctrl_op2_sel = _RANDOM[8'h36][17:15];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_ctrl_imm_sel = _RANDOM[8'h36][20:18];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_ctrl_op_fcn = _RANDOM[8'h36][24:21];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_ctrl_fcn_dw = _RANDOM[8'h36][25];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_ctrl_csr_cmd = _RANDOM[8'h36][28:26];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_ctrl_is_load = _RANDOM[8'h36][29];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_ctrl_is_sta = _RANDOM[8'h36][30];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_ctrl_is_std = _RANDOM[8'h36][31];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_iw_state = _RANDOM[8'h37][1:0];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_iw_p1_poisoned = _RANDOM[8'h37][2];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_iw_p2_poisoned = _RANDOM[8'h37][3];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_is_sfb = _RANDOM[8'h37][7];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_ftq_idx = _RANDOM[8'h37][28:24];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_edge_inst = _RANDOM[8'h37][29];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_pc_lob = {_RANDOM[8'h37][31:30], _RANDOM[8'h38][3:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_4_taken = _RANDOM[8'h38][4];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_csr_addr = {_RANDOM[8'h38][31:25], _RANDOM[8'h39][4:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_4_rxq_idx = _RANDOM[8'h39][20:19];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_xcpt_pf_if = _RANDOM[8'h3E][22];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_xcpt_ae_if = _RANDOM[8'h3E][23];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_xcpt_ma_if = _RANDOM[8'h3E][24];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_bp_debug_if = _RANDOM[8'h3E][25];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_bp_xcpt_if = _RANDOM[8'h3E][26];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_debug_fsrc = _RANDOM[8'h3E][28:27];	// fetch-buffer.scala:57:16
        fb_uop_ram_4_debug_tsrc = _RANDOM[8'h3E][30:29];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_inst = {_RANDOM[8'h3F][31:6], _RANDOM[8'h40][5:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_5_debug_inst = {_RANDOM[8'h40][31:6], _RANDOM[8'h41][5:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_5_is_rvc = _RANDOM[8'h41][6];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_debug_pc = {_RANDOM[8'h41][31:7], _RANDOM[8'h42][14:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_5_ctrl_br_type = _RANDOM[8'h42][31:28];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_ctrl_op1_sel = _RANDOM[8'h43][1:0];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_ctrl_op2_sel = _RANDOM[8'h43][4:2];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_ctrl_imm_sel = _RANDOM[8'h43][7:5];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_ctrl_op_fcn = _RANDOM[8'h43][11:8];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_ctrl_fcn_dw = _RANDOM[8'h43][12];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_ctrl_csr_cmd = _RANDOM[8'h43][15:13];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_ctrl_is_load = _RANDOM[8'h43][16];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_ctrl_is_sta = _RANDOM[8'h43][17];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_ctrl_is_std = _RANDOM[8'h43][18];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_iw_state = _RANDOM[8'h43][20:19];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_iw_p1_poisoned = _RANDOM[8'h43][21];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_iw_p2_poisoned = _RANDOM[8'h43][22];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_is_sfb = _RANDOM[8'h43][26];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_ftq_idx = _RANDOM[8'h44][15:11];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_edge_inst = _RANDOM[8'h44][16];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_pc_lob = _RANDOM[8'h44][22:17];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_taken = _RANDOM[8'h44][23];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_csr_addr = _RANDOM[8'h45][23:12];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_rxq_idx = _RANDOM[8'h46][7:6];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_xcpt_pf_if = _RANDOM[8'h4B][9];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_xcpt_ae_if = _RANDOM[8'h4B][10];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_xcpt_ma_if = _RANDOM[8'h4B][11];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_bp_debug_if = _RANDOM[8'h4B][12];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_bp_xcpt_if = _RANDOM[8'h4B][13];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_debug_fsrc = _RANDOM[8'h4B][15:14];	// fetch-buffer.scala:57:16
        fb_uop_ram_5_debug_tsrc = _RANDOM[8'h4B][17:16];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_inst = {_RANDOM[8'h4B][31:25], _RANDOM[8'h4C][24:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_6_debug_inst = {_RANDOM[8'h4C][31:25], _RANDOM[8'h4D][24:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_6_is_rvc = _RANDOM[8'h4D][25];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_debug_pc =
          {_RANDOM[8'h4D][31:26], _RANDOM[8'h4E], _RANDOM[8'h4F][1:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_6_ctrl_br_type = _RANDOM[8'h4F][18:15];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_ctrl_op1_sel = _RANDOM[8'h4F][20:19];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_ctrl_op2_sel = _RANDOM[8'h4F][23:21];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_ctrl_imm_sel = _RANDOM[8'h4F][26:24];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_ctrl_op_fcn = _RANDOM[8'h4F][30:27];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_ctrl_fcn_dw = _RANDOM[8'h4F][31];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_ctrl_csr_cmd = _RANDOM[8'h50][2:0];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_ctrl_is_load = _RANDOM[8'h50][3];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_ctrl_is_sta = _RANDOM[8'h50][4];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_ctrl_is_std = _RANDOM[8'h50][5];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_iw_state = _RANDOM[8'h50][7:6];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_iw_p1_poisoned = _RANDOM[8'h50][8];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_iw_p2_poisoned = _RANDOM[8'h50][9];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_is_sfb = _RANDOM[8'h50][13];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_ftq_idx = {_RANDOM[8'h50][31:30], _RANDOM[8'h51][2:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_6_edge_inst = _RANDOM[8'h51][3];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_pc_lob = _RANDOM[8'h51][9:4];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_taken = _RANDOM[8'h51][10];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_csr_addr = {_RANDOM[8'h51][31], _RANDOM[8'h52][10:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_6_rxq_idx = _RANDOM[8'h52][26:25];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_xcpt_pf_if = _RANDOM[8'h57][28];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_xcpt_ae_if = _RANDOM[8'h57][29];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_xcpt_ma_if = _RANDOM[8'h57][30];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_bp_debug_if = _RANDOM[8'h57][31];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_bp_xcpt_if = _RANDOM[8'h58][0];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_debug_fsrc = _RANDOM[8'h58][2:1];	// fetch-buffer.scala:57:16
        fb_uop_ram_6_debug_tsrc = _RANDOM[8'h58][4:3];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_inst = {_RANDOM[8'h58][31:12], _RANDOM[8'h59][11:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_7_debug_inst = {_RANDOM[8'h59][31:12], _RANDOM[8'h5A][11:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_7_is_rvc = _RANDOM[8'h5A][12];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_debug_pc = {_RANDOM[8'h5A][31:13], _RANDOM[8'h5B][20:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_7_ctrl_br_type = _RANDOM[8'h5C][5:2];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_ctrl_op1_sel = _RANDOM[8'h5C][7:6];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_ctrl_op2_sel = _RANDOM[8'h5C][10:8];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_ctrl_imm_sel = _RANDOM[8'h5C][13:11];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_ctrl_op_fcn = _RANDOM[8'h5C][17:14];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_ctrl_fcn_dw = _RANDOM[8'h5C][18];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_ctrl_csr_cmd = _RANDOM[8'h5C][21:19];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_ctrl_is_load = _RANDOM[8'h5C][22];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_ctrl_is_sta = _RANDOM[8'h5C][23];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_ctrl_is_std = _RANDOM[8'h5C][24];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_iw_state = _RANDOM[8'h5C][26:25];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_iw_p1_poisoned = _RANDOM[8'h5C][27];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_iw_p2_poisoned = _RANDOM[8'h5C][28];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_is_sfb = _RANDOM[8'h5D][0];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_ftq_idx = _RANDOM[8'h5D][21:17];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_edge_inst = _RANDOM[8'h5D][22];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_pc_lob = _RANDOM[8'h5D][28:23];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_taken = _RANDOM[8'h5D][29];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_csr_addr = _RANDOM[8'h5E][29:18];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_rxq_idx = _RANDOM[8'h5F][13:12];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_xcpt_pf_if = _RANDOM[8'h64][15];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_xcpt_ae_if = _RANDOM[8'h64][16];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_xcpt_ma_if = _RANDOM[8'h64][17];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_bp_debug_if = _RANDOM[8'h64][18];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_bp_xcpt_if = _RANDOM[8'h64][19];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_debug_fsrc = _RANDOM[8'h64][21:20];	// fetch-buffer.scala:57:16
        fb_uop_ram_7_debug_tsrc = _RANDOM[8'h64][23:22];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_inst = {_RANDOM[8'h64][31], _RANDOM[8'h65][30:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_8_debug_inst = {_RANDOM[8'h65][31], _RANDOM[8'h66][30:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_8_is_rvc = _RANDOM[8'h66][31];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_debug_pc = {_RANDOM[8'h67], _RANDOM[8'h68][7:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_8_ctrl_br_type = _RANDOM[8'h68][24:21];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_ctrl_op1_sel = _RANDOM[8'h68][26:25];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_ctrl_op2_sel = _RANDOM[8'h68][29:27];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_ctrl_imm_sel = {_RANDOM[8'h68][31:30], _RANDOM[8'h69][0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_8_ctrl_op_fcn = _RANDOM[8'h69][4:1];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_ctrl_fcn_dw = _RANDOM[8'h69][5];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_ctrl_csr_cmd = _RANDOM[8'h69][8:6];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_ctrl_is_load = _RANDOM[8'h69][9];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_ctrl_is_sta = _RANDOM[8'h69][10];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_ctrl_is_std = _RANDOM[8'h69][11];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_iw_state = _RANDOM[8'h69][13:12];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_iw_p1_poisoned = _RANDOM[8'h69][14];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_iw_p2_poisoned = _RANDOM[8'h69][15];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_is_sfb = _RANDOM[8'h69][19];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_ftq_idx = _RANDOM[8'h6A][8:4];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_edge_inst = _RANDOM[8'h6A][9];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_pc_lob = _RANDOM[8'h6A][15:10];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_taken = _RANDOM[8'h6A][16];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_csr_addr = _RANDOM[8'h6B][16:5];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_rxq_idx = {_RANDOM[8'h6B][31], _RANDOM[8'h6C][0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_8_xcpt_pf_if = _RANDOM[8'h71][2];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_xcpt_ae_if = _RANDOM[8'h71][3];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_xcpt_ma_if = _RANDOM[8'h71][4];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_bp_debug_if = _RANDOM[8'h71][5];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_bp_xcpt_if = _RANDOM[8'h71][6];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_debug_fsrc = _RANDOM[8'h71][8:7];	// fetch-buffer.scala:57:16
        fb_uop_ram_8_debug_tsrc = _RANDOM[8'h71][10:9];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_inst = {_RANDOM[8'h71][31:18], _RANDOM[8'h72][17:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_9_debug_inst = {_RANDOM[8'h72][31:18], _RANDOM[8'h73][17:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_9_is_rvc = _RANDOM[8'h73][18];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_debug_pc = {_RANDOM[8'h73][31:19], _RANDOM[8'h74][26:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_9_ctrl_br_type = _RANDOM[8'h75][11:8];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_ctrl_op1_sel = _RANDOM[8'h75][13:12];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_ctrl_op2_sel = _RANDOM[8'h75][16:14];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_ctrl_imm_sel = _RANDOM[8'h75][19:17];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_ctrl_op_fcn = _RANDOM[8'h75][23:20];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_ctrl_fcn_dw = _RANDOM[8'h75][24];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_ctrl_csr_cmd = _RANDOM[8'h75][27:25];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_ctrl_is_load = _RANDOM[8'h75][28];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_ctrl_is_sta = _RANDOM[8'h75][29];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_ctrl_is_std = _RANDOM[8'h75][30];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_iw_state = {_RANDOM[8'h75][31], _RANDOM[8'h76][0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_9_iw_p1_poisoned = _RANDOM[8'h76][1];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_iw_p2_poisoned = _RANDOM[8'h76][2];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_is_sfb = _RANDOM[8'h76][6];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_ftq_idx = _RANDOM[8'h76][27:23];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_edge_inst = _RANDOM[8'h76][28];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_pc_lob = {_RANDOM[8'h76][31:29], _RANDOM[8'h77][2:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_9_taken = _RANDOM[8'h77][3];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_csr_addr = {_RANDOM[8'h77][31:24], _RANDOM[8'h78][3:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_9_rxq_idx = _RANDOM[8'h78][19:18];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_xcpt_pf_if = _RANDOM[8'h7D][21];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_xcpt_ae_if = _RANDOM[8'h7D][22];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_xcpt_ma_if = _RANDOM[8'h7D][23];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_bp_debug_if = _RANDOM[8'h7D][24];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_bp_xcpt_if = _RANDOM[8'h7D][25];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_debug_fsrc = _RANDOM[8'h7D][27:26];	// fetch-buffer.scala:57:16
        fb_uop_ram_9_debug_tsrc = _RANDOM[8'h7D][29:28];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_inst = {_RANDOM[8'h7E][31:5], _RANDOM[8'h7F][4:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_10_debug_inst = {_RANDOM[8'h7F][31:5], _RANDOM[8'h80][4:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_10_is_rvc = _RANDOM[8'h80][5];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_debug_pc = {_RANDOM[8'h80][31:6], _RANDOM[8'h81][13:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_10_ctrl_br_type = _RANDOM[8'h81][30:27];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_ctrl_op1_sel = {_RANDOM[8'h81][31], _RANDOM[8'h82][0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_10_ctrl_op2_sel = _RANDOM[8'h82][3:1];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_ctrl_imm_sel = _RANDOM[8'h82][6:4];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_ctrl_op_fcn = _RANDOM[8'h82][10:7];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_ctrl_fcn_dw = _RANDOM[8'h82][11];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_ctrl_csr_cmd = _RANDOM[8'h82][14:12];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_ctrl_is_load = _RANDOM[8'h82][15];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_ctrl_is_sta = _RANDOM[8'h82][16];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_ctrl_is_std = _RANDOM[8'h82][17];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_iw_state = _RANDOM[8'h82][19:18];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_iw_p1_poisoned = _RANDOM[8'h82][20];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_iw_p2_poisoned = _RANDOM[8'h82][21];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_is_sfb = _RANDOM[8'h82][25];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_ftq_idx = _RANDOM[8'h83][14:10];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_edge_inst = _RANDOM[8'h83][15];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_pc_lob = _RANDOM[8'h83][21:16];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_taken = _RANDOM[8'h83][22];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_csr_addr = _RANDOM[8'h84][22:11];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_rxq_idx = _RANDOM[8'h85][6:5];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_xcpt_pf_if = _RANDOM[8'h8A][8];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_xcpt_ae_if = _RANDOM[8'h8A][9];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_xcpt_ma_if = _RANDOM[8'h8A][10];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_bp_debug_if = _RANDOM[8'h8A][11];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_bp_xcpt_if = _RANDOM[8'h8A][12];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_debug_fsrc = _RANDOM[8'h8A][14:13];	// fetch-buffer.scala:57:16
        fb_uop_ram_10_debug_tsrc = _RANDOM[8'h8A][16:15];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_inst = {_RANDOM[8'h8A][31:24], _RANDOM[8'h8B][23:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_11_debug_inst = {_RANDOM[8'h8B][31:24], _RANDOM[8'h8C][23:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_11_is_rvc = _RANDOM[8'h8C][24];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_debug_pc =
          {_RANDOM[8'h8C][31:25], _RANDOM[8'h8D], _RANDOM[8'h8E][0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_11_ctrl_br_type = _RANDOM[8'h8E][17:14];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_ctrl_op1_sel = _RANDOM[8'h8E][19:18];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_ctrl_op2_sel = _RANDOM[8'h8E][22:20];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_ctrl_imm_sel = _RANDOM[8'h8E][25:23];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_ctrl_op_fcn = _RANDOM[8'h8E][29:26];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_ctrl_fcn_dw = _RANDOM[8'h8E][30];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_ctrl_csr_cmd = {_RANDOM[8'h8E][31], _RANDOM[8'h8F][1:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_11_ctrl_is_load = _RANDOM[8'h8F][2];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_ctrl_is_sta = _RANDOM[8'h8F][3];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_ctrl_is_std = _RANDOM[8'h8F][4];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_iw_state = _RANDOM[8'h8F][6:5];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_iw_p1_poisoned = _RANDOM[8'h8F][7];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_iw_p2_poisoned = _RANDOM[8'h8F][8];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_is_sfb = _RANDOM[8'h8F][12];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_ftq_idx = {_RANDOM[8'h8F][31:29], _RANDOM[8'h90][1:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_11_edge_inst = _RANDOM[8'h90][2];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_pc_lob = _RANDOM[8'h90][8:3];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_taken = _RANDOM[8'h90][9];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_csr_addr = {_RANDOM[8'h90][31:30], _RANDOM[8'h91][9:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_11_rxq_idx = _RANDOM[8'h91][25:24];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_xcpt_pf_if = _RANDOM[8'h96][27];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_xcpt_ae_if = _RANDOM[8'h96][28];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_xcpt_ma_if = _RANDOM[8'h96][29];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_bp_debug_if = _RANDOM[8'h96][30];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_bp_xcpt_if = _RANDOM[8'h96][31];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_debug_fsrc = _RANDOM[8'h97][1:0];	// fetch-buffer.scala:57:16
        fb_uop_ram_11_debug_tsrc = _RANDOM[8'h97][3:2];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_inst = {_RANDOM[8'h97][31:11], _RANDOM[8'h98][10:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_12_debug_inst = {_RANDOM[8'h98][31:11], _RANDOM[8'h99][10:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_12_is_rvc = _RANDOM[8'h99][11];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_debug_pc = {_RANDOM[8'h99][31:12], _RANDOM[8'h9A][19:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_12_ctrl_br_type = _RANDOM[8'h9B][4:1];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_ctrl_op1_sel = _RANDOM[8'h9B][6:5];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_ctrl_op2_sel = _RANDOM[8'h9B][9:7];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_ctrl_imm_sel = _RANDOM[8'h9B][12:10];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_ctrl_op_fcn = _RANDOM[8'h9B][16:13];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_ctrl_fcn_dw = _RANDOM[8'h9B][17];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_ctrl_csr_cmd = _RANDOM[8'h9B][20:18];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_ctrl_is_load = _RANDOM[8'h9B][21];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_ctrl_is_sta = _RANDOM[8'h9B][22];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_ctrl_is_std = _RANDOM[8'h9B][23];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_iw_state = _RANDOM[8'h9B][25:24];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_iw_p1_poisoned = _RANDOM[8'h9B][26];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_iw_p2_poisoned = _RANDOM[8'h9B][27];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_is_sfb = _RANDOM[8'h9B][31];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_ftq_idx = _RANDOM[8'h9C][20:16];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_edge_inst = _RANDOM[8'h9C][21];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_pc_lob = _RANDOM[8'h9C][27:22];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_taken = _RANDOM[8'h9C][28];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_csr_addr = _RANDOM[8'h9D][28:17];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_rxq_idx = _RANDOM[8'h9E][12:11];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_xcpt_pf_if = _RANDOM[8'hA3][14];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_xcpt_ae_if = _RANDOM[8'hA3][15];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_xcpt_ma_if = _RANDOM[8'hA3][16];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_bp_debug_if = _RANDOM[8'hA3][17];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_bp_xcpt_if = _RANDOM[8'hA3][18];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_debug_fsrc = _RANDOM[8'hA3][20:19];	// fetch-buffer.scala:57:16
        fb_uop_ram_12_debug_tsrc = _RANDOM[8'hA3][22:21];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_inst = {_RANDOM[8'hA3][31:30], _RANDOM[8'hA4][29:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_13_debug_inst = {_RANDOM[8'hA4][31:30], _RANDOM[8'hA5][29:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_13_is_rvc = _RANDOM[8'hA5][30];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_debug_pc =
          {_RANDOM[8'hA5][31], _RANDOM[8'hA6], _RANDOM[8'hA7][6:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_13_ctrl_br_type = _RANDOM[8'hA7][23:20];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_ctrl_op1_sel = _RANDOM[8'hA7][25:24];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_ctrl_op2_sel = _RANDOM[8'hA7][28:26];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_ctrl_imm_sel = _RANDOM[8'hA7][31:29];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_ctrl_op_fcn = _RANDOM[8'hA8][3:0];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_ctrl_fcn_dw = _RANDOM[8'hA8][4];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_ctrl_csr_cmd = _RANDOM[8'hA8][7:5];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_ctrl_is_load = _RANDOM[8'hA8][8];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_ctrl_is_sta = _RANDOM[8'hA8][9];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_ctrl_is_std = _RANDOM[8'hA8][10];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_iw_state = _RANDOM[8'hA8][12:11];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_iw_p1_poisoned = _RANDOM[8'hA8][13];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_iw_p2_poisoned = _RANDOM[8'hA8][14];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_is_sfb = _RANDOM[8'hA8][18];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_ftq_idx = _RANDOM[8'hA9][7:3];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_edge_inst = _RANDOM[8'hA9][8];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_pc_lob = _RANDOM[8'hA9][14:9];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_taken = _RANDOM[8'hA9][15];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_csr_addr = _RANDOM[8'hAA][15:4];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_rxq_idx = _RANDOM[8'hAA][31:30];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_xcpt_pf_if = _RANDOM[8'hB0][1];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_xcpt_ae_if = _RANDOM[8'hB0][2];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_xcpt_ma_if = _RANDOM[8'hB0][3];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_bp_debug_if = _RANDOM[8'hB0][4];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_bp_xcpt_if = _RANDOM[8'hB0][5];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_debug_fsrc = _RANDOM[8'hB0][7:6];	// fetch-buffer.scala:57:16
        fb_uop_ram_13_debug_tsrc = _RANDOM[8'hB0][9:8];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_inst = {_RANDOM[8'hB0][31:17], _RANDOM[8'hB1][16:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_14_debug_inst = {_RANDOM[8'hB1][31:17], _RANDOM[8'hB2][16:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_14_is_rvc = _RANDOM[8'hB2][17];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_debug_pc = {_RANDOM[8'hB2][31:18], _RANDOM[8'hB3][25:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_14_ctrl_br_type = _RANDOM[8'hB4][10:7];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_ctrl_op1_sel = _RANDOM[8'hB4][12:11];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_ctrl_op2_sel = _RANDOM[8'hB4][15:13];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_ctrl_imm_sel = _RANDOM[8'hB4][18:16];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_ctrl_op_fcn = _RANDOM[8'hB4][22:19];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_ctrl_fcn_dw = _RANDOM[8'hB4][23];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_ctrl_csr_cmd = _RANDOM[8'hB4][26:24];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_ctrl_is_load = _RANDOM[8'hB4][27];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_ctrl_is_sta = _RANDOM[8'hB4][28];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_ctrl_is_std = _RANDOM[8'hB4][29];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_iw_state = _RANDOM[8'hB4][31:30];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_iw_p1_poisoned = _RANDOM[8'hB5][0];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_iw_p2_poisoned = _RANDOM[8'hB5][1];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_is_sfb = _RANDOM[8'hB5][5];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_ftq_idx = _RANDOM[8'hB5][26:22];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_edge_inst = _RANDOM[8'hB5][27];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_pc_lob = {_RANDOM[8'hB5][31:28], _RANDOM[8'hB6][1:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_14_taken = _RANDOM[8'hB6][2];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_csr_addr = {_RANDOM[8'hB6][31:23], _RANDOM[8'hB7][2:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_14_rxq_idx = _RANDOM[8'hB7][18:17];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_xcpt_pf_if = _RANDOM[8'hBC][20];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_xcpt_ae_if = _RANDOM[8'hBC][21];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_xcpt_ma_if = _RANDOM[8'hBC][22];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_bp_debug_if = _RANDOM[8'hBC][23];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_bp_xcpt_if = _RANDOM[8'hBC][24];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_debug_fsrc = _RANDOM[8'hBC][26:25];	// fetch-buffer.scala:57:16
        fb_uop_ram_14_debug_tsrc = _RANDOM[8'hBC][28:27];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_inst = {_RANDOM[8'hBD][31:4], _RANDOM[8'hBE][3:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_15_debug_inst = {_RANDOM[8'hBE][31:4], _RANDOM[8'hBF][3:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_15_is_rvc = _RANDOM[8'hBF][4];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_debug_pc = {_RANDOM[8'hBF][31:5], _RANDOM[8'hC0][12:0]};	// fetch-buffer.scala:57:16
        fb_uop_ram_15_ctrl_br_type = _RANDOM[8'hC0][29:26];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_ctrl_op1_sel = _RANDOM[8'hC0][31:30];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_ctrl_op2_sel = _RANDOM[8'hC1][2:0];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_ctrl_imm_sel = _RANDOM[8'hC1][5:3];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_ctrl_op_fcn = _RANDOM[8'hC1][9:6];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_ctrl_fcn_dw = _RANDOM[8'hC1][10];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_ctrl_csr_cmd = _RANDOM[8'hC1][13:11];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_ctrl_is_load = _RANDOM[8'hC1][14];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_ctrl_is_sta = _RANDOM[8'hC1][15];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_ctrl_is_std = _RANDOM[8'hC1][16];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_iw_state = _RANDOM[8'hC1][18:17];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_iw_p1_poisoned = _RANDOM[8'hC1][19];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_iw_p2_poisoned = _RANDOM[8'hC1][20];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_is_sfb = _RANDOM[8'hC1][24];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_ftq_idx = _RANDOM[8'hC2][13:9];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_edge_inst = _RANDOM[8'hC2][14];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_pc_lob = _RANDOM[8'hC2][20:15];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_taken = _RANDOM[8'hC2][21];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_csr_addr = _RANDOM[8'hC3][21:10];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_rxq_idx = _RANDOM[8'hC4][5:4];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_xcpt_pf_if = _RANDOM[8'hC9][7];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_xcpt_ae_if = _RANDOM[8'hC9][8];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_xcpt_ma_if = _RANDOM[8'hC9][9];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_bp_debug_if = _RANDOM[8'hC9][10];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_bp_xcpt_if = _RANDOM[8'hC9][11];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_debug_fsrc = _RANDOM[8'hC9][13:12];	// fetch-buffer.scala:57:16
        fb_uop_ram_15_debug_tsrc = _RANDOM[8'hC9][15:14];	// fetch-buffer.scala:57:16
        head = _RANDOM[8'hC9][23:16];	// fetch-buffer.scala:57:16, :61:21
        tail = {_RANDOM[8'hC9][31:24], _RANDOM[8'hCA][7:0]};	// fetch-buffer.scala:57:16, :62:21
        maybe_full = _RANDOM[8'hCA][8];	// fetch-buffer.scala:62:21, :64:27
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_enq_ready = ~_do_enq_T_1;	// fetch-buffer.scala:82:{16,40}
  assign io_deq_valid = _deq_valids_T_4 != 2'h3;	// fetch-buffer.scala:115:62, :170:38, util.scala:384:54
  assign io_deq_bits_uops_0_valid = ~reset & _deq_valids_T_5[0];	// fetch-buffer.scala:161:{21,53}, :168:72, :195:23, :196:41
  assign io_deq_bits_uops_0_bits_inst =
    (head[0] ? fb_uop_ram_0_inst : 32'h0) | (head[1] ? fb_uop_ram_2_inst : 32'h0)
    | (head[2] ? fb_uop_ram_4_inst : 32'h0) | (head[3] ? fb_uop_ram_6_inst : 32'h0)
    | (head[4] ? fb_uop_ram_8_inst : 32'h0) | (head[5] ? fb_uop_ram_10_inst : 32'h0)
    | (head[6] ? fb_uop_ram_12_inst : 32'h0) | (head[7] ? fb_uop_ram_14_inst : 32'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_0_bits_debug_inst =
    (head[0] ? fb_uop_ram_0_debug_inst : 32'h0)
    | (head[1] ? fb_uop_ram_2_debug_inst : 32'h0)
    | (head[2] ? fb_uop_ram_4_debug_inst : 32'h0)
    | (head[3] ? fb_uop_ram_6_debug_inst : 32'h0)
    | (head[4] ? fb_uop_ram_8_debug_inst : 32'h0)
    | (head[5] ? fb_uop_ram_10_debug_inst : 32'h0)
    | (head[6] ? fb_uop_ram_12_debug_inst : 32'h0)
    | (head[7] ? fb_uop_ram_14_debug_inst : 32'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_0_bits_is_rvc =
    head[0] & fb_uop_ram_0_is_rvc | head[1] & fb_uop_ram_2_is_rvc | head[2]
    & fb_uop_ram_4_is_rvc | head[3] & fb_uop_ram_6_is_rvc | head[4] & fb_uop_ram_8_is_rvc
    | head[5] & fb_uop_ram_10_is_rvc | head[6] & fb_uop_ram_12_is_rvc | head[7]
    & fb_uop_ram_14_is_rvc;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_0_bits_debug_pc =
    (head[0] ? fb_uop_ram_0_debug_pc : 40'h0) | (head[1] ? fb_uop_ram_2_debug_pc : 40'h0)
    | (head[2] ? fb_uop_ram_4_debug_pc : 40'h0)
    | (head[3] ? fb_uop_ram_6_debug_pc : 40'h0)
    | (head[4] ? fb_uop_ram_8_debug_pc : 40'h0)
    | (head[5] ? fb_uop_ram_10_debug_pc : 40'h0)
    | (head[6] ? fb_uop_ram_12_debug_pc : 40'h0)
    | (head[7] ? fb_uop_ram_14_debug_pc : 40'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_0_bits_ctrl_br_type =
    (head[0] ? fb_uop_ram_0_ctrl_br_type : 4'h0)
    | (head[1] ? fb_uop_ram_2_ctrl_br_type : 4'h0)
    | (head[2] ? fb_uop_ram_4_ctrl_br_type : 4'h0)
    | (head[3] ? fb_uop_ram_6_ctrl_br_type : 4'h0)
    | (head[4] ? fb_uop_ram_8_ctrl_br_type : 4'h0)
    | (head[5] ? fb_uop_ram_10_ctrl_br_type : 4'h0)
    | (head[6] ? fb_uop_ram_12_ctrl_br_type : 4'h0)
    | (head[7] ? fb_uop_ram_14_ctrl_br_type : 4'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_0_bits_ctrl_op1_sel =
    (head[0] ? fb_uop_ram_0_ctrl_op1_sel : 2'h0)
    | (head[1] ? fb_uop_ram_2_ctrl_op1_sel : 2'h0)
    | (head[2] ? fb_uop_ram_4_ctrl_op1_sel : 2'h0)
    | (head[3] ? fb_uop_ram_6_ctrl_op1_sel : 2'h0)
    | (head[4] ? fb_uop_ram_8_ctrl_op1_sel : 2'h0)
    | (head[5] ? fb_uop_ram_10_ctrl_op1_sel : 2'h0)
    | (head[6] ? fb_uop_ram_12_ctrl_op1_sel : 2'h0)
    | (head[7] ? fb_uop_ram_14_ctrl_op1_sel : 2'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_0_bits_ctrl_op2_sel =
    (head[0] ? fb_uop_ram_0_ctrl_op2_sel : 3'h0)
    | (head[1] ? fb_uop_ram_2_ctrl_op2_sel : 3'h0)
    | (head[2] ? fb_uop_ram_4_ctrl_op2_sel : 3'h0)
    | (head[3] ? fb_uop_ram_6_ctrl_op2_sel : 3'h0)
    | (head[4] ? fb_uop_ram_8_ctrl_op2_sel : 3'h0)
    | (head[5] ? fb_uop_ram_10_ctrl_op2_sel : 3'h0)
    | (head[6] ? fb_uop_ram_12_ctrl_op2_sel : 3'h0)
    | (head[7] ? fb_uop_ram_14_ctrl_op2_sel : 3'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_0_bits_ctrl_imm_sel =
    (head[0] ? fb_uop_ram_0_ctrl_imm_sel : 3'h0)
    | (head[1] ? fb_uop_ram_2_ctrl_imm_sel : 3'h0)
    | (head[2] ? fb_uop_ram_4_ctrl_imm_sel : 3'h0)
    | (head[3] ? fb_uop_ram_6_ctrl_imm_sel : 3'h0)
    | (head[4] ? fb_uop_ram_8_ctrl_imm_sel : 3'h0)
    | (head[5] ? fb_uop_ram_10_ctrl_imm_sel : 3'h0)
    | (head[6] ? fb_uop_ram_12_ctrl_imm_sel : 3'h0)
    | (head[7] ? fb_uop_ram_14_ctrl_imm_sel : 3'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_0_bits_ctrl_op_fcn =
    (head[0] ? fb_uop_ram_0_ctrl_op_fcn : 4'h0)
    | (head[1] ? fb_uop_ram_2_ctrl_op_fcn : 4'h0)
    | (head[2] ? fb_uop_ram_4_ctrl_op_fcn : 4'h0)
    | (head[3] ? fb_uop_ram_6_ctrl_op_fcn : 4'h0)
    | (head[4] ? fb_uop_ram_8_ctrl_op_fcn : 4'h0)
    | (head[5] ? fb_uop_ram_10_ctrl_op_fcn : 4'h0)
    | (head[6] ? fb_uop_ram_12_ctrl_op_fcn : 4'h0)
    | (head[7] ? fb_uop_ram_14_ctrl_op_fcn : 4'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_0_bits_ctrl_fcn_dw =
    head[0] & fb_uop_ram_0_ctrl_fcn_dw | head[1] & fb_uop_ram_2_ctrl_fcn_dw | head[2]
    & fb_uop_ram_4_ctrl_fcn_dw | head[3] & fb_uop_ram_6_ctrl_fcn_dw | head[4]
    & fb_uop_ram_8_ctrl_fcn_dw | head[5] & fb_uop_ram_10_ctrl_fcn_dw | head[6]
    & fb_uop_ram_12_ctrl_fcn_dw | head[7] & fb_uop_ram_14_ctrl_fcn_dw;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_0_bits_ctrl_csr_cmd =
    (head[0] ? fb_uop_ram_0_ctrl_csr_cmd : 3'h0)
    | (head[1] ? fb_uop_ram_2_ctrl_csr_cmd : 3'h0)
    | (head[2] ? fb_uop_ram_4_ctrl_csr_cmd : 3'h0)
    | (head[3] ? fb_uop_ram_6_ctrl_csr_cmd : 3'h0)
    | (head[4] ? fb_uop_ram_8_ctrl_csr_cmd : 3'h0)
    | (head[5] ? fb_uop_ram_10_ctrl_csr_cmd : 3'h0)
    | (head[6] ? fb_uop_ram_12_ctrl_csr_cmd : 3'h0)
    | (head[7] ? fb_uop_ram_14_ctrl_csr_cmd : 3'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_0_bits_ctrl_is_load =
    head[0] & fb_uop_ram_0_ctrl_is_load | head[1] & fb_uop_ram_2_ctrl_is_load | head[2]
    & fb_uop_ram_4_ctrl_is_load | head[3] & fb_uop_ram_6_ctrl_is_load | head[4]
    & fb_uop_ram_8_ctrl_is_load | head[5] & fb_uop_ram_10_ctrl_is_load | head[6]
    & fb_uop_ram_12_ctrl_is_load | head[7] & fb_uop_ram_14_ctrl_is_load;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_0_bits_ctrl_is_sta =
    head[0] & fb_uop_ram_0_ctrl_is_sta | head[1] & fb_uop_ram_2_ctrl_is_sta | head[2]
    & fb_uop_ram_4_ctrl_is_sta | head[3] & fb_uop_ram_6_ctrl_is_sta | head[4]
    & fb_uop_ram_8_ctrl_is_sta | head[5] & fb_uop_ram_10_ctrl_is_sta | head[6]
    & fb_uop_ram_12_ctrl_is_sta | head[7] & fb_uop_ram_14_ctrl_is_sta;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_0_bits_ctrl_is_std =
    head[0] & fb_uop_ram_0_ctrl_is_std | head[1] & fb_uop_ram_2_ctrl_is_std | head[2]
    & fb_uop_ram_4_ctrl_is_std | head[3] & fb_uop_ram_6_ctrl_is_std | head[4]
    & fb_uop_ram_8_ctrl_is_std | head[5] & fb_uop_ram_10_ctrl_is_std | head[6]
    & fb_uop_ram_12_ctrl_is_std | head[7] & fb_uop_ram_14_ctrl_is_std;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_0_bits_iw_state =
    (head[0] ? fb_uop_ram_0_iw_state : 2'h0) | (head[1] ? fb_uop_ram_2_iw_state : 2'h0)
    | (head[2] ? fb_uop_ram_4_iw_state : 2'h0) | (head[3] ? fb_uop_ram_6_iw_state : 2'h0)
    | (head[4] ? fb_uop_ram_8_iw_state : 2'h0) | (head[5] ? fb_uop_ram_10_iw_state : 2'h0)
    | (head[6] ? fb_uop_ram_12_iw_state : 2'h0)
    | (head[7] ? fb_uop_ram_14_iw_state : 2'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_0_bits_iw_p1_poisoned =
    head[0] & fb_uop_ram_0_iw_p1_poisoned | head[1] & fb_uop_ram_2_iw_p1_poisoned
    | head[2] & fb_uop_ram_4_iw_p1_poisoned | head[3] & fb_uop_ram_6_iw_p1_poisoned
    | head[4] & fb_uop_ram_8_iw_p1_poisoned | head[5] & fb_uop_ram_10_iw_p1_poisoned
    | head[6] & fb_uop_ram_12_iw_p1_poisoned | head[7] & fb_uop_ram_14_iw_p1_poisoned;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_0_bits_iw_p2_poisoned =
    head[0] & fb_uop_ram_0_iw_p2_poisoned | head[1] & fb_uop_ram_2_iw_p2_poisoned
    | head[2] & fb_uop_ram_4_iw_p2_poisoned | head[3] & fb_uop_ram_6_iw_p2_poisoned
    | head[4] & fb_uop_ram_8_iw_p2_poisoned | head[5] & fb_uop_ram_10_iw_p2_poisoned
    | head[6] & fb_uop_ram_12_iw_p2_poisoned | head[7] & fb_uop_ram_14_iw_p2_poisoned;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_0_bits_is_sfb =
    head[0] & fb_uop_ram_0_is_sfb | head[1] & fb_uop_ram_2_is_sfb | head[2]
    & fb_uop_ram_4_is_sfb | head[3] & fb_uop_ram_6_is_sfb | head[4] & fb_uop_ram_8_is_sfb
    | head[5] & fb_uop_ram_10_is_sfb | head[6] & fb_uop_ram_12_is_sfb | head[7]
    & fb_uop_ram_14_is_sfb;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_0_bits_ftq_idx =
    (head[0] ? fb_uop_ram_0_ftq_idx : 5'h0) | (head[1] ? fb_uop_ram_2_ftq_idx : 5'h0)
    | (head[2] ? fb_uop_ram_4_ftq_idx : 5'h0) | (head[3] ? fb_uop_ram_6_ftq_idx : 5'h0)
    | (head[4] ? fb_uop_ram_8_ftq_idx : 5'h0) | (head[5] ? fb_uop_ram_10_ftq_idx : 5'h0)
    | (head[6] ? fb_uop_ram_12_ftq_idx : 5'h0) | (head[7] ? fb_uop_ram_14_ftq_idx : 5'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_0_bits_edge_inst =
    head[0] & fb_uop_ram_0_edge_inst | head[1] & fb_uop_ram_2_edge_inst | head[2]
    & fb_uop_ram_4_edge_inst | head[3] & fb_uop_ram_6_edge_inst | head[4]
    & fb_uop_ram_8_edge_inst | head[5] & fb_uop_ram_10_edge_inst | head[6]
    & fb_uop_ram_12_edge_inst | head[7] & fb_uop_ram_14_edge_inst;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_0_bits_pc_lob =
    (head[0] ? fb_uop_ram_0_pc_lob : 6'h0) | (head[1] ? fb_uop_ram_2_pc_lob : 6'h0)
    | (head[2] ? fb_uop_ram_4_pc_lob : 6'h0) | (head[3] ? fb_uop_ram_6_pc_lob : 6'h0)
    | (head[4] ? fb_uop_ram_8_pc_lob : 6'h0) | (head[5] ? fb_uop_ram_10_pc_lob : 6'h0)
    | (head[6] ? fb_uop_ram_12_pc_lob : 6'h0) | (head[7] ? fb_uop_ram_14_pc_lob : 6'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_0_bits_taken =
    head[0] & fb_uop_ram_0_taken | head[1] & fb_uop_ram_2_taken | head[2]
    & fb_uop_ram_4_taken | head[3] & fb_uop_ram_6_taken | head[4] & fb_uop_ram_8_taken
    | head[5] & fb_uop_ram_10_taken | head[6] & fb_uop_ram_12_taken | head[7]
    & fb_uop_ram_14_taken;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_0_bits_csr_addr =
    (head[0] ? fb_uop_ram_0_csr_addr : 12'h0) | (head[1] ? fb_uop_ram_2_csr_addr : 12'h0)
    | (head[2] ? fb_uop_ram_4_csr_addr : 12'h0)
    | (head[3] ? fb_uop_ram_6_csr_addr : 12'h0)
    | (head[4] ? fb_uop_ram_8_csr_addr : 12'h0)
    | (head[5] ? fb_uop_ram_10_csr_addr : 12'h0)
    | (head[6] ? fb_uop_ram_12_csr_addr : 12'h0)
    | (head[7] ? fb_uop_ram_14_csr_addr : 12'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_0_bits_rxq_idx =
    (head[0] ? fb_uop_ram_0_rxq_idx : 2'h0) | (head[1] ? fb_uop_ram_2_rxq_idx : 2'h0)
    | (head[2] ? fb_uop_ram_4_rxq_idx : 2'h0) | (head[3] ? fb_uop_ram_6_rxq_idx : 2'h0)
    | (head[4] ? fb_uop_ram_8_rxq_idx : 2'h0) | (head[5] ? fb_uop_ram_10_rxq_idx : 2'h0)
    | (head[6] ? fb_uop_ram_12_rxq_idx : 2'h0) | (head[7] ? fb_uop_ram_14_rxq_idx : 2'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_0_bits_xcpt_pf_if =
    head[0] & fb_uop_ram_0_xcpt_pf_if | head[1] & fb_uop_ram_2_xcpt_pf_if | head[2]
    & fb_uop_ram_4_xcpt_pf_if | head[3] & fb_uop_ram_6_xcpt_pf_if | head[4]
    & fb_uop_ram_8_xcpt_pf_if | head[5] & fb_uop_ram_10_xcpt_pf_if | head[6]
    & fb_uop_ram_12_xcpt_pf_if | head[7] & fb_uop_ram_14_xcpt_pf_if;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_0_bits_xcpt_ae_if =
    head[0] & fb_uop_ram_0_xcpt_ae_if | head[1] & fb_uop_ram_2_xcpt_ae_if | head[2]
    & fb_uop_ram_4_xcpt_ae_if | head[3] & fb_uop_ram_6_xcpt_ae_if | head[4]
    & fb_uop_ram_8_xcpt_ae_if | head[5] & fb_uop_ram_10_xcpt_ae_if | head[6]
    & fb_uop_ram_12_xcpt_ae_if | head[7] & fb_uop_ram_14_xcpt_ae_if;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_0_bits_xcpt_ma_if =
    head[0] & fb_uop_ram_0_xcpt_ma_if | head[1] & fb_uop_ram_2_xcpt_ma_if | head[2]
    & fb_uop_ram_4_xcpt_ma_if | head[3] & fb_uop_ram_6_xcpt_ma_if | head[4]
    & fb_uop_ram_8_xcpt_ma_if | head[5] & fb_uop_ram_10_xcpt_ma_if | head[6]
    & fb_uop_ram_12_xcpt_ma_if | head[7] & fb_uop_ram_14_xcpt_ma_if;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_0_bits_bp_debug_if =
    head[0] & fb_uop_ram_0_bp_debug_if | head[1] & fb_uop_ram_2_bp_debug_if | head[2]
    & fb_uop_ram_4_bp_debug_if | head[3] & fb_uop_ram_6_bp_debug_if | head[4]
    & fb_uop_ram_8_bp_debug_if | head[5] & fb_uop_ram_10_bp_debug_if | head[6]
    & fb_uop_ram_12_bp_debug_if | head[7] & fb_uop_ram_14_bp_debug_if;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_0_bits_bp_xcpt_if =
    head[0] & fb_uop_ram_0_bp_xcpt_if | head[1] & fb_uop_ram_2_bp_xcpt_if | head[2]
    & fb_uop_ram_4_bp_xcpt_if | head[3] & fb_uop_ram_6_bp_xcpt_if | head[4]
    & fb_uop_ram_8_bp_xcpt_if | head[5] & fb_uop_ram_10_bp_xcpt_if | head[6]
    & fb_uop_ram_12_bp_xcpt_if | head[7] & fb_uop_ram_14_bp_xcpt_if;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_0_bits_debug_fsrc =
    (head[0] ? fb_uop_ram_0_debug_fsrc : 2'h0)
    | (head[1] ? fb_uop_ram_2_debug_fsrc : 2'h0)
    | (head[2] ? fb_uop_ram_4_debug_fsrc : 2'h0)
    | (head[3] ? fb_uop_ram_6_debug_fsrc : 2'h0)
    | (head[4] ? fb_uop_ram_8_debug_fsrc : 2'h0)
    | (head[5] ? fb_uop_ram_10_debug_fsrc : 2'h0)
    | (head[6] ? fb_uop_ram_12_debug_fsrc : 2'h0)
    | (head[7] ? fb_uop_ram_14_debug_fsrc : 2'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_0_bits_debug_tsrc =
    (head[0] ? fb_uop_ram_0_debug_tsrc : 2'h0)
    | (head[1] ? fb_uop_ram_2_debug_tsrc : 2'h0)
    | (head[2] ? fb_uop_ram_4_debug_tsrc : 2'h0)
    | (head[3] ? fb_uop_ram_6_debug_tsrc : 2'h0)
    | (head[4] ? fb_uop_ram_8_debug_tsrc : 2'h0)
    | (head[5] ? fb_uop_ram_10_debug_tsrc : 2'h0)
    | (head[6] ? fb_uop_ram_12_debug_tsrc : 2'h0)
    | (head[7] ? fb_uop_ram_14_debug_tsrc : 2'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_1_valid = ~reset & _deq_valids_T_5[1];	// fetch-buffer.scala:161:{21,53}, :168:72, :195:23, :196:41
  assign io_deq_bits_uops_1_bits_inst =
    (head[0] ? fb_uop_ram_1_inst : 32'h0) | (head[1] ? fb_uop_ram_3_inst : 32'h0)
    | (head[2] ? fb_uop_ram_5_inst : 32'h0) | (head[3] ? fb_uop_ram_7_inst : 32'h0)
    | (head[4] ? fb_uop_ram_9_inst : 32'h0) | (head[5] ? fb_uop_ram_11_inst : 32'h0)
    | (head[6] ? fb_uop_ram_13_inst : 32'h0) | (head[7] ? fb_uop_ram_15_inst : 32'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_1_bits_debug_inst =
    (head[0] ? fb_uop_ram_1_debug_inst : 32'h0)
    | (head[1] ? fb_uop_ram_3_debug_inst : 32'h0)
    | (head[2] ? fb_uop_ram_5_debug_inst : 32'h0)
    | (head[3] ? fb_uop_ram_7_debug_inst : 32'h0)
    | (head[4] ? fb_uop_ram_9_debug_inst : 32'h0)
    | (head[5] ? fb_uop_ram_11_debug_inst : 32'h0)
    | (head[6] ? fb_uop_ram_13_debug_inst : 32'h0)
    | (head[7] ? fb_uop_ram_15_debug_inst : 32'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_1_bits_is_rvc =
    head[0] & fb_uop_ram_1_is_rvc | head[1] & fb_uop_ram_3_is_rvc | head[2]
    & fb_uop_ram_5_is_rvc | head[3] & fb_uop_ram_7_is_rvc | head[4] & fb_uop_ram_9_is_rvc
    | head[5] & fb_uop_ram_11_is_rvc | head[6] & fb_uop_ram_13_is_rvc | head[7]
    & fb_uop_ram_15_is_rvc;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_1_bits_debug_pc =
    (head[0] ? fb_uop_ram_1_debug_pc : 40'h0) | (head[1] ? fb_uop_ram_3_debug_pc : 40'h0)
    | (head[2] ? fb_uop_ram_5_debug_pc : 40'h0)
    | (head[3] ? fb_uop_ram_7_debug_pc : 40'h0)
    | (head[4] ? fb_uop_ram_9_debug_pc : 40'h0)
    | (head[5] ? fb_uop_ram_11_debug_pc : 40'h0)
    | (head[6] ? fb_uop_ram_13_debug_pc : 40'h0)
    | (head[7] ? fb_uop_ram_15_debug_pc : 40'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_1_bits_ctrl_br_type =
    (head[0] ? fb_uop_ram_1_ctrl_br_type : 4'h0)
    | (head[1] ? fb_uop_ram_3_ctrl_br_type : 4'h0)
    | (head[2] ? fb_uop_ram_5_ctrl_br_type : 4'h0)
    | (head[3] ? fb_uop_ram_7_ctrl_br_type : 4'h0)
    | (head[4] ? fb_uop_ram_9_ctrl_br_type : 4'h0)
    | (head[5] ? fb_uop_ram_11_ctrl_br_type : 4'h0)
    | (head[6] ? fb_uop_ram_13_ctrl_br_type : 4'h0)
    | (head[7] ? fb_uop_ram_15_ctrl_br_type : 4'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_1_bits_ctrl_op1_sel =
    (head[0] ? fb_uop_ram_1_ctrl_op1_sel : 2'h0)
    | (head[1] ? fb_uop_ram_3_ctrl_op1_sel : 2'h0)
    | (head[2] ? fb_uop_ram_5_ctrl_op1_sel : 2'h0)
    | (head[3] ? fb_uop_ram_7_ctrl_op1_sel : 2'h0)
    | (head[4] ? fb_uop_ram_9_ctrl_op1_sel : 2'h0)
    | (head[5] ? fb_uop_ram_11_ctrl_op1_sel : 2'h0)
    | (head[6] ? fb_uop_ram_13_ctrl_op1_sel : 2'h0)
    | (head[7] ? fb_uop_ram_15_ctrl_op1_sel : 2'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_1_bits_ctrl_op2_sel =
    (head[0] ? fb_uop_ram_1_ctrl_op2_sel : 3'h0)
    | (head[1] ? fb_uop_ram_3_ctrl_op2_sel : 3'h0)
    | (head[2] ? fb_uop_ram_5_ctrl_op2_sel : 3'h0)
    | (head[3] ? fb_uop_ram_7_ctrl_op2_sel : 3'h0)
    | (head[4] ? fb_uop_ram_9_ctrl_op2_sel : 3'h0)
    | (head[5] ? fb_uop_ram_11_ctrl_op2_sel : 3'h0)
    | (head[6] ? fb_uop_ram_13_ctrl_op2_sel : 3'h0)
    | (head[7] ? fb_uop_ram_15_ctrl_op2_sel : 3'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_1_bits_ctrl_imm_sel =
    (head[0] ? fb_uop_ram_1_ctrl_imm_sel : 3'h0)
    | (head[1] ? fb_uop_ram_3_ctrl_imm_sel : 3'h0)
    | (head[2] ? fb_uop_ram_5_ctrl_imm_sel : 3'h0)
    | (head[3] ? fb_uop_ram_7_ctrl_imm_sel : 3'h0)
    | (head[4] ? fb_uop_ram_9_ctrl_imm_sel : 3'h0)
    | (head[5] ? fb_uop_ram_11_ctrl_imm_sel : 3'h0)
    | (head[6] ? fb_uop_ram_13_ctrl_imm_sel : 3'h0)
    | (head[7] ? fb_uop_ram_15_ctrl_imm_sel : 3'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_1_bits_ctrl_op_fcn =
    (head[0] ? fb_uop_ram_1_ctrl_op_fcn : 4'h0)
    | (head[1] ? fb_uop_ram_3_ctrl_op_fcn : 4'h0)
    | (head[2] ? fb_uop_ram_5_ctrl_op_fcn : 4'h0)
    | (head[3] ? fb_uop_ram_7_ctrl_op_fcn : 4'h0)
    | (head[4] ? fb_uop_ram_9_ctrl_op_fcn : 4'h0)
    | (head[5] ? fb_uop_ram_11_ctrl_op_fcn : 4'h0)
    | (head[6] ? fb_uop_ram_13_ctrl_op_fcn : 4'h0)
    | (head[7] ? fb_uop_ram_15_ctrl_op_fcn : 4'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_1_bits_ctrl_fcn_dw =
    head[0] & fb_uop_ram_1_ctrl_fcn_dw | head[1] & fb_uop_ram_3_ctrl_fcn_dw | head[2]
    & fb_uop_ram_5_ctrl_fcn_dw | head[3] & fb_uop_ram_7_ctrl_fcn_dw | head[4]
    & fb_uop_ram_9_ctrl_fcn_dw | head[5] & fb_uop_ram_11_ctrl_fcn_dw | head[6]
    & fb_uop_ram_13_ctrl_fcn_dw | head[7] & fb_uop_ram_15_ctrl_fcn_dw;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_1_bits_ctrl_csr_cmd =
    (head[0] ? fb_uop_ram_1_ctrl_csr_cmd : 3'h0)
    | (head[1] ? fb_uop_ram_3_ctrl_csr_cmd : 3'h0)
    | (head[2] ? fb_uop_ram_5_ctrl_csr_cmd : 3'h0)
    | (head[3] ? fb_uop_ram_7_ctrl_csr_cmd : 3'h0)
    | (head[4] ? fb_uop_ram_9_ctrl_csr_cmd : 3'h0)
    | (head[5] ? fb_uop_ram_11_ctrl_csr_cmd : 3'h0)
    | (head[6] ? fb_uop_ram_13_ctrl_csr_cmd : 3'h0)
    | (head[7] ? fb_uop_ram_15_ctrl_csr_cmd : 3'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_1_bits_ctrl_is_load =
    head[0] & fb_uop_ram_1_ctrl_is_load | head[1] & fb_uop_ram_3_ctrl_is_load | head[2]
    & fb_uop_ram_5_ctrl_is_load | head[3] & fb_uop_ram_7_ctrl_is_load | head[4]
    & fb_uop_ram_9_ctrl_is_load | head[5] & fb_uop_ram_11_ctrl_is_load | head[6]
    & fb_uop_ram_13_ctrl_is_load | head[7] & fb_uop_ram_15_ctrl_is_load;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_1_bits_ctrl_is_sta =
    head[0] & fb_uop_ram_1_ctrl_is_sta | head[1] & fb_uop_ram_3_ctrl_is_sta | head[2]
    & fb_uop_ram_5_ctrl_is_sta | head[3] & fb_uop_ram_7_ctrl_is_sta | head[4]
    & fb_uop_ram_9_ctrl_is_sta | head[5] & fb_uop_ram_11_ctrl_is_sta | head[6]
    & fb_uop_ram_13_ctrl_is_sta | head[7] & fb_uop_ram_15_ctrl_is_sta;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_1_bits_ctrl_is_std =
    head[0] & fb_uop_ram_1_ctrl_is_std | head[1] & fb_uop_ram_3_ctrl_is_std | head[2]
    & fb_uop_ram_5_ctrl_is_std | head[3] & fb_uop_ram_7_ctrl_is_std | head[4]
    & fb_uop_ram_9_ctrl_is_std | head[5] & fb_uop_ram_11_ctrl_is_std | head[6]
    & fb_uop_ram_13_ctrl_is_std | head[7] & fb_uop_ram_15_ctrl_is_std;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_1_bits_iw_state =
    (head[0] ? fb_uop_ram_1_iw_state : 2'h0) | (head[1] ? fb_uop_ram_3_iw_state : 2'h0)
    | (head[2] ? fb_uop_ram_5_iw_state : 2'h0) | (head[3] ? fb_uop_ram_7_iw_state : 2'h0)
    | (head[4] ? fb_uop_ram_9_iw_state : 2'h0) | (head[5] ? fb_uop_ram_11_iw_state : 2'h0)
    | (head[6] ? fb_uop_ram_13_iw_state : 2'h0)
    | (head[7] ? fb_uop_ram_15_iw_state : 2'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_1_bits_iw_p1_poisoned =
    head[0] & fb_uop_ram_1_iw_p1_poisoned | head[1] & fb_uop_ram_3_iw_p1_poisoned
    | head[2] & fb_uop_ram_5_iw_p1_poisoned | head[3] & fb_uop_ram_7_iw_p1_poisoned
    | head[4] & fb_uop_ram_9_iw_p1_poisoned | head[5] & fb_uop_ram_11_iw_p1_poisoned
    | head[6] & fb_uop_ram_13_iw_p1_poisoned | head[7] & fb_uop_ram_15_iw_p1_poisoned;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_1_bits_iw_p2_poisoned =
    head[0] & fb_uop_ram_1_iw_p2_poisoned | head[1] & fb_uop_ram_3_iw_p2_poisoned
    | head[2] & fb_uop_ram_5_iw_p2_poisoned | head[3] & fb_uop_ram_7_iw_p2_poisoned
    | head[4] & fb_uop_ram_9_iw_p2_poisoned | head[5] & fb_uop_ram_11_iw_p2_poisoned
    | head[6] & fb_uop_ram_13_iw_p2_poisoned | head[7] & fb_uop_ram_15_iw_p2_poisoned;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_1_bits_is_sfb =
    head[0] & fb_uop_ram_1_is_sfb | head[1] & fb_uop_ram_3_is_sfb | head[2]
    & fb_uop_ram_5_is_sfb | head[3] & fb_uop_ram_7_is_sfb | head[4] & fb_uop_ram_9_is_sfb
    | head[5] & fb_uop_ram_11_is_sfb | head[6] & fb_uop_ram_13_is_sfb | head[7]
    & fb_uop_ram_15_is_sfb;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_1_bits_ftq_idx =
    (head[0] ? fb_uop_ram_1_ftq_idx : 5'h0) | (head[1] ? fb_uop_ram_3_ftq_idx : 5'h0)
    | (head[2] ? fb_uop_ram_5_ftq_idx : 5'h0) | (head[3] ? fb_uop_ram_7_ftq_idx : 5'h0)
    | (head[4] ? fb_uop_ram_9_ftq_idx : 5'h0) | (head[5] ? fb_uop_ram_11_ftq_idx : 5'h0)
    | (head[6] ? fb_uop_ram_13_ftq_idx : 5'h0) | (head[7] ? fb_uop_ram_15_ftq_idx : 5'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_1_bits_edge_inst =
    head[0] & fb_uop_ram_1_edge_inst | head[1] & fb_uop_ram_3_edge_inst | head[2]
    & fb_uop_ram_5_edge_inst | head[3] & fb_uop_ram_7_edge_inst | head[4]
    & fb_uop_ram_9_edge_inst | head[5] & fb_uop_ram_11_edge_inst | head[6]
    & fb_uop_ram_13_edge_inst | head[7] & fb_uop_ram_15_edge_inst;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_1_bits_pc_lob =
    (head[0] ? fb_uop_ram_1_pc_lob : 6'h0) | (head[1] ? fb_uop_ram_3_pc_lob : 6'h0)
    | (head[2] ? fb_uop_ram_5_pc_lob : 6'h0) | (head[3] ? fb_uop_ram_7_pc_lob : 6'h0)
    | (head[4] ? fb_uop_ram_9_pc_lob : 6'h0) | (head[5] ? fb_uop_ram_11_pc_lob : 6'h0)
    | (head[6] ? fb_uop_ram_13_pc_lob : 6'h0) | (head[7] ? fb_uop_ram_15_pc_lob : 6'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_1_bits_taken =
    head[0] & fb_uop_ram_1_taken | head[1] & fb_uop_ram_3_taken | head[2]
    & fb_uop_ram_5_taken | head[3] & fb_uop_ram_7_taken | head[4] & fb_uop_ram_9_taken
    | head[5] & fb_uop_ram_11_taken | head[6] & fb_uop_ram_13_taken | head[7]
    & fb_uop_ram_15_taken;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_1_bits_csr_addr =
    (head[0] ? fb_uop_ram_1_csr_addr : 12'h0) | (head[1] ? fb_uop_ram_3_csr_addr : 12'h0)
    | (head[2] ? fb_uop_ram_5_csr_addr : 12'h0)
    | (head[3] ? fb_uop_ram_7_csr_addr : 12'h0)
    | (head[4] ? fb_uop_ram_9_csr_addr : 12'h0)
    | (head[5] ? fb_uop_ram_11_csr_addr : 12'h0)
    | (head[6] ? fb_uop_ram_13_csr_addr : 12'h0)
    | (head[7] ? fb_uop_ram_15_csr_addr : 12'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_1_bits_rxq_idx =
    (head[0] ? fb_uop_ram_1_rxq_idx : 2'h0) | (head[1] ? fb_uop_ram_3_rxq_idx : 2'h0)
    | (head[2] ? fb_uop_ram_5_rxq_idx : 2'h0) | (head[3] ? fb_uop_ram_7_rxq_idx : 2'h0)
    | (head[4] ? fb_uop_ram_9_rxq_idx : 2'h0) | (head[5] ? fb_uop_ram_11_rxq_idx : 2'h0)
    | (head[6] ? fb_uop_ram_13_rxq_idx : 2'h0) | (head[7] ? fb_uop_ram_15_rxq_idx : 2'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_1_bits_xcpt_pf_if =
    head[0] & fb_uop_ram_1_xcpt_pf_if | head[1] & fb_uop_ram_3_xcpt_pf_if | head[2]
    & fb_uop_ram_5_xcpt_pf_if | head[3] & fb_uop_ram_7_xcpt_pf_if | head[4]
    & fb_uop_ram_9_xcpt_pf_if | head[5] & fb_uop_ram_11_xcpt_pf_if | head[6]
    & fb_uop_ram_13_xcpt_pf_if | head[7] & fb_uop_ram_15_xcpt_pf_if;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_1_bits_xcpt_ae_if =
    head[0] & fb_uop_ram_1_xcpt_ae_if | head[1] & fb_uop_ram_3_xcpt_ae_if | head[2]
    & fb_uop_ram_5_xcpt_ae_if | head[3] & fb_uop_ram_7_xcpt_ae_if | head[4]
    & fb_uop_ram_9_xcpt_ae_if | head[5] & fb_uop_ram_11_xcpt_ae_if | head[6]
    & fb_uop_ram_13_xcpt_ae_if | head[7] & fb_uop_ram_15_xcpt_ae_if;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_1_bits_xcpt_ma_if =
    head[0] & fb_uop_ram_1_xcpt_ma_if | head[1] & fb_uop_ram_3_xcpt_ma_if | head[2]
    & fb_uop_ram_5_xcpt_ma_if | head[3] & fb_uop_ram_7_xcpt_ma_if | head[4]
    & fb_uop_ram_9_xcpt_ma_if | head[5] & fb_uop_ram_11_xcpt_ma_if | head[6]
    & fb_uop_ram_13_xcpt_ma_if | head[7] & fb_uop_ram_15_xcpt_ma_if;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_1_bits_bp_debug_if =
    head[0] & fb_uop_ram_1_bp_debug_if | head[1] & fb_uop_ram_3_bp_debug_if | head[2]
    & fb_uop_ram_5_bp_debug_if | head[3] & fb_uop_ram_7_bp_debug_if | head[4]
    & fb_uop_ram_9_bp_debug_if | head[5] & fb_uop_ram_11_bp_debug_if | head[6]
    & fb_uop_ram_13_bp_debug_if | head[7] & fb_uop_ram_15_bp_debug_if;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_1_bits_bp_xcpt_if =
    head[0] & fb_uop_ram_1_bp_xcpt_if | head[1] & fb_uop_ram_3_bp_xcpt_if | head[2]
    & fb_uop_ram_5_bp_xcpt_if | head[3] & fb_uop_ram_7_bp_xcpt_if | head[4]
    & fb_uop_ram_9_bp_xcpt_if | head[5] & fb_uop_ram_11_bp_xcpt_if | head[6]
    & fb_uop_ram_13_bp_xcpt_if | head[7] & fb_uop_ram_15_bp_xcpt_if;	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :155:31
  assign io_deq_bits_uops_1_bits_debug_fsrc =
    (head[0] ? fb_uop_ram_1_debug_fsrc : 2'h0)
    | (head[1] ? fb_uop_ram_3_debug_fsrc : 2'h0)
    | (head[2] ? fb_uop_ram_5_debug_fsrc : 2'h0)
    | (head[3] ? fb_uop_ram_7_debug_fsrc : 2'h0)
    | (head[4] ? fb_uop_ram_9_debug_fsrc : 2'h0)
    | (head[5] ? fb_uop_ram_11_debug_fsrc : 2'h0)
    | (head[6] ? fb_uop_ram_13_debug_fsrc : 2'h0)
    | (head[7] ? fb_uop_ram_15_debug_fsrc : 2'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
  assign io_deq_bits_uops_1_bits_debug_tsrc =
    (head[0] ? fb_uop_ram_1_debug_tsrc : 2'h0)
    | (head[1] ? fb_uop_ram_3_debug_tsrc : 2'h0)
    | (head[2] ? fb_uop_ram_5_debug_tsrc : 2'h0)
    | (head[3] ? fb_uop_ram_7_debug_tsrc : 2'h0)
    | (head[4] ? fb_uop_ram_9_debug_tsrc : 2'h0)
    | (head[5] ? fb_uop_ram_11_debug_tsrc : 2'h0)
    | (head[6] ? fb_uop_ram_13_debug_tsrc : 2'h0)
    | (head[7] ? fb_uop_ram_15_debug_tsrc : 2'h0);	// Mux.scala:27:72, fetch-buffer.scala:57:16, :61:21, :97:33, :155:31
endmodule

