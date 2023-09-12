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

module NBDTLB_2(
  input         clock,
                reset,
                io_req_0_valid,
  input  [39:0] io_req_0_bits_vaddr,
  input         io_req_0_bits_passthrough,
  input  [1:0]  io_req_0_bits_size,
  input  [4:0]  io_req_0_bits_cmd,
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
                io_resp_0_ma_ld,
                io_resp_0_ma_st,
                io_resp_0_cacheable,
                io_ptw_req_valid,
                io_ptw_req_bits_valid,
  output [26:0] io_ptw_req_bits_bits_addr
);

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
  reg              r_sectored_repl_addr;	// tlb.scala:132:33
  reg              r_sectored_hit_addr;	// tlb.scala:133:32
  reg              r_sectored_hit;	// tlb.scala:134:27
  wire             vm_enabled_0 =
    io_ptw_ptbr_mode[3] & ~(io_ptw_status_dprv[1]) & ~io_req_0_bits_passthrough;	// tlb.scala:138:27, :139:{63,109,112}
  wire             _io_ptw_req_valid_T = state == 2'h1;	// package.scala:15:47, tlb.scala:129:22
  wire             ignore_13 = special_entry_level == 2'h0;	// tlb.scala:80:31, :124:56, :129:22
  wire [27:0]      mpu_ppn_0 =
    io_ptw_resp_valid
      ? {8'h0, io_ptw_resp_bits_pte_ppn[19:0]}
      : vm_enabled_0
          ? {8'h0,
             special_entry_data_0[33:32],
             (ignore_13 ? io_req_0_bits_vaddr[29:21] : 9'h0)
               | special_entry_data_0[31:23],
             (special_entry_level[1] ? 9'h0 : io_req_0_bits_vaddr[20:12])
               | special_entry_data_0[22:14]}
          : io_req_0_bits_vaddr[39:12];	// tlb.scala:58:79, :78:28, :80:31, :81:{30,49}, :107:64, :124:56, :139:109, :142:47, :143:44, :147:20, :148:{20,134}, :262:32
  wire [13:0]      _GEN = mpu_ppn_0[13:0] ^ 14'h2010;	// Parameters.scala:137:31, tlb.scala:147:20
  wire [9:0]       _GEN_0 = mpu_ppn_0[13:4] ^ 10'h200;	// Parameters.scala:137:31, tlb.scala:147:20
  wire [3:0]       _GEN_1 = mpu_ppn_0[19:16] ^ 4'h8;	// Parameters.scala:137:31, tlb.scala:147:20, :152:20
  wire [16:0]      _GEN_2 = mpu_ppn_0[16:0] ^ 17'h10000;	// Parameters.scala:137:{31,52}, tlb.scala:147:20
  wire [1:0]       _GEN_3 = mpu_ppn_0[5:4] ^ 2'h2;	// Parameters.scala:137:31, tlb.scala:80:31, :147:20
  wire             legal_address_0 =
    {mpu_ppn_0[27:2], ~(mpu_ppn_0[1:0])} == 28'h0 | {mpu_ppn_0[27:14], _GEN} == 28'h0
    | {mpu_ppn_0[27:3], mpu_ppn_0[2:0] ^ 3'h4} == 28'h0
    | {mpu_ppn_0[27:19], mpu_ppn_0[18:0] ^ 19'h54000} == 28'h0
    | {mpu_ppn_0[27:9], mpu_ppn_0[8:0] ^ 9'h100} == 28'h0
    | {mpu_ppn_0[27:16], ~(mpu_ppn_0[15:14])} == 14'h0
    | {mpu_ppn_0[27:14], _GEN_0} == 24'h0 | mpu_ppn_0 == 28'h0
    | {mpu_ppn_0[27:5], ~(mpu_ppn_0[4])} == 24'h0 | {mpu_ppn_0[27:20], _GEN_1} == 12'h0
    | {mpu_ppn_0[27:17], _GEN_2} == 28'h0 | {mpu_ppn_0[27:6], _GEN_3} == 24'h0;	// Parameters.scala:137:{31,49,52,67}, tlb.scala:147:20, :157:84
  wire [3:0]       _GEN_4 = mpu_ppn_0[16:13] ^ 4'hA;	// Parameters.scala:137:31, tlb.scala:147:20
  wire [1:0]       _GEN_5 = {_GEN_1[3], mpu_ppn_0[16]};	// Parameters.scala:137:{31,49,52}, tlb.scala:147:20
  wire             newEntry_c =
    legal_address_0
    & ({mpu_ppn_0[19], _GEN_2[16], mpu_ppn_0[14:13]} == 4'h0 | ~(|_GEN_5));	// Parameters.scala:137:{31,49,52,67}, :615:89, tlb.scala:147:20, :157:84, :159:22, :231:89
  wire             newEntry_pr = legal_address_0 & _pmp_0_io_r;	// tlb.scala:150:40, :157:84, :162:60
  wire [5:0]       _GEN_6 =
    {mpu_ppn_0[19], mpu_ppn_0[16:15], mpu_ppn_0[13], mpu_ppn_0[5:4]};	// Parameters.scala:137:{31,49,52}, tlb.scala:147:20
  wire [5:0]       _GEN_7 =
    {mpu_ppn_0[19], mpu_ppn_0[16:15], _GEN_0[9], mpu_ppn_0[8], mpu_ppn_0[5]};	// Parameters.scala:137:{31,49,52}, tlb.scala:147:20
  wire [2:0]       _GEN_8 = {mpu_ppn_0[19], mpu_ppn_0[16], ~(mpu_ppn_0[15])};	// Parameters.scala:137:{31,49,52}, tlb.scala:147:20
  wire [6:0]       _GEN_9 =
    {mpu_ppn_0[19], _GEN_2[16:15], mpu_ppn_0[13], mpu_ppn_0[8], mpu_ppn_0[5:4]};	// Parameters.scala:137:{31,49,52}, tlb.scala:147:20
  wire             newEntry_pw =
    legal_address_0 & (~(|_GEN_6) | ~(|_GEN_7) | ~(|_GEN_8) | ~(|_GEN_9) | ~(|_GEN_5))
    & _pmp_0_io_w;	// Parameters.scala:137:{49,52,67}, :615:89, tlb.scala:150:40, :157:84, :163:64
  wire             newEntry_pal =
    legal_address_0 & (~(|_GEN_6) | ~(|_GEN_7) | ~(|_GEN_8) | ~(|_GEN_9) | ~(|_GEN_5));	// Parameters.scala:137:{49,52,67}, :615:89, tlb.scala:157:84, :159:22
  wire             newEntry_paa =
    legal_address_0 & (~(|_GEN_6) | ~(|_GEN_7) | ~(|_GEN_8) | ~(|_GEN_9) | ~(|_GEN_5));	// Parameters.scala:137:{49,52,67}, :615:89, tlb.scala:157:84, :159:22
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
          _GEN_0[9],
          mpu_ppn_0[8],
          mpu_ppn_0[5:4]} == 7'h0
       | {mpu_ppn_0[19],
          mpu_ppn_0[16],
          mpu_ppn_0[14],
          _GEN[13],
          mpu_ppn_0[8],
          _GEN[5:4],
          mpu_ppn_0[1]} == 8'h0 | {mpu_ppn_0[19], mpu_ppn_0[16], ~(mpu_ppn_0[14])} == 3'h0
       | {mpu_ppn_0[19],
          _GEN_4[3],
          _GEN_4[1:0],
          mpu_ppn_0[8],
          mpu_ppn_0[5:4],
          mpu_ppn_0[1]} == 8'h0);	// Parameters.scala:137:{31,49,52,67}, :615:89, Replacement.scala:168:70, tlb.scala:147:20, :157:84, :159:22, :215:39, :262:32
  wire [24:0]      _hitsVec_T = sectored_entries_0_tag[26:2] ^ io_req_0_bits_vaddr[38:14];	// tlb.scala:60:43, :122:29, :142:47
  wire [24:0]      _hitsVec_T_5 =
    sectored_entries_1_tag[26:2] ^ io_req_0_bits_vaddr[38:14];	// tlb.scala:60:43, :122:29, :142:47
  wire             ignore_1 = superpage_entries_0_level == 2'h0;	// tlb.scala:66:30, :123:30, :129:22
  wire             ignore_4 = superpage_entries_1_level == 2'h0;	// tlb.scala:66:30, :123:30, :129:22
  wire             ignore_7 = superpage_entries_2_level == 2'h0;	// tlb.scala:66:30, :123:30, :129:22
  wire             ignore_10 = superpage_entries_3_level == 2'h0;	// tlb.scala:66:30, :123:30, :129:22
  wire [3:0]       _GEN_10 =
    {{sectored_entries_0_valid_3},
     {sectored_entries_0_valid_2},
     {sectored_entries_0_valid_1},
     {sectored_entries_0_valid_0}};	// tlb.scala:72:20, :122:29
  wire             hitsVec_0_0 =
    vm_enabled_0 & _GEN_10[io_req_0_bits_vaddr[13:12]] & _hitsVec_T == 25'h0;	// package.scala:154:13, tlb.scala:60:{43,73}, :72:20, :139:109, :171:69
  wire [3:0]       _GEN_11 =
    {{sectored_entries_1_valid_3},
     {sectored_entries_1_valid_2},
     {sectored_entries_1_valid_1},
     {sectored_entries_1_valid_0}};	// tlb.scala:72:20, :122:29
  wire             hitsVec_0_1 =
    vm_enabled_0 & _GEN_11[io_req_0_bits_vaddr[13:12]] & _hitsVec_T_5 == 25'h0;	// package.scala:154:13, tlb.scala:60:{43,73}, :72:20, :139:109, :171:69
  wire             hitsVec_0_2 =
    vm_enabled_0 & superpage_entries_0_valid_0
    & superpage_entries_0_tag[26:18] == io_req_0_bits_vaddr[38:30]
    & (ignore_1 | superpage_entries_0_tag[17:9] == io_req_0_bits_vaddr[29:21]);	// tlb.scala:66:30, :67:{42,48,79,86}, :123:30, :139:109, :171:69
  wire             hitsVec_0_3 =
    vm_enabled_0 & superpage_entries_1_valid_0
    & superpage_entries_1_tag[26:18] == io_req_0_bits_vaddr[38:30]
    & (ignore_4 | superpage_entries_1_tag[17:9] == io_req_0_bits_vaddr[29:21]);	// tlb.scala:66:30, :67:{42,48,79,86}, :123:30, :139:109, :171:69
  wire             hitsVec_0_4 =
    vm_enabled_0 & superpage_entries_2_valid_0
    & superpage_entries_2_tag[26:18] == io_req_0_bits_vaddr[38:30]
    & (ignore_7 | superpage_entries_2_tag[17:9] == io_req_0_bits_vaddr[29:21]);	// tlb.scala:66:30, :67:{42,48,79,86}, :123:30, :139:109, :171:69
  wire             hitsVec_0_5 =
    vm_enabled_0 & superpage_entries_3_valid_0
    & superpage_entries_3_tag[26:18] == io_req_0_bits_vaddr[38:30]
    & (ignore_10 | superpage_entries_3_tag[17:9] == io_req_0_bits_vaddr[29:21]);	// tlb.scala:66:30, :67:{42,48,79,86}, :123:30, :139:109, :171:69
  wire             hitsVec_0_6 =
    vm_enabled_0 & special_entry_valid_0
    & special_entry_tag[26:18] == io_req_0_bits_vaddr[38:30]
    & (ignore_13 | special_entry_tag[17:9] == io_req_0_bits_vaddr[29:21])
    & (~(special_entry_level[1]) | special_entry_tag[8:0] == io_req_0_bits_vaddr[20:12]);	// tlb.scala:67:{42,48,79,86}, :80:31, :124:56, :139:109, :171:69
  wire [7:0]       hits_0 =
    {~vm_enabled_0,
     hitsVec_0_6,
     hitsVec_0_5,
     hitsVec_0_4,
     hitsVec_0_3,
     hitsVec_0_2,
     hitsVec_0_1,
     hitsVec_0_0};	// Cat.scala:30:58, tlb.scala:139:109, :171:69, :173:32
  wire [3:0][33:0] _GEN_12 =
    {{sectored_entries_0_data_3},
     {sectored_entries_0_data_2},
     {sectored_entries_0_data_1},
     {sectored_entries_0_data_0}};	// tlb.scala:122:29
  wire [33:0]      _normal_entries_WIRE_1 = _GEN_12[io_req_0_bits_vaddr[13:12]];	// package.scala:154:13
  wire [3:0][33:0] _GEN_13 =
    {{sectored_entries_1_data_3},
     {sectored_entries_1_data_2},
     {sectored_entries_1_data_1},
     {sectored_entries_1_data_0}};	// tlb.scala:122:29
  wire [33:0]      _normal_entries_WIRE_3 = _GEN_13[io_req_0_bits_vaddr[13:12]];	// package.scala:154:13
  wire [6:0]       priv_rw_ok_0 =
    (~(io_ptw_status_dprv[0]) | io_ptw_status_sum
       ? {special_entry_data_0[13],
          superpage_entries_3_data_0[13],
          superpage_entries_2_data_0[13],
          superpage_entries_1_data_0[13],
          superpage_entries_0_data_0[13],
          _normal_entries_WIRE_3[13],
          _normal_entries_WIRE_1[13]}
       : 7'h0)
    | (io_ptw_status_dprv[0]
         ? ~{special_entry_data_0[13],
             superpage_entries_3_data_0[13],
             superpage_entries_2_data_0[13],
             superpage_entries_1_data_0[13],
             superpage_entries_0_data_0[13],
             _normal_entries_WIRE_3[13],
             _normal_entries_WIRE_1[13]}
         : 7'h0);	// Cat.scala:30:58, tlb.scala:58:79, :123:30, :124:56, :137:20, :215:{39,40,48,103,108,117}
  wire [6:0]       r_array_lo_2 =
    priv_rw_ok_0
    & ({special_entry_data_0[8],
        superpage_entries_3_data_0[8],
        superpage_entries_2_data_0[8],
        superpage_entries_1_data_0[8],
        superpage_entries_0_data_0[8],
        _normal_entries_WIRE_3[8],
        _normal_entries_WIRE_1[8]}
       | (io_ptw_status_mxr
            ? {special_entry_data_0[9],
               superpage_entries_3_data_0[9],
               superpage_entries_2_data_0[9],
               superpage_entries_1_data_0[9],
               superpage_entries_0_data_0[9],
               _normal_entries_WIRE_3[9],
               _normal_entries_WIRE_1[9]}
            : 7'h0));	// Cat.scala:30:58, tlb.scala:58:79, :123:30, :124:56, :215:{39,103}, :217:{62,93,98}
  wire [6:0]       w_array_lo_1 =
    priv_rw_ok_0
    & {special_entry_data_0[10],
       superpage_entries_3_data_0[10],
       superpage_entries_2_data_0[10],
       superpage_entries_1_data_0[10],
       superpage_entries_0_data_0[10],
       _normal_entries_WIRE_3[10],
       _normal_entries_WIRE_1[10]};	// Cat.scala:30:58, tlb.scala:58:79, :123:30, :124:56, :215:103, :218:62
  wire [7:0]       _px_array_T_2 =
    {1'h1,
     ~(special_entry_data_0[11]),
     ~(superpage_entries_3_data_0[11]),
     ~(superpage_entries_2_data_0[11]),
     ~(superpage_entries_1_data_0[11]),
     ~(superpage_entries_0_data_0[11]),
     ~(_normal_entries_WIRE_3[11]),
     ~(_normal_entries_WIRE_1[11])};	// Cat.scala:30:58, tlb.scala:58:79, :123:30, :124:56, :220:116
  wire [7:0]       eff_array_0 =
    {{2{newEntry_eff}},
     superpage_entries_3_data_0[2],
     superpage_entries_2_data_0[2],
     superpage_entries_1_data_0[2],
     superpage_entries_0_data_0[2],
     _normal_entries_WIRE_3[2],
     _normal_entries_WIRE_1[2]};	// Bitwise.scala:72:12, Cat.scala:30:58, tlb.scala:58:79, :123:30, :159:22
  wire [7:0]       lrscAllowed_0 =
    {{2{newEntry_c}},
     superpage_entries_3_data_0[1],
     superpage_entries_2_data_0[1],
     superpage_entries_1_data_0[1],
     superpage_entries_0_data_0[1],
     _normal_entries_WIRE_3[1],
     _normal_entries_WIRE_1[1]};	// Bitwise.scala:72:12, Cat.scala:30:58, tlb.scala:58:79, :123:30, :159:22
  wire [3:0]       _GEN_14 =
    io_req_0_bits_vaddr[3:0] & (4'h1 << io_req_0_bits_size) - 4'h1;	// OneHot.scala:58:35, tlb.scala:231:{56,89}
  wire             bad_va_0 =
    vm_enabled_0
    & ~(io_req_0_bits_vaddr[39:38] == 2'h0 | (&(io_req_0_bits_vaddr[39:38])));	// tlb.scala:129:22, :139:109, :232:134, :237:46, :238:{49,63,71,86}
  wire             _cmd_read_T_1 = io_req_0_bits_cmd == 5'h6;	// package.scala:15:47
  wire             _cmd_write_T_3 = io_req_0_bits_cmd == 5'h7;	// package.scala:15:47
  wire             _cmd_write_T_5 = io_req_0_bits_cmd == 5'h4;	// package.scala:15:47
  wire             _cmd_write_T_6 = io_req_0_bits_cmd == 5'h9;	// package.scala:15:47
  wire             _cmd_write_T_7 = io_req_0_bits_cmd == 5'hA;	// package.scala:15:47
  wire             _cmd_write_T_8 = io_req_0_bits_cmd == 5'hB;	// package.scala:15:47
  wire             _cmd_write_T_12 = io_req_0_bits_cmd == 5'h8;	// package.scala:15:47
  wire             _cmd_write_T_13 = io_req_0_bits_cmd == 5'hC;	// package.scala:15:47
  wire             _cmd_write_T_14 = io_req_0_bits_cmd == 5'hD;	// package.scala:15:47
  wire             _cmd_write_T_15 = io_req_0_bits_cmd == 5'hE;	// package.scala:15:47
  wire             _cmd_write_T_16 = io_req_0_bits_cmd == 5'hF;	// package.scala:15:47
  wire             cmd_read_0 =
    io_req_0_bits_cmd == 5'h0 | _cmd_read_T_1 | _cmd_write_T_3 | _cmd_write_T_5
    | _cmd_write_T_6 | _cmd_write_T_7 | _cmd_write_T_8 | _cmd_write_T_12 | _cmd_write_T_13
    | _cmd_write_T_14 | _cmd_write_T_15 | _cmd_write_T_16;	// Consts.scala:81:{31,75}, package.scala:15:47
  wire             cmd_write_perms_0 =
    io_req_0_bits_cmd == 5'h1 | io_req_0_bits_cmd == 5'h11 | _cmd_write_T_3
    | _cmd_write_T_5 | _cmd_write_T_6 | _cmd_write_T_7 | _cmd_write_T_8 | _cmd_write_T_12
    | _cmd_write_T_13 | _cmd_write_T_14 | _cmd_write_T_15 | _cmd_write_T_16;	// Consts.scala:82:{32,49,76}, package.scala:15:47
  wire [7:0]       ae_array_0 =
    ((|_GEN_14) ? eff_array_0 : 8'h0)
    | (_cmd_read_T_1 | _cmd_write_T_3 ? ~lrscAllowed_0 : 8'h0);	// Cat.scala:30:58, package.scala:15:47, :72:59, tlb.scala:231:{56,97}, :252:{8,43}, :253:{8,24}, :262:32
  wire             tlb_miss_0 =
    vm_enabled_0 & ~bad_va_0
    & {hitsVec_0_6,
       hitsVec_0_5,
       hitsVec_0_4,
       hitsVec_0_3,
       hitsVec_0_2,
       hitsVec_0_1,
       hitsVec_0_0} == 7'h0;	// tlb.scala:139:109, :171:69, :172:44, :215:39, :232:134, :269:44, :270:{49,60}
  reg              state_reg;	// Replacement.scala:168:70
  reg  [2:0]       state_reg_1;	// Replacement.scala:168:70
  wire             multipleHits_rightOne_1 = hitsVec_0_1 | hitsVec_0_2;	// Misc.scala:182:16, tlb.scala:171:69
  wire             multipleHits_leftOne_4 = hitsVec_0_3 | hitsVec_0_4;	// Misc.scala:182:16, tlb.scala:171:69
  wire             multipleHits_rightOne_4 = hitsVec_0_5 | hitsVec_0_6;	// Misc.scala:182:16, tlb.scala:171:69
  wire             multipleHits_0 =
    hitsVec_0_1 & hitsVec_0_2 | hitsVec_0_0 & multipleHits_rightOne_1 | hitsVec_0_3
    & hitsVec_0_4 | hitsVec_0_5 & hitsVec_0_6 | multipleHits_leftOne_4
    & multipleHits_rightOne_4 | (hitsVec_0_0 | multipleHits_rightOne_1)
    & (multipleHits_leftOne_4 | multipleHits_rightOne_4);	// Misc.scala:182:{16,49,61}, tlb.scala:171:69
  wire             _io_miss_rdy_T = state == 2'h0;	// tlb.scala:129:22, :288:24
  wire [6:0]       _GEN_15 =
    {hitsVec_0_6,
     hitsVec_0_5,
     hitsVec_0_4,
     hitsVec_0_3,
     hitsVec_0_2,
     hitsVec_0_1,
     hitsVec_0_0};	// Cat.scala:30:58, tlb.scala:171:69
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
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    automatic logic        newEntry_px;	// tlb.scala:166:59
    automatic logic        _r_sectored_repl_addr_valids_T;	// package.scala:72:59
    automatic logic        sector_hits_0_0;	// tlb.scala:59:42
    automatic logic        _r_sectored_repl_addr_valids_T_2;	// package.scala:72:59
    automatic logic        sector_hits_0_1;	// tlb.scala:59:42
    automatic logic        newEntry_sr;	// PTW.scala:77:35
    automatic logic        newEntry_sw;	// PTW.scala:78:40
    automatic logic        newEntry_sx;	// PTW.scala:79:35
    automatic logic        _GEN_16 = io_ptw_resp_valid & ~io_ptw_resp_bits_homogeneous;	// tlb.scala:90:16, :124:56, :177:20, :196:{39,70}
    automatic logic        _GEN_17;	// tlb.scala:94:18, :124:56, :177:20, :196:70
    automatic logic        _GEN_18;	// tlb.scala:123:30, :177:20, :196:70
    automatic logic        _GEN_19;	// tlb.scala:123:30, :177:20, :196:70
    automatic logic        _GEN_20;	// tlb.scala:123:30, :177:20, :196:70
    automatic logic        _GEN_21;	// tlb.scala:123:30, :177:20, :196:70
    automatic logic        _GEN_22;	// tlb.scala:123:30, :177:20, :196:70
    automatic logic        _GEN_23;	// tlb.scala:123:30, :177:20, :196:70
    automatic logic        _GEN_24;	// tlb.scala:123:30, :177:20, :196:70
    automatic logic        _GEN_25;	// tlb.scala:123:30, :177:20, :196:70
    automatic logic        waddr;	// tlb.scala:203:22
    automatic logic        _GEN_26 =
      ~io_ptw_resp_bits_homogeneous | ~(io_ptw_resp_bits_level[1]);	// tlb.scala:122:29, :196:{39,70}, :198:{40,58}, :204:74
    automatic logic        _GEN_27;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_28;	// tlb.scala:94:18
    automatic logic        _GEN_29;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_30;	// tlb.scala:94:18
    automatic logic        _GEN_31;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_32;	// tlb.scala:94:18
    automatic logic        _GEN_33;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_34;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic [33:0] _sectored_entries_0_data_T;	// tlb.scala:95:26
    automatic logic        _GEN_35;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_36;	// tlb.scala:94:18
    automatic logic        _GEN_37;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_38;	// tlb.scala:94:18
    automatic logic        _GEN_39;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_40;	// tlb.scala:94:18
    automatic logic        _GEN_41;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic        _GEN_42;	// tlb.scala:122:29, :177:20, :196:70
    automatic logic [33:0] _sectored_entries_1_data_T;	// tlb.scala:95:26
    automatic logic        _GEN_43;	// tlb.scala:314:45
    automatic logic        _GEN_44 = _hitsVec_T == 25'h0;	// tlb.scala:60:{43,73}
    automatic logic        _GEN_45 = io_req_0_bits_vaddr[13:12] == 2'h0;	// package.scala:154:13, tlb.scala:103:60, :129:22
    automatic logic        _GEN_46 = _GEN_44 & _GEN_45;	// tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_47 = io_req_0_bits_vaddr[13:12] == 2'h1;	// package.scala:15:47, :154:13, tlb.scala:103:60
    automatic logic        _GEN_48 = _GEN_44 & _GEN_47;	// tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_49 = io_req_0_bits_vaddr[13:12] == 2'h2;	// package.scala:154:13, tlb.scala:80:31, :103:60
    automatic logic        _GEN_50 = _GEN_44 & _GEN_49;	// tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_51 = _GEN_44 & (&(io_req_0_bits_vaddr[13:12]));	// package.scala:154:13, tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_52 = _hitsVec_T[24:16] == 9'h0;	// tlb.scala:60:43, :107:{29,64}
    automatic logic        _GEN_53 = _hitsVec_T_5 == 25'h0;	// tlb.scala:60:{43,73}
    automatic logic        _GEN_54 = _GEN_53 & _GEN_45;	// tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_55 = _GEN_53 & _GEN_47;	// tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_56 = _GEN_53 & _GEN_49;	// tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_57 = _GEN_53 & (&(io_req_0_bits_vaddr[13:12]));	// package.scala:154:13, tlb.scala:60:73, :103:{36,60}, :177:20
    automatic logic        _GEN_58 = _hitsVec_T_5[24:16] == 9'h0;	// tlb.scala:60:43, :107:{29,64}
    automatic logic        _GEN_59 = multipleHits_0 | reset;	// Misc.scala:182:49, tlb.scala:346:28
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
         | {mpu_ppn_0[19], mpu_ppn_0[16], mpu_ppn_0[14:13], mpu_ppn_0[8], _GEN_3} == 7'h0
         | ~(|_GEN_5)) & _pmp_0_io_x;	// Parameters.scala:137:{31,49,52,67}, :615:89, tlb.scala:147:20, :150:40, :157:84, :166:59, :215:39
    _r_sectored_repl_addr_valids_T =
      sectored_entries_0_valid_0 | sectored_entries_0_valid_1;	// package.scala:72:59, tlb.scala:122:29
    sector_hits_0_0 =
      (_r_sectored_repl_addr_valids_T | sectored_entries_0_valid_2
       | sectored_entries_0_valid_3) & _hitsVec_T == 25'h0;	// package.scala:72:59, tlb.scala:59:42, :60:{43,73}, :122:29
    _r_sectored_repl_addr_valids_T_2 =
      sectored_entries_1_valid_0 | sectored_entries_1_valid_1;	// package.scala:72:59, tlb.scala:122:29
    sector_hits_0_1 =
      (_r_sectored_repl_addr_valids_T_2 | sectored_entries_1_valid_2
       | sectored_entries_1_valid_3) & _hitsVec_T_5 == 25'h0;	// package.scala:72:59, tlb.scala:59:42, :60:{43,73}, :122:29
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
    _GEN_17 = _GEN_16 | special_entry_valid_0;	// tlb.scala:90:16, :94:18, :124:56, :177:20, :196:70
    _GEN_18 =
      io_ptw_resp_valid & io_ptw_resp_bits_homogeneous & ~(io_ptw_resp_bits_level[1])
      & r_superpage_repl_addr == 2'h0;	// tlb.scala:123:30, :129:22, :131:34, :177:20, :196:70, :198:40, :199:82
    _GEN_19 = _GEN_18 | superpage_entries_0_valid_0;	// tlb.scala:123:30, :177:20, :196:70
    _GEN_20 =
      io_ptw_resp_valid & io_ptw_resp_bits_homogeneous & ~(io_ptw_resp_bits_level[1])
      & r_superpage_repl_addr == 2'h1;	// package.scala:15:47, tlb.scala:123:30, :131:34, :177:20, :196:70, :198:40, :199:82
    _GEN_21 = _GEN_20 | superpage_entries_1_valid_0;	// tlb.scala:123:30, :177:20, :196:70
    _GEN_22 =
      io_ptw_resp_valid & io_ptw_resp_bits_homogeneous & ~(io_ptw_resp_bits_level[1])
      & r_superpage_repl_addr == 2'h2;	// tlb.scala:80:31, :123:30, :131:34, :177:20, :196:70, :198:40, :199:82
    _GEN_23 = _GEN_22 | superpage_entries_2_valid_0;	// tlb.scala:123:30, :177:20, :196:70
    _GEN_24 =
      io_ptw_resp_valid & io_ptw_resp_bits_homogeneous & ~(io_ptw_resp_bits_level[1])
      & (&r_superpage_repl_addr);	// tlb.scala:123:30, :131:34, :177:20, :196:70, :198:40, :199:82
    _GEN_25 = _GEN_24 | superpage_entries_3_valid_0;	// tlb.scala:123:30, :177:20, :196:70
    waddr = r_sectored_hit ? r_sectored_hit_addr : r_sectored_repl_addr;	// tlb.scala:132:33, :133:32, :134:27, :203:22
    _GEN_27 = ~io_ptw_resp_valid | _GEN_26 | waddr;	// tlb.scala:122:29, :177:20, :196:70, :198:58, :203:22, :204:74
    _GEN_28 = r_refill_tag[1:0] == 2'h0;	// package.scala:154:13, tlb.scala:94:18, :129:22, :130:25
    _GEN_29 =
      _GEN_27
        ? sectored_entries_0_valid_0
        : _GEN_28 | r_sectored_hit & sectored_entries_0_valid_0;	// tlb.scala:94:18, :98:40, :122:29, :134:27, :177:20, :196:70, :205:32
    _GEN_30 = r_refill_tag[1:0] == 2'h1;	// package.scala:15:47, :154:13, tlb.scala:94:18, :130:25
    _GEN_31 =
      _GEN_27
        ? sectored_entries_0_valid_1
        : _GEN_30 | r_sectored_hit & sectored_entries_0_valid_1;	// tlb.scala:94:18, :98:40, :122:29, :134:27, :177:20, :196:70, :205:32
    _GEN_32 = r_refill_tag[1:0] == 2'h2;	// package.scala:154:13, tlb.scala:80:31, :94:18, :130:25
    _GEN_33 =
      _GEN_27
        ? sectored_entries_0_valid_2
        : _GEN_32 | r_sectored_hit & sectored_entries_0_valid_2;	// tlb.scala:94:18, :98:40, :122:29, :134:27, :177:20, :196:70, :205:32
    _GEN_34 =
      _GEN_27
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
    _GEN_35 = ~io_ptw_resp_valid | _GEN_26 | ~waddr;	// tlb.scala:122:29, :177:20, :196:70, :198:58, :203:22, :204:74
    _GEN_36 = r_refill_tag[1:0] == 2'h0;	// package.scala:154:13, tlb.scala:94:18, :129:22, :130:25
    _GEN_37 =
      _GEN_35
        ? sectored_entries_1_valid_0
        : _GEN_36 | r_sectored_hit & sectored_entries_1_valid_0;	// tlb.scala:94:18, :98:40, :122:29, :134:27, :177:20, :196:70, :205:32
    _GEN_38 = r_refill_tag[1:0] == 2'h1;	// package.scala:15:47, :154:13, tlb.scala:94:18, :130:25
    _GEN_39 =
      _GEN_35
        ? sectored_entries_1_valid_1
        : _GEN_38 | r_sectored_hit & sectored_entries_1_valid_1;	// tlb.scala:94:18, :98:40, :122:29, :134:27, :177:20, :196:70, :205:32
    _GEN_40 = r_refill_tag[1:0] == 2'h2;	// package.scala:154:13, tlb.scala:80:31, :94:18, :130:25
    _GEN_41 =
      _GEN_35
        ? sectored_entries_1_valid_2
        : _GEN_40 | r_sectored_hit & sectored_entries_1_valid_2;	// tlb.scala:94:18, :98:40, :122:29, :134:27, :177:20, :196:70, :205:32
    _GEN_42 =
      _GEN_35
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
    _GEN_43 = io_req_0_valid & tlb_miss_0 & _io_miss_rdy_T;	// tlb.scala:270:60, :288:24, :314:45
    if (_GEN_27) begin	// tlb.scala:122:29, :177:20, :196:70
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_0_tag <= r_refill_tag;	// tlb.scala:122:29, :130:25
    if (~io_ptw_resp_valid | _GEN_26 | ~(~waddr & _GEN_28)) begin	// tlb.scala:94:18, :95:17, :122:29, :177:20, :196:70, :198:58, :203:22, :204:{65,74}
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_0_data_0 <= _sectored_entries_0_data_T;	// tlb.scala:95:26, :122:29
    if (~io_ptw_resp_valid | _GEN_26 | ~(~waddr & _GEN_30)) begin	// tlb.scala:94:18, :95:17, :122:29, :177:20, :196:70, :198:58, :203:22, :204:{65,74}
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_0_data_1 <= _sectored_entries_0_data_T;	// tlb.scala:95:26, :122:29
    if (~io_ptw_resp_valid | _GEN_26 | ~(~waddr & _GEN_32)) begin	// tlb.scala:94:18, :95:17, :122:29, :177:20, :196:70, :198:58, :203:22, :204:{65,74}
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_0_data_2 <= _sectored_entries_0_data_T;	// tlb.scala:95:26, :122:29
    if (~io_ptw_resp_valid | _GEN_26 | ~(~waddr & (&(r_refill_tag[1:0])))) begin	// package.scala:154:13, tlb.scala:94:18, :95:17, :122:29, :130:25, :177:20, :196:70, :198:58, :203:22, :204:{65,74}
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_0_data_3 <= _sectored_entries_0_data_T;	// tlb.scala:95:26, :122:29
    sectored_entries_0_valid_0 <=
      ~_GEN_59
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_52
                     ? ~(sectored_entries_0_data_0[0] | _GEN_46) & _GEN_29
                     : ~_GEN_46 & _GEN_29)
                : io_sfence_bits_rs2 & sectored_entries_0_data_0[12] & _GEN_29)
           : _GEN_29);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    sectored_entries_0_valid_1 <=
      ~_GEN_59
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_52
                     ? ~(sectored_entries_0_data_1[0] | _GEN_48) & _GEN_31
                     : ~_GEN_48 & _GEN_31)
                : io_sfence_bits_rs2 & sectored_entries_0_data_1[12] & _GEN_31)
           : _GEN_31);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    sectored_entries_0_valid_2 <=
      ~_GEN_59
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_52
                     ? ~(sectored_entries_0_data_2[0] | _GEN_50) & _GEN_33
                     : ~_GEN_50 & _GEN_33)
                : io_sfence_bits_rs2 & sectored_entries_0_data_2[12] & _GEN_33)
           : _GEN_33);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    sectored_entries_0_valid_3 <=
      ~_GEN_59
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_52
                     ? ~(sectored_entries_0_data_3[0] | _GEN_51) & _GEN_34
                     : ~_GEN_51 & _GEN_34)
                : io_sfence_bits_rs2 & sectored_entries_0_data_3[12] & _GEN_34)
           : _GEN_34);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    if (_GEN_35) begin	// tlb.scala:122:29, :177:20, :196:70
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_1_tag <= r_refill_tag;	// tlb.scala:122:29, :130:25
    if (~io_ptw_resp_valid | _GEN_26 | ~(waddr & _GEN_36)) begin	// tlb.scala:94:18, :95:17, :122:29, :177:20, :196:70, :198:58, :203:22, :204:74
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_1_data_0 <= _sectored_entries_1_data_T;	// tlb.scala:95:26, :122:29
    if (~io_ptw_resp_valid | _GEN_26 | ~(waddr & _GEN_38)) begin	// tlb.scala:94:18, :95:17, :122:29, :177:20, :196:70, :198:58, :203:22, :204:74
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_1_data_1 <= _sectored_entries_1_data_T;	// tlb.scala:95:26, :122:29
    if (~io_ptw_resp_valid | _GEN_26 | ~(waddr & _GEN_40)) begin	// tlb.scala:94:18, :95:17, :122:29, :177:20, :196:70, :198:58, :203:22, :204:74
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_1_data_2 <= _sectored_entries_1_data_T;	// tlb.scala:95:26, :122:29
    if (~io_ptw_resp_valid | _GEN_26 | ~(waddr & (&(r_refill_tag[1:0])))) begin	// package.scala:154:13, tlb.scala:94:18, :95:17, :122:29, :130:25, :177:20, :196:70, :198:58, :203:22, :204:74
    end
    else	// tlb.scala:122:29, :177:20, :196:70
      sectored_entries_1_data_3 <= _sectored_entries_1_data_T;	// tlb.scala:95:26, :122:29
    sectored_entries_1_valid_0 <=
      ~_GEN_59
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_58
                     ? ~(sectored_entries_1_data_0[0] | _GEN_54) & _GEN_37
                     : ~_GEN_54 & _GEN_37)
                : io_sfence_bits_rs2 & sectored_entries_1_data_0[12] & _GEN_37)
           : _GEN_37);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    sectored_entries_1_valid_1 <=
      ~_GEN_59
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_58
                     ? ~(sectored_entries_1_data_1[0] | _GEN_55) & _GEN_39
                     : ~_GEN_55 & _GEN_39)
                : io_sfence_bits_rs2 & sectored_entries_1_data_1[12] & _GEN_39)
           : _GEN_39);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    sectored_entries_1_valid_2 <=
      ~_GEN_59
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_58
                     ? ~(sectored_entries_1_data_2[0] | _GEN_56) & _GEN_41
                     : ~_GEN_56 & _GEN_41)
                : io_sfence_bits_rs2 & sectored_entries_1_data_2[12] & _GEN_41)
           : _GEN_41);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    sectored_entries_1_valid_3 <=
      ~_GEN_59
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_58
                     ? ~(sectored_entries_1_data_3[0] | _GEN_57) & _GEN_42
                     : ~_GEN_57 & _GEN_42)
                : io_sfence_bits_rs2 & sectored_entries_1_data_3[12] & _GEN_42)
           : _GEN_42);	// tlb.scala:55:41, :98:40, :103:{36,60}, :107:{64,73}, :109:{44,48}, :115:22, :122:29, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    if (_GEN_18) begin	// tlb.scala:123:30, :177:20, :196:70
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
      ~_GEN_59
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? ~(superpage_entries_0_valid_0
                    & superpage_entries_0_tag[26:18] == io_req_0_bits_vaddr[38:30]
                    & (ignore_1
                       | superpage_entries_0_tag[17:9] == io_req_0_bits_vaddr[29:21]))
                  & _GEN_19
                : io_sfence_bits_rs2 & superpage_entries_0_data_0[12] & _GEN_19)
           : _GEN_19);	// tlb.scala:55:41, :66:30, :67:{31,42,48,79,86}, :98:40, :101:26, :115:22, :123:30, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    if (_GEN_20) begin	// tlb.scala:123:30, :177:20, :196:70
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
      ~_GEN_59
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? ~(superpage_entries_1_valid_0
                    & superpage_entries_1_tag[26:18] == io_req_0_bits_vaddr[38:30]
                    & (ignore_4
                       | superpage_entries_1_tag[17:9] == io_req_0_bits_vaddr[29:21]))
                  & _GEN_21
                : io_sfence_bits_rs2 & superpage_entries_1_data_0[12] & _GEN_21)
           : _GEN_21);	// tlb.scala:55:41, :66:30, :67:{31,42,48,79,86}, :98:40, :101:26, :115:22, :123:30, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    if (_GEN_22) begin	// tlb.scala:123:30, :177:20, :196:70
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
      ~_GEN_59
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? ~(superpage_entries_2_valid_0
                    & superpage_entries_2_tag[26:18] == io_req_0_bits_vaddr[38:30]
                    & (ignore_7
                       | superpage_entries_2_tag[17:9] == io_req_0_bits_vaddr[29:21]))
                  & _GEN_23
                : io_sfence_bits_rs2 & superpage_entries_2_data_0[12] & _GEN_23)
           : _GEN_23);	// tlb.scala:55:41, :66:30, :67:{31,42,48,79,86}, :98:40, :101:26, :115:22, :123:30, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    if (_GEN_24) begin	// tlb.scala:123:30, :177:20, :196:70
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
      ~_GEN_59
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? ~(superpage_entries_3_valid_0
                    & superpage_entries_3_tag[26:18] == io_req_0_bits_vaddr[38:30]
                    & (ignore_10
                       | superpage_entries_3_tag[17:9] == io_req_0_bits_vaddr[29:21]))
                  & _GEN_25
                : io_sfence_bits_rs2 & superpage_entries_3_data_0[12] & _GEN_25)
           : _GEN_25);	// tlb.scala:55:41, :66:30, :67:{31,42,48,79,86}, :98:40, :101:26, :115:22, :123:30, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    if (_GEN_16) begin	// tlb.scala:90:16, :124:56, :177:20, :196:70
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
      ~_GEN_59
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? ~(special_entry_valid_0
                    & special_entry_tag[26:18] == io_req_0_bits_vaddr[38:30]
                    & (ignore_13 | special_entry_tag[17:9] == io_req_0_bits_vaddr[29:21])
                    & (~(special_entry_level[1])
                       | special_entry_tag[8:0] == io_req_0_bits_vaddr[20:12])) & _GEN_17
                : io_sfence_bits_rs2 & special_entry_data_0[12] & _GEN_17)
           : _GEN_17);	// tlb.scala:55:41, :67:{31,42,48,79,86}, :80:31, :94:18, :98:40, :101:26, :115:22, :124:56, :177:20, :196:70, :336:19, :340:37, :341:42, :346:{28,45}
    if (_GEN_43) begin	// tlb.scala:314:45
      automatic logic r_sectored_repl_addr_valids_lo;	// package.scala:72:59
      r_sectored_repl_addr_valids_lo =
        _r_sectored_repl_addr_valids_T | sectored_entries_0_valid_2
        | sectored_entries_0_valid_3;	// package.scala:72:59, tlb.scala:122:29
      r_refill_tag <= io_req_0_bits_vaddr[38:12];	// tlb.scala:130:25, :142:47
      if (&{superpage_entries_3_valid_0,
            superpage_entries_2_valid_0,
            superpage_entries_1_valid_0,
            superpage_entries_0_valid_0})	// Cat.scala:30:58, tlb.scala:123:30, :353:16
        r_superpage_repl_addr <=
          {state_reg_1[2], state_reg_1[2] ? state_reg_1[1] : state_reg_1[0]};	// Cat.scala:30:58, Replacement.scala:168:70, :243:38, :245:38, :250:16, package.scala:154:13, tlb.scala:131:34
      else begin	// tlb.scala:353:16
        automatic logic [2:0] _r_superpage_repl_addr_T_4;	// tlb.scala:353:43
        _r_superpage_repl_addr_T_4 =
          ~{superpage_entries_2_valid_0,
            superpage_entries_1_valid_0,
            superpage_entries_0_valid_0};	// Cat.scala:30:58, tlb.scala:123:30, :353:43
        if (_r_superpage_repl_addr_T_4[0])	// OneHot.scala:47:40, tlb.scala:353:43
          r_superpage_repl_addr <= 2'h0;	// tlb.scala:129:22, :131:34
        else if (_r_superpage_repl_addr_T_4[1])	// OneHot.scala:47:40, tlb.scala:353:43
          r_superpage_repl_addr <= 2'h1;	// package.scala:15:47, tlb.scala:131:34
        else	// OneHot.scala:47:40
          r_superpage_repl_addr <= {1'h1, ~(_r_superpage_repl_addr_T_4[2])};	// Mux.scala:47:69, OneHot.scala:47:40, tlb.scala:131:34, :353:43
      end
      if (&{_r_sectored_repl_addr_valids_T_2 | sectored_entries_1_valid_2
              | sectored_entries_1_valid_3,
            r_sectored_repl_addr_valids_lo})	// Cat.scala:30:58, package.scala:72:59, tlb.scala:122:29, :353:16
        r_sectored_repl_addr <= state_reg;	// Replacement.scala:168:70, tlb.scala:132:33
      else	// tlb.scala:353:16
        r_sectored_repl_addr <= r_sectored_repl_addr_valids_lo;	// package.scala:72:59, tlb.scala:132:33
      r_sectored_hit_addr <= sector_hits_0_1;	// tlb.scala:59:42, :133:32
      r_sectored_hit <= sector_hits_0_0 | sector_hits_0_1;	// package.scala:72:59, tlb.scala:59:42, :134:27
    end
    if (reset) begin
      state <= 2'h0;	// tlb.scala:129:22
      state_reg <= 1'h0;	// Replacement.scala:168:70
      state_reg_1 <= 3'h0;	// Replacement.scala:168:70
    end
    else begin
      automatic logic superpage_hits_0_1;	// tlb.scala:67:31
      automatic logic superpage_hits_0_2;	// tlb.scala:67:31
      automatic logic superpage_hits_0_3;	// tlb.scala:67:31
      automatic logic _GEN_60 = io_req_0_valid & vm_enabled_0;	// tlb.scala:139:109, :275:27
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
      if (io_ptw_resp_valid)
        state <= 2'h0;	// tlb.scala:129:22
      else if (state == 2'h2 & io_sfence_valid)	// tlb.scala:80:31, :129:22, :329:{17,28}
        state <= 2'h3;	// package.scala:15:47, tlb.scala:129:22
      else if (_io_ptw_req_valid_T) begin	// package.scala:15:47
        if (io_kill)
          state <= 2'h0;	// tlb.scala:129:22
        else if (io_ptw_req_ready)
          state <= {1'h1, io_sfence_valid};	// tlb.scala:129:22, :326:45
        else if (io_sfence_valid)
          state <= 2'h0;	// tlb.scala:129:22
        else if (_GEN_43)	// tlb.scala:314:45
          state <= 2'h1;	// package.scala:15:47, tlb.scala:129:22
      end
      else if (_GEN_43)	// tlb.scala:314:45
        state <= 2'h1;	// package.scala:15:47, tlb.scala:129:22
      if (_GEN_60 & (sector_hits_0_0 | sector_hits_0_1))	// Replacement.scala:168:70, :172:15, package.scala:72:59, tlb.scala:59:42, :275:{27,45}, :276:33
        state_reg <= ~sector_hits_0_1;	// Replacement.scala:168:70, :218:7, tlb.scala:59:42
      if (_GEN_60
          & (superpage_entries_0_valid_0
             & superpage_entries_0_tag[26:18] == io_req_0_bits_vaddr[38:30]
             & (ignore_1 | superpage_entries_0_tag[17:9] == io_req_0_bits_vaddr[29:21])
             | superpage_hits_0_1 | superpage_hits_0_2 | superpage_hits_0_3)) begin	// Replacement.scala:168:70, :172:15, package.scala:72:59, tlb.scala:66:30, :67:{31,42,48,79,86}, :123:30, :275:{27,45}, :277:36
        automatic logic [1:0] hi_1;	// OneHot.scala:30:18
        automatic logic       lo_2;	// OneHot.scala:32:28
        hi_1 = {superpage_hits_0_3, superpage_hits_0_2};	// OneHot.scala:30:18, tlb.scala:67:31
        lo_2 = superpage_hits_0_3 | superpage_hits_0_1;	// OneHot.scala:32:28, tlb.scala:67:31
        state_reg_1 <=
          {~(|hi_1), (|hi_1) ? ~lo_2 : state_reg_1[1], (|hi_1) ? state_reg_1[0] : ~lo_2};	// Cat.scala:30:58, OneHot.scala:30:18, :32:{14,28}, Replacement.scala:168:70, :196:33, :198:38, :203:16, :206:16, :218:7, package.scala:154:13
      end
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:21];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [4:0] i = 5'h0; i < 5'h16; i += 5'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        sectored_entries_0_tag = _RANDOM[5'h0][28:2];	// tlb.scala:122:29
        sectored_entries_0_data_0 = {_RANDOM[5'h0][31:29], _RANDOM[5'h1][30:0]};	// tlb.scala:122:29
        sectored_entries_0_data_1 = {_RANDOM[5'h1][31], _RANDOM[5'h2], _RANDOM[5'h3][0]};	// tlb.scala:122:29
        sectored_entries_0_data_2 = {_RANDOM[5'h3][31:1], _RANDOM[5'h4][2:0]};	// tlb.scala:122:29
        sectored_entries_0_data_3 = {_RANDOM[5'h4][31:3], _RANDOM[5'h5][4:0]};	// tlb.scala:122:29
        sectored_entries_0_valid_0 = _RANDOM[5'h5][5];	// tlb.scala:122:29
        sectored_entries_0_valid_1 = _RANDOM[5'h5][6];	// tlb.scala:122:29
        sectored_entries_0_valid_2 = _RANDOM[5'h5][7];	// tlb.scala:122:29
        sectored_entries_0_valid_3 = _RANDOM[5'h5][8];	// tlb.scala:122:29
        sectored_entries_1_tag = {_RANDOM[5'h5][31:11], _RANDOM[5'h6][5:0]};	// tlb.scala:122:29
        sectored_entries_1_data_0 = {_RANDOM[5'h6][31:6], _RANDOM[5'h7][7:0]};	// tlb.scala:122:29
        sectored_entries_1_data_1 = {_RANDOM[5'h7][31:8], _RANDOM[5'h8][9:0]};	// tlb.scala:122:29
        sectored_entries_1_data_2 = {_RANDOM[5'h8][31:10], _RANDOM[5'h9][11:0]};	// tlb.scala:122:29
        sectored_entries_1_data_3 = {_RANDOM[5'h9][31:12], _RANDOM[5'hA][13:0]};	// tlb.scala:122:29
        sectored_entries_1_valid_0 = _RANDOM[5'hA][14];	// tlb.scala:122:29
        sectored_entries_1_valid_1 = _RANDOM[5'hA][15];	// tlb.scala:122:29
        sectored_entries_1_valid_2 = _RANDOM[5'hA][16];	// tlb.scala:122:29
        sectored_entries_1_valid_3 = _RANDOM[5'hA][17];	// tlb.scala:122:29
        superpage_entries_0_level = _RANDOM[5'hA][19:18];	// tlb.scala:122:29, :123:30
        superpage_entries_0_tag = {_RANDOM[5'hA][31:20], _RANDOM[5'hB][14:0]};	// tlb.scala:122:29, :123:30
        superpage_entries_0_data_0 = {_RANDOM[5'hB][31:15], _RANDOM[5'hC][16:0]};	// tlb.scala:123:30
        superpage_entries_0_valid_0 = _RANDOM[5'hC][17];	// tlb.scala:123:30
        superpage_entries_1_level = _RANDOM[5'hC][19:18];	// tlb.scala:123:30
        superpage_entries_1_tag = {_RANDOM[5'hC][31:20], _RANDOM[5'hD][14:0]};	// tlb.scala:123:30
        superpage_entries_1_data_0 = {_RANDOM[5'hD][31:15], _RANDOM[5'hE][16:0]};	// tlb.scala:123:30
        superpage_entries_1_valid_0 = _RANDOM[5'hE][17];	// tlb.scala:123:30
        superpage_entries_2_level = _RANDOM[5'hE][19:18];	// tlb.scala:123:30
        superpage_entries_2_tag = {_RANDOM[5'hE][31:20], _RANDOM[5'hF][14:0]};	// tlb.scala:123:30
        superpage_entries_2_data_0 = {_RANDOM[5'hF][31:15], _RANDOM[5'h10][16:0]};	// tlb.scala:123:30
        superpage_entries_2_valid_0 = _RANDOM[5'h10][17];	// tlb.scala:123:30
        superpage_entries_3_level = _RANDOM[5'h10][19:18];	// tlb.scala:123:30
        superpage_entries_3_tag = {_RANDOM[5'h10][31:20], _RANDOM[5'h11][14:0]};	// tlb.scala:123:30
        superpage_entries_3_data_0 = {_RANDOM[5'h11][31:15], _RANDOM[5'h12][16:0]};	// tlb.scala:123:30
        superpage_entries_3_valid_0 = _RANDOM[5'h12][17];	// tlb.scala:123:30
        special_entry_level = _RANDOM[5'h12][19:18];	// tlb.scala:123:30, :124:56
        special_entry_tag = {_RANDOM[5'h12][31:20], _RANDOM[5'h13][14:0]};	// tlb.scala:123:30, :124:56
        special_entry_data_0 = {_RANDOM[5'h13][31:15], _RANDOM[5'h14][16:0]};	// tlb.scala:124:56
        special_entry_valid_0 = _RANDOM[5'h14][17];	// tlb.scala:124:56
        state = _RANDOM[5'h14][19:18];	// tlb.scala:124:56, :129:22
        r_refill_tag = {_RANDOM[5'h14][31:20], _RANDOM[5'h15][14:0]};	// tlb.scala:124:56, :130:25
        r_superpage_repl_addr = _RANDOM[5'h15][16:15];	// tlb.scala:130:25, :131:34
        r_sectored_repl_addr = _RANDOM[5'h15][17];	// tlb.scala:130:25, :132:33
        r_sectored_hit_addr = _RANDOM[5'h15][18];	// tlb.scala:130:25, :133:32
        r_sectored_hit = _RANDOM[5'h15][19];	// tlb.scala:130:25, :134:27
        state_reg = _RANDOM[5'h15][20];	// Replacement.scala:168:70, tlb.scala:130:25
        state_reg_1 = _RANDOM[5'h15][23:21];	// Replacement.scala:168:70, tlb.scala:130:25
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  PMPChecker_10 pmp_0 (	// tlb.scala:150:40
    .io_prv
      (io_ptw_resp_valid | io_req_0_bits_passthrough ? 2'h1 : io_ptw_status_dprv),	// package.scala:15:47, tlb.scala:155:{25,50}
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
  assign io_miss_rdy = _io_miss_rdy_T;	// tlb.scala:288:24
  assign io_resp_0_miss = io_ptw_resp_valid | tlb_miss_0 | multipleHits_0;	// Misc.scala:182:49, tlb.scala:270:60, :303:50
  assign io_resp_0_paddr =
    {(hitsVec_0_0 ? _normal_entries_WIRE_1[33:14] : 20'h0)
       | (hitsVec_0_1 ? _normal_entries_WIRE_3[33:14] : 20'h0)
       | (hitsVec_0_2
            ? {superpage_entries_0_data_0[33:32],
               (ignore_1 ? io_req_0_bits_vaddr[29:21] : 9'h0)
                 | superpage_entries_0_data_0[31:23],
               io_req_0_bits_vaddr[20:12] | superpage_entries_0_data_0[22:14]}
            : 20'h0)
       | (hitsVec_0_3
            ? {superpage_entries_1_data_0[33:32],
               (ignore_4 ? io_req_0_bits_vaddr[29:21] : 9'h0)
                 | superpage_entries_1_data_0[31:23],
               io_req_0_bits_vaddr[20:12] | superpage_entries_1_data_0[22:14]}
            : 20'h0)
       | (hitsVec_0_4
            ? {superpage_entries_2_data_0[33:32],
               (ignore_7 ? io_req_0_bits_vaddr[29:21] : 9'h0)
                 | superpage_entries_2_data_0[31:23],
               io_req_0_bits_vaddr[20:12] | superpage_entries_2_data_0[22:14]}
            : 20'h0)
       | (hitsVec_0_5
            ? {superpage_entries_3_data_0[33:32],
               (ignore_10 ? io_req_0_bits_vaddr[29:21] : 9'h0)
                 | superpage_entries_3_data_0[31:23],
               io_req_0_bits_vaddr[20:12] | superpage_entries_3_data_0[22:14]}
            : 20'h0)
       | (hitsVec_0_6
            ? {special_entry_data_0[33:32],
               (ignore_13 ? io_req_0_bits_vaddr[29:21] : 9'h0)
                 | special_entry_data_0[31:23],
               (special_entry_level[1] ? 9'h0 : io_req_0_bits_vaddr[20:12])
                 | special_entry_data_0[22:14]}
            : 20'h0) | (vm_enabled_0 ? 20'h0 : io_req_0_bits_vaddr[31:12]),
     io_req_0_bits_vaddr[11:0]};	// Cat.scala:30:58, Mux.scala:27:72, tlb.scala:58:79, :66:30, :78:28, :80:31, :81:{30,49}, :107:64, :123:30, :124:56, :139:109, :142:47, :149:72, :171:69, :174:103
  assign io_resp_0_pf_ld =
    bad_va_0 & cmd_read_0
    | (|((cmd_read_0
            ? {~(r_array_lo_2[6] | special_entry_data_0[11]),
               ~(r_array_lo_2[5] | superpage_entries_3_data_0[11]),
               ~(r_array_lo_2[4] | superpage_entries_2_data_0[11]),
               ~(r_array_lo_2[3] | superpage_entries_1_data_0[11]),
               ~(r_array_lo_2[2] | superpage_entries_0_data_0[11]),
               ~(r_array_lo_2[1] | _normal_entries_WIRE_3[11]),
               ~(r_array_lo_2[0] | _normal_entries_WIRE_1[11])}
            : 7'h0) & _GEN_15));	// Cat.scala:30:58, Consts.scala:81:75, tlb.scala:58:79, :123:30, :124:56, :215:39, :217:62, :232:134, :265:{38,59,72}, :291:{38,54,73,84}
  assign io_resp_0_pf_st =
    bad_va_0 & cmd_write_perms_0
    | (|((cmd_write_perms_0
            ? {~(w_array_lo_1[6] | special_entry_data_0[11]),
               ~(w_array_lo_1[5] | superpage_entries_3_data_0[11]),
               ~(w_array_lo_1[4] | superpage_entries_2_data_0[11]),
               ~(w_array_lo_1[3] | superpage_entries_1_data_0[11]),
               ~(w_array_lo_1[2] | superpage_entries_0_data_0[11]),
               ~(w_array_lo_1[1] | _normal_entries_WIRE_3[11]),
               ~(w_array_lo_1[0] | _normal_entries_WIRE_1[11])}
            : 7'h0) & _GEN_15));	// Cat.scala:30:58, Consts.scala:82:76, tlb.scala:58:79, :123:30, :124:56, :215:39, :218:62, :232:134, :266:{38,59,72}, :292:{38,61,80,91}
  assign io_resp_0_ae_ld =
    |((cmd_read_0
         ? ae_array_0
           | ~({{2{newEntry_pr}},
                superpage_entries_3_data_0[5],
                superpage_entries_2_data_0[5],
                superpage_entries_1_data_0[5],
                superpage_entries_0_data_0[5],
                _normal_entries_WIRE_3[5],
                _normal_entries_WIRE_1[5]} & _px_array_T_2)
         : 8'h0) & hits_0);	// Bitwise.scala:72:12, Cat.scala:30:58, Consts.scala:81:75, tlb.scala:58:79, :123:30, :162:60, :220:114, :252:43, :254:{38,64,66}, :262:32, :294:{43,54}
  assign io_resp_0_ae_st =
    |(((cmd_write_perms_0
          ? ae_array_0
            | ~({{2{newEntry_pw}},
                 superpage_entries_3_data_0[7],
                 superpage_entries_2_data_0[7],
                 superpage_entries_1_data_0[7],
                 superpage_entries_0_data_0[7],
                 _normal_entries_WIRE_3[7],
                 _normal_entries_WIRE_1[7]} & _px_array_T_2)
          : 8'h0)
       | (_cmd_write_T_5 | _cmd_write_T_6 | _cmd_write_T_7 | _cmd_write_T_8
            ? ~({{2{newEntry_pal}},
                 superpage_entries_3_data_0[4],
                 superpage_entries_2_data_0[4],
                 superpage_entries_1_data_0[4],
                 superpage_entries_0_data_0[4],
                 _normal_entries_WIRE_3[4],
                 _normal_entries_WIRE_1[4]} | lrscAllowed_0)
            : 8'h0)
       | (_cmd_write_T_12 | _cmd_write_T_13 | _cmd_write_T_14 | _cmd_write_T_15
          | _cmd_write_T_16
            ? ~({{2{newEntry_paa}},
                 superpage_entries_3_data_0[3],
                 superpage_entries_2_data_0[3],
                 superpage_entries_1_data_0[3],
                 superpage_entries_0_data_0[3],
                 _normal_entries_WIRE_3[3],
                 _normal_entries_WIRE_1[3]} | lrscAllowed_0)
            : 8'h0)) & hits_0);	// Bitwise.scala:72:12, Cat.scala:30:58, Consts.scala:82:76, package.scala:15:47, :72:59, tlb.scala:58:79, :123:30, :159:22, :163:64, :221:114, :227:56, :228:56, :252:43, :256:{8,44,46}, :257:{8,32,62}, :258:{8,32}, :262:32, :295:{43,54}
  assign io_resp_0_ma_ld = |(((|_GEN_14) & cmd_read_0 ? ~eff_array_0 : 8'h0) & hits_0);	// Cat.scala:30:58, Consts.scala:81:75, tlb.scala:231:{56,97}, :262:32, :263:{38,53,70}, :297:{43,54}
  assign io_resp_0_ma_st =
    |(((|_GEN_14) & cmd_write_perms_0 ? ~eff_array_0 : 8'h0) & hits_0);	// Cat.scala:30:58, Consts.scala:82:76, tlb.scala:231:{56,97}, :262:32, :263:70, :264:{38,53}, :298:{43,54}
  assign io_resp_0_cacheable = |(lrscAllowed_0 & hits_0);	// Cat.scala:30:58, tlb.scala:300:{44,55}
  assign io_ptw_req_valid = _io_ptw_req_valid_T;	// package.scala:15:47
  assign io_ptw_req_bits_valid = ~io_kill;	// tlb.scala:308:28
  assign io_ptw_req_bits_bits_addr = r_refill_tag;	// tlb.scala:130:25
endmodule

