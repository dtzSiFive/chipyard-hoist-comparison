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

module Frontend_2(
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
  input  [33:0] io_cpu_req_bits_pc,
  input         io_cpu_req_bits_speculative,
                io_cpu_sfence_valid,
                io_cpu_resp_ready,
                io_cpu_btb_update_valid,
                io_cpu_bht_update_valid,
                io_cpu_flush_icache,
                io_ptw_status_debug,
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
  output [33:0] io_cpu_resp_bits_pc,
  output [31:0] io_cpu_resp_bits_data,
  output        io_cpu_resp_bits_xcpt_pf_inst,
                io_cpu_resp_bits_xcpt_ae_inst,
                io_cpu_resp_bits_replay,
                io_ptw_req_valid,
                io_ptw_req_bits_valid,
  output [20:0] io_ptw_req_bits_bits_addr
);

  wire [32:0] _io_cpu_npc_T;	// Frontend.scala:167:28
  wire        _fq_io_enq_valid_T_4;	// Frontend.scala:165:52
  reg         s2_valid;	// Frontend.scala:101:25
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
  reg  [33:0] s1_pc;	// Frontend.scala:108:18
  reg         s1_speculative;	// Frontend.scala:109:27
  reg  [33:0] s2_pc;	// Frontend.scala:110:22
  reg         s2_tlb_resp_miss;	// Frontend.scala:114:24
  reg         s2_tlb_resp_pf_inst;	// Frontend.scala:114:24
  reg         s2_tlb_resp_ae_inst;	// Frontend.scala:114:24
  reg         s2_tlb_resp_cacheable;	// Frontend.scala:114:24
  wire        s2_xcpt = s2_tlb_resp_ae_inst | s2_tlb_resp_pf_inst;	// Frontend.scala:114:24, :115:37
  reg         s2_speculative;	// Frontend.scala:116:27
  wire [33:0] predicted_npc = {s1_pc[33:2], 2'h0} + 34'h4;	// Frontend.scala:108:18, :121:20, :122:25
  reg         s2_replay_REG;	// Frontend.scala:127:58
  wire        s2_replay =
    s2_valid & ~(_fq_io_enq_ready & _fq_io_enq_valid_T_4) | s2_replay_REG;	// Decoupled.scala:40:37, Frontend.scala:84:57, :101:25, :127:{26,29,48,58}, :165:52
  wire        _icache_io_s2_kill_T_2 =
    s2_speculative & ~(s2_tlb_resp_cacheable & ~(io_ptw_customCSRs_csrs_0_value[3]))
    | s2_xcpt;	// CustomCSRs.scala:40:69, Frontend.scala:114:24, :115:37, :116:27, :161:{59,62}, :162:{39,42,71}
  reg         fq_io_enq_valid_REG;	// Frontend.scala:165:29
  assign _fq_io_enq_valid_T_4 =
    fq_io_enq_valid_REG & s2_valid
    & (_icache_io_resp_valid | ~s2_tlb_resp_miss & _icache_io_s2_kill_T_2);	// Frontend.scala:62:26, :101:25, :114:24, :162:71, :165:{29,52,77,80,98}
  assign _io_cpu_npc_T =
    io_cpu_req_valid
      ? io_cpu_req_bits_pc[33:1]
      : s2_replay ? s2_pc[33:1] : predicted_npc[33:1];	// Frontend.scala:110:22, :122:25, :127:48, :128:16, :167:28
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
    end // always @(posedge)
  `endif // not def SYNTHESIS
  always @(posedge gated_clock) begin
    s1_valid <= s0_valid;	// Frontend.scala:100:21, :106:35
    s1_pc <= {_io_cpu_npc_T, 1'h0};	// Frontend.scala:62:26, :84:57, :98:19, :108:18, :167:28, :341:33
    if (io_cpu_req_valid)
      s1_speculative <= io_cpu_req_bits_speculative;	// Frontend.scala:109:27
    else if (s2_replay)	// Frontend.scala:127:48
      s1_speculative <= s2_speculative;	// Frontend.scala:109:27, :116:27
    else	// Frontend.scala:127:48
      s1_speculative <= s1_speculative | s2_valid & ~s2_speculative;	// Frontend.scala:101:25, :109:27, :116:27, :134:{41,53,56}
    s2_tlb_resp_miss <= s2_replay & s2_tlb_resp_miss;	// Frontend.scala:114:24, :127:48, :140:21, :144:17
    if (~s2_replay) begin	// Frontend.scala:127:48
      s2_tlb_resp_pf_inst <= _tlb_io_resp_pf_inst;	// Frontend.scala:98:19, :114:24
      s2_tlb_resp_ae_inst <= _tlb_io_resp_ae_inst;	// Frontend.scala:98:19, :114:24
      s2_tlb_resp_cacheable <= _tlb_io_resp_cacheable;	// Frontend.scala:98:19, :114:24
    end
    fq_io_enq_valid_REG <= s1_valid;	// Frontend.scala:100:21, :165:29
    if (reset) begin
      s2_valid <= 1'h0;	// Frontend.scala:62:26, :84:57, :98:19, :101:25
      s2_pc <= 34'h10040;	// Frontend.scala:110:22
      s2_speculative <= 1'h0;	// Frontend.scala:62:26, :84:57, :98:19, :116:27
      s2_replay_REG <= 1'h1;	// Frontend.scala:89:9, :127:58
    end
    else begin
      s2_valid <= ~s2_replay & ~io_cpu_req_valid;	// Frontend.scala:101:25, :127:48, :139:12, :140:{9,21}, :141:{14,17}
      if (~s2_replay) begin	// Frontend.scala:127:48
        s2_pc <= s1_pc;	// Frontend.scala:108:18, :110:22
        s2_speculative <= s1_speculative;	// Frontend.scala:109:27, :116:27
      end
      s2_replay_REG <= s2_replay & ~s0_valid;	// Frontend.scala:106:35, :127:{48,58,69,72}
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:5];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [2:0] i = 3'h0; i < 3'h6; i += 3'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        s1_valid = _RANDOM[3'h0][1];	// Frontend.scala:100:21
        s2_valid = _RANDOM[3'h0][2];	// Frontend.scala:100:21, :101:25
        s1_pc = {_RANDOM[3'h0][31:3], _RANDOM[3'h1][4:0]};	// Frontend.scala:100:21, :108:18
        s1_speculative = _RANDOM[3'h1][5];	// Frontend.scala:108:18, :109:27
        s2_pc = {_RANDOM[3'h1][31:6], _RANDOM[3'h2][7:0]};	// Frontend.scala:108:18, :110:22
        s2_tlb_resp_miss = _RANDOM[3'h3][25];	// Frontend.scala:114:24
        s2_tlb_resp_pf_inst = _RANDOM[3'h4][28];	// Frontend.scala:114:24
        s2_tlb_resp_ae_inst = _RANDOM[3'h4][31];	// Frontend.scala:114:24
        s2_tlb_resp_cacheable = _RANDOM[3'h5][3];	// Frontend.scala:114:24
        s2_speculative = _RANDOM[3'h5][6];	// Frontend.scala:114:24, :116:27
        s2_replay_REG = _RANDOM[3'h5][25];	// Frontend.scala:114:24, :127:58
        fq_io_enq_valid_REG = _RANDOM[3'h5][26];	// Frontend.scala:114:24, :165:29
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  ICache_2 icache (	// Frontend.scala:62:26
    .clock                          (gated_clock),
    .reset                          (reset),
    .auto_master_out_a_ready        (auto_icache_master_out_a_ready),
    .auto_master_out_d_valid        (auto_icache_master_out_d_valid),
    .auto_master_out_d_bits_opcode  (auto_icache_master_out_d_bits_opcode),
    .auto_master_out_d_bits_size    (auto_icache_master_out_d_bits_size),
    .auto_master_out_d_bits_data    (auto_icache_master_out_d_bits_data),
    .auto_master_out_d_bits_corrupt (auto_icache_master_out_d_bits_corrupt),
    .io_req_valid                   (s0_valid),	// Frontend.scala:106:35
    .io_req_bits_addr               ({_io_cpu_npc_T[31:0], 1'h0}),	// Frontend.scala:62:26, :84:57, :98:19, :156:27, :167:28
    .io_s1_paddr                    (_tlb_io_resp_paddr),	// Frontend.scala:98:19
    .io_s1_kill                     (io_cpu_req_valid | s2_replay),	// Frontend.scala:127:48, :160:56
    .io_s2_kill                     (_icache_io_s2_kill_T_2),	// Frontend.scala:162:71
    .io_invalidate                  (io_cpu_flush_icache),
    .auto_master_out_a_valid        (auto_icache_master_out_a_valid),
    .auto_master_out_a_bits_address (auto_icache_master_out_a_bits_address),
    .io_resp_valid                  (_icache_io_resp_valid),
    .io_resp_bits_data              (_icache_io_resp_bits_data),
    .io_resp_bits_replay            (_icache_io_resp_bits_replay),
    .io_resp_bits_ae                (_icache_io_resp_bits_ae)
  );
  ShiftQueue_2 fq (	// Frontend.scala:84:57
    .clock                    (gated_clock),
    .reset                    (reset | io_cpu_req_valid),	// Frontend.scala:84:28
    .io_enq_valid             (_fq_io_enq_valid_T_4),	// Frontend.scala:165:52
    .io_enq_bits_btb_bridx    (1'h0),	// Frontend.scala:62:26, :84:57, :98:19
    .io_enq_bits_pc           (s2_pc),	// Frontend.scala:110:22
    .io_enq_bits_data         (_icache_io_resp_bits_data),	// Frontend.scala:62:26
    .io_enq_bits_xcpt_pf_inst (s2_tlb_resp_pf_inst),	// Frontend.scala:114:24
    .io_enq_bits_xcpt_ae_inst
      (_icache_io_resp_valid & _icache_io_resp_bits_ae | s2_tlb_resp_ae_inst),	// Frontend.scala:62:26, :114:24, :174:23, :176:{30,57,87}
    .io_enq_bits_replay
      (_icache_io_resp_bits_replay | _icache_io_s2_kill_T_2 & ~_icache_io_resp_valid
       & ~s2_xcpt),	// Frontend.scala:62:26, :115:37, :162:71, :171:{55,79,101,104}
    .io_deq_ready             (io_cpu_resp_ready),
    .io_enq_ready             (_fq_io_enq_ready),
    .io_deq_valid             (io_cpu_resp_valid),
    .io_deq_bits_btb_taken    (io_cpu_resp_bits_btb_taken),
    .io_deq_bits_btb_bridx    (io_cpu_resp_bits_btb_bridx),
    .io_deq_bits_pc           (io_cpu_resp_bits_pc),
    .io_deq_bits_data         (io_cpu_resp_bits_data),
    .io_deq_bits_xcpt_pf_inst (io_cpu_resp_bits_xcpt_pf_inst),
    .io_deq_bits_xcpt_ae_inst (io_cpu_resp_bits_xcpt_ae_inst),
    .io_deq_bits_replay       (io_cpu_resp_bits_replay),
    .io_mask                  (_fq_io_mask)
  );
  TLB_5 tlb (	// Frontend.scala:98:19
    .io_req_bits_vaddr         (s1_pc),	// Frontend.scala:108:18
    .io_ptw_status_debug       (io_ptw_status_debug),
    .io_ptw_status_prv         (io_ptw_status_prv),
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
    .io_kill                   (~s2_valid),	// Frontend.scala:101:25, :104:58
    .io_resp_paddr             (_tlb_io_resp_paddr),
    .io_resp_pf_inst           (_tlb_io_resp_pf_inst),
    .io_resp_ae_inst           (_tlb_io_resp_ae_inst),
    .io_resp_cacheable         (_tlb_io_resp_cacheable),
    .io_ptw_req_valid          (io_ptw_req_valid),
    .io_ptw_req_bits_valid     (io_ptw_req_bits_valid),
    .io_ptw_req_bits_bits_addr (io_ptw_req_bits_bits_addr)
  );
endmodule

