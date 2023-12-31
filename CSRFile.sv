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

module CSRFile(
  input         clock,
                reset,
                io_ungated_clock,
                io_interrupts_debug,
                io_interrupts_mtip,
                io_interrupts_msip,
                io_interrupts_meip,
                io_interrupts_seip,
  input  [2:0]  io_hartid,
  input  [11:0] io_rw_addr,
  input  [2:0]  io_rw_cmd,
  input  [63:0] io_rw_wdata,
  input  [11:0] io_decode_0_csr,
  input         io_exception,
                io_retire,
  input  [63:0] io_cause,
  input  [39:0] io_pc,
                io_tval,
  input         io_fcsr_flags_valid,
  input  [4:0]  io_fcsr_flags_bits,
  output [63:0] io_rw_rdata,
  output        io_decode_0_fp_illegal,
                io_decode_0_fp_csr,
                io_decode_0_read_illegal,
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
                io_status_prv,
  output        io_status_mxr,
                io_status_sum,
  output [3:0]  io_ptbr_mode,
  output [43:0] io_ptbr_ppn,
  output [39:0] io_evec,
  output [63:0] io_time,
  output [2:0]  io_fcsr_rm,
  output        io_interrupt,
  output [63:0] io_interrupt_cause,
  output        io_bp_0_control_action,
                io_bp_0_control_chain,
  output [1:0]  io_bp_0_control_tmatch,
  output        io_bp_0_control_m,
                io_bp_0_control_s,
                io_bp_0_control_u,
                io_bp_0_control_x,
                io_bp_0_control_w,
                io_bp_0_control_r,
  output [38:0] io_bp_0_address,
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
                io_trace_0_exception,
  output [63:0] io_customCSRs_0_value
);

  wire [63:0] _io_rw_rdata_WIRE;	// Mux.scala:27:72
  reg         io_status_cease_r;	// Reg.scala:27:20
  wire        _io_singleStep_output;	// CSR.scala:727:34
  reg  [1:0]  reg_mstatus_prv;	// CSR.scala:319:24
  reg         reg_mstatus_tsr;	// CSR.scala:319:24
  reg         reg_mstatus_tw;	// CSR.scala:319:24
  reg         reg_mstatus_tvm;	// CSR.scala:319:24
  reg         reg_mstatus_mxr;	// CSR.scala:319:24
  reg         reg_mstatus_sum;	// CSR.scala:319:24
  reg         reg_mstatus_mprv;	// CSR.scala:319:24
  reg  [1:0]  reg_mstatus_fs;	// CSR.scala:319:24
  reg  [1:0]  reg_mstatus_mpp;	// CSR.scala:319:24
  reg         reg_mstatus_spp;	// CSR.scala:319:24
  reg         reg_mstatus_mpie;	// CSR.scala:319:24
  reg         reg_mstatus_spie;	// CSR.scala:319:24
  reg         reg_mstatus_mie;	// CSR.scala:319:24
  reg         reg_mstatus_sie;	// CSR.scala:319:24
  reg         reg_dcsr_ebreakm;	// CSR.scala:327:21
  reg         reg_dcsr_ebreaks;	// CSR.scala:327:21
  reg         reg_dcsr_ebreaku;	// CSR.scala:327:21
  reg  [2:0]  reg_dcsr_cause;	// CSR.scala:327:21
  reg         reg_dcsr_step;	// CSR.scala:327:21
  reg  [1:0]  reg_dcsr_prv;	// CSR.scala:327:21
  reg         reg_debug;	// CSR.scala:368:22
  reg  [39:0] reg_dpc;	// CSR.scala:369:20
  reg  [63:0] reg_dscratch;	// CSR.scala:370:25
  reg         reg_singleStepped;	// CSR.scala:372:30
  reg         reg_bp_0_control_dmode;	// CSR.scala:378:19
  reg         reg_bp_0_control_action;	// CSR.scala:378:19
  reg         reg_bp_0_control_chain;	// CSR.scala:378:19
  reg  [1:0]  reg_bp_0_control_tmatch;	// CSR.scala:378:19
  reg         reg_bp_0_control_m;	// CSR.scala:378:19
  reg         reg_bp_0_control_s;	// CSR.scala:378:19
  reg         reg_bp_0_control_u;	// CSR.scala:378:19
  reg         reg_bp_0_control_x;	// CSR.scala:378:19
  reg         reg_bp_0_control_w;	// CSR.scala:378:19
  reg         reg_bp_0_control_r;	// CSR.scala:378:19
  reg  [38:0] reg_bp_0_address;	// CSR.scala:378:19
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
  reg  [63:0] reg_mideleg;	// CSR.scala:383:18
  wire [8:0]  _GEN = reg_mideleg[9:1] & 9'h111;	// CSR.scala:355:50, :383:18, :384:36
  wire [15:0] _GEN_0 = {6'h0, _GEN, 1'h0};	// CSR.scala:355:50, :384:36, :729:74, Counters.scala:45:37
  wire [63:0] _GEN_1 = {54'h0, _GEN, 1'h0};	// CSR.scala:355:50, :384:36, :729:74
  reg  [63:0] reg_medeleg;	// CSR.scala:387:18
  wire [63:0] _GEN_2 = {48'h0, reg_medeleg[15:0] & 16'hB15D};	// CSR.scala:378:19, :387:18, :388:36
  reg         reg_mip_seip;	// CSR.scala:390:20
  reg         reg_mip_stip;	// CSR.scala:390:20
  reg         reg_mip_ssip;	// CSR.scala:390:20
  reg  [39:0] reg_mepc;	// CSR.scala:391:21
  reg  [63:0] reg_mcause;	// CSR.scala:392:27
  reg  [39:0] reg_mtval;	// CSR.scala:393:22
  reg  [63:0] reg_mscratch;	// CSR.scala:394:25
  reg  [31:0] reg_mtvec;	// CSR.scala:397:27
  reg  [31:0] reg_mcounteren;	// CSR.scala:413:18
  wire [31:0] _GEN_3 = {29'h0, reg_mcounteren[2:0]};	// CSR.scala:413:18, :414:30
  reg  [31:0] reg_scounteren;	// CSR.scala:417:18
  wire [31:0] _GEN_4 = {29'h0, reg_scounteren[2:0]};	// CSR.scala:414:30, :417:18, :418:36
  reg  [39:0] reg_sepc;	// CSR.scala:421:21
  reg  [63:0] reg_scause;	// CSR.scala:422:23
  reg  [39:0] reg_stval;	// CSR.scala:423:22
  reg  [63:0] reg_sscratch;	// CSR.scala:424:25
  reg  [38:0] reg_stvec;	// CSR.scala:425:22
  reg  [3:0]  reg_satp_mode;	// CSR.scala:426:21
  reg  [43:0] reg_satp_ppn;	// CSR.scala:426:21
  reg         reg_wfi;	// CSR.scala:427:50
  reg  [4:0]  reg_fflags;	// CSR.scala:429:23
  reg  [2:0]  reg_frm;	// CSR.scala:430:20
  reg  [2:0]  reg_mcountinhibit;	// CSR.scala:436:34
  reg  [5:0]  value_lo;	// Counters.scala:45:37
  reg  [57:0] value_hi;	// Counters.scala:50:27
  wire [63:0] value = {value_hi, value_lo};	// Cat.scala:30:58, Counters.scala:45:37, :50:27
  reg  [5:0]  value_lo_1;	// Counters.scala:45:37
  reg  [57:0] value_hi_1;	// Counters.scala:50:27
  wire [63:0] value_1 = {value_hi_1, value_lo_1};	// Cat.scala:30:58, Counters.scala:45:37, :50:27
  wire [15:0] read_mip =
    {4'h0,
     io_interrupts_meip,
     1'h0,
     reg_mip_seip | io_interrupts_seip,
     1'h0,
     io_interrupts_mtip,
     1'h0,
     reg_mip_stip,
     1'h0,
     io_interrupts_msip,
     1'h0,
     reg_mip_ssip,
     1'h0};	// CSR.scala:390:20, :452:57, :454:22, :599:57, :729:74
  wire [15:0] _GEN_5 = reg_mie[15:0] & read_mip;	// CSR.scala:381:20, :454:22, :457:56
  wire [15:0] m_interrupts =
    ~(reg_mstatus_prv[1]) | reg_mstatus_mie ? ~(~_GEN_5 | _GEN_0) : 16'h0;	// CSR.scala:319:24, :384:36, :457:56, :464:{25,51,60,81,83,103}, Mux.scala:27:72
  wire [15:0] s_interrupts =
    reg_mstatus_prv == 2'h0 | reg_mstatus_prv == 2'h1 & reg_mstatus_sie
      ? _GEN_5 & _GEN_0
      : 16'h0;	// CSR.scala:319:24, :384:36, :457:56, :465:{25,51,59,79,89,130}, :859:21, Mux.scala:27:72
  wire [29:0] _GEN_6 = {reg_pmp_0_addr[28:0], reg_pmp_0_cfg_a[0]};	// CSR.scala:379:20, PMP.scala:59:31, :60:23
  wire [29:0] _GEN_7 = {reg_pmp_1_addr[28:0], reg_pmp_1_cfg_a[0]};	// CSR.scala:379:20, PMP.scala:59:31, :60:23
  wire [29:0] _GEN_8 = {reg_pmp_2_addr[28:0], reg_pmp_2_cfg_a[0]};	// CSR.scala:379:20, PMP.scala:59:31, :60:23
  wire [29:0] _GEN_9 = {reg_pmp_3_addr[28:0], reg_pmp_3_cfg_a[0]};	// CSR.scala:379:20, PMP.scala:59:31, :60:23
  wire [29:0] _GEN_10 = {reg_pmp_4_addr[28:0], reg_pmp_4_cfg_a[0]};	// CSR.scala:379:20, PMP.scala:59:31, :60:23
  wire [29:0] _GEN_11 = {reg_pmp_5_addr[28:0], reg_pmp_5_cfg_a[0]};	// CSR.scala:379:20, PMP.scala:59:31, :60:23
  wire [29:0] _GEN_12 = {reg_pmp_6_addr[28:0], reg_pmp_6_cfg_a[0]};	// CSR.scala:379:20, PMP.scala:59:31, :60:23
  wire [29:0] _GEN_13 = {reg_pmp_7_addr[28:0], reg_pmp_7_cfg_a[0]};	// CSR.scala:379:20, PMP.scala:59:31, :60:23
  reg  [63:0] reg_misa;	// CSR.scala:490:21
  wire [31:0] read_mtvec_lo = reg_mtvec & {24'hFFFFFF, ~(reg_mtvec[0] ? 8'hFE : 8'h2)};	// Bitwise.scala:72:12, CSR.scala:315:55, :397:27, :1206:{39,41}, package.scala:165:{35,37,41}
  wire [38:0] read_stvec_lo = reg_stvec & {31'h7FFFFFFF, ~(reg_stvec[0] ? 8'hFE : 8'h2)};	// CSR.scala:425:22, :1154:28, :1206:{39,41}, PMP.scala:60:16, package.scala:165:{35,37,41}
  wire [39:0] _io_evec_T_15 = ~reg_mepc;	// CSR.scala:391:21, :1205:28
  wire [1:0]  _GEN_14 = {~(reg_misa[2]), 1'h1};	// CSR.scala:325:24, :490:21, :1205:{36,45}
  wire [39:0] lo_4 = ~{_io_evec_T_15[39:2], _io_evec_T_15[1:0] | _GEN_14};	// CSR.scala:1205:{26,28,31,36}
  wire [39:0] _io_evec_T_5 = ~reg_dpc;	// CSR.scala:369:20, :1205:28
  wire [39:0] lo_6 = ~{_io_evec_T_5[39:2], _io_evec_T_5[1:0] | _GEN_14};	// CSR.scala:1205:{26,28,31,36}
  wire [39:0] _io_evec_T = ~reg_sepc;	// CSR.scala:421:21, :1205:28
  wire [39:0] lo_8 = ~{_io_evec_T[39:2], _io_evec_T[1:0] | _GEN_14};	// CSR.scala:1205:{26,28,31,36}
  reg  [63:0] reg_custom_0;	// CSR.scala:628:43
  wire        _GEN_15 = io_rw_addr == 12'h7A1;	// CSR.scala:636:73
  wire        _GEN_16 = io_rw_addr == 12'h7A2;	// CSR.scala:636:73
  wire        _GEN_17 = io_rw_addr == 12'h301;	// CSR.scala:636:73
  wire        _GEN_18 = io_rw_addr == 12'h300;	// CSR.scala:636:73
  wire        _GEN_19 = io_rw_addr == 12'h305;	// CSR.scala:636:73
  wire        _GEN_20 = io_rw_addr == 12'h344;	// CSR.scala:636:73
  wire        _GEN_21 = io_rw_addr == 12'h304;	// CSR.scala:636:73
  wire        _GEN_22 = io_rw_addr == 12'h340;	// CSR.scala:636:73
  wire        _GEN_23 = io_rw_addr == 12'h341;	// CSR.scala:636:73
  wire        _GEN_24 = io_rw_addr == 12'h343;	// CSR.scala:636:73
  wire        _GEN_25 = io_rw_addr == 12'h342;	// CSR.scala:636:73
  wire        _GEN_26 = io_rw_addr == 12'h7B0;	// CSR.scala:636:73
  wire        _GEN_27 = io_rw_addr == 12'h7B1;	// CSR.scala:636:73
  wire        _GEN_28 = io_rw_addr == 12'h7B2;	// CSR.scala:636:73
  wire        _GEN_29 = io_rw_addr == 12'h1;	// CSR.scala:636:73
  wire        _GEN_30 = io_rw_addr == 12'h2;	// CSR.scala:636:73
  wire        _GEN_31 = io_rw_addr == 12'h3;	// CSR.scala:636:73
  wire        _GEN_32 = io_rw_addr == 12'h320;	// CSR.scala:636:73
  wire        _GEN_33 = io_rw_addr == 12'hB00;	// CSR.scala:636:73
  wire        _GEN_34 = io_rw_addr == 12'hB02;	// CSR.scala:636:73
  wire        _GEN_35 = io_rw_addr == 12'h306;	// CSR.scala:636:73
  wire        _GEN_36 = io_rw_addr == 12'h100;	// CSR.scala:636:73
  wire        _GEN_37 = io_rw_addr == 12'h144;	// CSR.scala:636:73
  wire        _GEN_38 = io_rw_addr == 12'h104;	// CSR.scala:636:73
  wire        _GEN_39 = io_rw_addr == 12'h140;	// CSR.scala:636:73
  wire        _GEN_40 = io_rw_addr == 12'h142;	// CSR.scala:636:73
  wire        _GEN_41 = io_rw_addr == 12'h143;	// CSR.scala:636:73
  wire        _GEN_42 = io_rw_addr == 12'h180;	// CSR.scala:636:73
  wire        _GEN_43 = io_rw_addr == 12'h141;	// CSR.scala:636:73
  wire        _GEN_44 = io_rw_addr == 12'h105;	// CSR.scala:636:73
  wire        _GEN_45 = io_rw_addr == 12'h106;	// CSR.scala:636:73
  wire        _GEN_46 = io_rw_addr == 12'h303;	// CSR.scala:636:73
  wire        _GEN_47 = io_rw_addr == 12'h302;	// CSR.scala:636:73
  wire        _GEN_48 = io_rw_addr == 12'h3A0;	// CSR.scala:636:73
  wire        _GEN_49 = io_rw_addr == 12'h3B0;	// CSR.scala:636:73
  wire        _GEN_50 = io_rw_addr == 12'h3B1;	// CSR.scala:636:73
  wire        _GEN_51 = io_rw_addr == 12'h3B2;	// CSR.scala:636:73
  wire        _GEN_52 = io_rw_addr == 12'h3B3;	// CSR.scala:636:73
  wire        _GEN_53 = io_rw_addr == 12'h3B4;	// CSR.scala:636:73
  wire        _GEN_54 = io_rw_addr == 12'h3B5;	// CSR.scala:636:73
  wire        _GEN_55 = io_rw_addr == 12'h3B6;	// CSR.scala:636:73
  wire        _GEN_56 = io_rw_addr == 12'h3B7;	// CSR.scala:636:73
  wire        _GEN_57 = io_rw_addr == 12'h7C1;	// CSR.scala:636:73
  wire [63:0] _wdata_T_2 = (io_rw_cmd[1] ? _io_rw_rdata_WIRE : 64'h0) | io_rw_wdata;	// CSR.scala:392:27, :1183:{9,13,34}, Mux.scala:27:72
  wire [63:0] _wdata_T_6 = ~((&(io_rw_cmd[1:0])) ? io_rw_wdata : 64'h0);	// CSR.scala:392:27, :1183:{45,49,53,59}
  wire        system_insn = io_rw_cmd == 3'h4;	// CSR.scala:639:31, Mux.scala:47:69
  wire [1:0]  _GEN_58 = {io_rw_addr[8], io_rw_addr[0]};	// CSR.scala:652:28
  wire        insn_call = system_insn & _GEN_58 == 2'h0;	// CSR.scala:639:31, :652:{28,95}, Decode.scala:14:121
  wire        insn_break = system_insn & _GEN_58 == 2'h1;	// CSR.scala:639:31, :652:{28,95}, :859:21, Decode.scala:14:121
  wire        insn_ret =
    system_insn
    & ({io_rw_addr[8], io_rw_addr[5], io_rw_addr[2]} == 3'h4 | io_rw_addr[10]);	// CSR.scala:639:31, :652:{28,95}, Decode.scala:14:121, :15:30, Mux.scala:47:69
  wire        is_ret =
    {io_decode_0_csr[8], io_decode_0_csr[5], io_decode_0_csr[2]} == 3'h4
    | io_decode_0_csr[10];	// CSR.scala:659:30, Decode.scala:14:121, :15:30, Mux.scala:47:69
  wire        allow_sfence_vma = reg_mstatus_prv[1] | ~reg_mstatus_tvm;	// CSR.scala:319:24, :661:63, :662:{70,73}
  wire [31:0] _GEN_59 = {27'h0, io_decode_0_csr[4:0]};	// CSR.scala:315:55, :664:34, :665:68
  wire [31:0] _allow_counter_T_1 = _GEN_3 >> _GEN_59;	// CSR.scala:414:30, :665:68
  wire [31:0] _allow_counter_T_6 = _GEN_4 >> _GEN_59;	// CSR.scala:418:36, :665:68, :666:71
  wire        _io_decode_0_fp_illegal_output = reg_mstatus_fs == 2'h0 | ~(reg_misa[5]);	// CSR.scala:319:24, :490:21, :667:{39,45,48,57}
  wire        _io_decode_0_fp_csr_output =
    {io_decode_0_csr[11], io_decode_0_csr[8]} == 2'h0;	// CSR.scala:659:30, Decode.scala:14:{65,121}
  wire        _io_decode_0_read_illegal_T_297 = io_decode_0_csr == 12'h180;	// CSR.scala:636:73, :655:99
  wire        _io_decode_0_read_illegal_T_294 =
    io_decode_0_csr == 12'h7A0 | io_decode_0_csr == 12'h7A1 | io_decode_0_csr == 12'h7A2
    | io_decode_0_csr == 12'h7A3 | io_decode_0_csr == 12'h301 | io_decode_0_csr == 12'h300
    | io_decode_0_csr == 12'h305 | io_decode_0_csr == 12'h344 | io_decode_0_csr == 12'h304
    | io_decode_0_csr == 12'h340 | io_decode_0_csr == 12'h341 | io_decode_0_csr == 12'h343
    | io_decode_0_csr == 12'h342 | io_decode_0_csr == 12'hF14 | io_decode_0_csr == 12'h7B0
    | io_decode_0_csr == 12'h7B1 | io_decode_0_csr == 12'h7B2 | io_decode_0_csr == 12'h1
    | io_decode_0_csr == 12'h2 | io_decode_0_csr == 12'h3 | io_decode_0_csr == 12'h320
    | io_decode_0_csr == 12'hB00 | io_decode_0_csr == 12'hB02 | io_decode_0_csr == 12'h323
    | io_decode_0_csr == 12'hB03 | io_decode_0_csr == 12'hC03 | io_decode_0_csr == 12'h324
    | io_decode_0_csr == 12'hB04 | io_decode_0_csr == 12'hC04 | io_decode_0_csr == 12'h325
    | io_decode_0_csr == 12'hB05 | io_decode_0_csr == 12'hC05 | io_decode_0_csr == 12'h326
    | io_decode_0_csr == 12'hB06 | io_decode_0_csr == 12'hC06 | io_decode_0_csr == 12'h327
    | io_decode_0_csr == 12'hB07 | io_decode_0_csr == 12'hC07 | io_decode_0_csr == 12'h328
    | io_decode_0_csr == 12'hB08 | io_decode_0_csr == 12'hC08 | io_decode_0_csr == 12'h329
    | io_decode_0_csr == 12'hB09 | io_decode_0_csr == 12'hC09 | io_decode_0_csr == 12'h32A
    | io_decode_0_csr == 12'hB0A | io_decode_0_csr == 12'hC0A | io_decode_0_csr == 12'h32B
    | io_decode_0_csr == 12'hB0B | io_decode_0_csr == 12'hC0B | io_decode_0_csr == 12'h32C
    | io_decode_0_csr == 12'hB0C | io_decode_0_csr == 12'hC0C | io_decode_0_csr == 12'h32D
    | io_decode_0_csr == 12'hB0D | io_decode_0_csr == 12'hC0D | io_decode_0_csr == 12'h32E
    | io_decode_0_csr == 12'hB0E | io_decode_0_csr == 12'hC0E | io_decode_0_csr == 12'h32F
    | io_decode_0_csr == 12'hB0F | io_decode_0_csr == 12'hC0F | io_decode_0_csr == 12'h330
    | io_decode_0_csr == 12'hB10 | io_decode_0_csr == 12'hC10 | io_decode_0_csr == 12'h331
    | io_decode_0_csr == 12'hB11 | io_decode_0_csr == 12'hC11 | io_decode_0_csr == 12'h332
    | io_decode_0_csr == 12'hB12 | io_decode_0_csr == 12'hC12 | io_decode_0_csr == 12'h333
    | io_decode_0_csr == 12'hB13 | io_decode_0_csr == 12'hC13 | io_decode_0_csr == 12'h334
    | io_decode_0_csr == 12'hB14 | io_decode_0_csr == 12'hC14 | io_decode_0_csr == 12'h335
    | io_decode_0_csr == 12'hB15 | io_decode_0_csr == 12'hC15 | io_decode_0_csr == 12'h336
    | io_decode_0_csr == 12'hB16 | io_decode_0_csr == 12'hC16 | io_decode_0_csr == 12'h337
    | io_decode_0_csr == 12'hB17 | io_decode_0_csr == 12'hC17 | io_decode_0_csr == 12'h338
    | io_decode_0_csr == 12'hB18 | io_decode_0_csr == 12'hC18 | io_decode_0_csr == 12'h339
    | io_decode_0_csr == 12'hB19 | io_decode_0_csr == 12'hC19 | io_decode_0_csr == 12'h33A
    | io_decode_0_csr == 12'hB1A | io_decode_0_csr == 12'hC1A | io_decode_0_csr == 12'h33B
    | io_decode_0_csr == 12'hB1B | io_decode_0_csr == 12'hC1B | io_decode_0_csr == 12'h33C
    | io_decode_0_csr == 12'hB1C | io_decode_0_csr == 12'hC1C | io_decode_0_csr == 12'h33D
    | io_decode_0_csr == 12'hB1D | io_decode_0_csr == 12'hC1D | io_decode_0_csr == 12'h33E
    | io_decode_0_csr == 12'hB1E | io_decode_0_csr == 12'hC1E | io_decode_0_csr == 12'h33F
    | io_decode_0_csr == 12'hB1F | io_decode_0_csr == 12'hC1F | io_decode_0_csr == 12'h306
    | io_decode_0_csr == 12'hC00 | io_decode_0_csr == 12'hC02 | io_decode_0_csr == 12'h100
    | io_decode_0_csr == 12'h144 | io_decode_0_csr == 12'h104 | io_decode_0_csr == 12'h140
    | io_decode_0_csr == 12'h142 | io_decode_0_csr == 12'h143
    | _io_decode_0_read_illegal_T_297 | io_decode_0_csr == 12'h141
    | io_decode_0_csr == 12'h105 | io_decode_0_csr == 12'h106 | io_decode_0_csr == 12'h303
    | io_decode_0_csr == 12'h302 | io_decode_0_csr == 12'h3A0 | io_decode_0_csr == 12'h3A2
    | io_decode_0_csr == 12'h3B0 | io_decode_0_csr == 12'h3B1 | io_decode_0_csr == 12'h3B2
    | io_decode_0_csr == 12'h3B3 | io_decode_0_csr == 12'h3B4 | io_decode_0_csr == 12'h3B5
    | io_decode_0_csr == 12'h3B6 | io_decode_0_csr == 12'h3B7 | io_decode_0_csr == 12'h3B8
    | io_decode_0_csr == 12'h3B9 | io_decode_0_csr == 12'h3BA | io_decode_0_csr == 12'h3BB
    | io_decode_0_csr == 12'h3BC | io_decode_0_csr == 12'h3BD | io_decode_0_csr == 12'h3BE
    | io_decode_0_csr == 12'h3BF | io_decode_0_csr == 12'h7C1 | io_decode_0_csr == 12'hF12
    | io_decode_0_csr == 12'hF11 | io_decode_0_csr == 12'hF13;	// CSR.scala:636:73, :655:{99,115}
  wire [3:0]  _GEN_60 = {2'h0, reg_mstatus_prv};	// CSR.scala:319:24, :688:36
  wire [63:0] _GEN_61 = {60'h0, _GEN_60 - 4'h8};	// CSR.scala:688:{8,36}
  wire [63:0] cause = insn_call ? _GEN_61 : insn_break ? 64'h3 : io_cause;	// CSR.scala:652:95, :688:8, :689:14
  wire        _causeIsDebugTrigger_T_2 = cause[7:0] == 8'hE;	// CSR.scala:688:8, :690:25, :691:53
  wire        causeIsDebugInt = cause[63] & _causeIsDebugTrigger_T_2;	// CSR.scala:688:8, :691:{30,39,53}
  wire        causeIsDebugTrigger = ~(cause[63]) & _causeIsDebugTrigger_T_2;	// CSR.scala:688:8, :691:{30,53}, :692:{29,44}
  wire [3:0]  _causeIsDebugBreak_T_4 =
    {reg_dcsr_ebreakm, 1'h0, reg_dcsr_ebreaks, reg_dcsr_ebreaku} >> _GEN_60;	// CSR.scala:327:21, :688:36, :693:134, :729:74, Cat.scala:30:58
  wire        trapToDebug =
    reg_singleStepped | causeIsDebugInt | causeIsDebugTrigger | ~(cause[63]) & insn_break
    & _causeIsDebugBreak_T_4[0] | reg_debug;	// CSR.scala:368:22, :372:30, :652:95, :688:8, :691:{30,39}, :692:44, :693:{27,56,134}, :694:123
  wire [63:0] _GEN_62 = {56'h0, cause[7:0]};	// CSR.scala:688:8, :690:25, :698:102
  wire [63:0] _delegate_T_3 = _GEN_1 >> _GEN_62;	// CSR.scala:384:36, :698:102
  wire [63:0] _delegate_T_5 = _GEN_2 >> _GEN_62;	// CSR.scala:388:36, :698:{102,128}
  wire        delegate =
    ~(reg_mstatus_prv[1]) & (cause[63] ? _delegate_T_3[0] : _delegate_T_5[0]);	// CSR.scala:319:24, :464:51, :688:8, :691:30, :698:{68,74,102,128}
  wire [39:0] notDebugTVec_base =
    delegate ? {reg_stvec[38], read_stvec_lo} : {8'h0, read_mtvec_lo};	// CSR.scala:315:55, :425:22, :698:68, :705:19, Cat.scala:30:58, package.scala:123:38, :165:35
  wire        _exception_T = insn_call | insn_break;	// CSR.scala:652:95, :726:24
  assign _io_singleStep_output = reg_dcsr_step & ~reg_debug;	// CSR.scala:327:21, :368:22, :675:45, :727:34
  reg  [1:0]  io_status_dprv_REG;	// CSR.scala:734:24
  wire        _io_trace_0_exception_output = _exception_T | io_exception;	// CSR.scala:726:24, :738:43
  `ifndef SYNTHESIS	// CSR.scala:739:9
    always @(posedge clock) begin	// CSR.scala:739:9
      if (~({1'h0, {1'h0, insn_ret} + {1'h0, insn_call}}
            + {1'h0, {1'h0, insn_break} + {1'h0, io_exception}} < 3'h2 | reset)) begin	// Bitwise.scala:47:55, CSR.scala:652:95, :729:74, :739:{9,79}
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
  wire [1:0]  _GEN_63 = {~delegate, 1'h1};	// CSR.scala:325:24, :421:21, :698:68, :755:24, :763:31, :772:35, :780:15, :789:15
  wire [1:0]  _GEN_64 = {1'h0, reg_mstatus_spp};	// CSR.scala:319:24, :729:74, :819:15
  wire        _GEN_65 = io_rw_addr[10] & io_rw_addr[7];	// CSR.scala:652:28, :821:{52,65}
  wire [1:0]  ret_prv =
    io_rw_addr[9] ? (_GEN_65 ? reg_dcsr_prv : reg_mstatus_mpp) : _GEN_64;	// CSR.scala:319:24, :327:21, :652:28, :815:52, :819:15, :821:{52,70}, :822:15, :825:69
  wire        _io_csr_stall_output = reg_wfi | io_status_cease_r;	// CSR.scala:427:50, :845:27, Reg.scala:27:20
  wire [63:0] _io_rw_rdata_T_152 =
    (_GEN_15
       ? {4'h2,
          reg_bp_0_control_dmode,
          46'h40000000000,
          reg_bp_0_control_action,
          reg_bp_0_control_chain,
          2'h0,
          reg_bp_0_control_tmatch,
          reg_bp_0_control_m,
          1'h0,
          reg_bp_0_control_s,
          reg_bp_0_control_u,
          reg_bp_0_control_x,
          reg_bp_0_control_w,
          reg_bp_0_control_r}
       : 64'h0) | (_GEN_16 ? {{25{reg_bp_0_address[38]}}, reg_bp_0_address} : 64'h0)
    | (_GEN_17 ? reg_misa : 64'h0)
    | (_GEN_18
         ? {&reg_mstatus_fs,
            40'h1400,
            reg_mstatus_tsr,
            reg_mstatus_tw,
            reg_mstatus_tvm,
            reg_mstatus_mxr,
            reg_mstatus_sum,
            reg_mstatus_mprv,
            2'h0,
            reg_mstatus_fs,
            reg_mstatus_mpp,
            2'h0,
            reg_mstatus_spp,
            reg_mstatus_mpie,
            1'h0,
            reg_mstatus_spie,
            1'h0,
            reg_mstatus_mie,
            1'h0,
            reg_mstatus_sie,
            1'h0}
         : 64'h0) | (_GEN_19 ? {32'h0, read_mtvec_lo} : 64'h0);	// Bitwise.scala:72:12, CSR.scala:315:55, :319:24, :378:19, :392:27, :490:21, :491:{38,40}, :497:48, :599:57, :636:73, :729:{32,74}, :1058:67, Cat.scala:30:58, Mux.scala:27:72, package.scala:123:38, :165:35
  wire [63:0] _io_rw_rdata_T_158 =
    {_io_rw_rdata_T_152[63:16], _io_rw_rdata_T_152[15:0] | (_GEN_20 ? read_mip : 16'h0)}
    | (_GEN_21 ? reg_mie : 64'h0) | (_GEN_22 ? reg_mscratch : 64'h0)
    | (_GEN_23 ? {{24{lo_4[39]}}, lo_4} : 64'h0)
    | (_GEN_24 ? {{24{reg_mtval[39]}}, reg_mtval} : 64'h0)
    | (_GEN_25 ? reg_mcause : 64'h0);	// Bitwise.scala:72:12, CSR.scala:381:20, :392:27, :393:22, :394:25, :454:22, :636:73, :1205:26, Cat.scala:30:58, Mux.scala:27:72, package.scala:123:38
  wire [63:0] _io_rw_rdata_T_162 =
    {_io_rw_rdata_T_158[63:32],
     {_io_rw_rdata_T_158[31:3],
      _io_rw_rdata_T_158[2:0] | (io_rw_addr == 12'hF14 ? io_hartid : 3'h0)}
       | (_GEN_26
            ? {16'h4000,
               reg_dcsr_ebreakm,
               1'h0,
               reg_dcsr_ebreaks,
               reg_dcsr_ebreaku,
               3'h0,
               reg_dcsr_cause,
               3'h0,
               reg_dcsr_step,
               reg_dcsr_prv}
            : 32'h0)} | (_GEN_27 ? {{24{lo_6[39]}}, lo_6} : 64'h0)
    | (_GEN_28 ? reg_dscratch : 64'h0);	// Bitwise.scala:72:12, CSR.scala:315:55, :324:49, :327:21, :370:25, :392:27, :512:27, :636:73, :729:74, :1205:26, Cat.scala:30:58, Mux.scala:27:72, package.scala:123:38
  wire [4:0]  _GEN_66 = _io_rw_rdata_T_162[4:0] | (_GEN_29 ? reg_fflags : 5'h0);	// CSR.scala:429:23, :636:73, Mux.scala:27:72
  wire [7:0]  _GEN_67 =
    {_io_rw_rdata_T_162[7:5], _GEN_66[4:3], _GEN_66[2:0] | (_GEN_30 ? reg_frm : 3'h0)}
    | (_GEN_31 ? {reg_frm, reg_fflags} : 8'h0);	// CSR.scala:315:55, :324:49, :429:23, :430:20, :636:73, Cat.scala:30:58, Mux.scala:27:72
  wire [63:0] _io_rw_rdata_T_255 =
    {_io_rw_rdata_T_162[63:8],
     _GEN_67[7:3],
     _GEN_67[2:0] | (_GEN_32 ? reg_mcountinhibit : 3'h0)} | (_GEN_33 ? value_1 : 64'h0)
    | (_GEN_34 ? value : 64'h0);	// CSR.scala:324:49, :392:27, :436:34, :636:73, Cat.scala:30:58, Mux.scala:27:72
  wire [63:0] _io_rw_rdata_T_267 =
    {_io_rw_rdata_T_255[63:32], _io_rw_rdata_T_255[31:0] | (_GEN_35 ? _GEN_3 : 32'h0)}
    | (io_rw_addr == 12'hC00 ? value_1 : 64'h0) | (io_rw_addr == 12'hC02 ? value : 64'h0)
    | (_GEN_36
         ? {&reg_mstatus_fs,
            43'h2000,
            reg_mstatus_mxr,
            reg_mstatus_sum,
            3'h0,
            reg_mstatus_fs,
            4'h0,
            reg_mstatus_spp,
            2'h0,
            reg_mstatus_spie,
            3'h0,
            reg_mstatus_sie,
            1'h0}
         : 64'h0) | (_GEN_37 ? {48'h0, read_mip & _GEN_0} : 64'h0)
    | (_GEN_38 ? {48'h0, reg_mie[15:0] & _GEN_0} : 64'h0)
    | (_GEN_39 ? reg_sscratch : 64'h0) | (_GEN_40 ? reg_scause : 64'h0)
    | (_GEN_41 ? {{24{reg_stval[39]}}, reg_stval} : 64'h0)
    | (_GEN_42 ? {reg_satp_mode, 16'h0, reg_satp_ppn} : 64'h0)
    | (_GEN_43 ? {{24{lo_8[39]}}, lo_8} : 64'h0)
    | (_GEN_44 ? {{25{reg_stvec[38]}}, read_stvec_lo} : 64'h0);	// Bitwise.scala:72:12, CSR.scala:315:55, :319:24, :324:49, :378:19, :381:20, :384:36, :392:27, :414:30, :422:23, :423:22, :424:25, :425:22, :426:21, :454:22, :457:56, :584:28, :585:29, :599:{57,60}, :605:43, :636:73, :729:{32,74}, :1205:26, Cat.scala:30:58, Mux.scala:27:72, package.scala:123:38, :165:35
  wire [63:0] _io_rw_rdata_T_272 =
    {_io_rw_rdata_T_267[63:32], _io_rw_rdata_T_267[31:0] | (_GEN_45 ? _GEN_4 : 32'h0)}
    | (_GEN_46 ? _GEN_1 : 64'h0) | (_GEN_47 ? _GEN_2 : 64'h0)
    | (_GEN_48
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
         : 64'h0);	// CSR.scala:315:55, :379:20, :384:36, :388:36, :392:27, :418:36, :636:73, Cat.scala:30:58, Mux.scala:27:72
  wire [29:0] _GEN_68 =
    _io_rw_rdata_T_272[29:0] | (_GEN_49 ? reg_pmp_0_addr : 30'h0)
    | (_GEN_50 ? reg_pmp_1_addr : 30'h0) | (_GEN_51 ? reg_pmp_2_addr : 30'h0)
    | (_GEN_52 ? reg_pmp_3_addr : 30'h0) | (_GEN_53 ? reg_pmp_4_addr : 30'h0)
    | (_GEN_54 ? reg_pmp_5_addr : 30'h0) | (_GEN_55 ? reg_pmp_6_addr : 30'h0)
    | (_GEN_56 ? reg_pmp_7_addr : 30'h0);	// CSR.scala:379:20, :617:59, :636:73, Mux.scala:27:72
  assign _io_rw_rdata_WIRE =
    (_GEN_57 ? reg_custom_0 : 64'h0)
    | {_io_rw_rdata_T_272[63:30], _GEN_68[29:1], _GEN_68[0] | io_rw_addr == 12'hF12}
    | (io_rw_addr == 12'hF13 ? 64'h20181004 : 64'h0);	// CSR.scala:392:27, :628:43, :636:73, Mux.scala:27:72
  wire        csr_wen = io_rw_cmd == 3'h6 | (&io_rw_cmd) | io_rw_cmd == 3'h5;	// CSR.scala:794:118, Mux.scala:47:69, package.scala:15:47, :72:59
  wire [5:0]  _GEN_69 = _wdata_T_2[5:0] & _wdata_T_6[5:0];	// CSR.scala:1183:{34,43,45}, Counters.scala:65:11
  always @(posedge clock) begin
    automatic logic [63:0] _reg_bp_0_control_WIRE_1;	// CSR.scala:1183:43
    automatic logic [39:0] epc;	// CSR.scala:1204:31
    automatic logic        _GEN_70;	// CSR.scala:368:22, :754:20, :755:24, :756:25, :757:19
    automatic logic        _GEN_71;	// CSR.scala:421:21, :754:20, :755:24
    automatic logic        _GEN_72;	// CSR.scala:391:21, :754:20, :755:24
    automatic logic [8:0]  _new_mip_WIRE;	// CSR.scala:1183:43
    automatic logic [39:0] _GEN_73;	// CSR.scala:945:51
    automatic logic [31:0] _new_dcsr_WIRE;	// CSR.scala:948:52, :1183:43
    automatic logic [2:0]  _GEN_74;	// CSR.scala:965:{67,76}, :1183:43
    automatic logic [38:0] _GEN_75;	// CSR.scala:1025:54, :1183:43
    automatic logic        _GEN_76;	// CSR.scala:1039:55
    automatic logic        _GEN_77;	// CSR.scala:378:19, :897:18, :1039:70, :1051:44, :1052:24
    automatic logic [7:0]  _newCfg_WIRE;	// CSR.scala:1183:43
    automatic logic        _GEN_78;	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
    automatic logic [29:0] _GEN_79;	// CSR.scala:1081:18, :1183:43
    automatic logic [7:0]  _newCfg_WIRE_1;	// CSR.scala:1072:53, :1183:43
    automatic logic        _GEN_80;	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
    automatic logic [7:0]  _newCfg_WIRE_2;	// CSR.scala:1072:53, :1183:43
    automatic logic        _GEN_81;	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
    automatic logic [7:0]  _newCfg_WIRE_3;	// CSR.scala:1072:53, :1183:43
    automatic logic        _GEN_82;	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
    automatic logic [7:0]  _newCfg_WIRE_4;	// CSR.scala:1072:53, :1183:43
    automatic logic        _GEN_83;	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
    automatic logic [7:0]  _newCfg_WIRE_5;	// CSR.scala:1072:53, :1183:43
    automatic logic        _GEN_84;	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
    automatic logic [7:0]  _newCfg_WIRE_6;	// CSR.scala:1072:53, :1183:43
    automatic logic        _GEN_85;	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
    automatic logic        _GEN_86;	// PMP.scala:51:62
    automatic logic [7:0]  _newCfg_WIRE_7;	// CSR.scala:1072:53, :1183:43
    automatic logic        _GEN_87;	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
    _reg_bp_0_control_WIRE_1 = _wdata_T_2 & _wdata_T_6;	// CSR.scala:1183:{34,43,45}
    epc = {io_pc[39:1], 1'h0};	// CSR.scala:729:74, :1204:31
    _GEN_70 = _io_trace_0_exception_output & trapToDebug & ~reg_debug;	// CSR.scala:368:22, :675:45, :694:123, :738:43, :754:20, :755:24, :756:25, :757:19
    _GEN_71 = ~_io_trace_0_exception_output | trapToDebug | ~delegate;	// CSR.scala:421:21, :694:123, :698:68, :738:43, :754:20, :755:24, :763:31
    _GEN_72 = ~_io_trace_0_exception_output | trapToDebug | delegate;	// CSR.scala:391:21, :421:21, :694:123, :698:68, :738:43, :754:20, :755:24
    _new_mip_WIRE =
      ((io_rw_cmd[1] ? {reg_mip_seip, 3'h0, reg_mip_stip, 3'h0, reg_mip_ssip} : 9'h0)
       | io_rw_wdata[9:1]) & ~((&(io_rw_cmd[1:0])) ? io_rw_wdata[9:1] : 9'h0);	// CSR.scala:324:49, :390:20, :937:59, :1183:{9,13,34,43,45,49,53,59}, Mux.scala:27:72
    _GEN_73 = {_reg_bp_0_control_WIRE_1[39:1], 1'h0};	// CSR.scala:729:74, :945:51, :1183:43
    _new_dcsr_WIRE = _wdata_T_2[31:0] & _wdata_T_6[31:0];	// CSR.scala:948:52, :1183:{34,43,45}
    _GEN_74 = _wdata_T_2[2:0] & _wdata_T_6[2:0];	// CSR.scala:965:{67,76}, :1183:{34,43,45}
    _GEN_75 = _wdata_T_2[38:0] & _wdata_T_6[38:0];	// CSR.scala:1025:54, :1183:{34,43,45}
    _GEN_76 = ~reg_bp_0_control_dmode | reg_debug;	// CSR.scala:368:22, :378:19, :1039:{37,55}
    _GEN_77 = csr_wen & _GEN_76 & _GEN_15;	// CSR.scala:378:19, :636:73, :897:18, :1039:{55,70}, :1051:44, :1052:24, package.scala:72:59
    _newCfg_WIRE = _wdata_T_2[7:0] & _wdata_T_6[7:0];	// CSR.scala:1183:{34,43,45}
    _GEN_78 = csr_wen & _GEN_48 & ~reg_pmp_0_cfg_l;	// CSR.scala:379:20, :636:73, :897:18, :1071:{60,76}, :1073:17, package.scala:72:59
    _GEN_79 = _wdata_T_2[29:0] & _wdata_T_6[29:0];	// CSR.scala:1081:18, :1183:{34,43,45}
    _newCfg_WIRE_1 = _wdata_T_2[15:8] & _wdata_T_6[15:8];	// CSR.scala:1072:53, :1183:{34,43,45}
    _GEN_80 = csr_wen & _GEN_48 & ~reg_pmp_1_cfg_l;	// CSR.scala:379:20, :636:73, :897:18, :1071:{60,76}, :1073:17, package.scala:72:59
    _newCfg_WIRE_2 = _wdata_T_2[23:16] & _wdata_T_6[23:16];	// CSR.scala:1072:53, :1183:{34,43,45}
    _GEN_81 = csr_wen & _GEN_48 & ~reg_pmp_2_cfg_l;	// CSR.scala:379:20, :636:73, :897:18, :1071:{60,76}, :1073:17, package.scala:72:59
    _newCfg_WIRE_3 = _wdata_T_2[31:24] & _wdata_T_6[31:24];	// CSR.scala:1072:53, :1183:{34,43,45}
    _GEN_82 = csr_wen & _GEN_48 & ~reg_pmp_3_cfg_l;	// CSR.scala:379:20, :636:73, :897:18, :1071:{60,76}, :1073:17, package.scala:72:59
    _newCfg_WIRE_4 = _wdata_T_2[39:32] & _wdata_T_6[39:32];	// CSR.scala:1072:53, :1183:{34,43,45}
    _GEN_83 = csr_wen & _GEN_48 & ~reg_pmp_4_cfg_l;	// CSR.scala:379:20, :636:73, :897:18, :1071:{60,76}, :1073:17, package.scala:72:59
    _newCfg_WIRE_5 = _wdata_T_2[47:40] & _wdata_T_6[47:40];	// CSR.scala:1072:53, :1183:{34,43,45}
    _GEN_84 = csr_wen & _GEN_48 & ~reg_pmp_5_cfg_l;	// CSR.scala:379:20, :636:73, :897:18, :1071:{60,76}, :1073:17, package.scala:72:59
    _newCfg_WIRE_6 = _wdata_T_2[55:48] & _wdata_T_6[55:48];	// CSR.scala:1072:53, :1183:{34,43,45}
    _GEN_85 = csr_wen & _GEN_48 & ~reg_pmp_6_cfg_l;	// CSR.scala:379:20, :636:73, :897:18, :1071:{60,76}, :1073:17, package.scala:72:59
    _GEN_86 = reg_pmp_7_cfg_l & ~(reg_pmp_7_cfg_a[1]) & reg_pmp_7_cfg_a[0];	// CSR.scala:379:20, PMP.scala:47:20, :48:26, :49:13, :51:62
    _newCfg_WIRE_7 = _wdata_T_2[63:56] & _wdata_T_6[63:56];	// CSR.scala:1072:53, :1183:{34,43,45}
    _GEN_87 = csr_wen & _GEN_48 & ~reg_pmp_7_cfg_l;	// CSR.scala:379:20, :636:73, :897:18, :1071:{60,76}, :1073:17, package.scala:72:59
    if (reset) begin
      reg_mstatus_prv <= 2'h3;	// CSR.scala:316:21, :319:24
      reg_mstatus_tsr <= 1'h0;	// CSR.scala:319:24, :729:74
      reg_mstatus_tw <= 1'h0;	// CSR.scala:319:24, :729:74
      reg_mstatus_tvm <= 1'h0;	// CSR.scala:319:24, :729:74
      reg_mstatus_mxr <= 1'h0;	// CSR.scala:319:24, :729:74
      reg_mstatus_sum <= 1'h0;	// CSR.scala:319:24, :729:74
      reg_mstatus_mprv <= 1'h0;	// CSR.scala:319:24, :729:74
      reg_mstatus_fs <= 2'h0;	// CSR.scala:319:24
      reg_mstatus_mpp <= 2'h3;	// CSR.scala:316:21, :319:24
      reg_mstatus_spp <= 1'h0;	// CSR.scala:319:24, :729:74
      reg_mstatus_mpie <= 1'h0;	// CSR.scala:319:24, :729:74
      reg_mstatus_spie <= 1'h0;	// CSR.scala:319:24, :729:74
      reg_mstatus_mie <= 1'h0;	// CSR.scala:319:24, :729:74
      reg_mstatus_sie <= 1'h0;	// CSR.scala:319:24, :729:74
      reg_dcsr_ebreakm <= 1'h0;	// CSR.scala:327:21, :729:74
      reg_dcsr_ebreaks <= 1'h0;	// CSR.scala:327:21, :729:74
      reg_dcsr_ebreaku <= 1'h0;	// CSR.scala:327:21, :729:74
      reg_dcsr_cause <= 3'h0;	// CSR.scala:324:49, :327:21
      reg_dcsr_step <= 1'h0;	// CSR.scala:327:21, :729:74
      reg_dcsr_prv <= 2'h3;	// CSR.scala:316:21, :327:21
      reg_debug <= 1'h0;	// CSR.scala:368:22, :729:74
      reg_bp_0_control_dmode <= 1'h0;	// CSR.scala:378:19, :729:74
      reg_bp_0_control_action <= 1'h0;	// CSR.scala:378:19, :729:74
      reg_bp_0_control_x <= 1'h0;	// CSR.scala:378:19, :729:74
      reg_bp_0_control_w <= 1'h0;	// CSR.scala:378:19, :729:74
      reg_bp_0_control_r <= 1'h0;	// CSR.scala:378:19, :729:74
      reg_pmp_0_cfg_l <= 1'h0;	// CSR.scala:379:20, :729:74
      reg_pmp_0_cfg_a <= 2'h0;	// CSR.scala:379:20
      reg_pmp_1_cfg_l <= 1'h0;	// CSR.scala:379:20, :729:74
      reg_pmp_1_cfg_a <= 2'h0;	// CSR.scala:379:20
      reg_pmp_2_cfg_l <= 1'h0;	// CSR.scala:379:20, :729:74
      reg_pmp_2_cfg_a <= 2'h0;	// CSR.scala:379:20
      reg_pmp_3_cfg_l <= 1'h0;	// CSR.scala:379:20, :729:74
      reg_pmp_3_cfg_a <= 2'h0;	// CSR.scala:379:20
      reg_pmp_4_cfg_l <= 1'h0;	// CSR.scala:379:20, :729:74
      reg_pmp_4_cfg_a <= 2'h0;	// CSR.scala:379:20
      reg_pmp_5_cfg_l <= 1'h0;	// CSR.scala:379:20, :729:74
      reg_pmp_5_cfg_a <= 2'h0;	// CSR.scala:379:20
      reg_pmp_6_cfg_l <= 1'h0;	// CSR.scala:379:20, :729:74
      reg_pmp_6_cfg_a <= 2'h0;	// CSR.scala:379:20
      reg_pmp_7_cfg_l <= 1'h0;	// CSR.scala:379:20, :729:74
      reg_pmp_7_cfg_a <= 2'h0;	// CSR.scala:379:20
      reg_mcause <= 64'h0;	// CSR.scala:392:27
      reg_mtvec <= 32'h0;	// CSR.scala:315:55, :397:27
      reg_mcountinhibit <= 3'h0;	// CSR.scala:324:49, :436:34
      value_lo <= 6'h0;	// Counters.scala:45:37
      value_hi <= 58'h0;	// Counters.scala:50:27
      reg_misa <= 64'h800000000094112D;	// CSR.scala:490:21
      reg_custom_0 <= 64'h208;	// CSR.scala:628:43
      io_status_cease_r <= 1'h0;	// CSR.scala:729:74, Reg.scala:27:20
    end
    else begin
      automatic logic _GEN_88;	// CSR.scala:319:24, :754:20, :755:24
      automatic logic _GEN_89;	// CSR.scala:754:20, :813:19, :815:52, :816:23
      automatic logic _GEN_90;	// CSR.scala:754:20, :813:19, :815:52, :817:24
      automatic logic _GEN_91;	// CSR.scala:754:20, :813:19, :815:52, :818:23
      _GEN_88 = _GEN_71 & reg_mstatus_sie;	// CSR.scala:319:24, :421:21, :754:20, :755:24
      _GEN_89 = insn_ret & ~(io_rw_addr[9]);	// CSR.scala:652:{28,95}, :754:20, :813:19, :815:{36,52}, :816:23
      _GEN_90 = _GEN_89 | (_GEN_71 ? reg_mstatus_spie : reg_mstatus_sie);	// CSR.scala:319:24, :421:21, :754:20, :755:24, :813:19, :815:52, :816:23, :817:24
      _GEN_91 = ~_GEN_89 & (_GEN_71 ? reg_mstatus_spp : reg_mstatus_prv[0]);	// CSR.scala:319:24, :421:21, :754:20, :755:24, :778:23, :813:19, :815:52, :816:23, :818:23
      if ((insn_ret
             ? ret_prv
             : _io_trace_0_exception_output
                 ? (trapToDebug ? (reg_debug ? reg_mstatus_prv : 2'h3) : _GEN_63)
                 : reg_mstatus_prv) == 2'h2)	// CSR.scala:316:21, :319:24, :368:22, :652:95, :694:123, :738:43, :754:20, :755:24, :756:25, :761:17, :763:31, :772:35, :780:15, :789:15, :813:19, :815:52, :819:15, :821:70, :838:13, :1187:35
        reg_mstatus_prv <= 2'h0;	// CSR.scala:319:24
      else if (insn_ret) begin	// CSR.scala:652:95
        if (io_rw_addr[9]) begin	// CSR.scala:652:28, :815:47
          if (_GEN_65)	// CSR.scala:821:52
            reg_mstatus_prv <= reg_dcsr_prv;	// CSR.scala:319:24, :327:21
          else	// CSR.scala:821:52
            reg_mstatus_prv <= reg_mstatus_mpp;	// CSR.scala:319:24
        end
        else	// CSR.scala:815:47
          reg_mstatus_prv <= _GEN_64;	// CSR.scala:319:24, :819:15
      end
      else if (_io_trace_0_exception_output) begin	// CSR.scala:738:43
        if (trapToDebug) begin	// CSR.scala:694:123
          if (reg_debug) begin	// CSR.scala:368:22
          end
          else	// CSR.scala:368:22
            reg_mstatus_prv <= 2'h3;	// CSR.scala:316:21, :319:24
        end
        else	// CSR.scala:694:123
          reg_mstatus_prv <= _GEN_63;	// CSR.scala:319:24, :772:35, :780:15, :789:15
      end
      if (csr_wen & _GEN_18) begin	// CSR.scala:636:73, :813:19, :897:18, :898:39, :900:23, package.scala:72:59
        reg_mstatus_tsr <= _reg_bp_0_control_WIRE_1[22];	// CSR.scala:319:24, :899:47, :1183:43
        reg_mstatus_tw <= _reg_bp_0_control_WIRE_1[21];	// CSR.scala:319:24, :899:47, :1183:43
        reg_mstatus_tvm <= _reg_bp_0_control_WIRE_1[20];	// CSR.scala:319:24, :899:47, :1183:43
        reg_mstatus_mprv <= _reg_bp_0_control_WIRE_1[17];	// CSR.scala:319:24, :899:47, :1183:43
        if (_reg_bp_0_control_WIRE_1[12:11] == 2'h2)	// CSR.scala:899:47, :1183:43, :1187:35
          reg_mstatus_mpp <= 2'h0;	// CSR.scala:319:24
        else	// CSR.scala:1187:35
          reg_mstatus_mpp <= _reg_bp_0_control_WIRE_1[12:11];	// CSR.scala:319:24, :899:47, :1183:43
        reg_mstatus_mpie <= _reg_bp_0_control_WIRE_1[7];	// CSR.scala:319:24, :899:47, :1183:43
        reg_mstatus_mie <= _reg_bp_0_control_WIRE_1[3];	// CSR.scala:319:24, :899:47, :1183:43
      end
      else begin	// CSR.scala:813:19, :897:18, :898:39, :900:23
        automatic logic _GEN_92 = ~(io_rw_addr[9]) | _GEN_65;	// CSR.scala:652:28, :754:20, :815:{36,52}, :821:{52,70}, :825:69
        automatic logic _GEN_93 = ~insn_ret | _GEN_92;	// CSR.scala:652:95, :754:20, :813:19, :815:52, :821:70, :825:69
        reg_mstatus_mprv <= ~(insn_ret & ret_prv != 2'h3) & reg_mstatus_mprv;	// CSR.scala:316:21, :319:24, :652:95, :813:19, :815:52, :819:15, :821:70, :839:{32,41}, :840:24
        if (_GEN_93) begin	// CSR.scala:754:20, :813:19, :815:52
          if (_GEN_72) begin	// CSR.scala:319:24, :391:21, :754:20, :755:24
          end
          else	// CSR.scala:319:24, :754:20, :755:24
            reg_mstatus_mpp <= reg_mstatus_prv;	// CSR.scala:319:24
        end
        else	// CSR.scala:754:20, :813:19, :815:52
          reg_mstatus_mpp <= 2'h0;	// CSR.scala:319:24
        reg_mstatus_mpie <=
          insn_ret & ~_GEN_92 | (_GEN_72 ? reg_mstatus_mpie : reg_mstatus_mie);	// CSR.scala:319:24, :391:21, :652:95, :754:20, :755:24, :813:19, :815:52, :821:70, :825:69
        if (_GEN_93)	// CSR.scala:754:20, :813:19, :815:52
          reg_mstatus_mie <= _GEN_72 & reg_mstatus_mie;	// CSR.scala:319:24, :391:21, :754:20, :755:24
        else	// CSR.scala:754:20, :813:19, :815:52
          reg_mstatus_mie <= reg_mstatus_mpie;	// CSR.scala:319:24
      end
      if (csr_wen) begin	// package.scala:72:59
        if (_GEN_36) begin	// CSR.scala:636:73
          reg_mstatus_mxr <= _reg_bp_0_control_WIRE_1[19];	// CSR.scala:319:24, :996:49, :1183:43
          reg_mstatus_sum <= _reg_bp_0_control_WIRE_1[18];	// CSR.scala:319:24, :996:49, :1183:43
          reg_mstatus_fs <= {2{|(_reg_bp_0_control_WIRE_1[14:13])}};	// Bitwise.scala:72:12, CSR.scala:319:24, :996:49, :1183:43, :1208:73
          reg_mstatus_spp <= _reg_bp_0_control_WIRE_1[8];	// CSR.scala:319:24, :996:49, :1183:43
          reg_mstatus_spie <= _reg_bp_0_control_WIRE_1[5];	// CSR.scala:319:24, :996:49, :1183:43
          reg_mstatus_sie <= _reg_bp_0_control_WIRE_1[1];	// CSR.scala:319:24, :996:49, :1183:43
        end
        else if (_GEN_18) begin	// CSR.scala:636:73
          reg_mstatus_mxr <= _reg_bp_0_control_WIRE_1[19];	// CSR.scala:319:24, :899:47, :1183:43
          reg_mstatus_sum <= _reg_bp_0_control_WIRE_1[18];	// CSR.scala:319:24, :899:47, :1183:43
          reg_mstatus_fs <= {2{|(_reg_bp_0_control_WIRE_1[14:13])}};	// Bitwise.scala:72:12, CSR.scala:319:24, :899:47, :1183:43, :1208:73
          reg_mstatus_spp <= _reg_bp_0_control_WIRE_1[8];	// CSR.scala:319:24, :899:47, :1183:43
          reg_mstatus_spie <= _reg_bp_0_control_WIRE_1[5];	// CSR.scala:319:24, :899:47, :1183:43
          reg_mstatus_sie <= _reg_bp_0_control_WIRE_1[1];	// CSR.scala:319:24, :899:47, :1183:43
        end
        else begin	// CSR.scala:636:73
          reg_mstatus_spp <= _GEN_91;	// CSR.scala:319:24, :754:20, :813:19, :815:52, :818:23
          reg_mstatus_spie <= _GEN_90;	// CSR.scala:319:24, :754:20, :813:19, :815:52, :817:24
          if (_GEN_89)	// CSR.scala:754:20, :813:19, :815:52, :816:23
            reg_mstatus_sie <= reg_mstatus_spie;	// CSR.scala:319:24
          else	// CSR.scala:754:20, :813:19, :815:52, :816:23
            reg_mstatus_sie <= _GEN_88;	// CSR.scala:319:24, :754:20, :755:24
        end
      end
      else begin	// package.scala:72:59
        reg_mstatus_spp <= _GEN_91;	// CSR.scala:319:24, :754:20, :813:19, :815:52, :818:23
        reg_mstatus_spie <= _GEN_90;	// CSR.scala:319:24, :754:20, :813:19, :815:52, :817:24
        if (_GEN_89)	// CSR.scala:754:20, :813:19, :815:52, :816:23
          reg_mstatus_sie <= reg_mstatus_spie;	// CSR.scala:319:24
        else	// CSR.scala:754:20, :813:19, :815:52, :816:23
          reg_mstatus_sie <= _GEN_88;	// CSR.scala:319:24, :754:20, :755:24
      end
      if (csr_wen & _GEN_26) begin	// CSR.scala:327:21, :636:73, :897:18, :980:38, :982:23, package.scala:72:59
        reg_dcsr_ebreakm <= _new_dcsr_WIRE[15];	// CSR.scala:327:21, :948:52, :981:43, :1183:43
        reg_dcsr_ebreaks <= _new_dcsr_WIRE[13];	// CSR.scala:327:21, :948:52, :981:43, :1183:43
        reg_dcsr_ebreaku <= _new_dcsr_WIRE[12];	// CSR.scala:327:21, :948:52, :981:43, :1183:43
        reg_dcsr_step <= _new_dcsr_WIRE[2];	// CSR.scala:327:21, :948:52, :981:43, :1183:43
        if (_new_dcsr_WIRE[1:0] == 2'h2)	// CSR.scala:948:52, :981:43, :1183:43, :1187:35
          reg_dcsr_prv <= 2'h0;	// CSR.scala:327:21
        else	// CSR.scala:1187:35
          reg_dcsr_prv <= _new_dcsr_WIRE[1:0];	// CSR.scala:327:21, :948:52, :981:43, :1183:43
      end
      else if (_GEN_70)	// CSR.scala:368:22, :754:20, :755:24, :756:25, :757:19
        reg_dcsr_prv <= reg_mstatus_prv;	// CSR.scala:319:24, :327:21
      if (_GEN_70) begin	// CSR.scala:368:22, :754:20, :755:24, :756:25, :757:19
        if (reg_singleStepped)	// CSR.scala:372:30
          reg_dcsr_cause <= 3'h4;	// CSR.scala:327:21, Mux.scala:47:69
        else	// CSR.scala:372:30
          reg_dcsr_cause <=
            {1'h0, causeIsDebugInt ? 2'h3 : causeIsDebugTrigger ? 2'h2 : 2'h1};	// CSR.scala:316:21, :327:21, :691:39, :692:44, :729:74, :759:{30,56,86}, :859:21, :1187:35
      end
      reg_debug <= (~insn_ret | ~(io_rw_addr[9]) | ~_GEN_65) & (_GEN_70 | reg_debug);	// CSR.scala:368:22, :652:{28,95}, :754:20, :755:24, :756:25, :757:19, :813:19, :815:52, :821:{52,70}, :823:17
      if (_GEN_77) begin	// CSR.scala:378:19, :897:18, :1039:70, :1051:44, :1052:24
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
      if (_GEN_78) begin	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
        reg_pmp_0_cfg_l <= _newCfg_WIRE[7];	// CSR.scala:379:20, :1072:46, :1183:43
        reg_pmp_0_cfg_a <= _newCfg_WIRE[4:3];	// CSR.scala:379:20, :1072:46, :1183:43
      end
      if (_GEN_80) begin	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
        reg_pmp_1_cfg_l <= _newCfg_WIRE_1[7];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
        reg_pmp_1_cfg_a <= _newCfg_WIRE_1[4:3];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
      end
      if (_GEN_81) begin	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
        reg_pmp_2_cfg_l <= _newCfg_WIRE_2[7];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
        reg_pmp_2_cfg_a <= _newCfg_WIRE_2[4:3];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
      end
      if (_GEN_82) begin	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
        reg_pmp_3_cfg_l <= _newCfg_WIRE_3[7];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
        reg_pmp_3_cfg_a <= _newCfg_WIRE_3[4:3];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
      end
      if (_GEN_83) begin	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
        reg_pmp_4_cfg_l <= _newCfg_WIRE_4[7];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
        reg_pmp_4_cfg_a <= _newCfg_WIRE_4[4:3];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
      end
      if (_GEN_84) begin	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
        reg_pmp_5_cfg_l <= _newCfg_WIRE_5[7];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
        reg_pmp_5_cfg_a <= _newCfg_WIRE_5[4:3];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
      end
      if (_GEN_85) begin	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
        reg_pmp_6_cfg_l <= _newCfg_WIRE_6[7];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
        reg_pmp_6_cfg_a <= _newCfg_WIRE_6[4:3];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
      end
      if (_GEN_87) begin	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
        reg_pmp_7_cfg_l <= _newCfg_WIRE_7[7];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
        reg_pmp_7_cfg_a <= _newCfg_WIRE_7[4:3];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
      end
      if (csr_wen & _GEN_25)	// CSR.scala:636:73, :754:20, :897:18, :949:{40,53}, package.scala:72:59
        reg_mcause <= _reg_bp_0_control_WIRE_1 & 64'h800000000000000F;	// CSR.scala:392:27, :949:62, :1183:43
      else if (_GEN_72) begin	// CSR.scala:391:21, :392:27, :754:20, :755:24
      end
      else if (insn_call)	// CSR.scala:652:95
        reg_mcause <= _GEN_61;	// CSR.scala:392:27, :688:8
      else if (insn_break)	// CSR.scala:652:95
        reg_mcause <= 64'h3;	// CSR.scala:392:27, :689:14
      else	// CSR.scala:652:95
        reg_mcause <= io_cause;	// CSR.scala:392:27
      if (csr_wen & _GEN_19)	// CSR.scala:397:27, :636:73, :897:18, :948:{40,52}, package.scala:72:59
        reg_mtvec <= _new_dcsr_WIRE;	// CSR.scala:397:27, :948:52, :1183:43
      if (csr_wen & _GEN_32)	// CSR.scala:436:34, :636:73, :897:18, :965:{47,67}, package.scala:72:59
        reg_mcountinhibit <= _GEN_74 & 3'h5;	// CSR.scala:436:34, :965:{67,76}, :1183:43, Mux.scala:47:69
      if (csr_wen & _GEN_34) begin	// CSR.scala:636:73, :897:18, :1201:31, Counters.scala:47:19, :65:11, package.scala:72:59
        value_lo <= _GEN_69;	// CSR.scala:1183:43, Counters.scala:45:37, :65:11
        value_hi <= _wdata_T_2[63:6] & _wdata_T_6[63:6];	// CSR.scala:1183:{34,43,45}, Counters.scala:50:27, :66:28
      end
      else begin	// CSR.scala:897:18, :1201:31, Counters.scala:47:19, :65:11
        automatic logic [6:0] nextSmall;	// Counters.scala:46:33
        nextSmall = {1'h0, value_lo} + {6'h0, io_retire};	// CSR.scala:729:74, Counters.scala:45:37, :46:33
        if (reg_mcountinhibit[2]) begin	// CSR.scala:436:34, :438:75
        end
        else	// CSR.scala:438:75
          value_lo <= nextSmall[5:0];	// Counters.scala:45:37, :46:33, :47:27
        if (nextSmall[6] & ~(reg_mcountinhibit[2]))	// CSR.scala:436:34, :438:75, Counters.scala:46:33, :47:9, :51:{20,33}
          value_hi <= value_hi + 58'h1;	// Counters.scala:50:27, :51:55
      end
      if (csr_wen & _GEN_17 & (~(io_pc[1]) | _wdata_T_2[2] & _wdata_T_6[2])) begin	// CSR.scala:490:21, :636:73, :897:18, :923:36, :927:{33,39,43,51,64}, :929:20, :1183:{34,43,45}, package.scala:72:59
        automatic logic [63:0] _reg_misa_T;	// CSR.scala:929:25
        _reg_misa_T = ~_reg_bp_0_control_WIRE_1;	// CSR.scala:929:25, :1183:43
        reg_misa <=
          ~{_reg_misa_T[63:4],
            _reg_misa_T[3:0] | {~(_wdata_T_2[5] & _wdata_T_6[5]), 3'h0}} & 64'h102D
          | reg_misa & 64'hFFFFFFFFFFFFEFD2;	// CSR.scala:324:49, :490:21, :925:20, :929:{23,25,32,35,38,55,62,73,75}, :1183:{34,43,45}
      end
      if (csr_wen & _GEN_57)	// CSR.scala:628:43, :636:73, :897:18, :1086:35, :1087:13, package.scala:72:59
        reg_custom_0 <=
          _reg_bp_0_control_WIRE_1 & 64'h208 | reg_custom_0 & 64'hFFFFFFFFFFFFFDF7;	// CSR.scala:628:43, :1087:{23,31,38,40}, :1183:43
      io_status_cease_r <=
        system_insn & {io_rw_addr[9], io_rw_addr[1]} == 2'h2 | io_status_cease_r;	// CSR.scala:639:31, :652:{28,95}, :1187:35, Decode.scala:14:121, Reg.scala:27:20, :28:{19,23}
    end
    if (csr_wen & _GEN_27)	// CSR.scala:636:73, :754:20, :897:18, :988:{42,52}, package.scala:72:59
      reg_dpc <= _GEN_73;	// CSR.scala:369:20, :945:51
    else if (_GEN_70)	// CSR.scala:368:22, :754:20, :755:24, :756:25, :757:19
      reg_dpc <= epc;	// CSR.scala:369:20, :1204:31
    if (csr_wen & _GEN_28)	// CSR.scala:370:25, :636:73, :897:18, :989:{42,57}, package.scala:72:59
      reg_dscratch <= _reg_bp_0_control_WIRE_1;	// CSR.scala:370:25, :1183:43
    reg_singleStepped <=
      _io_singleStep_output
      & (io_retire | _io_trace_0_exception_output | reg_singleStepped);	// CSR.scala:372:30, :727:34, :738:43, :745:{36,56}, :746:{25,45}
    reg_bp_0_control_chain <= ~(reset | _GEN_77) & reg_bp_0_control_chain;	// CSR.scala:378:19, :897:18, :1039:70, :1051:44, :1052:24, :1062:30, :1140:18, :1143:17
    if (_GEN_77) begin	// CSR.scala:378:19, :897:18, :1039:70, :1051:44, :1052:24
      reg_bp_0_control_tmatch <= _reg_bp_0_control_WIRE_1[8:7];	// CSR.scala:378:19, :1052:41, :1183:43
      reg_bp_0_control_m <= _reg_bp_0_control_WIRE_1[6];	// CSR.scala:378:19, :1052:41, :1183:43
      reg_bp_0_control_s <= _reg_bp_0_control_WIRE_1[4];	// CSR.scala:378:19, :1052:41, :1183:43
      reg_bp_0_control_u <= _reg_bp_0_control_WIRE_1[3];	// CSR.scala:378:19, :1052:41, :1183:43
    end
    if (csr_wen & _GEN_76 & _GEN_16)	// CSR.scala:378:19, :636:73, :897:18, :1039:{55,70}, :1040:{44,57}, package.scala:72:59
      reg_bp_0_address <= _GEN_75;	// CSR.scala:378:19, :1025:54, :1183:43
    if (_GEN_78) begin	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
      reg_pmp_0_cfg_x <= _newCfg_WIRE[2];	// CSR.scala:379:20, :1072:46, :1183:43
      reg_pmp_0_cfg_w <= _newCfg_WIRE[1] & _newCfg_WIRE[0];	// CSR.scala:379:20, :1072:46, :1075:31, :1183:43
      reg_pmp_0_cfg_r <= _newCfg_WIRE[0];	// CSR.scala:379:20, :1072:46, :1183:43
    end
    if (csr_wen & _GEN_49
        & ~(reg_pmp_0_cfg_l | reg_pmp_1_cfg_l & ~(reg_pmp_1_cfg_a[1])
            & reg_pmp_1_cfg_a[0]))	// CSR.scala:379:20, :636:73, :897:18, :1080:{48,71}, :1081:18, PMP.scala:47:20, :48:26, :49:13, :51:{44,62}, package.scala:72:59
      reg_pmp_0_addr <= _GEN_79;	// CSR.scala:379:20, :1081:18, :1183:43
    if (_GEN_80) begin	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
      reg_pmp_1_cfg_x <= _newCfg_WIRE_1[2];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
      reg_pmp_1_cfg_w <= _newCfg_WIRE_1[1] & _newCfg_WIRE_1[0];	// CSR.scala:379:20, :1072:{46,53}, :1075:31, :1183:43
      reg_pmp_1_cfg_r <= _newCfg_WIRE_1[0];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
    end
    if (csr_wen & _GEN_50
        & ~(reg_pmp_1_cfg_l | reg_pmp_2_cfg_l & ~(reg_pmp_2_cfg_a[1])
            & reg_pmp_2_cfg_a[0]))	// CSR.scala:379:20, :636:73, :897:18, :1080:{48,71}, :1081:18, PMP.scala:47:20, :48:26, :49:13, :51:{44,62}, package.scala:72:59
      reg_pmp_1_addr <= _GEN_79;	// CSR.scala:379:20, :1081:18, :1183:43
    if (_GEN_81) begin	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
      reg_pmp_2_cfg_x <= _newCfg_WIRE_2[2];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
      reg_pmp_2_cfg_w <= _newCfg_WIRE_2[1] & _newCfg_WIRE_2[0];	// CSR.scala:379:20, :1072:{46,53}, :1075:31, :1183:43
      reg_pmp_2_cfg_r <= _newCfg_WIRE_2[0];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
    end
    if (csr_wen & _GEN_51
        & ~(reg_pmp_2_cfg_l | reg_pmp_3_cfg_l & ~(reg_pmp_3_cfg_a[1])
            & reg_pmp_3_cfg_a[0]))	// CSR.scala:379:20, :636:73, :897:18, :1080:{48,71}, :1081:18, PMP.scala:47:20, :48:26, :49:13, :51:{44,62}, package.scala:72:59
      reg_pmp_2_addr <= _GEN_79;	// CSR.scala:379:20, :1081:18, :1183:43
    if (_GEN_82) begin	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
      reg_pmp_3_cfg_x <= _newCfg_WIRE_3[2];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
      reg_pmp_3_cfg_w <= _newCfg_WIRE_3[1] & _newCfg_WIRE_3[0];	// CSR.scala:379:20, :1072:{46,53}, :1075:31, :1183:43
      reg_pmp_3_cfg_r <= _newCfg_WIRE_3[0];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
    end
    if (csr_wen & _GEN_52
        & ~(reg_pmp_3_cfg_l | reg_pmp_4_cfg_l & ~(reg_pmp_4_cfg_a[1])
            & reg_pmp_4_cfg_a[0]))	// CSR.scala:379:20, :636:73, :897:18, :1080:{48,71}, :1081:18, PMP.scala:47:20, :48:26, :49:13, :51:{44,62}, package.scala:72:59
      reg_pmp_3_addr <= _GEN_79;	// CSR.scala:379:20, :1081:18, :1183:43
    if (_GEN_83) begin	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
      reg_pmp_4_cfg_x <= _newCfg_WIRE_4[2];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
      reg_pmp_4_cfg_w <= _newCfg_WIRE_4[1] & _newCfg_WIRE_4[0];	// CSR.scala:379:20, :1072:{46,53}, :1075:31, :1183:43
      reg_pmp_4_cfg_r <= _newCfg_WIRE_4[0];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
    end
    if (csr_wen & _GEN_53
        & ~(reg_pmp_4_cfg_l | reg_pmp_5_cfg_l & ~(reg_pmp_5_cfg_a[1])
            & reg_pmp_5_cfg_a[0]))	// CSR.scala:379:20, :636:73, :897:18, :1080:{48,71}, :1081:18, PMP.scala:47:20, :48:26, :49:13, :51:{44,62}, package.scala:72:59
      reg_pmp_4_addr <= _GEN_79;	// CSR.scala:379:20, :1081:18, :1183:43
    if (_GEN_84) begin	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
      reg_pmp_5_cfg_x <= _newCfg_WIRE_5[2];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
      reg_pmp_5_cfg_w <= _newCfg_WIRE_5[1] & _newCfg_WIRE_5[0];	// CSR.scala:379:20, :1072:{46,53}, :1075:31, :1183:43
      reg_pmp_5_cfg_r <= _newCfg_WIRE_5[0];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
    end
    if (csr_wen & _GEN_54
        & ~(reg_pmp_5_cfg_l | reg_pmp_6_cfg_l & ~(reg_pmp_6_cfg_a[1])
            & reg_pmp_6_cfg_a[0]))	// CSR.scala:379:20, :636:73, :897:18, :1080:{48,71}, :1081:18, PMP.scala:47:20, :48:26, :49:13, :51:{44,62}, package.scala:72:59
      reg_pmp_5_addr <= _GEN_79;	// CSR.scala:379:20, :1081:18, :1183:43
    if (_GEN_85) begin	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
      reg_pmp_6_cfg_x <= _newCfg_WIRE_6[2];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
      reg_pmp_6_cfg_w <= _newCfg_WIRE_6[1] & _newCfg_WIRE_6[0];	// CSR.scala:379:20, :1072:{46,53}, :1075:31, :1183:43
      reg_pmp_6_cfg_r <= _newCfg_WIRE_6[0];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
    end
    if (csr_wen & _GEN_55 & ~(reg_pmp_6_cfg_l | _GEN_86))	// CSR.scala:379:20, :636:73, :897:18, :1080:{48,71}, :1081:18, PMP.scala:51:{44,62}, package.scala:72:59
      reg_pmp_6_addr <= _GEN_79;	// CSR.scala:379:20, :1081:18, :1183:43
    if (_GEN_87) begin	// CSR.scala:379:20, :897:18, :1071:76, :1073:17
      reg_pmp_7_cfg_x <= _newCfg_WIRE_7[2];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
      reg_pmp_7_cfg_w <= _newCfg_WIRE_7[1] & _newCfg_WIRE_7[0];	// CSR.scala:379:20, :1072:{46,53}, :1075:31, :1183:43
      reg_pmp_7_cfg_r <= _newCfg_WIRE_7[0];	// CSR.scala:379:20, :1072:{46,53}, :1183:43
    end
    if (csr_wen & _GEN_56 & ~(reg_pmp_7_cfg_l | _GEN_86))	// CSR.scala:379:20, :636:73, :897:18, :1080:{48,71}, :1081:18, PMP.scala:51:{44,62}, package.scala:72:59
      reg_pmp_7_addr <= _GEN_79;	// CSR.scala:379:20, :1081:18, :1183:43
    if (csr_wen) begin	// package.scala:72:59
      automatic logic [15:0] _GEN_94;	// CSR.scala:944:59, :1183:43
      automatic logic [15:0] _GEN_95;	// CSR.scala:384:36, :1008:78
      _GEN_94 = _wdata_T_2[15:0] & _wdata_T_6[15:0];	// CSR.scala:944:59, :1183:{34,43,45}
      _GEN_95 = _GEN_94 & _GEN_0;	// CSR.scala:384:36, :944:59, :1008:78, :1183:43
      if (_GEN_38)	// CSR.scala:636:73
        reg_mie <= {reg_mie[63:16], reg_mie[15:0] & {6'h3F, ~_GEN, 1'h1} | _GEN_95};	// CSR.scala:325:24, :355:50, :381:20, :384:36, :457:56, :1008:{52,78}, :1022:{64,66,81,90}
      else if (_GEN_21)	// CSR.scala:636:73
        reg_mie <= {48'h0, _GEN_94 & 16'hAAA};	// CSR.scala:355:10, :378:19, :381:20, :944:59, :1183:43
      if (_GEN_37)	// CSR.scala:636:73
        reg_mip_ssip <= ~(reg_mideleg[1]) & reg_mip_ssip | _GEN_95[1];	// CSR.scala:355:50, :383:18, :384:36, :390:20, :1008:{52,54,69,78}
      else if (_GEN_20)	// CSR.scala:636:73
        reg_mip_ssip <= _new_mip_WIRE[0];	// CSR.scala:390:20, :937:88, :1183:43
      if (_GEN_31)	// CSR.scala:636:73
        reg_frm <= _wdata_T_2[7:5] & _wdata_T_6[7:5];	// CSR.scala:430:20, :976:{17,26}, :1183:{34,43,45}
      else if (_GEN_30)	// CSR.scala:636:73
        reg_frm <= _GEN_74;	// CSR.scala:430:20, :965:{67,76}, :1183:43
    end
    if (csr_wen & _GEN_46)	// CSR.scala:383:18, :636:73, :897:18, :1028:{42,56}, package.scala:72:59
      reg_mideleg <= _reg_bp_0_control_WIRE_1;	// CSR.scala:383:18, :1183:43
    if (csr_wen & _GEN_47)	// CSR.scala:387:18, :636:73, :897:18, :1029:{42,56}, package.scala:72:59
      reg_medeleg <= _reg_bp_0_control_WIRE_1;	// CSR.scala:387:18, :1183:43
    if (csr_wen & _GEN_20) begin	// CSR.scala:390:20, :636:73, :897:18, :932:35, :940:22, package.scala:72:59
      reg_mip_seip <= _new_mip_WIRE[8];	// CSR.scala:390:20, :937:88, :1183:43
      reg_mip_stip <= _new_mip_WIRE[4];	// CSR.scala:390:20, :937:88, :1183:43
    end
    if (csr_wen & _GEN_23)	// CSR.scala:636:73, :754:20, :897:18, :945:{40,51}, package.scala:72:59
      reg_mepc <= _GEN_73;	// CSR.scala:391:21, :945:51
    else if (_GEN_72) begin	// CSR.scala:391:21, :754:20, :755:24
    end
    else	// CSR.scala:391:21, :754:20, :755:24
      reg_mepc <= epc;	// CSR.scala:391:21, :1204:31
    if (csr_wen & _GEN_24)	// CSR.scala:636:73, :754:20, :897:18, :950:{40,52}, package.scala:72:59
      reg_mtval <= _wdata_T_2[39:0] & _wdata_T_6[39:0];	// CSR.scala:393:22, :950:60, :1183:{34,43,45}
    else if (_GEN_72) begin	// CSR.scala:391:21, :393:22, :754:20, :755:24
    end
    else	// CSR.scala:393:22, :754:20, :755:24
      reg_mtval <= io_tval;	// CSR.scala:393:22
    if (csr_wen & _GEN_22)	// CSR.scala:394:25, :636:73, :897:18, :946:{40,55}, package.scala:72:59
      reg_mscratch <= _reg_bp_0_control_WIRE_1;	// CSR.scala:394:25, :1183:43
    if (csr_wen & _GEN_35)	// CSR.scala:413:18, :636:73, :897:18, :1033:{44,61}, package.scala:72:59
      reg_mcounteren <= _new_dcsr_WIRE;	// CSR.scala:413:18, :948:52, :1183:43
    if (csr_wen & _GEN_45)	// CSR.scala:417:18, :636:73, :897:18, :1030:{44,61}, package.scala:72:59
      reg_scounteren <= _new_dcsr_WIRE;	// CSR.scala:417:18, :948:52, :1183:43
    if (csr_wen & _GEN_43)	// CSR.scala:636:73, :754:20, :897:18, :1024:{42,53}, package.scala:72:59
      reg_sepc <= _GEN_73;	// CSR.scala:421:21, :945:51
    else if (_GEN_71) begin	// CSR.scala:421:21, :754:20, :755:24
    end
    else	// CSR.scala:421:21, :754:20, :755:24
      reg_sepc <= epc;	// CSR.scala:421:21, :1204:31
    if (csr_wen & _GEN_40)	// CSR.scala:636:73, :754:20, :897:18, :1026:{42,55}, package.scala:72:59
      reg_scause <= _reg_bp_0_control_WIRE_1 & 64'h800000000000001F;	// CSR.scala:422:23, :1026:64, :1183:43
    else if (_GEN_71) begin	// CSR.scala:421:21, :422:23, :754:20, :755:24
    end
    else if (insn_call)	// CSR.scala:652:95
      reg_scause <= _GEN_61;	// CSR.scala:422:23, :688:8
    else if (insn_break)	// CSR.scala:652:95
      reg_scause <= 64'h3;	// CSR.scala:422:23, :689:14
    else	// CSR.scala:652:95
      reg_scause <= io_cause;	// CSR.scala:422:23
    if (csr_wen & _GEN_41)	// CSR.scala:636:73, :754:20, :897:18, :1027:{42,54}, package.scala:72:59
      reg_stval <= _wdata_T_2[39:0] & _wdata_T_6[39:0];	// CSR.scala:423:22, :950:60, :1027:62, :1183:{34,43,45}
    else if (_GEN_71) begin	// CSR.scala:421:21, :423:22, :754:20, :755:24
    end
    else	// CSR.scala:423:22, :754:20, :755:24
      reg_stval <= io_tval;	// CSR.scala:423:22
    if (csr_wen & _GEN_39)	// CSR.scala:424:25, :636:73, :897:18, :1023:{42,57}, package.scala:72:59
      reg_sscratch <= _reg_bp_0_control_WIRE_1;	// CSR.scala:424:25, :1183:43
    if (csr_wen & _GEN_44)	// CSR.scala:425:22, :636:73, :897:18, :1025:{42,54}, package.scala:72:59
      reg_stvec <= _GEN_75;	// CSR.scala:425:22, :1025:54, :1183:43
    if (csr_wen & _GEN_42
        & (_reg_bp_0_control_WIRE_1[63:60] == 4'h0
           | _reg_bp_0_control_WIRE_1[63:60] == 4'h8)) begin	// CSR.scala:426:21, :599:57, :636:73, :897:18, :1011:38, :1013:45, :1015:62, :1016:27, :1183:43, Mux.scala:47:69, package.scala:15:47, :72:59
      reg_satp_mode <= {_reg_bp_0_control_WIRE_1[63], 3'h0};	// CSR.scala:324:49, :426:21, :1013:45, :1016:44, :1183:43
      reg_satp_ppn <= {24'h0, _reg_bp_0_control_WIRE_1[19:0]};	// Bitwise.scala:72:12, CSR.scala:426:21, :1017:{26,41}, :1183:43
    end
    if (csr_wen & (_GEN_31 | _GEN_29))	// CSR.scala:636:73, :883:30, :897:18, :971:40, :973:38, :975:20, package.scala:72:59
      reg_fflags <= _wdata_T_2[4:0] & _wdata_T_6[4:0];	// CSR.scala:429:23, :971:75, :1183:{34,43,45}
    else	// CSR.scala:883:30, :897:18, :973:38
      reg_fflags <= {5{io_fcsr_flags_valid}} & io_fcsr_flags_bits | reg_fflags;	// CSR.scala:429:23, :883:30, :884:16
    if (reg_mstatus_mprv & ~reg_debug)	// CSR.scala:319:24, :368:22, :675:45, :734:53
      io_status_dprv_REG <= reg_mstatus_mpp;	// CSR.scala:319:24, :734:24
    else	// CSR.scala:734:53
      io_status_dprv_REG <= reg_mstatus_prv;	// CSR.scala:319:24, :734:24
  end // always @(posedge)
  always @(posedge io_ungated_clock) begin
    if (reset) begin
      reg_wfi <= 1'h0;	// CSR.scala:427:50, :729:74
      value_lo_1 <= 6'h0;	// Counters.scala:45:37
      value_hi_1 <= 58'h0;	// Counters.scala:50:27
    end
    else begin
      reg_wfi <=
        ~((|{_GEN_5[11], _GEN_5[9], _GEN_5[7], _GEN_5[5], _GEN_5[3], _GEN_5[1]})
          | io_interrupts_debug | _io_trace_0_exception_output)
        & (system_insn & {io_rw_addr[9:8], io_rw_addr[5], io_rw_addr[1]} == 4'h4
           & ~_io_singleStep_output & ~reg_debug | reg_wfi);	// CSR.scala:368:22, :427:50, :457:56, :469:36, :639:31, :652:28, :675:45, :727:34, :738:43, :741:{36,51,61}, :742:{28,55,69,79}, Decode.scala:14:121, Mux.scala:47:69
      if (csr_wen & _GEN_33) begin	// CSR.scala:636:73, :897:18, :1201:31, Counters.scala:47:19, :65:11, package.scala:72:59
        value_lo_1 <= _GEN_69;	// CSR.scala:1183:43, Counters.scala:45:37, :65:11
        value_hi_1 <= _wdata_T_2[63:6] & _wdata_T_6[63:6];	// CSR.scala:1183:{34,43,45}, Counters.scala:50:27, :66:28
      end
      else begin	// CSR.scala:897:18, :1201:31, Counters.scala:47:19, :65:11
        automatic logic [6:0] nextSmall_1;	// Counters.scala:46:33
        nextSmall_1 = {1'h0, value_lo_1} + {6'h0, ~_io_csr_stall_output};	// CSR.scala:440:56, :729:74, :845:27, Counters.scala:45:37, :46:33
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
      automatic logic [31:0] _RANDOM[0:75];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [6:0] i = 7'h0; i < 7'h4C; i += 7'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        reg_mstatus_prv = _RANDOM[7'h1][6:5];	// CSR.scala:319:24
        reg_mstatus_tsr = _RANDOM[7'h2][16];	// CSR.scala:319:24
        reg_mstatus_tw = _RANDOM[7'h2][17];	// CSR.scala:319:24
        reg_mstatus_tvm = _RANDOM[7'h2][18];	// CSR.scala:319:24
        reg_mstatus_mxr = _RANDOM[7'h2][19];	// CSR.scala:319:24
        reg_mstatus_sum = _RANDOM[7'h2][20];	// CSR.scala:319:24
        reg_mstatus_mprv = _RANDOM[7'h2][21];	// CSR.scala:319:24
        reg_mstatus_fs = _RANDOM[7'h2][25:24];	// CSR.scala:319:24
        reg_mstatus_mpp = _RANDOM[7'h2][27:26];	// CSR.scala:319:24
        reg_mstatus_spp = _RANDOM[7'h2][30];	// CSR.scala:319:24
        reg_mstatus_mpie = _RANDOM[7'h2][31];	// CSR.scala:319:24
        reg_mstatus_spie = _RANDOM[7'h3][1];	// CSR.scala:319:24
        reg_mstatus_mie = _RANDOM[7'h3][3];	// CSR.scala:319:24
        reg_mstatus_sie = _RANDOM[7'h3][5];	// CSR.scala:319:24
        reg_dcsr_ebreakm = _RANDOM[7'h3][23];	// CSR.scala:319:24, :327:21
        reg_dcsr_ebreaks = _RANDOM[7'h3][25];	// CSR.scala:319:24, :327:21
        reg_dcsr_ebreaku = _RANDOM[7'h3][26];	// CSR.scala:319:24, :327:21
        reg_dcsr_cause = {_RANDOM[7'h3][31:30], _RANDOM[7'h4][0]};	// CSR.scala:319:24, :327:21
        reg_dcsr_step = _RANDOM[7'h4][4];	// CSR.scala:327:21
        reg_dcsr_prv = _RANDOM[7'h4][6:5];	// CSR.scala:327:21
        reg_debug = _RANDOM[7'h4][7];	// CSR.scala:327:21, :368:22
        reg_dpc = {_RANDOM[7'h4][31:8], _RANDOM[7'h5][15:0]};	// CSR.scala:327:21, :369:20
        reg_dscratch = {_RANDOM[7'h5][31:16], _RANDOM[7'h6], _RANDOM[7'h7][15:0]};	// CSR.scala:369:20, :370:25
        reg_singleStepped = _RANDOM[7'h7][16];	// CSR.scala:370:25, :372:30
        reg_bp_0_control_dmode = _RANDOM[7'h7][22];	// CSR.scala:370:25, :378:19
        reg_bp_0_control_action = _RANDOM[7'h9][5];	// CSR.scala:378:19
        reg_bp_0_control_chain = _RANDOM[7'h9][6];	// CSR.scala:378:19
        reg_bp_0_control_tmatch = _RANDOM[7'h9][10:9];	// CSR.scala:378:19
        reg_bp_0_control_m = _RANDOM[7'h9][11];	// CSR.scala:378:19
        reg_bp_0_control_s = _RANDOM[7'h9][13];	// CSR.scala:378:19
        reg_bp_0_control_u = _RANDOM[7'h9][14];	// CSR.scala:378:19
        reg_bp_0_control_x = _RANDOM[7'h9][15];	// CSR.scala:378:19
        reg_bp_0_control_w = _RANDOM[7'h9][16];	// CSR.scala:378:19
        reg_bp_0_control_r = _RANDOM[7'h9][17];	// CSR.scala:378:19
        reg_bp_0_address = {_RANDOM[7'h9][31:18], _RANDOM[7'hA][24:0]};	// CSR.scala:378:19
        reg_pmp_0_cfg_l = _RANDOM[7'h11][6];	// CSR.scala:379:20
        reg_pmp_0_cfg_a = _RANDOM[7'h11][10:9];	// CSR.scala:379:20
        reg_pmp_0_cfg_x = _RANDOM[7'h11][11];	// CSR.scala:379:20
        reg_pmp_0_cfg_w = _RANDOM[7'h11][12];	// CSR.scala:379:20
        reg_pmp_0_cfg_r = _RANDOM[7'h11][13];	// CSR.scala:379:20
        reg_pmp_0_addr = {_RANDOM[7'h11][31:14], _RANDOM[7'h12][11:0]};	// CSR.scala:379:20
        reg_pmp_1_cfg_l = _RANDOM[7'h12][12];	// CSR.scala:379:20
        reg_pmp_1_cfg_a = _RANDOM[7'h12][16:15];	// CSR.scala:379:20
        reg_pmp_1_cfg_x = _RANDOM[7'h12][17];	// CSR.scala:379:20
        reg_pmp_1_cfg_w = _RANDOM[7'h12][18];	// CSR.scala:379:20
        reg_pmp_1_cfg_r = _RANDOM[7'h12][19];	// CSR.scala:379:20
        reg_pmp_1_addr = {_RANDOM[7'h12][31:20], _RANDOM[7'h13][17:0]};	// CSR.scala:379:20
        reg_pmp_2_cfg_l = _RANDOM[7'h13][18];	// CSR.scala:379:20
        reg_pmp_2_cfg_a = _RANDOM[7'h13][22:21];	// CSR.scala:379:20
        reg_pmp_2_cfg_x = _RANDOM[7'h13][23];	// CSR.scala:379:20
        reg_pmp_2_cfg_w = _RANDOM[7'h13][24];	// CSR.scala:379:20
        reg_pmp_2_cfg_r = _RANDOM[7'h13][25];	// CSR.scala:379:20
        reg_pmp_2_addr = {_RANDOM[7'h13][31:26], _RANDOM[7'h14][23:0]};	// CSR.scala:379:20
        reg_pmp_3_cfg_l = _RANDOM[7'h14][24];	// CSR.scala:379:20
        reg_pmp_3_cfg_a = _RANDOM[7'h14][28:27];	// CSR.scala:379:20
        reg_pmp_3_cfg_x = _RANDOM[7'h14][29];	// CSR.scala:379:20
        reg_pmp_3_cfg_w = _RANDOM[7'h14][30];	// CSR.scala:379:20
        reg_pmp_3_cfg_r = _RANDOM[7'h14][31];	// CSR.scala:379:20
        reg_pmp_3_addr = _RANDOM[7'h15][29:0];	// CSR.scala:379:20
        reg_pmp_4_cfg_l = _RANDOM[7'h15][30];	// CSR.scala:379:20
        reg_pmp_4_cfg_a = _RANDOM[7'h16][2:1];	// CSR.scala:379:20
        reg_pmp_4_cfg_x = _RANDOM[7'h16][3];	// CSR.scala:379:20
        reg_pmp_4_cfg_w = _RANDOM[7'h16][4];	// CSR.scala:379:20
        reg_pmp_4_cfg_r = _RANDOM[7'h16][5];	// CSR.scala:379:20
        reg_pmp_4_addr = {_RANDOM[7'h16][31:6], _RANDOM[7'h17][3:0]};	// CSR.scala:379:20
        reg_pmp_5_cfg_l = _RANDOM[7'h17][4];	// CSR.scala:379:20
        reg_pmp_5_cfg_a = _RANDOM[7'h17][8:7];	// CSR.scala:379:20
        reg_pmp_5_cfg_x = _RANDOM[7'h17][9];	// CSR.scala:379:20
        reg_pmp_5_cfg_w = _RANDOM[7'h17][10];	// CSR.scala:379:20
        reg_pmp_5_cfg_r = _RANDOM[7'h17][11];	// CSR.scala:379:20
        reg_pmp_5_addr = {_RANDOM[7'h17][31:12], _RANDOM[7'h18][9:0]};	// CSR.scala:379:20
        reg_pmp_6_cfg_l = _RANDOM[7'h18][10];	// CSR.scala:379:20
        reg_pmp_6_cfg_a = _RANDOM[7'h18][14:13];	// CSR.scala:379:20
        reg_pmp_6_cfg_x = _RANDOM[7'h18][15];	// CSR.scala:379:20
        reg_pmp_6_cfg_w = _RANDOM[7'h18][16];	// CSR.scala:379:20
        reg_pmp_6_cfg_r = _RANDOM[7'h18][17];	// CSR.scala:379:20
        reg_pmp_6_addr = {_RANDOM[7'h18][31:18], _RANDOM[7'h19][15:0]};	// CSR.scala:379:20
        reg_pmp_7_cfg_l = _RANDOM[7'h19][16];	// CSR.scala:379:20
        reg_pmp_7_cfg_a = _RANDOM[7'h19][20:19];	// CSR.scala:379:20
        reg_pmp_7_cfg_x = _RANDOM[7'h19][21];	// CSR.scala:379:20
        reg_pmp_7_cfg_w = _RANDOM[7'h19][22];	// CSR.scala:379:20
        reg_pmp_7_cfg_r = _RANDOM[7'h19][23];	// CSR.scala:379:20
        reg_pmp_7_addr = {_RANDOM[7'h19][31:24], _RANDOM[7'h1A][21:0]};	// CSR.scala:379:20
        reg_mie = {_RANDOM[7'h1A][31:22], _RANDOM[7'h1B], _RANDOM[7'h1C][21:0]};	// CSR.scala:379:20, :381:20
        reg_mideleg = {_RANDOM[7'h1C][31:22], _RANDOM[7'h1D], _RANDOM[7'h1E][21:0]};	// CSR.scala:381:20, :383:18
        reg_medeleg = {_RANDOM[7'h1E][31:22], _RANDOM[7'h1F], _RANDOM[7'h20][21:0]};	// CSR.scala:383:18, :387:18
        reg_mip_seip = _RANDOM[7'h20][28];	// CSR.scala:387:18, :390:20
        reg_mip_stip = _RANDOM[7'h21][0];	// CSR.scala:390:20
        reg_mip_ssip = _RANDOM[7'h21][4];	// CSR.scala:390:20
        reg_mepc = {_RANDOM[7'h21][31:6], _RANDOM[7'h22][13:0]};	// CSR.scala:390:20, :391:21
        reg_mcause = {_RANDOM[7'h22][31:14], _RANDOM[7'h23], _RANDOM[7'h24][13:0]};	// CSR.scala:391:21, :392:27
        reg_mtval = {_RANDOM[7'h24][31:14], _RANDOM[7'h25][21:0]};	// CSR.scala:392:27, :393:22
        reg_mscratch = {_RANDOM[7'h25][31:22], _RANDOM[7'h26], _RANDOM[7'h27][21:0]};	// CSR.scala:393:22, :394:25
        reg_mtvec = {_RANDOM[7'h27][31:22], _RANDOM[7'h28][21:0]};	// CSR.scala:394:25, :397:27
        reg_mcounteren = {_RANDOM[7'h31][31:7], _RANDOM[7'h32][6:0]};	// CSR.scala:413:18
        reg_scounteren = {_RANDOM[7'h32][31:7], _RANDOM[7'h33][6:0]};	// CSR.scala:413:18, :417:18
        reg_sepc = {_RANDOM[7'h33][31:7], _RANDOM[7'h34][14:0]};	// CSR.scala:417:18, :421:21
        reg_scause = {_RANDOM[7'h34][31:15], _RANDOM[7'h35], _RANDOM[7'h36][14:0]};	// CSR.scala:421:21, :422:23
        reg_stval = {_RANDOM[7'h36][31:15], _RANDOM[7'h37][22:0]};	// CSR.scala:422:23, :423:22
        reg_sscratch = {_RANDOM[7'h37][31:23], _RANDOM[7'h38], _RANDOM[7'h39][22:0]};	// CSR.scala:423:22, :424:25
        reg_stvec = {_RANDOM[7'h39][31:23], _RANDOM[7'h3A][29:0]};	// CSR.scala:424:25, :425:22
        reg_satp_mode = {_RANDOM[7'h3A][31:30], _RANDOM[7'h3B][1:0]};	// CSR.scala:425:22, :426:21
        reg_satp_ppn = {_RANDOM[7'h3B][31:18], _RANDOM[7'h3C][29:0]};	// CSR.scala:426:21
        reg_wfi = _RANDOM[7'h3C][30];	// CSR.scala:426:21, :427:50
        reg_fflags = {_RANDOM[7'h3C][31], _RANDOM[7'h3D][3:0]};	// CSR.scala:426:21, :429:23
        reg_frm = _RANDOM[7'h3D][6:4];	// CSR.scala:429:23, :430:20
        reg_mcountinhibit = _RANDOM[7'h3D][9:7];	// CSR.scala:429:23, :436:34
        value_lo = _RANDOM[7'h3D][15:10];	// CSR.scala:429:23, Counters.scala:45:37
        value_hi = {_RANDOM[7'h3D][31:16], _RANDOM[7'h3E], _RANDOM[7'h3F][9:0]};	// CSR.scala:429:23, Counters.scala:50:27
        value_lo_1 = _RANDOM[7'h3F][15:10];	// Counters.scala:45:37, :50:27
        value_hi_1 = {_RANDOM[7'h3F][31:16], _RANDOM[7'h40], _RANDOM[7'h41][9:0]};	// Counters.scala:50:27
        reg_misa = {_RANDOM[7'h41][31:10], _RANDOM[7'h42], _RANDOM[7'h43][9:0]};	// CSR.scala:490:21, Counters.scala:50:27
        reg_custom_0 = {_RANDOM[7'h43][31:10], _RANDOM[7'h44], _RANDOM[7'h45][9:0]};	// CSR.scala:490:21, :628:43
        io_status_dprv_REG = _RANDOM[7'h4B][11:10];	// CSR.scala:734:24
        io_status_cease_r = _RANDOM[7'h4B][12];	// CSR.scala:734:24, Reg.scala:27:20
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_rw_rdata = _io_rw_rdata_WIRE;	// Mux.scala:27:72
  assign io_decode_0_fp_illegal = _io_decode_0_fp_illegal_output;	// CSR.scala:667:45
  assign io_decode_0_fp_csr = _io_decode_0_fp_csr_output;	// Decode.scala:14:121
  assign io_decode_0_read_illegal =
    reg_mstatus_prv < io_decode_0_csr[9:8] | ~_io_decode_0_read_illegal_T_294
    | _io_decode_0_read_illegal_T_297 & ~allow_sfence_vma
    | (io_decode_0_csr > 12'hBFF & io_decode_0_csr < 12'hC20 | io_decode_0_csr > 12'hC7F
       & io_decode_0_csr < 12'hCA0)
    & ~((reg_mstatus_prv[1] | _allow_counter_T_1[0])
        & ((|reg_mstatus_prv) | _allow_counter_T_6[0]))
    | {io_decode_0_csr[11:10], io_decode_0_csr[4]} == 3'h3 & ~reg_debug
    | _io_decode_0_fp_csr_output & _io_decode_0_fp_illegal_output;	// CSR.scala:319:24, :368:22, :655:{99,115}, :661:63, :662:70, :665:{50,68,84}, :666:{44,53,71}, :667:45, :671:{44,56}, :672:7, :673:{32,35}, :674:{66,130,133}, :675:{42,45}, :676:68, :677:21, Decode.scala:14:{65,121}, package.scala:204:{47,55,60}
  assign io_decode_0_write_illegal = &(io_decode_0_csr[11:10]);	// CSR.scala:678:{39,47}
  assign io_decode_0_write_flush =
    ~(io_decode_0_csr > 12'h33F & io_decode_0_csr < 12'h344 | io_decode_0_csr > 12'h13F
      & io_decode_0_csr < 12'h144);	// CSR.scala:636:73, :655:99, :679:{27,40,57,71,85,99,116,130}
  assign io_decode_0_system_illegal =
    reg_mstatus_prv < io_decode_0_csr[9:8]
    | {io_decode_0_csr[9:8], io_decode_0_csr[5], io_decode_0_csr[1]} == 4'h4
    & ~(reg_mstatus_prv[1] | ~reg_mstatus_tw) | is_ret
    & ~(reg_mstatus_prv[1] | ~reg_mstatus_tsr) | is_ret & io_decode_0_csr[10]
    & io_decode_0_csr[7] & ~reg_debug | {io_decode_0_csr[10], io_decode_0_csr[5]} == 2'h1
    & ~allow_sfence_vma;	// CSR.scala:319:24, :368:22, :659:30, :661:{63,71,74}, :662:70, :663:{72,75}, :671:56, :673:35, :675:45, :680:46, :681:{14,17}, :682:{14,17}, :683:{27,45,49,63}, :684:17, :859:21, Decode.scala:14:121, :15:30, Mux.scala:47:69
  assign io_csr_stall = _io_csr_stall_output;	// CSR.scala:845:27
  assign io_eret = _exception_T | insn_ret;	// CSR.scala:652:95, :726:{24,38}
  assign io_singleStep = _io_singleStep_output;	// CSR.scala:727:34
  assign io_status_debug = reg_debug;	// CSR.scala:368:22
  assign io_status_wfi = reg_wfi;	// CSR.scala:427:50
  assign io_status_isa = reg_misa[31:0];	// CSR.scala:490:21, :731:17
  assign io_status_dprv = io_status_dprv_REG;	// CSR.scala:734:24
  assign io_status_prv = reg_mstatus_prv;	// CSR.scala:319:24
  assign io_status_mxr = reg_mstatus_mxr;	// CSR.scala:319:24
  assign io_status_sum = reg_mstatus_sum;	// CSR.scala:319:24
  assign io_ptbr_mode = reg_satp_mode;	// CSR.scala:426:21
  assign io_ptbr_ppn = reg_satp_ppn;	// CSR.scala:426:21
  assign io_evec =
    insn_ret
      ? (io_rw_addr[9]
           ? (_GEN_65
                ? ~{_io_evec_T_5[39:2], _io_evec_T_5[1:0] | {~(reg_misa[2]), 1'h1}}
                : ~{_io_evec_T_15[39:2], _io_evec_T_15[1:0] | {~(reg_misa[2]), 1'h1}})
           : ~{_io_evec_T[39:2], _io_evec_T[1:0] | {~(reg_misa[2]), 1'h1}})
      : trapToDebug
          ? {28'h0, reg_debug ? {8'h80, ~insn_break, 3'h0} : 12'h800}
          : {notDebugTVec_base[0] & cause[63] & cause[7:6] == 2'h0
               ? {notDebugTVec_base[39:8], cause[5:0]}
               : notDebugTVec_base[39:2],
             2'h0};	// CSR.scala:324:49, :325:24, :368:22, :490:21, :652:{28,95}, :688:8, :690:25, :691:30, :694:123, :697:{22,37}, :705:19, :706:32, :708:{24,55,70,94}, :709:{8,38}, :723:17, :724:11, :813:19, :815:52, :820:15, :821:{52,70}, :824:15, :825:69, :1205:{26,28,31,36,45}, Cat.scala:30:58
  assign io_time = value_1;	// Cat.scala:30:58
  assign io_fcsr_rm = reg_frm;	// CSR.scala:430:20
  assign io_interrupt =
    ((io_interrupts_debug | m_interrupts[15] | m_interrupts[14] | m_interrupts[13]
      | m_interrupts[12] | m_interrupts[11] | m_interrupts[3] | m_interrupts[7]
      | m_interrupts[9] | m_interrupts[1] | m_interrupts[5] | m_interrupts[8]
      | m_interrupts[0] | m_interrupts[4] | s_interrupts[15] | s_interrupts[14]
      | s_interrupts[13] | s_interrupts[12] | s_interrupts[11] | s_interrupts[3]
      | s_interrupts[7] | s_interrupts[9] | s_interrupts[1] | s_interrupts[5]
      | s_interrupts[8] | s_interrupts[0] | s_interrupts[4]) & ~_io_singleStep_output
     | reg_singleStepped) & ~(reg_debug | io_status_cease_r);	// CSR.scala:368:22, :372:30, :464:25, :465:25, :469:{33,36,51,73,76,88}, :727:34, :1177:{76,90}, Reg.scala:27:20
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
                                                   : m_interrupts[0]
                                                       ? 4'h0
                                                       : m_interrupts[4]
                                                           ? 4'h4
                                                           : s_interrupts[15]
                                                               ? 4'hF
                                                               : s_interrupts[14]
                                                                   ? 4'hE
                                                                   : s_interrupts[13]
                                                                       ? 4'hD
                                                                       : s_interrupts[12]
                                                                           ? 4'hC
                                                                           : s_interrupts[11]
                                                                               ? 4'hB
                                                                               : s_interrupts[3]
                                                                                   ? 4'h3
                                                                                   : s_interrupts[7]
                                                                                       ? 4'h7
                                                                                       : s_interrupts[9]
                                                                                           ? 4'h9
                                                                                           : s_interrupts[1]
                                                                                               ? 4'h1
                                                                                               : s_interrupts[5]
                                                                                                   ? 4'h5
                                                                                                   : s_interrupts[8]
                                                                                                       ? 4'h8
                                                                                                       : {1'h0,
                                                                                                          ~(s_interrupts[0]),
                                                                                                          2'h0}}
    - 64'h8000000000000000;	// CSR.scala:464:25, :465:25, :468:67, :599:57, :688:8, :729:74, :1177:76, Mux.scala:47:69
  assign io_bp_0_control_action = reg_bp_0_control_action;	// CSR.scala:378:19
  assign io_bp_0_control_chain = reg_bp_0_control_chain;	// CSR.scala:378:19
  assign io_bp_0_control_tmatch = reg_bp_0_control_tmatch;	// CSR.scala:378:19
  assign io_bp_0_control_m = reg_bp_0_control_m;	// CSR.scala:378:19
  assign io_bp_0_control_s = reg_bp_0_control_s;	// CSR.scala:378:19
  assign io_bp_0_control_u = reg_bp_0_control_u;	// CSR.scala:378:19
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
  assign io_pmp_0_mask = {_GEN_6 & ~(_GEN_6 + 30'h1), 2'h3};	// CSR.scala:316:21, PMP.scala:29:14, :60:{14,16,23}
  assign io_pmp_1_cfg_l = reg_pmp_1_cfg_l;	// CSR.scala:379:20
  assign io_pmp_1_cfg_a = reg_pmp_1_cfg_a;	// CSR.scala:379:20
  assign io_pmp_1_cfg_x = reg_pmp_1_cfg_x;	// CSR.scala:379:20
  assign io_pmp_1_cfg_w = reg_pmp_1_cfg_w;	// CSR.scala:379:20
  assign io_pmp_1_cfg_r = reg_pmp_1_cfg_r;	// CSR.scala:379:20
  assign io_pmp_1_addr = reg_pmp_1_addr;	// CSR.scala:379:20
  assign io_pmp_1_mask = {_GEN_7 & ~(_GEN_7 + 30'h1), 2'h3};	// CSR.scala:316:21, PMP.scala:29:14, :60:{14,16,23}
  assign io_pmp_2_cfg_l = reg_pmp_2_cfg_l;	// CSR.scala:379:20
  assign io_pmp_2_cfg_a = reg_pmp_2_cfg_a;	// CSR.scala:379:20
  assign io_pmp_2_cfg_x = reg_pmp_2_cfg_x;	// CSR.scala:379:20
  assign io_pmp_2_cfg_w = reg_pmp_2_cfg_w;	// CSR.scala:379:20
  assign io_pmp_2_cfg_r = reg_pmp_2_cfg_r;	// CSR.scala:379:20
  assign io_pmp_2_addr = reg_pmp_2_addr;	// CSR.scala:379:20
  assign io_pmp_2_mask = {_GEN_8 & ~(_GEN_8 + 30'h1), 2'h3};	// CSR.scala:316:21, PMP.scala:29:14, :60:{14,16,23}
  assign io_pmp_3_cfg_l = reg_pmp_3_cfg_l;	// CSR.scala:379:20
  assign io_pmp_3_cfg_a = reg_pmp_3_cfg_a;	// CSR.scala:379:20
  assign io_pmp_3_cfg_x = reg_pmp_3_cfg_x;	// CSR.scala:379:20
  assign io_pmp_3_cfg_w = reg_pmp_3_cfg_w;	// CSR.scala:379:20
  assign io_pmp_3_cfg_r = reg_pmp_3_cfg_r;	// CSR.scala:379:20
  assign io_pmp_3_addr = reg_pmp_3_addr;	// CSR.scala:379:20
  assign io_pmp_3_mask = {_GEN_9 & ~(_GEN_9 + 30'h1), 2'h3};	// CSR.scala:316:21, PMP.scala:29:14, :60:{14,16,23}
  assign io_pmp_4_cfg_l = reg_pmp_4_cfg_l;	// CSR.scala:379:20
  assign io_pmp_4_cfg_a = reg_pmp_4_cfg_a;	// CSR.scala:379:20
  assign io_pmp_4_cfg_x = reg_pmp_4_cfg_x;	// CSR.scala:379:20
  assign io_pmp_4_cfg_w = reg_pmp_4_cfg_w;	// CSR.scala:379:20
  assign io_pmp_4_cfg_r = reg_pmp_4_cfg_r;	// CSR.scala:379:20
  assign io_pmp_4_addr = reg_pmp_4_addr;	// CSR.scala:379:20
  assign io_pmp_4_mask = {_GEN_10 & ~(_GEN_10 + 30'h1), 2'h3};	// CSR.scala:316:21, PMP.scala:29:14, :60:{14,16,23}
  assign io_pmp_5_cfg_l = reg_pmp_5_cfg_l;	// CSR.scala:379:20
  assign io_pmp_5_cfg_a = reg_pmp_5_cfg_a;	// CSR.scala:379:20
  assign io_pmp_5_cfg_x = reg_pmp_5_cfg_x;	// CSR.scala:379:20
  assign io_pmp_5_cfg_w = reg_pmp_5_cfg_w;	// CSR.scala:379:20
  assign io_pmp_5_cfg_r = reg_pmp_5_cfg_r;	// CSR.scala:379:20
  assign io_pmp_5_addr = reg_pmp_5_addr;	// CSR.scala:379:20
  assign io_pmp_5_mask = {_GEN_11 & ~(_GEN_11 + 30'h1), 2'h3};	// CSR.scala:316:21, PMP.scala:29:14, :60:{14,16,23}
  assign io_pmp_6_cfg_l = reg_pmp_6_cfg_l;	// CSR.scala:379:20
  assign io_pmp_6_cfg_a = reg_pmp_6_cfg_a;	// CSR.scala:379:20
  assign io_pmp_6_cfg_x = reg_pmp_6_cfg_x;	// CSR.scala:379:20
  assign io_pmp_6_cfg_w = reg_pmp_6_cfg_w;	// CSR.scala:379:20
  assign io_pmp_6_cfg_r = reg_pmp_6_cfg_r;	// CSR.scala:379:20
  assign io_pmp_6_addr = reg_pmp_6_addr;	// CSR.scala:379:20
  assign io_pmp_6_mask = {_GEN_12 & ~(_GEN_12 + 30'h1), 2'h3};	// CSR.scala:316:21, PMP.scala:29:14, :60:{14,16,23}
  assign io_pmp_7_cfg_l = reg_pmp_7_cfg_l;	// CSR.scala:379:20
  assign io_pmp_7_cfg_a = reg_pmp_7_cfg_a;	// CSR.scala:379:20
  assign io_pmp_7_cfg_x = reg_pmp_7_cfg_x;	// CSR.scala:379:20
  assign io_pmp_7_cfg_w = reg_pmp_7_cfg_w;	// CSR.scala:379:20
  assign io_pmp_7_cfg_r = reg_pmp_7_cfg_r;	// CSR.scala:379:20
  assign io_pmp_7_addr = reg_pmp_7_addr;	// CSR.scala:379:20
  assign io_pmp_7_mask = {_GEN_13 & ~(_GEN_13 + 30'h1), 2'h3};	// CSR.scala:316:21, PMP.scala:29:14, :60:{14,16,23}
  assign io_inhibit_cycle = reg_mcountinhibit[0];	// CSR.scala:436:34, :437:40
  assign io_trace_0_valid = io_retire | _io_trace_0_exception_output;	// CSR.scala:738:43, :1162:30
  assign io_trace_0_exception = _io_trace_0_exception_output;	// CSR.scala:738:43
  assign io_customCSRs_0_value = reg_custom_0;	// CSR.scala:628:43
endmodule

