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

module RocketTile(
  input         clock,
                reset,
                auto_int_local_in_3_0,
                auto_int_local_in_2_0,
                auto_int_local_in_1_0,
                auto_int_local_in_1_1,
                auto_int_local_in_0_0,
                auto_tl_other_masters_out_a_ready,
                auto_tl_other_masters_out_b_valid,
  input  [2:0]  auto_tl_other_masters_out_b_bits_opcode,
  input  [1:0]  auto_tl_other_masters_out_b_bits_param,
  input  [3:0]  auto_tl_other_masters_out_b_bits_size,
  input  [1:0]  auto_tl_other_masters_out_b_bits_source,
  input  [31:0] auto_tl_other_masters_out_b_bits_address,
  input  [7:0]  auto_tl_other_masters_out_b_bits_mask,
  input         auto_tl_other_masters_out_b_bits_corrupt,
                auto_tl_other_masters_out_c_ready,
                auto_tl_other_masters_out_d_valid,
  input  [2:0]  auto_tl_other_masters_out_d_bits_opcode,
  input  [1:0]  auto_tl_other_masters_out_d_bits_param,
  input  [3:0]  auto_tl_other_masters_out_d_bits_size,
  input  [1:0]  auto_tl_other_masters_out_d_bits_source,
  input  [2:0]  auto_tl_other_masters_out_d_bits_sink,
  input         auto_tl_other_masters_out_d_bits_denied,
  input  [63:0] auto_tl_other_masters_out_d_bits_data,
  input         auto_tl_other_masters_out_d_bits_corrupt,
                auto_tl_other_masters_out_e_ready,
  output        auto_wfi_out_0,
                auto_tl_other_masters_out_a_valid,
  output [2:0]  auto_tl_other_masters_out_a_bits_opcode,
                auto_tl_other_masters_out_a_bits_param,
  output [3:0]  auto_tl_other_masters_out_a_bits_size,
  output [1:0]  auto_tl_other_masters_out_a_bits_source,
  output [31:0] auto_tl_other_masters_out_a_bits_address,
  output [7:0]  auto_tl_other_masters_out_a_bits_mask,
  output [63:0] auto_tl_other_masters_out_a_bits_data,
  output        auto_tl_other_masters_out_b_ready,
                auto_tl_other_masters_out_c_valid,
  output [2:0]  auto_tl_other_masters_out_c_bits_opcode,
                auto_tl_other_masters_out_c_bits_param,
  output [3:0]  auto_tl_other_masters_out_c_bits_size,
  output [1:0]  auto_tl_other_masters_out_c_bits_source,
  output [31:0] auto_tl_other_masters_out_c_bits_address,
  output [63:0] auto_tl_other_masters_out_c_bits_data,
  output        auto_tl_other_masters_out_d_ready,
                auto_tl_other_masters_out_e_valid
);

  wire        _core_io_imem_might_request;	// RocketTile.scala:140:20
  wire        _core_io_imem_req_valid;	// RocketTile.scala:140:20
  wire [39:0] _core_io_imem_req_bits_pc;	// RocketTile.scala:140:20
  wire        _core_io_imem_req_bits_speculative;	// RocketTile.scala:140:20
  wire        _core_io_imem_sfence_valid;	// RocketTile.scala:140:20
  wire        _core_io_imem_sfence_bits_rs1;	// RocketTile.scala:140:20
  wire        _core_io_imem_sfence_bits_rs2;	// RocketTile.scala:140:20
  wire [38:0] _core_io_imem_sfence_bits_addr;	// RocketTile.scala:140:20
  wire        _core_io_imem_resp_ready;	// RocketTile.scala:140:20
  wire        _core_io_imem_btb_update_valid;	// RocketTile.scala:140:20
  wire [4:0]  _core_io_imem_btb_update_bits_prediction_entry;	// RocketTile.scala:140:20
  wire [38:0] _core_io_imem_btb_update_bits_pc;	// RocketTile.scala:140:20
  wire        _core_io_imem_btb_update_bits_isValid;	// RocketTile.scala:140:20
  wire [38:0] _core_io_imem_btb_update_bits_br_pc;	// RocketTile.scala:140:20
  wire [1:0]  _core_io_imem_btb_update_bits_cfiType;	// RocketTile.scala:140:20
  wire        _core_io_imem_bht_update_valid;	// RocketTile.scala:140:20
  wire [7:0]  _core_io_imem_bht_update_bits_prediction_history;	// RocketTile.scala:140:20
  wire [38:0] _core_io_imem_bht_update_bits_pc;	// RocketTile.scala:140:20
  wire        _core_io_imem_bht_update_bits_branch;	// RocketTile.scala:140:20
  wire        _core_io_imem_bht_update_bits_taken;	// RocketTile.scala:140:20
  wire        _core_io_imem_bht_update_bits_mispredict;	// RocketTile.scala:140:20
  wire        _core_io_imem_flush_icache;	// RocketTile.scala:140:20
  wire        _core_io_dmem_req_valid;	// RocketTile.scala:140:20
  wire [39:0] _core_io_dmem_req_bits_addr;	// RocketTile.scala:140:20
  wire [6:0]  _core_io_dmem_req_bits_tag;	// RocketTile.scala:140:20
  wire [4:0]  _core_io_dmem_req_bits_cmd;	// RocketTile.scala:140:20
  wire [1:0]  _core_io_dmem_req_bits_size;	// RocketTile.scala:140:20
  wire        _core_io_dmem_req_bits_signed;	// RocketTile.scala:140:20
  wire        _core_io_dmem_s1_kill;	// RocketTile.scala:140:20
  wire [63:0] _core_io_dmem_s1_data_data;	// RocketTile.scala:140:20
  wire [3:0]  _core_io_ptw_ptbr_mode;	// RocketTile.scala:140:20
  wire [43:0] _core_io_ptw_ptbr_ppn;	// RocketTile.scala:140:20
  wire        _core_io_ptw_sfence_valid;	// RocketTile.scala:140:20
  wire        _core_io_ptw_sfence_bits_rs1;	// RocketTile.scala:140:20
  wire        _core_io_ptw_sfence_bits_rs2;	// RocketTile.scala:140:20
  wire [38:0] _core_io_ptw_sfence_bits_addr;	// RocketTile.scala:140:20
  wire        _core_io_ptw_status_debug;	// RocketTile.scala:140:20
  wire [1:0]  _core_io_ptw_status_dprv;	// RocketTile.scala:140:20
  wire [1:0]  _core_io_ptw_status_prv;	// RocketTile.scala:140:20
  wire        _core_io_ptw_status_mxr;	// RocketTile.scala:140:20
  wire        _core_io_ptw_status_sum;	// RocketTile.scala:140:20
  wire        _core_io_ptw_pmp_0_cfg_l;	// RocketTile.scala:140:20
  wire [1:0]  _core_io_ptw_pmp_0_cfg_a;	// RocketTile.scala:140:20
  wire        _core_io_ptw_pmp_0_cfg_x;	// RocketTile.scala:140:20
  wire        _core_io_ptw_pmp_0_cfg_w;	// RocketTile.scala:140:20
  wire        _core_io_ptw_pmp_0_cfg_r;	// RocketTile.scala:140:20
  wire [29:0] _core_io_ptw_pmp_0_addr;	// RocketTile.scala:140:20
  wire [31:0] _core_io_ptw_pmp_0_mask;	// RocketTile.scala:140:20
  wire        _core_io_ptw_pmp_1_cfg_l;	// RocketTile.scala:140:20
  wire [1:0]  _core_io_ptw_pmp_1_cfg_a;	// RocketTile.scala:140:20
  wire        _core_io_ptw_pmp_1_cfg_x;	// RocketTile.scala:140:20
  wire        _core_io_ptw_pmp_1_cfg_w;	// RocketTile.scala:140:20
  wire        _core_io_ptw_pmp_1_cfg_r;	// RocketTile.scala:140:20
  wire [29:0] _core_io_ptw_pmp_1_addr;	// RocketTile.scala:140:20
  wire [31:0] _core_io_ptw_pmp_1_mask;	// RocketTile.scala:140:20
  wire        _core_io_ptw_pmp_2_cfg_l;	// RocketTile.scala:140:20
  wire [1:0]  _core_io_ptw_pmp_2_cfg_a;	// RocketTile.scala:140:20
  wire        _core_io_ptw_pmp_2_cfg_x;	// RocketTile.scala:140:20
  wire        _core_io_ptw_pmp_2_cfg_w;	// RocketTile.scala:140:20
  wire        _core_io_ptw_pmp_2_cfg_r;	// RocketTile.scala:140:20
  wire [29:0] _core_io_ptw_pmp_2_addr;	// RocketTile.scala:140:20
  wire [31:0] _core_io_ptw_pmp_2_mask;	// RocketTile.scala:140:20
  wire        _core_io_ptw_pmp_3_cfg_l;	// RocketTile.scala:140:20
  wire [1:0]  _core_io_ptw_pmp_3_cfg_a;	// RocketTile.scala:140:20
  wire        _core_io_ptw_pmp_3_cfg_x;	// RocketTile.scala:140:20
  wire        _core_io_ptw_pmp_3_cfg_w;	// RocketTile.scala:140:20
  wire        _core_io_ptw_pmp_3_cfg_r;	// RocketTile.scala:140:20
  wire [29:0] _core_io_ptw_pmp_3_addr;	// RocketTile.scala:140:20
  wire [31:0] _core_io_ptw_pmp_3_mask;	// RocketTile.scala:140:20
  wire        _core_io_ptw_pmp_4_cfg_l;	// RocketTile.scala:140:20
  wire [1:0]  _core_io_ptw_pmp_4_cfg_a;	// RocketTile.scala:140:20
  wire        _core_io_ptw_pmp_4_cfg_x;	// RocketTile.scala:140:20
  wire        _core_io_ptw_pmp_4_cfg_w;	// RocketTile.scala:140:20
  wire        _core_io_ptw_pmp_4_cfg_r;	// RocketTile.scala:140:20
  wire [29:0] _core_io_ptw_pmp_4_addr;	// RocketTile.scala:140:20
  wire [31:0] _core_io_ptw_pmp_4_mask;	// RocketTile.scala:140:20
  wire        _core_io_ptw_pmp_5_cfg_l;	// RocketTile.scala:140:20
  wire [1:0]  _core_io_ptw_pmp_5_cfg_a;	// RocketTile.scala:140:20
  wire        _core_io_ptw_pmp_5_cfg_x;	// RocketTile.scala:140:20
  wire        _core_io_ptw_pmp_5_cfg_w;	// RocketTile.scala:140:20
  wire        _core_io_ptw_pmp_5_cfg_r;	// RocketTile.scala:140:20
  wire [29:0] _core_io_ptw_pmp_5_addr;	// RocketTile.scala:140:20
  wire [31:0] _core_io_ptw_pmp_5_mask;	// RocketTile.scala:140:20
  wire        _core_io_ptw_pmp_6_cfg_l;	// RocketTile.scala:140:20
  wire [1:0]  _core_io_ptw_pmp_6_cfg_a;	// RocketTile.scala:140:20
  wire        _core_io_ptw_pmp_6_cfg_x;	// RocketTile.scala:140:20
  wire        _core_io_ptw_pmp_6_cfg_w;	// RocketTile.scala:140:20
  wire        _core_io_ptw_pmp_6_cfg_r;	// RocketTile.scala:140:20
  wire [29:0] _core_io_ptw_pmp_6_addr;	// RocketTile.scala:140:20
  wire [31:0] _core_io_ptw_pmp_6_mask;	// RocketTile.scala:140:20
  wire        _core_io_ptw_pmp_7_cfg_l;	// RocketTile.scala:140:20
  wire [1:0]  _core_io_ptw_pmp_7_cfg_a;	// RocketTile.scala:140:20
  wire        _core_io_ptw_pmp_7_cfg_x;	// RocketTile.scala:140:20
  wire        _core_io_ptw_pmp_7_cfg_w;	// RocketTile.scala:140:20
  wire        _core_io_ptw_pmp_7_cfg_r;	// RocketTile.scala:140:20
  wire [29:0] _core_io_ptw_pmp_7_addr;	// RocketTile.scala:140:20
  wire [31:0] _core_io_ptw_pmp_7_mask;	// RocketTile.scala:140:20
  wire [63:0] _core_io_ptw_customCSRs_csrs_0_value;	// RocketTile.scala:140:20
  wire [31:0] _core_io_fpu_inst;	// RocketTile.scala:140:20
  wire [63:0] _core_io_fpu_fromint_data;	// RocketTile.scala:140:20
  wire [2:0]  _core_io_fpu_fcsr_rm;	// RocketTile.scala:140:20
  wire        _core_io_fpu_dmem_resp_val;	// RocketTile.scala:140:20
  wire [2:0]  _core_io_fpu_dmem_resp_type;	// RocketTile.scala:140:20
  wire [4:0]  _core_io_fpu_dmem_resp_tag;	// RocketTile.scala:140:20
  wire        _core_io_fpu_valid;	// RocketTile.scala:140:20
  wire        _core_io_fpu_killx;	// RocketTile.scala:140:20
  wire        _core_io_fpu_killm;	// RocketTile.scala:140:20
  wire        _core_io_wfi;	// RocketTile.scala:140:20
  wire        _ptw_io_requestor_0_req_ready;	// PTW.scala:439:19
  wire        _ptw_io_requestor_0_resp_valid;	// PTW.scala:439:19
  wire        _ptw_io_requestor_0_resp_bits_ae;	// PTW.scala:439:19
  wire [53:0] _ptw_io_requestor_0_resp_bits_pte_ppn;	// PTW.scala:439:19
  wire        _ptw_io_requestor_0_resp_bits_pte_d;	// PTW.scala:439:19
  wire        _ptw_io_requestor_0_resp_bits_pte_a;	// PTW.scala:439:19
  wire        _ptw_io_requestor_0_resp_bits_pte_g;	// PTW.scala:439:19
  wire        _ptw_io_requestor_0_resp_bits_pte_u;	// PTW.scala:439:19
  wire        _ptw_io_requestor_0_resp_bits_pte_x;	// PTW.scala:439:19
  wire        _ptw_io_requestor_0_resp_bits_pte_w;	// PTW.scala:439:19
  wire        _ptw_io_requestor_0_resp_bits_pte_r;	// PTW.scala:439:19
  wire        _ptw_io_requestor_0_resp_bits_pte_v;	// PTW.scala:439:19
  wire [1:0]  _ptw_io_requestor_0_resp_bits_level;	// PTW.scala:439:19
  wire        _ptw_io_requestor_0_resp_bits_homogeneous;	// PTW.scala:439:19
  wire        _ptw_io_requestor_1_req_ready;	// PTW.scala:439:19
  wire        _ptw_io_requestor_1_resp_valid;	// PTW.scala:439:19
  wire        _ptw_io_requestor_1_resp_bits_ae;	// PTW.scala:439:19
  wire [53:0] _ptw_io_requestor_1_resp_bits_pte_ppn;	// PTW.scala:439:19
  wire        _ptw_io_requestor_1_resp_bits_pte_d;	// PTW.scala:439:19
  wire        _ptw_io_requestor_1_resp_bits_pte_a;	// PTW.scala:439:19
  wire        _ptw_io_requestor_1_resp_bits_pte_g;	// PTW.scala:439:19
  wire        _ptw_io_requestor_1_resp_bits_pte_u;	// PTW.scala:439:19
  wire        _ptw_io_requestor_1_resp_bits_pte_x;	// PTW.scala:439:19
  wire        _ptw_io_requestor_1_resp_bits_pte_w;	// PTW.scala:439:19
  wire        _ptw_io_requestor_1_resp_bits_pte_r;	// PTW.scala:439:19
  wire        _ptw_io_requestor_1_resp_bits_pte_v;	// PTW.scala:439:19
  wire [1:0]  _ptw_io_requestor_1_resp_bits_level;	// PTW.scala:439:19
  wire        _ptw_io_requestor_1_resp_bits_homogeneous;	// PTW.scala:439:19
  wire        _ptw_io_mem_req_valid;	// PTW.scala:439:19
  wire [39:0] _ptw_io_mem_req_bits_addr;	// PTW.scala:439:19
  wire        _ptw_io_mem_s1_kill;	// PTW.scala:439:19
  wire        _dcacheArb_io_requestor_0_s2_nack;	// HellaCache.scala:276:25
  wire        _dcacheArb_io_requestor_0_resp_valid;	// HellaCache.scala:276:25
  wire        _dcacheArb_io_requestor_1_req_ready;	// HellaCache.scala:276:25
  wire        _dcacheArb_io_requestor_1_s2_nack;	// HellaCache.scala:276:25
  wire        _dcacheArb_io_requestor_1_resp_valid;	// HellaCache.scala:276:25
  wire [6:0]  _dcacheArb_io_requestor_1_resp_bits_tag;	// HellaCache.scala:276:25
  wire        _dcacheArb_io_mem_req_valid;	// HellaCache.scala:276:25
  wire [39:0] _dcacheArb_io_mem_req_bits_addr;	// HellaCache.scala:276:25
  wire [6:0]  _dcacheArb_io_mem_req_bits_tag;	// HellaCache.scala:276:25
  wire [4:0]  _dcacheArb_io_mem_req_bits_cmd;	// HellaCache.scala:276:25
  wire [1:0]  _dcacheArb_io_mem_req_bits_size;	// HellaCache.scala:276:25
  wire        _dcacheArb_io_mem_req_bits_signed;	// HellaCache.scala:276:25
  wire        _dcacheArb_io_mem_req_bits_phys;	// HellaCache.scala:276:25
  wire        _dcacheArb_io_mem_s1_kill;	// HellaCache.scala:276:25
  wire [63:0] _dcacheArb_io_mem_s1_data_data;	// HellaCache.scala:276:25
  wire        _fpuOpt_io_fcsr_flags_valid;	// RocketTile.scala:202:62
  wire [4:0]  _fpuOpt_io_fcsr_flags_bits;	// RocketTile.scala:202:62
  wire [63:0] _fpuOpt_io_store_data;	// RocketTile.scala:202:62
  wire [63:0] _fpuOpt_io_toint_data;	// RocketTile.scala:202:62
  wire        _fpuOpt_io_fcsr_rdy;	// RocketTile.scala:202:62
  wire        _fpuOpt_io_nack_mem;	// RocketTile.scala:202:62
  wire        _fpuOpt_io_illegal_rm;	// RocketTile.scala:202:62
  wire        _fpuOpt_io_dec_wen;	// RocketTile.scala:202:62
  wire        _fpuOpt_io_dec_ren1;	// RocketTile.scala:202:62
  wire        _fpuOpt_io_dec_ren2;	// RocketTile.scala:202:62
  wire        _fpuOpt_io_dec_ren3;	// RocketTile.scala:202:62
  wire        _fpuOpt_io_sboard_set;	// RocketTile.scala:202:62
  wire        _fpuOpt_io_sboard_clr;	// RocketTile.scala:202:62
  wire [4:0]  _fpuOpt_io_sboard_clra;	// RocketTile.scala:202:62
  wire        _frontend_auto_icache_master_out_a_valid;	// Frontend.scala:350:28
  wire [31:0] _frontend_auto_icache_master_out_a_bits_address;	// Frontend.scala:350:28
  wire        _frontend_io_cpu_resp_valid;	// Frontend.scala:350:28
  wire        _frontend_io_cpu_resp_bits_btb_taken;	// Frontend.scala:350:28
  wire        _frontend_io_cpu_resp_bits_btb_bridx;	// Frontend.scala:350:28
  wire [4:0]  _frontend_io_cpu_resp_bits_btb_entry;	// Frontend.scala:350:28
  wire [7:0]  _frontend_io_cpu_resp_bits_btb_bht_history;	// Frontend.scala:350:28
  wire [39:0] _frontend_io_cpu_resp_bits_pc;	// Frontend.scala:350:28
  wire [31:0] _frontend_io_cpu_resp_bits_data;	// Frontend.scala:350:28
  wire        _frontend_io_cpu_resp_bits_xcpt_pf_inst;	// Frontend.scala:350:28
  wire        _frontend_io_cpu_resp_bits_xcpt_ae_inst;	// Frontend.scala:350:28
  wire        _frontend_io_cpu_resp_bits_replay;	// Frontend.scala:350:28
  wire        _frontend_io_ptw_req_valid;	// Frontend.scala:350:28
  wire        _frontend_io_ptw_req_bits_valid;	// Frontend.scala:350:28
  wire [26:0] _frontend_io_ptw_req_bits_bits_addr;	// Frontend.scala:350:28
  wire        _dcache_auto_out_a_valid;	// HellaCache.scala:265:43
  wire [2:0]  _dcache_auto_out_a_bits_opcode;	// HellaCache.scala:265:43
  wire [2:0]  _dcache_auto_out_a_bits_param;	// HellaCache.scala:265:43
  wire [3:0]  _dcache_auto_out_a_bits_size;	// HellaCache.scala:265:43
  wire        _dcache_auto_out_a_bits_source;	// HellaCache.scala:265:43
  wire [31:0] _dcache_auto_out_a_bits_address;	// HellaCache.scala:265:43
  wire [7:0]  _dcache_auto_out_a_bits_mask;	// HellaCache.scala:265:43
  wire [63:0] _dcache_auto_out_a_bits_data;	// HellaCache.scala:265:43
  wire        _dcache_auto_out_b_ready;	// HellaCache.scala:265:43
  wire        _dcache_auto_out_c_valid;	// HellaCache.scala:265:43
  wire [2:0]  _dcache_auto_out_c_bits_opcode;	// HellaCache.scala:265:43
  wire [2:0]  _dcache_auto_out_c_bits_param;	// HellaCache.scala:265:43
  wire [3:0]  _dcache_auto_out_c_bits_size;	// HellaCache.scala:265:43
  wire        _dcache_auto_out_c_bits_source;	// HellaCache.scala:265:43
  wire [31:0] _dcache_auto_out_c_bits_address;	// HellaCache.scala:265:43
  wire        _dcache_auto_out_d_ready;	// HellaCache.scala:265:43
  wire        _dcache_auto_out_e_valid;	// HellaCache.scala:265:43
  wire        _dcache_io_cpu_req_ready;	// HellaCache.scala:265:43
  wire        _dcache_io_cpu_s2_nack;	// HellaCache.scala:265:43
  wire        _dcache_io_cpu_resp_valid;	// HellaCache.scala:265:43
  wire [6:0]  _dcache_io_cpu_resp_bits_tag;	// HellaCache.scala:265:43
  wire [1:0]  _dcache_io_cpu_resp_bits_size;	// HellaCache.scala:265:43
  wire [63:0] _dcache_io_cpu_resp_bits_data;	// HellaCache.scala:265:43
  wire        _dcache_io_cpu_resp_bits_replay;	// HellaCache.scala:265:43
  wire        _dcache_io_cpu_resp_bits_has_data;	// HellaCache.scala:265:43
  wire [63:0] _dcache_io_cpu_resp_bits_data_word_bypass;	// HellaCache.scala:265:43
  wire        _dcache_io_cpu_replay_next;	// HellaCache.scala:265:43
  wire        _dcache_io_cpu_s2_xcpt_ma_ld;	// HellaCache.scala:265:43
  wire        _dcache_io_cpu_s2_xcpt_ma_st;	// HellaCache.scala:265:43
  wire        _dcache_io_cpu_s2_xcpt_pf_ld;	// HellaCache.scala:265:43
  wire        _dcache_io_cpu_s2_xcpt_pf_st;	// HellaCache.scala:265:43
  wire        _dcache_io_cpu_s2_xcpt_ae_ld;	// HellaCache.scala:265:43
  wire        _dcache_io_cpu_s2_xcpt_ae_st;	// HellaCache.scala:265:43
  wire        _dcache_io_cpu_ordered;	// HellaCache.scala:265:43
  wire        _dcache_io_cpu_perf_release;	// HellaCache.scala:265:43
  wire        _dcache_io_cpu_perf_grant;	// HellaCache.scala:265:43
  wire        _dcache_io_ptw_req_valid;	// HellaCache.scala:265:43
  wire [26:0] _dcache_io_ptw_req_bits_bits_addr;	// HellaCache.scala:265:43
  wire        _tlMasterXbar_auto_in_1_a_ready;	// BaseTile.scala:195:42
  wire        _tlMasterXbar_auto_in_1_d_valid;	// BaseTile.scala:195:42
  wire        _tlMasterXbar_auto_in_0_a_ready;	// BaseTile.scala:195:42
  wire        _tlMasterXbar_auto_in_0_b_valid;	// BaseTile.scala:195:42
  wire        _tlMasterXbar_auto_in_0_b_bits_source;	// BaseTile.scala:195:42
  wire        _tlMasterXbar_auto_in_0_d_valid;	// BaseTile.scala:195:42
  wire        _tlMasterXbar_auto_in_0_d_bits_source;	// BaseTile.scala:195:42
  reg         bundleOut_0_0_REG;	// Interrupts.scala:129:36
  always @(posedge clock) begin
    if (reset)
      bundleOut_0_0_REG <= 1'h0;	// Interrupts.scala:129:36
    else
      bundleOut_0_0_REG <= _core_io_wfi;	// Interrupts.scala:129:36, RocketTile.scala:140:20
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:0];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        _RANDOM[/*Zero width*/ 1'b0] = `RANDOM;
        bundleOut_0_0_REG = _RANDOM[/*Zero width*/ 1'b0][0];	// Interrupts.scala:129:36
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  TLXbar_7 tlMasterXbar (	// BaseTile.scala:195:42
    .clock                    (clock),
    .reset                    (reset),
    .auto_in_1_a_valid        (_frontend_auto_icache_master_out_a_valid),	// Frontend.scala:350:28
    .auto_in_1_a_bits_address (_frontend_auto_icache_master_out_a_bits_address),	// Frontend.scala:350:28
    .auto_in_0_a_valid        (_dcache_auto_out_a_valid),	// HellaCache.scala:265:43
    .auto_in_0_a_bits_opcode  (_dcache_auto_out_a_bits_opcode),	// HellaCache.scala:265:43
    .auto_in_0_a_bits_param   (_dcache_auto_out_a_bits_param),	// HellaCache.scala:265:43
    .auto_in_0_a_bits_size    (_dcache_auto_out_a_bits_size),	// HellaCache.scala:265:43
    .auto_in_0_a_bits_source  (_dcache_auto_out_a_bits_source),	// HellaCache.scala:265:43
    .auto_in_0_a_bits_address (_dcache_auto_out_a_bits_address),	// HellaCache.scala:265:43
    .auto_in_0_a_bits_mask    (_dcache_auto_out_a_bits_mask),	// HellaCache.scala:265:43
    .auto_in_0_a_bits_data    (_dcache_auto_out_a_bits_data),	// HellaCache.scala:265:43
    .auto_in_0_b_ready        (_dcache_auto_out_b_ready),	// HellaCache.scala:265:43
    .auto_in_0_c_valid        (_dcache_auto_out_c_valid),	// HellaCache.scala:265:43
    .auto_in_0_c_bits_opcode  (_dcache_auto_out_c_bits_opcode),	// HellaCache.scala:265:43
    .auto_in_0_c_bits_param   (_dcache_auto_out_c_bits_param),	// HellaCache.scala:265:43
    .auto_in_0_c_bits_size    (_dcache_auto_out_c_bits_size),	// HellaCache.scala:265:43
    .auto_in_0_c_bits_source  (_dcache_auto_out_c_bits_source),	// HellaCache.scala:265:43
    .auto_in_0_c_bits_address (_dcache_auto_out_c_bits_address),	// HellaCache.scala:265:43
    .auto_in_0_d_ready        (_dcache_auto_out_d_ready),	// HellaCache.scala:265:43
    .auto_in_0_e_valid        (_dcache_auto_out_e_valid),	// HellaCache.scala:265:43
    .auto_in_0_e_bits_sink    (auto_tl_other_masters_out_d_bits_sink),
    .auto_out_a_ready         (auto_tl_other_masters_out_a_ready),
    .auto_out_b_valid         (auto_tl_other_masters_out_b_valid),
    .auto_out_b_bits_opcode   (auto_tl_other_masters_out_b_bits_opcode),
    .auto_out_b_bits_param    (auto_tl_other_masters_out_b_bits_param),
    .auto_out_b_bits_size     (auto_tl_other_masters_out_b_bits_size),
    .auto_out_b_bits_source   (auto_tl_other_masters_out_b_bits_source),
    .auto_out_b_bits_address  (auto_tl_other_masters_out_b_bits_address),
    .auto_out_b_bits_mask     (auto_tl_other_masters_out_b_bits_mask),
    .auto_out_b_bits_corrupt  (auto_tl_other_masters_out_b_bits_corrupt),
    .auto_out_c_ready         (auto_tl_other_masters_out_c_ready),
    .auto_out_d_valid         (auto_tl_other_masters_out_d_valid),
    .auto_out_d_bits_opcode   (auto_tl_other_masters_out_d_bits_opcode),
    .auto_out_d_bits_param    (auto_tl_other_masters_out_d_bits_param),
    .auto_out_d_bits_size     (auto_tl_other_masters_out_d_bits_size),
    .auto_out_d_bits_source   (auto_tl_other_masters_out_d_bits_source),
    .auto_out_d_bits_sink     (auto_tl_other_masters_out_d_bits_sink),
    .auto_out_d_bits_denied   (auto_tl_other_masters_out_d_bits_denied),
    .auto_out_d_bits_corrupt  (auto_tl_other_masters_out_d_bits_corrupt),
    .auto_out_e_ready         (auto_tl_other_masters_out_e_ready),
    .auto_in_1_a_ready        (_tlMasterXbar_auto_in_1_a_ready),
    .auto_in_1_d_valid        (_tlMasterXbar_auto_in_1_d_valid),
    .auto_in_0_a_ready        (_tlMasterXbar_auto_in_0_a_ready),
    .auto_in_0_b_valid        (_tlMasterXbar_auto_in_0_b_valid),
    .auto_in_0_b_bits_source  (_tlMasterXbar_auto_in_0_b_bits_source),
    .auto_in_0_d_valid        (_tlMasterXbar_auto_in_0_d_valid),
    .auto_in_0_d_bits_source  (_tlMasterXbar_auto_in_0_d_bits_source),
    .auto_out_a_valid         (auto_tl_other_masters_out_a_valid),
    .auto_out_a_bits_opcode   (auto_tl_other_masters_out_a_bits_opcode),
    .auto_out_a_bits_param    (auto_tl_other_masters_out_a_bits_param),
    .auto_out_a_bits_size     (auto_tl_other_masters_out_a_bits_size),
    .auto_out_a_bits_source   (auto_tl_other_masters_out_a_bits_source),
    .auto_out_a_bits_address  (auto_tl_other_masters_out_a_bits_address),
    .auto_out_a_bits_mask     (auto_tl_other_masters_out_a_bits_mask),
    .auto_out_a_bits_data     (auto_tl_other_masters_out_a_bits_data),
    .auto_out_b_ready         (auto_tl_other_masters_out_b_ready),
    .auto_out_c_bits_source   (auto_tl_other_masters_out_c_bits_source),
    .auto_out_d_ready         (auto_tl_other_masters_out_d_ready)
  );
  DCache dcache (	// HellaCache.scala:265:43
    .gated_clock                       (clock),
    .reset                             (reset),
    .auto_out_a_ready                  (_tlMasterXbar_auto_in_0_a_ready),	// BaseTile.scala:195:42
    .auto_out_b_valid                  (_tlMasterXbar_auto_in_0_b_valid),	// BaseTile.scala:195:42
    .auto_out_b_bits_param             (auto_tl_other_masters_out_b_bits_param),
    .auto_out_b_bits_size              (auto_tl_other_masters_out_b_bits_size),
    .auto_out_b_bits_source            (_tlMasterXbar_auto_in_0_b_bits_source),	// BaseTile.scala:195:42
    .auto_out_b_bits_address           (auto_tl_other_masters_out_b_bits_address),
    .auto_out_c_ready                  (auto_tl_other_masters_out_c_ready),
    .auto_out_d_valid                  (_tlMasterXbar_auto_in_0_d_valid),	// BaseTile.scala:195:42
    .auto_out_d_bits_opcode            (auto_tl_other_masters_out_d_bits_opcode),
    .auto_out_d_bits_param             (auto_tl_other_masters_out_d_bits_param),
    .auto_out_d_bits_size              (auto_tl_other_masters_out_d_bits_size),
    .auto_out_d_bits_source            (_tlMasterXbar_auto_in_0_d_bits_source),	// BaseTile.scala:195:42
    .auto_out_d_bits_denied            (auto_tl_other_masters_out_d_bits_denied),
    .auto_out_d_bits_data              (auto_tl_other_masters_out_d_bits_data),
    .auto_out_e_ready                  (auto_tl_other_masters_out_e_ready),
    .io_cpu_req_valid                  (_dcacheArb_io_mem_req_valid),	// HellaCache.scala:276:25
    .io_cpu_req_bits_addr              (_dcacheArb_io_mem_req_bits_addr),	// HellaCache.scala:276:25
    .io_cpu_req_bits_tag               (_dcacheArb_io_mem_req_bits_tag),	// HellaCache.scala:276:25
    .io_cpu_req_bits_cmd               (_dcacheArb_io_mem_req_bits_cmd),	// HellaCache.scala:276:25
    .io_cpu_req_bits_size              (_dcacheArb_io_mem_req_bits_size),	// HellaCache.scala:276:25
    .io_cpu_req_bits_signed            (_dcacheArb_io_mem_req_bits_signed),	// HellaCache.scala:276:25
    .io_cpu_req_bits_phys              (_dcacheArb_io_mem_req_bits_phys),	// HellaCache.scala:276:25
    .io_cpu_s1_kill                    (_dcacheArb_io_mem_s1_kill),	// HellaCache.scala:276:25
    .io_cpu_s1_data_data               (_dcacheArb_io_mem_s1_data_data),	// HellaCache.scala:276:25
    .io_ptw_req_ready                  (_ptw_io_requestor_0_req_ready),	// PTW.scala:439:19
    .io_ptw_resp_valid                 (_ptw_io_requestor_0_resp_valid),	// PTW.scala:439:19
    .io_ptw_resp_bits_ae               (_ptw_io_requestor_0_resp_bits_ae),	// PTW.scala:439:19
    .io_ptw_resp_bits_pte_ppn          (_ptw_io_requestor_0_resp_bits_pte_ppn),	// PTW.scala:439:19
    .io_ptw_resp_bits_pte_d            (_ptw_io_requestor_0_resp_bits_pte_d),	// PTW.scala:439:19
    .io_ptw_resp_bits_pte_a            (_ptw_io_requestor_0_resp_bits_pte_a),	// PTW.scala:439:19
    .io_ptw_resp_bits_pte_g            (_ptw_io_requestor_0_resp_bits_pte_g),	// PTW.scala:439:19
    .io_ptw_resp_bits_pte_u            (_ptw_io_requestor_0_resp_bits_pte_u),	// PTW.scala:439:19
    .io_ptw_resp_bits_pte_x            (_ptw_io_requestor_0_resp_bits_pte_x),	// PTW.scala:439:19
    .io_ptw_resp_bits_pte_w            (_ptw_io_requestor_0_resp_bits_pte_w),	// PTW.scala:439:19
    .io_ptw_resp_bits_pte_r            (_ptw_io_requestor_0_resp_bits_pte_r),	// PTW.scala:439:19
    .io_ptw_resp_bits_pte_v            (_ptw_io_requestor_0_resp_bits_pte_v),	// PTW.scala:439:19
    .io_ptw_resp_bits_level            (_ptw_io_requestor_0_resp_bits_level),	// PTW.scala:439:19
    .io_ptw_resp_bits_homogeneous      (_ptw_io_requestor_0_resp_bits_homogeneous),	// PTW.scala:439:19
    .io_ptw_ptbr_mode                  (_core_io_ptw_ptbr_mode),	// RocketTile.scala:140:20
    .io_ptw_status_debug               (_core_io_ptw_status_debug),	// RocketTile.scala:140:20
    .io_ptw_status_dprv                (_core_io_ptw_status_dprv),	// RocketTile.scala:140:20
    .io_ptw_status_mxr                 (_core_io_ptw_status_mxr),	// RocketTile.scala:140:20
    .io_ptw_status_sum                 (_core_io_ptw_status_sum),	// RocketTile.scala:140:20
    .io_ptw_pmp_0_cfg_l                (_core_io_ptw_pmp_0_cfg_l),	// RocketTile.scala:140:20
    .io_ptw_pmp_0_cfg_a                (_core_io_ptw_pmp_0_cfg_a),	// RocketTile.scala:140:20
    .io_ptw_pmp_0_cfg_x                (_core_io_ptw_pmp_0_cfg_x),	// RocketTile.scala:140:20
    .io_ptw_pmp_0_cfg_w                (_core_io_ptw_pmp_0_cfg_w),	// RocketTile.scala:140:20
    .io_ptw_pmp_0_cfg_r                (_core_io_ptw_pmp_0_cfg_r),	// RocketTile.scala:140:20
    .io_ptw_pmp_0_addr                 (_core_io_ptw_pmp_0_addr),	// RocketTile.scala:140:20
    .io_ptw_pmp_0_mask                 (_core_io_ptw_pmp_0_mask),	// RocketTile.scala:140:20
    .io_ptw_pmp_1_cfg_l                (_core_io_ptw_pmp_1_cfg_l),	// RocketTile.scala:140:20
    .io_ptw_pmp_1_cfg_a                (_core_io_ptw_pmp_1_cfg_a),	// RocketTile.scala:140:20
    .io_ptw_pmp_1_cfg_x                (_core_io_ptw_pmp_1_cfg_x),	// RocketTile.scala:140:20
    .io_ptw_pmp_1_cfg_w                (_core_io_ptw_pmp_1_cfg_w),	// RocketTile.scala:140:20
    .io_ptw_pmp_1_cfg_r                (_core_io_ptw_pmp_1_cfg_r),	// RocketTile.scala:140:20
    .io_ptw_pmp_1_addr                 (_core_io_ptw_pmp_1_addr),	// RocketTile.scala:140:20
    .io_ptw_pmp_1_mask                 (_core_io_ptw_pmp_1_mask),	// RocketTile.scala:140:20
    .io_ptw_pmp_2_cfg_l                (_core_io_ptw_pmp_2_cfg_l),	// RocketTile.scala:140:20
    .io_ptw_pmp_2_cfg_a                (_core_io_ptw_pmp_2_cfg_a),	// RocketTile.scala:140:20
    .io_ptw_pmp_2_cfg_x                (_core_io_ptw_pmp_2_cfg_x),	// RocketTile.scala:140:20
    .io_ptw_pmp_2_cfg_w                (_core_io_ptw_pmp_2_cfg_w),	// RocketTile.scala:140:20
    .io_ptw_pmp_2_cfg_r                (_core_io_ptw_pmp_2_cfg_r),	// RocketTile.scala:140:20
    .io_ptw_pmp_2_addr                 (_core_io_ptw_pmp_2_addr),	// RocketTile.scala:140:20
    .io_ptw_pmp_2_mask                 (_core_io_ptw_pmp_2_mask),	// RocketTile.scala:140:20
    .io_ptw_pmp_3_cfg_l                (_core_io_ptw_pmp_3_cfg_l),	// RocketTile.scala:140:20
    .io_ptw_pmp_3_cfg_a                (_core_io_ptw_pmp_3_cfg_a),	// RocketTile.scala:140:20
    .io_ptw_pmp_3_cfg_x                (_core_io_ptw_pmp_3_cfg_x),	// RocketTile.scala:140:20
    .io_ptw_pmp_3_cfg_w                (_core_io_ptw_pmp_3_cfg_w),	// RocketTile.scala:140:20
    .io_ptw_pmp_3_cfg_r                (_core_io_ptw_pmp_3_cfg_r),	// RocketTile.scala:140:20
    .io_ptw_pmp_3_addr                 (_core_io_ptw_pmp_3_addr),	// RocketTile.scala:140:20
    .io_ptw_pmp_3_mask                 (_core_io_ptw_pmp_3_mask),	// RocketTile.scala:140:20
    .io_ptw_pmp_4_cfg_l                (_core_io_ptw_pmp_4_cfg_l),	// RocketTile.scala:140:20
    .io_ptw_pmp_4_cfg_a                (_core_io_ptw_pmp_4_cfg_a),	// RocketTile.scala:140:20
    .io_ptw_pmp_4_cfg_x                (_core_io_ptw_pmp_4_cfg_x),	// RocketTile.scala:140:20
    .io_ptw_pmp_4_cfg_w                (_core_io_ptw_pmp_4_cfg_w),	// RocketTile.scala:140:20
    .io_ptw_pmp_4_cfg_r                (_core_io_ptw_pmp_4_cfg_r),	// RocketTile.scala:140:20
    .io_ptw_pmp_4_addr                 (_core_io_ptw_pmp_4_addr),	// RocketTile.scala:140:20
    .io_ptw_pmp_4_mask                 (_core_io_ptw_pmp_4_mask),	// RocketTile.scala:140:20
    .io_ptw_pmp_5_cfg_l                (_core_io_ptw_pmp_5_cfg_l),	// RocketTile.scala:140:20
    .io_ptw_pmp_5_cfg_a                (_core_io_ptw_pmp_5_cfg_a),	// RocketTile.scala:140:20
    .io_ptw_pmp_5_cfg_x                (_core_io_ptw_pmp_5_cfg_x),	// RocketTile.scala:140:20
    .io_ptw_pmp_5_cfg_w                (_core_io_ptw_pmp_5_cfg_w),	// RocketTile.scala:140:20
    .io_ptw_pmp_5_cfg_r                (_core_io_ptw_pmp_5_cfg_r),	// RocketTile.scala:140:20
    .io_ptw_pmp_5_addr                 (_core_io_ptw_pmp_5_addr),	// RocketTile.scala:140:20
    .io_ptw_pmp_5_mask                 (_core_io_ptw_pmp_5_mask),	// RocketTile.scala:140:20
    .io_ptw_pmp_6_cfg_l                (_core_io_ptw_pmp_6_cfg_l),	// RocketTile.scala:140:20
    .io_ptw_pmp_6_cfg_a                (_core_io_ptw_pmp_6_cfg_a),	// RocketTile.scala:140:20
    .io_ptw_pmp_6_cfg_x                (_core_io_ptw_pmp_6_cfg_x),	// RocketTile.scala:140:20
    .io_ptw_pmp_6_cfg_w                (_core_io_ptw_pmp_6_cfg_w),	// RocketTile.scala:140:20
    .io_ptw_pmp_6_cfg_r                (_core_io_ptw_pmp_6_cfg_r),	// RocketTile.scala:140:20
    .io_ptw_pmp_6_addr                 (_core_io_ptw_pmp_6_addr),	// RocketTile.scala:140:20
    .io_ptw_pmp_6_mask                 (_core_io_ptw_pmp_6_mask),	// RocketTile.scala:140:20
    .io_ptw_pmp_7_cfg_l                (_core_io_ptw_pmp_7_cfg_l),	// RocketTile.scala:140:20
    .io_ptw_pmp_7_cfg_a                (_core_io_ptw_pmp_7_cfg_a),	// RocketTile.scala:140:20
    .io_ptw_pmp_7_cfg_x                (_core_io_ptw_pmp_7_cfg_x),	// RocketTile.scala:140:20
    .io_ptw_pmp_7_cfg_w                (_core_io_ptw_pmp_7_cfg_w),	// RocketTile.scala:140:20
    .io_ptw_pmp_7_cfg_r                (_core_io_ptw_pmp_7_cfg_r),	// RocketTile.scala:140:20
    .io_ptw_pmp_7_addr                 (_core_io_ptw_pmp_7_addr),	// RocketTile.scala:140:20
    .io_ptw_pmp_7_mask                 (_core_io_ptw_pmp_7_mask),	// RocketTile.scala:140:20
    .auto_out_a_valid                  (_dcache_auto_out_a_valid),
    .auto_out_a_bits_opcode            (_dcache_auto_out_a_bits_opcode),
    .auto_out_a_bits_param             (_dcache_auto_out_a_bits_param),
    .auto_out_a_bits_size              (_dcache_auto_out_a_bits_size),
    .auto_out_a_bits_source            (_dcache_auto_out_a_bits_source),
    .auto_out_a_bits_address           (_dcache_auto_out_a_bits_address),
    .auto_out_a_bits_mask              (_dcache_auto_out_a_bits_mask),
    .auto_out_a_bits_data              (_dcache_auto_out_a_bits_data),
    .auto_out_b_ready                  (_dcache_auto_out_b_ready),
    .auto_out_c_valid                  (_dcache_auto_out_c_valid),
    .auto_out_c_bits_opcode            (_dcache_auto_out_c_bits_opcode),
    .auto_out_c_bits_param             (_dcache_auto_out_c_bits_param),
    .auto_out_c_bits_size              (_dcache_auto_out_c_bits_size),
    .auto_out_c_bits_source            (_dcache_auto_out_c_bits_source),
    .auto_out_c_bits_address           (_dcache_auto_out_c_bits_address),
    .auto_out_c_bits_data              (auto_tl_other_masters_out_c_bits_data),
    .auto_out_d_ready                  (_dcache_auto_out_d_ready),
    .auto_out_e_valid                  (_dcache_auto_out_e_valid),
    .io_cpu_req_ready                  (_dcache_io_cpu_req_ready),
    .io_cpu_s2_nack                    (_dcache_io_cpu_s2_nack),
    .io_cpu_resp_valid                 (_dcache_io_cpu_resp_valid),
    .io_cpu_resp_bits_tag              (_dcache_io_cpu_resp_bits_tag),
    .io_cpu_resp_bits_size             (_dcache_io_cpu_resp_bits_size),
    .io_cpu_resp_bits_data             (_dcache_io_cpu_resp_bits_data),
    .io_cpu_resp_bits_replay           (_dcache_io_cpu_resp_bits_replay),
    .io_cpu_resp_bits_has_data         (_dcache_io_cpu_resp_bits_has_data),
    .io_cpu_resp_bits_data_word_bypass (_dcache_io_cpu_resp_bits_data_word_bypass),
    .io_cpu_replay_next                (_dcache_io_cpu_replay_next),
    .io_cpu_s2_xcpt_ma_ld              (_dcache_io_cpu_s2_xcpt_ma_ld),
    .io_cpu_s2_xcpt_ma_st              (_dcache_io_cpu_s2_xcpt_ma_st),
    .io_cpu_s2_xcpt_pf_ld              (_dcache_io_cpu_s2_xcpt_pf_ld),
    .io_cpu_s2_xcpt_pf_st              (_dcache_io_cpu_s2_xcpt_pf_st),
    .io_cpu_s2_xcpt_ae_ld              (_dcache_io_cpu_s2_xcpt_ae_ld),
    .io_cpu_s2_xcpt_ae_st              (_dcache_io_cpu_s2_xcpt_ae_st),
    .io_cpu_ordered                    (_dcache_io_cpu_ordered),
    .io_cpu_perf_release               (_dcache_io_cpu_perf_release),
    .io_cpu_perf_grant                 (_dcache_io_cpu_perf_grant),
    .io_ptw_req_valid                  (_dcache_io_ptw_req_valid),
    .io_ptw_req_bits_bits_addr         (_dcache_io_ptw_req_bits_bits_addr)
  );
  Frontend frontend (	// Frontend.scala:350:28
    .gated_clock                               (clock),
    .reset                                     (reset),
    .auto_icache_master_out_a_ready            (_tlMasterXbar_auto_in_1_a_ready),	// BaseTile.scala:195:42
    .auto_icache_master_out_d_valid            (_tlMasterXbar_auto_in_1_d_valid),	// BaseTile.scala:195:42
    .auto_icache_master_out_d_bits_opcode      (auto_tl_other_masters_out_d_bits_opcode),
    .auto_icache_master_out_d_bits_size        (auto_tl_other_masters_out_d_bits_size),
    .auto_icache_master_out_d_bits_data        (auto_tl_other_masters_out_d_bits_data),
    .auto_icache_master_out_d_bits_corrupt     (auto_tl_other_masters_out_d_bits_corrupt),
    .io_cpu_might_request                      (_core_io_imem_might_request),	// RocketTile.scala:140:20
    .io_cpu_req_valid                          (_core_io_imem_req_valid),	// RocketTile.scala:140:20
    .io_cpu_req_bits_pc                        (_core_io_imem_req_bits_pc),	// RocketTile.scala:140:20
    .io_cpu_req_bits_speculative               (_core_io_imem_req_bits_speculative),	// RocketTile.scala:140:20
    .io_cpu_sfence_valid                       (_core_io_imem_sfence_valid),	// RocketTile.scala:140:20
    .io_cpu_sfence_bits_rs1                    (_core_io_imem_sfence_bits_rs1),	// RocketTile.scala:140:20
    .io_cpu_sfence_bits_rs2                    (_core_io_imem_sfence_bits_rs2),	// RocketTile.scala:140:20
    .io_cpu_sfence_bits_addr                   (_core_io_imem_sfence_bits_addr),	// RocketTile.scala:140:20
    .io_cpu_resp_ready                         (_core_io_imem_resp_ready),	// RocketTile.scala:140:20
    .io_cpu_btb_update_valid                   (_core_io_imem_btb_update_valid),	// RocketTile.scala:140:20
    .io_cpu_btb_update_bits_prediction_entry
      (_core_io_imem_btb_update_bits_prediction_entry),	// RocketTile.scala:140:20
    .io_cpu_btb_update_bits_pc                 (_core_io_imem_btb_update_bits_pc),	// RocketTile.scala:140:20
    .io_cpu_btb_update_bits_isValid            (_core_io_imem_btb_update_bits_isValid),	// RocketTile.scala:140:20
    .io_cpu_btb_update_bits_br_pc              (_core_io_imem_btb_update_bits_br_pc),	// RocketTile.scala:140:20
    .io_cpu_btb_update_bits_cfiType            (_core_io_imem_btb_update_bits_cfiType),	// RocketTile.scala:140:20
    .io_cpu_bht_update_valid                   (_core_io_imem_bht_update_valid),	// RocketTile.scala:140:20
    .io_cpu_bht_update_bits_prediction_history
      (_core_io_imem_bht_update_bits_prediction_history),	// RocketTile.scala:140:20
    .io_cpu_bht_update_bits_pc                 (_core_io_imem_bht_update_bits_pc),	// RocketTile.scala:140:20
    .io_cpu_bht_update_bits_branch             (_core_io_imem_bht_update_bits_branch),	// RocketTile.scala:140:20
    .io_cpu_bht_update_bits_taken              (_core_io_imem_bht_update_bits_taken),	// RocketTile.scala:140:20
    .io_cpu_bht_update_bits_mispredict         (_core_io_imem_bht_update_bits_mispredict),	// RocketTile.scala:140:20
    .io_cpu_flush_icache                       (_core_io_imem_flush_icache),	// RocketTile.scala:140:20
    .io_ptw_req_ready                          (_ptw_io_requestor_1_req_ready),	// PTW.scala:439:19
    .io_ptw_resp_valid                         (_ptw_io_requestor_1_resp_valid),	// PTW.scala:439:19
    .io_ptw_resp_bits_ae                       (_ptw_io_requestor_1_resp_bits_ae),	// PTW.scala:439:19
    .io_ptw_resp_bits_pte_ppn                  (_ptw_io_requestor_1_resp_bits_pte_ppn),	// PTW.scala:439:19
    .io_ptw_resp_bits_pte_d                    (_ptw_io_requestor_1_resp_bits_pte_d),	// PTW.scala:439:19
    .io_ptw_resp_bits_pte_a                    (_ptw_io_requestor_1_resp_bits_pte_a),	// PTW.scala:439:19
    .io_ptw_resp_bits_pte_g                    (_ptw_io_requestor_1_resp_bits_pte_g),	// PTW.scala:439:19
    .io_ptw_resp_bits_pte_u                    (_ptw_io_requestor_1_resp_bits_pte_u),	// PTW.scala:439:19
    .io_ptw_resp_bits_pte_x                    (_ptw_io_requestor_1_resp_bits_pte_x),	// PTW.scala:439:19
    .io_ptw_resp_bits_pte_w                    (_ptw_io_requestor_1_resp_bits_pte_w),	// PTW.scala:439:19
    .io_ptw_resp_bits_pte_r                    (_ptw_io_requestor_1_resp_bits_pte_r),	// PTW.scala:439:19
    .io_ptw_resp_bits_pte_v                    (_ptw_io_requestor_1_resp_bits_pte_v),	// PTW.scala:439:19
    .io_ptw_resp_bits_level                    (_ptw_io_requestor_1_resp_bits_level),	// PTW.scala:439:19
    .io_ptw_resp_bits_homogeneous
      (_ptw_io_requestor_1_resp_bits_homogeneous),	// PTW.scala:439:19
    .io_ptw_ptbr_mode                          (_core_io_ptw_ptbr_mode),	// RocketTile.scala:140:20
    .io_ptw_status_debug                       (_core_io_ptw_status_debug),	// RocketTile.scala:140:20
    .io_ptw_status_prv                         (_core_io_ptw_status_prv),	// RocketTile.scala:140:20
    .io_ptw_pmp_0_cfg_l                        (_core_io_ptw_pmp_0_cfg_l),	// RocketTile.scala:140:20
    .io_ptw_pmp_0_cfg_a                        (_core_io_ptw_pmp_0_cfg_a),	// RocketTile.scala:140:20
    .io_ptw_pmp_0_cfg_x                        (_core_io_ptw_pmp_0_cfg_x),	// RocketTile.scala:140:20
    .io_ptw_pmp_0_cfg_w                        (_core_io_ptw_pmp_0_cfg_w),	// RocketTile.scala:140:20
    .io_ptw_pmp_0_cfg_r                        (_core_io_ptw_pmp_0_cfg_r),	// RocketTile.scala:140:20
    .io_ptw_pmp_0_addr                         (_core_io_ptw_pmp_0_addr),	// RocketTile.scala:140:20
    .io_ptw_pmp_0_mask                         (_core_io_ptw_pmp_0_mask),	// RocketTile.scala:140:20
    .io_ptw_pmp_1_cfg_l                        (_core_io_ptw_pmp_1_cfg_l),	// RocketTile.scala:140:20
    .io_ptw_pmp_1_cfg_a                        (_core_io_ptw_pmp_1_cfg_a),	// RocketTile.scala:140:20
    .io_ptw_pmp_1_cfg_x                        (_core_io_ptw_pmp_1_cfg_x),	// RocketTile.scala:140:20
    .io_ptw_pmp_1_cfg_w                        (_core_io_ptw_pmp_1_cfg_w),	// RocketTile.scala:140:20
    .io_ptw_pmp_1_cfg_r                        (_core_io_ptw_pmp_1_cfg_r),	// RocketTile.scala:140:20
    .io_ptw_pmp_1_addr                         (_core_io_ptw_pmp_1_addr),	// RocketTile.scala:140:20
    .io_ptw_pmp_1_mask                         (_core_io_ptw_pmp_1_mask),	// RocketTile.scala:140:20
    .io_ptw_pmp_2_cfg_l                        (_core_io_ptw_pmp_2_cfg_l),	// RocketTile.scala:140:20
    .io_ptw_pmp_2_cfg_a                        (_core_io_ptw_pmp_2_cfg_a),	// RocketTile.scala:140:20
    .io_ptw_pmp_2_cfg_x                        (_core_io_ptw_pmp_2_cfg_x),	// RocketTile.scala:140:20
    .io_ptw_pmp_2_cfg_w                        (_core_io_ptw_pmp_2_cfg_w),	// RocketTile.scala:140:20
    .io_ptw_pmp_2_cfg_r                        (_core_io_ptw_pmp_2_cfg_r),	// RocketTile.scala:140:20
    .io_ptw_pmp_2_addr                         (_core_io_ptw_pmp_2_addr),	// RocketTile.scala:140:20
    .io_ptw_pmp_2_mask                         (_core_io_ptw_pmp_2_mask),	// RocketTile.scala:140:20
    .io_ptw_pmp_3_cfg_l                        (_core_io_ptw_pmp_3_cfg_l),	// RocketTile.scala:140:20
    .io_ptw_pmp_3_cfg_a                        (_core_io_ptw_pmp_3_cfg_a),	// RocketTile.scala:140:20
    .io_ptw_pmp_3_cfg_x                        (_core_io_ptw_pmp_3_cfg_x),	// RocketTile.scala:140:20
    .io_ptw_pmp_3_cfg_w                        (_core_io_ptw_pmp_3_cfg_w),	// RocketTile.scala:140:20
    .io_ptw_pmp_3_cfg_r                        (_core_io_ptw_pmp_3_cfg_r),	// RocketTile.scala:140:20
    .io_ptw_pmp_3_addr                         (_core_io_ptw_pmp_3_addr),	// RocketTile.scala:140:20
    .io_ptw_pmp_3_mask                         (_core_io_ptw_pmp_3_mask),	// RocketTile.scala:140:20
    .io_ptw_pmp_4_cfg_l                        (_core_io_ptw_pmp_4_cfg_l),	// RocketTile.scala:140:20
    .io_ptw_pmp_4_cfg_a                        (_core_io_ptw_pmp_4_cfg_a),	// RocketTile.scala:140:20
    .io_ptw_pmp_4_cfg_x                        (_core_io_ptw_pmp_4_cfg_x),	// RocketTile.scala:140:20
    .io_ptw_pmp_4_cfg_w                        (_core_io_ptw_pmp_4_cfg_w),	// RocketTile.scala:140:20
    .io_ptw_pmp_4_cfg_r                        (_core_io_ptw_pmp_4_cfg_r),	// RocketTile.scala:140:20
    .io_ptw_pmp_4_addr                         (_core_io_ptw_pmp_4_addr),	// RocketTile.scala:140:20
    .io_ptw_pmp_4_mask                         (_core_io_ptw_pmp_4_mask),	// RocketTile.scala:140:20
    .io_ptw_pmp_5_cfg_l                        (_core_io_ptw_pmp_5_cfg_l),	// RocketTile.scala:140:20
    .io_ptw_pmp_5_cfg_a                        (_core_io_ptw_pmp_5_cfg_a),	// RocketTile.scala:140:20
    .io_ptw_pmp_5_cfg_x                        (_core_io_ptw_pmp_5_cfg_x),	// RocketTile.scala:140:20
    .io_ptw_pmp_5_cfg_w                        (_core_io_ptw_pmp_5_cfg_w),	// RocketTile.scala:140:20
    .io_ptw_pmp_5_cfg_r                        (_core_io_ptw_pmp_5_cfg_r),	// RocketTile.scala:140:20
    .io_ptw_pmp_5_addr                         (_core_io_ptw_pmp_5_addr),	// RocketTile.scala:140:20
    .io_ptw_pmp_5_mask                         (_core_io_ptw_pmp_5_mask),	// RocketTile.scala:140:20
    .io_ptw_pmp_6_cfg_l                        (_core_io_ptw_pmp_6_cfg_l),	// RocketTile.scala:140:20
    .io_ptw_pmp_6_cfg_a                        (_core_io_ptw_pmp_6_cfg_a),	// RocketTile.scala:140:20
    .io_ptw_pmp_6_cfg_x                        (_core_io_ptw_pmp_6_cfg_x),	// RocketTile.scala:140:20
    .io_ptw_pmp_6_cfg_w                        (_core_io_ptw_pmp_6_cfg_w),	// RocketTile.scala:140:20
    .io_ptw_pmp_6_cfg_r                        (_core_io_ptw_pmp_6_cfg_r),	// RocketTile.scala:140:20
    .io_ptw_pmp_6_addr                         (_core_io_ptw_pmp_6_addr),	// RocketTile.scala:140:20
    .io_ptw_pmp_6_mask                         (_core_io_ptw_pmp_6_mask),	// RocketTile.scala:140:20
    .io_ptw_pmp_7_cfg_l                        (_core_io_ptw_pmp_7_cfg_l),	// RocketTile.scala:140:20
    .io_ptw_pmp_7_cfg_a                        (_core_io_ptw_pmp_7_cfg_a),	// RocketTile.scala:140:20
    .io_ptw_pmp_7_cfg_x                        (_core_io_ptw_pmp_7_cfg_x),	// RocketTile.scala:140:20
    .io_ptw_pmp_7_cfg_w                        (_core_io_ptw_pmp_7_cfg_w),	// RocketTile.scala:140:20
    .io_ptw_pmp_7_cfg_r                        (_core_io_ptw_pmp_7_cfg_r),	// RocketTile.scala:140:20
    .io_ptw_pmp_7_addr                         (_core_io_ptw_pmp_7_addr),	// RocketTile.scala:140:20
    .io_ptw_pmp_7_mask                         (_core_io_ptw_pmp_7_mask),	// RocketTile.scala:140:20
    .io_ptw_customCSRs_csrs_0_value            (_core_io_ptw_customCSRs_csrs_0_value),	// RocketTile.scala:140:20
    .auto_icache_master_out_a_valid            (_frontend_auto_icache_master_out_a_valid),
    .auto_icache_master_out_a_bits_address
      (_frontend_auto_icache_master_out_a_bits_address),
    .io_cpu_resp_valid                         (_frontend_io_cpu_resp_valid),
    .io_cpu_resp_bits_btb_taken                (_frontend_io_cpu_resp_bits_btb_taken),
    .io_cpu_resp_bits_btb_bridx                (_frontend_io_cpu_resp_bits_btb_bridx),
    .io_cpu_resp_bits_btb_entry                (_frontend_io_cpu_resp_bits_btb_entry),
    .io_cpu_resp_bits_btb_bht_history
      (_frontend_io_cpu_resp_bits_btb_bht_history),
    .io_cpu_resp_bits_pc                       (_frontend_io_cpu_resp_bits_pc),
    .io_cpu_resp_bits_data                     (_frontend_io_cpu_resp_bits_data),
    .io_cpu_resp_bits_xcpt_pf_inst             (_frontend_io_cpu_resp_bits_xcpt_pf_inst),
    .io_cpu_resp_bits_xcpt_ae_inst             (_frontend_io_cpu_resp_bits_xcpt_ae_inst),
    .io_cpu_resp_bits_replay                   (_frontend_io_cpu_resp_bits_replay),
    .io_ptw_req_valid                          (_frontend_io_ptw_req_valid),
    .io_ptw_req_bits_valid                     (_frontend_io_ptw_req_bits_valid),
    .io_ptw_req_bits_bits_addr                 (_frontend_io_ptw_req_bits_bits_addr)
  );
  FPU fpuOpt (	// RocketTile.scala:202:62
    .clock               (clock),
    .reset               (reset),
    .io_inst             (_core_io_fpu_inst),	// RocketTile.scala:140:20
    .io_fromint_data     (_core_io_fpu_fromint_data),	// RocketTile.scala:140:20
    .io_fcsr_rm          (_core_io_fpu_fcsr_rm),	// RocketTile.scala:140:20
    .io_dmem_resp_val    (_core_io_fpu_dmem_resp_val),	// RocketTile.scala:140:20
    .io_dmem_resp_type   (_core_io_fpu_dmem_resp_type),	// RocketTile.scala:140:20
    .io_dmem_resp_tag    (_core_io_fpu_dmem_resp_tag),	// RocketTile.scala:140:20
    .io_dmem_resp_data   (_dcache_io_cpu_resp_bits_data_word_bypass),	// HellaCache.scala:265:43
    .io_valid            (_core_io_fpu_valid),	// RocketTile.scala:140:20
    .io_killx            (_core_io_fpu_killx),	// RocketTile.scala:140:20
    .io_killm            (_core_io_fpu_killm),	// RocketTile.scala:140:20
    .io_fcsr_flags_valid (_fpuOpt_io_fcsr_flags_valid),
    .io_fcsr_flags_bits  (_fpuOpt_io_fcsr_flags_bits),
    .io_store_data       (_fpuOpt_io_store_data),
    .io_toint_data       (_fpuOpt_io_toint_data),
    .io_fcsr_rdy         (_fpuOpt_io_fcsr_rdy),
    .io_nack_mem         (_fpuOpt_io_nack_mem),
    .io_illegal_rm       (_fpuOpt_io_illegal_rm),
    .io_dec_wen          (_fpuOpt_io_dec_wen),
    .io_dec_ren1         (_fpuOpt_io_dec_ren1),
    .io_dec_ren2         (_fpuOpt_io_dec_ren2),
    .io_dec_ren3         (_fpuOpt_io_dec_ren3),
    .io_sboard_set       (_fpuOpt_io_sboard_set),
    .io_sboard_clr       (_fpuOpt_io_sboard_clr),
    .io_sboard_clra      (_fpuOpt_io_sboard_clra)
  );
  HellaCacheArbiter dcacheArb (	// HellaCache.scala:276:25
    .clock                          (clock),
    .io_requestor_0_req_valid       (_ptw_io_mem_req_valid),	// PTW.scala:439:19
    .io_requestor_0_req_bits_addr   (_ptw_io_mem_req_bits_addr),	// PTW.scala:439:19
    .io_requestor_0_s1_kill         (_ptw_io_mem_s1_kill),	// PTW.scala:439:19
    .io_requestor_1_req_valid       (_core_io_dmem_req_valid),	// RocketTile.scala:140:20
    .io_requestor_1_req_bits_addr   (_core_io_dmem_req_bits_addr),	// RocketTile.scala:140:20
    .io_requestor_1_req_bits_tag    (_core_io_dmem_req_bits_tag),	// RocketTile.scala:140:20
    .io_requestor_1_req_bits_cmd    (_core_io_dmem_req_bits_cmd),	// RocketTile.scala:140:20
    .io_requestor_1_req_bits_size   (_core_io_dmem_req_bits_size),	// RocketTile.scala:140:20
    .io_requestor_1_req_bits_signed (_core_io_dmem_req_bits_signed),	// RocketTile.scala:140:20
    .io_requestor_1_s1_kill         (_core_io_dmem_s1_kill),	// RocketTile.scala:140:20
    .io_requestor_1_s1_data_data    (_core_io_dmem_s1_data_data),	// RocketTile.scala:140:20
    .io_mem_req_ready               (_dcache_io_cpu_req_ready),	// HellaCache.scala:265:43
    .io_mem_s2_nack                 (_dcache_io_cpu_s2_nack),	// HellaCache.scala:265:43
    .io_mem_resp_valid              (_dcache_io_cpu_resp_valid),	// HellaCache.scala:265:43
    .io_mem_resp_bits_tag           (_dcache_io_cpu_resp_bits_tag),	// HellaCache.scala:265:43
    .io_requestor_0_s2_nack         (_dcacheArb_io_requestor_0_s2_nack),
    .io_requestor_0_resp_valid      (_dcacheArb_io_requestor_0_resp_valid),
    .io_requestor_1_req_ready       (_dcacheArb_io_requestor_1_req_ready),
    .io_requestor_1_s2_nack         (_dcacheArb_io_requestor_1_s2_nack),
    .io_requestor_1_resp_valid      (_dcacheArb_io_requestor_1_resp_valid),
    .io_requestor_1_resp_bits_tag   (_dcacheArb_io_requestor_1_resp_bits_tag),
    .io_mem_req_valid               (_dcacheArb_io_mem_req_valid),
    .io_mem_req_bits_addr           (_dcacheArb_io_mem_req_bits_addr),
    .io_mem_req_bits_tag            (_dcacheArb_io_mem_req_bits_tag),
    .io_mem_req_bits_cmd            (_dcacheArb_io_mem_req_bits_cmd),
    .io_mem_req_bits_size           (_dcacheArb_io_mem_req_bits_size),
    .io_mem_req_bits_signed         (_dcacheArb_io_mem_req_bits_signed),
    .io_mem_req_bits_phys           (_dcacheArb_io_mem_req_bits_phys),
    .io_mem_s1_kill                 (_dcacheArb_io_mem_s1_kill),
    .io_mem_s1_data_data            (_dcacheArb_io_mem_s1_data_data)
  );
  PTW ptw (	// PTW.scala:439:19
    .clock                                (clock),
    .reset                                (reset),
    .io_requestor_0_req_valid             (_dcache_io_ptw_req_valid),	// HellaCache.scala:265:43
    .io_requestor_0_req_bits_bits_addr    (_dcache_io_ptw_req_bits_bits_addr),	// HellaCache.scala:265:43
    .io_requestor_1_req_valid             (_frontend_io_ptw_req_valid),	// Frontend.scala:350:28
    .io_requestor_1_req_bits_valid        (_frontend_io_ptw_req_bits_valid),	// Frontend.scala:350:28
    .io_requestor_1_req_bits_bits_addr    (_frontend_io_ptw_req_bits_bits_addr),	// Frontend.scala:350:28
    .io_mem_req_ready                     (_dcache_io_cpu_req_ready),	// HellaCache.scala:265:43
    .io_mem_s2_nack                       (_dcacheArb_io_requestor_0_s2_nack),	// HellaCache.scala:276:25
    .io_mem_resp_valid                    (_dcacheArb_io_requestor_0_resp_valid),	// HellaCache.scala:276:25
    .io_mem_resp_bits_data                (_dcache_io_cpu_resp_bits_data),	// HellaCache.scala:265:43
    .io_mem_s2_xcpt_ae_ld                 (_dcache_io_cpu_s2_xcpt_ae_ld),	// HellaCache.scala:265:43
    .io_dpath_ptbr_ppn                    (_core_io_ptw_ptbr_ppn),	// RocketTile.scala:140:20
    .io_dpath_sfence_valid                (_core_io_ptw_sfence_valid),	// RocketTile.scala:140:20
    .io_dpath_sfence_bits_rs1             (_core_io_ptw_sfence_bits_rs1),	// RocketTile.scala:140:20
    .io_dpath_sfence_bits_rs2             (_core_io_ptw_sfence_bits_rs2),	// RocketTile.scala:140:20
    .io_dpath_sfence_bits_addr            (_core_io_ptw_sfence_bits_addr),	// RocketTile.scala:140:20
    .io_dpath_pmp_0_cfg_a                 (_core_io_ptw_pmp_0_cfg_a),	// RocketTile.scala:140:20
    .io_dpath_pmp_0_addr                  (_core_io_ptw_pmp_0_addr),	// RocketTile.scala:140:20
    .io_dpath_pmp_0_mask                  (_core_io_ptw_pmp_0_mask),	// RocketTile.scala:140:20
    .io_dpath_pmp_1_cfg_a                 (_core_io_ptw_pmp_1_cfg_a),	// RocketTile.scala:140:20
    .io_dpath_pmp_1_addr                  (_core_io_ptw_pmp_1_addr),	// RocketTile.scala:140:20
    .io_dpath_pmp_1_mask                  (_core_io_ptw_pmp_1_mask),	// RocketTile.scala:140:20
    .io_dpath_pmp_2_cfg_a                 (_core_io_ptw_pmp_2_cfg_a),	// RocketTile.scala:140:20
    .io_dpath_pmp_2_addr                  (_core_io_ptw_pmp_2_addr),	// RocketTile.scala:140:20
    .io_dpath_pmp_2_mask                  (_core_io_ptw_pmp_2_mask),	// RocketTile.scala:140:20
    .io_dpath_pmp_3_cfg_a                 (_core_io_ptw_pmp_3_cfg_a),	// RocketTile.scala:140:20
    .io_dpath_pmp_3_addr                  (_core_io_ptw_pmp_3_addr),	// RocketTile.scala:140:20
    .io_dpath_pmp_3_mask                  (_core_io_ptw_pmp_3_mask),	// RocketTile.scala:140:20
    .io_dpath_pmp_4_cfg_a                 (_core_io_ptw_pmp_4_cfg_a),	// RocketTile.scala:140:20
    .io_dpath_pmp_4_addr                  (_core_io_ptw_pmp_4_addr),	// RocketTile.scala:140:20
    .io_dpath_pmp_4_mask                  (_core_io_ptw_pmp_4_mask),	// RocketTile.scala:140:20
    .io_dpath_pmp_5_cfg_a                 (_core_io_ptw_pmp_5_cfg_a),	// RocketTile.scala:140:20
    .io_dpath_pmp_5_addr                  (_core_io_ptw_pmp_5_addr),	// RocketTile.scala:140:20
    .io_dpath_pmp_5_mask                  (_core_io_ptw_pmp_5_mask),	// RocketTile.scala:140:20
    .io_dpath_pmp_6_cfg_a                 (_core_io_ptw_pmp_6_cfg_a),	// RocketTile.scala:140:20
    .io_dpath_pmp_6_addr                  (_core_io_ptw_pmp_6_addr),	// RocketTile.scala:140:20
    .io_dpath_pmp_6_mask                  (_core_io_ptw_pmp_6_mask),	// RocketTile.scala:140:20
    .io_dpath_pmp_7_cfg_a                 (_core_io_ptw_pmp_7_cfg_a),	// RocketTile.scala:140:20
    .io_dpath_pmp_7_addr                  (_core_io_ptw_pmp_7_addr),	// RocketTile.scala:140:20
    .io_dpath_pmp_7_mask                  (_core_io_ptw_pmp_7_mask),	// RocketTile.scala:140:20
    .io_requestor_0_req_ready             (_ptw_io_requestor_0_req_ready),
    .io_requestor_0_resp_valid            (_ptw_io_requestor_0_resp_valid),
    .io_requestor_0_resp_bits_ae          (_ptw_io_requestor_0_resp_bits_ae),
    .io_requestor_0_resp_bits_pte_ppn     (_ptw_io_requestor_0_resp_bits_pte_ppn),
    .io_requestor_0_resp_bits_pte_d       (_ptw_io_requestor_0_resp_bits_pte_d),
    .io_requestor_0_resp_bits_pte_a       (_ptw_io_requestor_0_resp_bits_pte_a),
    .io_requestor_0_resp_bits_pte_g       (_ptw_io_requestor_0_resp_bits_pte_g),
    .io_requestor_0_resp_bits_pte_u       (_ptw_io_requestor_0_resp_bits_pte_u),
    .io_requestor_0_resp_bits_pte_x       (_ptw_io_requestor_0_resp_bits_pte_x),
    .io_requestor_0_resp_bits_pte_w       (_ptw_io_requestor_0_resp_bits_pte_w),
    .io_requestor_0_resp_bits_pte_r       (_ptw_io_requestor_0_resp_bits_pte_r),
    .io_requestor_0_resp_bits_pte_v       (_ptw_io_requestor_0_resp_bits_pte_v),
    .io_requestor_0_resp_bits_level       (_ptw_io_requestor_0_resp_bits_level),
    .io_requestor_0_resp_bits_homogeneous (_ptw_io_requestor_0_resp_bits_homogeneous),
    .io_requestor_1_req_ready             (_ptw_io_requestor_1_req_ready),
    .io_requestor_1_resp_valid            (_ptw_io_requestor_1_resp_valid),
    .io_requestor_1_resp_bits_ae          (_ptw_io_requestor_1_resp_bits_ae),
    .io_requestor_1_resp_bits_pte_ppn     (_ptw_io_requestor_1_resp_bits_pte_ppn),
    .io_requestor_1_resp_bits_pte_d       (_ptw_io_requestor_1_resp_bits_pte_d),
    .io_requestor_1_resp_bits_pte_a       (_ptw_io_requestor_1_resp_bits_pte_a),
    .io_requestor_1_resp_bits_pte_g       (_ptw_io_requestor_1_resp_bits_pte_g),
    .io_requestor_1_resp_bits_pte_u       (_ptw_io_requestor_1_resp_bits_pte_u),
    .io_requestor_1_resp_bits_pte_x       (_ptw_io_requestor_1_resp_bits_pte_x),
    .io_requestor_1_resp_bits_pte_w       (_ptw_io_requestor_1_resp_bits_pte_w),
    .io_requestor_1_resp_bits_pte_r       (_ptw_io_requestor_1_resp_bits_pte_r),
    .io_requestor_1_resp_bits_pte_v       (_ptw_io_requestor_1_resp_bits_pte_v),
    .io_requestor_1_resp_bits_level       (_ptw_io_requestor_1_resp_bits_level),
    .io_requestor_1_resp_bits_homogeneous (_ptw_io_requestor_1_resp_bits_homogeneous),
    .io_mem_req_valid                     (_ptw_io_mem_req_valid),
    .io_mem_req_bits_addr                 (_ptw_io_mem_req_bits_addr),
    .io_mem_s1_kill                       (_ptw_io_mem_s1_kill)
  );
  Rocket core (	// RocketTile.scala:140:20
    .clock                                      (clock),
    .reset                                      (reset),
    .io_hartid                                  (3'h0),	// BaseTile.scala:195:42, BundleBridge.scala:196:31, Frontend.scala:350:28, RocketTile.scala:202:62
    .io_interrupts_debug                        (auto_int_local_in_0_0),
    .io_interrupts_mtip                         (auto_int_local_in_1_1),
    .io_interrupts_msip                         (auto_int_local_in_1_0),
    .io_interrupts_meip                         (auto_int_local_in_2_0),
    .io_interrupts_seip                         (auto_int_local_in_3_0),
    .io_imem_resp_valid                         (_frontend_io_cpu_resp_valid),	// Frontend.scala:350:28
    .io_imem_resp_bits_btb_taken                (_frontend_io_cpu_resp_bits_btb_taken),	// Frontend.scala:350:28
    .io_imem_resp_bits_btb_bridx                (_frontend_io_cpu_resp_bits_btb_bridx),	// Frontend.scala:350:28
    .io_imem_resp_bits_btb_entry                (_frontend_io_cpu_resp_bits_btb_entry),	// Frontend.scala:350:28
    .io_imem_resp_bits_btb_bht_history
      (_frontend_io_cpu_resp_bits_btb_bht_history),	// Frontend.scala:350:28
    .io_imem_resp_bits_pc                       (_frontend_io_cpu_resp_bits_pc),	// Frontend.scala:350:28
    .io_imem_resp_bits_data                     (_frontend_io_cpu_resp_bits_data),	// Frontend.scala:350:28
    .io_imem_resp_bits_xcpt_pf_inst             (_frontend_io_cpu_resp_bits_xcpt_pf_inst),	// Frontend.scala:350:28
    .io_imem_resp_bits_xcpt_ae_inst             (_frontend_io_cpu_resp_bits_xcpt_ae_inst),	// Frontend.scala:350:28
    .io_imem_resp_bits_replay                   (_frontend_io_cpu_resp_bits_replay),	// Frontend.scala:350:28
    .io_dmem_req_ready                          (_dcacheArb_io_requestor_1_req_ready),	// HellaCache.scala:276:25
    .io_dmem_s2_nack                            (_dcacheArb_io_requestor_1_s2_nack),	// HellaCache.scala:276:25
    .io_dmem_resp_valid                         (_dcacheArb_io_requestor_1_resp_valid),	// HellaCache.scala:276:25
    .io_dmem_resp_bits_tag                      (_dcacheArb_io_requestor_1_resp_bits_tag),	// HellaCache.scala:276:25
    .io_dmem_resp_bits_size                     (_dcache_io_cpu_resp_bits_size),	// HellaCache.scala:265:43
    .io_dmem_resp_bits_data                     (_dcache_io_cpu_resp_bits_data),	// HellaCache.scala:265:43
    .io_dmem_resp_bits_replay                   (_dcache_io_cpu_resp_bits_replay),	// HellaCache.scala:265:43
    .io_dmem_resp_bits_has_data                 (_dcache_io_cpu_resp_bits_has_data),	// HellaCache.scala:265:43
    .io_dmem_resp_bits_data_word_bypass
      (_dcache_io_cpu_resp_bits_data_word_bypass),	// HellaCache.scala:265:43
    .io_dmem_replay_next                        (_dcache_io_cpu_replay_next),	// HellaCache.scala:265:43
    .io_dmem_s2_xcpt_ma_ld                      (_dcache_io_cpu_s2_xcpt_ma_ld),	// HellaCache.scala:265:43
    .io_dmem_s2_xcpt_ma_st                      (_dcache_io_cpu_s2_xcpt_ma_st),	// HellaCache.scala:265:43
    .io_dmem_s2_xcpt_pf_ld                      (_dcache_io_cpu_s2_xcpt_pf_ld),	// HellaCache.scala:265:43
    .io_dmem_s2_xcpt_pf_st                      (_dcache_io_cpu_s2_xcpt_pf_st),	// HellaCache.scala:265:43
    .io_dmem_s2_xcpt_ae_ld                      (_dcache_io_cpu_s2_xcpt_ae_ld),	// HellaCache.scala:265:43
    .io_dmem_s2_xcpt_ae_st                      (_dcache_io_cpu_s2_xcpt_ae_st),	// HellaCache.scala:265:43
    .io_dmem_ordered                            (_dcache_io_cpu_ordered),	// HellaCache.scala:265:43
    .io_dmem_perf_release                       (_dcache_io_cpu_perf_release),	// HellaCache.scala:265:43
    .io_dmem_perf_grant                         (_dcache_io_cpu_perf_grant),	// HellaCache.scala:265:43
    .io_fpu_fcsr_flags_valid                    (_fpuOpt_io_fcsr_flags_valid),	// RocketTile.scala:202:62
    .io_fpu_fcsr_flags_bits                     (_fpuOpt_io_fcsr_flags_bits),	// RocketTile.scala:202:62
    .io_fpu_store_data                          (_fpuOpt_io_store_data),	// RocketTile.scala:202:62
    .io_fpu_toint_data                          (_fpuOpt_io_toint_data),	// RocketTile.scala:202:62
    .io_fpu_fcsr_rdy                            (_fpuOpt_io_fcsr_rdy),	// RocketTile.scala:202:62
    .io_fpu_nack_mem                            (_fpuOpt_io_nack_mem),	// RocketTile.scala:202:62
    .io_fpu_illegal_rm                          (_fpuOpt_io_illegal_rm),	// RocketTile.scala:202:62
    .io_fpu_dec_wen                             (_fpuOpt_io_dec_wen),	// RocketTile.scala:202:62
    .io_fpu_dec_ren1                            (_fpuOpt_io_dec_ren1),	// RocketTile.scala:202:62
    .io_fpu_dec_ren2                            (_fpuOpt_io_dec_ren2),	// RocketTile.scala:202:62
    .io_fpu_dec_ren3                            (_fpuOpt_io_dec_ren3),	// RocketTile.scala:202:62
    .io_fpu_sboard_set                          (_fpuOpt_io_sboard_set),	// RocketTile.scala:202:62
    .io_fpu_sboard_clr                          (_fpuOpt_io_sboard_clr),	// RocketTile.scala:202:62
    .io_fpu_sboard_clra                         (_fpuOpt_io_sboard_clra),	// RocketTile.scala:202:62
    .io_imem_might_request                      (_core_io_imem_might_request),
    .io_imem_req_valid                          (_core_io_imem_req_valid),
    .io_imem_req_bits_pc                        (_core_io_imem_req_bits_pc),
    .io_imem_req_bits_speculative               (_core_io_imem_req_bits_speculative),
    .io_imem_sfence_valid                       (_core_io_imem_sfence_valid),
    .io_imem_sfence_bits_rs1                    (_core_io_imem_sfence_bits_rs1),
    .io_imem_sfence_bits_rs2                    (_core_io_imem_sfence_bits_rs2),
    .io_imem_sfence_bits_addr                   (_core_io_imem_sfence_bits_addr),
    .io_imem_resp_ready                         (_core_io_imem_resp_ready),
    .io_imem_btb_update_valid                   (_core_io_imem_btb_update_valid),
    .io_imem_btb_update_bits_prediction_entry
      (_core_io_imem_btb_update_bits_prediction_entry),
    .io_imem_btb_update_bits_pc                 (_core_io_imem_btb_update_bits_pc),
    .io_imem_btb_update_bits_isValid            (_core_io_imem_btb_update_bits_isValid),
    .io_imem_btb_update_bits_br_pc              (_core_io_imem_btb_update_bits_br_pc),
    .io_imem_btb_update_bits_cfiType            (_core_io_imem_btb_update_bits_cfiType),
    .io_imem_bht_update_valid                   (_core_io_imem_bht_update_valid),
    .io_imem_bht_update_bits_prediction_history
      (_core_io_imem_bht_update_bits_prediction_history),
    .io_imem_bht_update_bits_pc                 (_core_io_imem_bht_update_bits_pc),
    .io_imem_bht_update_bits_branch             (_core_io_imem_bht_update_bits_branch),
    .io_imem_bht_update_bits_taken              (_core_io_imem_bht_update_bits_taken),
    .io_imem_bht_update_bits_mispredict
      (_core_io_imem_bht_update_bits_mispredict),
    .io_imem_flush_icache                       (_core_io_imem_flush_icache),
    .io_dmem_req_valid                          (_core_io_dmem_req_valid),
    .io_dmem_req_bits_addr                      (_core_io_dmem_req_bits_addr),
    .io_dmem_req_bits_tag                       (_core_io_dmem_req_bits_tag),
    .io_dmem_req_bits_cmd                       (_core_io_dmem_req_bits_cmd),
    .io_dmem_req_bits_size                      (_core_io_dmem_req_bits_size),
    .io_dmem_req_bits_signed                    (_core_io_dmem_req_bits_signed),
    .io_dmem_s1_kill                            (_core_io_dmem_s1_kill),
    .io_dmem_s1_data_data                       (_core_io_dmem_s1_data_data),
    .io_ptw_ptbr_mode                           (_core_io_ptw_ptbr_mode),
    .io_ptw_ptbr_ppn                            (_core_io_ptw_ptbr_ppn),
    .io_ptw_sfence_valid                        (_core_io_ptw_sfence_valid),
    .io_ptw_sfence_bits_rs1                     (_core_io_ptw_sfence_bits_rs1),
    .io_ptw_sfence_bits_rs2                     (_core_io_ptw_sfence_bits_rs2),
    .io_ptw_sfence_bits_addr                    (_core_io_ptw_sfence_bits_addr),
    .io_ptw_status_debug                        (_core_io_ptw_status_debug),
    .io_ptw_status_dprv                         (_core_io_ptw_status_dprv),
    .io_ptw_status_prv                          (_core_io_ptw_status_prv),
    .io_ptw_status_mxr                          (_core_io_ptw_status_mxr),
    .io_ptw_status_sum                          (_core_io_ptw_status_sum),
    .io_ptw_pmp_0_cfg_l                         (_core_io_ptw_pmp_0_cfg_l),
    .io_ptw_pmp_0_cfg_a                         (_core_io_ptw_pmp_0_cfg_a),
    .io_ptw_pmp_0_cfg_x                         (_core_io_ptw_pmp_0_cfg_x),
    .io_ptw_pmp_0_cfg_w                         (_core_io_ptw_pmp_0_cfg_w),
    .io_ptw_pmp_0_cfg_r                         (_core_io_ptw_pmp_0_cfg_r),
    .io_ptw_pmp_0_addr                          (_core_io_ptw_pmp_0_addr),
    .io_ptw_pmp_0_mask                          (_core_io_ptw_pmp_0_mask),
    .io_ptw_pmp_1_cfg_l                         (_core_io_ptw_pmp_1_cfg_l),
    .io_ptw_pmp_1_cfg_a                         (_core_io_ptw_pmp_1_cfg_a),
    .io_ptw_pmp_1_cfg_x                         (_core_io_ptw_pmp_1_cfg_x),
    .io_ptw_pmp_1_cfg_w                         (_core_io_ptw_pmp_1_cfg_w),
    .io_ptw_pmp_1_cfg_r                         (_core_io_ptw_pmp_1_cfg_r),
    .io_ptw_pmp_1_addr                          (_core_io_ptw_pmp_1_addr),
    .io_ptw_pmp_1_mask                          (_core_io_ptw_pmp_1_mask),
    .io_ptw_pmp_2_cfg_l                         (_core_io_ptw_pmp_2_cfg_l),
    .io_ptw_pmp_2_cfg_a                         (_core_io_ptw_pmp_2_cfg_a),
    .io_ptw_pmp_2_cfg_x                         (_core_io_ptw_pmp_2_cfg_x),
    .io_ptw_pmp_2_cfg_w                         (_core_io_ptw_pmp_2_cfg_w),
    .io_ptw_pmp_2_cfg_r                         (_core_io_ptw_pmp_2_cfg_r),
    .io_ptw_pmp_2_addr                          (_core_io_ptw_pmp_2_addr),
    .io_ptw_pmp_2_mask                          (_core_io_ptw_pmp_2_mask),
    .io_ptw_pmp_3_cfg_l                         (_core_io_ptw_pmp_3_cfg_l),
    .io_ptw_pmp_3_cfg_a                         (_core_io_ptw_pmp_3_cfg_a),
    .io_ptw_pmp_3_cfg_x                         (_core_io_ptw_pmp_3_cfg_x),
    .io_ptw_pmp_3_cfg_w                         (_core_io_ptw_pmp_3_cfg_w),
    .io_ptw_pmp_3_cfg_r                         (_core_io_ptw_pmp_3_cfg_r),
    .io_ptw_pmp_3_addr                          (_core_io_ptw_pmp_3_addr),
    .io_ptw_pmp_3_mask                          (_core_io_ptw_pmp_3_mask),
    .io_ptw_pmp_4_cfg_l                         (_core_io_ptw_pmp_4_cfg_l),
    .io_ptw_pmp_4_cfg_a                         (_core_io_ptw_pmp_4_cfg_a),
    .io_ptw_pmp_4_cfg_x                         (_core_io_ptw_pmp_4_cfg_x),
    .io_ptw_pmp_4_cfg_w                         (_core_io_ptw_pmp_4_cfg_w),
    .io_ptw_pmp_4_cfg_r                         (_core_io_ptw_pmp_4_cfg_r),
    .io_ptw_pmp_4_addr                          (_core_io_ptw_pmp_4_addr),
    .io_ptw_pmp_4_mask                          (_core_io_ptw_pmp_4_mask),
    .io_ptw_pmp_5_cfg_l                         (_core_io_ptw_pmp_5_cfg_l),
    .io_ptw_pmp_5_cfg_a                         (_core_io_ptw_pmp_5_cfg_a),
    .io_ptw_pmp_5_cfg_x                         (_core_io_ptw_pmp_5_cfg_x),
    .io_ptw_pmp_5_cfg_w                         (_core_io_ptw_pmp_5_cfg_w),
    .io_ptw_pmp_5_cfg_r                         (_core_io_ptw_pmp_5_cfg_r),
    .io_ptw_pmp_5_addr                          (_core_io_ptw_pmp_5_addr),
    .io_ptw_pmp_5_mask                          (_core_io_ptw_pmp_5_mask),
    .io_ptw_pmp_6_cfg_l                         (_core_io_ptw_pmp_6_cfg_l),
    .io_ptw_pmp_6_cfg_a                         (_core_io_ptw_pmp_6_cfg_a),
    .io_ptw_pmp_6_cfg_x                         (_core_io_ptw_pmp_6_cfg_x),
    .io_ptw_pmp_6_cfg_w                         (_core_io_ptw_pmp_6_cfg_w),
    .io_ptw_pmp_6_cfg_r                         (_core_io_ptw_pmp_6_cfg_r),
    .io_ptw_pmp_6_addr                          (_core_io_ptw_pmp_6_addr),
    .io_ptw_pmp_6_mask                          (_core_io_ptw_pmp_6_mask),
    .io_ptw_pmp_7_cfg_l                         (_core_io_ptw_pmp_7_cfg_l),
    .io_ptw_pmp_7_cfg_a                         (_core_io_ptw_pmp_7_cfg_a),
    .io_ptw_pmp_7_cfg_x                         (_core_io_ptw_pmp_7_cfg_x),
    .io_ptw_pmp_7_cfg_w                         (_core_io_ptw_pmp_7_cfg_w),
    .io_ptw_pmp_7_cfg_r                         (_core_io_ptw_pmp_7_cfg_r),
    .io_ptw_pmp_7_addr                          (_core_io_ptw_pmp_7_addr),
    .io_ptw_pmp_7_mask                          (_core_io_ptw_pmp_7_mask),
    .io_ptw_customCSRs_csrs_0_value             (_core_io_ptw_customCSRs_csrs_0_value),
    .io_fpu_inst                                (_core_io_fpu_inst),
    .io_fpu_fromint_data                        (_core_io_fpu_fromint_data),
    .io_fpu_fcsr_rm                             (_core_io_fpu_fcsr_rm),
    .io_fpu_dmem_resp_val                       (_core_io_fpu_dmem_resp_val),
    .io_fpu_dmem_resp_type                      (_core_io_fpu_dmem_resp_type),
    .io_fpu_dmem_resp_tag                       (_core_io_fpu_dmem_resp_tag),
    .io_fpu_valid                               (_core_io_fpu_valid),
    .io_fpu_killx                               (_core_io_fpu_killx),
    .io_fpu_killm                               (_core_io_fpu_killm),
    .io_wfi                                     (_core_io_wfi)
  );
  assign auto_wfi_out_0 = bundleOut_0_0_REG;	// Interrupts.scala:129:36
  assign auto_tl_other_masters_out_c_valid = _dcache_auto_out_c_valid;	// HellaCache.scala:265:43
  assign auto_tl_other_masters_out_c_bits_opcode = _dcache_auto_out_c_bits_opcode;	// HellaCache.scala:265:43
  assign auto_tl_other_masters_out_c_bits_param = _dcache_auto_out_c_bits_param;	// HellaCache.scala:265:43
  assign auto_tl_other_masters_out_c_bits_size = _dcache_auto_out_c_bits_size;	// HellaCache.scala:265:43
  assign auto_tl_other_masters_out_c_bits_address = _dcache_auto_out_c_bits_address;	// HellaCache.scala:265:43
  assign auto_tl_other_masters_out_e_valid = _dcache_auto_out_e_valid;	// HellaCache.scala:265:43
endmodule

