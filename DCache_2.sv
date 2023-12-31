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

module DCache_2(
  input         gated_clock,
                reset,
                auto_out_a_ready,
                auto_out_b_valid,
  input  [1:0]  auto_out_b_bits_param,
  input  [3:0]  auto_out_b_bits_size,
  input         auto_out_b_bits_source,
  input  [31:0] auto_out_b_bits_address,
  input         auto_out_c_ready,
                auto_out_d_valid,
  input  [2:0]  auto_out_d_bits_opcode,
  input  [1:0]  auto_out_d_bits_param,
  input  [3:0]  auto_out_d_bits_size,
  input         auto_out_d_bits_source,
                auto_out_d_bits_denied,
  input  [63:0] auto_out_d_bits_data,
  input         auto_out_e_ready,
                io_cpu_req_valid,
  input  [33:0] io_cpu_req_bits_addr,
  input  [5:0]  io_cpu_req_bits_tag,
  input  [4:0]  io_cpu_req_bits_cmd,
  input  [1:0]  io_cpu_req_bits_size,
  input         io_cpu_req_bits_signed,
                io_cpu_s1_kill,
  input  [63:0] io_cpu_s1_data_data,
  input         io_ptw_resp_valid,
                io_ptw_status_debug,
  input  [1:0]  io_ptw_status_dprv,
  input         io_ptw_status_mxr,
                io_ptw_status_sum,
                io_ptw_pmp_0_cfg_l,
  input  [1:0]  io_ptw_pmp_0_cfg_a,
  input         io_ptw_pmp_0_cfg_x,
                io_ptw_pmp_0_cfg_w,
                io_ptw_pmp_0_cfg_r,
  input  [29:0] io_ptw_pmp_0_addr,
  input  [31:0] io_ptw_pmp_0_mask,
  input         io_ptw_pmp_1_cfg_l,
  input  [1:0]  io_ptw_pmp_1_cfg_a,
  input         io_ptw_pmp_1_cfg_x,
                io_ptw_pmp_1_cfg_w,
                io_ptw_pmp_1_cfg_r,
  input  [29:0] io_ptw_pmp_1_addr,
  input  [31:0] io_ptw_pmp_1_mask,
  input         io_ptw_pmp_2_cfg_l,
  input  [1:0]  io_ptw_pmp_2_cfg_a,
  input         io_ptw_pmp_2_cfg_x,
                io_ptw_pmp_2_cfg_w,
                io_ptw_pmp_2_cfg_r,
  input  [29:0] io_ptw_pmp_2_addr,
  input  [31:0] io_ptw_pmp_2_mask,
  input         io_ptw_pmp_3_cfg_l,
  input  [1:0]  io_ptw_pmp_3_cfg_a,
  input         io_ptw_pmp_3_cfg_x,
                io_ptw_pmp_3_cfg_w,
                io_ptw_pmp_3_cfg_r,
  input  [29:0] io_ptw_pmp_3_addr,
  input  [31:0] io_ptw_pmp_3_mask,
  input         io_ptw_pmp_4_cfg_l,
  input  [1:0]  io_ptw_pmp_4_cfg_a,
  input         io_ptw_pmp_4_cfg_x,
                io_ptw_pmp_4_cfg_w,
                io_ptw_pmp_4_cfg_r,
  input  [29:0] io_ptw_pmp_4_addr,
  input  [31:0] io_ptw_pmp_4_mask,
  input         io_ptw_pmp_5_cfg_l,
  input  [1:0]  io_ptw_pmp_5_cfg_a,
  input         io_ptw_pmp_5_cfg_x,
                io_ptw_pmp_5_cfg_w,
                io_ptw_pmp_5_cfg_r,
  input  [29:0] io_ptw_pmp_5_addr,
  input  [31:0] io_ptw_pmp_5_mask,
  input         io_ptw_pmp_6_cfg_l,
  input  [1:0]  io_ptw_pmp_6_cfg_a,
  input         io_ptw_pmp_6_cfg_x,
                io_ptw_pmp_6_cfg_w,
                io_ptw_pmp_6_cfg_r,
  input  [29:0] io_ptw_pmp_6_addr,
  input  [31:0] io_ptw_pmp_6_mask,
  input         io_ptw_pmp_7_cfg_l,
  input  [1:0]  io_ptw_pmp_7_cfg_a,
  input         io_ptw_pmp_7_cfg_x,
                io_ptw_pmp_7_cfg_w,
                io_ptw_pmp_7_cfg_r,
  input  [29:0] io_ptw_pmp_7_addr,
  input  [31:0] io_ptw_pmp_7_mask,
  output        auto_out_a_valid,
  output [2:0]  auto_out_a_bits_opcode,
                auto_out_a_bits_param,
  output [3:0]  auto_out_a_bits_size,
  output        auto_out_a_bits_source,
  output [31:0] auto_out_a_bits_address,
  output [7:0]  auto_out_a_bits_mask,
  output [63:0] auto_out_a_bits_data,
  output        auto_out_b_ready,
                auto_out_c_valid,
  output [2:0]  auto_out_c_bits_opcode,
                auto_out_c_bits_param,
  output [3:0]  auto_out_c_bits_size,
  output        auto_out_c_bits_source,
  output [31:0] auto_out_c_bits_address,
  output [63:0] auto_out_c_bits_data,
  output        auto_out_d_ready,
                auto_out_e_valid,
                io_cpu_req_ready,
                io_cpu_s2_nack,
                io_cpu_resp_valid,
  output [5:0]  io_cpu_resp_bits_tag,
  output [63:0] io_cpu_resp_bits_data,
  output        io_cpu_resp_bits_replay,
                io_cpu_resp_bits_has_data,
  output [63:0] io_cpu_resp_bits_data_word_bypass,
  output        io_cpu_replay_next,
                io_cpu_s2_xcpt_ma_ld,
                io_cpu_s2_xcpt_ma_st,
                io_cpu_s2_xcpt_pf_ld,
                io_cpu_s2_xcpt_pf_st,
                io_cpu_s2_xcpt_ae_ld,
                io_cpu_s2_xcpt_ae_st,
                io_cpu_ordered,
                io_cpu_perf_release,
                io_cpu_perf_grant,
                io_ptw_req_valid,
  output [20:0] io_ptw_req_bits_bits_addr
);

  wire             _io_cpu_s2_xcpt_ma_st_output;	// DCache.scala:903:24
  wire             _io_cpu_s2_xcpt_ma_ld_output;	// DCache.scala:903:24
  wire             _io_cpu_s2_xcpt_ae_st_output;	// DCache.scala:903:24
  wire             _io_cpu_s2_xcpt_ae_ld_output;	// DCache.scala:903:24
  wire             _io_cpu_s2_xcpt_pf_st_output;	// DCache.scala:903:24
  wire             _io_cpu_s2_xcpt_pf_ld_output;	// DCache.scala:903:24
  wire [3:0]       tl_out_c_bits_size;	// DCache.scala:841:48, :845:102, :846:52
  wire [2:0]       tl_out_c_bits_opcode;	// DCache.scala:841:48, :845:102, :846:52
  wire             tl_out_c_valid;	// DCache.scala:806:21, :832:47, :833:22, :836:48, :837:22
  wire             s1_nack;	// DCache.scala:543:36, :806:21, :821:24
  wire             tl_out_d_ready;	// DCache.scala:643:18, :694:51, :696:20, :724:68, :725:22
  wire             readEnable;	// DCache.scala:286:59
  wire             writeEnable;	// DCache.scala:282:27
  wire [63:0]      _amoalu_io_out;	// DCache.scala:952:26
  wire             _dataArb_io_in_1_ready;	// DCache.scala:133:23
  wire             _dataArb_io_in_2_ready;	// DCache.scala:133:23
  wire             _dataArb_io_in_3_ready;	// DCache.scala:133:23
  wire             _dataArb_io_out_valid;	// DCache.scala:133:23
  wire [11:0]      _dataArb_io_out_bits_addr;	// DCache.scala:133:23
  wire             _dataArb_io_out_bits_write;	// DCache.scala:133:23
  wire [63:0]      _dataArb_io_out_bits_wdata;	// DCache.scala:133:23
  wire [7:0]       _dataArb_io_out_bits_eccMask;	// DCache.scala:133:23
  wire [63:0]      _data_io_resp_0;	// DCache.scala:132:20
  wire [21:0]      _tag_array_0_ext_RW0_rdata;	// DescribedSRAM.scala:19:26
  wire             _metaArb_io_in_4_ready;	// DCache.scala:122:23
  wire             _metaArb_io_in_6_ready;	// DCache.scala:122:23
  wire             _metaArb_io_in_7_ready;	// DCache.scala:122:23
  wire             _metaArb_io_out_valid;	// DCache.scala:122:23
  wire             _metaArb_io_out_bits_write;	// DCache.scala:122:23
  wire [33:0]      _metaArb_io_out_bits_addr;	// DCache.scala:122:23
  wire [5:0]       _metaArb_io_out_bits_idx;	// DCache.scala:122:23
  wire [21:0]      _metaArb_io_out_bits_data;	// DCache.scala:122:23
  wire             _tlb_io_req_ready;	// DCache.scala:117:19
  wire [31:0]      _tlb_io_resp_paddr;	// DCache.scala:117:19
  wire             _tlb_io_resp_pf_ld;	// DCache.scala:117:19
  wire             _tlb_io_resp_pf_st;	// DCache.scala:117:19
  wire             _tlb_io_resp_ae_ld;	// DCache.scala:117:19
  wire             _tlb_io_resp_ae_st;	// DCache.scala:117:19
  wire             _tlb_io_resp_ma_ld;	// DCache.scala:117:19
  wire             _tlb_io_resp_ma_st;	// DCache.scala:117:19
  wire             _tlb_io_resp_cacheable;	// DCache.scala:117:19
  wire             _tlb_io_resp_must_alloc;	// DCache.scala:117:19
  reg              s1_valid;	// DCache.scala:162:21
  reg              s1_probe;	// DCache.scala:163:21
  reg  [1:0]       probe_bits_param;	// Reg.scala:15:16
  reg  [3:0]       probe_bits_size;	// Reg.scala:15:16
  reg              probe_bits_source;	// Reg.scala:15:16
  reg  [31:0]      probe_bits_address;	// Reg.scala:15:16
  reg  [33:0]      s1_vaddr;	// Reg.scala:15:16
  reg  [5:0]       s1_req_tag;	// Reg.scala:15:16
  reg  [4:0]       s1_req_cmd;	// Reg.scala:15:16
  reg  [1:0]       s1_req_size;	// Reg.scala:15:16
  reg              s1_req_signed;	// Reg.scala:15:16
  reg              s1_req_phys;	// Reg.scala:15:16
  reg              s1_req_no_alloc;	// Reg.scala:15:16
  reg              s1_req_no_xcpt;	// Reg.scala:15:16
  reg  [33:0]      s1_tlb_req_vaddr;	// Reg.scala:15:16
  reg  [1:0]       s1_tlb_req_size;	// Reg.scala:15:16
  reg  [4:0]       s1_tlb_req_cmd;	// Reg.scala:15:16
  wire             _io_cpu_perf_canAcceptLoadThenLoad_T_1 = s1_req_cmd == 5'h0;	// Consts.scala:81:31, Reg.scala:15:16
  wire             _io_cpu_perf_canAcceptLoadThenLoad_T_2 = s1_req_cmd == 5'h6;	// Consts.scala:81:48, Reg.scala:15:16
  wire             _io_cpu_perf_canAcceptLoadThenLoad_T_27 = s1_req_cmd == 5'h7;	// Consts.scala:81:65, Reg.scala:15:16
  wire             _io_cpu_perf_canAcceptLoadThenLoad_T_29 = s1_req_cmd == 5'h4;	// Reg.scala:15:16, package.scala:15:47
  wire             _io_cpu_perf_canAcceptLoadThenLoad_T_30 = s1_req_cmd == 5'h9;	// Reg.scala:15:16, package.scala:15:47
  wire             _io_cpu_perf_canAcceptLoadThenLoad_T_31 = s1_req_cmd == 5'hA;	// Reg.scala:15:16, package.scala:15:47
  wire             _io_cpu_perf_canAcceptLoadThenLoad_T_32 = s1_req_cmd == 5'hB;	// Reg.scala:15:16, package.scala:15:47
  wire             _io_cpu_perf_canAcceptLoadThenLoad_T_36 = s1_req_cmd == 5'h8;	// Reg.scala:15:16, package.scala:15:47
  wire             _io_cpu_perf_canAcceptLoadThenLoad_T_37 = s1_req_cmd == 5'hC;	// Reg.scala:15:16, package.scala:15:47
  wire             _io_cpu_perf_canAcceptLoadThenLoad_T_38 = s1_req_cmd == 5'hD;	// Reg.scala:15:16, package.scala:15:47
  wire             _io_cpu_perf_canAcceptLoadThenLoad_T_39 = s1_req_cmd == 5'hE;	// Reg.scala:15:16, package.scala:15:47
  wire             _io_cpu_perf_canAcceptLoadThenLoad_T_40 = s1_req_cmd == 5'hF;	// Reg.scala:15:16, package.scala:15:47
  wire             s1_read =
    _io_cpu_perf_canAcceptLoadThenLoad_T_1 | _io_cpu_perf_canAcceptLoadThenLoad_T_2
    | _io_cpu_perf_canAcceptLoadThenLoad_T_27 | _io_cpu_perf_canAcceptLoadThenLoad_T_29
    | _io_cpu_perf_canAcceptLoadThenLoad_T_30 | _io_cpu_perf_canAcceptLoadThenLoad_T_31
    | _io_cpu_perf_canAcceptLoadThenLoad_T_32 | _io_cpu_perf_canAcceptLoadThenLoad_T_36
    | _io_cpu_perf_canAcceptLoadThenLoad_T_37 | _io_cpu_perf_canAcceptLoadThenLoad_T_38
    | _io_cpu_perf_canAcceptLoadThenLoad_T_39 | _io_cpu_perf_canAcceptLoadThenLoad_T_40;	// Consts.scala:81:{31,48,65,75}, package.scala:15:47
  wire             _io_cpu_perf_canAcceptLoadThenLoad_T_24 = s1_req_cmd == 5'h1;	// Consts.scala:82:32, Reg.scala:15:16
  wire             _io_cpu_perf_canAcceptLoadThenLoad_T_49 = s1_req_cmd == 5'h11;	// Consts.scala:82:49, Reg.scala:15:16
  wire             s1_write =
    _io_cpu_perf_canAcceptLoadThenLoad_T_24 | _io_cpu_perf_canAcceptLoadThenLoad_T_49
    | _io_cpu_perf_canAcceptLoadThenLoad_T_27 | _io_cpu_perf_canAcceptLoadThenLoad_T_29
    | _io_cpu_perf_canAcceptLoadThenLoad_T_30 | _io_cpu_perf_canAcceptLoadThenLoad_T_31
    | _io_cpu_perf_canAcceptLoadThenLoad_T_32 | _io_cpu_perf_canAcceptLoadThenLoad_T_36
    | _io_cpu_perf_canAcceptLoadThenLoad_T_37 | _io_cpu_perf_canAcceptLoadThenLoad_T_38
    | _io_cpu_perf_canAcceptLoadThenLoad_T_39 | _io_cpu_perf_canAcceptLoadThenLoad_T_40;	// Consts.scala:81:65, :82:{32,49,76}, package.scala:15:47
  reg              s1_flush_valid;	// DCache.scala:193:27
  reg              cached_grant_wait;	// DCache.scala:201:30
  reg              resetting;	// DCache.scala:202:26
  reg  [5:0]       flushCounter;	// DCache.scala:203:25
  reg              release_ack_wait;	// DCache.scala:204:29
  reg              release_ack_dirty;	// DCache.scala:205:30
  reg  [31:0]      release_ack_addr;	// DCache.scala:206:29
  reg  [3:0]       release_state;	// DCache.scala:207:26
  wire             _canAcceptCachedGrant_T = release_state == 4'h1;	// DCache.scala:207:26, package.scala:15:47
  wire             _inWriteback_T_1 = release_state == 4'h2;	// DCache.scala:207:26, package.scala:15:47
  wire             inWriteback = _canAcceptCachedGrant_T | _inWriteback_T_1;	// package.scala:15:47, :72:59
  wire             _io_cpu_req_ready_T_4 =
    release_state == 4'h0 & ~cached_grant_wait & ~s1_nack;	// DCache.scala:167:41, :201:30, :207:26, :212:{38,54,73}, :543:36, :806:21, :821:24
  reg              uncachedInFlight_0;	// DCache.scala:215:33
  reg  [33:0]      uncachedReqs_0_addr;	// DCache.scala:216:25
  reg  [5:0]       uncachedReqs_0_tag;	// DCache.scala:216:25
  reg  [1:0]       uncachedReqs_0_size;	// DCache.scala:216:25
  reg              uncachedReqs_0_signed;	// DCache.scala:216:25
  wire             _pstore_drain_opportunistic_T = io_cpu_req_bits_cmd == 5'h0;	// Consts.scala:81:31
  wire             _pstore_drain_opportunistic_T_1 = io_cpu_req_bits_cmd == 5'h6;	// Consts.scala:81:48
  wire             _pstore_drain_opportunistic_T_26 = io_cpu_req_bits_cmd == 5'h7;	// Consts.scala:81:65
  wire             _pstore_drain_opportunistic_T_28 = io_cpu_req_bits_cmd == 5'h4;	// package.scala:15:47
  wire             _pstore_drain_opportunistic_T_29 = io_cpu_req_bits_cmd == 5'h9;	// package.scala:15:47
  wire             _pstore_drain_opportunistic_T_30 = io_cpu_req_bits_cmd == 5'hA;	// package.scala:15:47
  wire             _pstore_drain_opportunistic_T_31 = io_cpu_req_bits_cmd == 5'hB;	// package.scala:15:47
  wire             _pstore_drain_opportunistic_T_35 = io_cpu_req_bits_cmd == 5'h8;	// package.scala:15:47
  wire             _pstore_drain_opportunistic_T_36 = io_cpu_req_bits_cmd == 5'hC;	// package.scala:15:47
  wire             _pstore_drain_opportunistic_T_37 = io_cpu_req_bits_cmd == 5'hD;	// package.scala:15:47
  wire             _pstore_drain_opportunistic_T_38 = io_cpu_req_bits_cmd == 5'hE;	// package.scala:15:47
  wire             _pstore_drain_opportunistic_T_39 = io_cpu_req_bits_cmd == 5'hF;	// package.scala:15:47
  wire             _pstore_drain_opportunistic_T_23 = io_cpu_req_bits_cmd == 5'h1;	// Consts.scala:82:32, package.scala:15:47
  wire             _pstore_drain_opportunistic_res_T_1 = io_cpu_req_bits_cmd == 5'h3;	// package.scala:15:47
  wire             _dataArb_io_in_3_valid_res_T_2 =
    _pstore_drain_opportunistic_T_23 | _pstore_drain_opportunistic_res_T_1;	// package.scala:15:47, :72:59
  wire             _pstore_drain_opportunistic_T_48 = io_cpu_req_bits_cmd == 5'h11;	// Consts.scala:82:49
  reg              s1_did_read;	// Reg.scala:15:16
  reg              s1_read_mask;	// Reg.scala:15:16
  wire             _GEN =
    ~_tlb_io_req_ready & ~io_ptw_resp_valid | ~_metaArb_io_in_7_ready
    | ~_dataArb_io_in_3_ready
    & (_pstore_drain_opportunistic_T | _pstore_drain_opportunistic_T_1
       | _pstore_drain_opportunistic_T_26 | _pstore_drain_opportunistic_T_28
       | _pstore_drain_opportunistic_T_29 | _pstore_drain_opportunistic_T_30
       | _pstore_drain_opportunistic_T_31 | _pstore_drain_opportunistic_T_35
       | _pstore_drain_opportunistic_T_36 | _pstore_drain_opportunistic_T_37
       | _pstore_drain_opportunistic_T_38 | _pstore_drain_opportunistic_T_39);	// Consts.scala:81:{31,48,65,75}, DCache.scala:117:19, :122:23, :133:23, :175:9, :212:20, :237:{9,33,45,64}, :246:{34,53}, :254:{9,27,30,79,98}, package.scala:15:47
  assign writeEnable = _metaArb_io_out_valid & _metaArb_io_out_bits_write;	// DCache.scala:122:23, :282:27
  assign readEnable = _metaArb_io_out_valid & ~_metaArb_io_out_bits_write;	// DCache.scala:122:23, :170:43, :286:59
  wire [1:0]       _s1_mask_xwr_T = {s1_vaddr[0] | (|s1_req_size), ~(s1_vaddr[0])};	// AMOALU.scala:17:{27,46,57}, :18:22, Cat.scala:30:58, DCache.scala:109:25, :136:24, Reg.scala:15:16
  wire [3:0]       _s1_mask_xwr_T_1 =
    {(s1_vaddr[1] ? _s1_mask_xwr_T : 2'h0) | {2{s1_req_size[1]}},
     s1_vaddr[1] ? 2'h0 : _s1_mask_xwr_T};	// AMOALU.scala:17:{22,27,46,51,57}, :18:22, Cat.scala:30:58, DCache.scala:117:19, :118:27, Reg.scala:15:16
  wire [7:0]       s1_mask_xwr =
    {(s1_vaddr[2] ? _s1_mask_xwr_T_1 : 4'h0) | {4{&s1_req_size}},
     s1_vaddr[2] ? 4'h0 : _s1_mask_xwr_T_1};	// AMOALU.scala:17:{22,27,46,51,57}, :18:22, Cat.scala:30:58, Reg.scala:15:16
  reg              s2_valid;	// DCache.scala:303:21
  wire             s2_valid_no_xcpt =
    s2_valid
    & {_io_cpu_s2_xcpt_ma_ld_output,
       _io_cpu_s2_xcpt_ma_st_output,
       _io_cpu_s2_xcpt_pf_ld_output,
       _io_cpu_s2_xcpt_pf_st_output,
       _io_cpu_s2_xcpt_ae_ld_output,
       _io_cpu_s2_xcpt_ae_st_output} == 6'h0;	// DCache.scala:303:21, :304:{35,54,61}, :903:24
  reg              s2_probe;	// DCache.scala:305:21
  wire             releaseInFlight = s1_probe | s2_probe | (|release_state);	// DCache.scala:163:21, :207:26, :305:21, :306:{46,63}
  reg              s2_not_nacked_in_s1;	// DCache.scala:307:36
  wire             s2_valid_masked = s2_valid_no_xcpt & s2_not_nacked_in_s1;	// DCache.scala:304:35, :307:36, :309:42
  reg  [33:0]      s2_req_addr;	// DCache.scala:311:19
  reg  [5:0]       s2_req_tag;	// DCache.scala:311:19
  reg  [4:0]       s2_req_cmd;	// DCache.scala:311:19
  reg  [1:0]       size;	// DCache.scala:311:19
  reg              s2_req_signed;	// DCache.scala:311:19
  reg              s2_req_no_alloc;	// DCache.scala:311:19
  reg              s2_req_no_xcpt;	// DCache.scala:311:19
  reg              s2_tlb_xcpt_pf_ld;	// DCache.scala:314:24
  reg              s2_tlb_xcpt_pf_st;	// DCache.scala:314:24
  reg              s2_tlb_xcpt_ae_ld;	// DCache.scala:314:24
  reg              s2_tlb_xcpt_ae_st;	// DCache.scala:314:24
  reg              s2_tlb_xcpt_ma_ld;	// DCache.scala:314:24
  reg              s2_tlb_xcpt_ma_st;	// DCache.scala:314:24
  reg              s2_pma_cacheable;	// DCache.scala:315:19
  reg              s2_pma_must_alloc;	// DCache.scala:315:19
  reg  [33:0]      s2_vaddr_r;	// Reg.scala:15:16
  wire             s2_lr = s2_req_cmd == 5'h6;	// Consts.scala:81:48, DCache.scala:311:19
  wire             s2_sc = s2_req_cmd == 5'h7;	// Consts.scala:81:65, DCache.scala:311:19
  wire             _metaArb_io_in_3_bits_data_c_cat_T_27 = s2_req_cmd == 5'h4;	// DCache.scala:311:19, package.scala:15:47
  wire             _metaArb_io_in_3_bits_data_c_cat_T_28 = s2_req_cmd == 5'h9;	// DCache.scala:311:19, package.scala:15:47
  wire             _metaArb_io_in_3_bits_data_c_cat_T_29 = s2_req_cmd == 5'hA;	// DCache.scala:311:19, package.scala:15:47
  wire             _metaArb_io_in_3_bits_data_c_cat_T_30 = s2_req_cmd == 5'hB;	// DCache.scala:311:19, package.scala:15:47
  wire             _metaArb_io_in_3_bits_data_c_cat_T_34 = s2_req_cmd == 5'h8;	// DCache.scala:311:19, package.scala:15:47
  wire             _metaArb_io_in_3_bits_data_c_cat_T_35 = s2_req_cmd == 5'hC;	// DCache.scala:311:19, package.scala:15:47
  wire             _metaArb_io_in_3_bits_data_c_cat_T_36 = s2_req_cmd == 5'hD;	// DCache.scala:311:19, package.scala:15:47
  wire             _metaArb_io_in_3_bits_data_c_cat_T_37 = s2_req_cmd == 5'hE;	// DCache.scala:311:19, package.scala:15:47
  wire             _metaArb_io_in_3_bits_data_c_cat_T_38 = s2_req_cmd == 5'hF;	// DCache.scala:311:19, package.scala:15:47
  wire             s2_read =
    s2_req_cmd == 5'h0 | s2_lr | s2_sc | _metaArb_io_in_3_bits_data_c_cat_T_27
    | _metaArb_io_in_3_bits_data_c_cat_T_28 | _metaArb_io_in_3_bits_data_c_cat_T_29
    | _metaArb_io_in_3_bits_data_c_cat_T_30 | _metaArb_io_in_3_bits_data_c_cat_T_34
    | _metaArb_io_in_3_bits_data_c_cat_T_35 | _metaArb_io_in_3_bits_data_c_cat_T_36
    | _metaArb_io_in_3_bits_data_c_cat_T_37 | _metaArb_io_in_3_bits_data_c_cat_T_38;	// Consts.scala:81:{31,48,65,75}, DCache.scala:311:19, package.scala:15:47
  wire             _metaArb_io_in_3_bits_data_c_cat_T_22 = s2_req_cmd == 5'h1;	// Consts.scala:82:32, DCache.scala:311:19
  wire             _metaArb_io_in_3_bits_data_c_cat_T_23 = s2_req_cmd == 5'h11;	// Consts.scala:82:49, DCache.scala:311:19
  wire             s2_write =
    _metaArb_io_in_3_bits_data_c_cat_T_22 | _metaArb_io_in_3_bits_data_c_cat_T_23 | s2_sc
    | _metaArb_io_in_3_bits_data_c_cat_T_27 | _metaArb_io_in_3_bits_data_c_cat_T_28
    | _metaArb_io_in_3_bits_data_c_cat_T_29 | _metaArb_io_in_3_bits_data_c_cat_T_30
    | _metaArb_io_in_3_bits_data_c_cat_T_34 | _metaArb_io_in_3_bits_data_c_cat_T_35
    | _metaArb_io_in_3_bits_data_c_cat_T_36 | _metaArb_io_in_3_bits_data_c_cat_T_37
    | _metaArb_io_in_3_bits_data_c_cat_T_38;	// Consts.scala:81:65, :82:{32,49,76}, package.scala:15:47
  wire             s2_readwrite = s2_read | s2_write;	// Consts.scala:81:75, :82:76, DCache.scala:326:30
  reg              s2_flush_valid_pre_tag_ecc;	// DCache.scala:327:43
  reg              s2_meta_correctable_errors;	// Reg.scala:15:16
  reg              s2_meta_error_uncorrectable;	// Reg.scala:15:16
  reg  [21:0]      s2_meta_corrected_r;	// Reg.scala:15:16
  wire             s2_meta_error =
    s2_meta_error_uncorrectable | s2_meta_correctable_errors;	// DCache.scala:334:53, Reg.scala:15:16
  wire             s2_flush_valid = s2_flush_valid_pre_tag_ecc & ~s2_meta_error;	// DCache.scala:327:43, :334:53, :335:{51,54}
  reg  [63:0]      s2_data;	// Reg.scala:15:16
  reg  [1:0]       s2_probe_state_state;	// Reg.scala:15:16
  reg  [1:0]       s2_hit_state_state;	// Reg.scala:15:16
  reg              s2_waw_hazard;	// Reg.scala:15:16
  wire             _metaArb_io_in_3_bits_data_c_cat_T_45 = s2_req_cmd == 5'h3;	// Consts.scala:83:54, DCache.scala:311:19, package.scala:15:47
  wire [3:0]       _GEN_0 =
    {_metaArb_io_in_3_bits_data_c_cat_T_22 | _metaArb_io_in_3_bits_data_c_cat_T_23 | s2_sc
       | _metaArb_io_in_3_bits_data_c_cat_T_27 | _metaArb_io_in_3_bits_data_c_cat_T_28
       | _metaArb_io_in_3_bits_data_c_cat_T_29 | _metaArb_io_in_3_bits_data_c_cat_T_30
       | _metaArb_io_in_3_bits_data_c_cat_T_34 | _metaArb_io_in_3_bits_data_c_cat_T_35
       | _metaArb_io_in_3_bits_data_c_cat_T_36 | _metaArb_io_in_3_bits_data_c_cat_T_37
       | _metaArb_io_in_3_bits_data_c_cat_T_38,
     _metaArb_io_in_3_bits_data_c_cat_T_22 | _metaArb_io_in_3_bits_data_c_cat_T_23 | s2_sc
       | _metaArb_io_in_3_bits_data_c_cat_T_27 | _metaArb_io_in_3_bits_data_c_cat_T_28
       | _metaArb_io_in_3_bits_data_c_cat_T_29 | _metaArb_io_in_3_bits_data_c_cat_T_30
       | _metaArb_io_in_3_bits_data_c_cat_T_34 | _metaArb_io_in_3_bits_data_c_cat_T_35
       | _metaArb_io_in_3_bits_data_c_cat_T_36 | _metaArb_io_in_3_bits_data_c_cat_T_37
       | _metaArb_io_in_3_bits_data_c_cat_T_38 | _metaArb_io_in_3_bits_data_c_cat_T_45
       | s2_lr,
     s2_hit_state_state};	// Cat.scala:30:58, Consts.scala:81:{48,65}, :82:{32,49,76}, :83:{54,64}, Reg.scala:15:16, package.scala:15:47
  wire [1:0]       _GEN_1 = {1'h0, _GEN_0 == 4'hC};	// Cat.scala:30:58, DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, Decoupled.scala:40:37, Misc.scala:34:36, :48:20, PRNG.scala:82:22, package.scala:15:47
  wire             s2_hit =
    _GEN_0 == 4'h3 | _GEN_0 == 4'h2 | _GEN_0 == 4'h1 | _GEN_0 == 4'h7 | _GEN_0 == 4'h6
    | (&_GEN_0) | _GEN_0 == 4'hE;	// Cat.scala:30:58, DCache.scala:815:29, Misc.scala:34:9, :48:20, package.scala:15:47
  wire [15:0][1:0] _GEN_2 =
    {{2'h3},
     {2'h3},
     {2'h2},
     {_GEN_1},
     {_GEN_1},
     {_GEN_1},
     {_GEN_1},
     {_GEN_1},
     {2'h3},
     {2'h2},
     {2'h2},
     {2'h1},
     {2'h3},
     {2'h2},
     {2'h1},
     {2'h0}};	// AMOALU.scala:17:57, Cat.scala:30:58, DCache.scala:117:19, :118:27, Misc.scala:34:36, :48:20, package.scala:15:47
  wire             s2_valid_hit_maybe_flush_pre_data_ecc_and_waw =
    s2_valid_masked & ~s2_meta_error & s2_hit;	// DCache.scala:309:42, :334:53, :335:54, :369:89, Misc.scala:34:9
  wire             s2_valid_hit_pre_data_ecc_and_waw =
    s2_valid_hit_maybe_flush_pre_data_ecc_and_waw & s2_readwrite;	// DCache.scala:326:30, :369:89, :390:89
  wire             s2_valid_flush_line =
    s2_valid_hit_maybe_flush_pre_data_ecc_and_waw & s2_req_cmd == 5'h5 & size[0];	// DCache.scala:192:34, :311:19, :312:{37,68}, :369:89, :391:75
  wire             s2_valid_hit = s2_valid_hit_pre_data_ecc_and_waw & ~s2_waw_hazard;	// DCache.scala:390:89, :392:{69,73}, Reg.scala:15:16
  wire             s2_valid_miss =
    s2_valid_masked & s2_readwrite & ~s2_meta_error & ~s2_hit;	// DCache.scala:309:42, :326:30, :334:53, :335:54, :395:{73,76}, Misc.scala:34:9
  wire             s2_uncached =
    ~s2_pma_cacheable | s2_req_no_alloc & ~s2_pma_must_alloc & ~(|s2_hit_state_state);	// DCache.scala:311:19, :315:19, :396:{21,39,61,80,83}, Metadata.scala:49:45, Reg.scala:15:16
  wire             s2_valid_cached_miss =
    s2_valid_miss & ~s2_uncached & ~uncachedInFlight_0;	// DCache.scala:215:33, :395:73, :396:39, :397:{47,60,63}
  wire             s2_want_victimize =
    s2_valid_cached_miss | s2_valid_flush_line | s2_flush_valid;	// DCache.scala:335:51, :391:75, :397:60, :399:125
  wire             s2_valid_uncached_pending =
    s2_valid_miss & s2_uncached & ~uncachedInFlight_0;	// DCache.scala:215:33, :395:73, :396:39, :402:{64,67}
  wire [1:0]       s2_victim_state_state =
    (|s2_hit_state_state) ? s2_hit_state_state : s2_meta_corrected_r[21:20];	// DCache.scala:333:99, :406:28, Metadata.scala:49:45, Reg.scala:15:16
  wire [3:0]       _GEN_3 = {probe_bits_param, s2_probe_state_state};	// Cat.scala:30:58, Reg.scala:15:16
  wire             _GEN_4 = _GEN_3 == 4'hB;	// Cat.scala:30:58, Misc.scala:55:20, package.scala:15:47
  wire             _GEN_5 = _GEN_3 == 4'h4;	// Cat.scala:30:58, DCache.scala:809:23, Misc.scala:55:20
  wire             _GEN_6 = _GEN_3 == 4'h5;	// Cat.scala:30:58, DCache.scala:819:29, Misc.scala:55:20
  wire             _GEN_7 = _GEN_3 == 4'h6;	// Cat.scala:30:58, Misc.scala:55:20, package.scala:15:47
  wire             _GEN_8 = _GEN_3 == 4'h7;	// Cat.scala:30:58, DCache.scala:815:29, Misc.scala:55:20
  wire             _GEN_9 = _GEN_3 == 4'h0;	// Cat.scala:30:58, Misc.scala:55:20
  wire             _GEN_10 = _GEN_3 == 4'h1;	// Cat.scala:30:58, Misc.scala:55:20, package.scala:15:47
  wire             _GEN_11 = _GEN_3 == 4'h2;	// Cat.scala:30:58, Misc.scala:55:20, package.scala:15:47
  wire             _GEN_12 = _GEN_3 == 4'h3;	// Cat.scala:30:58, DCache.scala:815:29, Misc.scala:55:20
  wire             s2_prb_ack_data =
    _GEN_12 | ~(_GEN_11 | _GEN_10 | _GEN_9)
    & (_GEN_8 | ~(_GEN_7 | _GEN_6 | _GEN_5) & _GEN_4);	// Misc.scala:37:9, :55:20
  wire             _GEN_13 = _GEN_12 | _GEN_11;	// Misc.scala:37:36, :55:20
  wire             _io_cpu_s2_nack_output =
    s2_valid_no_xcpt & ~(s2_valid_uncached_pending & auto_out_a_ready)
    & ~(s2_valid_masked & ~s2_meta_error & s2_req_cmd == 5'h17) & ~s2_valid_hit;	// DCache.scala:249:69, :304:35, :309:42, :311:19, :334:53, :335:54, :392:69, :402:64, :412:57, :413:61, :416:17, :417:{41,67,86,89}
  wire             _metaArb_io_in_2_valid_T =
    s2_valid_hit_pre_data_ecc_and_waw & s2_hit_state_state != _GEN_2[_GEN_0];	// Cat.scala:30:58, DCache.scala:390:89, :418:62, Metadata.scala:45:46, Misc.scala:34:36, :48:20, Reg.scala:15:16
  wire [5:0]       _metaArb_io_in_1_bits_idx_T_2 =
    s2_probe ? probe_bits_address[11:6] : s2_req_addr[11:6];	// DCache.scala:305:21, :311:19, :425:{35,76}, :1170:47, Reg.scala:15:16
  reg  [6:0]       lrscCount;	// DCache.scala:444:22
  reg  [27:0]      lrscAddr;	// DCache.scala:447:21
  wire             s2_sc_fail =
    s2_sc & ~((|(lrscCount[6:2])) & lrscAddr == s2_req_addr[33:6]);	// Consts.scala:81:65, DCache.scala:311:19, :444:22, :445:29, :447:21, :448:{32,49}, :449:{26,29,41}
  reg  [4:0]       pstore1_cmd;	// Reg.scala:15:16
  reg  [33:0]      pstore1_addr;	// Reg.scala:15:16
  reg  [63:0]      pstore1_data;	// Reg.scala:15:16
  reg  [7:0]       pstore1_mask;	// Reg.scala:15:16
  reg              pstore1_rmw;	// Reg.scala:15:16
  wire             _pstore1_held_T = s2_valid_hit & s2_write;	// Consts.scala:82:76, DCache.scala:392:69, :462:46
  reg              pstore2_valid;	// DCache.scala:473:30
  wire             _pstore_drain_opportunistic_res_T_2 =
    _pstore_drain_opportunistic_T_23 | _pstore_drain_opportunistic_res_T_1;	// package.scala:15:47, :72:59
  reg              pstore_drain_on_miss_REG;	// DCache.scala:475:56
  reg              pstore1_held;	// DCache.scala:476:29
  wire             pstore1_valid_likely = s2_valid & s2_write | pstore1_held;	// Consts.scala:82:76, DCache.scala:303:21, :476:29, :477:{39,51}
  wire             pstore1_valid = _pstore1_held_T & ~s2_sc_fail | pstore1_held;	// DCache.scala:449:26, :462:{46,58,61}, :476:29, :479:38
  wire             pstore_drain_structural =
    pstore1_valid_likely & pstore2_valid & (s1_valid & s1_write | pstore1_rmw);	// Consts.scala:82:76, DCache.scala:162:21, :473:30, :477:51, :481:{71,85,98}, Reg.scala:15:16
  wire             _dataArb_io_in_0_valid_T_4 = s2_valid_hit & s2_write;	// Consts.scala:82:76, DCache.scala:392:69, :478:72
  wire             _dataArb_io_in_0_valid_T_9 =
    ~(io_cpu_req_valid & ~_pstore_drain_opportunistic_res_T_2) | releaseInFlight
    | pstore_drain_on_miss_REG;	// DCache.scala:306:46, :474:{36,55}, :475:56, :490:107, :1155:15, package.scala:72:59
  wire             _pstore_drain_T_11 =
    pstore_drain_structural
    | ((_dataArb_io_in_0_valid_T_4 | pstore1_held) & ~pstore1_rmw | pstore2_valid)
    & _dataArb_io_in_0_valid_T_9;	// DCache.scala:473:30, :476:29, :478:{72,96}, :481:71, :489:48, :490:{41,44,58,76,107}, Reg.scala:15:16
  reg  [33:0]      pstore2_addr;	// Reg.scala:15:16
  reg  [7:0]       pstore2_storegen_data_lo_lo_lo;	// Reg.scala:15:16
  reg  [7:0]       pstore2_storegen_data_lo_lo_hi;	// Reg.scala:15:16
  reg  [7:0]       pstore2_storegen_data_lo_hi_lo;	// Reg.scala:15:16
  reg  [7:0]       pstore2_storegen_data_lo_hi_hi;	// Reg.scala:15:16
  reg  [7:0]       pstore2_storegen_data_hi_lo_lo;	// Reg.scala:15:16
  reg  [7:0]       pstore2_storegen_data_hi_lo_hi;	// Reg.scala:15:16
  reg  [7:0]       pstore2_storegen_data_hi_hi_lo;	// Reg.scala:15:16
  reg  [7:0]       pstore2_storegen_data_hi_hi_hi;	// Reg.scala:15:16
  reg  [7:0]       mask;	// DCache.scala:503:19
  wire             get_a_mask_size = size == 2'h2;	// AMOALU.scala:17:57, DCache.scala:311:19, Misc.scala:208:26
  wire             get_a_mask_acc = (&size) | get_a_mask_size & ~(s2_req_addr[2]);	// DCache.scala:311:19, Misc.scala:205:21, :208:26, :209:26, :210:20, :214:{29,38}
  wire             get_a_mask_acc_1 = (&size) | get_a_mask_size & s2_req_addr[2];	// DCache.scala:311:19, Misc.scala:205:21, :208:26, :209:26, :214:{29,38}
  wire             get_a_mask_size_1 = size == 2'h1;	// Cat.scala:30:58, DCache.scala:311:19, Misc.scala:208:26
  wire             get_a_mask_eq_2 = ~(s2_req_addr[2]) & ~(s2_req_addr[1]);	// DCache.scala:311:19, Misc.scala:209:26, :210:20, :213:27
  wire             get_a_mask_acc_2 =
    get_a_mask_acc | get_a_mask_size_1 & get_a_mask_eq_2;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             get_a_mask_eq_3 = ~(s2_req_addr[2]) & s2_req_addr[1];	// DCache.scala:311:19, Misc.scala:209:26, :210:20, :213:27
  wire             get_a_mask_acc_3 =
    get_a_mask_acc | get_a_mask_size_1 & get_a_mask_eq_3;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             get_a_mask_eq_4 = s2_req_addr[2] & ~(s2_req_addr[1]);	// DCache.scala:311:19, Misc.scala:209:26, :210:20, :213:27
  wire             get_a_mask_acc_4 =
    get_a_mask_acc_1 | get_a_mask_size_1 & get_a_mask_eq_4;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             get_a_mask_eq_5 = s2_req_addr[2] & s2_req_addr[1];	// DCache.scala:311:19, Misc.scala:209:26, :213:27
  wire             get_a_mask_acc_5 =
    get_a_mask_acc_1 | get_a_mask_size_1 & get_a_mask_eq_5;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             put_a_mask_size = size == 2'h2;	// AMOALU.scala:17:57, DCache.scala:311:19, Misc.scala:208:26
  wire             put_a_mask_acc = (&size) | put_a_mask_size & ~(s2_req_addr[2]);	// DCache.scala:311:19, Misc.scala:205:21, :208:26, :209:26, :210:20, :214:{29,38}
  wire             put_a_mask_acc_1 = (&size) | put_a_mask_size & s2_req_addr[2];	// DCache.scala:311:19, Misc.scala:205:21, :208:26, :209:26, :214:{29,38}
  wire             put_a_mask_size_1 = size == 2'h1;	// Cat.scala:30:58, DCache.scala:311:19, Misc.scala:208:26
  wire             put_a_mask_eq_2 = ~(s2_req_addr[2]) & ~(s2_req_addr[1]);	// DCache.scala:311:19, Misc.scala:209:26, :210:20, :213:27
  wire             put_a_mask_acc_2 =
    put_a_mask_acc | put_a_mask_size_1 & put_a_mask_eq_2;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             put_a_mask_eq_3 = ~(s2_req_addr[2]) & s2_req_addr[1];	// DCache.scala:311:19, Misc.scala:209:26, :210:20, :213:27
  wire             put_a_mask_acc_3 =
    put_a_mask_acc | put_a_mask_size_1 & put_a_mask_eq_3;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             put_a_mask_eq_4 = s2_req_addr[2] & ~(s2_req_addr[1]);	// DCache.scala:311:19, Misc.scala:209:26, :210:20, :213:27
  wire             put_a_mask_acc_4 =
    put_a_mask_acc_1 | put_a_mask_size_1 & put_a_mask_eq_4;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             put_a_mask_eq_5 = s2_req_addr[2] & s2_req_addr[1];	// DCache.scala:311:19, Misc.scala:209:26, :213:27
  wire             put_a_mask_acc_5 =
    put_a_mask_acc_1 | put_a_mask_size_1 & put_a_mask_eq_5;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             atomics_a_mask_size = size == 2'h2;	// AMOALU.scala:17:57, DCache.scala:311:19, Misc.scala:208:26
  wire             atomics_a_mask_acc = (&size) | atomics_a_mask_size & ~(s2_req_addr[2]);	// DCache.scala:311:19, Misc.scala:205:21, :208:26, :209:26, :210:20, :214:{29,38}
  wire             atomics_a_mask_acc_1 = (&size) | atomics_a_mask_size & s2_req_addr[2];	// DCache.scala:311:19, Misc.scala:205:21, :208:26, :209:26, :214:{29,38}
  wire             atomics_a_mask_size_1 = size == 2'h1;	// Cat.scala:30:58, DCache.scala:311:19, Misc.scala:208:26
  wire             atomics_a_mask_eq_2 = ~(s2_req_addr[2]) & ~(s2_req_addr[1]);	// DCache.scala:311:19, Misc.scala:209:26, :210:20, :213:27
  wire             atomics_a_mask_acc_2 =
    atomics_a_mask_acc | atomics_a_mask_size_1 & atomics_a_mask_eq_2;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             atomics_a_mask_eq_3 = ~(s2_req_addr[2]) & s2_req_addr[1];	// DCache.scala:311:19, Misc.scala:209:26, :210:20, :213:27
  wire             atomics_a_mask_acc_3 =
    atomics_a_mask_acc | atomics_a_mask_size_1 & atomics_a_mask_eq_3;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             atomics_a_mask_eq_4 = s2_req_addr[2] & ~(s2_req_addr[1]);	// DCache.scala:311:19, Misc.scala:209:26, :210:20, :213:27
  wire             atomics_a_mask_acc_4 =
    atomics_a_mask_acc_1 | atomics_a_mask_size_1 & atomics_a_mask_eq_4;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             atomics_a_mask_eq_5 = s2_req_addr[2] & s2_req_addr[1];	// DCache.scala:311:19, Misc.scala:209:26, :213:27
  wire             atomics_a_mask_acc_5 =
    atomics_a_mask_acc_1 | atomics_a_mask_size_1 & atomics_a_mask_eq_5;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             atomics_a_mask_size_3 = size == 2'h2;	// AMOALU.scala:17:57, DCache.scala:311:19, Misc.scala:208:26
  wire             atomics_a_mask_acc_6 =
    (&size) | atomics_a_mask_size_3 & ~(s2_req_addr[2]);	// DCache.scala:311:19, Misc.scala:205:21, :208:26, :209:26, :210:20, :214:{29,38}
  wire             atomics_a_mask_acc_7 =
    (&size) | atomics_a_mask_size_3 & s2_req_addr[2];	// DCache.scala:311:19, Misc.scala:205:21, :208:26, :209:26, :214:{29,38}
  wire             atomics_a_mask_size_4 = size == 2'h1;	// Cat.scala:30:58, DCache.scala:311:19, Misc.scala:208:26
  wire             atomics_a_mask_eq_16 = ~(s2_req_addr[2]) & ~(s2_req_addr[1]);	// DCache.scala:311:19, Misc.scala:209:26, :210:20, :213:27
  wire             atomics_a_mask_acc_8 =
    atomics_a_mask_acc_6 | atomics_a_mask_size_4 & atomics_a_mask_eq_16;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             atomics_a_mask_eq_17 = ~(s2_req_addr[2]) & s2_req_addr[1];	// DCache.scala:311:19, Misc.scala:209:26, :210:20, :213:27
  wire             atomics_a_mask_acc_9 =
    atomics_a_mask_acc_6 | atomics_a_mask_size_4 & atomics_a_mask_eq_17;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             atomics_a_mask_eq_18 = s2_req_addr[2] & ~(s2_req_addr[1]);	// DCache.scala:311:19, Misc.scala:209:26, :210:20, :213:27
  wire             atomics_a_mask_acc_10 =
    atomics_a_mask_acc_7 | atomics_a_mask_size_4 & atomics_a_mask_eq_18;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             atomics_a_mask_eq_19 = s2_req_addr[2] & s2_req_addr[1];	// DCache.scala:311:19, Misc.scala:209:26, :213:27
  wire             atomics_a_mask_acc_11 =
    atomics_a_mask_acc_7 | atomics_a_mask_size_4 & atomics_a_mask_eq_19;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             atomics_a_mask_size_6 = size == 2'h2;	// AMOALU.scala:17:57, DCache.scala:311:19, Misc.scala:208:26
  wire             atomics_a_mask_acc_12 =
    (&size) | atomics_a_mask_size_6 & ~(s2_req_addr[2]);	// DCache.scala:311:19, Misc.scala:205:21, :208:26, :209:26, :210:20, :214:{29,38}
  wire             atomics_a_mask_acc_13 =
    (&size) | atomics_a_mask_size_6 & s2_req_addr[2];	// DCache.scala:311:19, Misc.scala:205:21, :208:26, :209:26, :214:{29,38}
  wire             atomics_a_mask_size_7 = size == 2'h1;	// Cat.scala:30:58, DCache.scala:311:19, Misc.scala:208:26
  wire             atomics_a_mask_eq_30 = ~(s2_req_addr[2]) & ~(s2_req_addr[1]);	// DCache.scala:311:19, Misc.scala:209:26, :210:20, :213:27
  wire             atomics_a_mask_acc_14 =
    atomics_a_mask_acc_12 | atomics_a_mask_size_7 & atomics_a_mask_eq_30;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             atomics_a_mask_eq_31 = ~(s2_req_addr[2]) & s2_req_addr[1];	// DCache.scala:311:19, Misc.scala:209:26, :210:20, :213:27
  wire             atomics_a_mask_acc_15 =
    atomics_a_mask_acc_12 | atomics_a_mask_size_7 & atomics_a_mask_eq_31;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             atomics_a_mask_eq_32 = s2_req_addr[2] & ~(s2_req_addr[1]);	// DCache.scala:311:19, Misc.scala:209:26, :210:20, :213:27
  wire             atomics_a_mask_acc_16 =
    atomics_a_mask_acc_13 | atomics_a_mask_size_7 & atomics_a_mask_eq_32;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             atomics_a_mask_eq_33 = s2_req_addr[2] & s2_req_addr[1];	// DCache.scala:311:19, Misc.scala:209:26, :213:27
  wire             atomics_a_mask_acc_17 =
    atomics_a_mask_acc_13 | atomics_a_mask_size_7 & atomics_a_mask_eq_33;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             atomics_a_mask_size_9 = size == 2'h2;	// AMOALU.scala:17:57, DCache.scala:311:19, Misc.scala:208:26
  wire             atomics_a_mask_acc_18 =
    (&size) | atomics_a_mask_size_9 & ~(s2_req_addr[2]);	// DCache.scala:311:19, Misc.scala:205:21, :208:26, :209:26, :210:20, :214:{29,38}
  wire             atomics_a_mask_acc_19 =
    (&size) | atomics_a_mask_size_9 & s2_req_addr[2];	// DCache.scala:311:19, Misc.scala:205:21, :208:26, :209:26, :214:{29,38}
  wire             atomics_a_mask_size_10 = size == 2'h1;	// Cat.scala:30:58, DCache.scala:311:19, Misc.scala:208:26
  wire             atomics_a_mask_eq_44 = ~(s2_req_addr[2]) & ~(s2_req_addr[1]);	// DCache.scala:311:19, Misc.scala:209:26, :210:20, :213:27
  wire             atomics_a_mask_acc_20 =
    atomics_a_mask_acc_18 | atomics_a_mask_size_10 & atomics_a_mask_eq_44;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             atomics_a_mask_eq_45 = ~(s2_req_addr[2]) & s2_req_addr[1];	// DCache.scala:311:19, Misc.scala:209:26, :210:20, :213:27
  wire             atomics_a_mask_acc_21 =
    atomics_a_mask_acc_18 | atomics_a_mask_size_10 & atomics_a_mask_eq_45;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             atomics_a_mask_eq_46 = s2_req_addr[2] & ~(s2_req_addr[1]);	// DCache.scala:311:19, Misc.scala:209:26, :210:20, :213:27
  wire             atomics_a_mask_acc_22 =
    atomics_a_mask_acc_19 | atomics_a_mask_size_10 & atomics_a_mask_eq_46;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             atomics_a_mask_eq_47 = s2_req_addr[2] & s2_req_addr[1];	// DCache.scala:311:19, Misc.scala:209:26, :213:27
  wire             atomics_a_mask_acc_23 =
    atomics_a_mask_acc_19 | atomics_a_mask_size_10 & atomics_a_mask_eq_47;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             atomics_a_mask_size_12 = size == 2'h2;	// AMOALU.scala:17:57, DCache.scala:311:19, Misc.scala:208:26
  wire             atomics_a_mask_acc_24 =
    (&size) | atomics_a_mask_size_12 & ~(s2_req_addr[2]);	// DCache.scala:311:19, Misc.scala:205:21, :208:26, :209:26, :210:20, :214:{29,38}
  wire             atomics_a_mask_acc_25 =
    (&size) | atomics_a_mask_size_12 & s2_req_addr[2];	// DCache.scala:311:19, Misc.scala:205:21, :208:26, :209:26, :214:{29,38}
  wire             atomics_a_mask_size_13 = size == 2'h1;	// Cat.scala:30:58, DCache.scala:311:19, Misc.scala:208:26
  wire             atomics_a_mask_eq_58 = ~(s2_req_addr[2]) & ~(s2_req_addr[1]);	// DCache.scala:311:19, Misc.scala:209:26, :210:20, :213:27
  wire             atomics_a_mask_acc_26 =
    atomics_a_mask_acc_24 | atomics_a_mask_size_13 & atomics_a_mask_eq_58;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             atomics_a_mask_eq_59 = ~(s2_req_addr[2]) & s2_req_addr[1];	// DCache.scala:311:19, Misc.scala:209:26, :210:20, :213:27
  wire             atomics_a_mask_acc_27 =
    atomics_a_mask_acc_24 | atomics_a_mask_size_13 & atomics_a_mask_eq_59;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             atomics_a_mask_eq_60 = s2_req_addr[2] & ~(s2_req_addr[1]);	// DCache.scala:311:19, Misc.scala:209:26, :210:20, :213:27
  wire             atomics_a_mask_acc_28 =
    atomics_a_mask_acc_25 | atomics_a_mask_size_13 & atomics_a_mask_eq_60;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             atomics_a_mask_eq_61 = s2_req_addr[2] & s2_req_addr[1];	// DCache.scala:311:19, Misc.scala:209:26, :213:27
  wire             atomics_a_mask_acc_29 =
    atomics_a_mask_acc_25 | atomics_a_mask_size_13 & atomics_a_mask_eq_61;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             atomics_a_mask_size_15 = size == 2'h2;	// AMOALU.scala:17:57, DCache.scala:311:19, Misc.scala:208:26
  wire             atomics_a_mask_acc_30 =
    (&size) | atomics_a_mask_size_15 & ~(s2_req_addr[2]);	// DCache.scala:311:19, Misc.scala:205:21, :208:26, :209:26, :210:20, :214:{29,38}
  wire             atomics_a_mask_acc_31 =
    (&size) | atomics_a_mask_size_15 & s2_req_addr[2];	// DCache.scala:311:19, Misc.scala:205:21, :208:26, :209:26, :214:{29,38}
  wire             atomics_a_mask_size_16 = size == 2'h1;	// Cat.scala:30:58, DCache.scala:311:19, Misc.scala:208:26
  wire             atomics_a_mask_eq_72 = ~(s2_req_addr[2]) & ~(s2_req_addr[1]);	// DCache.scala:311:19, Misc.scala:209:26, :210:20, :213:27
  wire             atomics_a_mask_acc_32 =
    atomics_a_mask_acc_30 | atomics_a_mask_size_16 & atomics_a_mask_eq_72;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             atomics_a_mask_eq_73 = ~(s2_req_addr[2]) & s2_req_addr[1];	// DCache.scala:311:19, Misc.scala:209:26, :210:20, :213:27
  wire             atomics_a_mask_acc_33 =
    atomics_a_mask_acc_30 | atomics_a_mask_size_16 & atomics_a_mask_eq_73;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             atomics_a_mask_eq_74 = s2_req_addr[2] & ~(s2_req_addr[1]);	// DCache.scala:311:19, Misc.scala:209:26, :210:20, :213:27
  wire             atomics_a_mask_acc_34 =
    atomics_a_mask_acc_31 | atomics_a_mask_size_16 & atomics_a_mask_eq_74;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             atomics_a_mask_eq_75 = s2_req_addr[2] & s2_req_addr[1];	// DCache.scala:311:19, Misc.scala:209:26, :213:27
  wire             atomics_a_mask_acc_35 =
    atomics_a_mask_acc_31 | atomics_a_mask_size_16 & atomics_a_mask_eq_75;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             atomics_a_mask_size_18 = size == 2'h2;	// AMOALU.scala:17:57, DCache.scala:311:19, Misc.scala:208:26
  wire             atomics_a_mask_acc_36 =
    (&size) | atomics_a_mask_size_18 & ~(s2_req_addr[2]);	// DCache.scala:311:19, Misc.scala:205:21, :208:26, :209:26, :210:20, :214:{29,38}
  wire             atomics_a_mask_acc_37 =
    (&size) | atomics_a_mask_size_18 & s2_req_addr[2];	// DCache.scala:311:19, Misc.scala:205:21, :208:26, :209:26, :214:{29,38}
  wire             atomics_a_mask_size_19 = size == 2'h1;	// Cat.scala:30:58, DCache.scala:311:19, Misc.scala:208:26
  wire             atomics_a_mask_eq_86 = ~(s2_req_addr[2]) & ~(s2_req_addr[1]);	// DCache.scala:311:19, Misc.scala:209:26, :210:20, :213:27
  wire             atomics_a_mask_acc_38 =
    atomics_a_mask_acc_36 | atomics_a_mask_size_19 & atomics_a_mask_eq_86;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             atomics_a_mask_eq_87 = ~(s2_req_addr[2]) & s2_req_addr[1];	// DCache.scala:311:19, Misc.scala:209:26, :210:20, :213:27
  wire             atomics_a_mask_acc_39 =
    atomics_a_mask_acc_36 | atomics_a_mask_size_19 & atomics_a_mask_eq_87;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             atomics_a_mask_eq_88 = s2_req_addr[2] & ~(s2_req_addr[1]);	// DCache.scala:311:19, Misc.scala:209:26, :210:20, :213:27
  wire             atomics_a_mask_acc_40 =
    atomics_a_mask_acc_37 | atomics_a_mask_size_19 & atomics_a_mask_eq_88;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             atomics_a_mask_eq_89 = s2_req_addr[2] & s2_req_addr[1];	// DCache.scala:311:19, Misc.scala:209:26, :213:27
  wire             atomics_a_mask_acc_41 =
    atomics_a_mask_acc_37 | atomics_a_mask_size_19 & atomics_a_mask_eq_89;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             atomics_a_mask_size_21 = size == 2'h2;	// AMOALU.scala:17:57, DCache.scala:311:19, Misc.scala:208:26
  wire             atomics_a_mask_acc_42 =
    (&size) | atomics_a_mask_size_21 & ~(s2_req_addr[2]);	// DCache.scala:311:19, Misc.scala:205:21, :208:26, :209:26, :210:20, :214:{29,38}
  wire             atomics_a_mask_acc_43 =
    (&size) | atomics_a_mask_size_21 & s2_req_addr[2];	// DCache.scala:311:19, Misc.scala:205:21, :208:26, :209:26, :214:{29,38}
  wire             atomics_a_mask_size_22 = size == 2'h1;	// Cat.scala:30:58, DCache.scala:311:19, Misc.scala:208:26
  wire             atomics_a_mask_eq_100 = ~(s2_req_addr[2]) & ~(s2_req_addr[1]);	// DCache.scala:311:19, Misc.scala:209:26, :210:20, :213:27
  wire             atomics_a_mask_acc_44 =
    atomics_a_mask_acc_42 | atomics_a_mask_size_22 & atomics_a_mask_eq_100;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             atomics_a_mask_eq_101 = ~(s2_req_addr[2]) & s2_req_addr[1];	// DCache.scala:311:19, Misc.scala:209:26, :210:20, :213:27
  wire             atomics_a_mask_acc_45 =
    atomics_a_mask_acc_42 | atomics_a_mask_size_22 & atomics_a_mask_eq_101;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             atomics_a_mask_eq_102 = s2_req_addr[2] & ~(s2_req_addr[1]);	// DCache.scala:311:19, Misc.scala:209:26, :210:20, :213:27
  wire             atomics_a_mask_acc_46 =
    atomics_a_mask_acc_43 | atomics_a_mask_size_22 & atomics_a_mask_eq_102;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             atomics_a_mask_eq_103 = s2_req_addr[2] & s2_req_addr[1];	// DCache.scala:311:19, Misc.scala:209:26, :213:27
  wire             atomics_a_mask_acc_47 =
    atomics_a_mask_acc_43 | atomics_a_mask_size_22 & atomics_a_mask_eq_103;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             atomics_a_mask_size_24 = size == 2'h2;	// AMOALU.scala:17:57, DCache.scala:311:19, Misc.scala:208:26
  wire             atomics_a_mask_acc_48 =
    (&size) | atomics_a_mask_size_24 & ~(s2_req_addr[2]);	// DCache.scala:311:19, Misc.scala:205:21, :208:26, :209:26, :210:20, :214:{29,38}
  wire             atomics_a_mask_acc_49 =
    (&size) | atomics_a_mask_size_24 & s2_req_addr[2];	// DCache.scala:311:19, Misc.scala:205:21, :208:26, :209:26, :214:{29,38}
  wire             atomics_a_mask_size_25 = size == 2'h1;	// Cat.scala:30:58, DCache.scala:311:19, Misc.scala:208:26
  wire             atomics_a_mask_eq_114 = ~(s2_req_addr[2]) & ~(s2_req_addr[1]);	// DCache.scala:311:19, Misc.scala:209:26, :210:20, :213:27
  wire             atomics_a_mask_acc_50 =
    atomics_a_mask_acc_48 | atomics_a_mask_size_25 & atomics_a_mask_eq_114;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             atomics_a_mask_eq_115 = ~(s2_req_addr[2]) & s2_req_addr[1];	// DCache.scala:311:19, Misc.scala:209:26, :210:20, :213:27
  wire             atomics_a_mask_acc_51 =
    atomics_a_mask_acc_48 | atomics_a_mask_size_25 & atomics_a_mask_eq_115;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             atomics_a_mask_eq_116 = s2_req_addr[2] & ~(s2_req_addr[1]);	// DCache.scala:311:19, Misc.scala:209:26, :210:20, :213:27
  wire             atomics_a_mask_acc_52 =
    atomics_a_mask_acc_49 | atomics_a_mask_size_25 & atomics_a_mask_eq_116;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             atomics_a_mask_eq_117 = s2_req_addr[2] & s2_req_addr[1];	// DCache.scala:311:19, Misc.scala:209:26, :213:27
  wire             atomics_a_mask_acc_53 =
    atomics_a_mask_acc_49 | atomics_a_mask_size_25 & atomics_a_mask_eq_117;	// Misc.scala:208:26, :213:27, :214:{29,38}
  wire             _atomics_T = s2_req_cmd == 5'h4;	// DCache.scala:311:19, Mux.scala:80:60, package.scala:15:47
  wire             _atomics_T_2 = s2_req_cmd == 5'h9;	// DCache.scala:311:19, Mux.scala:80:60, package.scala:15:47
  wire             _atomics_T_4 = s2_req_cmd == 5'hA;	// DCache.scala:311:19, Mux.scala:80:60, package.scala:15:47
  wire             _atomics_T_6 = s2_req_cmd == 5'hB;	// DCache.scala:311:19, Mux.scala:80:60, package.scala:15:47
  wire             _atomics_T_8 = s2_req_cmd == 5'h8;	// DCache.scala:311:19, Mux.scala:80:60, package.scala:15:47
  wire             _atomics_T_10 = s2_req_cmd == 5'hC;	// DCache.scala:311:19, Mux.scala:80:60, package.scala:15:47
  wire             _atomics_T_12 = s2_req_cmd == 5'hD;	// DCache.scala:311:19, Mux.scala:80:60, package.scala:15:47
  wire             _atomics_T_14 = s2_req_cmd == 5'hE;	// DCache.scala:311:19, Mux.scala:80:60, package.scala:15:47
  wire             _atomics_T_16 = s2_req_cmd == 5'hF;	// DCache.scala:311:19, Mux.scala:80:60, package.scala:15:47
  wire [7:0]       atomics_mask =
    _atomics_T_16
      ? {atomics_a_mask_acc_53 | atomics_a_mask_eq_117 & s2_req_addr[0],
         atomics_a_mask_acc_53 | atomics_a_mask_eq_117 & ~(s2_req_addr[0]),
         atomics_a_mask_acc_52 | atomics_a_mask_eq_116 & s2_req_addr[0],
         atomics_a_mask_acc_52 | atomics_a_mask_eq_116 & ~(s2_req_addr[0]),
         atomics_a_mask_acc_51 | atomics_a_mask_eq_115 & s2_req_addr[0],
         atomics_a_mask_acc_51 | atomics_a_mask_eq_115 & ~(s2_req_addr[0]),
         atomics_a_mask_acc_50 | atomics_a_mask_eq_114 & s2_req_addr[0],
         atomics_a_mask_acc_50 | atomics_a_mask_eq_114 & ~(s2_req_addr[0])}
      : _atomics_T_14
          ? {atomics_a_mask_acc_47 | atomics_a_mask_eq_103 & s2_req_addr[0],
             atomics_a_mask_acc_47 | atomics_a_mask_eq_103 & ~(s2_req_addr[0]),
             atomics_a_mask_acc_46 | atomics_a_mask_eq_102 & s2_req_addr[0],
             atomics_a_mask_acc_46 | atomics_a_mask_eq_102 & ~(s2_req_addr[0]),
             atomics_a_mask_acc_45 | atomics_a_mask_eq_101 & s2_req_addr[0],
             atomics_a_mask_acc_45 | atomics_a_mask_eq_101 & ~(s2_req_addr[0]),
             atomics_a_mask_acc_44 | atomics_a_mask_eq_100 & s2_req_addr[0],
             atomics_a_mask_acc_44 | atomics_a_mask_eq_100 & ~(s2_req_addr[0])}
          : _atomics_T_12
              ? {atomics_a_mask_acc_41 | atomics_a_mask_eq_89 & s2_req_addr[0],
                 atomics_a_mask_acc_41 | atomics_a_mask_eq_89 & ~(s2_req_addr[0]),
                 atomics_a_mask_acc_40 | atomics_a_mask_eq_88 & s2_req_addr[0],
                 atomics_a_mask_acc_40 | atomics_a_mask_eq_88 & ~(s2_req_addr[0]),
                 atomics_a_mask_acc_39 | atomics_a_mask_eq_87 & s2_req_addr[0],
                 atomics_a_mask_acc_39 | atomics_a_mask_eq_87 & ~(s2_req_addr[0]),
                 atomics_a_mask_acc_38 | atomics_a_mask_eq_86 & s2_req_addr[0],
                 atomics_a_mask_acc_38 | atomics_a_mask_eq_86 & ~(s2_req_addr[0])}
              : _atomics_T_10
                  ? {atomics_a_mask_acc_35 | atomics_a_mask_eq_75 & s2_req_addr[0],
                     atomics_a_mask_acc_35 | atomics_a_mask_eq_75 & ~(s2_req_addr[0]),
                     atomics_a_mask_acc_34 | atomics_a_mask_eq_74 & s2_req_addr[0],
                     atomics_a_mask_acc_34 | atomics_a_mask_eq_74 & ~(s2_req_addr[0]),
                     atomics_a_mask_acc_33 | atomics_a_mask_eq_73 & s2_req_addr[0],
                     atomics_a_mask_acc_33 | atomics_a_mask_eq_73 & ~(s2_req_addr[0]),
                     atomics_a_mask_acc_32 | atomics_a_mask_eq_72 & s2_req_addr[0],
                     atomics_a_mask_acc_32 | atomics_a_mask_eq_72 & ~(s2_req_addr[0])}
                  : _atomics_T_8
                      ? {atomics_a_mask_acc_29 | atomics_a_mask_eq_61 & s2_req_addr[0],
                         atomics_a_mask_acc_29 | atomics_a_mask_eq_61 & ~(s2_req_addr[0]),
                         atomics_a_mask_acc_28 | atomics_a_mask_eq_60 & s2_req_addr[0],
                         atomics_a_mask_acc_28 | atomics_a_mask_eq_60 & ~(s2_req_addr[0]),
                         atomics_a_mask_acc_27 | atomics_a_mask_eq_59 & s2_req_addr[0],
                         atomics_a_mask_acc_27 | atomics_a_mask_eq_59 & ~(s2_req_addr[0]),
                         atomics_a_mask_acc_26 | atomics_a_mask_eq_58 & s2_req_addr[0],
                         atomics_a_mask_acc_26 | atomics_a_mask_eq_58 & ~(s2_req_addr[0])}
                      : _atomics_T_6
                          ? {atomics_a_mask_acc_23 | atomics_a_mask_eq_47
                               & s2_req_addr[0],
                             atomics_a_mask_acc_23 | atomics_a_mask_eq_47
                               & ~(s2_req_addr[0]),
                             atomics_a_mask_acc_22 | atomics_a_mask_eq_46
                               & s2_req_addr[0],
                             atomics_a_mask_acc_22 | atomics_a_mask_eq_46
                               & ~(s2_req_addr[0]),
                             atomics_a_mask_acc_21 | atomics_a_mask_eq_45
                               & s2_req_addr[0],
                             atomics_a_mask_acc_21 | atomics_a_mask_eq_45
                               & ~(s2_req_addr[0]),
                             atomics_a_mask_acc_20 | atomics_a_mask_eq_44
                               & s2_req_addr[0],
                             atomics_a_mask_acc_20 | atomics_a_mask_eq_44
                               & ~(s2_req_addr[0])}
                          : _atomics_T_4
                              ? {atomics_a_mask_acc_17 | atomics_a_mask_eq_33
                                   & s2_req_addr[0],
                                 atomics_a_mask_acc_17 | atomics_a_mask_eq_33
                                   & ~(s2_req_addr[0]),
                                 atomics_a_mask_acc_16 | atomics_a_mask_eq_32
                                   & s2_req_addr[0],
                                 atomics_a_mask_acc_16 | atomics_a_mask_eq_32
                                   & ~(s2_req_addr[0]),
                                 atomics_a_mask_acc_15 | atomics_a_mask_eq_31
                                   & s2_req_addr[0],
                                 atomics_a_mask_acc_15 | atomics_a_mask_eq_31
                                   & ~(s2_req_addr[0]),
                                 atomics_a_mask_acc_14 | atomics_a_mask_eq_30
                                   & s2_req_addr[0],
                                 atomics_a_mask_acc_14 | atomics_a_mask_eq_30
                                   & ~(s2_req_addr[0])}
                              : _atomics_T_2
                                  ? {atomics_a_mask_acc_11 | atomics_a_mask_eq_19
                                       & s2_req_addr[0],
                                     atomics_a_mask_acc_11 | atomics_a_mask_eq_19
                                       & ~(s2_req_addr[0]),
                                     atomics_a_mask_acc_10 | atomics_a_mask_eq_18
                                       & s2_req_addr[0],
                                     atomics_a_mask_acc_10 | atomics_a_mask_eq_18
                                       & ~(s2_req_addr[0]),
                                     atomics_a_mask_acc_9 | atomics_a_mask_eq_17
                                       & s2_req_addr[0],
                                     atomics_a_mask_acc_9 | atomics_a_mask_eq_17
                                       & ~(s2_req_addr[0]),
                                     atomics_a_mask_acc_8 | atomics_a_mask_eq_16
                                       & s2_req_addr[0],
                                     atomics_a_mask_acc_8 | atomics_a_mask_eq_16
                                       & ~(s2_req_addr[0])}
                                  : _atomics_T
                                      ? {atomics_a_mask_acc_5 | atomics_a_mask_eq_5
                                           & s2_req_addr[0],
                                         atomics_a_mask_acc_5 | atomics_a_mask_eq_5
                                           & ~(s2_req_addr[0]),
                                         atomics_a_mask_acc_4 | atomics_a_mask_eq_4
                                           & s2_req_addr[0],
                                         atomics_a_mask_acc_4 | atomics_a_mask_eq_4
                                           & ~(s2_req_addr[0]),
                                         atomics_a_mask_acc_3 | atomics_a_mask_eq_3
                                           & s2_req_addr[0],
                                         atomics_a_mask_acc_3 | atomics_a_mask_eq_3
                                           & ~(s2_req_addr[0]),
                                         atomics_a_mask_acc_2 | atomics_a_mask_eq_2
                                           & s2_req_addr[0],
                                         atomics_a_mask_acc_2 | atomics_a_mask_eq_2
                                           & ~(s2_req_addr[0])}
                                      : 8'h0;	// Cat.scala:30:58, DCache.scala:118:27, :311:19, Misc.scala:209:26, :210:20, :213:27, :214:29, Mux.scala:80:{57,60}
  wire             _block_probe_for_pending_release_ack_T =
    release_ack_wait & release_ack_dirty;	// DCache.scala:204:29, :205:30, :578:27
  wire             deq_valid =
    s2_valid_uncached_pending | s2_valid_cached_miss
    & ~_block_probe_for_pending_release_ack_T & ~(&s2_victim_state_state);	// DCache.scala:397:60, :402:64, :406:28, :576:32, :578:{8,27,49}, :579:89, Misc.scala:55:20
  wire             _GEN_14 =
    ~s2_write | _metaArb_io_in_3_bits_data_c_cat_T_23 | ~s2_read | _atomics_T_16
    | _atomics_T_14 | _atomics_T_12 | _atomics_T_10 | _atomics_T_8 | _atomics_T_6
    | _atomics_T_4 | _atomics_T_2 | _atomics_T;	// Consts.scala:81:75, :82:{49,76}, DCache.scala:581:8, :583:8, Mux.scala:80:60
  wire             _io_errors_bus_valid_T = tl_out_d_ready & auto_out_d_valid;	// DCache.scala:643:18, :694:51, :696:20, :724:68, :725:22, Decoupled.scala:40:37
  wire [26:0]      _beats1_decode_T_1 = 27'hFFF << auto_out_d_bits_size;	// package.scala:234:77
  wire [8:0]       beats1 =
    auto_out_d_bits_opcode[0] ? ~(_beats1_decode_T_1[11:3]) : 9'h0;	// Edges.scala:105:36, :220:14, :228:27, package.scala:234:{46,77,82}
  reg  [8:0]       counter;	// Edges.scala:228:27
  wire [8:0]       _counter1_T = counter - 9'h1;	// Edges.scala:228:27, :229:28
  wire             d_last = counter == 9'h1 | beats1 == 9'h0;	// Edges.scala:220:14, :228:27, :231:{25,37,47}
  wire [8:0]       count = beats1 & ~_counter1_T;	// Edges.scala:220:14, :229:28, :233:{25,27}
  wire             grantIsUncachedData = auto_out_d_bits_opcode == 3'h1;	// Misc.scala:37:36, package.scala:15:47
  wire             grantIsUncached =
    grantIsUncachedData | auto_out_d_bits_opcode == 3'h0 | auto_out_d_bits_opcode == 3'h2;	// Misc.scala:37:36, package.scala:15:47, :72:59
  wire             grantIsRefill = auto_out_d_bits_opcode == 3'h5;	// DCache.scala:192:34, package.scala:15:47
  wire             grantIsCached = auto_out_d_bits_opcode == 3'h4 | grantIsRefill;	// package.scala:15:47, :72:59
  wire             grantIsVoluntary = auto_out_d_bits_opcode == 3'h6;	// Consts.scala:81:48, DCache.scala:637:32
  reg              grantInProgress;	// DCache.scala:639:28
  reg  [2:0]       blockProbeAfterGrantCount;	// DCache.scala:640:38
  wire             _metaArb_io_in_4_valid_T = release_state == 4'h6;	// DCache.scala:207:26, package.scala:15:47
  wire             _bundleOut_0_c_valid_T = release_state == 4'h9;	// DCache.scala:207:26, package.scala:15:47
  wire             _canAcceptCachedGrant_T_4 =
    _canAcceptCachedGrant_T | _metaArb_io_in_4_valid_T | _bundleOut_0_c_valid_T;	// package.scala:15:47, :72:59
  wire             _GEN_15 = _io_errors_bus_valid_T & grantIsCached;	// DCache.scala:647:26, Decoupled.scala:40:37, package.scala:72:59
  wire             _GEN_16 = auto_out_d_bits_source & d_last;	// DCache.scala:658:17, Edges.scala:231:37
  wire             _GEN_17 =
    ~_io_errors_bus_valid_T | grantIsCached | ~(grantIsUncached & grantIsUncachedData);	// DCache.scala:603:26, :646:26, :647:26, :656:35, :663:34, :666:25, Decoupled.scala:40:37, package.scala:15:47, :72:59
  wire             _GEN_18 = grantIsRefill & ~_dataArb_io_in_1_ready;	// DCache.scala:133:23, :694:{23,26}, package.scala:15:47
  wire             tl_out_e_valid =
    ~_GEN_18 & auto_out_d_valid & ~(|counter) & grantIsCached
    & ~_canAcceptCachedGrant_T_4;	// DCache.scala:642:30, :686:18, :694:{23,51}, :695:20, Edges.scala:228:27, :230:25, package.scala:72:59
  wire [3:0]       _metaArb_io_in_3_bits_data_T_1 =
    {_metaArb_io_in_3_bits_data_c_cat_T_22 | _metaArb_io_in_3_bits_data_c_cat_T_23 | s2_sc
       | _metaArb_io_in_3_bits_data_c_cat_T_27 | _metaArb_io_in_3_bits_data_c_cat_T_28
       | _metaArb_io_in_3_bits_data_c_cat_T_29 | _metaArb_io_in_3_bits_data_c_cat_T_30
       | _metaArb_io_in_3_bits_data_c_cat_T_34 | _metaArb_io_in_3_bits_data_c_cat_T_35
       | _metaArb_io_in_3_bits_data_c_cat_T_36 | _metaArb_io_in_3_bits_data_c_cat_T_37
       | _metaArb_io_in_3_bits_data_c_cat_T_38,
     _metaArb_io_in_3_bits_data_c_cat_T_22 | _metaArb_io_in_3_bits_data_c_cat_T_23 | s2_sc
       | _metaArb_io_in_3_bits_data_c_cat_T_27 | _metaArb_io_in_3_bits_data_c_cat_T_28
       | _metaArb_io_in_3_bits_data_c_cat_T_29 | _metaArb_io_in_3_bits_data_c_cat_T_30
       | _metaArb_io_in_3_bits_data_c_cat_T_34 | _metaArb_io_in_3_bits_data_c_cat_T_35
       | _metaArb_io_in_3_bits_data_c_cat_T_36 | _metaArb_io_in_3_bits_data_c_cat_T_37
       | _metaArb_io_in_3_bits_data_c_cat_T_38 | _metaArb_io_in_3_bits_data_c_cat_T_45
       | s2_lr,
     auto_out_d_bits_param};	// Cat.scala:30:58, Consts.scala:81:{48,65}, :82:{32,49,76}, :83:{54,64}, package.scala:15:47
  reg              blockUncachedGrant;	// DCache.scala:722:33
  wire             _GEN_19 = grantIsUncachedData & (blockUncachedGrant | s1_valid);	// DCache.scala:162:21, :722:33, :724:{31,54}, package.scala:15:47
  assign tl_out_d_ready =
    ~(_GEN_19 | _GEN_18)
    & (~grantIsCached | ((|counter) | auto_out_e_ready) & ~_canAcceptCachedGrant_T_4);	// DCache.scala:642:30, :643:{18,24,50,69}, :694:{23,51}, :696:20, :724:{31,68}, :725:22, Edges.scala:228:27, :230:25, package.scala:72:59
  wire             _io_cpu_req_ready_output =
    _GEN_19
      ? ~(auto_out_d_valid | _GEN) & _io_cpu_req_ready_T_4
      : ~_GEN & _io_cpu_req_ready_T_4;	// DCache.scala:212:{20,73}, :237:{45,64}, :246:{34,53}, :254:{79,98}, :724:{31,68}, :727:29, :728:26
  wire             _GEN_20 = _GEN_19 & auto_out_d_valid;	// DCache.scala:693:26, :724:{31,68}, :727:29, :729:32
  wire             block_probe_for_core_progress =
    (|blockProbeAfterGrantCount) | (|(lrscCount[6:2]));	// DCache.scala:444:22, :445:29, :640:38, :641:35, :738:69
  wire             tl_out_b_ready =
    _metaArb_io_in_6_ready
    & ~(block_probe_for_core_progress | releaseInFlight
        | _block_probe_for_pending_release_ack_T
        & (auto_out_b_bits_address[11:6] ^ release_ack_addr[11:6]) == 6'h0
        | grantInProgress | s1_valid | s2_valid);	// DCache.scala:122:23, :162:21, :206:29, :303:21, :306:46, :578:27, :639:28, :738:69, :739:{83,109,145}, :742:{44,47,119}
  wire             _io_cpu_perf_release_T = auto_out_c_ready & tl_out_c_valid;	// DCache.scala:806:21, :832:47, :833:22, :836:48, :837:22, Decoupled.scala:40:37
  wire [26:0]      _GEN_21 = {23'h0, tl_out_c_bits_size};	// DCache.scala:841:48, :845:102, :846:52, package.scala:234:77
  wire [26:0]      _beats1_decode_T_5 = 27'hFFF << _GEN_21;	// package.scala:234:77
  wire [8:0]       beats1_1 =
    tl_out_c_bits_opcode[0] ? ~(_beats1_decode_T_5[11:3]) : 9'h0;	// DCache.scala:841:48, :845:102, :846:52, Edges.scala:101:36, :220:14, :228:27, package.scala:234:{46,77,82}
  reg  [8:0]       counter_1;	// Edges.scala:228:27
  wire [8:0]       _counter1_T_1 = counter_1 - 9'h1;	// Edges.scala:228:27, :229:28
  wire             c_first = counter_1 == 9'h0;	// Edges.scala:228:27, :230:25
  wire             releaseDone =
    (counter_1 == 9'h1 | beats1_1 == 9'h0) & _io_cpu_perf_release_T;	// Decoupled.scala:40:37, Edges.scala:220:14, :228:27, :231:{25,37,47}, :232:22
  reg              s1_release_data_valid;	// DCache.scala:773:34
  reg              s2_release_data_valid;	// DCache.scala:774:34
  wire             releaseRejected = s2_release_data_valid & ~_io_cpu_perf_release_T;	// DCache.scala:774:34, :775:{44,47}, Decoupled.scala:40:37
  wire [9:0]       _releaseDataBeat_T_5 =
    {1'h0, beats1_1 & ~_counter1_T_1}
    + {8'h0,
       releaseRejected
         ? 2'h0
         : {1'h0, s1_release_data_valid} + {1'h0, s2_release_data_valid}};	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, :773:34, :774:34, :775:44, :776:{47,52,101}, Decoupled.scala:40:37, Edges.scala:220:14, :229:28, :233:{25,27}, PRNG.scala:82:22
  wire             _GEN_22 = s2_meta_error | s2_prb_ack_data;	// DCache.scala:334:53, :783:17, :808:28, :810:36, :812:45, Misc.scala:37:9
  assign s1_nack =
    s2_probe & (s2_meta_error | s2_prb_ack_data | (|s2_probe_state_state) | ~releaseDone)
    | s1_valid & s1_read
    & (pstore1_valid_likely & pstore1_addr[11:3] == s1_vaddr[11:3]
       & (s1_write ? (|(pstore1_mask & s1_mask_xwr)) : (|(pstore1_mask & s1_mask_xwr)))
       | pstore2_valid & pstore2_addr[11:3] == s1_vaddr[11:3]
       & (s1_write ? (|(mask & s1_mask_xwr)) : (|(mask & s1_mask_xwr))))
    | _io_cpu_s2_nack_output | _metaArb_io_in_2_valid_T;	// Cat.scala:30:58, Consts.scala:81:75, :82:76, DCache.scala:162:21, :255:79, :265:{75,85}, :305:21, :334:53, :417:86, :418:{62,82,92}, :473:30, :477:51, :503:19, :533:{9,31,43}, :534:{8,38,66,77,92}, :536:{27,69}, :537:21, :543:{18,36,46}, :806:21, :818:22, :821:{24,34}, Edges.scala:232:22, Metadata.scala:49:45, Misc.scala:37:9, Reg.scala:15:16
  wire             _GEN_23 = release_state == 4'h4;	// DCache.scala:207:26, :809:23, :823:25
  wire             _GEN_24 = release_state == 4'h5;	// DCache.scala:207:26, :819:29, :832:25
  wire             _GEN_25 = release_state == 4'h3;	// DCache.scala:207:26, :815:29, :836:25
  assign tl_out_c_valid =
    _GEN_25 | _GEN_24 | s2_probe & ~_GEN_22 | s2_release_data_valid
    & ~(c_first & release_ack_wait);	// DCache.scala:204:29, :305:21, :774:34, :782:{18,115,118,128}, :783:17, :806:21, :808:28, :810:36, :812:45, :832:{25,47}, :833:22, :836:{25,48}, :837:22, Edges.scala:230:25
  wire             _GEN_26 =
    _canAcceptCachedGrant_T | _metaArb_io_in_4_valid_T | _bundleOut_0_c_valid_T;	// package.scala:15:47, :72:59
  assign tl_out_c_bits_opcode =
    _GEN_26 ? {2'h3, ~_bundleOut_0_c_valid_T} : {2'h2, _inWriteback_T_1};	// AMOALU.scala:17:57, DCache.scala:836:48, :841:48, :842:21, :845:102, :846:52, :847:23, :852:23, package.scala:15:47, :72:59
  assign tl_out_c_bits_size = _GEN_26 ? 4'h6 : probe_bits_size;	// DCache.scala:841:48, :845:102, :846:52, Reg.scala:15:16, package.scala:15:47, :72:59
  wire             _dataArb_io_in_2_valid_T_1 =
    inWriteback & _releaseDataBeat_T_5 < 10'h8;	// DCache.scala:776:47, :873:{41,60}, package.scala:72:59
  wire             _metaArb_io_in_4_valid_T_2 =
    _metaArb_io_in_4_valid_T | release_state == 4'h7;	// DCache.scala:207:26, :815:29, package.scala:15:47, :72:59
  wire [21:0]      _metaArb_io_in_4_bits_data_T_1 =
    {_GEN_26
       ? 2'h0
       : _GEN_13
           ? 2'h2
           : _GEN_10 ? 2'h1 : _GEN_9 ? 2'h0 : {1'h0, _GEN_8 | _GEN_7 | _GEN_6},
     probe_bits_address[31:12]};	// AMOALU.scala:17:57, Cat.scala:30:58, DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, :845:102, :858:14, :886:{78,97}, Decoupled.scala:40:37, Misc.scala:37:{36,63}, :55:20, PRNG.scala:82:22, Reg.scala:15:16, package.scala:72:59
  reg              io_cpu_s2_xcpt_REG;	// DCache.scala:903:32
  assign _io_cpu_s2_xcpt_pf_ld_output = io_cpu_s2_xcpt_REG & s2_tlb_xcpt_pf_ld;	// DCache.scala:314:24, :903:{24,32}
  assign _io_cpu_s2_xcpt_pf_st_output = io_cpu_s2_xcpt_REG & s2_tlb_xcpt_pf_st;	// DCache.scala:314:24, :903:{24,32}
  assign _io_cpu_s2_xcpt_ae_ld_output = io_cpu_s2_xcpt_REG & s2_tlb_xcpt_ae_ld;	// DCache.scala:314:24, :903:{24,32}
  assign _io_cpu_s2_xcpt_ae_st_output = io_cpu_s2_xcpt_REG & s2_tlb_xcpt_ae_st;	// DCache.scala:314:24, :903:{24,32}
  assign _io_cpu_s2_xcpt_ma_ld_output = io_cpu_s2_xcpt_REG & s2_tlb_xcpt_ma_ld;	// DCache.scala:314:24, :903:{24,32}
  assign _io_cpu_s2_xcpt_ma_st_output = io_cpu_s2_xcpt_REG & s2_tlb_xcpt_ma_st;	// DCache.scala:314:24, :903:{24,32}
  reg              doUncachedResp;	// DCache.scala:918:27
  wire             _io_cpu_replay_next_output =
    _io_errors_bus_valid_T & grantIsUncachedData;	// DCache.scala:920:41, Decoupled.scala:40:37, package.scala:15:47
  `ifndef SYNTHESIS	// DCache.scala:1156:11
    always @(posedge gated_clock) begin	// DCache.scala:1156:11
      automatic logic _GEN_27 = _io_errors_bus_valid_T & ~grantIsCached;	// DCache.scala:647:26, Decoupled.scala:40:37, package.scala:72:59
      if (~(~(_pstore_drain_opportunistic_T | _pstore_drain_opportunistic_T_1
              | _pstore_drain_opportunistic_T_26 | _pstore_drain_opportunistic_T_28
              | _pstore_drain_opportunistic_T_29 | _pstore_drain_opportunistic_T_30
              | _pstore_drain_opportunistic_T_31 | _pstore_drain_opportunistic_T_35
              | _pstore_drain_opportunistic_T_36 | _pstore_drain_opportunistic_T_37
              | _pstore_drain_opportunistic_T_38 | _pstore_drain_opportunistic_T_39
              | (_pstore_drain_opportunistic_T_23 | _pstore_drain_opportunistic_T_48
                 | _pstore_drain_opportunistic_T_26 | _pstore_drain_opportunistic_T_28
                 | _pstore_drain_opportunistic_T_29 | _pstore_drain_opportunistic_T_30
                 | _pstore_drain_opportunistic_T_31 | _pstore_drain_opportunistic_T_35
                 | _pstore_drain_opportunistic_T_36 | _pstore_drain_opportunistic_T_37
                 | _pstore_drain_opportunistic_T_38 | _pstore_drain_opportunistic_T_39)
              & _pstore_drain_opportunistic_T_48) | ~_dataArb_io_in_3_valid_res_T_2
            | reset)) begin	// Consts.scala:81:{31,48,65}, :82:{49,76}, DCache.scala:1155:15, :1156:{11,12}, :1160:21, :1161:23, package.scala:15:47, :72:59
        if (`ASSERT_VERBOSE_COND_)	// DCache.scala:1156:11
          $error("Assertion failed\n    at DCache.scala:1156 assert(!needsRead(req) || res)\n");	// DCache.scala:1156:11
        if (`STOP_COND_)	// DCache.scala:1156:11
          $fatal;	// DCache.scala:1156:11
      end
      if (~(~(_pstore_drain_opportunistic_T | _pstore_drain_opportunistic_T_1
              | _pstore_drain_opportunistic_T_26 | _pstore_drain_opportunistic_T_28
              | _pstore_drain_opportunistic_T_29 | _pstore_drain_opportunistic_T_30
              | _pstore_drain_opportunistic_T_31 | _pstore_drain_opportunistic_T_35
              | _pstore_drain_opportunistic_T_36 | _pstore_drain_opportunistic_T_37
              | _pstore_drain_opportunistic_T_38 | _pstore_drain_opportunistic_T_39
              | (_pstore_drain_opportunistic_T_23 | _pstore_drain_opportunistic_T_48
                 | _pstore_drain_opportunistic_T_26 | _pstore_drain_opportunistic_T_28
                 | _pstore_drain_opportunistic_T_29 | _pstore_drain_opportunistic_T_30
                 | _pstore_drain_opportunistic_T_31 | _pstore_drain_opportunistic_T_35
                 | _pstore_drain_opportunistic_T_36 | _pstore_drain_opportunistic_T_37
                 | _pstore_drain_opportunistic_T_38 | _pstore_drain_opportunistic_T_39)
              & _pstore_drain_opportunistic_T_48) | ~_pstore_drain_opportunistic_res_T_2
            | reset)) begin	// Consts.scala:81:{31,48,65}, :82:{49,76}, DCache.scala:1155:15, :1156:{11,12}, :1160:21, :1161:23, package.scala:15:47, :72:59
        if (`ASSERT_VERBOSE_COND_)	// DCache.scala:1156:11
          $error("Assertion failed\n    at DCache.scala:1156 assert(!needsRead(req) || res)\n");	// DCache.scala:1156:11
        if (`STOP_COND_)	// DCache.scala:1156:11
          $fatal;	// DCache.scala:1156:11
      end
      if (~(pstore1_rmw | (_dataArb_io_in_0_valid_T_4 | pstore1_held) == pstore1_valid
            | reset)) begin	// DCache.scala:476:29, :478:{72,96}, :479:38, :482:{9,63}, Reg.scala:15:16
        if (`ASSERT_VERBOSE_COND_)	// DCache.scala:482:9
          $error("Assertion failed\n    at DCache.scala:482 assert(pstore1_rmw || pstore1_valid_not_rmw(io.cpu.s2_kill) === pstore1_valid)\n");	// DCache.scala:482:9
        if (`STOP_COND_)	// DCache.scala:482:9
          $fatal;	// DCache.scala:482:9
      end
      if (_GEN_15 & ~(cached_grant_wait | reset)) begin	// DCache.scala:201:30, :647:26, :649:13
        if (`ASSERT_VERBOSE_COND_)	// DCache.scala:649:13
          $error("Assertion failed: A GrantData was unexpected by the dcache.\n    at DCache.scala:649 assert(cached_grant_wait, \"A GrantData was unexpected by the dcache.\")\n");	// DCache.scala:649:13
        if (`STOP_COND_)	// DCache.scala:649:13
          $fatal;	// DCache.scala:649:13
      end
      if (_GEN_27 & grantIsUncached & _GEN_16 & ~(uncachedInFlight_0 | reset)) begin	// DCache.scala:215:33, :647:26, :658:17, :659:17, package.scala:72:59
        if (`ASSERT_VERBOSE_COND_)	// DCache.scala:659:17
          $error("Assertion failed: An AccessAck was unexpected by the dcache.\n    at DCache.scala:659 assert(f, \"An AccessAck was unexpected by the dcache.\") // TODO must handle Ack coming back on same cycle!\n");	// DCache.scala:659:17
        if (`STOP_COND_)	// DCache.scala:659:17
          $fatal;	// DCache.scala:659:17
      end
      if (_GEN_27 & ~grantIsUncached & grantIsVoluntary
          & ~(release_ack_wait | reset)) begin	// DCache.scala:204:29, :637:32, :647:26, :656:35, :680:13, package.scala:72:59
        if (`ASSERT_VERBOSE_COND_)	// DCache.scala:680:13
          $error("Assertion failed: A ReleaseAck was unexpected by the dcache.\n    at DCache.scala:680 assert(release_ack_wait, \"A ReleaseAck was unexpected by the dcache.\") // TODO should handle Ack coming back on same cycle!\n");	// DCache.scala:680:13
        if (`STOP_COND_)	// DCache.scala:680:13
          $fatal;	// DCache.scala:680:13
      end
      if (~((auto_out_e_ready
             & tl_out_e_valid) == (_io_errors_bus_valid_T & ~(|counter) & grantIsCached)
            | reset)) begin	// DCache.scala:686:18, :688:{9,26,58}, :694:51, :695:20, Decoupled.scala:40:37, Edges.scala:228:27, :230:25, package.scala:72:59
        if (`ASSERT_VERBOSE_COND_)	// DCache.scala:688:9
          $error("Assertion failed\n    at DCache.scala:688 assert(tl_out.e.fire() === (tl_out.d.fire() && d_first && grantIsCached))\n");	// DCache.scala:688:9
        if (`STOP_COND_)	// DCache.scala:688:9
          $fatal;	// DCache.scala:688:9
      end
      if (s2_want_victimize
          & ~(s2_valid_flush_line | s2_flush_valid | _io_cpu_s2_nack_output
              | reset)) begin	// DCache.scala:335:51, :391:75, :399:125, :417:86, :799:13
        if (`ASSERT_VERBOSE_COND_)	// DCache.scala:799:13
          $error("Assertion failed\n    at DCache.scala:799 assert(s2_valid_flush_line || s2_flush_valid || io.cpu.s2_nack)\n");	// DCache.scala:799:13
        if (`STOP_COND_)	// DCache.scala:799:13
          $fatal;	// DCache.scala:799:13
      end
      if (doUncachedResp & ~(~s2_valid_hit | reset)) begin	// DCache.scala:392:69, :417:89, :918:27, :922:11
        if (`ASSERT_VERBOSE_COND_)	// DCache.scala:922:11
          $error("Assertion failed\n    at DCache.scala:922 assert(!s2_valid_hit)\n");	// DCache.scala:922:11
        if (`STOP_COND_)	// DCache.scala:922:11
          $fatal;	// DCache.scala:922:11
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  wire [31:0]      io_cpu_resp_bits_data_lo =
    s2_req_addr[2] ? s2_data[63:32] : s2_data[31:0];	// AMOALU.scala:39:{24,37,55}, DCache.scala:311:19, Misc.scala:209:26, Reg.scala:15:16
  wire             _io_cpu_resp_bits_data_word_bypass_T_1 = size == 2'h2;	// AMOALU.scala:17:57, :42:26, DCache.scala:311:19
  wire [15:0]      io_cpu_resp_bits_data_lo_1 =
    s2_req_addr[1] ? io_cpu_resp_bits_data_lo[31:16] : io_cpu_resp_bits_data_lo[15:0];	// AMOALU.scala:39:{24,37,55}, DCache.scala:311:19, Misc.scala:209:26
  wire [7:0]       io_cpu_resp_bits_data_lo_2 =
    s2_sc
      ? 8'h0
      : s2_req_addr[0]
          ? io_cpu_resp_bits_data_lo_1[15:8]
          : io_cpu_resp_bits_data_lo_1[7:0];	// AMOALU.scala:39:{24,37,55}, :41:23, Consts.scala:81:65, DCache.scala:118:27, :311:19, Misc.scala:209:26
  wire [31:0]      io_cpu_resp_bits_data_word_bypass_lo =
    s2_req_addr[2] ? s2_data[63:32] : s2_data[31:0];	// AMOALU.scala:39:{24,37,55}, DCache.scala:311:19, Misc.scala:209:26, Reg.scala:15:16
  reg              REG;	// DCache.scala:978:18
  wire [33:0]      _metaArb_io_in_5_bits_addr_T =
    {io_cpu_req_bits_addr[33:12], flushCounter, 6'h0};	// Cat.scala:30:58, DCache.scala:203:25, :224:89
  wire [26:0]      _io_cpu_perf_release_beats1_decode_T_1 = 27'hFFF << _GEN_21;	// package.scala:234:77
  reg  [8:0]       io_cpu_perf_release_counter;	// Edges.scala:228:27
  always @(posedge gated_clock) begin
    automatic logic s1_probe_x12;	// Decoupled.scala:40:37
    automatic logic s1_valid_not_nacked;	// DCache.scala:167:38
    automatic logic s0_clk_en = _metaArb_io_out_valid & ~_metaArb_io_out_bits_write;	// DCache.scala:122:23, :170:{40,43}
    automatic logic _GEN_28;	// DCache.scala:291:59
    automatic logic _s2_victim_way_T;	// DCache.scala:317:29
    automatic logic s1_meta_clk_en;	// DCache.scala:329:62
    automatic logic _GEN_29;	// DCache.scala:450:54
    automatic logic advance_pstore1;	// DCache.scala:494:61
    automatic logic _io_cpu_perf_acquire_T;	// Decoupled.scala:40:37
    automatic logic _GEN_30;	// DCache.scala:215:33, :603:26, :604:24, :606:18, :607:13
    automatic logic _GEN_31;	// DCache.scala:646:26, :845:102, :861:41, :862:26
    s1_probe_x12 = tl_out_b_ready & auto_out_b_valid;	// DCache.scala:742:44, Decoupled.scala:40:37
    s1_valid_not_nacked = s1_valid & ~s1_nack;	// DCache.scala:162:21, :167:{38,41}, :543:36, :806:21, :821:24
    _GEN_28 =
      _tag_array_0_ext_RW0_rdata[19:0] == _tlb_io_resp_paddr[31:12] & ~s1_flush_valid;	// DCache.scala:117:19, :193:27, :270:99, :287:80, :289:83, :291:{59,62}, DescribedSRAM.scala:19:26
    _s2_victim_way_T = s1_valid_not_nacked | s1_flush_valid;	// DCache.scala:167:38, :193:27, :317:29
    s1_meta_clk_en = _s2_victim_way_T | s1_probe;	// DCache.scala:163:21, :317:29, :329:62
    _GEN_29 = s2_valid_hit & s2_lr & ~cached_grant_wait | s2_valid_cached_miss;	// Consts.scala:81:48, DCache.scala:201:30, :212:54, :392:69, :397:60, :450:{32,54}
    advance_pstore1 = pstore1_valid & pstore2_valid == _pstore_drain_T_11;	// DCache.scala:473:30, :479:38, :489:48, :494:{61,79}
    _io_cpu_perf_acquire_T = auto_out_a_ready & deq_valid;	// DCache.scala:576:32, Decoupled.scala:40:37
    _GEN_30 = _io_cpu_perf_acquire_T & s2_uncached;	// DCache.scala:215:33, :396:39, :603:26, :604:24, :606:18, :607:13, Decoupled.scala:40:37
    _GEN_31 = _GEN_26 & _io_cpu_perf_release_T & c_first;	// DCache.scala:646:26, :845:102, :861:41, :862:26, Decoupled.scala:40:37, Edges.scala:230:25, package.scala:72:59
    if (reset) begin
      s1_valid <= 1'h0;	// DCache.scala:117:19, :118:27, :122:23, :133:23, :162:21, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
      s1_probe <= 1'h0;	// DCache.scala:117:19, :118:27, :122:23, :133:23, :163:21, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
      cached_grant_wait <= 1'h0;	// DCache.scala:117:19, :118:27, :122:23, :133:23, :201:30, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
      resetting <= 1'h0;	// DCache.scala:117:19, :118:27, :122:23, :133:23, :202:26, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
      flushCounter <= 6'h0;	// DCache.scala:203:25
      release_ack_wait <= 1'h0;	// DCache.scala:117:19, :118:27, :122:23, :133:23, :204:29, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
      release_state <= 4'h0;	// DCache.scala:207:26
      uncachedInFlight_0 <= 1'h0;	// DCache.scala:117:19, :118:27, :122:23, :133:23, :215:33, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
      s2_valid <= 1'h0;	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :303:21, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
      s2_probe <= 1'h0;	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :305:21, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
      lrscCount <= 7'h0;	// DCache.scala:444:22, :451:21
      pstore2_valid <= 1'h0;	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, :473:30, Decoupled.scala:40:37, PRNG.scala:82:22
      pstore1_held <= 1'h0;	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, :476:29, Decoupled.scala:40:37, PRNG.scala:82:22
      counter <= 9'h0;	// Edges.scala:228:27
      grantInProgress <= 1'h0;	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, :639:28, Decoupled.scala:40:37, PRNG.scala:82:22
      blockProbeAfterGrantCount <= 3'h0;	// DCache.scala:640:38, Misc.scala:37:36
      counter_1 <= 9'h0;	// Edges.scala:228:27
      io_cpu_perf_release_counter <= 9'h0;	// Edges.scala:228:27
    end
    else begin
      automatic logic       _GEN_32 = _io_errors_bus_valid_T & grantIsCached & d_last;	// DCache.scala:603:26, :646:26, :647:26, :650:20, :651:27, Decoupled.scala:40:37, Edges.scala:231:37, package.scala:72:59
      automatic logic       _GEN_33;	// DCache.scala:806:21, :823:44, :827:37, :828:23
      automatic logic [6:0] flushCounterNext;	// DCache.scala:979:39
      _GEN_33 = _GEN_23 & _metaArb_io_in_6_ready;	// DCache.scala:122:23, :806:21, :823:{25,44}, :827:37, :828:23
      flushCounterNext = {1'h0, flushCounter} + 7'h1;	// DCache.scala:117:19, :118:27, :122:23, :133:23, :203:25, :251:33, :255:58, :321:18, :979:39, Decoupled.scala:40:37, PRNG.scala:82:22
      s1_valid <= _io_cpu_req_ready_output & io_cpu_req_valid;	// DCache.scala:162:21, :254:79, :724:68, :727:29, Decoupled.scala:40:37
      s1_probe <= _GEN_33 | s1_probe_x12;	// DCache.scala:163:21, :806:21, :823:44, :827:37, :828:23, :829:18, Decoupled.scala:40:37
      cached_grant_wait <=
        ~_GEN_32 & (_io_cpu_perf_acquire_T & ~s2_uncached | cached_grant_wait);	// DCache.scala:201:30, :396:39, :603:26, :604:24, :613:25, :646:26, :647:26, :650:20, :651:27, Decoupled.scala:40:37
      resetting <= ~(resetting & flushCounterNext[6]) & (REG | resetting);	// DCache.scala:202:26, :978:{18,27,39}, :979:39, :980:37, :1021:20, :1023:22, :1024:17
      if (resetting)	// DCache.scala:202:26
        flushCounter <= flushCounterNext[5:0];	// DCache.scala:203:25, :979:39, :1022:18
      release_ack_wait <=
        _GEN_31
        | (~_io_errors_bus_valid_T | grantIsCached | grantIsUncached | ~grantIsVoluntary)
        & release_ack_wait;	// DCache.scala:204:29, :603:26, :637:32, :646:26, :647:26, :679:36, :681:24, :845:102, :861:41, :862:26, Decoupled.scala:40:37, package.scala:72:59
      if (_metaArb_io_in_4_ready & _metaArb_io_in_4_valid_T_2)	// DCache.scala:122:23, Decoupled.scala:40:37, package.scala:72:59
        release_state <= 4'h0;	// DCache.scala:207:26
      else begin	// Decoupled.scala:40:37
        automatic logic       _release_state_T_1;	// DCache.scala:801:44
        automatic logic [3:0] _release_state_T_14;	// DCache.scala:815:29
        automatic logic       _GEN_34;	// DCache.scala:806:21, :823:44, :827:37, :828:23, :834:{26,42}
        automatic logic       _GEN_35;	// DCache.scala:806:21, :823:44, :827:37, :828:23, :832:47, :834:{26,42}
        _release_state_T_1 = (&s2_victim_state_state) & ~(s2_valid_flush_line & size[1]);	// DCache.scala:311:19, :391:75, :406:28, :800:{46,60}, :801:{44,47}, Misc.scala:55:20
        _release_state_T_14 = {1'h0, releaseDone, 2'h3};	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, :815:29, Decoupled.scala:40:37, Edges.scala:232:22, PRNG.scala:82:22, package.scala:15:47
        _GEN_34 = releaseDone | _GEN_33;	// DCache.scala:806:21, :823:44, :827:37, :828:23, :834:{26,42}, Edges.scala:232:22
        _GEN_35 = _GEN_24 & releaseDone | _GEN_33;	// DCache.scala:806:21, :823:44, :827:37, :828:23, :832:{25,47}, :834:{26,42}, Edges.scala:232:22
        if (_GEN_26) begin	// package.scala:72:59
          if (releaseDone)	// Edges.scala:232:22
            release_state <= 4'h6;	// DCache.scala:207:26, package.scala:15:47
          else if (_GEN_25) begin	// DCache.scala:836:25
            if (_GEN_24) begin	// DCache.scala:832:25
              if (_GEN_34)	// DCache.scala:806:21, :823:44, :827:37, :828:23, :834:{26,42}
                release_state <= 4'h0;	// DCache.scala:207:26
              else if (s2_probe) begin	// DCache.scala:305:21
                if (s2_meta_error)	// DCache.scala:334:53
                  release_state <= 4'h4;	// DCache.scala:207:26, :809:23
                else if (s2_prb_ack_data)	// Misc.scala:37:9
                  release_state <= 4'h2;	// DCache.scala:207:26, package.scala:15:47
                else if (|s2_probe_state_state)	// Metadata.scala:49:45, Reg.scala:15:16
                  release_state <= 4'h3;	// DCache.scala:207:26, :815:29
                else	// Metadata.scala:49:45
                  release_state <= 4'h5;	// DCache.scala:207:26, :819:29
              end
              else if (s2_want_victimize) begin	// DCache.scala:399:125
                if (_release_state_T_1)	// DCache.scala:801:44
                  release_state <= 4'h1;	// DCache.scala:207:26, package.scala:15:47
                else	// DCache.scala:801:44
                  release_state <= 4'h6;	// DCache.scala:207:26, package.scala:15:47
              end
            end
            else if (_GEN_33)	// DCache.scala:806:21, :823:44, :827:37, :828:23
              release_state <= 4'h0;	// DCache.scala:207:26
            else if (s2_probe) begin	// DCache.scala:305:21
              if (s2_meta_error)	// DCache.scala:334:53
                release_state <= 4'h4;	// DCache.scala:207:26, :809:23
              else if (s2_prb_ack_data)	// Misc.scala:37:9
                release_state <= 4'h2;	// DCache.scala:207:26, package.scala:15:47
              else if (|s2_probe_state_state)	// Metadata.scala:49:45, Reg.scala:15:16
                release_state <= 4'h3;	// DCache.scala:207:26, :815:29
              else if (releaseDone)	// Edges.scala:232:22
                release_state <= 4'h0;	// DCache.scala:207:26
              else	// Edges.scala:232:22
                release_state <= 4'h5;	// DCache.scala:207:26, :819:29
            end
            else if (s2_want_victimize) begin	// DCache.scala:399:125
              if (_release_state_T_1)	// DCache.scala:801:44
                release_state <= 4'h1;	// DCache.scala:207:26, package.scala:15:47
              else	// DCache.scala:801:44
                release_state <= 4'h6;	// DCache.scala:207:26, package.scala:15:47
            end
          end
          else if (_GEN_35)	// DCache.scala:806:21, :823:44, :827:37, :828:23, :832:47, :834:{26,42}
            release_state <= 4'h0;	// DCache.scala:207:26
          else if (s2_probe) begin	// DCache.scala:305:21
            if (s2_meta_error)	// DCache.scala:334:53
              release_state <= 4'h4;	// DCache.scala:207:26, :809:23
            else if (s2_prb_ack_data)	// Misc.scala:37:9
              release_state <= 4'h2;	// DCache.scala:207:26, package.scala:15:47
            else if (|s2_probe_state_state)	// Metadata.scala:49:45, Reg.scala:15:16
              release_state <= _release_state_T_14;	// DCache.scala:207:26, :815:29
            else if (releaseDone)	// Edges.scala:232:22
              release_state <= 4'h0;	// DCache.scala:207:26
            else	// Edges.scala:232:22
              release_state <= 4'h5;	// DCache.scala:207:26, :819:29
          end
          else if (s2_want_victimize) begin	// DCache.scala:399:125
            if (_release_state_T_1)	// DCache.scala:801:44
              release_state <= 4'h1;	// DCache.scala:207:26, package.scala:15:47
            else	// DCache.scala:801:44
              release_state <= 4'h6;	// DCache.scala:207:26, package.scala:15:47
          end
        end
        else if (_inWriteback_T_1) begin	// package.scala:15:47
          if (releaseDone)	// Edges.scala:232:22
            release_state <= 4'h7;	// DCache.scala:207:26, :815:29
          else if (_GEN_25) begin	// DCache.scala:836:25
            if (_GEN_24) begin	// DCache.scala:832:25
              if (_GEN_34)	// DCache.scala:806:21, :823:44, :827:37, :828:23, :834:{26,42}
                release_state <= 4'h0;	// DCache.scala:207:26
              else if (s2_probe) begin	// DCache.scala:305:21
                if (s2_meta_error)	// DCache.scala:334:53
                  release_state <= 4'h4;	// DCache.scala:207:26, :809:23
                else if (s2_prb_ack_data)	// Misc.scala:37:9
                  release_state <= 4'h2;	// DCache.scala:207:26, package.scala:15:47
                else if (|s2_probe_state_state)	// Metadata.scala:49:45, Reg.scala:15:16
                  release_state <= 4'h3;	// DCache.scala:207:26, :815:29
                else	// Metadata.scala:49:45
                  release_state <= 4'h5;	// DCache.scala:207:26, :819:29
              end
              else if (s2_want_victimize) begin	// DCache.scala:399:125
                if (_release_state_T_1)	// DCache.scala:801:44
                  release_state <= 4'h1;	// DCache.scala:207:26, package.scala:15:47
                else	// DCache.scala:801:44
                  release_state <= 4'h6;	// DCache.scala:207:26, package.scala:15:47
              end
            end
            else if (_GEN_33)	// DCache.scala:806:21, :823:44, :827:37, :828:23
              release_state <= 4'h0;	// DCache.scala:207:26
            else if (s2_probe) begin	// DCache.scala:305:21
              if (s2_meta_error)	// DCache.scala:334:53
                release_state <= 4'h4;	// DCache.scala:207:26, :809:23
              else if (s2_prb_ack_data)	// Misc.scala:37:9
                release_state <= 4'h2;	// DCache.scala:207:26, package.scala:15:47
              else if (|s2_probe_state_state)	// Metadata.scala:49:45, Reg.scala:15:16
                release_state <= 4'h3;	// DCache.scala:207:26, :815:29
              else if (releaseDone)	// Edges.scala:232:22
                release_state <= 4'h0;	// DCache.scala:207:26
              else	// Edges.scala:232:22
                release_state <= 4'h5;	// DCache.scala:207:26, :819:29
            end
            else if (s2_want_victimize) begin	// DCache.scala:399:125
              if (_release_state_T_1)	// DCache.scala:801:44
                release_state <= 4'h1;	// DCache.scala:207:26, package.scala:15:47
              else	// DCache.scala:801:44
                release_state <= 4'h6;	// DCache.scala:207:26, package.scala:15:47
            end
          end
          else if (_GEN_35)	// DCache.scala:806:21, :823:44, :827:37, :828:23, :832:47, :834:{26,42}
            release_state <= 4'h0;	// DCache.scala:207:26
          else if (s2_probe) begin	// DCache.scala:305:21
            if (s2_meta_error)	// DCache.scala:334:53
              release_state <= 4'h4;	// DCache.scala:207:26, :809:23
            else if (s2_prb_ack_data)	// Misc.scala:37:9
              release_state <= 4'h2;	// DCache.scala:207:26, package.scala:15:47
            else if (|s2_probe_state_state)	// Metadata.scala:49:45, Reg.scala:15:16
              release_state <= _release_state_T_14;	// DCache.scala:207:26, :815:29
            else if (releaseDone)	// Edges.scala:232:22
              release_state <= 4'h0;	// DCache.scala:207:26
            else	// Edges.scala:232:22
              release_state <= 4'h5;	// DCache.scala:207:26, :819:29
          end
          else if (s2_want_victimize) begin	// DCache.scala:399:125
            if (_release_state_T_1)	// DCache.scala:801:44
              release_state <= 4'h1;	// DCache.scala:207:26, package.scala:15:47
            else	// DCache.scala:801:44
              release_state <= 4'h6;	// DCache.scala:207:26, package.scala:15:47
          end
        end
        else if (_GEN_25) begin	// DCache.scala:836:25
          if (releaseDone)	// Edges.scala:232:22
            release_state <= 4'h7;	// DCache.scala:207:26, :815:29
          else if (_GEN_35)	// DCache.scala:806:21, :823:44, :827:37, :828:23, :832:47, :834:{26,42}
            release_state <= 4'h0;	// DCache.scala:207:26
          else if (s2_probe) begin	// DCache.scala:305:21
            if (s2_meta_error)	// DCache.scala:334:53
              release_state <= 4'h4;	// DCache.scala:207:26, :809:23
            else if (s2_prb_ack_data)	// Misc.scala:37:9
              release_state <= 4'h2;	// DCache.scala:207:26, package.scala:15:47
            else if (|s2_probe_state_state)	// Metadata.scala:49:45, Reg.scala:15:16
              release_state <= 4'h3;	// DCache.scala:207:26, :815:29
            else	// Metadata.scala:49:45
              release_state <= 4'h5;	// DCache.scala:207:26, :819:29
          end
          else if (s2_want_victimize) begin	// DCache.scala:399:125
            if (_release_state_T_1)	// DCache.scala:801:44
              release_state <= 4'h1;	// DCache.scala:207:26, package.scala:15:47
            else	// DCache.scala:801:44
              release_state <= 4'h6;	// DCache.scala:207:26, package.scala:15:47
          end
        end
        else if (_GEN_35)	// DCache.scala:806:21, :823:44, :827:37, :828:23, :832:47, :834:{26,42}
          release_state <= 4'h0;	// DCache.scala:207:26
        else if (s2_probe) begin	// DCache.scala:305:21
          if (s2_meta_error)	// DCache.scala:334:53
            release_state <= 4'h4;	// DCache.scala:207:26, :809:23
          else if (s2_prb_ack_data)	// Misc.scala:37:9
            release_state <= 4'h2;	// DCache.scala:207:26, package.scala:15:47
          else if (|s2_probe_state_state)	// Metadata.scala:49:45, Reg.scala:15:16
            release_state <= _release_state_T_14;	// DCache.scala:207:26, :815:29
          else if (releaseDone)	// Edges.scala:232:22
            release_state <= 4'h0;	// DCache.scala:207:26
          else	// Edges.scala:232:22
            release_state <= 4'h5;	// DCache.scala:207:26, :819:29
        end
        else if (s2_want_victimize) begin	// DCache.scala:399:125
          if (_release_state_T_1)	// DCache.scala:801:44
            release_state <= 4'h1;	// DCache.scala:207:26, package.scala:15:47
          else	// DCache.scala:801:44
            release_state <= 4'h6;	// DCache.scala:207:26, package.scala:15:47
        end
      end
      uncachedInFlight_0 <=
        (~_io_errors_bus_valid_T | grantIsCached | ~(grantIsUncached & _GEN_16))
        & (_GEN_30 | uncachedInFlight_0);	// DCache.scala:215:33, :603:26, :604:24, :606:18, :607:13, :646:26, :647:26, :656:35, :658:{17,28}, :660:13, Decoupled.scala:40:37, package.scala:72:59
      s2_valid <= s1_valid & ~io_cpu_s1_kill & s1_req_cmd != 5'h14;	// DCache.scala:162:21, :166:37, :191:30, :303:{21,43}, Reg.scala:15:16
      s2_probe <= s1_probe;	// DCache.scala:163:21, :305:21
      if (s1_probe)	// DCache.scala:163:21
        lrscCount <= 7'h0;	// DCache.scala:444:22, :451:21
      else if (s2_valid_masked & (|(lrscCount[6:2])))	// DCache.scala:309:42, :444:22, :445:29, :455:29
        lrscCount <= 7'h3;	// DCache.scala:444:22, :455:55
      else if (|lrscCount)	// DCache.scala:444:22, :446:34
        lrscCount <= lrscCount - 7'h1;	// DCache.scala:444:22, :454:49
      else if (_GEN_29) begin	// DCache.scala:450:54
        if (s2_hit)	// Misc.scala:34:9
          lrscCount <= 7'h4F;	// DCache.scala:444:22, :451:21
        else	// Misc.scala:34:9
          lrscCount <= 7'h0;	// DCache.scala:444:22, :451:21
      end
      pstore2_valid <= pstore2_valid & ~_pstore_drain_T_11 | advance_pstore1;	// DCache.scala:473:30, :489:48, :493:91, :494:61, :495:{34,51}
      pstore1_held <=
        (_pstore1_held_T & ~s2_sc_fail | pstore1_held) & pstore2_valid
        & ~_pstore_drain_T_11;	// DCache.scala:449:26, :462:{46,58,61}, :473:30, :476:29, :489:48, :493:{54,88,91}
      if (_io_errors_bus_valid_T) begin	// Decoupled.scala:40:37
        if (|counter)	// Edges.scala:228:27, :230:25
          counter <= _counter1_T;	// Edges.scala:228:27, :229:28
        else if (auto_out_d_bits_opcode[0])	// Edges.scala:105:36
          counter <= ~(_beats1_decode_T_1[11:3]);	// Edges.scala:228:27, package.scala:234:{46,77,82}
        else	// Edges.scala:105:36
          counter <= 9'h0;	// Edges.scala:228:27
      end
      if (_GEN_15)	// DCache.scala:647:26
        grantInProgress <= ~d_last;	// DCache.scala:109:25, :136:24, :639:28, :648:23, :650:20, :652:25, Edges.scala:231:37
      if (_GEN_32)	// DCache.scala:603:26, :646:26, :647:26, :650:20, :651:27
        blockProbeAfterGrantCount <= 3'h7;	// Consts.scala:81:65, DCache.scala:640:38
      else if (|blockProbeAfterGrantCount)	// DCache.scala:640:38, :641:35
        blockProbeAfterGrantCount <= blockProbeAfterGrantCount - 3'h1;	// DCache.scala:640:38, :641:97
      if (_io_cpu_perf_release_T) begin	// Decoupled.scala:40:37
        if (c_first) begin	// Edges.scala:230:25
          if (tl_out_c_bits_opcode[0])	// DCache.scala:841:48, :845:102, :846:52, Edges.scala:101:36
            counter_1 <= ~(_beats1_decode_T_5[11:3]);	// Edges.scala:228:27, package.scala:234:{46,77,82}
          else	// Edges.scala:101:36
            counter_1 <= 9'h0;	// Edges.scala:228:27
        end
        else	// Edges.scala:230:25
          counter_1 <= _counter1_T_1;	// Edges.scala:228:27, :229:28
        if (io_cpu_perf_release_counter == 9'h0) begin	// Edges.scala:228:27, :230:25
          if (tl_out_c_bits_opcode[0])	// DCache.scala:841:48, :845:102, :846:52, Edges.scala:101:36
            io_cpu_perf_release_counter <=
              ~(_io_cpu_perf_release_beats1_decode_T_1[11:3]);	// Edges.scala:228:27, package.scala:234:{46,77,82}
          else	// Edges.scala:101:36
            io_cpu_perf_release_counter <= 9'h0;	// Edges.scala:228:27
        end
        else	// Edges.scala:230:25
          io_cpu_perf_release_counter <= io_cpu_perf_release_counter - 9'h1;	// Edges.scala:228:27, :229:28
      end
    end
    if (s2_want_victimize) begin	// DCache.scala:399:125
      probe_bits_param <= 2'h0;	// DCache.scala:117:19, :118:27, Reg.scala:15:16
      probe_bits_size <= 4'h0;	// Reg.scala:15:16
      probe_bits_address <=
        {s2_valid_flush_line ? s2_req_addr[31:12] : s2_meta_corrected_r[19:0],
         s2_req_addr[11:6],
         6'h0};	// DCache.scala:311:19, :333:99, :391:75, :405:{26,82}, :804:{76,96}, Reg.scala:15:16
    end
    else if (s1_probe_x12) begin	// Decoupled.scala:40:37
      probe_bits_param <= auto_out_b_bits_param;	// Reg.scala:15:16
      probe_bits_size <= auto_out_b_bits_size;	// Reg.scala:15:16
      probe_bits_address <= auto_out_b_bits_address;	// Reg.scala:15:16
    end
    probe_bits_source <=
      ~s2_want_victimize & (s1_probe_x12 ? auto_out_b_bits_source : probe_bits_source);	// DCache.scala:399:125, :798:25, :804:18, Decoupled.scala:40:37, Reg.scala:15:16, :16:{19,23}
    if (s0_clk_en) begin	// DCache.scala:170:40
      automatic logic [33:0] s0_tlb_req_vaddr =
        {_metaArb_io_out_bits_addr[33:6], io_cpu_req_bits_addr[5:0]};	// Cat.scala:30:58, DCache.scala:122:23, :173:{47,84}
      s1_vaddr <= s0_tlb_req_vaddr;	// Cat.scala:30:58, Reg.scala:15:16
      s1_req_tag <= io_cpu_req_bits_tag;	// Reg.scala:15:16
      s1_req_cmd <= io_cpu_req_bits_cmd;	// Reg.scala:15:16
      s1_req_size <= io_cpu_req_bits_size;	// Reg.scala:15:16
      s1_req_signed <= io_cpu_req_bits_signed;	// Reg.scala:15:16
      s1_req_phys <= ~_metaArb_io_in_7_ready;	// DCache.scala:122:23, :175:9, Reg.scala:15:16
      s1_tlb_req_vaddr <= s0_tlb_req_vaddr;	// Cat.scala:30:58, Reg.scala:15:16
      s1_tlb_req_size <= io_cpu_req_bits_size;	// Reg.scala:15:16
      s1_tlb_req_cmd <= io_cpu_req_bits_cmd;	// Reg.scala:15:16
      s1_did_read <=
        _dataArb_io_in_3_ready & io_cpu_req_valid
        & (_pstore_drain_opportunistic_T | _pstore_drain_opportunistic_T_1
           | _pstore_drain_opportunistic_T_26 | _pstore_drain_opportunistic_T_28
           | _pstore_drain_opportunistic_T_29 | _pstore_drain_opportunistic_T_30
           | _pstore_drain_opportunistic_T_31 | _pstore_drain_opportunistic_T_35
           | _pstore_drain_opportunistic_T_36 | _pstore_drain_opportunistic_T_37
           | _pstore_drain_opportunistic_T_38 | _pstore_drain_opportunistic_T_39
           | (_pstore_drain_opportunistic_T_23 | _pstore_drain_opportunistic_T_48
              | _pstore_drain_opportunistic_T_26 | _pstore_drain_opportunistic_T_28
              | _pstore_drain_opportunistic_T_29 | _pstore_drain_opportunistic_T_30
              | _pstore_drain_opportunistic_T_31 | _pstore_drain_opportunistic_T_35
              | _pstore_drain_opportunistic_T_36 | _pstore_drain_opportunistic_T_37
              | _pstore_drain_opportunistic_T_38 | _pstore_drain_opportunistic_T_39)
           & _pstore_drain_opportunistic_T_48);	// Consts.scala:81:{31,48,65}, :82:{49,76}, DCache.scala:133:23, :238:54, :1160:21, :1161:23, Reg.scala:15:16, package.scala:15:47
    end
    s1_req_no_alloc <= ~s0_clk_en & s1_req_no_alloc;	// DCache.scala:170:40, Reg.scala:15:16, :16:{19,23}
    s1_req_no_xcpt <= ~s0_clk_en & s1_req_no_xcpt;	// DCache.scala:170:40, Reg.scala:15:16, :16:{19,23}
    s1_flush_valid <= 1'h0;	// DCache.scala:117:19, :118:27, :122:23, :133:23, :193:27, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
    if (_GEN_31) begin	// DCache.scala:646:26, :845:102, :861:41, :862:26
      release_ack_dirty <= inWriteback;	// DCache.scala:205:30, package.scala:72:59
      release_ack_addr <= probe_bits_address;	// DCache.scala:206:29, Reg.scala:15:16
    end
    if (_GEN_30) begin	// DCache.scala:215:33, :603:26, :604:24, :606:18, :607:13
      uncachedReqs_0_addr <= s2_req_addr;	// DCache.scala:216:25, :311:19
      uncachedReqs_0_tag <= s2_req_tag;	// DCache.scala:216:25, :311:19
      uncachedReqs_0_size <= size;	// DCache.scala:216:25, :311:19
      uncachedReqs_0_signed <= s2_req_signed;	// DCache.scala:216:25, :311:19
    end
    s1_read_mask <= s0_clk_en | s1_read_mask;	// DCache.scala:170:40, Reg.scala:15:16, :16:{19,23}
    s2_not_nacked_in_s1 <= ~s1_nack;	// DCache.scala:167:41, :307:36, :543:36, :806:21, :821:24
    if (_GEN_17) begin	// DCache.scala:317:48, :646:26, :647:26
      if (_s2_victim_way_T) begin	// DCache.scala:317:29
        s2_req_addr <= {2'h0, _tlb_io_resp_paddr[31:12], s1_vaddr[11:0]};	// DCache.scala:117:19, :118:27, :177:78, :270:99, :311:19, :319:17, Reg.scala:15:16
        s2_req_tag <= s1_req_tag;	// DCache.scala:311:19, Reg.scala:15:16
        s2_req_cmd <= s1_req_cmd;	// DCache.scala:311:19, Reg.scala:15:16
        size <= s1_req_size;	// DCache.scala:311:19, Reg.scala:15:16
        s2_req_signed <= s1_req_signed;	// DCache.scala:311:19, Reg.scala:15:16
      end
    end
    else begin	// DCache.scala:317:48, :646:26, :647:26
      s2_req_addr <=
        {2'h0, _tlb_io_resp_paddr[31:12], s1_vaddr[11:3], uncachedReqs_0_addr[2:0]};	// DCache.scala:117:19, :118:27, :216:25, :270:99, :311:19, :671:23, :673:41, :674:45, Reg.scala:15:16
      s2_req_tag <= uncachedReqs_0_tag;	// DCache.scala:216:25, :311:19
      s2_req_cmd <= 5'h0;	// DCache.scala:311:19
      size <= uncachedReqs_0_size;	// DCache.scala:216:25, :311:19
      s2_req_signed <= uncachedReqs_0_signed;	// DCache.scala:216:25, :311:19
    end
    if (_s2_victim_way_T) begin	// DCache.scala:317:29
      s2_req_no_alloc <= s1_req_no_alloc;	// DCache.scala:311:19, Reg.scala:15:16
      s2_req_no_xcpt <= s1_req_no_xcpt;	// DCache.scala:311:19, Reg.scala:15:16
      s2_tlb_xcpt_pf_ld <= _tlb_io_resp_pf_ld;	// DCache.scala:117:19, :314:24
      s2_tlb_xcpt_pf_st <= _tlb_io_resp_pf_st;	// DCache.scala:117:19, :314:24
      s2_tlb_xcpt_ae_ld <= _tlb_io_resp_ae_ld;	// DCache.scala:117:19, :314:24
      s2_tlb_xcpt_ae_st <= _tlb_io_resp_ae_st;	// DCache.scala:117:19, :314:24
      s2_tlb_xcpt_ma_ld <= _tlb_io_resp_ma_ld;	// DCache.scala:117:19, :314:24
      s2_tlb_xcpt_ma_st <= _tlb_io_resp_ma_st;	// DCache.scala:117:19, :314:24
      s2_pma_cacheable <= _tlb_io_resp_cacheable;	// DCache.scala:117:19, :315:19
      s2_pma_must_alloc <= _tlb_io_resp_must_alloc;	// DCache.scala:117:19, :315:19
      s2_vaddr_r <= s1_vaddr;	// Reg.scala:15:16
      if (_GEN_28)	// DCache.scala:291:59
        s2_hit_state_state <= _tag_array_0_ext_RW0_rdata[21:20];	// DCache.scala:287:80, DescribedSRAM.scala:19:26, Reg.scala:15:16
      else	// DCache.scala:291:59
        s2_hit_state_state <= 2'h0;	// DCache.scala:117:19, :118:27, Reg.scala:15:16
    end
    s2_flush_valid_pre_tag_ecc <= s1_flush_valid;	// DCache.scala:193:27, :327:43
    s2_meta_correctable_errors <= ~s1_meta_clk_en & s2_meta_correctable_errors;	// DCache.scala:329:62, Reg.scala:15:16, :16:{19,23}
    s2_meta_error_uncorrectable <= ~s1_meta_clk_en & s2_meta_error_uncorrectable;	// DCache.scala:329:62, Reg.scala:15:16, :16:{19,23}
    if (s1_meta_clk_en)	// DCache.scala:329:62
      s2_meta_corrected_r <= _tag_array_0_ext_RW0_rdata;	// DescribedSRAM.scala:19:26, Reg.scala:15:16
    if (s1_valid | inWriteback | _io_cpu_replay_next_output) begin	// DCache.scala:162:21, :338:38, :920:41, package.scala:72:59
      automatic logic [1:0] _s2_data_T_1;	// DCache.scala:351:28
      _s2_data_T_1 =
        _io_cpu_replay_next_output | inWriteback | s1_did_read & s1_read_mask
          ? (_GEN_17 ? 2'h1 : 2'h2)
          : 2'h0;	// AMOALU.scala:17:57, Cat.scala:30:58, DCache.scala:117:19, :118:27, :339:63, :349:27, :351:28, :646:26, :647:26, :920:41, Reg.scala:15:16, package.scala:72:59
      s2_data <=
        (_s2_data_T_1[0] ? _data_io_resp_0 : 64'h0)
        | (_s2_data_T_1[1] ? auto_out_d_bits_data : 64'h0);	// DCache.scala:132:20, :351:28, Mux.scala:27:72, :29:36, Reg.scala:15:16
    end
    if (s1_probe) begin	// DCache.scala:163:21
      if (_GEN_28)	// DCache.scala:291:59
        s2_probe_state_state <= _tag_array_0_ext_RW0_rdata[21:20];	// DCache.scala:287:80, DescribedSRAM.scala:19:26, Reg.scala:15:16
      else	// DCache.scala:291:59
        s2_probe_state_state <= 2'h0;	// DCache.scala:117:19, :118:27, Reg.scala:15:16
    end
    s2_waw_hazard <= ~s1_valid_not_nacked & s2_waw_hazard;	// DCache.scala:167:38, Reg.scala:15:16, :16:{19,23}
    if (_GEN_29)	// DCache.scala:450:54
      lrscAddr <= s2_req_addr[33:6];	// DCache.scala:311:19, :447:21, :448:49
    if (s1_valid_not_nacked & s1_write) begin	// Consts.scala:82:76, DCache.scala:167:38, :464:63
      pstore1_cmd <= s1_req_cmd;	// Reg.scala:15:16
      pstore1_addr <= s1_vaddr;	// Reg.scala:15:16
      pstore1_data <= io_cpu_s1_data_data;	// Reg.scala:15:16
      if (_io_cpu_perf_canAcceptLoadThenLoad_T_49)	// Consts.scala:82:49
        pstore1_mask <= 8'h0;	// DCache.scala:118:27, Reg.scala:15:16
      else	// Consts.scala:82:49
        pstore1_mask <= s1_mask_xwr;	// Cat.scala:30:58, Reg.scala:15:16
      pstore1_rmw <=
        _io_cpu_perf_canAcceptLoadThenLoad_T_1 | _io_cpu_perf_canAcceptLoadThenLoad_T_2
        | _io_cpu_perf_canAcceptLoadThenLoad_T_27
        | _io_cpu_perf_canAcceptLoadThenLoad_T_29
        | _io_cpu_perf_canAcceptLoadThenLoad_T_30
        | _io_cpu_perf_canAcceptLoadThenLoad_T_31
        | _io_cpu_perf_canAcceptLoadThenLoad_T_32
        | _io_cpu_perf_canAcceptLoadThenLoad_T_36
        | _io_cpu_perf_canAcceptLoadThenLoad_T_37
        | _io_cpu_perf_canAcceptLoadThenLoad_T_38
        | _io_cpu_perf_canAcceptLoadThenLoad_T_39
        | _io_cpu_perf_canAcceptLoadThenLoad_T_40
        | (_io_cpu_perf_canAcceptLoadThenLoad_T_24
           | _io_cpu_perf_canAcceptLoadThenLoad_T_49
           | _io_cpu_perf_canAcceptLoadThenLoad_T_27
           | _io_cpu_perf_canAcceptLoadThenLoad_T_29
           | _io_cpu_perf_canAcceptLoadThenLoad_T_30
           | _io_cpu_perf_canAcceptLoadThenLoad_T_31
           | _io_cpu_perf_canAcceptLoadThenLoad_T_32
           | _io_cpu_perf_canAcceptLoadThenLoad_T_36
           | _io_cpu_perf_canAcceptLoadThenLoad_T_37
           | _io_cpu_perf_canAcceptLoadThenLoad_T_38
           | _io_cpu_perf_canAcceptLoadThenLoad_T_39
           | _io_cpu_perf_canAcceptLoadThenLoad_T_40)
        & _io_cpu_perf_canAcceptLoadThenLoad_T_49;	// Consts.scala:81:{31,48,65}, :82:{32,49,76}, DCache.scala:1160:21, :1161:23, Reg.scala:15:16, package.scala:15:47
    end
    pstore_drain_on_miss_REG <= _io_cpu_s2_nack_output;	// DCache.scala:417:86, :475:56
    if (advance_pstore1) begin	// DCache.scala:494:61
      pstore2_addr <= pstore1_addr;	// Reg.scala:15:16
      pstore2_storegen_data_lo_lo_lo <= _amoalu_io_out[7:0];	// DCache.scala:500:44, :952:26, Reg.scala:15:16
      pstore2_storegen_data_lo_lo_hi <= _amoalu_io_out[15:8];	// DCache.scala:500:44, :952:26, Reg.scala:15:16
      pstore2_storegen_data_lo_hi_lo <= _amoalu_io_out[23:16];	// DCache.scala:500:44, :952:26, Reg.scala:15:16
      pstore2_storegen_data_lo_hi_hi <= _amoalu_io_out[31:24];	// DCache.scala:500:44, :952:26, Reg.scala:15:16
      pstore2_storegen_data_hi_lo_lo <= _amoalu_io_out[39:32];	// DCache.scala:500:44, :952:26, Reg.scala:15:16
      pstore2_storegen_data_hi_lo_hi <= _amoalu_io_out[47:40];	// DCache.scala:500:44, :952:26, Reg.scala:15:16
      pstore2_storegen_data_hi_hi_lo <= _amoalu_io_out[55:48];	// DCache.scala:500:44, :952:26, Reg.scala:15:16
      pstore2_storegen_data_hi_hi_hi <= _amoalu_io_out[63:56];	// DCache.scala:500:44, :952:26, Reg.scala:15:16
      mask <= pstore1_mask;	// DCache.scala:503:19, Reg.scala:15:16
    end
    if (_GEN_20)	// DCache.scala:693:26, :724:68, :727:29, :729:32
      blockUncachedGrant <= ~_dataArb_io_in_1_ready;	// DCache.scala:133:23, :694:26, :722:33
    else	// DCache.scala:693:26, :724:68, :727:29, :729:32
      blockUncachedGrant <= _dataArb_io_out_valid;	// DCache.scala:133:23, :722:33
    s1_release_data_valid <= _dataArb_io_in_2_ready & _dataArb_io_in_2_valid_T_1;	// DCache.scala:133:23, :773:34, :873:41, Decoupled.scala:40:37
    s2_release_data_valid <= s1_release_data_valid & ~releaseRejected;	// DCache.scala:773:34, :774:{34,64,67}, :775:44
    io_cpu_s2_xcpt_REG <=
      s1_valid & ~io_cpu_s1_kill
      & (s1_read | s1_write | s1_req_cmd == 5'h5 & s1_req_size[0] | s1_req_cmd == 5'h17)
      & ~s1_req_no_xcpt & ~s1_nack;	// Consts.scala:81:75, :82:76, DCache.scala:162:21, :166:37, :167:41, :192:{34,50,64}, :249:{55,69}, :543:36, :806:21, :821:24, :900:35, :902:65, :903:32, Reg.scala:15:16
    doUncachedResp <= _io_cpu_replay_next_output;	// DCache.scala:918:27, :920:41
    REG <= reset;	// DCache.scala:978:18
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:41];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [5:0] i = 6'h0; i < 6'h2A; i += 6'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        s1_valid = _RANDOM[6'h0][1];	// DCache.scala:162:21
        s1_probe = _RANDOM[6'h0][2];	// DCache.scala:162:21, :163:21
        probe_bits_param = _RANDOM[6'h0][7:6];	// DCache.scala:162:21, Reg.scala:15:16
        probe_bits_size = _RANDOM[6'h0][11:8];	// DCache.scala:162:21, Reg.scala:15:16
        probe_bits_source = _RANDOM[6'h0][12];	// DCache.scala:162:21, Reg.scala:15:16
        probe_bits_address = {_RANDOM[6'h0][31:13], _RANDOM[6'h1][12:0]};	// DCache.scala:162:21, Reg.scala:15:16
        s1_vaddr = {_RANDOM[6'h3][31:24], _RANDOM[6'h4][25:0]};	// Reg.scala:15:16
        s1_req_tag = _RANDOM[6'h4][31:26];	// Reg.scala:15:16
        s1_req_cmd = _RANDOM[6'h5][4:0];	// Reg.scala:15:16
        s1_req_size = _RANDOM[6'h5][6:5];	// Reg.scala:15:16
        s1_req_signed = _RANDOM[6'h5][7];	// Reg.scala:15:16
        s1_req_phys = _RANDOM[6'h5][10];	// Reg.scala:15:16
        s1_req_no_alloc = _RANDOM[6'h5][11];	// Reg.scala:15:16
        s1_req_no_xcpt = _RANDOM[6'h5][12];	// Reg.scala:15:16
        s1_tlb_req_vaddr = {_RANDOM[6'h7][31:21], _RANDOM[6'h8][22:0]};	// Reg.scala:15:16
        s1_tlb_req_size = _RANDOM[6'h8][25:24];	// Reg.scala:15:16
        s1_tlb_req_cmd = _RANDOM[6'h8][30:26];	// Reg.scala:15:16
        s1_flush_valid = _RANDOM[6'h8][31];	// DCache.scala:193:27, Reg.scala:15:16
        cached_grant_wait = _RANDOM[6'hC][31];	// DCache.scala:201:30
        resetting = _RANDOM[6'hD][0];	// DCache.scala:202:26
        flushCounter = _RANDOM[6'hD][6:1];	// DCache.scala:202:26, :203:25
        release_ack_wait = _RANDOM[6'hD][7];	// DCache.scala:202:26, :204:29
        release_ack_dirty = _RANDOM[6'hD][8];	// DCache.scala:202:26, :205:30
        release_ack_addr = {_RANDOM[6'hD][31:9], _RANDOM[6'hE][8:0]};	// DCache.scala:202:26, :206:29
        release_state = _RANDOM[6'hE][12:9];	// DCache.scala:206:29, :207:26
        uncachedInFlight_0 = _RANDOM[6'hE][15];	// DCache.scala:206:29, :215:33
        uncachedReqs_0_addr = {_RANDOM[6'hE][31:16], _RANDOM[6'hF][17:0]};	// DCache.scala:206:29, :216:25
        uncachedReqs_0_tag = _RANDOM[6'hF][23:18];	// DCache.scala:216:25
        uncachedReqs_0_size = _RANDOM[6'hF][30:29];	// DCache.scala:216:25
        uncachedReqs_0_signed = _RANDOM[6'hF][31];	// DCache.scala:216:25
        s1_did_read = _RANDOM[6'h12][13];	// Reg.scala:15:16
        s1_read_mask = _RANDOM[6'h12][14];	// Reg.scala:15:16
        s2_valid = _RANDOM[6'h12][15];	// DCache.scala:303:21, Reg.scala:15:16
        s2_probe = _RANDOM[6'h12][16];	// DCache.scala:305:21, Reg.scala:15:16
        s2_not_nacked_in_s1 = _RANDOM[6'h12][17];	// DCache.scala:307:36, Reg.scala:15:16
        s2_req_addr = {_RANDOM[6'h12][31:18], _RANDOM[6'h13][19:0]};	// DCache.scala:311:19, Reg.scala:15:16
        s2_req_tag = _RANDOM[6'h13][25:20];	// DCache.scala:311:19
        s2_req_cmd = _RANDOM[6'h13][30:26];	// DCache.scala:311:19
        size = {_RANDOM[6'h13][31], _RANDOM[6'h14][0]};	// DCache.scala:311:19
        s2_req_signed = _RANDOM[6'h14][1];	// DCache.scala:311:19
        s2_req_no_alloc = _RANDOM[6'h14][5];	// DCache.scala:311:19
        s2_req_no_xcpt = _RANDOM[6'h14][6];	// DCache.scala:311:19
        s2_tlb_xcpt_pf_ld = _RANDOM[6'h17][16];	// DCache.scala:314:24
        s2_tlb_xcpt_pf_st = _RANDOM[6'h17][17];	// DCache.scala:314:24
        s2_tlb_xcpt_ae_ld = _RANDOM[6'h17][19];	// DCache.scala:314:24
        s2_tlb_xcpt_ae_st = _RANDOM[6'h17][20];	// DCache.scala:314:24
        s2_tlb_xcpt_ma_ld = _RANDOM[6'h17][22];	// DCache.scala:314:24
        s2_tlb_xcpt_ma_st = _RANDOM[6'h17][23];	// DCache.scala:314:24
        s2_pma_cacheable = _RANDOM[6'h19][6];	// DCache.scala:315:19
        s2_pma_must_alloc = _RANDOM[6'h19][7];	// DCache.scala:315:19
        s2_vaddr_r = {_RANDOM[6'h1A][31:11], _RANDOM[6'h1B][12:0]};	// Reg.scala:15:16
        s2_flush_valid_pre_tag_ecc = _RANDOM[6'h1B][13];	// DCache.scala:327:43, Reg.scala:15:16
        s2_meta_correctable_errors = _RANDOM[6'h1B][14];	// Reg.scala:15:16
        s2_meta_error_uncorrectable = _RANDOM[6'h1B][15];	// Reg.scala:15:16
        s2_meta_corrected_r = {_RANDOM[6'h1B][31:16], _RANDOM[6'h1C][5:0]};	// Reg.scala:15:16
        s2_data = {_RANDOM[6'h1C][31:6], _RANDOM[6'h1D], _RANDOM[6'h1E][5:0]};	// Reg.scala:15:16
        s2_probe_state_state = _RANDOM[6'h1E][8:7];	// Reg.scala:15:16
        s2_hit_state_state = _RANDOM[6'h1E][11:10];	// Reg.scala:15:16
        s2_waw_hazard = _RANDOM[6'h1E][12];	// Reg.scala:15:16
        lrscCount = _RANDOM[6'h1E][20:14];	// DCache.scala:444:22, Reg.scala:15:16
        lrscAddr = {_RANDOM[6'h1E][31:21], _RANDOM[6'h1F][16:0]};	// DCache.scala:447:21, Reg.scala:15:16
        pstore1_cmd = _RANDOM[6'h1F][22:18];	// DCache.scala:447:21, Reg.scala:15:16
        pstore1_addr = {_RANDOM[6'h1F][31:23], _RANDOM[6'h20][24:0]};	// DCache.scala:447:21, Reg.scala:15:16
        pstore1_data = {_RANDOM[6'h20][31:25], _RANDOM[6'h21], _RANDOM[6'h22][24:0]};	// Reg.scala:15:16
        pstore1_mask = {_RANDOM[6'h22][31:26], _RANDOM[6'h23][1:0]};	// Reg.scala:15:16
        pstore1_rmw = _RANDOM[6'h23][2];	// Reg.scala:15:16
        pstore2_valid = _RANDOM[6'h23][3];	// DCache.scala:473:30, Reg.scala:15:16
        pstore_drain_on_miss_REG = _RANDOM[6'h23][4];	// DCache.scala:475:56, Reg.scala:15:16
        pstore1_held = _RANDOM[6'h23][5];	// DCache.scala:476:29, Reg.scala:15:16
        pstore2_addr = {_RANDOM[6'h23][31:6], _RANDOM[6'h24][7:0]};	// Reg.scala:15:16
        pstore2_storegen_data_lo_lo_lo = _RANDOM[6'h24][16:9];	// Reg.scala:15:16
        pstore2_storegen_data_lo_lo_hi = _RANDOM[6'h24][24:17];	// Reg.scala:15:16
        pstore2_storegen_data_lo_hi_lo = {_RANDOM[6'h24][31:25], _RANDOM[6'h25][0]};	// Reg.scala:15:16
        pstore2_storegen_data_lo_hi_hi = _RANDOM[6'h25][8:1];	// Reg.scala:15:16
        pstore2_storegen_data_hi_lo_lo = _RANDOM[6'h25][16:9];	// Reg.scala:15:16
        pstore2_storegen_data_hi_lo_hi = _RANDOM[6'h25][24:17];	// Reg.scala:15:16
        pstore2_storegen_data_hi_hi_lo = {_RANDOM[6'h25][31:25], _RANDOM[6'h26][0]};	// Reg.scala:15:16
        pstore2_storegen_data_hi_hi_hi = _RANDOM[6'h26][8:1];	// Reg.scala:15:16
        mask = _RANDOM[6'h26][16:9];	// DCache.scala:503:19, Reg.scala:15:16
        counter = _RANDOM[6'h26][26:18];	// Edges.scala:228:27, Reg.scala:15:16
        grantInProgress = _RANDOM[6'h26][27];	// DCache.scala:639:28, Reg.scala:15:16
        blockProbeAfterGrantCount = _RANDOM[6'h26][30:28];	// DCache.scala:640:38, Reg.scala:15:16
        blockUncachedGrant = _RANDOM[6'h26][31];	// DCache.scala:722:33, Reg.scala:15:16
        counter_1 = _RANDOM[6'h27][8:0];	// Edges.scala:228:27
        s1_release_data_valid = _RANDOM[6'h27][9];	// DCache.scala:773:34, Edges.scala:228:27
        s2_release_data_valid = _RANDOM[6'h27][10];	// DCache.scala:774:34, Edges.scala:228:27
        io_cpu_s2_xcpt_REG = _RANDOM[6'h27][11];	// DCache.scala:903:32, Edges.scala:228:27
        doUncachedResp = _RANDOM[6'h29][12];	// DCache.scala:918:27
        REG = _RANDOM[6'h29][13];	// DCache.scala:918:27, :978:18
        io_cpu_perf_release_counter = _RANDOM[6'h29][31:23];	// DCache.scala:918:27, Edges.scala:228:27
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  TLB_4 tlb (	// DCache.scala:117:19
    .io_req_bits_vaddr         (s1_tlb_req_vaddr),	// Reg.scala:15:16
    .io_req_bits_size          (s1_tlb_req_size),	// Reg.scala:15:16
    .io_req_bits_cmd           (s1_tlb_req_cmd),	// Reg.scala:15:16
    .io_ptw_status_debug       (io_ptw_status_debug),
    .io_ptw_status_dprv        (io_ptw_status_dprv),
    .io_ptw_status_mxr         (io_ptw_status_mxr),
    .io_ptw_status_sum         (io_ptw_status_sum),
    .io_ptw_pmp_0_cfg_l        (io_ptw_pmp_0_cfg_l),
    .io_ptw_pmp_0_cfg_a        (io_ptw_pmp_0_cfg_a),
    .io_ptw_pmp_0_cfg_x        (io_ptw_pmp_0_cfg_x),
    .io_ptw_pmp_0_cfg_w        (io_ptw_pmp_0_cfg_w),
    .io_ptw_pmp_0_cfg_r        (io_ptw_pmp_0_cfg_r),
    .io_ptw_pmp_0_addr         (io_ptw_pmp_0_addr),
    .io_ptw_pmp_0_mask         (io_ptw_pmp_0_mask),
    .io_ptw_pmp_1_cfg_l        (io_ptw_pmp_1_cfg_l),
    .io_ptw_pmp_1_cfg_a        (io_ptw_pmp_1_cfg_a),
    .io_ptw_pmp_1_cfg_x        (io_ptw_pmp_1_cfg_x),
    .io_ptw_pmp_1_cfg_w        (io_ptw_pmp_1_cfg_w),
    .io_ptw_pmp_1_cfg_r        (io_ptw_pmp_1_cfg_r),
    .io_ptw_pmp_1_addr         (io_ptw_pmp_1_addr),
    .io_ptw_pmp_1_mask         (io_ptw_pmp_1_mask),
    .io_ptw_pmp_2_cfg_l        (io_ptw_pmp_2_cfg_l),
    .io_ptw_pmp_2_cfg_a        (io_ptw_pmp_2_cfg_a),
    .io_ptw_pmp_2_cfg_x        (io_ptw_pmp_2_cfg_x),
    .io_ptw_pmp_2_cfg_w        (io_ptw_pmp_2_cfg_w),
    .io_ptw_pmp_2_cfg_r        (io_ptw_pmp_2_cfg_r),
    .io_ptw_pmp_2_addr         (io_ptw_pmp_2_addr),
    .io_ptw_pmp_2_mask         (io_ptw_pmp_2_mask),
    .io_ptw_pmp_3_cfg_l        (io_ptw_pmp_3_cfg_l),
    .io_ptw_pmp_3_cfg_a        (io_ptw_pmp_3_cfg_a),
    .io_ptw_pmp_3_cfg_x        (io_ptw_pmp_3_cfg_x),
    .io_ptw_pmp_3_cfg_w        (io_ptw_pmp_3_cfg_w),
    .io_ptw_pmp_3_cfg_r        (io_ptw_pmp_3_cfg_r),
    .io_ptw_pmp_3_addr         (io_ptw_pmp_3_addr),
    .io_ptw_pmp_3_mask         (io_ptw_pmp_3_mask),
    .io_ptw_pmp_4_cfg_l        (io_ptw_pmp_4_cfg_l),
    .io_ptw_pmp_4_cfg_a        (io_ptw_pmp_4_cfg_a),
    .io_ptw_pmp_4_cfg_x        (io_ptw_pmp_4_cfg_x),
    .io_ptw_pmp_4_cfg_w        (io_ptw_pmp_4_cfg_w),
    .io_ptw_pmp_4_cfg_r        (io_ptw_pmp_4_cfg_r),
    .io_ptw_pmp_4_addr         (io_ptw_pmp_4_addr),
    .io_ptw_pmp_4_mask         (io_ptw_pmp_4_mask),
    .io_ptw_pmp_5_cfg_l        (io_ptw_pmp_5_cfg_l),
    .io_ptw_pmp_5_cfg_a        (io_ptw_pmp_5_cfg_a),
    .io_ptw_pmp_5_cfg_x        (io_ptw_pmp_5_cfg_x),
    .io_ptw_pmp_5_cfg_w        (io_ptw_pmp_5_cfg_w),
    .io_ptw_pmp_5_cfg_r        (io_ptw_pmp_5_cfg_r),
    .io_ptw_pmp_5_addr         (io_ptw_pmp_5_addr),
    .io_ptw_pmp_5_mask         (io_ptw_pmp_5_mask),
    .io_ptw_pmp_6_cfg_l        (io_ptw_pmp_6_cfg_l),
    .io_ptw_pmp_6_cfg_a        (io_ptw_pmp_6_cfg_a),
    .io_ptw_pmp_6_cfg_x        (io_ptw_pmp_6_cfg_x),
    .io_ptw_pmp_6_cfg_w        (io_ptw_pmp_6_cfg_w),
    .io_ptw_pmp_6_cfg_r        (io_ptw_pmp_6_cfg_r),
    .io_ptw_pmp_6_addr         (io_ptw_pmp_6_addr),
    .io_ptw_pmp_6_mask         (io_ptw_pmp_6_mask),
    .io_ptw_pmp_7_cfg_l        (io_ptw_pmp_7_cfg_l),
    .io_ptw_pmp_7_cfg_a        (io_ptw_pmp_7_cfg_a),
    .io_ptw_pmp_7_cfg_x        (io_ptw_pmp_7_cfg_x),
    .io_ptw_pmp_7_cfg_w        (io_ptw_pmp_7_cfg_w),
    .io_ptw_pmp_7_cfg_r        (io_ptw_pmp_7_cfg_r),
    .io_ptw_pmp_7_addr         (io_ptw_pmp_7_addr),
    .io_ptw_pmp_7_mask         (io_ptw_pmp_7_mask),
    .io_req_ready              (_tlb_io_req_ready),
    .io_resp_paddr             (_tlb_io_resp_paddr),
    .io_resp_pf_ld             (_tlb_io_resp_pf_ld),
    .io_resp_pf_st             (_tlb_io_resp_pf_st),
    .io_resp_ae_ld             (_tlb_io_resp_ae_ld),
    .io_resp_ae_st             (_tlb_io_resp_ae_st),
    .io_resp_ma_ld             (_tlb_io_resp_ma_ld),
    .io_resp_ma_st             (_tlb_io_resp_ma_st),
    .io_resp_cacheable         (_tlb_io_resp_cacheable),
    .io_resp_must_alloc        (_tlb_io_resp_must_alloc),
    .io_ptw_req_valid          (io_ptw_req_valid),
    .io_ptw_req_bits_bits_addr (io_ptw_req_bits_bits_addr)
  );
  TLB_4 pma_checker (	// DCache.scala:118:27
    .io_req_bits_vaddr         (34'h0),	// DCache.scala:118:27
    .io_req_bits_size          (s1_req_size),	// Reg.scala:15:16
    .io_req_bits_cmd           (s1_req_cmd),	// Reg.scala:15:16
    .io_ptw_status_debug       (1'h0),	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
    .io_ptw_status_dprv        (2'h0),	// DCache.scala:117:19, :118:27
    .io_ptw_status_mxr         (1'h0),	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
    .io_ptw_status_sum         (1'h0),	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
    .io_ptw_pmp_0_cfg_l        (1'h0),	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
    .io_ptw_pmp_0_cfg_a        (2'h0),	// DCache.scala:117:19, :118:27
    .io_ptw_pmp_0_cfg_x        (1'h0),	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
    .io_ptw_pmp_0_cfg_w        (1'h0),	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
    .io_ptw_pmp_0_cfg_r        (1'h0),	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
    .io_ptw_pmp_0_addr         (30'h0),
    .io_ptw_pmp_0_mask         (32'h0),
    .io_ptw_pmp_1_cfg_l        (1'h0),	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
    .io_ptw_pmp_1_cfg_a        (2'h0),	// DCache.scala:117:19, :118:27
    .io_ptw_pmp_1_cfg_x        (1'h0),	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
    .io_ptw_pmp_1_cfg_w        (1'h0),	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
    .io_ptw_pmp_1_cfg_r        (1'h0),	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
    .io_ptw_pmp_1_addr         (30'h0),
    .io_ptw_pmp_1_mask         (32'h0),
    .io_ptw_pmp_2_cfg_l        (1'h0),	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
    .io_ptw_pmp_2_cfg_a        (2'h0),	// DCache.scala:117:19, :118:27
    .io_ptw_pmp_2_cfg_x        (1'h0),	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
    .io_ptw_pmp_2_cfg_w        (1'h0),	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
    .io_ptw_pmp_2_cfg_r        (1'h0),	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
    .io_ptw_pmp_2_addr         (30'h0),
    .io_ptw_pmp_2_mask         (32'h0),
    .io_ptw_pmp_3_cfg_l        (1'h0),	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
    .io_ptw_pmp_3_cfg_a        (2'h0),	// DCache.scala:117:19, :118:27
    .io_ptw_pmp_3_cfg_x        (1'h0),	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
    .io_ptw_pmp_3_cfg_w        (1'h0),	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
    .io_ptw_pmp_3_cfg_r        (1'h0),	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
    .io_ptw_pmp_3_addr         (30'h0),
    .io_ptw_pmp_3_mask         (32'h0),
    .io_ptw_pmp_4_cfg_l        (1'h0),	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
    .io_ptw_pmp_4_cfg_a        (2'h0),	// DCache.scala:117:19, :118:27
    .io_ptw_pmp_4_cfg_x        (1'h0),	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
    .io_ptw_pmp_4_cfg_w        (1'h0),	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
    .io_ptw_pmp_4_cfg_r        (1'h0),	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
    .io_ptw_pmp_4_addr         (30'h0),
    .io_ptw_pmp_4_mask         (32'h0),
    .io_ptw_pmp_5_cfg_l        (1'h0),	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
    .io_ptw_pmp_5_cfg_a        (2'h0),	// DCache.scala:117:19, :118:27
    .io_ptw_pmp_5_cfg_x        (1'h0),	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
    .io_ptw_pmp_5_cfg_w        (1'h0),	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
    .io_ptw_pmp_5_cfg_r        (1'h0),	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
    .io_ptw_pmp_5_addr         (30'h0),
    .io_ptw_pmp_5_mask         (32'h0),
    .io_ptw_pmp_6_cfg_l        (1'h0),	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
    .io_ptw_pmp_6_cfg_a        (2'h0),	// DCache.scala:117:19, :118:27
    .io_ptw_pmp_6_cfg_x        (1'h0),	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
    .io_ptw_pmp_6_cfg_w        (1'h0),	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
    .io_ptw_pmp_6_cfg_r        (1'h0),	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
    .io_ptw_pmp_6_addr         (30'h0),
    .io_ptw_pmp_6_mask         (32'h0),
    .io_ptw_pmp_7_cfg_l        (1'h0),	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
    .io_ptw_pmp_7_cfg_a        (2'h0),	// DCache.scala:117:19, :118:27
    .io_ptw_pmp_7_cfg_x        (1'h0),	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
    .io_ptw_pmp_7_cfg_w        (1'h0),	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
    .io_ptw_pmp_7_cfg_r        (1'h0),	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
    .io_ptw_pmp_7_addr         (30'h0),
    .io_ptw_pmp_7_mask         (32'h0),
    .io_req_ready              (/* unused */),
    .io_resp_paddr             (/* unused */),
    .io_resp_pf_ld             (/* unused */),
    .io_resp_pf_st             (/* unused */),
    .io_resp_ae_ld             (/* unused */),
    .io_resp_ae_st             (/* unused */),
    .io_resp_ma_ld             (/* unused */),
    .io_resp_ma_st             (/* unused */),
    .io_resp_cacheable         (/* unused */),
    .io_resp_must_alloc        (/* unused */),
    .io_ptw_req_valid          (/* unused */),
    .io_ptw_req_bits_bits_addr (/* unused */)
  );
  DCacheModuleImpl_Anon_7 metaArb (	// DCache.scala:122:23
    .io_in_0_valid     (resetting),	// DCache.scala:202:26
    .io_in_0_bits_addr (_metaArb_io_in_5_bits_addr_T),	// Cat.scala:30:58
    .io_in_0_bits_idx  (flushCounter),	// DCache.scala:203:25
    .io_in_1_valid
      (s2_meta_error & (s2_valid_masked | s2_flush_valid_pre_tag_ecc | s2_probe)),	// DCache.scala:305:21, :309:42, :327:43, :334:53, :422:{43,93}
    .io_in_1_bits_addr
      ({io_cpu_req_bits_addr[33:12], _metaArb_io_in_1_bits_idx_T_2, 6'h0}),	// Cat.scala:30:58, DCache.scala:224:89, :425:35
    .io_in_1_bits_idx  (_metaArb_io_in_1_bits_idx_T_2),	// DCache.scala:425:35
    .io_in_1_bits_data
      ({s2_meta_error_uncorrectable ? 2'h0 : s2_meta_corrected_r[21:20],
        s2_meta_corrected_r[19:0]}),	// DCache.scala:117:19, :118:27, :333:99, :429:{40,55}, :430:14, Reg.scala:15:16
    .io_in_2_valid     (_metaArb_io_in_2_valid_T),	// DCache.scala:418:62
    .io_in_2_bits_addr ({io_cpu_req_bits_addr[33:12], s2_req_addr[11:0]}),	// Cat.scala:30:58, DCache.scala:224:89, :311:19, :323:103
    .io_in_2_bits_idx  (s2_req_addr[11:6]),	// DCache.scala:311:19, :425:76
    .io_in_2_bits_data ({_GEN_2[_GEN_0], s2_req_addr[31:12]}),	// Cat.scala:30:58, DCache.scala:311:19, :439:{68,97}, HellaCache.scala:290:14, Misc.scala:34:36, :48:20
    .io_in_3_valid
      (grantIsCached & d_last & _io_errors_bus_valid_T & ~auto_out_d_bits_denied),	// DCache.scala:713:{53,56}, Decoupled.scala:40:37, Edges.scala:231:37, package.scala:72:59
    .io_in_3_bits_addr ({io_cpu_req_bits_addr[33:12], s2_req_addr[11:0]}),	// Cat.scala:30:58, DCache.scala:224:89, :311:19, :323:103
    .io_in_3_bits_idx  (s2_req_addr[11:6]),	// DCache.scala:311:19, :425:76
    .io_in_3_bits_data
      ({_metaArb_io_in_3_bits_data_T_1 == 4'hC
          ? 2'h3
          : _metaArb_io_in_3_bits_data_T_1 == 4'h4
            | _metaArb_io_in_3_bits_data_T_1 == 4'h0
              ? 2'h2
              : {1'h0, _metaArb_io_in_3_bits_data_T_1 == 4'h1},
        s2_req_addr[31:12]}),	// AMOALU.scala:17:57, Cat.scala:30:58, DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :311:19, :321:18, :439:68, :718:134, :809:23, Decoupled.scala:40:37, HellaCache.scala:290:14, Mux.scala:80:{57,60}, PRNG.scala:82:22, package.scala:15:47
    .io_in_4_valid     (_metaArb_io_in_4_valid_T_2),	// package.scala:72:59
    .io_in_4_bits_addr ({io_cpu_req_bits_addr[33:12], probe_bits_address[11:0]}),	// Cat.scala:30:58, DCache.scala:224:89, :885:90, Reg.scala:15:16
    .io_in_4_bits_idx  (probe_bits_address[11:6]),	// DCache.scala:1170:47, Reg.scala:15:16
    .io_in_4_bits_data (_metaArb_io_in_4_bits_data_T_1),	// DCache.scala:886:97
    .io_in_5_valid     (1'h0),	// DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, Decoupled.scala:40:37, PRNG.scala:82:22
    .io_in_5_bits_addr (_metaArb_io_in_5_bits_addr_T),	// Cat.scala:30:58
    .io_in_5_bits_idx  (flushCounter),	// DCache.scala:203:25
    .io_in_5_bits_data (_metaArb_io_in_4_bits_data_T_1),	// DCache.scala:886:97
    .io_in_6_valid
      (_GEN_23 | auto_out_b_valid
       & (~block_probe_for_core_progress | (|lrscCount) & ~(|(lrscCount[6:2])))),	// DCache.scala:444:22, :445:29, :446:{34,38,41}, :738:69, :741:{26,44,48,79}, :823:{25,44}, :824:30
    .io_in_6_bits_addr
      ({io_cpu_req_bits_addr[33:32],
        _GEN_23 ? probe_bits_address : auto_out_b_bits_address}),	// Cat.scala:30:58, DCache.scala:745:{30,58}, :823:{25,44}, :826:34, Reg.scala:15:16
    .io_in_6_bits_idx
      (_GEN_23 ? probe_bits_address[11:6] : auto_out_b_bits_address[11:6]),	// DCache.scala:744:29, :823:{25,44}, :825:33, :1170:47, Reg.scala:15:16
    .io_in_6_bits_data (_metaArb_io_in_4_bits_data_T_1),	// DCache.scala:886:97
    .io_in_7_valid     (io_cpu_req_valid),
    .io_in_7_bits_addr (io_cpu_req_bits_addr),
    .io_in_7_bits_idx  (io_cpu_req_bits_addr[11:6]),	// DCache.scala:242:58
    .io_in_7_bits_data (_metaArb_io_in_4_bits_data_T_1),	// DCache.scala:886:97
    .io_in_4_ready     (_metaArb_io_in_4_ready),
    .io_in_5_ready     (/* unused */),
    .io_in_6_ready     (_metaArb_io_in_6_ready),
    .io_in_7_ready     (_metaArb_io_in_7_ready),
    .io_out_valid      (_metaArb_io_out_valid),
    .io_out_bits_write (_metaArb_io_out_bits_write),
    .io_out_bits_addr  (_metaArb_io_out_bits_addr),
    .io_out_bits_idx   (_metaArb_io_out_bits_idx),
    .io_out_bits_data  (_metaArb_io_out_bits_data)
  );
  tag_array_0_64x22 tag_array_0_ext (	// DescribedSRAM.scala:19:26
    .RW0_addr  (_metaArb_io_out_bits_idx),	// DCache.scala:122:23
    .RW0_en    (readEnable | writeEnable),	// DCache.scala:282:27, :286:59, DescribedSRAM.scala:19:26
    .RW0_clk   (gated_clock),
    .RW0_wmode (_metaArb_io_out_bits_write),	// DCache.scala:122:23
    .RW0_wdata (_metaArb_io_out_bits_data),	// DCache.scala:122:23
    .RW0_rdata (_tag_array_0_ext_RW0_rdata)
  );
  DCacheDataArray_1 data (	// DCache.scala:132:20
    .clock               (gated_clock),
    .io_req_valid        (_dataArb_io_out_valid),	// DCache.scala:133:23
    .io_req_bits_addr    (_dataArb_io_out_bits_addr),	// DCache.scala:133:23
    .io_req_bits_write   (_dataArb_io_out_bits_write),	// DCache.scala:133:23
    .io_req_bits_wdata   (_dataArb_io_out_bits_wdata),	// DCache.scala:133:23
    .io_req_bits_eccMask (_dataArb_io_out_bits_eccMask),	// DCache.scala:133:23
    .io_resp_0           (_data_io_resp_0)
  );
  DCacheModuleImpl_Anon_5 dataArb (	// DCache.scala:133:23
    .io_in_0_valid
      (pstore_drain_structural
       | ((_dataArb_io_in_0_valid_T_4 | pstore1_held) & ~pstore1_rmw | pstore2_valid)
       & _dataArb_io_in_0_valid_T_9),	// DCache.scala:473:30, :476:29, :478:{72,96}, :481:71, :489:48, :490:{41,44,58,76,107}, Reg.scala:15:16
    .io_in_0_bits_addr    (pstore2_valid ? pstore2_addr[11:0] : pstore1_addr[11:0]),	// DCache.scala:473:30, :521:36, Reg.scala:15:16
    .io_in_0_bits_write   (_pstore_drain_T_11),	// DCache.scala:489:48
    .io_in_0_bits_wdata
      (pstore2_valid
         ? {pstore2_storegen_data_hi_hi_hi,
            pstore2_storegen_data_hi_hi_lo,
            pstore2_storegen_data_hi_lo_hi,
            pstore2_storegen_data_hi_lo_lo,
            pstore2_storegen_data_lo_hi_hi,
            pstore2_storegen_data_lo_hi_lo,
            pstore2_storegen_data_lo_lo_hi,
            pstore2_storegen_data_lo_lo_lo}
         : pstore1_data),	// Cat.scala:30:58, DCache.scala:473:30, :523:63, Reg.scala:15:16
    .io_in_0_bits_eccMask (pstore2_valid ? mask : pstore1_mask),	// DCache.scala:473:30, :503:19, :529:47, Reg.scala:15:16
    .io_in_1_valid
      (_GEN_20 | auto_out_d_valid & grantIsRefill & ~_canAcceptCachedGrant_T_4),	// DCache.scala:642:30, :693:{26,61}, :724:68, :727:29, :729:32, package.scala:15:47, :72:59
    .io_in_1_bits_addr    ({s2_req_addr[11:6] | count[8:3], count[2:0], 3'h0}),	// DCache.scala:311:19, :700:{32,46,67}, Edges.scala:233:25, Misc.scala:37:36
    .io_in_1_bits_write   (~_GEN_19 | ~auto_out_d_valid),	// DCache.scala:109:25, :136:24, :699:33, :724:{31,68}, :727:29, :730:37
    .io_in_1_bits_wdata   (auto_out_d_bits_data),
    .io_in_2_valid        (_dataArb_io_in_2_valid_T_1),	// DCache.scala:873:41
    .io_in_2_bits_addr    ({probe_bits_address[11:6], _releaseDataBeat_T_5[2:0], 3'h0}),	// DCache.scala:776:47, :876:{72,90}, :1170:47, Misc.scala:37:36, Reg.scala:15:16
    .io_in_2_bits_wdata   (auto_out_d_bits_data),
    .io_in_3_valid        (io_cpu_req_valid & ~_dataArb_io_in_3_valid_res_T_2),	// DCache.scala:221:46, :1155:15, package.scala:72:59
    .io_in_3_bits_addr    (io_cpu_req_bits_addr[11:0]),	// DCache.scala:224:30
    .io_in_3_bits_wdata   (auto_out_d_bits_data),
    .io_in_1_ready        (_dataArb_io_in_1_ready),
    .io_in_2_ready        (_dataArb_io_in_2_ready),
    .io_in_3_ready        (_dataArb_io_in_3_ready),
    .io_out_valid         (_dataArb_io_out_valid),
    .io_out_bits_addr     (_dataArb_io_out_bits_addr),
    .io_out_bits_write    (_dataArb_io_out_bits_write),
    .io_out_bits_wdata    (_dataArb_io_out_bits_wdata),
    .io_out_bits_eccMask  (_dataArb_io_out_bits_eccMask)
  );
  AMOALU amoalu (	// DCache.scala:952:26
    .io_mask (pstore1_mask),	// Reg.scala:15:16
    .io_cmd  (pstore1_cmd),	// Reg.scala:15:16
    .io_lhs  (s2_data),	// Reg.scala:15:16
    .io_rhs  (pstore1_data),	// Reg.scala:15:16
    .io_out  (_amoalu_io_out)
  );
  assign auto_out_a_valid = deq_valid;	// DCache.scala:576:32
  assign auto_out_a_bits_opcode =
    s2_uncached
      ? (s2_write
           ? (_metaArb_io_in_3_bits_data_c_cat_T_23
                ? 3'h1
                : s2_read
                    ? (_atomics_T_16 | _atomics_T_14 | _atomics_T_12 | _atomics_T_10
                       | _atomics_T_8
                         ? 3'h2
                         : _atomics_T_6 | _atomics_T_4 | _atomics_T_2 | _atomics_T
                             ? 3'h3
                             : 3'h0)
                    : 3'h0)
           : 3'h4)
      : 3'h6;	// Consts.scala:81:{48,75}, :82:{49,76}, DCache.scala:396:39, :580:23, :581:8, :582:8, :583:8, Misc.scala:37:36, Mux.scala:80:{57,60}, package.scala:15:47
  assign auto_out_a_bits_param =
    s2_uncached
      ? (~s2_write | _metaArb_io_in_3_bits_data_c_cat_T_23 | ~s2_read
           ? 3'h0
           : _atomics_T_16
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
      : {1'h0, _GEN_2[_GEN_0]};	// Cat.scala:30:58, Consts.scala:81:75, :82:{49,76}, DCache.scala:117:19, :118:27, :122:23, :133:23, :251:33, :255:58, :321:18, :396:39, :580:23, :581:{8,9}, :582:8, :583:{8,9}, Decoupled.scala:40:37, Edges.scala:347:15, Misc.scala:34:36, :37:36, :48:20, Mux.scala:80:{57,60}, PRNG.scala:82:22, package.scala:15:47
  assign auto_out_a_bits_size = s2_uncached ? (_GEN_14 ? {2'h0, size} : 4'h0) : 4'h6;	// DCache.scala:117:19, :118:27, :311:19, :396:39, :580:23, :581:8, Edges.scala:450:15, package.scala:15:47
  assign auto_out_a_bits_source =
    s2_uncached
    & (~s2_write | _metaArb_io_in_3_bits_data_c_cat_T_23 | ~s2_read | _atomics_T_16
       | _atomics_T_14 | _atomics_T_12 | _atomics_T_10 | _atomics_T_8 | _atomics_T_6
       | _atomics_T_4 | _atomics_T_2 | _atomics_T);	// Consts.scala:81:75, :82:{49,76}, DCache.scala:396:39, :580:23, :581:{8,9}, :583:9, Mux.scala:80:60
  assign auto_out_a_bits_address =
    s2_uncached ? (_GEN_14 ? s2_req_addr[31:0] : 32'h0) : {s2_req_addr[31:6], 6'h0};	// DCache.scala:311:19, :396:39, :580:23, :581:8, Edges.scala:350:15, :452:15
  assign auto_out_a_bits_mask =
    s2_uncached
      ? (s2_write
           ? (_metaArb_io_in_3_bits_data_c_cat_T_23
                ? pstore1_mask
                : s2_read
                    ? atomics_mask
                    : {put_a_mask_acc_5 | put_a_mask_eq_5 & s2_req_addr[0],
                       put_a_mask_acc_5 | put_a_mask_eq_5 & ~(s2_req_addr[0]),
                       put_a_mask_acc_4 | put_a_mask_eq_4 & s2_req_addr[0],
                       put_a_mask_acc_4 | put_a_mask_eq_4 & ~(s2_req_addr[0]),
                       put_a_mask_acc_3 | put_a_mask_eq_3 & s2_req_addr[0],
                       put_a_mask_acc_3 | put_a_mask_eq_3 & ~(s2_req_addr[0]),
                       put_a_mask_acc_2 | put_a_mask_eq_2 & s2_req_addr[0],
                       put_a_mask_acc_2 | put_a_mask_eq_2 & ~(s2_req_addr[0])})
           : {get_a_mask_acc_5 | get_a_mask_eq_5 & s2_req_addr[0],
              get_a_mask_acc_5 | get_a_mask_eq_5 & ~(s2_req_addr[0]),
              get_a_mask_acc_4 | get_a_mask_eq_4 & s2_req_addr[0],
              get_a_mask_acc_4 | get_a_mask_eq_4 & ~(s2_req_addr[0]),
              get_a_mask_acc_3 | get_a_mask_eq_3 & s2_req_addr[0],
              get_a_mask_acc_3 | get_a_mask_eq_3 & ~(s2_req_addr[0]),
              get_a_mask_acc_2 | get_a_mask_eq_2 & s2_req_addr[0],
              get_a_mask_acc_2 | get_a_mask_eq_2 & ~(s2_req_addr[0])})
      : 8'hFF;	// Bitwise.scala:72:12, Cat.scala:30:58, Consts.scala:81:75, :82:{49,76}, DCache.scala:311:19, :396:39, :580:23, :581:8, :582:8, :583:8, Misc.scala:209:26, :210:20, :213:27, :214:29, Mux.scala:80:57, Reg.scala:15:16
  assign auto_out_a_bits_data =
    s2_uncached & s2_write
    & (_metaArb_io_in_3_bits_data_c_cat_T_23 | ~s2_read | _atomics_T_16 | _atomics_T_14
       | _atomics_T_12 | _atomics_T_10 | _atomics_T_8 | _atomics_T_6 | _atomics_T_4
       | _atomics_T_2 | _atomics_T)
      ? pstore1_data
      : 64'h0;	// Consts.scala:81:75, :82:{49,76}, DCache.scala:396:39, :580:23, :581:8, :582:8, :583:8, Mux.scala:80:60, Reg.scala:15:16
  assign auto_out_b_ready = tl_out_b_ready;	// DCache.scala:742:44
  assign auto_out_c_valid = tl_out_c_valid;	// DCache.scala:806:21, :832:47, :833:22, :836:48, :837:22
  assign auto_out_c_bits_opcode = tl_out_c_bits_opcode;	// DCache.scala:841:48, :845:102, :846:52
  assign auto_out_c_bits_param =
    _GEN_26
      ? ((&s2_victim_state_state) | s2_victim_state_state == 2'h2
           ? 3'h1
           : s2_victim_state_state == 2'h1
               ? 3'h2
               : s2_victim_state_state == 2'h0 ? 3'h5 : 3'h0)
      : _inWriteback_T_1 | _GEN_25 | ~(~s2_probe | _GEN_22 | ~(|s2_probe_state_state))
          ? (_GEN_13
               ? 3'h3
               : _GEN_10
                   ? 3'h4
                   : _GEN_9
                       ? 3'h5
                       : _GEN_8 | _GEN_7
                           ? 3'h0
                           : _GEN_6
                               ? 3'h4
                               : _GEN_5
                                   ? 3'h5
                                   : _GEN_4 | _GEN_3 == 4'hA
                                       ? 3'h1
                                       : _GEN_3 == 4'h9
                                           ? 3'h2
                                           : _GEN_3 == 4'h8 ? 3'h5 : 3'h0)
          : 3'h5;	// AMOALU.scala:17:57, Cat.scala:30:58, DCache.scala:117:19, :118:27, :192:34, :305:21, :406:28, :783:17, :806:21, :808:28, :810:36, :812:45, :836:{25,48}, :838:21, :841:48, :842:21, :845:102, :846:52, Metadata.scala:49:45, Misc.scala:37:36, :55:20, Reg.scala:15:16, package.scala:15:47, :72:59
  assign auto_out_c_bits_size = tl_out_c_bits_size;	// DCache.scala:841:48, :845:102, :846:52
  assign auto_out_c_bits_source = probe_bits_source;	// Reg.scala:15:16
  assign auto_out_c_bits_address = probe_bits_address;	// Reg.scala:15:16
  assign auto_out_c_bits_data = s2_data;	// Reg.scala:15:16
  assign auto_out_d_ready = tl_out_d_ready;	// DCache.scala:643:18, :694:51, :696:20, :724:68, :725:22
  assign auto_out_e_valid = tl_out_e_valid;	// DCache.scala:686:18, :694:51, :695:20
  assign io_cpu_req_ready = _io_cpu_req_ready_output;	// DCache.scala:254:79, :724:68, :727:29
  assign io_cpu_s2_nack = _io_cpu_s2_nack_output;	// DCache.scala:417:86
  assign io_cpu_resp_valid = s2_valid_hit | doUncachedResp;	// DCache.scala:392:69, :918:27, :919:51
  assign io_cpu_resp_bits_tag = s2_req_tag;	// DCache.scala:311:19
  assign io_cpu_resp_bits_data =
    {size == 2'h0 | s2_sc
       ? {56{s2_req_signed & io_cpu_resp_bits_data_lo_2[7]}}
       : {size == 2'h1
            ? {48{s2_req_signed & io_cpu_resp_bits_data_lo_1[15]}}
            : {_io_cpu_resp_bits_data_word_bypass_T_1
                 ? {32{s2_req_signed & io_cpu_resp_bits_data_lo[31]}}
                 : s2_data[63:32],
               io_cpu_resp_bits_data_lo[31:16]},
          io_cpu_resp_bits_data_lo_1[15:8]},
     io_cpu_resp_bits_data_lo_2[7:1],
     io_cpu_resp_bits_data_lo_2[0] | s2_sc_fail};	// AMOALU.scala:39:{24,37}, :41:23, :42:{20,26,38,76,85,98}, Bitwise.scala:72:12, Cat.scala:30:58, Consts.scala:81:65, DCache.scala:117:19, :118:27, :311:19, :449:26, :944:41, Reg.scala:15:16
  assign io_cpu_resp_bits_replay = doUncachedResp;	// DCache.scala:918:27
  assign io_cpu_resp_bits_has_data = s2_read;	// Consts.scala:81:75
  assign io_cpu_resp_bits_data_word_bypass =
    {_io_cpu_resp_bits_data_word_bypass_T_1
       ? {32{s2_req_signed & io_cpu_resp_bits_data_word_bypass_lo[31]}}
       : s2_data[63:32],
     io_cpu_resp_bits_data_word_bypass_lo};	// AMOALU.scala:39:{24,37}, :42:{20,26,76,85}, Bitwise.scala:72:12, Cat.scala:30:58, DCache.scala:311:19, Reg.scala:15:16
  assign io_cpu_replay_next = _io_cpu_replay_next_output;	// DCache.scala:920:41
  assign io_cpu_s2_xcpt_ma_ld = _io_cpu_s2_xcpt_ma_ld_output;	// DCache.scala:903:24
  assign io_cpu_s2_xcpt_ma_st = _io_cpu_s2_xcpt_ma_st_output;	// DCache.scala:903:24
  assign io_cpu_s2_xcpt_pf_ld = _io_cpu_s2_xcpt_pf_ld_output;	// DCache.scala:903:24
  assign io_cpu_s2_xcpt_pf_st = _io_cpu_s2_xcpt_pf_st_output;	// DCache.scala:903:24
  assign io_cpu_s2_xcpt_ae_ld = _io_cpu_s2_xcpt_ae_ld_output;	// DCache.scala:903:24
  assign io_cpu_s2_xcpt_ae_st = _io_cpu_s2_xcpt_ae_st_output;	// DCache.scala:903:24
  assign io_cpu_ordered =
    ~(s1_valid & ~s1_req_no_xcpt | s2_valid & ~s2_req_no_xcpt | cached_grant_wait
      | uncachedInFlight_0);	// DCache.scala:162:21, :201:30, :215:33, :303:21, :311:19, :900:{21,32,35,69,72,115}, Reg.scala:15:16
  assign io_cpu_perf_release =
    (io_cpu_perf_release_counter == 9'h1
     | (tl_out_c_bits_opcode[0]
          ? ~(_io_cpu_perf_release_beats1_decode_T_1[11:3])
          : 9'h0) == 9'h0) & _io_cpu_perf_release_T;	// DCache.scala:841:48, :845:102, :846:52, Decoupled.scala:40:37, Edges.scala:101:36, :220:14, :228:27, :231:{25,37,47}, :232:22, package.scala:234:{46,77,82}
  assign io_cpu_perf_grant = auto_out_d_valid & d_last;	// DCache.scala:1048:39, Edges.scala:231:37
endmodule

