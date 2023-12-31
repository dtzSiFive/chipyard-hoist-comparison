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

module RenameStage_1(
  input        clock,
               reset,
               io_kill,
               io_dec_uops_0_is_br,
               io_dec_uops_0_is_jalr,
               io_dec_uops_0_is_sfb,
  input  [4:0] io_dec_uops_0_br_tag,
  input  [5:0] io_dec_uops_0_ldst,
               io_dec_uops_0_lrs1,
               io_dec_uops_0_lrs2,
               io_dec_uops_0_lrs3,
  input        io_dec_uops_0_ldst_val,
  input  [1:0] io_dec_uops_0_dst_rtype,
               io_dec_uops_0_lrs1_rtype,
               io_dec_uops_0_lrs2_rtype,
  input        io_dec_uops_0_frs3_en,
               io_dec_uops_1_is_br,
               io_dec_uops_1_is_jalr,
               io_dec_uops_1_is_sfb,
  input  [4:0] io_dec_uops_1_br_tag,
  input  [5:0] io_dec_uops_1_ldst,
               io_dec_uops_1_lrs1,
               io_dec_uops_1_lrs2,
               io_dec_uops_1_lrs3,
  input        io_dec_uops_1_ldst_val,
  input  [1:0] io_dec_uops_1_dst_rtype,
               io_dec_uops_1_lrs1_rtype,
               io_dec_uops_1_lrs2_rtype,
  input        io_dec_uops_1_frs3_en,
               io_dec_uops_2_is_br,
               io_dec_uops_2_is_jalr,
               io_dec_uops_2_is_sfb,
  input  [4:0] io_dec_uops_2_br_tag,
  input  [5:0] io_dec_uops_2_ldst,
               io_dec_uops_2_lrs1,
               io_dec_uops_2_lrs2,
               io_dec_uops_2_lrs3,
  input        io_dec_uops_2_ldst_val,
  input  [1:0] io_dec_uops_2_dst_rtype,
               io_dec_uops_2_lrs1_rtype,
               io_dec_uops_2_lrs2_rtype,
  input        io_dec_uops_2_frs3_en,
               io_dec_uops_3_is_br,
               io_dec_uops_3_is_jalr,
               io_dec_uops_3_is_sfb,
  input  [4:0] io_dec_uops_3_br_tag,
  input  [5:0] io_dec_uops_3_ldst,
               io_dec_uops_3_lrs1,
               io_dec_uops_3_lrs2,
               io_dec_uops_3_lrs3,
  input        io_dec_uops_3_ldst_val,
  input  [1:0] io_dec_uops_3_dst_rtype,
               io_dec_uops_3_lrs1_rtype,
               io_dec_uops_3_lrs2_rtype,
  input        io_dec_uops_3_frs3_en,
  input  [4:0] io_brupdate_b2_uop_br_tag,
  input        io_brupdate_b2_mispredict,
               io_dis_fire_0,
               io_dis_fire_1,
               io_dis_fire_2,
               io_dis_fire_3,
               io_dis_ready,
               io_wakeups_0_valid,
  input  [6:0] io_wakeups_0_bits_uop_pdst,
  input  [1:0] io_wakeups_0_bits_uop_dst_rtype,
  input        io_wakeups_1_valid,
  input  [6:0] io_wakeups_1_bits_uop_pdst,
  input  [1:0] io_wakeups_1_bits_uop_dst_rtype,
  input        io_wakeups_2_valid,
  input  [6:0] io_wakeups_2_bits_uop_pdst,
  input  [1:0] io_wakeups_2_bits_uop_dst_rtype,
  input        io_wakeups_3_valid,
  input  [6:0] io_wakeups_3_bits_uop_pdst,
  input  [1:0] io_wakeups_3_bits_uop_dst_rtype,
  input        io_com_valids_0,
               io_com_valids_1,
               io_com_valids_2,
               io_com_valids_3,
  input  [6:0] io_com_uops_0_pdst,
               io_com_uops_0_stale_pdst,
  input  [5:0] io_com_uops_0_ldst,
  input        io_com_uops_0_ldst_val,
  input  [1:0] io_com_uops_0_dst_rtype,
  input  [6:0] io_com_uops_1_pdst,
               io_com_uops_1_stale_pdst,
  input  [5:0] io_com_uops_1_ldst,
  input        io_com_uops_1_ldst_val,
  input  [1:0] io_com_uops_1_dst_rtype,
  input  [6:0] io_com_uops_2_pdst,
               io_com_uops_2_stale_pdst,
  input  [5:0] io_com_uops_2_ldst,
  input        io_com_uops_2_ldst_val,
  input  [1:0] io_com_uops_2_dst_rtype,
  input  [6:0] io_com_uops_3_pdst,
               io_com_uops_3_stale_pdst,
  input  [5:0] io_com_uops_3_ldst,
  input        io_com_uops_3_ldst_val,
  input  [1:0] io_com_uops_3_dst_rtype,
  input        io_rbk_valids_0,
               io_rbk_valids_1,
               io_rbk_valids_2,
               io_rbk_valids_3,
               io_rollback,
               io_debug_rob_empty,
  output       io_ren_stalls_0,
               io_ren_stalls_1,
               io_ren_stalls_2,
               io_ren_stalls_3,
  output [6:0] io_ren2_uops_0_pdst,
               io_ren2_uops_0_prs1,
               io_ren2_uops_0_prs2,
               io_ren2_uops_0_prs3,
  output       io_ren2_uops_0_prs1_busy,
               io_ren2_uops_0_prs2_busy,
               io_ren2_uops_0_prs3_busy,
  output [6:0] io_ren2_uops_0_stale_pdst,
               io_ren2_uops_1_pdst,
               io_ren2_uops_1_prs1,
               io_ren2_uops_1_prs2,
               io_ren2_uops_1_prs3,
  output       io_ren2_uops_1_prs1_busy,
               io_ren2_uops_1_prs2_busy,
               io_ren2_uops_1_prs3_busy,
  output [6:0] io_ren2_uops_1_stale_pdst,
               io_ren2_uops_2_pdst,
               io_ren2_uops_2_prs1,
               io_ren2_uops_2_prs2,
               io_ren2_uops_2_prs3,
  output       io_ren2_uops_2_prs1_busy,
               io_ren2_uops_2_prs2_busy,
               io_ren2_uops_2_prs3_busy,
  output [6:0] io_ren2_uops_2_stale_pdst,
               io_ren2_uops_3_pdst,
               io_ren2_uops_3_prs1,
               io_ren2_uops_3_prs2,
               io_ren2_uops_3_prs3,
  output       io_ren2_uops_3_prs1_busy,
               io_ren2_uops_3_prs2_busy,
               io_ren2_uops_3_prs3_busy,
  output [6:0] io_ren2_uops_3_stale_pdst
);

  wire       _busytable_io_busy_resps_0_prs1_busy;	// rename-stage.scala:221:25
  wire       _busytable_io_busy_resps_0_prs2_busy;	// rename-stage.scala:221:25
  wire       _busytable_io_busy_resps_0_prs3_busy;	// rename-stage.scala:221:25
  wire       _busytable_io_busy_resps_1_prs1_busy;	// rename-stage.scala:221:25
  wire       _busytable_io_busy_resps_1_prs2_busy;	// rename-stage.scala:221:25
  wire       _busytable_io_busy_resps_1_prs3_busy;	// rename-stage.scala:221:25
  wire       _busytable_io_busy_resps_2_prs1_busy;	// rename-stage.scala:221:25
  wire       _busytable_io_busy_resps_2_prs2_busy;	// rename-stage.scala:221:25
  wire       _busytable_io_busy_resps_2_prs3_busy;	// rename-stage.scala:221:25
  wire       _busytable_io_busy_resps_3_prs1_busy;	// rename-stage.scala:221:25
  wire       _busytable_io_busy_resps_3_prs2_busy;	// rename-stage.scala:221:25
  wire       _busytable_io_busy_resps_3_prs3_busy;	// rename-stage.scala:221:25
  wire       _freelist_io_alloc_pregs_0_valid;	// rename-stage.scala:217:24
  wire [6:0] _freelist_io_alloc_pregs_0_bits;	// rename-stage.scala:217:24
  wire       _freelist_io_alloc_pregs_1_valid;	// rename-stage.scala:217:24
  wire [6:0] _freelist_io_alloc_pregs_1_bits;	// rename-stage.scala:217:24
  wire       _freelist_io_alloc_pregs_2_valid;	// rename-stage.scala:217:24
  wire [6:0] _freelist_io_alloc_pregs_2_bits;	// rename-stage.scala:217:24
  wire       _freelist_io_alloc_pregs_3_valid;	// rename-stage.scala:217:24
  wire [6:0] _freelist_io_alloc_pregs_3_bits;	// rename-stage.scala:217:24
  wire [6:0] _maptable_io_map_resps_0_prs1;	// rename-stage.scala:211:24
  wire [6:0] _maptable_io_map_resps_0_prs2;	// rename-stage.scala:211:24
  wire [6:0] _maptable_io_map_resps_0_prs3;	// rename-stage.scala:211:24
  wire [6:0] _maptable_io_map_resps_0_stale_pdst;	// rename-stage.scala:211:24
  wire [6:0] _maptable_io_map_resps_1_prs1;	// rename-stage.scala:211:24
  wire [6:0] _maptable_io_map_resps_1_prs2;	// rename-stage.scala:211:24
  wire [6:0] _maptable_io_map_resps_1_prs3;	// rename-stage.scala:211:24
  wire [6:0] _maptable_io_map_resps_1_stale_pdst;	// rename-stage.scala:211:24
  wire [6:0] _maptable_io_map_resps_2_prs1;	// rename-stage.scala:211:24
  wire [6:0] _maptable_io_map_resps_2_prs2;	// rename-stage.scala:211:24
  wire [6:0] _maptable_io_map_resps_2_prs3;	// rename-stage.scala:211:24
  wire [6:0] _maptable_io_map_resps_2_stale_pdst;	// rename-stage.scala:211:24
  wire [6:0] _maptable_io_map_resps_3_prs1;	// rename-stage.scala:211:24
  wire [6:0] _maptable_io_map_resps_3_prs2;	// rename-stage.scala:211:24
  wire [6:0] _maptable_io_map_resps_3_prs3;	// rename-stage.scala:211:24
  wire [6:0] _maptable_io_map_resps_3_stale_pdst;	// rename-stage.scala:211:24
  reg        r_uop_is_br;	// rename-stage.scala:119:23
  reg        r_uop_is_jalr;	// rename-stage.scala:119:23
  reg        r_uop_is_sfb;	// rename-stage.scala:119:23
  reg  [4:0] r_uop_br_tag;	// rename-stage.scala:119:23
  reg  [6:0] r_uop_prs1;	// rename-stage.scala:119:23
  reg  [6:0] r_uop_prs2;	// rename-stage.scala:119:23
  reg  [6:0] r_uop_prs3;	// rename-stage.scala:119:23
  reg  [6:0] r_uop_stale_pdst;	// rename-stage.scala:119:23
  reg  [5:0] r_uop_ldst;	// rename-stage.scala:119:23
  reg  [5:0] r_uop_lrs1;	// rename-stage.scala:119:23
  reg  [5:0] r_uop_lrs2;	// rename-stage.scala:119:23
  reg  [5:0] r_uop_lrs3;	// rename-stage.scala:119:23
  reg        r_uop_ldst_val;	// rename-stage.scala:119:23
  reg  [1:0] r_uop_dst_rtype;	// rename-stage.scala:119:23
  reg  [1:0] r_uop_lrs1_rtype;	// rename-stage.scala:119:23
  reg  [1:0] r_uop_lrs2_rtype;	// rename-stage.scala:119:23
  reg        r_uop_frs3_en;	// rename-stage.scala:119:23
  reg        r_uop_1_is_br;	// rename-stage.scala:119:23
  reg        r_uop_1_is_jalr;	// rename-stage.scala:119:23
  reg        r_uop_1_is_sfb;	// rename-stage.scala:119:23
  reg  [4:0] r_uop_1_br_tag;	// rename-stage.scala:119:23
  reg  [6:0] r_uop_1_prs1;	// rename-stage.scala:119:23
  reg  [6:0] r_uop_1_prs2;	// rename-stage.scala:119:23
  reg  [6:0] r_uop_1_prs3;	// rename-stage.scala:119:23
  reg  [6:0] r_uop_1_stale_pdst;	// rename-stage.scala:119:23
  reg  [5:0] r_uop_1_ldst;	// rename-stage.scala:119:23
  reg  [5:0] r_uop_1_lrs1;	// rename-stage.scala:119:23
  reg  [5:0] r_uop_1_lrs2;	// rename-stage.scala:119:23
  reg  [5:0] r_uop_1_lrs3;	// rename-stage.scala:119:23
  reg        r_uop_1_ldst_val;	// rename-stage.scala:119:23
  reg  [1:0] r_uop_1_dst_rtype;	// rename-stage.scala:119:23
  reg  [1:0] r_uop_1_lrs1_rtype;	// rename-stage.scala:119:23
  reg  [1:0] r_uop_1_lrs2_rtype;	// rename-stage.scala:119:23
  reg        r_uop_1_frs3_en;	// rename-stage.scala:119:23
  reg        r_uop_2_is_br;	// rename-stage.scala:119:23
  reg        r_uop_2_is_jalr;	// rename-stage.scala:119:23
  reg        r_uop_2_is_sfb;	// rename-stage.scala:119:23
  reg  [4:0] r_uop_2_br_tag;	// rename-stage.scala:119:23
  reg  [6:0] r_uop_2_prs1;	// rename-stage.scala:119:23
  reg  [6:0] r_uop_2_prs2;	// rename-stage.scala:119:23
  reg  [6:0] r_uop_2_prs3;	// rename-stage.scala:119:23
  reg  [6:0] r_uop_2_stale_pdst;	// rename-stage.scala:119:23
  reg  [5:0] r_uop_2_ldst;	// rename-stage.scala:119:23
  reg  [5:0] r_uop_2_lrs1;	// rename-stage.scala:119:23
  reg  [5:0] r_uop_2_lrs2;	// rename-stage.scala:119:23
  reg  [5:0] r_uop_2_lrs3;	// rename-stage.scala:119:23
  reg        r_uop_2_ldst_val;	// rename-stage.scala:119:23
  reg  [1:0] r_uop_2_dst_rtype;	// rename-stage.scala:119:23
  reg  [1:0] r_uop_2_lrs1_rtype;	// rename-stage.scala:119:23
  reg  [1:0] r_uop_2_lrs2_rtype;	// rename-stage.scala:119:23
  reg        r_uop_2_frs3_en;	// rename-stage.scala:119:23
  reg        r_uop_3_is_br;	// rename-stage.scala:119:23
  reg        r_uop_3_is_jalr;	// rename-stage.scala:119:23
  reg        r_uop_3_is_sfb;	// rename-stage.scala:119:23
  reg  [4:0] r_uop_3_br_tag;	// rename-stage.scala:119:23
  reg  [6:0] r_uop_3_prs1;	// rename-stage.scala:119:23
  reg  [6:0] r_uop_3_prs2;	// rename-stage.scala:119:23
  reg  [6:0] r_uop_3_prs3;	// rename-stage.scala:119:23
  reg  [6:0] r_uop_3_stale_pdst;	// rename-stage.scala:119:23
  reg  [5:0] r_uop_3_ldst;	// rename-stage.scala:119:23
  reg  [5:0] r_uop_3_lrs1;	// rename-stage.scala:119:23
  reg  [5:0] r_uop_3_lrs2;	// rename-stage.scala:119:23
  reg  [5:0] r_uop_3_lrs3;	// rename-stage.scala:119:23
  reg        r_uop_3_ldst_val;	// rename-stage.scala:119:23
  reg  [1:0] r_uop_3_dst_rtype;	// rename-stage.scala:119:23
  reg  [1:0] r_uop_3_lrs1_rtype;	// rename-stage.scala:119:23
  reg  [1:0] r_uop_3_lrs2_rtype;	// rename-stage.scala:119:23
  reg        r_uop_3_frs3_en;	// rename-stage.scala:119:23
  wire       _io_ren_stalls_0_T = r_uop_dst_rtype == 2'h1;	// rename-stage.scala:119:23, :237:78
  wire       ren2_alloc_reqs_0 = r_uop_ldst_val & _io_ren_stalls_0_T & io_dis_fire_0;	// rename-stage.scala:119:23, :237:{78,88}
  wire       ren2_br_tags_0_valid =
    io_dis_fire_0 & (r_uop_is_br & ~r_uop_is_sfb | r_uop_is_jalr);	// micro-op.scala:146:{33,36,45}, rename-stage.scala:119:23, :238:43
  wire       _rbk_valids_0_T = io_com_uops_0_dst_rtype == 2'h1;	// rename-stage.scala:237:78, :240:82
  wire       rbk_valids_0 = io_com_uops_0_ldst_val & _rbk_valids_0_T & io_rbk_valids_0;	// rename-stage.scala:240:82, :241:92
  wire       _io_ren_stalls_1_T = r_uop_1_dst_rtype == 2'h1;	// rename-stage.scala:119:23, :237:78
  wire       ren2_alloc_reqs_1 = r_uop_1_ldst_val & _io_ren_stalls_1_T & io_dis_fire_1;	// rename-stage.scala:119:23, :237:{78,88}
  wire       ren2_br_tags_1_valid =
    io_dis_fire_1 & (r_uop_1_is_br & ~r_uop_1_is_sfb | r_uop_1_is_jalr);	// micro-op.scala:146:{33,36,45}, rename-stage.scala:119:23, :238:43
  wire       _rbk_valids_1_T = io_com_uops_1_dst_rtype == 2'h1;	// rename-stage.scala:237:78, :240:82
  wire       rbk_valids_1 = io_com_uops_1_ldst_val & _rbk_valids_1_T & io_rbk_valids_1;	// rename-stage.scala:240:82, :241:92
  wire       _io_ren_stalls_2_T = r_uop_2_dst_rtype == 2'h1;	// rename-stage.scala:119:23, :237:78
  wire       ren2_alloc_reqs_2 = r_uop_2_ldst_val & _io_ren_stalls_2_T & io_dis_fire_2;	// rename-stage.scala:119:23, :237:{78,88}
  wire       ren2_br_tags_2_valid =
    io_dis_fire_2 & (r_uop_2_is_br & ~r_uop_2_is_sfb | r_uop_2_is_jalr);	// micro-op.scala:146:{33,36,45}, rename-stage.scala:119:23, :238:43
  wire       _rbk_valids_2_T = io_com_uops_2_dst_rtype == 2'h1;	// rename-stage.scala:237:78, :240:82
  wire       rbk_valids_2 = io_com_uops_2_ldst_val & _rbk_valids_2_T & io_rbk_valids_2;	// rename-stage.scala:240:82, :241:92
  wire       _io_ren_stalls_3_T = r_uop_3_dst_rtype == 2'h1;	// rename-stage.scala:119:23, :237:78
  wire       ren2_alloc_reqs_3 = r_uop_3_ldst_val & _io_ren_stalls_3_T & io_dis_fire_3;	// rename-stage.scala:119:23, :237:{78,88}
  wire       ren2_br_tags_3_valid =
    io_dis_fire_3 & (r_uop_3_is_br & ~r_uop_3_is_sfb | r_uop_3_is_jalr);	// micro-op.scala:146:{33,36,45}, rename-stage.scala:119:23, :238:43
  wire       _rbk_valids_3_T = io_com_uops_3_dst_rtype == 2'h1;	// rename-stage.scala:237:78, :240:82
  wire       rbk_valids_3 = io_com_uops_3_ldst_val & _rbk_valids_3_T & io_rbk_valids_3;	// rename-stage.scala:240:82, :241:92
  `ifndef SYNTHESIS	// rename-stage.scala:297:10
    always @(posedge clock) begin	// rename-stage.scala:297:10
      if (~((~ren2_alloc_reqs_0 | (|_freelist_io_alloc_pregs_0_bits))
            & (~ren2_alloc_reqs_1 | (|_freelist_io_alloc_pregs_1_bits))
            & (~ren2_alloc_reqs_2 | (|_freelist_io_alloc_pregs_2_bits))
            & (~ren2_alloc_reqs_3 | (|_freelist_io_alloc_pregs_3_bits)) | reset)) begin	// rename-stage.scala:217:24, :237:88, :297:{10,74,77,87,105}
        if (`ASSERT_VERBOSE_COND_)	// rename-stage.scala:297:10
          $error("Assertion failed: [rename-stage] A uop is trying to allocate the zero physical register.\n    at rename-stage.scala:297 assert (ren2_alloc_reqs zip freelist.io.alloc_pregs map {case (r,p) => !r || p.bits =/= 0.U} reduce (_&&_),\n");	// rename-stage.scala:297:10
        if (`STOP_COND_)	// rename-stage.scala:297:10
          $fatal;	// rename-stage.scala:297:10
      end
      if (~(~(io_wakeups_0_valid & io_wakeups_0_bits_uop_dst_rtype != 2'h1
              | io_wakeups_1_valid & io_wakeups_1_bits_uop_dst_rtype != 2'h1
              | io_wakeups_2_valid & io_wakeups_2_bits_uop_dst_rtype != 2'h1
              | io_wakeups_3_valid & io_wakeups_3_bits_uop_dst_rtype != 2'h1)
            | reset)) begin	// rename-stage.scala:237:78, :314:{10,11,41,65,84}
        if (`ASSERT_VERBOSE_COND_)	// rename-stage.scala:314:10
          $error("Assertion failed: [rename] Wakeup has wrong rtype.\n    at rename-stage.scala:314 assert (!(io.wakeups.map(x => x.valid && x.bits.uop.dst_rtype =/= rtype).reduce(_||_)),\n");	// rename-stage.scala:314:10
        if (`STOP_COND_)	// rename-stage.scala:314:10
          $fatal;	// rename-stage.scala:314:10
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
  wire       bypassed_uop_bypass_sel_rs1_0 =
    ren2_alloc_reqs_0 & r_uop_ldst == r_uop_1_lrs1;	// rename-stage.scala:119:23, :174:{77,87}, :237:88
  wire       bypassed_uop_bypass_sel_rs2_0 =
    ren2_alloc_reqs_0 & r_uop_ldst == r_uop_1_lrs2;	// rename-stage.scala:119:23, :175:{77,87}, :237:88
  wire       bypassed_uop_bypass_sel_rs3_0 =
    ren2_alloc_reqs_0 & r_uop_ldst == r_uop_1_lrs3;	// rename-stage.scala:119:23, :176:{77,87}, :237:88
  wire       bypassed_uop_bypass_hits_rs1_0_1 =
    ren2_alloc_reqs_0 & r_uop_ldst == r_uop_2_lrs1;	// rename-stage.scala:119:23, :174:{77,87}, :237:88
  wire       bypassed_uop_bypass_hits_rs1_1 =
    ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_2_lrs1;	// rename-stage.scala:119:23, :174:{77,87}, :237:88
  wire       bypassed_uop_bypass_hits_rs2_0_1 =
    ren2_alloc_reqs_0 & r_uop_ldst == r_uop_2_lrs2;	// rename-stage.scala:119:23, :175:{77,87}, :237:88
  wire       bypassed_uop_bypass_hits_rs2_1 =
    ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_2_lrs2;	// rename-stage.scala:119:23, :175:{77,87}, :237:88
  wire       bypassed_uop_bypass_hits_rs3_0_1 =
    ren2_alloc_reqs_0 & r_uop_ldst == r_uop_2_lrs3;	// rename-stage.scala:119:23, :176:{77,87}, :237:88
  wire       bypassed_uop_bypass_hits_rs3_1 =
    ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_2_lrs3;	// rename-stage.scala:119:23, :176:{77,87}, :237:88
  wire       bypassed_uop_bypass_hits_dst_0_1 =
    ren2_alloc_reqs_0 & r_uop_ldst == r_uop_2_ldst;	// rename-stage.scala:119:23, :177:{77,87}, :237:88
  wire       bypassed_uop_bypass_hits_dst_1 =
    ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_2_ldst;	// rename-stage.scala:119:23, :177:{77,87}, :237:88
  wire [1:0] bypassed_uop_bypass_sel_rs1_enc_1 =
    bypassed_uop_bypass_hits_rs1_1 ? 2'h1 : {bypassed_uop_bypass_hits_rs1_0_1, 1'h0};	// Mux.scala:47:69, rename-stage.scala:174:77, :237:78
  wire [1:0] bypassed_uop_bypass_sel_rs2_enc_1 =
    bypassed_uop_bypass_hits_rs2_1 ? 2'h1 : {bypassed_uop_bypass_hits_rs2_0_1, 1'h0};	// Mux.scala:47:69, rename-stage.scala:175:77, :237:78
  wire [1:0] bypassed_uop_bypass_sel_rs3_enc_1 =
    bypassed_uop_bypass_hits_rs3_1 ? 2'h1 : {bypassed_uop_bypass_hits_rs3_0_1, 1'h0};	// Mux.scala:47:69, rename-stage.scala:176:77, :237:78
  wire [1:0] bypassed_uop_bypass_sel_dst_enc_1 =
    bypassed_uop_bypass_hits_dst_1 ? 2'h1 : {bypassed_uop_bypass_hits_dst_0_1, 1'h0};	// Mux.scala:47:69, rename-stage.scala:177:77, :237:78
  wire       bypassed_uop_do_bypass_rs1 =
    bypassed_uop_bypass_hits_rs1_0_1 | bypassed_uop_bypass_hits_rs1_1;	// rename-stage.scala:174:77, :184:49
  wire       bypassed_uop_do_bypass_rs2 =
    bypassed_uop_bypass_hits_rs2_0_1 | bypassed_uop_bypass_hits_rs2_1;	// rename-stage.scala:175:77, :185:49
  wire       bypassed_uop_do_bypass_rs3 =
    bypassed_uop_bypass_hits_rs3_0_1 | bypassed_uop_bypass_hits_rs3_1;	// rename-stage.scala:176:77, :186:49
  wire       bypassed_uop_bypass_hits_rs1_0_2 =
    ren2_alloc_reqs_0 & r_uop_ldst == r_uop_3_lrs1;	// rename-stage.scala:119:23, :174:{77,87}, :237:88
  wire       bypassed_uop_bypass_hits_rs1_1_1 =
    ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_3_lrs1;	// rename-stage.scala:119:23, :174:{77,87}, :237:88
  wire       bypassed_uop_bypass_hits_rs1_2 =
    ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_3_lrs1;	// rename-stage.scala:119:23, :174:{77,87}, :237:88
  wire       bypassed_uop_bypass_hits_rs2_0_2 =
    ren2_alloc_reqs_0 & r_uop_ldst == r_uop_3_lrs2;	// rename-stage.scala:119:23, :175:{77,87}, :237:88
  wire       bypassed_uop_bypass_hits_rs2_1_1 =
    ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_3_lrs2;	// rename-stage.scala:119:23, :175:{77,87}, :237:88
  wire       bypassed_uop_bypass_hits_rs2_2 =
    ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_3_lrs2;	// rename-stage.scala:119:23, :175:{77,87}, :237:88
  wire       bypassed_uop_bypass_hits_rs3_0_2 =
    ren2_alloc_reqs_0 & r_uop_ldst == r_uop_3_lrs3;	// rename-stage.scala:119:23, :176:{77,87}, :237:88
  wire       bypassed_uop_bypass_hits_rs3_1_1 =
    ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_3_lrs3;	// rename-stage.scala:119:23, :176:{77,87}, :237:88
  wire       bypassed_uop_bypass_hits_rs3_2 =
    ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_3_lrs3;	// rename-stage.scala:119:23, :176:{77,87}, :237:88
  wire       bypassed_uop_bypass_hits_dst_0_2 =
    ren2_alloc_reqs_0 & r_uop_ldst == r_uop_3_ldst;	// rename-stage.scala:119:23, :177:{77,87}, :237:88
  wire       bypassed_uop_bypass_hits_dst_1_1 =
    ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_3_ldst;	// rename-stage.scala:119:23, :177:{77,87}, :237:88
  wire       bypassed_uop_bypass_hits_dst_2 =
    ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_3_ldst;	// rename-stage.scala:119:23, :177:{77,87}, :237:88
  wire [2:0] bypassed_uop_bypass_sel_rs1_enc_2 =
    bypassed_uop_bypass_hits_rs1_2
      ? 3'h1
      : bypassed_uop_bypass_hits_rs1_1_1
          ? 3'h2
          : {bypassed_uop_bypass_hits_rs1_0_2, 2'h0};	// Mux.scala:47:69, rename-stage.scala:174:77
  wire [2:0] bypassed_uop_bypass_sel_rs2_enc_2 =
    bypassed_uop_bypass_hits_rs2_2
      ? 3'h1
      : bypassed_uop_bypass_hits_rs2_1_1
          ? 3'h2
          : {bypassed_uop_bypass_hits_rs2_0_2, 2'h0};	// Mux.scala:47:69, rename-stage.scala:175:77
  wire [2:0] bypassed_uop_bypass_sel_rs3_enc_2 =
    bypassed_uop_bypass_hits_rs3_2
      ? 3'h1
      : bypassed_uop_bypass_hits_rs3_1_1
          ? 3'h2
          : {bypassed_uop_bypass_hits_rs3_0_2, 2'h0};	// Mux.scala:47:69, rename-stage.scala:176:77
  wire [2:0] bypassed_uop_bypass_sel_dst_enc_2 =
    bypassed_uop_bypass_hits_dst_2
      ? 3'h1
      : bypassed_uop_bypass_hits_dst_1_1
          ? 3'h2
          : {bypassed_uop_bypass_hits_dst_0_2, 2'h0};	// Mux.scala:47:69, rename-stage.scala:177:77
  wire       bypassed_uop_do_bypass_rs1_1 =
    bypassed_uop_bypass_hits_rs1_0_2 | bypassed_uop_bypass_hits_rs1_1_1
    | bypassed_uop_bypass_hits_rs1_2;	// rename-stage.scala:174:77, :184:49
  wire       bypassed_uop_do_bypass_rs2_1 =
    bypassed_uop_bypass_hits_rs2_0_2 | bypassed_uop_bypass_hits_rs2_1_1
    | bypassed_uop_bypass_hits_rs2_2;	// rename-stage.scala:175:77, :185:49
  wire       bypassed_uop_do_bypass_rs3_1 =
    bypassed_uop_bypass_hits_rs3_0_2 | bypassed_uop_bypass_hits_rs3_1_1
    | bypassed_uop_bypass_hits_rs3_2;	// rename-stage.scala:176:77, :186:49
  always @(posedge clock) begin
    automatic logic       _GEN;	// rename-stage.scala:122:14, :124:20, :126:30
    automatic logic [5:0] r_uop_newuop_lrs3;	// rename-stage.scala:122:14, :124:20, :126:30
    automatic logic [5:0] r_uop_newuop_lrs2;	// rename-stage.scala:122:14, :124:20, :126:30
    automatic logic [5:0] r_uop_newuop_lrs1;	// rename-stage.scala:122:14, :124:20, :126:30
    automatic logic [5:0] r_uop_newuop_ldst;	// rename-stage.scala:122:14, :124:20, :126:30
    automatic logic       r_uop_bypass_hits_rs1_0;	// rename-stage.scala:174:77
    automatic logic       r_uop_bypass_hits_rs1_1;	// rename-stage.scala:174:77
    automatic logic       r_uop_bypass_hits_rs1_2;	// rename-stage.scala:174:77
    automatic logic       r_uop_bypass_hits_rs1_3;	// rename-stage.scala:174:77
    automatic logic       r_uop_bypass_hits_rs2_0;	// rename-stage.scala:175:77
    automatic logic       r_uop_bypass_hits_rs2_1;	// rename-stage.scala:175:77
    automatic logic       r_uop_bypass_hits_rs2_2;	// rename-stage.scala:175:77
    automatic logic       r_uop_bypass_hits_rs2_3;	// rename-stage.scala:175:77
    automatic logic       r_uop_bypass_hits_rs3_0;	// rename-stage.scala:176:77
    automatic logic       r_uop_bypass_hits_rs3_1;	// rename-stage.scala:176:77
    automatic logic       r_uop_bypass_hits_rs3_2;	// rename-stage.scala:176:77
    automatic logic       r_uop_bypass_hits_rs3_3;	// rename-stage.scala:176:77
    automatic logic       r_uop_bypass_hits_dst_0;	// rename-stage.scala:177:77
    automatic logic       r_uop_bypass_hits_dst_1;	// rename-stage.scala:177:77
    automatic logic       r_uop_bypass_hits_dst_2;	// rename-stage.scala:177:77
    automatic logic       r_uop_bypass_hits_dst_3;	// rename-stage.scala:177:77
    automatic logic [5:0] r_uop_newuop_1_lrs3;	// rename-stage.scala:122:14, :124:20, :126:30
    automatic logic [5:0] r_uop_newuop_1_lrs2;	// rename-stage.scala:122:14, :124:20, :126:30
    automatic logic [5:0] r_uop_newuop_1_lrs1;	// rename-stage.scala:122:14, :124:20, :126:30
    automatic logic [5:0] r_uop_newuop_1_ldst;	// rename-stage.scala:122:14, :124:20, :126:30
    automatic logic       r_uop_bypass_hits_rs1_0_1;	// rename-stage.scala:174:77
    automatic logic       r_uop_bypass_hits_rs1_1_1;	// rename-stage.scala:174:77
    automatic logic       r_uop_bypass_hits_rs1_2_1;	// rename-stage.scala:174:77
    automatic logic       r_uop_bypass_hits_rs1_3_1;	// rename-stage.scala:174:77
    automatic logic       r_uop_bypass_hits_rs2_0_1;	// rename-stage.scala:175:77
    automatic logic       r_uop_bypass_hits_rs2_1_1;	// rename-stage.scala:175:77
    automatic logic       r_uop_bypass_hits_rs2_2_1;	// rename-stage.scala:175:77
    automatic logic       r_uop_bypass_hits_rs2_3_1;	// rename-stage.scala:175:77
    automatic logic       r_uop_bypass_hits_rs3_0_1;	// rename-stage.scala:176:77
    automatic logic       r_uop_bypass_hits_rs3_1_1;	// rename-stage.scala:176:77
    automatic logic       r_uop_bypass_hits_rs3_2_1;	// rename-stage.scala:176:77
    automatic logic       r_uop_bypass_hits_rs3_3_1;	// rename-stage.scala:176:77
    automatic logic       r_uop_bypass_hits_dst_0_1;	// rename-stage.scala:177:77
    automatic logic       r_uop_bypass_hits_dst_1_1;	// rename-stage.scala:177:77
    automatic logic       r_uop_bypass_hits_dst_2_1;	// rename-stage.scala:177:77
    automatic logic       r_uop_bypass_hits_dst_3_1;	// rename-stage.scala:177:77
    automatic logic [5:0] r_uop_newuop_2_lrs3;	// rename-stage.scala:122:14, :124:20, :126:30
    automatic logic [5:0] r_uop_newuop_2_lrs2;	// rename-stage.scala:122:14, :124:20, :126:30
    automatic logic [5:0] r_uop_newuop_2_lrs1;	// rename-stage.scala:122:14, :124:20, :126:30
    automatic logic [5:0] r_uop_newuop_2_ldst;	// rename-stage.scala:122:14, :124:20, :126:30
    automatic logic       r_uop_bypass_hits_rs1_0_2;	// rename-stage.scala:174:77
    automatic logic       r_uop_bypass_hits_rs1_1_2;	// rename-stage.scala:174:77
    automatic logic       r_uop_bypass_hits_rs1_2_2;	// rename-stage.scala:174:77
    automatic logic       r_uop_bypass_hits_rs1_3_2;	// rename-stage.scala:174:77
    automatic logic       r_uop_bypass_hits_rs2_0_2;	// rename-stage.scala:175:77
    automatic logic       r_uop_bypass_hits_rs2_1_2;	// rename-stage.scala:175:77
    automatic logic       r_uop_bypass_hits_rs2_2_2;	// rename-stage.scala:175:77
    automatic logic       r_uop_bypass_hits_rs2_3_2;	// rename-stage.scala:175:77
    automatic logic       r_uop_bypass_hits_rs3_0_2;	// rename-stage.scala:176:77
    automatic logic       r_uop_bypass_hits_rs3_1_2;	// rename-stage.scala:176:77
    automatic logic       r_uop_bypass_hits_rs3_2_2;	// rename-stage.scala:176:77
    automatic logic       r_uop_bypass_hits_rs3_3_2;	// rename-stage.scala:176:77
    automatic logic       r_uop_bypass_hits_dst_0_2;	// rename-stage.scala:177:77
    automatic logic       r_uop_bypass_hits_dst_1_2;	// rename-stage.scala:177:77
    automatic logic       r_uop_bypass_hits_dst_2_2;	// rename-stage.scala:177:77
    automatic logic       r_uop_bypass_hits_dst_3_2;	// rename-stage.scala:177:77
    automatic logic [5:0] r_uop_newuop_3_lrs3;	// rename-stage.scala:122:14, :124:20, :126:30
    automatic logic [5:0] r_uop_newuop_3_lrs2;	// rename-stage.scala:122:14, :124:20, :126:30
    automatic logic [5:0] r_uop_newuop_3_lrs1;	// rename-stage.scala:122:14, :124:20, :126:30
    automatic logic [5:0] r_uop_newuop_3_ldst;	// rename-stage.scala:122:14, :124:20, :126:30
    automatic logic       r_uop_bypass_hits_rs1_0_3;	// rename-stage.scala:174:77
    automatic logic       r_uop_bypass_hits_rs1_1_3;	// rename-stage.scala:174:77
    automatic logic       r_uop_bypass_hits_rs1_2_3;	// rename-stage.scala:174:77
    automatic logic       r_uop_bypass_hits_rs1_3_3;	// rename-stage.scala:174:77
    automatic logic       r_uop_bypass_hits_rs2_0_3;	// rename-stage.scala:175:77
    automatic logic       r_uop_bypass_hits_rs2_1_3;	// rename-stage.scala:175:77
    automatic logic       r_uop_bypass_hits_rs2_2_3;	// rename-stage.scala:175:77
    automatic logic       r_uop_bypass_hits_rs2_3_3;	// rename-stage.scala:175:77
    automatic logic       r_uop_bypass_hits_rs3_0_3;	// rename-stage.scala:176:77
    automatic logic       r_uop_bypass_hits_rs3_1_3;	// rename-stage.scala:176:77
    automatic logic       r_uop_bypass_hits_rs3_2_3;	// rename-stage.scala:176:77
    automatic logic       r_uop_bypass_hits_rs3_3_3;	// rename-stage.scala:176:77
    automatic logic       r_uop_bypass_hits_dst_0_3;	// rename-stage.scala:177:77
    automatic logic       r_uop_bypass_hits_dst_1_3;	// rename-stage.scala:177:77
    automatic logic       r_uop_bypass_hits_dst_2_3;	// rename-stage.scala:177:77
    automatic logic       r_uop_bypass_hits_dst_3_3;	// rename-stage.scala:177:77
    _GEN = io_kill | ~io_dis_ready;	// rename-stage.scala:122:14, :124:20, :126:30
    r_uop_newuop_lrs3 = _GEN ? r_uop_lrs3 : io_dec_uops_0_lrs3;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30
    r_uop_newuop_lrs2 = _GEN ? r_uop_lrs2 : io_dec_uops_0_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30
    r_uop_newuop_lrs1 = _GEN ? r_uop_lrs1 : io_dec_uops_0_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30
    r_uop_newuop_ldst = _GEN ? r_uop_ldst : io_dec_uops_0_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30
    r_uop_bypass_hits_rs1_0 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_newuop_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :174:{77,87}, :237:88
    r_uop_bypass_hits_rs1_1 = ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_newuop_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :174:{77,87}, :237:88
    r_uop_bypass_hits_rs1_2 = ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_newuop_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :174:{77,87}, :237:88
    r_uop_bypass_hits_rs1_3 = ren2_alloc_reqs_3 & r_uop_3_ldst == r_uop_newuop_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :174:{77,87}, :237:88
    r_uop_bypass_hits_rs2_0 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_newuop_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :175:{77,87}, :237:88
    r_uop_bypass_hits_rs2_1 = ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_newuop_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :175:{77,87}, :237:88
    r_uop_bypass_hits_rs2_2 = ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_newuop_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :175:{77,87}, :237:88
    r_uop_bypass_hits_rs2_3 = ren2_alloc_reqs_3 & r_uop_3_ldst == r_uop_newuop_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :175:{77,87}, :237:88
    r_uop_bypass_hits_rs3_0 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_newuop_lrs3;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :176:{77,87}, :237:88
    r_uop_bypass_hits_rs3_1 = ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_newuop_lrs3;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :176:{77,87}, :237:88
    r_uop_bypass_hits_rs3_2 = ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_newuop_lrs3;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :176:{77,87}, :237:88
    r_uop_bypass_hits_rs3_3 = ren2_alloc_reqs_3 & r_uop_3_ldst == r_uop_newuop_lrs3;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :176:{77,87}, :237:88
    r_uop_bypass_hits_dst_0 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_newuop_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :177:{77,87}, :237:88
    r_uop_bypass_hits_dst_1 = ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_newuop_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :177:{77,87}, :237:88
    r_uop_bypass_hits_dst_2 = ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_newuop_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :177:{77,87}, :237:88
    r_uop_bypass_hits_dst_3 = ren2_alloc_reqs_3 & r_uop_3_ldst == r_uop_newuop_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :177:{77,87}, :237:88
    r_uop_newuop_1_lrs3 = _GEN ? r_uop_1_lrs3 : io_dec_uops_1_lrs3;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30
    r_uop_newuop_1_lrs2 = _GEN ? r_uop_1_lrs2 : io_dec_uops_1_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30
    r_uop_newuop_1_lrs1 = _GEN ? r_uop_1_lrs1 : io_dec_uops_1_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30
    r_uop_newuop_1_ldst = _GEN ? r_uop_1_ldst : io_dec_uops_1_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30
    r_uop_bypass_hits_rs1_0_1 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_newuop_1_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :174:{77,87}, :237:88
    r_uop_bypass_hits_rs1_1_1 = ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_newuop_1_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :174:{77,87}, :237:88
    r_uop_bypass_hits_rs1_2_1 = ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_newuop_1_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :174:{77,87}, :237:88
    r_uop_bypass_hits_rs1_3_1 = ren2_alloc_reqs_3 & r_uop_3_ldst == r_uop_newuop_1_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :174:{77,87}, :237:88
    r_uop_bypass_hits_rs2_0_1 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_newuop_1_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :175:{77,87}, :237:88
    r_uop_bypass_hits_rs2_1_1 = ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_newuop_1_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :175:{77,87}, :237:88
    r_uop_bypass_hits_rs2_2_1 = ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_newuop_1_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :175:{77,87}, :237:88
    r_uop_bypass_hits_rs2_3_1 = ren2_alloc_reqs_3 & r_uop_3_ldst == r_uop_newuop_1_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :175:{77,87}, :237:88
    r_uop_bypass_hits_rs3_0_1 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_newuop_1_lrs3;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :176:{77,87}, :237:88
    r_uop_bypass_hits_rs3_1_1 = ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_newuop_1_lrs3;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :176:{77,87}, :237:88
    r_uop_bypass_hits_rs3_2_1 = ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_newuop_1_lrs3;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :176:{77,87}, :237:88
    r_uop_bypass_hits_rs3_3_1 = ren2_alloc_reqs_3 & r_uop_3_ldst == r_uop_newuop_1_lrs3;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :176:{77,87}, :237:88
    r_uop_bypass_hits_dst_0_1 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_newuop_1_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :177:{77,87}, :237:88
    r_uop_bypass_hits_dst_1_1 = ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_newuop_1_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :177:{77,87}, :237:88
    r_uop_bypass_hits_dst_2_1 = ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_newuop_1_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :177:{77,87}, :237:88
    r_uop_bypass_hits_dst_3_1 = ren2_alloc_reqs_3 & r_uop_3_ldst == r_uop_newuop_1_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :177:{77,87}, :237:88
    r_uop_newuop_2_lrs3 = _GEN ? r_uop_2_lrs3 : io_dec_uops_2_lrs3;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30
    r_uop_newuop_2_lrs2 = _GEN ? r_uop_2_lrs2 : io_dec_uops_2_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30
    r_uop_newuop_2_lrs1 = _GEN ? r_uop_2_lrs1 : io_dec_uops_2_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30
    r_uop_newuop_2_ldst = _GEN ? r_uop_2_ldst : io_dec_uops_2_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30
    r_uop_bypass_hits_rs1_0_2 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_newuop_2_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :174:{77,87}, :237:88
    r_uop_bypass_hits_rs1_1_2 = ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_newuop_2_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :174:{77,87}, :237:88
    r_uop_bypass_hits_rs1_2_2 = ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_newuop_2_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :174:{77,87}, :237:88
    r_uop_bypass_hits_rs1_3_2 = ren2_alloc_reqs_3 & r_uop_3_ldst == r_uop_newuop_2_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :174:{77,87}, :237:88
    r_uop_bypass_hits_rs2_0_2 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_newuop_2_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :175:{77,87}, :237:88
    r_uop_bypass_hits_rs2_1_2 = ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_newuop_2_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :175:{77,87}, :237:88
    r_uop_bypass_hits_rs2_2_2 = ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_newuop_2_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :175:{77,87}, :237:88
    r_uop_bypass_hits_rs2_3_2 = ren2_alloc_reqs_3 & r_uop_3_ldst == r_uop_newuop_2_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :175:{77,87}, :237:88
    r_uop_bypass_hits_rs3_0_2 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_newuop_2_lrs3;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :176:{77,87}, :237:88
    r_uop_bypass_hits_rs3_1_2 = ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_newuop_2_lrs3;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :176:{77,87}, :237:88
    r_uop_bypass_hits_rs3_2_2 = ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_newuop_2_lrs3;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :176:{77,87}, :237:88
    r_uop_bypass_hits_rs3_3_2 = ren2_alloc_reqs_3 & r_uop_3_ldst == r_uop_newuop_2_lrs3;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :176:{77,87}, :237:88
    r_uop_bypass_hits_dst_0_2 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_newuop_2_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :177:{77,87}, :237:88
    r_uop_bypass_hits_dst_1_2 = ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_newuop_2_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :177:{77,87}, :237:88
    r_uop_bypass_hits_dst_2_2 = ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_newuop_2_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :177:{77,87}, :237:88
    r_uop_bypass_hits_dst_3_2 = ren2_alloc_reqs_3 & r_uop_3_ldst == r_uop_newuop_2_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :177:{77,87}, :237:88
    r_uop_newuop_3_lrs3 = _GEN ? r_uop_3_lrs3 : io_dec_uops_3_lrs3;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30
    r_uop_newuop_3_lrs2 = _GEN ? r_uop_3_lrs2 : io_dec_uops_3_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30
    r_uop_newuop_3_lrs1 = _GEN ? r_uop_3_lrs1 : io_dec_uops_3_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30
    r_uop_newuop_3_ldst = _GEN ? r_uop_3_ldst : io_dec_uops_3_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30
    r_uop_bypass_hits_rs1_0_3 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_newuop_3_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :174:{77,87}, :237:88
    r_uop_bypass_hits_rs1_1_3 = ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_newuop_3_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :174:{77,87}, :237:88
    r_uop_bypass_hits_rs1_2_3 = ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_newuop_3_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :174:{77,87}, :237:88
    r_uop_bypass_hits_rs1_3_3 = ren2_alloc_reqs_3 & r_uop_3_ldst == r_uop_newuop_3_lrs1;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :174:{77,87}, :237:88
    r_uop_bypass_hits_rs2_0_3 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_newuop_3_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :175:{77,87}, :237:88
    r_uop_bypass_hits_rs2_1_3 = ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_newuop_3_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :175:{77,87}, :237:88
    r_uop_bypass_hits_rs2_2_3 = ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_newuop_3_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :175:{77,87}, :237:88
    r_uop_bypass_hits_rs2_3_3 = ren2_alloc_reqs_3 & r_uop_3_ldst == r_uop_newuop_3_lrs2;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :175:{77,87}, :237:88
    r_uop_bypass_hits_rs3_0_3 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_newuop_3_lrs3;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :176:{77,87}, :237:88
    r_uop_bypass_hits_rs3_1_3 = ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_newuop_3_lrs3;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :176:{77,87}, :237:88
    r_uop_bypass_hits_rs3_2_3 = ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_newuop_3_lrs3;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :176:{77,87}, :237:88
    r_uop_bypass_hits_rs3_3_3 = ren2_alloc_reqs_3 & r_uop_3_ldst == r_uop_newuop_3_lrs3;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :176:{77,87}, :237:88
    r_uop_bypass_hits_dst_0_3 = ren2_alloc_reqs_0 & r_uop_ldst == r_uop_newuop_3_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :177:{77,87}, :237:88
    r_uop_bypass_hits_dst_1_3 = ren2_alloc_reqs_1 & r_uop_1_ldst == r_uop_newuop_3_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :177:{77,87}, :237:88
    r_uop_bypass_hits_dst_2_3 = ren2_alloc_reqs_2 & r_uop_2_ldst == r_uop_newuop_3_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :177:{77,87}, :237:88
    r_uop_bypass_hits_dst_3_3 = ren2_alloc_reqs_3 & r_uop_3_ldst == r_uop_newuop_3_ldst;	// rename-stage.scala:119:23, :122:14, :124:20, :126:30, :177:{77,87}, :237:88
    if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else begin	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_is_br <= io_dec_uops_0_is_br;	// rename-stage.scala:119:23
      r_uop_is_jalr <= io_dec_uops_0_is_jalr;	// rename-stage.scala:119:23
      r_uop_is_sfb <= io_dec_uops_0_is_sfb;	// rename-stage.scala:119:23
      r_uop_br_tag <= io_dec_uops_0_br_tag;	// rename-stage.scala:119:23
    end
    if (r_uop_bypass_hits_rs1_0 | r_uop_bypass_hits_rs1_1 | r_uop_bypass_hits_rs1_2
        | r_uop_bypass_hits_rs1_3) begin	// rename-stage.scala:174:77, :184:49
      automatic logic [3:0] r_uop_bypass_sel_rs1_enc;	// Mux.scala:47:69
      r_uop_bypass_sel_rs1_enc =
        r_uop_bypass_hits_rs1_3
          ? 4'h1
          : r_uop_bypass_hits_rs1_2
              ? 4'h2
              : r_uop_bypass_hits_rs1_1 ? 4'h4 : {r_uop_bypass_hits_rs1_0, 3'h0};	// Mux.scala:47:69, rename-stage.scala:174:77
      r_uop_prs1 <=
        (r_uop_bypass_sel_rs1_enc[3] ? _freelist_io_alloc_pregs_0_bits : 7'h0)
        | (r_uop_bypass_sel_rs1_enc[2] ? _freelist_io_alloc_pregs_1_bits : 7'h0)
        | (r_uop_bypass_sel_rs1_enc[1] ? _freelist_io_alloc_pregs_2_bits : 7'h0)
        | (r_uop_bypass_sel_rs1_enc[0] ? _freelist_io_alloc_pregs_3_bits : 7'h0);	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :217:24
    end
    else if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_prs1 <= _maptable_io_map_resps_0_prs1;	// rename-stage.scala:119:23, :211:24
    if (r_uop_bypass_hits_rs2_0 | r_uop_bypass_hits_rs2_1 | r_uop_bypass_hits_rs2_2
        | r_uop_bypass_hits_rs2_3) begin	// rename-stage.scala:175:77, :185:49
      automatic logic [3:0] r_uop_bypass_sel_rs2_enc;	// Mux.scala:47:69
      r_uop_bypass_sel_rs2_enc =
        r_uop_bypass_hits_rs2_3
          ? 4'h1
          : r_uop_bypass_hits_rs2_2
              ? 4'h2
              : r_uop_bypass_hits_rs2_1 ? 4'h4 : {r_uop_bypass_hits_rs2_0, 3'h0};	// Mux.scala:47:69, rename-stage.scala:175:77
      r_uop_prs2 <=
        (r_uop_bypass_sel_rs2_enc[3] ? _freelist_io_alloc_pregs_0_bits : 7'h0)
        | (r_uop_bypass_sel_rs2_enc[2] ? _freelist_io_alloc_pregs_1_bits : 7'h0)
        | (r_uop_bypass_sel_rs2_enc[1] ? _freelist_io_alloc_pregs_2_bits : 7'h0)
        | (r_uop_bypass_sel_rs2_enc[0] ? _freelist_io_alloc_pregs_3_bits : 7'h0);	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :217:24
    end
    else if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_prs2 <= _maptable_io_map_resps_0_prs2;	// rename-stage.scala:119:23, :211:24
    if (r_uop_bypass_hits_rs3_0 | r_uop_bypass_hits_rs3_1 | r_uop_bypass_hits_rs3_2
        | r_uop_bypass_hits_rs3_3) begin	// rename-stage.scala:176:77, :186:49
      automatic logic [3:0] r_uop_bypass_sel_rs3_enc;	// Mux.scala:47:69
      r_uop_bypass_sel_rs3_enc =
        r_uop_bypass_hits_rs3_3
          ? 4'h1
          : r_uop_bypass_hits_rs3_2
              ? 4'h2
              : r_uop_bypass_hits_rs3_1 ? 4'h4 : {r_uop_bypass_hits_rs3_0, 3'h0};	// Mux.scala:47:69, rename-stage.scala:176:77
      r_uop_prs3 <=
        (r_uop_bypass_sel_rs3_enc[3] ? _freelist_io_alloc_pregs_0_bits : 7'h0)
        | (r_uop_bypass_sel_rs3_enc[2] ? _freelist_io_alloc_pregs_1_bits : 7'h0)
        | (r_uop_bypass_sel_rs3_enc[1] ? _freelist_io_alloc_pregs_2_bits : 7'h0)
        | (r_uop_bypass_sel_rs3_enc[0] ? _freelist_io_alloc_pregs_3_bits : 7'h0);	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :217:24
    end
    else if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_prs3 <= _maptable_io_map_resps_0_prs3;	// rename-stage.scala:119:23, :211:24
    if (r_uop_bypass_hits_dst_0 | r_uop_bypass_hits_dst_1 | r_uop_bypass_hits_dst_2
        | r_uop_bypass_hits_dst_3) begin	// rename-stage.scala:177:77, :187:49
      automatic logic [3:0] r_uop_bypass_sel_dst_enc;	// Mux.scala:47:69
      r_uop_bypass_sel_dst_enc =
        r_uop_bypass_hits_dst_3
          ? 4'h1
          : r_uop_bypass_hits_dst_2
              ? 4'h2
              : r_uop_bypass_hits_dst_1 ? 4'h4 : {r_uop_bypass_hits_dst_0, 3'h0};	// Mux.scala:47:69, rename-stage.scala:177:77
      r_uop_stale_pdst <=
        (r_uop_bypass_sel_dst_enc[3] ? _freelist_io_alloc_pregs_0_bits : 7'h0)
        | (r_uop_bypass_sel_dst_enc[2] ? _freelist_io_alloc_pregs_1_bits : 7'h0)
        | (r_uop_bypass_sel_dst_enc[1] ? _freelist_io_alloc_pregs_2_bits : 7'h0)
        | (r_uop_bypass_sel_dst_enc[0] ? _freelist_io_alloc_pregs_3_bits : 7'h0);	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :217:24
    end
    else if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_stale_pdst <= _maptable_io_map_resps_0_stale_pdst;	// rename-stage.scala:119:23, :211:24
    if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else begin	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_ldst <= io_dec_uops_0_ldst;	// rename-stage.scala:119:23
      r_uop_lrs1 <= io_dec_uops_0_lrs1;	// rename-stage.scala:119:23
      r_uop_lrs2 <= io_dec_uops_0_lrs2;	// rename-stage.scala:119:23
      r_uop_lrs3 <= io_dec_uops_0_lrs3;	// rename-stage.scala:119:23
      r_uop_ldst_val <= io_dec_uops_0_ldst_val;	// rename-stage.scala:119:23
      r_uop_dst_rtype <= io_dec_uops_0_dst_rtype;	// rename-stage.scala:119:23
      r_uop_lrs1_rtype <= io_dec_uops_0_lrs1_rtype;	// rename-stage.scala:119:23
      r_uop_lrs2_rtype <= io_dec_uops_0_lrs2_rtype;	// rename-stage.scala:119:23
      r_uop_frs3_en <= io_dec_uops_0_frs3_en;	// rename-stage.scala:119:23
      r_uop_1_is_br <= io_dec_uops_1_is_br;	// rename-stage.scala:119:23
      r_uop_1_is_jalr <= io_dec_uops_1_is_jalr;	// rename-stage.scala:119:23
      r_uop_1_is_sfb <= io_dec_uops_1_is_sfb;	// rename-stage.scala:119:23
      r_uop_1_br_tag <= io_dec_uops_1_br_tag;	// rename-stage.scala:119:23
    end
    if (r_uop_bypass_hits_rs1_0_1 | r_uop_bypass_hits_rs1_1_1 | r_uop_bypass_hits_rs1_2_1
        | r_uop_bypass_hits_rs1_3_1) begin	// rename-stage.scala:174:77, :184:49
      automatic logic [3:0] r_uop_bypass_sel_rs1_enc_1;	// Mux.scala:47:69
      r_uop_bypass_sel_rs1_enc_1 =
        r_uop_bypass_hits_rs1_3_1
          ? 4'h1
          : r_uop_bypass_hits_rs1_2_1
              ? 4'h2
              : r_uop_bypass_hits_rs1_1_1 ? 4'h4 : {r_uop_bypass_hits_rs1_0_1, 3'h0};	// Mux.scala:47:69, rename-stage.scala:174:77
      r_uop_1_prs1 <=
        (r_uop_bypass_sel_rs1_enc_1[3] ? _freelist_io_alloc_pregs_0_bits : 7'h0)
        | (r_uop_bypass_sel_rs1_enc_1[2] ? _freelist_io_alloc_pregs_1_bits : 7'h0)
        | (r_uop_bypass_sel_rs1_enc_1[1] ? _freelist_io_alloc_pregs_2_bits : 7'h0)
        | (r_uop_bypass_sel_rs1_enc_1[0] ? _freelist_io_alloc_pregs_3_bits : 7'h0);	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :217:24
    end
    else if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_1_prs1 <= _maptable_io_map_resps_1_prs1;	// rename-stage.scala:119:23, :211:24
    if (r_uop_bypass_hits_rs2_0_1 | r_uop_bypass_hits_rs2_1_1 | r_uop_bypass_hits_rs2_2_1
        | r_uop_bypass_hits_rs2_3_1) begin	// rename-stage.scala:175:77, :185:49
      automatic logic [3:0] r_uop_bypass_sel_rs2_enc_1;	// Mux.scala:47:69
      r_uop_bypass_sel_rs2_enc_1 =
        r_uop_bypass_hits_rs2_3_1
          ? 4'h1
          : r_uop_bypass_hits_rs2_2_1
              ? 4'h2
              : r_uop_bypass_hits_rs2_1_1 ? 4'h4 : {r_uop_bypass_hits_rs2_0_1, 3'h0};	// Mux.scala:47:69, rename-stage.scala:175:77
      r_uop_1_prs2 <=
        (r_uop_bypass_sel_rs2_enc_1[3] ? _freelist_io_alloc_pregs_0_bits : 7'h0)
        | (r_uop_bypass_sel_rs2_enc_1[2] ? _freelist_io_alloc_pregs_1_bits : 7'h0)
        | (r_uop_bypass_sel_rs2_enc_1[1] ? _freelist_io_alloc_pregs_2_bits : 7'h0)
        | (r_uop_bypass_sel_rs2_enc_1[0] ? _freelist_io_alloc_pregs_3_bits : 7'h0);	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :217:24
    end
    else if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_1_prs2 <= _maptable_io_map_resps_1_prs2;	// rename-stage.scala:119:23, :211:24
    if (r_uop_bypass_hits_rs3_0_1 | r_uop_bypass_hits_rs3_1_1 | r_uop_bypass_hits_rs3_2_1
        | r_uop_bypass_hits_rs3_3_1) begin	// rename-stage.scala:176:77, :186:49
      automatic logic [3:0] r_uop_bypass_sel_rs3_enc_1;	// Mux.scala:47:69
      r_uop_bypass_sel_rs3_enc_1 =
        r_uop_bypass_hits_rs3_3_1
          ? 4'h1
          : r_uop_bypass_hits_rs3_2_1
              ? 4'h2
              : r_uop_bypass_hits_rs3_1_1 ? 4'h4 : {r_uop_bypass_hits_rs3_0_1, 3'h0};	// Mux.scala:47:69, rename-stage.scala:176:77
      r_uop_1_prs3 <=
        (r_uop_bypass_sel_rs3_enc_1[3] ? _freelist_io_alloc_pregs_0_bits : 7'h0)
        | (r_uop_bypass_sel_rs3_enc_1[2] ? _freelist_io_alloc_pregs_1_bits : 7'h0)
        | (r_uop_bypass_sel_rs3_enc_1[1] ? _freelist_io_alloc_pregs_2_bits : 7'h0)
        | (r_uop_bypass_sel_rs3_enc_1[0] ? _freelist_io_alloc_pregs_3_bits : 7'h0);	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :217:24
    end
    else if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_1_prs3 <= _maptable_io_map_resps_1_prs3;	// rename-stage.scala:119:23, :211:24
    if (r_uop_bypass_hits_dst_0_1 | r_uop_bypass_hits_dst_1_1 | r_uop_bypass_hits_dst_2_1
        | r_uop_bypass_hits_dst_3_1) begin	// rename-stage.scala:177:77, :187:49
      automatic logic [3:0] r_uop_bypass_sel_dst_enc_1;	// Mux.scala:47:69
      r_uop_bypass_sel_dst_enc_1 =
        r_uop_bypass_hits_dst_3_1
          ? 4'h1
          : r_uop_bypass_hits_dst_2_1
              ? 4'h2
              : r_uop_bypass_hits_dst_1_1 ? 4'h4 : {r_uop_bypass_hits_dst_0_1, 3'h0};	// Mux.scala:47:69, rename-stage.scala:177:77
      r_uop_1_stale_pdst <=
        (r_uop_bypass_sel_dst_enc_1[3] ? _freelist_io_alloc_pregs_0_bits : 7'h0)
        | (r_uop_bypass_sel_dst_enc_1[2] ? _freelist_io_alloc_pregs_1_bits : 7'h0)
        | (r_uop_bypass_sel_dst_enc_1[1] ? _freelist_io_alloc_pregs_2_bits : 7'h0)
        | (r_uop_bypass_sel_dst_enc_1[0] ? _freelist_io_alloc_pregs_3_bits : 7'h0);	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :217:24
    end
    else if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_1_stale_pdst <= _maptable_io_map_resps_1_stale_pdst;	// rename-stage.scala:119:23, :211:24
    if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else begin	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_1_ldst <= io_dec_uops_1_ldst;	// rename-stage.scala:119:23
      r_uop_1_lrs1 <= io_dec_uops_1_lrs1;	// rename-stage.scala:119:23
      r_uop_1_lrs2 <= io_dec_uops_1_lrs2;	// rename-stage.scala:119:23
      r_uop_1_lrs3 <= io_dec_uops_1_lrs3;	// rename-stage.scala:119:23
      r_uop_1_ldst_val <= io_dec_uops_1_ldst_val;	// rename-stage.scala:119:23
      r_uop_1_dst_rtype <= io_dec_uops_1_dst_rtype;	// rename-stage.scala:119:23
      r_uop_1_lrs1_rtype <= io_dec_uops_1_lrs1_rtype;	// rename-stage.scala:119:23
      r_uop_1_lrs2_rtype <= io_dec_uops_1_lrs2_rtype;	// rename-stage.scala:119:23
      r_uop_1_frs3_en <= io_dec_uops_1_frs3_en;	// rename-stage.scala:119:23
      r_uop_2_is_br <= io_dec_uops_2_is_br;	// rename-stage.scala:119:23
      r_uop_2_is_jalr <= io_dec_uops_2_is_jalr;	// rename-stage.scala:119:23
      r_uop_2_is_sfb <= io_dec_uops_2_is_sfb;	// rename-stage.scala:119:23
      r_uop_2_br_tag <= io_dec_uops_2_br_tag;	// rename-stage.scala:119:23
    end
    if (r_uop_bypass_hits_rs1_0_2 | r_uop_bypass_hits_rs1_1_2 | r_uop_bypass_hits_rs1_2_2
        | r_uop_bypass_hits_rs1_3_2) begin	// rename-stage.scala:174:77, :184:49
      automatic logic [3:0] r_uop_bypass_sel_rs1_enc_2;	// Mux.scala:47:69
      r_uop_bypass_sel_rs1_enc_2 =
        r_uop_bypass_hits_rs1_3_2
          ? 4'h1
          : r_uop_bypass_hits_rs1_2_2
              ? 4'h2
              : r_uop_bypass_hits_rs1_1_2 ? 4'h4 : {r_uop_bypass_hits_rs1_0_2, 3'h0};	// Mux.scala:47:69, rename-stage.scala:174:77
      r_uop_2_prs1 <=
        (r_uop_bypass_sel_rs1_enc_2[3] ? _freelist_io_alloc_pregs_0_bits : 7'h0)
        | (r_uop_bypass_sel_rs1_enc_2[2] ? _freelist_io_alloc_pregs_1_bits : 7'h0)
        | (r_uop_bypass_sel_rs1_enc_2[1] ? _freelist_io_alloc_pregs_2_bits : 7'h0)
        | (r_uop_bypass_sel_rs1_enc_2[0] ? _freelist_io_alloc_pregs_3_bits : 7'h0);	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :217:24
    end
    else if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_2_prs1 <= _maptable_io_map_resps_2_prs1;	// rename-stage.scala:119:23, :211:24
    if (r_uop_bypass_hits_rs2_0_2 | r_uop_bypass_hits_rs2_1_2 | r_uop_bypass_hits_rs2_2_2
        | r_uop_bypass_hits_rs2_3_2) begin	// rename-stage.scala:175:77, :185:49
      automatic logic [3:0] r_uop_bypass_sel_rs2_enc_2;	// Mux.scala:47:69
      r_uop_bypass_sel_rs2_enc_2 =
        r_uop_bypass_hits_rs2_3_2
          ? 4'h1
          : r_uop_bypass_hits_rs2_2_2
              ? 4'h2
              : r_uop_bypass_hits_rs2_1_2 ? 4'h4 : {r_uop_bypass_hits_rs2_0_2, 3'h0};	// Mux.scala:47:69, rename-stage.scala:175:77
      r_uop_2_prs2 <=
        (r_uop_bypass_sel_rs2_enc_2[3] ? _freelist_io_alloc_pregs_0_bits : 7'h0)
        | (r_uop_bypass_sel_rs2_enc_2[2] ? _freelist_io_alloc_pregs_1_bits : 7'h0)
        | (r_uop_bypass_sel_rs2_enc_2[1] ? _freelist_io_alloc_pregs_2_bits : 7'h0)
        | (r_uop_bypass_sel_rs2_enc_2[0] ? _freelist_io_alloc_pregs_3_bits : 7'h0);	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :217:24
    end
    else if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_2_prs2 <= _maptable_io_map_resps_2_prs2;	// rename-stage.scala:119:23, :211:24
    if (r_uop_bypass_hits_rs3_0_2 | r_uop_bypass_hits_rs3_1_2 | r_uop_bypass_hits_rs3_2_2
        | r_uop_bypass_hits_rs3_3_2) begin	// rename-stage.scala:176:77, :186:49
      automatic logic [3:0] r_uop_bypass_sel_rs3_enc_2;	// Mux.scala:47:69
      r_uop_bypass_sel_rs3_enc_2 =
        r_uop_bypass_hits_rs3_3_2
          ? 4'h1
          : r_uop_bypass_hits_rs3_2_2
              ? 4'h2
              : r_uop_bypass_hits_rs3_1_2 ? 4'h4 : {r_uop_bypass_hits_rs3_0_2, 3'h0};	// Mux.scala:47:69, rename-stage.scala:176:77
      r_uop_2_prs3 <=
        (r_uop_bypass_sel_rs3_enc_2[3] ? _freelist_io_alloc_pregs_0_bits : 7'h0)
        | (r_uop_bypass_sel_rs3_enc_2[2] ? _freelist_io_alloc_pregs_1_bits : 7'h0)
        | (r_uop_bypass_sel_rs3_enc_2[1] ? _freelist_io_alloc_pregs_2_bits : 7'h0)
        | (r_uop_bypass_sel_rs3_enc_2[0] ? _freelist_io_alloc_pregs_3_bits : 7'h0);	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :217:24
    end
    else if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_2_prs3 <= _maptable_io_map_resps_2_prs3;	// rename-stage.scala:119:23, :211:24
    if (r_uop_bypass_hits_dst_0_2 | r_uop_bypass_hits_dst_1_2 | r_uop_bypass_hits_dst_2_2
        | r_uop_bypass_hits_dst_3_2) begin	// rename-stage.scala:177:77, :187:49
      automatic logic [3:0] r_uop_bypass_sel_dst_enc_2;	// Mux.scala:47:69
      r_uop_bypass_sel_dst_enc_2 =
        r_uop_bypass_hits_dst_3_2
          ? 4'h1
          : r_uop_bypass_hits_dst_2_2
              ? 4'h2
              : r_uop_bypass_hits_dst_1_2 ? 4'h4 : {r_uop_bypass_hits_dst_0_2, 3'h0};	// Mux.scala:47:69, rename-stage.scala:177:77
      r_uop_2_stale_pdst <=
        (r_uop_bypass_sel_dst_enc_2[3] ? _freelist_io_alloc_pregs_0_bits : 7'h0)
        | (r_uop_bypass_sel_dst_enc_2[2] ? _freelist_io_alloc_pregs_1_bits : 7'h0)
        | (r_uop_bypass_sel_dst_enc_2[1] ? _freelist_io_alloc_pregs_2_bits : 7'h0)
        | (r_uop_bypass_sel_dst_enc_2[0] ? _freelist_io_alloc_pregs_3_bits : 7'h0);	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :217:24
    end
    else if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_2_stale_pdst <= _maptable_io_map_resps_2_stale_pdst;	// rename-stage.scala:119:23, :211:24
    if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else begin	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_2_ldst <= io_dec_uops_2_ldst;	// rename-stage.scala:119:23
      r_uop_2_lrs1 <= io_dec_uops_2_lrs1;	// rename-stage.scala:119:23
      r_uop_2_lrs2 <= io_dec_uops_2_lrs2;	// rename-stage.scala:119:23
      r_uop_2_lrs3 <= io_dec_uops_2_lrs3;	// rename-stage.scala:119:23
      r_uop_2_ldst_val <= io_dec_uops_2_ldst_val;	// rename-stage.scala:119:23
      r_uop_2_dst_rtype <= io_dec_uops_2_dst_rtype;	// rename-stage.scala:119:23
      r_uop_2_lrs1_rtype <= io_dec_uops_2_lrs1_rtype;	// rename-stage.scala:119:23
      r_uop_2_lrs2_rtype <= io_dec_uops_2_lrs2_rtype;	// rename-stage.scala:119:23
      r_uop_2_frs3_en <= io_dec_uops_2_frs3_en;	// rename-stage.scala:119:23
      r_uop_3_is_br <= io_dec_uops_3_is_br;	// rename-stage.scala:119:23
      r_uop_3_is_jalr <= io_dec_uops_3_is_jalr;	// rename-stage.scala:119:23
      r_uop_3_is_sfb <= io_dec_uops_3_is_sfb;	// rename-stage.scala:119:23
      r_uop_3_br_tag <= io_dec_uops_3_br_tag;	// rename-stage.scala:119:23
    end
    if (r_uop_bypass_hits_rs1_0_3 | r_uop_bypass_hits_rs1_1_3 | r_uop_bypass_hits_rs1_2_3
        | r_uop_bypass_hits_rs1_3_3) begin	// rename-stage.scala:174:77, :184:49
      automatic logic [3:0] r_uop_bypass_sel_rs1_enc_3;	// Mux.scala:47:69
      r_uop_bypass_sel_rs1_enc_3 =
        r_uop_bypass_hits_rs1_3_3
          ? 4'h1
          : r_uop_bypass_hits_rs1_2_3
              ? 4'h2
              : r_uop_bypass_hits_rs1_1_3 ? 4'h4 : {r_uop_bypass_hits_rs1_0_3, 3'h0};	// Mux.scala:47:69, rename-stage.scala:174:77
      r_uop_3_prs1 <=
        (r_uop_bypass_sel_rs1_enc_3[3] ? _freelist_io_alloc_pregs_0_bits : 7'h0)
        | (r_uop_bypass_sel_rs1_enc_3[2] ? _freelist_io_alloc_pregs_1_bits : 7'h0)
        | (r_uop_bypass_sel_rs1_enc_3[1] ? _freelist_io_alloc_pregs_2_bits : 7'h0)
        | (r_uop_bypass_sel_rs1_enc_3[0] ? _freelist_io_alloc_pregs_3_bits : 7'h0);	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :217:24
    end
    else if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_3_prs1 <= _maptable_io_map_resps_3_prs1;	// rename-stage.scala:119:23, :211:24
    if (r_uop_bypass_hits_rs2_0_3 | r_uop_bypass_hits_rs2_1_3 | r_uop_bypass_hits_rs2_2_3
        | r_uop_bypass_hits_rs2_3_3) begin	// rename-stage.scala:175:77, :185:49
      automatic logic [3:0] r_uop_bypass_sel_rs2_enc_3;	// Mux.scala:47:69
      r_uop_bypass_sel_rs2_enc_3 =
        r_uop_bypass_hits_rs2_3_3
          ? 4'h1
          : r_uop_bypass_hits_rs2_2_3
              ? 4'h2
              : r_uop_bypass_hits_rs2_1_3 ? 4'h4 : {r_uop_bypass_hits_rs2_0_3, 3'h0};	// Mux.scala:47:69, rename-stage.scala:175:77
      r_uop_3_prs2 <=
        (r_uop_bypass_sel_rs2_enc_3[3] ? _freelist_io_alloc_pregs_0_bits : 7'h0)
        | (r_uop_bypass_sel_rs2_enc_3[2] ? _freelist_io_alloc_pregs_1_bits : 7'h0)
        | (r_uop_bypass_sel_rs2_enc_3[1] ? _freelist_io_alloc_pregs_2_bits : 7'h0)
        | (r_uop_bypass_sel_rs2_enc_3[0] ? _freelist_io_alloc_pregs_3_bits : 7'h0);	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :217:24
    end
    else if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_3_prs2 <= _maptable_io_map_resps_3_prs2;	// rename-stage.scala:119:23, :211:24
    if (r_uop_bypass_hits_rs3_0_3 | r_uop_bypass_hits_rs3_1_3 | r_uop_bypass_hits_rs3_2_3
        | r_uop_bypass_hits_rs3_3_3) begin	// rename-stage.scala:176:77, :186:49
      automatic logic [3:0] r_uop_bypass_sel_rs3_enc_3;	// Mux.scala:47:69
      r_uop_bypass_sel_rs3_enc_3 =
        r_uop_bypass_hits_rs3_3_3
          ? 4'h1
          : r_uop_bypass_hits_rs3_2_3
              ? 4'h2
              : r_uop_bypass_hits_rs3_1_3 ? 4'h4 : {r_uop_bypass_hits_rs3_0_3, 3'h0};	// Mux.scala:47:69, rename-stage.scala:176:77
      r_uop_3_prs3 <=
        (r_uop_bypass_sel_rs3_enc_3[3] ? _freelist_io_alloc_pregs_0_bits : 7'h0)
        | (r_uop_bypass_sel_rs3_enc_3[2] ? _freelist_io_alloc_pregs_1_bits : 7'h0)
        | (r_uop_bypass_sel_rs3_enc_3[1] ? _freelist_io_alloc_pregs_2_bits : 7'h0)
        | (r_uop_bypass_sel_rs3_enc_3[0] ? _freelist_io_alloc_pregs_3_bits : 7'h0);	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :217:24
    end
    else if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_3_prs3 <= _maptable_io_map_resps_3_prs3;	// rename-stage.scala:119:23, :211:24
    if (r_uop_bypass_hits_dst_0_3 | r_uop_bypass_hits_dst_1_3 | r_uop_bypass_hits_dst_2_3
        | r_uop_bypass_hits_dst_3_3) begin	// rename-stage.scala:177:77, :187:49
      automatic logic [3:0] r_uop_bypass_sel_dst_enc_3;	// Mux.scala:47:69
      r_uop_bypass_sel_dst_enc_3 =
        r_uop_bypass_hits_dst_3_3
          ? 4'h1
          : r_uop_bypass_hits_dst_2_3
              ? 4'h2
              : r_uop_bypass_hits_dst_1_3 ? 4'h4 : {r_uop_bypass_hits_dst_0_3, 3'h0};	// Mux.scala:47:69, rename-stage.scala:177:77
      r_uop_3_stale_pdst <=
        (r_uop_bypass_sel_dst_enc_3[3] ? _freelist_io_alloc_pregs_0_bits : 7'h0)
        | (r_uop_bypass_sel_dst_enc_3[2] ? _freelist_io_alloc_pregs_1_bits : 7'h0)
        | (r_uop_bypass_sel_dst_enc_3[1] ? _freelist_io_alloc_pregs_2_bits : 7'h0)
        | (r_uop_bypass_sel_dst_enc_3[0] ? _freelist_io_alloc_pregs_3_bits : 7'h0);	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :217:24
    end
    else if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_3_stale_pdst <= _maptable_io_map_resps_3_stale_pdst;	// rename-stage.scala:119:23, :211:24
    if (_GEN) begin	// rename-stage.scala:122:14, :124:20, :126:30
    end
    else begin	// rename-stage.scala:122:14, :124:20, :126:30
      r_uop_3_ldst <= io_dec_uops_3_ldst;	// rename-stage.scala:119:23
      r_uop_3_lrs1 <= io_dec_uops_3_lrs1;	// rename-stage.scala:119:23
      r_uop_3_lrs2 <= io_dec_uops_3_lrs2;	// rename-stage.scala:119:23
      r_uop_3_lrs3 <= io_dec_uops_3_lrs3;	// rename-stage.scala:119:23
      r_uop_3_ldst_val <= io_dec_uops_3_ldst_val;	// rename-stage.scala:119:23
      r_uop_3_dst_rtype <= io_dec_uops_3_dst_rtype;	// rename-stage.scala:119:23
      r_uop_3_lrs1_rtype <= io_dec_uops_3_lrs1_rtype;	// rename-stage.scala:119:23
      r_uop_3_lrs2_rtype <= io_dec_uops_3_lrs2_rtype;	// rename-stage.scala:119:23
      r_uop_3_frs3_en <= io_dec_uops_3_frs3_en;	// rename-stage.scala:119:23
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:51];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [5:0] i = 6'h0; i < 6'h34; i += 6'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        r_uop_is_br = _RANDOM[6'h4][25];	// rename-stage.scala:119:23
        r_uop_is_jalr = _RANDOM[6'h4][26];	// rename-stage.scala:119:23
        r_uop_is_sfb = _RANDOM[6'h4][28];	// rename-stage.scala:119:23
        r_uop_br_tag = _RANDOM[6'h5][21:17];	// rename-stage.scala:119:23
        r_uop_prs1 = {_RANDOM[6'h7][31:30], _RANDOM[6'h8][4:0]};	// rename-stage.scala:119:23
        r_uop_prs2 = _RANDOM[6'h8][11:5];	// rename-stage.scala:119:23
        r_uop_prs3 = _RANDOM[6'h8][18:12];	// rename-stage.scala:119:23
        r_uop_stale_pdst = {_RANDOM[6'h8][31:29], _RANDOM[6'h9][3:0]};	// rename-stage.scala:119:23
        r_uop_ldst = _RANDOM[6'hB][28:23];	// rename-stage.scala:119:23
        r_uop_lrs1 = {_RANDOM[6'hB][31:29], _RANDOM[6'hC][2:0]};	// rename-stage.scala:119:23
        r_uop_lrs2 = _RANDOM[6'hC][8:3];	// rename-stage.scala:119:23
        r_uop_lrs3 = _RANDOM[6'hC][14:9];	// rename-stage.scala:119:23
        r_uop_ldst_val = _RANDOM[6'hC][15];	// rename-stage.scala:119:23
        r_uop_dst_rtype = _RANDOM[6'hC][17:16];	// rename-stage.scala:119:23
        r_uop_lrs1_rtype = _RANDOM[6'hC][19:18];	// rename-stage.scala:119:23
        r_uop_lrs2_rtype = _RANDOM[6'hC][21:20];	// rename-stage.scala:119:23
        r_uop_frs3_en = _RANDOM[6'hC][22];	// rename-stage.scala:119:23
        r_uop_1_is_br = _RANDOM[6'h11][27];	// rename-stage.scala:119:23
        r_uop_1_is_jalr = _RANDOM[6'h11][28];	// rename-stage.scala:119:23
        r_uop_1_is_sfb = _RANDOM[6'h11][30];	// rename-stage.scala:119:23
        r_uop_1_br_tag = _RANDOM[6'h12][23:19];	// rename-stage.scala:119:23
        r_uop_1_prs1 = _RANDOM[6'h15][6:0];	// rename-stage.scala:119:23
        r_uop_1_prs2 = _RANDOM[6'h15][13:7];	// rename-stage.scala:119:23
        r_uop_1_prs3 = _RANDOM[6'h15][20:14];	// rename-stage.scala:119:23
        r_uop_1_stale_pdst = {_RANDOM[6'h15][31], _RANDOM[6'h16][5:0]};	// rename-stage.scala:119:23
        r_uop_1_ldst = _RANDOM[6'h18][30:25];	// rename-stage.scala:119:23
        r_uop_1_lrs1 = {_RANDOM[6'h18][31], _RANDOM[6'h19][4:0]};	// rename-stage.scala:119:23
        r_uop_1_lrs2 = _RANDOM[6'h19][10:5];	// rename-stage.scala:119:23
        r_uop_1_lrs3 = _RANDOM[6'h19][16:11];	// rename-stage.scala:119:23
        r_uop_1_ldst_val = _RANDOM[6'h19][17];	// rename-stage.scala:119:23
        r_uop_1_dst_rtype = _RANDOM[6'h19][19:18];	// rename-stage.scala:119:23
        r_uop_1_lrs1_rtype = _RANDOM[6'h19][21:20];	// rename-stage.scala:119:23
        r_uop_1_lrs2_rtype = _RANDOM[6'h19][23:22];	// rename-stage.scala:119:23
        r_uop_1_frs3_en = _RANDOM[6'h19][24];	// rename-stage.scala:119:23
        r_uop_2_is_br = _RANDOM[6'h1E][29];	// rename-stage.scala:119:23
        r_uop_2_is_jalr = _RANDOM[6'h1E][30];	// rename-stage.scala:119:23
        r_uop_2_is_sfb = _RANDOM[6'h1F][0];	// rename-stage.scala:119:23
        r_uop_2_br_tag = _RANDOM[6'h1F][25:21];	// rename-stage.scala:119:23
        r_uop_2_prs1 = _RANDOM[6'h22][8:2];	// rename-stage.scala:119:23
        r_uop_2_prs2 = _RANDOM[6'h22][15:9];	// rename-stage.scala:119:23
        r_uop_2_prs3 = _RANDOM[6'h22][22:16];	// rename-stage.scala:119:23
        r_uop_2_stale_pdst = _RANDOM[6'h23][7:1];	// rename-stage.scala:119:23
        r_uop_2_ldst = {_RANDOM[6'h25][31:27], _RANDOM[6'h26][0]};	// rename-stage.scala:119:23
        r_uop_2_lrs1 = _RANDOM[6'h26][6:1];	// rename-stage.scala:119:23
        r_uop_2_lrs2 = _RANDOM[6'h26][12:7];	// rename-stage.scala:119:23
        r_uop_2_lrs3 = _RANDOM[6'h26][18:13];	// rename-stage.scala:119:23
        r_uop_2_ldst_val = _RANDOM[6'h26][19];	// rename-stage.scala:119:23
        r_uop_2_dst_rtype = _RANDOM[6'h26][21:20];	// rename-stage.scala:119:23
        r_uop_2_lrs1_rtype = _RANDOM[6'h26][23:22];	// rename-stage.scala:119:23
        r_uop_2_lrs2_rtype = _RANDOM[6'h26][25:24];	// rename-stage.scala:119:23
        r_uop_2_frs3_en = _RANDOM[6'h26][26];	// rename-stage.scala:119:23
        r_uop_3_is_br = _RANDOM[6'h2B][31];	// rename-stage.scala:119:23
        r_uop_3_is_jalr = _RANDOM[6'h2C][0];	// rename-stage.scala:119:23
        r_uop_3_is_sfb = _RANDOM[6'h2C][2];	// rename-stage.scala:119:23
        r_uop_3_br_tag = _RANDOM[6'h2C][27:23];	// rename-stage.scala:119:23
        r_uop_3_prs1 = _RANDOM[6'h2F][10:4];	// rename-stage.scala:119:23
        r_uop_3_prs2 = _RANDOM[6'h2F][17:11];	// rename-stage.scala:119:23
        r_uop_3_prs3 = _RANDOM[6'h2F][24:18];	// rename-stage.scala:119:23
        r_uop_3_stale_pdst = _RANDOM[6'h30][9:3];	// rename-stage.scala:119:23
        r_uop_3_ldst = {_RANDOM[6'h32][31:29], _RANDOM[6'h33][2:0]};	// rename-stage.scala:119:23
        r_uop_3_lrs1 = _RANDOM[6'h33][8:3];	// rename-stage.scala:119:23
        r_uop_3_lrs2 = _RANDOM[6'h33][14:9];	// rename-stage.scala:119:23
        r_uop_3_lrs3 = _RANDOM[6'h33][20:15];	// rename-stage.scala:119:23
        r_uop_3_ldst_val = _RANDOM[6'h33][21];	// rename-stage.scala:119:23
        r_uop_3_dst_rtype = _RANDOM[6'h33][23:22];	// rename-stage.scala:119:23
        r_uop_3_lrs1_rtype = _RANDOM[6'h33][25:24];	// rename-stage.scala:119:23
        r_uop_3_lrs2_rtype = _RANDOM[6'h33][27:26];	// rename-stage.scala:119:23
        r_uop_3_frs3_en = _RANDOM[6'h33][28];	// rename-stage.scala:119:23
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  RenameMapTable_1 maptable (	// rename-stage.scala:211:24
    .clock                     (clock),
    .reset                     (reset),
    .io_map_reqs_0_lrs1        (io_dec_uops_0_lrs1),
    .io_map_reqs_0_lrs2        (io_dec_uops_0_lrs2),
    .io_map_reqs_0_lrs3        (io_dec_uops_0_lrs3),
    .io_map_reqs_0_ldst        (io_dec_uops_0_ldst),
    .io_map_reqs_1_lrs1        (io_dec_uops_1_lrs1),
    .io_map_reqs_1_lrs2        (io_dec_uops_1_lrs2),
    .io_map_reqs_1_lrs3        (io_dec_uops_1_lrs3),
    .io_map_reqs_1_ldst        (io_dec_uops_1_ldst),
    .io_map_reqs_2_lrs1        (io_dec_uops_2_lrs1),
    .io_map_reqs_2_lrs2        (io_dec_uops_2_lrs2),
    .io_map_reqs_2_lrs3        (io_dec_uops_2_lrs3),
    .io_map_reqs_2_ldst        (io_dec_uops_2_ldst),
    .io_map_reqs_3_lrs1        (io_dec_uops_3_lrs1),
    .io_map_reqs_3_lrs2        (io_dec_uops_3_lrs2),
    .io_map_reqs_3_lrs3        (io_dec_uops_3_lrs3),
    .io_map_reqs_3_ldst        (io_dec_uops_3_ldst),
    .io_remap_reqs_0_ldst      (io_rollback ? io_com_uops_3_ldst : r_uop_ldst),	// rename-stage.scala:119:23, :259:30
    .io_remap_reqs_0_pdst
      (io_rollback ? io_com_uops_3_stale_pdst : _freelist_io_alloc_pregs_0_bits),	// rename-stage.scala:217:24, :260:30
    .io_remap_reqs_0_valid     (ren2_alloc_reqs_0 | rbk_valids_3),	// rename-stage.scala:237:88, :241:92, :263:38
    .io_remap_reqs_1_ldst      (io_rollback ? io_com_uops_2_ldst : r_uop_1_ldst),	// rename-stage.scala:119:23, :259:30
    .io_remap_reqs_1_pdst
      (io_rollback ? io_com_uops_2_stale_pdst : _freelist_io_alloc_pregs_1_bits),	// rename-stage.scala:217:24, :260:30
    .io_remap_reqs_1_valid     (ren2_alloc_reqs_1 | rbk_valids_2),	// rename-stage.scala:237:88, :241:92, :263:38
    .io_remap_reqs_2_ldst      (io_rollback ? io_com_uops_1_ldst : r_uop_2_ldst),	// rename-stage.scala:119:23, :259:30
    .io_remap_reqs_2_pdst
      (io_rollback ? io_com_uops_1_stale_pdst : _freelist_io_alloc_pregs_2_bits),	// rename-stage.scala:217:24, :260:30
    .io_remap_reqs_2_valid     (ren2_alloc_reqs_2 | rbk_valids_1),	// rename-stage.scala:237:88, :241:92, :263:38
    .io_remap_reqs_3_ldst      (io_rollback ? io_com_uops_0_ldst : r_uop_3_ldst),	// rename-stage.scala:119:23, :259:30
    .io_remap_reqs_3_pdst
      (io_rollback ? io_com_uops_0_stale_pdst : _freelist_io_alloc_pregs_3_bits),	// rename-stage.scala:217:24, :260:30
    .io_remap_reqs_3_valid     (ren2_alloc_reqs_3 | rbk_valids_0),	// rename-stage.scala:237:88, :241:92, :263:38
    .io_ren_br_tags_0_valid    (ren2_br_tags_0_valid),	// rename-stage.scala:238:43
    .io_ren_br_tags_0_bits     (r_uop_br_tag),	// rename-stage.scala:119:23
    .io_ren_br_tags_1_valid    (ren2_br_tags_1_valid),	// rename-stage.scala:238:43
    .io_ren_br_tags_1_bits     (r_uop_1_br_tag),	// rename-stage.scala:119:23
    .io_ren_br_tags_2_valid    (ren2_br_tags_2_valid),	// rename-stage.scala:238:43
    .io_ren_br_tags_2_bits     (r_uop_2_br_tag),	// rename-stage.scala:119:23
    .io_ren_br_tags_3_valid    (ren2_br_tags_3_valid),	// rename-stage.scala:238:43
    .io_ren_br_tags_3_bits     (r_uop_3_br_tag),	// rename-stage.scala:119:23
    .io_brupdate_b2_uop_br_tag (io_brupdate_b2_uop_br_tag),
    .io_brupdate_b2_mispredict (io_brupdate_b2_mispredict),
    .io_rollback               (io_rollback),
    .io_map_resps_0_prs1       (_maptable_io_map_resps_0_prs1),
    .io_map_resps_0_prs2       (_maptable_io_map_resps_0_prs2),
    .io_map_resps_0_prs3       (_maptable_io_map_resps_0_prs3),
    .io_map_resps_0_stale_pdst (_maptable_io_map_resps_0_stale_pdst),
    .io_map_resps_1_prs1       (_maptable_io_map_resps_1_prs1),
    .io_map_resps_1_prs2       (_maptable_io_map_resps_1_prs2),
    .io_map_resps_1_prs3       (_maptable_io_map_resps_1_prs3),
    .io_map_resps_1_stale_pdst (_maptable_io_map_resps_1_stale_pdst),
    .io_map_resps_2_prs1       (_maptable_io_map_resps_2_prs1),
    .io_map_resps_2_prs2       (_maptable_io_map_resps_2_prs2),
    .io_map_resps_2_prs3       (_maptable_io_map_resps_2_prs3),
    .io_map_resps_2_stale_pdst (_maptable_io_map_resps_2_stale_pdst),
    .io_map_resps_3_prs1       (_maptable_io_map_resps_3_prs1),
    .io_map_resps_3_prs2       (_maptable_io_map_resps_3_prs2),
    .io_map_resps_3_prs3       (_maptable_io_map_resps_3_prs3),
    .io_map_resps_3_stale_pdst (_maptable_io_map_resps_3_stale_pdst)
  );
  RenameFreeList_1 freelist (	// rename-stage.scala:217:24
    .clock                     (clock),
    .reset                     (reset),
    .io_reqs_0                 (ren2_alloc_reqs_0),	// rename-stage.scala:237:88
    .io_reqs_1                 (ren2_alloc_reqs_1),	// rename-stage.scala:237:88
    .io_reqs_2                 (ren2_alloc_reqs_2),	// rename-stage.scala:237:88
    .io_reqs_3                 (ren2_alloc_reqs_3),	// rename-stage.scala:237:88
    .io_dealloc_pregs_0_valid
      (io_com_uops_0_ldst_val & _rbk_valids_0_T & io_com_valids_0 | rbk_valids_0),	// rename-stage.scala:240:{82,92}, :241:92, :290:37
    .io_dealloc_pregs_0_bits
      (io_rollback ? io_com_uops_0_pdst : io_com_uops_0_stale_pdst),	// rename-stage.scala:292:33
    .io_dealloc_pregs_1_valid
      (io_com_uops_1_ldst_val & _rbk_valids_1_T & io_com_valids_1 | rbk_valids_1),	// rename-stage.scala:240:{82,92}, :241:92, :290:37
    .io_dealloc_pregs_1_bits
      (io_rollback ? io_com_uops_1_pdst : io_com_uops_1_stale_pdst),	// rename-stage.scala:292:33
    .io_dealloc_pregs_2_valid
      (io_com_uops_2_ldst_val & _rbk_valids_2_T & io_com_valids_2 | rbk_valids_2),	// rename-stage.scala:240:{82,92}, :241:92, :290:37
    .io_dealloc_pregs_2_bits
      (io_rollback ? io_com_uops_2_pdst : io_com_uops_2_stale_pdst),	// rename-stage.scala:292:33
    .io_dealloc_pregs_3_valid
      (io_com_uops_3_ldst_val & _rbk_valids_3_T & io_com_valids_3 | rbk_valids_3),	// rename-stage.scala:240:{82,92}, :241:92, :290:37
    .io_dealloc_pregs_3_bits
      (io_rollback ? io_com_uops_3_pdst : io_com_uops_3_stale_pdst),	// rename-stage.scala:292:33
    .io_ren_br_tags_0_valid    (ren2_br_tags_0_valid),	// rename-stage.scala:238:43
    .io_ren_br_tags_0_bits     (r_uop_br_tag),	// rename-stage.scala:119:23
    .io_ren_br_tags_1_valid    (ren2_br_tags_1_valid),	// rename-stage.scala:238:43
    .io_ren_br_tags_1_bits     (r_uop_1_br_tag),	// rename-stage.scala:119:23
    .io_ren_br_tags_2_valid    (ren2_br_tags_2_valid),	// rename-stage.scala:238:43
    .io_ren_br_tags_2_bits     (r_uop_2_br_tag),	// rename-stage.scala:119:23
    .io_ren_br_tags_3_valid    (ren2_br_tags_3_valid),	// rename-stage.scala:238:43
    .io_ren_br_tags_3_bits     (r_uop_3_br_tag),	// rename-stage.scala:119:23
    .io_brupdate_b2_uop_br_tag (io_brupdate_b2_uop_br_tag),
    .io_brupdate_b2_mispredict (io_brupdate_b2_mispredict),
    .io_debug_pipeline_empty   (io_debug_rob_empty),
    .io_alloc_pregs_0_valid    (_freelist_io_alloc_pregs_0_valid),
    .io_alloc_pregs_0_bits     (_freelist_io_alloc_pregs_0_bits),
    .io_alloc_pregs_1_valid    (_freelist_io_alloc_pregs_1_valid),
    .io_alloc_pregs_1_bits     (_freelist_io_alloc_pregs_1_bits),
    .io_alloc_pregs_2_valid    (_freelist_io_alloc_pregs_2_valid),
    .io_alloc_pregs_2_bits     (_freelist_io_alloc_pregs_2_bits),
    .io_alloc_pregs_3_valid    (_freelist_io_alloc_pregs_3_valid),
    .io_alloc_pregs_3_bits     (_freelist_io_alloc_pregs_3_bits)
  );
  RenameBusyTable_1 busytable (	// rename-stage.scala:221:25
    .clock                     (clock),
    .reset                     (reset),
    .io_ren_uops_0_pdst        (_freelist_io_alloc_pregs_0_bits),	// rename-stage.scala:217:24
    .io_ren_uops_0_prs1        (r_uop_prs1),	// rename-stage.scala:119:23
    .io_ren_uops_0_prs2        (r_uop_prs2),	// rename-stage.scala:119:23
    .io_ren_uops_0_prs3        (r_uop_prs3),	// rename-stage.scala:119:23
    .io_ren_uops_1_pdst        (_freelist_io_alloc_pregs_1_bits),	// rename-stage.scala:217:24
    .io_ren_uops_1_prs1        (r_uop_1_prs1),	// rename-stage.scala:119:23
    .io_ren_uops_1_prs2        (r_uop_1_prs2),	// rename-stage.scala:119:23
    .io_ren_uops_1_prs3        (r_uop_1_prs3),	// rename-stage.scala:119:23
    .io_ren_uops_2_pdst        (_freelist_io_alloc_pregs_2_bits),	// rename-stage.scala:217:24
    .io_ren_uops_2_prs1        (r_uop_2_prs1),	// rename-stage.scala:119:23
    .io_ren_uops_2_prs2        (r_uop_2_prs2),	// rename-stage.scala:119:23
    .io_ren_uops_2_prs3        (r_uop_2_prs3),	// rename-stage.scala:119:23
    .io_ren_uops_3_pdst        (_freelist_io_alloc_pregs_3_bits),	// rename-stage.scala:217:24
    .io_ren_uops_3_prs1        (r_uop_3_prs1),	// rename-stage.scala:119:23
    .io_ren_uops_3_prs2        (r_uop_3_prs2),	// rename-stage.scala:119:23
    .io_ren_uops_3_prs3        (r_uop_3_prs3),	// rename-stage.scala:119:23
    .io_rebusy_reqs_0          (ren2_alloc_reqs_0),	// rename-stage.scala:237:88
    .io_rebusy_reqs_1          (ren2_alloc_reqs_1),	// rename-stage.scala:237:88
    .io_rebusy_reqs_2          (ren2_alloc_reqs_2),	// rename-stage.scala:237:88
    .io_rebusy_reqs_3          (ren2_alloc_reqs_3),	// rename-stage.scala:237:88
    .io_wb_pdsts_0             (io_wakeups_0_bits_uop_pdst),
    .io_wb_pdsts_1             (io_wakeups_1_bits_uop_pdst),
    .io_wb_pdsts_2             (io_wakeups_2_bits_uop_pdst),
    .io_wb_pdsts_3             (io_wakeups_3_bits_uop_pdst),
    .io_wb_valids_0            (io_wakeups_0_valid),
    .io_wb_valids_1            (io_wakeups_1_valid),
    .io_wb_valids_2            (io_wakeups_2_valid),
    .io_wb_valids_3            (io_wakeups_3_valid),
    .io_busy_resps_0_prs1_busy (_busytable_io_busy_resps_0_prs1_busy),
    .io_busy_resps_0_prs2_busy (_busytable_io_busy_resps_0_prs2_busy),
    .io_busy_resps_0_prs3_busy (_busytable_io_busy_resps_0_prs3_busy),
    .io_busy_resps_1_prs1_busy (_busytable_io_busy_resps_1_prs1_busy),
    .io_busy_resps_1_prs2_busy (_busytable_io_busy_resps_1_prs2_busy),
    .io_busy_resps_1_prs3_busy (_busytable_io_busy_resps_1_prs3_busy),
    .io_busy_resps_2_prs1_busy (_busytable_io_busy_resps_2_prs1_busy),
    .io_busy_resps_2_prs2_busy (_busytable_io_busy_resps_2_prs2_busy),
    .io_busy_resps_2_prs3_busy (_busytable_io_busy_resps_2_prs3_busy),
    .io_busy_resps_3_prs1_busy (_busytable_io_busy_resps_3_prs1_busy),
    .io_busy_resps_3_prs2_busy (_busytable_io_busy_resps_3_prs2_busy),
    .io_busy_resps_3_prs3_busy (_busytable_io_busy_resps_3_prs3_busy)
  );
  assign io_ren_stalls_0 = _io_ren_stalls_0_T & ~_freelist_io_alloc_pregs_0_valid;	// rename-stage.scala:217:24, :237:78, :336:{60,63}
  assign io_ren_stalls_1 = _io_ren_stalls_1_T & ~_freelist_io_alloc_pregs_1_valid;	// rename-stage.scala:217:24, :237:78, :336:{60,63}
  assign io_ren_stalls_2 = _io_ren_stalls_2_T & ~_freelist_io_alloc_pregs_2_valid;	// rename-stage.scala:217:24, :237:78, :336:{60,63}
  assign io_ren_stalls_3 = _io_ren_stalls_3_T & ~_freelist_io_alloc_pregs_3_valid;	// rename-stage.scala:217:24, :237:78, :336:{60,63}
  assign io_ren2_uops_0_pdst = _freelist_io_alloc_pregs_0_bits;	// rename-stage.scala:217:24
  assign io_ren2_uops_0_prs1 = r_uop_prs1;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_prs2 = r_uop_prs2;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_prs3 = r_uop_prs3;	// rename-stage.scala:119:23
  assign io_ren2_uops_0_prs1_busy =
    r_uop_lrs1_rtype == 2'h1 & _busytable_io_busy_resps_0_prs1_busy;	// rename-stage.scala:119:23, :221:25, :237:78, :320:{37,47}
  assign io_ren2_uops_0_prs2_busy =
    r_uop_lrs2_rtype == 2'h1 & _busytable_io_busy_resps_0_prs2_busy;	// rename-stage.scala:119:23, :221:25, :237:78, :321:{37,47}
  assign io_ren2_uops_0_prs3_busy = r_uop_frs3_en & _busytable_io_busy_resps_0_prs3_busy;	// rename-stage.scala:119:23, :221:25, :322:34
  assign io_ren2_uops_0_stale_pdst = r_uop_stale_pdst;	// rename-stage.scala:119:23
  assign io_ren2_uops_1_pdst = _freelist_io_alloc_pregs_1_bits;	// rename-stage.scala:217:24
  assign io_ren2_uops_1_prs1 =
    bypassed_uop_bypass_sel_rs1_0 ? _freelist_io_alloc_pregs_0_bits : r_uop_1_prs1;	// rename-stage.scala:119:23, :172:18, :174:77, :191:{26,52}, :217:24
  assign io_ren2_uops_1_prs2 =
    bypassed_uop_bypass_sel_rs2_0 ? _freelist_io_alloc_pregs_0_bits : r_uop_1_prs2;	// rename-stage.scala:119:23, :172:18, :175:77, :192:{26,52}, :217:24
  assign io_ren2_uops_1_prs3 =
    bypassed_uop_bypass_sel_rs3_0 ? _freelist_io_alloc_pregs_0_bits : r_uop_1_prs3;	// rename-stage.scala:119:23, :172:18, :176:77, :193:{26,52}, :217:24
  assign io_ren2_uops_1_prs1_busy =
    r_uop_1_lrs1_rtype == 2'h1 & _busytable_io_busy_resps_1_prs1_busy
    | bypassed_uop_bypass_sel_rs1_0;	// rename-stage.scala:119:23, :174:77, :196:45, :221:25, :237:78, :320:{37,47}
  assign io_ren2_uops_1_prs2_busy =
    r_uop_1_lrs2_rtype == 2'h1 & _busytable_io_busy_resps_1_prs2_busy
    | bypassed_uop_bypass_sel_rs2_0;	// rename-stage.scala:119:23, :175:77, :197:45, :221:25, :237:78, :321:{37,47}
  assign io_ren2_uops_1_prs3_busy =
    r_uop_1_frs3_en & _busytable_io_busy_resps_1_prs3_busy
    | bypassed_uop_bypass_sel_rs3_0;	// rename-stage.scala:119:23, :176:77, :198:45, :221:25, :322:34
  assign io_ren2_uops_1_stale_pdst =
    ren2_alloc_reqs_0 & r_uop_ldst == r_uop_1_ldst
      ? _freelist_io_alloc_pregs_0_bits
      : r_uop_1_stale_pdst;	// rename-stage.scala:119:23, :172:18, :177:{77,87}, :194:{26,52}, :217:24, :237:88
  assign io_ren2_uops_2_pdst = _freelist_io_alloc_pregs_2_bits;	// rename-stage.scala:217:24
  assign io_ren2_uops_2_prs1 =
    bypassed_uop_do_bypass_rs1
      ? (bypassed_uop_bypass_sel_rs1_enc_1[1] ? _freelist_io_alloc_pregs_0_bits : 7'h0)
        | (bypassed_uop_bypass_sel_rs1_enc_1[0] ? _freelist_io_alloc_pregs_1_bits : 7'h0)
      : r_uop_2_prs1;	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :172:18, :184:49, :191:{26,52}, :217:24
  assign io_ren2_uops_2_prs2 =
    bypassed_uop_do_bypass_rs2
      ? (bypassed_uop_bypass_sel_rs2_enc_1[1] ? _freelist_io_alloc_pregs_0_bits : 7'h0)
        | (bypassed_uop_bypass_sel_rs2_enc_1[0] ? _freelist_io_alloc_pregs_1_bits : 7'h0)
      : r_uop_2_prs2;	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :172:18, :185:49, :192:{26,52}, :217:24
  assign io_ren2_uops_2_prs3 =
    bypassed_uop_do_bypass_rs3
      ? (bypassed_uop_bypass_sel_rs3_enc_1[1] ? _freelist_io_alloc_pregs_0_bits : 7'h0)
        | (bypassed_uop_bypass_sel_rs3_enc_1[0] ? _freelist_io_alloc_pregs_1_bits : 7'h0)
      : r_uop_2_prs3;	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :172:18, :186:49, :193:{26,52}, :217:24
  assign io_ren2_uops_2_prs1_busy =
    r_uop_2_lrs1_rtype == 2'h1 & _busytable_io_busy_resps_2_prs1_busy
    | bypassed_uop_do_bypass_rs1;	// rename-stage.scala:119:23, :184:49, :196:45, :221:25, :237:78, :320:{37,47}
  assign io_ren2_uops_2_prs2_busy =
    r_uop_2_lrs2_rtype == 2'h1 & _busytable_io_busy_resps_2_prs2_busy
    | bypassed_uop_do_bypass_rs2;	// rename-stage.scala:119:23, :185:49, :197:45, :221:25, :237:78, :321:{37,47}
  assign io_ren2_uops_2_prs3_busy =
    r_uop_2_frs3_en & _busytable_io_busy_resps_2_prs3_busy | bypassed_uop_do_bypass_rs3;	// rename-stage.scala:119:23, :186:49, :198:45, :221:25, :322:34
  assign io_ren2_uops_2_stale_pdst =
    bypassed_uop_bypass_hits_dst_0_1 | bypassed_uop_bypass_hits_dst_1
      ? (bypassed_uop_bypass_sel_dst_enc_1[1] ? _freelist_io_alloc_pregs_0_bits : 7'h0)
        | (bypassed_uop_bypass_sel_dst_enc_1[0] ? _freelist_io_alloc_pregs_1_bits : 7'h0)
      : r_uop_2_stale_pdst;	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :172:18, :177:77, :187:49, :194:{26,52}, :217:24
  assign io_ren2_uops_3_pdst = _freelist_io_alloc_pregs_3_bits;	// rename-stage.scala:217:24
  assign io_ren2_uops_3_prs1 =
    bypassed_uop_do_bypass_rs1_1
      ? (bypassed_uop_bypass_sel_rs1_enc_2[2] ? _freelist_io_alloc_pregs_0_bits : 7'h0)
        | (bypassed_uop_bypass_sel_rs1_enc_2[1] ? _freelist_io_alloc_pregs_1_bits : 7'h0)
        | (bypassed_uop_bypass_sel_rs1_enc_2[0] ? _freelist_io_alloc_pregs_2_bits : 7'h0)
      : r_uop_3_prs1;	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :172:18, :184:49, :191:{26,52}, :217:24
  assign io_ren2_uops_3_prs2 =
    bypassed_uop_do_bypass_rs2_1
      ? (bypassed_uop_bypass_sel_rs2_enc_2[2] ? _freelist_io_alloc_pregs_0_bits : 7'h0)
        | (bypassed_uop_bypass_sel_rs2_enc_2[1] ? _freelist_io_alloc_pregs_1_bits : 7'h0)
        | (bypassed_uop_bypass_sel_rs2_enc_2[0] ? _freelist_io_alloc_pregs_2_bits : 7'h0)
      : r_uop_3_prs2;	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :172:18, :185:49, :192:{26,52}, :217:24
  assign io_ren2_uops_3_prs3 =
    bypassed_uop_do_bypass_rs3_1
      ? (bypassed_uop_bypass_sel_rs3_enc_2[2] ? _freelist_io_alloc_pregs_0_bits : 7'h0)
        | (bypassed_uop_bypass_sel_rs3_enc_2[1] ? _freelist_io_alloc_pregs_1_bits : 7'h0)
        | (bypassed_uop_bypass_sel_rs3_enc_2[0] ? _freelist_io_alloc_pregs_2_bits : 7'h0)
      : r_uop_3_prs3;	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :172:18, :186:49, :193:{26,52}, :217:24
  assign io_ren2_uops_3_prs1_busy =
    r_uop_3_lrs1_rtype == 2'h1 & _busytable_io_busy_resps_3_prs1_busy
    | bypassed_uop_do_bypass_rs1_1;	// rename-stage.scala:119:23, :184:49, :196:45, :221:25, :237:78, :320:{37,47}
  assign io_ren2_uops_3_prs2_busy =
    r_uop_3_lrs2_rtype == 2'h1 & _busytable_io_busy_resps_3_prs2_busy
    | bypassed_uop_do_bypass_rs2_1;	// rename-stage.scala:119:23, :185:49, :197:45, :221:25, :237:78, :321:{37,47}
  assign io_ren2_uops_3_prs3_busy =
    r_uop_3_frs3_en & _busytable_io_busy_resps_3_prs3_busy | bypassed_uop_do_bypass_rs3_1;	// rename-stage.scala:119:23, :186:49, :198:45, :221:25, :322:34
  assign io_ren2_uops_3_stale_pdst =
    bypassed_uop_bypass_hits_dst_0_2 | bypassed_uop_bypass_hits_dst_1_1
    | bypassed_uop_bypass_hits_dst_2
      ? (bypassed_uop_bypass_sel_dst_enc_2[2] ? _freelist_io_alloc_pregs_0_bits : 7'h0)
        | (bypassed_uop_bypass_sel_dst_enc_2[1] ? _freelist_io_alloc_pregs_1_bits : 7'h0)
        | (bypassed_uop_bypass_sel_dst_enc_2[0] ? _freelist_io_alloc_pregs_2_bits : 7'h0)
      : r_uop_3_stale_pdst;	// Mux.scala:27:72, :47:69, OneHot.scala:83:30, rename-stage.scala:119:23, :172:18, :177:77, :187:49, :194:{26,52}, :217:24
endmodule

