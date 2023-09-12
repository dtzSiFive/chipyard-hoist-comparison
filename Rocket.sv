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

module Rocket(
  input         clock,
                reset,
  input  [2:0]  io_hartid,
  input         io_interrupts_debug,
                io_interrupts_mtip,
                io_interrupts_msip,
                io_interrupts_meip,
                io_interrupts_seip,
                io_imem_resp_valid,
                io_imem_resp_bits_btb_taken,
                io_imem_resp_bits_btb_bridx,
  input  [4:0]  io_imem_resp_bits_btb_entry,
  input  [7:0]  io_imem_resp_bits_btb_bht_history,
  input  [39:0] io_imem_resp_bits_pc,
  input  [31:0] io_imem_resp_bits_data,
  input         io_imem_resp_bits_xcpt_pf_inst,
                io_imem_resp_bits_xcpt_ae_inst,
                io_imem_resp_bits_replay,
                io_dmem_req_ready,
                io_dmem_s2_nack,
                io_dmem_resp_valid,
  input  [6:0]  io_dmem_resp_bits_tag,
  input  [1:0]  io_dmem_resp_bits_size,
  input  [63:0] io_dmem_resp_bits_data,
  input         io_dmem_resp_bits_replay,
                io_dmem_resp_bits_has_data,
  input  [63:0] io_dmem_resp_bits_data_word_bypass,
  input         io_dmem_replay_next,
                io_dmem_s2_xcpt_ma_ld,
                io_dmem_s2_xcpt_ma_st,
                io_dmem_s2_xcpt_pf_ld,
                io_dmem_s2_xcpt_pf_st,
                io_dmem_s2_xcpt_ae_ld,
                io_dmem_s2_xcpt_ae_st,
                io_dmem_ordered,
                io_dmem_perf_release,
                io_dmem_perf_grant,
                io_fpu_fcsr_flags_valid,
  input  [4:0]  io_fpu_fcsr_flags_bits,
  input  [63:0] io_fpu_store_data,
                io_fpu_toint_data,
  input         io_fpu_fcsr_rdy,
                io_fpu_nack_mem,
                io_fpu_illegal_rm,
                io_fpu_dec_wen,
                io_fpu_dec_ren1,
                io_fpu_dec_ren2,
                io_fpu_dec_ren3,
                io_fpu_sboard_set,
                io_fpu_sboard_clr,
  input  [4:0]  io_fpu_sboard_clra,
  output        io_imem_might_request,
                io_imem_req_valid,
  output [39:0] io_imem_req_bits_pc,
  output        io_imem_req_bits_speculative,
                io_imem_sfence_valid,
                io_imem_sfence_bits_rs1,
                io_imem_sfence_bits_rs2,
  output [38:0] io_imem_sfence_bits_addr,
  output        io_imem_resp_ready,
                io_imem_btb_update_valid,
  output [4:0]  io_imem_btb_update_bits_prediction_entry,
  output [38:0] io_imem_btb_update_bits_pc,
  output        io_imem_btb_update_bits_isValid,
  output [38:0] io_imem_btb_update_bits_br_pc,
  output [1:0]  io_imem_btb_update_bits_cfiType,
  output        io_imem_bht_update_valid,
  output [7:0]  io_imem_bht_update_bits_prediction_history,
  output [38:0] io_imem_bht_update_bits_pc,
  output        io_imem_bht_update_bits_branch,
                io_imem_bht_update_bits_taken,
                io_imem_bht_update_bits_mispredict,
                io_imem_flush_icache,
                io_dmem_req_valid,
  output [39:0] io_dmem_req_bits_addr,
  output [6:0]  io_dmem_req_bits_tag,
  output [4:0]  io_dmem_req_bits_cmd,
  output [1:0]  io_dmem_req_bits_size,
  output        io_dmem_req_bits_signed,
                io_dmem_s1_kill,
  output [63:0] io_dmem_s1_data_data,
  output [3:0]  io_ptw_ptbr_mode,
  output [43:0] io_ptw_ptbr_ppn,
  output        io_ptw_sfence_valid,
                io_ptw_sfence_bits_rs1,
                io_ptw_sfence_bits_rs2,
  output [38:0] io_ptw_sfence_bits_addr,
  output        io_ptw_status_debug,
  output [1:0]  io_ptw_status_dprv,
                io_ptw_status_prv,
  output        io_ptw_status_mxr,
                io_ptw_status_sum,
                io_ptw_pmp_0_cfg_l,
  output [1:0]  io_ptw_pmp_0_cfg_a,
  output        io_ptw_pmp_0_cfg_x,
                io_ptw_pmp_0_cfg_w,
                io_ptw_pmp_0_cfg_r,
  output [29:0] io_ptw_pmp_0_addr,
  output [31:0] io_ptw_pmp_0_mask,
  output        io_ptw_pmp_1_cfg_l,
  output [1:0]  io_ptw_pmp_1_cfg_a,
  output        io_ptw_pmp_1_cfg_x,
                io_ptw_pmp_1_cfg_w,
                io_ptw_pmp_1_cfg_r,
  output [29:0] io_ptw_pmp_1_addr,
  output [31:0] io_ptw_pmp_1_mask,
  output        io_ptw_pmp_2_cfg_l,
  output [1:0]  io_ptw_pmp_2_cfg_a,
  output        io_ptw_pmp_2_cfg_x,
                io_ptw_pmp_2_cfg_w,
                io_ptw_pmp_2_cfg_r,
  output [29:0] io_ptw_pmp_2_addr,
  output [31:0] io_ptw_pmp_2_mask,
  output        io_ptw_pmp_3_cfg_l,
  output [1:0]  io_ptw_pmp_3_cfg_a,
  output        io_ptw_pmp_3_cfg_x,
                io_ptw_pmp_3_cfg_w,
                io_ptw_pmp_3_cfg_r,
  output [29:0] io_ptw_pmp_3_addr,
  output [31:0] io_ptw_pmp_3_mask,
  output        io_ptw_pmp_4_cfg_l,
  output [1:0]  io_ptw_pmp_4_cfg_a,
  output        io_ptw_pmp_4_cfg_x,
                io_ptw_pmp_4_cfg_w,
                io_ptw_pmp_4_cfg_r,
  output [29:0] io_ptw_pmp_4_addr,
  output [31:0] io_ptw_pmp_4_mask,
  output        io_ptw_pmp_5_cfg_l,
  output [1:0]  io_ptw_pmp_5_cfg_a,
  output        io_ptw_pmp_5_cfg_x,
                io_ptw_pmp_5_cfg_w,
                io_ptw_pmp_5_cfg_r,
  output [29:0] io_ptw_pmp_5_addr,
  output [31:0] io_ptw_pmp_5_mask,
  output        io_ptw_pmp_6_cfg_l,
  output [1:0]  io_ptw_pmp_6_cfg_a,
  output        io_ptw_pmp_6_cfg_x,
                io_ptw_pmp_6_cfg_w,
                io_ptw_pmp_6_cfg_r,
  output [29:0] io_ptw_pmp_6_addr,
  output [31:0] io_ptw_pmp_6_mask,
  output        io_ptw_pmp_7_cfg_l,
  output [1:0]  io_ptw_pmp_7_cfg_a,
  output        io_ptw_pmp_7_cfg_x,
                io_ptw_pmp_7_cfg_w,
                io_ptw_pmp_7_cfg_r,
  output [29:0] io_ptw_pmp_7_addr,
  output [31:0] io_ptw_pmp_7_mask,
  output [63:0] io_ptw_customCSRs_csrs_0_value,
  output [31:0] io_fpu_inst,
  output [63:0] io_fpu_fromint_data,
  output [2:0]  io_fpu_fcsr_rm,
  output        io_fpu_dmem_resp_val,
  output [2:0]  io_fpu_dmem_resp_type,
  output [4:0]  io_fpu_dmem_resp_tag,
  output        io_fpu_valid,
                io_fpu_killx,
                io_fpu_killm,
                io_wfi
);

  wire             _io_dmem_req_valid_output;	// RocketCore.scala:836:41
  wire             _GEN;	// RocketCore.scala:649:21, :662:44, :663:23
  wire             take_pc_wb;	// RocketCore.scala:640:53
  wire             take_pc_mem;	// RocketCore.scala:523:32
  wire             _div_io_req_ready;	// RocketCore.scala:409:19
  wire             _div_io_resp_valid;	// RocketCore.scala:409:19
  wire [63:0]      _div_io_resp_bits_data;	// RocketCore.scala:409:19
  wire [4:0]       _div_io_resp_bits_tag;	// RocketCore.scala:409:19
  wire [63:0]      _alu_io_out;	// RocketCore.scala:385:19
  wire [63:0]      _alu_io_adder_out;	// RocketCore.scala:385:19
  wire             _alu_io_cmp_out;	// RocketCore.scala:385:19
  wire             _bpu_io_xcpt_if;	// RocketCore.scala:323:19
  wire             _bpu_io_xcpt_ld;	// RocketCore.scala:323:19
  wire             _bpu_io_xcpt_st;	// RocketCore.scala:323:19
  wire             _bpu_io_debug_if;	// RocketCore.scala:323:19
  wire             _bpu_io_debug_ld;	// RocketCore.scala:323:19
  wire             _bpu_io_debug_st;	// RocketCore.scala:323:19
  wire [63:0]      _csr_io_rw_rdata;	// RocketCore.scala:282:19
  wire             _csr_io_decode_0_fp_illegal;	// RocketCore.scala:282:19
  wire             _csr_io_decode_0_fp_csr;	// RocketCore.scala:282:19
  wire             _csr_io_decode_0_read_illegal;	// RocketCore.scala:282:19
  wire             _csr_io_decode_0_write_illegal;	// RocketCore.scala:282:19
  wire             _csr_io_decode_0_write_flush;	// RocketCore.scala:282:19
  wire             _csr_io_decode_0_system_illegal;	// RocketCore.scala:282:19
  wire             _csr_io_csr_stall;	// RocketCore.scala:282:19
  wire             _csr_io_eret;	// RocketCore.scala:282:19
  wire             _csr_io_singleStep;	// RocketCore.scala:282:19
  wire             _csr_io_status_debug;	// RocketCore.scala:282:19
  wire [31:0]      _csr_io_status_isa;	// RocketCore.scala:282:19
  wire [1:0]       _csr_io_status_prv;	// RocketCore.scala:282:19
  wire [39:0]      _csr_io_evec;	// RocketCore.scala:282:19
  wire [63:0]      _csr_io_time;	// RocketCore.scala:282:19
  wire             _csr_io_interrupt;	// RocketCore.scala:282:19
  wire [63:0]      _csr_io_interrupt_cause;	// RocketCore.scala:282:19
  wire             _csr_io_bp_0_control_action;	// RocketCore.scala:282:19
  wire             _csr_io_bp_0_control_chain;	// RocketCore.scala:282:19
  wire [1:0]       _csr_io_bp_0_control_tmatch;	// RocketCore.scala:282:19
  wire             _csr_io_bp_0_control_m;	// RocketCore.scala:282:19
  wire             _csr_io_bp_0_control_s;	// RocketCore.scala:282:19
  wire             _csr_io_bp_0_control_u;	// RocketCore.scala:282:19
  wire             _csr_io_bp_0_control_x;	// RocketCore.scala:282:19
  wire             _csr_io_bp_0_control_w;	// RocketCore.scala:282:19
  wire             _csr_io_bp_0_control_r;	// RocketCore.scala:282:19
  wire [38:0]      _csr_io_bp_0_address;	// RocketCore.scala:282:19
  wire             _csr_io_inhibit_cycle;	// RocketCore.scala:282:19
  wire             _csr_io_trace_0_valid;	// RocketCore.scala:282:19
  wire             _csr_io_trace_0_exception;	// RocketCore.scala:282:19
  wire [63:0]      _csr_io_customCSRs_0_value;	// RocketCore.scala:282:19
  wire [63:0]      _rf_ext_R0_data;	// RocketCore.scala:1015:15
  wire [63:0]      _rf_ext_R1_data;	// RocketCore.scala:1015:15
  wire [39:0]      _ibuf_io_pc;	// RocketCore.scala:254:20
  wire [4:0]       _ibuf_io_btb_resp_entry;	// RocketCore.scala:254:20
  wire [7:0]       _ibuf_io_btb_resp_bht_history;	// RocketCore.scala:254:20
  wire             _ibuf_io_inst_0_valid;	// RocketCore.scala:254:20
  wire             _ibuf_io_inst_0_bits_xcpt0_pf_inst;	// RocketCore.scala:254:20
  wire             _ibuf_io_inst_0_bits_xcpt0_ae_inst;	// RocketCore.scala:254:20
  wire             _ibuf_io_inst_0_bits_xcpt1_pf_inst;	// RocketCore.scala:254:20
  wire             _ibuf_io_inst_0_bits_xcpt1_ae_inst;	// RocketCore.scala:254:20
  wire             _ibuf_io_inst_0_bits_replay;	// RocketCore.scala:254:20
  wire             _ibuf_io_inst_0_bits_rvc;	// RocketCore.scala:254:20
  wire [31:0]      _ibuf_io_inst_0_bits_inst_bits;	// RocketCore.scala:254:20
  wire [4:0]       _ibuf_io_inst_0_bits_inst_rd;	// RocketCore.scala:254:20
  wire [4:0]       _ibuf_io_inst_0_bits_inst_rs1;	// RocketCore.scala:254:20
  wire [4:0]       _ibuf_io_inst_0_bits_inst_rs2;	// RocketCore.scala:254:20
  wire [4:0]       _ibuf_io_inst_0_bits_inst_rs3;	// RocketCore.scala:254:20
  wire [31:0]      _ibuf_io_inst_0_bits_raw;	// RocketCore.scala:254:20
  reg              id_reg_pause;	// RocketCore.scala:114:25
  reg              imem_might_request_reg;	// RocketCore.scala:115:35
  reg              ex_ctrl_fp;	// RocketCore.scala:190:20
  reg              ex_ctrl_rocc;	// RocketCore.scala:190:20
  reg              ex_ctrl_branch;	// RocketCore.scala:190:20
  reg              ex_ctrl_jal;	// RocketCore.scala:190:20
  reg              ex_ctrl_jalr;	// RocketCore.scala:190:20
  reg              ex_ctrl_rxs2;	// RocketCore.scala:190:20
  reg              ex_ctrl_rxs1;	// RocketCore.scala:190:20
  reg  [1:0]       ex_ctrl_sel_alu2;	// RocketCore.scala:190:20
  reg  [1:0]       ex_ctrl_sel_alu1;	// RocketCore.scala:190:20
  reg  [2:0]       ex_ctrl_sel_imm;	// RocketCore.scala:190:20
  reg              ex_ctrl_alu_dw;	// RocketCore.scala:190:20
  reg  [3:0]       ex_ctrl_alu_fn;	// RocketCore.scala:190:20
  reg              ex_ctrl_mem;	// RocketCore.scala:190:20
  reg  [4:0]       ex_ctrl_mem_cmd;	// RocketCore.scala:190:20
  reg              ex_ctrl_rfs1;	// RocketCore.scala:190:20
  reg              ex_ctrl_rfs2;	// RocketCore.scala:190:20
  reg              ex_ctrl_wfd;	// RocketCore.scala:190:20
  reg              ex_ctrl_mul;	// RocketCore.scala:190:20
  reg              ex_ctrl_div;	// RocketCore.scala:190:20
  reg              ex_ctrl_wxd;	// RocketCore.scala:190:20
  reg  [2:0]       ex_ctrl_csr;	// RocketCore.scala:190:20
  reg              ex_ctrl_fence_i;	// RocketCore.scala:190:20
  reg              mem_ctrl_fp;	// RocketCore.scala:191:21
  reg              mem_ctrl_rocc;	// RocketCore.scala:191:21
  reg              mem_ctrl_branch;	// RocketCore.scala:191:21
  reg              mem_ctrl_jal;	// RocketCore.scala:191:21
  reg              mem_ctrl_jalr;	// RocketCore.scala:191:21
  reg              mem_ctrl_rxs2;	// RocketCore.scala:191:21
  reg              mem_ctrl_rxs1;	// RocketCore.scala:191:21
  reg              mem_ctrl_mem;	// RocketCore.scala:191:21
  reg              mem_ctrl_rfs1;	// RocketCore.scala:191:21
  reg              mem_ctrl_rfs2;	// RocketCore.scala:191:21
  reg              mem_ctrl_wfd;	// RocketCore.scala:191:21
  reg              mem_ctrl_mul;	// RocketCore.scala:191:21
  reg              mem_ctrl_div;	// RocketCore.scala:191:21
  reg              mem_ctrl_wxd;	// RocketCore.scala:191:21
  reg  [2:0]       mem_ctrl_csr;	// RocketCore.scala:191:21
  reg              mem_ctrl_fence_i;	// RocketCore.scala:191:21
  reg              wb_ctrl_rocc;	// RocketCore.scala:192:20
  reg              wb_ctrl_rxs2;	// RocketCore.scala:192:20
  reg              wb_ctrl_rxs1;	// RocketCore.scala:192:20
  reg              wb_ctrl_mem;	// RocketCore.scala:192:20
  reg              wb_ctrl_rfs1;	// RocketCore.scala:192:20
  reg              wb_ctrl_rfs2;	// RocketCore.scala:192:20
  reg              wb_ctrl_wfd;	// RocketCore.scala:192:20
  reg              wb_ctrl_div;	// RocketCore.scala:192:20
  reg              wb_ctrl_wxd;	// RocketCore.scala:192:20
  reg  [2:0]       wb_ctrl_csr;	// RocketCore.scala:192:20
  reg              wb_ctrl_fence_i;	// RocketCore.scala:192:20
  reg              ex_reg_xcpt_interrupt;	// RocketCore.scala:194:35
  reg              ex_reg_valid;	// RocketCore.scala:195:35
  reg              ex_reg_rvc;	// RocketCore.scala:196:35
  reg  [4:0]       ex_reg_btb_resp_entry;	// RocketCore.scala:197:35
  reg  [7:0]       ex_reg_btb_resp_bht_history;	// RocketCore.scala:197:35
  reg              ex_reg_xcpt;	// RocketCore.scala:198:35
  reg              ex_reg_flush_pipe;	// RocketCore.scala:199:35
  reg              ex_reg_load_use;	// RocketCore.scala:200:35
  reg  [63:0]      ex_reg_cause;	// RocketCore.scala:201:35
  reg              ex_reg_replay;	// RocketCore.scala:202:26
  reg  [39:0]      ex_reg_pc;	// RocketCore.scala:203:22
  reg  [1:0]       ex_reg_mem_size;	// RocketCore.scala:204:28
  reg  [31:0]      ex_reg_inst;	// RocketCore.scala:205:24
  reg  [31:0]      ex_reg_raw_inst;	// RocketCore.scala:206:28
  reg              ex_scie_unpipelined;	// RocketCore.scala:207:32
  reg              ex_scie_pipelined;	// RocketCore.scala:208:30
  reg              mem_reg_xcpt_interrupt;	// RocketCore.scala:211:36
  reg              mem_reg_valid;	// RocketCore.scala:212:36
  reg              mem_reg_rvc;	// RocketCore.scala:213:36
  reg  [4:0]       mem_reg_btb_resp_entry;	// RocketCore.scala:214:36
  reg  [7:0]       mem_reg_btb_resp_bht_history;	// RocketCore.scala:214:36
  reg              mem_reg_xcpt;	// RocketCore.scala:215:36
  reg              mem_reg_replay;	// RocketCore.scala:216:36
  reg              mem_reg_flush_pipe;	// RocketCore.scala:217:36
  reg  [63:0]      mem_reg_cause;	// RocketCore.scala:218:36
  reg              mem_mem_cmd_bh;	// RocketCore.scala:219:36
  reg              mem_reg_load;	// RocketCore.scala:220:36
  reg              mem_reg_store;	// RocketCore.scala:221:36
  reg              mem_reg_sfence;	// RocketCore.scala:222:27
  reg  [39:0]      mem_reg_pc;	// RocketCore.scala:223:23
  reg  [31:0]      mem_reg_inst;	// RocketCore.scala:224:25
  reg  [1:0]       mem_reg_mem_size;	// RocketCore.scala:225:29
  reg  [31:0]      mem_reg_raw_inst;	// RocketCore.scala:226:29
  reg              mem_scie_pipelined;	// RocketCore.scala:228:31
  reg  [63:0]      mem_reg_wdata;	// RocketCore.scala:229:26
  reg  [63:0]      mem_reg_rs2;	// RocketCore.scala:230:24
  reg              mem_br_taken;	// RocketCore.scala:231:25
  reg              wb_reg_valid;	// RocketCore.scala:235:35
  reg              wb_reg_xcpt;	// RocketCore.scala:236:35
  reg              wb_reg_replay;	// RocketCore.scala:237:35
  reg              wb_reg_flush_pipe;	// RocketCore.scala:238:35
  reg  [63:0]      wb_reg_cause;	// RocketCore.scala:239:35
  reg              wb_reg_sfence;	// RocketCore.scala:240:26
  reg  [39:0]      wb_reg_pc;	// RocketCore.scala:241:22
  reg  [1:0]       wb_reg_mem_size;	// RocketCore.scala:242:28
  reg  [31:0]      wb_reg_inst;	// RocketCore.scala:243:24
  reg  [31:0]      wb_reg_raw_inst;	// RocketCore.scala:244:28
  reg  [63:0]      wb_reg_wdata;	// RocketCore.scala:245:25
  wire             take_pc_mem_wb = take_pc_wb | take_pc_mem;	// RocketCore.scala:250:35, :523:32, :640:53
  wire [14:0]      _GEN_0 =
    {_ibuf_io_inst_0_bits_inst_bits[31:27],
     _ibuf_io_inst_0_bits_inst_bits[14:12],
     _ibuf_io_inst_0_bits_inst_bits[6:0]};	// Decode.scala:14:65, RocketCore.scala:254:20
  wire             _id_ctrl_decoder_bit_T_478 = _GEN_0 == 15'h12F;	// Decode.scala:14:{65,121}
  wire             _id_ctrl_decoder_bit_T_29 = _GEN_0 == 15'h112F;	// Decode.scala:14:{65,121}
  wire             _id_ctrl_decoder_bit_T_31 = _GEN_0 == 15'h52F;	// Decode.scala:14:{65,121}
  wire             _id_ctrl_decoder_bit_T_33 = _GEN_0 == 15'h312F;	// Decode.scala:14:{65,121}
  wire             _id_ctrl_decoder_bit_T_35 = _GEN_0 == 15'h212F;	// Decode.scala:14:{65,121}
  wire             _id_ctrl_decoder_bit_T_37 = _GEN_0 == 15'h412F;	// Decode.scala:14:{65,121}
  wire             _id_ctrl_decoder_bit_T_39 = _GEN_0 == 15'h612F;	// Decode.scala:14:{65,121}
  wire             _id_ctrl_decoder_bit_T_41 = _GEN_0 == 15'h512F;	// Decode.scala:14:{65,121}
  wire             _id_ctrl_decoder_bit_T_43 = _GEN_0 == 15'h712F;	// Decode.scala:14:{65,121}
  wire [19:0]      _GEN_1 =
    {_ibuf_io_inst_0_bits_inst_bits[31:27],
     _ibuf_io_inst_0_bits_inst_bits[24:20],
     _ibuf_io_inst_0_bits_inst_bits[14:12],
     _ibuf_io_inst_0_bits_inst_bits[6:0]};	// Decode.scala:14:65, RocketCore.scala:254:20
  wire             _id_ctrl_decoder_bit_T_45 = _GEN_1 == 20'h1012F;	// Decode.scala:14:{65,121}
  wire             _id_ctrl_decoder_bit_T_47 = _GEN_0 == 15'hD2F;	// Decode.scala:14:{65,121}
  wire             _id_ctrl_decoder_bit_T_49 = _GEN_0 == 15'h1AF;	// Decode.scala:14:{65,121}
  wire             _id_ctrl_decoder_bit_T_51 = _GEN_0 == 15'h5AF;	// Decode.scala:14:{65,121}
  wire             _id_ctrl_decoder_bit_T_53 = _GEN_0 == 15'h11AF;	// Decode.scala:14:{65,121}
  wire             _id_ctrl_decoder_bit_T_55 = _GEN_0 == 15'h31AF;	// Decode.scala:14:{65,121}
  wire             _id_ctrl_decoder_bit_T_57 = _GEN_0 == 15'h21AF;	// Decode.scala:14:{65,121}
  wire             _id_ctrl_decoder_bit_T_59 = _GEN_0 == 15'h41AF;	// Decode.scala:14:{65,121}
  wire             _id_ctrl_decoder_bit_T_61 = _GEN_0 == 15'h61AF;	// Decode.scala:14:{65,121}
  wire             _id_ctrl_decoder_bit_T_63 = _GEN_0 == 15'h51AF;	// Decode.scala:14:{65,121}
  wire             _id_ctrl_decoder_bit_T_65 = _GEN_0 == 15'h71AF;	// Decode.scala:14:{65,121}
  wire             _id_ctrl_decoder_bit_T_67 = _GEN_1 == 20'h101AF;	// Decode.scala:14:{65,121}
  wire             _id_ctrl_decoder_bit_T_69 = _GEN_0 == 15'hDAF;	// Decode.scala:14:{65,121}
  wire [9:0]       _GEN_2 =
    {_ibuf_io_inst_0_bits_inst_bits[14:12], _ibuf_io_inst_0_bits_inst_bits[6:0]};	// Decode.scala:14:65, RocketCore.scala:254:20
  wire             _id_ctrl_decoder_bit_T_115 = _GEN_2 == 10'h107;	// Decode.scala:14:{65,121}
  wire             _id_ctrl_decoder_bit_T_117 = _GEN_2 == 10'h127;	// Decode.scala:14:{65,121}
  wire             _id_ctrl_decoder_bit_T_175 = _GEN_2 == 10'h187;	// Decode.scala:14:{65,121}
  wire             _id_ctrl_decoder_bit_T_177 = _GEN_2 == 10'h1A7;	// Decode.scala:14:{65,121}
  wire             _id_ctrl_decoder_bit_T_195 = _GEN_2 == 10'h183;	// Decode.scala:14:{65,121}
  wire             _id_ctrl_decoder_bit_T_197 = _GEN_2 == 10'h303;	// Decode.scala:14:{65,121}
  wire             _id_ctrl_decoder_bit_T_199 = _GEN_2 == 10'h1A3;	// Decode.scala:14:{65,121}
  wire             _id_ctrl_decoder_bit_T_225 =
    {_ibuf_io_inst_0_bits_inst_bits[31:25],
     _ibuf_io_inst_0_bits_inst_bits[14:0]} == 22'h48073;	// Decode.scala:14:{65,121}, RocketCore.scala:254:20
  wire             _id_ctrl_decoder_bit_T_249 = _GEN_2 == 10'h3;	// Decode.scala:14:{65,121}
  wire             _id_ctrl_decoder_bit_T_251 = _GEN_2 == 10'h83;	// Decode.scala:14:{65,121}
  wire             _id_ctrl_decoder_bit_T_253 = _GEN_2 == 10'h103;	// Decode.scala:14:{65,121}
  wire             _id_ctrl_decoder_bit_T_255 = _GEN_2 == 10'h203;	// Decode.scala:14:{65,121}
  wire             _id_ctrl_decoder_bit_T_257 = _GEN_2 == 10'h283;	// Decode.scala:14:{65,121}
  wire             _id_ctrl_decoder_bit_T_259 = _GEN_2 == 10'h23;	// Decode.scala:14:{65,121}
  wire             _id_ctrl_decoder_bit_T_261 = _GEN_2 == 10'hA3;	// Decode.scala:14:{65,121}
  wire             _id_ctrl_decoder_bit_T_263 = _GEN_2 == 10'h123;	// Decode.scala:14:{65,121}
  wire             id_ctrl_fp =
    {_ibuf_io_inst_0_bits_inst_bits[6], _ibuf_io_inst_0_bits_inst_bits[4:2]} == 4'h1
    | _ibuf_io_inst_0_bits_inst_bits[6:5] == 2'h2;	// Decode.scala:14:{65,121}, :15:30, Mux.scala:47:69, RocketCore.scala:254:20
  wire [2:0]       _GEN_3 =
    {_ibuf_io_inst_0_bits_inst_bits[6:5], _ibuf_io_inst_0_bits_inst_bits[2]};	// Decode.scala:14:65, RocketCore.scala:254:20
  wire [2:0]       _GEN_4 =
    {_ibuf_io_inst_0_bits_inst_bits[5:4], _ibuf_io_inst_0_bits_inst_bits[2]};	// Decode.scala:14:65, RocketCore.scala:254:20
  wire             id_ctrl_rxs2 =
    _GEN_3 == 3'h2 | _GEN_4 == 3'h4
    | {_ibuf_io_inst_0_bits_inst_bits[13],
       _ibuf_io_inst_0_bits_inst_bits[6],
       _ibuf_io_inst_0_bits_inst_bits[3]} == 3'h5
    | {_ibuf_io_inst_0_bits_inst_bits[30],
       _ibuf_io_inst_0_bits_inst_bits[25],
       _ibuf_io_inst_0_bits_inst_bits[13:12],
       _ibuf_io_inst_0_bits_inst_bits[5],
       _ibuf_io_inst_0_bits_inst_bits[2]} == 6'h12;	// Decode.scala:14:{65,121}, :15:30, RocketCore.scala:254:20, :1037:24, :1038:26, :1048:22
  wire [1:0]       _GEN_5 =
    {_ibuf_io_inst_0_bits_inst_bits[6], _ibuf_io_inst_0_bits_inst_bits[2]};	// Decode.scala:14:65, RocketCore.scala:254:20
  wire             _id_ctrl_decoder_T_32 = _GEN_5 == 2'h0;	// Decode.scala:14:{65,121}
  wire             id_ctrl_rxs1 =
    _id_ctrl_decoder_T_32
    | {_ibuf_io_inst_0_bits_inst_bits[14],
       _ibuf_io_inst_0_bits_inst_bits[5],
       _ibuf_io_inst_0_bits_inst_bits[2]} == 3'h2
    | _ibuf_io_inst_0_bits_inst_bits[5:3] == 3'h4
    | {_ibuf_io_inst_0_bits_inst_bits[13],
       _ibuf_io_inst_0_bits_inst_bits[6],
       _ibuf_io_inst_0_bits_inst_bits[4]} == 3'h4
    | {_ibuf_io_inst_0_bits_inst_bits[31],
       _ibuf_io_inst_0_bits_inst_bits[28],
       _ibuf_io_inst_0_bits_inst_bits[5:4],
       _ibuf_io_inst_0_bits_inst_bits[2]} == 5'h1A;	// Decode.scala:14:{65,121}, :15:30, RocketCore.scala:254:20, :1038:26, :1048:22
  wire [1:0]       _GEN_6 =
    {_ibuf_io_inst_0_bits_inst_bits[6], _ibuf_io_inst_0_bits_inst_bits[4]};	// Decode.scala:14:65, RocketCore.scala:254:20
  wire             id_ctrl_mem =
    _id_ctrl_decoder_bit_T_478 | _id_ctrl_decoder_bit_T_29 | _id_ctrl_decoder_bit_T_31
    | _id_ctrl_decoder_bit_T_33 | _id_ctrl_decoder_bit_T_35 | _id_ctrl_decoder_bit_T_37
    | _id_ctrl_decoder_bit_T_39 | _id_ctrl_decoder_bit_T_41 | _id_ctrl_decoder_bit_T_43
    | _id_ctrl_decoder_bit_T_45 | _id_ctrl_decoder_bit_T_47 | _id_ctrl_decoder_bit_T_49
    | _id_ctrl_decoder_bit_T_51 | _id_ctrl_decoder_bit_T_53 | _id_ctrl_decoder_bit_T_55
    | _id_ctrl_decoder_bit_T_57 | _id_ctrl_decoder_bit_T_59 | _id_ctrl_decoder_bit_T_61
    | _id_ctrl_decoder_bit_T_63 | _id_ctrl_decoder_bit_T_65 | _id_ctrl_decoder_bit_T_67
    | _id_ctrl_decoder_bit_T_69 | _id_ctrl_decoder_bit_T_115 | _id_ctrl_decoder_bit_T_117
    | _id_ctrl_decoder_bit_T_175 | _id_ctrl_decoder_bit_T_177 | _id_ctrl_decoder_bit_T_195
    | _id_ctrl_decoder_bit_T_197 | _id_ctrl_decoder_bit_T_199 | _id_ctrl_decoder_bit_T_225
    | _id_ctrl_decoder_bit_T_249 | _id_ctrl_decoder_bit_T_251 | _id_ctrl_decoder_bit_T_253
    | _id_ctrl_decoder_bit_T_255 | _id_ctrl_decoder_bit_T_257 | _id_ctrl_decoder_bit_T_259
    | _id_ctrl_decoder_bit_T_261 | _id_ctrl_decoder_bit_T_263;	// Decode.scala:14:121, :15:30
  wire             id_ctrl_div =
    {_ibuf_io_inst_0_bits_inst_bits[25],
     _ibuf_io_inst_0_bits_inst_bits[6:4],
     _ibuf_io_inst_0_bits_inst_bits[2]} == 5'h16;	// Decode.scala:14:{65,121}, RocketCore.scala:254:20
  wire             id_ctrl_wxd =
    _GEN_3 == 3'h0 | _GEN_6 == 2'h1
    | {_ibuf_io_inst_0_bits_inst_bits[13],
       _ibuf_io_inst_0_bits_inst_bits[5],
       _ibuf_io_inst_0_bits_inst_bits[2]} == 3'h3
    | (&{_ibuf_io_inst_0_bits_inst_bits[5], _ibuf_io_inst_0_bits_inst_bits[3]})
    | (&{_ibuf_io_inst_0_bits_inst_bits[12], _ibuf_io_inst_0_bits_inst_bits[5:4]})
    | (&{_ibuf_io_inst_0_bits_inst_bits[13], _ibuf_io_inst_0_bits_inst_bits[5:4]})
    | {_ibuf_io_inst_0_bits_inst_bits[31],
       _ibuf_io_inst_0_bits_inst_bits[28],
       _ibuf_io_inst_0_bits_inst_bits[4]} == 3'h5;	// Decode.scala:14:{65,121}, :15:30, Mux.scala:80:60, RocketCore.scala:254:20, :1037:24, :1045:24
  wire [3:0]       _GEN_7 =
    {_ibuf_io_inst_0_bits_inst_bits[12], _ibuf_io_inst_0_bits_inst_bits[6:4]};	// Decode.scala:14:65, RocketCore.scala:254:20
  wire [3:0]       _GEN_8 =
    {_ibuf_io_inst_0_bits_inst_bits[13], _ibuf_io_inst_0_bits_inst_bits[6:4]};	// Decode.scala:14:65, RocketCore.scala:254:20
  wire [2:0]       id_ctrl_csr =
    {{_ibuf_io_inst_0_bits_inst_bits[28], _ibuf_io_inst_0_bits_inst_bits[6:4]} == 4'h7
       | (&_GEN_7) | (&_GEN_8)
       | {_ibuf_io_inst_0_bits_inst_bits[28],
          _ibuf_io_inst_0_bits_inst_bits[25],
          _ibuf_io_inst_0_bits_inst_bits[5:4],
          _ibuf_io_inst_0_bits_inst_bits[2]} == 5'h16
       | {_ibuf_io_inst_0_bits_inst_bits[31:29],
          _ibuf_io_inst_0_bits_inst_bits[6],
          _ibuf_io_inst_0_bits_inst_bits[4]} == 5'hF,
     &_GEN_8,
     &_GEN_7};	// Cat.scala:30:58, Decode.scala:14:{65,121}, :15:30, RocketCore.scala:254:20, package.scala:15:47
  wire             id_ctrl_fence_i =
    {_ibuf_io_inst_0_bits_inst_bits[13:12],
     _ibuf_io_inst_0_bits_inst_bits[6],
     _ibuf_io_inst_0_bits_inst_bits[4:3]} == 5'h9;	// Decode.scala:14:{65,121}, RocketCore.scala:254:20, package.scala:15:47
  wire             id_ctrl_amo =
    {_ibuf_io_inst_0_bits_inst_bits[14:13],
     _ibuf_io_inst_0_bits_inst_bits[6],
     _ibuf_io_inst_0_bits_inst_bits[3]} == 4'h5;	// Decode.scala:14:{65,121}, RocketCore.scala:254:20
  reg              id_reg_fence;	// RocketCore.scala:274:25
  wire             _id_csr_ren_T = id_ctrl_csr == 3'h6;	// Cat.scala:30:58, package.scala:15:47
  wire             id_csr_en = _id_csr_ren_T | (&id_ctrl_csr) | id_ctrl_csr == 3'h5;	// Cat.scala:30:58, RocketCore.scala:1037:24, package.scala:15:47, :72:59
  wire             id_mem_busy = ~io_dmem_ordered | _io_dmem_req_valid_output;	// RocketCore.scala:315:{21,38}, :836:41
  wire             _dcache_kill_mem_T = mem_reg_valid & mem_ctrl_wxd;	// RocketCore.scala:191:21, :212:36, :365:20
  reg              ex_reg_rs_bypass_0;	// RocketCore.scala:371:29
  reg              ex_reg_rs_bypass_1;	// RocketCore.scala:371:29
  reg  [1:0]       ex_reg_rs_lsb_0;	// RocketCore.scala:372:26
  reg  [1:0]       ex_reg_rs_lsb_1;	// RocketCore.scala:372:26
  reg  [61:0]      ex_reg_rs_msb_0;	// RocketCore.scala:373:26
  reg  [61:0]      ex_reg_rs_msb_1;	// RocketCore.scala:373:26
  wire [3:0][63:0] _GEN_9 =
    {{io_dmem_resp_bits_data_word_bypass}, {wb_reg_wdata}, {mem_reg_wdata}, {64'h0}};	// Mux.scala:80:57, RocketCore.scala:229:26, :245:25, package.scala:32:{76,86}
  wire [63:0]      _ex_rs_T_5 = _GEN_9[ex_reg_rs_lsb_0];	// RocketCore.scala:372:26, package.scala:32:{76,86}
  wire [63:0]      _ex_rs_T_6 = {ex_reg_rs_msb_0, ex_reg_rs_lsb_0};	// Cat.scala:30:58, RocketCore.scala:372:26, :373:26
  wire [63:0]      ex_rs_0 = ex_reg_rs_bypass_0 ? _ex_rs_T_5 : _ex_rs_T_6;	// Cat.scala:30:58, RocketCore.scala:371:29, :375:14, package.scala:32:76
  wire [63:0]      _ex_rs_T_12 = _GEN_9[ex_reg_rs_lsb_1];	// RocketCore.scala:372:26, package.scala:32:{76,86}
  wire [63:0]      _ex_rs_T_13 = {ex_reg_rs_msb_1, ex_reg_rs_lsb_1};	// Cat.scala:30:58, RocketCore.scala:372:26, :373:26
  wire [63:0]      ex_rs_1 = ex_reg_rs_bypass_1 ? _ex_rs_T_12 : _ex_rs_T_13;	// Cat.scala:30:58, RocketCore.scala:371:29, :375:14, package.scala:32:76
  wire             _ex_imm_b0_T_4 = ex_ctrl_sel_imm == 3'h5;	// RocketCore.scala:190:20, :1037:24
  wire             ex_imm_sign = ~_ex_imm_b0_T_4 & ex_reg_inst[31];	// RocketCore.scala:205:24, :1037:{19,24,48}
  wire             _ex_imm_b4_1_T = ex_ctrl_sel_imm == 3'h2;	// RocketCore.scala:190:20, :1038:26
  wire             _ex_imm_b4_1_T_2 = ex_ctrl_sel_imm == 3'h1;	// RocketCore.scala:190:20, :1042:23
  wire             _ex_imm_b0_T = ex_ctrl_sel_imm == 3'h0;	// RocketCore.scala:190:20, :1045:24
  wire [3:0]       _ex_op2_T_1 = ex_reg_rvc ? 4'h2 : 4'h4;	// Mux.scala:47:69, RocketCore.scala:196:35, :383:19
  wire [3:0][63:0] _GEN_10 =
    {{{{33{ex_imm_sign}},
       _ex_imm_b4_1_T ? ex_reg_inst[30:20] : {11{ex_imm_sign}},
       ex_ctrl_sel_imm != 3'h2 & ex_ctrl_sel_imm != 3'h3
         ? {8{ex_imm_sign}}
         : ex_reg_inst[19:12],
       ~(_ex_imm_b4_1_T | _ex_imm_b0_T_4)
         & (ex_ctrl_sel_imm == 3'h3
              ? ex_reg_inst[20]
              : _ex_imm_b4_1_T_2 ? ex_reg_inst[7] : ex_imm_sign),
       _ex_imm_b4_1_T | _ex_imm_b0_T_4 ? 6'h0 : ex_reg_inst[30:25],
       _ex_imm_b4_1_T
         ? 4'h0
         : _ex_imm_b0_T | _ex_imm_b4_1_T_2
             ? ex_reg_inst[11:8]
             : _ex_imm_b0_T_4 ? ex_reg_inst[19:16] : ex_reg_inst[24:21],
       _ex_imm_b0_T
         ? ex_reg_inst[7]
         : ex_ctrl_sel_imm == 3'h4 ? ex_reg_inst[20] : _ex_imm_b0_T_4 & ex_reg_inst[15]}},
     {ex_rs_1},
     {{{60{_ex_op2_T_1[3]}}, _ex_op2_T_1}},
     {64'h0}};	// Mux.scala:47:69, :80:{57,60}, RocketCore.scala:190:20, :205:24, :375:14, :383:19, :1037:{19,24}, :1038:{21,26,41}, :1039:{21,26,36,43,65}, :1040:{18,33}, :1041:{18,23,39}, :1042:{18,23,39}, :1043:{20,35,66}, :1044:19, :1045:{19,24,34,57}, :1046:{19,39,52}, :1047:17, :1048:{17,22}, :1049:{17,37}
  wire             _div_io_req_valid_T = ex_reg_valid & ex_ctrl_div;	// RocketCore.scala:190:20, :195:35, :410:36
  wire             ex_pc_valid = ex_reg_valid | ex_reg_replay | ex_reg_xcpt_interrupt;	// RocketCore.scala:194:35, :195:35, :202:26, :490:51
  wire             wb_dcache_miss = wb_ctrl_mem & ~io_dmem_resp_valid;	// RocketCore.scala:192:20, :491:{36,39}
  wire             replay_ex =
    ex_reg_replay | ex_reg_valid
    & (ex_ctrl_mem & ~io_dmem_req_ready | ex_ctrl_div & ~_div_io_req_ready
       | wb_dcache_miss & ex_reg_load_use);	// RocketCore.scala:190:20, :195:35, :200:35, :202:26, :409:19, :491:36, :492:{42,45}, :493:{42,45}, :494:43, :495:{33,50,75}
  wire             ctrl_killx = take_pc_mem_wb | replay_ex | ~ex_reg_valid;	// RocketCore.scala:195:35, :250:35, :495:33, :496:{48,51}
  wire             _mem_cfi_taken_T = mem_ctrl_branch & mem_br_taken;	// RocketCore.scala:191:21, :231:25, :510:25
  wire [3:0]       _mem_br_target_T_6 = mem_reg_rvc ? 4'h2 : 4'h4;	// Mux.scala:47:69, RocketCore.scala:213:36, :383:19, :512:8
  wire [31:0]      _mem_br_target_T_8 =
    _mem_cfi_taken_T
      ? {{20{mem_reg_inst[31]}},
         mem_reg_inst[7],
         mem_reg_inst[30:25],
         mem_reg_inst[11:8],
         1'h0}
      : mem_ctrl_jal
          ? {{12{mem_reg_inst[31]}},
             mem_reg_inst[19:12],
             mem_reg_inst[20],
             mem_reg_inst[30:21],
             1'h0}
          : {{28{_mem_br_target_T_6[3]}}, _mem_br_target_T_6};	// Cat.scala:30:58, RocketCore.scala:191:21, :224:25, :282:19, :323:19, :510:{8,25}, :511:8, :512:8, :1037:48, :1039:65, :1041:39, :1042:39, :1043:66, :1045:57
  wire [39:0]      _mem_br_target_T_9 =
    mem_reg_pc + {{8{_mem_br_target_T_8[31]}}, _mem_br_target_T_8};	// RocketCore.scala:223:23, :509:41, :510:8
  wire [39:0]      _mem_npc_T_3 =
    mem_ctrl_jalr | mem_reg_sfence
      ? {mem_reg_wdata[63:39] == 25'h0 | (&(mem_reg_wdata[63:39]))
           ? mem_reg_wdata[39]
           : ~(mem_reg_wdata[38]),
         mem_reg_wdata[38:0]}
      : _mem_br_target_T_9;	// Cat.scala:30:58, RocketCore.scala:191:21, :222:27, :229:26, :509:41, :513:{21,36}, :989:23, :990:{18,21,29,34,46,59,62}, :991:16
  wire [39:0]      mem_npc = _mem_npc_T_3 & 40'hFFFFFFFFFE;	// RocketCore.scala:513:{21,129}
  wire             mem_wrong_npc =
    ex_pc_valid
      ? mem_npc != ex_reg_pc
      : ~(_ibuf_io_inst_0_valid | io_imem_resp_valid) | mem_npc != _ibuf_io_pc;	// RocketCore.scala:203:22, :254:20, :490:51, :513:129, :515:{8,30}, :516:{8,31,62}
  wire             mem_cfi = mem_ctrl_branch | mem_ctrl_jalr | mem_ctrl_jal;	// RocketCore.scala:191:21, :519:50
  assign take_pc_mem = mem_reg_valid & (mem_wrong_npc | mem_reg_sfence);	// RocketCore.scala:212:36, :222:27, :515:8, :523:{32,54}
  wire             mem_debug_breakpoint =
    mem_reg_load & _bpu_io_debug_ld | mem_reg_store & _bpu_io_debug_st;	// RocketCore.scala:220:36, :221:36, :323:19, :567:{44,64,82}
  wire             mem_ldst_xcpt =
    mem_debug_breakpoint | mem_reg_load & _bpu_io_xcpt_ld | mem_reg_store
    & _bpu_io_xcpt_st;	// RocketCore.scala:220:36, :221:36, :323:19, :566:{38,75}, :567:64, :975:26
  wire             dcache_kill_mem = _dcache_kill_mem_T & io_dmem_replay_next;	// RocketCore.scala:365:20, :584:55
  wire             fpu_kill_mem = mem_reg_valid & mem_ctrl_fp & io_fpu_nack_mem;	// RocketCore.scala:191:21, :212:36, :585:51
  wire             killm_common =
    dcache_kill_mem | take_pc_wb | mem_reg_xcpt | ~mem_reg_valid;	// RocketCore.scala:212:36, :215:36, :584:55, :587:{68,71}, :640:53
  reg              div_io_kill_REG;	// RocketCore.scala:588:37
  wire             _GEN_11 = wb_reg_valid & wb_ctrl_mem;	// RocketCore.scala:192:20, :235:35, :615:19
  wire             _GEN_12 = _GEN_11 & io_dmem_s2_xcpt_ma_st;	// RocketCore.scala:615:{19,34}
  wire             _GEN_13 = _GEN_11 & io_dmem_s2_xcpt_ma_ld;	// RocketCore.scala:615:19, :616:34
  wire             _GEN_14 = _GEN_11 & io_dmem_s2_xcpt_pf_st;	// RocketCore.scala:615:19, :617:34
  wire             _GEN_15 = _GEN_11 & io_dmem_s2_xcpt_pf_ld;	// RocketCore.scala:615:19, :618:34
  wire             _GEN_16 = _GEN_11 & io_dmem_s2_xcpt_ae_st;	// RocketCore.scala:615:19, :619:34
  wire             wb_xcpt =
    wb_reg_xcpt | _GEN_12 | _GEN_13 | _GEN_14 | _GEN_15 | _GEN_16 | _GEN_11
    & io_dmem_s2_xcpt_ae_ld;	// RocketCore.scala:236:35, :615:{19,34}, :616:34, :617:34, :618:34, :619:34, :620:34, :975:26
  wire [63:0]      wb_cause =
    wb_reg_xcpt
      ? wb_reg_cause
      : {60'h0,
         _GEN_12
           ? 4'h6
           : _GEN_13 ? 4'h4 : _GEN_14 ? 4'hF : _GEN_15 ? 4'hD : {2'h1, _GEN_16, 1'h1}};	// Mux.scala:47:69, :80:60, RocketCore.scala:236:35, :239:35, :615:34, :616:34, :617:34, :618:34, :619:34, package.scala:15:47
  wire             wb_wxd = wb_reg_valid & wb_ctrl_wxd;	// RocketCore.scala:192:20, :235:35, :635:29
  wire             wb_set_sboard = wb_ctrl_div | wb_dcache_miss | wb_ctrl_rocc;	// RocketCore.scala:192:20, :491:36, :636:53
  wire             replay_wb =
    io_dmem_s2_nack | wb_reg_replay | wb_reg_valid & wb_ctrl_rocc;	// RocketCore.scala:192:20, :235:35, :237:35, :319:53, :639:36
  assign take_pc_wb = replay_wb | wb_xcpt | _csr_io_eret | wb_reg_flush_pipe;	// RocketCore.scala:238:35, :282:19, :639:36, :640:53, :975:26
  wire             dmem_resp_valid = io_dmem_resp_valid & io_dmem_resp_bits_has_data;	// RocketCore.scala:646:44
  wire             dmem_resp_replay = dmem_resp_valid & io_dmem_resp_bits_replay;	// RocketCore.scala:646:44, :647:42
  wire             _GEN_17 = dmem_resp_replay & ~(io_dmem_resp_bits_tag[0]);	// RocketCore.scala:643:{23,45}, :647:42, :662:26
  assign _GEN = ~_GEN_17 & ~wb_wxd;	// RocketCore.scala:635:29, :649:{21,24}, :662:{26,44}, :663:23
  wire [4:0]       ll_waddr =
    _GEN_17 ? io_dmem_resp_bits_tag[5:1] : _div_io_resp_bits_tag;	// RocketCore.scala:409:19, :645:46, :662:{26,44}, :666:14
  wire             ll_wen = _GEN_17 | _GEN & _div_io_resp_valid;	// Decoupled.scala:40:37, RocketCore.scala:409:19, :649:21, :662:{26,44}, :663:23, :667:12
  wire             wb_valid = wb_reg_valid & ~replay_wb & ~wb_xcpt;	// RocketCore.scala:235:35, :639:36, :670:{34,45,48}, :975:26
  wire             wb_wen = wb_valid & wb_ctrl_wxd;	// RocketCore.scala:192:20, :670:45, :671:25
  wire             rf_wen = wb_wen | ll_wen;	// RocketCore.scala:662:44, :667:12, :671:25, :672:23
  wire [4:0]       rf_waddr = ll_wen ? ll_waddr : wb_reg_inst[11:7];	// RocketCore.scala:243:24, :361:29, :662:44, :666:14, :667:12, :673:21
  wire [63:0]      coreMonitorBundle_wrdata =
    dmem_resp_valid & ~(io_dmem_resp_bits_tag[0])
      ? io_dmem_resp_bits_data
      : ll_wen
          ? _div_io_resp_bits_data
          : (|wb_ctrl_csr) ? _csr_io_rw_rdata : wb_reg_wdata;	// RocketCore.scala:192:20, :245:25, :282:19, :409:19, :643:{23,45}, :646:44, :662:44, :667:12, :674:{21,38}, :675:21, :676:{21,34}
  wire [63:0]      id_rs_0 =
    rf_wen & (|rf_waddr) & rf_waddr == _ibuf_io_inst_0_bits_inst_rs1
      ? coreMonitorBundle_wrdata
      : _rf_ext_R1_data;	// RocketCore.scala:254:20, :672:23, :673:21, :674:21, :679:17, :1015:15, :1022:19, :1027:{16,29}, :1030:{20,31,39}
  wire [63:0]      id_rs_1 =
    rf_wen & (|rf_waddr) & rf_waddr == _ibuf_io_inst_0_bits_inst_rs2
      ? coreMonitorBundle_wrdata
      : _rf_ext_R0_data;	// RocketCore.scala:254:20, :672:23, :673:21, :674:21, :679:17, :1015:15, :1022:19, :1027:{16,29}, :1030:{20,31,39}
  wire             _GEN_18 = id_ctrl_rxs1 & (|_ibuf_io_inst_0_bits_inst_rs1);	// Decode.scala:15:30, RocketCore.scala:254:20, :714:42, :1022:45
  wire             _GEN_19 = id_ctrl_rxs2 & (|_ibuf_io_inst_0_bits_inst_rs2);	// Decode.scala:15:30, RocketCore.scala:254:20, :367:82, :715:42
  wire             _GEN_20 = id_ctrl_wxd & (|_ibuf_io_inst_0_bits_inst_rd);	// Decode.scala:15:30, RocketCore.scala:254:20, :716:{42,55}
  reg  [31:0]      _r;	// RocketCore.scala:1001:25
  wire [31:0]      r = {_r[31:1], 1'h0};	// RocketCore.scala:282:19, :323:19, :1001:25, :1002:{35,40}
  wire [31:0]      _GEN_21 = {27'h0, _ibuf_io_inst_0_bits_inst_rs1};	// RocketCore.scala:254:20, :998:35, :1005:62
  wire [31:0]      _id_sboard_hazard_T = r >> _GEN_21;	// RocketCore.scala:998:35, :1002:40
  wire [31:0]      _GEN_22 = {27'h0, _ibuf_io_inst_0_bits_inst_rs2};	// RocketCore.scala:254:20, :998:35, :1005:62
  wire [31:0]      _id_sboard_hazard_T_7 = r >> _GEN_22;	// RocketCore.scala:998:35, :1002:40
  wire [31:0]      _GEN_23 = {27'h0, _ibuf_io_inst_0_bits_inst_rd};	// RocketCore.scala:254:20, :998:35, :1005:62
  wire [31:0]      _id_sboard_hazard_T_14 = r >> _GEN_23;	// RocketCore.scala:998:35, :1002:40
  wire             _fp_data_hazard_ex_T =
    _ibuf_io_inst_0_bits_inst_rs1 == ex_reg_inst[11:7];	// RocketCore.scala:205:24, :254:20, :359:29, :734:70
  wire             _fp_data_hazard_ex_T_2 =
    _ibuf_io_inst_0_bits_inst_rs2 == ex_reg_inst[11:7];	// RocketCore.scala:205:24, :254:20, :359:29, :734:70
  wire             _fp_data_hazard_ex_T_6 =
    _ibuf_io_inst_0_bits_inst_rd == ex_reg_inst[11:7];	// RocketCore.scala:205:24, :254:20, :359:29, :734:70
  wire             _fp_data_hazard_mem_T =
    _ibuf_io_inst_0_bits_inst_rs1 == mem_reg_inst[11:7];	// RocketCore.scala:224:25, :254:20, :360:31, :743:72
  wire             _fp_data_hazard_mem_T_2 =
    _ibuf_io_inst_0_bits_inst_rs2 == mem_reg_inst[11:7];	// RocketCore.scala:224:25, :254:20, :360:31, :743:72
  wire             _fp_data_hazard_mem_T_6 =
    _ibuf_io_inst_0_bits_inst_rd == mem_reg_inst[11:7];	// RocketCore.scala:224:25, :254:20, :360:31, :743:72
  wire             data_hazard_mem =
    mem_ctrl_wxd
    & (_GEN_18 & _fp_data_hazard_mem_T | _GEN_19 & _fp_data_hazard_mem_T_2 | _GEN_20
       & _fp_data_hazard_mem_T_6);	// RocketCore.scala:191:21, :714:42, :715:42, :716:42, :743:{38,72}, :984:{27,50}
  wire             _fp_data_hazard_wb_T =
    _ibuf_io_inst_0_bits_inst_rs1 == wb_reg_inst[11:7];	// RocketCore.scala:243:24, :254:20, :361:29, :749:70
  wire             _fp_data_hazard_wb_T_2 =
    _ibuf_io_inst_0_bits_inst_rs2 == wb_reg_inst[11:7];	// RocketCore.scala:243:24, :254:20, :361:29, :749:70
  wire             _fp_data_hazard_wb_T_6 =
    _ibuf_io_inst_0_bits_inst_rd == wb_reg_inst[11:7];	// RocketCore.scala:243:24, :254:20, :361:29, :749:70
  reg  [31:0]      id_stall_fpu__r;	// RocketCore.scala:1001:25
  wire [31:0]      _id_stall_fpu_T_18 = id_stall_fpu__r >> _GEN_21;	// RocketCore.scala:998:35, :1001:25
  wire [31:0]      _id_stall_fpu_T_21 = id_stall_fpu__r >> _GEN_22;	// RocketCore.scala:998:35, :1001:25
  wire [31:0]      _id_stall_fpu_T_24 = id_stall_fpu__r >> _ibuf_io_inst_0_bits_inst_rs3;	// RocketCore.scala:254:20, :998:35, :1001:25
  wire [31:0]      _id_stall_fpu_T_27 = id_stall_fpu__r >> _GEN_23;	// RocketCore.scala:998:35, :1001:25
  reg              blocked;	// RocketCore.scala:764:22
  wire             _ctrl_stalld_T_28 =
    ex_reg_valid
    & (ex_ctrl_wxd
       & (_GEN_18 & _fp_data_hazard_ex_T | _GEN_19 & _fp_data_hazard_ex_T_2 | _GEN_20
          & _fp_data_hazard_ex_T_6)
       & ((|ex_ctrl_csr) | ex_ctrl_jalr | ex_ctrl_mem | ex_ctrl_mul | ex_ctrl_div
          | ex_ctrl_fp | ex_ctrl_rocc | ex_scie_pipelined) | ex_ctrl_wfd
       & (io_fpu_dec_ren1 & _fp_data_hazard_ex_T | io_fpu_dec_ren2
          & _fp_data_hazard_ex_T_2 | io_fpu_dec_ren3
          & _ibuf_io_inst_0_bits_inst_rs3 == ex_reg_inst[11:7] | io_fpu_dec_wen
          & _fp_data_hazard_ex_T_6)) | mem_reg_valid
    & (data_hazard_mem
       & ((|mem_ctrl_csr) | mem_ctrl_mem & mem_mem_cmd_bh | mem_ctrl_mul | mem_ctrl_div
          | mem_ctrl_fp | mem_ctrl_rocc) | mem_ctrl_wfd
       & (io_fpu_dec_ren1 & _fp_data_hazard_mem_T | io_fpu_dec_ren2
          & _fp_data_hazard_mem_T_2 | io_fpu_dec_ren3
          & _ibuf_io_inst_0_bits_inst_rs3 == mem_reg_inst[11:7] | io_fpu_dec_wen
          & _fp_data_hazard_mem_T_6)) | wb_reg_valid
    & (wb_ctrl_wxd
       & (_GEN_18 & _fp_data_hazard_wb_T | _GEN_19 & _fp_data_hazard_wb_T_2 | _GEN_20
          & _fp_data_hazard_wb_T_6) & wb_set_sboard | wb_ctrl_wfd
       & (io_fpu_dec_ren1 & _fp_data_hazard_wb_T | io_fpu_dec_ren2
          & _fp_data_hazard_wb_T_2 | io_fpu_dec_ren3
          & _ibuf_io_inst_0_bits_inst_rs3 == wb_reg_inst[11:7] | io_fpu_dec_wen
          & _fp_data_hazard_wb_T_6)) | _GEN_18 & _id_sboard_hazard_T[0]
    & ~(ll_wen & ll_waddr == _ibuf_io_inst_0_bits_inst_rs1) | _GEN_19
    & _id_sboard_hazard_T_7[0] & ~(ll_wen & ll_waddr == _ibuf_io_inst_0_bits_inst_rs2)
    | _GEN_20 & _id_sboard_hazard_T_14[0]
    & ~(ll_wen & ll_waddr == _ibuf_io_inst_0_bits_inst_rd) | _csr_io_singleStep
    & (ex_reg_valid | mem_reg_valid | wb_reg_valid) | id_csr_en & _csr_io_decode_0_fp_csr
    & ~io_fpu_fcsr_rdy | id_ctrl_fp
    & (io_fpu_dec_ren1 & _id_stall_fpu_T_18[0] | io_fpu_dec_ren2 & _id_stall_fpu_T_21[0]
       | io_fpu_dec_ren3 & _id_stall_fpu_T_24[0] | io_fpu_dec_wen & _id_stall_fpu_T_27[0])
    | id_ctrl_mem & blocked & ~io_dmem_perf_grant | id_ctrl_div
    & (~(_div_io_req_ready | _div_io_resp_valid & ~wb_wxd) | _div_io_req_valid_T)
    | id_mem_busy
    & (id_ctrl_amo & _ibuf_io_inst_0_bits_inst_bits[25] | id_ctrl_fence_i | id_reg_fence
       & id_ctrl_mem) | _csr_io_csr_stall | id_reg_pause;	// Decode.scala:14:121, :15:30, RocketCore.scala:114:25, :190:20, :191:21, :192:20, :195:35, :205:24, :208:30, :212:36, :219:36, :224:25, :235:35, :243:24, :254:20, :274:25, :282:19, :311:29, :315:38, :321:{17,33,65,81}, :359:29, :360:31, :361:29, :409:19, :410:36, :635:29, :636:53, :649:24, :662:44, :666:14, :667:12, :714:42, :715:42, :716:42, :726:{58,70}, :729:80, :733:{38,139}, :734:70, :735:{39,76}, :736:{35,54,74}, :742:{40,66,131}, :743:{38,72}, :744:{41,78}, :745:{37,57,78}, :749:70, :750:{39,76}, :751:{35,54,71}, :764:22, :765:63, :773:{23,57}, :774:{42,45}, :775:16, :776:17, :778:{17,21,40,62,75}, :781:22, :984:{27,50}, :998:35, package.scala:72:59
  wire             ctrl_killd =
    ~_ibuf_io_inst_0_valid | _ibuf_io_inst_0_bits_replay | take_pc_mem_wb
    | _ctrl_stalld_T_28 | _csr_io_interrupt;	// RocketCore.scala:250:35, :254:20, :282:19, :781:22, :784:{17,104}
  wire             _io_imem_sfence_valid_output = wb_reg_valid & wb_reg_sfence;	// RocketCore.scala:235:35, :240:26, :797:40
  wire             _io_imem_btb_update_bits_cfiType_T_9 = mem_ctrl_jal | mem_ctrl_jalr;	// RocketCore.scala:191:21, :809:23
  wire [38:0]      _io_imem_btb_update_bits_br_pc_T_1 =
    mem_reg_pc[38:0] + {37'h0, ~mem_reg_rvc, 1'h0};	// RocketCore.scala:213:36, :223:23, :282:19, :323:19, :814:{69,74}
  wire [38:0]      _io_imem_btb_update_bits_pc_output =
    {_io_imem_btb_update_bits_br_pc_T_1[38:2], 2'h0};	// RocketCore.scala:814:69, :815:66
  assign _io_dmem_req_valid_output = ex_reg_valid & ex_ctrl_mem;	// RocketCore.scala:190:20, :195:35, :836:41
  reg  [63:0]      coreMonitorBundle_rd0val_x20;	// RocketCore.scala:896:43
  reg  [63:0]      coreMonitorBundle_rd0val_REG;	// RocketCore.scala:896:34
  reg  [63:0]      coreMonitorBundle_rd1val_x26;	// RocketCore.scala:898:43
  reg  [63:0]      coreMonitorBundle_rd1val_REG;	// RocketCore.scala:898:34
  `ifndef SYNTHESIS	// RocketCore.scala:931:13
    always @(posedge clock) begin	// RocketCore.scala:931:13
      if ((`PRINTF_COND_) & _csr_io_trace_0_valid & ~reset) begin	// RocketCore.scala:282:19, :931:13
        automatic logic [31:0] coreMonitorBundle_inst;	// Cat.scala:30:58
        automatic logic        coreMonitorBundle_wrenx = wb_wen & ~wb_set_sboard;	// RocketCore.scala:636:53, :671:25, :891:{37,40}
        automatic logic        _GEN_24;	// RocketCore.scala:937:27
        automatic logic        _GEN_25;	// RocketCore.scala:939:27
        coreMonitorBundle_inst =
          {(&(wb_reg_raw_inst[1:0])) ? wb_reg_inst[31:16] : 16'h0, wb_reg_raw_inst[15:0]};	// Cat.scala:30:58, RocketCore.scala:243:24, :244:28, :687:{50,66,73,91,119}
        _GEN_24 = wb_ctrl_rxs1 | wb_ctrl_rfs1;	// RocketCore.scala:192:20, :937:27
        _GEN_25 = wb_ctrl_rxs2 | wb_ctrl_rfs2;	// RocketCore.scala:192:20, :939:27
        $fwrite(32'h80000002,
                "C%d: %d [%d] pc=[%x] W[r%d=%x][%d] R[r%d=%x] R[r%d=%x] inst=[%x] DASM(%x)\n",
                io_hartid, _csr_io_time[31:0],
                _csr_io_trace_0_valid & ~_csr_io_trace_0_exception,
                {{24{wb_reg_pc[39]}}, wb_reg_pc},
                wb_ctrl_wxd | wb_ctrl_wfd ? wb_reg_inst[11:7] : 5'h0,
                coreMonitorBundle_wrenx ? coreMonitorBundle_wrdata : 64'h0,
                coreMonitorBundle_wrenx, _GEN_24 ? wb_reg_inst[19:15] : 5'h0,
                _GEN_24 ? coreMonitorBundle_rd0val_REG : 64'h0,
                _GEN_25 ? wb_reg_inst[24:20] : 5'h0,
                _GEN_25 ? coreMonitorBundle_rd1val_REG : 64'h0, coreMonitorBundle_inst,
                coreMonitorBundle_inst);	// Bitwise.scala:72:12, Cat.scala:30:58, Mux.scala:80:57, RocketCore.scala:192:20, :241:22, :243:24, :282:19, :361:29, :674:21, :692:29, :889:{52,55}, :891:37, :895:42, :896:34, :897:42, :898:34, :931:13, :934:{13,26}, :935:13, :937:{13,27}, :938:13, :939:{13,27}, :940:13, package.scala:123:38
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    automatic logic [16:0] _GEN_26 =
      {_ibuf_io_inst_0_bits_inst_bits[31:25],
       _ibuf_io_inst_0_bits_inst_bits[14:12],
       _ibuf_io_inst_0_bits_inst_bits[6:0]};	// Decode.scala:14:65, RocketCore.scala:254:20
    automatic logic [13:0] _GEN_27 =
      {_ibuf_io_inst_0_bits_inst_bits[31:25], _ibuf_io_inst_0_bits_inst_bits[6:0]};	// Decode.scala:14:65, RocketCore.scala:254:20
    automatic logic [8:0]  _GEN_28 =
      {_ibuf_io_inst_0_bits_inst_bits[26:25], _ibuf_io_inst_0_bits_inst_bits[6:0]};	// Decode.scala:14:65, RocketCore.scala:254:20
    automatic logic [21:0] _GEN_29 =
      {_ibuf_io_inst_0_bits_inst_bits[31:20],
       _ibuf_io_inst_0_bits_inst_bits[14:12],
       _ibuf_io_inst_0_bits_inst_bits[6:0]};	// Decode.scala:14:65, RocketCore.scala:254:20
    automatic logic [18:0] _GEN_30 =
      {_ibuf_io_inst_0_bits_inst_bits[31:20], _ibuf_io_inst_0_bits_inst_bits[6:0]};	// Decode.scala:14:65, RocketCore.scala:254:20
    automatic logic [15:0] _GEN_31 =
      {_ibuf_io_inst_0_bits_inst_bits[31:26],
       _ibuf_io_inst_0_bits_inst_bits[14:12],
       _ibuf_io_inst_0_bits_inst_bits[6:0]};	// Decode.scala:14:65, RocketCore.scala:254:20
    automatic logic [2:0]  _GEN_32;	// Decode.scala:14:65
    automatic logic [3:0]  _GEN_33;	// Decode.scala:14:65
    automatic logic [1:0]  _GEN_34 =
      {_ibuf_io_inst_0_bits_inst_bits[28], _ibuf_io_inst_0_bits_inst_bits[3]};	// Decode.scala:14:65, RocketCore.scala:254:20
    automatic logic [4:0]  id_ctrl_mem_cmd;	// Cat.scala:30:58
    automatic logic        id_ctrl_fence;	// Decode.scala:14:121
    automatic logic        id_csr_ren;	// RocketCore.scala:285:54
    automatic logic        _id_sfence_T;	// RocketCore.scala:287:50
    automatic logic        _id_illegal_insn_T_45;	// RocketCore.scala:288:32
    automatic logic        id_illegal_insn;	// RocketCore.scala:307:99
    automatic logic        id_xcpt;	// RocketCore.scala:975:26
    automatic logic        _GEN_35;	// RocketCore.scala:364:19
    automatic logic        _GEN_36;	// RocketCore.scala:365:36
    automatic logic        id_bypass_src_1_1;	// RocketCore.scala:367:74
    automatic logic        _id_bypass_src_T_7;	// RocketCore.scala:367:82
    automatic logic        id_bypass_src_1_2;	// RocketCore.scala:367:74
    automatic logic        do_bypass_1;	// RocketCore.scala:464:48
    automatic logic        _GEN_37;	// RocketCore.scala:468:23
    automatic logic        ex_sfence;	// RocketCore.scala:499:48
    automatic logic        mem_pc_valid;	// RocketCore.scala:508:54
    automatic logic        mem_npc_misaligned;	// RocketCore.scala:517:70
    automatic logic        _GEN_38;	// RocketCore.scala:532:23
    automatic logic        _GEN_39;	// RocketCore.scala:191:21, :532:46, :534:28
    automatic logic        _GEN_40;	// RocketCore.scala:559:24
    automatic logic        _GEN_41;	// RocketCore.scala:573:29
    automatic logic        _GEN_42;	// RocketCore.scala:574:20
    automatic logic        mem_xcpt;	// RocketCore.scala:975:26
    automatic logic        ctrl_killm;	// RocketCore.scala:589:45
    _GEN_32 = {_ibuf_io_inst_0_bits_inst_bits[6:5], _ibuf_io_inst_0_bits_inst_bits[3]};	// Decode.scala:14:65, RocketCore.scala:254:20
    _GEN_33 =
      {_ibuf_io_inst_0_bits_inst_bits[13],
       _ibuf_io_inst_0_bits_inst_bits[6],
       _ibuf_io_inst_0_bits_inst_bits[4:3]};	// Decode.scala:14:65, RocketCore.scala:254:20
    id_ctrl_mem_cmd =
      {_ibuf_io_inst_0_bits_inst_bits[6],
       {_ibuf_io_inst_0_bits_inst_bits[28:27], _ibuf_io_inst_0_bits_inst_bits[3]} == 3'h1,
       _ibuf_io_inst_0_bits_inst_bits[6]
         | (&{_ibuf_io_inst_0_bits_inst_bits[27], _ibuf_io_inst_0_bits_inst_bits[3]})
         | (&_GEN_34)
         | (&{_ibuf_io_inst_0_bits_inst_bits[31], _ibuf_io_inst_0_bits_inst_bits[3]}),
       (&_GEN_34)
         | (&{_ibuf_io_inst_0_bits_inst_bits[30], _ibuf_io_inst_0_bits_inst_bits[3]}),
       _GEN_32 == 3'h2
         | (&{_ibuf_io_inst_0_bits_inst_bits[28:27], _ibuf_io_inst_0_bits_inst_bits[5]})
         | (&{_ibuf_io_inst_0_bits_inst_bits[29], _ibuf_io_inst_0_bits_inst_bits[5]})};	// Cat.scala:30:58, Decode.scala:14:{65,121}, :15:30, RocketCore.scala:254:20, :1038:26, :1042:23
    id_ctrl_fence = _GEN_33 == 4'h1;	// Decode.scala:14:{65,121}, Mux.scala:47:69
    id_csr_ren = (_id_csr_ren_T | (&id_ctrl_csr)) & ~(|_ibuf_io_inst_0_bits_inst_rs1);	// Cat.scala:30:58, RocketCore.scala:254:20, :285:54, :1022:45, package.scala:15:47, :72:59
    _id_sfence_T = id_ctrl_mem_cmd == 5'h14;	// Cat.scala:30:58, RocketCore.scala:287:50
    _id_illegal_insn_T_45 = id_ctrl_mem & _id_sfence_T | id_ctrl_csr == 3'h4;	// Cat.scala:30:58, Decode.scala:15:30, RocketCore.scala:284:36, :287:{31,50}, :288:32, :1048:22
    id_illegal_insn =
      ~(_GEN_26 == 17'h433 | _GEN_26 == 17'h4B3 | _GEN_26 == 17'h5B3 | _GEN_26 == 17'h533
        | _GEN_26 == 17'h633 | _GEN_26 == 17'h6B3 | _GEN_26 == 17'h733
        | _GEN_26 == 17'h7B3 | _GEN_26 == 17'h43B | _GEN_26 == 17'h63B
        | _GEN_26 == 17'h6BB | _GEN_26 == 17'h73B | _GEN_26 == 17'h7BB
        | _id_ctrl_decoder_bit_T_478 | _id_ctrl_decoder_bit_T_29
        | _id_ctrl_decoder_bit_T_31 | _id_ctrl_decoder_bit_T_33
        | _id_ctrl_decoder_bit_T_35 | _id_ctrl_decoder_bit_T_37
        | _id_ctrl_decoder_bit_T_39 | _id_ctrl_decoder_bit_T_41
        | _id_ctrl_decoder_bit_T_43 | _id_ctrl_decoder_bit_T_45
        | _id_ctrl_decoder_bit_T_47 | _id_ctrl_decoder_bit_T_49
        | _id_ctrl_decoder_bit_T_51 | _id_ctrl_decoder_bit_T_53
        | _id_ctrl_decoder_bit_T_55 | _id_ctrl_decoder_bit_T_57
        | _id_ctrl_decoder_bit_T_59 | _id_ctrl_decoder_bit_T_61
        | _id_ctrl_decoder_bit_T_63 | _id_ctrl_decoder_bit_T_65
        | _id_ctrl_decoder_bit_T_67 | _id_ctrl_decoder_bit_T_69 | _GEN_26 == 17'h4053
        | _GEN_26 == 17'h4153 | _GEN_26 == 17'h40D3 | _GEN_26 == 17'h5053
        | _GEN_26 == 17'h50D3 | _GEN_27 == 14'h53 | _GEN_27 == 14'h253
        | _GEN_27 == 14'h453 | _GEN_28 == 9'h43 | _GEN_28 == 9'h47 | _GEN_28 == 9'h4F
        | _GEN_28 == 9'h4B | _GEN_29 == 22'h3800D3 | _GEN_29 == 22'h380053
        | _GEN_30 == 19'h60053 | _GEN_30 == 19'h600D3 | _GEN_26 == 17'h14153
        | _GEN_26 == 17'h140D3 | _GEN_26 == 17'h14053 | _GEN_29 == 22'h3C0053
        | _GEN_30 == 19'h68053 | _GEN_30 == 19'h680D3 | _id_ctrl_decoder_bit_T_115
        | _id_ctrl_decoder_bit_T_117 | _GEN_27 == 14'h653 | _GEN_30 == 19'h2C053
        | _GEN_30 == 19'h60153 | _GEN_30 == 19'h601D3 | _GEN_30 == 19'h68153
        | _GEN_30 == 19'h681D3 | _GEN_30 == 19'h200D3 | _GEN_30 == 19'h21053
        | _GEN_26 == 17'h4453 | _GEN_26 == 17'h4553 | _GEN_26 == 17'h44D3
        | _GEN_26 == 17'h5453 | _GEN_26 == 17'h54D3 | _GEN_27 == 14'hD3
        | _GEN_27 == 14'h2D3 | _GEN_27 == 14'h4D3 | _GEN_28 == 9'hC3 | _GEN_28 == 9'hC7
        | _GEN_28 == 9'hCF | _GEN_28 == 9'hCB | _GEN_29 == 22'h3880D3
        | _GEN_30 == 19'h61053 | _GEN_30 == 19'h610D3 | _GEN_26 == 17'h14553
        | _GEN_26 == 17'h144D3 | _GEN_26 == 17'h14453 | _GEN_30 == 19'h69053
        | _GEN_30 == 19'h690D3 | _id_ctrl_decoder_bit_T_175 | _id_ctrl_decoder_bit_T_177
        | _GEN_27 == 14'h6D3 | _GEN_30 == 19'h2D053 | _GEN_29 == 22'h388053
        | _GEN_30 == 19'h61153 | _GEN_30 == 19'h611D3 | _GEN_29 == 22'h3C8053
        | _GEN_30 == 19'h69153 | _GEN_30 == 19'h691D3 | _id_ctrl_decoder_bit_T_195
        | _id_ctrl_decoder_bit_T_197 | _id_ctrl_decoder_bit_T_199 | _GEN_31 == 16'h93
        | _GEN_31 == 16'h293 | _GEN_31 == 16'h4293 | _GEN_2 == 10'h1B | _GEN_26 == 17'h9B
        | _GEN_26 == 17'h29B | _GEN_26 == 17'h829B | _GEN_26 == 17'h3B
        | _GEN_26 == 17'h803B | _GEN_26 == 17'hBB | _GEN_26 == 17'h2BB
        | _GEN_26 == 17'h82BB | _id_ctrl_decoder_bit_T_225
        | _ibuf_io_inst_0_bits_inst_bits == 32'h10200073
        | _ibuf_io_inst_0_bits_inst_bits == 32'h7B200073 | _GEN_2 == 10'h8F
        | _GEN_2 == 10'hE3 | _GEN_2 == 10'h63 | _GEN_2 == 10'h263 | _GEN_2 == 10'h363
        | _GEN_2 == 10'h2E3 | _GEN_2 == 10'h3E3
        | _ibuf_io_inst_0_bits_inst_bits[6:0] == 7'h6F | _GEN_2 == 10'h67
        | _ibuf_io_inst_0_bits_inst_bits[6:0] == 7'h17 | _id_ctrl_decoder_bit_T_249
        | _id_ctrl_decoder_bit_T_251 | _id_ctrl_decoder_bit_T_253
        | _id_ctrl_decoder_bit_T_255 | _id_ctrl_decoder_bit_T_257
        | _id_ctrl_decoder_bit_T_259 | _id_ctrl_decoder_bit_T_261
        | _id_ctrl_decoder_bit_T_263 | _ibuf_io_inst_0_bits_inst_bits[6:0] == 7'h37
        | _GEN_2 == 10'h13 | _GEN_2 == 10'h113 | _GEN_2 == 10'h193 | _GEN_2 == 10'h393
        | _GEN_2 == 10'h313 | _GEN_2 == 10'h213 | _GEN_26 == 17'h33 | _GEN_26 == 17'h8033
        | _GEN_26 == 17'h133 | _GEN_26 == 17'h1B3 | _GEN_26 == 17'h3B3
        | _GEN_26 == 17'h333 | _GEN_26 == 17'h233 | _GEN_26 == 17'hB3 | _GEN_26 == 17'h2B3
        | _GEN_26 == 17'h82B3 | _GEN_2 == 10'hF | _ibuf_io_inst_0_bits_inst_bits == 32'h73
        | _ibuf_io_inst_0_bits_inst_bits == 32'h100073
        | _ibuf_io_inst_0_bits_inst_bits == 32'h30200073
        | _ibuf_io_inst_0_bits_inst_bits == 32'h10500073
        | _ibuf_io_inst_0_bits_inst_bits == 32'h30500073 | _GEN_2 == 10'hF3
        | _GEN_2 == 10'h173 | _GEN_2 == 10'h1F3 | _GEN_2 == 10'h2F3 | _GEN_2 == 10'h373
        | _GEN_2 == 10'h3F3) | id_ctrl_div & ~(_csr_io_status_isa[12]) | id_ctrl_amo
      & ~(_csr_io_status_isa[0]) | id_ctrl_fp
      & (_csr_io_decode_0_fp_illegal | io_fpu_illegal_rm)
      | ({_ibuf_io_inst_0_bits_inst_bits[12],
          _ibuf_io_inst_0_bits_inst_bits[6],
          _ibuf_io_inst_0_bits_inst_bits[4:2]} == 5'h11
         | {_ibuf_io_inst_0_bits_inst_bits[25],
            _ibuf_io_inst_0_bits_inst_bits[6:5]} == 3'h6
         | {_ibuf_io_inst_0_bits_inst_bits[31:30],
            _ibuf_io_inst_0_bits_inst_bits[28],
            _ibuf_io_inst_0_bits_inst_bits[6:4]} == 6'h15) & ~(_csr_io_status_isa[3])
      | _ibuf_io_inst_0_bits_rvc & ~(_csr_io_status_isa[2]) | id_csr_en
      & (_csr_io_decode_0_read_illegal | ~id_csr_ren & _csr_io_decode_0_write_illegal)
      | ~_ibuf_io_inst_0_bits_rvc & _id_illegal_insn_T_45
      & _csr_io_decode_0_system_illegal;	// Consts.scala:82:49, Decode.scala:14:{65,121}, :15:30, RocketCore.scala:254:20, :282:19, :285:54, :288:{32,67}, :296:25, :297:{34,37,55}, :298:{17,20,38}, :299:{16,48}, :300:{16,19,37}, :301:{30,33,51}, :307:{15,49,64,99}, :308:{5,31}, package.scala:15:47, :72:59
    id_xcpt =
      _csr_io_interrupt | _bpu_io_debug_if | _bpu_io_xcpt_if
      | _ibuf_io_inst_0_bits_xcpt0_pf_inst | _ibuf_io_inst_0_bits_xcpt0_ae_inst
      | _ibuf_io_inst_0_bits_xcpt1_pf_inst | _ibuf_io_inst_0_bits_xcpt1_ae_inst
      | id_illegal_insn;	// RocketCore.scala:254:20, :282:19, :307:99, :323:19, :975:26
    _GEN_35 = ex_reg_valid & ex_ctrl_wxd;	// RocketCore.scala:190:20, :195:35, :364:19
    _GEN_36 = _dcache_kill_mem_T & ~mem_ctrl_mem;	// RocketCore.scala:191:21, :365:{20,36,39}
    id_bypass_src_1_1 = _GEN_35 & ex_reg_inst[11:7] == _ibuf_io_inst_0_bits_inst_rs2;	// RocketCore.scala:205:24, :254:20, :359:29, :364:19, :367:{74,82}
    _id_bypass_src_T_7 = mem_reg_inst[11:7] == _ibuf_io_inst_0_bits_inst_rs2;	// RocketCore.scala:224:25, :254:20, :360:31, :367:82
    id_bypass_src_1_2 = _GEN_36 & _id_bypass_src_T_7;	// RocketCore.scala:365:36, :367:{74,82}
    do_bypass_1 =
      ~(|_ibuf_io_inst_0_bits_inst_rs2) | id_bypass_src_1_1 | id_bypass_src_1_2
      | _dcache_kill_mem_T & _id_bypass_src_T_7;	// RocketCore.scala:254:20, :365:20, :367:{74,82}, :464:48
    _GEN_37 = id_ctrl_rxs2 & ~do_bypass_1;	// Decode.scala:15:30, RocketCore.scala:464:48, :468:{23,26}
    ex_sfence = ex_ctrl_mem & ex_ctrl_mem_cmd == 5'h14;	// RocketCore.scala:190:20, :287:50, :499:{48,67}
    mem_pc_valid = mem_reg_valid | mem_reg_replay | mem_reg_xcpt_interrupt;	// RocketCore.scala:211:36, :212:36, :216:36, :508:54
    mem_npc_misaligned = ~(_csr_io_status_isa[2]) & _mem_npc_T_3[1] & ~mem_reg_sfence;	// RocketCore.scala:222:27, :282:19, :301:51, :513:{21,129}, :517:{28,66,70,73}
    _GEN_38 = mem_reg_valid & mem_reg_flush_pipe;	// RocketCore.scala:212:36, :217:36, :532:23
    _GEN_39 = _GEN_38 | ~ex_pc_valid;	// RocketCore.scala:191:21, :490:51, :532:{23,46}, :534:28
    _GEN_40 = ex_ctrl_jalr & _csr_io_status_debug;	// RocketCore.scala:190:20, :282:19, :559:24
    _GEN_41 = mem_reg_xcpt_interrupt | mem_reg_xcpt;	// RocketCore.scala:211:36, :215:36, :573:29
    _GEN_42 = mem_reg_valid & mem_npc_misaligned;	// RocketCore.scala:212:36, :517:70, :574:20
    mem_xcpt = _GEN_41 | _GEN_42 | mem_reg_valid & mem_ldst_xcpt;	// RocketCore.scala:212:36, :573:29, :574:20, :575:20, :975:26
    ctrl_killm = killm_common | mem_xcpt | fpu_kill_mem;	// RocketCore.scala:585:51, :587:68, :589:45, :975:26
    id_reg_pause <=
      ~(_csr_io_time[4:0] == 5'h0 | _csr_io_inhibit_cycle | io_dmem_perf_release
        | take_pc_mem_wb)
      & (~ctrl_killd & id_ctrl_fence & _ibuf_io_inst_0_bits_inst_bits[23:20] == 4'h0
         | id_reg_pause);	// Decode.scala:14:121, Mux.scala:47:69, RocketCore.scala:114:25, :250:35, :254:20, :282:19, :313:33, :423:19, :428:22, :434:{42,49,64}, :784:104, :861:{28,62,116}, :862:{18,33}
    imem_might_request_reg <= ex_pc_valid | mem_pc_valid | _csr_io_customCSRs_0_value[1];	// CustomCSRs.scala:38:61, RocketCore.scala:115:35, :282:19, :490:51, :508:54, :794:59
    if (~ctrl_killd) begin	// RocketCore.scala:784:104
      automatic logic       _id_ctrl_decoder_T_79 =
        _ibuf_io_inst_0_bits_inst_bits[4:3] == 2'h1;	// Decode.scala:14:{65,121}, Mux.scala:80:60, RocketCore.scala:254:20
      automatic logic [1:0] _GEN_43 =
        {_ibuf_io_inst_0_bits_inst_bits[4], _ibuf_io_inst_0_bits_inst_bits[2]};	// Decode.scala:14:65, RocketCore.scala:254:20
      automatic logic       _id_ctrl_decoder_T_178 =
        {_ibuf_io_inst_0_bits_inst_bits[31], _ibuf_io_inst_0_bits_inst_bits[6:5]} == 3'h2;	// Decode.scala:14:{65,121}, RocketCore.scala:254:20, :1038:26
      automatic logic [2:0] _GEN_44 =
        {_ibuf_io_inst_0_bits_inst_bits[28], _ibuf_io_inst_0_bits_inst_bits[6:5]};	// Decode.scala:14:65, RocketCore.scala:254:20
      automatic logic       id_ctrl_decoder_18 =
        _ibuf_io_inst_0_bits_inst_bits[6:4] == 3'h4;	// Decode.scala:14:{65,121}, RocketCore.scala:254:20, :1048:22
      automatic logic       id_bypass_src_0_1;	// RocketCore.scala:367:74
      automatic logic       _id_bypass_src_T_3;	// RocketCore.scala:367:82
      automatic logic       id_bypass_src_0_2;	// RocketCore.scala:367:74
      automatic logic [1:0] _GEN_45;	// RocketCore.scala:441:22
      automatic logic       do_bypass;	// RocketCore.scala:464:48
      id_bypass_src_0_1 = _GEN_35 & ex_reg_inst[11:7] == _ibuf_io_inst_0_bits_inst_rs1;	// RocketCore.scala:205:24, :254:20, :359:29, :364:19, :367:{74,82}
      _id_bypass_src_T_3 = mem_reg_inst[11:7] == _ibuf_io_inst_0_bits_inst_rs1;	// RocketCore.scala:224:25, :254:20, :360:31, :367:82
      id_bypass_src_0_2 = _GEN_36 & _id_bypass_src_T_3;	// RocketCore.scala:365:36, :367:{74,82}
      _GEN_45 = {_ibuf_io_inst_0_bits_xcpt1_pf_inst, _ibuf_io_inst_0_bits_xcpt1_ae_inst};	// RocketCore.scala:254:20, :441:22
      do_bypass =
        ~(|_ibuf_io_inst_0_bits_inst_rs1) | id_bypass_src_0_1 | id_bypass_src_0_2
        | _dcache_kill_mem_T & _id_bypass_src_T_3;	// RocketCore.scala:254:20, :365:20, :367:{74,82}, :464:48, :1022:45
      ex_ctrl_fp <= id_ctrl_fp;	// Decode.scala:15:30, RocketCore.scala:190:20
      ex_ctrl_branch <=
        {_ibuf_io_inst_0_bits_inst_bits[6:4], _ibuf_io_inst_0_bits_inst_bits[2]} == 4'hC;	// Decode.scala:14:{65,121}, Mux.scala:47:69, RocketCore.scala:190:20, :254:20
      ex_ctrl_jal <= &_GEN_32;	// Decode.scala:14:{65,121}, RocketCore.scala:190:20
      ex_ctrl_jalr <=
        {_ibuf_io_inst_0_bits_inst_bits[13], _ibuf_io_inst_0_bits_inst_bits[5:2]} == 5'h9;	// Decode.scala:14:{65,121}, RocketCore.scala:190:20, :254:20, package.scala:15:47
      ex_ctrl_rxs2 <= id_ctrl_rxs2;	// Decode.scala:15:30, RocketCore.scala:190:20
      ex_ctrl_rxs1 <= id_ctrl_rxs1;	// Decode.scala:15:30, RocketCore.scala:190:20
      if (id_xcpt) begin	// RocketCore.scala:975:26
        automatic logic _GEN_46 =
          _bpu_io_xcpt_if
          | (|{_ibuf_io_inst_0_bits_xcpt0_pf_inst, _ibuf_io_inst_0_bits_xcpt0_ae_inst});	// RocketCore.scala:254:20, :323:19, :446:{28,40,47}
        if (_GEN_46)	// RocketCore.scala:446:28
          ex_ctrl_sel_alu2 <= 2'h0;	// RocketCore.scala:190:20
        else	// RocketCore.scala:446:28
          ex_ctrl_sel_alu2 <= {1'h0, |_GEN_45};	// RocketCore.scala:190:20, :282:19, :323:19, :440:24, :441:{22,29,34}, :443:26
        if (_GEN_46 | (|_GEN_45))	// RocketCore.scala:439:24, :441:{22,29,34}, :442:26, :446:{28,52}, :447:26
          ex_ctrl_sel_alu1 <= 2'h2;	// Mux.scala:47:69, RocketCore.scala:190:20
        else	// RocketCore.scala:439:24, :441:34, :442:26, :446:52, :447:26
          ex_ctrl_sel_alu1 <= 2'h1;	// Mux.scala:80:60, RocketCore.scala:190:20
        ex_ctrl_alu_fn <= 4'h0;	// Mux.scala:47:69, RocketCore.scala:190:20
      end
      else begin	// RocketCore.scala:975:26
        automatic logic [1:0] _GEN_47 =
          {_ibuf_io_inst_0_bits_inst_bits[6], _ibuf_io_inst_0_bits_inst_bits[3]};	// Decode.scala:14:65, RocketCore.scala:254:20
        automatic logic       _id_ctrl_decoder_T_53 =
          _ibuf_io_inst_0_bits_inst_bits[4:3] == 2'h0;	// Decode.scala:14:{65,121}, RocketCore.scala:254:20
        automatic logic [4:0] _GEN_48 =
          {_ibuf_io_inst_0_bits_inst_bits[13:12],
           _ibuf_io_inst_0_bits_inst_bits[6],
           _ibuf_io_inst_0_bits_inst_bits[4],
           _ibuf_io_inst_0_bits_inst_bits[2]};	// Decode.scala:14:65, RocketCore.scala:254:20
        automatic logic       _id_ctrl_decoder_T_115 =
          {_ibuf_io_inst_0_bits_inst_bits[30],
           _ibuf_io_inst_0_bits_inst_bits[13:12],
           _ibuf_io_inst_0_bits_inst_bits[5:4],
           _ibuf_io_inst_0_bits_inst_bits[2]} == 6'h26;	// Decode.scala:14:{65,121}, RocketCore.scala:254:20
        automatic logic       _id_ctrl_decoder_T_133 =
          {_ibuf_io_inst_0_bits_inst_bits[14],
           _ibuf_io_inst_0_bits_inst_bits[6],
           _ibuf_io_inst_0_bits_inst_bits[4:3]} == 4'hC;	// Decode.scala:14:{65,121}, Mux.scala:47:69, RocketCore.scala:254:20
        ex_ctrl_sel_alu2 <=
          {_GEN_47 == 2'h0 | _id_ctrl_decoder_T_32 | _id_ctrl_decoder_T_53
             | {_ibuf_io_inst_0_bits_inst_bits[14],
                _ibuf_io_inst_0_bits_inst_bits[3]} == 2'h2,
           {_ibuf_io_inst_0_bits_inst_bits[6],
            _ibuf_io_inst_0_bits_inst_bits[4:3]} == 3'h0
             | ~(_ibuf_io_inst_0_bits_inst_bits[5])
             | _ibuf_io_inst_0_bits_inst_bits[3:2] == 2'h1 | (&_GEN_47)
             | (&{_ibuf_io_inst_0_bits_inst_bits[14],
                  _ibuf_io_inst_0_bits_inst_bits[6],
                  _ibuf_io_inst_0_bits_inst_bits[4]})};	// Cat.scala:30:58, Decode.scala:14:{65,121}, :15:30, Mux.scala:47:69, :80:60, RocketCore.scala:190:20, :254:20, :1045:24
        ex_ctrl_sel_alu1 <=
          {_GEN_4 == 3'h3 | (&_GEN_47),
           {_ibuf_io_inst_0_bits_inst_bits[14], _ibuf_io_inst_0_bits_inst_bits[2]} == 2'h0
             | _GEN_6 == 2'h0 | _id_ctrl_decoder_T_32
             | {_ibuf_io_inst_0_bits_inst_bits[5],
                _ibuf_io_inst_0_bits_inst_bits[2]} == 2'h0 | _id_ctrl_decoder_T_53};	// Cat.scala:30:58, Decode.scala:14:{65,121}, :15:30, RocketCore.scala:190:20, :254:20, :1037:24
        ex_ctrl_alu_fn <=
          {{_ibuf_io_inst_0_bits_inst_bits[25],
            _ibuf_io_inst_0_bits_inst_bits[14:13],
            _ibuf_io_inst_0_bits_inst_bits[6],
            _ibuf_io_inst_0_bits_inst_bits[4],
            _ibuf_io_inst_0_bits_inst_bits[2]} == 6'hA
             | {_ibuf_io_inst_0_bits_inst_bits[14:13],
                _ibuf_io_inst_0_bits_inst_bits[5:4],
                _ibuf_io_inst_0_bits_inst_bits[2]} == 5'hA | _id_ctrl_decoder_T_133
             | _id_ctrl_decoder_T_115
             | {_ibuf_io_inst_0_bits_inst_bits[30],
                _ibuf_io_inst_0_bits_inst_bits[13:12],
                _ibuf_io_inst_0_bits_inst_bits[6],
                _ibuf_io_inst_0_bits_inst_bits[4],
                _ibuf_io_inst_0_bits_inst_bits[2]} == 6'h2A,
           {_ibuf_io_inst_0_bits_inst_bits[25],
            _ibuf_io_inst_0_bits_inst_bits[13],
            _ibuf_io_inst_0_bits_inst_bits[6],
            _ibuf_io_inst_0_bits_inst_bits[4],
            _ibuf_io_inst_0_bits_inst_bits[2]} == 5'hA
             | {_ibuf_io_inst_0_bits_inst_bits[13],
                _ibuf_io_inst_0_bits_inst_bits[5:4],
                _ibuf_io_inst_0_bits_inst_bits[2]} == 4'hA
             | {_ibuf_io_inst_0_bits_inst_bits[30],
                _ibuf_io_inst_0_bits_inst_bits[14],
                _ibuf_io_inst_0_bits_inst_bits[6],
                _ibuf_io_inst_0_bits_inst_bits[4],
                _ibuf_io_inst_0_bits_inst_bits[2]} == 5'hA
             | {_ibuf_io_inst_0_bits_inst_bits[14],
                _ibuf_io_inst_0_bits_inst_bits[12],
                _ibuf_io_inst_0_bits_inst_bits[6],
                _ibuf_io_inst_0_bits_inst_bits[4],
                _ibuf_io_inst_0_bits_inst_bits[2]} == 5'h12 | _id_ctrl_decoder_T_133,
           {_ibuf_io_inst_0_bits_inst_bits[14],
            _ibuf_io_inst_0_bits_inst_bits[6],
            _ibuf_io_inst_0_bits_inst_bits[4],
            _ibuf_io_inst_0_bits_inst_bits[2]} == 4'h4 | _GEN_33 == 4'hC
             | _GEN_48 == 5'h1A
             | {_ibuf_io_inst_0_bits_inst_bits[14:13],
                _ibuf_io_inst_0_bits_inst_bits[6],
                _ibuf_io_inst_0_bits_inst_bits[4],
                _ibuf_io_inst_0_bits_inst_bits[2]} == 5'h1A
             | {_ibuf_io_inst_0_bits_inst_bits[25],
                _ibuf_io_inst_0_bits_inst_bits[13],
                _ibuf_io_inst_0_bits_inst_bits[6:4],
                _ibuf_io_inst_0_bits_inst_bits[2]} == 6'h36 | _id_ctrl_decoder_T_115
             | {_ibuf_io_inst_0_bits_inst_bits[30],
                _ibuf_io_inst_0_bits_inst_bits[12],
                _ibuf_io_inst_0_bits_inst_bits[6],
                _ibuf_io_inst_0_bits_inst_bits[4],
                _ibuf_io_inst_0_bits_inst_bits[2]} == 5'h1A,
           _GEN_48 == 5'hA
             | {_ibuf_io_inst_0_bits_inst_bits[12],
                _ibuf_io_inst_0_bits_inst_bits[6],
                _ibuf_io_inst_0_bits_inst_bits[4:3]} == 4'hC
             | {_ibuf_io_inst_0_bits_inst_bits[14:12],
                _ibuf_io_inst_0_bits_inst_bits[6],
                _ibuf_io_inst_0_bits_inst_bits[2]} == 5'h1C
             | {_ibuf_io_inst_0_bits_inst_bits[25],
                _ibuf_io_inst_0_bits_inst_bits[12],
                _ibuf_io_inst_0_bits_inst_bits[6:4],
                _ibuf_io_inst_0_bits_inst_bits[2]} == 6'h36};	// Cat.scala:30:58, Decode.scala:14:{65,121}, :15:30, Mux.scala:47:69, RocketCore.scala:190:20, :254:20, package.scala:15:47
      end
      ex_ctrl_sel_imm <=
        {_ibuf_io_inst_0_bits_inst_bits[5:4] == 2'h0
           | {_ibuf_io_inst_0_bits_inst_bits[13],
              _ibuf_io_inst_0_bits_inst_bits[4:2]} == 4'h1 | _GEN_43 == 2'h2,
         _id_ctrl_decoder_T_79 | (&_GEN_43),
         _id_ctrl_decoder_T_79 | _GEN_5 == 2'h2};	// Cat.scala:30:58, Decode.scala:14:{65,121}, :15:30, Mux.scala:47:69, RocketCore.scala:190:20, :254:20
      ex_ctrl_alu_dw <=
        id_xcpt | ~(_ibuf_io_inst_0_bits_inst_bits[4])
        | ~(_ibuf_io_inst_0_bits_inst_bits[3]);	// Decode.scala:14:{65,121}, RocketCore.scala:190:20, :254:20, :429:13, :436:20, :438:22, :975:26
      ex_ctrl_mem <= id_ctrl_mem;	// Decode.scala:15:30, RocketCore.scala:190:20
      ex_ctrl_mem_cmd <= id_ctrl_mem_cmd;	// Cat.scala:30:58, RocketCore.scala:190:20
      ex_ctrl_rfs1 <= _id_ctrl_decoder_T_178 | _GEN_44 == 3'h2 | id_ctrl_decoder_18;	// Decode.scala:14:{65,121}, :15:30, RocketCore.scala:190:20, :1038:26
      ex_ctrl_rfs2 <=
        _ibuf_io_inst_0_bits_inst_bits[6:2] == 5'h9
        | {_ibuf_io_inst_0_bits_inst_bits[30],
           _ibuf_io_inst_0_bits_inst_bits[6:5]} == 3'h2 | id_ctrl_decoder_18
        | {_ibuf_io_inst_0_bits_inst_bits[31],
           _ibuf_io_inst_0_bits_inst_bits[28],
           _ibuf_io_inst_0_bits_inst_bits[6:5]} == 4'h6;	// Decode.scala:14:{65,121}, :15:30, Mux.scala:47:69, RocketCore.scala:190:20, :254:20, :1038:26, package.scala:15:47
      ex_ctrl_wfd <=
        _ibuf_io_inst_0_bits_inst_bits[5:2] == 4'h1 | _id_ctrl_decoder_T_178
        | id_ctrl_decoder_18 | _GEN_44 == 3'h6;	// Decode.scala:14:{65,121}, :15:30, Mux.scala:47:69, RocketCore.scala:190:20, :254:20, package.scala:15:47
      ex_ctrl_div <= id_ctrl_div;	// Decode.scala:14:121, RocketCore.scala:190:20
      ex_ctrl_wxd <= id_ctrl_wxd;	// Decode.scala:15:30, RocketCore.scala:190:20
      if (id_csr_ren)	// RocketCore.scala:285:54
        ex_ctrl_csr <= 3'h2;	// RocketCore.scala:190:20, :1038:26
      else	// RocketCore.scala:285:54
        ex_ctrl_csr <= id_ctrl_csr;	// Cat.scala:30:58, RocketCore.scala:190:20
      ex_ctrl_fence_i <= id_ctrl_fence_i;	// Decode.scala:14:121, RocketCore.scala:190:20
      ex_reg_rvc <= id_xcpt & (|_GEN_45) | _ibuf_io_inst_0_bits_rvc;	// RocketCore.scala:196:35, :254:20, :430:16, :436:20, :441:{22,29,34}, :444:20, :975:26
      ex_reg_flush_pipe <=
        id_ctrl_fence_i | _id_illegal_insn_T_45 | id_csr_en & ~id_csr_ren
        & _csr_io_decode_0_write_flush;	// Decode.scala:14:121, RocketCore.scala:199:35, :282:19, :285:54, :288:{32,67,79}, :451:42, package.scala:72:59
      ex_reg_load_use <= mem_reg_valid & data_hazard_mem & mem_ctrl_mem;	// RocketCore.scala:191:21, :200:35, :212:36, :743:38, :746:51
      if (_id_sfence_T | id_ctrl_mem_cmd == 5'h5)	// Cat.scala:30:58, RocketCore.scala:287:50, package.scala:15:47, :72:59
        ex_reg_mem_size <=
          {|_ibuf_io_inst_0_bits_inst_rs2, |_ibuf_io_inst_0_bits_inst_rs1};	// Cat.scala:30:58, RocketCore.scala:204:28, :254:20, :455:{40,63}
      else	// package.scala:72:59
        ex_reg_mem_size <= _ibuf_io_inst_0_bits_inst_bits[13:12];	// RocketCore.scala:204:28, :254:20, :453:34
      ex_reg_rs_bypass_0 <= ~id_illegal_insn & do_bypass;	// RocketCore.scala:307:99, :371:29, :464:48, :466:27, :473:28, :475:27
      ex_reg_rs_bypass_1 <= do_bypass_1;	// RocketCore.scala:371:29, :464:48
      if (id_illegal_insn) begin	// RocketCore.scala:307:99
        automatic logic [31:0] inst =
          _ibuf_io_inst_0_bits_rvc
            ? {16'h0, _ibuf_io_inst_0_bits_raw[15:0]}
            : _ibuf_io_inst_0_bits_raw;	// RocketCore.scala:254:20, :474:{21,62}, :687:50
        ex_reg_rs_lsb_0 <= inst[1:0];	// RocketCore.scala:372:26, :474:21, :476:31
        ex_reg_rs_msb_0 <= {32'h0, inst[31:2]};	// RocketCore.scala:373:26, :474:21, :477:{24,32}
      end
      else if (id_ctrl_rxs1 & ~do_bypass) begin	// Decode.scala:15:30, RocketCore.scala:464:48, :468:{23,26}
        ex_reg_rs_lsb_0 <= id_rs_0[1:0];	// RocketCore.scala:372:26, :469:37, :679:17, :1022:19, :1027:29, :1030:{31,39}
        ex_reg_rs_msb_0 <= id_rs_0[63:2];	// RocketCore.scala:373:26, :470:38, :679:17, :1022:19, :1027:29, :1030:{31,39}
      end
      else if (|_ibuf_io_inst_0_bits_inst_rs1) begin	// RocketCore.scala:254:20, :1022:45
        if (id_bypass_src_0_1)	// RocketCore.scala:367:74
          ex_reg_rs_lsb_0 <= 2'h1;	// Mux.scala:80:60, RocketCore.scala:372:26
        else	// RocketCore.scala:367:74
          ex_reg_rs_lsb_0 <= {1'h1, ~id_bypass_src_0_2};	// Mux.scala:47:69, RocketCore.scala:367:74, :372:26
      end
      else	// RocketCore.scala:1022:45
        ex_reg_rs_lsb_0 <= 2'h0;	// RocketCore.scala:372:26
      if (_GEN_37)	// RocketCore.scala:468:23
        ex_reg_rs_lsb_1 <= id_rs_1[1:0];	// RocketCore.scala:372:26, :469:37, :679:17, :1022:19, :1027:29, :1030:{31,39}
      else if (|_ibuf_io_inst_0_bits_inst_rs2) begin	// RocketCore.scala:254:20, :367:82
        if (id_bypass_src_1_1)	// RocketCore.scala:367:74
          ex_reg_rs_lsb_1 <= 2'h1;	// Mux.scala:80:60, RocketCore.scala:372:26
        else	// RocketCore.scala:367:74
          ex_reg_rs_lsb_1 <= {1'h1, ~id_bypass_src_1_2};	// Mux.scala:47:69, RocketCore.scala:367:74, :372:26
      end
      else	// RocketCore.scala:367:82
        ex_reg_rs_lsb_1 <= 2'h0;	// RocketCore.scala:372:26
    end
    ex_ctrl_rocc <= ctrl_killd & ex_ctrl_rocc;	// RocketCore.scala:190:20, :428:22, :429:13, :784:104
    ex_ctrl_mul <= ctrl_killd & ex_ctrl_mul;	// RocketCore.scala:190:20, :428:22, :429:13, :784:104
    if (_GEN_39) begin	// RocketCore.scala:191:21, :532:46, :534:28
    end
    else begin	// RocketCore.scala:191:21, :532:46, :534:28
      mem_ctrl_fp <= ex_ctrl_fp;	// RocketCore.scala:190:20, :191:21
      mem_ctrl_rocc <= ex_ctrl_rocc;	// RocketCore.scala:190:20, :191:21
      mem_ctrl_branch <= ex_ctrl_branch;	// RocketCore.scala:190:20, :191:21
      mem_ctrl_jal <= ex_ctrl_jal;	// RocketCore.scala:190:20, :191:21
      mem_ctrl_jalr <= ex_ctrl_jalr;	// RocketCore.scala:190:20, :191:21
      mem_ctrl_rxs2 <= ex_ctrl_rxs2;	// RocketCore.scala:190:20, :191:21
      mem_ctrl_rxs1 <= ex_ctrl_rxs1;	// RocketCore.scala:190:20, :191:21
      mem_ctrl_mem <= ex_ctrl_mem;	// RocketCore.scala:190:20, :191:21
      mem_ctrl_rfs1 <= ex_ctrl_rfs1;	// RocketCore.scala:190:20, :191:21
      mem_ctrl_rfs2 <= ex_ctrl_rfs2;	// RocketCore.scala:190:20, :191:21
      mem_ctrl_wfd <= ex_ctrl_wfd;	// RocketCore.scala:190:20, :191:21
      mem_ctrl_mul <= ex_ctrl_mul;	// RocketCore.scala:190:20, :191:21
      mem_ctrl_div <= ex_ctrl_div;	// RocketCore.scala:190:20, :191:21
      mem_ctrl_wxd <= ex_ctrl_wxd;	// RocketCore.scala:190:20, :191:21
      mem_ctrl_csr <= ex_ctrl_csr;	// RocketCore.scala:190:20, :191:21
      mem_ctrl_fence_i <= _GEN_40 | ex_ctrl_fence_i;	// RocketCore.scala:190:20, :191:21, :535:14, :559:{24,48}, :561:24
    end
    if (mem_pc_valid) begin	// RocketCore.scala:508:54
      wb_ctrl_rocc <= mem_ctrl_rocc;	// RocketCore.scala:191:21, :192:20
      wb_ctrl_rxs2 <= mem_ctrl_rxs2;	// RocketCore.scala:191:21, :192:20
      wb_ctrl_rxs1 <= mem_ctrl_rxs1;	// RocketCore.scala:191:21, :192:20
      wb_ctrl_mem <= mem_ctrl_mem;	// RocketCore.scala:191:21, :192:20
      wb_ctrl_rfs1 <= mem_ctrl_rfs1;	// RocketCore.scala:191:21, :192:20
      wb_ctrl_rfs2 <= mem_ctrl_rfs2;	// RocketCore.scala:191:21, :192:20
      wb_ctrl_wfd <= mem_ctrl_wfd;	// RocketCore.scala:191:21, :192:20
      wb_ctrl_div <= mem_ctrl_div;	// RocketCore.scala:191:21, :192:20
      wb_ctrl_wxd <= mem_ctrl_wxd;	// RocketCore.scala:191:21, :192:20
      wb_ctrl_csr <= mem_ctrl_csr;	// RocketCore.scala:191:21, :192:20
      wb_ctrl_fence_i <= mem_ctrl_fence_i;	// RocketCore.scala:191:21, :192:20
      if (_GEN_41)	// RocketCore.scala:573:29
        wb_reg_cause <= mem_reg_cause;	// RocketCore.scala:218:36, :239:35
      else	// RocketCore.scala:573:29
        wb_reg_cause <= {60'h0, _GEN_42 ? 4'h0 : mem_debug_breakpoint ? 4'hE : 4'h3};	// Mux.scala:47:69, RocketCore.scala:239:35, :567:64, :574:20
      wb_reg_sfence <= mem_reg_sfence;	// RocketCore.scala:222:27, :240:26
      wb_reg_pc <= mem_reg_pc;	// RocketCore.scala:223:23, :241:22
      wb_reg_mem_size <= mem_reg_mem_size;	// RocketCore.scala:225:29, :242:28
      wb_reg_inst <= mem_reg_inst;	// RocketCore.scala:224:25, :243:24
      wb_reg_raw_inst <= mem_reg_raw_inst;	// RocketCore.scala:226:29, :244:28
      if (mem_scie_pipelined)	// RocketCore.scala:228:31
        wb_reg_wdata <= 64'h0;	// Mux.scala:80:57, RocketCore.scala:245:25
      else if (~mem_reg_xcpt & mem_ctrl_fp & mem_ctrl_wxd)	// RocketCore.scala:191:21, :215:36, :518:27, :600:40
        wb_reg_wdata <= io_fpu_toint_data;	// RocketCore.scala:245:25
      else if (~mem_reg_xcpt & (mem_ctrl_jalr ^ mem_npc_misaligned))	// RocketCore.scala:191:21, :215:36, :517:70, :518:{27,41,59}
        wb_reg_wdata <= {{24{_mem_br_target_T_9[39]}}, _mem_br_target_T_9};	// RocketCore.scala:245:25, :509:41, :518:26
      else	// RocketCore.scala:518:41
        wb_reg_wdata <= mem_reg_wdata;	// RocketCore.scala:229:26, :245:25
    end
    ex_reg_xcpt_interrupt <= ~take_pc_mem_wb & _ibuf_io_inst_0_valid & _csr_io_interrupt;	// RocketCore.scala:194:35, :250:35, :254:20, :282:19, :424:20, :426:62
    ex_reg_valid <= ~ctrl_killd;	// RocketCore.scala:195:35, :423:19, :784:104
    if (~ctrl_killd | _csr_io_interrupt | _ibuf_io_inst_0_bits_replay) begin	// RocketCore.scala:254:20, :282:19, :423:19, :480:41, :784:104
      ex_reg_btb_resp_entry <= _ibuf_io_btb_resp_entry;	// RocketCore.scala:197:35, :254:20
      ex_reg_btb_resp_bht_history <= _ibuf_io_btb_resp_bht_history;	// RocketCore.scala:197:35, :254:20
      if (_csr_io_interrupt)	// RocketCore.scala:282:19
        ex_reg_cause <= _csr_io_interrupt_cause;	// RocketCore.scala:201:35, :282:19
      else	// RocketCore.scala:282:19
        ex_reg_cause <=
          {60'h0,
           _bpu_io_debug_if
             ? 4'hE
             : _bpu_io_xcpt_if
                 ? 4'h3
                 : _ibuf_io_inst_0_bits_xcpt0_pf_inst
                     ? 4'hC
                     : _ibuf_io_inst_0_bits_xcpt0_ae_inst
                         ? 4'h1
                         : _ibuf_io_inst_0_bits_xcpt1_pf_inst
                             ? 4'hC
                             : {2'h0, _ibuf_io_inst_0_bits_xcpt1_ae_inst ? 2'h1 : 2'h2}};	// Mux.scala:47:69, :80:60, RocketCore.scala:201:35, :254:20, :323:19
      ex_reg_pc <= _ibuf_io_pc;	// RocketCore.scala:203:22, :254:20
      ex_reg_inst <= _ibuf_io_inst_0_bits_inst_bits;	// RocketCore.scala:205:24, :254:20
      ex_reg_raw_inst <= _ibuf_io_inst_0_bits_raw;	// RocketCore.scala:206:28, :254:20
    end
    ex_reg_xcpt <= ~ctrl_killd & id_xcpt;	// RocketCore.scala:198:35, :423:19, :425:30, :784:104, :975:26
    ex_reg_replay <=
      ~take_pc_mem_wb & _ibuf_io_inst_0_valid & _ibuf_io_inst_0_bits_replay;	// RocketCore.scala:202:26, :250:35, :254:20, :424:{20,54}
    ex_scie_unpipelined <= ctrl_killd & ex_scie_unpipelined;	// RocketCore.scala:207:32, :428:22, :432:25, :784:104
    ex_scie_pipelined <= ctrl_killd & ex_scie_pipelined;	// RocketCore.scala:208:30, :428:22, :433:23, :784:104
    mem_reg_xcpt_interrupt <= ~take_pc_mem_wb & ex_reg_xcpt_interrupt;	// RocketCore.scala:194:35, :211:36, :250:35, :424:20, :528:45
    mem_reg_valid <= ~ctrl_killx;	// RocketCore.scala:212:36, :496:48, :525:20
    if (_GEN_39) begin	// RocketCore.scala:191:21, :214:36, :532:46, :534:28
    end
    else begin	// RocketCore.scala:214:36, :532:46, :534:28
      mem_reg_rvc <= ex_reg_rvc;	// RocketCore.scala:196:35, :213:36
      mem_reg_btb_resp_entry <= ex_reg_btb_resp_entry;	// RocketCore.scala:197:35, :214:36
      mem_reg_btb_resp_bht_history <= ex_reg_btb_resp_bht_history;	// RocketCore.scala:197:35, :214:36
    end
    mem_reg_xcpt <= ~ctrl_killx & (ex_reg_xcpt_interrupt | ex_reg_xcpt);	// RocketCore.scala:194:35, :198:35, :215:36, :496:48, :502:28, :525:20, :527:31
    mem_reg_replay <= ~take_pc_mem_wb & replay_ex;	// RocketCore.scala:216:36, :250:35, :424:20, :495:33, :526:37
    if (_GEN_39) begin	// RocketCore.scala:191:21, :221:36, :532:46, :534:28
    end
    else begin	// RocketCore.scala:221:36, :532:46, :534:28
      automatic logic _mem_reg_store_T_3;	// RocketCore.scala:498:40
      automatic logic _mem_reg_store_T_5;	// package.scala:15:47
      automatic logic _mem_reg_store_T_6;	// package.scala:15:47
      automatic logic _mem_reg_store_T_7;	// package.scala:15:47
      automatic logic _mem_reg_store_T_8;	// package.scala:15:47
      automatic logic _mem_reg_store_T_12;	// package.scala:15:47
      automatic logic _mem_reg_store_T_13;	// package.scala:15:47
      automatic logic _mem_reg_store_T_14;	// package.scala:15:47
      automatic logic _mem_reg_store_T_15;	// package.scala:15:47
      automatic logic _mem_reg_store_T_16;	// package.scala:15:47
      _mem_reg_store_T_3 = ex_ctrl_mem_cmd == 5'h7;	// RocketCore.scala:190:20, :498:40
      _mem_reg_store_T_5 = ex_ctrl_mem_cmd == 5'h4;	// RocketCore.scala:190:20, package.scala:15:47
      _mem_reg_store_T_6 = ex_ctrl_mem_cmd == 5'h9;	// RocketCore.scala:190:20, package.scala:15:47
      _mem_reg_store_T_7 = ex_ctrl_mem_cmd == 5'hA;	// RocketCore.scala:190:20, package.scala:15:47
      _mem_reg_store_T_8 = ex_ctrl_mem_cmd == 5'hB;	// RocketCore.scala:190:20, package.scala:15:47
      _mem_reg_store_T_12 = ex_ctrl_mem_cmd == 5'h8;	// RocketCore.scala:190:20, package.scala:15:47
      _mem_reg_store_T_13 = ex_ctrl_mem_cmd == 5'hC;	// RocketCore.scala:190:20, package.scala:15:47
      _mem_reg_store_T_14 = ex_ctrl_mem_cmd == 5'hD;	// RocketCore.scala:190:20, package.scala:15:47
      _mem_reg_store_T_15 = ex_ctrl_mem_cmd == 5'hE;	// RocketCore.scala:190:20, package.scala:15:47
      _mem_reg_store_T_16 = ex_ctrl_mem_cmd == 5'hF;	// RocketCore.scala:190:20, package.scala:15:47
      mem_reg_flush_pipe <= _GEN_40 | ex_reg_flush_pipe;	// RocketCore.scala:199:35, :217:36, :543:24, :559:{24,48}, :562:26
      mem_reg_cause <= ex_reg_cause;	// RocketCore.scala:201:35, :218:36
      mem_mem_cmd_bh <= _mem_reg_store_T_3 | ~(ex_reg_mem_size[1]);	// RocketCore.scala:204:28, :219:36, :498:{40,50,69}
      mem_reg_load <=
        ex_ctrl_mem
        & (ex_ctrl_mem_cmd == 5'h0 | ex_ctrl_mem_cmd == 5'h6 | _mem_reg_store_T_3
           | _mem_reg_store_T_5 | _mem_reg_store_T_6 | _mem_reg_store_T_7
           | _mem_reg_store_T_8 | _mem_reg_store_T_12 | _mem_reg_store_T_13
           | _mem_reg_store_T_14 | _mem_reg_store_T_15 | _mem_reg_store_T_16);	// Consts.scala:81:{31,48,75}, RocketCore.scala:190:20, :220:36, :498:40, :539:33, package.scala:15:47
      mem_reg_store <=
        ex_ctrl_mem
        & (ex_ctrl_mem_cmd == 5'h1 | ex_ctrl_mem_cmd == 5'h11 | _mem_reg_store_T_3
           | _mem_reg_store_T_5 | _mem_reg_store_T_6 | _mem_reg_store_T_7
           | _mem_reg_store_T_8 | _mem_reg_store_T_12 | _mem_reg_store_T_13
           | _mem_reg_store_T_14 | _mem_reg_store_T_15 | _mem_reg_store_T_16);	// Consts.scala:82:{32,49,76}, RocketCore.scala:190:20, :221:36, :498:40, :540:34, package.scala:15:47
    end
    mem_reg_sfence <= ~_GEN_38 & (ex_pc_valid ? ex_sfence : mem_reg_sfence);	// RocketCore.scala:222:27, :490:51, :499:48, :532:{23,46}, :533:20, :534:28, :541:20
    if (_GEN_39) begin	// RocketCore.scala:191:21, :229:26, :532:46, :534:28
    end
    else begin	// RocketCore.scala:229:26, :532:46, :534:28
      mem_reg_pc <= ex_reg_pc;	// RocketCore.scala:203:22, :223:23
      mem_reg_inst <= ex_reg_inst;	// RocketCore.scala:205:24, :224:25
      mem_reg_mem_size <= ex_reg_mem_size;	// RocketCore.scala:204:28, :225:29
      mem_reg_raw_inst <= ex_reg_raw_inst;	// RocketCore.scala:206:28, :226:29
      mem_scie_pipelined <= ex_scie_pipelined;	// RocketCore.scala:208:30, :228:31
      if (ex_scie_unpipelined)	// RocketCore.scala:207:32
        mem_reg_wdata <= 64'h0;	// Mux.scala:80:57, RocketCore.scala:229:26
      else	// RocketCore.scala:207:32
        mem_reg_wdata <= _alu_io_out;	// RocketCore.scala:229:26, :385:19
    end
    if (_GEN_38
        | ~(ex_pc_valid & ex_ctrl_rxs2 & (ex_ctrl_mem | ex_ctrl_rocc | ex_sfence))) begin	// RocketCore.scala:190:20, :230:24, :490:51, :499:48, :532:{23,46}, :534:28, :555:{56,71}, :557:19
    end
    else begin	// RocketCore.scala:230:24, :532:46, :534:28
      automatic logic [3:0][63:0] _GEN_49 =
        {{ex_rs_1},
         {{2{ex_rs_1[31:0]}}},
         {{2{{2{ex_rs_1[15:0]}}}}},
         {{2{{2{{2{ex_rs_1[7:0]}}}}}}}};	// AMOALU.scala:26:{13,19,66}, Cat.scala:30:58, RocketCore.scala:375:14
      mem_reg_rs2 <= _GEN_49[ex_ctrl_rocc ? 2'h3 : ex_reg_mem_size];	// AMOALU.scala:26:{13,19}, Mux.scala:47:69, RocketCore.scala:190:20, :204:28, :230:24, :556:21
    end
    if (_GEN_39) begin	// RocketCore.scala:191:21, :231:25, :532:46, :534:28
    end
    else	// RocketCore.scala:231:25, :532:46, :534:28
      mem_br_taken <= _alu_io_cmp_out;	// RocketCore.scala:231:25, :385:19
    wb_reg_valid <= ~ctrl_killm;	// RocketCore.scala:235:35, :589:45, :592:19
    wb_reg_xcpt <= mem_xcpt & ~take_pc_wb;	// RocketCore.scala:236:35, :593:34, :594:27, :640:53, :975:26
    wb_reg_replay <= (dcache_kill_mem | mem_reg_replay | fpu_kill_mem) & ~take_pc_wb;	// RocketCore.scala:216:36, :237:35, :584:55, :585:51, :586:55, :593:{31,34}, :640:53
    wb_reg_flush_pipe <= ~ctrl_killm & mem_reg_flush_pipe;	// RocketCore.scala:217:36, :238:35, :589:45, :592:19, :595:36
    if (~ctrl_killd & _GEN_37)	// RocketCore.scala:373:26, :423:19, :428:22, :468:{23,38}, :470:26, :784:104
      ex_reg_rs_msb_1 <= id_rs_1[63:2];	// RocketCore.scala:373:26, :470:38, :679:17, :1022:19, :1027:29, :1030:{31,39}
    div_io_kill_REG <= _div_io_req_ready & _div_io_req_valid_T;	// Decoupled.scala:40:37, RocketCore.scala:409:19, :410:36, :588:37
    blocked <=
      ~io_dmem_req_ready & ~io_dmem_perf_grant
      & (blocked | _io_dmem_req_valid_output | io_dmem_s2_nack);	// RocketCore.scala:492:45, :764:22, :765:{63,83,116}, :836:41
    if (ex_reg_rs_bypass_0)	// RocketCore.scala:371:29
      coreMonitorBundle_rd0val_x20 <= _ex_rs_T_5;	// RocketCore.scala:896:43, package.scala:32:76
    else	// RocketCore.scala:371:29
      coreMonitorBundle_rd0val_x20 <= _ex_rs_T_6;	// Cat.scala:30:58, RocketCore.scala:896:43
    coreMonitorBundle_rd0val_REG <= coreMonitorBundle_rd0val_x20;	// RocketCore.scala:896:{34,43}
    if (ex_reg_rs_bypass_1)	// RocketCore.scala:371:29
      coreMonitorBundle_rd1val_x26 <= _ex_rs_T_12;	// RocketCore.scala:898:43, package.scala:32:76
    else	// RocketCore.scala:371:29
      coreMonitorBundle_rd1val_x26 <= _ex_rs_T_13;	// Cat.scala:30:58, RocketCore.scala:898:43
    coreMonitorBundle_rd1val_REG <= coreMonitorBundle_rd1val_x26;	// RocketCore.scala:898:{34,43}
    if (reset) begin
      id_reg_fence <= 1'h0;	// RocketCore.scala:274:25, :282:19, :323:19
      _r <= 32'h0;	// RocketCore.scala:1001:25
      id_stall_fpu__r <= 32'h0;	// RocketCore.scala:1001:25
    end
    else begin
      automatic logic [31:0] _GEN_50;	// RocketCore.scala:997:62
      automatic logic        _GEN_51;	// RocketCore.scala:730:28
      automatic logic [31:0] _id_stall_fpu_T_3;	// RocketCore.scala:1005:62
      automatic logic        _id_stall_fpu_T_6;	// RocketCore.scala:755:72
      automatic logic [31:0] _id_stall_fpu_T_4;	// RocketCore.scala:1005:49
      automatic logic        _id_stall_fpu_T_7 =
        dmem_resp_replay & io_dmem_resp_bits_tag[0];	// RocketCore.scala:643:45, :647:42, :756:38
      automatic logic [31:0] _id_stall_fpu_T_11;	// RocketCore.scala:997:62
      automatic logic        _id_stall_fpu_T_12;	// RocketCore.scala:1008:17
      _GEN_50 = r & ~(ll_wen ? 32'h1 << ll_waddr : 32'h0);	// RocketCore.scala:662:44, :666:14, :667:12, :997:{62,64}, :1002:40, :1005:{49,62}
      _GEN_51 = wb_set_sboard & wb_wen;	// RocketCore.scala:636:53, :671:25, :730:28
      _id_stall_fpu_T_3 = 32'h1 << wb_reg_inst[11:7];	// RocketCore.scala:243:24, :361:29, :1005:62
      _id_stall_fpu_T_6 = (wb_dcache_miss & wb_ctrl_wfd | io_fpu_sboard_set) & wb_valid;	// RocketCore.scala:192:20, :491:36, :670:45, :755:{35,50,72}
      _id_stall_fpu_T_4 = _id_stall_fpu_T_6 ? _id_stall_fpu_T_3 : 32'h0;	// RocketCore.scala:755:72, :1005:{49,62}
      _id_stall_fpu_T_11 =
        (id_stall_fpu__r | _id_stall_fpu_T_4)
        & ~(_id_stall_fpu_T_7 ? 32'h1 << io_dmem_resp_bits_tag[5:1] : 32'h0);	// RocketCore.scala:645:46, :756:38, :996:60, :997:{62,64}, :1001:25, :1005:{49,62}
      _id_stall_fpu_T_12 = _id_stall_fpu_T_6 | _id_stall_fpu_T_7;	// RocketCore.scala:755:72, :756:38, :1008:17
      id_reg_fence <=
        ~ctrl_killd & (id_ctrl_fence | id_ctrl_amo & _ibuf_io_inst_0_bits_inst_bits[26])
        | id_mem_busy & id_reg_fence;	// Decode.scala:14:121, RocketCore.scala:254:20, :274:25, :310:29, :314:{37,52}, :315:38, :316:{23,38}, :423:19, :428:22, :435:{26,41}, :784:104
      if (ll_wen | _GEN_51)	// RocketCore.scala:662:44, :667:12, :730:28, :1008:17
        _r <= _GEN_50 | (_GEN_51 ? _id_stall_fpu_T_3 : 32'h0);	// RocketCore.scala:730:28, :996:60, :997:62, :1001:25, :1005:{49,62}
      else if (ll_wen)	// RocketCore.scala:662:44, :667:12
        _r <= _GEN_50;	// RocketCore.scala:997:62, :1001:25
      if (_id_stall_fpu_T_12 | io_fpu_sboard_clr)	// RocketCore.scala:1008:17
        id_stall_fpu__r <=
          _id_stall_fpu_T_11 & ~(io_fpu_sboard_clr ? 32'h1 << io_fpu_sboard_clra : 32'h0);	// RocketCore.scala:997:{62,64}, :1001:25, :1005:{49,62}
      else if (_id_stall_fpu_T_12)	// RocketCore.scala:1008:17
        id_stall_fpu__r <= _id_stall_fpu_T_11;	// RocketCore.scala:997:62, :1001:25
      else	// RocketCore.scala:1008:17
        id_stall_fpu__r <= {32{_id_stall_fpu_T_6}} & _id_stall_fpu_T_4 | id_stall_fpu__r;	// RocketCore.scala:755:72, :1001:25, :1005:49, :1009:{18,23}
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:46];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [5:0] i = 6'h0; i < 6'h2F; i += 6'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        id_reg_pause = _RANDOM[6'h0][2];	// RocketCore.scala:114:25
        imem_might_request_reg = _RANDOM[6'h0][3];	// RocketCore.scala:114:25, :115:35
        ex_ctrl_fp = _RANDOM[6'h0][5];	// RocketCore.scala:114:25, :190:20
        ex_ctrl_rocc = _RANDOM[6'h0][6];	// RocketCore.scala:114:25, :190:20
        ex_ctrl_branch = _RANDOM[6'h0][7];	// RocketCore.scala:114:25, :190:20
        ex_ctrl_jal = _RANDOM[6'h0][8];	// RocketCore.scala:114:25, :190:20
        ex_ctrl_jalr = _RANDOM[6'h0][9];	// RocketCore.scala:114:25, :190:20
        ex_ctrl_rxs2 = _RANDOM[6'h0][10];	// RocketCore.scala:114:25, :190:20
        ex_ctrl_rxs1 = _RANDOM[6'h0][11];	// RocketCore.scala:114:25, :190:20
        ex_ctrl_sel_alu2 = _RANDOM[6'h0][14:13];	// RocketCore.scala:114:25, :190:20
        ex_ctrl_sel_alu1 = _RANDOM[6'h0][16:15];	// RocketCore.scala:114:25, :190:20
        ex_ctrl_sel_imm = _RANDOM[6'h0][19:17];	// RocketCore.scala:114:25, :190:20
        ex_ctrl_alu_dw = _RANDOM[6'h0][20];	// RocketCore.scala:114:25, :190:20
        ex_ctrl_alu_fn = _RANDOM[6'h0][24:21];	// RocketCore.scala:114:25, :190:20
        ex_ctrl_mem = _RANDOM[6'h0][25];	// RocketCore.scala:114:25, :190:20
        ex_ctrl_mem_cmd = _RANDOM[6'h0][30:26];	// RocketCore.scala:114:25, :190:20
        ex_ctrl_rfs1 = _RANDOM[6'h0][31];	// RocketCore.scala:114:25, :190:20
        ex_ctrl_rfs2 = _RANDOM[6'h1][0];	// RocketCore.scala:190:20
        ex_ctrl_wfd = _RANDOM[6'h1][2];	// RocketCore.scala:190:20
        ex_ctrl_mul = _RANDOM[6'h1][3];	// RocketCore.scala:190:20
        ex_ctrl_div = _RANDOM[6'h1][4];	// RocketCore.scala:190:20
        ex_ctrl_wxd = _RANDOM[6'h1][5];	// RocketCore.scala:190:20
        ex_ctrl_csr = _RANDOM[6'h1][8:6];	// RocketCore.scala:190:20
        ex_ctrl_fence_i = _RANDOM[6'h1][9];	// RocketCore.scala:190:20
        mem_ctrl_fp = _RANDOM[6'h1][14];	// RocketCore.scala:190:20, :191:21
        mem_ctrl_rocc = _RANDOM[6'h1][15];	// RocketCore.scala:190:20, :191:21
        mem_ctrl_branch = _RANDOM[6'h1][16];	// RocketCore.scala:190:20, :191:21
        mem_ctrl_jal = _RANDOM[6'h1][17];	// RocketCore.scala:190:20, :191:21
        mem_ctrl_jalr = _RANDOM[6'h1][18];	// RocketCore.scala:190:20, :191:21
        mem_ctrl_rxs2 = _RANDOM[6'h1][19];	// RocketCore.scala:190:20, :191:21
        mem_ctrl_rxs1 = _RANDOM[6'h1][20];	// RocketCore.scala:190:20, :191:21
        mem_ctrl_mem = _RANDOM[6'h2][2];	// RocketCore.scala:191:21
        mem_ctrl_rfs1 = _RANDOM[6'h2][8];	// RocketCore.scala:191:21
        mem_ctrl_rfs2 = _RANDOM[6'h2][9];	// RocketCore.scala:191:21
        mem_ctrl_wfd = _RANDOM[6'h2][11];	// RocketCore.scala:191:21
        mem_ctrl_mul = _RANDOM[6'h2][12];	// RocketCore.scala:191:21
        mem_ctrl_div = _RANDOM[6'h2][13];	// RocketCore.scala:191:21
        mem_ctrl_wxd = _RANDOM[6'h2][14];	// RocketCore.scala:191:21
        mem_ctrl_csr = _RANDOM[6'h2][17:15];	// RocketCore.scala:191:21
        mem_ctrl_fence_i = _RANDOM[6'h2][18];	// RocketCore.scala:191:21
        wb_ctrl_rocc = _RANDOM[6'h2][24];	// RocketCore.scala:191:21, :192:20
        wb_ctrl_rxs2 = _RANDOM[6'h2][28];	// RocketCore.scala:191:21, :192:20
        wb_ctrl_rxs1 = _RANDOM[6'h2][29];	// RocketCore.scala:191:21, :192:20
        wb_ctrl_mem = _RANDOM[6'h3][11];	// RocketCore.scala:192:20
        wb_ctrl_rfs1 = _RANDOM[6'h3][17];	// RocketCore.scala:192:20
        wb_ctrl_rfs2 = _RANDOM[6'h3][18];	// RocketCore.scala:192:20
        wb_ctrl_wfd = _RANDOM[6'h3][20];	// RocketCore.scala:192:20
        wb_ctrl_div = _RANDOM[6'h3][22];	// RocketCore.scala:192:20
        wb_ctrl_wxd = _RANDOM[6'h3][23];	// RocketCore.scala:192:20
        wb_ctrl_csr = _RANDOM[6'h3][26:24];	// RocketCore.scala:192:20
        wb_ctrl_fence_i = _RANDOM[6'h3][27];	// RocketCore.scala:192:20
        ex_reg_xcpt_interrupt = _RANDOM[6'h3][31];	// RocketCore.scala:192:20, :194:35
        ex_reg_valid = _RANDOM[6'h4][0];	// RocketCore.scala:195:35
        ex_reg_rvc = _RANDOM[6'h4][1];	// RocketCore.scala:195:35, :196:35
        ex_reg_btb_resp_entry = _RANDOM[6'h5][19:15];	// RocketCore.scala:197:35
        ex_reg_btb_resp_bht_history = _RANDOM[6'h5][27:20];	// RocketCore.scala:197:35
        ex_reg_xcpt = _RANDOM[6'h5][29];	// RocketCore.scala:197:35, :198:35
        ex_reg_flush_pipe = _RANDOM[6'h5][30];	// RocketCore.scala:197:35, :199:35
        ex_reg_load_use = _RANDOM[6'h5][31];	// RocketCore.scala:197:35, :200:35
        ex_reg_cause = {_RANDOM[6'h6], _RANDOM[6'h7]};	// RocketCore.scala:201:35
        ex_reg_replay = _RANDOM[6'h8][0];	// RocketCore.scala:202:26
        ex_reg_pc = {_RANDOM[6'h8][31:1], _RANDOM[6'h9][8:0]};	// RocketCore.scala:202:26, :203:22
        ex_reg_mem_size = _RANDOM[6'h9][10:9];	// RocketCore.scala:203:22, :204:28
        ex_reg_inst = {_RANDOM[6'h9][31:11], _RANDOM[6'hA][10:0]};	// RocketCore.scala:203:22, :205:24
        ex_reg_raw_inst = {_RANDOM[6'hA][31:11], _RANDOM[6'hB][10:0]};	// RocketCore.scala:205:24, :206:28
        ex_scie_unpipelined = _RANDOM[6'hB][11];	// RocketCore.scala:206:28, :207:32
        ex_scie_pipelined = _RANDOM[6'hB][12];	// RocketCore.scala:206:28, :208:30
        mem_reg_xcpt_interrupt = _RANDOM[6'hB][14];	// RocketCore.scala:206:28, :211:36
        mem_reg_valid = _RANDOM[6'hB][15];	// RocketCore.scala:206:28, :212:36
        mem_reg_rvc = _RANDOM[6'hB][16];	// RocketCore.scala:206:28, :213:36
        mem_reg_btb_resp_entry = {_RANDOM[6'hC][31:30], _RANDOM[6'hD][2:0]};	// RocketCore.scala:214:36
        mem_reg_btb_resp_bht_history = _RANDOM[6'hD][10:3];	// RocketCore.scala:214:36
        mem_reg_xcpt = _RANDOM[6'hD][12];	// RocketCore.scala:214:36, :215:36
        mem_reg_replay = _RANDOM[6'hD][13];	// RocketCore.scala:214:36, :216:36
        mem_reg_flush_pipe = _RANDOM[6'hD][14];	// RocketCore.scala:214:36, :217:36
        mem_reg_cause = {_RANDOM[6'hD][31:15], _RANDOM[6'hE], _RANDOM[6'hF][14:0]};	// RocketCore.scala:214:36, :218:36
        mem_mem_cmd_bh = _RANDOM[6'hF][15];	// RocketCore.scala:218:36, :219:36
        mem_reg_load = _RANDOM[6'hF][16];	// RocketCore.scala:218:36, :220:36
        mem_reg_store = _RANDOM[6'hF][17];	// RocketCore.scala:218:36, :221:36
        mem_reg_sfence = _RANDOM[6'hF][18];	// RocketCore.scala:218:36, :222:27
        mem_reg_pc = {_RANDOM[6'hF][31:19], _RANDOM[6'h10][26:0]};	// RocketCore.scala:218:36, :223:23
        mem_reg_inst = {_RANDOM[6'h10][31:27], _RANDOM[6'h11][26:0]};	// RocketCore.scala:223:23, :224:25
        mem_reg_mem_size = _RANDOM[6'h11][28:27];	// RocketCore.scala:224:25, :225:29
        mem_reg_raw_inst = {_RANDOM[6'h11][31:29], _RANDOM[6'h12][28:0]};	// RocketCore.scala:224:25, :226:29
        mem_scie_pipelined = _RANDOM[6'h12][30];	// RocketCore.scala:226:29, :228:31
        mem_reg_wdata = {_RANDOM[6'h12][31], _RANDOM[6'h13], _RANDOM[6'h14][30:0]};	// RocketCore.scala:226:29, :229:26
        mem_reg_rs2 = {_RANDOM[6'h14][31], _RANDOM[6'h15], _RANDOM[6'h16][30:0]};	// RocketCore.scala:229:26, :230:24
        mem_br_taken = _RANDOM[6'h16][31];	// RocketCore.scala:230:24, :231:25
        wb_reg_valid = _RANDOM[6'h17][1];	// RocketCore.scala:235:35
        wb_reg_xcpt = _RANDOM[6'h17][2];	// RocketCore.scala:235:35, :236:35
        wb_reg_replay = _RANDOM[6'h17][3];	// RocketCore.scala:235:35, :237:35
        wb_reg_flush_pipe = _RANDOM[6'h17][4];	// RocketCore.scala:235:35, :238:35
        wb_reg_cause = {_RANDOM[6'h17][31:5], _RANDOM[6'h18], _RANDOM[6'h19][4:0]};	// RocketCore.scala:235:35, :239:35
        wb_reg_sfence = _RANDOM[6'h19][5];	// RocketCore.scala:239:35, :240:26
        wb_reg_pc = {_RANDOM[6'h19][31:6], _RANDOM[6'h1A][13:0]};	// RocketCore.scala:239:35, :241:22
        wb_reg_mem_size = _RANDOM[6'h1A][15:14];	// RocketCore.scala:241:22, :242:28
        wb_reg_inst = {_RANDOM[6'h1A][31:16], _RANDOM[6'h1B][15:0]};	// RocketCore.scala:241:22, :243:24
        wb_reg_raw_inst = {_RANDOM[6'h1B][31:16], _RANDOM[6'h1C][15:0]};	// RocketCore.scala:243:24, :244:28
        wb_reg_wdata = {_RANDOM[6'h1C][31:16], _RANDOM[6'h1D], _RANDOM[6'h1E][15:0]};	// RocketCore.scala:244:28, :245:25
        id_reg_fence = _RANDOM[6'h20][17];	// RocketCore.scala:274:25
        ex_reg_rs_bypass_0 = _RANDOM[6'h20][18];	// RocketCore.scala:274:25, :371:29
        ex_reg_rs_bypass_1 = _RANDOM[6'h20][19];	// RocketCore.scala:274:25, :371:29
        ex_reg_rs_lsb_0 = _RANDOM[6'h20][21:20];	// RocketCore.scala:274:25, :372:26
        ex_reg_rs_lsb_1 = _RANDOM[6'h20][23:22];	// RocketCore.scala:274:25, :372:26
        ex_reg_rs_msb_0 = {_RANDOM[6'h20][31:24], _RANDOM[6'h21], _RANDOM[6'h22][21:0]};	// RocketCore.scala:274:25, :373:26
        ex_reg_rs_msb_1 = {_RANDOM[6'h22][31:22], _RANDOM[6'h23], _RANDOM[6'h24][19:0]};	// RocketCore.scala:373:26
        div_io_kill_REG = _RANDOM[6'h24][20];	// RocketCore.scala:373:26, :588:37
        _r = {_RANDOM[6'h24][31:21], _RANDOM[6'h25][20:0]};	// RocketCore.scala:373:26, :1001:25
        id_stall_fpu__r = {_RANDOM[6'h25][31:21], _RANDOM[6'h26][20:0]};	// RocketCore.scala:1001:25
        blocked = _RANDOM[6'h26][21];	// RocketCore.scala:764:22, :1001:25
        coreMonitorBundle_rd0val_x20 =
          {_RANDOM[6'h26][31:24], _RANDOM[6'h27], _RANDOM[6'h28][23:0]};	// RocketCore.scala:896:43, :1001:25
        coreMonitorBundle_rd0val_REG =
          {_RANDOM[6'h28][31:24], _RANDOM[6'h29], _RANDOM[6'h2A][23:0]};	// RocketCore.scala:896:{34,43}
        coreMonitorBundle_rd1val_x26 =
          {_RANDOM[6'h2A][31:24], _RANDOM[6'h2B], _RANDOM[6'h2C][23:0]};	// RocketCore.scala:896:34, :898:43
        coreMonitorBundle_rd1val_REG =
          {_RANDOM[6'h2C][31:24], _RANDOM[6'h2D], _RANDOM[6'h2E][23:0]};	// RocketCore.scala:898:{34,43}
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  IBuf ibuf (	// RocketCore.scala:254:20
    .clock                        (clock),
    .reset                        (reset),
    .io_imem_valid                (io_imem_resp_valid),
    .io_imem_bits_btb_taken       (io_imem_resp_bits_btb_taken),
    .io_imem_bits_btb_bridx       (io_imem_resp_bits_btb_bridx),
    .io_imem_bits_btb_entry       (io_imem_resp_bits_btb_entry),
    .io_imem_bits_btb_bht_history (io_imem_resp_bits_btb_bht_history),
    .io_imem_bits_pc              (io_imem_resp_bits_pc),
    .io_imem_bits_data            (io_imem_resp_bits_data),
    .io_imem_bits_xcpt_pf_inst    (io_imem_resp_bits_xcpt_pf_inst),
    .io_imem_bits_xcpt_ae_inst    (io_imem_resp_bits_xcpt_ae_inst),
    .io_imem_bits_replay          (io_imem_resp_bits_replay),
    .io_kill                      (take_pc_mem_wb),	// RocketCore.scala:250:35
    .io_inst_0_ready              (~_ctrl_stalld_T_28),	// RocketCore.scala:781:22, :804:28
    .io_imem_ready                (io_imem_resp_ready),
    .io_pc                        (_ibuf_io_pc),
    .io_btb_resp_entry            (_ibuf_io_btb_resp_entry),
    .io_btb_resp_bht_history      (_ibuf_io_btb_resp_bht_history),
    .io_inst_0_valid              (_ibuf_io_inst_0_valid),
    .io_inst_0_bits_xcpt0_pf_inst (_ibuf_io_inst_0_bits_xcpt0_pf_inst),
    .io_inst_0_bits_xcpt0_ae_inst (_ibuf_io_inst_0_bits_xcpt0_ae_inst),
    .io_inst_0_bits_xcpt1_pf_inst (_ibuf_io_inst_0_bits_xcpt1_pf_inst),
    .io_inst_0_bits_xcpt1_ae_inst (_ibuf_io_inst_0_bits_xcpt1_ae_inst),
    .io_inst_0_bits_replay        (_ibuf_io_inst_0_bits_replay),
    .io_inst_0_bits_rvc           (_ibuf_io_inst_0_bits_rvc),
    .io_inst_0_bits_inst_bits     (_ibuf_io_inst_0_bits_inst_bits),
    .io_inst_0_bits_inst_rd       (_ibuf_io_inst_0_bits_inst_rd),
    .io_inst_0_bits_inst_rs1      (_ibuf_io_inst_0_bits_inst_rs1),
    .io_inst_0_bits_inst_rs2      (_ibuf_io_inst_0_bits_inst_rs2),
    .io_inst_0_bits_inst_rs3      (_ibuf_io_inst_0_bits_inst_rs3),
    .io_inst_0_bits_raw           (_ibuf_io_inst_0_bits_raw)
  );
  rf_31x64 rf_ext (	// RocketCore.scala:1015:15
    .R0_addr (~_ibuf_io_inst_0_bits_inst_rs2),	// RocketCore.scala:254:20, :1016:39
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .R1_addr (~_ibuf_io_inst_0_bits_inst_rs1),	// RocketCore.scala:254:20, :1016:39
    .R1_en   (1'h1),
    .R1_clk  (clock),
    .W0_addr (~rf_waddr),	// RocketCore.scala:673:21, :1016:39
    .W0_en   (rf_wen & (|rf_waddr)),	// RocketCore.scala:672:23, :673:21, :679:17, :1015:15, :1027:{16,29}
    .W0_clk  (clock),
    .W0_data (coreMonitorBundle_wrdata),	// RocketCore.scala:674:21
    .R0_data (_rf_ext_R0_data),
    .R1_data (_rf_ext_R1_data)
  );
  CSRFile csr (	// RocketCore.scala:282:19
    .clock                      (clock),
    .reset                      (reset),
    .io_ungated_clock           (clock),
    .io_interrupts_debug        (io_interrupts_debug),
    .io_interrupts_mtip         (io_interrupts_mtip),
    .io_interrupts_msip         (io_interrupts_msip),
    .io_interrupts_meip         (io_interrupts_meip),
    .io_interrupts_seip         (io_interrupts_seip),
    .io_hartid                  (io_hartid),
    .io_rw_addr                 (wb_reg_inst[31:20]),	// RocketCore.scala:243:24, :705:32
    .io_rw_cmd                  (wb_ctrl_csr & {wb_reg_valid, 2'h3}),	// CSR.scala:132:{9,15}, Mux.scala:47:69, RocketCore.scala:192:20, :235:35
    .io_rw_wdata                (wb_reg_wdata),	// RocketCore.scala:245:25
    .io_decode_0_csr            (_ibuf_io_inst_0_bits_raw[31:20]),	// RocketCore.scala:254:20, :683:41
    .io_exception               (wb_xcpt),	// RocketCore.scala:975:26
    .io_retire                  (wb_valid),	// RocketCore.scala:670:45
    .io_cause                   (wb_cause),	// Mux.scala:47:69
    .io_pc                      (wb_reg_pc),	// RocketCore.scala:241:22
    .io_tval
      (wb_xcpt
       & (wb_cause == 64'h2 | wb_cause == 64'h3 | wb_cause == 64'h4 | wb_cause == 64'h6
          | wb_cause == 64'h5 | wb_cause == 64'h7 | wb_cause == 64'h1 | wb_cause == 64'hD
          | wb_cause == 64'hF | wb_cause == 64'hC)
         ? {wb_reg_wdata[63:39] == 25'h0 | (&(wb_reg_wdata[63:39]))
              ? wb_reg_wdata[39]
              : ~(wb_reg_wdata[38]),
            wb_reg_wdata[38:0]}
         : 40'h0),	// Cat.scala:30:58, Mux.scala:47:69, RocketCore.scala:245:25, :696:28, :700:21, :975:26, :979:38, :989:23, :990:{18,21,29,34,46,59,62}, :991:16, package.scala:15:47, :72:59
    .io_fcsr_flags_valid        (io_fpu_fcsr_flags_valid),
    .io_fcsr_flags_bits         (io_fpu_fcsr_flags_bits),
    .io_rw_rdata                (_csr_io_rw_rdata),
    .io_decode_0_fp_illegal     (_csr_io_decode_0_fp_illegal),
    .io_decode_0_fp_csr         (_csr_io_decode_0_fp_csr),
    .io_decode_0_read_illegal   (_csr_io_decode_0_read_illegal),
    .io_decode_0_write_illegal  (_csr_io_decode_0_write_illegal),
    .io_decode_0_write_flush    (_csr_io_decode_0_write_flush),
    .io_decode_0_system_illegal (_csr_io_decode_0_system_illegal),
    .io_csr_stall               (_csr_io_csr_stall),
    .io_eret                    (_csr_io_eret),
    .io_singleStep              (_csr_io_singleStep),
    .io_status_debug            (_csr_io_status_debug),
    .io_status_wfi              (io_wfi),
    .io_status_isa              (_csr_io_status_isa),
    .io_status_dprv             (io_ptw_status_dprv),
    .io_status_prv              (_csr_io_status_prv),
    .io_status_mxr              (io_ptw_status_mxr),
    .io_status_sum              (io_ptw_status_sum),
    .io_ptbr_mode               (io_ptw_ptbr_mode),
    .io_ptbr_ppn                (io_ptw_ptbr_ppn),
    .io_evec                    (_csr_io_evec),
    .io_time                    (_csr_io_time),
    .io_fcsr_rm                 (io_fpu_fcsr_rm),
    .io_interrupt               (_csr_io_interrupt),
    .io_interrupt_cause         (_csr_io_interrupt_cause),
    .io_bp_0_control_action     (_csr_io_bp_0_control_action),
    .io_bp_0_control_chain      (_csr_io_bp_0_control_chain),
    .io_bp_0_control_tmatch     (_csr_io_bp_0_control_tmatch),
    .io_bp_0_control_m          (_csr_io_bp_0_control_m),
    .io_bp_0_control_s          (_csr_io_bp_0_control_s),
    .io_bp_0_control_u          (_csr_io_bp_0_control_u),
    .io_bp_0_control_x          (_csr_io_bp_0_control_x),
    .io_bp_0_control_w          (_csr_io_bp_0_control_w),
    .io_bp_0_control_r          (_csr_io_bp_0_control_r),
    .io_bp_0_address            (_csr_io_bp_0_address),
    .io_pmp_0_cfg_l             (io_ptw_pmp_0_cfg_l),
    .io_pmp_0_cfg_a             (io_ptw_pmp_0_cfg_a),
    .io_pmp_0_cfg_x             (io_ptw_pmp_0_cfg_x),
    .io_pmp_0_cfg_w             (io_ptw_pmp_0_cfg_w),
    .io_pmp_0_cfg_r             (io_ptw_pmp_0_cfg_r),
    .io_pmp_0_addr              (io_ptw_pmp_0_addr),
    .io_pmp_0_mask              (io_ptw_pmp_0_mask),
    .io_pmp_1_cfg_l             (io_ptw_pmp_1_cfg_l),
    .io_pmp_1_cfg_a             (io_ptw_pmp_1_cfg_a),
    .io_pmp_1_cfg_x             (io_ptw_pmp_1_cfg_x),
    .io_pmp_1_cfg_w             (io_ptw_pmp_1_cfg_w),
    .io_pmp_1_cfg_r             (io_ptw_pmp_1_cfg_r),
    .io_pmp_1_addr              (io_ptw_pmp_1_addr),
    .io_pmp_1_mask              (io_ptw_pmp_1_mask),
    .io_pmp_2_cfg_l             (io_ptw_pmp_2_cfg_l),
    .io_pmp_2_cfg_a             (io_ptw_pmp_2_cfg_a),
    .io_pmp_2_cfg_x             (io_ptw_pmp_2_cfg_x),
    .io_pmp_2_cfg_w             (io_ptw_pmp_2_cfg_w),
    .io_pmp_2_cfg_r             (io_ptw_pmp_2_cfg_r),
    .io_pmp_2_addr              (io_ptw_pmp_2_addr),
    .io_pmp_2_mask              (io_ptw_pmp_2_mask),
    .io_pmp_3_cfg_l             (io_ptw_pmp_3_cfg_l),
    .io_pmp_3_cfg_a             (io_ptw_pmp_3_cfg_a),
    .io_pmp_3_cfg_x             (io_ptw_pmp_3_cfg_x),
    .io_pmp_3_cfg_w             (io_ptw_pmp_3_cfg_w),
    .io_pmp_3_cfg_r             (io_ptw_pmp_3_cfg_r),
    .io_pmp_3_addr              (io_ptw_pmp_3_addr),
    .io_pmp_3_mask              (io_ptw_pmp_3_mask),
    .io_pmp_4_cfg_l             (io_ptw_pmp_4_cfg_l),
    .io_pmp_4_cfg_a             (io_ptw_pmp_4_cfg_a),
    .io_pmp_4_cfg_x             (io_ptw_pmp_4_cfg_x),
    .io_pmp_4_cfg_w             (io_ptw_pmp_4_cfg_w),
    .io_pmp_4_cfg_r             (io_ptw_pmp_4_cfg_r),
    .io_pmp_4_addr              (io_ptw_pmp_4_addr),
    .io_pmp_4_mask              (io_ptw_pmp_4_mask),
    .io_pmp_5_cfg_l             (io_ptw_pmp_5_cfg_l),
    .io_pmp_5_cfg_a             (io_ptw_pmp_5_cfg_a),
    .io_pmp_5_cfg_x             (io_ptw_pmp_5_cfg_x),
    .io_pmp_5_cfg_w             (io_ptw_pmp_5_cfg_w),
    .io_pmp_5_cfg_r             (io_ptw_pmp_5_cfg_r),
    .io_pmp_5_addr              (io_ptw_pmp_5_addr),
    .io_pmp_5_mask              (io_ptw_pmp_5_mask),
    .io_pmp_6_cfg_l             (io_ptw_pmp_6_cfg_l),
    .io_pmp_6_cfg_a             (io_ptw_pmp_6_cfg_a),
    .io_pmp_6_cfg_x             (io_ptw_pmp_6_cfg_x),
    .io_pmp_6_cfg_w             (io_ptw_pmp_6_cfg_w),
    .io_pmp_6_cfg_r             (io_ptw_pmp_6_cfg_r),
    .io_pmp_6_addr              (io_ptw_pmp_6_addr),
    .io_pmp_6_mask              (io_ptw_pmp_6_mask),
    .io_pmp_7_cfg_l             (io_ptw_pmp_7_cfg_l),
    .io_pmp_7_cfg_a             (io_ptw_pmp_7_cfg_a),
    .io_pmp_7_cfg_x             (io_ptw_pmp_7_cfg_x),
    .io_pmp_7_cfg_w             (io_ptw_pmp_7_cfg_w),
    .io_pmp_7_cfg_r             (io_ptw_pmp_7_cfg_r),
    .io_pmp_7_addr              (io_ptw_pmp_7_addr),
    .io_pmp_7_mask              (io_ptw_pmp_7_mask),
    .io_inhibit_cycle           (_csr_io_inhibit_cycle),
    .io_trace_0_valid           (_csr_io_trace_0_valid),
    .io_trace_0_exception       (_csr_io_trace_0_exception),
    .io_customCSRs_0_value      (_csr_io_customCSRs_0_value)
  );
  BreakpointUnit bpu (	// RocketCore.scala:323:19
    .io_status_debug        (_csr_io_status_debug),	// RocketCore.scala:282:19
    .io_status_prv          (_csr_io_status_prv),	// RocketCore.scala:282:19
    .io_bp_0_control_action (_csr_io_bp_0_control_action),	// RocketCore.scala:282:19
    .io_bp_0_control_chain  (_csr_io_bp_0_control_chain),	// RocketCore.scala:282:19
    .io_bp_0_control_tmatch (_csr_io_bp_0_control_tmatch),	// RocketCore.scala:282:19
    .io_bp_0_control_m      (_csr_io_bp_0_control_m),	// RocketCore.scala:282:19
    .io_bp_0_control_s      (_csr_io_bp_0_control_s),	// RocketCore.scala:282:19
    .io_bp_0_control_u      (_csr_io_bp_0_control_u),	// RocketCore.scala:282:19
    .io_bp_0_control_x      (_csr_io_bp_0_control_x),	// RocketCore.scala:282:19
    .io_bp_0_control_w      (_csr_io_bp_0_control_w),	// RocketCore.scala:282:19
    .io_bp_0_control_r      (_csr_io_bp_0_control_r),	// RocketCore.scala:282:19
    .io_bp_0_address        (_csr_io_bp_0_address),	// RocketCore.scala:282:19
    .io_pc                  (_ibuf_io_pc[38:0]),	// RocketCore.scala:254:20, :326:13
    .io_ea                  (mem_reg_wdata[38:0]),	// RocketCore.scala:229:26, :327:13
    .io_xcpt_if             (_bpu_io_xcpt_if),
    .io_xcpt_ld             (_bpu_io_xcpt_ld),
    .io_xcpt_st             (_bpu_io_xcpt_st),
    .io_debug_if            (_bpu_io_debug_if),
    .io_debug_ld            (_bpu_io_debug_ld),
    .io_debug_st            (_bpu_io_debug_st)
  );
  ALU alu (	// RocketCore.scala:385:19
    .io_dw        (ex_ctrl_alu_dw),	// RocketCore.scala:190:20
    .io_fn        (ex_ctrl_alu_fn),	// RocketCore.scala:190:20
    .io_in2       (_GEN_10[ex_ctrl_sel_alu2]),	// Mux.scala:80:{57,60}, RocketCore.scala:190:20
    .io_in1
      (ex_ctrl_sel_alu1 == 2'h2
         ? {{24{ex_reg_pc[39]}}, ex_reg_pc}
         : ex_ctrl_sel_alu1 == 2'h1 ? ex_rs_0 : 64'h0),	// Mux.scala:47:69, :80:{57,60}, RocketCore.scala:190:20, :203:22, :375:14
    .io_out       (_alu_io_out),
    .io_adder_out (_alu_io_adder_out),
    .io_cmp_out   (_alu_io_cmp_out)
  );
  MulDiv div (	// RocketCore.scala:409:19
    .clock             (clock),
    .reset             (reset),
    .io_req_valid      (_div_io_req_valid_T),	// RocketCore.scala:410:36
    .io_req_bits_fn    (ex_ctrl_alu_fn),	// RocketCore.scala:190:20
    .io_req_bits_dw    (ex_ctrl_alu_dw),	// RocketCore.scala:190:20
    .io_req_bits_in1   (ex_rs_0),	// RocketCore.scala:375:14
    .io_req_bits_in2   (ex_rs_1),	// RocketCore.scala:375:14
    .io_req_bits_tag   (ex_reg_inst[11:7]),	// RocketCore.scala:205:24, :359:29
    .io_kill           (killm_common & div_io_kill_REG),	// RocketCore.scala:587:68, :588:{31,37}
    .io_resp_ready     (_GEN),	// RocketCore.scala:649:21, :662:44, :663:23
    .io_req_ready      (_div_io_req_ready),
    .io_resp_valid     (_div_io_resp_valid),
    .io_resp_bits_data (_div_io_resp_bits_data),
    .io_resp_bits_tag  (_div_io_resp_bits_tag)
  );
  PlusArgTimeout PlusArgTimeout (	// PlusArg.scala:89:11
    .clock    (clock),
    .reset    (reset),
    .io_count (_csr_io_time[31:0])	// PlusArg.scala:89:82, RocketCore.scala:282:19
  );
  assign io_imem_might_request = imem_might_request_reg;	// RocketCore.scala:115:35
  assign io_imem_req_valid = take_pc_mem_wb;	// RocketCore.scala:250:35
  assign io_imem_req_bits_pc =
    wb_xcpt | _csr_io_eret ? _csr_io_evec : replay_wb ? wb_reg_pc : mem_npc;	// RocketCore.scala:241:22, :282:19, :513:129, :639:36, :789:{8,17}, :790:8, :975:26
  assign io_imem_req_bits_speculative = ~take_pc_wb;	// RocketCore.scala:593:34, :640:53
  assign io_imem_sfence_valid = _io_imem_sfence_valid_output;	// RocketCore.scala:797:40
  assign io_imem_sfence_bits_rs1 = wb_reg_mem_size[0];	// RocketCore.scala:242:28, :798:45
  assign io_imem_sfence_bits_rs2 = wb_reg_mem_size[1];	// RocketCore.scala:242:28, :799:45
  assign io_imem_sfence_bits_addr = wb_reg_wdata[38:0];	// RocketCore.scala:245:25, :800:28
  assign io_imem_btb_update_valid =
    mem_reg_valid & ~take_pc_wb & mem_wrong_npc
    & (~mem_cfi | _mem_cfi_taken_T | mem_ctrl_jalr | mem_ctrl_jal);	// RocketCore.scala:191:21, :212:36, :510:25, :515:8, :519:50, :593:34, :640:53, :806:{77,81,90}
  assign io_imem_btb_update_bits_prediction_entry = mem_reg_btb_resp_entry;	// RocketCore.scala:214:36
  assign io_imem_btb_update_bits_pc = _io_imem_btb_update_bits_pc_output;	// RocketCore.scala:815:66
  assign io_imem_btb_update_bits_isValid = mem_cfi;	// RocketCore.scala:519:50
  assign io_imem_btb_update_bits_br_pc = _io_imem_btb_update_bits_br_pc_T_1;	// RocketCore.scala:814:69
  assign io_imem_btb_update_bits_cfiType =
    _io_imem_btb_update_bits_cfiType_T_9 & mem_reg_inst[7]
      ? 2'h2
      : mem_ctrl_jalr & {mem_reg_inst[19:18], mem_reg_inst[16:15]} == 4'h1
          ? 2'h3
          : {1'h0, _io_imem_btb_update_bits_cfiType_T_9};	// Mux.scala:47:69, RocketCore.scala:191:21, :224:25, :282:19, :323:19, :360:31, :809:{8,23,41,53}, :810:{8,23,62}
  assign io_imem_bht_update_valid = mem_reg_valid & ~take_pc_wb;	// RocketCore.scala:212:36, :593:34, :640:53, :818:45
  assign io_imem_bht_update_bits_prediction_history = mem_reg_btb_resp_bht_history;	// RocketCore.scala:214:36
  assign io_imem_bht_update_bits_pc = _io_imem_btb_update_bits_pc_output;	// RocketCore.scala:815:66
  assign io_imem_bht_update_bits_branch = mem_ctrl_branch;	// RocketCore.scala:191:21
  assign io_imem_bht_update_bits_taken = mem_br_taken;	// RocketCore.scala:231:25
  assign io_imem_bht_update_bits_mispredict = mem_wrong_npc;	// RocketCore.scala:515:8
  assign io_imem_flush_icache = wb_reg_valid & wb_ctrl_fence_i & ~io_dmem_s2_nack;	// RocketCore.scala:192:20, :235:35, :792:{59,62}
  assign io_dmem_req_valid = _io_dmem_req_valid_output;	// RocketCore.scala:836:41
  assign io_dmem_req_bits_addr =
    {ex_rs_0[63:39] == 25'h0 | (&(ex_rs_0[63:39]))
       ? _alu_io_adder_out[39]
       : ~(_alu_io_adder_out[38]),
     _alu_io_adder_out[38:0]};	// Cat.scala:30:58, RocketCore.scala:375:14, :385:19, :989:23, :990:{18,21,29,34,46,59,62}, :991:16
  assign io_dmem_req_bits_tag = {1'h0, ex_reg_inst[11:7], ex_ctrl_fp};	// RocketCore.scala:190:20, :205:24, :282:19, :323:19, :359:29, :839:25
  assign io_dmem_req_bits_cmd = ex_ctrl_mem_cmd;	// RocketCore.scala:190:20
  assign io_dmem_req_bits_size = ex_reg_mem_size;	// RocketCore.scala:204:28
  assign io_dmem_req_bits_signed = ~(ex_reg_inst[14]);	// RocketCore.scala:205:24, :842:{30,42}
  assign io_dmem_s1_kill = killm_common | mem_ldst_xcpt | fpu_kill_mem;	// RocketCore.scala:585:51, :587:68, :848:52, :975:26
  assign io_dmem_s1_data_data = mem_ctrl_fp ? io_fpu_store_data : mem_reg_rs2;	// RocketCore.scala:191:21, :230:24, :847:63
  assign io_ptw_sfence_valid = _io_imem_sfence_valid_output;	// RocketCore.scala:797:40
  assign io_ptw_sfence_bits_rs1 = wb_reg_mem_size[0];	// RocketCore.scala:242:28, :798:45
  assign io_ptw_sfence_bits_rs2 = wb_reg_mem_size[1];	// RocketCore.scala:242:28, :799:45
  assign io_ptw_sfence_bits_addr = wb_reg_wdata[38:0];	// RocketCore.scala:245:25, :800:28
  assign io_ptw_status_debug = _csr_io_status_debug;	// RocketCore.scala:282:19
  assign io_ptw_status_prv = _csr_io_status_prv;	// RocketCore.scala:282:19
  assign io_ptw_customCSRs_csrs_0_value = _csr_io_customCSRs_0_value;	// RocketCore.scala:282:19
  assign io_fpu_inst = _ibuf_io_inst_0_bits_inst_bits;	// RocketCore.scala:254:20
  assign io_fpu_fromint_data = ex_rs_0;	// RocketCore.scala:375:14
  assign io_fpu_dmem_resp_val = dmem_resp_valid & io_dmem_resp_bits_tag[0];	// RocketCore.scala:643:45, :646:44, :830:43
  assign io_fpu_dmem_resp_type = {1'h0, io_dmem_resp_bits_size};	// RocketCore.scala:282:19, :323:19, :832:25
  assign io_fpu_dmem_resp_tag = io_dmem_resp_bits_tag[5:1];	// RocketCore.scala:645:46
  assign io_fpu_valid = ~ctrl_killd & id_ctrl_fp;	// Decode.scala:15:30, RocketCore.scala:423:19, :784:104, :825:31
  assign io_fpu_killx = ctrl_killx;	// RocketCore.scala:496:48
  assign io_fpu_killm = killm_common;	// RocketCore.scala:587:68
endmodule

