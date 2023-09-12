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

module CSRFile_2(
  input         clock,
                reset,
                io_ungated_clock,
                io_interrupts_debug,
                io_interrupts_mtip,
                io_interrupts_msip,
                io_interrupts_meip,
  input  [2:0]  io_hartid,
  input  [11:0] io_rw_addr,
  input  [2:0]  io_rw_cmd,
  input  [63:0] io_rw_wdata,
  input  [11:0] io_decode_0_csr,
  input         io_exception,
                io_retire,
  input  [63:0] io_cause,
  input  [33:0] io_pc,
                io_tval,
  input  [31:0] io_inst_0,
  output [63:0] io_rw_rdata,
  output        io_decode_0_read_illegal,
                io_decode_0_write_illegal,
                io_decode_0_write_flush,
                io_decode_0_system_illegal,
                io_csr_stall,
                io_eret,
                io_singleStep,
                io_status_debug,
                io_status_wfi,
  output [31:0] io_status_isa,
  output [1:0]  io_status_dprv,
  output [33:0] io_evec,
  output [63:0] io_time,
  output        io_interrupt,
  output [63:0] io_interrupt_cause,
  output        io_bp_0_control_action,
                io_bp_0_control_chain,
  output [1:0]  io_bp_0_control_tmatch,
  output        io_bp_0_control_x,
                io_bp_0_control_w,
                io_bp_0_control_r,
  output [32:0] io_bp_0_address,
  output        io_pmp_0_cfg_l,
  output [1:0]  io_pmp_0_cfg_a,
  output        io_pmp_0_cfg_x,
                io_pmp_0_cfg_w,
                io_pmp_0_cfg_r,
  output [29:0] io_pmp_0_addr,
  output [31:0] io_pmp_0_mask,
  output        io_pmp_1_cfg_l,
  output [1:0]  io_pmp_1_cfg_a,
  output        io_pmp_1_cfg_x,
                io_pmp_1_cfg_w,
                io_pmp_1_cfg_r,
  output [29:0] io_pmp_1_addr,
  output [31:0] io_pmp_1_mask,
  output        io_pmp_2_cfg_l,
  output [1:0]  io_pmp_2_cfg_a,
  output        io_pmp_2_cfg_x,
                io_pmp_2_cfg_w,
                io_pmp_2_cfg_r,
  output [29:0] io_pmp_2_addr,
  output [31:0] io_pmp_2_mask,
  output        io_pmp_3_cfg_l,
  output [1:0]  io_pmp_3_cfg_a,
  output        io_pmp_3_cfg_x,
                io_pmp_3_cfg_w,
                io_pmp_3_cfg_r,
  output [29:0] io_pmp_3_addr,
  output [31:0] io_pmp_3_mask,
  output        io_pmp_4_cfg_l,
  output [1:0]  io_pmp_4_cfg_a,
  output        io_pmp_4_cfg_x,
                io_pmp_4_cfg_w,
                io_pmp_4_cfg_r,
  output [29:0] io_pmp_4_addr,
  output [31:0] io_pmp_4_mask,
  output        io_pmp_5_cfg_l,
  output [1:0]  io_pmp_5_cfg_a,
  output        io_pmp_5_cfg_x,
                io_pmp_5_cfg_w,
                io_pmp_5_cfg_r,
  output [29:0] io_pmp_5_addr,
  output [31:0] io_pmp_5_mask,
  output        io_pmp_6_cfg_l,
  output [1:0]  io_pmp_6_cfg_a,
  output        io_pmp_6_cfg_x,
                io_pmp_6_cfg_w,
                io_pmp_6_cfg_r,
  output [29:0] io_pmp_6_addr,
  output [31:0] io_pmp_6_mask,
  output        io_pmp_7_cfg_l,
  output [1:0]  io_pmp_7_cfg_a,
  output        io_pmp_7_cfg_x,
                io_pmp_7_cfg_w,
                io_pmp_7_cfg_r,
  output [29:0] io_pmp_7_addr,
  output [31:0] io_pmp_7_mask,
  output        io_inhibit_cycle,
                io_trace_0_valid,
  output [33:0] io_trace_0_iaddr,
  output [31:0] io_trace_0_insn,
  output        io_trace_0_exception,
  output [63:0] io_customCSRs_0_value
);

  wire [63:0] _io_rw_rdata_WIRE;	// Mux.scala:27:72
  reg         io_status_cease_r;	// Reg.scala:27:20
  wire        _io_singleStep_output;	// CSR.scala:727:34
  reg  [1:0]  reg_mstatus_mpp;	// CSR.scala:319:24
  reg         reg_mstatus_mpie;	// CSR.scala:319:24
  reg         reg_mstatus_mie;	// CSR.scala:319:24
  reg         reg_dcsr_ebreakm;	// CSR.scala:327:21
  reg  [2:0]  reg_dcsr_cause;	// CSR.scala:327:21
  reg         reg_dcsr_step;	// CSR.scala:327:21
  reg         reg_debug;	// CSR.scala:368:22
  reg  [33:0] reg_dpc;	// CSR.scala:369:20
  reg  [63:0] reg_dscratch;	// CSR.scala:370:25
  reg         reg_singleStepped;	// CSR.scala:372:30
  reg         reg_bp_0_control_dmode;	// CSR.scala:378:19
  reg         reg_bp_0_control_action;	// CSR.scala:378:19
  reg         reg_bp_0_control_chain;	// CSR.scala:378:19
  reg  [1:0]  reg_bp_0_control_tmatch;	// CSR.scala:378:19
  reg         reg_bp_0_control_x;	// CSR.scala:378:19
  reg         reg_bp_0_control_w;	// CSR.scala:378:19
  reg         reg_bp_0_control_r;	// CSR.scala:378:19
  reg  [32:0] reg_bp_0_address;	// CSR.scala:378:19
  reg         reg_pmp_0_cfg_l;	// CSR.scala:379:20
  reg  [1:0]  reg_pmp_0_cfg_a;	// CSR.scala:379:20
  reg         reg_pmp_0_cfg_x;	// CSR.scala:379:20
  reg         reg_pmp_0_cfg_w;	// CSR.scala:379:20
  reg         reg_pmp_0_cfg_r;	// CSR.scala:379:20
  reg  [29:0] reg_pmp_0_addr;	// CSR.scala:379:20
  reg         reg_pmp_1_cfg_l;	// CSR.scala:379:20
  reg  [1:0]  reg_pmp_1_cfg_a;	// CSR.scala:379:20
  reg         reg_pmp_1_cfg_x;	// CSR.scala:379:20
  reg         reg_pmp_1_cfg_w;	// CSR.scala:379:20
  reg         reg_pmp_1_cfg_r;	// CSR.scala:379:20
  reg  [29:0] reg_pmp_1_addr;	// CSR.scala:379:20
  reg         reg_pmp_2_cfg_l;	// CSR.scala:379:20
  reg  [1:0]  reg_pmp_2_cfg_a;	// CSR.scala:379:20
  reg         reg_pmp_2_cfg_x;	// CSR.scala:379:20
  reg         reg_pmp_2_cfg_w;	// CSR.scala:379:20
  reg         reg_pmp_2_cfg_r;	// CSR.scala:379:20
  reg  [29:0] reg_pmp_2_addr;	// CSR.scala:379:20
  reg         reg_pmp_3_cfg_l;	// CSR.scala:379:20
  reg  [1:0]  reg_pmp_3_cfg_a;	// CSR.scala:379:20
  reg         reg_pmp_3_cfg_x;	// CSR.scala:379:20
  reg         reg_pmp_3_cfg_w;	// CSR.scala:379:20
  reg         reg_pmp_3_cfg_r;	// CSR.scala:379:20
  reg  [29:0] reg_pmp_3_addr;	// CSR.scala:379:20
  reg         reg_pmp_4_cfg_l;	// CSR.scala:379:20
  reg  [1:0]  reg_pmp_4_cfg_a;	// CSR.scala:379:20
  reg         reg_pmp_4_cfg_x;	// CSR.scala:379:20
  reg         reg_pmp_4_cfg_w;	// CSR.scala:379:20
  reg         reg_pmp_4_cfg_r;	// CSR.scala:379:20
  reg  [29:0] reg_pmp_4_addr;	// CSR.scala:379:20
  reg         reg_pmp_5_cfg_l;	// CSR.scala:379:20
  reg  [1:0]  reg_pmp_5_cfg_a;	// CSR.scala:379:20
  reg         reg_pmp_5_cfg_x;	// CSR.scala:379:20
  reg         reg_pmp_5_cfg_w;	// CSR.scala:379:20
  reg         reg_pmp_5_cfg_r;	// CSR.scala:379:20
  reg  [29:0] reg_pmp_5_addr;	// CSR.scala:379:20
  reg         reg_pmp_6_cfg_l;	// CSR.scala:379:20
  reg  [1:0]  reg_pmp_6_cfg_a;	// CSR.scala:379:20
  reg         reg_pmp_6_cfg_x;	// CSR.scala:379:20
  reg         reg_pmp_6_cfg_w;	// CSR.scala:379:20
  reg         reg_pmp_6_cfg_r;	// CSR.scala:379:20
  reg  [29:0] reg_pmp_6_addr;	// CSR.scala:379:20
  reg         reg_pmp_7_cfg_l;	// CSR.scala:379:20
  reg  [1:0]  reg_pmp_7_cfg_a;	// CSR.scala:379:20
  reg         reg_pmp_7_cfg_x;	// CSR.scala:379:20
  reg         reg_pmp_7_cfg_w;	// CSR.scala:379:20
  reg         reg_pmp_7_cfg_r;	// CSR.scala:379:20
  reg  [29:0] reg_pmp_7_addr;	// CSR.scala:379:20
  reg  [63:0] reg_mie;	// CSR.scala:381:20
  reg  [33:0] reg_mepc;	// CSR.scala:391:21
  reg  [63:0] reg_mcause;	// CSR.scala:392:27
  reg  [33:0] reg_mtval;	// CSR.scala:393:22
  reg  [63:0] reg_mscratch;	// CSR.scala:394:25
  reg  [31:0] reg_mtvec;	// CSR.scala:397:27
  reg         reg_wfi;	// CSR.scala:427:50
  reg  [2:0]  reg_mcountinhibit;	// CSR.scala:436:34
  reg  [5:0]  value_lo;	// Counters.scala:45:37
  reg  [57:0] value_hi;	// Counters.scala:50:27
  reg  [5:0]  value_lo_1;	// Counters.scala:45:37
  reg  [57:0] value_hi_1;	// Counters.scala:50:27
  wire [63:0] value_1 = {value_hi_1, value_lo_1};	// Cat.scala:30:58, Counters.scala:45:37, :50:27
  wire [15:0] read_mip =
    {4'h0, io_interrupts_meip, 3'h0, io_interrupts_mtip, 3'h0, io_interrupts_msip, 3'h0};	// CSR.scala:324:49, :454:22, :491:38
  wire [15:0] _GEN = reg_mie[15:0] & read_mip;	// CSR.scala:381:20, :454:22, :457:56
  wire [15:0] m_interrupts = reg_mstatus_mie ? _GEN : 16'h0;	// CSR.scala:319:24, :457:56, :464:25, Mux.scala:27:72
  wire [29:0] _GEN_0 = {reg_pmp_0_addr[28:0], reg_pmp_0_cfg_a[0]};	// CSR.scala:379:20, PMP.scala:59:31, :60:23
  wire [29:0] _GEN_1 = {reg_pmp_1_addr[28:0], reg_pmp_1_cfg_a[0]};	// CSR.scala:379:20, PMP.scala:59:31, :60:23
  wire [29:0] _GEN_2 = {reg_pmp_2_addr[28:0], reg_pmp_2_cfg_a[0]};	// CSR.scala:379:20, PMP.scala:59:31, :60:23
  wire [29:0] _GEN_3 = {reg_pmp_3_addr[28:0], reg_pmp_3_cfg_a[0]};	// CSR.scala:379:20, PMP.scala:59:31, :60:23
  wire [29:0] _GEN_4 = {reg_pmp_4_addr[28:0], reg_pmp_4_cfg_a[0]};	// CSR.scala:379:20, PMP.scala:59:31, :60:23
  wire [29:0] _GEN_5 = {reg_pmp_5_addr[28:0], reg_pmp_5_cfg_a[0]};	// CSR.scala:379:20, PMP.scala:59:31, :60:23
  wire [29:0] _GEN_6 = {reg_pmp_6_addr[28:0], reg_pmp_6_cfg_a[0]};	// CSR.scala:379:20, PMP.scala:59:31, :60:23
  wire [29:0] _GEN_7 = {reg_pmp_7_addr[28:0], reg_pmp_7_cfg_a[0]};	// CSR.scala:379:20, PMP.scala:59:31, :60:23
  reg  [63:0] reg_misa;	// CSR.scala:490:21
  wire [31:0] read_mtvec_lo = reg_mtvec & {24'hFFFFFF, ~(reg_mtvec[0] ? 8'hFE : 8'h2)};	// CSR.scala:315:55, :397:27, :1206:{39,41}, package.scala:165:{35,37,41}
  wire [33:0] _io_evec_T_15 = ~reg_mepc;	// CSR.scala:391:21, :1205:28
  wire [1:0]  _GEN_8 = {~(reg_misa[2]), 1'h1};	// CSR.scala:325:24, :490:21, :1205:{36,45}
  wire [33:0] lo_4 = ~{_io_evec_T_15[33:2], _io_evec_T_15[1:0] | _GEN_8};	// CSR.scala:1205:{26,28,31,36}
  wire [33:0] _io_evec_T_5 = ~reg_dpc;	// CSR.scala:369:20, :1205:28
  wire [33:0] lo_6 = ~{_io_evec_T_5[33:2], _io_evec_T_5[1:0] | _GEN_8};	// CSR.scala:1205:{26,28,31,36}
  reg  [63:0] reg_custom_0;	// CSR.scala:628:43
  wire        _GEN_9 = io_rw_addr == 12'h7A1;	// CSR.scala:636:73
  wire        _GEN_10 = io_rw_addr == 12'h7A2;	// CSR.scala:636:73
  wire        _GEN_11 = io_rw_addr == 12'h301;	// CSR.scala:636:73
  wire        _GEN_12 = io_rw_addr == 12'h300;	// CSR.scala:636:73
  wire        _GEN_13 = io_rw_addr == 12'h305;	// CSR.scala:636:73
  wire        _GEN_14 = io_rw_addr == 12'h304;	// CSR.scala:636:73
  wire        _GEN_15 = io_rw_addr == 12'h340;	// CSR.scala:636:73
  wire        _GEN_16 = io_rw_addr == 12'h341;	// CSR.scala:636:73
  wire        _GEN_17 = io_rw_addr == 12'h343;	// CSR.scala:636:73
  wire        _GEN_18 = io_rw_addr == 12'h342;	// CSR.scala:636:73
  wire        _GEN_19 = io_rw_addr == 12'h7B0;	// CSR.scala:636:73
  wire        _GEN_20 = io_rw_addr == 12'h7B1;	// CSR.scala:636:73
  wire        _GEN_21 = io_rw_addr == 12'h7B2;	// CSR.scala:636:73
  wire        _GEN_22 = io_rw_addr == 12'h320;	// CSR.scala:636:73
  wire        _GEN_23 = io_rw_addr == 12'hB00;	// CSR.scala:636:73
  wire        _GEN_24 = io_rw_addr == 12'hB02;	// CSR.scala:636:73
  wire        _GEN_25 = io_rw_addr == 12'h3A0;	// CSR.scala:636:73
  wire        _GEN_26 = io_rw_addr == 12'h3B0;	// CSR.scala:636:73
  wire        _GEN_27 = io_rw_addr == 12'h3B1;	// CSR.scala:636:73
  wire        _GEN_28 = io_rw_addr == 12'h3B2;	// CSR.scala:636:73
  wire        _GEN_29 = io_rw_addr == 12'h3B3;	// CSR.scala:636:73
  wire        _GEN_30 = io_rw_addr == 12'h3B4;	// CSR.scala:636:73
  wire        _GEN_31 = io_rw_addr == 12'h3B5;	// CSR.scala:636:73
  wire        _GEN_32 = io_rw_addr == 12'h3B6;	// CSR.scala:636:73
  wire        _GEN_33 = io_rw_addr == 12'h3B7;	// CSR.scala:636:73
  wire        _GEN_34 = io_rw_addr == 12'h7C1;	// CSR.scala:636:73
  wire [63:0] _wdata_T_2 = (io_rw_cmd[1] ? _io_rw_rdata_WIRE : 64'h0) | io_rw_wdata;	// CSR.scala:392:27, :1183:{9,13,34}, Mux.scala:27:72
  wire [63:0] _wdata_T_6 = ~((&(io_rw_cmd[1:0])) ? io_rw_wdata : 64'h0);	// CSR.scala:392:27, :1183:{45,49,53,59}
  wire        system_insn = io_rw_cmd == 3'h4;	// CSR.scala:639:31, Mux.scala:47:69
  wire        insn_call = system_insn & {io_rw_addr[9], io_rw_addr[0]} == 2'h0;	// CSR.scala:639:31, :652:{28,95}, Decode.scala:14:121
  wire        insn_break = system_insn & {io_rw_addr[8], io_rw_addr[0]} == 2'h1;	// CSR.scala:639:31, :652:{28,95}, :859:21, Decode.scala:14:121
  wire        insn_ret = system_insn & {io_rw_addr[9], io_rw_addr[2]} == 2'h2;	// CSR.scala:639:31, :652:{28,95}, :1206:39, Decode.scala:14:121
  wire [63:0] cause = insn_call ? 64'hB : insn_break ? 64'h3 : io_cause;	// CSR.scala:652:95, :688:8, :689:14
  wire        _causeIsDebugTrigger_T_2 = cause[7:0] == 8'hE;	// CSR.scala:688:8, :690:25, :691:53
  wire        causeIsDebugInt = cause[63] & _causeIsDebugTrigger_T_2;	// CSR.scala:688:8, :691:{30,39,53}
  wire        causeIsDebugTrigger = ~(cause[63]) & _causeIsDebugTrigger_T_2;	// CSR.scala:688:8, :691:{30,53}, :692:{29,44}
  wire        trapToDebug =
    reg_singleStepped | causeIsDebugInt | causeIsDebugTrigger | ~(cause[63]) & insn_break
    & reg_dcsr_ebreakm | reg_debug;	// CSR.scala:327:21, :368:22, :372:30, :652:95, :688:8, :691:{30,39}, :692:44, :693:{27,56}, :694:123
  wire        _exception_T = insn_call | insn_break;	// CSR.scala:652:95, :726:24
  assign _io_singleStep_output = reg_dcsr_step & ~reg_debug;	// CSR.scala:327:21, :368:22, :675:45, :727:34
  reg  [1:0]  io_status_dprv_REG;	// CSR.scala:734:24
  wire        _io_trace_0_exception_output = _exception_T | io_exception;	// CSR.scala:726:24, :738:43
  `ifndef SYNTHESIS	// CSR.scala:739:9
    always @(posedge clock) begin	// CSR.scala:739:9
      if (~({1'h0, {1'h0, insn_ret} + {1'h0, insn_call}}
            + {1'h0, {1'h0, insn_break} + {1'h0, io_exception}} < 3'h2 | reset)) begin	// Bitwise.scala:47:55, CSR.scala:652:95, :677:21, :729:74, :739:{9,79}
        if (`ASSERT_VERBOSE_COND_)	// CSR.scala:739:9
          $error("Assertion failed: these conditions must be mutually exclusive\n    at CSR.scala:739 assert(PopCount(insn_ret :: insn_call :: insn_break :: io.exception :: Nil) <= 1, \"these conditions must be mutually exclusive\")\n");	// CSR.scala:739:9
        if (`STOP_COND_)	// CSR.scala:739:9
          $fatal;	// CSR.scala:739:9
      end
      if (~(~reg_singleStepped | ~io_retire | reset)) begin	// CSR.scala:372:30, :748:{9,10,42}
        if (`ASSERT_VERBOSE_COND_)	// CSR.scala:748:9
          $error("Assertion failed\n    at CSR.scala:748 assert(!reg_singleStepped || io.retire === UInt(0))\n");	// CSR.scala:748:9
        if (`STOP_COND_)	// CSR.scala:748:9
          $fatal;	// CSR.scala:748:9
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  wire        _GEN_35 = io_rw_addr[10] & io_rw_addr[7];	// CSR.scala:821:{47,52,65}
  wire        _io_csr_stall_output = reg_wfi | io_status_cease_r;	// CSR.scala:427:50, :845:27, Reg.scala:27:20
  wire [63:0] _io_rw_rdata_T_105 =
    (_GEN_9
       ? {4'h2,
          reg_bp_0_control_dmode,
          46'h40000000000,
          reg_bp_0_control_action,
          reg_bp_0_control_chain,
          2'h0,
          reg_bp_0_control_tmatch,
          4'h8,
          reg_bp_0_control_x,
          reg_bp_0_control_w,
          reg_bp_0_control_r}
       : 64'h0) | (_GEN_10 ? {{31{reg_bp_0_address[32]}}, reg_bp_0_address} : 64'h0)
    | (_GEN_11 ? reg_misa : 64'h0)
    | (_GEN_12
         ? {51'h0, reg_mstatus_mpp, 3'h0, reg_mstatus_mpie, 3'h0, reg_mstatus_mie, 3'h0}
         : 64'h0) | (_GEN_13 ? {32'h0, read_mtvec_lo} : 64'h0);	// Bitwise.scala:72:12, CSR.scala:315:55, :319:24, :324:49, :378:19, :392:27, :490:21, :491:40, :497:48, :636:73, :1058:67, :1132:15, Cat.scala:30:58, Mux.scala:27:72, :47:69, package.scala:123:38, :165:35
  wire [63:0] _io_rw_rdata_T_111 =
    {_io_rw_rdata_T_105[63:16],
     _io_rw_rdata_T_105[15:0] | (io_rw_addr == 12'h344 ? read_mip : 16'h0)}
    | (_GEN_14 ? reg_mie : 64'h0) | (_GEN_15 ? reg_mscratch : 64'h0)
    | (_GEN_16 ? {{30{lo_4[33]}}, lo_4} : 64'h0)
    | (_GEN_17 ? {{30{reg_mtval[33]}}, reg_mtval} : 64'h0)
    | (_GEN_18 ? reg_mcause : 64'h0);	// Bitwise.scala:72:12, CSR.scala:381:20, :392:27, :393:22, :394:25, :454:22, :636:73, :1205:26, Cat.scala:30:58, Mux.scala:27:72, package.scala:123:38
  wire [63:0] _io_rw_rdata_T_115 =
    {_io_rw_rdata_T_111[63:32],
     {_io_rw_rdata_T_111[31:3],
      _io_rw_rdata_T_111[2:0] | (io_rw_addr == 12'hF14 ? io_hartid : 3'h0)}
       | (_GEN_19
            ? {16'h4000,
               reg_dcsr_ebreakm,
               6'h0,
               reg_dcsr_cause,
               3'h0,
               reg_dcsr_step,
               2'h3}
            : 32'h0)} | (_GEN_20 ? {{30{lo_6[33]}}, lo_6} : 64'h0)
    | (_GEN_21 ? reg_dscratch : 64'h0);	// Bitwise.scala:72:12, CSR.scala:315:55, :316:21, :324:49, :327:21, :370:25, :392:27, :512:27, :636:73, :1205:26, Cat.scala:30:58, Counters.scala:45:37, Mux.scala:27:72, package.scala:123:38
  wire [63:0] _io_rw_rdata_T_178 =
    {_io_rw_rdata_T_115[63:3],
     _io_rw_rdata_T_115[2:0] | (_GEN_22 ? reg_mcountinhibit : 3'h0)}
    | (_GEN_23 ? value_1 : 64'h0) | (_GEN_24 ? {value_hi, value_lo} : 64'h0)
    | (_GEN_25
         ? {reg_pmp_7_cfg_l,
            2'h0,
            reg_pmp_7_cfg_a,
            reg_pmp_7_cfg_x,
            reg_pmp_7_cfg_w,
            reg_pmp_7_cfg_r,
            reg_pmp_6_cfg_l,
            2'h0,
            reg_pmp_6_cfg_a,
            reg_pmp_6_cfg_x,
            reg_pmp_6_cfg_w,
            reg_pmp_6_cfg_r,
            reg_pmp_5_cfg_l,
            2'h0,
            reg_pmp_5_cfg_a,
            reg_pmp_5_cfg_x,
            reg_pmp_5_cfg_w,
            reg_pmp_5_cfg_r,
            reg_pmp_4_cfg_l,
            2'h0,
            reg_pmp_4_cfg_a,
            reg_pmp_4_cfg_x,
            reg_pmp_4_cfg_w,
            reg_pmp_4_cfg_r,
            reg_pmp_3_cfg_l,
            2'h0,
            reg_pmp_3_cfg_a,
            reg_pmp_3_cfg_x,
            reg_pmp_3_cfg_w,
            reg_pmp_3_cfg_r,
            reg_pmp_2_cfg_l,
            2'h0,
            reg_pmp_2_cfg_a,
            reg_pmp_2_cfg_x,
            reg_pmp_2_cfg_w,
            reg_pmp_2_cfg_r,
            reg_pmp_1_cfg_l,
            2'h0,
            reg_pmp_1_cfg_a,
            reg_pmp_1_cfg_x,
            reg_pmp_1_cfg_w,
            reg_pmp_1_cfg_r,
            reg_pmp_0_cfg_l,
            2'h0,
            reg_pmp_0_cfg_a,
            reg_pmp_0_cfg_x,
            reg_pmp_0_cfg_w,
            reg_pmp_0_cfg_r}
         : 64'h0);	// CSR.scala:324:49, :379:20, :392:27, :436:34, :636:73, Cat.scala:30:58, Counters.scala:45:37, :50:27, Mux.scala:27:72
  wire [29:0] _GEN_36 =
    _io_rw_rdata_T_178[29:0] | (_GEN_26 ? reg_pmp_0_addr : 30'h0)
    | (_GEN_27 ? reg_pmp_1_addr : 30'h0) | (_GEN_28 ? reg_pmp_2_addr : 30'h0)
    | (_GEN_29 ? reg_pmp_3_addr : 30'h0) | (_GEN_30 ? reg_pmp_4_addr : 30'h0)
    | (_GEN_31 ? reg_pmp_5_addr : 30'h0) | (_GEN_32 ? reg_pmp_6_addr : 30'h0)
    | (_GEN_33 ? reg_pmp_7_addr : 30'h0);	// Bitwise.scala:72:12, CSR.scala:379:20, :636:73, Mux.scala:27:72
  assign _io_rw_rdata_WIRE =
    (_GEN_34 ? reg_custom_0 : 64'h0)
    | {_io_rw_rdata_T_178[63:30], _GEN_36[29:1], _GEN_36[0] | io_rw_addr == 12'hF12}
    | (io_rw_addr == 12'hF13 ? 64'h20181004 : 64'h0);	// CSR.scala:392:27, :628:43, :636:73, Mux.scala:27:72
  wire        csr_wen = io_rw_cmd == 3'h6 | (&io_rw_cmd) | io_rw_cmd == 3'h5;	// CSR.scala:794:118, Mux.scala:47:69, package.scala:15:47, :72:59
  wire [5:0]  _GEN_37 = _wdata_T_2[5:0] & _wdata_T_6[5:0];	// CSR.scala:1183:{34,43,45}, Counters.scala:65:11
  always @(posedge clock) begin
    automatic logic [63:0] _reg_bp_0_control_WIRE_1;	// CSR.scala:1183:43
    automatic logic [33:0] epc;	// CSR.scala:1204:31
    automatic logic        _GEN_38;	// CSR.scala:368:22, :754:20, :755:24, :756:25, :757:19
    automatic logic        _GEN_39;	// CSR.scala:391:21, :754:20, :755:24
    automatic logic [33:0] _GEN_40;	// CSR.scala:945:51
    automatic logic        _GEN_41;	// CSR.scala:1039:55
    automatic logic        _GEN_42;	// CSR.scala:378:19, :897:18, :1039:70, :1051:44, :1052:24
    automatic logic [7:0]  _newCfg_WIRE;	// CSR.scala:1183:43
    automatic logic        _GEN_43;	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
    automatic logic [29:0] _GEN_44;	// CSR.scala:1081:18, :1183:43
    automatic logic [7:0]  _newCfg_WIRE_1;	// CSR.scala:1072:53, :1183:43
    automatic logic        _GEN_45;	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
    automatic logic [7:0]  _newCfg_WIRE_2;	// CSR.scala:1072:53, :1183:43
    automatic logic        _GEN_46;	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
    automatic logic [7:0]  _newCfg_WIRE_3;	// CSR.scala:1072:53, :1183:43
    automatic logic        _GEN_47;	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
    automatic logic [7:0]  _newCfg_WIRE_4;	// CSR.scala:1072:53, :1183:43
    automatic logic        _GEN_48;	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
    automatic logic [7:0]  _newCfg_WIRE_5;	// CSR.scala:1072:53, :1183:43
    automatic logic        _GEN_49;	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
    automatic logic [7:0]  _newCfg_WIRE_6;	// CSR.scala:1072:53, :1183:43
    automatic logic        _GEN_50;	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
    automatic logic        _GEN_51;	// PMP.scala:51:62
    automatic logic [7:0]  _newCfg_WIRE_7;	// CSR.scala:1072:53, :1183:43
    automatic logic        _GEN_52;	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
    _reg_bp_0_control_WIRE_1 = _wdata_T_2 & _wdata_T_6;	// CSR.scala:1183:{34,43,45}
    epc = {io_pc[33:1], 1'h0};	// CSR.scala:677:21, :729:74, :1204:31
    _GEN_38 = _io_trace_0_exception_output & trapToDebug & ~reg_debug;	// CSR.scala:368:22, :675:45, :694:123, :738:43, :754:20, :755:24, :756:25, :757:19
    _GEN_39 = ~_io_trace_0_exception_output | trapToDebug;	// CSR.scala:391:21, :694:123, :738:43, :754:20, :755:24
    _GEN_40 = {_reg_bp_0_control_WIRE_1[33:1], 1'h0};	// CSR.scala:677:21, :729:74, :945:51, :1183:43
    _GEN_41 = ~reg_bp_0_control_dmode | reg_debug;	// CSR.scala:368:22, :378:19, :1039:{37,55}
    _GEN_42 = csr_wen & _GEN_41 & _GEN_9;	// CSR.scala:378:19, :636:73, :897:18, :1039:{55,70}, :1051:44, :1052:24, package.scala:72:59
    _newCfg_WIRE = _wdata_T_2[7:0] & _wdata_T_6[7:0];	// CSR.scala:1183:{34,43,45}
    _GEN_43 = csr_wen & _GEN_25 & ~reg_pmp_0_cfg_l;	// CSR.scala:379:20, :636:73, :897:18, :1071:{60,76}, :1073:17, package.scala:72:59
    _GEN_44 = _wdata_T_2[29:0] & _wdata_T_6[29:0];	// CSR.scala:1081:18, :1183:{34,43,45}
    _newCfg_WIRE_1 = _wdata_T_2[15:8] & _wdata_T_6[15:8];	// CSR.scala:1072:53, :1183:{34,43,45}
    _GEN_45 = csr_wen & _GEN_25 & ~reg_pmp_1_cfg_l;	// CSR.scala:379:20, :636:73, :897:18, :1071:{60,76}, :1073:17, package.scala:72:59
    _newCfg_WIRE_2 = _wdata_T_2[23:16] & _wdata_T_6[23:16];	// CSR.scala:1072:53, :1183:{34,43,45}
    _GEN_46 = csr_wen & _GEN_25 & ~reg_pmp_2_cfg_l;	// CSR.scala:379:20, :636:73, :897:18, :1071:{60,76}, :1073:17, package.scala:72:59
    _newCfg_WIRE_3 = _wdata_T_2[31:24] & _wdata_T_6[31:24];	// CSR.scala:1072:53, :1183:{34,43,45}
    _GEN_47 = csr_wen & _GEN_25 & ~reg_pmp_3_cfg_l;	// CSR.scala:379:20, :636:73, :897:18, :1071:{60,76}, :1073:17, package.scala:72:59
    _newCfg_WIRE_4 = _wdata_T_2[39:32] & _wdata_T_6[39:32];	// CSR.scala:1072:53, :1183:{34,43,45}
    _GEN_48 = csr_wen & _GEN_25 & ~reg_pmp_4_cfg_l;	// CSR.scala:379:20, :636:73, :897:18, :1071:{60,76}, :1073:17, package.scala:72:59
    _newCfg_WIRE_5 = _wdata_T_2[47:40] & _wdata_T_6[47:40];	// CSR.scala:1072:53, :1183:{34,43,45}
    _GEN_49 = csr_wen & _GEN_25 & ~reg_pmp_5_cfg_l;	// CSR.scala:379:20, :636:73, :897:18, :1071:{60,76}, :1073:17, package.scala:72:59
    _newCfg_WIRE_6 = _wdata_T_2[55:48] & _wdata_T_6[55:48];	// CSR.scala:1072:53, :1183:{34,43,45}
    _GEN_50 = csr_wen & _GEN_25 & ~reg_pmp_6_cfg_l;	// CSR.scala:379:20, :636:73, :897:18, :1071:{60,76}, :1073:17, package.scala:72:59
    _GEN_51 = reg_pmp_7_cfg_l & ~(reg_pmp_7_cfg_a[1]) & reg_pmp_7_cfg_a[0];	// CSR.scala:379:20, PMP.scala:47:20, :48:26, :49:13, :51:62
    _newCfg_WIRE_7 = _wdata_T_2[63:56] & _wdata_T_6[63:56];	// CSR.scala:1072:53, :1183:{34,43,45}
    _GEN_52 = csr_wen & _GEN_25 & ~reg_pmp_7_cfg_l;	// CSR.scala:379:20, :636:73, :897:18, :1071:{60,76}, :1073:17, package.scala:72:59
    if (reset) begin
      reg_mstatus_mpp <= 2'h3;	// CSR.scala:316:21, :319:24
      reg_mstatus_mpie <= 1'h0;	// CSR.scala:319:24, :677:21, :729:74
      reg_mstatus_mie <= 1'h0;	// CSR.scala:319:24, :677:21, :729:74
      reg_dcsr_ebreakm <= 1'h0;	// CSR.scala:327:21, :677:21, :729:74
      reg_dcsr_cause <= 3'h0;	// CSR.scala:324:49, :327:21
      reg_dcsr_step <= 1'h0;	// CSR.scala:327:21, :677:21, :729:74
      reg_debug <= 1'h0;	// CSR.scala:368:22, :677:21, :729:74
      reg_bp_0_control_dmode <= 1'h0;	// CSR.scala:378:19, :677:21, :729:74
      reg_bp_0_control_action <= 1'h0;	// CSR.scala:378:19, :677:21, :729:74
      reg_bp_0_control_x <= 1'h0;	// CSR.scala:378:19, :677:21, :729:74
      reg_bp_0_control_w <= 1'h0;	// CSR.scala:378:19, :677:21, :729:74
      reg_bp_0_control_r <= 1'h0;	// CSR.scala:378:19, :677:21, :729:74
      reg_pmp_0_cfg_l <= 1'h0;	// CSR.scala:379:20, :677:21, :729:74
      reg_pmp_0_cfg_a <= 2'h0;	// CSR.scala:379:20
      reg_pmp_1_cfg_l <= 1'h0;	// CSR.scala:379:20, :677:21, :729:74
      reg_pmp_1_cfg_a <= 2'h0;	// CSR.scala:379:20
      reg_pmp_2_cfg_l <= 1'h0;	// CSR.scala:379:20, :677:21, :729:74
      reg_pmp_2_cfg_a <= 2'h0;	// CSR.scala:379:20
      reg_pmp_3_cfg_l <= 1'h0;	// CSR.scala:379:20, :677:21, :729:74
      reg_pmp_3_cfg_a <= 2'h0;	// CSR.scala:379:20
      reg_pmp_4_cfg_l <= 1'h0;	// CSR.scala:379:20, :677:21, :729:74
      reg_pmp_4_cfg_a <= 2'h0;	// CSR.scala:379:20
      reg_pmp_5_cfg_l <= 1'h0;	// CSR.scala:379:20, :677:21, :729:74
      reg_pmp_5_cfg_a <= 2'h0;	// CSR.scala:379:20
      reg_pmp_6_cfg_l <= 1'h0;	// CSR.scala:379:20, :677:21, :729:74
      reg_pmp_6_cfg_a <= 2'h0;	// CSR.scala:379:20
      reg_pmp_7_cfg_l <= 1'h0;	// CSR.scala:379:20, :677:21, :729:74
      reg_pmp_7_cfg_a <= 2'h0;	// CSR.scala:379:20
      reg_mcause <= 64'h0;	// CSR.scala:392:27
      reg_mtvec <= 32'h0;	// CSR.scala:315:55, :397:27
      reg_mcountinhibit <= 3'h0;	// CSR.scala:324:49, :436:34
      value_lo <= 6'h0;	// Counters.scala:45:37
      value_hi <= 58'h0;	// Counters.scala:50:27
      reg_misa <= 64'h8000000000801105;	// CSR.scala:490:21
      reg_custom_0 <= 64'h208;	// CSR.scala:628:43
      io_status_cease_r <= 1'h0;	// CSR.scala:677:21, :729:74, Reg.scala:27:20
    end
    else begin
      automatic logic        _GEN_53;	// CSR.scala:754:20, :813:19, :815:52
      automatic logic [31:0] _new_dcsr_WIRE;	// CSR.scala:948:52, :1183:43
      _GEN_53 = ~insn_ret | _GEN_35;	// CSR.scala:652:95, :754:20, :813:19, :815:52, :821:52
      _new_dcsr_WIRE = _wdata_T_2[31:0] & _wdata_T_6[31:0];	// CSR.scala:948:52, :1183:{34,43,45}
      if (_GEN_53 & _GEN_39) begin	// CSR.scala:319:24, :391:21, :754:20, :755:24, :813:19, :815:52, :821:70, :825:69
      end
      else	// CSR.scala:319:24, :754:20, :755:24, :813:19, :815:52, :821:70, :825:69
        reg_mstatus_mpp <= 2'h3;	// CSR.scala:316:21, :319:24
      if (csr_wen & _GEN_12) begin	// CSR.scala:636:73, :813:19, :897:18, :898:39, :900:23, package.scala:72:59
        reg_mstatus_mpie <= _reg_bp_0_control_WIRE_1[7];	// CSR.scala:319:24, :899:47, :1183:43
        reg_mstatus_mie <= _reg_bp_0_control_WIRE_1[3];	// CSR.scala:319:24, :899:47, :1183:43
      end
      else begin	// CSR.scala:813:19, :897:18, :898:39, :900:23
        reg_mstatus_mpie <=
          insn_ret & ~_GEN_35 | (_GEN_39 ? reg_mstatus_mpie : reg_mstatus_mie);	// CSR.scala:319:24, :391:21, :652:95, :754:20, :755:24, :813:19, :815:52, :821:{52,70}, :825:69
        if (_GEN_53)	// CSR.scala:754:20, :813:19, :815:52
          reg_mstatus_mie <= _GEN_39 & reg_mstatus_mie;	// CSR.scala:319:24, :391:21, :754:20, :755:24
        else	// CSR.scala:754:20, :813:19, :815:52
          reg_mstatus_mie <= reg_mstatus_mpie;	// CSR.scala:319:24
      end
      if (csr_wen & _GEN_19) begin	// CSR.scala:327:21, :636:73, :897:18, :980:38, :982:23, package.scala:72:59
        reg_dcsr_ebreakm <= _new_dcsr_WIRE[15];	// CSR.scala:327:21, :948:52, :981:43, :1183:43
        reg_dcsr_step <= _new_dcsr_WIRE[2];	// CSR.scala:327:21, :948:52, :981:43, :1183:43
      end
      if (_GEN_38) begin	// CSR.scala:368:22, :754:20, :755:24, :756:25, :757:19
        if (reg_singleStepped)	// CSR.scala:372:30
          reg_dcsr_cause <= 3'h4;	// CSR.scala:327:21, Mux.scala:47:69
        else	// CSR.scala:372:30
          reg_dcsr_cause <=
            {1'h0, causeIsDebugInt ? 2'h3 : causeIsDebugTrigger ? 2'h2 : 2'h1};	// CSR.scala:316:21, :327:21, :677:21, :691:39, :692:44, :729:74, :759:{30,56,86}, :859:21, :1206:39
      end
      reg_debug <= ~(insn_ret & _GEN_35) & (_GEN_38 | reg_debug);	// CSR.scala:368:22, :652:95, :754:20, :755:24, :756:25, :757:19, :813:19, :815:52, :821:{52,70}, :823:17
      if (_GEN_42) begin	// CSR.scala:378:19, :897:18, :1039:70, :1051:44, :1052:24
        automatic logic [47:0] _newBPC_WIRE;	// CSR.scala:1183:43
        automatic logic        dMode;	// CSR.scala:1059:38
        _newBPC_WIRE =
          ((io_rw_cmd[1]
              ? {reg_bp_0_control_dmode, 46'h40000000000, reg_bp_0_control_action}
              : 48'h0) | io_rw_wdata[59:12])
          & ~((&(io_rw_cmd[1:0])) ? io_rw_wdata[59:12] : 48'h0);	// CSR.scala:378:19, :1058:67, :1183:{9,13,34,43,45,49,53,59}
        dMode = _newBPC_WIRE[47] & reg_debug;	// CSR.scala:368:22, :1058:96, :1059:38, :1183:43
        reg_bp_0_control_dmode <= dMode;	// CSR.scala:378:19, :1059:38
        reg_bp_0_control_action <= dMode & _newBPC_WIRE[0];	// CSR.scala:378:19, :1058:96, :1059:38, :1061:{51,71,120}, :1183:43
        reg_bp_0_control_x <= _reg_bp_0_control_WIRE_1[2];	// CSR.scala:378:19, :1052:41, :1183:43
        reg_bp_0_control_w <= _reg_bp_0_control_WIRE_1[1];	// CSR.scala:378:19, :1052:41, :1183:43
        reg_bp_0_control_r <= _reg_bp_0_control_WIRE_1[0];	// CSR.scala:378:19, :1052:41, :1183:43
      end
      if (_GEN_43) begin	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
        reg_pmp_0_cfg_l <= _newCfg_WIRE[7];	// CSR.scala:379:20, :1072:46, :1183:43
        reg_pmp_0_cfg_a <= _newCfg_WIRE[4:3];	// CSR.scala:379:20, :1072:46, :1183:43
      end
      if (_GEN_45) begin	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
        reg_pmp_1_cfg_l <= _newCfg_WIRE_1[7];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
        reg_pmp_1_cfg_a <= _newCfg_WIRE_1[4:3];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
      end
      if (_GEN_46) begin	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
        reg_pmp_2_cfg_l <= _newCfg_WIRE_2[7];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
        reg_pmp_2_cfg_a <= _newCfg_WIRE_2[4:3];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
      end
      if (_GEN_47) begin	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
        reg_pmp_3_cfg_l <= _newCfg_WIRE_3[7];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
        reg_pmp_3_cfg_a <= _newCfg_WIRE_3[4:3];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
      end
      if (_GEN_48) begin	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
        reg_pmp_4_cfg_l <= _newCfg_WIRE_4[7];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
        reg_pmp_4_cfg_a <= _newCfg_WIRE_4[4:3];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
      end
      if (_GEN_49) begin	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
        reg_pmp_5_cfg_l <= _newCfg_WIRE_5[7];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
        reg_pmp_5_cfg_a <= _newCfg_WIRE_5[4:3];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
      end
      if (_GEN_50) begin	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
        reg_pmp_6_cfg_l <= _newCfg_WIRE_6[7];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
        reg_pmp_6_cfg_a <= _newCfg_WIRE_6[4:3];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
      end
      if (_GEN_52) begin	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
        reg_pmp_7_cfg_l <= _newCfg_WIRE_7[7];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
        reg_pmp_7_cfg_a <= _newCfg_WIRE_7[4:3];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
      end
      if (csr_wen & _GEN_18)	// CSR.scala:636:73, :754:20, :897:18, :949:{40,53}, package.scala:72:59
        reg_mcause <= _reg_bp_0_control_WIRE_1 & 64'h800000000000000F;	// CSR.scala:392:27, :949:62, :1183:43
      else if (_GEN_39) begin	// CSR.scala:391:21, :392:27, :754:20, :755:24
      end
      else if (insn_call)	// CSR.scala:652:95
        reg_mcause <= 64'hB;	// CSR.scala:392:27, :688:8
      else if (insn_break)	// CSR.scala:652:95
        reg_mcause <= 64'h3;	// CSR.scala:392:27, :689:14
      else	// CSR.scala:652:95
        reg_mcause <= io_cause;	// CSR.scala:392:27
      if (csr_wen & _GEN_13)	// CSR.scala:397:27, :636:73, :897:18, :948:{40,52}, package.scala:72:59
        reg_mtvec <= _new_dcsr_WIRE;	// CSR.scala:397:27, :948:52, :1183:43
      if (csr_wen & _GEN_22)	// CSR.scala:436:34, :636:73, :897:18, :965:{47,67}, package.scala:72:59
        reg_mcountinhibit <= _wdata_T_2[2:0] & _wdata_T_6[2:0] & 3'h5;	// CSR.scala:436:34, :965:{67,76}, :1183:{34,43,45}, Mux.scala:47:69
      if (csr_wen & _GEN_24) begin	// CSR.scala:636:73, :897:18, :1201:31, Counters.scala:47:19, :65:11, package.scala:72:59
        value_lo <= _GEN_37;	// CSR.scala:1183:43, Counters.scala:45:37, :65:11
        value_hi <= _wdata_T_2[63:6] & _wdata_T_6[63:6];	// CSR.scala:1183:{34,43,45}, Counters.scala:50:27, :66:28
      end
      else begin	// CSR.scala:897:18, :1201:31, Counters.scala:47:19, :65:11
        automatic logic [6:0] nextSmall;	// Counters.scala:46:33
        nextSmall = {1'h0, value_lo} + {6'h0, io_retire};	// CSR.scala:677:21, :729:74, Counters.scala:45:37, :46:33
        if (reg_mcountinhibit[2]) begin	// CSR.scala:436:34, :438:75
        end
        else	// CSR.scala:438:75
          value_lo <= nextSmall[5:0];	// Counters.scala:45:37, :46:33, :47:27
        if (nextSmall[6] & ~(reg_mcountinhibit[2]))	// CSR.scala:436:34, :438:75, Counters.scala:46:33, :47:9, :51:{20,33}
          value_hi <= value_hi + 58'h1;	// Counters.scala:50:27, :51:55
      end
      if (csr_wen & _GEN_11 & (~(io_pc[1]) | _wdata_T_2[2] & _wdata_T_6[2])) begin	// CSR.scala:490:21, :636:73, :897:18, :923:36, :927:{33,39,43,51,64}, :929:20, :1183:{34,43,45}, package.scala:72:59
        automatic logic [63:0] _reg_misa_T;	// CSR.scala:929:25
        _reg_misa_T = ~_reg_bp_0_control_WIRE_1;	// CSR.scala:929:25, :1183:43
        reg_misa <=
          ~{_reg_misa_T[63:4],
            _reg_misa_T[3:0] | {~(_wdata_T_2[5] & _wdata_T_6[5]), 3'h0}} & 64'h1005
          | reg_misa & 64'hFFFFFFFFFFFFEFFA;	// CSR.scala:324:49, :490:21, :925:20, :929:{23,25,32,35,38,55,62,73,75}, :1183:{34,43,45}
      end
      if (csr_wen & _GEN_34)	// CSR.scala:628:43, :636:73, :897:18, :1086:35, :1087:13, package.scala:72:59
        reg_custom_0 <=
          _reg_bp_0_control_WIRE_1 & 64'h208 | reg_custom_0 & 64'hFFFFFFFFFFFFFDF7;	// CSR.scala:628:43, :1087:{23,31,38,40}, :1183:43
      io_status_cease_r <=
        system_insn & {io_rw_addr[9], io_rw_addr[1]} == 2'h2 | io_status_cease_r;	// CSR.scala:639:31, :652:{28,95}, :1206:39, Decode.scala:14:121, Reg.scala:27:20, :28:{19,23}
    end
    if (csr_wen & _GEN_20)	// CSR.scala:636:73, :754:20, :897:18, :988:{42,52}, package.scala:72:59
      reg_dpc <= _GEN_40;	// CSR.scala:369:20, :945:51
    else if (_GEN_38)	// CSR.scala:368:22, :754:20, :755:24, :756:25, :757:19
      reg_dpc <= epc;	// CSR.scala:369:20, :1204:31
    if (csr_wen & _GEN_21)	// CSR.scala:370:25, :636:73, :897:18, :989:{42,57}, package.scala:72:59
      reg_dscratch <= _reg_bp_0_control_WIRE_1;	// CSR.scala:370:25, :1183:43
    reg_singleStepped <=
      _io_singleStep_output
      & (io_retire | _io_trace_0_exception_output | reg_singleStepped);	// CSR.scala:372:30, :727:34, :738:43, :745:{36,56}, :746:{25,45}
    reg_bp_0_control_chain <= ~(reset | _GEN_42) & reg_bp_0_control_chain;	// CSR.scala:378:19, :897:18, :1039:70, :1051:44, :1052:24, :1062:30, :1140:18, :1143:17
    if (_GEN_42)	// CSR.scala:378:19, :897:18, :1039:70, :1051:44, :1052:24
      reg_bp_0_control_tmatch <= _reg_bp_0_control_WIRE_1[8:7];	// CSR.scala:378:19, :1052:41, :1183:43
    if (csr_wen & _GEN_41 & _GEN_10)	// CSR.scala:378:19, :636:73, :897:18, :1039:{55,70}, :1040:{44,57}, package.scala:72:59
      reg_bp_0_address <= _wdata_T_2[32:0] & _wdata_T_6[32:0];	// CSR.scala:378:19, :1040:57, :1183:{34,43,45}
    if (_GEN_43) begin	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
      reg_pmp_0_cfg_x <= _newCfg_WIRE[2];	// CSR.scala:379:20, :1072:46, :1183:43
      reg_pmp_0_cfg_w <= _newCfg_WIRE[1] & _newCfg_WIRE[0];	// CSR.scala:379:20, :1072:46, :1075:31, :1183:43
      reg_pmp_0_cfg_r <= _newCfg_WIRE[0];	// CSR.scala:379:20, :1072:46, :1183:43
    end
    if (csr_wen & _GEN_26
        & ~(reg_pmp_0_cfg_l | reg_pmp_1_cfg_l & ~(reg_pmp_1_cfg_a[1])
            & reg_pmp_1_cfg_a[0]))	// CSR.scala:379:20, :636:73, :897:18, :1080:{48,71}, :1081:18, PMP.scala:47:20, :48:26, :49:13, :51:{44,62}, package.scala:72:59
      reg_pmp_0_addr <= _GEN_44;	// CSR.scala:379:20, :1081:18, :1183:43
    if (_GEN_45) begin	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
      reg_pmp_1_cfg_x <= _newCfg_WIRE_1[2];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
      reg_pmp_1_cfg_w <= _newCfg_WIRE_1[1] & _newCfg_WIRE_1[0];	// CSR.scala:379:20, :1072:{46,53}, :1075:31, :1183:43
      reg_pmp_1_cfg_r <= _newCfg_WIRE_1[0];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
    end
    if (csr_wen & _GEN_27
        & ~(reg_pmp_1_cfg_l | reg_pmp_2_cfg_l & ~(reg_pmp_2_cfg_a[1])
            & reg_pmp_2_cfg_a[0]))	// CSR.scala:379:20, :636:73, :897:18, :1080:{48,71}, :1081:18, PMP.scala:47:20, :48:26, :49:13, :51:{44,62}, package.scala:72:59
      reg_pmp_1_addr <= _GEN_44;	// CSR.scala:379:20, :1081:18, :1183:43
    if (_GEN_46) begin	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
      reg_pmp_2_cfg_x <= _newCfg_WIRE_2[2];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
      reg_pmp_2_cfg_w <= _newCfg_WIRE_2[1] & _newCfg_WIRE_2[0];	// CSR.scala:379:20, :1072:{46,53}, :1075:31, :1183:43
      reg_pmp_2_cfg_r <= _newCfg_WIRE_2[0];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
    end
    if (csr_wen & _GEN_28
        & ~(reg_pmp_2_cfg_l | reg_pmp_3_cfg_l & ~(reg_pmp_3_cfg_a[1])
            & reg_pmp_3_cfg_a[0]))	// CSR.scala:379:20, :636:73, :897:18, :1080:{48,71}, :1081:18, PMP.scala:47:20, :48:26, :49:13, :51:{44,62}, package.scala:72:59
      reg_pmp_2_addr <= _GEN_44;	// CSR.scala:379:20, :1081:18, :1183:43
    if (_GEN_47) begin	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
      reg_pmp_3_cfg_x <= _newCfg_WIRE_3[2];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
      reg_pmp_3_cfg_w <= _newCfg_WIRE_3[1] & _newCfg_WIRE_3[0];	// CSR.scala:379:20, :1072:{46,53}, :1075:31, :1183:43
      reg_pmp_3_cfg_r <= _newCfg_WIRE_3[0];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
    end
    if (csr_wen & _GEN_29
        & ~(reg_pmp_3_cfg_l | reg_pmp_4_cfg_l & ~(reg_pmp_4_cfg_a[1])
            & reg_pmp_4_cfg_a[0]))	// CSR.scala:379:20, :636:73, :897:18, :1080:{48,71}, :1081:18, PMP.scala:47:20, :48:26, :49:13, :51:{44,62}, package.scala:72:59
      reg_pmp_3_addr <= _GEN_44;	// CSR.scala:379:20, :1081:18, :1183:43
    if (_GEN_48) begin	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
      reg_pmp_4_cfg_x <= _newCfg_WIRE_4[2];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
      reg_pmp_4_cfg_w <= _newCfg_WIRE_4[1] & _newCfg_WIRE_4[0];	// CSR.scala:379:20, :1072:{46,53}, :1075:31, :1183:43
      reg_pmp_4_cfg_r <= _newCfg_WIRE_4[0];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
    end
    if (csr_wen & _GEN_30
        & ~(reg_pmp_4_cfg_l | reg_pmp_5_cfg_l & ~(reg_pmp_5_cfg_a[1])
            & reg_pmp_5_cfg_a[0]))	// CSR.scala:379:20, :636:73, :897:18, :1080:{48,71}, :1081:18, PMP.scala:47:20, :48:26, :49:13, :51:{44,62}, package.scala:72:59
      reg_pmp_4_addr <= _GEN_44;	// CSR.scala:379:20, :1081:18, :1183:43
    if (_GEN_49) begin	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
      reg_pmp_5_cfg_x <= _newCfg_WIRE_5[2];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
      reg_pmp_5_cfg_w <= _newCfg_WIRE_5[1] & _newCfg_WIRE_5[0];	// CSR.scala:379:20, :1072:{46,53}, :1075:31, :1183:43
      reg_pmp_5_cfg_r <= _newCfg_WIRE_5[0];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
    end
    if (csr_wen & _GEN_31
        & ~(reg_pmp_5_cfg_l | reg_pmp_6_cfg_l & ~(reg_pmp_6_cfg_a[1])
            & reg_pmp_6_cfg_a[0]))	// CSR.scala:379:20, :636:73, :897:18, :1080:{48,71}, :1081:18, PMP.scala:47:20, :48:26, :49:13, :51:{44,62}, package.scala:72:59
      reg_pmp_5_addr <= _GEN_44;	// CSR.scala:379:20, :1081:18, :1183:43
    if (_GEN_50) begin	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
      reg_pmp_6_cfg_x <= _newCfg_WIRE_6[2];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
      reg_pmp_6_cfg_w <= _newCfg_WIRE_6[1] & _newCfg_WIRE_6[0];	// CSR.scala:379:20, :1072:{46,53}, :1075:31, :1183:43
      reg_pmp_6_cfg_r <= _newCfg_WIRE_6[0];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
    end
    if (csr_wen & _GEN_32 & ~(reg_pmp_6_cfg_l | _GEN_51))	// CSR.scala:379:20, :636:73, :897:18, :1080:{48,71}, :1081:18, PMP.scala:51:{44,62}, package.scala:72:59
      reg_pmp_6_addr <= _GEN_44;	// CSR.scala:379:20, :1081:18, :1183:43
    if (_GEN_52) begin	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
      reg_pmp_7_cfg_x <= _newCfg_WIRE_7[2];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
      reg_pmp_7_cfg_w <= _newCfg_WIRE_7[1] & _newCfg_WIRE_7[0];	// CSR.scala:379:20, :1072:{46,53}, :1075:31, :1183:43
      reg_pmp_7_cfg_r <= _newCfg_WIRE_7[0];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
    end
    if (csr_wen & _GEN_33 & ~(reg_pmp_7_cfg_l | _GEN_51))	// CSR.scala:379:20, :636:73, :897:18, :1080:{48,71}, :1081:18, PMP.scala:51:{44,62}, package.scala:72:59
      reg_pmp_7_addr <= _GEN_44;	// CSR.scala:379:20, :1081:18, :1183:43
    if (csr_wen & _GEN_14)	// CSR.scala:381:20, :636:73, :897:18, :944:{40,50}, package.scala:72:59
      reg_mie <= {48'h0, _wdata_T_2[15:0] & _wdata_T_6[15:0] & 16'h888};	// CSR.scala:355:10, :378:19, :381:20, :944:59, :1183:{34,43,45}
    if (csr_wen & _GEN_16)	// CSR.scala:636:73, :754:20, :897:18, :945:{40,51}, package.scala:72:59
      reg_mepc <= _GEN_40;	// CSR.scala:391:21, :945:51
    else if (_GEN_39) begin	// CSR.scala:391:21, :754:20, :755:24
    end
    else	// CSR.scala:391:21, :754:20, :755:24
      reg_mepc <= epc;	// CSR.scala:391:21, :1204:31
    if (csr_wen & _GEN_17)	// CSR.scala:636:73, :754:20, :897:18, :950:{40,52}, package.scala:72:59
      reg_mtval <= _wdata_T_2[33:0] & _wdata_T_6[33:0];	// CSR.scala:393:22, :950:60, :1183:{34,43,45}
    else if (_GEN_39) begin	// CSR.scala:391:21, :393:22, :754:20, :755:24
    end
    else	// CSR.scala:393:22, :754:20, :755:24
      reg_mtval <= io_tval;	// CSR.scala:393:22
    if (csr_wen & _GEN_15)	// CSR.scala:394:25, :636:73, :897:18, :946:{40,55}, package.scala:72:59
      reg_mscratch <= _reg_bp_0_control_WIRE_1;	// CSR.scala:394:25, :1183:43
    io_status_dprv_REG <= 2'h3;	// CSR.scala:316:21, :734:24
  end // always @(posedge)
  always @(posedge io_ungated_clock) begin
    if (reset) begin
      reg_wfi <= 1'h0;	// CSR.scala:427:50, :677:21, :729:74
      value_lo_1 <= 6'h0;	// Counters.scala:45:37
      value_hi_1 <= 58'h0;	// Counters.scala:50:27
    end
    else begin
      reg_wfi <=
        ~((|{_GEN[11], _GEN[7], _GEN[3]}) | io_interrupts_debug
          | _io_trace_0_exception_output)
        & (system_insn & io_rw_addr[9:8] == 2'h1 & ~_io_singleStep_output & ~reg_debug
           | reg_wfi);	// CSR.scala:368:22, :427:50, :457:56, :469:36, :639:31, :652:28, :675:45, :727:34, :738:43, :741:{36,51,61}, :742:{28,55,69,79}, :859:21, Decode.scala:14:121
      if (csr_wen & _GEN_23) begin	// CSR.scala:636:73, :897:18, :1201:31, Counters.scala:47:19, :65:11, package.scala:72:59
        value_lo_1 <= _GEN_37;	// CSR.scala:1183:43, Counters.scala:45:37, :65:11
        value_hi_1 <= _wdata_T_2[63:6] & _wdata_T_6[63:6];	// CSR.scala:1183:{34,43,45}, Counters.scala:50:27, :66:28
      end
      else begin	// CSR.scala:897:18, :1201:31, Counters.scala:47:19, :65:11
        automatic logic [6:0] nextSmall_1;	// Counters.scala:46:33
        nextSmall_1 = {1'h0, value_lo_1} + {6'h0, ~_io_csr_stall_output};	// CSR.scala:440:56, :677:21, :729:74, :845:27, Counters.scala:45:37, :46:33
        if (reg_mcountinhibit[0]) begin	// CSR.scala:436:34, :437:40
        end
        else	// CSR.scala:437:40
          value_lo_1 <= nextSmall_1[5:0];	// Counters.scala:45:37, :46:33, :47:27
        if (nextSmall_1[6] & ~(reg_mcountinhibit[0]))	// CSR.scala:436:34, :437:40, Counters.scala:46:33, :47:9, :51:{20,33}
          value_hi_1 <= value_hi_1 + 58'h1;	// Counters.scala:50:27, :51:55
      end
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:73];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [6:0] i = 7'h0; i < 7'h4A; i += 7'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        reg_mstatus_mpp = _RANDOM[7'h2][27:26];	// CSR.scala:319:24
        reg_mstatus_mpie = _RANDOM[7'h2][31];	// CSR.scala:319:24
        reg_mstatus_mie = _RANDOM[7'h3][3];	// CSR.scala:319:24
        reg_dcsr_ebreakm = _RANDOM[7'h3][23];	// CSR.scala:319:24, :327:21
        reg_dcsr_cause = {_RANDOM[7'h3][31:30], _RANDOM[7'h4][0]};	// CSR.scala:319:24, :327:21
        reg_dcsr_step = _RANDOM[7'h4][4];	// CSR.scala:327:21
        reg_debug = _RANDOM[7'h4][7];	// CSR.scala:327:21, :368:22
        reg_dpc = {_RANDOM[7'h4][31:8], _RANDOM[7'h5][9:0]};	// CSR.scala:327:21, :369:20
        reg_dscratch = {_RANDOM[7'h5][31:10], _RANDOM[7'h6], _RANDOM[7'h7][9:0]};	// CSR.scala:369:20, :370:25
        reg_singleStepped = _RANDOM[7'h7][10];	// CSR.scala:370:25, :372:30
        reg_bp_0_control_dmode = _RANDOM[7'h7][16];	// CSR.scala:370:25, :378:19
        reg_bp_0_control_action = _RANDOM[7'h8][31];	// CSR.scala:378:19
        reg_bp_0_control_chain = _RANDOM[7'h9][0];	// CSR.scala:378:19
        reg_bp_0_control_tmatch = _RANDOM[7'h9][4:3];	// CSR.scala:378:19
        reg_bp_0_control_x = _RANDOM[7'h9][9];	// CSR.scala:378:19
        reg_bp_0_control_w = _RANDOM[7'h9][10];	// CSR.scala:378:19
        reg_bp_0_control_r = _RANDOM[7'h9][11];	// CSR.scala:378:19
        reg_bp_0_address = {_RANDOM[7'h9][31:12], _RANDOM[7'hA][12:0]};	// CSR.scala:378:19
        reg_pmp_0_cfg_l = _RANDOM[7'h10][20];	// CSR.scala:379:20
        reg_pmp_0_cfg_a = _RANDOM[7'h10][24:23];	// CSR.scala:379:20
        reg_pmp_0_cfg_x = _RANDOM[7'h10][25];	// CSR.scala:379:20
        reg_pmp_0_cfg_w = _RANDOM[7'h10][26];	// CSR.scala:379:20
        reg_pmp_0_cfg_r = _RANDOM[7'h10][27];	// CSR.scala:379:20
        reg_pmp_0_addr = {_RANDOM[7'h10][31:28], _RANDOM[7'h11][25:0]};	// CSR.scala:379:20
        reg_pmp_1_cfg_l = _RANDOM[7'h11][26];	// CSR.scala:379:20
        reg_pmp_1_cfg_a = _RANDOM[7'h11][30:29];	// CSR.scala:379:20
        reg_pmp_1_cfg_x = _RANDOM[7'h11][31];	// CSR.scala:379:20
        reg_pmp_1_cfg_w = _RANDOM[7'h12][0];	// CSR.scala:379:20
        reg_pmp_1_cfg_r = _RANDOM[7'h12][1];	// CSR.scala:379:20
        reg_pmp_1_addr = _RANDOM[7'h12][31:2];	// CSR.scala:379:20
        reg_pmp_2_cfg_l = _RANDOM[7'h13][0];	// CSR.scala:379:20
        reg_pmp_2_cfg_a = _RANDOM[7'h13][4:3];	// CSR.scala:379:20
        reg_pmp_2_cfg_x = _RANDOM[7'h13][5];	// CSR.scala:379:20
        reg_pmp_2_cfg_w = _RANDOM[7'h13][6];	// CSR.scala:379:20
        reg_pmp_2_cfg_r = _RANDOM[7'h13][7];	// CSR.scala:379:20
        reg_pmp_2_addr = {_RANDOM[7'h13][31:8], _RANDOM[7'h14][5:0]};	// CSR.scala:379:20
        reg_pmp_3_cfg_l = _RANDOM[7'h14][6];	// CSR.scala:379:20
        reg_pmp_3_cfg_a = _RANDOM[7'h14][10:9];	// CSR.scala:379:20
        reg_pmp_3_cfg_x = _RANDOM[7'h14][11];	// CSR.scala:379:20
        reg_pmp_3_cfg_w = _RANDOM[7'h14][12];	// CSR.scala:379:20
        reg_pmp_3_cfg_r = _RANDOM[7'h14][13];	// CSR.scala:379:20
        reg_pmp_3_addr = {_RANDOM[7'h14][31:14], _RANDOM[7'h15][11:0]};	// CSR.scala:379:20
        reg_pmp_4_cfg_l = _RANDOM[7'h15][12];	// CSR.scala:379:20
        reg_pmp_4_cfg_a = _RANDOM[7'h15][16:15];	// CSR.scala:379:20
        reg_pmp_4_cfg_x = _RANDOM[7'h15][17];	// CSR.scala:379:20
        reg_pmp_4_cfg_w = _RANDOM[7'h15][18];	// CSR.scala:379:20
        reg_pmp_4_cfg_r = _RANDOM[7'h15][19];	// CSR.scala:379:20
        reg_pmp_4_addr = {_RANDOM[7'h15][31:20], _RANDOM[7'h16][17:0]};	// CSR.scala:379:20
        reg_pmp_5_cfg_l = _RANDOM[7'h16][18];	// CSR.scala:379:20
        reg_pmp_5_cfg_a = _RANDOM[7'h16][22:21];	// CSR.scala:379:20
        reg_pmp_5_cfg_x = _RANDOM[7'h16][23];	// CSR.scala:379:20
        reg_pmp_5_cfg_w = _RANDOM[7'h16][24];	// CSR.scala:379:20
        reg_pmp_5_cfg_r = _RANDOM[7'h16][25];	// CSR.scala:379:20
        reg_pmp_5_addr = {_RANDOM[7'h16][31:26], _RANDOM[7'h17][23:0]};	// CSR.scala:379:20
        reg_pmp_6_cfg_l = _RANDOM[7'h17][24];	// CSR.scala:379:20
        reg_pmp_6_cfg_a = _RANDOM[7'h17][28:27];	// CSR.scala:379:20
        reg_pmp_6_cfg_x = _RANDOM[7'h17][29];	// CSR.scala:379:20
        reg_pmp_6_cfg_w = _RANDOM[7'h17][30];	// CSR.scala:379:20
        reg_pmp_6_cfg_r = _RANDOM[7'h17][31];	// CSR.scala:379:20
        reg_pmp_6_addr = _RANDOM[7'h18][29:0];	// CSR.scala:379:20
        reg_pmp_7_cfg_l = _RANDOM[7'h18][30];	// CSR.scala:379:20
        reg_pmp_7_cfg_a = _RANDOM[7'h19][2:1];	// CSR.scala:379:20
        reg_pmp_7_cfg_x = _RANDOM[7'h19][3];	// CSR.scala:379:20
        reg_pmp_7_cfg_w = _RANDOM[7'h19][4];	// CSR.scala:379:20
        reg_pmp_7_cfg_r = _RANDOM[7'h19][5];	// CSR.scala:379:20
        reg_pmp_7_addr = {_RANDOM[7'h19][31:6], _RANDOM[7'h1A][3:0]};	// CSR.scala:379:20
        reg_mie = {_RANDOM[7'h1A][31:4], _RANDOM[7'h1B], _RANDOM[7'h1C][3:0]};	// CSR.scala:379:20, :381:20
        reg_mepc = {_RANDOM[7'h20][31:20], _RANDOM[7'h21][21:0]};	// CSR.scala:391:21
        reg_mcause = {_RANDOM[7'h21][31:22], _RANDOM[7'h22], _RANDOM[7'h23][21:0]};	// CSR.scala:391:21, :392:27
        reg_mtval = {_RANDOM[7'h23][31:22], _RANDOM[7'h24][23:0]};	// CSR.scala:392:27, :393:22
        reg_mscratch = {_RANDOM[7'h24][31:24], _RANDOM[7'h25], _RANDOM[7'h26][23:0]};	// CSR.scala:393:22, :394:25
        reg_mtvec = {_RANDOM[7'h26][31:24], _RANDOM[7'h27][23:0]};	// CSR.scala:394:25, :397:27
        reg_wfi = _RANDOM[7'h3B][8];	// CSR.scala:427:50
        reg_mcountinhibit = _RANDOM[7'h3B][19:17];	// CSR.scala:427:50, :436:34
        value_lo = _RANDOM[7'h3B][25:20];	// CSR.scala:427:50, Counters.scala:45:37
        value_hi = {_RANDOM[7'h3B][31:26], _RANDOM[7'h3C], _RANDOM[7'h3D][19:0]};	// CSR.scala:427:50, Counters.scala:50:27
        value_lo_1 = _RANDOM[7'h3D][25:20];	// Counters.scala:45:37, :50:27
        value_hi_1 = {_RANDOM[7'h3D][31:26], _RANDOM[7'h3E], _RANDOM[7'h3F][19:0]};	// Counters.scala:50:27
        reg_misa = {_RANDOM[7'h3F][31:20], _RANDOM[7'h40], _RANDOM[7'h41][19:0]};	// CSR.scala:490:21, Counters.scala:50:27
        reg_custom_0 = {_RANDOM[7'h41][31:20], _RANDOM[7'h42], _RANDOM[7'h43][19:0]};	// CSR.scala:490:21, :628:43
        io_status_dprv_REG = _RANDOM[7'h49][21:20];	// CSR.scala:734:24
        io_status_cease_r = _RANDOM[7'h49][22];	// CSR.scala:734:24, Reg.scala:27:20
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_rw_rdata = _io_rw_rdata_WIRE;	// Mux.scala:27:72
  assign io_decode_0_read_illegal =
    ~(io_decode_0_csr == 12'h7A0 | io_decode_0_csr == 12'h7A1 | io_decode_0_csr == 12'h7A2
      | io_decode_0_csr == 12'h7A3 | io_decode_0_csr == 12'h301
      | io_decode_0_csr == 12'h300 | io_decode_0_csr == 12'h305
      | io_decode_0_csr == 12'h344 | io_decode_0_csr == 12'h304
      | io_decode_0_csr == 12'h340 | io_decode_0_csr == 12'h341
      | io_decode_0_csr == 12'h343 | io_decode_0_csr == 12'h342
      | io_decode_0_csr == 12'hF14 | io_decode_0_csr == 12'h7B0
      | io_decode_0_csr == 12'h7B1 | io_decode_0_csr == 12'h7B2
      | io_decode_0_csr == 12'h320 | io_decode_0_csr == 12'hB00
      | io_decode_0_csr == 12'hB02 | io_decode_0_csr == 12'h323
      | io_decode_0_csr == 12'hB03 | io_decode_0_csr == 12'h324
      | io_decode_0_csr == 12'hB04 | io_decode_0_csr == 12'h325
      | io_decode_0_csr == 12'hB05 | io_decode_0_csr == 12'h326
      | io_decode_0_csr == 12'hB06 | io_decode_0_csr == 12'h327
      | io_decode_0_csr == 12'hB07 | io_decode_0_csr == 12'h328
      | io_decode_0_csr == 12'hB08 | io_decode_0_csr == 12'h329
      | io_decode_0_csr == 12'hB09 | io_decode_0_csr == 12'h32A
      | io_decode_0_csr == 12'hB0A | io_decode_0_csr == 12'h32B
      | io_decode_0_csr == 12'hB0B | io_decode_0_csr == 12'h32C
      | io_decode_0_csr == 12'hB0C | io_decode_0_csr == 12'h32D
      | io_decode_0_csr == 12'hB0D | io_decode_0_csr == 12'h32E
      | io_decode_0_csr == 12'hB0E | io_decode_0_csr == 12'h32F
      | io_decode_0_csr == 12'hB0F | io_decode_0_csr == 12'h330
      | io_decode_0_csr == 12'hB10 | io_decode_0_csr == 12'h331
      | io_decode_0_csr == 12'hB11 | io_decode_0_csr == 12'h332
      | io_decode_0_csr == 12'hB12 | io_decode_0_csr == 12'h333
      | io_decode_0_csr == 12'hB13 | io_decode_0_csr == 12'h334
      | io_decode_0_csr == 12'hB14 | io_decode_0_csr == 12'h335
      | io_decode_0_csr == 12'hB15 | io_decode_0_csr == 12'h336
      | io_decode_0_csr == 12'hB16 | io_decode_0_csr == 12'h337
      | io_decode_0_csr == 12'hB17 | io_decode_0_csr == 12'h338
      | io_decode_0_csr == 12'hB18 | io_decode_0_csr == 12'h339
      | io_decode_0_csr == 12'hB19 | io_decode_0_csr == 12'h33A
      | io_decode_0_csr == 12'hB1A | io_decode_0_csr == 12'h33B
      | io_decode_0_csr == 12'hB1B | io_decode_0_csr == 12'h33C
      | io_decode_0_csr == 12'hB1C | io_decode_0_csr == 12'h33D
      | io_decode_0_csr == 12'hB1D | io_decode_0_csr == 12'h33E
      | io_decode_0_csr == 12'hB1E | io_decode_0_csr == 12'h33F
      | io_decode_0_csr == 12'hB1F | io_decode_0_csr == 12'h3A0
      | io_decode_0_csr == 12'h3A2 | io_decode_0_csr == 12'h3B0
      | io_decode_0_csr == 12'h3B1 | io_decode_0_csr == 12'h3B2
      | io_decode_0_csr == 12'h3B3 | io_decode_0_csr == 12'h3B4
      | io_decode_0_csr == 12'h3B5 | io_decode_0_csr == 12'h3B6
      | io_decode_0_csr == 12'h3B7 | io_decode_0_csr == 12'h3B8
      | io_decode_0_csr == 12'h3B9 | io_decode_0_csr == 12'h3BA
      | io_decode_0_csr == 12'h3BB | io_decode_0_csr == 12'h3BC
      | io_decode_0_csr == 12'h3BD | io_decode_0_csr == 12'h3BE
      | io_decode_0_csr == 12'h3BF | io_decode_0_csr == 12'h7C1
      | io_decode_0_csr == 12'hF12 | io_decode_0_csr == 12'hF11
      | io_decode_0_csr == 12'hF13) | {io_decode_0_csr[11:10], io_decode_0_csr[4]} == 3'h3
    & ~reg_debug;	// CSR.scala:368:22, :636:73, :655:{99,115}, :672:7, :674:148, :675:{42,45}, Decode.scala:14:{65,121}
  assign io_decode_0_write_illegal = &(io_decode_0_csr[11:10]);	// CSR.scala:678:{39,47}
  assign io_decode_0_write_flush =
    ~(io_decode_0_csr > 12'h33F & io_decode_0_csr < 12'h344 | io_decode_0_csr > 12'h13F
      & io_decode_0_csr < 12'h144);	// CSR.scala:636:73, :655:99, :679:{27,40,57,71,85,99,116,130}
  assign io_decode_0_system_illegal =
    {io_decode_0_csr[9], io_decode_0_csr[2]} == 2'h2 & io_decode_0_csr[10]
    & io_decode_0_csr[7] & ~reg_debug;	// CSR.scala:368:22, :659:30, :675:45, :683:{27,45,49}, :1206:39, Decode.scala:14:121
  assign io_csr_stall = _io_csr_stall_output;	// CSR.scala:845:27
  assign io_eret = _exception_T | insn_ret;	// CSR.scala:652:95, :726:{24,38}
  assign io_singleStep = _io_singleStep_output;	// CSR.scala:727:34
  assign io_status_debug = reg_debug;	// CSR.scala:368:22
  assign io_status_wfi = reg_wfi;	// CSR.scala:427:50
  assign io_status_isa = reg_misa[31:0];	// CSR.scala:490:21, :731:17
  assign io_status_dprv = io_status_dprv_REG;	// CSR.scala:734:24
  assign io_evec =
    insn_ret
      ? (_GEN_35
           ? ~{_io_evec_T_5[33:2], _io_evec_T_5[1:0] | {~(reg_misa[2]), 1'h1}}
           : ~{_io_evec_T_15[33:2], _io_evec_T_15[1:0] | {~(reg_misa[2]), 1'h1}})
      : trapToDebug
          ? {22'h0, reg_debug ? {8'h80, ~insn_break, 3'h0} : 12'h800}
          : {2'h0,
             read_mtvec_lo[0] & cause[63] & cause[7:6] == 2'h0
               ? {read_mtvec_lo[31:8], cause[5:0]}
               : read_mtvec_lo[31:2],
             2'h0};	// CSR.scala:324:49, :325:24, :368:22, :490:21, :652:95, :688:8, :690:25, :691:30, :694:123, :697:{22,37}, :706:32, :707:33, :708:{24,55,70,94}, :709:{8,38}, :723:17, :724:11, :813:19, :815:52, :821:{52,70}, :824:15, :825:69, :1205:{26,28,31,36,45}, Cat.scala:30:58, package.scala:165:35
  assign io_time = value_1;	// Cat.scala:30:58
  assign io_interrupt =
    ((io_interrupts_debug | m_interrupts[15] | m_interrupts[14] | m_interrupts[13]
      | m_interrupts[12] | m_interrupts[11] | m_interrupts[3] | m_interrupts[7]
      | m_interrupts[9] | m_interrupts[1] | m_interrupts[5] | m_interrupts[8]
      | m_interrupts[0] | m_interrupts[4]) & ~_io_singleStep_output | reg_singleStepped)
    & ~(reg_debug | io_status_cease_r);	// CSR.scala:368:22, :372:30, :464:25, :469:{33,36,51,73,76,88}, :727:34, :1177:{76,90}, Reg.scala:27:20
  assign io_interrupt_cause =
    {60'h0,
     io_interrupts_debug
       ? 4'hE
       : m_interrupts[15]
           ? 4'hF
           : m_interrupts[14]
               ? 4'hE
               : m_interrupts[13]
                   ? 4'hD
                   : m_interrupts[12]
                       ? 4'hC
                       : m_interrupts[11]
                           ? 4'hB
                           : m_interrupts[3]
                               ? 4'h3
                               : m_interrupts[7]
                                   ? 4'h7
                                   : m_interrupts[9]
                                       ? 4'h9
                                       : m_interrupts[1]
                                           ? 4'h1
                                           : m_interrupts[5]
                                               ? 4'h5
                                               : m_interrupts[8]
                                                   ? 4'h8
                                                   : {1'h0, ~(m_interrupts[0]), 2'h0}}
    - 64'h8000000000000000;	// CSR.scala:464:25, :468:67, :677:21, :729:74, :1177:76, Mux.scala:47:69
  assign io_bp_0_control_action = reg_bp_0_control_action;	// CSR.scala:378:19
  assign io_bp_0_control_chain = reg_bp_0_control_chain;	// CSR.scala:378:19
  assign io_bp_0_control_tmatch = reg_bp_0_control_tmatch;	// CSR.scala:378:19
  assign io_bp_0_control_x = reg_bp_0_control_x;	// CSR.scala:378:19
  assign io_bp_0_control_w = reg_bp_0_control_w;	// CSR.scala:378:19
  assign io_bp_0_control_r = reg_bp_0_control_r;	// CSR.scala:378:19
  assign io_bp_0_address = reg_bp_0_address;	// CSR.scala:378:19
  assign io_pmp_0_cfg_l = reg_pmp_0_cfg_l;	// CSR.scala:379:20
  assign io_pmp_0_cfg_a = reg_pmp_0_cfg_a;	// CSR.scala:379:20
  assign io_pmp_0_cfg_x = reg_pmp_0_cfg_x;	// CSR.scala:379:20
  assign io_pmp_0_cfg_w = reg_pmp_0_cfg_w;	// CSR.scala:379:20
  assign io_pmp_0_cfg_r = reg_pmp_0_cfg_r;	// CSR.scala:379:20
  assign io_pmp_0_addr = reg_pmp_0_addr;	// CSR.scala:379:20
  assign io_pmp_0_mask = {_GEN_0 & ~(_GEN_0 + 30'h1), 2'h3};	// CSR.scala:316:21, PMP.scala:29:14, :60:{14,16,23}
  assign io_pmp_1_cfg_l = reg_pmp_1_cfg_l;	// CSR.scala:379:20
  assign io_pmp_1_cfg_a = reg_pmp_1_cfg_a;	// CSR.scala:379:20
  assign io_pmp_1_cfg_x = reg_pmp_1_cfg_x;	// CSR.scala:379:20
  assign io_pmp_1_cfg_w = reg_pmp_1_cfg_w;	// CSR.scala:379:20
  assign io_pmp_1_cfg_r = reg_pmp_1_cfg_r;	// CSR.scala:379:20
  assign io_pmp_1_addr = reg_pmp_1_addr;	// CSR.scala:379:20
  assign io_pmp_1_mask = {_GEN_1 & ~(_GEN_1 + 30'h1), 2'h3};	// CSR.scala:316:21, PMP.scala:29:14, :60:{14,16,23}
  assign io_pmp_2_cfg_l = reg_pmp_2_cfg_l;	// CSR.scala:379:20
  assign io_pmp_2_cfg_a = reg_pmp_2_cfg_a;	// CSR.scala:379:20
  assign io_pmp_2_cfg_x = reg_pmp_2_cfg_x;	// CSR.scala:379:20
  assign io_pmp_2_cfg_w = reg_pmp_2_cfg_w;	// CSR.scala:379:20
  assign io_pmp_2_cfg_r = reg_pmp_2_cfg_r;	// CSR.scala:379:20
  assign io_pmp_2_addr = reg_pmp_2_addr;	// CSR.scala:379:20
  assign io_pmp_2_mask = {_GEN_2 & ~(_GEN_2 + 30'h1), 2'h3};	// CSR.scala:316:21, PMP.scala:29:14, :60:{14,16,23}
  assign io_pmp_3_cfg_l = reg_pmp_3_cfg_l;	// CSR.scala:379:20
  assign io_pmp_3_cfg_a = reg_pmp_3_cfg_a;	// CSR.scala:379:20
  assign io_pmp_3_cfg_x = reg_pmp_3_cfg_x;	// CSR.scala:379:20
  assign io_pmp_3_cfg_w = reg_pmp_3_cfg_w;	// CSR.scala:379:20
  assign io_pmp_3_cfg_r = reg_pmp_3_cfg_r;	// CSR.scala:379:20
  assign io_pmp_3_addr = reg_pmp_3_addr;	// CSR.scala:379:20
  assign io_pmp_3_mask = {_GEN_3 & ~(_GEN_3 + 30'h1), 2'h3};	// CSR.scala:316:21, PMP.scala:29:14, :60:{14,16,23}
  assign io_pmp_4_cfg_l = reg_pmp_4_cfg_l;	// CSR.scala:379:20
  assign io_pmp_4_cfg_a = reg_pmp_4_cfg_a;	// CSR.scala:379:20
  assign io_pmp_4_cfg_x = reg_pmp_4_cfg_x;	// CSR.scala:379:20
  assign io_pmp_4_cfg_w = reg_pmp_4_cfg_w;	// CSR.scala:379:20
  assign io_pmp_4_cfg_r = reg_pmp_4_cfg_r;	// CSR.scala:379:20
  assign io_pmp_4_addr = reg_pmp_4_addr;	// CSR.scala:379:20
  assign io_pmp_4_mask = {_GEN_4 & ~(_GEN_4 + 30'h1), 2'h3};	// CSR.scala:316:21, PMP.scala:29:14, :60:{14,16,23}
  assign io_pmp_5_cfg_l = reg_pmp_5_cfg_l;	// CSR.scala:379:20
  assign io_pmp_5_cfg_a = reg_pmp_5_cfg_a;	// CSR.scala:379:20
  assign io_pmp_5_cfg_x = reg_pmp_5_cfg_x;	// CSR.scala:379:20
  assign io_pmp_5_cfg_w = reg_pmp_5_cfg_w;	// CSR.scala:379:20
  assign io_pmp_5_cfg_r = reg_pmp_5_cfg_r;	// CSR.scala:379:20
  assign io_pmp_5_addr = reg_pmp_5_addr;	// CSR.scala:379:20
  assign io_pmp_5_mask = {_GEN_5 & ~(_GEN_5 + 30'h1), 2'h3};	// CSR.scala:316:21, PMP.scala:29:14, :60:{14,16,23}
  assign io_pmp_6_cfg_l = reg_pmp_6_cfg_l;	// CSR.scala:379:20
  assign io_pmp_6_cfg_a = reg_pmp_6_cfg_a;	// CSR.scala:379:20
  assign io_pmp_6_cfg_x = reg_pmp_6_cfg_x;	// CSR.scala:379:20
  assign io_pmp_6_cfg_w = reg_pmp_6_cfg_w;	// CSR.scala:379:20
  assign io_pmp_6_cfg_r = reg_pmp_6_cfg_r;	// CSR.scala:379:20
  assign io_pmp_6_addr = reg_pmp_6_addr;	// CSR.scala:379:20
  assign io_pmp_6_mask = {_GEN_6 & ~(_GEN_6 + 30'h1), 2'h3};	// CSR.scala:316:21, PMP.scala:29:14, :60:{14,16,23}
  assign io_pmp_7_cfg_l = reg_pmp_7_cfg_l;	// CSR.scala:379:20
  assign io_pmp_7_cfg_a = reg_pmp_7_cfg_a;	// CSR.scala:379:20
  assign io_pmp_7_cfg_x = reg_pmp_7_cfg_x;	// CSR.scala:379:20
  assign io_pmp_7_cfg_w = reg_pmp_7_cfg_w;	// CSR.scala:379:20
  assign io_pmp_7_cfg_r = reg_pmp_7_cfg_r;	// CSR.scala:379:20
  assign io_pmp_7_addr = reg_pmp_7_addr;	// CSR.scala:379:20
  assign io_pmp_7_mask = {_GEN_7 & ~(_GEN_7 + 30'h1), 2'h3};	// CSR.scala:316:21, PMP.scala:29:14, :60:{14,16,23}
  assign io_inhibit_cycle = reg_mcountinhibit[0];	// CSR.scala:436:34, :437:40
  assign io_trace_0_valid = io_retire | _io_trace_0_exception_output;	// CSR.scala:738:43, :1162:30
  assign io_trace_0_iaddr = io_pc;
  assign io_trace_0_insn = io_inst_0;
  assign io_trace_0_exception = _io_trace_0_exception_output;	// CSR.scala:738:43
  assign io_customCSRs_0_value = reg_custom_0;	// CSR.scala:628:43
endmodule

