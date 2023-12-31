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

module Frontend(
  input         gated_clock,
                reset,
                auto_icache_master_out_a_ready,
                auto_icache_master_out_d_valid,
  input  [2:0]  auto_icache_master_out_d_bits_opcode,
  input  [3:0]  auto_icache_master_out_d_bits_size,
  input  [63:0] auto_icache_master_out_d_bits_data,
  input         auto_icache_master_out_d_bits_corrupt,
                io_cpu_might_request,
                io_cpu_req_valid,
  input  [39:0] io_cpu_req_bits_pc,
  input         io_cpu_req_bits_speculative,
                io_cpu_sfence_valid,
                io_cpu_sfence_bits_rs1,
                io_cpu_sfence_bits_rs2,
  input  [38:0] io_cpu_sfence_bits_addr,
  input         io_cpu_resp_ready,
                io_cpu_btb_update_valid,
  input  [4:0]  io_cpu_btb_update_bits_prediction_entry,
  input  [38:0] io_cpu_btb_update_bits_pc,
  input         io_cpu_btb_update_bits_isValid,
  input  [38:0] io_cpu_btb_update_bits_br_pc,
  input  [1:0]  io_cpu_btb_update_bits_cfiType,
  input         io_cpu_bht_update_valid,
  input  [7:0]  io_cpu_bht_update_bits_prediction_history,
  input  [38:0] io_cpu_bht_update_bits_pc,
  input         io_cpu_bht_update_bits_branch,
                io_cpu_bht_update_bits_taken,
                io_cpu_bht_update_bits_mispredict,
                io_cpu_flush_icache,
                io_ptw_req_ready,
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
  input  [63:0] io_ptw_customCSRs_csrs_0_value,
  output        auto_icache_master_out_a_valid,
  output [31:0] auto_icache_master_out_a_bits_address,
  output        io_cpu_resp_valid,
                io_cpu_resp_bits_btb_taken,
                io_cpu_resp_bits_btb_bridx,
  output [4:0]  io_cpu_resp_bits_btb_entry,
  output [7:0]  io_cpu_resp_bits_btb_bht_history,
  output [39:0] io_cpu_resp_bits_pc,
  output [31:0] io_cpu_resp_bits_data,
  output        io_cpu_resp_bits_xcpt_pf_inst,
                io_cpu_resp_bits_xcpt_ae_inst,
                io_cpu_resp_bits_replay,
                io_ptw_req_valid,
                io_ptw_req_bits_valid,
  output [26:0] io_ptw_req_bits_bits_addr
);

  wire        s2_redirect;	// Frontend.scala:311:26, :312:20, :316:{33,47}
  wire [38:0] predicted_npc;	// Frontend.scala:245:25, :305:19, :306:21
  wire        updateBTB;	// Frontend.scala:245:25, :273:125, :274:21
  wire [1:0]  _GEN;	// Frontend.scala:245:25, :249:40
  wire [1:0]  after_idx;	// Frontend.scala:245:25, :247:19
  wire        taken_taken;	// Frontend.scala:230:71
  wire [38:0] _io_cpu_npc_T;	// Frontend.scala:167:28
  wire        _fq_io_enq_valid_T_4;	// Frontend.scala:165:52
  reg         s2_valid;	// Frontend.scala:101:25
  wire        _btb_io_resp_valid;	// Frontend.scala:179:21
  wire        _btb_io_resp_bits_taken;	// Frontend.scala:179:21
  wire        _btb_io_resp_bits_bridx;	// Frontend.scala:179:21
  wire [38:0] _btb_io_resp_bits_target;	// Frontend.scala:179:21
  wire [4:0]  _btb_io_resp_bits_entry;	// Frontend.scala:179:21
  wire [7:0]  _btb_io_resp_bits_bht_history;	// Frontend.scala:179:21
  wire        _btb_io_resp_bits_bht_value;	// Frontend.scala:179:21
  wire        _btb_io_ras_head_valid;	// Frontend.scala:179:21
  wire [38:0] _btb_io_ras_head_bits;	// Frontend.scala:179:21
  wire        _tlb_io_resp_miss;	// Frontend.scala:98:19
  wire [31:0] _tlb_io_resp_paddr;	// Frontend.scala:98:19
  wire        _tlb_io_resp_pf_inst;	// Frontend.scala:98:19
  wire        _tlb_io_resp_ae_inst;	// Frontend.scala:98:19
  wire        _tlb_io_resp_cacheable;	// Frontend.scala:98:19
  wire        _fq_io_enq_ready;	// Frontend.scala:84:57
  wire [4:0]  _fq_io_mask;	// Frontend.scala:84:57
  wire        _icache_io_resp_valid;	// Frontend.scala:62:26
  wire [31:0] _icache_io_resp_bits_data;	// Frontend.scala:62:26
  wire        _icache_io_resp_bits_replay;	// Frontend.scala:62:26
  wire        _icache_io_resp_bits_ae;	// Frontend.scala:62:26
  reg         s1_valid;	// Frontend.scala:100:21
  wire        s0_valid =
    io_cpu_req_valid | ~(_fq_io_mask[2]) | ~(_fq_io_mask[3]) & (~s1_valid | ~s2_valid)
    | ~(_fq_io_mask[4]) & ~s1_valid & ~s2_valid;	// Frontend.scala:84:57, :100:21, :101:25, :103:{5,16}, :104:{6,17,41,45,55,58}, :105:{6,17,41}, :106:35
  reg  [39:0] s1_pc;	// Frontend.scala:108:18
  reg         s1_speculative;	// Frontend.scala:109:27
  reg  [39:0] s2_pc;	// Frontend.scala:110:22
  reg         s2_btb_resp_valid;	// Frontend.scala:111:44
  reg         s2_btb_resp_bits_taken;	// Frontend.scala:112:29
  reg         s2_btb_resp_bits_bridx;	// Frontend.scala:112:29
  reg  [4:0]  s2_btb_resp_bits_entry;	// Frontend.scala:112:29
  reg  [7:0]  s2_btb_resp_bits_bht_history;	// Frontend.scala:112:29
  reg         taken_predict_taken;	// Frontend.scala:112:29
  wire        s2_btb_taken = s2_btb_resp_valid & s2_btb_resp_bits_taken;	// Frontend.scala:111:44, :112:29, :113:40
  reg         s2_tlb_resp_miss;	// Frontend.scala:114:24
  reg         s2_tlb_resp_pf_inst;	// Frontend.scala:114:24
  reg         s2_tlb_resp_ae_inst;	// Frontend.scala:114:24
  reg         s2_tlb_resp_cacheable;	// Frontend.scala:114:24
  wire        s2_xcpt = s2_tlb_resp_ae_inst | s2_tlb_resp_pf_inst;	// Frontend.scala:114:24, :115:37
  reg         s2_speculative;	// Frontend.scala:116:27
  reg         s2_partial_insn_valid;	// Frontend.scala:117:38
  reg  [15:0] s2_partial_insn;	// Frontend.scala:118:28
  reg         wrong_path;	// Frontend.scala:119:27
  wire [39:0] _ntpc_T = {s1_pc[39:2], 2'h0} + 40'h4;	// Frontend.scala:108:18, :122:25, :170:52
  wire        _taken_T_57 = _fq_io_enq_ready & _fq_io_enq_valid_T_4;	// Decoupled.scala:40:37, Frontend.scala:84:57, :165:52
  reg         s2_replay_REG;	// Frontend.scala:127:58
  wire        s2_replay = s2_valid & ~_taken_T_57 | s2_replay_REG;	// Decoupled.scala:40:37, Frontend.scala:101:25, :127:{26,29,48,58}
  wire        _icache_io_s2_kill_T_2 =
    s2_speculative & ~(s2_tlb_resp_cacheable & ~(io_ptw_customCSRs_csrs_0_value[3]))
    | s2_xcpt;	// CustomCSRs.scala:40:69, Frontend.scala:114:24, :115:37, :116:27, :161:{59,62}, :162:{39,42,71}
  reg         fq_io_enq_valid_REG;	// Frontend.scala:165:29
  assign _fq_io_enq_valid_T_4 =
    fq_io_enq_valid_REG & s2_valid
    & (_icache_io_resp_valid | ~s2_tlb_resp_miss & _icache_io_s2_kill_T_2);	// Frontend.scala:62:26, :101:25, :114:24, :162:71, :165:{29,52,77,80,98}
  assign _io_cpu_npc_T =
    io_cpu_req_valid ? io_cpu_req_bits_pc[39:1] : s2_replay ? s2_pc[39:1] : predicted_npc;	// Frontend.scala:110:22, :127:48, :128:16, :167:28, :245:25, :305:19, :306:21
  wire [2:0]  _fq_io_enq_bits_mask_T_1 = 3'h3 << s2_pc[1];	// Frontend.scala:110:22, :170:52, package.scala:154:13
  wire        predicted_taken = _btb_io_resp_valid & _btb_io_resp_bits_taken;	// Frontend.scala:179:21, :192:29
  wire [38:0] _GEN_0 = {s2_pc[38:2], 2'h0};	// Frontend.scala:110:22, :170:52, :298:36, :299:33
  wire        taken_prevRVI = s2_partial_insn_valid & (&(s2_partial_insn[1:0]));	// Frontend.scala:117:38, :118:28, :208:{39,45}, :209:31
  wire        taken_valid = _fq_io_enq_bits_mask_T_1[0] & ~taken_prevRVI;	// Frontend.scala:170:52, :209:31, :210:{38,44,47}
  wire        taken_rviBranch = s2_partial_insn[6:0] == 7'h63;	// Frontend.scala:118:28, :214:{30,36}
  wire        taken_rviJump = s2_partial_insn[6:0] == 7'h6F;	// Frontend.scala:118:28, :214:30, :215:34
  wire        taken_rviJALR = s2_partial_insn[6:0] == 7'h67;	// Frontend.scala:118:28, :214:30, :216:34
  wire        taken_rviReturn =
    taken_rviJALR & ~(s2_partial_insn[7])
    & {_icache_io_resp_bits_data[3:2],
       _icache_io_resp_bits_data[0],
       s2_partial_insn[15]} == 4'h1;	// Frontend.scala:62:26, :118:28, :216:34, :217:{34,42,46,66,77}
  wire        taken_rviCall = (taken_rviJALR | taken_rviJump) & s2_partial_insn[7];	// Frontend.scala:118:28, :215:34, :216:34, :217:42, :218:{30,42}
  wire [4:0]  _GEN_1 = {_icache_io_resp_bits_data[15:13], _icache_io_resp_bits_data[1:0]};	// Frontend.scala:62:26, :219:28
  wire        taken_rvcBranch = _GEN_1 == 5'h19 | _GEN_1 == 5'h1D;	// Frontend.scala:219:{28,52,60}
  wire        taken_rvcJump = _GEN_1 == 5'h15;	// Frontend.scala:219:28, :221:26
  wire [5:0]  _GEN_2 = {_icache_io_resp_bits_data[15:12], _icache_io_resp_bits_data[1:0]};	// Frontend.scala:62:26, :219:28, :223:24
  wire        taken_rvcJR = _GEN_2 == 6'h22 & ~(|(_icache_io_resp_bits_data[6:2]));	// Frontend.scala:62:26, :211:37, :223:{24,46,53,59}
  wire        taken_rvcReturn =
    taken_rvcJR
    & {_icache_io_resp_bits_data[11:10], _icache_io_resp_bits_data[8:7]} == 4'h1;	// Frontend.scala:62:26, :217:66, :223:46, :224:{29,49}
  wire        taken_rvcJALR = _GEN_2 == 6'h26 & ~(|(_icache_io_resp_bits_data[6:2]));	// Frontend.scala:62:26, :211:37, :223:{24,53,59}, :225:{26,49,62}
  assign taken_taken =
    taken_prevRVI
    & (taken_rviJump | taken_rviJALR | taken_rviBranch & taken_predict_taken)
    | taken_valid
    & (taken_rvcJump | taken_rvcJALR | taken_rvcJR | taken_rvcBranch
       & taken_predict_taken);	// Frontend.scala:112:29, :209:31, :210:44, :214:36, :215:34, :216:34, :219:52, :221:26, :223:46, :225:49, :230:{17,40,53,71}, :231:{15,47,60}
  wire        taken_predictReturn =
    _btb_io_ras_head_valid
    & (taken_prevRVI & taken_rviReturn | taken_valid & taken_rvcReturn);	// Frontend.scala:179:21, :209:31, :210:44, :217:46, :224:29, :232:{49,61,74,83}
  wire        taken_predictJump =
    taken_prevRVI & taken_rviJump | taken_valid & taken_rvcJump;	// Frontend.scala:209:31, :210:44, :215:34, :221:26, :233:{33,44,53}
  wire        _taken_T_19 = taken_prevRVI & taken_rviBranch;	// Frontend.scala:209:31, :214:36, :234:53
  wire        _taken_T_20 = taken_valid & taken_rvcBranch;	// Frontend.scala:210:44, :219:52, :234:75
  wire        taken_predictBranch = taken_predict_taken & (_taken_T_19 | _taken_T_20);	// Frontend.scala:112:29, :234:{41,53,66,75}
  wire        _taken_T_29 = s2_valid & s2_btb_resp_valid;	// Frontend.scala:101:25, :111:44, :236:22
  wire        _taken_T_5 =
    _taken_T_29 & ~s2_btb_resp_bits_bridx & taken_valid
    & (&(_icache_io_resp_bits_data[1:0]));	// Frontend.scala:62:26, :112:29, :208:{39,45}, :210:44, :211:37, :236:{22,69,86}
  wire [32:0] _taken_npc_T_2 =
    taken_prevRVI
      ? {{13{_icache_io_resp_bits_data[15]}},
         s2_partial_insn[3]
           ? {_icache_io_resp_bits_data[3:0],
              s2_partial_insn[15:12],
              _icache_io_resp_bits_data[4],
              _icache_io_resp_bits_data[14:5]}
           : {{8{_icache_io_resp_bits_data[15]}},
              s2_partial_insn[7],
              _icache_io_resp_bits_data[14:9],
              s2_partial_insn[11:8]},
         1'h0} - 33'h2
      : {{22{_icache_io_resp_bits_data[12]}},
         _icache_io_resp_bits_data[14]
           ? {{3{_icache_io_resp_bits_data[12]}},
              _icache_io_resp_bits_data[6:5],
              _icache_io_resp_bits_data[2],
              _icache_io_resp_bits_data[11:10],
              _icache_io_resp_bits_data[4:3]}
           : {_icache_io_resp_bits_data[8],
              _icache_io_resp_bits_data[10:9],
              _icache_io_resp_bits_data[6],
              _icache_io_resp_bits_data[7],
              _icache_io_resp_bits_data[2],
              _icache_io_resp_bits_data[11],
              _icache_io_resp_bits_data[5:3]},
         1'h0};	// Cat.scala:30:58, Frontend.scala:62:26, :86:25, :118:28, :209:31, :211:37, :217:42, :222:{23,28}, :227:{23,31}, :264:{44,61}, RVC.scala:44:{36,42,51,57,69,76}, :45:{27,35,43,49,59}, RocketCore.scala:1037:48, :1039:65, :1041:39, :1043:66, :1045:57
  wire [39:0] _taken_npc_T_3 =
    {s2_pc[39:2], 2'h0} + {{7{_taken_npc_T_2[32]}}, _taken_npc_T_2};	// Frontend.scala:110:22, :170:52, :264:{39,44}
  wire        taken_prevRVI_1 = taken_valid & (&(_icache_io_resp_bits_data[1:0]));	// Frontend.scala:62:26, :208:{39,45}, :209:31, :210:44, :211:37
  wire        taken_valid_1 = _fq_io_enq_bits_mask_T_1[1] & ~taken_prevRVI_1;	// Frontend.scala:170:52, :209:31, :210:{38,44,47}
  wire        taken_rviBranch_1 = _icache_io_resp_bits_data[6:0] == 7'h63;	// Frontend.scala:62:26, :214:{30,36}
  wire        taken_rviJump_1 = _icache_io_resp_bits_data[6:0] == 7'h6F;	// Frontend.scala:62:26, :214:30, :215:34
  wire        taken_rviJALR_1 = _icache_io_resp_bits_data[6:0] == 7'h67;	// Frontend.scala:62:26, :214:30, :216:34
  wire        taken_rviReturn_1 =
    taken_rviJALR_1 & ~(_icache_io_resp_bits_data[7])
    & {_icache_io_resp_bits_data[19:18], _icache_io_resp_bits_data[16:15]} == 4'h1;	// Frontend.scala:62:26, :216:34, :217:{34,42,46,66}
  wire        taken_rviCall_1 =
    (taken_rviJALR_1 | taken_rviJump_1) & _icache_io_resp_bits_data[7];	// Frontend.scala:62:26, :215:34, :216:34, :217:42, :218:{30,42}
  wire [4:0]  _GEN_3 =
    {_icache_io_resp_bits_data[31:29], _icache_io_resp_bits_data[17:16]};	// Frontend.scala:62:26, :219:28
  wire        taken_rvcBranch_1 = _GEN_3 == 5'h19 | _GEN_3 == 5'h1D;	// Frontend.scala:219:{28,52,60}
  wire        taken_rvcJump_1 = _GEN_3 == 5'h15;	// Frontend.scala:219:28, :221:26
  wire [5:0]  _GEN_4 =
    {_icache_io_resp_bits_data[31:28], _icache_io_resp_bits_data[17:16]};	// Frontend.scala:62:26, :219:28, :223:24
  wire        taken_rvcJR_1 = _GEN_4 == 6'h22 & ~(|(_icache_io_resp_bits_data[22:18]));	// Frontend.scala:62:26, :211:37, :223:{24,46,53,59}
  wire        taken_rvcReturn_1 =
    taken_rvcJR_1
    & {_icache_io_resp_bits_data[27:26], _icache_io_resp_bits_data[24:23]} == 4'h1;	// Frontend.scala:62:26, :217:66, :223:46, :224:{29,49}
  wire        taken_rvcJALR_1 = _GEN_4 == 6'h26 & ~(|(_icache_io_resp_bits_data[22:18]));	// Frontend.scala:62:26, :211:37, :223:{24,53,59}, :225:{26,49,62}
  wire        taken_taken_1 =
    taken_prevRVI_1
    & (taken_rviJump_1 | taken_rviJALR_1 | taken_rviBranch_1 & taken_predict_taken)
    | taken_valid_1
    & (taken_rvcJump_1 | taken_rvcJALR_1 | taken_rvcJR_1 | taken_rvcBranch_1
       & taken_predict_taken);	// Frontend.scala:112:29, :209:31, :210:44, :214:36, :215:34, :216:34, :219:52, :221:26, :223:46, :225:49, :230:{17,40,53,71}, :231:{15,47,60}
  wire        taken_predictReturn_1 =
    _btb_io_ras_head_valid
    & (taken_prevRVI_1 & taken_rviReturn_1 | taken_valid_1 & taken_rvcReturn_1);	// Frontend.scala:179:21, :209:31, :210:44, :217:46, :224:29, :232:{49,61,74,83}
  wire        taken_predictJump_1 =
    taken_prevRVI_1 & taken_rviJump_1 | taken_valid_1 & taken_rvcJump_1;	// Frontend.scala:209:31, :210:44, :215:34, :221:26, :233:{33,44,53}
  wire        _taken_T_48 = taken_prevRVI_1 & taken_rviBranch_1;	// Frontend.scala:209:31, :214:36, :234:53
  wire        _taken_T_49 = taken_valid_1 & taken_rvcBranch_1;	// Frontend.scala:210:44, :219:52, :234:75
  wire        taken_predictBranch_1 = taken_predict_taken & (_taken_T_48 | _taken_T_49);	// Frontend.scala:112:29, :234:{41,53,66,75}
  wire        _taken_T_34 =
    _taken_T_29 & s2_btb_resp_bits_bridx & taken_valid_1
    & (&(_icache_io_resp_bits_data[17:16]));	// Frontend.scala:62:26, :112:29, :208:{39,45}, :210:44, :211:37, :236:{22,86}
  assign after_idx = taken_taken ? 2'h1 : 2'h2;	// Frontend.scala:151:24, :230:71, :245:25, :247:19
  assign _GEN =
    taken_taken
      ? ((taken_prevRVI ? taken_rviReturn : taken_rvcReturn)
           ? 2'h3
           : (taken_prevRVI ? taken_rviCall : taken_rvcJALR)
               ? 2'h2
               : {1'h0, ~(taken_prevRVI ? taken_rviBranch : taken_rvcBranch)})
      : (taken_prevRVI_1 ? taken_rviReturn_1 : taken_rvcReturn_1)
          ? 2'h3
          : (taken_prevRVI_1 ? taken_rviCall_1 : taken_rvcJALR_1)
              ? 2'h2
              : {1'h0, ~(taken_prevRVI_1 ? taken_rviBranch_1 : taken_rvcBranch_1)};	// Frontend.scala:86:25, :89:9, :121:29, :151:24, :209:31, :214:36, :217:46, :218:42, :219:52, :224:29, :225:49, :230:71, :245:25, :249:{40,46,50}, :250:{46,50}, :251:{46,50}
  wire [30:0] _GEN_5 =
    taken_prevRVI_1
      ? {{12{_icache_io_resp_bits_data[31]}},
         _icache_io_resp_bits_data[3]
           ? {_icache_io_resp_bits_data[19:12],
              _icache_io_resp_bits_data[20],
              _icache_io_resp_bits_data[30:21]}
           : {{8{_icache_io_resp_bits_data[31]}},
              _icache_io_resp_bits_data[7],
              _icache_io_resp_bits_data[30:25],
              _icache_io_resp_bits_data[11:8]}}
      : {{21{_icache_io_resp_bits_data[28]}},
         _icache_io_resp_bits_data[30]
           ? {{3{_icache_io_resp_bits_data[28]}},
              _icache_io_resp_bits_data[22:21],
              _icache_io_resp_bits_data[18],
              _icache_io_resp_bits_data[27:26],
              _icache_io_resp_bits_data[20:19]}
           : {_icache_io_resp_bits_data[24],
              _icache_io_resp_bits_data[26:25],
              _icache_io_resp_bits_data[22],
              _icache_io_resp_bits_data[23],
              _icache_io_resp_bits_data[18],
              _icache_io_resp_bits_data[27],
              _icache_io_resp_bits_data[21:19]}};	// Cat.scala:30:58, Frontend.scala:62:26, :209:31, :211:37, :217:42, :222:{23,28}, :227:{23,31}, :265:69, RVC.scala:44:{36,42,51,57,69,76}, :45:{27,35,43,49,59}, RocketCore.scala:1037:48, :1039:65, :1041:39, :1043:66, :1045:57
  wire [39:0] _taken_npc_T_10 =
    (taken_prevRVI_1 ? {s2_pc[39:2], 2'h2} - 40'h2 : {s2_pc[39:2], 2'h2})
    + {{8{_GEN_5[30]}}, _GEN_5, 1'h0};	// Frontend.scala:86:25, :110:22, :151:24, :209:31, :262:33, :265:{23,36,64,69}
  assign updateBTB =
    ~taken_taken & ~s2_btb_resp_valid
    & (taken_predictBranch_1 & taken_predict_taken | taken_predictJump_1
       | taken_predictReturn_1) | ~s2_btb_resp_valid
    & (taken_predictBranch & taken_predict_taken | taken_predictJump
       | taken_predictReturn);	// Frontend.scala:111:44, :112:29, :230:71, :232:49, :233:44, :234:41, :245:{13,25}, :273:{15,34,52,106,125}, :274:21
  wire        taken = taken_taken | taken_taken_1;	// Frontend.scala:230:71, :286:19
  assign predicted_npc =
    ~taken_taken & ~s2_btb_taken & s2_valid & taken_predictReturn_1 | ~s2_btb_taken
    & s2_valid & taken_predictReturn
      ? {1'h0, _btb_io_ras_head_bits[38:1]}
      : ~taken_taken & ~s2_btb_taken & s2_valid
        & (taken_predictBranch_1 | taken_predictJump_1)
          ? _taken_npc_T_10[39:1]
          : ~s2_btb_taken & s2_valid & (taken_predictBranch | taken_predictJump)
              ? _taken_npc_T_3[39:1]
              : predicted_taken
                  ? {_btb_io_resp_bits_target[38], _btb_io_resp_bits_target[38:1]}
                  : _ntpc_T[39:1];	// Cat.scala:30:58, Frontend.scala:86:25, :101:25, :113:40, :122:25, :179:21, :192:{29,56}, :193:21, :230:71, :232:49, :233:44, :234:41, :245:{13,25}, :254:{15,30}, :258:44, :259:20, :261:{44,61}, :264:39, :265:64, :266:27, :305:19, :306:21, package.scala:123:38
  wire        _GEN_6 = ~s2_btb_taken & taken;	// Frontend.scala:113:40, :172:22, :286:19, :311:{11,26}, :312:20, :313:34
  assign s2_redirect = ~s2_btb_taken & taken & _taken_T_57 | io_cpu_req_valid;	// Decoupled.scala:40:37, Frontend.scala:113:40, :286:19, :311:{11,26}, :312:20, :316:{33,47}
  `ifndef SYNTHESIS	// Frontend.scala:89:9
    always @(posedge gated_clock) begin	// Frontend.scala:89:9
      if (~(~(io_cpu_req_valid | io_cpu_sfence_valid | io_cpu_flush_icache
              | io_cpu_bht_update_valid | io_cpu_btb_update_valid) | io_cpu_might_request
            | reset)) begin	// Frontend.scala:89:{9,10,102}
        if (`ASSERT_VERBOSE_COND_)	// Frontend.scala:89:9
          $error("Assertion failed\n    at Frontend.scala:89 assert(!(io.cpu.req.valid || io.cpu.sfence.valid || io.cpu.flush_icache || io.cpu.bht_update.valid || io.cpu.btb_update.valid) || io.cpu.might_request)\n");	// Frontend.scala:89:9
        if (`STOP_COND_)	// Frontend.scala:89:9
          $fatal;	// Frontend.scala:89:9
      end
      if (~(~(s2_speculative & io_ptw_customCSRs_csrs_0_value[3]
              & ~_icache_io_s2_kill_T_2) | reset)) begin	// CustomCSRs.scala:40:69, Frontend.scala:116:27, :162:71, :175:{9,10,110,113}
        if (`ASSERT_VERBOSE_COND_)	// Frontend.scala:175:9
          $error("Assertion failed\n    at Frontend.scala:175 assert(!(s2_speculative && io.ptw.customCSRs.asInstanceOf[RocketCustomCSRs].disableSpeculativeICacheRefill && !icache.io.s2_kill))\n");	// Frontend.scala:175:9
        if (`STOP_COND_)	// Frontend.scala:175:9
          $fatal;	// Frontend.scala:175:9
      end
      if (~(~s2_partial_insn_valid | _fq_io_enq_bits_mask_T_1[0] | reset)) begin	// Frontend.scala:117:38, :170:52, :210:38, :320:{11,12}
        if (`ASSERT_VERBOSE_COND_)	// Frontend.scala:320:11
          $error("Assertion failed\n    at Frontend.scala:320 assert(!s2_partial_insn_valid || fq.io.enq.bits.mask(0))\n");	// Frontend.scala:320:11
        if (`STOP_COND_)	// Frontend.scala:320:11
          $fatal;	// Frontend.scala:320:11
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge gated_clock) begin
    automatic logic _taken_T_61;	// Frontend.scala:281:37
    _taken_T_61 = taken_valid_1 & ~taken_taken & (&(_icache_io_resp_bits_data[17:16]));	// Frontend.scala:62:26, :208:{39,45}, :210:44, :211:37, :230:71, :245:13, :281:37
    s1_valid <= s0_valid;	// Frontend.scala:100:21, :106:35
    s1_pc <= {_io_cpu_npc_T, 1'h0};	// Frontend.scala:86:25, :108:18, :167:28, :341:33
    if (io_cpu_req_valid)
      s1_speculative <= io_cpu_req_bits_speculative;	// Frontend.scala:109:27
    else if (s2_replay)	// Frontend.scala:127:48
      s1_speculative <= s2_speculative;	// Frontend.scala:109:27, :116:27
    else	// Frontend.scala:127:48
      s1_speculative <= s1_speculative | s2_valid & ~s2_speculative | predicted_taken;	// Frontend.scala:101:25, :109:27, :116:27, :134:{53,56,72}, :192:29
    if (~s2_replay) begin	// Frontend.scala:127:48
      s2_btb_resp_valid <= _btb_io_resp_valid;	// Frontend.scala:111:44, :179:21
      s2_btb_resp_bits_taken <= _btb_io_resp_bits_taken;	// Frontend.scala:112:29, :179:21
      s2_btb_resp_bits_bridx <= _btb_io_resp_bits_bridx;	// Frontend.scala:112:29, :179:21
      s2_btb_resp_bits_entry <= _btb_io_resp_bits_entry;	// Frontend.scala:112:29, :179:21
      s2_btb_resp_bits_bht_history <= _btb_io_resp_bits_bht_history;	// Frontend.scala:112:29, :179:21
      taken_predict_taken <= _btb_io_resp_bits_bht_value;	// Frontend.scala:112:29, :179:21
      s2_tlb_resp_miss <= _tlb_io_resp_miss;	// Frontend.scala:98:19, :114:24
      s2_tlb_resp_pf_inst <= _tlb_io_resp_pf_inst;	// Frontend.scala:98:19, :114:24
      s2_tlb_resp_ae_inst <= _tlb_io_resp_ae_inst;	// Frontend.scala:98:19, :114:24
      s2_tlb_resp_cacheable <= _tlb_io_resp_cacheable;	// Frontend.scala:98:19, :114:24
    end
    if (_taken_T_57 & _taken_T_61)	// Decoupled.scala:40:37, Frontend.scala:118:28, :279:33, :281:{37,46}, :283:29
      s2_partial_insn <= {_icache_io_resp_bits_data[31:18], 2'h3};	// Frontend.scala:62:26, :118:28, :121:29, :211:37, :283:37
    fq_io_enq_valid_REG <= s1_valid;	// Frontend.scala:100:21, :165:29
    if (reset) begin
      s2_valid <= 1'h0;	// Frontend.scala:86:25, :101:25
      s2_pc <= 40'h10040;	// Frontend.scala:110:22
      s2_speculative <= 1'h0;	// Frontend.scala:86:25, :116:27
      s2_partial_insn_valid <= 1'h0;	// Frontend.scala:86:25, :117:38
      wrong_path <= 1'h0;	// Frontend.scala:86:25, :119:27
      s2_replay_REG <= 1'h1;	// Frontend.scala:89:9, :127:58
    end
    else begin
      automatic logic _GEN_7;	// Frontend.scala:236:95, :254:30, :255:96
      _GEN_7 =
        s2_btb_taken
          ? _taken_T_5 | wrong_path
          : _taken_T_57 & taken_taken & ~taken_predictBranch & ~taken_predictJump
            & ~taken_predictReturn | _taken_T_5 | wrong_path;	// Decoupled.scala:40:37, Frontend.scala:113:40, :119:27, :230:71, :232:49, :233:44, :234:41, :236:{86,95}, :241:20, :254:30, :255:{46,64,77,80,96}, :256:24
      s2_valid <= ~s2_replay & ~s2_redirect;	// Frontend.scala:101:25, :127:48, :139:12, :140:{9,21}, :141:{14,17}, :311:26, :312:20, :316:{33,47}
      if (~s2_replay) begin	// Frontend.scala:127:48
        s2_pc <= s1_pc;	// Frontend.scala:108:18, :110:22
        s2_speculative <= s1_speculative;	// Frontend.scala:109:27, :116:27
      end
      s2_partial_insn_valid <=
        ~(s2_redirect | _taken_T_57 & (s2_btb_taken | taken))
        & (_taken_T_57 ? _taken_T_61 : s2_partial_insn_valid);	// Decoupled.scala:40:37, Frontend.scala:113:40, :117:38, :279:33, :281:{37,46}, :286:19, :308:{28,45,56}, :309:29, :311:26, :312:20, :316:{33,47}, :321:{24,48}
      wrong_path <=
        ~io_cpu_req_valid
        & (taken_taken | s2_btb_taken
             ? _taken_T_34 | _GEN_7
             : _taken_T_57 & taken_taken_1 & ~taken_predictBranch_1 & ~taken_predictJump_1
               & ~taken_predictReturn_1 | _taken_T_34 | _GEN_7);	// Decoupled.scala:40:37, Frontend.scala:113:40, :119:27, :230:71, :232:49, :233:44, :234:41, :236:{86,95}, :241:20, :245:25, :254:30, :255:{46,64,77,80,96}, :256:24, :322:{29,42}
      s2_replay_REG <= s2_replay & ~s0_valid;	// Frontend.scala:106:35, :127:{48,58,69,72}
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:6];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [2:0] i = 3'h0; i < 3'h7; i += 3'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        s1_valid = _RANDOM[3'h0][1];	// Frontend.scala:100:21
        s2_valid = _RANDOM[3'h0][2];	// Frontend.scala:100:21, :101:25
        s1_pc = {_RANDOM[3'h0][31:3], _RANDOM[3'h1][10:0]};	// Frontend.scala:100:21, :108:18
        s1_speculative = _RANDOM[3'h1][11];	// Frontend.scala:108:18, :109:27
        s2_pc = {_RANDOM[3'h1][31:12], _RANDOM[3'h2][19:0]};	// Frontend.scala:108:18, :110:22
        s2_btb_resp_valid = _RANDOM[3'h2][20];	// Frontend.scala:110:22, :111:44
        s2_btb_resp_bits_taken = _RANDOM[3'h2][23];	// Frontend.scala:110:22, :112:29
        s2_btb_resp_bits_bridx = _RANDOM[3'h2][26];	// Frontend.scala:110:22, :112:29
        s2_btb_resp_bits_entry = _RANDOM[3'h4][6:2];	// Frontend.scala:112:29
        s2_btb_resp_bits_bht_history = _RANDOM[3'h4][14:7];	// Frontend.scala:112:29
        taken_predict_taken = _RANDOM[3'h4][15];	// Frontend.scala:112:29
        s2_tlb_resp_miss = _RANDOM[3'h4][16];	// Frontend.scala:112:29, :114:24
        s2_tlb_resp_pf_inst = _RANDOM[3'h5][19];	// Frontend.scala:114:24
        s2_tlb_resp_ae_inst = _RANDOM[3'h5][22];	// Frontend.scala:114:24
        s2_tlb_resp_cacheable = _RANDOM[3'h5][26];	// Frontend.scala:114:24
        s2_speculative = _RANDOM[3'h5][29];	// Frontend.scala:114:24, :116:27
        s2_partial_insn_valid = _RANDOM[3'h5][30];	// Frontend.scala:114:24, :117:38
        s2_partial_insn = {_RANDOM[3'h5][31], _RANDOM[3'h6][14:0]};	// Frontend.scala:114:24, :118:28
        wrong_path = _RANDOM[3'h6][15];	// Frontend.scala:118:28, :119:27
        s2_replay_REG = _RANDOM[3'h6][16];	// Frontend.scala:118:28, :127:58
        fq_io_enq_valid_REG = _RANDOM[3'h6][17];	// Frontend.scala:118:28, :165:29
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  ICache icache (	// Frontend.scala:62:26
    .clock                          (gated_clock),
    .reset                          (reset),
    .auto_master_out_a_ready        (auto_icache_master_out_a_ready),
    .auto_master_out_d_valid        (auto_icache_master_out_d_valid),
    .auto_master_out_d_bits_opcode  (auto_icache_master_out_d_bits_opcode),
    .auto_master_out_d_bits_size    (auto_icache_master_out_d_bits_size),
    .auto_master_out_d_bits_data    (auto_icache_master_out_d_bits_data),
    .auto_master_out_d_bits_corrupt (auto_icache_master_out_d_bits_corrupt),
    .io_req_valid                   (s0_valid),	// Frontend.scala:106:35
    .io_req_bits_addr               ({_io_cpu_npc_T[37:0], 1'h0}),	// Frontend.scala:86:25, :156:27, :167:28
    .io_s1_paddr                    (_tlb_io_resp_paddr),	// Frontend.scala:98:19
    .io_s1_kill                     (s2_redirect | _tlb_io_resp_miss | s2_replay),	// Frontend.scala:98:19, :127:48, :160:56, :311:26, :312:20, :316:{33,47}
    .io_s2_kill                     (_icache_io_s2_kill_T_2),	// Frontend.scala:162:71
    .io_invalidate                  (io_cpu_flush_icache),
    .auto_master_out_a_valid        (auto_icache_master_out_a_valid),
    .auto_master_out_a_bits_address (auto_icache_master_out_a_bits_address),
    .io_resp_valid                  (_icache_io_resp_valid),
    .io_resp_bits_data              (_icache_io_resp_bits_data),
    .io_resp_bits_replay            (_icache_io_resp_bits_replay),
    .io_resp_bits_ae                (_icache_io_resp_bits_ae)
  );
  ShiftQueue fq (	// Frontend.scala:84:57
    .clock                       (gated_clock),
    .reset                       (reset | io_cpu_req_valid),	// Frontend.scala:84:28
    .io_enq_valid                (_fq_io_enq_valid_T_4),	// Frontend.scala:165:52
    .io_enq_bits_btb_taken       (_GEN_6 | s2_btb_taken),	// Frontend.scala:113:40, :172:22, :173:28, :311:26, :312:20, :313:34, :314:34
    .io_enq_bits_btb_bridx       (_GEN_6 ? ~taken_taken : s2_btb_resp_bits_bridx),	// Frontend.scala:112:29, :172:22, :230:71, :245:13, :311:26, :312:20, :313:34
    .io_enq_bits_btb_entry       (_GEN_6 ? 5'h1C : s2_btb_resp_bits_entry),	// Frontend.scala:112:29, :172:22, :295:47, :311:26, :312:20, :313:34, :315:34
    .io_enq_bits_btb_bht_history (s2_btb_resp_bits_bht_history),	// Frontend.scala:112:29
    .io_enq_bits_pc              (s2_pc),	// Frontend.scala:110:22
    .io_enq_bits_data            (_icache_io_resp_bits_data),	// Frontend.scala:62:26
    .io_enq_bits_xcpt_pf_inst    (s2_tlb_resp_pf_inst),	// Frontend.scala:114:24
    .io_enq_bits_xcpt_ae_inst
      (_icache_io_resp_valid & _icache_io_resp_bits_ae | s2_tlb_resp_ae_inst),	// Frontend.scala:62:26, :114:24, :174:23, :176:{30,57,87}
    .io_enq_bits_replay
      (_taken_T_34 | _taken_T_5 | _icache_io_resp_bits_replay | _icache_io_s2_kill_T_2
       & ~_icache_io_resp_valid & ~s2_xcpt),	// Frontend.scala:62:26, :115:37, :162:71, :171:{25,79,101,104}, :236:{86,95}, :240:31
    .io_deq_ready                (io_cpu_resp_ready),
    .io_enq_ready                (_fq_io_enq_ready),
    .io_deq_valid                (io_cpu_resp_valid),
    .io_deq_bits_btb_taken       (io_cpu_resp_bits_btb_taken),
    .io_deq_bits_btb_bridx       (io_cpu_resp_bits_btb_bridx),
    .io_deq_bits_btb_entry       (io_cpu_resp_bits_btb_entry),
    .io_deq_bits_btb_bht_history (io_cpu_resp_bits_btb_bht_history),
    .io_deq_bits_pc              (io_cpu_resp_bits_pc),
    .io_deq_bits_data            (io_cpu_resp_bits_data),
    .io_deq_bits_xcpt_pf_inst    (io_cpu_resp_bits_xcpt_pf_inst),
    .io_deq_bits_xcpt_ae_inst    (io_cpu_resp_bits_xcpt_ae_inst),
    .io_deq_bits_replay          (io_cpu_resp_bits_replay),
    .io_mask                     (_fq_io_mask)
  );
  TLB_1 tlb (	// Frontend.scala:98:19
    .clock                        (gated_clock),
    .reset                        (reset),
    .io_req_valid                 (s1_valid & ~s2_replay),	// Frontend.scala:100:21, :127:48, :140:9, :148:32
    .io_req_bits_vaddr            (s1_pc),	// Frontend.scala:108:18
    .io_sfence_valid              (io_cpu_sfence_valid),
    .io_sfence_bits_rs1           (io_cpu_sfence_bits_rs1),
    .io_sfence_bits_rs2           (io_cpu_sfence_bits_rs2),
    .io_sfence_bits_addr          (io_cpu_sfence_bits_addr),
    .io_ptw_req_ready             (io_ptw_req_ready),
    .io_ptw_resp_valid            (io_ptw_resp_valid),
    .io_ptw_resp_bits_ae          (io_ptw_resp_bits_ae),
    .io_ptw_resp_bits_pte_ppn     (io_ptw_resp_bits_pte_ppn),
    .io_ptw_resp_bits_pte_d       (io_ptw_resp_bits_pte_d),
    .io_ptw_resp_bits_pte_a       (io_ptw_resp_bits_pte_a),
    .io_ptw_resp_bits_pte_g       (io_ptw_resp_bits_pte_g),
    .io_ptw_resp_bits_pte_u       (io_ptw_resp_bits_pte_u),
    .io_ptw_resp_bits_pte_x       (io_ptw_resp_bits_pte_x),
    .io_ptw_resp_bits_pte_w       (io_ptw_resp_bits_pte_w),
    .io_ptw_resp_bits_pte_r       (io_ptw_resp_bits_pte_r),
    .io_ptw_resp_bits_pte_v       (io_ptw_resp_bits_pte_v),
    .io_ptw_resp_bits_level       (io_ptw_resp_bits_level),
    .io_ptw_resp_bits_homogeneous (io_ptw_resp_bits_homogeneous),
    .io_ptw_ptbr_mode             (io_ptw_ptbr_mode),
    .io_ptw_status_debug          (io_ptw_status_debug),
    .io_ptw_status_prv            (io_ptw_status_prv),
    .io_ptw_pmp_0_cfg_l           (io_ptw_pmp_0_cfg_l),
    .io_ptw_pmp_0_cfg_a           (io_ptw_pmp_0_cfg_a),
    .io_ptw_pmp_0_cfg_x           (io_ptw_pmp_0_cfg_x),
    .io_ptw_pmp_0_cfg_w           (io_ptw_pmp_0_cfg_w),
    .io_ptw_pmp_0_cfg_r           (io_ptw_pmp_0_cfg_r),
    .io_ptw_pmp_0_addr            (io_ptw_pmp_0_addr),
    .io_ptw_pmp_0_mask            (io_ptw_pmp_0_mask),
    .io_ptw_pmp_1_cfg_l           (io_ptw_pmp_1_cfg_l),
    .io_ptw_pmp_1_cfg_a           (io_ptw_pmp_1_cfg_a),
    .io_ptw_pmp_1_cfg_x           (io_ptw_pmp_1_cfg_x),
    .io_ptw_pmp_1_cfg_w           (io_ptw_pmp_1_cfg_w),
    .io_ptw_pmp_1_cfg_r           (io_ptw_pmp_1_cfg_r),
    .io_ptw_pmp_1_addr            (io_ptw_pmp_1_addr),
    .io_ptw_pmp_1_mask            (io_ptw_pmp_1_mask),
    .io_ptw_pmp_2_cfg_l           (io_ptw_pmp_2_cfg_l),
    .io_ptw_pmp_2_cfg_a           (io_ptw_pmp_2_cfg_a),
    .io_ptw_pmp_2_cfg_x           (io_ptw_pmp_2_cfg_x),
    .io_ptw_pmp_2_cfg_w           (io_ptw_pmp_2_cfg_w),
    .io_ptw_pmp_2_cfg_r           (io_ptw_pmp_2_cfg_r),
    .io_ptw_pmp_2_addr            (io_ptw_pmp_2_addr),
    .io_ptw_pmp_2_mask            (io_ptw_pmp_2_mask),
    .io_ptw_pmp_3_cfg_l           (io_ptw_pmp_3_cfg_l),
    .io_ptw_pmp_3_cfg_a           (io_ptw_pmp_3_cfg_a),
    .io_ptw_pmp_3_cfg_x           (io_ptw_pmp_3_cfg_x),
    .io_ptw_pmp_3_cfg_w           (io_ptw_pmp_3_cfg_w),
    .io_ptw_pmp_3_cfg_r           (io_ptw_pmp_3_cfg_r),
    .io_ptw_pmp_3_addr            (io_ptw_pmp_3_addr),
    .io_ptw_pmp_3_mask            (io_ptw_pmp_3_mask),
    .io_ptw_pmp_4_cfg_l           (io_ptw_pmp_4_cfg_l),
    .io_ptw_pmp_4_cfg_a           (io_ptw_pmp_4_cfg_a),
    .io_ptw_pmp_4_cfg_x           (io_ptw_pmp_4_cfg_x),
    .io_ptw_pmp_4_cfg_w           (io_ptw_pmp_4_cfg_w),
    .io_ptw_pmp_4_cfg_r           (io_ptw_pmp_4_cfg_r),
    .io_ptw_pmp_4_addr            (io_ptw_pmp_4_addr),
    .io_ptw_pmp_4_mask            (io_ptw_pmp_4_mask),
    .io_ptw_pmp_5_cfg_l           (io_ptw_pmp_5_cfg_l),
    .io_ptw_pmp_5_cfg_a           (io_ptw_pmp_5_cfg_a),
    .io_ptw_pmp_5_cfg_x           (io_ptw_pmp_5_cfg_x),
    .io_ptw_pmp_5_cfg_w           (io_ptw_pmp_5_cfg_w),
    .io_ptw_pmp_5_cfg_r           (io_ptw_pmp_5_cfg_r),
    .io_ptw_pmp_5_addr            (io_ptw_pmp_5_addr),
    .io_ptw_pmp_5_mask            (io_ptw_pmp_5_mask),
    .io_ptw_pmp_6_cfg_l           (io_ptw_pmp_6_cfg_l),
    .io_ptw_pmp_6_cfg_a           (io_ptw_pmp_6_cfg_a),
    .io_ptw_pmp_6_cfg_x           (io_ptw_pmp_6_cfg_x),
    .io_ptw_pmp_6_cfg_w           (io_ptw_pmp_6_cfg_w),
    .io_ptw_pmp_6_cfg_r           (io_ptw_pmp_6_cfg_r),
    .io_ptw_pmp_6_addr            (io_ptw_pmp_6_addr),
    .io_ptw_pmp_6_mask            (io_ptw_pmp_6_mask),
    .io_ptw_pmp_7_cfg_l           (io_ptw_pmp_7_cfg_l),
    .io_ptw_pmp_7_cfg_a           (io_ptw_pmp_7_cfg_a),
    .io_ptw_pmp_7_cfg_x           (io_ptw_pmp_7_cfg_x),
    .io_ptw_pmp_7_cfg_w           (io_ptw_pmp_7_cfg_w),
    .io_ptw_pmp_7_cfg_r           (io_ptw_pmp_7_cfg_r),
    .io_ptw_pmp_7_addr            (io_ptw_pmp_7_addr),
    .io_ptw_pmp_7_mask            (io_ptw_pmp_7_mask),
    .io_kill                      (~s2_valid),	// Frontend.scala:101:25, :104:58
    .io_resp_miss                 (_tlb_io_resp_miss),
    .io_resp_paddr                (_tlb_io_resp_paddr),
    .io_resp_pf_inst              (_tlb_io_resp_pf_inst),
    .io_resp_ae_inst              (_tlb_io_resp_ae_inst),
    .io_resp_cacheable            (_tlb_io_resp_cacheable),
    .io_ptw_req_valid             (io_ptw_req_valid),
    .io_ptw_req_bits_valid        (io_ptw_req_bits_valid),
    .io_ptw_req_bits_bits_addr    (io_ptw_req_bits_bits_addr)
  );
  BTB btb (	// Frontend.scala:179:21
    .clock                                 (gated_clock),
    .reset                                 (reset),
    .io_req_bits_addr                      (s1_pc[38:0]),	// Frontend.scala:108:18, :182:26
    .io_btb_update_valid
      (io_cpu_btb_update_valid
         ? io_cpu_btb_update_valid
         : _taken_T_57 & ~wrong_path & ~(_fq_io_mask[1]) & updateBTB),	// Decoupled.scala:40:37, Frontend.scala:84:57, :119:27, :183:23, :245:25, :273:125, :274:21, :292:37, :293:{33,44}, :294:{31,54,89}
    .io_btb_update_bits_prediction_entry
      (io_cpu_btb_update_valid ? io_cpu_btb_update_bits_prediction_entry : 5'h1C),	// Frontend.scala:183:23, :292:37, :295:47
    .io_btb_update_bits_pc
      (io_cpu_btb_update_valid ? io_cpu_btb_update_bits_pc : _GEN_0),	// Frontend.scala:183:23, :292:37, :299:33
    .io_btb_update_bits_isValid
      (~io_cpu_btb_update_valid | io_cpu_btb_update_bits_isValid),	// Frontend.scala:183:23, :292:{11,37}, :296:38
    .io_btb_update_bits_br_pc
      (io_cpu_btb_update_valid
         ? io_cpu_btb_update_bits_br_pc
         : {s2_pc[38:2], ~taken_taken, 1'h0}),	// Frontend.scala:86:25, :110:22, :183:23, :230:71, :245:13, :292:37, :298:36
    .io_btb_update_bits_cfiType
      (io_cpu_btb_update_valid ? io_cpu_btb_update_bits_cfiType : _GEN),	// Frontend.scala:183:23, :245:25, :249:40, :292:37, :297:38
    .io_bht_update_valid                   (io_cpu_bht_update_valid),
    .io_bht_update_bits_prediction_history (io_cpu_bht_update_bits_prediction_history),
    .io_bht_update_bits_pc                 (io_cpu_bht_update_bits_pc),
    .io_bht_update_bits_branch             (io_cpu_bht_update_bits_branch),
    .io_bht_update_bits_taken              (io_cpu_bht_update_bits_taken),
    .io_bht_update_bits_mispredict         (io_cpu_bht_update_bits_mispredict),
    .io_bht_advance_valid
      (~taken_taken & (_taken_T_48 | _taken_T_49)
         ? _taken_T_57 & ~wrong_path
         : (_taken_T_19 | _taken_T_20) & _taken_T_57 & ~wrong_path),	// Decoupled.scala:40:37, Frontend.scala:119:27, :186:30, :230:71, :234:{53,75}, :245:{13,25}, :248:56, :269:{36,59}, :270:{36,56}
    .io_bht_advance_bits_bht_value         (taken_predict_taken),	// Frontend.scala:112:29
    .io_ras_update_valid
      (taken_taken
         ? _taken_T_57 & ~wrong_path
           & (taken_prevRVI & (taken_rviCall | taken_rviReturn) | taken_valid
              & (taken_rvcJALR | taken_rvcReturn))
         : _taken_T_57 & ~wrong_path
           & (taken_prevRVI_1 & (taken_rviCall_1 | taken_rviReturn_1) | taken_valid_1
              & (taken_rvcJALR_1 | taken_rvcReturn_1))),	// Decoupled.scala:40:37, Frontend.scala:119:27, :209:31, :210:44, :217:46, :218:42, :224:29, :225:49, :230:71, :245:25, :248:{33,56,68,80,92,106,115,127}
    .io_ras_update_bits_cfiType            (_GEN),	// Frontend.scala:245:25, :249:40
    .io_ras_update_bits_returnAddr         (_GEN_0 + {36'h0, after_idx, 1'h0}),	// Frontend.scala:86:25, :245:25, :247:19, :299:33, :302:53
    .io_flush                              (_taken_T_34 | _taken_T_5),	// Frontend.scala:236:{86,95}, :239:22
    .io_resp_valid                         (_btb_io_resp_valid),
    .io_resp_bits_taken                    (_btb_io_resp_bits_taken),
    .io_resp_bits_bridx                    (_btb_io_resp_bits_bridx),
    .io_resp_bits_target                   (_btb_io_resp_bits_target),
    .io_resp_bits_entry                    (_btb_io_resp_bits_entry),
    .io_resp_bits_bht_history              (_btb_io_resp_bits_bht_history),
    .io_resp_bits_bht_value                (_btb_io_resp_bits_bht_value),
    .io_ras_head_valid                     (_btb_io_ras_head_valid),
    .io_ras_head_bits                      (_btb_io_ras_head_bits)
  );
endmodule

