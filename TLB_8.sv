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

module TLB_8(
  input         clock,
                reset,
                io_req_valid,
  input  [39:0] io_req_bits_vaddr,
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
  input  [1:0]  io_ptw_status_prv,
  input         io_ptw_pmp_0_cfg_l,
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
  output        io_resp_miss,
  output [31:0] io_resp_paddr,
  output        io_resp_pf_inst,
                io_resp_ae_inst,
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
  reg  [26:0]      sectored_entries_0_1_tag;	// TLB.scala:165:29
  reg  [34:0]      sectored_entries_0_1_data_0;	// TLB.scala:165:29
  reg  [34:0]      sectored_entries_0_1_data_1;	// TLB.scala:165:29
  reg  [34:0]      sectored_entries_0_1_data_2;	// TLB.scala:165:29
  reg  [34:0]      sectored_entries_0_1_data_3;	// TLB.scala:165:29
  reg              sectored_entries_0_1_valid_0;	// TLB.scala:165:29
  reg              sectored_entries_0_1_valid_1;	// TLB.scala:165:29
  reg              sectored_entries_0_1_valid_2;	// TLB.scala:165:29
  reg              sectored_entries_0_1_valid_3;	// TLB.scala:165:29
  reg  [26:0]      sectored_entries_0_2_tag;	// TLB.scala:165:29
  reg  [34:0]      sectored_entries_0_2_data_0;	// TLB.scala:165:29
  reg  [34:0]      sectored_entries_0_2_data_1;	// TLB.scala:165:29
  reg  [34:0]      sectored_entries_0_2_data_2;	// TLB.scala:165:29
  reg  [34:0]      sectored_entries_0_2_data_3;	// TLB.scala:165:29
  reg              sectored_entries_0_2_valid_0;	// TLB.scala:165:29
  reg              sectored_entries_0_2_valid_1;	// TLB.scala:165:29
  reg              sectored_entries_0_2_valid_2;	// TLB.scala:165:29
  reg              sectored_entries_0_2_valid_3;	// TLB.scala:165:29
  reg  [26:0]      sectored_entries_0_3_tag;	// TLB.scala:165:29
  reg  [34:0]      sectored_entries_0_3_data_0;	// TLB.scala:165:29
  reg  [34:0]      sectored_entries_0_3_data_1;	// TLB.scala:165:29
  reg  [34:0]      sectored_entries_0_3_data_2;	// TLB.scala:165:29
  reg  [34:0]      sectored_entries_0_3_data_3;	// TLB.scala:165:29
  reg              sectored_entries_0_3_valid_0;	// TLB.scala:165:29
  reg              sectored_entries_0_3_valid_1;	// TLB.scala:165:29
  reg              sectored_entries_0_3_valid_2;	// TLB.scala:165:29
  reg              sectored_entries_0_3_valid_3;	// TLB.scala:165:29
  reg  [26:0]      sectored_entries_0_4_tag;	// TLB.scala:165:29
  reg  [34:0]      sectored_entries_0_4_data_0;	// TLB.scala:165:29
  reg  [34:0]      sectored_entries_0_4_data_1;	// TLB.scala:165:29
  reg  [34:0]      sectored_entries_0_4_data_2;	// TLB.scala:165:29
  reg  [34:0]      sectored_entries_0_4_data_3;	// TLB.scala:165:29
  reg              sectored_entries_0_4_valid_0;	// TLB.scala:165:29
  reg              sectored_entries_0_4_valid_1;	// TLB.scala:165:29
  reg              sectored_entries_0_4_valid_2;	// TLB.scala:165:29
  reg              sectored_entries_0_4_valid_3;	// TLB.scala:165:29
  reg  [26:0]      sectored_entries_0_5_tag;	// TLB.scala:165:29
  reg  [34:0]      sectored_entries_0_5_data_0;	// TLB.scala:165:29
  reg  [34:0]      sectored_entries_0_5_data_1;	// TLB.scala:165:29
  reg  [34:0]      sectored_entries_0_5_data_2;	// TLB.scala:165:29
  reg  [34:0]      sectored_entries_0_5_data_3;	// TLB.scala:165:29
  reg              sectored_entries_0_5_valid_0;	// TLB.scala:165:29
  reg              sectored_entries_0_5_valid_1;	// TLB.scala:165:29
  reg              sectored_entries_0_5_valid_2;	// TLB.scala:165:29
  reg              sectored_entries_0_5_valid_3;	// TLB.scala:165:29
  reg  [26:0]      sectored_entries_0_6_tag;	// TLB.scala:165:29
  reg  [34:0]      sectored_entries_0_6_data_0;	// TLB.scala:165:29
  reg  [34:0]      sectored_entries_0_6_data_1;	// TLB.scala:165:29
  reg  [34:0]      sectored_entries_0_6_data_2;	// TLB.scala:165:29
  reg  [34:0]      sectored_entries_0_6_data_3;	// TLB.scala:165:29
  reg              sectored_entries_0_6_valid_0;	// TLB.scala:165:29
  reg              sectored_entries_0_6_valid_1;	// TLB.scala:165:29
  reg              sectored_entries_0_6_valid_2;	// TLB.scala:165:29
  reg              sectored_entries_0_6_valid_3;	// TLB.scala:165:29
  reg  [26:0]      sectored_entries_0_7_tag;	// TLB.scala:165:29
  reg  [34:0]      sectored_entries_0_7_data_0;	// TLB.scala:165:29
  reg  [34:0]      sectored_entries_0_7_data_1;	// TLB.scala:165:29
  reg  [34:0]      sectored_entries_0_7_data_2;	// TLB.scala:165:29
  reg  [34:0]      sectored_entries_0_7_data_3;	// TLB.scala:165:29
  reg              sectored_entries_0_7_valid_0;	// TLB.scala:165:29
  reg              sectored_entries_0_7_valid_1;	// TLB.scala:165:29
  reg              sectored_entries_0_7_valid_2;	// TLB.scala:165:29
  reg              sectored_entries_0_7_valid_3;	// TLB.scala:165:29
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
  reg  [2:0]       r_sectored_repl_addr;	// TLB.scala:176:33
  reg  [2:0]       r_sectored_hit_addr;	// TLB.scala:177:32
  reg              r_sectored_hit;	// TLB.scala:178:27
  wire             _vm_enabled_T_2 = io_ptw_ptbr_mode[3] & ~(io_ptw_status_prv[1]);	// TLB.scala:182:27, :183:{53,83}
  wire             _io_ptw_req_valid_T = state == 2'h1;	// TLB.scala:173:18, package.scala:15:47
  wire             ignore_13 = special_entry_level == 2'h0;	// TLB.scala:108:28, :167:56, :173:18
  wire [27:0]      mpu_ppn =
    io_ptw_resp_valid
      ? {8'h0, io_ptw_resp_bits_pte_ppn[19:0]}
      : _vm_enabled_T_2
          ? {8'h0,
             special_entry_data_0[34:33],
             (ignore_13 ? io_req_bits_vaddr[29:21] : 9'h0) | special_entry_data_0[32:24],
             (special_entry_level[1] ? 9'h0 : io_req_bits_vaddr[20:12])
               | special_entry_data_0[23:15]}
          : io_req_bits_vaddr[39:12];	// TLB.scala:86:77, :106:26, :108:28, :109:{28,47}, :135:61, :163:30, :167:56, :183:83, :186:44, :189:20, :190:{20,123}
  wire [2:0]       mpu_priv =
    io_ptw_resp_valid ? 3'h1 : {io_ptw_status_debug, io_ptw_status_prv};	// Cat.scala:30:58, TLB.scala:192:27
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
    | {mpu_ppn[27:6], _GEN_3} == 24'h0;	// Parameters.scala:137:{31,49,52,67}, TLB.scala:189:20, :198:67, :253:75, :344:55
  wire [1:0]       _GEN_4 = {_GEN_1[3], mpu_ppn[16]};	// Parameters.scala:137:{31,49,52}, TLB.scala:189:20
  wire             deny_access_to_debug = ~(mpu_priv[2]) & ~(|mpu_ppn);	// Parameters.scala:137:{49,52,67}, TLB.scala:189:20, :192:27, :203:{39,48}
  wire             newEntry_px =
    legal_address
    & ({mpu_ppn[19], mpu_ppn[14:13], mpu_ppn[8], mpu_ppn[5:4], mpu_ppn[2]} == 7'h0
       | {mpu_ppn[19],
          mpu_ppn[16],
          mpu_ppn[14:13],
          mpu_ppn[8],
          mpu_ppn[5],
          ~(mpu_ppn[4])} == 7'h0
       | {mpu_ppn[19], mpu_ppn[16], mpu_ppn[14:13], mpu_ppn[8], _GEN_3} == 7'h0
       | ~(|_GEN_4)) & ~deny_access_to_debug & _pmp_io_x;	// Parameters.scala:137:{31,49,52,67}, :615:89, Replacement.scala:168:70, TLB.scala:189:20, :193:19, :198:67, :203:48, :204:44, :209:65
  wire [24:0]      _hitsVec_T = sectored_entries_0_0_tag[26:2] ^ io_req_bits_vaddr[38:14];	// TLB.scala:88:41, :163:30, :165:29
  wire [24:0]      _hitsVec_T_4 =
    sectored_entries_0_1_tag[26:2] ^ io_req_bits_vaddr[38:14];	// TLB.scala:88:41, :163:30, :165:29
  wire [24:0]      _hitsVec_T_8 =
    sectored_entries_0_2_tag[26:2] ^ io_req_bits_vaddr[38:14];	// TLB.scala:88:41, :163:30, :165:29
  wire [24:0]      _hitsVec_T_12 =
    sectored_entries_0_3_tag[26:2] ^ io_req_bits_vaddr[38:14];	// TLB.scala:88:41, :163:30, :165:29
  wire [24:0]      _hitsVec_T_16 =
    sectored_entries_0_4_tag[26:2] ^ io_req_bits_vaddr[38:14];	// TLB.scala:88:41, :163:30, :165:29
  wire [24:0]      _hitsVec_T_20 =
    sectored_entries_0_5_tag[26:2] ^ io_req_bits_vaddr[38:14];	// TLB.scala:88:41, :163:30, :165:29
  wire [24:0]      _hitsVec_T_24 =
    sectored_entries_0_6_tag[26:2] ^ io_req_bits_vaddr[38:14];	// TLB.scala:88:41, :163:30, :165:29
  wire [24:0]      _hitsVec_T_28 =
    sectored_entries_0_7_tag[26:2] ^ io_req_bits_vaddr[38:14];	// TLB.scala:88:41, :163:30, :165:29
  wire             ignore_1 = superpage_entries_0_level == 2'h0;	// TLB.scala:94:28, :166:30, :173:18
  wire             ignore_4 = superpage_entries_1_level == 2'h0;	// TLB.scala:94:28, :166:30, :173:18
  wire             ignore_7 = superpage_entries_2_level == 2'h0;	// TLB.scala:94:28, :166:30, :173:18
  wire             ignore_10 = superpage_entries_3_level == 2'h0;	// TLB.scala:94:28, :166:30, :173:18
  wire [3:0]       _GEN_5 =
    {{sectored_entries_0_0_valid_3},
     {sectored_entries_0_0_valid_2},
     {sectored_entries_0_0_valid_1},
     {sectored_entries_0_0_valid_0}};	// TLB.scala:100:18, :165:29
  wire             hitsVec_0 =
    _vm_enabled_T_2 & _GEN_5[io_req_bits_vaddr[13:12]] & _hitsVec_T == 25'h0;	// TLB.scala:88:{41,66}, :100:18, :163:30, :183:83, :214:44, package.scala:154:13
  wire [3:0]       _GEN_6 =
    {{sectored_entries_0_1_valid_3},
     {sectored_entries_0_1_valid_2},
     {sectored_entries_0_1_valid_1},
     {sectored_entries_0_1_valid_0}};	// TLB.scala:100:18, :165:29
  wire             hitsVec_1 =
    _vm_enabled_T_2 & _GEN_6[io_req_bits_vaddr[13:12]] & _hitsVec_T_4 == 25'h0;	// TLB.scala:88:{41,66}, :100:18, :163:30, :183:83, :214:44, package.scala:154:13
  wire [3:0]       _GEN_7 =
    {{sectored_entries_0_2_valid_3},
     {sectored_entries_0_2_valid_2},
     {sectored_entries_0_2_valid_1},
     {sectored_entries_0_2_valid_0}};	// TLB.scala:100:18, :165:29
  wire             hitsVec_2 =
    _vm_enabled_T_2 & _GEN_7[io_req_bits_vaddr[13:12]] & _hitsVec_T_8 == 25'h0;	// TLB.scala:88:{41,66}, :100:18, :163:30, :183:83, :214:44, package.scala:154:13
  wire [3:0]       _GEN_8 =
    {{sectored_entries_0_3_valid_3},
     {sectored_entries_0_3_valid_2},
     {sectored_entries_0_3_valid_1},
     {sectored_entries_0_3_valid_0}};	// TLB.scala:100:18, :165:29
  wire             hitsVec_3 =
    _vm_enabled_T_2 & _GEN_8[io_req_bits_vaddr[13:12]] & _hitsVec_T_12 == 25'h0;	// TLB.scala:88:{41,66}, :100:18, :163:30, :183:83, :214:44, package.scala:154:13
  wire [3:0]       _GEN_9 =
    {{sectored_entries_0_4_valid_3},
     {sectored_entries_0_4_valid_2},
     {sectored_entries_0_4_valid_1},
     {sectored_entries_0_4_valid_0}};	// TLB.scala:100:18, :165:29
  wire             hitsVec_4 =
    _vm_enabled_T_2 & _GEN_9[io_req_bits_vaddr[13:12]] & _hitsVec_T_16 == 25'h0;	// TLB.scala:88:{41,66}, :100:18, :163:30, :183:83, :214:44, package.scala:154:13
  wire [3:0]       _GEN_10 =
    {{sectored_entries_0_5_valid_3},
     {sectored_entries_0_5_valid_2},
     {sectored_entries_0_5_valid_1},
     {sectored_entries_0_5_valid_0}};	// TLB.scala:100:18, :165:29
  wire             hitsVec_5 =
    _vm_enabled_T_2 & _GEN_10[io_req_bits_vaddr[13:12]] & _hitsVec_T_20 == 25'h0;	// TLB.scala:88:{41,66}, :100:18, :163:30, :183:83, :214:44, package.scala:154:13
  wire [3:0]       _GEN_11 =
    {{sectored_entries_0_6_valid_3},
     {sectored_entries_0_6_valid_2},
     {sectored_entries_0_6_valid_1},
     {sectored_entries_0_6_valid_0}};	// TLB.scala:100:18, :165:29
  wire             hitsVec_6 =
    _vm_enabled_T_2 & _GEN_11[io_req_bits_vaddr[13:12]] & _hitsVec_T_24 == 25'h0;	// TLB.scala:88:{41,66}, :100:18, :163:30, :183:83, :214:44, package.scala:154:13
  wire [3:0]       _GEN_12 =
    {{sectored_entries_0_7_valid_3},
     {sectored_entries_0_7_valid_2},
     {sectored_entries_0_7_valid_1},
     {sectored_entries_0_7_valid_0}};	// TLB.scala:100:18, :165:29
  wire             hitsVec_7 =
    _vm_enabled_T_2 & _GEN_12[io_req_bits_vaddr[13:12]] & _hitsVec_T_28 == 25'h0;	// TLB.scala:88:{41,66}, :100:18, :163:30, :183:83, :214:44, package.scala:154:13
  wire             hitsVec_8 =
    _vm_enabled_T_2 & superpage_entries_0_valid_0
    & superpage_entries_0_tag[26:18] == io_req_bits_vaddr[38:30]
    & (ignore_1 | superpage_entries_0_tag[17:9] == io_req_bits_vaddr[29:21]);	// TLB.scala:94:28, :95:{40,46,77,84}, :163:30, :166:30, :183:83, :214:44
  wire             hitsVec_9 =
    _vm_enabled_T_2 & superpage_entries_1_valid_0
    & superpage_entries_1_tag[26:18] == io_req_bits_vaddr[38:30]
    & (ignore_4 | superpage_entries_1_tag[17:9] == io_req_bits_vaddr[29:21]);	// TLB.scala:94:28, :95:{40,46,77,84}, :163:30, :166:30, :183:83, :214:44
  wire             hitsVec_10 =
    _vm_enabled_T_2 & superpage_entries_2_valid_0
    & superpage_entries_2_tag[26:18] == io_req_bits_vaddr[38:30]
    & (ignore_7 | superpage_entries_2_tag[17:9] == io_req_bits_vaddr[29:21]);	// TLB.scala:94:28, :95:{40,46,77,84}, :163:30, :166:30, :183:83, :214:44
  wire             hitsVec_11 =
    _vm_enabled_T_2 & superpage_entries_3_valid_0
    & superpage_entries_3_tag[26:18] == io_req_bits_vaddr[38:30]
    & (ignore_10 | superpage_entries_3_tag[17:9] == io_req_bits_vaddr[29:21]);	// TLB.scala:94:28, :95:{40,46,77,84}, :163:30, :166:30, :183:83, :214:44
  wire             hitsVec_12 =
    _vm_enabled_T_2 & special_entry_valid_0
    & special_entry_tag[26:18] == io_req_bits_vaddr[38:30]
    & (ignore_13 | special_entry_tag[17:9] == io_req_bits_vaddr[29:21])
    & (~(special_entry_level[1]) | special_entry_tag[8:0] == io_req_bits_vaddr[20:12]);	// TLB.scala:95:{40,46,77,84}, :108:28, :163:30, :167:56, :183:83, :214:44
  wire [3:0][34:0] _GEN_13 =
    {{sectored_entries_0_0_data_3},
     {sectored_entries_0_0_data_2},
     {sectored_entries_0_0_data_1},
     {sectored_entries_0_0_data_0}};	// TLB.scala:165:29
  wire [34:0]      _normal_entries_WIRE_1 = _GEN_13[io_req_bits_vaddr[13:12]];	// TLB.scala:163:30, package.scala:154:13
  wire [3:0][34:0] _GEN_14 =
    {{sectored_entries_0_1_data_3},
     {sectored_entries_0_1_data_2},
     {sectored_entries_0_1_data_1},
     {sectored_entries_0_1_data_0}};	// TLB.scala:165:29
  wire [34:0]      _normal_entries_WIRE_3 = _GEN_14[io_req_bits_vaddr[13:12]];	// TLB.scala:163:30, package.scala:154:13
  wire [3:0][34:0] _GEN_15 =
    {{sectored_entries_0_2_data_3},
     {sectored_entries_0_2_data_2},
     {sectored_entries_0_2_data_1},
     {sectored_entries_0_2_data_0}};	// TLB.scala:165:29
  wire [34:0]      _normal_entries_WIRE_5 = _GEN_15[io_req_bits_vaddr[13:12]];	// TLB.scala:163:30, package.scala:154:13
  wire [3:0][34:0] _GEN_16 =
    {{sectored_entries_0_3_data_3},
     {sectored_entries_0_3_data_2},
     {sectored_entries_0_3_data_1},
     {sectored_entries_0_3_data_0}};	// TLB.scala:165:29
  wire [34:0]      _normal_entries_WIRE_7 = _GEN_16[io_req_bits_vaddr[13:12]];	// TLB.scala:163:30, package.scala:154:13
  wire [3:0][34:0] _GEN_17 =
    {{sectored_entries_0_4_data_3},
     {sectored_entries_0_4_data_2},
     {sectored_entries_0_4_data_1},
     {sectored_entries_0_4_data_0}};	// TLB.scala:165:29
  wire [34:0]      _normal_entries_WIRE_9 = _GEN_17[io_req_bits_vaddr[13:12]];	// TLB.scala:163:30, package.scala:154:13
  wire [3:0][34:0] _GEN_18 =
    {{sectored_entries_0_5_data_3},
     {sectored_entries_0_5_data_2},
     {sectored_entries_0_5_data_1},
     {sectored_entries_0_5_data_0}};	// TLB.scala:165:29
  wire [34:0]      _normal_entries_WIRE_11 = _GEN_18[io_req_bits_vaddr[13:12]];	// TLB.scala:163:30, package.scala:154:13
  wire [3:0][34:0] _GEN_19 =
    {{sectored_entries_0_6_data_3},
     {sectored_entries_0_6_data_2},
     {sectored_entries_0_6_data_1},
     {sectored_entries_0_6_data_0}};	// TLB.scala:165:29
  wire [34:0]      _normal_entries_WIRE_13 = _GEN_19[io_req_bits_vaddr[13:12]];	// TLB.scala:163:30, package.scala:154:13
  wire [3:0][34:0] _GEN_20 =
    {{sectored_entries_0_7_data_3},
     {sectored_entries_0_7_data_2},
     {sectored_entries_0_7_data_1},
     {sectored_entries_0_7_data_0}};	// TLB.scala:165:29
  wire [34:0]      _normal_entries_WIRE_15 = _GEN_20[io_req_bits_vaddr[13:12]];	// TLB.scala:163:30, package.scala:154:13
  wire [12:0]      x_array_lo_1 =
    (io_ptw_status_prv[0]
       ? ~{special_entry_data_0[14],
           superpage_entries_3_data_0[14],
           superpage_entries_2_data_0[14],
           superpage_entries_1_data_0[14],
           superpage_entries_0_data_0[14],
           _normal_entries_WIRE_15[14],
           _normal_entries_WIRE_13[14],
           _normal_entries_WIRE_11[14],
           _normal_entries_WIRE_9[14],
           _normal_entries_WIRE_7[14],
           _normal_entries_WIRE_5[14],
           _normal_entries_WIRE_3[14],
           _normal_entries_WIRE_1[14]}
       : {special_entry_data_0[14],
          superpage_entries_3_data_0[14],
          superpage_entries_2_data_0[14],
          superpage_entries_1_data_0[14],
          superpage_entries_0_data_0[14],
          _normal_entries_WIRE_15[14],
          _normal_entries_WIRE_13[14],
          _normal_entries_WIRE_11[14],
          _normal_entries_WIRE_9[14],
          _normal_entries_WIRE_7[14],
          _normal_entries_WIRE_5[14],
          _normal_entries_WIRE_3[14],
          _normal_entries_WIRE_1[14]})
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
       _normal_entries_WIRE_1[10]};	// Cat.scala:30:58, TLB.scala:86:77, :166:30, :167:56, :181:20, :266:{22,31}, :269:39
  wire             bad_va =
    _vm_enabled_T_2 & ~(io_req_bits_vaddr[39:38] == 2'h0 | (&(io_req_bits_vaddr[39:38])));	// TLB.scala:173:18, :183:83, :284:117, :289:43, :290:{47,61,67,82}
  wire             tlb_miss =
    _vm_enabled_T_2 & ~bad_va
    & {hitsVec_12,
       hitsVec_11,
       hitsVec_10,
       hitsVec_9,
       hitsVec_8,
       hitsVec_7,
       hitsVec_6,
       hitsVec_5,
       hitsVec_4,
       hitsVec_3,
       hitsVec_2,
       hitsVec_1,
       hitsVec_0} == 13'h0;	// Cat.scala:30:58, TLB.scala:183:83, :214:44, :284:117, :324:27, :325:{32,40}
  reg  [6:0]       state_vec_0;	// Replacement.scala:305:17
  reg  [2:0]       state_reg_1;	// Replacement.scala:168:70
  wire             multipleHits_rightOne_1 = hitsVec_1 | hitsVec_2;	// Misc.scala:182:16, TLB.scala:214:44
  wire             multipleHits_leftOne_2 = hitsVec_0 | multipleHits_rightOne_1;	// Misc.scala:182:16, TLB.scala:214:44
  wire             multipleHits_rightOne_3 = hitsVec_4 | hitsVec_5;	// Misc.scala:182:16, TLB.scala:214:44
  wire             multipleHits_rightOne_4 = hitsVec_3 | multipleHits_rightOne_3;	// Misc.scala:182:16, TLB.scala:214:44
  wire             multipleHits_rightOne_6 = hitsVec_7 | hitsVec_8;	// Misc.scala:182:16, TLB.scala:214:44
  wire             multipleHits_leftOne_8 = hitsVec_6 | multipleHits_rightOne_6;	// Misc.scala:182:16, TLB.scala:214:44
  wire             multipleHits_leftOne_10 = hitsVec_9 | hitsVec_10;	// Misc.scala:182:16, TLB.scala:214:44
  wire             multipleHits_rightOne_9 = hitsVec_11 | hitsVec_12;	// Misc.scala:182:16, TLB.scala:214:44
  wire             multipleHits_rightOne_10 =
    multipleHits_leftOne_10 | multipleHits_rightOne_9;	// Misc.scala:182:16
  wire             multipleHits =
    hitsVec_1 & hitsVec_2 | hitsVec_0 & multipleHits_rightOne_1 | hitsVec_4 & hitsVec_5
    | hitsVec_3 & multipleHits_rightOne_3 | multipleHits_leftOne_2
    & multipleHits_rightOne_4 | hitsVec_7 & hitsVec_8 | hitsVec_6
    & multipleHits_rightOne_6 | hitsVec_9 & hitsVec_10 | hitsVec_11 & hitsVec_12
    | multipleHits_leftOne_10 & multipleHits_rightOne_9 | multipleHits_leftOne_8
    & multipleHits_rightOne_10 | (multipleHits_leftOne_2 | multipleHits_rightOne_4)
    & (multipleHits_leftOne_8 | multipleHits_rightOne_10);	// Misc.scala:182:{16,49,61}, TLB.scala:214:44
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
    automatic logic [3:0]  _GEN_21 = mpu_ppn[16:13] ^ 4'hA;	// Parameters.scala:137:31, TLB.scala:189:20
    automatic logic        newEntry_c;	// TLB.scala:200:19
    automatic logic        newEntry_pr;	// TLB.scala:204:66
    automatic logic [5:0]  _GEN_22 =
      {mpu_ppn[19], mpu_ppn[16:15], mpu_ppn[13], mpu_ppn[5:4]};	// Parameters.scala:137:{31,49,52}, TLB.scala:189:20
    automatic logic [5:0]  _GEN_23 =
      {mpu_ppn[19], mpu_ppn[16:15], _GEN_0[9], mpu_ppn[8], mpu_ppn[5]};	// Parameters.scala:137:{31,49,52}, TLB.scala:189:20
    automatic logic [2:0]  _GEN_24 = {mpu_ppn[19], mpu_ppn[16], ~(mpu_ppn[15])};	// Parameters.scala:137:{31,49,52}, TLB.scala:189:20
    automatic logic [6:0]  _GEN_25 =
      {mpu_ppn[19], _GEN_2[16:15], mpu_ppn[13], mpu_ppn[8], mpu_ppn[5:4]};	// Parameters.scala:137:{31,49,52}, TLB.scala:189:20
    automatic logic        newEntry_pw;	// TLB.scala:205:70
    automatic logic        newEntry_ppp;	// TLB.scala:200:19
    automatic logic        newEntry_pal;	// TLB.scala:200:19
    automatic logic        newEntry_paa;	// TLB.scala:200:19
    automatic logic        newEntry_eff;	// TLB.scala:200:19
    automatic logic        _r_sectored_repl_addr_valids_T;	// package.scala:72:59
    automatic logic        sector_hits_0;	// TLB.scala:87:40
    automatic logic        _r_sectored_repl_addr_valids_T_2;	// package.scala:72:59
    automatic logic        sector_hits_1;	// TLB.scala:87:40
    automatic logic        _r_sectored_repl_addr_valids_T_4;	// package.scala:72:59
    automatic logic        sector_hits_2;	// TLB.scala:87:40
    automatic logic        _r_sectored_repl_addr_valids_T_6;	// package.scala:72:59
    automatic logic        sector_hits_3;	// TLB.scala:87:40
    automatic logic        _r_sectored_repl_addr_valids_T_8;	// package.scala:72:59
    automatic logic        sector_hits_4;	// TLB.scala:87:40
    automatic logic        _r_sectored_repl_addr_valids_T_10;	// package.scala:72:59
    automatic logic        sector_hits_5;	// TLB.scala:87:40
    automatic logic        _r_sectored_repl_addr_valids_T_12;	// package.scala:72:59
    automatic logic        sector_hits_6;	// TLB.scala:87:40
    automatic logic        _r_sectored_repl_addr_valids_T_14;	// package.scala:72:59
    automatic logic        sector_hits_7;	// TLB.scala:87:40
    automatic logic        newEntry_g;	// TLB.scala:226:25
    automatic logic        newEntry_sr;	// PTW.scala:77:35
    automatic logic        newEntry_sw;	// PTW.scala:78:40
    automatic logic        newEntry_sx;	// PTW.scala:79:35
    automatic logic        _GEN_26 = io_ptw_resp_valid & ~io_ptw_resp_bits_homogeneous;	// TLB.scala:118:14, :167:56, :220:20, :240:{37,68}
    automatic logic        _GEN_27;	// TLB.scala:167:56, :220:20, :240:68, :243:34
    automatic logic        _GEN_28;	// TLB.scala:166:30, :220:20, :240:68
    automatic logic        _GEN_29;	// TLB.scala:166:30, :220:20, :240:68
    automatic logic        _GEN_30;	// TLB.scala:166:30, :220:20, :240:68
    automatic logic        _GEN_31;	// TLB.scala:166:30, :220:20, :240:68
    automatic logic        _GEN_32;	// TLB.scala:166:30, :220:20, :240:68
    automatic logic        _GEN_33;	// TLB.scala:166:30, :220:20, :240:68
    automatic logic        _GEN_34;	// TLB.scala:166:30, :220:20, :240:68
    automatic logic        _GEN_35;	// TLB.scala:166:30, :220:20, :240:68
    automatic logic [2:0]  waddr;	// TLB.scala:252:22
    automatic logic        _GEN_36;	// TLB.scala:253:75
    automatic logic        _GEN_37 =
      ~io_ptw_resp_bits_homogeneous | ~(io_ptw_resp_bits_level[1]);	// TLB.scala:165:29, :240:{37,68}, :245:{40,54}, :253:82
    automatic logic        _GEN_38;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_39;	// TLB.scala:122:16
    automatic logic        _GEN_40;	// TLB.scala:122:16
    automatic logic        _GEN_41;	// TLB.scala:122:16
    automatic logic [34:0] _sectored_entries_0_0_data_T;	// TLB.scala:123:24
    automatic logic        _GEN_42;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_43;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_44;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_45;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_46;	// TLB.scala:253:75
    automatic logic        _GEN_47;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_48;	// TLB.scala:122:16
    automatic logic        _GEN_49;	// TLB.scala:122:16
    automatic logic        _GEN_50;	// TLB.scala:122:16
    automatic logic [34:0] _sectored_entries_0_1_data_T;	// TLB.scala:123:24
    automatic logic        _GEN_51;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_52;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_53;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_54;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_55;	// TLB.scala:253:75
    automatic logic        _GEN_56;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_57;	// TLB.scala:122:16
    automatic logic        _GEN_58;	// TLB.scala:122:16
    automatic logic        _GEN_59;	// TLB.scala:122:16
    automatic logic [34:0] _sectored_entries_0_2_data_T;	// TLB.scala:123:24
    automatic logic        _GEN_60;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_61;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_62;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_63;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_64;	// TLB.scala:253:75
    automatic logic        _GEN_65;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_66;	// TLB.scala:122:16
    automatic logic        _GEN_67;	// TLB.scala:122:16
    automatic logic        _GEN_68;	// TLB.scala:122:16
    automatic logic [34:0] _sectored_entries_0_3_data_T;	// TLB.scala:123:24
    automatic logic        _GEN_69;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_70;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_71;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_72;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_73;	// TLB.scala:253:75
    automatic logic        _GEN_74;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_75;	// TLB.scala:122:16
    automatic logic        _GEN_76;	// TLB.scala:122:16
    automatic logic        _GEN_77;	// TLB.scala:122:16
    automatic logic [34:0] _sectored_entries_0_4_data_T;	// TLB.scala:123:24
    automatic logic        _GEN_78;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_79;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_80;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_81;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_82;	// TLB.scala:253:75
    automatic logic        _GEN_83;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_84;	// TLB.scala:122:16
    automatic logic        _GEN_85;	// TLB.scala:122:16
    automatic logic        _GEN_86;	// TLB.scala:122:16
    automatic logic [34:0] _sectored_entries_0_5_data_T;	// TLB.scala:123:24
    automatic logic        _GEN_87;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_88;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_89;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_90;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_91;	// TLB.scala:253:75
    automatic logic        _GEN_92;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_93;	// TLB.scala:122:16
    automatic logic        _GEN_94;	// TLB.scala:122:16
    automatic logic        _GEN_95;	// TLB.scala:122:16
    automatic logic [34:0] _sectored_entries_0_6_data_T;	// TLB.scala:123:24
    automatic logic        _GEN_96;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_97;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_98;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_99;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_100;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_101;	// TLB.scala:122:16
    automatic logic        _GEN_102;	// TLB.scala:122:16
    automatic logic        _GEN_103;	// TLB.scala:122:16
    automatic logic [34:0] _sectored_entries_0_7_data_T;	// TLB.scala:123:24
    automatic logic        _GEN_104;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_105;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_106;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_107;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic [2:0]  _GEN_108;	// OneHot.scala:30:18
    automatic logic [2:0]  _GEN_109;	// OneHot.scala:31:18
    automatic logic        _GEN_110;	// TLB.scala:363:25
    automatic logic [24:0] _GEN_111;	// TLB.scala:88:41
    automatic logic        _GEN_112;	// TLB.scala:88:66
    automatic logic        _GEN_113 = io_req_bits_vaddr[13:12] == 2'h0;	// TLB.scala:131:58, :163:30, :173:18, package.scala:154:13
    automatic logic        _GEN_114;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_115 = io_req_bits_vaddr[13:12] == 2'h1;	// TLB.scala:131:58, :163:30, package.scala:15:47, :154:13
    automatic logic        _GEN_116;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_117 = io_req_bits_vaddr[13:12] == 2'h2;	// TLB.scala:108:28, :131:58, :163:30, package.scala:154:13
    automatic logic        _GEN_118;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_119;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_120;	// TLB.scala:135:61
    automatic logic [24:0] _GEN_121;	// TLB.scala:88:41
    automatic logic        _GEN_122;	// TLB.scala:88:66
    automatic logic        _GEN_123;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_124;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_125;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_126;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_127;	// TLB.scala:135:61
    automatic logic [24:0] _GEN_128;	// TLB.scala:88:41
    automatic logic        _GEN_129;	// TLB.scala:88:66
    automatic logic        _GEN_130;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_131;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_132;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_133;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_134;	// TLB.scala:135:61
    automatic logic [24:0] _GEN_135;	// TLB.scala:88:41
    automatic logic        _GEN_136;	// TLB.scala:88:66
    automatic logic        _GEN_137;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_138;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_139;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_140;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_141;	// TLB.scala:135:61
    automatic logic [24:0] _GEN_142;	// TLB.scala:88:41
    automatic logic        _GEN_143;	// TLB.scala:88:66
    automatic logic        _GEN_144;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_145;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_146;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_147;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_148;	// TLB.scala:135:61
    automatic logic [24:0] _GEN_149;	// TLB.scala:88:41
    automatic logic        _GEN_150;	// TLB.scala:88:66
    automatic logic        _GEN_151;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_152;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_153;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_154;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_155;	// TLB.scala:135:61
    automatic logic [24:0] _GEN_156;	// TLB.scala:88:41
    automatic logic        _GEN_157;	// TLB.scala:88:66
    automatic logic        _GEN_158;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_159;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_160;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_161;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_162;	// TLB.scala:135:61
    automatic logic [24:0] _GEN_163;	// TLB.scala:88:41
    automatic logic        _GEN_164;	// TLB.scala:88:66
    automatic logic        _GEN_165;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_166;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_167;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_168;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_169;	// TLB.scala:135:61
    automatic logic        _GEN_170 = multipleHits | reset;	// Misc.scala:182:49, TLB.scala:392:24
    invalidate_refill = _io_ptw_req_valid_T | (&state) | io_sfence_valid;	// TLB.scala:173:18, :188:88, package.scala:15:47
    newEntry_c =
      legal_address & ({mpu_ppn[19], _GEN_2[16], mpu_ppn[14:13]} == 4'h0 | ~(|_GEN_4));	// OneHot.scala:32:14, Parameters.scala:137:{31,49,52,67}, :615:89, TLB.scala:189:20, :198:67, :200:19
    newEntry_pr = legal_address & ~deny_access_to_debug & _pmp_io_r;	// TLB.scala:193:19, :198:67, :203:48, :204:{44,66}
    newEntry_pw =
      legal_address & (~(|_GEN_22) | ~(|_GEN_23) | ~(|_GEN_24) | ~(|_GEN_25) | ~(|_GEN_4))
      & ~deny_access_to_debug & _pmp_io_w;	// Parameters.scala:137:{49,52,67}, :615:89, TLB.scala:193:19, :198:67, :203:48, :204:44, :205:70
    newEntry_ppp =
      legal_address
      & (~(|_GEN_22) | ~(|_GEN_23) | ~(|_GEN_24) | ~(|_GEN_25) | ~(|_GEN_4));	// Parameters.scala:137:{49,52,67}, :615:89, TLB.scala:198:67, :200:19
    newEntry_pal =
      legal_address
      & (~(|_GEN_22) | ~(|_GEN_23) | ~(|_GEN_24) | ~(|_GEN_25) | ~(|_GEN_4));	// Parameters.scala:137:{49,52,67}, :615:89, TLB.scala:198:67, :200:19
    newEntry_paa =
      legal_address
      & (~(|_GEN_22) | ~(|_GEN_23) | ~(|_GEN_24) | ~(|_GEN_25) | ~(|_GEN_4));	// Parameters.scala:137:{49,52,67}, :615:89, TLB.scala:198:67, :200:19
    newEntry_eff =
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
            _GEN_21[3],
            _GEN_21[1:0],
            mpu_ppn[8],
            mpu_ppn[5:4],
            mpu_ppn[1]} == 8'h0);	// Parameters.scala:137:{31,49,52,67}, :615:89, Replacement.scala:168:70, TLB.scala:189:20, :190:20, :198:67, :200:19
    _r_sectored_repl_addr_valids_T =
      sectored_entries_0_0_valid_0 | sectored_entries_0_0_valid_1;	// TLB.scala:165:29, package.scala:72:59
    sector_hits_0 =
      (_r_sectored_repl_addr_valids_T | sectored_entries_0_0_valid_2
       | sectored_entries_0_0_valid_3) & _hitsVec_T == 25'h0;	// TLB.scala:87:40, :88:{41,66}, :165:29, package.scala:72:59
    _r_sectored_repl_addr_valids_T_2 =
      sectored_entries_0_1_valid_0 | sectored_entries_0_1_valid_1;	// TLB.scala:165:29, package.scala:72:59
    sector_hits_1 =
      (_r_sectored_repl_addr_valids_T_2 | sectored_entries_0_1_valid_2
       | sectored_entries_0_1_valid_3) & _hitsVec_T_4 == 25'h0;	// TLB.scala:87:40, :88:{41,66}, :165:29, package.scala:72:59
    _r_sectored_repl_addr_valids_T_4 =
      sectored_entries_0_2_valid_0 | sectored_entries_0_2_valid_1;	// TLB.scala:165:29, package.scala:72:59
    sector_hits_2 =
      (_r_sectored_repl_addr_valids_T_4 | sectored_entries_0_2_valid_2
       | sectored_entries_0_2_valid_3) & _hitsVec_T_8 == 25'h0;	// TLB.scala:87:40, :88:{41,66}, :165:29, package.scala:72:59
    _r_sectored_repl_addr_valids_T_6 =
      sectored_entries_0_3_valid_0 | sectored_entries_0_3_valid_1;	// TLB.scala:165:29, package.scala:72:59
    sector_hits_3 =
      (_r_sectored_repl_addr_valids_T_6 | sectored_entries_0_3_valid_2
       | sectored_entries_0_3_valid_3) & _hitsVec_T_12 == 25'h0;	// TLB.scala:87:40, :88:{41,66}, :165:29, package.scala:72:59
    _r_sectored_repl_addr_valids_T_8 =
      sectored_entries_0_4_valid_0 | sectored_entries_0_4_valid_1;	// TLB.scala:165:29, package.scala:72:59
    sector_hits_4 =
      (_r_sectored_repl_addr_valids_T_8 | sectored_entries_0_4_valid_2
       | sectored_entries_0_4_valid_3) & _hitsVec_T_16 == 25'h0;	// TLB.scala:87:40, :88:{41,66}, :165:29, package.scala:72:59
    _r_sectored_repl_addr_valids_T_10 =
      sectored_entries_0_5_valid_0 | sectored_entries_0_5_valid_1;	// TLB.scala:165:29, package.scala:72:59
    sector_hits_5 =
      (_r_sectored_repl_addr_valids_T_10 | sectored_entries_0_5_valid_2
       | sectored_entries_0_5_valid_3) & _hitsVec_T_20 == 25'h0;	// TLB.scala:87:40, :88:{41,66}, :165:29, package.scala:72:59
    _r_sectored_repl_addr_valids_T_12 =
      sectored_entries_0_6_valid_0 | sectored_entries_0_6_valid_1;	// TLB.scala:165:29, package.scala:72:59
    sector_hits_6 =
      (_r_sectored_repl_addr_valids_T_12 | sectored_entries_0_6_valid_2
       | sectored_entries_0_6_valid_3) & _hitsVec_T_24 == 25'h0;	// TLB.scala:87:40, :88:{41,66}, :165:29, package.scala:72:59
    _r_sectored_repl_addr_valids_T_14 =
      sectored_entries_0_7_valid_0 | sectored_entries_0_7_valid_1;	// TLB.scala:165:29, package.scala:72:59
    sector_hits_7 =
      (_r_sectored_repl_addr_valids_T_14 | sectored_entries_0_7_valid_2
       | sectored_entries_0_7_valid_3) & _hitsVec_T_28 == 25'h0;	// TLB.scala:87:40, :88:{41,66}, :165:29, package.scala:72:59
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
    _GEN_27 = _GEN_26 ? ~invalidate_refill : special_entry_valid_0;	// TLB.scala:118:14, :122:16, :126:46, :165:29, :167:56, :182:27, :188:88, :220:20, :240:68, :243:34
    _GEN_28 =
      io_ptw_resp_valid & io_ptw_resp_bits_homogeneous & ~(io_ptw_resp_bits_level[1])
      & r_superpage_repl_addr == 2'h0;	// TLB.scala:166:30, :173:18, :175:34, :220:20, :240:68, :245:40, :246:82
    _GEN_29 = _GEN_28 ? ~invalidate_refill : superpage_entries_0_valid_0;	// TLB.scala:122:16, :126:46, :165:29, :166:30, :182:27, :188:88, :220:20, :240:68, :243:34
    _GEN_30 =
      io_ptw_resp_valid & io_ptw_resp_bits_homogeneous & ~(io_ptw_resp_bits_level[1])
      & r_superpage_repl_addr == 2'h1;	// TLB.scala:166:30, :175:34, :220:20, :240:68, :245:40, :246:82, package.scala:15:47
    _GEN_31 = _GEN_30 ? ~invalidate_refill : superpage_entries_1_valid_0;	// TLB.scala:122:16, :126:46, :165:29, :166:30, :182:27, :188:88, :220:20, :240:68, :243:34
    _GEN_32 =
      io_ptw_resp_valid & io_ptw_resp_bits_homogeneous & ~(io_ptw_resp_bits_level[1])
      & r_superpage_repl_addr == 2'h2;	// TLB.scala:108:28, :166:30, :175:34, :220:20, :240:68, :245:40, :246:82
    _GEN_33 = _GEN_32 ? ~invalidate_refill : superpage_entries_2_valid_0;	// TLB.scala:122:16, :126:46, :165:29, :166:30, :182:27, :188:88, :220:20, :240:68, :243:34
    _GEN_34 =
      io_ptw_resp_valid & io_ptw_resp_bits_homogeneous & ~(io_ptw_resp_bits_level[1])
      & (&r_superpage_repl_addr);	// TLB.scala:166:30, :175:34, :220:20, :240:68, :245:40, :246:82
    _GEN_35 = _GEN_34 ? ~invalidate_refill : superpage_entries_3_valid_0;	// TLB.scala:122:16, :126:46, :165:29, :166:30, :182:27, :188:88, :220:20, :240:68, :243:34
    waddr = r_sectored_hit ? r_sectored_hit_addr : r_sectored_repl_addr;	// TLB.scala:176:33, :177:32, :178:27, :252:22
    _GEN_36 = waddr == 3'h0;	// Replacement.scala:168:70, TLB.scala:252:22, :253:75
    _GEN_38 = ~io_ptw_resp_valid | _GEN_37 | ~_GEN_36;	// TLB.scala:165:29, :220:20, :240:68, :245:54, :253:{75,82}
    _GEN_39 = r_refill_tag[1:0] == 2'h0;	// TLB.scala:122:16, :173:18, :174:25, package.scala:154:13
    _GEN_40 = r_refill_tag[1:0] == 2'h1;	// TLB.scala:122:16, :174:25, package.scala:15:47, :154:13
    _GEN_41 = r_refill_tag[1:0] == 2'h2;	// TLB.scala:108:28, :122:16, :174:25, package.scala:154:13
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
       1'h0};	// PTW.scala:77:35, :78:40, :79:35, TLB.scala:123:24, :200:19, :204:66, :205:70, :209:65, :223:18, :226:25, :343:48, :346:41, :349:41, :352:51
    _GEN_42 =
      _GEN_38
        ? sectored_entries_0_0_valid_0
        : ~invalidate_refill & (_GEN_39 | r_sectored_hit & sectored_entries_0_0_valid_0);	// TLB.scala:122:16, :126:46, :165:29, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34
    _GEN_43 =
      _GEN_38
        ? sectored_entries_0_0_valid_1
        : ~invalidate_refill & (_GEN_40 | r_sectored_hit & sectored_entries_0_0_valid_1);	// TLB.scala:122:16, :126:46, :165:29, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34
    _GEN_44 =
      _GEN_38
        ? sectored_entries_0_0_valid_2
        : ~invalidate_refill & (_GEN_41 | r_sectored_hit & sectored_entries_0_0_valid_2);	// TLB.scala:122:16, :126:46, :165:29, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34
    _GEN_45 =
      _GEN_38
        ? sectored_entries_0_0_valid_3
        : ~invalidate_refill
          & ((&(r_refill_tag[1:0])) | r_sectored_hit & sectored_entries_0_0_valid_3);	// TLB.scala:122:16, :126:46, :165:29, :174:25, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34, package.scala:154:13
    _GEN_46 = waddr == 3'h1;	// TLB.scala:192:27, :252:22, :253:75
    _GEN_47 = ~io_ptw_resp_valid | _GEN_37 | ~_GEN_46;	// TLB.scala:165:29, :220:20, :240:68, :245:54, :253:{75,82}
    _GEN_48 = r_refill_tag[1:0] == 2'h0;	// TLB.scala:122:16, :173:18, :174:25, package.scala:154:13
    _GEN_49 = r_refill_tag[1:0] == 2'h1;	// TLB.scala:122:16, :174:25, package.scala:15:47, :154:13
    _GEN_50 = r_refill_tag[1:0] == 2'h2;	// TLB.scala:108:28, :122:16, :174:25, package.scala:154:13
    _sectored_entries_0_1_data_T =
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
       1'h0};	// PTW.scala:77:35, :78:40, :79:35, TLB.scala:123:24, :200:19, :204:66, :205:70, :209:65, :223:18, :226:25, :343:48, :346:41, :349:41, :352:51
    _GEN_51 =
      _GEN_47
        ? sectored_entries_0_1_valid_0
        : ~invalidate_refill & (_GEN_48 | r_sectored_hit & sectored_entries_0_1_valid_0);	// TLB.scala:122:16, :126:46, :165:29, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34
    _GEN_52 =
      _GEN_47
        ? sectored_entries_0_1_valid_1
        : ~invalidate_refill & (_GEN_49 | r_sectored_hit & sectored_entries_0_1_valid_1);	// TLB.scala:122:16, :126:46, :165:29, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34
    _GEN_53 =
      _GEN_47
        ? sectored_entries_0_1_valid_2
        : ~invalidate_refill & (_GEN_50 | r_sectored_hit & sectored_entries_0_1_valid_2);	// TLB.scala:122:16, :126:46, :165:29, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34
    _GEN_54 =
      _GEN_47
        ? sectored_entries_0_1_valid_3
        : ~invalidate_refill
          & ((&(r_refill_tag[1:0])) | r_sectored_hit & sectored_entries_0_1_valid_3);	// TLB.scala:122:16, :126:46, :165:29, :174:25, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34, package.scala:154:13
    _GEN_55 = waddr == 3'h2;	// Mux.scala:47:69, TLB.scala:252:22, :253:75
    _GEN_56 = ~io_ptw_resp_valid | _GEN_37 | ~_GEN_55;	// TLB.scala:165:29, :220:20, :240:68, :245:54, :253:{75,82}
    _GEN_57 = r_refill_tag[1:0] == 2'h0;	// TLB.scala:122:16, :173:18, :174:25, package.scala:154:13
    _GEN_58 = r_refill_tag[1:0] == 2'h1;	// TLB.scala:122:16, :174:25, package.scala:15:47, :154:13
    _GEN_59 = r_refill_tag[1:0] == 2'h2;	// TLB.scala:108:28, :122:16, :174:25, package.scala:154:13
    _sectored_entries_0_2_data_T =
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
       1'h0};	// PTW.scala:77:35, :78:40, :79:35, TLB.scala:123:24, :200:19, :204:66, :205:70, :209:65, :223:18, :226:25, :343:48, :346:41, :349:41, :352:51
    _GEN_60 =
      _GEN_56
        ? sectored_entries_0_2_valid_0
        : ~invalidate_refill & (_GEN_57 | r_sectored_hit & sectored_entries_0_2_valid_0);	// TLB.scala:122:16, :126:46, :165:29, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34
    _GEN_61 =
      _GEN_56
        ? sectored_entries_0_2_valid_1
        : ~invalidate_refill & (_GEN_58 | r_sectored_hit & sectored_entries_0_2_valid_1);	// TLB.scala:122:16, :126:46, :165:29, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34
    _GEN_62 =
      _GEN_56
        ? sectored_entries_0_2_valid_2
        : ~invalidate_refill & (_GEN_59 | r_sectored_hit & sectored_entries_0_2_valid_2);	// TLB.scala:122:16, :126:46, :165:29, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34
    _GEN_63 =
      _GEN_56
        ? sectored_entries_0_2_valid_3
        : ~invalidate_refill
          & ((&(r_refill_tag[1:0])) | r_sectored_hit & sectored_entries_0_2_valid_3);	// TLB.scala:122:16, :126:46, :165:29, :174:25, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34, package.scala:154:13
    _GEN_64 = waddr == 3'h3;	// Mux.scala:47:69, TLB.scala:252:22, :253:75
    _GEN_65 = ~io_ptw_resp_valid | _GEN_37 | ~_GEN_64;	// TLB.scala:165:29, :220:20, :240:68, :245:54, :253:{75,82}
    _GEN_66 = r_refill_tag[1:0] == 2'h0;	// TLB.scala:122:16, :173:18, :174:25, package.scala:154:13
    _GEN_67 = r_refill_tag[1:0] == 2'h1;	// TLB.scala:122:16, :174:25, package.scala:15:47, :154:13
    _GEN_68 = r_refill_tag[1:0] == 2'h2;	// TLB.scala:108:28, :122:16, :174:25, package.scala:154:13
    _sectored_entries_0_3_data_T =
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
       1'h0};	// PTW.scala:77:35, :78:40, :79:35, TLB.scala:123:24, :200:19, :204:66, :205:70, :209:65, :223:18, :226:25, :343:48, :346:41, :349:41, :352:51
    _GEN_69 =
      _GEN_65
        ? sectored_entries_0_3_valid_0
        : ~invalidate_refill & (_GEN_66 | r_sectored_hit & sectored_entries_0_3_valid_0);	// TLB.scala:122:16, :126:46, :165:29, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34
    _GEN_70 =
      _GEN_65
        ? sectored_entries_0_3_valid_1
        : ~invalidate_refill & (_GEN_67 | r_sectored_hit & sectored_entries_0_3_valid_1);	// TLB.scala:122:16, :126:46, :165:29, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34
    _GEN_71 =
      _GEN_65
        ? sectored_entries_0_3_valid_2
        : ~invalidate_refill & (_GEN_68 | r_sectored_hit & sectored_entries_0_3_valid_2);	// TLB.scala:122:16, :126:46, :165:29, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34
    _GEN_72 =
      _GEN_65
        ? sectored_entries_0_3_valid_3
        : ~invalidate_refill
          & ((&(r_refill_tag[1:0])) | r_sectored_hit & sectored_entries_0_3_valid_3);	// TLB.scala:122:16, :126:46, :165:29, :174:25, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34, package.scala:154:13
    _GEN_73 = waddr == 3'h4;	// TLB.scala:252:22, :253:75
    _GEN_74 = ~io_ptw_resp_valid | _GEN_37 | ~_GEN_73;	// TLB.scala:165:29, :220:20, :240:68, :245:54, :253:{75,82}
    _GEN_75 = r_refill_tag[1:0] == 2'h0;	// TLB.scala:122:16, :173:18, :174:25, package.scala:154:13
    _GEN_76 = r_refill_tag[1:0] == 2'h1;	// TLB.scala:122:16, :174:25, package.scala:15:47, :154:13
    _GEN_77 = r_refill_tag[1:0] == 2'h2;	// TLB.scala:108:28, :122:16, :174:25, package.scala:154:13
    _sectored_entries_0_4_data_T =
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
       1'h0};	// PTW.scala:77:35, :78:40, :79:35, TLB.scala:123:24, :200:19, :204:66, :205:70, :209:65, :223:18, :226:25, :343:48, :346:41, :349:41, :352:51
    _GEN_78 =
      _GEN_74
        ? sectored_entries_0_4_valid_0
        : ~invalidate_refill & (_GEN_75 | r_sectored_hit & sectored_entries_0_4_valid_0);	// TLB.scala:122:16, :126:46, :165:29, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34
    _GEN_79 =
      _GEN_74
        ? sectored_entries_0_4_valid_1
        : ~invalidate_refill & (_GEN_76 | r_sectored_hit & sectored_entries_0_4_valid_1);	// TLB.scala:122:16, :126:46, :165:29, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34
    _GEN_80 =
      _GEN_74
        ? sectored_entries_0_4_valid_2
        : ~invalidate_refill & (_GEN_77 | r_sectored_hit & sectored_entries_0_4_valid_2);	// TLB.scala:122:16, :126:46, :165:29, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34
    _GEN_81 =
      _GEN_74
        ? sectored_entries_0_4_valid_3
        : ~invalidate_refill
          & ((&(r_refill_tag[1:0])) | r_sectored_hit & sectored_entries_0_4_valid_3);	// TLB.scala:122:16, :126:46, :165:29, :174:25, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34, package.scala:154:13
    _GEN_82 = waddr == 3'h5;	// TLB.scala:252:22, :253:75
    _GEN_83 = ~io_ptw_resp_valid | _GEN_37 | ~_GEN_82;	// TLB.scala:165:29, :220:20, :240:68, :245:54, :253:{75,82}
    _GEN_84 = r_refill_tag[1:0] == 2'h0;	// TLB.scala:122:16, :173:18, :174:25, package.scala:154:13
    _GEN_85 = r_refill_tag[1:0] == 2'h1;	// TLB.scala:122:16, :174:25, package.scala:15:47, :154:13
    _GEN_86 = r_refill_tag[1:0] == 2'h2;	// TLB.scala:108:28, :122:16, :174:25, package.scala:154:13
    _sectored_entries_0_5_data_T =
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
       1'h0};	// PTW.scala:77:35, :78:40, :79:35, TLB.scala:123:24, :200:19, :204:66, :205:70, :209:65, :223:18, :226:25, :343:48, :346:41, :349:41, :352:51
    _GEN_87 =
      _GEN_83
        ? sectored_entries_0_5_valid_0
        : ~invalidate_refill & (_GEN_84 | r_sectored_hit & sectored_entries_0_5_valid_0);	// TLB.scala:122:16, :126:46, :165:29, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34
    _GEN_88 =
      _GEN_83
        ? sectored_entries_0_5_valid_1
        : ~invalidate_refill & (_GEN_85 | r_sectored_hit & sectored_entries_0_5_valid_1);	// TLB.scala:122:16, :126:46, :165:29, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34
    _GEN_89 =
      _GEN_83
        ? sectored_entries_0_5_valid_2
        : ~invalidate_refill & (_GEN_86 | r_sectored_hit & sectored_entries_0_5_valid_2);	// TLB.scala:122:16, :126:46, :165:29, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34
    _GEN_90 =
      _GEN_83
        ? sectored_entries_0_5_valid_3
        : ~invalidate_refill
          & ((&(r_refill_tag[1:0])) | r_sectored_hit & sectored_entries_0_5_valid_3);	// TLB.scala:122:16, :126:46, :165:29, :174:25, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34, package.scala:154:13
    _GEN_91 = waddr == 3'h6;	// TLB.scala:252:22, :253:75
    _GEN_92 = ~io_ptw_resp_valid | _GEN_37 | ~_GEN_91;	// TLB.scala:165:29, :220:20, :240:68, :245:54, :253:{75,82}
    _GEN_93 = r_refill_tag[1:0] == 2'h0;	// TLB.scala:122:16, :173:18, :174:25, package.scala:154:13
    _GEN_94 = r_refill_tag[1:0] == 2'h1;	// TLB.scala:122:16, :174:25, package.scala:15:47, :154:13
    _GEN_95 = r_refill_tag[1:0] == 2'h2;	// TLB.scala:108:28, :122:16, :174:25, package.scala:154:13
    _sectored_entries_0_6_data_T =
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
       1'h0};	// PTW.scala:77:35, :78:40, :79:35, TLB.scala:123:24, :200:19, :204:66, :205:70, :209:65, :223:18, :226:25, :343:48, :346:41, :349:41, :352:51
    _GEN_96 =
      _GEN_92
        ? sectored_entries_0_6_valid_0
        : ~invalidate_refill & (_GEN_93 | r_sectored_hit & sectored_entries_0_6_valid_0);	// TLB.scala:122:16, :126:46, :165:29, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34
    _GEN_97 =
      _GEN_92
        ? sectored_entries_0_6_valid_1
        : ~invalidate_refill & (_GEN_94 | r_sectored_hit & sectored_entries_0_6_valid_1);	// TLB.scala:122:16, :126:46, :165:29, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34
    _GEN_98 =
      _GEN_92
        ? sectored_entries_0_6_valid_2
        : ~invalidate_refill & (_GEN_95 | r_sectored_hit & sectored_entries_0_6_valid_2);	// TLB.scala:122:16, :126:46, :165:29, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34
    _GEN_99 =
      _GEN_92
        ? sectored_entries_0_6_valid_3
        : ~invalidate_refill
          & ((&(r_refill_tag[1:0])) | r_sectored_hit & sectored_entries_0_6_valid_3);	// TLB.scala:122:16, :126:46, :165:29, :174:25, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34, package.scala:154:13
    _GEN_100 = ~io_ptw_resp_valid | _GEN_37 | ~(&waddr);	// TLB.scala:165:29, :220:20, :240:68, :245:54, :252:22, :253:{75,82}
    _GEN_101 = r_refill_tag[1:0] == 2'h0;	// TLB.scala:122:16, :173:18, :174:25, package.scala:154:13
    _GEN_102 = r_refill_tag[1:0] == 2'h1;	// TLB.scala:122:16, :174:25, package.scala:15:47, :154:13
    _GEN_103 = r_refill_tag[1:0] == 2'h2;	// TLB.scala:108:28, :122:16, :174:25, package.scala:154:13
    _sectored_entries_0_7_data_T =
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
       1'h0};	// PTW.scala:77:35, :78:40, :79:35, TLB.scala:123:24, :200:19, :204:66, :205:70, :209:65, :223:18, :226:25, :343:48, :346:41, :349:41, :352:51
    _GEN_104 =
      _GEN_100
        ? sectored_entries_0_7_valid_0
        : ~invalidate_refill & (_GEN_101 | r_sectored_hit & sectored_entries_0_7_valid_0);	// TLB.scala:122:16, :126:46, :165:29, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34
    _GEN_105 =
      _GEN_100
        ? sectored_entries_0_7_valid_1
        : ~invalidate_refill & (_GEN_102 | r_sectored_hit & sectored_entries_0_7_valid_1);	// TLB.scala:122:16, :126:46, :165:29, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34
    _GEN_106 =
      _GEN_100
        ? sectored_entries_0_7_valid_2
        : ~invalidate_refill & (_GEN_103 | r_sectored_hit & sectored_entries_0_7_valid_2);	// TLB.scala:122:16, :126:46, :165:29, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34
    _GEN_107 =
      _GEN_100
        ? sectored_entries_0_7_valid_3
        : ~invalidate_refill
          & ((&(r_refill_tag[1:0])) | r_sectored_hit & sectored_entries_0_7_valid_3);	// TLB.scala:122:16, :126:46, :165:29, :174:25, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34, package.scala:154:13
    _GEN_108 = {sector_hits_7, sector_hits_6, sector_hits_5};	// OneHot.scala:30:18, TLB.scala:87:40
    _GEN_109 = {sector_hits_3, sector_hits_2, sector_hits_1};	// OneHot.scala:31:18, TLB.scala:87:40
    _GEN_110 = state == 2'h0 & io_req_valid & tlb_miss;	// TLB.scala:173:18, :325:40, :341:25, :363:25
    _GEN_111 = sectored_entries_0_0_tag[26:2] ^ io_req_bits_vaddr[38:14];	// TLB.scala:88:41, :163:30, :165:29
    _GEN_112 = _GEN_111 == 25'h0;	// TLB.scala:88:{41,66}
    _GEN_114 = _GEN_112 & _GEN_113;	// TLB.scala:88:66, :131:{34,58}, :220:20
    _GEN_116 = _GEN_112 & _GEN_115;	// TLB.scala:88:66, :131:{34,58}, :220:20
    _GEN_118 = _GEN_112 & _GEN_117;	// TLB.scala:88:66, :131:{34,58}, :220:20
    _GEN_119 = _GEN_112 & (&(io_req_bits_vaddr[13:12]));	// TLB.scala:88:66, :131:{34,58}, :163:30, :220:20, package.scala:154:13
    _GEN_120 = _GEN_111[24:16] == 9'h0;	// TLB.scala:88:41, :135:{26,61}
    _GEN_121 = sectored_entries_0_1_tag[26:2] ^ io_req_bits_vaddr[38:14];	// TLB.scala:88:41, :163:30, :165:29
    _GEN_122 = _GEN_121 == 25'h0;	// TLB.scala:88:{41,66}
    _GEN_123 = _GEN_122 & _GEN_113;	// TLB.scala:88:66, :131:{34,58}, :220:20
    _GEN_124 = _GEN_122 & _GEN_115;	// TLB.scala:88:66, :131:{34,58}, :220:20
    _GEN_125 = _GEN_122 & _GEN_117;	// TLB.scala:88:66, :131:{34,58}, :220:20
    _GEN_126 = _GEN_122 & (&(io_req_bits_vaddr[13:12]));	// TLB.scala:88:66, :131:{34,58}, :163:30, :220:20, package.scala:154:13
    _GEN_127 = _GEN_121[24:16] == 9'h0;	// TLB.scala:88:41, :135:{26,61}
    _GEN_128 = sectored_entries_0_2_tag[26:2] ^ io_req_bits_vaddr[38:14];	// TLB.scala:88:41, :163:30, :165:29
    _GEN_129 = _GEN_128 == 25'h0;	// TLB.scala:88:{41,66}
    _GEN_130 = _GEN_129 & _GEN_113;	// TLB.scala:88:66, :131:{34,58}, :220:20
    _GEN_131 = _GEN_129 & _GEN_115;	// TLB.scala:88:66, :131:{34,58}, :220:20
    _GEN_132 = _GEN_129 & _GEN_117;	// TLB.scala:88:66, :131:{34,58}, :220:20
    _GEN_133 = _GEN_129 & (&(io_req_bits_vaddr[13:12]));	// TLB.scala:88:66, :131:{34,58}, :163:30, :220:20, package.scala:154:13
    _GEN_134 = _GEN_128[24:16] == 9'h0;	// TLB.scala:88:41, :135:{26,61}
    _GEN_135 = sectored_entries_0_3_tag[26:2] ^ io_req_bits_vaddr[38:14];	// TLB.scala:88:41, :163:30, :165:29
    _GEN_136 = _GEN_135 == 25'h0;	// TLB.scala:88:{41,66}
    _GEN_137 = _GEN_136 & _GEN_113;	// TLB.scala:88:66, :131:{34,58}, :220:20
    _GEN_138 = _GEN_136 & _GEN_115;	// TLB.scala:88:66, :131:{34,58}, :220:20
    _GEN_139 = _GEN_136 & _GEN_117;	// TLB.scala:88:66, :131:{34,58}, :220:20
    _GEN_140 = _GEN_136 & (&(io_req_bits_vaddr[13:12]));	// TLB.scala:88:66, :131:{34,58}, :163:30, :220:20, package.scala:154:13
    _GEN_141 = _GEN_135[24:16] == 9'h0;	// TLB.scala:88:41, :135:{26,61}
    _GEN_142 = sectored_entries_0_4_tag[26:2] ^ io_req_bits_vaddr[38:14];	// TLB.scala:88:41, :163:30, :165:29
    _GEN_143 = _GEN_142 == 25'h0;	// TLB.scala:88:{41,66}
    _GEN_144 = _GEN_143 & _GEN_113;	// TLB.scala:88:66, :131:{34,58}, :220:20
    _GEN_145 = _GEN_143 & _GEN_115;	// TLB.scala:88:66, :131:{34,58}, :220:20
    _GEN_146 = _GEN_143 & _GEN_117;	// TLB.scala:88:66, :131:{34,58}, :220:20
    _GEN_147 = _GEN_143 & (&(io_req_bits_vaddr[13:12]));	// TLB.scala:88:66, :131:{34,58}, :163:30, :220:20, package.scala:154:13
    _GEN_148 = _GEN_142[24:16] == 9'h0;	// TLB.scala:88:41, :135:{26,61}
    _GEN_149 = sectored_entries_0_5_tag[26:2] ^ io_req_bits_vaddr[38:14];	// TLB.scala:88:41, :163:30, :165:29
    _GEN_150 = _GEN_149 == 25'h0;	// TLB.scala:88:{41,66}
    _GEN_151 = _GEN_150 & _GEN_113;	// TLB.scala:88:66, :131:{34,58}, :220:20
    _GEN_152 = _GEN_150 & _GEN_115;	// TLB.scala:88:66, :131:{34,58}, :220:20
    _GEN_153 = _GEN_150 & _GEN_117;	// TLB.scala:88:66, :131:{34,58}, :220:20
    _GEN_154 = _GEN_150 & (&(io_req_bits_vaddr[13:12]));	// TLB.scala:88:66, :131:{34,58}, :163:30, :220:20, package.scala:154:13
    _GEN_155 = _GEN_149[24:16] == 9'h0;	// TLB.scala:88:41, :135:{26,61}
    _GEN_156 = sectored_entries_0_6_tag[26:2] ^ io_req_bits_vaddr[38:14];	// TLB.scala:88:41, :163:30, :165:29
    _GEN_157 = _GEN_156 == 25'h0;	// TLB.scala:88:{41,66}
    _GEN_158 = _GEN_157 & _GEN_113;	// TLB.scala:88:66, :131:{34,58}, :220:20
    _GEN_159 = _GEN_157 & _GEN_115;	// TLB.scala:88:66, :131:{34,58}, :220:20
    _GEN_160 = _GEN_157 & _GEN_117;	// TLB.scala:88:66, :131:{34,58}, :220:20
    _GEN_161 = _GEN_157 & (&(io_req_bits_vaddr[13:12]));	// TLB.scala:88:66, :131:{34,58}, :163:30, :220:20, package.scala:154:13
    _GEN_162 = _GEN_156[24:16] == 9'h0;	// TLB.scala:88:41, :135:{26,61}
    _GEN_163 = sectored_entries_0_7_tag[26:2] ^ io_req_bits_vaddr[38:14];	// TLB.scala:88:41, :163:30, :165:29
    _GEN_164 = _GEN_163 == 25'h0;	// TLB.scala:88:{41,66}
    _GEN_165 = _GEN_164 & _GEN_113;	// TLB.scala:88:66, :131:{34,58}, :220:20
    _GEN_166 = _GEN_164 & _GEN_115;	// TLB.scala:88:66, :131:{34,58}, :220:20
    _GEN_167 = _GEN_164 & _GEN_117;	// TLB.scala:88:66, :131:{34,58}, :220:20
    _GEN_168 = _GEN_164 & (&(io_req_bits_vaddr[13:12]));	// TLB.scala:88:66, :131:{34,58}, :163:30, :220:20, package.scala:154:13
    _GEN_169 = _GEN_163[24:16] == 9'h0;	// TLB.scala:88:41, :135:{26,61}
    if (_GEN_38) begin	// TLB.scala:165:29, :220:20, :240:68
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_0_tag <= r_refill_tag;	// TLB.scala:165:29, :174:25
    if (~io_ptw_resp_valid | _GEN_37 | ~(_GEN_36 & _GEN_39)) begin	// TLB.scala:122:16, :123:15, :165:29, :220:20, :240:68, :245:54, :253:{75,82}
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_0_data_0 <= _sectored_entries_0_0_data_T;	// TLB.scala:123:24, :165:29
    if (~io_ptw_resp_valid | _GEN_37 | ~(_GEN_36 & _GEN_40)) begin	// TLB.scala:122:16, :123:15, :165:29, :220:20, :240:68, :245:54, :253:{75,82}
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_0_data_1 <= _sectored_entries_0_0_data_T;	// TLB.scala:123:24, :165:29
    if (~io_ptw_resp_valid | _GEN_37 | ~(_GEN_36 & _GEN_41)) begin	// TLB.scala:122:16, :123:15, :165:29, :220:20, :240:68, :245:54, :253:{75,82}
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_0_data_2 <= _sectored_entries_0_0_data_T;	// TLB.scala:123:24, :165:29
    if (~io_ptw_resp_valid | _GEN_37 | ~(_GEN_36 & (&(r_refill_tag[1:0])))) begin	// TLB.scala:122:16, :123:15, :165:29, :174:25, :220:20, :240:68, :245:54, :253:{75,82}, package.scala:154:13
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_0_data_3 <= _sectored_entries_0_0_data_T;	// TLB.scala:123:24, :165:29
    sectored_entries_0_0_valid_0 <=
      ~_GEN_170
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_120
                     ? ~(sectored_entries_0_0_data_0[0] | _GEN_114) & _GEN_42
                     : ~_GEN_114 & _GEN_42)
                : io_sfence_bits_rs2 & sectored_entries_0_0_data_0[13] & _GEN_42)
           : _GEN_42);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    sectored_entries_0_0_valid_1 <=
      ~_GEN_170
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_120
                     ? ~(sectored_entries_0_0_data_1[0] | _GEN_116) & _GEN_43
                     : ~_GEN_116 & _GEN_43)
                : io_sfence_bits_rs2 & sectored_entries_0_0_data_1[13] & _GEN_43)
           : _GEN_43);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    sectored_entries_0_0_valid_2 <=
      ~_GEN_170
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_120
                     ? ~(sectored_entries_0_0_data_2[0] | _GEN_118) & _GEN_44
                     : ~_GEN_118 & _GEN_44)
                : io_sfence_bits_rs2 & sectored_entries_0_0_data_2[13] & _GEN_44)
           : _GEN_44);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    sectored_entries_0_0_valid_3 <=
      ~_GEN_170
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_120
                     ? ~(sectored_entries_0_0_data_3[0] | _GEN_119) & _GEN_45
                     : ~_GEN_119 & _GEN_45)
                : io_sfence_bits_rs2 & sectored_entries_0_0_data_3[13] & _GEN_45)
           : _GEN_45);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    if (_GEN_47) begin	// TLB.scala:165:29, :220:20, :240:68
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_1_tag <= r_refill_tag;	// TLB.scala:165:29, :174:25
    if (~io_ptw_resp_valid | _GEN_37 | ~(_GEN_46 & _GEN_48)) begin	// TLB.scala:122:16, :123:15, :165:29, :220:20, :240:68, :245:54, :253:{75,82}
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_1_data_0 <= _sectored_entries_0_1_data_T;	// TLB.scala:123:24, :165:29
    if (~io_ptw_resp_valid | _GEN_37 | ~(_GEN_46 & _GEN_49)) begin	// TLB.scala:122:16, :123:15, :165:29, :220:20, :240:68, :245:54, :253:{75,82}
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_1_data_1 <= _sectored_entries_0_1_data_T;	// TLB.scala:123:24, :165:29
    if (~io_ptw_resp_valid | _GEN_37 | ~(_GEN_46 & _GEN_50)) begin	// TLB.scala:122:16, :123:15, :165:29, :220:20, :240:68, :245:54, :253:{75,82}
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_1_data_2 <= _sectored_entries_0_1_data_T;	// TLB.scala:123:24, :165:29
    if (~io_ptw_resp_valid | _GEN_37 | ~(_GEN_46 & (&(r_refill_tag[1:0])))) begin	// TLB.scala:122:16, :123:15, :165:29, :174:25, :220:20, :240:68, :245:54, :253:{75,82}, package.scala:154:13
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_1_data_3 <= _sectored_entries_0_1_data_T;	// TLB.scala:123:24, :165:29
    sectored_entries_0_1_valid_0 <=
      ~_GEN_170
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_127
                     ? ~(sectored_entries_0_1_data_0[0] | _GEN_123) & _GEN_51
                     : ~_GEN_123 & _GEN_51)
                : io_sfence_bits_rs2 & sectored_entries_0_1_data_0[13] & _GEN_51)
           : _GEN_51);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    sectored_entries_0_1_valid_1 <=
      ~_GEN_170
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_127
                     ? ~(sectored_entries_0_1_data_1[0] | _GEN_124) & _GEN_52
                     : ~_GEN_124 & _GEN_52)
                : io_sfence_bits_rs2 & sectored_entries_0_1_data_1[13] & _GEN_52)
           : _GEN_52);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    sectored_entries_0_1_valid_2 <=
      ~_GEN_170
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_127
                     ? ~(sectored_entries_0_1_data_2[0] | _GEN_125) & _GEN_53
                     : ~_GEN_125 & _GEN_53)
                : io_sfence_bits_rs2 & sectored_entries_0_1_data_2[13] & _GEN_53)
           : _GEN_53);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    sectored_entries_0_1_valid_3 <=
      ~_GEN_170
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_127
                     ? ~(sectored_entries_0_1_data_3[0] | _GEN_126) & _GEN_54
                     : ~_GEN_126 & _GEN_54)
                : io_sfence_bits_rs2 & sectored_entries_0_1_data_3[13] & _GEN_54)
           : _GEN_54);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    if (_GEN_56) begin	// TLB.scala:165:29, :220:20, :240:68
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_2_tag <= r_refill_tag;	// TLB.scala:165:29, :174:25
    if (~io_ptw_resp_valid | _GEN_37 | ~(_GEN_55 & _GEN_57)) begin	// TLB.scala:122:16, :123:15, :165:29, :220:20, :240:68, :245:54, :253:{75,82}
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_2_data_0 <= _sectored_entries_0_2_data_T;	// TLB.scala:123:24, :165:29
    if (~io_ptw_resp_valid | _GEN_37 | ~(_GEN_55 & _GEN_58)) begin	// TLB.scala:122:16, :123:15, :165:29, :220:20, :240:68, :245:54, :253:{75,82}
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_2_data_1 <= _sectored_entries_0_2_data_T;	// TLB.scala:123:24, :165:29
    if (~io_ptw_resp_valid | _GEN_37 | ~(_GEN_55 & _GEN_59)) begin	// TLB.scala:122:16, :123:15, :165:29, :220:20, :240:68, :245:54, :253:{75,82}
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_2_data_2 <= _sectored_entries_0_2_data_T;	// TLB.scala:123:24, :165:29
    if (~io_ptw_resp_valid | _GEN_37 | ~(_GEN_55 & (&(r_refill_tag[1:0])))) begin	// TLB.scala:122:16, :123:15, :165:29, :174:25, :220:20, :240:68, :245:54, :253:{75,82}, package.scala:154:13
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_2_data_3 <= _sectored_entries_0_2_data_T;	// TLB.scala:123:24, :165:29
    sectored_entries_0_2_valid_0 <=
      ~_GEN_170
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_134
                     ? ~(sectored_entries_0_2_data_0[0] | _GEN_130) & _GEN_60
                     : ~_GEN_130 & _GEN_60)
                : io_sfence_bits_rs2 & sectored_entries_0_2_data_0[13] & _GEN_60)
           : _GEN_60);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    sectored_entries_0_2_valid_1 <=
      ~_GEN_170
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_134
                     ? ~(sectored_entries_0_2_data_1[0] | _GEN_131) & _GEN_61
                     : ~_GEN_131 & _GEN_61)
                : io_sfence_bits_rs2 & sectored_entries_0_2_data_1[13] & _GEN_61)
           : _GEN_61);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    sectored_entries_0_2_valid_2 <=
      ~_GEN_170
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_134
                     ? ~(sectored_entries_0_2_data_2[0] | _GEN_132) & _GEN_62
                     : ~_GEN_132 & _GEN_62)
                : io_sfence_bits_rs2 & sectored_entries_0_2_data_2[13] & _GEN_62)
           : _GEN_62);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    sectored_entries_0_2_valid_3 <=
      ~_GEN_170
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_134
                     ? ~(sectored_entries_0_2_data_3[0] | _GEN_133) & _GEN_63
                     : ~_GEN_133 & _GEN_63)
                : io_sfence_bits_rs2 & sectored_entries_0_2_data_3[13] & _GEN_63)
           : _GEN_63);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    if (_GEN_65) begin	// TLB.scala:165:29, :220:20, :240:68
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_3_tag <= r_refill_tag;	// TLB.scala:165:29, :174:25
    if (~io_ptw_resp_valid | _GEN_37 | ~(_GEN_64 & _GEN_66)) begin	// TLB.scala:122:16, :123:15, :165:29, :220:20, :240:68, :245:54, :253:{75,82}
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_3_data_0 <= _sectored_entries_0_3_data_T;	// TLB.scala:123:24, :165:29
    if (~io_ptw_resp_valid | _GEN_37 | ~(_GEN_64 & _GEN_67)) begin	// TLB.scala:122:16, :123:15, :165:29, :220:20, :240:68, :245:54, :253:{75,82}
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_3_data_1 <= _sectored_entries_0_3_data_T;	// TLB.scala:123:24, :165:29
    if (~io_ptw_resp_valid | _GEN_37 | ~(_GEN_64 & _GEN_68)) begin	// TLB.scala:122:16, :123:15, :165:29, :220:20, :240:68, :245:54, :253:{75,82}
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_3_data_2 <= _sectored_entries_0_3_data_T;	// TLB.scala:123:24, :165:29
    if (~io_ptw_resp_valid | _GEN_37 | ~(_GEN_64 & (&(r_refill_tag[1:0])))) begin	// TLB.scala:122:16, :123:15, :165:29, :174:25, :220:20, :240:68, :245:54, :253:{75,82}, package.scala:154:13
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_3_data_3 <= _sectored_entries_0_3_data_T;	// TLB.scala:123:24, :165:29
    sectored_entries_0_3_valid_0 <=
      ~_GEN_170
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_141
                     ? ~(sectored_entries_0_3_data_0[0] | _GEN_137) & _GEN_69
                     : ~_GEN_137 & _GEN_69)
                : io_sfence_bits_rs2 & sectored_entries_0_3_data_0[13] & _GEN_69)
           : _GEN_69);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    sectored_entries_0_3_valid_1 <=
      ~_GEN_170
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_141
                     ? ~(sectored_entries_0_3_data_1[0] | _GEN_138) & _GEN_70
                     : ~_GEN_138 & _GEN_70)
                : io_sfence_bits_rs2 & sectored_entries_0_3_data_1[13] & _GEN_70)
           : _GEN_70);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    sectored_entries_0_3_valid_2 <=
      ~_GEN_170
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_141
                     ? ~(sectored_entries_0_3_data_2[0] | _GEN_139) & _GEN_71
                     : ~_GEN_139 & _GEN_71)
                : io_sfence_bits_rs2 & sectored_entries_0_3_data_2[13] & _GEN_71)
           : _GEN_71);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    sectored_entries_0_3_valid_3 <=
      ~_GEN_170
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_141
                     ? ~(sectored_entries_0_3_data_3[0] | _GEN_140) & _GEN_72
                     : ~_GEN_140 & _GEN_72)
                : io_sfence_bits_rs2 & sectored_entries_0_3_data_3[13] & _GEN_72)
           : _GEN_72);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    if (_GEN_74) begin	// TLB.scala:165:29, :220:20, :240:68
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_4_tag <= r_refill_tag;	// TLB.scala:165:29, :174:25
    if (~io_ptw_resp_valid | _GEN_37 | ~(_GEN_73 & _GEN_75)) begin	// TLB.scala:122:16, :123:15, :165:29, :220:20, :240:68, :245:54, :253:{75,82}
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_4_data_0 <= _sectored_entries_0_4_data_T;	// TLB.scala:123:24, :165:29
    if (~io_ptw_resp_valid | _GEN_37 | ~(_GEN_73 & _GEN_76)) begin	// TLB.scala:122:16, :123:15, :165:29, :220:20, :240:68, :245:54, :253:{75,82}
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_4_data_1 <= _sectored_entries_0_4_data_T;	// TLB.scala:123:24, :165:29
    if (~io_ptw_resp_valid | _GEN_37 | ~(_GEN_73 & _GEN_77)) begin	// TLB.scala:122:16, :123:15, :165:29, :220:20, :240:68, :245:54, :253:{75,82}
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_4_data_2 <= _sectored_entries_0_4_data_T;	// TLB.scala:123:24, :165:29
    if (~io_ptw_resp_valid | _GEN_37 | ~(_GEN_73 & (&(r_refill_tag[1:0])))) begin	// TLB.scala:122:16, :123:15, :165:29, :174:25, :220:20, :240:68, :245:54, :253:{75,82}, package.scala:154:13
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_4_data_3 <= _sectored_entries_0_4_data_T;	// TLB.scala:123:24, :165:29
    sectored_entries_0_4_valid_0 <=
      ~_GEN_170
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_148
                     ? ~(sectored_entries_0_4_data_0[0] | _GEN_144) & _GEN_78
                     : ~_GEN_144 & _GEN_78)
                : io_sfence_bits_rs2 & sectored_entries_0_4_data_0[13] & _GEN_78)
           : _GEN_78);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    sectored_entries_0_4_valid_1 <=
      ~_GEN_170
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_148
                     ? ~(sectored_entries_0_4_data_1[0] | _GEN_145) & _GEN_79
                     : ~_GEN_145 & _GEN_79)
                : io_sfence_bits_rs2 & sectored_entries_0_4_data_1[13] & _GEN_79)
           : _GEN_79);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    sectored_entries_0_4_valid_2 <=
      ~_GEN_170
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_148
                     ? ~(sectored_entries_0_4_data_2[0] | _GEN_146) & _GEN_80
                     : ~_GEN_146 & _GEN_80)
                : io_sfence_bits_rs2 & sectored_entries_0_4_data_2[13] & _GEN_80)
           : _GEN_80);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    sectored_entries_0_4_valid_3 <=
      ~_GEN_170
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_148
                     ? ~(sectored_entries_0_4_data_3[0] | _GEN_147) & _GEN_81
                     : ~_GEN_147 & _GEN_81)
                : io_sfence_bits_rs2 & sectored_entries_0_4_data_3[13] & _GEN_81)
           : _GEN_81);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    if (_GEN_83) begin	// TLB.scala:165:29, :220:20, :240:68
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_5_tag <= r_refill_tag;	// TLB.scala:165:29, :174:25
    if (~io_ptw_resp_valid | _GEN_37 | ~(_GEN_82 & _GEN_84)) begin	// TLB.scala:122:16, :123:15, :165:29, :220:20, :240:68, :245:54, :253:{75,82}
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_5_data_0 <= _sectored_entries_0_5_data_T;	// TLB.scala:123:24, :165:29
    if (~io_ptw_resp_valid | _GEN_37 | ~(_GEN_82 & _GEN_85)) begin	// TLB.scala:122:16, :123:15, :165:29, :220:20, :240:68, :245:54, :253:{75,82}
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_5_data_1 <= _sectored_entries_0_5_data_T;	// TLB.scala:123:24, :165:29
    if (~io_ptw_resp_valid | _GEN_37 | ~(_GEN_82 & _GEN_86)) begin	// TLB.scala:122:16, :123:15, :165:29, :220:20, :240:68, :245:54, :253:{75,82}
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_5_data_2 <= _sectored_entries_0_5_data_T;	// TLB.scala:123:24, :165:29
    if (~io_ptw_resp_valid | _GEN_37 | ~(_GEN_82 & (&(r_refill_tag[1:0])))) begin	// TLB.scala:122:16, :123:15, :165:29, :174:25, :220:20, :240:68, :245:54, :253:{75,82}, package.scala:154:13
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_5_data_3 <= _sectored_entries_0_5_data_T;	// TLB.scala:123:24, :165:29
    sectored_entries_0_5_valid_0 <=
      ~_GEN_170
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_155
                     ? ~(sectored_entries_0_5_data_0[0] | _GEN_151) & _GEN_87
                     : ~_GEN_151 & _GEN_87)
                : io_sfence_bits_rs2 & sectored_entries_0_5_data_0[13] & _GEN_87)
           : _GEN_87);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    sectored_entries_0_5_valid_1 <=
      ~_GEN_170
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_155
                     ? ~(sectored_entries_0_5_data_1[0] | _GEN_152) & _GEN_88
                     : ~_GEN_152 & _GEN_88)
                : io_sfence_bits_rs2 & sectored_entries_0_5_data_1[13] & _GEN_88)
           : _GEN_88);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    sectored_entries_0_5_valid_2 <=
      ~_GEN_170
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_155
                     ? ~(sectored_entries_0_5_data_2[0] | _GEN_153) & _GEN_89
                     : ~_GEN_153 & _GEN_89)
                : io_sfence_bits_rs2 & sectored_entries_0_5_data_2[13] & _GEN_89)
           : _GEN_89);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    sectored_entries_0_5_valid_3 <=
      ~_GEN_170
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_155
                     ? ~(sectored_entries_0_5_data_3[0] | _GEN_154) & _GEN_90
                     : ~_GEN_154 & _GEN_90)
                : io_sfence_bits_rs2 & sectored_entries_0_5_data_3[13] & _GEN_90)
           : _GEN_90);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    if (_GEN_92) begin	// TLB.scala:165:29, :220:20, :240:68
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_6_tag <= r_refill_tag;	// TLB.scala:165:29, :174:25
    if (~io_ptw_resp_valid | _GEN_37 | ~(_GEN_91 & _GEN_93)) begin	// TLB.scala:122:16, :123:15, :165:29, :220:20, :240:68, :245:54, :253:{75,82}
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_6_data_0 <= _sectored_entries_0_6_data_T;	// TLB.scala:123:24, :165:29
    if (~io_ptw_resp_valid | _GEN_37 | ~(_GEN_91 & _GEN_94)) begin	// TLB.scala:122:16, :123:15, :165:29, :220:20, :240:68, :245:54, :253:{75,82}
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_6_data_1 <= _sectored_entries_0_6_data_T;	// TLB.scala:123:24, :165:29
    if (~io_ptw_resp_valid | _GEN_37 | ~(_GEN_91 & _GEN_95)) begin	// TLB.scala:122:16, :123:15, :165:29, :220:20, :240:68, :245:54, :253:{75,82}
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_6_data_2 <= _sectored_entries_0_6_data_T;	// TLB.scala:123:24, :165:29
    if (~io_ptw_resp_valid | _GEN_37 | ~(_GEN_91 & (&(r_refill_tag[1:0])))) begin	// TLB.scala:122:16, :123:15, :165:29, :174:25, :220:20, :240:68, :245:54, :253:{75,82}, package.scala:154:13
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_6_data_3 <= _sectored_entries_0_6_data_T;	// TLB.scala:123:24, :165:29
    sectored_entries_0_6_valid_0 <=
      ~_GEN_170
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_162
                     ? ~(sectored_entries_0_6_data_0[0] | _GEN_158) & _GEN_96
                     : ~_GEN_158 & _GEN_96)
                : io_sfence_bits_rs2 & sectored_entries_0_6_data_0[13] & _GEN_96)
           : _GEN_96);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    sectored_entries_0_6_valid_1 <=
      ~_GEN_170
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_162
                     ? ~(sectored_entries_0_6_data_1[0] | _GEN_159) & _GEN_97
                     : ~_GEN_159 & _GEN_97)
                : io_sfence_bits_rs2 & sectored_entries_0_6_data_1[13] & _GEN_97)
           : _GEN_97);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    sectored_entries_0_6_valid_2 <=
      ~_GEN_170
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_162
                     ? ~(sectored_entries_0_6_data_2[0] | _GEN_160) & _GEN_98
                     : ~_GEN_160 & _GEN_98)
                : io_sfence_bits_rs2 & sectored_entries_0_6_data_2[13] & _GEN_98)
           : _GEN_98);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    sectored_entries_0_6_valid_3 <=
      ~_GEN_170
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_162
                     ? ~(sectored_entries_0_6_data_3[0] | _GEN_161) & _GEN_99
                     : ~_GEN_161 & _GEN_99)
                : io_sfence_bits_rs2 & sectored_entries_0_6_data_3[13] & _GEN_99)
           : _GEN_99);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    if (_GEN_100) begin	// TLB.scala:165:29, :220:20, :240:68
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_7_tag <= r_refill_tag;	// TLB.scala:165:29, :174:25
    if (~io_ptw_resp_valid | _GEN_37 | ~((&waddr) & _GEN_101)) begin	// TLB.scala:122:16, :123:15, :165:29, :220:20, :240:68, :245:54, :252:22, :253:{75,82}
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_7_data_0 <= _sectored_entries_0_7_data_T;	// TLB.scala:123:24, :165:29
    if (~io_ptw_resp_valid | _GEN_37 | ~((&waddr) & _GEN_102)) begin	// TLB.scala:122:16, :123:15, :165:29, :220:20, :240:68, :245:54, :252:22, :253:{75,82}
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_7_data_1 <= _sectored_entries_0_7_data_T;	// TLB.scala:123:24, :165:29
    if (~io_ptw_resp_valid | _GEN_37 | ~((&waddr) & _GEN_103)) begin	// TLB.scala:122:16, :123:15, :165:29, :220:20, :240:68, :245:54, :252:22, :253:{75,82}
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_7_data_2 <= _sectored_entries_0_7_data_T;	// TLB.scala:123:24, :165:29
    if (~io_ptw_resp_valid | _GEN_37 | ~((&waddr) & (&(r_refill_tag[1:0])))) begin	// TLB.scala:122:16, :123:15, :165:29, :174:25, :220:20, :240:68, :245:54, :252:22, :253:{75,82}, package.scala:154:13
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_7_data_3 <= _sectored_entries_0_7_data_T;	// TLB.scala:123:24, :165:29
    sectored_entries_0_7_valid_0 <=
      ~_GEN_170
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_169
                     ? ~(sectored_entries_0_7_data_0[0] | _GEN_165) & _GEN_104
                     : ~_GEN_165 & _GEN_104)
                : io_sfence_bits_rs2 & sectored_entries_0_7_data_0[13] & _GEN_104)
           : _GEN_104);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    sectored_entries_0_7_valid_1 <=
      ~_GEN_170
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_169
                     ? ~(sectored_entries_0_7_data_1[0] | _GEN_166) & _GEN_105
                     : ~_GEN_166 & _GEN_105)
                : io_sfence_bits_rs2 & sectored_entries_0_7_data_1[13] & _GEN_105)
           : _GEN_105);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    sectored_entries_0_7_valid_2 <=
      ~_GEN_170
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_169
                     ? ~(sectored_entries_0_7_data_2[0] | _GEN_167) & _GEN_106
                     : ~_GEN_167 & _GEN_106)
                : io_sfence_bits_rs2 & sectored_entries_0_7_data_2[13] & _GEN_106)
           : _GEN_106);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    sectored_entries_0_7_valid_3 <=
      ~_GEN_170
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_169
                     ? ~(sectored_entries_0_7_data_3[0] | _GEN_168) & _GEN_107
                     : ~_GEN_168 & _GEN_107)
                : io_sfence_bits_rs2 & sectored_entries_0_7_data_3[13] & _GEN_107)
           : _GEN_107);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    if (_GEN_28) begin	// TLB.scala:166:30, :220:20, :240:68
      superpage_entries_0_level <= {1'h0, io_ptw_resp_bits_level[0]};	// TLB.scala:119:16, :166:30, :343:48, :346:41, :349:41, :352:51, package.scala:154:13
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
         1'h0};	// PTW.scala:77:35, :78:40, :79:35, TLB.scala:123:24, :166:30, :200:19, :204:66, :205:70, :209:65, :223:18, :226:25, :343:48, :346:41, :349:41, :352:51
    end
    superpage_entries_0_valid_0 <=
      ~_GEN_170
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? ~(superpage_entries_0_valid_0
                    & superpage_entries_0_tag[26:18] == io_req_bits_vaddr[38:30]
                    & (ignore_1
                       | superpage_entries_0_tag[17:9] == io_req_bits_vaddr[29:21]))
                  & _GEN_29
                : io_sfence_bits_rs2 & superpage_entries_0_data_0[13] & _GEN_29)
           : _GEN_29);	// TLB.scala:83:39, :94:28, :95:{29,40,46,77,84}, :126:46, :129:23, :143:19, :163:30, :166:30, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    if (_GEN_30) begin	// TLB.scala:166:30, :220:20, :240:68
      superpage_entries_1_level <= {1'h0, io_ptw_resp_bits_level[0]};	// TLB.scala:119:16, :166:30, :343:48, :346:41, :349:41, :352:51, package.scala:154:13
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
         1'h0};	// PTW.scala:77:35, :78:40, :79:35, TLB.scala:123:24, :166:30, :200:19, :204:66, :205:70, :209:65, :223:18, :226:25, :343:48, :346:41, :349:41, :352:51
    end
    superpage_entries_1_valid_0 <=
      ~_GEN_170
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? ~(superpage_entries_1_valid_0
                    & superpage_entries_1_tag[26:18] == io_req_bits_vaddr[38:30]
                    & (ignore_4
                       | superpage_entries_1_tag[17:9] == io_req_bits_vaddr[29:21]))
                  & _GEN_31
                : io_sfence_bits_rs2 & superpage_entries_1_data_0[13] & _GEN_31)
           : _GEN_31);	// TLB.scala:83:39, :94:28, :95:{29,40,46,77,84}, :126:46, :129:23, :143:19, :163:30, :166:30, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    if (_GEN_32) begin	// TLB.scala:166:30, :220:20, :240:68
      superpage_entries_2_level <= {1'h0, io_ptw_resp_bits_level[0]};	// TLB.scala:119:16, :166:30, :343:48, :346:41, :349:41, :352:51, package.scala:154:13
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
         1'h0};	// PTW.scala:77:35, :78:40, :79:35, TLB.scala:123:24, :166:30, :200:19, :204:66, :205:70, :209:65, :223:18, :226:25, :343:48, :346:41, :349:41, :352:51
    end
    superpage_entries_2_valid_0 <=
      ~_GEN_170
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? ~(superpage_entries_2_valid_0
                    & superpage_entries_2_tag[26:18] == io_req_bits_vaddr[38:30]
                    & (ignore_7
                       | superpage_entries_2_tag[17:9] == io_req_bits_vaddr[29:21]))
                  & _GEN_33
                : io_sfence_bits_rs2 & superpage_entries_2_data_0[13] & _GEN_33)
           : _GEN_33);	// TLB.scala:83:39, :94:28, :95:{29,40,46,77,84}, :126:46, :129:23, :143:19, :163:30, :166:30, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    if (_GEN_34) begin	// TLB.scala:166:30, :220:20, :240:68
      superpage_entries_3_level <= {1'h0, io_ptw_resp_bits_level[0]};	// TLB.scala:119:16, :166:30, :343:48, :346:41, :349:41, :352:51, package.scala:154:13
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
         1'h0};	// PTW.scala:77:35, :78:40, :79:35, TLB.scala:123:24, :166:30, :200:19, :204:66, :205:70, :209:65, :223:18, :226:25, :343:48, :346:41, :349:41, :352:51
    end
    superpage_entries_3_valid_0 <=
      ~_GEN_170
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? ~(superpage_entries_3_valid_0
                    & superpage_entries_3_tag[26:18] == io_req_bits_vaddr[38:30]
                    & (ignore_10
                       | superpage_entries_3_tag[17:9] == io_req_bits_vaddr[29:21]))
                  & _GEN_35
                : io_sfence_bits_rs2 & superpage_entries_3_data_0[13] & _GEN_35)
           : _GEN_35);	// TLB.scala:83:39, :94:28, :95:{29,40,46,77,84}, :126:46, :129:23, :143:19, :163:30, :166:30, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    if (_GEN_26) begin	// TLB.scala:118:14, :167:56, :220:20, :240:68
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
         1'h0};	// PTW.scala:77:35, :78:40, :79:35, TLB.scala:123:24, :167:56, :200:19, :204:66, :205:70, :209:65, :223:18, :226:25, :343:48, :346:41, :349:41, :352:51
    end
    special_entry_valid_0 <=
      ~_GEN_170
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? ~(special_entry_valid_0
                    & special_entry_tag[26:18] == io_req_bits_vaddr[38:30]
                    & (ignore_13 | special_entry_tag[17:9] == io_req_bits_vaddr[29:21])
                    & (~(special_entry_level[1])
                       | special_entry_tag[8:0] == io_req_bits_vaddr[20:12])) & _GEN_27
                : io_sfence_bits_rs2 & special_entry_data_0[13] & _GEN_27)
           : _GEN_27);	// TLB.scala:83:39, :95:{29,40,46,77,84}, :108:28, :126:46, :129:23, :143:19, :163:30, :167:56, :220:20, :240:68, :243:34, :384:19, :387:35, :388:40, :392:{24,34}
    if (_GEN_110) begin	// TLB.scala:363:25
      automatic logic       r_sectored_repl_addr_valids_lo_lo_lo;	// package.scala:72:59
      automatic logic       r_sectored_repl_addr_valids_lo_lo_hi;	// package.scala:72:59
      automatic logic       r_sectored_repl_addr_valids_lo_hi_lo;	// package.scala:72:59
      automatic logic       r_sectored_repl_addr_valids_lo_hi_hi;	// package.scala:72:59
      automatic logic       r_sectored_repl_addr_valids_hi_lo_lo;	// package.scala:72:59
      automatic logic       r_sectored_repl_addr_valids_hi_lo_hi;	// package.scala:72:59
      automatic logic       r_sectored_repl_addr_valids_hi_hi_lo;	// package.scala:72:59
      automatic logic [2:0] _r_sectored_hit_addr_T_1;	// OneHot.scala:32:28
      r_sectored_repl_addr_valids_lo_lo_lo =
        _r_sectored_repl_addr_valids_T | sectored_entries_0_0_valid_2
        | sectored_entries_0_0_valid_3;	// TLB.scala:165:29, package.scala:72:59
      r_sectored_repl_addr_valids_lo_lo_hi =
        _r_sectored_repl_addr_valids_T_2 | sectored_entries_0_1_valid_2
        | sectored_entries_0_1_valid_3;	// TLB.scala:165:29, package.scala:72:59
      r_sectored_repl_addr_valids_lo_hi_lo =
        _r_sectored_repl_addr_valids_T_4 | sectored_entries_0_2_valid_2
        | sectored_entries_0_2_valid_3;	// TLB.scala:165:29, package.scala:72:59
      r_sectored_repl_addr_valids_lo_hi_hi =
        _r_sectored_repl_addr_valids_T_6 | sectored_entries_0_3_valid_2
        | sectored_entries_0_3_valid_3;	// TLB.scala:165:29, package.scala:72:59
      r_sectored_repl_addr_valids_hi_lo_lo =
        _r_sectored_repl_addr_valids_T_8 | sectored_entries_0_4_valid_2
        | sectored_entries_0_4_valid_3;	// TLB.scala:165:29, package.scala:72:59
      r_sectored_repl_addr_valids_hi_lo_hi =
        _r_sectored_repl_addr_valids_T_10 | sectored_entries_0_5_valid_2
        | sectored_entries_0_5_valid_3;	// TLB.scala:165:29, package.scala:72:59
      r_sectored_repl_addr_valids_hi_hi_lo =
        _r_sectored_repl_addr_valids_T_12 | sectored_entries_0_6_valid_2
        | sectored_entries_0_6_valid_3;	// TLB.scala:165:29, package.scala:72:59
      _r_sectored_hit_addr_T_1 = _GEN_108 | _GEN_109;	// OneHot.scala:30:18, :31:18, :32:28
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
          r_superpage_repl_addr <= {1'h1, ~(_r_superpage_repl_addr_T_4[2])};	// Consts.scala:81:75, Mux.scala:47:69, OneHot.scala:47:40, TLB.scala:175:34, :183:102, :358:28, :411:43
      end
      if (&{_r_sectored_repl_addr_valids_T_14 | sectored_entries_0_7_valid_2
              | sectored_entries_0_7_valid_3,
            r_sectored_repl_addr_valids_hi_hi_lo,
            r_sectored_repl_addr_valids_hi_lo_hi,
            r_sectored_repl_addr_valids_hi_lo_lo,
            r_sectored_repl_addr_valids_lo_hi_hi,
            r_sectored_repl_addr_valids_lo_hi_lo,
            r_sectored_repl_addr_valids_lo_lo_hi,
            r_sectored_repl_addr_valids_lo_lo_lo})	// Cat.scala:30:58, TLB.scala:165:29, :411:16, package.scala:72:59
        r_sectored_repl_addr <=
          {state_vec_0[6],
           state_vec_0[6]
             ? {state_vec_0[5], state_vec_0[5] ? state_vec_0[4] : state_vec_0[3]}
             : {state_vec_0[2], state_vec_0[2] ? state_vec_0[1] : state_vec_0[0]}};	// Cat.scala:30:58, Replacement.scala:243:38, :245:38, :250:16, :305:17, TLB.scala:176:33, package.scala:154:13
      else begin	// TLB.scala:411:16
        automatic logic [6:0] _r_sectored_repl_addr_T_8;	// TLB.scala:411:43
        _r_sectored_repl_addr_T_8 =
          ~{r_sectored_repl_addr_valids_hi_hi_lo,
            r_sectored_repl_addr_valids_hi_lo_hi,
            r_sectored_repl_addr_valids_hi_lo_lo,
            r_sectored_repl_addr_valids_lo_hi_hi,
            r_sectored_repl_addr_valids_lo_hi_lo,
            r_sectored_repl_addr_valids_lo_lo_hi,
            r_sectored_repl_addr_valids_lo_lo_lo};	// Cat.scala:30:58, TLB.scala:411:43, package.scala:72:59
        if (_r_sectored_repl_addr_T_8[0])	// OneHot.scala:47:40, TLB.scala:411:43
          r_sectored_repl_addr <= 3'h0;	// Replacement.scala:168:70, TLB.scala:176:33
        else if (_r_sectored_repl_addr_T_8[1])	// OneHot.scala:47:40, TLB.scala:411:43
          r_sectored_repl_addr <= 3'h1;	// TLB.scala:176:33, :192:27
        else if (_r_sectored_repl_addr_T_8[2])	// OneHot.scala:47:40, TLB.scala:411:43
          r_sectored_repl_addr <= 3'h2;	// Mux.scala:47:69, TLB.scala:176:33
        else if (_r_sectored_repl_addr_T_8[3])	// OneHot.scala:47:40, TLB.scala:411:43
          r_sectored_repl_addr <= 3'h3;	// Mux.scala:47:69, TLB.scala:176:33
        else if (_r_sectored_repl_addr_T_8[4])	// OneHot.scala:47:40, TLB.scala:411:43
          r_sectored_repl_addr <= 3'h4;	// TLB.scala:176:33, :253:75
        else if (_r_sectored_repl_addr_T_8[5])	// OneHot.scala:47:40, TLB.scala:411:43
          r_sectored_repl_addr <= 3'h5;	// TLB.scala:176:33, :253:75
        else	// OneHot.scala:47:40
          r_sectored_repl_addr <= {2'h3, ~(_r_sectored_repl_addr_T_8[6])};	// Mux.scala:47:69, OneHot.scala:47:40, TLB.scala:176:33, :193:19, :411:43
      end
      r_sectored_hit_addr <=
        {|{sector_hits_7, sector_hits_6, sector_hits_5, sector_hits_4},
         |(_r_sectored_hit_addr_T_1[2:1]),
         _r_sectored_hit_addr_T_1[2] | _r_sectored_hit_addr_T_1[0]};	// Cat.scala:30:58, OneHot.scala:30:18, :31:18, :32:{14,28}, TLB.scala:87:40, :177:32
      r_sectored_hit <=
        sector_hits_0 | sector_hits_1 | sector_hits_2 | sector_hits_3 | sector_hits_4
        | sector_hits_5 | sector_hits_6 | sector_hits_7;	// TLB.scala:87:40, :178:27, package.scala:72:59
    end
    if (reset) begin
      state <= 2'h0;	// TLB.scala:173:18
      state_vec_0 <= 7'h0;	// Replacement.scala:168:70, :305:17
      state_reg_1 <= 3'h0;	// Replacement.scala:168:70
    end
    else begin
      automatic logic superpage_hits_1;	// TLB.scala:95:29
      automatic logic superpage_hits_2;	// TLB.scala:95:29
      automatic logic superpage_hits_3;	// TLB.scala:95:29
      automatic logic _GEN_171 = io_req_valid & _vm_enabled_T_2;	// TLB.scala:183:83, :329:22
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
        state <= 2'h3;	// TLB.scala:173:18, :193:19
      else if (_io_ptw_req_valid_T) begin	// package.scala:15:47
        if (io_ptw_req_ready)
          state <= {1'h1, io_sfence_valid};	// Consts.scala:81:75, TLB.scala:173:18, :183:102, :358:28, :374:45
        else if (io_sfence_valid)
          state <= 2'h0;	// TLB.scala:173:18
        else if (_GEN_110)	// TLB.scala:363:25
          state <= 2'h1;	// TLB.scala:173:18, package.scala:15:47
      end
      else if (_GEN_110)	// TLB.scala:363:25
        state <= 2'h1;	// TLB.scala:173:18, package.scala:15:47
      if (_GEN_171
          & (sector_hits_0 | sector_hits_1 | sector_hits_2 | sector_hits_3 | sector_hits_4
             | sector_hits_5 | sector_hits_6 | sector_hits_7)) begin	// Replacement.scala:305:17, :308:20, TLB.scala:87:40, :329:{22,37}, :330:28, package.scala:72:59
        automatic logic [3:0] hi_1;	// OneHot.scala:30:18
        automatic logic [2:0] _GEN_172;	// OneHot.scala:32:28
        automatic logic       lo_3;	// OneHot.scala:32:28
        hi_1 = {sector_hits_7, sector_hits_6, sector_hits_5, sector_hits_4};	// OneHot.scala:30:18, TLB.scala:87:40
        _GEN_172 = _GEN_108 | _GEN_109;	// OneHot.scala:30:18, :31:18, :32:28
        lo_3 = _GEN_172[2] | _GEN_172[0];	// OneHot.scala:30:18, :31:18, :32:28
        state_vec_0 <=
          {~(|hi_1),
           (|hi_1)
             ? {~(|(_GEN_172[2:1])),
                (|(_GEN_172[2:1])) ? ~lo_3 : state_vec_0[4],
                (|(_GEN_172[2:1])) ? state_vec_0[3] : ~lo_3}
             : state_vec_0[5:3],
           (|hi_1)
             ? state_vec_0[2:0]
             : {~(|(_GEN_172[2:1])),
                (|(_GEN_172[2:1])) ? ~lo_3 : state_vec_0[1],
                (|(_GEN_172[2:1])) ? state_vec_0[0] : ~lo_3}};	// Cat.scala:30:58, OneHot.scala:30:18, :32:{14,28}, Replacement.scala:196:33, :198:38, :203:16, :206:16, :218:7, :305:17, package.scala:154:13
      end
      if (_GEN_171
          & (superpage_entries_0_valid_0
             & superpage_entries_0_tag[26:18] == io_req_bits_vaddr[38:30]
             & (ignore_1 | superpage_entries_0_tag[17:9] == io_req_bits_vaddr[29:21])
             | superpage_hits_1 | superpage_hits_2 | superpage_hits_3)) begin	// Replacement.scala:168:70, :172:15, TLB.scala:94:28, :95:{29,40,46,77,84}, :163:30, :166:30, :329:{22,37}, :331:31, package.scala:72:59
        automatic logic [1:0] hi_6;	// OneHot.scala:30:18
        automatic logic       lo_7;	// OneHot.scala:32:28
        hi_6 = {superpage_hits_3, superpage_hits_2};	// OneHot.scala:30:18, TLB.scala:95:29
        lo_7 = superpage_hits_3 | superpage_hits_1;	// OneHot.scala:32:28, TLB.scala:95:29
        state_reg_1 <=
          {~(|hi_6), (|hi_6) ? ~lo_7 : state_reg_1[1], (|hi_6) ? state_reg_1[0] : ~lo_7};	// Cat.scala:30:58, OneHot.scala:30:18, :32:{14,28}, Replacement.scala:168:70, :196:33, :198:38, :203:16, :206:16, :218:7, package.scala:154:13
      end
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:55];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [5:0] i = 6'h0; i < 6'h38; i += 6'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        sectored_entries_0_0_tag = _RANDOM[6'h0][28:2];	// TLB.scala:165:29
        sectored_entries_0_0_data_0 = {_RANDOM[6'h0][31:29], _RANDOM[6'h1]};	// TLB.scala:165:29
        sectored_entries_0_0_data_1 = {_RANDOM[6'h2], _RANDOM[6'h3][2:0]};	// TLB.scala:165:29
        sectored_entries_0_0_data_2 = {_RANDOM[6'h3][31:3], _RANDOM[6'h4][5:0]};	// TLB.scala:165:29
        sectored_entries_0_0_data_3 = {_RANDOM[6'h4][31:6], _RANDOM[6'h5][8:0]};	// TLB.scala:165:29
        sectored_entries_0_0_valid_0 = _RANDOM[6'h5][9];	// TLB.scala:165:29
        sectored_entries_0_0_valid_1 = _RANDOM[6'h5][10];	// TLB.scala:165:29
        sectored_entries_0_0_valid_2 = _RANDOM[6'h5][11];	// TLB.scala:165:29
        sectored_entries_0_0_valid_3 = _RANDOM[6'h5][12];	// TLB.scala:165:29
        sectored_entries_0_1_tag = {_RANDOM[6'h5][31:15], _RANDOM[6'h6][9:0]};	// TLB.scala:165:29
        sectored_entries_0_1_data_0 = {_RANDOM[6'h6][31:10], _RANDOM[6'h7][12:0]};	// TLB.scala:165:29
        sectored_entries_0_1_data_1 = {_RANDOM[6'h7][31:13], _RANDOM[6'h8][15:0]};	// TLB.scala:165:29
        sectored_entries_0_1_data_2 = {_RANDOM[6'h8][31:16], _RANDOM[6'h9][18:0]};	// TLB.scala:165:29
        sectored_entries_0_1_data_3 = {_RANDOM[6'h9][31:19], _RANDOM[6'hA][21:0]};	// TLB.scala:165:29
        sectored_entries_0_1_valid_0 = _RANDOM[6'hA][22];	// TLB.scala:165:29
        sectored_entries_0_1_valid_1 = _RANDOM[6'hA][23];	// TLB.scala:165:29
        sectored_entries_0_1_valid_2 = _RANDOM[6'hA][24];	// TLB.scala:165:29
        sectored_entries_0_1_valid_3 = _RANDOM[6'hA][25];	// TLB.scala:165:29
        sectored_entries_0_2_tag = {_RANDOM[6'hA][31:28], _RANDOM[6'hB][22:0]};	// TLB.scala:165:29
        sectored_entries_0_2_data_0 = {_RANDOM[6'hB][31:23], _RANDOM[6'hC][25:0]};	// TLB.scala:165:29
        sectored_entries_0_2_data_1 = {_RANDOM[6'hC][31:26], _RANDOM[6'hD][28:0]};	// TLB.scala:165:29
        sectored_entries_0_2_data_2 = {_RANDOM[6'hD][31:29], _RANDOM[6'hE]};	// TLB.scala:165:29
        sectored_entries_0_2_data_3 = {_RANDOM[6'hF], _RANDOM[6'h10][2:0]};	// TLB.scala:165:29
        sectored_entries_0_2_valid_0 = _RANDOM[6'h10][3];	// TLB.scala:165:29
        sectored_entries_0_2_valid_1 = _RANDOM[6'h10][4];	// TLB.scala:165:29
        sectored_entries_0_2_valid_2 = _RANDOM[6'h10][5];	// TLB.scala:165:29
        sectored_entries_0_2_valid_3 = _RANDOM[6'h10][6];	// TLB.scala:165:29
        sectored_entries_0_3_tag = {_RANDOM[6'h10][31:9], _RANDOM[6'h11][3:0]};	// TLB.scala:165:29
        sectored_entries_0_3_data_0 = {_RANDOM[6'h11][31:4], _RANDOM[6'h12][6:0]};	// TLB.scala:165:29
        sectored_entries_0_3_data_1 = {_RANDOM[6'h12][31:7], _RANDOM[6'h13][9:0]};	// TLB.scala:165:29
        sectored_entries_0_3_data_2 = {_RANDOM[6'h13][31:10], _RANDOM[6'h14][12:0]};	// TLB.scala:165:29
        sectored_entries_0_3_data_3 = {_RANDOM[6'h14][31:13], _RANDOM[6'h15][15:0]};	// TLB.scala:165:29
        sectored_entries_0_3_valid_0 = _RANDOM[6'h15][16];	// TLB.scala:165:29
        sectored_entries_0_3_valid_1 = _RANDOM[6'h15][17];	// TLB.scala:165:29
        sectored_entries_0_3_valid_2 = _RANDOM[6'h15][18];	// TLB.scala:165:29
        sectored_entries_0_3_valid_3 = _RANDOM[6'h15][19];	// TLB.scala:165:29
        sectored_entries_0_4_tag = {_RANDOM[6'h15][31:22], _RANDOM[6'h16][16:0]};	// TLB.scala:165:29
        sectored_entries_0_4_data_0 = {_RANDOM[6'h16][31:17], _RANDOM[6'h17][19:0]};	// TLB.scala:165:29
        sectored_entries_0_4_data_1 = {_RANDOM[6'h17][31:20], _RANDOM[6'h18][22:0]};	// TLB.scala:165:29
        sectored_entries_0_4_data_2 = {_RANDOM[6'h18][31:23], _RANDOM[6'h19][25:0]};	// TLB.scala:165:29
        sectored_entries_0_4_data_3 = {_RANDOM[6'h19][31:26], _RANDOM[6'h1A][28:0]};	// TLB.scala:165:29
        sectored_entries_0_4_valid_0 = _RANDOM[6'h1A][29];	// TLB.scala:165:29
        sectored_entries_0_4_valid_1 = _RANDOM[6'h1A][30];	// TLB.scala:165:29
        sectored_entries_0_4_valid_2 = _RANDOM[6'h1A][31];	// TLB.scala:165:29
        sectored_entries_0_4_valid_3 = _RANDOM[6'h1B][0];	// TLB.scala:165:29
        sectored_entries_0_5_tag = _RANDOM[6'h1B][29:3];	// TLB.scala:165:29
        sectored_entries_0_5_data_0 =
          {_RANDOM[6'h1B][31:30], _RANDOM[6'h1C], _RANDOM[6'h1D][0]};	// TLB.scala:165:29
        sectored_entries_0_5_data_1 = {_RANDOM[6'h1D][31:1], _RANDOM[6'h1E][3:0]};	// TLB.scala:165:29
        sectored_entries_0_5_data_2 = {_RANDOM[6'h1E][31:4], _RANDOM[6'h1F][6:0]};	// TLB.scala:165:29
        sectored_entries_0_5_data_3 = {_RANDOM[6'h1F][31:7], _RANDOM[6'h20][9:0]};	// TLB.scala:165:29
        sectored_entries_0_5_valid_0 = _RANDOM[6'h20][10];	// TLB.scala:165:29
        sectored_entries_0_5_valid_1 = _RANDOM[6'h20][11];	// TLB.scala:165:29
        sectored_entries_0_5_valid_2 = _RANDOM[6'h20][12];	// TLB.scala:165:29
        sectored_entries_0_5_valid_3 = _RANDOM[6'h20][13];	// TLB.scala:165:29
        sectored_entries_0_6_tag = {_RANDOM[6'h20][31:16], _RANDOM[6'h21][10:0]};	// TLB.scala:165:29
        sectored_entries_0_6_data_0 = {_RANDOM[6'h21][31:11], _RANDOM[6'h22][13:0]};	// TLB.scala:165:29
        sectored_entries_0_6_data_1 = {_RANDOM[6'h22][31:14], _RANDOM[6'h23][16:0]};	// TLB.scala:165:29
        sectored_entries_0_6_data_2 = {_RANDOM[6'h23][31:17], _RANDOM[6'h24][19:0]};	// TLB.scala:165:29
        sectored_entries_0_6_data_3 = {_RANDOM[6'h24][31:20], _RANDOM[6'h25][22:0]};	// TLB.scala:165:29
        sectored_entries_0_6_valid_0 = _RANDOM[6'h25][23];	// TLB.scala:165:29
        sectored_entries_0_6_valid_1 = _RANDOM[6'h25][24];	// TLB.scala:165:29
        sectored_entries_0_6_valid_2 = _RANDOM[6'h25][25];	// TLB.scala:165:29
        sectored_entries_0_6_valid_3 = _RANDOM[6'h25][26];	// TLB.scala:165:29
        sectored_entries_0_7_tag = {_RANDOM[6'h25][31:29], _RANDOM[6'h26][23:0]};	// TLB.scala:165:29
        sectored_entries_0_7_data_0 = {_RANDOM[6'h26][31:24], _RANDOM[6'h27][26:0]};	// TLB.scala:165:29
        sectored_entries_0_7_data_1 = {_RANDOM[6'h27][31:27], _RANDOM[6'h28][29:0]};	// TLB.scala:165:29
        sectored_entries_0_7_data_2 =
          {_RANDOM[6'h28][31:30], _RANDOM[6'h29], _RANDOM[6'h2A][0]};	// TLB.scala:165:29
        sectored_entries_0_7_data_3 = {_RANDOM[6'h2A][31:1], _RANDOM[6'h2B][3:0]};	// TLB.scala:165:29
        sectored_entries_0_7_valid_0 = _RANDOM[6'h2B][4];	// TLB.scala:165:29
        sectored_entries_0_7_valid_1 = _RANDOM[6'h2B][5];	// TLB.scala:165:29
        sectored_entries_0_7_valid_2 = _RANDOM[6'h2B][6];	// TLB.scala:165:29
        sectored_entries_0_7_valid_3 = _RANDOM[6'h2B][7];	// TLB.scala:165:29
        superpage_entries_0_level = _RANDOM[6'h2B][9:8];	// TLB.scala:165:29, :166:30
        superpage_entries_0_tag = {_RANDOM[6'h2B][31:10], _RANDOM[6'h2C][4:0]};	// TLB.scala:165:29, :166:30
        superpage_entries_0_data_0 = {_RANDOM[6'h2C][31:5], _RANDOM[6'h2D][7:0]};	// TLB.scala:166:30
        superpage_entries_0_valid_0 = _RANDOM[6'h2D][8];	// TLB.scala:166:30
        superpage_entries_1_level = _RANDOM[6'h2D][10:9];	// TLB.scala:166:30
        superpage_entries_1_tag = {_RANDOM[6'h2D][31:11], _RANDOM[6'h2E][5:0]};	// TLB.scala:166:30
        superpage_entries_1_data_0 = {_RANDOM[6'h2E][31:6], _RANDOM[6'h2F][8:0]};	// TLB.scala:166:30
        superpage_entries_1_valid_0 = _RANDOM[6'h2F][9];	// TLB.scala:166:30
        superpage_entries_2_level = _RANDOM[6'h2F][11:10];	// TLB.scala:166:30
        superpage_entries_2_tag = {_RANDOM[6'h2F][31:12], _RANDOM[6'h30][6:0]};	// TLB.scala:166:30
        superpage_entries_2_data_0 = {_RANDOM[6'h30][31:7], _RANDOM[6'h31][9:0]};	// TLB.scala:166:30
        superpage_entries_2_valid_0 = _RANDOM[6'h31][10];	// TLB.scala:166:30
        superpage_entries_3_level = _RANDOM[6'h31][12:11];	// TLB.scala:166:30
        superpage_entries_3_tag = {_RANDOM[6'h31][31:13], _RANDOM[6'h32][7:0]};	// TLB.scala:166:30
        superpage_entries_3_data_0 = {_RANDOM[6'h32][31:8], _RANDOM[6'h33][10:0]};	// TLB.scala:166:30
        superpage_entries_3_valid_0 = _RANDOM[6'h33][11];	// TLB.scala:166:30
        special_entry_level = _RANDOM[6'h33][13:12];	// TLB.scala:166:30, :167:56
        special_entry_tag = {_RANDOM[6'h33][31:14], _RANDOM[6'h34][8:0]};	// TLB.scala:166:30, :167:56
        special_entry_data_0 = {_RANDOM[6'h34][31:9], _RANDOM[6'h35][11:0]};	// TLB.scala:167:56
        special_entry_valid_0 = _RANDOM[6'h35][12];	// TLB.scala:167:56
        state = _RANDOM[6'h35][14:13];	// TLB.scala:167:56, :173:18
        r_refill_tag = {_RANDOM[6'h35][31:15], _RANDOM[6'h36][9:0]};	// TLB.scala:167:56, :174:25
        r_superpage_repl_addr = _RANDOM[6'h36][11:10];	// TLB.scala:174:25, :175:34
        r_sectored_repl_addr = _RANDOM[6'h36][14:12];	// TLB.scala:174:25, :176:33
        r_sectored_hit_addr = _RANDOM[6'h36][17:15];	// TLB.scala:174:25, :177:32
        r_sectored_hit = _RANDOM[6'h36][18];	// TLB.scala:174:25, :178:27
        state_vec_0 = {_RANDOM[6'h36][31:26], _RANDOM[6'h37][0]};	// Replacement.scala:305:17, TLB.scala:174:25
        state_reg_1 = _RANDOM[6'h37][3:1];	// Replacement.scala:168:70, :305:17
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
    .io_size        (2'h3),	// TLB.scala:193:19
    .io_r           (_pmp_io_r),
    .io_w           (_pmp_io_w),
    .io_x           (_pmp_io_x)
  );
  assign io_resp_miss = io_ptw_resp_valid | tlb_miss | multipleHits;	// Misc.scala:182:49, TLB.scala:325:40, :354:41
  assign io_resp_paddr =
    {(hitsVec_0 ? _normal_entries_WIRE_1[34:15] : 20'h0)
       | (hitsVec_1 ? _normal_entries_WIRE_3[34:15] : 20'h0)
       | (hitsVec_2 ? _normal_entries_WIRE_5[34:15] : 20'h0)
       | (hitsVec_3 ? _normal_entries_WIRE_7[34:15] : 20'h0)
       | (hitsVec_4 ? _normal_entries_WIRE_9[34:15] : 20'h0)
       | (hitsVec_5 ? _normal_entries_WIRE_11[34:15] : 20'h0)
       | (hitsVec_6 ? _normal_entries_WIRE_13[34:15] : 20'h0)
       | (hitsVec_7 ? _normal_entries_WIRE_15[34:15] : 20'h0)
       | (hitsVec_8
            ? {superpage_entries_0_data_0[34:33],
               (ignore_1 ? io_req_bits_vaddr[29:21] : 9'h0)
                 | superpage_entries_0_data_0[32:24],
               io_req_bits_vaddr[20:12] | superpage_entries_0_data_0[23:15]}
            : 20'h0)
       | (hitsVec_9
            ? {superpage_entries_1_data_0[34:33],
               (ignore_4 ? io_req_bits_vaddr[29:21] : 9'h0)
                 | superpage_entries_1_data_0[32:24],
               io_req_bits_vaddr[20:12] | superpage_entries_1_data_0[23:15]}
            : 20'h0)
       | (hitsVec_10
            ? {superpage_entries_2_data_0[34:33],
               (ignore_7 ? io_req_bits_vaddr[29:21] : 9'h0)
                 | superpage_entries_2_data_0[32:24],
               io_req_bits_vaddr[20:12] | superpage_entries_2_data_0[23:15]}
            : 20'h0)
       | (hitsVec_11
            ? {superpage_entries_3_data_0[34:33],
               (ignore_10 ? io_req_bits_vaddr[29:21] : 9'h0)
                 | superpage_entries_3_data_0[32:24],
               io_req_bits_vaddr[20:12] | superpage_entries_3_data_0[23:15]}
            : 20'h0)
       | (hitsVec_12
            ? {special_entry_data_0[34:33],
               (ignore_13 ? io_req_bits_vaddr[29:21] : 9'h0)
                 | special_entry_data_0[32:24],
               (special_entry_level[1] ? 9'h0 : io_req_bits_vaddr[20:12])
                 | special_entry_data_0[23:15]}
            : 20'h0) | (_vm_enabled_T_2 ? 20'h0 : io_req_bits_vaddr[31:12]),
     io_req_bits_vaddr[11:0]};	// Cat.scala:30:58, Mux.scala:27:72, TLB.scala:86:77, :94:28, :106:26, :108:28, :109:{28,47}, :135:61, :163:30, :166:30, :167:56, :183:83, :191:52, :214:44, :217:77
  assign io_resp_pf_inst =
    bad_va
    | (|({~(x_array_lo_1[12] | special_entry_data_0[12]),
          ~(x_array_lo_1[11] | superpage_entries_3_data_0[12]),
          ~(x_array_lo_1[10] | superpage_entries_2_data_0[12]),
          ~(x_array_lo_1[9] | superpage_entries_1_data_0[12]),
          ~(x_array_lo_1[8] | superpage_entries_0_data_0[12]),
          ~(x_array_lo_1[7] | _normal_entries_WIRE_15[12]),
          ~(x_array_lo_1[6] | _normal_entries_WIRE_13[12]),
          ~(x_array_lo_1[5] | _normal_entries_WIRE_11[12]),
          ~(x_array_lo_1[4] | _normal_entries_WIRE_9[12]),
          ~(x_array_lo_1[3] | _normal_entries_WIRE_7[12]),
          ~(x_array_lo_1[2] | _normal_entries_WIRE_5[12]),
          ~(x_array_lo_1[1] | _normal_entries_WIRE_3[12]),
          ~(x_array_lo_1[0] | _normal_entries_WIRE_1[12])}
         & {hitsVec_12,
            hitsVec_11,
            hitsVec_10,
            hitsVec_9,
            hitsVec_8,
            hitsVec_7,
            hitsVec_6,
            hitsVec_5,
            hitsVec_4,
            hitsVec_3,
            hitsVec_2,
            hitsVec_1,
            hitsVec_0}));	// Cat.scala:30:58, TLB.scala:86:77, :166:30, :167:56, :214:44, :269:39, :284:117, :322:{23,33}, :344:{29,47,55}
  assign io_resp_ae_inst =
    |(~({{2{newEntry_px}},
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
         _normal_entries_WIRE_1[7]}
        & {1'h1,
           ~(special_entry_data_0[12]),
           ~(superpage_entries_3_data_0[12]),
           ~(superpage_entries_2_data_0[12]),
           ~(superpage_entries_1_data_0[12]),
           ~(superpage_entries_0_data_0[12]),
           ~(_normal_entries_WIRE_15[12]),
           ~(_normal_entries_WIRE_13[12]),
           ~(_normal_entries_WIRE_11[12]),
           ~(_normal_entries_WIRE_9[12]),
           ~(_normal_entries_WIRE_7[12]),
           ~(_normal_entries_WIRE_5[12]),
           ~(_normal_entries_WIRE_3[12]),
           ~(_normal_entries_WIRE_1[12])})
      & {~_vm_enabled_T_2,
         hitsVec_12,
         hitsVec_11,
         hitsVec_10,
         hitsVec_9,
         hitsVec_8,
         hitsVec_7,
         hitsVec_6,
         hitsVec_5,
         hitsVec_4,
         hitsVec_3,
         hitsVec_2,
         hitsVec_1,
         hitsVec_0});	// Bitwise.scala:72:12, Cat.scala:30:58, Consts.scala:81:75, TLB.scala:86:77, :166:30, :167:56, :183:{83,102}, :209:65, :214:44, :216:18, :270:89, :272:87, :347:{23,33,41}, :358:28
  assign io_ptw_req_valid = _io_ptw_req_valid_T;	// package.scala:15:47
  assign io_ptw_req_bits_bits_addr = r_refill_tag;	// TLB.scala:174:25
endmodule

