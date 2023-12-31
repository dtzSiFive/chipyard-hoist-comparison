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

module TLB_2(
  input         clock,
                reset,
                io_req_valid,
  input  [39:0] io_req_bits_vaddr,
  input         io_req_bits_passthrough,
  input  [1:0]  io_req_bits_size,
  input  [4:0]  io_req_bits_cmd,
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
  input         io_ptw_status_debug,
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
  output        io_req_ready,
                io_resp_miss,
  output [31:0] io_resp_paddr,
  output        io_resp_pf_ld,
                io_resp_pf_st,
                io_resp_ae_ld,
                io_resp_ae_st,
                io_resp_ma_ld,
                io_resp_ma_st,
                io_resp_cacheable,
                io_resp_must_alloc,
                io_ptw_req_valid,
  output [26:0] io_ptw_req_bits_bits_addr
);

  wire             _pmp_io_r;	// TLB.scala:193:19
  wire             _pmp_io_w;	// TLB.scala:193:19
  wire             _pmp_io_x;	// TLB.scala:193:19
  reg  [26:0]      sectored_entries_0_0_tag;	// TLB.scala:165:29
  reg  [34:0]      sectored_entries_0_0_data_0;	// TLB.scala:165:29
  reg  [34:0]      sectored_entries_0_0_data_1;	// TLB.scala:165:29
  reg  [34:0]      sectored_entries_0_0_data_2;	// TLB.scala:165:29
  reg  [34:0]      sectored_entries_0_0_data_3;	// TLB.scala:165:29
  reg              sectored_entries_0_0_valid_0;	// TLB.scala:165:29
  reg              sectored_entries_0_0_valid_1;	// TLB.scala:165:29
  reg              sectored_entries_0_0_valid_2;	// TLB.scala:165:29
  reg              sectored_entries_0_0_valid_3;	// TLB.scala:165:29
  reg  [1:0]       superpage_entries_0_level;	// TLB.scala:166:30
  reg  [26:0]      superpage_entries_0_tag;	// TLB.scala:166:30
  reg  [34:0]      superpage_entries_0_data_0;	// TLB.scala:166:30
  reg              superpage_entries_0_valid_0;	// TLB.scala:166:30
  reg  [1:0]       superpage_entries_1_level;	// TLB.scala:166:30
  reg  [26:0]      superpage_entries_1_tag;	// TLB.scala:166:30
  reg  [34:0]      superpage_entries_1_data_0;	// TLB.scala:166:30
  reg              superpage_entries_1_valid_0;	// TLB.scala:166:30
  reg  [1:0]       superpage_entries_2_level;	// TLB.scala:166:30
  reg  [26:0]      superpage_entries_2_tag;	// TLB.scala:166:30
  reg  [34:0]      superpage_entries_2_data_0;	// TLB.scala:166:30
  reg              superpage_entries_2_valid_0;	// TLB.scala:166:30
  reg  [1:0]       superpage_entries_3_level;	// TLB.scala:166:30
  reg  [26:0]      superpage_entries_3_tag;	// TLB.scala:166:30
  reg  [34:0]      superpage_entries_3_data_0;	// TLB.scala:166:30
  reg              superpage_entries_3_valid_0;	// TLB.scala:166:30
  reg  [1:0]       special_entry_level;	// TLB.scala:167:56
  reg  [26:0]      special_entry_tag;	// TLB.scala:167:56
  reg  [34:0]      special_entry_data_0;	// TLB.scala:167:56
  reg              special_entry_valid_0;	// TLB.scala:167:56
  reg  [1:0]       state;	// TLB.scala:173:18
  reg  [26:0]      r_refill_tag;	// TLB.scala:174:25
  reg  [1:0]       r_superpage_repl_addr;	// TLB.scala:175:34
  reg              r_sectored_hit;	// TLB.scala:178:27
  wire             vm_enabled =
    io_ptw_ptbr_mode[3] & ~(io_ptw_status_dprv[1]) & ~io_req_bits_passthrough;	// TLB.scala:182:27, :183:{53,99,102}
  wire             _io_ptw_req_valid_T = state == 2'h1;	// TLB.scala:173:18, package.scala:15:47
  wire             ignore_13 = special_entry_level == 2'h0;	// TLB.scala:108:28, :167:56, :173:18
  wire [27:0]      mpu_ppn =
    io_ptw_resp_valid
      ? {8'h0, io_ptw_resp_bits_pte_ppn[19:0]}
      : vm_enabled
          ? {8'h0,
             special_entry_data_0[34:33],
             (ignore_13 ? io_req_bits_vaddr[29:21] : 9'h0) | special_entry_data_0[32:24],
             (special_entry_level[1] ? 9'h0 : io_req_bits_vaddr[20:12])
               | special_entry_data_0[23:15]}
          : io_req_bits_vaddr[39:12];	// TLB.scala:86:77, :106:26, :108:28, :109:{28,47}, :135:61, :163:30, :167:56, :183:99, :186:44, :189:20, :190:{20,123}
  wire [2:0]       mpu_priv =
    io_ptw_resp_valid | io_req_bits_passthrough
      ? 3'h1
      : {io_ptw_status_debug, io_ptw_status_dprv};	// Cat.scala:30:58, TLB.scala:192:{27,56}
  wire [13:0]      _GEN = mpu_ppn[13:0] ^ 14'h2010;	// Parameters.scala:137:31, TLB.scala:189:20
  wire [9:0]       _GEN_0 = mpu_ppn[13:4] ^ 10'h200;	// Parameters.scala:137:31, TLB.scala:189:20
  wire [3:0]       _GEN_1 = mpu_ppn[19:16] ^ 4'h8;	// Parameters.scala:137:31, TLB.scala:189:20, :194:15
  wire [16:0]      _GEN_2 = mpu_ppn[16:0] ^ 17'h10000;	// Parameters.scala:137:{31,52}, TLB.scala:189:20
  wire [1:0]       _GEN_3 = mpu_ppn[5:4] ^ 2'h2;	// Parameters.scala:137:31, TLB.scala:108:28, :189:20
  wire             legal_address =
    {mpu_ppn[27:2], ~(mpu_ppn[1:0])} == 28'h0 | {mpu_ppn[27:14], _GEN} == 28'h0
    | {mpu_ppn[27:3], mpu_ppn[2:0] ^ 3'h4} == 28'h0
    | {mpu_ppn[27:19], mpu_ppn[18:0] ^ 19'h54000} == 28'h0
    | {mpu_ppn[27:9], mpu_ppn[8:0] ^ 9'h100} == 28'h0
    | {mpu_ppn[27:16], ~(mpu_ppn[15:14])} == 14'h0 | {mpu_ppn[27:14], _GEN_0} == 24'h0
    | ~(|mpu_ppn) | {mpu_ppn[27:5], ~(mpu_ppn[4])} == 24'h0
    | {mpu_ppn[27:20], _GEN_1} == 12'h0 | {mpu_ppn[27:17], _GEN_2} == 28'h0
    | {mpu_ppn[27:6], _GEN_3} == 24'h0;	// Parameters.scala:137:{31,49,52,67}, TLB.scala:189:20, :198:67
  wire [3:0]       _GEN_4 = mpu_ppn[16:13] ^ 4'hA;	// Parameters.scala:137:31, TLB.scala:189:20
  wire [1:0]       _GEN_5 = {_GEN_1[3], mpu_ppn[16]};	// Parameters.scala:137:{31,49,52}, TLB.scala:189:20
  wire             newEntry_c =
    legal_address & ({mpu_ppn[19], _GEN_2[16], mpu_ppn[14:13]} == 4'h0 | ~(|_GEN_5));	// Parameters.scala:137:{31,49,52,67}, :615:89, TLB.scala:189:20, :198:67, :200:19, :283:69
  wire             deny_access_to_debug = ~(mpu_priv[2]) & ~(|mpu_ppn);	// Parameters.scala:137:{49,52,67}, TLB.scala:189:20, :192:27, :203:{39,48}
  wire             newEntry_pr = legal_address & ~deny_access_to_debug & _pmp_io_r;	// TLB.scala:193:19, :198:67, :203:48, :204:{44,66}
  wire [5:0]       _GEN_6 = {mpu_ppn[19], mpu_ppn[16:15], mpu_ppn[13], mpu_ppn[5:4]};	// Parameters.scala:137:{31,49,52}, TLB.scala:189:20
  wire [5:0]       _GEN_7 =
    {mpu_ppn[19], mpu_ppn[16:15], _GEN_0[9], mpu_ppn[8], mpu_ppn[5]};	// Parameters.scala:137:{31,49,52}, TLB.scala:189:20
  wire [2:0]       _GEN_8 = {mpu_ppn[19], mpu_ppn[16], ~(mpu_ppn[15])};	// Parameters.scala:137:{31,49,52}, TLB.scala:189:20
  wire [6:0]       _GEN_9 =
    {mpu_ppn[19], _GEN_2[16:15], mpu_ppn[13], mpu_ppn[8], mpu_ppn[5:4]};	// Parameters.scala:137:{31,49,52}, TLB.scala:189:20
  wire             newEntry_pw =
    legal_address & (~(|_GEN_6) | ~(|_GEN_7) | ~(|_GEN_8) | ~(|_GEN_9) | ~(|_GEN_5))
    & ~deny_access_to_debug & _pmp_io_w;	// Parameters.scala:137:{49,52,67}, :615:89, TLB.scala:193:19, :198:67, :203:48, :204:44, :205:70
  wire             newEntry_ppp =
    legal_address & (~(|_GEN_6) | ~(|_GEN_7) | ~(|_GEN_8) | ~(|_GEN_9) | ~(|_GEN_5));	// Parameters.scala:137:{49,52,67}, :615:89, TLB.scala:198:67, :200:19
  wire             newEntry_pal =
    legal_address & (~(|_GEN_6) | ~(|_GEN_7) | ~(|_GEN_8) | ~(|_GEN_9) | ~(|_GEN_5));	// Parameters.scala:137:{49,52,67}, :615:89, TLB.scala:198:67, :200:19
  wire             newEntry_paa =
    legal_address & (~(|_GEN_6) | ~(|_GEN_7) | ~(|_GEN_8) | ~(|_GEN_9) | ~(|_GEN_5));	// Parameters.scala:137:{49,52,67}, :615:89, TLB.scala:198:67, :200:19
  wire             newEntry_eff =
    legal_address
    & ({mpu_ppn[19], mpu_ppn[16], mpu_ppn[14:13], mpu_ppn[5:4], mpu_ppn[1]} == 7'h0
       | {mpu_ppn[19],
          mpu_ppn[16],
          mpu_ppn[14],
          _GEN_0[9],
          mpu_ppn[8],
          mpu_ppn[5:4]} == 7'h0
       | {mpu_ppn[19],
          mpu_ppn[16],
          mpu_ppn[14],
          _GEN[13],
          mpu_ppn[8],
          _GEN[5:4],
          mpu_ppn[1]} == 8'h0 | {mpu_ppn[19], mpu_ppn[16], ~(mpu_ppn[14])} == 3'h0
       | {mpu_ppn[19],
          _GEN_4[3],
          _GEN_4[1:0],
          mpu_ppn[8],
          mpu_ppn[5:4],
          mpu_ppn[1]} == 8'h0);	// Parameters.scala:137:{31,49,52,67}, :615:89, Replacement.scala:168:70, TLB.scala:189:20, :190:20, :198:67, :200:19, :317:19
  wire [24:0]      _hitsVec_T = sectored_entries_0_0_tag[26:2] ^ io_req_bits_vaddr[38:14];	// TLB.scala:88:41, :163:30, :165:29
  wire             ignore_1 = superpage_entries_0_level == 2'h0;	// TLB.scala:94:28, :166:30, :173:18
  wire             ignore_4 = superpage_entries_1_level == 2'h0;	// TLB.scala:94:28, :166:30, :173:18
  wire             ignore_7 = superpage_entries_2_level == 2'h0;	// TLB.scala:94:28, :166:30, :173:18
  wire             ignore_10 = superpage_entries_3_level == 2'h0;	// TLB.scala:94:28, :166:30, :173:18
  wire [3:0]       _GEN_10 =
    {{sectored_entries_0_0_valid_3},
     {sectored_entries_0_0_valid_2},
     {sectored_entries_0_0_valid_1},
     {sectored_entries_0_0_valid_0}};	// TLB.scala:100:18, :165:29
  wire             hitsVec_0 =
    vm_enabled & _GEN_10[io_req_bits_vaddr[13:12]] & _hitsVec_T == 25'h0;	// TLB.scala:88:{41,66}, :100:18, :163:30, :183:99, :214:44, package.scala:154:13
  wire             hitsVec_1 =
    vm_enabled & superpage_entries_0_valid_0
    & superpage_entries_0_tag[26:18] == io_req_bits_vaddr[38:30]
    & (ignore_1 | superpage_entries_0_tag[17:9] == io_req_bits_vaddr[29:21]);	// TLB.scala:94:28, :95:{40,46,77,84}, :163:30, :166:30, :183:99, :214:44
  wire             hitsVec_2 =
    vm_enabled & superpage_entries_1_valid_0
    & superpage_entries_1_tag[26:18] == io_req_bits_vaddr[38:30]
    & (ignore_4 | superpage_entries_1_tag[17:9] == io_req_bits_vaddr[29:21]);	// TLB.scala:94:28, :95:{40,46,77,84}, :163:30, :166:30, :183:99, :214:44
  wire             hitsVec_3 =
    vm_enabled & superpage_entries_2_valid_0
    & superpage_entries_2_tag[26:18] == io_req_bits_vaddr[38:30]
    & (ignore_7 | superpage_entries_2_tag[17:9] == io_req_bits_vaddr[29:21]);	// TLB.scala:94:28, :95:{40,46,77,84}, :163:30, :166:30, :183:99, :214:44
  wire             hitsVec_4 =
    vm_enabled & superpage_entries_3_valid_0
    & superpage_entries_3_tag[26:18] == io_req_bits_vaddr[38:30]
    & (ignore_10 | superpage_entries_3_tag[17:9] == io_req_bits_vaddr[29:21]);	// TLB.scala:94:28, :95:{40,46,77,84}, :163:30, :166:30, :183:99, :214:44
  wire             hitsVec_5 =
    vm_enabled & special_entry_valid_0
    & special_entry_tag[26:18] == io_req_bits_vaddr[38:30]
    & (ignore_13 | special_entry_tag[17:9] == io_req_bits_vaddr[29:21])
    & (~(special_entry_level[1]) | special_entry_tag[8:0] == io_req_bits_vaddr[20:12]);	// TLB.scala:95:{40,46,77,84}, :108:28, :163:30, :167:56, :183:99, :214:44
  wire [6:0]       hits =
    {~vm_enabled, hitsVec_5, hitsVec_4, hitsVec_3, hitsVec_2, hitsVec_1, hitsVec_0};	// Cat.scala:30:58, TLB.scala:183:99, :214:44, :216:18
  wire [3:0][34:0] _GEN_11 =
    {{sectored_entries_0_0_data_3},
     {sectored_entries_0_0_data_2},
     {sectored_entries_0_0_data_1},
     {sectored_entries_0_0_data_0}};	// TLB.scala:165:29
  wire [34:0]      _normal_entries_WIRE_1 = _GEN_11[io_req_bits_vaddr[13:12]];	// TLB.scala:163:30, package.scala:154:13
  wire [5:0]       priv_rw_ok =
    (~(io_ptw_status_dprv[0]) | io_ptw_status_sum
       ? {special_entry_data_0[14],
          superpage_entries_3_data_0[14],
          superpage_entries_2_data_0[14],
          superpage_entries_1_data_0[14],
          superpage_entries_0_data_0[14],
          _normal_entries_WIRE_1[14]}
       : 6'h0)
    | (io_ptw_status_dprv[0]
         ? ~{special_entry_data_0[14],
             superpage_entries_3_data_0[14],
             superpage_entries_2_data_0[14],
             superpage_entries_1_data_0[14],
             superpage_entries_0_data_0[14],
             _normal_entries_WIRE_1[14]}
         : 6'h0);	// Cat.scala:30:58, TLB.scala:86:77, :166:30, :167:56, :181:20, :265:{23,24,32,84,89,98}
  wire [5:0]       r_array_lo_2 =
    priv_rw_ok
    & ({special_entry_data_0[9],
        superpage_entries_3_data_0[9],
        superpage_entries_2_data_0[9],
        superpage_entries_1_data_0[9],
        superpage_entries_0_data_0[9],
        _normal_entries_WIRE_1[9]}
       | (io_ptw_status_mxr
            ? {special_entry_data_0[10],
               superpage_entries_3_data_0[10],
               superpage_entries_2_data_0[10],
               superpage_entries_1_data_0[10],
               superpage_entries_0_data_0[10],
               _normal_entries_WIRE_1[10]}
            : 6'h0));	// Cat.scala:30:58, TLB.scala:86:77, :166:30, :167:56, :265:{23,84}, :267:{40,68,73}
  wire [5:0]       w_array_lo_1 =
    priv_rw_ok
    & {special_entry_data_0[11],
       superpage_entries_3_data_0[11],
       superpage_entries_2_data_0[11],
       superpage_entries_1_data_0[11],
       superpage_entries_0_data_0[11],
       _normal_entries_WIRE_1[11]};	// Cat.scala:30:58, TLB.scala:86:77, :166:30, :167:56, :265:84, :268:40
  wire [6:0]       _px_array_T_2 =
    {1'h1,
     ~(special_entry_data_0[12]),
     ~(superpage_entries_3_data_0[12]),
     ~(superpage_entries_2_data_0[12]),
     ~(superpage_entries_1_data_0[12]),
     ~(superpage_entries_0_data_0[12]),
     ~(_normal_entries_WIRE_1[12])};	// Cat.scala:30:58, TLB.scala:86:77, :166:30, :167:56, :182:27, :270:89
  wire [6:0]       eff_array =
    {{2{newEntry_eff}},
     superpage_entries_3_data_0[2],
     superpage_entries_2_data_0[2],
     superpage_entries_1_data_0[2],
     superpage_entries_0_data_0[2],
     _normal_entries_WIRE_1[2]};	// Bitwise.scala:72:12, Cat.scala:30:58, TLB.scala:86:77, :166:30, :200:19
  wire [6:0]       lrscAllowed =
    {{2{newEntry_c}},
     superpage_entries_3_data_0[1],
     superpage_entries_2_data_0[1],
     superpage_entries_1_data_0[1],
     superpage_entries_0_data_0[1],
     _normal_entries_WIRE_1[1]};	// Bitwise.scala:72:12, Cat.scala:30:58, TLB.scala:86:77, :166:30, :200:19
  wire [6:0]       ppp_array =
    {{2{newEntry_ppp}},
     superpage_entries_3_data_0[5],
     superpage_entries_2_data_0[5],
     superpage_entries_1_data_0[5],
     superpage_entries_0_data_0[5],
     _normal_entries_WIRE_1[5]};	// Bitwise.scala:72:12, Cat.scala:30:58, TLB.scala:86:77, :166:30, :200:19
  wire [6:0]       paa_array =
    {{2{newEntry_paa}},
     superpage_entries_3_data_0[3],
     superpage_entries_2_data_0[3],
     superpage_entries_1_data_0[3],
     superpage_entries_0_data_0[3],
     _normal_entries_WIRE_1[3]};	// Bitwise.scala:72:12, Cat.scala:30:58, TLB.scala:86:77, :166:30, :200:19
  wire [6:0]       pal_array =
    {{2{newEntry_pal}},
     superpage_entries_3_data_0[4],
     superpage_entries_2_data_0[4],
     superpage_entries_1_data_0[4],
     superpage_entries_0_data_0[4],
     _normal_entries_WIRE_1[4]};	// Bitwise.scala:72:12, Cat.scala:30:58, TLB.scala:86:77, :166:30, :200:19
  wire [3:0]       _GEN_12 = io_req_bits_vaddr[3:0] & (4'h1 << io_req_bits_size) - 4'h1;	// OneHot.scala:58:35, TLB.scala:283:{39,69}
  wire             bad_va =
    vm_enabled & ~(io_req_bits_vaddr[39:38] == 2'h0 | (&(io_req_bits_vaddr[39:38])));	// TLB.scala:173:18, :183:99, :284:117, :289:43, :290:{47,61,67,82}
  wire             _cmd_read_T_1 = io_req_bits_cmd == 5'h6;	// package.scala:15:47
  wire             _cmd_write_T_3 = io_req_bits_cmd == 5'h7;	// package.scala:15:47
  wire             cmd_lrsc = _cmd_read_T_1 | _cmd_write_T_3;	// package.scala:15:47, :72:59
  wire             _cmd_write_T_5 = io_req_bits_cmd == 5'h4;	// package.scala:15:47
  wire             _cmd_write_T_6 = io_req_bits_cmd == 5'h9;	// package.scala:15:47
  wire             _cmd_write_T_7 = io_req_bits_cmd == 5'hA;	// package.scala:15:47
  wire             _cmd_write_T_8 = io_req_bits_cmd == 5'hB;	// package.scala:15:47
  wire             cmd_amo_logical =
    _cmd_write_T_5 | _cmd_write_T_6 | _cmd_write_T_7 | _cmd_write_T_8;	// package.scala:15:47, :72:59
  wire             _cmd_write_T_12 = io_req_bits_cmd == 5'h8;	// package.scala:15:47
  wire             _cmd_write_T_13 = io_req_bits_cmd == 5'hC;	// package.scala:15:47
  wire             _cmd_write_T_14 = io_req_bits_cmd == 5'hD;	// package.scala:15:47
  wire             _cmd_write_T_15 = io_req_bits_cmd == 5'hE;	// package.scala:15:47
  wire             _cmd_write_T_16 = io_req_bits_cmd == 5'hF;	// package.scala:15:47
  wire             cmd_amo_arithmetic =
    _cmd_write_T_12 | _cmd_write_T_13 | _cmd_write_T_14 | _cmd_write_T_15
    | _cmd_write_T_16;	// package.scala:15:47, :72:59
  wire             cmd_put_partial = io_req_bits_cmd == 5'h11;	// TLB.scala:297:41
  wire             cmd_read =
    io_req_bits_cmd == 5'h0 | _cmd_read_T_1 | _cmd_write_T_3 | _cmd_write_T_5
    | _cmd_write_T_6 | _cmd_write_T_7 | _cmd_write_T_8 | _cmd_write_T_12 | _cmd_write_T_13
    | _cmd_write_T_14 | _cmd_write_T_15 | _cmd_write_T_16;	// Consts.scala:81:{31,75}, package.scala:15:47
  wire             cmd_write =
    io_req_bits_cmd == 5'h1 | cmd_put_partial | _cmd_write_T_3 | _cmd_write_T_5
    | _cmd_write_T_6 | _cmd_write_T_7 | _cmd_write_T_8 | _cmd_write_T_12 | _cmd_write_T_13
    | _cmd_write_T_14 | _cmd_write_T_15 | _cmd_write_T_16;	// Consts.scala:82:{32,76}, TLB.scala:297:41, package.scala:15:47
  wire             cmd_write_perms =
    cmd_write | io_req_bits_cmd == 5'h5 | io_req_bits_cmd == 5'h17;	// Consts.scala:82:76, TLB.scala:300:35, package.scala:15:47
  wire [6:0]       ae_array =
    ((|_GEN_12) ? eff_array : 7'h0) | (cmd_lrsc ? ~lrscAllowed : 7'h0);	// Cat.scala:30:58, TLB.scala:283:{39,75}, :305:{8,37}, :306:{8,19}, :317:19, package.scala:72:59
  wire             tlb_miss =
    vm_enabled & ~bad_va
    & {hitsVec_5, hitsVec_4, hitsVec_3, hitsVec_2, hitsVec_1, hitsVec_0} == 6'h0;	// Cat.scala:30:58, TLB.scala:183:99, :214:44, :265:23, :284:117, :324:27, :325:{32,40}
  reg  [2:0]       state_reg_1;	// Replacement.scala:168:70
  wire             multipleHits_rightOne_1 = hitsVec_1 | hitsVec_2;	// Misc.scala:182:16, TLB.scala:214:44
  wire             multipleHits_rightOne_3 = hitsVec_4 | hitsVec_5;	// Misc.scala:182:16, TLB.scala:214:44
  wire             multipleHits =
    hitsVec_1 & hitsVec_2 | hitsVec_0 & multipleHits_rightOne_1 | hitsVec_4 & hitsVec_5
    | hitsVec_3 & multipleHits_rightOne_3 | (hitsVec_0 | multipleHits_rightOne_1)
    & (hitsVec_3 | multipleHits_rightOne_3);	// Misc.scala:182:{16,49,61}, TLB.scala:214:44
  wire             _io_req_ready_output = state == 2'h0;	// TLB.scala:173:18, :341:25
  wire [5:0]       _GEN_13 =
    {hitsVec_5, hitsVec_4, hitsVec_3, hitsVec_2, hitsVec_1, hitsVec_0};	// Cat.scala:30:58, TLB.scala:214:44
  `ifndef SYNTHESIS	// TLB.scala:385:13
    always @(posedge clock) begin	// TLB.scala:385:13
      if (io_sfence_valid
          & ~(~io_sfence_bits_rs1 | io_sfence_bits_addr[38:12] == io_req_bits_vaddr[38:12]
              | reset)) begin	// TLB.scala:163:30, :385:{13,14,58,72}
        if (`ASSERT_VERBOSE_COND_)	// TLB.scala:385:13
          $error("Assertion failed\n    at TLB.scala:385 assert(!io.sfence.bits.rs1 || (io.sfence.bits.addr >> pgIdxBits) === vpn)\n");	// TLB.scala:385:13
        if (`STOP_COND_)	// TLB.scala:385:13
          $fatal;	// TLB.scala:385:13
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge clock) begin
    automatic logic        invalidate_refill;	// TLB.scala:188:88
    automatic logic        newEntry_px;	// TLB.scala:209:65
    automatic logic        newEntry_g;	// TLB.scala:226:25
    automatic logic        newEntry_sr;	// PTW.scala:77:35
    automatic logic        newEntry_sw;	// PTW.scala:78:40
    automatic logic        newEntry_sx;	// PTW.scala:79:35
    automatic logic        _GEN_14 = io_ptw_resp_valid & ~io_ptw_resp_bits_homogeneous;	// TLB.scala:118:14, :167:56, :220:20, :240:{37,68}
    automatic logic        _GEN_15;	// TLB.scala:167:56, :220:20, :240:68, :243:34
    automatic logic        _GEN_16;	// TLB.scala:166:30, :220:20, :240:68
    automatic logic        _GEN_17;	// TLB.scala:166:30, :220:20, :240:68
    automatic logic        _GEN_18;	// TLB.scala:166:30, :220:20, :240:68
    automatic logic        _GEN_19;	// TLB.scala:166:30, :220:20, :240:68
    automatic logic        _GEN_20;	// TLB.scala:166:30, :220:20, :240:68
    automatic logic        _GEN_21;	// TLB.scala:166:30, :220:20, :240:68
    automatic logic        _GEN_22;	// TLB.scala:166:30, :220:20, :240:68
    automatic logic        _GEN_23;	// TLB.scala:166:30, :220:20, :240:68
    automatic logic        _GEN_24 =
      ~io_ptw_resp_bits_homogeneous | ~(io_ptw_resp_bits_level[1]);	// TLB.scala:165:29, :240:{37,68}, :245:{40,54}, :253:82
    automatic logic        _GEN_25 = ~io_ptw_resp_valid | _GEN_24;	// TLB.scala:165:29, :220:20, :240:68, :245:54, :253:82
    automatic logic        _GEN_26;	// TLB.scala:122:16
    automatic logic        _GEN_27;	// TLB.scala:122:16
    automatic logic        _GEN_28;	// TLB.scala:122:16
    automatic logic [34:0] _sectored_entries_0_0_data_T;	// TLB.scala:123:24
    automatic logic        _GEN_29;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_30;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_31;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_32;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_33;	// TLB.scala:363:25
    automatic logic [24:0] _GEN_34;	// TLB.scala:88:41
    automatic logic        _GEN_35;	// TLB.scala:88:66
    automatic logic        _GEN_36;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_37;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_38;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_39;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_40;	// TLB.scala:135:61
    automatic logic        _GEN_41 = multipleHits | reset;	// Misc.scala:182:49, TLB.scala:392:24
    invalidate_refill = _io_ptw_req_valid_T | (&state) | io_sfence_valid;	// TLB.scala:173:18, :188:88, package.scala:15:47
    newEntry_px =
      legal_address
      & ({mpu_ppn[19], mpu_ppn[14:13], mpu_ppn[8], mpu_ppn[5:4], mpu_ppn[2]} == 7'h0
         | {mpu_ppn[19],
            mpu_ppn[16],
            mpu_ppn[14:13],
            mpu_ppn[8],
            mpu_ppn[5],
            ~(mpu_ppn[4])} == 7'h0
         | {mpu_ppn[19], mpu_ppn[16], mpu_ppn[14:13], mpu_ppn[8], _GEN_3} == 7'h0
         | ~(|_GEN_5)) & ~deny_access_to_debug & _pmp_io_x;	// Parameters.scala:137:{31,49,52,67}, :615:89, TLB.scala:189:20, :193:19, :198:67, :203:48, :204:44, :209:65, :317:19
    newEntry_g = io_ptw_resp_bits_pte_g & io_ptw_resp_bits_pte_v;	// TLB.scala:226:25
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
    _GEN_15 = _GEN_14 ? ~invalidate_refill : special_entry_valid_0;	// TLB.scala:118:14, :122:16, :126:46, :165:29, :167:56, :182:27, :188:88, :220:20, :240:68, :243:34
    _GEN_16 =
      io_ptw_resp_valid & io_ptw_resp_bits_homogeneous & ~(io_ptw_resp_bits_level[1])
      & r_superpage_repl_addr == 2'h0;	// TLB.scala:166:30, :173:18, :175:34, :220:20, :240:68, :245:40, :246:82
    _GEN_17 = _GEN_16 ? ~invalidate_refill : superpage_entries_0_valid_0;	// TLB.scala:122:16, :126:46, :165:29, :166:30, :182:27, :188:88, :220:20, :240:68, :243:34
    _GEN_18 =
      io_ptw_resp_valid & io_ptw_resp_bits_homogeneous & ~(io_ptw_resp_bits_level[1])
      & r_superpage_repl_addr == 2'h1;	// TLB.scala:166:30, :175:34, :220:20, :240:68, :245:40, :246:82, package.scala:15:47
    _GEN_19 = _GEN_18 ? ~invalidate_refill : superpage_entries_1_valid_0;	// TLB.scala:122:16, :126:46, :165:29, :166:30, :182:27, :188:88, :220:20, :240:68, :243:34
    _GEN_20 =
      io_ptw_resp_valid & io_ptw_resp_bits_homogeneous & ~(io_ptw_resp_bits_level[1])
      & r_superpage_repl_addr == 2'h2;	// TLB.scala:108:28, :166:30, :175:34, :220:20, :240:68, :245:40, :246:82
    _GEN_21 = _GEN_20 ? ~invalidate_refill : superpage_entries_2_valid_0;	// TLB.scala:122:16, :126:46, :165:29, :166:30, :182:27, :188:88, :220:20, :240:68, :243:34
    _GEN_22 =
      io_ptw_resp_valid & io_ptw_resp_bits_homogeneous & ~(io_ptw_resp_bits_level[1])
      & (&r_superpage_repl_addr);	// TLB.scala:166:30, :175:34, :220:20, :240:68, :245:40, :246:82
    _GEN_23 = _GEN_22 ? ~invalidate_refill : superpage_entries_3_valid_0;	// TLB.scala:122:16, :126:46, :165:29, :166:30, :182:27, :188:88, :220:20, :240:68, :243:34
    _GEN_26 = r_refill_tag[1:0] == 2'h0;	// TLB.scala:122:16, :173:18, :174:25, package.scala:154:13
    _GEN_27 = r_refill_tag[1:0] == 2'h1;	// TLB.scala:122:16, :174:25, package.scala:15:47, :154:13
    _GEN_28 = r_refill_tag[1:0] == 2'h2;	// TLB.scala:108:28, :122:16, :174:25, package.scala:154:13
    _sectored_entries_0_0_data_T =
      {io_ptw_resp_bits_pte_ppn[19:0],
       io_ptw_resp_bits_pte_u,
       newEntry_g,
       io_ptw_resp_bits_ae,
       newEntry_sw,
       newEntry_sx,
       newEntry_sr,
       newEntry_pw,
       newEntry_px,
       newEntry_pr,
       newEntry_ppp,
       newEntry_pal,
       newEntry_paa,
       newEntry_eff,
       newEntry_c,
       1'h0};	// PTW.scala:77:35, :78:40, :79:35, TLB.scala:123:24, :200:19, :204:66, :205:70, :209:65, :223:18, :226:25
    _GEN_29 =
      _GEN_25
        ? sectored_entries_0_0_valid_0
        : ~invalidate_refill & (_GEN_26 | r_sectored_hit & sectored_entries_0_0_valid_0);	// TLB.scala:122:16, :126:46, :165:29, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34
    _GEN_30 =
      _GEN_25
        ? sectored_entries_0_0_valid_1
        : ~invalidate_refill & (_GEN_27 | r_sectored_hit & sectored_entries_0_0_valid_1);	// TLB.scala:122:16, :126:46, :165:29, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34
    _GEN_31 =
      _GEN_25
        ? sectored_entries_0_0_valid_2
        : ~invalidate_refill & (_GEN_28 | r_sectored_hit & sectored_entries_0_0_valid_2);	// TLB.scala:122:16, :126:46, :165:29, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34
    _GEN_32 =
      _GEN_25
        ? sectored_entries_0_0_valid_3
        : ~invalidate_refill
          & ((&(r_refill_tag[1:0])) | r_sectored_hit & sectored_entries_0_0_valid_3);	// TLB.scala:122:16, :126:46, :165:29, :174:25, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34, package.scala:154:13
    _GEN_33 = _io_req_ready_output & io_req_valid & tlb_miss;	// TLB.scala:325:40, :341:25, :363:25
    _GEN_34 = sectored_entries_0_0_tag[26:2] ^ io_req_bits_vaddr[38:14];	// TLB.scala:88:41, :163:30, :165:29
    _GEN_35 = _GEN_34 == 25'h0;	// TLB.scala:88:{41,66}
    _GEN_36 = _GEN_35 & io_req_bits_vaddr[13:12] == 2'h0;	// TLB.scala:88:66, :131:{34,58}, :163:30, :173:18, :220:20, package.scala:154:13
    _GEN_37 = _GEN_35 & io_req_bits_vaddr[13:12] == 2'h1;	// TLB.scala:88:66, :131:{34,58}, :163:30, :220:20, package.scala:15:47, :154:13
    _GEN_38 = _GEN_35 & io_req_bits_vaddr[13:12] == 2'h2;	// TLB.scala:88:66, :108:28, :131:{34,58}, :163:30, :220:20, package.scala:154:13
    _GEN_39 = _GEN_35 & (&(io_req_bits_vaddr[13:12]));	// TLB.scala:88:66, :131:{34,58}, :163:30, :220:20, package.scala:154:13
    _GEN_40 = _GEN_34[24:16] == 9'h0;	// TLB.scala:88:41, :135:{26,61}
    if (_GEN_25) begin	// TLB.scala:165:29, :220:20, :240:68
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_0_tag <= r_refill_tag;	// TLB.scala:165:29, :174:25
    if (~io_ptw_resp_valid | _GEN_24 | ~_GEN_26) begin	// TLB.scala:122:16, :165:29, :220:20, :240:68, :245:54, :253:82
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_0_data_0 <= _sectored_entries_0_0_data_T;	// TLB.scala:123:24, :165:29
    if (~io_ptw_resp_valid | _GEN_24 | ~_GEN_27) begin	// TLB.scala:122:16, :165:29, :220:20, :240:68, :245:54, :253:82
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_0_data_1 <= _sectored_entries_0_0_data_T;	// TLB.scala:123:24, :165:29
    if (~io_ptw_resp_valid | _GEN_24 | ~_GEN_28) begin	// TLB.scala:122:16, :165:29, :220:20, :240:68, :245:54, :253:82
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_0_data_2 <= _sectored_entries_0_0_data_T;	// TLB.scala:123:24, :165:29
    if (~io_ptw_resp_valid | _GEN_24 | ~(&(r_refill_tag[1:0]))) begin	// TLB.scala:122:16, :165:29, :174:25, :220:20, :240:68, :245:54, :253:82, package.scala:154:13
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_0_data_3 <= _sectored_entries_0_0_data_T;	// TLB.scala:123:24, :165:29
    sectored_entries_0_0_valid_0 <=
      ~_GEN_41
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_40
                     ? ~(sectored_entries_0_0_data_0[0] | _GEN_36) & _GEN_29
                     : ~_GEN_36 & _GEN_29)
                : io_sfence_bits_rs2 & sectored_entries_0_0_data_0[13] & _GEN_29)
           : _GEN_29);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    sectored_entries_0_0_valid_1 <=
      ~_GEN_41
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_40
                     ? ~(sectored_entries_0_0_data_1[0] | _GEN_37) & _GEN_30
                     : ~_GEN_37 & _GEN_30)
                : io_sfence_bits_rs2 & sectored_entries_0_0_data_1[13] & _GEN_30)
           : _GEN_30);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    sectored_entries_0_0_valid_2 <=
      ~_GEN_41
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_40
                     ? ~(sectored_entries_0_0_data_2[0] | _GEN_38) & _GEN_31
                     : ~_GEN_38 & _GEN_31)
                : io_sfence_bits_rs2 & sectored_entries_0_0_data_2[13] & _GEN_31)
           : _GEN_31);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    sectored_entries_0_0_valid_3 <=
      ~_GEN_41
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_40
                     ? ~(sectored_entries_0_0_data_3[0] | _GEN_39) & _GEN_32
                     : ~_GEN_39 & _GEN_32)
                : io_sfence_bits_rs2 & sectored_entries_0_0_data_3[13] & _GEN_32)
           : _GEN_32);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    if (_GEN_16) begin	// TLB.scala:166:30, :220:20, :240:68
      superpage_entries_0_level <= {1'h0, io_ptw_resp_bits_level[0]};	// TLB.scala:119:16, :166:30, package.scala:154:13
      superpage_entries_0_tag <= r_refill_tag;	// TLB.scala:166:30, :174:25
      superpage_entries_0_data_0 <=
        {io_ptw_resp_bits_pte_ppn[19:0],
         io_ptw_resp_bits_pte_u,
         newEntry_g,
         io_ptw_resp_bits_ae,
         newEntry_sw,
         newEntry_sx,
         newEntry_sr,
         newEntry_pw,
         newEntry_px,
         newEntry_pr,
         newEntry_ppp,
         newEntry_pal,
         newEntry_paa,
         newEntry_eff,
         newEntry_c,
         1'h0};	// PTW.scala:77:35, :78:40, :79:35, TLB.scala:123:24, :166:30, :200:19, :204:66, :205:70, :209:65, :223:18, :226:25
    end
    superpage_entries_0_valid_0 <=
      ~_GEN_41
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? ~(superpage_entries_0_valid_0
                    & superpage_entries_0_tag[26:18] == io_req_bits_vaddr[38:30]
                    & (ignore_1
                       | superpage_entries_0_tag[17:9] == io_req_bits_vaddr[29:21]))
                  & _GEN_17
                : io_sfence_bits_rs2 & superpage_entries_0_data_0[13] & _GEN_17)
           : _GEN_17);	// TLB.scala:83:39, :94:28, :95:{29,40,46,77,84}, :126:46, :129:23, :143:19, :163:30, :166:30, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    if (_GEN_18) begin	// TLB.scala:166:30, :220:20, :240:68
      superpage_entries_1_level <= {1'h0, io_ptw_resp_bits_level[0]};	// TLB.scala:119:16, :166:30, package.scala:154:13
      superpage_entries_1_tag <= r_refill_tag;	// TLB.scala:166:30, :174:25
      superpage_entries_1_data_0 <=
        {io_ptw_resp_bits_pte_ppn[19:0],
         io_ptw_resp_bits_pte_u,
         newEntry_g,
         io_ptw_resp_bits_ae,
         newEntry_sw,
         newEntry_sx,
         newEntry_sr,
         newEntry_pw,
         newEntry_px,
         newEntry_pr,
         newEntry_ppp,
         newEntry_pal,
         newEntry_paa,
         newEntry_eff,
         newEntry_c,
         1'h0};	// PTW.scala:77:35, :78:40, :79:35, TLB.scala:123:24, :166:30, :200:19, :204:66, :205:70, :209:65, :223:18, :226:25
    end
    superpage_entries_1_valid_0 <=
      ~_GEN_41
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? ~(superpage_entries_1_valid_0
                    & superpage_entries_1_tag[26:18] == io_req_bits_vaddr[38:30]
                    & (ignore_4
                       | superpage_entries_1_tag[17:9] == io_req_bits_vaddr[29:21]))
                  & _GEN_19
                : io_sfence_bits_rs2 & superpage_entries_1_data_0[13] & _GEN_19)
           : _GEN_19);	// TLB.scala:83:39, :94:28, :95:{29,40,46,77,84}, :126:46, :129:23, :143:19, :163:30, :166:30, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    if (_GEN_20) begin	// TLB.scala:166:30, :220:20, :240:68
      superpage_entries_2_level <= {1'h0, io_ptw_resp_bits_level[0]};	// TLB.scala:119:16, :166:30, package.scala:154:13
      superpage_entries_2_tag <= r_refill_tag;	// TLB.scala:166:30, :174:25
      superpage_entries_2_data_0 <=
        {io_ptw_resp_bits_pte_ppn[19:0],
         io_ptw_resp_bits_pte_u,
         newEntry_g,
         io_ptw_resp_bits_ae,
         newEntry_sw,
         newEntry_sx,
         newEntry_sr,
         newEntry_pw,
         newEntry_px,
         newEntry_pr,
         newEntry_ppp,
         newEntry_pal,
         newEntry_paa,
         newEntry_eff,
         newEntry_c,
         1'h0};	// PTW.scala:77:35, :78:40, :79:35, TLB.scala:123:24, :166:30, :200:19, :204:66, :205:70, :209:65, :223:18, :226:25
    end
    superpage_entries_2_valid_0 <=
      ~_GEN_41
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? ~(superpage_entries_2_valid_0
                    & superpage_entries_2_tag[26:18] == io_req_bits_vaddr[38:30]
                    & (ignore_7
                       | superpage_entries_2_tag[17:9] == io_req_bits_vaddr[29:21]))
                  & _GEN_21
                : io_sfence_bits_rs2 & superpage_entries_2_data_0[13] & _GEN_21)
           : _GEN_21);	// TLB.scala:83:39, :94:28, :95:{29,40,46,77,84}, :126:46, :129:23, :143:19, :163:30, :166:30, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    if (_GEN_22) begin	// TLB.scala:166:30, :220:20, :240:68
      superpage_entries_3_level <= {1'h0, io_ptw_resp_bits_level[0]};	// TLB.scala:119:16, :166:30, package.scala:154:13
      superpage_entries_3_tag <= r_refill_tag;	// TLB.scala:166:30, :174:25
      superpage_entries_3_data_0 <=
        {io_ptw_resp_bits_pte_ppn[19:0],
         io_ptw_resp_bits_pte_u,
         newEntry_g,
         io_ptw_resp_bits_ae,
         newEntry_sw,
         newEntry_sx,
         newEntry_sr,
         newEntry_pw,
         newEntry_px,
         newEntry_pr,
         newEntry_ppp,
         newEntry_pal,
         newEntry_paa,
         newEntry_eff,
         newEntry_c,
         1'h0};	// PTW.scala:77:35, :78:40, :79:35, TLB.scala:123:24, :166:30, :200:19, :204:66, :205:70, :209:65, :223:18, :226:25
    end
    superpage_entries_3_valid_0 <=
      ~_GEN_41
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? ~(superpage_entries_3_valid_0
                    & superpage_entries_3_tag[26:18] == io_req_bits_vaddr[38:30]
                    & (ignore_10
                       | superpage_entries_3_tag[17:9] == io_req_bits_vaddr[29:21]))
                  & _GEN_23
                : io_sfence_bits_rs2 & superpage_entries_3_data_0[13] & _GEN_23)
           : _GEN_23);	// TLB.scala:83:39, :94:28, :95:{29,40,46,77,84}, :126:46, :129:23, :143:19, :163:30, :166:30, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    if (_GEN_14) begin	// TLB.scala:118:14, :167:56, :220:20, :240:68
      special_entry_level <= io_ptw_resp_bits_level;	// TLB.scala:167:56
      special_entry_tag <= r_refill_tag;	// TLB.scala:167:56, :174:25
      special_entry_data_0 <=
        {io_ptw_resp_bits_pte_ppn[19:0],
         io_ptw_resp_bits_pte_u,
         newEntry_g,
         io_ptw_resp_bits_ae,
         newEntry_sw,
         newEntry_sx,
         newEntry_sr,
         newEntry_pw,
         newEntry_px,
         newEntry_pr,
         newEntry_ppp,
         newEntry_pal,
         newEntry_paa,
         newEntry_eff,
         newEntry_c,
         1'h0};	// PTW.scala:77:35, :78:40, :79:35, TLB.scala:123:24, :167:56, :200:19, :204:66, :205:70, :209:65, :223:18, :226:25
    end
    special_entry_valid_0 <=
      ~_GEN_41
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? ~(special_entry_valid_0
                    & special_entry_tag[26:18] == io_req_bits_vaddr[38:30]
                    & (ignore_13 | special_entry_tag[17:9] == io_req_bits_vaddr[29:21])
                    & (~(special_entry_level[1])
                       | special_entry_tag[8:0] == io_req_bits_vaddr[20:12])) & _GEN_15
                : io_sfence_bits_rs2 & special_entry_data_0[13] & _GEN_15)
           : _GEN_15);	// TLB.scala:83:39, :95:{29,40,46,77,84}, :108:28, :126:46, :129:23, :143:19, :163:30, :167:56, :220:20, :240:68, :243:34, :384:19, :387:35, :388:40, :392:{24,34}
    if (_GEN_33) begin	// TLB.scala:363:25
      r_refill_tag <= io_req_bits_vaddr[38:12];	// TLB.scala:163:30, :174:25
      if (&{superpage_entries_3_valid_0,
            superpage_entries_2_valid_0,
            superpage_entries_1_valid_0,
            superpage_entries_0_valid_0})	// Cat.scala:30:58, TLB.scala:166:30, :411:16
        r_superpage_repl_addr <=
          {state_reg_1[2], state_reg_1[2] ? state_reg_1[1] : state_reg_1[0]};	// Cat.scala:30:58, Replacement.scala:168:70, :243:38, :245:38, :250:16, TLB.scala:175:34, package.scala:154:13
      else begin	// TLB.scala:411:16
        automatic logic [2:0] _r_superpage_repl_addr_T_4;	// TLB.scala:411:43
        _r_superpage_repl_addr_T_4 =
          ~{superpage_entries_2_valid_0,
            superpage_entries_1_valid_0,
            superpage_entries_0_valid_0};	// Cat.scala:30:58, TLB.scala:166:30, :411:43
        if (_r_superpage_repl_addr_T_4[0])	// OneHot.scala:47:40, TLB.scala:411:43
          r_superpage_repl_addr <= 2'h0;	// TLB.scala:173:18, :175:34
        else if (_r_superpage_repl_addr_T_4[1])	// OneHot.scala:47:40, TLB.scala:411:43
          r_superpage_repl_addr <= 2'h1;	// TLB.scala:175:34, package.scala:15:47
        else	// OneHot.scala:47:40
          r_superpage_repl_addr <= {1'h1, ~(_r_superpage_repl_addr_T_4[2])};	// Mux.scala:47:69, OneHot.scala:47:40, TLB.scala:175:34, :182:27, :411:43
      end
      r_sectored_hit <=
        (sectored_entries_0_0_valid_0 | sectored_entries_0_0_valid_1
         | sectored_entries_0_0_valid_2 | sectored_entries_0_0_valid_3)
        & _hitsVec_T == 25'h0;	// TLB.scala:87:40, :88:{41,66}, :165:29, :178:27, package.scala:72:59
    end
    if (reset) begin
      state <= 2'h0;	// TLB.scala:173:18
      state_reg_1 <= 3'h0;	// Replacement.scala:168:70
    end
    else begin
      automatic logic superpage_hits_1;	// TLB.scala:95:29
      automatic logic superpage_hits_2;	// TLB.scala:95:29
      automatic logic superpage_hits_3;	// TLB.scala:95:29
      superpage_hits_1 =
        superpage_entries_1_valid_0
        & superpage_entries_1_tag[26:18] == io_req_bits_vaddr[38:30]
        & (ignore_4 | superpage_entries_1_tag[17:9] == io_req_bits_vaddr[29:21]);	// TLB.scala:94:28, :95:{29,40,46,77,84}, :163:30, :166:30
      superpage_hits_2 =
        superpage_entries_2_valid_0
        & superpage_entries_2_tag[26:18] == io_req_bits_vaddr[38:30]
        & (ignore_7 | superpage_entries_2_tag[17:9] == io_req_bits_vaddr[29:21]);	// TLB.scala:94:28, :95:{29,40,46,77,84}, :163:30, :166:30
      superpage_hits_3 =
        superpage_entries_3_valid_0
        & superpage_entries_3_tag[26:18] == io_req_bits_vaddr[38:30]
        & (ignore_10 | superpage_entries_3_tag[17:9] == io_req_bits_vaddr[29:21]);	// TLB.scala:94:28, :95:{29,40,46,77,84}, :163:30, :166:30
      if (io_ptw_resp_valid)
        state <= 2'h0;	// TLB.scala:173:18
      else if (state == 2'h2 & io_sfence_valid)	// TLB.scala:108:28, :173:18, :377:{17,28}
        state <= 2'h3;	// TLB.scala:173:18, package.scala:15:47
      else if (_io_ptw_req_valid_T) begin	// package.scala:15:47
        if (io_ptw_req_ready)
          state <= {1'h1, io_sfence_valid};	// TLB.scala:173:18, :182:27, :374:45
        else if (io_sfence_valid)
          state <= 2'h0;	// TLB.scala:173:18
        else if (_GEN_33)	// TLB.scala:363:25
          state <= 2'h1;	// TLB.scala:173:18, package.scala:15:47
      end
      else if (_GEN_33)	// TLB.scala:363:25
        state <= 2'h1;	// TLB.scala:173:18, package.scala:15:47
      if (io_req_valid & vm_enabled
          & (superpage_entries_0_valid_0
             & superpage_entries_0_tag[26:18] == io_req_bits_vaddr[38:30]
             & (ignore_1 | superpage_entries_0_tag[17:9] == io_req_bits_vaddr[29:21])
             | superpage_hits_1 | superpage_hits_2 | superpage_hits_3)) begin	// Replacement.scala:168:70, :172:15, TLB.scala:94:28, :95:{29,40,46,77,84}, :163:30, :166:30, :183:99, :329:37, :331:31, package.scala:72:59
        automatic logic [1:0] hi_1;	// OneHot.scala:30:18
        automatic logic       lo_2;	// OneHot.scala:32:28
        hi_1 = {superpage_hits_3, superpage_hits_2};	// OneHot.scala:30:18, TLB.scala:95:29
        lo_2 = superpage_hits_3 | superpage_hits_1;	// OneHot.scala:32:28, TLB.scala:95:29
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
      automatic logic [31:0] _RANDOM[0:16];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [4:0] i = 5'h0; i < 5'h11; i += 5'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        sectored_entries_0_0_tag = _RANDOM[5'h0][28:2];	// TLB.scala:165:29
        sectored_entries_0_0_data_0 = {_RANDOM[5'h0][31:29], _RANDOM[5'h1]};	// TLB.scala:165:29
        sectored_entries_0_0_data_1 = {_RANDOM[5'h2], _RANDOM[5'h3][2:0]};	// TLB.scala:165:29
        sectored_entries_0_0_data_2 = {_RANDOM[5'h3][31:3], _RANDOM[5'h4][5:0]};	// TLB.scala:165:29
        sectored_entries_0_0_data_3 = {_RANDOM[5'h4][31:6], _RANDOM[5'h5][8:0]};	// TLB.scala:165:29
        sectored_entries_0_0_valid_0 = _RANDOM[5'h5][9];	// TLB.scala:165:29
        sectored_entries_0_0_valid_1 = _RANDOM[5'h5][10];	// TLB.scala:165:29
        sectored_entries_0_0_valid_2 = _RANDOM[5'h5][11];	// TLB.scala:165:29
        sectored_entries_0_0_valid_3 = _RANDOM[5'h5][12];	// TLB.scala:165:29
        superpage_entries_0_level = _RANDOM[5'h5][14:13];	// TLB.scala:165:29, :166:30
        superpage_entries_0_tag = {_RANDOM[5'h5][31:15], _RANDOM[5'h6][9:0]};	// TLB.scala:165:29, :166:30
        superpage_entries_0_data_0 = {_RANDOM[5'h6][31:10], _RANDOM[5'h7][12:0]};	// TLB.scala:166:30
        superpage_entries_0_valid_0 = _RANDOM[5'h7][13];	// TLB.scala:166:30
        superpage_entries_1_level = _RANDOM[5'h7][15:14];	// TLB.scala:166:30
        superpage_entries_1_tag = {_RANDOM[5'h7][31:16], _RANDOM[5'h8][10:0]};	// TLB.scala:166:30
        superpage_entries_1_data_0 = {_RANDOM[5'h8][31:11], _RANDOM[5'h9][13:0]};	// TLB.scala:166:30
        superpage_entries_1_valid_0 = _RANDOM[5'h9][14];	// TLB.scala:166:30
        superpage_entries_2_level = _RANDOM[5'h9][16:15];	// TLB.scala:166:30
        superpage_entries_2_tag = {_RANDOM[5'h9][31:17], _RANDOM[5'hA][11:0]};	// TLB.scala:166:30
        superpage_entries_2_data_0 = {_RANDOM[5'hA][31:12], _RANDOM[5'hB][14:0]};	// TLB.scala:166:30
        superpage_entries_2_valid_0 = _RANDOM[5'hB][15];	// TLB.scala:166:30
        superpage_entries_3_level = _RANDOM[5'hB][17:16];	// TLB.scala:166:30
        superpage_entries_3_tag = {_RANDOM[5'hB][31:18], _RANDOM[5'hC][12:0]};	// TLB.scala:166:30
        superpage_entries_3_data_0 = {_RANDOM[5'hC][31:13], _RANDOM[5'hD][15:0]};	// TLB.scala:166:30
        superpage_entries_3_valid_0 = _RANDOM[5'hD][16];	// TLB.scala:166:30
        special_entry_level = _RANDOM[5'hD][18:17];	// TLB.scala:166:30, :167:56
        special_entry_tag = {_RANDOM[5'hD][31:19], _RANDOM[5'hE][13:0]};	// TLB.scala:166:30, :167:56
        special_entry_data_0 = {_RANDOM[5'hE][31:14], _RANDOM[5'hF][16:0]};	// TLB.scala:167:56
        special_entry_valid_0 = _RANDOM[5'hF][17];	// TLB.scala:167:56
        state = _RANDOM[5'hF][19:18];	// TLB.scala:167:56, :173:18
        r_refill_tag = {_RANDOM[5'hF][31:20], _RANDOM[5'h10][14:0]};	// TLB.scala:167:56, :174:25
        r_superpage_repl_addr = _RANDOM[5'h10][16:15];	// TLB.scala:174:25, :175:34
        r_sectored_hit = _RANDOM[5'h10][17];	// TLB.scala:174:25, :178:27
        state_reg_1 = _RANDOM[5'h10][20:18];	// Replacement.scala:168:70, TLB.scala:174:25
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  PMPChecker pmp (	// TLB.scala:193:19
    .io_prv         (mpu_priv[1:0]),	// TLB.scala:192:27, :197:14
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
    .io_addr        ({mpu_ppn[19:0], io_req_bits_vaddr[11:0]}),	// TLB.scala:189:20, :191:52, :194:15
    .io_size        (io_req_bits_size),
    .io_r           (_pmp_io_r),
    .io_w           (_pmp_io_w),
    .io_x           (_pmp_io_x)
  );
  assign io_req_ready = _io_req_ready_output;	// TLB.scala:341:25
  assign io_resp_miss = io_ptw_resp_valid | tlb_miss | multipleHits;	// Misc.scala:182:49, TLB.scala:325:40, :354:41
  assign io_resp_paddr =
    {(hitsVec_0 ? _normal_entries_WIRE_1[34:15] : 20'h0)
       | (hitsVec_1
            ? {superpage_entries_0_data_0[34:33],
               (ignore_1 ? io_req_bits_vaddr[29:21] : 9'h0)
                 | superpage_entries_0_data_0[32:24],
               io_req_bits_vaddr[20:12] | superpage_entries_0_data_0[23:15]}
            : 20'h0)
       | (hitsVec_2
            ? {superpage_entries_1_data_0[34:33],
               (ignore_4 ? io_req_bits_vaddr[29:21] : 9'h0)
                 | superpage_entries_1_data_0[32:24],
               io_req_bits_vaddr[20:12] | superpage_entries_1_data_0[23:15]}
            : 20'h0)
       | (hitsVec_3
            ? {superpage_entries_2_data_0[34:33],
               (ignore_7 ? io_req_bits_vaddr[29:21] : 9'h0)
                 | superpage_entries_2_data_0[32:24],
               io_req_bits_vaddr[20:12] | superpage_entries_2_data_0[23:15]}
            : 20'h0)
       | (hitsVec_4
            ? {superpage_entries_3_data_0[34:33],
               (ignore_10 ? io_req_bits_vaddr[29:21] : 9'h0)
                 | superpage_entries_3_data_0[32:24],
               io_req_bits_vaddr[20:12] | superpage_entries_3_data_0[23:15]}
            : 20'h0)
       | (hitsVec_5
            ? {special_entry_data_0[34:33],
               (ignore_13 ? io_req_bits_vaddr[29:21] : 9'h0)
                 | special_entry_data_0[32:24],
               (special_entry_level[1] ? 9'h0 : io_req_bits_vaddr[20:12])
                 | special_entry_data_0[23:15]}
            : 20'h0) | (vm_enabled ? 20'h0 : io_req_bits_vaddr[31:12]),
     io_req_bits_vaddr[11:0]};	// Cat.scala:30:58, Mux.scala:27:72, TLB.scala:86:77, :94:28, :106:26, :108:28, :109:{28,47}, :135:61, :163:30, :166:30, :167:56, :183:99, :191:52, :214:44, :217:77
  assign io_resp_pf_ld =
    bad_va & cmd_read
    | (|((cmd_read
            ? {~(r_array_lo_2[5] | special_entry_data_0[12]),
               ~(r_array_lo_2[4] | superpage_entries_3_data_0[12]),
               ~(r_array_lo_2[3] | superpage_entries_2_data_0[12]),
               ~(r_array_lo_2[2] | superpage_entries_1_data_0[12]),
               ~(r_array_lo_2[1] | superpage_entries_0_data_0[12]),
               ~(r_array_lo_2[0] | _normal_entries_WIRE_1[12])}
            : 6'h0) & _GEN_13));	// Cat.scala:30:58, Consts.scala:81:75, TLB.scala:86:77, :166:30, :167:56, :265:23, :267:40, :284:117, :320:{24,35,45}, :342:{28,41,57,65}
  assign io_resp_pf_st =
    bad_va & cmd_write_perms
    | (|((cmd_write_perms
            ? {~(w_array_lo_1[5] | special_entry_data_0[12]),
               ~(w_array_lo_1[4] | superpage_entries_3_data_0[12]),
               ~(w_array_lo_1[3] | superpage_entries_2_data_0[12]),
               ~(w_array_lo_1[2] | superpage_entries_1_data_0[12]),
               ~(w_array_lo_1[1] | superpage_entries_0_data_0[12]),
               ~(w_array_lo_1[0] | _normal_entries_WIRE_1[12])}
            : 6'h0) & _GEN_13));	// Cat.scala:30:58, TLB.scala:86:77, :166:30, :167:56, :265:23, :268:40, :284:117, :300:35, :321:{24,42,52}, :343:{28,48,64,72}
  assign io_resp_ae_ld =
    |((cmd_read
         ? ae_array
           | ~({{2{newEntry_pr}},
                superpage_entries_3_data_0[6],
                superpage_entries_2_data_0[6],
                superpage_entries_1_data_0[6],
                superpage_entries_0_data_0[6],
                _normal_entries_WIRE_1[6]} & _px_array_T_2)
         : 7'h0) & hits);	// Bitwise.scala:72:12, Cat.scala:30:58, Consts.scala:81:75, TLB.scala:86:77, :166:30, :204:66, :270:87, :305:37, :307:{24,44,46}, :317:19, :345:{33,41}
  assign io_resp_ae_st =
    |(((cmd_write_perms
          ? ae_array
            | ~({{2{newEntry_pw}},
                 superpage_entries_3_data_0[8],
                 superpage_entries_2_data_0[8],
                 superpage_entries_1_data_0[8],
                 superpage_entries_0_data_0[8],
                 _normal_entries_WIRE_1[8]} & _px_array_T_2)
          : 7'h0) | (cmd_put_partial ? ~(ppp_array | lrscAllowed) : 7'h0)
       | (cmd_amo_logical ? ~(pal_array | lrscAllowed) : 7'h0)
       | (cmd_amo_arithmetic ? ~(paa_array | lrscAllowed) : 7'h0)) & hits);	// Bitwise.scala:72:12, Cat.scala:30:58, TLB.scala:86:77, :166:30, :205:70, :271:87, :278:39, :279:39, :280:39, :297:41, :300:35, :305:37, :309:{8,35,37}, :310:{8,26}, :311:{8,26,53}, :312:{8,29}, :317:19, :346:{33,41}, package.scala:72:59
  assign io_resp_ma_ld = |(((|_GEN_12) & cmd_read ? ~eff_array : 7'h0) & hits);	// Cat.scala:30:58, Consts.scala:81:75, TLB.scala:283:{39,75}, :317:19, :318:{24,36,49}, :348:{33,41}
  assign io_resp_ma_st = |(((|_GEN_12) & cmd_write ? ~eff_array : 7'h0) & hits);	// Cat.scala:30:58, Consts.scala:82:76, TLB.scala:283:{39,75}, :317:19, :318:49, :319:{24,36}, :349:{33,41}
  assign io_resp_cacheable = |(lrscAllowed & hits);	// Cat.scala:30:58, TLB.scala:351:{33,41}
  assign io_resp_must_alloc =
    |(((cmd_put_partial ? ~ppp_array : 7'h0) | (cmd_amo_logical ? ~paa_array : 7'h0)
       | (cmd_amo_arithmetic ? ~pal_array : 7'h0) | {7{cmd_lrsc}}) & hits);	// Cat.scala:30:58, TLB.scala:297:41, :314:{8,26}, :315:{8,26}, :316:{8,29,46}, :317:{8,19}, :352:{43,51}, package.scala:72:59
  assign io_ptw_req_valid = _io_ptw_req_valid_T;	// package.scala:15:47
  assign io_ptw_req_bits_bits_addr = r_refill_tag;	// TLB.scala:174:25
endmodule

