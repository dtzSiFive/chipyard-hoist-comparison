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

module RenameBusyTable_2(
  input        clock,
               reset,
  input  [6:0] io_ren_uops_0_pdst,
               io_ren_uops_0_prs1,
               io_ren_uops_0_prs2,
               io_ren_uops_1_pdst,
               io_ren_uops_1_prs1,
               io_ren_uops_1_prs2,
               io_ren_uops_2_pdst,
               io_ren_uops_2_prs1,
               io_ren_uops_2_prs2,
  input        io_rebusy_reqs_0,
               io_rebusy_reqs_1,
               io_rebusy_reqs_2,
  input  [6:0] io_wb_pdsts_0,
               io_wb_pdsts_1,
               io_wb_pdsts_2,
               io_wb_pdsts_3,
               io_wb_pdsts_4,
               io_wb_pdsts_5,
               io_wb_pdsts_6,
  input        io_wb_valids_0,
               io_wb_valids_1,
               io_wb_valids_2,
               io_wb_valids_3,
               io_wb_valids_4,
               io_wb_valids_5,
               io_wb_valids_6,
  output       io_busy_resps_0_prs1_busy,
               io_busy_resps_0_prs2_busy,
               io_busy_resps_1_prs1_busy,
               io_busy_resps_1_prs2_busy,
               io_busy_resps_2_prs1_busy,
               io_busy_resps_2_prs2_busy
);

  reg  [99:0] busy_table;	// rename-busytable.scala:48:27
  wire [99:0] _io_busy_resps_0_prs1_busy_T = busy_table >> io_ren_uops_0_prs1;	// rename-busytable.scala:48:27, :67:45
  wire [99:0] _io_busy_resps_0_prs2_busy_T = busy_table >> io_ren_uops_0_prs2;	// rename-busytable.scala:48:27, :68:45
  wire [99:0] _io_busy_resps_1_prs1_busy_T = busy_table >> io_ren_uops_1_prs1;	// rename-busytable.scala:48:27, :67:45
  wire [99:0] _io_busy_resps_1_prs2_busy_T = busy_table >> io_ren_uops_1_prs2;	// rename-busytable.scala:48:27, :68:45
  wire [99:0] _io_busy_resps_2_prs1_busy_T = busy_table >> io_ren_uops_2_prs1;	// rename-busytable.scala:48:27, :67:45
  wire [99:0] _io_busy_resps_2_prs2_busy_T = busy_table >> io_ren_uops_2_prs2;	// rename-busytable.scala:48:27, :68:45
  always @(posedge clock) begin
    if (reset)
      busy_table <= 100'h0;	// rename-busytable.scala:48:27
    else begin
      automatic logic [127:0] _busy_table_next_T_8 = 128'h1 << io_ren_uops_2_pdst;	// OneHot.scala:58:35
      automatic logic [127:0] _busy_table_next_T_4 = 128'h1 << io_ren_uops_1_pdst;	// OneHot.scala:58:35
      automatic logic [127:0] _busy_table_next_T = 128'h1 << io_ren_uops_0_pdst;	// OneHot.scala:58:35
      automatic logic [127:0] _busy_table_wb_T_24 = 128'h1 << io_wb_pdsts_6;	// OneHot.scala:58:35
      automatic logic [127:0] _busy_table_wb_T_20 = 128'h1 << io_wb_pdsts_5;	// OneHot.scala:58:35
      automatic logic [127:0] _busy_table_wb_T_16 = 128'h1 << io_wb_pdsts_4;	// OneHot.scala:58:35
      automatic logic [127:0] _busy_table_wb_T_12 = 128'h1 << io_wb_pdsts_3;	// OneHot.scala:58:35
      automatic logic [127:0] _busy_table_wb_T_8 = 128'h1 << io_wb_pdsts_2;	// OneHot.scala:58:35
      automatic logic [127:0] _busy_table_wb_T_4 = 128'h1 << io_wb_pdsts_1;	// OneHot.scala:58:35
      automatic logic [127:0] _busy_table_wb_T = 128'h1 << io_wb_pdsts_0;	// OneHot.scala:58:35
      busy_table <=
        ~(_busy_table_wb_T[99:0] & {100{io_wb_valids_0}} | _busy_table_wb_T_4[99:0]
          & {100{io_wb_valids_1}} | _busy_table_wb_T_8[99:0] & {100{io_wb_valids_2}}
          | _busy_table_wb_T_12[99:0] & {100{io_wb_valids_3}} | _busy_table_wb_T_16[99:0]
          & {100{io_wb_valids_4}} | _busy_table_wb_T_20[99:0] & {100{io_wb_valids_5}}
          | _busy_table_wb_T_24[99:0] & {100{io_wb_valids_6}}) & busy_table
        | _busy_table_next_T[99:0] & {100{io_rebusy_reqs_0}} | _busy_table_next_T_4[99:0]
        & {100{io_rebusy_reqs_1}} | _busy_table_next_T_8[99:0] & {100{io_rebusy_reqs_2}};	// Bitwise.scala:72:12, OneHot.scala:58:35, rename-busytable.scala:48:27, :50:{34,36}, :51:{48,88}, :53:39, :54:49
    end
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin
      automatic logic [31:0] _RANDOM[0:3];
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [2:0] i = 3'h0; i < 3'h4; i += 3'h1) begin
          _RANDOM[i[1:0]] = `RANDOM;
        end
        busy_table = {_RANDOM[2'h0], _RANDOM[2'h1], _RANDOM[2'h2], _RANDOM[2'h3][3:0]};	// rename-busytable.scala:48:27
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_busy_resps_0_prs1_busy = _io_busy_resps_0_prs1_busy_T[0];	// rename-busytable.scala:67:45
  assign io_busy_resps_0_prs2_busy = _io_busy_resps_0_prs2_busy_T[0];	// rename-busytable.scala:68:45
  assign io_busy_resps_1_prs1_busy = _io_busy_resps_1_prs1_busy_T[0];	// rename-busytable.scala:67:45
  assign io_busy_resps_1_prs2_busy = _io_busy_resps_1_prs2_busy_T[0];	// rename-busytable.scala:68:45
  assign io_busy_resps_2_prs1_busy = _io_busy_resps_2_prs1_busy_T[0];	// rename-busytable.scala:67:45
  assign io_busy_resps_2_prs2_busy = _io_busy_resps_2_prs2_busy_T[0];	// rename-busytable.scala:68:45
endmodule

