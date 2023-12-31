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

module NBDTLB(
  input         clock,
                reset,
                io_req_0_valid,
  input  [39:0] io_req_0_bits_vaddr,
  input  [1:0]  io_req_0_bits_size,
  input  [4:0]  io_req_0_bits_cmd,
  input         io_req_1_valid,
  input  [39:0] io_req_1_bits_vaddr,
  input         io_req_1_bits_passthrough,
  input  [1:0]  io_req_1_bits_size,
  input  [4:0]  io_req_1_bits_cmd,
  input         io_sfence_valid,
                io_sfence_bits_rs1,
                io_sfence_bits_rs2,
  input  [38:0] io_sfence_bits_addr,
  input         io_ptw_req_ready,
                io_ptw_resp_valid,
                io_ptw_resp_bits_ae,
  input  [53:0] io_ptw_resp_bits_pte_ppn,
  input         io_ptw_resp_bits_pte_d,
                io_ptw_resp_bits_pte_a,
                io_ptw_resp_bits_pte_g,
                io_ptw_resp_bits_pte_u,
                io_ptw_resp_bits_pte_x,
                io_ptw_resp_bits_pte_w,
                io_ptw_resp_bits_pte_r,
                io_ptw_resp_bits_pte_v,
  input  [1:0]  io_ptw_resp_bits_level,
  input         io_ptw_resp_bits_homogeneous,
  input  [3:0]  io_ptw_ptbr_mode,
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
  input         io_kill,
  output        io_miss_rdy,
                io_resp_0_miss,
  output [31:0] io_resp_0_paddr,
  output        io_resp_0_pf_ld,
                io_resp_0_pf_st,
                io_resp_0_ae_ld,
                io_resp_0_ae_st,
                io_resp_0_cacheable,
                io_resp_1_miss,
  output [31:0] io_resp_1_paddr,
  output        io_resp_1_pf_ld,
                io_resp_1_pf_st,
                io_resp_1_ae_ld,
                io_resp_1_ae_st,
                io_resp_1_ma_ld,
                io_resp_1_ma_st,
                io_resp_1_cacheable,
                io_ptw_req_valid,
                io_ptw_req_bits_valid,
  output [26:0] io_ptw_req_bits_bits_addr
);

  wire             _pmp_1_io_r;	// tlb.scala:150:40
  wire             _pmp_1_io_w;	// tlb.scala:150:40
  wire             _pmp_0_io_r;	// tlb.scala:150:40
  wire             _pmp_0_io_w;	// tlb.scala:150:40
  wire             _pmp_0_io_x;	// tlb.scala:150:40
  reg  [26:0]      sectored_entries_0_tag;	// tlb.scala:122:29
  reg  [33:0]      sectored_entries_0_data_0;	// tlb.scala:122:29
  reg  [33:0]      sectored_entries_0_data_1;	// tlb.scala:122:29
  reg  [33:0]      sectored_entries_0_data_2;	// tlb.scala:122:29
  reg  [33:0]      sectored_entries_0_data_3;	// tlb.scala:122:29
  reg              sectored_entries_0_valid_0;	// tlb.scala:122:29
  reg              sectored_entries_0_valid_1;	// tlb.scala:122:29
  reg              sectored_entries_0_valid_2;	// tlb.scala:122:29
  reg              sectored_entries_0_valid_3;	// tlb.scala:122:29
  reg  [26:0]      sectored_entries_1_tag;	// tlb.scala:122:29
  reg  [33:0]      sectored_entries_1_data_0;	// tlb.scala:122:29
  reg  [33:0]      sectored_entries_1_data_1;	// tlb.scala:122:29
  reg  [33:0]      sectored_entries_1_data_2;	// tlb.scala:122:29
  reg  [33:0]      sectored_entries_1_data_3;	// tlb.scala:122:29
  reg              sectored_entries_1_valid_0;	// tlb.scala:122:29
  reg              sectored_entries_1_valid_1;	// tlb.scala:122:29
  reg              sectored_entries_1_valid_2;	// tlb.scala:122:29
  reg              sectored_entries_1_valid_3;	// tlb.scala:122:29
  reg  [26:0]      sectored_entries_2_tag;	// tlb.scala:122:29
  reg  [33:0]      sectored_entries_2_data_0;	// tlb.scala:122:29
  reg  [33:0]      sectored_entries_2_data_1;	// tlb.scala:122:29
  reg  [33:0]      sectored_entries_2_data_2;	// tlb.scala:122:29
  reg  [33:0]      sectored_entries_2_data_3;	// tlb.scala:122:29
  reg              sectored_entries_2_valid_0;	// tlb.scala:122:29
  reg              sectored_entries_2_valid_1;	// tlb.scala:122:29
  reg              sectored_entries_2_valid_2;	// tlb.scala:122:29
  reg              sectored_entries_2_valid_3;	// tlb.scala:122:29
  reg  [26:0]      sectored_entries_3_tag;	// tlb.scala:122:29
  reg  [33:0]      sectored_entries_3_data_0;	// tlb.scala:122:29
  reg  [33:0]      sectored_entries_3_data_1;	// tlb.scala:122:29
  reg  [33:0]      sectored_entries_3_data_2;	// tlb.scala:122:29
  reg  [33:0]      sectored_entries_3_data_3;	// tlb.scala:122:29
  reg              sectored_entries_3_valid_0;	// tlb.scala:122:29
  reg              sectored_entries_3_valid_1;	// tlb.scala:122:29
  reg              sectored_entries_3_valid_2;	// tlb.scala:122:29
  reg              sectored_entries_3_valid_3;	// tlb.scala:122:29
  reg  [26:0]      sectored_entries_4_tag;	// tlb.scala:122:29
  reg  [33:0]      sectored_entries_4_data_0;	// tlb.scala:122:29
  reg  [33:0]      sectored_entries_4_data_1;	// tlb.scala:122:29
  reg  [33:0]      sectored_entries_4_data_2;	// tlb.scala:122:29
  reg  [33:0]      sectored_entries_4_data_3;	// tlb.scala:122:29
  reg              sectored_entries_4_valid_0;	// tlb.scala:122:29
  reg              sectored_entries_4_valid_1;	// tlb.scala:122:29
  reg              sectored_entries_4_valid_2;	// tlb.scala:122:29
  reg              sectored_entries_4_valid_3;	// tlb.scala:122:29
  reg  [26:0]      sectored_entries_5_tag;	// tlb.scala:122:29
  reg  [33:0]      sectored_entries_5_data_0;	// tlb.scala:122:29
  reg  [33:0]      sectored_entries_5_data_1;	// tlb.scala:122:29
  reg  [33:0]      sectored_entries_5_data_2;	// tlb.scala:122:29
  reg  [33:0]      sectored_entries_5_data_3;	// tlb.scala:122:29
  reg              sectored_entries_5_valid_0;	// tlb.scala:122:29
  reg              sectored_entries_5_valid_1;	// tlb.scala:122:29
  reg              sectored_entries_5_valid_2;	// tlb.scala:122:29
  reg              sectored_entries_5_valid_3;	// tlb.scala:122:29
  reg  [26:0]      sectored_entries_6_tag;	// tlb.scala:122:29
  reg  [33:0]      sectored_entries_6_data_0;	// tlb.scala:122:29
  reg  [33:0]      sectored_entries_6_data_1;	// tlb.scala:122:29
  reg  [33:0]      sectored_entries_6_data_2;	// tlb.scala:122:29
  reg  [33:0]      sectored_entries_6_data_3;	// tlb.scala:122:29
  reg              sectored_entries_6_valid_0;	// tlb.scala:122:29
  reg              sectored_entries_6_valid_1;	// tlb.scala:122:29
  reg              sectored_entries_6_valid_2;	// tlb.scala:122:29
  reg              sectored_entries_6_valid_3;	// tlb.scala:122:29
  reg  [26:0]      sectored_entries_7_tag;	// tlb.scala:122:29
  reg  [33:0]      sectored_entries_7_data_0;	// tlb.scala:122:29
  reg  [33:0]      sectored_entries_7_data_1;	// tlb.scala:122:29
  reg  [33:0]      sectored_entries_7_data_2;	// tlb.scala:122:29
  reg  [33:0]      sectored_entries_7_data_3;	// tlb.scala:122:29
  reg              sectored_entries_7_valid_0;	// tlb.scala:122:29
  reg              sectored_entries_7_valid_1;	// tlb.scala:122:29
  reg              sectored_entries_7_valid_2;	// tlb.scala:122:29
  reg              sectored_entries_7_valid_3;	// tlb.scala:122:29
  reg  [1:0]       superpage_entries_0_level;	// tlb.scala:123:30
  reg  [26:0]      superpage_entries_0_tag;	// tlb.scala:123:30
  reg  [33:0]      superpage_entries_0_data_0;	// tlb.scala:123:30
  reg              superpage_entries_0_valid_0;	// tlb.scala:123:30
  reg  [1:0]       superpage_entries_1_level;	// tlb.scala:123:30
  reg  [26:0]      superpage_entries_1_tag;	// tlb.scala:123:30
  reg  [33:0]      superpage_entries_1_data_0;	// tlb.scala:123:30
  reg              superpage_entries_1_valid_0;	// tlb.scala:123:30
  reg  [1:0]       superpage_entries_2_level;	// tlb.scala:123:30
  reg  [26:0]      superpage_entries_2_tag;	// tlb.scala:123:30
  reg  [33:0]      superpage_entries_2_data_0;	// tlb.scala:123:30
  reg              superpage_entries_2_valid_0;	// tlb.scala:123:30
  reg  [1:0]       superpage_entries_3_level;	// tlb.scala:123:30
  reg  [26:0]      superpage_entries_3_tag;	// tlb.scala:123:30
  reg  [33:0]      superpage_entries_3_data_0;	// tlb.scala:123:30
  reg              superpage_entries_3_valid_0;	// tlb.scala:123:30
  reg  [1:0]       special_entry_level;	// tlb.scala:124:56
  reg  [26:0]      special_entry_tag;	// tlb.scala:124:56
  reg  [33:0]      special_entry_data_0;	// tlb.scala:124:56
  reg              special_entry_valid_0;	// tlb.scala:124:56
  reg  [1:0]       state;	// tlb.scala:129:22
  reg  [26:0]      r_refill_tag;	// tlb.scala:130:25
  reg  [1:0]       r_superpage_repl_addr;	// tlb.scala:131:34
  reg  [2:0]       r_sectored_repl_addr;	// tlb.scala:132:33
  reg  [2:0]       r_sectored_hit_addr;	// tlb.scala:133:32
  reg              r_sectored_hit;	// tlb.scala:134:27
  wire             vm_enabled_0 = io_ptw_ptbr_mode[3] & ~(io_ptw_status_dprv[1]);	// tlb.scala:138:27, :139:{63,93}
  wire             vm_enabled_1 =
    io_ptw_ptbr_mode[3] & ~(io_ptw_status_dprv[1]) & ~io_req_1_bits_passthrough;	// tlb.scala:138:27, :139:{63,109,112}
  wire             _io_ptw_req_valid_T = state == 2'h1;	// package.scala:15:47, tlb.scala:129:22
  wire             ignore_13 = special_entry_level == 2'h0;	// tlb.scala:80:31, :124:56, :129:22
  wire [27:0]      _GEN = {8'h0, io_ptw_resp_bits_pte_ppn[19:0]};	// tlb.scala:143:44, :147:20, :148:20
  wire [27:0]      mpu_ppn_0 =
    io_ptw_resp_valid
      ? _GEN
      : vm_enabled_0
          ? {8'h0,
             special_entry_data_0[33:32],
             (ignore_13 ? io_req_0_bits_vaddr[29:21] : 9'h0)
               | special_entry_data_0[31:23],
             (special_entry_level[1] ? 9'h0 : io_req_0_bits_vaddr[20:12])
               | special_entry_data_0[22:14]}
          : io_req_0_bits_vaddr[39:12];	// tlb.scala:58:79, :78:28, :80:31, :81:{30,49}, :107:64, :124:56, :139:93, :142:47, :147:20, :148:{20,134}
  wire [27:0]      mpu_ppn_1 =
    io_ptw_resp_valid
      ? _GEN
      : vm_enabled_1
          ? {8'h0,
             special_entry_data_0[33:32],
             (ignore_13 ? io_req_1_bits_vaddr[29:21] : 9'h0)
               | special_entry_data_0[31:23],
             (special_entry_level[1] ? 9'h0 : io_req_1_bits_vaddr[20:12])
               | special_entry_data_0[22:14]}
          : io_req_1_bits_vaddr[39:12];	// tlb.scala:58:79, :78:28, :80:31, :81:{30,49}, :107:64, :124:56, :139:109, :142:47, :147:20, :148:{20,134}
  wire [13:0]      _GEN_0 = mpu_ppn_0[13:0] ^ 14'h2010;	// Parameters.scala:137:31, tlb.scala:147:20
  wire [9:0]       _GEN_1 = mpu_ppn_0[13:4] ^ 10'h200;	// Parameters.scala:137:31, tlb.scala:147:20
  wire [3:0]       _GEN_2 = mpu_ppn_0[19:16] ^ 4'h8;	// Parameters.scala:137:31, tlb.scala:147:20, :152:20
  wire [16:0]      _GEN_3 = mpu_ppn_0[16:0] ^ 17'h10000;	// Parameters.scala:137:{31,52}, tlb.scala:147:20
  wire [1:0]       _GEN_4 = mpu_ppn_0[5:4] ^ 2'h2;	// Parameters.scala:137:31, tlb.scala:80:31, :147:20
  wire             legal_address_0 =
    {mpu_ppn_0[27:2], ~(mpu_ppn_0[1:0])} == 28'h0 | {mpu_ppn_0[27:14], _GEN_0} == 28'h0
    | {mpu_ppn_0[27:3], mpu_ppn_0[2:0] ^ 3'h4} == 28'h0
    | {mpu_ppn_0[27:19], mpu_ppn_0[18:0] ^ 19'h54000} == 28'h0
    | {mpu_ppn_0[27:9], mpu_ppn_0[8:0] ^ 9'h100} == 28'h0
    | {mpu_ppn_0[27:16], ~(mpu_ppn_0[15:14])} == 14'h0
    | {mpu_ppn_0[27:14], _GEN_1} == 24'h0 | mpu_ppn_0 == 28'h0
    | {mpu_ppn_0[27:5], ~(mpu_ppn_0[4])} == 24'h0 | {mpu_ppn_0[27:20], _GEN_2} == 12'h0
    | {mpu_ppn_0[27:17], _GEN_3} == 28'h0 | {mpu_ppn_0[27:6], _GEN_4} == 24'h0;	// Parameters.scala:137:{31,49,52,67}, tlb.scala:147:20, :157:84, :204:65, :262:32
  wire [13:0]      _GEN_5 = mpu_ppn_1[13:0] ^ 14'h2010;	// Parameters.scala:137:31, tlb.scala:147:20
  wire [9:0]       _GEN_6 = mpu_ppn_1[13:4] ^ 10'h200;	// Parameters.scala:137:31, tlb.scala:147:20
  wire [3:0]       _GEN_7 = mpu_ppn_1[19:16] ^ 4'h8;	// Parameters.scala:137:31, tlb.scala:147:20, :152:20
  wire [16:0]      _GEN_8 = mpu_ppn_1[16:0] ^ 17'h10000;	// Parameters.scala:137:{31,52}, tlb.scala:147:20
  wire             legal_address_1 =
    {mpu_ppn_1[27:2], ~(mpu_ppn_1[1:0])} == 28'h0 | {mpu_ppn_1[27:14], _GEN_5} == 28'h0
    | {mpu_ppn_1[27:3], mpu_ppn_1[2:0] ^ 3'h4} == 28'h0
    | {mpu_ppn_1[27:19], mpu_ppn_1[18:0] ^ 19'h54000} == 28'h0
    | {mpu_ppn_1[27:9], mpu_ppn_1[8:0] ^ 9'h100} == 28'h0
    | {mpu_ppn_1[27:16], ~(mpu_ppn_1[15:14])} == 14'h0
    | {mpu_ppn_1[27:14], _GEN_6} == 24'h0 | mpu_ppn_1 == 28'h0
    | {mpu_ppn_1[27:5], ~(mpu_ppn_1[4])} == 24'h0 | {mpu_ppn_1[27:20], _GEN_7} == 12'h0
    | {mpu_ppn_1[27:17], _GEN_8} == 28'h0
    | {mpu_ppn_1[27:6], mpu_ppn_1[5:4] ^ 2'h2} == 24'h0;	// Parameters.scala:137:{31,49,52,67}, tlb.scala:80:31, :147:20, :157:84, :204:65, :262:32
  wire [3:0]       _GEN_9 = mpu_ppn_0[16:13] ^ 4'hA;	// Parameters.scala:137:31, tlb.scala:147:20
  wire [1:0]       _GEN_10 = {_GEN_2[3], mpu_ppn_0[16]};	// Parameters.scala:137:{31,49,52}, tlb.scala:147:20
  wire             newEntry_c =
    legal_address_0
    & ({mpu_ppn_0[19], _GEN_3[16], mpu_ppn_0[14:13]} == 4'h0 | ~(|_GEN_10));	// Parameters.scala:137:{31,49,52,67}, :615:89, tlb.scala:147:20, :157:84, :159:22, :231:89
  wire [3:0]       _GEN_11 = mpu_ppn_1[16:13] ^ 4'hA;	// Parameters.scala:137:31, tlb.scala:147:20
  wire [1:0]       _GEN_12 = {_GEN_7[3], mpu_ppn_1[16]};	// Parameters.scala:137:{31,49,52}, tlb.scala:147:20
  wire             newEntry_pr = legal_address_0 & _pmp_0_io_r;	// tlb.scala:150:40, :157:84, :162:60
  wire [5:0]       _GEN_13 =
    {mpu_ppn_0[19], mpu_ppn_0[16:15], mpu_ppn_0[13], mpu_ppn_0[5:4]};	// Parameters.scala:137:{31,49,52}, tlb.scala:147:20
  wire [5:0]       _GEN_14 =
    {mpu_ppn_0[19], mpu_ppn_0[16:15], _GEN_1[9], mpu_ppn_0[8], mpu_ppn_0[5]};	// Parameters.scala:137:{31,49,52}, tlb.scala:147:20
  wire [2:0]       _GEN_15 = {mpu_ppn_0[19], mpu_ppn_0[16], ~(mpu_ppn_0[15])};	// Parameters.scala:137:{31,49,52}, tlb.scala:147:20
  wire [6:0]       _GEN_16 =
    {mpu_ppn_0[19], _GEN_3[16:15], mpu_ppn_0[13], mpu_ppn_0[8], mpu_ppn_0[5:4]};	// Parameters.scala:137:{31,49,52}, tlb.scala:147:20
  wire             newEntry_pw =
    legal_address_0
    & (~(|_GEN_13) | ~(|_GEN_14) | ~(|_GEN_15) | ~(|_GEN_16) | ~(|_GEN_10)) & _pmp_0_io_w;	// Parameters.scala:137:{49,52,67}, :615:89, tlb.scala:150:40, :157:84, :163:64
  wire [5:0]       _GEN_17 =
    {mpu_ppn_1[19], mpu_ppn_1[16:15], mpu_ppn_1[13], mpu_ppn_1[5:4]};	// Parameters.scala:137:{31,49,52}, tlb.scala:147:20
  wire [5:0]       _GEN_18 =
    {mpu_ppn_1[19], mpu_ppn_1[16:15], _GEN_6[9], mpu_ppn_1[8], mpu_ppn_1[5]};	// Parameters.scala:137:{31,49,52}, tlb.scala:147:20
  wire [2:0]       _GEN_19 = {mpu_ppn_1[19], mpu_ppn_1[16], ~(mpu_ppn_1[15])};	// Parameters.scala:137:{31,49,52}, tlb.scala:147:20
  wire [6:0]       _GEN_20 =
    {mpu_ppn_1[19], _GEN_8[16:15], mpu_ppn_1[13], mpu_ppn_1[8], mpu_ppn_1[5:4]};	// Parameters.scala:137:{31,49,52}, tlb.scala:147:20
  wire             newEntry_pal =
    legal_address_0
    & (~(|_GEN_13) | ~(|_GEN_14) | ~(|_GEN_15) | ~(|_GEN_16) | ~(|_GEN_10));	// Parameters.scala:137:{49,52,67}, :615:89, tlb.scala:157:84, :159:22
  wire             newEntry_paa =
    legal_address_0
    & (~(|_GEN_13) | ~(|_GEN_14) | ~(|_GEN_15) | ~(|_GEN_16) | ~(|_GEN_10));	// Parameters.scala:137:{49,52,67}, :615:89, tlb.scala:157:84, :159:22
  wire             newEntry_eff =
    legal_address_0
    & ({mpu_ppn_0[19],
        mpu_ppn_0[16],
        mpu_ppn_0[14:13],
        mpu_ppn_0[5:4],
        mpu_ppn_0[1]} == 7'h0
       | {mpu_ppn_0[19],
          mpu_ppn_0[16],
          mpu_ppn_0[14],
          _GEN_1[9],
          mpu_ppn_0[8],
          mpu_ppn_0[5:4]} == 7'h0
       | {mpu_ppn_0[19],
          mpu_ppn_0[16],
          mpu_ppn_0[14],
          _GEN_0[13],
          mpu_ppn_0[8],
          _GEN_0[5:4],
          mpu_ppn_0[1]} == 8'h0 | {mpu_ppn_0[19], mpu_ppn_0[16], ~(mpu_ppn_0[14])} == 3'h0
       | {mpu_ppn_0[19],
          _GEN_9[3],
          _GEN_9[1:0],
          mpu_ppn_0[8],
          mpu_ppn_0[5:4],
          mpu_ppn_0[1]} == 8'h0);	// Parameters.scala:137:{31,49,52,67}, :615:89, Replacement.scala:168:70, tlb.scala:147:20, :148:20, :157:84, :159:22
  wire [24:0]      _hitsVec_T = sectored_entries_0_tag[26:2] ^ io_req_0_bits_vaddr[38:14];	// tlb.scala:60:43, :122:29, :142:47
  wire [24:0]      _hitsVec_T_5 =
    sectored_entries_1_tag[26:2] ^ io_req_0_bits_vaddr[38:14];	// tlb.scala:60:43, :122:29, :142:47
  wire [24:0]      _hitsVec_T_10 =
    sectored_entries_2_tag[26:2] ^ io_req_0_bits_vaddr[38:14];	// tlb.scala:60:43, :122:29, :142:47
  wire [24:0]      _hitsVec_T_15 =
    sectored_entries_3_tag[26:2] ^ io_req_0_bits_vaddr[38:14];	// tlb.scala:60:43, :122:29, :142:47
  wire [24:0]      _hitsVec_T_20 =
    sectored_entries_4_tag[26:2] ^ io_req_0_bits_vaddr[38:14];	// tlb.scala:60:43, :122:29, :142:47
  wire [24:0]      _hitsVec_T_25 =
    sectored_entries_5_tag[26:2] ^ io_req_0_bits_vaddr[38:14];	// tlb.scala:60:43, :122:29, :142:47
  wire [24:0]      _hitsVec_T_30 =
    sectored_entries_6_tag[26:2] ^ io_req_0_bits_vaddr[38:14];	// tlb.scala:60:43, :122:29, :142:47
  wire [24:0]      _hitsVec_T_35 =
    sectored_entries_7_tag[26:2] ^ io_req_0_bits_vaddr[38:14];	// tlb.scala:60:43, :122:29, :142:47
  wire [24:0]      _hitsVec_T_120 =
    sectored_entries_0_tag[26:2] ^ io_req_1_bits_vaddr[38:14];	// tlb.scala:60:43, :122:29, :142:47
  wire [24:0]      _hitsVec_T_125 =
    sectored_entries_1_tag[26:2] ^ io_req_1_bits_vaddr[38:14];	// tlb.scala:60:43, :122:29, :142:47
  wire [24:0]      _hitsVec_T_130 =
    sectored_entries_2_tag[26:2] ^ io_req_1_bits_vaddr[38:14];	// tlb.scala:60:43, :122:29, :142:47
  wire [24:0]      _hitsVec_T_135 =
    sectored_entries_3_tag[26:2] ^ io_req_1_bits_vaddr[38:14];	// tlb.scala:60:43, :122:29, :142:47
  wire [24:0]      _hitsVec_T_140 =
    sectored_entries_4_tag[26:2] ^ io_req_1_bits_vaddr[38:14];	// tlb.scala:60:43, :122:29, :142:47
  wire [24:0]      _hitsVec_T_145 =
    sectored_entries_5_tag[26:2] ^ io_req_1_bits_vaddr[38:14];	// tlb.scala:60:43, :122:29, :142:47
  wire [24:0]      _hitsVec_T_150 =
    sectored_entries_6_tag[26:2] ^ io_req_1_bits_vaddr[38:14];	// tlb.scala:60:43, :122:29, :142:47
  wire [24:0]      _hitsVec_T_155 =
    sectored_entries_7_tag[26:2] ^ io_req_1_bits_vaddr[38:14];	// tlb.scala:60:43, :122:29, :142:47
  wire             ignore_1 = superpage_entries_0_level == 2'h0;	// tlb.scala:66:30, :123:30, :129:22
  wire             ignore_4 = superpage_entries_1_level == 2'h0;	// tlb.scala:66:30, :123:30, :129:22
  wire             ignore_7 = superpage_entries_2_level == 2'h0;	// tlb.scala:66:30, :123:30, :129:22
  wire             ignore_10 = superpage_entries_3_level == 2'h0;	// tlb.scala:66:30, :123:30, :129:22
  wire [3:0]       _GEN_21 =
    {{sectored_entries_0_valid_3},
     {sectored_entries_0_valid_2},
     {sectored_entries_0_valid_1},
     {sectored_entries_0_valid_0}};	// tlb.scala:72:20, :122:29
  wire             hitsVec_0_0 =
    vm_enabled_0 & _GEN_21[io_req_0_bits_vaddr[13:12]] & _hitsVec_T == 25'h0;	// package.scala:154:13, tlb.scala:60:{43,73}, :72:20, :139:93, :171:69
  wire [3:0]       _GEN_22 =
    {{sectored_entries_1_valid_3},
     {sectored_entries_1_valid_2},
     {sectored_entries_1_valid_1},
     {sectored_entries_1_valid_0}};	// tlb.scala:72:20, :122:29
  wire             hitsVec_0_1 =
    vm_enabled_0 & _GEN_22[io_req_0_bits_vaddr[13:12]] & _hitsVec_T_5 == 25'h0;	// package.scala:154:13, tlb.scala:60:{43,73}, :72:20, :139:93, :171:69
  wire [3:0]       _GEN_23 =
    {{sectored_entries_2_valid_3},
     {sectored_entries_2_valid_2},
     {sectored_entries_2_valid_1},
     {sectored_entries_2_valid_0}};	// tlb.scala:72:20, :122:29
  wire             hitsVec_0_2 =
    vm_enabled_0 & _GEN_23[io_req_0_bits_vaddr[13:12]] & _hitsVec_T_10 == 25'h0;	// package.scala:154:13, tlb.scala:60:{43,73}, :72:20, :139:93, :171:69
  wire [3:0]       _GEN_24 =
    {{sectored_entries_3_valid_3},
     {sectored_entries_3_valid_2},
     {sectored_entries_3_valid_1},
     {sectored_entries_3_valid_0}};	// tlb.scala:72:20, :122:29
  wire             hitsVec_0_3 =
    vm_enabled_0 & _GEN_24[io_req_0_bits_vaddr[13:12]] & _hitsVec_T_15 == 25'h0;	// package.scala:154:13, tlb.scala:60:{43,73}, :72:20, :139:93, :171:69
  wire [3:0]       _GEN_25 =
    {{sectored_entries_4_valid_3},
     {sectored_entries_4_valid_2},
     {sectored_entries_4_valid_1},
     {sectored_entries_4_valid_0}};	// tlb.scala:72:20, :122:29
  wire             hitsVec_0_4 =
    vm_enabled_0 & _GEN_25[io_req_0_bits_vaddr[13:12]] & _hitsVec_T_20 == 25'h0;	// package.scala:154:13, tlb.scala:60:{43,73}, :72:20, :139:93, :171:69
  wire [3:0]       _GEN_26 =
    {{sectored_entries_5_valid_3},
     {sectored_entries_5_valid_2},
     {sectored_entries_5_valid_1},
     {sectored_entries_5_valid_0}};	// tlb.scala:72:20, :122:29
  wire             hitsVec_0_5 =
    vm_enabled_0 & _GEN_26[io_req_0_bits_vaddr[13:12]] & _hitsVec_T_25 == 25'h0;	// package.scala:154:13, tlb.scala:60:{43,73}, :72:20, :139:93, :171:69
  wire [3:0]       _GEN_27 =
    {{sectored_entries_6_valid_3},
     {sectored_entries_6_valid_2},
     {sectored_entries_6_valid_1},
     {sectored_entries_6_valid_0}};	// tlb.scala:72:20, :122:29
  wire             hitsVec_0_6 =
    vm_enabled_0 & _GEN_27[io_req_0_bits_vaddr[13:12]] & _hitsVec_T_30 == 25'h0;	// package.scala:154:13, tlb.scala:60:{43,73}, :72:20, :139:93, :171:69
  wire [3:0]       _GEN_28 =
    {{sectored_entries_7_valid_3},
     {sectored_entries_7_valid_2},
     {sectored_entries_7_valid_1},
     {sectored_entries_7_valid_0}};	// tlb.scala:72:20, :122:29
  wire             hitsVec_0_7 =
    vm_enabled_0 & _GEN_28[io_req_0_bits_vaddr[13:12]] & _hitsVec_T_35 == 25'h0;	// package.scala:154:13, tlb.scala:60:{43,73}, :72:20, :139:93, :171:69
  wire             hitsVec_0_8 =
    vm_enabled_0 & superpage_entries_0_valid_0
    & superpage_entries_0_tag[26:18] == io_req_0_bits_vaddr[38:30]
    & (ignore_1 | superpage_entries_0_tag[17:9] == io_req_0_bits_vaddr[29:21]);	// tlb.scala:66:30, :67:{42,48,79,86}, :123:30, :139:93, :171:69
  wire             hitsVec_0_9 =
    vm_enabled_0 & superpage_entries_1_valid_0
    & superpage_entries_1_tag[26:18] == io_req_0_bits_vaddr[38:30]
    & (ignore_4 | superpage_entries_1_tag[17:9] == io_req_0_bits_vaddr[29:21]);	// tlb.scala:66:30, :67:{42,48,79,86}, :123:30, :139:93, :171:69
  wire             hitsVec_0_10 =
    vm_enabled_0 & superpage_entries_2_valid_0
    & superpage_entries_2_tag[26:18] == io_req_0_bits_vaddr[38:30]
    & (ignore_7 | superpage_entries_2_tag[17:9] == io_req_0_bits_vaddr[29:21]);	// tlb.scala:66:30, :67:{42,48,79,86}, :123:30, :139:93, :171:69
  wire             hitsVec_0_11 =
    vm_enabled_0 & superpage_entries_3_valid_0
    & superpage_entries_3_tag[26:18] == io_req_0_bits_vaddr[38:30]
    & (ignore_10 | superpage_entries_3_tag[17:9] == io_req_0_bits_vaddr[29:21]);	// tlb.scala:66:30, :67:{42,48,79,86}, :123:30, :139:93, :171:69
  wire             hitsVec_0_12 =
    vm_enabled_0 & special_entry_valid_0
    & special_entry_tag[26:18] == io_req_0_bits_vaddr[38:30]
    & (ignore_13 | special_entry_tag[17:9] == io_req_0_bits_vaddr[29:21])
    & (~(special_entry_level[1]) | special_entry_tag[8:0] == io_req_0_bits_vaddr[20:12]);	// tlb.scala:67:{42,48,79,86}, :80:31, :124:56, :139:93, :171:69
  wire             hitsVec_1_0 =
    vm_enabled_1 & _GEN_21[io_req_1_bits_vaddr[13:12]] & _hitsVec_T_120 == 25'h0;	// package.scala:154:13, tlb.scala:60:{43,73}, :72:20, :139:109, :171:69
  wire             hitsVec_1_1 =
    vm_enabled_1 & _GEN_22[io_req_1_bits_vaddr[13:12]] & _hitsVec_T_125 == 25'h0;	// package.scala:154:13, tlb.scala:60:{43,73}, :72:20, :139:109, :171:69
  wire             hitsVec_1_2 =
    vm_enabled_1 & _GEN_23[io_req_1_bits_vaddr[13:12]] & _hitsVec_T_130 == 25'h0;	// package.scala:154:13, tlb.scala:60:{43,73}, :72:20, :139:109, :171:69
  wire             hitsVec_1_3 =
    vm_enabled_1 & _GEN_24[io_req_1_bits_vaddr[13:12]] & _hitsVec_T_135 == 25'h0;	// package.scala:154:13, tlb.scala:60:{43,73}, :72:20, :139:109, :171:69
  wire             hitsVec_1_4 =
    vm_enabled_1 & _GEN_25[io_req_1_bits_vaddr[13:12]] & _hitsVec_T_140 == 25'h0;	// package.scala:154:13, tlb.scala:60:{43,73}, :72:20, :139:109, :171:69
  wire             hitsVec_1_5 =
    vm_enabled_1 & _GEN_26[io_req_1_bits_vaddr[13:12]] & _hitsVec_T_145 == 25'h0;	// package.scala:154:13, tlb.scala:60:{43,73}, :72:20, :139:109, :171:69
  wire             hitsVec_1_6 =
    vm_enabled_1 & _GEN_27[io_req_1_bits_vaddr[13:12]] & _hitsVec_T_150 == 25'h0;	// package.scala:154:13, tlb.scala:60:{43,73}, :72:20, :139:109, :171:69
  wire             hitsVec_1_7 =
    vm_enabled_1 & _GEN_28[io_req_1_bits_vaddr[13:12]] & _hitsVec_T_155 == 25'h0;	// package.scala:154:13, tlb.scala:60:{43,73}, :72:20, :139:109, :171:69
  wire             hitsVec_1_8 =
    vm_enabled_1 & superpage_entries_0_valid_0
    & superpage_entries_0_tag[26:18] == io_req_1_bits_vaddr[38:30]
    & (ignore_1 | superpage_entries_0_tag[17:9] == io_req_1_bits_vaddr[29:21]);	// tlb.scala:66:30, :67:{42,48,79,86}, :123:30, :139:109, :171:69
  wire             hitsVec_1_9 =
    vm_enabled_1 & superpage_entries_1_valid_0
    & superpage_entries_1_tag[26:18] == io_req_1_bits_vaddr[38:30]
    & (ignore_4 | superpage_entries_1_tag[17:9] == io_req_1_bits_vaddr[29:21]);	// tlb.scala:66:30, :67:{42,48,79,86}, :123:30, :139:109, :171:69
  wire             hitsVec_1_10 =
    vm_enabled_1 & superpage_entries_2_valid_0
    & superpage_entries_2_tag[26:18] == io_req_1_bits_vaddr[38:30]
    & (ignore_7 | superpage_entries_2_tag[17:9] == io_req_1_bits_vaddr[29:21]);	// tlb.scala:66:30, :67:{42,48,79,86}, :123:30, :139:109, :171:69
  wire             hitsVec_1_11 =
    vm_enabled_1 & superpage_entries_3_valid_0
    & superpage_entries_3_tag[26:18] == io_req_1_bits_vaddr[38:30]
    & (ignore_10 | superpage_entries_3_tag[17:9] == io_req_1_bits_vaddr[29:21]);	// tlb.scala:66:30, :67:{42,48,79,86}, :123:30, :139:109, :171:69
  wire             hitsVec_1_12 =
    vm_enabled_1 & special_entry_valid_0
    & special_entry_tag[26:18] == io_req_1_bits_vaddr[38:30]
    & (ignore_13 | special_entry_tag[17:9] == io_req_1_bits_vaddr[29:21])
    & (~(special_entry_level[1]) | special_entry_tag[8:0] == io_req_1_bits_vaddr[20:12]);	// tlb.scala:67:{42,48,79,86}, :80:31, :124:56, :139:109, :171:69
  wire [13:0]      hits_0 =
    {~vm_enabled_0,
     hitsVec_0_12,
     hitsVec_0_11,
     hitsVec_0_10,
     hitsVec_0_9,
     hitsVec_0_8,
     hitsVec_0_7,
     hitsVec_0_6,
     hitsVec_0_5,
     hitsVec_0_4,
     hitsVec_0_3,
     hitsVec_0_2,
     hitsVec_0_1,
     hitsVec_0_0};	// Cat.scala:30:58, tlb.scala:139:93, :171:69, :173:32
  wire [13:0]      hits_1 =
    {~vm_enabled_1,
     hitsVec_1_12,
     hitsVec_1_11,
     hitsVec_1_10,
     hitsVec_1_9,
     hitsVec_1_8,
     hitsVec_1_7,
     hitsVec_1_6,
     hitsVec_1_5,
     hitsVec_1_4,
     hitsVec_1_3,
     hitsVec_1_2,
     hitsVec_1_1,
     hitsVec_1_0};	// Cat.scala:30:58, tlb.scala:139:109, :171:69, :173:32
  wire [3:0][33:0] _GEN_29 =
    {{sectored_entries_0_data_3},
     {sectored_entries_0_data_2},
     {sectored_entries_0_data_1},
     {sectored_entries_0_data_0}};	// tlb.scala:122:29
  wire [33:0]      _normal_entries_WIRE_1 = _GEN_29[io_req_0_bits_vaddr[13:12]];	// package.scala:154:13
  wire [3:0][33:0] _GEN_30 =
    {{sectored_entries_1_data_3},
     {sectored_entries_1_data_2},
     {sectored_entries_1_data_1},
     {sectored_entries_1_data_0}};	// tlb.scala:122:29
  wire [33:0]      _normal_entries_WIRE_3 = _GEN_30[io_req_0_bits_vaddr[13:12]];	// package.scala:154:13
  wire [3:0][33:0] _GEN_31 =
    {{sectored_entries_2_data_3},
     {sectored_entries_2_data_2},
     {sectored_entries_2_data_1},
     {sectored_entries_2_data_0}};	// tlb.scala:122:29
  wire [33:0]      _normal_entries_WIRE_5 = _GEN_31[io_req_0_bits_vaddr[13:12]];	// package.scala:154:13
  wire [3:0][33:0] _GEN_32 =
    {{sectored_entries_3_data_3},
     {sectored_entries_3_data_2},
     {sectored_entries_3_data_1},
     {sectored_entries_3_data_0}};	// tlb.scala:122:29
  wire [33:0]      _normal_entries_WIRE_7 = _GEN_32[io_req_0_bits_vaddr[13:12]];	// package.scala:154:13
  wire [3:0][33:0] _GEN_33 =
    {{sectored_entries_4_data_3},
     {sectored_entries_4_data_2},
     {sectored_entries_4_data_1},
     {sectored_entries_4_data_0}};	// tlb.scala:122:29
  wire [33:0]      _normal_entries_WIRE_9 = _GEN_33[io_req_0_bits_vaddr[13:12]];	// package.scala:154:13
  wire [3:0][33:0] _GEN_34 =
    {{sectored_entries_5_data_3},
     {sectored_entries_5_data_2},
     {sectored_entries_5_data_1},
     {sectored_entries_5_data_0}};	// tlb.scala:122:29
  wire [33:0]      _normal_entries_WIRE_11 = _GEN_34[io_req_0_bits_vaddr[13:12]];	// package.scala:154:13
  wire [3:0][33:0] _GEN_35 =
    {{sectored_entries_6_data_3},
     {sectored_entries_6_data_2},
     {sectored_entries_6_data_1},
     {sectored_entries_6_data_0}};	// tlb.scala:122:29
  wire [33:0]      _normal_entries_WIRE_13 = _GEN_35[io_req_0_bits_vaddr[13:12]];	// package.scala:154:13
  wire [3:0][33:0] _GEN_36 =
    {{sectored_entries_7_data_3},
     {sectored_entries_7_data_2},
     {sectored_entries_7_data_1},
     {sectored_entries_7_data_0}};	// tlb.scala:122:29
  wire [33:0]      _normal_entries_WIRE_15 = _GEN_36[io_req_0_bits_vaddr[13:12]];	// package.scala:154:13
  wire [33:0]      _normal_entries_WIRE_26 = _GEN_29[io_req_1_bits_vaddr[13:12]];	// package.scala:154:13
  wire [33:0]      _normal_entries_WIRE_28 = _GEN_30[io_req_1_bits_vaddr[13:12]];	// package.scala:154:13
  wire [33:0]      _normal_entries_WIRE_30 = _GEN_31[io_req_1_bits_vaddr[13:12]];	// package.scala:154:13
  wire [33:0]      _normal_entries_WIRE_32 = _GEN_32[io_req_1_bits_vaddr[13:12]];	// package.scala:154:13
  wire [33:0]      _normal_entries_WIRE_34 = _GEN_33[io_req_1_bits_vaddr[13:12]];	// package.scala:154:13
  wire [33:0]      _normal_entries_WIRE_36 = _GEN_34[io_req_1_bits_vaddr[13:12]];	// package.scala:154:13
  wire [33:0]      _normal_entries_WIRE_38 = _GEN_35[io_req_1_bits_vaddr[13:12]];	// package.scala:154:13
  wire [33:0]      _normal_entries_WIRE_40 = _GEN_36[io_req_1_bits_vaddr[13:12]];	// package.scala:154:13
  wire [12:0]      priv_rw_ok_0 =
    (~(io_ptw_status_dprv[0]) | io_ptw_status_sum
       ? {special_entry_data_0[13],
          superpage_entries_3_data_0[13],
          superpage_entries_2_data_0[13],
          superpage_entries_1_data_0[13],
          superpage_entries_0_data_0[13],
          _normal_entries_WIRE_15[13],
          _normal_entries_WIRE_13[13],
          _normal_entries_WIRE_11[13],
          _normal_entries_WIRE_9[13],
          _normal_entries_WIRE_7[13],
          _normal_entries_WIRE_5[13],
          _normal_entries_WIRE_3[13],
          _normal_entries_WIRE_1[13]}
       : 13'h0)
    | (io_ptw_status_dprv[0]
         ? ~{special_entry_data_0[13],
             superpage_entries_3_data_0[13],
             superpage_entries_2_data_0[13],
             superpage_entries_1_data_0[13],
             superpage_entries_0_data_0[13],
             _normal_entries_WIRE_15[13],
             _normal_entries_WIRE_13[13],
             _normal_entries_WIRE_11[13],
             _normal_entries_WIRE_9[13],
             _normal_entries_WIRE_7[13],
             _normal_entries_WIRE_5[13],
             _normal_entries_WIRE_3[13],
             _normal_entries_WIRE_1[13]}
         : 13'h0);	// Cat.scala:30:58, tlb.scala:58:79, :123:30, :124:56, :137:20, :215:{39,40,48,103,108,117}
  wire [12:0]      priv_rw_ok_1 =
    (~(io_ptw_status_dprv[0]) | io_ptw_status_sum
       ? {special_entry_data_0[13],
          superpage_entries_3_data_0[13],
          superpage_entries_2_data_0[13],
          superpage_entries_1_data_0[13],
          superpage_entries_0_data_0[13],
          _normal_entries_WIRE_40[13],
          _normal_entries_WIRE_38[13],
          _normal_entries_WIRE_36[13],
          _normal_entries_WIRE_34[13],
          _normal_entries_WIRE_32[13],
          _normal_entries_WIRE_30[13],
          _normal_entries_WIRE_28[13],
          _normal_entries_WIRE_26[13]}
       : 13'h0)
    | (io_ptw_status_dprv[0]
         ? ~{special_entry_data_0[13],
             superpage_entries_3_data_0[13],
             superpage_entries_2_data_0[13],
             superpage_entries_1_data_0[13],
             superpage_entries_0_data_0[13],
             _normal_entries_WIRE_40[13],
             _normal_entries_WIRE_38[13],
             _normal_entries_WIRE_36[13],
             _normal_entries_WIRE_34[13],
             _normal_entries_WIRE_32[13],
             _normal_entries_WIRE_30[13],
             _normal_entries_WIRE_28[13],
             _normal_entries_WIRE_26[13]}
         : 13'h0);	// Cat.scala:30:58, tlb.scala:58:79, :123:30, :124:56, :137:20, :215:{39,40,48,103,108,117}
  wire [12:0]      r_array_lo_2 =
    priv_rw_ok_0
    & ({special_entry_data_0[8],
        superpage_entries_3_data_0[8],
        superpage_entries_2_data_0[8],
        superpage_entries_1_data_0[8],
        superpage_entries_0_data_0[8],
        _normal_entries_WIRE_15[8],
        _normal_entries_WIRE_13[8],
        _normal_entries_WIRE_11[8],
        _normal_entries_WIRE_9[8],
        _normal_entries_WIRE_7[8],
        _normal_entries_WIRE_5[8],
        _normal_entries_WIRE_3[8],
        _normal_entries_WIRE_1[8]}
       | (io_ptw_status_mxr
            ? {special_entry_data_0[9],
               superpage_entries_3_data_0[9],
               superpage_entries_2_data_0[9],
               superpage_entries_1_data_0[9],
               superpage_entries_0_data_0[9],
               _normal_entries_WIRE_15[9],
               _normal_entries_WIRE_13[9],
               _normal_entries_WIRE_11[9],
               _normal_entries_WIRE_9[9],
               _normal_entries_WIRE_7[9],
               _normal_entries_WIRE_5[9],
               _normal_entries_WIRE_3[9],
               _normal_entries_WIRE_1[9]}
            : 13'h0));	// Cat.scala:30:58, tlb.scala:58:79, :123:30, :124:56, :215:{39,103}, :217:{62,93,98}
  wire [12:0]      r_array_lo_5 =
    priv_rw_ok_1
    & ({special_entry_data_0[8],
        superpage_entries_3_data_0[8],
        superpage_entries_2_data_0[8],
        superpage_entries_1_data_0[8],
        superpage_entries_0_data_0[8],
        _normal_entries_WIRE_40[8],
        _normal_entries_WIRE_38[8],
        _normal_entries_WIRE_36[8],
        _normal_entries_WIRE_34[8],
        _normal_entries_WIRE_32[8],
        _normal_entries_WIRE_30[8],
        _normal_entries_WIRE_28[8],
        _normal_entries_WIRE_26[8]}
       | (io_ptw_status_mxr
            ? {special_entry_data_0[9],
               superpage_entries_3_data_0[9],
               superpage_entries_2_data_0[9],
               superpage_entries_1_data_0[9],
               superpage_entries_0_data_0[9],
               _normal_entries_WIRE_40[9],
               _normal_entries_WIRE_38[9],
               _normal_entries_WIRE_36[9],
               _normal_entries_WIRE_34[9],
               _normal_entries_WIRE_32[9],
               _normal_entries_WIRE_30[9],
               _normal_entries_WIRE_28[9],
               _normal_entries_WIRE_26[9]}
            : 13'h0));	// Cat.scala:30:58, tlb.scala:58:79, :123:30, :124:56, :215:{39,103}, :217:{62,93,98}
  wire [12:0]      w_array_lo_1 =
    priv_rw_ok_0
    & {special_entry_data_0[10],
       superpage_entries_3_data_0[10],
       superpage_entries_2_data_0[10],
       superpage_entries_1_data_0[10],
       superpage_entries_0_data_0[10],
       _normal_entries_WIRE_15[10],
       _normal_entries_WIRE_13[10],
       _normal_entries_WIRE_11[10],
       _normal_entries_WIRE_9[10],
       _normal_entries_WIRE_7[10],
       _normal_entries_WIRE_5[10],
       _normal_entries_WIRE_3[10],
       _normal_entries_WIRE_1[10]};	// Cat.scala:30:58, tlb.scala:58:79, :123:30, :124:56, :215:103, :218:62
  wire [12:0]      w_array_lo_3 =
    priv_rw_ok_1
    & {special_entry_data_0[10],
       superpage_entries_3_data_0[10],
       superpage_entries_2_data_0[10],
       superpage_entries_1_data_0[10],
       superpage_entries_0_data_0[10],
       _normal_entries_WIRE_40[10],
       _normal_entries_WIRE_38[10],
       _normal_entries_WIRE_36[10],
       _normal_entries_WIRE_34[10],
       _normal_entries_WIRE_32[10],
       _normal_entries_WIRE_30[10],
       _normal_entries_WIRE_28[10],
       _normal_entries_WIRE_26[10]};	// Cat.scala:30:58, tlb.scala:58:79, :123:30, :124:56, :215:103, :218:62
  wire [13:0]      _px_array_T_2 =
    {1'h1,
     ~(special_entry_data_0[11]),
     ~(superpage_entries_3_data_0[11]),
     ~(superpage_entries_2_data_0[11]),
     ~(superpage_entries_1_data_0[11]),
     ~(superpage_entries_0_data_0[11]),
     ~(_normal_entries_WIRE_15[11]),
     ~(_normal_entries_WIRE_13[11]),
     ~(_normal_entries_WIRE_11[11]),
     ~(_normal_entries_WIRE_9[11]),
     ~(_normal_entries_WIRE_7[11]),
     ~(_normal_entries_WIRE_5[11]),
     ~(_normal_entries_WIRE_3[11]),
     ~(_normal_entries_WIRE_1[11])};	// Cat.scala:30:58, tlb.scala:58:79, :123:30, :124:56, :139:112, :220:116
  wire [13:0]      _px_array_T_6 =
    {1'h1,
     ~(special_entry_data_0[11]),
     ~(superpage_entries_3_data_0[11]),
     ~(superpage_entries_2_data_0[11]),
     ~(superpage_entries_1_data_0[11]),
     ~(superpage_entries_0_data_0[11]),
     ~(_normal_entries_WIRE_40[11]),
     ~(_normal_entries_WIRE_38[11]),
     ~(_normal_entries_WIRE_36[11]),
     ~(_normal_entries_WIRE_34[11]),
     ~(_normal_entries_WIRE_32[11]),
     ~(_normal_entries_WIRE_30[11]),
     ~(_normal_entries_WIRE_28[11]),
     ~(_normal_entries_WIRE_26[11])};	// Cat.scala:30:58, tlb.scala:58:79, :123:30, :124:56, :139:112, :220:116
  wire [13:0]      eff_array_1 =
    {{2{legal_address_1
          & ({mpu_ppn_1[19],
              mpu_ppn_1[16],
              mpu_ppn_1[14:13],
              mpu_ppn_1[5:4],
              mpu_ppn_1[1]} == 7'h0
             | {mpu_ppn_1[19],
                mpu_ppn_1[16],
                mpu_ppn_1[14],
                _GEN_6[9],
                mpu_ppn_1[8],
                mpu_ppn_1[5:4]} == 7'h0
             | {mpu_ppn_1[19],
                mpu_ppn_1[16],
                mpu_ppn_1[14],
                _GEN_5[13],
                mpu_ppn_1[8],
                _GEN_5[5:4],
                mpu_ppn_1[1]} == 8'h0
             | {mpu_ppn_1[19], mpu_ppn_1[16], ~(mpu_ppn_1[14])} == 3'h0
             | {mpu_ppn_1[19],
                _GEN_11[3],
                _GEN_11[1:0],
                mpu_ppn_1[8],
                mpu_ppn_1[5:4],
                mpu_ppn_1[1]} == 8'h0)}},
     superpage_entries_3_data_0[2],
     superpage_entries_2_data_0[2],
     superpage_entries_1_data_0[2],
     superpage_entries_0_data_0[2],
     _normal_entries_WIRE_40[2],
     _normal_entries_WIRE_38[2],
     _normal_entries_WIRE_36[2],
     _normal_entries_WIRE_34[2],
     _normal_entries_WIRE_32[2],
     _normal_entries_WIRE_30[2],
     _normal_entries_WIRE_28[2],
     _normal_entries_WIRE_26[2]};	// Bitwise.scala:72:12, Cat.scala:30:58, Parameters.scala:137:{31,49,52,67}, :615:89, Replacement.scala:168:70, tlb.scala:58:79, :123:30, :147:20, :148:20, :157:84, :159:22
  wire [13:0]      lrscAllowed_0 =
    {{2{newEntry_c}},
     superpage_entries_3_data_0[1],
     superpage_entries_2_data_0[1],
     superpage_entries_1_data_0[1],
     superpage_entries_0_data_0[1],
     _normal_entries_WIRE_15[1],
     _normal_entries_WIRE_13[1],
     _normal_entries_WIRE_11[1],
     _normal_entries_WIRE_9[1],
     _normal_entries_WIRE_7[1],
     _normal_entries_WIRE_5[1],
     _normal_entries_WIRE_3[1],
     _normal_entries_WIRE_1[1]};	// Bitwise.scala:72:12, Cat.scala:30:58, tlb.scala:58:79, :123:30, :159:22
  wire [13:0]      lrscAllowed_1 =
    {{2{legal_address_1
          & ({mpu_ppn_1[19], _GEN_8[16], mpu_ppn_1[14:13]} == 4'h0 | ~(|_GEN_12))}},
     superpage_entries_3_data_0[1],
     superpage_entries_2_data_0[1],
     superpage_entries_1_data_0[1],
     superpage_entries_0_data_0[1],
     _normal_entries_WIRE_40[1],
     _normal_entries_WIRE_38[1],
     _normal_entries_WIRE_36[1],
     _normal_entries_WIRE_34[1],
     _normal_entries_WIRE_32[1],
     _normal_entries_WIRE_30[1],
     _normal_entries_WIRE_28[1],
     _normal_entries_WIRE_26[1]};	// Bitwise.scala:72:12, Cat.scala:30:58, Parameters.scala:137:{31,49,52,67}, :615:89, tlb.scala:58:79, :123:30, :147:20, :157:84, :159:22, :231:89
  wire [3:0]       _GEN_37 =
    io_req_1_bits_vaddr[3:0] & (4'h1 << io_req_1_bits_size) - 4'h1;	// OneHot.scala:58:35, tlb.scala:231:{56,89}
  wire             bad_va_0 =
    vm_enabled_0
    & ~(io_req_0_bits_vaddr[39:38] == 2'h0 | (&(io_req_0_bits_vaddr[39:38])));	// tlb.scala:129:22, :139:93, :232:134, :237:46, :238:{49,63,71,86}
  wire             bad_va_1 =
    vm_enabled_1
    & ~(io_req_1_bits_vaddr[39:38] == 2'h0 | (&(io_req_1_bits_vaddr[39:38])));	// tlb.scala:129:22, :139:109, :232:134, :237:46, :238:{49,63,71,86}
  wire             _cmd_read_T_1 = io_req_0_bits_cmd == 5'h6;	// package.scala:15:47
  wire             _cmd_write_T_3 = io_req_0_bits_cmd == 5'h7;	// package.scala:15:47
  wire             _cmd_read_T_24 = io_req_1_bits_cmd == 5'h6;	// package.scala:15:47
  wire             _cmd_write_T_26 = io_req_1_bits_cmd == 5'h7;	// package.scala:15:47
  wire             _cmd_write_T_5 = io_req_0_bits_cmd == 5'h4;	// package.scala:15:47
  wire             _cmd_write_T_6 = io_req_0_bits_cmd == 5'h9;	// package.scala:15:47
  wire             _cmd_write_T_7 = io_req_0_bits_cmd == 5'hA;	// package.scala:15:47
  wire             _cmd_write_T_8 = io_req_0_bits_cmd == 5'hB;	// package.scala:15:47
  wire             _cmd_write_T_28 = io_req_1_bits_cmd == 5'h4;	// package.scala:15:47
  wire             _cmd_write_T_29 = io_req_1_bits_cmd == 5'h9;	// package.scala:15:47
  wire             _cmd_write_T_30 = io_req_1_bits_cmd == 5'hA;	// package.scala:15:47
  wire             _cmd_write_T_31 = io_req_1_bits_cmd == 5'hB;	// package.scala:15:47
  wire             _cmd_write_T_12 = io_req_0_bits_cmd == 5'h8;	// package.scala:15:47
  wire             _cmd_write_T_13 = io_req_0_bits_cmd == 5'hC;	// package.scala:15:47
  wire             _cmd_write_T_14 = io_req_0_bits_cmd == 5'hD;	// package.scala:15:47
  wire             _cmd_write_T_15 = io_req_0_bits_cmd == 5'hE;	// package.scala:15:47
  wire             _cmd_write_T_16 = io_req_0_bits_cmd == 5'hF;	// package.scala:15:47
  wire             _cmd_write_T_35 = io_req_1_bits_cmd == 5'h8;	// package.scala:15:47
  wire             _cmd_write_T_36 = io_req_1_bits_cmd == 5'hC;	// package.scala:15:47
  wire             _cmd_write_T_37 = io_req_1_bits_cmd == 5'hD;	// package.scala:15:47
  wire             _cmd_write_T_38 = io_req_1_bits_cmd == 5'hE;	// package.scala:15:47
  wire             _cmd_write_T_39 = io_req_1_bits_cmd == 5'hF;	// package.scala:15:47
  wire             cmd_read_0 =
    io_req_0_bits_cmd == 5'h0 | _cmd_read_T_1 | _cmd_write_T_3 | _cmd_write_T_5
    | _cmd_write_T_6 | _cmd_write_T_7 | _cmd_write_T_8 | _cmd_write_T_12 | _cmd_write_T_13
    | _cmd_write_T_14 | _cmd_write_T_15 | _cmd_write_T_16;	// Consts.scala:81:{31,75}, package.scala:15:47
  wire             cmd_read_1 =
    io_req_1_bits_cmd == 5'h0 | _cmd_read_T_24 | _cmd_write_T_26 | _cmd_write_T_28
    | _cmd_write_T_29 | _cmd_write_T_30 | _cmd_write_T_31 | _cmd_write_T_35
    | _cmd_write_T_36 | _cmd_write_T_37 | _cmd_write_T_38 | _cmd_write_T_39;	// Consts.scala:81:{31,75}, package.scala:15:47
  wire             cmd_write_perms_0 =
    io_req_0_bits_cmd == 5'h1 | io_req_0_bits_cmd == 5'h11 | _cmd_write_T_3
    | _cmd_write_T_5 | _cmd_write_T_6 | _cmd_write_T_7 | _cmd_write_T_8 | _cmd_write_T_12
    | _cmd_write_T_13 | _cmd_write_T_14 | _cmd_write_T_15 | _cmd_write_T_16;	// Consts.scala:82:{32,49,76}, package.scala:15:47, tlb.scala:231:89
  wire             cmd_write_perms_1 =
    io_req_1_bits_cmd == 5'h1 | io_req_1_bits_cmd == 5'h11 | _cmd_write_T_26
    | _cmd_write_T_28 | _cmd_write_T_29 | _cmd_write_T_30 | _cmd_write_T_31
    | _cmd_write_T_35 | _cmd_write_T_36 | _cmd_write_T_37 | _cmd_write_T_38
    | _cmd_write_T_39;	// Consts.scala:82:{32,49,76}, package.scala:15:47, tlb.scala:231:89
  wire [13:0]      ae_array_0 =
    ((|(io_req_0_bits_vaddr[3:0] & (4'h1 << io_req_0_bits_size) - 4'h1))
       ? {{2{newEntry_eff}},
          superpage_entries_3_data_0[2],
          superpage_entries_2_data_0[2],
          superpage_entries_1_data_0[2],
          superpage_entries_0_data_0[2],
          _normal_entries_WIRE_15[2],
          _normal_entries_WIRE_13[2],
          _normal_entries_WIRE_11[2],
          _normal_entries_WIRE_9[2],
          _normal_entries_WIRE_7[2],
          _normal_entries_WIRE_5[2],
          _normal_entries_WIRE_3[2],
          _normal_entries_WIRE_1[2]}
       : 14'h0) | (_cmd_read_T_1 | _cmd_write_T_3 ? ~lrscAllowed_0 : 14'h0);	// Bitwise.scala:72:12, Cat.scala:30:58, OneHot.scala:58:35, package.scala:15:47, :72:59, tlb.scala:58:79, :123:30, :159:22, :231:{56,89,97}, :252:{8,43}, :253:{8,24}, :262:32
  wire [13:0]      ae_array_1 =
    ((|_GEN_37) ? eff_array_1 : 14'h0)
    | (_cmd_read_T_24 | _cmd_write_T_26 ? ~lrscAllowed_1 : 14'h0);	// Cat.scala:30:58, package.scala:15:47, :72:59, tlb.scala:231:{56,97}, :252:{8,43}, :253:{8,24}, :262:32
  wire             tlb_miss_0 =
    vm_enabled_0 & ~bad_va_0
    & {hitsVec_0_12,
       hitsVec_0_11,
       hitsVec_0_10,
       hitsVec_0_9,
       hitsVec_0_8,
       hitsVec_0_7,
       hitsVec_0_6,
       hitsVec_0_5,
       hitsVec_0_4,
       hitsVec_0_3,
       hitsVec_0_2,
       hitsVec_0_1,
       hitsVec_0_0} == 13'h0;	// tlb.scala:139:93, :171:69, :172:44, :215:39, :232:134, :269:44, :270:{49,60}
  wire             tlb_miss_1 =
    vm_enabled_1 & ~bad_va_1
    & {hitsVec_1_12,
       hitsVec_1_11,
       hitsVec_1_10,
       hitsVec_1_9,
       hitsVec_1_8,
       hitsVec_1_7,
       hitsVec_1_6,
       hitsVec_1_5,
       hitsVec_1_4,
       hitsVec_1_3,
       hitsVec_1_2,
       hitsVec_1_1,
       hitsVec_1_0} == 13'h0;	// tlb.scala:139:109, :171:69, :172:44, :215:39, :232:134, :269:44, :270:{49,60}
  reg  [6:0]       state_reg;	// Replacement.scala:168:70
  reg  [2:0]       state_reg_1;	// Replacement.scala:168:70
  wire             multipleHits_rightOne_1 = hitsVec_0_1 | hitsVec_0_2;	// Misc.scala:182:16, tlb.scala:171:69
  wire             multipleHits_leftOne_2 = hitsVec_0_0 | multipleHits_rightOne_1;	// Misc.scala:182:16, tlb.scala:171:69
  wire             multipleHits_rightOne_3 = hitsVec_0_4 | hitsVec_0_5;	// Misc.scala:182:16, tlb.scala:171:69
  wire             multipleHits_rightOne_4 = hitsVec_0_3 | multipleHits_rightOne_3;	// Misc.scala:182:16, tlb.scala:171:69
  wire             multipleHits_rightOne_6 = hitsVec_0_7 | hitsVec_0_8;	// Misc.scala:182:16, tlb.scala:171:69
  wire             multipleHits_leftOne_8 = hitsVec_0_6 | multipleHits_rightOne_6;	// Misc.scala:182:16, tlb.scala:171:69
  wire             multipleHits_leftOne_10 = hitsVec_0_9 | hitsVec_0_10;	// Misc.scala:182:16, tlb.scala:171:69
  wire             multipleHits_rightOne_9 = hitsVec_0_11 | hitsVec_0_12;	// Misc.scala:182:16, tlb.scala:171:69
  wire             multipleHits_rightOne_10 =
    multipleHits_leftOne_10 | multipleHits_rightOne_9;	// Misc.scala:182:16
  wire             multipleHits_0 =
    hitsVec_0_1 & hitsVec_0_2 | hitsVec_0_0 & multipleHits_rightOne_1 | hitsVec_0_4
    & hitsVec_0_5 | hitsVec_0_3 & multipleHits_rightOne_3 | multipleHits_leftOne_2
    & multipleHits_rightOne_4 | hitsVec_0_7 & hitsVec_0_8 | hitsVec_0_6
    & multipleHits_rightOne_6 | hitsVec_0_9 & hitsVec_0_10 | hitsVec_0_11 & hitsVec_0_12
    | multipleHits_leftOne_10 & multipleHits_rightOne_9 | multipleHits_leftOne_8
    & multipleHits_rightOne_10 | (multipleHits_leftOne_2 | multipleHits_rightOne_4)
    & (multipleHits_leftOne_8 | multipleHits_rightOne_10);	// Misc.scala:182:{16,49,61}, tlb.scala:171:69
  wire             multipleHits_rightOne_13 = hitsVec_1_1 | hitsVec_1_2;	// Misc.scala:182:16, tlb.scala:171:69
  wire             multipleHits_leftOne_14 = hitsVec_1_0 | multipleHits_rightOne_13;	// Misc.scala:182:16, tlb.scala:171:69
  wire             multipleHits_rightOne_15 = hitsVec_1_4 | hitsVec_1_5;	// Misc.scala:182:16, tlb.scala:171:69
  wire             multipleHits_rightOne_16 = hitsVec_1_3 | multipleHits_rightOne_15;	// Misc.scala:182:16, tlb.scala:171:69
  wire             multipleHits_rightOne_18 = hitsVec_1_7 | hitsVec_1_8;	// Misc.scala:182:16, tlb.scala:171:69
  wire             multipleHits_leftOne_20 = hitsVec_1_6 | multipleHits_rightOne_18;	// Misc.scala:182:16, tlb.scala:171:69
  wire             multipleHits_leftOne_22 = hitsVec_1_9 | hitsVec_1_10;	// Misc.scala:182:16, tlb.scala:171:69
  wire             multipleHits_rightOne_21 = hitsVec_1_11 | hitsVec_1_12;	// Misc.scala:182:16, tlb.scala:171:69
  wire             multipleHits_rightOne_22 =
    multipleHits_leftOne_22 | multipleHits_rightOne_21;	// Misc.scala:182:16
  wire             multipleHits_1 =
    hitsVec_1_1 & hitsVec_1_2 | hitsVec_1_0 & multipleHits_rightOne_13 | hitsVec_1_4
    & hitsVec_1_5 | hitsVec_1_3 & multipleHits_rightOne_15 | multipleHits_leftOne_14
    & multipleHits_rightOne_16 | hitsVec_1_7 & hitsVec_1_8 | hitsVec_1_6
    & multipleHits_rightOne_18 | hitsVec_1_9 & hitsVec_1_10 | hitsVec_1_11 & hitsVec_1_12
    | multipleHits_leftOne_22 & multipleHits_rightOne_21 | multipleHits_leftOne_20
    & multipleHits_rightOne_22 | (multipleHits_leftOne_14 | multipleHits_rightOne_16)
    & (multipleHits_leftOne_20 | multipleHits_rightOne_22);	// Misc.scala:182:{16,49,61}, tlb.scala:171:69
  wire             _io_miss_rdy_T = state == 2'h0;	// tlb.scala:129:22, :288:24
  wire [12:0]      _GEN_38 =
    {hitsVec_0_12,
     hitsVec_0_11,
     hitsVec_0_10,
     hitsVec_0_9,
     hitsVec_0_8,
     hitsVec_0_7,
     hitsVec_0_6,
     hitsVec_0_5,
     hitsVec_0_4,
     hitsVec_0_3,
     hitsVec_0_2,
     hitsVec_0_1,
     hitsVec_0_0};	// Cat.scala:30:58, tlb.scala:171:69
  wire [12:0]      _GEN_39 =
    {hitsVec_1_12,
     hitsVec_1_11,
     hitsVec_1_10,
     hitsVec_1_9,
     hitsVec_1_8,
     hitsVec_1_7,
     hitsVec_1_6,
     hitsVec_1_5,
     hitsVec_1_4,
     hitsVec_1_3,
     hitsVec_1_2,
     hitsVec_1_1,
     hitsVec_1_0};	// Cat.scala:30:58, tlb.scala:171:69
  `ifndef SYNTHESIS	// tlb.scala:338:15
    always @(posedge clock) begin	// tlb.scala:338:15
      if (io_sfence_valid
          & ~(~io_sfence_bits_rs1
              | io_sfence_bits_addr[38:12] == io_req_0_bits_vaddr[38:12] | reset)) begin	// tlb.scala:142:47, :338:{15,16,60,74}
        if (`ASSERT_VERBOSE_COND_)	// tlb.scala:338:15
          $error("Assertion failed\n    at tlb.scala:338 assert(!io.sfence.bits.rs1 || (io.sfence.bits.addr >> pgIdxBits) === vpn(w))\n");	// tlb.scala:338:15
        if (`STOP_COND_)	// tlb.scala:338:15
          $fatal;	// tlb.scala:338:15
      end
      if (io_sfence_valid
          & ~(~io_sfence_bits_rs1
              | io_sfence_bits_addr[38:12] == io_req_1_bits_vaddr[38:12] | reset)) begin	// tlb.scala:142:47, :338:{15,16,60,74}
        if (`ASSERT_VERBOSE_COND_)	// tlb.scala:338:15
          $error("Assertion failed\n    at tlb.scala:338 assert(!io.sfence.bits.rs1 || (io.sfence.bits.addr >> pgIdxBits) === vpn(w))\n");	// tlb.scala:338:15
        if (`STOP_COND_)	// tlb.scala:338:15
          $fatal;	// tlb.scala:338:15
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    automatic logic        newEntry_px;	// tlb.scala:166:59
    automatic logic        _r_sectored_repl_addr_valids_T_16;	// package.scala:72:59
    automatic logic        sector_hits_0_0;	// tlb.scala:59:42
    automatic logic        _r_sectored_repl_addr_valids_T_18;	// package.scala:72:59
    automatic logic        sector_hits_0_1;	// tlb.scala:59:42
    automatic logic        _r_sectored_repl_addr_valids_T_20;	// package.scala:72:59
    automatic logic        sector_hits_0_2;	// tlb.scala:59:42
    automatic logic        _r_sectored_repl_addr_valids_T_22;	// package.scala:72:59
    automatic logic        sector_hits_0_3;	// tlb.scala:59:42
    automatic logic        _r_sectored_repl_addr_valids_T_24;	// package.scala:72:59
    automatic logic        sector_hits_0_4;	// tlb.scala:59:42
    automatic logic        _r_sectored_repl_addr_valids_T_26;	// package.scala:72:59
    automatic logic        sector_hits_0_5;	// tlb.scala:59:42
    automatic logic        _r_sectored_repl_addr_valids_T_28;	// package.scala:72:59
    automatic logic        sector_hits_0_6;	// tlb.scala:59:42
    automatic logic        _r_sectored_repl_addr_valids_T_30;	// package.scala:72:59
    automatic logic        sector_hits_0_7;	// tlb.scala:59:42
    automatic logic        sector_hits_1_0;	// tlb.scala:59:42
    automatic logic        sector_hits_1_1;	// tlb.scala:59:42
    automatic logic        sector_hits_1_2;	// tlb.scala:59:42
    automatic logic        sector_hits_1_3;	// tlb.scala:59:42
    automatic logic        sector_hits_1_4;	// tlb.scala:59:42
    automatic logic        sector_hits_1_5;	// tlb.scala:59:42
    automatic logic        sector_hits_1_6;	// tlb.scala:59:42
    automatic logic        sector_hits_1_7;	// tlb.scala:59:42
    automatic logic        newEntry_sr;	// PTW.scala:77:35
    automatic logic        newEntry_sw;	// PTW.scala:78:40
    automatic logic        newEntry_sx;	// PTW.scala:79:35
    automatic logic        _GEN_40 = io_ptw_resp_valid & ~io_ptw_resp_bits_homogeneous;	// tlb.scala:90:16, :124:56, :177:20, :196:{39,70}
    automatic logic        _GEN_41;	// tlb.scala:94:18, :124:56, :177:20, :196:70
    automatic logic        _GEN_42;	// tlb.scala:123:30, :177:20, :196:70
    automatic logic        _GEN_43;	// tlb.scala:123:30, :177:20, :196:70
    automatic logic        _GEN_44;	// tlb.scala:123:30, :177:20, :196:70
    automatic logic        _GEN_45;	// tlb.scala:123:30, :177:20, :196:70
    automatic logic        _GEN_46;	// tlb.scala:123:30, :177:20, :196:70
    automatic logic        _GEN_47;	// tlb.scala:123:30, :177:20, :196:70
    automatic logic        _GEN_48;	// tlb.scala:123:30, :177:20, :196:70
    automatic logic        _GEN_49;	// tlb.scala:123:30, :177:20, :196:70
    automatic logic [2:0]  waddr;	// tlb.scala:203:22
    automatic logic        _GEN_50;	// tlb.scala:204:65
    automatic logic        _GEN_51 =
      ~io_ptw_resp_bits_homogeneous | ~(io_ptw_resp_bits_level[1]);	// tlb.scala:122:29, :196:{39,70}, :198:{40,58}, :204:74
    automatic logic        _GEN_52;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_53;	// tlb.scala:94:18
    automatic logic        _GEN_54;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_55;	// tlb.scala:94:18
    automatic logic        _GEN_56;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_57;	// tlb.scala:94:18
    automatic logic        _GEN_58;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_59;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic [33:0] _sectored_entries_0_data_T;	// tlb.scala:95:26
    automatic logic        _GEN_60;	// tlb.scala:204:65
    automatic logic        _GEN_61;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_62;	// tlb.scala:94:18
    automatic logic        _GEN_63;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_64;	// tlb.scala:94:18
    automatic logic        _GEN_65;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_66;	// tlb.scala:94:18
    automatic logic        _GEN_67;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_68;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic [33:0] _sectored_entries_1_data_T;	// tlb.scala:95:26
    automatic logic        _GEN_69;	// tlb.scala:204:65
    automatic logic        _GEN_70;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_71;	// tlb.scala:94:18
    automatic logic        _GEN_72;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_73;	// tlb.scala:94:18
    automatic logic        _GEN_74;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_75;	// tlb.scala:94:18
    automatic logic        _GEN_76;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_77;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic [33:0] _sectored_entries_2_data_T;	// tlb.scala:95:26
    automatic logic        _GEN_78;	// tlb.scala:204:65
    automatic logic        _GEN_79;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_80;	// tlb.scala:94:18
    automatic logic        _GEN_81;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_82;	// tlb.scala:94:18
    automatic logic        _GEN_83;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_84;	// tlb.scala:94:18
    automatic logic        _GEN_85;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_86;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic [33:0] _sectored_entries_3_data_T;	// tlb.scala:95:26
    automatic logic        _GEN_87;	// tlb.scala:204:65
    automatic logic        _GEN_88;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_89;	// tlb.scala:94:18
    automatic logic        _GEN_90;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_91;	// tlb.scala:94:18
    automatic logic        _GEN_92;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_93;	// tlb.scala:94:18
    automatic logic        _GEN_94;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_95;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic [33:0] _sectored_entries_4_data_T;	// tlb.scala:95:26
    automatic logic        _GEN_96;	// tlb.scala:204:65
    automatic logic        _GEN_97;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_98;	// tlb.scala:94:18
    automatic logic        _GEN_99;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_100;	// tlb.scala:94:18
    automatic logic        _GEN_101;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_102;	// tlb.scala:94:18
    automatic logic        _GEN_103;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_104;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic [33:0] _sectored_entries_5_data_T;	// tlb.scala:95:26
    automatic logic        _GEN_105;	// tlb.scala:204:65
    automatic logic        _GEN_106;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_107;	// tlb.scala:94:18
    automatic logic        _GEN_108;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_109;	// tlb.scala:94:18
    automatic logic        _GEN_110;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_111;	// tlb.scala:94:18
    automatic logic        _GEN_112;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_113;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic [33:0] _sectored_entries_6_data_T;	// tlb.scala:95:26
    automatic logic        _GEN_114;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_115;	// tlb.scala:94:18
    automatic logic        _GEN_116;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_117;	// tlb.scala:94:18
    automatic logic        _GEN_118;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_119;	// tlb.scala:94:18
    automatic logic        _GEN_120;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_121;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic [33:0] _sectored_entries_7_data_T;	// tlb.scala:95:26
    automatic logic [2:0]  _GEN_122;	// OneHot.scala:30:18
    automatic logic [2:0]  _GEN_123;	// OneHot.scala:31:18
    automatic logic [2:0]  _GEN_124;	// OneHot.scala:30:18
    automatic logic [2:0]  _GEN_125;	// OneHot.scala:31:18
    automatic logic        _GEN_126;	// tlb.scala:314:45
    automatic logic [2:0]  _GEN_127;	// Cat.scala:30:58
    automatic logic        _GEN_128;	// tlb.scala:314:45
    automatic logic        _GEN_129 = _hitsVec_T == 25'h0;	// tlb.scala:60:{43,73}
    automatic logic        _GEN_130 = io_req_0_bits_vaddr[13:12] == 2'h0;	// package.scala:154:13, tlb.scala:103:60, :129:22
    automatic logic        _GEN_131 = _GEN_129 & _GEN_130;	// tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_132 = io_req_0_bits_vaddr[13:12] == 2'h1;	// package.scala:15:47, :154:13, tlb.scala:103:60
    automatic logic        _GEN_133 = _GEN_129 & _GEN_132;	// tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_134 = io_req_0_bits_vaddr[13:12] == 2'h2;	// package.scala:154:13, tlb.scala:80:31, :103:60
    automatic logic        _GEN_135 = _GEN_129 & _GEN_134;	// tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_136 = _GEN_129 & (&(io_req_0_bits_vaddr[13:12]));	// package.scala:154:13, tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_137 = _hitsVec_T[24:16] == 9'h0;	// tlb.scala:60:43, :107:{29,64}
    automatic logic        _GEN_138;	// tlb.scala:103:36, :107:73, :109:44
    automatic logic        _GEN_139;	// tlb.scala:103:36, :107:73, :109:44
    automatic logic        _GEN_140;	// tlb.scala:103:36, :107:73, :109:44
    automatic logic        _GEN_141;	// tlb.scala:103:36, :107:73, :109:44
    automatic logic        _GEN_142 = _hitsVec_T_5 == 25'h0;	// tlb.scala:60:{43,73}
    automatic logic        _GEN_143 = _GEN_142 & _GEN_130;	// tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_144 = _GEN_142 & _GEN_132;	// tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_145 = _GEN_142 & _GEN_134;	// tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_146 = _GEN_142 & (&(io_req_0_bits_vaddr[13:12]));	// package.scala:154:13, tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_147 = _hitsVec_T_5[24:16] == 9'h0;	// tlb.scala:60:43, :107:{29,64}
    automatic logic        _GEN_148;	// tlb.scala:103:36, :107:73, :109:44
    automatic logic        _GEN_149;	// tlb.scala:103:36, :107:73, :109:44
    automatic logic        _GEN_150;	// tlb.scala:103:36, :107:73, :109:44
    automatic logic        _GEN_151;	// tlb.scala:103:36, :107:73, :109:44
    automatic logic        _GEN_152 = _hitsVec_T_10 == 25'h0;	// tlb.scala:60:{43,73}
    automatic logic        _GEN_153 = _GEN_152 & _GEN_130;	// tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_154 = _GEN_152 & _GEN_132;	// tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_155 = _GEN_152 & _GEN_134;	// tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_156 = _GEN_152 & (&(io_req_0_bits_vaddr[13:12]));	// package.scala:154:13, tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_157 = _hitsVec_T_10[24:16] == 9'h0;	// tlb.scala:60:43, :107:{29,64}
    automatic logic        _GEN_158;	// tlb.scala:103:36, :107:73, :109:44
    automatic logic        _GEN_159;	// tlb.scala:103:36, :107:73, :109:44
    automatic logic        _GEN_160;	// tlb.scala:103:36, :107:73, :109:44
    automatic logic        _GEN_161;	// tlb.scala:103:36, :107:73, :109:44
    automatic logic        _GEN_162 = _hitsVec_T_15 == 25'h0;	// tlb.scala:60:{43,73}
    automatic logic        _GEN_163 = _GEN_162 & _GEN_130;	// tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_164 = _GEN_162 & _GEN_132;	// tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_165 = _GEN_162 & _GEN_134;	// tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_166 = _GEN_162 & (&(io_req_0_bits_vaddr[13:12]));	// package.scala:154:13, tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_167 = _hitsVec_T_15[24:16] == 9'h0;	// tlb.scala:60:43, :107:{29,64}
    automatic logic        _GEN_168;	// tlb.scala:103:36, :107:73, :109:44
    automatic logic        _GEN_169;	// tlb.scala:103:36, :107:73, :109:44
    automatic logic        _GEN_170;	// tlb.scala:103:36, :107:73, :109:44
    automatic logic        _GEN_171;	// tlb.scala:103:36, :107:73, :109:44
    automatic logic        _GEN_172 = _hitsVec_T_20 == 25'h0;	// tlb.scala:60:{43,73}
    automatic logic        _GEN_173 = _GEN_172 & _GEN_130;	// tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_174 = _GEN_172 & _GEN_132;	// tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_175 = _GEN_172 & _GEN_134;	// tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_176 = _GEN_172 & (&(io_req_0_bits_vaddr[13:12]));	// package.scala:154:13, tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_177 = _hitsVec_T_20[24:16] == 9'h0;	// tlb.scala:60:43, :107:{29,64}
    automatic logic        _GEN_178;	// tlb.scala:103:36, :107:73, :109:44
    automatic logic        _GEN_179;	// tlb.scala:103:36, :107:73, :109:44
    automatic logic        _GEN_180;	// tlb.scala:103:36, :107:73, :109:44
    automatic logic        _GEN_181;	// tlb.scala:103:36, :107:73, :109:44
    automatic logic        _GEN_182 = _hitsVec_T_25 == 25'h0;	// tlb.scala:60:{43,73}
    automatic logic        _GEN_183 = _GEN_182 & _GEN_130;	// tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_184 = _GEN_182 & _GEN_132;	// tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_185 = _GEN_182 & _GEN_134;	// tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_186 = _GEN_182 & (&(io_req_0_bits_vaddr[13:12]));	// package.scala:154:13, tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_187 = _hitsVec_T_25[24:16] == 9'h0;	// tlb.scala:60:43, :107:{29,64}
    automatic logic        _GEN_188;	// tlb.scala:103:36, :107:73, :109:44
    automatic logic        _GEN_189;	// tlb.scala:103:36, :107:73, :109:44
    automatic logic        _GEN_190;	// tlb.scala:103:36, :107:73, :109:44
    automatic logic        _GEN_191;	// tlb.scala:103:36, :107:73, :109:44
    automatic logic        _GEN_192 = _hitsVec_T_30 == 25'h0;	// tlb.scala:60:{43,73}
    automatic logic        _GEN_193 = _GEN_192 & _GEN_130;	// tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_194 = _GEN_192 & _GEN_132;	// tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_195 = _GEN_192 & _GEN_134;	// tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_196 = _GEN_192 & (&(io_req_0_bits_vaddr[13:12]));	// package.scala:154:13, tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_197 = _hitsVec_T_30[24:16] == 9'h0;	// tlb.scala:60:43, :107:{29,64}
    automatic logic        _GEN_198;	// tlb.scala:103:36, :107:73, :109:44
    automatic logic        _GEN_199;	// tlb.scala:103:36, :107:73, :109:44
    automatic logic        _GEN_200;	// tlb.scala:103:36, :107:73, :109:44
    automatic logic        _GEN_201;	// tlb.scala:103:36, :107:73, :109:44
    automatic logic        _GEN_202 = _hitsVec_T_35 == 25'h0;	// tlb.scala:60:{43,73}
    automatic logic        _GEN_203 = _GEN_202 & _GEN_130;	// tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_204 = _GEN_202 & _GEN_132;	// tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_205 = _GEN_202 & _GEN_134;	// tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_206 = _GEN_202 & (&(io_req_0_bits_vaddr[13:12]));	// package.scala:154:13, tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_207 = _hitsVec_T_35[24:16] == 9'h0;	// tlb.scala:60:43, :107:{29,64}
    automatic logic        _GEN_208;	// tlb.scala:103:36, :107:73, :109:44
    automatic logic        _GEN_209;	// tlb.scala:103:36, :107:73, :109:44
    automatic logic        _GEN_210;	// tlb.scala:103:36, :107:73, :109:44
    automatic logic        _GEN_211;	// tlb.scala:103:36, :107:73, :109:44
    automatic logic        _GEN_212 = _hitsVec_T_120 == 25'h0;	// tlb.scala:60:{43,73}
    automatic logic        _GEN_213 = io_req_1_bits_vaddr[13:12] == 2'h0;	// package.scala:154:13, tlb.scala:103:60, :129:22
    automatic logic        _GEN_214 = _GEN_212 & _GEN_213;	// tlb.scala:60:73, :103:{36,60}, :340:37
    automatic logic        _GEN_215 = io_req_1_bits_vaddr[13:12] == 2'h1;	// package.scala:15:47, :154:13, tlb.scala:103:60
    automatic logic        _GEN_216 = _GEN_212 & _GEN_215;	// tlb.scala:60:73, :103:{36,60}, :340:37
    automatic logic        _GEN_217 = io_req_1_bits_vaddr[13:12] == 2'h2;	// package.scala:154:13, tlb.scala:80:31, :103:60
    automatic logic        _GEN_218 = _GEN_212 & _GEN_217;	// tlb.scala:60:73, :103:{36,60}, :340:37
    automatic logic        _GEN_219 = _GEN_212 & (&(io_req_1_bits_vaddr[13:12]));	// package.scala:154:13, tlb.scala:60:73, :103:{36,60}, :340:37
    automatic logic        _GEN_220 = _hitsVec_T_120[24:16] == 9'h0;	// tlb.scala:60:43, :107:{29,64}
    automatic logic        _GEN_221 = _hitsVec_T_125 == 25'h0;	// tlb.scala:60:{43,73}
    automatic logic        _GEN_222 = _GEN_221 & _GEN_213;	// tlb.scala:60:73, :103:{36,60}, :340:37
    automatic logic        _GEN_223 = _GEN_221 & _GEN_215;	// tlb.scala:60:73, :103:{36,60}, :340:37
    automatic logic        _GEN_224 = _GEN_221 & _GEN_217;	// tlb.scala:60:73, :103:{36,60}, :340:37
    automatic logic        _GEN_225 = _GEN_221 & (&(io_req_1_bits_vaddr[13:12]));	// package.scala:154:13, tlb.scala:60:73, :103:{36,60}, :340:37
    automatic logic        _GEN_226 = _hitsVec_T_125[24:16] == 9'h0;	// tlb.scala:60:43, :107:{29,64}
    automatic logic        _GEN_227 = _hitsVec_T_130 == 25'h0;	// tlb.scala:60:{43,73}
    automatic logic        _GEN_228 = _GEN_227 & _GEN_213;	// tlb.scala:60:73, :103:{36,60}, :340:37
    automatic logic        _GEN_229 = _GEN_227 & _GEN_215;	// tlb.scala:60:73, :103:{36,60}, :340:37
    automatic logic        _GEN_230 = _GEN_227 & _GEN_217;	// tlb.scala:60:73, :103:{36,60}, :340:37
    automatic logic        _GEN_231 = _GEN_227 & (&(io_req_1_bits_vaddr[13:12]));	// package.scala:154:13, tlb.scala:60:73, :103:{36,60}, :340:37
    automatic logic        _GEN_232 = _hitsVec_T_130[24:16] == 9'h0;	// tlb.scala:60:43, :107:{29,64}
    automatic logic        _GEN_233 = _hitsVec_T_135 == 25'h0;	// tlb.scala:60:{43,73}
    automatic logic        _GEN_234 = _GEN_233 & _GEN_213;	// tlb.scala:60:73, :103:{36,60}, :340:37
    automatic logic        _GEN_235 = _GEN_233 & _GEN_215;	// tlb.scala:60:73, :103:{36,60}, :340:37
    automatic logic        _GEN_236 = _GEN_233 & _GEN_217;	// tlb.scala:60:73, :103:{36,60}, :340:37
    automatic logic        _GEN_237 = _GEN_233 & (&(io_req_1_bits_vaddr[13:12]));	// package.scala:154:13, tlb.scala:60:73, :103:{36,60}, :340:37
    automatic logic        _GEN_238 = _hitsVec_T_135[24:16] == 9'h0;	// tlb.scala:60:43, :107:{29,64}
    automatic logic        _GEN_239 = _hitsVec_T_140 == 25'h0;	// tlb.scala:60:{43,73}
    automatic logic        _GEN_240 = _GEN_239 & _GEN_213;	// tlb.scala:60:73, :103:{36,60}, :340:37
    automatic logic        _GEN_241 = _GEN_239 & _GEN_215;	// tlb.scala:60:73, :103:{36,60}, :340:37
    automatic logic        _GEN_242 = _GEN_239 & _GEN_217;	// tlb.scala:60:73, :103:{36,60}, :340:37
    automatic logic        _GEN_243 = _GEN_239 & (&(io_req_1_bits_vaddr[13:12]));	// package.scala:154:13, tlb.scala:60:73, :103:{36,60}, :340:37
    automatic logic        _GEN_244 = _hitsVec_T_140[24:16] == 9'h0;	// tlb.scala:60:43, :107:{29,64}
    automatic logic        _GEN_245 = _hitsVec_T_145 == 25'h0;	// tlb.scala:60:{43,73}
    automatic logic        _GEN_246 = _GEN_245 & _GEN_213;	// tlb.scala:60:73, :103:{36,60}, :340:37
    automatic logic        _GEN_247 = _GEN_245 & _GEN_215;	// tlb.scala:60:73, :103:{36,60}, :340:37
    automatic logic        _GEN_248 = _GEN_245 & _GEN_217;	// tlb.scala:60:73, :103:{36,60}, :340:37
    automatic logic        _GEN_249 = _GEN_245 & (&(io_req_1_bits_vaddr[13:12]));	// package.scala:154:13, tlb.scala:60:73, :103:{36,60}, :340:37
    automatic logic        _GEN_250 = _hitsVec_T_145[24:16] == 9'h0;	// tlb.scala:60:43, :107:{29,64}
    automatic logic        _GEN_251 = _hitsVec_T_150 == 25'h0;	// tlb.scala:60:{43,73}
    automatic logic        _GEN_252 = _GEN_251 & _GEN_213;	// tlb.scala:60:73, :103:{36,60}, :340:37
    automatic logic        _GEN_253 = _GEN_251 & _GEN_215;	// tlb.scala:60:73, :103:{36,60}, :340:37
    automatic logic        _GEN_254 = _GEN_251 & _GEN_217;	// tlb.scala:60:73, :103:{36,60}, :340:37
    automatic logic        _GEN_255 = _GEN_251 & (&(io_req_1_bits_vaddr[13:12]));	// package.scala:154:13, tlb.scala:60:73, :103:{36,60}, :340:37
    automatic logic        _GEN_256 = _hitsVec_T_150[24:16] == 9'h0;	// tlb.scala:60:43, :107:{29,64}
    automatic logic        _GEN_257 = _hitsVec_T_155 == 25'h0;	// tlb.scala:60:{43,73}
    automatic logic        _GEN_258 = _GEN_257 & _GEN_213;	// tlb.scala:60:73, :103:{36,60}, :340:37
    automatic logic        _GEN_259 = _GEN_257 & _GEN_215;	// tlb.scala:60:73, :103:{36,60}, :340:37
    automatic logic        _GEN_260 = _GEN_257 & _GEN_217;	// tlb.scala:60:73, :103:{36,60}, :340:37
    automatic logic        _GEN_261 = _GEN_257 & (&(io_req_1_bits_vaddr[13:12]));	// package.scala:154:13, tlb.scala:60:73, :103:{36,60}, :340:37
    automatic logic        _GEN_262 = _hitsVec_T_155[24:16] == 9'h0;	// tlb.scala:60:43, :107:{29,64}
    automatic logic        _GEN_263 = multipleHits_0 | multipleHits_1 | reset;	// Misc.scala:182:49, tlb.scala:346:28
    newEntry_px =
      legal_address_0
      & ({mpu_ppn_0[19],
          mpu_ppn_0[14:13],
          mpu_ppn_0[8],
          mpu_ppn_0[5:4],
          mpu_ppn_0[2]} == 7'h0
         | {mpu_ppn_0[19],
            mpu_ppn_0[16],
            mpu_ppn_0[14:13],
            mpu_ppn_0[8],
            mpu_ppn_0[5],
            ~(mpu_ppn_0[4])} == 7'h0
         | {mpu_ppn_0[19], mpu_ppn_0[16], mpu_ppn_0[14:13], mpu_ppn_0[8], _GEN_4} == 7'h0
         | ~(|_GEN_10)) & _pmp_0_io_x;	// Parameters.scala:137:{31,49,52,67}, :615:89, Replacement.scala:168:70, tlb.scala:147:20, :150:40, :157:84, :166:59
    _r_sectored_repl_addr_valids_T_16 =
      sectored_entries_0_valid_0 | sectored_entries_0_valid_1;	// package.scala:72:59, tlb.scala:122:29
    sector_hits_0_0 =
      (_r_sectored_repl_addr_valids_T_16 | sectored_entries_0_valid_2
       | sectored_entries_0_valid_3) & _hitsVec_T == 25'h0;	// package.scala:72:59, tlb.scala:59:42, :60:{43,73}, :122:29
    _r_sectored_repl_addr_valids_T_18 =
      sectored_entries_1_valid_0 | sectored_entries_1_valid_1;	// package.scala:72:59, tlb.scala:122:29
    sector_hits_0_1 =
      (_r_sectored_repl_addr_valids_T_18 | sectored_entries_1_valid_2
       | sectored_entries_1_valid_3) & _hitsVec_T_5 == 25'h0;	// package.scala:72:59, tlb.scala:59:42, :60:{43,73}, :122:29
    _r_sectored_repl_addr_valids_T_20 =
      sectored_entries_2_valid_0 | sectored_entries_2_valid_1;	// package.scala:72:59, tlb.scala:122:29
    sector_hits_0_2 =
      (_r_sectored_repl_addr_valids_T_20 | sectored_entries_2_valid_2
       | sectored_entries_2_valid_3) & _hitsVec_T_10 == 25'h0;	// package.scala:72:59, tlb.scala:59:42, :60:{43,73}, :122:29
    _r_sectored_repl_addr_valids_T_22 =
      sectored_entries_3_valid_0 | sectored_entries_3_valid_1;	// package.scala:72:59, tlb.scala:122:29
    sector_hits_0_3 =
      (_r_sectored_repl_addr_valids_T_22 | sectored_entries_3_valid_2
       | sectored_entries_3_valid_3) & _hitsVec_T_15 == 25'h0;	// package.scala:72:59, tlb.scala:59:42, :60:{43,73}, :122:29
    _r_sectored_repl_addr_valids_T_24 =
      sectored_entries_4_valid_0 | sectored_entries_4_valid_1;	// package.scala:72:59, tlb.scala:122:29
    sector_hits_0_4 =
      (_r_sectored_repl_addr_valids_T_24 | sectored_entries_4_valid_2
       | sectored_entries_4_valid_3) & _hitsVec_T_20 == 25'h0;	// package.scala:72:59, tlb.scala:59:42, :60:{43,73}, :122:29
    _r_sectored_repl_addr_valids_T_26 =
      sectored_entries_5_valid_0 | sectored_entries_5_valid_1;	// package.scala:72:59, tlb.scala:122:29
    sector_hits_0_5 =
      (_r_sectored_repl_addr_valids_T_26 | sectored_entries_5_valid_2
       | sectored_entries_5_valid_3) & _hitsVec_T_25 == 25'h0;	// package.scala:72:59, tlb.scala:59:42, :60:{43,73}, :122:29
    _r_sectored_repl_addr_valids_T_28 =
      sectored_entries_6_valid_0 | sectored_entries_6_valid_1;	// package.scala:72:59, tlb.scala:122:29
    sector_hits_0_6 =
      (_r_sectored_repl_addr_valids_T_28 | sectored_entries_6_valid_2
       | sectored_entries_6_valid_3) & _hitsVec_T_30 == 25'h0;	// package.scala:72:59, tlb.scala:59:42, :60:{43,73}, :122:29
    _r_sectored_repl_addr_valids_T_30 =
      sectored_entries_7_valid_0 | sectored_entries_7_valid_1;	// package.scala:72:59, tlb.scala:122:29
    sector_hits_0_7 =
      (_r_sectored_repl_addr_valids_T_30 | sectored_entries_7_valid_2
       | sectored_entries_7_valid_3) & _hitsVec_T_35 == 25'h0;	// package.scala:72:59, tlb.scala:59:42, :60:{43,73}, :122:29
    sector_hits_1_0 =
      (_r_sectored_repl_addr_valids_T_16 | sectored_entries_0_valid_2
       | sectored_entries_0_valid_3) & _hitsVec_T_120 == 25'h0;	// package.scala:72:59, tlb.scala:59:42, :60:{43,73}, :122:29
    sector_hits_1_1 =
      (_r_sectored_repl_addr_valids_T_18 | sectored_entries_1_valid_2
       | sectored_entries_1_valid_3) & _hitsVec_T_125 == 25'h0;	// package.scala:72:59, tlb.scala:59:42, :60:{43,73}, :122:29
    sector_hits_1_2 =
      (_r_sectored_repl_addr_valids_T_20 | sectored_entries_2_valid_2
       | sectored_entries_2_valid_3) & _hitsVec_T_130 == 25'h0;	// package.scala:72:59, tlb.scala:59:42, :60:{43,73}, :122:29
    sector_hits_1_3 =
      (_r_sectored_repl_addr_valids_T_22 | sectored_entries_3_valid_2
       | sectored_entries_3_valid_3) & _hitsVec_T_135 == 25'h0;	// package.scala:72:59, tlb.scala:59:42, :60:{43,73}, :122:29
    sector_hits_1_4 =
      (_r_sectored_repl_addr_valids_T_24 | sectored_entries_4_valid_2
       | sectored_entries_4_valid_3) & _hitsVec_T_140 == 25'h0;	// package.scala:72:59, tlb.scala:59:42, :60:{43,73}, :122:29
    sector_hits_1_5 =
      (_r_sectored_repl_addr_valids_T_26 | sectored_entries_5_valid_2
       | sectored_entries_5_valid_3) & _hitsVec_T_145 == 25'h0;	// package.scala:72:59, tlb.scala:59:42, :60:{43,73}, :122:29
    sector_hits_1_6 =
      (_r_sectored_repl_addr_valids_T_28 | sectored_entries_6_valid_2
       | sectored_entries_6_valid_3) & _hitsVec_T_150 == 25'h0;	// package.scala:72:59, tlb.scala:59:42, :60:{43,73}, :122:29
    sector_hits_1_7 =
      (_r_sectored_repl_addr_valids_T_30 | sectored_entries_7_valid_2
       | sectored_entries_7_valid_3) & _hitsVec_T_155 == 25'h0;	// package.scala:72:59, tlb.scala:59:42, :60:{43,73}, :122:29
    newEntry_sr =
      io_ptw_resp_bits_pte_v
      & (io_ptw_resp_bits_pte_r | io_ptw_resp_bits_pte_x & ~io_ptw_resp_bits_pte_w)
      & io_ptw_resp_bits_pte_a & io_ptw_resp_bits_pte_r;	// PTW.scala:73:{38,44,47}, :77:35
    newEntry_sw =
      io_ptw_resp_bits_pte_v
      & (io_ptw_resp_bits_pte_r | io_ptw_resp_bits_pte_x & ~io_ptw_resp_bits_pte_w)
      & io_ptw_resp_bits_pte_a & io_ptw_resp_bits_pte_w & io_ptw_resp_bits_pte_d;	// PTW.scala:73:{38,44,47}, :78:40
    newEntry_sx =
      io_ptw_resp_bits_pte_v
      & (io_ptw_resp_bits_pte_r | io_ptw_resp_bits_pte_x & ~io_ptw_resp_bits_pte_w)
      & io_ptw_resp_bits_pte_a & io_ptw_resp_bits_pte_x;	// PTW.scala:73:{38,44,47}, :79:35
    _GEN_41 = _GEN_40 | special_entry_valid_0;	// tlb.scala:90:16, :94:18, :124:56, :177:20, :196:70
    _GEN_42 =
      io_ptw_resp_valid & io_ptw_resp_bits_homogeneous & ~(io_ptw_resp_bits_level[1])
      & r_superpage_repl_addr == 2'h0;	// tlb.scala:123:30, :129:22, :131:34, :177:20, :196:70, :198:40, :199:82
    _GEN_43 = _GEN_42 | superpage_entries_0_valid_0;	// tlb.scala:123:30, :177:20, :196:70
    _GEN_44 =
      io_ptw_resp_valid & io_ptw_resp_bits_homogeneous & ~(io_ptw_resp_bits_level[1])
      & r_superpage_repl_addr == 2'h1;	// package.scala:15:47, tlb.scala:123:30, :131:34, :177:20, :196:70, :198:40, :199:82
    _GEN_45 = _GEN_44 | superpage_entries_1_valid_0;	// tlb.scala:123:30, :177:20, :196:70
    _GEN_46 =
      io_ptw_resp_valid & io_ptw_resp_bits_homogeneous & ~(io_ptw_resp_bits_level[1])
      & r_superpage_repl_addr == 2'h2;	// tlb.scala:80:31, :123:30, :131:34, :177:20, :196:70, :198:40, :199:82
    _GEN_47 = _GEN_46 | superpage_entries_2_valid_0;	// tlb.scala:123:30, :177:20, :196:70
    _GEN_48 =
      io_ptw_resp_valid & io_ptw_resp_bits_homogeneous & ~(io_ptw_resp_bits_level[1])
      & (&r_superpage_repl_addr);	// tlb.scala:123:30, :131:34, :177:20, :196:70, :198:40, :199:82
    _GEN_49 = _GEN_48 | superpage_entries_3_valid_0;	// tlb.scala:123:30, :177:20, :196:70
    waddr = r_sectored_hit ? r_sectored_hit_addr : r_sectored_repl_addr;	// tlb.scala:132:33, :133:32, :134:27, :203:22
    _GEN_50 = waddr == 3'h0;	// Replacement.scala:168:70, tlb.scala:203:22, :204:65
    _GEN_52 = ~io_ptw_resp_valid | _GEN_51 | ~_GEN_50;	// tlb.scala:122:29, :177:20, :196:70, :198:58, :204:{65,74}
    _GEN_53 = r_refill_tag[1:0] == 2'h0;	// package.scala:154:13, tlb.scala:94:18, :129:22, :130:25
    _GEN_54 =
      _GEN_52
        ? sectored_entries_0_valid_0
        : _GEN_53 | r_sectored_hit & sectored_entries_0_valid_0;	// tlb.scala:94:18, :98:40, :122:29, :134:27, :177:20, :196:70, :205:32
    _GEN_55 = r_refill_tag[1:0] == 2'h1;	// package.scala:15:47, :154:13, tlb.scala:94:18, :130:25
    _GEN_56 =
      _GEN_52
        ? sectored_entries_0_valid_1
        : _GEN_55 | r_sectored_hit & sectored_entries_0_valid_1;	// tlb.scala:94:18, :98:40, :122:29, :134:27, :177:20, :196:70, :205:32
    _GEN_57 = r_refill_tag[1:0] == 2'h2;	// package.scala:154:13, tlb.scala:80:31, :94:18, :130:25
    _GEN_58 =
      _GEN_52
        ? sectored_entries_0_valid_2
        : _GEN_57 | r_sectored_hit & sectored_entries_0_valid_2;	// tlb.scala:94:18, :98:40, :122:29, :134:27, :177:20, :196:70, :205:32
    _GEN_59 =
      _GEN_52
        ? sectored_entries_0_valid_3
        : (&(r_refill_tag[1:0])) | r_sectored_hit & sectored_entries_0_valid_3;	// package.scala:154:13, tlb.scala:94:18, :98:40, :122:29, :130:25, :134:27, :177:20, :196:70, :205:32
    _sectored_entries_0_data_T =
      {io_ptw_resp_bits_pte_ppn[19:0],
       io_ptw_resp_bits_pte_u,
       io_ptw_resp_bits_pte_g,
       io_ptw_resp_bits_ae,
       newEntry_sw,
       newEntry_sx,
       newEntry_sr,
       newEntry_pw,
       newEntry_px,
       newEntry_pr,
       newEntry_pal,
       newEntry_paa,
       newEntry_eff,
       newEntry_c,
       1'h0};	// PTW.scala:77:35, :78:40, :79:35, tlb.scala:95:26, :159:22, :162:60, :163:64, :166:59, :180:18
    _GEN_60 = waddr == 3'h1;	// Mux.scala:47:69, tlb.scala:203:22, :204:65
    _GEN_61 = ~io_ptw_resp_valid | _GEN_51 | ~_GEN_60;	// tlb.scala:122:29, :177:20, :196:70, :198:58, :204:{65,74}
    _GEN_62 = r_refill_tag[1:0] == 2'h0;	// package.scala:154:13, tlb.scala:94:18, :129:22, :130:25
    _GEN_63 =
      _GEN_61
        ? sectored_entries_1_valid_0
        : _GEN_62 | r_sectored_hit & sectored_entries_1_valid_0;	// tlb.scala:94:18, :98:40, :122:29, :134:27, :177:20, :196:70, :205:32
    _GEN_64 = r_refill_tag[1:0] == 2'h1;	// package.scala:15:47, :154:13, tlb.scala:94:18, :130:25
    _GEN_65 =
      _GEN_61
        ? sectored_entries_1_valid_1
        : _GEN_64 | r_sectored_hit & sectored_entries_1_valid_1;	// tlb.scala:94:18, :98:40, :122:29, :134:27, :177:20, :196:70, :205:32
    _GEN_66 = r_refill_tag[1:0] == 2'h2;	// package.scala:154:13, tlb.scala:80:31, :94:18, :130:25
    _GEN_67 =
      _GEN_61
        ? sectored_entries_1_valid_2
        : _GEN_66 | r_sectored_hit & sectored_entries_1_valid_2;	// tlb.scala:94:18, :98:40, :122:29, :134:27, :177:20, :196:70, :205:32
    _GEN_68 =
      _GEN_61
        ? sectored_entries_1_valid_3
        : (&(r_refill_tag[1:0])) | r_sectored_hit & sectored_entries_1_valid_3;	// package.scala:154:13, tlb.scala:94:18, :98:40, :122:29, :130:25, :134:27, :177:20, :196:70, :205:32
    _sectored_entries_1_data_T =
      {io_ptw_resp_bits_pte_ppn[19:0],
       io_ptw_resp_bits_pte_u,
       io_ptw_resp_bits_pte_g,
       io_ptw_resp_bits_ae,
       newEntry_sw,
       newEntry_sx,
       newEntry_sr,
       newEntry_pw,
       newEntry_px,
       newEntry_pr,
       newEntry_pal,
       newEntry_paa,
       newEntry_eff,
       newEntry_c,
       1'h0};	// PTW.scala:77:35, :78:40, :79:35, tlb.scala:95:26, :159:22, :162:60, :163:64, :166:59, :180:18
    _GEN_69 = waddr == 3'h2;	// Mux.scala:47:69, tlb.scala:203:22, :204:65
    _GEN_70 = ~io_ptw_resp_valid | _GEN_51 | ~_GEN_69;	// tlb.scala:122:29, :177:20, :196:70, :198:58, :204:{65,74}
    _GEN_71 = r_refill_tag[1:0] == 2'h0;	// package.scala:154:13, tlb.scala:94:18, :129:22, :130:25
    _GEN_72 =
      _GEN_70
        ? sectored_entries_2_valid_0
        : _GEN_71 | r_sectored_hit & sectored_entries_2_valid_0;	// tlb.scala:94:18, :98:40, :122:29, :134:27, :177:20, :196:70, :205:32
    _GEN_73 = r_refill_tag[1:0] == 2'h1;	// package.scala:15:47, :154:13, tlb.scala:94:18, :130:25
    _GEN_74 =
      _GEN_70
        ? sectored_entries_2_valid_1
        : _GEN_73 | r_sectored_hit & sectored_entries_2_valid_1;	// tlb.scala:94:18, :98:40, :122:29, :134:27, :177:20, :196:70, :205:32
    _GEN_75 = r_refill_tag[1:0] == 2'h2;	// package.scala:154:13, tlb.scala:80:31, :94:18, :130:25
    _GEN_76 =
      _GEN_70
        ? sectored_entries_2_valid_2
        : _GEN_75 | r_sectored_hit & sectored_entries_2_valid_2;	// tlb.scala:94:18, :98:40, :122:29, :134:27, :177:20, :196:70, :205:32
    _GEN_77 =
      _GEN_70
        ? sectored_entries_2_valid_3
        : (&(r_refill_tag[1:0])) | r_sectored_hit & sectored_entries_2_valid_3;	// package.scala:154:13, tlb.scala:94:18, :98:40, :122:29, :130:25, :134:27, :177:20, :196:70, :205:32
    _sectored_entries_2_data_T =
      {io_ptw_resp_bits_pte_ppn[19:0],
       io_ptw_resp_bits_pte_u,
       io_ptw_resp_bits_pte_g,
       io_ptw_resp_bits_ae,
       newEntry_sw,
       newEntry_sx,
       newEntry_sr,
       newEntry_pw,
       newEntry_px,
       newEntry_pr,
       newEntry_pal,
       newEntry_paa,
       newEntry_eff,
       newEntry_c,
       1'h0};	// PTW.scala:77:35, :78:40, :79:35, tlb.scala:95:26, :159:22, :162:60, :163:64, :166:59, :180:18
    _GEN_78 = waddr == 3'h3;	// Mux.scala:47:69, tlb.scala:203:22, :204:65
    _GEN_79 = ~io_ptw_resp_valid | _GEN_51 | ~_GEN_78;	// tlb.scala:122:29, :177:20, :196:70, :198:58, :204:{65,74}
    _GEN_80 = r_refill_tag[1:0] == 2'h0;	// package.scala:154:13, tlb.scala:94:18, :129:22, :130:25
    _GEN_81 =
      _GEN_79
        ? sectored_entries_3_valid_0
        : _GEN_80 | r_sectored_hit & sectored_entries_3_valid_0;	// tlb.scala:94:18, :98:40, :122:29, :134:27, :177:20, :196:70, :205:32
    _GEN_82 = r_refill_tag[1:0] == 2'h1;	// package.scala:15:47, :154:13, tlb.scala:94:18, :130:25
    _GEN_83 =
      _GEN_79
        ? sectored_entries_3_valid_1
        : _GEN_82 | r_sectored_hit & sectored_entries_3_valid_1;	// tlb.scala:94:18, :98:40, :122:29, :134:27, :177:20, :196:70, :205:32
    _GEN_84 = r_refill_tag[1:0] == 2'h2;	// package.scala:154:13, tlb.scala:80:31, :94:18, :130:25
    _GEN_85 =
      _GEN_79
        ? sectored_entries_3_valid_2
        : _GEN_84 | r_sectored_hit & sectored_entries_3_valid_2;	// tlb.scala:94:18, :98:40, :122:29, :134:27, :177:20, :196:70, :205:32
    _GEN_86 =
      _GEN_79
        ? sectored_entries_3_valid_3
        : (&(r_refill_tag[1:0])) | r_sectored_hit & sectored_entries_3_valid_3;	// package.scala:154:13, tlb.scala:94:18, :98:40, :122:29, :130:25, :134:27, :177:20, :196:70, :205:32
    _sectored_entries_3_data_T =
      {io_ptw_resp_bits_pte_ppn[19:0],
       io_ptw_resp_bits_pte_u,
       io_ptw_resp_bits_pte_g,
       io_ptw_resp_bits_ae,
       newEntry_sw,
       newEntry_sx,
       newEntry_sr,
       newEntry_pw,
       newEntry_px,
       newEntry_pr,
       newEntry_pal,
       newEntry_paa,
       newEntry_eff,
       newEntry_c,
       1'h0};	// PTW.scala:77:35, :78:40, :79:35, tlb.scala:95:26, :159:22, :162:60, :163:64, :166:59, :180:18
    _GEN_87 = waddr == 3'h4;	// tlb.scala:203:22, :204:65
    _GEN_88 = ~io_ptw_resp_valid | _GEN_51 | ~_GEN_87;	// tlb.scala:122:29, :177:20, :196:70, :198:58, :204:{65,74}
    _GEN_89 = r_refill_tag[1:0] == 2'h0;	// package.scala:154:13, tlb.scala:94:18, :129:22, :130:25
    _GEN_90 =
      _GEN_88
        ? sectored_entries_4_valid_0
        : _GEN_89 | r_sectored_hit & sectored_entries_4_valid_0;	// tlb.scala:94:18, :98:40, :122:29, :134:27, :177:20, :196:70, :205:32
    _GEN_91 = r_refill_tag[1:0] == 2'h1;	// package.scala:15:47, :154:13, tlb.scala:94:18, :130:25
    _GEN_92 =
      _GEN_88
        ? sectored_entries_4_valid_1
        : _GEN_91 | r_sectored_hit & sectored_entries_4_valid_1;	// tlb.scala:94:18, :98:40, :122:29, :134:27, :177:20, :196:70, :205:32
    _GEN_93 = r_refill_tag[1:0] == 2'h2;	// package.scala:154:13, tlb.scala:80:31, :94:18, :130:25
    _GEN_94 =
      _GEN_88
        ? sectored_entries_4_valid_2
        : _GEN_93 | r_sectored_hit & sectored_entries_4_valid_2;	// tlb.scala:94:18, :98:40, :122:29, :134:27, :177:20, :196:70, :205:32
    _GEN_95 =
      _GEN_88
        ? sectored_entries_4_valid_3
        : (&(r_refill_tag[1:0])) | r_sectored_hit & sectored_entries_4_valid_3;	// package.scala:154:13, tlb.scala:94:18, :98:40, :122:29, :130:25, :134:27, :177:20, :196:70, :205:32
    _sectored_entries_4_data_T =
      {io_ptw_resp_bits_pte_ppn[19:0],
       io_ptw_resp_bits_pte_u,
       io_ptw_resp_bits_pte_g,
       io_ptw_resp_bits_ae,
       newEntry_sw,
       newEntry_sx,
       newEntry_sr,
       newEntry_pw,
       newEntry_px,
       newEntry_pr,
       newEntry_pal,
       newEntry_paa,
       newEntry_eff,
       newEntry_c,
       1'h0};	// PTW.scala:77:35, :78:40, :79:35, tlb.scala:95:26, :159:22, :162:60, :163:64, :166:59, :180:18
    _GEN_96 = waddr == 3'h5;	// tlb.scala:203:22, :204:65
    _GEN_97 = ~io_ptw_resp_valid | _GEN_51 | ~_GEN_96;	// tlb.scala:122:29, :177:20, :196:70, :198:58, :204:{65,74}
    _GEN_98 = r_refill_tag[1:0] == 2'h0;	// package.scala:154:13, tlb.scala:94:18, :129:22, :130:25
    _GEN_99 =
      _GEN_97
        ? sectored_entries_5_valid_0
        : _GEN_98 | r_sectored_hit & sectored_entries_5_valid_0;	// tlb.scala:94:18, :98:40, :122:29, :134:27, :177:20, :196:70, :205:32
    _GEN_100 = r_refill_tag[1:0] == 2'h1;	// package.scala:15:47, :154:13, tlb.scala:94:18, :130:25
    _GEN_101 =
      _GEN_97
        ? sectored_entries_5_valid_1
        : _GEN_100 | r_sectored_hit & sectored_entries_5_valid_1;	// tlb.scala:94:18, :98:40, :122:29, :134:27, :177:20, :196:70, :205:32
    _GEN_102 = r_refill_tag[1:0] == 2'h2;	// package.scala:154:13, tlb.scala:80:31, :94:18, :130:25
    _GEN_103 =
      _GEN_97
        ? sectored_entries_5_valid_2
        : _GEN_102 | r_sectored_hit & sectored_entries_5_valid_2;	// tlb.scala:94:18, :98:40, :122:29, :134:27, :177:20, :196:70, :205:32
    _GEN_104 =
      _GEN_97
        ? sectored_entries_5_valid_3
        : (&(r_refill_tag[1:0])) | r_sectored_hit & sectored_entries_5_valid_3;	// package.scala:154:13, tlb.scala:94:18, :98:40, :122:29, :130:25, :134:27, :177:20, :196:70, :205:32
    _sectored_entries_5_data_T =
      {io_ptw_resp_bits_pte_ppn[19:0],
       io_ptw_resp_bits_pte_u,
       io_ptw_resp_bits_pte_g,
       io_ptw_resp_bits_ae,
       newEntry_sw,
       newEntry_sx,
       newEntry_sr,
       newEntry_pw,
       newEntry_px,
       newEntry_pr,
       newEntry_pal,
       newEntry_paa,
       newEntry_eff,
       newEntry_c,
       1'h0};	// PTW.scala:77:35, :78:40, :79:35, tlb.scala:95:26, :159:22, :162:60, :163:64, :166:59, :180:18
    _GEN_105 = waddr == 3'h6;	// tlb.scala:203:22, :204:65
    _GEN_106 = ~io_ptw_resp_valid | _GEN_51 | ~_GEN_105;	// tlb.scala:122:29, :177:20, :196:70, :198:58, :204:{65,74}
    _GEN_107 = r_refill_tag[1:0] == 2'h0;	// package.scala:154:13, tlb.scala:94:18, :129:22, :130:25
    _GEN_108 =
      _GEN_106
        ? sectored_entries_6_valid_0
        : _GEN_107 | r_sectored_hit & sectored_entries_6_valid_0;	// tlb.scala:94:18, :98:40, :122:29, :134:27, :177:20, :196:70, :205:32
    _GEN_109 = r_refill_tag[1:0] == 2'h1;	// package.scala:15:47, :154:13, tlb.scala:94:18, :130:25
    _GEN_110 =
      _GEN_106
        ? sectored_entries_6_valid_1
        : _GEN_109 | r_sectored_hit & sectored_entries_6_valid_1;	// tlb.scala:94:18, :98:40, :122:29, :134:27, :177:20, :196:70, :205:32
    _GEN_111 = r_refill_tag[1:0] == 2'h2;	// package.scala:154:13, tlb.scala:80:31, :94:18, :130:25
    _GEN_112 =
      _GEN_106
        ? sectored_entries_6_valid_2
        : _GEN_111 | r_sectored_hit & sectored_entries_6_valid_2;	// tlb.scala:94:18, :98:40, :122:29, :134:27, :177:20, :196:70, :205:32
    _GEN_113 =
      _GEN_106
        ? sectored_entries_6_valid_3
        : (&(r_refill_tag[1:0])) | r_sectored_hit & sectored_entries_6_valid_3;	// package.scala:154:13, tlb.scala:94:18, :98:40, :122:29, :130:25, :134:27, :177:20, :196:70, :205:32
    _sectored_entries_6_data_T =
      {io_ptw_resp_bits_pte_ppn[19:0],
       io_ptw_resp_bits_pte_u,
       io_ptw_resp_bits_pte_g,
       io_ptw_resp_bits_ae,
       newEntry_sw,
       newEntry_sx,
       newEntry_sr,
       newEntry_pw,
       newEntry_px,
       newEntry_pr,
       newEntry_pal,
       newEntry_paa,
       newEntry_eff,
       newEntry_c,
       1'h0};	// PTW.scala:77:35, :78:40, :79:35, tlb.scala:95:26, :159:22, :162:60, :163:64, :166:59, :180:18
    _GEN_114 = ~io_ptw_resp_valid | _GEN_51 | ~(&waddr);	// tlb.scala:122:29, :177:20, :196:70, :198:58, :203:22, :204:{65,74}
    _GEN_115 = r_refill_tag[1:0] == 2'h0;	// package.scala:154:13, tlb.scala:94:18, :129:22, :130:25
    _GEN_116 =
      _GEN_114
        ? sectored_entries_7_valid_0
        : _GEN_115 | r_sectored_hit & sectored_entries_7_valid_0;	// tlb.scala:94:18, :98:40, :122:29, :134:27, :177:20, :196:70, :205:32
    _GEN_117 = r_refill_tag[1:0] == 2'h1;	// package.scala:15:47, :154:13, tlb.scala:94:18, :130:25
    _GEN_118 =
      _GEN_114
        ? sectored_entries_7_valid_1
        : _GEN_117 | r_sectored_hit & sectored_entries_7_valid_1;	// tlb.scala:94:18, :98:40, :122:29, :134:27, :177:20, :196:70, :205:32
    _GEN_119 = r_refill_tag[1:0] == 2'h2;	// package.scala:154:13, tlb.scala:80:31, :94:18, :130:25
    _GEN_120 =
      _GEN_114
        ? sectored_entries_7_valid_2
        : _GEN_119 | r_sectored_hit & sectored_entries_7_valid_2;	// tlb.scala:94:18, :98:40, :122:29, :134:27, :177:20, :196:70, :205:32
    _GEN_121 =
      _GEN_114
        ? sectored_entries_7_valid_3
        : (&(r_refill_tag[1:0])) | r_sectored_hit & sectored_entries_7_valid_3;	// package.scala:154:13, tlb.scala:94:18, :98:40, :122:29, :130:25, :134:27, :177:20, :196:70, :205:32
    _sectored_entries_7_data_T =
      {io_ptw_resp_bits_pte_ppn[19:0],
       io_ptw_resp_bits_pte_u,
       io_ptw_resp_bits_pte_g,
       io_ptw_resp_bits_ae,
       newEntry_sw,
       newEntry_sx,
       newEntry_sr,
       newEntry_pw,
       newEntry_px,
       newEntry_pr,
       newEntry_pal,
       newEntry_paa,
       newEntry_eff,
       newEntry_c,
       1'h0};	// PTW.scala:77:35, :78:40, :79:35, tlb.scala:95:26, :159:22, :162:60, :163:64, :166:59, :180:18
    _GEN_122 = {sector_hits_0_7, sector_hits_0_6, sector_hits_0_5};	// OneHot.scala:30:18, tlb.scala:59:42
    _GEN_123 = {sector_hits_0_3, sector_hits_0_2, sector_hits_0_1};	// OneHot.scala:31:18, tlb.scala:59:42
    _GEN_124 = {sector_hits_1_7, sector_hits_1_6, sector_hits_1_5};	// OneHot.scala:30:18, tlb.scala:59:42
    _GEN_125 = {sector_hits_1_3, sector_hits_1_2, sector_hits_1_1};	// OneHot.scala:31:18, tlb.scala:59:42
    _GEN_126 = io_req_0_valid & tlb_miss_0 & _io_miss_rdy_T;	// tlb.scala:270:60, :288:24, :314:45
    _GEN_127 =
      {superpage_entries_2_valid_0,
       superpage_entries_1_valid_0,
       superpage_entries_0_valid_0};	// Cat.scala:30:58, tlb.scala:123:30
    _GEN_128 = io_req_1_valid & tlb_miss_1 & _io_miss_rdy_T;	// tlb.scala:270:60, :288:24, :314:45
    _GEN_138 =
      _GEN_137
        ? ~(sectored_entries_0_data_0[0] | _GEN_131) & _GEN_54
        : ~_GEN_131 & _GEN_54;	// tlb.scala:55:41, :103:{36,60}, :107:{64,73}, :109:{44,48}, :122:29, :177:20, :196:70
    _GEN_139 =
      _GEN_137
        ? ~(sectored_entries_0_data_1[0] | _GEN_133) & _GEN_56
        : ~_GEN_133 & _GEN_56;	// tlb.scala:55:41, :103:{36,60}, :107:{64,73}, :109:{44,48}, :122:29, :177:20, :196:70
    _GEN_140 =
      _GEN_137
        ? ~(sectored_entries_0_data_2[0] | _GEN_135) & _GEN_58
        : ~_GEN_135 & _GEN_58;	// tlb.scala:55:41, :103:{36,60}, :107:{64,73}, :109:{44,48}, :122:29, :177:20, :196:70
    _GEN_141 =
      _GEN_137
        ? ~(sectored_entries_0_data_3[0] | _GEN_136) & _GEN_59
        : ~_GEN_136 & _GEN_59;	// tlb.scala:55:41, :103:{36,60}, :107:{64,73}, :109:{44,48}, :122:29, :177:20, :196:70
    _GEN_148 =
      _GEN_147
        ? ~(sectored_entries_1_data_0[0] | _GEN_143) & _GEN_63
        : ~_GEN_143 & _GEN_63;	// tlb.scala:55:41, :103:{36,60}, :107:{64,73}, :109:{44,48}, :122:29, :177:20, :196:70
    _GEN_149 =
      _GEN_147
        ? ~(sectored_entries_1_data_1[0] | _GEN_144) & _GEN_65
        : ~_GEN_144 & _GEN_65;	// tlb.scala:55:41, :103:{36,60}, :107:{64,73}, :109:{44,48}, :122:29, :177:20, :196:70
    _GEN_150 =
      _GEN_147
        ? ~(sectored_entries_1_data_2[0] | _GEN_145) & _GEN_67
        : ~_GEN_145 & _GEN_67;	// tlb.scala:55:41, :103:{36,60}, :107:{64,73}, :109:{44,48}, :122:29, :177:20, :196:70
    _GEN_151 =
      _GEN_147
        ? ~(sectored_entries_1_data_3[0] | _GEN_146) & _GEN_68
        : ~_GEN_146 & _GEN_68;	// tlb.scala:55:41, :103:{36,60}, :107:{64,73}, :109:{44,48}, :122:29, :177:20, :196:70
    _GEN_158 =
      _GEN_157
        ? ~(sectored_entries_2_data_0[0] | _GEN_153) & _GEN_72
        : ~_GEN_153 & _GEN_72;	// tlb.scala:55:41, :103:{36,60}, :107:{64,73}, :109:{44,48}, :122:29, :177:20, :196:70
    _GEN_159 =
      _GEN_157
        ? ~(sectored_entries_2_data_1[0] | _GEN_154) & _GEN_74
        : ~_GEN_154 & _GEN_74;	// tlb.scala:55:41, :103:{36,60}, :107:{64,73}, :109:{44,48}, :122:29, :177:20, :196:70
    _GEN_160 =
      _GEN_157
        ? ~(sectored_entries_2_data_2[0] | _GEN_155) & _GEN_76
        : ~_GEN_155 & _GEN_76;	// tlb.scala:55:41, :103:{36,60}, :107:{64,73}, :109:{44,48}, :122:29, :177:20, :196:70
    _GEN_161 =
      _GEN_157
        ? ~(sectored_entries_2_data_3[0] | _GEN_156) & _GEN_77
        : ~_GEN_156 & _GEN_77;	// tlb.scala:55:41, :103:{36,60}, :107:{64,73}, :109:{44,48}, :122:29, :177:20, :196:70
    _GEN_168 =
      _GEN_167
        ? ~(sectored_entries_3_data_0[0] | _GEN_163) & _GEN_81
        : ~_GEN_163 & _GEN_81;	// tlb.scala:55:41, :103:{36,60}, :107:{64,73}, :109:{44,48}, :122:29, :177:20, :196:70
    _GEN_169 =
      _GEN_167
        ? ~(sectored_entries_3_data_1[0] | _GEN_164) & _GEN_83
        : ~_GEN_164 & _GEN_83;	// tlb.scala:55:41, :103:{36,60}, :107:{64,73}, :109:{44,48}, :122:29, :177:20, :196:70
    _GEN_170 =
      _GEN_167
        ? ~(sectored_entries_3_data_2[0] | _GEN_165) & _GEN_85
        : ~_GEN_165 & _GEN_85;	// tlb.scala:55:41, :103:{36,60}, :107:{64,73}, :109:{44,48}, :122:29, :177:20, :196:70
    _GEN_171 =
      _GEN_167
        ? ~(sectored_entries_3_data_3[0] | _GEN_166) & _GEN_86
        : ~_GEN_166 & _GEN_86;	// tlb.scala:55:41, :103:{36,60}, :107:{64,73}, :109:{44,48}, :122:29, :177:20, :196:70
    _GEN_178 =
      _GEN_177
        ? ~(sectored_entries_4_data_0[0] | _GEN_173) & _GEN_90
        : ~_GEN_173 & _GEN_90;	// tlb.scala:55:41, :103:{36,60}, :107:{64,73}, :109:{44,48}, :122:29, :177:20, :196:70
    _GEN_179 =
      _GEN_177
        ? ~(sectored_entries_4_data_1[0] | _GEN_174) & _GEN_92
        : ~_GEN_174 & _GEN_92;	// tlb.scala:55:41, :103:{36,60}, :107:{64,73}, :109:{44,48}, :122:29, :177:20, :196:70
    _GEN_180 =
      _GEN_177
        ? ~(sectored_entries_4_data_2[0] | _GEN_175) & _GEN_94
        : ~_GEN_175 & _GEN_94;	// tlb.scala:55:41, :103:{36,60}, :107:{64,73}, :109:{44,48}, :122:29, :177:20, :196:70
    _GEN_181 =
      _GEN_177
        ? ~(sectored_entries_4_data_3[0] | _GEN_176) & _GEN_95
        : ~_GEN_176 & _GEN_95;	// tlb.scala:55:41, :103:{36,60}, :107:{64,73}, :109:{44,48}, :122:29, :177:20, :196:70
    _GEN_188 =
      _GEN_187
        ? ~(sectored_entries_5_data_0[0] | _GEN_183) & _GEN_99
        : ~_GEN_183 & _GEN_99;	// tlb.scala:55:41, :103:{36,60}, :107:{64,73}, :109:{44,48}, :122:29, :177:20, :196:70
    _GEN_189 =
      _GEN_187
        ? ~(sectored_entries_5_data_1[0] | _GEN_184) & _GEN_101
        : ~_GEN_184 & _GEN_101;	// tlb.scala:55:41, :103:{36,60}, :107:{64,73}, :109:{44,48}, :122:29, :177:20, :196:70
    _GEN_190 =
      _GEN_187
        ? ~(sectored_entries_5_data_2[0] | _GEN_185) & _GEN_103
        : ~_GEN_185 & _GEN_103;	// tlb.scala:55:41, :103:{36,60}, :107:{64,73}, :109:{44,48}, :122:29, :177:20, :196:70
    _GEN_191 =
      _GEN_187
        ? ~(sectored_entries_5_data_3[0] | _GEN_186) & _GEN_104
        : ~_GEN_186 & _GEN_104;	// tlb.scala:55:41, :103:{36,60}, :107:{64,73}, :109:{44,48}, :122:29, :177:20, :196:70
    _GEN_198 =
      _GEN_197
        ? ~(sectored_entries_6_data_0[0] | _GEN_193) & _GEN_108
        : ~_GEN_193 & _GEN_108;	// tlb.scala:55:41, :103:{36,60}, :107:{64,73}, :109:{44,48}, :122:29, :177:20, :196:70
    _GEN_199 =
      _GEN_197
        ? ~(sectored_entries_6_data_1[0] | _GEN_194) & _GEN_110
        : ~_GEN_194 & _GEN_110;	// tlb.scala:55:41, :103:{36,60}, :107:{64,73}, :109:{44,48}, :122:29, :177:20, :196:70
    _GEN_200 =
      _GEN_197
        ? ~(sectored_entries_6_data_2[0] | _GEN_195) & _GEN_112
        : ~_GEN_195 & _GEN_112;	// tlb.scala:55:41, :103:{36,60}, :107:{64,73}, :109:{44,48}, :122:29, :177:20, :196:70
    _GEN_201 =
      _GEN_197
        ? ~(sectored_entries_6_data_3[0] | _GEN_196) & _GEN_113
        : ~_GEN_196 & _GEN_113;	// tlb.scala:55:41, :103:{36,60}, :107:{64,73}, :109:{44,48}, :122:29, :177:20, :196:70
    _GEN_208 =
      _GEN_207
        ? ~(sectored_entries_7_data_0[0] | _GEN_203) & _GEN_116
        : ~_GEN_203 & _GEN_116;	// tlb.scala:55:41, :103:{36,60}, :107:{64,73}, :109:{44,48}, :122:29, :177:20, :196:70
    _GEN_209 =
      _GEN_207
        ? ~(sectored_entries_7_data_1[0] | _GEN_204) & _GEN_118
        : ~_GEN_204 & _GEN_118;	// tlb.scala:55:41, :103:{36,60}, :107:{64,73}, :109:{44,48}, :122:29, :177:20, :196:70
    _GEN_210 =
      _GEN_207
        ? ~(sectored_entries_7_data_2[0] | _GEN_205) & _GEN_120
        : ~_GEN_205 & _GEN_120;	// tlb.scala:55:41, :103:{36,60}, :107:{64,73}, :109:{44,48}, :122:29, :177:20, :196:70
    _GEN_211 =
      _GEN_207
        ? ~(sectored_entries_7_data_3[0] | _GEN_206) & _GEN_121
        : ~_GEN_206 & _GEN_121;	// tlb.scala:55:41, :103:{36,60}, :107:{64,73}, :109:{44,48}, :122:29, :177:20, :196:70
    if (_GEN_52) begin	// tlb.scala:122:29, :177:20, :196:70
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_0_tag <= r_refill_tag;	// tlb.scala:122:29, :130:25
    if (~io_ptw_resp_valid | _GEN_51 | ~(_GEN_50 & _GEN_53)) begin	// tlb.scala:94:18, :95:17, :122:29, :177:20, :196:70, :198:58, :204:{65,74}
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_0_data_0 <= _sectored_entries_0_data_T;	// tlb.scala:95:26, :122:29
    if (~io_ptw_resp_valid | _GEN_51 | ~(_GEN_50 & _GEN_55)) begin	// tlb.scala:94:18, :95:17, :122:29, :177:20, :196:70, :198:58, :204:{65,74}
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_0_data_1 <= _sectored_entries_0_data_T;	// tlb.scala:95:26, :122:29
    if (~io_ptw_resp_valid | _GEN_51 | ~(_GEN_50 & _GEN_57)) begin	// tlb.scala:94:18, :95:17, :122:29, :177:20, :196:70, :198:58, :204:{65,74}
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_0_data_2 <= _sectored_entries_0_data_T;	// tlb.scala:95:26, :122:29
    if (~io_ptw_resp_valid | _GEN_51 | ~(_GEN_50 & (&(r_refill_tag[1:0])))) begin	// package.scala:154:13, tlb.scala:94:18, :95:17, :122:29, :130:25, :177:20, :196:70, :198:58, :204:{65,74}
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_0_data_3 <= _sectored_entries_0_data_T;	// tlb.scala:95:26, :122:29
    sectored_entries_0_valid_0 <=
      ~_GEN_263
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_220
                     ? ~(sectored_entries_0_data_0[0] | _GEN_214) & _GEN_138
                     : ~_GEN_214 & _GEN_138)
                : io_sfence_bits_rs2 & sectored_entries_0_data_0[12] & _GEN_54)
           : _GEN_54);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    sectored_entries_0_valid_1 <=
      ~_GEN_263
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_220
                     ? ~(sectored_entries_0_data_1[0] | _GEN_216) & _GEN_139
                     : ~_GEN_216 & _GEN_139)
                : io_sfence_bits_rs2 & sectored_entries_0_data_1[12] & _GEN_56)
           : _GEN_56);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    sectored_entries_0_valid_2 <=
      ~_GEN_263
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_220
                     ? ~(sectored_entries_0_data_2[0] | _GEN_218) & _GEN_140
                     : ~_GEN_218 & _GEN_140)
                : io_sfence_bits_rs2 & sectored_entries_0_data_2[12] & _GEN_58)
           : _GEN_58);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    sectored_entries_0_valid_3 <=
      ~_GEN_263
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_220
                     ? ~(sectored_entries_0_data_3[0] | _GEN_219) & _GEN_141
                     : ~_GEN_219 & _GEN_141)
                : io_sfence_bits_rs2 & sectored_entries_0_data_3[12] & _GEN_59)
           : _GEN_59);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    if (_GEN_61) begin	// tlb.scala:122:29, :177:20, :196:70
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_1_tag <= r_refill_tag;	// tlb.scala:122:29, :130:25
    if (~io_ptw_resp_valid | _GEN_51 | ~(_GEN_60 & _GEN_62)) begin	// tlb.scala:94:18, :95:17, :122:29, :177:20, :196:70, :198:58, :204:{65,74}
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_1_data_0 <= _sectored_entries_1_data_T;	// tlb.scala:95:26, :122:29
    if (~io_ptw_resp_valid | _GEN_51 | ~(_GEN_60 & _GEN_64)) begin	// tlb.scala:94:18, :95:17, :122:29, :177:20, :196:70, :198:58, :204:{65,74}
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_1_data_1 <= _sectored_entries_1_data_T;	// tlb.scala:95:26, :122:29
    if (~io_ptw_resp_valid | _GEN_51 | ~(_GEN_60 & _GEN_66)) begin	// tlb.scala:94:18, :95:17, :122:29, :177:20, :196:70, :198:58, :204:{65,74}
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_1_data_2 <= _sectored_entries_1_data_T;	// tlb.scala:95:26, :122:29
    if (~io_ptw_resp_valid | _GEN_51 | ~(_GEN_60 & (&(r_refill_tag[1:0])))) begin	// package.scala:154:13, tlb.scala:94:18, :95:17, :122:29, :130:25, :177:20, :196:70, :198:58, :204:{65,74}
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_1_data_3 <= _sectored_entries_1_data_T;	// tlb.scala:95:26, :122:29
    sectored_entries_1_valid_0 <=
      ~_GEN_263
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_226
                     ? ~(sectored_entries_1_data_0[0] | _GEN_222) & _GEN_148
                     : ~_GEN_222 & _GEN_148)
                : io_sfence_bits_rs2 & sectored_entries_1_data_0[12] & _GEN_63)
           : _GEN_63);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    sectored_entries_1_valid_1 <=
      ~_GEN_263
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_226
                     ? ~(sectored_entries_1_data_1[0] | _GEN_223) & _GEN_149
                     : ~_GEN_223 & _GEN_149)
                : io_sfence_bits_rs2 & sectored_entries_1_data_1[12] & _GEN_65)
           : _GEN_65);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    sectored_entries_1_valid_2 <=
      ~_GEN_263
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_226
                     ? ~(sectored_entries_1_data_2[0] | _GEN_224) & _GEN_150
                     : ~_GEN_224 & _GEN_150)
                : io_sfence_bits_rs2 & sectored_entries_1_data_2[12] & _GEN_67)
           : _GEN_67);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    sectored_entries_1_valid_3 <=
      ~_GEN_263
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_226
                     ? ~(sectored_entries_1_data_3[0] | _GEN_225) & _GEN_151
                     : ~_GEN_225 & _GEN_151)
                : io_sfence_bits_rs2 & sectored_entries_1_data_3[12] & _GEN_68)
           : _GEN_68);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    if (_GEN_70) begin	// tlb.scala:122:29, :177:20, :196:70
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_2_tag <= r_refill_tag;	// tlb.scala:122:29, :130:25
    if (~io_ptw_resp_valid | _GEN_51 | ~(_GEN_69 & _GEN_71)) begin	// tlb.scala:94:18, :95:17, :122:29, :177:20, :196:70, :198:58, :204:{65,74}
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_2_data_0 <= _sectored_entries_2_data_T;	// tlb.scala:95:26, :122:29
    if (~io_ptw_resp_valid | _GEN_51 | ~(_GEN_69 & _GEN_73)) begin	// tlb.scala:94:18, :95:17, :122:29, :177:20, :196:70, :198:58, :204:{65,74}
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_2_data_1 <= _sectored_entries_2_data_T;	// tlb.scala:95:26, :122:29
    if (~io_ptw_resp_valid | _GEN_51 | ~(_GEN_69 & _GEN_75)) begin	// tlb.scala:94:18, :95:17, :122:29, :177:20, :196:70, :198:58, :204:{65,74}
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_2_data_2 <= _sectored_entries_2_data_T;	// tlb.scala:95:26, :122:29
    if (~io_ptw_resp_valid | _GEN_51 | ~(_GEN_69 & (&(r_refill_tag[1:0])))) begin	// package.scala:154:13, tlb.scala:94:18, :95:17, :122:29, :130:25, :177:20, :196:70, :198:58, :204:{65,74}
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_2_data_3 <= _sectored_entries_2_data_T;	// tlb.scala:95:26, :122:29
    sectored_entries_2_valid_0 <=
      ~_GEN_263
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_232
                     ? ~(sectored_entries_2_data_0[0] | _GEN_228) & _GEN_158
                     : ~_GEN_228 & _GEN_158)
                : io_sfence_bits_rs2 & sectored_entries_2_data_0[12] & _GEN_72)
           : _GEN_72);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    sectored_entries_2_valid_1 <=
      ~_GEN_263
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_232
                     ? ~(sectored_entries_2_data_1[0] | _GEN_229) & _GEN_159
                     : ~_GEN_229 & _GEN_159)
                : io_sfence_bits_rs2 & sectored_entries_2_data_1[12] & _GEN_74)
           : _GEN_74);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    sectored_entries_2_valid_2 <=
      ~_GEN_263
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_232
                     ? ~(sectored_entries_2_data_2[0] | _GEN_230) & _GEN_160
                     : ~_GEN_230 & _GEN_160)
                : io_sfence_bits_rs2 & sectored_entries_2_data_2[12] & _GEN_76)
           : _GEN_76);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    sectored_entries_2_valid_3 <=
      ~_GEN_263
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_232
                     ? ~(sectored_entries_2_data_3[0] | _GEN_231) & _GEN_161
                     : ~_GEN_231 & _GEN_161)
                : io_sfence_bits_rs2 & sectored_entries_2_data_3[12] & _GEN_77)
           : _GEN_77);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    if (_GEN_79) begin	// tlb.scala:122:29, :177:20, :196:70
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_3_tag <= r_refill_tag;	// tlb.scala:122:29, :130:25
    if (~io_ptw_resp_valid | _GEN_51 | ~(_GEN_78 & _GEN_80)) begin	// tlb.scala:94:18, :95:17, :122:29, :177:20, :196:70, :198:58, :204:{65,74}
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_3_data_0 <= _sectored_entries_3_data_T;	// tlb.scala:95:26, :122:29
    if (~io_ptw_resp_valid | _GEN_51 | ~(_GEN_78 & _GEN_82)) begin	// tlb.scala:94:18, :95:17, :122:29, :177:20, :196:70, :198:58, :204:{65,74}
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_3_data_1 <= _sectored_entries_3_data_T;	// tlb.scala:95:26, :122:29
    if (~io_ptw_resp_valid | _GEN_51 | ~(_GEN_78 & _GEN_84)) begin	// tlb.scala:94:18, :95:17, :122:29, :177:20, :196:70, :198:58, :204:{65,74}
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_3_data_2 <= _sectored_entries_3_data_T;	// tlb.scala:95:26, :122:29
    if (~io_ptw_resp_valid | _GEN_51 | ~(_GEN_78 & (&(r_refill_tag[1:0])))) begin	// package.scala:154:13, tlb.scala:94:18, :95:17, :122:29, :130:25, :177:20, :196:70, :198:58, :204:{65,74}
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_3_data_3 <= _sectored_entries_3_data_T;	// tlb.scala:95:26, :122:29
    sectored_entries_3_valid_0 <=
      ~_GEN_263
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_238
                     ? ~(sectored_entries_3_data_0[0] | _GEN_234) & _GEN_168
                     : ~_GEN_234 & _GEN_168)
                : io_sfence_bits_rs2 & sectored_entries_3_data_0[12] & _GEN_81)
           : _GEN_81);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    sectored_entries_3_valid_1 <=
      ~_GEN_263
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_238
                     ? ~(sectored_entries_3_data_1[0] | _GEN_235) & _GEN_169
                     : ~_GEN_235 & _GEN_169)
                : io_sfence_bits_rs2 & sectored_entries_3_data_1[12] & _GEN_83)
           : _GEN_83);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    sectored_entries_3_valid_2 <=
      ~_GEN_263
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_238
                     ? ~(sectored_entries_3_data_2[0] | _GEN_236) & _GEN_170
                     : ~_GEN_236 & _GEN_170)
                : io_sfence_bits_rs2 & sectored_entries_3_data_2[12] & _GEN_85)
           : _GEN_85);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    sectored_entries_3_valid_3 <=
      ~_GEN_263
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_238
                     ? ~(sectored_entries_3_data_3[0] | _GEN_237) & _GEN_171
                     : ~_GEN_237 & _GEN_171)
                : io_sfence_bits_rs2 & sectored_entries_3_data_3[12] & _GEN_86)
           : _GEN_86);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    if (_GEN_88) begin	// tlb.scala:122:29, :177:20, :196:70
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_4_tag <= r_refill_tag;	// tlb.scala:122:29, :130:25
    if (~io_ptw_resp_valid | _GEN_51 | ~(_GEN_87 & _GEN_89)) begin	// tlb.scala:94:18, :95:17, :122:29, :177:20, :196:70, :198:58, :204:{65,74}
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_4_data_0 <= _sectored_entries_4_data_T;	// tlb.scala:95:26, :122:29
    if (~io_ptw_resp_valid | _GEN_51 | ~(_GEN_87 & _GEN_91)) begin	// tlb.scala:94:18, :95:17, :122:29, :177:20, :196:70, :198:58, :204:{65,74}
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_4_data_1 <= _sectored_entries_4_data_T;	// tlb.scala:95:26, :122:29
    if (~io_ptw_resp_valid | _GEN_51 | ~(_GEN_87 & _GEN_93)) begin	// tlb.scala:94:18, :95:17, :122:29, :177:20, :196:70, :198:58, :204:{65,74}
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_4_data_2 <= _sectored_entries_4_data_T;	// tlb.scala:95:26, :122:29
    if (~io_ptw_resp_valid | _GEN_51 | ~(_GEN_87 & (&(r_refill_tag[1:0])))) begin	// package.scala:154:13, tlb.scala:94:18, :95:17, :122:29, :130:25, :177:20, :196:70, :198:58, :204:{65,74}
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_4_data_3 <= _sectored_entries_4_data_T;	// tlb.scala:95:26, :122:29
    sectored_entries_4_valid_0 <=
      ~_GEN_263
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_244
                     ? ~(sectored_entries_4_data_0[0] | _GEN_240) & _GEN_178
                     : ~_GEN_240 & _GEN_178)
                : io_sfence_bits_rs2 & sectored_entries_4_data_0[12] & _GEN_90)
           : _GEN_90);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    sectored_entries_4_valid_1 <=
      ~_GEN_263
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_244
                     ? ~(sectored_entries_4_data_1[0] | _GEN_241) & _GEN_179
                     : ~_GEN_241 & _GEN_179)
                : io_sfence_bits_rs2 & sectored_entries_4_data_1[12] & _GEN_92)
           : _GEN_92);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    sectored_entries_4_valid_2 <=
      ~_GEN_263
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_244
                     ? ~(sectored_entries_4_data_2[0] | _GEN_242) & _GEN_180
                     : ~_GEN_242 & _GEN_180)
                : io_sfence_bits_rs2 & sectored_entries_4_data_2[12] & _GEN_94)
           : _GEN_94);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    sectored_entries_4_valid_3 <=
      ~_GEN_263
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_244
                     ? ~(sectored_entries_4_data_3[0] | _GEN_243) & _GEN_181
                     : ~_GEN_243 & _GEN_181)
                : io_sfence_bits_rs2 & sectored_entries_4_data_3[12] & _GEN_95)
           : _GEN_95);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    if (_GEN_97) begin	// tlb.scala:122:29, :177:20, :196:70
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_5_tag <= r_refill_tag;	// tlb.scala:122:29, :130:25
    if (~io_ptw_resp_valid | _GEN_51 | ~(_GEN_96 & _GEN_98)) begin	// tlb.scala:94:18, :95:17, :122:29, :177:20, :196:70, :198:58, :204:{65,74}
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_5_data_0 <= _sectored_entries_5_data_T;	// tlb.scala:95:26, :122:29
    if (~io_ptw_resp_valid | _GEN_51 | ~(_GEN_96 & _GEN_100)) begin	// tlb.scala:94:18, :95:17, :122:29, :177:20, :196:70, :198:58, :204:{65,74}
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_5_data_1 <= _sectored_entries_5_data_T;	// tlb.scala:95:26, :122:29
    if (~io_ptw_resp_valid | _GEN_51 | ~(_GEN_96 & _GEN_102)) begin	// tlb.scala:94:18, :95:17, :122:29, :177:20, :196:70, :198:58, :204:{65,74}
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_5_data_2 <= _sectored_entries_5_data_T;	// tlb.scala:95:26, :122:29
    if (~io_ptw_resp_valid | _GEN_51 | ~(_GEN_96 & (&(r_refill_tag[1:0])))) begin	// package.scala:154:13, tlb.scala:94:18, :95:17, :122:29, :130:25, :177:20, :196:70, :198:58, :204:{65,74}
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_5_data_3 <= _sectored_entries_5_data_T;	// tlb.scala:95:26, :122:29
    sectored_entries_5_valid_0 <=
      ~_GEN_263
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_250
                     ? ~(sectored_entries_5_data_0[0] | _GEN_246) & _GEN_188
                     : ~_GEN_246 & _GEN_188)
                : io_sfence_bits_rs2 & sectored_entries_5_data_0[12] & _GEN_99)
           : _GEN_99);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    sectored_entries_5_valid_1 <=
      ~_GEN_263
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_250
                     ? ~(sectored_entries_5_data_1[0] | _GEN_247) & _GEN_189
                     : ~_GEN_247 & _GEN_189)
                : io_sfence_bits_rs2 & sectored_entries_5_data_1[12] & _GEN_101)
           : _GEN_101);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    sectored_entries_5_valid_2 <=
      ~_GEN_263
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_250
                     ? ~(sectored_entries_5_data_2[0] | _GEN_248) & _GEN_190
                     : ~_GEN_248 & _GEN_190)
                : io_sfence_bits_rs2 & sectored_entries_5_data_2[12] & _GEN_103)
           : _GEN_103);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    sectored_entries_5_valid_3 <=
      ~_GEN_263
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_250
                     ? ~(sectored_entries_5_data_3[0] | _GEN_249) & _GEN_191
                     : ~_GEN_249 & _GEN_191)
                : io_sfence_bits_rs2 & sectored_entries_5_data_3[12] & _GEN_104)
           : _GEN_104);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    if (_GEN_106) begin	// tlb.scala:122:29, :177:20, :196:70
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_6_tag <= r_refill_tag;	// tlb.scala:122:29, :130:25
    if (~io_ptw_resp_valid | _GEN_51 | ~(_GEN_105 & _GEN_107)) begin	// tlb.scala:94:18, :95:17, :122:29, :177:20, :196:70, :198:58, :204:{65,74}
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_6_data_0 <= _sectored_entries_6_data_T;	// tlb.scala:95:26, :122:29
    if (~io_ptw_resp_valid | _GEN_51 | ~(_GEN_105 & _GEN_109)) begin	// tlb.scala:94:18, :95:17, :122:29, :177:20, :196:70, :198:58, :204:{65,74}
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_6_data_1 <= _sectored_entries_6_data_T;	// tlb.scala:95:26, :122:29
    if (~io_ptw_resp_valid | _GEN_51 | ~(_GEN_105 & _GEN_111)) begin	// tlb.scala:94:18, :95:17, :122:29, :177:20, :196:70, :198:58, :204:{65,74}
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_6_data_2 <= _sectored_entries_6_data_T;	// tlb.scala:95:26, :122:29
    if (~io_ptw_resp_valid | _GEN_51 | ~(_GEN_105 & (&(r_refill_tag[1:0])))) begin	// package.scala:154:13, tlb.scala:94:18, :95:17, :122:29, :130:25, :177:20, :196:70, :198:58, :204:{65,74}
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_6_data_3 <= _sectored_entries_6_data_T;	// tlb.scala:95:26, :122:29
    sectored_entries_6_valid_0 <=
      ~_GEN_263
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_256
                     ? ~(sectored_entries_6_data_0[0] | _GEN_252) & _GEN_198
                     : ~_GEN_252 & _GEN_198)
                : io_sfence_bits_rs2 & sectored_entries_6_data_0[12] & _GEN_108)
           : _GEN_108);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    sectored_entries_6_valid_1 <=
      ~_GEN_263
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_256
                     ? ~(sectored_entries_6_data_1[0] | _GEN_253) & _GEN_199
                     : ~_GEN_253 & _GEN_199)
                : io_sfence_bits_rs2 & sectored_entries_6_data_1[12] & _GEN_110)
           : _GEN_110);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    sectored_entries_6_valid_2 <=
      ~_GEN_263
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_256
                     ? ~(sectored_entries_6_data_2[0] | _GEN_254) & _GEN_200
                     : ~_GEN_254 & _GEN_200)
                : io_sfence_bits_rs2 & sectored_entries_6_data_2[12] & _GEN_112)
           : _GEN_112);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    sectored_entries_6_valid_3 <=
      ~_GEN_263
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_256
                     ? ~(sectored_entries_6_data_3[0] | _GEN_255) & _GEN_201
                     : ~_GEN_255 & _GEN_201)
                : io_sfence_bits_rs2 & sectored_entries_6_data_3[12] & _GEN_113)
           : _GEN_113);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    if (_GEN_114) begin	// tlb.scala:122:29, :177:20, :196:70
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_7_tag <= r_refill_tag;	// tlb.scala:122:29, :130:25
    if (~io_ptw_resp_valid | _GEN_51 | ~((&waddr) & _GEN_115)) begin	// tlb.scala:94:18, :95:17, :122:29, :177:20, :196:70, :198:58, :203:22, :204:{65,74}
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_7_data_0 <= _sectored_entries_7_data_T;	// tlb.scala:95:26, :122:29
    if (~io_ptw_resp_valid | _GEN_51 | ~((&waddr) & _GEN_117)) begin	// tlb.scala:94:18, :95:17, :122:29, :177:20, :196:70, :198:58, :203:22, :204:{65,74}
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_7_data_1 <= _sectored_entries_7_data_T;	// tlb.scala:95:26, :122:29
    if (~io_ptw_resp_valid | _GEN_51 | ~((&waddr) & _GEN_119)) begin	// tlb.scala:94:18, :95:17, :122:29, :177:20, :196:70, :198:58, :203:22, :204:{65,74}
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_7_data_2 <= _sectored_entries_7_data_T;	// tlb.scala:95:26, :122:29
    if (~io_ptw_resp_valid | _GEN_51 | ~((&waddr) & (&(r_refill_tag[1:0])))) begin	// package.scala:154:13, tlb.scala:94:18, :95:17, :122:29, :130:25, :177:20, :196:70, :198:58, :203:22, :204:{65,74}
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_7_data_3 <= _sectored_entries_7_data_T;	// tlb.scala:95:26, :122:29
    sectored_entries_7_valid_0 <=
      ~_GEN_263
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_262
                     ? ~(sectored_entries_7_data_0[0] | _GEN_258) & _GEN_208
                     : ~_GEN_258 & _GEN_208)
                : io_sfence_bits_rs2 & sectored_entries_7_data_0[12] & _GEN_116)
           : _GEN_116);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    sectored_entries_7_valid_1 <=
      ~_GEN_263
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_262
                     ? ~(sectored_entries_7_data_1[0] | _GEN_259) & _GEN_209
                     : ~_GEN_259 & _GEN_209)
                : io_sfence_bits_rs2 & sectored_entries_7_data_1[12] & _GEN_118)
           : _GEN_118);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    sectored_entries_7_valid_2 <=
      ~_GEN_263
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_262
                     ? ~(sectored_entries_7_data_2[0] | _GEN_260) & _GEN_210
                     : ~_GEN_260 & _GEN_210)
                : io_sfence_bits_rs2 & sectored_entries_7_data_2[12] & _GEN_120)
           : _GEN_120);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    sectored_entries_7_valid_3 <=
      ~_GEN_263
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_262
                     ? ~(sectored_entries_7_data_3[0] | _GEN_261) & _GEN_211
                     : ~_GEN_261 & _GEN_211)
                : io_sfence_bits_rs2 & sectored_entries_7_data_3[12] & _GEN_121)
           : _GEN_121);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    if (_GEN_42) begin	// tlb.scala:123:30, :177:20, :196:70
      superpage_entries_0_level <= {1'h0, io_ptw_resp_bits_level[0]};	// package.scala:154:13, tlb.scala:91:18, :123:30
      superpage_entries_0_tag <= r_refill_tag;	// tlb.scala:123:30, :130:25
      superpage_entries_0_data_0 <=
        {io_ptw_resp_bits_pte_ppn[19:0],
         io_ptw_resp_bits_pte_u,
         io_ptw_resp_bits_pte_g,
         io_ptw_resp_bits_ae,
         newEntry_sw,
         newEntry_sx,
         newEntry_sr,
         newEntry_pw,
         newEntry_px,
         newEntry_pr,
         newEntry_pal,
         newEntry_paa,
         newEntry_eff,
         newEntry_c,
         1'h0};	// PTW.scala:77:35, :78:40, :79:35, tlb.scala:95:26, :123:30, :159:22, :162:60, :163:64, :166:59, :180:18
    end
    superpage_entries_0_valid_0 <=
      ~_GEN_263
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? ~(superpage_entries_0_valid_0
                    & superpage_entries_0_tag[26:18] == io_req_1_bits_vaddr[38:30]
                    & (ignore_1
                       | superpage_entries_0_tag[17:9] == io_req_1_bits_vaddr[29:21])
                    | superpage_entries_0_valid_0
                    & superpage_entries_0_tag[26:18] == io_req_0_bits_vaddr[38:30]
                    & (ignore_1
                       | superpage_entries_0_tag[17:9] == io_req_0_bits_vaddr[29:21]))
                  & _GEN_43
                : io_sfence_bits_rs2 & superpage_entries_0_data_0[12] & _GEN_43)
           : _GEN_43);	// tlb.scala:55:41, :66:30, :67:{31,42,48,79,86}, :98:40, :101:26, :115:22, :123:30, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    if (_GEN_44) begin	// tlb.scala:123:30, :177:20, :196:70
      superpage_entries_1_level <= {1'h0, io_ptw_resp_bits_level[0]};	// package.scala:154:13, tlb.scala:91:18, :123:30
      superpage_entries_1_tag <= r_refill_tag;	// tlb.scala:123:30, :130:25
      superpage_entries_1_data_0 <=
        {io_ptw_resp_bits_pte_ppn[19:0],
         io_ptw_resp_bits_pte_u,
         io_ptw_resp_bits_pte_g,
         io_ptw_resp_bits_ae,
         newEntry_sw,
         newEntry_sx,
         newEntry_sr,
         newEntry_pw,
         newEntry_px,
         newEntry_pr,
         newEntry_pal,
         newEntry_paa,
         newEntry_eff,
         newEntry_c,
         1'h0};	// PTW.scala:77:35, :78:40, :79:35, tlb.scala:95:26, :123:30, :159:22, :162:60, :163:64, :166:59, :180:18
    end
    superpage_entries_1_valid_0 <=
      ~_GEN_263
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? ~(superpage_entries_1_valid_0
                    & superpage_entries_1_tag[26:18] == io_req_1_bits_vaddr[38:30]
                    & (ignore_4
                       | superpage_entries_1_tag[17:9] == io_req_1_bits_vaddr[29:21])
                    | superpage_entries_1_valid_0
                    & superpage_entries_1_tag[26:18] == io_req_0_bits_vaddr[38:30]
                    & (ignore_4
                       | superpage_entries_1_tag[17:9] == io_req_0_bits_vaddr[29:21]))
                  & _GEN_45
                : io_sfence_bits_rs2 & superpage_entries_1_data_0[12] & _GEN_45)
           : _GEN_45);	// tlb.scala:55:41, :66:30, :67:{31,42,48,79,86}, :98:40, :101:26, :115:22, :123:30, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    if (_GEN_46) begin	// tlb.scala:123:30, :177:20, :196:70
      superpage_entries_2_level <= {1'h0, io_ptw_resp_bits_level[0]};	// package.scala:154:13, tlb.scala:91:18, :123:30
      superpage_entries_2_tag <= r_refill_tag;	// tlb.scala:123:30, :130:25
      superpage_entries_2_data_0 <=
        {io_ptw_resp_bits_pte_ppn[19:0],
         io_ptw_resp_bits_pte_u,
         io_ptw_resp_bits_pte_g,
         io_ptw_resp_bits_ae,
         newEntry_sw,
         newEntry_sx,
         newEntry_sr,
         newEntry_pw,
         newEntry_px,
         newEntry_pr,
         newEntry_pal,
         newEntry_paa,
         newEntry_eff,
         newEntry_c,
         1'h0};	// PTW.scala:77:35, :78:40, :79:35, tlb.scala:95:26, :123:30, :159:22, :162:60, :163:64, :166:59, :180:18
    end
    superpage_entries_2_valid_0 <=
      ~_GEN_263
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? ~(superpage_entries_2_valid_0
                    & superpage_entries_2_tag[26:18] == io_req_1_bits_vaddr[38:30]
                    & (ignore_7
                       | superpage_entries_2_tag[17:9] == io_req_1_bits_vaddr[29:21])
                    | superpage_entries_2_valid_0
                    & superpage_entries_2_tag[26:18] == io_req_0_bits_vaddr[38:30]
                    & (ignore_7
                       | superpage_entries_2_tag[17:9] == io_req_0_bits_vaddr[29:21]))
                  & _GEN_47
                : io_sfence_bits_rs2 & superpage_entries_2_data_0[12] & _GEN_47)
           : _GEN_47);	// tlb.scala:55:41, :66:30, :67:{31,42,48,79,86}, :98:40, :101:26, :115:22, :123:30, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    if (_GEN_48) begin	// tlb.scala:123:30, :177:20, :196:70
      superpage_entries_3_level <= {1'h0, io_ptw_resp_bits_level[0]};	// package.scala:154:13, tlb.scala:91:18, :123:30
      superpage_entries_3_tag <= r_refill_tag;	// tlb.scala:123:30, :130:25
      superpage_entries_3_data_0 <=
        {io_ptw_resp_bits_pte_ppn[19:0],
         io_ptw_resp_bits_pte_u,
         io_ptw_resp_bits_pte_g,
         io_ptw_resp_bits_ae,
         newEntry_sw,
         newEntry_sx,
         newEntry_sr,
         newEntry_pw,
         newEntry_px,
         newEntry_pr,
         newEntry_pal,
         newEntry_paa,
         newEntry_eff,
         newEntry_c,
         1'h0};	// PTW.scala:77:35, :78:40, :79:35, tlb.scala:95:26, :123:30, :159:22, :162:60, :163:64, :166:59, :180:18
    end
    superpage_entries_3_valid_0 <=
      ~_GEN_263
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? ~(superpage_entries_3_valid_0
                    & superpage_entries_3_tag[26:18] == io_req_1_bits_vaddr[38:30]
                    & (ignore_10
                       | superpage_entries_3_tag[17:9] == io_req_1_bits_vaddr[29:21])
                    | superpage_entries_3_valid_0
                    & superpage_entries_3_tag[26:18] == io_req_0_bits_vaddr[38:30]
                    & (ignore_10
                       | superpage_entries_3_tag[17:9] == io_req_0_bits_vaddr[29:21]))
                  & _GEN_49
                : io_sfence_bits_rs2 & superpage_entries_3_data_0[12] & _GEN_49)
           : _GEN_49);	// tlb.scala:55:41, :66:30, :67:{31,42,48,79,86}, :98:40, :101:26, :115:22, :123:30, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    if (_GEN_40) begin	// tlb.scala:90:16, :124:56, :177:20, :196:70
      special_entry_level <= io_ptw_resp_bits_level;	// tlb.scala:124:56
      special_entry_tag <= r_refill_tag;	// tlb.scala:124:56, :130:25
      special_entry_data_0 <=
        {io_ptw_resp_bits_pte_ppn[19:0],
         io_ptw_resp_bits_pte_u,
         io_ptw_resp_bits_pte_g,
         io_ptw_resp_bits_ae,
         newEntry_sw,
         newEntry_sx,
         newEntry_sr,
         newEntry_pw,
         newEntry_px,
         newEntry_pr,
         newEntry_pal,
         newEntry_paa,
         newEntry_eff,
         newEntry_c,
         1'h0};	// PTW.scala:77:35, :78:40, :79:35, tlb.scala:95:26, :124:56, :159:22, :162:60, :163:64, :166:59, :180:18
    end
    special_entry_valid_0 <=
      ~_GEN_263
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? ~(special_entry_valid_0
                    & special_entry_tag[26:18] == io_req_1_bits_vaddr[38:30]
                    & (ignore_13 | special_entry_tag[17:9] == io_req_1_bits_vaddr[29:21])
                    & (~(special_entry_level[1])
                       | special_entry_tag[8:0] == io_req_1_bits_vaddr[20:12])
                    | special_entry_valid_0
                    & special_entry_tag[26:18] == io_req_0_bits_vaddr[38:30]
                    & (ignore_13 | special_entry_tag[17:9] == io_req_0_bits_vaddr[29:21])
                    & (~(special_entry_level[1])
                       | special_entry_tag[8:0] == io_req_0_bits_vaddr[20:12])) & _GEN_41
                : io_sfence_bits_rs2 & special_entry_data_0[12] & _GEN_41)
           : _GEN_41);	// tlb.scala:55:41, :67:{31,42,48,79,86}, :80:31, :94:18, :98:40, :101:26, :115:22, :124:56, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    if (_GEN_128) begin	// tlb.scala:314:45
      automatic logic       r_sectored_repl_addr_valids_lo_lo_lo_1;	// package.scala:72:59
      automatic logic       r_sectored_repl_addr_valids_lo_lo_hi_1;	// package.scala:72:59
      automatic logic       r_sectored_repl_addr_valids_lo_hi_lo_1;	// package.scala:72:59
      automatic logic       r_sectored_repl_addr_valids_lo_hi_hi_1;	// package.scala:72:59
      automatic logic       r_sectored_repl_addr_valids_hi_lo_lo_1;	// package.scala:72:59
      automatic logic       r_sectored_repl_addr_valids_hi_lo_hi_1;	// package.scala:72:59
      automatic logic       r_sectored_repl_addr_valids_hi_hi_lo_1;	// package.scala:72:59
      automatic logic [2:0] _r_sectored_hit_addr_T_5;	// OneHot.scala:32:28
      r_sectored_repl_addr_valids_lo_lo_lo_1 =
        _r_sectored_repl_addr_valids_T_16 | sectored_entries_0_valid_2
        | sectored_entries_0_valid_3;	// package.scala:72:59, tlb.scala:122:29
      r_sectored_repl_addr_valids_lo_lo_hi_1 =
        _r_sectored_repl_addr_valids_T_18 | sectored_entries_1_valid_2
        | sectored_entries_1_valid_3;	// package.scala:72:59, tlb.scala:122:29
      r_sectored_repl_addr_valids_lo_hi_lo_1 =
        _r_sectored_repl_addr_valids_T_20 | sectored_entries_2_valid_2
        | sectored_entries_2_valid_3;	// package.scala:72:59, tlb.scala:122:29
      r_sectored_repl_addr_valids_lo_hi_hi_1 =
        _r_sectored_repl_addr_valids_T_22 | sectored_entries_3_valid_2
        | sectored_entries_3_valid_3;	// package.scala:72:59, tlb.scala:122:29
      r_sectored_repl_addr_valids_hi_lo_lo_1 =
        _r_sectored_repl_addr_valids_T_24 | sectored_entries_4_valid_2
        | sectored_entries_4_valid_3;	// package.scala:72:59, tlb.scala:122:29
      r_sectored_repl_addr_valids_hi_lo_hi_1 =
        _r_sectored_repl_addr_valids_T_26 | sectored_entries_5_valid_2
        | sectored_entries_5_valid_3;	// package.scala:72:59, tlb.scala:122:29
      r_sectored_repl_addr_valids_hi_hi_lo_1 =
        _r_sectored_repl_addr_valids_T_28 | sectored_entries_6_valid_2
        | sectored_entries_6_valid_3;	// package.scala:72:59, tlb.scala:122:29
      _r_sectored_hit_addr_T_5 = _GEN_124 | _GEN_125;	// OneHot.scala:30:18, :31:18, :32:28
      r_refill_tag <= io_req_1_bits_vaddr[38:12];	// tlb.scala:130:25, :142:47
      if (&{superpage_entries_3_valid_0,
            superpage_entries_2_valid_0,
            superpage_entries_1_valid_0,
            superpage_entries_0_valid_0})	// Cat.scala:30:58, tlb.scala:123:30, :353:16
        r_superpage_repl_addr <=
          {state_reg_1[2], state_reg_1[2] ? state_reg_1[1] : state_reg_1[0]};	// Cat.scala:30:58, Replacement.scala:168:70, :243:38, :245:38, :250:16, package.scala:154:13, tlb.scala:131:34
      else begin	// tlb.scala:353:16
        automatic logic [2:0] _r_superpage_repl_addr_T_17;	// tlb.scala:353:43
        _r_superpage_repl_addr_T_17 = ~_GEN_127;	// Cat.scala:30:58, tlb.scala:353:43
        if (_r_superpage_repl_addr_T_17[0])	// OneHot.scala:47:40, tlb.scala:353:43
          r_superpage_repl_addr <= 2'h0;	// tlb.scala:129:22, :131:34
        else if (_r_superpage_repl_addr_T_17[1])	// OneHot.scala:47:40, tlb.scala:353:43
          r_superpage_repl_addr <= 2'h1;	// package.scala:15:47, tlb.scala:131:34
        else	// OneHot.scala:47:40
          r_superpage_repl_addr <= {1'h1, ~(_r_superpage_repl_addr_T_17[2])};	// Mux.scala:47:69, OneHot.scala:47:40, tlb.scala:131:34, :139:112, :353:43
      end
      if (&{_r_sectored_repl_addr_valids_T_30 | sectored_entries_7_valid_2
              | sectored_entries_7_valid_3,
            r_sectored_repl_addr_valids_hi_hi_lo_1,
            r_sectored_repl_addr_valids_hi_lo_hi_1,
            r_sectored_repl_addr_valids_hi_lo_lo_1,
            r_sectored_repl_addr_valids_lo_hi_hi_1,
            r_sectored_repl_addr_valids_lo_hi_lo_1,
            r_sectored_repl_addr_valids_lo_lo_hi_1,
            r_sectored_repl_addr_valids_lo_lo_lo_1})	// Cat.scala:30:58, package.scala:72:59, tlb.scala:122:29, :353:16
        r_sectored_repl_addr <=
          {state_reg[6],
           state_reg[6]
             ? {state_reg[5], state_reg[5] ? state_reg[4] : state_reg[3]}
             : {state_reg[2], state_reg[2] ? state_reg[1] : state_reg[0]}};	// Cat.scala:30:58, Replacement.scala:168:70, :243:38, :245:38, :250:16, package.scala:154:13, tlb.scala:132:33
      else begin	// tlb.scala:353:16
        automatic logic [6:0] _r_sectored_repl_addr_T_33;	// tlb.scala:353:43
        _r_sectored_repl_addr_T_33 =
          ~{r_sectored_repl_addr_valids_hi_hi_lo_1,
            r_sectored_repl_addr_valids_hi_lo_hi_1,
            r_sectored_repl_addr_valids_hi_lo_lo_1,
            r_sectored_repl_addr_valids_lo_hi_hi_1,
            r_sectored_repl_addr_valids_lo_hi_lo_1,
            r_sectored_repl_addr_valids_lo_lo_hi_1,
            r_sectored_repl_addr_valids_lo_lo_lo_1};	// Cat.scala:30:58, package.scala:72:59, tlb.scala:353:43
        if (_r_sectored_repl_addr_T_33[0])	// OneHot.scala:47:40, tlb.scala:353:43
          r_sectored_repl_addr <= 3'h0;	// Replacement.scala:168:70, tlb.scala:132:33
        else if (_r_sectored_repl_addr_T_33[1])	// OneHot.scala:47:40, tlb.scala:353:43
          r_sectored_repl_addr <= 3'h1;	// Mux.scala:47:69, tlb.scala:132:33
        else if (_r_sectored_repl_addr_T_33[2])	// OneHot.scala:47:40, tlb.scala:353:43
          r_sectored_repl_addr <= 3'h2;	// Mux.scala:47:69, tlb.scala:132:33
        else if (_r_sectored_repl_addr_T_33[3])	// OneHot.scala:47:40, tlb.scala:353:43
          r_sectored_repl_addr <= 3'h3;	// Mux.scala:47:69, tlb.scala:132:33
        else if (_r_sectored_repl_addr_T_33[4])	// OneHot.scala:47:40, tlb.scala:353:43
          r_sectored_repl_addr <= 3'h4;	// tlb.scala:132:33, :204:65
        else if (_r_sectored_repl_addr_T_33[5])	// OneHot.scala:47:40, tlb.scala:353:43
          r_sectored_repl_addr <= 3'h5;	// tlb.scala:132:33, :204:65
        else	// OneHot.scala:47:40
          r_sectored_repl_addr <= {2'h3, ~(_r_sectored_repl_addr_T_33[6])};	// Mux.scala:47:69, OneHot.scala:47:40, package.scala:15:47, tlb.scala:132:33, :353:43
      end
      r_sectored_hit_addr <=
        {|{sector_hits_1_7, sector_hits_1_6, sector_hits_1_5, sector_hits_1_4},
         |(_r_sectored_hit_addr_T_5[2:1]),
         _r_sectored_hit_addr_T_5[2] | _r_sectored_hit_addr_T_5[0]};	// Cat.scala:30:58, OneHot.scala:30:18, :31:18, :32:{14,28}, tlb.scala:59:42, :133:32
      r_sectored_hit <=
        sector_hits_1_0 | sector_hits_1_1 | sector_hits_1_2 | sector_hits_1_3
        | sector_hits_1_4 | sector_hits_1_5 | sector_hits_1_6 | sector_hits_1_7;	// package.scala:72:59, tlb.scala:59:42, :134:27
    end
    else if (_GEN_126) begin	// tlb.scala:314:45
      automatic logic       r_sectored_repl_addr_valids_lo_lo_lo;	// package.scala:72:59
      automatic logic       r_sectored_repl_addr_valids_lo_lo_hi;	// package.scala:72:59
      automatic logic       r_sectored_repl_addr_valids_lo_hi_lo;	// package.scala:72:59
      automatic logic       r_sectored_repl_addr_valids_lo_hi_hi;	// package.scala:72:59
      automatic logic       r_sectored_repl_addr_valids_hi_lo_lo;	// package.scala:72:59
      automatic logic       r_sectored_repl_addr_valids_hi_lo_hi;	// package.scala:72:59
      automatic logic       r_sectored_repl_addr_valids_hi_hi_lo;	// package.scala:72:59
      automatic logic [2:0] _r_sectored_hit_addr_T_1;	// OneHot.scala:32:28
      r_sectored_repl_addr_valids_lo_lo_lo =
        _r_sectored_repl_addr_valids_T_16 | sectored_entries_0_valid_2
        | sectored_entries_0_valid_3;	// package.scala:72:59, tlb.scala:122:29
      r_sectored_repl_addr_valids_lo_lo_hi =
        _r_sectored_repl_addr_valids_T_18 | sectored_entries_1_valid_2
        | sectored_entries_1_valid_3;	// package.scala:72:59, tlb.scala:122:29
      r_sectored_repl_addr_valids_lo_hi_lo =
        _r_sectored_repl_addr_valids_T_20 | sectored_entries_2_valid_2
        | sectored_entries_2_valid_3;	// package.scala:72:59, tlb.scala:122:29
      r_sectored_repl_addr_valids_lo_hi_hi =
        _r_sectored_repl_addr_valids_T_22 | sectored_entries_3_valid_2
        | sectored_entries_3_valid_3;	// package.scala:72:59, tlb.scala:122:29
      r_sectored_repl_addr_valids_hi_lo_lo =
        _r_sectored_repl_addr_valids_T_24 | sectored_entries_4_valid_2
        | sectored_entries_4_valid_3;	// package.scala:72:59, tlb.scala:122:29
      r_sectored_repl_addr_valids_hi_lo_hi =
        _r_sectored_repl_addr_valids_T_26 | sectored_entries_5_valid_2
        | sectored_entries_5_valid_3;	// package.scala:72:59, tlb.scala:122:29
      r_sectored_repl_addr_valids_hi_hi_lo =
        _r_sectored_repl_addr_valids_T_28 | sectored_entries_6_valid_2
        | sectored_entries_6_valid_3;	// package.scala:72:59, tlb.scala:122:29
      _r_sectored_hit_addr_T_1 = _GEN_122 | _GEN_123;	// OneHot.scala:30:18, :31:18, :32:28
      r_refill_tag <= io_req_0_bits_vaddr[38:12];	// tlb.scala:130:25, :142:47
      if (&{superpage_entries_3_valid_0,
            superpage_entries_2_valid_0,
            superpage_entries_1_valid_0,
            superpage_entries_0_valid_0})	// Cat.scala:30:58, tlb.scala:123:30, :353:16
        r_superpage_repl_addr <=
          {state_reg_1[2], state_reg_1[2] ? state_reg_1[1] : state_reg_1[0]};	// Cat.scala:30:58, Replacement.scala:168:70, :243:38, :245:38, :250:16, package.scala:154:13, tlb.scala:131:34
      else begin	// tlb.scala:353:16
        automatic logic [2:0] _r_superpage_repl_addr_T_4;	// tlb.scala:353:43
        _r_superpage_repl_addr_T_4 = ~_GEN_127;	// Cat.scala:30:58, tlb.scala:353:43
        if (_r_superpage_repl_addr_T_4[0])	// OneHot.scala:47:40, tlb.scala:353:43
          r_superpage_repl_addr <= 2'h0;	// tlb.scala:129:22, :131:34
        else if (_r_superpage_repl_addr_T_4[1])	// OneHot.scala:47:40, tlb.scala:353:43
          r_superpage_repl_addr <= 2'h1;	// package.scala:15:47, tlb.scala:131:34
        else	// OneHot.scala:47:40
          r_superpage_repl_addr <= {1'h1, ~(_r_superpage_repl_addr_T_4[2])};	// Mux.scala:47:69, OneHot.scala:47:40, tlb.scala:131:34, :139:112, :353:43
      end
      if (&{_r_sectored_repl_addr_valids_T_30 | sectored_entries_7_valid_2
              | sectored_entries_7_valid_3,
            r_sectored_repl_addr_valids_hi_hi_lo,
            r_sectored_repl_addr_valids_hi_lo_hi,
            r_sectored_repl_addr_valids_hi_lo_lo,
            r_sectored_repl_addr_valids_lo_hi_hi,
            r_sectored_repl_addr_valids_lo_hi_lo,
            r_sectored_repl_addr_valids_lo_lo_hi,
            r_sectored_repl_addr_valids_lo_lo_lo})	// Cat.scala:30:58, package.scala:72:59, tlb.scala:122:29, :353:16
        r_sectored_repl_addr <=
          {state_reg[6],
           state_reg[6]
             ? {state_reg[5], state_reg[5] ? state_reg[4] : state_reg[3]}
             : {state_reg[2], state_reg[2] ? state_reg[1] : state_reg[0]}};	// Cat.scala:30:58, Replacement.scala:168:70, :243:38, :245:38, :250:16, package.scala:154:13, tlb.scala:132:33
      else begin	// tlb.scala:353:16
        automatic logic [6:0] _r_sectored_repl_addr_T_8;	// tlb.scala:353:43
        _r_sectored_repl_addr_T_8 =
          ~{r_sectored_repl_addr_valids_hi_hi_lo,
            r_sectored_repl_addr_valids_hi_lo_hi,
            r_sectored_repl_addr_valids_hi_lo_lo,
            r_sectored_repl_addr_valids_lo_hi_hi,
            r_sectored_repl_addr_valids_lo_hi_lo,
            r_sectored_repl_addr_valids_lo_lo_hi,
            r_sectored_repl_addr_valids_lo_lo_lo};	// Cat.scala:30:58, package.scala:72:59, tlb.scala:353:43
        if (_r_sectored_repl_addr_T_8[0])	// OneHot.scala:47:40, tlb.scala:353:43
          r_sectored_repl_addr <= 3'h0;	// Replacement.scala:168:70, tlb.scala:132:33
        else if (_r_sectored_repl_addr_T_8[1])	// OneHot.scala:47:40, tlb.scala:353:43
          r_sectored_repl_addr <= 3'h1;	// Mux.scala:47:69, tlb.scala:132:33
        else if (_r_sectored_repl_addr_T_8[2])	// OneHot.scala:47:40, tlb.scala:353:43
          r_sectored_repl_addr <= 3'h2;	// Mux.scala:47:69, tlb.scala:132:33
        else if (_r_sectored_repl_addr_T_8[3])	// OneHot.scala:47:40, tlb.scala:353:43
          r_sectored_repl_addr <= 3'h3;	// Mux.scala:47:69, tlb.scala:132:33
        else if (_r_sectored_repl_addr_T_8[4])	// OneHot.scala:47:40, tlb.scala:353:43
          r_sectored_repl_addr <= 3'h4;	// tlb.scala:132:33, :204:65
        else if (_r_sectored_repl_addr_T_8[5])	// OneHot.scala:47:40, tlb.scala:353:43
          r_sectored_repl_addr <= 3'h5;	// tlb.scala:132:33, :204:65
        else	// OneHot.scala:47:40
          r_sectored_repl_addr <= {2'h3, ~(_r_sectored_repl_addr_T_8[6])};	// Mux.scala:47:69, OneHot.scala:47:40, package.scala:15:47, tlb.scala:132:33, :353:43
      end
      r_sectored_hit_addr <=
        {|{sector_hits_0_7, sector_hits_0_6, sector_hits_0_5, sector_hits_0_4},
         |(_r_sectored_hit_addr_T_1[2:1]),
         _r_sectored_hit_addr_T_1[2] | _r_sectored_hit_addr_T_1[0]};	// Cat.scala:30:58, OneHot.scala:30:18, :31:18, :32:{14,28}, tlb.scala:59:42, :133:32
      r_sectored_hit <=
        sector_hits_0_0 | sector_hits_0_1 | sector_hits_0_2 | sector_hits_0_3
        | sector_hits_0_4 | sector_hits_0_5 | sector_hits_0_6 | sector_hits_0_7;	// package.scala:72:59, tlb.scala:59:42, :134:27
    end
    if (reset) begin
      state <= 2'h0;	// tlb.scala:129:22
      state_reg <= 7'h0;	// Replacement.scala:168:70
      state_reg_1 <= 3'h0;	// Replacement.scala:168:70
    end
    else begin
      automatic logic superpage_hits_1_1;	// tlb.scala:67:31
      automatic logic superpage_hits_1_2;	// tlb.scala:67:31
      automatic logic superpage_hits_1_3;	// tlb.scala:67:31
      automatic logic _GEN_264;	// tlb.scala:275:27
      automatic logic _GEN_265 = io_req_1_valid & vm_enabled_1;	// tlb.scala:139:109, :275:27
      superpage_hits_1_1 =
        superpage_entries_1_valid_0
        & superpage_entries_1_tag[26:18] == io_req_1_bits_vaddr[38:30]
        & (ignore_4 | superpage_entries_1_tag[17:9] == io_req_1_bits_vaddr[29:21]);	// tlb.scala:66:30, :67:{31,42,48,79,86}, :123:30
      superpage_hits_1_2 =
        superpage_entries_2_valid_0
        & superpage_entries_2_tag[26:18] == io_req_1_bits_vaddr[38:30]
        & (ignore_7 | superpage_entries_2_tag[17:9] == io_req_1_bits_vaddr[29:21]);	// tlb.scala:66:30, :67:{31,42,48,79,86}, :123:30
      superpage_hits_1_3 =
        superpage_entries_3_valid_0
        & superpage_entries_3_tag[26:18] == io_req_1_bits_vaddr[38:30]
        & (ignore_10 | superpage_entries_3_tag[17:9] == io_req_1_bits_vaddr[29:21]);	// tlb.scala:66:30, :67:{31,42,48,79,86}, :123:30
      _GEN_264 = io_req_0_valid & vm_enabled_0;	// tlb.scala:139:93, :275:27
      if (io_ptw_resp_valid)
        state <= 2'h0;	// tlb.scala:129:22
      else if (state == 2'h2 & io_sfence_valid)	// tlb.scala:80:31, :129:22, :329:{17,28}
        state <= 2'h3;	// package.scala:15:47, tlb.scala:129:22
      else begin	// tlb.scala:329:28
        automatic logic _GEN_266;	// tlb.scala:129:22, :314:67, :315:15
        _GEN_266 = _GEN_128 | _GEN_126;	// tlb.scala:129:22, :314:{45,67}, :315:15
        if (_io_ptw_req_valid_T) begin	// package.scala:15:47
          if (io_kill)
            state <= 2'h0;	// tlb.scala:129:22
          else if (io_ptw_req_ready)
            state <= {1'h1, io_sfence_valid};	// tlb.scala:129:22, :139:112, :326:45
          else if (io_sfence_valid)
            state <= 2'h0;	// tlb.scala:129:22
          else if (_GEN_266)	// tlb.scala:129:22, :314:67, :315:15
            state <= 2'h1;	// package.scala:15:47, tlb.scala:129:22
        end
        else if (_GEN_266)	// tlb.scala:129:22, :314:67, :315:15
          state <= 2'h1;	// package.scala:15:47, tlb.scala:129:22
      end
      if (_GEN_265
          & (sector_hits_1_0 | sector_hits_1_1 | sector_hits_1_2 | sector_hits_1_3
             | sector_hits_1_4 | sector_hits_1_5 | sector_hits_1_6
             | sector_hits_1_7)) begin	// Replacement.scala:172:15, package.scala:72:59, tlb.scala:59:42, :275:{27,45}, :276:33
        automatic logic [3:0] hi_9;	// OneHot.scala:30:18
        automatic logic [2:0] _GEN_267;	// OneHot.scala:32:28
        automatic logic       lo_11;	// OneHot.scala:32:28
        hi_9 = {sector_hits_1_7, sector_hits_1_6, sector_hits_1_5, sector_hits_1_4};	// OneHot.scala:30:18, tlb.scala:59:42
        _GEN_267 = _GEN_124 | _GEN_125;	// OneHot.scala:30:18, :31:18, :32:28
        lo_11 = _GEN_267[2] | _GEN_267[0];	// OneHot.scala:30:18, :31:18, :32:28
        state_reg <=
          {~(|hi_9),
           (|hi_9)
             ? {~(|(_GEN_267[2:1])),
                (|(_GEN_267[2:1])) ? ~lo_11 : state_reg[4],
                (|(_GEN_267[2:1])) ? state_reg[3] : ~lo_11}
             : state_reg[5:3],
           (|hi_9)
             ? state_reg[2:0]
             : {~(|(_GEN_267[2:1])),
                (|(_GEN_267[2:1])) ? ~lo_11 : state_reg[1],
                (|(_GEN_267[2:1])) ? state_reg[0] : ~lo_11}};	// Cat.scala:30:58, OneHot.scala:30:18, :32:{14,28}, Replacement.scala:168:70, :196:33, :198:38, :203:16, :206:16, :218:7, package.scala:154:13
      end
      else if (_GEN_264
               & (sector_hits_0_0 | sector_hits_0_1 | sector_hits_0_2 | sector_hits_0_3
                  | sector_hits_0_4 | sector_hits_0_5 | sector_hits_0_6
                  | sector_hits_0_7)) begin	// Replacement.scala:168:70, :172:15, package.scala:72:59, tlb.scala:59:42, :275:{27,45}, :276:33
        automatic logic [3:0] hi_1;	// OneHot.scala:30:18
        automatic logic [2:0] _GEN_268;	// OneHot.scala:32:28
        automatic logic       lo_3;	// OneHot.scala:32:28
        hi_1 = {sector_hits_0_7, sector_hits_0_6, sector_hits_0_5, sector_hits_0_4};	// OneHot.scala:30:18, tlb.scala:59:42
        _GEN_268 = _GEN_122 | _GEN_123;	// OneHot.scala:30:18, :31:18, :32:28
        lo_3 = _GEN_268[2] | _GEN_268[0];	// OneHot.scala:30:18, :31:18, :32:28
        state_reg <=
          {~(|hi_1),
           (|hi_1)
             ? {~(|(_GEN_268[2:1])),
                (|(_GEN_268[2:1])) ? ~lo_3 : state_reg[4],
                (|(_GEN_268[2:1])) ? state_reg[3] : ~lo_3}
             : state_reg[5:3],
           (|hi_1)
             ? state_reg[2:0]
             : {~(|(_GEN_268[2:1])),
                (|(_GEN_268[2:1])) ? ~lo_3 : state_reg[1],
                (|(_GEN_268[2:1])) ? state_reg[0] : ~lo_3}};	// Cat.scala:30:58, OneHot.scala:30:18, :32:{14,28}, Replacement.scala:168:70, :196:33, :198:38, :203:16, :206:16, :218:7, package.scala:154:13
      end
      if (_GEN_265
          & (superpage_entries_0_valid_0
             & superpage_entries_0_tag[26:18] == io_req_1_bits_vaddr[38:30]
             & (ignore_1 | superpage_entries_0_tag[17:9] == io_req_1_bits_vaddr[29:21])
             | superpage_hits_1_1 | superpage_hits_1_2 | superpage_hits_1_3)) begin	// Replacement.scala:172:15, package.scala:72:59, tlb.scala:66:30, :67:{31,42,48,79,86}, :123:30, :275:{27,45}, :277:36
        automatic logic [1:0] hi_14;	// OneHot.scala:30:18
        automatic logic       lo_15;	// OneHot.scala:32:28
        hi_14 = {superpage_hits_1_3, superpage_hits_1_2};	// OneHot.scala:30:18, tlb.scala:67:31
        lo_15 = superpage_hits_1_3 | superpage_hits_1_1;	// OneHot.scala:32:28, tlb.scala:67:31
        state_reg_1 <=
          {~(|hi_14),
           (|hi_14) ? ~lo_15 : state_reg_1[1],
           (|hi_14) ? state_reg_1[0] : ~lo_15};	// Cat.scala:30:58, OneHot.scala:30:18, :32:{14,28}, Replacement.scala:168:70, :196:33, :198:38, :203:16, :206:16, :218:7, package.scala:154:13
      end
      else begin	// Replacement.scala:172:15, tlb.scala:275:45, :277:36
        automatic logic superpage_hits_0_1;	// tlb.scala:67:31
        automatic logic superpage_hits_0_2;	// tlb.scala:67:31
        automatic logic superpage_hits_0_3;	// tlb.scala:67:31
        superpage_hits_0_1 =
          superpage_entries_1_valid_0
          & superpage_entries_1_tag[26:18] == io_req_0_bits_vaddr[38:30]
          & (ignore_4 | superpage_entries_1_tag[17:9] == io_req_0_bits_vaddr[29:21]);	// tlb.scala:66:30, :67:{31,42,48,79,86}, :123:30
        superpage_hits_0_2 =
          superpage_entries_2_valid_0
          & superpage_entries_2_tag[26:18] == io_req_0_bits_vaddr[38:30]
          & (ignore_7 | superpage_entries_2_tag[17:9] == io_req_0_bits_vaddr[29:21]);	// tlb.scala:66:30, :67:{31,42,48,79,86}, :123:30
        superpage_hits_0_3 =
          superpage_entries_3_valid_0
          & superpage_entries_3_tag[26:18] == io_req_0_bits_vaddr[38:30]
          & (ignore_10 | superpage_entries_3_tag[17:9] == io_req_0_bits_vaddr[29:21]);	// tlb.scala:66:30, :67:{31,42,48,79,86}, :123:30
        if (_GEN_264
            & (superpage_entries_0_valid_0
               & superpage_entries_0_tag[26:18] == io_req_0_bits_vaddr[38:30]
               & (ignore_1 | superpage_entries_0_tag[17:9] == io_req_0_bits_vaddr[29:21])
               | superpage_hits_0_1 | superpage_hits_0_2 | superpage_hits_0_3)) begin	// Replacement.scala:168:70, :172:15, package.scala:72:59, tlb.scala:66:30, :67:{31,42,48,79,86}, :123:30, :275:{27,45}, :277:36
          automatic logic [1:0] hi_6;	// OneHot.scala:30:18
          automatic logic       lo_7;	// OneHot.scala:32:28
          hi_6 = {superpage_hits_0_3, superpage_hits_0_2};	// OneHot.scala:30:18, tlb.scala:67:31
          lo_7 = superpage_hits_0_3 | superpage_hits_0_1;	// OneHot.scala:32:28, tlb.scala:67:31
          state_reg_1 <=
            {~(|hi_6),
             (|hi_6) ? ~lo_7 : state_reg_1[1],
             (|hi_6) ? state_reg_1[0] : ~lo_7};	// Cat.scala:30:58, OneHot.scala:30:18, :32:{14,28}, Replacement.scala:168:70, :196:33, :198:38, :203:16, :206:16, :218:7, package.scala:154:13
        end
      end
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:53];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [5:0] i = 6'h0; i < 6'h36; i += 6'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        sectored_entries_0_tag = _RANDOM[6'h0][28:2];	// tlb.scala:122:29
        sectored_entries_0_data_0 = {_RANDOM[6'h0][31:29], _RANDOM[6'h1][30:0]};	// tlb.scala:122:29
        sectored_entries_0_data_1 = {_RANDOM[6'h1][31], _RANDOM[6'h2], _RANDOM[6'h3][0]};	// tlb.scala:122:29
        sectored_entries_0_data_2 = {_RANDOM[6'h3][31:1], _RANDOM[6'h4][2:0]};	// tlb.scala:122:29
        sectored_entries_0_data_3 = {_RANDOM[6'h4][31:3], _RANDOM[6'h5][4:0]};	// tlb.scala:122:29
        sectored_entries_0_valid_0 = _RANDOM[6'h5][5];	// tlb.scala:122:29
        sectored_entries_0_valid_1 = _RANDOM[6'h5][6];	// tlb.scala:122:29
        sectored_entries_0_valid_2 = _RANDOM[6'h5][7];	// tlb.scala:122:29
        sectored_entries_0_valid_3 = _RANDOM[6'h5][8];	// tlb.scala:122:29
        sectored_entries_1_tag = {_RANDOM[6'h5][31:11], _RANDOM[6'h6][5:0]};	// tlb.scala:122:29
        sectored_entries_1_data_0 = {_RANDOM[6'h6][31:6], _RANDOM[6'h7][7:0]};	// tlb.scala:122:29
        sectored_entries_1_data_1 = {_RANDOM[6'h7][31:8], _RANDOM[6'h8][9:0]};	// tlb.scala:122:29
        sectored_entries_1_data_2 = {_RANDOM[6'h8][31:10], _RANDOM[6'h9][11:0]};	// tlb.scala:122:29
        sectored_entries_1_data_3 = {_RANDOM[6'h9][31:12], _RANDOM[6'hA][13:0]};	// tlb.scala:122:29
        sectored_entries_1_valid_0 = _RANDOM[6'hA][14];	// tlb.scala:122:29
        sectored_entries_1_valid_1 = _RANDOM[6'hA][15];	// tlb.scala:122:29
        sectored_entries_1_valid_2 = _RANDOM[6'hA][16];	// tlb.scala:122:29
        sectored_entries_1_valid_3 = _RANDOM[6'hA][17];	// tlb.scala:122:29
        sectored_entries_2_tag = {_RANDOM[6'hA][31:20], _RANDOM[6'hB][14:0]};	// tlb.scala:122:29
        sectored_entries_2_data_0 = {_RANDOM[6'hB][31:15], _RANDOM[6'hC][16:0]};	// tlb.scala:122:29
        sectored_entries_2_data_1 = {_RANDOM[6'hC][31:17], _RANDOM[6'hD][18:0]};	// tlb.scala:122:29
        sectored_entries_2_data_2 = {_RANDOM[6'hD][31:19], _RANDOM[6'hE][20:0]};	// tlb.scala:122:29
        sectored_entries_2_data_3 = {_RANDOM[6'hE][31:21], _RANDOM[6'hF][22:0]};	// tlb.scala:122:29
        sectored_entries_2_valid_0 = _RANDOM[6'hF][23];	// tlb.scala:122:29
        sectored_entries_2_valid_1 = _RANDOM[6'hF][24];	// tlb.scala:122:29
        sectored_entries_2_valid_2 = _RANDOM[6'hF][25];	// tlb.scala:122:29
        sectored_entries_2_valid_3 = _RANDOM[6'hF][26];	// tlb.scala:122:29
        sectored_entries_3_tag = {_RANDOM[6'hF][31:29], _RANDOM[6'h10][23:0]};	// tlb.scala:122:29
        sectored_entries_3_data_0 = {_RANDOM[6'h10][31:24], _RANDOM[6'h11][25:0]};	// tlb.scala:122:29
        sectored_entries_3_data_1 = {_RANDOM[6'h11][31:26], _RANDOM[6'h12][27:0]};	// tlb.scala:122:29
        sectored_entries_3_data_2 = {_RANDOM[6'h12][31:28], _RANDOM[6'h13][29:0]};	// tlb.scala:122:29
        sectored_entries_3_data_3 = {_RANDOM[6'h13][31:30], _RANDOM[6'h14]};	// tlb.scala:122:29
        sectored_entries_3_valid_0 = _RANDOM[6'h15][0];	// tlb.scala:122:29
        sectored_entries_3_valid_1 = _RANDOM[6'h15][1];	// tlb.scala:122:29
        sectored_entries_3_valid_2 = _RANDOM[6'h15][2];	// tlb.scala:122:29
        sectored_entries_3_valid_3 = _RANDOM[6'h15][3];	// tlb.scala:122:29
        sectored_entries_4_tag = {_RANDOM[6'h15][31:6], _RANDOM[6'h16][0]};	// tlb.scala:122:29
        sectored_entries_4_data_0 = {_RANDOM[6'h16][31:1], _RANDOM[6'h17][2:0]};	// tlb.scala:122:29
        sectored_entries_4_data_1 = {_RANDOM[6'h17][31:3], _RANDOM[6'h18][4:0]};	// tlb.scala:122:29
        sectored_entries_4_data_2 = {_RANDOM[6'h18][31:5], _RANDOM[6'h19][6:0]};	// tlb.scala:122:29
        sectored_entries_4_data_3 = {_RANDOM[6'h19][31:7], _RANDOM[6'h1A][8:0]};	// tlb.scala:122:29
        sectored_entries_4_valid_0 = _RANDOM[6'h1A][9];	// tlb.scala:122:29
        sectored_entries_4_valid_1 = _RANDOM[6'h1A][10];	// tlb.scala:122:29
        sectored_entries_4_valid_2 = _RANDOM[6'h1A][11];	// tlb.scala:122:29
        sectored_entries_4_valid_3 = _RANDOM[6'h1A][12];	// tlb.scala:122:29
        sectored_entries_5_tag = {_RANDOM[6'h1A][31:15], _RANDOM[6'h1B][9:0]};	// tlb.scala:122:29
        sectored_entries_5_data_0 = {_RANDOM[6'h1B][31:10], _RANDOM[6'h1C][11:0]};	// tlb.scala:122:29
        sectored_entries_5_data_1 = {_RANDOM[6'h1C][31:12], _RANDOM[6'h1D][13:0]};	// tlb.scala:122:29
        sectored_entries_5_data_2 = {_RANDOM[6'h1D][31:14], _RANDOM[6'h1E][15:0]};	// tlb.scala:122:29
        sectored_entries_5_data_3 = {_RANDOM[6'h1E][31:16], _RANDOM[6'h1F][17:0]};	// tlb.scala:122:29
        sectored_entries_5_valid_0 = _RANDOM[6'h1F][18];	// tlb.scala:122:29
        sectored_entries_5_valid_1 = _RANDOM[6'h1F][19];	// tlb.scala:122:29
        sectored_entries_5_valid_2 = _RANDOM[6'h1F][20];	// tlb.scala:122:29
        sectored_entries_5_valid_3 = _RANDOM[6'h1F][21];	// tlb.scala:122:29
        sectored_entries_6_tag = {_RANDOM[6'h1F][31:24], _RANDOM[6'h20][18:0]};	// tlb.scala:122:29
        sectored_entries_6_data_0 = {_RANDOM[6'h20][31:19], _RANDOM[6'h21][20:0]};	// tlb.scala:122:29
        sectored_entries_6_data_1 = {_RANDOM[6'h21][31:21], _RANDOM[6'h22][22:0]};	// tlb.scala:122:29
        sectored_entries_6_data_2 = {_RANDOM[6'h22][31:23], _RANDOM[6'h23][24:0]};	// tlb.scala:122:29
        sectored_entries_6_data_3 = {_RANDOM[6'h23][31:25], _RANDOM[6'h24][26:0]};	// tlb.scala:122:29
        sectored_entries_6_valid_0 = _RANDOM[6'h24][27];	// tlb.scala:122:29
        sectored_entries_6_valid_1 = _RANDOM[6'h24][28];	// tlb.scala:122:29
        sectored_entries_6_valid_2 = _RANDOM[6'h24][29];	// tlb.scala:122:29
        sectored_entries_6_valid_3 = _RANDOM[6'h24][30];	// tlb.scala:122:29
        sectored_entries_7_tag = _RANDOM[6'h25][27:1];	// tlb.scala:122:29
        sectored_entries_7_data_0 = {_RANDOM[6'h25][31:28], _RANDOM[6'h26][29:0]};	// tlb.scala:122:29
        sectored_entries_7_data_1 = {_RANDOM[6'h26][31:30], _RANDOM[6'h27]};	// tlb.scala:122:29
        sectored_entries_7_data_2 = {_RANDOM[6'h28], _RANDOM[6'h29][1:0]};	// tlb.scala:122:29
        sectored_entries_7_data_3 = {_RANDOM[6'h29][31:2], _RANDOM[6'h2A][3:0]};	// tlb.scala:122:29
        sectored_entries_7_valid_0 = _RANDOM[6'h2A][4];	// tlb.scala:122:29
        sectored_entries_7_valid_1 = _RANDOM[6'h2A][5];	// tlb.scala:122:29
        sectored_entries_7_valid_2 = _RANDOM[6'h2A][6];	// tlb.scala:122:29
        sectored_entries_7_valid_3 = _RANDOM[6'h2A][7];	// tlb.scala:122:29
        superpage_entries_0_level = _RANDOM[6'h2A][9:8];	// tlb.scala:122:29, :123:30
        superpage_entries_0_tag = {_RANDOM[6'h2A][31:10], _RANDOM[6'h2B][4:0]};	// tlb.scala:122:29, :123:30
        superpage_entries_0_data_0 = {_RANDOM[6'h2B][31:5], _RANDOM[6'h2C][6:0]};	// tlb.scala:123:30
        superpage_entries_0_valid_0 = _RANDOM[6'h2C][7];	// tlb.scala:123:30
        superpage_entries_1_level = _RANDOM[6'h2C][9:8];	// tlb.scala:123:30
        superpage_entries_1_tag = {_RANDOM[6'h2C][31:10], _RANDOM[6'h2D][4:0]};	// tlb.scala:123:30
        superpage_entries_1_data_0 = {_RANDOM[6'h2D][31:5], _RANDOM[6'h2E][6:0]};	// tlb.scala:123:30
        superpage_entries_1_valid_0 = _RANDOM[6'h2E][7];	// tlb.scala:123:30
        superpage_entries_2_level = _RANDOM[6'h2E][9:8];	// tlb.scala:123:30
        superpage_entries_2_tag = {_RANDOM[6'h2E][31:10], _RANDOM[6'h2F][4:0]};	// tlb.scala:123:30
        superpage_entries_2_data_0 = {_RANDOM[6'h2F][31:5], _RANDOM[6'h30][6:0]};	// tlb.scala:123:30
        superpage_entries_2_valid_0 = _RANDOM[6'h30][7];	// tlb.scala:123:30
        superpage_entries_3_level = _RANDOM[6'h30][9:8];	// tlb.scala:123:30
        superpage_entries_3_tag = {_RANDOM[6'h30][31:10], _RANDOM[6'h31][4:0]};	// tlb.scala:123:30
        superpage_entries_3_data_0 = {_RANDOM[6'h31][31:5], _RANDOM[6'h32][6:0]};	// tlb.scala:123:30
        superpage_entries_3_valid_0 = _RANDOM[6'h32][7];	// tlb.scala:123:30
        special_entry_level = _RANDOM[6'h32][9:8];	// tlb.scala:123:30, :124:56
        special_entry_tag = {_RANDOM[6'h32][31:10], _RANDOM[6'h33][4:0]};	// tlb.scala:123:30, :124:56
        special_entry_data_0 = {_RANDOM[6'h33][31:5], _RANDOM[6'h34][6:0]};	// tlb.scala:124:56
        special_entry_valid_0 = _RANDOM[6'h34][7];	// tlb.scala:124:56
        state = _RANDOM[6'h34][9:8];	// tlb.scala:124:56, :129:22
        r_refill_tag = {_RANDOM[6'h34][31:10], _RANDOM[6'h35][4:0]};	// tlb.scala:124:56, :130:25
        r_superpage_repl_addr = _RANDOM[6'h35][6:5];	// tlb.scala:130:25, :131:34
        r_sectored_repl_addr = _RANDOM[6'h35][9:7];	// tlb.scala:130:25, :132:33
        r_sectored_hit_addr = _RANDOM[6'h35][12:10];	// tlb.scala:130:25, :133:32
        r_sectored_hit = _RANDOM[6'h35][13];	// tlb.scala:130:25, :134:27
        state_reg = _RANDOM[6'h35][20:14];	// Replacement.scala:168:70, tlb.scala:130:25
        state_reg_1 = _RANDOM[6'h35][23:21];	// Replacement.scala:168:70, tlb.scala:130:25
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  PMPChecker_10 pmp_0 (	// tlb.scala:150:40
    .io_prv         (io_ptw_resp_valid ? 2'h1 : io_ptw_status_dprv),	// package.scala:15:47, tlb.scala:155:25
    .io_pmp_0_cfg_l (io_ptw_pmp_0_cfg_l),
    .io_pmp_0_cfg_a (io_ptw_pmp_0_cfg_a),
    .io_pmp_0_cfg_x (io_ptw_pmp_0_cfg_x),
    .io_pmp_0_cfg_w (io_ptw_pmp_0_cfg_w),
    .io_pmp_0_cfg_r (io_ptw_pmp_0_cfg_r),
    .io_pmp_0_addr  (io_ptw_pmp_0_addr),
    .io_pmp_0_mask  (io_ptw_pmp_0_mask),
    .io_pmp_1_cfg_l (io_ptw_pmp_1_cfg_l),
    .io_pmp_1_cfg_a (io_ptw_pmp_1_cfg_a),
    .io_pmp_1_cfg_x (io_ptw_pmp_1_cfg_x),
    .io_pmp_1_cfg_w (io_ptw_pmp_1_cfg_w),
    .io_pmp_1_cfg_r (io_ptw_pmp_1_cfg_r),
    .io_pmp_1_addr  (io_ptw_pmp_1_addr),
    .io_pmp_1_mask  (io_ptw_pmp_1_mask),
    .io_pmp_2_cfg_l (io_ptw_pmp_2_cfg_l),
    .io_pmp_2_cfg_a (io_ptw_pmp_2_cfg_a),
    .io_pmp_2_cfg_x (io_ptw_pmp_2_cfg_x),
    .io_pmp_2_cfg_w (io_ptw_pmp_2_cfg_w),
    .io_pmp_2_cfg_r (io_ptw_pmp_2_cfg_r),
    .io_pmp_2_addr  (io_ptw_pmp_2_addr),
    .io_pmp_2_mask  (io_ptw_pmp_2_mask),
    .io_pmp_3_cfg_l (io_ptw_pmp_3_cfg_l),
    .io_pmp_3_cfg_a (io_ptw_pmp_3_cfg_a),
    .io_pmp_3_cfg_x (io_ptw_pmp_3_cfg_x),
    .io_pmp_3_cfg_w (io_ptw_pmp_3_cfg_w),
    .io_pmp_3_cfg_r (io_ptw_pmp_3_cfg_r),
    .io_pmp_3_addr  (io_ptw_pmp_3_addr),
    .io_pmp_3_mask  (io_ptw_pmp_3_mask),
    .io_pmp_4_cfg_l (io_ptw_pmp_4_cfg_l),
    .io_pmp_4_cfg_a (io_ptw_pmp_4_cfg_a),
    .io_pmp_4_cfg_x (io_ptw_pmp_4_cfg_x),
    .io_pmp_4_cfg_w (io_ptw_pmp_4_cfg_w),
    .io_pmp_4_cfg_r (io_ptw_pmp_4_cfg_r),
    .io_pmp_4_addr  (io_ptw_pmp_4_addr),
    .io_pmp_4_mask  (io_ptw_pmp_4_mask),
    .io_pmp_5_cfg_l (io_ptw_pmp_5_cfg_l),
    .io_pmp_5_cfg_a (io_ptw_pmp_5_cfg_a),
    .io_pmp_5_cfg_x (io_ptw_pmp_5_cfg_x),
    .io_pmp_5_cfg_w (io_ptw_pmp_5_cfg_w),
    .io_pmp_5_cfg_r (io_ptw_pmp_5_cfg_r),
    .io_pmp_5_addr  (io_ptw_pmp_5_addr),
    .io_pmp_5_mask  (io_ptw_pmp_5_mask),
    .io_pmp_6_cfg_l (io_ptw_pmp_6_cfg_l),
    .io_pmp_6_cfg_a (io_ptw_pmp_6_cfg_a),
    .io_pmp_6_cfg_x (io_ptw_pmp_6_cfg_x),
    .io_pmp_6_cfg_w (io_ptw_pmp_6_cfg_w),
    .io_pmp_6_cfg_r (io_ptw_pmp_6_cfg_r),
    .io_pmp_6_addr  (io_ptw_pmp_6_addr),
    .io_pmp_6_mask  (io_ptw_pmp_6_mask),
    .io_pmp_7_cfg_l (io_ptw_pmp_7_cfg_l),
    .io_pmp_7_cfg_a (io_ptw_pmp_7_cfg_a),
    .io_pmp_7_cfg_x (io_ptw_pmp_7_cfg_x),
    .io_pmp_7_cfg_w (io_ptw_pmp_7_cfg_w),
    .io_pmp_7_cfg_r (io_ptw_pmp_7_cfg_r),
    .io_pmp_7_addr  (io_ptw_pmp_7_addr),
    .io_pmp_7_mask  (io_ptw_pmp_7_mask),
    .io_addr        ({mpu_ppn_0[19:0], io_req_0_bits_vaddr[11:0]}),	// tlb.scala:147:20, :149:72, :152:20
    .io_size        (io_req_0_bits_size),
    .io_r           (_pmp_0_io_r),
    .io_w           (_pmp_0_io_w),
    .io_x           (_pmp_0_io_x)
  );
  PMPChecker_10 pmp_1 (	// tlb.scala:150:40
    .io_prv
      (io_ptw_resp_valid | io_req_1_bits_passthrough ? 2'h1 : io_ptw_status_dprv),	// package.scala:15:47, tlb.scala:155:{25,50}
    .io_pmp_0_cfg_l (io_ptw_pmp_0_cfg_l),
    .io_pmp_0_cfg_a (io_ptw_pmp_0_cfg_a),
    .io_pmp_0_cfg_x (io_ptw_pmp_0_cfg_x),
    .io_pmp_0_cfg_w (io_ptw_pmp_0_cfg_w),
    .io_pmp_0_cfg_r (io_ptw_pmp_0_cfg_r),
    .io_pmp_0_addr  (io_ptw_pmp_0_addr),
    .io_pmp_0_mask  (io_ptw_pmp_0_mask),
    .io_pmp_1_cfg_l (io_ptw_pmp_1_cfg_l),
    .io_pmp_1_cfg_a (io_ptw_pmp_1_cfg_a),
    .io_pmp_1_cfg_x (io_ptw_pmp_1_cfg_x),
    .io_pmp_1_cfg_w (io_ptw_pmp_1_cfg_w),
    .io_pmp_1_cfg_r (io_ptw_pmp_1_cfg_r),
    .io_pmp_1_addr  (io_ptw_pmp_1_addr),
    .io_pmp_1_mask  (io_ptw_pmp_1_mask),
    .io_pmp_2_cfg_l (io_ptw_pmp_2_cfg_l),
    .io_pmp_2_cfg_a (io_ptw_pmp_2_cfg_a),
    .io_pmp_2_cfg_x (io_ptw_pmp_2_cfg_x),
    .io_pmp_2_cfg_w (io_ptw_pmp_2_cfg_w),
    .io_pmp_2_cfg_r (io_ptw_pmp_2_cfg_r),
    .io_pmp_2_addr  (io_ptw_pmp_2_addr),
    .io_pmp_2_mask  (io_ptw_pmp_2_mask),
    .io_pmp_3_cfg_l (io_ptw_pmp_3_cfg_l),
    .io_pmp_3_cfg_a (io_ptw_pmp_3_cfg_a),
    .io_pmp_3_cfg_x (io_ptw_pmp_3_cfg_x),
    .io_pmp_3_cfg_w (io_ptw_pmp_3_cfg_w),
    .io_pmp_3_cfg_r (io_ptw_pmp_3_cfg_r),
    .io_pmp_3_addr  (io_ptw_pmp_3_addr),
    .io_pmp_3_mask  (io_ptw_pmp_3_mask),
    .io_pmp_4_cfg_l (io_ptw_pmp_4_cfg_l),
    .io_pmp_4_cfg_a (io_ptw_pmp_4_cfg_a),
    .io_pmp_4_cfg_x (io_ptw_pmp_4_cfg_x),
    .io_pmp_4_cfg_w (io_ptw_pmp_4_cfg_w),
    .io_pmp_4_cfg_r (io_ptw_pmp_4_cfg_r),
    .io_pmp_4_addr  (io_ptw_pmp_4_addr),
    .io_pmp_4_mask  (io_ptw_pmp_4_mask),
    .io_pmp_5_cfg_l (io_ptw_pmp_5_cfg_l),
    .io_pmp_5_cfg_a (io_ptw_pmp_5_cfg_a),
    .io_pmp_5_cfg_x (io_ptw_pmp_5_cfg_x),
    .io_pmp_5_cfg_w (io_ptw_pmp_5_cfg_w),
    .io_pmp_5_cfg_r (io_ptw_pmp_5_cfg_r),
    .io_pmp_5_addr  (io_ptw_pmp_5_addr),
    .io_pmp_5_mask  (io_ptw_pmp_5_mask),
    .io_pmp_6_cfg_l (io_ptw_pmp_6_cfg_l),
    .io_pmp_6_cfg_a (io_ptw_pmp_6_cfg_a),
    .io_pmp_6_cfg_x (io_ptw_pmp_6_cfg_x),
    .io_pmp_6_cfg_w (io_ptw_pmp_6_cfg_w),
    .io_pmp_6_cfg_r (io_ptw_pmp_6_cfg_r),
    .io_pmp_6_addr  (io_ptw_pmp_6_addr),
    .io_pmp_6_mask  (io_ptw_pmp_6_mask),
    .io_pmp_7_cfg_l (io_ptw_pmp_7_cfg_l),
    .io_pmp_7_cfg_a (io_ptw_pmp_7_cfg_a),
    .io_pmp_7_cfg_x (io_ptw_pmp_7_cfg_x),
    .io_pmp_7_cfg_w (io_ptw_pmp_7_cfg_w),
    .io_pmp_7_cfg_r (io_ptw_pmp_7_cfg_r),
    .io_pmp_7_addr  (io_ptw_pmp_7_addr),
    .io_pmp_7_mask  (io_ptw_pmp_7_mask),
    .io_addr        ({mpu_ppn_1[19:0], io_req_1_bits_vaddr[11:0]}),	// tlb.scala:147:20, :149:72, :152:20
    .io_size        (io_req_1_bits_size),
    .io_r           (_pmp_1_io_r),
    .io_w           (_pmp_1_io_w),
    .io_x           (/* unused */)
  );
  assign io_miss_rdy = _io_miss_rdy_T;	// tlb.scala:288:24
  assign io_resp_0_miss = io_ptw_resp_valid | tlb_miss_0 | multipleHits_0;	// Misc.scala:182:49, tlb.scala:270:60, :303:50
  assign io_resp_0_paddr =
    {(hitsVec_0_0 ? _normal_entries_WIRE_1[33:14] : 20'h0)
       | (hitsVec_0_1 ? _normal_entries_WIRE_3[33:14] : 20'h0)
       | (hitsVec_0_2 ? _normal_entries_WIRE_5[33:14] : 20'h0)
       | (hitsVec_0_3 ? _normal_entries_WIRE_7[33:14] : 20'h0)
       | (hitsVec_0_4 ? _normal_entries_WIRE_9[33:14] : 20'h0)
       | (hitsVec_0_5 ? _normal_entries_WIRE_11[33:14] : 20'h0)
       | (hitsVec_0_6 ? _normal_entries_WIRE_13[33:14] : 20'h0)
       | (hitsVec_0_7 ? _normal_entries_WIRE_15[33:14] : 20'h0)
       | (hitsVec_0_8
            ? {superpage_entries_0_data_0[33:32],
               (ignore_1 ? io_req_0_bits_vaddr[29:21] : 9'h0)
                 | superpage_entries_0_data_0[31:23],
               io_req_0_bits_vaddr[20:12] | superpage_entries_0_data_0[22:14]}
            : 20'h0)
       | (hitsVec_0_9
            ? {superpage_entries_1_data_0[33:32],
               (ignore_4 ? io_req_0_bits_vaddr[29:21] : 9'h0)
                 | superpage_entries_1_data_0[31:23],
               io_req_0_bits_vaddr[20:12] | superpage_entries_1_data_0[22:14]}
            : 20'h0)
       | (hitsVec_0_10
            ? {superpage_entries_2_data_0[33:32],
               (ignore_7 ? io_req_0_bits_vaddr[29:21] : 9'h0)
                 | superpage_entries_2_data_0[31:23],
               io_req_0_bits_vaddr[20:12] | superpage_entries_2_data_0[22:14]}
            : 20'h0)
       | (hitsVec_0_11
            ? {superpage_entries_3_data_0[33:32],
               (ignore_10 ? io_req_0_bits_vaddr[29:21] : 9'h0)
                 | superpage_entries_3_data_0[31:23],
               io_req_0_bits_vaddr[20:12] | superpage_entries_3_data_0[22:14]}
            : 20'h0)
       | (hitsVec_0_12
            ? {special_entry_data_0[33:32],
               (ignore_13 ? io_req_0_bits_vaddr[29:21] : 9'h0)
                 | special_entry_data_0[31:23],
               (special_entry_level[1] ? 9'h0 : io_req_0_bits_vaddr[20:12])
                 | special_entry_data_0[22:14]}
            : 20'h0) | (vm_enabled_0 ? 20'h0 : io_req_0_bits_vaddr[31:12]),
     io_req_0_bits_vaddr[11:0]};	// Cat.scala:30:58, Mux.scala:27:72, tlb.scala:58:79, :66:30, :78:28, :80:31, :81:{30,49}, :107:64, :123:30, :124:56, :139:93, :142:47, :149:72, :171:69, :174:103
  assign io_resp_0_pf_ld =
    bad_va_0 & cmd_read_0
    | (|((cmd_read_0
            ? {~(r_array_lo_2[12] | special_entry_data_0[11]),
               ~(r_array_lo_2[11] | superpage_entries_3_data_0[11]),
               ~(r_array_lo_2[10] | superpage_entries_2_data_0[11]),
               ~(r_array_lo_2[9] | superpage_entries_1_data_0[11]),
               ~(r_array_lo_2[8] | superpage_entries_0_data_0[11]),
               ~(r_array_lo_2[7] | _normal_entries_WIRE_15[11]),
               ~(r_array_lo_2[6] | _normal_entries_WIRE_13[11]),
               ~(r_array_lo_2[5] | _normal_entries_WIRE_11[11]),
               ~(r_array_lo_2[4] | _normal_entries_WIRE_9[11]),
               ~(r_array_lo_2[3] | _normal_entries_WIRE_7[11]),
               ~(r_array_lo_2[2] | _normal_entries_WIRE_5[11]),
               ~(r_array_lo_2[1] | _normal_entries_WIRE_3[11]),
               ~(r_array_lo_2[0] | _normal_entries_WIRE_1[11])}
            : 13'h0) & _GEN_38));	// Cat.scala:30:58, Consts.scala:81:75, tlb.scala:58:79, :123:30, :124:56, :215:39, :217:62, :232:134, :265:{38,59,72}, :291:{38,54,73,84}
  assign io_resp_0_pf_st =
    bad_va_0 & cmd_write_perms_0
    | (|((cmd_write_perms_0
            ? {~(w_array_lo_1[12] | special_entry_data_0[11]),
               ~(w_array_lo_1[11] | superpage_entries_3_data_0[11]),
               ~(w_array_lo_1[10] | superpage_entries_2_data_0[11]),
               ~(w_array_lo_1[9] | superpage_entries_1_data_0[11]),
               ~(w_array_lo_1[8] | superpage_entries_0_data_0[11]),
               ~(w_array_lo_1[7] | _normal_entries_WIRE_15[11]),
               ~(w_array_lo_1[6] | _normal_entries_WIRE_13[11]),
               ~(w_array_lo_1[5] | _normal_entries_WIRE_11[11]),
               ~(w_array_lo_1[4] | _normal_entries_WIRE_9[11]),
               ~(w_array_lo_1[3] | _normal_entries_WIRE_7[11]),
               ~(w_array_lo_1[2] | _normal_entries_WIRE_5[11]),
               ~(w_array_lo_1[1] | _normal_entries_WIRE_3[11]),
               ~(w_array_lo_1[0] | _normal_entries_WIRE_1[11])}
            : 13'h0) & _GEN_38));	// Cat.scala:30:58, Consts.scala:82:76, tlb.scala:58:79, :123:30, :124:56, :215:39, :218:62, :232:134, :266:{38,59,72}, :292:{38,61,80,91}
  assign io_resp_0_ae_ld =
    |((cmd_read_0
         ? ae_array_0
           | ~({{2{newEntry_pr}},
                superpage_entries_3_data_0[5],
                superpage_entries_2_data_0[5],
                superpage_entries_1_data_0[5],
                superpage_entries_0_data_0[5],
                _normal_entries_WIRE_15[5],
                _normal_entries_WIRE_13[5],
                _normal_entries_WIRE_11[5],
                _normal_entries_WIRE_9[5],
                _normal_entries_WIRE_7[5],
                _normal_entries_WIRE_5[5],
                _normal_entries_WIRE_3[5],
                _normal_entries_WIRE_1[5]} & _px_array_T_2)
         : 14'h0) & hits_0);	// Bitwise.scala:72:12, Cat.scala:30:58, Consts.scala:81:75, tlb.scala:58:79, :123:30, :162:60, :220:114, :252:43, :254:{38,64,66}, :262:32, :294:{43,54}
  assign io_resp_0_ae_st =
    |(((cmd_write_perms_0
          ? ae_array_0
            | ~({{2{newEntry_pw}},
                 superpage_entries_3_data_0[7],
                 superpage_entries_2_data_0[7],
                 superpage_entries_1_data_0[7],
                 superpage_entries_0_data_0[7],
                 _normal_entries_WIRE_15[7],
                 _normal_entries_WIRE_13[7],
                 _normal_entries_WIRE_11[7],
                 _normal_entries_WIRE_9[7],
                 _normal_entries_WIRE_7[7],
                 _normal_entries_WIRE_5[7],
                 _normal_entries_WIRE_3[7],
                 _normal_entries_WIRE_1[7]} & _px_array_T_2)
          : 14'h0)
       | (_cmd_write_T_5 | _cmd_write_T_6 | _cmd_write_T_7 | _cmd_write_T_8
            ? ~({{2{newEntry_pal}},
                 superpage_entries_3_data_0[4],
                 superpage_entries_2_data_0[4],
                 superpage_entries_1_data_0[4],
                 superpage_entries_0_data_0[4],
                 _normal_entries_WIRE_15[4],
                 _normal_entries_WIRE_13[4],
                 _normal_entries_WIRE_11[4],
                 _normal_entries_WIRE_9[4],
                 _normal_entries_WIRE_7[4],
                 _normal_entries_WIRE_5[4],
                 _normal_entries_WIRE_3[4],
                 _normal_entries_WIRE_1[4]} | lrscAllowed_0)
            : 14'h0)
       | (_cmd_write_T_12 | _cmd_write_T_13 | _cmd_write_T_14 | _cmd_write_T_15
          | _cmd_write_T_16
            ? ~({{2{newEntry_paa}},
                 superpage_entries_3_data_0[3],
                 superpage_entries_2_data_0[3],
                 superpage_entries_1_data_0[3],
                 superpage_entries_0_data_0[3],
                 _normal_entries_WIRE_15[3],
                 _normal_entries_WIRE_13[3],
                 _normal_entries_WIRE_11[3],
                 _normal_entries_WIRE_9[3],
                 _normal_entries_WIRE_7[3],
                 _normal_entries_WIRE_5[3],
                 _normal_entries_WIRE_3[3],
                 _normal_entries_WIRE_1[3]} | lrscAllowed_0)
            : 14'h0)) & hits_0);	// Bitwise.scala:72:12, Cat.scala:30:58, Consts.scala:82:76, package.scala:15:47, :72:59, tlb.scala:58:79, :123:30, :159:22, :163:64, :221:114, :227:56, :228:56, :252:43, :256:{8,44,46}, :257:{8,32,62}, :258:{8,32}, :262:32, :295:{43,54}
  assign io_resp_0_cacheable = |(lrscAllowed_0 & hits_0);	// Cat.scala:30:58, tlb.scala:300:{44,55}
  assign io_resp_1_miss = io_ptw_resp_valid | tlb_miss_1 | multipleHits_1;	// Misc.scala:182:49, tlb.scala:270:60, :303:50
  assign io_resp_1_paddr =
    {(hitsVec_1_0 ? _normal_entries_WIRE_26[33:14] : 20'h0)
       | (hitsVec_1_1 ? _normal_entries_WIRE_28[33:14] : 20'h0)
       | (hitsVec_1_2 ? _normal_entries_WIRE_30[33:14] : 20'h0)
       | (hitsVec_1_3 ? _normal_entries_WIRE_32[33:14] : 20'h0)
       | (hitsVec_1_4 ? _normal_entries_WIRE_34[33:14] : 20'h0)
       | (hitsVec_1_5 ? _normal_entries_WIRE_36[33:14] : 20'h0)
       | (hitsVec_1_6 ? _normal_entries_WIRE_38[33:14] : 20'h0)
       | (hitsVec_1_7 ? _normal_entries_WIRE_40[33:14] : 20'h0)
       | (hitsVec_1_8
            ? {superpage_entries_0_data_0[33:32],
               (ignore_1 ? io_req_1_bits_vaddr[29:21] : 9'h0)
                 | superpage_entries_0_data_0[31:23],
               io_req_1_bits_vaddr[20:12] | superpage_entries_0_data_0[22:14]}
            : 20'h0)
       | (hitsVec_1_9
            ? {superpage_entries_1_data_0[33:32],
               (ignore_4 ? io_req_1_bits_vaddr[29:21] : 9'h0)
                 | superpage_entries_1_data_0[31:23],
               io_req_1_bits_vaddr[20:12] | superpage_entries_1_data_0[22:14]}
            : 20'h0)
       | (hitsVec_1_10
            ? {superpage_entries_2_data_0[33:32],
               (ignore_7 ? io_req_1_bits_vaddr[29:21] : 9'h0)
                 | superpage_entries_2_data_0[31:23],
               io_req_1_bits_vaddr[20:12] | superpage_entries_2_data_0[22:14]}
            : 20'h0)
       | (hitsVec_1_11
            ? {superpage_entries_3_data_0[33:32],
               (ignore_10 ? io_req_1_bits_vaddr[29:21] : 9'h0)
                 | superpage_entries_3_data_0[31:23],
               io_req_1_bits_vaddr[20:12] | superpage_entries_3_data_0[22:14]}
            : 20'h0)
       | (hitsVec_1_12
            ? {special_entry_data_0[33:32],
               (ignore_13 ? io_req_1_bits_vaddr[29:21] : 9'h0)
                 | special_entry_data_0[31:23],
               (special_entry_level[1] ? 9'h0 : io_req_1_bits_vaddr[20:12])
                 | special_entry_data_0[22:14]}
            : 20'h0) | (vm_enabled_1 ? 20'h0 : io_req_1_bits_vaddr[31:12]),
     io_req_1_bits_vaddr[11:0]};	// Cat.scala:30:58, Mux.scala:27:72, tlb.scala:58:79, :66:30, :78:28, :80:31, :81:{30,49}, :107:64, :123:30, :124:56, :139:109, :142:47, :149:72, :171:69, :174:103
  assign io_resp_1_pf_ld =
    bad_va_1 & cmd_read_1
    | (|((cmd_read_1
            ? {~(r_array_lo_5[12] | special_entry_data_0[11]),
               ~(r_array_lo_5[11] | superpage_entries_3_data_0[11]),
               ~(r_array_lo_5[10] | superpage_entries_2_data_0[11]),
               ~(r_array_lo_5[9] | superpage_entries_1_data_0[11]),
               ~(r_array_lo_5[8] | superpage_entries_0_data_0[11]),
               ~(r_array_lo_5[7] | _normal_entries_WIRE_40[11]),
               ~(r_array_lo_5[6] | _normal_entries_WIRE_38[11]),
               ~(r_array_lo_5[5] | _normal_entries_WIRE_36[11]),
               ~(r_array_lo_5[4] | _normal_entries_WIRE_34[11]),
               ~(r_array_lo_5[3] | _normal_entries_WIRE_32[11]),
               ~(r_array_lo_5[2] | _normal_entries_WIRE_30[11]),
               ~(r_array_lo_5[1] | _normal_entries_WIRE_28[11]),
               ~(r_array_lo_5[0] | _normal_entries_WIRE_26[11])}
            : 13'h0) & _GEN_39));	// Cat.scala:30:58, Consts.scala:81:75, tlb.scala:58:79, :123:30, :124:56, :215:39, :217:62, :232:134, :265:{38,59,72}, :291:{38,54,73,84}
  assign io_resp_1_pf_st =
    bad_va_1 & cmd_write_perms_1
    | (|((cmd_write_perms_1
            ? {~(w_array_lo_3[12] | special_entry_data_0[11]),
               ~(w_array_lo_3[11] | superpage_entries_3_data_0[11]),
               ~(w_array_lo_3[10] | superpage_entries_2_data_0[11]),
               ~(w_array_lo_3[9] | superpage_entries_1_data_0[11]),
               ~(w_array_lo_3[8] | superpage_entries_0_data_0[11]),
               ~(w_array_lo_3[7] | _normal_entries_WIRE_40[11]),
               ~(w_array_lo_3[6] | _normal_entries_WIRE_38[11]),
               ~(w_array_lo_3[5] | _normal_entries_WIRE_36[11]),
               ~(w_array_lo_3[4] | _normal_entries_WIRE_34[11]),
               ~(w_array_lo_3[3] | _normal_entries_WIRE_32[11]),
               ~(w_array_lo_3[2] | _normal_entries_WIRE_30[11]),
               ~(w_array_lo_3[1] | _normal_entries_WIRE_28[11]),
               ~(w_array_lo_3[0] | _normal_entries_WIRE_26[11])}
            : 13'h0) & _GEN_39));	// Cat.scala:30:58, Consts.scala:82:76, tlb.scala:58:79, :123:30, :124:56, :215:39, :218:62, :232:134, :266:{38,59,72}, :292:{38,61,80,91}
  assign io_resp_1_ae_ld =
    |((cmd_read_1
         ? ae_array_1
           | ~({{2{legal_address_1 & _pmp_1_io_r}},
                superpage_entries_3_data_0[5],
                superpage_entries_2_data_0[5],
                superpage_entries_1_data_0[5],
                superpage_entries_0_data_0[5],
                _normal_entries_WIRE_40[5],
                _normal_entries_WIRE_38[5],
                _normal_entries_WIRE_36[5],
                _normal_entries_WIRE_34[5],
                _normal_entries_WIRE_32[5],
                _normal_entries_WIRE_30[5],
                _normal_entries_WIRE_28[5],
                _normal_entries_WIRE_26[5]} & _px_array_T_6)
         : 14'h0) & hits_1);	// Bitwise.scala:72:12, Cat.scala:30:58, Consts.scala:81:75, tlb.scala:58:79, :123:30, :150:40, :157:84, :162:60, :220:114, :252:43, :254:{38,64,66}, :262:32, :294:{43,54}
  assign io_resp_1_ae_st =
    |(((cmd_write_perms_1
          ? ae_array_1
            | ~({{2{legal_address_1
                      & (~(|_GEN_17) | ~(|_GEN_18) | ~(|_GEN_19) | ~(|_GEN_20)
                         | ~(|_GEN_12)) & _pmp_1_io_w}},
                 superpage_entries_3_data_0[7],
                 superpage_entries_2_data_0[7],
                 superpage_entries_1_data_0[7],
                 superpage_entries_0_data_0[7],
                 _normal_entries_WIRE_40[7],
                 _normal_entries_WIRE_38[7],
                 _normal_entries_WIRE_36[7],
                 _normal_entries_WIRE_34[7],
                 _normal_entries_WIRE_32[7],
                 _normal_entries_WIRE_30[7],
                 _normal_entries_WIRE_28[7],
                 _normal_entries_WIRE_26[7]} & _px_array_T_6)
          : 14'h0)
       | (_cmd_write_T_28 | _cmd_write_T_29 | _cmd_write_T_30 | _cmd_write_T_31
            ? ~({{2{legal_address_1
                      & (~(|_GEN_17) | ~(|_GEN_18) | ~(|_GEN_19) | ~(|_GEN_20)
                         | ~(|_GEN_12))}},
                 superpage_entries_3_data_0[4],
                 superpage_entries_2_data_0[4],
                 superpage_entries_1_data_0[4],
                 superpage_entries_0_data_0[4],
                 _normal_entries_WIRE_40[4],
                 _normal_entries_WIRE_38[4],
                 _normal_entries_WIRE_36[4],
                 _normal_entries_WIRE_34[4],
                 _normal_entries_WIRE_32[4],
                 _normal_entries_WIRE_30[4],
                 _normal_entries_WIRE_28[4],
                 _normal_entries_WIRE_26[4]} | lrscAllowed_1)
            : 14'h0)
       | (_cmd_write_T_35 | _cmd_write_T_36 | _cmd_write_T_37 | _cmd_write_T_38
          | _cmd_write_T_39
            ? ~({{2{legal_address_1
                      & (~(|_GEN_17) | ~(|_GEN_18) | ~(|_GEN_19) | ~(|_GEN_20)
                         | ~(|_GEN_12))}},
                 superpage_entries_3_data_0[3],
                 superpage_entries_2_data_0[3],
                 superpage_entries_1_data_0[3],
                 superpage_entries_0_data_0[3],
                 _normal_entries_WIRE_40[3],
                 _normal_entries_WIRE_38[3],
                 _normal_entries_WIRE_36[3],
                 _normal_entries_WIRE_34[3],
                 _normal_entries_WIRE_32[3],
                 _normal_entries_WIRE_30[3],
                 _normal_entries_WIRE_28[3],
                 _normal_entries_WIRE_26[3]} | lrscAllowed_1)
            : 14'h0)) & hits_1);	// Bitwise.scala:72:12, Cat.scala:30:58, Consts.scala:82:76, Parameters.scala:137:{49,52,67}, :615:89, package.scala:15:47, :72:59, tlb.scala:58:79, :123:30, :150:40, :157:84, :159:22, :163:64, :221:114, :227:56, :228:56, :252:43, :256:{8,44,46}, :257:{8,32,62}, :258:{8,32}, :262:32, :295:{43,54}
  assign io_resp_1_ma_ld = |(((|_GEN_37) & cmd_read_1 ? ~eff_array_1 : 14'h0) & hits_1);	// Cat.scala:30:58, Consts.scala:81:75, tlb.scala:231:{56,97}, :262:32, :263:{38,53,70}, :297:{43,54}
  assign io_resp_1_ma_st =
    |(((|_GEN_37) & cmd_write_perms_1 ? ~eff_array_1 : 14'h0) & hits_1);	// Cat.scala:30:58, Consts.scala:82:76, tlb.scala:231:{56,97}, :262:32, :263:70, :264:{38,53}, :298:{43,54}
  assign io_resp_1_cacheable = |(lrscAllowed_1 & hits_1);	// Cat.scala:30:58, tlb.scala:300:{44,55}
  assign io_ptw_req_valid = _io_ptw_req_valid_T;	// package.scala:15:47
  assign io_ptw_req_bits_valid = ~io_kill;	// tlb.scala:308:28
  assign io_ptw_req_bits_bits_addr = r_refill_tag;	// tlb.scala:130:25
endmodule

