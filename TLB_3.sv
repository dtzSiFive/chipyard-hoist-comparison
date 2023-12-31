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

module TLB_3(
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
  input         io_kill,
  output        io_resp_miss,
  output [31:0] io_resp_paddr,
  output        io_resp_pf_inst,
                io_resp_ae_inst,
                io_resp_cacheable,
                io_ptw_req_valid,
                io_ptw_req_bits_valid,
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
    | {mpu_ppn[27:6], _GEN_3} == 24'h0;	// Parameters.scala:137:{31,49,52,67}, TLB.scala:189:20, :198:67
  wire [1:0]       _GEN_4 = {_GEN_1[3], mpu_ppn[16]};	// Parameters.scala:137:{31,49,52}, TLB.scala:189:20
  wire             newEntry_c =
    legal_address & ({mpu_ppn[19], _GEN_2[16], mpu_ppn[14:13]} == 4'h0 | ~(|_GEN_4));	// Parameters.scala:137:{31,49,52,67}, :615:89, TLB.scala:189:20, :198:67, :200:19
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
       | ~(|_GEN_4)) & ~deny_access_to_debug & _pmp_io_x;	// Parameters.scala:137:{31,49,52,67}, :615:89, TLB.scala:189:20, :193:19, :198:67, :203:48, :204:44, :209:65, :344:55
  wire [24:0]      _hitsVec_T = sectored_entries_0_0_tag[26:2] ^ io_req_bits_vaddr[38:14];	// TLB.scala:88:41, :163:30, :165:29
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
  wire             hitsVec_1 =
    _vm_enabled_T_2 & superpage_entries_0_valid_0
    & superpage_entries_0_tag[26:18] == io_req_bits_vaddr[38:30]
    & (ignore_1 | superpage_entries_0_tag[17:9] == io_req_bits_vaddr[29:21]);	// TLB.scala:94:28, :95:{40,46,77,84}, :163:30, :166:30, :183:83, :214:44
  wire             hitsVec_2 =
    _vm_enabled_T_2 & superpage_entries_1_valid_0
    & superpage_entries_1_tag[26:18] == io_req_bits_vaddr[38:30]
    & (ignore_4 | superpage_entries_1_tag[17:9] == io_req_bits_vaddr[29:21]);	// TLB.scala:94:28, :95:{40,46,77,84}, :163:30, :166:30, :183:83, :214:44
  wire             hitsVec_3 =
    _vm_enabled_T_2 & superpage_entries_2_valid_0
    & superpage_entries_2_tag[26:18] == io_req_bits_vaddr[38:30]
    & (ignore_7 | superpage_entries_2_tag[17:9] == io_req_bits_vaddr[29:21]);	// TLB.scala:94:28, :95:{40,46,77,84}, :163:30, :166:30, :183:83, :214:44
  wire             hitsVec_4 =
    _vm_enabled_T_2 & superpage_entries_3_valid_0
    & superpage_entries_3_tag[26:18] == io_req_bits_vaddr[38:30]
    & (ignore_10 | superpage_entries_3_tag[17:9] == io_req_bits_vaddr[29:21]);	// TLB.scala:94:28, :95:{40,46,77,84}, :163:30, :166:30, :183:83, :214:44
  wire             hitsVec_5 =
    _vm_enabled_T_2 & special_entry_valid_0
    & special_entry_tag[26:18] == io_req_bits_vaddr[38:30]
    & (ignore_13 | special_entry_tag[17:9] == io_req_bits_vaddr[29:21])
    & (~(special_entry_level[1]) | special_entry_tag[8:0] == io_req_bits_vaddr[20:12]);	// TLB.scala:95:{40,46,77,84}, :108:28, :163:30, :167:56, :183:83, :214:44
  wire [6:0]       hits =
    {~_vm_enabled_T_2, hitsVec_5, hitsVec_4, hitsVec_3, hitsVec_2, hitsVec_1, hitsVec_0};	// Cat.scala:30:58, TLB.scala:183:83, :214:44, :216:18
  wire [3:0][34:0] _GEN_6 =
    {{sectored_entries_0_0_data_3},
     {sectored_entries_0_0_data_2},
     {sectored_entries_0_0_data_1},
     {sectored_entries_0_0_data_0}};	// TLB.scala:165:29
  wire [34:0]      _normal_entries_WIRE_1 = _GEN_6[io_req_bits_vaddr[13:12]];	// TLB.scala:163:30, package.scala:154:13
  wire [5:0]       x_array_lo_1 =
    (io_ptw_status_prv[0]
       ? ~{special_entry_data_0[14],
           superpage_entries_3_data_0[14],
           superpage_entries_2_data_0[14],
           superpage_entries_1_data_0[14],
           superpage_entries_0_data_0[14],
           _normal_entries_WIRE_1[14]}
       : {special_entry_data_0[14],
          superpage_entries_3_data_0[14],
          superpage_entries_2_data_0[14],
          superpage_entries_1_data_0[14],
          superpage_entries_0_data_0[14],
          _normal_entries_WIRE_1[14]})
    & {special_entry_data_0[10],
       superpage_entries_3_data_0[10],
       superpage_entries_2_data_0[10],
       superpage_entries_1_data_0[10],
       superpage_entries_0_data_0[10],
       _normal_entries_WIRE_1[10]};	// Cat.scala:30:58, TLB.scala:86:77, :166:30, :167:56, :181:20, :266:{22,31}, :269:39
  wire             bad_va =
    _vm_enabled_T_2 & ~(io_req_bits_vaddr[39:38] == 2'h0 | (&(io_req_bits_vaddr[39:38])));	// TLB.scala:173:18, :183:83, :284:117, :289:43, :290:{47,61,67,82}
  wire             tlb_miss =
    _vm_enabled_T_2 & ~bad_va
    & {hitsVec_5, hitsVec_4, hitsVec_3, hitsVec_2, hitsVec_1, hitsVec_0} == 6'h0;	// Cat.scala:30:58, TLB.scala:183:83, :214:44, :284:117, :324:27, :325:{32,40}
  reg  [2:0]       state_reg_1;	// Replacement.scala:168:70
  wire             multipleHits_rightOne_1 = hitsVec_1 | hitsVec_2;	// Misc.scala:182:16, TLB.scala:214:44
  wire             multipleHits_rightOne_3 = hitsVec_4 | hitsVec_5;	// Misc.scala:182:16, TLB.scala:214:44
  wire             multipleHits =
    hitsVec_1 & hitsVec_2 | hitsVec_0 & multipleHits_rightOne_1 | hitsVec_4 & hitsVec_5
    | hitsVec_3 & multipleHits_rightOne_3 | (hitsVec_0 | multipleHits_rightOne_1)
    & (hitsVec_3 | multipleHits_rightOne_3);	// Misc.scala:182:{16,49,61}, TLB.scala:214:44
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
    automatic logic [3:0]  _GEN_7 = mpu_ppn[16:13] ^ 4'hA;	// Parameters.scala:137:31, TLB.scala:189:20
    automatic logic        newEntry_pr;	// TLB.scala:204:66
    automatic logic [5:0]  _GEN_8 =
      {mpu_ppn[19], mpu_ppn[16:15], mpu_ppn[13], mpu_ppn[5:4]};	// Parameters.scala:137:{31,49,52}, TLB.scala:189:20
    automatic logic [5:0]  _GEN_9 =
      {mpu_ppn[19], mpu_ppn[16:15], _GEN_0[9], mpu_ppn[8], mpu_ppn[5]};	// Parameters.scala:137:{31,49,52}, TLB.scala:189:20
    automatic logic [2:0]  _GEN_10 = {mpu_ppn[19], mpu_ppn[16], ~(mpu_ppn[15])};	// Parameters.scala:137:{31,49,52}, TLB.scala:189:20
    automatic logic [6:0]  _GEN_11 =
      {mpu_ppn[19], _GEN_2[16:15], mpu_ppn[13], mpu_ppn[8], mpu_ppn[5:4]};	// Parameters.scala:137:{31,49,52}, TLB.scala:189:20
    automatic logic        newEntry_pw;	// TLB.scala:205:70
    automatic logic        newEntry_ppp;	// TLB.scala:200:19
    automatic logic        newEntry_pal;	// TLB.scala:200:19
    automatic logic        newEntry_paa;	// TLB.scala:200:19
    automatic logic        newEntry_eff;	// TLB.scala:200:19
    automatic logic        newEntry_g;	// TLB.scala:226:25
    automatic logic        newEntry_sr;	// PTW.scala:77:35
    automatic logic        newEntry_sw;	// PTW.scala:78:40
    automatic logic        newEntry_sx;	// PTW.scala:79:35
    automatic logic        _GEN_12 = io_ptw_resp_valid & ~io_ptw_resp_bits_homogeneous;	// TLB.scala:118:14, :167:56, :220:20, :240:{37,68}
    automatic logic        _GEN_13;	// TLB.scala:167:56, :220:20, :240:68, :243:34
    automatic logic        _GEN_14;	// TLB.scala:166:30, :220:20, :240:68
    automatic logic        _GEN_15;	// TLB.scala:166:30, :220:20, :240:68
    automatic logic        _GEN_16;	// TLB.scala:166:30, :220:20, :240:68
    automatic logic        _GEN_17;	// TLB.scala:166:30, :220:20, :240:68
    automatic logic        _GEN_18;	// TLB.scala:166:30, :220:20, :240:68
    automatic logic        _GEN_19;	// TLB.scala:166:30, :220:20, :240:68
    automatic logic        _GEN_20;	// TLB.scala:166:30, :220:20, :240:68
    automatic logic        _GEN_21;	// TLB.scala:166:30, :220:20, :240:68
    automatic logic        _GEN_22 =
      ~io_ptw_resp_bits_homogeneous | ~(io_ptw_resp_bits_level[1]);	// TLB.scala:165:29, :240:{37,68}, :245:{40,54}, :253:82
    automatic logic        _GEN_23 = ~io_ptw_resp_valid | _GEN_22;	// TLB.scala:165:29, :220:20, :240:68, :245:54, :253:82
    automatic logic        _GEN_24;	// TLB.scala:122:16
    automatic logic        _GEN_25;	// TLB.scala:122:16
    automatic logic        _GEN_26;	// TLB.scala:122:16
    automatic logic [34:0] _sectored_entries_0_0_data_T;	// TLB.scala:123:24
    automatic logic        _GEN_27;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_28;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_29;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_30;	// TLB.scala:165:29, :220:20, :240:68
    automatic logic        _GEN_31;	// TLB.scala:363:25
    automatic logic [24:0] _GEN_32;	// TLB.scala:88:41
    automatic logic        _GEN_33;	// TLB.scala:88:66
    automatic logic        _GEN_34;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_35;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_36;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_37;	// TLB.scala:131:{34,58}, :220:20
    automatic logic        _GEN_38;	// TLB.scala:135:61
    automatic logic        _GEN_39 = multipleHits | reset;	// Misc.scala:182:49, TLB.scala:392:24
    invalidate_refill = _io_ptw_req_valid_T | (&state) | io_sfence_valid;	// TLB.scala:173:18, :188:88, package.scala:15:47
    newEntry_pr = legal_address & ~deny_access_to_debug & _pmp_io_r;	// TLB.scala:193:19, :198:67, :203:48, :204:{44,66}
    newEntry_pw =
      legal_address & (~(|_GEN_8) | ~(|_GEN_9) | ~(|_GEN_10) | ~(|_GEN_11) | ~(|_GEN_4))
      & ~deny_access_to_debug & _pmp_io_w;	// Parameters.scala:137:{49,52,67}, :615:89, TLB.scala:193:19, :198:67, :203:48, :204:44, :205:70
    newEntry_ppp =
      legal_address & (~(|_GEN_8) | ~(|_GEN_9) | ~(|_GEN_10) | ~(|_GEN_11) | ~(|_GEN_4));	// Parameters.scala:137:{49,52,67}, :615:89, TLB.scala:198:67, :200:19
    newEntry_pal =
      legal_address & (~(|_GEN_8) | ~(|_GEN_9) | ~(|_GEN_10) | ~(|_GEN_11) | ~(|_GEN_4));	// Parameters.scala:137:{49,52,67}, :615:89, TLB.scala:198:67, :200:19
    newEntry_paa =
      legal_address & (~(|_GEN_8) | ~(|_GEN_9) | ~(|_GEN_10) | ~(|_GEN_11) | ~(|_GEN_4));	// Parameters.scala:137:{49,52,67}, :615:89, TLB.scala:198:67, :200:19
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
            _GEN_7[3],
            _GEN_7[1:0],
            mpu_ppn[8],
            mpu_ppn[5:4],
            mpu_ppn[1]} == 8'h0);	// Parameters.scala:137:{31,49,52,67}, :615:89, Replacement.scala:168:70, TLB.scala:189:20, :190:20, :198:67, :200:19, :344:55
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
    _GEN_13 = _GEN_12 ? ~invalidate_refill : special_entry_valid_0;	// TLB.scala:118:14, :122:16, :126:46, :165:29, :167:56, :182:27, :188:88, :220:20, :240:68, :243:34
    _GEN_14 =
      io_ptw_resp_valid & io_ptw_resp_bits_homogeneous & ~(io_ptw_resp_bits_level[1])
      & r_superpage_repl_addr == 2'h0;	// TLB.scala:166:30, :173:18, :175:34, :220:20, :240:68, :245:40, :246:82
    _GEN_15 = _GEN_14 ? ~invalidate_refill : superpage_entries_0_valid_0;	// TLB.scala:122:16, :126:46, :165:29, :166:30, :182:27, :188:88, :220:20, :240:68, :243:34
    _GEN_16 =
      io_ptw_resp_valid & io_ptw_resp_bits_homogeneous & ~(io_ptw_resp_bits_level[1])
      & r_superpage_repl_addr == 2'h1;	// TLB.scala:166:30, :175:34, :220:20, :240:68, :245:40, :246:82, package.scala:15:47
    _GEN_17 = _GEN_16 ? ~invalidate_refill : superpage_entries_1_valid_0;	// TLB.scala:122:16, :126:46, :165:29, :166:30, :182:27, :188:88, :220:20, :240:68, :243:34
    _GEN_18 =
      io_ptw_resp_valid & io_ptw_resp_bits_homogeneous & ~(io_ptw_resp_bits_level[1])
      & r_superpage_repl_addr == 2'h2;	// TLB.scala:108:28, :166:30, :175:34, :220:20, :240:68, :245:40, :246:82
    _GEN_19 = _GEN_18 ? ~invalidate_refill : superpage_entries_2_valid_0;	// TLB.scala:122:16, :126:46, :165:29, :166:30, :182:27, :188:88, :220:20, :240:68, :243:34
    _GEN_20 =
      io_ptw_resp_valid & io_ptw_resp_bits_homogeneous & ~(io_ptw_resp_bits_level[1])
      & (&r_superpage_repl_addr);	// TLB.scala:166:30, :175:34, :220:20, :240:68, :245:40, :246:82
    _GEN_21 = _GEN_20 ? ~invalidate_refill : superpage_entries_3_valid_0;	// TLB.scala:122:16, :126:46, :165:29, :166:30, :182:27, :188:88, :220:20, :240:68, :243:34
    _GEN_24 = r_refill_tag[1:0] == 2'h0;	// TLB.scala:122:16, :173:18, :174:25, package.scala:154:13
    _GEN_25 = r_refill_tag[1:0] == 2'h1;	// TLB.scala:122:16, :174:25, package.scala:15:47, :154:13
    _GEN_26 = r_refill_tag[1:0] == 2'h2;	// TLB.scala:108:28, :122:16, :174:25, package.scala:154:13
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
    _GEN_27 =
      _GEN_23
        ? sectored_entries_0_0_valid_0
        : ~invalidate_refill & (_GEN_24 | r_sectored_hit & sectored_entries_0_0_valid_0);	// TLB.scala:122:16, :126:46, :165:29, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34
    _GEN_28 =
      _GEN_23
        ? sectored_entries_0_0_valid_1
        : ~invalidate_refill & (_GEN_25 | r_sectored_hit & sectored_entries_0_0_valid_1);	// TLB.scala:122:16, :126:46, :165:29, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34
    _GEN_29 =
      _GEN_23
        ? sectored_entries_0_0_valid_2
        : ~invalidate_refill & (_GEN_26 | r_sectored_hit & sectored_entries_0_0_valid_2);	// TLB.scala:122:16, :126:46, :165:29, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34
    _GEN_30 =
      _GEN_23
        ? sectored_entries_0_0_valid_3
        : ~invalidate_refill
          & ((&(r_refill_tag[1:0])) | r_sectored_hit & sectored_entries_0_0_valid_3);	// TLB.scala:122:16, :126:46, :165:29, :174:25, :178:27, :188:88, :220:20, :240:68, :254:32, :256:34, package.scala:154:13
    _GEN_31 = state == 2'h0 & io_req_valid & tlb_miss;	// TLB.scala:173:18, :325:40, :341:25, :363:25
    _GEN_32 = sectored_entries_0_0_tag[26:2] ^ io_req_bits_vaddr[38:14];	// TLB.scala:88:41, :163:30, :165:29
    _GEN_33 = _GEN_32 == 25'h0;	// TLB.scala:88:{41,66}
    _GEN_34 = _GEN_33 & io_req_bits_vaddr[13:12] == 2'h0;	// TLB.scala:88:66, :131:{34,58}, :163:30, :173:18, :220:20, package.scala:154:13
    _GEN_35 = _GEN_33 & io_req_bits_vaddr[13:12] == 2'h1;	// TLB.scala:88:66, :131:{34,58}, :163:30, :220:20, package.scala:15:47, :154:13
    _GEN_36 = _GEN_33 & io_req_bits_vaddr[13:12] == 2'h2;	// TLB.scala:88:66, :108:28, :131:{34,58}, :163:30, :220:20, package.scala:154:13
    _GEN_37 = _GEN_33 & (&(io_req_bits_vaddr[13:12]));	// TLB.scala:88:66, :131:{34,58}, :163:30, :220:20, package.scala:154:13
    _GEN_38 = _GEN_32[24:16] == 9'h0;	// TLB.scala:88:41, :135:{26,61}
    if (_GEN_23) begin	// TLB.scala:165:29, :220:20, :240:68
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_0_tag <= r_refill_tag;	// TLB.scala:165:29, :174:25
    if (~io_ptw_resp_valid | _GEN_22 | ~_GEN_24) begin	// TLB.scala:122:16, :165:29, :220:20, :240:68, :245:54, :253:82
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_0_data_0 <= _sectored_entries_0_0_data_T;	// TLB.scala:123:24, :165:29
    if (~io_ptw_resp_valid | _GEN_22 | ~_GEN_25) begin	// TLB.scala:122:16, :165:29, :220:20, :240:68, :245:54, :253:82
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_0_data_1 <= _sectored_entries_0_0_data_T;	// TLB.scala:123:24, :165:29
    if (~io_ptw_resp_valid | _GEN_22 | ~_GEN_26) begin	// TLB.scala:122:16, :165:29, :220:20, :240:68, :245:54, :253:82
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_0_data_2 <= _sectored_entries_0_0_data_T;	// TLB.scala:123:24, :165:29
    if (~io_ptw_resp_valid | _GEN_22 | ~(&(r_refill_tag[1:0]))) begin	// TLB.scala:122:16, :165:29, :174:25, :220:20, :240:68, :245:54, :253:82, package.scala:154:13
    end
    else	// TLB.scala:165:29, :220:20, :240:68
      sectored_entries_0_0_data_3 <= _sectored_entries_0_0_data_T;	// TLB.scala:123:24, :165:29
    sectored_entries_0_0_valid_0 <=
      ~_GEN_39
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_38
                     ? ~(sectored_entries_0_0_data_0[0] | _GEN_34) & _GEN_27
                     : ~_GEN_34 & _GEN_27)
                : io_sfence_bits_rs2 & sectored_entries_0_0_data_0[13] & _GEN_27)
           : _GEN_27);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    sectored_entries_0_0_valid_1 <=
      ~_GEN_39
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_38
                     ? ~(sectored_entries_0_0_data_1[0] | _GEN_35) & _GEN_28
                     : ~_GEN_35 & _GEN_28)
                : io_sfence_bits_rs2 & sectored_entries_0_0_data_1[13] & _GEN_28)
           : _GEN_28);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    sectored_entries_0_0_valid_2 <=
      ~_GEN_39
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_38
                     ? ~(sectored_entries_0_0_data_2[0] | _GEN_36) & _GEN_29
                     : ~_GEN_36 & _GEN_29)
                : io_sfence_bits_rs2 & sectored_entries_0_0_data_2[13] & _GEN_29)
           : _GEN_29);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    sectored_entries_0_0_valid_3 <=
      ~_GEN_39
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? (_GEN_38
                     ? ~(sectored_entries_0_0_data_3[0] | _GEN_37) & _GEN_30
                     : ~_GEN_37 & _GEN_30)
                : io_sfence_bits_rs2 & sectored_entries_0_0_data_3[13] & _GEN_30)
           : _GEN_30);	// TLB.scala:83:39, :126:46, :131:{34,58}, :135:{61,68}, :137:{41,45}, :143:19, :165:29, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    if (_GEN_14) begin	// TLB.scala:166:30, :220:20, :240:68
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
      ~_GEN_39
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? ~(superpage_entries_0_valid_0
                    & superpage_entries_0_tag[26:18] == io_req_bits_vaddr[38:30]
                    & (ignore_1
                       | superpage_entries_0_tag[17:9] == io_req_bits_vaddr[29:21]))
                  & _GEN_15
                : io_sfence_bits_rs2 & superpage_entries_0_data_0[13] & _GEN_15)
           : _GEN_15);	// TLB.scala:83:39, :94:28, :95:{29,40,46,77,84}, :126:46, :129:23, :143:19, :163:30, :166:30, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    if (_GEN_16) begin	// TLB.scala:166:30, :220:20, :240:68
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
      ~_GEN_39
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? ~(superpage_entries_1_valid_0
                    & superpage_entries_1_tag[26:18] == io_req_bits_vaddr[38:30]
                    & (ignore_4
                       | superpage_entries_1_tag[17:9] == io_req_bits_vaddr[29:21]))
                  & _GEN_17
                : io_sfence_bits_rs2 & superpage_entries_1_data_0[13] & _GEN_17)
           : _GEN_17);	// TLB.scala:83:39, :94:28, :95:{29,40,46,77,84}, :126:46, :129:23, :143:19, :163:30, :166:30, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    if (_GEN_18) begin	// TLB.scala:166:30, :220:20, :240:68
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
      ~_GEN_39
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? ~(superpage_entries_2_valid_0
                    & superpage_entries_2_tag[26:18] == io_req_bits_vaddr[38:30]
                    & (ignore_7
                       | superpage_entries_2_tag[17:9] == io_req_bits_vaddr[29:21]))
                  & _GEN_19
                : io_sfence_bits_rs2 & superpage_entries_2_data_0[13] & _GEN_19)
           : _GEN_19);	// TLB.scala:83:39, :94:28, :95:{29,40,46,77,84}, :126:46, :129:23, :143:19, :163:30, :166:30, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    if (_GEN_20) begin	// TLB.scala:166:30, :220:20, :240:68
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
      ~_GEN_39
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? ~(superpage_entries_3_valid_0
                    & superpage_entries_3_tag[26:18] == io_req_bits_vaddr[38:30]
                    & (ignore_10
                       | superpage_entries_3_tag[17:9] == io_req_bits_vaddr[29:21]))
                  & _GEN_21
                : io_sfence_bits_rs2 & superpage_entries_3_data_0[13] & _GEN_21)
           : _GEN_21);	// TLB.scala:83:39, :94:28, :95:{29,40,46,77,84}, :126:46, :129:23, :143:19, :163:30, :166:30, :220:20, :240:68, :384:19, :387:35, :388:40, :392:{24,34}
    if (_GEN_12) begin	// TLB.scala:118:14, :167:56, :220:20, :240:68
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
      ~_GEN_39
      & (io_sfence_valid
           ? (io_sfence_bits_rs1
                ? ~(special_entry_valid_0
                    & special_entry_tag[26:18] == io_req_bits_vaddr[38:30]
                    & (ignore_13 | special_entry_tag[17:9] == io_req_bits_vaddr[29:21])
                    & (~(special_entry_level[1])
                       | special_entry_tag[8:0] == io_req_bits_vaddr[20:12])) & _GEN_13
                : io_sfence_bits_rs2 & special_entry_data_0[13] & _GEN_13)
           : _GEN_13);	// TLB.scala:83:39, :95:{29,40,46,77,84}, :108:28, :126:46, :129:23, :143:19, :163:30, :167:56, :220:20, :240:68, :243:34, :384:19, :387:35, :388:40, :392:{24,34}
    if (_GEN_31) begin	// TLB.scala:363:25
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
          r_superpage_repl_addr <= {1'h1, ~(_r_superpage_repl_addr_T_4[2])};	// Consts.scala:81:75, Mux.scala:47:69, OneHot.scala:47:40, TLB.scala:175:34, :183:102, :411:43
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
        if (io_kill)
          state <= 2'h0;	// TLB.scala:173:18
        else if (io_ptw_req_ready)
          state <= {1'h1, io_sfence_valid};	// Consts.scala:81:75, TLB.scala:173:18, :183:102, :374:45
        else if (io_sfence_valid)
          state <= 2'h0;	// TLB.scala:173:18
        else if (_GEN_31)	// TLB.scala:363:25
          state <= 2'h1;	// TLB.scala:173:18, package.scala:15:47
      end
      else if (_GEN_31)	// TLB.scala:363:25
        state <= 2'h1;	// TLB.scala:173:18, package.scala:15:47
      if (io_req_valid & _vm_enabled_T_2
          & (superpage_entries_0_valid_0
             & superpage_entries_0_tag[26:18] == io_req_bits_vaddr[38:30]
             & (ignore_1 | superpage_entries_0_tag[17:9] == io_req_bits_vaddr[29:21])
             | superpage_hits_1 | superpage_hits_2 | superpage_hits_3)) begin	// Replacement.scala:168:70, :172:15, TLB.scala:94:28, :95:{29,40,46,77,84}, :163:30, :166:30, :183:83, :329:37, :331:31, package.scala:72:59
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
  PMPChecker_2 pmp (	// TLB.scala:193:19
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
    .io_r           (_pmp_io_r),
    .io_w           (_pmp_io_w),
    .io_x           (_pmp_io_x)
  );
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
            : 20'h0) | (_vm_enabled_T_2 ? 20'h0 : io_req_bits_vaddr[31:12]),
     io_req_bits_vaddr[11:0]};	// Cat.scala:30:58, Mux.scala:27:72, TLB.scala:86:77, :94:28, :106:26, :108:28, :109:{28,47}, :135:61, :163:30, :166:30, :167:56, :183:83, :191:52, :214:44, :217:77
  assign io_resp_pf_inst =
    bad_va
    | (|({~(x_array_lo_1[5] | special_entry_data_0[12]),
          ~(x_array_lo_1[4] | superpage_entries_3_data_0[12]),
          ~(x_array_lo_1[3] | superpage_entries_2_data_0[12]),
          ~(x_array_lo_1[2] | superpage_entries_1_data_0[12]),
          ~(x_array_lo_1[1] | superpage_entries_0_data_0[12]),
          ~(x_array_lo_1[0] | _normal_entries_WIRE_1[12])}
         & {hitsVec_5, hitsVec_4, hitsVec_3, hitsVec_2, hitsVec_1, hitsVec_0}));	// Cat.scala:30:58, TLB.scala:86:77, :166:30, :167:56, :214:44, :269:39, :284:117, :322:{23,33}, :344:{29,47,55}
  assign io_resp_ae_inst =
    |(~({{2{newEntry_px}},
         superpage_entries_3_data_0[7],
         superpage_entries_2_data_0[7],
         superpage_entries_1_data_0[7],
         superpage_entries_0_data_0[7],
         _normal_entries_WIRE_1[7]}
        & {1'h1,
           ~(special_entry_data_0[12]),
           ~(superpage_entries_3_data_0[12]),
           ~(superpage_entries_2_data_0[12]),
           ~(superpage_entries_1_data_0[12]),
           ~(superpage_entries_0_data_0[12]),
           ~(_normal_entries_WIRE_1[12])}) & hits);	// Bitwise.scala:72:12, Cat.scala:30:58, Consts.scala:81:75, TLB.scala:86:77, :166:30, :167:56, :183:102, :209:65, :270:89, :272:87, :347:{23,33,41}
  assign io_resp_cacheable =
    |({{2{newEntry_c}},
       superpage_entries_3_data_0[1],
       superpage_entries_2_data_0[1],
       superpage_entries_1_data_0[1],
       superpage_entries_0_data_0[1],
       _normal_entries_WIRE_1[1]} & hits);	// Bitwise.scala:72:12, Cat.scala:30:58, TLB.scala:86:77, :166:30, :200:19, :351:{33,41}
  assign io_ptw_req_valid = _io_ptw_req_valid_T;	// package.scala:15:47
  assign io_ptw_req_bits_valid = ~io_kill;	// TLB.scala:358:28
  assign io_ptw_req_bits_bits_addr = r_refill_tag;	// TLB.scala:174:25
endmodule

